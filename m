Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795779356;
	b=t8pTLrzB417N2q/Rr3sGzsof0llwIpIhqUU8qdVnjioSq74U9JsTsf+clc/Tg4/mh5pf
	 pnHJUbdMlC0Ex3VHDtFonPM4gno3ddb9gRDLiBtbn3T/o9/fGb9zwdq6IgHNXzuDB1z6K
	 K6aBpc56XQly7fJd3c4p8ibRqc6YZkVXsQWQ7RmLBCV1csXL2dEAvNXBTzCHGp3EgWJMY
	 UBY/tli6dM753Tgq3hd/iYgtlc3H6EPJmkNza0mbJGSZiZ6N0ez3eV08rYt4qR+bpAcOb
	 UXzNeOCfTwN96PPaABzwRN6qytMiYcYdDwhLs6kfngXx5+EWkNDKaSq5bRcS49Uk8Xw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795779356;
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
	bh=kS2UVUUMeeXYXkRssLv/FaG0DCanROGj51LmIOGykhM=;
	b=Th+YIbFkbnDMLbY9MsPizTzKrC5FCZmc7LKS5aTj14TvlvtTHxFVBD2Oqfx5zHLNSoT7
	 84/rCu9NoZVKiRT1YxQCHKTt5/j0Pa07Fs2lCYYVBjSs/1ezAwP4MQlddazcAzjfrXaan
	 Oicbf3Plh5DzbWF5CjwIyc0PuRyuyaC+RjHP1OM9/LAIB1K7BwTiCH7uofQ+xcsvAo6gl
	 KWLDufaHPIUDXb3QQ/j5OHPtNQ5yS66CvuST9i1CQvB4qW7vhckbqqKX3yG0MCSRhB9fr
	 at0PqdfKkoZS7P5Dj9qcpoVZIYW3QqxE1ihaQnCM/W48gejDUFViN+zkzxQUOHvLuwA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=ZtzAHniR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.12
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011012.outbound.protection.outlook.com [52.101.70.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154BD606A687;
	Fri, 27 Nov 2026 11:35:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 154BD606A687
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=ZtzAHniR
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lo6ZCk/pMsY/LHhiQG05qmMtRtrj0okhuVAf2JTp7RF29HuO5Khl7owhJD114jX2w/QFBdbJ/IMhsD4MT2wgj6s7Qj5796mLxXdkPJbK4yAokVEZWo37CbQUpE4jObIgq86AiHdDuzk/zvS8xdtc52uFcz4jj44PbwSNIw3fYZSMLt3erdrgmr/UL3QaC+k29NIcX+n5wyZpPFZ1EUs/Dwl7SCFmzWb/eS6a/QCpTvStXyzn5tVgE0LcjPWrPMx8ZGDjADmBfyb4hzbe8DGWm+aNlyU7LGimmnuI+dSjQMmRT2Lc9WaSslHKSSyRvypAYQon64ZHc9OLkXddXZLEqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kS2UVUUMeeXYXkRssLv/FaG0DCanROGj51LmIOGykhM=;
 b=Gzn4F4PqiSarc3l4QvIxEHK/Xs54YDqD+HIlH/jLNsLcvrNhbm+wHFd9fJcxr9Bqf/sCFHwiJFMqD1qxFeIkqBnkDtqG38u67bMfn0wEFfVPkVkTjohD/MTEqCoia7GMtnyZNI4kHBvUNH+0cYSLEd5zVtlbkfXwSfTY3fw186t9bOdvzTbdpkV1bJkPdQ4/NTLskdT2cFsPyxBTP6jTsylkSoWIkxhZEzLTkEMvRqkd8FF+vOuRasUihfX+y8PUi6E93fe/2P2DFsgsjStpnLIryVjELORjFVXqZLJbc4ReBq6hW8PB72I4UEQrekwN4LP2kr1YgIeNI0FwqY/PnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kS2UVUUMeeXYXkRssLv/FaG0DCanROGj51LmIOGykhM=;
 b=ZtzAHniRXVUNmlgZ19im58JW9SExrauunUA6UHO+9QmL+quq03+ksRGZQHYVOJYwvIJBYrTk0a/FitSLc7td/CiOARuCAIq4J0gfY98tKKw0zvM3dLszCThig5FVU6fb1q4qZlciTpJE5PzMcFvQKan138fX5d07wQrdmymMRGDw/54rj/v8WZtHajG3chFuaIHfly6fBRXIW63Wr9vOak7F3HAIlVBzR09u/K/HggqARgPGMf2II+LDHxVDbeuHs6qSyW7bw3+dDZI/tRk874rMTIslIF1769z3uaiZ4DgyI90sJmGT66TaO33OLkCHz9JZk+TZYdrqCBYuKBrHMg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by AS2PR10MB6425.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:544::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.688.5; Fri, 27 Nov
 2026 11:35:53 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%6]) with mapi id 15.21.0688.001; Fri, 27 Nov 2026
 11:35:53 +0000
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
	Tobias Schaffner <tobias.schaffner@siemens.com>,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH v5 2/4] rv: add per-edge dwell-time statistics
Date: Fri, 27 Nov 2026 12:36:07 +0100
Message-ID: <20261127113609.650286-3-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261127113609.650286-1-tobias.schaffner@siemens.com>
References: <20261127113609.650286-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0176.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::7) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|AS2PR10MB6425:EE_
X-MS-Office365-Filtering-Correlation-Id: a135be1f-4a45-4fc3-8637-08df4c7a9827
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|23010399003|1800799024|10070799003|11063799006|5023799004|6133799003|261009223027099003|22082099003|18002099003|3023799007|10067099003|56012099006|261026140227099003|261026121527099003|261028144727099003|261022105027099003|261102123227099003|261021121427099003|261021123027099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	e3i0PQW+zbSG0jZYbt0c2JrR4TjCcWtf4/8iPl6UPMZaMFUt42GP6HV8yc1CWuyaM9cIcKK/HNqM1AfZKGwD4ZF0WZe+LZ+BUMwJuxRvbN8UCdyogMOpy5WEydnvPVlKYFgjMlFypNi9AO8dkZtPsHReIkJzFp8U2572PPW7Kkpm2UwRd/zK90aVfA98KsQHm+95kdo5MCCdasma7PEO6wPBx9Zt7h+Xg2mYIOXGawEjJ9990/dNnE+KLH7q0kWAxu9aJTyOZdNTNXQFKJGYBlACQ2ibVvkVpYasOp6BgaAvbKz/yoAnT9KtEFKPdvCmBiC1eC9jJzStrxZXy+oD14+YUvtTAcCyjKBj+7O1Jb78fnpq51OmAX/T/G/ITrkGyDqXtH86XxK/TbsYBbecxG3XIz66M+nDA6FmfDy6adxPvGeHS1rLzK//lB+OSNymY9CJe6NxBBe+qFz+KZbfMS7yGrVJuvFWIKf+XZUptYA5LTe8RVpSJiLgPIR88AMpBEiFGorI1GVgQRgAgvcQtqiOzrnwcUPk6T833X67awvgmcS5gT2L1YVz/wXuf6riCf+tzuhqoO4okYkJqU/N0OBRjh+paAOAQyn7Ls+xzjhus3ZlN0joP7QW8xRYaU7G6tpJg36EclZwOOo9Pa6IO4VHfZ5sUEupXOp7201efoI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(23010399003)(1800799024)(10070799003)(11063799006)(5023799004)(6133799003)(261009223027099003)(22082099003)(18002099003)(3023799007)(10067099003)(56012099006)(261026140227099003)(261026121527099003)(261028144727099003)(261022105027099003)(261102123227099003)(261021121427099003)(261021123027099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9FVnu28PyKUVFoHkj1hpHVLElV3DYcB9Rh30Wat5sEguXl+SvnzanBSJIoHM?=
 =?us-ascii?Q?UQ0edRqu8WIYp8Sy73IVgyg6uNHobQ40uU3U3dwllzThtbG1ROzB8L6wPdyA?=
 =?us-ascii?Q?X7SJTJWn6pbI7dDXI8VukA6g8tdUv4gLtDRSYlYgM3s8+QW3XSudVNOPSp+j?=
 =?us-ascii?Q?Xp6xR9yDlQceWZaBgo9AFYJejA17iMSc0GFV8Kte/kB5fi1Vf3Dj0iMIqGP3?=
 =?us-ascii?Q?hpfTG+4VG6PYPdqRkh/ePggUi8hUWzBk2jNloPQ5cu7RdSCPBx2bTF2LN2tV?=
 =?us-ascii?Q?510oRWLjle0h2C9oqowIqU+knq/Gv1P4UK2tz3uRa4M2EOgEjqXWbf63HhcJ?=
 =?us-ascii?Q?DDLOMP6tNvJbbVyUnmhZHJMdxs21RLdNl5I2xCpm+LpLpkpKs2wsKZQFrHaC?=
 =?us-ascii?Q?r1u+CCXE38Z7ncJ9/KuDQOrhPJ6ibHaa7fJHSGEI6EP0HVkdid3/1Nb01eE+?=
 =?us-ascii?Q?qi05UHLM4KDA4WL1L831KLlg747IVfBbSUKMRo7Nu8zZSvV7hfokXKxnkH2o?=
 =?us-ascii?Q?KukyNPR8c2VO49e6+0CTzUzfUiP8vuj83WIEt3aZhrdx6E6pLYV31idxPnSO?=
 =?us-ascii?Q?ea0KSXCIyNuzgvTXC5BGNM2XHteOJnbpq7lwarROuVVqiwmQcHxDXIxH/i5R?=
 =?us-ascii?Q?uaNuSqxxw1K/vq32dgIw6jBYDSoPjbVgeo/K4cCHSgkrPzTwpOGcPo/kXq2U?=
 =?us-ascii?Q?OoJI2KvGMhGUDn6wa6tULuBWMXJMeeDdCHWGAwewQwWOpH12praQ7f0Xtr/z?=
 =?us-ascii?Q?mbirM09/s5I8GEt7i2wF5CwWEF0JuQMVIJ7Jz2BOCfNACRexQXSjXIRllMR9?=
 =?us-ascii?Q?BdX4JJ8qY5e43Oh2fYzRyFht+Y7NJ1H2nwv7Qi5dqP21qcIwux/oFNowG3U1?=
 =?us-ascii?Q?skSyEdh97mq+vAm7sEh944A8b1EOUj96G7Gr+YviBOTSokQdcZ+lotdU42zM?=
 =?us-ascii?Q?5m40Igq1wXykeCKS4UelqQfKjdrZuF1KYGt/DKGfYtHpLnS9TEM2eU4IvtX7?=
 =?us-ascii?Q?MFcD3X6YXWWqPFv7sbI1uikXPjiJwh+S+IecElnUh3WF/L8MyVrQDF17QFin?=
 =?us-ascii?Q?jb6W2PQzz6z3UgLuGVI1YNcIFOLGtn3NEIVqk9UBj8XBcHRZqL9k608Mv9TH?=
 =?us-ascii?Q?hxO9Ra4VW/Zh7KlVGWsbwGO40BCaR3AEFddDA1caL9F1/mu9PeFh3nQFxvJj?=
 =?us-ascii?Q?OebhwoD6I+YhVNn3nsnpUw1Rn1cr0GKKyDfeD6EhwDdLyy+cOBdjJwyHh8Tx?=
 =?us-ascii?Q?PF5sv40QtzaFcKtDEzL8gDk882frt0xxYgYinbZ6EIBSfSoRe7jylyuQ6e80?=
 =?us-ascii?Q?+cfGWdCLd8l+sn0KKFSq5iyg7hsrzQLSDxUTO7TSfNVjun2j/d55rVT/HyhU?=
 =?us-ascii?Q?40h/rHdJQLMqlHU5N2GYp4ieC6Oz+Sgl1eG7CwQo2l3njk9XOI3v2brznq2e?=
 =?us-ascii?Q?QFQVe2hmUuzXz7Bm8PqTNS2vXfExatIrZZ9m6+vzRKCmAGWRrBE9ILMQxJvi?=
 =?us-ascii?Q?7puHESeQv91spu87AHBoAr1ZzUuSwPk8urBHENjlo3sCQ2cGT/6O1V5+86IN?=
 =?us-ascii?Q?sXRXgnNYZDLYXtVnZg75ezNjEwplJCmVuPjlyFoj6qQMP2fN5YXqZ2zD+CLI?=
 =?us-ascii?Q?4KpyDW29BvOIh4v096BaXwMcpW+p04yYYh6MuDnpI5aaDbBsaRx89NZLgcR+?=
 =?us-ascii?Q?O+92aFfbkojFwOISiwjKV8BDQ677p1In3zzlgAEfno9FZgI8zFPSTTAY7qLK?=
 =?us-ascii?Q?1Mf0L8Gazw0PyNV5kYZw/GnF843GF9MtRpEqYCGj8F0w60MdKUtftU9nGH/E?=
X-MS-Exchange-AntiSpam-MessageData-1: UvbNc83pMdYGZzdPYEEadD6HJTFzE6LDzFg=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a135be1f-4a45-4fc3-8637-08df4c7a9827
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 11:35:53.3903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VUmR/jPvnGkGgcc+BM7wlhrhp2zSWp0CxXbEhyOm8+tUQubAolybrmaShaoda7I2aarPBMdk5umQuGdaTF+siE13zoQ5k7RcjvCWHyTlHC0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6425

Add CONFIG_RV_EDGE_STAT, an optional facility that records how long a
monitor's automaton dwells in a state before leaving it and accounts that
dwell to the edge it leaves by.

Keep the state and its entry timestamp in one word so a transition commits
both with a single cmpxchg and nested transitions cannot charge a dwell to
the wrong edge. This requires a native 64-bit cmpxchg.

The counters are per-CPU and lock-free, so a monitor's hot path can update
them without disabling interrupts and without perturbing the latency being
measured. Only the owning CPU writes them, so a reader snapshots them with
local64_read() with no IPI and no locking on the accounting path.

Storage is a static per-CPU array of STATE_MAX * EVENT_MAX edges per
monitor, exposed through a per-monitor "stats" tracefs file. Report whether
the model defines each edge, so a count on an edge that should never be
taken is visible. Nothing uses the facility yet.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 include/linux/rv.h      |   7 ++
 include/rv/edge_stat.h  | 211 ++++++++++++++++++++++++++++++++++++++++
 kernel/trace/rv/Kconfig |  12 +++
 3 files changed, 230 insertions(+)
 create mode 100644 include/rv/edge_stat.h

diff --git a/include/linux/rv.h b/include/linux/rv.h
index 541ba404926a..bf75cf2300ee 100644
--- a/include/linux/rv.h
+++ b/include/linux/rv.h
@@ -21,6 +21,13 @@
 #include <linux/list.h>
 #include <linux/types.h>
 
+/* Edge statistics pack the state and its entry timestamp into one word. */
+#ifdef CONFIG_RV_EDGE_STAT
+typedef unsigned long da_state_t;
+#else
+typedef unsigned int da_state_t;
+#endif
+
 /*
  * Deterministic automaton per-object variables.
  */
diff --git a/include/rv/edge_stat.h b/include/rv/edge_stat.h
new file mode 100644
index 000000000000..8b99e8520e1e
--- /dev/null
+++ b/include/rv/edge_stat.h
@@ -0,0 +1,211 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Per-edge dwell-time statistics for RV monitors.
+ *
+ * Copyright (C) 2026 Siemens AG
+ * Author: Tobias Schaffner <tobias.schaffner@siemens.com>
+ */
+#ifndef _RV_EDGE_STAT_H
+#define _RV_EDGE_STAT_H
+
+#include <linux/rv.h>
+
+#ifdef CONFIG_RV_EDGE_STAT
+
+#include <linux/args.h>
+#include <linux/atomic.h>
+#include <linux/bitfield.h>
+#include <linux/bug.h>
+#include <linux/compiler.h>
+#include <linux/percpu.h>
+#include <linux/sched/clock.h>
+#include <linux/seq_file.h>
+#include <linux/types.h>
+#include <asm/local64.h>
+#include <rv/automata.h>
+#include "rv.h"
+
+/*
+ * Per-CPU counters kept in local64_t so accounting is safe against interrupt
+ * and NMI nesting on the owning CPU without disabling interrupts. Only the
+ * owning CPU writes.
+ */
+struct rv_edge_stat {
+	local64_t	count;
+	local64_t	sum_ns;
+	local64_t	max_ns;
+};
+
+/*
+ * State and entry timestamp share one word so a transition commits both with
+ * one cmpxchg. Comparing the timestamp also detects nested transitions that
+ * return to the same state.
+ */
+#define RV_STATE_BITS		8
+#define RV_STATE_MASK		GENMASK(RV_STATE_BITS - 1, 0)
+#define RV_TS_MASK		GENMASK(BITS_PER_LONG - 1, RV_STATE_BITS)
+
+#define da_state_of(w)		FIELD_GET(RV_STATE_MASK, w)
+#define da_ts_of(w)		FIELD_GET(RV_TS_MASK, w)
+#define da_state_pack(s, ts)	(FIELD_PREP(RV_TS_MASK, ts) | \
+				 FIELD_PREP(RV_STATE_MASK, s))
+
+static __always_inline
+void rv_edge_stat_account(struct rv_edge_stat *s, u64 dwell_ns)
+{
+	s64 max;
+	int i;
+
+	local64_inc(&s->count);
+	local64_add(dwell_ns, &s->sum_ns);
+
+	/* Keep the largest dwell; bound retries if a nested update races us. */
+	max = local64_read(&s->max_ns);
+	for (i = 0; dwell_ns > (u64)max; i++) {
+		if (i == MAX_DA_RETRY_RACING_EVENTS) {
+			WARN_ONCE(1, "rv: edge-stat max update exceeded %d retries\n",
+				  MAX_DA_RETRY_RACING_EVENTS);
+			break;
+		}
+		if (local64_try_cmpxchg(&s->max_ns, &max, dwell_ns))
+			break;
+	}
+}
+
+static_assert(STATE_MAX <= (1U << RV_STATE_BITS),
+	      "automaton has more states than the packed state word can hold");
+
+#if RV_MON_TYPE == RV_MON_PER_CPU
+
+/*
+ * One edge per (state, event) pair. Static storage avoids allocation lifetime
+ * races. Only the owning CPU writes, so readers can snapshot counters with
+ * local64_read().
+ */
+#define RV_THIS_NR_EDGES	(STATE_MAX * EVENT_MAX)
+
+#define DA_EDGE(state, event)	((state) * EVENT_MAX + (event))
+#define DA_EDGE_STATE(edge)	((edge) / EVENT_MAX)
+#define DA_EDGE_EVENT(edge)	((edge) % EVENT_MAX)
+
+#define DA_MON_EDGES		CONCATENATE(da_mon_edges_, MONITOR_NAME)
+
+static DEFINE_PER_CPU(struct rv_edge_stat[RV_THIS_NR_EDGES], DA_MON_EDGES);
+static struct dentry *rv_this_stats_file;
+
+/* Called before tracepoints are registered, so memset cannot race an update. */
+static void rv_edge_stats_reset(void)
+{
+	int cpu;
+
+	for_each_possible_cpu(cpu)
+		memset(per_cpu_ptr(DA_MON_EDGES, cpu), 0, sizeof(DA_MON_EDGES));
+}
+
+static int rv_edge_stats_show(struct seq_file *seq, void *v)
+{
+	unsigned int e;
+	int cpu;
+
+	seq_puts(seq, "# cpu edge label valid count sum_ns max_ns\n");
+	/* Include offline CPUs and keep output stable across CPU hotplug. */
+	for_each_possible_cpu(cpu) {
+		struct rv_edge_stat *edges = per_cpu_ptr(DA_MON_EDGES, cpu);
+
+		for (e = 0; e < RV_THIS_NR_EDGES; e++) {
+			enum states state = DA_EDGE_STATE(e);
+			enum events event = DA_EDGE_EVENT(e);
+
+			/* Edges the model does not define must stay at zero. */
+			seq_printf(seq, "%d %u %s:%s %d %llu %llu %llu\n",
+				   cpu, e,
+				   model_get_state_name(state),
+				   model_get_event_name(event),
+				   model_get_next_state(state, event) != INVALID_STATE,
+				   (u64)local64_read(&edges[e].count),
+				   (u64)local64_read(&edges[e].sum_ns),
+				   (u64)local64_read(&edges[e].max_ns));
+		}
+	}
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(rv_edge_stats);
+
+static int rv_edge_stats_create(struct dentry *parent)
+{
+	rv_edge_stats_reset();
+	rv_this_stats_file = rv_create_file("stats", RV_MODE_READ, parent,
+					    NULL, &rv_edge_stats_fops);
+	return rv_this_stats_file ? 0 : -ENOMEM;
+}
+
+static void rv_edge_stats_remove(void)
+{
+	rv_remove(rv_this_stats_file);
+	rv_this_stats_file = NULL;
+}
+
+/* A zero timestamp marks resets, which can run on a different CPU. */
+#define da_state_entered(s)	da_state_pack((s), local_clock())
+
+static __always_inline void
+rv_edge_account(da_state_t old, da_state_t new, enum states curr, enum events ev)
+{
+	struct rv_edge_stat *edges;
+	u64 prev = da_ts_of(old);
+
+	if (unlikely(!prev))
+		return;
+
+	edges = this_cpu_ptr(DA_MON_EDGES);
+	rv_edge_stat_account(&edges[DA_EDGE(curr, ev)],
+			     (da_ts_of(new) - prev) & FIELD_MAX(RV_TS_MASK));
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
+#define da_state_of(w)		(w)
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
+#endif /* CONFIG_RV_EDGE_STAT */
+
+#endif /* _RV_EDGE_STAT_H */
diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
index efa930f94ea4..1de88081fd2a 100644
--- a/kernel/trace/rv/Kconfig
+++ b/kernel/trace/rv/Kconfig
@@ -126,3 +126,15 @@ config RV_MONITORS_KUNIT_TEST
 	  unrelated KUnit test is running.
 
 	  If unsure, say N.
+
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
-- 
2.53.0

