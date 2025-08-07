resource "konnect_gateway_control_plane" "tfdemo" {
  name          = "Sample Control Plane"
  cluster_type  = "CLUSTER_TYPE_CONTROL_PLANE"
  description   = "Sample Cloud Control plane"
  auth_type     = "pinned_client_certs"
  proxy_urls    = []
}
