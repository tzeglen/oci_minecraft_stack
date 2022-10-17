variable compartment_ocid {}
variable region {}
variable availability_domain {}
variable ssh_authorized_keys {}
variable memory_count {}
variable ocpu_count {}

variable "InstanceImageOCID" {
    type = map
    default = {
        // See https://docs.us-phoenix-1.oraclecloud.com/images/
        // Oracle-provided image "Oracle-Linux-7.4-2018.02.21-1"
        us-phoenix-1 = "ocid1.image.oc3.us-gov-phoenix-1.aaaaaaaa6uais5jgplip7eugdn3rxzpdezope5jxs7kxigg5rz22itfshwhq"
        eu-amsterdam-1 = "ocid1.image.oc1.eu-amsterdam-1.aaaaaaaa77lg57by5mxnxz6laei46cmqpaapef5povuutfkrcr7frllc5qwa"
        eu-frankfurt-1 = "ocid1.image.oc1.eu-frankfurt-1.aaaaaaaaajkxjdpgfzjl7tg3a7vzdvwnww6w5k47r5acwe4fqecowqwuoria"
        uk-london-1 = "ocid1.image.oc1.uk-london-1.aaaaaaaaezfspur6d5z66jpu3znxm2z6civgqzgkfiwla35zzk4mcdlwsstq"
    }
}