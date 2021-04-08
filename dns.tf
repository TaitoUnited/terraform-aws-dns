/**
 * Copyright 2021 Taito United
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

resource "aws_route53_zone" "dns_zone" {
  for_each          = {for item in local.dnsZones: item.name => item}

  name              = each.value.dnsName
  force_destroy     = false
  delegation_set_id = each.value.delegationSetId

  tags              = var.tags

  dynamic "vpc" {
    for_each = each.value.privateNetworks
    content {
      vpc_id     = each.value.id
      vpc_region = each.value.region
    }
  }
}

data "aws_route53_zone" "dns_zone" {
  depends_on   = [aws_route53_zone.dns_zone]
  for_each      = {for item in local.dnsZoneRecordSets: item.key => item}

  name         = each.value.dnsZone.dnsName
  private_zone = length(coalesce(each.value.dnsZone.privateNetworks, [])) > 0
}

resource "aws_route53_record" "dns_record_set" {
  depends_on    = [aws_route53_zone.dns_zone]
  for_each      = {for item in local.dnsZoneRecordSets: item.key => item}

  zone_id = data.aws_route53_zone.dns_zone[each.key].id

  name    = each.value.dnsName
  type    = each.value.type
  ttl     = each.value.ttl
  records = each.value.values
}
