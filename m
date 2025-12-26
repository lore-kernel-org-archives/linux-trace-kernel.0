Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021142.outbound.protection.outlook.com [52.101.95.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E15258EE1;
	Fri, 26 Dec 2025 16:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.142
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766765255; cv=fail; b=EG8V7UHarYXAJR6LL4mqUpTKgkN67clg20/Qsnj1m/4klSmhoxYSZtiDK1eX3w6KtdzvnHotvh4/2SjAlsvCs+am9aSxqz0Y+6A6/zL8OCOKcXCnubhHvLpIGWTxKxhGUZgTEFPyXAei8FsSHeowp5GNzWpH4ZaX1Aj42YJFIxU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766765255; c=relaxed/simple;
	bh=Or6pskPw0GRv/+0UuZ4g/ktqMhEgyp11J/CLzX1mtus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=upVHfmUdtvozaa7ApqKqej8hUDYFml/cuPj9dadJM2F2/pUyV+DzbSaXacOpbqA/KFrg9/b5XUn+x11wbFDSJXrjAIeILGueLwDtN6NUeP03UTBAMIG9G8yhjxxicBwZaMZ0kQP9CArnlNE4zJNs6KNtgtRhQ4MPA8Az49blhdU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.95.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A2Gqzn4z8MHflMmByJ9yE2QKO2/oQ554dxbs96vg8cmQ0/YTA1gtATvUzsD8QPaeYFJRr51GwLpJJQ1EhCTSYqDzZzABwts/UQ5F9A3lM6hD04SFv7zSalqoUEtbPSu0/8EHPvzH8a/7w1ssp3bJEifWMxp4zrLB4MwhpBuR47BBxWw8OXPXdCEMF9sTFPP6ghZCov82q+ItCKyMx4d79FRsAfuf+NecVkdF4NNXuzYAJWjxG+/+vOvjCDraXZ4ubcAbp+0CEKnGTQVGfKZ/+yqIAZpfokUB1hb6PZE/tNsmd6czadmkk3T0cIUJoxKAqhOWTMj2YqY7bD8Y22Iwlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pm6b+lURNwmDwYmMKtzgMED1hb4gl/ENKjxAOPhfLgM=;
 b=IRifsvh+QRunylThciQ7q2zshQPASSK4PL1yiVfBGYXc8FQ4rLOCP5FS1ZufHt3PSWp5xIvmyYYjb3Zart2DO3QBuRzdpa/m4RoxhjZOJ7u9qU6fIbGAFEb4dOTgVJw76fc/ukNKL3tR2/SPuP93oEcuGIbvK/XxyxMb0DJSJGabypn+YQgEHC18QixFOizNkN674oV3FTcJvKhh4ow2dsRtJ4BD4E9SLnTFsVy42REOy94vZQQh7VB6/diT8Q0a6epHIAuTfbuinY364oMKCGGxdXchGMZoPilB9wCargDVQu5IRBcY81OHJcivgVFTTvFuWBUTuhvvW3KMY63oRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LO6P123MB7410.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:346::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.11; Fri, 26 Dec
 2025 16:07:32 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%5]) with mapi id 15.20.9456.008; Fri, 26 Dec 2025
 16:07:32 +0000
From: Aaron Tomlin <atomlin@atomlin.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com,
	corbet@lwn.net
Cc: sean@ashe.io,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [v3 PATCH 1/1] tracing: Add bitmask-list option for human-readable bitmask display
Date: Fri, 26 Dec 2025 11:07:24 -0500
Message-ID: <20251226160724.2246493-2-atomlin@atomlin.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251226160724.2246493-1-atomlin@atomlin.com>
References: <20251226160724.2246493-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR04CA0209.namprd04.prod.outlook.com
 (2603:10b6:408:e9::34) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LO6P123MB7410:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c593ceb-a5a1-4852-d94c-08de4498e02b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7142099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6YTXFjg/sXEMwz9a5ercuyFW4bu6iItTaG93rQzZPcOWHSre2Mo9gm+A/Qgb?=
 =?us-ascii?Q?DsGW05HVcafjo+uETGDbmrinEoDSy0P/AD3YSuf4im1t1CXcYkeuUcJN0mqR?=
 =?us-ascii?Q?T8JY+D5XVnmnwQBZhvDVSGd8HAad/rq6NWpCNmuMCVa4D8UlzinuL4s2Yxqb?=
 =?us-ascii?Q?d/DRFhRgUTuM+GeUDhaIjbTQCHWHrQxxHznyBx01Z/o1hxRK4R8fLbbKnGBv?=
 =?us-ascii?Q?HoBJmDcvzmRKI/wvQX3qt2nGHWJNyhI8xOsOwriPDWp8y2lvqwR5VaKaRH3R?=
 =?us-ascii?Q?p8K8tHMSxoqkEAYGnaLY9DQhNmSIIo6JLlKH8O/c7jmnB7fnmk2bgQno04IQ?=
 =?us-ascii?Q?Z5edS5dunMfn/RiaZZQErg1Vx3r1uckJVTcAp/3zrma6hsO2/gIiu9EZi8ib?=
 =?us-ascii?Q?WhmCA51NerhGk79O2N8RL6t6eXRyAmEXNqZaYXS+JctAjUckA0SJX8AmpKiD?=
 =?us-ascii?Q?gv0i6a8C0wq56zB/kQ6eGSWuvlxuyhkfId5+RfH04pFNzU4evj/Xv1Emvx4D?=
 =?us-ascii?Q?d4Gl6Pud7JBYLmQa+mfLsRgB3xEGiS83gNN2wgw8gfYP2zpE7Xognodi7NHV?=
 =?us-ascii?Q?ow9zgdtQLuSXZj+gJY/fAtQTVLnknpVG6iyv35gnv/RHHDUF99yzEQjH8S39?=
 =?us-ascii?Q?xGkNHnoAO37V/SSr4KjNcLsiaCe6c9SkVTJiOxL6BNpCy1KdoRWyOjou1qXq?=
 =?us-ascii?Q?tJQwMJniiGoKzLMEaHPa/buEqNf6AOnv6BOe2lwO7QOjAfwo0Ge+p90etx+m?=
 =?us-ascii?Q?Pi/B/3fv0wsqCHWJcjrCCAqgAxAviVeGu8IQwVlPIQk2gDvU/KGzklCoifjl?=
 =?us-ascii?Q?YxipuyYaOgNEwXZAo34yDR5NAvC+fcdrYGnt1e3M4prDzYaFKKjelD7jOHKc?=
 =?us-ascii?Q?X+hOogLBXMelt20TDIP8XxSRWTmyk93xoJYO/cFRfXcpgEdGfheczk/+7c2K?=
 =?us-ascii?Q?E/rpKhk4VHrqmq3tucqpaZkXf/uuMn3UTsKBGQoQlaMGKU+5Luafb/2Fa2Dr?=
 =?us-ascii?Q?fPx0Kl9KQL2dRUQPr9M5CSsNsVzzU/paNSdwcMQOGqU+GW6TMP2kcASSjRK1?=
 =?us-ascii?Q?4/04QjnPUBFmMsAT6ahWXX+wn3/yg5lYapyjO5MbHWEzhiRVNTgsxYqmmS0m?=
 =?us-ascii?Q?8hA1HTE/exbxT1NRIiMhYc/FQsPFFicHqPZgGhgoKKs3KINNKzKfNf1sBskY?=
 =?us-ascii?Q?dZQdAyCdBM76deHvcgX5zE5W3bIhof82zsc1KY7yKFta7A0P7jTbsok8l5Jz?=
 =?us-ascii?Q?U7FwMbrNU/zghg5wm8xTY25wrNrWxSQ/AFbh5TSiClWZy64AqgNVYtwmFLXh?=
 =?us-ascii?Q?eX1Fjfe3TSss/A90Lxhi+CbgVmHBodXuyCINeiLhUrl/hCDKkJinSDK3HkOP?=
 =?us-ascii?Q?075IGtbqGHov6BNtH2IttY7XAFC7aU1C8Lb7GJa61hUm1Pr7Bd8Q97jBnxi7?=
 =?us-ascii?Q?BHyJ+rPbHXJCOsM5K4EiJcHpPhHzJOKy?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7142099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CHScWDlXs07cnrDHT0f6BWHKNGhffyyYxQ4r2d3/KATXMRlrS4JmsetfiBLI?=
 =?us-ascii?Q?shD9C9ATIZzHDeVJYDyWkNQywMXTkrO81BTPikc5kmrX/TfPjEu5cSFPnkE4?=
 =?us-ascii?Q?eXMRpBXUD2nCdR4ZkSGhVKNjB7BQ/OSXZTBl5e3IOfOXaywJA2OjNCrNNX1N?=
 =?us-ascii?Q?eujhDmN+DfxNH8EpKenrpUrf0/0MLPWmaW6JRXa5C5pGhmlYU5JugB21FUWV?=
 =?us-ascii?Q?TFkyX/ye6fYIYU/16Xp1Racp2GE/NDkg9QqhU9zyifAyUVr7FgzclAVc1vyO?=
 =?us-ascii?Q?KkvlQHWWNSUAwgBth5M/pXgTdExAIdbJQar1ZZgMbJGp0lkFHmSTOgknt5UP?=
 =?us-ascii?Q?8ex7VdAh9nlvAFd2iOWkaFmlpJn2qcmYy5p2F8brcHXglsQqk5FPq94PlZKs?=
 =?us-ascii?Q?6FpsYUiWS1CgYMZtE8lCCxHEZWKP8BAa1juOpi/twbzUT4wXTGoSjukoObHP?=
 =?us-ascii?Q?0cmO2vRplK+RvwA92uFImqPOCbeAkbklD3c/0jACDlnCFedjecxiSCOoCIfw?=
 =?us-ascii?Q?r8Na/XgF9WFXTpCmeCikzu6OQjK64vRl9K27+BFEbWvyjSIUAUK9Q2GMABcJ?=
 =?us-ascii?Q?MFD+BX6Dh7y6k0Pea/m1tS1rPveQZ56fnhtkG0PLf/AHRMtb9UpKfFGKUaRi?=
 =?us-ascii?Q?kRapN5TNPhtZeL64LejhH+LXBxuqhL5i1HcdWur5qMmVGxhjRo36sv5iqLbl?=
 =?us-ascii?Q?s5Vifn1aDjk7g7DzML1bHzQfNBWC7RnFxGAw9XGVZ0/K7NV9JRbTgTeDFnzd?=
 =?us-ascii?Q?Zwu0ureSlF0nqWejTFoIabdQb6Z8PHnxYhrLO2DjePC7URic3t5TOlBAE+jW?=
 =?us-ascii?Q?usRo9/9HJrQ9x/wiADha9lW+URYUcg7x5XCB5VsbBl9mkWY0S8XT1y0A4fD0?=
 =?us-ascii?Q?Y+ZWx3AXkitoUzS6Ur9+b0yXmfcciezTsmzKgSUOB9v0elY5MeWKl9hSCqCA?=
 =?us-ascii?Q?DvuJP13tuiNa7VkX8zkSu489XK9MHNLBZ7muRd63K+xCZZmb6cUhp6Mi4fgK?=
 =?us-ascii?Q?MerjN21y4fmD8WUm5YwqB263F1SDrLW2a22Vwo0e4lEOvCgXxa9ztuT5dsjM?=
 =?us-ascii?Q?82ujGIeAnSdFfQU4BGNyh3JcIDBcw+YWn7TBB7ztn7WhKi0OvVaYSwRgAZ12?=
 =?us-ascii?Q?vv81vMCjIH2DtXhW7kB3CGJFwGtPS8m/EDlZbmPiWd5UGiqey3Ct5PuBkfoq?=
 =?us-ascii?Q?dH0F/CmoWJNrA0vr5ijiAsNqw9aKhJqPbWxwypPVDjgs8Eeorm5GQAuNr0an?=
 =?us-ascii?Q?HNyIe0Z67TTBKmhyogiAiF1LkYQ1wtQhLnEW5WOYfOeVOgN95xWHK35fOH7D?=
 =?us-ascii?Q?foPCDZ0E/0zgqjlxfILUrjab3sx4Netie+yQ4uE/6TwpBvfpDTC7tDC375su?=
 =?us-ascii?Q?gpNTkevJPXxoUsrrTg/PAgge960PjHhQf9Ag8Mz9v9YI7QbppZjLANLryx8W?=
 =?us-ascii?Q?kUYGBOhbhqDR8o8TossP3B+r3XRNQM1r+srGpTlhhD9l+adxGL4qrTHT+umE?=
 =?us-ascii?Q?YdRBK58DxzIv61BSS904KERiJaAW1T0/xoq66/UUDcz2hborh4gBneNNVRET?=
 =?us-ascii?Q?NqTlfQdYs2iM2069xBCqobGi7dA3rEHLQWf+aBN26D7FHjG31L1yyjKoq9CH?=
 =?us-ascii?Q?4UWVbZfd2IxehxGs8k0/cIEzWnZONRYFHEVGZYhG6cTYfOlE7DSzTo5cOtEI?=
 =?us-ascii?Q?Pkop7Iipsu+XhiLPqcmMQV9gNvwVOJs9a1AvtkG/qmybw8SgevR9ZuliGzM5?=
 =?us-ascii?Q?N0vhO5kUnw=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c593ceb-a5a1-4852-d94c-08de4498e02b
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Dec 2025 16:07:32.2445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: abiiIa/rdgqHu4x2CUI9UxyEzIkJ3dv1C7ExSl3SgWj8pBqaX/w7y2rPVFVyKtEK+OWjGglGH2f7OLFezKIGvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P123MB7410

Add support for displaying bitmasks in human-readable list format (e.g.,
0,2-5,7) in addition to the default hexadecimal bitmap representation.
This is particularly useful when tracing CPU masks and other large
bitmasks where individual bit positions are more meaningful than their
hexadecimal encoding.

When the "bitmask-list" option is enabled, the printk "%*pbl" format
specifier is used to render bitmasks as comma-separated ranges, making
trace output easier to interpret for complex CPU configurations and
large bitmask values.

Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 Documentation/trace/ftrace.rst             |  9 +++++++
 include/linux/trace_events.h               |  8 +++---
 include/linux/trace_seq.h                  | 12 ++++++++-
 include/trace/stages/stage3_trace_output.h |  4 +--
 kernel/trace/trace.h                       |  1 +
 kernel/trace/trace_output.c                | 30 +++++++++++++++++++---
 kernel/trace/trace_seq.c                   | 29 ++++++++++++++++++++-
 7 files changed, 82 insertions(+), 11 deletions(-)

diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
index d1f313a5f4ad..639f4d95732f 100644
--- a/Documentation/trace/ftrace.rst
+++ b/Documentation/trace/ftrace.rst
@@ -1290,6 +1290,15 @@ Here are the available options:
         This will be useful if you want to find out which hashed
         value is corresponding to the real value in trace log.
 
+  bitmask-list
+        When enabled, bitmasks are displayed as a human-readable list of
+        ranges (e.g., 0,2-5,7) using the printk "%*pbl" format specifier.
+        When disabled (the default), bitmasks are displayed in the
+        traditional hexadecimal bitmap representation. The list format is
+        particularly useful for tracing CPU masks and other large bitmasks
+        where individual bit positions are more meaningful than their
+        hexadecimal encoding.
+
   record-cmd
 	When any event or tracer is enabled, a hook is enabled
 	in the sched_switch trace point to fill comm cache
diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 3690221ba3d8..0a2b8229b999 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -38,7 +38,10 @@ const char *trace_print_symbols_seq_u64(struct trace_seq *p,
 								 *symbol_array);
 #endif
 
-const char *trace_print_bitmask_seq(struct trace_seq *p, void *bitmask_ptr,
+struct trace_iterator;
+struct trace_event;
+
+const char *trace_print_bitmask_seq(struct trace_iterator *iter, void *bitmask_ptr,
 				    unsigned int bitmask_size);
 
 const char *trace_print_hex_seq(struct trace_seq *p,
@@ -54,9 +57,6 @@ trace_print_hex_dump_seq(struct trace_seq *p, const char *prefix_str,
 			 int prefix_type, int rowsize, int groupsize,
 			 const void *buf, size_t len, bool ascii);
 
-struct trace_iterator;
-struct trace_event;
-
 int trace_raw_output_prep(struct trace_iterator *iter,
 			  struct trace_event *event);
 extern __printf(2, 3)
diff --git a/include/linux/trace_seq.h b/include/linux/trace_seq.h
index 4a0b8c172d27..697d619aafdc 100644
--- a/include/linux/trace_seq.h
+++ b/include/linux/trace_seq.h
@@ -114,7 +114,11 @@ extern void trace_seq_putmem_hex(struct trace_seq *s, const void *mem,
 extern int trace_seq_path(struct trace_seq *s, const struct path *path);
 
 extern void trace_seq_bitmask(struct trace_seq *s, const unsigned long *maskp,
-			     int nmaskbits);
+			      int nmaskbits);
+
+extern void trace_seq_bitmask_list(struct trace_seq *s,
+				   const unsigned long *maskp,
+				   int nmaskbits);
 
 extern int trace_seq_hex_dump(struct trace_seq *s, const char *prefix_str,
 			      int prefix_type, int rowsize, int groupsize,
@@ -137,6 +141,12 @@ trace_seq_bitmask(struct trace_seq *s, const unsigned long *maskp,
 {
 }
 
+static inline void
+trace_seq_bitmask_list(struct trace_seq *s, const unsigned long *maskp,
+		       int nmaskbits)
+{
+}
+
 static inline int trace_print_seq(struct seq_file *m, struct trace_seq *s)
 {
 	return 0;
diff --git a/include/trace/stages/stage3_trace_output.h b/include/trace/stages/stage3_trace_output.h
index 1e7b0bef95f5..fce85ea2df1c 100644
--- a/include/trace/stages/stage3_trace_output.h
+++ b/include/trace/stages/stage3_trace_output.h
@@ -39,7 +39,7 @@
 		void *__bitmask = __get_dynamic_array(field);		\
 		unsigned int __bitmask_size;				\
 		__bitmask_size = __get_dynamic_array_len(field);	\
-		trace_print_bitmask_seq(p, __bitmask, __bitmask_size);	\
+		trace_print_bitmask_seq(iter, __bitmask, __bitmask_size);	\
 	})
 
 #undef __get_cpumask
@@ -51,7 +51,7 @@
 		void *__bitmask = __get_rel_dynamic_array(field);		\
 		unsigned int __bitmask_size;				\
 		__bitmask_size = __get_rel_dynamic_array_len(field);	\
-		trace_print_bitmask_seq(p, __bitmask, __bitmask_size);	\
+		trace_print_bitmask_seq(iter, __bitmask, __bitmask_size);	\
 	})
 
 #undef __get_rel_cpumask
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index b6d42fe06115..8888fc9335b6 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1411,6 +1411,7 @@ extern int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
 		C(COPY_MARKER,		"copy_trace_marker"),	\
 		C(PAUSE_ON_TRACE,	"pause-on-trace"),	\
 		C(HASH_PTR,		"hash-ptr"),	/* Print hashed pointer */ \
+		C(BITMASK_LIST,		"bitmask-list"),	\
 		FUNCTION_FLAGS					\
 		FGRAPH_FLAGS					\
 		STACK_FLAGS					\
diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index cc2d3306bb60..1996d7aba038 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -194,13 +194,37 @@ trace_print_symbols_seq_u64(struct trace_seq *p, unsigned long long val,
 EXPORT_SYMBOL(trace_print_symbols_seq_u64);
 #endif
 
+/**
+ * trace_print_bitmask_seq - print a bitmask to a sequence buffer
+ * @iter: The trace iterator for the current event instance
+ * @bitmask_ptr: The pointer to the bitmask data
+ * @bitmask_size: The size of the bitmask in bytes
+ *
+ * Prints a bitmask into a sequence buffer as either a hex string or a
+ * human-readable range list, depending on the instance's "bitmask-list"
+ * trace option. The bitmask is formatted into the iterator's temporary
+ * scratchpad rather than the primary sequence buffer. This avoids
+ * duplication and pointer-collision issues when the returned string is
+ * processed by a "%s" specifier in a TP_printk() macro.
+ *
+ * Returns a pointer to the formatted string within the temporary buffer.
+ */
 const char *
-trace_print_bitmask_seq(struct trace_seq *p, void *bitmask_ptr,
+trace_print_bitmask_seq(struct trace_iterator *iter, void *bitmask_ptr,
 			unsigned int bitmask_size)
 {
-	const char *ret = trace_seq_buffer_ptr(p);
+	struct trace_seq *p = &iter->tmp_seq;
+	const struct trace_array *tr = iter->tr;
+	const char *ret;
+
+	trace_seq_init(p);
+	ret = trace_seq_buffer_ptr(p);
+
+	if (tr->trace_flags & TRACE_ITER(BITMASK_LIST))
+		trace_seq_bitmask_list(p, bitmask_ptr, bitmask_size * 8);
+	else
+		trace_seq_bitmask(p, bitmask_ptr, bitmask_size * 8);
 
-	trace_seq_bitmask(p, bitmask_ptr, bitmask_size * 8);
 	trace_seq_putc(p, 0);
 
 	return ret;
diff --git a/kernel/trace/trace_seq.c b/kernel/trace/trace_seq.c
index 32684ef4fb9d..85f6f10d107f 100644
--- a/kernel/trace/trace_seq.c
+++ b/kernel/trace/trace_seq.c
@@ -106,7 +106,7 @@ EXPORT_SYMBOL_GPL(trace_seq_printf);
  * Writes a ASCII representation of a bitmask string into @s.
  */
 void trace_seq_bitmask(struct trace_seq *s, const unsigned long *maskp,
-		      int nmaskbits)
+		       int nmaskbits)
 {
 	unsigned int save_len = s->seq.len;
 
@@ -124,6 +124,33 @@ void trace_seq_bitmask(struct trace_seq *s, const unsigned long *maskp,
 }
 EXPORT_SYMBOL_GPL(trace_seq_bitmask);
 
+/**
+ * trace_seq_bitmask_list - write a bitmask array in its list representation
+ * @s:		trace sequence descriptor
+ * @maskp:	points to an array of unsigned longs that represent a bitmask
+ * @nmaskbits:	The number of bits that are valid in @maskp
+ *
+ * Writes a list representation (e.g., 0-3,5-7) of a bitmask string into @s.
+ */
+void trace_seq_bitmask_list(struct trace_seq *s, const unsigned long *maskp,
+		       int nmaskbits)
+{
+	unsigned int save_len = s->seq.len;
+
+	if (s->full)
+		return;
+
+	__trace_seq_init(s);
+
+	seq_buf_printf(&s->seq, "%*pbl", nmaskbits, maskp);
+
+	if (unlikely(seq_buf_has_overflowed(&s->seq))) {
+		s->seq.len = save_len;
+		s->full = 1;
+	}
+}
+EXPORT_SYMBOL_GPL(trace_seq_bitmask_list);
+
 /**
  * trace_seq_vprintf - sequence printing of trace information
  * @s: trace sequence descriptor
-- 
2.51.0

