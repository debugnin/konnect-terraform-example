

# Configure a service and a route that we can use to test
resource "konnect_gateway_service" "httpbin" {
  name             = "HTTPBin"
  protocol         = "https"
  host             = "httpbin.org"
  port             = 443
  path             = "/"
  control_plane_id = konnect_gateway_control_plane.tfdemo.id
}

resource "konnect_gateway_route" "anything" {
  methods = ["GET"]
  name    = "Anything"
  paths   = ["/anything"]

  strip_path = false

  control_plane_id = konnect_gateway_control_plane.tfdemo.id
  service = {
    id = konnect_gateway_service.httpbin.id
  }
}

resource "konnect_gateway_plugin_key_auth" "key-auth" {
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
  protocols = ["grpc", "grpcs", "http", "https"]

  route = {
    id = konnect_gateway_route.anything.id
  }

  control_plane_id = konnect_gateway_control_plane.tfdemo.id
}

# Create a consumer and a basic auth credential for that consumer
resource "konnect_gateway_consumer" "alice" {
  username         = "alice"
  custom_id        = "alice"
  control_plane_id = konnect_gateway_control_plane.tfdemo.id
}

# Then a consumer group, and add the consumer to a group
resource "konnect_gateway_consumer_group" "gold" {
  name             = "gold"
  control_plane_id = konnect_gateway_control_plane.tfdemo.id
}

resource "konnect_gateway_consumer_group_member" "ag" {
  consumer_id       = konnect_gateway_consumer.alice.id
  consumer_group_id = konnect_gateway_consumer_group.gold.id
  control_plane_id  = konnect_gateway_control_plane.tfdemo.id
}
