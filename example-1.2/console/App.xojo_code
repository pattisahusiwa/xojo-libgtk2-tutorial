#tag Class
Protected Class App
Inherits ConsoleApplication
	#tag Event
		Function Run(args() as String) As Integer
		  dim argc as Integer = args.Ubound
		  dim argv as CString = Join(args, " ")
		  
		  gtk_init(argc, argv)
		  
		  dim window as Ptr = gtk_window_new(GTK_WINDOW_TOPLEVEL)
		  gtk_window_set_title(window, "Center")
		  
		  // mimick Xojo default window size, 600x400
		  gtk_window_set_default_size(window, 600, 400) 
		  gtk_window_set_position(window, GTK_WIN_POS_CENTER)
		  gtk_widget_show(window)
		  
		  g_signal_connect(window, "destroy", WeakAddressOf GtkMainQuit, Nil)
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
