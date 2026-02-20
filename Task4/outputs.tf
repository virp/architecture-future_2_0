output "app_container_name" {
  description = "Name of the running application container."
  value       = docker_container.app.name
}

output "app_url" {
  description = "URL to access the application from the host machine."
  value       = "http://localhost:${var.app_port}"
}

output "db_connection_info" {
  description = "Database host and port exposed on the host machine."
  value       = "localhost:${var.db_port}"
}
