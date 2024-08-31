variable "environments" {
  type        = list(string)
  description = "A list of possible environments"
}

variable "ENV" {
  type        = string
  description = "Environment name to setup backend for, typically set using TF_VAR_ENV"
  validation {
    condition     = contains(var.environments, var.ENV)
    error_message = "Please make sure ENV is one of the approved values: [\n${join(",\n", [for v in var.environments : "    ${v}"])}\n]"
  }
}

variable "output_dir" {
  type        = string
  description = "The directory to place the output files (backend.tf, environment.auto.tfvars, & env_vars.tf.json)"
}

variable "environment_configs_dir" {
  type        = string
  description = "The directory where ENV-environment.yaml files are stored"
  default     = "."
}

variable "variables" {
  type        = map(string)
  description = "A map of variable names and types (string formatted)"
  default     = {}
}

variable "passthrough" {
  type = map(any)
  default = {}
}
