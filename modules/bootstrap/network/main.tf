
### VPC
resource "google_compute_network" "x" {
  provider                      = google-beta
  project                       = var.project_id
  name                          = "${var.alias}"
  auto_create_subnetworks       = false
  mtu                           = 8896
  routing_mode                  = "GLOBAL"
  bgp_best_path_selection_mode  = "STANDARD"
  bgp_always_compare_med        = true
  bgp_inter_region_cost         = "ADD_COST_TO_MED"
}

### Peering allocation
resource "google_compute_global_address" "peering" {
  name          = "peering-reserved"
  address_type  = "INTERNAL"
  purpose       = "VPC_PEERING"
  network       = google_compute_network.x.id
  project       = var.project_id
  address       = var.peer_allocation
  prefix_length = 20
}

### Peering network hold
resource "google_service_networking_connection" "x" {
  network                 = google_compute_network.x.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.peering.name]
}

### SUBNETS 
resource "google_compute_subnetwork" "x" {
  for_each = var.vpc_config
  name                     = "${each.key}"
  ip_cidr_range            = each.value.vpc_subnet_cidr
  region                   = each.key
  project                  = var.project_id
  network                  = google_compute_network.x.id
  private_ip_google_access = true

  log_config {
    aggregation_interval   = var.logs_config.subnet.interval
    flow_sampling          = var.logs_config.subnet.samples
    metadata               = var.logs_config.subnet.metadata 
  }  
}


### FIREWALL
resource "google_compute_firewall" "rule" {
  for_each = var.firewall_config
  name    = "${each.key}"
  network = google_compute_network.x.id
  project = var.project_id

  allow {
    protocol = each.value.procotol
    ports    = each.value.ports
  }

  log_config {
    metadata = each.value.logs
  }

  priority = each.value.priority
  target_tags   = each.value.tags
  source_ranges = each.value.source
}

### NAT
resource "google_compute_address" "x" {
  for_each = var.vpc_config
  name   = "natip-${each.key}"
  region = each.key
  project = var.project_id
}

resource "google_compute_router" "x" {
  for_each = var.vpc_config
  name    = "router-${each.key}"
  region  = each.key
  project = var.project_id
  network = google_compute_network.x.id
}

resource "google_compute_router_nat" "x" {
  for_each = var.vpc_config
  name                               = "nat-${each.key}"
  router                             = google_compute_router.x[each.key].name
  region                             = each.key
  project                            = var.project_id
  nat_ip_allocate_option             = "MANUAL_ONLY"
  nat_ips                            = google_compute_address.x[each.key].*.self_link
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
  enable_endpoint_independent_mapping = false
  enable_dynamic_port_allocation = true

  log_config {
    enable = var.logs_config.router.enable
    filter = var.logs_config.router.filter
  }  
}
