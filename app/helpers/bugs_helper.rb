module BugsHelper
  def bug_state_label(bug)
    css = case bug.state
      when 'open' then 'label label-danger'
      when 'fixed' then 'label label-success'
      when 'rejected' then 'label label-default'
    end
    content_tag :span, I18n.t("bugs.states.#{bug.state}"), class: css
  end

  def bug_id(bug)
    number = bug.id.to_s.rjust(5, '0')
    "##{number}"
  end
end