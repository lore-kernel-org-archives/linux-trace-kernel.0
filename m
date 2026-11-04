Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.14.83
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793784110;
	b=gAOisO/Yxv1i5+5gG4mbduLQgRaYZM+JdUwsHUnDRUXQHIai2hgvEhmVMGkWBUcUiqmA
	 Z55EytdAhUD6Caqu9oJg6/A3A9DEkgpea1x4NMEFVdDPpDM+QNaSgjkyUvMy3JRzSndjV
	 4FQmfxeOakZWN2e7kaRYnFfMUkLQNYh56rfALZXsDVnCsoUGil3bNc6fkYmg66HcVp0wk
	 Zjd5YkbdGDC1QXnD4ObQt3wQC3W9berKeVAj7WC2Jye/pOLLOLJASN0yRLzhJPxJGf1ZP
	 US5AP9BmecP7aWbsIAeP+Y5vNAbWEYW70FGe+UoyHXPIKX6WIxm1CsyfESLMHSsMXig==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793784110;
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
	bh=fBL4vD6sFwSstwdDzHqwI9scCy7oXa+GBM2dVHFwtkY=;
	b=PSiM9nt84FaLCzzqDmmFtGISQ/BbpDswNxLpARbCvWq+tm9tJRfhvuxUKSK/rfHFQWe8
	 /7NhZMBZ9WcOB/eThpxVOQqkVwKPnafD3RGcmNBnrbjMN+hmEbr5fzQ+CXWCzqNMVvW/9
	 +UFNsYI42SB5+jvqhKFL4VVjVSfliwaDoYaXtRGYQDx88BDsJNn9bqqg8/pB9wpWEAoLZ
	 c8Iv3dbN/Ofl2LlF/7fn9i0j72l5bckoFoK8UZ48tJj3gikOZQavjETFRR/TOTyxsAwoo
	 GdWem2Ay9wMKo+J1jNjjCmwD8ZOn0WEYNzi5CYQ1ymNT+9lejBhUKSc+o0nOES8R4fQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hotmail.com;
	spf=pass smtp.mailfrom=hotmail.com;
	dkim=pass header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b="Sv1rv/yh";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.14.83
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazolkn19013083.outbound.protection.outlook.com [52.103.14.83])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB383606D81A;
	Wed,  4 Nov 2026 09:21:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB383606D81A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=Sv1rv/yh
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VEX1y754XeKT3o6psOMppshIJ/eNr2Ih6FzGnZY1PTwRPieqRfeMyTA4XHyuGEWQtriXU31q2btrkOId++eiUNgjq7qhUXzsuWkXFUVn5TWhGx08ZXrDwb2zMKZMKu88D3GmpekcbJ/7YOgVMjBRVevMyzjQOAFYL8OVvJKo+aHasU6XGbtxslBp+xsUU/OoWQxLh1cWTgO9q6ZJnb44PKlJZjw6cr3TG7xwIgMJVGe8ii0UO0rvx6vXy3LL76zlmaDJXFtODNYy+tD8IOKQjp+9U+uPLVkvBqwLonl1601UHha2upr2O20fLgLAkQhdXHp9f6+mmpd0dxKJAkCRgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fBL4vD6sFwSstwdDzHqwI9scCy7oXa+GBM2dVHFwtkY=;
 b=NKQIwK5stu/d8SxloJ86MLnMGvRvsVN73aKM282VQI0UG9Tg+5582c9iPdKFaICt+Lhp4xh0vRo+CR6bvd2/oZ3OKH3vjDFq0ihv6RkNxAP91prH5RB/94e0YzilLGOpvGwrZSLjLdabmgcP7rtFyRT0Ra04G7IjbGeK40ZQnSQC4MnPkxSrM0g9HY7BXlcCTWDb3LcAwjqIj7fxDkWC9nEaN0AsTH/W11eEEj9fFjrYadwj2gJw5jG4rmsXYyowFs14frkI4EYhrUjS9lMe4G0O3tt2IYJURthbn7RVE0Dsv0ow2oeWX9Us9CjguBQix9H5Kfhldl8PuFJ8p0RHVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fBL4vD6sFwSstwdDzHqwI9scCy7oXa+GBM2dVHFwtkY=;
 b=Sv1rv/yhYAhiM9PEValyJ7yRx6OikNLeHeTa5SQJPPE6goDwRhPMwTXj9iBPBArFOWkMj7RPTERVD1COhyULi4zCpadho9d+hO7tFfSnb/Id5wY/5qcjhvWqf6iW1fCDRpTgp7xqtbQS5wIglFOc1Gmd9WDDeu+EnkJmBJjYC3l3Vl98RCT1phOotoGEh7FGF7oqiYhiKUkQNKMtXiukGntaL0TBStyKriq05bFYd7DN5XVEuKuzMu+qU4iXJhKvrjIl7XKh3SjhBw546j6ln0JwlA7zlgSu+XYO0+bnxbszDGv2KK0hTsrJNckdSa7tY89abpU4Nxd67DIRnIUDXQ==
Received: from CY8PR19MB7009.namprd19.prod.outlook.com (2603:10b6:930:5b::17)
 by MN2PR19MB4063.namprd19.prod.outlook.com (2603:10b6:208:1e3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 09:21:47 +0000
Received: from CY8PR19MB7009.namprd19.prod.outlook.com
 ([fe80::905f:ec34:5f65:aaeb]) by CY8PR19MB7009.namprd19.prod.outlook.com
 ([fe80::905f:ec34:5f65:aaeb%6]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 09:21:47 +0000
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
Subject: [PATCH 2/6] rv: Update monitors through a quiesce helper
Date: Wed,  4 Nov 2026 17:21:21 +0800
Message-ID:
 <CY8PR19MB7009AD3DA7BC39C8D5419B1EB7682@CY8PR19MB7009.namprd19.prod.outlook.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <CY8PR19MB70098BF493A3B67418C7B9ABB7682@CY8PR19MB7009.namprd19.prod.outlook.com>
References: <CY8PR19MB70098BF493A3B67418C7B9ABB7682@CY8PR19MB7009.namprd19.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SEWP216CA0095.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2bf::15) To CY8PR19MB7009.namprd19.prod.outlook.com
 (2603:10b6:930:5b::17)
X-Microsoft-Original-Message-ID:
 <20261104092125.915254-3-liwei1412@hotmail.com>
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
X-MS-Office365-Filtering-Correlation-Id: 75ef2212-0b78-4e57-8241-08df3a550cc2
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|23021999003|41001999006|25031999004|15080799012|24021099003|260925184616899003|19110799012|51005399006|21061999006|8060799015|25010399006|26104999009|440099028|3412199025|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8SswF7rJIdl8msEgKRdOxHaN7yq+bdWKZ+068z6v1qqEi86S8qNTGszKlQoh?=
 =?us-ascii?Q?okBfRRv0gRzlIWyHDJY08M9c7nAb35TldmuCrx07TYiEOXwAx8bkYMQm97Tb?=
 =?us-ascii?Q?flCSVLUmcQuFPzWPJSV6ARhjXWc5hm03P36BKpco8jcf8dnKIUlTBuKwRfRa?=
 =?us-ascii?Q?3zHba8+RUCdVn9Gz90a7sLb5tqjaClw/TSJFzwicTgnkj6hpfc56Kl/ZhYq/?=
 =?us-ascii?Q?7DLdzC9gMqbIvxwWq7LttQtnAFCuMut8Yz2GOyR0fgkNo0lVPuGHUh5T4cfr?=
 =?us-ascii?Q?s+upms00xecgU1c6+gaSjnae9c0hxhGlLbPn8UVjmTGEFqeCruGhWTaGw9Ml?=
 =?us-ascii?Q?0uQr7L/k22Qzb8RqK34gijvzmR+0h/BElqhmsPGpoyrMhk5aFnaeBsR7XlDA?=
 =?us-ascii?Q?JSOJ22zOBi9WMekksQ7/FVMHOqeZ56zyQHkQonmP7GdK+K2wKCCn1AV3hEbd?=
 =?us-ascii?Q?SMGew5vVVd8tX0r7jRgLIcG14W7I8sltiKpHqMzs97vvwRmRYMj5Bzy8kquU?=
 =?us-ascii?Q?OoI3+vXPP3peStrDHsXrnp+AeioyRdjpdIbsM18FomlUJJjIx/79ugyiSC/d?=
 =?us-ascii?Q?hh4W5DeHswtDcv85uFGjWIOJJqBCGbeD0C0CFYV2XJ33iO/PK2VP9CczofrM?=
 =?us-ascii?Q?my+qJ9EI8uJ/4VrC7o1irsAE1j95TEwdLdpb04YXxF3t08YfSN/N4DRRxmTG?=
 =?us-ascii?Q?TEYanuvZF703eM0Ay4ZQr7bWnX1ClUAU2kWEqbQJsMPQfhugoqveYQBGE8jv?=
 =?us-ascii?Q?QcId8NCsYqQbF4WUYM3KGcDV4IbFXUDZaIBANulUkzYBaJ6Pm1/5LZIiCgYs?=
 =?us-ascii?Q?fXEvLAdpzmnCGHoKF+J/B0R3arF0HkgYvTW0TAmLpHN1Z0BJ8IGt0Txm/OTl?=
 =?us-ascii?Q?gVl/dG3KQjV8yJGxHVVttNbQ9MjjvIDInrIc4K6dQqgvP34kUDp3u8eY7vd9?=
 =?us-ascii?Q?L6TGbBrkKH65pW+kJ0kLMjV0ZLM5Ua88E3CIIn/bw+CTD4q0lqx+mLYapCUV?=
 =?us-ascii?Q?K4hvtAeBq48SAepSQABWnyN99nB72/tfbMSwdgqKmq6ydg4=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5/xpziKzEI7TI4zWub9H1M1gHO7HF0SV67gBiw4exitnUR86l7/nCAPB1bZb?=
 =?us-ascii?Q?Ekl0YJzQsIp7+g6JGNdnq7geZzLdLVwKCm4TOjJf/7LhYPpFwCRNtYxuluMV?=
 =?us-ascii?Q?7Ki6YT7nkSZcqjeB6eGFLR8qh4ePUcNGllE7L3f4fzxpN9/Ukpz8MPSH0tA+?=
 =?us-ascii?Q?HjOO3rtxXYfkPXeCTScyDtFIVMAYG59SGANlD7p7VX3uexEf2ZK/a7KMeAOO?=
 =?us-ascii?Q?rOgdUEdlXAUjCEpYO0RX/CYbzczVRoQWrU4QJmtWlXdks/MBYAP/tXOoqvJ8?=
 =?us-ascii?Q?UapJNJf6ZNpjw/8/KAUUXiKCEQzbLnfvBJMuHNc0xQ21oFpKMYBRIQdlRLS5?=
 =?us-ascii?Q?N/p7ALdFhQMLDoNOX3GhJIurbOB5iLPqCEndl6gvJt5X2TZUFAFE0ex/5pHe?=
 =?us-ascii?Q?Y+WlqR/As/E5hhlUwsRm8eKMd/CJ9iAt2XLJecmfaHLEI9AWWbQDgdZc/S2F?=
 =?us-ascii?Q?K2aiOXhYW29H1Eo3HBY9dqAy/Sa7Geepdt084ZB1ArK6AF+56Un/TAPPjRdo?=
 =?us-ascii?Q?UaKLxn3WN+FJp3VGo+bqyzCo2z5k5yn8dsptKTysNeP0RCP7d+GGg/IrV275?=
 =?us-ascii?Q?1GHWYn68tVeHgTZLi67GIB0TbiUy/Fh/fMj8Z7iU3HUw21tfA+UD//HyfC4Q?=
 =?us-ascii?Q?itUlYcvCGVbE697QOzerM/BKno+WMLOMFv1LpHqtvXzLozqlri3FSE8Tr4R1?=
 =?us-ascii?Q?9l1uNbODWDOd0GjAOZ0zKUQz/Zw3to7RMx3yEhe8bFXpX1zPBVsB8R7leBUW?=
 =?us-ascii?Q?tlfvleRuXhf9gveXdq5bJxf+3E2GpNEyNN05SUoxGOwP54Yw8gfTlGUzbE4f?=
 =?us-ascii?Q?0LjO+9CHHyTwwvb++d/ctRiU2+8d0q359ohCgnf5cBE+v9HCEbWzeqWJgrnZ?=
 =?us-ascii?Q?23PXRXw54kV5Rf08O/niseriQHWH6LJ1jncG5s1+YEmQGK7wqeJwrsMDObfV?=
 =?us-ascii?Q?aRI2hlqkUkXbnei4wCu/935QetUjh2jPKMn1vPfFgB4GtB/CtMZq9XQo/Vl5?=
 =?us-ascii?Q?lgKUuRdLXImQom+yne2wVIY/wYSOevmH47diQGAL4sEvjvKYHsJAJ9yjR3Oc?=
 =?us-ascii?Q?9146M9ZYMBv3BY2bXYKDdK2j4ctaYE4RhvgsP9HERfdnYBlbTr7MHru72XEP?=
 =?us-ascii?Q?i3uzxls9f/XWP8wMWXvkSkENyX/LojVVufG0qAbbaTHKDY2vsczU3D3buYkY?=
 =?us-ascii?Q?NfUamrINUrmcKZRsLc8MYS3Jgrt6a6rLXaThRPkvegrOjAbflenR7a++m48l?=
 =?us-ascii?Q?DtPwE99afqfUfQQO/vqJFk6jDiyb6dUcsfpeRIE6eFPwHi3NxkM5uXmdUlu+?=
 =?us-ascii?Q?ApwTqeiTC2BCxJMvmzJUHc54quancdRCWPYspnfZcRp2aLzXjt9hZTxJMm2K?=
 =?us-ascii?Q?VRYC7y2r0xIMSzlXsWJNZzBNJ9C+?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-990eb.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 75ef2212-0b78-4e57-8241-08df3a550cc2
X-MS-Exchange-CrossTenant-AuthSource: CY8PR19MB7009.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 09:21:47.4873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR19MB4063

From: Wei Li <liwei391@huawei.com>

The reactor swap inlines the disable-update-re-enable pattern in
monitor_swap_reactors_single(). The nested flag splits one helper into
two behaviors. The container path re-enables every nested monitor,
including the ones the user left off. This abnormal logic seems to be a
temporary strategy from the comments.

Add rv_update_monitor() helper with callback for generic update
processing. A monitor is updated with it quiesced and keeps its enabled
state, including the children of a container.

Signed-off-by: Wei Li <liwei391@huawei.com>
---
 kernel/trace/rv/rv.c          | 49 +++++++++++++++++++++++++++++++++++
 kernel/trace/rv/rv.h          |  2 ++
 kernel/trace/rv/rv_reactors.c | 34 +++++-------------------
 3 files changed, 58 insertions(+), 27 deletions(-)

diff --git a/kernel/trace/rv/rv.c b/kernel/trace/rv/rv.c
index 29f155c6968b..4e689d4590ae 100644
--- a/kernel/trace/rv/rv.c
+++ b/kernel/trace/rv/rv.c
@@ -289,6 +289,19 @@ static int rv_enable_single(struct rv_monitor *mon)
 	return retval;
 }
 
+static int rv_update_single(struct rv_monitor *mon, rvmon_update_fn_t update, void *data)
+{
+	int retval = 0;
+	int enabled;
+
+	enabled = __rv_disable_monitor(mon, true);
+	update(mon, data);
+	if (enabled)
+		retval = rv_enable_single(mon);
+
+	return retval;
+}
+
 static void rv_disable_container(struct rv_monitor *mon)
 {
 	struct rv_monitor *p = mon;
@@ -321,6 +334,22 @@ static int rv_enable_container(struct rv_monitor *mon)
 	return retval;
 }
 
+static int rv_update_container(struct rv_monitor *mon, rvmon_update_fn_t update, void *data)
+{
+	struct rv_monitor *p = mon;
+	int retval = 0;
+
+	list_for_each_entry_continue(p, &rv_monitors_list, list) {
+		if (retval || p->parent != mon)
+			break;
+		retval = rv_update_single(p, update, data);
+	}
+	if (retval)
+		rv_disable_container(mon);
+	update(mon, data);
+	return retval;
+}
+
 /**
  * rv_disable_monitor - disable a given runtime monitor
  * @mon: Pointer to the monitor definition structure.
@@ -355,6 +384,26 @@ int rv_enable_monitor(struct rv_monitor *mon)
 	return retval;
 }
 
+/**
+ * rv_update_monitor - update and reenable a given runtime monitor
+ * @mon: Pointer to the monitor definition structure.
+ * @update: Pointer to the monitor update callback.
+ * @data: Context data passed to the update().
+ *
+ * Returns 0 on success, error otherwise.
+ */
+int rv_update_monitor(struct rv_monitor *mon, rvmon_update_fn_t update, void *data)
+{
+	int retval;
+
+	if (rv_is_container_monitor(mon))
+		retval = rv_update_container(mon, update, data);
+	else
+		retval = rv_update_single(mon, update, data);
+
+	return retval;
+}
+
 /*
  * interface for enabling/disabling a monitor.
  */
diff --git a/kernel/trace/rv/rv.h b/kernel/trace/rv/rv.h
index 2c0f51ff9d5c..d0e89b8a66ac 100644
--- a/kernel/trace/rv/rv.h
+++ b/kernel/trace/rv/rv.h
@@ -26,8 +26,10 @@ extern struct mutex rv_interface_lock;
 extern struct list_head rv_monitors_list;
 
 struct dentry *get_monitors_root(void);
+typedef void (rvmon_update_fn_t)(struct rv_monitor *mon, void *data);
 int rv_disable_monitor(struct rv_monitor *mon);
 int rv_enable_monitor(struct rv_monitor *mon);
+int rv_update_monitor(struct rv_monitor *mon, rvmon_update_fn_t update, void *data);
 bool rv_is_container_monitor(struct rv_monitor *mon);
 bool rv_is_nested_monitor(struct rv_monitor *mon);
 
diff --git a/kernel/trace/rv/rv_reactors.c b/kernel/trace/rv/rv_reactors.c
index ea52f50e6453..06f21bcdd6cf 100644
--- a/kernel/trace/rv/rv_reactors.c
+++ b/kernel/trace/rv/rv_reactors.c
@@ -177,45 +177,25 @@ static const struct seq_operations monitor_reactors_seq_ops = {
 	.show	= monitor_reactor_show
 };
 
-static void monitor_swap_reactors_single(struct rv_monitor *mon,
-					 struct rv_reactor *reactor,
-					 bool nested)
+static void monitor_update_reactor(struct rv_monitor *mon, void *data)
 {
-	bool monitor_enabled;
+	struct rv_reactor *reactor = data;
 
-	/* nothing to do */
-	if (mon->reactor == reactor)
+	if (mon->reactor == data)
 		return;
 
-	monitor_enabled = mon->enabled;
-	if (monitor_enabled)
-		rv_disable_monitor(mon);
-
 	mon->reactor = reactor;
 	mon->react = reactor->react;
-
-	/* enable only once if iterating through a container */
-	if (monitor_enabled && !nested)
-		rv_enable_monitor(mon);
 }
 
 static void monitor_swap_reactors(struct rv_monitor *mon, struct rv_reactor *reactor)
 {
-	struct rv_monitor *p = mon;
-
-	if (rv_is_container_monitor(mon))
-		list_for_each_entry_continue(p, &rv_monitors_list, list) {
-			if (p->parent != mon)
-				break;
-			monitor_swap_reactors_single(p, reactor, true);
-		}
 	/*
-	 * This call enables and disables the monitor if they were active.
-	 * In case of a container, we already disabled all and will enable all.
-	 * All nested monitors are enabled also if they were off, we may refine
-	 * this logic in the future.
+	 * Update the reactor with the monitor quiesced: enabled monitors are
+	 * disabled, updated and re-enabled, disabled ones are only updated.
+	 * Children of a container keep their enabled state.
 	 */
-	monitor_swap_reactors_single(mon, reactor, false);
+	rv_update_monitor(mon, monitor_update_reactor, reactor);
 }
 
 static ssize_t
-- 
2.55.0

