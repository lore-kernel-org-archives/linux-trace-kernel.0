Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020132.outbound.protection.outlook.com [52.101.196.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B592741A0;
	Tue, 23 Dec 2025 03:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766462191; cv=fail; b=rUla3neuXxxFwoNEvTOQ+6v0p2zH952w8K7sBM7FZ90O0rOZHrk/qL74IfCI/mzQQfy1NXoJttQP/KZTyxz4oV8r3n818oj8WN6JXbLftZoCk32LFLIAo8C8qyBMdMC/MA+i7bH/PpIMs18WUuQw4+hQzEwxf/EVGdJKP59UU0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766462191; c=relaxed/simple;
	bh=jP7LxdN3fEhgdzBkHV1bzpeGMqkow/K9N55suZTAz8k=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=EPlgSH1ZmlY/D2rkfiFUO1iwTcxzaZZKWpGMlN8d6ojN7HfSVcR/L8jcQnR1rGtLyCjb28Hq+ZYof0or3xJnpkSQhMCv4KumLjYkvQcQzZWwRGKxODLyVawPMg1udsiJZqJgKdg1MzZfpMO6Z03YVTNhzAxpdmsN3kqxHGxX4AY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.196.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LSZJs+IBiuwdixVOT1fqmK4jo1h7jEPiJrZkRZ+59nL5np4RCXsmOT4qqJxzfXl3b6BGX3kohD+BqagIXOOl+PrMUlftoSlFPziEL2Vszo+0KPzfa36tqHYGRNyhrUd4By25CTUsqd82UxjPrEAU4799FDAKusvGKVnLtjrke1pTqHkxM6+SPX4rCZY+Q3frPu7iSrYHJy45hiCEmsGzMncO7DK8ZUMTS5EGg+KAKFdGk5qb/Tapkvv/urDzk32izJ+G83jHKu+6eFJi+ZAXedAf3+tiHFzA7gXRr93hK+enJyuM/pX3dALc1LOIV0NTl5uG5ogmaPEIHAoInAGXFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+xSgD3fiYwMVSBwi5otiKvJv3i6vH0OhwA34sL0kUvY=;
 b=E2Ht/1Rv6lELz64d/plHXtG5hjD8NMzw/92s0YwwqFyGwNsUTMQdbHmNW1fc8BaN69G6WhNQjewSIIJUEmv/2B6zcERbOm7qHyvTtjNQe0ErzdudfsmWAslR5gsPYNAzyyinVZAJmiUnPb0PY9IVo5EkPR5QZbasTDLlZtV4H83zNwiWxKjXcTuTLlNvuIbO2qbfTeznXywGdTLweXtm6iQHKXIScwO9W2kFNmNE4zKwRx06Mgc5C1EdamgVXAeLxCsj9EeNcHEsGYDy2BkA12hcfmPARYJu/wtxBEkSYlV0+6mM1xWnuErLJWC9ZM1U215i//rWbLRGb6u9lZDmiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by CWLP123MB7249.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:1f3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.11; Tue, 23 Dec
 2025 03:56:26 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%5]) with mapi id 15.20.9434.009; Tue, 23 Dec 2025
 03:56:25 +0000
From: Aaron Tomlin <atomlin@atomlin.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com,
	corbet@lwn.net
Cc: atomlin@atomlin.com,
	sean@ashe.io,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH] tracing: Add bitmask-list option for human-readable bitmask display
Date: Mon, 22 Dec 2025 22:56:22 -0500
Message-ID: <20251223035622.2084081-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR07CA0013.namprd07.prod.outlook.com
 (2603:10b6:408:141::19) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|CWLP123MB7249:EE_
X-MS-Office365-Filtering-Correlation-Id: b11ce031-344d-43e0-ddcf-08de41d73e53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?m0gCCPIVO4+0t7JOV1wRBylh8GMfskgGNAkpLkrOYNnARsE3/vy6vbhFRrk7?=
 =?us-ascii?Q?6R8JicwaKb/ilrJU1pN9ZH0kgxRXTs3bVuoGX3vIseDu3svLdC4G/Ugpk4qO?=
 =?us-ascii?Q?Jr/J7kA+kquz2epvCHM4Qtus3qNn3mOKQaNISt3y43hE5CgkzCm0H5NLun3f?=
 =?us-ascii?Q?eoo/Rxw4l4QtaRKicGL362VAE2eZW1sPB1ri1eRM4vCEiQcXH7ssTVPWBBPH?=
 =?us-ascii?Q?LqF4FS1gA6Xu5TDpcRAEc//imt4E/Z0k4tsecEJbkus/Y9oVvyUSqnM05bq+?=
 =?us-ascii?Q?WI/x4fKe73IsByVZUyq+PwXHuUdL1Rx+R7GHUAZQoyN23nWaqN+gMjZus2Ml?=
 =?us-ascii?Q?oPUKdfYbkiYtWR672f/ULHJeLv1x+heIHuTCux1kNz7hqP1zAKYdYvjmwFrM?=
 =?us-ascii?Q?GmSlugi0ly+7D3ra+bMvTuJDMdQJVnieRC6DPPkdEbCZb2/88X7wTGVXsEOo?=
 =?us-ascii?Q?Hfxv6nBgGaOlK4wHBnTpN3Tt9VhNXzcvSpThy7JtoxpaX4LN5Xa49ZMuF6U7?=
 =?us-ascii?Q?7rhKl4Ei4ChOK54xgdhbNDTusB1jYEa1IjzT5cLak58BD6vaLc2Jq0erThgv?=
 =?us-ascii?Q?7pfu7g4ri0fmyNf9xleN+ktfenuTm0V514CiGelZXak4Z3Y1Eih6jSz+GzSe?=
 =?us-ascii?Q?JYqV/hvT/1kgTnJZiUrqZdh3IwCwTe9bMFjaVYzZUcbNW/ZYaBOrdv4KytUH?=
 =?us-ascii?Q?CJ8/N8b7xOF7mjkA4G20TZDt9gn/XuwDtCMVTlD25woe0g/1Y1k8YVeKe4kj?=
 =?us-ascii?Q?9dEqltppHhNoOKh3aXLQbxfaBJMtz9DsCRUB60OGKntPur6eeBIVbuEb6ise?=
 =?us-ascii?Q?e3XWu3fvho1FIG5kfetY5DqM6/xTNb2ZTxDdiIdK5A8yN9cCRkFBwZNiPqpx?=
 =?us-ascii?Q?w0EJVkVDhAF8oU79iV69w6LLNqG2Vx1+LBNo1Gmd5vRz8cT9oyYOT57lfzYy?=
 =?us-ascii?Q?rYNZCQ8Wp1WUe+k3tJcO2fsdMtYSeYhwCYu+OKO00JOchazvpMSLEkjeEsBr?=
 =?us-ascii?Q?fNnTC6Oz66FKngM9HxWo+mDGa146gRDgOt8E0jif0UWOoNizOHK1Y1F4V2s4?=
 =?us-ascii?Q?5O40hsnBEjmPK5Ei+sF78dFvzDg3FNd9AFkh1ju4OOprV1X9G6m3VyR0qBwf?=
 =?us-ascii?Q?wsSxRMvgSD/AJAZsSPeMeG0ktwbDnNIXGpr4FcfRkxhWvhZoxnLCtPv6zClz?=
 =?us-ascii?Q?2odCC8nDWq9wjpRKo9ksnkG1GTzWozc2xSZpC7sDj8U3MtCo9LlcWE2G/DvK?=
 =?us-ascii?Q?hYEfTKJT8Wur531khOn83pXmE0v0NXgA5wH/6h/HlcsEEbe4P0eNuv/+dCON?=
 =?us-ascii?Q?oNKbaGudnQYpaIpoTJHM1OWkXBU8oVXinmSSD2DeALHOBLEG7eKLySprwHVt?=
 =?us-ascii?Q?Ie89vil0uS7ukuHj2UZ+FWksM40PIJR2UJtcjpBMYATuChJ1RntzB+u9AkAC?=
 =?us-ascii?Q?DEhQZiY3boG5+dHRLzKeCrrH+EKGC3vp?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MdsDuvS/0vIRDpn6vIY6+MPoYePeRKUXsuCSl7M2kZaony2/oXxbbhcUNezW?=
 =?us-ascii?Q?WyY6sj0tCmx9vZiLBqH2tgCSHkgx/1jTlzeFQk7h+bVx5H/V7ZKSyar9QQ9t?=
 =?us-ascii?Q?kIplL296FdGkdTqTBkijAwGZAUA908TaTRSL1tQegbutJpzkf7MIVrgHEm2a?=
 =?us-ascii?Q?TyUBGE5LJ6hUq9AuBGN/PkZ0laQEX4+VmlwyODZb0N4j8YhGUS7a9xRoa6/C?=
 =?us-ascii?Q?/H62Y4HlXBk0SVRMFslyWjL/Pz8I6x9y5rM33pqkmi9yj2PLn7itWJrIGxSX?=
 =?us-ascii?Q?l1Rv57FxojAKA+bWgdBEEgG0NZOCpf6m3dV1ojgoezmU11Gr+tYFiZhCgaD5?=
 =?us-ascii?Q?j09zT9MA46wXRFovwTsmYkFRGCXu4lpZGCPJtKR01oRMdD/viBuemZYdq2WP?=
 =?us-ascii?Q?Q+fzonGqwNqPBMGoEak6CDKgP6CPzrOdxzvVSyjljZzh1DJxdHNCvy9bUmvJ?=
 =?us-ascii?Q?kMUFrOCT/OMIrrvtHiXQHXODsmKlnyJFty6zkq841ys6shq9LdjKxFyUhYHR?=
 =?us-ascii?Q?iRjdKWOJnBTINNjs4ZtB+SjiU3/V9uvjJZ0o0jQ0/Qhv7hjmMfmUdbT/SsGw?=
 =?us-ascii?Q?UT8F7H3LVrU/AOtUtZSskgFzlo9k0PPitvI/QAXJGsBMDRunlLw+KGTmdb42?=
 =?us-ascii?Q?cYHNaP6SQxXYfJO3vN+i0S3D2rnC68KskKAP1URNw6MZ1da/Axqg8duvfhqT?=
 =?us-ascii?Q?1wHSvJlk9jKTYpBe79IUbvWCStzOXCmOAcyfWGGLEjXE/CjEnwsCZxaRZB5W?=
 =?us-ascii?Q?WQ7em9mrt2Klgv6YlJ36A0Nl/vkVLjw2mCy29uIW0chaZ6cWuh/HegPz8apz?=
 =?us-ascii?Q?A9Rh4+0J3iGhlNu9OOa1RfSMhFsajhErwangSo0EZ41xZ0X9+zNLKcgXXexq?=
 =?us-ascii?Q?vix7WohNiDJOEb+kODuff94nXOZigQsvlwU0j+pizRmj+pZbnKBbbLJBKJ75?=
 =?us-ascii?Q?4Ig2tBSv684udfzkJV9bzGlNYZg7Yf7/97iqkRaINugeY5pcteRm7bKhxapg?=
 =?us-ascii?Q?8ZGwE6cxOFMtgK97Wh5OjQLLD1/Yjq3RDfmeqYgNtMuCcKzAKi+aOT0fNxB4?=
 =?us-ascii?Q?koOLqMhQ/g28DnFX+d7hapX+V+I7f9ln7z/NIWNYbAoiZbAbdB03cOmwDHjI?=
 =?us-ascii?Q?8y+vbMmgkyMxhivqzXtCM+lMxrVB4gau+MypJ5X47ZEdogHura/MLBQI16nm?=
 =?us-ascii?Q?RnvBbsInaUG31Gzb2TpQ1CzsQP8XWX4LO5Li20Pwap2MJreFkRv/Tf0cb0O4?=
 =?us-ascii?Q?H2gxeX1TC/+2s/VG8+jBavUF+zM7yzvNpODheB62qkvIia399LxGxUXPbyMi?=
 =?us-ascii?Q?CDs3nuDeJIfRc6dwEmNESkvxPYbeyZ3euUV+r2Ad9jQ75+phWtSY5H3ZKnxe?=
 =?us-ascii?Q?UpPYmkJaWwdgD3f8tYsUK/h3CwOrhUHxbomlRuh3rT/CfU6hcCXwBOrLgo3v?=
 =?us-ascii?Q?Oz7lDb1Y74h4X1yJTKzThQixr0wzJtOhbmoc5kcQ2opoAPKgPQMIwCAh8fal?=
 =?us-ascii?Q?XLIOw0Dt5N1W2DiNyxJ8wRXtKWwmlL+OSlKy/m3AyBQjKMIsJHzYbP69TKi0?=
 =?us-ascii?Q?/e1nuLgipCOl9RM9S7UBHDB5sbdxO5ZfPBN4y6ABkzNzZqKRb6HQkim/lR6M?=
 =?us-ascii?Q?x7p6Xw33l9Hhvc4ybTzN3WHAUq4UX2Yk1koLaKHvCw21e3S1Thvf+2KzP3Vm?=
 =?us-ascii?Q?mLeAaX53KqllPvuD5akucoUPjZi0qEmMMh0OOO0i99hVGwf/bRa1GZqyCAy3?=
 =?us-ascii?Q?4J8uRubAng=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b11ce031-344d-43e0-ddcf-08de41d73e53
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2025 03:56:25.5808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XqIqq07WDvHNtJI1DaPvOPnBdcHgKCUYBzOTWhapwE4n0uMrYgHU/BEPQezjfl1/WuLovRehq4sU8VGFyotdAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB7249

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
 Documentation/trace/ftrace.rst |  9 +++++++++
 include/linux/trace_seq.h      |  4 ++--
 kernel/trace/trace.h           |  1 +
 kernel/trace/trace_output.c    |  6 +++++-
 kernel/trace/trace_seq.c       | 11 +++++++----
 5 files changed, 24 insertions(+), 7 deletions(-)

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
diff --git a/include/linux/trace_seq.h b/include/linux/trace_seq.h
index 4a0b8c172d27..5e5b4331f8f1 100644
--- a/include/linux/trace_seq.h
+++ b/include/linux/trace_seq.h
@@ -114,7 +114,7 @@ extern void trace_seq_putmem_hex(struct trace_seq *s, const void *mem,
 extern int trace_seq_path(struct trace_seq *s, const struct path *path);
 
 extern void trace_seq_bitmask(struct trace_seq *s, const unsigned long *maskp,
-			     int nmaskbits);
+			      int nmaskbits, bool show_list);
 
 extern int trace_seq_hex_dump(struct trace_seq *s, const char *prefix_str,
 			      int prefix_type, int rowsize, int groupsize,
@@ -133,7 +133,7 @@ void trace_seq_bprintf(struct trace_seq *s, const char *fmt, const u32 *binary)
 
 static inline void
 trace_seq_bitmask(struct trace_seq *s, const unsigned long *maskp,
-		  int nmaskbits)
+		  int nmaskbits, bool show_list)
 {
 }
 
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
index cc2d3306bb60..ede1a1b6d5a6 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -199,8 +199,12 @@ trace_print_bitmask_seq(struct trace_seq *p, void *bitmask_ptr,
 			unsigned int bitmask_size)
 {
 	const char *ret = trace_seq_buffer_ptr(p);
+	const struct trace_array *tr = trace_get_global_array();
+	bool show_bitmask_list = tr->trace_flags &
+				 TRACE_ITER(BITMASK_LIST);
 
-	trace_seq_bitmask(p, bitmask_ptr, bitmask_size * 8);
+	trace_seq_bitmask(p, bitmask_ptr, bitmask_size * 8,
+			  show_bitmask_list);
 	trace_seq_putc(p, 0);
 
 	return ret;
diff --git a/kernel/trace/trace_seq.c b/kernel/trace/trace_seq.c
index 32684ef4fb9d..5445fecf5f95 100644
--- a/kernel/trace/trace_seq.c
+++ b/kernel/trace/trace_seq.c
@@ -98,24 +98,27 @@ void trace_seq_printf(struct trace_seq *s, const char *fmt, ...)
 EXPORT_SYMBOL_GPL(trace_seq_printf);
 
 /**
- * trace_seq_bitmask - write a bitmask array in its ASCII representation
+ * trace_seq_bitmask - write a bitmask array in its ASCII or list representation
  * @s:		trace sequence descriptor
  * @maskp:	points to an array of unsigned longs that represent a bitmask
  * @nmaskbits:	The number of bits that are valid in @maskp
+ * @show_list:	True for comma-separated list of ranges, false for hex bitmap
  *
- * Writes a ASCII representation of a bitmask string into @s.
+ * Writes a ASCII or list (e.g., 0-3,5-7) representation of a bitmask
+ * string into @s.
  */
 void trace_seq_bitmask(struct trace_seq *s, const unsigned long *maskp,
-		      int nmaskbits)
+		       int nmaskbits, bool show_list)
 {
 	unsigned int save_len = s->seq.len;
+	const char *fmt = show_list ? "%*pbl" : "%*pb";
 
 	if (s->full)
 		return;
 
 	__trace_seq_init(s);
 
-	seq_buf_printf(&s->seq, "%*pb", nmaskbits, maskp);
+	seq_buf_printf(&s->seq, fmt, nmaskbits, maskp);
 
 	if (unlikely(seq_buf_has_overflowed(&s->seq))) {
 		s->seq.len = save_len;
-- 
2.51.0

