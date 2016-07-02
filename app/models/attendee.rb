class Attendee < ActiveRecord::Base
	validates_uniqueness_of :user_id, :scope => :event_id
	validates_presence_of :user_id, :event_id
	validate :check_if_past_event
	belongs_to :event
	belongs_to :user

	private
	def check_if_past_event
		if event.present? && ( event.time < Time.now )
			errors.add(:event_id, "is a past event")
		end
	end
end
