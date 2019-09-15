firestore_key=Rails.application.credentials[:firestore]
File.open("config/firestore.json","w") do |f|
    f.write(firestore_key.to_json)
    Rails.logger.info "firestore service key updated"
end