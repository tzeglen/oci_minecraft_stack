
resource oci_core_internet_gateway MinecraftIG {
  compartment_id = var.compartment_ocid
  display_name = "MinecraftIG"
  enabled      = "true"
  vcn_id = oci_core_vcn.MinecraftVCN.id
}

resource oci_core_subnet MinecraftSubnet {
  cidr_block     = "10.10.0.0/24"
  compartment_id = var.compartment_ocid
  dhcp_options_id = oci_core_vcn.MinecraftVCN.default_dhcp_options_id
  display_name    = "MinecraftSubnet"
  dns_label       = "minecraftsubnet"
  freeform_tags = {
  }
  #ipv6cidr_block = <<Optional value not found in discovery>>
  prohibit_internet_ingress  = "false"
  prohibit_public_ip_on_vnic = "false"
  route_table_id             = oci_core_vcn.MinecraftVCN.default_route_table_id
  security_list_ids = [
    oci_core_vcn.MinecraftVCN.default_security_list_id,
  ]
  vcn_id = oci_core_vcn.MinecraftVCN.id
}

#resource oci_core_private_ip MinecraftServer_1 {
# 
#  hostname_label = "minecraftserver"
#  ip_address     = "10.10.0.25"
#  vnic_id = "ocid1.vnic.oc1.uk-london-1.abwgiljs7cunoag7pi4qfz2bo4dhb6sy4neq7mossdtzsg53wzkbk5akz6tq"
#}

resource oci_core_vcn MinecraftVCN {
  cidr_blocks = [
    "10.10.0.0/16",
  ]
  compartment_id = var.compartment_ocid
  display_name = "MinecraftVCN"
  dns_label    = "minecraftvcn"
  
}

resource oci_core_default_dhcp_options Default-DHCP-Options-for-MinecraftVCN {
  compartment_id = var.compartment_ocid
  display_name = "Default DHCP Options for MinecraftVCN"
  manage_default_resource_id = oci_core_vcn.MinecraftVCN.default_dhcp_options_id
  options {
    custom_dns_servers = [
    ]
    #search_domain_names = <<Optional value not found in discovery>>
    server_type = "VcnLocalPlusInternet"
    type        = "DomainNameServer"
  }
  options {
    #custom_dns_servers = <<Optional value not found in discovery>>
    search_domain_names = [
      "minecraftvcn.oraclevcn.com",
    ]
        type = "SearchDomain"
  }
}

resource oci_core_default_route_table Default-Route-Table-for-MinecraftVCN {
  compartment_id = var.compartment_ocid
  display_name = "Default Route Table for MinecraftVCN"
  manage_default_resource_id = oci_core_vcn.MinecraftVCN.default_route_table_id
  route_rules {
  
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.MinecraftIG.id
  }
}

resource oci_core_default_security_list Default-Security-List-for-MinecraftVCN {
  compartment_id = var.compartment_ocid
    display_name = "Default Security List for MinecraftVCN"
  egress_security_rules {
    destination      = "0.0.0.0/0"
    destination_type = "CIDR_BLOCK"
    protocol  = "all"
    stateless = "false"
  }
  freeform_tags = {
  }
  ingress_security_rules {
    protocol    = "6"
    source      = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    stateless   = "false"
    tcp_options {
      max = "22"
      min = "22"
     
    }
    
  }
  ingress_security_rules {
    
    icmp_options {
      code = "4"
      type = "3"
    }
    protocol    = "1"
    source      = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    stateless   = "false"
    
  }
  ingress_security_rules {
    icmp_options {
      code = "-1"
      type = "3"
    }
    protocol    = "1"
    source      = "10.10.0.0/16"
    source_type = "CIDR_BLOCK"
    stateless   = "false"
       
  }
  ingress_security_rules {
    protocol    = "6"
    source      = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    stateless   = "false"
    tcp_options {
      max = "25565"
      min = "25565"
    }
    
  }
  ingress_security_rules {
    protocol    = "17"
    source      = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    stateless   = "false"
    
    udp_options {
      max = "25565"
      min = "25565"
    
    }
  }
  manage_default_resource_id = oci_core_vcn.MinecraftVCN.default_security_list_id
}

