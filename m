Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.23
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795763131;
	b=NNkh7Mi/HxdajAWlsFlsJZC83yOKRY50+JaZ67gDgnSXSu3a5yTdIRc2kAV8avIUC1b6
	 oKufj0b2N2IS56e1LOcQCg+IG0yPR1Hk7fkIB2suPNpC2lFMacPJMD7BB3Gtt8lVYMtq9
	 2iQrieC/8SzBSuyV5j6+8Kailo1V1Igt1DpgUX1viSVi1PjqhFFDQRMljy/67D2r4aH0I
	 ydAQs4xDOPWPOl7wXoH0Lbm3tCsr075XWzpzxL4F19ZHYsHzjweAdgdu2nBXUxV/d9cDd
	 v3T3XVC2wWAI43qw5duhKkUauP8RcGOVjaD8NdqRUdW1jPMw0H1NX/ifo/eky0sVn/A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795763131;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
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
	bh=17S/ehX7nQNq3SUBuTPO17VqRMytpWDVSuMXBA+JGXQ=;
	b=LlaBcXQ0SvjT+OAEOMNo8FNZ/7DZSCrJwQruhaPWi5pUGvruXX5HCyKvsXLetw6yjD8/
	 C6ME6CpFQ7cWm4bKN6lf2ZiQtMpU2AXcLT8zvmamR843z1ithghJlhwOpQUgBMWbYKnxZ
	 rFExOAK6R9YTQcNUDdo9JVWm6bk8pU3D3gMgsQbqsPPNz1iuYvVEKjm/rsIxkMDuJliza
	 0DXeAQBXWHrmt9Btu59V6IjLh1ssztAYrYtwvKSMaJCsJe/HcmNSMiiBtewFmZEAGRn4t
	 LCV5QPMufB2W2MKcr0su7wmGssg8qhCWbQde3AlqkUkzfBKeuFT0ahVkvFoiHtQAY5Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=Ur802SIF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.23
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010023.outbound.protection.outlook.com [52.101.84.23])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22385606A31C;
	Fri, 27 Nov 2026 07:05:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22385606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=Ur802SIF
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qGkmQbK++GxVIWBDGZ4vw8L68cGhZYVm9OYZsAe7CqtbJzcRuTqTVDU5otSRR0/L3hHfXNfM5do0vE4A8X0KePw50RuDQJ192gNWjwvUNb2qn9/xNb9gWPCN61z0EHSKpcKSltMzxrCDrKbTeCRTF6Via5/9gZ1XRtZvviGR3tm2+9uJGGjwGAHZQxiiPL/Lr219A1vStDkIm0o7F3eBLT2x2pewcRSg34MRtxFKzIn7XcWi++lkqWKLrsredLrxQBOHTg72mGu6e9HSASzcbEpsH6JMHEtL1DzWWWa9QAGWtqdnqXpCbxl09emDJQr7EbQKJ+dY1Ft33lMdC4abMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=17S/ehX7nQNq3SUBuTPO17VqRMytpWDVSuMXBA+JGXQ=;
 b=pYC+f2b27EUB+7juVAGbaKvRfrQi3Pv1u71UL2gP+iOVIYjZtxalwOubIn8l10a7Ok99M387Cdhjjge3UF4QEBIbE0zDihThAEIqPO0KnQ9LUZmWt9ta8FIkh+qQ/Es1PzwkiDmiZJQfN+Nb0XUByvHYt47LyeRaog5RN0J9qCaFtSpgL6E6IUEcBFql1dv6W5A3XzhydTv5l/peHAp2D8CYryo0vAZyYhChAqiiDuM/MZyQ6s+d6zM9u92it9HpykhufyTb5yzBXHmcYjicbavt4Awvhh8g4L7Fg542Oy672uNYKzA4wNBUjPcwwyQx205w+NCGMItr+jQYghLklQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=17S/ehX7nQNq3SUBuTPO17VqRMytpWDVSuMXBA+JGXQ=;
 b=Ur802SIFWPZn2zObOcEFQjlu1KDuNwdI7j4QoKuDsZYtyXJbSCWgVCt63SO0s2EIKFBTRHa36cetXbHuhSXflFThl/9SNh6ER0HK0QlSBdrvoLik9jeeuXh6GzqpDo38dqzWc8BIAHePci9krQZuk3q/vY3HZLSs/TY08Z847sfi7uj3Q9Q8YLchRHZMmi9P2c59UfMQKanj4tv98bkMvHWa6T1101tvE/zgckPrbmrBhUp5a3nmFUPILBxfWGak3SuseZQqGyNrdDw8aZzrRqYZbFRhVLSshsY1F45sCuUbWN/c4YRCIN7HN1bnH0WO0GMEJTu3ESvfUsGquc2E0g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by DU0PR10MB5244.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:34c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.688.4; Fri, 27 Nov
 2026 07:05:26 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%6]) with mapi id 15.21.0688.001; Fri, 27 Nov 2026
 07:05:26 +0000
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
Subject: [PATCH v4 0/4] rv: per-edge dwell-time statistics for per-cpu monitors
Date: Fri, 27 Nov 2026 08:05:41 +0100
Message-ID: <20261127070545.64265-1-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.53.0
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
X-MS-Office365-Filtering-Correlation-Id: 0afcdc03-bd14-4744-97a4-08df4c54d042
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|7416014|376014|1800799024|10070799003|261009223027099003|55112099003|18002099003|6133799003|10067099003|260925022911599003|260925021911599003|11063799006|260925021311599003|261022075727099003|261026140227099003|261022105027099003|261026121527099003|56012099006|261021123027099003|261021121427099003|261028144727099003|261102123227099003;
X-Microsoft-Antispam-Message-Info:
	/HJc8IYdAFDaoxK+xaEAxYQod2gzV0VjZ/bUZWB7YhT8xSTSLRd1OgwsH2i416Q1dIw32IT/Xq3hieEzEdzEstTUdVBNmaQ3kzXTx1VKFPdERSz7DCzRS5RPol742+4PaeKGDTWYm09Otz473PlgVQIBQ86vYSGtUsBauzVyI/njs0qnB3kMgOw5g62td7UeTwufVYpHwzlDKt65IfkQ1BCcQZaug4laohFZSM6x7RFZoYI1c5eFsaxgmXQ1TYQiMHOeeztvOiTpyPY9zU9yhVCAO69z1jBgMllPC1P7q1akYBH/chB6F3O95jbjOxP35HfCzqkSvd67odG/nx7KVOohGJK8skdTOEX9QUCYYgX6nKRXtz6aVY73VkHkhDomMJcAh7GrDLbsbhUAZ07NofGh6lOGPWwi2h9NfbBZ5h4GzgVE9jCbHOSxfWEkD6KY17BUJ5ZykTCX/sDAXVkFXLnDoIrgUQPFzflVd0EHIrGvnlJtKPIbGYs3v4wgXxCnwcA4gZZsjZ5osayuQmX85//wAbArsB5eGKch8ZNzEl094LuFZ+/yIoKhee21bVZjCmVPSvGqnGvFCm6YpmoYOK6ltor/32rOu16LOTpkO/GzqHlkMGAG1O/0I6i7Ed2Z
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(376014)(1800799024)(10070799003)(261009223027099003)(55112099003)(18002099003)(6133799003)(10067099003)(260925022911599003)(260925021911599003)(11063799006)(260925021311599003)(261022075727099003)(261026140227099003)(261022105027099003)(261026121527099003)(56012099006)(261021123027099003)(261021121427099003)(261028144727099003)(261102123227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZEEt+ibpbYmVQ7JVvm5JOVIgktT/xLmuj2yhlZmTdy7KAUQHOrhKYpRQvbkK?=
 =?us-ascii?Q?VhQc5JMpzbZpzDugX60TKT8OS/4DzaOKOB1yZHtiATEkrF5u8Gmvyu7K9b0u?=
 =?us-ascii?Q?89wSOQ4DGi7UWVuEQG+BibB+cC6xRbfEAbfbX1geZK3PKICN++hpIJksBclh?=
 =?us-ascii?Q?LSqcGjr6cRN9nwabMUX1y6/wwpqF+hMDS3HE8yS5fsNRmRwJ42ZccCy/bZD9?=
 =?us-ascii?Q?gtmWerLlayuLNXvXo2EXO+bEzwqRy05+gRUNNqjDN7AI0qB5jBMit/zJ/Z9n?=
 =?us-ascii?Q?A52Myr3zFaz6ssCLCDcxpHRNvrw36HxbkrcADK8nKGjIL5R4kC8S5Y6cxt9Z?=
 =?us-ascii?Q?mjNIDYmu2Vf21x92Mj8f1WcwehViuNds2SEHVLkAEr2wsNYt1/M9RqbMoW+K?=
 =?us-ascii?Q?2QVD6ElZTu1M/7KFo3JPrBN0+gghzZqkd0Qof5FfDsPnm3tO4mdBuZv+Sffn?=
 =?us-ascii?Q?sr9QxXZvA0Bq1PsTi1bMbwtjWr+GH1iyMTLk48WqZTepgohZ5UVHX65O6slA?=
 =?us-ascii?Q?L9tWxTimgYAjvlTrg++LsWfN/U/uhstj6IOrLupNO3ao8HK8BBBalPg9wBHQ?=
 =?us-ascii?Q?jJrKIl9L+YJLWH594cRBk0n6vJwHVsDBhdyZi2uT+v+31QTSxdhnO1dJj8hx?=
 =?us-ascii?Q?8qeK3Sjq+5hiUe1GfRr8SBjNFqi4lLRk4ZwLMBnzNKZM9nzZodZgLjedhUf8?=
 =?us-ascii?Q?2g44jlIMX25nERCBURpFxDRvR20rGlLZYS6+rcId3t9SQarIGCAafRiR5AGQ?=
 =?us-ascii?Q?VHPjUb/7VvLAPukDSqjSdbc+zCnQp5nsVrPKM9aKWK1dqAQjW1PnEaGtp0Yt?=
 =?us-ascii?Q?QqPX4Ctpvv88NxhDzQXlNXNM7rMxdFZHBrkGeBPxjJ+r6Py2haGV5wNEo84G?=
 =?us-ascii?Q?fcfsxGXxqG9o7UF6zuNuK38RoQhh6eVSIokXHT+XtP0EIu5GM3fdmqzoFy31?=
 =?us-ascii?Q?sO/KK7TyPHU+vKA43dLiTMkaJTP2bx8KkkBfQTVI7kZenaZ2Rshc4wpmcVA6?=
 =?us-ascii?Q?MFgMT23dMBxLnhsXkt79iZ0wLKnFVVI2gTGeddTPNXSls7D7MquFW5Ex4lf5?=
 =?us-ascii?Q?HjhbLUTXC4W50/VVfi5yj9puRUdNP9YukduYxayjcx9YavaF0+ygdtCBnCDw?=
 =?us-ascii?Q?pbY9/uKeRUrpwKmFofLXnYAlh3I5avtNv7Iq+gYavAVL3vswePuXKKPwkmqt?=
 =?us-ascii?Q?4ByqiBk5NPjMXHBm0aBrrx06L2P5h+SKag5mhDRQjA57P9+sdtDXa5znKrxt?=
 =?us-ascii?Q?bnGF1uU0zX7DDpaalFfBtIvuxyMOJc0R6ulnJNaIpSb9t42YE33AcUoyfccw?=
 =?us-ascii?Q?zu6hoNffBDikAzhM3bSHWvrIS+jRaPxc89Z5ee/qF0BqVSmMqZYyIeYo3VgC?=
 =?us-ascii?Q?omqUthZJvdV2k2VWcm2yuTZO89N1v8vAi8YEPl8O9JWELnDGOID62X2ITm2R?=
 =?us-ascii?Q?nXUlReVVw89xLS5jGURkxVd4REeidWMMjx+fOa83hwwYAsOvZD4LLCrxMAzT?=
 =?us-ascii?Q?8YC9Wci36fuUUjaj8SRqtJbr039y8GEHgGie8WITeLfvlCT+iTopch+1nCn7?=
 =?us-ascii?Q?qsMZgaorZedlOB4hXWQgBV7Khx9Zlm4cHBrVIL4smxuFgMrmtT0OZUr0Wauu?=
 =?us-ascii?Q?o89hd2StCgDskJ+QpYUT0VPVMwluOknDEV5TqB9fBvHMjx7u1nJ2xwFlZvva?=
 =?us-ascii?Q?u/vEeGWsuE4gh83M9Yifx28hZSg30FrBHomc2kbsbcYfWShgrzkufRhhRJr3?=
 =?us-ascii?Q?4ts04jhRIe6c9cmFYj87wnCicsZFZiBzZmyFf2GNepetWBYpZ7tBnm5FayoE?=
X-MS-Exchange-AntiSpam-MessageData-1: 0FtKuf6ks7xdnMs5eVa/dgKRntHl8OONRHY=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0afcdc03-bd14-4744-97a4-08df4c54d042
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 07:05:26.6576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QKSUpttAxF+SyYzEMrmHYM43+8MS1H35RSWc2fts792r/qJZhjfV/F479B/afbDtjh6QvlOuDBnkeMkBOb1gLUyaIIyt1KjNULfw8fzSqHo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5244

Hi Steven, Gabriele,

I am using the RV system for a downstream project called EVL (aka Xenomai4).
It is a small co-kernel system, small enough that I can model the whole
co-kernel with RV instead of just a fragment of it.

The patches in this series add a per-monitor "stats" file that exposes how
often an edge has been visited and the dwell time in the prior state for
per-cpu monitors.

This allows me to not only check if the model is correct but also to see if
all paths are exercised by my stress tooling and to decompose the latency of
the co-kernel's wakeup path.

I think that some of the upstream monitors like e.g. the sts monitor could also
profit from this.

As an example, here is the sts monitor on a StarFive VisionFive2 running a
PREEMPT_RT kernel with this series (isolcpus=2-3 nohz_full=2-3). While it
was enabled, hackbench (-g 4 -l 2000) ran on cpus 0-1, a SCHED_FIFO
stress-ng cyclic thread (1 ms period) ran on the isolated cpu3 for 40 s,
and cpu2 stayed idle. Only edges with a non-zero count are shown; all of
them are valid (column 4) and every undefined edge stayed at zero:

  # cat monitors/sched/sts/stats
  # cpu edge label valid count sum_ns max_ns
  0 0 can_sched:irq_disable 1 11367959 39357857250 3955250
  0 4 can_sched:schedule_entry 1 912841 1953227750 54500
  0 7 cant_sched:irq_enable 1 11367959 15829311500 44750
  0 8 cant_sched:irq_entry 1 64567 105061000 6500
  0 13 disable_to_switch:irq_enable 1 8637 24605500 14250
  0 14 disable_to_switch:irq_entry 1 170 263500 5500
  0 15 disable_to_switch:sched_switch 1 904204 3682090250 24000
  0 18 enable_to_exit:irq_disable 1 8488 16681750 3500
  0 19 enable_to_exit:irq_enable 1 8488 55429250 23750
  0 20 enable_to_exit:irq_entry 1 8324 13597750 5500
  0 23 enable_to_exit:schedule_exit 1 912841 1015160500 2750
  0 25 in_irq:irq_enable 1 170 1154000 15500
  0 26 in_irq:irq_entry 1 2 2500 1250
  0 30 scheduling:irq_disable 1 913011 1096248500 2250
  0 37 switching:irq_enable 1 904204 2809182000 13000
  [ cpus 1-2 omitted ]
  3 0 can_sched:irq_disable 1 308000 44282747500 1991893250
  3 4 can_sched:schedule_entry 1 77831 99574500 6000
  3 7 cant_sched:irq_enable 1 308000 781368250 25750
  3 8 cant_sched:irq_entry 1 48789 71474750 4750
  3 13 disable_to_switch:irq_enable 1 7 24000 9000
  3 14 disable_to_switch:irq_entry 1 21 26750 1500
  3 15 disable_to_switch:sched_switch 1 77824 179601750 10500
  3 18 enable_to_exit:irq_disable 1 147 266000 3250
  3 19 enable_to_exit:irq_enable 1 147 1193250 14000
  3 20 enable_to_exit:irq_entry 1 143 198250 1750
  3 23 enable_to_exit:schedule_exit 1 77831 78554500 4250
  3 25 in_irq:irq_enable 1 21 199500 11250
  3 30 scheduling:irq_disable 1 77852 89848000 2500
  3 37 switching:irq_enable 1 77824 130814500 7000

The sts model splits the schedule->switch path into separate states, so the
per-edge dwell decomposes the scheduler's interrupts-off window: on cpu0 the
prep phase (disable_to_switch, irqs off until the switch) tops out at 24.0us
and the switch itself (switching:irq_enable) at 13.0us, over 904k switches.
The counts also line up with the model, e.g. every irq_disable in can_sched
has a matching irq_enable in cant_sched (11367959 == 11367959) and every
switch in disable_to_switch leaves switching once (904204 == 904204).

The isolated cpu3 only runs the cyclic thread, 77824 switches in 40 s, and
its worst case is tighter (10.5us prep, 7.0us switch), while the idle
isolated cpu2 shows no transitions at all. So the same file also makes the
effect of cpu isolation visible per cpu.

The changes are gated by CONFIG_RV_EDGE_STAT and dormant until a monitor is
enabled, so existing setups are unaffected. When enabled, each accepted
transition adds one local_clock() and a few lock-free local64_t updates. With
the config off there is no code on the hot path at all.

I focused on per-cpu monitors as a first step. Per-task and per-object
monitors would have to aggregate entities that share a cpu, which is harder
to get right, so I left them out for now.

What is your opinion on this? Do you think this is worth getting upstreamed?

Thanks for taking a look,
Tobias

---

Changes since v3:
 - Based on Gabriele's BTF fix for rv.h [1]. Thanks for this!
 - Stamp the initial state only when the monitor starts on entering it
   (da_handle_start_event()). da_handle_start_run_event() starts a
   monitor in a state the system has been in for an unknown time, so
   its first dwell was a bogus few nanoseconds (sashiko). Documented
   that this first transition is neither counted or timed.
 - Made da_state_t a typedef instead of a define (Gabriele).
 - Moved RV_EDGE_STAT to the end of the RV Kconfig (Gabriele).

[1] https://lore.kernel.org/r/20261123083709.62502-1-gmonaco@redhat.com

Changes since v2:
 - Resplit the series: one patch adds the facility, one wires it into the
   DA/HA layer and one adds the selftest. da_state_t is now defined before
   its first use (Gabriele).
 - Used rv_create_file() / rv_remove() with RV_MODE_READ and included
   "rv.h" rather than <linux/tracefs.h> (Gabriele). That makes rv.h
   reachable from a header every monitor pulls in, so patch 1 guards it
   against double inclusion first.
 - Replaced the pack/unpack macros with FIELD_GET() and FIELD_PREP()
   (Gabriele).
 - Dropped struct rv_this_edges in favour of a plain per-cpu array of
   struct rv_edge_stat, used through per_cpu_ptr() and sizeof().
 - Added DA_EDGE(), DA_EDGE_STATE() and DA_EDGE_EVENT() instead of open
   coding the state * EVENT_MAX + event arithmetic.
 - New "valid" column, from model_get_next_state() != INVALID_STATE, so a
   non-zero count on an edge the model does not define is visible instead
   of having to be inferred from the label. The selftest checks it too.
 - unlikely() on the first-sample check, and dropped the (unsigned int)
   casts from both da_state_of() variants.

Changes since v1:
 - Packed the state and its entry timestamp into one word, so one cmpxchg
   commits both and a nested IRQ can no longer charge a dwell to the
   wrong edge. Hope this approach is fine.
 - Moved the header to include/rv/edge_stat.h (Gabriele).
 - Implemented it all in the da_monitor layer so that rv.c is untouched
   and the file is created from da_monitor_init() (Gabriele). I did not
   create a matrix living in struct da_monitor though. I think that this
   would need a fixed upper bound as rv.h does not know how many states
   and events the monitor will have. But this would lead to a large array
   in any monitor including per-task monitors.
 - Used local64_try_cmpxchg(), bound the loop at
   MAX_DA_RETRY_RACING_EVENTS and warn now if it is hit (Gabriele).
 - Static per-cpu matrix instead of alloc_percpu() (sashiko).
 - depend on 64BIT, so GENERIC_ATOMIC64 is unreachable and the 32-bit
   NMI deadlock cannot happen at all (sashiko).
 - Reset and report for_each_possible_cpu(), and reset before the
   tracepoints are registered (sashiko).
 - stats file is 0440 now, and a failed create is propagated.
 - Columns are now count sum_ns max_ns.

Tobias Schaffner (4):
  rv: guard rv.h against double inclusion
  rv: add per-edge dwell-time statistics
  rv: collect per-edge dwell time for per-cpu DA/HA monitors
  selftests/verification: test per-edge dwell-time statistics

 .../trace/rv/runtime-verification.rst         |  30 +++
 include/linux/rv.h                            |   9 +-
 include/rv/da_monitor.h                       |  24 +-
 include/rv/edge_stat.h                        | 214 ++++++++++++++++++
 include/rv/ha_monitor.h                       |   2 +-
 kernel/trace/rv/Kconfig                       |  12 +
 kernel/trace/rv/rv.h                          |   5 +
 tools/testing/selftests/verification/config   |   3 +
 .../verification/test.d/rv_edge_stats.tc      |  37 +++
 9 files changed, 328 insertions(+), 8 deletions(-)
 create mode 100644 include/rv/edge_stat.h
 create mode 100644 tools/testing/selftests/verification/test.d/rv_edge_stats.tc


base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
prerequisite-patch-id: 206f940ad5b807994984989e14eb713386bf8b59
-- 
2.53.0

