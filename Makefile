REPO=andrewb3000/telsocket
VERSION=$$(git rev-parse --verify HEAD)
docker:
	docker build -t $(REPO):$(VERSION) .

push: docker
	docker tag $(REPO):$(VERSION) $(REPO):latest && \
		docker push $(REPO)
