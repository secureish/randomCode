# https://isc.sans.edu/diary/NMAP+without+NMAP+Port+Testing+and+Scanning+with+PowerShell/29202/

$targetservers = "192.168.122.241", "192.168.122.1"
$ports = "22","23","80","443","9100"
$result = @()

foreach ($target in $targetservers) {

    foreach ($port in $ports) {

        $obj = new-Object system.Net.Sockets.TcpClient

        $connect = $obj.BeginConnect($target,$port,$null,$null)

        $Wait = $connect.AsyncWaitHandle.WaitOne(100,$false)

        If (-Not $Wait) {

            write-host $target 'port' $port 'Closed - Timeout'

        }

        else {

            $value = "Open"

            write-host $target 'port' $port $value

            $r = new-object -type psobject

            $r | add-member -membertype noteproperty -name host -value $target

            $r | add-member -membertype noteproperty -name port -value $port

            $r | add-member -membertype noteproperty -name state -value $value

            $result += $r

        }

    }

}
