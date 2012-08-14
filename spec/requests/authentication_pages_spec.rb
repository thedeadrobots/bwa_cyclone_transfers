require 'spec_helper'

describe "Authentication" do
  
  
  describe "signin page" do
    before { visit signin_path }

    describe "with valid information" do 
      let(:user) { FactoryGirl.create(:user) }
      before do
	fill_in "Email", with: user.email
	fill_in "Password", with: user.password
	click_button "Sign in"
      end
      
      it { should have_selector('title', text: user.name) }
      it { should have_link('Profile', href: user_path(user)) }
      it { should have_link('Sign out', href: signout_path) }
      it { should_not have_link('Sign in', href: signin_path) }
    end 
    describe "with invalid information" do
      before { click_button "Sign in" }

      it { should have_selector('title', text: 'Sign in') }
      it { should have_selector('div.alert.alert-error', text: 'Invalid') }
    end

  end
end
