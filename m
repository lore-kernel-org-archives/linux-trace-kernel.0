Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010028.outbound.protection.outlook.com [52.101.201.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E35D3859E0;
	Tue,  1 Sep 2026 02:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788228731; cv=fail; b=AAegtAJXom9w6QiL0gUsbtRmi9naHwDj/O+ubYIWZE0kS9j1iznMbPeuCMfiDr1M+1ohaLneWcgPIRAhPK1VQoUQNkWnlShJbZ9+8Mk96CgHgHHDQ/LlADOI+XXLa7PCFKA0L3bYtL18gJvXYCgUaE8Kl6Dy8CvnVIZFF5g7bBo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788228731; c=relaxed/simple;
	bh=0CWz9OtcdzYt6rxanyzgW/fYHmupEYNs1UlFIwVVuN4=;
	h=Content-Type:Date:Message-Id:Subject:Cc:To:From:References:
	 In-Reply-To:MIME-Version; b=HJxQuDCciHHsthsTZxnYIVCy+4VJd71czcsrcndqYa7B95uA0m9lODzkzlmPX+YOST7eCTbtShy1OIoYRG5j4l+DEMqiOwLfj7bQo+sFy6bvAPPuZpheynD6vnlB/KMMbPHTtwV5bSb/hzc8esclTzbYHMrY+6HmXI2HQSRNgzg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bqOFOnG6; arc=fail smtp.client-ip=52.101.201.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bqOFOnG6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=inkj2+L6HDTN0fEAp2QxK69w4qm47jp33dps6c8Dw9l+dTreF+930RjoNozaLn3Cs5YgI4zjqfUTV33BVxj78CKRi4/mlAyEhhkZ9D6kSdd6vAqoym2eu6gyvaCr9SSnus58bQgTpjZp218NIvi0mOl5MBc4p7hglZqswRuSS7Dwx/Rh6tSgDgxSoq5veB6wxNuqjmB74plfmVmu4yk2qXpCb9yhvcf3XE0NqTPELXEtJf4SibJQlyhaaZaZnbj6HR1QUzPPv8rMlhFDsfQ/qXHUg/81BuyNy+goyO5vIwJLkB8A0c0iBGb7mocHch3xmTwrsuxTPXuZrWJFG7r0hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PqtzknO3G8NyLXaJkb4bbK7oObF4e67L1M/6AWyk8cc=;
 b=Nd/34wSMaqvo7ZlZwsnoV4jKScUj0u36QYUkvvV20WJ1PcTpFQ0E4eZbKfoQWEKYB0PelCvfcZ5qUMNh8PIc34cePVQ3fspr91C8W/zbQ68R8lqyFmtxCk1GQrKnbRtK2iWUBNtfQfdUV9N+/oN1xGBURHYSaXmeX179Vi6rLpDH8/kZ/Fk37d7v9WXOFAUWXoJ2n+kagDVYxXkY8SWDJadwjpobG42XaiQzoTRnEHm/p8TgeafCQkKmgfI5/X0860C+dGIkVU0JYXkhjZSdIMVIAj1Q9050Ia9Rto/Ih7AnOCWb8jRYMumnM5na/4NYVstSS++ovdmuQ0ZGbVkumA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PqtzknO3G8NyLXaJkb4bbK7oObF4e67L1M/6AWyk8cc=;
 b=bqOFOnG6yCcsNFCw6fJMKfx83zVmU+4apOvaVaHjaT/s8+GpQSvPh1YvG+KoypnuAfVQTWmBq0eTmQ7DJuc6Rft97QrS5JYHprXDxWI/qP0/hFX9tDS/1SshWPdp59F/AwD9X5cnfD/0DiV3DiDbzkrsaG4TRCK8O9yDdL1hVCN9mmC+TFBxle14/AQwEjJjZN741zM1G6ZT0EsMZXU4kjqwfkddUXInJ/CsKLW0Gtq5St87sXoGFaq9mrFKQ5RD7djmhQYpP/DSmC/B4kzrzejbWK7Y41G0ZIkMcW4sIX/tl8My3cV0BGzvVyQYrHvdKLVNJlSuoM9m/uYo39dDZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by CH3PR12MB9172.namprd12.prod.outlook.com (2603:10b6:610:198::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 02:11:48 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%5]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 02:11:48 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 31 Aug 2026 22:11:45 -0400
Message-Id: <DL3M668E4MQ7.1OEAAHUPN9S6S@nvidia.com>
Subject: Re: [PATCH v2 09/14] mm/page-flags: check page/folio->private
 instead of PG_private
Cc: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, "Zi Yan"
 <ziy@nvidia.com>, "Steven Rostedt" <rostedt@goodmis.org>, "Masami
 Hiramatsu" <mhiramat@kernel.org>, "Jan Kara" <jack@suse.cz>, "Mathieu
 Desnoyers" <mathieu.desnoyers@efficios.com>, "Matthew Brost"
 <matthew.brost@intel.com>, "Joshua Hahn" <joshua.hahnjy@gmail.com>, "Rakie
 Kim" <rakie.kim@sk.com>, "Byungchul Park" <byungchul@sk.com>, "Axel
 Rasmussen" <axelrasmussen@google.com>, "Yuanchu Xie" <yuanchu@google.com>,
 "Wei Xu" <weixugc@google.com>, <linux-fsdevel@vger.kernel.org>,
 <linux-trace-kernel@vger.kernel.org>
To: "David Hildenbrand" <david@kernel.org>, "Matthew Wilcox (Oracle)"
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
X-Mailer: aerc 0.22.0
References: <20260831-remove-pg_private-v2-0-3668159cd9e8@nvidia.com>
 <20260831-remove-pg_private-v2-9-3668159cd9e8@nvidia.com>
In-Reply-To: <20260831-remove-pg_private-v2-9-3668159cd9e8@nvidia.com>
X-ClientProxiedBy: YQBPR0101CA0268.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:68::8) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|CH3PR12MB9172:EE_
X-MS-Office365-Filtering-Correlation-Id: aa72562f-414c-4eb8-6dc8-08df07ce60ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|366016|10067099003|56012099006|11063799006|4143699003|6133799003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	71Qd4WcGiY9ZKDcy8/TeOsO2IUaivVZfyK9bzZcAHWxy7N7iU9my7sNmv6uGHOAut6UpOtg6f4n9nisZyY7TWIh05mbctjBkSzah44wKsdH+sxt9Ygo+deoF1USU9kSkswj/mU4UNpYvna8eexOFWCn1DsypwntWJLeM+JeXAyehRgBpGM0EajM+dT2XxQXZ50hAZ+9775LwfU/R/H7nby6GQYcIKZOdBLjuJ1tO3xBJYL/Fa7OmXjmKATUfKnhrrTGchzasq0Ot7jT2mkCc4OXTWPA1txI1HKrWLGG1tuf2s5Lc/ftGTvm5VkJkmcmBEupW3AF2VwRl/5c7dOcKZtai7YTF+8NAO8facWnWKjV81BUmQNFwbRgOy4YaCP/eL2l/TSXqJ+Z2lH+cVvRuyPV9RUGVl0SKdpjxZ9ZKqaaWx6Gi1xsv344oJlyZfXEX8lDpraGgO9icnt5I3GKPhigXmcwGOVrolgESQhvoh+ucMx4n3t1Gp84HS39ErEVWy2tZbLQu5QIw+5KUnBMMZU3gEvpkBlJn2bgSIw95k+iM1tgPTtYPktHweuCBE2xsYkBibRY9O/SZZ/n+OhFa9+JrkqEMAHxoB/78Ds4tHCnPFMZNMzk2TZi9xF1yfEpOT01NaimKqm1za0LQP89ceN1vNjdq7R5Gg8wv0jqE7cJ1WIQ8TV0KqI0dkpBiem+jOJQRgwbUqqQyOW5mg5G8/Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(10067099003)(56012099006)(11063799006)(4143699003)(6133799003)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UERPb25aZ3g4akhIK1pocWdXWmlQWFR1MXF2YzNOWFpaanRDR3NJNXVzWGFM?=
 =?utf-8?B?dytRcTh4WkcwWHovMndLdkh2U2pTK1JjUVR3R0txd0VSMDM3bXY5YXJueWF1?=
 =?utf-8?B?VlhQMGFJMTh0aTNIeW5Nb1lnK0xsNW5UUU92MzUyckY0anBRQmFrczExeG53?=
 =?utf-8?B?OGRHSERCQWtmUGpLMllaWFN1ZElvUGJCTU94Y0lWRS9La2kzcG12VWxFdExB?=
 =?utf-8?B?c1VTYm9JQkc5bTJPS045Z3B0cEFqS3lva2lTL1hRRm5iK3FEYnJIMVc3UktC?=
 =?utf-8?B?K3BjNkwwMFVyN0duTUovelZ4cmwvc1dkTlRiL2xsYkxYdlF2dE9aVVNTRE5O?=
 =?utf-8?B?RmN2QTU2a2llYlhTVWh5TEdLa201Q0hwTjJXZ0p5OXEzQk9PRURZeXlnd2JM?=
 =?utf-8?B?TEE3NVBaNTh6NDF3ei8xWUxnQjkvWUtaMGhMWURUUjVxRHV5MFptWmY4M1RU?=
 =?utf-8?B?dXJTRzA1eDNtUUoxZkpyK0FwaUxCeWZNUzRTa3VjSXBPdHRXMkhqazlLdDE2?=
 =?utf-8?B?M2xpcTIrTWhWSTZRRnNxbUcvZFRaS0ZEUkJKV0VWYW1naExEUWVLbnkwMXJx?=
 =?utf-8?B?VE4zanZ4blRhS3ZIL3F4UVp0SHgrakZVcld2R3NvS01pdWhzOU9NamIwQ29o?=
 =?utf-8?B?WjBKYXZiRmZEY2ltVFRQWGJiR2lKSGR3alNWS3Yzc05CRVloeDVFSlJjdUdt?=
 =?utf-8?B?cDlWVGRpV0ZiZ25lUGNxNmpidVgvK0I2NEUxTU11MkNack15NjN2RVJjSFNC?=
 =?utf-8?B?UW56L2tlQmpHaE5VZHBrVnNQMjVTSFNGYWhRVGZ5cTUweXBkemx6REFnOWdV?=
 =?utf-8?B?NVYvUGlKQ0ZxR0o3WnVodW1jb21sTEk4QXJmc1pLd3lSNFlPK1Z2Vk1pR3Ra?=
 =?utf-8?B?TkhLNTBML3VJc08zNnVOdWpRRDV1REY4TFJoNjR6c05LcTZPVTE1TkVnc1k5?=
 =?utf-8?B?RzdVd1ZDV0VJZHE0T00xRGRWb1JFZTRWQ1Raam5selFvZGVIQXBUdTdoTjBj?=
 =?utf-8?B?aFU4bGVRMVE1bDFjQmxGbnNRamtMNnhiRUpoQ0sxMGxqZmtRZE42NVYzYldm?=
 =?utf-8?B?MTBzdU5ZdTBjY0FobUZmMGk0ejJyNStQQkxKTjBvaFJ4WmtEaloyTFdmY3lM?=
 =?utf-8?B?eEVvSXlmbXkvQXVGRXRONFdyVHVvSkIxRGxNbkpPeHJiZXdwSGN2ZFZ4a3Zy?=
 =?utf-8?B?Vm1jRGlsWmdVTk9KVUg2aENwWWhKeStLaGliSGM1RVVtZlpMTXVBaVR6d1Yy?=
 =?utf-8?B?Ymt4UDBiejAxMllLTENHc1ZSUmlNNFIyU1FqSWZqVnl3ZTE2c2RmdXhoQmlG?=
 =?utf-8?B?bWZlQ2dCNG53SFE2WGJBUmtuWVgwYnlHT2xlbHE2SC9wY29ZN2JMWFhjdGxa?=
 =?utf-8?B?NUdjdXprWUlnV0VUVURoaWI2WldWbFA2UW9Fd0NUYUZXSi9ETFNxc24rL2hC?=
 =?utf-8?B?aFZPMUl6bmt2ZzBTM25qQU5aMzBSV0lTeUhqckVMQzJSaXdROEJlMjVTUCsy?=
 =?utf-8?B?RHpQZC8zd0N6QU5sd2FmNEZJd0hMaERSSlRzeFZKWVpib25Jc1RUZFdhZUM3?=
 =?utf-8?B?cXplY2V3Ylhod3FidkdsQTlHR0k4VWkxMERLVWRualRKQktTaHgvUUdSZzJU?=
 =?utf-8?B?RWJvRE80YjhEMkhaOGt5STBISUpvU1Z4VDNySE0wZEhTd3NzS0FDYzZKT3dY?=
 =?utf-8?B?V1Q0NWJ3QXc1UTFDbGcvTEpPOEtURVIzS3pRdUJwUlZZM0N3Ui9FU2dwR21y?=
 =?utf-8?B?ZFVRSHNxT1plRCs5U2ZTZXNjMG1ZOTBLOHVuaDFMRVYyayswdHFrUVRZR2hJ?=
 =?utf-8?B?bGVPN3BvS3pmWXdmM1FtK3VnVjRmQW81V3lzQTN5OTErWTdvMCtKVUNpdFdn?=
 =?utf-8?B?bWtERVpMdTdxSFE3ZVhDYTFGMkZqMmtaOHFENnRlSkpvN2ZKODRwTUtEUklC?=
 =?utf-8?B?UlZneDFMWjZ1Q21iZWdPTWwwdW9PQ1pYU3U1aWoyQnJDY0ZPZ3FHMFhzellX?=
 =?utf-8?B?T3RsRlE2Y2U0K1JyNGFjSURMamZyZ0xLU0pOZjFGRXVqSmZqeWplby9ZbEhm?=
 =?utf-8?B?Z0xyTjIrVmwzUjAxUXZDNkZrN3dIQWoyYU40bWpBeks5KzJjNGxjeVp1Wkg3?=
 =?utf-8?B?YnRiWTYvZEh2MnZzMDk4MER2NENZR1hudlVTdTlZWmY5K2dRTHhwVlZGR3Bw?=
 =?utf-8?B?Z3lJd2lEZzFCbDA0c3FrRkY4K1ZXWHVKaDk0RjZZWnM4bkJ0b0U4RlI3NWNF?=
 =?utf-8?B?VUlScDU4ckRWRzF6OWZlYXRINDFScm1qODZpSnJRcTZmTnhSMzZtVExRMGJh?=
 =?utf-8?Q?hzWZ4S2z/E2Zby1t7A?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa72562f-414c-4eb8-6dc8-08df07ce60ea
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 02:11:48.2048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e4zVD+i1BydH5/9L8tH3hBvInyDZ/oXD8AGPNE7vjqWD8OektoslInoj3HimxMBy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9172

On Mon Aug 31, 2026 at 3:25 PM EDT, Zi Yan wrote:
> After the changes of the prior commits, page/folio->private !=3D NULL is =
now
> equivalent to checking PG_private.
>
> Stop checking PG_private on pages and folios and use page/folio->private
> instead, except swapcache and hugetlb folios, because the former uses a
> field (swp_entry_t swap) overlapping with ->private and the latter sets i=
ts
> flags in ->private. Exclude swapcache and hugetlb when the code is meant =
to
> check PG_private only.
>
> folio_expected_ref_count() can be called without folio lock, so annotate
> folio_test_private() with data_race() to avoid triggering race condition
> checks. While at it, annotate folio->mapping too.
>
> folio_set/clear_private() and Set/ClearPagePrivate() become no-ops.
> PG_private is no longer checked at page free time.
>
> Remove KPF_PRIVATE since PG_private is no longer used.
>
<snip>

> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index dd09c438fa23e..786f8a47cea6d 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3022,9 +3022,9 @@ static inline bool folio_maybe_mapped_shared(struct=
 folio *folio)
>   * @folio: the folio
>   *
>   * Calculate the expected folio refcount, taking references from the pag=
ecache,
> - * swapcache, PG_private and page table mappings into account. Useful in
> - * combination with folio_ref_count() to detect unexpected references (e=
.g.,
> - * GUP or other temporary references).
> + * swapcache, private data (folio->private !=3D NULL) and page table map=
pings into
> + * account. Useful in combination with folio_ref_count() to detect unexp=
ected
> + * references (e.g., GUP or other temporary references).
>   *
>   * Does currently not consider references from the LRU cache. If the fol=
io
>   * was isolated from the LRU (which is the case during migration or spli=
t),
> @@ -3062,10 +3062,18 @@ static inline int folio_expected_ref_count(const =
struct folio *folio)
>  	ref_count +=3D folio_test_swapcache(folio) << order;
> =20
>  	if (!folio_test_anon(folio)) {
> -		/* One reference per page from the pagecache. */
> -		ref_count +=3D !!folio->mapping << order;
> -		/* One reference from PG_private. */
> -		ref_count +=3D folio_test_private(folio);
> +		/*
> +		 * One reference per page from the pagecache.
> +		 * Use data_race() since folio might not be locked.
> +		 */
> +		ref_count +=3D !!data_race(folio->mapping) << order;
> +		/*
> +		 * One reference from filesystem private data.
> +		 * Use data_race() since folio might not be locked.
> +		 */
> +		ref_count +=3D data_race(folio_test_private(folio)) &&
> +			     !folio_test_hugetlb(folio) &&
> +			     !folio_test_swapcache(folio);

Sashiko said [Severity: High]:

Could this lockless evaluation of folio->private and PG_swapcache lead to a
TOCTOU race for shmem folios during swap cache removal?

During __delete_from_swap_cache, folio->swap.val (which aliases
folio->private) is cleared before PG_swapcache. Without memory barriers, a
lockless reader like memfd_tag_pins calling folio_expected_ref_count could
observe the stale non-zero folio->private and the newly cleared PG_swapcach=
e.

This would evaluate the condition above as true, falsely inflating the
expected refcount by 1. If the folio has exactly one extra GUP pin, the
inflated expected refcount would match the actual refcount, bypassing the
F_SEAL_WRITE protections.

Answer:

Yes, it is a problem, since folio->swap.val and PG_swapcache cannot be
read as a whole, when __swap_cache_do_del_folio() (was
__delete_from_swap_cache()) clears folio->swap.val first then
PG_swapcache.

Fortunately, PG_swapbacked is stable during the process. So the code can
exclude swapcache folios by checking PG_swapbacked instead.

In the next patch, folio_test_fs_private() will be changed to replace the
new check: folio_test_private() && !folio_test_hugetlb(folio) &&
!folio_test_swapbacked().

<snip>

> diff --git a/include/trace/events/pagemap.h b/include/trace/events/pagema=
p.h
> index 36c3a90f0acca..fb9abec40ec79 100644
> --- a/include/trace/events/pagemap.h
> +++ b/include/trace/events/pagemap.h
> @@ -22,7 +22,9 @@
>  	(folio_test_swapcache(folio)	? PAGEMAP_SWAPCACHE  : 0) | \
>  	(folio_test_swapbacked(folio)	? PAGEMAP_SWAPBACKED : 0) | \
>  	(folio_test_mappedtodisk(folio)	? PAGEMAP_MAPPEDDISK : 0) | \
> -	(folio_test_private(folio)	? PAGEMAP_BUFFERS    : 0) \
> +	(folio_test_private(folio) && \
> +	 !folio_test_swapcache(folio) && \
> +	 !folio_test_hugetlb(folio)	? PAGEMAP_BUFFERS    : 0) \

Sashiko said:
hould this lockless read of folio->private be annotated with data_race() or
READ_ONCE()?

Since tracepoints like TRACE_EVENT(mm_lru_insertion) are often executed
without the folio lock, concurrent modifications to folio->private could
trigger KCSAN data race warnings here.

Answer:

Yes, will annotate with data_race() here.

>  	)
> =20
>  TRACE_EVENT(mm_lru_insertion,
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index ced400f72d43a..546b37ccce37f 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -4810,7 +4810,9 @@ static int split_huge_pages_pid(int pid, unsigned l=
ong vaddr_start,
>  		 * will try to drop it before split and then check if the folio
>  		 * can be split or not. So skip the check here.
>  		 */
> -		if (!folio_test_private(folio) &&
> +		if (!(folio_test_private(folio) &&
> +		      !folio_test_swapcache(folio) &&
> +		      !folio_test_hugetlb(folio)) &&
>  		    folio_expected_ref_count(folio) !=3D folio_ref_count(folio))
>  			goto next;

This is another lockless check and data_race() annotation is needed.


> =20
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 15b45832bcfa7..f14e7bfee14bd 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1327,7 +1327,8 @@ static int migrate_folio_unmap(new_folio_t get_new_=
folio,
>  	 * free the metadata, so the page can be freed.
>  	 */
>  	if (!src->mapping) {
> -		if (folio_test_private(src)) {
> +		if (folio_test_private(src) && !folio_test_swapcache(src) &&
> +		    !folio_test_hugetlb(src)) {
>  			try_to_free_buffers(src);
>  			goto out;
>  		}

Sashiko said [Severity: High]:
This is a pre-existing issue, but does this generic migration code blindly
assume all private data on an orphaned folio corresponds to buffer heads?

If a folio is orphaned after truncation (src->mapping is NULL) but retains
private data because an earlier release failed, try_to_free_buffers is
unconditionally called. For filesystems like iomap, folio->private contains
custom structures (like iomap_folio_state), not a linked list of buffer
heads. Calling try_to_free_buffers here could lead to type confusion and a
kernel panic when accessing what it expects to be bh->b_this_page.


Answer:

Not an issue. With the help of gpt-5.6-sol, this issue only affects
buffer heads. Folios using iomap always clears folio->private before
folio->mapping is cleared.

> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index eeab25d6ce364..4022d6c381896 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -2705,7 +2705,10 @@ bool filemap_dirty_folio(struct address_space *map=
ping, struct folio *folio)
>  	if (folio_test_set_dirty(folio))
>  		return false;
> =20
> -	__folio_mark_dirty(folio, mapping, !folio_test_private(folio));
> +	__folio_mark_dirty(folio, mapping,
> +			   !(folio_test_private(folio) &&
> +			     !folio_test_swapcache(folio) &&
> +			     !folio_test_hugetlb(folio)));
> =20

Another place needs data_race() annotation since filemap_dirty_folio()
can be called locklessly (e.g., zap_pte_range()).


--=20
Best Regards,
Yan, Zi

