output "glue_job_name" {
    value = aws_glue_job.python_job.name
}

output "glue_trigger_name" {
    value = aws_glue_trigger.daily_trigger.name
}