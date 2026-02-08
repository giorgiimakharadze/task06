variable "plan_name" {
  type        = string
  description = "App Service name"
}

variable "resource_group_name" {
  type        = string
  description = "Resource Group Name"
}

variable "location" {
  type        = string
  description = "Location"
}

variable "os_type" {
  type    = string
  default = "Linux"
  validation {
    condition     = contains(["Windows", "Linux"], var.os_type)
    error_message = "os_type must be Windows or Linux"
  }
  description = "OS type"
}

variable "sku_name" {
  type        = string
  description = "SKU name"
}

variable "worker_count" {
  type    = number
  default = 1
  validation {
    condition     = var.worker_count >= 1
    error_message = "worker_count must be greater or equal to 1"
  }

  description = "Worker Count"
}

variable "tags" {
  type        = map(string)
  description = "Tags"
}

###############################################

variable "app_name" {
  type        = string
  description = "App Name"
}

variable "app_settings" {
  type        = map(string)
  description = "App Settings"
}

variable "sql_connection_string" {
  type        = string
  description = "Sensitive SQL ADO.NET connection string passed from the SQL module."
  sensitive   = true
}

variable "app_allow_ip_rule" {
  type = list(object({
    name       = string
    ip_address = string
    priority   = number
    action     = optional(string, "Allow")
  }))
  description = "Access restriction allow IP rule"
}

variable "app_allow_tag_rule" {
  type = list(object({
    name        = string
    service_tag = string
    priority    = number
    action      = optional(string, "Allow")
  }))
  description = "Access restriction allow tag rule"
}

variable "ip_restriction_default_action" {
  type    = string
  default = "Deny"
  validation {
    condition     = contains(["Allow", "Deny"], var.ip_restriction_default_action)
    error_message = "ip_restriction_default_action must be Allow or Deny"
  }
  description = "default action"
}

variable "dotnet_version" {
  type        = string
  description = "Dotnet Version"
}
