//
//  auth-enum.dart
//  JazzB
//
//  Created by Alireza Khakpour on 7/8/19.
//  Copyright © 2019 JazzB. All rights reserved.
//
enum AuthMode { Signup, Login }

class ImageMode {
  static const logo = 'logo';
  static const banner = 'banner';
  static const img1 = 'img1';
  static const img2 = 'img2';
}

enum LocationMode { Current, Selected, NotUser, Default }

enum CompanyStatusType { All, Marketing, Activity }

enum UiType { Card, Logo, Promo, CircleChip, ShapOnBranch, DistShapOnBranch, RateShapOnBranch, StarShapOnBranch, NameShapOnBranch}

class ActionUIMode {
  static const alert = 'ActionAlert';
  static const report = 'ActionReport';
  static const detailList = 'DetailTableView';
  static const edit = 'EditView';
  static const singleEdit = 'VarEditView';
  static const sheet = 'ActionSheet';
  static const collection = 'CollectionView';
  static const web = 'WebView';
}

class ListConstant {
  static const  List<String> imageSource = ['Camera', 'Gallery', 'Unsplash', 'Instagram'];
}


