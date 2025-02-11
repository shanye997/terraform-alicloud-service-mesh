
variable "name" {
  description = "The name of the resource."
  type        = string
  default     = "tf-test"
}

variable "edition" {
  description = "The type of the resource. Valid values: Default and Pro. Default:the standard. Pro:the Pro version."
  type        = string
  default     = "Default"
}

variable "force" {
  description = "This parameter is used for resource destroy. Default value is false."
  type        = bool
  default     = false
}

variable "customized_zipkin" {
  description = "Whether or not to enable the use of a custom zipkin."
  type        = bool
  default     = true
}

variable "enable_locality_lb" {
  description = "The enable locality lb."
  type        = bool
  default     = false
}

variable "outbound_traffic_policy" {
  description = "The policy of the Out to the traffic. Valid values: ALLOW_ANY and REGISTRY_ONLY."
  type        = string
  default     = "REGISTRY_ONLY"
}

variable "telemetry" {
  description = "Whether to enable acquisition Prometheus metrics"
  type        = bool
  default     = false
}

variable "access_log" {
  description = "The configuration of the access logging."
  type        = map(string)
  default     = {}
}

variable "kiali" {
  description = "The configuration of the Kiali."
  type        = map(string)
  default     = {}
}

variable "opa" {
  description = "The open-door policy of agent (OPA) plug-in information."
  type        = map(string)
  default     = {}
}

variable "proxy" {
  description = "The configuration of the Proxy. "
  type        = map(string)
  default = {
    limit_cpu      = "2000m"
    limit_memory   = "1024Mi"
    request_cpu    = "100m"
    request_memory = "128Mi"
  }
}

variable "sidecar_injector" {
  description = "The configuration of the Sidecar injector."
  type        = map(string)
  default = {
    limit_cpu      = "2000m"
    limit_memory   = "1024Mi"
    request_cpu    = "100m"
    request_memory = "128Mi"
  }
}
