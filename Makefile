# Recipes for facilitating image building/publishing
INDEX=./releases.json
REPOSITORY=rtckit/freeswitch
RELEASES=$(shell jq -r 'keys_unsorted[] as $$r | "\($$r)/\(.[$$r] | keys_unsorted[])"' ${INDEX})

.PHONY: all
all: $(RELEASES)
	@echo "============================="
	@echo Built all releases: ${RELEASES}

.PHONY: $(RELEASES)
$(RELEASES): TAG_PATH=$(shell echo $@ | sed -r 's#(.+)/(.+)#."\1".\2.tags[]#')
$(RELEASES): TAGS=$(shell jq -r '${TAG_PATH} as $$t | "-t ${REPOSITORY}:\($$t)"' ${INDEX})
$(RELEASES):
	@echo Building $@ ...
	docker build ${TAGS} $@
	@echo "-----------------------------"
	@echo Done building $@

.PHONY: push
push:
	docker push ${REPOSITORY}
