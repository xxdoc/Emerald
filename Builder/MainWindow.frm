VERSION 5.00
Begin VB.Form MainWindow 
   Appearance      =   0  'Flat
   BackColor       =   &H80000005&
   BorderStyle     =   0  'None
   Caption         =   "Emerald Builder"
   ClientHeight    =   6672
   ClientLeft      =   12
   ClientTop       =   12
   ClientWidth     =   9660
   Icon            =   "MainWindow.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   556
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   805
   StartUpPosition =   2  '��Ļ����
   Begin VB.Timer DrawTimer 
      Enabled         =   0   'False
      Interval        =   5
      Left            =   9000
      Top             =   240
   End
End
Attribute VB_Name = "MainWindow"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'==================================================
'   ҳ�������
    Dim EC As GMan
'==================================================
Private Sub DrawTimer_Timer()
    '����
    If EC.ActivePage = "" Then Exit Sub
    EC.Display
End Sub

Private Sub Form_KeyPress(KeyAscii As Integer)
    '�����ַ�����
    If TextHandle <> 0 Then WaitChr = WaitChr & Chr(KeyAscii)
End Sub

Private Sub Form_Load()
    '��ʼ��Emerald
    StartEmerald Me.Hwnd, 991, 754
    DebugSwitch.HideLOGO = 1
    DebugSwitch.DisableLOGO = 1
    
    '��������
    Set EF = New GFont
    If PackPos = -1 Then
        EF.AddFont App.path & "\Builder.UI.otf"
        EF.MakeFont "Abadi MT Extra Light"
        'EF.MakeFont "΢���ź�"
    Else
        EF.MakeFont "΢���ź�"
    End If
    
    '����ҳ�������
    Set EC = New GMan
    If PackPos = -1 Then EC.Layered False
    
    '�����浵����ѡ��
    Set ESave = New GSaving
    ESave.Create "Emerald.Core"
    ESave.AutoSave = True
    
    '���������б�
    Set MusicList = New GMusicList
    MusicList.Create App.path & "\music"

    '�ڴ˴���ʼ�����ҳ��
    If PackPos = -1 Then
        Set WelcomePage = New WelcomePage
        Set ToNewPage = New ToNewPage
        Set TitleBar = New TitleBar
    Else
        Set SetupPage = New SetupPage
    End If

    '���ûҳ��
    If PackPos = -1 Then EC.ActivePage = "WelcomePage"
    
    DrawTimer.Enabled = True
End Sub

Private Sub Form_MouseDown(button As Integer, Shift As Integer, X As Single, y As Single)
    '���������Ϣ
    UpdateMouse X, y, 1, button
End Sub

Private Sub Form_MouseMove(button As Integer, Shift As Integer, X As Single, y As Single)
    '���������Ϣ
    If Mouse.State = 0 Then
        UpdateMouse X, y, 0, button
    Else
        Mouse.X = X: Mouse.y = y
    End If
End Sub
Private Sub Form_MouseUp(button As Integer, Shift As Integer, X As Single, y As Single)
    '���������Ϣ
    UpdateMouse X, y, 2, button
End Sub

Private Sub Form_Unload(Cancel As Integer)
    '��ֹ����
    DrawTimer.Enabled = False
    '�ͷ�Emerald��Դ
    EndEmerald
    If CmdMark = "Uninstall" Then
        Open VBA.Environ("temp") & "\copyemr.cmd" For Output As #1
        Print #1, "@echo off"
        Print #1, "echo ж�س���������������ļ� , Emerald Builder �汾��: " & Version
        Print #1, "echo ������������ļ� ..."
        Print #1, "ping localhost -n 5 > nul"
        Print #1, "rd /s /q """ & App.path & """"
        Close #1
        ShellExecuteA 0, "open", VBA.Environ("temp") & "\copyemr.cmd", "", "", SW_SHOW
    End If
End Sub
