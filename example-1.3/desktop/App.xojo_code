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
		  gtk_window_set_title(window, "Icon")
		  
		  // mimick Xojo default window size, 600x400
		  gtk_window_set_default_size(window, 600, 400) 
		  gtk_window_set_position(window, GTK_WIN_POS_CENTER)
		  
		  // NOTE: icon.png should be copied into ExecutableFile.Parent folder FIRST
		  dim fi as FolderItem = App.path.Child("icon.png")
		  dim icon as Ptr = create_pixbuf(fi.NativePath)
		  gtk_window_set_icon(window, icon)
		  
		  gtk_widget_show(window)
		  
		  g_signal_connect(window, "destroy", WeakAddressOf GtkMainQuit, Nil)
		  
		  g_object_unref(icon)
		  gtk_main()
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Function create_pixbuf(filename as String) as Ptr
		  dim error as ptr
		  dim pixbuf as ptr = gdk_pixbuf_new_from_file(filename, error)
		  
		  If (pixbuf = Nil) then
		    // TODO: Convert error ptr to GError
		    MsgBox "Can't create pixbuf"
		    g_error_free(error)
		  End If
		  
		  Return pixbuf
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub GtkMainQuit()
		  gtk_main_quit()
		End Sub
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  #If DebugBuild
			    Return App.ExecutableFile.Parent.Parent
			  #Endif
			  
			  Return App.ExecutableFile.Parent
			End Get
		#tag EndGetter
		path As FolderItem
	#tag EndComputedProperty


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
