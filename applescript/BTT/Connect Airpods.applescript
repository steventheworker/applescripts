use framework "IOBluetooth"
use scripting additions

set AirPodsName to "AirPod" # "Steven’s AirPods" # note the special apostrophe ’ (opposed to ')

on getFirstMatchingDevice(targetName)
	repeat with device in (current application's IOBluetoothDevice's pairedDevices() as list)
		set deviceName to device's nameOrAddress as string
		log deviceName
		if deviceName contains targetName then return device
	end repeat
end getFirstMatchingDevice

on toggleDevice(device)
	if not (device's isConnected as boolean) then
		device's openConnection()
		return "Connecting " & (device's nameOrAddress as string)
	else
		device's closeConnection()
		return "Disconnecting " & (device's nameOrAddress as string)
	end if
end toggleDevice

return toggleDevice(getFirstMatchingDevice(AirPodsName))
