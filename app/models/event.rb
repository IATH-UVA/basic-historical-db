class Event < ApplicationRecord
  belongs_to :era
  belongs_to :event_type
  belongs_to :source, optional: true
end
