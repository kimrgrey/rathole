module OmniauthHelper
  DEVISE_PROVIDERS_MAPPING = { :vkontakte => :vk }

  def omniauth_provider_name(provider)
    DEVISE_PROVIDERS_MAPPING.fetch(provider, provider).to_s
  end

  def omniauth_logo(provider, options = {})
    defaults = {
      data: { placement: 'bottom' },
      title: t('.connected_to', provider: omniauth_provider_name(provider).camelcase)
    }
    content_tag :span, icon(omniauth_provider_name(provider)), defaults.merge(options)
  end

  def omniauth_link(provider, options = {})
    provider_name = omniauth_provider_name(provider)
    defaults = {
      data: { placement: 'bottom' },
      title: t('.sign_in_via', provider: provider_name.camelcase)
    }
    link_to icon(provider_name), user_omniauth_authorize_path(provider), defaults.merge(options)
  end
end