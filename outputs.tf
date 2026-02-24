output "instance_id" {
  value = aws_instance.my_instance.id
}

output "instance_public_ip" {
  value = aws_instance.my_instance.public_ip
}

output "instance_private_ip" {
  value = aws_instance.my_instance.private_ip
}
