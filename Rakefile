require 'rubygems'
require 'rake'

namespace :knife do
  namespace :solo do
    desc 'Prepare host chef-repo.'
    task :prepare, :host do |task, args|
      system_or_exit %Q[knife solo prepare #{args.host}]
    end

    desc 'Cook host'
    task :cook, :host do |task, args|
      system_or_exit %Q[knife solo cook #{args.host}]
    end

    desc 'Clean host'
    task :clean, :host do |task, args|
      system_or_exit %Q[knife solo clean #{args.host}]
    end
  end

  namespace :cookbook do
    desc 'Create new cookbook.'
    task :create, :name do |task, args|
      system_or_exit %Q[knife cookbook create #{args.name} -o site-cookbooks]
    end

    desc 'Site vendor cookbook'
    task :site, :name do |task, args|
      system_or_exit %Q[knife cookbook site vendor #{args.name}]
    end
  end
end
private

def system_or_exit(cmd, stdout = nil)
  puts "$ #{cmd}"
  cmd += " | tee #{stdout}" if stdout
  system(cmd) or raise "command failed. "
end

