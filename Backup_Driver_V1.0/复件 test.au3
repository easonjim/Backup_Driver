#Region ;**** 参数创建于 ACNWrapper_GUI ****
#AutoIt3Wrapper_icon=Download Drive 2.ico
#EndRegion ;**** 参数创建于 ACNWrapper_GUI ****
#cs================================================================
变量定义的代表意思









#ce=================================================================
#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <TabConstants.au3>
#include <TreeViewConstants.au3>
#include <WindowsConstants.au3>
;~ =================================================================
;~ 自行添加的头文件

#Include <Array.au3>


;~ =================================================================
;~ =================================================================
;~ 自定义变量
Dim $c[100] , $b , $DriverCount = 0 , $c1[100] ,$e ,$f[100] , $r


;~ =================================================================
#Region ### START Koda GUI section ### Form=
$Form1 = GUICreate("Form1", 508, 320, 241, 159)
$Tab1 = GUICtrlCreateTab(0, 0, 497, 265)
$TabSheet1 = GUICtrlCreateTabItem("TabSheet1")
$TreeView1 = GUICtrlCreateTreeView(16, 32, 321, 217,BitOR($TVS_EDITLABELS, $TVS_HASBUTTONS, $TVS_HASLINES, $TVS_LINESATROOT, $TVS_DISABLEDRAGDROP, $TVS_SHOWSELALWAYS, $TVS_CHECKBOXES),$WS_EX_CLIENTEDGE)
$xyfx = GUICtrlCreateTreeViewItem("需要备份的驱动",$TreeView1)
$xtfx = GUICtrlCreateTreeViewItem("系统自带的驱动",$TreeView1)
$Group1 = GUICtrlCreateGroup("Group1", 344, 24, 145, 233)
$Label2 = GUICtrlCreateLabel("Label2", 360, 56, 36, 17)
$Input2 = GUICtrlCreateInput("Input2", 352, 104, 121, 21)
$Label3 = GUICtrlCreateLabel("Label3", 352, 144, 36, 17)
$Input3 = GUICtrlCreateInput("Input3", 352, 176, 121, 21)
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateTabItem("")
$Group2 = GUICtrlCreateGroup("Group2", 8, 264, 489, 49)
$Label1 = GUICtrlCreateLabel("Label1", 32, 280, 60, 25)
$Input1 = GUICtrlCreateInput("Input1", 128, 280, 177, 21)
$Button1 = GUICtrlCreateButton("Button1", 312, 280, 35, 25)
$Button2 = GUICtrlCreateButton("Button2", 352, 280, 59, 25)
$Button3 = GUICtrlCreateButton("Button3", 424, 280, 59, 25)
GUICtrlCreateGroup("", -99, -99, 1, 1)
_ReadAllRegDrv()
GUISetState(@SW_SHOW)


#EndRegion ### END Koda GUI section ###

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit

	EndSwitch
WEnd
;~ ===============================================================
;~ 自定义函数的定义

Func _ReadAllRegDrv();读取注册表中所有的驱动信息
	Local $HKLM = "HKLM\SYSTEM\CurrentControlSet\Control\Class" , $a = 1
		While 1
			$HKLM1 = $HKLM & "\" & RegEnumKey($HKLM,$a)
			If @error = -1 Then ExitLoop
			_GetAllRegDrv($HKLM1)
			_GetAllRegDrv1($HKLM1)
			$a += 1
		WEnd

		
EndFunc ;===>_ReadAllRegDrv
Func _GetAllRegDrv($HKLM);获取注册表中所有可用的信息
	Local $HKLM1 , $a = 1
	While 1
		$HKLM1 = $HKLM & "\" & RegEnumKey($HKLM,$a)
		If @error = -1 Then ExitLoop
		If _JudCanBackDrv($HKLM1,"DriverDesc") Then
			$f[$DriverCount] = RegRead($HKLM1,"ProviderName")
			If $f[$DriverCount] <> "Microsoft"Then
				$r = $f[$DriverCount]
				
			If Not _SearchName(RegRead($HKLM, "")) Then
				$DriverType = RegRead($HKLM, "")
			$c[$DriverCount] = RegRead($HKLM, "")
			
			$c1[$DriverCount] = GUICtrlCreateTreeViewItem($DriverType,$xyfx)
			;MsgBox(0,"",$c1[$DriverCount])
			;MsgBox(0,"",$DriverType)
			$e = $c1[$DriverCount]
			
			
			$DriverCount = $DriverCount + 1
			EndIf
			
		EndIf
		;MsgBox(0,"",$DriverCount)
		If $f[$DriverCount] <> "Microsoft"Then
		$d = RegRead($HKLM1, "DriverDesc")
		;MsgBox(0,"",$d)
		GUICtrlCreateTreeViewItem($d,$e)
			EndIf
			
		EndIf
			
		$a += 1
	WEnd
EndFunc

Func _GetAllRegDrv1($HKLM);获取注册表中所有可用的信息
	Local $HKLM1 , $a = 1
	While 1
		$HKLM1 = $HKLM & "\" & RegEnumKey($HKLM,$a)
		If @error = -1 Then ExitLoop
		If _JudCanBackDrv($HKLM1,"DriverDesc") Then
			$f[$DriverCount] = RegRead($HKLM1,"ProviderName")
			If $f[$DriverCount] = "Microsoft"Then
				
			If Not _SearchName(RegRead($HKLM, "")) Then
				$DriverType = RegRead($HKLM, "")
			$c[$DriverCount] = RegRead($HKLM, "")
			
			$c1[$DriverCount] = GUICtrlCreateTreeViewItem($DriverType,$xtfx)
			;MsgBox(0,"",$c1[$DriverCount])
			;MsgBox(0,"",$DriverType)
			$e = $c1[$DriverCount]
			
			
			$DriverCount = $DriverCount + 1
			EndIf
			
		EndIf
		;MsgBox(0,"",$DriverCount)
		If $f[$DriverCount] = "Microsoft" Then
		$d = RegRead($HKLM1, "DriverDesc")
		;MsgBox(0,"",$d)
		GUICtrlCreateTreeViewItem($d,$e)
			EndIf
			
		EndIf
			
		$a += 1
	WEnd
EndFunc



Func _JudCanBackDrv($HKLM1,$KeyName);判断是否复合备份的条件，并返回真或假
	Local $RetVal
	RegRead($HKLM1,$KeyName)
	If @error <> 0 Then
		$RetVal = False
	Else
		$RetVal = True
	EndIf
	Return $RetVal
EndFunc ;===>_JudCanBackDrv



Func _SearchName($DriverDesc)
        Local $i, $Boolen
        For $i = 0 To $DriverCount
                If $c[$i] = $DriverDesc Then
                        $Boolen = True
                        ExitLoop
                EndIf
        Next
        Return $Boolen
EndFunc   ;==>_SearchName




