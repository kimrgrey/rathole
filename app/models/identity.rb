class Identity < ActiveRecord::Base
  belongs_to :user, touch: true

  validates :user, presence: true
  validates :uuid, presence: true
  validates :provider, presence: true

  after_create :destroy_duplicates

  def self.find_by_auth(auth)
    Identity.where(:uuid => auth.uid, :provider => auth.provider).first
  end

  private

  def destroy_duplicates
    Identity.where('identities.id <> ?', id).where(:uuid => uuid, :provider => provider).destroy_all
  end
end