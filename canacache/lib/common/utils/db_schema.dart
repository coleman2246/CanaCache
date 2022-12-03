enum LocalDBTables { steps }

Map<LocalDBTables, DBTable> dbTables = {
  LocalDBTables.steps: const DBTable(
    tableTitle: "steps",
    columnTypeMap: {"timeSlice": "TEXT UNIQUE", "steps": "INT"},
  ),
};

class DBTable {
  final String tableTitle;

  /// <column name, type>
  final Map<String, String> columnTypeMap;

  const DBTable({required this.tableTitle, required this.columnTypeMap});

  String createTableString() {
    String schema =
        columnTypeMap.entries.map((e) => "${e.key} ${e.value}").join(", ");

    return "$tableTitle($schema)";
  }

  // makes sure that a map contains all the columns
  bool verifyMapRow(Map<String, dynamic> map) {
    for (String colName in columnTypeMap.keys) {
      if (!map.containsKey(colName)) {
        return false;
      }
    }

    return true;
  }
}
