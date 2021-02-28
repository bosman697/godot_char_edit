extends Tree

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

# for load in character editor for bones
var M_List = []

#	get skeleton for bones 
var All_Bones
#for loop
var Current_Edited_Bone = "Root"
var Current_Edited_Bone_ID = 0

var Current_Edited_Bone_T

var Current_Edited_Bone_P

var Current_Edited_Bone_S

var Current_Edited_Value_Bone = "C"

#last value for edited bones scale rot trans 
var Last_Edited_Value_pos = Vector3(0.0,0.0,0.0)
var Last_Edited_Value_rot = Vector3(0.0,0.0,0.0)
var Last_Edited_Value_scal = Vector3(1.0,1.0,1.0)

var Last_Mirror_Edited_Value_pos = Vector3(0.0,0.0,0.0)
var Last_Mirror_Edited_Value_rot = Vector3(0.0,0.0,0.0)
var Last_Mirror_Edited_Value_scal = Vector3(1.0,1.0,1.0)

# form mirror bones
var Current_Mirror_Bone = "as"
var Current_Mirror_Bone_ID = 0
var Current_Mirror_Bone_T
var Current_Mirror_Bone_P
var Current_Mirror_Value_Bone = "C"

#for store scale mesh
var Tree_Scale_Mesh = 1.0
#for store scale Head for store head heightr width ets bones location etc



func _ready():
#	get skeleton for bones 
	All_Bones = get_parent().get_parent().get_parent().get_parent().get_parent().get_node("Body/Char_Editor_Armature/Skeleton")
#	
	
	var Customize = self.create_item()
#subroot
	var Head_Root = self.create_item()
	var Body_Root = self.create_item()
	
	
	Head_Root.collapsed = true
	Body_Root.collapsed = true
	
	Customize.set_text(0,"Customize")
	Head_Root.set_text(0,"Head")
	Body_Root.set_text(0,"Body")


	
	
#	Head pos y
	var General_Head_posZ = self.create_item(Head_Root)
	General_Head_posZ.set_text(0,"Head Y position")
	var General_Head_PZ = self.create_item(Head_Root)
#	this is wery important ( "name_of_the bone" - "what I edited "   )
#	PX - position on x axis
#	PY - position on Y axis
#	PZ - position on Z axis

#	RX - Rotation on x axis
#	RY - Rotation on y axis
#	RZ - Rotation on z axis

#	SA - Scale in all directions 
#	SX - Scale on x axis
#	SY - Scale on y axis
#	SZ - Scale on z axis
# if bone has mirror bones alvays write left name of the bones. example Femur.L has also Femur.R
# but I write Femur_L-SA
	General_Head_PZ.set_metadata(0,"Head-PZ")
#	I edited position on z axis  BONE named Head 
	General_Head_PZ.set_cell_mode(0,TreeItem.CELL_MODE_RANGE)
	General_Head_PZ.set_editable(0,true)
	General_Head_PZ.set_range_config(0,-0.30,0.30,0.001)
	General_Head_PZ.set_range(0,0.0)
	
	
	
#	Head pos z
	var General_Head_posY = self.create_item(Head_Root)
	General_Head_posY.set_text(0,"Head Z position")
	var General_Head_PY = self.create_item(Head_Root)
	General_Head_PY.set_metadata(0,"Head-PY")
	General_Head_PY.set_cell_mode(0,TreeItem.CELL_MODE_RANGE)
	General_Head_PY.set_editable(0,true)
	General_Head_PY.set_range_config(0,-0.30,0.30,0.001)
	General_Head_PY.set_range(0,0.0)
	
	
	#	Head SCALE xyz
	var General_Head_scal = self.create_item(Head_Root)
	General_Head_scal.set_text(0,"Head Size")
	var General_Head_S = self.create_item(Head_Root)
	General_Head_S.set_metadata(0,"Head-SA")
	General_Head_S.set_cell_mode(0,TreeItem.CELL_MODE_RANGE)
	General_Head_S.set_editable(0,true)
	General_Head_S.set_range_config(0,0.9,1.2,0.001)
	General_Head_S.set_range(0,1.0)
	
#	append to array for  save
	M_List.append(General_Head_PZ)
	M_List.append(General_Head_PY)
	M_List.append(General_Head_S)
#	nose position
	var Nose_posy = self.create_item(Head_Root)
	Nose_posy.set_text(0,"Nose_Y_Position")
	var Nose_PY = self.create_item(Head_Root)
	Nose_PY.set_metadata(0,"Nose-PZ")
	Nose_PY.set_cell_mode(0,TreeItem.CELL_MODE_RANGE)
	Nose_PY.set_editable(0,true)
	Nose_PY.set_range_config(0,-0.05,0.07,0.001)
	Nose_PY.set_range(0,0.0)
	
	
	var Nose_size = self.create_item(Head_Root)
	Nose_size.set_text(0,"Nose_Size")
	var Nose_S = self.create_item(Head_Root)
	Nose_S.set_metadata(0,"Nose-SA")
	Nose_S.set_cell_mode(0,TreeItem.CELL_MODE_RANGE)
	Nose_S.set_editable(0,true)
	Nose_S.set_range_config(0,0.5,2.0,0.001)
	Nose_S.set_range(0,1.0)
	
	var Nose_sizex = self.create_item(Head_Root)
	Nose_sizex.set_text(0,"Nose_size_Round_Width")
	var Nose_SX = self.create_item(Head_Root)
	Nose_SX.set_metadata(0,"Nose-SX")
	Nose_SX.set_cell_mode(0,TreeItem.CELL_MODE_RANGE)
	Nose_SX.set_editable(0,true)
	Nose_SX.set_range_config(0,0.5,2.0,0.001)
	Nose_SX.set_range(0,1.0)
	
	
	var Nose_sizey = self.create_item(Head_Root)
	Nose_sizey.set_text(0,"Nose_Round_Depth")
	var Nose_SY = self.create_item(Head_Root)
	Nose_SY.set_metadata(0,"Nose-SZ")
	Nose_SY.set_cell_mode(0,TreeItem.CELL_MODE_RANGE)
	Nose_SY.set_editable(0,true)
	Nose_SY.set_range_config(0,0.5,2.0,0.001)
	Nose_SY.set_range(0,1.0)
	
	
	var Nose_roty = self.create_item(Head_Root)
	Nose_roty.set_text(0,"Nose_rot_x")
	var Nose_RX = self.create_item(Head_Root)
	Nose_RX.set_metadata(0,"Nose-RX")
	Nose_RX.set_cell_mode(0,TreeItem.CELL_MODE_RANGE)
	Nose_RX.set_editable(0,true)
	Nose_RX.set_range_config(0,0.5,2.0,0.001)
	Nose_RX.set_range(0,1.0)
	
	

	#	append to array for load save
	M_List.append(Nose_PY)
	M_List.append(Nose_S)
	M_List.append(Nose_SX)
	M_List.append(Nose_SY)
	M_List.append(Nose_RX)
	

	
#	
	
	var Hips_sizex = self.create_item(Body_Root)
	Hips_sizex.set_text(0,"Hips_Width")
	var Hips_SX = self.create_item(Body_Root)
	Hips_SX.set_metadata(0,"Femur_L-SX")
	Hips_SX.set_cell_mode(0,TreeItem.CELL_MODE_RANGE)
	Hips_SX.set_editable(0,true)
	Hips_SX.set_range_config(0,0.5,2.0,0.001)
	Hips_SX.set_range(0,1.0)
	
	M_List.append(Hips_SX)
	
	
	
	var Breast_size = self.create_item(Body_Root)
	Breast_size.set_text(0,"Breast_size")
	var Breast_S = self.create_item(Body_Root)
	Breast_S.set_metadata(0,"breast_L-SA")
	Breast_S.set_cell_mode(0,TreeItem.CELL_MODE_RANGE)
	Breast_S.set_editable(0,true)
	Breast_S.set_range_config(0,0.5,2.0,0.001)
	Breast_S.set_range(0,1.0)
	
	M_List.append(Breast_S)
	
	
#	add extra  in loop out of index
	M_List.append(Breast_S)
	M_List.append(Breast_S)
	M_List.append(Breast_S)
	
	


func _on_Tree_item_edited():

#	get name of the bone
	var Bone_name = get_edited().get_metadata(0).left(get_edited().get_metadata(0).find("-"))
#	get pos rot or scale of the bone
	var Bone_P_R_S = get_edited().get_metadata(0).right(get_edited().get_metadata(0).find("-")+1)
#	 for symmetry bones eq Eyes_L Eyes_R if has dot . dont work eq name Eye_L.008 
	var Bone_Symetry = get_edited().get_metadata(0).right(get_edited().get_metadata(0).find("-")-1)
	var Bone_Symetry_Name = (get_edited().get_metadata(0).left(get_edited().get_metadata(0).find("-")-1)+"R")

#	if bone has dot . in name blender bones for symery bones new name eq name Eye_L.008 
	if(get_edited().get_metadata(0).left(get_edited().get_metadata(0).find("."))):
		var find_dot_in_name = (get_edited().get_metadata(0).right(get_edited().get_metadata(0).find(".")))
		Bone_Symetry_Name = ((get_edited().get_metadata(0).left(get_edited().get_metadata(0).find(".")-1)+"R"+find_dot_in_name[0]+find_dot_in_name[1]+find_dot_in_name[2]+find_dot_in_name[3]))
		
		Bone_Symetry = "L"
		
		
		
		
#	for mirror bones
	if((Bone_Symetry[0]=="L") and (Bone_Symetry_Name !=Current_Mirror_Bone or Bone_P_R_S!=Current_Edited_Value_Bone )):
		
		Current_Mirror_Bone = All_Bones.get_bone_name(All_Bones.find_bone(Bone_Symetry_Name))
		Current_Mirror_Bone_ID = All_Bones.find_bone(Bone_Symetry_Name)
		Current_Mirror_Value_Bone = Bone_P_R_S
		Current_Mirror_Bone_P = All_Bones.get_bone_pose(Current_Mirror_Bone_ID)
	
	if (Bone_Symetry[0]=="L"):
		Current_Mirror_Bone_T = All_Bones.get_bone_custom_pose(Current_Mirror_Bone_ID)
	
	
	
#	 for rest bones
	if (Bone_name != Current_Edited_Bone)  or (Bone_P_R_S!=Current_Edited_Value_Bone):
		
		Current_Edited_Bone = All_Bones.get_bone_name(All_Bones.find_bone(Bone_name))
		Current_Edited_Bone_ID = All_Bones.find_bone(Bone_name)
		Current_Edited_Value_Bone = Bone_P_R_S
		Current_Edited_Bone_P = All_Bones.get_bone_pose(Current_Edited_Bone_ID)
		
		
		
	Current_Edited_Bone_T = All_Bones.get_bone_custom_pose(Current_Edited_Bone_ID)
	
	
#		for position of the bones
	if(Current_Edited_Value_Bone == "PX"):
		Current_Edited_Bone_T = Current_Edited_Bone_T.translated(Vector3(get_edited().get_range(0),Current_Edited_Bone_P.origin.y,Current_Edited_Bone_P.origin.z))
		
		if(Bone_Symetry[0]=="L"):
			Current_Mirror_Bone_T = Current_Mirror_Bone_T.translated(Vector3(-get_edited().get_range(0),Current_Mirror_Bone_P.origin.y,Current_Mirror_Bone_P.origin.z))
			
	if (Current_Edited_Value_Bone == "PY"):
		Current_Edited_Bone_T = Current_Edited_Bone_T.translated(Vector3(Current_Edited_Bone_P.origin.x,get_edited().get_range(0),Current_Edited_Bone_P.origin.z))
		
		if(Bone_Symetry[0]=="L"):
			Current_Mirror_Bone_T = Current_Mirror_Bone_T.translated(Vector3(Current_Mirror_Bone_P.origin.x,get_edited().get_range(0),Current_Mirror_Bone_P.origin.z))
			
	
	
	if (Current_Edited_Value_Bone == "PZ"):
		Current_Edited_Bone_T = Current_Edited_Bone_T.translated(Vector3(Current_Edited_Bone_P.origin.x,Current_Edited_Bone_P.origin.y,get_edited().get_range(0)))
		
		if(Bone_Symetry[0]=="L"):
			Current_Mirror_Bone_T = Current_Mirror_Bone_T.translated(Vector3(Current_Mirror_Bone_P.origin.x,Current_Mirror_Bone_P.origin.y,get_edited().get_range(0)))
			
	
	
	
#	for rotation of the bones
	
	if(Current_Edited_Value_Bone == "RX"):
		Current_Edited_Bone_T = Current_Edited_Bone_T.rotated(Vector3(1,0,0),get_edited().get_range(0))
		
		Current_Edited_Bone_T = Current_Edited_Bone_T.rotated(Vector3(0,1,0),Current_Edited_Bone_P.basis.get_euler().y)
		Current_Edited_Bone_T = Current_Edited_Bone_T.rotated(Vector3(0,0,1),Current_Edited_Bone_P.basis.get_euler().z)
		
	
		if(Bone_Symetry[0]=="L"):
			Current_Mirror_Bone_T = Current_Mirror_Bone_T.rotated(Vector3(1,0,0),get_edited().get_range(0))
			
			Current_Mirror_Bone_T = Current_Mirror_Bone_T.rotated(Vector3(0,1,0),Current_Mirror_Bone_P.basis.get_euler().y)
			Current_Mirror_Bone_T = Current_Mirror_Bone_T.rotated(Vector3(0,0,1),Current_Mirror_Bone_P.basis.get_euler().z)
			
		
	if(Current_Edited_Value_Bone == "RY"):
		Current_Edited_Bone_T = Current_Edited_Bone_T.rotated(Vector3(0,1,0),get_edited().get_range(0))
		
		Current_Edited_Bone_T = Current_Edited_Bone_T.rotated(Vector3(1,0,0),Current_Edited_Bone_P.basis.get_euler().x)
		Current_Edited_Bone_T = Current_Edited_Bone_T.rotated(Vector3(0,0,1),Current_Edited_Bone_P.basis.get_euler().z)
		
		
		
		if(Bone_Symetry[0]=="L"):
			Current_Mirror_Bone_T = Current_Mirror_Bone_T.rotated(Vector3(0,1,0),-get_edited().get_range(0))
			Current_Mirror_Bone_T = Current_Mirror_Bone_T.rotated(Vector3(1,0,0),Current_Mirror_Bone_P.basis.get_euler().x)
			Current_Mirror_Bone_T = Current_Mirror_Bone_T.rotated(Vector3(0,0,1),Current_Mirror_Bone_P.basis.get_euler().z)
		
		
		
	if(Current_Edited_Value_Bone == "RZ"):
		Current_Edited_Bone_T = Current_Edited_Bone_T.rotated(Vector3(0,0,1),get_edited().get_range(0))
		
		Current_Edited_Bone_T = Current_Edited_Bone_T.rotated(Vector3(1,0,0),Current_Edited_Bone_P.basis.get_euler().x)
		Current_Edited_Bone_T = Current_Edited_Bone_T.rotated(Vector3(0,1,0),Current_Edited_Bone_P.basis.get_euler().y)
		
		
		if(Bone_Symetry[0]=="L"):
			Current_Mirror_Bone_T = Current_Mirror_Bone_T.rotated(Vector3(0,0,1),-get_edited().get_range(0))
			
			Current_Mirror_Bone_T = Current_Mirror_Bone_T.rotated(Vector3(1,0,0),Current_Mirror_Bone_P.basis.get_euler().x)
			Current_Mirror_Bone_T = Current_Mirror_Bone_T.rotated(Vector3(0,1,0),Current_Mirror_Bone_P.basis.get_euler().y)
		
		
	
#	for scale of the bones
	
	if(Current_Edited_Value_Bone == "SX"):
		Current_Edited_Bone_T = Current_Edited_Bone_T.scaled(Vector3(get_edited().get_range(0) , Current_Edited_Bone_P.basis.get_scale().y , Current_Edited_Bone_P.basis.get_scale().z))
		
		if(Bone_Symetry[0]=="L"):
			Current_Mirror_Bone_T = Current_Mirror_Bone_T.scaled(Vector3(get_edited().get_range(0) , Current_Mirror_Bone_P.basis.get_scale().y , Current_Mirror_Bone_P.basis.get_scale().z))
		
			
		
		
	if(Current_Edited_Value_Bone == "SY"):
		Current_Edited_Bone_T = Current_Edited_Bone_T.scaled(Vector3(Current_Edited_Bone_P.basis.get_scale().x , get_edited().get_range(0) , Current_Edited_Bone_P.basis.get_scale().z))
	
		if(Bone_Symetry[0]=="L"):
			
			Current_Mirror_Bone_T = Current_Mirror_Bone_T.scaled(Vector3(Current_Mirror_Bone_P.basis.get_scale().x , get_edited().get_range(0) , Current_Mirror_Bone_P.basis.get_scale().z))
	
			
	
	
	if(Current_Edited_Value_Bone == "SZ"):
		Current_Edited_Bone_T = Current_Edited_Bone_T.scaled(Vector3(Current_Edited_Bone_P.basis.get_scale().x , Current_Edited_Bone_P.basis.get_scale().y, get_edited().get_range(0)))
		
		if(Bone_Symetry[0]=="L"):
			Current_Mirror_Bone_T = Current_Mirror_Bone_T.scaled(Vector3(Current_Mirror_Bone_P.basis.get_scale().x , Current_Mirror_Bone_P.basis.get_scale().y, get_edited().get_range(0)))
		
		
		
	
	
	
	if(Current_Edited_Value_Bone == "SA"):
		Current_Edited_Bone_T = Current_Edited_Bone_T.scaled(Vector3 (get_edited().get_range(0),get_edited().get_range(0),get_edited().get_range(0)))
		
		if(Bone_Symetry[0]=="L"):
			Current_Mirror_Bone_T = Current_Mirror_Bone_T.scaled(Vector3(get_edited().get_range(0) , get_edited().get_range(0), get_edited().get_range(0)))
		
		
		
		for i in M_List.size():
			
			if( M_List[i].get_metadata(0)  == get_edited().get_metadata(0)  ):
				if(M_List[i+1].get_metadata(0).right(get_edited().get_metadata(0).find("-")+1) == "SX" ):
					Current_Edited_Bone_T = Current_Edited_Bone_T.scaled(Vector3 (M_List[i+1].get_range(0),get_edited().get_range(0),get_edited().get_range(0)))
					if(Bone_Symetry[0]=="L"):
						Current_Mirror_Bone_T = Current_Mirror_Bone_T.scaled(Vector3(M_List[i+1].get_range(0),get_edited().get_range(0),get_edited().get_range(0)))
		
						
					
				if(M_List[i+2].get_metadata(0).right(get_edited().get_metadata(0).find("-")+1) == "SY" ):
					Current_Edited_Bone_T = Current_Edited_Bone_T.scaled(Vector3 (get_edited().get_range(0),M_List[i+2].get_range(0),get_edited().get_range(0)))
					if(Bone_Symetry[0]=="L"):
						Current_Mirror_Bone_T = Current_Mirror_Bone_T.scaled(Vector3(get_edited().get_range(0),M_List[i+2].get_range(0),get_edited().get_range(0)))
		
					
				if(M_List[i+3].get_metadata(0).right(get_edited().get_metadata(0).find("-")+1) == "SZ" ):
					Current_Edited_Bone_T = Current_Edited_Bone_T.scaled(Vector3 (get_edited().get_range(0),get_edited().get_range(0),M_List[i+3].get_range(0)))
					if(Bone_Symetry[0]=="L"):
						Current_Mirror_Bone_T = Current_Mirror_Bone_T.scaled(Vector3 (get_edited().get_range(0),get_edited().get_range(0),M_List[i+3].get_range(0)))
		
				break
	
	
	
	
	if(Current_Edited_Value_Bone == "PX" or Current_Edited_Value_Bone == "PY" or Current_Edited_Value_Bone == "PZ"):
		
		for i in M_List.size():
			if (M_List[i].get_metadata(0).left(get_edited().get_metadata(0).find("-")) == Bone_name):
				var scale_value = Vector3(1.0,1.0,1.0)
				var rot_value = Vector3(0.0,0.0,0.0)
				
				if(M_List[i].get_metadata(0).right(get_edited().get_metadata(0).find("-")+1) == "SA"):
					scale_value.x = M_List[i].get_range(0)
					scale_value.y = M_List[i].get_range(0)
					scale_value.z = M_List[i].get_range(0)
				
				if(M_List[i].get_metadata(0).right(get_edited().get_metadata(0).find("-")+1) == "SX"):
					scale_value.x = M_List[i].get_range(0)
				if(M_List[i].get_metadata(0).right(get_edited().get_metadata(0).find("-")+1) == "SY"):
					scale_value.y = M_List[i].get_range(0)
				if(M_List[i].get_metadata(0).right(get_edited().get_metadata(0).find("-")+1) == "SZ"):
					scale_value.z = M_List[i].get_range(0)
				
				if(M_List[i].get_metadata(0).right(get_edited().get_metadata(0).find("-")+1) == "RX"):
					rot_value.x = M_List[i].get_range(0)
				if(M_List[i].get_metadata(0).right(get_edited().get_metadata(0).find("-")+1) == "RY"):
					rot_value.y = M_List[i].get_range(0)
				if(M_List[i].get_metadata(0).right(get_edited().get_metadata(0).find("-")+1) == "RZ"):
					rot_value.z = M_List[i].get_range(0)

				Current_Edited_Bone_T = Current_Edited_Bone_T.scaled(scale_value)
				Current_Edited_Bone_T = Current_Edited_Bone_T.rotated(Vector3(1,0,0),rot_value.x)
				Current_Edited_Bone_T = Current_Edited_Bone_T.rotated(Vector3(0,1,0),rot_value.y)
				Current_Edited_Bone_T = Current_Edited_Bone_T.rotated(Vector3(0,0,1),rot_value.z)
				
				
				
		
		
		
		
#
		

		if(Bone_Symetry[0]=="L"):
			
			for i in M_List.size():
				if (M_List[i].get_metadata(0).left(get_edited().get_metadata(0).find("-")) == Bone_name):
					var scale_value = Vector3(1.0,1.0,1.0)
					var rot_value = Vector3(0.0,0.0,0.0)
					
					if(M_List[i].get_metadata(0).right(get_edited().get_metadata(0).find("-")+1) == "SA"):
						scale_value.x = M_List[i].get_range(0)
						scale_value.y = M_List[i].get_range(0)
						scale_value.z = M_List[i].get_range(0)
					if(M_List[i].get_metadata(0).right(get_edited().get_metadata(0).find("-")+1) == "SX"):
						scale_value.x = M_List[i].get_range(0)
					if(M_List[i].get_metadata(0).right(get_edited().get_metadata(0).find("-")+1) == "SY"):
						scale_value.y = M_List[i].get_range(0)
					if(M_List[i].get_metadata(0).right(get_edited().get_metadata(0).find("-")+1) == "SZ"):
						scale_value.z = M_List[i].get_range(0)
					
					if(M_List[i].get_metadata(0).right(get_edited().get_metadata(0).find("-")+1) == "RX"):
						rot_value.x = M_List[i].get_range(0)
					if(M_List[i].get_metadata(0).right(get_edited().get_metadata(0).find("-")+1) == "RY"):
						rot_value.y = -M_List[i].get_range(0)
					if(M_List[i].get_metadata(0).right(get_edited().get_metadata(0).find("-")+1) == "RZ"):
						rot_value.z = -M_List[i].get_range(0)
	
					Current_Mirror_Bone_T = Current_Mirror_Bone_T.scaled(scale_value)
					Current_Mirror_Bone_T = Current_Mirror_Bone_T.rotated(Vector3(1,0,0),rot_value.x)
					Current_Mirror_Bone_T = Current_Mirror_Bone_T.rotated(Vector3(0,1,0),rot_value.y)
					Current_Mirror_Bone_T = Current_Mirror_Bone_T.rotated(Vector3(0,0,1),rot_value.z)
			
			
			
			
			
			
	if(Current_Edited_Value_Bone == "SX" or Current_Edited_Value_Bone == "SY" or Current_Edited_Value_Bone == "SZ"  or Current_Edited_Value_Bone == "SA"):
		
		for i in M_List.size():
			if (M_List[i].get_metadata(0).left(get_edited().get_metadata(0).find("-")) == Bone_name):
				var pos_value = Vector3(0.0,0.0,0.0)
				var rot_value = Vector3(0.0,0.0,0.0)
				
				if(M_List[i].get_metadata(0).right(get_edited().get_metadata(0).find("-")+1) == "PX"):
					pos_value.x = M_List[i].get_range(0)
				if(M_List[i].get_metadata(0).right(get_edited().get_metadata(0).find("-")+1) == "PY"):
					pos_value.y = M_List[i].get_range(0)
				if(M_List[i].get_metadata(0).right(get_edited().get_metadata(0).find("-")+1) == "PZ"):
					pos_value.z = M_List[i].get_range(0)
				
				if(M_List[i].get_metadata(0).right(get_edited().get_metadata(0).find("-")+1) == "RX"):
					rot_value.x = M_List[i].get_range(0)
				if(M_List[i].get_metadata(0).right(get_edited().get_metadata(0).find("-")+1) == "RY"):
					rot_value.y = M_List[i].get_range(0)
				if(M_List[i].get_metadata(0).right(get_edited().get_metadata(0).find("-")+1) == "RZ"):
					rot_value.z = M_List[i].get_range(0)

				Current_Edited_Bone_T = Current_Edited_Bone_T.translated(pos_value)
				Current_Edited_Bone_T = Current_Edited_Bone_T.rotated(Vector3(1,0,0),rot_value.x)
				Current_Edited_Bone_T = Current_Edited_Bone_T.rotated(Vector3(0,1,0),rot_value.y)
				Current_Edited_Bone_T = Current_Edited_Bone_T.rotated(Vector3(0,0,1),rot_value.z)
		
		
		
		
#	
		
	
		if(Bone_Symetry[0]=="L"):
			
			for i in M_List.size():
				if (M_List[i].get_metadata(0).left(get_edited().get_metadata(0).find("-")) == Bone_name):
					var pos_value = Vector3(0.0,0.0,0.0)
					var rot_value = Vector3(0.0,0.0,0.0)
					
					if(M_List[i].get_metadata(0).right(get_edited().get_metadata(0).find("-")+1) == "PX"):
						pos_value.x = -M_List[i].get_range(0)
					if(M_List[i].get_metadata(0).right(get_edited().get_metadata(0).find("-")+1) == "PY"):
						pos_value.y = M_List[i].get_range(0)
					if(M_List[i].get_metadata(0).right(get_edited().get_metadata(0).find("-")+1) == "PZ"):
						pos_value.z = M_List[i].get_range(0)
					
					if(M_List[i].get_metadata(0).right(get_edited().get_metadata(0).find("-")+1) == "RX"):
						rot_value.x = M_List[i].get_range(0)
					if(M_List[i].get_metadata(0).right(get_edited().get_metadata(0).find("-")+1) == "RY"):
						rot_value.y = -M_List[i].get_range(0)
					if(M_List[i].get_metadata(0).right(get_edited().get_metadata(0).find("-")+1) == "RZ"):
						rot_value.z = -M_List[i].get_range(0)
	
					Current_Mirror_Bone_T = Current_Mirror_Bone_T.translated(pos_value)
					Current_Mirror_Bone_T = Current_Mirror_Bone_T.rotated(Vector3(1,0,0),rot_value.x)
					Current_Mirror_Bone_T = Current_Mirror_Bone_T.rotated(Vector3(0,1,0),rot_value.y)
					Current_Mirror_Bone_T = Current_Mirror_Bone_T.rotated(Vector3(0,0,1),rot_value.z)
			
			
			
#
			
			
	
	
	if(Current_Edited_Value_Bone == "RX" or Current_Edited_Value_Bone == "RY" or Current_Edited_Value_Bone == "RZ"):
		
		for i in M_List.size():
			if (M_List[i].get_metadata(0).left(get_edited().get_metadata(0).find("-")) == Bone_name):
				var pos_value = Vector3(0.0,0.0,0.0)
				var scale_value = Vector3(1.0,1.0,1.0)
				
				if(M_List[i].get_metadata(0).right(get_edited().get_metadata(0).find("-")+1) == "SA"):
					scale_value.x = M_List[i].get_range(0)
					scale_value.y = M_List[i].get_range(0)
					scale_value.z = M_List[i].get_range(0)
				
				if(M_List[i].get_metadata(0).right(get_edited().get_metadata(0).find("-")+1) == "SX"):
					scale_value.x = M_List[i].get_range(0)
				if(M_List[i].get_metadata(0).right(get_edited().get_metadata(0).find("-")+1) == "SY"):
					scale_value.y = M_List[i].get_range(0)
				if(M_List[i].get_metadata(0).right(get_edited().get_metadata(0).find("-")+1) == "SZ"):
					scale_value.z = M_List[i].get_range(0)
				
				if(M_List[i].get_metadata(0).right(get_edited().get_metadata(0).find("-")+1) == "PX"):
					pos_value.x = M_List[i].get_range(0)
				if(M_List[i].get_metadata(0).right(get_edited().get_metadata(0).find("-")+1) == "PY"):
					pos_value.y = M_List[i].get_range(0)
				if(M_List[i].get_metadata(0).right(get_edited().get_metadata(0).find("-")+1) == "PZ"):
					pos_value.z = M_List[i].get_range(0)

				
				Current_Edited_Bone_T = Current_Edited_Bone_T.scaled(scale_value)
				Current_Edited_Bone_T = Current_Edited_Bone_T.translated(pos_value)
	
		if(Bone_Symetry[0]=="L"):
			for i in M_List.size():
				if (M_List[i].get_metadata(0).left(get_edited().get_metadata(0).find("-")) == Bone_name):
					var pos_value = Vector3(0.0,0.0,0.0)
					var scale_value = Vector3(1.0,1.0,1.0)
					
					if(M_List[i].get_metadata(0).right(get_edited().get_metadata(0).find("-")+1) == "SA"):
						scale_value.x = M_List[i].get_range(0)
						scale_value.y = M_List[i].get_range(0)
						scale_value.z = M_List[i].get_range(0)
					
					if(M_List[i].get_metadata(0).right(get_edited().get_metadata(0).find("-")+1) == "SX"):
						scale_value.x = M_List[i].get_range(0)
					if(M_List[i].get_metadata(0).right(get_edited().get_metadata(0).find("-")+1) == "SY"):
						scale_value.y = M_List[i].get_range(0)
					if(M_List[i].get_metadata(0).right(get_edited().get_metadata(0).find("-")+1) == "SZ"):
						scale_value.z = M_List[i].get_range(0)
					
					if(M_List[i].get_metadata(0).right(get_edited().get_metadata(0).find("-")+1) == "PX"):
						pos_value.x = -M_List[i].get_range(0)
					if(M_List[i].get_metadata(0).right(get_edited().get_metadata(0).find("-")+1) == "PY"):
						pos_value.y = M_List[i].get_range(0)
					if(M_List[i].get_metadata(0).right(get_edited().get_metadata(0).find("-")+1) == "PZ"):
						pos_value.z = M_List[i].get_range(0)
	
					
					Current_Mirror_Bone_T = Current_Mirror_Bone_T.scaled(scale_value)
					Current_Mirror_Bone_T = Current_Mirror_Bone_T.translated(pos_value)
			
			
	
	
	
	All_Bones.set_bone_pose(Current_Edited_Bone_ID, Current_Edited_Bone_T)
	if(Bone_Symetry[0]=="L"):
		All_Bones.set_bone_pose(Current_Mirror_Bone_ID, Current_Mirror_Bone_T)
		
#	

