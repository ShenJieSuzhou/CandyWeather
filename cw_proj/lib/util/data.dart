import 'dart:math';
Random random = Random();

List jiTangData = [
  {"白鹤林《孤独》":"从童年起，我便独自一人,照顾着,历代的星辰。"},
  {"安德鲁•怀斯《远方》":"于是整整一个雨季，我守着阳光，守着越冬的麦田，将那段闪亮的日子，轻轻弹唱。"},
  {"安德鲁•怀斯《远方》":"你在风口遥望彼岸的紫丁香，你在田野捡拾古老的忧伤，我知道那是你心的方向。"},
  {"顾城《门前》":"草在结它的种子，风在摇它的叶子。我们站着，不说话，就十分美好。"},
  {"顾城《远和近》":"你，一会看我，一会看云。我觉得，你看我时很远，你看云时很近。"},
  {"余秀华《雪》":"雪下不下来都阻挡不了我的白，我白不白都掩饰不了一生的荒唐。"},
  {"北岛":"这不是告别，因为我们并没有相见，尽管影子和影子，曾在路上叠在一起。"},
  {"北岛":"我们却按成年人的规则，继续着孩子的游戏"},
  {"北岛":"当月光层层涌入港口，这夜色仿佛透明，一级级磨损的石阶，通向天空，通向我的梦境。"},
  {"泰戈尔":"我的心是旷野的鸟，在你的眼睛里找到了它的天空。"},
  {"泰戈尔":"路边的紫罗兰吸引不了那粗心的目光，它的声音却能在这零星的诗句里呢喃。"},
  {"拜伦":"若我会见到你，事隔经年。我该如何向你致意，以眼泪，以沉默。"},
  {"阿多尼斯":"世界让我遍体鳞伤，但伤口长出的却是翅膀，夜晚在我的枕头上沉睡，我却独自无眠。"},
  {"泰戈尔":"纵然伤心，也不要愁眉不展，因为你不知是谁会爱上你的笑容。"},
  {"泰戈尔":"世界上最遥远的距离，不是生与死，而是我就站在你面前，你却不知道我爱你。"},
  {"泰戈尔":"寂静在喧嚣里低头不语，沉默在黑夜里与目光结交，于是，我们看错了世界，却说世界欺骗了我们。"},
  {"泰戈尔":"你微微地笑着，不同我说什么话。而我觉得，为了这个，我已等待得很久了。"},
  {"泰戈尔":"生命的意义不在于留下什么，只要你经历过，就是最大的美好，这不是无能，而是一种超然。"},
  {"泰戈尔":"有一次，我们梦见彼此竟是陌生人；醒来后，才发现我们原是相亲相爱的。"},
  {"泰戈尔":"只管走下去，不必逗留着，去采花朵来保存，因为这一路上，花朵还会继续绽放。"},
  {"泰戈尔":"如果错过了太阳时你流了泪，那么你也要错过群星了。"},
  {"北岛":"我拿本书，在长椅上晒太阳，心变得软软的，容易流泪，像个多愁善感的老头。"},
  {"北岛":"如今我们深夜饮酒，杯子碰到一起，都是梦破碎的声音。"},
  {"北岛":"有人像家雀儿，不愿意挪窝。有人像候鸟，永远在路上。"},
  {"北岛":"生活是一次机会，仅仅一次，谁校对时间，谁就会突然老去。"}
];
// Map jiTangData = {
//   "白鹤林《孤独》":"从童年起，我便独自一人,照顾着,历代的星辰。",
//   "安德鲁•怀斯《远方》":"于是整整一个雨季，我守着阳光，守着越冬的麦田，将那段闪亮的日子，轻轻弹唱。",
//   "安德鲁•怀斯《远方》":"你在风口遥望彼岸的紫丁香，你在田野捡拾古老的忧伤，我知道那是你心的方向。",
//   "顾城《门前》":"草在结它的种子，风在摇它的叶子。我们站着，不说话，就十分美好。",
//   "顾城《远和近》":"你，一会看我，一会看云。我觉得，你看我时很远，你看云时很近。",
//   "余秀华《雪》":"雪下不下来都阻挡不了我的白，我白不白都掩饰不了一生的荒唐。",
//   "北岛":"这不是告别，因为我们并没有相见，尽管影子和影子，曾在路上叠在一起。",
//   "北岛":"我们却按成年人的规则，继续着孩子的游戏",
//   "北岛":"当月光层层涌入港口，这夜色仿佛透明，一级级磨损的石阶，通向天空，通向我的梦境。",
//   "泰戈尔":"我的心是旷野的鸟，在你的眼睛里找到了它的天空。",
//   "泰戈尔":"路边的紫罗兰吸引不了那粗心的目光，它的声音却能在这零星的诗句里呢喃。",
//   "拜伦":"若我会见到你，事隔经年。我该如何向你致意，以眼泪，以沉默。",
//   "阿多尼斯":"世界让我遍体鳞伤，但伤口长出的却是翅膀，夜晚在我的枕头上沉睡，我却独自无眠。",
//   "泰戈尔":"纵然伤心，也不要愁眉不展，因为你不知是谁会爱上你的笑容。",
//   "泰戈尔":"世界上最遥远的距离，不是生与死，而是我就站在你面前，你却不知道我爱你。",
//   "泰戈尔":"寂静在喧嚣里低头不语，沉默在黑夜里与目光结交，于是，我们看错了世界，却说世界欺骗了我们。",
//   "泰戈尔":"你微微地笑着，不同我说什么话。而我觉得，为了这个，我已等待得很久了。",
//   "泰戈尔":"生命的意义不在于留下什么，只要你经历过，就是最大的美好，这不是无能，而是一种超然。",
//   "泰戈尔":"有一次，我们梦见彼此竟是陌生人；醒来后，才发现我们原是相亲相爱的。",
//   "泰戈尔":"只管走下去，不必逗留着，去采花朵来保存，因为这一路上，花朵还会继续绽放。",
//   "泰戈尔":"如果错过了太阳时你流了泪，那么你也要错过群星了。",
//   "北岛":"我拿本书，在长椅上晒太阳，心变得软软的，容易流泪，像个多愁善感的老头。",
//   "北岛":"如今我们深夜饮酒，杯子碰到一起，都是梦破碎的声音。",
//   "北岛":"有人像家雀儿，不愿意挪窝。有人像候鸟，永远在路上。",
//   "北岛":"生活是一次机会，仅仅一次，谁校对时间，谁就会突然老去。",
//   "Chuck Palahniuk":"We all die. The goal isn't to live forever, the goal is to create something that will。",
//   "Ernest Hemingway":"Never think that war, no matter how necessary nor how justified is not a crime。"
// };

List names = [
  "Ling Waldner",
  "Gricelda Barrera",
  "Lenard Milton",
  "Bryant Marley",
  "Rosalva Sadberry",
  "Guadalupe Ratledge",
  "Brandy Gazda",
  "Kurt Toms",
  "Rosario Gathright",
  "Kim Delph",
  "Stacy Christensen",
];

List messages = [
  "Hey, how are you doing?",
  "Are you available tomorrow?",
  "It's late. Go to bed!",
  "This cracked me up 😂😂",
  "Flutter Rocks!!!",
  "The last rocket🚀",
  "Griezmann signed for Barca❤️❤️",
  "Will you be attending the meetup tomorrow?",
  "Are you angry at something?",
  "Let's make a UI serie.",
  "Can i hear your voice?",
];

List notifs = [
  "${names[random.nextInt(10)]} and ${random.nextInt(100)} others liked liked your post",
  "${names[random.nextInt(10)]} mentioned you in a comment",
  "${names[random.nextInt(10)]} shared your post",
  "${names[random.nextInt(10)]} commented on your post",
  "${names[random.nextInt(10)]} replied to your comment",
  "${names[random.nextInt(10)]} reacted to your comment",
  "${names[random.nextInt(10)]} asked you to join a Group️",
  "${names[random.nextInt(10)]} asked you to like a page",
  "You have memories with ${names[random.nextInt(10)]}",
  "${names[random.nextInt(10)]} Tagged you and ${random.nextInt(100)} others in a post",
  "${names[random.nextInt(10)]} Sent you a friend request",
];

List notifications = List.generate(13, (index)=>{
  "name": names[random.nextInt(10)],
  "dp": "assets/cm${random.nextInt(10)}.jpeg",
  "time": "${random.nextInt(50)} min ago",
  "notif": notifs[random.nextInt(10)]
});

List posts = List.generate(13, (index)=>{
    "name": names[random.nextInt(10)],
    "dp": "assets/cm${random.nextInt(10)}.jpeg",
    "time": "${random.nextInt(50)} min ago",
    "img": "assets/cm${random.nextInt(10)}.jpeg"
});

List chats = List.generate(13, (index)=>{
  "name": names[random.nextInt(10)],
  "dp": "assets/cm${random.nextInt(10)}.jpeg",
  "msg": messages[random.nextInt(10)],
  "counter": random.nextInt(20),
  "time": "${random.nextInt(50)} min ago",
  "isOnline": random.nextBool(),
});

List groups = List.generate(13, (index)=>{
  "name": "Group ${random.nextInt(20)}",
  "dp": "assets/cm${random.nextInt(10)}.jpeg",
  "msg": messages[random.nextInt(10)],
  "counter": random.nextInt(20),
  "time": "${random.nextInt(50)} min ago",
  "isOnline": random.nextBool(),
});

List types = ["text", "image"];
List conversation = List.generate(10, (index)=>{
  "username": "Group ${random.nextInt(20)}",
  "time": "${random.nextInt(50)} min ago",
  "type": types[random.nextInt(2)],
  "replyText": messages[random.nextInt(10)],
  "isMe": random.nextBool(),
  "isGroup": false,
  "isReply": random.nextBool(),
});

List friends = List.generate(13, (index)=>{
  "name": names[random.nextInt(10)],
  "dp": "assets/cm${random.nextInt(10)}.jpeg",
  "status": "Anything could be here",
  "isAccept": random.nextBool(),
});