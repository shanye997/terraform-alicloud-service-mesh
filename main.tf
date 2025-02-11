
resource "alicloud_service_mesh_service_mesh" "mesh" {
  count             = var.create_service_mesh ? 1 : 0
  service_mesh_name = var.name
  edition           = var.edition
  force             = var.force
  version           = var.service_mesh_version
  network {
    vpc_id        = var.vpc_id
    vswitche_list = var.vswitche_ids
  }
  load_balancer {
    api_server_public_eip = lookup(var.load_balancer, "api_server_public_eip", false)
    pilot_public_eip      = lookup(var.load_balancer, "pilot_public_eip", false)
  }
  mesh_config {
    customized_zipkin       = var.customized_zipkin
    enable_locality_lb      = var.enable_locality_lb
    outbound_traffic_policy = var.outbound_traffic_policy
    telemetry               = var.telemetry
    tracing                 = var.tracing
    access_log {
      enabled = lookup(var.access_log, "enabled", false)
    }
    audit {
      enabled = lookup(var.audit, "enabled", null)
      project = lookup(var.audit, "project", null)
    }
    kiali {
      enabled = lookup(var.kiali, "enabled", false)
    }
    opa {
      enabled        = lookup(var.opa, "enabled", false)
      limit_cpu      = lookup(var.opa, "limit_cpu", null)
      limit_memory   = lookup(var.opa, "limit_memory", null)
      log_level      = lookup(var.opa, "log_level", null)
      request_cpu    = lookup(var.opa, "request_cpu", null)
      request_memory = lookup(var.opa, "request_memory", null)
    }
    pilot {
      http10_enabled = lookup(var.pilot, "http10_enabled", false)
      trace_sampling = lookup(var.pilot, "trace_sampling", null)
    }
    proxy {
      limit_cpu      = lookup(var.proxy, "limit_cpu", null)
      limit_memory   = lookup(var.proxy, "limit_memory", null)
      request_cpu    = lookup(var.proxy, "request_cpu", null)
      request_memory = lookup(var.proxy, "request_memory", null)
    }
    sidecar_injector {
      auto_injection_policy_enabled = lookup(var.sidecar_injector, "auto_injection_policy_enabled", false)
      enable_namespaces_by_default  = lookup(var.sidecar_injector, "enable_namespaces_by_default", false)
      limit_cpu                     = lookup(var.sidecar_injector, "limit_cpu", null)
      limit_memory                  = lookup(var.sidecar_injector, "limit_memory", null)
      request_cpu                   = lookup(var.sidecar_injector, "request_cpu", null)
      request_memory                = lookup(var.sidecar_injector, "request_memory", null)
    }
  }
}


