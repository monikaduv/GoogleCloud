set -ex

echo "*** Printing all variables ***"

echo "PROJECT_ID=${PROJECT_ID}"
echo "COMMIT_SHA=${COMMIT_SHA}"
echo "SHORT_SHA=${SHORT_SHA}"
echo "REPO_NAME=${REPO_NAME}"
echo "BRANCH_NAME=${BRANCH_NAME}"
echo "HEAD_BRANCH=${HEAD_BRANCH}"
echo "BASE_BRANCH=${BASE_BRANCH}"
echo "HEAD_REPO_URL=${HEAD_REPO_URL}"
echo "PR_NUMBER=${PR_NUMBER}"

#git config user.email "sample@example.com"

git clone "${BASE_REPO_URL}"
echo "Repo cloned successfully"
cd "${REPO_NAME}"
git fetch origin refs/pull/${PR_NUMBER}/head:validate#${PR_NUMBER}
echo "pull ref created"
git checkout validate#${PR_NUMBER}
if ! git merge --ff-only "origin/${BASE_BRANCH}"
then
  echo "PR#${PR_NUMBER} cannot be fast forwared automatically. Resolve conflicts manually"
  exit 1
fi

echo "PR#${PR_NUMBER} can be rebased successfully on ${BASE_BRANCH} branch."
