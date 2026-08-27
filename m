Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012048.outbound.protection.outlook.com [52.101.66.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D00D23C4F3;
	Thu, 27 Aug 2026 07:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787815457; cv=fail; b=CDvuHgHNlOBUE4DZNfep6/heuUDnP8ZI0EVEobw1anVWiYEJp2lomciEkgRgjQwexWOb40PPSJC4VCpWmMg1hXnc4rLJAbyRmYevsIZiuuYf4bu3xFIXS8cC0OYwl3IK8v3AW1bRtPac++AVP0YYYHGbMCmfnx1HJDUj5BNv+CE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787815457; c=relaxed/simple;
	bh=CbH24tSQgZD3/J7kO7ij8xOxjR/yQS4KjCu+nX4cVFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VAvb9VY03egqXXb9S0Q1Og0cAbSUQZ3iohXq3zYzcK7J++oyWrz1h77gK5fmvf4ocd/aW0P24sfST1AJsE48UmsTmqLw/OfyB/1BrYv78uzTV/nbIHgOarEBjBfHKBuDjPOt73v/BNPL0bnUYB2GlFxyxRGLanVLfJSd4rLOPt0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=QNzKNAxw; arc=fail smtp.client-ip=52.101.66.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="QNzKNAxw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RE7yIlhiG5CmL/s689I4AdTLkFeSNYRHNS+vtQtYyppJ7WN4VxvXBKYRSzZgtkYHu9iYq+OCEZAGKLmC5v6Xj32aAUS/XQo3uuBCsFxDmDwn8V8P9i7zaU/laM4bD9zrsijOZ6dvoO8OSln5VXU5ZdpvdguSxu66mklUd8WMjGPzH9oow61DycdgWTH9JcLc5HyGEH1zbypw3HQG5x6+9ThYawiRFuscTiIqAMlqBYvkmXRoJTLBoJvwfqd7yu8JjuhphxG6NaHhCvNBgvRIBsBqgWTcnoW+CftZaRTk1zeGooke7/HZha9iCiUgMZTZSoTvPloWnxfRXztBjm++DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eBaOH7eUoOkbG0PfDgQCuWbEC5Th9YF5kltGbORhnDA=;
 b=DSTaY9SrdZCBqI8HLNqRZ+yaCG+bJ3wGJ8oXhcXXOt7mVmktsockkMjU+GVV9MbpUeZSzggvUvK+5Kz3ydPt9HWwLkRWeF+0eli0DjHuv6wXOTuGG51rjPZTO18bw6TZeqjafjAi5os+6sx/7L9id9Uaz0TTUQnm8GnyEnxmvQq3REMTKTNSmqDyQV6nyIw2rBS4/QuRG/h4KC4SqUB2u5mBUM8oqV5ZlSdq/BUeDwkZmS1E/oLhZ7qEaZ/G95AnneC/tecPclN2xynxKVtEzemr1H3zToK4+dbu9r7sX793cLQV8uhO0kG0wx/bUe+pho1a+N3bzQkbqBNI1xAc6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eBaOH7eUoOkbG0PfDgQCuWbEC5Th9YF5kltGbORhnDA=;
 b=QNzKNAxwTng1hT+zj/PZHF9nSnNIt3qheMnxC25819odAtzzsXFcYMEdp+6MoL9VmdR99xw9JqQu1YzGYIbXzKg40n2lyecoK8GW7rWzB97hR5hBHHx0en+yUT9jBbtm1K68jDe4DiQjp7+18x6ylcbjD1UQ3yjSMzM3C8IdGv8GJdxgwKq58Wbm0KdJZEnq25l8ps4ObN77rJwQNwIkTBgNsxAwoPTCPqlMnwz4bxD+iKLL/d0k4vdyLwnnqUbDZ8WpnB0o/LFwIuM+Xn0KKU9AstglHsXy0tUmI/zRsOttUI3jOUHIUutFRrfbuM29VeeCrkKsxIe8p6BetfxnMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by VI1PR10MB3343.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:13e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 07:24:10 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%6]) with mapi id 15.21.0339.008; Thu, 27 Aug 2026
 07:24:10 +0000
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
Subject: [RFC 2/3] rv: add per-monitor edge-stat facility and stats file
Date: Thu, 27 Aug 2026 09:23:59 +0200
Message-ID: <20260827072400.45734-3-tobias.schaffner@siemens.com>
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
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|VI1PR10MB3343:EE_
X-MS-Office365-Filtering-Correlation-Id: 58cd89ad-3aa4-439f-5231-08df040c2fc1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|10070799003|366016|6133799003|10067099003|56012099006|11063799006|22082099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	BbQk9ZGf3phwhV1V0WU37H4bqVannewEwx1KEOoZcn/l6QGl158X1WVVMoRDaZdtlEpghsS9QVlzdRkpwVvN8DZMaV/H2ud7m8DsIJE5A/ZyqG2lKx1Zx8DAlmVGDR3FexQOLlojBCt1GGVgjtIQL1ecjbnj/FuuVvz5N+TEvjfdg18oAaw5h0gjYtwt0T150feSPRr/zTJjLlgloTomL0vx6uv0w/GWynsuOSx3hk4VwrZwOIx3C81E18ep9xxrFqTSSgcd/tPCBIlU5fI6JhnjELETgXx5dfNPEIB3Bu4tqxbE/A6iV27YFqHsZNUymDBguq3ejX7BAnUkMTN2N7Rv09JGRckVAuQcNglS3SvseqcBX7BBIUzdarWrTZD4Mx8YNv9+mPI5Wyff49QyU929Fo186PeIhJkhA2Y2smsm7gU+KB12qAq+kCMazrJ87TaGv/i47nKHdol2tdPMYkgZkXtvi8QZppWJQycHQFVs8O7DygPmv3v2C1jYIJbTyYRiK5+YwMjbMuUc/FmbFj2m63OX6BpfgXO6rBJ06+jghzxJ8aY2ClXSTVYIGXPWkNlcmS0OoGf1+vB0B6tSmA5QPd5Bi0+6aX5nxC+hDS6/dDfVaxL6StYmJSQm0bpHkhFd2+q9Ex2gAx3mz42IESUfrP1ZcwnktYNMeMB1HGI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(10070799003)(366016)(6133799003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LYE2yg5BGQhdVLl419fyJBAlDDGQRQv01KrTij8SKUZc1Cc7dhagt3g14B+N?=
 =?us-ascii?Q?RqdozvFJLbP/KCBRBoAB7KdaEqrb5VPH/h7F+FrqPlpCibMKoxbTPW0hu9nt?=
 =?us-ascii?Q?Kh80zqPVF5Inv4YhV66J8Y15qKux3Ns4gQ4UFf2UcTHQPDkTU/HDvW1Tu9M3?=
 =?us-ascii?Q?3xOBOZxH82k2ShTzWLxsIcL9YwCjT+/6UZi/NnQo+c/tCXLzwrJ9kfVq2JqX?=
 =?us-ascii?Q?vOQj8RBGZCInvIUTrS9eAAfNKWBCH9OqpfisEyVhADleBGCUFUDWBMqA/rDD?=
 =?us-ascii?Q?odaZEdDlPM1FntMKKar4SkkuG2w4RU6IV6/SRgDsADLOuF1oJm3p4Snzyyix?=
 =?us-ascii?Q?toWRimwkBNT2lwQbB2Jm26ikSy3S4ytHMHvsqBAYRnafD2GfMxp+UOf93GjO?=
 =?us-ascii?Q?nclaXw7SZv/1GceI9IC3SYWBvLek3E3zKXwv06V8Bwgs4yZ9pfmjZ2UMl3c2?=
 =?us-ascii?Q?IWSmMaaL5q80swTpkTGPgACJGlpSMlYG03AOIuaxIFBU3QqyRaPzORQ0accd?=
 =?us-ascii?Q?3GJD99naIWpUdwiZRtydToq8zpEMo8L2jpajJUyzwXvH7Kx9Gq7WZLq+QZd0?=
 =?us-ascii?Q?fejxSubaccBETArt0eJV4o5UsQjk9wD13ofyY47HHQ64hqU2luol+533APV1?=
 =?us-ascii?Q?+WAXY4Aji0uoyhPhJCKju08t6YD1hoxQZFS0R1u8W5l0oW1DgTipfoMH/iaP?=
 =?us-ascii?Q?byups19zEGXL/jYOyqU3//8Hcsnm4hJN3rPOBeC54mqPChVLQyEAhPL10322?=
 =?us-ascii?Q?cL0P0IbK7mlt7Gz9ER4T2hNoDsqFgKwgFmYTBrmuKAcUl9jmykkb1kcMqVm4?=
 =?us-ascii?Q?XwvPjZKdE6LZel9k27hNDPbXXIyHZ8b0orD4vcbtXsiS1omKYSZ1A0o3swsV?=
 =?us-ascii?Q?6UEoYDf8leXdO+EDn7+GLu3DLGu0/TajneYPhMiGdX3OnL9sB4MM3bTX73yP?=
 =?us-ascii?Q?m9aW31Iywm9ZhznOTZPCdnCplTjhF9oqAOJJK7nPJwzonqzPBO8t+lFzg9Y2?=
 =?us-ascii?Q?SsRXb3A3nbWYPrS7Z+6EA8Mla2mPIw86QE/3LAqXJ1NyFOo1lQ+nnJMS+Mtx?=
 =?us-ascii?Q?mtuDMM3tFuh61Rz8AdrsR/0WqjxQUj1qc/E50bSvtFUCM1mkn77gWnrxAuOZ?=
 =?us-ascii?Q?6FWgVl78i+BN22PZ4Mmaf5n5AqZSS4Hz90ijnSPFvxiNnG2EBq4eD4FI2dcz?=
 =?us-ascii?Q?J3Odr40CvS9xBLNz2S89NPMfkYaW2GOtTh14+1g0tN5cfSLFnGcLcdAMf5Rt?=
 =?us-ascii?Q?hy+CxmI7fWqEDD5jmz0iV9Rak8bvu5PJtN4uFVBGZ7f/qWjiFOpuZ87bEVbF?=
 =?us-ascii?Q?TtkNwQ5RXAPHOL+1F1EMq/hOT4pu19X41Z2+TS8GU+uL7/sRv78qWnvQTmGs?=
 =?us-ascii?Q?tnaY1piYFp7SRO1rgnoF5qMPE/Fok5Cd5coSdZbUoIzzSdak75qeZX261hv5?=
 =?us-ascii?Q?hMEAinLO0nt+pIiF+SiLVzL/DxDfvkFZlPKKka9VFzaAt/PMxnY9E123ILyn?=
 =?us-ascii?Q?QxTTtTJFwpEIxN/SEK05wF3U8y9NCL7nUonfWEqgqgj6VXKP2N4njxMOjSjn?=
 =?us-ascii?Q?pigkpMMnzagvh52PjX4hdl/lYS6Ztg1+UUUJPPCa1acCYPJ+3n8hSLpflBYU?=
 =?us-ascii?Q?LcgZrM2PeM0v6KxVbLMtmzzi9psJx+x4j1Raapv05slgW4nlSzeV9GX3h6Z8?=
 =?us-ascii?Q?WYQ66lSgHjAaWW87qOujT9dizopNzFKlJE4rOTRWutgjoQjuzzjcbaDx3KOh?=
 =?us-ascii?Q?ApABoeVJOaeisvDwX4n88LUx5xWVG1J6/X3V9Q2hbGest58Dra69PzwDA2w7?=
X-MS-Exchange-AntiSpam-MessageData-1: 45HfX1hUhW81Dr5pKJFNuzybuLelj7rjf4s=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58cd89ad-3aa4-439f-5231-08df040c2fc1
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 07:24:09.8487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p7L61pyw9/2mN5GwHpSle26p5z+Spdgb9XbOZFHFrEPeW3tl4WdsnKV/OY8gDGmz6H55U4w23EsbKrSj8HJpwU/wayrya1Ny8cSwbWBKl3g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3343

Add CONFIG_RV_EDGE_STAT, an optional feature that records how long a
monitor's automaton dwells in a state and exposes it per edge through a
per-monitor "stats" tracefs file.

The core allocates a per-CPU buffer on first enable and reports, per edge
and per CPU, the count, maximum and summed dwell time. Only the owning CPU
writes the counters, so a reader snapshots them with local64_read() with no
IPI and no locking on the accounting path.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 .../trace/rv/runtime-verification.rst         |  24 ++++
 include/linux/rv.h                            |  14 +++
 include/linux/rv_edge_stat.h                  |  25 +++-
 kernel/trace/rv/Kconfig                       |  11 ++
 kernel/trace/rv/rv.c                          | 116 +++++++++++++++++-
 5 files changed, 184 insertions(+), 6 deletions(-)

diff --git a/Documentation/trace/rv/runtime-verification.rst b/Documentation/trace/rv/runtime-verification.rst
index c700dde9259c..194b2f9db461 100644
--- a/Documentation/trace/rv/runtime-verification.rst
+++ b/Documentation/trace/rv/runtime-verification.rst
@@ -229,3 +229,27 @@ For example::
    nop
    [panic]
    printk
+
+**monitors/MONITOR/stats**
+
+Present only when the kernel is built with CONFIG_RV_EDGE_STAT=y and *MONITOR*
+is a per-cpu DA/HA (automaton) monitor. It reports how long the automaton
+dwells in each state before leaving it, timed with local_clock() and accounted
+per outgoing edge and per CPU.
+
+- The first line is a header naming the columns.
+- Each following line describes one edge on one CPU::
+
+   cpu edge label count max_ns sum_ns
+
+  *count* is the number of times the edge was taken, *max_ns* and *sum_ns* are
+  the worst and total dwell in nanoseconds, and *label* is "state:event".
+
+The counters are reset each time the monitor is enabled.
+
+For example::
+
+   # cat monitors/wip/stats
+   # cpu edge label count max_ns sum_ns
+   0 0 preemptive:preempt_disable 4210 183200 95501200
+   0 4 non_preemptive:preempt_enable 4208 42600 3812900
diff --git a/include/linux/rv.h b/include/linux/rv.h
index 541ba404926a..7eeecce17e50 100644
--- a/include/linux/rv.h
+++ b/include/linux/rv.h
@@ -136,6 +136,16 @@ struct rv_reactor {
 };
 #endif
 
+/**
+ * struct rv_edge_cfg - per-edge dwell-time statistics for a monitor
+ * @n_edges:	number of automaton edges (STATE_MAX * EVENT_MAX)
+ * @edge_name:	optional, write a human name for @edge into @buf (may be NULL)
+ */
+struct rv_edge_cfg {
+	unsigned int	n_edges;
+	void		(*edge_name)(unsigned int edge, char *buf, size_t len);
+};
+
 struct rv_monitor {
 	const char		*name;
 	const char		*description;
@@ -146,6 +156,10 @@ struct rv_monitor {
 #ifdef CONFIG_RV_REACTORS
 	struct rv_reactor	*reactor;
 	__printf(1, 0) void	(*react)(const char *msg, va_list args);
+#endif
+#ifdef CONFIG_RV_EDGE_STAT
+	const struct rv_edge_cfg	*edge_cfg;
+	void __percpu			*edge_pcpu;
 #endif
 	struct list_head	list;
 	struct rv_monitor	*parent;
diff --git a/include/linux/rv_edge_stat.h b/include/linux/rv_edge_stat.h
index 751de8074dcc..fda30ff728a1 100644
--- a/include/linux/rv_edge_stat.h
+++ b/include/linux/rv_edge_stat.h
@@ -9,14 +9,11 @@
 #define _LINUX_RV_EDGE_STAT_H
 
 #include <linux/compiler.h>
+#include <linux/percpu.h>
+#include <linux/rv.h>
 #include <linux/types.h>
 #include <asm/local64.h>
 
-/*
- * Per-CPU counters kept in local64_t so accounting is safe against interrupt
- * and NMI nesting on the owning CPU without disabling interrupts -- the same
- * approach the trace ring buffer uses. Only the owning CPU writes.
- */
 struct rv_edge_stat {
 	local64_t	count;
 	local64_t	sum_ns;
@@ -42,4 +39,22 @@ void rv_edge_stat_account(struct rv_edge_stat *s, u64 dwell_ns)
 	}
 }
 
+#ifdef CONFIG_RV_EDGE_STAT
+/**
+ * rv_edge_account - record a dwell of @dwell_ns on @edge of monitor @mon
+ *
+ * Cheap and lock-free: the local64_t counters make this safe against interrupt
+ * and NMI nesting on the current CPU without disabling interrupts, so it does
+ * not perturb the latency being measured. The caller only needs to stay on its
+ * CPU for the call (as tracepoint probes already do).
+ */
+static __always_inline void
+rv_edge_account(struct rv_monitor *mon, unsigned int edge, u64 dwell_ns)
+{
+	struct rv_edge_stat *e = this_cpu_ptr(mon->edge_pcpu);
+
+	rv_edge_stat_account(&e[edge], dwell_ns);
+}
+#endif /* CONFIG_RV_EDGE_STAT */
+
 #endif /* _LINUX_RV_EDGE_STAT_H */
diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
index 3884b14df375..9d76dff394ca 100644
--- a/kernel/trace/rv/Kconfig
+++ b/kernel/trace/rv/Kconfig
@@ -59,6 +59,17 @@ config RV_PER_TASK_MONITORS
 	  This option configures the maximum number of per-task RV monitors that can run
 	  simultaneously.
 
+config RV_EDGE_STAT
+	bool "Per-edge dwell-time statistics"
+	depends on RV
+	help
+	  Record per-edge dwell-time statistics for per-cpu DA/HA monitors and
+	  expose them through a per-monitor "stats" tracefs file. This times
+	  each monitored automaton transition with local_clock(), so leave it
+	  off if you do not need the statistics.
+
+	  If unsure, say N.
+
 source "kernel/trace/rv/monitors/wip/Kconfig"
 source "kernel/trace/rv/monitors/wwnr/Kconfig"
 
diff --git a/kernel/trace/rv/rv.c b/kernel/trace/rv/rv.c
index ee4e68102f17..88a0bbaec4d0 100644
--- a/kernel/trace/rv/rv.c
+++ b/kernel/trace/rv/rv.c
@@ -142,6 +142,12 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
+#include <linux/seq_file.h>
+#ifdef CONFIG_RV_EDGE_STAT
+#include <linux/percpu.h>
+#include <linux/rv_edge_stat.h>
+#include <linux/smp.h>
+#endif
 
 #ifdef CONFIG_RV_MON_EVENTS
 #define CREATE_TRACE_POINTS
@@ -278,6 +284,9 @@ static void rv_disable_single(struct rv_monitor *mon)
 	__rv_disable_monitor(mon, true);
 }
 
+static int rv_edge_setup(struct rv_monitor *mon);
+static void rv_edge_reset(struct rv_monitor *mon);
+
 static int rv_enable_single(struct rv_monitor *mon)
 {
 	int retval;
@@ -289,9 +298,15 @@ static int rv_enable_single(struct rv_monitor *mon)
 
 	retval = mon->enable();
 
-	if (!retval)
+	if (!retval) {
 		mon->enabled = 1;
 
+		if (rv_edge_setup(mon))
+			pr_warn("rv: %s: edge statistics unavailable (out of memory)\n",
+				mon->name);
+		rv_edge_reset(mon);
+	}
+
 	return retval;
 }
 
@@ -412,6 +427,101 @@ static const struct file_operations interface_desc_fops = {
 	.read	= monitor_desc_read_data,
 };
 
+#ifdef CONFIG_RV_EDGE_STAT
+static size_t rv_edge_blob_size(const struct rv_monitor *mon)
+{
+	return mon->edge_cfg->n_edges * sizeof(struct rv_edge_stat);
+}
+
+static void rv_edge_reset_ipi(void *info)
+{
+	struct rv_monitor *mon = info;
+
+	memset(this_cpu_ptr(mon->edge_pcpu), 0, rv_edge_blob_size(mon));
+}
+
+/* rv_edge_reset - zero the statistics; call from a monitor reset/enable. */
+static void rv_edge_reset(struct rv_monitor *mon)
+{
+	if (mon->edge_pcpu)
+		on_each_cpu(rv_edge_reset_ipi, mon, 1);
+}
+
+/*
+ * The counters are per-CPU and only the owning CPU writes them, so a reader on
+ * any CPU can snapshot them with local64_read().
+ */
+static int rv_edge_stats_show(struct seq_file *seq, void *v)
+{
+	struct rv_monitor *mon = seq->private;
+	const struct rv_edge_cfg *cfg = mon->edge_cfg;
+	unsigned int e;
+	int cpu;
+
+	seq_puts(seq, "# cpu edge label count max_ns sum_ns\n");
+
+	if (!mon->edge_pcpu)
+		return 0;
+
+	for_each_online_cpu(cpu) {
+		struct rv_edge_stat *s = per_cpu_ptr(mon->edge_pcpu, cpu);
+
+		for (e = 0; e < cfg->n_edges; e++) {
+			char lbl[48] = "";
+
+			if (cfg->edge_name)
+				cfg->edge_name(e, lbl, sizeof(lbl));
+			seq_printf(seq, "%d %u %s %llu %llu %llu\n",
+				   cpu, e, lbl,
+				   (u64)local64_read(&s[e].count),
+				   (u64)local64_read(&s[e].max_ns),
+				   (u64)local64_read(&s[e].sum_ns));
+		}
+	}
+	return 0;
+}
+
+static int rv_edge_stats_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, rv_edge_stats_show, inode->i_private);
+}
+
+static const struct file_operations rv_edge_stats_fops = {
+	.open		= rv_edge_stats_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+/*
+ * Allocate the per-CPU buffer and expose stats. Done on first enable
+ * rather than at registration because a DA/HA monitor's edge_cfg is bound by
+ * da_monitor_init(), which runs from the monitor's enable path.
+ */
+static int rv_edge_setup(struct rv_monitor *mon)
+{
+	if (!mon->edge_cfg || !mon->edge_cfg->n_edges || mon->edge_pcpu)
+		return 0;
+
+	mon->edge_pcpu = __alloc_percpu(rv_edge_blob_size(mon),
+					__alignof__(struct rv_edge_stat));
+	if (!mon->edge_pcpu)
+		return -ENOMEM;
+
+	if (!rv_create_file("stats", RV_MODE_READ, mon->root_d, mon,
+			    &rv_edge_stats_fops)) {
+		free_percpu(mon->edge_pcpu);
+		mon->edge_pcpu = NULL;
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+#else
+static int rv_edge_setup(struct rv_monitor *mon) { return 0; }
+static void rv_edge_reset(struct rv_monitor *mon) { }
+#endif /* CONFIG_RV_EDGE_STAT */
+
 /*
  * During the registration of a monitor, this function creates
  * the monitor dir, where the specific options of the monitor
@@ -747,6 +857,10 @@ static const struct file_operations monitoring_on_fops = {
 
 static void destroy_monitor_dir(struct rv_monitor *mon)
 {
+#ifdef CONFIG_RV_EDGE_STAT
+	free_percpu(mon->edge_pcpu);
+	mon->edge_pcpu = NULL;
+#endif
 	rv_remove(mon->root_d);
 }
 
-- 
2.43.0

