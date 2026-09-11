Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011047.outbound.protection.outlook.com [40.107.130.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C126C4756D9;
	Fri, 11 Sep 2026 12:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789130118; cv=fail; b=Y+QVLZKL9a3TADGxB6SRN+8MZkC+KwgsB0pdutNtpSScDnbyS+STBw7Kq9M1TacrXL4R733ckWvh5iYphWTOJwcoHkMtPbKpK92SCPPL5PeNtGxJSROYUrJgYwX4BJN4Li7d3b0rf1CzDNdWg/vj7uzZ44zCZWblmk7Cb9DDN0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789130118; c=relaxed/simple;
	bh=V4sEgNB3SalMiDKX4/gE8ywG09HJAttYDTiX0X/vrgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fUP2YFeqRwX/8omtJGKfk7LiIMZHu/DSsuJdhp9q3BGnPBgDtK1CLD5DdT7/lNXJ+NDQEhVRNaQ+xsG74oH5enTEhNVWQ2//QMbo3bjDxn3QHrkKikkg2kNnDteLYLZC6AeYeiHWiuWiy7A91DzVig3fl71/e44jjb5zK07redk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=WptYgngs; arc=fail smtp.client-ip=40.107.130.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="WptYgngs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DzSyLKkqlbFBHB/3k9x8ESWU6xeXwj7kD1thWmY1InIFrML9OTWLzg2RyUoanVK9OlcfI2yNnpDKUoueBlP6cKCvCwl5IXb6PLZIKbfFiu+O2zO1IMIVHUJ+EG+jgp4xTOE5A+USHDQ9FrhThXU4cvXdbi0N3mEp29d6JJCCKaED/lDeYIASCrJeB3AA7/ND1XN8joSuCuqTt03ADjTrOUGutI0tL+Q4e1z3Jt/m1fl9+ikbmKWtUgPDWK533zB26hW3XwzSTXFZQoWwp3wHtenPdef3HRd0AcKY2kcEZy2q8nziQsJ45sR5MRWg5h8N5u7cY++/UylVsrQhyVqxJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r+3UHVT1nOsVIjhMx9H4BhtW1MTkIvuuIO+zrRQ5iv0=;
 b=w75zquBn4abNIZUHmiQUJUy8gP/W/2s9IsX7D0CwZDPl8O2VQKB08es054yc2xqEXz2uAL2FlROE118z5ubKRhPvuei1yF3h4tEdmltGy07TWjK7gH9Qi2bCNN6CDsujd31LyB7/y7NeKnu+JRWzZniZuRNE3UOjxc/eI3TbqWA4unbFnpPy37oiP5+fzVKKSLfDVfbv1NQ9ZLbgGKeWA9BbzsJe6QaO92RguD6+6GBPoq+ggB9MeI2LWv7s+8ExpR833fvw3mF6K2TsnQPojryGFNRmQIc1aB3+40LEh7KTb3tZ6qIwibDiYZ8+O9qBlCli5I0Kk31GpIeOPxx1Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r+3UHVT1nOsVIjhMx9H4BhtW1MTkIvuuIO+zrRQ5iv0=;
 b=WptYgngs7bm+lbEh2wZP9Ax/Br0aYo9XTavYoapqMstgFI7MvtUQf071O0xFJKA4BI6uUiZHqK7EVkvHSy+GSVgltk65EzK153I5cuY4FWx7ugxAa9xLR0fu/p02SJxY5eLWxt3eHobpF8IAQfm06r3aJ5k/GnT+agZkZuX6MO339LBZqwESriIwAZbbdiqAjVUHtWIGMEtB0HSb5fP8xWcMhZA3nB2QkllVLwJZxIYLcY207waiipaaU/B/9iF3zoUeWzCqAQBCQWlPSQuEhKtMSiyrJ2LUx4K1E7RHSrQkhGRdgx6lQErwA116tACX7LpPNbI52vxb/5c1f5/7eg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by PA2PR10MB8602.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:421::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 12:35:13 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%6]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 12:35:13 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rpm@xenomai.org,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH v2 2/3] rv: add per-monitor edge-stat facility and stats file
Date: Fri, 11 Sep 2026 14:34:37 +0200
Message-ID: <20260911123439.463052-3-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260911123439.463052-1-tobias.schaffner@siemens.com>
References: <20260911123439.463052-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: JN3P275CA0022.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:71::15)
 To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|PA2PR10MB8602:EE_
X-MS-Office365-Filtering-Correlation-Id: 19d50cd4-2ec9-4e5d-462c-08df10011f19
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|366016|10070799003|3023799007|6133799003|10067099003|11063799006|18002099003|56012099006|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	LJwLopD5xUZGjRiTpIwWioAO+0vNrFGHVlJzNxYegQhsUJmTFwpvKNXCBpgbbbT2crXuFQ8WJFQ31JI3OkGH1IRpWAPl8YMgxaqwyUZ4uG+XndQP4aegWd86LkiV68HSl30y1zvUbfHs9SCRDEdGuXpfslZwlYY2L8hraEU00QAB+D+wAEL9ZDIMivDd+9zi7o1xm0736/BwG9u1jx3Hr+A851ebynCodoc/6feyhSgfwbh9I8kWb1rSrFCIvtS4rjF/heZrPYSUmUEyWjTpiTa6JeNMdgsU8rTRBqTYz357kkbuFCToiVr/zbdx417oZr7QaCzWl41GstkrE6XHYJPAEA3rAz7FpHQWvvjjkQrc/LqlehoJ/xVgR2qqLhldci05+I1wPyZ9kt7G3mBJ/BoOVubSlnLhLG/pDn3C5RtYZjOd3SjVAFYBQNclnXsc7Yx4uLb8sGn1bSBVuNzZ62jvsDiR4LKkwMWq/y4781mLV5flAr29C+xQPH6kAzmOX7TOUNds+nnVW5Ggsr9wdS0VLu76o/w/HMkUFTZiK/ItZMUENzpEZrpMmlVa1IDoKyGVspYLbwvUhuTSa2KAsdZPeoMqivnvDjzAqVUbai1i5AjiDL7ZNDv7GLP6qEirdLUG0Ox8iflzghJYAo6IBuZaU8XAf1RPXUYfcknkkNc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(10070799003)(3023799007)(6133799003)(10067099003)(11063799006)(18002099003)(56012099006)(22082099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+TWUuYvnaz09e3+CawTo2HtPGwKp7CZBJDslDhC6P+bTifN0DXEk99udRImE?=
 =?us-ascii?Q?C+RjYtqTW9Bdi5hSPvmWFTONTfzSeQtnkbDtR0SMP0JZpGGpdx27FGFe0WT+?=
 =?us-ascii?Q?EVHXzSnMPxgKVMPGuAWO8AAyKtdC5IVLWndPFfY5y5sSVO3s+/nx01sw1Gxf?=
 =?us-ascii?Q?CKiiv8eJzw9Bkj5k6TLkr8Cspdx64aR0+ki+LLeCu8nN7NGD/N6zyjNbv0ik?=
 =?us-ascii?Q?AWCRIFBuV6h+lknZUNItl1AC/LO+0qpaSN++nc+EN6FIXKy+8z2r5bNB2pHc?=
 =?us-ascii?Q?wh2DtxDEIsmBTqyyaydl3IkrkcHyDTjpdYLhzdvTYI45MV0MODrj4hdQB1fT?=
 =?us-ascii?Q?PAlSBI3x5qODI0/40RNnxqW+kPqE+xJlVA5isKKx+2z3BE1UCFQ+OK1sxPMi?=
 =?us-ascii?Q?UANpRR85bDeV8ni1evmQriHYGnR4vNEqh3fdcUESFUM0N8iF1nTNRx5QlBi9?=
 =?us-ascii?Q?HCsvRTd9JYDHJWn1gGG4gi2h0E1vADQsHgMnF1eK7KN9NdmdnpxLryjsuhPD?=
 =?us-ascii?Q?7/S7EQt105qa0T5ogvMxVNqaf3AktJ3Kcgio8yd00SxC1nAyWzFmgvt+1vbj?=
 =?us-ascii?Q?R64x7pX7lMlXoFXMx0bCfXMLxJCEhJTla10o/cuHlqIlReFEKZWp+T0n8D2y?=
 =?us-ascii?Q?189doOEaIJGPiiP/w+Ce32urEmTeQZGDJXHvulfejvm5taIlKzK/f0iYbXEd?=
 =?us-ascii?Q?6JfrkheWDGkm429ytdR9tQgR2d41iiEjF5ncwYnTku0O9M/mrSf3vI4oJGOo?=
 =?us-ascii?Q?D7LHyY8rW0CzgI5LjSfXLIjzQkElOJ34fB60/W5nGVLgcFZeLkzwLKJVsgSX?=
 =?us-ascii?Q?oj/KSK1j1ojXt36akugZ7x/iSgdSJjA326iXoGZYEkmlREOticQI3j0yEQIn?=
 =?us-ascii?Q?5cxr1y7P+8OcqmwK7iL0GwB4GIWsbXeeqNjm9u8YEAKu8mAeaM7J7NC0ZKV5?=
 =?us-ascii?Q?/DIDgVk9shYFqKxL1XbjBAzZHX7jRJ2nyvp01yucRXXZo4z6k20yWKnt6KjE?=
 =?us-ascii?Q?cpB+AVqSt6h468GJ56yDluY9xrErKqDQ/iZqq/vI/+bxTRpKcQV4LTfhWWlm?=
 =?us-ascii?Q?qcN/elLVM8jjMA48kOxKmeZdrMDg380Cy9LLrgtUH8Bz6egiJmVTWqp5QZh5?=
 =?us-ascii?Q?oDhy3DzmVsdMPjOLAS1p/yCfuP9ShDtM7A7xlDjPlFdhvsJ9m20dCYTbWEfP?=
 =?us-ascii?Q?IS9rDahwZPBUMF07QdUYWaFBtY7gPbOq18klwpUvVNWbMDDUT04iR3WgrcKR?=
 =?us-ascii?Q?8oNUIQUeUxJ3VdnEKNk0FBGhzhGr8ZUcMMXVCFA6UfyY3XGg2HXdiWbr8qfs?=
 =?us-ascii?Q?zRD6+OSIBES3LFOlYieRro9pI63aQI0EA7UcV3oQgUscCmQ6bWWnUzyTBsZv?=
 =?us-ascii?Q?vpW+r+HpnlIEQpp02lV3wsCiIVEML78RcpZ5RyQKPuJ3loFXWE/C7fhWd6fx?=
 =?us-ascii?Q?8DMUnSrF+CUa4rRpVjUKDftuh48UhW4JLvUzhBwP0OPk7SSSWUqyFw1nAm9a?=
 =?us-ascii?Q?eZV8yYLAKTcXVvlGECe9TeaUbQ1j1fDcLBkoitnHN4my3YXP81e4R/DzZzLO?=
 =?us-ascii?Q?ZkRe0atj8N3zhQvNpSlMceNhutO3XmmdzMqkPFE6eS74ywi26nvZ0fpzRPnH?=
 =?us-ascii?Q?GnxeB3PUqoIj+Be5FL5A09MYvViuv2tdwArG/Y1EFuZ70RPGDt83dVT2hw65?=
 =?us-ascii?Q?l7mwsTvc72TkXAeF8uXJuQBvYwNKS+pq5cO8hPPAZu0e8uxpj9krsxg1G2n6?=
 =?us-ascii?Q?tY2ZLd+KhVjk2IfvGDhlonWJ/yLdYHu1ohOHYSHm/kuHtJR/xaYgQoWfCN5M?=
X-MS-Exchange-AntiSpam-MessageData-1: NLlj6wkJcmrE1Zju7bxMKefkwo4UBTyumYg=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19d50cd4-2ec9-4e5d-462c-08df10011f19
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 12:35:13.5137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h4mhIzapJPyoXMbFxfPNMm7mIoeCZuu0AF4Easv8PrjWiQzt9vHSVRdlrdLSAQCz0ta2qMCs0I1u6s3iNvhlVCaAy2PwhzaOynd44EgGsq0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB8602

Add CONFIG_RV_EDGE_STAT, an optional feature that records how long a
monitor's automaton dwells in a state and exposes it per edge through a
per-monitor "stats" tracefs file.

The facility uses a static per-CPU matrix and reports, per edge and per
CPU, the count, summed dwell time and maximum dwell time. Only the owning
CPU writes the counters, so a reader snapshots them with local64_read()
with no IPI and no locking on the accounting path.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 .../trace/rv/runtime-verification.rst         |  26 ++++
 include/rv/edge_stat.h                        | 135 ++++++++++++++++++
 kernel/trace/rv/Kconfig                       |  12 ++
 3 files changed, 173 insertions(+)

diff --git a/Documentation/trace/rv/runtime-verification.rst b/Documentation/trace/rv/runtime-verification.rst
index c700dde9259c..88ea04ff64be 100644
--- a/Documentation/trace/rv/runtime-verification.rst
+++ b/Documentation/trace/rv/runtime-verification.rst
@@ -229,3 +229,29 @@ For example::
    nop
    [panic]
    printk
+
+**monitors/MONITOR/stats**
+
+Present only when the kernel is built with CONFIG_RV_EDGE_STAT=y and *MONITOR*
+is a per-cpu deterministic or hybrid automaton monitor. The file exists while
+the monitor is enabled and reports how long the automaton dwells in each state
+before leaving it, timed with local_clock() and accounted per outgoing edge and
+per CPU.
+
+- The first line is a header naming the columns.
+- Each following line describes one edge on on one CPU::
+
+   cpu edge label count sum_ns max_ns
+
+   *count* is the number of times the transition was committed, *sum_ns* and
+   *max_ns* are the total and worst dwell in nanoseconds, and *label* is
+   "state:event".
+
+The counters are reset each time the monitor is enabled.
+
+For example::
+
+   # cat monitors/wip/stats
+   # cpu edge label count sum_ns max_ns
+   0 0 preemptive:preempt_disable 4210 95501200 183200
+   0 4 non_preemptive:preempt_enable 4208 3812900 42600
diff --git a/include/rv/edge_stat.h b/include/rv/edge_stat.h
index c5f04fd34aee..aff00c6fbb39 100644
--- a/include/rv/edge_stat.h
+++ b/include/rv/edge_stat.h
@@ -8,12 +8,18 @@
 #ifndef _RV_EDGE_STAT_H
 #define _RV_EDGE_STAT_H
 
+#include <linux/args.h>
 #include <linux/atomic.h>
 #include <linux/bug.h>
 #include <linux/compiler.h>
+#include <linux/percpu.h>
 #include <linux/rv.h>
+#include <linux/sched/clock.h>
+#include <linux/seq_file.h>
+#include <linux/tracefs.h>
 #include <linux/types.h>
 #include <asm/local64.h>
+#include <rv/automata.h>
 
 #ifdef CONFIG_RV_EDGE_STAT
 
@@ -64,6 +70,135 @@ void rv_edge_stat_account(struct rv_edge_stat *s, u64 dwell_ns)
 	}
 }
 
+#define DA_MON_EDGES CONCATENATE(da_mon_edges_, MONITOR_NAME)
+
+static_assert(STATE_MAX <= (1U << RV_STATE_BITS),
+	      "automaton has more states than the packed state word can hold");
+
+#if RV_MON_TYPE == RV_MON_PER_CPU
+
+/*
+ * Static storage avoids allocation lifetime races. Only the owning CPU writes,
+ * so readers can snapshot counters with local64_read().
+ */
+#define RV_THIS_NR_EDGES	(STATE_MAX * EVENT_MAX)
+
+struct rv_this_edges {
+	struct rv_edge_stat	edge[RV_THIS_NR_EDGES];
+};
+
+static DEFINE_PER_CPU(struct rv_this_edges, DA_MON_EDGES);
+static struct dentry *rv_this_stats_file;
+
+/* Called before tracepoints are registered, so memset cannot race an update. */
+static void rv_edge_stats_reset(void)
+{
+	int cpu;
+
+	for_each_possible_cpu(cpu)
+		memset(per_cpu_ptr(&DA_MON_EDGES, cpu), 0,
+		       sizeof(struct rv_this_edges));
+}
+
+static int rv_edge_stats_show(struct seq_file *seq, void *v)
+{
+	unsigned int e;
+	int cpu;
+
+	seq_puts(seq, "# cpu edge label count sum_ns max_ns\n");
+	/* Include offline CPUs and keep output stable across CPU hotplug. */
+	for_each_possible_cpu(cpu) {
+		struct rv_this_edges *m = per_cpu_ptr(&DA_MON_EDGES, cpu);
+
+		for (e = 0; e < RV_THIS_NR_EDGES; e++)
+			seq_printf(seq, "%d %u %s:%s %llu %llu %llu\n",
+				   cpu, e,
+				   model_get_state_name(e / EVENT_MAX),
+				   model_get_event_name(e % EVENT_MAX),
+				   (u64)local64_read(&m->edge[e].count),
+				   (u64)local64_read(&m->edge[e].sum_ns),
+				   (u64)local64_read(&m->edge[e].max_ns));
+	}
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(rv_edge_stats);
+
+static int rv_edge_stats_create(struct dentry *parent)
+{
+	rv_edge_stats_reset();
+	/* RV_MODE_READ is private to kernel/trace/rv/. */
+	rv_this_stats_file = tracefs_create_file("stats", 0440, parent,
+						 NULL, &rv_edge_stats_fops);
+	return rv_this_stats_file ? 0 : -ENOMEM;
+}
+
+static void rv_edge_stats_remove(void)
+{
+	tracefs_remove(rv_this_stats_file);
+	rv_this_stats_file = NULL;
+}
+
+/* A zero timestamp marks resets, which can run on a different CPU. */
+#define da_state_entered(s)	da_state_pack((s), local_clock() & RV_TS_MASK)
+
+static __always_inline void
+rv_edge_account(da_state_t old, da_state_t new, enum states curr, enum events ev)
+{
+	struct rv_this_edges *m;
+	u64 prev = da_ts_of(old);
+
+	if (!prev)
+		return;
+
+	m = this_cpu_ptr(&DA_MON_EDGES);
+	rv_edge_stat_account(&m->edge[curr * EVENT_MAX + ev],
+			     (da_ts_of(new) - prev) & RV_TS_MASK);
+}
+
+#else /* per-cpu accounting off for this monitor type */
+
+#define da_state_entered(s)	((da_state_t)(s))
+
+static __always_inline void
+rv_edge_account(da_state_t old, da_state_t new, enum states curr, enum events ev) { }
+
+#endif /* RV_MON_TYPE == RV_MON_PER_CPU */
+
+static __always_inline bool
+da_state_try_commit(da_state_t *word, da_state_t *old, enum states next,
+		    enum events event)
+{
+	da_state_t prev = *old;
+	da_state_t new = da_state_entered(next);
+
+	if (!try_cmpxchg(word, old, new))
+		return false;
+
+	rv_edge_account(prev, new, da_state_of(prev), event);
+	return true;
+}
+
+#else /* !CONFIG_RV_EDGE_STAT */
+
+/*
+ * Feature off: only the hooks the DA/HA layer calls are provided, as trivial
+ * pass-throughs. da_state_t is a plain state word with no packed timestamp.
+ */
+#define da_state_of(w)		((unsigned int)(w))
+#define da_state_entered(s)	(s)
+
+static __always_inline bool
+da_state_try_commit(da_state_t *word, da_state_t *old, enum states next,
+		    enum events event)
+{
+	return try_cmpxchg(word, old, next);
+}
+
+#if RV_MON_TYPE == RV_MON_PER_CPU
+static inline int rv_edge_stats_create(struct dentry *parent) { return 0; }
+static inline void rv_edge_stats_remove(void) { }
+#endif
+
 #endif /* CONFIG_RV_EDGE_STAT */
 
 #endif /* _RV_EDGE_STAT_H */
diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
index 3884b14df375..3045037fb36a 100644
--- a/kernel/trace/rv/Kconfig
+++ b/kernel/trace/rv/Kconfig
@@ -59,6 +59,18 @@ config RV_PER_TASK_MONITORS
 	  This option configures the maximum number of per-task RV monitors that can run
 	  simultaneously.
 
+config RV_EDGE_STAT
+	bool "Per-edge dwell-time statistics"
+	depends on RV && 64BIT && DA_MON_EVENTS_IMPLICIT
+	help
+	  Record per-edge dwell-time statistics for per-cpu deterministic and
+	  hybrid automaton monitors and expose them through a per-monitor
+	  "stats" tracefs file. This times each monitored automaton transition
+	  with local_clock(), so leave it off if you do not need the
+	  statistics.
+
+	  If unsure, say N.
+
 source "kernel/trace/rv/monitors/wip/Kconfig"
 source "kernel/trace/rv/monitors/wwnr/Kconfig"
 
-- 
2.43.0

