namespace :test do
  namespace :users do
    desc "Create N tests users, if N isn't provided create 5 by default"
    task :create => :environment do
      test_users = Koala::Facebook::TestUsers.new(:app_id => FacebookConfig['app_id'], :secret => FacebookConfig['app_secret'])
      users = test_users.create_network(ENV['N'] || 5, true, FacebookConfig['app_scope'])
      puts "Users logins URL: "
      users.each do |user|
        puts "Login URL: #{user['login_url']}"
      end
    end

    desc "List all created test users"
    task :list => :environment do
      test_users = Koala::Facebook::TestUsers.new(:app_id => FacebookConfig['app_id'], :secret => FacebookConfig['app_secret'])
      users = test_users.list
      puts "Users logins URL: "
      users.each do |user|
        puts "Login URL: #{user['login_url']}"
      end
    end

    desc "Delete all created test users"
    task :delete => :environment do
      test_users = Koala::Facebook::TestUsers.new(:app_id => FacebookConfig['app_id'], :secret => FacebookConfig['app_secret'])
      users = test_users.list
      test_user.delete_all
      puts "Users deleted successfully"
    end
  end
end
