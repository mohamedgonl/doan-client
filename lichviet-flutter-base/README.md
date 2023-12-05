Sử dụng dùng chung cho các module lịch việt:
struct:
- core
- cubit
- data
- di
- theme

Cài đặt:  
in_app_purchase:  
 git:  
  url: https://github.com/Lich-Viet/lichviet-flutter-base.git  
  ref: main  

Base url mặc định: https://api.lichviet.org  

Chạy function setup trước khi sử dụng:  
      await  LichVietFlutterBase.getInstance().setUpBase();  
      
example:  
Sử dụng call api :  

-Không lưu cache:  
 LichVietFlutterBase.getInstance()  
 .apiHandle  
 .post('/api/login', parser: (data){});  
-Lưu cache:  
 LichVietFlutterBase.getInstance().apiHandle.post('/api/login',  
 options: buildCacheOptions(Duration(hours: IntConstanst.timeCache),  
 maxStale: Duration(days: IntConstanst.maxAge),  
 forceRefresh: false,  
 subKey: 'k=$param'),  
 parser: (data) {});  

Sử dụng theme:  
- ThemeColor:   
    LichVietFlutterBase.getInstance().themeColor;  
- ThemeStyle:  
    LichVietFlutterBase.getInstance().themeStyle;  
- ThemeLayouts:  
    LichVietFlutterBase.getInstance().themeLayOuts;  


