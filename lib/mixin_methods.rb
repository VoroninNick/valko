module MixinMethods

  def to_slug(str)
    str.parameterize
  end
  def save_slug(str, slug)
    self.slug = to_slug(str) if self.slug.blank?
  end
end

ActiveRecord::Base.send(:include, MixinMethods)
