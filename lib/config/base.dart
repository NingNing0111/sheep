class BaseConfig {
  static const APPLICATION_NAME = "Sheep";
  static const APPLICATION_TITLE = "Sheep";
  static const BASE_INIT_ROUTER = "/";
  static const DATABASE_NAME = "sheep";

  // 语音角色
  // static const BASE_VCN = ["xiaoyan","aisjiuxu","aisxping","aisjinger","aisbabyxu"];
  static const BASE_VCN = [
    {
      "value": "xiaoyan",
      "name": "小燕",
    },
    {
      "value": "aisjiuxu",
      "name": "许久",
    },
    {
      "value": "aisxping",
      "name": "小萍",
    },
    {
      "value": "aisjinger",
      "name": "小婧",
    },
    {
      "value": "aisbabyxu",
      "name": "许小宝",
    },
    {
      "value": "x4_lingxiaolu_en",
      "name": "聆小璐"
    },
    {
      "value": "x4_lingfeizhe_zl",
      "name": "聆飞哲"
    },
    {
      "value": "x4_lingxiaoxuan_en",
      "name": "聆小璇-温柔"
    },
    {
      "value": "x4_lingfeichen_assist",
      "name": "聆飞晨-助理"
    },
  ];
}
