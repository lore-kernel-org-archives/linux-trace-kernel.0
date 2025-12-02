Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012034.outbound.protection.outlook.com [52.101.43.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2962C23BD02;
	Tue,  2 Dec 2025 15:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764689792; cv=fail; b=HSfiBUQlupNhMdqnGuSxFyl4c6NM6Kn1SQr7RWuAHsBMpaZir7poLgecOWXSIc2NO665kJpIElt+hFnFeZ6b+sL5VHtGNluZHiNvJKi/Ba95ek3eo0+07p6PU+yl6hTf5nmBkhmoTjABCMHPE5NVT0tjM/LYNs22FJAFalAfYYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764689792; c=relaxed/simple;
	bh=EocDMvRJYYF3Y5xWWCmzs4VMFC2a2Jh3LMEyQC0CAtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ur+40dK6TvxShFokUV4w3QuuiUIRmFK6pwruTjbCham42U9+8bV8a51Stp8emCJnxsu+VluXZATJZtJbaukBIZUvhRmwjbdvKqpEMLlK3h15abflthv3et+TY0+8Np7/LZ7VGFFqY1k+4a8hoUHf68NQ1efLLi1tXYZrB4Drfho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KUA51FgQ; arc=fail smtp.client-ip=52.101.43.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KUA51FgQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V5ectRFxwJbXBJrnThTvgxaNTM1QMB22Kq6NzY+eVUdE9LIC5eNFupDmQaN2iTAm5A+QHxrIZ4Bb842fJYsv5gVIYaaglhIyKihOQxtI0Dqio9olZFUalCc6tPHsbh5C9Q4Vr+lBWVFaO4ZVL10zkZNPVUvMbbzF21Cfzhtt3VqyqTNDAVxJzflAR4YZR1sjGw1TVZcvkIXSowq+h95Hr1vdF3t2mopluFuI1paCSxfz9c3CxfG80VTinpMXqj20EO0PoO7oXDGUM5LibYW9NpP3DcIKuqRM/6MgsyDU9o6NKx6F3VUGOX8rI/ELkax6b9Wb6s6qeuy9DB2NLQwbxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fm7sssV20swgSvYAIBj+K3dI85K4eLmMHSbMsVjiZJc=;
 b=CKY59jB08bFYZAa8trO5bjqZ7PfJhnmzcSVkDtvUbvxfpqHY/8xqzhGjGJ5rpaj2c8YJaKZE6zlUgLCAa3LC1l/XMuuJJMgXf1mq73Yxao3h4082fBvgnXY9d8dznKTinNQrdRfQWMsb6CjyRwaSn1tVvVszpYENCaiIWtWdI9dawk+DBoCk31E6DjR8M72NjC6OtiNw3k5h9Qd+VdZV3C0trd/2eQ1VXRZla8Ww8ouWXik1iXSbZIT0KwHfUgcLzEJJoBkrs04A43xUeQK5mo2YHxEtmMBle0vRcsCZ9Y/OA44OofyvgoPfMASTjGquKZYM+fhmyXAG5DP6+IUvwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fm7sssV20swgSvYAIBj+K3dI85K4eLmMHSbMsVjiZJc=;
 b=KUA51FgQOuxH1ebc9kzgPm1ze5h0UIdNZLXs5gowryJbdaPfey0r0MNCtj4fZYIM974kyloaNs/kcBAa89SHblK+lpkS8yxCqY1Dfsd0Q97+9OVpO6GhtG8JFPHGTKTvE4cHiYuuINusrNODUfuhm6UKlaF03CyL4T+MT4ThhDIDAyJLzFqn/BULqyLYKs5IREQFFpPm8672LhB4F3fpXqEava1K9En0M13BomaW/DPv4VqZ3O1Fho4nedG3oH/HJhZTAeGs76XDTGL5BXd079O9QsO04J7CpIihzy67G4DSegCV/1q55hNpeMPdlDrxv+pIoFg3VB1XosKIQ/Em7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 MN0PR12MB5977.namprd12.prod.outlook.com (2603:10b6:208:37c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 15:36:26 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.9388.003; Tue, 2 Dec 2025
 15:36:26 +0000
From: Zi Yan <ziy@nvidia.com>
To: Nico Pache <npache@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-doc@vger.kernel.org, david@redhat.com,
 baolin.wang@linux.alibaba.com, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, ryan.roberts@arm.com, dev.jain@arm.com,
 corbet@lwn.net, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, akpm@linux-foundation.org, baohua@kernel.org,
 willy@infradead.org, peterx@redhat.com, wangkefeng.wang@huawei.com,
 usamaarif642@gmail.com, sunnanyong@huawei.com, vishal.moola@gmail.com,
 thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com,
 kas@kernel.org, aarcange@redhat.com, raquini@redhat.com,
 anshuman.khandual@arm.com, catalin.marinas@arm.com, tiwai@suse.de,
 will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org,
 jglisse@google.com, surenb@google.com, zokeefe@google.com,
 hannes@cmpxchg.org, rientjes@google.com, mhocko@suse.com,
 rdunlap@infradead.org, hughd@google.com, richard.weiyang@gmail.com,
 lance.yang@linux.dev, vbabka@suse.cz, rppt@kernel.org, jannh@google.com,
 pfalcato@suse.de
Subject: Re: [PATCH v13 mm-new 02/16] introduce collapse_single_pmd to unify
 khugepaged and madvise_collapse
Date: Tue, 02 Dec 2025 10:36:22 -0500
X-Mailer: MailMate (2.0r6290)
Message-ID: <1B958142-28E9-4910-B870-490826089023@nvidia.com>
In-Reply-To: <20251201174627.23295-3-npache@redhat.com>
References: <20251201174627.23295-1-npache@redhat.com>
 <20251201174627.23295-3-npache@redhat.com>
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0250.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::15) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|MN0PR12MB5977:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a53c0a4-b1fe-448e-8e97-08de31b88e75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tMgf1IU1XrIR9CpsPND7DL1aMFJKRFn6+/dcvYsAjbQbLYx39ZKewbON4IHP?=
 =?us-ascii?Q?7dIzqf3NY8NUY0eSKtZ1tvr0lK3yAn6kahIrYgG64Gcqa5r29/jzdg3/IVpT?=
 =?us-ascii?Q?kaDKVlLhseM1S1bUcBTY+nrp0gxruDO6XYiYoXaBSowk+tznh9bqUGJ/wEAW?=
 =?us-ascii?Q?F2zabUkJwIpcRiu2weBB0y3t5vGguRRVZt96XW+shmSGGCj8TirG3oEjla5G?=
 =?us-ascii?Q?+hV8fffb5E2kHMwJvPOLBE2Afo1YrSpLn0nAWh+9vcta6aW8wc5eeaHpILZI?=
 =?us-ascii?Q?w4qImAI9HhSe0KfnifxpY6zDqi0jCLiAFUKTfOHsTtBKaJFOBC5VU3s4clCM?=
 =?us-ascii?Q?mmAqL2QC2dpRXwfFTdqDqETBXawGy5m+SIu00qa4bPPfT8KTyiVidMa74mpj?=
 =?us-ascii?Q?GcTYNreU4bPbHnkO+57u3T6i/1wIolL20GN3m+0yxV6MKH4n5BSlExgCrQQ+?=
 =?us-ascii?Q?UXJkGJs2zst4lLBcfl5qUH69Xom1d9rGpgd9AadAEjUP+CQCixZln7niQu1V?=
 =?us-ascii?Q?voIEE0Ik5R5zLE9p/s1a3Ycf2RKa78yeoL7xi+UXWDwB/z1rlShF0zLxMCeE?=
 =?us-ascii?Q?9eEXls4A1zJ/xlAjdtHytbapZuviAT01cVH2owtf7cVzi+iLGX2G/HBpTvtk?=
 =?us-ascii?Q?6NyU7SJberuykTOsl0BYxyivzNchoNH8U6ew8vK9sL/BQWalN1BxVfc7mJ78?=
 =?us-ascii?Q?rZsyLWN63lXlymvaBNU7pDt9xuSLgug7aUSnRe2+kMb77fwQDPcBEFWCdek6?=
 =?us-ascii?Q?xUJjpk/sd3CvaYHYqV9m0Rtz3dhQcQfBuCfAEZQYjUDnNSUt7olgddmoImDs?=
 =?us-ascii?Q?AXDzCcx4+20cKsJz3ifSQvvC2P3iM/XxgMuePRPe5hIuPfdFpn8WR5+jAic/?=
 =?us-ascii?Q?YATlCp/mMtXa/0pbmVt4AUJfNRzKFTns2d5VVOoi/RmBI57AH6+Z7iHo2t1O?=
 =?us-ascii?Q?4cMhN1JWzeRFeS/avBf7P2GyCsHu+oY2AswSI8HZnFln1b5/YniOwQdFBytO?=
 =?us-ascii?Q?aT8aRUO8d7nSVRqSa9Owxm1aSdQfc06X1+qlGAu40/X/FO4QGlbA5qVCfkqB?=
 =?us-ascii?Q?URE6+mlhSD+INdXdOGQimS/EKr5TAHTf7j38DSyF+Lmbn7+xCoS3rAu6UC4H?=
 =?us-ascii?Q?G8zwcrmJsLQ2cxzmu+QcTV1orFn+QzMIldci/OShAVZprufWXrDMf7u2VXrm?=
 =?us-ascii?Q?aPM6kVVX4E7zhvVP0gr6hkmt5Sy3D+YN8rwrksrZ9pdvNSsw2ZPw0eLPhQp9?=
 =?us-ascii?Q?2583muXqYnD6PbLTNHFN4oWalnnS6knI2D5m5uUYboVq2cvhdCohWMTuU98t?=
 =?us-ascii?Q?Ye1ih45CFcsOyTMhqZSkmH1SvZYGz5IxL1bCyFsh+KjioDQyC0OL9NSUieLD?=
 =?us-ascii?Q?8TfVqmLdJOHQIkCv7qsvIVD1MMuJr0lti6KKxXn+CdKAGxDlHmnnljEqQ/mg?=
 =?us-ascii?Q?0IklWWRizAPC+vRg61Kg3mKRQ/sErgQq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oHMGP4F12sDZVqbT0l6hLnUNa3HdRZMqHUzVqfSaOWJSj+0f0OssYsHMaP7K?=
 =?us-ascii?Q?fb9SCEds/NLrIbTGeqTMsCaS0CY2mCwyWtK8EL18u40oAc5JROdiN8a7ZKE+?=
 =?us-ascii?Q?tT2ltieGFWi3Fk07Fb0Xk/2tHef2smGgIzh1b1KPy+ox0LySniwsebCSRDxV?=
 =?us-ascii?Q?adw9sXIgr9cTUgCCM4v8uOcCOR0eCbXfEqRV3zgOYuvelQcOxdVTTF7jdEKy?=
 =?us-ascii?Q?MOPKaniu3tweXNS1Q0m34LUSHIPikyhVV1mIQwcVNIjsQSYujx6owdEFV60g?=
 =?us-ascii?Q?2R3gdBk/dPmoqYA4PlIr6vITl6AAMtyczMkJipbb+1HQUEMbHGhKVTnVqCBz?=
 =?us-ascii?Q?Pc87rOocoDBsB00xBgB7c1c3zJ9X0uEF+yHk6xorkHP4hLvswuGEEBboAiwu?=
 =?us-ascii?Q?UTicGCAWCLpbTwGriUUi5Dyc3RSv2qHj2UuWvTlyG8g29kT3HTlNf7VRn+57?=
 =?us-ascii?Q?o5Df6A918XGTFaepT6G9GlZFknlbBkyaqpfhfhqcO8Z5UvrA4Yc6hrUlh0ki?=
 =?us-ascii?Q?JSDvm/pP9Epr9rSeTvr/FNdFGCIoKOiV87hGbtqx3vkpK43VFlcWNP6RqmaV?=
 =?us-ascii?Q?96gw72k+ECSKZHFCD4gKM/TSKhtjrihN0clJ1BW7ueMyQKJqUtg8KgUSODlY?=
 =?us-ascii?Q?CwReffQZ9/CTraXtmmWI1dqgL07uwbkGOkuXKfEUuo2Il+vprw6QK+p5CFBn?=
 =?us-ascii?Q?TZ2MXo3ViSOrtmJr72T4V0Nz+QpIjSLnrnpckJbhOn8EWkkXTyUOBSfgfsnQ?=
 =?us-ascii?Q?hSFlkaotl2nGqmxVOFyo2eQ5HyCfHUPaVVtfzLS79hpno9KH5+Sp7VY2ykm0?=
 =?us-ascii?Q?G/AiyaaFspkWe0iYcfauITnuoTmweaXI3KQjKPyWLsFqJ8rdghU+7T2EfvpK?=
 =?us-ascii?Q?7MGU1kiheFQKiwDdJWkm2fN5opR5FNBdj6y/0wtU2CpczTl5WQt0/D0iaEpz?=
 =?us-ascii?Q?Ewwc6Lzz6h8ES08ZMeBHqHZU8XmtMbRSNTG5CyLC13Rv8lhVdIYQhHsLbCaC?=
 =?us-ascii?Q?fL4i2BNt7qB4y/fAkbsy+DaFn7AW9yP/1Xt9vp1flJMyEwhaWfvid2tVtDTv?=
 =?us-ascii?Q?8pBEKuwoCrUMDAAyAGQzDQWkT5NooQEkctwqTm1WqJIabxPo4opeCmY3f8fA?=
 =?us-ascii?Q?qK7fxiI/YZUu6ZhkGzJ2uZUw6AdjXmyEzeioFwe5Q6uOJ/TwKnxD5OriCeAa?=
 =?us-ascii?Q?Y22ZkM9n0mGxs5HvGNzpU3HhBjwtaHXev2H8WFNEbHN5ibSDlCKo4do+QcVd?=
 =?us-ascii?Q?m7ibg+I9iQNTFMmBLpndDr52lqLRwh4TmOm6B2Dg4qXbGEGDLB7B6ifcfxQh?=
 =?us-ascii?Q?aQkCf41QIlS9GBOTO8+qD5U5gNgxIw8sSTjt/U4pzl7jyb1tSFWmdPOGHDH2?=
 =?us-ascii?Q?o9IyI1ITOORC2V6oMWAAmfQug+kjoINpyC5/t9tZ15GPK/VFjueYoMOhceOd?=
 =?us-ascii?Q?bR3iEsbRYHLomBaTOaoY2HaubG0rKeSQvMQtNBmegrs1bTUGaTTsXECoePIo?=
 =?us-ascii?Q?2BIyG52f8OLP1h188FhDreDOOC4/1hiEUbAkJwhy+4cyoQ6s7Dsaa3HOwyV+?=
 =?us-ascii?Q?rxCe+y+a628NSMSQKTBsBlapnlYCpk4aFpL3O+6G?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a53c0a4-b1fe-448e-8e97-08de31b88e75
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 15:36:26.8208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h03y7V628v8t50hFruKhUyCRv+eGId2urujdc//OT/PKadhD1QUkr+QzQdRSDRDo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5977

On 1 Dec 2025, at 12:46, Nico Pache wrote:

> The khugepaged daemon and madvise_collapse have two different
> implementations that do almost the same thing.
>
> Create collapse_single_pmd to increase code reuse and create an entry
> point to these two users.
>
> Refactor madvise_collapse and collapse_scan_mm_slot to use the new
> collapse_single_pmd function. This introduces a minor behavioral change
> that is most likely an undiscovered bug. The current implementation of
> khugepaged tests collapse_test_exit_or_disable before calling
> collapse_pte_mapped_thp, but we weren't doing it in the madvise_collapse
> case. By unifying these two callers madvise_collapse now also performs
> this check. We also modify the return value to be SCAN_ANY_PROCESS which
> properly indicates that this process is no longer valid to operate on.
>
> We also guard the khugepaged_pages_collapsed variable to ensure its only
> incremented for khugepaged.
>
> Reviewed-by: Wei Yang <richard.weiyang@gmail.com>
> Reviewed-by: Lance Yang <lance.yang@linux.dev>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Nico Pache <npache@redhat.com>
> ---
>  mm/khugepaged.c | 97 ++++++++++++++++++++++++++-----------------------
>  1 file changed, 52 insertions(+), 45 deletions(-)
>
LGTM. Reviewed-by: Zi Yan <ziy@nvidia.com>

Best Regards,
Yan, Zi
