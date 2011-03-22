require "spec_helper"

describe InviteMailer do
  it "should send a invitation email" do
    inviter = Factory.create(:registered_user)
    invited = Factory.create(:registered_user)
    email = InviteMailer.invite_email(inviter, invited, "user@facebook.com").deliver

    ActionMailer::Base.deliveries.should_not be_empty
    email.to.should == ["user@facebook.com"]
    email.subject.should == "Vote My Three Best Photos!!"
    email.encoded.should match(/#{invited.first_name}/)
    email.encoded.should match(/\/vote\/#{inviter.id}/)
  end
end
