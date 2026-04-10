#!/usr/bin/python

from mininet.topo import Topo
from mininet.net import Mininet
from mininet.cli import CLI
from mininet.node import CPULimitedHost
from mininet.link import TCLink
from mininet.util import irange,dumpNodeConnections
from mininet.log import setLogLevel
from mininet.node import RemoteController

import argparse
import sys
import time


class ClosTopo(Topo):
    def __init__(self, fanout, cores, **opts):
        Topo.__init__(self, **opts)

        "Set up Core and Aggregate level, Connection Core - Aggregation level"
        core_switches = []
        for i in irange(1, cores):
            core_sw = self.addSwitch('c%s' % i)
            core_switches.append(core_sw)

        agg_switches = []
        for i in irange(1, fanout):
            agg_sw = self.addSwitch('a%s' % i)
            agg_switches.append(agg_sw)
            for core_sw in core_switches:
                self.addLink(agg_sw, core_sw)

        "Set up Edge level, Connection Aggregation - Edge level"
        edge_switches = []
        for i in irange(1, fanout * fanout):
            edge_sw = self.addSwitch('e%s' % i)
            edge_switches.append(edge_sw)

        for i, agg_sw in enumerate(agg_switches):
            for j in irange(1, fanout):
                edge_sw = edge_switches[(i * fanout) + (j - 1)]
                self.addLink(agg_sw, edge_sw)

        "Set up Host level, Connection Edge - Host level"
        host_count = 1
        for edge_sw in edge_switches:
            for _ in irange(1, fanout):
                host = self.addHost('h%s' % host_count)
                self.addLink(edge_sw, host)
                host_count += 1
	

def setup_clos_topo(fanout=2, cores=1):
    "Create and test a simple clos network"
    assert(fanout>0)
    assert(cores>0)
    topo = ClosTopo(fanout, cores)
    net = Mininet(topo=topo, controller=lambda name: RemoteController('c0', "127.0.0.1"), autoSetMacs=True, link=TCLink)
    net.start()
    time.sleep(20) #wait 20 sec for routing to converge
    net.pingAll()  #test all to all ping and learn the ARP info over this process
    CLI(net)       #invoke the mininet CLI to test your own commands
    net.stop()     #stop the emulation (in practice Ctrl-C from the CLI 
                   #and then sudo mn -c will be performed by programmer)

    
def main(argv):
    parser = argparse.ArgumentParser(description="Parse input information for mininet Clos network")
    parser.add_argument('--num_of_core_switches', '-c', dest='cores', type=int, help='number of core switches')
    parser.add_argument('--fanout', '-f', dest='fanout', type=int, help='network fanout')
    args = parser.parse_args(argv)
    setLogLevel('info')
    setup_clos_topo(args.fanout, args.cores)


if __name__ == '__main__':
    main(sys.argv[1:])