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
  before { @user = User.new(name: "Example User", email: "user@example.com") }

    subject { @user }

    it { should respond_to(:name) }
    it { should respond_to(:email) }
    it {should be_valid}
    
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
    
    describe "when email format is fuckvalid" do
      invalid_addresses = %w[users@foo.com user_at_foo.org xample.user@foo.]
      invalid_addresses.each do |invalid_address|
        before{@user.email=invalid_address}
        it{should_not be_valid}
      end
    end
end
