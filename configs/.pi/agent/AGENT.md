## 代码分析约束

分析代码仓库前，先调用 codegraph MCP 工具。若返回"当前仓库未索引"，则先执行 `codegraph init -i` 索引，再调用 codegraph MCP。非代码仓库可忽略此约束。