Current output:
```bash
~/src/ghc-9122-aarch64-bug [1] $ ghc -fprefer-byte-code -O2 -threaded --make -ddump-splices A.hs
[3 of 4] Compiling G                ( G.hs, G.o, interpreted )
[4 of 4] Compiling A                ( A.hs, A.o )
A.hs:9:1-16: Splicing declarations
    useLeader bounds ======> data IntEnum = I1274R | I1294R
~/src/ghc-9122-aarch64-bug $ 
```
Expected output:
```bash
~/src/ghc-9122-aarch64-bug $ ghc -O2 -threaded --make -ddump-splices A.hs
[1 of 2] Compiling G                ( G.hs, G.o, G.dyn_o )
[2 of 2] Compiling A                ( A.hs, A.o )
A.hs:7:1-16: Splicing declarations
    useLeader bounds ======> data IntEnum = I1271R | I1294R
```
