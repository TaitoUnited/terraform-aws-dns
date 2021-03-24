# AWS DNS

Example usage:

```
provider "aws" {
  region = "us-east-1"
}

module "dns" {
  source       = "TaitoUnited/dns/aws"
  version      = "1.0.0"

  dns_zones    = yamldecode(file("${path.root}/../infra.yaml"))["dnsZones"]
}
```

Example YAML:

```
dnsZones:
  - dnsName: mydomain.com
    recordSets:
      - dnsName: www.mydomain.com
        type: A
        ttl: "3600"
        values: ["127.127.127.127"]
      - dnsName: myapp.mydomain.com
        type: CNAME
        ttl: "43200"
        values: ["myapp.otherdomain.com"]
```

YAML attributes:

- See variables.tf for all the supported YAML attributes.
- See [route53_zone](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_zone) and [route53_record](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) for attribute descriptions.

Combine with the following modules to get a complete infrastructure defined by YAML:

- [Admin](https://registry.terraform.io/modules/TaitoUnited/admin/aws)
- [DNS](https://registry.terraform.io/modules/TaitoUnited/dns/aws)
- [Network](https://registry.terraform.io/modules/TaitoUnited/network/aws)
- [Kubernetes](https://registry.terraform.io/modules/TaitoUnited/kubernetes/aws)
- [Databases](https://registry.terraform.io/modules/TaitoUnited/databases/aws)
- [Storage](https://registry.terraform.io/modules/TaitoUnited/storage/aws)
- [Monitoring](https://registry.terraform.io/modules/TaitoUnited/monitoring/aws)
- [Integrations](https://registry.terraform.io/modules/TaitoUnited/integrations/aws)
- [PostgreSQL privileges](https://registry.terraform.io/modules/TaitoUnited/privileges/postgresql)
- [MySQL privileges](https://registry.terraform.io/modules/TaitoUnited/privileges/mysql)

Similar modules are also available for Azure, Google Cloud, and DigitalOcean. All modules are used by [infrastructure templates](https://taitounited.github.io/taito-cli/templates#infrastructure-templates) of [Taito CLI](https://taitounited.github.io/taito-cli/). TIP: See also [AWS project resources](https://registry.terraform.io/modules/TaitoUnited/project-resources/aws), [Full Stack Helm Chart](https://github.com/TaitoUnited/taito-charts/blob/master/full-stack), and [full-stack-template](https://github.com/TaitoUnited/full-stack-template).

Contributions are welcome!
