Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.23
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795763134;
	b=kaoAQmkowjlRUIaND+aNLRrWjLpvAcrERfepm85DQ/92nGehsHWxM3bj51kDObhTCS5a
	 yIiuBpCi50xUPfGcLdA5Sr8iziupW+FoUtcaVnfJ45mIP0JryJkav/ijsOyh+gHzM3J8F
	 fGf0at+CCZ38XwjXx0IZxjmYFY/c7R5cfJMz4Nmsdo77/PAdiGssuM9KBvfYK6BJDxTLU
	 ZnMbhpmcxORJLJTRwIgMtb5t+SxVplXIuH7grv2McAL1hQRLQTwDw3M0WOOkH50kYOzVc
	 KMl6b9ctDxModMTxLYUn+HtNXepKmSArYo54g7rlhwfK5WvpPw/jWHMc6E15h7xMiPg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795763134;
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
	bh=TNQnDzPQcshp8YI/jqgHaF/6oQx0cn/MBY97kCx6Cvs=;
	b=uLEmw1MYFmhMR0W6bi0gyrTvtmzOm6DgzeDaSNroCG0GHGrzlxkG2oe3K/d1HsHr9fPD
	 W5RIKrFy8MNsLWrHH4gEg2C/JIQ6HK5xwNhneKcC/YuGvB95tmFr5aO472Zf3WbTP4mgx
	 ZLRP07VYCjSmBT/pAnZHxp2NEG8kDen7gZzXfdJAr+BHofDUvBNqhxoe7LiqSYGO2xe75
	 Kck4ZPkEnNEf6GKrXeJ09DJ8CXQDIM2uly1ynE+1+Zbt4J6zo4XoStEBOLKQOtIAGLya1
	 95u77q0qBt0TLJzQnOe5wBbOx/9AkGEZr3uDhgKOm5l1dWG0nY054yfVQH4+2E8zwkA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=WFbF17tU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.23
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010023.outbound.protection.outlook.com [52.101.84.23])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB09606A33C;
	Fri, 27 Nov 2026 07:05:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4BB09606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=WFbF17tU
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qhrkVPLsngRwcm+7HwRCVepPyBWfbmNvYmqk0bkv5Rwg3dLzXQf3nUFRKyRIwIjRae7LSK5W/8lTryc1KVQIpfAhI6oVWABR/ra8Z22eKSxlD1Ginj/wiegqpnViDS2ajax/T9/MDlrR08/Q2oTqX85zHquN66ZaMPc1o37xKornx7ERxFZlPH41h3QTGmsZ5iEb/R6/ksVwuVbj2HPDEns0VZSbJwMpATIZdUmJlTHA8KMCPCKh0rIvE1quH/Lme9mC4V6VjTmBRifVC2OdsTBBvRjP0cDmSXCYIKyCuqpzyy4Y3JC9JU+AV5E9QW0PBSJMBa01rwsiZ58rqRhgpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TNQnDzPQcshp8YI/jqgHaF/6oQx0cn/MBY97kCx6Cvs=;
 b=i5y/eiDaA4vFPb5ZvNWsuRUmRlt/0xp9n3jcUp7xsHnWv3TWTYBrVgsnFl+fNVgRkImiLvbU6Lzj/rt9d+P9p+0QQDX7kiWjllUh+m/mmSnIGUNW7BPO/hWxYMTUItkxrBSPIwnra8MTQK0gGxI+hERGnqcBlaYl5q5RTbp0n5UzFZELVj4V66R4UvPrQ6uN3xQ3iuY8/Cr8/dmnLIdg6fq15FVywg9Ap4zmXMkT0Kbe/Q+T9Sj2kht5n1xEaQmgHA9twooTBaLSJ+bMj4KXVgaITw6QZ1kHXY7oZuzZ+YlJL8++0EJ8wx8ZNKG4Lzte71OXN1BXXfKbh6pJVn+7LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TNQnDzPQcshp8YI/jqgHaF/6oQx0cn/MBY97kCx6Cvs=;
 b=WFbF17tUceGKyfs8RrLwqd/OA88RWljgvJ/hkT+abY6Spi9ZFCC4xdBeEMxa6pG2aItkwLnET6u4XUNlzn2aNI+W3dKV9VB3a1rrBLzylWNqFi1iTz5aUeHb5/9pIS+0OkX/SjfIF/eA5MZH7qyHsLJ8+91R/EJsIjfRhKeAzifR5A7g5xo5ppfNwwYXNPZXFvl/SmUYVVk8WLvZhjPaBmERxxctUUl7g0j50bM1GL0YdOIJKJErbJ+YBLNFCVSgeRAw5pWvfS5im9afpDl71uffSQq7PwGrdwaazwzUMAQlsXY77PZC+aKQxfo7cLE1XOQxjAD2WrI3BCGrf7zRhg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by DU0PR10MB5244.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:34c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.688.4; Fri, 27 Nov
 2026 07:05:29 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%6]) with mapi id 15.21.0688.001; Fri, 27 Nov 2026
 07:05:29 +0000
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
Subject: [PATCH v4 3/4] rv: collect per-edge dwell time for per-cpu DA/HA monitors
Date: Fri, 27 Nov 2026 08:05:44 +0100
Message-ID: <20261127070545.64265-4-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261127070545.64265-1-tobias.schaffner@siemens.com>
References: <20261127070545.64265-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0054.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::8) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|DU0PR10MB5244:EE_
X-MS-Office365-Filtering-Correlation-Id: 97bb9e83-398f-476a-3af3-08df4c54d224
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|7416014|376014|1800799024|10070799003|261009223027099003|55112099003|18002099003|22082099003|10067099003|11063799006|261026140227099003|261022105027099003|261026121527099003|56012099006|261021123027099003|261021121427099003|261028144727099003|261021135927099003|261102123227099003;
X-Microsoft-Antispam-Message-Info:
	Z0WgfWQfVSXup2fGk+D2422PScKricYrA3T9KOmok4ETSkAXULl8aVwjAgOZpVfCfdGuyFALYo9wpdVMHjrfY/gRXIbQ2XyBCI6sXhhT0pDm2/Lxl4Kr0CrOlieAVMVilP/gUaQZ2G8/opawDToe+ND9YV5glHpi3X79hyozEQJC5JezzvIpnicwHALR6UJF8uFnAL27QSXCJJz1hOT7KeY6aLwYSWvwm3fwvBg5PrgYukCNmB0V+z3xumS8xe9R0pBMLeXEHZNQw1Aeg0vhVWCzmh+ueonydXI09F8N4lm7MDw5pxi3jmDLfyjF9e5eXPEzusKiNRGFB8yF7fxTfdkwlBXNVKfDrOV+3ML4EKKNxx/1xw4SoNvT4r0chqEvXyg31UvilYB2/4/79v21tONo9H3NEhOF3wk7tf0xMcVVuMe700Yb0X6DBCJysP8noBkP5UbWX0/bqGxLEzOUD1xomx26DHDynNKVINzOtpuANfOEspB7OYEPs/OiE+2g9SOtBJqAioSPe7wN71W8UbRI814WjNTxYPkxzQDp2fGlqoio0BhuhkmOD7AaDn/iGK5DVt0I07Rh0aP8VZ23fg1FNeTaSbBQ/Vi2ixZtJCi9gUxwUxVXOuwie8CGvOhtM27kdAd0lQqP+btwD53+MwhR3sUyKhnA3UiAbAzVLJY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(376014)(1800799024)(10070799003)(261009223027099003)(55112099003)(18002099003)(22082099003)(10067099003)(11063799006)(261026140227099003)(261022105027099003)(261026121527099003)(56012099006)(261021123027099003)(261021121427099003)(261028144727099003)(261021135927099003)(261102123227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MRyeNWts9QRrdSJpFAPxg7fuijpGrHJoIhl5RM7fht3RBLdT4kjV+pps8cMn?=
 =?us-ascii?Q?WP6Iou9UtuyW6Xv/o27hf0F5ZsOp9ZozkThrP4/gcrQQsennjnM/P0BoyWa9?=
 =?us-ascii?Q?1/TZLBI0Uug/RyROOtx2U/1KZFatY9aRzhXfCBXJqMNMrbSwDU1Gve+nFtSs?=
 =?us-ascii?Q?2ni/JU7v9S4EunLYx2+Kwf+VFTnKnoj5AoRIXg67fXrp0lmDmFtAEME68mo3?=
 =?us-ascii?Q?QV0ilrsP8C4kBo+/kHfJfSx6HNsB1TXvBUL7bqORuQMjB3Mon0OM32lBJjp+?=
 =?us-ascii?Q?8bg8wyHfXphtjM1MZQ/1nDBzBX3Bj1/MdtBgZ43kvcpX4zs5Oaix6lKSgDkT?=
 =?us-ascii?Q?Om3SECZV8B1U+20Uq5HPjtz/CfzM7UQJrn7JeauEDFX6ukIfI1KaW1PdlZbC?=
 =?us-ascii?Q?dWPRUOWoUcWSbbka/HkBfXOEKyMLXGnGK8ACrQhzKqcsObzQCqNe2j17AUoM?=
 =?us-ascii?Q?8YBF/h3/hQt4IPWUt2SHH5FqRhl59CZ7OKtAaopyEh1Z46aC9ro6u7CyFt/c?=
 =?us-ascii?Q?lSai0cRVVI2tlYF48lg7LJshEiE5xLCrL2YwEzD4/oYZ9W8xiqRcQfub/Yx+?=
 =?us-ascii?Q?5VP76IzlobzqmSsHGLrTVNFCxy5nxquisdQ1LIT72HRj3pqdt5Pg1K4Wb+Fz?=
 =?us-ascii?Q?DNFYeB2wTu9Zl2uu8zfa2iFlXNq9hufkYXrRAHCqrRtHAKEZZzc3nH2C1zSu?=
 =?us-ascii?Q?ssxj3IQ0tu/2e9F3GYsTFB5vUD0dX7hZzE7MUF6OeMIq5ARtu1U545yoBRtO?=
 =?us-ascii?Q?qEXVpyFEn6mWyDhIHxOO+wwW8OkNhWixBmNOJO5qMkvfVkRAfOukkFNJ83N5?=
 =?us-ascii?Q?1kelRBZdfri1KQa5idYdoK81KDqJUN+nC6lVKJIJyX6jGELbI2khXtpacAq8?=
 =?us-ascii?Q?kB5bWEWgPKGFnEQntj1laTJI953ZDh1rhWv20Lm/71EQv4WQq2hjosROG4Qy?=
 =?us-ascii?Q?oJ2rsyFi5O9jE2TLG82IyIU0L99IA9orsog2/7RzhOmAGILNjdz2IghFthSS?=
 =?us-ascii?Q?KpFPsc+Kd/miy4aBFvOWbRtsOtZMsmDlazww+5H6jx2sAnl+rxsp1RyTsyyE?=
 =?us-ascii?Q?j6QePtCStMpW33le2LgowYrvykzLkG7k9Jhm/ga0OIz1fcnX9YIjlNyCPLM2?=
 =?us-ascii?Q?cIt/cv+lGIkhe4wmvJiTh7ZJtvmzhpREFaoWmOQjWObvIFgwUeIQo3F19ORV?=
 =?us-ascii?Q?b99xPRYgSaZOcDrOMYf+13SesCqPbOF/XUf8mzofbGtclycbJOXYvQXyDGkw?=
 =?us-ascii?Q?FYHk/XylARp17Zri/peidJustIzjnx46xfqCcczqohLCfU4I7bZ7Eo7WvPnw?=
 =?us-ascii?Q?2Kh3GnS/MheoGDhgkHjDuZUfCNl5H26uoFvBgDyYvlLQ4rUNDzGAGapGDg7F?=
 =?us-ascii?Q?12P32/+sgtoqWeLn9ynKAMeC1iPLasc8ljf8qOBey0daE9fwJoEcBjBwwkTH?=
 =?us-ascii?Q?pPtg64QAHINzmEdgKjXla1c5NFZMnC6m9hXatF6GfK9YQb9iLIS8BOCVU/ws?=
 =?us-ascii?Q?5dddicYfZ+bo6n8unCJLKIk4UIo6H3YovH/eUb8N1xt2IoOg/1wLH8LLLDjZ?=
 =?us-ascii?Q?1F6J/Gw7EPiFtf0yO6VXAFuPGovMogE2+5qIB/fNe358w+RQWKw7MLG/uwvk?=
 =?us-ascii?Q?qzrV490bcAFUBQFJq8wb6TZLk2K/nyVEEdS/K7u32cEPlzruVElGFRuYMzt9?=
 =?us-ascii?Q?HSbSVHP4DTD26iIt/gtfz1wOJw7A4Cl45da/VRGOHbN87s0c7Qn4pyjV9KCx?=
 =?us-ascii?Q?ep9/v35HV++KZfrGk/DhKCi82L28bayoXkCCtU4GCTUsOpq2rELHV5sFISTv?=
X-MS-Exchange-AntiSpam-MessageData-1: p4iYz9k3V0dS44cPSDsgOfNx0fxaThHznlc=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97bb9e83-398f-476a-3af3-08df4c54d224
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 07:05:29.8279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DokPJ9psMpWL4Ct2/7XyloAThZS3Sb0SQol/QhqvcSPeLm9H7rap4f+KCVohuJAoKKDMGrJ1V9qAV1SHjSdokgubYs9JxXFBPik7wwMXWeg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5244

Hook the edge-stat facility into the DA/HA layer, so that any per-cpu
automaton monitor also reports how long it lingers in each state.

Account a transition as soon as its state change is committed. An HA
constraint that rejects the transition can therefore reset the monitor
without leaving an accounting window for nested events.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 .../trace/rv/runtime-verification.rst         | 30 +++++++++++++++++++
 include/linux/rv.h                            |  2 +-
 include/rv/da_monitor.h                       | 24 +++++++++++----
 include/rv/edge_stat.h                        |  5 +++-
 include/rv/ha_monitor.h                       |  2 +-
 5 files changed, 54 insertions(+), 9 deletions(-)

diff --git a/Documentation/trace/rv/runtime-verification.rst b/Documentation/trace/rv/runtime-verification.rst
index c700dde9259c..ac16b5532e86 100644
--- a/Documentation/trace/rv/runtime-verification.rst
+++ b/Documentation/trace/rv/runtime-verification.rst
@@ -229,3 +229,33 @@ For example::
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
+The counters are reset each time the monitor is enabled. A monitor that starts
+on an event leaving its initial state does not know since when it was in that
+state, so this first transition is neither counted nor timed.
+
+For example::
+
+   # cat monitors/wip/stats
+   # cpu edge label valid count sum_ns max_ns
+   0 0 preemptive:preempt_disable 1 4210 95501200 183200
+   0 1 preemptive:preempt_enable 0 0 0 0
+   0 4 non_preemptive:preempt_enable 1 4208 3812900 42600
diff --git a/include/linux/rv.h b/include/linux/rv.h
index bf75cf2300ee..d83d1a98344e 100644
--- a/include/linux/rv.h
+++ b/include/linux/rv.h
@@ -33,7 +33,7 @@ typedef unsigned int da_state_t;
  */
 struct da_monitor {
 	bool		monitoring;
-	unsigned int	curr_state;
+	da_state_t	curr_state;
 };
 
 #ifdef CONFIG_RV_LTL_MONITOR
diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
index 6fc5ef8142ac..d903624d5a8e 100644
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
@@ -110,10 +111,11 @@ static inline void da_monitor_reset(struct da_monitor *da_mon)
  *
  * The monitor will ignore all events until monitoring is set to true. This
  * function needs to be called to tell the monitor to start monitoring.
+ * @state is the initial state, stamped with its entry time if known.
  */
-static inline void da_monitor_start(struct da_monitor *da_mon)
+static inline void da_monitor_start(struct da_monitor *da_mon, da_state_t state)
 {
-	da_mon->curr_state = model_get_initial_state();
+	da_mon->curr_state = state;
 	da_monitor_init_hook(da_mon);
 	/* Pairs with smp_load_acquire in da_monitoring(). */
 	smp_store_release(&da_mon->monitoring, 1);
@@ -276,6 +278,11 @@ static inline void da_monitor_reset_state_all(void)
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
@@ -287,6 +294,7 @@ static inline void da_monitor_destroy(void)
 {
 	da_monitor_reset_all();
 	da_monitor_sync_hook();
+	rv_edge_stats_remove();
 }
 
 #ifndef da_implicit_guard
@@ -689,9 +697,11 @@ static inline void da_trace_error(struct da_monitor *da_mon,
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
@@ -699,7 +709,8 @@ static inline bool da_event(struct da_monitor *da_mon, enum events event, da_id_
 				       model_get_event_name(event), id);
 			return false;
 		}
-		if (likely(try_cmpxchg(&da_mon->curr_state, &curr_state, next_state))) {
+		if (likely(da_state_try_commit(&da_mon->curr_state, &old,
+					       next_state, event))) {
 			if (!da_monitor_event_hook(da_mon, curr_state, event, next_state, id))
 				return false;
 			da_trace_event(da_mon, model_get_state_name(curr_state),
@@ -737,7 +748,7 @@ static inline bool __da_handle_start_event(struct da_monitor *da_mon,
 	if (!da_monitor_enabled())
 		return 0;
 	if (unlikely(!da_monitoring(da_mon))) {
-		da_monitor_start(da_mon);
+		da_monitor_start(da_mon, da_state_entered(model_get_initial_state()));
 		return 0;
 	}
 
@@ -751,8 +762,9 @@ static inline bool __da_handle_start_run_event(struct da_monitor *da_mon,
 {
 	if (!da_monitor_enabled())
 		return 0;
+	/* In the initial state since an unknown time: do not time it. */
 	if (unlikely(!da_monitoring(da_mon)))
-		da_monitor_start(da_mon);
+		da_monitor_start(da_mon, model_get_initial_state());
 
 	__da_handle_event_common(da_mon, event, id);
 
diff --git a/include/rv/edge_stat.h b/include/rv/edge_stat.h
index 8b99e8520e1e..16c28aedabdd 100644
--- a/include/rv/edge_stat.h
+++ b/include/rv/edge_stat.h
@@ -145,7 +145,10 @@ static void rv_edge_stats_remove(void)
 	rv_this_stats_file = NULL;
 }
 
-/* A zero timestamp marks resets, which can run on a different CPU. */
+/*
+ * A zero timestamp marks an unknown entry time: resets can run on a different
+ * CPU, and da_handle_start_run_event() starts in a state entered earlier.
+ */
 #define da_state_entered(s)	da_state_pack((s), local_clock())
 
 static __always_inline void
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

