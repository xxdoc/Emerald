VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "WaitPage"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
'======================================
'   ҳ�������
    Dim Page As GPage
    Dim pos As Single, degree As Single
'======================================

Public Sub Update()
    '�����¼�
    
    Page.Clear argb(255 * 0.85, 242, 242, 249) '��ջ���
    
    Page.PaintArc GW / 2, GH / 2, 200, 200, 120, (GetTickCount Mod 3000) / 3000 * 360, argb(255, 232, 76, 61), 13, 1, posOnCenter
    Page.PaintArc GW / 2, GH / 2, 200, 200, 120, (GetTickCount Mod 1800) / 1800 * 360 + 90, argb(255, 240, 127, 34), 14, 1, posOnCenter
    Page.PaintArc GW / 2, GH / 2, 200, 200, 120, (GetTickCount Mod 1200) / 1200 * 360 + 90, argb(255, 242, 195, 17), 15, 1, posOnCenter

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
Private Sub Class_Initialize()
    '����ҳ�������
    Set Page = New GPage
    Page.Create Me
    '������Ϸ��Դ
    Page.Res.NewImages App.path & "\assets"
    '����ҳ��
    ECore.Add Page, "WaitPage"
    
    '===============================================
    '   �����Ҫ���Ӷ�����������ڴ˴�
    
    '===============================================
End Sub