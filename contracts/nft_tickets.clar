;; title: nft_tickets
;; version: 0.1.0
;; summary: Nft tickets bought with bitcoin
;; description: a clarity smart contract that enables people buy nft on the stacks chain with bitcoin

;; token definitions
(define-non-fungible-token nft_tickets uint)


;; constants
(define-constant contract-owner tx-sender)
(define-constant nft_price u10000000)

;; errors
(define-constant err-owner-only (err u100))
(define-constant err-not-token-owner (err u101))
(define-constant err-incorrect-amount (err u102))
(define-constant err-not-reciepient (err u103))
(define-constant err-out-not-found (err u501))
(define-constant err-in-not-found (err u502))

;; data vars
(define-data-var last-token-id uint u0)
(define-data-var accountant principal contract-owner)

;; public functions
;; (define-public (bitcoin_mint (tx (buff 1024)))
;;     (let 
;;         (
;;         (tx-obj (try! (contract-call? .clarity-bitcoin parse-tx tx)))
;;         (first-output (unwrap! (element-at (get outs tx-obj) u0) err-out-not-found))
;;         (first-input (unwrap! (element-at (get ins tx-obj) u0) err-in-not-found))
;;         (first-output-p2pkh (unwrap-panic (slice? (get scriptPubKey first-output) u3 u23)))
;;         (first-input-p2pkh (unwrap-panic (slice? (get scriptSig first-input) u72 u92)))
;;         )
;;     ;; confirm the caller is the owner
;;     (asserts! (is-eq tx-sender contract-owner) err-owner-only)
;;     ;; confirm the value is the right amount
;;     (asserts! (is-eq (get value first-output) nft_price) err-incorrect-amount)
;;     ;; confirm the funds were sent to the owner
;;     (asserts! (is-eq (principal-of? first-input-p2pkh) contract-owner) err-not-reciepient)
;;     ;; mint the nft to the sender
;;     (nft-mint? nft_tickets u1 (principal-construct? 0x1a first-input-p2pkh))
;;     )
;; )

;; read only functions
(define-read-only (p2pkh-to-principal (scriptSig (buff 256)))
  (let ((pk (unwrap! (as-max-len? (unwrap! (slice? scriptSig (- (len scriptSig) u33) (len scriptSig)) none) u33) none)))
    (some (unwrap! (principal-of? pk) none))))
