

String joinSingleQuoted(Iterable<String> strings) {
  return strings.map((s)=>"'$s'").join(",");
}