Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.23
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795763134;
	b=GnAajnIlY8gLza+ShZyvrDJ5FXSjruysApxgYV00BQe641BiTRBticjIEtgA2/b0vcT4
	 xlr0MS7/xxbdAQ18/y9+XEnkPmlNo7iNscrst+80uIRAqDDWbNBF5D4B78jj0JZoZwLOR
	 iq9CBEpA5j1bll5yg1+p+RccPzTHfQY+tmEpvb6YmK2NljjO9TbKi1+wusic0cFzoE1sl
	 M2Vxd58n8avP0rMwyUy6wV8uSv12Fm03IXEn1Gws7BY/Uiiy8vhnhNqxl3A4B/M6BoWXe
	 fuiqUw7NcLexoSNLzQIHST7BALbhKMsZtcM5BQEV4UFe1LFM6y/aVKll9vh21Jo6+eA==
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
	bh=kS2UVUUMeeXYXkRssLv/FaG0DCanROGj51LmIOGykhM=;
	b=un1Lf3+6rBVTDzVWyuo8bNhsHPP8tB+VMdndsT7PDxlXjYDNbdWe1PrB+/Bz8JjFtjEM
	 u16eBr03IGt+nqLR9qn8ULTTjythOCJ4RfCYztRCif9P+yqPciOPVSmv+V9irh/eKQrgp
	 dCCKO4XmivrcazyAffP4GCe+tqYXqnmAs+PdxDErn6SUEOclFW01KRZnY6KZrcBdhida7
	 iWM/9pEYDDDDiSWWywfd5vqhgUlpw6Pbn6fb08M0dvhYk3MCmhI0uAuZ+HBi8HJ1K35jY
	 7C8QylQhKvOvtEvx4dpxZzPH9LLyG5nQWhnU/xnp1+7lbgu8aKdwYEP5tsEhL4x7S/w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=VIYBYqB8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.23
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010023.outbound.protection.outlook.com [52.101.84.23])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79317606A32F;
	Fri, 27 Nov 2026 07:05:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79317606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=VIYBYqB8
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f2hQ+zDSw5MVacx/yTEr9M2UeQJkLEpF0iMk2/2QWJHfW64p6B0YuCsNpniXmmZHDcP96qMYkRYmnVXmkA1esKomk+rpss3QNFdzi5Zc2kcrcnF8TxmypcvJk4sdqSXzs+iNKiLOSJN07++if0pdRut3DA5GQfpUjgPJLy6t9i9mq8/tw1UHUDNRsvB0YTqheTeyMQmAtHa0H9OMhXGQQSDx0QfUkITrsXc8Bsiyyjsl1CrV/LHIrChoczbfc2yg9YfM5TrpU5jttfWgqzHqWTc1bP4e7TWpvnHnnX6SvqZn/nybUA7JKkUxm7htPqJ7uOR1HR0t1QYVOJxLywisQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kS2UVUUMeeXYXkRssLv/FaG0DCanROGj51LmIOGykhM=;
 b=tANRZStxmID2Asf6HnLm90HfEcPVDuQJS9PtC4XgLyeJLY2H/jXEcs8XiYUsW7sq3Av80+aaQ7fkJpuj2YBVxzPpfov12119NHGyJJLlGae2bwlkqmfocbQwBwn8oSbxLNTg3KAATdrzv7J2YAJMBqfGOC/YS3vPBZGzXHZjFf31f7lMiia4W7xhWb4GH1Mdy6rLDJvtoslVFIeZ9KzHD+MGyJwVu6nArGepWWJdpF0mNHlvSP5cTovtrafTsD/kUBs5jqpmu+4lOM5fDnQXpR4QsM/USZqHns3oE8DYbA/bzlByghbnxs4vjSSHReeKLDMqlmZZvq/8Qw3weOcnQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kS2UVUUMeeXYXkRssLv/FaG0DCanROGj51LmIOGykhM=;
 b=VIYBYqB8CjACrmDO4i9uPqUronwlLYl5tB4/WCbZ0YTaHx2sKK3lqYxHvlfVZaPTRpKXuqqG/9b+kXThliSL32cLzkyaCIqT4SpOlC8FHjsWXRsPi8l68hA8nP43UlxT3DUmDLF2t5M9tGCzUUJzXjboZmMyfvm4Mh2arsJWt+I9FhHsGUdpmnKpC5v2XupjQ5a888H9BtLXdj4+N17HCHfHXbHm5aUzKNUWb/wgAf//NDMWSQdKsWRXV+QXFBrlh9QM9jbzVdPtAZeNixKBuTHWYf15rDGXA1WN7HYv6UYeLmlX501XCNP6URj1yJGzcBaerTYtaukNSvedfX3E6w==
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
Subject: [PATCH v4 2/4] rv: add per-edge dwell-time statistics
Date: Fri, 27 Nov 2026 08:05:43 +0100
Message-ID: <20261127070545.64265-3-tobias.schaffner@siemens.com>
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
X-MS-Office365-Filtering-Correlation-Id: 53ffe256-95c1-4023-6f8e-08df4c54d1b1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|7416014|376014|1800799024|10070799003|261009223027099003|55112099003|18002099003|6133799003|22082099003|3023799007|10067099003|5023799004|11063799006|261026140227099003|261022105027099003|261026121527099003|56012099006|261021123027099003|261021121427099003|261028144727099003|261102123227099003;
X-Microsoft-Antispam-Message-Info:
	pbkDiehTiE6a0pleqs1WXq+jKRXBGou6nvFHO+bmIQRtOvBEviAsVaIP4euIttD5tkBkvQMDkhOtm0I5gsENT4SEip//tRR/LnwE6FfzKX1nsinkINp6SvSKPmh0FOpZWmLPr6VwrXMjrwdBLnT6W0tkTatPRZ4aGAJFgSd73wttdZ0D0+DXcb3qP+GdfW/Kl3Z++LsOo6oSDNYaf8WieU4nmlo1tJbyRVXgQheicWNJ4VgsUVfHb2a76b/5+hLQXsl2mWb+egvwCZ1L8wGF784eWissmcKSxDYNQBa8yq4/ySgLQI6CBpnuNbC1tXBs069Gnnakh6uHhahe+CopJXt6jk62EfWMl+gukBelERwzIIaUOaq7eY0HGRrPU7Wzj1hl0bruIIyWbMnv3IW/yZM8cqlIKdKtoN6iqSnRWtcB3j8BC79GE/m3GOO018P6yEMp2yXpV1Qdr1ej2DNlV3og3Ro91B2JmDILpRn2azv9Cu9l7XTaWSvXdCEoBhTT2I/42XzaHVPrmBYq3ieHSyi5mw75BQLgLlzlufqp/KwA8tndyAT8XYWhuHSn2VjVSS9puzRNW1q7d7zOtlgsaMGRgJkwAfYrMIgEvm/q4T7dxPKSK3Lp5CCIEia4CjMyNwugdAdtFh86Nkzi/clHcf4ZBx84KiqTTCBi3yR5WD8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(376014)(1800799024)(10070799003)(261009223027099003)(55112099003)(18002099003)(6133799003)(22082099003)(3023799007)(10067099003)(5023799004)(11063799006)(261026140227099003)(261022105027099003)(261026121527099003)(56012099006)(261021123027099003)(261021121427099003)(261028144727099003)(261102123227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?16MihrhgUiLWCrkNv0dEjkri4OCVZqdbPCp7fcYWyJz0xOAfEn04NKIHICCA?=
 =?us-ascii?Q?DREPWAxNg8hrCwhiDD5F29++BGjssRAiKw4waSg8hYw8r3EuLoyG2+/QKSSH?=
 =?us-ascii?Q?I/7iNlBE3LT7ZZ9WmLzZjkumRoJHBMyRTyvcAWSyKtG+vLjrSV609pdd9bMP?=
 =?us-ascii?Q?dLwDA47f78iRzpHF72fa9ubKjOW1pWJg7hW4C1IqtoLxCgH9QtC5HuiVrkTJ?=
 =?us-ascii?Q?1hnVfHQdmLpmbhmNtuujVol32/akky6VTpnBwh39FzfwIjOZ0tVbu6gvk5Po?=
 =?us-ascii?Q?uBXp+i8NB1xUGZ08ocTwnc54yYrdu7KqXACLK8zZAcymGq2GszrEQyWcLNkV?=
 =?us-ascii?Q?H0eVJoHzMBMzqfGsFI/0mxQKVJUlIj1vbnH/0xvk5u52tWoF6aUbYAg95+Gq?=
 =?us-ascii?Q?V8dcJmIjLLkS8oLPjBBaQ0bGOLhmyLryG/dm8fBQvx6nunPuaOuhcEbWEAOM?=
 =?us-ascii?Q?54VdwzeiO3Ar3DopQkwxCcKYZNzoM8ASBGQFKVf+T7NWbOYRbS0itVEq12Pt?=
 =?us-ascii?Q?BXrBnELspeF/H2P9mlPRy9Fi5HOyMWViniftPTDBdZyhGHExNXWdlISukKtq?=
 =?us-ascii?Q?Ykr5gCHODWYfMNtMZt8qjCxx59p26a/xqnLiLyO8uaUVwnbGwVaSOfFps0pi?=
 =?us-ascii?Q?YuEkU+XPZb1I2k/AoKAzpUajAadQ6jSUnQZwU1anQKeGM6e8Xl/INtczYwvi?=
 =?us-ascii?Q?0qxg26j1MkXVcaO1YVN69z/RMAJHmVDFca6hyLl2QL+oLuJz+AJUL/j0GAbJ?=
 =?us-ascii?Q?CXaF43Wel1lKpQCrH7vLOFpT56SK7VTgydt026shaCLeBK3UuzGM86oV/TJp?=
 =?us-ascii?Q?AkswKx5a8FuFmN2UEu9uz+nM0KfvC/bQX4vKAZ7ctCDr1a80Y0klK4bgOmKn?=
 =?us-ascii?Q?EP2wp7GUDKsBQgmyzO7cswVbyAdi1SePLjN7vsx18B0HUukmgJI/7u0Ece+7?=
 =?us-ascii?Q?tmS3E9A6XuRkgklqk3eFad2zNrbChzO7elPmM63PaQNAyTdmFkp5f6FPd5E4?=
 =?us-ascii?Q?dZbN8eb7lmFbR71XHsWnIwe6xTF2rWSF547isLWj0TJDq6jw+vBSvAkTus2x?=
 =?us-ascii?Q?OoHO909rz+gkgmYSbcaLocRVePqOYmnXTyQdaegwISqyK6sqgs2hL/PmmZ5Q?=
 =?us-ascii?Q?Ndtg58WW6rX5TBlBYM5MdmPkkcANqwzFDms0r3zic/eWWgaqtfqFwahYirBh?=
 =?us-ascii?Q?Ci2qOO7EaaxVgxGGSurXKcozbBqk6li3uQeVEmS/uly7mS6OVwbrw0Wi6wGR?=
 =?us-ascii?Q?5r/+DH4/3Bz4BnZgCjHPNh9nZW45zyPGyGPtuHS+hQBOPHpsYMcf7BI0biAP?=
 =?us-ascii?Q?4n3IdC2SXCTkzoCWuSYkng8TRRojQ1gXAjMA3bLO9tMnw+6+hD7eWbm0gKoh?=
 =?us-ascii?Q?CE+jJTaccs3DD8fD6wvU5Zi4cu4XB6riP8ZDdTpsk3YAecQoQBILzHFs+BQJ?=
 =?us-ascii?Q?tVpTBaN9xDQ33ynZaFxUCWL6Y/XsTrh1wXOhoMyVwTdIwEy7lD7+upxUXTiq?=
 =?us-ascii?Q?rd33XYtRgzGot0eV722vi6LgbdD3zoslGcwMK0v/sQyPrTNdaCYbhSXY/aT3?=
 =?us-ascii?Q?6QUbh8a6dpdqFJ3CoepLI5bUFe7siZF2+DmxN9t7eUD4ESDm5uJATinHh41R?=
 =?us-ascii?Q?14oLOL5tRq3Jes0HQ8fa/n5LSYw3E/rIZ1v3QA2I73FB1dsJuCh9NdfjBeVp?=
 =?us-ascii?Q?35dQQM7Dy09XteL31ql2auuHt1I64Z8HDVOkhDK6rWJ6r6GXrF97U68rpGYU?=
 =?us-ascii?Q?s0CU4GhuJhAk2Rojsond34vEWhyZ2i8cjdkkDVoCEkDxWjOBK4cbFFgyxJOi?=
X-MS-Exchange-AntiSpam-MessageData-1: eqRyAgB3tOlcSNvMp/X74pLFQHGIaDq5gls=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53ffe256-95c1-4023-6f8e-08df4c54d1b1
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 07:05:28.9998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BNTs5FCkY8i/zqZL+5FH1TbqoL0tj/SdGqgzkViNhokEsw5zYjaCgunQWLMkF/kbkH8ZVIyXpEajzMlyYyI2PIxPbav1YGQ2MQlNfO6oCtc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5244

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

