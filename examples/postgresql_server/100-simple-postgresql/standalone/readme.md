You can test this module outside of a landingzone using

```bash
cd /tf/caf/examples/postgresql_server/100-simple-postgresql/standalone

terraform init

terraform plan \
  -var-file ../configuration.tfvars

```

To test this deployment in the example landingzone. Make sure the launchpad has been deployed first

```bash

rover \
  -lz /tf/caf/landingzones/caf_example \
  -var-folder  /tf/caf/examples/postgresql_server/100-simple-postgresql/ \
  -level level1 \
  -a plan

```