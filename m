Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.23.36
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793784128;
	b=3bW7WH5Vg4EkA7oGsTkZnvRdXcw8B4VQzBxEbeAWI6t763k/BsmrRQelZzKJlKEIlJ2V
	 UOZOhHhUC80OTXDCuBGV2AH58YF9icaJr6280YFCB+g9SisPzUjiAkZ1ZH+YKMFQA4XBj
	 EUPIM2fB1MZZctXpzxjC4z7pLsCohmd8Bi0uGzJiMJ/J8fMEDEid5wMigA91frz5jMAza
	 aETFuFG0hWhRK18+VivJIbU3Vl4IjiESMFfl38tzYTYTvlINPK4SCHIaueGYuo7q9H0m+
	 Ilstm0ZnVLXZOEIifRnW9F44fDxxQrThT2nBdN7oaqMJTU5IEW5C44tg93QUJabKtIQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793784128;
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
	bh=9gLvB8/D1AVqvjQav4TyF0sLqA8//yF6rrVZm3TmDYU=;
	b=suX/LAkizHqb29MqvpqOxdAk2nYJkSn8LN5GLvXIOMopkRKTigudpDQpRD+Yprg6kwag
	 3bGusgSwTYOAgwwjWQUlLmeOsILkSTEcMX1jhb0MynQJkRU6fjVl32sojoW5cI3cKao8w
	 HMUgibgCkoG33VYoBBtgnxE+LUt7217mfLUOpJ6rg+Ml36vfvfpdF1jLn3mqL8D/Jxswp
	 kSPNBZEmodBqtBRyjL2KaVLtc5UX+YtUxa9E88oGpSnMhh2kFDY+fkuoDcVfiVmlj8372
	 hoixzb/JwGfpLH2l+WAcaPqeQiJIgoIpRez1Bdmf8xtHApiMrGJ6EQeVS6N70PtDw8g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hotmail.com;
	spf=pass smtp.mailfrom=hotmail.com;
	dkim=pass header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=qxB6ALXX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.23.36
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19012036.outbound.protection.outlook.com [52.103.23.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C97606A339;
	Wed,  4 Nov 2026 09:22:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2C97606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=qxB6ALXX
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kjx+50C1aH79fVsSZXZyuCTkaTwwea0J5WareSVzafEYMHLBXP12dKp/UfO2Xkai0h9xwNbhRsRQXM+OHaEd1y7tyjvW556fL7B672YtfPecGSqOU2zzxGU75DFBKAdYfkwyCc+V2Cnv5nh1CjsRfWSpWwtX9D9dlyjbaQnevNMHopI8flMt8TbdO70H/6XFbrJRkNmwwGo1NTuehR+SSih4e9m1SG+6FamEexW53pOdsamr5zHKiAHl5gSy0fAeeewGPa+1w1OxvXE1rMs+Z+yDffCjMndtV6JUJ8JRpV4FhiWG17fB6sIRd3R5ocR5Kxbj8Xh5YZzhabHUt1OJgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9gLvB8/D1AVqvjQav4TyF0sLqA8//yF6rrVZm3TmDYU=;
 b=iv07vMBirDC7Rch1iMpwZmn7qbR3rFMnOC01DcADdSTRzKvHN3aVojynBHNFoWwJflHg+z0LsVYpnf0ZhKsKSgUMEALG/qj/ObX6DnJsRRBY4s7YGSnOU1ZV5qntD8nv9Ynp8yiiI/KEibYVsNActkqohtCw0Fwv2ZYycFk9miHYDh+dkg8EWatnL5Dwra0+1H2m7XlMqASSpCxzkAKVmiD52cuFQDEiufZo466q7PcoEAZRdLvWcuqlFv2KoRWuTkQxcJ0jJ6TTilrVedeuU9PDspIXqI+J+afXbrBjSMbOhjgQQRDEqCZ0JMH1WKjFck7pSPrxDSQoNMWe+3pj7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9gLvB8/D1AVqvjQav4TyF0sLqA8//yF6rrVZm3TmDYU=;
 b=qxB6ALXX0lOgehcsFw1UeZtsOTY9j/DsNNVRV+McHE9VoDQYg2neukuSGS9JcZ04aRe1kOqLBBGREtZcQjrxuwak/hOVEKJ/H8t9m367WwRJ1waPHw/ysR+Gg6i+IN2egD7lnFqmROvDfwOnf8Zzm4Gv7G4eHDXDxAy6FsOKrsfB1dqJlQg3CCbprZXITHnMWrERgLzeZplX/n6ieYoMzPqQ73p2iIGhgcDr4uulWHMzy6XNyl6MfC2e45M620t1NSQqjpyPTaW3/jlHzE02K0iEPpjArI1SfGl4YNgor6luWNwMmBu+FoOc8MtoPoQLxUD9fqsQfDURP8xm2XicEw==
Received: from CY8PR19MB7009.namprd19.prod.outlook.com (2603:10b6:930:5b::17)
 by MN2PR19MB4063.namprd19.prod.outlook.com (2603:10b6:208:1e3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 09:22:05 +0000
Received: from CY8PR19MB7009.namprd19.prod.outlook.com
 ([fe80::905f:ec34:5f65:aaeb]) by CY8PR19MB7009.namprd19.prod.outlook.com
 ([fe80::905f:ec34:5f65:aaeb%6]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 09:22:05 +0000
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
Subject: [PATCH 6/6] rv: Do not send the trailing NUL to userspace
Date: Wed,  4 Nov 2026 17:21:25 +0800
Message-ID:
 <CY8PR19MB7009D39FB627A9576A9868AFB7682@CY8PR19MB7009.namprd19.prod.outlook.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <CY8PR19MB70098BF493A3B67418C7B9ABB7682@CY8PR19MB7009.namprd19.prod.outlook.com>
References: <CY8PR19MB70098BF493A3B67418C7B9ABB7682@CY8PR19MB7009.namprd19.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SEWP216CA0095.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2bf::15) To CY8PR19MB7009.namprd19.prod.outlook.com
 (2603:10b6:930:5b::17)
X-Microsoft-Original-Message-ID:
 <20261104092125.915254-7-liwei1412@hotmail.com>
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
X-MS-Office365-Filtering-Correlation-Id: c1413076-d859-43e5-195b-08df3a551731
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799015|16051099003|55001999006|25010399006|19110799012|24021099003|260925184616899003|15080799012|5072599009|23021999003|25031999004|41001999006|51005399006|40105399003|26104999009|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KfdPqEjGDuh/4w+lgCjLheZZZZnJkwVOpzuesDZWRQSzWf0lTkEtRPVVHj3X?=
 =?us-ascii?Q?LH0Rj0IaDwieMMj5uIWIAus4fJnDzuIVAWl+xGcO5G33Nyb+UsiUewia7POi?=
 =?us-ascii?Q?2Oi65ITTx1pzJU69rifVYyrSRLYmKxQjm3odZVvrY5NMddrcDIFOZKPHA5sF?=
 =?us-ascii?Q?siyt64jFz4DLeP1/EeeVvCfet1BBd/rBeUArRbteVnsFPSedRIo8GURgqF98?=
 =?us-ascii?Q?8sntw8MbS0TIV/S56mwwY6ZU2Ju1fymb63m67NnOw1vhausWjKJQAQs2m3SA?=
 =?us-ascii?Q?z1dlhj7mqP4lgOLZnPpsENhO+LT1JaRKCKrfyIwOwjg9xrj5/IWxifc1gACm?=
 =?us-ascii?Q?gm2CWGEIkQWKZXR/wyZtzCi3hyT7pjwbYpP0rnpvZAtOhBrQ5kHXohLQq58e?=
 =?us-ascii?Q?gVKwb8r9KoOZytYEgJb6Cms+8+UjZ2lvopGC+y6vwz6lEqDt04YGa1oVvs74?=
 =?us-ascii?Q?rBMdOik8Lnt1xhHB+u3LMpA0pdzZtq9GpB9HxnCvfuXzn08JMYvm4pM95WDc?=
 =?us-ascii?Q?vz6J9l7kzE8gkb7h12lUzBo4EP/KgpEW33ncXDrXWP1ngmTebzoG1YHfiSQS?=
 =?us-ascii?Q?7qabssU4khFPbj/f6o+IZmK32xfaMwmMWyNdNK1eWpXbPl8ghASyEtLP6fKO?=
 =?us-ascii?Q?gPz0AlGrOSFx+Asuo9BG79C+mUe2WPFxfsT/kKv/uZ+0xY1CbjtWeQ2n07c4?=
 =?us-ascii?Q?DVCiNSLahVUEeLzJRRTmstgnhI5EBJL/0BIyr1GE/rf9iVKsEDCVJFsLK22o?=
 =?us-ascii?Q?l8SWLJUG8ZG6w9gk8/jMXLoUKUqJQ9OE5QGXPRujePdesbhB43lSRvmh+Uaz?=
 =?us-ascii?Q?A3IDFLOybuJosucIluy4qZzeXMBGJ36GQUE8XnQs3gkqjVjBAZwnU1n+k8O+?=
 =?us-ascii?Q?10MPBd++fvfgQtmgs2SQGQbDjhRSPj9SJC9sDU4+nMmWC0chdbATg+vqKxpd?=
 =?us-ascii?Q?uc1iEd6eOWmow4VMru80LWKF+g/5JVAaRpunvE9OpMg/Yg47ZNWYjYr9II0E?=
 =?us-ascii?Q?mCc3nSvan+x2oJD/4uaJTcF4YWrur1uQYDQMepsHIiRK+9J8Ys6pjkdvF7rL?=
 =?us-ascii?Q?nU6C2KVO?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jSFrsIzZ4yiB+YgyyPDKl8CAaccFMgYqZZgCJUh2LOg7tZE2bunuh9fjqAaW?=
 =?us-ascii?Q?f3VKeYHRuhzbCB7wS42Za1K+gbco0N/z33dPYTH9hygNfL+/PuoSb9NY0thG?=
 =?us-ascii?Q?ZlacSEs0yBXBJ6vgtT5sYWIZTni+JoLGhrg5TjoFn24lrYbC8zURXFbkw4vF?=
 =?us-ascii?Q?tRX2VzGW44IB16ZkFuQ8jcKlpHuueIVUDBzcQM20a7WG6amLpIp8jXjo443l?=
 =?us-ascii?Q?V1LMxxEVGeGYOz2xMz4dV6DOQVXRTWaL8UqvOp73XX34qH8ItuysqbphFqPG?=
 =?us-ascii?Q?tf0zvJak1x71wvzaJfMkCE9pDxZRVwDg5JaAvRj68Og8qJpCNr0M1rLQ6HeN?=
 =?us-ascii?Q?dzDVWezL+w6H/DwYJLu9hgIQ99vHo6cyuX+Te+xJwftUiOD2Usc+/IWl/9TB?=
 =?us-ascii?Q?Osf3OAh4bwdX2d/JAWR1Zych1YBRDwprHPaLSgWXit8laiZ4jRXrAnaxew1k?=
 =?us-ascii?Q?7CnHC/B1ZNOEu8prQuJJ4Px3/fEyr/rNnJguasfuxylXwGsHXJFpE4h1ms6H?=
 =?us-ascii?Q?Vyojwss7bgjB6lHF3Wxjiw8V9VLjo3uK1LnQ9LlycyPPIOkYegSf5nX3N8Iw?=
 =?us-ascii?Q?z4SiYNJ2d2dWNCE94cmzpTK3pVX1DJ/Iv0hdaZhw/lW7ELb9t1qjByoTRX3o?=
 =?us-ascii?Q?4AAXtkWe64cnKtfdvXT87Edat6WcBPck1cbjV89b9QZV8s5czHOt+x7zS0BD?=
 =?us-ascii?Q?Rr/c/Qfp16g3ajjz01V+He4A3rYlaKyd78CX+Bt5ZWzH/1pSkTOgbXAq5Gkq?=
 =?us-ascii?Q?1OiDUzkuxNxyZeM49bHvkOoy7MkOZKRsV5DNSg8YeaK5HcczHdiyQYWKsFhk?=
 =?us-ascii?Q?+40sNyi5bCYnPCx8NmuWYHQRoLl9Sz7K17IZ79upwRz5vV5JMnMlSJXtPQUx?=
 =?us-ascii?Q?eCrMuPS1X7Gdc7VFSPiUIh1VeXChhTA9VFj+3t2AYJVpMUK8ygkd0fVgoPaW?=
 =?us-ascii?Q?UBesz2G8G35YmOdqcez60Cqoeh7KYitgUISUE8W61pcJRcSwfwSwSZtOKsAa?=
 =?us-ascii?Q?ImCZTHnK+cKJ/DXOB71HVPEj8T2dEUcHMVQLHQImY8ZQZGypr2g4G9PXlxi1?=
 =?us-ascii?Q?d/cvS2BKDOuZzV0SBSU/D8g6wLMshE4fEgQdvugwKy9AT1iA34OrdDTu1OVa?=
 =?us-ascii?Q?VpduATFJ2wQ2c76dRHHz00UghzhR5Gv0XegouyB47EpNJdQuzf3FGQyutSad?=
 =?us-ascii?Q?0hkTFEOXmuibnDVMsEXxm+cVyHd8DhsXBi5JQ9AHUEd/VWNF+eW6M6OWHNdw?=
 =?us-ascii?Q?Ej6eocPwH4pxyi2PYYV0Le59L9mjFn7hiCCUBSplOlN62J/7TMic11Vh5eeE?=
 =?us-ascii?Q?KZXkspMJauZ7zCP7zQQtgamWHpHUT3BEzOjm+s9+196RwSwGpzh7K4W2nhHI?=
 =?us-ascii?Q?5xWYGOx1JEnVb/jJSnp+WOzcgONF?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-990eb.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: c1413076-d859-43e5-195b-08df3a551731
X-MS-Exchange-CrossTenant-AuthSource: CY8PR19MB7009.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 09:22:05.8163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR19MB4063

From: Wei Li <liwei391@huawei.com>

In the rv module, there are three read handlers that pass
'strlen(buff) + 1' to simple_read_from_buffer(). The terminator byte is
not data, so the read returns one extra byte. Pass strlen(buff)
instead.

Signed-off-by: Wei Li <liwei391@huawei.com>
---
 kernel/trace/rv/rv.c          | 4 ++--
 kernel/trace/rv/rv_reactors.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/rv/rv.c b/kernel/trace/rv/rv.c
index 7846e4092b9c..835d53978961 100644
--- a/kernel/trace/rv/rv.c
+++ b/kernel/trace/rv/rv.c
@@ -483,7 +483,7 @@ static ssize_t monitor_desc_read_data(struct file *filp, char __user *user_buf,
 
 	snprintf(buff, sizeof(buff), "%s\n", mon->description);
 
-	return simple_read_from_buffer(user_buf, count, ppos, buff, strlen(buff) + 1);
+	return simple_read_from_buffer(user_buf, count, ppos, buff, strlen(buff));
 }
 
 static const struct file_operations interface_desc_fops = {
@@ -752,7 +752,7 @@ static ssize_t monitoring_on_read_data(struct file *filp, char __user *user_buf,
 
 	buff = rv_monitoring_on() ? "1\n" : "0\n";
 
-	return simple_read_from_buffer(user_buf, count, ppos, buff, strlen(buff) + 1);
+	return simple_read_from_buffer(user_buf, count, ppos, buff, strlen(buff));
 }
 
 static void turn_monitoring_off(void)
diff --git a/kernel/trace/rv/rv_reactors.c b/kernel/trace/rv/rv_reactors.c
index 06f21bcdd6cf..8a4f0740e3ab 100644
--- a/kernel/trace/rv/rv_reactors.c
+++ b/kernel/trace/rv/rv_reactors.c
@@ -353,7 +353,7 @@ static ssize_t reacting_on_read_data(struct file *filp,
 
 	buff = rv_reacting_on() ? "1\n" : "0\n";
 
-	return simple_read_from_buffer(user_buf, count, ppos, buff, strlen(buff)+1);
+	return simple_read_from_buffer(user_buf, count, ppos, buff, strlen(buff));
 }
 
 static void turn_reacting_off(void)
-- 
2.55.0

