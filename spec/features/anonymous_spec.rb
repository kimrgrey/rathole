require "rails_helper"

describe "anonymous", :type => :feature, :js => true do
  it "should able to visit sign in page" do
    visit '/users/sign_in'
    within('h2') do
      expect(page).to have_content I18n.t("devise.sessions.new.page_header")
    end
  end

  it "should able to visit sign up page" do
    visit '/users/new'
    within('h2') do
      expect(page).to have_content I18n.t("devise.registrations.new.page_header")
    end
  end

  it "should be able to visit overview page" do
    visit '/overview'
    within('h2') do
      expect(page).to have_content I18n.t("public.overview.page_header")
    end
  end

  it "should be redirected sign in page after attempt to access private page" do
    visit '/user/imports'
    expect(page.current_path).to eq("/users/sign_in")
  end
end
