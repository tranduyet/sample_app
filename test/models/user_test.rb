require 'test_helper'

class UserTest < ActiveSupport::TestCase

  	def setup
    	@user = User.new(name: "Duyet", email: "abcd@gmail.com")
  	end

 	test "should be valid" do
    	assert @user.valid?
  	end

  	test "name should be present" do
    	@user.name = ""
    	assert_not @user.valid?
  	end

  	test "email should be present" do
    	@user.email = "     "
    	assert_not @user.valid?
  	end
  	test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A__US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      	@user.email = valid_address
      	assert @user.valid?, "#{valid_address.inspect} should be valid"
    	end
    end
    test "email addresses should be unique" do
    	dupdicate_user = @user.dup
    	dupdicate_user.email = @user.email.upcase
    	@user.save
    	assert_not dupdicate_user.valid?
	end
	test "email addresses should be saved as lower-case" do
    	mixed_case_email = "DuyEt@GmaiL.CoM"
    	@user.email = mixed_case_email
    	@user.save
    	assert_equal mixed_case_email.downcase, @user.reload.email
  end
end
