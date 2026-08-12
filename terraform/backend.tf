resource "render_web_service" "backend" {
  name   = "condocombat-backend-api"
  plan   = "free"
  region = "oregon"

  runtime_source = {
    image = {
      image_url = "docker.io/${var.dockerhub_username}/condocombat-backend"
      tag       = "latest"
    }
  }

  env_vars = {
    "DATABASE_URL" = {
      value = "postgresql+asyncpg://postgres.${supabase_project.db.id}:${var.supabase_db_password}@aws-0-us-east-1.pooler.supabase.com:5432/postgres"
    }
    "SECRET_KEY" = {
      value = var.backend_secret_key
    }
    "CORS_ORIGINS" = {
      value = "*"
    }
    "PORT" = {
      value = "8000"
    }
  }
}