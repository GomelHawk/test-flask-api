variable "cluster_name" {
  type = string
}

variable "cluster_version" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "subnets" {
  type = list(string)
}

variable "node_group" {
  type = object({
    instance_type = string
    desired_size  = number
    max_size      = number
    min_size      = number
  })
}
