(load "commands.cl")

; Processing buffer 
(defun process-buffer (buffer)
  (setf nick "")

  (if (string= buffer ":" :end1 1)
    (progn
      (setf nick (subseq buffer 1 (search "!" buffer :start2 1)))
      (setf buffer (subseq buffer (search " " buffer)))))

  (setf command (subseq buffer 1 (search " " buffer :start2 1)))
  (setf buffer (subseq buffer (search " " buffer)))
  
  (process-command nick command buffer))

; Process command
(defun process-command (nick command buffer)
  (loop for args = ()
		while (search " " buffer :start2 1)
		do (setf buffer (subseq buffer 1 (search " " buffer :start2 1)))) 
  (cond
	((string-equal command "PING")
	 (pong (subseq buffer 1)))

	((string-equal command "PRIVMSG")
	 (cond 
	   ((string= (format nil " ~a :~a:" *room* *nick*) buffer)
		())))))

; Process mail command
(defun process-mail-command (command)
  (cond
	((string= command ".send")
	   (command-send))
	((string= command ".check")
	   (command-check))))
