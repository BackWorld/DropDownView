# DropDownView

A drop down menu view simple and easy to use.

![Demo](http://upload-images.jianshu.io/upload_images/1334681-44f40b86cd24e72d.gif?imageMogr2/auto-orient/strip)

- Platform: iOS8.0+ 
- Language: Swift3.0
- Editor: Xcode8

### How to use it?

```
let items = ["item0", "item1", "item2"]

ActionSheetView.show(items: items, selectedIndex: 0, sourceView: sender){
    [unowned self] (index) in
    print("selected item: \(index)")
}
```
