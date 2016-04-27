#import "Controll.h"
#import "Person.h"
#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    //它是数据库的管理者
    NSManagedObjectContext *_moc;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self CreatUI];
    //配置环境
    [self deploy];
    
    //查询
    NSFetchRequest *request=[NSFetchRequest fetchRequestWithEntityName:@"Person"];
     
    self.array.array=[_moc executeFetchRequest:request error:nil];
    
    
    
    
}
//数组开辟空间
-(NSMutableArray *)array
{
    if (!_array) {
        
        _array=[[NSMutableArray alloc]init];
    }
    return _array;
}
-(void)CreatUI
{
#pragma mark -输入框
    
    NSArray *titleArray=@[@"用户名",@"密码"];
    
    for (int i=0;i<2;i++) {
        
        UITextField *field=[Controll creatTextFiledFrame:CGRectMake(10+i*50,25,40,40) textFieldPlacehoder:titleArray[i]];
        
        field.tag=i+1;
        
        [self.view addSubview:field];
    }
#pragma mark-增,删,改,查,按钮
    
    NSArray *arrays=@[@"增",@"删",@"改",@"查"];
    
    for (int i=0;i<arrays.count; i++) {
        
        UIButton *button=[Controll creatButtonFrame:CGRectMake(110+i*60,25,40,40) buttonTitle:arrays[i] buttonTitleColor:[UIColor redColor]];
        
        [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        
        button.tag=i+3;
        
        [self.view addSubview:button];
    }
#pragma mark -列表视图
    
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0,80,self.view.bounds.size.width,self.view.bounds.size.height-80) style:UITableViewStylePlain];
    
    self.tableView.delegate=self;
    
    self.tableView.dataSource=self;

    [self.view addSubview:self.tableView];
}
//点击事件
-(void)click:(UIButton *)sender
{
    UITextField *name=(UITextField *)[self.view viewWithTag:1];
    
    UITextField *password=(UITextField *)[self.view viewWithTag:2];
    
    
    //增
    if (sender.tag==3) {
        //1:模型名字  2:数据库的管理对象
        Person * mm=[NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:_moc];
        
        mm.name=name.text;
        
        mm.password=password.text;
       //写入数据库要判断一下
        NSError *error=nil;
        
        if ([_moc save:&error]) {
            
            [self.array addObject:mm];
            
            [_tableView reloadData];
        }
     //删
    }else if (sender.tag==4)
    {
        Person *mm=_array[_row];
        //数据库删除数据
        [_moc deleteObject:mm];
        
        NSError *error=nil;
        
        if ([_moc save:&error]) {
          
            [_array removeObjectAtIndex:_row];
            
            [_tableView reloadData];
        }
    //改
    }else if (sender.tag==5)
    {
    
        Person *mm=_array[_row];
        
        mm.name=name.text;
        
        mm.password=password.text;
        
        NSError *error=nil;
        if ([_moc save:&error]) {
            
            [_tableView reloadData];
        }
    //查
    }else
    {
        //查询请求类
        NSFetchRequest *request=[NSFetchRequest fetchRequestWithEntityName:@"Person"];
        //可以设置查询条件(类)
        NSPredicate *perdicate=[NSPredicate predicateWithFormat:@"name like %@",[NSString stringWithFormat:@"*%@*",name.text]];
        // 查询请求设置查询条件
        request.predicate=perdicate;
        
        self.array.array=[_moc executeFetchRequest:request error:nil];
        
        [_tableView reloadData];
    }
}
#pragma mark -收起键盘
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
#pragma mark -列表视图的回调函数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.array.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    Person *person=self.array[indexPath.row];
    
    cell.textLabel.text=person.name;
    cell.detailTextLabel.text=person.password;
    
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITextField *name=(UITextField *)[self.view viewWithTag:1];
    
    UITextField *password=(UITextField *)[self.view viewWithTag:2];
    
    //告诉编译器咱们 删,或者改的是那条数据
     _row=(int)indexPath.row;
    
    //获取到你点击的那个cell
    UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    
    name.text=cell.textLabel.text;
    
    password.text=cell.detailTextLabel.text;
}
#pragma mark - 配置一下CoreData 的环境
-(void)deploy
{
    //1咱们需要取出 Person 的路径:文件的类型(momd);
    NSString *path=[[NSBundle mainBundle]pathForResource:@"Model" ofType:@"momd"];
    
    //2.数据模型类
    NSManagedObjectModel *model=[[NSManagedObjectModel alloc]initWithContentsOfURL:[NSURL fileURLWithPath:path]];
    
    //数据持久化协调器
    NSPersistentStoreCoordinator *coord=[[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:model];
    
    //保存数据到数据库1:数据库的类型 2:其他设置 3:存放数据库的路径  4:设置特定的设置参数  5.错误信息
    
    //存放数据库的路径
    NSString *SQLPath=[NSString stringWithFormat:@"%@/Documents/db",NSHomeDirectory()];
    
    NSError *error=nil;
    
    NSPersistentStore *store=[coord addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:[NSURL fileURLWithPath:SQLPath] options:nil error:&error];
    
    
    if (!store) {
        
        NSLog(@"%@",error.description);
    }
    //管理者
    _moc=[[NSManagedObjectContext alloc]init];
    
    _moc.persistentStoreCoordinator=coord;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
