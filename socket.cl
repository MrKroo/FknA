; Socket stream (send and receive packets)
(defvar socket nil)

; Connection to server
(defun socket-init (server port)
  (setf socket (socket-connect port server :external-format charset:iso-8859-1))) ; Charset for portability

; Close connection
(defun socket-close ()
  (socket-stream-shutdown socket :output))

; Send packet
(defun socket-send (str)
  (format socket (format nil "~a~%" str))
  (force-output socket))

; Receive packet
(defun socket-receive ()
  (setf buff (read-line socket))
  (if (string/= nil buff) buff))
