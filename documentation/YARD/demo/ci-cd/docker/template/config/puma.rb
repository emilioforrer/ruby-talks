application_path = File.expand_path("../..", __FILE__)

threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }
threads threads_count, threads_count

environment ENV.fetch("RAILS_ENV") { "development" }

# daemonize true

pidfile "#{application_path}/tmp/pids/puma.pid"

state_path "#{application_path}/tmp/pids/puma.state"

stdout_redirect "#{application_path}/log/puma.stdout.log", "#{application_path}/log/puma.stderr.log"

bind "unix://#{application_path}/tmp/sockets/puma.sock"

plugin :tmp_restart