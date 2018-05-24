# virtual env

deactivate

mkdocs build

git checkout gh-pages

git add *

git commit -m "update master"

git push origin master
