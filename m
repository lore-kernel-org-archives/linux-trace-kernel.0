Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.196.122
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793673912;
	b=y4fAsQNLW+GXyPVdj2up+7FmRdTu1thGxceXgi09GBa+zM/ZoctL7Z10QjRLFn11eaNx
	 AVxXmuHg6g6Fhm16GCfOEqrqCQPYKJ6N97bbBJxzuLhcrelOSWHhtiQNVuLhP464ui36U
	 skiXGogZM2X+6lcIk4kJrvOiKecVdYYY95CWexUKR/EpgA4likPJEbj7ke+QqiLUr+kjJ
	 7Wp5lPNaSkEjOJEvLb1bmuyVGEL0piS29FwhkZjHHGjZDxsNYXjZUFlyCA7Rq/AUI+lhT
	 vTAWuzuCE2Mld5+Ilvqzh/CKWHhDmkZozOeFyzjmRh8neA3rnWZqZPWVr6Q02sAaoXQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793673912;
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
	bh=R5tGfW1ky4si4RwX40JQdC4wv91k5kgX6hr5LMogCSU=;
	b=H9TFZG2QS/v50NSqd+m6ZlDShjFRFqCkW1KfT17uuoKhIeuSunWsLIzIwEAtkDC3QYQd
	 F6OwOLoxvGDbSdoa7EcceiI43eDqD8jBuGxDWYunpqb+nEtDH2zNOyhJcqkYekBgya5kK
	 Y7Xrb1Kl0UqvXqBtcykWBAkyEdsZDD9wSZteJMYVo8fgKmzL+ME5nLq7e0/aD7HCG7F+z
	 xhbo2jqw3J/rutAr3xXVJzFldSvgoQJhgAkOIq7xRul3YMGwfsvf4JUVeOfBze9EAG7yG
	 lBmZQgJDF+OkJHFGrU5xugBwvU+yrotwCyV7h+h1ofeKdMnlY65YeUWQ7k4xT3x+e0Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=atomlin.com;
	spf=pass smtp.mailfrom=atomlin.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.196.122
Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020122.outbound.protection.outlook.com [52.101.196.122])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88F0606A331;
	Tue,  3 Nov 2026 02:45:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A88F0606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d15kmlcvcRgOsP03reMpndP2Wy/kGvXihhdmO+vWbROgKt/9x+AlaIJWqxN4iGVazHt4iijyd3tNdSVKaNYm/TJrKUiJkiC5k3nCNqlamFCUHdmNT6UiB/Qj6cZAodwGmscXuhjC7egJ75mO3ysTWgnuOCDdeYELRIekTw46i1VE98YFFFY/Y8PG5CorFmCq/k1LvddxcMF7Ow+ZcIrrrOVejzJLyqOOyf306Qd37gmswGBSOtg6UfI2LYnUoe/qaPVx0hZbnEt+pELMV4h0bK7j47d9smZy+vtBlyCXoGjsAQO8dvqQ5WR0CO4N7VvP7tFaf0eSGF5aqIsCzy3U5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=R5tGfW1ky4si4RwX40JQdC4wv91k5kgX6hr5LMogCSU=;
 b=rXt7ZxPD+elpOR84lC9RJEJQrH29WoHwcKgrP8WbiehHKNNLVMy9+46KKX5AyaSM6auRXlYYAcpc6WgcoCn7cydDF6t4SNcF/k9YD3Zfry/imov5XY6+0M3rlFv9JzdEP4Ni+esndzFORqD4nV3QESumQWFGYFnXz5kOImoPtWmKjvABp1yp550y7+E7cX03AWUUNNrti0OTb6HmsDpyU0b4CRA8Bm2LcXGR3kCbIsNe6NysSnjvH+6Tc3ldav/sSlWlGzC7prTLrGt1JfDxdXRGQOyxuXZQi9U9GZYQyUblBldrgYhv1ie/ibOlyYewf0EIn17u4J5NU5VB5vwP2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:163::8)
 by LOFP123MB913335.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:702::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 02:45:08 +0000
Received: from LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f71f:a9f:c4de:687a]) by LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f71f:a9f:c4de:687a%5]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 02:45:08 +0000
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
Subject: [RFC PATCH v2 3/5] timers: Avoid blocking on hrtimer_cpu_base lock during Oops or panic
Date: Mon,  2 Nov 2026 21:44:51 -0500
Message-ID: <20261103024453.922373-4-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261103024453.922373-1-atomlin@atomlin.com>
References: <20261103024453.922373-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR04CA0098.namprd04.prod.outlook.com
 (2603:10b6:408:ec::13) To LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: LO2P123MB4190:EE_|LOFP123MB913335:EE_
X-MS-Office365-Filtering-Correlation-Id: bd5c6619-321d-48db-364b-08df39547908
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|23010399003|376014|1800799024|6133799003|10067099003|22082099003|261102123227099003|18002099003|921020|56012099006|5023799004|261021121427099003|261021123027099003|261022075727099003|261026121527099003|261009223027099003|261021135927099003;
X-Microsoft-Antispam-Message-Info:
	TLi9/smI4SWrrwh5XdQXjxosQKtf2BPmxvj6iChYdWts7cvwu8GZCvQGiV4Aseoa/V4sFdlIrur7eIqnWN7haZroYAqqZBGjAetZBoM6AhHRxKXv4sdRinhrsPM8aBunE6zTWGD3VSmMPUBIcUh1qDA9HmRiYAoONWsRHRV2OcvOQG1w086WOXkMGzA4CWpeJstTaZd1hKIIQ29V1qno+AtsGpUdBfwUA9AXfoNbJ+DvJLjEoHSHQg/rKstbJ1hH/tAMjY8ISC3ja3NtqxW4n972egwkCPLI8DntFFMqPWFySBwb+aPr7wIZcOfAXWaIY6kzjQH25shAFhKYq1CY+QoyubzL4acqHrI2ajzViKw2oirjWK2ArnuFY+QlF44hBNLEYiaEb3w96Ch2/5xvva06oguaD4SwDjapFd4CZlgCxt+hVfa99z4rtqdZp/ybR/lheIOqSSSD4iDGqpp85Ar0lfMAuMb33QMFH8FpgXP2WSf1OJPzCZSWvfcyxvJiCK3rGOdaqDCMKpwkkCtSUmBiGgScH9Eg0xZyDkectNpmmROqDffxdIDq/wFXph2+acX29Pumkbw6pQv4trdMngkNueRZK/t0SL1/bfDyeyFDUwlycvWs9jdtaNgvwTK3byG5aLAePuLR5GxuRsXMG8wEjhiJ6luxgJjl+qByHjKs+UX7G2aY2xwCwoVmGCCg3nlq8I78eEmJgmttIFHd4g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(23010399003)(376014)(1800799024)(6133799003)(10067099003)(22082099003)(261102123227099003)(18002099003)(921020)(56012099006)(5023799004)(261021121427099003)(261021123027099003)(261022075727099003)(261026121527099003)(261009223027099003)(261021135927099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NL/cG7SZrq4v4TYqepzd5U4QMFzwBvSyoVXffV1I0G9hwYMOMqwPUIJAzhP/?=
 =?us-ascii?Q?q6pssBujzs5Vm0Rvuryta3LrbduzZ3XJEwys+X5KSQ1ABM0GV9DloOFDA7ip?=
 =?us-ascii?Q?Pb2YqQHHzjr41GHAS86Nzqmb+r2662qTQpUZDEulLok+A+/Cj0VecWN5Jmos?=
 =?us-ascii?Q?GwCMuhl9TcSor2TQa4wm4Qgo42m/wVDnc2L11CU1U0awfpV98UBbZiw1PL4G?=
 =?us-ascii?Q?Npfhx61fefgBgDf9K7geeoUUPPFYuZY8m8sU55gIU1UUScgUa572W/NPxA/u?=
 =?us-ascii?Q?oERFZDW9irOEXO7FEwhIN3OCaEfNTEJSq1CPbd7Yom0/mo66bA14tWGreURd?=
 =?us-ascii?Q?U259c3X7UrxfEe6VYJUeWTtP89ccX0E8MCQVT6zeaKceZ0nMEadCZt6Zgxow?=
 =?us-ascii?Q?jYv4XncdzRfXPofhsc/1Bq143l9OD83LpCHAqvfD62at51EZhwdzIGOABvi7?=
 =?us-ascii?Q?WJmKuvW61drQhDubmQo4OiQKfEp4/oVFYMBTekfGw1bSCiHYfweSpbBShIrH?=
 =?us-ascii?Q?fpzBSYSWPfdshmH/RUNHlqq8+tj35VvtBa4TNbvIVtjAe6jbjxiuqTCb/IJB?=
 =?us-ascii?Q?y/5ZXbDW9FyI5cjeVO3+5heeCckouwn9w2rLJGhSOcVae0AUOt4wHTYVPRK1?=
 =?us-ascii?Q?9Y3MFTfe9Pw5+0pKPqHmPd1M2FYayjIq8WbuMREEqMH+8e2aiBnLPR5LrWKb?=
 =?us-ascii?Q?ycVqvNYlOVINN5uassvokcwIae91YpfwjeVDtjWa0zMuoQ9QHmncZl380XjY?=
 =?us-ascii?Q?K4ypSK76jBTrPG8jGUNl0uCPGtMTzqbsOHiE7MMQ2qMPeHI5LAH5oytYMijz?=
 =?us-ascii?Q?fgUiKsRNHkpkR5iWKmKMEVyrP+pBXaOasmoU/crClXm8zPMHqC1wNehhYjEE?=
 =?us-ascii?Q?fCc7XlDq51hUGcNGYjzAPAPgGiJcjCt1Pdpf9RXDHmVKlJcKIGOtAUsZlhyM?=
 =?us-ascii?Q?jQlXGlfZj8kdnxzHFoW/nWONq3afGp6Hs2MRagr0U+AGzYjAqw8aoihdrNom?=
 =?us-ascii?Q?7BWgiUTN7XJmlyWi4YTBRR0zGBJgsK+1ZxVTIcD9h8U37+sLEjut51ZkaHnT?=
 =?us-ascii?Q?QW8dyf5h4tF12tPt4UNgh+SJxrLiw6Q1olBDd3Z/jo6p34f5A9rdzlJqUomK?=
 =?us-ascii?Q?8F3Cy/Hl8AHZgJ5+pw1Qp6/h+AUkyTCiBRlnFeUyU6QdKjeQfB+9ut+Wim+7?=
 =?us-ascii?Q?oVFfzYajXh6IYiHLO8ECRT9wKwgBzcj3+BBqXKqrnVZaNDh9vUt1pHIIWFyd?=
 =?us-ascii?Q?nk91oYNSkC4Xg973jg0MW/nXp52GdR8wwe37cIv70XL+ulkoV0T4fXufj7Eq?=
 =?us-ascii?Q?Me5o78sfzw63GNOMR9/L8U+iieULM3vMzBcQDAjdC1lUfEflBWWfPRY+JK2d?=
 =?us-ascii?Q?Xcyo4Ll+Hl4R2hvxDHYmGCJwPpmlxlDfmoQlOW/lv6NCuZEkUj6tgzx/0VQj?=
 =?us-ascii?Q?N20FSNWpSRb0ofxb+sQYor8Ri2pssAzFAmQ9pjnecQcQAzYOjWy5a70TDRht?=
 =?us-ascii?Q?a3B2cbJVedjtmAy7lieWoU5FLak533ut8GSOxzjEb48TA+/Q15jZaqcQWHRe?=
 =?us-ascii?Q?PgaRnT40OUUT2uPToRWY6pJt8dn+6XxCyH9AbYpgbWLYRoR0dOgY3UrFmIzW?=
 =?us-ascii?Q?5+prCtyXdn0QNPDSTgCiQOHKYxa1WYjDNEntdhRQ6eGv83jLxkG8SuRx5HxD?=
 =?us-ascii?Q?4n2tRVmWvnZ2QKb9LnM7EhzmKtgbPYI/Mni9m++K53MulHB5OGhpoTod81u7?=
 =?us-ascii?Q?wkQMTlUATw=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd5c6619-321d-48db-364b-08df39547908
X-MS-Exchange-CrossTenant-AuthSource: LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 02:45:08.1982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kcy4pIlcXkxaEe30kis2y9Pko5il4sb47WD+YFhtH41EWz4GBvCC7cjUPgKI0pJj4OkoLsMjfc6hntItWv2IqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOFP123MB913335

When sysrq_timer_list_show() dumps active high-resolution timers across
all online CPUs, it calls ktime_get() (which spins on tk_core.seq) and
print_active_timers() unconditionally acquires each CPU's
base->cpu_base->lock via raw_spin_lock_irqsave(). If invoked from an
Oops, NMI, or panic context while the crashing CPU or a wedged remote
CPU is inside a timekeeping write section or already holds
base->cpu_base->lock, sysrq_timer_list_show() will spin indefinitely
and prevent panic recovery or kexec from completing.

Use the NMI-safe ktime_get_mono_fast_ns() helper in
sysrq_timer_list_show() and raw_spin_trylock_irqsave() in
print_active_timers() when in_nmi(), oops_in_progress, or
panic_in_progress() is active, noting any contended lock and returning cleanly instead of
deadlocking.

Fixes: d999bd9392de ("panic: add options to print system info when panic happens")
Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 kernel/time/timer_list.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/kernel/time/timer_list.c b/kernel/time/timer_list.c
index 0406bf4488e9..4973650c4ae5 100644
--- a/kernel/time/timer_list.c
+++ b/kernel/time/timer_list.c
@@ -68,7 +68,15 @@ static void print_active_timers(struct seq_file *m, struct hrtimer_clock_base *b
 
 	touch_nmi_watchdog();
 
-	raw_spin_lock_irqsave(&base->cpu_base->lock, flags);
+	if (in_nmi() || oops_in_progress || panic_in_progress()) {
+		if ((!IS_ENABLED(CONFIG_SMP) && in_nmi()) ||
+		    !raw_spin_trylock_irqsave(&base->cpu_base->lock, flags)) {
+			SEQ_printf(m, "  [cpu_base lock contended]\n");
+			return;
+		}
+	} else {
+		raw_spin_lock_irqsave(&base->cpu_base->lock, flags);
+	}
 
 	curr = timerqueue_linked_first(&base->active);
 	/*
@@ -262,7 +270,8 @@ static inline void timer_list_header(struct seq_file *m, ktime_t now)
 
 void sysrq_timer_list_show(void)
 {
-	ktime_t now = ktime_get();
+	ktime_t now = (in_nmi() || oops_in_progress || panic_in_progress()) ?
+		      ns_to_ktime(ktime_get_mono_fast_ns()) : ktime_get();
 	int cpu;
 
 	timer_list_header(NULL, now);
-- 
2.55.0

