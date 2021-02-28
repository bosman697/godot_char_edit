extends Spatial


var one =0
#name of the character
var save_name ="Unknow"

# get skeleton from edited model
var skeleton_bones 
#get skeleton  from animation model
var animation_bones

#real position of the bones
var Real_Rest_Skeleton_Origin = Array()
#real position  rot of the bones in t pose
var Real_Rest_Skeleton_Basis_Rotation = Array()



# Called when the node enters the scene tree for the first time.
func _ready():
	
	
	
#	 get skeleton from edited model
	skeleton_bones = get_node("Body/Char_Editor_Armature/Skeleton")
#	get skeleton from animation model
#	animation_bones = get_node("Main_Body/Armature/Skeleton")
	
	
#	real reset bone position 
	for rS in  skeleton_bones.get_bone_count():
		Real_Rest_Skeleton_Origin.append(skeleton_bones.get_bone_global_pose(rS).origin)
		Real_Rest_Skeleton_Basis_Rotation.append(skeleton_bones.get_bone_global_pose(rS).basis.get_rotation_quat())
			







func make_M_Tools(animation_instance):
#	 array  from MeshDataTool Edit_Body
	var mtool_Array = []
#	 array  from MeshDataTool Armature_body
	var ztool_Array = []
#	materials
	var surface_count_before_remove = []
# name of the materials
	var surface_material_name = []
	#	return this
	var ar_surface
#	for secount mesh data tool
	var ar_surface2
#	get skeleton from animation_body 
	var animation_bones = animation_instance.get_child(0).get_child(0)
#	meshdatattool for edit_body
	for mt in skeleton_bones.get_child_count():
		if(skeleton_bones.get_child(mt).visible ==true):
			for iki in skeleton_bones.get_child(mt).get_mesh().get_surface_count():
				var mtool = MeshDataTool.new()
				mtool.create_from_surface(skeleton_bones.get_child(mt).get_mesh(),iki)
				mtool_Array.append(mtool)
			
#	meshdatatool for armature body 
	for mt in animation_bones.get_child_count():
		for iki in animation_bones.get_child(mt).get_mesh().get_surface_count():
			var mtool = MeshDataTool.new()
			mtool.create_from_surface(animation_bones.get_child(mt).get_mesh(),iki)
			ztool_Array.append(mtool)
	

	var new_vertex_position = Vector3(0.0,0.0,0.0)
	
#	magic
	for a in mtool_Array.size():
		
		
		for i in range(mtool_Array[a].get_vertex_count()):
			var bone_index = mtool_Array[a].get_vertex_bones(i)
			var vertex_bone_weight = mtool_Array[a].get_vertex_weights(i)
			var find_bone0_position = skeleton_bones.get_bone_custom_pose(bone_index[0])
			var find_bone1_position = skeleton_bones.get_bone_custom_pose(bone_index[1])
			var find_bone2_position = skeleton_bones.get_bone_custom_pose(bone_index[2])
			var find_bone3_position = skeleton_bones.get_bone_custom_pose(bone_index[3])
			
			var Gfind_bone0_position = skeleton_bones.get_bone_global_pose(bone_index[0]).origin - Real_Rest_Skeleton_Origin[bone_index[0]]
			var Gfind_bone1_position = skeleton_bones.get_bone_global_pose(bone_index[1]).origin - Real_Rest_Skeleton_Origin[bone_index[1]]
			var Gfind_bone2_position = skeleton_bones.get_bone_global_pose(bone_index[2]).origin - Real_Rest_Skeleton_Origin[bone_index[2]]
			var Gfind_bone3_position = skeleton_bones.get_bone_global_pose(bone_index[3]).origin - Real_Rest_Skeleton_Origin[bone_index[3]]
			
			
			var G2find_bone0_position = skeleton_bones.get_bone_global_pose(bone_index[0]) 
			var G2find_bone1_position = skeleton_bones.get_bone_global_pose(bone_index[1]) 
			var G2find_bone2_position = skeleton_bones.get_bone_global_pose(bone_index[2]) 
			var G2find_bone3_position = skeleton_bones.get_bone_global_pose(bone_index[3]) 
			
			
			var scal1 = Vector3(1.0,1.0,1.0)
			var scal2 = Vector3(1.0,1.0,1.0)
			var scal3 = Vector3(1.0,1.0,1.0)
			var scal4 = Vector3(1.0,1.0,1.0)
			
			var C_rotage0 = Vector3(G2find_bone0_position.basis.get_rotation_quat().x,G2find_bone0_position.basis.get_rotation_quat().y,G2find_bone0_position.basis.get_rotation_quat().z) - Vector3(Real_Rest_Skeleton_Basis_Rotation[bone_index[0]].x,Real_Rest_Skeleton_Basis_Rotation[bone_index[0]].y,Real_Rest_Skeleton_Basis_Rotation[bone_index[0]].z)
			var C_rotage1 = Vector3(G2find_bone1_position.basis.get_rotation_quat().x,G2find_bone1_position.basis.get_rotation_quat().y,G2find_bone1_position.basis.get_rotation_quat().z) - Vector3(Real_Rest_Skeleton_Basis_Rotation[bone_index[1]].x,Real_Rest_Skeleton_Basis_Rotation[bone_index[1]].y,Real_Rest_Skeleton_Basis_Rotation[bone_index[1]].z)
			var C_rotage2 = Vector3(G2find_bone2_position.basis.get_rotation_quat().x,G2find_bone2_position.basis.get_rotation_quat().y,G2find_bone2_position.basis.get_rotation_quat().z) - Vector3(Real_Rest_Skeleton_Basis_Rotation[bone_index[2]].x,Real_Rest_Skeleton_Basis_Rotation[bone_index[2]].y,Real_Rest_Skeleton_Basis_Rotation[bone_index[2]].z)
			var C_rotage3 = Vector3(G2find_bone3_position.basis.get_rotation_quat().x,G2find_bone3_position.basis.get_rotation_quat().y,G2find_bone3_position.basis.get_rotation_quat().z) - Vector3(Real_Rest_Skeleton_Basis_Rotation[bone_index[3]].x,Real_Rest_Skeleton_Basis_Rotation[bone_index[3]].y,Real_Rest_Skeleton_Basis_Rotation[bone_index[3]].z)
#			

			var rot1 = Vector3(1.0,1.0,1.0)
			var rot2 = Vector3(1.0,1.0,1.0)
			var rot3 = Vector3(1.0,1.0,1.0)
			var rot4 = Vector3(1.0,1.0,1.0)
			


#			for position 
			new_vertex_position =   mtool_Array[a].get_vertex(i) +  (Gfind_bone0_position * vertex_bone_weight[0])+(Gfind_bone1_position * vertex_bone_weight[1])+(Gfind_bone2_position * vertex_bone_weight[2])+(Gfind_bone3_position * vertex_bone_weight[3])
			
#			for rotation
			
			rot1  = new_vertex_position  + 2.0*  C_rotage0.cross(C_rotage0.cross(new_vertex_position-skeleton_bones.get_bone_global_pose(bone_index[0]).origin) + find_bone0_position.basis.get_rotation_quat().w * (new_vertex_position-skeleton_bones.get_bone_global_pose(bone_index[0]).origin))
			rot1 = rot1 * vertex_bone_weight[0]

			rot2  = new_vertex_position  + 2.0*  C_rotage1.cross(C_rotage1.cross(new_vertex_position-skeleton_bones.get_bone_global_pose(bone_index[1]).origin) + find_bone1_position.basis.get_rotation_quat().w * (new_vertex_position-skeleton_bones.get_bone_global_pose(bone_index[1]).origin))
			rot2 = rot2 * vertex_bone_weight[1]

			rot3  = new_vertex_position  + 2.0*  C_rotage2.cross(C_rotage2.cross(new_vertex_position-skeleton_bones.get_bone_global_pose(bone_index[2]).origin) + find_bone2_position.basis.get_rotation_quat().w * (new_vertex_position-skeleton_bones.get_bone_global_pose(bone_index[2]).origin))
			rot3 = rot3 * vertex_bone_weight[2]

			rot4  = new_vertex_position  +  2.0* C_rotage3.cross(C_rotage3.cross(new_vertex_position-skeleton_bones.get_bone_global_pose(bone_index[3]).origin) + find_bone3_position.basis.get_rotation_quat().w * (new_vertex_position-skeleton_bones.get_bone_global_pose(bone_index[3]).origin))
			rot4 = rot4 * vertex_bone_weight[3]

			new_vertex_position =rot1 +rot2+rot3+rot4
#
##			for scale 
#
#
			scal1 = ((new_vertex_position - skeleton_bones.get_bone_global_pose(bone_index[0]).origin) * (Vector3(G2find_bone0_position.basis.get_scale()[0],G2find_bone0_position.basis.get_scale()[1],G2find_bone0_position.basis.get_scale()[2]) )) +  (skeleton_bones.get_bone_global_pose(bone_index[0]).origin )
			scal1 = scal1 *vertex_bone_weight[0]


			scal2 =  ((new_vertex_position - skeleton_bones.get_bone_global_pose(bone_index[1]).origin)* (Vector3(G2find_bone1_position.basis.get_scale()[0],G2find_bone1_position.basis.get_scale()[1],G2find_bone1_position.basis.get_scale()[2]) ))+  (skeleton_bones.get_bone_global_pose(bone_index[1]).origin)
			scal2 = scal2 *vertex_bone_weight[1]



			scal3 = ((new_vertex_position - skeleton_bones.get_bone_global_pose(bone_index[2]).origin)* (Vector3(G2find_bone2_position.basis.get_scale()[0],G2find_bone2_position.basis.get_scale()[1],G2find_bone2_position.basis.get_scale()[2]) ))+   (skeleton_bones.get_bone_global_pose(bone_index[2]).origin )
			scal3 = scal3 *vertex_bone_weight[2]



			scal4 = ((new_vertex_position - skeleton_bones.get_bone_global_pose(bone_index[3]).origin)* (Vector3(G2find_bone3_position.basis.get_scale()[0],G2find_bone3_position.basis.get_scale()[1],G2find_bone3_position.basis.get_scale()[2]) )) + (skeleton_bones.get_bone_global_pose(bone_index[3]).origin )
			scal4 = scal4 *vertex_bone_weight[3]

			new_vertex_position =  (scal1+scal2+scal3+scal4) 
		
			mtool_Array[a].set_vertex(i,new_vertex_position)

#	set vertex from edit body to vertex armature body
	for b in ztool_Array.size():
		for i in mtool_Array[b].get_vertex_count():
			ztool_Array[b].set_vertex(i,mtool_Array[b].get_vertex(i))
			
	
	
	
#	remove surface from armature body 
	for iki in animation_instance.get_child(0).get_child(0).get_child_count():
		ar_surface = animation_instance.get_child(0).get_child(0).get_child(iki).get_mesh()
		surface_count_before_remove.append(ar_surface.get_surface_count())
		for z in ar_surface.get_surface_count():
			ar_surface.surface_remove(0)
			
	
	
#commit to surface on armature body
	var i_for_ar = 0
	for ik in animation_instance.get_child(0).get_child(0).get_child_count():
		ar_surface2 = animation_instance.get_child(0).get_child(0).get_child(ik).get_mesh()
		for kk in surface_count_before_remove[ik]:
			
			ztool_Array[i_for_ar].commit_to_surface(ar_surface2)
			i_for_ar = i_for_ar+1
			
	
	
	

# save char to tscn
func _on_save_pressed():
	
#	empty scene neet only for duplication 
	var Empty_Scene = load("res://Characters/Empty_Stage_for_save.tscn").instance().duplicate()
#	path to main body (with animations )
	var Main_Body = load("res://Characters/Body.tscn").instance()
# duplicate main body 
	var new_chracter = Main_Body.duplicate()
	
#	--------------make meshdatatools---------------
	make_M_Tools(new_chracter)
	
	
#	--------------save to file  (tscn file)-----------------
	
	var dir = Directory.new()
#	create folder in godot .exe
	var path = OS.get_executable_path().get_base_dir().plus_file("Save_Char")
	dir.make_dir(path)
	
	var file = File.new()
	
	var tmpl_instance = new_chracter
	
	
	var ps = PackedScene.new()
	var result = ps.pack(tmpl_instance)
	
	
	if result == OK:
		
		ResourceSaver.save(path+"/"+save_name+".tscn",ps)
		
	
	




func _on_rungame_pressed():
	
	get_tree().change_scene("res://Save_Char/Stage.tscn")



