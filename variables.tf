variable "compute_resource_policies" {
  description = <<EOT
Map of compute_resource_policies, attributes below
Required:
    - name
Optional:
    - deletion_policy
    - description
    - project
    - region
    - disk_consistency_group_policy (block):
        - enabled (required)
    - group_placement_policy (block):
        - availability_domain_count (optional)
        - collocation (optional)
        - gpu_topology (optional)
        - vm_count (optional)
    - instance_schedule_policy (block):
        - expiration_time (optional)
        - start_time (optional)
        - time_zone (required)
        - vm_start_schedule (optional, block):
            - schedule (required)
        - vm_stop_schedule (optional, block):
            - schedule (required)
    - snapshot_schedule_policy (block):
        - retention_policy (optional, block):
            - max_retention_days (required)
            - on_source_disk_delete (optional)
        - schedule (required, block):
            - daily_schedule (optional, block):
                - days_in_cycle (required)
                - start_time (required)
            - hourly_schedule (optional, block):
                - hours_in_cycle (required)
                - start_time (required)
            - weekly_schedule (optional, block):
                - day_of_weeks (required, block):
                    - day (required)
                    - start_time (required)
        - snapshot_properties (optional, block):
            - chain_name (optional)
            - guest_flush (optional)
            - labels (optional)
            - storage_locations (optional)
    - timeouts (block):
        - create (optional)
        - delete (optional)
        - update (optional)
    - workload_policy (block):
        - accelerator_topology (optional)
        - max_topology_distance (optional)
        - type (required)
EOT

  type = map(object({
    name            = string
    deletion_policy = optional(string)
    description     = optional(string)
    project         = optional(string)
    region          = optional(string)
    disk_consistency_group_policy = optional(object({
      enabled = bool
    }))
    group_placement_policy = optional(object({
      availability_domain_count = optional(number)
      collocation               = optional(string)
      gpu_topology              = optional(string)
      vm_count                  = optional(number)
    }))
    instance_schedule_policy = optional(object({
      expiration_time = optional(string)
      start_time      = optional(string)
      time_zone       = string
      vm_start_schedule = optional(object({
        schedule = string
      }))
      vm_stop_schedule = optional(object({
        schedule = string
      }))
    }))
    snapshot_schedule_policy = optional(object({
      retention_policy = optional(object({
        max_retention_days    = number
        on_source_disk_delete = optional(string)
      }))
      schedule = object({
        daily_schedule = optional(object({
          days_in_cycle = number
          start_time    = string
        }))
        hourly_schedule = optional(object({
          hours_in_cycle = number
          start_time     = string
        }))
        weekly_schedule = optional(object({
          day_of_weeks = list(object({
            day        = string
            start_time = string
          }))
        }))
      })
      snapshot_properties = optional(object({
        chain_name        = optional(string)
        guest_flush       = optional(bool)
        labels            = optional(map(string))
        storage_locations = optional(set(string))
      }))
    }))
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
      update = optional(string)
    }))
    workload_policy = optional(object({
      accelerator_topology  = optional(string)
      max_topology_distance = optional(string)
      type                  = string
    }))
  }))
  validation {
    condition = alltrue([
      for k, v in var.compute_resource_policies : (
        v.snapshot_schedule_policy == null || (v.snapshot_schedule_policy.schedule.weekly_schedule == null || (length(v.snapshot_schedule_policy.schedule.weekly_schedule.day_of_weeks) >= 1 && length(v.snapshot_schedule_policy.schedule.weekly_schedule.day_of_weeks) <= 7))
      )
    ])
    error_message = "Each day_of_weeks list must contain between 1 and 7 items"
  }
  # Note: 7 additional provider-side validators are enforced at apply time but not mirrored as validation{} blocks here (bespoke or non-mechanically-translatable).
}

