Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012044.outbound.protection.outlook.com [40.107.200.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D8F1B4223;
	Tue, 25 Aug 2026 02:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787623407; cv=fail; b=balv3sB8tvLSOw7V2CI9PvXWmxVzZ7kTypac0KtgwUU7iPlU7lS3fEi/fbcnJxnZ5cVGDZIPJCymh4fgIzxnDP64yADGuPc6ayYiF+gUJPAJOInDTH86rCkqwecnCeO4sjUiXcvJtAIzjGZ2tbeUUSgRM6hWFc4Q0IfFv816rDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787623407; c=relaxed/simple;
	bh=LUbceBqpF3/oIbHUjsZ7iDjFA/7PfJOuWMrI/gxVvfw=;
	h=Content-Type:Date:Message-Id:Subject:Cc:To:From:References:
	 In-Reply-To:MIME-Version; b=LAoexzTg5dR/1aG9kVLlS4YrU1IEsZwyiyKUSmh+cOtMyHDxYO6yt5tKGoa+KUK24U++drF/wa5SOdzu6uB3OXVfnVIyKqhwBkNGlvtBPQT6fA2awtqtoz7GRcSx1pM7ZwA7N1MPObusasdIddoRreLxbN75IMHGkDSXEmsNUek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AsbDR9bn; arc=fail smtp.client-ip=40.107.200.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AsbDR9bn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tc5IJWHSM5fFldSyNjQs0EuSye3HkYwSztoRQ0nTWeTRtFp2sIvGn7C8P45R//XU96rjfFMCiSK2lqSznzbB5qjgZTQxVYda1AHB41K1lLsBE4wD5DxtQTq5GHEjUT+lOlxJndgkISj5h1Ebmk2K2x0f6OmlDJ8LHT/DsToHe5R2B3sCaevphlFMwCJslXlCQ1CXDO0E1u4in3r+I6O7VvOsGppUCZFE+87aLT0ILODKDTqrLZgk4tESuFSxPU5UjM22Tn5f30BvZwUqDT+44oZSuoFAJ135V5tIZ53lhr5OOzjY1E2YmjtXRsOx4Qlo5j6ND4bOTN/G8JP4YgJsew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g+GV7Ns6TyH1HCdLp7T4DefVda5ZXyLoFJ/Nv9jljE8=;
 b=FABWJJWvWEMMxvN58NaV8AZ9ChuQC0PP7vvszxv37qW55qyxudcCcXjdcgJWbN/dUE7Yl2RMlv/7qGWbRk/vXKg71vVJki9aIXeuKk/NS2pOb67gIgTvVgw9VhODO6ZkoqUhYDsjTmPMmC9L90Bk+1zNGvG1kHK38R9qrSlEARXqMqP0ufdBd9WWwgbH8OCf7pMUeypcn+T2eyUIKFTfj9dtLIZwXHKiAxTB/N3QQxOxotcv2/GJrH+KE2g0701nor6cKyS4GRoq3CVeaua6xgVdwZKwuK0Hhs23zzVXThOOxsSqgZ6JR7DYammQHaAS1Lx/Z0XOgioxi4yV0K2yfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g+GV7Ns6TyH1HCdLp7T4DefVda5ZXyLoFJ/Nv9jljE8=;
 b=AsbDR9bns9R5zHahufVI/RckdkjGh2ItK/e+JlRQ+ueCvL0VUPSozy8Ppnyvbgwkywsjqdpy5md5NDx8jXsPqMKQA1QB4k12FUiI7FMarVtj/exPpFi3y8a5Sx/c84oqXJyHrfWrgq2kuSO5PYVw9MkbxM++QDv63swIK6YI3iP134W6G5wjQFiyyexkCbr+bZPiIZ7qYNFTkGhFvkcWRYSUQ8dhcuwebSfZiGVRd9uuyWYqXchs6r4NOncUo1LfKIb6mXjNlHtSK3DLj+Y+ykpTt2OzyfaDA+fsjBp6nxMQOMaIjis3G+Sho4A3QbcOPnffI3Xs+W0kGzFEU5el7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by BY5PR12MB4081.namprd12.prod.outlook.com (2603:10b6:a03:20e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 02:03:21 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%5]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 02:03:21 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 24 Aug 2026 22:03:20 -0400
Message-Id: <DKXNLX03Y6QX.1B65UHEQB7SEV@nvidia.com>
Subject: Re: [PATCH 1/6] mm/gup: move gup_can_follow_protnone() to gup.c
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
 <20260823-uffd-vm-flags-v1-v1-1-3086981b33cf@kernel.org>
In-Reply-To: <20260823-uffd-vm-flags-v1-v1-1-3086981b33cf@kernel.org>
X-ClientProxiedBy: IA4P221CA0005.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:559::10) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|BY5PR12MB4081:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f733a02-bd33-4a37-e353-08df024d0a09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|7416014|56012099006|10067099003|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	6xs4y9TqoDnK1p3goAskPKwEgZ1SkJtxV7KCwgLRgv75M/Li90l7lP6KT7+LXXU4lhAhybu7ISDlruoRQt8k8oRH/WnDR3oYmAQEp82x/UgDlxtk8uON3LE5Q7pohfX0c+mAU3YpnoVWhielJ8naNOMng7x0TqGl/lC3U5vNJ4dSDnz7fonXKTKPZsDbzzUw4cdVqqd0oM6Arl9eN4M+LPh6F7omRGo6aTxzWMshaRgILoeWeAi8EpHM1uKu7pxZi3FHbITmKKSBy5GyOpA5+4PWapSgHQZqntkaTHxdd6Ot92hiDbfau+PY1medUqiziGkXxlcJGdJ3Dpco7wj0QkZ0bAtACtql1uGbwsYKkRaMkMIbR/hZUCPl7aLR3nCewZBtDYTSV9O8HBl+W7lO+PauwRXQso+bZUFB1N5HvpdJMrZFLjeS9qwb9sWSgE8oWrcZ5WX7C2iRwogRucNdF9rZSDiIBn0gRJQ+ykdCNEKImp5MhPtb7pEIZHy4v1dGQwlB1p6lTM4ZoMMa68qdK4qaelELh+ofNjLW1d9KKb42JISlP27Gz1EF25NC315T1EJcah8VYFRRiGu8HogKvmAxJoplhwAFpQGxdAWMkN0jvDD8FCaY5pmbt6NHIIJ1+XWzkvsxLY3Djcy+o6F4O48/Bv0fZ6K1PjcVWHfCMTg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(7416014)(56012099006)(10067099003)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M24wVGxXemRqS3U0dkV6bWlRODRlY1RBUFJ6cTMrRHFKY2FaSE9EMituNGRG?=
 =?utf-8?B?VFVvUHRyTkk5V0ZTUm4wNFgreUdFK09uL2xJeGlMZ1pUa08vRnA4NWdHQWZ0?=
 =?utf-8?B?cEpSZVV3T3paZExQdnIwendIUXBGdld2MzlkaGo3b3ZjNjVxRERBMFZLSER1?=
 =?utf-8?B?Rkl0QkNOZ3lvM0E2YWg1WjhXdU1Kak81ZnRFKzNUQStpNUVGM2JZRmszYXN6?=
 =?utf-8?B?NkJvUnZnaVpHN0dDOEN0OUlLZHhnZThYcFNQWW1pN0FwNmVaSlg4SWN3RUJ2?=
 =?utf-8?B?UlB1VHpCbDVGRWxiRTNTckpxdnAvdC9ISmprNkQrMjJGZW03MUZ4SXRqZlVt?=
 =?utf-8?B?WjFPQ0ZNREFXZE9kSFpTdktNR1crM2drL2JnbFdEcFBLZXdNQ1FHQ0xFeU5L?=
 =?utf-8?B?K25ObFZzbjJ4MTV5RUlqTFJlOUxHYWgwYnNtUUdtSDBuaVQ2bWZKS0JiVXRO?=
 =?utf-8?B?OU5Ba3dIME5Td0VMWmwwd24rNjIxWnhOR0RrUDlYOWZPRlIza2dydzRuYkd2?=
 =?utf-8?B?NmVUb3c5WDBzSXYvRnE1amh4elVaZzUrcytEVE1lUzRUdXNHYmg1eExrY2p3?=
 =?utf-8?B?RzIxeExWazZXajIvbkUwaFdEaFAycEV0dmpIUUFZT2hUbG4rSjB0WnBOcnpt?=
 =?utf-8?B?V1pjMFYrdHkrQVZIK255UEV5SW1TTXV0VmZ5RnRFUzZ1cWJCbjF6bUJWQVpH?=
 =?utf-8?B?QkkyTDR1cG8wei8zb1ZlTks5TEdZMCt5OFNvUXVwQzYxUnV6YXZRZkM2a2s4?=
 =?utf-8?B?eXJ4RlJLc0YweEpOM2hidGtkZVZDQ3hkWmxDYnpIKzIyWWxZSGtmZW1MUWJk?=
 =?utf-8?B?bk10cUdhVGtBczJIdGxsOG83Q25vUXNPUEJzMCt5QVYzclE3d29yaEhkVGU1?=
 =?utf-8?B?cDlqeitHVlJGWnZ6YkZLRkpkVW5Ja1NoblJxZGNRUHdwVGZrSnd2V1VmN2ZX?=
 =?utf-8?B?WGJxRUNkeUh0ZkhuR1J2Zkg0ZmF5ZzNGVUxuRmlSRFUxZXFITjZKZWVCZm9j?=
 =?utf-8?B?VitRTDZFU3Mydld0a2JWTDBNeGxvVUtJMWRLcmF0SXJqUVJOSDAvLzA2UmRW?=
 =?utf-8?B?MTIwMU80U0hHOWJ3S0Q5UnprNEsxNHk2YThueHVudmVhMm5QcGxTQVk1NlQ1?=
 =?utf-8?B?djZGK1lmNDUwZUFXOFBHRnN1RTNGM3VaaVM3akZJU2FTMFZtVE5rT2JoTVBC?=
 =?utf-8?B?WmZkelJLMlpHeUVFbjVpSmhnV3d6U0xlajZqa1BSN2c1emhGSkQ5N1lCTTA1?=
 =?utf-8?B?VmV4eUtTSmxXc1pTcDZmMGF5M1UxWFVyQmxmN3V3RlBGN3RISkhYMDBHMlk1?=
 =?utf-8?B?M2t6VUx6azVsTE8xVTdad2wzT2habjF4NkxOc3RES2VucHVsajNIMHFaV0Z5?=
 =?utf-8?B?OHM3aXFpQzJVN2FVdkRBRWhnS2FPTFA4TTQyc1UxZEZkbEdUeGI0LzUwSXlR?=
 =?utf-8?B?U2RrQXZDZUxPZVJQZ09PTExDNmI5RVBvdlJCdVE4RnBQZ09CaWEzV2tlelhs?=
 =?utf-8?B?Zzl6UTQyVWMwVlp2WDZHZG9Ia3hYS0JYOFFXMnFiL1pDK0E3KzRNeDhwcjlI?=
 =?utf-8?B?Z2prOVVSTG9mZTZLeS9ZZFJiOWx6bW8yd3dueWNyMVFvYVBhUHZsZXZuc0hn?=
 =?utf-8?B?djJ2dWkrSXFaL3BFWUhOdlcvWTZvM3VqaXpCOSsxR1pJV3dBZWhpWi9OSnRh?=
 =?utf-8?B?WkxTNUdscUp0ME9ZdjBLQWlkMEZGSDIySnQrRHR5L3M3ZUtIV2N6SU5HeEJz?=
 =?utf-8?B?cWR6Rzlhc0hHQTVTTnY0b0NwSVFPVExFc2dMZExCcGxpaUJJK0pBUEdIc3hV?=
 =?utf-8?B?MEg0ZmsxdnkxeWxBdXNxaHE2Q21wRS8rZlYxYUNQdXlTaHVpUkxtcWVKN3lP?=
 =?utf-8?B?VkxMalZxNkhhMFhFUkFTZDhHUXFuYk5lZFVTWWNOS3MzSDlmNW9ucGtyL3Vq?=
 =?utf-8?B?MFluMWt1UHZCVExXcmxvbmFmUTU2RHNHRkdwR2Q4aFBXcHRkRFludEJ2QVVT?=
 =?utf-8?B?eDFpdnZ0NE1vTUFVRkhVVGR6YkovaDlUMHR4dDZ1TVVFMldPdXpHSHN4Kzlj?=
 =?utf-8?B?d0tlUXN5VUZZRlBQMWF0Z3E4Sm5aRlhGa3VLbVQyREhBTmxNcmZIeEdqRXJk?=
 =?utf-8?B?cnVEVU5mb1psNFZab2c2aFB0Z0d1dHFHZDNMRDhIVnZJL0pleWdhNFVTTDRu?=
 =?utf-8?B?TEZUOHBvSThyS2tlT1NXdElLWGg4NnFFNGZaNm5DczBpQzlvR3dzR3VLdXR0?=
 =?utf-8?B?NWtkSWNzSnREM1FrTkNuODJXenVLYktRUHVPWnowMXIvMVYwR1BXTkRhQjAy?=
 =?utf-8?Q?F7XdL5IopH2nUWF6MD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f733a02-bd33-4a37-e353-08df024d0a09
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 02:03:21.6167
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BhW0aJjNBuhsVyDUEd8T8fLnv7jYGFxrGg7NWd7iIW9gDfBB8/DvnXOgC8L88GCk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4081

On Sun Aug 23, 2026 at 8:17 AM EDT, Mike Rapoport (Microsoft) wrote:
> gup_can_follow_protnone() is defined in include/linux/mm.h but only used
> by mm/gup.c.
>
> First, there is no reason to have it in already gigantic header.
>
> Next, the upcoming refactoring of userfaultfd flags will make
> gup_can_follow_protnone() depend on userfaultfd_k.h which would cause a
> cyclic header dependency.
>
> Move gup_can_follow_protnone() to mm/gup.c.
>
> No functional change.
>
> Assisted-by: copilot:claude-opus-5
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  include/linux/mm.h | 38 --------------------------------------
>  mm/gup.c           | 38 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 38 insertions(+), 38 deletions(-)
>
LGTM.

Reviewed-by: Zi Yan <ziy@nvidia.com>


--=20
Best Regards,
Yan, Zi

