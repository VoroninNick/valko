module HasGallery

  def self.included(base)
    #base.gallery_initialize
  end

  def self.extended(base)
    if (ancs = base.try(:ancestors)) && ancs.select{|m| m.name == "ActiveRecord::Base"}.first
      base.gallery_initialize
    end
  end

  def add_gallery_columns(connection)
    connection.change_table self.table_name do |t|
      t.string :video_title
      t.string :video_url
      t.attachment :video_poster
      t.boolean :video_published
    end
  end

  def gallery_initialize
    attr_accessible :video_poster
    has_attached_file :video_poster,
                      styles: { large: "440x300>"},
                      convert_options: { large: "-quality 94 -interlace Plane"},
                      default_url: "/images/:style/missing.png"

    validates_attachment_content_type :video_poster, content_type: /\Aimage\/.*\Z/

    has_many :photo_galleries, as: :imageable
    attr_accessible :photo_galleries
    accepts_nested_attributes_for :photo_galleries, allow_destroy: true
    attr_accessible :photo_galleries_attributes
  end

  def rails_admin_gallery_fields
    group :gallery do
      label 'Галерея'
      active false
      field :photo_galleries do
        label 'Фотогалерея:'
      end
      field :video_published do
        label 'Чи публікувати відео?:'
      end
      field :video_title do
        label 'Назва відео:'
      end
      field :video_url do
        label 'Лінк на відео:'
      end
      field :video_poster, :paperclip do
        label 'Відео постер:'
        help 'розмір зображення 440x300'
      end

    end
  end
end