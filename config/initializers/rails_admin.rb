RailsAdmin.config do |config|

  ### Popular gems integration

  ## == Devise ==
  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  config.current_user_method(&:current_user)

  ## == Cancan ==
  # config.authorize_with :cancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show

  end
  config.model Testimonial do
    label 'Відгук'
    label_plural 'Відгуки'

    edit do
      field :published
      # field :position
      field :main
      field :on_index_page
      field :avatar, :paperclip do
        help 'розмір зображення 320x320'
      end
      field :description do
        html_attributes rows: 10, cols: 100
      end
      field :name
      field :date_post
    end
  end

end
