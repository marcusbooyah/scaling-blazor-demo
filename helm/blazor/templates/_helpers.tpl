{{/*
Expand the name of the chart.
*/}}
{{- define "blazor.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "blazor.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}


{{- define "signalr-proxy.fullname" -}}
{{- printf "%s-signalr-proxy" (include "blazor.fullname" .) }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "blazor.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "blazor.labels" -}}
helm.sh/chart: {{ include "blazor.chart" . }}
{{ include "blazor.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "blazor.selectorLabels" -}}
app.kubernetes.io/name: {{ include "blazor.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "blazor.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "blazor.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}



{{/*
Set dotnet env vars
{{ printf "%x" (div int(.Values.resources.requests.memory 4) | quote }}

*/}}
{{- define "dotnet.gc.heapHardLimit" -}}
{{- if .Values.resources.requests }}
{{- printf "%s" .Values.resources.requests.memory }}
{{- else }}
{{- printf "0xf00000" }}
{{- end }}
{{- end }}
