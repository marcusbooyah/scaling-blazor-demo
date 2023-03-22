param(
  [string]$clusterId,
  [string]$registry,
  [switch]$build = $false
)


if (!$registry)
{
  $registry = "ghcr.io/marcusbooyah"

  Write-Host "Pushing image to: $registry"
}

dotnet publish scaling-blazor-demo.csproj -c Release -o .\bin\Release\7.0\publish
docker build -t $registry/scaling-blazor-demo .
docker push $registry/scaling-blazor-demo:latest

if (-not $?)
{
    throw "ERROR: Publish scaling-blazor-demo failed."
}
