Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA8C278150;
	Thu, 21 Aug 2025 05:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755754022; cv=fail; b=USr+K9Z4clDnMEIqFa4sB9ABb7yhhBab5Wbtyb0hdD3KnvD1LBdCCwRKFtrkIiTaZkxN4APuEXkBMAo0vsRZZyNKWjEwqFxF4CRsz5MVtY1Saw4xCea5YgB6u3XheDF8en3bsqYt9u6/+WQ2e2o2kloSMN1XgLRE+ToTcu4Wwdk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755754022; c=relaxed/simple;
	bh=3xeiutSlONbeY6Mnqs8gyO2JvYsL7r0s44h87lzFMx0=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=e+UjTtTW1+v5mHxByYjvElDqejykYl1B+8zdV3sLIq4EP8rjNS53/JNyMSJ7vJjD3ii5R7VgatkST37VoxNQ16QzXq4k3YE2y8NbDJt2PRLcLgUU2T6jnipCx6bhUc373VH/V/0cq0bgI9lka5UksH4lzqAMdgXjJREcEX+IC7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=erE+AlGS; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="erE+AlGS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755754019; x=1787290019;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3xeiutSlONbeY6Mnqs8gyO2JvYsL7r0s44h87lzFMx0=;
  b=erE+AlGSL28WNfpXQLvexmm5QuxxmF1jO7eSeVRLOt7D8yUqAzgkHxGq
   dWLN9NDimKfedY5ShXy11wyyaUIBW4T5JvhDwSF21eqWJrLz6DiZRC2kH
   kYEhmxsdIXgBSb0G/AOznw8Xsu506IvJyySvpq0N4bZeb19N//GakrX+k
   RYQwM9l6vqWPuBkjMDGD/p/PWDu6Ac7YO3Qj42GHYfP4NjpCAwqNzE8b6
   /p11Zj8J1F6kvym+d2CnETNaDN3WM+Iah4YTCJzmjrH27euWpR7ATmcuR
   2Yw4nM7TfFhVNjd6/BzT/UATj7kcAY67GSYu1FM266qbL70D4jHL3s+R/
   Q==;
X-CSE-ConnectionGUID: gheM6bCkQOW7Q5gutoONQw==
X-CSE-MsgGUID: rZNYShGiTC2E7SkR1Ld7Cg==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="61845079"
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="61845079"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 22:26:59 -0700
X-CSE-ConnectionGUID: nfUS11HbRxq2EJ51X7Uylg==
X-CSE-MsgGUID: yzEtAsSKTVGE55DvMpw/xQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="168242943"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 22:26:59 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 20 Aug 2025 22:26:58 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 20 Aug 2025 22:26:58 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.67)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 20 Aug 2025 22:26:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AUmt/7TXTFPwa3enlhGkxT2eL33kQe8VQyrG86muygJtzWQ6AG4xDuKlSoq4pY4mW4arBHvmtsIzCe25vXuZ6KNyzEo8dlDqG89nC+gbw/EjI7X072YgawRQivRfcBrcO6tkqHmon1IHO1ercEASXDF1YkypYCg+S5VnKaRgRD1uz5n42vJA/mjbNSyKbGq3sR+TTC0mOsZB4DHtP3rXEar/od0VfU1KhiY3Wh159p6UQTN45naOgTbvwCoh0Myxt7u+wmLmhvqRNBmyfO8EUxHfgDgzeh+kTLDL/pd1EW1EjmdDdz7TntZhFqzA3nWVrpXhFYtVP/wK4eCS2lwGPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qcyV7hCORBUI4fGMS5IbLXaiCsnktzTPby2osju5+WQ=;
 b=ba32LblEijh6Q0t95Zzm/gMuPFn7NszmcjBLcmHWdUzOMlZ4x9u8kkiq6nAdqvATVbUZpQXeZ3hdV24WP/VTjtMvkWr+kjdxPrHULJb42EZzrczRYSBFi+W1l9z2KKKdw9VWJXrfRwbHJ+OZ2F0LTpUpmACFAJlkffs8O8/A/Izgg/+yw/RaGYX77IZNKCMhLvxIJgNyspRuknz+WjsCMOgVLcCOka+j78dd196Y1HJTvxcDwjhEOBxJ0k4rhfsbhIp1Mfme3ibq9KIOeEHAy4f/xuRJSPj6bex0jmt8ZoTpvoEO9CEL8ZKtwmNtpUCBb+LWQbfR7zPD3yTS6I839Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH0PR11MB4824.namprd11.prod.outlook.com (2603:10b6:510:38::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Thu, 21 Aug
 2025 05:26:56 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9052.013; Thu, 21 Aug 2025
 05:26:54 +0000
Date: Thu, 21 Aug 2025 13:26:45 +0800
From: kernel test robot <oliver.sang@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Steven Rostedt
	<rostedt@goodmis.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	<linux-trace-kernel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [paulmck-rcu:dev.2025.08.13a] [tracing]  364ac25d46:
 WARNING:at_arch/x86/mm/fault.c:#do_user_addr_fault
Message-ID: <202508211038.c93e8603-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR01CA0188.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::10) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH0PR11MB4824:EE_
X-MS-Office365-Filtering-Correlation-Id: f0f0eac0-3b17-4f20-972e-08dde0735717
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YOOvyy+Pv2TEmyokYMZ9Rog2L0J4SRrJhFj9lQHAP0wxOMWvaWw9EesVBjvY?=
 =?us-ascii?Q?M3e3UgkMwhXBUW2thc1LCf1KKniZLfgELVh3j1Qf3/bXFOb0t12lpunEILZd?=
 =?us-ascii?Q?OF7IUt0factx1u0AF/NX4eEGCR+y/npeGgZrn2XLuuiCiLUjDkX0eB3MNnhF?=
 =?us-ascii?Q?j7/U4i+3pjewLZm1MWjkhNfdapeJer6S+h1xXIPqCLlVw68vjoDCItG9q9GS?=
 =?us-ascii?Q?dDjh/gIPM6t3w8xlSHr0uxX9lmm2gZ83uQCrDW/Srp7qhsZMBSRafhLLzX3q?=
 =?us-ascii?Q?xGQqOfjqrj+SSPWzZbxJAhHtwC5m9vYm6qqsapgN6qVEaMbRPDwOV9UkPUY5?=
 =?us-ascii?Q?au1gfvBYYb+6ezKW5DpCAfIbRK2/D4/O3oRmRELP19+e/BvGqftmspqxoFYt?=
 =?us-ascii?Q?fb0OrbhDW51dUezurmnKrAyae6OIz29pS6uF0xDAHhejCsO9WjVIWM28AjOD?=
 =?us-ascii?Q?9Z/+jO+tH3r2N8F71bSUkmgmTPM0U9NFevESlP1q4mS8IE7/GwHQHzNcsdYH?=
 =?us-ascii?Q?x+I4XNgjj1ExXtL870KIAtcHFWTGR9vdTJd4D+MZl7df011RYI446K5ENOBT?=
 =?us-ascii?Q?zcKFTaCyltkc9p7wrJrtOhhtS+Czbn1o501aErbHPe9jJbpMsWSAuoYPvAfl?=
 =?us-ascii?Q?GbJjX9rJ/SU9oj5kmNkD4xu8UkthD04p6kNyeYCvrl+ouJzLe1wIhwo83Ulp?=
 =?us-ascii?Q?c51NcG29C2rdbrQlxkrlRpD/KNHyB8Vg407rT7RoFaXFz3FWC9VgtaCqcmRN?=
 =?us-ascii?Q?sdZQ4iCT6dvnm4kUChcFXle/nsZHPikGWxY4NHmbChw4SLVI980YLKwqMTcq?=
 =?us-ascii?Q?KVq8zWMYTXIQk/DIIycJj4Qv+0+6Z8Tq6wNUBjV3SgEjpjMaVxKIkcNk9ktZ?=
 =?us-ascii?Q?2Fj8lykHaOE6QNgDZwmf32CxU/KYpGXMtCoSDA4vb97MrWz+HoVhXUSZz9Mz?=
 =?us-ascii?Q?iJZ37efZVGd3W8eDYNk3PFHCXJVU3Kay/eyQRjzOLTil/IT1agi6qPcl/nHG?=
 =?us-ascii?Q?xAW8NQqWNj0G2W6PwVHRytGqrwjH5GoqrszTN2rr5rJRMv24NZz7w/9HqYgG?=
 =?us-ascii?Q?T4IldFXVwaTaxNts+QPSkIPdTHG04FS38i3JMncwqa09QdqLYrFljDFPciqq?=
 =?us-ascii?Q?YjKVpilxKEVAURfq0M1MALZqqa9L0CvqlKx3kWeYwY8bo8kCJ7VRtReVW//K?=
 =?us-ascii?Q?AOKAQhJRpgvOb1kpYV5GtVGFN9UpsFT+4Epjy4TSbYfhqcAYoaVOoEU0k3mw?=
 =?us-ascii?Q?FbrCCkcF1G5U84h/Z/3zh42sBJepD24hP3w5TUqIZVhIB/vNQRTIVsUmupFS?=
 =?us-ascii?Q?WrYLiwSOzJQQPC2/jjdntlcQdeqJhwpH8418b6/JY0qGZwlBP8OGo2bYfwH5?=
 =?us-ascii?Q?l3/TcskJ0jg264xF6Wq9Wpl+gmHW?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IGxGrc2b9mVaJIPWTx2FgUhllGe1sO047sQYUO6NfiDJCLKO7MDM3SfTkkjg?=
 =?us-ascii?Q?b7EsgiszD/CGpn+prUvDTP29sUA7r0Bih3kgri1todagk/H8RgQ9JsrMv8zG?=
 =?us-ascii?Q?LACjLl7FuEA01owwZCiYqmkJbhREM0OX0UdLo/97UmMKlP/GMT3Jj6xWx/If?=
 =?us-ascii?Q?BstoEjTBPnMgA6LDCMb9ArdD6dtDA1vEna0l8G+Le3I0baLis+fWecyCPN9D?=
 =?us-ascii?Q?2Fky+UHo8Jwbn9sXksFBnKYQeCIk6YGuTPYenTYrGZ5Pmd21RYNnx2arIla1?=
 =?us-ascii?Q?kniD0WtlM3eYhcYewQifOo9gvb1PrdrBthXug7upXQza0cixgd6S3GQVSTqI?=
 =?us-ascii?Q?yB2CU/S9syjUnignvO5/yG3MbgDmdFzGbCr2+TwXc/13JEsUd8BqOhrx/Ntf?=
 =?us-ascii?Q?651ByCMin1xV8Vr/TS+mbUVlSG3vjR/fMCXc+wsXoutJeSjkfn3DVYaKdFin?=
 =?us-ascii?Q?/1iUiinjp2i5KV1RBlMJT6zYRngy/sL8XoJv3LfOLoXe2MR2/wEmZcnMYPa4?=
 =?us-ascii?Q?ZiMKFQH9RgCMjnVB2w8DHYGriLHUTv62bhhmtroURq4m030AnJCG3IFxPIS4?=
 =?us-ascii?Q?iJy0Di6DRK0kVzoiYAMBrIwekQL7a5TLkR5XXlJGcr9vyXMa6z95rAqInLDX?=
 =?us-ascii?Q?nF6neWoE8XvXPSRnbfPJDSRzyU22aFd2OU32QbSjxhh2176SeT/IC7ZclWyT?=
 =?us-ascii?Q?LTUduNWBVBy9k+JKq1bDJzQoPGqtZ5y0w3GNNfkGQC9iYh6cCja+5OVMpMBf?=
 =?us-ascii?Q?eZxZFOw9g1TSVt7vtbk3m4hEKAjUa+Tbej92PyN2Ae/2VF9jOOSfIzeJ8qNS?=
 =?us-ascii?Q?CvD57KtpztvO9vN4CY80O2unF0cdPB+UcbtN/+FCnZAkU+gWEEGHiGpOWi2x?=
 =?us-ascii?Q?E7/2uIrsLy/XF96YS4wfeU3av3J7aTmT7Ddsc5NsPKUGESsl1tl+60MlRaLb?=
 =?us-ascii?Q?l6xC4pALZB2vxkEhACyG6jZWDatFkMh9tvkL5866KSWACGDtv0DT+kQPRdoz?=
 =?us-ascii?Q?IgeJaopRTqZMhXEGxq7Mq9cqbnYYEf8WauR3QnHnDtf+mQTAC1Q6fChVY45e?=
 =?us-ascii?Q?+R+mySIZ0TOvKPuNs+3n42uiqfWWkcPJwrBD0Y6ceiWKPWxNHeqAGkKN4Qcg?=
 =?us-ascii?Q?brEB9ybR+LY0NC3OnSb6fp5zS0yIXi1HKUVqPn8ks+sTNwdGs0NLipke1aPI?=
 =?us-ascii?Q?9UkU9xjv3lCldHJaSC53dReFE8eUOKNqpGhhy0eLvsZV11jYek0vOk29cq81?=
 =?us-ascii?Q?uJ+Vk8Jo4WuHqJ0aMAPYogC6nkPgCRQIBKg2OpOlpj9Vt0JLBA9qDA1K5uPk?=
 =?us-ascii?Q?dEwj3m90QClvd6GUWuBLCTEr9Ix/00YM7RJWL7HNPbBn+7hLAL39dqOYp04/?=
 =?us-ascii?Q?A7pjT7Y9GXj32iNhxZIQtOay3l2AqZNFPoXaBZDI1HpAwSeiaAtskjhbjdrf?=
 =?us-ascii?Q?jtld4pixNQEj4bpevuZ7vcJDFDm1LO/s2WVV9iDwvl8VqAUynRETsNIdtcrH?=
 =?us-ascii?Q?pIhDE6iDqu1TIZXYd1b6TAgkhLpl/76+OaugvJqaSumu+bPtLh7T9yEfO/TJ?=
 =?us-ascii?Q?OM02mNH9JxUgn/S6wbzcQ45r3OX+IPRJJ1z+TmrTHpE6jWf5uMfnbiV7mPQg?=
 =?us-ascii?Q?UA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f0f0eac0-3b17-4f20-972e-08dde0735717
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 05:26:54.5652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TnXKwGHtPtC5PFfJWFGCCHX70c8AQvGqOCdL91XbUXDpvOmp1+v7oFYvFEF/dAzAfIpk7IQjvW14nLxT35nIbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4824
X-OriginatorOrg: intel.com


hi, Paul,

we also noticed there is similar commit in newer branch
  dev.2025.08.14a
  dev.2025.08.19a
but we didn't finish any bisect for them so far.

if the issue is already known and fixed in newer version, please just ignore
this report. sorry if any inconvenience.

below full report FYI.


Hello,

kernel test robot noticed "WARNING:at_arch/x86/mm/fault.c:#do_user_addr_fault" on:

commit: 364ac25d46eea504eb90229d2a1f92e18c1a1eae ("tracing: Guard __DECLARE_TRACE() use of __DO_TRACE_CALL() with SRCU-fast")
https://git.kernel.org/cgit/linux/kernel/git/paulmck/linux-rcu.git dev.2025.08.13a

in testcase: boot

config: i386-randconfig-004-20250819
compiler: clang-20
test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 4G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+----------------------------------------------------+------------+------------+
|                                                    | c0e2a3f449 | 364ac25d46 |
+----------------------------------------------------+------------+------------+
| WARNING:at_arch/x86/mm/fault.c:#do_user_addr_fault | 0          | 12         |
| EIP:do_user_addr_fault                             | 0          | 12         |
| BUG:kernel_NULL_pointer_dereference,address        | 0          | 12         |
| Oops                                               | 0          | 12         |
| EIP:do_int80_syscall_32                            | 0          | 12         |
| Kernel_panic-not_syncing:Fatal_exception           | 0          | 12         |
+----------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202508211038.c93e8603-lkp@intel.com


[    5.974959][  T117] ------------[ cut here ]------------
[ 5.975530][ T117] WARNING: CPU: 1 PID: 117 at arch/x86/mm/fault.c:1276 do_user_addr_fault (ld-temp.o:?) 
[    5.976496][  T117] Modules linked in:
[    5.976924][  T117] CPU: 1 UID: 0 PID: 117 Comm: sh Not tainted 6.17.0-rc1-00010-g364ac25d46ee #1 NONE  7aaffa6b74f3c55be0a24cdbe6593fcd4ccf301d
[    5.978263][  T117] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 5.979306][ T117] EIP: do_user_addr_fault (ld-temp.o:?) 
[ 5.979859][ T117] Code: 15 fe ff ff 89 f9 ff 75 f0 e8 96 04 00 00 83 c4 04 e9 03 fe ff ff 89 f9 89 da ff 75 f0 e8 72 01 00 00 83 c4 04 e9 ef fd ff ff <0f> 0b 89 f9 89 da ff 75 f0 e8 fc 03 00 00 83 c4 04 e9 d9 fd ff ff
All code
========
   0:	15 fe ff ff 89       	adc    $0x89fffffe,%eax
   5:	f9                   	stc
   6:	ff 75 f0             	push   -0x10(%rbp)
   9:	e8 96 04 00 00       	call   0x4a4
   e:	83 c4 04             	add    $0x4,%esp
  11:	e9 03 fe ff ff       	jmp    0xfffffffffffffe19
  16:	89 f9                	mov    %edi,%ecx
  18:	89 da                	mov    %ebx,%edx
  1a:	ff 75 f0             	push   -0x10(%rbp)
  1d:	e8 72 01 00 00       	call   0x194
  22:	83 c4 04             	add    $0x4,%esp
  25:	e9 ef fd ff ff       	jmp    0xfffffffffffffe19
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	89 f9                	mov    %edi,%ecx
  2e:	89 da                	mov    %ebx,%edx
  30:	ff 75 f0             	push   -0x10(%rbp)
  33:	e8 fc 03 00 00       	call   0x434
  38:	83 c4 04             	add    $0x4,%esp
  3b:	e9 d9 fd ff ff       	jmp    0xfffffffffffffe19

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	89 f9                	mov    %edi,%ecx
   4:	89 da                	mov    %ebx,%edx
   6:	ff 75 f0             	push   -0x10(%rbp)
   9:	e8 fc 03 00 00       	call   0x40a
   e:	83 c4 04             	add    $0x4,%esp
  11:	e9 d9 fd ff ff       	jmp    0xfffffffffffffdef
[    5.981783][  T117] EAX: 80000000 EBX: 00000000 ECX: 00000000 EDX: 4875de00
[    5.982461][  T117] ESI: 46bf1f14 EDI: 46bf1f14 EBP: 46bf1ef0 ESP: 46bf1ec4
[    5.983152][  T117] DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068 EFLAGS: 00010046
[    5.983885][  T117] CR0: 80050033 CR2: 00000004 CR3: 06fc8000 CR4: 00040690
[    5.984575][  T117] Call Trace:
[ 5.984911][ T117] ? exc_page_fault (ld-temp.o:?) 
[ 5.985376][ T117] ? pvclock_clocksource_read_nowd (ld-temp.o:?) 
[ 5.985971][ T117] ? handle_exception (arch/x86/entry/entry_32.S:1048) 
[ 5.986454][ T117] ? do_int80_syscall_32 (ld-temp.o:?) 
[ 5.986948][ T117] ? entry_INT80_32 (arch/x86/entry/entry_32.S:945) 
[ 5.987410][ T117] ? insn_get_code_seg_params (ld-temp.o:?) 
[ 5.987948][ T117] ? pvclock_clocksource_read_nowd (ld-temp.o:?) 
[ 5.988547][ T117] ? do_int80_syscall_32 (ld-temp.o:?) 
[ 5.989050][ T117] ? pvclock_clocksource_read_nowd (ld-temp.o:?) 
[ 5.989645][ T117] ? do_int80_syscall_32 (ld-temp.o:?) 
[ 5.990146][ T117] ? entry_INT80_32 (arch/x86/entry/entry_32.S:945) 
[ 5.990611][ T117] ? irqentry_exit (ld-temp.o:?) 
[ 5.991053][ T117] ? exc_page_fault (ld-temp.o:?) 
[ 5.991512][ T117] ? entry_INT80_32 (arch/x86/entry/entry_32.S:945) 
[    5.991915][  T117] irq event stamp: 5810
[ 5.992173][ T117] hardirqs last enabled at (5809): do_wait (ld-temp.o:?) 
[ 5.992686][ T117] hardirqs last disabled at (5810): do_int80_syscall_32 (ld-temp.o:?) 
[ 5.993245][ T117] softirqs last enabled at (5692): local_bh_enable (ld-temp.o:?) 
[ 5.993776][ T117] softirqs last disabled at (5690): local_bh_disable (ld-temp.o:?) 
[    5.994304][  T117] ---[ end trace 0000000000000000 ]---


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250821/202508211038.c93e8603-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

