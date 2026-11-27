Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795779358;
	b=urzRru+nSNE/O20ItxHLl6T9wO2ZVgDT5ZDmSqMKzhJu/kEkau0EBX0UIGHl2gBmlOhq
	 fS80/isuKj1eE9oWgaYPWJq49O9qOBcpz27/SLpXrW3lxNy7S6JuMAXzEQFC64SZp0sNR
	 OL7Gyj9ETZES8afyNkxUMv9y0OoCbsfI33Yu9i3Pzf3bk6qzgoNkl4GDixJIxbqxZavur
	 xbqlhrU6QpuviNaiTYTRpe4oFV3rAENJoFCn/Ka0Kc/oH3eknE8W6WX58Gp/8mRsR1YLr
	 DtrhEmJjvX4rq2+SdWxDQ/3McsfNa3Ns0wYpDFTonC7GNz9fWHp7XbCf2uq/Il9vc+g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795779358;
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
	bh=u46n/d6cIKVN0IYjSIIO4rMbbPdm08tcMU6puiZFPi8=;
	b=FuxoWyvqERDWb79lkMHsjW0Y4iMV9aQxfMyvF/stEpZCjXVyzG8Y/QtVwswqQavVuYgU
	 UqymGOsU9lxt55xmQlP6u7LOuJUKDM+bUPA9Ty7/Tzp5y1QubpLr/6wINI0GgZv9lgYtC
	 RJgutgQkFHP20YWUu/nt+8FtEQZiGBvTPaQGCHheuOuTnPRF1r4iIfBLcefXVRZKhy/N7
	 avxBguePLcnxbnup8OfPwfA+EWT2hIEryqvA2mu+5dLVG9PR//JKBAjJeECAopEHXKBrA
	 ly+LkPTHnttpTcGpeDvYbt3dnR2olOnKyRQ5p51QKTkKdR8z74WGkjQUJ2oBTGxeyUg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=HtORvkF6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.12
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011012.outbound.protection.outlook.com [52.101.70.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE73D606A6AA;
	Fri, 27 Nov 2026 11:35:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE73D606A6AA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=HtORvkF6
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BYhznwfMbos2OwCWfMXunIQrACAs/8DRebDfqRcs+55nd/k9QNn4/J3ZSZZd2hCDbTyS0ZutvVWKOle7lnMl7VCBTtX+9/jPchbw0iEtLKmWB2bg6PtbHJ7jZvjUrZyiHFLbrTQZsge8j51+TWyQK31OMrnLSceZf0r2SxO9BBob53OhEmn4co9B0z/Ot9kfshTNN6ECQg++MnnU18RRzS9fB6hUcSskX8JwIt/YA18QUY2bqfssuHzVKXoj5xd6pHvrA/cxUR2nxYNCsm4a18+N2VaVvrrOWWiq1QX6bY7nkF/yX6w3HE11m0uYmI1L+z7mWDGKrt164iEumiMmnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u46n/d6cIKVN0IYjSIIO4rMbbPdm08tcMU6puiZFPi8=;
 b=I+4QCQqGoD8/ypIHR1urvGY2UoVVZdYkIQ3xyhvXezYs8GluEKWwJczOPlb1AeXFcVGUdIhH8NaNxsdWo57/NvZYWrWVAG0JPXvImF2qi4iImllIYZKBLXJKkpuuXYR0MChP2t/9sZrMnphwnFeezJhD9P4Rw8ntzXQ2KmToalsdDFRYvhjdQXwMAt6TwOjRLP3o370NdYnzZuwG1ne7nnNm6aplcoXAYLMGIrpF7ldaZ7voBWf6vaXxxU9Cs/7UeryKSvQz63JTgXTym3E1AWcovGcq7bcfp+D768VET1MyOngPTGGprw6MZdmw58e/1TAb+7OeHNJ5ZyaAICcOew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u46n/d6cIKVN0IYjSIIO4rMbbPdm08tcMU6puiZFPi8=;
 b=HtORvkF6folWKAEch/nSxY9KWx/mhwZR1InQVHoSY5PQdQdMkR3N/3XgdIZz9OL01hrYDcL3uJGCFXMfcmRrvcYuD0tY1ZolEfLCGvL13l9vPPHE9dHZR71yn2/r9Ww261xzvpbsobR5boYqHAFGLofgGcsMEnXHf69Blv3BgmQo422Sdouix8sFnR4DU+4AG26S9mPKSvBvSDlz8MQ7KvHv3uzIDO2FzEOC8gHzcttO5FcbVa1ib6qOKlkUgS+e2CFK/X7tguKmraqZijo8rViVzOJzV+E9QLHvf4xKkaXTGw306zwgXk7jrSZvUMlf2N/0NBzZfGp1ZL1ln8GZDw==
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
Subject: [PATCH v5 4/4] selftests/verification: test per-edge dwell-time statistics
Date: Fri, 27 Nov 2026 12:36:09 +0100
Message-ID: <20261127113609.650286-5-tobias.schaffner@siemens.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8c277175-031c-4158-f609-08df4c7a9911
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|23010399003|1800799024|10070799003|11063799006|6133799003|261009223027099003|22082099003|18002099003|10067099003|56012099006|261026140227099003|261026121527099003|261028144727099003|261022105027099003|261102123227099003|261022075727099003|261021121427099003|261021123027099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	md6pdtcmXRoKsNjEM475oBhXulHzNb/4DDV8pz1c/+bfJNLq86Rm9sMaykfZdYo+STr/rAWqY0zmpRVQTnBgw3XGqNqKqPCMDaNlq/POodubse80W58sxdXDTx6+AWuvGhl4vy56quM96carWFhLfkhh2OzOgg1sHG675tdHkG0Xk3RjW9OYSvGswRIcwd3dgssX18k+B7v/9gVrED1Jnco5+G9Jea0FxbaXrQKCzLbz9Xg3soJBVtDDze+7mIXr6kmFjFg7ueQ/JYGdcKGTWDWJkwdUXhrDM/gcenAGHHGiCbXsYpQqLiHs3YkTSJjXS9R08yoZwacE9QjBseAFtbn4NLY7Kpe5Kevk8D8KYSJgCXxpqp1lsMKPfoPiHA45zz44BNlPstjMguODK1L90FIO2Pg+Ypt0kSr2ylOV5MiPzw2XPQqQn93pa3eDQeAKjCOc90LwcyCaGSgLZNkyUefbBmKRz/OEVqnBspEhLoUce4Gljt3GfyhlGmVHuczBTAux05oRjYkIDSz9Y4S5rZg1PEk7soywpJMCGjqZ4R6oILcUrh/nbgdqWlRADoF8nJF4/lePDRg609RyKEB8VOf6khdHtBLWN6Mx2MH/q8gpZUjdIUJwiN/N+WH77XAe2mvSDoabM6CRCxtdfsxQcVnJHhfDNbxRUgODDrfXPjM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(23010399003)(1800799024)(10070799003)(11063799006)(6133799003)(261009223027099003)(22082099003)(18002099003)(10067099003)(56012099006)(261026140227099003)(261026121527099003)(261028144727099003)(261022105027099003)(261102123227099003)(261022075727099003)(261021121427099003)(261021123027099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?95uOFZ9ESkDhUdUl6DQmMJpch0MQ3Pkh3ulMPPByMDcCrBehoDh1+wZ3Uk5d?=
 =?us-ascii?Q?WCtVvyMJQFJzUcMFfqRv2zMEu9QNKbULtZzlRctR3MkC5n7rLVvT/DnTvLi9?=
 =?us-ascii?Q?UdXE7D6VdPrnU1MU68ogVviAPSJUBWvJh9Zp8lxsV/gLezIzQyUTtgsGVQal?=
 =?us-ascii?Q?1yQrTpDDWWi8dACf7bPhvqfO8DmYA7OVA+IeAapB4SX08FWVH7Y+3TP4NSXo?=
 =?us-ascii?Q?x2JthvStRO9rgREXMCCj29eb+ihLSC8pjbuZ/zD08Ud2Yq1RK9RsBvv7+y/C?=
 =?us-ascii?Q?mf5lHoICQJvsMn31/VDK+BUciQxEnpBqTvJgs+xkueG0n+VO1IbHU7Sp/HEn?=
 =?us-ascii?Q?XecnUgPen3Is+XLL9XqmX2bC8fI6GqtkhEe9x+8SHkL/jB8qCjkvgLUmoRiE?=
 =?us-ascii?Q?5SFdUWBlF0EFX03PMZNQ8p3qeCBtsGwWA0Wl2lU4VJ/+ZlPd8gb8mn/ge4C3?=
 =?us-ascii?Q?P+G9Km8MOcmKEBdaAcejQtQpRKcyo3TkrJZnLb72EBVrGCWdAydOBlsN6pP0?=
 =?us-ascii?Q?pA59x8FgoClzsTIGi+ex4qazQfBgK868ljoD1+FREWvCeUxjD5uQK2MDFIau?=
 =?us-ascii?Q?+vRmK01sOZSESKCywSQAPCdx9Ei/rPed8t3BjpemCx6qIAvXunAR9JwiQn/5?=
 =?us-ascii?Q?YQJnjr+J9Lau912bCr1gFAK+bmNRN/9CITgWsahNteqdhyMJvMijqIwdbu1z?=
 =?us-ascii?Q?VP9WempEWaWy0sFjoHLdTF3ygom9huSQ0/uRRfUU7hpezhYWN7lNc3Cc76L8?=
 =?us-ascii?Q?CRe+d0NnXIim4DE7PCsmq29xiLxyv6CmKraZsIKwX/FMcJd+tV0nnCb2Py7i?=
 =?us-ascii?Q?11CW1PV58Rg3lsLH6hSNjTq1SnKqRiCNvQcgTLQdwlXqy+h/9oBjWIpt5l4x?=
 =?us-ascii?Q?2i7TtHAEiu7P8+GdKQXAV3Qd8P0WPnInDzFRyZ1D+nBZHoMNRBrwRHgH+0kr?=
 =?us-ascii?Q?aiYB9QA12luQxJerTCzwYE/QHHrVwNKI+AFuDwwH/kM07Cqh4Jzf3UKSZGTv?=
 =?us-ascii?Q?4liUYZCbQ0NZLa9Pxfo8V5z9qIf9B3rjP8lOE1oFV3BNrRzLcCCbc6D/CMtX?=
 =?us-ascii?Q?tYZOs88GKlBuIf2ZYW8PZ4LF/jMk+Vaq5nhFcwQiVikH/yUrIOBSOb60TL1y?=
 =?us-ascii?Q?9riu01I7hLuhDbgXS6Wnmpw3YPz3rlGWUehjdpoms80j9QzSF2WrpyRTOeUh?=
 =?us-ascii?Q?EKeF3RDsdoLLGdznGky5tL+bc/mtY84ahdutQJVQiDIqtvaMlg6iv+kbOa2o?=
 =?us-ascii?Q?OQ8UAVNhZe2P9rNdakcSTnOwC9yGNvVN60REeWKid8zm0vp1iFsXO41Srpf1?=
 =?us-ascii?Q?bO+uK2ElAzgPob4wS/Ez1deYWhkmxDPOJw6d5Ot0XmMdckPvOEQE+2EA1UIQ?=
 =?us-ascii?Q?ALsguHYpxdWSs8iaLRDCJR3L+uXme+uezMAyxrrCCArtcZBwUW8ddMb+ZMUk?=
 =?us-ascii?Q?cS5wROFJ5pyLtTmK7ZTV4xoGZMUpItOGEYuJ15qiacjm7Nm/D74wxfo96aSN?=
 =?us-ascii?Q?5U97gFCjvS0H4Da2RLHBlOnzf8CSjOFzg1731amvks0mKUVVII261ku2N8RP?=
 =?us-ascii?Q?8ltHEAiHygp+4Q9n/tzqKRchvYktg65mPv8DrW79aToU54YvCjZZifqhpNds?=
 =?us-ascii?Q?I5uOEXbgzS+NrFa0RwJufsIXg0EvMiglHoUi05ElxkkjQ6Xex0BuCHKDormV?=
 =?us-ascii?Q?wx6KBNIb8WYGgj8ipweTuJiEKFN3HJjlfc0bsWzcHxDxz000NnGuCQZZ03cY?=
 =?us-ascii?Q?jeJTamNkJxyJ5ukdV6HQPqw/tyDDegSWCHW6vO5IWXe92PN/s/0Mq3A23FEs?=
X-MS-Exchange-AntiSpam-MessageData-1: sZYBU+n/zHbYGgB841rSKbVtkajSl+omBsY=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c277175-031c-4158-f609-08df4c7a9911
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 11:35:54.8774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UsLjlEzi+NzCSVziGeRO+1QU3Pf81qMq/EyCHnfrddrP7juOlfVkeUx/qmPXSGiqDjf130YJjo0+/tGw9apk354yqT+ULys98cvruMzunQQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6425

Enable a per-cpu monitor, check that the stats file appears and is
populated under load, and skip cleanly when CONFIG_RV_EDGE_STAT is off.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 tools/testing/selftests/verification/config   |  3 ++
 .../verification/test.d/rv_edge_stats.tc      | 37 +++++++++++++++++++
 2 files changed, 40 insertions(+)
 create mode 100644 tools/testing/selftests/verification/test.d/rv_edge_stats.tc

diff --git a/tools/testing/selftests/verification/config b/tools/testing/selftests/verification/config
index 43072c1c38f4..caf3a96ac8b4 100644
--- a/tools/testing/selftests/verification/config
+++ b/tools/testing/selftests/verification/config
@@ -1 +1,4 @@
 CONFIG_RV=y
+CONFIG_PREEMPT_TRACER=y
+CONFIG_RV_MON_WIP=y
+CONFIG_RV_EDGE_STAT=y
diff --git a/tools/testing/selftests/verification/test.d/rv_edge_stats.tc b/tools/testing/selftests/verification/test.d/rv_edge_stats.tc
new file mode 100644
index 000000000000..c03ed6682b80
--- /dev/null
+++ b/tools/testing/selftests/verification/test.d/rv_edge_stats.tc
@@ -0,0 +1,37 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# description: Test per-edge dwell-time statistics (stats)
+
+MON=wip
+
+check_requires "$MON:monitor"
+
+# The "stats" file is created on enable; if it is still missing the kernel was
+# built without CONFIG_RV_EDGE_STAT, so skip.
+echo 1 > "monitors/$MON/enable"
+if [ ! -e "monitors/$MON/stats" ]; then
+	echo 0 > "monitors/$MON/enable"
+	echo "CONFIG_RV_EDGE_STAT is not enabled."
+	exit_unsupported
+fi
+
+# The first line is the column header; the body has one line per (cpu, edge).
+head -n1 "monitors/$MON/stats" | grep -q "^# cpu edge label valid count sum_ns max_ns"
+[ "$(grep -cvE '^#' "monitors/$MON/stats")" -gt 0 ]
+
+# Drive some scheduler activity so the automaton records transitions.
+for _ in 1 2 3 4 5 6 7 8 9 10; do
+	(true) &
+	wait
+done
+
+# At least one valid edge must now show a non-zero count. Do not require a
+# non-zero dwell: a coarse local_clock() may legitimately return the same
+# value twice.
+grep -vE '^#' "monitors/$MON/stats" | \
+	awk '$4 == 1 && $5 > 0 && $6 >= $7 { hit = 1 } END { exit !hit }'
+
+# An edge the model does not define must never be taken.
+grep -vE '^#' "monitors/$MON/stats" | awk '$4 == 0 && $5 > 0 { exit 1 }'
+
+echo 0 > "monitors/$MON/enable"
-- 
2.53.0

