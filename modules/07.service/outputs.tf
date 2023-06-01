output "ZONE_ID" {
    value = try(aws_route53_zone.ZONE[*].zone_id, null)
}

output "ZONE_NS" {
    value = try(aws_route53_zone.ZONE[*].name_servers, null)
}

output "EP_ID" {
    value = try(aws_route53_resolver_endpoint.RESOLV_EP[*].id, null)
}

output "LB_ID"{
    value = try(aws_lb.LB[*].id, null)
}

output "LB_TG_ID"{
    value = try(aws_lb_target_group.LB_TG[*].arn, null)
}

output "GAC_LS_ID" {
    value = try(aws_globalaccelerator_listener.GAC_LS[*].id, null)
}

output "RT53_DOMAIN" {
    value = try(aws_route53_record.ZONE_RECORD[*].fqdn, null)
}