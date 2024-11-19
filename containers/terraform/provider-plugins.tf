terraform {
  required_providers {
    aws      = { source = "hashicorp/aws", version = "4.9.0" }
    random   = { source = "hashicorp/random", version = "3.1.0" }
    external = { source = "hashicorp/external", version = "2.1.0" }
    local    = { source = "hashicorp/local", version = "2.1.0" }
    null     = { source = "hashicorp/null", version = "3.1.0" }
    template = { source = "hashicorp/template", version = "2.2.0" }
    tls      = { source = "hashicorp/tls", version = "3.1.0" }
  }
}
