#tag Class
Protected Class App
Inherits ConsoleApplication
	#tag Event
		Function Run(args() as String) As Integer
		  dim argc as Integer = args.Ubound
		  dim argv as CString = Join(args, " ")
		  
		  gtk_init(argc, argv)
		  
		  dim window as Ptr = gtk_window_new(GTK_WINDOW_TOPLEVEL)
		  gtk_window_set_title(window, "Icon")
		  
		  // mimick Xojo default window size, 600x400
		  gtk_window_set_default_size(window, 600, 400) 
		  gtk_window_set_position(window, GTK_WIN_POS_CENTER)
		  
		  // NOTE: icon.png should be copied into ExecutableFile.Parent folder FIRST
		  dim fi as FolderItem = App.ExecutableFile.Parent.Child("icon.png")
		  dim icon as Ptr = create_pixbuf(fi.NativePath)
		  gtk_window_set_icon(window, icon)
		  
		  gtk_widget_show(window)
		  
		  g_signal_connect(window, "destroy", WeakAddressOf GtkMainQuit, Nil)
		  
		  g_object_unref(icon)
		  gtk_main()
		  
		  Return 0
		End Function
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Function create_pixbuf(filename as String) As Ptr
		  dim error as ptr
		  dim pixbuf as ptr = gdk_pixbuf_new_from_file(filename, error)
		  
		  If (pixbuf = Nil) then
		    // TODO: Convert error ptr to GError
		    Print "Can't create pixbuf"
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


	#tag ViewBehavior
	#tag EndViewBehavior
End Class
#tag EndClass
