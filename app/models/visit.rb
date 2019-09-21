class Visit < ApplicationRecord

    scope :group_by_date,
        -> { group("created_at::date").order("created_at::date DESC").count('id')}
    scope :by_domain, ->(domain) { where("domain=?",domain)}
    scope :by_week, -> { group("DATE_TRUNC('week',created_at)").count('id') }

    def push_to_firestore
        begin 
            project_id = Rails.application.credentials[:firestore][:project_id]
            firestore = Google::Cloud::Firestore.new project_id: project_id
            visit_time = created_at 
            visit_time ||= Time.now
            created_at = visit_time
            domain.sub!(/^www\./, '')
            doc_ref = firestore.col(domain).doc("nested").col("days").doc(visit_time.strftime('%Y%m%d')).col("visits").doc(visit_time.strftime('%H%M%S%3N'))
            doc_ref.set(id: id,domain: domain, ip: ip, device: device, country: country, referer: referer, keyword: keyword, bounce: bounce, retention: retention, browser: browser, version: version, path: path,created_at: visit_time)
            # doc_ref = firestore.col(domain).doc("flat").col("visits").doc(visit_time.strftime('%Y%m%d%H%M%S%3N'))
            # doc_ref.set(id: id, domain: domain, ip: ip, device: device, country: country, referer: referer, keyword: keyword, bounce: bounce, retention: retention, browser: browser, version: version, path: path,created_at: visit_time)
            puts "Created a document for visit id: #{id} ; time: #{visit_time.strftime('%Y%m%d%H%M%S%3N')}"
            return visit_time
        rescue StandardError => e
            puts "Error writing #{self} to firestore: #{e}"
        end
    end

end
