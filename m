Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023124.outbound.protection.outlook.com [40.107.162.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139312C21F2;
	Wed,  3 Jun 2026 15:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780500736; cv=fail; b=SkhhbZqn7GsIYSQISR2zPTxZF4hWs9dVfEvw/zCnyMjWI6qaPEkJk5Zn33omXAurZws0NC0X0oA7pKtMdX9KnWGbfWLIhsgrUtf78DuTnfBlip2hERtUZtNm8TZDc5V0F7F/91odFUi/QroqeN1xBfvzjusdxNFF9gJpZ/xxWEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780500736; c=relaxed/simple;
	bh=por042yki7AhkVTfW8PwcyOx1xlXyFm9j59pl2ky/hw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=GxUe/qlhsdunRl20KF4SK3E+yKtftZg4GJQSHOReSlNBxXHxIYRwVNHNdxQMtcuaP/YWHBnVJ63c144Mk1q1jWzIT2xkyhdcVent+AS/954WKVFterO4G/JJ4/vYQ4bzZHDYuKq0KVXtj8Z6gPlMfdeYj4j5CL/InJdIgXkeFV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=nu7qvOt8; arc=fail smtp.client-ip=40.107.162.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="nu7qvOt8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aOOJ01ADRT7KUV12qk/dvfmjYrAsXVe7pbCJeXDDH4anfJAMMargz7D7dyag7RWYGI69c0nycOPOBe8D7Jh6yRjGXVEVa4VI4ekngihL+xQ3fUuTxu6pBldEi+9NWKwyjvStfr3JDPxA8e1i16wGtJbCGLcgHQoB2F6ua/J2HmVt9JkANdkGOOHrjDokJk+45qKi3iHKUY0rGWMLl4ReULIwRkil8lSH/Vdm+qawUr3Jz/kj9BRl6q8A65xWBfhP8yjJVOi+C1VDyEPrl8+kVFcNJ4A93hGRBD+vlVSBN7CrqG6i0EljZFTtwBIVgBL2d9RG61JW7hVt9SrsrZrEYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oLZ+ijzgqJddsfxcbdYRcEDRgkAlzmYrMrz2KmU6jiM=;
 b=p6UrpKmKHFTIRL0ov7YVWBJmWJl/gLZzMaqU4igMODtZ/FdRC9U/qVnN2V9fevC3oGoJbjungVtTOg/Ap8pF0VL+KQ/05b8ZHYAChBFf6L86Wt9BR/DIfdOfxUL+aCBd5Xk8yOGqkLhYfm6mSMmShM5vdzgNWgzohiBjUImarjT1snjOSNxN1Hyt7bHEvFA/Wb6R+xke05ZQafSVKARhSkNIwKLpfUHv+942rNTFRi8cPFZJ5SPwA3mws87fXpT0b2Z1xmemZLisG6pO78pJYjUEjpPOuVeYTu3i5njd1HQ4WEQOf2rx3/iUe+jZaJZo6ihEESo8TBn1xRN62pU2ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oLZ+ijzgqJddsfxcbdYRcEDRgkAlzmYrMrz2KmU6jiM=;
 b=nu7qvOt87xN/ahearNVK1LkOdvYVnVybmzjEW4wCL37+QTwOfq20SbL8onSTXAszH3gyNmHjhxMChGbMiTOK2SLWNg6ySroHG/Jy3pltdB+BODPLCEqlCmVE5IE/3r8Bn4v2QQtu5WDWIsYFmFyzT/PZy8TquKwYcH4lEnhnraUp5xipy62yI5EPRifmxJecCNayrhWqAck6ZvLwMqA3OVRb36A0P6eW+Wl6wxOBwcI/zX5v7tQq++9qMfTQ2sskeXvNwt684ziT9Hz8tFU1BhgqE/MEq0lQzw+4LYemfPMrQzWKGahejbsJMLhhIpHEMrPoYP2FI6ZozmoJIISCHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AS4PR08MB7555.eurprd08.prod.outlook.com (2603:10a6:20b:4fd::12)
 by AMDPR08MB11459.eurprd08.prod.outlook.com (2603:10a6:20b:71a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 15:32:10 +0000
Received: from AS4PR08MB7555.eurprd08.prod.outlook.com
 ([fe80::7d00:380e:b72:55e6]) by AS4PR08MB7555.eurprd08.prod.outlook.com
 ([fe80::7d00:380e:b72:55e6%4]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 15:32:10 +0000
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
Subject: [PATCH v3] tracing: fix CFI violation in probestub test
Date: Wed,  3 Jun 2026 18:31:42 +0300
Message-ID: <20260603153147.573589-1-eva.kurchatova@virtuozzo.com>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: WA2P291CA0011.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::23) To AS4PR08MB7555.eurprd08.prod.outlook.com
 (2603:10a6:20b:4fd::12)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR08MB7555:EE_|AMDPR08MB11459:EE_
X-MS-Office365-Filtering-Correlation-Id: 74e47848-bec5-4a09-443b-08dec1854739
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|18002099003|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info:
	2+uSSaK62kSFk1DJO4m9IqMcQX9SmWI8saX/HRV6UEZtqmIgEhuhslPXY7NZcx0vK43XAKQFrdg+SxwviljNEr6Br7Ba7JuU8XuljmzJIwtKdSRShQ43cZyIa9NUDBOpa3H4vExIYuJ2TGJH2ETeAUcmvi1CUBAE34adm/AynVTVGsHkFP119iiJLdo7/vDNUHiTAVyn57k5f39432szRxGXbipUgCXX/0yRMy1QJXIx0g7wydk2zX4sqYuFRzWDLPMmNfB8mrDNuQ3qq0MWmiEeGpvB/bkxa7klqgSjjaYOzcv+YZvBCMTXv1fwgTYVlpqUXa9Vwvhklw+rAiYBKZ3L1L3P4F21Ie9eN7Z8Fxc3roY4db6wbdq3iTj9p/HGn5g7DeNWV7xG8jREDxqyc4zfq+uwdM6b+z+hIiLkpVly+7YkU7JjkLvYZpYHfXnzpXZx/Qm2jwf8DEzbaRcAh9M++1LJ4ByE1mJ7g4iEzjj2uqwu3Z8/qsWgq6edNXcJSo5x60Bsai/pJIx8mpTlqmT6dRWJ9XHRE9tTxuUtOpLXX5QphSMk9bvFyipNxwy+HJgoQ458nXbHHNV3zIRxPYXEGyhTbwnhCbuYjMXs0fFbbI4bnq7L1wJp2uriUVQ4wTLp3GPAOkurKoRupcW7Ev48axfzruGk//gqgX8XrTIAtn/Dv7ofq4hm/ke4I4rc
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR08MB7555.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(6133799003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2yV5/iQ/P1N4FVLpRh1NFwCk7bPTd2te9GdzUsM5KZ1VNSidxnPRQNatCGnj?=
 =?us-ascii?Q?hTfqY8l3m1fbl9KLX04rACvO+bxNfH20vabVK7XsWUAxSSmfXcBoNqG84Ilx?=
 =?us-ascii?Q?hVSjrE56tkleZ9EeD/gLPSf9e/nJJOER6dC+JCpcZaZ8oNxXOG/vOqzotFJ/?=
 =?us-ascii?Q?SZRfHVbCsQUe5yBsqcy1amM4BAi88NB7ydryX+n0Un19vvhXWQsTBN4nCrRk?=
 =?us-ascii?Q?aRThINsua2hpngMgBQ7HsTsNMFO5eNQX441SCiOnoiCATDYs4y95fuDFH3w9?=
 =?us-ascii?Q?kI+Nr2lko39Y52/VOaRUeYQyx45Bkq4JhaH7KRXBA6nBlWVvaUUWxzepJcQr?=
 =?us-ascii?Q?JRB12/qo8io5D0ovgdlRVGMAIEckx4teynU6yejStPe/4QIjwc+6who2898N?=
 =?us-ascii?Q?qRuK6eVdDk2mEfJ7z7l5S2ufBzo+xezGhVgyfa3ADXlg1lDCICCVO2Y0+c2z?=
 =?us-ascii?Q?H25UtL/Sq8RKoCzFy8dHx53lesZy5O4fQI36avrSAWREgNL0wjp8gO4CHq9w?=
 =?us-ascii?Q?KCk+Q9g2RlDrTOQPI0Ua63alRh3FfxXHEeu1d+gti3ytzd27djauvVGHYxXr?=
 =?us-ascii?Q?EOhYZ7fsp+Fd6k/q4cmqAdOyzs0mEx8uUvWw6LcSamc0K+K2edlN0AKMBj/Y?=
 =?us-ascii?Q?NLZ5/LSbXve5RncQH+267jECXfzqycxhND8gmzt6kWGZcJRierqls2sNg7o5?=
 =?us-ascii?Q?V3i1Puzq4ImJV9QllSZXhaE+BMrgjSFMpi332XPJhlaaHFnpEYUchvXNPtGj?=
 =?us-ascii?Q?XCD0pDFtTefDQVPMKcJMHs6lZL8o//nqcQoq4jdy7kOQzOsJCONDMjJbBv20?=
 =?us-ascii?Q?ggWmfRsY/CZoJ0EJjMXZNIcjVpWhpXqV6+KvlbHFkXKkVXRMA8gHGgo8O+u8?=
 =?us-ascii?Q?GQSuW09BTdKILGCAz3c0JET1aO3P3aecZzX+B+K6p7jb8ge1c27fkWCPNf/R?=
 =?us-ascii?Q?qNQL0vIsPk5xctUuUf9aIa6Fz9vQWvxHaK2qvgtymO2GJG5KChvWoaESRZMx?=
 =?us-ascii?Q?WQM08549L5v1Ipbq/qVOTH707K0+Aapd+rhaLqUlebflW2OA45+Ue6tXKy0A?=
 =?us-ascii?Q?iejr+ISOtCKg3oVlHweK6bfaI2zWOaO5pCwhURfgTn0au3f2an8pMlLIaSh/?=
 =?us-ascii?Q?kmJ1w0hcAu44cIeQD0TqjqvOSjlprvR7xugBVLTYODcPzgUiL6NyUKXnjF3O?=
 =?us-ascii?Q?PSfNLQ4+ajPlLd5yjyPzalyTUVjRjxlee831ja19U43llHPndrcWfS7APK26?=
 =?us-ascii?Q?lwmhhv0VYrJcHREuwAw7juqFcwojRAs3XTM9u6Mxtp1Pnh41E5dMECT/jRsT?=
 =?us-ascii?Q?bpm02wLb8I6iW2rY9A40+lgGKjULbrX6aOstxHOrtb0TiX/ACxgHUEZXWRQ+?=
 =?us-ascii?Q?4UKx1MODnn62H5/HAy+NGbe9CJu01DuVfrAMRRpM/4CFuMvwcx8pIMCqX2CM?=
 =?us-ascii?Q?PW2CfGKZRmV7RdnstdUjO0Q+vGII5yZcAZxPKeFwrxuhdSzDtN3mELoc9l6S?=
 =?us-ascii?Q?eYOXF1HhTOBJDx2yaLIFfGhgqf1LQH9mSTu2qGFD+5uRkxammy41Eea3t7Ka?=
 =?us-ascii?Q?Qhl0soSEPm17eVWl+cC46KoJBC5nMvF+2cbnOemv7A65qg9C7rzg3IWONo4H?=
 =?us-ascii?Q?u6Jttjydz1aDyPKCoaVjeaPrAhkBJusYUq8rhtZVwfPT/dEcVft7lbWvSRXO?=
 =?us-ascii?Q?PW9tTwNfIlN3HPGbMRB05BE4OkLypmDiYZ4VXRpEnzIKANjIMxciKcwjVO63?=
 =?us-ascii?Q?QWx1ukJycsFSBQfmQ6tKBNg1Q1bbpEQ=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74e47848-bec5-4a09-443b-08dec1854739
X-MS-Exchange-CrossTenant-AuthSource: AS4PR08MB7555.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 15:32:10.4079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iOHpZJ5hhMFpCVWVMNjnChGR3i4Pvs5vsPNcPRQk1iWWPPMcDKHs8OjoKnNUtDQ6iVfod/GocXHh96qWtXjwIf0tlG1/OfAwlBm6W3wxt/0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR08MB11459

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
index 763eea4d80d8..2d2b9f8cdda4 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -20,6 +20,7 @@
 #include <linux/rcupdate_trace.h>
 #include <linux/tracepoint-defs.h>
 #include <linux/static_call.h>
+#include <linux/cfi.h>
 
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

