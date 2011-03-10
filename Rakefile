require 'bundler'
Bundler::GemHelper.install_tasks

require 'rake/testtask'
Rake::TestTask.new do |t|
  t.test_files = FileList['test/**/*_{test,spec}.rb']
  # t.warning = true
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |t|
    t.test_files = FileList['test/**/*_{test,spec}.rb']
    t.verbose = true
    t.rcov_opts << %w{ --exclude .rvm }
  end
rescue LoadError
  desc 'Analyze code coverage with tests'
  task :rcov do
    puts "Install rcov"
  end
end