VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "DialogPage"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
'======================================
'   ҳ�������
    Dim Page As GPage
    Public Key As Integer, Title As String, Context As String
    Dim buttons()
'======================================

Public Sub Update()
    '�����¼�
    
    Page.Clear argb(255 * 0.85, 242, 242, 249) '��ջ���

    Page.Paint 0, GW / 2, GH / 2, 600, 250, argb(128, 255, 255, 255), pos:=posOnCenter
    Page.Writes Title, GW / 2 - 600 / 2 + 20, GH / 2 - 250 / 2 + 20, 30, argb(255, 27, 27, 27), style:=FontStyleBold
    Page.Writes Context, GW / 2 - 600 / 2 + 23, GH / 2 - 250 / 2 + 70, 18, argb(150, 27, 27, 27)
    
    For i = 0 To UBound(buttons)
        If Page.ShowColorButton(0, GW / 2 - 600 / 2 + 600 - 120 * (UBound(buttons) + 1) + i * 120, GH / 2 - 250 / 2 + 250 - 40 - 20, 100, 40, CStr(buttons(i)), argb(255, 255, 255, 255), argb(255, 85, 219, 211), argb(255, 55, 189, 181), size:=16) = 3 Then
            Key = i + 1
        End If
    Next
    
    '================================================================
    '   ʾ������������
    '   Page.Writes "��������", 20,20, Color:=argb(255, 0, 0, 0)
    '================================================================
    
End Sub
Public Sub Wheel(Direction As Integer, Depth As Single)
    '�������¼�
    'Direction:����Depth�����
End Sub
Public Sub Enter()
    'ҳ������¼�
End Sub
Public Sub Leave()
    'ҳ���뿪�¼�
End Sub
Public Sub Gotfocus()
    '����ȡ�ý����¼�
End Sub
Public Sub Lostfocus()
    '����ʧȥ�����¼�
End Sub
Public Sub AnimationDone(id As Integer)
    '�������Ž����¼�
    'id�������Ķ���ID
End Sub
Public Sub NewDialog(t As String, c As String, btn())
    buttons = btn
    Title = t
    Context = c
    Key = 0
    ECore.NewTransform transFadeIn, 700, "DialogPage"
End Sub
Private Sub Class_Initialize()
    '����ҳ�������
    Set Page = New GPage
    Page.Create Me
    '������Ϸ��Դ
    Page.Res.NewImages App.Path & "\assets"
    '����ҳ��
    ECore.Add Page, "DialogPage"
    
    '===============================================
    '   �����Ҫ���Ӷ�����������ڴ˴�
    
    '===============================================
End Sub