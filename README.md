linux-tgt Cookbook
==================
Set up linux tgtd and configure targets. 
This cookbook uses a conf.d approach  and since there is no "managed-directory" (http://lists.opscode.com/sympa/arc/chef/2012-08/msg00316.html) support in chef it can not remove configs ...


Attributes
----------

* `default['linux-tgt']['targets_data_bag'] = 'tgt_targets'`
* `default['linux-tgt']['server_package'] = 'tgt'`
* `default['linux-tgt']['server_service'] = 'tgt'`

Usage
-----
Define your iscsi targets in a data bag, one item per target, and include recipe `linux-tgt::server`

Example data bag:

```json
{
  "id": "target1",
  "targetname": "iqn.2014-10.net.globalways.iscsi:target1",
  "incomingusers": {
      "user1": "somepw"
  },
  "outgoingusers": {
      "user2": "anotherpw"
  },
  "initiatoraddresses": [ "192.168.0.1, "127.0.0.0/30", "ALL" ],
  "backingstores": {
    "rbd-pool1/rbd-image1": {
      "bs-type": "rbd",
      "params": "bsopts=\"id=node1\"",
      "lun": "1"
    }
  }
}
```

