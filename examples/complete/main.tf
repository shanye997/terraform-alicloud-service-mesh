provider "alicloud" {
  region = "cn-hangzhou"
}

data "alicloud_zones" "default" {
  available_resource_creation = "VSwitch"
}

module "vpc" {
  source             = "alibaba/vpc/alicloud"
  version            = "~> 1.11.0"

  create             = true
  vpc_name           = "tf-test-service-mesh"
  vpc_cidr           = "172.16.0.0/16"
  vswitch_name       = "tf-test-service-mesh"
  vswitch_cidrs      = ["172.16.0.0/21"]
  availability_zones = [data.alicloud_zones.default.zones[0].id]
}

resource "random_integer" "default" {
  min = 10000
  max = 99999
}

resource "alicloud_log_project" "default" {
  name        = "tf-example-${random_integer.default.result}"
  description = "created by terraform"
}


data "alicloud_service_mesh_versions" "default" {
  edition = "Default"
}

module "example" {
  source                  = "../.."
  create_service_mesh     = true
  name                    = var.name
  vpc_id                  = module.vpc.this_vpc_id
  vswitche_ids            = [module.vpc.this_vswitch_ids[0]]
  service_mesh_version    = reverse(data.alicloud_service_mesh_versions.default.versions)[0].version
  edition                 = var.edition
  force                   = var.force
  customized_zipkin       = var.customized_zipkin
  enable_locality_lb      = var.enable_locality_lb
  outbound_traffic_policy = var.outbound_traffic_policy
  telemetry               = var.telemetry
  tracing                 = true
  access_log              = var.access_log
  audit = {
    enabled = "true"
    project = alicloud_log_project.default.project_name
  }
  kiali            = var.kiali
  opa              = var.opa
  proxy            = var.proxy
  sidecar_injector = var.sidecar_injector
  load_balancer = {
    api_server_public_eip = false
    pilot_public_eip      = false
  }
  pilot = {
    http10_enabled = true
    trace_sampling = 100
  }
}
