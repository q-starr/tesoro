# Tesoro

Simulated, client-side demo of an AI spend-management ("treasury") business for regulated LatAm — the CFO door to the [Torre](https://torre.q-starr.app) engine.

- **Live:** https://tesoro.q-starr.app
- **Ship:** everything is a single root-level `index.html` — no build step, no dependencies, zero network requests after load.
- **Deploy:** `./deploy.sh` (git + GitHub + Vercel; mirrors the Torre flow).

All companies, bills, rates, savings and revenue are simulated client-side for illustration. Every numeric constant lives in the `CONFIG` object at the top of the inline script.

A Q Starr LLC concept demo.
