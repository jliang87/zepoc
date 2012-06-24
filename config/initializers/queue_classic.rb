ENV["QC_DATABASE_URL"] = "postgres://localhost/zepoc" if Rails.env.development?
ENV["DATABASE_URL"] = "postgres://postgres:ml870813@zepoc.herokuapp.com/zepoc" if Rails.env.production?