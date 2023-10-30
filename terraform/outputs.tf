output "ip" {
    value = module.myown-instance.ectype[0].public_ip
}