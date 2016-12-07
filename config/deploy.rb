lock '3.6.1'

set :application, 'sistema_hotel'
set :repo_url, 'git@github.com:GTi-Jr/sistema-hotel-fluxo.git'
set :branch, :master
set :user, 'rails'
set :deploy_to, '/home/rails/sistema_hotel'
set :pty, true
set :linked_files, %w{config/database.yml config/application.yml config/secrets.yml}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/uploads}
set :keep_releases, 5
set :rvm_type, :user
#set :rvm_version, '1.27.0'
set :rvm_ruby, '1.0.0' # Edit this if you are using MRI Ruby

set :puma_rackup, -> { File.join(current_path, 'config.ru') }
set :puma_state, "#{shared_path}/tmp/pids/puma.state"
set :puma_pid, "#{shared_path}/tmp/pids/puma.pid"
set :puma_bind, "unix://#{shared_path}/tmp/sockets/puma.sock"    #accept array for multi-bind
set :puma_conf, "#{shared_path}/puma.rb"
set :puma_access_log, "#{shared_path}/log/puma_error.log"
set :puma_error_log, "#{shared_path}/log/puma_access.log"
set :puma_role, :app
set :puma_env, fetch(:rack_env, fetch(:rails_env, 'production'))
set :puma_threads, [0, 8]
set :puma_workers, 0
set :puma_worker_timeout, nil
set :puma_init_active_record, true
set :puma_preload_app, false

namespace :db do
  desc "Seed the database."
  task :seed do
    on roles(:app) do
      within "#{current_path}" do
        with rails_env: :production do
          execute :rake, "db:seed"
        end
      end
    end
  end

  desc "Seed the database."
  task :setup do
    on roles(:app) do
      within "#{current_path}" do
        with rails_env: :production do
          execute :rake, "db:drop db:create db:migrate db:seed"
        end
      end
    end
  end


end
# namespace :rake do
#   namespace :db do
#     %w[create migrate reset rollback seed setup].each do |command|
#       desc "Rake db:#{command}"
#       task command, roles: :app, except: {no_release: true} do
#         run "cd #{deploy_to}/current"
#         run "bundle exec rake db:#{ENV['task']} RAILS_ENV=#{rails_env}"
#       end
#     end
#   end
#   namespace :assets do
#     %w[precompile clean].each do |command|
#       desc "Rake assets:#{command}"
#       task command, roles: :app, except: {no_release: true} do
#         run "cd #{deploy_to}/current"
#         run "bundle exec rake assets:#{ENV['task']} RAILS_ENV=#{rails_env}"
#       end
#     end
#   end
# end