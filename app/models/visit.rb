class Visit < ApplicationRecord

    scope :total_visit_by_url, -> { group('domain').count('id')}
    scope :total_visit_by_date,
        -> { group("created_at::date").count('id')}
end
