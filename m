Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17731AB523;
	Tue, 10 Dec 2024 14:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733840330; cv=fail; b=KBlyaSMnTMRP0mJR2xGfmsqjl5Ka0M0/SGMzOMamON6nOPtsLsVVCIq0E8VtfOjpFIbyoXeGY7jW3aq2WVqy3rv6Mk6Ulssj2Ut+0egx4U3cjr0v4n16pGaxe9ugp4flDszXM1a8b9CGW1xZ/FR3i2VVRzuX89NJsgmgptGOMG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733840330; c=relaxed/simple;
	bh=tB53kTwC1fOVYG56AxPxfTZ1rlCpCb2r0OW8ck23SLI=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=dWtwAbv8bsLXGTEncZNV6HitRrQNfP/kehWfLYL1f6hSgARuFw6R66D4GTDYGsNZyirZNMCTmmRQ74rFy5BmOyUPkA1pB7AJvXDBhjnyiAIecSzjbIzyBVJBTXk64TuEytDM718hLk032OqN1iTTvSSlnehd40yLWlDJBL3+3hY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jcuGSMuC; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jcuGSMuC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733840319; x=1765376319;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=tB53kTwC1fOVYG56AxPxfTZ1rlCpCb2r0OW8ck23SLI=;
  b=jcuGSMuC+icVl+RNah54vZlO3tBP8SLF5NoGCrC3ErEQ0Sjempc4a7iC
   SUEEVhWtrdE8AV/PfyyQVnwp7cx6V/aZgkqX72qwQiDAwWvGryACEDlzg
   sxCU99P7OKHrk3tkt3coOI5djlbwDk2IcPSegG4QdaJgTwxRQdmUTip0S
   MjV7IeMO7B7co25j2QQVblKcsw02ePxeC1Ci9E9HfTgJRkTMYcfyWYIGn
   Re0xr2uQsWKhoiaFHkUKZ8oYFjthTEHFK/SnQUverJbJ/rKyO//sb/FC9
   DMAvmHvEgXHnBYaZtG8jXYDKsA+mC0R+lf/+mwMy0J4rX7lMSwTL6NP3D
   g==;
X-CSE-ConnectionGUID: zSxrHi6yQsC8NEHPH1MFAA==
X-CSE-MsgGUID: lMqUB8W5TNO5WEzaYwmzZQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="44655754"
X-IronPort-AV: E=Sophos;i="6.12,222,1728975600"; 
   d="scan'208";a="44655754"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 06:18:36 -0800
X-CSE-ConnectionGUID: 9jxnWxpHR7K7nCafteXoNw==
X-CSE-MsgGUID: +wCqL5rnRou+Em40GBppcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,222,1728975600"; 
   d="scan'208";a="95256852"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Dec 2024 06:18:35 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 10 Dec 2024 06:18:35 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 10 Dec 2024 06:18:35 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.49) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 10 Dec 2024 06:18:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AnRnU0qjgmIKoCUt8E/1Ia6rOUTEHvKnWW781YthtGji3i9W7FKYMj0BadXRAOye05a8M4AwnvCx0IOphvjXP7nUOX9OlOCfP7EQQfhzIFo0xgAwR2f8SCYxVBBOt/L1QH04AA4DFaIjaMM3T/bZf5y1UgVqs7YGC8D7ja7rtVbVzOaektQwm+yRw/atJfeF/wBw+Ji4cuqtCKo14h08O7te96FZv97+XivPXNk490jEagxwCpIEEsjsvd+/wh68UPYwM2HXR26oOAmHTi/s1weC+yymiLaCEmvdty7UjLTpKKOtCP/oJcOyDcVtxsQtoWq/Cm9gomkwE6ddKg4pVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aXSAOpK1DMlUaMlj3OerfEMZrRkms4CXGWbYgPFYkgI=;
 b=sSZOacyGd2+MGaf9yPoGuLQ7521lH2/5B9yvPE3oKVGcOEYhdye1Tujnx0c3pQUeAdDcd7ZJIAlJQwCCu+nBsKijYrXthmxtf6C/YBFqRnJtFL4FGA0pxt0kSGCDHDFrcaLFukCFXe6cdGtOhxHbTL4BAbVLsjfq0XIH7DDLfZAv8rS/hN+A3F2MKF9dBbNUBQgWTKHSUIJXJvCXxslH5j9af1/LVKmw7BV216nH/+DZO4gbl0qUl4sDktJZUthTeUNsNc8UeyYrF02+H+mQdeqMJ8qx4UjSfmygUq0Gi91W/rtwa81fqOeJQ0+9Ojc87qhFIS0OBebgGa2TY1V7UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by IA0PR11MB7933.namprd11.prod.outlook.com (2603:10b6:208:407::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Tue, 10 Dec
 2024 14:18:30 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%6]) with mapi id 15.20.8251.008; Tue, 10 Dec 2024
 14:18:30 +0000
Date: Tue, 10 Dec 2024 22:18:21 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Andrii Nakryiko <andrii@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, Oleg Nesterov <oleg@redhat.com>,
	<linux-trace-kernel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linus:master] [uprobes]  87195a1ee3:  stress-ng.uprobe.ops_per_sec
 -13.3% regression
Message-ID: <202412102244.92ff3a6a-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::14) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|IA0PR11MB7933:EE_
X-MS-Office365-Filtering-Correlation-Id: 82ef5922-de3d-413b-db6e-08dd19258558
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?phlLEffPxm45iyqLp6fKU3UA+n1NGpRnKiF/fzMbSZudpJljz2HoXDtmgg?=
 =?iso-8859-1?Q?NJZpyLA8PbNIgAnixqct+VhBGs8ba/GmYkuZQkBq0YK1vyjmilY4i6GIlB?=
 =?iso-8859-1?Q?hg5NOEy2Cy/HTmHl1fb1mnZI4sfGEmjzE82E3qqsqmztr2bPPX7tV1UY2+?=
 =?iso-8859-1?Q?oOQH05A3VU+bN0GLOE9zZ0gFgwzuLCTp9tCYgqN1nxDzjjukQ8G0e99+Pj?=
 =?iso-8859-1?Q?pVlWG48ufyTANb7I1DWzDXcnzGpmlX/40dQwsPfl3GXpA7sKIonFkatwII?=
 =?iso-8859-1?Q?Q7n5d6IztePxPu4MAvGMkBZKTcejJnf4IjVBBYsueNyFR3JJBoUAZJLouw?=
 =?iso-8859-1?Q?wgzxnAuH8NoiFezIse35hd2njuspDV3C2mcEKB068bMQZUC7sA+E4i2ku3?=
 =?iso-8859-1?Q?u73EW1LqRbzRn/WmZS20H2CDxLoP/b26VE4NmlLdZ1IxYPHfs/FgYWw5jM?=
 =?iso-8859-1?Q?pyUudraXVpglnxw7XcBr6kr/PRAlGVSbbMwShlt1v2P2H8Jg6DEA50XfnA?=
 =?iso-8859-1?Q?/8eM+g21hwaxox5yi5y6zhBOHiF7LWiSZISHE2RGyuVTxHmGw5rXdgJXmk?=
 =?iso-8859-1?Q?aSuQ7Amuu6aSnrwr/ANZWtPbgRa7IKbXZC4tzYVbi6x8sisBFjke49WSKz?=
 =?iso-8859-1?Q?TtUJhuNQaV5kQ2EkgZmdx5Sr/3v5gAV4Qz5olQns6cQ5sfSrHjKEuhJMjR?=
 =?iso-8859-1?Q?1rGrvbeyOx0vWH0Bu4IlsOW214RmgJ8BGyJnFPz9oGYpY9ZTqqudJ9d3H6?=
 =?iso-8859-1?Q?GFLtInwRlOoWM3m8S4/IAVQNDwXf21Xq3fHBJOWFYV5r5H7WSQv/i4vhPV?=
 =?iso-8859-1?Q?Ud19dBdatluRy047P1FwWd7csw40lfo8VyEclTgtZj4KZk1kr6WgSbzVL8?=
 =?iso-8859-1?Q?LNeTorQo0317bS0chWQWyGgvjGhmBMeBi9i7yt4CELEcFj5T6oyGDDlKwp?=
 =?iso-8859-1?Q?g+Dy15XU9Z/uYU0KkualgvAiJvOui/Y9cJupow3gdI2Wu5ot2dnw6TNsPJ?=
 =?iso-8859-1?Q?HDQWvDHC5Zf+jyWncx3M4FZFvmw9hskflqrEsqJu41GZ81+Q0LNgecLUJ/?=
 =?iso-8859-1?Q?6Oz5ESZe0gr6n9RadAZ0COcY3yBktkWza2VS8fJ9BRTz6hnnY0rU9zLssE?=
 =?iso-8859-1?Q?pq2aUOq/Qi8PcMH+rkfOR0Syy1k6P4x7yGOrHmE5jSfFrlLIPFpVBxBu/p?=
 =?iso-8859-1?Q?iis3/vR38jhsCPSze66Bnu9YUrABWYk5+5QoW2axE2Be/x4a7DUeajewBe?=
 =?iso-8859-1?Q?WsD4FCBT+IvYS/ADSlqxfbChNBALQMSwTQ1kYgKBF6ZpEitkEOunWkrFjP?=
 =?iso-8859-1?Q?84I+pSzGmO6wSHNGq6nUY6oPifCz72cNjKl6xhIiwisWcwngj62wN678PT?=
 =?iso-8859-1?Q?zegBV2tQon58TUvCRPVpcOtLMn5L5vIXGrZyGKfUZN80HgfyNq95Y=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?N6x243uAlUzZIn/9PkaOL9lyR38lYZjOfYzsECULfUiBwJ00dGBES7uSG9?=
 =?iso-8859-1?Q?mC4NbQc6FcHdcDZ5bIdWMCTuoESfL/Uu4PT7ae4gEKjMps29U6q18Vwqs+?=
 =?iso-8859-1?Q?wQUhgr4vIq9q4D7tFhhKK5LfUKS7+Pn32lU0Y/9HxBSb4SoGpeKyYc2DWA?=
 =?iso-8859-1?Q?fZneqEQsVS1CZVA8oVc1vQ5pLVfT0S7Q9SkH52tKR2ZuVg/Lz7/YI0mcfe?=
 =?iso-8859-1?Q?VHUB/PQ8rYVV9jV6jSsFUw8hwDxze5tFJicnCNZ5PkpOGVKoViattyv4zA?=
 =?iso-8859-1?Q?qleI5m7ybVWnG1n9nKgAyEdnKLOHRcLbdaobt7wOp+vjMFq76YX6Z/QFaO?=
 =?iso-8859-1?Q?Kt3Tfrq6fo4hxkcnp9ltVWGgKSn2hvKHIfvakJfIFv0rJXFuVwLlFZ5o//?=
 =?iso-8859-1?Q?dL76ITvgcBz3XWk4dLhzt7cWjvEjvB6/sbzyrujDR9tbZXgOyxFaOPC73b?=
 =?iso-8859-1?Q?EwnBIVY03vG7rx9JHyLJ7nypC/Iz3vWwu8JbfjebRW4Xjgu0OV0yP9Wqs+?=
 =?iso-8859-1?Q?I170vzrmqGnq3ovCPtBfc87Z4daTPz0lijVGTpsmivWn1YhhMofXEXMQUN?=
 =?iso-8859-1?Q?kCvzeX59hV+XXHL8GG+PsuGzFfFJ3z/+1kt8zfAa/lG2JJ/o3CcrOwHLBH?=
 =?iso-8859-1?Q?4biJ2/9J2Wuk489m8h7dzjzEFMPxSRXv4NhV6EdtfAL+K9Nx/mF+7fpToG?=
 =?iso-8859-1?Q?T+yN7UCneqyQAoWrQ3XPty1U7kOpKQKr487qDTxLW5ybZgSQdXmrLtea3Y?=
 =?iso-8859-1?Q?YHKrlh/DNKeoVvx3vFpPF0VrErPDV4RICeoNE1/zoSW6cG2wbwUCVrgRKL?=
 =?iso-8859-1?Q?gBsMQOkz86tAa/DLGp+FuHDrBlvCULioqEHN/2EqQnC2u+izxsZ17hhPpq?=
 =?iso-8859-1?Q?83GPA0QC9gw6D19aEK5C+ehHVTkn2VB30SEvbVLOJ+UAbpb15zTLKPe7d+?=
 =?iso-8859-1?Q?I3LyRpbC+BbV6TRXH3FYAH+6PkE0SdqVF9V4EruDRYHpebs5yF9uDUZGNp?=
 =?iso-8859-1?Q?3WvBRgzG0RyFHyzJwfRJM6iK6lIAoIQ7WtkXslikcOQo9rIPLQ6gFJU8x+?=
 =?iso-8859-1?Q?g+GI8pZuF8dEQqtu2EhpxFeqlv6ZEku02rGKb9T7Lxd6KmI5IfpnZ2eehp?=
 =?iso-8859-1?Q?l8jI8TbO3r/DG5Zl8vGd3agTz8x5datNr4GxoS4Ltlkr+KnfbZvD/Mp5oh?=
 =?iso-8859-1?Q?e9qD1CDza6loeTuzXuZQQLCcw1KHS/AFRrpEvOJNScXZ0OKEynD/aauIDV?=
 =?iso-8859-1?Q?oZ/PaYe05xiK6etwOJEAXKO97dyjVhw5Jkad4CHVZNMcmPLp3BiwPVKCVf?=
 =?iso-8859-1?Q?aGl2EAujA91YRqEqmhsorWaVepvc/Cyjn565LWVpA6hMarUUZwDbwm0I1Y?=
 =?iso-8859-1?Q?jxKzHJg7Pjj5FnhZBdk8gLf3qFbqyIcL8HMi+6/733X+lLuxFML7Jg1WDh?=
 =?iso-8859-1?Q?oItA8H3MDfQmTwGmTqgyUsaDQ0ZNp1zIOL+kY5Qfpm5cLgTQUM2n4eeohJ?=
 =?iso-8859-1?Q?U1bjn6JIUvyVG8pUFQClun3VdbIhzYDYsHo/bSiiUQ38rMzrDEioKe1HjJ?=
 =?iso-8859-1?Q?2ipjpU9ozmT12eEFyALhazfy55NXjy2qWl6DERykom2l+yBzpue5H1AoNL?=
 =?iso-8859-1?Q?h88FOjvwmeFhLafSbEO77TeqP7UlWAkgEJlE1OvNDdMz33j406iWoywQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 82ef5922-de3d-413b-db6e-08dd19258558
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 14:18:30.4343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Hb/xLAwlkyh4LWDVUQO8weuPELI0SHHpf9K7vR4ed/1pFL48nB4QJInx0/Jv40bCT7liyNmHoDwMl+m5qhfOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7933
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a -13.3% regression of stress-ng.uprobe.ops_per_sec on:


commit: 87195a1ee332add27bd51448c6b54aad551a28f5 ("uprobes: switch to RCU Tasks Trace flavor for better performance")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master      b5f217084ab3ddd4bdd03cd437f8e3b7e2d1f5b6]
[test failed on linux-next/master ebe1b11614e079c5e366ce9bd3c8f44ca0fbcc1b]

testcase: stress-ng
config: x86_64-rhel-9.4
compiler: gcc-12
test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
parameters:

	nr_threads: 100%
	testtime: 60s
	test: uprobe
	cpufreq_governor: performance


In addition to that, the commit also has significant impact on the following tests:

+------------------+---------------------------------------------------------------------------------------------+
| testcase: change | stress-ng: stress-ng.uprobe.ops_per_sec -16.3% regression                                   |
| test machine     | 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 512G memory |
| test parameters  | cpufreq_governor=performance                                                                |
|                  | nr_threads=100%                                                                             |
|                  | test=uprobe                                                                                 |
|                  | testtime=60s                                                                                |
+------------------+---------------------------------------------------------------------------------------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202412102244.92ff3a6a-lkp@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20241210/202412102244.92ff3a6a-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/x86_64-rhel-9.4/100%/debian-12-x86_64-20240206.cgz/lkp-icl-2sp8/uprobe/stress-ng/60s

commit: 
  v6.12-rc2
  87195a1ee3 ("uprobes: switch to RCU Tasks Trace flavor for better performance")

       v6.12-rc2 87195a1ee332add27bd51448c6b 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
   2866935           -10.9%    2554200        cpuidle..usage
     47730           -10.5%      42715        vmstat.system.in
    260.00 ±  9%     -17.9%     213.33 ± 11%  perf-c2c.DRAM.remote
    206.17 ± 10%     -20.3%     164.33 ± 13%  perf-c2c.HITM.remote
     18419 ± 20%     +50.6%      27744 ± 19%  sched_debug.cpu.nr_switches.max
      3339 ±  6%     +36.0%       4539 ± 20%  sched_debug.cpu.nr_switches.stddev
     66728 ± 15%     -44.8%      36856 ± 30%  numa-numastat.node0.other_node
    257817 ± 10%     -26.2%     190235 ± 13%  numa-numastat.node1.local_node
     30764 ± 32%     +88.6%      58030 ± 19%  numa-numastat.node1.other_node
    116664           -10.4%     104570        stress-ng.time.minor_page_faults
     45306            -5.9%      42620        stress-ng.time.voluntary_context_switches
   1254359           -13.3%    1087389        stress-ng.uprobe.ops
     20905           -13.3%      18120        stress-ng.uprobe.ops_per_sec
    543954 ± 23%     -44.0%     304705 ± 43%  numa-meminfo.node0.Active
    543954 ± 23%     -44.0%     304705 ± 43%  numa-meminfo.node0.Active(anon)
    226185 ± 57%    +106.0%     465960 ± 28%  numa-meminfo.node1.Active
    226185 ± 57%    +106.0%     465960 ± 28%  numa-meminfo.node1.Active(anon)
    201571 ± 69%    +112.8%     428867 ± 27%  numa-meminfo.node1.AnonPages
    607244            -4.7%     578484        proc-vmstat.numa_hit
    509750            -5.1%     483596        proc-vmstat.numa_local
     97492            -2.7%      94886        proc-vmstat.numa_other
    645262            -4.7%     615181        proc-vmstat.pgalloc_normal
    618833            -6.0%     581768        proc-vmstat.pgfree
    135883 ± 23%     -44.0%      76030 ± 43%  numa-vmstat.node0.nr_active_anon
    135883 ± 23%     -44.0%      76029 ± 43%  numa-vmstat.node0.nr_zone_active_anon
     66728 ± 15%     -44.8%      36856 ± 30%  numa-vmstat.node0.numa_other
     56553 ± 57%    +105.8%     116390 ± 28%  numa-vmstat.node1.nr_active_anon
     50403 ± 69%    +112.7%     107213 ± 27%  numa-vmstat.node1.nr_anon_pages
     56553 ± 57%    +105.8%     116390 ± 28%  numa-vmstat.node1.nr_zone_active_anon
    257605 ± 10%     -26.1%     190264 ± 13%  numa-vmstat.node1.numa_local
     30764 ± 32%     +88.6%      58030 ± 19%  numa-vmstat.node1.numa_other
      2.70            +0.1        2.77        perf-stat.i.branch-miss-rate%
   9507785            -2.8%    9243135        perf-stat.i.cache-references
      1.97            -1.9%       1.93        perf-stat.i.cpi
 3.299e+09            -3.3%   3.19e+09        perf-stat.i.cpu-cycles
      0.72            +1.7%       0.74        perf-stat.i.ipc
      4.94            +0.1        5.00        perf-stat.overall.branch-miss-rate%
      1.02            -2.4%       0.99        perf-stat.overall.cpi
      0.98            +2.5%       1.01        perf-stat.overall.ipc
   9389445            -3.1%    9097600        perf-stat.ps.cache-references
 3.264e+09            -3.7%  3.143e+09        perf-stat.ps.cpu-cycles
      0.00 ± 17%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_timeout.__wait_for_common.__synchronize_srcu.part.0
      0.54 ±105%     -93.5%       0.04 ± 43%  perf-sched.sch_delay.max.ms.__traceiter_sched_switch.__traceiter_sched_switch.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      0.01 ± 12%     -28.3%       0.01 ± 13%  perf-sched.sch_delay.max.ms.__traceiter_sched_switch.__traceiter_sched_switch.rcu_gp_kthread.kthread.ret_from_fork
      0.01 ± 28%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_timeout.__wait_for_common.__synchronize_srcu.part.0
    163.60 ± 13%     +37.3%     224.63 ± 15%  perf-sched.wait_and_delay.avg.ms.__traceiter_sched_switch.__traceiter_sched_switch.pipe_read.vfs_read.ksys_read
     55.03 ± 24%     +45.0%      79.79 ±  8%  perf-sched.wait_and_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
    214.95 ± 10%     -16.7%     178.97 ± 11%  perf-sched.wait_and_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      9.43 ± 35%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.schedule_timeout.__wait_for_common.__synchronize_srcu.part.0
      8.03 ±  2%    +143.9%      19.59        perf-sched.wait_and_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.__wait_rcu_gp
      3.43           +28.3%       4.40        perf-sched.wait_and_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      1194 ±  2%     -17.8%     981.83 ±  5%  perf-sched.wait_and_delay.count.__traceiter_sched_switch.__traceiter_sched_switch.do_nanosleep.hrtimer_nanosleep.common_nsleep
    148.67 ±  2%     -11.9%     131.00        perf-sched.wait_and_delay.count.__traceiter_sched_switch.__traceiter_sched_switch.rcu_gp_kthread.kthread.ret_from_fork
     10.33 ± 27%     -37.1%       6.50 ± 34%  perf-sched.wait_and_delay.count.__traceiter_sched_switch.__traceiter_sched_switch.schedule_hrtimeout_range_clock.do_poll.constprop
     54.17           -26.8%      39.67 ± 44%  perf-sched.wait_and_delay.count.__traceiter_sched_switch.__traceiter_sched_switch.schedule_hrtimeout_range_clock.do_select.core_sys_select
    195.50 ±  7%     -14.6%     167.00 ±  6%  perf-sched.wait_and_delay.count.__traceiter_sched_switch.__traceiter_sched_switch.schedule_timeout.__wait_for_common.wait_for_completion_state
    314.00 ±  2%     -13.2%     272.67 ±  3%  perf-sched.wait_and_delay.count.__traceiter_sched_switch.__traceiter_sched_switch.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread
    334.00 ±  6%     -22.3%     259.67 ±  7%  perf-sched.wait_and_delay.count.__traceiter_sched_switch.__traceiter_sched_switch.worker_thread.kthread.ret_from_fork
    838.33 ±  2%     +28.7%       1079 ±  6%  perf-sched.wait_and_delay.count.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
     29.17 ± 46%     +57.7%      46.00 ±  2%  perf-sched.wait_and_delay.count.schedule_preempt_disabled.__mutex_lock.constprop.0.register_trace_uprobe
     54.50          -100.0%       0.00        perf-sched.wait_and_delay.count.schedule_timeout.__wait_for_common.__synchronize_srcu.part.0
    270.50           +22.1%     330.33        perf-sched.wait_and_delay.count.schedule_timeout.__wait_for_common.wait_for_completion_state.__wait_rcu_gp
    662.17           -10.6%     591.67        perf-sched.wait_and_delay.count.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
    119.31 ±153%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.schedule_timeout.__wait_for_common.__synchronize_srcu.part.0
     23.48 ±  2%    +443.7%     127.66 ±  9%  perf-sched.wait_and_delay.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.__wait_rcu_gp
    163.59 ± 13%     +37.3%     224.63 ± 15%  perf-sched.wait_time.avg.ms.__traceiter_sched_switch.__traceiter_sched_switch.pipe_read.vfs_read.ksys_read
     55.02 ± 24%     +45.0%      79.79 ±  8%  perf-sched.wait_time.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
    214.95 ± 10%     -16.7%     178.96 ± 11%  perf-sched.wait_time.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
      9.43 ± 35%    -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.__synchronize_srcu.part.0
      8.03 ±  2%    +143.9%      19.58        perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.__wait_rcu_gp
      3.42           +28.3%       4.39        perf-sched.wait_time.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
    119.30 ±153%    -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_timeout.__wait_for_common.__synchronize_srcu.part.0
     23.48 ±  2%    +443.7%     127.65 ±  9%  perf-sched.wait_time.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.__wait_rcu_gp
     94.57            -4.7       89.83        perf-profile.calltrace.cycles-pp.asm_sysvec_call_function.acpi_safe_halt.acpi_idle_do_entry.acpi_idle_enter.cpuidle_enter_state
      6.44            -0.3        6.09        perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      6.43            -0.3        6.09        perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      6.44            -0.3        6.10        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      6.44            -0.3        6.11        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
      6.46            -0.3        6.13        perf-profile.calltrace.cycles-pp.write
      2.94            -0.2        2.75 ±  2%  perf-profile.calltrace.cycles-pp.trace_parse_run_command.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.19 ±  2%      -0.2        1.01 ± 21%  perf-profile.calltrace.cycles-pp.on_each_cpu_cond_mask.text_poke_bp_batch.text_poke_bp.__static_call_transform.arch_static_call_transform
      1.18 ±  2%      -0.2        1.00 ± 21%  perf-profile.calltrace.cycles-pp.smp_call_function_many_cond.on_each_cpu_cond_mask.text_poke_bp_batch.text_poke_bp.__static_call_transform
      2.81            -0.2        2.66        perf-profile.calltrace.cycles-pp.dyn_event_release.trace_parse_run_command.vfs_write.ksys_write.do_syscall_64
      2.73            -0.1        2.58 ±  2%  perf-profile.calltrace.cycles-pp.ring_buffer_reset_online_cpus.tracing_reset_online_cpus.tracing_reset_all_online_cpus.dyn_event_release.trace_parse_run_command
      2.74            -0.1        2.60 ±  2%  perf-profile.calltrace.cycles-pp.tracing_reset_all_online_cpus.dyn_event_release.trace_parse_run_command.vfs_write.ksys_write
      2.74            -0.1        2.60 ±  2%  perf-profile.calltrace.cycles-pp.tracing_reset_online_cpus.tracing_reset_all_online_cpus.dyn_event_release.trace_parse_run_command.vfs_write
      2.64            -0.1        2.52        perf-profile.calltrace.cycles-pp.reset_disabled_cpu_buffer.ring_buffer_reset_online_cpus.tracing_reset_online_cpus.tracing_reset_all_online_cpus.dyn_event_release
      2.62            -0.1        2.50 ±  2%  perf-profile.calltrace.cycles-pp.rb_reset_cpu.reset_disabled_cpu_buffer.ring_buffer_reset_online_cpus.tracing_reset_online_cpus.tracing_reset_all_online_cpus
      1.25 ±  2%      -0.1        1.15 ±  2%  perf-profile.calltrace.cycles-pp.text_poke_bp_batch.text_poke_bp.__static_call_transform.arch_static_call_transform.__static_call_update
      0.85            -0.0        0.82        perf-profile.calltrace.cycles-pp.tracepoint_add_func.tracepoint_probe_register.tracing_start_sched_switch.__ftrace_event_enable_disable.event_enable_write
      0.85            -0.0        0.82        perf-profile.calltrace.cycles-pp.tracepoint_probe_register.tracing_start_sched_switch.__ftrace_event_enable_disable.event_enable_write.vfs_write
      0.85            -0.0        0.82        perf-profile.calltrace.cycles-pp.tracing_start_sched_switch.__ftrace_event_enable_disable.event_enable_write.vfs_write.ksys_write
      1.22 ±  7%      +0.2        1.44 ±  7%  perf-profile.calltrace.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      1.29 ±  8%      +0.4        1.64 ± 11%  perf-profile.calltrace.cycles-pp.poll_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      1.00 ±  7%      +0.6        1.57 ±  4%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork.ret_from_fork_asm
      1.00 ±  7%      +0.6        1.57 ±  4%  perf-profile.calltrace.cycles-pp.ret_from_fork.ret_from_fork_asm
      1.00 ±  7%      +0.6        1.57 ±  4%  perf-profile.calltrace.cycles-pp.ret_from_fork_asm
      0.90 ± 30%      +1.3        2.16 ±  6%  perf-profile.calltrace.cycles-pp.asm_sysvec_call_function_single.acpi_safe_halt.acpi_idle_do_entry.acpi_idle_enter.cpuidle_enter_state
     51.18            -2.5       48.69        perf-profile.children.cycles-pp.asm_sysvec_call_function
      6.44            -0.3        6.10        perf-profile.children.cycles-pp.vfs_write
      6.44            -0.3        6.10        perf-profile.children.cycles-pp.ksys_write
      6.46            -0.3        6.13        perf-profile.children.cycles-pp.write
      2.94            -0.2        2.75 ±  2%  perf-profile.children.cycles-pp.trace_parse_run_command
      2.81            -0.2        2.66        perf-profile.children.cycles-pp.dyn_event_release
      2.74            -0.1        2.60 ±  2%  perf-profile.children.cycles-pp.tracing_reset_all_online_cpus
      1.29 ±  5%      -0.1        1.15 ±  3%  perf-profile.children.cycles-pp.irqentry_exit_to_user_mode
      1.26 ±  3%      -0.1        1.16 ±  3%  perf-profile.children.cycles-pp.__static_call_update
      1.25 ±  3%      -0.1        1.15 ±  3%  perf-profile.children.cycles-pp.arch_static_call_transform
      1.25 ±  2%      -0.1        1.15 ±  3%  perf-profile.children.cycles-pp.text_poke_bp
      1.25 ±  2%      -0.1        1.15 ±  3%  perf-profile.children.cycles-pp.__static_call_transform
      1.61            -0.1        1.52        perf-profile.children.cycles-pp.smp_call_function_many_cond
      0.35 ±  8%      -0.1        0.27 ± 17%  perf-profile.children.cycles-pp.mutex_spin_on_owner
      0.66 ±  6%      -0.1        0.58 ±  3%  perf-profile.children.cycles-pp.__memcpy
      1.60            -0.1        1.52        perf-profile.children.cycles-pp.on_each_cpu_cond_mask
      1.66            -0.1        1.58        perf-profile.children.cycles-pp.text_poke_bp_batch
      0.55 ±  6%      -0.1        0.48 ±  9%  perf-profile.children.cycles-pp.pre_ssout
      0.36 ±  7%      -0.1        0.30 ± 16%  perf-profile.children.cycles-pp.__replace_page
      0.10 ± 28%      -0.1        0.04 ±109%  perf-profile.children.cycles-pp.trace_empty
      0.85            -0.0        0.82        perf-profile.children.cycles-pp.tracepoint_add_func
      0.12 ± 20%      -0.0        0.09 ± 16%  perf-profile.children.cycles-pp.__trace_uprobe_create
      0.85            -0.0        0.82        perf-profile.children.cycles-pp.tracepoint_probe_register
      0.85            -0.0        0.82        perf-profile.children.cycles-pp.tracing_start_sched_switch
      0.08            +0.0        0.09 ±  4%  perf-profile.children.cycles-pp.__i2c_transfer
      0.08            +0.0        0.09 ±  4%  perf-profile.children.cycles-pp.ast_vga_connector_helper_detect_ctx
      0.08            +0.0        0.09 ±  4%  perf-profile.children.cycles-pp.bit_xfer
      0.08            +0.0        0.09 ±  4%  perf-profile.children.cycles-pp.drm_connector_helper_detect_from_ddc
      0.08            +0.0        0.09 ±  4%  perf-profile.children.cycles-pp.drm_do_probe_ddc_edid
      0.08            +0.0        0.09 ±  4%  perf-profile.children.cycles-pp.drm_helper_probe_detect_ctx
      0.08            +0.0        0.09 ±  4%  perf-profile.children.cycles-pp.drm_probe_ddc
      0.08            +0.0        0.09 ±  4%  perf-profile.children.cycles-pp.i2c_transfer
      0.08            +0.0        0.09 ±  4%  perf-profile.children.cycles-pp.output_poll_execute
      0.06 ±  6%      +0.0        0.08 ±  6%  perf-profile.children.cycles-pp.i2c_outb
      0.10 ± 23%      +0.1        0.18 ± 22%  perf-profile.children.cycles-pp.timekeeping_advance
      0.10 ± 23%      +0.1        0.18 ± 22%  perf-profile.children.cycles-pp.update_wall_time
      0.19 ± 22%      +0.1        0.27 ± 19%  perf-profile.children.cycles-pp.cmd_stat
      0.19 ± 22%      +0.1        0.27 ± 19%  perf-profile.children.cycles-pp.dispatch_events
      0.19 ± 22%      +0.1        0.27 ± 19%  perf-profile.children.cycles-pp.process_interval
      0.61 ±  5%      +0.1        0.70 ±  5%  perf-profile.children.cycles-pp.asm_exc_page_fault
      0.21 ± 21%      +0.1        0.29 ± 18%  perf-profile.children.cycles-pp.handle_internal_command
      0.21 ± 21%      +0.1        0.29 ± 18%  perf-profile.children.cycles-pp.main
      0.21 ± 21%      +0.1        0.29 ± 18%  perf-profile.children.cycles-pp.run_builtin
      0.52 ±  9%      +0.1        0.61 ± 10%  perf-profile.children.cycles-pp.enqueue_task_fair
      0.52 ± 10%      +0.1        0.62 ± 10%  perf-profile.children.cycles-pp.enqueue_task
      0.27 ± 22%      +0.1        0.37 ± 10%  perf-profile.children.cycles-pp.hrtimer_wakeup
      0.21 ± 17%      +0.1        0.31 ± 15%  perf-profile.children.cycles-pp.dequeue_entities
      0.52 ± 11%      +0.1        0.63 ±  6%  perf-profile.children.cycles-pp.try_to_wake_up
      0.21 ± 17%      +0.1        0.32 ± 13%  perf-profile.children.cycles-pp.dequeue_task_fair
      1.14 ±  6%      +0.1        1.26 ±  4%  perf-profile.children.cycles-pp.handle_softirqs
      0.49 ±  8%      +0.1        0.62 ± 11%  perf-profile.children.cycles-pp.sysvec_call_function_single
      1.97 ±  7%      +0.2        2.16 ±  5%  perf-profile.children.cycles-pp.hrtimer_interrupt
      2.03 ±  7%      +0.2        2.23 ±  5%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      1.27 ±  6%      +0.2        1.50 ±  5%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.00            +0.3        0.29 ± 11%  perf-profile.children.cycles-pp.smp_call_function_single
      0.00            +0.3        0.34 ± 13%  perf-profile.children.cycles-pp.trc_wait_for_one_reader
      0.00            +0.4        0.36 ± 12%  perf-profile.children.cycles-pp.check_all_holdout_tasks_trace
      1.37 ±  6%      +0.4        1.75 ± 11%  perf-profile.children.cycles-pp.poll_idle
      0.00            +0.4        0.44 ±  7%  perf-profile.children.cycles-pp.rcu_tasks_wait_gp
      0.00            +0.4        0.44 ±  7%  perf-profile.children.cycles-pp.rcu_tasks_kthread
      0.00            +0.4        0.44 ±  7%  perf-profile.children.cycles-pp.rcu_tasks_one_gp
      1.00 ±  7%      +0.6        1.56 ±  4%  perf-profile.children.cycles-pp.asm_sysvec_call_function_single
      1.03 ±  6%      +0.6        1.59 ±  4%  perf-profile.children.cycles-pp.ret_from_fork
      1.04 ±  6%      +0.6        1.61 ±  4%  perf-profile.children.cycles-pp.ret_from_fork_asm
      1.00 ±  7%      +0.6        1.57 ±  4%  perf-profile.children.cycles-pp.kthread
     53.70            -1.3       52.45        perf-profile.self.cycles-pp.acpi_safe_halt
      0.64 ±  7%      -0.1        0.57 ±  4%  perf-profile.self.cycles-pp.__memcpy
      0.35 ±  8%      -0.1        0.27 ± 17%  perf-profile.self.cycles-pp.mutex_spin_on_owner
      0.13 ± 18%      -0.0        0.08 ± 20%  perf-profile.self.cycles-pp.ring_buffer_reset_online_cpus
      0.12 ± 27%      +0.1        0.18 ± 12%  perf-profile.self.cycles-pp.irqentry_enter
      0.05 ± 74%      +0.1        0.11 ± 15%  perf-profile.self.cycles-pp.nr_iowait_cpu
      0.01 ±223%      +0.1        0.06 ± 17%  perf-profile.self.cycles-pp.timerqueue_add
      0.00            +0.2        0.24 ± 18%  perf-profile.self.cycles-pp.smp_call_function_single
      1.32 ±  6%      +0.4        1.70 ± 12%  perf-profile.self.cycles-pp.poll_idle


***************************************************************************************************
lkp-spr-2sp4: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 512G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/x86_64-rhel-9.4/100%/debian-12-x86_64-20240206.cgz/lkp-spr-2sp4/uprobe/stress-ng/60s

commit: 
  v6.12-rc2
  87195a1ee3 ("uprobes: switch to RCU Tasks Trace flavor for better performance")

       v6.12-rc2 87195a1ee332add27bd51448c6b 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      0.47 ±  5%      -0.1        0.35 ±  2%  mpstat.cpu.all.sys%
      7759            -3.3%       7502        vmstat.system.cs
    139087           -12.1%     122220        vmstat.system.in
   1396372            -4.2%    1337857        proc-vmstat.numa_hit
   1071700            -4.7%    1021601        proc-vmstat.numa_local
    324655            -2.6%     316249        proc-vmstat.numa_other
   1459914            -4.2%    1398802        proc-vmstat.pgalloc_normal
    721541            -2.5%     703816        proc-vmstat.pgfault
    213660           -10.4%     191374        stress-ng.time.minor_page_faults
     97.00 ±  6%     -36.6%      61.50 ±  4%  stress-ng.time.percent_of_cpu_this_job_got
     58.46 ±  6%     -36.7%      37.00 ±  4%  stress-ng.time.system_time
    135842            -4.6%     129605        stress-ng.time.voluntary_context_switches
    973099           -16.3%     814898        stress-ng.uprobe.ops
     16218           -16.3%      13577        stress-ng.uprobe.ops_per_sec
 8.688e+08            -8.1%  7.986e+08 ±  2%  perf-stat.i.branch-instructions
      2.34            +0.3        2.65 ±  2%  perf-stat.i.branch-miss-rate%
      7635            -2.5%       7447        perf-stat.i.context-switches
 7.684e+09 ±  2%     -14.9%  6.536e+09        perf-stat.i.cpu-cycles
  4.22e+09            -8.1%  3.878e+09 ±  2%  perf-stat.i.instructions
      3.67            +0.3        3.97        perf-stat.overall.branch-miss-rate%
      1.82            -7.2%       1.69 ±  2%  perf-stat.overall.cpi
      1989 ±  4%     -11.5%       1760 ±  6%  perf-stat.overall.cycles-between-cache-misses
      0.55            +7.8%       0.59 ±  2%  perf-stat.overall.ipc
 8.535e+08            -8.2%  7.832e+08 ±  2%  perf-stat.ps.branch-instructions
      7502            -2.4%       7323        perf-stat.ps.context-switches
 7.546e+09 ±  2%     -14.9%  6.421e+09        perf-stat.ps.cpu-cycles
 4.146e+09            -8.2%  3.804e+09 ±  2%  perf-stat.ps.instructions
 2.552e+11 ±  2%      -8.3%   2.34e+11        perf-stat.total.instructions
      0.02 ±  7%     -18.5%       0.02 ±  7%  perf-sched.sch_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      0.01 ± 23%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_timeout.__wait_for_common.__synchronize_srcu.part.0
      0.01 ± 28%    +135.1%       0.01 ± 14%  perf-sched.sch_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.__wait_rcu_gp
      0.05 ±106%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_timeout.__wait_for_common.__synchronize_srcu.part.0
      0.04 ± 89%    +658.6%       0.28 ± 15%  perf-sched.sch_delay.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.__wait_rcu_gp
    479.18 ±  6%     +17.9%     564.98        perf-sched.wait_and_delay.avg.ms.__traceiter_sched_switch.__traceiter_sched_switch.worker_thread.kthread.ret_from_fork
     80.63 ± 23%     +30.4%     105.14 ±  7%  perf-sched.wait_and_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      7.91          +219.8%      25.30        perf-sched.wait_and_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.__wait_rcu_gp
      5.09 ±  3%     +21.6%       6.19 ±  2%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      5420 ±  5%     -25.5%       4038 ±  8%  perf-sched.wait_and_delay.count.__traceiter_sched_switch.__traceiter_sched_switch.do_nanosleep.hrtimer_nanosleep.common_nsleep
    123.67 ±  3%     -13.7%     106.67 ±  3%  perf-sched.wait_and_delay.count.__traceiter_sched_switch.__traceiter_sched_switch.rcu_gp_kthread.kthread.ret_from_fork
    164.50 ±  5%     -23.2%     126.33 ±  8%  perf-sched.wait_and_delay.count.__traceiter_sched_switch.__traceiter_sched_switch.schedule_timeout.__wait_for_common.wait_for_completion_state
    284.33 ±  3%     -20.0%     227.33 ±  5%  perf-sched.wait_and_delay.count.__traceiter_sched_switch.__traceiter_sched_switch.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread
    436.00 ± 11%     -19.6%     350.67 ± 15%  perf-sched.wait_and_delay.count.__traceiter_sched_switch.__traceiter_sched_switch.worker_thread.kthread.ret_from_fork
      1686 ± 11%     +92.3%       3242 ±  8%  perf-sched.wait_and_delay.count.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
    223.50           -13.7%     192.83 ±  2%  perf-sched.wait_and_delay.count.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      3271 ±  5%     -23.4%       2505 ± 10%  perf-sched.wait_and_delay.count.schedule_preempt_disabled.__mutex_lock.constprop.0.tracing_check_open_get_tr
    202.33           +19.0%     240.83        perf-sched.wait_and_delay.count.schedule_timeout.__wait_for_common.wait_for_completion_state.__wait_rcu_gp
     22.32 ±  5%    +483.8%     130.32 ±  7%  perf-sched.wait_and_delay.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.__wait_rcu_gp
    479.15 ±  6%     +17.9%     564.95        perf-sched.wait_time.avg.ms.__traceiter_sched_switch.__traceiter_sched_switch.worker_thread.kthread.ret_from_fork
     80.60 ± 23%     +30.4%     105.12 ±  7%  perf-sched.wait_time.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      7.73 ±  5%    -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.__synchronize_srcu.part.0
      7.90          +219.9%      25.28        perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.__wait_rcu_gp
      5.08 ±  3%     +21.2%       6.16 ±  2%  perf-sched.wait_time.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
    259.73           -11.9%     228.73 ±  7%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.register_trace_uprobe
     17.17 ± 10%    -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_timeout.__wait_for_common.__synchronize_srcu.part.0
     22.32 ±  5%    +483.8%     130.29 ±  7%  perf-sched.wait_time.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.__wait_rcu_gp
     34.34 ±  7%     -15.8       18.49 ± 38%  perf-profile.calltrace.cycles-pp.__mutex_lock.tracing_check_open_get_tr.tracing_open_pipe.do_dentry_open.vfs_open
     34.43 ±  7%     -15.8       18.59 ± 37%  perf-profile.calltrace.cycles-pp.tracing_check_open_get_tr.tracing_open_pipe.do_dentry_open.vfs_open.do_open
     34.48 ±  7%     -15.8       18.64 ± 37%  perf-profile.calltrace.cycles-pp.tracing_open_pipe.do_dentry_open.vfs_open.do_open.path_openat
     39.73 ±  5%     -15.3       24.47 ± 26%  perf-profile.calltrace.cycles-pp.vfs_open.do_open.path_openat.do_filp_open.do_sys_openat2
     39.73 ±  5%     -15.3       24.47 ± 26%  perf-profile.calltrace.cycles-pp.do_dentry_open.vfs_open.do_open.path_openat.do_filp_open
     39.78 ±  5%     -15.3       24.53 ± 25%  perf-profile.calltrace.cycles-pp.do_open.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
     40.53 ±  5%     -15.0       25.50 ± 24%  perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64
     40.54 ±  5%     -15.0       25.52 ± 24%  perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
     40.85 ±  5%     -15.0       25.86 ± 24%  perf-profile.calltrace.cycles-pp.open64
     40.79 ±  5%     -15.0       25.80 ± 24%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
     40.79 ±  5%     -15.0       25.80 ± 24%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.open64
     40.65 ±  5%     -15.0       25.67 ± 24%  perf-profile.calltrace.cycles-pp.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
     40.66 ±  5%     -15.0       25.68 ± 24%  perf-profile.calltrace.cycles-pp.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
     31.21 ±  9%     -14.8       16.36 ± 43%  perf-profile.calltrace.cycles-pp.osq_lock.__mutex_lock.tracing_check_open_get_tr.tracing_open_pipe.do_dentry_open
      6.27 ±  3%      -1.7        4.55 ±  9%  perf-profile.calltrace.cycles-pp.trace_parse_run_command.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      6.17 ±  2%      -1.7        4.45 ±  9%  perf-profile.calltrace.cycles-pp.dyn_event_release.trace_parse_run_command.vfs_write.ksys_write.do_syscall_64
      6.07 ±  2%      -1.6        4.43 ±  9%  perf-profile.calltrace.cycles-pp.tracing_reset_all_online_cpus.dyn_event_release.trace_parse_run_command.vfs_write.ksys_write
      6.07 ±  2%      -1.6        4.43 ±  9%  perf-profile.calltrace.cycles-pp.tracing_reset_online_cpus.tracing_reset_all_online_cpus.dyn_event_release.trace_parse_run_command.vfs_write
      6.04 ±  2%      -1.6        4.42 ±  9%  perf-profile.calltrace.cycles-pp.ring_buffer_reset_online_cpus.tracing_reset_online_cpus.tracing_reset_all_online_cpus.dyn_event_release.trace_parse_run_command
      8.20 ±  3%      -1.5        6.69 ±  9%  perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      8.20 ±  3%      -1.5        6.69 ±  9%  perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      8.21 ±  3%      -1.5        6.70 ±  9%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      8.21 ±  3%      -1.5        6.70 ±  9%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
      8.21 ±  3%      -1.5        6.71 ±  9%  perf-profile.calltrace.cycles-pp.write
      5.72 ±  2%      -1.5        4.23 ±  9%  perf-profile.calltrace.cycles-pp.rb_reset_cpu.reset_disabled_cpu_buffer.ring_buffer_reset_online_cpus.tracing_reset_online_cpus.tracing_reset_all_online_cpus
      5.74 ±  2%      -1.5        4.25 ±  9%  perf-profile.calltrace.cycles-pp.reset_disabled_cpu_buffer.ring_buffer_reset_online_cpus.tracing_reset_online_cpus.tracing_reset_all_online_cpus.dyn_event_release
      2.88 ± 15%      -1.0        1.89 ±  9%  perf-profile.calltrace.cycles-pp.mutex_spin_on_owner.__mutex_lock.tracing_check_open_get_tr.tracing_open_pipe.do_dentry_open
      0.75 ±  8%      +0.2        0.92 ± 10%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.rest_init.start_kernel.x86_64_start_reservations.x86_64_start_kernel
      0.75 ±  8%      +0.2        0.92 ± 10%  perf-profile.calltrace.cycles-pp.rest_init.start_kernel.x86_64_start_reservations.x86_64_start_kernel.common_startup_64
      0.75 ±  8%      +0.2        0.92 ± 10%  perf-profile.calltrace.cycles-pp.start_kernel.x86_64_start_reservations.x86_64_start_kernel.common_startup_64
      0.75 ±  8%      +0.2        0.92 ± 10%  perf-profile.calltrace.cycles-pp.x86_64_start_kernel.common_startup_64
      0.75 ±  8%      +0.2        0.92 ± 10%  perf-profile.calltrace.cycles-pp.x86_64_start_reservations.x86_64_start_kernel.common_startup_64
      0.75 ±  7%      +0.2        0.92 ± 10%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.rest_init.start_kernel.x86_64_start_reservations
      0.62 ± 14%      +0.2        0.80 ± 12%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.rest_init
      0.57 ±  6%      +0.2        0.76 ± 10%  perf-profile.calltrace.cycles-pp.__hrtimer_start_range_ns.hrtimer_start_range_ns.start_dl_timer.enqueue_dl_entity.dl_server_start
      0.46 ± 45%      +0.2        0.66 ± 13%  perf-profile.calltrace.cycles-pp.smp_call_function_many_cond.on_each_cpu_cond_mask.text_poke_bp_batch.text_poke_bp.__static_call_transform
      0.64 ± 13%      +0.2        0.84 ± 11%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.rest_init.start_kernel
      0.59 ±  6%      +0.2        0.79 ± 10%  perf-profile.calltrace.cycles-pp.hrtimer_start_range_ns.start_dl_timer.enqueue_dl_entity.dl_server_start.enqueue_task_fair
      0.86 ±  3%      +0.2        1.06 ±  8%  perf-profile.calltrace.cycles-pp.tick_nohz_idle_stop_tick.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      0.60 ±  6%      +0.2        0.81 ± 10%  perf-profile.calltrace.cycles-pp.start_dl_timer.enqueue_dl_entity.dl_server_start.enqueue_task_fair.enqueue_task
      0.63 ±  6%      +0.2        0.84 ± 10%  perf-profile.calltrace.cycles-pp.enqueue_dl_entity.dl_server_start.enqueue_task_fair.enqueue_task.ttwu_do_activate
      0.63 ±  6%      +0.2        0.84 ± 10%  perf-profile.calltrace.cycles-pp.dl_server_start.enqueue_task_fair.enqueue_task.ttwu_do_activate.try_to_wake_up
      0.54 ± 45%      +0.2        0.76 ±  6%  perf-profile.calltrace.cycles-pp.tick_nohz_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      0.79 ±  6%      +0.2        1.02 ± 12%  perf-profile.calltrace.cycles-pp.__irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      0.75 ±  6%      +0.2        0.98 ± 12%  perf-profile.calltrace.cycles-pp.handle_softirqs.__irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      0.59 ± 10%      +0.2        0.84 ± 14%  perf-profile.calltrace.cycles-pp.clock_nanosleep
      0.81 ±  5%      +0.3        1.09 ± 11%  perf-profile.calltrace.cycles-pp.ttwu_do_activate.try_to_wake_up.hrtimer_wakeup.__hrtimer_run_queues.hrtimer_interrupt
      0.79 ±  5%      +0.3        1.07 ± 11%  perf-profile.calltrace.cycles-pp.enqueue_task_fair.enqueue_task.ttwu_do_activate.try_to_wake_up.hrtimer_wakeup
      0.79 ±  5%      +0.3        1.08 ± 11%  perf-profile.calltrace.cycles-pp.enqueue_task.ttwu_do_activate.try_to_wake_up.hrtimer_wakeup.__hrtimer_run_queues
      0.57 ±  4%      +0.3        0.87 ±  9%  perf-profile.calltrace.cycles-pp.tick_nohz_get_sleep_length.menu_select.cpuidle_idle_call.do_idle.cpu_startup_entry
      0.92 ±  5%      +0.3        1.24 ± 11%  perf-profile.calltrace.cycles-pp.try_to_wake_up.hrtimer_wakeup.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
      0.92 ±  5%      +0.3        1.25 ± 11%  perf-profile.calltrace.cycles-pp.hrtimer_wakeup.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      0.38 ± 71%      +0.4        0.76 ± 14%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.clock_nanosleep
      0.38 ± 71%      +0.4        0.77 ± 15%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.clock_nanosleep
      0.19 ±141%      +0.4        0.59 ±  8%  perf-profile.calltrace.cycles-pp.update_process_times.tick_nohz_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
      2.06 ± 10%      +0.5        2.52 ± 11%  perf-profile.calltrace.cycles-pp.rb_per_cpu_empty.ring_buffer_empty_cpu.__find_next_entry.trace_find_next_entry_inc.tracing_read_pipe
      1.09 ± 17%      +0.5        1.58 ± 14%  perf-profile.calltrace.cycles-pp.irq_enter_rcu.sysvec_call_function.asm_sysvec_call_function.cpuidle_enter_state.cpuidle_enter
      1.02 ± 19%      +0.5        1.52 ± 14%  perf-profile.calltrace.cycles-pp.tick_irq_enter.irq_enter_rcu.sysvec_call_function.asm_sysvec_call_function.cpuidle_enter_state
      1.64 ±  4%      +0.5        2.13 ±  8%  perf-profile.calltrace.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.08 ±223%      +0.5        0.62 ± 12%  perf-profile.calltrace.cycles-pp.__x64_sys_clock_nanosleep.do_syscall_64.entry_SYSCALL_64_after_hwframe.clock_nanosleep
      0.09 ±223%      +0.5        0.63 ± 10%  perf-profile.calltrace.cycles-pp.get_nohz_timer_target.__hrtimer_start_range_ns.hrtimer_start_range_ns.start_dl_timer.enqueue_dl_entity
      1.90 ±  4%      +0.5        2.45 ±  7%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      0.45 ± 75%      +0.6        1.02 ± 24%  perf-profile.calltrace.cycles-pp.tick_do_update_jiffies64.tick_irq_enter.irq_enter_rcu.sysvec_call_function.asm_sysvec_call_function
      1.93 ±  4%      +0.6        2.50 ±  7%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      0.00            +0.6        0.58 ±  9%  perf-profile.calltrace.cycles-pp.schedule_idle.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      0.22 ±141%      +0.6        0.83 ± 25%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.tick_do_update_jiffies64.tick_irq_enter.irq_enter_rcu
      0.00            +0.6        0.63 ±  8%  perf-profile.calltrace.cycles-pp.tick_nohz_next_event.tick_nohz_get_sleep_length.menu_select.cpuidle_idle_call.do_idle
      1.64 ±  2%      +0.6        2.28 ±  8%  perf-profile.calltrace.cycles-pp.menu_select.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      0.24 ±142%      +0.7        0.91 ± 25%  perf-profile.calltrace.cycles-pp._raw_spin_lock.tick_do_update_jiffies64.tick_irq_enter.irq_enter_rcu.sysvec_call_function
      4.24 ±  7%      +0.8        5.06 ±  9%  perf-profile.calltrace.cycles-pp.ring_buffer_empty_cpu.__find_next_entry.trace_find_next_entry_inc.tracing_read_pipe.vfs_read
      4.66 ±  7%      +0.8        5.48 ±  9%  perf-profile.calltrace.cycles-pp.__find_next_entry.trace_find_next_entry_inc.tracing_read_pipe.vfs_read.ksys_read
      4.74 ±  7%      +0.8        5.56 ±  9%  perf-profile.calltrace.cycles-pp.trace_find_next_entry_inc.tracing_read_pipe.vfs_read.ksys_read.do_syscall_64
      2.94 ±  4%      +0.8        3.78 ±  8%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      5.01 ±  7%      +0.9        5.87 ±  9%  perf-profile.calltrace.cycles-pp.tracing_read_pipe.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.15 ±  7%      +0.9        6.04 ±  9%  perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      5.17 ±  7%      +0.9        6.06 ±  9%  perf-profile.calltrace.cycles-pp.read
      5.15 ±  7%      +0.9        6.04 ±  9%  perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      5.16 ±  7%      +0.9        6.06 ±  9%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      5.16 ±  7%      +0.9        6.06 ±  9%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read
      3.05 ±  4%      +0.9        3.96 ±  8%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      5.04 ±  6%      +0.9        5.94 ±  4%  perf-profile.calltrace.cycles-pp.sysvec_call_function.asm_sysvec_call_function.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      8.02 ±  5%      +1.1        9.17 ±  5%  perf-profile.calltrace.cycles-pp.asm_sysvec_call_function.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
     22.95 ±  3%      +3.4       26.39 ±  9%  perf-profile.calltrace.cycles-pp.intel_idle_xstate.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      0.00            +6.2        6.21 ±  8%  perf-profile.calltrace.cycles-pp.smp_call_function_single.trc_wait_for_one_reader.check_all_holdout_tasks_trace.rcu_tasks_wait_gp.rcu_tasks_one_gp
      0.00            +6.3        6.26 ±  8%  perf-profile.calltrace.cycles-pp.trc_wait_for_one_reader.check_all_holdout_tasks_trace.rcu_tasks_wait_gp.rcu_tasks_one_gp.rcu_tasks_kthread
      0.00            +6.3        6.28 ±  8%  perf-profile.calltrace.cycles-pp.check_all_holdout_tasks_trace.rcu_tasks_wait_gp.rcu_tasks_one_gp.rcu_tasks_kthread.kthread
     36.75 ±  3%      +6.3       43.09 ±  8%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      0.00            +6.4        6.36 ±  8%  perf-profile.calltrace.cycles-pp.rcu_tasks_wait_gp.rcu_tasks_one_gp.rcu_tasks_kthread.kthread.ret_from_fork
      0.00            +6.4        6.37 ±  8%  perf-profile.calltrace.cycles-pp.rcu_tasks_kthread.kthread.ret_from_fork.ret_from_fork_asm
      0.00            +6.4        6.37 ±  8%  perf-profile.calltrace.cycles-pp.rcu_tasks_one_gp.rcu_tasks_kthread.kthread.ret_from_fork.ret_from_fork_asm
     36.61 ±  3%      +6.4       43.02 ±  8%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
      0.74 ±  6%      +6.6        7.35 ±  8%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork.ret_from_fork_asm
      0.74 ±  6%      +6.6        7.35 ±  8%  perf-profile.calltrace.cycles-pp.ret_from_fork.ret_from_fork_asm
      0.74 ±  6%      +6.6        7.35 ±  8%  perf-profile.calltrace.cycles-pp.ret_from_fork_asm
     39.90 ±  3%      +7.3       47.22 ±  8%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.common_startup_64
     41.32 ±  3%      +8.1       49.38 ±  8%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.common_startup_64
     41.34 ±  3%      +8.1       49.41 ±  8%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.common_startup_64
     41.34 ±  3%      +8.1       49.41 ±  8%  perf-profile.calltrace.cycles-pp.start_secondary.common_startup_64
     42.10 ±  3%      +8.2       50.33 ±  8%  perf-profile.calltrace.cycles-pp.common_startup_64
     34.52 ±  7%     -15.9       18.58 ± 37%  perf-profile.children.cycles-pp.__mutex_lock
     34.44 ±  7%     -15.8       18.59 ± 37%  perf-profile.children.cycles-pp.tracing_check_open_get_tr
     34.48 ±  7%     -15.8       18.64 ± 37%  perf-profile.children.cycles-pp.tracing_open_pipe
     39.74 ±  5%     -15.3       24.48 ± 26%  perf-profile.children.cycles-pp.do_dentry_open
     39.74 ±  5%     -15.3       24.48 ± 26%  perf-profile.children.cycles-pp.vfs_open
     39.80 ±  5%     -15.2       24.55 ± 25%  perf-profile.children.cycles-pp.do_open
     55.81 ±  3%     -15.1       40.70 ± 12%  perf-profile.children.cycles-pp.do_syscall_64
     55.82 ±  3%     -15.1       40.72 ± 12%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     40.61 ±  5%     -15.0       25.60 ± 24%  perf-profile.children.cycles-pp.path_openat
     40.62 ±  5%     -15.0       25.61 ± 24%  perf-profile.children.cycles-pp.do_filp_open
     40.85 ±  5%     -15.0       25.86 ± 24%  perf-profile.children.cycles-pp.open64
     40.74 ±  5%     -15.0       25.77 ± 24%  perf-profile.children.cycles-pp.do_sys_openat2
     40.75 ±  5%     -15.0       25.78 ± 24%  perf-profile.children.cycles-pp.__x64_sys_openat
     31.22 ±  9%     -14.9       16.36 ± 43%  perf-profile.children.cycles-pp.osq_lock
      6.27 ±  3%      -1.7        4.55 ±  9%  perf-profile.children.cycles-pp.trace_parse_run_command
      6.17 ±  2%      -1.7        4.45 ±  9%  perf-profile.children.cycles-pp.dyn_event_release
      6.07 ±  2%      -1.6        4.43 ±  9%  perf-profile.children.cycles-pp.tracing_reset_all_online_cpus
      8.20 ±  3%      -1.5        6.69 ±  9%  perf-profile.children.cycles-pp.ksys_write
      8.20 ±  3%      -1.5        6.69 ±  9%  perf-profile.children.cycles-pp.vfs_write
      8.22 ±  3%      -1.5        6.71 ±  9%  perf-profile.children.cycles-pp.write
      3.05 ± 14%      -1.1        1.98 ±  9%  perf-profile.children.cycles-pp.mutex_spin_on_owner
      0.44 ± 14%      -0.1        0.35 ± 14%  perf-profile.children.cycles-pp.sched_tick
      0.06 ± 11%      +0.0        0.08 ±  6%  perf-profile.children.cycles-pp.__do_sys_clone
      0.05 ±  8%      +0.0        0.08 ± 17%  perf-profile.children.cycles-pp.update_irq_load_avg
      0.06 ± 13%      +0.0        0.08 ± 13%  perf-profile.children.cycles-pp.__run_timers
      0.23 ±  7%      +0.0        0.26 ±  7%  perf-profile.children.cycles-pp.__probe_event_disable
      0.09 ± 12%      +0.0        0.11 ± 12%  perf-profile.children.cycles-pp.__x64_sys_exit_group
      0.09 ± 12%      +0.0        0.11 ± 12%  perf-profile.children.cycles-pp.do_exit
      0.09 ± 12%      +0.0        0.11 ± 12%  perf-profile.children.cycles-pp.do_group_exit
      0.11 ±  8%      +0.0        0.14 ± 10%  perf-profile.children.cycles-pp.vm_mmap_pgoff
      0.12 ±  9%      +0.0        0.15 ±  7%  perf-profile.children.cycles-pp.__replace_page
      0.10 ±  8%      +0.0        0.12 ± 10%  perf-profile.children.cycles-pp.mmap_region
      0.06 ± 13%      +0.0        0.09 ± 14%  perf-profile.children.cycles-pp.__memcg_slab_post_alloc_hook
      0.06 ± 13%      +0.0        0.09 ± 12%  perf-profile.children.cycles-pp.irq_work_needs_cpu
      0.23 ±  7%      +0.0        0.26 ±  7%  perf-profile.children.cycles-pp.probe_event_disable
      0.10 ±  9%      +0.0        0.13 ± 14%  perf-profile.children.cycles-pp.ct_kernel_exit
      0.12 ± 18%      +0.0        0.16 ± 12%  perf-profile.children.cycles-pp.rcu_gp_kthread
      0.12 ±  7%      +0.0        0.16 ± 14%  perf-profile.children.cycles-pp.x64_sys_call
      0.18 ±  8%      +0.0        0.22 ±  8%  perf-profile.children.cycles-pp.call_cpuidle
      0.06 ± 19%      +0.0        0.10 ± 15%  perf-profile.children.cycles-pp.menu_reflect
      0.05 ± 49%      +0.0        0.09 ± 20%  perf-profile.children.cycles-pp.prepare_task_switch
      0.08 ± 14%      +0.0        0.12 ± 13%  perf-profile.children.cycles-pp.evsel__read_counter
      0.06 ± 47%      +0.0        0.10 ± 17%  perf-profile.children.cycles-pp.tmigr_cpu_deactivate
      0.15 ± 14%      +0.0        0.19 ± 11%  perf-profile.children.cycles-pp.bprm_execve
      0.08 ± 19%      +0.0        0.12 ± 18%  perf-profile.children.cycles-pp.alloc_empty_file
      0.04 ± 71%      +0.0        0.08 ± 22%  perf-profile.children.cycles-pp.getname_flags
      0.09 ± 15%      +0.0        0.13 ± 13%  perf-profile.children.cycles-pp.lapic_next_deadline
      0.14 ± 15%      +0.0        0.18 ±  9%  perf-profile.children.cycles-pp.filemap_map_pages
      0.28 ±  8%      +0.0        0.32 ±  7%  perf-profile.children.cycles-pp.install_breakpoint
      0.11 ± 12%      +0.0        0.16 ± 10%  perf-profile.children.cycles-pp.__update_blocked_fair
      0.15 ± 15%      +0.0        0.19 ± 10%  perf-profile.children.cycles-pp.do_read_fault
      0.06 ± 13%      +0.0        0.10 ± 11%  perf-profile.children.cycles-pp.tmigr_cpu_activate
      0.12 ± 15%      +0.0        0.17 ± 11%  perf-profile.children.cycles-pp.__sched_setaffinity
      0.08 ±  5%      +0.0        0.13 ± 17%  perf-profile.children.cycles-pp.readn
      0.08 ± 11%      +0.0        0.13 ± 18%  perf-profile.children.cycles-pp.enqueue_hrtimer
      0.12 ± 17%      +0.1        0.18 ± 10%  perf-profile.children.cycles-pp.tsc_verify_tsc_adjust
      0.14 ± 11%      +0.1        0.18 ±  9%  perf-profile.children.cycles-pp.__x64_sys_sched_setaffinity
      0.10 ± 14%      +0.1        0.15 ± 13%  perf-profile.children.cycles-pp.kmem_cache_alloc_noprof
      0.14 ± 17%      +0.1        0.19 ± 14%  perf-profile.children.cycles-pp.arch_cpu_idle_enter
      0.09 ± 20%      +0.1        0.14 ± 16%  perf-profile.children.cycles-pp.sysvec_call_function_single
      0.23 ±  9%      +0.1        0.28 ± 16%  perf-profile.children.cycles-pp.walk_component
      0.03 ±100%      +0.1        0.08 ± 16%  perf-profile.children.cycles-pp.__tmigr_cpu_activate
      0.09 ± 20%      +0.1        0.15 ± 17%  perf-profile.children.cycles-pp.asm_sysvec_call_function_single
      0.07 ± 10%      +0.1        0.13 ±  6%  perf-profile.children.cycles-pp.__hrtimer_next_event_base
      0.14 ±  6%      +0.1        0.20 ± 13%  perf-profile.children.cycles-pp.do_user_addr_fault
      0.01 ±223%      +0.1        0.07 ± 16%  perf-profile.children.cycles-pp.hrtimer_cancel
      0.01 ±223%      +0.1        0.07 ± 23%  perf-profile.children.cycles-pp.___perf_sw_event
      0.14 ±  6%      +0.1        0.21 ± 15%  perf-profile.children.cycles-pp.exc_page_fault
      0.22 ±  7%      +0.1        0.29 ± 10%  perf-profile.children.cycles-pp.__handle_mm_fault
      0.00            +0.1        0.07 ± 16%  perf-profile.children.cycles-pp.need_update
      0.23 ±  7%      +0.1        0.30 ±  8%  perf-profile.children.cycles-pp.clockevents_program_event
      0.19 ± 12%      +0.1        0.26 ±  4%  perf-profile.children.cycles-pp.evlist_cpu_iterator__next
      0.14 ± 11%      +0.1        0.22 ± 24%  perf-profile.children.cycles-pp.finish_task_switch
      0.24 ±  7%      +0.1        0.31 ± 10%  perf-profile.children.cycles-pp.handle_mm_fault
      0.00            +0.1        0.07 ± 16%  perf-profile.children.cycles-pp.quiet_vmstat
      0.11 ± 16%      +0.1        0.18 ± 13%  perf-profile.children.cycles-pp.hrtimer_next_event_without
      0.24 ± 14%      +0.1        0.31 ± 10%  perf-profile.children.cycles-pp.dequeue_entity
      0.22 ± 10%      +0.1        0.30 ± 14%  perf-profile.children.cycles-pp.lookup_fast
      0.17 ±  7%      +0.1        0.24 ± 12%  perf-profile.children.cycles-pp.asm_exc_page_fault
      0.17 ±  7%      +0.1        0.25 ± 18%  perf-profile.children.cycles-pp.cpuidle_governor_latency_req
      0.28 ± 10%      +0.1        0.36 ±  8%  perf-profile.children.cycles-pp.ct_kernel_exit_state
      0.00            +0.1        0.08 ± 18%  perf-profile.children.cycles-pp.rcu_tasks_trace_pregp_step
      0.28 ±  7%      +0.1        0.36 ± 10%  perf-profile.children.cycles-pp.worker_thread
      0.18 ± 10%      +0.1        0.27 ± 11%  perf-profile.children.cycles-pp.update_rq_clock_task
      0.63 ±  6%      +0.1        0.73 ±  6%  perf-profile.children.cycles-pp.ktime_get
      0.36 ± 10%      +0.1        0.46 ±  9%  perf-profile.children.cycles-pp.dequeue_entities
      0.28 ±  9%      +0.1        0.39 ±  9%  perf-profile.children.cycles-pp.sched_balance_update_blocked_averages
      0.30 ± 12%      +0.1        0.41 ±  7%  perf-profile.children.cycles-pp.sched_setaffinity
      0.37 ±  9%      +0.1        0.48 ±  9%  perf-profile.children.cycles-pp.dequeue_task_fair
      0.52 ±  9%      +0.1        0.64 ± 11%  perf-profile.children.cycles-pp.update_sg_lb_stats
      0.80 ±  8%      +0.1        0.93 ± 10%  perf-profile.children.cycles-pp.__static_call_transform
      0.80 ±  8%      +0.1        0.93 ± 10%  perf-profile.children.cycles-pp.text_poke_bp
      0.58 ±  8%      +0.1        0.71 ± 10%  perf-profile.children.cycles-pp.sched_balance_find_src_group
      0.58 ±  8%      +0.1        0.71 ± 10%  perf-profile.children.cycles-pp.update_sd_lb_stats
      0.34 ± 10%      +0.1        0.48 ± 10%  perf-profile.children.cycles-pp.cmd_stat
      0.34 ± 10%      +0.1        0.48 ± 10%  perf-profile.children.cycles-pp.dispatch_events
      0.34 ± 10%      +0.1        0.48 ±  9%  perf-profile.children.cycles-pp.process_interval
      0.33 ±  9%      +0.1        0.47 ±  9%  perf-profile.children.cycles-pp.read_counters
      0.36 ± 10%      +0.1        0.49 ± 11%  perf-profile.children.cycles-pp.handle_internal_command
      0.36 ± 10%      +0.1        0.49 ± 11%  perf-profile.children.cycles-pp.main
      0.36 ± 10%      +0.1        0.49 ± 11%  perf-profile.children.cycles-pp.run_builtin
      0.57 ±  8%      +0.1        0.71 ± 11%  perf-profile.children.cycles-pp.link_path_walk
      0.37 ±  8%      +0.1        0.52 ± 10%  perf-profile.children.cycles-pp.ct_kernel_enter
      0.19 ± 10%      +0.2        0.34 ±  7%  perf-profile.children.cycles-pp.tick_nohz_restart_sched_tick
      0.42 ±  8%      +0.2        0.58 ±  8%  perf-profile.children.cycles-pp.ct_idle_exit
      0.40 ± 12%      +0.2        0.56 ± 13%  perf-profile.children.cycles-pp.do_nanosleep
      0.44 ± 10%      +0.2        0.60 ± 10%  perf-profile.children.cycles-pp.schedule_idle
      0.26 ±  8%      +0.2        0.43 ± 14%  perf-profile.children.cycles-pp.raw_spin_rq_lock_nested
      0.41 ± 11%      +0.2        0.58 ± 13%  perf-profile.children.cycles-pp.hrtimer_nanosleep
      0.30 ± 10%      +0.2        0.47 ± 10%  perf-profile.children.cycles-pp.tick_nohz_stop_tick
      0.42 ± 11%      +0.2        0.59 ± 13%  perf-profile.children.cycles-pp.common_nsleep
      0.75 ±  8%      +0.2        0.92 ± 10%  perf-profile.children.cycles-pp.rest_init
      0.75 ±  8%      +0.2        0.92 ± 10%  perf-profile.children.cycles-pp.start_kernel
      0.75 ±  8%      +0.2        0.92 ± 10%  perf-profile.children.cycles-pp.x86_64_start_kernel
      0.75 ±  8%      +0.2        0.92 ± 10%  perf-profile.children.cycles-pp.x86_64_start_reservations
      0.28 ± 20%      +0.2        0.46 ±  9%  perf-profile.children.cycles-pp.tick_nohz_idle_exit
      0.44 ± 11%      +0.2        0.62 ± 12%  perf-profile.children.cycles-pp.__x64_sys_clock_nanosleep
      0.59 ±  6%      +0.2        0.79 ± 12%  perf-profile.children.cycles-pp.idle_cpu
      0.18 ±  3%      +0.2        0.38 ± 15%  perf-profile.children.cycles-pp.poll_idle
      0.72 ±  7%      +0.2        0.92 ±  9%  perf-profile.children.cycles-pp.__get_next_timer_interrupt
      0.58 ±  6%      +0.2        0.78 ± 10%  perf-profile.children.cycles-pp.get_nohz_timer_target
      0.89 ±  3%      +0.2        1.09 ±  8%  perf-profile.children.cycles-pp.tick_nohz_idle_stop_tick
      0.90 ±  7%      +0.2        1.11 ±  7%  perf-profile.children.cycles-pp.schedule
      0.79 ±  7%      +0.2        1.01 ±  9%  perf-profile.children.cycles-pp.start_dl_timer
      0.95 ±  7%      +0.2        1.18 ±  7%  perf-profile.children.cycles-pp.tick_nohz_next_event
      0.76 ±  7%      +0.2        1.00 ± 11%  perf-profile.children.cycles-pp.enqueue_dl_entity
      0.76 ±  6%      +0.2        1.01 ± 11%  perf-profile.children.cycles-pp.dl_server_start
      0.63 ± 11%      +0.2        0.87 ± 17%  perf-profile.children.cycles-pp._nohz_idle_balance
      0.61 ±  9%      +0.2        0.86 ± 15%  perf-profile.children.cycles-pp.clock_nanosleep
      0.79 ±  4%      +0.3        1.10 ± 11%  perf-profile.children.cycles-pp.__hrtimer_start_range_ns
      0.58 ±  4%      +0.3        0.89 ±  8%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
      1.15 ±  9%      +0.3        1.47 ± 14%  perf-profile.children.cycles-pp.handle_softirqs
      1.02 ±  5%      +0.3        1.34 ± 10%  perf-profile.children.cycles-pp.ttwu_do_activate
      1.02 ±  4%      +0.3        1.35 ± 11%  perf-profile.children.cycles-pp.enqueue_task_fair
      0.92 ±  5%      +0.3        1.25 ± 11%  perf-profile.children.cycles-pp.hrtimer_wakeup
      0.96 ±  6%      +0.3        1.29 ± 10%  perf-profile.children.cycles-pp.hrtimer_start_range_ns
      1.04 ±  4%      +0.3        1.37 ± 11%  perf-profile.children.cycles-pp.enqueue_task
      0.82 ± 23%      +0.4        1.20 ± 15%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      1.09 ±  3%      +0.4        1.46 ± 11%  perf-profile.children.cycles-pp.try_to_wake_up
      1.34 ±  6%      +0.4        1.72 ±  7%  perf-profile.children.cycles-pp.__schedule
      2.00 ±  6%      +0.4        2.39 ±  6%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      2.31 ±  5%      +0.4        2.76 ±  5%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.61 ± 30%      +0.5        1.07 ± 22%  perf-profile.children.cycles-pp.tick_do_update_jiffies64
      2.35 ±  5%      +0.5        2.82 ±  5%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      1.18 ± 16%      +0.5        1.70 ± 13%  perf-profile.children.cycles-pp.tick_irq_enter
      1.22 ± 15%      +0.5        1.75 ± 13%  perf-profile.children.cycles-pp.irq_enter_rcu
      1.67 ±  3%      +0.6        2.32 ±  8%  perf-profile.children.cycles-pp.menu_select
      3.61 ±  5%      +0.8        4.39 ±  8%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      4.42 ±  8%      +0.8        5.24 ±  9%  perf-profile.children.cycles-pp.ring_buffer_empty_cpu
      4.74 ±  7%      +0.8        5.56 ±  9%  perf-profile.children.cycles-pp.trace_find_next_entry_inc
      4.74 ±  7%      +0.8        5.56 ±  9%  perf-profile.children.cycles-pp.__find_next_entry
      3.78 ±  5%      +0.8        4.62 ±  8%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      5.01 ±  7%      +0.9        5.87 ±  9%  perf-profile.children.cycles-pp.tracing_read_pipe
      2.86 ±  7%      +0.9        3.74 ±  5%  perf-profile.children.cycles-pp._raw_spin_lock
      5.18 ±  6%      +0.9        6.08 ±  4%  perf-profile.children.cycles-pp.sysvec_call_function
      5.22 ±  7%      +0.9        6.13 ±  9%  perf-profile.children.cycles-pp.vfs_read
      5.22 ±  7%      +0.9        6.15 ±  9%  perf-profile.children.cycles-pp.ksys_read
      5.25 ±  7%      +0.9        6.19 ±  9%  perf-profile.children.cycles-pp.read
      6.74 ±  5%      +1.0        7.78 ±  5%  perf-profile.children.cycles-pp.asm_sysvec_call_function
     23.06 ±  3%      +3.5       26.52 ±  9%  perf-profile.children.cycles-pp.intel_idle_xstate
      0.00            +6.2        6.23 ±  8%  perf-profile.children.cycles-pp.smp_call_function_single
      0.00            +6.3        6.26 ±  8%  perf-profile.children.cycles-pp.trc_wait_for_one_reader
      0.00            +6.3        6.28 ±  8%  perf-profile.children.cycles-pp.check_all_holdout_tasks_trace
      0.00            +6.4        6.36 ±  8%  perf-profile.children.cycles-pp.rcu_tasks_wait_gp
      0.00            +6.4        6.37 ±  8%  perf-profile.children.cycles-pp.rcu_tasks_kthread
      0.00            +6.4        6.37 ±  8%  perf-profile.children.cycles-pp.rcu_tasks_one_gp
     37.33 ±  3%      +6.5       43.84 ±  8%  perf-profile.children.cycles-pp.cpuidle_enter_state
     37.38 ±  3%      +6.5       43.90 ±  8%  perf-profile.children.cycles-pp.cpuidle_enter
      0.74 ±  6%      +6.6        7.35 ±  8%  perf-profile.children.cycles-pp.kthread
      0.74 ±  6%      +6.6        7.36 ±  8%  perf-profile.children.cycles-pp.ret_from_fork
      0.74 ±  6%      +6.6        7.37 ±  8%  perf-profile.children.cycles-pp.ret_from_fork_asm
     40.58 ±  3%      +7.5       48.12 ±  8%  perf-profile.children.cycles-pp.cpuidle_idle_call
     41.34 ±  3%      +8.1       49.41 ±  8%  perf-profile.children.cycles-pp.start_secondary
     42.10 ±  3%      +8.2       50.33 ±  8%  perf-profile.children.cycles-pp.common_startup_64
     42.10 ±  3%      +8.2       50.33 ±  8%  perf-profile.children.cycles-pp.cpu_startup_entry
     42.09 ±  3%      +8.2       50.33 ±  8%  perf-profile.children.cycles-pp.do_idle
     30.89 ±  8%     -14.7       16.21 ± 43%  perf-profile.self.cycles-pp.osq_lock
      3.04 ± 14%      -1.1        1.98 ±  9%  perf-profile.self.cycles-pp.mutex_spin_on_owner
      0.41 ±  5%      -0.1        0.28 ± 14%  perf-profile.self.cycles-pp.ring_buffer_reset_online_cpus
      0.05 ±  7%      +0.0        0.08 ± 15%  perf-profile.self.cycles-pp.irq_work_needs_cpu
      0.05 ± 45%      +0.0        0.08 ±  7%  perf-profile.self.cycles-pp.tmigr_cpu_new_timer
      0.07 ± 18%      +0.0        0.11 ± 11%  perf-profile.self.cycles-pp.__update_blocked_fair
      0.17 ± 11%      +0.0        0.21 ±  8%  perf-profile.self.cycles-pp.call_cpuidle
      0.12 ± 12%      +0.0        0.16 ± 15%  perf-profile.self.cycles-pp.do_idle
      0.09 ± 15%      +0.0        0.12 ± 12%  perf-profile.self.cycles-pp.tsc_verify_tsc_adjust
      0.15 ±  6%      +0.0        0.19 ± 15%  perf-profile.self.cycles-pp.tick_nohz_next_event
      0.08 ± 21%      +0.0        0.12 ± 12%  perf-profile.self.cycles-pp.tick_nohz_stop_tick
      0.09 ± 15%      +0.0        0.13 ± 12%  perf-profile.self.cycles-pp.lapic_next_deadline
      0.04 ± 71%      +0.0        0.08 ± 17%  perf-profile.self.cycles-pp.update_irq_load_avg
      0.07 ± 16%      +0.0        0.12 ±  9%  perf-profile.self.cycles-pp.__hrtimer_next_event_base
      0.01 ±223%      +0.1        0.06 ± 13%  perf-profile.self.cycles-pp.kmem_cache_alloc_noprof
      0.01 ±223%      +0.1        0.06 ± 14%  perf-profile.self.cycles-pp.__d_lookup
      0.01 ±223%      +0.1        0.06 ± 11%  perf-profile.self.cycles-pp.menu_reflect
      0.14 ± 11%      +0.1        0.20 ± 12%  perf-profile.self.cycles-pp.update_rq_clock_task
      0.15 ± 12%      +0.1        0.23 ± 13%  perf-profile.self.cycles-pp.ct_kernel_enter
      0.38 ±  8%      +0.1        0.46 ±  6%  perf-profile.self.cycles-pp.update_sg_lb_stats
      0.27 ± 10%      +0.1        0.35 ±  9%  perf-profile.self.cycles-pp.ct_kernel_exit_state
      0.26 ± 10%      +0.1        0.35 ± 12%  perf-profile.self.cycles-pp.cpuidle_idle_call
      0.27 ±  7%      +0.1        0.38 ± 11%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      1.03 ±  6%      +0.1        1.17 ±  6%  perf-profile.self.cycles-pp.__flush_smp_call_function_queue
      0.82 ±  6%      +0.1        0.96 ±  7%  perf-profile.self.cycles-pp.ring_buffer_empty_cpu
      0.57 ±  6%      +0.2        0.76 ±  8%  perf-profile.self.cycles-pp.idle_cpu
      0.17 ±  4%      +0.2        0.36 ± 16%  perf-profile.self.cycles-pp.poll_idle
      0.88 ±  3%      +0.2        1.11 ±  8%  perf-profile.self.cycles-pp.menu_select
      2.29 ±  5%      +0.3        2.61 ±  8%  perf-profile.self.cycles-pp.cpuidle_enter_state
      0.82 ± 23%      +0.4        1.20 ± 15%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      2.13 ±  6%      +0.5        2.62 ±  9%  perf-profile.self.cycles-pp._raw_spin_lock
     23.00 ±  3%      +3.4       26.44 ±  9%  perf-profile.self.cycles-pp.intel_idle_xstate
      0.00            +6.2        6.17 ±  8%  perf-profile.self.cycles-pp.smp_call_function_single





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

