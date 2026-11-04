Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.10.89
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793784114;
	b=ZdgNc9uqJF4kZ7DEkg/QYD0FP5dbwMLb5XuSBNpBFcDAf5on35/YhwwJ5/ooV82KYEMi
	 jWb22I10a3fkayDfsRtX969RcOSLycsK+vl3raTRWCtqo21HVuJMAdtnH6dMZcY4isBin
	 ypZonBZdNHZS6CYPWhk/HHh+BreKl+APlQEPYlXDod1sp3nvd7JYqpcmS8sFugFw3lMx3
	 qVskPvjAZ8n78DB1OuLX4tbs0aS+GpbdQdh/IUnRHWQlhvwlw7QN4yas93Q13oeiaOjLo
	 RXBq19psY0ylNs1ZRoKOyYQfSGfX+B3Y2VN32mRKjumFaL8izfU+RlPiZVwWqCHjMwQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793784114;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:
	 X-Microsoft-Original-Message-ID:MIME-Version:
	 X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=Ap7ftiFf8LYhu3DQ5HRD8bLP9HT9yZX1j3hNOn3QXS8=;
	b=5ktyGaTBbgiXjbOlRK/N3JakwqTpYaASCnKQ6vSJ4989WPzP6a8v/tUBxy9GOwB6tRVM
	 PQkGDAQAchtS2HvYZR8OB98uB+WlLeXuKnxz27tYD7KSkxZziDrI3ZXdJuAfLwvpDU91W
	 ckzVGtDU3K3y6kqLsO6+iWnLBx1AfoUPlngmzU+CfhXL9Qw9mBfco6sMyTj6IqMDZxWfK
	 he6WTm/f4X9nyOwO4Q1nAjaO2MZ0j+TPmdVG3++VI7HBsMllT9PqyaKwcZc9aBscnTTXo
	 cjFAlcx3y52a5avTdatxSNcsWEgWEAAl0Fe2tTd3NN32aImbl41m2JSrvXVJ8vsP9wA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hotmail.com;
	spf=pass smtp.mailfrom=hotmail.com;
	dkim=pass header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=ONSKx2qI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.10.89
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azolkn19010089.outbound.protection.outlook.com [52.103.10.89])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD78606EEA6;
	Wed,  4 Nov 2026 09:21:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7DD78606EEA6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=ONSKx2qI
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dRMZ9W0cxNnGbWuwGW/7dF5BSab1qEVaAs+5e3JOPhB3OC1tgV9oPpKgCvTxY4sWJSHYgJbVjp9sCC3cCoWJqtWpzpVKdrvJ61WXeq0EA1zDe2bfOtQMhqa0btOffegxprD94zKEujZGpNRkLkuPYffgTsnxEsFHZJwf+ryYT8P2fwOOTgePHY5PGJ/9Hv02VTrm4jL6/bn/x+vyRTxTgbLnJHxjx6i17QxPQP5VRzLyraF98jer0HoQB7bHzwKdyK/xhPB8frLjmyF/E9fLoFoBOH1EM3F2OL2qUyaAmS2982zr1kVTgyPTtd1GsQhYqrU07ng3AO2ylrnKBnPvgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ap7ftiFf8LYhu3DQ5HRD8bLP9HT9yZX1j3hNOn3QXS8=;
 b=YNVfx8Wb/LGNSyRK2F+1tH5nkZ5OAkuB1d0VgE9ph9e0iolX7wAb8YcmKdJ7sDAkkyJIV3A6kXEikgOPvSfBVf2j9r5PlqdUFVAbcpWFnEJ7CxSmJu7pncrvqyiXBloibr7hpWjQL8WOaiBImn68akjwlk+9m6eLrqvMdZYDJH8hn+J8UjexN9zv5cCPDNCTOqlOGyoGY2vcAu6egrj6h1xnMdCcG1dleJ5oEeJf9fmfMXuwpEvHs547RtfuS4po81lrgNVPh/Glmv2aNXr7OGnBGw4DDc43ezgobf9HZhb2Omc7kSkx4h5qgsx76RYm9QXJJol4n0RONM3YcaEGgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ap7ftiFf8LYhu3DQ5HRD8bLP9HT9yZX1j3hNOn3QXS8=;
 b=ONSKx2qIOkPUTT5vI09UMr902clKt9IoEBqi8BTvqcCevoKt6PBrSr+R0N4WVtxY7cynUquKnc0FL5c0d7ft7hzGIlSyD+JyWnRZnEbZax5WEOfFyRbuP8BhqnYTYsqQlpyiUxIEpXUZJzWUuSLfD9ELzjmwiQFZyReUiUGOCiZa9K/b9hHAOHwvSvvq3CGqyq+1s/2wb9ACQX0mUGeg17e4sz26IGqt+GAQI3Bis/LL9/6dPV2daS6CnaKbG9jzjKqOxPDY8YwuUdb/fo8ZLrBIehY7ETFGlTwFgcOSWtD3Kmjap22FsZT/v7+qma/ZBIqNaxqux5JyO41vzK1VxQ==
Received: from CY8PR19MB7009.namprd19.prod.outlook.com (2603:10b6:930:5b::17)
 by MN2PR19MB4063.namprd19.prod.outlook.com (2603:10b6:208:1e3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 09:21:52 +0000
Received: from CY8PR19MB7009.namprd19.prod.outlook.com
 ([fe80::905f:ec34:5f65:aaeb]) by CY8PR19MB7009.namprd19.prod.outlook.com
 ([fe80::905f:ec34:5f65:aaeb%6]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 09:21:51 +0000
From: Wei Li <liwei1412@hotmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Nam Cao <namcao@linutronix.de>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	liwei391@huawei.com
Subject: [PATCH 3/6] rv: Show the mixed enable state of containers
Date: Wed,  4 Nov 2026 17:21:22 +0800
Message-ID:
 <CY8PR19MB70099F2263C408361053B295B7682@CY8PR19MB7009.namprd19.prod.outlook.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <CY8PR19MB70098BF493A3B67418C7B9ABB7682@CY8PR19MB7009.namprd19.prod.outlook.com>
References: <CY8PR19MB70098BF493A3B67418C7B9ABB7682@CY8PR19MB7009.namprd19.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SEWP216CA0095.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2bf::15) To CY8PR19MB7009.namprd19.prod.outlook.com
 (2603:10b6:930:5b::17)
X-Microsoft-Original-Message-ID:
 <20261104092125.915254-4-liwei1412@hotmail.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR19MB7009:EE_|MN2PR19MB4063:EE_
X-MS-Office365-Filtering-Correlation-Id: 22cf2361-d193-4d64-6998-08df3a550f76
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799015|25010399006|19110799012|24021099003|260925184616899003|15080799012|5072599009|23021999003|25031999004|41001999006|51005399006|40105399003|26104999009|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kxb1sword7GcgBKHkgzF9yPSpuvunZeyGdefmol45mS2CjsT5tRUfIU7elpX?=
 =?us-ascii?Q?4110dbMpXyPHOsiWCWcrzzZVSdTB6nF0e4lqVHnXZU4AXNzJL8yjk9UbrePp?=
 =?us-ascii?Q?rewQmgfpgL31PHeyHepybYcOwfFnrT5BDpmnBordg1Q92xbDSoCH0/edFHOm?=
 =?us-ascii?Q?dA+If292atRKB+qM+APKOsJ1J6LDe0EnIRtXq3K2CDZAUJl+9uLGqKdbl8aH?=
 =?us-ascii?Q?rPgvxF7ywqoPNudfaysc+ZlOxpvKc0zjHwmiOGkZXywBNa0hk9nD6XYorNJQ?=
 =?us-ascii?Q?nxaBtbJpLkUd7fZfNdKpnupkyDfxHF+VVwRHmMZ7ql/FvQkiUcHBFo8SRMaK?=
 =?us-ascii?Q?PxDN4WZcznVOX+rqjq4wjwWlfLhDqPa9z0jetuymRdOHhwcdFpCJudJb4DV/?=
 =?us-ascii?Q?x5a5D5lzo7/KD0vJjkplfGHZzlGxWpmt3B1r646UdBVyIGiUFGGZtIF+cP96?=
 =?us-ascii?Q?sxY30MVGBYJFvwF6YMgZM8Qzp8rh1lHWDCtTASQLsIQxy4TYB2BTumRtMUjU?=
 =?us-ascii?Q?49QoAgoIgfZz5SNd86z5WCiXo2BvnsCb/ZHQgYb3ekrTiP1St63FDDUmQEmu?=
 =?us-ascii?Q?HLYIGVZvF6j9gnE7TkE9+WHQjHLW4rqZ1LUXhbZaULT9yjjrgW74sj8QelZy?=
 =?us-ascii?Q?nmh6EYd2nlsJB7ISgKcPUDOUh99CacjMTmrjyZiFXiUEuOwxW8KdZL1oYGjg?=
 =?us-ascii?Q?eGBn8F9n7ivatT0tbiEqSD4eqIwpo9kKK2N9dcXSjr+mUa05srH2Z8m9Jhe/?=
 =?us-ascii?Q?mef5muf2170Y7EYsT5aBbIed+nFmN/WsSIwTqb3vpxU+bblI894VUXByCxpx?=
 =?us-ascii?Q?1IzAMEgwOCXcTT29MfOhL/dCfpn0ga7o8mTvV4kfRRdwa8gs6IFXJU+7l12u?=
 =?us-ascii?Q?1iazWXqoy8NW9HBjrFjzrCUl8BDPrUcmTMxkYKMAnJBiRzH4I8X9w1NLXp6Y?=
 =?us-ascii?Q?fmHL3VAYKlSTc7tlXEveMzogLgZqXBM/0yTsTWwMq7F1LzRzlc1EHfZ38CTO?=
 =?us-ascii?Q?J8ZX?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MMpwi5XHlilrVX7shxjc6jx6sFvUwEFV4BFgTaLE9AOnI5l75lmrtvSWduQ8?=
 =?us-ascii?Q?X5H52AqUIJs3O1TeorVYdmMLnx4YS4Y4Gh2lksbvOD8B36p4kuYB5ktd+AE5?=
 =?us-ascii?Q?SvtBaEOtiP9NrhgxEiOb+Ze/kFk3yy+pLMorpAA8XHw+ukH1Wgrm4IEBVlvj?=
 =?us-ascii?Q?Ccv8xLj0Q8d9aLeCCGsEcIuQZAaHldsjlFQR6EhiZq2W+4QMpz5AEwxHNB97?=
 =?us-ascii?Q?PRkHep0ZAL88l6OP3VA374TWTZCourhdmsKqOCZDhid5Uc/ArxZBEzYVulhD?=
 =?us-ascii?Q?06DK5Qyf7hTXh/wnHnonP75+QYmha7eSN+6xpWBNoIW8nPlmTGjR/ev0BT8X?=
 =?us-ascii?Q?BK6/lsHEMf7zSIUwAUnacinKWVSct4X6UTuOibtkxdl8CUmMZ3L0xWsLxLHd?=
 =?us-ascii?Q?eDIq2kV0niQKpGo24GHHk32sXbEvTCNjwwepSbZyHz1mPmeaESXUSo7xbB37?=
 =?us-ascii?Q?Y1eMTJ53vgDwrmaYjXDT7Cz1bUkaTDkKFrrT6HFgeQrJVocix+IndW2YoaJK?=
 =?us-ascii?Q?F+/kl+yxQPlBEGFBOVViGfhKjNE+sRcGu4DzQldLf++jGL0RtyjBak2rePQJ?=
 =?us-ascii?Q?VfkZ7X571ypD5zMBDJ8jQaYIGaGAoo34YOyUpJxYg71zDbbWc5AtM5ZPgWQv?=
 =?us-ascii?Q?eJv6nrWyEGtPjy8sZZ+S9JZEYkxGc6hUBUGQI7xS25ISGl4UogXuKW76Gvp9?=
 =?us-ascii?Q?h5Qcd9tGZIEvhD0qXKUdSHwcaucDYY3IZ5SlE7wyIICU17qBOJUyNI9vk29y?=
 =?us-ascii?Q?CIRBRMu4iQKrum7MJrYIAltNEyCy1zQny5ZAkDldJF0VIlU4sdh0/9eItJey?=
 =?us-ascii?Q?tJpx+Ij2rjOT5Jx00fUfCVmYK9nSR2PQVDpQcW4ptym6D49y4vzSMRyIQxAU?=
 =?us-ascii?Q?AiPL5VBtB8dalcGqNYN4PFN+6uGJw7zEGyZx58ULY2Fsy5G7WSs2NLSqWBvQ?=
 =?us-ascii?Q?M0vpmovpkBYR2orl0AsZ6CKeuCbkfyjOiIB2l//qMpJkMDVR5qdDtT89TaCq?=
 =?us-ascii?Q?f01kSiryIDvieFg3L6/l4puKm8xA4lCLNtRJ000F3G8til9YpQpOZC9NrADD?=
 =?us-ascii?Q?rRN+faWb0raIqoCtYFLovhLqWM5UtnRcNwK16drXU8bsGeP9YpAZ6Bf5+ifs?=
 =?us-ascii?Q?qtHyCFM//OWVg5Kxtme45Xf+0Sv2zD8me6wZYHpBf7swY2O0+YzgTC2JL7Ms?=
 =?us-ascii?Q?AWj5YGnehYq0kMGQVMCgNMVZRUhgE3mzTTc6lVK6uKehHnw2ZHCvoClWW7Yu?=
 =?us-ascii?Q?WRndAng/p360E6TCaseZo+a2VwigzN/e5YrTBMAdyNP6N4NjOpkALElUAKbZ?=
 =?us-ascii?Q?VdQaPWYWCJjxhdzT62a/d5uvZacZgtvsXcci6PqTag3EXN0y4gfMdaWEbUHW?=
 =?us-ascii?Q?oPap3+GlZko5p5/JmzicwU6OoReb?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-990eb.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 22cf2361-d193-4d64-6998-08df3a550f76
X-MS-Exchange-CrossTenant-AuthSource: CY8PR19MB7009.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 09:21:51.9253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR19MB4063

From: Wei Li <liwei391@huawei.com>

The enable file of a container reports 0 or 1 only currently. A
partially enabled container is indistinguishable from a fully enabled
one. Tracefs draws this distinction with the "X" value in
system_enable_read().

Turn the enabled field into enum rv_monitor_state.  Refresh the
container state when a nested monitor is enabled or disabled.

Signed-off-by: Wei Li <liwei391@huawei.com>
---
 include/linux/rv.h   | 12 ++++++++++-
 kernel/trace/rv/rv.c | 50 +++++++++++++++++++++++++++++++++++++-------
 2 files changed, 54 insertions(+), 8 deletions(-)

diff --git a/include/linux/rv.h b/include/linux/rv.h
index 541ba404926a..37ca94d3c4a4 100644
--- a/include/linux/rv.h
+++ b/include/linux/rv.h
@@ -136,10 +136,20 @@ struct rv_reactor {
 };
 #endif
 
+/*
+ * Monitor state. A plain monitor is either disabled or enabled. A container
+ * monitor tracks its children, may be mixed if only some are.
+ */
+enum rv_monitor_state {
+	RV_MON_DISABLED		= 0,
+	RV_MON_ENABLED		= 1,
+	RV_MON_MIXED		= 2,
+};
+
 struct rv_monitor {
 	const char		*name;
 	const char		*description;
-	bool			enabled;
+	enum rv_monitor_state	enabled;
 	int			(*enable)(void);
 	void			(*disable)(void);
 	void			(*reset)(void);
diff --git a/kernel/trace/rv/rv.c b/kernel/trace/rv/rv.c
index 4e689d4590ae..7846e4092b9c 100644
--- a/kernel/trace/rv/rv.c
+++ b/kernel/trace/rv/rv.c
@@ -235,12 +235,15 @@ bool rv_is_container_monitor(struct rv_monitor *mon)
 static ssize_t monitor_enable_read_data(struct file *filp, char __user *user_buf, size_t count,
 					loff_t *ppos)
 {
+	const char set_to_char[3] = { '0', '1', 'X' };
 	struct rv_monitor *mon = filp->private_data;
-	const char *buff;
+	char buff[2];
 
-	buff = mon->enabled ? "1\n" : "0\n";
+	guard(mutex)(&rv_interface_lock);
+	buff[0] = set_to_char[mon->enabled];
+	buff[1] = '\n';
 
-	return simple_read_from_buffer(user_buf, count, ppos, buff, strlen(buff)+1);
+	return simple_read_from_buffer(user_buf, count, ppos, buff, 2);
 }
 
 /*
@@ -269,10 +272,22 @@ static int __rv_disable_monitor(struct rv_monitor *mon, bool sync)
 
 static void rv_disable_single(struct rv_monitor *mon)
 {
+	struct rv_monitor *cntr = mon->parent;
+	struct rv_monitor *p = cntr;
+
 	__rv_disable_monitor(mon, true);
+	if (!cntr)
+		return;
+	cntr->enabled = 0;
+	list_for_each_entry_continue(p, &rv_monitors_list, list) {
+		if (p->parent != cntr)
+			break;
+		if (p->enabled)
+			cntr->enabled = 2;
+	}
 }
 
-static int rv_enable_single(struct rv_monitor *mon)
+static int __rv_enable_monitor(struct rv_monitor *mon)
 {
 	int retval;
 
@@ -289,6 +304,27 @@ static int rv_enable_single(struct rv_monitor *mon)
 	return retval;
 }
 
+static int rv_enable_single(struct rv_monitor *mon)
+{
+	struct rv_monitor *cntr = mon->parent;
+	struct rv_monitor *p = cntr;
+	int retval;
+
+	retval = __rv_enable_monitor(mon);
+
+	if (!retval && cntr) {
+		cntr->enabled = 1;
+		list_for_each_entry_continue(p, &rv_monitors_list, list) {
+			if (p->parent != cntr)
+				break;
+			if (!p->enabled)
+				cntr->enabled = 2;
+		}
+	}
+
+	return retval;
+}
+
 static int rv_update_single(struct rv_monitor *mon, rvmon_update_fn_t update, void *data)
 {
 	int retval = 0;
@@ -297,7 +333,7 @@ static int rv_update_single(struct rv_monitor *mon, rvmon_update_fn_t update, vo
 	enabled = __rv_disable_monitor(mon, true);
 	update(mon, data);
 	if (enabled)
-		retval = rv_enable_single(mon);
+		retval = __rv_enable_monitor(mon);
 
 	return retval;
 }
@@ -325,7 +361,7 @@ static int rv_enable_container(struct rv_monitor *mon)
 	list_for_each_entry_continue(p, &rv_monitors_list, list) {
 		if (retval || p->parent != mon)
 			break;
-		retval = rv_enable_single(p);
+		retval = __rv_enable_monitor(p);
 	}
 	if (retval)
 		rv_disable_container(mon);
@@ -533,7 +569,7 @@ static void *enabled_monitors_next(struct seq_file *m, void *p, loff_t *pos)
 	(*pos)++;
 
 	list_for_each_entry_continue(mon, &rv_monitors_list, list) {
-		if (mon->enabled)
+		if (mon->enabled == RV_MON_ENABLED)
 			return &mon->list;
 	}
 
-- 
2.55.0

