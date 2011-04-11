require "spec_helper"

describe InviteMailer do
  it "should send a invitation email" do
    inviter = Factory.create(:registered_user)
    invited = Factory.create(:registered_user)
    invite = {:email => "user@facebook.com", :subject => "Vote My Three Best Photos!!",
      :message => "Hi #{invited.first_name}: mythreebest.com/vote/#{inviter.id}"}
    email = InviteMailer.invite_email(inviter.id, invited.id, invite[:message], invite[:email], invite[:subject]).deliver

    ActionMailer::Base.deliveries.should_not be_empty
    email.to.should == ["user@facebook.com"]
    email.subject.should == "Vote My Three Best Photos!!"
    email.encoded.should match(/#{invited.first_name}/)
    email.encoded.should match(/\/vote\/#{inviter.id}/)
  end
end
