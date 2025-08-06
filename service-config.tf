
resource "konnect_gateway_service" "avm_test_service" {
  enabled = true
  name = "api-test"
  connect_timeout = 60000
  host = "api-test.staging.example.com"
  port = 443
  protocol = "https"
  read_timeout = 60000
  retries = 5
  write_timeout = 70000

  control_plane_id = konnect_gateway_control_plane.tfdemo.id
}

resource "konnect_gateway_route" "heartbeat" {
  name = "v1-heartbeat"
  https_redirect_status_code = 426
  methods = ["GET"]
  path_handling = "v1"
  paths = ["/api/v1/heartbeat"]
  preserve_host = false
  protocols = ["https"]
  regex_priority = 0
  request_buffering = true
  response_buffering = true
  strip_path = false

  service = {
    id = konnect_gateway_service.avm_test_service.id
  }

  control_plane_id = konnect_gateway_control_plane.tfdemo.id
}

resource "konnect_gateway_plugin_key_auth" "heartbeat_key_auth" {
  enabled = true
  config = {
    hide_credentials = false
    identity_realms = [
      {
        scope = "cp"
      },
    ]
    key_in_body = false
    key_in_header = true
    key_in_query = false
    key_names = ["apikey"]
    run_on_preflight = true
  }
  protocols = ["grpc", "grpcs", "http", "https", "ws", "wss"]

  route = {
    id = konnect_gateway_route.heartbeat.id
  }

  control_plane_id = konnect_gateway_control_plane.tfdemo.id
}

resource "konnect_gateway_consumer" "machine_locke_test" {
  username = "machine-locke-test"

  control_plane_id = konnect_gateway_control_plane.tfdemo.id
}

resource "konnect_gateway_consumer" "realtime_avm_client" {
  username = "realtime-avm-client"
  custom_id = "client_id"

  control_plane_id = konnect_gateway_control_plane.tfdemo.id
}


