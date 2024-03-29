require 'spec_helper'

describe "AuthenticationPages" do
  subject { page }
  
  describe "signin page" do
    before { visit signin_path }
    
    it { should have_selector 'h1', text: 'Sign in' }
    it { should have_selector 'title', text: 'Sign in'}
  end
  
  describe "signin" do
    before { visit signin_path }
    
    describe "with invalid info" do
      before { click_button "Sign in" }
      
      it { should have_selector 'title', text: 'Sign in' }
      it { should have_selector 'div.alert.alert-error', text: 'Invalid' }
    end
    
    describe "after visiting another page" do
      before {click_link "Home"}    
      
      it {should_not have_selector 'div.alert.alert-error'}
    end
    
    describe  "with valid info" do
      let(:user) {FactoryGirl.create(:user)}
      let(:name) {user.name}
      before do
        fill_in "email", with: user.email
        fill_in "password", with: user.password
        click_button "Sign in"
      end
      
      it { should have_selector 'title', text: user.name }
      it { should have_link 'Profile', href: user_path(user)}
      it { should have_link 'Sign out', href: signout_path }
      it { should_not have_link 'Sign in', href: signin_path }
      
      describe "followed by signout" do
          before { click_link 'Sign out' }
          it { should have_link 'Sign in' }
      end
    end
  end
end
