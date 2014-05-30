class UserNameValidator < ActiveModel::EachValidator
  def validate_each(user, attribute, value)
    denied_names = [
      'posts', 'pictures', 'tag', 'public', 'admin', 'jobs', 'letters',
      'bugs', 'comments', 'overview'
    ]
    if denied_names.include?(value)
      user.errors.add(attribute, I18n.t("activerecord.errors.models.user.attributes.user_name.system"))
    end
  end
end