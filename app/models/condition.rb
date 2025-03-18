class Condition < ActiveRecord::Base
  belongs_to :patient
  default_scope { current.order(started_at: :asc).order(cronic: :desc) }
  scope :current, -> { where("cronic = true OR ended_at >= ?", Date.today) }
  scope :cronic, -> { where(cronic: true) }
  scope :transitory, -> { where(cronic: false) }
  
  validates :patient, :name, presence: true

  attr_reader :current

  def current
    return true if self.ended_at.nil?
    not self.ended_at < Date.today
  end
end
