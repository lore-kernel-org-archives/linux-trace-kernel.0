Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.40
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792490127;
	b=oPiU6ABEo8YFU7TldAarDuh5Hfl8b2HukiSED9YxMS+JJiPdIWvxFoR2GlU5XNqRJ9kv
	 r3IgrzyUb+gHrNn0YTsmOwh9ouH2C5XvUoIR6aTBDsMt5DFEB56Y0VBHq2vSB9GmERn+B
	 R/TKKEdHep+pGea8J8rNGQd2AJVYTFqIPcTLsEQqDbVZ6OYM/ljkdQOTHU6IjKEFq+JKe
	 5iKX9I0eQyOxQdmGiZasKR+3XC45hRvPdqHdR99F9jSbFETYwqwjGHYDqeErP04easiny
	 byTG3i3pjDFKoNJ0xXVkw6fAk45OJAKlP/7gb+s9IzVn8EhhGKEoNzolijOeALgLVkw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792490127;
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
	bh=iHVU8JewzwDBE8Y+BKpJAZ0jjj54XPqD4RfgJo75jm8=;
	b=5b31u2XwFRRAy5uoAYBs+jRgnwg7lnLVppHrAyK4xsq2FD4U9I+CAtzdtMp0eJRvzjGD
	 kkAFerR59tsFx0h5ePLaPgevgbUBaHE4YTRpbWNQK+aQzjFd2tP9R9hz3TyBF3kA64Csq
	 mTneh40Q7FBF5JoCV0SIHtNdvWr91SAq8zahXr7grvvq82uup+yCJFoxNj0ORa+Qc51aV
	 rySOplQEV0JMLykwfBjO9M0yO+PZvo1LdSH9m0wttAXHM2f72F0HmcCt6bRc1ncY+38J0
	 siQ0PPDCvCSRbMvy1gx9Bd+TuWqrgGSQeHzhSRSo7txMBgwKb6XgotRLBLSvKAuO31w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=jfehl4Qb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.40
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013040.outbound.protection.outlook.com [40.107.159.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F5C606A325;
	Tue, 20 Oct 2026 09:55:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0F5C606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=jfehl4Qb
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AKuW2VLQbV/g9jYiv7GXL4vPirOdEnkoq6FXQRvABSA23nkrCFQe62wJdi7vuzs1W2BDyh3ewkGuy2he1UFnthIttdPotjTQQai2foA/MBMtEksiQYbMmCYF863GlfVxuHCYr9597bKYhqLcRTNc11p+tOmZMxCM85qBs9CCNfsKvCVGjO8+GtlHJHBPY8O8C1j4IQEwp45kyMV+8FDliz7YSc95bhW9YOwf07nQz1WLqKZooVNn7TfbR2hoBQ8QiXre2WxT5oIMGjOGvnHscnH57q5u4wbuoTgP9ZDPninlURsgmvycuJbjBjNHYAnC41GsmnSO5r++DjiOoY+eIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iHVU8JewzwDBE8Y+BKpJAZ0jjj54XPqD4RfgJo75jm8=;
 b=FMUDK8YPlITAEK/nMbnwrdV0ut+4/6RIpGFQNsbfwhCwlWQD28TD1R8KCv9xudbyF8/T6iQDYWr9PhTkCv9DzM5X1Na5gZn9iqEecYo2GMiLJSCOf/L5Gax1bIQoLd3bc2FdmS6LUHT8QVOxr5Cy1GQ+L8o6Jem4x1hFUc++TvtdmMPPGQEBtxFgIz4vEJ3J/447RZN0SkhF8d+/uAHOnuX0nw/ihZkj8C1+yv0TDw6YwyZRSaNLMTJ+U3nCVfyD/e2LMrKLu2RJ/85Mdafpswqx/EzB5MHIUJiX+nykiTucsGwGih8ksORY6XviWoh8WPjQyWtvVTm7bEM2kn9SUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iHVU8JewzwDBE8Y+BKpJAZ0jjj54XPqD4RfgJo75jm8=;
 b=jfehl4QbQhxpythRg1xDKOCueQwV8slnOm3sPdGRslUw9ylCdrPa+YQEkFInnUDhWNfpP0DS6+KAK9XsMgBCVAr6904IcNeyQgsJsrAweCNFnyWvrQlW3YiGTQ0o3v+cuhAYsur+HsAZl6qkH7gT3FtDu8ujA3ZLU/DlHqy4SJkUvFJByr9aTTaOQUmBJ9ExoeD+ir2apYFlR0Rbkf+PDRTxDNdnS3CMKG+nfsislBfsbSlJDyRDcofdEb6XS1SoflILqWcqQlV36yzy3ABvm0i/SgcmwQmnT/9X4h4lGM+hr6bF1MK8Exr4D0sRqSdSVl4ktFHVcp7N7MIKoVRqhA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by AS4PR10MB5872.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:517::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 09:55:22 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%6]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 09:55:22 +0000
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
Subject: [PATCH v3 1/4] rv: guard rv.h against double inclusion
Date: Tue, 20 Oct 2026 11:55:09 +0200
Message-ID: <20261020095512.863754-2-tobias.schaffner@siemens.com>
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
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|AS4PR10MB5872:EE_
X-MS-Office365-Filtering-Correlation-Id: eee8ae3a-4b1d-4a4f-c28c-08df2e90417b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|10070799003|1800799024|23010399003|366016|10067099003|55112099003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	6yFjbNyNSg2hH2qOfJtZoCGzOsEQbk4w2/cLoK5m53s91UaLornBmT0Hqqc7KnLDIylsL7yRV6Y/H5zGaZSFs/GBgOVimPv8VrYbTNMQgbgNo/qIUVrOU1JxBlhO6raa3ObJRNLoMPlq5Ano2WHvw9/mef8OdLKsE57o+KVR4qQ50UktyfEBXnDp0L7lid1Po4RbfFGz7h3ddSDHxqZ+hxNxRo3UfWbdFKM7NML9ZyHFOtLfGS/wRFabDqWSkG8TmzDkdKCT55ubO+wqyhqomp63g/yjNC/XgAXAB5YScJ1D3OUblwa8Eoa7PcK7+mvriBBptjUoSNnLjDtFC6/o/n68WXz2Zt0l+gcF43Hj2W08YUW6LzQyUdgDPmQSKc35OnaMo7HyfEqQp9v0q5D6vwF7o3EoCnR/79G2Rf8eKQwb5R01wrvFtIp75wOyjUzFlcOFKlM45bYRBl9B1md5RgemOkSTZvWcsaglVXcBqL4cYSHFZ4nQQlQhosUZ75dHx2JPOgPdviHkx1XrCCzHiDNeI1tfzZ7jlfXrbMb51qQpbMGI8SQa6DHsy+0xYHzlTLPOUPyO8DLeNYiMqyHSr+QKE9VD8LCesNh6QE7xKACeNODrc15ID20X2sMdOzzrkkKY39c99SsRk9mKCTO/J5dLyhcKWoX8Es3wqxACb44=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(1800799024)(23010399003)(366016)(10067099003)(55112099003)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RA1BMK69PO+i3wksYOXyshc4jy+i9FVTsttoZ+S3fuYP50PqfsIGH7iBvugN?=
 =?us-ascii?Q?mP06AFcp5JGmPOdgIlJ5MwKcjNlaR31LWWEHwGIzoTThDALm9V5ruzjc+96m?=
 =?us-ascii?Q?wgWiu3z0kuiTxgGJebhyqiUoYYqAtI+SsEWqF1wJ1fyAs6IyvF0GPxGjcsLV?=
 =?us-ascii?Q?Ra+dZYToOeEWN1AjY1H29byQ/DER2QE4UmV4OICVQwgvPNMCdChXVihC2f45?=
 =?us-ascii?Q?ARoelZ0FJIqnb5nx6YDaHP3/viELgZgrJHKSuncbSn6ejzpw0xLOXtk5ItiF?=
 =?us-ascii?Q?2ThQLoYj+GxFO4TA/8FOkvq7WSbxxoSd4KxjWuxrGhXXVliOLu0YD2i7sajh?=
 =?us-ascii?Q?sntA9B3ZqFY45qzNZacVTtsdmKdxZITg7p9n0dA9W/xM8Tp5S9MqlRzKm4cb?=
 =?us-ascii?Q?aZMJK1aXdCNeEQcvxfI2qyhMeER6h5egSVIfHvKMWReSaYcZKOe2g2sUCG2Y?=
 =?us-ascii?Q?5u1vKMYUaXZa1AK2HMSAxLmqwthebudQuWSWWFLxfTZxgYEjmmGle+ZlNFmL?=
 =?us-ascii?Q?+r8t984bafcnTAD2IvlagTY+R4n/p07oSPs/ZbF+f5FH3+LtZeqU7DjXYRpE?=
 =?us-ascii?Q?hNsLbQBsb7VI/QOWTVPXM4L/cUgcUkQMHdSyCvG7ObUHjrE1PWrKtQF3MLb+?=
 =?us-ascii?Q?cxvZmUM1zXF8K/m7h8s9tSfWxL2xjVOlJzAQzzK5k3PLWj2B6XKniKWE4v/U?=
 =?us-ascii?Q?+DnFGIVY0OMaXSgIrN73nwKxZoOvRPlEOs4xpDfrHFm+rUPrd3orXnWa4F3/?=
 =?us-ascii?Q?1WbVyxCb9cXLXRDi7ziROaiPyErhZbKRCmrjMYOSUsLmGVbRn6OsV7593vFB?=
 =?us-ascii?Q?gKJI4jOLBeV2/pmfljEkYUOUz9nqOKowoD/B+HCBDHdjbji4yOZKPZNh9kCE?=
 =?us-ascii?Q?a5RwK1d14Edqae+QEXYSRGYOsjU4ui7ZuE3hzfk/qpRTL4WTJ40R9ENZQNDo?=
 =?us-ascii?Q?bGVLgVrZz/nOKf/zTlAV3p/gfTetiWfNAIjyszrrA/jOm6E6JK5l541rnNtZ?=
 =?us-ascii?Q?dDZ6bk0iNbuMpMMz754rA7faTuXm3mH999+Tvqoh2uMHeuJoHwrF7g3dyae5?=
 =?us-ascii?Q?jPJvCjzAfRa3Lw7KIPLG3VKqUGRie5Urx78vsi6EKDxZUvomA3Ks+Bddcsml?=
 =?us-ascii?Q?vmJkTVUUUi+v1uVd68q8UNAGknFtOmwln8hXGnZrV/4GpCwsMoFB6R9BpZlg?=
 =?us-ascii?Q?87r4IUikwM5gz2ZkjHeh66J260edXwLSmu72dhgOV/qE6kftRahPKdVPqjpM?=
 =?us-ascii?Q?VmxUc/VvPXQZQslnk+DtLE20pJ+FOto3bMeZNff7iglg73kgrtjyTEMLioxn?=
 =?us-ascii?Q?J5Cgk4cNrGdshgC5DZ5yYlXf/AfE37YVkAJB2SaMi7JkHn3f6GGTA20bjKma?=
 =?us-ascii?Q?VQUBW+YILxU5UlP9rW9kHAnZMUla2SWjZzST1jAoJSGZ02yvOa7In1R6jpRb?=
 =?us-ascii?Q?JSR2vZYXofy9YgFaRssm2ThpE7dqC+j+4ADhJaEXrXUijH3WBBZMNobEaxuw?=
 =?us-ascii?Q?PRhnAaCp3Hv/17/sEwtNo5c7C7A1JupBw2H+JQXuh44NGlnyZDBOb1jF1Oo0?=
 =?us-ascii?Q?BN3kbZjdEuv5ILkNsH1c/rpiaogIF4mLIa9kqIDD7imQPy45fHwDiZ35kbuv?=
 =?us-ascii?Q?9ixWXyrlWU/HmwPi+J49Ot+SELyYws1Hzu2YggZQz0dSRbUMcdoLvfEsXFxz?=
 =?us-ascii?Q?crL9IHoKOH1IgVifJWZWtDOT1uaAd5mI7JbhHSLlopPCwyPgTzsCQJ06HfGF?=
 =?us-ascii?Q?SV59zXo+Lo7qLHyZ81jwESlA8oBziXW9e2EdrPUYNtGTz+OfgF7H4BqAPkEL?=
X-MS-Exchange-AntiSpam-MessageData-1: 3MRvp7qG4XW/lqV8IBWWhKlC0wWbtPYFlKA=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eee8ae3a-4b1d-4a4f-c28c-08df2e90417b
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 09:55:22.1406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dpYJ7vZDmZvgg3GcfPU09LsF9gA5PgbCNOukvelxMsU9IRhFL0Vfk4Hqvj+lvcSPysOmsmiTH0SMopxsbzWqmQrxcjILlpfNbN6CJSeg/yw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5872

rv.h has no include guard. Only three C files include it directly and
none of them twice, but anything that includes it from a header hits
this.

Add the guard, so rv.h can be included from a header as well.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 kernel/trace/rv/rv.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/trace/rv/rv.h b/kernel/trace/rv/rv.h
index 2c0f51ff9d5c..62779e6b74bd 100644
--- a/kernel/trace/rv/rv.h
+++ b/kernel/trace/rv/rv.h
@@ -1,4 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _KERNEL_TRACE_RV_H
+#define _KERNEL_TRACE_RV_H
+
 #include <linux/mutex.h>
 
 struct rv_interface {
@@ -45,3 +48,5 @@ static inline int init_rv_reactors(struct dentry *root_dir)
 	return 0;
 }
 #endif
+
+#endif /* _KERNEL_TRACE_RV_H */
-- 
2.53.0

