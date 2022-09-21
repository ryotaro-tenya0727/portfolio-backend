class User::NotificationSerializer
  include JSONAPI::Serializer
  attributes :action, :checked

  attribute :notifier_name do |notification|
    notification.notifier.name
  end
end
