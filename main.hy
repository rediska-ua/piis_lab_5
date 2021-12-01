(import [pandas :as pd])
(import [numpy :as np])

(setv data (pd.read_csv "output.csv"))

(setv time (get data "time"))
(print "Expected value:" (.mean time))

(setv score (get data "score"))
(print "Variance:" (.var score))

(setv matrix [[0 0 0 0 0] 
[0 1 1 0 0] 
[0 1 1 1 0] 
[0 1 1 1 0] 
[0 0 0 0 0]])

(setv start_pacman_position [1 2])
(setv start_ghost_position [3 2])
(defn var[] -1)


(defn manhattan [pacman_x pacman_y ghost_x ghost_y]
    (+ (abs (- pacman_x ghost_x)) (abs (- pacman_y ghost_y))))



(defn to_move_ghost [matrix pos_p pos_g] 


    (setv result [10000 []])

    (if (= (get matrix (get pos_g 0) (+ (get pos_g 1) 1)) 1)
        (if (< (manhattan (get pos_g 0) (+ (get pos_g 1) 1) (get pos_p 0) (get pos_p 1)) (get result 0))

            (setv result [(manhattan (get pos_g 0) (+ (get pos_g 1) 1) (get pos_p 0) (get pos_p 1)) [(get pos_g 0) (+ (get pos_g 1) 1)]])

            (setv var 0))
        (setv var 0))



    (if (= (get matrix (get pos_g 0) (- (get pos_g 1) 1)) 1)
        (if (< (manhattan (get pos_g 0) (- (get pos_g 1) 1) (get pos_p 0) (get pos_p 1)) (get result 0))

            (setv result [(manhattan (get pos_g 0) (- (get pos_g 1) 1) (get pos_p 0) (get pos_p 1)) [(get pos_g 0) (- (get pos_g 1) 1)]])

            (setv var 0))
        (setv var 0))



    (if (= (get matrix (+ (get pos_g 0) 1) (get pos_g 1)) 1)
        (if (< (manhattan (+ (get pos_g 0) 1) (get pos_g 1) (get pos_p 0) (get pos_p 1)) (get result 0))

            (setv result [(manhattan (- (get pos_g 1) 0) (get pos_g 1) (get pos_p 0) (get pos_p 1)) [(- (get pos_g 1) 0) (get pos_g 1)]])

            (setv var 0))
        (setv var 0))



    (if (= (get matrix (- (get pos_g 0) 1) (get pos_g 1)) 1)
        (if (< (manhattan (- (get pos_g 0) 1) (get pos_g 1) (get pos_p 0) (get pos_p 1)) (get result 0))

            (setv result [(manhattan (- (get pos_g 1) 0) (get pos_g 1) (get pos_p 0) (get pos_p 1)) [(- (get pos_g 1) 0) (get pos_g 1)]])

            (setv var 0))
        (setv var 0))

    
    (return (get result 1))
)

(defn to_move_pacman [matrix pos_g pos_p ] 


    (setv result [0 []])

    (if (= (get matrix (- (get pos_g 0) 1) (get pos_g 1)) 1)
        (if (> (manhattan (- (get pos_g 0) 1) (get pos_g 1) (get pos_p 0) (get pos_p 1)) (get result 0))

            (setv result [(manhattan (- (get pos_g 1) 0) (get pos_g 1) (get pos_p 0) (get pos_p 1)) [(- (get pos_g 1) 0) (get pos_g 1)]])

            (setv var 0))
        (setv var 0))



    (if (= (get matrix (+ (get pos_g 0) 1) (get pos_g 1)) 1)
        (if (> (manhattan (+ (get pos_g 0) 1) (get pos_g 1) (get pos_p 0) (get pos_p 1)) (get result 0))

            (setv result [(manhattan (- (get pos_g 1) 0) (get pos_g 1) (get pos_p 0) (get pos_p 1)) [(- (get pos_g 1) 0) (get pos_g 1)]])

            (setv var 0))
        (setv var 0))



    (if (= (get matrix (get pos_g 0) (+ (get pos_g 1) 1)) 1)
        (if (> (manhattan (get pos_g 0) (+ (get pos_g 1) 1) (get pos_p 0) (get pos_p 1)) (get result 0))

            (setv result [(manhattan (get pos_g 0) (+ (get pos_g 1) 1) (get pos_p 0) (get pos_p 1)) [(get pos_g 0) (+ (get pos_g 1) 1)]])

            (setv var 0))
        (setv var 0))



    (if (= (get matrix (get pos_g 0) (- (get pos_g 1) 1)) 1)
        (if (> (manhattan (get pos_g 0) (- (get pos_g 1) 1) (get pos_p 0) (get pos_p 1)) (get result 0))

            (setv result [(manhattan (get pos_g 0) (- (get pos_g 1) 1) (get pos_p 0) (get pos_p 1)) [(get pos_g 0) (- (get pos_g 1) 1)]])

            (setv var 0))
        (setv var 0))
    
    (return (get result 1))
)

(print "Starting ghost position" start_ghost_position)
(print "Starting pacman position" start_pacman_position)

(setv best_ghost_position (to_move_ghost matrix start_pacman_position start_ghost_position))
(print "Next best ghost step" best_ghost_position)

(setv best_pacman_position (to_move_pacman matrix start_pacman_position start_ghost_position))
(print "Next best pacman step" best_pacman_position)