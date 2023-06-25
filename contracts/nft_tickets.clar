;; title: nft_tickets
;; version: 0.1.0
;; summary: Nft tickets bought with bitcoin
;; description: a clarity smart contract that enables people buy nft on the stacks chain with bitcoin

;; traits
(impl-trait .tickets.tickets_trait)

;; token definitions
(define-non-fungible-token nft_tickets uint)


;; constants
(define-constant contract-owner tx-sender)
(define-constant err-owner-only (err u100))
(define-constant err-not-token-owner (err u101))

;; data vars

(define-data-var last-token-id uint u0)
(define-data-var accountant principal contract-owner)

;; maps
;; 

;; public functions
;;

;; read only functions
;;

;; private functions
;;

