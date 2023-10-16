function _morveus-kubernetes-full-rollout
    kubectl get deployments --all-namespaces -o json | jq -c -r '.items[] | "\(.metadata.namespace) \(.metadata.name)"' | while read -l ns deployment
        kubectl rollout restart deployment $deployment -n $ns
    end
end
