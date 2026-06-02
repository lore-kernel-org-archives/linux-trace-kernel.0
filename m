Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11022131.outbound.protection.outlook.com [52.101.66.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B80921CC59;
	Tue,  2 Jun 2026 13:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780408495; cv=fail; b=Gg5qQKVLR0QGPUjP0oamlJsEIm0WRMOXm2T72jjgNpNDmMtsBdE0b76B+SP7olZoEJ2x9Y+pXoWs11OZTkyGmoHCzeGZs+ISwbfHt+IBiOliGCm4uVLGi4MJWbw3+2HwO1MYE++uNDKCXn6WDbryXVhraP8XQo9UC2h7hU25Mdg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780408495; c=relaxed/simple;
	bh=wtubTvsSSAuq9Fg8xeEn7yNG2H1W7JKzbQL09zL+CO0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=DFc6sPrOqFssyT70YQN+MpSDrYRU6VahZbFJ8+PGNSeU2MMu59higZRdXe1uHq00tP47tezLMDLZA3crRhgR+Lt3C84o5URULgQzPlJvr5wg2h0vKRKN2FUZqT+E9fuFW11Knu5+e4JKFVKOYLvh3pqUnfJprceiOss2B50s67k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=S+nMQnKT; arc=fail smtp.client-ip=52.101.66.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="S+nMQnKT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xDoqc6vpipByHbjZoruBhnPpFcdonwt41k97A3Ee8qZ8Vnn0zsDt3CEeG78XBV8UPtQwIAyXORpvtw/LFV8ImRgcG9jjLpdlP64P2r7hQexKQPq8C+0hd5jdA7mDrriGA/JZfEulQUAhKK5UiMMooXt5shpWpocIfpoR7nXTn3MWQ0xSsczV2BTiL526ZWgFja5+XKXc3wdhl08vAtUkvOgvJtqVJuZh0Oc+Do91+0zgl6xK0skz0TlUrmVDmHN3eWxdXbEFY6Qb5VqPzReW+TLFj0yXmihVxo2V1WGuOZ5GlkwXiMhGlNPwQ0aIc1kKPKUlB8rn+dVP18Sn30Hd5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1xGyWu1As5uVAJKt2UY0V5vKlsiQZZBY51oy1oYnJRM=;
 b=Mvyzueb2jnu2c1Drvr/5WO5gdzmH6uFgGVXXpeXUDimy6jXFoAUXLrcN47flCxKYapRWtCinf3dh4t+q5vTUQXU6ynLb+s2k0tEs98Iq0RMfQTlVATcm2CVK8WIU5Qwj0cSuucrH/fDWNtIAovPD3KneAYmA8sTfsrB8efQz5G4vB2Nz14a4aqIJPoK3Nvj2M2GxHeBwofZ2ilWVjg8R/If/AMbJU407rN6MPJYUcLFYhWl3me/bO7m5l/ptH/Xi1Lh0Z5ZMQhOCmkdoW5sMyeVN+ekv9y2rPJPdCdUyMJB2vr7okfOC8UhBsRc2MIgMigWk+9aTlXsQyw5IlXhBEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1xGyWu1As5uVAJKt2UY0V5vKlsiQZZBY51oy1oYnJRM=;
 b=S+nMQnKTEC4zu/oHWn8E4bWG4Ubl5wLNoNlWn7UlmKZAYqCbBjbtiLvHD1/bYg/249+f0hBJyrTfH1wJkwGINjFva5C3bArn4N5429BqqjDG8TzVDgJjVpfg6fqEundOeIKLRH025Bes2/Uii1GPyxJziopCHql+/8MYFff1YAms2RNgG2tAt3u3EUhEHhgfHDAqt5Hb3byyDGMtKs9n8DJkGwfwPogKrby7CxmkTzyRoYJ78Z6SpUZt1SHuFTfeHvn/ZG4cAIOulnbHG+F3ruO2Gc8Xpvj51Gc4SkBBnHkUERyxBJNE6UVahcxX05o4pwugHdKyth0+RzC4OBrsZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AS4PR08MB7555.eurprd08.prod.outlook.com (2603:10a6:20b:4fd::12)
 by AM9PR08MB6722.eurprd08.prod.outlook.com (2603:10a6:20b:302::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Tue, 2 Jun 2026
 13:54:48 +0000
Received: from AS4PR08MB7555.eurprd08.prod.outlook.com
 ([fe80::7d00:380e:b72:55e6]) by AS4PR08MB7555.eurprd08.prod.outlook.com
 ([fe80::7d00:380e:b72:55e6%4]) with mapi id 15.21.0092.006; Tue, 2 Jun 2026
 13:54:48 +0000
From: Eva Kurchatova <eva.kurchatova@virtuozzo.com>
To: mhiramat@kernel.org,
	rostedt@goodmis.org
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com,
	peterz@infradead.org,
	jpoimboe@kernel.org,
	samitolvanen@google.com,
	eva.kurchatova@virtuozzo.com
Subject: [PATCH v2] tracing: fix CFI violation in probestub test
Date: Tue,  2 Jun 2026 16:54:08 +0300
Message-ID: <20260602135425.542073-1-eva.kurchatova@virtuozzo.com>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: WA2P291CA0020.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::9) To AS4PR08MB7555.eurprd08.prod.outlook.com
 (2603:10a6:20b:4fd::12)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR08MB7555:EE_|AM9PR08MB6722:EE_
X-MS-Office365-Filtering-Correlation-Id: 82503f75-31e5-42f8-74da-08dec0ae824c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|56012099006|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	zgngjiI3V+MBiDsgnNT5wI1+AvQHnjC3bIG9Pfk+3blaLqwnwLmnH7g26aDaQkQYhuhnNDv+XywZiy3PW8lLYbPM07S2itzIMKNal4Q/KdmBc2RcruNDd0fj9CBn2g2+5jyUmVGKfhc9vg1b7RP9iIL7YYBQtNfAqdKerOvKArJVMGL/9aFE9EdL9RPowrNzir8OrsHBQgqDwwiI+LcnV8rQ1o4uWFZxEXfm3EExzGldq6salO6Ikbum3JbMJNFtD6dOlFhmYHPm/6QrWAXenP7jEHdZFZVqE9EDyUIIoaCewHPSmD8W5jXUEocph2vJKzcWJ6xMAnPqYoPkS5w6oXNln9zuM0Er06DHmm7YefX+pTZgJGX3meeePNcaJsVHNvbRqCZKaJ9v7S+UeeZl+cQ5usTLc+sqYwOoGJPovm4zNyo5pP5st/TQQ0QjtRh0txDCXLkGSlHLjcPR4/r3/ilNnXqlc95avGMjEPa4RYR0ufah7wkIPUSvRV42cQ/FDPMutK6Aoym5My9KAFOTdB7C0Qib7DTO4zPwDofZTMfXrg7+kzNoXhT1fywIKOzK6Li/EqaIkZBWBKk3Kkw8ySzC8J2gQKYE9sRtxDz1vZZZMArsw4gCx30AB2h0AuqQ7exs5Lp3NtnQTdA4M747Uk7IW8XFoXUARTa64SuOcUNEwpAUx3IDQ1etlfb0Ejbq
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR08MB7555.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(56012099006)(6133799003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EiR0GAtXdHfbcGhOgtiNDGjosHw+55Qe9sm4E5eqotxULFohdyyNlEppA9BO?=
 =?us-ascii?Q?SBbAAfGEsY0CUTktcJ02ehxYwVGihHwPqmVmiZR9OHxRUf1k8TeJFiZKiVq4?=
 =?us-ascii?Q?HZE75k2HaNVSPLtufevi2La5s7Af/T+/bsGFOuY7pD+SPVpu5vpG14ux0V7d?=
 =?us-ascii?Q?ZoDIp4wBMh2e25vn7F9n2QCCfseH5zwjp10GF+EkIuTZTUDLhmXab1nhhp2q?=
 =?us-ascii?Q?OLuwKv/cFQXBqtyxy0ogI5eUemraF3ipx7BBSARmQjLwIFDU84C+fwLv+Ldo?=
 =?us-ascii?Q?pgkRuAHq42RhA3ngHw177vWnsFkAFsHuhLNUipMkHaN1lSsOfHxD55kIwbi3?=
 =?us-ascii?Q?4PxkZqdYttd91kODw8vngt6R5HB7fDkDra3ulYt2GUkXfyYuZ9fqXdAhT2el?=
 =?us-ascii?Q?dX9lA/h9nKxPVG8lyxHE3GvUW8cQRVeit9q5ApwJEEauJjNIZbq9PuGiO0Hj?=
 =?us-ascii?Q?GDRktg8lifwsXnNiXMBXgdFHRr2PiSQ1UUXNnG73T37i/DlQTtVtOc6Wfjx1?=
 =?us-ascii?Q?10EA26CoJZrd5QQSsQaWC1WQehphhGbsa7NS11IeAfrARe9J7P0As6lbUz/S?=
 =?us-ascii?Q?r01VlKAif5j/VUoQkBcvePfZOBwIiKijLC/LjtH15nB7mlCfrfCPmlDtXTIP?=
 =?us-ascii?Q?OwXQBa2ls0jQmUfymtW9nNVDVh8p5R4BE5I3dpy9Xm7gTJNs29bQsYBmb3ms?=
 =?us-ascii?Q?3E8p4gZK+3sXnFgBerwu8XO55V9jCUw+2hS4sJXElXig71atzLtti+3BcsE5?=
 =?us-ascii?Q?K+GhsE66eI4fX9T6LVeq4Or9ohY75Ywzq0tL8DNV5jYzMww5YWv0ZnzChysg?=
 =?us-ascii?Q?qxakeu2iIIFYQJmDi2qP4vNPO/7/IIRFdW4dosIEUnFhYzTo0MJoyMRwLnAY?=
 =?us-ascii?Q?2Ky5/dzqU+IpWec1uEeu9f0XwL8u9d2iOnl89ma+hi8EwPbMSNoErpFmgfUp?=
 =?us-ascii?Q?9+gGdh8i7v9qy8aAYvHikNdn8pjOLi0XtW7IlrXLKsYB3NRAIpSZYvXR8s7M?=
 =?us-ascii?Q?DLHCfiPNf3rjqY2OYSDexzCy9OMEZls18soobeYxAQX0sR8/W2/gEv0P7i9h?=
 =?us-ascii?Q?04B0SzarjkEDP9hXbsuWWcS02lwF97Qp4xptu/7eso3E/F+uLUxVC5ur+Ud7?=
 =?us-ascii?Q?HTCG0GGjiQROwii16mdCf8zV+hNiB3Tr7dsCMdxwqu0xtsJkjGrdkFJvGncp?=
 =?us-ascii?Q?YZyup9ijT7Q/GK4pWyTCUeDuP1LoRszdE702uQsEjWDFuB+RCQzyLTcvLTIM?=
 =?us-ascii?Q?XNfANVcTFrRXIMw0hTwbgWDcU87CWOpZWrd+lxpxlFEgcZ/VWjEMQcbWWaaP?=
 =?us-ascii?Q?anOmAzKXKkPAFxuLobmuu4zrufOBHnpzcANuSnaQ3+XsuUaZoOOS1Gtbv6wA?=
 =?us-ascii?Q?nXC2D68W9Kp4L8zt8V/Ln/mktaxJoY3UO/sVodxuqlJHtf3sH10vF2lMYbIx?=
 =?us-ascii?Q?mp17+rN4C80pZ1U95DxFOcRZhKqWAvJ+glgSRHnugka2pk2ANQkU5VBRJLJE?=
 =?us-ascii?Q?tR1a7WgMcyFX6uzgBCqsHNSPFFAHMH1G12EYwnIZp/dqYvdfmcAAsbkYcvGg?=
 =?us-ascii?Q?3sno713ej6+zIeSmIyNYqH9PPEPGyafphikK0MZHskdqQ4Zx7GgqYJrzKLrU?=
 =?us-ascii?Q?r96a3/+LAqFugHfvxuP+h5hjcwh8r6aj4bPLybym4TIEWw+s0ppDqqBMaDpI?=
 =?us-ascii?Q?yo6yNCK3qZja7KePu6PQi8IahwibQry4JXclPZUIVkMNYHtWz+37OueEqbVz?=
 =?us-ascii?Q?rq1zG5o4XhY6R2SN+CfHxR3Z29tW9JU=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82503f75-31e5-42f8-74da-08dec0ae824c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR08MB7555.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 13:54:47.8836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aVzfWP/mxWE4j2GOObHKudY8LWGkc8z05OuZuawQ0PgOM2VrOCz1gvhO07mp1BI6mdVgdOyd8oztknWqwSiY7kh57qpK3tAkq67LtTTkQQQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6722

When multiple callbacks are registered on the same tracepoint,
callbacks will be indirectly called via traceiter helper.

Pointers to __probestub_* callbacks reside in __tracepoints section,
which is excluded from ENDBR checks in objtool, causing objtool to
assume those functions are never indirectly called.

Registering multiple callbacks using sched_wakeup test will result
in #CP exception due to missing ENDBR in __probestub_sched_wakeup
on a CFI-enabled machine.

Fix this by adding CFI_NOSEAL annotation to probestub declaration.

Fixes: d5173f753750 ("objtool: Exclude __tracepoints data from ENDBR checks")
Signed-off-by: Eva Kurchatova <eva.kurchatova@virtuozzo.com>
---
 include/linux/tracepoint.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 763eea4d80d8..38e9f49a71b7 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -20,6 +20,7 @@
 #include <linux/rcupdate_trace.h>
 #include <linux/tracepoint-defs.h>
 #include <linux/static_call.h>
+#include <asm/cfi.h>
 
 struct module;
 struct tracepoint;
@@ -389,6 +390,13 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 	void __probestub_##_name(void *__data, proto)			\
 	{								\
 	}								\
+	/*								\
+	 * Annotate the probestub 'CFI_NOSEAL' to stop objtool from	\
+	 * requesting the kernel remove the ENDBR, because the only	\
+	 * references to the function are in the __tracepoint section,	\
+	 * that objtool doesn't scan.					\
+	 */								\
+	CFI_NOSEAL(__probestub_##_name);				\
 	DEFINE_STATIC_CALL(tp_func_##_name, __traceiter_##_name);	\
 	DEFINE_RUST_DO_TRACE(_name, TP_PROTO(proto), TP_ARGS(args))
 
-- 
2.54.0

