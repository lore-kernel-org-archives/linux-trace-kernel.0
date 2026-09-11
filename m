Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011040.outbound.protection.outlook.com [40.107.130.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3A64756D9;
	Fri, 11 Sep 2026 12:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789130111; cv=fail; b=WRlOzyUyPnQu8rleOBmKBOAAxleBeKYVhC0PdRMtTDT87GurOzPQG/hRxY3y/hMtJoKYJCeog97B8YPcvrow8yVMD54iDhfqrf/wjrh2AHl9vFzwR56ggPRYOZUb7aiwDFoD12QsyNxPH/YnUQsoc4gPZzexx5Fmv8AybY+Oodc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789130111; c=relaxed/simple;
	bh=oOuIKixt/XjvqYmo6yrpLbtbdtRYP/ZUo9Ix/xzSCB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LLZP6ZcHdaL2Rdp4OhlfIYTM2AENJn1ui02+euLWkbsiHEMLhAFsxuv6veWmX1wM2rg4wS49ofWdVom6QezOvcXIu/F/OXai55jsbMxabFwNbV1eaJjs+ao2FmXit5E0t3Y0IGuxUbKlnjD9DJsk4hl+Q+/GPHsi/fQlky6WDyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=IvTYZ9sb; arc=fail smtp.client-ip=40.107.130.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="IvTYZ9sb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SvzRb8ikebrhyJdV1yZHVfQlUDyX8hBDawIAfxxIJyPcSrP7wP9crw4iFIp2BCnsxVCWA4yrhv9SqKC2sKvjEjupLRHa/v5DmvpxN78aq2ATyZ0tLPdp4Vw9GRhMEl/+otQpD1liTHLEeQKtAWikYc/6SX4HpDhl2GFjdZx9dXd3UKMftCWekJxIhxeH/Hc+tpQrk/M0ZI6/WM/EJ/lBGNpYVqSPeJb90Xk0HGjxc4QN9qbK/iYqBuFq0BGBzJGI1g4EspUdpKZTG4cjgfjfVZPdBmTMG+hXyT8ZcbVG+4OB8R+H1EW808GWq+XsodT3VB4Wk7kyu6LkirX5GfjXWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7jG4By9HwJtqC4aPqYo+zIP7B8epV4Bbdm1UxcaJVuY=;
 b=vchxTJKE36jKJhwhdnftWrCAiyOnYQ/N96mo8XffkYJHHOf4YZ4KmLoq2lg5ZwA6i3c2lx8XGumswD7mqHqBeeHo4cHO9VGB5EEJ6rsrmH+HUvz4Q61pQP1Ja+k5wvHA7nWAnA5bd+VCvfAUpjXjNtc0xvxq288uYt/d68N4OOYrTV0m2HMqgDKwE5VdTrdDsCZ5qa2TdtjoW5phLpGtoAYfLPByhFZxzFe/lrThEHk4KXlpOQzqSFWueLzKIu1wLHO0aT2tYq5aUlZHlzDN1QE1g4SY5mnAi3qs1HgaLyvG7Pe2/Uljmr6Avs7u1wW+4oy5yijGY8PYm1RCRqi5jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7jG4By9HwJtqC4aPqYo+zIP7B8epV4Bbdm1UxcaJVuY=;
 b=IvTYZ9sbqNTRsBsc6Oy95Qu8Q84LLP1JETqTu3SJYqU6YaA5usmw1cAx9Uluf5/oWXaigWcfKgsgdt6t+RwMLRclnwbfQAsPsKmohFC2YZMxeH1ZnwVb4+VJLdH5Pwo5BB9qm1KTcZvxAXzAGYmBrTg+y6tI+hdx7YAfEe30ZDs7g6lKdCORhBoQI8PKTaolo6ml9yI/+dTQ1zyGgceg8IP2KRx0r7I1Vm6sUOn1frWBW8Mtys6jmJ18S9hfPDZMxqgJiiOo4vvzW/woLFlvT4BOHDwe7UG4F3dqyU6YZF6U4NFI65Dc7TK575n23LrnUMC6MErI5GefspOUs7UA6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by PA2PR10MB8602.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:421::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 12:35:05 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%6]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 12:35:05 +0000
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
Subject: [PATCH v2 1/3] rv: add per-edge dwell-time statistics primitive
Date: Fri, 11 Sep 2026 14:34:36 +0200
Message-ID: <20260911123439.463052-2-tobias.schaffner@siemens.com>
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
X-MS-Office365-Filtering-Correlation-Id: c477d0bc-4d24-4457-c6ce-08df10011b86
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|366016|10070799003|10067099003|11063799006|18002099003|56012099006|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	rhnA+ixVR6gA8fP/SCtlzfN71ZVs96lJlJiKkbIY1VyStRvUDq1uGVUW+BE9V1IpyfrY2uPm4otZXOKMXo+V6+1olvwfCLpwWjGiWojMaOR185sDQw8ZqMnqPZlm+N/0lIKuMfUFOjTb71tOoRRdLVmUUwACbrDTEla0TcYhEuZdo+IAb4lLeYQKQyMSoFPtRWds9bWG8PUp6yNglo1Jx/DMhW1S+f0wvnGEUHZgIEzJiDJuw7+wm94TVVkTQdVGiCysfA8fdoIVl2SAXX0BOnCbR7WEeATSJ78ZwRddRAx0fHyCxDuvHx9DIOz6RQFjFhm7vmwTTfjlcqzw2JV7sETaZiHa4Cr25h2x2PRATHLIeUWUZS+g4MDEJ0FSglUt+XbUudq2VJLGUz5vLQrOoqaCHSnfsBPk4hdiynpqcIz2QUPro47hnLcGZQqXLDzg/NgVFyodXUz3Xg/qTUmHIU7tKy3ahDrzVzojHKWdHZY6Q3ZUFtIPuHF8d9fZ9LqigyrUjdhdB0nM01hcrx740rZTv7u83rax5DaYTa+5hvNuw/LprRJ2GPgJwrfv7kW2U/A/s+tc/ZL3pVB+80KUqfAp/FG/3AHdfTx7Wr0KH2KxoPoxrsSgGH/GZWYQB3K6kQGT/1+b9B+UArvc9RrDrFzPHdOLPvtmdKqxxGLeguw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(10070799003)(10067099003)(11063799006)(18002099003)(56012099006)(22082099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jBYY/1sW+IguZelFLNIBzNS1+gR+RzgvNsqzCOzmmS3qrAYwX7XYwppTqzHH?=
 =?us-ascii?Q?zy+fAYQds8Tqf3sCrPwSxBD9v8kZqgAabhEACoOBcjOMi6R8JaXnlp4RHcM0?=
 =?us-ascii?Q?3wIaPduzOtyDtVdh6HOUpuAtDxXcaTZ3cT6gy/6q2G9mo0hHHc9yk93cqG1d?=
 =?us-ascii?Q?v6XbZeNt76v1IzRDffN/TeEpToumsIb5mhZuDikIGXGRl/4vJmEB3f1AR3TJ?=
 =?us-ascii?Q?RedHedXY/afChbv5UdCmj/PAk5pBMRzBNvhLGnupilbgeJtXEBt9uCz0pb1s?=
 =?us-ascii?Q?E5rMt9mDro6VyFLPyaNhr0ibaZ8a5w1imBUO7PzmpSnUrcn9b+llhhXq1XGn?=
 =?us-ascii?Q?gYuhGgwWXkwasuxAPtwTxLCLsB++D+OApip4g0lH7IbxY156mRxm5lkaSAQj?=
 =?us-ascii?Q?GGtGO9CRWy7KNuf+eyZl2jNAAuhr/todCSH5Q8Q8ajxwzAmUtr0B1TKILsf4?=
 =?us-ascii?Q?FZ/vDtWbE1u5/hGV860t+r+a1JrvhN6dh5rxWRCJKDt/Qy2RayLQ7zw8/Vma?=
 =?us-ascii?Q?lt4Qw58Z4C0TKMZ0HJxaYXkLrqn9ViFXNqDJqLEWE+RhAGM+p10Vxa2D2Lu/?=
 =?us-ascii?Q?yTdcRPF47APTT1sdBsMepuWlnfiGXvBKLPVKzvKvjiEtapqSBg0hMlLyhRjv?=
 =?us-ascii?Q?m0xnDr4Wofs4fI1cquw50yEsssuTBPjDkkolItIgQU0XAj3qhEMBmdPJTr6H?=
 =?us-ascii?Q?o425ufebmpNDU0WVsjG4KVTUgWAcrIN2C+hssQ6gmnR2QeZVj/FEqydbhRIH?=
 =?us-ascii?Q?+06Jum7NGZMCbeMwbJqqMLRdzPzA3xbcovCASx7nF27rB/3LW2hGr5XycBcG?=
 =?us-ascii?Q?6R3AcClhj03078cWsyekuixlWRfR/z7DQubWuT1pESvtg3Wf60nwzovqeqvW?=
 =?us-ascii?Q?ySeqFOOGVlCwATTirRS2DUPNV0dGctuTDhnB2cwaxQVlsvM80/Xyidn5/5Cb?=
 =?us-ascii?Q?i6dvG74maOlOpMSsK9cr3PxxSFz/TnDIS2JgbklniV2O5MtfXEstqPkX1o+H?=
 =?us-ascii?Q?o8uM+doR6keby8Aw4lNKoDh/i1RdsKNlMp4lu/FWkZL/borxaHivMyd1QsDh?=
 =?us-ascii?Q?JtO9ZZ9p3TtfIoxlBPi8xmx+Bk+Eh4CnozSP42DyfvSH77VIDLzPK2JjLVh+?=
 =?us-ascii?Q?aFnV4fA+NHF005DZXVcdM5f6XBHm67n+LipW/BdHWx754SYqf0N0OlWecNge?=
 =?us-ascii?Q?GPYO3XK5lvMNgh8VLaMviA46IYylCeua8WLVnqK/E1X31Z4Tw8NnkbmEKYKx?=
 =?us-ascii?Q?Ypsq6maDdW2ZhGLEARIZdOn72xRabc5VgqA3puW5HrQie7OOFKAYL4GvAeLi?=
 =?us-ascii?Q?UzdPzkTu0YGzQEt4xLSTEfXqgtZVUKwsIYl1ZwvX2Q8xuBYwbcDouPZC3y7Y?=
 =?us-ascii?Q?7aGNc+PgyTNnxUoG8Cio2ZMvUo9d9pXLppGeVOrXD3vVfbgVX8rxLMLCOMxe?=
 =?us-ascii?Q?0HdraauWY7P5AOwNckjRW0aa0L8KoGU+C6JcwtYHKjHlw8TWTM9zWO5fbQpf?=
 =?us-ascii?Q?w51ZykXejFqJvdcWKHBrvJ2aoiMxIzm4fX8BxQvNmNqQ6fOs+xhAP/necACI?=
 =?us-ascii?Q?FJysO5GYQkJxvg0gKZ3rVFQP72UocjiIp09Rqnq9SjAFHFEqUBVl/tjUyhS0?=
 =?us-ascii?Q?sRcJaDrvgsXKASub0X1vBdzqr56Aa7mfgrMhAnSGX9FRD0ij4mWDKiTeXF7P?=
 =?us-ascii?Q?jS42ndxELxWXRXI25bqCJbIorOCg54tj1scZDqYx9IeuiWnsCv9rjhEgB/zO?=
 =?us-ascii?Q?YNYf/Ws2xve56NdFPSztVvV97gjiGgbajOwGKec9gKh++0w/cw63/vV+tBq5?=
X-MS-Exchange-AntiSpam-MessageData-1: VeqvIzh+tjP5mj4ScEdV0qM1xfIf/mDCIx8=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c477d0bc-4d24-4457-c6ce-08df10011b86
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 12:35:05.5958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0AneCZHTngSLoyLG/KxmaJ0z+5eWhQjhiibgC+zlUENWHOab1VtzonYRDaT8AWEyLDaj9rkYIK8DPGjpgnQrum1C3bwqWDpoMOEySGXbtt0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB8602

Add a small primitive that records, per automaton edge, how long the
monitor dwelled before taking it with a count, a sum and a maximum.

The counters are per-CPU and lock-free, so a monitor's hot path can
update them without disabling interrupts and without perturbing the latency
being measured. Keep the state and its entry timestamp in one word so
nested transitions cannot charge a dwell to the wrong edge.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 include/rv/edge_stat.h | 69 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)
 create mode 100644 include/rv/edge_stat.h

diff --git a/include/rv/edge_stat.h b/include/rv/edge_stat.h
new file mode 100644
index 000000000000..c5f04fd34aee
--- /dev/null
+++ b/include/rv/edge_stat.h
@@ -0,0 +1,69 @@
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
+#include <linux/atomic.h>
+#include <linux/bug.h>
+#include <linux/compiler.h>
+#include <linux/rv.h>
+#include <linux/types.h>
+#include <asm/local64.h>
+
+#ifdef CONFIG_RV_EDGE_STAT
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
+#define RV_TS_MASK		GENMASK(BITS_PER_LONG - RV_STATE_BITS - 1, 0)
+
+#define da_state_of(w)		((unsigned int)((w) & RV_STATE_MASK))
+#define da_ts_of(w)		((u64)(w) >> RV_STATE_BITS)
+#define da_state_pack(s, ts)	(((((da_state_t)(ts)) & RV_TS_MASK) << RV_STATE_BITS) | \
+				 ((da_state_t)(s) & RV_STATE_MASK))
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
+#endif /* CONFIG_RV_EDGE_STAT */
+
+#endif /* _RV_EDGE_STAT_H */
-- 
2.43.0

