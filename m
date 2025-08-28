Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827DF2D29B7;
	Thu, 28 Aug 2025 08:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756370616; cv=fail; b=gEc3VOHTMNzG2F0ita/p4rrCRrLMw+g4Et6WW7oX79LtBgFmIzC1VnjzKlAt+BABkrWLaUdHub+Xx1aNsKztvOug9cajLSEGAJaqSI2x8EfgjLzXkxpY3yK6rQgusUnoJKw4aoEJpuL2JIbDSztVqntjUeTdkeN53TDzdFo5+Nk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756370616; c=relaxed/simple;
	bh=ofrjOV7eeLCeq2bYGdIqX/6RyDSczkS60/ObRaiwyVI=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=RT9UWvMh6yE9smrLMdKLeo+QsqoO/oR9uGdo9QU1k640zxgjYNwer8ftN8gUsqRmf9U/HYJ60WTNZ7khDtnCc6qVy5l8usu4w8lHI8VQpgxJKFxIBXJy4yhDhnuMy63LEAtzFHbUrvQP3+ZX56Zpvc3CwbFFSr92gVwK07AaVIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kS+exFj2; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kS+exFj2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756370614; x=1787906614;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ofrjOV7eeLCeq2bYGdIqX/6RyDSczkS60/ObRaiwyVI=;
  b=kS+exFj2oM4ssu+B3axgEtAKhRfppTo+W/vULkV4CSn2JdNZIEXqj/WW
   EkY4mTW+vWwez8pgH4YfvPNTWH8DkgeOXOjREUy44RO7551CAF0xrdD4A
   q7aOz3eJz9eN5gpOyGYi5N+7wXbMjEgfhP2uS7jOdqBIiBnpMxsKovDsr
   BsUYvan9P2slMSITwoO5v2ULWgfSOwn8CWDHPDXklRLVcT+Q6a8apn0C4
   tPczc/vLjwy37Z134YC4617JojLLnBS0jdQ3fia9q8xT7LpMH86bB0G0C
   EjihkdKI4gId2ckXWBXzZ8PS27SVfV2ZY7dUA74nGSAjzdZzUehEVLDEq
   Q==;
X-CSE-ConnectionGUID: aamriXLGReOYkoG5ud8gWA==
X-CSE-MsgGUID: fVDleHTSRvGXF2AqVgiWdw==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="58733045"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="58733045"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 01:43:34 -0700
X-CSE-ConnectionGUID: o1vhJwzWStGbCIZDHb6yUg==
X-CSE-MsgGUID: urBwGpeXSlqCv2G3yrRXcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="170227117"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 01:43:33 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 01:43:32 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 28 Aug 2025 01:43:32 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.51)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 01:43:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ael4om5zPdPA9mkeonrDfANG5/MdhAn4K8jX8G+sysobIBuivGcdPbWSCtoP8Uw7T3FDNuynzSrzF1M7dq0GVlIq0Db+dv9Q/Yp8TeNfuHx7WafWJIbjrkVVNqayg3AeeXA7YBHcj9IeihjMHe+Apw4YuBWIVU4QCcBMEHmCXDz4ImQN7D8beusG6kkiAiMOyCQantxLXuw1WXSJCfhj7KfVlaeQauBpPV3m2yn0DlGNPv/fC8jOFjCmwhwj92Ww9z1nOz6FjYpUJMsUdY4zCB1FArgBT/kzkXwTB7H+abLMghm3Y9KfCniGatw0t1tY4YOb5pET4kNX+K6s2iQWIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IS3HTK3VWivdVI5P6/hCyij7e6zjCALrgItDSARx6nY=;
 b=tkWiAJd/ba89JnZPmSzON5PkRovNWLbe1OVA5dKKtFsRr2ixKAimyKjj4eVWvoG9Y7a58zKBQxsef9RFhZNg0N3kisgoY4KNetkKwZqtvEyhOFUY1jzoT2ogf/6B9pLD+JbrlCLbNs+q/DVsPOM/lKsIqjFO/60Vt5SAv7VgyL+9fc8nBLiZlXcE8ZAFo5QtSip23DoRkv60mIGkbSzAPoU0mLk6qJD5WlC2Utm/0FXMpR/O7vrrvwAsILof0IbdXryM0xLEpK960wX+jplR8pzyVl/IYo2AM7iOVLMGRcYEIGoh8JOHOl5m0qM+5EUYPndD84hwx6GYrKHRvhpUQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SJ0PR11MB5894.namprd11.prod.outlook.com (2603:10b6:a03:42a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.13; Thu, 28 Aug
 2025 08:43:16 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9052.019; Thu, 28 Aug 2025
 08:43:16 +0000
Date: Thu, 28 Aug 2025 16:43:07 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Menglong Dong <menglong8.dong@gmail.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Masami Hiramatsu
	<mhiramat@kernel.org>, Menglong Dong <dongml2@chinatelecom.cn>,
	<linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linux-next:master] [tracing]  dfe0d675df:
 WARNING:suspicious_RCU_usage
Message-ID: <202508281655.54c87330-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR02CA0091.apcprd02.prod.outlook.com
 (2603:1096:4:90::31) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SJ0PR11MB5894:EE_
X-MS-Office365-Filtering-Correlation-Id: c57e0306-ca0e-477e-a4ce-08dde60eee68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WflSno/6ZCLQmyQXd0qr9W3DSBmH7BRdEKPruq4fkVBkBS+2APzi+Fokk2z0?=
 =?us-ascii?Q?atlzj/wHTR7Z34a2DF32wTSACbXIvW3d+KqLXrOSrYWWhpYS9jwtTmMAtdl6?=
 =?us-ascii?Q?TVh1orbA3Lab3sDfFV3nwDqVZ5Ju2LWhydIcpY+g4rZQzjc60QrCQEd2iqCh?=
 =?us-ascii?Q?afJabdp+nEODbX0z+lsHRluFByWIxHQOQ8kWte+LMoXWOVihCFfIbh7vnUK4?=
 =?us-ascii?Q?4RRU9rqKcewZwCl6oLh1/UD20fSVszPqyEOnkvaQJAgs6NJwehqE5NRM7t4R?=
 =?us-ascii?Q?ZxNEgZgoaV1ua7nRwLdnF1iry+dPGXqpBM3Pn8OFhpaWLkUq/BSukbMQ0oHK?=
 =?us-ascii?Q?INRyzsC+EUqDU9lljE5rmnmnCoZVGy/42w5+48E+lDao+qmRcVwnI7lqhCAP?=
 =?us-ascii?Q?bBeTnVswQGTi5DS3h/yoyuDi1L4lHJL5otqCONX/woabkP7imailX6EpFUGZ?=
 =?us-ascii?Q?3Xf2aw7wkxGpqM3PVXI37qkagfMyTyXu1M8+PrqO+s2Gd6n7yw1g5U7fPbDB?=
 =?us-ascii?Q?Ji/LxQFn+ZbuVPefJ88z6tmBndBevpgN4XwUjX1Pcif/W2m4DfPgDHizEDWK?=
 =?us-ascii?Q?Ww73bwIrL0S9zdA9CtFxLpo/b8MpPjcH+mqSVsSqfePSzZbsmE5lDxTqXQC8?=
 =?us-ascii?Q?kPtop+WgEmFUo3i6bQKRx1czy3J7UJRitnPhmHEwio9ytoNHe3vYdH1ufWKl?=
 =?us-ascii?Q?AfJ1tDeJQgq7tVt3NZ7ss7Qej8sLQOTpKrp9NhJd79tUUTiRc1ae/SfbbW9u?=
 =?us-ascii?Q?h+CRYvSqCOS2Yk1vAsPBaPmUjXKTg3JRvMuD+pP9IMtcb1OUA98eTlg20ygN?=
 =?us-ascii?Q?rPkat/tCWfd1Q2J8BsyFkMj2MN/25WRBnAQDhPD0rSK1mAte1X7bb3r8jYV4?=
 =?us-ascii?Q?SVWmaz3nJE8YsQD723HNpSBCPGwTtuFMJbwKwYm0Dtf+s17OBJLjlSEuwOaQ?=
 =?us-ascii?Q?EjcZNGgE5qdHe+whZo+zuxIOhjQeXUsVk+fkmTpfMUMgdU/JsRVQWSfB5s+N?=
 =?us-ascii?Q?vMvstiwZnjEL6aB8TKwauk0o0gmQqRUsRSzuuNdNbJ7BoU7VQkqK0GP3wbLg?=
 =?us-ascii?Q?X4tWvbGMJJUxvkyL7iZCvtLupO7C0zfhWsYNrsl1XRMv8VROvFDG3hrw24qj?=
 =?us-ascii?Q?Hy3j+z4mPiZnxKgqTLl3ARnXPO1PjG3vhATVCfpxHJsGBrnDUZwE1+qjr39O?=
 =?us-ascii?Q?e+v1E71/WlNGPrz7FmK7aVHLV6kBIvlTlIg/4xvP1UNVcnSE2DRGWnod//Jb?=
 =?us-ascii?Q?6BAZTJlpPMVBkoxTziMtrDh3XVYOkdoKIufNOrK7FH7w7KVigy4X53NDPQ8m?=
 =?us-ascii?Q?QnbAPdW/rL5ntLp6VDaGdlYMHg3yIoMNl7Zyo5G+CJVKEwDmjLakSL56Ex20?=
 =?us-ascii?Q?9qjF/5/xKQyFqCFeBmIYuyZf4HDp?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D5MVUludqZbs+/OrjiclNQmZ8tCBzYod+mAukbn57IGTfn5pZPrXTGLk9yJZ?=
 =?us-ascii?Q?KAXdhfQqyGmXRkE+13QkSWNxg6FP3yRrM64foEJUxG+7eLDhxpyRix3o8cu6?=
 =?us-ascii?Q?Pxnj6TbYpseE19SU71bnJLdJtNrspqH4Ly1dZuS9SQkGaHy+wP9m2ooVwzOo?=
 =?us-ascii?Q?s+GC8pQmo6NYUfXaqX6PTEImrvcHtq3K2v71H0IOY13aCRlqq/7MzQkrf72b?=
 =?us-ascii?Q?+3GOHnCZJQdihvumlqE8E+PIxhLusGqnlGet4AhxV68Hr8mEV5OK+hYq4j5p?=
 =?us-ascii?Q?py7jRy3Jne4eLyfZGZlWINgBqBhGTkzqO+ZH+rdoa0NoJm7NJyYzuEbdaclO?=
 =?us-ascii?Q?j+VQFo0V2yBrUDJxfJjl4rv8zyieSj1l1umtGUlBzh/udleAHwotT1cwZXVs?=
 =?us-ascii?Q?4MmGw3MlfxuHdQE6hgQo8xVZ9+PhatZbKfMtYdqf5SlfZ1m4XVibhejVTvZP?=
 =?us-ascii?Q?JVA2HLAIFoAaj0kSA6ChrfrI9j90X/yMARluIGSXHD7pzqLerfrQYlrL+9v9?=
 =?us-ascii?Q?eZIVwtiUBAGvXOWvPGS32z6HSaRkv2DJ2FErpr5FTkeNlB+NcW65SdBws6WD?=
 =?us-ascii?Q?9uyR1uEEnj+dcSGyfPK/Om9I5aV0X2KsijAP8PMLHbF4BmA425a3OBdUXd7S?=
 =?us-ascii?Q?HHgn+H4T0n9311z67xD7poYreozdpkx2oQV49eOpZeGgoXpRm0GwybkC/SJE?=
 =?us-ascii?Q?BCtLJFeRQAQeoCJkndDgbVePshtYiShUYzUc+ei02sWuqm5HiEUBBh/hSnoE?=
 =?us-ascii?Q?5bNRSfa4d2SCbH3hT0nK70eAIKQACXcX2cbBIGSeu5fB/b4PZi4YK1lJChvP?=
 =?us-ascii?Q?3Gs7pmS45VndndfsGSV26MVbRIV7XZugCD7ReS7Nsdysxzpz15opLx363/d7?=
 =?us-ascii?Q?UdG/jCWjl39hhQ62dnzhEOvVPiHokdiPrgBkzpU3jjhDt4QS1FvafchJ+jCF?=
 =?us-ascii?Q?LSruTSMkHDKRooXtzJTVtYMptIeNsfSAHcimr7A7nEIJllB/w32Iy/lnE6/9?=
 =?us-ascii?Q?T2mkFnlo+dPiagkuFKG6W4kaI/GEE4IFzexjOCTTVGRBuvhsgE0ksU7QLc0p?=
 =?us-ascii?Q?W+1T768SPCbRqkcWtti1M14IROj7gT+raCc2yWa1VP3i7rmkvEeE2u+ONDVV?=
 =?us-ascii?Q?JyRHFzaN1f07g01T0U8vZLU1qY8et0vLAt03j36slMYjf/2rnX4uf1/6y+5e?=
 =?us-ascii?Q?0uOYnK4TDAGdDb/wZTaLOWY5aYJB9yzV+oWR5zPNvEKX4zhxkgfH6jCDfFdn?=
 =?us-ascii?Q?dx9LjxLX3xcslyY9G/rz+oHKGTyefjsL9jJyb9m/l39nfv2kx8y5M7z2ytm7?=
 =?us-ascii?Q?L5uJax1CdCAafF9JgfqY1esojTaAnWfK29A2kwJvAi9ThIFwnmlTN9eWmTgD?=
 =?us-ascii?Q?787DvWei967bG15WCvJC/pUGECRv5TJauuKPMYxFdi34hmzrJy34mQjq67Cy?=
 =?us-ascii?Q?H93fGmVbQn+YzjJoVVBCV9gJ0pTpxFNDhhCAdGVmUAoUQcoNpbi32+kEmWyR?=
 =?us-ascii?Q?U26AE7p20Ckpgnefh4u3hWrw9AtMNAR8pFr43UOprr6hbC4b/EUgMEm61olR?=
 =?us-ascii?Q?sRVLSZ4cPjx8moVwz0nWCWUdfwwk30IOmlQpZqSig2rehApb8g+a1QAsTTjZ?=
 =?us-ascii?Q?eg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c57e0306-ca0e-477e-a4ce-08dde60eee68
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 08:43:16.1310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4m5xsbmeCR9F5DkFsErM1K0MA5d4PMc47h+1+LP5fFXulI4pnM6qQ7qF2Wru2Go+jeQ01qtWfj4DBfVrIs3ivg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5894
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:suspicious_RCU_usage" on:

commit: dfe0d675df82fb9297ff98253b9c3042fdab5544 ("tracing: fprobe: use rhltable for fprobe_ip_table")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master d0630b758e593506126e8eda6c3d56097d1847c5]

in testcase: kernel-selftests-bpf
version: 
with following parameters:

	group: ftrace



config: x86_64-rhel-9.4-bpf
compiler: gcc-12
test machine: 4 threads Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz (Skylake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202508281655.54c87330-lkp@intel.com


[  354.896751][ T4652] =============================
[  354.901528][ T4652] WARNING: suspicious RCU usage
[  354.906255][ T4652] 6.17.0-rc1-00001-gdfe0d675df82 #1 Tainted: G S        I
[  354.913924][ T4652] -----------------------------
[  354.918654][ T4652] include/linux/rhashtable.h:602 suspicious rcu_dereference_check() usage!
[  354.927114][ T4652]
[  354.927114][ T4652] other info that might help us debug this:
[  354.927114][ T4652]
[  354.937180][ T4652]
[  354.937180][ T4652] rcu_scheduler_active = 2, debug_locks = 1
[  354.945106][ T4652] no locks held by ftracetest/4652.
[  354.950167][ T4652]
[  354.950167][ T4652] stack backtrace:
[  354.955924][ T4652] CPU: 1 UID: 0 PID: 4652 Comm: ftracetest Tainted: G S        I         6.17.0-rc1-00001-gdfe0d675df82 #1 PREEMPT(voluntary)
[  354.955948][ T4652] Tainted: [S]=CPU_OUT_OF_SPEC, [I]=FIRMWARE_WORKAROUND
[  354.955950][ T4652] Hardware name: Dell Inc. OptiPlex 7040/0Y7WYT, BIOS 1.1.1 10/07/2015
[  354.955966][ T4652] Call Trace:
[  354.955968][ T4652]  <TASK>
[  354.955971][ T4652]  dump_stack_lvl+0x7c/0x90
[  354.955978][ T4652]  lockdep_rcu_suspicious+0x14f/0x1c0
[  354.955987][ T4652]  __rhashtable_lookup+0x1e0/0x260
[  354.955994][ T4652]  ? __pfx_kernel_clone+0x10/0x10
[  354.956000][ T4652]  fprobe_entry+0x9a/0x450
[  354.956017][ T4652]  ? __lock_acquire+0x6b0/0xca0
[  354.956022][ T4652]  ? find_held_lock+0x2b/0x80
[  354.956041][ T4652]  ? __pfx_fprobe_entry+0x10/0x10
[  354.956045][ T4652]  ? __pfx_kernel_clone+0x10/0x10
[  354.956049][ T4652]  ? lock_acquire+0x14c/0x2d0
[  354.956053][ T4652]  ? __might_fault+0x74/0xc0
[  354.956063][ T4652]  function_graph_enter_regs+0x2a0/0x550
[  354.956067][ T4652]  ? __do_sys_clone+0xb5/0x100
[  354.956076][ T4652]  ? __pfx_function_graph_enter_regs+0x10/0x10
[  354.956080][ T4652]  ? _copy_to_user+0x58/0x70
[  354.956084][ T4652]  ? __pfx_kernel_clone+0x10/0x10
[  354.956088][ T4652]  ? __x64_sys_rt_sigprocmask+0x114/0x180
[  354.956093][ T4652]  ? __pfx___x64_sys_rt_sigprocmask+0x10/0x10
[  354.956099][ T4652]  ? __pfx_kernel_clone+0x10/0x10
[  354.956103][ T4652]  ftrace_graph_func+0x87/0xb0
[  354.956110][ T4652]  0xffffffffc0547095
[  354.956118][ T4652]  ? __pfx_handle_pte_fault+0x10/0x10
[  354.956126][ T4652]  ? kernel_clone+0x5/0x560
[  354.956132][ T4652]  kernel_clone+0x5/0x560
[  354.956136][ T4652]  __do_sys_clone+0xb5/0x100
[  354.956140][ T4652]  ? __pfx___do_sys_clone+0x10/0x10
[  354.956154][ T4652]  ? __might_fault+0x74/0xc0
[  354.956159][ T4652]  ? tracer_hardirqs_on+0x61/0x170
[  354.956166][ T4652]  ? __x64_sys_clone+0x4d/0x70
[  354.956172][ T4652]  do_syscall_64+0x8c/0x390
[  354.956177][ T4652]  ? __pfx___x64_sys_rt_sigprocmask+0x10/0x10
[  354.956181][ T4652]  ? handle_mm_fault+0x198/0x540
[  354.956186][ T4652]  ? exc_page_fault+0x57/0xb0
[  354.956192][ T4652]  ? lock_release+0x6c/0x130
[  354.956196][ T4652]  ? tracer_hardirqs_on+0x61/0x170
[  354.956201][ T4652]  ? do_user_addr_fault+0x400/0x730
[  354.956209][ T4652]  ? do_syscall_64+0x169/0x390
[  354.956213][ T4652]  ? lockdep_hardirqs_on_prepare+0xd7/0x190
[  354.956220][ T4652]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  354.956225][ T4652] RIP: 0033:0x7ff812c54353
[  354.956229][ T4652] Code: 00 00 00 00 00 66 90 64 48 8b 04 25 10 00 00 00 45 31 c0 31 d2 31 f6 bf 11 00 20 01 4c 8d 90 d0 02 00 00 b8 38 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 35 89 c2 85 c0 75 2c 64 48 8b 04 25 10 00 00
[  354.956233][ T4652] RSP: 002b:00007ffdebe44c98 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
[  354.956237][ T4652] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007ff812c54353
[  354.956240][ T4652] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
[  354.956243][ T4652] RBP: 0000000000000000 R08: 0000000000000000 R09: 000055a6ea2c1f90
[  354.956245][ T4652] R10: 00007ff812b7ee50 R11: 0000000000000246 R12: 0000000000000001
[  354.956248][ T4652] R13: 00007ffdebe44ed0 R14: 000055a6bd29eb08 R15: 000055a6ea2c33e0
[  354.956260][ T4652]  </TASK>
[  354.956262][ T4652]
[  355.255635][ T4652] =============================
[  355.260334][ T4652] WARNING: suspicious RCU usage
[  355.265034][ T4652] 6.17.0-rc1-00001-gdfe0d675df82 #1 Tainted: G S        I
[  355.272672][ T4652] -----------------------------
[  355.277375][ T4652] include/linux/rhashtable.h:376 suspicious rcu_dereference_check() usage!
[  355.285767][ T4652]
[  355.285767][ T4652] other info that might help us debug this:
[  355.285767][ T4652]
[  355.295845][ T4652]
[  355.295845][ T4652] rcu_scheduler_active = 2, debug_locks = 1
[  355.303744][ T4652] no locks held by ftracetest/4652.
[  355.308785][ T4652]
[  355.308785][ T4652] stack backtrace:
[  355.314561][ T4652] CPU: 1 UID: 0 PID: 4652 Comm: ftracetest Tainted: G S        I         6.17.0-rc1-00001-gdfe0d675df82 #1 PREEMPT(voluntary)
[  355.314569][ T4652] Tainted: [S]=CPU_OUT_OF_SPEC, [I]=FIRMWARE_WORKAROUND
[  355.314571][ T4652] Hardware name: Dell Inc. OptiPlex 7040/0Y7WYT, BIOS 1.1.1 10/07/2015
[  355.314573][ T4652] Call Trace:
[  355.314575][ T4652]  <TASK>
[  355.314578][ T4652]  dump_stack_lvl+0x7c/0x90
[  355.314585][ T4652]  lockdep_rcu_suspicious+0x14f/0x1c0
[  355.314594][ T4652]  __rhashtable_lookup+0x181/0x260
[  355.314600][ T4652]  ? __pfx_kernel_clone+0x10/0x10
[  355.314606][ T4652]  fprobe_entry+0x9a/0x450
[  355.314610][ T4652]  ? __lock_acquire+0x6b0/0xca0
[  355.314615][ T4652]  ? find_held_lock+0x2b/0x80
[  355.314621][ T4652]  ? __pfx_fprobe_entry+0x10/0x10
[  355.314625][ T4652]  ? __pfx_kernel_clone+0x10/0x10
[  355.314629][ T4652]  ? lock_acquire+0x14c/0x2d0
[  355.314646][ T4652]  ? __might_fault+0x74/0xc0
[  355.314655][ T4652]  function_graph_enter_regs+0x2a0/0x550
[  355.314659][ T4652]  ? __do_sys_clone+0xb5/0x100
[  355.314667][ T4652]  ? __pfx_function_graph_enter_regs+0x10/0x10
[  355.314671][ T4652]  ? _copy_to_user+0x58/0x70
[  355.314675][ T4652]  ? __pfx_kernel_clone+0x10/0x10
[  355.314679][ T4652]  ? __x64_sys_rt_sigprocmask+0x114/0x180
[  355.314684][ T4652]  ? __pfx___x64_sys_rt_sigprocmask+0x10/0x10
[  355.314689][ T4652]  ? __pfx_kernel_clone+0x10/0x10
[  355.314694][ T4652]  ftrace_graph_func+0x87/0xb0
[  355.314701][ T4652]  0xffffffffc0547095
[  355.314708][ T4652]  ? __pfx_handle_pte_fault+0x10/0x10
[  355.314716][ T4652]  ? kernel_clone+0x5/0x560
[  355.314722][ T4652]  kernel_clone+0x5/0x560
[  355.314725][ T4652]  __do_sys_clone+0xb5/0x100
[  355.314730][ T4652]  ? __pfx___do_sys_clone+0x10/0x10
[  355.314743][ T4652]  ? __might_fault+0x74/0xc0
[  355.314748][ T4652]  ? tracer_hardirqs_on+0x61/0x170
[  355.314755][ T4652]  ? __x64_sys_clone+0x4d/0x70
[  355.314761][ T4652]  do_syscall_64+0x8c/0x390
[  355.314766][ T4652]  ? __pfx___x64_sys_rt_sigprocmask+0x10/0x10
[  355.314770][ T4652]  ? handle_mm_fault+0x198/0x540
[  355.314775][ T4652]  ? exc_page_fault+0x57/0xb0
[  355.314780][ T4652]  ? lock_release+0x6c/0x130
[  355.314785][ T4652]  ? tracer_hardirqs_on+0x61/0x170
[  355.314789][ T4652]  ? do_user_addr_fault+0x400/0x730
[  355.314796][ T4652]  ? do_syscall_64+0x169/0x390
[  355.314801][ T4652]  ? lockdep_hardirqs_on_prepare+0xd7/0x190
[  355.314808][ T4652]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  355.314812][ T4652] RIP: 0033:0x7ff812c54353
[  355.314816][ T4652] Code: 00 00 00 00 00 66 90 64 48 8b 04 25 10 00 00 00 45 31 c0 31 d2 31 f6 bf 11 00 20 01 4c 8d 90 d0 02 00 00 b8 38 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 35 89 c2 85 c0 75 2c 64 48 8b 04 25 10 00 00
[  355.314819][ T4652] RSP: 002b:00007ffdebe44c98 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
[  355.314824][ T4652] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007ff812c54353
[  355.314827][ T4652] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
[  355.314829][ T4652] RBP: 0000000000000000 R08: 0000000000000000 R09: 000055a6ea2c1f90
[  355.314831][ T4652] R10: 00007ff812b7ee50 R11: 0000000000000246 R12: 0000000000000001
[  355.314834][ T4652] R13: 00007ffdebe44ed0 R14: 000055a6bd29eb08 R15: 000055a6ea2c33e0
[  355.314846][ T4652]  </TASK>



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250828/202508281655.54c87330-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

