Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010048.outbound.protection.outlook.com [52.101.61.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6097A3DB645;
	Tue,  1 Sep 2026 02:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788229036; cv=fail; b=R0F/TnaEgUvpXaG2Z9PdbzGUn0F77zc/6b1jF0JKOCD3verIjhgCa1W2XAK17qHJI80E0UkZL+a5oK8xwqqzr4n3sFggxVqIU7RfkRu2Nmyx1PhU1vf5C1AJz3G8lDFlaQXPXVLGnWzTYFtcaQapCGJjjHU9e5dKcIZ58xn2o9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788229036; c=relaxed/simple;
	bh=Su/Ioz0wHlSKfztK2XNC8lbWPOJIr5GSCoI3zN1swI8=;
	h=Content-Type:Date:Message-Id:Subject:Cc:To:From:References:
	 In-Reply-To:MIME-Version; b=YwQTbsAwxX2z1IAMJVTgsfiH4E5aiR0N4rHM2aIJOludqPCqJ79Yo7pAY6U1tg4NT8BsdTZLkX9H2fUgG4iFvfdmTaRphfiRX+zioDsY3Bkx8pj6yyBQevH2pbCpsMiJxSsoVOefpXWUiJHC2w/6ChJwda03gEMmzJb+CAV2z98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NI+EJDMr; arc=fail smtp.client-ip=52.101.61.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NI+EJDMr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qEB9EYfpM6XrtiJhLQt5BR/K0o4aFCFAi03ASG+07rjpfxxihQ4N95twrPeac+znx4InXCip1juB5zV3DlABCXiYG9MyLfsbf+5UGixHpKrOuzWek++gSQ4x/mnBQGW6xWlYcA/Siar9XDPwX1+ak0P4NRnwAFMFiBkvKveSF66tZeNzvuj/PNdlt285V/tpxDyEp9x/lqgVw/TCDpMyLgq6BA2jm8xtoYIRbxN5rdFARqVYyg7aQ6W2/Ol5/QMC+f3dchG1R6Ygh5tP4s3uzJqfFsiQMbCajoSlHGlvT5T5PKDEAgklkOVG55v89bALDVeNKtDSFeISbxfo2bQzIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wF1bxOQbi4a9+s6iNAwgCdnObG2CpbRj32aHiozIBeQ=;
 b=ecjHZ38brn+uoH3uXL7QyNKEhjqeamUS0S/hvSzm8M2f4XlKqwsUH0/aRwOwZwUe45BDlOoPoWAuXvCH7T3CbuRtSKPATV+1hHbcBEHJU4cJBSXxnza0v68H91mW0bV5g+86fMPTc16iWJFAwiDjpKPKhieulCVnlvThkAgaPQPg7P59EdTo9BCAyEUVnqs6KpoCD3S1T5pObxPH693rjEHFDMkQxhYmxSa/bE2UoF8GZ5apVBOWgN6Lc82yDuwNWUW1SUJHhvU+gp3g0fhPGKSmW9x8sbvSHMuzMvjo9G60C6UXq1rVBgDuSwP2pcigNjrOSs6vS5qzC3jVOxv7OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wF1bxOQbi4a9+s6iNAwgCdnObG2CpbRj32aHiozIBeQ=;
 b=NI+EJDMr/XvrZ3Ls3jiK3reYqTUg9RAXq6VctDq73r7I/ctQCQOHCPIJZdcNu5+h6+qG4z9VnZOjvNNdPumxtqZCfFGKbwM3T03aPA6mv0aX9AYJbOnciih6zSPE1Wo3stfBcAjZEeDQHUsWK8jk9vBtsrQB5KanjNYIYWzCq9sjFrpYdpgWLXRM6YCbTmja8bnc9dLR2AE/5zSjjy/eVlpvB/Hs8iZgV4UdQE3iMCrbTD7GntkDXKABlAbNEIeprOIcxi5wrz/SbiEK734zah0bOeWg7DRx/Uwiqpk331kDawYeTB71wqf41O64n/CCdQtjd/Kp1EgPeCHmtfybgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by CH8PR12MB9790.namprd12.prod.outlook.com (2603:10b6:610:274::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Tue, 1 Sep
 2026 02:17:03 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%5]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 02:17:03 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 31 Aug 2026 22:17:01 -0400
Message-Id: <DL3MA7GQBXUW.5L0DGZHLFDHW@nvidia.com>
Subject: Re: [PATCH v2 14/14] mm/page-flags: remove PG_private
Cc: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, "Zi Yan"
 <ziy@nvidia.com>, "Baoquan He" <baoquan.he@linux.dev>, "Pasha Tatashin"
 <pasha.tatashin@soleen.com>, "Pratyush Yadav" <pratyush@kernel.org>,
 "Jonathan Corbet" <corbet@lwn.net>, "Jan Kara" <jack@suse.cz>, "Steven
 Rostedt" <rostedt@goodmis.org>, "Masami Hiramatsu" <mhiramat@kernel.org>,
 "Dave Young" <ruirui.yang@linux.dev>, "Shuah Khan"
 <skhan@linuxfoundation.org>, "Mathieu Desnoyers"
 <mathieu.desnoyers@efficios.com>, <kexec@lists.infradead.org>,
 <linux-doc@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
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
 <20260831-remove-pg_private-v2-14-3668159cd9e8@nvidia.com>
In-Reply-To: <20260831-remove-pg_private-v2-14-3668159cd9e8@nvidia.com>
X-ClientProxiedBy: BL1PR13CA0082.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::27) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|CH8PR12MB9790:EE_
X-MS-Office365-Filtering-Correlation-Id: 9270ab8a-7bd6-4fa8-9de4-08df07cf1c83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|921020|10067099003|56012099006|4143699003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	n+1yViA+lU3IrsW7hn38MZ/T9TMXvgsV92owyTW79g2VRkfzxFLlSUOEldjVvYtQDbB3e+Wp1ZAVN4/6fklwbFVXayirbh4Hb3GCuuvVquUL+uiMCXxnwhY2ICFTIw2+FLK/ddwWDQWX4CZf9zR+HzrzEP9qPEW6Sc0QTnUcIwJ9Zjc5t0CA3+8YfpZTrH197l9nqHheTkD+GsnaZW8NbIsVxPYbWOu3yL4C7sunO1QsNaLS2FacEKdm0ADKQV99Y0GjI7zx+YgcVnkl1aWujZV8Y51uGWfDM6IH3AHcl96ToK/ZVnZVn9VnZkAOjuwCl0TCfljqORh+yd/hWAmjfbln9SJ3729S8ovNCxJT3FBWhoAGIwZWDoBetT68TPZ6vg7HO+FpNLJCTLyprGloRRhUtBQha9u95cn+ONJiZc9ofQJsm+ZohDfnRjB2jV5ZM9vh5tx7Ayq8XIoV2N4vg8vQH0Ws03JsCMWpEteSCzL/BHgF0TPU4HkPZf6crbHPpWGbwEvI3aiR7q88MgxC5MuJ4jacRG5qHK+kZcnENQAMr0knhSjfwJcV2ayZ/3y9lAeoL6K4ZV1NXy3Qj1GIxMEh4mk7G5RsTBMQBqkdbOLFv1l66RhnqBhGlJ9QaQTUpmDpbW1m/BmmCQWLgig/14iCw4PUMWffo0Gpjb/3OnQrVFEx2VNK7RdlcaxohZJuuEo1BCtD2/OPZquyjhZtMA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(921020)(10067099003)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VzNOQXZHOWFTWFk3Q3V2QTVjdGN3ZVZ0REdHc2pPNTc0bTJnOFR0K2ZzcU0v?=
 =?utf-8?B?OVFrREZvUUYrdkVXRnBuRktXL1kxQXIyMnR0OXQ4cVhPVktKQXJjMk01ek1u?=
 =?utf-8?B?b1dQQzBvRUl3U1kwVTFoRUVkY0xoOHJOY2cyUTY2L1p1SndUSEJBanBTWkNh?=
 =?utf-8?B?akgxRXJXekFHSHlNMlJ2WnlTaVlGRm1vVm5WYlNtWksyaWJjWWUycCtnVy9w?=
 =?utf-8?B?QWxTVjdSVzlYSUhsVGRDbW5ySGxoTGhkYkxkYjljMk9pNTFqRHBmOUVRNmFH?=
 =?utf-8?B?NkxFbE5nNCtzSmpFZ0h0Q3JaUy9jdStFTnB2RjhmbytvRXdzWklIRU5qaGZm?=
 =?utf-8?B?RkovaGNsdE5zdzI4VGVOVTJnVC9rTHFsL3pPUWFTcXR4czRsYU1mbTVnR21k?=
 =?utf-8?B?cWYwSG5MdzVJZHBWODNtR213ejk2SE9RSHAxMkg5aXI0bTJWS3VyQzRIdTQv?=
 =?utf-8?B?NFE3SzBKdHJ1TnpIS1hvTWtHcDdCR3JISlFyUEhrL1BiMDArZ0JRbkJ6aGZ2?=
 =?utf-8?B?eStTYmFVU0lNN2xUbVYyaHhhOGhwc2orODNNRzlpcnlPaStuU3RFTzF3U0VF?=
 =?utf-8?B?WGJBRS9yL0pBRlBLNTM5eDFFWkJ6MHlSMWlMbTVGY0V5MUJibTRmWmVNWGZn?=
 =?utf-8?B?SnR4aHlHZnhXVVhKcTZMWEtlZU9PeTRLYVVHZHh0MUtDd2svVzI1S21LQkRl?=
 =?utf-8?B?K0E0L3ltQUYvbVdWWHhzNFdRbDlTZEx2MHA5dHdRWHloekVFUm10U1ZUOTdW?=
 =?utf-8?B?ZFEzcm5nZzIvNTBYOUpZbkNXbERFQ01DSXpvbHl1YlVad1d0bFZuY00vOU12?=
 =?utf-8?B?YThsUEhOamZMMEhaR3FkRHI3ODFmRXZ0TXBtem51YTFiR0VwdlFlN3ljOHNz?=
 =?utf-8?B?VWtFcVpZQjgxbDdKR0NWdUV0ZzJRYVJlQm14RGdUV0gxblZJenpDVEYyZXJ3?=
 =?utf-8?B?RFVnNFBtY3VXTjZWREhjUmhQajBOckx4SkJva2o5UDRlbkJkaW8yMjlYRkJI?=
 =?utf-8?B?SHNId1FPTnNqREJIajZtTUwrT2hEZDJuZTZEcC82VTlKNzBPMExTRklTUWo2?=
 =?utf-8?B?WUR2NEJhVnk4bVE3WkZJcHQ1M2lPMHh3bURMVHNhWk50Um9RNVNKT2FiYWU3?=
 =?utf-8?B?V3Fydzh0U01BQnJSd3RaNXdpMWc1U01XSnc3YWR0WnJlYVJKUm50VnczWkZa?=
 =?utf-8?B?UCs4NXJMS2VlV2JnOWoxbnZsRm1sb1haZzB0NkxHeVNuUE83eUMrTnBWNVNV?=
 =?utf-8?B?NlhNdWo0MW1PS0hCeThiN0w4a1RkcG9YUFp6K3FYZUxlUUdjRDBBSUp1ckt0?=
 =?utf-8?B?dk9WMmVXTUM0UkRTZVMxWE1MRG5XTE5lQm16WVZkQ216Z0pZNCsyUW93OTB1?=
 =?utf-8?B?c1pOOEx4OE1jbjU2L3kzbFVHSEY3UlBpcTB2cVRlR0VoNU5pMi9EakxFeC9X?=
 =?utf-8?B?blUyM0d2dnFURzNLZU4zTjQzMURpdGZ0K1JtUnloR1czTk5BVk5XM3NiRE90?=
 =?utf-8?B?Mzc0eFpCZW11R1NoVkF6OFlrb3ROekVJblVaY2xqdlkyQlpMWDFza1BydU42?=
 =?utf-8?B?WWpPS2tpUHlWWnBYaGRnZ2E1Um5ZbXVGZFhyZFYycUI5S2t4QjR3Q3JMN1pv?=
 =?utf-8?B?Tk5Bbm1PeHkwMXp3SHZ4WmFUU3pSNWxCVy80R2hSci9uS21OSFU4N1NsYzlN?=
 =?utf-8?B?MllQRlpvcGpnME5qR0dzU0hyMGFnRHVTNzNmMVBJZlN2a2hrMTUyd0o4L0l1?=
 =?utf-8?B?K3EzRWlaMysrOUV3R3llTUIwdUhHL1FpNGNCZ3NKZVpjVHR6VCtuODRHNzJi?=
 =?utf-8?B?R2tQdWtpcXZEMWNrYnpyMEtaekI0TVJzeEErcDdUbzNzWFRGSDZQWkxGK3N0?=
 =?utf-8?B?T2xKT3JLbFJoWUM1aUE3djRLVGw5R0hMYS9TT0N6Z1IyWkpIQmlKWWpMcmNZ?=
 =?utf-8?B?b01seFhaeTByYmRtUzRMYzJYeThHdWZaVHdmbTlOcmZtMkxtTjg3czYycFB4?=
 =?utf-8?B?cGlNNnBmSmM4VTBYOFg0RzZWQ0R0ZXdsbXdpWCszYjliVFEwSTdsNnFkWmJT?=
 =?utf-8?B?VTRTMUU3bURrQ044ZCtuME4wa1dHVC8zYjd0R0hYRWJMZEZlTGpFSi9QTTR3?=
 =?utf-8?B?YlovajhUaXVzOUlUYXQrVGxlTml3UkV3NjZsUy8vaEJaSUZKQjRaLzJlRDk0?=
 =?utf-8?B?UnJkbUtaNXJ0OXBqSlNWdStxNG0wSXNOTTZWdFRIb1FIUmtDQ3ZKTDdYcGY2?=
 =?utf-8?B?WlBFSUN3ZEdSTVVQekwrYndwb2dHZVhGZ1I3V3BpT0xHc0FSZk5QVGlGV1JH?=
 =?utf-8?Q?TfKvR8mZVZvnWaA7Lh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9270ab8a-7bd6-4fa8-9de4-08df07cf1c83
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 02:17:02.8978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rUXDkbPvoqBcTT6A0UZFNKBDK/GELWsWjC6jEU9RV3xRE6jhvDnmg7WEtbxBgfRz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9790

On Mon Aug 31, 2026 at 3:25 PM EDT, Zi Yan wrote:
> folio->private !=3D NULL indicates a folio carries private data, replacin=
g
> PG_private. All PG_private users are converted. Remove PG_private and
> reserve the space as __PG_folio for future use.
>
> Also update files in Documentation. hugetlbfs_reserv.rst is outdated and
> left unchanged. It should be rewritten.
>
<snip>

> =20
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index 9b585e68127a2..eb2961ed61018 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -44,10 +44,6 @@
>   * Consequently, PG_reserved for a page mapped into user space can indic=
ate
>   * the zero page, the vDSO, MMIO pages or device memory.
>   *
> - * The PG_private bitflag is set on pagecache pages if they contain file=
system
> - * specific data (which is normally at page->private). It can be used by
> - * private allocations for its own usage.
> - *
>   * During initiation of disk I/O, PG_locked is set. This bit is set befo=
re I/O
>   * and cleared when writeback _starts_ or when read _completes_. PG_writ=
eback
>   * is set before writeback starts and cleared when it finishes.
> @@ -105,7 +101,7 @@ enum pageflags {
>  	PG_owner_2,		/* Owner use. If pagecache, fs may use */
>  	PG_arch_1,
>  	PG_reserved,
> -	PG_private,		/* If pagecache, has fs-private data */
> +	__PG_folio,		/* Do not use: reserved for folio identification */

Sashiko asked how to detect leaked filesystem private data during page
free time after PG_private is removed.

Answer copied from RFC:

After the conversion, folio/page should have an elevated refcount whenever
->private is set. That would help detect leaked private data. I tried to
enforce ->private needs to be NULL at page free time[1], but that might
cause trouble for certain use cases.

[1] https://lore.kernel.org/all/20260223032641.1859381-1-ziy@nvidia.com/


--=20
Best Regards,
Yan, Zi

