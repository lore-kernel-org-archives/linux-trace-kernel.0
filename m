Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A04233B96A;
	Mon, 26 Jan 2026 15:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769440855; cv=fail; b=ZjB26oDWOmbyn5Y4LfhOgoCggOxwKGIWcfijqFl5VtZnqcdB/YRwd+5j4g5VBabWUnHUEQqXp35y+5/0ynRoDNeIHNofnJppn3sp3aRi0G3gzcReE+6759NsbGp3IuEmqnW3grl8rzBueQKAhJFKYI8vV8TWvBla1dGN/5zohZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769440855; c=relaxed/simple;
	bh=8gbIVY291AHIMaCZRrkewLMs5Cs5SCpCkLReRtTsMxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Lk+fNpuLpWSK/xcbKC0LE5kixq+EvmBFaj7ndj4OI8erG80B3U7qFAm+wNKKz17J6b9zuSlHE5ueF4vrNq76QONxLcqTURmqHrEbWBPTscTw7wp+JTK+AcdEUxA48OU7TsCzEsN6jnXmXFm9TempRuVfISB/7MAsK1++TDD/FRw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bPD/I3Ce; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AOvzf/2h; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bPD/I3Ce";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AOvzf/2h"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60Q4d7Oc491228;
	Mon, 26 Jan 2026 15:18:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=r3MB/YRU0fzPSsGGaY
	eqsQbDA+KjfUUDfrLQ4ORMw4w=; b=bPD/I3CeMmOIWwchiMwNaMmp4tRMIPGI+2
	+//hGNvosK6RxJnl3ytyywWAayRHLrC5VmDrQcQ2HMJVVkFg1CDDKgftaZ3krH7B
	mNiFSw+eg66KmQSr38hF3egAYalsjjXXBcD8hQFu8/uvOxWJjnFvyCn97x/HsXkw
	1ygg47XeuLkJ+s9fhfIs+Wky0Nw6Rr0ou/QUQQY4HwDHPnohst1ksBliJEa5HTnm
	tVBCgDCWaqudefMtJYuyWPbg4gLu5oDL6cIbEpGmuq2m4LyzS59hoxt/pKtxjW/x
	A2NG5qHl7hf7a+c+T+YqM1OZ2mHAT3TlmfxVcFVd+Nq7G8AT6teQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bvn09j1ma-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Jan 2026 15:18:58 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60QEkSnW036107;
	Mon, 26 Jan 2026 15:18:57 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010033.outbound.protection.outlook.com [52.101.46.33])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4bvmhmate4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Jan 2026 15:18:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZJ/CkmC2fq8385rk3T72ncjsBKl1FjPvdKwfcBybSFabwKdYufSq2ntPwpmvNdeBQvNZq/bWUmeJMw13o1OctYgdUeGqC31q0EFdKZ1xV6bV59j5jopBfsPGwMA/CsljSifHwcb/irOePXKGh7OouRjBMZQxlj1zH6BrxBT3fufYQA4jdwDtVmka8SYBzPEep7HhinoJx5mc3leDQnWkHWIIl00entM94HRScLpa0HOif4KoPToia5SVt8GFqjxxjkZpZWvEyIg6+DFsnSiEFnAZiY7ilLt9mvHUjPG+icnMKTWANg1PzcryiQLSyqb4amtvDqa/OUCaBlU5dGXEOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r3MB/YRU0fzPSsGGaYeqsQbDA+KjfUUDfrLQ4ORMw4w=;
 b=nVWnZFxqiui6rZr6Khprj6mLlGFiGuIKLu+BeJtkMcbqLOtLhzXoIHY1gK1TVNHGDc2neAgKzOLdhWhWL2jnuZWiXkproe6QI44JMQR9QlZFsWoO/zV6N+ZLX0xVPDJyZRB7heEpk7dGndL4yesbgRgZPDtIz39xiG9FVcTIwNifUq64e4X+P9Md/TlrvH5ZheOx+kdto72G2tJO/6wZnaey14KKNKtNd2lK8q6XZxeHHS4eGpLwYmvhl/hTA79DoqZcE047Xwmm9vqn/OkR4rP9BFwMjjdI0o2m2k062NBbvebiNOTg82ted4sx6PrcNlJNAXlw63Kf0QJKF2yQfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r3MB/YRU0fzPSsGGaYeqsQbDA+KjfUUDfrLQ4ORMw4w=;
 b=AOvzf/2hzl7T0Bgys2K4iak2Cq2zVV1FFqVvoS+2pEMvZlqqSdtNfdA0SFZ7g/3a823wEZDyBX0JlK3CgnpxOdgSsmsICoRcz1J+u6oi1UgIBoLBLCVuKCXub+zIyxzlkeYMvqeZ5BgalKklLUTH/fUV6kcFQdLHaEwInKb0I8w=
Received: from CH3PR10MB8215.namprd10.prod.outlook.com (2603:10b6:610:1f5::7)
 by CY5PR10MB5913.namprd10.prod.outlook.com (2603:10b6:930:2f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Mon, 26 Jan
 2026 15:18:50 +0000
Received: from CH3PR10MB8215.namprd10.prod.outlook.com
 ([fe80::4ef1:fa49:5a08:c1d9]) by CH3PR10MB8215.namprd10.prod.outlook.com
 ([fe80::4ef1:fa49:5a08:c1d9%6]) with mapi id 15.20.9499.005; Mon, 26 Jan 2026
 15:18:50 +0000
Date: Mon, 26 Jan 2026 15:18:48 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Lance Yang <lance.yang@linux.dev>, Nico Pache <npache@redhat.com>,
        david@kernel.org, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
        Liam.Howlett@oracle.com, ryan.roberts@arm.com, dev.jain@arm.com,
        baohua@kernel.org, vbabka@suse.cz, rppt@kernel.org, surenb@google.com,
        mhocko@suse.com, linux-trace-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, corbet@lwn.net, rostedt@goodmis.org,
        mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
        linux-kernel@vger.kernel.org, matthew.brost@intel.com,
        joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com,
        gourry@gourry.net, ying.huang@linux.alibaba.com, apopple@nvidia.com,
        jannh@google.com, pfalcato@suse.de, jackmanb@google.com,
        hannes@cmpxchg.org, willy@infradead.org, peterx@redhat.com,
        wangkefeng.wang@huawei.com, usamaarif642@gmail.com,
        sunnanyong@huawei.com, vishal.moola@gmail.com,
        thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com,
        kas@kernel.org, aarcange@redhat.com, raquini@redhat.com,
        anshuman.khandual@arm.com, catalin.marinas@arm.com, tiwai@suse.de,
        will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz,
        cl@gentwo.org, jglisse@google.com, zokeefe@google.com,
        rientjes@google.com, rdunlap@infradead.org, hughd@google.com,
        richard.weiyang@gmail.com, David Hildenbrand <david@redhat.com>,
        linux-mm@kvack.org
Subject: Re: [PATCH mm-unstable v14 03/16] introduce collapse_single_pmd to
 unify khugepaged and madvise_collapse
Message-ID: <97dae79c-1ee4-4a7a-9587-f97c0a1720f3@lucifer.local>
References: <20260122192841.128719-1-npache@redhat.com>
 <20260122192841.128719-4-npache@redhat.com>
 <65dcf7ab-1299-411f-9cbc-438ae72ff757@linux.dev>
 <0e79a766-811d-477c-83ee-389db29d41bb@lucifer.local>
 <20260126070918.cbbd532f4a8813e8a188108a@linux-foundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126070918.cbbd532f4a8813e8a188108a@linux-foundation.org>
X-ClientProxiedBy: LO4P123CA0563.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:33b::11) To CH3PR10MB8215.namprd10.prod.outlook.com
 (2603:10b6:610:1f5::7)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB8215:EE_|CY5PR10MB5913:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cb4cd27-e007-4c6a-8096-08de5cee354c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ffLytMI+RKLZr3K7eINCthkeCb/SCqKDkHp3nW3WnKUA8n5kLPyFwUpftswq?=
 =?us-ascii?Q?IddM0rSVfMpOUsdLzkl6YgqTVlvAPt3uXT8w20TKBZZo4tuOsNsDpZkinEFF?=
 =?us-ascii?Q?NNE7eutIgz6e2elSri6PUMWavANM/Nda8brt1bCyaswZ+6aRAnE2ymS4j9oU?=
 =?us-ascii?Q?LRT147BpJhVE6RHCC6zG+O3h72Gr2ZcSo/Sgz9blRHFAOdi+ARDzPhKPbXxw?=
 =?us-ascii?Q?39MNCAKz2zwA+d0hGTNkKeKxgLsNSsWCtdzQvcbJT7ETZdChoezs6+XKU5I6?=
 =?us-ascii?Q?jXu/nLD4GJMG9tnlpn3DCmCV51hor1QHMfQkvDCO+l3VUrbrMTlE1dqojvKj?=
 =?us-ascii?Q?XO7W1gRkBfNX9ZiOjpuKJvRJonZmmEkpWmAJHJAfm62Rg86wX9z58u/L8VOs?=
 =?us-ascii?Q?/p9uca5CKVdRWP0uCkgbzXePu9kH5SAVQHQFxGsbPHNPblmmh5qKpmsdthV7?=
 =?us-ascii?Q?hVKsGp+07fg6EsAoMMrPmEgAheyErXPT5OPEva8oe+U6RwIusX2zADdsBgdh?=
 =?us-ascii?Q?nNzdwFY8Dqyx2OkVDzAs8oRVKtx7VTgSo3H6285SXvLkKCBoop775aCuCA2G?=
 =?us-ascii?Q?8ZcjT/axen5ZJS9z9yJVJTNfuZWl0U6z7M8LDEbENLXdxw0nMXL+Hk/j7dLM?=
 =?us-ascii?Q?B2YrRW8BRbkEua/STqd4e7KPuln121hVMbHXvJCRdP3j0cGwFgLnVlfYB4AP?=
 =?us-ascii?Q?YyWx2JgLu9xtRITH9tHFnqaLP1jRYrsUP+CXzDXiYtJiJAzJuJRYtJ8tRdZi?=
 =?us-ascii?Q?3p/Bgi/wMPThKg//+jQAwZYcvXK/Vzl3YWMKUl7r9088+h68IrOp0VyLnaUG?=
 =?us-ascii?Q?u40tMjzu21c70z+mCQtSetqN3ZR0ENC7n73SchVa6u3qO0+nnLQVyVnzKE4k?=
 =?us-ascii?Q?YfgC8Z+3mld3e9P4Zqhw/RJwR5gWQ5dxW+grZUR4dke8bmUnzObDIbG2wZ33?=
 =?us-ascii?Q?jpj70TkakxGRdclc0fnObBj0VqErikNYB1b/8NJdRNML6dE/RMRSPuoaMqWJ?=
 =?us-ascii?Q?H+sM2ytuBlAsJdov5N5H7jRn74m2AtGrCd7kjbJiEnqyDXqM4d2CCV5D6uB7?=
 =?us-ascii?Q?WrCPOrdcYDgmWShcnHvE1ck1jVbQRyzerj0fLGlvwkETUV+eam8kEP6gDBtp?=
 =?us-ascii?Q?vhQCIvjczjy6a1NzjnUCvklKE+JKT8Efpg59PhyF3EPSnhYoS+72YWFFvz6c?=
 =?us-ascii?Q?tHwRwbJmg7QmHS7wvlcYvgkiiT9DD4KWwIxTqvxFUuOwJ/VNezaCp6mAGyHv?=
 =?us-ascii?Q?uO7fz6oxwIvRraLeDWrc7fMYeADmKI/nuiAwPVckNb2C1L0Ls8uf3BHRXzQq?=
 =?us-ascii?Q?SVVt/kog+o3yALlkVtU4sATpLtP3HFo3NNaqkUGPElqRF0CvxF5KC5voJ62/?=
 =?us-ascii?Q?FoxzXdYVj+jvZclJCrM2wRZRqOmxrq3X5vPgMNBBvOhK0fjmgoqtVk1h+cXn?=
 =?us-ascii?Q?cmJGOv7JT4tVmcVBXhqxnvtW2aSYPiHIFxAMiZVBOmAUoPM1lOvDX4pjJ7FP?=
 =?us-ascii?Q?QTnE4aydZ9FjeKSQf9ebjuTrz0CQnxy7cfMf4GW0fFhYr7NTXQQzpgXJy+B9?=
 =?us-ascii?Q?eRF8qbiQZEkKfrebSno=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB8215.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ARGwMnSYULKHbsRUoAYmOKBsEYkwxLlU6KoWVZM6lPiPEOdUA72d4SdLM0Yp?=
 =?us-ascii?Q?vq5p8kWp/35vwbFXD5LSbBZOspEDNdLzHmMUqOTqa4ijHsHv0jma+S1prFSp?=
 =?us-ascii?Q?XXXiVF/7NxjhTI/Td+rR/9FRfun2/vJB4PrFOGAgHUeNS64kfXw2oNqJBgvL?=
 =?us-ascii?Q?/9EQa2D47LwnJ2eukCNSuzUmVfO4j3HWr/4FDsrHM74541wfjNq329pxbQXT?=
 =?us-ascii?Q?pzv2x0p8LCBg5+VgKLyQi7vZKTFWpqcJxWqZmIByD2jrq1KvhhWzr8/kxe4n?=
 =?us-ascii?Q?xwnTBYCg+7QOkEiBDCN8TxG6iXYZugwOkQUuqqtez/7+jb2VyXYVsOxkl+4F?=
 =?us-ascii?Q?S+HDvIqy1GzKI8r4edWm3D7pCUijMMuEyDVmIOBiWqt39M2bpWD083DaeEe5?=
 =?us-ascii?Q?3Xr4k9bX/p7F0NWGbljtL5BHjsy9iShWF3kMSitDKV7cWotNKb4ofoMZTHFS?=
 =?us-ascii?Q?wVbiiaM84uLnhnNToL8LjC+NYPRTJEOKu4t5y/Ae/6PuWOnpm7ZepoYEFpxU?=
 =?us-ascii?Q?G6xHJ0GReGiUPOEGzmd432gJc/6GX8mUYNnetPWErKsrFL/6U1s6ue4/VMsT?=
 =?us-ascii?Q?7Kkl9ZTFTalSZo1tmN0l7XOjpQGm8cjIXqLYLksQg6j2F6RI2k+c8ffrZDa+?=
 =?us-ascii?Q?S+hob/Bkq0F4IwzArK1k4Phoe3Q56DsLL6LFDR+NfN0HgKDnuQ3iWgxFsk0V?=
 =?us-ascii?Q?xLeKqUodmwu8qHKvz+1Hd0wL2C27jF8SS/yN2856Y4cNJ0nUOTX53cY0ouHH?=
 =?us-ascii?Q?vJCmqWm139p+cHWPcJnVgy3Hx4iYXpVYVFpGmQf7Jp3vJuXH160CaxyOtYcn?=
 =?us-ascii?Q?lHrfDSh+rx5AF0ac5hUIdor073fpR6xpePRGZT+pmHDQgyE3qWUssgxjSSvW?=
 =?us-ascii?Q?RioR0M3IZWknRKOkuIgK1auhyuYuB9vE8Udg6bT/i018ExXb8Nx8lusJyUhy?=
 =?us-ascii?Q?ELLbsuSLOs8xMmSoIUpvhkIrfaeKK4ZhabBLJO8kBTuSRvbfs9zijOetLFE/?=
 =?us-ascii?Q?nekJDXuFw5CHFhb00RisJi2OADzJv7zi0VByDewCHRf+pMA0596T54Bnojq7?=
 =?us-ascii?Q?UBV1RUyZNT5HFhFc8aJrjg1OMheMZ7nYRszSwnuCq46Mo+frgXtKaFkb6/Hp?=
 =?us-ascii?Q?BDQAJoWLiZLmlA0CIH9MbDaoV1KXmHd4OpJisPzQSroR+bmOR9vKFtmFCg8X?=
 =?us-ascii?Q?x8gJSJ92/a8xcKRGNTbjP0SMQdb4Cb8x5pij7B7yDiUjLSr6N6xLMicm6Zor?=
 =?us-ascii?Q?cWhmu3rqPjB5GvX6WuDdDI55iXp49peZDRasdPQVqhroX/YIN10wvwNSo6TS?=
 =?us-ascii?Q?IIS+mYgb1NmAg9zRvU3DxABjeffMHPvLAScql5f1ZpUTdfilm3kc2trFLxRD?=
 =?us-ascii?Q?s+fx9tJo+K4pe+5LhcfkmO9/H3R3E88WM48StwzS5+48efcbQ6yHHtTKZ92u?=
 =?us-ascii?Q?cqqOILNSnU3mYzr7TkxLPNJ4YnigGLEARUWm9S0m0CHC6uUu/vJHIVmgN9ER?=
 =?us-ascii?Q?tDfQS2y+k9LUgIJQUXcBFSqsj4NltwahU2G28pLgh4uCPXq+JQdvPYsQF9J8?=
 =?us-ascii?Q?SNEXFOYHxsj6ebpDWqjJsX/bKuS0X0ue+Zx6mtzYCsbLS8BRgVB3YaSZ10Dn?=
 =?us-ascii?Q?0N/1F94zFW8A8PliD0JrpGGdxROBOMYIb57tddVbvFdWo1d2zhz33io7AcyO?=
 =?us-ascii?Q?ag1L3LUdi9nw2ApQE3dajJvueuyPBdaIO4y+vpC0SGzJqciaEJfO88cZSgY/?=
 =?us-ascii?Q?mxrJKozV0+v203zJ+rI1E+RPplqv/is=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YftHcNEnsx55GOB6FV2mnySjtGyuzqi5g+lZRJscW9x4NxfYDbVgXFj2cUPC4xbU9FMMyLVEDvARpRcXyfvvg4oHkCwbxCu+piAniEFxYEGv7FhIAZkaWgvFnS8cGAvr+mTiP0BRVu9RY9iQsTea9bkijbYn0/io6cmNmcJNKrgwCZMy2zBTNyv1TFwznIgjN20ILyuXRB3plbFVVDpl2OvWQXlyhvo7FjJpzDABQSshh6xlU0BjzYGivhFHAOGctlDVlBXFCq7CwomDfaUdFhTbhFT7yZD6TtCvEYYPkG8XEcA3GzF86RIXzy3XYQbb+79IFYgBB9SNmBTVnX4lWxzxU2CIgZq7g5RuCSdf4tEAbYapHPS/SWbmnbgAd0YJYBGwpItcbKTKc73yCJ96Phid4hLAt4KPA78WWWisDOPU5+riukbyP4557ocA0KK54vRgiW1Yl96P7n8cI3PKR8INQATL4l8dhdJC1y9kNAMEv1tOjYOM5VdKLHrodNrv6JR71meNUJ6MzORBvQLtPsBSK5SgUuSbSPSgDNWnlruk+kUfrURMvx3KkKnCosilxV/QT5xskdmKytZqvSmYyFx3KCECVhWzB1Y5fYzftN8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cb4cd27-e007-4c6a-8096-08de5cee354c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB8215.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 15:18:50.1082
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ToOML4zt+fPzZWSFkVfzsO1+NpGGkhHBWO/ZPtK/hMV0uBYCxasulIeNqx1SrrXD8KpJiPfsf5qzcuK+cqbDKLGazX5PrhASJrJ10ZnS28k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB5913
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-26_03,2026-01-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601260131
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI2MDEzMCBTYWx0ZWRfXxjZYcAPOnTPM
 iMMgKbY+xBKnHPU25Siyhml41ZhAMAlPfnbxdLUaenqMRaQL4Tn9QGAIiPk80LriBxqHsCWVTO3
 atSaNrk+J7gA56ABf9kUZDpkobzDS+6URpAFuUnIl9wTetGa84g9+n34tCLdCxgKGBDMIVIHztD
 uQGNh0KzpeJzYyyEMFnRF9BJL089O6xgRzRIEtBFp4owIj+EY6my5auNXSpoBnReKOn3m0FAtRb
 IPQHMsJ+pN5c9lu6vl6a5HWILBPheTXfnF8sY8HI/LV8TeFePeCbzuzWVf/PFt+2EVSXS1bKOAv
 TFLdig+ApWCBhIob56hog8WwOZXGYSPBbVGVAsFhAdKmS6fUely3h+iGj9rDOI1fVoMGJQ8EFG6
 mABBVY8oES6YU5irOtzhNs079FbaFM9uSqdfk52S/wgFKKGxX47Y98TpiL159FaWJUqxbnAgsha
 vB0Ucv8LWoDLhHnpKcAs4BEIi91Cac7VBHecP93g=
X-Proofpoint-ORIG-GUID: XPqxpRG_WsAU-BdPdTWVLUkZdQ5_yFjD
X-Authority-Analysis: v=2.4 cv=Rp7I7SmK c=1 sm=1 tr=0 ts=697785e2 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=bdDnA0Oh1QtCEI8eoVMA:9 a=CjuIK1q_8ugA:10 cc=ntf
 awl=host:12104
X-Proofpoint-GUID: XPqxpRG_WsAU-BdPdTWVLUkZdQ5_yFjD

On Mon, Jan 26, 2026 at 07:09:18AM -0800, Andrew Morton wrote:
> On Mon, 26 Jan 2026 11:40:21 +0000 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
>
> > Andrew - when this goes into mm-new if there isn't a respin between, please
> > drop all tags except any obviously sent re: the fix-patch.
> >
>
> I've been believing this is next -rc1 material.  Was that mistaken?

Yeah this isn't ready yet sorry. I did hope we could get this in this cycle but
there's too much to check (esp. given this change for isntance0 and we need more
time to stabilise it, so please keep this out of mm-(un)stable for now.

It's a really huge change to THP so we need to take our time with it.

So we're aiming for 6.21-rc1 / 7.1-rc1 or whatever deems it to be :)
i.e. next+1-rc1.

Cheers, Lorenzo
