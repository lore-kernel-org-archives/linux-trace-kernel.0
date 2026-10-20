Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792490128;
	b=P28K25GyM4FfhDQuquM60ii6asnArvGRUQ3iuBHRzuXAQXVv1MW4jDhNA65Xpk0U72mH
	 wycTwB6+6rTBMZIJtn+XwLNNfrFpmrAMCMvLsVPJAVwsyPGQk/SjnfrQ4D4KvOI/se9K+
	 edY/+GGNfRDcFpbaDJj5xrG/+08SN2E3iegbRosgzdRelsuGO2mfShJo6IIvkrFgaRaP0
	 6sthmzYdzcgkXNBa79p56togVi7AJfBOlT3+QFRVdPpQQNQFireiL2MAPfj+dEGb9Ai2v
	 TJmxGdII+TAS9xsnKL0sSRnIJl2YNgdNbpfxBJ++SYaJ4MER/+/WSM0CjFLrytSxubQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792490128;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=Wf+vI+fNt1I5LEGhBbDWxOtDifbUyPlbbGY96HTLVYc=;
	b=JSjpunxFcixF4qeljZp01LUZkZFN21pBXk/M77ztEPswNqz3lW+jw9MEnvsmlatG8HZs
	 BYeSFU9ZrQhfFbFnBBa0Qo2i9pW0DxCzuTQS5fjDqccNHTr5iVZ669FmjUHrd6BmJ3eo8
	 WWhtn39sP2Ct9bfQKhyevh2EPHwdZo6IUlfbWywX8LfK/GoX9OI+eF69SRNJeyFtyJV/p
	 bnd3xpheltSXtaoRUIJCriYHmJMsVTwV9wfFuQghtlTqu2+w+xj0SDqjDSP4XEm5ftCeS
	 3bfAKOFaPRYLup47hwp1ulm6fe+XQqAn+7LUeWKEUB7ebW5Qffto51JJcKKOcE9NKmA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=djSugvjy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.12
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013012.outbound.protection.outlook.com [40.107.159.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87471606A329;
	Tue, 20 Oct 2026 09:55:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87471606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=djSugvjy
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fb+nmG9JkpGqFsumfFlfpPbmxVo/wmQGtwAjcz+kh9YBEkZM7UsGuCfUi3oumUusMgUIgO+kSDSRHE9+E1VP4qLVAEz9XGCCDozrEXFg1V4V+QzmmBILsK2+CBlgE58sYwvZ+8mSI4/U2RsuVW37Keqs+I7wp443cYcyTs+3Z6Edh7UWkI6LgBo7nD12BtMNPSBRrGNg1QdiSIQX6GrkMxC6yvuoPNuUX1TyCGktS3LMKOJRGRzE08MQerkEfIIlC86uP/TxWj04tksfpgIotv/Fxy7fsUdzSZJEM4TLNTyFzTEQzGNGYFYmpv1TrzogMBhmFKIMAjhNTR6xXkjXtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wf+vI+fNt1I5LEGhBbDWxOtDifbUyPlbbGY96HTLVYc=;
 b=s2B/elQUQCMf9dLeLzWd0NJg2mE31kV4cWIexXhbYX+5xUcTmYWbfRDtFoUolE5GzgkTm+5jDNOaqz2LXjWN5HqageObBDvDi3Crh1lGW8hjztykeUOjhodoXAPLqfMpeUcejQgMlckF6mzoSmJkPsK7GxGwOoRpX1cNFhEg5XWfatcnyb8dkfl76JNxu5m+eWuY0z+l2NJjrzFk8IvtMUODYYcyEdpRRYMvvkAsUNSnYdWW2nxDicfNQSJBfKHbHbLxhh0khC4xioJDchvGyX0oowQq7qItu0mn5m7wwchXAzHSdiMQKO5QamdtFbdDnYGP3XvHH0f4LnR3RdTn0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wf+vI+fNt1I5LEGhBbDWxOtDifbUyPlbbGY96HTLVYc=;
 b=djSugvjyp8RjOQSwHUvI81mOnnP55HuUW8m1e5ssOSn8q7EO70Ef3G+bmbGkScbaPATV6zdvZvgCPCkLrJkIVVpWn/G/yVyJIdm+zkIcNb32OmJZjPUsGZ/ANznjWrFqhN4pySa/1Mw4Ss7QSscLZg0Nz4EENsP6UQULUMkYQQkr+CEqyoe1U82/olyA7zjH3JMeEo/09K2EulNx0sUbeR5wwqVrt7j8N68FYiAeToEiBWx2L3sCi5OWk3DxafzGmmo7DOaSm533U1q+AJG9xYPNIQKSAq+SyARi5Zdg1Q9WhNfybE42yJM3TZNOBBaoFUrrzJj6kdTNNFppMuWqDA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by DB4PR10MB6047.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:379::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 09:55:24 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%6]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 09:55:24 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rpm@xenomai.org,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH v3 3/4] rv: collect per-edge dwell time for per-cpu DA/HA monitors
Date: Tue, 20 Oct 2026 11:55:11 +0200
Message-ID: <20261020095512.863754-4-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261020095512.863754-1-tobias.schaffner@siemens.com>
References: <20261020095512.863754-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0241.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::19) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
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
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|DB4PR10MB6047:EE_
X-MS-Office365-Filtering-Correlation-Id: 18c46ad1-bdf7-4bbb-0084-08df2e9042a1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|10070799003|23010399003|1800799024|7416014|55112099003|18002099003|22082099003|10067099003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	MuskfAg7YBCiKx5xvP0VzR2UrQXVdXNB1WAB2rLJoFap/G5wdAeEl8lT4Bud9A/iSKs8Wky+rqihBHL3wcJTlEj3Vp2gXU0y5QxrZA5Hzuw+7dveDa1bTB28RpSq4UEUaYoSvYH3DAUSARi2ERFmchn0/eLZ1irZaT5si/18K6NLyZ+6Z7WtxzvYMqzB1Nj/R7sTvWI4BAWQsxODt2lAOKw18DXfnSAZtd26Q0WhTdI2Vj6wRkM301NGN0gHFloxn/tsuY9t13rVPsWWjwuer67qwnepNcC04qau/3ZRGLyshFSwMoxxtIGLp9QWUHlBWuhbSQP7hM/PYae6ihDWVoRlDfSPkPf0hCR5i1HgKOAPEg7lDaIV87b9faznSERIhSY5H54mAaAQNOTPmPaBCS830U9nCKEPOIPeZ4Z5AsgyCh5DMPyMe5nf4PO/5dgJzpI4peUcMYGpZxO123wuquSq1pvaPzFfw6AxNUmddCK48QYblpRmd+X5axeC1Ocz0yXN8EnZNfg+y8qQ4FXpMtlQUaz1SOW4urQ1+Qr4uA9BtJKUWVtxnwdm5IFuIKZ4OhjVPuhe317s3FCALlzzYlutrjyfCs39s0y3+blPX7JYy78o/JiCAuX9rR8qg898jILGbSZLTjUqkUaNoiEXindaxiuJOky63/vTrkokJLU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(23010399003)(1800799024)(7416014)(55112099003)(18002099003)(22082099003)(10067099003)(261009223027099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1RZnu3BSCcgW2LFAesJ4D6Brpj7Qr1/k+QUwj7d6D3IVKWeUzMRrIZJER8k7?=
 =?us-ascii?Q?JePvuR8/QpIXqjRtLUCqAA34XVqakweXS+haMSRWVARSWxF3AilRXYkU2D61?=
 =?us-ascii?Q?OijbfuLQjW094F1eqANgbomPoDh04bjXivq0zBJ2dJjwX836gsWVQSj5H0eK?=
 =?us-ascii?Q?4CbjpfbHkVdpO2fTxKIe33Ib9iWHb/tCe5TZBGfPbkTgoZ0doKsbWLwWdwns?=
 =?us-ascii?Q?fs62c9i2L09nexKJlkG8dOm8EGQtnFznL3Il27mj66BCl0tyF5UbHNFCbXzP?=
 =?us-ascii?Q?wdQhP9CqnIO1DDk3PCa9E35pYpgNM1eh4xwumpyCP1nvMn+pq9+HFOY6UU2h?=
 =?us-ascii?Q?d4ACcCNZEQdgN3u/ly9CqHAoa7jGATGww7HpcVQG34kcy8+96kba3LJmRNjE?=
 =?us-ascii?Q?suErMzcF27QxPszHL+GC2XhmO7tFIckk5ueQaFMEGrUND8cjo0DTPs1iXLQG?=
 =?us-ascii?Q?iUMzl9vtqJ0WRJ1iN52S89FN05bP0vdUMBg2Tb9mOxpS3Gu6FUSVtIhLzX6x?=
 =?us-ascii?Q?jb6HUX5eGKmf+1J9MxQXHUTDPvPLOer85ficfdeCCTC/DwmpqpSJrukHWqu6?=
 =?us-ascii?Q?vi6TVQvyNxh4nT1gnMfd+aeuyc4fnar3OSzgkVlLAawjv7sO2sQgq/K5ds4u?=
 =?us-ascii?Q?If4IupGkq3vc9RmbChF3kzaYi0kHehFpqV3lx5yZNG5Q3gsB9mvLAJwyyySF?=
 =?us-ascii?Q?ViNlvdsKfqodiOxttH5siQxAX/Zkp4NFATpt2pPB1e69vXWqqN07joX7SrKC?=
 =?us-ascii?Q?XN0s+mwhHID3E5dfd9v7lf4XhVXZk36NeF9H2tc5idD3mPLEJfuOkTPiTOA8?=
 =?us-ascii?Q?6Yoxmo0PSUtgJz443chn6qpnZhBXVoTcbFrkVGJzYdDqElWzsD1KdVqBhs+J?=
 =?us-ascii?Q?9a5nVkKaYeCSzb7nW/HkMLUjB2PuTY07Ujmmmq+9n7XhcHQ53g8VGZwJmEYQ?=
 =?us-ascii?Q?fmQzpcrfTt9DnQ/n0IHjItXUz44zjbtPAu0G59VTGyENVMr6FYJMlRLnrfTK?=
 =?us-ascii?Q?pmpYFabRPj1//p5kLuxYwMGfmIIQ70Hr5UV1AR1uO1kLD7aDrj0SyhCKg7T9?=
 =?us-ascii?Q?+N7cUDiOd2WdQv3o7joR/d5sikDoG/sRMZTWBq9fFfaUJiZV7BAFraq0y5u5?=
 =?us-ascii?Q?QlfSPT4sXR0yNq0rW66Zobh/UVyNMmEq7zoZ5VBfXNfKy2KaO2da/r0+zjry?=
 =?us-ascii?Q?SaM1IGTIKrnO30zMc/d5PMmAmab5abi1F7LpwPk1G8UhonyH/SWKOz1RonK+?=
 =?us-ascii?Q?bmiGjOdF9pdq9eT6GowcoFbaJxC9c5n8ZvF5rfCAiCPhtAX0YS9pRC/PEfC4?=
 =?us-ascii?Q?0eW/geb5viXNtTWgLNHq6u0A0tZheGROxw73mO6YuALkhkb4D4tvQxqYMliU?=
 =?us-ascii?Q?rFiJY/JqCk7T72I/WANl+9RuuN0LQ+n71rXsKJAyjUI+mW+v2ReHCLd3YyeN?=
 =?us-ascii?Q?QQf1OjEJ/et2Fz6OostwrkSZTPB1DhyORr9HrA52xcZf7PTuY+i2aVW0gRHP?=
 =?us-ascii?Q?5MNFqJAR1jqtBIe9RjOe1y/hgZJoFwhtMUvh1xmvPV7V7e6cv2LDYsYVPaZw?=
 =?us-ascii?Q?H8igAnhFYFWGAjRCoLBMnfUA5bcJLnzM8zQSR6NYC1faqZyLVgr/coiGsHqa?=
 =?us-ascii?Q?12uT+US26JSQAjDAbQWSUzKkesJ5r2+lVbPjVS6Nj7LS5Jb41t/Bdb/6vk7S?=
 =?us-ascii?Q?2E3Y4qfvdAijvyF/zMrrigWMJTopenf2T+/aeL17+4Ep0vvlqqfRgP5kf1R5?=
 =?us-ascii?Q?4PqlFLclVe1qh2vc53lBrQL4ARP6vW+aif9xZ/9EkfJLg1MqO62KdtSg3Ghq?=
X-MS-Exchange-AntiSpam-MessageData-1: aZ0RuCDFigF9Ww4fTUWy2x/BJUo9+yDgTtc=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18c46ad1-bdf7-4bbb-0084-08df2e9042a1
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 09:55:24.1516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yoy6QHi3aW9MC7EDmKfhfY0N/mQoeKb6Dn7RgKkpsfJyF73gZ0IHEKdXnhrVgjjs6dzoZ9mp4LJxcm7+/fj6dosVl9hcnUyM8SMaRZm1Wwk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6047

Hook the edge-stat facility into the DA/HA layer, so that any per-cpu
automaton monitor also reports how long it lingers in each state.

Account a transition as soon as its state change is committed. An HA
constraint that rejects the transition can therefore reset the monitor
without leaving an accounting window for nested events.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 .../trace/rv/runtime-verification.rst         | 28 +++++++++++++++++++
 include/linux/rv.h                            |  2 +-
 include/rv/da_monitor.h                       | 16 +++++++++--
 include/rv/ha_monitor.h                       |  2 +-
 4 files changed, 43 insertions(+), 5 deletions(-)

diff --git a/Documentation/trace/rv/runtime-verification.rst b/Documentation/trace/rv/runtime-verification.rst
index c700dde9259c..012bb037c323 100644
--- a/Documentation/trace/rv/runtime-verification.rst
+++ b/Documentation/trace/rv/runtime-verification.rst
@@ -229,3 +229,31 @@ For example::
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
+- Each following line describes one edge on one CPU::
+
+   cpu edge label valid count sum_ns max_ns
+
+  *label* is "state:event", *valid* is 1 if the model defines the edge and 0
+  otherwise, *count* is the number of times the transition was committed, and
+  *sum_ns* and *max_ns* are the total and worst dwell in nanoseconds. An
+  invalid edge always reports a zero count.
+
+The counters are reset each time the monitor is enabled.
+
+For example::
+
+   # cat monitors/wip/stats
+   # cpu edge label valid count sum_ns max_ns
+   0 0 preemptive:preempt_disable 1 4210 95501200 183200
+   0 1 preemptive:preempt_enable 0 0 0 0
+   0 4 non_preemptive:preempt_enable 1 4208 3812900 42600
diff --git a/include/linux/rv.h b/include/linux/rv.h
index 1dc7c45f476c..6c5c2fa7dd68 100644
--- a/include/linux/rv.h
+++ b/include/linux/rv.h
@@ -33,7 +33,7 @@
  */
 struct da_monitor {
 	bool		monitoring;
-	unsigned int	curr_state;
+	da_state_t	curr_state;
 };
 
 #ifdef CONFIG_RV_LTL_MONITOR
diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
index 6fc5ef8142ac..c8f7497800d0 100644
--- a/include/rv/da_monitor.h
+++ b/include/rv/da_monitor.h
@@ -17,6 +17,7 @@
 #include <rv/automata.h>
 #include <linux/rv.h>
 #include <rv/kunit.h>
+#include <rv/edge_stat.h>
 #include <linux/stringify.h>
 #include <linux/bug.h>
 #include <linux/sched.h>
@@ -113,7 +114,7 @@ static inline void da_monitor_reset(struct da_monitor *da_mon)
  */
 static inline void da_monitor_start(struct da_monitor *da_mon)
 {
-	da_mon->curr_state = model_get_initial_state();
+	da_mon->curr_state = da_state_entered(model_get_initial_state());
 	da_monitor_init_hook(da_mon);
 	/* Pairs with smp_load_acquire in da_monitoring(). */
 	smp_store_release(&da_mon->monitoring, 1);
@@ -276,6 +277,11 @@ static inline void da_monitor_reset_state_all(void)
  */
 static inline int da_monitor_init(void)
 {
+	int retval = rv_edge_stats_create(rv_this.root_d);
+
+	if (retval)
+		return retval;
+
 	da_monitor_reset_state_all();
 	return 0;
 }
@@ -287,6 +293,7 @@ static inline void da_monitor_destroy(void)
 {
 	da_monitor_reset_all();
 	da_monitor_sync_hook();
+	rv_edge_stats_remove();
 }
 
 #ifndef da_implicit_guard
@@ -689,9 +696,11 @@ static inline void da_trace_error(struct da_monitor *da_mon,
 static inline bool da_event(struct da_monitor *da_mon, enum events event, da_id_type id)
 {
 	enum states curr_state, next_state;
+	da_state_t old;
 
-	curr_state = READ_ONCE(da_mon->curr_state);
+	old = READ_ONCE(da_mon->curr_state);
 	for (int i = 0; i < MAX_DA_RETRY_RACING_EVENTS; i++) {
+		curr_state = da_state_of(old);
 		next_state = model_get_next_state(curr_state, event);
 		if (next_state == INVALID_STATE) {
 			react(curr_state, event);
@@ -699,7 +708,8 @@ static inline bool da_event(struct da_monitor *da_mon, enum events event, da_id_
 				       model_get_event_name(event), id);
 			return false;
 		}
-		if (likely(try_cmpxchg(&da_mon->curr_state, &curr_state, next_state))) {
+		if (likely(da_state_try_commit(&da_mon->curr_state, &old,
+					       next_state, event))) {
 			if (!da_monitor_event_hook(da_mon, curr_state, event, next_state, id))
 				return false;
 			da_trace_event(da_mon, model_get_state_name(curr_state),
diff --git a/include/rv/ha_monitor.h b/include/rv/ha_monitor.h
index 6e1c7fe5449a..78d1bb80aefd 100644
--- a/include/rv/ha_monitor.h
+++ b/include/rv/ha_monitor.h
@@ -312,7 +312,7 @@ static inline void __ha_monitor_timer_callback(struct ha_monitor *ha_mon)
 	if (unlikely(READ_ONCE(ha_mon_destroying)))
 		return;
 	/* Ensure consistent curr_state if we race with da_monitor_reset */
-	curr_state = smp_load_acquire(&ha_mon->da_mon.curr_state);
+	curr_state = da_state_of(smp_load_acquire(&ha_mon->da_mon.curr_state));
 	if (unlikely(!da_monitor_handling_event(&ha_mon->da_mon)))
 		return;
 
-- 
2.53.0

