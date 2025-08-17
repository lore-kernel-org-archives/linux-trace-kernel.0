Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013043.outbound.protection.outlook.com [40.107.44.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FC279EA;
	Sun, 17 Aug 2025 08:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755420463; cv=fail; b=Hox7YWMFgDu4XtCSfgvKyWU95ghXRn0DSlShXz3u6242eWGtxywbYQZMgtzHdJ34yDlx75IeD1va69qVVeRJw0KVX/FLhurBNrouh6HNVK60OKQWm+BjsJmBTwH8uvvkSwTi/WYFZ37CGfEx6VfW3dBaMYdgzhxJsjOjd+AElso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755420463; c=relaxed/simple;
	bh=pIN9EK415kcWfGug+8XqfwDObRklUGCSXytxTqgfhqQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Hj+o2qPszryJwzIytAngTCtKjQ4UhIZhYf4EYt1FsK9qkbFllPXObzdIwKTZGHdkwHESIBUuZBDytOkHIOkHrgAr8Jco4WhS3JN/gefyLNwSl3tfZLzID2h269sK7Q12P3ygi4P/ii2yxf8RxPuQiQADblt3poV0PhP8EUO9LwU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=agZYt8W7; arc=fail smtp.client-ip=40.107.44.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="agZYt8W7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ePZjJDnK0yYqsOBjSKKb/k38WKmleVCO3zibuEnD8wUCAYH20Y6dkXvyU0d4fP0VX4hjb6HzczaJxc2NGvgKDQlppbu5H6wOm09x0hZM/q+SXeK904jvk/o7aku/lGe4TAYOVf+Eqkg721q5kXar1nfdevUlg5pE6J6dxruI0Fu2bicT2DzlaHcfuM47eQMC7l6r6MMZqXblGm89TF6SC6bLRoak8Kq9dzb3HBHLYUuG87AgK1KQYMhR52LYZz5FVNw4vZI8HIw2sRMGdf5n6X8rIOZgDTAIZxal+5E5z28LpIbdkCo2WxKLiWvQgXhlPjhlohcCqbF3DLQySxE1Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KcPOplqCmDwzmB4GVODZj1D6NeY6kBinS3J7G9uvsG4=;
 b=bcyaCQXyquMh/FH05B+ux8Ly1WGKaCBezUJPikAmWUwEOL0IrVe42Z8tA0e1d0e6c0+TXqtj4oT4GSRfewyePm/qJh/HFWWMfkLimFCPe91z0lGCYaNrb/CTdKWLKuOqUUmfJGRXCh2RdR/WXDSCCwBslJCcYM2EneqUe9U3Eg0EHIiU/h1gsnPJqbCJ4LgSUoicsG3XzVWGs8cFAgg68tQTRKkNcNE9V6V3N78e1vRGpYxrklID/ATPraPY6JlO+cbEt/IT2GCPDMCQyTGVSZ4bbtU69gv3zSqvPiaXgd7BVVP4xJw++6zHR1vhdNMY0IMp1XyaZIi4wUqqkNx0Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KcPOplqCmDwzmB4GVODZj1D6NeY6kBinS3J7G9uvsG4=;
 b=agZYt8W7/Pf9vpIj4oRD9eYI2zlWAXBsRJo6DSNDFLepKmJmJGbVCnFArFp9PMgI+j019/9oo8inLO+oR8wICzQZjUkhlNCkVkSTUXqLXyj92NYugiymDVHcMzKChJO7cF4JO/ZgvXQ4ouix2r/h68frljZKwO9JzGLElnZaBi6iQkU8IjPJ5ZGmRsKlliVWnUfH+waohkV8+jshz+EojD3X2raAF8f24hURMcR3ZLsOzgIs43tFyGGnQ3tKFGhB8TzyMtawRK+l03PrmdlV4p21F/Hs5eYkQIed2ebomYe8ncTVfZWsK/t6Nr09sfu5lG6cmhtwxHHaPUaXTqhFMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 SEZPR06MB6405.apcprd06.prod.outlook.com (2603:1096:101:130::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.23; Sun, 17 Aug 2025 08:47:37 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%5]) with mapi id 15.20.9031.021; Sun, 17 Aug 2025
 08:47:37 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Qianfeng Rong <rongqianfeng@vivo.com>
Subject: [PATCH] tracing: Use vmalloc_array() to improve code
Date: Sun, 17 Aug 2025 16:47:25 +0800
Message-Id: <20250817084725.59477-1-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0192.jpnprd01.prod.outlook.com
 (2603:1096:404:ba::36) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|SEZPR06MB6405:EE_
X-MS-Office365-Filtering-Correlation-Id: ba126bdc-b462-4c8a-72f5-08dddd6ab774
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?w+saRxRJjsJFFReeDSQY2Uf+DC9uWh82NfJxwnzvTRXQNWXALUSX+ACG6PDS?=
 =?us-ascii?Q?UIJehqNYqI3ppau8vD9M6sE0i2UWYFX8sIomZkMr3H7qYpzxrbQ2oaDk/JNk?=
 =?us-ascii?Q?IPh/mbXFDl2eUcckFwT0JYudPZOFUPIAUxDhZYpv04303mvuYl3zlQ17ppyM?=
 =?us-ascii?Q?eNQY7v6aGadMzcooyVT9Ih3GEC0Nksq0z363yWR3xMjI5kQVqWuADfKTISti?=
 =?us-ascii?Q?+RmUISXiXQnGcyicmXTIZ48ng6F3QfYZCnIK/qmSlpu6kX4LBDJSDxPqPbDB?=
 =?us-ascii?Q?Hq20GH1SvW6xfCUkKgjKVkX2v98ycro4kLFedWTDfOEAWNFs7hY/W7X6l+jh?=
 =?us-ascii?Q?3CU83cTsK5NrB1mr3adEhP9k72AZCDgObvnj2BCH+g4CuUU3Bw1i9UGuDRTI?=
 =?us-ascii?Q?qnE57jvwqdK+iwHydm9cud/Kd/WEw8nrDrPR84qQ1RkLQcrtGGhG/27JIYs8?=
 =?us-ascii?Q?uTwrQG4ADpZ/PZjdE0usZRSg0fXNnXMOvS0gNHKv7t0msPkxKJYulRD6r8Zf?=
 =?us-ascii?Q?vzHWKLWQoW54nvbsagUeLkEqtrwdtYQ4D8mBzHbs+kXXB369CW6+Dqni+8nI?=
 =?us-ascii?Q?Q+kdtSfiz0dIDYMfTb1mrS+a5fc4Hj4RCLR9NIs4RKwQOHkgB3sm68zmMM2d?=
 =?us-ascii?Q?5w7KtvRl8mkDEn3CB4qMrZGDaGGohmbBYr09fUZ5Z6PFrD6ox8L/3pPmjiKk?=
 =?us-ascii?Q?J/GCnzDiij24k6IFX5uDq15MZZO5jH9m1IjSnNKgSXHLzLzATY3rsIDkPysW?=
 =?us-ascii?Q?BzaEf7oN8VzQ+jDEsZ1Hmufot7iPxtTfZtFrIQog471eN9wMSbBb0LNiP0dc?=
 =?us-ascii?Q?dootqWctl87Stx/GsjCib5ku65vtAmowPido23uvGTFwQD9uhfl89OOc+93d?=
 =?us-ascii?Q?vFOm59ffpsrAEyWNrIb+qwlPtlm7i8SS6mznRCBcT+CJ/67+sicnGbYPRnEs?=
 =?us-ascii?Q?lH1JHBDgGi5LDovz4606MuhliMqnZARYW7+URDPkWYQag6ukIDtSrK5Nel76?=
 =?us-ascii?Q?lQvznZeKp/1i38hxmG4z98w3ORKycB9r9AyuADlLunbsqK+E44zwujiacrFo?=
 =?us-ascii?Q?gyZ3JrGsn20AY5XkohxZHGifUpIcRAOUZQU68eBz2pSPjMZtqBkgjLdk7t1y?=
 =?us-ascii?Q?y9H2SeQK0yB4wMx55Oj65acpnII5Ks+aTBfoCZxtH2q8SYiiq7on5Vp718nX?=
 =?us-ascii?Q?dkIqGAxzOvAZOn4p+kvg9wCrd7wpDJsQjpKk4F9+p06B803kttwzYDxyW8/q?=
 =?us-ascii?Q?1x99vVGQtv9jHwTvFbbmBwir2MwdY4CIJksXdluMTaetFn4uA7zT+XXWxvlt?=
 =?us-ascii?Q?CudEOSGBvgne5psUcPU42keEHFbIrCBfVCpxpxmxgRCMP3Eqe2/Ud0OrW6t3?=
 =?us-ascii?Q?yWpq1JgD8wmuRCDtvjdJIXEGSL3kvzQhRRkkVuTvOwONvX541yWGjvX6YrZr?=
 =?us-ascii?Q?TDxnLDJp38WzzTVRCuLNyztZLfBRdIlkHS0ORHu1g2x9RGb3bO5u1trLARWu?=
 =?us-ascii?Q?RFFcglmR6Bj6R5o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fYdOHYNmMyUnhV4vTuqb+hCHTxWpQ3BDBUWJ0KbA4chASIRD2egldpJPgs+p?=
 =?us-ascii?Q?vHRXhrrCGzXZt+4zg1qxeXKQPriwNLdghyKIY213SYR0JIPcgxW2/2WfVgQW?=
 =?us-ascii?Q?xyG8PC/WDenQFExDOE9lx4TbzV/V24zP8Uescidk6ML7RCmqalSx8FAkGo/Q?=
 =?us-ascii?Q?Qb3HLXjH7zOi5rRBVsVodeTiv927pVDcnWpI/RbJ6EAU0ec8WyzWxmebOuCF?=
 =?us-ascii?Q?vVd2lGH6MKUz4ttpiGL48CjF55OxxB+Yc44vk9OoW+F4rHDzbBp1gUaByv/b?=
 =?us-ascii?Q?xAoczIrqTmZwauhD15s2V4lcEwEn40pr49UDzrKQR+b6HmWdq5VG1+5c8zqR?=
 =?us-ascii?Q?pJkPbxPN86GZt3xmL1YI2u6OYgIZhmsWobBtSj9fSDmNJxYZ5iy5bod2W4ik?=
 =?us-ascii?Q?AFX+B8KlkhcXiZTzt4qC65C0YJnL0Vm0uRlaxl/31dLOKmIPb5jAO48VxFZz?=
 =?us-ascii?Q?8EX2MwoafK+w2bOwXSwzQKc55iVomZX/SyoloQ7pJUKuJsYP1fJAkYYjQLzT?=
 =?us-ascii?Q?bnqThC/syJuMcjlVtfziIYzKOmrsfh7Idv7+qmNSTrq/Gv81RJj0hAijmMG8?=
 =?us-ascii?Q?j4wMSBP7qV7eSrHtE26msE7y210w4O1QcMuCTA2YEMK7z/wE1Tzwgk4dcGkt?=
 =?us-ascii?Q?6V6rsImi1ziBoj2sLb+UWvo5HedlNBUiOqiXVTAB/gqC/X/wnInCUlzDT0sO?=
 =?us-ascii?Q?dIyB27xcuByqyutFO3mkk24PSmJWCZx/ipjP1NSIg+0C07wKCw5yGcOzXvbh?=
 =?us-ascii?Q?jAsWrSv2MZUEwjcgmkdEpfPuGSeAqbM/e3b2c9+xOg8in5rfk7SoIWU1Jx1g?=
 =?us-ascii?Q?debF1rEEQUHVBLGNHAyw01pyKlmyunnQ6juph/AFSULqFYJ8HTBz6wHHFre4?=
 =?us-ascii?Q?StfCEzRIBZs7lVqhtcjt7+cPZ7yR4aaL+iQ8OFzMdcPYooDeDqTLf7bjPlV/?=
 =?us-ascii?Q?VWoVP3AVGuFyI8bhfx8jGQe7D01u6gJ+bANGwDVEUY79Avx9LKg0hS8Z85RS?=
 =?us-ascii?Q?010anO2KGzjOZGSWf4dUGZNzukaOVWJl/PHU0fi/sPkObrehLgVioPze1gj8?=
 =?us-ascii?Q?MtOxhATJVvHbtT75I6e+syZXNYvHnXGk7kn2QS1N06fy1Yrc/AF/CBQn4Xfu?=
 =?us-ascii?Q?ZkSpFpcGejl9pcRfmp8cRoZEcwmuBQGsfikGFGel0OtO+cgZup7qE5pXqEXg?=
 =?us-ascii?Q?no3bXrmSpTN2/Gosos2gaBmuMaSOXkvibRRu1vMu9rStFmyxu5c+gYSIcSWZ?=
 =?us-ascii?Q?KrANjnokOtqsiYvQhva/7xPPecYwgs0Mu3OCr7juU0zfAsm183F1no1Lynhl?=
 =?us-ascii?Q?Ub8WESmPdcrw7Nog4pdamyAED/r7oiLnIGuxW6Xn1+L8SbMDcyQyyZSqefH6?=
 =?us-ascii?Q?jJo1vZCJzrjHlKxrAVfXbz6Lrw8tFFJ5RGSsHzhKqHKd26VchK+ElobYAkQ8?=
 =?us-ascii?Q?hMk5z3lP9kUC6TCNNW3to/Yri8jWfWMMADcxqvHpYLR9ht1hrY1FTyPgMWjy?=
 =?us-ascii?Q?GR9h48zwi8Xl/DHVVDFleDWwXWM0O/M6z0OTURBNpCB1nkIFmcnj0Y9WR5yY?=
 =?us-ascii?Q?qthvIr0ZGeWTsgXBX0/R7GgzZI4jaYpKIHTi21Vb?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba126bdc-b462-4c8a-72f5-08dddd6ab774
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2025 08:47:37.2887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KB/bt+rh/RtWVz0r9uZ+o2lb3y6Jb5W6fGxB5KEGsKQuGcxLNgbHBZeL2vGh5pKKlW+fVyjQgHWq/cSCOT+9hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6405

Remove array_size() calls and replace vmalloc() with vmalloc_array() in
tracing_map_sort_entries().  vmalloc_array() is optimized better, uses
fewer instructions, and handles overflow more concisely[1].

[1]: https://lore.kernel.org/lkml/abc66ec5-85a4-47e1-9759-2f60ab111971@vivo.com/

Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
 kernel/trace/tracing_map.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/tracing_map.c b/kernel/trace/tracing_map.c
index 1921ade45be3..7f8da4dab69d 100644
--- a/kernel/trace/tracing_map.c
+++ b/kernel/trace/tracing_map.c
@@ -1076,7 +1076,7 @@ int tracing_map_sort_entries(struct tracing_map *map,
 	struct tracing_map_sort_entry *sort_entry, **entries;
 	int i, n_entries, ret;
 
-	entries = vmalloc(array_size(sizeof(sort_entry), map->max_elts));
+	entries = vmalloc_array(map->max_elts, sizeof(sort_entry));
 	if (!entries)
 		return -ENOMEM;
 
-- 
2.34.1

