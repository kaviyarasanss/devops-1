terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

# Talks to the local Docker engine (Docker Desktop on the laptop).
provider "docker" {}

variable "image" {
  description = "Image built beforehand with: docker build -t devops-1 ."
  type        = string
  default     = "devops-1:latest"
}

variable "host_port" {
  description = "Laptop port that forwards to the app's port 3000 inside the container"
  type        = number
  default     = 8080
}

# Uses the image already on this machine instead of building or pulling it.
resource "docker_image" "app" {
  name         = var.image
  keep_locally = true
}

resource "docker_container" "app" {
  name  = "devops-1-terraform"
  image = docker_image.app.image_id

  ports {
    internal = 3000
    external = var.host_port
  }
}

output "health_url" {
  value = "http://localhost:${var.host_port}/health"
}
