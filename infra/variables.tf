variable "tags_app" {
    type = map(any)
    description = "Tags para criacao de recursos"
    default = {
        projeto = "site-front"
        ambiente = "desenvolvimento"
    }
}

variable "tags_terraform" {
    type = map(any)
    description = "Tags para criacao de recursos"
    default = {
        projeto = "terraform"
        ambiente = "desenvolvimento"
    }
}
variable "app_name" {
    type = string
    description = "Tags para criacao de recursos"
    default  = "sitechalangedevops"
}