require "rails_helper"

describe "signed in user", :type => :feature do
  fixtures :users

  describe "anyway" do
    before do
      sign_in_as :tom
    end

    it "should not be able to access sign in page" do
      visit '/user/events'
      visit '/users/sign_in'

      expect(page.current_path).to eq("/user/events")
      expect(page).to have_content I18n.t("devise.failure.already_authenticated")
    end

    it "should not be able to access sign up page" do
      visit '/user/events'
      visit '/users/new'

      expect(page.current_path).to eq("/user/events")
      expect(page).to have_content I18n.t("devise.failure.already_authenticated")
    end
  end

  describe "who is not admin" do
    before do
      sign_in_as :tom
    end

    it "should not be able to know about an amdin dashboard" do
      expect{
        visit "/admin"
      }.to raise_error ActionController::RoutingError
    end

    it "should not be able to know about an queues monitor" do
      expect{
        visit "/admin/jobs"
      }.to raise_error ActionController::RoutingError
    end
  end
end
