#!/bin/bash
REPOSITORIES=vino
for repo in $REPOSITORIES; do
      TAGS=$(aws ecr --region $1 list-images --repository-name $repo | jq -r 'map(.[] | .imageTag) | join(" ")')
      for tag in $TAGS; do
           docker pull $3.dkr.ecr.$1.amazonaws.com/$repo:$tag
           echo "Pull complete"
           docker tag $3.dkr.ecr.$1.amazonaws.com/$repo:$tag $3.dkr.ecr.$2.amazonaws.com/vinod-temp:$tag
           echo "Tag complete"
           docker push $3.dkr.ecr.$2.amazonaws.com/vinod-temp:$tag
           echo "Push complete"
      done
done
