;; Carbon Credits Contract
;; Allows minting, transferring, and retiring carbon credits (measured in tons CO2 offset)

(define-data-var admin principal tx-sender)

(define-map balances {account: principal} {amount: uint})
(define-map retired {account: principal} {amount: uint})

;; -------------------
;; Helpers
;; -------------------
(define-read-only (get-admin)
  (var-get admin)
)

(define-read-only (get-balance (account principal))
  (default-to u0 (get amount (map-get? balances {account: account})))
)

(define-read-only (get-retired (account principal))
  (default-to u0 (get amount (map-get? retired {account: account})))
)

;; -------------------
;; Core Functions
;; -------------------

;; Only admin can mint new credits
(define-public (mint (recipient principal) (amount uint))
  (begin
    (asserts! (is-eq tx-sender (var-get admin)) (err "Only admin can mint"))
    (let ((current (default-to u0 (get amount (map-get? balances {account: recipient})))))
      (map-set balances {account: recipient} {amount: (+ current amount)})
    )
    (ok amount)
  )
)

;; Transfer credits from caller to another account
(define-public (transfer (to principal) (amount uint))
  (let ((sender-bal (get-balance tx-sender)))
    (begin
      (asserts! (>= sender-bal amount) (err "Not enough credits"))
      ;; deduct from sender
      (map-set balances {account: tx-sender} {amount: (- sender-bal amount)})
      ;; add to receiver
      (let ((receiver-bal (default-to u0 (get amount (map-get? balances {account: to})))))
        (map-set balances {account: to} {amount: (+ receiver-bal amount)})
      )
      (ok true)
    )
  )
)

;; Retire credits (burn them permanently)
(define-public (retire (amount uint))
  (let ((bal (get-balance tx-sender)))
    (asserts! (>= bal amount) (err "Not enough credits"))
    ;; deduct from balance
    (map-set balances {account: tx-sender} {amount: (- bal amount)})
    ;; record retired credits
    (let ((retired-bal (get-retired tx-sender)))
      (map-set retired {account: tx-sender} {amount: (+ retired-bal amount)})
    )
    (ok true)
  )
)
