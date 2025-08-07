Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68D42222D6;
	Thu,  7 Aug 2025 08:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754555057; cv=fail; b=fTTTbLoBCLDiQhkBkWj9sms+UNo+Ewb64h19fnauBuBNZZSy6Mb1PKYZWKYtoeoi7uyd9QMqXruD9d9xvNh98MygFa/94G5tGG56jRNVlLq45JMnkNbfSPBR0nLL56fdmixZeRhLdI9Q0MHWFvxPWoFsSJ5q/C6FZqMAABvkgTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754555057; c=relaxed/simple;
	bh=SrgjL9DIN5jSk8L025QNuHhutlJDyX3vP3cAwID7QME=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=MUazz9LGGXZxji7kb+5arC7+sEZuELvqJfhj6FpL+QSG+5+lxLMhSsdpOHJqHJIxRkrzS1Aj5VsZU+vtLk53MthpqdOELUa/tERDkyDd/disIGTw9r+KdyPqkhxBYxhzLpogeq8p3L+jNk8aqpsVzXGzaU17NuI1CAj3iKaVD54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JlPxryC7; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JlPxryC7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754555056; x=1786091056;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=SrgjL9DIN5jSk8L025QNuHhutlJDyX3vP3cAwID7QME=;
  b=JlPxryC7s6o7n+/0iV7gmlPbjkx64wAA8YPRXJti7VRMQ/p1vR/8scKE
   jZ2OsXnI3EP6ENIhZVDFnPTSpd5UP7WMQjOEgkfsuoYBG+eza1FKZH6+v
   TPTWbpu2yhs2Po8twyKRrXyLpQD8OFA/QQCJdZ30Z/1lu49a6HfiJIBCC
   pgzJtwKaazPvzmr1nMXqOEHvg0ipjdNK24vPYCBJgwuWiOzdRwAZLWRm9
   DSLXGSFMeerV/srOAWNVQODiiPuY64QNPtAN4y0e724N2cm9viz2Pvqme
   rqEMmO4amsAkjME57iuUePxLbLYnLjvjPm54VjgPj31RUjyD5HDYxOTNJ
   A==;
X-CSE-ConnectionGUID: aBJkx7SCSU6rB8XYn5WZTg==
X-CSE-MsgGUID: 30Oa0+DtTBKL/ZrofLaTxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="56962043"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="56962043"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2025 01:24:16 -0700
X-CSE-ConnectionGUID: wzET0aT7Rua7IjIfKjZiog==
X-CSE-MsgGUID: J3VGCkoFTLSicdDWiw3Sxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="164903419"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2025 01:24:15 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 7 Aug 2025 01:24:14 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 7 Aug 2025 01:24:14 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.57) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 7 Aug 2025 01:24:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qK2ASAxOJ2hC+ZMlUpCJfu2z+Apwb8jw7CpMoOO2Md+Vet6lF41wRrWI02XfqdzdDilYuE+BD/Rk2u/huxRPPEcVmSnaMWRCi5J6/VaT2V2UCXHSeCcsBGNtsIMd/4zB6ilK8vazrwMkjm9EtMQbn6v/sYZkz1AkFlsJF0Vm0TYGtJeVKFw5nK6Y0JNoEwf5jPK9XKDV6sKRl59W7CuqW1KPRju1QpTa5k41ipM01Ez6dCz4hkF5BihnbEDvzkpyH6OOpMH4Y/IsPD9n9JWPUC/pvwAhGdAXA4vSUPw9n7+2G7UjvFTRkmG7FmpX0yl483aaVDX7tOQj0/152buJpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BwtJYSe1u3o3cN7626eoChX5XkNRwQf1ZSyO8dC+O6k=;
 b=HPc1aTSdzoEWwnV/hqw7asRq+nTdSAhdhUmjLv6PUd7ULRUtdunNZPxfUXuDXXkwa4hLQq9h5P1cDZD30yMGQpFclPLyf7nQGatPfclDcPBX9phBNJl92ReS/4eEccBcHLgWAlQTi4upMPmDLaWfw3xaw21M4I1zGNb12F4Fh05HCMLTsJ3oRuQ5kRxS0Nl1C8KOvFgCdZWoRXihyUUaPDq1LkCjjtCvForhwKKB57BSODYkQAIsmI9xWRfa8cpCUy6aHWp5cBfJ1grUBXTINrCajqbVxiIic9cF1QFsbBNstfs40E65U0t4tI/k5n9DlIdRy4OPM66jYg2phLpyZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SA1PR11MB6848.namprd11.prod.outlook.com (2603:10b6:806:29c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.15; Thu, 7 Aug
 2025 08:24:06 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9009.013; Thu, 7 Aug 2025
 08:24:05 +0000
Date: Thu, 7 Aug 2025 16:23:56 +0800
From: kernel test robot <oliver.sang@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Neeraj Upadhyay
	<neeraj.upadhyay@kernel.org>, Mathieu Desnoyers
	<mathieu.desnoyers@efficios.com>, Steven Rostedt <rostedt@goodmis.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	<linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [rcu:dev.30.07.2025a] [tracing]  7f4591b8cb:
 BUG:using_smp_processor_id()in_preemptible
Message-ID: <202508071000.47c89ff-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR06CA0006.apcprd06.prod.outlook.com
 (2603:1096:4:186::19) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SA1PR11MB6848:EE_
X-MS-Office365-Filtering-Correlation-Id: c11f1307-0d97-4ea7-7d6f-08ddd58bc615
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?32oh7OgWlgxVT8D4pkiGEKNITAVO3eUHMaAFG/NgazZotIc9EmBntGpPAQLi?=
 =?us-ascii?Q?Ns+gdS04Pzagus5iSh81KWZ6UhV+gOG5wvFzUGxoCuLnDa76Rm1eNoBeGYpy?=
 =?us-ascii?Q?mkyNcz3kkkB41AhCTb8kyccEYRM7csni5mAKi2G4G2QCXNJpaMtTAaPVHQf8?=
 =?us-ascii?Q?H7pk31LKc1g8yq8Eb2TSCTyb88fhQYvkOyFBwmtS/wD7FLT5u1cgfK0NZxnO?=
 =?us-ascii?Q?lO1lgT/uiAK90Xa5/Wo1x1UM2HqCOqstk63d6ZCMp+3RY60PqkFPiHhtwtkh?=
 =?us-ascii?Q?VG0VCG9ghASxno/3kCj7CxbOn3Dz/rFHjIzNtF/qVCH6hl56b5+YeW7LEoCd?=
 =?us-ascii?Q?DjFbElrycEVqfWLaUjyqq97IS5ZSqnXoL+GfIWYRezU1AxIVgU4k7rmUu/Uo?=
 =?us-ascii?Q?1fBA1sjEz9fb0Fhh4nlUBxJw3BFznq0CaruuWlG4Ldd8BjTiCXy2f/qXNCnw?=
 =?us-ascii?Q?OFVoUUAEnqWtuJG56zPu7qwVCoU/M29xCk1CkAg7I/S4XulCDU+wgHknJV/A?=
 =?us-ascii?Q?iSHJoV15aDNWb6Oqmxx0EuhLzye/AplNk0jORS5IKuXw+NUfzt+aou3YJwcJ?=
 =?us-ascii?Q?a8uzHX74LdCmRzJD3anhlOd3yP9ar7z/Ikv6/PrKsSTT1xwpcucyOS4j0/oS?=
 =?us-ascii?Q?PONBuQL3nuquCaDyie/3ititxxVYA2RgDwvVmPYljrTfg1ho9eQO6Bx3dga8?=
 =?us-ascii?Q?u/j2OQn9F1zxFDFNV20femiWIn15ifbb2mpMT7bli7G/nX40rdUG5Uhushch?=
 =?us-ascii?Q?XN+Fr/tFqNYDTt3p9smn1kN5C9rLSO1xbteiFZOXZr3sLtntFqBp4iFWAu2J?=
 =?us-ascii?Q?TIKBu1fQaNoNLE8xrGs5Q5i3l9b1dOvtOJ6Ar0tlM7kKyOo6P9ZHRO49ISRS?=
 =?us-ascii?Q?Q4j2WU3pK2tUJ690PV2yBjwGblDsiWyjFDtURcwyIrDCyZsC/smTYybvlOTI?=
 =?us-ascii?Q?/PLv/yQWOhSt5u2PTFnBZeZ+TcjcfjYDeBY4Br4CFl6kKXaEMP51KtGsrBkM?=
 =?us-ascii?Q?j9W+Ptg9A5OX9Euqi6nRsK3GP9kPt9FPnchKOpE9iUKUpyNKhgfKdosGRtHP?=
 =?us-ascii?Q?xssvChPk1kug67XxmXwFxA9kX3w8qOiNal58qv5f1gjMFbUEzduTDSOg+UID?=
 =?us-ascii?Q?pyzgiE7DdyS7vxEpFiWnBXJXtcnCiysg4Nxr8q+Co/1zzwQJ3BeTQnWWMUZu?=
 =?us-ascii?Q?fyDa1tG1Wu03x+gC/kYJ/YikpUu0Nht0mUnzB7vOfVj2G7MA+dpDYoOOXIlM?=
 =?us-ascii?Q?fxt4alKc8NhYMVquCzJHlsUGd5ke/RFrGll3dTZNhvF6V9e3OwUvhmOdSWHx?=
 =?us-ascii?Q?z7B2aj/MFMu/0ty4Jhnq3NkQmFV1zUkh9N+j5FC6n8V/nTKd2eX0MDPTsQf1?=
 =?us-ascii?Q?39PIM1jSvaYI8SyFle8jRY8PAl5O?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mtMs9sf3ic/TEazRqpctR7C2EeI8f+mZBk7nESLGZKfBubCY3EpsB1whsgJz?=
 =?us-ascii?Q?9hoWDo3+TDu3v1fl3J/bR/XvYHQ6iAl+AsEIbhjseYUlIB1wwK0u71zrN/JL?=
 =?us-ascii?Q?8QCSUb7KamKtZStQLHB0G9CiPSn/CuHYcCc2vgux8W1gdpu2zvxUBT4TVN96?=
 =?us-ascii?Q?cec5rN33F9OFRqHPI8u5/xy2CkbyCvpouMotVEbswvmBGzbess906EvFDXQX?=
 =?us-ascii?Q?vCmv8RgyZxcIcUyws1Gc0oOqGIZEu++5KVLM+Tz5Xov18PFL/o1IKLauZXPe?=
 =?us-ascii?Q?r0zYrPerkjMmSewzDBl/QyGOowmk4r8XtfymQcty6R2bJba6wZospcCMofUu?=
 =?us-ascii?Q?wwYYfLaC81MZq18NRH6OuWvpU4kFA2E0fgYUQA0uFrtaHL81dgS4qzrM/reJ?=
 =?us-ascii?Q?pAzsjeRxxR/Ui77/9qc++ljzHy/UDeau9/K1czDFr9jdWkBpAO6pTOcPqLsk?=
 =?us-ascii?Q?3FRBIboAK80F3qKA5W2zsa13i6RTkZqhkv66foGnJtASGQlIJFjGVE9J34zN?=
 =?us-ascii?Q?8LMa2d0uNwpKw2McYRSbd38p/01/zzXROtUJl9gHxrBMcR+Z0R4FYYdBfzvD?=
 =?us-ascii?Q?85+Q0gE6c1a76pgO2cUmcQ64xM5ljcso1iFEYK773vSRThxUCHcFr1lnGCZk?=
 =?us-ascii?Q?8eWUpXKMScj4MEQn1XR0heaxF4ymd2QnkUDBDe6Yw6BJfBs2m7EdcI6f7U42?=
 =?us-ascii?Q?MM5YafItc9Jn8WbWiZJjCCIJ1IGMavMZqT6/2mR6REhmJCQeKMf5bTGB8m2U?=
 =?us-ascii?Q?3Wo+ZhPfh0Xo1FekZgj7KLCLKCS1mtT0tGhJ8bgIchrSVAPiS3C+663HnSCF?=
 =?us-ascii?Q?JjA70DDGI8N5ZvSe3d8995FxwQ9qCPaVIfGEK2DaPLQxabgFOjjcSRuYeidF?=
 =?us-ascii?Q?beAfPgMQxEUYdaHjNyNkf28KLmPDKYA9Wc12Oid4/qB1xUA1cdo4L4Lt7jxQ?=
 =?us-ascii?Q?AjT2t/iLnjQTqINtRhjJCI0684hMzh5X2To4gdMk4JmZS0tflwPZg7eoAyuF?=
 =?us-ascii?Q?vwmE00MOfS+AJlJ8WeGZNS/y9SRkfpKeJGmw1gRYVeKcmVbjiVZ5lSKd16di?=
 =?us-ascii?Q?wlEixjg7dHhrAROZ7azFEPhOEnVrC5TFWrojLD2HKBIXyz8Vot52miPRgniN?=
 =?us-ascii?Q?XANRh6Tnj908zg+QPXWSeiGgiXGw0FVGDTM0J5B7M7vDPPPUEi1zDrTrJYd2?=
 =?us-ascii?Q?v4gALXkWbWPq1WZUjGowIvZIa329QEst2Ns0WvYHC2WaH68A+pU1gPXuqjXc?=
 =?us-ascii?Q?vsnZfLlNaToHorXQmZyXzaQrgcdj654Xoy3R726iFk/I2Mm3mFSlSB9f+lfx?=
 =?us-ascii?Q?eHPJDVwy21lIvh9p43p7lHJsVVDGghvU94v6vhcLEL0wn5wYeBmfQ2WzIrCT?=
 =?us-ascii?Q?fFiY1CC26ZteILiBNqUQGac8REaeI8XxQU28IyWICtCnKrmnNQZeDeStZ3qR?=
 =?us-ascii?Q?oFLDv+D9hZQTBlNLzMrP/PaNXYvRDl61MfOhVPFDmXWVekZ8hySmn5qF0jHS?=
 =?us-ascii?Q?lQ1lSoOc8wntrThu0qxacQr5UkW5+ryJYRydr0Vg05Tk2VWwgAyXst7W9puI?=
 =?us-ascii?Q?yUscIjXyn2tXRjMbEewaxIR7iQm1WNnbWayQj+T+UqOYcrjcptEkwd2F6LxB?=
 =?us-ascii?Q?sQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c11f1307-0d97-4ea7-7d6f-08ddd58bc615
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 08:24:05.8622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZjV/u5q6fvn4accdOZ+JEIwi8eqxd3WupbA5ak1Rjhp61vaSkoJdUzmfX5l0W6RyOZaVNLnD1EMKW7DnYsZ3pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6848
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "BUG:using_smp_processor_id()in_preemptible" on:

commit: 7f4591b8cb9c4682dd20ce624bb090e2a634cf9b ("tracing: Guard __DECLARE_TRACE() use of __DO_TRACE_CALL() with SRCU-fast")
https://git.kernel.org/cgit/linux/kernel/git/rcu/linux.git dev.30.07.2025a

in testcase: trinity
version: trinity-i386-abe9de86-1_20230429
with following parameters:

	runtime: 300s
	group: group-00
	nr_groups: 5



config: i386-randconfig-002-20250801
compiler: clang-20
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+--------------------------------------------+------------+------------+
|                                            | 97b572666e | 7f4591b8cb |
+--------------------------------------------+------------+------------+
| BUG:using_smp_processor_id()in_preemptible | 0          | 12         |
+--------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202508071000.47c89ff-lkp@intel.com


[   32.787484][ T3676] BUG: using smp_processor_id() in preemptible [00000000] code: meminfo/3676
[ 32.788206][ T3676] caller is debug_smp_processor_id (lib/smp_processor_id.c:60) 
[   32.788627][ T3676] CPU: 0 UID: 0 PID: 3676 Comm: meminfo Not tainted 6.16.0-rc3-00057-g7f4591b8cb9c #1 PREEMPT(lazy)
[   32.788631][ T3676] Call Trace:
[ 32.788633][ T3676] __dump_stack (lib/dump_stack.c:95) 
[ 32.788638][ T3676] dump_stack_lvl (lib/dump_stack.c:123) 
[ 32.788644][ T3676] dump_stack (lib/dump_stack.c:129) 
[ 32.788647][ T3676] check_preemption_disabled (lib/smp_processor_id.c:?) 
[ 32.788654][ T3676] debug_smp_processor_id (lib/smp_processor_id.c:60) 
[ 32.788657][ T3676] perf_trace_sched_prepare_exec (include/trace/events/sched.h:458) 
[ 32.788672][ T3676] begin_new_exec (include/linux/srcutree.h:300 include/linux/srcu.h:419 include/linux/srcu.h:519 include/trace/events/sched.h:458 include/trace/events/sched.h:458 fs/exec.c:1110) 
[ 32.788682][ T3676] load_elf_binary (fs/binfmt_elf.c:?) 
[ 32.788693][ T3676] ? __this_cpu_preempt_check (lib/smp_processor_id.c:67) 
[ 32.788698][ T3676] ? bprm_execve (fs/exec.c:1665 fs/exec.c:1697 fs/exec.c:1749) 
[ 32.788707][ T3676] bprm_execve (fs/exec.c:1665 fs/exec.c:1697 fs/exec.c:1749) 
[ 32.788719][ T3676] do_execveat_common (fs/exec.c:?) 
[ 32.788724][ T3676] __ia32_sys_execve (fs/exec.c:1929 fs/exec.c:2005 fs/exec.c:2000 fs/exec.c:2000) 
[ 32.788731][ T3676] ia32_sys_call (kbuild/obj/consumer/i386-randconfig-002-20250801/./arch/x86/include/generated/asm/syscalls_32.h:?) 
[ 32.788735][ T3676] __do_fast_syscall_32 (arch/x86/entry/syscall_32.c:?) 
[ 32.788740][ T3676] ? __lock_acquire (kernel/locking/lockdep.c:4677) 
[ 32.788745][ T3676] ? __lock_acquire (kernel/locking/lockdep.c:4677) 
[ 32.788763][ T3676] ? get_page_from_freelist (mm/page_alloc.c:1714 mm/page_alloc.c:3669) 
[ 32.788766][ T3676] ? __this_cpu_preempt_check (lib/smp_processor_id.c:67) 
[ 32.788773][ T3676] ? lock_acquire (kernel/locking/lockdep.c:5871) 
[ 32.788779][ T3676] ? local_lock_release (include/linux/local_lock_internal.h:54) 
[ 32.788786][ T3676] ? __this_cpu_preempt_check (lib/smp_processor_id.c:67) 
[ 32.788790][ T3676] ? local_lock_release (include/linux/local_lock_internal.h:54) 
[ 32.788800][ T3676] ? __this_cpu_preempt_check (lib/smp_processor_id.c:67) 
[ 32.788805][ T3676] ? rcu_lock_acquire (include/linux/rcupdate.h:340) 
[ 32.788814][ T3676] ? handle_mm_fault (include/linux/rcupdate.h:? include/linux/pgtable.h:136 mm/memory.c:3670 mm/memory.c:4030 mm/memory.c:6105 mm/memory.c:6232 mm/memory.c:6401) 
[ 32.788827][ T3676] ? __this_cpu_preempt_check (lib/smp_processor_id.c:67) 
[ 32.788830][ T3676] ? preempt_count_add (include/linux/ftrace.h:1091 kernel/sched/core.c:5852 kernel/sched/core.c:5877) 
[ 32.788837][ T3676] ? irqentry_exit (kernel/entry/common.c:320) 
[ 32.788840][ T3676] ? __this_cpu_preempt_check (lib/smp_processor_id.c:67) 
[ 32.788843][ T3676] ? lockdep_hardirqs_on (kernel/locking/lockdep.c:4475) 
[ 32.788849][ T3676] ? irqentry_exit_to_user_mode (kernel/entry/common.c:187) 
[ 32.788856][ T3676] do_fast_syscall_32 (arch/x86/entry/syscall_32.c:331) 
[ 32.788860][ T3676] do_SYSENTER_32 (arch/x86/entry/syscall_32.c:369) 
[ 32.788862][ T3676] entry_SYSENTER_32 (arch/x86/entry/entry_32.S:836) 
[   32.788865][ T3676] EIP: 0xb7f4c539
[ 32.788868][ T3676] Code: 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
All code
========
   0:	03 74 b4 01          	add    0x1(%rsp,%rsi,4),%esi
   4:	10 07                	adc    %al,(%rdi)
   6:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
   a:	10 08                	adc    %cl,(%rax)
   c:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
	...
  20:*	00 51 52             	add    %dl,0x52(%rcx)		<-- trapping instruction
  23:	55                   	push   %rbp
  24:	89 e5                	mov    %esp,%ebp
  26:	0f 34                	sysenter
  28:	cd 80                	int    $0x80
  2a:	5d                   	pop    %rbp
  2b:	5a                   	pop    %rdx
  2c:	59                   	pop    %rcx
  2d:	c3                   	ret
  2e:	90                   	nop
  2f:	90                   	nop
  30:	90                   	nop
  31:	90                   	nop
  32:	90                   	nop
  33:	90                   	nop
  34:	90                   	nop
  35:	90                   	nop
  36:	90                   	nop
  37:	90                   	nop
  38:	90                   	nop
  39:	90                   	nop
  3a:	90                   	nop
  3b:	90                   	nop
  3c:	90                   	nop
  3d:	90                   	nop
  3e:	90                   	nop
  3f:	90                   	nop

Code starting with the faulting instruction
===========================================
   0:	5d                   	pop    %rbp
   1:	5a                   	pop    %rdx
   2:	59                   	pop    %rcx
   3:	c3                   	ret
   4:	90                   	nop
   5:	90                   	nop
   6:	90                   	nop
   7:	90                   	nop
   8:	90                   	nop
   9:	90                   	nop
   a:	90                   	nop
   b:	90                   	nop
   c:	90                   	nop
   d:	90                   	nop
   e:	90                   	nop
   f:	90                   	nop
  10:	90                   	nop
  11:	90                   	nop
  12:	90                   	nop
  13:	90                   	nop
  14:	90                   	nop
  15:	90                   	nop
[   32.788871][ T3676] EAX: ffffffda EBX: 01e25d34 ECX: 01e25c00 EDX: 01e25c0c
[   32.788873][ T3676] ESI: 01e25d34 EDI: 01e25c00 EBP: bffe5404 ESP: bffe52d8
[   32.788874][ T3676] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000296


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250807/202508071000.47c89ff-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

