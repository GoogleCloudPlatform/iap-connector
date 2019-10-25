# Copyright 2019 Google LLC
#
# This software is provided as is, without warranty or representation for any
# use or purpose. Your use of it is subject to your agreement with Google.

"""Create configuration to deploy GKE cluster."""


def GenerateConfig(context):
  """Generate YAML resource configuration."""

  name_prefix = context.env['deployment'] + '-' + context.env['name']
  cluster_name = name_prefix
  regular_type_name = name_prefix + '-type'
  service_type_name = name_prefix + '-service-type'
  k8s_endpoints = {
      '': 'api/v1',
      '-apps': 'apis/apps/v1beta1',
      '-v1beta1-extensions': 'apis/extensions/v1beta1',
      '-v1beta1-rbac-authorization': 'apis/rbac.authorization.k8s.io/v1beta1'
  }

  resources = [{
      'name': cluster_name,
      'type': 'container.v1.cluster',
      'properties': {
          'zone': context.properties['zone'],
          'cluster': {
              'name':
                  cluster_name,
              'network': context.properties['network'],
              'subnetwork': context.properties['subnetwork'],
              'ipAllocationPolicy': {
                  'useIpAliases': context.properties['useIpAliases'],
                  'clusterSecondaryRangeName': context.properties['clusterSecondaryRangeName'],
                  'servicesSecondaryRangeName': context.properties['servicesSecondaryRangeName']
              },
              'initialNodeCount':
                  context.properties['initialNodeCount'],
              'nodeConfig': {
                  'machineType': context.properties['machineType'],
                  'preemptible': context.properties['preemptible'],
                  'oauthScopes': [
                      'https://www.googleapis.com/auth/' + s for s in [
                          'compute', 'devstorage.read_only', 'logging.write',
                          'monitoring'
                      ]
                  ]
              }
          }
      }
  }]

  k8s_resource_types = []
  k8s_resource_types.append(service_type_name)
  resources.append({
      'name': service_type_name,
      'type': 'deploymentmanager.v2beta.typeProvider',
      'properties': {
          'options': {
              'validationOptions': {
                  # Kubernetes API accepts ints, in fields they annotate
                  # with string. This validation will show as warning
                  # rather than failure for Deployment Manager.
                  # https://github.com/kubernetes/kubernetes/issues/2971
                  'schemaValidation': 'IGNORE_WITH_WARNINGS'
              },
              # According to kubernetes spec, the path parameter 'name'
              # should be the value inside the metadata field
              # https://github.com/kubernetes/community/blob/master
              # /contributors/devel/api-conventions.md
              # This mapping specifies that
              'inputMappings': [{
                  'fieldName': 'name',
                  'location': 'PATH',
                  'methodMatch': '^(GET|DELETE|PUT)$',
                  'value': '$.ifNull('
                           '$.resource.properties.metadata.name, '
                           '$.resource.name)'
              }, {
                  'fieldName': 'metadata.name',
                  'location': 'BODY',
                  'methodMatch': '^(PUT|POST)$',
                  'value': '$.ifNull('
                           '$.resource.properties.metadata.name, '
                           '$.resource.name)'
              }, {
                  'fieldName': 'Authorization',
                  'location': 'HEADER',
                  'value': '$.concat("Bearer ",'
                           '$.googleOauth2AccessToken())'
              }, {
                  'fieldName': 'spec.clusterIP',
                  'location': 'BODY',
                  'methodMatch': '^(PUT)$',
                  'value': '$.resource.self.spec.clusterIP'
              }, {
                  'fieldName': 'metadata.resourceVersion',
                  'location': 'BODY',
                  'methodMatch': '^(PUT)$',
                  'value': '$.resource.self.metadata.resourceVersion'
              }, {
                  'fieldName': 'spec.ports',
                  'location': 'BODY',
                  'methodMatch': '^(PUT)$',
                  'value': '$.resource.self.spec.ports'
              }]
          },
          'descriptorUrl':
              ''.join([
                  'https://$(ref.', cluster_name, '.endpoint)/swaggerapi/',
                  'api/v1'
              ])
      }
  })

  for type_suffix, endpoint in k8s_endpoints.iteritems():
    k8s_resource_types.append(regular_type_name + type_suffix)
    resources.append({
        'name': regular_type_name + type_suffix,
        'type': 'deploymentmanager.v2beta.typeProvider',
        'properties': {
            'options': {
                'validationOptions': {
                    # Kubernetes API accepts ints, in fields they annotate
                    # with string. This validation will show as warning
                    # rather than failure for Deployment Manager.
                    # https://github.com/kubernetes/kubernetes/issues/2971
                    'schemaValidation': 'IGNORE_WITH_WARNINGS'
                },
                # According to kubernetes spec, the path parameter 'name'
                # should be the value inside the metadata field
                # https://github.com/kubernetes/community/blob/master
                # /contributors/devel/api-conventions.md
                # This mapping specifies that
                'inputMappings': [{
                    'fieldName': 'name',
                    'location': 'PATH',
                    'methodMatch': '^(GET|DELETE|PUT)$',
                    'value': '$.ifNull('
                             '$.resource.properties.metadata.name, '
                             '$.resource.name)'
                }, {
                    'fieldName': 'metadata.name',
                    'location': 'BODY',
                    'methodMatch': '^(PUT|POST)$',
                    'value': '$.ifNull('
                             '$.resource.properties.metadata.name, '
                             '$.resource.name)'
                }, {
                    'fieldName': 'Authorization',
                    'location': 'HEADER',
                    'value': '$.concat("Bearer ",'
                             '$.googleOauth2AccessToken())'
                }]
            },
            'descriptorUrl':
                ''.join([
                    'https://$(ref.', cluster_name, '.endpoint)/swaggerapi/',
                    endpoint
                ])
        }
    })

  cluster_regular_type_root = ''.join(
      [context.env['project'], '/', regular_type_name])
  cluster_service_type_root = ''.join(
      [context.env['project'], '/', service_type_name])
  cluster_types = {
      'Service':
          ''.join([
              cluster_service_type_root, ':',
              '/api/v1/namespaces/{namespace}/services'
          ]),
      'ServiceAccount':
          ''.join([
              cluster_regular_type_root, ':',
              '/api/v1/namespaces/{namespace}/serviceaccounts'
          ]),
      'Deployment':
          ''.join([
              cluster_regular_type_root, '-v1beta1-extensions', ':',
              '/apis/extensions/v1beta1/namespaces/{namespace}/deployments'
          ]),
      'ClusterRole':
          ''.join([
              cluster_regular_type_root, '-v1beta1-rbac-authorization', ':',
              '/apis/rbac.authorization.k8s.io/v1beta1/clusterroles'
          ]),
      'ClusterRoleBinding':
          ''.join([
              cluster_regular_type_root, '-v1beta1-rbac-authorization', ':',
              '/apis/rbac.authorization.k8s.io/v1beta1/clusterrolebindings'
          ]),
      'Ingress':
          ''.join([
              cluster_regular_type_root, '-v1beta1-extensions', ':',
              '/apis/extensions/v1beta1/namespaces/{namespace}/ingresses'
          ]),
  }

  resources.append({
      'name': name_prefix + '-rbac-admin-clusterrolebinding',
      'type': cluster_types['ClusterRoleBinding'],
      'metadata': {
          'dependsOn': k8s_resource_types
      },
      'properties': {
          'apiVersion':
              'rbac.authorization.k8s.io/v1beta1',
          'kind':
              'ClusterRoleBinding',
          'namespace':
              'default',
          'metadata': {
              'name': 'rbac-cluster-admin',
          },
          'roleRef': {
              'apiGroup': 'rbac.authorization.k8s.io',
              'kind': 'ClusterRole',
              'name': 'cluster-admin',
          },
          'subjects': [{
              'kind': 'User',
              'name': context.properties['serviceAccountName'],
              'apiGroup': 'rbac.authorization.k8s.io',
          }],
      }
  })

  resources.extend([{
      'name': name_prefix + '-service',
      'type': cluster_types['Service'],
      'metadata': {
          'dependsOn': [name_prefix + '-rbac-admin-clusterrolebinding']
      },
      'properties': {
          'apiVersion': 'v1',
          'kind': 'Service',
          'namespace': 'default',
          'metadata': {
              'name': 'ambassador-admin',
              'labels': {
                  'service': 'ambassador-admin'
              }
          },
          'spec': {
              'type':
                  'NodePort',
              'ports': [{
                  'name': 'ambassador-admin',
                  'port': 8877,
                  'targetPort': 8877,
              }],
              'selector': {
                  'service': 'ambassador',
              }
          }
      }
  }, {
      'name': name_prefix + '-clusterrole',
      'type': cluster_types['ClusterRole'],
      'metadata': {
          'dependsOn': [name_prefix + '-rbac-admin-clusterrolebinding']
      },
      'properties': {
          'apiVersion':
              'rbac.authorization.k8s.io/v1beta1',
          'kind':
              'ClusterRole',
          'namespace':
              'default',
          'metadata': {
              'name': 'ambassador',
          },
          'rules': [{
              'apiGroups': [''],
              'resources': ['services'],
              'verbs': ['get', 'list', 'watch']
          }, {
              'apiGroups': [''],
              'resources': ['configmaps'],
              'verbs': ['create', 'update', 'patch', 'get', 'list', 'watch']
          }, {
              'apiGroups': [''],
              'resources': ['secrets'],
              'verbs': ['get', 'list', 'watch']
          }]
      }
  }, {
      'name': name_prefix + '-serviceaccount',
      'type': cluster_types['ServiceAccount'],
      'metadata': {
          'dependsOn': [name_prefix + '-rbac-admin-clusterrolebinding']
      },
      'properties': {
          'apiVersion': 'v1',
          'kind': 'ServiceAccount',
          'namespace': 'default',
          'metadata': {
              'name': 'ambassador',
          },
      }
  }, {
      'name': name_prefix + '-clusterrolebinding',
      'type': cluster_types['ClusterRoleBinding'],
      'metadata': {
          'dependsOn': [name_prefix + '-rbac-admin-clusterrolebinding']
      },
      'properties': {
          'apiVersion':
              'rbac.authorization.k8s.io/v1beta1',
          'kind':
              'ClusterRoleBinding',
          'namespace':
              'default',
          'metadata': {
              'name': 'ambassador',
          },
          'roleRef': {
              'apiGroup': 'rbac.authorization.k8s.io',
              'kind': 'ClusterRole',
              'name': 'ambassador',
          },
          'subjects': [{
              'kind': 'ServiceAccount',
              'name': 'ambassador',
              'namespace': 'default',
          }],
      }
  }, {
      'name': name_prefix + '-deployment',
      'type': cluster_types['Deployment'],
      'metadata': {
          'dependsOn': [name_prefix + '-rbac-admin-clusterrolebinding']
      },
      'properties': {
          'apiVersion': 'extensions/v1beta1',
          'kind': 'Deployment',
          'namespace': 'default',
          'metadata': {
              'name': 'ambassador'
          },
          'spec': {
              'replicas': context.properties['replicas'],
              'template': {
                  'metadata': {
                      'annotations': {
                          'sidecar.istio.io/inject': 'false'
                      },
                      'labels': {
                          'service': 'ambassador'
                      }
                  },
                  'spec': {
                      'serviceAccountName':
                          'ambassador',
                      'containers': [{
                          'name':
                              'ambassador',
                          'image':
                              'quay.io/datawire/ambassador:' +
                              context.properties['imageVersion'],
                          'ports': [{'containerPort': 80}],
                          'resources': {
                              'limits': {
                                  'cpu': '1',
                                  'memory': '400Mi'
                              },
                              'requests': {
                                  'cpu': '200m',
                                  'memory': '100Mi'
                              },
                          },
                          'env': [{
                              'name': 'AMBASSADOR_NAMESPACE',
                              'valueFrom': {
                                  'fieldRef': {
                                      'fieldPath': 'metadata.namespace'
                                  }
                              },
                          }],
                          'livenessProbe': {
                              'httpGet': {
                                  'path': '/ambassador/v0/check_alive',
                                  'port': 80
                              },
                              'initialDelaySeconds': 30,
                              'periodSeconds': 3,
                          },
                          'readinessProbe': {
                              'httpGet': {
                                  'path': '/ambassador/v0/check_ready',
                                  'port': 80
                              },
                              'initialDelaySeconds': 30,
                              'periodSeconds': 3,
                          }
                      }],
                      'restartPolicy': 'Always',
                  },
              }
          }
      }
  }])

  ambassador_config_template = ('---\n'
                                'apiVersion: ambassador/v0\n'
                                'kind: Mapping\n'
                                'name: {0}_mapping\n'
                                'prefix: /\n'
                                'host: {1}\n'
                                'service: https://{2}:443\n'
                                'host_rewrite: {2}\n'
                                'tls: True\n')

  # create services
  ingress_sepc_rules = []
  for routing_obj in context.properties['routing']:
    ambassador_config = ''
    for mapping_obj in routing_obj['mapping']:
      ambassador_config = ambassador_config + ambassador_config_template.format(
          routing_obj['name'] + mapping_obj['name'], mapping_obj['source'],
          mapping_obj['destination'])
      ingress_sepc_rules.append({
          'host': mapping_obj['source'],
          'http': {
              'paths': [{
                  'path': '/*',
                  'backend': {
                      'serviceName': routing_obj['name'],
                      'servicePort': 80,
                  },
              }],
          },
      })

    resources.append({
        'name': name_prefix + '-' + routing_obj['name'] + '-service',
        'type': cluster_types['Service'],
        'metadata': {
            'dependsOn': [name_prefix + '-rbac-admin-clusterrolebinding']
        },
        'properties': {
            'apiVersion': 'v1',
            'kind': 'Service',
            'namespace': 'default',
            'metadata': {
                'name': routing_obj['name'],
                'labels': {
                    'service': 'ambassador'
                },
                'annotations': {
                    'getambassador.io/config': ambassador_config,
                },
            },
            'spec': {
                'type':
                    'NodePort',
                'ports': [{
                    'name': routing_obj['name'] + '-http',
                    'port': 80,
                    'targetPort': 80,
                }],
                'selector': {
                    'service': 'ambassador',
                }
            }
        }
    })

  resources.append({
      'name': name_prefix + '-ingress',
      'type': cluster_types['Ingress'],
      'metadata': {
          'dependsOn': [name_prefix + '-rbac-admin-clusterrolebinding']
      },
      'properties': {
          'apiVersion': 'extensions/v1beta1',
          'kind': 'Ingress',
          'namespace': 'default',
          'metadata': {
              'name': name_prefix + '-ingress',
              'annotations': {
                  'ingress.gcp.kubernetes.io/pre-shared-cert':
                      ','.join(context.properties['tls']),
              },
          },
          'spec': {
              'rules': ingress_sepc_rules,
          }
      }
  })

  return {'resources': resources}
