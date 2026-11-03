Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.96.87
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793673908;
	b=nh4bIlOCs4rTNy++IIp8cDYnFW1CGvJDh0Kd0WJm6IfhHGS8rLn1r5vkvET4qW3/xWbA
	 iCOJ9eckfYR1LiG0px5QEuu3qfNe+EILC+iQcS+aoryT+ucHifmJFb7v8R7dDualqSQvW
	 lh2/nucm7BpJ34j9mzWzVcV89kvAtqjbI5TM5qaUg3bq5dVTHMMbvpYU1lmD6pEZdTFtP
	 tS9nL6UrfiqEOlmn0jJLJwQfE4LR/IUFEWGcy/pCMRlMu4SEEVGxVrmpvrgg/thAabr4h
	 i0ap51oSNxvztMswy95AaqSCDvt5qUtTeDnz0Kf9Om+len26XUIb1vpqi0U5Ysh9KfA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793673908;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:Content-Transfer-Encoding:
	 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=ftvaG1o2ZuK9RpRIZjOlT4Siw57MMPBlDTzMlX4Vqlw=;
	b=EehR2cPho+LtJkTud6nT36NqTJMeHA3V/Yjd49tVs2e50VATUnqhTqCnswq2hKrWJEm0
	 txsMnu4Xy7oLPuJQja0J/XGTmvuO9gML4LJDVkHzgKR6zvIRHKofoZwdM/ws7UJP5IMEQ
	 Iwch4FAaHJ+iqveHDlxuLxRkJv/C+estnIabTPB8hWQPLuUB/St2hy+SVvnUJLNQQhkx3
	 u6Uw9m+rYJ0teC3Dp3v4iKrfrncN4KiCNUYFpezVAcfMxQxbHiQlEZ9dBfLo9IPN0cSfI
	 BTEM5O1D2RmYXwLXbFLbdwiPyiq2A3QeNEVSoIdLWX9wwk1Q7GS9SRg5TOzMirHOROA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=atomlin.com;
	spf=pass smtp.mailfrom=atomlin.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.96.87
Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022087.outbound.protection.outlook.com [52.101.96.87])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5042606A32C;
	Tue,  3 Nov 2026 02:45:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5042606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fYl6d00dTDj8YFzJLc0upKLO5BJSUfhB3dd7/ptvI72jjXVWk41K7/KLLjlZ5hC1Bl7MFmqAiY81QQ1ZaIGpJWwDV1eb0fJEMYs0pUbiTBxsqatOYdC0092hrWJF1dkd//sCLEVmEbRevqhtI0a2eSfTTOBAVegH+juSmVjFHnrWclfk1cdC0LC8nMEmzlZYjPpoX13NX2nDJPpkyXTaFbJ1HjVfaMMuWVJVma8mwQtnbl6xBa5zRfGEio0+sTRkiEUqih4fFlK2KC6p8g6dnl2MgZMH6phf1tmQJAzSaa/QLzt4HYQPHWFpiG0ybXZpdbHG0Ei6Pbg7Hr5/qwJEww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=ftvaG1o2ZuK9RpRIZjOlT4Siw57MMPBlDTzMlX4Vqlw=;
 b=tOqQDMjEeT3DC3vR0dMdc3cGQma3ZRPWouMdtGXtx4Q4KTndaxWAmsjUUCxcmmTTPXtRQXhY5Re5nhU4G26VyzU1y+CNliUCtY9f+Gx7ZfhiyhrInowGvRbAeN9U5MJwWIa5abtiO1lzNw6PHGmFc+iw3GxYzovFNXp3yQ5Mj+Kj2+qwn+3QnNeT8XmIh5RUvZD/QMjLlFH6gWkuBr7TzxH757TmKss7//tH4LO+uEhYYOW+iRIWwnyEfWHzNESaRpc5FpWekmFM4AtKznxHSGsDvzaBbEEKT2Y/6Qqnqj2MnJW/QTxtY6Rh/EaeVI0tiF/9vqmqNN3RpoWeI08s4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:163::8)
 by LOEP123MB620368.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:501::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 02:45:04 +0000
Received: from LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f71f:a9f:c4de:687a]) by LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f71f:a9f:c4de:687a%5]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 02:45:04 +0000
From: Aaron Tomlin <atomlin@atomlin.com>
To: pmladek@suse.com,
	john.ogness@linutronix.de,
	rostedt@goodmis.org,
	senozhatsky@chromium.org,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	kprateek.nayak@amd.com,
	akpm@linux-foundation.org,
	baoquan.he@linux.dev,
	rppt@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	ruirui.yang@linux.dev,
	david@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	kees@kernel.org,
	anna-maria@linutronix.de,
	frederic@kernel.org,
	tglx@kernel.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	brendan.jackman@linux.dev,
	hannes@cmpxchg.org,
	ziy@nvidia.com,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org
Cc: linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: [RFC PATCH v2 2/5] mm/show_mem: Avoid blocking on zone->lock during Oops or panic
Date: Mon,  2 Nov 2026 21:44:50 -0500
Message-ID: <20261103024453.922373-3-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261103024453.922373-1-atomlin@atomlin.com>
References: <20261103024453.922373-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0431.namprd03.prod.outlook.com
 (2603:10b6:408:113::16) To LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:163::8)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P123MB4190:EE_|LOEP123MB620368:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cca2195-e6c3-40e0-89b2-08df395476d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|23010399003|1800799024|6133799003|10067099003|22082099003|261102123227099003|18002099003|921020|56012099006|5023799004|261021123027099003|261022075727099003|261021135927099003|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	f/aurlGl/qw7tE+xWQnBOn7WxYABpXS+wKYuZunS2LcjrAR/9FKvgK3gRZYmRMo/inkdKscM3qmrOowkQGl9Hu8M3sSowr4dfAssu/ZUMyPoN1lE2ZRicsakFkrXDVNgxNS+RSspBG2O4Bxblb9WnaQG8DxF1p7Kg/NXv40FmY6kivqLO8syiCw6DT0Iu41hHlvLCJnPfNeTE7roijRdM2t7qFm50PY2WBVanhobZMnK6vGY9UY24g55HtUoaxUlUWzHvSLE7v+ovQFhji5i2pd2KqvMIgRNDN2xl+MHbmxjnAxnKe1JhBrT5XJfxFc9YQClBtQp/i5pxPA2myZJJtQylXkCyUu0lTGFX596soV3mMq4yKHb7AHU/xMrcvckjgEpKii7W61tcI1QkSB/vXLD8sm86NKfGBf5ENPcO61hn7g8S66frP7JslngJGmsL09mKp6hhfnIR1ORumF/aqEz5FUTq5/4+V/6mHuuzB6DK1Dd3gYwakX2ThcOjoofDoCOaj2Hb/leO0ecvhaAKbRRB7OpdSm7HOP6t1jUx5WDtN8sxSN1xRUWgC7s08H6W8wNJbcHOuj0lxyKe7+4txv9I9b8T3uyUibFT+z/u1K3fopHSX82NI8HkT3NfNq57mRO2OYzsmYC+H6lpEmY7T+teDm0d9hO4edq4XKl6LG0anlpQycFP1/6eRNWeY+uRL6LeCw/kMg5bFYqLvLoLA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(23010399003)(1800799024)(6133799003)(10067099003)(22082099003)(261102123227099003)(18002099003)(921020)(56012099006)(5023799004)(261021123027099003)(261022075727099003)(261021135927099003)(261021121427099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uWvjaBIFx1c6QgMHhhb8vgBqlBEQQvlFE9i4CsRH8beDYraLCFfuJnI75jeu?=
 =?us-ascii?Q?iE/aeHb55dRZaogYzLVCVoTEUcpNvoFSxWj6yDDJCPU0YTJVtDh9KQkR2XwP?=
 =?us-ascii?Q?s9tHTBx99VWhj2023lV7dFcFSNwLWbUyPQbmXAmUWSw+IbY4BlN7eXmQ1IFM?=
 =?us-ascii?Q?hcmWqTdrL560kkZZ+4AF/5CaSGoWHVxBirlSFV4LyaTwxyWbEbEGw0TC4dnr?=
 =?us-ascii?Q?ML6eLoA/7P1Chb6lS76u4vazGpoXG8Q1e7mG67Nk35jI9TmFDakHJni+G6Zl?=
 =?us-ascii?Q?NPcqv6+7XjBm4zVtBEk+cE7rquHrqitOUBhirDup+TSfxDq6k0kvN2BOjeOx?=
 =?us-ascii?Q?svs+tlytSgrujw3WtrUQADQ6HNOCtbkaBM248HVWlKqyNJ32oHprAEUt/yFc?=
 =?us-ascii?Q?sjRDLYmFaALVqcvwvI2L3GsRa5OXQIegIMX7n3ft+bQi8bgRiHuBybLIyudy?=
 =?us-ascii?Q?jskItb+uxc3oH6dq3yQhzmN4tns1jjQBw4QgR2W4+aTp56DdP8RKKhUyD4rP?=
 =?us-ascii?Q?zNxLfXhl2FomTXwdqaFyGnblWKgPBngxGCabz4s3fsLtmndpGXrE3U/9WycW?=
 =?us-ascii?Q?aRd2Sb7iYNoh+yx4M4fnFGk06WUo3gywrcuV3Wpam8/+5QEmE+ZwB0FH+8qS?=
 =?us-ascii?Q?iGZNW4njH5d8WvzOQpIud9So/HlzYymTjXsmcqAr6lJ2OYZHGIJYsjj8F+vt?=
 =?us-ascii?Q?pFqJo+hh8mY0Ju5j2w+ER0Wrykw6qMDpJP/C/MfOYFcLf+/7Sxa1G6uhc6l+?=
 =?us-ascii?Q?qBNHBZ2yrS0tCHNsx3YkTTQTVtE9yUC/aaB5InKRKT69aL4DtPUm/yN5NAtO?=
 =?us-ascii?Q?pIsS5XnoeksPxkqZ52DoZwvGocLDHieUjHojONqjEWiDzYth1cNR92itb52F?=
 =?us-ascii?Q?me639G4PDdtV7479qtVgiMOvPrf/UQ2LHEDk91aHTcVvYla3Kb8XHYni7jsE?=
 =?us-ascii?Q?Nt9NnLwt8Y+mfJejOATl8WdiiAF2PhAXez0qyRJwgIOd2q2ZkNuOsv9debwJ?=
 =?us-ascii?Q?vzpf0xASbD2Q3kchyUkQvVDlYReB2v0eskgjbcUgPLYNg03yIQX/d+1F56AM?=
 =?us-ascii?Q?E5cVzYQKzFUUmDFjuL9Ndj2fOwBmgJOa+amAPiwwk4muSnzY7x/7EDxK+RJ9?=
 =?us-ascii?Q?8cH4rfijNfNT9zmQYdcnficfECOB3/24/Ny+CGR7Xy8ib7YPzUwnysXzRga4?=
 =?us-ascii?Q?hBIqNBMsm8A4nR40qja0xgFjse/s7Pz2TOBcgLGzJk5FaHGrD/+755QVtVo6?=
 =?us-ascii?Q?ktYshGcJSG2VCxbh24C/ooUQquYaYXzTxuWEovs2MyEgpExVln9Uu9zaTnjt?=
 =?us-ascii?Q?Zt2a2dxM3u67o4VaZlZi2HZRkhV+8cihN6HgLf0lHEprX68YL8avS0DRyoX9?=
 =?us-ascii?Q?ofr1udujjddsYBv2vR1vdFKZ7PX+vwxy0/8gjJbYbjBu2wvEz9sUBwFfj6on?=
 =?us-ascii?Q?pTORwXoEHAUMC89yrQYGtu5iguwHuAuUTEUjimS6M4ttSRBJrsqcQRBk3veB?=
 =?us-ascii?Q?SvJNam1nlsfH/1/C7JIqIdtJBW5PiNbNHctZ3/1I9RxMpk/Unh7s+NsZbtUT?=
 =?us-ascii?Q?i/PVKNZfFMHyj23m6Ae+SaX5HJRZB+YNghMgw5HhCWlQGZQBhtT8eNcqc6mo?=
 =?us-ascii?Q?SDikW4opLpC88s8OxcAKa8MtJRX+YEqyHsAgI+WpO+oR6fMslYJ99NelDtDt?=
 =?us-ascii?Q?L/pQAwG8BQfdlLc3pu1/xwkcnCBw7QRQq21hth6/LVzaaBfdn0pxiWQiCy9e?=
 =?us-ascii?Q?5th0dFpYVA=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cca2195-e6c3-40e0-89b2-08df395476d1
X-MS-Exchange-CrossTenant-AuthSource: LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 02:45:04.5013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NJLbb7mT7AKig0wuLEe2hPsl8cIphaNdtf617Gq1aiD1mkZMPDRndOJSdxZxGN2V8auuSBui1BeA2MZWV9R9ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOEP123MB620368

When show_free_areas() iterates over populated memory zones, it
unconditionally acquires zone->lock via spin_lock_irqsave(). If
show_mem() is invoked from an Oops or panic context while the crashing
CPU or a wedged remote CPU already holds zone->lock, or from an NMI or
hardirq context under CONFIG_PREEMPT_RT where spinlock_t is a sleeping
rt_mutex, acquiring zone->lock can self-deadlock or fault before
post-mortem recovery (such as kdump) can proceed.

Check can_spin_trylock() and use spin_trylock_irqsave() when
!can_spin_trylock(), in_nmi(), oops_in_progress, or panic_in_progress()
is active, and emit the zone header after releasing zone->lock,
logging a contention notice and skipping the locked zone rather than
spinning indefinitely.

Fixes: d999bd9392de ("panic: add options to print system info when panic happens")
Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 mm/show_mem.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/mm/show_mem.c b/mm/show_mem.c
index b938cbcd774a..77098077523a 100644
--- a/mm/show_mem.c
+++ b/mm/show_mem.c
@@ -367,10 +367,17 @@ static void show_free_areas(unsigned int filter, const nodemask_t *nodemask,
 			continue;
 		if (show_mem_node_skip(filter, zone_to_nid(zone), nodemask))
 			continue;
-		show_node(zone);
-		printk(KERN_CONT "%s: ", zone->name);
 
-		spin_lock_irqsave(&zone->lock, flags);
+		if (!can_spin_trylock() || in_nmi() ||
+		    oops_in_progress || panic_in_progress()) {
+			if (!can_spin_trylock() ||
+			    !spin_trylock_irqsave(&zone->lock, flags)) {
+				pr_warn("zone %s lock contended\n", zone->name);
+				continue;
+			}
+		} else {
+			spin_lock_irqsave(&zone->lock, flags);
+		}
 		for (order = 0; order < NR_PAGE_ORDERS; order++) {
 			struct free_area *area = &zone->free_area[order];
 			int type;
@@ -385,6 +392,8 @@ static void show_free_areas(unsigned int filter, const nodemask_t *nodemask,
 			}
 		}
 		spin_unlock_irqrestore(&zone->lock, flags);
+		show_node(zone);
+		printk(KERN_CONT "%s: ", zone->name);
 		for (order = 0; order < NR_PAGE_ORDERS; order++) {
 			printk(KERN_CONT "%lu*%lukB ",
 			       nr[order], K(1UL) << order);
-- 
2.55.0

