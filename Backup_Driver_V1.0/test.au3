#Region ;**** 参数创建于 ACNWrapper_GUI ****
#AutoIt3Wrapper_icon=Windows XP Drive 2.ico
#AutoIt3Wrapper_outfile=Backup_Driver_V1.0.exe
#AutoIt3Wrapper_Res_Comment=Backup_Driver
#AutoIt3Wrapper_Res_Description=Backup_Driver
#AutoIt3Wrapper_Res_Fileversion=1.0.0.0
#AutoIt3Wrapper_Res_LegalCopyright=Backup_Driver
#EndRegion ;**** 参数创建于 ACNWrapper_GUI ****
#cs================================================================
变量定义的代表意思
$xyzx[?];需要备份驱动的主父项
$xyzx1[?][]；嵌套在$xyzx[?]的子项
$xtzx[?]；系统自带驱动的主父项
$xtzx1[?][];嵌套在$xtzx[?]的子项
#ce=================================================================
_RepRun();调用重复运行的函数
#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <TabConstants.au3>
#include <TreeViewConstants.au3>
#include <WindowsConstants.au3>
;~ =================================================================
;~ 自行添加的头文件
#Include <GuiTreeView.au3>;运用到TREEVIEW函数要用到的头文件，比如勾选什么之内的
;~ =================================================================
;~ =================================================================
;~ 自定义变量
Opt("TrayMenuMode",1)
Global $xx[600][8] , $xyzx[600] ,$xyzx1[600][4] ,$xtzx[600] , $xtzx1[600][4] , $xx1[600] , $xx2[600]
Dim $a1  = 0 ,  $a2 = 1 ,$a3  = 0 ,  $a4 = 1 , $a1_1_1 = 0 , $a3_3_3 = 0  , $c_1 , $c_2
Global $DrvDIR , $BackupDrvDIR
;~ =================================================================
#Region ### START Koda GUI section ### Form=
$Form1 = GUICreate("Backup_Driver_V1.0", 504, 319, -1, -1)
$Tab1 = GUICtrlCreateTab(5, 3, 497, 265)
$TabSheet1 = GUICtrlCreateTabItem("驱动备份")
$TreeView1 = GUICtrlCreateTreeView(15, 31, 319, 226, _ 
										BitOR($TVS_EDITLABELS, $TVS_HASBUTTONS, _
										$TVS_HASLINES,$TVS_NONEVENHEIGHT, _ 
										$TVS_LINESATROOT, $TVS_DISABLEDRAGDROP, _ 
										$TVS_SHOWSELALWAYS, $TVS_CHECKBOXES) _ 
										,$WS_EX_CLIENTEDGE)
$xyfx = GUICtrlCreateTreeViewItem("需要备份的驱动",$TreeView1)
GUICtrlSetImage($xyfx, "shell32.dll", 7);为TreeView添加图标
$xtfx = GUICtrlCreateTreeViewItem("系统自带的驱动",$TreeView1)
GUICtrlSetImage($xtfx, "shell32.dll", 7);为TreeView添加图标
$Group1 = GUICtrlCreateGroup("", 344, 24, 145, 233)
$Label2 = GUICtrlCreateLabel("硬件ID:", 360, 80, 42, 17)
$Input2 = GUICtrlCreateInput("(硬件ID)", 356, 104, 121, 21, _
										$ES_AUTOHSCROLL + $ES_READONLY + $ES_UPPERCASE)
$Label3 = GUICtrlCreateLabel("Inf文件:", 360, 153, 48, 17)
$Input3 = GUICtrlCreateInput("(Inf文件)", 356, 176, 121, 21, _ 
										$ES_AUTOHSCROLL + $ES_READONLY + $ES_UPPERCASE)
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateTabItem("")
$Group2 = GUICtrlCreateGroup("", 8, 264, 489, 49)
$Label1 = GUICtrlCreateLabel("驱动备份途径:", 20, 285, 80, 15)
$Input1 = GUICtrlCreateInput("D:\Drivers", 105, 281, 177, 21)
$Button1 = GUICtrlCreateButton(" ...", 288, 279, 35, 25)
$Button2 = GUICtrlCreateButton("备份", 350, 276, 59, 30)
$Button3 = GUICtrlCreateButton("退出", 424, 276, 59, 30)
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUISetState(@SW_SHOW)
;~ 进度条，没什么意思，只为视觉
	GUISetState(@SW_DISABLE,$Form1);调整窗口状态
	$Form2 = GUICreate("进度条", 314, 50, -1, -1,$WS_POPUP,-1,$Form1)
	GUISetState(@SW_SHOW);创建子GUI必不可少的
	WinSetTrans($Form2, "", 220) ;设置透明读，这里没有调用API，目的是为了方便
	$Progress1 = GUICtrlCreateProgress(9, 27, 294, 11)
	$Label = GUICtrlCreateLabel("检测可备份的驱动...",20,9,"",14)
	For $h = 1 To 9 Step 1
		GUICtrlSetData($Progress1,$h)
		Sleep(100)
	Next
	For $h = 10 To 100 Step 5
		GUICtrlSetData($Progress1,$h)
		Sleep(10)
	Next
	$Labe2 = GUICtrlCreateLabel("检测完毕，载入列表...",20,9,"",14)
	Sleep(10)
_ReadAllRegDrv();调用读取注册表中所有的驱动信息的函数
	GUISetState(@SW_ENABLE,$Form1);调整窗口状态
	GUIDelete($Form2);关闭$Form2
	GUICtrlSetState($xyfx,$GUI_EXPAND);展开项目
	GUICtrlSetState($xtfx,$GUI_EXPAND);展开项目
	_GUICtrlTreeView_Expand($TreeView1,$xtfx,False);只为视觉目的，没什么意义
#EndRegion ### END Koda GUI section ###
GUICtrlSetImage(2, "regedit.exe", 0,4);
While 1	
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit
		Case $xtzx1[0][0] To $xtzx1[$a3_3_3 - 1][0] , _ 
			$xyzx[0] To $xyzx[$a1 - 1] , _ 
			$xyzx1[0][0] To $xyzx1[$a1_1_1 - 1][0] , _ 
			$xtzx[0] To $xtzx[$a3 - 1] , $xtfx , $xyfx
				$Text = _GUICtrlTreeView_GetText($Treeview1, _GUICtrlTreeView_GetSelection($Treeview1));读取TREEVIEW中的文本
				_ShowDrvInf($Text);调用输出信息的函数
;===========================如过父项选中其带的所有子项也被选种=======反之，如果父项选空其带的所有子项也被选空==================				
					If $nMsg = $xyfx And BitAND(GUICtrlRead($xyfx), $GUI_CHECKED) Then
					For $q = 0 To $a1 - 1
						GUICtrlSetState($xyzx[$q], $GUI_CHECKED)
						$nMsg = $xyzx[$q]
							If $nMsg = $xyzx[$q] And BitAND(GUICtrlRead($xyzx[$q]), $GUI_CHECKED) Then
								$Number = _GUICtrlTreeView_GetChildCount($TreeView1,$xyzx[$q])
								For $q1_1 = $nMsg To $nMsg + $Number
									GUICtrlSetState($q1_1, $GUI_CHECKED)
								Next
							EndIf						
					Next
					ElseIf $nMsg = $xyfx And BitAND(GUICtrlRead($xyfx), $GUI_UNCHECKED) Then
						For $q = 0 To $a1 - 1
							GUICtrlSetState($xyzx[$q], $GUI_UNCHECKED)
							$nMsg = $xyzx[$q]
							If $nMsg = $xyzx[$q] And BitAND(GUICtrlRead($xyzx[$q]), $GUI_UNCHECKED) Then
								$Number = _GUICtrlTreeView_GetChildCount($TreeView1,$xyzx[$q])
								For $q1_1 = $nMsg To $nMsg + $Number
									GUICtrlSetState($q1_1, $GUI_UNCHECKED)
								Next
							EndIf
						Next
					ElseIf	$nMsg = $xtfx And BitAND(GUICtrlRead($xtfx), $GUI_CHECKED) Then
						For $q = 0 To $a3 - 1
							GUICtrlSetState($xtzx[$q], $GUI_CHECKED)
							$nMsg = $xtzx[$q]
							If $nMsg = $xtzx[$q] And BitAND(GUICtrlRead($xtzx[$q]), $GUI_CHECKED) Then
								$Number1 = _GUICtrlTreeView_GetChildCount($TreeView1,$xtzx[$q])
								For $q2 = $nMsg To $nMsg + $Number1
									GUICtrlSetState($q2, $GUI_CHECKED)
								Next
							EndIf
						Next
					ElseIf $nMsg = $xtfx And BitAND(GUICtrlRead($xtfx), $GUI_UNCHECKED) Then
						For $q = 0 To $a3 - 1
							GUICtrlSetState($xtzx[$q], $GUI_UNCHECKED)
							$nMsg = $xtzx[$q]
							If $nMsg = $xtzx[$q] And BitAND(GUICtrlRead($xtzx[$q]), $GUI_UNCHECKED) Then
								$Number1 = _GUICtrlTreeView_GetChildCount($TreeView1,$xtzx[$q])
								For $q2 = $nMsg To $nMsg + $Number1
									GUICtrlSetState($q2, $GUI_UNCHECKED)
								Next
							EndIf
						Next
					EndIf
					For $q1 = 0 To $a1 - 1
						If $nMsg = $xyzx[$q1] And BitAND(GUICtrlRead($xyzx[$q1]), $GUI_CHECKED) Then
							$Number = _GUICtrlTreeView_GetChildCount($TreeView1,$xyzx[$q1])
							For $q1_1 = $nMsg To $nMsg + $Number
								GUICtrlSetState($q1_1, $GUI_CHECKED)
							Next
						ElseIf $nMsg = $xyzx[$q1] And BitAND(GUICtrlRead($xyzx[$q1]), $GUI_UNCHECKED) Then
							$Number = _GUICtrlTreeView_GetChildCount($TreeView1,$xyzx[$q1])
							For $q1_1 = $nMsg To $nMsg + $Number
								GUICtrlSetState($q1_1, $GUI_UNCHECKED)
							Next
						EndIf
					Next
					For $q2 = 0 To $a3 - 1
						If $nMsg = $xtzx[$q2] And BitAND(GUICtrlRead($xtzx[$q2]), $GUI_CHECKED) Then
							$Number1 = _GUICtrlTreeView_GetChildCount($TreeView1,$xtzx[$q2])
							For $q2 = $nMsg To $nMsg + $Number1
								GUICtrlSetState($q2, $GUI_CHECKED)
							Next
						ElseIf $nMsg = $xtzx[$q2] And BitAND(GUICtrlRead($xtzx[$q2]), $GUI_UNCHECKED) Then
							$Number1 = _GUICtrlTreeView_GetChildCount($TreeView1,$xtzx[$q2])
							For $q2 = $nMsg To $nMsg + $Number1
								GUICtrlSetState($q2, $GUI_UNCHECKED)
							Next
						EndIf					
					Next							
;=========================如果子项选中，父项也跟着选中==========反之，如果子项选空，父项也跟着选空============================				
					For $w5 = 0 To $a1_1_1 - 1
						If $nMsg = $xyzx1[$w5][0] And BitAND(GUICtrlRead($xyzx1[$w5][0]),$GUI_CHECKED) Then
							$Handle2 = _GUICtrlTreeView_GetParentParam($TreeView1,$xyzx1[$w5][0])
							GUICtrlSetState($Handle2,$GUI_CHECKED)
							$nMsg = $Handle2
							For $w = 0 To $a1 - 1
								If $nMsg = $xyzx[$w] And BitAND(GUICtrlRead($xyzx[$w]), $GUI_CHECKED) Then
									$Handle = _GUICtrlTreeView_GetParentParam($TreeView1,$xyzx[$w])
									GUICtrlSetState($Handle,$GUI_CHECKED)
								EndIf
							Next
						ElseIf $nMsg = $xyzx1[$w5][0] And BitAND(GUICtrlRead($xyzx1[$w5][0]),$GUI_UNCHECKED) Then
							$Handle3 = _GUICtrlTreeView_GetParentParam($TreeView1,$xyzx1[$w5][0])
							$Number3 = Number(_GUICtrlTreeView_GetChildCount($TreeView1,$Handle3))
							For $w6 = $Handle3 To $Handle3 + $Number3
								If GUICtrlRead($w6) = $GUI_CHECKED Then ExitLoop
								If $w6 = $Handle3 + $Number3 Then
									GUICtrlSetState($Handle3,$GUI_UNCHECKED)
									$nMsg = $Handle3
									For $w = 0 To $a1 - 1
										If $nMsg = $xyzx[$w] And BitAND(GUICtrlRead($xyzx[$w]), $GUI_UNCHECKED) Then
											For $w1 = 0 To $a1 - 1
												If BitAND(GUICtrlRead($xyzx[$w1]), $GUI_CHECKED) Then ExitLoop
												If $w1 = $a1 - 1 Then
													GUICtrlSetState($xyfx,$GUI_UNCHECKED)
												EndIf
											Next
										EndIf
									Next	
								EndIf
							Next
						EndIf
					Next
					For $w7 = 0 To $a3_3_3 - 1
						If $nMsg = $xtzx1[$w7][0] And BitAND(GUICtrlRead($xtzx1[$w7][0]),$GUI_CHECKED) Then
							$Handle4 = _GUICtrlTreeView_GetParentParam($TreeView1,$xtzx1[$w7][0])
							GUICtrlSetState($Handle4,$GUI_CHECKED)
							$nMsg = $Handle4
							For $w3 = 0 To $a3 - 1 
								If $nMsg = $xtzx[$w3] And BitAND(GUICtrlRead($xtzx[$w3]),$GUI_CHECKED) Then
									$Handle1 = _GUICtrlTreeView_GetParentParam($TreeView1,$xtzx[$w3])
									GUICtrlSetState($Handle1,$GUI_CHECKED)
								EndIf
							Next							
						ElseIf $nMsg = $xtzx1[$w7][0] And BitAND(GUICtrlRead($xtzx1[$w7][0]),$GUI_UNCHECKED) Then
							$Handle5 = _GUICtrlTreeView_GetParentParam($TreeView1,$xtzx1[$w7][0])
							$Number5 = Number(_GUICtrlTreeView_GetChildCount($TreeView1,$Handle5))
							For $w8 = $Handle5 To $Handle5 + $Number5
								If GUICtrlRead($w8) = $GUI_CHECKED Then ExitLoop
								If $w8 = $Handle5 + $Number5 Then
									GUICtrlSetState($Handle5,$GUI_UNCHECKED)
									$nMsg = $Handle5
									For $w3 = 0 To $a3 - 1 
										If $nMsg = $xtzx[$w3] And BitAND(GUICtrlRead($xtzx[$w3]), $GUI_UNCHECKED) Then
											For $w4 = 0 To $a3 - 1
												If BitAND(GUICtrlRead($xtzx[$w4]), $GUI_CHECKED) Then ExitLoop
												If $w4 = $a3 - 1 Then
													GUICtrlSetState($xtfx,$GUI_UNCHECKED)
												EndIf
											Next
										EndIf
									Next
								EndIf
							Next
						EndIf
					Next
					For $w = 0 To $a1 - 1
						If $nMsg = $xyzx[$w] And BitAND(GUICtrlRead($xyzx[$w]), $GUI_CHECKED) Then
							$Handle = _GUICtrlTreeView_GetParentParam($TreeView1,$xyzx[$w])
							GUICtrlSetState($Handle,$GUI_CHECKED)
						ElseIf $nMsg = $xyzx[$w] And BitAND(GUICtrlRead($xyzx[$w]), $GUI_UNCHECKED) Then
							For $w1 = 0 To $a1 - 1
								If BitAND(GUICtrlRead($xyzx[$w1]), $GUI_CHECKED) Then ExitLoop
								If $w1 = $a1 - 1 Then
									GUICtrlSetState($xyfx,$GUI_UNCHECKED)
								EndIf
							Next
						EndIf
					Next
					For $w3 = 0 To $a3 - 1 
						If $nMsg = $xtzx[$w3] And BitAND(GUICtrlRead($xtzx[$w3]),$GUI_CHECKED) Then
							$Handle1 = _GUICtrlTreeView_GetParentParam($TreeView1,$xtzx[$w3])
							GUICtrlSetState($Handle1,$GUI_CHECKED)
						ElseIf $nMsg = $xtzx[$w3] And BitAND(GUICtrlRead($xtzx[$w3]), $GUI_UNCHECKED) Then
							For $w4 = 0 To $a3 - 1
								If BitAND(GUICtrlRead($xtzx[$w4]), $GUI_CHECKED) Then ExitLoop
								If $w4 = $a3 - 1 Then
									GUICtrlSetState($xtfx,$GUI_UNCHECKED)
								EndIf
							Next
						EndIf																							
					Next
;=========================结束选择按钮====================================================================================


			Case $Button1
				$Dir = FileSelectFolder("选择一个文件夹.", "",1+2+4)
				If @error <> 1 Then
					GUICtrlSetData($Input1, $Dir)
				EndIf
				
			Case $Button2	
				Jud();调用判断是否空选的函数
				Jud1();调用判断是否空选的函数
				If $c_1 + $c_2 = 0 Then ;作出判断
					MsgBox(8192+48,"警告","貌似你一个都没有选！")
				Else
				Begin();调用开始备份的函数
				EndIf
			Case $Button3 
				Exit	
	EndSwitch
WEnd
;~ ===============================================================
;~ 自定义函数的定义
Func Begin();定义开始备份的函数
	GUISetState(@SW_DISABLE,$Form1);调整窗口状态
	$Form3 = GUICreate("进度条", 314, 50, -1, -1,$WS_POPUP,-1,$Form1)
	GUISetState(@SW_SHOW);创建子GUI必不可少的
	WinSetTrans($Form3, "", 220) ;设置透明读，这里没有调用API，目的是为了方便
	$Progress1 = GUICtrlCreateProgress(9, 27, 294, 11)
	$Label = GUICtrlCreateLabel("正在创建目录...",20,9,"",14)
	For $h = 1 To 9 Step 1
		GUICtrlSetData($Progress1,$h)
		Sleep(100)
	Next
_CreateDIR();调用创建备份的主目录途径
	$Labe2 = GUICtrlCreateLabel("目录创建完毕...",20,9,"",14)
	Sleep(10)
	$Labe3 = GUICtrlCreateLabel("复制文件中...",20,9,"",14)
	For $h = 10 To 50 Step 5
		GUICtrlSetData($Progress1,$h)
		Sleep(10)
	Next
_BackupDrv()
	For $h = 50 To 70 Step 5
		GUICtrlSetData($Progress1,$h)
		Sleep(10)
	Next
_BackupDrv1()
	For $h = 70 To 100 Step 5
		GUICtrlSetData($Progress1,$h)
		Sleep(10)
	Next
	$Labe4 = GUICtrlCreateLabel("文件复制完毕...",20,9,"",14)
	Sleep(100)
	GUISetState(@SW_ENABLE,$Form1);调整窗口状态
	GUIDelete($Form3);关闭$Form2
EndFunc

Func _ReadAllRegDrv();读取注册表中所有的驱动信息
	Local $HKLM = "HKLM\SYSTEM\CurrentControlSet\Control\Class" , $a = 1
		While 1
			$HKLM1 = $HKLM & "\" & RegEnumKey($HKLM,$a)
			If @error = -1 Then ExitLoop
			_GetAllRegDrv($HKLM1)
			_GetAllRegDrv1($HKLM1)
			$a += 1
		WEnd
		ReDim $xyzx[$a1];调整数组大小
		ReDim $xtzx[$a3];调整数组大小
		ReDim $xyzx1[$a1_1_1][4];调整数组大小
		ReDim $xtzx1[$a3_3_3][4];调整数组大小		
EndFunc ;===>_ReadAllRegDrv
	
Func _GetAllRegDrv($HKLM);获取注册表中所有可用的信息
	Local $HKLM1 ,$a = 1
	While 1
		$HKLM1 = $HKLM & "\" & RegEnumKey($HKLM,$a)
		If @error = -1 Then ExitLoop
		If _JudCanBackDrv($HKLM1,"DriverDesc") Then
			$xx[$a2][0] = RegRead($HKLM1, "DriverDesc")
			$xx[$a2][1] = RegRead($HKLM1, "ProviderName")
			$xx[$a2][2] = RegRead($HKLM1, "InfPath")
			RegRead($HKLM1, "MatchingDeviceId")
				If @error = 0 Then
					$xx[$a2][6] = RegRead($HKLM1, "MatchingDeviceId")
				Else 
					$xx[$a2][6] = "无法读取！"
				EndIf			
			If $xx[$a2][1] <> "Microsoft" Then
					If Not _RepName(RegRead($HKLM,"")) Then  ;调用是否有重复的函数，
						$xx1[$a1] = RegRead($HKLM,"")
						$xyzx[$a1] = GUICtrlCreateTreeViewItem($xx1[$a1],$xyfx)		
						GUICtrlSetImage($xyzx[$a1], "shell32.dll",$a1-10);添加图标
						$a1 += 1
					EndIf
					$a1_1 = $a1 - 1
					$xyzx1[$a1_1_1][0] = GUICtrlCreateTreeViewItem($xx[$a2][0],$xyzx[$a1_1])
					GUICtrlSetImage($xyzx1[$a1_1_1][0], "shell32.dll",$a1_1_1-20);添加图标
					$xyzx1[$a1_1_1][1] = $xx[$a2][0] ;设置文件夹的名字要用到
					$xyzx1[$a1_1_1][2] = $xx[$a2][2] ;设置INF文件名，搜索INF要用到
					$xyzx1[$a1_1_1][3] = $xx[$a2][6] ;设置硬件ID
					$a1_1_1 += 1
			EndIf	
		EndIf			
		$a2 += 1
		$a += 1
	WEnd
EndFunc

Func _GetAllRegDrv1($HKLM);获取注册表中所有可用的信息的函数
	Local $HKLM1 ,$a = 1
	While 1
		$HKLM1 = $HKLM & "\" & RegEnumKey($HKLM,$a)
		If @error = -1 Then ExitLoop
		If _JudCanBackDrv($HKLM1,"DriverDesc") Then
			$xx[$a4][3] = RegRead($HKLM1, "DriverDesc")
			$xx[$a4][4] = RegRead($HKLM1, "ProviderName")
			$xx[$a4][5] = RegRead($HKLM1, "InfPath")
			RegRead($HKLM1, "MatchingDeviceId")
				If @error = 0 Then
					$xx[$a4][7] = RegRead($HKLM1, "MatchingDeviceId")
				Else
					$xx[$a4][7] = "无法读取！"
				EndIf
			If $xx[$a4][4] = "Microsoft" Then
					If Not _RepName1(RegRead($HKLM,"")) Then ;调用是否有重复的函数
						$xx2[$a3] = RegRead($HKLM,"")
						$xtzx[$a3] = GUICtrlCreateTreeViewItem($xx2[$a3],$xtfx)
						GUICtrlSetImage($xtzx[$a3], "shell32.dll",$a3-18);添加图标
						$a3 += 1
					EndIf
					$a3_3 = $a3 - 1
					$xtzx1[$a3_3_3][0] = GUICtrlCreateTreeViewItem($xx[$a4][3],$xtzx[$a3_3])
					GUICtrlSetImage($xtzx1[$a3_3_3][0], "shell32.dll",$a3_3_3-50);添加图标
					$xtzx1[$a3_3_3][1] = $xx[$a4][3] ;设置文件夹的名字要用到
					$xtzx1[$a3_3_3][2] = $xx[$a4][5] ;设置INF文件名，搜索INF要用到
					$xtzx1[$a3_3_3][3] = $xx[$a4][7] ;设置硬件ID
					$a3_3_3 += 1	
			EndIf
		EndIf
		$a4 += 1
		$a += 1
	WEnd
EndFunc

Func _JudCanBackDrv($HKLM1,$KeyName);判断是否复合备份的条件，并返回真或假的函数
	Local $RetVal
	RegRead($HKLM1,$KeyName)
	If @error <> 0 Then
		$RetVal = False
	Else
		$RetVal = True
	EndIf
	Return $RetVal
EndFunc ;===>_JudCanBackDrv

Func _RepName($xx1_1);判断是否有重复的名字的函数
        Local $i, $RetVal
        For $i = 0 To $a1
                If $xx1[$i] = $xx1_1 Then
                        $RetVal = True
                        ExitLoop
                EndIf
        Next
        Return $RetVal
EndFunc   ;==>_SearchName 

Func _RepName1($xx1_1);判断是否有重复的名字的函数
        Local $i, $RetVal
        For $i = 0 To $a3
                If $xx2[$i] = $xx1_1 Then
                        $RetVal = True
                        ExitLoop
                EndIf
        Next
        Return $RetVal
EndFunc   ;==>_SearchName 
	
Func _CreateDIR();创建备份的主目录
		$DrvDIR = GUICtrlRead($Input1)
		DirCreate($DrvDIR)
EndFunc

Func _BackupDrv();创建要备份的目录并准备备份驱动
	For $c = 0 To $a1_1_1 - 1 Step 1 ;需要备份的选项
		If _GUICtrlTreeView_GetChecked($TreeView1,$xyzx1[$c][0]) Then
			$BackupDrv = $xyzx1[$c][1]
			$BackupDrv = StringRegExpReplace($BackupDrv,"[/]","")
			$BackupDrv = StringRegExpReplace($BackupDrv,"[ ]","_")
			$BackupDrvDIR = $DrvDIR & "\" & $BackupDrv ;设置备份的目录
			DirCreate($BackupDrvDIR) ;创建备份的目录			
			FileCopy(@WindowsDir & "\inf\" & $xyzx1[$c][2],$BackupDrvDIR);复制要备份的驱动inf文件到目录中
			$BackupDrvInf = IniReadSection($BackupDrvDIR & "\" & $xyzx1[$c][2],"SourceDisksFiles");读取inf中要备份的文件
			If Not @error = 1 Then				
				$BackupDrvInfCat = IniRead($BackupDrvDIR & "\" & $xyzx1[$c][2],"Version","CatalogFile","无");读取inf中的数字前面文件
				_CopyBackupDrv($BackupDrvInf,$BackupDrvInfCat);传递从inf中读取的信息并执行复制函数	
			EndIf
		EndIf		
	Next
EndFunc

Func _CopyBackupDrv($BackupDrvInf,$BackupDrvInfCat);复制要备份的文件到备份文件目录中
Local $d, $d1, $WinDrvDIR[7] 
        ;设置驱动程序所在的目录,不用递归目录查找是想的这样比较快些~
        $WinDrvDIR[0] = @WindowsDir & "\"
        $WinDrvDIR[1] = @WindowsDir & "\inf\"
        $WinDrvDIR[2] = @WindowsDir & "\help\"
        $WinDrvDIR[3] = @WindowsDir & "\System32\"
        $WinDrvDIR[4] = @WindowsDir & "\System32\Drivers\"
		$WinDrvDIR[5] = @WindowsDir & "\system32\RTCOM\"
		$WinDrvDIR[6] = "C:\Program Files\Microsoft Office\OFFICE11\Migration\"
		For $d = 1 To $BackupDrvInf[0][0]
			For $d1 = 0 To 6
				FileCopy($WinDrvDIR[$d1] & $BackupDrvInf[$d][0] , $BackupDrvDIR)
				FileCopy($WinDrvDIR[$d1] & $BackupDrvInfCat,$BackupDrvDIR);复制CAT文件
			Next
		Next 
EndFunc

Func _BackupDrv1();创建要备份的目录并准备备份驱动
	For $c = 0 To $a3_3_3 - 1 Step 1 ;需要备份的选项
		If _GUICtrlTreeView_GetChecked($TreeView1,$xtzx1[$c][0]) Then			
			$BackupDrv = $xtzx1[$c][1]
			$BackupDrv = StringRegExpReplace($BackupDrv,"[/]","")
			$BackupDrv = StringRegExpReplace($BackupDrv,"[ ]","_")
			$BackupDrvDIR = $DrvDIR & "\" & $BackupDrv ;设置备份的目录
			DirCreate($BackupDrvDIR) ;创建备份的目录			
			FileCopy(@WindowsDir & "\inf\" & $xtzx1[$c][2],$BackupDrvDIR);复制要备份的驱动inf文件到目录中
			$BackupDrvInf = IniReadSection($BackupDrvDIR & "\" & $xtzx1[$c][2],"SourceDisksFiles");读取inf中要备份的文件
			If Not @error = 1 Then
				$BackupDrvInfCat = IniRead($BackupDrvDIR & "\" & $xtzx1[$c][2],"Version","CatalogFile","无");读取inf中的数字前面文件
				_CopyBackupDrv1($BackupDrvInf,$BackupDrvInfCat);传递从inf中读取的信息并执行复制函数	
			EndIf			
		EndIf		
	Next
EndFunc

Func _CopyBackupDrv1($BackupDrvInf,$BackupDrvInfCat);复制要备份的文件到备份文件目录中
Local $d, $d1, $WinDrvDIR[7] 
        ;设置驱动程序所在的目录,不用递归目录查找是想的这样比较快些~
        $WinDrvDIR[0] = @WindowsDir & "\"
        $WinDrvDIR[1] = @WindowsDir & "\inf\"
        $WinDrvDIR[2] = @WindowsDir & "\help\"
        $WinDrvDIR[3] = @WindowsDir & "\System32\"
        $WinDrvDIR[4] = @WindowsDir & "\System32\Drivers\"
		$WinDrvDIR[5] = @WindowsDir & "\system32\RTCOM\"
		$WinDrvDIR[6] = "C:\Program Files\Microsoft Office\OFFICE11\Migration\"		
		For $d = 1 To $BackupDrvInf[0][0]
			For $d1 = 0 To 6
				FileCopy($WinDrvDIR[$d1] & $BackupDrvInf[$d][0] , $BackupDrvDIR)
				FileCopy($WinDrvDIR[$d1] & $BackupDrvInfCat,$BackupDrvDIR);复制CAT文件
			Next
		Next 
EndFunc

Func _ShowDrvInf($Text);设置输出信息
	Local $e
	For $e = 0 To $a1_1_1 - 1
		If $Text = $xyzx1[$e][1] Then
			GUICtrlSetData($Input2,$xyzx1[$e][3]);硬件ID
			GUICtrlSetData($Input3,$xyzx1[$e][2]);inf文件名
		EndIf
	Next
	For $e1 = 0 To $a3_3_3 - 1
		If $Text = $xtzx1[$e1][1] Then
			GUICtrlSetData($Input2,$xtzx1[$e1][3]);硬件ID
			GUICtrlSetData($Input3,$xtzx1[$e1][2]);inf文件名
		EndIf
	Next
EndFunc

Func Jud();定义判断是否空选的函数
	Dim $c_1 = 0
	For $c = 0 To $a1_1_1 - 1 Step 1 ;需要备份的选项
		If _GUICtrlTreeView_GetChecked($TreeView1,$xyzx1[$c][0]) Then
			$c_1 += 1
		EndIf		
	Next
	Return $c_1
EndFunc

Func Jud1();定义判断是否空选的函数
	Dim $c_2 = 0
	For $c = 0 To $a3_3_3 - 1 Step 1 ;需要备份的选项
		If _GUICtrlTreeView_GetChecked($TreeView1,$xtzx1[$c][0]) Then
			$c_2 += 1
		EndIf		
	Next
	Return $c_2
EndFunc
	
Func _RepRun();定义重复运行的函数
	$Form = "Backup_Driver_V1.0"
	If WinExists($Form) Then 
		MsgBox(16,"Warning","貌似你已经运行的本程序！" & @CRLF & "     请按确定退出")
		Exit
	EndIf
EndFunc

	
	
	
	
	