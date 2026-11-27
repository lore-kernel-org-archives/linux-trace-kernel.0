Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.23
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795763135;
	b=gYfwL7OJ5VPKmHyaMKYC+VQKJ4ZBXVXZWMhQA093oKzxYVxVl3pjpDKvNhF4Zj2tOnYx
	 e3nqs9S88lEAv09Q3TWvImIUIpke5OJb/DhHRwcnwJYM2fyOq7Y/1XcHnfqXIL+ndnpUI
	 CCAQTH4xf2HrwUYPFLMZfomwbSCNTFNvfx4Ns2pPNB2L65hmzIX9ev0LkMDKwpg0cZA/g
	 ICgEOQ40OqMoSyaC2ENp0rSYmhXkR7EdnVIGUxzq6bC+2wCal08OBopOJmma7id18tDx/
	 ofs/1SyS1hXJY+nftlk5n1in0u4aVVbgG3Duf9+fyGrAPj70CKpeKqq1ZJXxikdMi5A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795763135;
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
	b=AnsJXDcbr+megQuQaFnyHZ9a5NAcFUcZdyHRmA0vVlYEjIHMrDcL9GLbxwpYV2xQmO8W
	 OCtXbadvibLpXamGKchbKyRDKOpGhca5QpW5q91QsPWmWonpUXKY7QxG9JxyAH0WdLkWV
	 fd30xSNgJqmUayEu+YWDW+IhaWr5cBJ1cqUJptT68lQArtZwom12r28mEJBQRSnjmWtKQ
	 cbjEhh0fKzTNtolfMtF5mGkOAr+s9hMASlTodl8yXj6pAzvzhTbWZkpbxWtDKQyvZz9tt
	 bql/StXa+I7yCHOgqLfbBjgvWk7mWCdiJVwChY/TjG3pFqluiMNyLObJXiKSCVFTDuw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=oCNHh15c;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.23
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010023.outbound.protection.outlook.com [52.101.84.23])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1952B606A68E;
	Fri, 27 Nov 2026 07:05:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1952B606A68E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=oCNHh15c
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sSzJz5AXV9PSoVBr8if4B4nHgY07JaUyTNaKcqn2LiGSEDWGsu8VL5uLSnTqEg+G72WWspxTfXvVTr6vzZjQBEGUbC2fOCIRGgFGS4Wo2+0DnsjxIQoyIn0y0d+NHyN3bcs/XVpTvWp2s/OXTi2bv8kQ0TTLHZsjWw4rpdPeu0LAqNhE4sTlnD1lm8zBKUQxFw0MYqQItOV39J6HDh+Lbk1HXu7DPic9C5/TUukMb6q+GTi73O9pJJN0fpb6vUWPMXGblYlFdkWmLVOLeyD2rd0UuOXJu1sHNC6do49aCo+NGxOJKYaEGy5Tzey2/qEDmiOXWlDC/FlNe32CN2bhBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u46n/d6cIKVN0IYjSIIO4rMbbPdm08tcMU6puiZFPi8=;
 b=X2NRgoEDVHIxS15K/EL6yQZIXcKHHK4RU/fj3b4G8kqz8hlOeO2Shi4WgwiesWdSzM3adp2fNr9OwU6O59V3BNYSRRLef82Zy+cmHjDnNka09FgaxJ9rt0VRlTjJRjqaoivyLfNn9zx3uKpLnzxTHiQzXT/UGATlEip0CKmDs+KxOmm/heE6mymDsS3K8YCVo5UILZtJfq/Iqmh+XrX6NoU1E2QY2GNi4vGEPj6f8Ab8l9oI+3psTuf/lwaZlCmyIrSt0RLkd/vGsGFdUe6P+CjwPyxFG6azOaK6qkex+4UysDwp7t/91FH/XOlUt8+kLobdL0/Y/TqWm9N2LIT65Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u46n/d6cIKVN0IYjSIIO4rMbbPdm08tcMU6puiZFPi8=;
 b=oCNHh15c9UUpljLrIS7ea4CnMXpljuZYRxEGi3l9u3FD5TpVGgVKNq/sLuFP/k/PGmb9GNku4vBPom+C71FGa3ROTPEuDEXn0rNwv1+KOxmyi6li5pt3LTD8SKETxbTRn8p86CbCEYJQrx/RY3G1mmRZAIG8Nr4AnT96wQR7J2njPyIEmWFQasHRF1badPYQ0YOFJk1nneKyPan9N4hii0mUvTtQG0yzvtUAfqB/JL5akG4Ohp761a6lwSq1mreKoIfyEpC7QbDEL8kOGFv+ozSaXxlVZu1t/9hoLSPspIH9wp0Hz5O5Wa5FDpF+Ah8vfoOQw4+PUR6B78wLdwUFNw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by DU0PR10MB5244.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:34c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.688.4; Fri, 27 Nov
 2026 07:05:32 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%6]) with mapi id 15.21.0688.001; Fri, 27 Nov 2026
 07:05:30 +0000
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
Subject: [PATCH v4 4/4] selftests/verification: test per-edge dwell-time statistics
Date: Fri, 27 Nov 2026 08:05:45 +0100
Message-ID: <20261127070545.64265-5-tobias.schaffner@siemens.com>
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
X-MS-Office365-Filtering-Correlation-Id: e6ca444a-d3d0-4e62-d592-08df4c54d2a8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|7416014|376014|1800799024|10070799003|261009223027099003|55112099003|18002099003|6133799003|22082099003|10067099003|11063799006|261022075727099003|261026140227099003|261022105027099003|261026121527099003|56012099006|261021123027099003|261021121427099003|261028144727099003|261102123227099003;
X-Microsoft-Antispam-Message-Info:
	wVlOu1RGwEE5tgbCx4COT3/93cTyvHwffEgMtVXEBYnJdSqXdMtjH6vGTsN0FLnVN7VxbbMn/6Z6dVypJwAn7KT4Ridd9DidkAYzqaSOJodbASFX+MyWJFI/FIoJMNUezmNPVE9YEbfPlVjJAqZQ5zME0l0u4rK+MjzYMuXszphFVQr3oH/RHurs6aX+BgsrGEikjBeV1CqUvxNjDadZgUpQmoLNXGZXwtn6TBOWRVEn6rU0vG0D6puFqynHeBp55BO2VCxYaCOv40dUGZC2Cb8QzSvWOclT2XAffbNJyoidyhpqvLy1qEFZTRTUzywiHZv0PMsWX2EmSF2ibudbR0ayVRGE0+CRDvLt7/ulbXhX6n9ZM9GOGyyU+tatPs95k0Vj1P4YDShO9nB2zyj2zYabLywLevt2MCihu6lFBjvgFnk0J2SmiqYkM/um1qtawvNXPklUIyIrbMjBDc5t6Ft2LgmLAZNQa9SDabQ6NlrRpHR0Xv/S17mEccA9fOq+ilt78uSxgdkxcIN34awFekH25l74j35P2m3jU8q8WNlrgM8EL0CI1JIjLc9ikUxNh7TnHIgRHvReMaFyVA6bkEjDS9JClUP/EhE60+J9+qZPnUIXjKOVaOeAj+kAvBHXOnGg0ZR9idtsEb0hqI/gWc7g/E1jqivChpH4A3h/VK4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(376014)(1800799024)(10070799003)(261009223027099003)(55112099003)(18002099003)(6133799003)(22082099003)(10067099003)(11063799006)(261022075727099003)(261026140227099003)(261022105027099003)(261026121527099003)(56012099006)(261021123027099003)(261021121427099003)(261028144727099003)(261102123227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zt6Ed0htawBYOWGVV4P6MkUcepHVrZqv1TUiSiNy4S4PnB3Tpn6XcpasdllI?=
 =?us-ascii?Q?GXt8SrMFbzb5NZV7sVuoGO8vd5ogoKKl4T6v+s56xG6tugRDK2MS1hLH1jL0?=
 =?us-ascii?Q?8cqNITavDysLxLIc+FTWUpDH1/cyJijkCPwkl76ZK+r8dziIJZlRq2DTX689?=
 =?us-ascii?Q?JSh9Oq6DP5ZcmoKWuEUBfFyhqYateI7Ge9RRKcSHrGKuBc5gm6m3ZeeKj37Q?=
 =?us-ascii?Q?RHSI1LUVtoHDcKWwrTQbZcZM687zc9/tEe7+TX7d46S0yfa7CDQmOSdXqccO?=
 =?us-ascii?Q?jA02qfg87Nw6hOSjIP2afskxwxd370BM3VpBc1bVxm7Pk3iet0x2ecJCe2Yx?=
 =?us-ascii?Q?Z6EyUKYRTueh8RnBbkTXOk+QZaqGyk5RnzheIWyaJiInYLa6MQiSOPRWCsXE?=
 =?us-ascii?Q?3uZcMAlMTZvshU98R1WrlkJKCOOh2ZlQeixIX1LO8zF1GF3uEcQkzmAki2NG?=
 =?us-ascii?Q?mm/QblD61bi3w7k8Czyl2XFcfAQ/PjREYwQnAjGM2PU4bjKBz33XNZjD6/3w?=
 =?us-ascii?Q?Hdf3wlLE7iCr/Hmj28+F/LofjrMJ4Rgxr82US97MV6FNs0JnLqc3JNJUgjwu?=
 =?us-ascii?Q?Zw9qwn2nWpC88P6hpjUWembPzYeq4GuMOobtGy+xERNSPHB0Na3O59yB/utG?=
 =?us-ascii?Q?vOu5m+sSnXbMVTqQ+72GEgX5Pa+4O0u0qbGMIOE82HdTRlzaOra4s2A58BMJ?=
 =?us-ascii?Q?1YpQeziKuMhLvvTbCTp3XPPcEMg2bD8UgRjlZEmb7JlbbryQ3pJk7dqMHM5X?=
 =?us-ascii?Q?5Lscf+9XmXRVvUplFqSDQSdKwNUZz3w1nvyhEtjs7+gtjODez4Xzpxp72qv9?=
 =?us-ascii?Q?ccqPaXsxovrJav/GLxvMQFaUZUXry7MAfTk6wLqEuN1U5clmoC502MxG5HNz?=
 =?us-ascii?Q?ysVx0FidDqlK9YEI5TLvtUnVWpI/Z94OJOJ93k/llR9Sp46VPgNqTuDd3Ty9?=
 =?us-ascii?Q?XAPkoWoU+cAfsM507qxxGt6hRTw/spe+8RkOHY+4MjBnDjNtlcbLDrAaYiic?=
 =?us-ascii?Q?Q2T9nWo96+heyPjiwibbr3iuZ5ESGlVjJb7TbMR5qgA+p4HrM5LNifv65hQu?=
 =?us-ascii?Q?lxAZIRmL3d2m/uNhSY62zU4agG4M/4en4UomjGxMXNRfAvPz3KUwwwKXDXgL?=
 =?us-ascii?Q?Xdoj0Xm/WjF+YV3uzGAG8wAoN5MDncP38833wRNlxqcWoT4RZiLTYeCMGPwp?=
 =?us-ascii?Q?kGfMsqI0B+fyxJytF2wocM5b0KTDu7ZgM4SUKF63wWgXK4vSwIZMyKDkowKP?=
 =?us-ascii?Q?SrEl9XUfXFGmzL4Nm5YrqHFOOCnhebTtIUBKt+6WtBMUKOm5CkTs9iDCduHv?=
 =?us-ascii?Q?e4nliisq9HJtMOeizTOFTfc4j4ZvojwqGfoSuKrqyYSJUBp5lCXtojA9nzXN?=
 =?us-ascii?Q?z+alEDzPbZDbX740bfmmuFHgsu+74R2vQzBdS/M4LNZeg5fhMsCbUUUn0biB?=
 =?us-ascii?Q?NqsGdhc4o3PLObXphKri88r1zB6swA+g6Wxf7EkXIJDxtRMXszEZ8Dz+Aohq?=
 =?us-ascii?Q?LGQv61UfLm/NmGdd49zJTtK9ZCvVKBU4UFsenjw+h1uw07rgE+OFc1UPU4rx?=
 =?us-ascii?Q?2T2t8GyxGaiYbIKec+wkOspXs2xuM8z8STwHXwX931VIhqKGDSJ4jPWWbtgB?=
 =?us-ascii?Q?pB0h0nBTX7i8q/r9Jv+XmFDaGKKWUQq2TlHR+O5L70poDhPUfoO0sJF/qXw7?=
 =?us-ascii?Q?7yxfNfqjiTFXExGOXEr7S4nvaaP2WoI5wpAiekWJeMF/iwlZsOPqWP5j+ldU?=
 =?us-ascii?Q?89TJwiQ3RoYgVnEqmcY4OdilSfi+farEz+lD0NPIHn4um08U8RkcboGxpTvK?=
X-MS-Exchange-AntiSpam-MessageData-1: SpnNARFSO5+2/dC5SUn9YoeQndivWe6zyyY=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6ca444a-d3d0-4e62-d592-08df4c54d2a8
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 07:05:30.6180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tspp5020A3F7aKmD956CO+uf0Zchsz1qSiEI3XMwA92o7J89o9nh7yOkZ0KdpEtW48WK8xdkOwwsJYeZNxOUekWQYcL82RVg6SPzoAkRaBs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5244

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

