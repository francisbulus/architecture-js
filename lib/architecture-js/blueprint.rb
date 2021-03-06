module ArchitectureJS

  class Blueprint
    attr_accessor :root,
                  :src_files,
                  :blueprint,
                  :config_name,
                  :directories,
                  :template_directories,
                  :templates,
                  :config,
                  :raise_errors

    def self.init_with_config(path)
      config_file = Dir.entries(path).select {|f| f =~ /\.blueprint$/ }.first

      raise ".blueprint file was not found in #{path}/" if config_file.nil?

      config = YAML::load_file "#{path}/#{config_file}"
      config = ArchitectureJS::Helpers::symbolize_keys config

      require "#{config[:blueprint]}-architecture" unless config[:blueprint] == 'default'
      project = ArchitectureJS::BLUEPRINTS[config[:blueprint]].new config, path
    end

    def initialize(config, root = nil)
      raise "#{self.class}.new({ name: 'myapp' }, options): config[:name] is undefined" unless config[:name]
      @raise_errors = false
      @config_file = "#{config[:name].downcase}.blueprint"
      root ||= Dir.getwd
      @root = File.expand_path(root)
      @template_directories = ["#{@root}/templates"]
      @directories = ['lib', 'src']
      @config = {
        blueprint: 'default',
        src_dir: 'src',
        build_dir: 'lib',
        asset_root: '../',
        output: 'compressed',
        template_dir: 'templates',
        template_namespace: 'templates'
      }
      @config.merge! config unless config.nil?
      @template_directories = [*@config[:template_dir]].map { |dir| "#{@root}/#{dir}" }
      get_src_files
    end

    def read_config
      config = YAML::load_file("#{@root}/#{@config_file}")
      assign_config_variables config
    end

    def assign_config_variables(config)
      config.each do |key, value|
        @config[key.to_sym] = value
      end
    end

    def create
      puts ArchitectureJS::Notification.notice "Creating the #{@config[:name]} project in #{@root}" 
      create_project_scaffold
      write_config
      create_application_file
    end

    def create_project_scaffold
      Dir.mkdir "#{@root}" unless File.exists? "#{@root}"

      @directories.each do |dir|
        puts ArchitectureJS::Notification.added "#{dir}/ created" unless File.exists? "#{@root}/#{dir}"
        Dir.mkdir "#{@root}/#{dir}" unless File.exists? "#{@root}/#{dir}"
      end
    end

    def write_config
      File.open("#{@root}/#{@config_file}", "w+") do |conf_file|
        @config.each do |key, value|
          conf_file << "#{key}: #{ArchitectureJS::Helpers.array_to_yml value}\n" if value.is_a? Array
          conf_file << "#{key}: #{value}\n" if value.is_a? String
        end
      end

      puts ArchitectureJS::Notification.added "#{@config_file} created"
    end

    def create_application_file
      FileUtils.touch("#{@root}/#{@config[:src_dir]}/#{@config[:name]}.js")
      puts ArchitectureJS::Notification.added "#{@config[:src_dir]}/#{@config[:name]}.js created"
    end

    def update(compress = false)
      read_config
      get_src_files
      get_templates
      create_templates_file unless @templates.empty?
      compile_src_files
      compress_application if compress || @config[:output] == 'compressed'
      puts ArchitectureJS::Notification.log "application updated" unless @errors
      @errors = false
    end

    def get_src_files
      @src_files = []
      [*@config[:src_dir]].each do |directory| 
        add_src_files_to_project File.expand_path(directory, @root)
      end      
    end

    def get_templates
      @templates = {}
      @template_directories.each do |dir|
        find_templates_in_directory dir
      end
    end

    def find_templates_in_directory(dir)
      dir_glob = File.join(dir, "**", "*.jst")
      Dir.glob(dir_glob).each do |f|
        name = get_template_name f, dir
        @templates[name] = EJS.compile(File.read f)
      end
    end

    def get_template_name(file, dir, ext = '.jst')
      File.basename(file.gsub(/#{dir}\/?/, ''), ext)
    end

    def create_templates_file
      templates_string = ''
      app_name = @config[:name]
      template_namespace = @config[:template_namespace]
      formatted_templates = @templates.map do |name, function|
        "\"#{name}\": #{function}"
      end
      template = ERB.new File.read("#{ArchitectureJS::base_directory}/templates/templates_file.erb")
      @compiled_templates_file = template.result binding
      File.open("#{@root}/#{@config[:build_dir]}/templates.js", "w+") do |f|
        f << @compiled_templates_file
      end
    end

    def add_src_files_to_project(directory)
      Dir["#{directory}/*.js"].each do |file|
        src_filename = file.gsub(directory, '')
        @src_files << "#{directory}#{src_filename}" unless src_filename.match(/^\/_/)
      end
    end

    def compile_src_files
      @src_files.each do |file_path|
        file_name = get_file_name file_path
        compile_src_file file_path, file_name
      end
    end

    def get_file_name(module_path)
      module_file = module_path.split(/[\\\/]/).last
      module_filename = module_file.gsub(/\.js$/, '')
    end

    def compile_src_file(file_path, file_name)
      sprockets = Sprockets::Secretary.new(
        root: ArchitectureJS::base_directory,
        asset_root: @config[:asset_root],
        load_path: ['repository'],
        source_files: [file_path],
        interpolate_constants: false
      )

      compiled_file = sprockets.concatenation
      message = File.exists?("#{@root}/#{@config[:build_dir]}/#{file_name}.js") ? "#{@config[:build_dir]}/#{file_name}.js updated" : "#{@config[:build_dir]}/#{file_name}.js created"
      compiled_file.save_to "#{@root}/#{@config[:build_dir]}/#{file_name}.js"
      ArchitectureJS::Notification.log message
      sprockets.install_assets

    rescue Exception => error
      @errors = true
      puts ArchitectureJS::Notification.error "Sprockets error: #{error.message}"
      raise if @raise_errors
    end

    def compress_application
      app_root = File.expand_path "#{@root}/#{@config[:build_dir]}"
      src_files = Dir.entries(app_root).reject! { |file| file =~ /^\./ }

      src_files.each do |file|
        full_path = "#{app_root}/#{file}"
        uncompressed = File.open(full_path, "r").read
        File.open(full_path, "w+") do |file|
          file << JSMin.minify(uncompressed).gsub(/\n?/, '')
        end
      end
    end

    def watch(message)
      watcher = ArchitectureJS::Watcher.new self
      watcher.watch message
    end

  end # class Blueprint
end # module ArchitectureJS

# this line adds the default blueprint to ArchitectureJS
ArchitectureJS::register_blueprint('default', ArchitectureJS::Blueprint)