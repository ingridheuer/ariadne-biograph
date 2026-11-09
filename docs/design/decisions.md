# Decision log

Short, **append-only** record of decisions that shaped the project.

Rules:
- One entry per decision, a few lines long. The full current picture lives in [`DESIGN.md`](DESIGN.md).
- **Never rewrite an entry.** If a decision changes, add a new one that *supersedes* it, and mark the old one with `Superseded by Dxx`.
- Add an entry only for choices that are hard to reverse or that someone will later ask "why?" about.

---

### D01 · New repository; thesis code is prior work · 2026-11-09
Port the thesis's ideas, not its code. The thesis repo was exploratory, with hardcoded paths and missing pieces. A clean repo reads better from outside and avoids inherited debt.

### D02 · Use PrimeKG as is · 2026-11-09
No custom integration of DisGeNET or other sources. Simple and reproducible.
**Cost:** we accept PrimeKG's grouping of similar diseases, which the thesis deliberately avoided.

### D03 · Text embeddings for disease nodes · 2026-11-09
They replace the thesis's LSA features. One embedding serves as a GNN feature *and* as the index for semantic search.
**Constraint:** the embedding model is pinned and versioned, because changing it invalidates the trained GNN.

### D04 · Degree-aware negative sampling from the start · 2026-11-09
P(v) ∝ deg^0.75. In the thesis, uniform negatives inflated AUROC from 0.70 to 0.91 for the same model by rewarding hub bias.

### D05 · Splits with held-out diseases and stratified reporting · 2026-11-09
Random edge split plus cold-start diseases. Results are reported as known / new / no-information, following the thesis's strata.

### D06 · Few models, bounded evolutionary HPO · 2026-11-09
A reformulation of the thesis's Metropolis–Hastings walks. The search is budget-capped, and a degree baseline is mandatory.

### D07 · Train locally (M4) for development, Colab GPU for full runs · 2026-11-09
The pipeline is an installable package, so it runs the same everywhere. Artifacts are published to versioned storage and kept separate from serving.

### D08 · Common model contract in standard IDs · 2026-11-09
Every predictor (baseline, GNN, external) implements the same interface, keyed by gene, disease and drug IDs, not tensor indices. This enables the multi-model registry.

### D09 · Scale-to-zero AWS with IaC · 2026-11-09
AWS Free account plan, with credits. Idle cost ≈ $0. Everything is created and destroyed by code, and a budget alert is set before the first deploy.

### D10 · Serve the GNN from precomputed embeddings · 2026-11-09
The model is transductive, so node embeddings are computed offline. Inference is a dot product in numpy, which fits in Lambda without PyTorch.

### D11 · Neo4j: Docker locally, Community on EC2 on demand in production · 2026-11-09
The instance starts on the first request (~1–2 min cold start) and a scheduled job stops it when idle. Estimated cost is ~$3–6/month with sporadic use.
- Rejected AuraDB Free: its cap is 50k nodes and 175k relationships.
- Rejected Aura Professional: ≈ $66/month always-on.
- Rejected Neptune: it does not scale to zero.
- Rejected FalkorDB.

Fallback: an embedded Cypher engine in Lambda (LadybugDB), but it is a young fork. All access goes through a `GraphRepository` interface, so the backend can be swapped.

### D12 · Core subgraph of PrimeKG, including drugs · 2026-11-09
Node types: gene/protein, disease, pathway, phenotype and drug. The edge types are listed in `DESIGN.md` §4.
- Excluded anatomy–protein and drug–drug edges, which together are ~70% of PrimeKG.
- Drug–drug interactions are dense and class-annotated, and they would dominate drug message passing.
- Drug–phenotype (side effects) is included because side-effect similarity is a known repurposing signal.

Drugs are included from the start, because adding them later means retraining and reindexing everything.

### D13 · GNN task is GDA; drug repurposing is derived by graph reasoning · 2026-11-09
The repurposing chain is disease → predicted gene → drugs targeting it, minus contraindicated ones. A drug–indication model (TxGNN-style) is optional and late, because its evaluation is harder to do rigorously.

### D14 · Design docs: one living design doc + specs + short decision log · 2026-11-09
Chosen over a full ADR directory, which becomes hard to follow as a project grows. `DESIGN.md` is the single source of truth.
