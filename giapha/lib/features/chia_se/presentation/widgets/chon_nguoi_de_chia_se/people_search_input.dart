import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:giapha/core/constants/icon_constrants.dart';
import 'package:giapha/core/constants/package_name.dart';
import 'package:giapha/features/chia_se/domain/entities/Person.dart';
import 'package:giapha/features/chia_se/presentation/bloc/chia_se_bloc.dart';
import 'package:giapha/features/chia_se/presentation/bloc/choosed_bloc/choosed_bloc.dart';
import 'package:giapha/features/chia_se/presentation/bloc/choosed_bloc/choosed_event.dart';
import 'package:giapha/features/chia_se/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:giapha/features/chia_se/presentation/bloc/search_bloc/search_event.dart';
import 'package:giapha/features/chia_se/presentation/bloc/search_bloc/search_state.dart';
import 'package:giapha/shared/widget/image.dart';
import 'package:searchfield/searchfield.dart';

class PeopleSearchInput extends StatefulWidget {
  final ChoosedBloc choosedBloc;
  final String idGiaPha;
  const PeopleSearchInput(
      {super.key, required this.choosedBloc, required this.idGiaPha});

  @override
  State<PeopleSearchInput> createState() => _PeopleSearchInputState();
}

class _PeopleSearchInputState extends State<PeopleSearchInput> {
  late List<Person> peopleShared;
  late SearchBloc searchBloc;
  late ChoosedBloc choosedBloc;

  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchBloc = BlocProvider.of<SearchBloc>(context);
    choosedBloc = BlocProvider.of<ChoosedBloc>(context);
    searchController.addListener(() {
      searchBloc.add(OnSearchEvent(searchController.text, widget.idGiaPha));
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    choosedBloc.close();
    searchBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Person> searchResults = [];
    return BlocBuilder<SearchBloc, SearchState>(builder: (context, state) {
      if (state is OnSearchState) {
        searchResults = state.people;
      }
      return Row(children: [
        Expanded(
          child: SearchField(
            controller: searchController,
            suggestionAction: SuggestionAction.unfocus,
            suggestions: searchResults
                .map((e) => SearchFieldListItem(e.name,
                    item: e.maLichViet,
                    child: PersonSearched(personSearched: e)))
                .toList(),
            hint: 'Nhập mã chia sẻ',
            onSuggestionTap: (selected) {
              widget.choosedBloc.add(AddPeopleToPickedListEvent(
                  searchResults.firstWhere(
                      (element) => element.maLichViet == selected.item)));
            },
            autoCorrect: false,
            textInputAction: TextInputAction.search,
            searchInputDecoration: InputDecoration(
              filled: true,
              floatingLabelBehavior: FloatingLabelBehavior.never,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            // hasOverlay: true,
            emptyWidget: Container(
              decoration: BoxDecoration(
                  border:
                      Border.all(color: Color.fromARGB(255, 211, 211, 211))),
              child: ListTile(
                contentPadding: EdgeInsets.only(left: 10.w),
                title: const Text('Không có dữ liệu'),
              ),
            ),
            itemHeight: 60.h,
            maxSuggestionsInViewPort: 4,
          ),
        ),
        SizedBox(width: 20.w),
        IconButton(
          padding: EdgeInsets.zero,
          onPressed: () {},
          constraints: BoxConstraints(
            minHeight: 28.h,
            minWidth: 22.75.w,
          ),
          icon: SvgPicture.asset(
            IconConstants.icDanhBa,
            height: 28.h,
            width: 22.75.w,
            fit: BoxFit.cover,
            package: PackageName.namePackageAddImage
          ),
        ),
        SizedBox(width: 2.25.w),
      ]);
    });
  }
}

class PersonSearched extends StatelessWidget {
  const PersonSearched({super.key, required this.personSearched});
  final Person personSearched;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListTile(
        minLeadingWidth: 0,
        isThreeLine: true,
        contentPadding: EdgeInsets.only(left: 10.w),
        leading: SizedBox(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(18.r),
            child: personSearched.avatar.isEmpty
                ? imageFromLocale(url: IconConstants.icDefaultAvatar)
                : imageFromNetWork(
                    url: personSearched.avatar, width: 36.w, height: 36.h),
          ),
        ),
        title: Text(personSearched.name),
        subtitle: Padding(
          padding: EdgeInsets.only(top: 4.h),
          child: Text(personSearched.phone),
        ),
        // minVerticalPadding: 12.5.h,
      ),
    );
  }
}
