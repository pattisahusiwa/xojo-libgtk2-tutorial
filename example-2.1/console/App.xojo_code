#tag Class
Protected Class App
Inherits ConsoleApplication
	#tag Event
		Function Run(args() as String) As Integer
		  dim argc as Integer = args.Ubound
		  dim argv as CString = Join(args, " ")
		  
		  gtk_init(argc, argv)
		  
		  dim window as Ptr = gtk_window_new(GTK_WINDOW_TOPLEVEL)
		  gtk_window_set_position(window, GTK_WIN_POS_CENTER)
		  // mimick Xojo default window size, 600x400
		  gtk_window_set_default_size(window, 600, 400)
		  gtk_window_set_title(window, "Simple menu")
		  
		  dim vbox as ptr = gtk_vbox_new(False, 0)
		  gtk_container_add(window, vbox)
		  
		  dim menubar as ptr = gtk_menu_bar_new()
		  dim fileMenu as ptr = gtk_menu_new()
		  
		  dim fileMi as ptr = gtk_menu_item_new_with_label("File")
		  dim quitMi as ptr = gtk_menu_item_new_with_label("Quit")
		  
		  gtk_menu_item_set_submenu(fileMi, fileMenu)
		  gtk_menu_shell_append(fileMenu, quitMi)
		  gtk_menu_shell_append(menubar, fileMi)
		  gtk_box_pack_start(vbox, menubar, False, False, 0)
		  
		  g_signal_connect(window, "destroy", WeakAddressOf GtkMainQuit, Nil)
		  g_signal_connect(quitMi, "activate", WeakAddressOf GtkMainQuit, Nil)
		  
		  gtk_widget_show_all(window)
		  gtk_main()
		  Return 0
		End Function
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub GtkMainQuit()
		  gtk_main_quit()
		End Sub
	#tag EndMethod


	#tag ViewBehavior
	#tag EndViewBehavior
End Class
#tag EndClass
