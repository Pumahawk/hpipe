{{/*
Create a default service account name
*/}}
{{- define "hpipe-chart.serviceAccountName" -}}
{{ .Release.Name }}-hpipe-sa
{{- end -}}

