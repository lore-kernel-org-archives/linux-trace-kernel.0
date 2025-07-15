Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C97126D4F2;
	Tue, 15 Jul 2025 07:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752564750; cv=fail; b=dMxxcN+bl/9OEInznHAmwqSA0Wde7uNQ1x1x9cLE9fKVh/Xopg2S+/fvPMRKK+FKlKoj1sHGeiokMhsKTEZG4TkFPXWHe0ExFhqmJl8oIKes0G2J5G3DgUyQGweSsXHKOTrFWP2QzQYiSJkVbZsQTn5zxqThUkzwsdM1BnpceCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752564750; c=relaxed/simple;
	bh=4/GKbYOlh7gdSTrmLPUwSJrVtGISJ3FChN+U3rWGhng=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AO6X/dyhP+bQbtiRHb7Q8I3zv8tbDRuQ+1OdtKN8kCUPzshZh1KJp6yq6CNdFQqnSveVPeJ6VvWaQEt1OIIApej1nfVu2MzDBJ9B6UGy76pdmOAHGngHiqPwwTxicpFIV/vzEBobAfFoR1N9xtdN+FzdjoPaloT7aRwEACOMBb0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mNRQl2Gh; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mNRQl2Gh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752564746; x=1784100746;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=4/GKbYOlh7gdSTrmLPUwSJrVtGISJ3FChN+U3rWGhng=;
  b=mNRQl2Ghxe24+reZ0JBy5K0JGn8w6CxXgyV/CQHjtuIXmfI1jslpcmjM
   RLbihtRZ7vBI/QNjPjOEYgpvOiR3fNDqKxO72FvDs2PSr6kmqaA3IuYS5
   F+ePZLuTgcfXdivRpNVgQ+XaAyxm+WAbgAvjw8/KIu4+vaSR3faoJdRzE
   TkQemRb3QNXuvcRAYTkFwYpVwh2sVCn3Tm8RxfNXRU+BsaAHNjo/A1Z5p
   Pn3J1k9B/Q3jEiuMgT4OChLIyMygiYzhEtR/PDC2o7l8gNoyoa4aI1Ck0
   4LtOS1n5cY1gllXw2hqjtrQiU60Nhefi4L8n10q9of3lzDqG+8vnzq5oQ
   g==;
X-CSE-ConnectionGUID: MSsJEhDMR0Kqm5fWFMqtDA==
X-CSE-MsgGUID: LzTlzZcASA+7cyOsYoeTrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="54927106"
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; 
   d="scan'208";a="54927106"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 00:32:25 -0700
X-CSE-ConnectionGUID: mEYMbRDJTjSh7DiGKbzy/A==
X-CSE-MsgGUID: zmnPSW9UTka3vc4exSK9Ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; 
   d="scan'208";a="156797527"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 00:32:24 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 15 Jul 2025 00:32:23 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 15 Jul 2025 00:32:23 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.46)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 15 Jul 2025 00:32:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=viEidnaqYr3zZnz2NFP+TttIh36KYPURgJo8S4wN6IV68Nnq2KgIf7Gtgk0wkfl/j7BMnn2DOCP4lzvTcYdKZF/C9fyOyH9xJSShErvAT/YemB2Fty3uTzeccYlLcMVEKt440FtHMyCsA6kSUgkPuLWxMCTO1gEdJQdqGC1JnyCA4dUnN76fcGPq1pTYrfxWAxkJuxAhQib8R4LamIQv+fgvubXc2azCegUuRtiasp05ztTdH9s2iQQkgf5h1PWy+FFISugxloMLeFChFcixRYtbAFLDl9H1uY2pyUzKFnhitF0C0KJ6Sz3y8Z0PoofUWXZ1PdBhYEo3HgArGd3RCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GoQuSh4IRqy1uN0YyTdXx7Ih6kZXj0ThhrKqAziUgwg=;
 b=KjKyxrJau+++14F8WKG8XPVqxGcXDGLCUlkSFkm29NBxPHeQMzM9qaiI1EguYAmlTxx2TWUpCeBq9PwP4WKOTfrHfxvmv/xxTvJGoQ+lYcE38L165Y5SzN4QAzinGJEycl5qobH8FOww43u+7/9PWOkQX4CnCB3KBiJNMv/8oxsVsqrV5S5J7us/OxA6/iCdAEvDSyqc5zPMPI96QA79ZCoW7U1MsjUsFIWybEOzxHoDxkKp4ERR6rejVEATGBNt/G29rYFoCxGX69x3jJQG7OxYWnOrP+Qf48dxDvRU+1ylUx+DJh/3h6PiyB5WllekBKnE4v65KyNec1QbC3XayQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SJ5PPF2F2B659FE.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::81c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Tue, 15 Jul
 2025 07:32:14 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8901.018; Tue, 15 Jul 2025
 07:32:14 +0000
Date: Tue, 15 Jul 2025 15:32:04 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Steven Rostedt <rostedt@goodmis.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, David Howells
	<dhowells@redhat.com>, <linux-kernel@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, <oliver.sang@intel.com>
Subject: Re: [PATCH] ring-buffer: Remove ring_buffer_read_prepare_sync()
Message-ID: <202507150815.f6cdbee0-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250630180440.3eabb514@batman.local.home>
X-ClientProxiedBy: SG2P153CA0004.APCP153.PROD.OUTLOOK.COM (2603:1096::14) To
 LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SJ5PPF2F2B659FE:EE_
X-MS-Office365-Filtering-Correlation-Id: ce48aac6-1e53-4aa8-0c37-08ddc371b7c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?brLSYJD0jDEIrsWTo2wq2UlGshAstXaDy4//ETf6GaT8kqaS2cU053Yrki?=
 =?iso-8859-1?Q?Rv+0ySV1LBO8BX3ZADqGKm94M3WO46ylBGYL2KCH6fGDItY+SoO44qwwpV?=
 =?iso-8859-1?Q?xK6LnWVsiVx1k3PC+46vc7e3jhJF2mLDZWSKGbfDMe3i3XdM8C0qFelPK6?=
 =?iso-8859-1?Q?GU6pCemlpuVuEoDpMbqg0XpKUKKgOOxmXm1Wd9t7xQSvfJuN1BLGjRNGnn?=
 =?iso-8859-1?Q?4PV83OYrb68fHFGKpu3n1bWshkqwnov7NrmtxVYrlneC6Q9jJ4r6oE6SQt?=
 =?iso-8859-1?Q?FYD2Q6jMQnLIyHcPe+TVImEcGHKzbsXQgAYBY1xQmoisL0nkNHt4tgVzb5?=
 =?iso-8859-1?Q?P9mOGUT5YDd/P1gI5B6UIf/RaVELlPYWQ23kkFtZ/E4bODXRWmZzcrNXJz?=
 =?iso-8859-1?Q?QpaWg8YvFjH8KsVshTYnIc96nkm/WWPIqEyEMy6wcdMWBt+3VnGJcMtJlO?=
 =?iso-8859-1?Q?Ke0mVFPSuZeo9LCm7tA/kPvPrzpIFXAPP+pqP0Yn5fKXujWd/zlRSdbpt5?=
 =?iso-8859-1?Q?b5ZgdZhdJPyX/Kmz4juF9NmWGrjcbtzVSzJo0GHDvQCO7+3RriwjiVXcIz?=
 =?iso-8859-1?Q?/R45K3KaSwDsROVcrfmk2Nmz9cvbtobLpt70D5aw4mmB+KAuHxNWhzcrkz?=
 =?iso-8859-1?Q?flGwcuUh0LoEk1UxxgZnd1y3F7rY3eo1yf/oBBrt9ikwK0vcKhmGLtm8MS?=
 =?iso-8859-1?Q?GMloKKtsel/qnGqwJasSkue/Iu+ClX6UhGDc0V1hdE3IsPduPR5Nhk3i1o?=
 =?iso-8859-1?Q?JudXiLrUdYSWf/JHydECLJAphVqjEykL0/jq+kl5Mmv706hvRBrZYaT3rN?=
 =?iso-8859-1?Q?u0xsFTZlY5iTjo3R5sFfpVMPICHBGFVdUrFgfKbRw3WiNK0nh62GRQtxRg?=
 =?iso-8859-1?Q?bj3CcG3Jwah6Jto++ehOCEUjE++qyMJxnfmqROjCKYVGHUHI66lQcxAptP?=
 =?iso-8859-1?Q?fcboP6h4i+6AccFuc837q3AmFRF5qwStIN+gtRz27lPUP3H90G5kX/D0Pu?=
 =?iso-8859-1?Q?VbpuSzsqeHgO/xfxsQ5lKDOlvRQd3+u88fix6xD1QVJOl1zC3dqkpzLwN2?=
 =?iso-8859-1?Q?3p89BSZxlTISobrri5F0s/BStMxaOfQ4mEclyvmWq69e41j3a8uw5B7LB4?=
 =?iso-8859-1?Q?EHSTsqao9O70g27ar6QEkCU2vsj/Lsk5cGzHk5Mv4n+XwDeB+fSP7e7E+2?=
 =?iso-8859-1?Q?iX8fd2Nr1D7vqvGTjOPlpSHb/E3sfukOfsN8bxCVhlTyTwNAgrL5tTfLHC?=
 =?iso-8859-1?Q?69C4mbVV91/oUgYi17wvQb32FaO633pr471oFV0ce68c/TqM/tVMq964Oo?=
 =?iso-8859-1?Q?TDyfJuab1dkZB4B/rQGZSOiykG7Xmu4k/rFigqNTSg6w63jG4S+xSti0v8?=
 =?iso-8859-1?Q?PbUQ9+5KzUjE8bHcMth92+fIgwT4Irvsbm1og6IXRMSjLHry2LQ5nP63p+?=
 =?iso-8859-1?Q?OxEAfU2oJeD0vrjX?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?UXNsdVaM3Avy4CnVjGAML2/NNnPlJx9fywBSRoU91Y28ZEBmTbq1tm2vto?=
 =?iso-8859-1?Q?6wRzz77yJGbhuRr5kQ6f5cUCyQNGyj8/3q6kXaXCXYafmiC1fzXVHuxq4v?=
 =?iso-8859-1?Q?UEfwm7t0k3FWzZ0fQvbL2e5ugFNQS56TN6iekLRsfsU7fI7nbRpmcSQ0Np?=
 =?iso-8859-1?Q?uC8deQwbeL8lsYXvxDVBFvlo1OCQ8hmlfhs8upYyyx2DFlImPV1KJOym0Q?=
 =?iso-8859-1?Q?5zTP7nUaGw87oBRZXSWxnil2pZ0hhUB2zfK8idZy3SYfxOMouXEZylXmCE?=
 =?iso-8859-1?Q?6hUUho/3U22I0wlcO7ChYqK9tCxZmT/EXOFWBn5inG1u9AExtk5+j5IUeu?=
 =?iso-8859-1?Q?qBMT/xi0k3cFcosFHTGZbJrb65euEZyUeq4HVw7VQcUCOZfMnwOBfqM7qd?=
 =?iso-8859-1?Q?aL7UdQCaX72nY4xM716mDT3DOD9oyhN2Znz3I5Spq305HgydzvLo4JzbWN?=
 =?iso-8859-1?Q?U6Ox2vS1mTZSzNvEwpqCeUlciIIMcuTdLzfW7TCCbYdvyulGwC5BW8pUfH?=
 =?iso-8859-1?Q?lWGVAkSaK8yqXP2CKeKWENTA5NVvUCic+k3w3jTnYHYqovvm0uHICFZjM6?=
 =?iso-8859-1?Q?OIIDMXYjB6E8pFnho5yyXl1vkUjXJiWORbJf0RYK+T7OMbYB4tJoVs7P+s?=
 =?iso-8859-1?Q?D+oKIoPe/VdoshQVlxv/JVPRykLkuef6n7ETt9OMJcIpVgn+AU3tL0q2P0?=
 =?iso-8859-1?Q?NWBvg8YqW6KABNuJrpmO6EhW1/Uf81jnW5zRc5K5fCYlsgxhyM+RdZmvYI?=
 =?iso-8859-1?Q?JY+JH0txSPAmaT/i8JGBp2MzeDhtx9sjGhO7/Vjp7O4ysEskqkwUJ2n0sN?=
 =?iso-8859-1?Q?D6EFDJpckX34kzIbRo8EPs5DZA3lH4qa92tgHAGvhcrcemBJEmXcrgSkkz?=
 =?iso-8859-1?Q?7WwGDNBheWvLTdOoEbweTnVFdyVySDpF/TMVTpBchWxRRTv/v2hWYOW4ZC?=
 =?iso-8859-1?Q?Vd4NZaMuWqpXXFoLMdvMDhC0decoPxnQ1xiU5CqoW9gLfYOf9doDPbA0fM?=
 =?iso-8859-1?Q?Ua089kT64ZlfeJ1nn/7WlDnrLiNMcsdpBd0zCyNIWCdLBLRiYUfkwakydW?=
 =?iso-8859-1?Q?Vlsv7YpvS+iHNtGlWD5LdwPz1QM9WmUSFOPEKv/5tgusAv383ZUkw8aVOo?=
 =?iso-8859-1?Q?Ys63D6T5XPb3NVGD7Q1QpD3eb8oZfeNXhWExG7Jzh7WGIPCTDHEJYjpjpi?=
 =?iso-8859-1?Q?708vINijNjeD14hJuvpFqh81ZybRVsL7km9CcX6P2crIy2GOnHlGuZrlgt?=
 =?iso-8859-1?Q?DUh//nVl1w+krYuzXhlkAocILB9hyX7VJUQOCQTXPUfKh4hmQweoQhHgqQ?=
 =?iso-8859-1?Q?ZV0RpEC9ZVoAlD4p+wLoAF5qlO15zAla+EV/UiehpE5pDBK3lXebvkBDVM?=
 =?iso-8859-1?Q?HJbJ87RK6TBIy+CEu8TYQQsQmGK15Js8kRSRtCgnQA20SelktWTKorrfWh?=
 =?iso-8859-1?Q?08FibDcf2z5DZyuTX+o8asw/HXdE3HrlskEczFFxOblO5Z/ZLmz8Tdh2B3?=
 =?iso-8859-1?Q?i+7JsgXp8r4ZpFjyCB4PGCvTIzuvVYlHEx9X2vtbEu9MIR6K8TEpTcD9DH?=
 =?iso-8859-1?Q?qjmj2N4A0XfPHIeI2827fL5d7WN5cs25GP5gFTI9OrEyto8Jre1BiTHLsP?=
 =?iso-8859-1?Q?PK5DaV6gYmbsXNFPMJ5JXQualjo5HizyCfAGAzyzGEho6JBcSv4wxKPQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ce48aac6-1e53-4aa8-0c37-08ddc371b7c5
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 07:32:14.5641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sggl5kQg901DDgb9Cz1ztKBS6bOrdQszSi+36Qqz+ynBd0WBWW6ioPE9x9OX91mpSPWlXnGP5R3vOrK7MPrh1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF2F2B659FE
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 46.6% improvement of stress-ng.mmapfiles.ops_per_sec on:


commit: e554d9f934596e6e1c81f99d4617d3c3061129bb ("[PATCH] ring-buffer: Remove ring_buffer_read_prepare_sync()")
url: https://github.com/intel-lab-lkp/linux/commits/Steven-Rostedt/ring-buffer-Remove-ring_buffer_read_prepare_sync/20250701-060627
base: https://git.kernel.org/cgit/linux/kernel/git/trace/linux-trace for-next
patch link: https://lore.kernel.org/all/20250630180440.3eabb514@batman.local.home/
patch subject: [PATCH] ring-buffer: Remove ring_buffer_read_prepare_sync()

testcase: stress-ng
config: x86_64-rhel-9.4
compiler: gcc-12
test machine: 192 threads 2 sockets Intel(R) Xeon(R) 6740E  CPU @ 2.4GHz (Sierra Forest) with 256G memory
parameters:

	nr_threads: 100%
	testtime: 60s
	test: mmapfiles
	cpufreq_governor: performance



Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250715/202507150815.f6cdbee0-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/x86_64-rhel-9.4/100%/debian-12-x86_64-20240206.cgz/lkp-srf-2sp2/mmapfiles/stress-ng/60s

commit: 
  9cca84d73f ("Merge tools/for-next")
  e554d9f934 ("ring-buffer: Remove ring_buffer_read_prepare_sync()")

9cca84d73fae0f7c e554d9f934596e6e1c81f99d461 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
 1.191e+10           -30.8%  8.242e+09 ±  5%  cpuidle..time
    557160          +182.9%    1576368 ± 12%  cpuidle..usage
    517840 ±  8%    +499.0%    3101638 ±  7%  numa-numastat.node0.local_node
    592074 ± 10%    +446.4%    3235092 ±  6%  numa-numastat.node0.numa_hit
    487358 ±  8%    +500.3%    2925629 ±  4%  numa-numastat.node1.local_node
    610968 ±  9%    +389.4%    2990283 ±  5%  numa-numastat.node1.numa_hit
     98.45           -29.1%      69.78 ±  5%  vmstat.cpu.id
      2.41 ± 16%   +2346.5%      59.04 ± 11%  vmstat.procs.r
      3491          +162.4%       9160 ± 12%  vmstat.system.cs
     14593          +813.0%     133235 ± 22%  vmstat.system.in
      6.50 ± 53%  +38700.0%       2522 ± 44%  perf-c2c.DRAM.local
     40.17 ± 21%  +11012.2%       4463 ± 59%  perf-c2c.DRAM.remote
     83.50 ± 26%  +12360.8%      10404 ± 84%  perf-c2c.HITM.local
     25.50 ± 22%   +9441.2%       2433 ± 81%  perf-c2c.HITM.remote
    109.00 ± 23%  +11677.8%      12837 ± 81%  perf-c2c.HITM.total
    143881           +61.6%     232515        meminfo.KReclaimable
  10550821 ±  2%     +17.2%   12364230 ±  4%  meminfo.Memused
     44747 ±  2%   +2922.7%    1352558 ± 34%  meminfo.PageTables
    143881           +61.6%     232515        meminfo.SReclaimable
    233317           +40.9%     328842 ± 13%  meminfo.Shmem
  11374925 ±  2%     +17.1%   13323634 ±  5%  meminfo.max_used_kB
     85738 ± 39%    +103.8%     174738 ±  3%  numa-meminfo.node0.KReclaimable
   5806365 ± 25%     +35.4%    7863059 ±  2%  numa-meminfo.node0.MemUsed
     25460 ± 38%   +2636.2%     696665 ± 37%  numa-meminfo.node0.PageTables
     85738 ± 39%    +103.8%     174738 ±  3%  numa-meminfo.node0.SReclaimable
     19286 ± 52%   +3358.4%     667006 ± 32%  numa-meminfo.node1.PageTables
     99582 ± 88%    +136.2%     235198 ± 51%  numa-meminfo.node1.Shmem
     98.49           -29.7       68.82 ±  5%  mpstat.cpu.all.idle%
      0.02 ±  5%      +0.1        0.16 ± 11%  mpstat.cpu.all.irq%
      0.05 ±  2%      +0.1        0.14 ± 11%  mpstat.cpu.all.soft%
      1.27           +29.3       30.53 ± 12%  mpstat.cpu.all.sys%
      0.17            +0.2        0.35 ± 11%  mpstat.cpu.all.usr%
      2.00          +410.0%      10.20 ± 33%  mpstat.max_utilization.seconds
     56.84 ±  3%     +75.9%     100.00        mpstat.max_utilization_pct
      6362 ± 38%   +2597.0%     171604 ± 38%  numa-vmstat.node0.nr_page_table_pages
     21433 ± 39%    +103.7%      43659 ±  3%  numa-vmstat.node0.nr_slab_reclaimable
    592326 ± 10%    +447.6%    3243498 ±  6%  numa-vmstat.node0.numa_hit
    518092 ±  8%    +500.3%    3110044 ±  7%  numa-vmstat.node0.numa_local
      4823 ± 52%   +3265.9%     162349 ± 31%  numa-vmstat.node1.nr_page_table_pages
     24897 ± 88%    +134.9%      58481 ± 52%  numa-vmstat.node1.nr_shmem
    610128 ±  9%    +391.6%    2999506 ±  5%  numa-vmstat.node1.numa_hit
    486517 ±  8%    +503.2%    2934852 ±  4%  numa-vmstat.node1.numa_local
    173139 ±  7%     -28.5%     123716 ±  5%  stress-ng.mmapfiles.file_munmap_per_sec
   3255621          +189.4%    9420391 ± 17%  stress-ng.mmapfiles.file_pages_mmap'd_per_sec
   4406848 ±  7%    +177.4%   12226005 ± 17%  stress-ng.mmapfiles.file_pages_munmap'd_per_sec
   6750720           +45.8%    9839893 ±  4%  stress-ng.mmapfiles.ops
    111233           +46.6%     163043 ±  4%  stress-ng.mmapfiles.ops_per_sec
     25.45          +185.7%      72.72 ± 17%  stress-ng.mmapfiles.pages_per_mapping
      2385 ± 11%   +1274.5%      32790 ±  3%  stress-ng.time.involuntary_context_switches
    126772 ±  7%     +39.7%     177103 ±  7%  stress-ng.time.minor_page_faults
    233.83         +2464.3%       5996 ± 12%  stress-ng.time.percent_of_cpu_this_job_got
    139.02 ±  2%   +2502.9%       3618 ± 12%  stress-ng.time.system_time
      4.73 ±  2%    +325.0%      20.11 ±  7%  stress-ng.time.user_time
     23391          +393.7%     115477 ± 27%  stress-ng.time.voluntary_context_switches
    945786            +2.6%     970204        proc-vmstat.nr_file_pages
     68051           +11.7%      76009 ±  6%  proc-vmstat.nr_mapped
     11189 ±  2%   +2912.5%     337076 ± 34%  proc-vmstat.nr_page_table_pages
     58330           +40.5%      81973 ± 13%  proc-vmstat.nr_shmem
     35968           +61.4%      58056        proc-vmstat.nr_slab_reclaimable
    923417            +4.1%     961412        proc-vmstat.nr_slab_unreclaimable
      6994 ±  2%    +282.2%      26735 ± 88%  proc-vmstat.numa_hint_faults
   1205445          +417.1%    6233925 ±  6%  proc-vmstat.numa_hit
   1007600          +499.0%    6035817 ±  6%  proc-vmstat.numa_local
    500.50 ± 46%   +3114.1%      16086 ± 82%  proc-vmstat.numa_pages_migrated
      8249          +920.6%      84190 ± 65%  proc-vmstat.numa_pte_updates
   1867778 ±  3%    +476.0%   10758231 ±  4%  proc-vmstat.pgalloc_normal
    480874           +15.1%     553383 ±  6%  proc-vmstat.pgfault
   1816801 ±  3%    +417.9%    9409800 ±  8%  proc-vmstat.pgfree
    500.50 ± 46%   +3114.1%      16086 ± 82%  proc-vmstat.pgmigrate_success
     18020           +39.3%      25094 ±  7%  proc-vmstat.pgreuse
      1.50 ±  5%     -21.0%       1.19 ±  2%  perf-stat.i.MPKI
 9.549e+08 ±  3%    +526.1%  5.979e+09 ±  5%  perf-stat.i.branch-instructions
      2.68            -2.1        0.58 ±  6%  perf-stat.i.branch-miss-rate%
  18077507           +39.1%   25144949 ±  3%  perf-stat.i.branch-misses
     20.48 ±  3%     +15.9       36.39 ±  4%  perf-stat.i.cache-miss-rate%
   5467752 ± 11%    +471.9%   31267720 ±  6%  perf-stat.i.cache-misses
  17535422 ±  4%    +384.2%   84912182 ±  7%  perf-stat.i.cache-references
      3219          +184.2%       9149 ± 12%  perf-stat.i.context-switches
      1.75          +268.0%       6.43 ± 14%  perf-stat.i.cpi
  7.74e+09 ±  4%   +2371.9%  1.913e+11 ± 11%  perf-stat.i.cpu-cycles
    278.42           +12.2%     312.44 ±  2%  perf-stat.i.cpu-migrations
      2859 ±  8%    +147.1%       7066 ± 13%  perf-stat.i.cycles-between-cache-misses
 4.615e+09 ±  3%    +524.5%  2.882e+10 ±  5%  perf-stat.i.instructions
      0.71           -55.8%       0.31 ± 18%  perf-stat.i.ipc
      5250 ±  3%     +20.7%       6340 ±  7%  perf-stat.i.minor-faults
      5250 ±  3%     +20.7%       6340 ±  7%  perf-stat.i.page-faults
      1.89 ±  3%      -1.5        0.42 ±  2%  perf-stat.overall.branch-miss-rate%
     31.05 ±  6%      +5.8       36.86 ±  3%  perf-stat.overall.cache-miss-rate%
      1.68 ±  2%    +295.8%       6.65 ±  7%  perf-stat.overall.cpi
      1431 ±  7%    +329.5%       6147 ±  9%  perf-stat.overall.cycles-between-cache-misses
      0.60 ±  2%     -74.6%       0.15 ±  7%  perf-stat.overall.ipc
 9.436e+08 ±  3%    +523.6%  5.884e+09 ±  5%  perf-stat.ps.branch-instructions
  17808666           +37.8%   24537286 ±  3%  perf-stat.ps.branch-misses
   5399377 ± 11%    +468.8%   30710020 ±  6%  perf-stat.ps.cache-misses
  17331532 ±  4%    +381.3%   83414797 ±  7%  perf-stat.ps.cache-references
      3165          +183.8%       8984 ± 12%  perf-stat.ps.context-switches
 7.661e+09 ±  4%   +2367.5%   1.89e+11 ± 11%  perf-stat.ps.cpu-cycles
    273.88           +12.1%     306.96 ±  2%  perf-stat.ps.cpu-migrations
 4.561e+09 ±  3%    +521.7%  2.836e+10 ±  5%  perf-stat.ps.instructions
      5162 ±  3%     +20.5%       6221 ±  7%  perf-stat.ps.minor-faults
      5162 ±  3%     +20.5%       6221 ±  7%  perf-stat.ps.page-faults
 2.827e+11 ±  4%    +518.2%  1.748e+12 ±  6%  perf-stat.total.instructions
      0.03 ± 22%    +114.4%       0.07 ± 48%  sched_debug.cfs_rq:/.h_nr_queued.avg
      0.16 ±  8%     +46.6%       0.24 ± 14%  sched_debug.cfs_rq:/.h_nr_queued.stddev
      0.03 ± 22%    +114.4%       0.07 ± 48%  sched_debug.cfs_rq:/.h_nr_runnable.avg
      0.16 ±  8%     +46.6%       0.24 ± 14%  sched_debug.cfs_rq:/.h_nr_runnable.stddev
     28.55 ± 22%    +105.6%      58.68 ± 30%  sched_debug.cfs_rq:/.load_avg.avg
    129.70 ± 12%     +68.8%     219.00 ± 21%  sched_debug.cfs_rq:/.load_avg.stddev
      0.03 ± 23%    +110.4%       0.07 ± 49%  sched_debug.cfs_rq:/.nr_queued.avg
      0.17 ± 10%     +44.6%       0.24 ± 16%  sched_debug.cfs_rq:/.nr_queued.stddev
     19.92 ± 31%    +131.3%      46.08 ± 38%  sched_debug.cfs_rq:/.removed.load_avg.avg
     96.83 ± 15%    +102.7%     196.23 ± 25%  sched_debug.cfs_rq:/.removed.load_avg.stddev
      8.64 ± 31%    +113.6%      18.44 ± 35%  sched_debug.cfs_rq:/.removed.runnable_avg.avg
    263.25 ±  2%     +80.2%     474.40 ± 20%  sched_debug.cfs_rq:/.removed.runnable_avg.max
     43.62 ± 16%     +87.4%      81.72 ± 22%  sched_debug.cfs_rq:/.removed.runnable_avg.stddev
      8.64 ± 31%    +113.6%      18.44 ± 35%  sched_debug.cfs_rq:/.removed.util_avg.avg
    263.25 ±  2%     +80.1%     474.20 ± 20%  sched_debug.cfs_rq:/.removed.util_avg.max
     43.62 ± 16%     +87.3%      81.72 ± 22%  sched_debug.cfs_rq:/.removed.util_avg.stddev
     73.73 ±  5%    +107.0%     152.62 ± 11%  sched_debug.cfs_rq:/.runnable_avg.avg
    132.86 ±  2%     +75.9%     233.71 ± 18%  sched_debug.cfs_rq:/.runnable_avg.stddev
     73.61 ±  5%    +107.0%     152.40 ± 11%  sched_debug.cfs_rq:/.util_avg.avg
    132.55 ±  2%     +76.2%     233.59 ± 18%  sched_debug.cfs_rq:/.util_avg.stddev
      6.04 ± 37%    +243.7%      20.77 ± 85%  sched_debug.cfs_rq:/.util_est.avg
    372.25 ± 17%     +89.1%     704.00 ± 20%  sched_debug.cfs_rq:/.util_est.max
     41.23 ± 23%    +122.7%      91.83 ± 38%  sched_debug.cfs_rq:/.util_est.stddev
     66163 ± 20%     -93.2%       4511 ± 59%  sched_debug.cpu.avg_idle.min
    124590 ±  7%     +63.4%     203555 ± 20%  sched_debug.cpu.avg_idle.stddev
    239770           -10.1%     215480 ±  5%  sched_debug.cpu.clock.avg
    239792           -10.1%     215503 ±  5%  sched_debug.cpu.clock.max
    239740           -10.1%     215453 ±  5%  sched_debug.cpu.clock.min
    239688           -10.1%     215399 ±  5%  sched_debug.cpu.clock_task.avg
    239761           -10.1%     215478 ±  5%  sched_debug.cpu.clock_task.max
    233073           -10.4%     208806 ±  5%  sched_debug.cpu.clock_task.min
    102.79 ± 24%    +146.7%     253.62 ± 72%  sched_debug.cpu.curr->pid.avg
    615.65 ±  8%     +39.6%     859.42 ± 28%  sched_debug.cpu.curr->pid.stddev
      0.03 ± 27%    +128.4%       0.06 ± 54%  sched_debug.cpu.nr_running.avg
      0.14 ± 11%     +57.0%       0.22 ± 17%  sched_debug.cpu.nr_running.stddev
      0.50           -83.0%       0.09 ±181%  sched_debug.cpu.nr_uninterruptible.avg
    239751           -10.1%     215460 ±  5%  sched_debug.cpu_clk
    239489           -10.1%     215201 ±  5%  sched_debug.ktime
    239978           -10.1%     215654 ±  5%  sched_debug.sched_clk
      0.00 ±223%  +23036.0%       0.19 ± 54%  perf-sched.sch_delay.avg.ms.__cond_resched.__kmalloc_cache_noprof.perf_event_mmap_event.perf_event_mmap.__mmap_region
      0.01          +106.7%       0.02 ± 48%  perf-sched.sch_delay.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      0.00 ±223%   +6920.0%       0.05 ±112%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_alloc.__mmap_new_vma.__mmap_region
      0.00 ±145%  +14564.0%       0.24 ±126%  perf-sched.sch_delay.avg.ms.__cond_resched.zap_pte_range.zap_pmd_range.isra.0
      0.02 ± 12%     -43.3%       0.01 ± 29%  perf-sched.sch_delay.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.01 ±  8%     +22.3%       0.01 ±  4%  perf-sched.sch_delay.avg.ms.anon_pipe_read.fifo_pipe_read.vfs_read.ksys_read
      0.00 ±104%   +1168.6%       0.03 ± 56%  perf-sched.sch_delay.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      0.02 ± 47%     -75.5%       0.00 ± 93%  perf-sched.sch_delay.avg.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      0.02 ±  9%     -33.6%       0.01 ± 19%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      2.30 ±219%     -99.9%       0.00 ±200%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.__tracing_open
      2.35 ±222%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.tracing_buffers_open
      0.01 ± 11%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.tracing_open_pipe
      0.02 ± 45%     -90.5%       0.00 ±200%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.tracing_release
      0.01 ±  3%    +501.8%       0.07 ± 54%  perf-sched.sch_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.__wait_rcu_gp
      0.01           +68.0%       0.01 ± 40%  perf-sched.sch_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.01 ± 34%    +252.6%       0.04 ± 76%  perf-sched.sch_delay.avg.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.03 ± 41%     -58.0%       0.01 ±  8%  perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.00 ±223%   +1392.5%       0.04 ± 85%  perf-sched.sch_delay.max.ms.__cond_resched.__alloc_frozen_pages_noprof.alloc_pages_mpol.alloc_pages_noprof.pte_alloc_one
      0.00 ±223%  +1.6e+05%       1.36 ± 71%  perf-sched.sch_delay.max.ms.__cond_resched.__kmalloc_cache_noprof.perf_event_mmap_event.perf_event_mmap.__mmap_region
      0.04 ± 31%  +12614.8%       5.36 ±136%  perf-sched.sch_delay.max.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      0.00 ±223%  +23720.0%       0.16 ±142%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.vm_area_alloc.__mmap_new_vma.__mmap_region
      0.00 ±145%  +43904.0%       0.73 ±110%  perf-sched.sch_delay.max.ms.__cond_resched.zap_pte_range.zap_pmd_range.isra.0
      0.04 ± 11%     -46.3%       0.02 ± 34%  perf-sched.sch_delay.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.04 ± 15%     +38.7%       0.06 ±  5%  perf-sched.sch_delay.max.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      0.03 ± 23%     -37.5%       0.02 ± 26%  perf-sched.sch_delay.max.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      0.00 ±104%   +8077.1%       0.19 ± 75%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      0.01 ± 79%  +25841.2%       2.20 ±159%  perf-sched.sch_delay.max.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown].[unknown]
      2.85 ±114%     -99.9%       0.00 ± 93%  perf-sched.sch_delay.max.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      0.04 ±  7%     -33.2%       0.03 ± 29%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
    162.34 ±220%    -100.0%       0.00 ±200%  perf-sched.sch_delay.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.__tracing_open
    151.86 ±223%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.tracing_buffers_open
      0.03 ± 12%     -83.7%       0.00 ±200%  perf-sched.sch_delay.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.tracing_buffers_release
      0.04 ± 34%   +2146.1%       0.81 ± 88%  perf-sched.sch_delay.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.tracing_check_open_get_tr
      0.02 ± 12%    -100.0%       0.00        perf-sched.sch_delay.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.tracing_open_pipe
      1.86 ±218%     -99.9%       0.00 ±200%  perf-sched.sch_delay.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.tracing_release
      0.03 ±  5%   +1199.8%       0.41 ± 51%  perf-sched.sch_delay.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.__wait_rcu_gp
      0.02 ±  7%  +17495.5%       3.87 ±122%  perf-sched.sch_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.02 ± 22%   +3550.0%       0.58 ± 79%  perf-sched.sch_delay.max.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
    318.12           -64.9%     111.82 ± 44%  perf-sched.total_wait_and_delay.average.ms
      7352          +251.9%      25870 ± 78%  perf-sched.total_wait_and_delay.count.ms
    318.06           -64.8%     111.81 ± 44%  perf-sched.total_wait_time.average.ms
      3.93          -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
    556.93 ±  6%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.__tracing_open
    598.50 ±  7%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.tracing_buffers_open
    605.96 ±  6%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.tracing_buffers_release
    648.70 ±  3%     -97.8%      14.58 ±127%  perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.tracing_check_open_get_tr
    729.67 ±  7%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.tracing_open_pipe
    242.46 ±  5%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.tracing_release
    747.54 ±  5%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.tracing_release_generic_tr
    621.23 ± 23%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.tracing_release_pipe
    228.85 ±  8%     -96.1%       8.96 ±200%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.__wait_rcu_gp
      3.26           +28.1%       4.17 ±  2%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.00 ±  7%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.wait_for_partner.fifo_open.do_dentry_open.vfs_open
    922.74 ±  2%     -87.3%     116.81 ± 12%  perf-sched.wait_and_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
    417.33 ±  2%    -100.0%       0.00        perf-sched.wait_and_delay.count.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
     69.17 ±  8%    -100.0%       0.00        perf-sched.wait_and_delay.count.schedule_preempt_disabled.__mutex_lock.constprop.0.__tracing_open
     65.00 ±  7%    -100.0%       0.00        perf-sched.wait_and_delay.count.schedule_preempt_disabled.__mutex_lock.constprop.0.tracing_buffers_open
     83.00 ±  9%    -100.0%       0.00        perf-sched.wait_and_delay.count.schedule_preempt_disabled.__mutex_lock.constprop.0.tracing_buffers_release
    537.83 ±  2%     -96.2%      20.60 ±145%  perf-sched.wait_and_delay.count.schedule_preempt_disabled.__mutex_lock.constprop.0.tracing_check_open_get_tr
     12.50 ± 27%    -100.0%       0.00        perf-sched.wait_and_delay.count.schedule_preempt_disabled.__mutex_lock.constprop.0.tracing_open_pipe
    572.00 ±  2%    -100.0%       0.00        perf-sched.wait_and_delay.count.schedule_preempt_disabled.__mutex_lock.constprop.0.tracing_release
     59.00 ± 13%    -100.0%       0.00        perf-sched.wait_and_delay.count.schedule_preempt_disabled.__mutex_lock.constprop.0.tracing_release_generic_tr
     17.00 ± 10%    -100.0%       0.00        perf-sched.wait_and_delay.count.schedule_preempt_disabled.__mutex_lock.constprop.0.tracing_release_pipe
    463.33           -99.5%       2.20 ±200%  perf-sched.wait_and_delay.count.schedule_timeout.__wait_for_common.wait_for_completion_state.__wait_rcu_gp
      1031           +16.0%       1196 ±  2%  perf-sched.wait_and_delay.count.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
     36.00          -100.0%       0.00        perf-sched.wait_and_delay.count.wait_for_partner.fifo_open.do_dentry_open.vfs_open
    611.50 ±  3%    +758.1%       5247 ±  7%  perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      1670 ± 27%     -52.7%     789.82 ± 50%  perf-sched.wait_and_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call
      5.68 ± 26%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      1030 ±  2%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.__tracing_open
      1031 ±  3%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.tracing_buffers_open
      1034 ±  2%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.tracing_buffers_release
      1046 ±  3%     -94.2%      60.44 ±123%  perf-sched.wait_and_delay.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.tracing_check_open_get_tr
      1013 ±  3%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.tracing_open_pipe
      1031 ±  3%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.tracing_release
      1027 ±  2%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.tracing_release_generic_tr
      1006 ±  2%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.tracing_release_pipe
      1044 ±  3%     -98.5%      15.36 ±200%  perf-sched.wait_and_delay.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.__wait_rcu_gp
      0.01 ± 29%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.wait_for_partner.fifo_open.do_dentry_open.vfs_open
      4529 ±  6%     -15.7%       3817 ± 10%  perf-sched.wait_and_delay.max.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.29 ±  6%     +16.7%       0.33 ±  5%  perf-sched.wait_time.avg.ms.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00 ±223%  +28060.0%       0.70 ±154%  perf-sched.wait_time.avg.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      3.91           -79.2%       0.81 ±117%  perf-sched.wait_time.avg.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
    554.63 ±  5%     -98.1%      10.38 ±200%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.__tracing_open
    596.15 ±  6%    -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.tracing_buffers_open
    605.94 ±  6%     -96.0%      23.97 ±200%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.tracing_buffers_release
    648.69 ±  3%     -91.9%      52.84 ± 70%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.tracing_check_open_get_tr
    729.66 ±  7%    -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.tracing_open_pipe
    242.44 ±  5%     -99.0%       2.44 ±200%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.tracing_release
    747.53 ±  5%     -97.3%      19.82 ± 89%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.tracing_release_generic_tr
    621.22 ± 23%     -95.6%      27.30 ±129%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.tracing_release_pipe
    228.84 ±  8%     -84.4%      35.69 ± 29%  perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.__wait_rcu_gp
      0.68 ±  9%     +62.9%       1.11 ±  6%  perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
      3.24           +28.2%       4.16 ±  2%  perf-sched.wait_time.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
    922.72 ±  2%     -87.3%     116.80 ± 12%  perf-sched.wait_time.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      1670 ± 27%     -29.8%       1172 ± 31%  perf-sched.wait_time.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call
      0.01 ±223%  +1.5e+05%       7.73 ±167%  perf-sched.wait_time.max.ms.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt.[unknown]
      5.00           -83.7%       0.81 ±117%  perf-sched.wait_time.max.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
      1030 ±  2%     -99.0%      10.38 ±200%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.__tracing_open
      1031 ±  3%    -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.tracing_buffers_open
      1034 ±  2%     -97.7%      23.97 ±200%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.tracing_buffers_release
      1046 ±  3%     -86.4%     141.95 ± 38%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.tracing_check_open_get_tr
      1013 ±  3%    -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.tracing_open_pipe
      1031 ±  3%     -99.5%       4.88 ±200%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.tracing_release
      1027 ±  2%     -97.3%      27.26 ±104%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.tracing_release_generic_tr
      1006 ±  2%     -95.7%      43.61 ±149%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.tracing_release_pipe
      1044 ±  3%     -87.7%     128.89 ± 47%  perf-sched.wait_time.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.__wait_rcu_gp
      5.06 ±  2%     +55.8%       7.88 ± 17%  perf-sched.wait_time.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      4529 ±  6%     -15.7%       3817 ± 10%  perf-sched.wait_time.max.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
     48.04 ±  7%     -46.7        1.38 ± 71%  perf-profile.calltrace.cycles-pp.__cmd_record
     46.88 ±  8%     -45.7        1.20 ± 80%  perf-profile.calltrace.cycles-pp.record__finish_output.__cmd_record
     46.87 ±  8%     -45.7        1.20 ± 80%  perf-profile.calltrace.cycles-pp.perf_session__process_events.record__finish_output.__cmd_record
     46.74 ±  8%     -45.5        1.20 ± 80%  perf-profile.calltrace.cycles-pp.reader__read_event.perf_session__process_events.record__finish_output.__cmd_record
     40.46 ±  8%     -39.7        0.76 ±104%  perf-profile.calltrace.cycles-pp.process_simple.reader__read_event.perf_session__process_events.record__finish_output.__cmd_record
     38.04 ±  8%     -37.3        0.73 ±105%  perf-profile.calltrace.cycles-pp.ordered_events__queue.process_simple.reader__read_event.perf_session__process_events.record__finish_output
     37.64 ±  8%     -36.9        0.73 ±105%  perf-profile.calltrace.cycles-pp.queue_event.ordered_events__queue.process_simple.reader__read_event.perf_session__process_events
     21.58 ±  8%     -21.3        0.24 ±124%  perf-profile.calltrace.cycles-pp.perf_session__process_user_event.reader__read_event.perf_session__process_events.record__finish_output.__cmd_record
     21.56 ±  8%     -21.3        0.24 ±124%  perf-profile.calltrace.cycles-pp.__ordered_events__flush.perf_session__process_user_event.reader__read_event.perf_session__process_events.record__finish_output
     20.36 ±  8%     -20.2        0.13 ±200%  perf-profile.calltrace.cycles-pp.perf_session__deliver_event.__ordered_events__flush.perf_session__process_user_event.reader__read_event.perf_session__process_events
     19.36 ±  8%     -19.2        0.15 ±200%  perf-profile.calltrace.cycles-pp.handle_internal_command.main
     19.36 ±  8%     -19.2        0.15 ±200%  perf-profile.calltrace.cycles-pp.main
     19.36 ±  8%     -19.2        0.15 ±200%  perf-profile.calltrace.cycles-pp.run_builtin.handle_internal_command.main
     18.32 ±  8%     -18.2        0.13 ±200%  perf-profile.calltrace.cycles-pp.cmd_record.perf_c2c__record.run_builtin.handle_internal_command.main
     18.32 ±  8%     -18.2        0.13 ±200%  perf-profile.calltrace.cycles-pp.perf_c2c__record.run_builtin.handle_internal_command.main
     18.31 ±  8%     -18.2        0.13 ±200%  perf-profile.calltrace.cycles-pp.__cmd_record.cmd_record.perf_c2c__record.run_builtin.handle_internal_command
     15.63 ±  9%     -15.6        0.00        perf-profile.calltrace.cycles-pp.record__finish_output.__cmd_record.cmd_record.perf_c2c__record.run_builtin
     15.63 ±  9%     -15.6        0.00        perf-profile.calltrace.cycles-pp.perf_session__process_events.record__finish_output.__cmd_record.cmd_record.perf_c2c__record
     15.58 ±  9%     -15.6        0.00        perf-profile.calltrace.cycles-pp.reader__read_event.perf_session__process_events.record__finish_output.__cmd_record.cmd_record
     14.08 ± 18%     -13.5        0.62 ± 96%  perf-profile.calltrace.cycles-pp.common_startup_64
     13.01 ±  8%     -13.0        0.00        perf-profile.calltrace.cycles-pp.machine__process_mmap2_event.perf_session__deliver_event.__ordered_events__flush.perf_session__process_user_event.reader__read_event
     11.85 ± 21%     -11.3        0.51 ± 98%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.common_startup_64
     11.85 ± 21%     -11.3        0.51 ± 98%  perf-profile.calltrace.cycles-pp.start_secondary.common_startup_64
     11.85 ± 21%     -11.3        0.51 ± 98%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.common_startup_64
     11.03 ± 16%     -10.6        0.46 ± 97%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
      9.69 ± 21%      -9.2        0.49 ± 98%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      9.16 ± 16%      -8.8        0.34 ±136%  perf-profile.calltrace.cycles-pp.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      9.16 ± 16%      -8.8        0.34 ±136%  perf-profile.calltrace.cycles-pp.acpi_idle_do_entry.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      9.16 ± 16%      -8.8        0.34 ±136%  perf-profile.calltrace.cycles-pp.acpi_safe_halt.acpi_idle_do_entry.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter
      8.82 ± 20%      -8.4        0.46 ± 97%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      7.17 ± 15%      -7.0        0.18 ±200%  perf-profile.calltrace.cycles-pp.pv_native_safe_halt.acpi_safe_halt.acpi_idle_do_entry.acpi_idle_enter.cpuidle_enter_state
      6.86 ± 21%      -6.7        0.19 ±200%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.pv_native_safe_halt.acpi_safe_halt.acpi_idle_do_entry.acpi_idle_enter
      6.41 ±  9%      -6.4        0.00        perf-profile.calltrace.cycles-pp.evlist__parse_sample.perf_session__deliver_event.__ordered_events__flush.perf_session__process_user_event.reader__read_event
      6.00 ± 10%      -6.0        0.00        perf-profile.calltrace.cycles-pp.map__new.machine__process_mmap2_event.perf_session__deliver_event.__ordered_events__flush.perf_session__process_user_event
      5.92 ±  5%      -5.7        0.27 ±122%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork.ret_from_fork_asm
      5.92 ±  5%      -5.7        0.27 ±122%  perf-profile.calltrace.cycles-pp.ret_from_fork.ret_from_fork_asm
      5.92 ±  5%      -5.7        0.27 ±122%  perf-profile.calltrace.cycles-pp.ret_from_fork_asm
      0.53 ± 47%      +0.7        1.18 ± 44%  perf-profile.calltrace.cycles-pp.__close
      1.14 ± 11%      +0.8        1.89 ± 41%  perf-profile.calltrace.cycles-pp.do_dentry_open.vfs_open.do_open.path_openat.do_filp_open
      1.15 ± 12%      +0.8        1.95 ± 41%  perf-profile.calltrace.cycles-pp.vfs_open.do_open.path_openat.do_filp_open.do_sys_openat2
      0.00            +1.3        1.25 ± 45%  perf-profile.calltrace.cycles-pp.lockref_put_return.dput.step_into.link_path_walk.path_openat
      0.00            +1.3        1.26 ± 49%  perf-profile.calltrace.cycles-pp.lookup_fast.open_last_lookups.path_openat.do_filp_open.do_sys_openat2
      0.00            +1.3        1.34 ± 51%  perf-profile.calltrace.cycles-pp.open_last_lookups.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
      0.00            +1.7        1.65 ± 51%  perf-profile.calltrace.cycles-pp.vma_interval_tree_insert.__mmap_new_vma.__mmap_region.do_mmap.vm_mmap_pgoff
      0.00            +1.7        1.68 ± 41%  perf-profile.calltrace.cycles-pp.down_read.kernfs_iop_permission.inode_permission.may_open.do_open
      0.00            +1.9        1.89 ± 53%  perf-profile.calltrace.cycles-pp.iterate_dir.__x64_sys_getdents64.do_syscall_64.entry_SYSCALL_64_after_hwframe.getdents64
      0.00            +1.9        1.92 ± 53%  perf-profile.calltrace.cycles-pp.__x64_sys_getdents64.do_syscall_64.entry_SYSCALL_64_after_hwframe.getdents64
      0.00            +1.9        1.93 ± 53%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.getdents64
      0.00            +1.9        1.94 ± 52%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.getdents64
      0.00            +2.0        1.98 ± 52%  perf-profile.calltrace.cycles-pp.getdents64
      0.00            +2.1        2.07 ± 42%  perf-profile.calltrace.cycles-pp.down_read.kernfs_iop_getattr.vfs_getattr_nosec.vfs_fstat.__do_sys_newfstatat
      0.00            +2.5        2.49 ± 46%  perf-profile.calltrace.cycles-pp.kernfs_iop_permission.inode_permission.may_open.do_open.path_openat
      0.00            +2.7        2.67 ± 45%  perf-profile.calltrace.cycles-pp.inode_permission.may_open.do_open.path_openat.do_filp_open
      0.00            +2.8        2.82 ± 46%  perf-profile.calltrace.cycles-pp.down_read.kernfs_dop_revalidate.lookup_fast.walk_component.link_path_walk
      0.00            +2.9        2.85 ± 45%  perf-profile.calltrace.cycles-pp.may_open.do_open.path_openat.do_filp_open.do_sys_openat2
      0.00            +2.9        2.86 ± 37%  perf-profile.calltrace.cycles-pp.kernfs_iop_getattr.vfs_getattr_nosec.vfs_fstat.__do_sys_newfstatat.do_syscall_64
      0.00            +3.1        3.10 ± 36%  perf-profile.calltrace.cycles-pp.vfs_getattr_nosec.vfs_fstat.__do_sys_newfstatat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +3.1        3.14 ± 36%  perf-profile.calltrace.cycles-pp.vfs_fstat.__do_sys_newfstatat.do_syscall_64.entry_SYSCALL_64_after_hwframe.fstatat64
      0.00            +3.2        3.23 ± 76%  perf-profile.calltrace.cycles-pp.zap_present_ptes.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas
      0.00            +3.2        3.24 ± 39%  perf-profile.calltrace.cycles-pp.kernfs_dop_revalidate.lookup_fast.walk_component.link_path_walk.path_openat
      0.00            +3.3        3.32 ± 36%  perf-profile.calltrace.cycles-pp.__do_sys_newfstatat.do_syscall_64.entry_SYSCALL_64_after_hwframe.fstatat64
      0.00            +3.4        3.38 ± 35%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.fstatat64
      0.00            +3.4        3.39 ± 35%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.fstatat64
      0.00            +3.5        3.55 ± 35%  perf-profile.calltrace.cycles-pp.fstatat64
      1.36 ±  8%      +3.7        5.09 ± 42%  perf-profile.calltrace.cycles-pp.do_open.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
      0.00            +3.9        3.89 ± 58%  perf-profile.calltrace.cycles-pp.dput.terminate_walk.path_openat.do_filp_open.do_sys_openat2
      0.00            +3.9        3.91 ± 57%  perf-profile.calltrace.cycles-pp.terminate_walk.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
      0.00            +3.9        3.92 ± 58%  perf-profile.calltrace.cycles-pp.lockref_get_not_dead.__legitimize_path.try_to_unlazy.link_path_walk.path_openat
      0.00            +4.0        3.95 ± 58%  perf-profile.calltrace.cycles-pp.__legitimize_path.try_to_unlazy.link_path_walk.path_openat.do_filp_open
      0.00            +4.0        3.96 ± 57%  perf-profile.calltrace.cycles-pp.try_to_unlazy.link_path_walk.path_openat.do_filp_open.do_sys_openat2
      0.00            +4.1        4.12 ± 77%  perf-profile.calltrace.cycles-pp.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas.vms_clear_ptes
      0.00            +4.1        4.13 ± 77%  perf-profile.calltrace.cycles-pp.zap_pmd_range.unmap_page_range.unmap_vmas.vms_clear_ptes.vms_complete_munmap_vmas
      0.00            +4.1        4.14 ± 77%  perf-profile.calltrace.cycles-pp.unmap_page_range.unmap_vmas.vms_clear_ptes.vms_complete_munmap_vmas.do_vmi_align_munmap
      0.00            +4.3        4.32 ± 77%  perf-profile.calltrace.cycles-pp.unmap_vmas.vms_clear_ptes.vms_complete_munmap_vmas.do_vmi_align_munmap.do_vmi_munmap
      0.00            +5.0        4.95 ± 46%  perf-profile.calltrace.cycles-pp.__mmap_new_vma.__mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff
      0.00            +5.0        5.04 ± 77%  perf-profile.calltrace.cycles-pp.vms_clear_ptes.vms_complete_munmap_vmas.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap
      0.00            +5.2        5.23 ± 77%  perf-profile.calltrace.cycles-pp.vms_complete_munmap_vmas.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap.__x64_sys_munmap
      0.00            +5.7        5.70 ± 49%  perf-profile.calltrace.cycles-pp.__mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64
      0.00            +6.2        6.16 ± 77%  perf-profile.calltrace.cycles-pp.do_vmi_align_munmap.do_vmi_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64
      0.00            +6.2        6.19 ± 77%  perf-profile.calltrace.cycles-pp.do_vmi_munmap.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +6.2        6.21 ± 77%  perf-profile.calltrace.cycles-pp.__vm_munmap.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
      0.00            +6.2        6.21 ± 77%  perf-profile.calltrace.cycles-pp.__x64_sys_munmap.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
      0.00            +6.5        6.53 ± 47%  perf-profile.calltrace.cycles-pp.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +6.6        6.61 ± 48%  perf-profile.calltrace.cycles-pp.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
      0.00            +6.6        6.64 ± 76%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__munmap
      0.00            +6.6        6.65 ± 76%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__munmap
      0.00            +6.7        6.66 ± 47%  perf-profile.calltrace.cycles-pp.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
      0.00            +6.7        6.67 ± 76%  perf-profile.calltrace.cycles-pp.__munmap
      0.00            +6.7        6.73 ± 47%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__mmap
      0.00            +6.7        6.73 ± 47%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__mmap
      0.00            +6.9        6.89 ± 47%  perf-profile.calltrace.cycles-pp.__mmap
      0.00            +9.4        9.42 ± 18%  perf-profile.calltrace.cycles-pp.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.__open64_nocancel
      0.00            +9.4        9.42 ± 18%  perf-profile.calltrace.cycles-pp.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.__open64_nocancel
      0.00            +9.5        9.46 ± 18%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__open64_nocancel
      0.00            +9.5        9.46 ± 18%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__open64_nocancel
      0.00            +9.5        9.49 ± 17%  perf-profile.calltrace.cycles-pp.__open64_nocancel
      0.00           +10.1       10.12 ± 36%  perf-profile.calltrace.cycles-pp.up_read.kernfs_iop_permission.inode_permission.link_path_walk.path_openat
      0.00           +12.5       12.52 ± 41%  perf-profile.calltrace.cycles-pp.down_read.kernfs_iop_permission.inode_permission.link_path_walk.path_openat
      0.00           +12.5       12.52 ± 71%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.dput.step_into.link_path_walk
      0.00           +12.6       12.64 ± 71%  perf-profile.calltrace.cycles-pp._raw_spin_lock.dput.step_into.link_path_walk.path_openat
      0.00           +13.1       13.09 ± 72%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.__d_lookup.lookup_fast.walk_component
      0.00           +14.1       14.06 ± 61%  perf-profile.calltrace.cycles-pp.dput.step_into.link_path_walk.path_openat.do_filp_open
      0.00           +14.3       14.26 ± 64%  perf-profile.calltrace.cycles-pp._raw_spin_lock.__d_lookup.lookup_fast.walk_component.link_path_walk
      0.00           +14.4       14.41 ± 63%  perf-profile.calltrace.cycles-pp.__d_lookup.lookup_fast.walk_component.link_path_walk.path_openat
      0.00           +14.8       14.80 ± 61%  perf-profile.calltrace.cycles-pp.step_into.link_path_walk.path_openat.do_filp_open.do_sys_openat2
      0.00           +18.2       18.21 ± 46%  perf-profile.calltrace.cycles-pp.lookup_fast.walk_component.link_path_walk.path_openat.do_filp_open
      0.00           +18.3       18.25 ± 46%  perf-profile.calltrace.cycles-pp.walk_component.link_path_walk.path_openat.do_filp_open.do_sys_openat2
      0.00           +23.8       23.84 ± 38%  perf-profile.calltrace.cycles-pp.kernfs_iop_permission.inode_permission.link_path_walk.path_openat.do_filp_open
      0.00           +26.6       26.62 ± 38%  perf-profile.calltrace.cycles-pp.inode_permission.link_path_walk.path_openat.do_filp_open.do_sys_openat2
      2.39 ±  7%     +63.7       66.05 ± 15%  perf-profile.calltrace.cycles-pp.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
      2.39 ±  7%     +63.7       66.05 ± 15%  perf-profile.calltrace.cycles-pp.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
      2.42 ±  7%     +63.8       66.23 ± 15%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
      2.42 ±  7%     +63.8       66.25 ± 15%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.open64
      0.10 ±223%     +63.9       64.00 ± 19%  perf-profile.calltrace.cycles-pp.link_path_walk.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
      2.48 ±  7%     +64.0       66.44 ± 15%  perf-profile.calltrace.cycles-pp.open64
      2.30 ±  8%     +72.9       75.16 ± 15%  perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64
      2.30 ±  8%     +72.9       75.17 ± 15%  perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
     66.48 ±  5%     -64.6        1.84 ± 58%  perf-profile.children.cycles-pp.__cmd_record
     62.50 ±  6%     -61.1        1.42 ± 74%  perf-profile.children.cycles-pp.record__finish_output
     62.50 ±  6%     -61.1        1.42 ± 74%  perf-profile.children.cycles-pp.perf_session__process_events
     62.34 ±  6%     -60.9        1.42 ± 74%  perf-profile.children.cycles-pp.reader__read_event
     40.48 ±  8%     -39.4        1.07 ± 78%  perf-profile.children.cycles-pp.process_simple
     38.11 ±  8%     -37.1        1.01 ± 78%  perf-profile.children.cycles-pp.ordered_events__queue
     37.76 ±  8%     -36.8        1.00 ± 78%  perf-profile.children.cycles-pp.queue_event
     21.66 ±  8%     -21.3        0.37 ± 66%  perf-profile.children.cycles-pp.__ordered_events__flush
     21.58 ±  8%     -21.2        0.37 ± 66%  perf-profile.children.cycles-pp.perf_session__process_user_event
     21.37 ±  8%     -21.0        0.37 ± 68%  perf-profile.children.cycles-pp.perf_session__deliver_event
     19.36 ±  8%     -18.9        0.41 ± 51%  perf-profile.children.cycles-pp.handle_internal_command
     19.36 ±  8%     -18.9        0.41 ± 51%  perf-profile.children.cycles-pp.main
     19.36 ±  8%     -18.9        0.41 ± 51%  perf-profile.children.cycles-pp.run_builtin
     18.49 ±  8%     -18.1        0.39 ± 51%  perf-profile.children.cycles-pp.cmd_record
     18.32 ±  8%     -18.0        0.34 ± 58%  perf-profile.children.cycles-pp.perf_c2c__record
     14.08 ± 18%     -13.3        0.78 ± 56%  perf-profile.children.cycles-pp.common_startup_64
     14.08 ± 18%     -13.3        0.78 ± 56%  perf-profile.children.cycles-pp.cpu_startup_entry
     14.08 ± 18%     -13.3        0.78 ± 56%  perf-profile.children.cycles-pp.do_idle
     13.13 ±  8%     -12.9        0.20 ± 62%  perf-profile.children.cycles-pp.machine__process_mmap2_event
     11.85 ± 21%     -11.2        0.65 ± 58%  perf-profile.children.cycles-pp.start_secondary
     11.91 ± 17%     -11.2        0.75 ± 57%  perf-profile.children.cycles-pp.cpuidle_idle_call
     11.03 ± 17%     -10.3        0.71 ± 57%  perf-profile.children.cycles-pp.cpuidle_enter
     11.03 ± 16%     -10.3        0.71 ± 57%  perf-profile.children.cycles-pp.cpuidle_enter_state
      9.17 ± 16%      -8.5        0.67 ± 58%  perf-profile.children.cycles-pp.acpi_idle_enter
      9.16 ± 16%      -8.5        0.67 ± 59%  perf-profile.children.cycles-pp.acpi_idle_do_entry
      9.16 ± 16%      -8.5        0.67 ± 58%  perf-profile.children.cycles-pp.pv_native_safe_halt
      9.16 ± 16%      -8.5        0.67 ± 59%  perf-profile.children.cycles-pp.acpi_safe_halt
      6.48 ±  9%      -6.3        0.13 ± 86%  perf-profile.children.cycles-pp.evlist__parse_sample
      6.10 ± 10%      -6.0        0.09 ± 59%  perf-profile.children.cycles-pp.map__new
      5.98 ±  5%      -5.6        0.40 ± 53%  perf-profile.children.cycles-pp.ret_from_fork_asm
      5.97 ±  5%      -5.6        0.40 ± 53%  perf-profile.children.cycles-pp.ret_from_fork
      5.92 ±  5%      -5.5        0.40 ± 53%  perf-profile.children.cycles-pp.kthread
      6.25 ± 19%      -5.0        1.29 ± 37%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      5.05 ±  9%      -4.9        0.10 ±105%  perf-profile.children.cycles-pp.evlist__event2evsel
      3.61 ± 11%      -3.6        0.04 ± 83%  perf-profile.children.cycles-pp.__dsos__find_by_longname_id
      3.54 ± 13%      -3.5        0.04 ± 83%  perf-profile.children.cycles-pp.maps__fixup_overlap_and_insert
      4.53 ± 20%      -3.3        1.18 ± 35%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      3.47 ± 14%      -3.3        0.17 ± 50%  perf-profile.children.cycles-pp._nohz_idle_balance
      3.37 ± 12%      -3.1        0.24 ± 45%  perf-profile.children.cycles-pp.asm_sysvec_call_function_single
      3.33 ±  5%      -3.1        0.20 ± 60%  perf-profile.children.cycles-pp.worker_thread
      3.61 ± 10%      -3.0        0.59 ± 55%  perf-profile.children.cycles-pp.__irq_exit_rcu
      3.70 ± 10%      -3.0        0.73 ± 59%  perf-profile.children.cycles-pp.handle_softirqs
      2.95 ± 10%      -2.9        0.04 ± 83%  perf-profile.children.cycles-pp.dsos__findnew_id
      3.03 ±  7%      -2.9        0.13 ± 65%  perf-profile.children.cycles-pp.process_one_work
      2.89 ± 14%      -2.9        0.04 ± 83%  perf-profile.children.cycles-pp.__maps__fixup_overlap_and_insert
      3.04 ± 10%      -2.8        0.22 ± 46%  perf-profile.children.cycles-pp.sysvec_call_function_single
      2.80 ±  9%      -2.7        0.07 ± 93%  perf-profile.children.cycles-pp.read
      2.86 ±  6%      -2.6        0.23 ± 82%  perf-profile.children.cycles-pp.write
      2.70 ± 11%      -2.6        0.07 ± 93%  perf-profile.children.cycles-pp.ksys_read
      2.79 ±  6%      -2.6        0.21 ± 81%  perf-profile.children.cycles-pp.ksys_write
      2.78 ±  6%      -2.6        0.20 ± 80%  perf-profile.children.cycles-pp.vfs_write
      2.61 ± 11%      -2.5        0.07 ± 91%  perf-profile.children.cycles-pp.vfs_read
      2.60 ±  8%      -2.5        0.05 ± 91%  perf-profile.children.cycles-pp.asm_exc_page_fault
      2.54 ± 11%      -2.4        0.17 ± 32%  perf-profile.children.cycles-pp.__schedule
      2.41 ±  9%      -2.4        0.04 ± 86%  perf-profile.children.cycles-pp.machine__findnew_thread
      2.32 ±  9%      -2.3        0.04 ± 90%  perf-profile.children.cycles-pp.evsel__parse_sample
      2.27 ± 12%      -2.2        0.06 ± 93%  perf-profile.children.cycles-pp.seq_read_iter
      2.24 ± 10%      -2.2        0.05 ± 93%  perf-profile.children.cycles-pp.exc_page_fault
      2.23 ± 10%      -2.2        0.05 ± 93%  perf-profile.children.cycles-pp.do_user_addr_fault
      2.32 ±  8%      -2.1        0.20 ± 39%  perf-profile.children.cycles-pp.sched_balance_rq
      2.23 ± 12%      -2.1        0.12 ± 66%  perf-profile.children.cycles-pp.rest_init
      2.23 ± 12%      -2.1        0.12 ± 66%  perf-profile.children.cycles-pp.start_kernel
      2.23 ± 12%      -2.1        0.12 ± 66%  perf-profile.children.cycles-pp.x86_64_start_kernel
      2.23 ± 12%      -2.1        0.12 ± 66%  perf-profile.children.cycles-pp.x86_64_start_reservations
      2.78 ± 22%      -2.1        0.73 ± 28%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      2.73 ± 23%      -2.0        0.72 ± 28%  perf-profile.children.cycles-pp.hrtimer_interrupt
      2.06 ± 11%      -2.0        0.05 ± 90%  perf-profile.children.cycles-pp.handle_mm_fault
      2.00 ± 11%      -2.0        0.04 ± 93%  perf-profile.children.cycles-pp.__handle_mm_fault
      2.09 ±  9%      -1.9        0.17 ± 42%  perf-profile.children.cycles-pp.sched_balance_find_src_group
      2.06 ± 13%      -1.9        0.15 ± 30%  perf-profile.children.cycles-pp.schedule
      2.07 ±  9%      -1.9        0.17 ± 42%  perf-profile.children.cycles-pp.update_sd_lb_stats
      1.93 ± 10%      -1.8        0.16 ± 41%  perf-profile.children.cycles-pp.update_sg_lb_stats
      1.95 ±  6%      -1.7        0.22 ± 84%  perf-profile.children.cycles-pp.writen
      1.91 ±  6%      -1.7        0.19 ± 80%  perf-profile.children.cycles-pp.shmem_file_write_iter
      1.89 ±  6%      -1.7        0.18 ± 78%  perf-profile.children.cycles-pp.generic_perform_write
      1.80 ± 10%      -1.7        0.13 ± 33%  perf-profile.children.cycles-pp.__pick_next_task
      1.86 ±  6%      -1.6        0.22 ± 84%  perf-profile.children.cycles-pp.record__pushfn
      1.82 ± 14%      -1.6        0.17 ± 72%  perf-profile.children.cycles-pp.smpboot_thread_fn
      1.95 ±  6%      -1.6        0.35 ± 99%  perf-profile.children.cycles-pp.perf_mmap__push
      1.95 ±  6%      -1.6        0.36 ±100%  perf-profile.children.cycles-pp.record__mmap_read_evlist
      1.58 ± 16%      -1.5        0.05 ± 93%  perf-profile.children.cycles-pp.seq_read
      1.59 ± 11%      -1.5        0.12 ± 35%  perf-profile.children.cycles-pp.sched_balance_newidle
      1.87 ± 23%      -1.3        0.53 ± 24%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      1.37 ±  7%      -1.2        0.13 ± 79%  perf-profile.children.cycles-pp.copy_page_from_iter_atomic
      1.69 ± 24%      -1.2        0.51 ± 24%  perf-profile.children.cycles-pp.tick_nohz_handler
      1.17 ± 14%      -1.1        0.09 ± 39%  perf-profile.children.cycles-pp.vfs_fstatat
      1.09 ±  5%      -1.0        0.07 ± 91%  perf-profile.children.cycles-pp.sched_balance_domains
      1.04 ± 21%      -1.0        0.05 ± 64%  perf-profile.children.cycles-pp.raw_spin_rq_lock_nested
      1.00 ± 21%      -1.0        0.04 ± 88%  perf-profile.children.cycles-pp.idle_cpu
      1.03 ± 10%      -0.9        0.18 ± 68%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.80 ± 12%      -0.8        0.05 ± 88%  perf-profile.children.cycles-pp.sched_balance_update_blocked_averages
      1.10 ± 12%      -0.7        0.38 ± 39%  perf-profile.children.cycles-pp.__alloc_frozen_pages_noprof
      1.01 ± 11%      -0.7        0.32 ± 37%  perf-profile.children.cycles-pp.get_page_from_freelist
      0.99 ± 10%      -0.6        0.36 ± 43%  perf-profile.children.cycles-pp.alloc_pages_mpol
      1.04 ± 30%      -0.6        0.45 ± 20%  perf-profile.children.cycles-pp.update_process_times
      0.72 ± 27%      -0.6        0.16 ± 48%  perf-profile.children.cycles-pp.ktime_get
      0.62 ± 17%      -0.5        0.11 ± 27%  perf-profile.children.cycles-pp.pick_next_task_fair
      0.55 ± 18%      -0.5        0.04 ± 53%  perf-profile.children.cycles-pp.update_load_avg
      0.76 ±  9%      -0.5        0.25 ± 40%  perf-profile.children.cycles-pp.clear_page_erms
      0.62 ± 28%      -0.5        0.15 ± 42%  perf-profile.children.cycles-pp.clockevents_program_event
      0.45 ± 34%      -0.2        0.22 ± 20%  perf-profile.children.cycles-pp.sched_tick
      0.25 ± 25%      -0.2        0.04 ± 83%  perf-profile.children.cycles-pp.rmqueue
      0.28 ± 44%      -0.2        0.09 ± 28%  perf-profile.children.cycles-pp.tmigr_requires_handle_remote
      0.20 ± 36%      -0.2        0.04 ± 83%  perf-profile.children.cycles-pp.__rmqueue_pcplist
      0.24 ± 19%      -0.2        0.08 ±106%  perf-profile.children.cycles-pp.tracing_buffers_open
      0.17 ± 50%      -0.1        0.05 ± 90%  perf-profile.children.cycles-pp.__memset
      0.05 ± 72%      +0.1        0.10 ± 11%  perf-profile.children.cycles-pp.task_tick_fair
      0.00            +0.1        0.06 ± 14%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.00            +0.1        0.08 ± 33%  perf-profile.children.cycles-pp.readdir64
      0.00            +0.1        0.08 ± 40%  perf-profile.children.cycles-pp.mas_ascend
      0.00            +0.1        0.10 ± 57%  perf-profile.children.cycles-pp.kmem_cache_free_bulk
      0.00            +0.1        0.11 ± 41%  perf-profile.children.cycles-pp.cp_new_stat
      0.00            +0.1        0.11 ± 53%  perf-profile.children.cycles-pp.simple_getattr
      0.04 ± 73%      +0.1        0.16 ± 76%  perf-profile.children.cycles-pp.up_write
      0.02 ±142%      +0.1        0.14 ± 58%  perf-profile.children.cycles-pp.path_init
      0.00            +0.1        0.13 ± 66%  perf-profile.children.cycles-pp.__rb_insert_augmented
      0.00            +0.1        0.13 ± 60%  perf-profile.children.cycles-pp.nd_jump_root
      0.06 ± 74%      +0.1        0.19 ± 43%  perf-profile.children.cycles-pp.alloc_empty_file
      0.00            +0.1        0.13 ± 89%  perf-profile.children.cycles-pp.tlb_remove_table_rcu
      0.02 ±142%      +0.1        0.15 ± 45%  perf-profile.children.cycles-pp.vm_area_alloc
      0.00            +0.1        0.14 ± 38%  perf-profile.children.cycles-pp.filldir64
      0.00            +0.1        0.14 ± 54%  perf-profile.children.cycles-pp.unmap_region
      0.01 ±223%      +0.1        0.16 ± 39%  perf-profile.children.cycles-pp.mas_find
      0.00            +0.1        0.15 ± 67%  perf-profile.children.cycles-pp.pfn_modify_allowed
      0.02 ±142%      +0.1        0.17 ± 95%  perf-profile.children.cycles-pp.kernfs_unlink_open_file
      0.11 ± 20%      +0.2        0.27 ± 42%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.02 ±144%      +0.2        0.19 ± 45%  perf-profile.children.cycles-pp.rb_next
      0.00            +0.2        0.18 ± 33%  perf-profile.children.cycles-pp.vma_migratable
      0.02 ±142%      +0.2        0.20 ± 32%  perf-profile.children.cycles-pp.lockref_get
      0.00            +0.2        0.19 ± 55%  perf-profile.children.cycles-pp.generic_fillattr
      0.13 ± 40%      +0.2        0.32 ± 48%  perf-profile.children.cycles-pp.alloc_pages_noprof
      0.00            +0.2        0.19 ± 33%  perf-profile.children.cycles-pp.task_numa_work
      0.13 ± 22%      +0.2        0.33 ± 41%  perf-profile.children.cycles-pp.entry_SYSCALL_64
      0.05 ±109%      +0.2        0.26 ± 72%  perf-profile.children.cycles-pp.mas_wr_bnode
      0.00            +0.2        0.21 ± 82%  perf-profile.children.cycles-pp.vma_interval_tree_remove
      0.03 ±141%      +0.2        0.24 ± 83%  perf-profile.children.cycles-pp.kernfs_fop_release
      0.00            +0.2        0.22 ± 74%  perf-profile.children.cycles-pp.tracing_open_file_tr
      0.00            +0.2        0.25 ± 76%  perf-profile.children.cycles-pp.__kmem_cache_alloc_bulk
      0.00            +0.3        0.26 ± 73%  perf-profile.children.cycles-pp.kmem_cache_alloc_bulk_noprof
      0.06 ± 73%      +0.3        0.33 ± 54%  perf-profile.children.cycles-pp.mas_preallocate
      0.05 ± 79%      +0.3        0.35 ± 49%  perf-profile.children.cycles-pp.pte_alloc_one
      0.00            +0.4        0.36 ± 48%  perf-profile.children.cycles-pp.__pte_alloc
      0.02 ±142%      +0.4        0.43 ± 67%  perf-profile.children.cycles-pp.mas_alloc_nodes
      0.00            +0.4        0.44 ± 45%  perf-profile.children.cycles-pp.mas_rev_awalk
      0.27 ± 14%      +0.5        0.76 ± 37%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.01 ±223%      +0.5        0.50 ± 52%  perf-profile.children.cycles-pp.generic_permission
      0.07 ± 47%      +0.5        0.59 ± 34%  perf-profile.children.cycles-pp.task_work_run
      0.00            +0.6        0.56 ± 84%  perf-profile.children.cycles-pp.vm_normal_page
      0.00            +0.6        0.57 ± 44%  perf-profile.children.cycles-pp.mas_empty_area_rev
      0.14 ± 25%      +0.6        0.74 ± 66%  perf-profile.children.cycles-pp.kernfs_fop_open
      0.00            +0.6        0.62 ± 78%  perf-profile.children.cycles-pp.mas_store_gfp
      0.02 ±142%      +0.7        0.67 ± 92%  perf-profile.children.cycles-pp.scan_positives
      0.01 ±223%      +0.7        0.66 ± 44%  perf-profile.children.cycles-pp.unmapped_area_topdown
      0.01 ±223%      +0.7        0.67 ± 44%  perf-profile.children.cycles-pp.vm_unmapped_area
      0.07 ± 73%      +0.7        0.73 ± 74%  perf-profile.children.cycles-pp.free_pgtables
      0.00            +0.7        0.67 ±120%  perf-profile.children.cycles-pp.__traverse_mounts
      0.01 ±223%      +0.7        0.69 ± 76%  perf-profile.children.cycles-pp.unlink_file_vma_batch_process
      0.00            +0.7        0.69 ± 53%  perf-profile.children.cycles-pp.set_nlink
      0.01 ±223%      +0.7        0.73 ± 43%  perf-profile.children.cycles-pp.arch_get_unmapped_area_topdown
      0.02 ±141%      +0.7        0.75 ± 43%  perf-profile.children.cycles-pp.__get_unmapped_area
      0.06 ± 77%      +0.8        0.82 ± 83%  perf-profile.children.cycles-pp.dcache_readdir
      1.20 ± 11%      +0.8        2.01 ± 41%  perf-profile.children.cycles-pp.do_dentry_open
      0.00            +0.8        0.83 ± 50%  perf-profile.children.cycles-pp.kernfs_fop_readdir
      1.20 ± 11%      +0.9        2.07 ± 42%  perf-profile.children.cycles-pp.vfs_open
      0.00            +1.0        1.02 ± 60%  perf-profile.children.cycles-pp.remap_pfn_range_internal
      0.00            +1.0        1.04 ± 60%  perf-profile.children.cycles-pp.remap_pfn_range
      0.00            +1.0        1.05 ± 60%  perf-profile.children.cycles-pp.kernfs_fop_mmap
      0.47 ±  8%      +1.1        1.60 ± 46%  perf-profile.children.cycles-pp.open_last_lookups
      0.16 ± 65%      +1.5        1.66 ± 51%  perf-profile.children.cycles-pp.vma_interval_tree_insert
      0.10 ± 36%      +1.8        1.90 ± 53%  perf-profile.children.cycles-pp.iterate_dir
      0.10 ± 36%      +1.8        1.92 ± 53%  perf-profile.children.cycles-pp.__x64_sys_getdents64
      0.10 ± 35%      +1.9        1.99 ± 52%  perf-profile.children.cycles-pp.getdents64
      1.24 ± 12%      +2.1        3.35 ± 35%  perf-profile.children.cycles-pp.__do_sys_newfstatat
      1.30 ± 12%      +2.3        3.62 ± 35%  perf-profile.children.cycles-pp.fstatat64
      0.08 ± 51%      +2.5        2.54 ± 42%  perf-profile.children.cycles-pp.lockref_put_return
      0.21 ± 26%      +2.8        3.03 ± 40%  perf-profile.children.cycles-pp.may_open
      0.00            +2.9        2.86 ± 37%  perf-profile.children.cycles-pp.kernfs_iop_getattr
      0.05 ± 50%      +3.0        3.10 ± 36%  perf-profile.children.cycles-pp.vfs_getattr_nosec
      0.17 ± 40%      +3.1        3.28 ± 76%  perf-profile.children.cycles-pp.zap_present_ptes
      0.02 ±142%      +3.1        3.14 ± 36%  perf-profile.children.cycles-pp.vfs_fstat
      1.45 ±  7%      +3.7        5.20 ± 39%  perf-profile.children.cycles-pp.do_open
      0.23 ± 39%      +3.9        4.17 ± 77%  perf-profile.children.cycles-pp.zap_pte_range
      0.23 ± 40%      +3.9        4.18 ± 77%  perf-profile.children.cycles-pp.zap_pmd_range
      0.24 ± 39%      +4.0        4.21 ± 76%  perf-profile.children.cycles-pp.unmap_page_range
      0.07 ± 61%      +4.0        4.03 ± 53%  perf-profile.children.cycles-pp.terminate_walk
      0.10 ± 59%      +4.0        4.15 ± 51%  perf-profile.children.cycles-pp.try_to_unlazy
      0.24 ± 30%      +4.1        4.32 ± 36%  perf-profile.children.cycles-pp.kernfs_dop_revalidate
      0.07 ± 85%      +4.1        4.19 ± 51%  perf-profile.children.cycles-pp.lockref_get_not_dead
      0.10 ± 66%      +4.1        4.21 ± 50%  perf-profile.children.cycles-pp.__legitimize_path
      0.26 ± 36%      +4.2        4.41 ± 76%  perf-profile.children.cycles-pp.unmap_vmas
      0.24 ± 25%      +4.7        4.96 ± 46%  perf-profile.children.cycles-pp.__mmap_new_vma
      0.06 ± 84%      +5.0        5.04 ± 77%  perf-profile.children.cycles-pp.vms_clear_ptes
      0.56 ± 19%      +5.2        5.71 ± 49%  perf-profile.children.cycles-pp.__mmap_region
      0.04 ±110%      +5.2        5.23 ± 77%  perf-profile.children.cycles-pp.vms_complete_munmap_vmas
      0.60 ± 18%      +5.9        6.54 ± 47%  perf-profile.children.cycles-pp.do_mmap
      0.61 ± 19%      +6.0        6.62 ± 47%  perf-profile.children.cycles-pp.vm_mmap_pgoff
      0.08 ± 67%      +6.1        6.18 ± 77%  perf-profile.children.cycles-pp.do_vmi_align_munmap
      0.09 ± 52%      +6.1        6.19 ± 77%  perf-profile.children.cycles-pp.do_vmi_munmap
      0.08 ± 68%      +6.1        6.21 ± 77%  perf-profile.children.cycles-pp.__vm_munmap
      0.04 ±141%      +6.2        6.21 ± 77%  perf-profile.children.cycles-pp.__x64_sys_munmap
      0.46 ± 22%      +6.2        6.66 ± 47%  perf-profile.children.cycles-pp.ksys_mmap_pgoff
      0.04 ±151%      +6.6        6.68 ± 76%  perf-profile.children.cycles-pp.__munmap
      0.21 ± 16%      +6.7        6.92 ± 47%  perf-profile.children.cycles-pp.__mmap
      0.22 ± 21%      +9.3        9.50 ± 17%  perf-profile.children.cycles-pp.__open64_nocancel
      0.09 ± 29%     +12.1       12.17 ± 32%  perf-profile.children.cycles-pp.up_read
      0.46 ± 16%     +14.6       15.04 ± 60%  perf-profile.children.cycles-pp.step_into
      0.41 ±  9%     +14.6       15.03 ± 59%  perf-profile.children.cycles-pp.__d_lookup
      0.88 ± 15%     +17.4       18.28 ± 46%  perf-profile.children.cycles-pp.walk_component
      1.19 ± 11%     +18.5       19.67 ± 40%  perf-profile.children.cycles-pp.lookup_fast
      0.19 ± 21%     +18.8       18.96 ± 58%  perf-profile.children.cycles-pp.dput
      0.08 ± 85%     +20.2       20.29 ± 38%  perf-profile.children.cycles-pp.down_read
      0.12 ± 30%     +26.5       26.60 ± 38%  perf-profile.children.cycles-pp.kernfs_iop_permission
      0.35 ± 28%     +29.1       29.46 ± 38%  perf-profile.children.cycles-pp.inode_permission
      0.46 ± 18%     +32.9       33.37 ± 70%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      1.51 ± 19%     +33.5       35.02 ± 65%  perf-profile.children.cycles-pp._raw_spin_lock
      1.12 ± 13%     +62.9       64.03 ± 19%  perf-profile.children.cycles-pp.link_path_walk
      2.48 ±  7%     +64.0       66.47 ± 15%  perf-profile.children.cycles-pp.open64
      2.63 ±  7%     +72.6       75.19 ± 15%  perf-profile.children.cycles-pp.path_openat
      2.63 ±  7%     +72.6       75.20 ± 15%  perf-profile.children.cycles-pp.do_filp_open
      2.76 ±  7%     +72.7       75.50 ± 15%  perf-profile.children.cycles-pp.do_sys_openat2
      2.76 ±  7%     +72.7       75.51 ± 15%  perf-profile.children.cycles-pp.__x64_sys_openat
     14.50 ±  6%     +81.5       95.98 ±  2%  perf-profile.children.cycles-pp.do_syscall_64
     14.51 ±  6%     +81.5       96.03 ±  2%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     37.26 ±  8%     -36.3        0.99 ± 78%  perf-profile.self.cycles-pp.queue_event
      4.85 ±  9%      -4.8        0.10 ±104%  perf-profile.self.cycles-pp.evlist__event2evsel
      3.19 ± 10%      -3.2        0.04 ± 83%  perf-profile.self.cycles-pp.__dsos__find_by_longname_id
      2.80 ± 13%      -2.8        0.04 ± 83%  perf-profile.self.cycles-pp.__maps__fixup_overlap_and_insert
      2.29 ±  9%      -2.2        0.04 ± 90%  perf-profile.self.cycles-pp.evsel__parse_sample
      1.98 ± 20%      -1.9        0.09 ±108%  perf-profile.self.cycles-pp.pv_native_safe_halt
      1.39 ±  9%      -1.3        0.13 ± 43%  perf-profile.self.cycles-pp.update_sg_lb_stats
      1.32 ±  6%      -1.2        0.13 ± 81%  perf-profile.self.cycles-pp.copy_page_from_iter_atomic
      0.99 ± 22%      -1.0        0.04 ± 88%  perf-profile.self.cycles-pp.idle_cpu
      0.74 ± 10%      -0.5        0.24 ± 40%  perf-profile.self.cycles-pp.clear_page_erms
      0.61 ± 27%      -0.5        0.15 ± 45%  perf-profile.self.cycles-pp.ktime_get
      0.15 ± 52%      -0.1        0.05 ± 90%  perf-profile.self.cycles-pp.__memset
      0.00            +0.1        0.06 ± 14%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.00            +0.1        0.07 ± 37%  perf-profile.self.cycles-pp.readdir64
      0.00            +0.1        0.08 ± 42%  perf-profile.self.cycles-pp.step_into
      0.00            +0.1        0.08 ± 41%  perf-profile.self.cycles-pp.mas_ascend
      0.00            +0.1        0.10 ± 46%  perf-profile.self.cycles-pp.__mmap_region
      0.00            +0.1        0.10 ± 38%  perf-profile.self.cycles-pp.filldir64
      0.00            +0.1        0.13 ± 68%  perf-profile.self.cycles-pp.__rb_insert_augmented
      0.00            +0.1        0.14 ± 68%  perf-profile.self.cycles-pp.pfn_modify_allowed
      0.11 ± 20%      +0.2        0.27 ± 41%  perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.02 ±142%      +0.2        0.18 ± 33%  perf-profile.self.cycles-pp.lockref_get
      0.02 ±144%      +0.2        0.19 ± 44%  perf-profile.self.cycles-pp.rb_next
      0.00            +0.2        0.17 ± 34%  perf-profile.self.cycles-pp.vma_migratable
      0.00            +0.2        0.18 ± 53%  perf-profile.self.cycles-pp.generic_fillattr
      0.00            +0.2        0.19 ± 74%  perf-profile.self.cycles-pp.__kmem_cache_alloc_bulk
      0.00            +0.2        0.20 ± 81%  perf-profile.self.cycles-pp.vma_interval_tree_remove
      0.00            +0.2        0.23 ± 53%  perf-profile.self.cycles-pp.kernfs_fop_readdir
      0.02 ±142%      +0.2        0.27 ± 59%  perf-profile.self.cycles-pp.__fput
      0.06 ± 75%      +0.3        0.32 ± 38%  perf-profile.self.cycles-pp.do_dentry_open
      0.00            +0.4        0.38 ± 45%  perf-profile.self.cycles-pp.mas_rev_awalk
      0.01 ±223%      +0.5        0.49 ± 51%  perf-profile.self.cycles-pp.generic_permission
      0.00            +0.5        0.52 ± 66%  perf-profile.self.cycles-pp.remap_pfn_range_internal
      0.00            +0.5        0.52 ± 83%  perf-profile.self.cycles-pp.vm_normal_page
      0.00            +0.7        0.69 ± 52%  perf-profile.self.cycles-pp.set_nlink
      0.02 ±142%      +0.8        0.82 ± 84%  perf-profile.self.cycles-pp.zap_pte_range
      0.07 ± 86%      +1.0        1.07 ± 31%  perf-profile.self.cycles-pp.lockref_get_not_dead
      0.16 ± 65%      +1.5        1.61 ± 51%  perf-profile.self.cycles-pp.vma_interval_tree_insert
      0.08 ± 50%      +2.4        2.51 ± 42%  perf-profile.self.cycles-pp.lockref_put_return
      0.18 ± 21%      +2.5        2.70 ± 57%  perf-profile.self.cycles-pp.inode_permission
      0.07 ± 74%      +2.5        2.61 ± 73%  perf-profile.self.cycles-pp.zap_present_ptes
      0.08 ± 27%     +12.0       12.10 ± 32%  perf-profile.self.cycles-pp.up_read
      0.08 ± 88%     +19.8       19.91 ± 39%  perf-profile.self.cycles-pp.down_read
      0.46 ± 18%     +32.7       33.19 ± 70%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

