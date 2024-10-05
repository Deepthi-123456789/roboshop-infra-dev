resource "aws_lb" "app-alb" {
  name               = "${local.name}-${var.tags.component}"
  internal           =  false
  load_balancer_type = "application"
  security_groups    = [data.aws_ssm_parameter.web_alb_sg_id.value]
  subnets            = split(",",data.aws_ssm_parameter.public_subnet_ids.value)

  #enable_deletion_protection = true

  tags = merge(var.common_tags,var.tags)
}

##lisner
resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.front_end.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS13-1-2-2021-06"
  certificate_arn   = data.aws_ssm_parameter.acm_certificate_arn

   default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "hi,this response is from web alb using https"
      status_code  = "200"
    }
}
}
## record for 
module "records" {
  source  = "terraform-aws-modules/route53/aws//modules/records"

  zone_name = "pjdevops.online"

  records = [
    {
      name    = "web-${var.environment}"
      type    = "A"
      alias   = {
        name    = aws_lb.web_alb.dns_name
        zone_id = aws_lb.web_alb.zone_id
      }
    }
  ]
}