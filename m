Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED472FD7D2;
	Wed, 15 Oct 2025 05:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760505278; cv=fail; b=QSV+MpFgeEPIVXlMzL64BCV57M/3kT1VKOcYkJVhbm4QWTe1OUbuJHvAq9CWHZ9csElXF0LzE4sFlEqBpCGN5SuO5EMsjbNCcbsEmyY5Nx8sKR/M4Z7yfSL3qbY2iKZ27dyXmp/4LnMM1UQO2adYF1YYeehU4rMzNhOHZcG/0RA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760505278; c=relaxed/simple;
	bh=ELk1e77UCO4Q6JGfIKZs4m1HneuTlUdOVf6QPn5VQzQ=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=iYlBp4QV2CBL6/8q/s4WBrQD67PIBrR3j0/q+mAYRuKgzxl9mUJGZwpvoUmrAfudshaKTG3VdB8t2hG5N5LbT5DM3M/EEF7CWkefmj/STEzDZFPagMdFhbungrlIszc6FHc2D79QF0u1wf3k9KspOFe5JSknYOjXLkHvy4mxP8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RzrRX7c/; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RzrRX7c/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760505277; x=1792041277;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ELk1e77UCO4Q6JGfIKZs4m1HneuTlUdOVf6QPn5VQzQ=;
  b=RzrRX7c/PxslNsCJUrKMRAAjDsjyTSkQyc0exGsh7wG57MJRSYaXVWe0
   Ni5g7Y9PDbB5A67NHIedybtbBiJo/6Egf+ay+VDh/OO55FcxScnZ0a7xS
   4NyWMiR6w256pFmOGeMebfEFg7qgAVp7HL9SDSpg1tZhkX7TGXlaYky6K
   ZpD4ixzsVcjheY1PD5dv49yYcE+L0gwuZ8UDvQ8qsksLfPlfvJM1xKaEL
   Ii/eqW0G18Ou67mcqEOaJ2i6F9GxcSYHDaP6NDmvqKfbgAXelqxqafOCB
   P3KH9GlxNaaSnu5qpLwqbIZWLBbhuvhYXvGrCD3SlcaNI9NVnLZU7q8Sj
   g==;
X-CSE-ConnectionGUID: sfrjuoKXSzmIMKAE9X2Jbg==
X-CSE-MsgGUID: EIoTw5PYQnWOZrB7t7zhaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="85289718"
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; 
   d="xz'341?scan'341,208,341";a="85289718"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 22:14:36 -0700
X-CSE-ConnectionGUID: lZnmF1kORNCeGYrx1XGaHQ==
X-CSE-MsgGUID: J+XTvHzhTueYYH1gmV+Nig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; 
   d="xz'341?scan'341,208,341";a="182016613"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 22:14:35 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 14 Oct 2025 22:14:35 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 14 Oct 2025 22:14:35 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.21) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 14 Oct 2025 22:14:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gh4xXQj+T+4fgDm0HN670k8CwPYs3pSDzHR/JGdm0JB4LmxIiXqHtxeSxDfxroqWYv3azyTOyh6CmA1SA8zbwE+//rgjE2UYGBVZuy6a+KbrxB7NJAtDL+3vmP5ZRthS7jmdLb7EcYSSaoYnMGvRzjSLEbZe1YlT12+T6w2RLJsnIjU6YH2wPkGwpWNbhfr9vU74rEay6c3yfsS++Z+IVyU6rt6vDNy7ySyNsEZuyzQDgODOfQXyIq1SPAMQ163qZgNbBnyRAUumMOdl2UPHLWNNDa//HCpjWP/T/EK7mChyXXiI5aiQ4weKHqFNwGYDIKZ5IJWOGL3azx9eMl82+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UGQxSHJvBJVwbqwcXockASbIvWnjCFTUM2eV6A4T5ck=;
 b=t6nKcLH97ePsx4YETRmT0VGMShDQfZ95u0r+XNzQJ1XSv8DU+XSe2xZXiZBA9pMwdXrRvy8yI2AFiWX0uydVuqksOfoT/Ugzc642Z0gJFZ6X/MRzjpcFqTOPwNtgsSOIn1SK+HaISKN/+H1tE8lpkNbitD7zaIHbqwhhiOI97G50JRqz4dICkw6lJaoEyCJvMtmtteEabR4MfZ8wMU8kdLFxDbZIpIFRMc8AbwvjybTSCgDQTUwNvP2+8rz9Sd5n3NkPdAjWXbnLCc3pH4J7X0B6g4E7sDQY0sQ+8EGBo3K+qN9KZDkXr4xhpUGsnbApgBNkdG1hvIyulj18Aze6Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH3PPF5A636EDE4.namprd11.prod.outlook.com (2603:10b6:518:1::d21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Wed, 15 Oct
 2025 05:14:26 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9203.009; Wed, 15 Oct 2025
 05:14:26 +0000
Date: Wed, 15 Oct 2025 13:14:14 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Steven Rostedt <rostedt@goodmis.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
	<mathieu.desnoyers@efficios.com>, Will Deacon <will@kernel.org>, Russell King
	<linux@armlinux.org.uk>, Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner
	<tglx@linutronix.de>, Valentin Schneider <vschneid@redhat.com>, Nicolas Pitre
	<nico@fluxnic.net>, Peter Zijlstra <peterz@infradead.org>, Catalin Marinas
	<catalin.marinas@arm.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-trace-kernel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linus:master] [tracing]  9f0cb91767: BUG:kernel_hang_in_boot_stage
Message-ID: <202510150626.636464df-lkp@intel.com>
Content-Type: multipart/mixed; boundary="vGmfYNHtEf0U2onE"
Content-Disposition: inline
X-ClientProxiedBy: KU2P306CA0004.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:14::19) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH3PPF5A636EDE4:EE_
X-MS-Office365-Filtering-Correlation-Id: 025745a4-3421-4e78-7593-08de0ba9b5dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|4053099003;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ctpOLN5K/gaUVtVJoQu5BS/SqeUXhXvQSUXXUv0Mx40ky/NHtJycjQLgqyMW?=
 =?us-ascii?Q?2dT/MRJ220IiPDvgR6SEJ4ipI0jMxHhWp0/FLJ32lILvCIfF6scCQdxgR7M/?=
 =?us-ascii?Q?norECVt0cF5HZ2dvCah3oecg29IvyhY2+6zwEOSRx+RuImc6XD+1GvAoVsE6?=
 =?us-ascii?Q?GAwViQgjmarGgw0Zl2WL2coRPFNF3SMvPxceb28oVmu/x3C092+feGHQzQ84?=
 =?us-ascii?Q?jMVCvyzDUM5n4ZTZi1VcGbd/Q5erevvd/T76E+GR5Msl7OboO5a0jrnbwD5J?=
 =?us-ascii?Q?ZagFAIfBdkr+RtHz6+t7TuMyHhSy/2lfxEWDyhtjJpiV/JpbIH8gqAdCeXCG?=
 =?us-ascii?Q?TOu9gGZupMdYWD0qx37nn8w8AdQYpxG1mtF4STyLDzplsdaBMK59a9IDpWE7?=
 =?us-ascii?Q?7AFLO5P4iH9xBvsAk6qRDy4O8/VAPT4nTf5ajvkhuvw/OS46H4PAKb8NbwSr?=
 =?us-ascii?Q?cnxGiT88pA/twQltce0aP+AEGNoeKhbkM2op5MHlZEGBjMRM94U8lngUAvpd?=
 =?us-ascii?Q?tZBQfEdUxAAgHsvb3kxbMPxgNdvqYOz9M/cDRBu6pw2GRLGohXtEa527Alj9?=
 =?us-ascii?Q?T7IeNsYyyphD/FZRhkPWS4+4KP4wKhcFThrJJedKi3XYMje9tY0lezChNNiI?=
 =?us-ascii?Q?BR/4mMbu1VOai6iViIAfj1EN8WdiZycIVLYNuRhOz9cUoUbYCuec3HR+GRPU?=
 =?us-ascii?Q?RV3nuvrnOGT5SiKIST+fe7gVjiPL6mvWXwB338yKcBA1tehdUjCxxVuY8uSW?=
 =?us-ascii?Q?ekFmTJhUek9iurjVZ67hUn15Ig1wEGrEu/ALaS9yLkIU7pclEMUATOCleqni?=
 =?us-ascii?Q?nfbyhIWlJIo2M8eqA+CFuMpLtWaqOn4iWoUXtxOaN9RtJzg0S7/YGFiLb8tM?=
 =?us-ascii?Q?sB4wgy6NNK34UsW2rCWe2b+7oAiRGjHy/2lnxR2972LfTjPWShfQFIXd3Zmt?=
 =?us-ascii?Q?VcGqtGvoTQynsXlRVeZGROte5vGnkCE8NzM+PkPrj7ybczmULc2qypF26WK1?=
 =?us-ascii?Q?lhZwmTZrrdlXf8KHBxpe9C4/ytKM00y6rVXkoqyXX7VyahYx3k7p0q7pXfg8?=
 =?us-ascii?Q?LrAtJ/uGV2Gr7gMyaBPxYoETA5/45MJo9tz0XdsQEHvdgv5ePPTNdBMoGp5w?=
 =?us-ascii?Q?ERjHfc/M2UvEEn5/BhEClof/Pjd5H2BqM10bwV0A8z5M3h84fLEW6RHspyqo?=
 =?us-ascii?Q?jrFar5g9w80o8SBWxAUKrtZRHwBhKxI5c+C5NvdBwDs1OP9FOC/zRistZOsT?=
 =?us-ascii?Q?BNeV8jopxVOcaOHUf5iBUagL4cMDz/JZqUOqrTl2tbgV89/7rWsLCexyo0vW?=
 =?us-ascii?Q?EKpLrav1mV/31Cq4c0/r6b7qc/OpN5JC20ak+gDitw989fe1q9uLp+uBKcfo?=
 =?us-ascii?Q?gM5xo810nexbJ9yilqXMLu2FKI0qn3Ac49OkDzAqbeqe6FDTa7LzSUTu/EQ8?=
 =?us-ascii?Q?2NrkxSm5URI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(4053099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9bssm8YXZ9Sx9DQm/8GTKF/ER/XA+ztHo+dpwhkPBM/y5pt+vVH/BJMweDC9?=
 =?us-ascii?Q?hI5Ctp89dWfTt1LpPK0PDYn5PIR/765a43VFXBRLy5CE+PFZID89eSLVoAHB?=
 =?us-ascii?Q?Gat66nDqoRDKKPf3+XbxJ9o5NjbUjzvmQODJ7z+sK1cbi56HxTTFKg0+dbPX?=
 =?us-ascii?Q?Bwt2T8M53Ng4yFuUTqKDysAp/BUQLqsG+Osd90wwY70IRR7bDV//r1B7F3cg?=
 =?us-ascii?Q?osfcFpCjhd+gSpwlT7ugTprDVxAiDzFZDH+WbXtcL4kv3g+7zlj7oLEW3RMc?=
 =?us-ascii?Q?Fn0wYnvgLUjhmmVsXY8/ipFtH5rjb9z+sT4XRHOYhoMNn4NSjR+jmRE18RmG?=
 =?us-ascii?Q?vwXhK0btLi55Zfzt+gHzC78a17dzzHoaRB8NsuR3JYYd737OgM6sUYwJr6H3?=
 =?us-ascii?Q?TqlI/tYPNHkN2GYuFb8zskuXDPB74J58MhG1KClzqJky7okNuE2hAxklLqB5?=
 =?us-ascii?Q?Aqmqtr4ynMsAiEQAS6Z3wL+jBItmLdZx1HM+6oizzDpeuqBpplYXsClubrhV?=
 =?us-ascii?Q?2aHi2Ba94T718zIvl7sz5Q/LwNQQL3ZLoywCqoIFrmyyzN3j65n5U/bHLi/w?=
 =?us-ascii?Q?iyvlLgoh01s8mRNOUeDvn80qjXIiNAyihwP68Dvd+QpvIprKYT6eZVcE4Wj9?=
 =?us-ascii?Q?vGsqu0QIRuOm2rU2xuOGz0xEPAPPrJX/NuZX+xhd//di8lgVsniCv9pyWDZf?=
 =?us-ascii?Q?TMHysLkkFHN8evwweBgKQm4JPqOUQuUQZbydvXOwIcn2n8Wcdz5g5diWdmYp?=
 =?us-ascii?Q?S0VOuhyyCMxbFfZEHHMvJAm4V4CpoNfStrDMKTgoQ+Gll6LXScGxxjEiXvgg?=
 =?us-ascii?Q?RrsmEswHK0bH2FP7sg9ry7NvXuey506RtwINIopZ0dIVzDo+rFf0zcvf9R9m?=
 =?us-ascii?Q?2B450oMwFiHaEOvzCfU67VmLQyEh9DjNdBufeZkxh+2aGY/FkABEdEdpfEek?=
 =?us-ascii?Q?BxK1Lcm1iq6unWDgl+K4PbHSxVUHN8H3QLwBO1IAL4cG+uKPAXyd6HR7CSfZ?=
 =?us-ascii?Q?xZijiYFotOrI2ypHVX6trygT/6COPU58PYLBLVyBgKAVnZNOfhfRVCzwXAlD?=
 =?us-ascii?Q?ejy9nwbNz7W256elVUsu5RqweiJeFlcE3ZgzaKM9f7U55jJhAEQBVPMSFqvi?=
 =?us-ascii?Q?60vrbbCRiux0hUFQH9ImEr8mzPBYVmKBvrhllac4G+d57eILpFTdl2UF9xJy?=
 =?us-ascii?Q?4XNOkdlKMgrOSS7VueUlMqmL+4gjpmlFbYDf5/Ycui5m1L5cKZohTBIeqxv0?=
 =?us-ascii?Q?bDRe15FeVtTYQAAvx5ZyCy5L0vy9uxyEb4PFa9MfPtgRAgrQm6UTM+HV1LFT?=
 =?us-ascii?Q?3XK4EygUFbXqm8yDHoo91NiVegnPB6kpfWrb2zvr6p80AnJe47NhdyFVnffx?=
 =?us-ascii?Q?R6Nhs1n5tSRFwHZD9by7SAkh4HcgRBxjUeT7jOFYwBluuVFn7szZ3xrVKzt8?=
 =?us-ascii?Q?JQyraYwEbAAqcBDWagv43s7lrVwC2GXO4GCehPm7+QtXzqFTX4p+goC/ALDK?=
 =?us-ascii?Q?qZrdkGCB1qa3Mn3uv8SJfJCzEMZIJOwDO8y9OTXtvKcFoJzWBPKmyGcbizq8?=
 =?us-ascii?Q?+eqjgSPUMlNIVYZwfEuYmLOoGoegCmUUmzLe9W65?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 025745a4-3421-4e78-7593-08de0ba9b5dc
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 05:14:26.2987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ixz9Wqyo1xQAqpQWpTH0Xv7KHuEMJZosN8Ogmd1YjHR/Opy3xvfh/FgMp19r5hWC9vk7r5LZECNYS93pL1JRXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF5A636EDE4
X-OriginatorOrg: intel.com

--vGmfYNHtEf0U2onE
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline



Hello,

this report is just FYI what we observed in our tests.

from commit message, it seems to us it should only impact arm or arm64,
however, we rebuild the kernel for this commit and parent several times,
rerun tests and the issues are quite persistent while parent keeps clean.

=========================================================================================
tbox_group/testcase/rootfs/kconfig/compiler/runtime/test/torture_type:
  vm-snb-i386/rcutorture/debian-11.1-i386-20220923.cgz/i386-randconfig-2006-20250804/gcc-14/300s/cpuhotplug/srcud

a594dec7607744a8 9f0cb91767f582df6b17c1e2f22
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :200        100%         200:200   last_state.booting
           :200        100%         200:200   last_state.is_incomplete_run
           :200         90%         179:200   dmesg.BUG:kernel_hang_in_boot_stage
           :200         10%          21:200   dmesg.BUG:workqueue_lockup-pool
           :200          2%           5:200   dmesg.EIP:_raw_spin_unlock_irq
           :200          1%           2:200   dmesg.EIP:finish_task_switch
           :200          0%           1:200   dmesg.EIP:get_recent_times
           :200          2%           3:200   dmesg.EIP:lock_acquire
           :200          0%           1:200   dmesg.EIP:lock_release
           :200          0%           1:200   dmesg.EIP:preempt_schedule_irq
           :200          1%           2:200   dmesg.EIP:rcu_preempt_deferred_qs_irqrestore
           :200        100%         200:200   dmesg.boot_failures


the config used to build both commit/parent is uploaded to
https://download.01.org/0day-ci/archive/20251015/202510150626.636464df-lkp@intel.com/config-6.16.0-rc7-00008-g9f0cb91767f5
there is no CONFIG_HAVE_EXTRA_IPI_TRACEPOINTS.

though this really caused code difference between commit and parent while
compiling, we don't have enough knowledge how to connect to the issues.

another thing is most runs have dmesg.BUG:kernel_hang_in_boot_stage, which
has little hints in dmesg as below [1] which is uploaded by bot automatically
to https://download.01.org/0day-ci/archive/20251015/202510150626.636464df-lkp@intel.com/dmesg.xz
we also noticed in some runs (~10%) there are issues of
"dmesg.BUG:workqueue_lockup-pool"

though still don't see the connection, attached one dmesg FYI
dmesg-9f0cb91767-workqueue_lockup-pool.xz

below is full report.


kernel test robot noticed "BUG:kernel_hang_in_boot_stage" on:

commit: 9f0cb91767f582df6b17c1e2f22f684c36962295 ("tracing: arm: arm64: Hide trace events ipi_raise, ipi_entry and ipi_exit")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on      linus/master 0d97f2067c166eb495771fede9f7b73999c67f66]
[test failed on linux-next/master 68842969e138d9ad3e3aa2bbd65d514df1581b5c]

in testcase: rcutorture
version: 
with following parameters:

	runtime: 300s
	test: cpuhotplug
	torture_type: srcud



config: i386-randconfig-2006-20250804
compiler: gcc-14
test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 4G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202510150626.636464df-lkp@intel.com



[1]

[    0.367885][    T0] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.369051][    T0] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.370006][    T0] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.373610][    T0] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.378001][    T0] x86/fpu: Enabled xstate features 0x7, context size is 832 bytes, using 'standard' format.
BUG: kernel hang in boot stage



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20251015/202510150626.636464df-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


--vGmfYNHtEf0U2onE
Content-Type: application/x-xz
Content-Disposition: attachment;
	filename="dmesg-9f0cb91767-workqueue_lockup-pool.xz"
Content-Transfer-Encoding: base64

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
AQD9qoUfscRn+wIAAAAABFla

--vGmfYNHtEf0U2onE--
