Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012068.outbound.protection.outlook.com [40.107.200.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB4F233149;
	Tue, 25 Aug 2026 02:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787623445; cv=fail; b=kA+cQZOv795sFfBy+JsTddprBcFvPaUjO3mNerhqwbsb5DAqAGKzzZxJPW9rcpWkuJb5kMfuwunTSgVfQp8qA8K8m7wqbJoJV5CedtlVTq8IxQ420ixXrfRp50dtOHCgPCVaRsaQRwkWsWSh/sb0z6wqOjxsW3YAsQ66+qpApMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787623445; c=relaxed/simple;
	bh=d6HR4PIxEjMoT/Gpx8rgjGvzunZl/Yd6UJ+nzzaDbyg=;
	h=Content-Type:Date:Message-Id:Subject:Cc:To:From:References:
	 In-Reply-To:MIME-Version; b=o67FDWY+uPqYhfD7bti5H7JtShxPBSzp/Qt5aGNotGTicT3jCxV7WGcg47BprvqbBKcFmPc1GkUk+dXbj/CC8AA/iG4gUp1xv7+Mz6q+kOm1B5aB6bRQog5QSh8KN0HpG6kpQwxhprZgG/rM1GujaCD2XqmrxzzHD32Vh+vdWqg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fyYOuAd9; arc=fail smtp.client-ip=40.107.200.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fyYOuAd9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A0eFMMWYsKNFh4XKPbvZPt022EV49ZAWKqRsRAcVv+Na9SuGpBqtRQhlxqSk1Rz2VRVJuNGsamJWH2DxkeR9vH4cWrAmYHJ2Y9btr+cuNV2izBkKBpKgcKgS0/X8daTLcYz1SxKECC+YsU5O44Y00SFx7w3uRJjckSVypdSQr2fWJIYuUjvCTS4GHQO8b781YDj6olEPWnE8SqXGNBOm/3FLZtxxsi+3a5OiMWsjLp0vMoNKZDxSQIKCdtJ4chsvUvsHtLUV54yau/+nhaSx/1Uts8pZRRaLCIJHTeJfedYMp+VjWmlkzqRj9PXMdImx2qXw9YszlWnNL+9HCsx3wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zjPPTo9SFY1kxMlV8rJHKB/9Cx0OpUyU9AX5VF8JjdY=;
 b=HP8PYhDJ9CPSo/jTuCbLNZUP895mosBhZpWdHh93WYP6IHu97vIyJnFGt6Y5rseqzxuIIhA95OgdlzDc+0nLCsX7XC8a9f5x6ThHb5VxGFHwZn8UTm4dkOrCJ7RfnLv0M96AOkdMFr2m0KQRYzxkFxsHA6F5mz7owSQfGhqtAO0PQcfwFouKHjxwNqfQNS3DOohcy+NfCMokWhFuRZt+iEo9kx0RekuLFy2JmFacS3vrxE2n3B2CP8DVbwNNR61bancxeCk0k+yPZRtpqCtndnpNk4GvaeP9Al80F0V5xZNYTKvT7d8ni2MypKUT4IgY68bIIQhY8JJsoiXuf8/MRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zjPPTo9SFY1kxMlV8rJHKB/9Cx0OpUyU9AX5VF8JjdY=;
 b=fyYOuAd9VIA1sbjvmoT3U49CgQcFeAMb3W3YH6ZLeKCe3Ae9UxA6srh+i9xAhDxkPXu6ivp90M8KwF+tJ849xuv5jBE1zDcSbBMVoTpmQ6yRQzK0drt+0lxvYy1v807eZsW4DZ/R8BxQp0XQ0CtWhBgNt8B00K0AKdD/BrS0ksO8ubKaE4SqgGqySyaA11A+4aP3T7g0tGpYLV6vFDM1OeW9YcWTVTJXaK2txKPKez9EYqJu6W/HHg4Jn3CNTdVpOt/vMmMZLqQolU/HbTTmisJqdzEhDpBzEnZV6dtQ4Vla3obHwtN4wUvNEjc5RHCUjHZ1ZHViq14UtjAvGw3Y2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by BY5PR12MB4081.namprd12.prod.outlook.com (2603:10b6:a03:20e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 02:03:59 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%5]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 02:03:59 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 24 Aug 2026 22:03:56 -0400
Message-Id: <DKXNMDJZIBOU.106CM3I6IKW2G@nvidia.com>
Subject: Re: [PATCH 2/6] userfaultfd: constify VMA parameter of
 userfaultfd_*() helpers
Cc: "Baolin Wang" <baolin.wang@linux.alibaba.com>, "Barry Song"
 <baohua@kernel.org>, "Dev Jain" <dev.jain@arm.com>, "Hugh Dickins"
 <hughd@google.com>, "Jann Horn" <jannh@google.com>, "Jason Gunthorpe"
 <jgg@ziepe.ca>, "John Hubbard" <jhubbard@nvidia.com>, "Jonathan Corbet"
 <corbet@lwn.net>, "Lance Yang" <lance.yang@linux.dev>, "Liam R. Howlett"
 <liam@infradead.org>, "Lorenzo Stoakes" <ljs@kernel.org>, "Masami
 Hiramatsu" <mhiramat@kernel.org>, "Mathieu Desnoyers"
 <mathieu.desnoyers@efficios.com>, "Michal Hocko" <mhocko@suse.com>, "Muchun
 Song" <muchun.song@linux.dev>, "Nico Pache" <nico.pache@linux.dev>, "Oscar
 Salvador" <osalvador@suse.de>, "Pedro Falcato" <pfalcato@suse.de>, "Peter
 Xu" <peterx@redhat.com>, "Ryan Roberts" <ryan.roberts@arm.com>, "Shakeel
 Butt" <shakeel.butt@linux.dev>, "Shuah Khan" <skhan@linuxfoundation.org>,
 "Steven Rostedt" <rostedt@goodmis.org>, "Suren Baghdasaryan"
 <surenb@google.com>, "Usama Arif" <usama.arif@linux.dev>, "Vlastimil Babka"
 <vbabka@kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-mm@kvack.org>, <linux-trace-kernel@vger.kernel.org>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>, "Andrew Morton"
 <akpm@linux-foundation.org>, "David Hildenbrand" <david@kernel.org>
From: "Zi Yan" <ziy@nvidia.com>
X-Mailer: aerc 0.22.0
References: <20260823-uffd-vm-flags-v1-v1-0-3086981b33cf@kernel.org>
 <20260823-uffd-vm-flags-v1-v1-2-3086981b33cf@kernel.org>
In-Reply-To: <20260823-uffd-vm-flags-v1-v1-2-3086981b33cf@kernel.org>
X-ClientProxiedBy: YQ1P288CA0024.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9e::7) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|BY5PR12MB4081:EE_
X-MS-Office365-Filtering-Correlation-Id: 74b0fba7-9a32-4cf6-4dd0-08df024d2065
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|7416014|56012099006|10067099003|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	qnXUq1oxe/87vZs7eOjxFtQ27LWrVNO+K56ry4+IhNu0RVLTKxfg2OXqkQfbsXTfRJ/lObQ/TiI+U8u3gcPWvK+dQ70d4xd4hn83+I4wMZCKGnjr5JTf7XXpAnfLGe3aAwzw/Pbre2Huzy7livexFQjfaTVsN210vxswOZ9WZls4PTpIwbux3zd+MBnFTfns3tIKufHtJAWCJbtPNRbd/JDLAAAEv19U8hvUVpg9qdjqPD2NITpiRb00g/6HK2J9ykdtzfdYSfzx7DzIj0QwDtmXgO1NCApCDUKOMjRf0WO+abJqUaN5ty3CPPqpCso+imP0pfw8bzeoB9CwujcMwbfepgCl9zqv6bsi8eZWk2vS5l2PlXA5VKelmKYKAX9OVbjo+hnFa9nDk+w/PsxZShl8DFAmQWBxXeXk2gUnHrzBRg6iJcDPmpwmoioWgz2TyDGAeUG+DVZGXUIMYReLpkbi7YNY3KJo5dKMT3GBiW6Rj6MGO8E5D+re9FvaoeJoM7c2CgPoPROxkiIBOECpzLZItXMs6hxviRXxFyMe9q0OaqiovQggnclNkJ9Kar4b0r8xW1EShwz/ygAvJPUu0ZyOZx7en5zWrAsHxrq0Vfz7CJpzEKPIlNf/vl0yaDnY7jMqohZ60Qed73wbWVdZq8/NWFcQP7dgms6w6xripN8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(7416014)(56012099006)(10067099003)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d1FWcnp5OU96b28yd0ZIanJ4bjlITHJNeTVTaW5JU1kvZTJnWEovS3JkdHVF?=
 =?utf-8?B?T21PemJRSGtkNkhlK3NadFZicFJzamRESDg1VzY1bUpoQmNKR0RCWU5VdkVo?=
 =?utf-8?B?bnBYL0RCUlN1OUwrU2V0Zk1TMlltL3FFNWZCdnFrandzUEQxamlhQnZzTlpw?=
 =?utf-8?B?TEI5YVUzcGZyQWYrdWVvVmxDZEJNaldFMllld0dMajY5cHpCbERvaU4rSjBz?=
 =?utf-8?B?RUx4ZkFwTzh6V29aTElJZHVSYVJWM1FaSnRiM2h0YkJjbmVxV0VUOWhRVGxR?=
 =?utf-8?B?MXhJSUlvL1FxRjRNY2JwbnorRXgxMXZGRi82SnRjZndzUjdOY0k5RkNhVUVz?=
 =?utf-8?B?Q2c4T1UraTBhb0JoYisxYi92bDl5Q3liS0FxNTBSenRFUmZSR3BNN0tOYWIz?=
 =?utf-8?B?bjZuUnR4VWh5eTJOMzZOd2FWdXNPeUxQOHo3WmlQczlhaWdDSlZIamJIYVlL?=
 =?utf-8?B?TFowalpETzJCUVlDR2U4MEFtS0FGRkFVVnh5dkhvelBkckphS01XWmVvK1Mz?=
 =?utf-8?B?NVlHZ3hQZjBWbFNZczBNbDJpOGQ5MHluWVc1TEJld1I4dGlFaDJLMHJob2NC?=
 =?utf-8?B?Snl0V0cwVUQ0UTlFWHZqUFVBdm43QjJBTWNINTRwRW1BUjBQK0lXQy9Rc3Vk?=
 =?utf-8?B?VXBjdWNSUGs0cStETmRJSnBHci9vUVZocGxCQ3pnRGpCQTdkUW1BR1F1MkxF?=
 =?utf-8?B?WVFoTDNpTzgxNHBJYnFlYUhyY0lnWmNQQjRid0lYUDQvUml2K0lZMEFTcDQ2?=
 =?utf-8?B?VUEzaHN0RnJaTGtpMVdGbjIvODQrR0tuVTl2Qng2YVh6b0hpeUE1U09kRXBG?=
 =?utf-8?B?L0NFLzIzSklidjN5K0RJVW1LbXNqTVlmMFkzSzloU2wxTitIL2twMDBSOWt5?=
 =?utf-8?B?RzRiMlljaGlDeDVERmhBOXNob25kRFZiSHlVWE9wdnRwdEJmNll4RU00Z0xT?=
 =?utf-8?B?cjFtTllIOFF0L3N3Q05KeXA5YmpKeDMvT2JTYWk0TE9lWE03L2ZhMlVyT251?=
 =?utf-8?B?VmZJRDZmM2JYekZtSDNaQThuVEdiV2ZvQ2lDeVExeXNIY25kWlAzRUVZenpj?=
 =?utf-8?B?dHpVZTdiSElibFJEeXRBT1dSN2w3WEpoZFFXZU5PLzZxTGxZOHkybjhpSmFs?=
 =?utf-8?B?KzlKWXJ3dVd3c1RmdStjcEJlZ0hpRWlPeGRkMXZMSDVEWUVsMktGTTVEcDNk?=
 =?utf-8?B?Wm9aMnlKWkk1bGlJa1llWEh6YzY5NjEreWw5bEhzSWkzenFMRFBaQytidUxr?=
 =?utf-8?B?S1FwZ2VaTExNdHpubTdQM0FyaXhJdXMrU2hDTWlGRytIYXQrYnBNTzdQalFH?=
 =?utf-8?B?TDJWYnJqNGhUaVBZSnhmRGcwMzJJcjhLNmxpV1VRdWlrYlVacE9DY1pWVHV3?=
 =?utf-8?B?L3dranZCT0t1RzQwcnMrMWdydUtpV2srbmhSMkN0Z1lGQVNvL0NPaGp5OVQ5?=
 =?utf-8?B?cFJhQ0VlbzcxZVIyZERLNGh3c1JNOEYyWEVSTG1uSmJiTmdscGJET2x1NGxT?=
 =?utf-8?B?Rm1GdFMvWGJPYXlxbDRXNVE5bG9ZVVFxSk1mYjRkc0NGalZ2SlpySjRuZmQw?=
 =?utf-8?B?WHVsd210S21XZlRvc3V5L3lDZWxOLzNZQ0x2YWt4My9vb1ZhVGl5RnYwSEVK?=
 =?utf-8?B?dHljci8xb2VpbUhVamJPK3NRWnRMM0FJMi9vRW90MUFHOE1Vc09PQ0ZFUmZG?=
 =?utf-8?B?ZityODhzUjd6S015RUdqVCtoU0pSTVhnWHIzZVcvMzZNOXFmcmNWMGx2T1Bw?=
 =?utf-8?B?eUhGdmR6VERsVzZLRUFNQjd6QWNJSVNoRThZSUNjdXgxV0tyOUF2bll6V2Nu?=
 =?utf-8?B?a1g4dGg2bTFORHdhSGtyd0Y1eEJaSjgwaUMyWXBJT3RrU3RBLzgxa0JFMHYr?=
 =?utf-8?B?Z3N6TW1VMWU1clp6bnVzTlJURStpc0tNekFqcGkzSjZLV1RTS0c2emtram9N?=
 =?utf-8?B?c1JBZlhrZll2SUxBS1UzOHVrZDljVE9WYnlnYURJa1NYUGEvYW45eGQ3WG4r?=
 =?utf-8?B?SmhRbzd0a1BqcGNHcDRjaHhOeTlrSjFQQ09nWDhXSjI0c0xGcS9EZlkyQUxs?=
 =?utf-8?B?TXY1MEdZaEFLWG9XdXlKeUszRTA3Um14d25veFp3VDQ1cHgwZnNXZEFIRXhP?=
 =?utf-8?B?WnZ2ZnllS1N1NXpHUzMxTEsvempZWUFkVkV2Q20veDZVa04ySHEzblM1bWla?=
 =?utf-8?B?NTU0MnZZR3hhM3dYWTZhTCtCejFZdmdHeXRGQklib1NPc0lCeGNzVHU5UWV3?=
 =?utf-8?B?QW41eU1UK1JsRVY0T1BPelhFSTFkdlJyV0VOVkFhZ05PVHJiTk5ZMkJEaW9B?=
 =?utf-8?Q?GhrZ64BedAv7TmgwtO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74b0fba7-9a32-4cf6-4dd0-08df024d2065
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 02:03:59.1154
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P6FrzmKjykvJO/wa0VZozCeUpYhMqKegQT8NdpEUppFEuIHyHki08R11fcNFOJJJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4081

On Sun Aug 23, 2026 at 8:17 AM EDT, Mike Rapoport (Microsoft) wrote:
> userfaultfd_{missing,wp,minor,rwp}() and userfaultfd_protected() only
> read the VMA.
>
> Make their vma parameter const.
>
> No functional change.
>
> Assisted-by: copilot:claude-opus-5
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  include/linux/userfaultfd_k.h | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>

LGTM.

Reviewed-by: Zi Yan <ziy@nvidia.com>


--=20
Best Regards,
Yan, Zi

