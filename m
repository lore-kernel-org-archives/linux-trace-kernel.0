Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11023088.outbound.protection.outlook.com [40.107.201.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD69D18F2C3;
	Fri,  7 Mar 2025 03:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741318797; cv=fail; b=tRHSaQsM1FSLIPtZaAeOV2wgryleYA7K1QZ+/WYvh+k4AqUKsrsGS6U8n9mf9vLlxNQ9Vq2XSOLg9RAxV3YbXONmQDffrxdPFS12BPOFUkwpoxC6O/tBqKExQVbk9nbmpnX8fg+Zy9120/Q71lya433mkPdyKgAVMxNE20E8YWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741318797; c=relaxed/simple;
	bh=r3Z3vo9e0426lxeloX7rKPC5IavvcWNe8zqRSB4vmZI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=GG2cHUj6minIUpm/iGLqhUfehmm+qUDlW9oSbCK+8XnZ77dSetcxSnhluOO66/GT4EA3igfLJgqJI6DoWJaRusZE4MW6Hz35l48KhuYwMryq7oRwwsCU/LyzUbs+us0zFSTkD4ZC84DlnBNHndI1QdegqGKuXUl9P/PKVKuWvMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=nhlMw4MJ; arc=fail smtp.client-ip=40.107.201.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="nhlMw4MJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o+AIctm6/QnYi21msM0wVE2TWbBylDnMjF87amSFxQ8174M2ksUdQFxdwAagF1WboIQmgY65smuuKve86F2JscWdv+9fFYIxZNxPb5w2KtmhJYWxfcv318O9k01ibx9lhS1BJ9nXBy0egWYvZqXWvOtkmJEa4EjIAJNk1emFZSqC7CxrxeBaLTz0LAZklOAen2TDLcwreqe3t2ZWEyiVaCD89m7BC+3idenFY7p7UlzgwvN85Exh/IWc/klHr3tsbwyL1HW4S3j365x6cIjNBEdzu5gAapGlUsyo0nejK8QkvEosI/+3PJZdPI7uM4HhSndOnsQP2bGmbs8U6zjmkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rz0y3svfa9sJTODg1g29V6slagaAVgQQ/zc7RNYeiUw=;
 b=lscDPwuT1o37ia36NoX+ClOXArDELaoWj58bF27AuIDK8bTDeroXfEFa6PcpX0zdsLeJ3YvIg0R2bcLdOQQVC45emfEME2bO2uVrFdJV4ZqwlOW7WCZo8w2TUyD9mZdZkkGmQQt/aqYriPIsymGZ70/PRKQZ71Q6TIXIymBZhDEACJyGzvslAiPSCaX9JaTKFhaDMpIvw2Cb+bY8GljRaxzhGAqiHylIlg3Zz0KV4f7e/u1jSps7/5fzFLFU9EkTctO3wAsvW1Yhmu5oc6CPpUc4RNEiThCt8iHk2rdwjOWVVwP9/2iknA0XsHIpnuUtb+0yj3b3JmctYwafk7ZzIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rz0y3svfa9sJTODg1g29V6slagaAVgQQ/zc7RNYeiUw=;
 b=nhlMw4MJUQblPj7DI/loSCqvo8OY+bY5a+UgXn1D6D9x+w6mRkkNmWY45uzcEbdbu1pegLJ3/uNuX7HHKa3XReAjw961I9Hv+TJtMSImHk/0dKgyH5ZWgVrhVavy3SEmBjlyjqOpM84VzZzBkaHa77w8ei773igjt/2CfLyWPXM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH0PR01MB7975.prod.exchangelabs.com (2603:10b6:510:26d::15) by
 DS1PR01MB8917.prod.exchangelabs.com (2603:10b6:8:21c::14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.18; Fri, 7 Mar 2025 03:39:50 +0000
Received: from PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::6926:a627:118e:8050]) by PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::6926:a627:118e:8050%4]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 03:39:50 +0000
From: Huang Shijie <shijie@os.amperecomputing.com>
To: rostedt@goodmis.org
Cc: patches@amperecomputing.com,
	cl@linux.com,
	yang@os.amperecomputing.com,
	mathieu.desnoyers@efficios.com,
	peterz@infradead.org,
	jpoimboe@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Huang Shijie <shijie@os.amperecomputing.com>
Subject: [PATCH v2] tracepoint: Print the function symbol when tracepoint_debug is set
Date: Fri,  7 Mar 2025 11:38:58 +0800
Message-Id: <20250307033858.4134-1-shijie@os.amperecomputing.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::12) To PH0PR01MB7975.prod.exchangelabs.com
 (2603:10b6:510:26d::15)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB7975:EE_|DS1PR01MB8917:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d42cca3-aa48-49cf-a20f-08dd5d29b687
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FyJnNxWWEQujvhcO9ANx5c5evGAbvToH4vZ9WMMibBz7UEaXR9QAa8puHcNO?=
 =?us-ascii?Q?1+T78PuqKtQyUbfhP9ii9AlGGhZImygXMxGbTZJVTM0oe7P5q3qsCjd2/a87?=
 =?us-ascii?Q?p+LTaPHAIWiQzSTpP3PMeMkYHFww0p2q/55BGTSaynPZ/GEf0n6f028cicrR?=
 =?us-ascii?Q?LNiN5d893aFHUT2280NEYQNCtU3i/O13wW94WEYXb1S8xROCTtu/eE+Jwhs+?=
 =?us-ascii?Q?JYsPhbWpRnPo5dO/OotLB2cWsceh3ZVJbITDctXOV2zshmDTWYyUOtDAqk4Z?=
 =?us-ascii?Q?WVD40jamx5q4fzj+Rif1/Gcwdt/++nP7DO8LWNQP1xY7fQre1rUFeZ8NM+13?=
 =?us-ascii?Q?3EMalBC1TW1r+YXNJns9xroMuToDj3xvvQCv9cXSDT8WfHjp2KYstaSLzhPb?=
 =?us-ascii?Q?aUUMVJlSrznTLNMcXmxrJQ6l0QrMDZ8ISz2xnzKLs0RlxAPtvR3o4TzWS6bg?=
 =?us-ascii?Q?q59dQy2o7GDeVFBYultxGKr8oJY+m+tIuaLqRTofm8vjkXhgVWhtpdBH5kHi?=
 =?us-ascii?Q?F7vTTYlnM42Sst6btpEbhTtkjNHSIIyTugajtkd/3OFId+sZcTluHv4arTal?=
 =?us-ascii?Q?GcIh12Z8TRbOAOeFfwo6yjCcOimxQ+5uzVHxbWBkeuOtB/wStAeAH+KLRufm?=
 =?us-ascii?Q?SM23BZBeasj868wfKD0G50kBOzmKbCEoU/7NAvQGt3A8YL+vNQwf+1ohXd5g?=
 =?us-ascii?Q?Y8SJ8YmJ9yp4ikVkj5cbI+j3w1p0EZklX6XE9mYTywLauGZmwcZ5Nh1ULcWK?=
 =?us-ascii?Q?UwUghbYHwlNqk7awN5Wwrn/M5b2D8h00rbWRCo7IGZ//04TMi0CNEJmaaAE4?=
 =?us-ascii?Q?hCsTs3/Jk1+mE4yEpo89+HMIhKH821UM030hrC6lFGXFm1b/h6YMXwBb+Gcv?=
 =?us-ascii?Q?OiuNQssuuCvDg1MzNJphur3sQYi5Na0kT1iEToZJeO/uIlM8+gR3spBz9BVh?=
 =?us-ascii?Q?pEKoDfZedx27TAUStsKgGe8rlr0ARoc4WndFcfF++Zhv2c/gDWuU8xNIzFy0?=
 =?us-ascii?Q?qYL15edL+ImuV8ZUpXP2mwAMv8oTTjFmysiI7ZpB/jI7Z+p7jK3YOdSWtuMm?=
 =?us-ascii?Q?gA1xvR3K5HDYr/uKFOI1zjSGV3jq8VI503lhKG7mkAAeCUeRFKoCXGpPnCE2?=
 =?us-ascii?Q?h4R+neL9tniRq2OPEXafGibME+kXYpukH09zrm7erAttHbR9PCu3PeLwke5o?=
 =?us-ascii?Q?u4GKCt4tzxHY43UHd7IOR8/YRttsswkhwQ6neF0XiBp0t2siuaHcOp6X2Z8t?=
 =?us-ascii?Q?zVQCsoNOZsXTe7LHB3wN9OY7U99dxX/hP7cgzAl1eLMTkkSTw6kSpTQt5ug9?=
 =?us-ascii?Q?RIkisYI3Bj0thtmLEv++8AI6G4ShoWtQBI320UOX5kkyFTiF4LdBZv+eVRzF?=
 =?us-ascii?Q?dLe84P/4PQ0gULkyAPxKkgJWwZIL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB7975.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZNJ6ziVxmiJ2W6ss9MB4LEOOUTJ5hIDGXfadN2Z3QBWn5V1nAOgIVWM6D7PA?=
 =?us-ascii?Q?U6EedJv7zW5uJ8ynixe28c0P4+Vz5cWslVnR089SRTTeZsl1BhkG4+Fdw1TZ?=
 =?us-ascii?Q?IMG3kh73QzET5uBPdSBbPZF3TBE6VQAo/ud6xozPlmBa2p95AC1ulHz2KEDg?=
 =?us-ascii?Q?7JHcS0WJJlDirGnkJqYNZ1ic7moimdEz8r0B0II48255H68I2DmKSJ6zbx4e?=
 =?us-ascii?Q?dLZNAZQetXcvxC11VxjwRHx9bKMzRee+bnnUENp0Oa+TMBx8g/hr/gRubFBr?=
 =?us-ascii?Q?wBdmPvU+nwfbUsZ6WuoBWJ/ct6pYOfsrH5JfuVxy5tPGCOSaLleOzicLuc+7?=
 =?us-ascii?Q?Q0vsPTe421OpbHVF3f0rvTx6sici5Oka1SMhH1vTMoNPuZCzKkVKyBXRSEhi?=
 =?us-ascii?Q?oFd/PPD1x3P0YTPdHy0sErY/5f3IUtYWlMFvsZHb35B5nkzcxbl3MKzYXS3R?=
 =?us-ascii?Q?kmeSQ6DIYKsmHpJfC4bIIiO+QluhsqZxIMKuDemBYHoHNqYPA4k2mH9rehdy?=
 =?us-ascii?Q?rVH67mXt/esvUXBLDObxcn0Bj2HVEopA9OEjjti+lCX043w+7c0cJcAc3QlS?=
 =?us-ascii?Q?DRotkunfqzSy3xtqUum94sRBHpFlNB8tIs2YFCc1pSueywYpn7w5UqP99tEV?=
 =?us-ascii?Q?mo90CEnNySfibMMuAJF8sJuL/eywsOTNCt6iTh9EWrCUwbiFKIMvKhyuFT5B?=
 =?us-ascii?Q?NkY3WHS0KOXbm32+C/9QbOQch3Zc/TNG1XR4oeHeq82vz3m8sAqJMl9MHWlP?=
 =?us-ascii?Q?vr1v4pasJbf/1CEo2b9/DM7n1RQLEgQCpB6YK5oxtORU38mFslx5XRisJhso?=
 =?us-ascii?Q?lo/1notaAwj0uC9oLEXE8+ndIocEJ7cDNl0bhPR06+PkucojHBVi7NyG5rZ/?=
 =?us-ascii?Q?mfaIZF/cN+vrs1g/P1TF1Gu8WRTA1hKULy4aSxzhr5zd/O+5zw73ZdNxZa0B?=
 =?us-ascii?Q?Bjkz+C2hFOf7Ra6Jf/2Rk1h7kiEw8Y2DEtx9ATYfuJZAhH3f+gAc7exOgazO?=
 =?us-ascii?Q?9NZKMKIzDDaA34gPQclNjPcN5/vXjD34O5y7fu1NB1g/QxtFqurGq/pRYrBN?=
 =?us-ascii?Q?OO6xlm1IvSqpcTF/OpTJ9pQNBnfWI9vKMPjZ494ZOpCult4YgfIpNLFAeWwL?=
 =?us-ascii?Q?f8N4hW5L1nGF2cyeJoKwMuNys+oZEQ0XIgr1SZM1A3ZAvFt8PCPwzAWx+AKs?=
 =?us-ascii?Q?SRK88eLmPBidmD3cHtod/ccDSNEVys1PZi8C4WCc13OEfJp9vJqiYCiqxfnW?=
 =?us-ascii?Q?hiQCit7cJoZMm/9uyyqbVgOakwYJ7cwY0ouNBAcqophfIt+P8VA6vIhFM5wp?=
 =?us-ascii?Q?Yxwh+7EGJqIOCgvqV2OXjzgcNb+JNpO02a4iAaglkuyLdxis3CDrI3UefmiF?=
 =?us-ascii?Q?tPxizHd+OWC2eD4bAlc++WWEmKtxgolFLzorzY2jddAK1y5qjW1tDLggolof?=
 =?us-ascii?Q?/OtY3Ws4x691oh/96bOUOmgOlJ0NOQt0TM8AB7qBUnItXvyKSTwfxsbNHIa+?=
 =?us-ascii?Q?NdyIthDBghgvciQUKZZFsWRwsn/Veg6ogF2VWTYItcLvCCuStGrwimFgeC0w?=
 =?us-ascii?Q?MOnfpD7Z/A7bUzNZQUZlYcCPZqFKgQIISCsjfHjmb/kZ5d5FCR/1vuajC6gA?=
 =?us-ascii?Q?s2U2x45TXwj2l9/e1xx1YSo=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d42cca3-aa48-49cf-a20f-08dd5d29b687
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB7975.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 03:39:49.9310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ucLY8qAvPkQlxnIYSdsFLVs9/Mhg4K+paFnrZ4qo5SRi14Y/qOOIm5Y9FQQ6Orz9cTfozbUOyvjrwaSLPUfkkksMz4KUaa8mRQOF99AkxHKXcG/f4ggyWHr+H/pX6uOT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR01MB8917

When tracepoint_debug is set, we may get the output in kernel log:
     [  380.013843] Probe 0 : 00000000f0d68cda

It is not readable, so change to print the function symbol.
After this patch, the output may becomes:
     [   55.225555] Probe 0 : perf_trace_sched_wakeup_template+0x0/0x20

Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
---
v1--> v2:
     Change from "%ps" to "%pSb".

     v1(resend): https://lkml.org/lkml/2025/3/5/109

---
 kernel/tracepoint.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
index abfd0ac1177f..3d958367f5fb 100644
--- a/kernel/tracepoint.c
+++ b/kernel/tracepoint.c
@@ -127,7 +127,7 @@ static void debug_print_probes(struct tracepoint_func *funcs)
 		return;
 
 	for (i = 0; funcs[i].func; i++)
-		printk(KERN_DEBUG "Probe %d : %p\n", i, funcs[i].func);
+		printk(KERN_DEBUG "Probe %d : %pSb\n", i, funcs[i].func);
 }
 
 static struct tracepoint_func *
-- 
2.40.1

