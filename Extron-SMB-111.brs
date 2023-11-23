Const DEVICE_IP_ADDRESS = "10.100.2.51"
Const TCP_PORT = 23
Const START_RECORD_COMMAND = "E Y1 RCDR}"
Const STOP_RECORD_COMMAND = "E Y0 RCDR}"

Function InitializeTCPConnection() As Object
    tcpConnection = CreateObject("roTCPStream")
    if tcpConnection.Connect(DEVICE_IP_ADDRESS, TCP_PORT) then
        Return tcpConnection
    else
        print "Error: No se pudo inicializar la conexión TCP."
        Return invalid
    end if
End Function

Function SendStartRecordingCommand()
    tcpConnection = InitializeTCPConnection()
    if tcpConnection <> invalid then
        tcpConnection.Write(START_RECORD_COMMAND)
    else
        print "Error: Conexión TCP no válida para iniciar grabación."
    end if
End Function

Function SendStopRecordingCommand()
    tcpConnection = InitializeTCPConnection()
    if tcpConnection <> invalid then
        tcpConnection.Write(STOP_RECORD_COMMAND)
    else
        print "Error: Conexión TCP no válida para detener grabación."
    end if
End Function

Function ProcessPluginMessage(event as Object)
    if type(event) = "roAssociativeArray" then
        if type(event["EventType"]) = "roString" then
            if event["EventType"] = "SEND_PLUGIN_MESSAGE" then
                message$ = event["PluginMessage"]
                if message$ = "StartRecording" then
                    SendStartRecordingCommand()
                else if message$ = "StopRecording" then
                    SendStopRecordingCommand()
                else
                    print "Error: Mensaje del plugin no reconocido: "; message$
                end if
            endif
        endif
    endif
End Function
