#!/system/bin/sh
# Altering system identity before Android fully loads
resetprop ro.product.model "Pixel 10 Pro"
resetprop ro.product.brand "google"
resetprop ro.product.name "tegus"
resetprop ro.product.device "tegus"
resetprop ro.product.manufacturer "Google"
resetprop ro.build.flavor "tegus-user"
