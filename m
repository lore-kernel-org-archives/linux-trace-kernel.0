Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012055.outbound.protection.outlook.com [40.107.209.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784423271FD;
	Fri,  5 Jun 2026 16:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780675518; cv=fail; b=I6bFOoGpNZBZRhHqxivHd/dv0nvDlM0Up2LnDK/OiAQP3wNO9h8VyqsSTnhm2rAxNx5nsHRlhPZyEXvmr+ZNKRKX8FrHKMC1Y4y53GrPOzIQcPC6xa9cduREVb7Z0G7N9XNFKTttxLW7PaixTx82K9moxGuqZd8JBweUNohYU14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780675518; c=relaxed/simple;
	bh=U+eAevlYKQ5YduqCf+Bz/DElrCnwr9Yis2197eD1j/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aNnMUzzZ6UlHUSHU7+hyo2rrgQRwMFLNoCh/8ywpxAY01CkItNO8aAQoskzgrCAVrrTqUe8Upe3DoJPatvptc9LGX2px56tdy0/2QbuQzBL2K5Y4lDTSsiUdNMZwlwUDRWAOB7Tg5uypWX1WH8ABZlSastKuZKjTeW1iPTSQB6s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MsPR1Bzx; arc=fail smtp.client-ip=40.107.209.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MsPR1Bzx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TP0QIAsEvT85DVZrZjYEPynRwjEYJT0FLphD1QSWnXha3PQ+dJf10mGHvuFtr+YLabgNMhIAEJXwqzrIsjLJsGhpemdprYaCN2k2nsPxB5xMyrwHoxdQqs8ILIHPV17XJg+9rce0xyGs5dybu1QKOmd+W0di+wUtR4ugwXF42eT/8HpvqF4I7EBgkEX5IOnQ1kNEZ8sGaAh1s6d4mxBFPxX14+ISt/0neqJj7mLw5dkzfC8ILu0JwC/bmvqrEk05+XbhgTOpkb9lJCMd7KBbONTf3SLoBQBSz35cAYwo91CoxKWN62wINGUGzX9Z2sy/WJLo+PffWUDvNR8nL2EJFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X0ljNOWJmuIFJa//vLl2Uii9okpP/nLim7UzXrn9yeE=;
 b=owbbvKEljIMej3IDY06jVWzt4CyoxUHsrX7Nzd/f0CfAXDD+eDGPjp/ee4bbvUC0QbENj1wnsuqUtyjyIV1EpuYVCEblLyzVvIGcG/o0MZN5AlMQ2TffPUXAKFqre62eS5iYIwdaaBfwPv+DDQuSsX0CpL4WR5nx0XodPdfCI+U5lQ9sxELAgxpy4+ZIaxdgSOk3eUH1mERygwUBFUFRFpEvcmV+3dmrbnwnVtcl00MwXzAFQ9qaQlMxCnFHs1VvpzRoayfukRsNzQeDM0B/5F11g8IxRNtqomeAAgaD9qhmtZwIwGSCz3clCJSBugNA/m8WnbuOYcWus3mRI517XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X0ljNOWJmuIFJa//vLl2Uii9okpP/nLim7UzXrn9yeE=;
 b=MsPR1BzxSU5r3EMKoyLibC77c2r1j8YyS7RafLjdcA4VaAuoB+7Cnsvr/2t3E8zzj6hhnf/nNUFvVrJrFALHMHdNIWhNQcWan/KylCoG1WVfMhIg2LolSS6zFPv+Vw9UIU564IEj2rPwgV9l29RxS+IG6EQlJ9Z3VWFfiteQNxfMwF4eN2pcj4RucJ8BgMSLVl01tO/l2mAwEOnpX4y0R31749zgyZJE4dxZ6WdvRXsPAZNcc8EduYOBHl63Oszgv9cNgyITd0aR9ZyMr2gMVsWJlB/LG3mbXSOVNast7QWGiN5149R6HdNhJ1T88E6Fh+Y5yiCBtRRR10jwC1ndog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CH2PR12MB4085.namprd12.prod.outlook.com (2603:10b6:610:79::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.17; Fri, 5 Jun 2026 16:04:58 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2%5]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 16:04:58 +0000
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
 ying.huang@linux.alibaba.com, zokeefe@google.com,
 Usama Arif <usama.arif@linux.dev>
Subject: Re: [PATCH mm-unstable v18 03/14] mm/khugepaged: rework max_ptes_*
 handling with helper functions
Date: Fri, 05 Jun 2026 12:04:53 -0400
X-Mailer: MailMate (2.0r6290)
Message-ID: <62E1363B-ED9C-4CFB-AB5E-CD7B1D1EF3C3@nvidia.com>
In-Reply-To: <20260522150009.121603-4-npache@redhat.com>
References: <20260522150009.121603-1-npache@redhat.com>
 <20260522150009.121603-4-npache@redhat.com>
Content-Type: text/plain
X-ClientProxiedBy: MN2PR20CA0045.namprd20.prod.outlook.com
 (2603:10b6:208:235::14) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CH2PR12MB4085:EE_
X-MS-Office365-Filtering-Correlation-Id: b9ebe9da-549c-4bf8-9d2d-08dec31c312c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|22082099003|18002099003|6133799003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	2Q/oMjzoU8jL+MMBnOsc5smPPVDUXzOZaTHbix4gAaItzK8b2i0F+66fDPrognR7h/0MwCZlO62iqiLWVH0dIHXR/4DpYOaBunrbfwEO79d1Ht/4s8qc2MehmbTchYs/zw2n8uCSwtPE3SbWOXeo7vO4UWufDPDBjGUVgqoqLZMy5CFsEq0nR+wT5dhP3Xz/Fpdy/YywX/pOCvGstM2bUkLufiLovFlM7ErrkQvedYxIAsSg9fUlfGWS1br1vegYjb2SrjOHFibDZcm8USo3ftaUZEYAgWkx3qgtkl8U1dn3DIRCVbttDz5vYkppB5ZPARJS2ba4ax+V79ERU4yvJIy1KUGCDO574Y6aJkiP/QdNxmzP67Jl3pTDv4c+fKccIPccvoVLqYkIJtWryg+POUqRKeb/LjSuV1XV88IYXkvTFD2CLCQeAWqHIIq6TLAxlhmnF7UYBaViogfSU9xEZwXnTCDJCRaVd+fxGjrmzoUCc5CTdRsshynjYHIAdFXvRLWW02RmfTl6Uy6eNVP7E5GMFj1ZITtgXtub+Z6+3w0L+lIw64at3XaqTa9FpJHfyBv8kWszjHc9VXoojDVeZ9JqgA1L6NYfMCbpYX3H8J0LO9jSpJmJ30Anw/LQBD1QlKoQEssdaBy56x3UHSiDpZBoVB3JQOX1l1/fTMN/F02Zp7cLIx+GveaBwyChCQFZ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(22082099003)(18002099003)(6133799003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?J6GPxZrLZB/si2C0XXw0NvEsg0MCidp2w1XapKMXO0XnIRXFrU+9drYiWxnt?=
 =?us-ascii?Q?CNBMtYeNKZ7aNIC3EbzCs0YhzRVTaTUCvzFziga5jOlw1QpJQod4xbfvnoDW?=
 =?us-ascii?Q?0cyoSoBn7WwVooPY6/It1FfX6bNYvGIb1uFlxbxul50uv49HYdFsPKLw85D3?=
 =?us-ascii?Q?1nUS/qNtQlnzNsmEoaYLTieSisxB9PghD7oaCLaOCiQniUlh/m7zjsI3iYPl?=
 =?us-ascii?Q?6idq8Qfs/UYXk1/cQClxj6BrutF4m8Xq0bfRNnjDJBMbbb1gt9VJOD2IVbcy?=
 =?us-ascii?Q?0oe5nUdAMUqzFSPY/IsVYnxNMj7Rx/+tucwOdML0Sve428H6DN4FsYitO5BR?=
 =?us-ascii?Q?e0d5AomMxZSdDZZ9DbZwLiXGGsOLY2JY3kUjZKKz9GdXlrl4Qj1McPJJDakO?=
 =?us-ascii?Q?l6CBkM8De13LGxzZs87Gff8chwL15SXRSFyZ99/8Y/l+1QMClQpFLdNkIdek?=
 =?us-ascii?Q?Swh2IHuMb7xBQfRCrwoLhqpt7tF+2yyo5ty7i/jKIO8g0YgDgqU2KKwyQdRI?=
 =?us-ascii?Q?TjBE3ygDlDrlVsUPdrPpjufQy0OJhz/5w02eZ5VwUhgBRNimZYPArIs6qoIG?=
 =?us-ascii?Q?SP+9HCH9xJZX9NRcj60107FIVyFcgbj1XaWDGS7YHhjkZ56SuMab3/TUI78A?=
 =?us-ascii?Q?gEzVrajAppR533mmfB2c3HEx4buTdhhWYn4yzHrw7/FbqkCcDYiumLgqT9J4?=
 =?us-ascii?Q?Kh1r0FwLkj36iaIguh6JU7pp/Jh1qTAvJGgHQ2ruJSo38cG+8F29PSplkqUS?=
 =?us-ascii?Q?CQF1jc0MbkdxEGB8WZ2XWJt4/v3RzCXHWzzr5sx2ZFsOQm+2L8bp1Cg1tiDF?=
 =?us-ascii?Q?7UDhukPs6rNalNtBZD5GUX3tqf19YCmFBDKdqeRzQJ4NS5YQQhYAlOFe3E7R?=
 =?us-ascii?Q?EYF7s6X8FdJxQqdyMpqdibxwvdxCPKKx1l3rI3NDvSeUuQC3deHf3wc+oRx1?=
 =?us-ascii?Q?TCCw4YDafRua91gzVHOByqjTBKEFWINiwo2TSJSw8I5bLDMnswsO3CYbRkOu?=
 =?us-ascii?Q?rduok/lhrdZgKYUugotjU2IGqAR6h5KAe2l6+U5UAF5HZsryh1PaimUl+nA4?=
 =?us-ascii?Q?DPPhORq60BVtySv9e+3PZj3d9bzV2cmu4GVbLhURe8ywi8ucEHZ08asG2guY?=
 =?us-ascii?Q?ZxjOR0JgfN7XAO2huUQwh5pYhc6ruQXzc3P/OG6+NCtexewa8M0GWWVpIDEl?=
 =?us-ascii?Q?ELjGP5HmnGV042h6XXRPGOUS35NmYaZg8iagBNDVAb7CM6h9Jx7hcIVh8Hbt?=
 =?us-ascii?Q?w75m8RyIiJIJE/fuBzRySseLdauB9GCCA6x0aVxOSZhFzStx331wbdn+A73Y?=
 =?us-ascii?Q?tXxiT3gly0g7TiliCv1AGoZkjusMj+11UQJQ3s+nro8C2bsSQ6Y4iYuSFHma?=
 =?us-ascii?Q?zDgOmI9hsbiNW5kdQHbAI4zvc4Vw2+KxrcotFqKMyqE4qXzFjimTbRNfr0Gn?=
 =?us-ascii?Q?nPZcjKxuExNU4bxKi2rh2AV8tGKNywT13WTTaBiiHwCoWwKfV5PkkQKdGiUz?=
 =?us-ascii?Q?GvXt7E/zgtMqHB490nkwwQP61ElxX13+Odb8tGch+Jbt1Vob8wzv4BOXZAfw?=
 =?us-ascii?Q?nLxeUKQTMreV6qj6JB6guFJEVJxQiLlCEnc+PD7Lz9VmxC3R3GYlIRJOPZZB?=
 =?us-ascii?Q?Or7KxosjNsIUdmnAM8gGWRRUEg9vfmZ94eo73awAxaU4QUJOSLxmno7/WPot?=
 =?us-ascii?Q?ghrHpjJwX91XS/UJ07QdLw0ckjefTO4xc/OvMghAJYNKU/mV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9ebe9da-549c-4bf8-9d2d-08dec31c312c
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 16:04:58.6284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H6OYTTiYEWw06o3OhSW+WYPDEj5+Bi8TzHvW4kHOjwVBYV0J3WA9L+NTrZ8iMWGZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4085

On 22 May 2026, at 10:59, Nico Pache wrote:

> The following cleanup reworks all the max_ptes_* handling into helper
> functions. This increases the code readability and will later be used to
> implement the mTHP handling of these variables.
>
> With these changes we abstract all the madvise_collapse() special casing
> (do not respect the sysctls) away from the functions that utilize them.
> And will be used later in this series to cleanly restrict the mTHP
> collapse behavior.
>
> No functional change is intended; however, we are now only reading the
> sysfs variables once per scan, whereas before these variables were being
> read on each loop iteration.
>
> Reviewed-by: Lance Yang <lance.yang@linux.dev>
> Suggested-by: David Hildenbrand <david@kernel.org>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> Acked-by: Usama Arif <usama.arif@linux.dev>
> Signed-off-by: Nico Pache <npache@redhat.com>
> ---
>  mm/khugepaged.c | 120 +++++++++++++++++++++++++++++++++---------------
>  1 file changed, 84 insertions(+), 36 deletions(-)
>

userfaultfd_armed() and cc->is_khugepaged check results are now folded
into collapse_max_ptes_*() return values, using 0 and HPAGE_PMD_NR.
It simplifies the caller code. LGTM.

Reviewed-by: Zi Yan <ziy@nvidia.com>

Best Regards,
Yan, Zi
