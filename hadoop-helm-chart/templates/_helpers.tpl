{{/*
Helper template to generate names for resources
*/}}

{{- define "hadoop.fullname" -}}
{{- printf "%s-%s" .Release.Name .Chart.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Helper template to generate labels for resources
*/}}

{{- define "hadoop.labels" -}}
app: {{ include "hadoop.fullname" . }}
release: {{ .Release.Name }}
chart: {{ .Chart.Name }}-{{ .Chart.Version | replace "+" "_" }}
{{- end -}}

{{/*
Helper template to generate resource requests and limits
*/}}

{{- define "hadoop.resources" -}}
resources:
  requests:
    cpu: "100m"
    memory: "256Mi"
  limits:
    cpu: "500m"
    memory: "512Mi"
{{- end -}}