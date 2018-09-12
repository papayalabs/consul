class SiteCustomization::Page < ActiveRecord::Base
  VALID_STATUSES = %w(draft published)

  validates :slug, presence: true,
                   uniqueness: { case_sensitive: false },
                   format: { with: /\A[0-9a-zA-Z\-_]*\Z/, message: :slug_format }
  validates :title, presence: true
  validates :status, presence: true, inclusion: { in: VALID_STATUSES }
  
  translates :title, :subtitle, :content
  globalize_accessors locales: [:en, :es, :fr, :nl, :val, :pt_br] 
 
  scope :published, -> { where(status: 'published').order('id DESC') }
  scope :with_more_info_flag, -> { where(status: 'published', more_info_flag: true).order('id ASC') }
#  scope :with_same_locale, -> { where(locale: I18n.locale).order('id ASC') }

  def url
    "/#{slug}"
  end
end
