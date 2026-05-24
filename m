Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020104.outbound.protection.outlook.com [52.101.69.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EA4175A64;
	Sun, 24 May 2026 15:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779637408; cv=fail; b=KgwmOnWJgJKSJD1/2MQisoq2swqljtx8v8urnXUgzOe+bASq6i/NMTq9vnlglfEGq8D4nv0jNlwsBDXHKAXyaxas8P91lXNOIbV4l811Gp1I3H036J0ZNRTVxKHPJ2aAyUowJpoxKtyZZIfjO4IOPJrvmVetXjzuuC1cPSMpSG0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779637408; c=relaxed/simple;
	bh=TTGtX7lCyg4gZvO2eaprH6cBjogDhX32C9cW4JjnDtI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=fxTjQf8H2Hjgw6+/GT26N6GC1yLT4kK5xTN4rvZbF7UsLgSsRiR3m1b57ObbwSZ5WeOCdDt5l6PCjvXUwNmYpWaYAaUnGgj6bIN+y7r54h5YlYwgV+O2vpMGqYrKuopY1/ryclzOoGWUma9xUjCxX3TD/YtK7LayjLvqp25/xwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=orf36C5O; arc=fail smtp.client-ip=52.101.69.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="orf36C5O"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NPkVrbY6Vh9mVLAS+vcIWuiKOM82tbuiulWOLBrr9Nn0kWgIuxgpljnri1F34umtc9Go4laABGUFgT5PBqlR7U7q8eOkYp3f23N1iJezXdgY/B2oiXDK5GmZFaL3CzDJRVQy5r/+SOdEf+ySSY+xAT1HT3md1Yg3feTjWJ4vCsoARC/xfqn3s3wS/DDFdS/OOjEvIhiPlPyBEyuV6pDRa/K2tZoGQV8iAix3LkuHeF0dXgTS0d9UKe2zKmvFYaiAJt/crv8ro6JeuhgDhujwNTCKC8ijCM0z0OsoSrG7DB/ojw9acXVDpwQTEPEHuG5dlO/ZwcuRFNpv1R3fvujNUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=puETqXHWQQcgOkGdcG4DafB3RW+r/EQ85eX9Dh7elVY=;
 b=PATIUWhZWPO7omGLlRZwBehkF1nbxs84KCUzo44AqrKvTXpVcK+crmYY0UsXmEHJnznP5LmGG4T318KaMyWAT51tIZvVDeaZP2PJHmxSTUqSHmvuevX5nhlIkUNDc0IkJq4nrjxNoHw7HyyJL4YYI9u0vm/70XB3rvYj9CKYe1zUTVEkXRgBuf7sHxHhsB57OvzUKusq//ziTmhX5bJZlxbVfGieUdMs41C2Pqy87UkCV6nhbWe1XoDc+uFYyccnNZdDQJOWafe4XbbbYrzoQMun8+1SRN4x9lrS5jMhVPV+qHocRwPGayjxmb58ZiAogX7jiQyeE6/mHRa0rr0BKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=puETqXHWQQcgOkGdcG4DafB3RW+r/EQ85eX9Dh7elVY=;
 b=orf36C5Oe/d4UUFosqgHZyJOmjMIJjLAA1/PyH+ZMbEyDTK/ah7FdVgUL3pNlrs464QxuQkP/4rep3eQj3wCfdb4tgf39FnRVK/hzn7BWchYw3INAhC35+OuUMx2lVQE1k5Wmp7EC90Kux/HMufrmuZLchGMY3ElkLA4yHLaIiJawQWzIspntKrzdvqOcta0nU1+1r/fEjeGz4Gt+Mfa1TNFH2DibsedocvndvJV7+xOWQd8Gqr5Ep8pc0cNc1/1TvrtGxXOZQs9CIbBkpqa8xwXiNTi/5fJTeeIphJ3Awxu7KG7SLwsQkcocgpEn1S+3We7ekhklcePD/bn9oGcsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AS4PR08MB7555.eurprd08.prod.outlook.com (2603:10a6:20b:4fd::12)
 by AS2PR08MB8745.eurprd08.prod.outlook.com (2603:10a6:20b:55d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Sun, 24 May
 2026 15:43:23 +0000
Received: from AS4PR08MB7555.eurprd08.prod.outlook.com
 ([fe80::7d00:380e:b72:55e6]) by AS4PR08MB7555.eurprd08.prod.outlook.com
 ([fe80::7d00:380e:b72:55e6%4]) with mapi id 15.21.0048.016; Sun, 24 May 2026
 15:43:21 +0000
From: Eva Kurchatova <eva.kurchatova@virtuozzo.com>
To: mhiramat@kernel.org,
	rostedt@goodmis.org
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com,
	peterz@infradead.org,
	jpoimboe@kernel.org,
	samitolvanen@google.com,
	eva.kurchatova@virtuozzo.com
Subject: [PATCH] tracing: fix CFI violation in probestub helper
Date: Sun, 24 May 2026 18:43:01 +0300
Message-ID: <20260524154301.21119-1-eva.kurchatova@virtuozzo.com>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: WA2P291CA0024.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::15) To AS4PR08MB7555.eurprd08.prod.outlook.com
 (2603:10a6:20b:4fd::12)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR08MB7555:EE_|AS2PR08MB8745:EE_
X-MS-Office365-Filtering-Correlation-Id: a8ae0cf8-c1fe-403a-1639-08deb9ab2ed3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	3PbOwxtcUa/b8Jl24pCKcMZjx/Ty1KyilIjKmE6sTqLXG89hAX3m/OID7KR+qjKaoTv1w3Y/KuSB9xbf1VnwCOgEh39BklAwefCL6ex9F3aJKW0pfDBRNARSylzmK9bLC4EkfX0RcX3qep35R11JgJCYMma/gNu8LwESWPdcEbiMkCRf2Cx8IZQvHgL5coDd1RgX0eQvV6//GsyZLnBfB8bMUZpltZudOQdp9Dvc1nzpNREf4JsrOmwnW0mtDGvV1GdaWW6+3AoU56TICdX2/r8BBeAB+NvRAN5ohwoW4cLNbg9Ln963UU8EF3BGhVnhj+dLFRCyHzOQ+Oa0P5PF5ZK+GlQTwomm/tloRMoEHVICKyJs3bEPabjhoxRZiEKp1LC5vcWPec7c+9VegYfG4zSXdN84ERDTLNObgbIPEWOF4yVMOXKfJ7HDt/hWqoAMy18ytOlZ0ua6mnrYD23+o/D8GqB+Om+n0EUOMScbG9tT5/O48YAdNh2ILyGt546yrsan7g4JTOdwJUWOiyJSH0l4mQtl+tK3v6ItwPg3VFaXItB2hHWiM33sNjV//jvzxLZEmhiGN0YlN3+kcRrowmmB5b8bnX5y7ZGvMlFa4ISZPHuaHV4w3wrZyEKNz5/a70p1a+d3NKRMFndzzTyDZe1tiNwRh1Hf/4zWhsrIDzYq0EBIakWdLwtuE0zY2CQD
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR08MB7555.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xScgq165MLVnoWToJyivAcBtrSHpDn9inDkUJ0wOGZgktjDjHedS1DxQqDhV?=
 =?us-ascii?Q?yyAMX/4mzg/Y4s2KuQKPg8gBSxY8B9/QjFlCByXxMsDtwc37yon9OK7A7icJ?=
 =?us-ascii?Q?d52gILf9G2Ms/TFYMvMQuvcyOA7RLpARgHagN//FjVId6ingzuCEC8AtMQCm?=
 =?us-ascii?Q?oxymrlgLVVwAE0ow6+s9KmO32Pg0iLnEWo9kmUgH12wQAqz2VodR3EW7Rx8y?=
 =?us-ascii?Q?JJdPWq7dAseQzXsguo2puA4hDp49Hd1ychJJ4cPF0HvDPXDWhtehwpXLgjXh?=
 =?us-ascii?Q?MQ8aV52lY9q+5T/v9FStwaE7luTgY0UM8HQ5eOtelesQWe3Zy1PJI0+dHiUG?=
 =?us-ascii?Q?IcvxV5aPaPJxlg7nZx4a+y0uzzgFkJJYo+A6bNkJmHogolO6a89j5oCmSbOR?=
 =?us-ascii?Q?w6WFAuTTnbWZy8CNM5CHlbzw7re8q++rKeE91dvXlTqwZoDYOIW44as8kV4C?=
 =?us-ascii?Q?ZDrKcg1pzuMFuHfxbhVzOnD/HYAyiYSKtUy2fzVIMz0m+OFQgc9t1AKev6nf?=
 =?us-ascii?Q?UrPcKGY/78M/VLVo23a2w0Z/fsjxa0b8ABYQl62YiSFrY7q6b8sS2YX9Lv6B?=
 =?us-ascii?Q?cAqgWMagTRe+Pzq53fwNsGHlIDMBguhc37P4mmEyH3NN16D4v33x5x4gO60V?=
 =?us-ascii?Q?5g8VkhMjY1bYdEbErkT0O0MGLwt6cL+3fdHt+VFCWv0rVUhraEosInl+A3u1?=
 =?us-ascii?Q?HosfwlDzaYdnOQ7zqJyZCbadg4OkdmbAI0Mfq39rAUn2OBagMPgYd7trJN5w?=
 =?us-ascii?Q?APXGuWf9BHC3FtZCcSHW8MS1WdvqonME+zufZzkC0j22CnYW4WWUU/D6yh7H?=
 =?us-ascii?Q?nIvsw2tHpNIOWNWjLzafQWTpY/E3c/M1HycnuPfQJPuN//58/bOtbPOw+95b?=
 =?us-ascii?Q?NR8yNjZ9zmvvowH3hYrI/JnolLleVLw8cFouYDZMsA9B8F0vPUQl+MhNO5jF?=
 =?us-ascii?Q?uxeapN6NAonRxd860b2zFnke8C5ticRmnwxN50Od6bCO19tNZLRdcnKoqVH3?=
 =?us-ascii?Q?Wvtaef1/9p2Q/CnkVnnzd3cMMTw6cM6hwQZZ62lacq2N6fIfAQkciEoZ/D5m?=
 =?us-ascii?Q?eIZll8NdOIjS5Ws9hMXJ5Yd90WYU4nWZCUdlh0+Iu09pQ6TOhMmDBGxHBQ9L?=
 =?us-ascii?Q?1NqBdgab89MMNeQPMWZ7EB58TaAGyiSkYvIN2Tvk6fiB2yT8rP0UFDm4YPJ9?=
 =?us-ascii?Q?ERvkKB/BlEfo3Sctn/3TNKsgQ1JXedG055qg6K5bbjBpfBtA3r2zT+Lomfse?=
 =?us-ascii?Q?D60tIo8OKP/PzhyBEgzAt4Zhai+lOewJdmpF4yKCXpv6Wp2b+Buh72eSQVYs?=
 =?us-ascii?Q?maFc5/p4XenHZR1ST3F072r+8IfE+Xg3ilAzK+djiJ9E0ydbKzYap0yRyxDV?=
 =?us-ascii?Q?C6RxChUc9whzDEniiYEQfjnV8NZAl6zX/FL+1/4XmJPsjGZ+MhinEyBKNOIJ?=
 =?us-ascii?Q?7SBf8mep0LXQ/iQ6FsLcFLNKBhblvQqfTWFNNUDEWR0GSXxpZ2z39sEjvr75?=
 =?us-ascii?Q?Lofy8+VhhkWST2yZCtrRThCJvtfDAq/Bb41bDXr9BiQICqXthCVuxSJM354f?=
 =?us-ascii?Q?ZN1S2WmSXnjLvbvhl64iRgcCt8Y8RIwQRlVA68etjUHk89/pxDXLB24+pKT6?=
 =?us-ascii?Q?LRGNfcbgHl8kSewlk4togQ8O5gilu3atfaQ3kdmVm3VTJ+6PlNAon2Z/a6KT?=
 =?us-ascii?Q?GdC/eQDZDSclFLEYJKsKIIfx+RLJc3fJ7aoKewRYv7PxmykF4/ZZmYh5pC4p?=
 =?us-ascii?Q?flX6xjUsBqjR+z2T0uLiGorW29Zw3hA=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8ae0cf8-c1fe-403a-1639-08deb9ab2ed3
X-MS-Exchange-CrossTenant-AuthSource: AS4PR08MB7555.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2026 15:43:21.0597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aumyVpd/xe/AIYukxQuzqTprrDE8qNYu7QS9iHo8qEKr0Kz+n64QKiKvDA7B4fDqGBki00OleEvXMLv7ABhkWPPZ4cUyHT+L7HQXtkSu0+Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB8745

When multiple callbacks are registered on the same tracepoint, probestub
will be indirectly called via traceiter helper.

Pointer to probestub callback resides in __tracepoints section, which is
excluded from ENDBR checks in objtool. Pointers to regfunc/unregfunc
callbacks reside in extended structure however, which is not affected.

Registering multiple callbacks will result in a #CP exception due to
missed ENDBR in __probestub helper on a CFI-enabled machine.

Fix this by adding CFI_NOSEAL annotation to probestub declaration.

Fixes: d5173f753750 ("objtool: Exclude __tracepoints data from ENDBR checks")
Signed-off-by: Eva Kurchatova <eva.kurchatova@virtuozzo.com>
---
 include/linux/tracepoint.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 583d962abcc3..5a32a709759c 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -19,6 +19,7 @@
 #include <linux/rcupdate.h>
 #include <linux/tracepoint-defs.h>
 #include <linux/static_call.h>
+#include <asm/cfi.h>
 
 struct module;
 struct tracepoint;
@@ -356,6 +357,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 	void __probestub_##_name(void *__data, proto)			\
 	{								\
 	}								\
+	CFI_NOSEAL(__probestub_##_name);				\
 	DEFINE_STATIC_CALL(tp_func_##_name, __traceiter_##_name);
 
 #define DEFINE_TRACE_FN(_name, _reg, _unreg, _proto, _args)		\
-- 
2.54.0

