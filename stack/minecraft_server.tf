resource oci_core_instance MinecraftServer {
  agent_config {
    are_all_plugins_disabled = "false"
    is_management_disabled   = "false"
    is_monitoring_disabled   = "false"
    plugins_config {
      desired_state = "ENABLED"
      name          = "Compute Instance Monitoring"
    }
  }
  availability_config {
    recovery_action = "RESTORE_INSTANCE"
  }
  availability_domain = var.availability_domain
  
  compartment_id = var.compartment_ocid
  create_vnic_details {
    
    assign_public_ip = "true"
   
    display_name = "MinecraftServer"
    hostname_label = "minecraftserver"
    nsg_ids = [
    ]
    skip_source_dest_check = "false"
    subnet_id              = oci_core_subnet.MinecraftSubnet.id
    
  }
  
  display_name = "MinecraftServer"
  instance_options {
    are_legacy_imds_endpoints_disabled = "false"
  }
  launch_options {
    boot_volume_type                    = "PARAVIRTUALIZED"
    firmware                            = "UEFI_64"
    is_consistent_volume_naming_enabled = "true"
    is_pv_encryption_in_transit_enabled = "true"
    network_type                        = "PARAVIRTUALIZED"
    remote_data_volume_type             = "PARAVIRTUALIZED"
  }
  metadata = {
    ssh_authorized_keys = var.ssh_authorized_keys
    user_data = base64encode(file("minecraft_install_script.sh")) 
    #user_data = "IyEvYmluL3NoCm1rZGlyIC1wIC91MDEvTWluZWNyYWZ0U2VydmVyCmNkIC91MDEvTWluZWNyYWZ0U2VydmVyCnl1bSBpbnN0YWxsIGpkay0xOC5hYXJjaDY0IC15CndnZXQgaHR0cHM6Ly9waXN0b24tZGF0YS5tb2phbmcuY29tL3YxL29iamVjdHMvZjY5YzI4NDIzMmQ3Yzc1ODBiZDg5YTVhNDkzMWMzNTgxZWFlMTM3OC9zZXJ2ZXIuamFyCmphdmEgLVhteDEwMjRNIC1YbXMxMDI0TSAtamFyIHNlcnZlci5qYXIgbm9ndWkKc2VkIC1pICdzL2V1bGE9ZmFsc2UvZXVsYT10cnVlL2cnIGV1bGEudHh0CmZpcmV3YWxsLW9mZmxpbmUtY21kIC0tem9uZT1wdWJsaWMgLS1hZGQtcG9ydD0yNTU2NS90Y3AKZmlyZXdhbGwtb2ZmbGluZS1jbWQgLS16b25lPXB1YmxpYyAtLWFkZC1wb3J0PTI1NTY1L3VkcApzeXN0ZW1jdGwgcmVzdGFydCBmaXJld2FsbGQKbm9odXAgamF2YSAtWG14NEcgLVhtczEwMjRNIC1qYXIgc2VydmVyLmphciBub2d1aSA+Pi90bXAvTWluZWNyYWZ0U2VydmVyLmxvZyAmCg=="
      }
  
  shape = "VM.Standard.A1.Flex"
  shape_config {
    baseline_ocpu_utilization = ""
    memory_in_gbs             = var.memory_count
    ocpus                     = var.ocpu_count
  }
  source_details {
    source_id   = var.InstanceImageOCID[var.region]
    source_type = "image"
  }
  
}

output "MinecraftServer-Public-IP"  {
  value = oci_core_instance.MinecraftServer.public_ip
} 