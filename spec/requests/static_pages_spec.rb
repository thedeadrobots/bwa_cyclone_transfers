require 'spec_helper'

describe "StaticPages" do
  subject { page }  
  describe "Home page" do
    before { visit root_path }
    it { should have_selector('title', text: 'Cyclone Transfers | Home') }
    it { should have_selector('h1', text: 'Welcome to Cyclone.') }
  end
  
  describe "Help page" do
    it "should have the title 'Help'" do
      visit help_path
      page.should have_selector('title', :text => "Cyclone Transfers | Help")
    end
    it "should have the h1 'Help'" do
      visit help_path
      page.should have_selector('h1', :text => 'Help')
    end
  end

  describe "About page" do
    it "should have the title 'About Us'" do 
      visit about_path
      page.should have_selector('title', :text => "Cyclone Transfers | About")
    end
    it "should have the h1 'About'" do
      visit about_path
      page.should have_selector('h1', :text => 'About')
    end
  end
end

