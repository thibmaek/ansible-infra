package main

import (
	"fmt"
	"net"
	"strings"
)

func main() {
	var currentIP, currentNetworkHardwareName string

	interfaces, _ := net.Interfaces()
	for _, iface := range interfaces {
		if addrs, err := iface.Addrs(); err == nil {
			for _, addr := range addrs {
				if ipnet, ok := addr.(*net.IPNet); ok && !ipnet.IP.IsLoopback() {
					if ipnet.IP.To4() != nil {
						currentIP = ipnet.IP.String()

						if strings.Contains(addr.String(), currentIP) {
							currentNetworkHardwareName = iface.Name
						}

						macAddress := iface.HardwareAddr
						hwAddr, err := net.ParseMAC(macAddress.String())
						if err != nil {
							continue
						}

						currentNetworkHardwareName = strings.Replace(currentNetworkHardwareName, " ", "", -1)

						fmt.Printf("net_iface,name=%s,ip_address=%s,mac_address=%s status=1\n",
							currentNetworkHardwareName, currentIP, hwAddr)
					}
				}
			}
		}
	}
}
