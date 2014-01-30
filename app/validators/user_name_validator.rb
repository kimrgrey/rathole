class UserNameValidator < ActiveModel::EachValidator
  def validate_each(user, attribute, value)
    if ['posts', 'pictures', 'tag'].include?(value)
      user.errors.add(attribute, I18n.t("activerecord.errors.models.user.attributes.user_name.system"))
    end
  end
end