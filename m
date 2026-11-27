Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795779357;
	b=5mCmFVqEiS41Usmf/B5018hGKmg9CkvMTHZYf2e+/21gmUxH/ojD4BNFUgQ0zuFcpT0A
	 YH2hsFfL512WDaxIxSGRrNlLsriTyXxnC2bXmGxTlaSWI5Z0ESqIdDlDPtXKBOg7WubaP
	 uAM92vWIQbbGzbKYCC7fsXXrIoaHc2d85icOLpxttfEqY/GjghlGBkw9Qc7unX5inJBDz
	 Es8tAszuIdjNB+VRutJdYppkYvtNC3OopInRgGuAWO7VkamT5zWGFwejALyZWBWRfBMQP
	 fAgwpBrufyEkqsOPVdGcItqV+nJIGbWRIuQR+k8Fs+/2kFbjIM0ZLnRH+Qa8x5Mni0g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795779357;
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
	bh=OzN/kNIHDLtUVXAPXbdlpaL0MaMzXtC1x3EKvEO6kKs=;
	b=F/zutyc8Sw1NixvqgLGLp12L8GeESrig6/PJdgtggCDjhn/8BAsj/5XQ26dQrlsAMQhY
	 8vm5gNsq0AAYkUThgAs2H8LO/uOc557/0gXeA8FWrX8MaAuH7p5veY+TiJJ/cMuFoh/qC
	 uc/hPjC3WsKXzV8Z+g1nx9YCr10ro1jMljhhqX3A58dcrPkKMWMFEaTL5/iaMmSyIxjDa
	 E8kgXZmaLJRzIVk5vSWgz0TBZhwaiv6GGB0pKeL6Whlo9ytGB4duDVHVotkhTCjZLmTb3
	 WEc+ZqPZ1Xkr3/cebS1tR7UIEmY7Jt1qGSmfwEZGuxNpTTCkMa1618rP/v6fbjL4zeQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=i4V7cLa0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.12
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011012.outbound.protection.outlook.com [52.101.70.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF127606A337;
	Fri, 27 Nov 2026 11:35:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF127606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=i4V7cLa0
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=twP9driSGYgm1cq7fa3nP7FEbMg8pCp9vDh4p5xpVpPftDBQsKfXFq18MGHaHuxwkISk/YtWC15OT5tb8FXmyjs4Jc/Svmlmb0tS/WuN4vO4j9jHoEfh2I9NKKa9vyDFJRFyHge4yVfo7Xw+SQibrNY9M97OfPY3ndWcPip2S9Ryr9EcoaY/eLfyrdcKnrzosNKLVOP8Eo9J//FcSVFCU1acmkMcgnMfKFIlbkZbFN+phKXxzVefLc/woVKXg95Q4qQBMxHGq26TnEM0B2G9vLROXU/EqrBbjv+yNHw7k7ddR/IhKG4umetuE1/aL7CuynU9xtGNcml/NEdhqEEpPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OzN/kNIHDLtUVXAPXbdlpaL0MaMzXtC1x3EKvEO6kKs=;
 b=uXN9wf5d+BDdnwqD0jeU8ybgVP0iMGS1vKN7MxOume0NDXDYRuCnXTQ0WgdR32tyEecNJer57lHzz3lWxCf6B8Y19I0fXo0a8vI5ZjuoW2Zu8y6eqOY8qwxLl1k2SLqdgI5TN/EJcAdwl3MvQL9VkCRBuepEI5eVaKemO2O9KzKi/VkxhJTKmuJTpFnByTQGZcljtLgP7fIMKM89qLIgBuk1uqURPBb4FJAgYsr0HPkO+wOmcY0/rtIzw7czyV8Gyvf0j/yQ5mm3EPi8LYFjfTk+py7SvbJAZIxl+VT0ObxWtkcwflcH1gKRYhyvdL2ifT/btyPewTTzNcE7nJAm5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OzN/kNIHDLtUVXAPXbdlpaL0MaMzXtC1x3EKvEO6kKs=;
 b=i4V7cLa0K15Oxfd3ztR/XDXjsroKLicJ36v3yVh/XisbsagePiMyncmWnLTYVWwQ8Cx9AuUoG/yzqKya7OFEmssWBX4nIGWkSqrLnaj/upvnYgNs+3CvchCJ58U6VY+vnSsGRwv0SO5Dl2ArRxE40wBH5g2iwsPuAsUuXZQo4YqhHG8HXEZGqQsJGBxDiVognN1H6ZL3OhWTwI45o4mWZWAIHD/324SNaiUrlg/IUp3atsn4Suimw7K2hB/sd+oTttFuJd7uZgml7rXs6BraE8jrjrW8X7r81rMqZ/vyZVn1SkiC36BtrI3Zk3Uzd9bwUHaIpNVY6eUEPq7VtWaRMA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by AS2PR10MB6425.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:544::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.688.5; Fri, 27 Nov
 2026 11:35:54 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%6]) with mapi id 15.21.0688.001; Fri, 27 Nov 2026
 11:35:54 +0000
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
Subject: [PATCH v5 3/4] rv: collect per-edge dwell time for per-cpu DA/HA monitors
Date: Fri, 27 Nov 2026 12:36:08 +0100
Message-ID: <20261127113609.650286-4-tobias.schaffner@siemens.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8abec8b7-6037-4fb4-f7bf-08df4c7a989f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|23010399003|1800799024|10070799003|11063799006|261009223027099003|22082099003|18002099003|10067099003|56012099006|261026140227099003|261026121527099003|261028144727099003|261022105027099003|261102123227099003|261021121427099003|261021123027099003|261021135927099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	0XzblAMWoGO2icGBTSd3s4Q78oXGwFarmf2hT7trMa3R0RbclJz89IkhE5J6fr4ExP6TKo1ms2eGcoMGjj9fgOXaUrAbj4fYq1qBRw0fXtoXIMcVuBDAMpQiV+OS8Y7V/ilnD1LJgyvKifqaSq5oush507tiOuXfc9BvGeEasvrRyShtu4qWHTXGVKurLiXJfB+iLK1iiGDe7u6pFTaAfAZ/Hf4IxRPZ2ouLQg/vOsGo7XIY0NH4h/pHxT+X49PjTjjzf+ZP/VdhTJT8zrlh5aEeAtRgW95prtsEU8RJGlP2f9E2g5BAyxEPJw0dIhByEPf4ZOyxDTnjZ5gHRzaPuL+NoUe/7txe7l+zUSmfuU92wAdzqwWjMv7RPnHy9IyG8up4imElUIbThET6RTh3x44m1UhsjbmLpB84vxRbVrng6g8XOYRcZES5xfV0/QWqfnhrcrZTcPBlVDx3Pn9XPid42oAw0jvfW2ZwR5rTZMbfSALgvouYcREaPYUDp3zhD8RSFBUYciI5/tuIXNsxHNVRpx5M7apfMymuxdyrHSSG6cy7I5XqNsNQR3PmLc+Z9NahvYc7IhN0qvxujYfaqnUPvrllBYmySUy6nWVcVGfkW3+mXKSxHp4p831T+TW6iMaUzXzzHP0Q181hEB7VrrRyJ2OTLtDfFuRvipEvA0Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(23010399003)(1800799024)(10070799003)(11063799006)(261009223027099003)(22082099003)(18002099003)(10067099003)(56012099006)(261026140227099003)(261026121527099003)(261028144727099003)(261022105027099003)(261102123227099003)(261021121427099003)(261021123027099003)(261021135927099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IHCHACwAOdjIM+fiVm9WRMcT4/3HRKILErPilaycgQg9pIZxOs1l43qHSG/R?=
 =?us-ascii?Q?tKq0Lu1Y41L/2CVYJYMtYTIwredTgw72p03AqyHDbsen6H1ZK7v3EeYRG92d?=
 =?us-ascii?Q?0ALET/Od7+5qc8oZS1H0xJ8cpzfkfWolIDVivbkTGJyMP+ZBOZ5UzaX/E0rd?=
 =?us-ascii?Q?1f46ecddTahZvz6BetWc17nOHSYIshjh8oUzCxxP2ta2vV9AAo/09buF14nm?=
 =?us-ascii?Q?pmpVwPnayR6csgZovfuicLFWm7J+0dm0m7Ayemz2hfJD8lfiiF3zi5lguDEb?=
 =?us-ascii?Q?Wf3SjOhi66snmyeYlMy522WYWF82e79b/VY8h3j72etYOfH/XLhAX1u+L2vH?=
 =?us-ascii?Q?qdKne4on8FCzYKDAcn+Lpco/yGaJT+X4Y0qhaNkheaAxUlFPN7tnN7FPzTlO?=
 =?us-ascii?Q?mWrSCYrzBIDfBoj2+3FyY4DMzzZji7UsZQku2nL45/+diOBZExTguO4zjlK3?=
 =?us-ascii?Q?3mq6o0L6j6ZjhN4F6gtJrnhOQzRh7RAoz2kTOsDPQQGdDwxEkrqdOMI1ewJG?=
 =?us-ascii?Q?i3//r2xrwNltHssZ88Yp0Q+dDv2imlabbCBXgIoFFeNdmD3yEu6OzXpQObWN?=
 =?us-ascii?Q?cQXwEvbrI0lZm9TqcHq+vJKuh/NWMf7k17ALtCkJg/BpzyIpdbveuiAP3xft?=
 =?us-ascii?Q?AX/T2Suu0YaNtEpSdpZ+LhfZvF8clnYHbC6viZNcjpazbLoHSVjSdZNYfV5g?=
 =?us-ascii?Q?OYboTTaV4SIz8gBbzADxg5QrOFdm/aMEnUwZFWffq5KkzjUYq4RgA7YZ0smv?=
 =?us-ascii?Q?83BU/4rSIKgwGwF1LdRP4a/T2KTwOOl6RfwI37l4ceJBjYzCjlUfCIbEGkl9?=
 =?us-ascii?Q?pnubVfXC2yu+lPmA8BPlhzLUfcJUWDVOk8Bkc9pCjuF7ReGW1Hh35IHNTSaT?=
 =?us-ascii?Q?mSGvCIY4IWUVJfFa7MkdUtvpBR0Hua8Hv0TNmakVIO01HPQkDYyzMEZJxqNW?=
 =?us-ascii?Q?qTNqYRUUjC08gr6AaFeNwxvmyaXV59oEZc2o32GiLsKj5yhSIGBrWUdK5r+g?=
 =?us-ascii?Q?aF03DMHfdlmdRk7gQNUnfO4iU8fMWtKdYbIXqLX2YS2UIJmZBhtfcTmKV/Ck?=
 =?us-ascii?Q?QrWJENFRrrLZK8JDrwJJMHYKsjaN1kRdo0iILKJmn3+rVWg2liexdR4sxgBp?=
 =?us-ascii?Q?2se1Ni5IfJows0wdizafeTA33J/JJF3h2ioOr07c1NMh/ZhcYkzxQHOFFV2s?=
 =?us-ascii?Q?S9v0Ov1yq2NuJDhoJpoCb3sf2Rgv/KZocCMS0Ge5TAePZq2F3JoUodd78HVx?=
 =?us-ascii?Q?dmYqtbesErL2014mgVHgtfpS4Vbs32tYOJMasBU9kkeeya1eYAzYxbSACG36?=
 =?us-ascii?Q?YJdlcueGxNhzUrj1FIGiwit2O9muID0Hr/Duywz7pJMnNN/3ajzBZHuPMkxd?=
 =?us-ascii?Q?Gu1W6rome5fX+cnW59E4dAGKJgYEeDu02BdSDKhwL9gEaLFtuCadbu1X7w3f?=
 =?us-ascii?Q?26n6RKclm8z8ysVmUuKfpRb2Sx8Kb82iVvedXol1FelWK/MQsDNqB6F9XNTh?=
 =?us-ascii?Q?QWatHHNpK5I3KKG6BFS0uPlJiewZ9hVytr7emcvS/yoTVq5Vvu+CDbHcmRAr?=
 =?us-ascii?Q?ClGQQsxTLOEtkNpKatvWZ2+ON6A1VODjKPbZvDc7HlkXOD3YjKv7LNX/eJnY?=
 =?us-ascii?Q?8yhWPNpM6ezEr6SrXoUbTS3TuvP2cHIz/H/p9F4pROaDGMljcwyQVZ03247L?=
 =?us-ascii?Q?Goslx6g0nl1cVsiYIhRuqoHH+evuaSl/ZxuS/JiGHnVkzQRY2X2BJnww4E2a?=
 =?us-ascii?Q?W6Hw9RrLIHMG3pQuleQ8ZJb9sJBwTNk4ZJ6zzwutnRGqqnEddvrGOCWbpTcU?=
X-MS-Exchange-AntiSpam-MessageData-1: oG19qJ21zZpSHaMStHNzNsGDggIh7NDGMKA=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8abec8b7-6037-4fb4-f7bf-08df4c7a989f
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 11:35:54.1670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VHjcsCNNR3YEMEcWVgRdtM5lps8nzP1QQjhdkwZ2klGHWWWjSbVemvlCO/Gct/9PUWbI0ovrEAcyMhEvqDKXprbBS4WiXS6SK0ksNmV3K/s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6425

Hook the edge-stat facility into the DA/HA layer, so that any per-cpu
automaton monitor also reports how long it lingers in each state.

Account a transition as soon as its state change is committed. An HA
constraint that rejects the transition can therefore reset the monitor
without leaving an accounting window for nested events.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 .../trace/rv/runtime-verification.rst         | 30 ++++++++++++++
 include/linux/rv.h                            |  2 +-
 include/rv/da_monitor.h                       | 40 +++++++++++++++----
 include/rv/edge_stat.h                        |  5 ++-
 include/rv/ha_monitor.h                       |  2 +-
 5 files changed, 69 insertions(+), 10 deletions(-)

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
index 6fc5ef8142ac..942b35428ccd 100644
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
@@ -105,6 +106,14 @@ static inline void da_monitor_reset(struct da_monitor *da_mon)
 	da_monitor_reset_state(da_mon);
 }
 
+static inline void __da_monitor_start(struct da_monitor *da_mon, da_state_t state)
+{
+	da_mon->curr_state = state;
+	da_monitor_init_hook(da_mon);
+	/* Pairs with smp_load_acquire in da_monitoring(). */
+	smp_store_release(&da_mon->monitoring, 1);
+}
+
 /*
  * da_monitor_start - start monitoring
  *
@@ -113,10 +122,18 @@ static inline void da_monitor_reset(struct da_monitor *da_mon)
  */
 static inline void da_monitor_start(struct da_monitor *da_mon)
 {
-	da_mon->curr_state = model_get_initial_state();
-	da_monitor_init_hook(da_mon);
-	/* Pairs with smp_load_acquire in da_monitoring(). */
-	smp_store_release(&da_mon->monitoring, 1);
+	__da_monitor_start(da_mon, da_state_entered(model_get_initial_state()));
+}
+
+/*
+ * da_monitor_start_unaccounted - start monitoring without accounting
+ *
+ * Like da_monitor_start(), for a monitor that has been in its initial state
+ * since an unknown time. The first transition is neither counted nor timed.
+ */
+static inline void da_monitor_start_unaccounted(struct da_monitor *da_mon)
+{
+	__da_monitor_start(da_mon, model_get_initial_state());
 }
 
 /*
@@ -276,6 +293,11 @@ static inline void da_monitor_reset_state_all(void)
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
@@ -287,6 +309,7 @@ static inline void da_monitor_destroy(void)
 {
 	da_monitor_reset_all();
 	da_monitor_sync_hook();
+	rv_edge_stats_remove();
 }
 
 #ifndef da_implicit_guard
@@ -689,9 +712,11 @@ static inline void da_trace_error(struct da_monitor *da_mon,
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
@@ -699,7 +724,8 @@ static inline bool da_event(struct da_monitor *da_mon, enum events event, da_id_
 				       model_get_event_name(event), id);
 			return false;
 		}
-		if (likely(try_cmpxchg(&da_mon->curr_state, &curr_state, next_state))) {
+		if (likely(da_state_try_commit(&da_mon->curr_state, &old,
+					       next_state, event))) {
 			if (!da_monitor_event_hook(da_mon, curr_state, event, next_state, id))
 				return false;
 			da_trace_event(da_mon, model_get_state_name(curr_state),
@@ -752,7 +778,7 @@ static inline bool __da_handle_start_run_event(struct da_monitor *da_mon,
 	if (!da_monitor_enabled())
 		return 0;
 	if (unlikely(!da_monitoring(da_mon)))
-		da_monitor_start(da_mon);
+		da_monitor_start_unaccounted(da_mon);
 
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

