# get NATed IP to allow ssh only from terraform host
data "http" "myip" {
  url = "https://api.ipify.org"
}
