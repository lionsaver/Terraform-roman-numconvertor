resource "aws_cloudfront_distribution" "cf_dist" {
    enabled = true
    # default_root_object = "index.html"
    aliases = ["www.liondevops.click"]
    origin {
      domain_name = aws_instance.trf-ec2.public_dns
      origin_id = aws_instance.trf-ec2.public_dns
    custom_origin_config {
      http_port = "80"
      https_port = "443"
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
    }
    default_cache_behavior {
        allowed_methods        = ["GET", "HEAD", "OPTIONS", "PUT", "POST", "PATCH", "DELETE"]
        cached_methods         = ["GET", "HEAD", "OPTIONS"]
        target_origin_id = aws_instance.trf-ec2.public_dns
        viewer_protocol_policy = "redirect-to-https" 
        forwarded_values {
            headers      = ["origin"]
            query_string = true
            cookies {
                forward = "all"
      }
    }
  }
    restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
  tags = {
    Enviroment= "${local.tags}-development"
    }
  # viewer_certificate {
  #   cloudfront_default_certificate = true
    # ssl_support_method = "sni-only"
  
  viewer_certificate {
    acm_certificate_arn      = data.aws_acm_certificate.amazon_issued.arn
    ssl_support_method       = "sni-only"
    # minimum_protocol_version = "TLSv1.2_2018"
  }
}