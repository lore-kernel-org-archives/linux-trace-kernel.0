Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2047.outbound.protection.outlook.com [40.92.63.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B52487AE
	for <linux-trace-kernel@vger.kernel.org>; Thu, 22 Aug 2024 17:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.63.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724348461; cv=fail; b=O/h0+MroMbZ3MjBOUWqF69HvcWrAbIY+ORchT+LunoW6ffvLUaRg2oHevvNQC1L6q7TYFTTi5FGLbhaCVgHKCW5Z1wgGN0ZHBoDeeN6eNowUlOEgh7iqdwt3zg+fBx1yFHZ/sAlgNe2uD2EVduASFmJUbCfbhj9lokawCo07Idc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724348461; c=relaxed/simple;
	bh=mKRrP+oR+o5CxbjXOWml3YWmpmwP2y5/ozrTvM35FsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HVmWywRCwMpxOdyPDVpqYh7j9dsS/mXJPStDUl8uCIbJTeg6dXSJfmlrtqTzasgSKlzsNOzEW71lVeQpQoZHAvN46eJw6I6nZEEu1VlYLxK1uAzHxbzKenCjuyDEltMfVOpE0kFVds5FPIwdbGXGOOPRDTZ35eJpp5LmVqgH6GU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=pz0/89Kd; arc=fail smtp.client-ip=40.92.63.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="pz0/89Kd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dB9USW8N81P1dfkFb73P1boIGWcRTA/IqDTiAohARk+vGOJ1CTQLl2L0QCPdS5EPRMpogB81fFesFKQh87IMFwmKDUnFcSVseZkiJWfAjiHH/g/PRpTWlGlHjfRNl8gKxmW+Y7ianaWzcrKrn1a0viml6Odsel6kntcTdUgqJChiFiTk51m2AadxI17T4j1v7wQAUzuBUT6YmJVVKEcytO+BrT4Fan9gnvMM5ZTAQfRnCO/nezo7KQsMyUbCgia2HWUHqxHgFqiKWyOzFttfkRc8YQyMid6QVbuVQzE3yVW34g8dbb8ETF0mTeGOMfMG1YbX/fdcoxZe2FDXELIqqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iFthCAGpv1gMmQlIweamK4Io6RjBnV5noWEvRGtPSvo=;
 b=x0cl209H3zUh7bxGMc1lh5Vdqvh6aBfMmdgTOKuMq2rF8wWxIUTHrGOxQueSutA+2dm4ngKUI8JrSsDLKH7Ylu7OGv8Rut7UCrBiLTRiS72Ci7kgUKGwvFw4cv+yQtql4MC+a9eCResvkMjIHJmz9rtbD7NzZMosAkfWH9GVCz/8bh+jz2/zOiYoLA5+Til4UwOEmNJYMuZ74daOhLLTZA6UqEnVbZQyWjN75T21sOz6/ddqX8cKhMk9u8Hej5Z/oQXpyFRIBVs30gFgLqWLNOQKZcZhPvYMX+zAkTPR85/rTLBBLUZpfhoUywGVeq303ELfH4QSi7dZa3D89/R23w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iFthCAGpv1gMmQlIweamK4Io6RjBnV5noWEvRGtPSvo=;
 b=pz0/89Kdj3bpC200Ddryv11wJazhEZ2mAe2NeNwwhxhqJoyUDdhBydgyMvZsus3R1Mj9gx+xCcHcmTIp4cLvbSPHC9sWuGCoAXHO/eU9t91jDmOJsqq+6YkMGLfvlacj7yooRDcnLjnsisObUsVL/ek/YEulEMLvAZYf0g1flmqURvEIjjtNo2TAU680z2bUzQsZsocbl7qgOUAju52qRZxFgG8+R/zmwSAkth2oi16ob/o7iJQKpgZElBvtnVcdRLe+FVlD8LoTU3clUDI4ByLEunrsrCBQgr91aHWXrlPskp8kPkW0JVIaW2VE9fNEw9CCPB1ihmh3pv+GAUjrHA==
Received: from ME0P300MB0416.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:22a::20)
 by SY0P300MB0722.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:286::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.25; Thu, 22 Aug
 2024 17:40:52 +0000
Received: from ME0P300MB0416.AUSP300.PROD.OUTLOOK.COM
 ([fe80::f5dd:ff41:ef28:710e]) by ME0P300MB0416.AUSP300.PROD.OUTLOOK.COM
 ([fe80::f5dd:ff41:ef28:710e%5]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 17:40:52 +0000
From: Tianyi Liu <i.pear@outlook.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: mathieu.desnoyers@efficios.com,
	flaniel@linux.microsoft.com,
	albancrequy@linux.microsoft.com,
	linux-trace-kernel@vger.kernel.org,
	Tianyi Liu <i.pear@outlook.com>
Subject: [RFC PATCH v1 1/1] tracing/uprobe: Add missing filter for uretprobe
Date: Fri, 23 Aug 2024 01:40:14 +0800
Message-ID:
 <ME0P300MB0416CAC1E33697C3EF5971989D8F2@ME0P300MB0416.AUSP300.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <ME0P300MB04166144CDF92A72B9E1BAEA9D8F2@ME0P300MB0416.AUSP300.PROD.OUTLOOK.COM>
References: <ME0P300MB04166144CDF92A72B9E1BAEA9D8F2@ME0P300MB0416.AUSP300.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [czOGj8m8Y+9qqbW0Q0s34d72a6xDJwggA+ra60OGRo//NXWsDbkOHA==]
X-ClientProxiedBy: SI2PR01CA0054.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::22) To ME0P300MB0416.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:220:22a::20)
X-Microsoft-Original-Message-ID: <20240822174014.2925-1-i.pear@outlook.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ME0P300MB0416:EE_|SY0P300MB0722:EE_
X-MS-Office365-Filtering-Correlation-Id: 51fdc586-834b-47b4-c2cc-08dcc2d19194
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|461199028|15080799003|8060799006|19110799003|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	n7146C8WIiDBRAqIS9aoCV+SMB0sZTqlN3TOkSRPz/u3dH9y50E209eA0ilM3cRxSPzTpAAdz/eMIQXuSZlYyxktKyJM8l4wHnQjlP32bQXhn4Uo2V25/DBH0xJV+Qqw0Y9Unqz8O3TYK38DS9maCKztSvjluMPXnG6Ib1Tt6MIu5tm2/gsTZ91Z3ubWQE+zhe4iCXtQTAiZpAwnZq2/NQrF3wGxfwoo17jB5gg5MBcaemzS8WjNe9Ku6y5nOPBwep19K6YNBu2Aczqxd54WVkNigsgQgN7ciFZcsRudCxYgxpzqeR6h7fIJQE8dv8RY54cOZsfj2d9Q9Uxj/QnIcKRKpgZdBwOg8/7S205rQbCbzOGK/qYgSKoxY6LfnnVKWYPE8iUeqqEd2ehqIWhsPx4d2TvCnGWXbf+A5rCvzPi3Kitw3XFk3f2fkFN7MciPlfx0ZAelEiUg0iKGSm074fx5Xws0PMK8O6pt12pPAsRJyXqZRe3GbITUWZ/+UiG1SO0vMZKMV6YR7ejlBy6MWX1vnKMlzsCgqe7nsHkRyBb0Sbra43RnVVcNXUKc0mfX+Lna8tEeE42JW6V6Ii7OXAh5dZTJjqO1n1Y2XzrS/t08mwsLEbRwE4FD6Colvv0Z0tEMGJ030lmQMrgU0WrWxQGCMptfAgLMyA6vucUTVYh8zyiPR6KwFXZBC71+4QLsazDohUxPGgYwNTam8eYoKNYF1YzeGWoibpDlMROnUc0=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6Gwg0FlnNyyPA0DudCis+CGoG3ZOPqWiKJjx/OH6RpW2ZgcYn4DY5Afb0J8p?=
 =?us-ascii?Q?DQkRPIsUthApeTDd5Ogh3LFJdiledXbgrczQxpVLVRLUnQHQjInMovhictvG?=
 =?us-ascii?Q?Dl4KZAQ4zeyDDXFTJM9qkn9Iqjs55aS2x/B9tSKyus9J0wQbS7yqw71Of7Mw?=
 =?us-ascii?Q?Ry8hWITFo+6d9UiWNRGhNkHrE5J0KLnpkvf+6a4pmO7VS0kjkeXMW+uwmjRj?=
 =?us-ascii?Q?/EyU5hhFhSMJJpqjCwETu1IM1Hd9FTEq0BB4/c4s3bsxXcUaUCVHF1chktmw?=
 =?us-ascii?Q?00ejQvJvFhUzdU85f+Ws0mz3Wn1dZNkyY2FpYyM7GQIUulWxT2/7NesHmoAC?=
 =?us-ascii?Q?fq26jLSs343elanrebxU7DMU5gejbPbaZCZjf2q0FPtH41OBgfk9ksYv6ERn?=
 =?us-ascii?Q?NX892W2NwmBHajgQhVLOz1bbKof3ZZLMtdnrpbVSsRJVaWlS5S8KXlEq9McP?=
 =?us-ascii?Q?DLac6gMEWjUDz+UqNkcTvhPp9Le7QF23jzdz+WV3LlseH5CNIjRPwxfUa3qu?=
 =?us-ascii?Q?AmW0b/5glRu7lc16gT8QjktHQjzuO2f7Yd5V+wdkGf8ZUTYve3AAxlNxVbdx?=
 =?us-ascii?Q?q9wSqS79Q7RHFHDkxjmg8h+5ZINNexrCtGwbXpY7ToEfjqvNvIUPM5s+XvTw?=
 =?us-ascii?Q?JKXf+MpZaFtamwxVej1ypZS1PeKdWBjCHWI2VEPfe7LX75IG8qU4467ztzKw?=
 =?us-ascii?Q?rMW5P+BLxIlHDJr2eFnWAn8Jjvn/3o0XCMzFawWuqE2huHGwVR2bRN7DlWjt?=
 =?us-ascii?Q?G5m+34P04opyAEy1gPii1627ItxKXFMRJIBcLQn3QyniblnoIZlPxV29/HSm?=
 =?us-ascii?Q?RdakaGIfaK04bz3YXlbbMav+hrCoYuSJs0mte1FxNrr3HnaHDNuCjM4x5BQB?=
 =?us-ascii?Q?Yq8/MKo6lSuSdLSUTQOZK8dj34kLyZtjBhb47+rUi+ojkuKBuL7CLqRGal6d?=
 =?us-ascii?Q?SKenKNFrMXkQ1Z1nd+yZ0+thkH5jxMG4y+XcqMklfLGrW6ezoS+CfSK0WJ/E?=
 =?us-ascii?Q?dzO8nehIWyg3cAxR0BHqiZg/IrJwQgeq6bBjJoadJNQ/KdOgg9n54ySImCxF?=
 =?us-ascii?Q?kOrLgCDVP8y6kB5rG/JmoAqlhDsiWcMNoNOl519lW1KZE8HDYjMoZlFkoC5o?=
 =?us-ascii?Q?plT9JSVI6ucHiKPvbkI0dJAQ3v7oZMVpa354+jZtFNk7jZqsdo31x/iSYhKB?=
 =?us-ascii?Q?58fDTJXzY/YrM4PgeMvEzeoY8pPlXS6QMu4zmquhjxXHsoDYdMz3ny9BMXv+?=
 =?us-ascii?Q?A4v8UT24sf34cuNbe3jeixA+arPLiIdX0mLcoql0aw=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51fdc586-834b-47b4-c2cc-08dcc2d19194
X-MS-Exchange-CrossTenant-AuthSource: ME0P300MB0416.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 17:40:52.8399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY0P300MB0722

U(ret)probes are designed to be filterable using the PID, which is the
second parameter in the perf_event_open syscall. Currently, uprobe works
well with the filtering, but uretprobe is not affected by it. This patch
adds the missing filter for uretprobe to make it work with the PID filter.

Fixes: c1ae5c75e103 ("uprobes/tracing: Introduce is_ret_probe() and uretprobe_dispatcher()")
Cc: Alban Crequy <albancrequy@linux.microsoft.com>
Signed-off-by: Francis Laniel <flaniel@linux.microsoft.com>
Signed-off-by: Tianyi Liu <i.pear@outlook.com>
---
 kernel/trace/trace_uprobe.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index c98e3b3386ba..c7e2a0962928 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -1443,6 +1443,9 @@ static void uretprobe_perf_func(struct trace_uprobe *tu, unsigned long func,
 				struct pt_regs *regs,
 				struct uprobe_cpu_buffer **ucbp)
 {
+	if (!uprobe_perf_filter(&tu->consumer, 0, current->mm))
+		return;
+
 	__uprobe_perf_func(tu, func, regs, ucbp);
 }
 
-- 
2.34.1

