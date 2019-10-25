/*
* Copyright 2019 Google LLC. This software is provided as is, without warranty
* or representation for any use or purpose. Your use of it is subject to your
* agreement with Google.
*/

# shared locals for gke
locals {
  host_project_id = ""

  network_name = "projects/${local.host_project_id}/global/networks/"
  subnet_name  = "projects/${local.host_project_id}/regions/${local.region}/subnetworks/${lookup(local.subnets_region_map[local.region], local.cluster_id)}"

  # gke locals
  gke_pods_secondary_range_name        = "${lookup(local.gke_pods_secondary_range_name_region_map[local.region], local.cluster_id)}"
  gke_services_secondary_range_name    = "${lookup(local.gke_services_secondary_range_name_region_map[local.region], local.cluster_id)}"
  location                             = "${local.region}"
  cluster_name                         = "iap-connector-${local.env}-${local.region}-${local.cluster_id}"
  cluster_service_acct_id              = "${lookup(local.cluster_service_acct_id_region_map[local.region], local.cluster_id)}"
  master_cidr_block                    = "${lookup(local.master_cidr_block_region_map[local.region],local.cluster_id)}"
  master_authorized_network            = "${local.master_authorized_network_cluster_map[local.cluster_id]}"
  gke_node_tags                        = ["gke-iap", "${local.env}", "${local.region}", "${local.cluster_id}"]
  primary_initial_node_count_per_zone  = "${lookup(local.primary_initial_node_count_per_zone_region_map[local.region], local.cluster_id)}"
  gke_nodes_machine_type               = "${lookup(local.gke_nodes_machine_type_region_map[local.region], local.cluster_id)}"
  enable_autoscaling                   = true
  primary_max_node_count               = "${lookup(local.primary_max_node_count_region_map[local.region], local.cluster_id)}"
  primary_min_node_count               = "${lookup(local.primary_min_node_count_region_map[local.region], local.cluster_id)}"
  secondary_intial_node_count_per_zone = "${lookup(local.secondary_initial_node_count_per_zone_region_map[local.region], local.cluster_id)}"
  secondary_max_node_count             = "${lookup(local.secondary_max_node_count_region_map[local.region], local.cluster_id)}"
  secondary_min_node_count             = "${lookup(local.secondary_min_node_count_region_map[local.region], local.cluster_id)}"
  disable_horizontal_pod_autoscaling   = false
  max_pods_per_node                    = "${lookup(local.max_pods_per_node_region_map[local.region], local.cluster_id)}"
  gke_nodes_disk_size_gb               = "50"
  gke_node_list_of_roles               = ["monitoring.editor", "logging.logWriter"]
  gke_network_name                     = "${local.network_name}"
  gke_subnet_name                      = "${local.subnet_name}"

  //gke locals region maps
  // We need these because Terraform doesn't fully support nested maps. These flatten the maps by one level

  subnets_region_map                           = "${local.subnets_map[local.env]}"
  gke_pods_secondary_range_name_region_map     = "${local.gke_pods_secondary_range_name_map[local.env]}"
  gke_services_secondary_range_name_region_map = "${local.gke_services_secondary_range_name_map[local.env]}"
  cluster_service_acct_id_region_map           = "${local.cluster_service_acct_id_map[local.env]}"
  master_cidr_block_region_map                 = "${local.master_cidr_block_map[local.env]}"
  master_authorized_network_region_map         = "${local.master_authorized_network_map[local.env]}"
  # We need to flatten this one level more since master authorized network values are a map
  master_authorized_network_cluster_map            = "${local.master_authorized_network_region_map[local.region]}"
  primary_initial_node_count_per_zone_region_map   = "${local.primary_initial_node_count_per_zone_map[local.env]}"
  gke_nodes_machine_type_region_map                = "${local.gke_nodes_machine_type_map[local.env]}"
  primary_max_node_count_region_map                = "${local.primary_max_node_count_map[local.env]}"
  primary_min_node_count_region_map                = "${local.primary_min_node_count_map[local.env]}"
  secondary_initial_node_count_per_zone_region_map = "${local.secondary_initial_node_count_per_zone_map[local.env]}"
  secondary_max_node_count_region_map              = "${local.secondary_max_node_count_map[local.env]}"
  secondary_min_node_count_region_map              = "${local.secondary_min_node_count_map[local.env]}"
  max_pods_per_node_region_map                     = "${local.max_pods_per_node_map[local.env]}"

  /*
   * To list availabe versions in a zone use: gcloud container get-server-config --zone <zone>
   * Example: gcloud container get-server-config --zone us-east4-a
   * Later gke versions may be available in different zones. You should check
   * all zones in a region.
   *
   * Since we want to use container native load balancing, we must use versions
   * listed on https://cloud.google.com/kubernetes-engine/docs/how-to/container-native-load-balancing#pod_readiness
   * Basically (as of 2019-09-23)
   * v1.13 GKE clusters running v1.13.8 and higher
   * and v1.14 GKE clusters running v1.14.4 and higher
   */

  gke_version = "1.14.6-gke.1"
  # The following locals are nested maps for environment to region to cluster id
  # This allows us to have a location where we can update values and reuse code
  # for what is potentially 20 clusters (1 dev, 1 stage, and 3 prod per region with 4 regions)
  subnets_map = {
    dev = {
      us-east4 = {
        cluster-a = ""
      }
    }

    stage = {
      us-east4 = {
        cluster-a = ""
      }
    }

    prod = {
      us-east4 = {
        cluster-a = ""
      }
    }
  }
  # The name for the secondary range for the subnet for pods. Google will
  # sometimes use the term 'cluster' instead of 'pods' in their api calls.
  gke_pods_secondary_range_name_map = {
    dev = {
      us-east4 = {
        cluster-a = ""
      }
    }

    stage = {
      us-east4 = {
        cluster-a = ""
      }
    }
    
    prod = {
      us-east4 = {
        cluster-a = ""
      }
    }
  }
  # The name for the secondary range for the subnet for services
  gke_services_secondary_range_name_map = {
    dev = {
      us-east4 = {
        cluster-a = ""
      }
    }

    stage = {
      us-east4 = {
        cluster-a = ""
      }
    }
    
    prod = {
      us-east4 = {
        cluster-a = ""
      }
    }
  }
  # service account ids must be 6-30 characters
  # This is the service account id used by the cluster nodes.
  cluster_service_acct_id_map = {
    dev = {
      us-east4 = {
        cluster-a = ""
      }
    }

    stage = {
      us-east4 = {
        cluster-a = ""
      }
    }

    prod = {
      us-east4 = {
        cluster-a = ""
      }
    }
  }
  # Cidr block for the master gke nodes. This is used by Google's network.
  master_cidr_block_map = {
    dev = {
      us-east4 = {
        cluster-a = ""
      }
    }

    stage = {
      us-east4 = {
        cluster-a = ""
      }
    }

    prod = {
      us-east4 = {
        cluster-a = ""
      }
    }
  }
  # The ips that are allowed to use the kubernetes api, e.g. kubectl commands.
  # Kubernetes api are only allowed by users with IAM permissions to use the api
  master_authorized_network_map = {
    dev = {
      us-east4 = {
        cluster-a = {
          display_name = ""
          cidr_block   = ""
        }
      }
    }

    stage = {
      us-east4 = {
        cluster-a = {
          display_name = ""
          cidr_block   = ""
        }
      }
    }

    prod = {
      us-east4 = {
        cluster-a = {
          display_name = ""
          cidr_block   = ""
        }
      }
    }
  }
  # initial node count is for the primary node pool. After the initial nodes
  # are created, then autoscaling rules kick in.
  primary_initial_node_count_per_zone_map = {
    dev = {
      us-east4 = {
        cluster-a = "1"
      }
    }

    stage = {
      us-east4 = {
        cluster-a = "1"
      }
    }

    prod = {
      us-east4 = {
        cluster-a = "1"
      }
    }
  }
  # The compute engine machine type for the gke nodes
  gke_nodes_machine_type_map = {
    dev = {
      us-east4 = {
        cluster-a = "n1-standard-16"
      }
    }

    stage = {
      us-east4 = {
        cluster-a = "n1-highcpu-32"
      }
    }

    prod = {
      us-east4 = {
        cluster-a = "n1-highcpu-32"
      }
    }
  }
  # max node count for autoscaling for the primary node pool per zone
  primary_max_node_count_map = {
    dev = {
      us-east4 = {
        cluster-a = "6"
      }
    }

    stage = {
      us-east4 = {
        cluster-a = "6"
      }
    }

    prod = {
      us-east4 = {
        cluster-a = "6"
      }
    }
  }
  # The minimum node count for autoscaling for the primary node pool
  primary_min_node_count_map = {
    dev = {
      us-east4 = {
        cluster-a = "1"
      }
    }

    stage = {
      us-east4 = {
        cluster-a = "1"
      }
    }

    prod = {
      us-east4 = {
        cluster-a = "1"
      }
    }
  }

  # values for the secondary node pool. Secondary node pool is used in case we
  # need a second node pool, e.g. upgrades

  # The initial node count per zone for the secondary node pool
  secondary_initial_node_count_per_zone_map = {
    dev = {
      us-east4 = {
        cluster-a = "0"
      }
    }

    stage = {
      us-east4 = {
        cluster-a = "0"
      }
    }

    prod = {
      us-east4 = {
        cluster-a = "0"
      }
    }
  }
  # The maximum node count for autoscaling for the secondary node pool
  secondary_max_node_count_map = {
    dev = {
      us-east4 = {
        cluster-a = "6"
      }
    }

    stage = {
      us-east4 = {
        cluster-a = "6"
      }
    }

    prod = {
      us-east4 = {
        cluster-a = "6"
      }
    }
  }
  # The minimum node count for autoscaling for the secondary primary node pool
  secondary_min_node_count_map = {
    dev = {
      us-east4 = {
        cluster-a = "0"
      }
    }

    stage = {
      us-east4 = {
        cluster-a = "0"
      }
    }

    prod = {
      us-east4 = {
        cluster-a = "0"
      }
    }
  }
  # Maxiumum pods per node. This sets the default maximum pods per node and the
  # maximum pods per node for primary and secondary node pools.
  max_pods_per_node_map = {
    dev = {
      us-east4 = {
        cluster-a = "16"
      }
    }

    stage = {
      us-east4 = {
        cluster-a = "16"
      }
    }

    prod = {
      us-east4 = {
        cluster-a = "16"
      }
    }
  }
}
