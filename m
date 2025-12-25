Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022088.outbound.protection.outlook.com [52.101.101.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A9B305962;
	Thu, 25 Dec 2025 08:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766649748; cv=fail; b=iA0lNPXNdVMAKYN7kv5CCiVwcFK77UDu/dAHOuuZ5o1DfytJs0NNylsGBrWzW+f/7hG5IXlFdDT+dkh3TPSZHszEQWZkoQhqythvNxeSA0F+zDD9x0VLdVWWfJ9FT3k9gBVe6dPZbmI4sCFft9JOYOEHXKFiRXK5aJdwFNS3uQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766649748; c=relaxed/simple;
	bh=4U22II8eAyNYO5967nG6quANHht75kjQAwuUmeN5Hgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fpKv9NGWUYVddA7CqVndr6/ncHU/EFcWVi5JPTc5P4sdrT8EJBF2zGIzLHE6fLXIhBjgpyUaxFkRZnt2OtGyzEy9PX0m8vyDXAEZtSRMkbALjQ/+pWMQ31VjNAECy36I7YVSz5qh9k26v3KuNrK4kO3NQ9lIG7m2LM3uTcwz2sU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.101.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JPpnNmKH/bpnuzBp214RP1/ioBEtXRVa8lS7jqrMcUCL3EXGHtRsgm3UxRWNEdiAwpesrFAn5eBX54/TSaUbParPRmYwk03zFZ+MhtDJiSpC3FdveO+YCHY3LrYHKt9WnDaVlxQ1srRhuLqkfeNLg5ka6fULKTwFVSqkjEvyGPuxXt+CDXaGOSM3f6FF74Fk0Kb0a/fYf+sB8xF2mJesOkFW7b/w5fKywYSRnNnwvJJQT4JNv9c/wJCE8zuLw3kr4fcgWVDT49ffUN0Gfz/B0l8ENqYTdP5zMclcY8SNxSMIuaY2SQ0dR1QQv0eZSTAKXl5JjVCnbJqh7a1lRafVXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BlEDqhq3hcpTzdVcA/Uqhx7HTZB1J6vpGz61KN0ZeYY=;
 b=MVPnwmxl7CBp0roYNv1DJQLtMMwt2jDffeCicfoT5jWfPo14PLVmWT/zimWLmTSVmnFNIVkzVFphIVaJNrtNL39ndNSIgsVmnUbslkckT0PmhKP0VrNaqox0dyy5RRIqPiJGqoqb0wQIaIe5Ii5TJqSTHKdMg8Q4ANL/HFHPx7Fuz34YY51Ip3glVrH6hhnNuD0ibId7sX1cj2EA5inhpMsGigFV6eIAQeiD9zN/AXCR2RBlJmpq/Ux2XjxuSaGrm+c8QaOGOpKg6+pYbWo2llrd+jsK6tzk4eFw0R/pNdvYP5zgB/0DZuRHLd1KdC2T2sxRkiOMiABoJNCgdvIyOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by CWLP123MB3540.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:63::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.12; Thu, 25 Dec
 2025 08:02:24 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%5]) with mapi id 15.20.9456.008; Thu, 25 Dec 2025
 08:02:24 +0000
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
Subject: [v2 PATCH 1/1] tracing: Add bitmask-list option for human-readable bitmask display
Date: Thu, 25 Dec 2025 03:02:16 -0500
Message-ID: <20251225080216.2196411-2-atomlin@atomlin.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251225080216.2196411-1-atomlin@atomlin.com>
References: <20251225080216.2196411-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR04CA0129.namprd04.prod.outlook.com
 (2603:10b6:408:ed::14) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|CWLP123MB3540:EE_
X-MS-Office365-Filtering-Correlation-Id: a13e8e59-125c-4563-8f6c-08de438bf027
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7142099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eHUrYLrtibQcHaohc67984TySAdWB72AD+3l7989zueC9/jyZikm8oe7tvfg?=
 =?us-ascii?Q?DXGB4K9nqwM1yk20U1mrLTPM3Q/YMo9SV3CY6j3BJKBAG+Z20qHQzGKIRQ99?=
 =?us-ascii?Q?aYqwtfP28IQoWbWncoZJCsWl75slMoBCXeD4msv4sqQNOE6WAr6q06T9ZmuR?=
 =?us-ascii?Q?H56DE4/s3ZlzqifecquEtC2B4IEE+66AMT6R8XLTCzlpTyKR2gQQN+lSGdfD?=
 =?us-ascii?Q?0d7XpYsl9G6vAPaa7XKTQMSl09tgps6YlLEV2rUcyyEJI1h6i+aqbbDCJDRD?=
 =?us-ascii?Q?kTYN8xpzp/Hpv+smxbHUHD6yE9PfYm5PONV8INMnelpTm7HcTkxJ16GQMUOn?=
 =?us-ascii?Q?pnYK3Ouy2QLkrZ1It72x2h4TJoNt4dXjNjm3r5LvPOPDgOU2uAX4gbHEZP1t?=
 =?us-ascii?Q?CjunqAm1pKENMHSDd4O+HYYHLR3CORnrBz26E8+dOT0KziN5IUXM8tAwpbG6?=
 =?us-ascii?Q?vGyXJtviazmzVD9qnXxmkEJm+W0sVz7ixA4fJ0gNRUp6DdJz/6vQKbi1JPEJ?=
 =?us-ascii?Q?AN9mBtNNm6ZxOj5h83OIDHBaCwseeDC4TDazwHijIvME8rzSixuEieh15piX?=
 =?us-ascii?Q?YQe25UfUL9GjAVWJy+36WNjTNKoQLKeJST7oSUD4vrtsAKunkQTxm6nZrEhJ?=
 =?us-ascii?Q?tR/FxCkHBzYRUnSsPc2KMLqJ4dZrh+6KxF0j1aJW7jZNFN4sMeEndgcbmOu5?=
 =?us-ascii?Q?zujwJpr3UEQUi0SFsoUlds+RVPI6L1bdtDR2dbJPAP0Gq1U/+MkjOKkJDRs9?=
 =?us-ascii?Q?8RwUtg8SOlif9OuNl3yruTma7RIE5q/v1BH4u7OaCiK3gTQ1c7zf4kAkRLdz?=
 =?us-ascii?Q?o+A2rcIJ2N28fKCVeC0ZPD4uPVLhlupb/SnQdlw/m6LBe9Pk1pV2FUAgA6j6?=
 =?us-ascii?Q?bvJGWKoQ5ChAhdO+lCb2j0ISGj+KtWc1feDD8rmJN8hePgRmcku2O4/BzrxB?=
 =?us-ascii?Q?TujhE3KXu9zrIAdd4d1d7StenJDyhZFS2MppdX/oZyYZRA2khl3P0ZsbXgAR?=
 =?us-ascii?Q?20ij3dmoneS7dxKJgW5SOAhx35eAXdn/Q81nsa0mVW5x/gO3tx2o4bIp544f?=
 =?us-ascii?Q?+3kGD1LSK391wPnYgf+t1RMNuBO0Z8AgW7hQDbVdS8qyup4OZdMGy6+QKRL+?=
 =?us-ascii?Q?+lHyYjreBJqOvzSLuHPymq100XZfXWAIjgJ0zi0CMrBOz9DxAl5+uQNU1kKO?=
 =?us-ascii?Q?pFaLVk6JqPPH0T40pdIPKGIpStJKJjvMx6Cn+Ds9jchuOM32dPfZK3+wG0XS?=
 =?us-ascii?Q?BmXjAp+vbzCbBk1XBCK58o3Os8+pIh4AX2lgmokE2BcxsEwRrlhucTb96wZo?=
 =?us-ascii?Q?bN72nQnSj8bcBnOipEh8gGFCEzSWaFJbHQmUg1fXL5IZzEM1JWLgBuj4E39W?=
 =?us-ascii?Q?/7meXOVtYHLjw2OdEK/XhqlnGrO3xQg2YvFXqW47MqItgwt4ZiSx9KDBr4b2?=
 =?us-ascii?Q?SXVoA+FWUKBEttJaH8d7hVlW2Xg/aWjT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7142099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cS01HSQzMZZemKQLnOXmxFqmWEmlodk76tVk+dbci+4ARRlz5uFtzRWb/Txw?=
 =?us-ascii?Q?naUrjWo36PJo+tYEtlG0kgouBlhrXP7aVgPei8fgjlVSV6w0JD33dscQRT+7?=
 =?us-ascii?Q?pzcbZUR6mX/Lr6A7mvTIMUrkyRD+75EQFwFuxhdazDRtibsEYKDH6IEM9VRU?=
 =?us-ascii?Q?5kHTzwIkn8HEAGAdQkvUa7VxmAeWt+niUEd3+oQSkGhyA4ebfax2c8bQqDDs?=
 =?us-ascii?Q?wK8iAnVh223NOPTuza8KnTrf7dJuFoKFvQnHey9HBHg3cvstFBzTDk1JFKO2?=
 =?us-ascii?Q?BynQmMh6NYP3sjoCGB6uPEuGpIRHto6n4E2aP+8RcAsI0Hpbx7U4EJy8vCmz?=
 =?us-ascii?Q?laSWrv5PbbkD61l5RqSrPJaaE78/FQjHow7tsIHPwyztfioeL80RFAnhl16J?=
 =?us-ascii?Q?Inu2PXekJgoTXJALedPjorDrt2Pk9+Glvs+j/QYxq8nRrfsUsJlvhQeXTQ8O?=
 =?us-ascii?Q?u40RsN0sTpv9DeYDGhjShtqsiQgGNQ61NCBuXNbDKvPCL5ghDhqlgqhtKZfN?=
 =?us-ascii?Q?thftCk6ri3uzBBfYuLi+tJwl32eN+hIo6Ksn1XxfdQuqylveeqkyl4bgEJqG?=
 =?us-ascii?Q?O7Qnul5Q0gxf9feqogV8VvMOnru1eTCdf+MQxDZnhpp61nCpvM3pOpsyKJQS?=
 =?us-ascii?Q?Pqc+8jhxMGp24Uyg+D5J/urmty8AIzWJJheln8fS3d1G+PgEos7vTNoqyuM+?=
 =?us-ascii?Q?w9jzThTefhmzHMMO/rL0CjAwQkgMuP4WMfH7UnP4jBkKNcL4N0bp/rV+TLPG?=
 =?us-ascii?Q?7/f38CnE8dhg4mLwyrPBEk3letZZbFweKMi1kPrUAMd/lAGA2bWMFnZg40eQ?=
 =?us-ascii?Q?1xYgW/zVt9JzqldNJPoztXZLFAp9pTGzouosPrBS8TfhBVI+Nw7lmnHhI25g?=
 =?us-ascii?Q?8R7C9kxfKd5bbmFX7WFlx4oxsAFIlQ0Fj3mOLUMAdun4/h9vRIL9rW4vOOVt?=
 =?us-ascii?Q?wVOpamIqxF2r8sGoiWtmMx3s6nPMZDf2w2c7/O2bWvDdH8pPyJQdYDbIXck+?=
 =?us-ascii?Q?7FWHu8ilRmCW7vQzh2gKEfIaHEp32zwLnjHGv/FGNtzRGfy7MRxHx87ZdalH?=
 =?us-ascii?Q?eKJqnBnd+Qd3RGXUUwKRvNcU0D5doPvo5fOoYc/6xu8/VQiX9viF0oYSytAn?=
 =?us-ascii?Q?/cOOiFreg6ZItNHbVPPiOoLTku2Afxj8etHzD0+YC0ZTdTMdTZbR6RCb/wEJ?=
 =?us-ascii?Q?a7hraaLIUPCIyT9nAPwIcsX2vdbKGc+mluTYojzGOXpzw+3LHVnGl11LyV9l?=
 =?us-ascii?Q?hJX8ghk6jGETDMdxK1j9MX/dbaqtDpW1sBlW18AvXZyXfUEycsWe+31i+g2K?=
 =?us-ascii?Q?KxKXlCNqvd13YgCYjvIMAaJ1lOcqMLAcTZyuRIeNh1svngkwZ/fQ9U4DXPIR?=
 =?us-ascii?Q?GKcZmxue6FnGUVYBZcLJxdl2beL+X1+oFgWIHYq3++3oeaQFptbJ43ceqYFU?=
 =?us-ascii?Q?pMHWeFbSXRoOxMjcLeUtwLZyhYPnzrhJqcthM3zL/JwPs7f/NcXTPPIWZyx5?=
 =?us-ascii?Q?ga7smXQBsGR4bK+e4bWkTrM5Y7M6vFJVeM6rrKwuJUNZ0IUCSPfOE4dZE+q8?=
 =?us-ascii?Q?/vaJJ1ERyfFBQfLiMmoCh3XGrJaGYHTJuwHgLQ7XF/P9JRQdMHJCZHgaG2OD?=
 =?us-ascii?Q?retc0Vh01QTxCXb6otOVr7WWRvZkn3RIA3z03PlVGRd0nK2eafNh1vNdsQXJ?=
 =?us-ascii?Q?owT+QASsfeYuB6d3iJ9yZ9Q6rVQmzoGrhpgpJEntbPADOOxrYAxwdlsTtSGn?=
 =?us-ascii?Q?3zkiGwbBzQ=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a13e8e59-125c-4563-8f6c-08de438bf027
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Dec 2025 08:02:24.4608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: egMR+JnCJbAgXbozES1+q17bTrc13q/N+hGkLNK7SIY7C49uj42paAkpQSylW732N4tnOgPjJaiD0skNRn2hYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB3540

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
index 4a0b8c172d27..37772d8f97f8 100644
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
+trace_seq_bitmask(struct trace_seq *s, const unsigned long *maskp,
+		  int nmaskbits)
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

