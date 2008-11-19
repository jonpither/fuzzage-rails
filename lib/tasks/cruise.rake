namespace :test do

    task(:start_mongrel) {
        FileUtils.chdir "#{RAILS_ROOT}"
        `mongrel_rails start -P log/test_mongrel.pid -d -p 3000 -e test`
    }

    task(:stop_mongrel) {
        FileUtils.chdir "#{RAILS_ROOT}"
        `mongrel_rails stop -P log/test_mongrel.pid`
    }

    task(:reset_test_database) {
        FileUtils.rm "db/schema.rb"
        STDOUT.puts `rake db:migrate:reset RAILS_ENV=test`
    }
end

task :cruise=> %w[
  test:reset_test_database
  test:units
  test:functionals
  test:integration
  test:stop_mongrel
  test:start_mongrel
  test:acceptance
]