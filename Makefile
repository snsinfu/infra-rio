ARTIFACTS = \
  terraform.tfstate \
  terraform.tfstate.backup \
  _init.ok \
  _server.ok \
  _provision.ok \
  _database.ok \
  _vars.json \
  _known_hosts \
  _output \
  _ssh_config \
  inventory/_terraform_hosts

.PHONY: all clean destroy

all: _provision.ok _ssh_config
	@:

clean: destroy
	rm -rf $(ARTIFACTS)

destroy:
	terraform destroy -auto-approve -var-file _vars.json
	@rm -f _server.ok

_init.ok:
	terraform init
	@touch $@

_server.ok: _init.ok _vars.json
	terraform apply -auto-approve -var-file _vars.json
	@touch $@

_provision.ok: _server.ok inventory/_terraform_hosts provision.yml
	ansible-playbook provision.yml
	@touch $@

_database.ok: _provision.ok database.yml
	ansible-playbook database.yml
	@touch $@

inventory/_terraform_hosts: _server.ok
	terraform output ansible_inventory > $@

_ssh_config: _server.ok
	terraform output ssh_config > $@

_vars.json:
	ansible-inventory --host rio | jq ".terraform" > $@
