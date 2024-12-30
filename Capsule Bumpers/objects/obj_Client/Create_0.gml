port = 25567;
ip = global.ipaddress;//change later

areWeConnectedCount = 0;
areWeConnectedDisconnectionLimit = 6;//sent x pings that the server hasn't responded to
areWeConnectedTime = 0;
areWeConnectedTimeMax = 0;

alarm[0] = 1;
client = -1;

usernames = ["Online0", "Online1", "Online2", "Online3"];