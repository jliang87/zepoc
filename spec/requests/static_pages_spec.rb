require 'spec_helper'

describe "Static pages" do
  
    describe "Home page" do
      subject{page}
      before {visit root_path}
        it {should have_selector 'h1', :text => 'Sample App' }
        it {should have_selector 'title', :text => full_title('Home') }
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
    
end

