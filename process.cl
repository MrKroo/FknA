(load "commands.cl")

; Processing text
(defun process (buff)
  (setf line buff)

  (setf name nil)
  (if (char= #\: (char line 0))
	(progn
	  (setf name (subseq line 1 (search "!" line)))
	  (setf line (subseq line (+ 1 (search " " buff))))))

  (setf command (subseq line 0 (search " " line)))

  (setf params nil)
  (loop while (search " " line) do
	(setf line (subseq line (+ 1 (search " " line))))
	(if (char= #\: (char line 0))
	  (progn
		(push (subseq line 1) params)
		(setf line ""))
	  (push (subseq line 0 (search " " line)) params)))
  (nreverse params)

  (process-command command params))

; Processing commands
(defun process-command (command params)
  (cond
	((string-equal command "PING")
	   (pong (elt params 0)))
	((string-equal command "ERROR")
	   (print buff))
	((and (string-equal command "PRIVMSG") (string= (format "~a : " *nick*) (subseq 0 (+ 2 (length *nick*))) (elt params 1)))
		  (process-mail-command (subseq (+ 2 (length *nick*) (search " " (elt params 1) :start (+ 2 (length *nick*)))) (elt params 1))))

; Process mail command
(defun process-mail-command (command)
  (cond
	((string= command ".send")
	   (command-send))
	((string= command ".check")
	   (command-check))))

(defun command-send (username)
  ())

(defun command-check (username)
  ())
