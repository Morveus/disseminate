function _morveus-kubernetes-full-rollout
    kubectl get deployments --all-namespaces -o json | jq -c -r '.items[] | "\(.metadata.namespace) \(.metadata.name)"' | while read -l ns deployment
        kubectl rollout restart deployment $deployment -n $ns
    end
end

function morveus_scale_NASbound_deployments
    if test -z "$argv[1]"
        echo "Error: Argument 'scale' (a number) is missing."
        return 1
    end

    set REP $argv[1]

    echo "Scaling replicas to $REP for deployments accessing unRAID NAS"

    for DEP in (kubectl get deployments --all-namespaces -o yaml | grep -E "NAS_CIFS|MegaNAS" | grep "Deployment" | jq -r ".metadata.name")
        set NS (kubectl get deployments --all-namespaces | grep "$DEP" | awk '{print $1}' | uniq)
        echo "$DEP in $NS..."
        kubectl scale deployment $DEP --replicas="$REP" -n $NS
    end
end
