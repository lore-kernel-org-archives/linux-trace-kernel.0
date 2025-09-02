Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE8B30FC33;
	Tue,  2 Sep 2025 15:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756825809; cv=fail; b=ZFVoylEcK6W6FrwBIpXQhwItbIY/IdQ2AWPI9LXMN0INTP3NLq2ssv6nCxv9UC5Vp2tBpGT4vPmgdqbrEopf7mEhppWZfGVJDI4Y6Y7v5PVN72j7znxZbtRW8DYN/0E12vhj8fMKnwTcgAMT9oICB0+/PPyruKfhRxMJP/ltbDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756825809; c=relaxed/simple;
	bh=1iN3CjM/AUAVnR82in2b6VrY7uZYDaz4blD5mzyYt1M=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IUmOrZiINxbJ5PkmyXtn0UmdbLp7wGcj6nyS/1ku5L2DWOD3HDHfCAam7IW5bizdwOkTe3tvxf8lhdiV59jBZidKxhwfX0AMosdqwXH6enlG4bPlNTOfuvhQp7LixHsM0On7lxmBWTR0lzU1Kyblpev1+lfCvITLAY8A5isNlzM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gt2RkMhD; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gt2RkMhD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756825808; x=1788361808;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=1iN3CjM/AUAVnR82in2b6VrY7uZYDaz4blD5mzyYt1M=;
  b=gt2RkMhDghHqxsJmCDYIse9bDVuk34wzI8WniEAdhHygg+IpAAkqUvWJ
   Z/76aLeh3z/AUlrWIoKLF0fJwPNStQbiKHsv3ZJtMp2DCy2fVrDK7G11D
   dGKG/82/UdGmDOEMeiNa1wFjZtwrq7lREa4zQw19GE9M7xvIyYR842qpC
   TfcOsO9KnbOm/1RK7rMyDNmMe0aI1Z51+eB03nNQoIXx4A/C76mcb1dG+
   /vN7VYMnjs4PSxHUm8wBd0syW8TLU1U2CRHDkmZt8Ys+qUg8Cd5MT/u2R
   DbP+iiNrfNAZ84COArDsb1M58XICl59VXq22AthuubD+AIPF3X/lYfm+j
   A==;
X-CSE-ConnectionGUID: fqhNIhZUTNiLlLSkLVfCwg==
X-CSE-MsgGUID: j7vV2HcRT0WVK79QKU1VCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11541"; a="59242084"
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="59242084"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 08:10:08 -0700
X-CSE-ConnectionGUID: eOMt6dI1TJ+G+Lg8k7E7hA==
X-CSE-MsgGUID: YsiXQjvUShaoBmHvbQmK5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="170596386"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 08:10:07 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 2 Sep 2025 08:10:06 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 2 Sep 2025 08:10:06 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.79)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 2 Sep 2025 08:10:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nKNSziI7fBFPL3RHUX2KDt1gi4Ou9VKAiOyJmmaWIM5kubzGwe+18aAfUgbHWplqppPt0+GM94kLFPSk0bQfygsoLOYbGeRAMMDGD20o/6bW+mBC15djbscVDN71ziYnyyj8JDZCTj4msBHQjrktW+nd8JvQY5AhH7spMjDC1FK+GpyqhZJ1kjMr6+SMcFHifdq+qli0BawhQm+jad6DRP89OOCLZHWnSxkpaTGxbFystIzqwjR8mZ2Z+GG+tuCXBvp/mNDs2OIW7RChn8iU3ZGXUoKG6o3NCYmcNl1WKhDdUXb6GQUaUuxOwdwGnMVFA74Dr20Uw15398gyAy246Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QSb1TRHtnLzKntulHJBm6Vm2/mRWvi0bR2Fj82X/Ois=;
 b=W6gl+h4KvYT/x33hT9QRmNV61SS1ubQGxyk1pScCKB2qJdNckk5V16P/4facRT5dR4W/ykNqtxQtgnftw0tpeYU8CW7E56s6VHL2r9KG3GmcVCwbK6nQxNhMbnRXBpbXdwAn2wtDMPjF/TILag+g4CbStLWaBDi32nahI4Mu+g4vTKpcrXxFXmCG7gBIShQoNEaC8tSCHLzwwvMWRvgmsB07t8c4AqvcnlJPAb4/we3OB+71xJA7bJFfb0wohALArkTeE2On0J4ZE9BVAFgi9qV9ZbBVtlLNkq3k/XX+JCcqUiRVcbzJxuQekTIUH3Z9rVZMm13lcmlVCgN21xD8rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by IA1PR11MB6537.namprd11.prod.outlook.com (2603:10b6:208:3a3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Tue, 2 Sep
 2025 15:10:03 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 15:10:03 +0000
Date: Tue, 2 Sep 2025 23:09:53 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Pu Lehui <pulehui@huaweicloud.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, <rostedt@goodmis.org>,
	<mhiramat@kernel.org>, <mathieu.desnoyers@efficios.com>,
	<pulehui@huawei.com>, <oliver.sang@intel.com>
Subject: Re: [PATCH] tracing: Fix missing errno when zero parser->idx in
 trace_pid_write
Message-ID: <202509022339.ae20a8bb-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250821071721.3609109-1-pulehui@huaweicloud.com>
X-ClientProxiedBy: SI2PR02CA0007.apcprd02.prod.outlook.com
 (2603:1096:4:194::23) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|IA1PR11MB6537:EE_
X-MS-Office365-Filtering-Correlation-Id: 66e2761e-7522-4d95-cce2-08ddea32cb3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?389XPl2fyWL/01vA5WdZHr6O+5Sq7QEUWT8TC8EIUSYpD1e2ETbypICcAQrN?=
 =?us-ascii?Q?IaXBQRmWJIXPFT+zA2aVmIep9o8hwc33B+G/zalvrmH5l5osgQWkbvkH41J8?=
 =?us-ascii?Q?bR6euwYr1K/oAXFoHtJ/gOh1r2Q0k5Algt8/3ERpfjPvbaZv5WIDZyhJZEUP?=
 =?us-ascii?Q?nIIR1C9E810Ty6K9+7zppp2raKksPNM5ItrcfSq03Rc4zckEPk2hMoAR1AlI?=
 =?us-ascii?Q?7059Q0+1DbIt2BKUrOwP/U3rpuopL4aGSP0C4sDJ618JF3vUb4KGpl2R76Id?=
 =?us-ascii?Q?AB71vyUvTK3nDPuoHInMivj/CB51VVTqMNx61GpnC2J3EHMOtP3dWnN97+b3?=
 =?us-ascii?Q?tbykUVYniEeDBT3V2yIpJ/f+d1qfwmJZyMV4DuFyB52/bVhdmtK45hxAryCj?=
 =?us-ascii?Q?hDXbzQbJJYrbwb7JS93UM3Zj43tu0WNgeKHQo5xzo45yc6kEacB7KncNmN1h?=
 =?us-ascii?Q?1/NSObbnKq5UFkNF7yKS0fSeYHa42nsN7OY1Gsa6VMHfM4GYI7+1NwNN2bSf?=
 =?us-ascii?Q?pqtQPO9DtNenFlHIl8pMMfOljn2EtfrydwuGTnd3oMHzCtYsMbhuugPAcSoq?=
 =?us-ascii?Q?TCMEW7f5W9aPs386s8cATzqRyqXqQZSCeBV1tPXl0luo/1IVbSAtaXZ/WUjI?=
 =?us-ascii?Q?Ok4waUuD2O0Cl68Tb9h+UG0EYasCIOeuOc5FnIhltahSkdi2mPE5blaDBug0?=
 =?us-ascii?Q?90ulNV9bL3jle9XqM/nJJS/WfF+P4bpkIUEoizVwkF//EpQqLgau34oq8MN3?=
 =?us-ascii?Q?GdC1HRezrdxURjsy9qhUFYVljfu816o+k50rBraOpLJJq1nn65ESXt1RHGxG?=
 =?us-ascii?Q?EIO2mtIubosyNZSarEbRU4ZZWtu/LU+RVPgblJuI3xIsvIA7s+3Pe4iudkCN?=
 =?us-ascii?Q?8Epbsu6QMVGid6W9ljtYSEQ97AK1xSlm7EDoJ0gxcIJq6VCVZogKm9rEZqQ6?=
 =?us-ascii?Q?fHRM2bjJCF2xM+33VHTtz5QThcdmeioX8nvpFVJym0djyIg6ajFM70zh+m0d?=
 =?us-ascii?Q?pecENlXSXaV/XaVz8oExqFFKZ2vIWrGgOYC0vYIwo/Rtx78pjxauw/q1QM2+?=
 =?us-ascii?Q?J+qWeTHcY6wUBIIj23ejJOm1Q348Uzh9faUbod6q7cjzDhuIvleVK7L53lU/?=
 =?us-ascii?Q?hjS43i8hBEAI0os9aR4txN2v391/VFc7TtjlLYX30cUMpiJC22jFEd47Zq5q?=
 =?us-ascii?Q?E7U6UczutMrFs31dWaGWmBXuFyepOTC3IjsJd2gTx3EXmZO9+7HAP+3uxZTW?=
 =?us-ascii?Q?lxEd4pbri41dlQvBXe01iJ62SFaTMOfNp2RM2g2JGPgnEVyRwonOR5cEQcX6?=
 =?us-ascii?Q?J1h7B3064NNq5wNGdt3s8UtuSVaqEiQe9KgP1pBtq0g2sEpJBN2s+u4Wnktz?=
 =?us-ascii?Q?zhC4kMD2bAI4eBmdKTgzRHw8xrkw?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YQ8h3irFYBRKxDhcKBkiLyKx9Jmmdk8MtNg2xFz/koXoUzms+EUmoJIHp89S?=
 =?us-ascii?Q?oEObORnWzzMEG5WtcOduogInj/pxd9R1f7KbnmEWXqESytj6Fm19mTAls/my?=
 =?us-ascii?Q?Hbm0yoTXXW+r29YP0uwmQk+5ExIKI8iMI6VmaeNz5/D0f2oKAilFRxjFJBdh?=
 =?us-ascii?Q?44Ekrygm4fbOJ12wMFwOWAMPEjSX+FIJPbLyqiuZjzapTvJuDKnjjg7gaf6S?=
 =?us-ascii?Q?luWar4fgTAM1mozM7Dqf5F1XQq8nNuCnVy0texr/pjikgAYeYwX+r4xk0z6O?=
 =?us-ascii?Q?i6hBBb2ByA4tbb8U0gi29l/l18d/gPHNLgDHfAM8zAdDxV/nyGk4Zxw+K/bX?=
 =?us-ascii?Q?54wN2yTvf8+Zxy0LAvdDce4xd7hVjdCxPIv3PQA8ny6hZ+Jm/+otfILbIwui?=
 =?us-ascii?Q?WrMahrIdTKRgYGQbflGFJCwjfyWc/Gx3RVQoqGbpxC5m25nkhnetSO3TYKwT?=
 =?us-ascii?Q?zpyJoZazLCWQKNvgw2MhVQ9xDrjVXdLxvFDNd/XG86zLoyD0tNndkxK/M51r?=
 =?us-ascii?Q?v7QwhyIqo9kAlqeKk0QX5F0LhX/b86I4sO/1kQJXVK1t7Lkapveti6muRsMI?=
 =?us-ascii?Q?W2Ncufnz0Nr86tZ/OGWF/V/Q4syobEtti0RzPGK+9yiCcOr1LN4KmQP8Phbs?=
 =?us-ascii?Q?85dopNPxNKMuzcCuTb/EF1vftYDRS+zhZ1xsUyYpalaa5JPwdenugXGvnr4U?=
 =?us-ascii?Q?EgpjofKBKFlO06nXCk5CuTQ7W32f0/sDxPLrSpqYkTDiD7vNblypCjUUdYvD?=
 =?us-ascii?Q?JghB0v3RYYyx1OMtw3yQ/zpsZWkqZ2HH6ebQxyeFnvQnWBmEQJaknrYtXiUp?=
 =?us-ascii?Q?cdOhRR0nbUw1MIkdJlss38T4JMEmAC8h3V4RnHETBXokCV+7sK9ksOEO2AwX?=
 =?us-ascii?Q?vOy3sTh37rfmwE1fRwiWvNMOrH1K20fi1u41sS6L+2S1+xl7gvVg7Lr5ychW?=
 =?us-ascii?Q?+wtH9RV0CgTxxjd0USmikbZaNDA7zke9W2/1Jqbusz8LpjX7jB5VMN0VR1Vm?=
 =?us-ascii?Q?dFkG6yxsn3ceWUm21udb06BB0R7bCOWcebEMF3XImWFEqzRVf7SNEYdwWmEB?=
 =?us-ascii?Q?BSWdEgyL+vYzZUbLsHosqoZvxD1MNlmqNWZTI8oAcc9lya6sKrDvnm0ABg4m?=
 =?us-ascii?Q?wVP9Tiwm4a2cg5VXsY0kVSt4k8X0B1iAYBBvnNMqi/a7EMpXAqdJzc6Zck3s?=
 =?us-ascii?Q?Merqh8ePPf2C80dHv4jOwVHcB2rYcuVF/uNvDUioCEdsx1jKsKyG+CSAmRDX?=
 =?us-ascii?Q?1EzXu0oUrfzibq5JOoBiJS6q6gN/5D5MdG5JDAvklEiK2gkdf8xfvDhONqy0?=
 =?us-ascii?Q?NqQYOda9xfl3LJK+wXFi1dRPODiemuz0m812ACx4pIyuUYSfnAEMtjU58YVJ?=
 =?us-ascii?Q?7tc8Xs5yGub5TW1/bMcnIbCRsPoWL1mmZY8+ekYVcAHvm49n+GSV6mCSWsaO?=
 =?us-ascii?Q?2Vln49qyH0Pgeuux7MD5aiffeZsFxhpgRYb/aiqDzZAKO9m+GaTV4Jdi8DI6?=
 =?us-ascii?Q?82V4MmX/GqLM30a3an9/0qgmnG8VvtXJydWZBLhbi0WQMq82SfzI4N3BBzpx?=
 =?us-ascii?Q?q9Pz+PMPORQxVg+ku+AqKP+zM0bZZzxk4V5M8dD/JWmHdZc31ZfOBarutgtB?=
 =?us-ascii?Q?5Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 66e2761e-7522-4d95-cce2-08ddea32cb3c
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 15:10:03.7199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9bwy5p7lZnpdng4qqsVsqUbzRvpY9iTGblk/6UE8Yu+nqOUImL6sPX0c3f9dOMH4b+qwOkXJQ0wt6xxMlRAZNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6537
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "perf-sanity-tests.perf_ftrace_tests.fail" on:

commit: cebdd2c9a622becc41349f32ace1795d750beda8 ("[PATCH] tracing: Fix missing errno when zero parser->idx in trace_pid_write")
url: https://github.com/intel-lab-lkp/linux/commits/Pu-Lehui/tracing-Fix-missing-errno-when-zero-parser-idx-in-trace_pid_write/20250821-151736
base: https://git.kernel.org/cgit/linux/kernel/git/trace/linux-trace for-next
patch link: https://lore.kernel.org/all/20250821071721.3609109-1-pulehui@huaweicloud.com/
patch subject: [PATCH] tracing: Fix missing errno when zero parser->idx in trace_pid_write

in testcase: perf-sanity-tests
version: 
with following parameters:

	perf_compiler: gcc
	group: group-01


config: x86_64-rhel-9.4-bpf
compiler: gcc-12
test machine: 20 threads 1 sockets (Commet Lake) with 16G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202509022339.ae20a8bb-lkp@intel.com


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250902/202509022339.ae20a8bb-lkp@intel.com


2025-08-31 21:12:04 sudo /usr/src/linux-perf-x86_64-rhel-9.4-bpf-cebdd2c9a622becc41349f32ace1795d750beda8/tools/perf/perf test 83 -v
 83: perf ftrace tests                                               : Running (1 active)
--- start ---
test child forked, pid 10325
perf ftrace list test
syscalls for sleep:
__ia32_sys_nanosleep
__x64_sys_nanosleep
__x64_sys_clock_nanosleep
__ia32_sys_clock_nanosleep
perf ftrace list test  [Success]
perf ftrace trace test
failed to reset ftrace
---- end(-1) ----
 83: perf ftrace tests                                               : FAILED!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

