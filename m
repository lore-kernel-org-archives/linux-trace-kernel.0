Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA182DC791;
	Fri, 12 Sep 2025 13:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757684208; cv=fail; b=Mm2Ktx1ZOrKH2HpFvAFP/ILbyc5C0ibYc70VW52uYXRRR+dWGPZxgBaNkvJU7G/TgO8d/5hKuLJf8TtvTR8u9Mp8i7Eu77J17tlgeU+kqUEv0DRNYBkggPYGvFMne67yMqZJWIPxdv4KYa3kU3+S6u4FJv7iYbFw87kabYH7q74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757684208; c=relaxed/simple;
	bh=3kWVz8xIu6osaE3mBzpFicJ7j6qbw514OcSH8GNkPYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CawBPxVIC5oK4Lo5Sl4FWiedJM36/Lw3jjxqOwSiHDX3ZKPdCmPEEIwWysuurSgf+ls/r7cMNN+Q5mWcTLxxWR0Iv4YFcacHBkf0Ya5HhQx+0Bsl9tk3oruvk9oekwi4apu9d0dE7yIolz86KuVf5Tp9NvFGp9WjGzMdjqW+yUY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BxKoJoPn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RnK/dUrk; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BxKoJoPn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RnK/dUrk"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58C1tq9P017268;
	Fri, 12 Sep 2025 13:35:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=NOmQwES/W+zNoL3DgB
	YLgYkLa7X4kLDOuTUtuO8TS5k=; b=BxKoJoPnDiv3U1yFO6JdSLAfZCfoP4ot7L
	7wd+O1Lw42YeuRZnu0uxpJzQDW1moaopIRhvKSzyOim2xTnGW4JYIy0qNZr7m7OG
	o5U3biEowoktocTgzV9KTg71xXR/ohuuD4N3Sz2RDeeUScp4ByJ3HLQO/xaXbdrc
	SPPPTOpJQELFa02+bHqtlKLe6WO/HvawsKQOhbN2ofRmmUadIOKcsEH+oP/0Yyyv
	Zih0ibXjlt35Bu4UMicKlMtqrnfUaSgsKLlKWKTJyqsotOzsD0GZmuSrau6sTH12
	Gjsz83SQdayEOi8EUgytpZoJblcR1plB9FTJAR5JiqnVCWeOKmew==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49226t08j0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Sep 2025 13:35:51 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58CCrYXH026002;
	Fri, 12 Sep 2025 13:35:51 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013007.outbound.protection.outlook.com [40.93.196.7])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 490bddwwrh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Sep 2025 13:35:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ryNEu/qU06m0sQdoxjzWHPhQJ59k/e8R/Bb+2vuchslQTSMgRfJWiIgg8hDk0/Hh/Zybui85Yfrze5Njw8uxvc2rSQ7uLVvh4ss+2TrIdi965dj/GNveHceBKrksUNO8cSRPb+vPRZmnivffGP8FuT/wA4b+x3QALzcggalLHyjXt9P2kkEPqAYVXfOpuxnen4VYShnQiYCQjDL01rBHJ9XO1GyTf9Oo3+JNBp9UnEO1QgodhMYZZ2Szn2y+bGo+4T8CbD+hBVwnBVVP5Uxx+DlwrRwFcT2Fico3zYP0pfQCQ/HwDxhF+dBQmtCZVGPm2EGTwW8wRpNg15uhOA7L9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NOmQwES/W+zNoL3DgBYLgYkLa7X4kLDOuTUtuO8TS5k=;
 b=r+rIHJhwfLY3VmklY7l1+uP3In40SHolxWdyhuwXqEWoJMTFSk8kk0Rd9mfFISHmHFgN7uSRApvZNlWGW8KoGt7ar8V/HZE3jwyyQ7kU+F3IdTiZJLExrZBwHBrpipMGphXvpGaZsA7ekafV57qXO68Dql8+b+HxCwaYvDyyDVgSlhYRmbyqbgGXeoE33pTLHq9/c7MkPpB5RACwjEHkCE+ZP0kxj+E8McPLtmE0+CcKEtbRFICDj/10zH9DPpRInbZ/cvp1vDIl1di2a+bYtoDAfe/Q2aE5+BdLjjzkB9inUDosNiYTa4H/lav038upjg71ja27g6SLEvWw0znMFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NOmQwES/W+zNoL3DgBYLgYkLa7X4kLDOuTUtuO8TS5k=;
 b=RnK/dUrk1dJETTmPdgRrOWCWzrACxTP+dy0aNOSIOLCihc0cj4I3M2x4eAehTyraQ+p0nRYwbPKFK/TS5LlQ50VbTWPowIBCJedmaA/G/DHFpDiMvv8UGfVbo67601f0vBvfLfED5euGxYKybDHmHWiQ5orU0JBfb1Iyw/u6it4=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by MW4PR10MB5809.namprd10.prod.outlook.com (2603:10b6:303:185::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 13:35:47 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9094.021; Fri, 12 Sep 2025
 13:35:47 +0000
Date: Fri, 12 Sep 2025 14:35:44 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Nico Pache <npache@redhat.com>
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
        Liam.Howlett@oracle.com, ryan.roberts@arm.com, dev.jain@arm.com,
        corbet@lwn.net, rostedt@goodmis.org, mhiramat@kernel.org,
        mathieu.desnoyers@efficios.com, akpm@linux-foundation.org,
        baohua@kernel.org, willy@infradead.org, peterx@redhat.com,
        wangkefeng.wang@huawei.com, usamaarif642@gmail.com,
        sunnanyong@huawei.com, vishal.moola@gmail.com,
        thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com,
        kas@kernel.org, aarcange@redhat.com, raquini@redhat.com,
        anshuman.khandual@arm.com, catalin.marinas@arm.com, tiwai@suse.de,
        will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz,
        cl@gentwo.org, jglisse@google.com, surenb@google.com,
        zokeefe@google.com, hannes@cmpxchg.org, rientjes@google.com,
        mhocko@suse.com, rdunlap@infradead.org, hughd@google.com,
        richard.weiyang@gmail.com, lance.yang@linux.dev, vbabka@suse.cz,
        rppt@kernel.org, jannh@google.com, pfalcato@suse.de
Subject: Re: [PATCH v11 06/15] khugepaged: introduce collapse_max_ptes_none
 helper function
Message-ID: <4e1fef74-f369-439e-83ff-c50f991c834e@lucifer.local>
References: <20250912032810.197475-1-npache@redhat.com>
 <20250912032810.197475-7-npache@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912032810.197475-7-npache@redhat.com>
X-ClientProxiedBy: LO4P123CA0663.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:316::10) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|MW4PR10MB5809:EE_
X-MS-Office365-Filtering-Correlation-Id: 19b056d2-86b9-46eb-8f3c-08ddf20147eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Iz0byvODK3J+XWEcnpZ9eHudDHu6HSPyZrx4pdyyoHjfHO4q4HkKx5CAS0PB?=
 =?us-ascii?Q?iQFTk2b7kK8Toaik1k950qmDbGjX75g3AZsITzWeXOTXO5xpNFPN1mIPKW5n?=
 =?us-ascii?Q?OyyaTv9qSyxNlIyB28SV23LzjIpCtBj1uBcpDMOmD/XBDqaQ7jV0cqOAFA5b?=
 =?us-ascii?Q?fwVVCv9aj6ppdRcSQAQpMXyhQyfTTP5u50H8I71q2UXeH6d1QkIbHiCjJYiF?=
 =?us-ascii?Q?c0uizIpkCMfqxiwgHQF74PpHMG8GeWgACRjZc7WxDjAu8i+m2o7a8y707BuO?=
 =?us-ascii?Q?qg2yMmbEtn9QiXRKkHE8HjPrwqgkhKeZBDlK6XH+yo1b8ZTJL1OWkkS5tAtw?=
 =?us-ascii?Q?kiU4rdRJvhvpCuWi/QKwd68Rm5oLzlz9wQN55+tdi8RTdCHSM8HEYrpDQtpJ?=
 =?us-ascii?Q?ypt87SJv3kPGlLBMXJcK/+ZgrDvHkTyPF6kTQgj3DqT4lLrnv2e1YY1MuRYj?=
 =?us-ascii?Q?1zTg5eyR/T8hjbu06z66DNGDX2JzVzqyYp9WbpbBcLeid9V0/T59+w/+9Jdt?=
 =?us-ascii?Q?wctmivn+wBV6+PwUQQZkB8HdcIxnzhvX5B3uYIPXX12A+EI1xcrn+y/3AlWn?=
 =?us-ascii?Q?pgoj9llgTwPUHp+PLhfIy710J4xo+CMv0xbOKJy4WpE7TACOPm7k2LuKGszU?=
 =?us-ascii?Q?6E/icnqbMd6iGEggnAZILGZ//2lrzFu9OsBdSu2y4tma54YV0EYvriED5FrI?=
 =?us-ascii?Q?3lqypxb1mkeuUFz2Fzu+gS7IQrtL2d9YZxEBJwX0Sn7pLpzuQNymFTbwC5sm?=
 =?us-ascii?Q?vRtBanc+TY+Zq/ttBgnTL6tgVI/prpsqMnEbzdPE9BFoJqB30qKUnsFXmHRc?=
 =?us-ascii?Q?HBQEKWi8dgPTG2wF8XfpKgIJ23WCXQrW7EntZ+SCfOlt6js+g7ZY6QQub7I9?=
 =?us-ascii?Q?C8uSmcup+BOFVRMBQgH++xpht+XXy9SS16WlE+14aqcNyBMZclqg0qk+nCnp?=
 =?us-ascii?Q?a1dcOK1shnpjjUnxdLKJS19/TRSjlS0ocLT3yV6ZKYs4GmvU93/HPo9u4q7H?=
 =?us-ascii?Q?u90BTfnu42i7rRK7iZ1rLoDDVRwQ3EfKTavgrJFZWl6yxTNB6J8ED0pzSExC?=
 =?us-ascii?Q?S5Que66R+roO+PHFjod9eqgE8BI1jdIYdGYfT4CxdgdTzqjZBX4oemZO9X/s?=
 =?us-ascii?Q?13EGPjCcoWVE209Bg819oKKmrI9WdkEDUxzIO06+9UWSZnQMhYQ7JLmfdZD6?=
 =?us-ascii?Q?Fe+89CdIgXgbVRfBjueAcl0eX+dwu2RJ4SvCZKrGRreefdovGc8JeKDCflit?=
 =?us-ascii?Q?l9hSI58/m5wNkGTvfxpwoDooLGemYiB+XE9Oq7Zx1MxrxNztGmtG+wppeMmy?=
 =?us-ascii?Q?JWo97lqxLMoXCu277FD7FZ3egz65EIuvXxtgM4iQ+5gwoRPI8IZf9g8NshE5?=
 =?us-ascii?Q?2oe79MlHpboMmDksSu1FM3kqdlJPns8e1h4K4G86mDEJ8j1iqypTXoWpngmn?=
 =?us-ascii?Q?oFNX5MyNmMM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jt/gK6nCe/7nGMnkKtgIfx4xKVZCAmxbaFYSkL9QIJ4mVHmHTAycVKPuXeqV?=
 =?us-ascii?Q?JDcFyPEXgx8zlgLKrQjaTI3GFVx+zG/IBRBrLZ+DTH175439Vo7iDRjOiyuI?=
 =?us-ascii?Q?ZvoiVNTpfXpTx9lsshncbWADs3fRvvSMiE+7YsR8BGfuMb9KkHF3o1RcaFdK?=
 =?us-ascii?Q?ffcnnB5mOnRd6RQmnS69IPtE2yUZ9omm0Z670sOH8NZQhdC++S1cDguJ614Q?=
 =?us-ascii?Q?ck9a70DuZOWlp0UBr3D2NTHZJwepY7zC+NQ6QndeLaUXgTnUCA7IjGIs6dw2?=
 =?us-ascii?Q?N9LDSruEoHL3v9w65wRMkEnut2vUNWlEfA/52NS8dmuLTAYD38Ru7S7bdpWm?=
 =?us-ascii?Q?SOKKM17OXuyEXxoQ/LI8LCs6A3h/FQM5Wm6A20sH9AEIaAsNfJXRXkS+6feB?=
 =?us-ascii?Q?6Uqgbo7+laYDMKTYiDzlKbCX78DSv8VYh7iy6/W3BnOvN0PdsfvQNh0AMQZ1?=
 =?us-ascii?Q?lUQnKGDYKlGEJmhxq/KQ6Ey7nZF949zF4P0ZiAa0YiLkm0FUjTh5hokPCOkE?=
 =?us-ascii?Q?4EzkMbTKjLa9CLtE1zaIygOf/TtuySrs8hixbdV/B9Puddu8yQ7RiQiR+391?=
 =?us-ascii?Q?h4uD1DCgvWcTdr0CNv4K+LIxRH/AqHUfFLEJ6muzi20hJy06tgoNEOcmzm98?=
 =?us-ascii?Q?c+HIiVNU6jDt7lMRRiU2Dc8quDMqwIL/teb6qYKluyrARqLmwASncbmRZxDD?=
 =?us-ascii?Q?pQkKyA1yEUxVQLfUFHbBxqpDeVeB1CO/FdN0lGOyHeBPDFGSE1TzV6IVzNAk?=
 =?us-ascii?Q?ymy5gFgDty13nJT36yDKMjYNbPlSkJS6/akMgp8eZ9aIBEM3EwMOIbZpTy09?=
 =?us-ascii?Q?/U0xFTiKOktQ67UP+zDCprglZ/rAUCDs0rXXWL5gzUmc1nHIvctjj/2eRLA7?=
 =?us-ascii?Q?TW8hfWBOUkHN+5AX6Wq8aJj6o8yPnrpBu0M0u0+/sJ/SZcQZdSlDHr3DE3wd?=
 =?us-ascii?Q?hZGIpRziWbqCoCa3wnMlK/spbDXT6dMUlZQXsRSrIbBNitTAkYg9BL+O84lO?=
 =?us-ascii?Q?n+XX+NfcUn5ruVw0iroZke6V/a1GQsM3B3ieONl82ZkzaQ23hrgVHq7WPyZX?=
 =?us-ascii?Q?mKMckGfv0+KwOGCFOqxJw8DVcrfkkOgEARSkozAOcpnj6HIwWkbUWbfu0t1N?=
 =?us-ascii?Q?zGEdHt4P2UDrJBe8RUQD4tmQC30clPLvbMfxz0vnfjOHyPQGrJczVyg/hiVS?=
 =?us-ascii?Q?9ydTTKtZDvR6Nc3nyAhr2ZinRbZBgspX2812cRvajp531jh41UH0FjvICvhE?=
 =?us-ascii?Q?Hp9i2Uh2ER+WebHD3TGONmwTErhA+amTu17wjHuQzjzSULt64NQI0V9zMH/G?=
 =?us-ascii?Q?G2Ych713OPWHPKZYpE2zRGalGIQy2l8MuYzgHDLtU97ikx/t6fwdNjaJ/pJf?=
 =?us-ascii?Q?CG/i9I+VQGOB+8GjM/YkGRZ0UWcJAi+yfkV8gN9Bd5rm0dc2BBRtxlXhRM3b?=
 =?us-ascii?Q?7vAOKYuDdBFUyE/tviF6JXDIDRMLd/AI+i5c647wDDIL1dBQt+nb8mzW8HSm?=
 =?us-ascii?Q?xqcPTtdU7LpmebK0+0yf518+/tmViWC8TLY3TD8g7tWo5a6aNPTUlBdpqU5M?=
 =?us-ascii?Q?bp6nsLQFh55tfkHgdSby5i/VlaxF6hAVkHJF8uua6p2K6SRb5ScSJs/Q2y/8?=
 =?us-ascii?Q?tA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fehxTukluXyVmMOM1JubLNFNQvAliJP+Dvb7B/6DMcnPqwo+w6KDImcdXoKyrHbwMxWsLKtvNCNT4z2Leq0k9zMAp884PMB/p8A4KfjfNWfAQt5GdPoBBXx5NPa5of+lFadgjMORb2wCMq8iJPmgO+IF09tNED2kv+2+3YFCqGTcqchkEENYjUz2TqsS69pIp3nFJZzAXK+SCiZmcVxhA95XApn5hRjos1QIrc3vx6iL63Doi9JKTrDlYXby5nCAeBuxA1CItKMOdtrxNh0fsed7DGgPOg0fdWUAhDgiDlpDSvPcixdgBNrbmajAkB6ujtB58VIV3RYURvqrC0XuS7/xEkkGbBYHznlD5qoPfLTTCBImCK0y5h8Iw0UohTTcEN+awRFGvYlRhr/mia2cDZl8l1V/1iF8zfpq9zAyJAcJcV/MCqSysTpwfjssDhk6sOtHnqrNmOOfD1cE2qaNTlRf7n5ppAtttl0V/HMqEejKgnEKqXwdDOmIIhcHAW3vvD/KwTz+MUZbu/CGyIpLD6mTzAy8gnqlNQE2mOopLRsDpeQkPhFXtl1Z0U1vmNZe8OZpyyO+PzvsA1Y+jJZn+4dMEfShW7xgMEzqo1c5yBA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19b056d2-86b9-46eb-8f3c-08ddf20147eb
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 13:35:47.2729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XAwxSijKDn1+756NGtTwotOfzUTvrIN4VQdgQt4PfvBd3RSrhEJSOLVLfJMHZ4B1KFcYEmlVSYVB7liEkKwleC2JcI1gROnDZ5FdUuZSyHs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5809
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_04,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509120127
X-Authority-Analysis: v=2.4 cv=QeRmvtbv c=1 sm=1 tr=0 ts=68c421b8 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=20KFwNOVAAAA:8 a=nbRkX1cIBELV1V8xH9AA:9
 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13614
X-Proofpoint-ORIG-GUID: aAHQgVyNIiDoqa-K9d4Sa7NyOTAd4Tn-
X-Proofpoint-GUID: aAHQgVyNIiDoqa-K9d4Sa7NyOTAd4Tn-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1OCBTYWx0ZWRfX1hLYjJFKE584
 hmo04ZFWEJo7OOS5QJHGjfJaqNftVDdJ1bxDVlYgzNg7Njphwd0ArHUOMTMWSBShc3OZ+iw5oBG
 XZIJnJW+HJaXupklP6WQMDveiDULYLOktVpz1Y6Zs+JIOJGP4xoKqas9l6swc0LjQ24NSDHoHWK
 8qt4RjHaBIObp59/jhCHJd0S/rZaF4P6CCDbA9pAvXBGTO+cVTQ5TJpPP4DkPP/qMn1VhtzBXwu
 jDDdHDdDNcWJLsqfNEd9dIPwuyLHc8vtaQp6HFZRF4rMSlT0TPeCqgPt/KcAW5Hj3PsFbjfoOxS
 j/dt4gLDyakZFIIl8Vviz53/yjaOD/ENMjNxuwZaGpDmmtxvprDIjJRIrAb/2Q+kWVsdEI1Uf0X
 wtyzvR+/RAb9SRwtYDndYEIoH+4ZlA==

On Thu, Sep 11, 2025 at 09:28:01PM -0600, Nico Pache wrote:
> The current mechanism for determining mTHP collapse scales the
> khugepaged_max_ptes_none value based on the target order. This
> introduces an undesirable feedback loop, or "creep", when max_ptes_none
> is set to a value greater than HPAGE_PMD_NR / 2.
>
> With this configuration, a successful collapse to order N will populate
> enough pages to satisfy the collapse condition on order N+1 on the next
> scan. This leads to unnecessary work and memory churn.
>
> To fix this issue introduce a helper function that caps the max_ptes_none
> to HPAGE_PMD_NR / 2 - 1 (255 on 4k page size). The function also scales
> the max_ptes_none number by the (PMD_ORDER - target collapse order).

I would say very clearly that this is only in the mTHP case.


>
> Signed-off-by: Nico Pache <npache@redhat.com>

Hmm I thought we were going to wait for David to investigate different
approaches to this?

This is another issue with quickly going to another iteration. Though I do think
David explicitly said he'd come back with a solution?

So I'm not sure why we're seeing this solution here? Unless I'm missing
something?

> ---
>  mm/khugepaged.c | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
>
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index b0ae0b63fc9b..4587f2def5c1 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -468,6 +468,26 @@ void __khugepaged_enter(struct mm_struct *mm)
>  		wake_up_interruptible(&khugepaged_wait);
>  }
>
> +/* Returns the scaled max_ptes_none for a given order.

We don't start comments at the /*, please use a normal comment format like:

/*
 * xxxx
 */

> + * Caps the value to HPAGE_PMD_NR/2 - 1 in the case of mTHP collapse to prevent

This is super unclear.

It start with 'caps the xxx' which seems like you're talking generally.

You should say very clearly 'For PMD allocations we apply the
khugepaged_max_ptes_none parameter as normal. For mTHP ... [details about mTHP].

> + * a feedback loop. If max_ptes_none is greater than HPAGE_PMD_NR/2, the value
> + * would lead to collapses that introduces 2x more pages than the original
> + * number of pages. On subsequent scans, the max_ptes_none check would be
> + * satisfied and the collapses would continue until the largest order is reached
> + */

This is a super vauge explanation. Please describe the issue with creep more
clearly.

Also aren't we saying that 511 or 0 are the sensible choices? But now somehow
that's not the case?

You're also not giving a kdoc info on what this returns.

> +static int collapse_max_ptes_none(unsigned int order)

It's a problem that existed already, but khugepaged_max_ptes_none is an unsigned
int and this returns int.

Maybe we should fix this while we're at it...

> +{
> +	int max_ptes_none;
> +
> +	if (order != HPAGE_PMD_ORDER &&
> +	    khugepaged_max_ptes_none >= HPAGE_PMD_NR/2)
> +		max_ptes_none = HPAGE_PMD_NR/2 - 1;
> +	else
> +		max_ptes_none = khugepaged_max_ptes_none;
> +	return max_ptes_none >> (HPAGE_PMD_ORDER - order);
> +
> +}
> +

I really don't like this formulation, you're making it unnecessarily unclear and
now, for the super common case of PMD size, you have to figure out 'oh it's this
second branch and we're subtracting HPAGE_PMD_ORDER from HPAGE_PMD_ORDER so just
return khugepaged_max_ptes_none'. When we could... just return it no?

So something like:

#define MAX_PTES_NONE_MTHP_CAP (HPAGE_PMD_NR / 2 - 1)

static unsigned int collapse_max_ptes_none(unsigned int order)
{
	unsigned int max_ptes_none_pmd;

	/* PMD-sized THPs behave precisely the same as before. */
	if (order == HPAGE_PMD_ORDER)
		return khugepaged_max_ptes_none;

	/*
	* Bizarrely, this is expressed in terms of PTEs were this PMD-sized.
	* For the reasons stated above, we cap this value in the case of mTHP.
	*/
	max_ptes_none_pmd = MIN(MAX_PTES_NONE_MTHP_CAP,
		khugepaged_max_ptes_none);

	/* Apply PMD -> mTHP scaling. */
	return max_ptes_none >> (HPAGE_PMD_ORDER - order);
}

>  void khugepaged_enter_vma(struct vm_area_struct *vma,
>  			  vm_flags_t vm_flags)
>  {
> @@ -554,7 +574,7 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
>  	struct folio *folio = NULL;
>  	pte_t *_pte;
>  	int none_or_zero = 0, shared = 0, result = SCAN_FAIL, referenced = 0;
> -	int scaled_max_ptes_none = khugepaged_max_ptes_none >> (HPAGE_PMD_ORDER - order);
> +	int scaled_max_ptes_none = collapse_max_ptes_none(order);
>  	const unsigned long nr_pages = 1UL << order;
>
>  	for (_pte = pte; _pte < pte + nr_pages;
> --
> 2.51.0
>

Thanks, Lorenzo
