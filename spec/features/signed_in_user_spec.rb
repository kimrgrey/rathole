require "rails_helper"

describe "signed in user", :type => :feature, :js => true do
  fixtures :users

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
