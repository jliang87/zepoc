# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

require 'spec_helper'

describe User do
  before { @user = User.new(name: "ExampleUser", email: "user@example.com", password: "foobar", password_confirmation: "foobar") }

    subject { @user }

    it { should respond_to(:name) }
    it { should respond_to(:email) }
    it {should respond_to(:password_digest)}
    it {should respond_to(:password)}
    it {should respond_to(:password_confirmation)}
    it {should respond_to(:authenticate)}
    it {should be_valid}
    it { should respond_to :remember_token }
    
    describe "when name is not present" do
      before{@user.name= " "}
      it {should_not be_valid}
    end
    
    describe "when email is not present" do
      before{@user.email=" "}
      it {should_not be_valid}
    end
    
    describe "when name is too long" do
      before{@user.name="a"*51}
      it {should_not be_valid}
    end
    
    describe "when email format is invalid" do
      invalid_addresses = %w[users@foo,com user_at_foo.org xample.user@foo.]
      invalid_addresses.each do |invalid_address|
        before{@user.email=invalid_address}
        it{should_not be_valid}
      end
    end
    
    describe "when email format is valid" do
      valid_addresses = %w[333-33@foo.com A_USER@f.b.org frst.lst@foo.jp ads+db@baz.cn]
      valid_addresses.each do |valid_address|
        before{@user.email=valid_address}
        it{should be_valid}
      end
    end
    
    describe "when email address is already taken" do
      before do
        user_with_same_email = @user.dup
        user_with_same_email.save
      end
      it {should_not be_valid}
    end
    
    describe "when email address is already taken" do
      before do
        user_with_same_email = @user.dup
        user_with_same_email.email = @user.email.upcase
        user_with_same_email.save
      end
      it {should_not be_valid}
    end

     describe "when name is already taken" do
       before do
         user_with_same_name = @user.dup
         user_with_same_name.name = @user.name.upcase
         user_with_same_name.save
       end
       it {should_not be_valid}
     end
    
    describe "when password is not present" do
      before {@user.password = @user.password_confirmation = ""}
      it {should_not be_valid}
    end 
    
    describe "when password doesn't match confirmation" do
      before {@user.password_confirmation = "mismatch"}
      it {should_not be_valid}
    end
    
    describe "return value of authenticate method" do
      before {@user.save}
      let(:found_user) {User.find_by_email(@user.email)}
      
      describe "with valid password" do
        it {should == found_user.authenticate(@user.password)}
      end
      
      describe "with invalid password" do
        let(:user_for_invalid_password) {found_user.authenticate("invalid")}
        it {should_not == user_for_invalid_password}
        specify {user_for_invalid_password.should be_false}
      end 
    end
    
    describe "with a password that's too short" do
      before {@user.password = @user.password_confirmation = "a" * 5}
      it {should be_invalid}
    end
    
    describe "rememeber token" do
      before { @user.save }
      its(:remember_token) {should_not be_blank} #it { @user.remember_token.should_not be_blank }
    end
    
end
