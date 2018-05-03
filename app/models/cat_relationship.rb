class CatRelationship < ApplicationRecord
  def self.relationship_exists?(giver:, taker:)
    where(giver_id: giver, taker_id: taker).exists?
  end
end
