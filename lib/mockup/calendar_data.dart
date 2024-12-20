var calendarMockup = [
  {"id": 1, "title": "วันปีใหม่", "start": "2022-01-03", "end": "2022-01-03"},
  {"id": 19, "title": "วันมาฆบูชา", "start": "2022-02-16", "end": "2022-02-16"},
  {
    "id": 3,
    "title": "วันพระบาทสมเด็จพระพุทธยอดฟ้าจุฬาโลกมหาราช และวันที่ระลึกมหาจักรีบรมราชวงศ์",
    "start": "2022-04-06",
    "end": "2022-04-06"
  },
  {"id": 4, "title": "วันสงกรานต์", "start": "2022-04-13", "end": "2022-04-13"},
  {"id": 5, "title": "วันสงกรานต์", "start": "2022-04-14", "end": "2022-04-14"},
  {"id": 6, "title": "วันสงกรานต์", "start": "2022-04-15", "end": "2022-04-15"},
  {"id": 7, "title": "ชดเชย​วันแรงงานแห่งชาติ (วันอาทิตย์ที่ 1 พฤษภาคม 2565)", "start": "2022-05-02", "end": "2022-05-02"},
  {"id": 8, "title": "​วันฉัตรมงคล", "start": "2022-05-04", "end": "2022-05-04"},
  {"id": 9, "title": "​ชดเชยวันวิสาขบูชา (วันอาทิตย์ที่ 15 พฤษภาคม 2565)", "start": "2022-05-16", "end": "2022-05-16"},
  {
    "id": 10,
    "title": "วันเฉลิมพระชนมพรรษาสมเด็จพระนางเจ้าสุทิดา พัชรสุธาพิมลลักษณ พระบรมราชินี",
    "start": "2022-06-03",
    "end": "2022-06-03"
  },
  {"id": 11, "title": "วันอาสาฬหบูชา", "start": "2022-07-13", "end": "2022-07-13"},
  {"id": 12, "title": "วันเฉลิมพระชนมพรรษา พระบาทสมเด็จพระเจ้าอยู่หัว", "start": "2022-07-28", "end": "2022-07-28"},
  {"id": 13, "title": "วันหยุดพิเศษ (เพิ่มเติม)", "start": "2022-07-29", "end": "2022-07-29"},
  {
    "id": 14,
    "title": "วันเฉลิมพระชนมพรรษา สมเด็จพระนางเจ้าสิริกิติ์ พระบรมราชินีนาถ พระบรมราชชนนีพันปีหลวง และวันแม่แห่งชา",
    "start": "2022-08-12",
    "end": "2022-08-12"
  },
  {
    "id": 15,
    "title": "วันคล้ายวันสวรรคต พระบาทสมเด็จพระบรมชนกาธิเบศร มหาภูมิพลอดุลยเดชมหาราช บรมนาถบพิตร",
    "start": "2022-10-13",
    "end": "2022-10-13"
  },
  {"id": 25, "title": "วันหยุดพิเศษ (เพิ่มเติม)", "start": "2022-10-14", "end": "2022-10-14"},
  {"id": 16, "title": "ชดเชยวันปิยมหาราช (วันอาทิตย์ที่ 23 ตุลาคม 2565)", "start": "2022-10-24", "end": "2022-10-24"},
  {
    "id": 17,
    "title": "วันคล้ายวันพระบรมราชสมภพของ พระบาทสมเด็จพระบรมชนกาธิเบศร มหาภูมิพลอดุลยเดชมหาราช บรมนาถบพิตร วันชาติ",
    "start": "2022-12-05",
    "end": "2022-12-05"
  },
  {"id": 18, "title": "​ชดเชยวันรัฐธรรมนูญ (วันเสาร์ที่ 10 ธันวาคม 2565)", "start": "2022-12-12", "end": "2022-12-12"},
  {
    "id": 27,
    "title": "ชดเชยวันสิ้นปีและวันขึ้นปีใหม่ (วันเสาร์ที่ 31 ธันวาคม 2565 และวันอาทิตย์ที่ 1 มกราคม 2566)",
    "start": "2023-01-02",
    "end": "2023-01-02"
  },
  {"id": 28, "title": "​วันมาฆบูชา", "start": "2023-03-06", "end": "2023-03-06"},
  {
    "id": 29,
    "title": "วันพระบาทสมเด็จพระพุทธยอดฟ้าจุฬาโลกมหาราช และวันที่ระลึกมหาจักรีบรมราชวงศ์",
    "start": "2023-04-06",
    "end": "2023-04-06"
  },
  {"id": 30, "title": "​วันสงกรานต์", "start": "2023-04-13", "end": "2023-04-13"},
  {"id": 31, "title": "​วันสงกรานต์", "start": "2023-04-14", "end": "2023-04-14"},
  {"id": 32, "title": "วันแรงงานแห่งชาติ", "start": "2023-05-01", "end": "2023-05-01"},
  {"id": 33, "title": "วันฉัตรมงคล", "start": "2023-05-04", "end": "2023-05-04"},
  {
    "id": 34,
    "title": "ชดเชยวันเฉลิมพระชนมพรรษาสมเด็จพระนางเจ้าสุทิดา พัชรสุธาพิมลลักษณ พระบรมราชินี และวันวิสาขบูชา (วันเส",
    "start": "2023-06-05",
    "end": "2023-06-05"
  },
  {"id": 35, "title": "​วันเฉลิมพระชนมพรรษา พระบาทสมเด็จพระเจ้าอยู่หัว", "start": "2023-07-28", "end": "2023-07-28"},
  {"id": 36, "title": "วันอาสาฬหบูชา", "start": "2023-08-01", "end": "2023-08-01"},
  {
    "id": 37,
    "title": "ชดเชยวันเฉลิมพระชนมพรรษา สมเด็จพระนางเจ้าสิริกิติ์ พระบรมราชินีนาถ พระบรมราชชนนีพันปีหลวง และวันแม่",
    "start": "2023-08-14",
    "end": "2023-08-14"
  },
  {
    "id": 38,
    "title": "วันคล้ายวันสวรรคต พระบาทสมเด็จพระบรมชนกาธิเบศร มหาภูมิพลอดุลยเดชมหาราช บรมนาถบพิตร",
    "start": "2023-10-13",
    "end": "2023-10-13"
  },
  {"id": 39, "title": "​วันปิยมหาราช", "start": "2023-10-23", "end": "2023-10-23"},
  {
    "id": 40,
    "title": "​วันคล้ายวันพระบรมราชสมภพ พระบาทสมเด็จพระบรมชนกาธิเบศร มหาภูมิพลอดุลยเดชมหาราช บรมนาถบพิตร วันชาติ",
    "start": "2023-12-05",
    "end": "2023-12-05"
  },
  {"id": 41, "title": "ชดเชยวันรัฐธรรมนูญ (วันอาทิตย์ที่ 10 ธันวาคม 2566)", "start": "2023-12-11", "end": "2023-12-11"}
];
