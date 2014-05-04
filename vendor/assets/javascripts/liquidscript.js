(exec 
  (_context 
   ()) 
  (call 
   (expression 
    (function 
     (exec 
      (_context 
       (Liquidscript Promise)) 
      (_arguments 
       ()) 
      (set 
       (_variable Liquidscript) 
       (function 
        (exec 
         (_context 
          (opt)) 
         (_arguments 
          (
           (identifier opt))) 
         (if 
          (unop 
           (preunop !) 
           (expression 
            (binop 
             (binop instanceof) 
             (_variable this) 
             (_variable Liquidscript)))) 
          (
           (return 
            (unop 
             (preunop new) 
             (call 
              (_variable Liquidscript) 
              (_variable opt))))) 
          (elsif 
           (property 
            (_variable this) initialize) 
           (
            (call 
             (property 
              (property 
               (_variable this) initialize) apply) 
             (_variable this) 
             (_variable arguments)))))))) 
      (set 
       (property 
        (_variable Liquidscript) prototype) 
       (_variable Liquidscript)) 
      (class 
       (identifier Liquidscript) 
       (
        (
         (identifier singleton) 
         (function 
          (exec 
           (_context 
            (fn ran memo)) 
           (_arguments 
            (
             (identifier fn))) 
           (set 
            (_variable ran) 
            (keyword 
             (keyword false))) 
           (set 
            (_variable memo) 
            (call 
             (keyword 
              (keyword undefined)))) 
           (function 
            (exec 
             (_context 
              (ran memo)) 
             (_arguments 
              ()) 
             (if 
              (_variable ran) 
              (
               (return 
                (_variable memo)))) 
             (set 
              (_variable ran) 
              (keyword 
               (keyword true))) 
             (set 
              (_variable memo) 
              (call 
               (property 
                (_variable fn) apply) 
               (keyword 
                (keyword null)) 
               (_variable arguments)))))))))) 
      (exec 
       (_context 
        ()) 
       (class 
        (identifier Liquidscript) 
        (
         (class 
          (identifier Promise) 
          (
           (
            (identifier onFulfilled) 
            (array 
             ())) 
           (
            (identifier onRejected) 
            (array 
             ())) 
           (
            (identifier func) 
            (keyword 
             (keyword undefined))) 
           (
            (identifier state) 
            (keyword 
             (keyword undefined))) 
           (
            (identifier initialize) 
            (function 
             (exec 
              (_context 
               (fn)) 
              (_arguments 
               (
                (identifier fn))) 
              (set 
               (property 
                (_variable this) onFulfilled) 
               (array 
                ())) 
              (set 
               (property 
                (_variable this) onRejected) 
               (array 
                ())) 
              (set 
               (property 
                (_variable this) func) 
               (_variable fn)) 
              (set 
               (property 
                (_variable this) state) 
               (istring pending))))) 
           (
            (identifier then) 
            (function 
             (exec 
              (_context 
               (fulfilled rejected)) 
              (_arguments 
               (
                (identifier fulfilled) 
                (identifier rejected))) 
              (if 
               (binop 
                (binop instanceof) 
                (_variable fulfilled) 
                (_variable Function)) 
               (
                (call 
                 (property 
                  (property 
                   (_variable this) onFulfilled) push) 
                 (_variable fulfilled)))) 
              (if 
               (binop 
                (binop instanceof) 
                (_variable rejected) 
                (_variable Function)) 
               (
                (call 
                 (property 
                  (property 
                   (_variable this) onRejected) push) 
                 (_variable rejected))))))) 
           (
            (identifier reject) 
            (function 
             (exec 
              (_context 
               ()) 
              (_arguments 
               ()) 
              (keyword 
               (keyword null))))) 
           (
            (identifier fulfill) 
            (function 
             (exec 
              (_context 
               ()) 
              (_arguments 
               ()) 
              (keyword 
               (keyword null))))) 
           (
            (identifier resolve) 
            (function 
             (exec 
              (_context 
               (value self thenProperty e resolved)) 
              (_arguments 
               (
                (identifier value))) 
              (set 
               (_variable self) 
               (_variable this)) 
              (set 
               (property 
                (_variable this) value) 
               (_variable value)) 
              (if 
               (binop 
                (binop ==) 
                (_variable this) 
                (_variable value)) 
               (
                (return 
                 (call 
                  (_variable reject) 
                  (_variable TypeError)))) 
               (elsif 
                (binop 
                 (binop instanceof) 
                 (_variable value) 
                 (_variable Promise)) 
                (
                 (call 
                  (property 
                   (_variable value) then) 
                  (function 
                   (exec 
                    (_context 
                     (v)) 
                    (_arguments 
                     (
                      (identifier v))) 
                    (call 
                     (property 
                      (_variable self) fulfill) 
                     (_variable v)))) 
                  (function 
                   (exec 
                    (_context 
                     (e)) 
                    (_arguments 
                     (
                      (identifier e))) 
                    (call 
                     (property 
                      (_variable self) reject) 
                     (_variable e)))))))) 
              (try 
               (
                (set 
                 (_variable thenProperty) 
                 (property 
                  (_variable value) then))) 
               (catch 
                (_variable e) 
                (
                 (return 
                  (call 
                   (_variable reject) 
                   (_variable e)))))) 
              (if 
               (_variable thenProperty) 
               (
                (set 
                 (_variable resolved) 
                 (keyword 
                  (keyword false))) 
                (try 
                 (
                  (call 
                   (_variable thenProperty) 
                   (function 
                    (exec 
                     (_context 
                      (v resolved)) 
                     (_arguments 
                      (
                       (identifier v))) 
                     (if 
                      (_variable resolved) 
                      (
                       (return 
                        (keyword 
                         (keyword null))))) 
                     (set 
                      (_variable resolved) 
                      (keyword 
                       (keyword true))) 
                     (call 
                      (property 
                       (_variable self) resolve) 
                      (_variable v)))) 
                   (function 
                    (exec 
                     (_context 
                      (e resolved)) 
                     (_arguments 
                      (
                       (identifier e))) 
                     (if 
                      (_variable resolved) 
                      (
                       (return 
                        (keyword 
                         (keyword null))))) 
                     (set 
                      (_variable resolved) 
                      (keyword 
                       (keyword true))) 
                     (call 
                      (property 
                       (_variable self) reject) 
                      (_variable e)))))) 
                 (catch 
                  (_variable e) 
                  (
                   (if 
                    (unop 
                     (preunop !) 
                     (_variable resolved)) 
                    (
                     (call 
                      (_variable reject) 
                      (_variable e)))))))) 
               (else 
                (
                 (call 
                  (_variable fulfill) 
                  (_variable value))))))))))))))))))