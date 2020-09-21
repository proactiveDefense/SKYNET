from scapy.all import *
from scapy.utils import rdpcap

while True:
    pkts=rdpcap("MASTER.pcap")
    for pkt in pkts:
        pkt[Ether].src= "3F:F0:00:01:02:03"
        pkt[IP].src= "10.10.10.10"
        sendp(pkt)
        time.sleep(random.random())

