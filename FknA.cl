(load "variables.cl")
(load "socket.cl")
(load "process.cl")

(defun process ()
  (setf buffer (socket-receive))
  (from-server-command buffer))

(defun main ()
  (socket-init *server* *port*)

  (connect *server* *nick* *realname*)
  (join *room*)

  (loop while t do (process))

  (socket-close))

; Start
(main)
