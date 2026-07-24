output "helm_repository_urls" {
  description = "URLs of all Helm chart repositories"

  value = {
    for service, repository in module.helm_repositories :
    service => repository.repository_url
  }
}
