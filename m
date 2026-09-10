Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010046.outbound.protection.outlook.com [52.101.56.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BE037BE7B;
	Thu, 10 Sep 2026 02:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789006104; cv=fail; b=TjywDEAeKOL+1nQCYqEigKlmByXlZ7/askFH29n6+598UFctIc8nx4cm5lAIHWVVSQqC5hPxTBvfX660KvF4w/kagCoJuqtDBand5Cn2u7CkuiT8zubfdOwE2cXJGRbp9uXszKr1+wHESsLHAMj3bBQ1PIdPYKDd7t42COg6Wpk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789006104; c=relaxed/simple;
	bh=ijN5IVOhvhGjnyTKg1+YkfTMX+Zodxws33m4zOSvf6c=;
	h=Content-Type:Date:Message-Id:Cc:To:From:Subject:References:
	 In-Reply-To:MIME-Version; b=T26bK/24Owmaep4qszbrczzcUNFaEDXh0IJubbjy3aYDJYqaNLqHKfq2EC1LfcFqSg8okH2Duw0lijmuJmiYpGeJqb1fOR0f9jHct6ldi5xyMunYkFPGL9tLoxTXXhEFdfZIDF7mbT2ll2rutwJbLPtSVY6v86pw5nwLlygsVwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eYnHLI41; arc=fail smtp.client-ip=52.101.56.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eYnHLI41"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B8sbgCyuMWEzWCmR7y9zykxAwFqdHSpjmaWGHi/ThfzRGib0+xddrrE0VwWTwqCQy648TiWrfWUYlyn4MwN0Nrs6KPNAzhrOAKc/Oz3td56RMYo0H6ruPft8tKc5sZx3dTDQ1qH+5Mq/rVJD4Sj0gDBGhyIPuBJdsKRtUfm38X+FjmAEtrJ5GDLYKrwayfww82qT5AIkz3Bm/mXU10mt5oI7HW+NWU3EthLokdL+ffab437ePVNv7sH540EXRb8ft58UIhYsWQWJLG57jnSPDy9Rsmy3P/u1mFP0NdPAVEnfXlfSax80p2vfoqOy2Rp9CVSKvJy+2D6xYUS+b7wdFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b405lqWAdBRkjf4wHTRGozTF8Oyzpj36aRbXjLlaZCA=;
 b=RqyZj5vKzkmTyrcWz1i/LxxYjiNCZ1vCAxMt1Ox87KwMYSX2HQqvsCAaocfTwVXIFZCnzdSW13jfNZk3GfltWs31eSp9EecQfencMK7HTQigRUeqHW5JNft/r8eQbxIJl1zUHgLFoQ6desvjUMSVa0QEROzQE0O96SRX10xHtCOjiSiESUZo2IKYLogYeVoNxblwdzt8xHDxXP/f46vHK9sdqNC1WjdkfV2pZD9yXWg39elVSxVnzaGBrPEEbKJvzbBu2wzVC4ZqMNv8fZTswuBlbcgRc6SWQNjQp0wnxXBOG12VyPlw3PM5mSawwVAruR3WNafoZGLDrr6RhALTew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b405lqWAdBRkjf4wHTRGozTF8Oyzpj36aRbXjLlaZCA=;
 b=eYnHLI41A//Uil+Dfu2QAvm54jmAPNBXEhC/XECCbiZq9pICkvP4S4ibxSlTnoKn7XzHk5ULPkg3SLk60sAlPspY3shSoIxFTYg20J2KIvqEvC+n+8ql/0ihmGlZie5lk6y3x9qnDzgtb1xAMMcq3QmOaBdR2e4zuE0rsp1lk1cPgAGzAcc376Ih+L4sVTLH00/oxAFSPAXi4dyW8Owo3mRgBFCv0yD5Dv7+EUIOKPV28K9dIi85POh7iv+YgCE+LgVPQ+8WrBqhOZXKVn3y5ongWzYpvDIs9yMP18XXXhbH684KBZIU/f2PM1Cx2JshQmsLFwZZNIrSHEkXetlTCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by CH2PR12MB4183.namprd12.prod.outlook.com (2603:10b6:610:7a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Thu, 10 Sep
 2026 02:08:10 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%5]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 02:08:10 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 09 Sep 2026 22:08:08 -0400
Message-Id: <DLB9QBBHE5HE.3832WPIZAFS7H@nvidia.com>
Cc: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, "Steven Rostedt"
 <rostedt@goodmis.org>, "Masami Hiramatsu" <mhiramat@kernel.org>, "Jan Kara"
 <jack@suse.cz>, "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>,
 "Matthew Brost" <matthew.brost@intel.com>, "Joshua Hahn"
 <joshua.hahnjy@gmail.com>, "Rakie Kim" <rakie.kim@sk.com>, "Byungchul Park"
 <byungchul@sk.com>, "Axel Rasmussen" <axelrasmussen@google.com>, "Yuanchu
 Xie" <yuanchu@google.com>, "Wei Xu" <weixugc@google.com>,
 <linux-fsdevel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>, "Matthew Wilcox (Oracle)"
 <willy@infradead.org>, "Andrew Morton" <akpm@linux-foundation.org>, "Muchun
 Song" <muchun.song@linux.dev>, "Lorenzo Stoakes" <ljs@kernel.org>, "Liam R.
 Howlett" <liam@infradead.org>, "Vlastimil Babka" <vbabka@kernel.org>, "Mike
 Rapoport" <rppt@kernel.org>, "Suren Baghdasaryan" <surenb@google.com>,
 "Michal Hocko" <mhocko@suse.com>, "Baolin Wang"
 <baolin.wang@linux.alibaba.com>, "Nico Pache" <nico.pache@linux.dev>, "Ryan
 Roberts" <ryan.roberts@arm.com>, "Dev Jain" <dev.jain@arm.com>, "Barry
 Song" <baohua@kernel.org>, "Lance Yang" <lance.yang@linux.dev>, "Usama
 Arif" <usama.arif@linux.dev>, "Gregory Price" <gourry@gourry.net>, "Ying
 Huang" <ying.huang@linux.alibaba.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Johannes Weiner" <hannes@cmpxchg.org>, "Qi Zheng"
 <qi.zheng@linux.dev>, "Shakeel Butt" <shakeel.butt@linux.dev>, "Kairui
 Song" <kasong@tencent.com>
From: "Zi Yan" <ziy@nvidia.com>
Subject: Re: [PATCH v3 09/14] mm/page-flags: check page/folio->private
 instead of PG_private
X-Mailer: aerc 0.22.0
References: <20260907-remove-pg_private-v3-0-6ae22f9d9272@nvidia.com>
 <20260907-remove-pg_private-v3-9-6ae22f9d9272@nvidia.com>
 <9395aac2-af01-42cf-92ea-4e3d5e7eec6d@kernel.org>
In-Reply-To: <9395aac2-af01-42cf-92ea-4e3d5e7eec6d@kernel.org>
X-ClientProxiedBy: BLAPR03CA0132.namprd03.prod.outlook.com
 (2603:10b6:208:32e::17) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|CH2PR12MB4183:EE_
X-MS-Office365-Filtering-Correlation-Id: 3267ba2c-f236-4d73-c881-08df0ee05cc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|10067099003|56012099006|4143699003|11063799006|22082099003|6133799003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	ZxLcAgVsRbDliAYW76wAJqytV/wTP2VbPwfOlFq12XSkvDBe0IjbRDx8xmSg3SKcri9tI9DUCfHWARtCaIrAF5xOG52usuKzAec8wDQQNHL6poRLF0QFZItbtqYMvruLgUAVYOicWyGQPStYB+q2WqeJLa9KvBcAE1CKatUqRG7QVh5w31wDUK5QeMEYGB+7hMvP7shDMGHaesTN+LRkY3f4reCPp4LlmOkPxwbVmko+RqSFw8+J2y4AmzDm/f1CeQyqBOxQ1C4wyY7LQoU1zWVApvMCYP8s+Z9Qvgd/gdS2ImYj+ygiyeWGedp4NOck4w3ECRSAV3Eby48u3YC72bxn24H/Zsq5oN4SCwDa7zeIR5INVlx55kPiTryiDKVYY5AsTCOi2j1PrOh10pm26LW5Zc2TO1lojQt61cFtgWydhoUEMIlLm58fRqkNWySl3ieNFvesaI5tvbk4MyNvMzDbFBQy07uK+sm8lJ3+TH588ocpKm0CYxPQZyE2El8SIydrVrln+tHBeDyvPMjyagCtQOvHjfGEMhx3YKAVtzKwKSWuM+CWL8w5ogyptS2kO+Qyzk2YqRtfVJOVJtKUOvOa6cuMXH7lQBpqUmQTLZ0gI4Sc+d3aHC1W/zG5UhlRNNumVPOsOaWBal2GF3RuBe85CI2hdAjCx1Bzj0OPSQ0rXviY/4i0iqldP7qWLwG0jmFEc3PtC1u/bF5+yW61yA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(10067099003)(56012099006)(4143699003)(11063799006)(22082099003)(6133799003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b0RMVTY4Nk81MHdCVmg3TlNnU0trS3Fwb0k3OGhCQTBYeVpyaHMzWnhHMFVO?=
 =?utf-8?B?eThpeDUyNWpnZjIvN1kvRklZSE5Fb29YajliVXlNNHd3Nmk0Mjc3S1BCQWVW?=
 =?utf-8?B?SzRCdFM5bUYwM1NRUjQvUXZ0Q240NHo2TnZUM2t1QllHZE1seHZ2TjU2ZkpX?=
 =?utf-8?B?YS95Uit4RDdLYThPUmwveU9nS2VUVGhXT3dKZitYeEhyaTlINWlnUkRHYUl4?=
 =?utf-8?B?THhMVDJNZUswenlBVlNadlpYakl4K0RWd09wQWdia2JNVUhyNUM1R2x4bXVH?=
 =?utf-8?B?MDJpZk5LbDZFVHc2aFB2eEVXbXpLKzkvZmZEdFlPUDRvNXlmb1JiVDFSWkFQ?=
 =?utf-8?B?N2cyazBteTJ5MTI5VFJpNmNnYlQ3TSsvVllZU0lPS3NheEVRaDZpZGowYk12?=
 =?utf-8?B?RExrQlNpdVVadnQ1OWdZL295Q1RaempobEtZK3FvYnBzN2VTRmR4ai9VU3pF?=
 =?utf-8?B?a2Yva01yUlkyeFhCckZDQnNrbXByaVRDR3QxOTNzTk9QU1o5SEY3RnE0cWFM?=
 =?utf-8?B?MDFNWmQycnhZaUo3UlE3VkhzMWhZUDBWZUpWYTJBZXFrMW84VjRVcmorckxu?=
 =?utf-8?B?L0JWRzBQSlJMdUpRaDdkcFFYOWR4L0xPbEsxTm9CdmJBWk1UQ2kzTGNVWTlv?=
 =?utf-8?B?SmxkbDl1ZnVsTGRCa2I3cWJHSXE2bEgyak1PQ3BwQ3YrUWhGdzhWY24vbEZZ?=
 =?utf-8?B?ckFKcFJvbllJTVFSb1g0a1NDZlZzZjZDK24rWTdDTGVSNFJxc1hNTVkyV2kr?=
 =?utf-8?B?T1pUQmgrSHdiSVdOVjJiMm9uRTZXSVpjYXA5UC95TzlKWE14UlJaR0ZDQnA4?=
 =?utf-8?B?MHM2ZHFVVXZibXBML3JuTHh3cGxhcWV1QzVOQWVwZWQraTZOZ2VkQllzZUg2?=
 =?utf-8?B?amVFTE1udlQ1YmY0V0FpOUJwdURKQnJaUnFZbTNvcDh1N2d1YmllSi9BQnBU?=
 =?utf-8?B?SHZEeDhpTC9Bd0dZeXRHQ1dMUXI5YXdXZ1JNdzg0SDdwSFFkdW81cFIxTFFO?=
 =?utf-8?B?T2NuMnBhRThtdEd5cHRZemFHM2FTUHpOSXhVcTdNY2Z3QnpQL1dxaXZkUTIr?=
 =?utf-8?B?eDNiUWdJSWRmODF6Z1lEQzRtb0F6VExWQS9xKyt6UitIaDZMR0RUNlBlMFVW?=
 =?utf-8?B?VlF1UGM2a012cVA3OU1wOTJMbTRPLy92aGUxTFRhZnIzYzBtUmlld2VRMThS?=
 =?utf-8?B?NnB3eXZqYXo2Tm1rQ2JZVTJPM21GeHZERzRGRkNWMjdhTzJSME14ckNqUDBD?=
 =?utf-8?B?bUhIWWJMVHVkNGN6RTU1dVA0Mk1rQUZuUVRDeHpFb3Q5b1dLcVd0RjA3SWp2?=
 =?utf-8?B?OUI2azlvb3R6cVdKM3dkYUpSU0xhd0x0UmJpbEhteTZvcUgzcCtjNjdldFF1?=
 =?utf-8?B?ZWY3cmd4RWNkMU5OcnhLbkNreGtEUnRKTE1JT2pqeWwwTDRGZjBnUEU0aEVz?=
 =?utf-8?B?RWV3NC9uMzBwNWRJdmUwUGdMaCtjY0xDdzNPOXBya0VWWTBPeUlXT1NGdDNR?=
 =?utf-8?B?SVFvR05kczZOQTlSVWxoUitJdVc0VDRJWjFEb2dneGpOaFl3dlFSR3E1NTRU?=
 =?utf-8?B?K2FFR0llRFA4bHNKbXgwWmZucG9BS1NPdlE4K1B0N1pXb3pkeHFsY1JJalZM?=
 =?utf-8?B?NVlxMzl1Y3ZCcjJVellJU2tBNER2aURJMU55MnZoU3NrbmpMNWpNZ1ZDcmtL?=
 =?utf-8?B?SVhqQWZLYXJvMTlFK2w0azVrRUovMGRmWHFxRmR5TnNNVGZLQ1c3VXZRdDR4?=
 =?utf-8?B?bXA2aXlMODVhOUhHRWl2cG94TEwvUDFKNTNWSUdwTmFMYjJvSDQvcHRERHMx?=
 =?utf-8?B?b1hSaVFwRDlpclRZOHAvYlFtOGZEbU9mTi9GK1dIb0tHUlRjem9pWit4elZl?=
 =?utf-8?B?bUFtWWk5aStDTmpaQmhSVG5ad1BzQkFJTkNtWkIxVkdvYm0vZlJBOVJQclpD?=
 =?utf-8?B?dDlWTTN2aVc0RTAvbklMMDBHOWttOEUwY2hvb3VzMUdFY3FYYXNVUlNzVVJR?=
 =?utf-8?B?K0Z6MkMxRjU2dy9LVDdidUFVZENvVjBYaG5uek1DK0dQQy9IeC9ZczljMmI4?=
 =?utf-8?B?ZEppa2lRakU0cDRuS0dBQk8xem1jcXhVeFhXcGdRRnJBcFMvNUFSbDRTbmJ4?=
 =?utf-8?B?bEpBZlJQRFlxMmw3ckpUc21nai9ETy9QcVY4S3F5emU2ejhsbHdVb01peEJs?=
 =?utf-8?B?Umo3ZHlMNC81dDBpeXBQeGRCWjNvQXRPTmhhT2o5cG15NUh2anlleFlpZzVO?=
 =?utf-8?B?M2ZlZ0IvV1AvM3hCL0NySmtGMCs3alMvWTljZ253ZHNYdlVYcWlXcFRyTGFx?=
 =?utf-8?Q?tA/hrYFR3GyP0U+1MS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3267ba2c-f236-4d73-c881-08df0ee05cc3
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 02:08:10.3019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dVtHZKlKOMpE5yXR0RTrtlu9gFK3soDY8kLaMVvdWd/rfBG177b1HxV6LtwXoIGP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4183

On Tue Sep 8, 2026 at 12:56 PM EDT, David Hildenbrand (Arm) wrote:
> On 9/8/26 04:56, Zi Yan wrote:
>> After the changes of the prior commits, page/folio->private !=3D NULL is=
 now
>> equivalent to checking PG_private.
>>=20
>> Stop checking PG_private on pages and folios and use page/folio->private
>> instead, except swapcache and hugetlb folios, because the former uses a
>> field (swp_entry_t swap) overlapping with ->private and the latter sets =
its
>> flags in ->private. Exclude swapcache and hugetlb when the code is meant=
 to
>> check PG_private only. PG_swapcache and folio->swap.val cannot be set/cl=
ear
>> as a whole, so excluding swapcache with folio_test_swapcache() is not
>> reliable. Instead, use folio_test_swapbacked(), since PG_swapbacked is
>> stable when a folio is added to/removed from swapcache.
>>=20
>> folio_expected_ref_count() can be called without folio lock, so annotate
>> folio_test_private() with data_race() to avoid triggering race condition
>> checks. While at it, annotate folio->mapping too. Add data_race()
>> annotation for other lockless callers too.
>>=20
>> folio_set/clear_private() and Set/ClearPagePrivate() become no-ops.
>> PG_private is no longer checked at page free time.
>>=20
>> Remove KPF_PRIVATE since PG_private is no longer used.
>>=20
>> Assisted-by: Claude:claude-opus-4-8
>> Assisted-by: Codex:gpt-5
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> To: Andrew Morton <akpm@linux-foundation.org>
>> To: David Hildenbrand <david@kernel.org>
>> To: Steven Rostedt <rostedt@goodmis.org>
>> To: Masami Hiramatsu <mhiramat@kernel.org>
>> To: Lorenzo Stoakes <ljs@kernel.org>
>> To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
>> To: Jan Kara <jack@suse.cz>
>> To: Johannes Weiner <hannes@cmpxchg.org>
>> Cc: "Liam R. Howlett" <liam@infradead.org>
>> Cc: Vlastimil Babka <vbabka@kernel.org>
>> Cc: Mike Rapoport <rppt@kernel.org>
>> Cc: Suren Baghdasaryan <surenb@google.com>
>> Cc: Michal Hocko <mhocko@suse.com>
>> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>> Cc: Zi Yan <ziy@nvidia.com>
>> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
>> Cc: Nico Pache <nico.pache@linux.dev>
>> Cc: Ryan Roberts <ryan.roberts@arm.com>
>> Cc: Dev Jain <dev.jain@arm.com>
>> Cc: Barry Song <baohua@kernel.org>
>> Cc: Lance Yang <lance.yang@linux.dev>
>> Cc: Usama Arif <usama.arif@linux.dev>
>> Cc: Matthew Brost <matthew.brost@intel.com>
>> Cc: Joshua Hahn <joshua.hahnjy@gmail.com>
>> Cc: Rakie Kim <rakie.kim@sk.com>
>> Cc: Byungchul Park <byungchul@sk.com>
>> Cc: Gregory Price <gourry@gourry.net>
>> Cc: Ying Huang <ying.huang@linux.alibaba.com>
>> Cc: Alistair Popple <apopple@nvidia.com>
>> Cc: Qi Zheng <qi.zheng@linux.dev>
>> Cc: Shakeel Butt <shakeel.butt@linux.dev>
>> Cc: Kairui Song <kasong@tencent.com>
>> Cc: Axel Rasmussen <axelrasmussen@google.com>
>> Cc: Yuanchu Xie <yuanchu@google.com>
>> Cc: Wei Xu <weixugc@google.com>
>> Cc: linux-kernel@vger.kernel.org
>> Cc: linux-fsdevel@vger.kernel.org
>> Cc: linux-mm@kvack.org
>> Cc: linux-trace-kernel@vger.kernel.org
>> ---
>
> [...]
>
>>  		/* !PageAnon && !swapper_space */
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index 40d3f1b48a74c..9348ebf9de882 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -978,7 +978,8 @@ static void folio_check_dirty_writeback(struct folio=
 *folio,
>>  	*writeback =3D folio_test_writeback(folio);
>> =20
>>  	/* Verify dirty/writeback state if the filesystem supports it */
>> -	if (!folio_test_private(folio))
>> +	if (!(folio_test_private(folio) && !folio_test_swapbacked(folio) &&
>> +	      !folio_test_hugetlb(folio)))
>
> Now that I read that check ... a fourth time? a fifth? I stopped counting=
 :)
>
> Should we have a (in light of folio_attach_private()):
>
> static inline bool folio_has_attached_private(const struct folio *folio)
> {
> 	/* Careful, we might get called on unlocked folios. */
> 	if (!data_race(folio->private))
> 		return false;
> 	/* On some folios ->private is used for different purposes. */
> 	return !folio_test_swapbacked(folio) && !folio_test_hugetlb(folio);
> }
>
> Of course, adding some nice documentation what having attached private me=
ans?

Will squash the next one into this one and use
folio_has_attached_private() instead of folio_test_fs_private(), like we
discussed in Patch 10.



--=20
Best Regards,
Yan, Zi

