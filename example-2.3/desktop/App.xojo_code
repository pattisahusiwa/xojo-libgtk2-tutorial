#tag Class
Protected Class App
Inherits Application
	#tag Event
		Sub Open()
		  dim args(-1) as String = Array(App.ExecutableFile.NativePath)
		  dim argc as Integer = args.Ubound
		  dim argv as CString = Join(args, " ")
		  
		  gtk_init(argc, argv)
		  
		  dim window as Ptr = gtk_window_new(GTK_WINDOW_TOPLEVEL)
		  gtk_window_set_position(window, GTK_WIN_POS_CENTER)
		  // mimick Xojo default window size, 600x400
		  gtk_window_set_default_size(window, 600, 400)
		  gtk_window_set_title(window, "Images")
		  
		  dim vbox as ptr = gtk_vbox_new(False, 0)
		  gtk_container_add(window, vbox)
		  
		  dim menubar as ptr = gtk_menu_bar_new()
		  dim fileMenu as ptr = gtk_menu_new()
		  
		  dim accel_group as Ptr = gtk_accel_group_new()
		  gtk_window_add_accel_group(window, accel_group)
		  
		  dim fileMi as ptr = gtk_menu_item_new_with_mnemonic("_File")
		  dim newMi as Ptr = gtk_image_menu_item_new_from_stock(GTK_STOCK_NEW, Nil)
		  dim openMi as Ptr = gtk_image_menu_item_new_from_stock(GTK_STOCK_OPEN, Nil)
		  dim sep as ptr = gtk_separator_menu_item_new()
		  dim quitMi as ptr = gtk_image_menu_item_new_from_stock(GTK_STOCK_QUIT, accel_group)
		  
		  Const GDK_Q = 81
		  gtk_widget_add_accelerator(quitMi, "activate", accel_group, GDK_Q, GDK_CONTROL_MASK, GTK_ACCEL_VISIBLE)
		  
		  gtk_menu_item_set_submenu(fileMi, fileMenu)
		  gtk_menu_shell_append(fileMenu, newMi)
		  gtk_menu_shell_append(fileMenu, openMi)
		  gtk_menu_shell_append(fileMenu, sep)
		  gtk_menu_shell_append(fileMenu, quitMi)
		  gtk_menu_shell_append(menubar, fileMi)
		  gtk_box_pack_start(vbox, menubar, False, False, 0)
		  
		  g_signal_connect(window, "destroy", WeakAddressOf GtkMainQuit, Nil)
		  g_signal_connect(quitMi, "activate", WeakAddressOf GtkMainQuit, Nil)
		  
		  gtk_widget_show_all(window)
		  gtk_main()
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub GtkMainQuit()
		  gtk_main_quit()
		End Sub
	#tag EndMethod


	#tag Constant, Name = kEditClear, Type = String, Dynamic = False, Default = \"&Delete", Scope = Public
		#Tag Instance, Platform = Windows, Language = Default, Definition  = \"&Delete"
		#Tag Instance, Platform = Linux, Language = Default, Definition  = \"&Delete"
	#tag EndConstant

	#tag Constant, Name = kFileQuit, Type = String, Dynamic = False, Default = \"&Quit", Scope = Public
		#Tag Instance, Platform = Windows, Language = Default, Definition  = \"E&xit"
	#tag EndConstant

	#tag Constant, Name = kFileQuitShortcut, Type = String, Dynamic = False, Default = \"", Scope = Public
		#Tag Instance, Platform = Mac OS, Language = Default, Definition  = \"Cmd+Q"
		#Tag Instance, Platform = Linux, Language = Default, Definition  = \"Ctrl+Q"
	#tag EndConstant


	#tag ViewBehavior
	#tag EndViewBehavior
End Class
#tag EndClass
