run:
	source ../env/bin/activate
	mkdocs build
	git add *
	git commit -m "update master"
	git push origin master
	