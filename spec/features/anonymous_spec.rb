require "rails_helper"

describe "anonymous user", :type => :feature, :js => true do
  it "is able to visit sign in page" do
    visit '/users/sign_in'
    within('h2') do
      expect(page).to have_content I18n.t("devise.sessions.new.page_header")
    end
  end

  it "is able to visit sign up page" do
    visit '/users/new'
    within('h2') do
      expect(page).to have_content I18n.t("devise.registrations.new.page_header")
    end
  end
end
