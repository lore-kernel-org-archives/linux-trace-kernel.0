Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1821FC7;
	Mon, 16 Feb 2026 02:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771207757; cv=fail; b=UPpTtQhTM6XKkg6/6Vjocr55CjEqL1hkXdqgRgaqmyDT/yjzWlC7TC8E5lme45dP2MnSqj4RtVLoGlhYnATV0j4tBbptrerx+/PTvGeUX7wuaP32mNvV4xVYuqDXftondHlko8guYuQsmNizunvlbDD9oZ9DnECHMpf3lKZPniA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771207757; c=relaxed/simple;
	bh=Gy57D0dYkx6mqqYWEMX5PDvtORezVPUOB6Typ0ByUvo=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=JKIE3to2AwipP32yZ5ItT7ycGYiktyImTxZ/3QbXEsqE672muOsVylIwBUQOgvWYXLjld0kHXVIddNTuhyvh01P6ZhuQPOdO7Q2x2g46EB55hjYPyD1IrBdAsrhqR4EF+P09UMyoxneYNtetZlWEL8TiSSXbQ9RUqqlG/wBvZFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bs8EfUWn; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bs8EfUWn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771207755; x=1802743755;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Gy57D0dYkx6mqqYWEMX5PDvtORezVPUOB6Typ0ByUvo=;
  b=bs8EfUWnzIFY2zxfkgzKdFig8tyYmaCkVRKBqwSw5J2bVRCrqKIzSOMO
   wPT2UnNMOMXwFklpqbknt6fZKBSacWD41vrs/e38Q7xpGzQK+BQIBApNq
   HvxX4fYuyAueWZWjS8AA/xb4KN5dQQoYhh1ZYk35j8RYP0Y+ol+AHNrmu
   WLU/11eqOGZzOYaJaSCwPcWb1/IbtsjlOQPqm0S/vxtH2rtC9sA+CdCcx
   TLomA156SoZsgqWil4Ted9FhS6BXHm4rGoOsojHxmyhow6gYn+0or8Ma4
   vyxJorh9KT4/94rqUQX1+wVNTOgYK2un88u9e18XM5GswqfECGCgitCy3
   g==;
X-CSE-ConnectionGUID: ZjzLvf6HRluqtw3fx4XjUg==
X-CSE-MsgGUID: otrTTW1zStG9RHfZjHY5QQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11702"; a="83731750"
X-IronPort-AV: E=Sophos;i="6.21,293,1763452800"; 
   d="scan'208";a="83731750"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2026 18:09:15 -0800
X-CSE-ConnectionGUID: OPsOOZhHSQK5iyG+hOb62g==
X-CSE-MsgGUID: 91wqhvnSTG+e0WCsAb2V7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,293,1763452800"; 
   d="scan'208";a="217501797"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2026 18:09:14 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Sun, 15 Feb 2026 18:09:13 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Sun, 15 Feb 2026 18:09:13 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.65) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Sun, 15 Feb 2026 18:09:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uk2eXKIFFJMayDP7IkqAd7w3CAyYyic5spnRQpLSk70vuB8uBP+XKRSym3CNILtYNqBt69I8TnW7iUSMJjsKBcJkmru3oVC/F3jNsCT+wXQPcIeJQVbzrEOEL+pgxIzcYP0SCqALgsAyNWbjOtYFU7PoEXNVBTu+BpZCOj5Lh1DUaBsNauZpONOiA+0/9fzwGq7OeLAJkKTHe/iYfg6duuZ255E1P2RFx3S4EWtVVMIN5ikBKUgxqJAlII0dKTsFUHoYeKgrc+KdsBjMTvtLvKIf34U71TR90YL352hXFGfTTCe50QCfujebNb3445eKtJLx4xG9tc4i5ktyQ9pJyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pk/ClXEX7ERFdw9NOxAsMVt1wmDNi0ausjWg3KEKnG4=;
 b=vDKFBFV2Kj6P+ROzdE5rJGSPdw290aTYD18TXFFEQvdwxNucWVTEyzhO/sZIIzC3jtcpIZxZbQuMPhd00CUQ4kLBj23j11/EBbfWLTcOy5e17Nf2Iu9iPzJi2z7nDmbXYqKl4II0UQf2ElEy7VeUjJ+kdZPgxDblMkyUpUURl1eVWr3B1MOsMY6hBiYg4Rk2D3fjoWHRP5YOrk4sKNqFsIsDirBuXvCwz7stjtA8YX0rJxUmyfUzfq+0mBYU4GOnrKxuzgLbkAi7PSmWuFkSv5BdnKRmgEyOEYhqYMFm1rPXl1C3WHBy8B1TCsKnzuliHLCQ1+MHmxkEPnjf0PtiKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CH3PR11MB8343.namprd11.prod.outlook.com (2603:10b6:610:180::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 02:09:11 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::e4de:b1d:5557:7257]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::e4de:b1d:5557:7257%5]) with mapi id 15.20.9611.013; Mon, 16 Feb 2026
 02:09:11 +0000
Date: Mon, 16 Feb 2026 10:09:00 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Steven Rostedt <rostedt@goodmis.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
	<akpm@linux-foundation.org>, Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>, Alexei Starovoitov <ast@kernel.org>, "Paul E.
 McKenney" <paulmck@kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linus:master] [tracing]  a46023d561: EIP:do_user_addr_fault
Message-ID: <202602160941.c62658c7-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: s-nail v14.9.25
X-ClientProxiedBy: KU0P306CA0087.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:22::11) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CH3PR11MB8343:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a836a9f-e07b-4443-37eb-08de6d006026
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cHkexueiRWdxh50bimCc9uIP7qQ0F+gN5foLrhMfNkxLryc92SmFlgtAWMgd?=
 =?us-ascii?Q?kv3BjteLNq0taGE/Q6lHpqvHFJ4SS+VZEZAu5uELmbfVeGYkH/z92X6EOCvm?=
 =?us-ascii?Q?b9ZNwETfYcoqfe9fgFqUu2pDTX04E/53do0V71+4nFTdGZIcQXRj8qrc+AVx?=
 =?us-ascii?Q?Yo6lvVPVo57FUeEjLYKsDEx+gfCHF1oEnLN9CtoZpkGfFp/P0c54frgoaGVs?=
 =?us-ascii?Q?KPsW5mHAwGpOKzJLOWFNQLhP63VQfB9Tgl0/WCTaKIZTJmYO2TU6L4ewaca+?=
 =?us-ascii?Q?9/WITTWg3d9E98PsqRUSAZSHkvGzp6ZYBOubj6BTPDazeZl7jH94COqQxVb4?=
 =?us-ascii?Q?M7boOJNyHggVyr0zzuSRT11eX/3JpBjmGP/QlGstImyUXbpLCX/c0dYJLQSv?=
 =?us-ascii?Q?qvPyJNJwKdUXz8tsYFvikkk5y4FGodBWLCtbT+LXVMNj8EOAMegXoSpPJ+6P?=
 =?us-ascii?Q?4WzaCwHCdUKjA4o0UCL/epSKQYEJhCK2NYGdwt2s2zj/+DFu45BLCvWaVuaA?=
 =?us-ascii?Q?j0sSVisuW1PYIeIKm5EN8LHzoI6kNUnOCoYNoAm3VOzatxGAkD8hgSxVKs7Y?=
 =?us-ascii?Q?qA3SE5gkYGprdolRNbGWmwy7kT3FM2XPylzwVWxr2YA4GnN2eiKqCPN8zz2Q?=
 =?us-ascii?Q?v/ghPDSJHciNSQFJh4OhwtC197eip1WGf+U4BfDYQdBPNRipvGd3Y3itpI14?=
 =?us-ascii?Q?4ge0GdNzJqkiU8ni/Gvz7/oP+zHiQyKoXaeECsgdaLaCQklqsGTNlhGodJJ5?=
 =?us-ascii?Q?UXPagLCIggj2gMOBCJQDBhdNG2uTgpYKVqf/xfiR9hV3n2QJPBS3ZSdxaKIE?=
 =?us-ascii?Q?N/08iC2S0xXgPW0lW2jCS3qpWFx5qYRKiPhUmVt7k0osykbvFzx6kumBDown?=
 =?us-ascii?Q?lThHAuWTK3yApmwXTdh1iyBa7ZcEPEEhfE5Q5H3+ZOiBqmWuHsqPb0sqD3Qz?=
 =?us-ascii?Q?/6rtPCHTfbwTXaGVggDPLCD6mpIUGC3y9YZNWnkd06ZighyCNyrT3Kcgbr3g?=
 =?us-ascii?Q?d8qmF19KvXoCCMXhhpy3MADRlwqHJplXz+3HjV65CHTmZAwmE5GtTHFeNazQ?=
 =?us-ascii?Q?FLix74sjB2PdY+zbjlkvi8wH1NXYPyCXmO/UBp3avaLCFxlLsSKc4KU/nquT?=
 =?us-ascii?Q?D6Fpu6MpKQqQFHyGmnSshLsDAz2ZGvN4+3sJDO5fJX7Tmm0a8xhCxAG30Kkt?=
 =?us-ascii?Q?6uPNRpth6d0bezbd5aSSJR4Uc3mqsHoxt8xhSns5qP17wmETcZ7n2razT6FN?=
 =?us-ascii?Q?N7oOoFN+TT1bbNFEi+i9UpCh+5B6oijb7+AsUrZHxoi24sIPKRlHGjBFx5oc?=
 =?us-ascii?Q?NZppJrd09rS34IL+GW5Zf7doASqg0IaC6HI2xaE1NAncu4d3phgJjzPCVeLC?=
 =?us-ascii?Q?MjOt+59nVyYt6sYEjR8rsCVK/9uhWYW2X/Eg50h9ju6X6e0ay726ePc3aaZj?=
 =?us-ascii?Q?ZI8Lr7DcWM0+ftutKV6A7ewkIt1rdTLMpAaU/CZRSDWWfb96ZDyJH3CT/8xM?=
 =?us-ascii?Q?a0k7JY0XfPRjs+xGIFeutP8CeKivhAmosBUnn1E7TFa3x8JoXJ6En61ay9QN?=
 =?us-ascii?Q?WWy/ONgEQceNAbayGQXu5StLZgnNOm48lbl9hFtL?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FzYgJUo+XDo4xbXWr1y5KmqGZHgSuQlPsZ7bR603PdeuUBrRSiLGTipJ9H1U?=
 =?us-ascii?Q?OfS++k3jnl3fvYQbWEMeuumAzIgECIJKCym0anjUZ4DcxfoQImk4glUEWhjO?=
 =?us-ascii?Q?7w7Paw2b8Qg+lkFiuxTaGQzGhYAnzCaY0SvGKCn8aQqdLUDwG5RDVduExG4+?=
 =?us-ascii?Q?EnFa9/V9cFwg03JJGHP/UyAFkxxP2+rMfnN4ZbPgXPYElAiOULKGrW89mnDt?=
 =?us-ascii?Q?6JUMeqNwYmdhBApDdoSpej8xKAjRKUdM83RQPl4XJQe7bYfixxcWdJATI+Oj?=
 =?us-ascii?Q?kgaYBsRA9vbvSmzX4nwHXnrTPmml/B0d3EBQBV0kyztJXpFIRhIhTEtysGAG?=
 =?us-ascii?Q?jIDYuP7ZPlTFXhupaLxfQxAKsHzuVfCH0kDO841rfg083ci++TH1PpcXPwEu?=
 =?us-ascii?Q?jhJV7Wq5MaQBLx3BrlOJ2XBjK+wWlvZ2Z9M61WQuILkfI9s9o7s8IL5H/u1o?=
 =?us-ascii?Q?8BxxhQxN6zLhmo423xRuNP9hOl6m77UNj08RQMPLlcylQfGiZqTUTH0RdPva?=
 =?us-ascii?Q?oH6FzBVuxchFdPTYIPplNWnhlaPAehjAmv1gG4xfj/AiEfqee8FwGodcYd5z?=
 =?us-ascii?Q?tsozF+OQf0zFtFvWCPnp3/2YxculPlxRZGsnreArfO7oZj8HDO0hyI4s+5lk?=
 =?us-ascii?Q?tb2NRCcxROHr+misK8nUX+ysBPcwNGBDaMGVZxCNf3NQmfjuZaZx7g6XCviT?=
 =?us-ascii?Q?5qosuws9koc8laqqbvMtrri6ep3FdZ7e5Rt6Psm1eaV8PI0cbEYRGk5rcLRY?=
 =?us-ascii?Q?dW5jNU57InFgyUM2lHyqaY4N0gcT/aAM4f7o243wcuJE4IVVRDavlg8miXhn?=
 =?us-ascii?Q?unPYOuVIch4uvN7SGDFwaV33BlzNdJuiaFc6fI+Vu+Kq1GygaYJ6wGN1ETP+?=
 =?us-ascii?Q?Tj4agSBJayFgmmMpV1SPYUOz23D+nTcn/krsPceUHH7XR0tt2HLogTBqB0zu?=
 =?us-ascii?Q?YBSeSvFS5HqQINm/8M4W1FQqazAX4O4ZR4XOinmoIAioIN/OxR9vHGI+18z9?=
 =?us-ascii?Q?DbNU7DmG6SHjeGtf4lR1xtK4nf0OXJF+XIWkXwZGoTZJWfF9neWyk2vcMwph?=
 =?us-ascii?Q?NQ97xQQBA/iIOFXPRTz7GloksKcgHlKaPyTRCHgRCCYFyuII29B3nXK5nlTb?=
 =?us-ascii?Q?E+oHWuYBpmNLw7WZKaH577XGS1hV3lO744S/aTqTM2DnWtZWLm492DdJgNji?=
 =?us-ascii?Q?lb30gDkOSbj90TOKEuW+DHxhV6cQtFW0K+lyMMZjAEhM6nL9dQEyeWz8hup6?=
 =?us-ascii?Q?QpwqbOs/OmiWtz25Qz6w87ipKWCIO5DJzUevgwwBZNrUjzsu28d8i1pI1yf3?=
 =?us-ascii?Q?9ey65lSPwG0NhRv85t8jjmKe/nztQwl7dJBkMf1giiIJHx2D/MwvOnEbzuvg?=
 =?us-ascii?Q?LNPuZNo/Yxy28Ef3L83C7uRK5T1PQUynnn+BjYQpwUC/76P5vlPjEtvIGZ3M?=
 =?us-ascii?Q?pQSHCV67XTsJO+W1U23RCZlAnZ6Inbollx7D4x1W61P4ooZgCTPyflCSywF+?=
 =?us-ascii?Q?5VsPHF3nC1dZsOzB4Ni4xSE5sFwnnvi4kqCVpE+kh3cdhjmAFLk+R+phFkHy?=
 =?us-ascii?Q?oekhO72BhvpuanaRGewFyKPwS7p0BSENf7H4tjGiXrwc3rijjfmZq3AtED+G?=
 =?us-ascii?Q?dVNHUlgdn+kl+tBte8bny72G4TtxqYWlvgftuCFV36fpyrLb8MRPTaz5t7HO?=
 =?us-ascii?Q?EQ8uDABuJ0QOj/8p+QqvmGGiFcNL79RgO8/i9p3eh8MBHbj1LJgGZcJrx39E?=
 =?us-ascii?Q?WzTCMmStyA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a836a9f-e07b-4443-37eb-08de6d006026
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 02:09:11.4740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yHVUr1xDrMM0kS2sHfvwC1IkAzgbbnnq0yYk8b0zlzTOZ/wVBTTMzpOZF/UsNjX5Mx1OFZOWQE+R89qPNYBBAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8343
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "EIP:do_user_addr_fault" on:

commit: a46023d5616ed3ed781e56ca93400eb9490e3646 ("tracing: Guard __DECLARE_TRACE() use of __DO_TRACE_CALL() with SRCU-fast")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master      ca4ee40bf13dbd3a4be3b40a00c33a1153d487e5]
[test failed on linux-next/master 635c467cc14ebdffab3f77610217c1dacaf88e8c]

in testcase: boot

config: i386-randconfig-001-20260215
compiler: clang-20
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 32G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+---------------------------------------------+------------+------------+
|                                             | a77cb6a867 | a46023d561 |
+---------------------------------------------+------------+------------+
| EIP:do_user_addr_fault                      | 0          | 18         |
| EIP:do_int80_syscall_32                     | 0          | 18         |
| BUG:kernel_NULL_pointer_dereference,address | 0          | 15         |
| Oops                                        | 0          | 18         |
| Kernel_panic-not_syncing:Fatal_exception    | 0          | 18         |
| BUG:unable_to_handle_page_fault_for_address | 0          | 3          |
+---------------------------------------------+------------+------------+

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202602160941.c62658c7-lkp@intel.com



[    3.833434][   T59] ------------[ cut here ]------------
[    3.834088][   T59] WARNING: arch/x86/mm/fault.c:1274 at do_user_addr_fault+0x387/0x480, CPU#1: modprobe/59
[    3.835108][   T59] Modules linked in:
[    3.835140][   T59] CPU: 1 UID: 0 PID: 59 Comm: modprobe Tainted: G                T   6.19.0-rc7-00020-ga46023d5616e #1 PREEMPT(lazy)
[    3.835140][   T59] Tainted: [T]=RANDSTRUCT
[    3.835140][   T59] EIP: do_user_addr_fault (ld-temp.o:?)
[    3.835140][   T59] Code: ff ff 89 f9 89 da ff 75 f0 e8 15 01 00 00 83 c4 04 e9 03 fe ff ff 89 f9 89 da ff 75 f0 e8 01 49 f6 ff 83 c4 04 e9 f7 fc ff ff <0f> 0b 89 f9 89 da ff 75 f0 e8 eb 03 00 00 83 c4 04 e9 d9 fd ff ff
All code
========
   0:	ff                   	(bad)
   1:	ff 89 f9 89 da ff    	decl   -0x257607(%rcx)
   7:	75 f0                	jne    0xfffffffffffffff9
   9:	e8 15 01 00 00       	call   0x123
   e:	83 c4 04             	add    $0x4,%esp
  11:	e9 03 fe ff ff       	jmp    0xfffffffffffffe19
  16:	89 f9                	mov    %edi,%ecx
  18:	89 da                	mov    %ebx,%edx
  1a:	ff 75 f0             	push   -0x10(%rbp)
  1d:	e8 01 49 f6 ff       	call   0xfffffffffff64923
  22:	83 c4 04             	add    $0x4,%esp
  25:	e9 f7 fc ff ff       	jmp    0xfffffffffffffd21
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	89 f9                	mov    %edi,%ecx
  2e:	89 da                	mov    %ebx,%edx
  30:	ff 75 f0             	push   -0x10(%rbp)
  33:	e8 eb 03 00 00       	call   0x423
  38:	83 c4 04             	add    $0x4,%esp
  3b:	e9 d9 fd ff ff       	jmp    0xfffffffffffffe19

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	89 f9                	mov    %edi,%ecx
   4:	89 da                	mov    %ebx,%edx
   6:	ff 75 f0             	push   -0x10(%rbp)
   9:	e8 eb 03 00 00       	call   0x3f9
   e:	83 c4 04             	add    $0x4,%esp
  11:	e9 d9 fd ff ff       	jmp    0xfffffffffffffdef
[    3.835140][   T59] EAX: 80000000 EBX: 00000000 ECX: 4324aef7 EDX: 431f7ada
[    3.835140][   T59] ESI: 52cb2000 EDI: 52cb5f34 EBP: 52cb5f14 ESP: 52cb5ef0
[    3.835140][   T59] DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068 EFLAGS: 00210046
[    3.835140][   T59] CR0: 80050033 CR2: 00000004 CR3: 1275e000 CR4: 000406b0
[    3.835140][   T59] Call Trace:
[    3.835140][   T59]  ? debug_smp_processor_id (ld-temp.o:?)
[    3.835140][   T59]  ? trace_page_fault_kernel (ld-temp.o:?)
[    3.835140][   T59]  ? exc_page_fault (ld-temp.o:?)
[    3.835140][   T59]  ? pvclock_clocksource_read_nowd (ld-temp.o:?)
[    3.835140][   T59]  ? entry_INT80_32 (arch/x86/entry/entry_32.S:945)
[    3.835140][   T59]  ? handle_exception (arch/x86/entry/entry_32.S:1048)
[    3.835140][   T59]  ? entry_INT80_32 (arch/x86/entry/entry_32.S:945)
[    3.835140][   T59]  ? xas_find_conflict (ld-temp.o:?)
[    3.835140][   T59]  ? pvclock_clocksource_read_nowd (ld-temp.o:?)
[    3.835140][   T59]  ? do_int80_syscall_32 (ld-temp.o:?)
[    3.835140][   T59]  ? pvclock_clocksource_read_nowd (ld-temp.o:?)
[    3.835140][   T59]  ? do_int80_syscall_32 (ld-temp.o:?)
[    3.835140][   T59]  ? entry_INT80_32 (arch/x86/entry/entry_32.S:945)
[    3.835140][   T59] irq event stamp: 5220
[    3.835140][   T59] hardirqs last  enabled at (5219): free_to_partial_list (ld-temp.o:?)
[    3.835140][   T59] hardirqs last disabled at (5220): do_int80_syscall_32 (ld-temp.o:?)
[    3.835140][   T59] softirqs last  enabled at (2722): __do_softirq (ld-temp.o:?)
[    3.835140][   T59] softirqs last disabled at (2713): __do_softirq (ld-temp.o:?)
[    3.835140][   T59] ---[ end trace 0000000000000000 ]---


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260216/202602160941.c62658c7-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

