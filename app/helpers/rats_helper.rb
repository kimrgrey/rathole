module RatsHelper
  RATS = [:rap, :chump, :keys, :painter, :pen]

  def rat(name)
    content_tag(:span, '', class: "rat #{name.to_s}") if RATS.include?(name)
  end

  def random_rat(variants = nil)
    variants ||= RATS
    rat(variants.sample)
  end

  def clip_and_clamp
    random_rat([:rap]) + random_rat([:chump, :pen])
  end

  def keys
    rat(:keys)
  end

  def painter
    rat(:painter)
  end
end