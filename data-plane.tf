resource "konnect_gateway_data_plane_client_certificate" "example_ca_cert" {
  cert = file("./cert/ca.crt")
  control_plane_id = konnect_gateway_control_plane.tfdemo.id
}