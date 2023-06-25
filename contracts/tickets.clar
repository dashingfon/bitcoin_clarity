(define-trait tickets_trait
    (
        ;; Last token ID, limited to uint range
        (get-last-token-id () (response uint uint))

        ;; URI for metadata associated with the token 
        (get-token-uri (uint) (response (optional (string-ascii 256)) uint))

        ;; Owner of a given token identifier
        (get-owner (uint) (response (optional principal) uint))

        ;; Transfer from the sender to a new principal
        (transfer (uint principal principal) (response bool uint))

        ;; buy a ticket token based on a Bitcoin transaction
        (buy (height uint) (tx (buff 1024))
                        (header { version: (buff 4), parent: (buff 32), merkle-root: (buff 32), timestamp: (buff 4), nbits: (buff 4), nonce: (buff 4) })
                        (proof { tx-index: uint, hashes: (list 14 (buff 32)), tree-depth: uint}))
    )
)