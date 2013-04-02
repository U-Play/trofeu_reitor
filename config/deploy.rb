require "rvm/capistrano"
require "bundler/capistrano"

ssh_options[:forward_agent] = true
set :scm, 'git'
set :scm_user, "deploy"
set :repository,  "git@github.com:U-Play/trofeu_reitor.git"
set :branch, 'develop'
# set :ssh_options, { :forward_agent => true }
set :deploy_via, :remote_cache

set :application, "uplaypro.com"
set :deploy_to,"/home/deploy/trofeu_reitor.git"

set :user, 'deploy'
set :use_sudo, false

server 'uplaypro.com', :web, :app, :db, :primary => true

# additional settings
default_run_options[:pty] = true

# if you want to clean up old releases on each deploy uncomment this:
set :keep_releases, 5
after "deploy:restart", "deploy:cleanup"

namespace :deploy do
	task :start do ; end
	task :stop do ; end
	task :restart, :roles => :app, :except => { :no_release => true } do
		run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
	end
end

after 'deploy:update_code', 'deploy:migrate'
