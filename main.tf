resource "google_compute_resource_policy" "compute_resource_policies" {
  for_each = var.compute_resource_policies

  name            = each.value.name
  deletion_policy = each.value.deletion_policy
  description     = each.value.description
  project         = each.value.project
  region          = each.value.region

  dynamic "disk_consistency_group_policy" {
    for_each = each.value.disk_consistency_group_policy != null ? [each.value.disk_consistency_group_policy] : []
    content {
      enabled = disk_consistency_group_policy.value.enabled
    }
  }

  dynamic "group_placement_policy" {
    for_each = each.value.group_placement_policy != null ? [each.value.group_placement_policy] : []
    content {
      availability_domain_count = group_placement_policy.value.availability_domain_count
      collocation               = group_placement_policy.value.collocation
      gpu_topology              = group_placement_policy.value.gpu_topology
      vm_count                  = group_placement_policy.value.vm_count
    }
  }

  dynamic "instance_schedule_policy" {
    for_each = each.value.instance_schedule_policy != null ? [each.value.instance_schedule_policy] : []
    content {
      expiration_time = instance_schedule_policy.value.expiration_time
      start_time      = instance_schedule_policy.value.start_time
      time_zone       = instance_schedule_policy.value.time_zone
      dynamic "vm_start_schedule" {
        for_each = instance_schedule_policy.value.vm_start_schedule != null ? [instance_schedule_policy.value.vm_start_schedule] : []
        content {
          schedule = vm_start_schedule.value.schedule
        }
      }
      dynamic "vm_stop_schedule" {
        for_each = instance_schedule_policy.value.vm_stop_schedule != null ? [instance_schedule_policy.value.vm_stop_schedule] : []
        content {
          schedule = vm_stop_schedule.value.schedule
        }
      }
    }
  }

  dynamic "snapshot_schedule_policy" {
    for_each = each.value.snapshot_schedule_policy != null ? [each.value.snapshot_schedule_policy] : []
    content {
      dynamic "retention_policy" {
        for_each = snapshot_schedule_policy.value.retention_policy != null ? [snapshot_schedule_policy.value.retention_policy] : []
        content {
          max_retention_days    = retention_policy.value.max_retention_days
          on_source_disk_delete = retention_policy.value.on_source_disk_delete
        }
      }
      schedule {
        dynamic "daily_schedule" {
          for_each = snapshot_schedule_policy.value.schedule.daily_schedule != null ? [snapshot_schedule_policy.value.schedule.daily_schedule] : []
          content {
            days_in_cycle = daily_schedule.value.days_in_cycle
            start_time    = daily_schedule.value.start_time
          }
        }
        dynamic "hourly_schedule" {
          for_each = snapshot_schedule_policy.value.schedule.hourly_schedule != null ? [snapshot_schedule_policy.value.schedule.hourly_schedule] : []
          content {
            hours_in_cycle = hourly_schedule.value.hours_in_cycle
            start_time     = hourly_schedule.value.start_time
          }
        }
        dynamic "weekly_schedule" {
          for_each = snapshot_schedule_policy.value.schedule.weekly_schedule != null ? [snapshot_schedule_policy.value.schedule.weekly_schedule] : []
          content {
            dynamic "day_of_weeks" {
              for_each = weekly_schedule.value.day_of_weeks
              content {
                day        = day_of_weeks.value.day
                start_time = day_of_weeks.value.start_time
              }
            }
          }
        }
      }
      dynamic "snapshot_properties" {
        for_each = snapshot_schedule_policy.value.snapshot_properties != null ? [snapshot_schedule_policy.value.snapshot_properties] : []
        content {
          chain_name        = snapshot_properties.value.chain_name
          guest_flush       = snapshot_properties.value.guest_flush
          labels            = snapshot_properties.value.labels
          storage_locations = snapshot_properties.value.storage_locations
        }
      }
    }
  }

  dynamic "timeouts" {
    for_each = each.value.timeouts != null ? [each.value.timeouts] : []
    content {
      create = timeouts.value.create
      delete = timeouts.value.delete
      update = timeouts.value.update
    }
  }

  dynamic "workload_policy" {
    for_each = each.value.workload_policy != null ? [each.value.workload_policy] : []
    content {
      accelerator_topology  = workload_policy.value.accelerator_topology
      max_topology_distance = workload_policy.value.max_topology_distance
      type                  = workload_policy.value.type
    }
  }
}

