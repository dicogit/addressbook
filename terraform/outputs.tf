output "ip" {
    value = module.myown-instance.ec2[0].public_ip
}