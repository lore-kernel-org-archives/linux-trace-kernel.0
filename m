Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDD12512EA;
	Thu, 17 Apr 2025 14:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744901245; cv=fail; b=EDmoCdg9poFtyPz0zgWlBPEtV5rISvEA9UhBqGAEoYErBAt5Ct3R62StzmML2k7A29npTllGpnPrbhzBSvNvKJus7JbKl5QISCbBmxDnyytGTeSh0hLrliIkhU3N2iZWmFYgY88aIP4ms0+4la9Db7p/9ahQa2emlmCl+1W1Osc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744901245; c=relaxed/simple;
	bh=/u6eUanw/SLgT14ssP9XuslMP5K6y8FDLfYORCi1MQA=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=LpuqZeB79KHqThy1A4Q+Akxiboww+9h1E82X/414htwwhZ8Lrb/3dMQrVPdjgQRf186vf3hZeMtX7aECstV8MxfcSd4wPKvsXaklU9NnoAxkflir9qAIXRq/hKPpvqs8FY8PoANYg5FqlCZR5pR0SXTSmZsewiPgo5e+QO8+B2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g/rYMOHu; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g/rYMOHu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744901243; x=1776437243;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/u6eUanw/SLgT14ssP9XuslMP5K6y8FDLfYORCi1MQA=;
  b=g/rYMOHuwtnfD8Y+8V60fxsv5bdXBBFgbrKAQbYdb7cqepPG7k2iFurC
   I9QESpkgaMNJcydQDTz6sbo7dRC7TXhLxz6gogDDDHWtd+OpqQq1SqC0+
   UIrefkBy36uqAbU+uHy4KdhtaE2RKBFiXBSMT25N48zWwnKJRRvGBBjb4
   uRRq910RA3iHPJjbGo4D66sDf/cG+tsTkB8Sy7DN1/zBG/odmFVu+hlfQ
   erxzGm3cQxmtjO7cRQd10q8t6tBH9yE9tDNFRnXGxXHIMQFzjDGhS2zZz
   +88TIQQfzHhghWdW7nbukBkKaYBe2847Id2QfQy2a65NDRgXiXe6+zFTg
   A==;
X-CSE-ConnectionGUID: 1AI47b6iTzSJ/d5rw1PQUA==
X-CSE-MsgGUID: NgOQ/1O6TS2T/7Ll2ap12w==
X-IronPort-AV: E=McAfee;i="6700,10204,11406"; a="50315122"
X-IronPort-AV: E=Sophos;i="6.15,219,1739865600"; 
   d="scan'208";a="50315122"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 07:47:20 -0700
X-CSE-ConnectionGUID: JOQQ+KtkToqLOzUC0OU9Kw==
X-CSE-MsgGUID: KPWbUoErTGSbLoms7irZPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,219,1739865600"; 
   d="scan'208";a="161871679"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 07:47:16 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 17 Apr 2025 07:47:14 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 17 Apr 2025 07:47:14 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.48) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 17 Apr 2025 07:47:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kLMLBkrQ5hA8nu0peuJdI5UtKrWlubhfKBZelViQH8cdnfCVqmxVWy4EhJajzcDsh1KNSLPBBxp4pFsi9IYQBrl6onwKwu4WCPN5beLvMaqVQYaHhVt8tdD9LseXR4rE6Ypce+RQdMyUMrEkYR9aDq6kqqjDVrAtxTYtakUz2smbM6co79b9MIfdOMffsO2Y3dSVfwFHWcydpMI0rdziDVG4NG7162ZE9ABy6tDtYn38m6a2MZl/0nBLxDF4fSYdwpUt5yt4tt3Y/jarT85/lbCJt74zTsfLufGbWMcNAiqo585cspyGPGMm0hlWtCIzlM71lkwXNLpYA/DNXu1A9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LKB6H2tdELB5VfstZVt8NIoFtBHvBWSuosTzRXKdF2Q=;
 b=Uin3uUwHD2pylolPnWxOZ3b9XHtQ2/+R81MUa+MgHiaaVgTmxNDuBKv7JMMXi1x/s7Q0pDeiKAGtfXZ/b3F8bueEgsSLLrh3QeWXUcgU3oW3zSiNice3/BMf96nR71fBnjYZrkA8Z/SrCP1bHCE3Wg7U0EncD5cKTAcxnuyiug/H3By/qn/Wx5QZYS3ZKT0ZEOQCmBWnmIfbiIaBeMv54Px/piEKsSZ8OExnrlj0Q2OwDgNAVot3GuoW4tL99OBpxRgLANfILbSaJWPJEmksIWF3rtDqniIStKOL9SKJ41RdUFnjUH6o7x1QfH7hQJgWVDb0QW1CX3LtkibDD7zgOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DM6PR11MB4740.namprd11.prod.outlook.com (2603:10b6:5:2ad::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Thu, 17 Apr
 2025 14:47:09 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%4]) with mapi id 15.20.8632.035; Thu, 17 Apr 2025
 14:47:09 +0000
Date: Thu, 17 Apr 2025 22:46:58 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Steven Rostedt <rostedt@goodmis.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
	<akpm@linux-foundation.org>, Shuah Khan <skhan@linuxfoundation.org>, "Andy
 Chiu" <andybnac@gmail.com>, <linux-trace-kernel@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linus:master] [ftrace]  0ae6b8ce20:
 UBSAN:shift-out-of-bounds_in_kernel/trace/ftrace.c
Message-ID: <202504172247.26db367d-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR06CA0242.apcprd06.prod.outlook.com
 (2603:1096:4:ac::26) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DM6PR11MB4740:EE_
X-MS-Office365-Filtering-Correlation-Id: afd4f394-840a-4923-a326-08dd7dbebaf5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TrGWHekXaJDiZcC2cI+sVV4gmE7ZTC2LyAY98DnuODIiizznWWchomCyoAvu?=
 =?us-ascii?Q?e0SxDXGrZPrJvO1cXr6LIf3CrgYKIc5uqCFT9qgzAA4alskxL9UgyYbMkicI?=
 =?us-ascii?Q?39JTRz+yJUf29L6gVt8wOZSXhiEYY3coOPTjdlu4Gbh7HBmw32s0yX3LJI+K?=
 =?us-ascii?Q?1wCbdJcGXyEWFF2uH1AjLzdCbcpUj9jTf045Y7p0mEKUg5PjtIFI9HyTpjgO?=
 =?us-ascii?Q?2gKOXbLqt90dzvy10xKKJgC4dadAEHJBPbazMGQodCEEOsTJPqaUc/tW7XXT?=
 =?us-ascii?Q?Jxj5IepoP6WtkHKtbGeRL5itCwvcVDJs8FjALccN1hfhdLwYg+OSeM9sEglK?=
 =?us-ascii?Q?bcW8XUy5gwZX04yiYaQYJ3NOcMBr+WWKGOVpp0Ivb8/wVz7hPTncDMryXm1r?=
 =?us-ascii?Q?pq0eK8MnzZRg0WZWbC3bkD73xwVRtKSPxFRalCSCqY0o4BYIM8PLt0bxqavu?=
 =?us-ascii?Q?WIPOxNGyZkFXXbrncn7GNhZi7icTkAHjWKvQE1fHHz5wnkZnmKiuY3yADvqu?=
 =?us-ascii?Q?MGxpN/o37CoCqQtHXlHS7cuoQt7xm4zTKwK1DfG4T2YHEBMtTf1H3sfmz/I9?=
 =?us-ascii?Q?No+tHxfSQfZzluN3jK0EgouOAlHLzSswDopUIJBMGayEZdVFCpTzX2R6xMgi?=
 =?us-ascii?Q?CMW6fApzjxPgKAO+Euf8qYNDffekyn94GfBENhkRXqCWOWyhwxfUWXgtRk1v?=
 =?us-ascii?Q?oP4F9oG9b/UQKAimO5xJLMtGFu9Pb7rtXWpveg/S5sK5KMJeTdLfY5q1rsM5?=
 =?us-ascii?Q?G4RveC9yBY106fF//3lT/kRtjT2q4pFfa3n478QHBFDQjuTuM/yjmYuvv1yI?=
 =?us-ascii?Q?76WPsm8nn2sWKnaB6HF27DYA380q2Vfx2Zz9+VRxudPT/Esm/8u6UfTcdDIf?=
 =?us-ascii?Q?DiZs/aagwPC1VvF5h6d1NeIVQxJXUu4RBHFDpw2c+bKZz1G1KbQBhkRflBB5?=
 =?us-ascii?Q?KxsXVCnHP4uetGFx/Ij/9bVSHogSWgDMsS5EE1UyJ8/Q5vTskWnKicUqBs5p?=
 =?us-ascii?Q?RRrxbXtZ5KcSM9OLI7ktgjJfHiS4I3eUHbwNxcsOLUXyFaxMcum1XoMNpj3e?=
 =?us-ascii?Q?9sBhaVdRJ+iSDEoLU6L8k45NNVNY8J5YVjU+xmI9TqgInQP6xMDnWDn8Omq7?=
 =?us-ascii?Q?LRpROfFklhebK+NpC3ZOkuWWgmLo+fWWl0QheQkOOPUIwx9Fr1ONR8K0YX22?=
 =?us-ascii?Q?MX9rXjiXveBGhlLF2dkv+ELzUHH/NyIaXgffR8Vb7WHnEJFsvNPynZr3MuqF?=
 =?us-ascii?Q?bcjSEN4VTLK5CX0mAdkREIsZ7DN8mfV7C5eKlUi1YTAt4ZRBRQzAbE/vc3Yg?=
 =?us-ascii?Q?xCS0shMx0YJ+HTLZhwmkAHmD6jVUuXmJArq11EvEXPnw0Hb1aPz3nzXlhX2Q?=
 =?us-ascii?Q?RtDj2V0orD+Q7XICSjfm7lZnDFYq?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7Gb3kralwWPD+OQtxllOQ1JITQvm63nGbEIwEcIlBSsSjxbt/JcuvHyBGoo2?=
 =?us-ascii?Q?5KRekAxrJMWFHkawMRHc+ABoR87E7keAcfROQObjDgCzWIWE9h7Rx6ypuJwR?=
 =?us-ascii?Q?vUu4g6OcInz2T+Skk0PXzerhXcK5W6vsyoI5argzd+tWiexI3zPuaMWQhqWC?=
 =?us-ascii?Q?m6JvvTpmfvh74nqTVQTscaTSXcN9L9TPRQCs/uPLUFn+zgdzdAYrk1Z19EJC?=
 =?us-ascii?Q?l7EiEXwj9SZAjs8E9GTAMYvoCBe/7iXwI76KEDAiOE3eIFTQ1ZgJdBfolIZN?=
 =?us-ascii?Q?PHDKudh+7xNJpVQ9hVe7J5ZV4q4PNGXZQzcnF9wFTR0XBQdsTy4D/yI4Slx7?=
 =?us-ascii?Q?++9QP17u5ficJVE+wUtYkS1yD3/YvhH2A9c2klRC+kVGCSCGmAmKtw/pTtj2?=
 =?us-ascii?Q?IV9ylbci/kKOtNSWUeQM4yiM6pfPLqk1uUVzo8x6zkTMxQPMTu1UxQohvB5i?=
 =?us-ascii?Q?tKkTJ81SHNP/eFu/k4ujJz+i96TMN49EdbGV081NKmdwfNx9FbvJMYvDLv90?=
 =?us-ascii?Q?zNB1gf6Qm+Xz460RKaCb23qqCvq9vK+dkaLaJEs0UmGVoZEz7hJ6nER53vTh?=
 =?us-ascii?Q?FQk0DydgnfxvWhooiQUPxL/tKiTMyCtju+hsTR7EKlRX2Zh7Ri/WtqH9i39P?=
 =?us-ascii?Q?e8aUrBtRU8J1mTUIST2rtqCHiZ/XPhNkxq4u78BiyGT9CLxaCruuaTWCO7nO?=
 =?us-ascii?Q?zCURFngqejYlnky95/p4lOLEOew0WZiXTYlb6q8r1rlypTN6jCLewRHDi4cn?=
 =?us-ascii?Q?l/pQAPP31ri65mnaOffHafvGVArh7IZEVbiEMlxWQWGlp4ojZ5DMQ9gQzsb/?=
 =?us-ascii?Q?GRdqzU8eUxAtrAfmyJY6IHXx6bgZMOaZQ8FTCHk2Yeo3a8095gB1avWbLg+U?=
 =?us-ascii?Q?S/LEmmNeRqFa7BzQoby5RcdDiHtfSf3PI5SwsgcwRtxHv15NfTYJfo8x3J79?=
 =?us-ascii?Q?D97fAZX4q9y443P5P4JgdPm9lDx5EvXh037sm8r1hw6sZnHJU0pjWlmbsTEI?=
 =?us-ascii?Q?22gCAologrKUNdaF35jTS/M48pBLscVEzFfqfEAAvTvDvTqN/5G4JcEwq0Cd?=
 =?us-ascii?Q?lSuueXArWe1pKTR5d9EmRbEj+f4AjJqX8MgJQdNxAq0gNeFKe/nzWgxqcVvg?=
 =?us-ascii?Q?BRiHthf8iKWduE5UDTH+IlhshljZX+3r5polgnvP/AU/Y6H7h2VeytREc6zd?=
 =?us-ascii?Q?kUxpTPAV6ygNXAf/iWmWSQ2KyGlp+Y0NulH2jKpMebClk2zdjAt45VwB3uHV?=
 =?us-ascii?Q?SkkZpHShDceliUxVFwpkp7ptArvTDLxBC2AMf+Ev+EiEXOqsATa0Mdt0B9Rz?=
 =?us-ascii?Q?qDj9l+3STd3CIg7S/5Sp4VlUbYhyWYa2Vp8WfU/ON5dx6az6uE9TeFzLPDhq?=
 =?us-ascii?Q?k6OeBj5OEX2dOLQ+ZVjQCXTpSWF8cDp173jZ4oRECobqm1Aotbs86B+rb2QA?=
 =?us-ascii?Q?LntBSQGWBdRoac53ABT4wGdXpShLERYI7O5oJ+rfpZcZ6F5e91M7jPblhgX1?=
 =?us-ascii?Q?905f+cKLNQQQRSFyo0MVj7pcZOt6GZX86Jy+GCuJYRkHkKjiDdOB69P+PaT3?=
 =?us-ascii?Q?h8DLsTgsgqyLxPmom/kAkxSmdugak9V0G7PFkdJb8JXkVEQJFsat2MM1zDST?=
 =?us-ascii?Q?nw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: afd4f394-840a-4923-a326-08dd7dbebaf5
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 14:47:09.4536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ppcroj9LkC7lTvJluYWpcj4iud1twoP62TVjN+n7gnexTWyENjstYnpDl3zCR9MafoQhkJtA3sOt6Ojn/bGStg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4740
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "UBSAN:shift-out-of-bounds_in_kernel/trace/ftrace.c" on:

commit: 0ae6b8ce200da00a78f33c055fdc4fe3225d22ec ("ftrace: Fix accounting of subop hashes")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master      8ffd015db85fea3e15a77027fda6c02ced4d2444]
[test failed on linux-next/master b425262c07a6a643ebeed91046e161e20b944164]

in testcase: boot

config: x86_64-rhel-9.4-kunit
compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+--------------------------------------------------------------------------------------+------------+------------+
|                                                                                      | 04a80a34c2 | 0ae6b8ce20 |
+--------------------------------------------------------------------------------------+------------+------------+
| boot_successes                                                                       | 27         | 0          |
| boot_failures                                                                        | 0          | 30         |
| UBSAN:shift-out-of-bounds_in_kernel/trace/ftrace.c                                   | 0          | 30         |
| Oops:general_protection_fault,probably_for_non-canonical_address#:#[##]SMP_KASAN_PTI | 0          | 30         |
| KASAN:maybe_wild-memory-access_in_range[#-#]                                         | 0          | 30         |
| RIP:__ftrace_hash_move                                                               | 0          | 30         |
| Kernel_panic-not_syncing:Fatal_exception                                             | 0          | 30         |
+--------------------------------------------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202504172247.26db367d-lkp@intel.com


[   12.139798][    T1] ------------[ cut here ]------------
[   12.140960][    T1] UBSAN: shift-out-of-bounds in kernel/trace/ftrace.c:1426:11
[   12.142488][    T1] shift exponent 51870560556424975 is too large for 32-bit type 'int'
[   12.143262][    T1] CPU: 1 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.15.0-rc1-00004-g0ae6b8ce200d #1 PREEMPT(voluntary)
[   12.143266][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   12.143266][    T1] Call Trace:
[   12.143266][    T1]  <TASK>
[ 12.143266][ T1] dump_stack_lvl (kbuild/obj/consumer/x86_64-rhel-9.4-kunit/lib/dump_stack.c:123 (discriminator 1)) 
[ 12.143266][ T1] __ubsan_handle_shift_out_of_bounds (kbuild/obj/consumer/x86_64-rhel-9.4-kunit/lib/ubsan.c:232 kbuild/obj/consumer/x86_64-rhel-9.4-kunit/lib/ubsan.c:492) 
[ 12.143266][ T1] ? __pfx_mutex_unlock (kbuild/obj/consumer/x86_64-rhel-9.4-kunit/kernel/locking/mutex.c:534) 
[ 12.143266][ T1] __ftrace_hash_move.cold (kbuild/obj/consumer/x86_64-rhel-9.4-kunit/kernel/trace/ftrace.c:1426 kbuild/obj/consumer/x86_64-rhel-9.4-kunit/kernel/trace/ftrace.c:1449) 
[ 12.143266][ T1] ? kasan_save_track (kbuild/obj/consumer/x86_64-rhel-9.4-kunit/arch/x86/include/asm/current.h:25 kbuild/obj/consumer/x86_64-rhel-9.4-kunit/mm/kasan/common.c:60 kbuild/obj/consumer/x86_64-rhel-9.4-kunit/mm/kasan/common.c:69) 
[ 12.143266][ T1] ? mutex_unlock (kbuild/obj/consumer/x86_64-rhel-9.4-kunit/include/linux/instrumented.h:96 kbuild/obj/consumer/x86_64-rhel-9.4-kunit/include/linux/atomic/atomic-instrumented.h:4479 kbuild/obj/consumer/x86_64-rhel-9.4-kunit/kernel/locking/mutex.c:166 kbuild/obj/consumer/x86_64-rhel-9.4-kunit/kernel/locking/mutex.c:536) 
[ 12.143266][ T1] ? __kasan_kmalloc (kbuild/obj/consumer/x86_64-rhel-9.4-kunit/mm/kasan/common.c:377 kbuild/obj/consumer/x86_64-rhel-9.4-kunit/mm/kasan/common.c:394) 
[ 12.143266][ T1] ? alloc_and_copy_ftrace_hash (kbuild/obj/consumer/x86_64-rhel-9.4-kunit/kernel/trace/ftrace.c:1198 kbuild/obj/consumer/x86_64-rhel-9.4-kunit/kernel/trace/ftrace.c:1377) 
[ 12.143266][ T1] ? __pfx_mutex_unlock (kbuild/obj/consumer/x86_64-rhel-9.4-kunit/kernel/locking/mutex.c:534) 
[ 12.143266][ T1] __ftrace_hash_move_and_update_ops (kbuild/obj/consumer/x86_64-rhel-9.4-kunit/kernel/trace/ftrace.c:1483 kbuild/obj/consumer/x86_64-rhel-9.4-kunit/kernel/trace/ftrace.c:3364) 
[ 12.143266][ T1] ? __pfx_mutex_unlock (kbuild/obj/consumer/x86_64-rhel-9.4-kunit/kernel/locking/mutex.c:534) 
[ 12.143266][ T1] ftrace_update_ops (kbuild/obj/consumer/x86_64-rhel-9.4-kunit/kernel/trace/ftrace.c:3387) 
[ 12.143266][ T1] ? __pfx_mutex_unlock (kbuild/obj/consumer/x86_64-rhel-9.4-kunit/kernel/locking/mutex.c:534) 
[ 12.143266][ T1] ftrace_startup_subops (kbuild/obj/consumer/x86_64-rhel-9.4-kunit/kernel/trace/ftrace.c:3566) 
[ 12.143266][ T1] ? __SCT__fgraph_func (??:?) 
[ 12.143266][ T1] ? __pfx_ftrace_startup_subops (kbuild/obj/consumer/x86_64-rhel-9.4-kunit/kernel/trace/ftrace.c:3492) 
[ 12.143266][ T1] ? __pfx_mutex_unlock (kbuild/obj/consumer/x86_64-rhel-9.4-kunit/kernel/locking/mutex.c:534) 
[ 12.143266][ T1] ? __pfx_store_entry (kbuild/obj/consumer/x86_64-rhel-9.4-kunit/kernel/trace/trace_selftest.c:781) 
[ 12.143266][ T1] register_ftrace_graph (kbuild/obj/consumer/x86_64-rhel-9.4-kunit/kernel/trace/fgraph.c:1385) 
[ 12.143266][ T1] ? ftrace_set_regex (kbuild/obj/consumer/x86_64-rhel-9.4-kunit/kernel/trace/ftrace.c:6251) 
[ 12.143266][ T1] ? __pfx_register_ftrace_graph (kbuild/obj/consumer/x86_64-rhel-9.4-kunit/kernel/trace/fgraph.c:1322) 
[ 12.143266][ T1] ? __pfx_ftrace_set_regex (kbuild/obj/consumer/x86_64-rhel-9.4-kunit/kernel/trace/ftrace.c:6228) 
[ 12.143266][ T1] test_graph_storage (kbuild/obj/consumer/x86_64-rhel-9.4-kunit/kernel/trace/trace_selftest.c:966 kbuild/obj/consumer/x86_64-rhel-9.4-kunit/kernel/trace/trace_selftest.c:1014) 
[ 12.143266][ T1] trace_selftest_startup_function_graph (kbuild/obj/consumer/x86_64-rhel-9.4-kunit/kernel/trace/trace_selftest.c:1181) 
[ 12.143266][ T1] ? __pfx_trace_selftest_startup_function_graph (kbuild/obj/consumer/x86_64-rhel-9.4-kunit/kernel/trace/trace_selftest.c:1064) 
[ 12.143266][ T1] ? __pfx_tracing_reset_online_cpus (kbuild/obj/consumer/x86_64-rhel-9.4-kunit/kernel/trace/trace.c:2354) 
[ 12.143266][ T1] ? mutex_lock (kbuild/obj/consumer/x86_64-rhel-9.4-kunit/arch/x86/include/asm/atomic64_64.h:101 kbuild/obj/consumer/x86_64-rhel-9.4-kunit/include/linux/atomic/atomic-arch-fallback.h:4296 kbuild/obj/consumer/x86_64-rhel-9.4-kunit/include/linux/atomic/atomic-long.h:1482 kbuild/obj/consumer/x86_64-rhel-9.4-kunit/include/linux/atomic/atomic-instrumented.h:4458 kbuild/obj/consumer/x86_64-rhel-9.4-kunit/kernel/locking/mutex.c:156 kbuild/obj/consumer/x86_64-rhel-9.4-kunit/kernel/locking/mutex.c:276) 
[ 12.143266][ T1] ? __pfx_mutex_lock (kbuild/obj/consumer/x86_64-rhel-9.4-kunit/kernel/locking/mutex.c:273) 
[ 12.143266][ T1] run_tracer_selftest (kbuild/obj/consumer/x86_64-rhel-9.4-kunit/kernel/trace/trace.c:2152 (discriminator 1)) 
[ 12.143266][ T1] register_tracer (kbuild/obj/consumer/x86_64-rhel-9.4-kunit/kernel/trace/trace.c:2190 kbuild/obj/consumer/x86_64-rhel-9.4-kunit/kernel/trace/trace.c:2306) 
[ 12.143266][ T1] ? __pfx_init_graph_trace (kbuild/obj/consumer/x86_64-rhel-9.4-kunit/kernel/trace/trace_functions_graph.c:1731) 
[ 12.143266][ T1] do_one_initcall (kbuild/obj/consumer/x86_64-rhel-9.4-kunit/init/main.c:1257) 
[ 12.143266][ T1] ? __pfx_do_one_initcall (kbuild/obj/consumer/x86_64-rhel-9.4-kunit/init/main.c:1248) 
[ 12.143266][ T1] ? __pfx_parse_args (kbuild/obj/consumer/x86_64-rhel-9.4-kunit/kernel/params.c:168) 
[ 12.143266][ T1] ? __kmalloc_noprof (kbuild/obj/consumer/x86_64-rhel-9.4-kunit/include/linux/kasan.h:260 kbuild/obj/consumer/x86_64-rhel-9.4-kunit/mm/slub.c:4331 kbuild/obj/consumer/x86_64-rhel-9.4-kunit/mm/slub.c:4343) 
[ 12.143266][ T1] ? do_initcalls (kbuild/obj/consumer/x86_64-rhel-9.4-kunit/include/linux/slab.h:909 kbuild/obj/consumer/x86_64-rhel-9.4-kunit/include/linux/slab.h:1039 kbuild/obj/consumer/x86_64-rhel-9.4-kunit/init/main.c:1328) 
[ 12.143266][ T1] do_initcalls (kbuild/obj/consumer/x86_64-rhel-9.4-kunit/init/main.c:1318 kbuild/obj/consumer/x86_64-rhel-9.4-kunit/init/main.c:1335) 
[ 12.143266][ T1] kernel_init_freeable (kbuild/obj/consumer/x86_64-rhel-9.4-kunit/init/main.c:1569) 
[ 12.143266][ T1] ? __pfx_kernel_init (kbuild/obj/consumer/x86_64-rhel-9.4-kunit/init/main.c:1449) 
[ 12.143266][ T1] kernel_init (kbuild/obj/consumer/x86_64-rhel-9.4-kunit/init/main.c:1459) 
[ 12.143266][ T1] ? calculate_sigpending (kbuild/obj/consumer/x86_64-rhel-9.4-kunit/kernel/signal.c:194) 
[ 12.143266][ T1] ret_from_fork (kbuild/obj/consumer/x86_64-rhel-9.4-kunit/arch/x86/kernel/process.c:159) 
[ 12.143266][ T1] ? __pfx_kernel_init (kbuild/obj/consumer/x86_64-rhel-9.4-kunit/init/main.c:1449) 
[ 12.143266][ T1] ret_from_fork_asm (kbuild/obj/consumer/x86_64-rhel-9.4-kunit/arch/x86/entry/entry_64.S:258) 
[   12.143266][    T1]  </TASK>
[   12.177300][    T1] ---[ end trace ]---
[   12.177951][    T1] Oops: general protection fault, probably for non-canonical address 0xeabbfbff80000000: 0000 [#1] SMP KASAN PTI
[   12.178266][    T1] KASAN: maybe wild-memory-access in range [0x55dffffc00000000-0x55dffffc00000007]
[   12.178266][    T1] CPU: 1 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.15.0-rc1-00004-g0ae6b8ce200d #1 PREEMPT(voluntary)
[   12.178266][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 12.178266][ T1] RIP: 0010:__ftrace_hash_move (kbuild/obj/consumer/x86_64-rhel-9.4-kunit/kernel/trace/ftrace.c:1429 kbuild/obj/consumer/x86_64-rhel-9.4-kunit/kernel/trace/ftrace.c:1449) 
[ 12.178266][ T1] Code: 49 01 e9 49 89 c2 49 89 fc 48 8b 44 24 08 48 c1 e8 03 80 3c 28 00 0f 85 b8 05 00 00 49 8b 5f 08 4c 01 f3 48 89 d8 48 c1 e8 03 <80> 3c 28 00 0f 85 81 05 00 00 4c 8b 1b 4d 85 db 0f 84 90 01 00 00
All code
========
   0:	49 01 e9             	add    %rbp,%r9
   3:	49 89 c2             	mov    %rax,%r10
   6:	49 89 fc             	mov    %rdi,%r12
   9:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
   e:	48 c1 e8 03          	shr    $0x3,%rax
  12:	80 3c 28 00          	cmpb   $0x0,(%rax,%rbp,1)
  16:	0f 85 b8 05 00 00    	jne    0x5d4
  1c:	49 8b 5f 08          	mov    0x8(%r15),%rbx
  20:	4c 01 f3             	add    %r14,%rbx
  23:	48 89 d8             	mov    %rbx,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
  2a:*	80 3c 28 00          	cmpb   $0x0,(%rax,%rbp,1)		<-- trapping instruction
  2e:	0f 85 81 05 00 00    	jne    0x5b5
  34:	4c 8b 1b             	mov    (%rbx),%r11
  37:	4d 85 db             	test   %r11,%r11
  3a:	0f 84 90 01 00 00    	je     0x1d0

Code starting with the faulting instruction
===========================================
   0:	80 3c 28 00          	cmpb   $0x0,(%rax,%rbp,1)
   4:	0f 85 81 05 00 00    	jne    0x58b
   a:	4c 8b 1b             	mov    (%rbx),%r11
   d:	4d 85 db             	test   %r11,%r11
  10:	0f 84 90 01 00 00    	je     0x1a6


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250417/202504172247.26db367d-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

