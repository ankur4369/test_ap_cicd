output "instance_id" {
    description = "The ID of the created EC2 instance"
    value = aws_instance.example.id
}

output "public_ip" {
    description = "Public IP of the EC2 instance"
    value = aws_instance.example.public_ip
}

output "local_file_path" {
    description = "Path of the local file"
    value = local.filename
}

output "ssh_private_key_path" {
  value = local_file.private_key.filename
}

output "ssh_command" {
  value = "ssh -i ${local_file.private_key.filename} ec2-user@${aws_instance.example.public_ip}"
}
