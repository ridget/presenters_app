class UserPresenter < SimpleDelegator
  include Rails.application.routes.url_helpers
  include ActionView::Helpers

  def full_name_with_title
    "#{model.title} #{model.first_name} #{model.last_name}"
  end

  def avatar_link
    link_to_if model.profile_link.present?, image_tag("avatars/#{avatar_name}", class: "avatar"), model.profile_link
  end

  def preference_names
    if preferences.blank?
      model.preferences.map(&:name).join(",")
    else
      "No Preferences selected for this user"
    end
  end

  def description
    if model.description.present?
      model.description
    else
      "This User hasn't filled in their description yet."
    end
  end

  def avatar_name
    "#{model.avatar}.jpeg"
  end

  # Returns ref to the object we're decorating
  #  a method to help readability.
  # If using this n>1 times then consider moving upto superclass
  def model
    __getobj__
  end

  # Enables us to call Presenter.wrap on a collection of objects and instatiate those objects
  def self.wrap(collection)
    collection.map do |obj|
      new obj
    end
  end

end