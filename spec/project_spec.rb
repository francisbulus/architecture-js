require "spec_helper.rb"

describe ArchitectureJS::Project do

  it "should exist" do
    ArchitectureJS::Project.should_not be_nil
  end

  context 'Instantiation' do
    before :each do
      FileUtils.mkdir TMP_DIR
      suppress_output do
        @project = ArchitectureJS::Project.new({ name: 'myapp' }, TMP_DIR)
      end
    end

    it "should add the 'none' framework to ArchitectureJS" do
      ArchitectureJS::FRAMEWORKS['none'].should == ArchitectureJS::Project
    end

    after :each do
      FileUtils.rm_rf "#{TMP_DIR}" if File.exists? "#{TMP_DIR}"
    end

    it 'should have an empty src_files array' do
      @project.src_files.should == Array.new
    end

    it 'should have a read_config method' do
      @project.respond_to?("read_config").should be_true
    end

    it 'should have a write_config method' do
      @project.respond_to?("write_config").should be_true
    end

    it "should have directories" do
      @project.directories.should == ['lib', 'src']
    end

    it "should have template_directories" do
      @project.template_directories.should == ["#{ArchitectureJS::BASE_DIR}/templates", "#{TMP_DIR}/templates"]
    end

    it "should have a watch_directories array" do
      @project.watch_directories.should == ['src']
    end

    it "should have a generator" do
      @project.generator.should_not be_nil
    end
  end # Instantiation

  context "Project Creation" do
   before :each do
     FileUtils.mkdir("#{TMP_DIR}")
     suppress_output do
       @project = ArchitectureJS::Project.new({ name: 'myapp' }, TMP_DIR)
       @project.create
     end
   end

   after :each do
     FileUtils.rm_rf "#{TMP_DIR}" if File.exists? "#{TMP_DIR}"
   end

   it 'should create a project directory structure' do
     File.directory?("#{TMP_DIR}/lib").should be_true
     File.directory?("#{TMP_DIR}/src").should be_true
   end

   it 'should create a config file' do
     File.exists?("#{TMP_DIR}/myapp.architecture").should be_true
     "#{TMP_DIR}/myapp.architecture".should be_same_file_as "#{FIXTURES}/myapp.architecture"
   end

   it "should create an application source file" do     
     File.exists?("#{TMP_DIR}/src/myapp.js").should be_true
   end
  end # Project Creation

  context "Project Update" do
    before :each do
      FileUtils.mkdir("#{TMP_DIR}")
      suppress_output do
        @project = ArchitectureJS::Project.new({ name: 'myapp' },TMP_DIR)
        @project.create
        FileUtils.cp "#{FIXTURES}/lib1.js", "#{TMP_DIR}/lib/lib1.js"
        FileUtils.cp "#{FIXTURES}/lib2.js", "#{TMP_DIR}/lib/lib2.js"
        FileUtils.cp "#{FIXTURES}/src_file.js", "#{TMP_DIR}/src/myapp.js"
        @project.update
      end
    end

    after :each do
      FileUtils.rm_rf "#{TMP_DIR}" if File.exists? "#{TMP_DIR}"
    end

    it 'should compile the source files into the destination folder' do
      File.exists?("#{TMP_DIR}/lib/myapp.js").should be_true
      "#{TMP_DIR}/lib/myapp.js".should be_same_file_as "#{FIXTURES}/compiled_src.js"
    end

  end # Project Update

end