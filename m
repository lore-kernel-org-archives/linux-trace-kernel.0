Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012024.outbound.protection.outlook.com [52.101.53.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F327F345CC0;
	Fri,  5 Jun 2026 20:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780690097; cv=fail; b=La75acwgCMKen5RUycyOavuf4Bl8FofuGwTPyi+xh+BT4XSgTpbu/HOt0KPs+5UHGFZpPhMekdY30aEPy6gTkQvq50YwsWZX8vcRXe/gLD+ZeKPBY4j4ggl6GJEHPzW69i6XK1m/v8p78vMukDquFfapMRWSFD0F0QJSPPUbEj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780690097; c=relaxed/simple;
	bh=WNMb2hxKC2nM6DlXB4DgI6A7f+ejICDQfGAPOWD8cmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XVYf9umcFqZjg0K+c2Tx/mJLIgrBEY44su3+GYPP3CK/51lieZvKM1fLng6ZbdYbbwqNFljmqggPncFQhMq11Ew0Tj70HfLu8xwE6lWZOJcEwuj8RuMkvJLnojIt0z/X1MLAGy5nUzAICT3tpj0ZQlPpKQJe1cQE5QaYrtks5ZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mJ9GqTTy; arc=fail smtp.client-ip=52.101.53.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mJ9GqTTy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=reTty9mAyL2B6KIgzDb0OKYQD11e9KyIqI6eeb9uoWKtb2gSKQjM6GcI8LAjG4vddePMSUOSmkw9AhZ1WK2KvVLgYP9VzMQVuoP+SNqpQRV3fROSwTEvkrVRh+VzsiAs7ZzieSO86CG1arWwZ25W4hWbjmSCsPyYI/Qc/pAhFqwAukvjGyVgN6LX3m8HIzmNjCWNX48zzj3ZTV+tFly+eyMbBmrIMlUPrqM6/51rJ2r36kByGUyynHUShSjBzaAOWYMLglm8IDQY07v+1gn7hLbHNkn1KmkjjpoGISLz596z6qSwlnmXAxPqbp/uIZ4F/cvcxR53xcBsLyX1VI0xGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zDOq5HSj2oX768VN+NTdbrN4/PMY7AoRKtlpz3K4WoQ=;
 b=XXtGHYO5TIOFE62TLtGNWYf7CyElrpp0uV7Q3woXSGdGzSK948QIP0XjONfQsIBB0pz3Fk6ODIfdTrksOGer20PkSn40axgflS8aC+XTLKSXpEu5eoNmLegESbWjL8ejydYGVauU5mSU7gOwwT06kdAguZU00RnkW2qQnuC+qwjpIAiWC7YjNxBvzYWDOQ468ByRO2mo1XHAFmietyAlmkuJBDMmyriPT/afiYp2lT29UNYsCELY5XpTG/oC2eaGbqNLc+IPjcYwu9L3Ib2RgCtURcaB3LE0aVWobXTCHBnP/TCTUGfesxvVr3QGGbCx3gOcanXh0XvcYOgWWaMAYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zDOq5HSj2oX768VN+NTdbrN4/PMY7AoRKtlpz3K4WoQ=;
 b=mJ9GqTTyhtLT41d7J+2EiF0qWmFLFjqJawbNopfCLqLUTybLhqe/XFa4Vj4thHw9hKQfHGquCH7iz/dJHdH77Jou/u8O10Sa4p9U8RdILpUYKk/HCVCL4gA3u/U27X2GE76OaqIePQtsHbdassDNxeB5M713OBbpIhD8gY4NwAIW1VM3gTC2g16qYvLittz+KFo3Vc/kND32c+D5dgO28MsEzBQuewscyFqQyoIWCIK4/wkIUrB03PK1J/ICK2qS9RzGmk6SNL9pMqDdcrIaTgC245SPi/XNNZyIvELiVrUQ+TpoLvXOMN580bs1rsUGM4cpsZ/SiJcRHDyFlqbGVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 PH7PR12MB5998.namprd12.prod.outlook.com (2603:10b6:510:1da::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.9; Fri, 5 Jun 2026 20:08:07 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2%5]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 20:08:07 +0000
From: Zi Yan <ziy@nvidia.com>
To: Nico Pache <npache@redhat.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, aarcange@redhat.com,
 akpm@linux-foundation.org, anshuman.khandual@arm.com, apopple@nvidia.com,
 baohua@kernel.org, baolin.wang@linux.alibaba.com, byungchul@sk.com,
 catalin.marinas@arm.com, cl@gentwo.org, corbet@lwn.net,
 dave.hansen@linux.intel.com, david@kernel.org, dev.jain@arm.com,
 gourry@gourry.net, hannes@cmpxchg.org, hughd@google.com, jack@suse.cz,
 jackmanb@google.com, jannh@google.com, jglisse@google.com,
 joshua.hahnjy@gmail.com, kas@kernel.org, lance.yang@linux.dev,
 liam@infradead.org, ljs@kernel.org, mathieu.desnoyers@efficios.com,
 matthew.brost@intel.com, mhiramat@kernel.org, mhocko@suse.com,
 peterx@redhat.com, pfalcato@suse.de, rakie.kim@sk.com, raquini@redhat.com,
 rdunlap@infradead.org, richard.weiyang@gmail.com, rientjes@google.com,
 rostedt@goodmis.org, rppt@kernel.org, ryan.roberts@arm.com, shivankg@amd.com,
 sunnanyong@huawei.com, surenb@google.com, thomas.hellstrom@linux.intel.com,
 tiwai@suse.de, usamaarif642@gmail.com, vbabka@suse.cz,
 vishal.moola@gmail.com, wangkefeng.wang@huawei.com, will@kernel.org,
 willy@infradead.org, yang@os.amperecomputing.com,
 ying.huang@linux.alibaba.com, zokeefe@google.com
Subject: Re: [PATCH mm-unstable v19 05/14] mm/khugepaged: require
 collapse_huge_page to enter/exit with the lock dropped
Date: Fri, 05 Jun 2026 16:07:56 -0400
X-Mailer: MailMate (2.0r6290)
Message-ID: <F4C2A4F3-54E9-4150-8196-DD303E4D8C39@nvidia.com>
In-Reply-To: <20260605161422.213817-6-npache@redhat.com>
References: <20260605161422.213817-1-npache@redhat.com>
 <20260605161422.213817-6-npache@redhat.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0170.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::25) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|PH7PR12MB5998:EE_
X-MS-Office365-Filtering-Correlation-Id: be69971c-7a13-4097-4a8e-08dec33e28a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|22082099003|18002099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	mTktN32ilqW64KzrJQ/60dnvoe9EzbDKDn0yLtQyuL9g/Lc5NiTXwxu9dueiRkFjzfZO+mVidhox0kRbojP5Budh3k56wjJtmM3J/r8KJLz6DND+LftNK0Q5p5RVGjW6MUKdFaxMA/YOmhpB8rHsdfESHggevHwNnB6O/UXlDJKk8yvG97BRG5lOnHX5TXz5PH74crFmwvEXmGzYcH+japSmDjSGtyDnj70y4cpXqrQAxVpii7eAghWw6laef3BYPXvuWYWncVQfWyCAfprjyCOzfrMlTTuY/K6uekkC67rBI6egJET6rDN3KFuCV6IuG5dx8f8yDM5G2BpaanveFDe0ZER8F9dudt3vXqvuv9OU+3mausbYnjQUkp0uzs22m7e+ubVOtG8SSrcmYtHR+6Dk+VAilWHzyuLQp9yP/QZr+vCi1pLJ2hLBCQTjxaEsMNeHuC7s/67q7o8kwL/t2U75kufwHzz3jdoccpN4UslB6DC8w8HsyQX4HJO1GQ3sPNaMXO0VqTe6RZcdoFgUdju2Wu0vQhOgMKc2gdjBbRCM2hkRiR4hqG/o2UpuqKav5pauD+kKZONU0CIeDBb4NSf8bIfrOyLhMU1JCDG2Y10QuwPjZvHegru+IG6Bhxt4kHpJ25sVjqLloev630FZKBISB28zymnBmCCxn0kLxClw8A1EdTTLbUPD3a3FWHBB
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bjpkw2Vb3KXhRKdF+DXuCXIVLFVbE/WBuTryVV9gAfFp0jCfIoZ0D5VZItlQ?=
 =?us-ascii?Q?Hosgrq0KbLfIntvobPRh9YKwYoYvBQOisDPaH03uW0pn2gpdrJowPwMHNNu5?=
 =?us-ascii?Q?YrpDH54Dfifc5f067aiyPKU6GSJNuVf8Ud8FlSMonBodr+EoQ2pPgknbAlus?=
 =?us-ascii?Q?tMKofB7djVa8MP3IExmV/CY4bi+puLLdhABVgsnLa3bJaFIInb74tgMJpxt6?=
 =?us-ascii?Q?lql9t57bwfoQD7e9zGNy1a51f+cGkc8yB7XTqP8VLY5otp0D6XY4gl/kacCv?=
 =?us-ascii?Q?xuBXQIs3r7+q789b4wrEDxJ1jriKly94igw5H1PSDaqsLStkpDjrpkg4sXZt?=
 =?us-ascii?Q?nhPo9HxgJp2RISW6LCfuskxJ44FlUlXtDmFccs+4jXIpy9mc2kqdFX0I3Ld5?=
 =?us-ascii?Q?rCkGs9ZWclEoQiF9zpTd70pIj8UYTFAYfLuLkrzn0nMCTi5jGj4jeOZJSyFk?=
 =?us-ascii?Q?Zru15PBwOzxJmke4Ni0eEq/O04AdWzyRR+VH2AC0ZZ4syO+60QBbAzShChHq?=
 =?us-ascii?Q?FI8p6Pwxfbd3bB8BphfegeXu5pZbui4bTZp644NvQICEkyOHdta3UksuYaN6?=
 =?us-ascii?Q?64D9N8JKbJyRFQnOBCxeX/ip9MLrzw/bpuT2bkJExzFzpCJb3vY4nCdcPLtB?=
 =?us-ascii?Q?uGWBm3p7fqCbS/+iu8Kje1WgolOiYrvr+jYywHesR5n0ofdDDz0lFBTmb8BA?=
 =?us-ascii?Q?GjmXW52jSuZjqlTEk3U5plH4LxxyXUFBo/jXB0MjffzLZFjf3HOQK/UdOR13?=
 =?us-ascii?Q?5UMRus0/4sA+9ynwx1NVMwMEnBXoNPxVO3Cfns9Dk7ZdCZ+G6MBIneNM+a8N?=
 =?us-ascii?Q?/SpLKySCvvF/0AK1l3b06m6DVop0GRCzCXUPUjKyC4UdvC3DMA7dwbAkHmqa?=
 =?us-ascii?Q?IV5QrlWm6E3M/E4p374Dci9PbK+3eiXyumx6fVdWiypFhjzVq44kU6poplhV?=
 =?us-ascii?Q?uds+B9IMKtS3lnPdEMxKSsHG6oZ8VnIhXO2IvTpwiQ8BHvTdeFqY/uVr3Rgq?=
 =?us-ascii?Q?ksRvLfjuDBdggtrJu17JNfZWiLkz/QzRasqa/f+4TKdso37R/AaV36WuZ0Nr?=
 =?us-ascii?Q?q5iP6OBpiqto2HAm0yByHgTH80wwlxBM6w8wSGxuXIRTGA4uXamypIV45l13?=
 =?us-ascii?Q?cz8GSjRkxYSkqo+FL6IBX8X0aGbQHFm9MoSHXiPnNK3hijpMw/7oZRJM98AQ?=
 =?us-ascii?Q?rGGlLeFcsur+89EbjGrSSDIN7qbsluQcDE+C0rHOe92re+J4tMPPwNcL5SNl?=
 =?us-ascii?Q?zDLuF7phSRfyy+mM9OlmN7xX92ko4ksH1WxJkV0CgmT+H+gBVtGDnlD2nAHF?=
 =?us-ascii?Q?RVk4l+hPVGugpEZFH9E3/8Pu1x3IWVYPPO78Pp0jlseHj86aMOd9GiWJkhff?=
 =?us-ascii?Q?048Ij20UhU01OwwK5OOo4ItacLvRXQDje6QxU2YimIOUjeR6t1l2Qv7efvR7?=
 =?us-ascii?Q?r/edPNgjMVoR3yXNiv48bH7iOBxeSwghdzmQNTM3cBbmmB9a9oZewia1hIU0?=
 =?us-ascii?Q?5OZJDDy9HeBStnp2G0ABmpvRPRrhGrMfzYx6O3MxMCKRM36wVIXhX8O0tMIT?=
 =?us-ascii?Q?tT5vg2yaP3G96/j53PCq2e/eZt1dTSa6MsZCiY8z0HU3jb/5VM31vWoEVglV?=
 =?us-ascii?Q?ma/emjkhXX1vhk7Wij3gOHhyR26FdxIr3RejjGLTO8zhpfGlaDf6NkTg+k6r?=
 =?us-ascii?Q?VDa+tce+7Q9DQWH3is9PRX1SiKOJiztlsJ8WXp8ot3kuKzT+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be69971c-7a13-4097-4a8e-08dec33e28a2
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 20:08:07.1398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tRYU/jAQx1K1T6rbsCJ69mTaLzizCgn2QOA6bPsyn7t1ntBNvO5bjkTtFcs4HUHg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5998

On 5 Jun 2026, at 12:14, Nico Pache wrote:

> Currently the collapse_huge_page function requires the mmap_read_lock to
> enter with it held, and exit with it dropped. This function moves the
> unlock into its parent caller, and changes this semantic to requiring it
> to enter/exit with it always unlocked.
>
> In future patches, we need this expectation, as for in mTHP collapse, we
> may have already dropped the lock, and do not want to conditionally
> check for this by passing through the lock_dropped variable.
>
> No functional change is expected as one of the first things the
> collapse_huge_page function does is drop this lock before allocating the
> hugepage.
>
> Reviewed-by: Lorenzo Stoakes <ljs@kernel.org>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> Signed-off-by: Nico Pache <npache@redhat.com>
> ---
>  mm/khugepaged.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
LGTM.

Reviewed-by: Zi Yan <ziy@nvidia.com>

Best Regards,
Yan, Zi
