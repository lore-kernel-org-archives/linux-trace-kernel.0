Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012011.outbound.protection.outlook.com [52.101.48.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9F055D880;
	Tue,  8 Sep 2026 17:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788888131; cv=fail; b=HrQXeIRgcNrzXZwJNf98EIT7BhFPYEsFepKtoES+sJ8Senl8qJWpms+FDNYDAC+Xbq9O6U5a5RcIcrSUBDPuityh1AkafMlt52w6EtQ0ob5w3y2ftFNR+uhvqccxVOBMcYT6QSKUMdXYnD+JROtIKnkLjBcK8WBXeDmtIk7hON4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788888131; c=relaxed/simple;
	bh=DRK2LMYsvLDqC1a6VYo610rbqLW0iRXmjWXG05kH4yE=;
	h=Content-Type:Date:Message-Id:From:Subject:Cc:To:References:
	 In-Reply-To:MIME-Version; b=kBNkH+vBIHwycq8tCIp7XlfYXJ8iBVWIuvA9BorK0voWj58tThZVhuBjGm16ZVVb8HagW4g8iwVyxz4ihFoaH4+heRayTnWflUQSTZx0IJbuV+P8Zb8AVrNsYf0NBttPk/0BJC0/QPV2v252V3ydgXggVInaZRayIIivxn2Mz3w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tMCtRfU/; arc=fail smtp.client-ip=52.101.48.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tMCtRfU/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iaxVGmLzt6/6PJAIvVeTo5p3hp6eNV6ubIaGx/COawmuxV/Tl2qKttIG/vB3OR3E2rVuoFe9ElC5x/Ac7gUSZm1FhncAS09NSQjW0nZjBcfCSEoXkmf1eh717iB8tGCtlk1zMiUO4HioEcgb2kIqsZEUTzjOlYXK100iiCtpee2x/jV7ek9hgNR1Ar7Rm3LKFVHnAKW/GrkRdSbXO0gyARm9hMJE0YzhZgHGXlagxWVHqCoSwHDF/6+Olj//vOyaAk06At5RfByNYaLQR3vsQd46L+oBhu481PIcq69O3GN5ECx4TRXnHuDikyJPeHX+QMIumBn+BWZdS5K8uRNGGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VbHtyfEelPxLzCROjVk2iL1R6xYOsxhBLengWg9qRss=;
 b=OyykYdhd4LUbiycJkHIO/hFC5+jl75opooO3TXGT4L/BRoZaEEkR4rjcOX2FyaHEtlQQD4ebGa7fjfn2+sDyZIlaNZXLSUTkPixzgbW6jW6leRvWDZe8xM9fZlTz3lFyk7nzoNrkvQUdYolrYzEyYb7MTQyk7+O6c0+B+bMxL+FxyuF2RfeuEZK3FrV+eP2RV/Nlgad+A8axBblr26UAasjeWYAUadaJzwJbyd18GWeLpASAo8NR+6cDs5LFvqQtibDvyh+ygbyIRMlIuKjATFyWeVByONjgRkSWFrXKmy9+N3yj8pQkIsuoaOEBqcAfBIQ/Ro+VBYcJK1ZrMWPx8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VbHtyfEelPxLzCROjVk2iL1R6xYOsxhBLengWg9qRss=;
 b=tMCtRfU/l7HWuCetHRhteQxna7xm4Prf3LWGvrvG4lYNzN9SIngd233F+nXO/vTGUHyNT/oJOKniAWi51ifYKU+m3bgEZmUK9pJAGvaqlRq1OncpVhK1X5r100P9a2Cmg7WWiDZ8whZSBL3nm4/QaoAnZG46l+RAIrUwBu+T5iXdGLo2iE8vh7k1y9dGi1rGkHNreqTBW0ZcqRuO9WzirN/nFmD8vRQNcXmUevSJfFp+I5grXFa62E5h23DUQ1udivJEc6hUDXdoI7tKi9fklnMxXI6gtBwUz4K3PuEgBUm4b50c7eDtCti4c7xAykmQCFdHw+n0yz5ITnBIsa9Sew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by SN7PR12MB7955.namprd12.prod.outlook.com (2603:10b6:806:34d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 17:22:04 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%5]) with mapi id 15.21.0406.005; Tue, 8 Sep 2026
 17:22:03 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 08 Sep 2026 13:22:01 -0400
Message-Id: <DLA3WXO23NK2.1EG7GHUT907UB@nvidia.com>
From: "Zi Yan" <ziy@nvidia.com>
Subject: Re: [PATCH v3 10/14] mm/page-flags: introduce
 folio_test_fs_private()
Cc: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, "Steven Rostedt"
 <rostedt@goodmis.org>, "Masami Hiramatsu" <mhiramat@kernel.org>, "Mathieu
 Desnoyers" <mathieu.desnoyers@efficios.com>, "Matthew Brost"
 <matthew.brost@intel.com>, "Joshua Hahn" <joshua.hahnjy@gmail.com>, "Rakie
 Kim" <rakie.kim@sk.com>, "Byungchul Park" <byungchul@sk.com>,
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
X-Mailer: aerc 0.22.0
References: <20260907-remove-pg_private-v3-0-6ae22f9d9272@nvidia.com>
 <20260907-remove-pg_private-v3-10-6ae22f9d9272@nvidia.com>
 <6efff84b-7628-4d26-b65a-6f5b747030d0@kernel.org>
In-Reply-To: <6efff84b-7628-4d26-b65a-6f5b747030d0@kernel.org>
X-ClientProxiedBy: BN9PR03CA0400.namprd03.prod.outlook.com
 (2603:10b6:408:111::15) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|SN7PR12MB7955:EE_
X-MS-Office365-Filtering-Correlation-Id: 17a8dea4-049c-4aee-2df7-08df0dcdb2ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|366016|1800799024|376014|10067099003|18002099003|22082099003|56012099006|4143699003|11063799006|921020;
X-Microsoft-Antispam-Message-Info:
	e01zPpFY6sERZum8+4CCTBjo1JdW1U0cg0Grd1+U5bmxwpVWEklS0r+T7+fd47JbfNZRMMzOWPY01a1i4BrO1ptxk8Vq6/fV2a6v79cJMH6wJ1sxmurjPg+QZvKK1fIu3BhBzqjgTZcgBg8f3DIArcVC4lVKQAFbL6otos14vt6WsR4HPV83lD571NEsMR3botFlnuzLno3vH03l6HK7S6eGdnQZI/PVWX7nW75JZglVE+1zBAoFilV1rRSN9nStK37vDjTHmvXcm7K2Tj0I5ep4luJYJ2FwrRDYcWXqPtwQTk4uj7UV7q+j6q/x3aBohgRf12DvDsGMnC0JA3bjnmFZ3jhRmx/rhp1CaGCuihWQFtKr8o9EmT8G+rQkiJusQIcTsfVWBPOQHvMsLMQOVdWRkiN1pZEvmEi06NhSaq7H/lcb4yiL5HZtWdTOuri8tEAunjZH2wG/CJD3mVfBHkfskIbmiwFqcIHtmWIgydXUTNItY95upACi3VDEjp0Ql/CoyG5jjPdqRnH8iBA4RZBWpGoO+Apwzje3v/WrQFXbwkCUYt8aDu7KlsWdtLDaJ9bI0YOOiceWtU6fh5kmiPqZJ9piMsFL1ckp21W6y5uRcRFEnGIsxOD+Zme8Vh9XkoVlgQiYvdR5zMRE2fgwgsUmfwwS426GukV+2f+L8UH/L5d2QdvLxntpqHZ95WQi8rkCY96zXqu53NlqZkNdPQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(366016)(1800799024)(376014)(10067099003)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WUcxTnEyMDNhL0RUK29yOXBDNmxJVVpsWldUOHd2enozRkRkUVFqK092VmEr?=
 =?utf-8?B?SUJ6c09UQmt3SlpiV1BHOTNIZ2F6aHNKYlZYaEUrQy9yVWxWMHFtWkF0Ry8y?=
 =?utf-8?B?NERvN3p6RVp2OEZxeGRXZTMxV2h0bTdXSFYzZFcwakxGZGVrSXc0Nkl0TWd1?=
 =?utf-8?B?Y2N5OVJBOGpwcFNLS09iNWZOZWcxZFRaeUdJeTJWcVdhWEUydzRGc0lJUjhW?=
 =?utf-8?B?VzRIMm1RVitxdWk3Q1N4bWU2NEZwT1VhMm9mU2tncVpkelRlbGlNajZBVjRk?=
 =?utf-8?B?SmJPWUNxdXE5TUV3bUVuTjFVcFJWWms1WFV4RUhiZG5wVEpvaXN3QitsUDJI?=
 =?utf-8?B?RkFEb0w0MkhTdk5aaDhxWGxSNHpSUi9pYVJMbmowQjFZS0Z6dGNwVU1pcFZJ?=
 =?utf-8?B?a0dTYXcvQmVCZC81RDhGZ1VZcUxPUWxtcUhXdHY3UlgzUlRMdWhPaUhYSTc0?=
 =?utf-8?B?TmliRmRlT1NzQXpqemhySy9mSGdRWi9tWkJZQ21vbTE1cVFsZ3BrV2Zwenlx?=
 =?utf-8?B?YUZsU2NBWEtPU2s0bHRWaklrSzBvaWk3SXViQ3lOV2hIZjJLa09JaVBWRzJ6?=
 =?utf-8?B?MWdLYnZGVjlsZER4d3krZE5oVERQNEFDWjZYL1BTQ0o3S0hOSnBqNE5qQ3dk?=
 =?utf-8?B?WjU4aUZSQTkxR2FPUUJ0ZGNxeWlnd2EzRUNjRzJrSE5YY1EvM1YxaXRMeXVv?=
 =?utf-8?B?Qmx5WVJxTWh0T3BrYUdYWlh0a0xTeUNra2RyU20zRkhoU213c0dRWE5rT1VP?=
 =?utf-8?B?Z1l0WWJSSXJPQTk3ODdPUmcyc2FteG5qcy9UZ3A4eThmM2NCdE5rQXBFWU5R?=
 =?utf-8?B?SHJmUmJTMy9TT1V6cFhCa2QzTDd1SWlHM1gvQ2JqMkdpYWwxbUprVU41VTB4?=
 =?utf-8?B?YkNoMDQwMDQ2K2dhbTRLWm1qTmVtc3g3QStwV0VUOFJjcURJWGp6RC9Dakxn?=
 =?utf-8?B?QjRtVWFDSW0raTFOVlB5SFFpb053N3VDaEYxb2ZaWlZ5NmduYWtlbHYzS09r?=
 =?utf-8?B?ZTNZL2h1K0NJc0xUa1VwYmhHVnJ0S2p5UGRuMWw0Rm1zczF0WThtdlEydWdY?=
 =?utf-8?B?K2lZZ2hMU29IZElRYStTZ2RYQm96c2U4dE15a0F2SFVselU2eE1OMUwzZFVx?=
 =?utf-8?B?SWp0SWNPMFFzbGJGZWIvWUxuK1JqUVNMeS9aTkVhVEFsUENqbzR0cnU0RW50?=
 =?utf-8?B?T1pFdHRXTkNrdG1wM3R0OGNXQW9PQzFmVW05SW5paC9Ya2RxZTluMFlQZkxM?=
 =?utf-8?B?Um9DRG5XQjB5OHdiOGM5cTkzdjZCemtLVUJHRCtqYnZxVlNJQXRWOUtVT0VD?=
 =?utf-8?B?bWQxYTBDQVVWZVdaZlVwZ1NDeFZYM1N3cE8yLzFSbEdadStYSlpKNysxcmNW?=
 =?utf-8?B?alFhRXR1dDdWa1QrdlhBTzFBenVBVVViZXM3WTM0V2tpTEtqQWRoMnVpelRT?=
 =?utf-8?B?SUFxRjZ0dklISDFkVGNxcThhTm5YRkpTRWhCb2FUdWRjNytLNDREVFNyUlI0?=
 =?utf-8?B?NUN4RnI4Y1hlcDh5K2kvTk5jLzhPcURiVWVaV1FnTnlpRndCcFZydlkxcGNo?=
 =?utf-8?B?Vm8vKzVVb3d5d01EUFdEa21UdUV1UlJVMW9JSTZYYjFYYW0zWDR5c2hKSUFl?=
 =?utf-8?B?SE9MVDRYb25NSWo5aVRhaVZUaGM4RmpqTzJFWkI0OG93N1k5eW9pQ2FWV2tW?=
 =?utf-8?B?MWMzY29WMFFINGE2L0tmeFRBS3lmeGJuYTE3Yyt0TVRPS2pJenlCbEM3d00x?=
 =?utf-8?B?OWYvL01QY3BUVTZia3drZEpzVHFJYTd3Tyt2UFUzd3dYVmkwVjk3K3BkYzJM?=
 =?utf-8?B?MFZzWUlZM1kxeUR4dE53ckhOWnBqbXIvUmJmbEZhbUxqclYrU0J2NGdzc0VP?=
 =?utf-8?B?UFBBWFFHUElkR0tCaTNSUmJNUWRiOWN4Z2xnUFRlNzlMei95eG9UWjI5TEFh?=
 =?utf-8?B?ako2SjB0SVZEcWg0akRLTGN6c0dmbGl6aENnRml6NjhQSEhHWjl0YmdqOFlM?=
 =?utf-8?B?a2ppVVpXUXUycFhkQzFtNFJjRXd0THR0NU4xZTZReC9DaUJDamliMVhodjQy?=
 =?utf-8?B?dUR3WGNWcHE5bGdqbzhkeER2K01Yd2xYUFhCek51c1gyYm9tbmZYOGd2V0ZH?=
 =?utf-8?B?MHdjejNjMTRZYVV1NzZBNW1haXU1eDJXcmw2akxmRjRFcHl3aUMwUEhQZUM5?=
 =?utf-8?B?WmRhRGtxYkZEQ3BmZDJUaDNwRUxDdFNJOVFNajFycDFKb0JHcVZObWE0aGk4?=
 =?utf-8?B?N2RGTGVmYUdtNFd3THNNL2NHQWpiRDVTcUVqSEdHWndtM28rMWxaNDhxaThz?=
 =?utf-8?Q?oftFGKp4f0mfXy0HNm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17a8dea4-049c-4aee-2df7-08df0dcdb2ba
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 17:22:02.9722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cQjzpGJZhznbwwkNfAmQtBRpU6WWOohgKTsVYVQTtQ7XSodpYpabpj+kTpBWMP8G
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7955

On Tue Sep 8, 2026 at 12:59 PM EDT, David Hildenbrand (Arm) wrote:
> On 9/8/26 04:56, Zi Yan wrote:
>> folio_test_fs_private() wraps folio->private !=3D NULL check and exclude=
s
>> swapcache and hugetlb folios, since swapcache uses swp_entry_t overlappi=
ng
>> with folio->private and hugetlb sets its own flags in folio->private.
>> Replace open code with the helper, since core MM does this check
>> frequently.
>>=20
>> No functional change intended.
>>=20
>> Assisted-by: Claude:claude-opus-4-8
>> Assisted-by: Codex:gpt-5
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> To: Andrew Morton <akpm@linux-foundation.org>
>> To: David Hildenbrand <david@kernel.org>
>> To: Steven Rostedt <rostedt@goodmis.org>
>> To: Masami Hiramatsu <mhiramat@kernel.org>
>> To: Lorenzo Stoakes <ljs@kernel.org>
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
>> Cc: linux-kernel@vger.kernel.org
>> Cc: linux-fsdevel@vger.kernel.org
>> Cc: linux-mm@kvack.org
>> Cc: linux-trace-kernel@vger.kernel.org
>> ---
>>  include/linux/mm.h             |  4 +---
>>  include/linux/page-flags.h     | 26 +++++++++++++++++++++++---
>>  include/trace/events/pagemap.h |  4 +---
>>  mm/huge_memory.c               |  4 +---
>>  mm/migrate.c                   |  3 +--
>>  mm/page-writeback.c            |  5 +----
>>  mm/vmscan.c                    |  3 +--
>>  7 files changed, 29 insertions(+), 20 deletions(-)
>>=20
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index 5eb8a62fafb56..c861525cda83f 100644
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -3053,9 +3053,7 @@ static inline int folio_expected_ref_count(const s=
truct folio *folio)
>>  		 * One reference from filesystem private data.
>>  		 * Use data_race() since folio might not be locked.
>>  		 */
>> -		ref_count +=3D data_race(folio_test_private(folio)) &&
>> -			     !folio_test_hugetlb(folio) &&
>> -			     !folio_test_swapbacked(folio);
>> +		ref_count +=3D data_race(folio_test_fs_private(folio));
>>  	}
>
> Lol :) That's what I meant with folio_has_attached_private()
>
> (I think I prefer that name as it matches folio_attach_private(), but I m=
ight be
> biased ;) )

I can rename it, since it sounds more generic than "fs private".
>
>
> This really should be sqashed into the previous patch, OR, have a prep pa=
tch
> that only replaces these instances and uses folio_test_private() until yo=
u
> convert it to folio->private in the second patch.
>
> In short: touch these call sites only once, not twice in a row.

Will squash it to the prior patch.

--=20
Best Regards,
Yan, Zi

