Attribute VB_Name = "Process"
'Emerald ��ش���

Public VBIDEPath As String, InstalledPath As String, IsUpdate As Boolean
Public WelcomePage As New WelcomePage, TitleBar As New TitleBar, SetupPage As SetupPage, WaitPage As WaitPage, DialogPage As DialogPage, UpdatePage As UpdatePage
Public Tasks() As String
Public NewVersion As Long
Public CmdMark As String, SetupErr As Long, Repaired As Boolean
Public AppInfo() As String
Public Cmd As String
Public Abouting As Boolean
Public SetMode As Boolean, PackPos As Long
Public Sub CheckUpdate()
    On Error GoTo ErrHandle
    
    Dim WSHShell As Object, temp As String
    Set WSHShell = CreateObject("WScript.Shell")
    
    temp = WSHShell.RegRead("HKEY_CLASSES_ROOT\Directory\shell\emerald\version")
    IsUpdate = (Val(temp) <> Version)
    
ErrHandle:
    
End Sub
Public Sub GetInstalledPath()
    On Error GoTo ErrHandle
    
    Dim WSHShell As Object, temp As String
    Set WSHShell = CreateObject("WScript.Shell")
    
    temp = WSHShell.RegRead("HKEY_CLASSES_ROOT\Directory\shell\emerald\icon")
    InstalledPath = Replace(temp, """", "")
    
ErrHandle:
    
End Sub
Public Sub GetVBIDEPath()
    On Error GoTo ErrHandle
    
    Dim WSHShell As Object, temp As String, temp2() As String
    Set WSHShell = CreateObject("WScript.Shell")
    
    temp = WSHShell.RegRead("HKEY_CLASSES_ROOT\VisualBasic.Project\shell\open\command\")
    temp2 = Split(temp, "vb6.exe")
    VBIDEPath = Replace(temp2(0), """", "")
    
ErrHandle:
    If Err.Number <> 0 Then
        Dialog "��·", "��ȡVB6·��ʧ�ܣ���ȷ�����ĵ������Ѿ���װVB6���Ǿ���棩��" & vbCrLf & vbCrLf & _
               "ע�⣺Emeraldֻ������VB6", "�ð�"
    End If
End Sub
Public Function CheckFileName(name As String) As Boolean
    CheckFileName = ((InStr(name, "*") Or InStr(name, "\") Or InStr(name, "/") Or InStr(name, ":") Or InStr(name, "?") Or InStr(name, """") Or InStr(name, "<") Or InStr(name, ">") Or InStr(name, "|") Or InStr(name, " ") Or InStr(name, "!") Or InStr(name, "-") Or InStr(name, "+") Or InStr(name, "#") Or InStr(name, "@") Or InStr(name, "$") Or InStr(name, "^") Or InStr(name, "&") Or InStr(name, "(") Or InStr(name, ")")) = 0)
    Dim t As String
    If name <> "" Then t = Left(name, 1)
    CheckFileName = CheckFileName And (Trim(Str(Val(t))) <> t)
End Function
Sub Uninstall()
    'If Dialog("ж��", "Emerald Builder �Ѿ���װ����ϣ��ɾ������", "ж��", "�ֻ�") <> 1 Then End
    On Error Resume Next
    
    SetupPage.SetupInfo = "���ڴ�����WScript.Shell����"
    SetupPage.Progress = 0.1
    Call FakeSleep
    
    Set WSHShell = CreateObject("WScript.Shell")
    
    SetupPage.SetupInfo = "����ɾ������Դ�����������˵���"
    SetupPage.Progress = 0.4
    Call FakeSleep
    
    WSHShell.RegDelete "HKEY_CLASSES_ROOT\Directory\shell\emerald\icon"
    WSHShell.RegDelete "HKEY_CLASSES_ROOT\Directory\shell\emerald\version"
    WSHShell.RegDelete "HKEY_CLASSES_ROOT\Directory\shell\emerald\command\"
    WSHShell.RegDelete "HKEY_CLASSES_ROOT\Directory\shell\emerald\"
    
    WSHShell.RegDelete "HKEY_CLASSES_ROOT\Directory\Background\shell\emerald\icon"
    WSHShell.RegDelete "HKEY_CLASSES_ROOT\Directory\Background\shell\emerald\command\"
    WSHShell.RegDelete "HKEY_CLASSES_ROOT\Directory\Background\shell\emerald\"
    
    WSHShell.RegDelete "HKEY_CLASSES_ROOT\Directory\shell\emeraldp\icon"
    WSHShell.RegDelete "HKEY_CLASSES_ROOT\Directory\shell\emeraldp\command\"
    WSHShell.RegDelete "HKEY_CLASSES_ROOT\Directory\shell\emeraldp\"
    
    WSHShell.RegDelete "HKEY_CLASSES_ROOT\Directory\Background\shell\emeraldp\icon"
    WSHShell.RegDelete "HKEY_CLASSES_ROOT\Directory\Background\shell\emeraldp\command\"
    WSHShell.RegDelete "HKEY_CLASSES_ROOT\Directory\Background\shell\emeraldp\"
    
    SetupPage.SetupInfo = "����ɾ���������Ϣ"
    SetupPage.Progress = 0.7
    Call FakeSleep
    
    WSHShell.RegDelete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Uninstall\Emerald\DisplayIcon"
    WSHShell.RegDelete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Uninstall\Emerald\DisplayName"
    WSHShell.RegDelete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Uninstall\Emerald\DisplayVersion"
    WSHShell.RegDelete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Uninstall\Emerald\Publisher"
    WSHShell.RegDelete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Uninstall\Emerald\URLInfoAbout"
    WSHShell.RegDelete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Uninstall\Emerald\UninstallString"
    WSHShell.RegDelete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Uninstall\Emerald\InstallLocation"
    WSHShell.RegDelete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Uninstall\Emerald\"
    
    SetupPage.SetupInfo = "����ɾ����Visual Basic 6 ģ���ļ� (1/2)"
    SetupPage.Progress = 0.8
    Call FakeSleep
    
    Kill VBIDEPath & "Template\Forms\Emerald ��Ϸ����.frm"
    
    SetupPage.SetupInfo = "����ɾ����Visual Basic 6 ģ���ļ� (2/2)"
    SetupPage.Progress = 0.9
    Call FakeSleep
    
    Kill VBIDEPath & "Template\Classes\Emerald ҳ��.cls"
    
    SetupPage.SetupInfo = "��β"
    SetupPage.Progress = 1
    
    SetupErr = Err.Number
End Sub
Sub FakeSleep(Optional Counts As Long = 10)
    For i = 1 To Counts
        Sleep 10: DoEvents
        ECore.Display
    Next
End Sub
Sub Setup()
    On Error Resume Next
    
    Dim exeP As String
    exeP = """" & App.path & "\Builder.exe" & """"
    
    SetupPage.SetupInfo = "���ڴ�����WScript.Shell����"
    SetupPage.Progress = 0.1
    Set WSHShell = CreateObject("WScript.Shell")

    Call FakeSleep

    SetupPage.SetupInfo = "����ע�᣺��Դ�����������˵���"
    SetupPage.Progress = 0.3
    WSHShell.RegWrite "HKEY_CLASSES_ROOT\Directory\shell\emerald\", "�ڴ˴�����/����Emerald����"
    WSHShell.RegWrite "HKEY_CLASSES_ROOT\Directory\shell\emerald\icon", exeP
    
    WSHShell.RegWrite "HKEY_CLASSES_ROOT\Directory\shell\emerald\version", Version
    
    WSHShell.RegWrite "HKEY_CLASSES_ROOT\Directory\shell\emerald\command\", exeP & " ""%v"""
    
    WSHShell.RegWrite "HKEY_CLASSES_ROOT\Directory\Background\shell\emerald\", "�ڴ˴�����/����Emerald����"
    WSHShell.RegWrite "HKEY_CLASSES_ROOT\Directory\Background\shell\emerald\icon", exeP
    
    WSHShell.RegWrite "HKEY_CLASSES_ROOT\Directory\Background\shell\emerald\command\", exeP & " ""%v"""
    
    WSHShell.RegWrite "HKEY_CLASSES_ROOT\Directory\shell\emeraldp\", "������Emerald���̵İ�װ��"
    WSHShell.RegWrite "HKEY_CLASSES_ROOT\Directory\shell\emeraldp\icon", exeP
    WSHShell.RegWrite "HKEY_CLASSES_ROOT\Directory\shell\emeraldp\command\", exeP & " p""%v"""
    
    WSHShell.RegWrite "HKEY_CLASSES_ROOT\Directory\Background\shell\emeraldp\", "������Emerald���̵İ�װ��"
    WSHShell.RegWrite "HKEY_CLASSES_ROOT\Directory\Background\shell\emeraldp\icon", exeP
    WSHShell.RegWrite "HKEY_CLASSES_ROOT\Directory\Background\shell\emeraldp\command\", exeP & " p""%v"""
    
    
    Call FakeSleep
    
    SetupPage.SetupInfo = "����ע�᣺�����Ϣ"
    SetupPage.Progress = 0.6
    WSHShell.RegWrite "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Uninstall\Emerald\DisplayIcon", exeP
    WSHShell.RegWrite "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Uninstall\Emerald\DisplayName", "Emerald"
    WSHShell.RegWrite "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Uninstall\Emerald\DisplayVersion", "Indev " & Version
    WSHShell.RegWrite "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Uninstall\Emerald\Publisher", "Error 404"
    WSHShell.RegWrite "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Uninstall\Emerald\InstallLocation", App.path
    WSHShell.RegWrite "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Uninstall\Emerald\URLInfoAbout", "http://red-error404.github.io/233"
    WSHShell.RegWrite "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Uninstall\Emerald\UninstallString", exeP & " ""-uninstall"""
    
    Call FakeSleep
    
    SetupPage.SetupInfo = "���ڸ��ƣ�Visual Basic 6 ģ���ļ���1/2��"
    SetupPage.Progress = 0.8
    FileCopy App.path & "\Example\Emerald ��Ϸ����.frm", VBIDEPath & "Template\Forms\Emerald ��Ϸ����.frm"
    
    Call FakeSleep
    
    SetupPage.SetupInfo = "���ڸ��ƣ�Visual Basic 6 ģ���ļ���2/2��"
    SetupPage.Progress = 0.9
    FileCopy App.path & "\Example\Emerald ҳ��.cls", VBIDEPath & "Template\Classes\Emerald ҳ��.cls"
    
    Call FakeSleep
    
    SetupPage.SetupInfo = "��β"
    SetupPage.Progress = 1
    
    SetupErr = Err.Number
End Sub
Sub CheckVersion()
    On Error Resume Next
    Dim exeP As String, sh As String
    exeP = """" & App.path & "\Builder.exe" & """"
    Set WSHShell = CreateObject("WScript.Shell")
    
    sh = WSHShell.RegRead("HKEY_CLASSES_ROOT\Directory\shell\emerald\version")
    
    If sh <> "" Then
        If Val(sh) <> Version Then
            If Dialog("���¿���", "ʹ��ǰ��Ҫ�������Emerald��", "����", "�Ժ�") <> 1 Then Unload MainWindow: End
            Call Setup
            Dialog "����", "���³ɹ�������������������", "�õ�"
            Unload MainWindow: End
        End If
    End If
End Sub
Sub Repair()
    If InstalledPath = "" Then Exit Sub
    
    If Dir(InstalledPath) = "" Then
        ECore.NewTransform transFadeIn, 700, "WelcomePage": Repaired = True
    End If
End Sub
Public Sub CheckOnLineUpdate()
    On Error Resume Next
    
    Call FakeSleep(300)
    
    If InternetGetConnectedState(0&, 0&) = 0 Then
        NewVersion = 3
        Exit Sub
    End If
    
    Dim data As New GSaving
    data.Create "Emerald.Core"
    data.AutoSave = True
    If Now - CDate(data.GetData("UpdateTime")) >= UpdateCheckInterval Or data.GetData("UpdateAble") = 1 Then
        data.PutData "UpdateTime", Now
        
        Dim xmlHttp As Object, Ret As String, Start As Long
        Set xmlHttp = CreateObject("Microsoft.XMLHTTP")
        xmlHttp.Open "GET", "https://raw.githubusercontent.com/Red-Error404/Emerald/master/Version.txt", True
        xmlHttp.send
        
        Start = GetTickCount
        Do While xmlHttp.ReadyState <> 4
            If GetTickCount - Start >= UpdateTimeOut Then
                NewVersion = 3
                Exit Sub
            End If
            ECore.Display
            Sleep 10: DoEvents
        Loop
        Ret = xmlHttp.responseText
        Set xmlHttp = Nothing

        NewVersion = Val(Ret)
        data.PutData "UpdateAble", 1

    Else
    
        NewVersion = Version
        
    End If
End Sub
Sub Main()
    Dim targetEXE As String
    targetEXE = App.path & "\" & App.EXEName & ".exe"
    'targetEXE = "D:\MyDoc\Emerald\Export\Minesweeper - ��װ��.exe"
    
    PackPos = FindPackage(targetEXE, 598000)
    
    MainWindow.Show
    ECore.Display
    DoEvents
    
    If LCase(Trim(Replace(Command$, """", ""))) = "-uninstallgame" Then
        If Dialog("ж��", "ȷʵҪж�ظ���Ϸ��", "��", "�ֻ�") <> 1 Then Unload MainWindow: End
        CmdMark = "Uninstall"
        SetupMode = True
        ECore.NewTransform , 700, "SetupPage"
        Call UninPack
        Exit Sub
    End If
    
    If PackPos <> -1 Then
        '��ָ��λ�ðѰ�װ���������
        Dim tempPath As String, data() As Byte, data2() As Byte
        tempPath = VBA.Environ("temp")
        If Dir(tempPath & "\setuppack.emrpack") <> "" Then Kill tempPath & "\setuppack.emrpack"
        ReDim data(FileLen(targetEXE) - 1)
        ReDim data2(UBound(data) - PackPos)
        Open targetEXE For Binary As #1
        Get #1, , data
        Close #1
        CopyMemory data2(0), data(PackPos), UBound(data) - PackPos + 1
        ReDim Preserve data(PackPos - 1)
        Open tempPath & "\setuppack.emrpack" For Binary As #1
        Put #1, , data2
        Close #1
        Open tempPath & "\emrtempUninstall.exe" For Binary As #1
        Put #1, , data
        Close #1
        Open tempPath & "\setuppack.emrpack" For Binary As #1
        Get #1, , SPackage
        Close #1
        If SPackage.files(0).path <> "" Then
            Open tempPath & "\setupappicon.png" For Binary As #1
            Put #1, , SPackage.files(0).data
            Close #1
            WelcomePage.Page.Res.newImage tempPath & "\setupappicon.png", 128, 128
        End If
        SetupMode = True
        Kill tempPath & "\setuppack.emrpack"
        ECore.NewTransform , 700, "WelcomePage"
        Exit Sub
    End If
    
    Call CheckUpdate
    Call GetVBIDEPath
    Call GetInstalledPath
    Call Repair
    
    If Repaired Then Exit Sub
    
    Cmd = Replace(Command$, """", "")
    'Cmd = "E:\Error 404\ħ�޻�ս3"
    'Cmd = "pC:\Users\Error404\Desktop\Project\ħ�޻�ս3"
    Dim pmode As Boolean
    If Left(Cmd, 1) = "p" Then pmode = True: Cmd = Right(Cmd, Len(Cmd) - 1)
    
    If Cmd <> "" Then
        Dim appn As String, f As String, t As String, p As String
        Dim nList As String, xinfo As String, info() As String
        p = Cmd

        If p = "-uninstall" Then
            ECore.NewTransform transFadeIn, 700, "WelcomePage"
            Exit Sub
        End If
        
        Call CheckVersion
        
        If Dir(p & "\.emerald") <> "" Then
            Open p & "\.emerald" For Input As #1
            Do While Not EOF(1)
            Line Input #1, t
            xinfo = xinfo & t & vbCrLf
            Loop
            Close #1
            If Dir(p & "\core", vbDirectory) = "" Then MkDir p & "\core"
            If Dir(p & "\.emr", vbDirectory) = "" Then MkDir p & "\.emr"
            If Dir(p & "\.emr\backup", vbDirectory) = "" Then MkDir p & "\.emr\backup"
            If Dir(p & "\.emr\cache", vbDirectory) = "" Then MkDir p & "\.emr\cache"
            If Dir(p & "\assets\debug", vbDirectory) = "" Then MkDir p & "\assets\debug"
            If Dir(p & "\animation", vbDirectory) = "" Then MkDir p & "\animation"
            If Dir(p & "\music", vbDirectory) = "" Then MkDir p & "\music"
            info = Split(xinfo, vbCrLf)
        End If
        
        If Dir(p & "\core\GCore.bas") <> "" Then
            Dim sw2 As String
            If UBound(info) >= 2 Then sw2 = Trim(info(2))
            If Val(info(0)) < Version Or sw2 = "True" Then
                If pmode Then
                    Dialog "�����", "�뱣֤���Ĺ�������ʹ�����°�Emerald��", "OK"
                    Unload MainWindow: End
                End If
                ECore.NewTransform , 700, "UpdatePage"
                AppInfo = info
                UpdatePage.GetWarnStr
                Exit Sub
            Else
                If pmode Then
                    If Dialog("���", "���ڿ�ʼ�����", "��", "��Ҫ") <> 1 Then Unload MainWindow: End
                    If Dir(Cmd & "\app.exe") = "" Then
                        Dialog "����", "�Ҳ�����Ϸ������app.exe�������á�", "��"
                        Unload MainWindow: End
                    End If
                    Dim QQ As Long, Maker As String, name As String, Describe As String, GVersion As String
                    Dim tempr As String
                    Open Cmd & "\" & Dir(Cmd & "\*.vbp") For Input As #1
                    Do While Not EOF(1)
                        Line Input #1, tempr
                        If InStr(tempr, "VersionProductName") = 1 Then name = Split(tempr, """")(1)
                        If InStr(tempr, "VersionFileDescription") = 1 Then Describe = Split(tempr, """")(1)
                        If InStr(tempr, "VersionCompanyName") = 1 Then Maker = Split(tempr, """")(1)
                        If InStr(tempr, "MajorVer") = 1 Then GVersion = GVersion & Split(tempr, "=")(1) & "."
                        If InStr(tempr, "MinorVer") = 1 Then GVersion = GVersion & Split(tempr, "=")(1) & "."
                        If InStr(tempr, "RevisionVer") = 1 Then GVersion = GVersion & Split(tempr, "=")(1)
                    Loop
                    Close #1
                    If name = "" Then
                        Dialog "����", "��Ϸ���Ʋ���Ϊ�ա�", "��"
                        Unload MainWindow: End
                    End If
                    MakePackage Cmd, Maker, name, GVersion, Describe, QQ
                    CreateFolder GetSpecialDir(MYDOCUMENTS) & "\Emerald\Export\"
                    If Dir(GetSpecialDir(MYDOCUMENTS) & "\Emerald\Export\" & name & " - ��װ��.exe") <> "" Then Kill GetSpecialDir(MYDOCUMENTS) & "\Emerald\Export\" & name & " - ��װ��.exe"
                    Open VBA.Environ("temp") & "\copyemr.cmd" For Output As #1
                    Print #1, "@echo off"
                    Print #1, "echo Emerald Package Toolkit , Version: " & Version
                    Print #1, "echo Building Installer..."
                    Print #1, "ping localhost -n 3 > nul"
                    Print #1, "copy """ & targetEXE & """ /b + """ & VBA.Environ("temp") & "\emrpack"" /b """ & GetSpecialDir(MYDOCUMENTS) & "\Emerald\Export\" & name & " - ��װ��.exe"""
                    Close #1
                    ShellExecuteA 0, "open", VBA.Environ("temp") & "\copyemr.cmd", "", "", SW_SHOW
                    Do While Dir(GetSpecialDir(MYDOCUMENTS) & "\Emerald\Export\" & name & " - ��װ��.exe") = ""
                        Sleep 10: DoEvents
                        ECore.Display
                    Loop
                    Dialog "��ϲ", "��װ�������ɹ�", "�õ�"
                    ShellExecuteA 0, "open", "explorer.exe", "/select,""" & GetSpecialDir(MYDOCUMENTS) & "\Emerald\Export\" & name & " - ��װ��.exe" & """", "", SW_SHOW
                    Unload MainWindow: End
                End If
                Dialog "�޲���", "��Ĺ����Ѿ���ʹ�����µ�Emerald�ˡ�", "�ֻ�"
                Unload MainWindow: End
            End If
        End If

        appn = InputAsk("��������", "������Ŀɰ��Ĺ�������(*^��^*)~", "���", "ȡ��")
        If CheckFileName(appn) = False Or appn = "" Then Dialog "��ŭ", "����Ĺ������ơ�", "����": Unload MainWindow: End
        
        Open App.path & "\Example\example.vbp" For Input As #1
        Do While Not EOF(1)
        Line Input #1, t
        f = f & t & vbCrLf
        Loop
        Close #1
        
        f = Replace(f, "{app}", appn)
        
        Open p & "\" & appn & ".vbp" For Output As #1
        Print #1, f
        Close #1
            
SkipName:
        If Dir(p & "\core", vbDirectory) = "" Then MkDir p & "\core"
        If Dir(p & "\.emr", vbDirectory) = "" Then MkDir p & "\.emr"
        If Dir(p & "\.emr\backup", vbDirectory) = "" Then MkDir p & "\.emr\backup"
        If Dir(p & "\.emr\cache", vbDirectory) = "" Then MkDir p & "\.emr\cache"
        If Dir(p & "\assets", vbDirectory) = "" Then MkDir p & "\assets"
        If Dir(p & "\assets\debug", vbDirectory) = "" Then MkDir p & "\assets\debug"
        If Dir(p & "\music", vbDirectory) = "" Then MkDir p & "\music"
        
        CopyInto App.path & "\core", p & "\core", True
        CopyInto App.path & "\assets\debug", p & "\assets\debug"
        CopyInto App.path & "\framework", p
        
        Open p & "\.emerald" For Output As #1
        Print #1, Version 'version
        Print #1, Now 'Update Time
        Print #1, False
        Close #1
        
    Else
        
        If InstalledPath <> "" Then
            If (Not IsUpdate) Then
                ECore.NewTransform transFadeIn, 700, "WelcomePage": Exit Sub
            Else
                ECore.NewTransform transFadeIn, 700, "WelcomePage": Exit Sub
            End If
        End If
        
        If InstalledPath = "" Then
            ECore.NewTransform transFadeIn, 700, "WelcomePage": Exit Sub
        End If
        
    End If
    
    Unload MainWindow: End
End Sub
Function InputAsk(t As String, c As String, ParamArray b()) As String
    InputAsk = InputBox(c, t)
End Function
Function Dialog(t As String, c As String, ParamArray b()) As Integer
    Dim b2(), last As String
    b2 = b
    
    last = ECore.ActivePage
    DialogPage.NewDialog t, c, b2
    
    Do While DialogPage.Key = 0
        ECore.Display
        Sleep 10: DoEvents
    Loop
    
    Dialog = DialogPage.Key
    ECore.NewTransform transFadeIn, 700, last
End Function
Sub CopyInto(Src As String, Dst As String, Optional WriteCache As Boolean = False)
    Dim f As String, p As Boolean
    p = Dir(Dst & "\Core.bas") <> ""
    f = Dir(Src & "\")
    Do While f <> ""
        If f = "Core.bas" Then
            If p Then GoTo skip
        End If
        FileCopy Src & "\" & f, Dst & "\" & f
        If WriteCache Then
            Open Cmd & "\.emr\cache\" & f For Output As #1
            Print #1, FileLen(Dst & "\" & f)
            Close #1
        End If
        
        DoEvents
skip:
        f = Dir()
    Loop
End Sub
Function CompareFolder(Src As String, Dst As String) As String
    Dim f As String, fs() As String
    f = Dir(Src & "\")
    
    ReDim fs(0)
    
    Do While f <> ""
        ReDim Preserve fs(UBound(fs) + 1)
        fs(UBound(fs)) = f
        f = Dir()
    Loop
    
    For i = 1 To UBound(fs)
        If Dir(Dst & "\" & fs(i)) = "" Then
            CompareFolder = CompareFolder & fs(i) & vbCrLf
        End If
    Next
End Function
