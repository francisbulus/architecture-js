# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "architecture-js"
  s.version = "0.5.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Dayton Nolan"]
  s.date = "2012-05-27"
  s.description = "Architecture.js helps you generate scaffolding, manage third-party packages, compile, and compress your application."
  s.email = "daytonn@gmail.com"
  s.executables = ["architect"]
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.md"
  ]
  s.files = [
    ".DS_Store",
    ".document",
    ".rvmrc",
    ".travis.yml",
    "AUTHORS",
    "Gemfile",
    "Gemfile.lock",
    "HELP",
    "LICENSE.txt",
    "README.md",
    "Rakefile",
    "VERSION",
    "architecture-js.gemspec",
    "bin/architect",
    "docs/docco.css",
    "lib/architecture-js.rb",
    "lib/architecture-js/architect.rb",
    "lib/architecture-js/blueprint.rb",
    "lib/architecture-js/dependencies.rb",
    "lib/architecture-js/generator.rb",
    "lib/architecture-js/helpers.rb",
    "lib/architecture-js/notification.rb",
    "lib/architecture-js/watcher.rb",
    "lib/sprockets/CHANGELOG",
    "lib/sprockets/LICENSE",
    "lib/sprockets/README.markdown",
    "lib/sprockets/lib/sprockets.rb",
    "lib/sprockets/lib/sprockets/concatenation.rb",
    "lib/sprockets/lib/sprockets/environment.rb",
    "lib/sprockets/lib/sprockets/error.rb",
    "lib/sprockets/lib/sprockets/pathname.rb",
    "lib/sprockets/lib/sprockets/preprocessor.rb",
    "lib/sprockets/lib/sprockets/secretary.rb",
    "lib/sprockets/lib/sprockets/source_file.rb",
    "lib/sprockets/lib/sprockets/source_line.rb",
    "lib/sprockets/lib/sprockets/version.rb",
    "lib/sprockets/test/fixtures/assets/images/script_with_assets/one.png",
    "lib/sprockets/test/fixtures/assets/images/script_with_assets/two.png",
    "lib/sprockets/test/fixtures/assets/stylesheets/script_with_assets.css",
    "lib/sprockets/test/fixtures/constants.yml",
    "lib/sprockets/test/fixtures/double_slash_comments_that_are_not_requires_should_be_ignored_when_strip_comments_is_false.js",
    "lib/sprockets/test/fixtures/double_slash_comments_that_are_not_requires_should_be_removed_by_default.js",
    "lib/sprockets/test/fixtures/multiline_comments_should_be_removed_by_default.js",
    "lib/sprockets/test/fixtures/requiring_a_file_after_it_has_already_been_required_should_do_nothing.js",
    "lib/sprockets/test/fixtures/requiring_a_file_that_does_not_exist_should_raise_an_error.js",
    "lib/sprockets/test/fixtures/requiring_a_single_file_should_replace_the_require_comment_with_the_file_contents.js",
    "lib/sprockets/test/fixtures/requiring_the_current_file_should_do_nothing.js",
    "lib/sprockets/test/fixtures/src/constants.yml",
    "lib/sprockets/test/fixtures/src/foo.js",
    "lib/sprockets/test/fixtures/src/foo/bar.js",
    "lib/sprockets/test/fixtures/src/foo/foo.js",
    "lib/sprockets/test/fixtures/src/script_with_assets.js",
    "lib/sprockets/test/fixtures/src/script_with_comments.js",
    "lib/sprockets/test/test_concatenation.rb",
    "lib/sprockets/test/test_environment.rb",
    "lib/sprockets/test/test_helper.rb",
    "lib/sprockets/test/test_pathname.rb",
    "lib/sprockets/test/test_preprocessor.rb",
    "lib/sprockets/test/test_secretary.rb",
    "lib/sprockets/test/test_source_file.rb",
    "lib/sprockets/test/test_source_line.rb",
    "repository/modjs/plugins/jquery-elements.js",
    "spec/.DS_Store",
    "spec/architect_spec.rb",
    "spec/architecture-js_spec.rb",
    "spec/blueprint_spec.rb",
    "spec/fixtures/.DS_Store",
    "spec/fixtures/_hidden.js",
    "spec/fixtures/compiled_src.js",
    "spec/fixtures/compressed.blueprint",
    "spec/fixtures/compressed.js",
    "spec/fixtures/ejs.ejs",
    "spec/fixtures/env-test.js",
    "spec/fixtures/existing.blueprint",
    "spec/fixtures/lib1.js",
    "spec/fixtures/lib1_compressed.js",
    "spec/fixtures/lib2.js",
    "spec/fixtures/lib2_compressed.js",
    "spec/fixtures/myapp.blueprint",
    "spec/fixtures/src_file.js",
    "spec/fixtures/templates/env_template.js",
    "spec/fixtures/templates/test_template_one.js",
    "spec/fixtures/templates/test_template_two.js",
    "spec/fixtures/test_blueprint.rb",
    "spec/fixtures/test_template_options.js",
    "spec/fixtures/test_template_two.js",
    "spec/fixtures/underscore_template.js",
    "spec/fixtures/update.blueprint",
    "spec/fixtures/update.js",
    "spec/generator_spec.rb",
    "spec/helpers_spec.rb",
    "spec/notification_spec.rb",
    "spec/spec_helper.rb",
    "templates/blank.js"
  ]
  s.homepage = "https://github.com/daytonn/architecture-js"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.21"
  s.summary = "architecture.js is a command line application to dynamically build and manage complex javascript applications."

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<listen>, [">= 0"])
      s.add_runtime_dependency(%q<jsmin>, ["~> 1.0.1"])
      s.add_development_dependency(%q<rspec>, ["~> 2.8.0"])
      s.add_development_dependency(%q<bundler>, [">= 0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.8.3"])
      s.add_runtime_dependency(%q<jsmin>, [">= 0"])
      s.add_runtime_dependency(%q<listen>, [">= 0"])
    else
      s.add_dependency(%q<listen>, [">= 0"])
      s.add_dependency(%q<jsmin>, ["~> 1.0.1"])
      s.add_dependency(%q<rspec>, ["~> 2.8.0"])
      s.add_dependency(%q<bundler>, [">= 0"])
      s.add_dependency(%q<jeweler>, ["~> 1.8.3"])
      s.add_dependency(%q<jsmin>, [">= 0"])
      s.add_dependency(%q<listen>, [">= 0"])
    end
  else
    s.add_dependency(%q<listen>, [">= 0"])
    s.add_dependency(%q<jsmin>, ["~> 1.0.1"])
    s.add_dependency(%q<rspec>, ["~> 2.8.0"])
    s.add_dependency(%q<bundler>, [">= 0"])
    s.add_dependency(%q<jeweler>, ["~> 1.8.3"])
    s.add_dependency(%q<jsmin>, [">= 0"])
    s.add_dependency(%q<listen>, [">= 0"])
  end
end

