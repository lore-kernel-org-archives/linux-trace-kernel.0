Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.21
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792490131;
	b=YNlusNcKjSdvilYW2MlgcwFSOF3LgG/v3uYXyWpkhS6RW05Bw34yI/C+heUispka4Gc5
	 zcJZpK6JkPkVghiya6Rdqmn/J1D/KCtM+D4ofVI4wyBBoaEne9b/dQ84AEJG/mm5bFVtJ
	 FPsU1uXQdMr6yzFRRYl1j27KfplCC6mVz1HnhaQUZdxTcdwDubfvvbE5BbiS9L/Fguw6y
	 H2mb03qFV5DKVYYnDQ20nWwo5INuOtM0YYUOpsxoxIEOeuwkTSOxRblIgKpDis8ZD2vW4
	 IGIGWy4ehMTNJveksfSg+BSwZEMmbqS1vE81/NzaFMXBX0J0TJyNhNHnxx4xZDjdwYg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792490131;
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
	b=p/iIgxy/BO19/ttdzjOoQ9YEg8LgrVD0BtIicneLSW/cZPbMOte0sfTm8dCdAoXK8B0G
	 bhQq2eXyg2jyCoNbeZ+EjLGJEGQLg+5aW1rhbHWGytPoDHI4DSx7q3nSeDXhzSsRIfyB6
	 keI0Hio1xG+YZFWtUHfZpRJxUAXw0E5xEqJEAQHLLKy1JOHTF7AruU97TNztrpQ8Z032f
	 8OLQP5BaM9XcdCiUq0jZlLjpTST6kd6IhxLBPU0/3HSDriK1ysNWcUAQY2lwC+aPhrFrY
	 XdhTh+McXk5t5sO3f6629Ia8jlS/z5rmoMzvm0Hm8+M3E0jdWk2IW0SlKHe+QY1BbyQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=hxGknRjy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.21
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010021.outbound.protection.outlook.com [52.101.84.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF36606A33B;
	Tue, 20 Oct 2026 09:55:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4AF36606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=hxGknRjy
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jbybYwuzYyYjsVRQ9abalbz2hPunyx9ePxqLHnLJGOxb5o0cmvgFtdq/wobPDTYTdKUgAABE9Kekr3aeJZIQkF/QP6RMCfdZP0ZBBFMTifwwn7GMwaUnfcBJD+x7RIlgzPhmyv6gFdZff4s4lFos3vNaJBAGW0jBzkjc8nGGmOJ2HFB2JowH4VhGWH1IIro2dvSwjs1cE+/6tnMRr9sbINutWUmEEUDkNIA0XoDwP/VuLt7CR7uF3vHSvSZGexFZdhDmkdhueuTdIU4c1mrHZyD8l7WOfIgipbr7bHK/1E+M8KNcCITbIb+WK4HNnV3K0iMFhN6IMZik7MFDgYaXgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u46n/d6cIKVN0IYjSIIO4rMbbPdm08tcMU6puiZFPi8=;
 b=Mvq47Jn54OlRxPNAYmfUaD0Q/v0VyBwBiOylUb5OKYfaBVmiKdItb5JWmnl6sZebo78DE2CdQvVrqENCpyAxuym8JMwygDGWlunzNLLyg3TrfzT0bUFIg/bFeReRk2Z/flgHWGt9TP85QWVXiOJzQ9lPTcRQ3oc0EowsOYQSyfHaOKrhT0oK41WeLkLnPw0pJxHb2jAPxB3Z2SeGWBEStg1cBLtXeQNIMYrbcPKeyA9vCTjG3m6tyYJPEF795l4kEy76n2CWs+TYePLF9hgXzPGghyxjcvcoGoJBJuY/JVnvnJxtOVSlI4DEL5XDboKFTugRpsPiaEObFXEG7txxjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u46n/d6cIKVN0IYjSIIO4rMbbPdm08tcMU6puiZFPi8=;
 b=hxGknRjyu3OIn7MmJUZajItkZa7cNA6M7xauMNfqn0IRtk3yg2RsxvquItBCcTQVk1Qrf0sXY24sM016dGSMdvJnWH6XXQyJHX/fC7KJaiHlMk5OpX4Z6jhMhAGOp8342kqLHbX98j+Rd7x9siu4Jsu2ZigIuW/9OtdA8BU7pPTLRPbCSOUPVyh3yHxbEbm0GvMNblvCB5VijsvrZcIGCAeuIapyM56G1UM9bDf1NkDhZx+r19N9T17zkIt9tln5/1VDSKgk1DbVNdaSStQbmfkgU0pXyyJ87Qlo1X6EZW97XvjS7BkMH9wbCX6c9TnHm22QbDWQjbMSG2DwwQlvrQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by DU0PR10MB9197.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:5dd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 09:55:25 +0000
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
Subject: [PATCH v3 4/4] selftests/verification: test per-edge dwell-time statistics
Date: Tue, 20 Oct 2026 11:55:12 +0200
Message-ID: <20261020095512.863754-5-tobias.schaffner@siemens.com>
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
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|DU0PR10MB9197:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a57c733-a4cd-4585-42f6-08df2e90433f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|10070799003|1800799024|376014|23010399003|366016|56012099006|11063799006|10067099003|261009223027099003|55112099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	Muiz8r3lwc/uBIrqQEPfE0g1zrYkaHwimEr2aX2MSAmXtz9jMWXxRkpu886+/ehmOZ1omya9SZ+EABsXUgKlIj7a/isU9MeQCuaXBSh6wD6O7sIOrH6po7qTS11gGFW6nKwKnVQqvpOyJvDCcseDzJcSccpIXO26nvPzyr4yBsvbt9lF0hvWcQ3VWrcSGqTlsXEoPG56yPIRCta8ye9SuKE4iegFZjUHv3QJAE604YuciEwkN7NlC0c8H7SpUBHdiqHAafxtYq62XvzowMHSutDitUsgQ/QYO5eslzJV1IJlkjHTePN/SU1S+WGsDxKBXrwKWfKoajAUogoPjwJzrPzewPTOAhIk5GVVnmf7WWu1HubPJvlW8QcTI57Z1nJ1nkoFlk/J6rd74Wb/uI7qfcqmF9AtSdasDv0s4YOvCvmXanZS7gN3UqzseXnDFB1PPHjkmEMIMXzQfOo1j/omEGda4uNCHLKz5FwhFow28khM7OHj77XhzcVPl5lP0xY5ix/1tfy85S9UKLZxYD4jwiWTR4adL+ynCZpCx+BRoIRAqWx4tuSwVAOeoa+IvisTNnWD1TOc4p/oE9GhYPA4pH8pUQYXePI9aCcDH6LnC1Fwkb6ciiviy6g0osje4yiyxb8OlxaAViuLJIHNqz87OYzjL9q1hGgMRR+jJbhU5es=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(10070799003)(1800799024)(376014)(23010399003)(366016)(56012099006)(11063799006)(10067099003)(261009223027099003)(55112099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?c/iAdw0RvP/GGdx8OAzeKHvZ3eNqAe7mMtKcWT6s9x2d0hQylrIlT5vxuZOf?=
 =?us-ascii?Q?qWorD23Xa6mZdLj4wCHsspWc+JRKCWZu0mpbkW7AxtLQYSmGGDC6mGtPXy+G?=
 =?us-ascii?Q?GePwap+AEtqDutMECIaXAGS3UE0PSUQaYrGkt122C2szd+JqxBCA/rCYM7gT?=
 =?us-ascii?Q?F7+6o14vPcnMyKSfHSCKDnDup7G+L1AJAFBBxfRvTpmVF6z24a7FmWpbmTmE?=
 =?us-ascii?Q?G5bA+XOGY+apDfyBUbeHQBuObp3bfz8l90U3pnoWOfnumOKmDjcp27VAP423?=
 =?us-ascii?Q?CguhA4INI6BsCHxSlZMkwrMnZ5nosmlXLI2ZeHXiPKw/5HzZrZxIw+CE2yBO?=
 =?us-ascii?Q?NRWbdcmDsw6OJjR/WK1UQDDr786cBHtZvzMUJQhHCif2HLU+4DZMseM/avhs?=
 =?us-ascii?Q?Ppfc9pDHSb28TedCC2NeU/FynMRjKqr8gnXsTuVgXGq4zU2d7j0NK4oVQF8I?=
 =?us-ascii?Q?QtnGZXe3WKACoS8ECcAotYwn/bZGWJbdXsQ6+bsWAWMQLsAsCTl1cn25hh2b?=
 =?us-ascii?Q?I/v+ksL4rtWuDut7mgNJB6uY3sdirBIYmsIHmWYEMqzHc5yRFNrJmNiHC4A6?=
 =?us-ascii?Q?xeL/DWTB06TnKcE5zdAq2QA13zgBaXkIYNnRXm+cvqC5XEsL79xmCxFFQSy4?=
 =?us-ascii?Q?vF7SgssEnThOAPH/VTJKDEILOx5Lv6QlMP1xvpO+ai2uHE5Z0l52hlKJHrW1?=
 =?us-ascii?Q?SChQhaOfgd9Dgza1CTPvY4gJIg/iidUlO+HkzGCzU56HFQE2+z3l7G3lSWj5?=
 =?us-ascii?Q?1T7vluiqW41QB8LRjTnxYQStnbKKuJ1IrQ84A+Y51eKl/uuWEXsp9Mi9KsZe?=
 =?us-ascii?Q?njquf4L/WmgynGwu8gSTRPr7sa90em1B9Kd9fMLDddWUmLtDsKU1xNlC7RcH?=
 =?us-ascii?Q?V+feTO8j2vZ84PgPKZxR39drnVny+YEWMeYF12V7YvXwxhbBorV0kATetWnT?=
 =?us-ascii?Q?IJC9+pGfNvKnseYDDhgFx0PqL1D2vOHjEfcxLnaFcHz3VY4evhVYkG8CYSfo?=
 =?us-ascii?Q?G/mxj/WTEer7u+omsbnMOOujcufwlUeu1zuEXx3SIRrGnud/sA2//Rlgm0cO?=
 =?us-ascii?Q?z2p9zDc1kl254m/qXT9jrKJvIiLNMvFA1KZSIt0O5IcNjT5qGSFjdM9wuy25?=
 =?us-ascii?Q?RIFmO70kHgclnLg2vvULMjBA9WU8CbqHKqb1Q6Cer98u2yWJ5iq0C2Po8h9a?=
 =?us-ascii?Q?XxwDDW9pQSEnEVYQypB0nBer+BoLAhCH2wfeS1YDdzEiOsfcRbxvCdspXI0v?=
 =?us-ascii?Q?EfLbYZoXT3Y9e/xzcWHjXmD/4uFw4pAMEBOHWG7fuhenGw3lVGvr+IpNi5QV?=
 =?us-ascii?Q?HdNljKGHyOZ39+ot2Y6v3f1BCvdfZ5MXNLdzllCCSY92hi4g0quiLXynaUBx?=
 =?us-ascii?Q?y28PnBiHCPSOdFKRHnIHX799W5Y8ebRZE/7t8AuEaYos7k4Oj3QHZk3Obx2h?=
 =?us-ascii?Q?xEyEh/j5022SUOwMjZ94DtXQQgOE1nXMApAFJhjgrG1mdPPBWA2vTzwsiiAK?=
 =?us-ascii?Q?uuonhXjjybcDzspUkxPpu49bId98T5qRPPOOcwv1GvDM9LO3UYhMNt/ODKP1?=
 =?us-ascii?Q?ZmE12uABfEkHLXyhAq3tDWHn/bZCnUd/NsXXyovTz+hjebxBgTJ1eIyWQ3Rz?=
 =?us-ascii?Q?cHMT0MBwQhf/xnzwB3zZSZMuMNu76m335Gpc2zBAzQ1Xiv3ljxnMwUVeGiRc?=
 =?us-ascii?Q?VNIbggOM/Jdz39TY66MNSwM9Ge6hMcMqbaq30IItYKvAC6sSWEeK+dT5STLU?=
 =?us-ascii?Q?Am5/87ShwWArj7kXO7tOqzyIHw/5qCbOE5m73NCDAAnMsfH4WAcxssk2VBhO?=
X-MS-Exchange-AntiSpam-MessageData-1: LUVSzjYxbsZcZj5I/RUgAZ4mGwJsntb+abk=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a57c733-a4cd-4585-42f6-08df2e90433f
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 09:55:24.9243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6f5qR3nqy3u/grnL9aR00t0LNDC5TYcgafC8cPVdiMvM1k4l8+UlRt04iDaDe1xPEWx61UzxUBJgJ6t0u+jdyhrMBoJDSgNh+H3js983eSc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB9197

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

