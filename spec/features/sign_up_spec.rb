require "rails_helper"

describe "sign up", :type => :feature, :js => true do
  fixtures :users

  it "should redirect to events page after success" do
    visit '/users/new'

    fill_in I18n.t("activerecord.attributes.user.email"), :with => "john@example.com"
    fill_in I18n.t("activerecord.attributes.user.user_name"), :with => "john"
    fill_in I18n.t("activerecord.attributes.user.password"), :with => "password"
    fill_in I18n.t("activerecord.attributes.user.password_confirmation"), :with => "password"
    click_button I18n.t("devise.registrations.new.submit")

    expect(page.current_path).to eq("/user/events")
  end

  it "should show an error when email has been already taken" do
    visit '/users/new'

    fill_in I18n.t("activerecord.attributes.user.email"), :with => "tom@example.com"
    fill_in I18n.t("activerecord.attributes.user.user_name"), :with => "john"
    fill_in I18n.t("activerecord.attributes.user.password"), :with => "password"
    fill_in I18n.t("activerecord.attributes.user.password_confirmation"), :with => "password"
    click_button I18n.t("devise.registrations.new.submit")

    expect(page.current_path).to eq("/users")
    expect(page).to have_content(I18n.t("activerecord.errors.models.user.attributes.email.taken"))
  end

  it "should show an error when email has been already taken" do
    visit '/users/new'

    fill_in I18n.t("activerecord.attributes.user.email"), :with => "john@example.com"
    fill_in I18n.t("activerecord.attributes.user.user_name"), :with => "tom"
    fill_in I18n.t("activerecord.attributes.user.password"), :with => "password"
    fill_in I18n.t("activerecord.attributes.user.password_confirmation"), :with => "password"
    click_button I18n.t("devise.registrations.new.submit")

    expect(page.current_path).to eq("/users")
    expect(page).to have_content(I18n.t("activerecord.errors.models.user.attributes.user_name.taken"))
  end

  it "should show an error when email was not specified" do
    visit '/users/new'

    fill_in I18n.t("activerecord.attributes.user.user_name"), :with => "john"
    fill_in I18n.t("activerecord.attributes.user.password"), :with => "password"
    fill_in I18n.t("activerecord.attributes.user.password_confirmation"), :with => "password"
    click_button I18n.t("devise.registrations.new.submit")

    expect(page.current_path).to eq("/users")
    expect(page).to have_content(I18n.t("activerecord.errors.models.user.attributes.email.blank"))
  end

  it "should show an error when user_name was not specified" do
    visit '/users/new'

    fill_in I18n.t("activerecord.attributes.user.email"), :with => "john@example.com"
    fill_in I18n.t("activerecord.attributes.user.password"), :with => "password"
    fill_in I18n.t("activerecord.attributes.user.password_confirmation"), :with => "password"
    click_button I18n.t("devise.registrations.new.submit")

    expect(page.current_path).to eq("/users")
    expect(page).to have_content(I18n.t("activerecord.errors.models.user.attributes.user_name.invalid"))
  end

  it "should show an error when password was not specified" do
    visit '/users/new'

    fill_in I18n.t("activerecord.attributes.user.email"), :with => "john@example.com"
    fill_in I18n.t("activerecord.attributes.user.user_name"), :with => "john"
    click_button I18n.t("devise.registrations.new.submit")

    expect(page.current_path).to eq("/users")
    expect(page).to have_content(I18n.t("activerecord.errors.models.user.attributes.password.blank"))
  end

  it "should show an error when password is too short" do
    visit '/users/new'

    fill_in I18n.t("activerecord.attributes.user.email"), :with => "john@example.com"
    fill_in I18n.t("activerecord.attributes.user.user_name"), :with => "john"
    fill_in I18n.t("activerecord.attributes.user.password"), :with => "123"
    fill_in I18n.t("activerecord.attributes.user.password_confirmation"), :with => "123"
    click_button I18n.t("devise.registrations.new.submit")

    expect(page.current_path).to eq("/users")
    expect(page).to have_content(I18n.t("activerecord.errors.models.user.attributes.password.too_short"))
  end

  it "should show an error when password confirmation is not equal to password" do
    visit '/users/new'

    fill_in I18n.t("activerecord.attributes.user.email"), :with => "john@example.com"
    fill_in I18n.t("activerecord.attributes.user.user_name"), :with => "john"
    fill_in I18n.t("activerecord.attributes.user.password"), :with => "password"
    fill_in I18n.t("activerecord.attributes.user.password_confirmation"), :with => "wrongpassword"
    click_button I18n.t("devise.registrations.new.submit")

    expect(page.current_path).to eq("/users")
    expect(page).to have_content(I18n.t("activerecord.errors.models.user.attributes.password_confirmation.confirmation"))
  end
end
