{{- define "webapp-chart.name" -}}
{{ .Chart.Name }}
{{- end }}

{{- define "webapp-chart.fullname" -}}
{{ .Release.Name }}-{{ .Chart.Name }}
{{- end }}
