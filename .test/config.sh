#!/usr/bin/env bash

# https://github.com/docker-library/official-images/blob/3e27b6eb7a12bc15e5e2dde52d2477c818863ce3/test/config.sh

imageTests+=(
	[khulnasoft/true]='true'

	# run containerd test on containerd-containing images :D
	[khulnasoft/containerd]='c8dind'
	[khulnasoft/docker-master]='c8dind'
	[khulnasoft/infosiftr-moby]='c8dind'
	[infosiftr/moby]='c8dind'

	# make sure our buildkit image works correctly with buildx
	[khulnasoft/buildkit]='buildkitd'

	# avoid: java.lang.UnsatisfiedLinkError: /opt/java/openjdk/lib/libfontmanager.so: libfreetype.so.6: cannot open shared object file: No such file or directory
	[khulnasoft/jenkins]='java-uimanager-font'
)

globalExcludeTests+=(
	# single-binary images
	[khulnasoft/sleeping-beauty_no-hard-coded-passwords]=1
	[khulnasoft/sleeping-beauty_utc]=1
	[khulnasoft/true_no-hard-coded-passwords]=1
	[khulnasoft/true_utc]=1
)

# run Docker tests on Docker images :D
testAlias+=(
	[khulnasoft/docker-master]='docker:dind'
	[khulnasoft/infosiftr-moby]='docker:dind'
	[infosiftr/moby]='docker:dind'
)
# the "docker-registry-push-pull" test isn't very good at detecting whether our custom image is dind or registry O:)
globalExcludeTests+=(
	[khulnasoft/docker-master_docker-registry-push-pull]=1
	[khulnasoft/infosiftr-moby_docker-registry-push-pull]=1
	[infosiftr/moby_docker-registry-push-pull]=1
)

# Cygwin looks like Unix, but fails in cute ways (host timezone instead of "UTC" because Windows, can't scrape "/etc/passwd" because --user)
globalExcludeTests+=(
	[khulnasoft/cygwin_no-hard-coded-passwords]=1
	[khulnasoft/cygwin_utc]=1
)
