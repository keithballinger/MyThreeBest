namespace :test do
  namespace :users do
    desc "Create N tests users, if N isn't provided create 5 by default"
    task :create => :environment do
      test_users = Koala::Facebook::TestUsers.new(:app_id => FacebookConfig['app_id'], :secret => FacebookConfig['app_secret'])
      n = ENV['N'] || 5
      n = 10 if n > 10
      users = test_users.create_network(n, true, FacebookConfig['app_scope'])
      puts "Users logins URL: "
      users.each do |user|
        puts "Login URL: #{user['login_url']}"
      end
      puts "Uploading some photos to profile picture album..."
      users.each_with_index do |user, i|
        api = Koala::Facebook::GraphAndRestAPI.new(user['access_token'])
        id = api.get_connections(user["id"], "albums").select{|x| x["name"] == "Profile Pictures"}.first["id"] 
        api.put_picture("#{Rails.root}/public/test_images/profile#{i+1}.jpg", {}, id)
        api.put_picture("#{Rails.root}/public/test_images/friends#{i+1}.jpg", {}, id)
      end
      puts "Photos uploaded!!!"
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
      test_users.delete_all
      puts "Users deleted successfully"
    end

    desc "Delete old users and create new users"
    task :reset => [:delete, :create]
  end
end
