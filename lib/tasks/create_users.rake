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
      puts "Uploading and tagging some photos..."
      users.each_with_index do |user, i|
        api = Koala::Facebook::GraphAndRestAPI.new(user['access_token'])
        photo = api.put_picture("#{Rails.root}/public/test_images/profile#{i+1}.jpg")
        api.rest_call("photos.addTag", {"pid" => photo['id'], "tag_uid" => user['id'], "x" => 50, "y" => 50})
        photo = api.put_picture("#{Rails.root}/public/test_images/friends#{i+1}.jpg")
        tags = ((0..n)).to_a.-([i]).shuffle[0..5].map do |j| 
          { 'tag_uid' => users[j]['id'], 'x' => rand(100), 'y' => rand(100)}
        end
        api.rest_call("photos.addTag", {"pid" => photo['id'], "tags" => tags})
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
