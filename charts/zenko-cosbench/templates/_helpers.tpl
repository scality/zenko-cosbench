{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "cosbench.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "cosbench-controller.fullname" -}}
{{- $name := default .Chart.Name .Values.controller.name -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "cosbench-driver.fullname" -}}
{{- $name := default .Chart.Name .Values.driver.name -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a comma seperated list of drivers
*/}}
{{- define "cosbench-drivers" -}}
{{- $count := (atoi (printf "%d" (int64 .Values.driver.replicaCount))) -}}
{{ range $v := until $count }}{{ .Release.Name }}-cosbench-driver-{{ $v }}.{{ .Release.Name }}-cosbench-driver{{ if ne $v (sub $count 1) }},{{end}}{{end}}
{{- end -}}
