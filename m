Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011061.outbound.protection.outlook.com [52.101.70.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4149A355F53;
	Thu, 27 Aug 2026 07:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787815457; cv=fail; b=QBwSqBsbbcamSZlaahk3aEMgykhCsaQj6epUPahUGHbrS/oEIzXhBCC3JN5X5sAAFPwqL1I5K8w/cPyETaSSthyaqUx3fb39xt/L9edwhLpJ9tpTJZ9492a2PmS0QV8VEEvM5YWtkCn7Wy9hZsSnfVh/9NmDEgtei7G3uDZqUkc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787815457; c=relaxed/simple;
	bh=p5oFt5dMsFqZ14fhJwuilHYeN1go6CA0+780+TEhQmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Wra5IFnu+1LYHWqPH8tHKJ2yeP2wNoHYxg7nuTzHF8SH5ryFJ3reFEnMsLwyTq+OQccRCChS4eEGzJKti+B70/jj9odzHqSYSfu17G+8u+kyERIynpS5BsbQ3nfQJzwEk3qymRxB5cZebOpvLbdzMEulALJSYc78QjnVwXW1ww0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=ei2YBWcm; arc=fail smtp.client-ip=52.101.70.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="ei2YBWcm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F9eYc6R65YdgLKKmlkm/Ri3ZKJQx2x3xmonVJmhh52kwZeXNC/ZalsEQmVwmWWKQtQQhYjWKpYP5TEBjwJ73uTtSQKG410nN0p5TKzf1K46PWCmoXYJ5iqx+4Ggm9OboneCtWBoDsfsmbMBX9doPqde8mlCwdfME2rl+1AqfLSQRT2egmXy7WXQ+KOD6MjrTrVA02E6xSLiQUlh0gKYl2t4sCAD+byAdjTRIz97ZlNcREgwOkEqEXku1IRCouYokRqhRkRqerfFJmw8uoSZnvF5L8TTVQTwjim+o69otCajlWQYWdku5kbhblCtI1ZfhjOC+z31+NlbKrQQdDNpDpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g33wKqR9KESKIpXxUioT/XopYhYnLSY3wKWfD2CjqYw=;
 b=uzKbjnaLcY/GVTa3VsEjyhstfbTVbLWhhMMy9khG3eq++lrH5XR9jyogL0S2/ILsWpIdfGplZkov8xYn7iwwmpZiXugJhC5s+zq6sVzVzlTVUq2mVkZbVDwXXzs0n0YnOj/kbF34IfpX3A2wNeexkilm82GwPMLVF0+qI/pE77i/bmxaLMsYOS8QGFHzxy2lt6hJKHNhDtPcc1U2c91KMjhm6HN0MOu4RbbansReV5lE0mIec9EpmrH/PSKRuccPHwsWM40tburuN0qHGc6p17GrpLzimt5aQr7sWCD81Lz75+usuGIGL2xYrdTvlhwbkchZ3Lfy58KfzJiLNJMNYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g33wKqR9KESKIpXxUioT/XopYhYnLSY3wKWfD2CjqYw=;
 b=ei2YBWcmHSRNdL1lh2ZojtWQ4en18/1EQdXuaD8iG4y/F+C1X7qeV9jQwwSPOFRnXq1TveMlFS+anpz1oMcKlux71lXE1CFp4Etb45FudbcEBGLBxOKQ//r8GAps4+XzyYg280fYhMwW4Kjv5hDGkil+maBRcpz2W23FYcSG/IeKoA5rPVq1kGOuR0fAoQMcurnY2rHFYWGbQxNSyFma6cfRTkkPDa/P58h0W9X7oP/lw13rpCfvlZqFJe/16jYFmY2giMNDaHFeGea7OX2VfOO9SkmJoRs4D3Ldr2XakxZBsrtqWUEeC/I7ZM2owI753rgYyMVlcuQB8bRRomm1Cg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by GV1PR10MB8608.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 07:24:09 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%6]) with mapi id 15.21.0339.008; Thu, 27 Aug 2026
 07:24:09 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Philippe Gerum <rpm@xenomai.org>,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [RFC 1/3] rv: add per-edge dwell-time statistics primitive
Date: Thu, 27 Aug 2026 09:23:58 +0200
Message-ID: <20260827072400.45734-2-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827072400.45734-1-tobias.schaffner@siemens.com>
References: <20260827072400.45734-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0071.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::7) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|GV1PR10MB8608:EE_
X-MS-Office365-Filtering-Correlation-Id: ad5df11b-45df-4438-33be-08df040c2f48
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|10070799003|366016|6133799003|10067099003|56012099006|11063799006|55112099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	O00Te+I7c+NEuFAOjC2xI8kjCbeBaBTcK2j2tYp3BWlQM989mBMhbFa+1LSFKNLHw0jSyj0p2tJULAGXQZu8w0XDrgNK7Sk8pCYzeAQwMW2Mqi1buQ2sIz/o7ZU5DNsGGFVOeYAzWLeXjGjw6YXjgr2v6FBqpUE9oeiC31JEMMEmfen7k7BQkY7NBuRvwCqIyDfUpIXxqaQaKKmS9OJ5TaQS5kLIMCBhE6ZO+1mV6gNEw/Kd/asg9U36+SqLspX8M12/y87Uo2jCwwGp6nI11g2HBtqKaRGwUP7vyXTnkiQ7WF7OYpf6HA1du0/5qPcMP+o9+rtB8Em98yEXAldxH6GFyDN0llC+2gKTT6HrLEfBDlWblpRQp4zal5PEKFlrQG0bGw2SUPnGYeNU8AFgsydab+GA1qEZCi3mSNevzeuM0bAH02gxXy7LUxLr73k6dLuT9CAtSVYzdTJQCtAjKhnqDIOjv29VkMnIu7lVh1hkF0z+Sp78iatM5ycfmqUHj5OwyUWGmyYVtuqEDdPzh/0UwLaXfMo+Ow/ApqRQZwY/+BuNcvWqNtBazni9uPXBmRsk4x9M3YxlqC++JNEE3n7xXViB6nvQ6zc3b1bQwh12J3S58zJz9UpwKY1wjd6SQKKIoLg8O2pEjAK4zFKPBqJleXQgLkNIXZgzsoYfl6Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(10070799003)(366016)(6133799003)(10067099003)(56012099006)(11063799006)(55112099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?B/96TLB8zyM2H8f2/MBYGLjT26e4nRjFwuYL22ORIsZBTd9IrpYLm0H44UbD?=
 =?us-ascii?Q?p8qjYoKREDTE2kF8PXD0iHtsrE6Wr/KKZ2NZFwuy9G7yXYsOoWr+Zbkawho5?=
 =?us-ascii?Q?IsoX3Wtl/g0Nl6ETgyZnmRdrsJWFTx0Br1HvpceCH0/SIVDyEly8GyvWbS76?=
 =?us-ascii?Q?tuIh0BPYGmrN4lv2TaJ9fW12WZIoxOe5KXH1usnv+OqPdWFVzVytZclfBZ8A?=
 =?us-ascii?Q?p078Bsz1mfIBboEARyVnwW1V51QX8pp/SIWrXRitLgmKxKKMdUCMVwIdzq8E?=
 =?us-ascii?Q?E3KLRVmwniKyBQOsn0E2kXBKX/g46idxkGzm/qal4t9UygcM2AaUcmdIUzyx?=
 =?us-ascii?Q?HV+s4SHj4aMrYy3GQ+vrUmen6TF2mmy94nJJBiiM9Kavh7Hibtzhr6XBWZnh?=
 =?us-ascii?Q?uiyMGLqQC6JufwfH0neY/qFXJ75zsF5pYYDSN/L39julO4OGm+7bWyR6sVwy?=
 =?us-ascii?Q?bKP8HZ/qkv18AtM30G/QoJJcDjNQf4txbHGiqpiG6TD+k13PSsWfQv7OUCNZ?=
 =?us-ascii?Q?fQeMl6bASMuRyjcQtrMurkeotIMZpd/T8ln6/ZNvzIyJdKAx4uk4hSvziIm1?=
 =?us-ascii?Q?8OJkZzSxoRRmT9veEL+KgpQWIUZyWgBxV+eIz0QDOPEbpwAkJqmcbKKfhGKb?=
 =?us-ascii?Q?rl41ayJylcO0zNxPDqRD18yYn68FP0Cg2r9QClzNW1FOio1mxSQZiY9+fYDk?=
 =?us-ascii?Q?jmhBve7mp1leoHzABB5l9XEn3is4GckesEFk2tHFhPDodq/kZqiW+Mrxv3yw?=
 =?us-ascii?Q?Pgb6b3ohgpr3ktL0bT7udVVe6aEc178y8oNmTSTu6Hegq/wpg/I9VOzewLWv?=
 =?us-ascii?Q?D64vFGCWGIl7/ONS9cy0/05sadQgOH+FZMdSG/W0I//kBqcqGOaF3HWGvYnu?=
 =?us-ascii?Q?87MXJyfWRMHXD81L+Jwu/lu7W2i1qR55YJSOeEO/d4+FN6mYIZIlhKZKOMz5?=
 =?us-ascii?Q?W6cznMTz0Dvzw9cppvd5iMvvkxPJ9UTr7MMiTA+nZ8uAcztWhHqaLIS2CQf3?=
 =?us-ascii?Q?p4WfupeqPEQrVU7yHfEKyhKbqbBrDE1YkHMALUo92FAUvEtXmwnGCXgq6jwd?=
 =?us-ascii?Q?cQpiZLjnTxn0k/LePxD1D40NhAXWNnC4GbfLcMVeHtITSt+fW3eeIi5Uuq52?=
 =?us-ascii?Q?KEMSIVUeHYH+VUrIvnlJ8aedY6GVKs1Scj70jaPcBivCih19C1epBcyQhHfl?=
 =?us-ascii?Q?6kMRhxB8y1tR+XDypiyxmyjrxW6+x+czS1XWBYHoWD68GxLyzBg9nhLamz+E?=
 =?us-ascii?Q?h+LrL1HWYTFTxlGlnNE5JpcOzcDj34DSmBH0ElWsw08gq7gIAFvOuTJyzuXJ?=
 =?us-ascii?Q?4C7Lgcfti901X4YIgQ2k4VE5wJI9CYJF8eoB1WnRDOKlEKY6AA3HsLGtNFAY?=
 =?us-ascii?Q?gZd446Hwl/0+JHpSyEi2PpqIYpkOZWoW1hZUuAbwiNhmMAvldhQHtHyfVvQ+?=
 =?us-ascii?Q?eTIlH3/0lhx5FxLrQokDnbiC5YEiBNVF7iiSFkfjpXcTyN2D1+VJIyMxWbGd?=
 =?us-ascii?Q?IboiFdMN4CXKKZGFbG/Z+HFX3Rhd8QzMg+H00xkd9cDoDIwdisR0eMXu/Skc?=
 =?us-ascii?Q?4SPD6uhPged94ZTwBF7gvspmkEpLOyr7bXW0+gLlid9564hiTBUgUOKxd1EW?=
 =?us-ascii?Q?ecgADpex/fNucq8MHTCVmaeCTzeX4zS/Fkp0ve51vMJqwKh/Q/bCDpPTHxmR?=
 =?us-ascii?Q?UvSLVNiG7RzEAH2HTFuSjqX62pWO1ncM/8IkDKGxu3i4pAWB9Y+BlXflSkgu?=
 =?us-ascii?Q?ptSwu8WFprv/8li9IL1a1/qGgCiJ0Mjyw9SL4ONcafFZwm4FwGFIqgRDo35Y?=
X-MS-Exchange-AntiSpam-MessageData-1: OYVnDow/5q9/9nWHA90mGXTJ+ky5rjcWIiM=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad5df11b-45df-4438-33be-08df040c2f48
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 07:24:09.0941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RN7yJzv4H4M6J40nl8OjCv0Yui2sC3Jj6fB5UzOZjOllE1pDY3vfL3Nhg/jjgjiX0q+oYmhgiUqXZ60rwZdX45M479CGlpney6Npl3kV5CQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8608

Add a small primitive that records, per automaton edge, how long the
monitor dwelled before taking it with a count, a sum and a maximum.

The counters are per-CPU and lock-free, so a monitor's hot path can update
them without disabling interrupts and without perturbing the very latency
being measured.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 MAINTAINERS                  |  1 +
 include/linux/rv_edge_stat.h | 45 ++++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)
 create mode 100644 include/linux/rv_edge_stat.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 8014b9f8253e..04589dda0873 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23654,6 +23654,7 @@ L:	linux-trace-kernel@vger.kernel.org
 S:	Maintained
 F:	Documentation/trace/rv/
 F:	include/linux/rv.h
+F:	include/linux/rv_edge_stat.h
 F:	include/rv/
 F:	kernel/trace/rv/
 F:	tools/testing/selftests/verification/
diff --git a/include/linux/rv_edge_stat.h b/include/linux/rv_edge_stat.h
new file mode 100644
index 000000000000..751de8074dcc
--- /dev/null
+++ b/include/linux/rv_edge_stat.h
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Per-edge dwell-time statistics for RV monitors.
+ *
+ * Copyright (C) 2026 Siemens AG
+ * Author: Tobias Schaffner <tobias.schaffner@siemens.com>
+ */
+#ifndef _LINUX_RV_EDGE_STAT_H
+#define _LINUX_RV_EDGE_STAT_H
+
+#include <linux/compiler.h>
+#include <linux/types.h>
+#include <asm/local64.h>
+
+/*
+ * Per-CPU counters kept in local64_t so accounting is safe against interrupt
+ * and NMI nesting on the owning CPU without disabling interrupts -- the same
+ * approach the trace ring buffer uses. Only the owning CPU writes.
+ */
+struct rv_edge_stat {
+	local64_t	count;
+	local64_t	sum_ns;
+	local64_t	max_ns;
+};
+
+static __always_inline
+void rv_edge_stat_account(struct rv_edge_stat *s, u64 dwell_ns)
+{
+	s64 max;
+
+	local64_inc(&s->count);
+	local64_add(dwell_ns, &s->sum_ns);
+
+	/* Keep the largest dwell; retry only if a nested update raced us. */
+	max = local64_read(&s->max_ns);
+	while (dwell_ns > (u64)max) {
+		s64 prev = local64_cmpxchg(&s->max_ns, max, dwell_ns);
+
+		if (prev == max)
+			break;
+		max = prev;
+	}
+}
+
+#endif /* _LINUX_RV_EDGE_STAT_H */
-- 
2.43.0

