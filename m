Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21112765C0;
	Tue, 30 Sep 2025 06:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759214922; cv=fail; b=Dxz/f3bMHICffzznQiFi/HKHdYIdEtjNNIurcGF9+yvMzWMGZ1FeFq8X2mNWouz4JNFnCu4oz94oGVPWcOQejgAXRtcqEfEm6SBPNyIBxtrGgXQY16Zy5Y2jhFTleDMzUM4MOmF56P45jArwV5IyrAFWCzyTQnBO/hTfi1lbnt8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759214922; c=relaxed/simple;
	bh=Zdu5Vo9zjyxG7FoVQGdVczRng/IzTjw9sTUQtn7hy1Q=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=NCQcvfgkWNhovoWS7wHbVWYDuPID+Oj9eHPwZ8/OM+UzqNLSVQMmbzMG/gtBqAxdCZcMMNX60T6HSSd5yNT57tPnGopq32wNmNg6/fGp0T47/JenrriEL9QO4PUiwbAeDX8WOBuzPYdNINnUigD7W7XFS4+yH54xFA/RwSHiRYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e1o6dRHD; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e1o6dRHD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759214920; x=1790750920;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Zdu5Vo9zjyxG7FoVQGdVczRng/IzTjw9sTUQtn7hy1Q=;
  b=e1o6dRHDCWyk6tufvmNoPtCMXleenxeN0n4X4/SMaHQaI5ZsmgyxpvXc
   n0KHvIJiqmNDZAdzTtFoSk9GGmfTz6MKUvWeHV4fzrjXKnE2LKqEJAeLa
   CuCI+ZKQ6PUtu3Qx20ILmDtfW4l4hYeuZySVxwtFfg7lU52GAFmBIFGpD
   FrJCprPyIdT3vBi/mhN/A75UEbLwMSsHw/jLZYtl6vQWJueuf/0Jp8g84
   H9ZjyDZge7RS//O4DGBNeGnoU+D3aGSm65jjm/eXvULjUL8RcVpxAaJzP
   PcZ7n4E8gLyYon5Jh4LCZvVop9uwuvDJKUiuJ20oPk/BFrzENm8gmoFmz
   A==;
X-CSE-ConnectionGUID: 12UC2nIHTwyBfCwca9H9KA==
X-CSE-MsgGUID: ZQ4RWmw9QWerjp7NxDJJnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11568"; a="65100993"
X-IronPort-AV: E=Sophos;i="6.18,303,1751266800"; 
   d="scan'208";a="65100993"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 23:48:40 -0700
X-CSE-ConnectionGUID: 5g/lcV2kRXCEUquWjqlouQ==
X-CSE-MsgGUID: uKSV+DlFS5+utOEPUudbRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,303,1751266800"; 
   d="scan'208";a="177690176"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 23:48:41 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 29 Sep 2025 23:48:39 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 29 Sep 2025 23:48:39 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.46)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 29 Sep 2025 23:48:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HpI5PM5Fkl+smypV8YoMeHAAaQybTJ9z96UZqpvf1tFp0q3iIM9M805Jxhf0SsD/7FVLyl+sLKrfVVvtidosta/pPbwofR0VvCkqN5Eb+zAz33BtTNWAAKhhP5dzOcEhZDVq2IgKWrOpWonswMAOzWdjjI5bO6jX6Jnum/Cz/p9KsETJGqq5B1iWmLWNHqSntlT14nPOTKpHUsTW/DqnSYxFlYRXv5IF9iprGqVKEDb642HDWOtfwJoXgr/vzOCCVQIywZ0NbPRjxwPCy0SdsCS6vhm74wuA1MgxUSIw0O4nyRt2sMl/4qjdgspvPF6/9NhnaiQLogVhTYHwHaDPaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ck8V1/aSLWoKwRsmaCIQ+Zsol/+kY+XZXOZzIh4zTBI=;
 b=eEgJ0vYrDlz0xCraObDMXumJMzwEPnq3teSbDZo4a0xeeGwdMbjZw0XMRn5jATuJKvBIUGrUp+B9T7J8GPTWC6kYcBf2EQrzHfJ2XgoyeVSaRempLsT91AyPXWtmeKUXPH/WCfeVRfyVn9h0Nu8fpbQ8znGTN+1XUAG2tJMZrUDueZaZWRNRjRXuNDsEqm5i3CVAenu1EXGyxD2tXNF2g8BOCYQj/YJS5+qimaqUvM+puC7Yq/KAzdeaPBiwOX+jmmdTudklIexixgS+etH0+naj968nTSSMJf1MrZxJJp0dmHppwrT9M9s/dKRhv4qjlBXnH0OC31ZsL1OrKFUe1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by MW3PR11MB4636.namprd11.prod.outlook.com (2603:10b6:303:5a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 06:48:37 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9160.014; Tue, 30 Sep 2025
 06:48:36 +0000
Date: Tue, 30 Sep 2025 14:48:27 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Menglong Dong <menglong8.dong@gmail.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Masami Hiramatsu
	<mhiramat@kernel.org>, Menglong Dong <dongml2@chinatelecom.cn>,
	<linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linux-next:master] [tracing]  e5a4cc28a0:
 BUG:spinlock_bad_magic_on_CPU
Message-ID: <202509301440.be4b3631-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: TPYP295CA0032.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:7::13) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|MW3PR11MB4636:EE_
X-MS-Office365-Filtering-Correlation-Id: 835598eb-5d34-4d48-0fec-08ddffed61a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Eugv3lnDkl0Evti3ZK2g+6Mq7t8bAG0cxvBzaIU2AhLbj+C/TeZqutGputje?=
 =?us-ascii?Q?za6izzQc51Ls3MxwmC7p/zPr1ZBgZIxYEYCoeStbhA+jVd2GyBwdDsmFILa1?=
 =?us-ascii?Q?BQV7twuO2ngKmBmjcUhEdkn7Qnsm2iGfh9rI/b2AlKndwL+KEZsnSprRoZzm?=
 =?us-ascii?Q?cp9QpJoGQTN2f0lOV6dlhaZrUQO4G4utdtuGPgopOBLQPuQYPNpsxIS3gT7k?=
 =?us-ascii?Q?6FAeJhzlWegWpNGAStkYIZE9lclTYhl7HQHhBoYw40RtDs9x04absgiAIYnU?=
 =?us-ascii?Q?NHnWy97XDd0I4f8EmKVQA6bJ/wVKT79RJHQ6KId5mgOrKFb6jp3NArU704i3?=
 =?us-ascii?Q?fzvqH+Zc3Kh5+N++zlPfmI8SISmKMcg0AcbNTSmLtgFWcFHbjuvpdU24GgMd?=
 =?us-ascii?Q?/gCgjd8S/mtLHI7sHFDxGiC3FmDVrcNiCLlUhfwLKB+zVpERXAGdWI7JTVXk?=
 =?us-ascii?Q?XtIJy98GFpVwQOyAYxp9LMnfLsgTKsNwtmzpIGnrl1CLsuD4j3kv2Q3WpEo6?=
 =?us-ascii?Q?frvyBKX6tzFsRdBUEWFSwMZQTOfmQ5BRoFD4kY9NaPe5Y6FiVFOd/4OTXp7w?=
 =?us-ascii?Q?1rfohZttCL/BphBZejHNmHynftx045kxvTzbrYqMSMymaFqU5WXJcCTLkdjJ?=
 =?us-ascii?Q?ZM4rY0B4+HmZVdIRJRsEiIg3NkC347mXMUNmiAPacxtIQpCq9JMKFRdckciO?=
 =?us-ascii?Q?ogW1o1VA9155VkOF+nylv1y2Q9cGRpQ2gFOrcYQ25cElq29PXVfaTxAyFVue?=
 =?us-ascii?Q?5p5Rm1aOIhuF/C45PxFEjwi4gLKJcmBiR0T59ByAfE6ZqIPRKYqquxqyPhil?=
 =?us-ascii?Q?aOVgKhaxSbbULB0eCrnn+pQfAM7I2E0s7K3P+mlpXGZNZtUuHrtuGjwmBUG0?=
 =?us-ascii?Q?hjKGGWiatKe8WQaWqbAeUS0BhkYpueT+wZrxA9tCzIIk8QJ93rwGs/u7PW3L?=
 =?us-ascii?Q?QtbUnKsruoMmqBokb353t7xSooyZ/srD9H1TuPIAdAr73aFsE2KWOifyfaol?=
 =?us-ascii?Q?4Z2AfgGfKsraxLWjvq50Ny+o+IdZdG8kmc/t8jRFcdSOYzEY8bFwOJYzybmn?=
 =?us-ascii?Q?YWoMMOYovSQ6kbTA4YL/YSgzKGdY8Z3MYHT+3kOvc8pg2FbY2+EJiR58XGMA?=
 =?us-ascii?Q?YfgHxuqI8sPj8ELREedgVYEpTOZBe16+uT6lXSb5Z9DbF4Ab4/PAJkA9+F/W?=
 =?us-ascii?Q?5B4onomw5NLq1Ovlo2N3UxqRh5eG4X7Xff7ByNExcnx5jzyPn8St1eRWA/8T?=
 =?us-ascii?Q?PZK5+897nrNvQm1Aocie39ssAjgCyvKXhln8J9uCSpjzmKfcVI6+itYxH+ZT?=
 =?us-ascii?Q?cI+tzvwZ49+PdDVKC3a2xeCwe9lV6qbWwYZ5sNnBcWWTJwiK3+j9OKueU4RK?=
 =?us-ascii?Q?44NLmGm65z8jUkbOqTEDvI22aoBr7RedNqXnxlBKMduoB95TRK88ffW46OSZ?=
 =?us-ascii?Q?zVMumXpNDXg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?akusgnYYACC0XTwXKlHCifoBpKffMEgTH2fpeYlG05QVmpogTo5ViG2UFrwQ?=
 =?us-ascii?Q?qATN4G3mM18e3ztCYzmKEyk1vZSAfG29mmWnzfMBK0phTIucUHSpouSdbnAI?=
 =?us-ascii?Q?gdU4CLKxd8awV0jVoHqWpIOwe5A9tIFzzvhACakhr7huH6lEKtTCSYoz/8Bw?=
 =?us-ascii?Q?6ViiR4eBUfc+WTo5U4Wa7Iq1wabJ5aWWslewHHVBUVFDzdwRzF2R68HRc4GS?=
 =?us-ascii?Q?G/jPWiJNUtKgL6geqotKDGGhSW4EtayZDp98GC3EbXoSARXAV6jrlVRv35oq?=
 =?us-ascii?Q?AD14bP2EtsbRbFmAaXJWSkVS7NtB5D04CzEZzbq7ymD9QdXrFB2bJYvuiMZV?=
 =?us-ascii?Q?XS/dmVgpzjmBl/4eP6tgv3AyIXeAzCkzLjKwhLTPb8Dpi6WmRA0H6cqdkHTb?=
 =?us-ascii?Q?LOyGecdQPeyFUEHQBvsoi8vy62Z054ZVDr+H9iksx+JBc5gYvP1ftqZSdSoL?=
 =?us-ascii?Q?bt7lW5wYSXbr03BW37CHU07Xli7UlM+iW/Pi+GBo23SKZKnSlYVGXKYTpAuF?=
 =?us-ascii?Q?uNFHE4pYbBdnBtrJhFPD/BB1ppS4NTtf6V3Ss8eVyaRlMbjxxap7OdsjRLRM?=
 =?us-ascii?Q?hYPAxxtHzJDdvQdY2LfRgH64/gfnR9bKbWUUDLqkHlrZSOCWT4Uc0N6LCcd7?=
 =?us-ascii?Q?yCeZXM5nXjrCvf/f4q9x6yavtevmV3c32oVvh1ZQiyoKDCF2L1HOB6uEWfLB?=
 =?us-ascii?Q?2VhKjDO0zkgvCuLkdqcjEs76cbvGqIjSUdHyTC8il2xpa5DeVKdNIME+EfPS?=
 =?us-ascii?Q?iCCgfxjZYLZZArrb8/S97gs1Ylq0kE4uiGD3S+FnBPaXgj8aFEyyNPmUtkbE?=
 =?us-ascii?Q?Kf8aG6OkrC2njSj9jLLXa4FV7yjLpuFqFzRef53iqDI77APykNIpegVqps57?=
 =?us-ascii?Q?8vVGOEM5bTynuugBX5Y89F8UH1aoZ3x2r4xve7fd9bi1yin+qOsMBcsteiaa?=
 =?us-ascii?Q?3FjyyMV+vOkbJaGFPq/tj1zjendlno5h/cbmf+VGPCJ3JrV5x5BC+DQ+E0I4?=
 =?us-ascii?Q?yrfQ1njNHdUR9xH21lwyDhhC3mLWzOhjWiYCI6dnRe9sI52iMIZYWwwU96HK?=
 =?us-ascii?Q?wiyeM5w2MpdUFPw3jHFczuV0/tozp9c2Nh/9I2riYx4fPACXTj1yqxDkOQ49?=
 =?us-ascii?Q?fxIl2J1iVuQBHbzXzY9jSfm9kgy06q6Doj4oRIzQWaq55gdkzbkWk7GgLDUZ?=
 =?us-ascii?Q?Fpx3HSDSHgWDeyEo6euuoAM7iP7j1voAs6dCme38xdlIbS6bu4lr5fj4SAHn?=
 =?us-ascii?Q?83FBcCop/gWRRCO2/Q/m+I7Gx4Qo9oSUYc94CTsHUa7UUVafHUlEs3oiLQfi?=
 =?us-ascii?Q?hnM+IgyAa8xefn8tFoiAq6KqsVVdPxym6vUiNcbVsYSwD7yqUVVWQn39tDCR?=
 =?us-ascii?Q?HTQ5/4vek6rSKbaIB30jCbqABT43FUHQfNQ26qFz9uUrLtEvQUrm6fvOEqmq?=
 =?us-ascii?Q?2MAdK+IM0suQ44KhydP1oyGEAuYWZ7Uffl3xkUEqf+t4vL8WN2EfLjsK7Zaa?=
 =?us-ascii?Q?BdvkWLjVVfSERASItSU+PK0e6tEZw6XsJyA+IXxmHmSjsYbDvVruYeVsHf3s?=
 =?us-ascii?Q?DY4b547Gk4/vldcpPYJk8TYcJD8skDZK7ehT5ANjC5OCpDWuEMSsvbkxge6y?=
 =?us-ascii?Q?xA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 835598eb-5d34-4d48-0fec-08ddffed61a8
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 06:48:36.8809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ly5FKLLcLHpDgBBOcNjAHCttb2YFHS7A+5l0MHG02r8oo4xKoBTE1PlYQAHVkonHd2cZRRvhvc9yCk+dloPS4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4636
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "BUG:spinlock_bad_magic_on_CPU" on:

commit: e5a4cc28a052369b6e56b0a9ac05d9b9d5607b06 ("tracing: fprobe: use rhltable for fprobe_ip_table")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

in testcase: boot

config: x86_64-randconfig-072-20250929
compiler: gcc-14
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202509301440.be4b3631-lkp@intel.com


[   30.894986][   T66] BUG: spinlock bad magic on CPU#0, modprobe/66
[ 30.896030][ T66] lock: fprobe_ip_table+0x110/0x180, .magic: 00000000, .owner: <none>/-1, .owner_cpu: 0 
[   30.898263][   T66] CPU: 0 UID: 0 PID: 66 Comm: modprobe Not tainted 6.17.0-rc6-00004-ge5a4cc28a052 #1 NONE  5e106928d64815a8c70ffa200d16301537e1528f
[   30.898799][   T66] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   30.898799][   T66] Call Trace:
[   30.898799][   T66]  <TASK>
[ 30.898799][ T66] show_stack (arch/x86/kernel/dumpstack.c:319) 
[ 30.898799][ T66] dump_stack_lvl (lib/dump_stack.c:122) 
[ 30.898799][ T66] dump_stack (lib/dump_stack.c:130) 
[ 30.898799][ T66] spin_dump (kernel/locking/spinlock_debug.c:71) 
[ 30.898799][ T66] do_raw_spin_lock.cold (kernel/locking/spinlock_debug.c:78 kernel/locking/spinlock_debug.c:86 kernel/locking/spinlock_debug.c:115) 
[ 30.898799][ T66] _raw_spin_lock (kernel/locking/spinlock.c:155) 
[ 30.898799][ T66] ? rhashtable_walk_enter (lib/rhashtable.c:687) 
[ 30.898799][ T66] rhashtable_walk_enter (lib/rhashtable.c:687) 
[ 30.898799][ T66] fprobe_module_callback (kernel/trace/fprobe.c:478) 
[ 30.898799][ T66] ? _mutex_trylock_nest_lock (kernel/locking/mutex.c:916) 
[ 30.898799][ T66] ? fprobe_addr_list_add+0x4a0/0x4a0 
[ 30.898799][ T66] ? mutex_unlock (kernel/locking/mutex.c:537) 
[ 30.898799][ T66] notifier_call_chain (kernel/notifier.c:85) 
[ 30.898799][ T66] blocking_notifier_call_chain (kernel/notifier.c:381 kernel/notifier.c:368) 
[ 30.898799][ T66] do_init_module (kernel/module/main.c:3134) 
[ 30.898799][ T66] ? free_module (kernel/module/main.c:3011) 
[ 30.898799][ T66] load_module (kernel/module/main.c:3509) 
[ 30.898799][ T66] init_module_from_file (kernel/module/main.c:3701) 
[ 30.898799][ T66] ? __ia32_sys_init_module (kernel/module/main.c:3677) 
[ 30.898799][ T66] ? ftrace_likely_update (arch/x86/include/asm/smap.h:53 kernel/trace/trace_branch.c:223) 
[ 30.898799][ T66] ? do_raw_spin_unlock (kernel/locking/spinlock_debug.c:103 (discriminator 4) kernel/locking/spinlock_debug.c:141 (discriminator 4)) 
[ 30.898799][ T66] idempotent_init_module (kernel/module/main.c:3636 kernel/module/main.c:3714) 
[ 30.898799][ T66] ? tracer_hardirqs_on (kernel/trace/trace_irqsoff.c:643) 
[ 30.898799][ T66] ? init_module_from_file (kernel/module/main.c:3705) 
[ 30.898799][ T66] ? ftrace_likely_update (arch/x86/include/asm/smap.h:53 kernel/trace/trace_branch.c:223) 
[ 30.898799][ T66] __x64_sys_finit_module (include/linux/file.h:62 (discriminator 3) include/linux/file.h:83 (discriminator 3) kernel/module/main.c:3736 (discriminator 3) kernel/module/main.c:3723 (discriminator 3) kernel/module/main.c:3723 (discriminator 3)) 
[ 30.898799][ T66] x64_sys_call (arch/x86/entry/syscall_64.c:41) 
[ 30.898799][ T66] do_syscall_64 (arch/x86/entry/syscall_64.c:63 (discriminator 1) arch/x86/entry/syscall_64.c:94 (discriminator 1)) 
[ 30.898799][ T66] ? ksys_read (fs/read_write.c:705) 
[ 30.898799][ T66] ? vfs_write (fs/read_write.c:705) 
[ 30.898799][ T66] ? build_open_flags (fs/open.c:1420) 
[ 30.898799][ T66] ? ftrace_likely_update (arch/x86/include/asm/smap.h:53 kernel/trace/trace_branch.c:223) 
[ 30.898799][ T66] ? tracer_hardirqs_on (kernel/trace/trace_irqsoff.c:643) 
[ 30.898799][ T66] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4678) 
[ 30.898799][ T66] ? do_syscall_64 (arch/x86/entry/syscall_64.c:113) 
[ 30.898799][ T66] ? __x64_sys_openat (fs/open.c:1461) 
[ 30.898799][ T66] ? __x64_sys_open (fs/open.c:1461) 
[ 30.898799][ T66] ? ftrace_likely_update (arch/x86/include/asm/smap.h:53 kernel/trace/trace_branch.c:223) 
[ 30.898799][ T66] ? tracer_hardirqs_on (kernel/trace/trace_irqsoff.c:643) 
[ 30.898799][ T66] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4678) 
[ 30.898799][ T66] ? do_syscall_64 (arch/x86/entry/syscall_64.c:113) 
[ 30.898799][ T66] ? tracer_hardirqs_on (kernel/trace/trace_irqsoff.c:643) 
[ 30.898799][ T66] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:4678) 
[ 30.898799][ T66] ? do_syscall_64 (arch/x86/entry/syscall_64.c:113) 
[ 30.898799][ T66] ? irqentry_exit (kernel/entry/common.c:210) 
[ 30.898799][ T66] ? exc_page_fault (arch/x86/mm/fault.c:1536) 
[ 30.898799][ T66] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130) 
[   30.898799][   T66] RIP: 0033:0x7f46bce10719
[ 30.898799][ T66] Code: 08 89 e8 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d b7 06 0d 00 f7 d8 64 89 01 48
All code
========
   0:	08 89 e8 5b 5d c3    	or     %cl,-0x3ca2a418(%rcx)
   6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
   d:	00 00 00 
  10:	90                   	nop
  11:	48 89 f8             	mov    %rdi,%rax
  14:	48 89 f7             	mov    %rsi,%rdi
  17:	48 89 d6             	mov    %rdx,%rsi
  1a:	48 89 ca             	mov    %rcx,%rdx
  1d:	4d 89 c2             	mov    %r8,%r10
  20:	4d 89 c8             	mov    %r9,%r8
  23:	4c 8b 4c 24 08       	mov    0x8(%rsp),%r9
  28:	0f 05                	syscall
  2a:*	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax		<-- trapping instruction
  30:	73 01                	jae    0x33
  32:	c3                   	ret
  33:	48 8b 0d b7 06 0d 00 	mov    0xd06b7(%rip),%rcx        # 0xd06f1
  3a:	f7 d8                	neg    %eax
  3c:	64 89 01             	mov    %eax,%fs:(%rcx)
  3f:	48                   	rex.W

Code starting with the faulting instruction
===========================================
   0:	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax
   6:	73 01                	jae    0x9
   8:	c3                   	ret
   9:	48 8b 0d b7 06 0d 00 	mov    0xd06b7(%rip),%rcx        # 0xd06c7
  10:	f7 d8                	neg    %eax
  12:	64 89 01             	mov    %eax,%fs:(%rcx)
  15:	48                   	rex.W
[   30.898799][   T66] RSP: 002b:00007ffc679745b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[   30.898799][   T66] RAX: ffffffffffffffda RBX: 00005640c34b9160 RCX: 00007f46bce10719
[   30.898799][   T66] RDX: 0000000000000000 RSI: 00005640aa9b74a0 RDI: 0000000000000004
[   30.898799][   T66] RBP: 00005640aa9b74a0 R08: 0000000000000000 R09: 00005640c34ba430
[   30.898799][   T66] R10: 0000000000000004 R11: 0000000000000246 R12: 0000000000040000
[   30.898799][   T66] R13: 0000000000000000 R14: 00005640c34b83a0 R15: 0000000000000000
[   30.898799][   T66]  </TASK>
[   30.963748][   T66] Oops: general protection fault, probably for non-canonical address 0xdffffc0000000002: 0000 [#1] KASAN
[   30.964694][   T66] KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
[   30.964694][   T66] CPU: 0 UID: 0 PID: 66 Comm: modprobe Not tainted 6.17.0-rc6-00004-ge5a4cc28a052 #1 NONE  5e106928d64815a8c70ffa200d16301537e1528f
[   30.964694][   T66] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[ 30.964694][ T66] RIP: 0010:rhashtable_walk_enter (include/linux/list.h:169 lib/rhashtable.c:688) 
[ 30.964694][ T66] Code: c1 ea 03 80 3c 02 00 0f 85 2b 02 00 00 4d 89 77 28 4d 8d 6e 10 48 b8 00 00 00 00 00 fc ff df 4d 8d 67 18 4c 89 ea 48 c1 ea 03 <80> 3c 02 00 0f 85 f7 01 00 00 49 8b 5e 10 48 8d 43 08 48 89 c2 48
All code
========
   0:	c1 ea 03             	shr    $0x3,%edx
   3:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
   7:	0f 85 2b 02 00 00    	jne    0x238
   d:	4d 89 77 28          	mov    %r14,0x28(%r15)
  11:	4d 8d 6e 10          	lea    0x10(%r14),%r13
  15:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  1c:	fc ff df 
  1f:	4d 8d 67 18          	lea    0x18(%r15),%r12
  23:	4c 89 ea             	mov    %r13,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
  2a:*	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)		<-- trapping instruction
  2e:	0f 85 f7 01 00 00    	jne    0x22b
  34:	49 8b 5e 10          	mov    0x10(%r14),%rbx
  38:	48 8d 43 08          	lea    0x8(%rbx),%rax
  3c:	48 89 c2             	mov    %rax,%rdx
  3f:	48                   	rex.W

Code starting with the faulting instruction
===========================================
   0:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
   4:	0f 85 f7 01 00 00    	jne    0x201
   a:	49 8b 5e 10          	mov    0x10(%r14),%rbx
   e:	48 8d 43 08          	lea    0x8(%rbx),%rax
  12:	48 89 c2             	mov    %rax,%rdx
  15:	48                   	rex.W


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250930/202509301440.be4b3631-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

