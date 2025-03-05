Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2118.outbound.protection.outlook.com [40.107.95.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888F8146A6F;
	Wed,  5 Mar 2025 01:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741139768; cv=fail; b=a/xA9dj+/7jfK7/ZSUuggHyzQLSWMOE6cnNwAAfhJWDpSDyh/faYvJInIQCJQcUzWsp8O4Q/17NSSpd/gqG1b8wxSapc5dfbgrF5FSEzORaGNQyrXcJ9mWVBJj2+m7wCkr6i8RxlV+CrUX+b/+Gc1c5eGWta6f4IA2Xkex276nI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741139768; c=relaxed/simple;
	bh=CvgprK6Azr97e+/ug+CS97a1FuTe/kwYwSfFn8/kqbI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=LTL6au4FHeLxsaIgZuuSghtuUDxWZr3oyMbRDoisbXpGUGAgq2O1yP88LoNBGCBKHKiB1Hxhk2m9lLSaqsGsW/WaHIHSiouUH9WAsDqcbti78MHlMHsfx8JBBcoqy097D0eoo3NthCnf1M0aglzvbWaO4WGDPz2JHaATBYmsukI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=dulM4BfM; arc=fail smtp.client-ip=40.107.95.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="dulM4BfM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K2PRtAbwzGCtnBBnG7VwtcE9+S2UOMZ1o1B8WBhz2I5Kuq7ONhJwQWJBk9+WO3RMW4+QdBXij4LlSbX8LVwIoKni3ywkui3mUX3DBTDpGtGbfjxMAUWW30LXECdGOi5p4ssr7FblmqnuMxUBh8QrqV0Q4QZ+ZguVtDVj4Rc0SUaX2GI/rJdyQVsSanvRdZHP1Bo6ND+p1YXgFoh8zFcsWHdSaNuTe+bchykkuEDHixqBIEAJX2eZC/cae286as9M9yHfRec9W8m5V40xpSVo+15j/1WUQFZ0MTMMaGT7BDDn+SJgVDBS7wiWacwBLZM0nqHg6bd0sg+0Fb69FRFwHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yCeFzyriY26j96qACozwoZVBtZVGdvcE2m48fXxpZME=;
 b=i4Yu1iOvVN4bWxWdbp8ac1XiOQNoHNC8S9CiO93bjzP6MKhM94JahpPDUKbc92XXiM6UMTGSunkeV8Bq/bSJ6RAeyZcY4GKjA9QL1hWQ5bNCLHLI//hlPLvMNC4EKpaQxTr7EBdBB+yYmOBuAJbdgcMrJx7vvqTsxI4Xcfoez8LHsbSVLTpCWbEherRhsQVU8HBYdiRpClyJw/XmUD+b80XGBnYRFo+1cLa5N349K0TyZLccbvHsedUsO32j8hJj2JkDmlzmiH/hUJzlf2cw/02J4Z8UCKrco3ndjPAmVIOHK+7EvNjfEQ5ZP0y7ovvDmLvxGX9qPCG4qAHOUedkWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yCeFzyriY26j96qACozwoZVBtZVGdvcE2m48fXxpZME=;
 b=dulM4BfMkgSEUEORqvhABRF2wk5CVQKoBZHZhfWrJp0grCXdPiDsGovWGRVYUtCd5T5QlzAq6Z9jr0waWPUJ34zm80gB1kzXenvvqXt6OZghneWdutbt9U4fQclJtulbvT668J9LUgyjg2u+1p57mtpdcaIVFMzOuODVGbSsj68=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7969.prod.exchangelabs.com (2603:10b6:806:34a::19) by
 DS1PR01MB8717.prod.exchangelabs.com (2603:10b6:8:214::12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.16; Wed, 5 Mar 2025 01:56:00 +0000
Received: from SN7PR01MB7969.prod.exchangelabs.com
 ([fe80::5ca3:a44a:c242:d9eb]) by SN7PR01MB7969.prod.exchangelabs.com
 ([fe80::5ca3:a44a:c242:d9eb%3]) with mapi id 15.20.8489.025; Wed, 5 Mar 2025
 01:56:00 +0000
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
Subject: [PATCH resend ] tracepoint: Print the function symbol when tracepoint_debug is set
Date: Wed,  5 Mar 2025 09:55:05 +0800
Message-Id: <20250305015505.14493-1-shijie@os.amperecomputing.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0168.apcprd04.prod.outlook.com (2603:1096:4::30)
 To SN7PR01MB7969.prod.exchangelabs.com (2603:10b6:806:34a::19)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR01MB7969:EE_|DS1PR01MB8717:EE_
X-MS-Office365-Filtering-Correlation-Id: 9937dd4a-413a-4fb2-8f7f-08dd5b88e085
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?z0h5Skksy2UGh3fllDUafkJ5RvHDQVVA3gYkh3g3JLpEfNlAiYO6TzNXBiOP?=
 =?us-ascii?Q?DFrluucq8/R3f1ZOg/zdMTPoHlC9Ht9lmUMF1hk4itY9kvYkmADqOsiNWQuw?=
 =?us-ascii?Q?J/eNodlgl5QUXv7pDDDEggGz8jfuUe9zPMsRsNPI1SNiV2+dCeOaHDWN+Z+J?=
 =?us-ascii?Q?kbw9bmVD4aISRE7SYq4ETgvXuzUkOGM7Bs8wHtWvqTSohoyfV7vCTsuXUxFA?=
 =?us-ascii?Q?H8JwQvw6GIsjIZWFcBtAz0itRWp+O8PjWKun1hx0rilOFt1pLMf6xq2+KjQr?=
 =?us-ascii?Q?QaU2q4Bjeeay7gGiLVuhkSiHUobpHCRFUmmODqzpVxtHV8Q6uNoAQiF0KL6Q?=
 =?us-ascii?Q?RMuNFXX7s9tSLCuDpB6h4G+ojYT0D4AyZovu1jtUf85NYkvA1r8JJH4UFdro?=
 =?us-ascii?Q?C1BEFUPSij9MM07f1VRScJUHGs9LHTZP2NDyc1yw8FHfMkgkQi1A0szhtRHN?=
 =?us-ascii?Q?8gcAkhZ1/ueh3+MLzH6qYg/FLIHFGdtPVQKMUoA+ooXWxVmRVCMbY/vG1qsc?=
 =?us-ascii?Q?zs5fkUFO8V5v5y5gxlriaAyRqD0NAWY9b0t6verDCSceSylhE6sDey8qdbOw?=
 =?us-ascii?Q?DgDBEDnhfI1KCpjqKS64a9f1i6CRc3XuoL6mX4m1Pu4nnCdIzDel82Nelpw5?=
 =?us-ascii?Q?y8zvHlkBGzdR5I6uuT1VBygp8L+Lp1Tvx4vxa7GatqtLv8Y1QuyT/LWcRmFP?=
 =?us-ascii?Q?VNdlBM9Kuy4TbKFomUrtmNHR7HrK0oFH/VkyWxad27S2hkdjVtL8/wM8W5JO?=
 =?us-ascii?Q?TLTsX5iltlICJgT4pRBcKr7Dq72CTEhcyk8qoH7n3AsHZwC5xBnUJPPMqfzU?=
 =?us-ascii?Q?ygBS89QeEr+nnkU8wbZEFw8rctk5bGO9BCzSq4fT2GOD71tyUSS1/utK4Moh?=
 =?us-ascii?Q?AfMnM+WdlmdsSnQYwC0r6Nu2Vf6283I+rCfgF0ogidxW+b6W7qwDdCUh++kp?=
 =?us-ascii?Q?PsjZV+PgcLZTbLAvVw5MwawzAUZuIIWnFR3kxalu0ZV8ORs5CD8BoMDjYIFc?=
 =?us-ascii?Q?xX/AHshiG7I/WlESQTzdO8PLePmaqqrdn92raCWatmgls1BJwMy08Xe2AhNx?=
 =?us-ascii?Q?NvuXMnHfXoN0JVeEU9BZPMQwX/wt2Er8atSEcCALDqKCXv9vThl/LabkEp87?=
 =?us-ascii?Q?KzmAtO9njzYDfgqzq0wGb4rO9XNkojET/eeVWmGEXwWo+VkycA5ilQAZpuSa?=
 =?us-ascii?Q?bBDdSMsyoZ2Jb05ph7EAiIeWhQ22vDFl5G6IwX4yZwM/MaDkMi5NX8F1hCG+?=
 =?us-ascii?Q?M8WYzb3pHgbL1mMdLApX5HW547xxT5TjaQr2S3sEN/XJnaGsMsyE4TQUmzTE?=
 =?us-ascii?Q?Q+ZSjihNKG8jPAqglUUO/b4krYLOmVyGlsb0SMKuAYmb70LEgGDgdFnNNpuy?=
 =?us-ascii?Q?ruetYtrIOEduVKiPaaa4CMSY3rlb/h9y6yfFsjKGJeSlbg2Yq8UjuODew9pW?=
 =?us-ascii?Q?59zyNblLi9BFmiLNf8ldHPRVMFI3X6EZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7969.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4AxXkz/EvisC1sLhA66/cdQok3zsYMIfxKaaE3j0yoMypg3nBZCkr2fV6UD7?=
 =?us-ascii?Q?iBFojvLJsvDeBYDm5/vgREzShAA2+x8ZCx2jvZQrDRwVz6leZ/fkS05j10Bm?=
 =?us-ascii?Q?9PgM3SGs5nWylJ0BhuTQl3VjppwyFhDS6msosL3P+eD4X/99JTRfgF2ScDNj?=
 =?us-ascii?Q?c5F1XB3zF1IxHHCLNSP+f9HIf1+pX63cBXM7REiiQ0yM8Gv9+LgHaZsnht6q?=
 =?us-ascii?Q?SqCFntqhUHI1UyTkfX3Dg/fmKn5JIQYaGtOOX9DExY4/2JqfbLEF+sEY4CIp?=
 =?us-ascii?Q?2a/1PQtnDYpcjhI7uTgfceleCjahC9oaPoCbRqSdCbZ7JX+EkoBET6Ny+swx?=
 =?us-ascii?Q?RWs+LS1zU+5riqvDJjzjr3r5wt6aracchLHGiYkXfVfNIpLVsjiM/ua7J8S5?=
 =?us-ascii?Q?ZwqECCxPUcdsrKRr0P+6sP85lkf/ViTRlvPVgt3MZLV5w3+gPz4Y5YCAfyMY?=
 =?us-ascii?Q?KwRtiyNFTmuDp44dB4SbXTMroQOjpLTS4LGhZ/iWDJ7S8yIn544b9TUTShfa?=
 =?us-ascii?Q?XjxkopyWUb5CAJSu3EOjZv9sQP9KAdYGU8qSRoHELdr3kUE3n494xadv0uwE?=
 =?us-ascii?Q?j8dF+RuD7dQKaFGRTv9fHs1lI8ur5KSUn8eYuRE4AWbTtPQZrf/9nVEySMgm?=
 =?us-ascii?Q?IXan6NwCOHpsIdoW0nG3X1+FQVfzge7Ec/TxEs4dj1uYe9Y85zN/d6EfBRXH?=
 =?us-ascii?Q?SPSXv4a19sycFiG2EsVE7QSTHgmnnPNXGSMlNbCgizQpe5BrYRk7EcGyJk5Y?=
 =?us-ascii?Q?70KUQk83vnARMkPpn540WTGzdspRN9n0n+/8IF01ThYX22zURX7TuYqQL0aN?=
 =?us-ascii?Q?TP44YPOuvlcTwYMEP63TPZW8OrD1h/Pb2uxiNyjrlBUI5Vqw/jURRfDkU1mN?=
 =?us-ascii?Q?/Owzb3BnO8KofRiVBgsfwYgVX/k3eaJ5kdohVfnubCN4jsIW4JnvI+h8Yakb?=
 =?us-ascii?Q?7uLQiryJXxep0C0rwN+GxUYJqUTD/NqEsCkPp33itTz3MAOhHjKTUo2Yvilw?=
 =?us-ascii?Q?f3jTbMeW69Sq35gWeV54hUsOnhhC9lCIcOdH9aWIxmpa5mGCvfre+nbvR6X6?=
 =?us-ascii?Q?umEtGvSygkTtyEDprBUNBk4Ix2lFto5r/qxdmGAD8jkWDGMtp8m2b78vlcbg?=
 =?us-ascii?Q?1HiHZ5g87jvp8ZC+iE9p7+/vuF+mxW7GePnSdEHjZdmh5XM2Q1N1sboBqKRw?=
 =?us-ascii?Q?7triAGo5hm+tOam42zTCUQ2D1x9kpji5IFAN2SOw9N66jMThyPrnqkmCLIzS?=
 =?us-ascii?Q?7HzGmMhtmBXLZ+1cpR3uKMvE7FOyLJiAaaEkKAqHJHhIK1+jAG9/HffvuYI1?=
 =?us-ascii?Q?Xw9HtxG50Uz580o+SfzAavOPOEPW8q8r43HuE0bLN/YICD3RwuWmo7xndJzZ?=
 =?us-ascii?Q?tQYtxsQ4Xmh8VBO3561kswRKsjMDNBN089GQav8MJcT0vc8l0SL/DVQhzXZE?=
 =?us-ascii?Q?S5k8G4WYGqJM3oYhvC/Q1Ilw5t+JIE/5XHbmeZgNbgJ49ONUx/lNi3mE85aY?=
 =?us-ascii?Q?ddWlTGHbCMTBq3VkelLvA7Bob4xQsvhkknASM3OP6cmFyz29KsyRTd+95ki2?=
 =?us-ascii?Q?V99X2OfH/JHXo9wsKpL+CaMSe8AoWLyAPsLUo6+M/xjGDccubw3NmrHvrQcm?=
 =?us-ascii?Q?L1Rv3Emnr9m99fNFHFhCZ5Q=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9937dd4a-413a-4fb2-8f7f-08dd5b88e085
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7969.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 01:56:00.2970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5hrw9cZn3sk4RlVUCyqDGRIwjKeDajqrhHemQZoVXGn2cQhXFM180RdfHLnoekU+9OJklWf+RkyQxgUjBl2SK0R/TuvT6LcXi17Q3S2px3z/CAcN5fMx43w6dfsrwJ56
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR01MB8717

When tracepoint_debug is set, we may get the output in kernel log:
     [  380.013843] Probe 0 : 00000000f0d68cda

It is not readable, so change to print the function symbol.
After this patch, the output may becomes:
     [   54.930567] Probe 0 : perf_trace_sched_wakeup_template

Reviewed-by: Christoph Lameter <cl@linux.com>
Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
---
 kernel/tracepoint.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
index 1848ce7e2976..82bef4b9400a 100644
--- a/kernel/tracepoint.c
+++ b/kernel/tracepoint.c
@@ -127,7 +127,7 @@ static void debug_print_probes(struct tracepoint_func *funcs)
 		return;
 
 	for (i = 0; funcs[i].func; i++)
-		printk(KERN_DEBUG "Probe %d : %p\n", i, funcs[i].func);
+		printk(KERN_DEBUG "Probe %d : %ps\n", i, funcs[i].func);
 }
 
 static struct tracepoint_func *
-- 
2.40.1

