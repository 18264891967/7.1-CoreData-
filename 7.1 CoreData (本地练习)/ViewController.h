/*创建实体(数据模型):1.你改名字的时候,一定要记住,首个单词要大写
 面板上面:(1):它是给数据模型添加属性 (2):建立模型间的关系的  (3)查询:(用代码可以搞定)
 */
#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSMutableArray *array;


@property(nonatomic,assign)int row;

@end

