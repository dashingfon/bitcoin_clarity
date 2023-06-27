;; title: nft_tickets
;; version: 0.1.0
;; summary: Nft tickets bought with bitcoin
;; description: a clarity smart contract that enables people buy nft on the stacks chain with bitcoin

;; token definitions
(define-non-fungible-token nft_tickets uint)

;; constants
(define-constant contract-owner tx-sender)
(define-constant nft_price_satoshi u10000000)

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

;; read only functions
(define-read-only (p2pkh-to-principal-in (scriptSig (buff 256)))
  (let ((pk (unwrap! (as-max-len? (unwrap! (slice? scriptSig (- (len scriptSig) u33) (len scriptSig)) none) u33) none)))
    (some (unwrap! (principal-of? pk) none))))

(define-read-only (p2pkh-to-principal-out (scriptPubKey (buff 256)))
  (let ((pk (unwrap! (as-max-len? (unwrap! (slice? scriptPubKey u3 u23) none) u20) none)))
    (some (unwrap! (principal-of? pk) none))))

(define-read-only (get-token-uri (token-id uint))
    (ok "")
)

;; public functions
(define-public (bitcoin_mint (tx (buff 1024)))
    (let 
        (
        (tx-obj (try! (contract-call? .clarity-bitcoin parse-tx tx)))
        (first-output (unwrap! (element-at (get outs tx-obj) u0) err-out-not-found))
        (first-input (unwrap! (element-at (get ins tx-obj) u0) err-in-not-found))
        (first-output-principal (unwrap-panic (p2pkh-to-principal-out (get scriptPubKey first-output))))
        (first-input-principal (unwrap-panic (p2pkh-to-principal-in (get scriptSig first-input))))
        )
    ;; confirm the caller is the owner
    (asserts! (is-eq tx-sender contract-owner) err-owner-only)
    ;; confirm the value is the right amount
    (asserts! (is-eq (get value first-output) nft_price_satoshi) err-incorrect-amount)
    ;; confirm the funds were sent to the owner
    (asserts! (is-eq first-output-principal contract-owner) err-not-reciepient)
    ;; mint the nft to the sender
    (nft-mint? nft_tickets u1 first-input-principal)
    )
)

(define-public (transfer (token-id uint) (sender principal) (recipient principal))
    (begin
        (asserts! (is-eq tx-sender sender) err-not-token-owner)
        (nft-transfer? nft_tickets token-id sender recipient)
    )
)
