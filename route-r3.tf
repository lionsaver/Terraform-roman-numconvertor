# get hosted zone details
# terraform aws data hosted zone
data "aws_route53_zone" "hosted_zone" {
  name = var.domain_name
}

# create a record set in route 53
# terraform aws route 53 record
resource "aws_route53_record" "site_domain" {
  zone_id = data.aws_route53_zone.hosted_zone.zone_id
  name    = var.record_name
  type    = "A"
  # ttl = 300
  # records = [aws_cloudfront_distribution.cf_dist.name]
  # records = [www.liondevops.click]

#   alias {
#     name                   = 
#     zone_id                = 
#     evaluate_target_health = 
  alias {
    name                   = aws_cloudfront_distribution.cf_dist.domain_name
    zone_id                = aws_cloudfront_distribution.cf_dist.hosted_zone_id
    evaluate_target_health = true
  }

  
}

