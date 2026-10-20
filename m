Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.40
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792490128;
	b=nabiy6b8K7e/08bRe8235hbdav5q+bnbuOx5hmbJ+V+zCqQNG0T8nWtNRB09J57Jrjgn
	 99jupjYOhgJHeAWABZLDlfApHle06wFaCaQyEkW/qVEAj1yCW1s5cj+rsWrH8Mz27xvP+
	 J5eeklJo+MQHoVXFwDxvGtZFApRtXxqYnNfRtyBd5UEdqNJ8D4+F8xn5nLD+BuBPA6Om6
	 TlH4I8ZG+m7ypCxHb2gGAVKOM7A6Von5rf9NM5rL12e2qlrbweHppvQEh2cy9bK8BnP1m
	 TRp8NOn2PuYiW5LRWTNKRvvA25JO41hmwEjy9WXAl+N85JHZWOOVue958ubSjbCCXAw==
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
	bh=8lMzMRpEz5Q9g2VO9kmmVS5jRwTyJVFB9CvPoZhpuFQ=;
	b=1r1wiwAYLgFNzPWWJWSWf7HlKVhJB5yxOQjefRSDXF76Uw6W5nlWvXnm3hUwD+rCsdg+
	 YTJ+EQ2o3/pG6lwhrPXCyeJG2Y1X2uG9JtQklgjMqDcjjTV2hPWoCWoQBwTMyyeOaYPSA
	 uYnwOea2GPocoed5bbCm31YOVwirSj8WiEJlwAbI9XQNeWQlL/I+m4x/dZozFDkYjcFtB
	 Q9DgRpVhgeR32y/GKyYDydw97/Gm1TlJah04vntiZsB57wiq+4eLZA2RwAB+UwXChhmC4
	 eKBn/ZDhC/r/6SJkyrcM/zMhXb63g/fHXHxsbSXW/qOXlhgd4Nd35dU9MFasqA4S9mw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=YNqh18uv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.40
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013040.outbound.protection.outlook.com [40.107.159.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8ABB606A31C;
	Tue, 20 Oct 2026 09:55:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8ABB606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=YNqh18uv
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qlJWA5BjhbOHO9sNFAJbxmN/bYwZrH0mc9cNboQsWiYRI4zn0XVERB72wplecGaqyCGoiRkkfRnns6s4yNka/47SZ8WEJcNKzQ5B0t4M7s2usGlJUqG6IKaxNMfcl9/RPo+6nKaOprXCagOKCrLbXlf17sUu8xbM7V+GGNC19uJ5NPJCg9jvEAfC2Uo+0QkGKSFBYPPyRW9mMPhLxDhvURyUv+TK4pqQmUF/tWU+3UNavMOu95VLLpHbtAzKcZcdI95SHsDQyZKaCSjMeMQK4ZtdumgZLZ62F5WYizpxpQKHO6q159/9ycA4BmkUtfGLnGL1hizsMQfk0h+FJZHt6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8lMzMRpEz5Q9g2VO9kmmVS5jRwTyJVFB9CvPoZhpuFQ=;
 b=eRvNF3JfC3bRiWMMY6jlslicfnKZKMFDnXOoyXtmfIZEAm/lOAV4Sa+VPhaaoFqiDFTHQp4SKOE8uL222wcRVBm7UnhxONH5YezQtOkF9IjP+b4tV7sbzIGw/WuEDEUrKNBHD64rKvIXASBFV11zL8ZpG8+hq0tpF9TTXAn+UnNKWITAQeyY/NihjgF5tXgiyrmZr//V2hf2Aqu+b2k85P7JR2LpzRsXTJk5Q6CMT2C7fKuVUQlZYuYBkxqqWcufJDSUHyaLpl3r6FjNV8D84U0zOsKSOOi5t6AkFqQJuWqc/KSeqWozg6TkSL6iPevb8D0QmFgeMyqxUv/gsy/F2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8lMzMRpEz5Q9g2VO9kmmVS5jRwTyJVFB9CvPoZhpuFQ=;
 b=YNqh18uv/KFzUCmMxgBWrARw5p+PA2tbvrgiKFF+G4nHlW9LwHePBOZ6KsfbA0aSUFUJ1lWHIW1Bti9ntELz+7NCQJuTaceC3Ewvht/wkvK1QlHjd61bEVBUVNyUe1aa9lJbq8f3hEWgECZE8nJt9GvfszFwg3748v0xx1oyNejMb+Uwf37hT/VUPUoV+Hv82vJstT2nbhODgr3sxXlLuj4kwChtXoUE7YhOYZHWVA+Hl7dGqWy+bCLa8c9y8ihMaZsz0hrifKD5pxpIxtKP8Tdm22C9bQNygFFl29wYMsKPPQI1MrAgO8mK+sVQiuR4ALdr6SDvugzkE6KjalKA4Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by AS4PR10MB5872.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:517::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 09:55:23 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%6]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 09:55:23 +0000
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
Subject: [PATCH v3 2/4] rv: add per-edge dwell-time statistics
Date: Tue, 20 Oct 2026 11:55:10 +0200
Message-ID: <20261020095512.863754-3-tobias.schaffner@siemens.com>
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
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|AS4PR10MB5872:EE_
X-MS-Office365-Filtering-Correlation-Id: f86826f1-91cf-4f3a-3768-08df2e904224
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|10070799003|1800799024|23010399003|366016|6133799003|10067099003|55112099003|18002099003|22082099003|3023799007|11063799006|261009223027099003|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info:
	sW9wrJtYsCE1g9K3+g9SXFTsGWX9LDWd3L3CMQT7AXemWt8sGcCLKtSuaoqgdukwlalsvtwBdOGNy1zXq3FDj0MgAYyOYjd4mvU8qG9j/lvltYzY6Q/kgnrC0TXxcChE8ejkTW5lqg3b/S0dMl5w4V+f0J6iYHYcMJGMHc3ZS1JoEaX/BusVPK9gYNBEp/CuaFAmWJyha8Nm13prK/0rNXT7OVXVlJhOLMxyxpiBw27JGHrf6WaP2gV95L4KfZv1eGhaD1ZeZ0LgaWJruWJfoIQFQ1lCYWAoSnC4FHc2kDXeawcoMQxSEzD7SJ69w5yqiijoA0A0sGU97I+q15ylQhom9yvWhl8mNM2rdw0owHBgbSAyDsP61Q8xPWE2VwcohlA/FXGXGqRRCjK2zIhVlCd54fo50iRdqPKSFeJ+oGh5aFBNGpZSR2K3Ot85EOC+RQwJzgvRy2KBVSBg5JPtx6NCI2QQue17zm21TGdNhq2szvrN89+Id6WkdCn97ovXL4Lc3FyGZnFdqvYUGJMm62RPNg0GyjSJAXsYujK3/O0gAGDUXy0THObdfQcqFFn3ZSSy1AdwdL+g0el8Sh2GN2Np/TF1xhCsjN5pVRXolGuOOrr4+/9YxPPNN9K5EnQoGz9tWqVRB/h6B/IgwMU+p1tQO1zhQm+I0IXO/GvHjq8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(1800799024)(23010399003)(366016)(6133799003)(10067099003)(55112099003)(18002099003)(22082099003)(3023799007)(11063799006)(261009223027099003)(5023799004)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RlJ66FqN61kQxZSJVmQ3N1ykFjYVmUiv8hwPMwvYS9ojhF30vwU8swlZhtb8?=
 =?us-ascii?Q?Tlrq2n5vk6AWROd0rfQDppcHYmUIcOLcfQfOJpMuOEJ8LQzedDMehhIflq7T?=
 =?us-ascii?Q?m67mS6r96ssVnDrcNhqs0Q8Fh+TFIkg776Bgw0OCjfldvS5y7uX7UGYw4/Bf?=
 =?us-ascii?Q?3ggYk+6CIH7/YOL5d46darQSgzvNtmyoMhn+xeAA8GcRRX6DyahabRVmW/qX?=
 =?us-ascii?Q?FtOYmuOv/dHAuFYQx8fB83CNuh6QKv0YAlS2sOrYzgN/HPQWpryu7PGuiR+3?=
 =?us-ascii?Q?z8fj4wpHmM7r+E/eTx3aRSTA8FR4gZ0li82oAvqJ9jhNghXc7dhHR+VOs0Oa?=
 =?us-ascii?Q?u4wFblkazXklPwj4JrAWwFHjfUUYfhV4LuZwGC8WOWKMn+XD8VRW5HWoQ1YL?=
 =?us-ascii?Q?iUyXsHG0nZTNlYhocnZXvgLAPatMa9hP9R40a6uJwYMIbtgDj+X0+SfiGLFn?=
 =?us-ascii?Q?8zH4FPTJK4KPHV2h9jKv7z3eeStZSjKdSVUJAmx0c7R9j5jA08XB7Tj1wcsx?=
 =?us-ascii?Q?3nWvBcEQ/7X4IqLoFHTTR4QwRZUVZMPuN2aHzrR8XzlSe9AoxWzycjWOhmOI?=
 =?us-ascii?Q?JZvfXTqhTyMqR3PBI65tO7MYHKFOkc8ICaWmM+2LujkGX1nz06XWBgL/fFOT?=
 =?us-ascii?Q?njhA7KtK3OWXLne5h0fMpwg4BvrR0mWvlby8VwteGV1tQ0gcUgi4fAPtXiq7?=
 =?us-ascii?Q?2z6ZXCwTfZvKcz6PXIOnnfFCha71NPjiaiiNkMOVaS7ZSjmcK4NJGwuIsqV1?=
 =?us-ascii?Q?yeydjUIriLyU95CVLIg5P6vmszqHXRD71y2OHzewJWEQDA36jAOrhpLaTmTN?=
 =?us-ascii?Q?qbBG7VkNncAolikarfgmgW26WrdHb+CSCitI6HCo8lCpyPGafu21zlJEDc1O?=
 =?us-ascii?Q?L5FkwTncoYaqOO0tJypisZoy0XVza2bR2gJtNw1KV6oiuftqu+wEMRA/kyOl?=
 =?us-ascii?Q?S/SU95abYeL6leu0ZbvYv0Q6G0xJLMyvpxROYdrqVg6qSzZXEAXv/Mn44WE9?=
 =?us-ascii?Q?j4pFPs/k3isaPjlE7yum+dYdnTRJitX50UoykrMdUlBl+lvQpTh0T4HqI/v4?=
 =?us-ascii?Q?SXiG1PXWf2f2Ul1vuxuN6ZUmVhjZZVJ1zFLhML0bH4wRZKz+y8zg7FMbdbNS?=
 =?us-ascii?Q?VhdwJzGEmtFMxz/ptf99jkNFvdtPGs1AW9Int+QwlDaDp+zINMQE/CieJYHY?=
 =?us-ascii?Q?wWIGlcw0mxRrlxKvOKNWlXHpU1zDq3+SNJOMqgx+4y4Yw/2lgAk5hLxmKDCx?=
 =?us-ascii?Q?PV/TuAnwMBylNHftVZTc7Jiaf73XJtR50gVHjVnxajXbF1uofvfMsk5gKvB8?=
 =?us-ascii?Q?4SkEz1GExRqcRbyB3a3ZZ9f4xXuJcnTLRsIE/E4xoYr4+4n6HBX7aunnuMxC?=
 =?us-ascii?Q?Yslhr+MRm1DwkPLLapuI2O7py8aRPr9MOMOlnyqt8MySPOdA2BlLM3C73SSS?=
 =?us-ascii?Q?ZQlAJS6b8beKLXmWN+GA0A6SBbw4lGBhOJ8MB4fpPKdth8LmLVSJV0F4J7zI?=
 =?us-ascii?Q?q2WRnFeV0FVSKIINgw7AlhoprBwC3xq3FlVV5pLhm4vpzLosoYV61XhtvdK1?=
 =?us-ascii?Q?PuBRW58Qupiz0UkyR5d37A97BMUq+TJJ0e0s1KS/Zg0gJA4+ltHn44KPrXzo?=
 =?us-ascii?Q?IpSd1nxsAooGOwiM6K9/S7NiP8LgYCY1jjnsdGIAlNjzzRnZZMDx6IoE5tz+?=
 =?us-ascii?Q?2t8a80z9MThYSlg0z39XJxHSj0p4fC4L/aKJorLg9oXI01o1vY0nRvGIzWpM?=
 =?us-ascii?Q?1kvMgOCUOkPhb9m3qeYjnuJ8jbNeGS5KA7q9BxKswpsxsx+fdAA3LewL5X6F?=
X-MS-Exchange-AntiSpam-MessageData-1: OxEopXBoXwMnIFn/RGBDOlkCQuMp/OGj7OQ=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f86826f1-91cf-4f3a-3768-08df2e904224
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 09:55:23.0686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CrfZ3ecBqm/ds8c9ub6Ht6EMShZtL0n6XQPq01YuuJNsbUpsW9ZiMQ+5pR5ymirdxishKyybEgFLAA1Yr2IwUdI+anT0Z0/UkEyDBngNa44=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5872

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
index 541ba404926a..1dc7c45f476c 100644
--- a/include/linux/rv.h
+++ b/include/linux/rv.h
@@ -21,6 +21,13 @@
 #include <linux/list.h>
 #include <linux/types.h>
 
+/* Edge statistics pack the state and its entry timestamp into one word. */
+#ifdef CONFIG_RV_EDGE_STAT
+#define da_state_t	unsigned long
+#else
+#define da_state_t	unsigned int
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
index efa930f94ea4..54f7c50a74a8 100644
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
2.53.0

