import 'package:giapha/features/cay_gia_pha/datasource/data/member_model.dart';

class TreeUtils {
  static List<List<Member>> merge2Tree(
      List<List<Member>> srcTree, List<List<Member>> desTree, String mergeId) {
    List<List<Member>> result =
        desTree.map((list) => List<Member>.from(list)).toList();
    int desTreeLength = desTree.length;
    int srcTreeLength = srcTree.length;
    for (List<Member> generation in desTree) {
      for (Member member in generation) {
        // first, find the start id for merging
        if (member.info?.memberId == mergeId) {
          // set fid of root of source tree = leaf id of  des tree
          // member.cInfo.add(value)
          srcTree[0][0].info?.fid = mergeId;

          int startIndex = member.info?.depth ?? 1;
          int leftGen = desTreeLength - startIndex;
          if (leftGen < srcTreeLength) {
            int remainGen = srcTreeLength - leftGen;
            for (int i = 0; i < remainGen; i++) {
              result.add([]);
            }
          }

          // add src  tree to des tree
          for (var i = 0; i < srcTree.length; i++) {
            result[startIndex].addAll(srcTree[i]);
            startIndex++;
          }
        }
      }
    }

    return result;
  }
}

void main(List<String> args) {


}
