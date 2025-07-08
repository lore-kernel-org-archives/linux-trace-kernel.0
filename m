Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FDD2E542B;
	Tue,  8 Jul 2025 16:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751991886; cv=fail; b=UfQY4wIr/uaVRdKs9OHj9scSBLXk1K85nrveWkOIrZsWCTIhc/lf1OCTHr2Nx6PXFbvBnFEslwounU1a+ioQ7fWhhvk/B2SyNuUAsu5iche9IMNSm7wuKvTBjcmxIwJBbrC4eDyNuN8SHeCWOZMILCVe/GlTi1VpuCeP8+W/aHA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751991886; c=relaxed/simple;
	bh=WNJNWbWU7mPFzITPxR2Buiq6aLcfwRUl4fXbtt7oM6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Hh9E/A3KjFkhr2per8LZdNXz0aVdqnjrtCuLqDJfplHiv/S2U3riOj1UcYeA/GCJMc818QOQhB1wCzGH/56gpurXi9FoORYkh1IhBfGJkuUhnyOUDWTfC99c5bmuBfVNh0q33lXiCLFS/YRrdTI47Ba1HYHxrN0zU4faw4bNuBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZrH60n3A; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Y53oSHmZ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZrH60n3A";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Y53oSHmZ"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 568FBres032516;
	Tue, 8 Jul 2025 16:23:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=WNJNWbWU7mPFzITPxR
	2Buiq6aLcfwRUl4fXbtt7oM6E=; b=ZrH60n3AGq5edWMYEqAlbQhxv2QnW+KI9z
	pe69XfB2Lrc7wCjqmHi9x8gT5IAe8if0IaRHrOtA5Vln3pHqWo2bVJJFkSRYsJMU
	b3ycupoQgFRemtHVIwdVUvtkdHhPH921+ujgIf2UlBQ1XOIiPemkOGerX6YyqERq
	/ebcMCbSMwfDA7ItESjYRpS1ZNRIpC5a03OhN0J1Qjcci9bkvKi9Oo/l8XuL9vw8
	5AMdAEvyIl5x2z0mf6kZpdAvc0j1e0PingG/nJxYi3erse5FYcyINfMsB7LzCNj1
	0nvvPuL4tz+ONMt7fwAcRVNpC0c+P+HC0QunR0oRpGmmIUGld/mw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47s5rtg59b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Jul 2025 16:23:51 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 568ExtHK027375;
	Tue, 8 Jul 2025 16:23:50 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ptg9ty1r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Jul 2025 16:23:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PM7DLZiN9gHC8Nn5hPpf6tyTUDaTQwTcEg6laIyePbGjeZaHgY/g8wCCbjP0kw8yxirZZXiEPOdbtYDOgoi6IeJ9mSsmHKT0Dvx2EJ+K/HAR3Ck70Ks5JylGtvpYKvak25x9hH5NQReEZKd05OkxZootmqJhGZHci/szL300P6UNf0PgTD0N8tnUmvC89eqmqirRvBxk3MD5eKjbmq01wOMUSiMCl7YHAElDV939e9ILS8x0r4Y3ghLcGDwIM4QZUSESfdDIzPtXNEioWnzDsBxlmi5TQgtMp8tZ2a/va/OlPMUQU9cNIEhNzLfL/EqkDQATKX+AKgXlyvuQ/3N9wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WNJNWbWU7mPFzITPxR2Buiq6aLcfwRUl4fXbtt7oM6E=;
 b=iwxdyTEWI47ypxO6vZNE1MIxRDaOUd6USEBkeQgWK5tCzwhA+69iXvksvndCBkqs02ixCcuMKxfay36NHHvnzbXuoXmJL3JLquNo+xFhg2pnIBfBiV+is0AqRjL6ewSKDlc0Bkw1Mf6xF2KQqWWdVqnaEJ1DdWkJrB8V3Wp5JIIVHaRtyxFs2VgyIyXj3aWrOSQsvE5nevLstRYSgiR1bdAQGHDKdsl1HVL19EiY49hNIqrBWmh491GEXG1p2yhmWyTq+4PNShaGp7QkSaVuCLZYYvFJL5XWlFJfFcvFJbKMh9fmUDEY9YWyVpwJM1jcN0faK4An+1TCu66chj8dcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WNJNWbWU7mPFzITPxR2Buiq6aLcfwRUl4fXbtt7oM6E=;
 b=Y53oSHmZS9J2/fXJ5jDkfIysfMcaBTeisIbP2T4XKkBwL41aE4u+Ws0XaBw2P99gMLManK8NNB/6ObLySZZHdRmqs3vMnagI4mXu6Mm4H9w/UVfriI7qwrRN14wI2MNxPAvUITWZWSExdzopu83smv75dYclmhB+d28EvzWETB4=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH0PR10MB4905.namprd10.prod.outlook.com (2603:10b6:610:ca::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Tue, 8 Jul
 2025 16:23:48 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8901.024; Tue, 8 Jul 2025
 16:23:48 +0000
Date: Tue, 8 Jul 2025 17:23:45 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Dev Jain <dev.jain@arm.com>, Nico Pache <npache@redhat.com>,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        ziy@nvidia.com, baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
        ryan.roberts@arm.com, corbet@lwn.net, rostedt@goodmis.org,
        mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
        akpm@linux-foundation.org, baohua@kernel.org, willy@infradead.org,
        peterx@redhat.com, wangkefeng.wang@huawei.com, usamaarif642@gmail.com,
        sunnanyong@huawei.com, vishal.moola@gmail.com,
        thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com,
        kirill.shutemov@linux.intel.com, aarcange@redhat.com,
        raquini@redhat.com, anshuman.khandual@arm.com, catalin.marinas@arm.com,
        tiwai@suse.de, will@kernel.org, dave.hansen@linux.intel.com,
        jack@suse.cz, cl@gentwo.org, jglisse@google.com, surenb@google.com,
        zokeefe@google.com, hannes@cmpxchg.org, rientjes@google.com,
        mhocko@suse.com, rdunlap@infradead.org
Subject: Re: [PATCH v8 01/15] khugepaged: rename hpage_collapse_* to
 khugepaged_*
Message-ID: <79bb3f59-7bff-4e18-bcf1-6414c188db28@lucifer.local>
References: <20250702055742.102808-1-npache@redhat.com>
 <20250702055742.102808-2-npache@redhat.com>
 <9076b4be-8b1d-4434-a72f-d7a829a1a30a@arm.com>
 <e35a4316-f6cb-4f1a-b338-4e62c0974d2c@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e35a4316-f6cb-4f1a-b338-4e62c0974d2c@redhat.com>
X-ClientProxiedBy: LO4P265CA0218.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:33a::19) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH0PR10MB4905:EE_
X-MS-Office365-Filtering-Correlation-Id: c8c66cf8-0cb7-48c7-b573-08ddbe3bd12a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?epOr/yWRq3LiDm7YifJ0T9FK2GGZzwflOKCRPN79Ome4HWxqoqRf9me05K54?=
 =?us-ascii?Q?7f59/fD+1JRANAYsBWSSsK/wRZmQgE8NSiLwYEEUXHQBZ69vFHzddPONrFc4?=
 =?us-ascii?Q?YtmVblMNNUfB3taAVLB0CCp/ovSjwsBidOS4chNf7V3w41VFsfWCojVxpj2z?=
 =?us-ascii?Q?4nbv6upJe9V3H5XFyt+rNlhfb3/CX0+K962Jrexrgf2A5cczTi9RGyG76jkM?=
 =?us-ascii?Q?+07q6RZ4365xf77ZSElG8u59FNrjwSlntfuA35DMEtA96ETSDB9YpvWjCemH?=
 =?us-ascii?Q?ShRvhqBRwiwxGygkQfz/uZ8GtPNgWo8irisLZEO7HAk2ZzoQwcu71DovJhBd?=
 =?us-ascii?Q?ZxhANNZqosBeYaJMEUuJZ8VfMZcjBcf8bjIUjsHFTAznK+hnc8cZBBQulLxY?=
 =?us-ascii?Q?9/W4Ko3VUcaS87rZ/ZGySqP1QPD0WaKNg00B8xO9KGkuOeKDqOmARADf5+sE?=
 =?us-ascii?Q?Qm0jMEl8FQgW/CzRO4vw3o8K9RwgLPWtgKlEi73LkxPNOtBTUFFLNowRKNTA?=
 =?us-ascii?Q?A/650yvbnE7O8Ay5CniAf6sYlqkkojMtOuJYvVkwvJaoDd/876S3ODNm5OPD?=
 =?us-ascii?Q?oE66eSMa0Oo3VBip1gugdQRUEELOGoIUxdbq1mAZzk0nZcVmUvrXTQTMnAGp?=
 =?us-ascii?Q?R+z2wYvz9Iq8Gjc9w35P/o1JzsowU0UxWt3m96mc4C4wCaoPOE/1i9cfCBJN?=
 =?us-ascii?Q?tjC6J9y+gG7RwV1qHxAQ17EAKBBJiTWWqKSQ712PidGskf3HzzZAIkGCI+1v?=
 =?us-ascii?Q?QjYDdedot2KwqR407mgJ75ueadKznAcgtsYCwrFX/fbWpIDLm07OfHLewCtL?=
 =?us-ascii?Q?z5sIoxDxvHKWGEUcqJ53ymyPshLaT03uOHdYl2YfjSBwUtE6boIbWVz2RftF?=
 =?us-ascii?Q?cY8/9GtUpL7HdRoMDYB+MO9T0s+KZatZZ78w2KbIhGepnSiQdghmcs9ulBBc?=
 =?us-ascii?Q?wE/gHmZ72fxqneukatbbLRgn0kK3fyJlnb5rz3+FqkIJWOFVhaoX6PRKvZP7?=
 =?us-ascii?Q?kAO5+8vo/8vvUZyxCSjLwnZSi+oHiJ923hE8a8SK+V8lWx0GTM52wu29OxhP?=
 =?us-ascii?Q?kD3kLKG7obVxDNMPWAGx9I6RS5J0Rwo/cZnt3OwfugZP8WtExzyI5kwipVQS?=
 =?us-ascii?Q?4mSEHCCEPFDoINcaFVORQB+x6WA9IjuXgp4HjbiiM5ZVcD0ZUCTcSp/avTOv?=
 =?us-ascii?Q?CijYJA70CM8HIXSATnHJWEqnXN89EHRkNxEIxiody3mU0xJYJUC5lEvy1/Ip?=
 =?us-ascii?Q?GA3nH3uClqL+X3xrUdhG9wLxtV01QwA0qQ6Pkq6lcaqCV5tL5+LHwpBhX3Wf?=
 =?us-ascii?Q?+kOCdFPPitYkI4c40mRJBm9YHf4P1FyL/WvQbE2p67fbCMgEArWzfnWQqllf?=
 =?us-ascii?Q?whJSP0lbJRFEBHltxZDyfPBJb2ArZys39SqsD73WgywuOP0QAvKOPhQIHLFE?=
 =?us-ascii?Q?AB8k1anOkzw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DAS/7aVMuNLODnH1ERNAbLOPHrgYWAOC9qH8o33ZeBnQP+thAvwyHQWuYBYM?=
 =?us-ascii?Q?41d2i49MxZ+kd385N+PvZCTqySwoGoEJcbY0/qSP019lRcvAxJgC/6kuE4Ig?=
 =?us-ascii?Q?/XfAofVZCBz6uLUgBh60KywRNOPszWoy74VBOSnNNi2BygHihFM3K2Zhw2NR?=
 =?us-ascii?Q?t4p6bFsZy5XPGH69iR+XTqCmNNNrgHIgTeDLk1QLso7goBUEhMeAIbFSSBoL?=
 =?us-ascii?Q?EtTCSnKMTuRhi4vymMUQbJexfWwqNnZeJCf3onkpEdKxz6DDC5VyTegeoAAn?=
 =?us-ascii?Q?LwCezEBW5G5Ux9AqvvIRL1i86st/3SyWXt+Kf1VvyZ6wxlvSS7h6TMLpxsMH?=
 =?us-ascii?Q?fig6I6q8ozkrpDfuaJxlBy46g456kDtVrSonN1P7AQEC7k7t/lunQhrF8mLZ?=
 =?us-ascii?Q?lOzQ4AckSyhsZANANfrfOAiM9SFpSm6ZYYQAGMwdnuLcN09NEaNReN7u1B2z?=
 =?us-ascii?Q?vqze0EbndEByaB2lxE1/6JA/VgEmMr5vBRjWli2Yt/X+qrzi/ZJh9bnWVrwV?=
 =?us-ascii?Q?vTHTiVZqrTaB0To65eYR2J0Y7TOEYb2VHfW7sqvh93sZ0LcPdI0Qe3+cKJmH?=
 =?us-ascii?Q?dVMkoon8nGb2Y3JOHv/5aJRdaIFZV9pqecB1yhXFQp1DD+ix9CtgIdmdOOb8?=
 =?us-ascii?Q?ZcuWmzQLypdIc1r42C3o7D3q6ZkFKO+KpTrgyajyTQP3bBVrD37pgzaPhaqH?=
 =?us-ascii?Q?MaQyC5CW2y6F0v3EQNFf/JpQEjpraz1hZu/8goc1/TV8jhA1LYNyAab1moUS?=
 =?us-ascii?Q?TmLAwn4FyWJY/mwIauKmMVlXRULfYaaFvVBAXDBANA0QiCaOl5X3F8KoI946?=
 =?us-ascii?Q?y46sA43KFuu15C8i1mMaPWlo/CJ9IZX51pBmIb7zBgY1bw8CXKc1ZCTPMqEf?=
 =?us-ascii?Q?YrnMeT/7SHneWEOBQi4DTJ2QG5ZZpCQ33TDMkderaiwstAGR4iZNiZ/PS1r4?=
 =?us-ascii?Q?JPwhffv0sk4OWVJodx0ijajmo/q7NM14pSfyjnn8ckAj1mFP3Iju4ai70rPu?=
 =?us-ascii?Q?YWkYQpfdB6msVLJmycNww0PAiD/T5BygghVE8wE6rImd0wI7zEsagl0+5g8H?=
 =?us-ascii?Q?swKqKb7Bt02bADrsSQfN9AAgdihU2cYsglKdaoW5zJa+gWdRNhZBue15yRUp?=
 =?us-ascii?Q?YXCIkm9RFuXDTuACNBIEWEAt2g4eZ+AwvnBxAMbmcN7ehWG0zL2SdK2l04ZF?=
 =?us-ascii?Q?PiR0SJNffb1MWkEAv1OY3RK2SaOAZ3EGnZKUx6VYDhLR9uSBwYeSrwwS6ort?=
 =?us-ascii?Q?OWBZtpDkET4XIWpZtico6JBD+PZUIJ4PbucSErReag6QcYnhEWbzfqsvZGfS?=
 =?us-ascii?Q?kChsVgce0b7iJEfh4//+cyPEauPwDWroUOPtvjpMFWoW6Iskh+JZOnBHy1f9?=
 =?us-ascii?Q?SEVLLgZ8781InNrD1tIMu+/7yk2V51KB0QafEp4u4qOjkMN+MlUu1wZ+Lgnm?=
 =?us-ascii?Q?2+WrsBZH88n9EVHAVgU94lslHHtZH/bXDaoj1Z7C5Pr/XOPMu3fnq5lPGWMZ?=
 =?us-ascii?Q?NZrmbuJ/p4pNxcnKxgNPETHEkX9gw11a2bcedA/03Kx7cdUrfconEzcO+jGW?=
 =?us-ascii?Q?iCLNb3NOegdy/lzjJ2HeynAfnWaYdMnuHUV8cGPT2azWiDvcRKGlyjQYvesK?=
 =?us-ascii?Q?ug=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GBCUHnWyGfogpGGvccy9ueYSrc7ZNZzKbVHwJXTmZGPmqgwtEbfcNGJT3tkgjhiPC2wDUZCd5UjaK6SQpL9QIb6ZeSsf6aSHbmrb/HQDOn+6uaFrqd0d3uo5BKtQ3gCidCHwgO+bi+HOws2wFdFqPy1RAbDHMCXoaGl9MLfjjoZObqqG+t2wsqqL5PXRr+eA5gItSM5zmHRwfxsLK2oLOFxPuffakHwNLasvZDS4TedPuZ0nzIOIA82WAoZ0DcI5YwM8xWp+RhHbKOkk085myLzs6cVwBBZTbE38bsM8WCW7yltqqLcQUyXj4CNdojLnuPQYqwF+7qyXsi75WcjUi3chhErekFYnGvTKEm/nr6dp1O+YmflNuH3O49C/d9lYtAvgpV/DRQQ9+qPqU3/JJb0/MO20nvGy2ZNjT0TSlEslNm/aFbbZiE9J1gIspSgbR/IGkKP7x7vfnk/L9CpRhF7frXuXFgjy3ZiqNd3BTnDcZ8zWXybxeDhFHNszk+w1KL1ZJs/15nQVpo/PRTxNW6fLwZDWqJ9Plo0h+Zv4AYftLw5lXOQBUGHwObYIQs/WLD1Hshrwee/M0qlO8Uokc3TF6zj0r7QJLpZ7fa9bDow=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8c66cf8-0cb7-48c7-b573-08ddbe3bd12a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 16:23:47.9167
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qFuWu0lGDhfD0joxXxkXDWLsWkEoW0BvXMLbVLK2dQz2f6VHzl3z0zlqdZNly0YItSzKK1ni7xeudCa4pwUPVS9A8KCg0CvyQVnY5RsBEqk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4905
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_04,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 suspectscore=0 phishscore=0 mlxlogscore=835 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507080138
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDEzOCBTYWx0ZWRfX3F8FKAkGplsy 4wy/8m55jptw+yVZcxW9PNbFwFbn4uyEMaDJx2iqNCDsXeqxiE/FGZX6Qkz8JgDgmLY4aUNQ8bF LXRpapbsWbmmNsj6sBNeBCsCzOJeBNRCZ67IMbTZIFLfGYKmMo4oHoPnEiL692MdlRYSicIakhj
 cARmEBsRwjIcAJhMW1Ek0nxmxUg+iPO0sA/783WJup/t+H9N9QLr4J1xFo/+0FZERCQXLj8H46E x9YHu+TbuU31l69QiZJFEwb84ug6rhBbjy9atO3B8X4ptKxA+KnFZsV6moK3+iDeotAIlYaCBTi oySnTF4xfOW4b9AWBeKHzeWpmuKeFC9DG82eyTQ1ZfyL12/YFcJ6BUvlUhJsXH3utNZOAxEXM0V
 WNF+bET2Rf+n4sYdvXiw9UapWLS2DOdQAJ1eSh8gfrOBXeJodPWKMxkqkRxZFV+Q0PnVGENa
X-Authority-Analysis: v=2.4 cv=ScT3duRu c=1 sm=1 tr=0 ts=686d4617 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=AFNuM6uwx-vTrvlKcrMA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12057
X-Proofpoint-GUID: AG18lOUT3JSKh9BQb0jmPrtIGPFuBiqe
X-Proofpoint-ORIG-GUID: AG18lOUT3JSKh9BQb0jmPrtIGPFuBiqe

On Tue, Jul 08, 2025 at 05:57:31PM +0200, David Hildenbrand wrote:
> Yeah. Or just "collapse_". Anything is better than this "hpage" stuff.
>
> >
> > @David, I forgot where you replied but I remember you saying
> > that we should not introduce MADV_COLLAPSE mTHP support for
> > now?
>
> Yes, that's what Lorenzo and me discussed. Better to keep it at PMDs for
> now, as that's what the current interface promises.

Reminds me, I will reply to that thread to make this clear.

I'll also review this series, at some point... :)))
