If $nMsg = $xyfx And BitAND(GUICtrlRead($xyfx), $GUI_CHECKED) Then
					For $q = 0 To $a1 - 1
						GUICtrlSetState($xyzx[$q], $GUI_CHECKED)
						;For $q1 = 0 To $a1 - 1
						
						;MsgBox(0,"",$xyzx[$q])
						$nMsg = $xyzx[$q]
							If $nMsg = $xyzx[$q] And BitAND(GUICtrlRead($xyzx[$q]), $GUI_CHECKED) Then
								;MsgBox(0,"",$nMsg)
								$Number = _GUICtrlTreeView_GetChildCount($TreeView1,$xyzx[$q])
							For $q1_1 = $nMsg To $nMsg + $Number
								GUICtrlSetState($q1_1, $GUI_CHECKED)
							Next
							EndIf
						;Next
						
					Next
				ElseIf $nMsg = $xyfx And BitAND(GUICtrlRead($xyfx), $GUI_UNCHECKED) Then
					For $q = 0 To $a1 - 1
						GUICtrlSetState($xyzx[$q], $GUI_UNCHECKED)
						$nMsg = $xyzx[$q]
							If $nMsg = $xyzx[$q] And BitAND(GUICtrlRead($xyzx[$q]), $GUI_UNCHECKED) Then
								;MsgBox(0,"",$nMsg)
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