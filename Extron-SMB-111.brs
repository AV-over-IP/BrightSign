Const ipAddress = "10.100.2.51" ' IP de Dispositivo EXTRON SMB 111, cambiar si es neceario
Const port = 23

Const startRecord = "E Y1 RCDR}"
Const stopRecord = "E Y0 RCDR}"

Function InitTCPConnection() As Object
    tcp = CreateObject("roUrlTransfer")
    tcp.SetPort(port)
    tcp.SetHost(ipAddress)
    Return tcp
End Function

Function StartRecording()
    tcp = InitTCPConnection()
    command = startRecord ' Comando de inicio de grabación
    tcp.AsyncPostFromString(command)
End Function

Function StopRecording()
    tcp = InitTCPConnection()
    command = stopRecord ' Comando de detención de grabación
    tcp.AsyncPostFromString(command)
End Function
