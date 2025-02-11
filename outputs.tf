
output "service_mesh_id" {
  description = "The resource ID in terraform of Service Mesh."
  value       = concat(alicloud_service_mesh_service_mesh.mesh[*].id, [""])[0]
}

output "service_mesh_status" {
  description = "The status of the resource."
  value       = concat(alicloud_service_mesh_service_mesh.mesh[*].status, [""])[0]
}