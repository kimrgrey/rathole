require "rails_helper"

describe "registered and confirmed user", :type => :feature, :js => true do
  fixtures :users

  it "should be able to sign in" do
    visit '/users/sign_in'

    fill_in I18n.t("activerecord.attributes.user.email"), :with => "tom@example.com"
    fill_in I18n.t("activerecord.attributes.user.password"), :with => "password"
    click_button I18n.t("devise.sessions.new.submit")

    expect(page.current_path).to eq("/user/events")
  end
end
