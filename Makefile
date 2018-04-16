build:
	rm -rf public
	hugo

deploy: build
	git submodule update --init --recursive
	aws s3 sync public/ s3://earthtoernie.com --acl public-read --delete
	aws configure set preview.cloudfront true
	aws cloudfront create-invalidation --distribution-id E38GN7XRZF19S2 --paths '/*'