The supplementary material for OOPSLA2020 submission "Naturalness-Guided Dynamic Programming for Accelerating Programming by Example"

The files in this project are organized in the following way:

```
├── src                                   // Our implementation of MaxFlash
├── benchmark                             // Benchmarks used in our evaluation
│   ├── atlas                             // String benchmarks used to compare with Atlas
│   │   ├── atlas_style                   // Benchmarks in the format required by Atlas
│   │   ├── sygus_style                   // Benchmarks in the SyGuS format
│   │   ├── sygus_with_program            // Benchmarks with new oracle programs
│   ├── main                              // The main dataset, in SyGuS format
│   ├── matrix                            // The matrix dataset
│   ├── euphony                           // Benchmarks used to compare with euphony
│   │   ├── test                          // Testing set
│   │   ├── train                         // Training set
├── run                                   // Evaluation results and scripts
│   ├── artifact                          // ./artifact could draw figures from results
│   ├── result_cache                      // Results stored in pickle files
│   ├── euphony_result                    // Results of Eusolver and Euphony on string
│   ├── flashfill_result                  // Results of FlashFill on string
│   ├── atlas_string.csv                  // Results of Atlas on string
│   ├── atlas_matrix.csv                  // Results of Atlas on matrix
│   ├── flashmeta_matrix.csv              // Results of FlshMeta on matrix
│   ├── result_fig                        // Figrues used in our paper
```

