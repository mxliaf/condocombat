resource "supabase_project" "db" {
  organization_id   = "fkhfoxettqngfzzzrgep"
  name              = "condocombat-db"
  database_password = var.supabase_db_password
  region            = "us-east-1"
}