class Visit < ApplicationRecord

    scope :group_by_date,
        -> { group("created_at::date").count('id')}
    scope :by_domain, ->(domain) { where("domain=?",domain)}
end
