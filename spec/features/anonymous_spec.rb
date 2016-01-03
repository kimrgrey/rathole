require "rails_helper"

describe "anonymous", :type => :feature, :js => true do
  fixtures :users

  it "should be able to visit sign in page" do
    visit '/users/sign_in'
    within('h2') do
      expect(page).to have_content I18n.t("devise.sessions.new.page_header")
    end
  end

  it "should be able to visit sign up page" do
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

  it "should be able to visit user's public profile" do
    visit '/tom'
    within('.profile > h2') do
      expect(page).to have_content I18n.t("users.show.page_header")
    end
  end

  it "should be redirected sign in page after attempt to access post's creating page" do
    visit '/user/posts/new'
    expect(page.current_path).to eq("/users/sign_in")
  end
end
