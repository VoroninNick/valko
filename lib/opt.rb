module Opt
  def self.models
    models = Dir[Rails.root.join("app/models/*.rb")].map {|f| name = f.split("/").last.gsub(/\.rb\Z/, "").camelize.constantize }.select{|a| a.instance_of?(Class) && a.superclass == ActiveRecord::Base }
  end
  def self.reprocess_images(models = nil, extensions = [:jpg, :jpeg, :png])
    models ||= Opt.models
    if !models.is_a?(Array)
      models =[models]
    end
    Paperclip.options[:log] = false
    if !extensions.is_a?(Array)
      extensions = [extensions]
    end
    (models).each do |model|
      puts "model: #{model.name}"
      model.logger = nil
      names = model.try(:attachment_definitions)
      if names.try(:any?)
        names.each do |name, attachment_definition|
          model.all.each do |item|
            attachment = item.send(name)
            if attachment.exists?
              attachment.styles.each do |style_name, style_definition|
                if extensions.include?(File.extname(attachment.path(style_name)).gsub(/\A\./, "").to_sym)
                  attachment.reprocess!(style_name)
                end
              end
            end
          end
        end
      end
    end

    return true
  end

  def self.optimize_static_images
    optimized_images_relative_path = "app/assets/optimized_images"
    original_assets_path = Rails.root.join("app/assets/images")
    optimized_assets_path = Rails.root.join(optimized_images_relative_path)
    FileUtils.rm_rf(optimized_assets_path)
    FileUtils.copy_entry(original_assets_path, optimized_assets_path)
    #AssetImageOpt::WORKING_DIR = optimized_images_relative_path
    AssetImageOpt::WORKING_DIR.send(:replace, optimized_images_relative_path)
    opt = AssetImageOpt.new

    opt.optimize
  end
end