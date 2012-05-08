;;; Room Commands

; Send functions
(defun connect (servername nickname realname) ; Should be used only once!
  (socket-send (format nil "USER ~a ~a ~a ~a" nickname nickname servername (concatenate 'string ":" realname)))
  (socket-send (format nil "NICK ~a" nickname)))

; Send back the ping of the server
(defun pong (username)
  (socket-send (format nil "PONG ~a" username)))

; Send message to a room to a specific user
(defun senduser (roomname username msg)
  (socket-send (format nil "PRIVMSG ~a :~a: ~a" roomname username msg)))

; Send message to a room
(defun sendroom (roomname msg)
  (socket-send (format nil "PRIVMSG ~a :~a" roomname msg)))

; Send message to a user
(defun whisper (username msg)
  (socket-send (format nil "PRIVMSG ~a :~a" username msg)))

; Set Nickname
(defun setnick (nickname)
  (setf *nick* nickname)
  (socket-send (format nil "NICK ~a" nickname)))

; Join a room
(defun join (roomname)
  (setf *room* roomname)
  (socket-send (format nil "JOIN ~a" roomname)))

;;; Mail Commands

(defparameter filename (format nil "./db/~a-~a" *server* *room*))
(defparameter stack-messages nil)

; Write message to a person
(defun write-message (from to msg)
  (with-open-file (stream filename :direction :output :if-does-not-exist :create) (format stream "~a:~a:~a" to from msg)))

; Read all messages
(defun read-database (name)
  (setf stack-messages nil)
  (stream (open filename))
  (setf line (read-line stream))
  (while (string= line nil) 
	(if (string= (subseq 0 (search ":" line)) name)
	  (push (subseq (+ 1 (search ":" line :from-end t))) stack-messages))
	(setf line (read-line stream)))) 

; Authenticate
; Later
