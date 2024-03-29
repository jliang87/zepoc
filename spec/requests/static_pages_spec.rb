require 'spec_helper'

describe "Static pages" do
  
    describe "Home page" do
      subject{page}
      before {visit root_path}
        it {should have_selector 'h1', :text => 'Welcome!' }
        it {should have_selector 'title', :text => 'zepoc' }
    end
  
    describe "Help page" do
      subject{page}
      before {visit help_path}
        it {should have_selector 'h1', :text => 'Help'}
        it {should have_selector 'title', :text => full_title("Help") }
    end 
  
    describe "About page" do
      subject{page}
      before {visit about_path}
        it {should have_selector 'h1', :text => 'About me'}
        it {should have_selector 'title', :text => full_title('About me')}
    end
  
    describe "Contact page" do
      subject{page}
      before {visit contact_path}
        it {should have_selector 'h1', text: 'Contact'}
        it {should have_selector 'title', text: full_title('Contact')}
    end 
    
    it "should have the correct links" do
      visit root_path
      click_link "About"
      page.should have_selector 'title', text: full_title('About me')
      click_link "Help"
      page.should have_selector 'title', text: full_title('Help')
      click_link "Contact"
      page.should have_selector 'title', text: full_title('Contact')
      click_link "Home"
      page.should have_selector 'title', text: "zepoc"
      click_link "Sign up now!"
      page.should have_selector 'title', text: full_title('Sign up')
    end 
      
      
    
end

