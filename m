Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010067.outbound.protection.outlook.com [52.101.46.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610B6411F8B;
	Tue,  1 Sep 2026 16:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788278493; cv=fail; b=BSA7TtiPUihwTQCh1aHtZJ3mJFKEtJFkuKWhXt1MsoSfViJy86wsztN4zZNdf/ABDWS6KrZt7rcIpcsBpE5yfsR9+/YzRQjn5Rt0P47DFF9XXK1C+qw4KIXXl3FLItQ2JEF7HT6wPBWfooqL2GWYfBPLasmSBA5nw86uEZm/uRs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788278493; c=relaxed/simple;
	bh=13pZTwHbrQS/3LKLIBaBbvu7CM/EZ7BbLtEfD9PpQEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JRG2lBj2nuGTx8jhO7XbAU2SLVPhxquHDkp1aGANN/I7ZT0ZpCe96BCLP9CYmFf5eR+1W1CcXE2Ls3znAiwWQwjEijPQVrKmo2KKQc7v5pttdeiva1N5xKf7iE417q8KtzyKJB8DDW5jzMTm7viLbkznA9i9+c4wtHCJ7s8fvVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VizP/y1C; arc=fail smtp.client-ip=52.101.46.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VizP/y1C"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ShKMCidC2wy+6sr7PW47Lce/KOLSEddwCJhYU72dfyITQAsyS8M8K9VtWXwgSLcMWRgY1H+gNtDGYB/u2GqFsuqMF+yRgvs/wjjg0VUXhEubO71tDKQ8qfA62hYosKx6DFRpiUSd5hUIE+EDklyypIni2jaTIxiXzSX4+Jn54lMuw4BZJQY5Ou3R4o5dBLkDK9fSQQH/+ADvg19arSPxmwv+CO2KbyG+JDzWzSPau0CtgNZa4oSFZvOt4evNKEXGQ6zu/6bJJGpHZtBdx7CV7f51UPtmHOFZDagv7C1JYfkhu9G/KAu+7+s2EvNjDUGFr7n4yVSX8bY8XNC2aFWfFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P/DmEx5/WB+Em+la+QvOgrNoPkDRmGyHQEe65bVuto4=;
 b=ucX/QHL4qyM/SoVfcaQcwezdc8oXLE0hP1RxaozVSeVLuKQHXmNT4mktSHeZWumxGt3l454nbZr5tZcnOfeCqp3CsPc9lPc9ikWOeMFrrC1UB9/NZO4Sq5LhZeWGhlLogNng76iWdx+9+7TAA0kqKjUgXuzEyf8pNgEmpfX67HFZJooeKylAGPM4VaD3eSaKmuGTb/tFbhjYYbHF6qwOu4Uk2Gd1/rVUoNZ7NbLtzxy2whLdMcIL2PK2he4imqImnDUK+SHuMZN0a/GvrBhu3Mel6FOMCx8Bo98ekfMIYGkdXDCObeiwOXlrpaE+Anwo80qjUl18LYX1ZvrQr/xugA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P/DmEx5/WB+Em+la+QvOgrNoPkDRmGyHQEe65bVuto4=;
 b=VizP/y1CgmX73m0Lq94U7/1U6fsRqLVhWPgHvWvn+2L1/aFTX7ZbKfd9xOolFFj7TWg9OCnJbmZ/TQqlCn/+TFgof5QkzoPbfg8lzVU/jMhhN+0bzWQLtC6cdMWzrogMvwyh2vV4JNkienJbA94saYUriydLB5Q5t/7UsEEJrtmjGk8zFxxPaE98FhuSnUpUPgK+sSKI3G/2JDHEIWrUIwqXcnxHNgrJGtNNPk9NEHW1ibLky0gA41dgskYJN3hLWyK0oZ4G2MiZgF2SLapkMkyjYkNz3vT/4fn6c9Ob/ibA/n1PSqpU+weGfl1gpGSD5lx0QPHxV6DkzyVQMa+8WA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by MW9PR12MB999209.namprd12.prod.outlook.com (2603:10b6:303:301::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 16:01:29 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%5]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 16:01:29 +0000
From: Zi Yan <ziy@nvidia.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: David Hildenbrand <david@kernel.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Muchun Song <muchun.song@linux.dev>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>,
 Gregory Price <gourry@gourry.net>, Ying Huang <ying.huang@linux.alibaba.com>,
 Alistair Popple <apopple@nvidia.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>,
 Kairui Song <kasong@tencent.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Baoquan He <baoquan.he@linux.dev>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pratyush Yadav <pratyush@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Jan Kara <jack@suse.cz>, Masami Hiramatsu <mhiramat@kernel.org>,
 Dave Young <ruirui.yang@linux.dev>, Shuah Khan <skhan@linuxfoundation.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 kexec@lists.infradead.org, linux-doc@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 14/14] mm/page-flags: remove PG_private
Date: Tue, 01 Sep 2026 12:01:24 -0400
X-Mailer: MailMate (3.0r7024)
Message-ID: <21998471-74B7-4799-9E8C-D75003D1A4CB@nvidia.com>
In-Reply-To: <20260901115542.35cf337f@gandalf.local.home>
References: <20260831-remove-pg_private-v2-0-3668159cd9e8@nvidia.com>
 <20260831-remove-pg_private-v2-14-3668159cd9e8@nvidia.com>
 <20260901115542.35cf337f@gandalf.local.home>
Content-Type: text/plain
X-MS-Reactions: disallow
X-ClientProxiedBy: YT1PR01CA0084.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::23) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|MW9PR12MB999209:EE_
X-MS-Office365-Filtering-Correlation-Id: e301290c-ad93-4ea3-d08b-08df08424887
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|366016|10067099003|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	NaOquSOHq3qDfgJ4uRqzvyhAEdS5CRdYU36kpuxOOEelZNDgEW9b78+O5Q4eP3YaVlrr4UijSIn9owZgLgT13yH0mOEPUpeuMGsbtSiW7MBS8CcAbF9WLiEUNNvfnk1XcQQnN7zaU1WPLHbDXfUMUww6Gw0ewM0W07WNNYGt3wK4FnEbREYB7jw+BAFpWA4ZJQNd1ivvZ4aSFSND2w5zig2bJzP78+R73LLdDdFvNNxZRGrSAfiYC+EAhlb4MDYP7OGQFDKkpFUUct2i8dgxJ94TGVW486qlkGrOsFUVmQ1PTK2Tt2K6lqsJMkPTqvl3dGf56vlWqsoQtDoIe1H/vaKFCIQhj7464ZGJ3zrCFnqd8uB5fA2v13ZeXllMirxXzffl/wUYrHTeb937swoKXf1gLmrJH5klSQuzCX4qxcDX+exEWteLX5GYO7DYrusZOofsKoPoSfSU6qSqvvC0pT6v8ZlPls4maoEz6d0i/G328LHwE9qUkBnWsoQ/UxGOLh0iPUZ0iNYAbSMXCiXRQkZMeaDbFOlDQ73THkmJtqPBd6FV16w8cBfNCV2F+zYBFDZf7Xd+utiCs50AF5NMT7mg2Ezikgnl9J55IIO7gomPdHzzaO8eKkgFJou4QzhjkGlRIoclioAZpe/v1pwaAhokSU5+v8O7FYQjEx73fIg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(10067099003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pFAuO+J1iPlAakgGdD5klVJlZts7suOogn9xWqtT4tEv5sRqMe4jea4yELVV?=
 =?us-ascii?Q?2XCG0TLtN2z3dKFmdVAw0cwpsyMHA7JyTUpalLZPN9URyXAT+Sq9Htd2yRdD?=
 =?us-ascii?Q?xLnH2LoBorsh5yE4xcKgP78YLlqbrw6/hVrAKs5w6ga+60SFYggBfosImMMh?=
 =?us-ascii?Q?iUxIHppr1fhRcorKw/q5Jid4jL+pBGeATq8aXP3+6mf399d+wTJf3nBrGE5o?=
 =?us-ascii?Q?MTDVO7yQYkzeebDuKSmeJhFpKJiiyeZcVTrO/MidZJK7O4gKSZAn1q4vGH4K?=
 =?us-ascii?Q?/6I1IOeYgbHQqME6hNajy+oL0A5b8d4l+tT6zTcfHGFQEAL/J3RWcn1gq02O?=
 =?us-ascii?Q?bnDycIYAOgjTOMqLICm5s7DbhRmwc88Dh1LjYAnf6JZaI1TIg2bCLYf4+aW9?=
 =?us-ascii?Q?2aSrY/OQg33/fQwSrMUJR6sbBHM5WYjyheLJAvOuQe96H3iYKbSv8Wpl2QKb?=
 =?us-ascii?Q?bqGvLJxy1WstPxPLitsbn+JZJpm7OPbT1jqodN/LnTT869B4dwgvCwnbPrF0?=
 =?us-ascii?Q?E1YtfmaiqEI3fTKQtY2/0lI7IFuWIdhLuSgGisAlF0KFME3kEIRFI2WN7Vwb?=
 =?us-ascii?Q?zKYA5DLV1qwj2/HdvQ5GBVGlKcGeMlbdWqDsKNAYJxexKmHn0yJQJucJBV8s?=
 =?us-ascii?Q?aiZMmDg6gyeSTz02VuucwAFIhyeN9n1wOoNcs72ruE/Boa/BzQx+nzr+LdL/?=
 =?us-ascii?Q?XV79XAIyzCkcgbccjpr43AVpTaMtloahcS26bHyfqDTTT3OW4BY+0a+biEkX?=
 =?us-ascii?Q?UVInBiO65jKNDUmk09z442u/dL5mBkikJ87xQXq1SeO4HWVmXTLHYSwQhhqZ?=
 =?us-ascii?Q?U9luAlD5W1dliexKBFNpNNPUnDeOXrjeCKGHk4HFNs8qddXCUXkBRm/cG8/E?=
 =?us-ascii?Q?jptNWU1T8Hdd+OjZFmyZQIx6T8WJI545beb5rtBmTW5BYl1uIl0AEiU76+yV?=
 =?us-ascii?Q?8m6GsWgbOaCwONaOEgs5f0j4Xvjpfas3L5nmJZrjMN3AeDjqSm52eaHS0CTp?=
 =?us-ascii?Q?HaiNuILZ7moaWkfqyQ1Bil8+oVCs/SN+IrY7/o661BAcZsYHOCMUxvQlE5LT?=
 =?us-ascii?Q?3tJYzRsYuMg6nnQi0rgXCMyfJG4NMCFx4/9GIJwAr33adJ4M+wvJogEB9JDM?=
 =?us-ascii?Q?P5jGP7chR9KcQYYNk0lsnuyqIfnzh9xfsJW8pC1R8UyEhFUP29wOYJghnsNo?=
 =?us-ascii?Q?xtmXDkOcGoLGuUDw9xK5G2RAa3NZMhc9d9GOvslyEBL4uKwW/pfbhS+2ijXQ?=
 =?us-ascii?Q?acrq7HmKMhnQy2cJjLHvj+WmeNmhj2qHnqo+NkTJ/AQBbYrQ6GadoQ8u66iN?=
 =?us-ascii?Q?LXZ3+zNm+mqnXTSdOhT8DT98/F+3RFQj0sEQ9GQR95Hm+cuA8qrhIJNZ0QNk?=
 =?us-ascii?Q?vRG6/2XGBrSrOZoHmiqgip7A9giL44Mon4yO7Jb8i5HmRYXN/xCSAo/S+Iqe?=
 =?us-ascii?Q?6TKiHY7PCvgitl9Laxiu6UJmAe63KuTfgYsiODHufwEUE2wIstqt4581v3dB?=
 =?us-ascii?Q?Y7/vngztCBSpeC3vgVUfGiuY+/7Eqjbs80uLYNVt7D9IQpbXBsdQdy6e2mCi?=
 =?us-ascii?Q?LfLXSjzWKkTu5xTLf0L0Xw9kkSsTYGEmlY2MqhvTeaEK20Iz/6rH2/YHJkjz?=
 =?us-ascii?Q?6tLghKF2Di0woEWUlNJCT/41cqJZX8ypgjiw3BH2GnnJlXz+OWbczUQiemPL?=
 =?us-ascii?Q?C7LrNuZNxCaQ8qsdw8TWqm7yGWPfmdFXzSd6n96DeI5xGp02gY3dslzXqgqL?=
 =?us-ascii?Q?pFUGEZNkiQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e301290c-ad93-4ea3-d08b-08df08424887
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 16:01:28.9236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SocWdsEStq/hi7+wWZgc8NKX8mfja0+VxYrL/7DQYtXuMM3cscPluo0NUnrEDe8F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW9PR12MB999209

On 1 Sep 2026, at 11:55, Steven Rostedt wrote:

> On Mon, 31 Aug 2026 15:25:37 -0400
> Zi Yan <ziy@nvidia.com> wrote:
>
>> diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
>> index 935893e5ea53b..caf090cd6f85e 100644
>> --- a/include/trace/events/mmflags.h
>> +++ b/include/trace/events/mmflags.h
>> @@ -144,7 +144,7 @@ TRACE_DEFINE_ENUM(___GFP_LAST_BIT);
>>  	DEF_PAGEFLAG_NAME(owner_2),					\
>>  	DEF_PAGEFLAG_NAME(arch_1),					\
>>  	DEF_PAGEFLAG_NAME(reserved),					\
>> -	DEF_PAGEFLAG_NAME(private),					\
>> +	{ 1UL << __PG_folio, "folio" },					\
>>  	DEF_PAGEFLAG_NAME(private_2),					\
>>  	DEF_PAGEFLAG_NAME(writeback),					\
>>  	DEF_PAGEFLAG_NAME(head),					\
>
> Hmm, just for consistency sake, can we create a:
>
>  #define __DEF_PAGEFLAG_NAME(_name) { 1UL <<  __PG_##_name, __stringify(_name) }
>
> Which is similar to:
>
>  #define DEF_PAGEFLAG_NAME(_name) { 1UL <<  PG_##_name, __stringify(_name) }
>
> But adds the "__" to the name. Then the above would look like:
>
> 	DEF_PAGEFLAG_NAME(reserved),					\
> 	__DEF_PAGEFLAG_NAME(folio),					\
> 	DEF_PAGEFLAG_NAME(private_2),					\
> 	DEF_PAGEFLAG_NAME(writeback),					\
>
> Where the __DEF_PAGEFLAG_NAME() with the "__" still stands out, but the
> code looks better than open coding it in the middle and making one wonder
> why it was open coded. (It took me a bit to noticed the "__" difference.)
>

No problem.

BTW, the plan is to add PG_folio after this series is picked up by Andrew/David.
So the new __DEF_PAGEFLAG_NAME() will have no user then and can be deleted.
It should be fine, right?

Best Regards,
Yan, Zi
