class Testimonial < ActiveRecord::Base


  has_attached_file :avatar, styles: { medium: "320x320>", thumb: "150x150>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/


  #
  # def course_type
  #   "#{I18n.t("activerecord.attributes.course.group") if self.group} #{"/" if self.group && self.individual}  #{I18n.t("activerecord.attributes.course.individual") if self.individual}"
  # end

  scope :published, ->() {
    where(published: true).sort_by_date_published
  }
  scope :post_on_index, ->() {
    where(on_index_page: true).sort_by_date_published
  }
  scope :main_testimonial, ->() {
    where(main: true)
  }
  scope :list_testimonial, ->() {
    published.where.not(main: true).sort_by_date_published
  }
  scope :sort_by_date_published, ->() {
    order(date_post: 'asc')
  }
end
