module ArchitectureJS
  class Watcher

    attr_accessor :project, :listener

    def initialize(project)
      @project = project
      @listener = Listen.to(@project.root) do |modified, added, removed|
        update_files(modified, "modified") if modified.length > 0
        update_files(added, "added") if added.length > 0
        update_files(removed, "deleted") if removed.length > 0
      end
      @listener.ignore(/#{@project.config[:build_dir]}/)
    end

    def watch(message = false)
      @listener.start
      puts ArchitectureJS::Notification.log message if message
      self
    end

    def stop
      @listener.stop
    end

    private

      def update_files(files, action)
        files.each do |f|
          next unless f.match(/\.jst?$|\.blueprint$/)
          f = File.basename f
          if action == "deleted"
            FileUtils.rm_rf("#{@project.root}/#{@project.config[:build_dir]}/#{f}") if File.exists? "#{@project.root}/#{@project.config[:build_dir]}/#{f}"
          end

          puts "\n" << ArchitectureJS::Notification.event("#{f} was #{action}")
        end

        @project.read_config
        @project.update
        print ArchitectureJS::Notification.prompt
      end

  end
end
