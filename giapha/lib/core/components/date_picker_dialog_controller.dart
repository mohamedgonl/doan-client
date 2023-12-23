
typedef ScrollToNewDate = void Function(DateTime date);



class DatePickerDialogController{

  DatePickerDialogController();

  ScrollToNewDate? _scrollToNewDate;

  set jumpToTopCallBack(ScrollToNewDate? scrollToNewDate){
    _scrollToNewDate = scrollToNewDate;
  }

  void scrollToNewDate(DateTime dateTime,){
    _scrollToNewDate?.call(dateTime);
  }
}