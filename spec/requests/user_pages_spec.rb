require 'spec_helper'

describe "User pages" do
  subject{ page }
  
  describe "signup page" do
    before { visit signup_path }
    it { should have_selector('h1', text: 'Sign up') }
    it { should have_selector('title', text: 'Sign up') }
  end
  
  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    let(:name) {user.name}
    before { visit user_path(user) }
    it { should have_selector('h1',    text: name) }
    it { should have_selector('title', text: name) }
  end  
  
  describe "signup" do
    before { visit signup_path }
    
    describe 'with invalid info' do
      
      it 'should not create a user' do
        expect {click_button 'Create my account'}.not_to change(User, :count)
      end
      
      describe "error messages" do
        before { click_button "Create my account" }
        
        it { should have_selector('title', text: 'Sign up') }
        # it { should have_content('error') } //no more because better design
      end
    end
    
    describe 'with valid info' do
      before do
        fill_in "user_username_textfield", with: "ExampleUser"
        fill_in "user_email_textfield", with: "user@example.com"
        fill_in "user_password_textfield", with: "foobar"
        fill_in "user_passwordconfirm_textfield", with: "foobar"
      end
      
      it "should create a user" do
        expect {click_button 'Create my account'}.to change(User, :count).by(1)
      end
      
      describe "after saving the user" do
        before { click_button "Create my account" }
        let(:user) { User.find_by_email('user@example.com')}
        it { should have_selector('title', text:user.name) }
        it { should have_selector('div.alert.alert-success', text: 'Welcome') }
        it { should have_link 'Sign out' }
      end
    end
  end

  describe "edit" do
    let(:user) { FactoryGirl.create(:user)}
    before { visit edit_user_path(user) }
    
    describe "page" do
      it { should have_selector('h1', text: "Update your profile")}
      it { should have_selector('title', text: "Edit user")}
      it { should have_link 'change', href: 'http://gravatar.com/emails'}
    end

    #describe "with invalid information" do
     # before { click_button "Save changes" }
      
      #it { should have_content('error')}    
end
