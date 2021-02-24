## Alibaba Cloud ACK
module "alibaba" {
  source  = "iac/k8s/alicloud"

  enable_alibaba = var.enable_alibaba

  ali_access_key = var.ali_access_key
  ali_secret_key = var.ali_secret_key

  ack_node_count = var.nodes
}

## AWS EKS
module "amazon" {
  source  = "iac/k8s/aws"

  enable_amazon = var.enable_amazon

}

## GCP GKE
module "google" {
  source  = "iac/k8s/google"

  enable_google = var.enable_google

  gcp_project = var.gcp_project

  gke_nodes = var.nodes
}

## Azure AKS
module "microsoft" {
  source  = "iac/k8s/azurerm"

  enable_microsoft = var.enable_microsoft

  az_tenant_id     = var.az_tenant_id
  az_client_id     = var.az_client_id
  az_client_secret = var.az_client_secret

  aks_nodes = var.nodes
}


# Create kubeconfig files in main module directory
# (will be created in submodule directories, too)

resource "local_file" "kubeconfigali" {
  count    = var.enable_alibaba ? 1 : 0
  content  = module.alibaba.kubeconfig_path_ali
  filename = "${path.module}/kubeconfig_ali"

  depends_on = [module.alibaba]
}

resource "local_file" "kubeconfigaws" {
  count    = var.enable_amazon ? 1 : 0
  content  = module.amazon.kubeconfig_path_aws
  filename = "${path.module}/kubeconfig_aws"

  depends_on = [module.amazon]
}


resource "local_file" "kubeconfiggke" {
  count    = var.enable_google ? 1 : 0
  content  = module.google.kubeconfig_path_gke
  filename = "${path.module}/kubeconfig_gke"

  depends_on = [module.google]
}

resource "local_file" "kubeconfigaks" {
  count    = var.enable_microsoft ? 1 : 0
  content  = module.microsoft.kubeconfig_path_aks
  filename = "${path.module}/kubeconfig_aks"

  depends_on = [module.microsoft]
}
