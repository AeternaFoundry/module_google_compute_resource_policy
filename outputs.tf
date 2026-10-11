output "compute_resource_policies_id" {
  description = "Map of id values across all compute_resource_policies, keyed the same as var.compute_resource_policies except keys with no id are omitted"
  value       = { for k, v in google_compute_resource_policy.compute_resource_policies : k => v.id if v.id != null && length(v.id) > 0 }
}
output "compute_resource_policies_deletion_policy" {
  description = "Map of deletion_policy values across all compute_resource_policies, keyed the same as var.compute_resource_policies except keys with no deletion_policy are omitted"
  value       = { for k, v in google_compute_resource_policy.compute_resource_policies : k => v.deletion_policy if v.deletion_policy != null && length(v.deletion_policy) > 0 }
}
output "compute_resource_policies_description" {
  description = "Map of description values across all compute_resource_policies, keyed the same as var.compute_resource_policies except keys with no description are omitted"
  value       = { for k, v in google_compute_resource_policy.compute_resource_policies : k => v.description if v.description != null && length(v.description) > 0 }
}
output "compute_resource_policies_disk_consistency_group_policy" {
  description = "Map of disk_consistency_group_policy values across all compute_resource_policies, keyed the same as var.compute_resource_policies except keys with no disk_consistency_group_policy are omitted"
  value       = { for k, v in google_compute_resource_policy.compute_resource_policies : k => one(v.disk_consistency_group_policy) if v.disk_consistency_group_policy != null && length(v.disk_consistency_group_policy) > 0 }
}
output "compute_resource_policies_group_placement_policy" {
  description = "Map of group_placement_policy values across all compute_resource_policies, keyed the same as var.compute_resource_policies except keys with no group_placement_policy are omitted"
  value       = { for k, v in google_compute_resource_policy.compute_resource_policies : k => one(v.group_placement_policy) if v.group_placement_policy != null && length(v.group_placement_policy) > 0 }
}
output "compute_resource_policies_instance_schedule_policy" {
  description = "Map of instance_schedule_policy values across all compute_resource_policies, keyed the same as var.compute_resource_policies except keys with no instance_schedule_policy are omitted"
  value       = { for k, v in google_compute_resource_policy.compute_resource_policies : k => one(v.instance_schedule_policy) if v.instance_schedule_policy != null && length(v.instance_schedule_policy) > 0 }
}
output "compute_resource_policies_name" {
  description = "Map of name values across all compute_resource_policies, keyed the same as var.compute_resource_policies except keys with no name are omitted"
  value       = { for k, v in google_compute_resource_policy.compute_resource_policies : k => v.name if v.name != null && length(v.name) > 0 }
}
output "compute_resource_policies_project" {
  description = "Map of project values across all compute_resource_policies, keyed the same as var.compute_resource_policies except keys with no project are omitted"
  value       = { for k, v in google_compute_resource_policy.compute_resource_policies : k => v.project if v.project != null && length(v.project) > 0 }
}
output "compute_resource_policies_region" {
  description = "Map of region values across all compute_resource_policies, keyed the same as var.compute_resource_policies except keys with no region are omitted"
  value       = { for k, v in google_compute_resource_policy.compute_resource_policies : k => v.region if v.region != null && length(v.region) > 0 }
}
output "compute_resource_policies_self_link" {
  description = "Map of self_link values across all compute_resource_policies, keyed the same as var.compute_resource_policies except keys with no self_link are omitted"
  value       = { for k, v in google_compute_resource_policy.compute_resource_policies : k => v.self_link if v.self_link != null && length(v.self_link) > 0 }
}
output "compute_resource_policies_snapshot_schedule_policy" {
  description = "Map of snapshot_schedule_policy values across all compute_resource_policies, keyed the same as var.compute_resource_policies except keys with no snapshot_schedule_policy are omitted"
  value       = { for k, v in google_compute_resource_policy.compute_resource_policies : k => one(v.snapshot_schedule_policy) if v.snapshot_schedule_policy != null && length(v.snapshot_schedule_policy) > 0 }
}
output "compute_resource_policies_workload_policy" {
  description = "Map of workload_policy values across all compute_resource_policies, keyed the same as var.compute_resource_policies except keys with no workload_policy are omitted"
  value       = { for k, v in google_compute_resource_policy.compute_resource_policies : k => one(v.workload_policy) if v.workload_policy != null && length(v.workload_policy) > 0 }
}

