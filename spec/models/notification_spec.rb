# == Schema Information
#
# Table name: notifications
#
#  id          :bigint           not null, primary key
#  action      :string(255)      default(""), not null
#  checked     :boolean          default(FALSE), not null
#  uuid        :string(255)      not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  comment_id  :bigint
#  diary_id    :bigint
#  notified_id :bigint           not null
#  notifier_id :bigint           not null
#
# Indexes
#
#  index_notifications_on_comment_id   (comment_id)
#  index_notifications_on_diary_id     (diary_id)
#  index_notifications_on_notified_id  (notified_id)
#  index_notifications_on_notifier_id  (notifier_id)
#  index_notifications_on_uuid         (uuid) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (comment_id => comments.id)
#  fk_rails_...  (diary_id => diaries.id)
#  fk_rails_...  (notified_id => users.id)
#  fk_rails_...  (notifier_id => users.id)
#
require 'rails_helper'

RSpec.describe Notification, type: :model do
end
