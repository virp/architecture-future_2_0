variable "project_name" {
  description = "Short identifier used in image tags, network and volume names."
  type        = string
}

variable "environment" {
  description = "Logical environment name (dev, stage, prod)."
  type        = string
  default     = "dev"
}

variable "docker_host" {
  description = "Docker host socket/URL used by the provider."
  type        = string
  default     = "unix:///var/run/docker.sock"
}

variable "app_port" {
  description = "Port exposed by the application."
  type        = number
  default     = 8080
}

variable "app_image_tag" {
  description = "Tag for the locally built application image."
  type        = string
  default     = "latest"
}

variable "db_version" {
  description = "PostgreSQL image tag."
  type        = string
  default     = "15-alpine"
}

variable "db_name" {
  description = "Database name that will be created in PostgreSQL."
  type        = string
  default     = "appdb"
}

variable "db_username" {
  description = "Database username."
  type        = string
  default     = "postgres"
}

variable "db_password" {
  description = "Database password."
  type        = string
  sensitive   = true
}

variable "db_port" {
  description = "Host port mapped to the PostgreSQL container."
  type        = number
  default     = 5432
}

variable "db_host_override" {
  description = "Optional host/IP for the application to reach the database (defaults to container name)."
  type        = string
  default     = null
}
