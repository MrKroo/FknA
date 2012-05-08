(defun process-mail (nick message)
  (setf command (subseq message 0 (search " " message)))
  (cond 
	((string= command "send")
	 ())
	((string= command "check")
	 ())
	((string= command "")
	 ())))

(defun send-mail ()
  )

(defun check-mail ()
  )
