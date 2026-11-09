# Ariadne Biograph

**Follow the thread from disease to gene to drug.**

Ariadne Biograph is a GraphRAG system over [PrimeKG](https://github.com/mims-harvard/PrimeKG), a biomedical knowledge graph. A biologist can ask questions in plain language and get answers backed by the graph:

- **Explore**: semantic and community-level search over diseases, genes, phenotypes and drugs.
- **Predict**: graph neural networks propose candidate gene–disease associations. Models are pluggable, so you can bring your own.
- **Explain**: every prediction comes with the paths that support it.
- **Repurpose**: from predicted genes to existing drugs that target them, filtered by known contraindications.

> ⚠️ All outputs are research hypotheses, not clinical recommendations.

## Status

🚧 **Phase 0: setup.** The design is in place and nothing runs yet. See the [roadmap](docs/design/DESIGN.md#10-roadmap).

| Phase | Deliverable | Status |
|---|---|---|
| 0 | Repo, tooling, design docs | 🚧 |
| 1 | Core subgraph pipeline, network EDA, disease embeddings | ⏳ |
| 2 | Model contract, baselines, GNN with honest evaluation | ⏳ |
| 3 | GraphRAG agent (local) | ⏳ |
| 4 | Web UI + scale-to-zero AWS deployment | ⏳ |
| 5 | Bring-your-own-model | ⏳ |

## Design

- [`docs/design/DESIGN.md`](docs/design/DESIGN.md): vision, principles, architecture, stack and conventions. This is the source of truth.
- [`docs/design/decisions.md`](docs/design/decisions.md): a short log of key decisions and why they were made.
- [`docs/design/specs/`](docs/design/specs/): per-component specs.

## Development

Requires [uv](https://docs.astral.sh/uv/).

```bash
make install   # create env and install package + dev tools
make check     # lint, format check and tests (same as CI)
```

## Background

This project builds on the author's undergraduate thesis, *Redes neuronales definidas en grafos para la priorización de asociaciones gen-enfermedad* (Universidad de Buenos Aires, 2024), [code](https://github.com/ingridheuer/gcnn_gdas). One of its key findings shapes this project: with uniform negative sampling, a GNN can reach high AUROC just by favoring high-degree nodes. Honest evaluation needs degree-aware negatives.

## Data & attribution

PrimeKG: Chandak, P., Huang, K., & Zitnik, M. (2023). *Building a knowledge graph to enable precision medicine.* Scientific Data, 10, 67. Please refer to PrimeKG and its upstream sources for their respective licenses.

## License

Code: [MIT](LICENSE).
