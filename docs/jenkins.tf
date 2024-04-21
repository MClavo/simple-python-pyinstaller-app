terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}

provider "docker" {
  host = "npipe:////.//pipe//docker_engine"
}


# Crea la red de Docker
resource "docker_network" "jenkins_network" {
  name = "jenkins"
}

# Crea el volumen de certificados
resource "docker_volume" "jenkins-docker-certs" {
  name = "jenkins-docker-certs"
}

# Crea el volumen de datos
resource "docker_volume" "jenkins-data" {
  name = "jenkins-data"
}


####################### Contenedores  ##################################

# Crea el contenedor de Docker in Docker
resource "docker_container" "jenkins_docker" {
  name = "jenkins-docker"
  image = "docker:dind"
  rm = true 
  privileged = true

  networks_advanced {
    name = "jenkins"
    aliases = ["docker"]
  }

  env = [
    "DOCKER_TLS_CERTDIR = /certs"
  ]

  volumes {
    volume_name = "jenkins-docker-certs"
    container_path = "/certs/client"
  }

  volumes {
    volume_name = "jenkins-data"
    container_path = "/var/jenkins_home"
  }

  ports {
    internal = 2376
    external = 2376
  }

  ports {
    internal = 3000
    external = 3000
  }

  ports {
    internal = 5000
    external = 5000
  }
}

# Crea el contenedor de Jenkins
resource "docker_container" "jenkins_blueocean" {
  name = "jenkins-blueocean"
  image = "myjenkins-blueocean" # Imagen creada con el Dockerfile
  restart = "on-failure"
  network_mode = "jenkins"

  env = [
    "DOCKER_HOST        = tcp://docker:2376",
    "DOCKER_CERT_PATH   = /certs/client",
    "DOCKER_TLS_VERIFY  = 1",
  ]

  ports {
    internal = 8080
    external = 8080
  }

  ports {
    internal = 50000
    external = 50000
  }

  volumes {
    volume_name = "jenkins-data"
    container_path = "/var/jenkins_home"
  }

  volumes {
    volume_name = "jenkins-docker-certs"
    container_path = "/certs/client"
    read_only = true
  }
}