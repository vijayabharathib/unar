class Visit < ApplicationRecord

    scope :group_by_date,
        -> { group("created_at::date").order("created_at::date DESC").count('id')}
    scope :by_domain, ->(domain) { where("domain=?",domain)}
end
