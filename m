Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.10.37
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793784122;
	b=f25m9YBVEMGjwnyH3FP4tSN8/cVAunw2fot9NlRPd/EywIdteF5m2j4F+D1eS74Gline
	 NFHs1Psmwga7X+rgOlW+DiEcrIc2asX5Aj1zJDi2ICA7AYQIkrHQhhRTXV2nGXzaJerPI
	 mOHLbdWvUk0bpYg018usM6gTYY+vVcpix2kVFUpXsORySRDlcx/E8PUQDj00DK2vx6byj
	 t27T7yEs1xLM43NaI1vV54OG/vGIByz2rESxq/khAX0dOZDodivMsqFkF7mCuOKYQNfV0
	 iAsOYUzokn1w7N1I8B6AZKjr718nM4qGL0GOLVT/6s3kr69EafiY9P9v2mAHcsD2asQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793784122;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:
	 X-Microsoft-Original-Message-ID:MIME-Version:
	 X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=9Y3RpzT7qKKEV2JOmdhoM6TwfDlK7nSQ7jeHaLgFzQk=;
	b=Z0nxUIp3OK1oGt/OxMxg0VkO3u7yAM9Rf71XNQWnkDEtgSBtPLT8jOqi/ssUvJDrI7ji
	 djNJ+DxK+FJkj+6QWsnF8mx4xxJ/ZAA3BDnHtleOFgVGxQVPr03k7cUL0yvoqS/7QvsK/
	 Y4n3O5rbXdiMWX8BSwiTfTXLW+Gs1WDRrdo2wZCMOdzJS5BpUz3y++QBuz/b3EtLWBzcB
	 EZSkBHEd2HEwjpRp0P/oH9sx6Qzp/3I3SayKkbg6nV5kWVH02sWf8liq2z6iWlV6MAdgp
	 tf22NkD/6yVegiy9i3Uw/nbo7Plba0vAvG88+6/VXfYE8g8yQitZhrSkp37nt9LE0Mg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hotmail.com;
	spf=pass smtp.mailfrom=hotmail.com;
	dkim=pass header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b="NwJLya/E";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.10.37
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azolkn19010037.outbound.protection.outlook.com [52.103.10.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C50606A329;
	Wed,  4 Nov 2026 09:22:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29C50606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=NwJLya/E
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nm3GWuZkRFfCQcJKzTl++plmbvU3kbz5dnvyzPyS6mIf9z0vt9ck1+fPMeGvlLLBkOvjYZdCk550EtwuUugzFPd/f8fDcwe74vsRuFDaDXnQeaqC/xlNv0Ld70vwx/S2N5/5m9av0ZlHb1lOkeYF/W43Rl0dyqjuIE9chCx8f9ZlQo67sjUIlkGmtE+xO1Ej3VRNgjkVPdc+3GjzKC0FxGaRm2sIVVOA0LgSpZpOnXqOstXx8Z/oaF+JSnXjxsWVMdkxQPrP6gw4iik2CDS8lPN4oiABd1Mo0dgFtzbMJ5n8OlLkq1Al0dCP6G1UzEHOc0paX5Plzkt4JeIwBXgeeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Y3RpzT7qKKEV2JOmdhoM6TwfDlK7nSQ7jeHaLgFzQk=;
 b=MRtUt7E0Axqx5UTytzz2m69LIn5srHfh3uPB/A4nvLJMvp9s7ThPlgKbMNVYaiJd4ZtxRTU6US6Qp2QeU/TjY4UdbBRW03jznu2pGhM5gCONoOOWhhuzfWSHlqxEczSdhvb8xpVFyD7vclVggQ8DnuLC5cXrqgGd3/CPLO0wnBC/C4zNa8qgLCXvU/XeJp8TVfcE78pnRCpzLS6adyi9xGjbjr81wBEioCqJ7poHF2FxMLQxTUGcv1dnQbRuDPxuzgfKpUOZxLd4YrlGGnxb/987PawG+P+CThFStu4PnwSyXfc8Knj+MUrgTd31JytuC6yjan0qr+ccsWcL5kKKSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Y3RpzT7qKKEV2JOmdhoM6TwfDlK7nSQ7jeHaLgFzQk=;
 b=NwJLya/Ex2WT28s7dybHou5NqLuQjajJ/HJzqr+WTS6FjiDHc3npvIcIHK2XWFgyOIoTdzgmKnEmjDAP2i4mZnzXmXwCULIxrn+EQsA/bDv7R4lub2/KQP4vkHgbSpZ+9fxssnNjaf3OVepRtR5XEhbi5NIuAKncmJA9fAWktH1XiqqnpBWw3LtRktugsV21WzpJmW84whInnXAVRy0WcV95Q2Fug5M2hgTpPHvV4IvZ6pL4gMSPq/Ucd2R/43fhS4v7crIRiPiS+dsXBzC4arHXuZztewmradabbGUCp4FUBHcMaGglJbpxdP++chc4OpEJC46wVlMBjEhO8kAQKw==
Received: from CY8PR19MB7009.namprd19.prod.outlook.com (2603:10b6:930:5b::17)
 by MN2PR19MB4063.namprd19.prod.outlook.com (2603:10b6:208:1e3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 09:22:00 +0000
Received: from CY8PR19MB7009.namprd19.prod.outlook.com
 ([fe80::905f:ec34:5f65:aaeb]) by CY8PR19MB7009.namprd19.prod.outlook.com
 ([fe80::905f:ec34:5f65:aaeb%6]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 09:22:00 +0000
From: Wei Li <liwei1412@hotmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Nam Cao <namcao@linutronix.de>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	liwei391@huawei.com
Subject: [PATCH 5/6] tools/rv: Parse the mixed enable state of containers
Date: Wed,  4 Nov 2026 17:21:24 +0800
Message-ID:
 <CY8PR19MB700974075298C61A1DB70C3EB7682@CY8PR19MB7009.namprd19.prod.outlook.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <CY8PR19MB70098BF493A3B67418C7B9ABB7682@CY8PR19MB7009.namprd19.prod.outlook.com>
References: <CY8PR19MB70098BF493A3B67418C7B9ABB7682@CY8PR19MB7009.namprd19.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SEWP216CA0095.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2bf::15) To CY8PR19MB7009.namprd19.prod.outlook.com
 (2603:10b6:930:5b::17)
X-Microsoft-Original-Message-ID:
 <20261104092125.915254-6-liwei1412@hotmail.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR19MB7009:EE_|MN2PR19MB4063:EE_
X-MS-Office365-Filtering-Correlation-Id: a627a59e-edc8-4d56-f5e1-08df3a5514bf
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799015|16051099003|55001999006|25010399006|19110799012|12121999013|24021099003|260925184616899003|15080799012|5072599009|23021999003|25031999004|41001999006|51005399006|12091999003|40105399003|26104999009|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rgAwRNlrEh2ZwCCPmqoI+2iSvLpKLBbR1ud29/R9m9iDkqUAfXO+rICjBCTI?=
 =?us-ascii?Q?HW8uDOtEQP9+E3y4kpwFequEdjmQDQNeGijJzHmL6WXW4gQUbgpBPkg73x+1?=
 =?us-ascii?Q?w7bDa/TNuzFHvPHK9HPoHD6uNEw9pkcZxsY0hstM5KE3XFXO77sfCTZx3KmD?=
 =?us-ascii?Q?scyXLF0tomYqJn0Vkj5eK9+BTuDGVh0q3J5veI9si+aYYr4k3IjlkcwmNQ0I?=
 =?us-ascii?Q?j6OA29IVlhDlh31CIhnYB+8UKpHLvGBE3XM4TwEjjCQZBHkZZXrjkU510Rb8?=
 =?us-ascii?Q?24Y35+wLKQYUMJYoSjkci0PuuYACJ9nEMr1B0DL8keFIhfDBUum6our7ejZF?=
 =?us-ascii?Q?ulcvgutjro4RaIhSRdoZRphH+fQBpF8z25cPvHm8GLm2zSfHAUr1jmPQiudl?=
 =?us-ascii?Q?K5DQmoEU9dD25mhO7N/pagfyxIpW/Ncit2JJ2x2MvEZPL36Q+RcIVp8LOOre?=
 =?us-ascii?Q?BnQP5aq422ZlmjnJ3xY5b9wZ79AgwLIuAdTsARsb+MUAB6Yn/5RPc4gGjnpF?=
 =?us-ascii?Q?+TTFPaJHUDRJeJn01yxZz5mLFeU08+xYHPi3k6eNs7HF7in+12tP2ZnwOzXO?=
 =?us-ascii?Q?1HCGIykmFhOmu4F+hiYoenDtluegaEzpCGi/o4nY5ZaROrVJFxrd/BHws4t8?=
 =?us-ascii?Q?6eYssTU/un4oKU+kykv3QmpVdUyJXHwe5kTeu4mzRgF+mJMXcelUQKGjmGmx?=
 =?us-ascii?Q?ctv9ge+06z1ELLmrr2BZY5tmvRyn/AwLV3Q07G0szgMJKRxTNyPxQEEIeXsX?=
 =?us-ascii?Q?25JwPZgM23iwoOHu1e0MPcdtYBk03NtH/BiewHkCfkHdQFPVpKjpb52Hehd3?=
 =?us-ascii?Q?1KlNd5cyxga6VKxesraW55rlWGhpM/blOAfDEBwpqDs9RCx44/ONysJ3hlZx?=
 =?us-ascii?Q?FaF0/xayMxaJgpT2o+a8nUP0JT1uRTN1mIciyRKXsorAHLDTmzoVltPur2N2?=
 =?us-ascii?Q?zpIKZDH1ZWrXDKtc8K1bfl7oqimoLCARQnUZbrqoTl0TLZUoBY7GlhfZyGIS?=
 =?us-ascii?Q?HqGPtlUdKeUy4KORqWZZrd6Hva7PvN4pmKgj5h+nfkT/qFWCC1qyeNCruiaI?=
 =?us-ascii?Q?cZXclx7DGzPbLxRKms/MHNIYJkyBRiZkz9JTc3T98ugjfi6sQV9Zz0uhgNVm?=
 =?us-ascii?Q?Za9Z4yYEiwS3?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fXQf07e73AoFtKLeFLPz9LNQYkSGCSLGnYRB6OdBfHYURhHQRLEKBdMdwd5w?=
 =?us-ascii?Q?nSSCmP+HPhqpqM0bMaP43QHQMt6SBZlb+qeeFzpLd1h1b4bF0noKi6r67VW0?=
 =?us-ascii?Q?/RuYE1RguAlD5kyakVU6wc5l0nALLeZBIRex7QCtZmGB2nGccSN0yrsmvOE+?=
 =?us-ascii?Q?CKnAXBz0fZtjDUQ+/rItDfo8UyQfMzPQcF105woGxk1MsbGRmTj/un8PVtHe?=
 =?us-ascii?Q?adkQIzIouORNpa52mPWDx6udBMZxb4uZXkJW6QK9v96oqyTkvHy0kBe6Blys?=
 =?us-ascii?Q?yBJ5HSWicHbCPhL8TpyFATpxKMUmBTGa9f6KvmFF7uu300ETgvaRcZ3Ch8yi?=
 =?us-ascii?Q?eWXZoENHoSHBLYUspTb1Da/Kg1FJqdi81eQfIZe/sqSrXCYlIEhj4c4FG1Lf?=
 =?us-ascii?Q?urcKzeTm4gwj1CdPHh7jWXOZ+Wtw/u8bPXd130whNWSW0yH1Xw9A+E0dEizj?=
 =?us-ascii?Q?me8u+/c0P3kpMdG8KUUh7MkxcaM4YtLBIL7KnXC1goFDo31x0TqAtJ8PLxcE?=
 =?us-ascii?Q?yBywjpycgD9bO0otEum7XSR7krlJa3ukToQAyiXHZcGLcaz8gdkiNLIdUuUB?=
 =?us-ascii?Q?Rz8RkAWzyvpZrxu2pWKpY39vQXmf1V5NdyeZf41Sf4w0k26SLGCij5TrcvKM?=
 =?us-ascii?Q?th5lYINLENkGy3OBx9O/cXDs9OsXxcbBCwJvoNxWhuLxgDkIOPhEeXGx5g4U?=
 =?us-ascii?Q?g+U7lF3r/U64sREghIGLRoZTOpujasit/0NUGwaKJEz/JEGBbn39cBU3mR1s?=
 =?us-ascii?Q?+O4ER4gkL2n3+yPz3GUdCIwa8+PaXMmLnAakDVtMOz8PiIkZq8mlA+xXYDC8?=
 =?us-ascii?Q?7xTUFwe47c+iI/Z1VTJ5DXnM69SS496MzGCkHJqAV7u0kvjCL2XY1bWRsSr3?=
 =?us-ascii?Q?BQ7WqgREqFsf5Pc8nj0hEId5SMOsgpPP0T6kiGtmiJAVSc8UBkjiXD4EI764?=
 =?us-ascii?Q?aWC6mSa8wXYSGMC4rQYX4KImmAUYDjnbK3JAJRiE3nfDyrx+uLglJ5PkkbSs?=
 =?us-ascii?Q?ZYS2lK1nqv8ZgLXDQ1FOtBe1AYCrKIbmHBlkXxIp+rMMQofb6uWdkjnb/qZm?=
 =?us-ascii?Q?89zIkaB5dY0f1xULg27Rh/8TP41FxvHyesXSQGxgFLvRydv5kicaSkPRuPN8?=
 =?us-ascii?Q?iLv7JSBjCFIVCAwKuRIa8A8+x1h4AhsRgEquWb111v8HPrVEfmXRZK01ZPRu?=
 =?us-ascii?Q?WemkdmNnj1w7fJ0qD2ZEulPXmdtHRj2C2e3DXu/L3TlrWfvFjt7u1/EtLVBO?=
 =?us-ascii?Q?SWex2P4SZ57xxT9od6dO1dglyCRLc+FwvLANdqY9V87CxTJDViXEk7W2bVNA?=
 =?us-ascii?Q?OCMjV5gwwkX/GLXsY3eEgMLX6lm2O2/lFZqPclHu8NHULGz4aOJh49Z721JK?=
 =?us-ascii?Q?0XhKcrj0naSwKoKzDEPINe0pMOpr?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-990eb.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: a627a59e-edc8-4d56-f5e1-08df3a5514bf
X-MS-Exchange-CrossTenant-AuthSource: CY8PR19MB7009.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 09:22:00.6570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR19MB4063

From: Wei Li <liwei391@huawei.com>

A container reports "X" in its enable file when its children have mixed
states. The rv tool fails to list or start such a container.

__ikm_read_enable() cannot parse "X" now and returns -1. 'rv list'
skips the container line and reports "error reading". 'rv mon' takes -1
as a true value and reports a spurious "already enabled" info.

Add support of parsing the mixed enable state of containers. Show a
mixed container as [MIX] in 'rv list'.

Signed-off-by: Wei Li <liwei391@huawei.com>
---
 tools/verification/rv/src/in_kernel.c | 32 +++++++++++++++++++++------
 tools/verification/rv/tests/rv_list.t |  2 +-
 2 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/tools/verification/rv/src/in_kernel.c b/tools/verification/rv/src/in_kernel.c
index e6dea4040f8f..0f2e9f1eca51 100644
--- a/tools/verification/rv/src/in_kernel.c
+++ b/tools/verification/rv/src/in_kernel.c
@@ -29,21 +29,38 @@ static char *config_reactor;
  *
  * __does not log errors.
  *
- * Returns the current status, or -1 if the monitor does not exist,
- * __hence not logging errors.
+ * Returns 0 if disabled, 1 if enabled, 2 if a container with children
+ * in mixed states, or -1 if the monitor does not exist, __hence not
+ * logging errors.
  */
 static int __ikm_read_enable(char *monitor_name)
 {
 	char path[MAX_PATH];
-	long long enabled;
-	int retval;
+	char *buffer;
+	int enabled;
 
 	snprintf(path, MAX_PATH, "rv/monitors/%s/enable", monitor_name);
 
-	retval = tracefs_instance_file_read_number(NULL, path, &enabled);
-	if (retval < 0)
+	buffer = tracefs_instance_file_read(NULL, path, NULL);
+	if (!buffer)
 		return -1;
 
+	switch (buffer[0]) {
+	case '0':
+		enabled = 0;
+		break;
+	case '1':
+		enabled = 1;
+		break;
+	case 'X':
+		enabled = 2;
+		break;
+	default:
+		enabled = -1;
+	}
+
+	free(buffer);
+
 	return enabled;
 }
 
@@ -370,7 +387,8 @@ int ikm_list_monitors(char *container)
 			list_monitor = 1;
 			printf("%s%-*s %s %s\n", indent ? " - " : "",
 			       indent ? MAX_DA_NAME_LEN - 3 : MAX_DA_NAME_LEN,
-			       ikm.name, ikm.desc, ikm.enabled ? "[ON]" : "[OFF]");
+			       ikm.name, ikm.desc,
+			       ikm.enabled == 2 ? "[MIX]" : ikm.enabled ? "[ON]" : "[OFF]");
 		}
 		curr = ++next;
 
diff --git a/tools/verification/rv/tests/rv_list.t b/tools/verification/rv/tests/rv_list.t
index 201af33a52cc..f63697a903c1 100644
--- a/tools/verification/rv/tests/rv_list.t
+++ b/tools/verification/rv/tests/rv_list.t
@@ -17,7 +17,7 @@ check "verify list subcommand help" \
 all_nested=$(grep : $RVDIR/available_monitors | cut -d: -f2 | paste -s | sed 's/\t/\\|/g')
 all_non_nested=$(grep -v : $RVDIR/available_monitors | cut -d: -f2 | paste -s | sed 's/\t/\\|/g')
 sched_monitors=$(grep sched: $RVDIR/available_monitors | cut -d: -f2 | paste -s | sed 's/\t/\\|/g')
-description_state="[[:space:]]\+[[:print:]]\+\[\(OFF\|ON\)\]"
+description_state="[[:space:]]\+[[:print:]]\+\[\(OFF\|ON\|MIX\)\]"
 line_nested=" - \($all_nested\)${description_state}"
 line_non_nested="\($all_non_nested\)${description_state}"
 
-- 
2.55.0

