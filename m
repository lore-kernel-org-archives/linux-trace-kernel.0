Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3516437C0F3;
	Wed, 15 Jul 2026 14:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784124908; cv=fail; b=AC1yWFuW1DRVufN8Z4DVotTPMQltg+n2fsm8N7WpXrMvD2bhNPHqj41jjNt5NaqDMihQfGfMZQ/Jtws8mp4zUTA3DvuKvoHJ+M67UB4PSQmNkoTOUVgXmatnNKFSiS1Vnv30cgxaACJspy41Yx3PZUbVJ3LRukHIShmNdjeOqy0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784124908; c=relaxed/simple;
	bh=HV4BA5BnWAVRFJOB30r3JY8hgqYOKiUKGdExJW9y94U=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=PfEjbLdCq1IGU98lNLv6O7/O3ImyGO2uzwhCJIagnoEV1uf7MkrSMwTx05WOd63bQ5QtULKD/BEQ02Il2OvCyzst1fRGN2UGbJSTc5Qywh28SrdQWuE2S8aCHlcyeQ/i4DN3jBYmMoxCi/SE+zMtpS5NySaXyFRBXwhfF5G3Ud0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D/CaNlqC; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D/CaNlqC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784124891; x=1815660891;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=HV4BA5BnWAVRFJOB30r3JY8hgqYOKiUKGdExJW9y94U=;
  b=D/CaNlqCuudTxnH+dMCBCObkxt7PxwoGvEyoWD84HQuQH2gSPBuS65lJ
   HZDHvEG3/oR0EAAOanpuC/XXYv23bTEju7BBAX9PVjqB0XT379O1zPMdq
   T4hohYJJ8VZeJuDC7kP4FfwvhiWR0SW3VTBhiKawMcy6p7YM+rOgXjWqB
   wEJPkTh9n4olh3w88aIRlG6IeulfHcxy/iFnH+AXaozi3kE4XeTYo0hv+
   li3VKg1kjg0q9duUYmoqgjsiWOvZrXIYyPoSbmE94jiEo9oOePyOMYaBl
   uCNrV9UD73BK5nCncx0Qmk2Xv/gtFQdM+Fg6liAfEG9FEpHOY2tbpF59T
   A==;
X-CSE-ConnectionGUID: 4nKZEPVIRyyqyv5n1Qf+2g==
X-CSE-MsgGUID: XRAV/sBcSx2P2LvvZ3vJ8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="83884504"
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="xz'341?scan'341,208,341";a="83884504"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 07:14:47 -0700
X-CSE-ConnectionGUID: 6abJFVARTtaS75i0QW8llg==
X-CSE-MsgGUID: j1UQeOq4S9CDWa4yqO+FRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="xz'341?scan'341,208,341";a="249831511"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 07:14:47 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 15 Jul 2026 07:14:45 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 15 Jul 2026 07:14:45 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.55) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 15 Jul 2026 07:14:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MgTCSIeErNSUPT60HJ7aAIdTA9KJGTl5pdXnKW6py/0pi+/pTOA/FOg0Wvp0brAY6vP6EJUyLlscTRJ7d9DdB/fGQVUgBXtj3cuq5iAIv9tXzfBKVf3WIRhSShGDO2QcLI553r5dynvTLnJpCcYHBYioU9JqoCaO13UdW//nxyKAZ2tP5A97E25PG3J21bVwNeHKJsJ87/E35AZqZnOuHflsszvF3xYWPFfMzcDeTOHkL97sNgOTCQc6nR4wT+6ujx9X2FrMDcoiHhLgCF+wUabyDQTC01a0naRRkGFuDPgbybGIj/xyPKm1VSBESVNpSotqASXiafkFtbOFe/lmSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eV9jK7uLHHYoWvaxz3uAn+FbjfjRvvRTYdXONczXIMc=;
 b=nmZPAgYbKnUz+owTlusAyD462DXomSaD6dyar5znCxy1jbXrlCM1zmcOhLQ07JL7SHpR6Y5GQUhz8AqZxNitrke6rkQUanKMsE7CTWzfiOvRr30OE/XxqQkma0GjsVxXBnIDuRFHXIv54ZOzjrw6iXH4+ni1EnIULkU8UAhwSZtasU0WnOIQ/lUd4u6Z8HIXlIO1nzCmYqLCw1WDFwFazog/MryzsHBCFH3TuxBg6TRv8YHRMbSddYrPznV8m1StD3Z85ogZlgOsKsx+9spqOb3gZXUlG7pLDPIQTcqwFexFNiySvwRxM0+SDxifqbFTpWXeLTmCUrAzstaEA49ZsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5832.namprd11.prod.outlook.com (2603:10b6:510:141::7)
 by DSWPR11MB9583.namprd11.prod.outlook.com (2603:10b6:8:36e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Wed, 15 Jul
 2026 14:14:29 +0000
Received: from PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707]) by PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707%5]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 14:14:29 +0000
Date: Wed, 15 Jul 2026 22:14:20 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Martin Kaiser <martin@kaiser.cx>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linus:master] [tracing]  206b25c090:
 kselftests-bpf.ftrace.ftracetest-ktap.Generic_dynamic_event_-_add/remove_eprobe_events.fail
Message-ID: <202607151010.b68428e1-lkp@intel.com>
Content-Type: multipart/mixed; boundary="rsArGZbvv6T0absu"
Content-Disposition: inline
User-Agent: s-nail v14.9.25
X-ClientProxiedBy: KUZPR04CA0024.apcprd04.prod.outlook.com
 (2603:1096:d10:25::6) To PH0PR11MB5832.namprd11.prod.outlook.com
 (2603:10b6:510:141::7)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5832:EE_|DSWPR11MB9583:EE_
X-MS-Office365-Filtering-Correlation-Id: c5f36813-6c6f-4583-67bb-08dee27b6206
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|6049299003|376014|11063799006|56012099006|6133799003|5023799004|10067099003|3023799007|18002099003|4053099003;
X-Microsoft-Antispam-Message-Info: 8+lhaStTDGiGhj3DJ5EuTzi/h2F1x3d8wZsU1QWD8zBtsobmGTn4Gyc+mb9bh/+ZlQkWF4AxeUNLq75iQCSCnCkdgR8iCUr3yYxPGT+wTa8oQTJruML1tEkBjPgXS3BuT0smRDznFEAhJ4rNNZ78igdP+XD7LTW2O2YdMKjnsQrri9ylMa7C+4v84Auf9pPKAFVovRlB251EwNyH/Bwz7wh99fcIS/RQ94Gvh3ucZDoDuebJO5iH/0ArRoeyFlKDfEOnHENXuvKs3JV0N8elGMRcC/sTOHmd5LbLMfRWzsEoSk/MtYlK2lGlf5aFo76uznfNoDE57WN4N5aVWGmy40zAi1tao2FaObwuhxqOdzC3bWIaBdDcMCfdORGww8BJ7IOwpyt28mDy/OwT7JDtFfkjZIUidb6kQwwEyfYHl8CDvlL4RhJ6Yi4mTSD2Spbq2w6020+3LHbHP17SpYItuZIU41O7HCT/yigq5eV6vn+naeK3H7SFfNM0SqHB6QFbCmaAGuCtduG/q0gxzIEauz4nmIsQHTP7/QoTO17iu5lLvPuu/tl0xidesCeyvIfEw+tDfo+FHfN4eKd+0d9XUbfhnagBrc+LD2SJxP2k7IJc5pekDP2hYLFTmjknm1Zb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5832.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(6049299003)(376014)(11063799006)(56012099006)(6133799003)(5023799004)(10067099003)(3023799007)(18002099003)(4053099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Yj1p6iY7JfMr5KvhN6VfHJMJWvAGoRQXcB4vFHmPWutR1Asj9XBFMsSFchIc?=
 =?us-ascii?Q?Wo0hU8F6BUEodolLoe6O7ZaiEOl9UbdKISOl6szocfyqKn1Z3643arhnOwPY?=
 =?us-ascii?Q?xpVBlIgRTYtfRdZ9sMlz19YndIohaDQ+tkQwhW8e/YICi92Sfr1XzTGKzHAg?=
 =?us-ascii?Q?oRvt0rQGqa6cSJItYs2IDklY7tSsi4ZHHXsiRsbiYmQZ7Gt+KJ/uu5ueFDWP?=
 =?us-ascii?Q?msc0BhNIAL42y5/7ZO2A9cym0NbDfw9+MdyWgtzXK7tKsARdBuOxlyPFfP2y?=
 =?us-ascii?Q?V/TzRql7Vnfl3ZGrsXxNVqueTfy9lYLWilsMj8f8nI2SPbxpB08p0OAwGNyG?=
 =?us-ascii?Q?IM/UpgrQyTWdiFV57GzFUEKjbEDfzPOdzsknu5MXmhBATmVGfyGLoIHDuuHQ?=
 =?us-ascii?Q?QGrAdpG1lHmovDUdP0UMEj0L4QhGx/OkVrsjRBw+oY2U8Mj2QoM4PR6Y851F?=
 =?us-ascii?Q?/B3lhkb9LrtXhnP2YJc8BMTdz75HQLmo/fTNYEQPUXrsJBs7+PwkeGkoGmg0?=
 =?us-ascii?Q?YYLxcCMk/rvFVJjQOVfb3aEX3KiPcvh5L8RGNDqBD1UOVbFuRsQjPtoleT8C?=
 =?us-ascii?Q?1JrryaDUxdasA41RXLYfcZMnkK6gEMj18KGdkS7S4b4MFgDWxDoSP2UndeSd?=
 =?us-ascii?Q?W3Bk00e9dSOp5M19y8Ta1XcBFf/rxxkDAvpPhA1FoSQgE5DLlubrBY4q1QCn?=
 =?us-ascii?Q?gSA/1tEBLOzo3AZbbkLlOSzLuNgCJas3fAPiKGkyMUo3OsCMQMJvrqAD4HKX?=
 =?us-ascii?Q?cX7YHfCWUzawvx8WNuwQxWonvePEFvptk+jsirthvVqb6vjrkrPy4C9D9m2a?=
 =?us-ascii?Q?WZMMzwziJNqvZpDrUv5/JyUiwcB07vxEhu+jJLwsP1oHQzQF8Rz6JA+9EAyL?=
 =?us-ascii?Q?cm3Ky19HiZUBoUBfiS8rAoA4Ovkq4DVM2RywHiHGdj3BaaiCANbaxvbYNO2Q?=
 =?us-ascii?Q?W7v1LN/huqonDwniP8rc4i+su7wyxIT/oSFXLTv2XAqQQuL4E94MnfzPE62Y?=
 =?us-ascii?Q?xUyrN0UQhi+KFE5vpL6JmkLZyG8D+DZxgA/X8F8vTaJJhbKZlnDt1RhNE/GY?=
 =?us-ascii?Q?vrQs5JUPFnbJODMJhxXjYs++W7MTjadWDrNu5XICBSMN6c6VsOnHciImS74j?=
 =?us-ascii?Q?qQrwufJx174PTG/E1lBUBPp/pGiulrR1TQxaWmNSaSpisWz5gFQmOnsNm67b?=
 =?us-ascii?Q?+PMSTp+fUmaxf4TmoHpuO7/9pBinjYSIbL0QETqx6Wsx6ZnHR7SxcVxZgfNR?=
 =?us-ascii?Q?w/t2M895pWi42oJp+f7eos/UIGnwAPHBHaevlElFIBZzzBuW4jz1KQLuQqms?=
 =?us-ascii?Q?b82ryzy+SYpYxaEkqtbotxL3jr1qFx2ZYQHpXm6B9wv5BLoqpqnPXtd3x8KN?=
 =?us-ascii?Q?2gH5J2OimVyABBc7cLKKf1hXlLeVEtrocnR393L92uCRM0Ma837OBJqqoRQd?=
 =?us-ascii?Q?TjxoeyRRrOzvbMP5TCAb2OHwD0vezpcOk9UIMGhvIk6Qs7S1fZJFdEDoOIAu?=
 =?us-ascii?Q?nTO9wQzOfXYokldQ19aB+ZFCJCmffjbCdCSTTHyUi8t3+Oku+5SKUYA/Qk2l?=
 =?us-ascii?Q?eYppPShdUZ4omX6kn+hi6iFBPFPu1n1WXeXwgrjSsGruTFKkqoACRBC4zuCi?=
 =?us-ascii?Q?MlYOnJZXQII4W1p9LStMlW+EaoFj2v5+hBiY6CfawcFBfigiusXo7ze0Llcf?=
 =?us-ascii?Q?a7P0mkV/Mnf7XWLIW4zS+7pE6bzZ2XrYa/+4gttoR4L4iGCftV8ImvIAZH+X?=
 =?us-ascii?Q?eZv8S5EaZg=3D=3D?=
X-Exchange-RoutingPolicyChecked: qnVem6e7ASSRsbxc9CVuQ6esqcSj3LG+CcD+/J/Q6KO75DQLHZhubDcCo0F0OVpyX2jkeqQyHoG4P2YjqkrQ1xYwaReVItkb2JazHI+3c8Gfqz6NpFCpiRTB9QQCtoB4yFa6wjN+3HGdSvEEtVnTqews988XJYIFZ2Ba/cZNSHeWPmUuqD+YzoPUaUdc4mqSyGfOp2Dd+wRMCTngJ+IOUC8D6gF2A1tKfK7IYvFsrQq7uqVpy732tYI85pDJtx3oNw9yqctp+YEAPeG2tibQZN4C2zmjL0ki7HVR5lg+9hJgir5sxuTZluuGPdbGl8jPLBv8zi7bnm6LQmvJUFk+1w==
X-MS-Exchange-CrossTenant-Network-Message-Id: c5f36813-6c6f-4583-67bb-08dee27b6206
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5832.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 14:14:29.6435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: butg6bpBFE9+qX8KfKewZXqUlap0NSvBQN1DcykeruLRJ/FkPW1VpjldGi+6ZR8PggI7r20NDhUjaUzVYMXPpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR11MB9583
X-OriginatorOrg: intel.com

--rsArGZbvv6T0absu
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable



Hello,

kernel test robot noticed "kselftests-bpf.ftrace.ftracetest-ktap.Generic_dy=
namic_event_-_add/remove_eprobe_events.fail" on:

commit: 206b25c09080cc20fd4c2bea12d59df4b7ba2121 ("tracing: eprobe: read th=
e complete FILTER_PTR_STRING pointer")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master      3b029c035b34bbc693405ddf759f0e9b920c27f1]
[test failed on linux-next/master 49362394dad7df66c274c867a271394c10ca2bb8]

in testcase: kselftests-bpf
version:=20
with following parameters:

	group: ftrace



config: x86_64-rhel-9.4-bpf
compiler: gcc-14
test machine: 16 threads Intel(R) Core(TM) i7-13620H (Raptor Lake) with 32G=
 memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new versio=
n of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202607151010.b68428e1-lkp@intel.co=
m


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260715/202607151010.b68428e1-lkp@=
intel.com


# not ok 17 Generic dynamic event - add/remove eprobe events
# # execute: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-206b25c09080cc20fd=
4c2bea12d59df4b7ba2121/tools/testing/selftests/ftrace/test.d/dynevent/add_r=
emove_eprobe.tc
# # + checkreq /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-206b25c09080cc20=
fd4c2bea12d59df4b7ba2121/tools/testing/selftests/ftrace/test.d/dynevent/add=
_remove_eprobe.tc
# # ++ grep '^#[ t]*requires:' /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-=
206b25c09080cc20fd4c2bea12d59df4b7ba2121/tools/testing/selftests/ftrace/tes=
t.d/dynevent/add_remove_eprobe.tc
# # ++ cut -f2- -d:
# # + requires=3D' dynamic_events events/syscalls/sys_enter_openat "<attach=
ed-group>.<attached-event> [<args>]":README'
# # + eval check_requires ' dynamic_events events/syscalls/sys_enter_openat=
 "<attached-group>.<attached-event> [<args>]":README'
# # ++ check_requires dynamic_events events/syscalls/sys_enter_openat '<att=
ached-group>.<attached-event> [<args>]:README'
# # ++ for i in "$@"
# # ++ p=3Ddynamic_events
# # ++ r=3Ddynamic_events
# # ++ t=3Ddynamic_events
# # ++ '[' dynamic_events '!=3D' dynamic_events ']'
# # ++ '[' dynamic_events '!=3D' dynamic_events ']'
# # ++ '[' dynamic_events '!=3D' dynamic_events ']'
# # ++ '[' '!' -e dynamic_events ']'
# # ++ for i in "$@"
# # ++ p=3Devents/syscalls/sys_enter_openat
# # ++ r=3Devents/syscalls/sys_enter_openat
# # ++ t=3Devents/syscalls/sys_enter_openat
# # ++ '[' events/syscalls/sys_enter_openat '!=3D' events/syscalls/sys_ente=
r_openat ']'
# # ++ '[' events/syscalls/sys_enter_openat '!=3D' events/syscalls/sys_ente=
r_openat ']'
# # ++ '[' events/syscalls/sys_enter_openat '!=3D' events/syscalls/sys_ente=
r_openat ']'
# # ++ '[' '!' -e events/syscalls/sys_enter_openat ']'
# # ++ for i in "$@"
# # ++ p=3D'<attached-group>.<attached-event> [<args>]:README'
# # ++ r=3D'<attached-group>.<attached-event> [<args>]'
# # ++ t=3D'<attached-group>.<attached-event> [<args>]:README'
# # ++ '[' '<attached-group>.<attached-event> [<args>]:README' '!=3D' '<att=
ached-group>.<attached-event> [<args>]:README' ']'
# # ++ '[' '<attached-group>.<attached-event> [<args>]:README' '!=3D' '<att=
ached-group>.<attached-event> [<args>]:README' ']'
# # ++ '[' '<attached-group>.<attached-event> [<args>]' '!=3D' '<attached-g=
roup>.<attached-event> [<args>]:README' ']'
# # ++ echo /sys/kernel/tracing
# # ++ grep -q /instances/
# # ++ test=3D/sys/kernel/tracing
# # ++ grep -Fq '<attached-group>.<attached-event> [<args>]' /sys/kernel/tr=
acing/README
# # + initialize_system
# # + disable_tracing
# # + echo 0
# # + reset_tracer
# # + echo nop
# # + reset_trigger
# # + '[' -d events/synthetic ']'
# # + reset_trigger_file events/9p/9p_client_req/trigger events/9p/9p_clien=
t_res/trigger events/9p/9p_fid_ref/trigger events/9p/9p_protocol_dump/trigg=
er events/alarmtimer/alarmtimer_cancel/trigger events/alarmtimer/alarmtimer=
_fired/trigger events/alarmtimer/alarmtimer_start/trigger events/alarmtimer=
/alarmtimer_suspend/trigger events/amd_cpu/amd_pstate_cppc_req2/trigger eve=
nts/amd_cpu/amd_pstate_epp_perf/trigger events/amd_cpu/amd_pstate_perf/trig=
ger events/asoc/snd_soc_bias_level_done/trigger events/asoc/snd_soc_bias_le=
vel_start/trigger events/asoc/snd_soc_dapm_connected/trigger events/asoc/sn=
d_soc_dapm_done/trigger events/asoc/snd_soc_dapm_path/trigger events/asoc/s=
nd_soc_dapm_start/trigger events/asoc/snd_soc_dapm_walk_done/trigger events=
/asoc/snd_soc_dapm_widget_event_done/trigger events/asoc/snd_soc_dapm_widge=
t_event_start/trigger events/asoc/snd_soc_dapm_widget_power/trigger events/=
asoc/snd_soc_jack_irq/trigger events/asoc/snd_soc_jack_notify/trigger event=
s/asoc/snd_soc_jack_report/trigger events/avc/selinux_audited/trigger event=
s/block/blk_zone_append_update_request_bio/trigger events/block/blk_zone_wp=
lug_bio/trigger events/block/blkdev_zone_mgmt/trigger events/block/block_bi=
o_backmerge/trigger events/block/block_bio_complete/trigger events/block/bl=
ock_bio_frontmerge/trigger events/block/block_bio_queue/trigger events/bloc=
k/block_bio_remap/trigger events/block/block_dirty_buffer/trigger events/bl=
ock/block_getrq/trigger events/block/block_io_done/trigger events/block/blo=
ck_io_start/trigger events/block/block_plug/trigger events/block/block_rq_c=
omplete/trigger events/block/block_rq_error/trigger events/block/block_rq_i=
nsert/trigger events/block/block_rq_issue/trigger events/block/block_rq_mer=
ge/trigger events/block/block_rq_remap/trigger events/block/block_rq_requeu=
e/trigger events/block/block_rq_tag_wait/trigger events/block/block_split/t=
rigger events/block/block_touch_buffer/trigger events/block/block_unplug/tr=
igger events/block/disk_zone_wplug_add_bio/trigger events/bpf_test_run/bpf_=
test_finish/trigger events/bpf_test_run/bpf_trigger_tp/trigger events/bpf_t=
race/bpf_trace_printk/trigger events/bridge/br_fdb_add/trigger events/bridg=
e/br_fdb_external_learn_add/trigger events/bridge/br_fdb_update/trigger eve=
nts/bridge/br_mdb_full/trigger events/bridge/fdb_delete/trigger events/btrf=
s/add_delayed_data_ref/trigger events/btrfs/add_delayed_ref_head/trigger ev=
ents/btrfs/add_delayed_tree_ref/trigger events/btrfs/btrfs_add_block_group/=
trigger events/btrfs/btrfs_add_conflicting_inode_enter/trigger events/btrfs=
/btrfs_add_conflicting_inode_exit/trigger events/btrfs/btrfs_add_reclaim_bl=
ock_group/trigger events/btrfs/btrfs_add_unused_block_group/trigger events/=
btrfs/btrfs_all_work_done/trigger events/btrfs/btrfs_alloc_extent_state/tri=
gger events/btrfs/btrfs_chunk_alloc/trigger events/btrfs/btrfs_chunk_free/t=
rigger events/btrfs/btrfs_clear_extent_bit/trigger events/btrfs/btrfs_conve=
rt_extent_bit/trigger events/btrfs/btrfs_cow_block/trigger events/btrfs/btr=
fs_done_preemptive_reclaim/trigger events/btrfs/btrfs_extent_map_shrinker_c=
ount/trigger events/btrfs/btrfs_extent_map_shrinker_remove_em/trigger event=
s/btrfs/btrfs_extent_map_shrinker_scan_enter/trigger events/btrfs/btrfs_ext=
ent_map_shrinker_scan_exit/trigger events/btrfs/btrfs_fail_all_tickets/trig=
ger events/btrfs/btrfs_failed_cluster_setup/trigger events/btrfs/btrfs_find=
_cluster/trigger events/btrfs/btrfs_find_free_extent/trigger events/btrfs/b=
trfs_find_free_extent_have_block_group/trigger events/btrfs/btrfs_find_free=
_extent_search_loop/trigger events/btrfs/btrfs_finish_ordered_extent/trigge=
r events/btrfs/btrfs_flush_space/trigger events/btrfs/btrfs_free_extent_sta=
te/trigger events/btrfs/btrfs_get_extent/trigger events/btrfs/btrfs_get_ext=
ent_show_fi_inline/trigger events/btrfs/btrfs_get_extent_show_fi_regular/tr=
igger events/btrfs/btrfs_get_raid_extent_offset/trigger events/btrfs/btrfs_=
handle_em_exist/trigger events/btrfs/btrfs_inode_evict/trigger events/btrfs=
/btrfs_inode_mod_outstanding_extents/trigger events/btrfs/btrfs_inode_new/t=
rigger events/btrfs/btrfs_inode_request/trigger events/btrfs/btrfs_insert_o=
ne_raid_extent/trigger events/btrfs/btrfs_log_all_new_ancestors_enter/trigg=
er events/btrfs/btrfs_log_all_new_ancestors_exit/trigger events/btrfs/btrfs=
_log_all_parents_enter/trigger events/btrfs/btrfs_log_all_parents_exit/trig=
ger events/btrfs/btrfs_log_conflicting_inodes_enter/trigger events/btrfs/bt=
rfs_log_conflicting_inodes_exit/trigger events/btrfs/btrfs_log_inode_enter/=
trigger events/btrfs/btrfs_log_inode_exit/trigger events/btrfs/btrfs_log_in=
ode_parent_enter/trigger events/btrfs/btrfs_log_inode_parent_exit/trigger e=
vents/btrfs/btrfs_log_new_delayed_dentries_enter/trigger events/btrfs/btrfs=
_log_new_delayed_dentries_exit/trigger events/btrfs/btrfs_log_new_dir_dentr=
ies_enter/trigger events/btrfs/btrfs_log_new_dir_dentries_exit/trigger even=
ts/btrfs/btrfs_log_new_name_enter/trigger events/btrfs/btrfs_log_new_name_e=
xit/trigger events/btrfs/btrfs_ordered_extent_add/trigger events/btrfs/btrf=
s_ordered_extent_dec_test_pending/trigger events/btrfs/btrfs_ordered_extent=
_lookup/trigger events/btrfs/btrfs_ordered_extent_lookup_first/trigger even=
ts/btrfs/btrfs_ordered_extent_lookup_first_range/trigger events/btrfs/btrfs=
_ordered_extent_lookup_for_logging/trigger events/btrfs/btrfs_ordered_exten=
t_lookup_range/trigger events/btrfs/btrfs_ordered_extent_mark_finished/trig=
ger events/btrfs/btrfs_ordered_extent_put/trigger events/btrfs/btrfs_ordere=
d_extent_remove/trigger events/btrfs/btrfs_ordered_extent_split/trigger eve=
nts/btrfs/btrfs_ordered_extent_start/trigger events/btrfs/btrfs_ordered_sch=
ed/trigger events/btrfs/btrfs_prelim_ref_insert/trigger events/btrfs/btrfs_=
prelim_ref_merge/trigger events/btrfs/btrfs_qgroup_account_extent/trigger e=
vents/btrfs/btrfs_qgroup_account_extents/trigger events/btrfs/btrfs_qgroup_=
meta_convert/trigger events/btrfs/btrfs_qgroup_meta_free_all_pertrans/trigg=
er events/btrfs/btrfs_qgroup_meta_reserve/trigger events/btrfs/btrfs_qgroup=
_num_dirty_extents/trigger events/btrfs/btrfs_qgroup_release_data/trigger e=
vents/btrfs/btrfs_qgroup_reserve_data/trigger events/btrfs/btrfs_qgroup_tra=
ce_extent/trigger events/btrfs/btrfs_qgroup_update_counters/trigger events/=
btrfs/btrfs_qgroup_update_reserve/trigger events/btrfs/btrfs_raid_extent_de=
lete/trigger events/btrfs/btrfs_reclaim_block_group/trigger events/btrfs/bt=
rfs_record_new_subvolume/trigger events/btrfs/btrfs_record_snapshot_destroy=
/trigger events/btrfs/btrfs_record_unlink_dir/trigger events/btrfs/btrfs_re=
move_block_group/trigger events/btrfs/btrfs_reserve_extent/trigger events/b=
trfs/btrfs_reserve_extent_cluster/trigger events/btrfs/btrfs_reserve_ticket=
/trigger events/btrfs/btrfs_reserved_extent_alloc/trigger events/btrfs/btrf=
s_reserved_extent_free/trigger events/btrfs/btrfs_search_slot_restart/trigg=
er events/btrfs/btrfs_set_extent_bit/trigger events/btrfs/btrfs_setup_clust=
er/trigger events/btrfs/btrfs_skip_unused_block_group/trigger events/btrfs/=
btrfs_space_reservation/trigger events/btrfs/btrfs_sync_file_enter/trigger =
events/btrfs/btrfs_sync_file_exit/trigger events/btrfs/btrfs_sync_fs/trigge=
r events/btrfs/btrfs_sync_log_enter/trigger events/btrfs/btrfs_sync_log_exi=
t/trigger events/btrfs/btrfs_transaction_abort/trigger events/btrfs/btrfs_t=
ransaction_commit/trigger events/btrfs/btrfs_transaction_start/trigger even=
ts/btrfs/btrfs_tree_lock/trigger events/btrfs/btrfs_tree_read_lock/trigger =
events/btrfs/btrfs_tree_read_unlock/trigger events/btrfs/btrfs_tree_unlock/=
trigger events/btrfs/btrfs_trigger_flush/trigger events/btrfs/btrfs_truncat=
e_show_fi_inline/trigger events/btrfs/btrfs_truncate_show_fi_regular/trigge=
r events/btrfs/btrfs_try_tree_read_lock/trigger events/btrfs/btrfs_work_que=
ued/trigger events/btrfs/btrfs_work_sched/trigger events/btrfs/btrfs_workqu=
eue_alloc/trigger events/btrfs/btrfs_workqueue_destroy/trigger events/btrfs=
/btrfs_writepage_end_io_hook/trigger events/btrfs/extent_writepage/trigger =
events/btrfs/raid56_read/trigger events/btrfs/raid56_write/trigger events/b=
trfs/run_delayed_data_ref/trigger events/btrfs/run_delayed_ref_head/trigger=
 events/btrfs/run_delayed_tree_ref/trigger events/btrfs/update_bytes_may_us=
e/trigger events/btrfs/update_bytes_pinned/trigger events/btrfs/update_byte=
s_zone_unusable/trigger events/capability/cap_capable/trigger events/cfg802=
11/cfg80211_assoc_comeback/trigger events/cfg80211/cfg80211_bss_color_notif=
y/trigger events/cfg80211/cfg80211_cac_event/trigger events/cfg80211/cfg802=
11_ch_switch_notify/trigger events/cfg80211/cfg80211_ch_switch_started_noti=
fy/trigger events/cfg80211/cfg80211_control_port_tx_status/trigger events/c=
fg80211/cfg80211_cqm_pktloss_notify/trigger events/cfg80211/cfg80211_cqm_rs=
si_notify/trigger events/cfg80211/cfg80211_del_sta/trigger events/cfg80211/=
cfg80211_epcs_changed/trigger events/cfg80211/cfg80211_ft_event/trigger eve=
nts/cfg80211/cfg80211_get_bss/trigger events/cfg80211/cfg80211_gtk_rekey_no=
tify/trigger events/cfg80211/cfg80211_ibss_joined/trigger events/cfg80211/c=
fg80211_incumbent_signal_notify/trigger events/cfg80211/cfg80211_inform_bss=
_frame/trigger events/cfg80211/cfg80211_links_removed/trigger events/cfg802=
11/cfg80211_mgmt_tx_status/trigger events/cfg80211/cfg80211_michael_mic_fai=
lure/trigger events/cfg80211/cfg80211_mlo_reconf_add_done/trigger events/cf=
g80211/cfg80211_nan_channel_evac/trigger events/cfg80211/cfg80211_nan_clust=
er_joined/trigger events/cfg80211/cfg80211_nan_sched_update_done/trigger ev=
ents/cfg80211/cfg80211_nan_ulw_update/trigger events/cfg80211/cfg80211_new_=
sta/trigger events/cfg80211/cfg80211_next_nan_dw_notif/trigger events/cfg80=
211/cfg80211_notify_new_peer_candidate/trigger events/cfg80211/cfg80211_pmk=
sa_candidate_notify/trigger events/cfg80211/cfg80211_pmsr_complete/trigger =
events/cfg80211/cfg80211_pmsr_report/trigger events/cfg80211/cfg80211_probe=
_status/trigger events/cfg80211/cfg80211_radar_event/trigger events/cfg8021=
1/cfg80211_ready_on_channel/trigger events/cfg80211/cfg80211_ready_on_chann=
el_expired/trigger events/cfg80211/cfg80211_reg_can_beacon/trigger events/c=
fg80211/cfg80211_report_obss_beacon/trigger events/cfg80211/cfg80211_report=
_wowlan_wakeup/trigger events/cfg80211/cfg80211_return_bool/trigger events/=
cfg80211/cfg80211_return_bss/trigger events/cfg80211/cfg80211_rx_control_po=
rt/trigger events/cfg80211/cfg80211_rx_mgmt/trigger events/cfg80211/cfg8021=
1_rx_mlme_mgmt/trigger events/cfg80211/cfg80211_rx_spurious_frame/trigger e=
vents/cfg80211/cfg80211_rx_unexpected_4addr_frame/trigger events/cfg80211/c=
fg80211_rx_unprot_mlme_mgmt/trigger events/cfg80211/cfg80211_scan_done/trig=
ger events/cfg80211/cfg80211_sched_scan_results/trigger events/cfg80211/cfg=
80211_sched_scan_stopped/trigger events/cfg80211/cfg80211_send_assoc_failur=
e/trigger events/cfg80211/cfg80211_send_auth_timeout/trigger events/cfg8021=
1/cfg80211_send_rx_assoc/trigger events/cfg80211/cfg80211_stop_link/trigger=
 events/cfg80211/cfg80211_tdls_oper_request/trigger events/cfg80211/cfg8021=
1_tx_mgmt_expired/trigger events/cfg80211/cfg80211_tx_mlme_mgmt/trigger eve=
nts/cfg80211/cfg80211_update_owe_info_event/trigger events/cfg80211/rdev_ab=
ort_pmsr/trigger events/cfg80211/rdev_abort_scan/trigger events/cfg80211/rd=
ev_add_intf_link/trigger events/cfg80211/rdev_add_key/trigger events/cfg802=
11/rdev_add_link_station/trigger events/cfg80211/rdev_add_mpath/trigger eve=
nts/cfg80211/rdev_add_nan_func/trigger events/cfg80211/rdev_add_station/tri=
gger events/cfg80211/rdev_add_tx_ts/trigger events/cfg80211/rdev_add_virtua=
l_intf/trigger events/cfg80211/rdev_assoc/trigger events/cfg80211/rdev_asso=
c_ml_reconf/trigger events/cfg80211/rdev_auth/trigger events/cfg80211/rdev_=
cancel_remain_on_channel/trigger events/cfg80211/rdev_change_beacon/trigger=
 events/cfg80211/rdev_change_bss/trigger events/cfg80211/rdev_change_mpath/=
trigger events/cfg80211/rdev_change_station/trigger events/cfg80211/rdev_ch=
ange_virtual_intf/trigger events/cfg80211/rdev_channel_switch/trigger event=
s/cfg80211/rdev_color_change/trigger events/cfg80211/rdev_connect/trigger e=
vents/cfg80211/rdev_crit_proto_start/trigger events/cfg80211/rdev_crit_prot=
o_stop/trigger events/cfg80211/rdev_deauth/trigger events/cfg80211/rdev_del=
_intf_link/trigger events/cfg80211/rdev_del_key/trigger events/cfg80211/rde=
v_del_link_station/trigger events/cfg80211/rdev_del_mpath/trigger events/cf=
g80211/rdev_del_nan_func/trigger events/cfg80211/rdev_del_pmk/trigger event=
s/cfg80211/rdev_del_pmksa/trigger events/cfg80211/rdev_del_station/trigger =
events/cfg80211/rdev_del_tx_ts/trigger events/cfg80211/rdev_del_virtual_int=
f/trigger events/cfg80211/rdev_disassoc/trigger events/cfg80211/rdev_discon=
nect/trigger events/cfg80211/rdev_dump_mpath/trigger events/cfg80211/rdev_d=
ump_mpp/trigger events/cfg80211/rdev_dump_station/trigger events/cfg80211/r=
dev_dump_survey/trigger events/cfg80211/rdev_end_cac/trigger events/cfg8021=
1/rdev_external_auth/trigger events/cfg80211/rdev_flush_pmksa/trigger event=
s/cfg80211/rdev_get_antenna/trigger events/cfg80211/rdev_get_channel/trigge=
r events/cfg80211/rdev_get_ftm_responder_stats/trigger events/cfg80211/rdev=
_get_key/trigger events/cfg80211/rdev_get_mesh_config/trigger events/cfg802=
11/rdev_get_mpath/trigger events/cfg80211/rdev_get_mpp/trigger events/cfg80=
211/rdev_get_station/trigger events/cfg80211/rdev_get_tx_power/trigger even=
ts/cfg80211/rdev_get_txq_stats/trigger events/cfg80211/rdev_inform_bss/trig=
ger events/cfg80211/rdev_join_ibss/trigger events/cfg80211/rdev_join_mesh/t=
rigger events/cfg80211/rdev_join_ocb/trigger events/cfg80211/rdev_leave_ibs=
s/trigger events/cfg80211/rdev_leave_mesh/trigger events/cfg80211/rdev_leav=
e_ocb/trigger events/cfg80211/rdev_libertas_set_mesh_channel/trigger events=
/cfg80211/rdev_mgmt_tx/trigger events/cfg80211/rdev_mgmt_tx_cancel_wait/tri=
gger events/cfg80211/rdev_mod_link_station/trigger events/cfg80211/rdev_nan=
_change_conf/trigger events/cfg80211/rdev_nan_set_local_sched/trigger event=
s/cfg80211/rdev_nan_set_peer_sched/trigger events/cfg80211/rdev_probe_clien=
t/trigger events/cfg80211/rdev_probe_mesh_link/trigger events/cfg80211/rdev=
_remain_on_channel/trigger events/cfg80211/rdev_reset_tid_config/trigger ev=
ents/cfg80211/rdev_resume/trigger events/cfg80211/rdev_return_chandef/trigg=
er events/cfg80211/rdev_return_int/trigger events/cfg80211/rdev_return_int_=
cookie/trigger events/cfg80211/rdev_return_int_int/trigger events/cfg80211/=
rdev_return_int_mesh_config/trigger events/cfg80211/rdev_return_int_mpath_i=
nfo/trigger events/cfg80211/rdev_return_int_station_info/trigger events/cfg=
80211/rdev_return_int_survey_info/trigger events/cfg80211/rdev_return_int_t=
x_rx/trigger events/cfg80211/rdev_return_void/trigger events/cfg80211/rdev_=
return_void_tx_rx/trigger events/cfg80211/rdev_return_wdev/trigger events/c=
fg80211/rdev_rfkill_poll/trigger events/cfg80211/rdev_scan/trigger events/c=
fg80211/rdev_sched_scan_start/trigger events/cfg80211/rdev_sched_scan_stop/=
trigger events/cfg80211/rdev_set_antenna/trigger events/cfg80211/rdev_set_a=
p_chanwidth/trigger events/cfg80211/rdev_set_bitrate_mask/trigger events/cf=
g80211/rdev_set_coalesce/trigger events/cfg80211/rdev_set_cqm_rssi_config/t=
rigger events/cfg80211/rdev_set_cqm_rssi_range_config/trigger events/cfg802=
11/rdev_set_cqm_txe_config/trigger events/cfg80211/rdev_set_default_beacon_=
key/trigger events/cfg80211/rdev_set_default_key/trigger events/cfg80211/rd=
ev_set_default_mgmt_key/trigger events/cfg80211/rdev_set_epcs/trigger event=
s/cfg80211/rdev_set_fils_aad/trigger events/cfg80211/rdev_set_hw_timestamp/=
trigger events/cfg80211/rdev_set_mac_acl/trigger events/cfg80211/rdev_set_m=
cast_rate/trigger events/cfg80211/rdev_set_monitor_channel/trigger events/c=
fg80211/rdev_set_multicast_to_unicast/trigger events/cfg80211/rdev_set_noac=
k_map/trigger events/cfg80211/rdev_set_pmk/trigger events/cfg80211/rdev_set=
_pmksa/trigger events/cfg80211/rdev_set_power_mgmt/trigger events/cfg80211/=
rdev_set_qos_map/trigger events/cfg80211/rdev_set_radar_background/trigger =
events/cfg80211/rdev_set_rekey_data/trigger events/cfg80211/rdev_set_sar_sp=
ecs/trigger events/cfg80211/rdev_set_tid_config/trigger events/cfg80211/rde=
v_set_ttlm/trigger events/cfg80211/rdev_set_tx_power/trigger events/cfg8021=
1/rdev_set_txq_params/trigger events/cfg80211/rdev_set_wakeup/trigger event=
s/cfg80211/rdev_set_wiphy_params/trigger events/cfg80211/rdev_start_ap/trig=
ger events/cfg80211/rdev_start_nan/trigger events/cfg80211/rdev_start_p2p_d=
evice/trigger events/cfg80211/rdev_start_pd/trigger events/cfg80211/rdev_st=
art_pmsr/trigger events/cfg80211/rdev_start_radar_detection/trigger events/=
cfg80211/rdev_stop_ap/trigger events/cfg80211/rdev_stop_nan/trigger events/=
cfg80211/rdev_stop_p2p_device/trigger events/cfg80211/rdev_stop_pd/trigger =
events/cfg80211/rdev_suspend/trigger events/cfg80211/rdev_tdls_cancel_chann=
el_switch/trigger events/cfg80211/rdev_tdls_channel_switch/trigger events/c=
fg80211/rdev_tdls_mgmt/trigger events/cfg80211/rdev_tdls_oper/trigger event=
s/cfg80211/rdev_tx_control_port/trigger events/cfg80211/rdev_update_connect=
_params/trigger events/cfg80211/rdev_update_ft_ies/trigger events/cfg80211/=
rdev_update_mesh_config/trigger events/cfg80211/rdev_update_mgmt_frame_regi=
strations/trigger events/cfg80211/rdev_update_owe_info/trigger events/cfg80=
211/wiphy_delayed_work_queue/trigger events/cfg80211/wiphy_hrtimer_work_que=
ue/trigger events/cfg80211/wiphy_work_cancel/trigger events/cfg80211/wiphy_=
work_flush/trigger events/cfg80211/wiphy_work_queue/trigger events/cfg80211=
/wiphy_work_run/trigger events/cfg80211/wiphy_work_worker_start/trigger eve=
nts/cgroup/cgroup_attach_task/trigger events/cgroup/cgroup_destroy_root/tri=
gger events/cgroup/cgroup_freeze/trigger events/cgroup/cgroup_mkdir/trigger=
 events/cgroup/cgroup_notify_frozen/trigger events/cgroup/cgroup_notify_pop=
ulated/trigger events/cgroup/cgroup_release/trigger events/cgroup/cgroup_re=
mount/trigger events/cgroup/cgroup_rename/trigger events/cgroup/cgroup_rmdi=
r/trigger events/cgroup/cgroup_rstat_lock_contended/trigger events/cgroup/c=
group_rstat_locked/trigger events/cgroup/cgroup_rstat_unlock/trigger events=
/cgroup/cgroup_setup_root/trigger events/cgroup/cgroup_transfer_tasks/trigg=
er events/cgroup/cgroup_unfreeze/trigger events/clk/clk_disable/trigger eve=
nts/clk/clk_disable_complete/trigger events/clk/clk_enable/trigger events/c=
lk/clk_enable_complete/trigger events/clk/clk_prepare/trigger events/clk/cl=
k_prepare_complete/trigger events/clk/clk_rate_request_done/trigger events/=
clk/clk_rate_request_start/trigger events/clk/clk_set_duty_cycle/trigger ev=
ents/clk/clk_set_duty_cycle_complete/trigger events/clk/clk_set_max_rate/tr=
igger events/clk/clk_set_min_rate/trigger events/clk/clk_set_parent/trigger=
 events/clk/clk_set_parent_complete/trigger events/clk/clk_set_phase/trigge=
r events/clk/clk_set_phase_complete/trigger events/clk/clk_set_rate/trigger=
 events/clk/clk_set_rate_complete/trigger events/clk/clk_set_rate_range/tri=
gger events/clk/clk_unprepare/trigger events/clk/clk_unprepare_complete/tri=
gger events/cma/cma_alloc_busy_retry/trigger events/cma/cma_alloc_finish/tr=
igger events/cma/cma_alloc_start/trigger events/cma/cma_release/trigger eve=
nts/compaction/mm_compaction_begin/trigger events/compaction/mm_compaction_=
defer_compaction/trigger events/compaction/mm_compaction_defer_reset/trigge=
r events/compaction/mm_compaction_deferred/trigger events/compaction/mm_com=
paction_end/trigger events/compaction/mm_compaction_fast_isolate_freepages/=
trigger events/compaction/mm_compaction_finished/trigger events/compaction/=
mm_compaction_isolate_freepages/trigger events/compaction/mm_compaction_iso=
late_migratepages/trigger events/compaction/mm_compaction_kcompactd_sleep/t=
rigger events/compaction/mm_compaction_kcompactd_wake/trigger events/compac=
tion/mm_compaction_migratepages/trigger events/compaction/mm_compaction_sui=
table/trigger events/compaction/mm_compaction_try_to_compact_pages/trigger =
events/compaction/mm_compaction_wakeup_kcompactd/trigger events/context_tra=
cking/user_enter/trigger events/context_tracking/user_exit/trigger events/c=
oredump/coredump/trigger events/cpuhp/cpuhp_enter/trigger events/cpuhp/cpuh=
p_exit/trigger events/cpuhp/cpuhp_multi_enter/trigger events/csd/csd_functi=
on_entry/trigger events/csd/csd_function_exit/trigger events/csd/csd_queue_=
cpu/trigger events/damon/damon_aggregated/trigger events/damon/damon_monito=
r_intervals_tune/trigger events/damon/damon_region_aggregated/trigger event=
s/damon/damos_before_apply/trigger events/damon/damos_esz/trigger events/da=
mon/damos_stat_after_apply_interval/trigger events/dev/devres_log/trigger e=
vents/devlink/devlink_health_recover_aborted/trigger events/devlink/devlink=
_health_report/trigger events/devlink/devlink_health_reporter_state_update/=
trigger events/devlink/devlink_hwerr/trigger events/devlink/devlink_hwmsg/t=
rigger events/devlink/devlink_trap_report/trigger events/dma/dma_alloc/trig=
ger events/dma/dma_alloc_pages/trigger events/dma/dma_alloc_sgt/trigger eve=
nts/dma/dma_alloc_sgt_err/trigger events/dma/dma_free/trigger events/dma/dm=
a_free_pages/trigger events/dma/dma_free_sgt/trigger events/dma/dma_map_phy=
s/trigger events/dma/dma_map_sg/trigger events/dma/dma_map_sg_err/trigger e=
vents/dma/dma_sync_sg_for_cpu/trigger events/dma/dma_sync_sg_for_device/tri=
gger events/dma/dma_sync_single_for_cpu/trigger events/dma/dma_sync_single_=
for_device/trigger events/dma/dma_unmap_phys/trigger events/dma/dma_unmap_s=
g/trigger events/dma_buf/dma_buf_detach/trigger events/dma_buf/dma_buf_dyna=
mic_attach/trigger events/dma_buf/dma_buf_export/trigger events/dma_buf/dma=
_buf_fd/trigger events/dma_buf/dma_buf_get/trigger events/dma_buf/dma_buf_m=
map/trigger events/dma_buf/dma_buf_mmap_internal/trigger events/dma_buf/dma=
_buf_put/trigger events/dma_fence/dma_fence_destroy/trigger events/dma_fenc=
e/dma_fence_emit/trigger events/dma_fence/dma_fence_enable_signal/trigger e=
vents/dma_fence/dma_fence_init/trigger events/dma_fence/dma_fence_signaled/=
trigger events/dma_fence/dma_fence_wait_end/trigger events/dma_fence/dma_fe=
nce_wait_start/trigger events/drm/drm_vblank_event/trigger events/drm/drm_v=
blank_event_delivered/trigger events/drm/drm_vblank_event_queued/trigger ev=
ents/e1000e_trace/e1000e_trace_mac_register/trigger events/error_report/err=
or_report_end/trigger events/exceptions/page_fault_kernel/trigger events/ex=
ceptions/page_fault_user/trigger events/ext4/ext4_alloc_da_blocks/trigger e=
vents/ext4/ext4_allocate_blocks/trigger events/ext4/ext4_allocate_inode/tri=
gger events/ext4/ext4_begin_ordered_truncate/trigger events/ext4/ext4_colla=
pse_range/trigger events/ext4/ext4_da_release_space/trigger events/ext4/ext=
4_da_reserve_space/trigger events/ext4/ext4_da_update_reserve_space/trigger=
 events/ext4/ext4_da_write_begin/trigger events/ext4/ext4_da_write_end/trig=
ger events/ext4/ext4_da_write_folios_end/trigger events/ext4/ext4_da_write_=
folios_start/trigger events/ext4/ext4_da_write_pages_extent/trigger events/=
ext4/ext4_discard_blocks/trigger events/ext4/ext4_discard_preallocations/tr=
igger events/ext4/ext4_drop_inode/trigger events/ext4/ext4_error/trigger ev=
ents/ext4/ext4_es_cache_extent/trigger events/ext4/ext4_es_find_extent_rang=
e_enter/trigger events/ext4/ext4_es_find_extent_range_exit/trigger events/e=
xt4/ext4_es_insert_delayed_extent/trigger events/ext4/ext4_es_insert_extent=
/trigger events/ext4/ext4_es_lookup_extent_enter/trigger events/ext4/ext4_e=
s_lookup_extent_exit/trigger events/ext4/ext4_es_remove_extent/trigger even=
ts/ext4/ext4_es_shrink/trigger events/ext4/ext4_es_shrink_count/trigger eve=
nts/ext4/ext4_es_shrink_scan_enter/trigger events/ext4/ext4_es_shrink_scan_=
exit/trigger events/ext4/ext4_evict_inode/trigger events/ext4/ext4_ext_conv=
ert_to_initialized_enter/trigger events/ext4/ext4_ext_convert_to_initialize=
d_fastpath/trigger events/ext4/ext4_ext_handle_unwritten_extents/trigger ev=
ents/ext4/ext4_ext_load_extent/trigger events/ext4/ext4_ext_map_blocks_ente=
r/trigger events/ext4/ext4_ext_map_blocks_exit/trigger events/ext4/ext4_ext=
_remove_space/trigger events/ext4/ext4_ext_remove_space_done/trigger events=
/ext4/ext4_ext_rm_idx/trigger events/ext4/ext4_ext_rm_leaf/trigger events/e=
xt4/ext4_ext_show_extent/trigger events/ext4/ext4_fallocate_enter/trigger e=
vents/ext4/ext4_fallocate_exit/trigger events/ext4/ext4_fc_cleanup/trigger =
events/ext4/ext4_fc_commit_start/trigger events/ext4/ext4_fc_commit_stop/tr=
igger events/ext4/ext4_fc_lock_updates/trigger events/ext4/ext4_fc_replay/t=
rigger events/ext4/ext4_fc_replay_scan/trigger events/ext4/ext4_fc_stats/tr=
igger events/ext4/ext4_fc_track_create/trigger events/ext4/ext4_fc_track_in=
ode/trigger events/ext4/ext4_fc_track_link/trigger events/ext4/ext4_fc_trac=
k_range/trigger events/ext4/ext4_fc_track_unlink/trigger events/ext4/ext4_f=
orget/trigger events/ext4/ext4_free_blocks/trigger events/ext4/ext4_free_in=
ode/trigger events/ext4/ext4_fsmap_high_key/trigger events/ext4/ext4_fsmap_=
low_key/trigger events/ext4/ext4_fsmap_mapping/trigger events/ext4/ext4_get=
_implied_cluster_alloc_exit/trigger events/ext4/ext4_getfsmap_high_key/trig=
ger events/ext4/ext4_getfsmap_low_key/trigger events/ext4/ext4_getfsmap_map=
ping/trigger events/ext4/ext4_ind_map_blocks_enter/trigger events/ext4/ext4=
_ind_map_blocks_exit/trigger events/ext4/ext4_insert_range/trigger events/e=
xt4/ext4_invalidate_folio/trigger events/ext4/ext4_journal_start_inode/trig=
ger events/ext4/ext4_journal_start_reserved/trigger events/ext4/ext4_journa=
l_start_sb/trigger events/ext4/ext4_journalled_invalidate_folio/trigger eve=
nts/ext4/ext4_journalled_write_end/trigger events/ext4/ext4_lazy_itable_ini=
t/trigger events/ext4/ext4_load_inode/trigger events/ext4/ext4_load_inode_b=
itmap/trigger events/ext4/ext4_mark_inode_dirty/trigger events/ext4/ext4_mb=
_bitmap_load/trigger events/ext4/ext4_mb_buddy_bitmap_load/trigger events/e=
xt4/ext4_mb_discard_preallocations/trigger events/ext4/ext4_mb_new_group_pa=
/trigger events/ext4/ext4_mb_new_inode_pa/trigger events/ext4/ext4_mb_relea=
se_group_pa/trigger events/ext4/ext4_mb_release_inode_pa/trigger events/ext=
4/ext4_mballoc_alloc/trigger events/ext4/ext4_mballoc_discard/trigger event=
s/ext4/ext4_mballoc_free/trigger events/ext4/ext4_mballoc_prealloc/trigger =
events/ext4/ext4_move_extent_enter/trigger events/ext4/ext4_move_extent_exi=
t/trigger events/ext4/ext4_nfs_commit_metadata/trigger events/ext4/ext4_oth=
er_inode_update_time/trigger events/ext4/ext4_prefetch_bitmaps/trigger even=
ts/ext4/ext4_punch_hole/trigger events/ext4/ext4_read_block_bitmap_load/tri=
gger events/ext4/ext4_read_folio/trigger events/ext4/ext4_release_folio/tri=
gger events/ext4/ext4_remove_blocks/trigger events/ext4/ext4_request_blocks=
/trigger events/ext4/ext4_request_inode/trigger events/ext4/ext4_shutdown/t=
rigger events/ext4/ext4_sync_file_enter/trigger events/ext4/ext4_sync_file_=
exit/trigger events/ext4/ext4_sync_fs/trigger events/ext4/ext4_trim_all_fre=
e/trigger events/ext4/ext4_trim_extent/trigger events/ext4/ext4_truncate_en=
ter/trigger events/ext4/ext4_truncate_exit/trigger events/ext4/ext4_unlink_=
enter/trigger events/ext4/ext4_unlink_exit/trigger events/ext4/ext4_update_=
sb/trigger events/ext4/ext4_write_begin/trigger events/ext4/ext4_write_end/=
trigger events/ext4/ext4_writepages/trigger events/ext4/ext4_writepages_res=
ult/trigger events/ext4/ext4_zero_range/trigger events/fib/fib_table_lookup=
/trigger events/fib6/fib6_table_lookup/trigger events/filelock/break_lease/=
trigger events/filelock/break_lease_block/trigger events/filelock/break_lea=
se_noblock/trigger events/filelock/break_lease_unblock/trigger events/filel=
ock/fcntl_setlk/trigger events/filelock/flock_lock_inode/trigger events/fil=
elock/generic_add_lease/trigger events/filelock/generic_delete_lease/trigge=
r events/filelock/leases_conflict/trigger events/filelock/locks_get_lock_co=
ntext/trigger events/filelock/locks_remove_posix/trigger events/filelock/po=
six_lock_inode/trigger events/filelock/time_out_leases/trigger events/filem=
ap/file_check_and_advance_wb_err/trigger events/filemap/filemap_set_wb_err/=
trigger events/filemap/mm_filemap_add_to_page_cache/trigger events/filemap/=
mm_filemap_delete_from_page_cache/trigger events/filemap/mm_filemap_fault/t=
rigger events/filemap/mm_filemap_get_pages/trigger events/filemap/mm_filema=
p_map_pages/trigger events/fs_dax/dax_insert_pfn_mkwrite/trigger events/fs_=
dax/dax_insert_pfn_mkwrite_no_entry/trigger events/fs_dax/dax_load_hole/tri=
gger events/fs_dax/dax_pmd_fault/trigger events/fs_dax/dax_pmd_fault_done/t=
rigger events/fs_dax/dax_pmd_load_hole/trigger events/fs_dax/dax_pmd_load_h=
ole_fallback/trigger events/fs_dax/dax_pte_fault/trigger events/fs_dax/dax_=
pte_fault_done/trigger events/fs_dax/dax_writeback_one/trigger events/fs_da=
x/dax_writeback_range/trigger events/fs_dax/dax_writeback_range_done/trigge=
r events/fscache/fscache_access/trigger events/fscache/fscache_access_cache=
/trigger events/fscache/fscache_access_volume/trigger events/fscache/fscach=
e_acquire/trigger events/fscache/fscache_active/trigger events/fscache/fsca=
che_cache/trigger events/fscache/fscache_cookie/trigger events/fscache/fsca=
che_invalidate/trigger events/fscache/fscache_relinquish/trigger events/fsc=
ache/fscache_resize/trigger events/fscache/fscache_volume/trigger events/fs=
notify/fsnotify/trigger events/fsverity/fsverity_enable/trigger events/fsve=
rity/fsverity_merkle_hit/trigger events/fsverity/fsverity_tree_done/trigger=
 events/fsverity/fsverity_verify_data_block/trigger events/fsverity/fsverit=
y_verify_merkle_block/trigger events/ftrace/print/trigger events/fuse/fuse_=
request_end/trigger events/fuse/fuse_request_send/trigger events/fuse/fuse_=
request_sent/trigger events/gpio/gpio_direction/trigger events/gpio/gpio_va=
lue/trigger events/handshake/handshake_cancel/trigger events/handshake/hand=
shake_cancel_busy/trigger events/handshake/handshake_cancel_none/trigger ev=
ents/handshake/handshake_cmd_accept/trigger events/handshake/handshake_cmd_=
accept_err/trigger events/handshake/handshake_cmd_done/trigger events/hands=
hake/handshake_cmd_done_err/trigger events/handshake/handshake_complete/tri=
gger events/handshake/handshake_destruct/trigger events/handshake/handshake=
_notify_err/trigger events/handshake/handshake_submit/trigger events/handsh=
ake/handshake_submit_err/trigger events/handshake/tls_alert_recv/trigger ev=
ents/handshake/tls_alert_send/trigger events/handshake/tls_contenttype/trig=
ger events/hda/hda_get_response/trigger events/hda/hda_send_cmd/trigger eve=
nts/hda/hda_unsol_event/trigger events/hda/snd_hdac_stream_start/trigger ev=
ents/hda/snd_hdac_stream_stop/trigger events/hda_controller/azx_get_positio=
n/trigger events/hda_controller/azx_pcm_close/trigger events/hda_controller=
/azx_pcm_hw_params/trigger events/hda_controller/azx_pcm_open/trigger event=
s/hda_controller/azx_pcm_prepare/trigger events/hda_controller/azx_pcm_trig=
ger/trigger events/hda_intel/azx_resume/trigger events/hda_intel/azx_runtim=
e_resume/trigger events/hda_intel/azx_runtime_suspend/trigger events/hda_in=
tel/azx_suspend/trigger events/huge_memory/mm_collapse_huge_page/trigger ev=
ents/huge_memory/mm_collapse_huge_page_isolate/trigger events/huge_memory/m=
m_collapse_huge_page_swapin/trigger events/huge_memory/mm_khugepaged_collap=
se_file/trigger events/huge_memory/mm_khugepaged_scan/trigger events/huge_m=
emory/mm_khugepaged_scan_file/trigger events/huge_memory/mm_khugepaged_scan=
_pmd/trigger events/hugetlbfs/hugetlbfs_alloc_inode/trigger events/hugetlbf=
s/hugetlbfs_evict_inode/trigger events/hugetlbfs/hugetlbfs_fallocate/trigge=
r events/hugetlbfs/hugetlbfs_free_inode/trigger events/hugetlbfs/hugetlbfs_=
setattr/trigger events/hwmon/hwmon_attr_show/trigger events/hwmon/hwmon_att=
r_show_string/trigger events/hwmon/hwmon_attr_store/trigger events/i2c/i2c_=
read/trigger events/i2c/i2c_reply/trigger events/i2c/i2c_result/trigger eve=
nts/i2c/i2c_write/trigger events/i915/g4x_wm/trigger events/i915/i915_conte=
xt_create/trigger events/i915/i915_context_free/trigger events/i915/i915_ge=
m_evict/trigger events/i915/i915_gem_evict_node/trigger events/i915/i915_ge=
m_evict_vm/trigger events/i915/i915_gem_object_clflush/trigger events/i915/=
i915_gem_object_create/trigger events/i915/i915_gem_object_destroy/trigger =
events/i915/i915_gem_object_fault/trigger events/i915/i915_gem_object_pread=
/trigger events/i915/i915_gem_object_pwrite/trigger events/i915/i915_gem_sh=
rink/trigger events/i915/i915_ppgtt_create/trigger events/i915/i915_ppgtt_r=
elease/trigger events/i915/i915_reg_rw/trigger events/i915/i915_request_add=
/trigger events/i915/i915_request_queue/trigger events/i915/i915_request_re=
tire/trigger events/i915/i915_request_wait_begin/trigger events/i915/i915_r=
equest_wait_end/trigger events/i915/i915_vma_bind/trigger events/i915/i915_=
vma_unbind/trigger events/i915/intel_cpu_fifo_underrun/trigger events/i915/=
intel_crtc_flip_done/trigger events/i915/intel_crtc_vblank_work_end/trigger=
 events/i915/intel_crtc_vblank_work_start/trigger events/i915/intel_fbc_act=
ivate/trigger events/i915/intel_fbc_deactivate/trigger events/i915/intel_fb=
c_nuke/trigger events/i915/intel_frontbuffer_flush/trigger events/i915/inte=
l_frontbuffer_invalidate/trigger events/i915/intel_memory_cxsr/trigger even=
ts/i915/intel_pch_fifo_underrun/trigger events/i915/intel_pipe_crc/trigger =
events/i915/intel_pipe_disable/trigger events/i915/intel_pipe_enable/trigge=
r events/i915/intel_pipe_scaler_update_arm/trigger events/i915/intel_pipe_u=
pdate_end/trigger events/i915/intel_pipe_update_start/trigger events/i915/i=
ntel_pipe_update_vblank_evaded/trigger events/i915/intel_plane_async_flip/t=
rigger events/i915/intel_plane_disable_arm/trigger events/i915/intel_plane_=
scaler_update_arm/trigger events/i915/intel_plane_update_arm/trigger events=
/i915/intel_plane_update_noarm/trigger events/i915/intel_scaler_disable_arm=
/trigger events/i915/vlv_fifo_size/trigger events/i915/vlv_wm/trigger event=
s/ib_cma/icm_dreq_skipped/trigger events/ib_cma/icm_dreq_unknown_err/trigge=
r events/ib_cma/icm_establish_err/trigger events/ib_cma/icm_handler_err/tri=
gger events/ib_cma/icm_insert_failed_err/trigger events/ib_cma/icm_issue_dr=
ep/trigger events/ib_cma/icm_issue_rej/trigger events/ib_cma/icm_mad_send_e=
rr/trigger events/ib_cma/icm_mra_unknown_err/trigger events/ib_cma/icm_no_l=
istener_err/trigger events/ib_cma/icm_no_priv_err/trigger events/ib_cma/icm=
_prepare_mra_unknown_err/trigger events/ib_cma/icm_qp_init_err/trigger even=
ts/ib_cma/icm_qp_rtr_err/trigger events/ib_cma/icm_qp_rts_err/trigger event=
s/ib_cma/icm_rej_unknown_err/trigger events/ib_cma/icm_remote_no_priv_err/t=
rigger events/ib_cma/icm_rep_unknown_err/trigger events/ib_cma/icm_send_cm_=
rtu_err/trigger events/ib_cma/icm_send_drep/trigger events/ib_cma/icm_send_=
drep_err/trigger events/ib_cma/icm_send_dreq/trigger events/ib_cma/icm_send=
_dup_rep/trigger events/ib_cma/icm_send_dup_req/trigger events/ib_cma/icm_s=
end_mra/trigger events/ib_cma/icm_send_rej/trigger events/ib_cma/icm_send_r=
ep/trigger events/ib_cma/icm_send_rep_err/trigger events/ib_cma/icm_send_re=
q/trigger events/ib_cma/icm_send_rtu/trigger events/ib_cma/icm_send_sidr_re=
p/trigger events/ib_cma/icm_send_sidr_req/trigger events/ib_cma/icm_send_un=
known_rej_err/trigger events/ib_cma/icm_staleconn_err/trigger events/ib_mad=
/ib_mad_create_agent/trigger events/ib_mad/ib_mad_error_handler/trigger eve=
nts/ib_mad/ib_mad_handle_ib_smi/trigger events/ib_mad/ib_mad_handle_opa_smi=
/trigger events/ib_mad/ib_mad_handle_out_ib_smi/trigger events/ib_mad/ib_ma=
d_handle_out_opa_smi/trigger events/ib_mad/ib_mad_ib_send_mad/trigger event=
s/ib_mad/ib_mad_recv_done_agent/trigger events/ib_mad/ib_mad_recv_done_hand=
ler/trigger events/ib_mad/ib_mad_send_done_agent/trigger events/ib_mad/ib_m=
ad_send_done_handler/trigger events/ib_mad/ib_mad_send_done_resend/trigger =
events/ib_mad/ib_mad_unregister_agent/trigger events/icmp/icmp_send/trigger=
 events/initcall/initcall_finish/trigger events/initcall/initcall_level/tri=
gger events/initcall/initcall_start/trigger events/intel_avs/avs_d0ix/trigg=
er events/intel_avs/avs_dsp_core_op/trigger events/intel_avs/avs_ipc_msg_pa=
yload/trigger events/intel_avs/avs_ipc_notify_msg/trigger events/intel_avs/=
avs_ipc_reply_msg/trigger events/intel_avs/avs_ipc_request_msg/trigger even=
ts/intel_iommu/cache_tag_assign/trigger events/intel_iommu/cache_tag_flush_=
range/trigger events/intel_iommu/cache_tag_flush_range_np/trigger events/in=
tel_iommu/cache_tag_unassign/trigger events/intel_iommu/prq_report/trigger =
events/intel_iommu/qi_submit/trigger events/io_uring/io_uring_complete/trig=
ger events/io_uring/io_uring_cqe_overflow/trigger events/io_uring/io_uring_=
cqring_wait/trigger events/io_uring/io_uring_create/trigger events/io_uring=
/io_uring_defer/trigger events/io_uring/io_uring_fail_link/trigger events/i=
o_uring/io_uring_file_get/trigger events/io_uring/io_uring_link/trigger eve=
nts/io_uring/io_uring_local_work_run/trigger events/io_uring/io_uring_poll_=
arm/trigger events/io_uring/io_uring_queue_async_work/trigger events/io_uri=
ng/io_uring_register/trigger events/io_uring/io_uring_req_failed/trigger ev=
ents/io_uring/io_uring_short_write/trigger events/io_uring/io_uring_submit_=
req/trigger events/io_uring/io_uring_task_add/trigger events/io_uring/io_ur=
ing_task_work_run/trigger events/iomap/iomap_add_to_ioend/trigger events/io=
map/iomap_dio_complete/trigger events/iomap/iomap_dio_invalidate_fail/trigg=
er events/iomap/iomap_dio_rw_begin/trigger events/iomap/iomap_dio_rw_queued=
/trigger events/iomap/iomap_invalidate_folio/trigger events/iomap/iomap_ite=
r/trigger events/iomap/iomap_iter_dstmap/trigger events/iomap/iomap_iter_sr=
cmap/trigger events/iomap/iomap_readahead/trigger events/iomap/iomap_readpa=
ge/trigger events/iomap/iomap_release_folio/trigger events/iomap/iomap_writ=
eback_folio/trigger events/iomap/iomap_zero_iter/trigger events/iommu/add_d=
evice_to_group/trigger events/iommu/attach_device_to_domain/trigger events/=
iommu/io_page_fault/trigger events/iommu/map/trigger events/iommu/remove_de=
vice_from_group/trigger events/iommu/unmap/trigger events/ipi/ipi_send_cpu/=
trigger events/ipi/ipi_send_cpumask/trigger events/irq/irq_handler_entry/tr=
igger events/irq/irq_handler_exit/trigger events/irq/softirq_entry/trigger =
events/irq/softirq_exit/trigger events/irq/softirq_raise/trigger events/irq=
/tasklet_entry/trigger events/irq/tasklet_exit/trigger events/irq_matrix/ir=
q_matrix_alloc/trigger events/irq_matrix/irq_matrix_alloc_managed/trigger e=
vents/irq_matrix/irq_matrix_assign/trigger events/irq_matrix/irq_matrix_ass=
ign_system/trigger events/irq_matrix/irq_matrix_free/trigger events/irq_mat=
rix/irq_matrix_offline/trigger events/irq_matrix/irq_matrix_online/trigger =
events/irq_matrix/irq_matrix_remove_managed/trigger events/irq_matrix/irq_m=
atrix_remove_reserved/trigger events/irq_matrix/irq_matrix_reserve/trigger =
events/irq_matrix/irq_matrix_reserve_managed/trigger events/irq_vectors/cal=
l_function_entry/trigger events/irq_vectors/call_function_exit/trigger even=
ts/irq_vectors/call_function_single_entry/trigger events/irq_vectors/call_f=
unction_single_exit/trigger events/irq_vectors/deferred_error_apic_entry/tr=
igger events/irq_vectors/deferred_error_apic_exit/trigger events/irq_vector=
s/error_apic_entry/trigger events/irq_vectors/error_apic_exit/trigger event=
s/irq_vectors/irq_work_entry/trigger events/irq_vectors/irq_work_exit/trigg=
er events/irq_vectors/local_timer_entry/trigger events/irq_vectors/local_ti=
mer_exit/trigger events/irq_vectors/reschedule_entry/trigger events/irq_vec=
tors/reschedule_exit/trigger events/irq_vectors/spurious_apic_entry/trigger=
 events/irq_vectors/spurious_apic_exit/trigger events/irq_vectors/thermal_a=
pic_entry/trigger events/irq_vectors/thermal_apic_exit/trigger events/irq_v=
ectors/threshold_apic_entry/trigger events/irq_vectors/threshold_apic_exit/=
trigger events/irq_vectors/vector_activate/trigger events/irq_vectors/vecto=
r_alloc/trigger events/irq_vectors/vector_alloc_managed/trigger events/irq_=
vectors/vector_clear/trigger events/irq_vectors/vector_config/trigger event=
s/irq_vectors/vector_deactivate/trigger events/irq_vectors/vector_free_move=
d/trigger events/irq_vectors/vector_reserve/trigger events/irq_vectors/vect=
or_reserve_managed/trigger events/irq_vectors/vector_setup/trigger events/i=
rq_vectors/vector_teardown/trigger events/irq_vectors/vector_update/trigger=
 events/irq_vectors/x86_platform_ipi_entry/trigger events/irq_vectors/x86_p=
latform_ipi_exit/trigger events/jbd2/jbd2_checkpoint/trigger events/jbd2/jb=
d2_checkpoint_stats/trigger events/jbd2/jbd2_commit_flushing/trigger events=
/jbd2/jbd2_commit_locking/trigger events/jbd2/jbd2_commit_logging/trigger e=
vents/jbd2/jbd2_drop_transaction/trigger events/jbd2/jbd2_end_commit/trigge=
r events/jbd2/jbd2_handle_extend/trigger events/jbd2/jbd2_handle_restart/tr=
igger events/jbd2/jbd2_handle_start/trigger events/jbd2/jbd2_handle_stats/t=
rigger events/jbd2/jbd2_lock_buffer_stall/trigger events/jbd2/jbd2_run_stat=
s/trigger events/jbd2/jbd2_shrink_checkpoint_list/trigger events/jbd2/jbd2_=
shrink_count/trigger events/jbd2/jbd2_shrink_scan_enter/trigger events/jbd2=
/jbd2_shrink_scan_exit/trigger events/jbd2/jbd2_start_commit/trigger events=
/jbd2/jbd2_submit_inode_data/trigger events/jbd2/jbd2_update_log_tail/trigg=
er events/jbd2/jbd2_write_superblock/trigger events/kmem/kfree/trigger even=
ts/kmem/kmalloc/trigger events/kmem/kmem_cache_alloc/trigger events/kmem/km=
em_cache_free/trigger events/kmem/mm_calculate_totalreserve_pages/trigger e=
vents/kmem/mm_page_alloc/trigger events/kmem/mm_page_alloc_extfrag/trigger =
events/kmem/mm_page_alloc_zone_locked/trigger events/kmem/mm_page_free/trig=
ger events/kmem/mm_page_free_batched/trigger events/kmem/mm_page_pcpu_drain=
/trigger events/kmem/mm_setup_per_zone_lowmem_reserve/trigger events/kmem/m=
m_setup_per_zone_wmarks/trigger events/kmem/rss_stat/trigger events/kprobes=
/kpevent/trigger events/ksm/ksm_advisor/trigger events/ksm/ksm_enter/trigge=
r events/ksm/ksm_exit/trigger events/ksm/ksm_merge_one_page/trigger events/=
ksm/ksm_merge_with_ksm_page/trigger events/ksm/ksm_remove_ksm_page/trigger =
events/ksm/ksm_remove_rmap_item/trigger events/ksm/ksm_start_scan/trigger e=
vents/ksm/ksm_stop_scan/trigger events/kvm/kvm_ack_irq/trigger events/kvm/k=
vm_age_hva/trigger events/kvm/kvm_apic/trigger events/kvm/kvm_apic_accept_i=
rq/trigger events/kvm/kvm_apic_ipi/trigger events/kvm/kvm_apicv_accept_irq/=
trigger events/kvm/kvm_apicv_inhibit_changed/trigger events/kvm/kvm_async_p=
f_completed/trigger events/kvm/kvm_async_pf_not_present/trigger events/kvm/=
kvm_async_pf_ready/trigger events/kvm/kvm_async_pf_repeated_fault/trigger e=
vents/kvm/kvm_avic_doorbell/trigger events/kvm/kvm_avic_ga_log/trigger even=
ts/kvm/kvm_avic_incomplete_ipi/trigger events/kvm/kvm_avic_kick_vcpu_slowpa=
th/trigger events/kvm/kvm_avic_unaccelerated_access/trigger events/kvm/kvm_=
cpuid/trigger events/kvm/kvm_cr/trigger events/kvm/kvm_dirty_ring_exit/trig=
ger events/kvm/kvm_dirty_ring_push/trigger events/kvm/kvm_dirty_ring_reset/=
trigger events/kvm/kvm_emulate_insn/trigger events/kvm/kvm_entry/trigger ev=
ents/kvm/kvm_eoi/trigger events/kvm/kvm_exit/trigger events/kvm/kvm_fast_mm=
io/trigger events/kvm/kvm_fpu/trigger events/kvm/kvm_halt_poll_ns/trigger e=
vents/kvm/kvm_hv_flush_tlb/trigger events/kvm/kvm_hv_flush_tlb_ex/trigger e=
vents/kvm/kvm_hv_hypercall/trigger events/kvm/kvm_hv_hypercall_done/trigger=
 events/kvm/kvm_hv_notify_acked_sint/trigger events/kvm/kvm_hv_send_ipi/tri=
gger events/kvm/kvm_hv_send_ipi_ex/trigger events/kvm/kvm_hv_stimer_callbac=
k/trigger events/kvm/kvm_hv_stimer_cleanup/trigger events/kvm/kvm_hv_stimer=
_expiration/trigger events/kvm/kvm_hv_stimer_set_config/trigger events/kvm/=
kvm_hv_stimer_set_count/trigger events/kvm/kvm_hv_stimer_start_one_shot/tri=
gger events/kvm/kvm_hv_stimer_start_periodic/trigger events/kvm/kvm_hv_synd=
bg_get_msr/trigger events/kvm/kvm_hv_syndbg_set_msr/trigger events/kvm/kvm_=
hv_synic_send_eoi/trigger events/kvm/kvm_hv_synic_set_irq/trigger events/kv=
m/kvm_hv_synic_set_msr/trigger events/kvm/kvm_hv_timer_state/trigger events=
/kvm/kvm_hypercall/trigger events/kvm/kvm_inj_exception/trigger events/kvm/=
kvm_inj_virq/trigger events/kvm/kvm_invlpga/trigger events/kvm/kvm_ioapic_d=
elayed_eoi_inj/trigger events/kvm/kvm_ioapic_set_irq/trigger events/kvm/kvm=
_mmio/trigger events/kvm/kvm_msi_set_irq/trigger events/kvm/kvm_msr/trigger=
 events/kvm/kvm_nested_intercepts/trigger events/kvm/kvm_nested_intr_vmexit=
/trigger events/kvm/kvm_nested_vmenter/trigger events/kvm/kvm_nested_vmente=
r_failed/trigger events/kvm/kvm_nested_vmexit/trigger events/kvm/kvm_nested=
_vmexit_inject/trigger events/kvm/kvm_page_fault/trigger events/kvm/kvm_pi_=
irte_update/trigger events/kvm/kvm_pic_set_irq/trigger events/kvm/kvm_pio/t=
rigger events/kvm/kvm_ple_window_update/trigger events/kvm/kvm_pml_full/tri=
gger events/kvm/kvm_pv_eoi/trigger events/kvm/kvm_pv_tlb_flush/trigger even=
ts/kvm/kvm_pvclock_update/trigger events/kvm/kvm_rmp_fault/trigger events/k=
vm/kvm_set_irq/trigger events/kvm/kvm_skinit/trigger events/kvm/kvm_smm_tra=
nsition/trigger events/kvm/kvm_test_age_hva/trigger events/kvm/kvm_track_ts=
c/trigger events/kvm/kvm_try_async_get_page/trigger events/kvm/kvm_unmap_hv=
a_range/trigger events/kvm/kvm_update_master_clock/trigger events/kvm/kvm_u=
serspace_exit/trigger events/kvm/kvm_vcpu_wakeup/trigger events/kvm/kvm_vm_=
set_mem_attributes/trigger events/kvm/kvm_vmgexit_enter/trigger events/kvm/=
kvm_vmgexit_exit/trigger events/kvm/kvm_vmgexit_msr_protocol_enter/trigger =
events/kvm/kvm_vmgexit_msr_protocol_exit/trigger events/kvm/kvm_wait_lapic_=
expire/trigger events/kvm/kvm_write_tsc_offset/trigger events/kvm/kvm_xen_h=
ypercall/trigger events/kvm/vcpu_match_mmio/trigger events/kvmmmu/check_mmi=
o_spte/trigger events/kvmmmu/fast_page_fault/trigger events/kvmmmu/handle_m=
mio_page_fault/trigger events/kvmmmu/kvm_mmu_get_page/trigger events/kvmmmu=
/kvm_mmu_pagetable_walk/trigger events/kvmmmu/kvm_mmu_paging_element/trigge=
r events/kvmmmu/kvm_mmu_prepare_zap_page/trigger events/kvmmmu/kvm_mmu_set_=
accessed_bit/trigger events/kvmmmu/kvm_mmu_set_dirty_bit/trigger events/kvm=
mmu/kvm_mmu_set_spte/trigger events/kvmmmu/kvm_mmu_split_huge_page/trigger =
events/kvmmmu/kvm_mmu_spte_requested/trigger events/kvmmmu/kvm_mmu_sync_pag=
e/trigger events/kvmmmu/kvm_mmu_unsync_page/trigger events/kvmmmu/kvm_mmu_w=
alker_error/trigger events/kvmmmu/kvm_mmu_zap_all_fast/trigger events/kvmmm=
u/kvm_tdp_mmu_spte_changed/trigger events/kvmmmu/mark_mmio_spte/trigger eve=
nts/kyber/kyber_adjust/trigger events/kyber/kyber_latency/trigger events/ky=
ber/kyber_throttled/trigger events/libata/ata_bmdma_setup/trigger events/li=
bata/ata_bmdma_start/trigger events/libata/ata_bmdma_status/trigger events/=
libata/ata_bmdma_stop/trigger events/libata/ata_eh_about_to_do/trigger even=
ts/libata/ata_eh_done/trigger events/libata/ata_eh_link_autopsy/trigger eve=
nts/libata/ata_eh_link_autopsy_qc/trigger events/libata/ata_exec_command/tr=
igger events/libata/ata_link_hardreset_begin/trigger events/libata/ata_link=
_hardreset_end/trigger events/libata/ata_link_postreset/trigger events/liba=
ta/ata_link_softreset_begin/trigger events/libata/ata_link_softreset_end/tr=
igger events/libata/ata_port_freeze/trigger events/libata/ata_port_thaw/tri=
gger events/libata/ata_qc_complete_done/trigger events/libata/ata_qc_comple=
te_failed/trigger events/libata/ata_qc_complete_internal/trigger events/lib=
ata/ata_qc_issue/trigger events/libata/ata_qc_prep/trigger events/libata/at=
a_sff_flush_pio_task/trigger events/libata/ata_sff_hsm_command_complete/tri=
gger events/libata/ata_sff_hsm_state/trigger events/libata/ata_sff_pio_tran=
sfer_data/trigger events/libata/ata_sff_port_intr/trigger events/libata/ata=
_slave_hardreset_begin/trigger events/libata/ata_slave_hardreset_end/trigge=
r events/libata/ata_slave_postreset/trigger events/libata/ata_std_sched_eh/=
trigger events/libata/ata_tf_load/trigger events/libata/atapi_pio_transfer_=
data/trigger events/libata/atapi_send_cdb/trigger events/lock/contended_rel=
ease/trigger events/lock/contention_begin/trigger events/lock/contention_en=
d/trigger events/lock/lock_acquire/trigger events/lock/lock_release/trigger=
 events/lockd/nlmclnt_grant/trigger events/lockd/nlmclnt_lock/trigger event=
s/lockd/nlmclnt_test/trigger events/lockd/nlmclnt_unlock/trigger events/map=
le_tree/ma_op/trigger events/maple_tree/ma_read/trigger events/maple_tree/m=
a_write/trigger events/mce/mce_record/trigger events/mdio/mdio_access/trigg=
er events/mei/mei_pci_cfg_read/trigger events/mei/mei_reg_read/trigger even=
ts/mei/mei_reg_write/trigger events/memcg/count_memcg_events/trigger events=
/memcg/memcg_flush_stats/trigger events/memcg/mod_memcg_lruvec_state/trigge=
r events/memcg/mod_memcg_state/trigger events/memory_failure/memory_failure=
_event/trigger events/migrate/mm_migrate_pages/trigger events/migrate/mm_mi=
grate_pages_start/trigger events/migrate/remove_migration_pte/trigger event=
s/migrate/set_migration_pte/trigger events/mmap/exit_mmap/trigger events/mm=
ap/vm_unmapped_area/trigger events/mmap_lock/mmap_lock_acquire_returned/tri=
gger events/mmap_lock/mmap_lock_released/trigger events/mmap_lock/mmap_lock=
_start_locking/trigger events/module/module_free/trigger events/module/modu=
le_get/trigger events/module/module_load/trigger events/module/module_put/t=
rigger events/module/module_request/trigger events/mptcp/ack_update_msk/tri=
gger events/mptcp/get_mapping_status/trigger events/mptcp/mptcp_rcvbuf_grow=
/trigger events/mptcp/mptcp_sendmsg_frag/trigger events/mptcp/mptcp_subflow=
_get_send/trigger events/mptcp/subflow_check_data_avail/trigger events/msr/=
rdpmc/trigger events/msr/read_msr/trigger events/msr/write_msr/trigger even=
ts/napi/dql_stall_detected/trigger events/napi/napi_poll/trigger events/nei=
gh/neigh_cleanup_and_release/trigger events/neigh/neigh_create/trigger even=
ts/neigh/neigh_event_send_dead/trigger events/neigh/neigh_event_send_done/t=
rigger events/neigh/neigh_timer_handler/trigger events/neigh/neigh_update/t=
rigger events/neigh/neigh_update_done/trigger events/net/napi_gro_frags_ent=
ry/trigger events/net/napi_gro_frags_exit/trigger events/net/napi_gro_recei=
ve_entry/trigger events/net/napi_gro_receive_exit/trigger events/net/net_de=
v_queue/trigger events/net/net_dev_start_xmit/trigger events/net/net_dev_xm=
it/trigger events/net/net_dev_xmit_timeout/trigger events/net/netif_receive=
_skb/trigger events/net/netif_receive_skb_entry/trigger events/net/netif_re=
ceive_skb_exit/trigger events/net/netif_receive_skb_list_entry/trigger even=
ts/net/netif_receive_skb_list_exit/trigger events/net/netif_rx/trigger even=
ts/net/netif_rx_entry/trigger events/net/netif_rx_exit/trigger events/netfs=
/netfs_collect/trigger events/netfs/netfs_collect_folio/trigger events/netf=
s/netfs_collect_gap/trigger events/netfs/netfs_collect_sreq/trigger events/=
netfs/netfs_collect_state/trigger events/netfs/netfs_collect_stream/trigger=
 events/netfs/netfs_copy2cache/trigger events/netfs/netfs_failure/trigger e=
vents/netfs/netfs_folio/trigger events/netfs/netfs_folioq/trigger events/ne=
tfs/netfs_read/trigger events/netfs/netfs_rreq/trigger events/netfs/netfs_r=
req_ref/trigger events/netfs/netfs_sreq/trigger events/netfs/netfs_sreq_ref=
/trigger events/netfs/netfs_write/trigger events/netfs/netfs_write_iter/tri=
gger events/netlink/netlink_extack/trigger events/nfs/nfs_access_enter/trig=
ger events/nfs/nfs_access_exit/trigger events/nfs/nfs_aop_readahead/trigger=
 events/nfs/nfs_aop_readahead_done/trigger events/nfs/nfs_aop_readpage/trig=
ger events/nfs/nfs_aop_readpage_done/trigger events/nfs/nfs_async_rename_do=
ne/trigger events/nfs/nfs_atomic_open_enter/trigger events/nfs/nfs_atomic_o=
pen_exit/trigger events/nfs/nfs_commit_done/trigger events/nfs/nfs_commit_e=
rror/trigger events/nfs/nfs_comp_error/trigger events/nfs/nfs_create_enter/=
trigger events/nfs/nfs_create_exit/trigger events/nfs/nfs_direct_commit_com=
plete/trigger events/nfs/nfs_direct_resched_write/trigger events/nfs/nfs_di=
rect_write_complete/trigger events/nfs/nfs_direct_write_completion/trigger =
events/nfs/nfs_direct_write_reschedule_io/trigger events/nfs/nfs_direct_wri=
te_schedule_iovec/trigger events/nfs/nfs_do_writepage/trigger events/nfs/nf=
s_fh_to_dentry/trigger events/nfs/nfs_file_read/trigger events/nfs/nfs_file=
_write/trigger events/nfs/nfs_fsync_enter/trigger events/nfs/nfs_fsync_exit=
/trigger events/nfs/nfs_getattr_enter/trigger events/nfs/nfs_getattr_exit/t=
rigger events/nfs/nfs_initiate_commit/trigger events/nfs/nfs_initiate_read/=
trigger events/nfs/nfs_initiate_write/trigger events/nfs/nfs_invalidate_fol=
io/trigger events/nfs/nfs_invalidate_mapping_enter/trigger events/nfs/nfs_i=
nvalidate_mapping_exit/trigger events/nfs/nfs_launder_folio_done/trigger ev=
ents/nfs/nfs_link_enter/trigger events/nfs/nfs_link_exit/trigger events/nfs=
/nfs_local_open_fh/trigger events/nfs/nfs_lookup_enter/trigger events/nfs/n=
fs_lookup_exit/trigger events/nfs/nfs_lookup_revalidate_enter/trigger event=
s/nfs/nfs_lookup_revalidate_exit/trigger events/nfs/nfs_mkdir_enter/trigger=
 events/nfs/nfs_mkdir_exit/trigger events/nfs/nfs_mknod_enter/trigger event=
s/nfs/nfs_mknod_exit/trigger events/nfs/nfs_mount_assign/trigger events/nfs=
/nfs_mount_option/trigger events/nfs/nfs_mount_path/trigger events/nfs/nfs_=
pgio_error/trigger events/nfs/nfs_readdir_cache_fill/trigger events/nfs/nfs=
_readdir_cache_fill_done/trigger events/nfs/nfs_readdir_force_readdirplus/t=
rigger events/nfs/nfs_readdir_invalidate_cache_range/trigger events/nfs/nfs=
_readdir_lookup/trigger events/nfs/nfs_readdir_lookup_revalidate/trigger ev=
ents/nfs/nfs_readdir_lookup_revalidate_failed/trigger events/nfs/nfs_readdi=
r_uncached/trigger events/nfs/nfs_readdir_uncached_done/trigger events/nfs/=
nfs_readpage_done/trigger events/nfs/nfs_readpage_short/trigger events/nfs/=
nfs_refresh_inode_enter/trigger events/nfs/nfs_refresh_inode_exit/trigger e=
vents/nfs/nfs_remove_enter/trigger events/nfs/nfs_remove_exit/trigger event=
s/nfs/nfs_rename_enter/trigger events/nfs/nfs_rename_exit/trigger events/nf=
s/nfs_revalidate_inode_enter/trigger events/nfs/nfs_revalidate_inode_exit/t=
rigger events/nfs/nfs_rmdir_enter/trigger events/nfs/nfs_rmdir_exit/trigger=
 events/nfs/nfs_set_cache_invalid/trigger events/nfs/nfs_set_inode_stale/tr=
igger events/nfs/nfs_setattr_enter/trigger events/nfs/nfs_setattr_exit/trig=
ger events/nfs/nfs_sillyrename_unlink/trigger events/nfs/nfs_size_grow/trig=
ger events/nfs/nfs_size_truncate/trigger events/nfs/nfs_size_truncate_folio=
/trigger events/nfs/nfs_size_update/trigger events/nfs/nfs_size_wcc/trigger=
 events/nfs/nfs_symlink_enter/trigger events/nfs/nfs_symlink_exit/trigger e=
vents/nfs/nfs_try_to_update_request/trigger events/nfs/nfs_try_to_update_re=
quest_done/trigger events/nfs/nfs_unlink_enter/trigger events/nfs/nfs_unlin=
k_exit/trigger events/nfs/nfs_update_folio/trigger events/nfs/nfs_update_fo=
lio_done/trigger events/nfs/nfs_write_begin/trigger events/nfs/nfs_write_be=
gin_done/trigger events/nfs/nfs_write_end/trigger events/nfs/nfs_write_end_=
done/trigger events/nfs/nfs_write_error/trigger events/nfs/nfs_writeback_do=
ne/trigger events/nfs/nfs_writeback_folio/trigger events/nfs/nfs_writeback_=
folio_done/trigger events/nfs/nfs_writeback_folio_reclaim/trigger events/nf=
s/nfs_writeback_folio_reclaim_done/trigger events/nfs/nfs_writeback_inode_e=
nter/trigger events/nfs/nfs_writeback_inode_exit/trigger events/nfs/nfs_wri=
tepage_setup/trigger events/nfs/nfs_writepages/trigger events/nfs/nfs_write=
pages_done/trigger events/nfs/nfs_xdr_bad_filehandle/trigger events/nfs/nfs=
_xdr_status/trigger events/nmi/nmi_handler/trigger events/notifier/notifier=
_register/trigger events/notifier/notifier_run/trigger events/notifier/noti=
fier_unregister/trigger events/nvme/nvme_async_event/trigger events/nvme/nv=
me_complete_rq/trigger events/nvme/nvme_setup_cmd/trigger events/nvme/nvme_=
sq/trigger events/oom/compact_retry/trigger events/oom/finish_task_reaping/=
trigger events/oom/mark_victim/trigger events/oom/oom_score_adj_update/trig=
ger events/oom/reclaim_retry_zone/trigger events/oom/skip_task_reaping/trig=
ger events/oom/start_task_reaping/trigger events/oom/wake_reaper/trigger ev=
ents/osnoise/irq_noise/trigger events/osnoise/nmi_noise/trigger events/osno=
ise/osnoise_sample/trigger events/osnoise/sample_threshold/trigger events/o=
snoise/softirq_noise/trigger events/osnoise/thread_noise/trigger events/osn=
oise/timerlat_sample/trigger events/page_isolation/test_pages_isolated/trig=
ger events/page_pool/page_pool_release/trigger events/page_pool/page_pool_s=
tate_hold/trigger events/page_pool/page_pool_state_release/trigger events/p=
age_pool/page_pool_update_nid/trigger events/pagemap/mm_lru_activate/trigge=
r events/pagemap/mm_lru_insertion/trigger events/pci/pci_hp_event/trigger e=
vents/pci/pcie_link_event/trigger events/pci_controller/pcie_ltssm_state_tr=
ansition/trigger events/percpu/percpu_alloc_percpu/trigger events/percpu/pe=
rcpu_alloc_percpu_fail/trigger events/percpu/percpu_create_chunk/trigger ev=
ents/percpu/percpu_destroy_chunk/trigger events/percpu/percpu_free_percpu/t=
rigger events/power/cpu_frequency/trigger events/power/cpu_frequency_limits=
/trigger events/power/cpu_idle/trigger events/power/cpu_idle_miss/trigger e=
vents/power/dev_pm_qos_add_request/trigger events/power/dev_pm_qos_remove_r=
equest/trigger events/power/dev_pm_qos_update_request/trigger events/power/=
device_pm_callback_end/trigger events/power/device_pm_callback_start/trigge=
r events/power/guest_halt_poll_ns/trigger events/power/pm_qos_add_request/t=
rigger events/power/pm_qos_remove_request/trigger events/power/pm_qos_updat=
e_flags/trigger events/power/pm_qos_update_request/trigger events/power/pm_=
qos_update_target/trigger events/power/pstate_sample/trigger events/power/s=
uspend_resume/trigger events/power/wakeup_source_activate/trigger events/po=
wer/wakeup_source_deactivate/trigger events/preemptirq/irq_disable/trigger =
events/preemptirq/irq_enable/trigger events/preemptirq/preempt_disable/trig=
ger events/preemptirq/preempt_enable/trigger events/printk/console/trigger =
events/pwm/pwm_apply/trigger events/pwm/pwm_get/trigger events/pwm/pwm_read=
_waveform/trigger events/pwm/pwm_round_waveform_fromhw/trigger events/pwm/p=
wm_round_waveform_tohw/trigger events/pwm/pwm_write_waveform/trigger events=
/qdisc/qdisc_create/trigger events/qdisc/qdisc_dequeue/trigger events/qdisc=
/qdisc_destroy/trigger events/qdisc/qdisc_drop/trigger events/qdisc/qdisc_e=
nqueue/trigger events/qdisc/qdisc_reset/trigger events/ras/aer_event/trigge=
r events/ras/arm_event/trigger events/ras/extlog_mem_event/trigger events/r=
as/mc_event/trigger events/ras/non_standard_event/trigger events/raw_syscal=
ls/sys_enter/trigger events/raw_syscalls/sys_exit/trigger events/rcu/rcu_st=
all_warning/trigger events/rcu/rcu_utilization/trigger events/rdma_cma/cm_a=
dd_one/trigger events/rdma_cma/cm_disconnect/trigger events/rdma_cma/cm_eve=
nt_done/trigger events/rdma_cma/cm_event_handler/trigger events/rdma_cma/cm=
_id_attach/trigger events/rdma_cma/cm_id_destroy/trigger events/rdma_cma/cm=
_prepare_mra/trigger events/rdma_cma/cm_qp_create/trigger events/rdma_cma/c=
m_qp_destroy/trigger events/rdma_cma/cm_remove_one/trigger events/rdma_cma/=
cm_req_handler/trigger events/rdma_cma/cm_send_rej/trigger events/rdma_cma/=
cm_send_rep/trigger events/rdma_cma/cm_send_req/trigger events/rdma_cma/cm_=
send_rtu/trigger events/rdma_cma/cm_send_sidr_rep/trigger events/rdma_cma/c=
m_send_sidr_req/trigger events/rdma_cma/cm_sent_drep/trigger events/rdma_cm=
a/cm_sent_dreq/trigger events/rdma_core/cq_alloc/trigger events/rdma_core/c=
q_alloc_error/trigger events/rdma_core/cq_drain_complete/trigger events/rdm=
a_core/cq_free/trigger events/rdma_core/cq_modify/trigger events/rdma_core/=
cq_poll/trigger events/rdma_core/cq_process/trigger events/rdma_core/cq_res=
chedule/trigger events/rdma_core/cq_schedule/trigger events/rdma_core/mr_al=
loc/trigger events/rdma_core/mr_dereg/trigger events/rdma_core/mr_integ_all=
oc/trigger events/readahead/page_cache_async_ra/trigger events/readahead/pa=
ge_cache_ra_order/trigger events/readahead/page_cache_ra_unbounded/trigger =
events/readahead/page_cache_sync_ra/trigger events/regmap/regcache_drop_reg=
ion/trigger events/regmap/regcache_sync/trigger events/regmap/regmap_async_=
complete_done/trigger events/regmap/regmap_async_complete_start/trigger eve=
nts/regmap/regmap_async_io_complete/trigger events/regmap/regmap_async_writ=
e_start/trigger events/regmap/regmap_bulk_read/trigger events/regmap/regmap=
_bulk_write/trigger events/regmap/regmap_cache_bypass/trigger events/regmap=
/regmap_cache_only/trigger events/regmap/regmap_hw_read_done/trigger events=
/regmap/regmap_hw_read_start/trigger events/regmap/regmap_hw_write_done/tri=
gger events/regmap/regmap_hw_write_start/trigger events/regmap/regmap_reg_r=
ead/trigger events/regmap/regmap_reg_read_cache/trigger events/regmap/regma=
p_reg_write/trigger events/resctrl/mon_llc_occupancy_limbo/trigger events/r=
esctrl/pseudo_lock_l2/trigger events/resctrl/pseudo_lock_l3/trigger events/=
resctrl/pseudo_lock_mem_latency/trigger events/rpm/rpm_idle/trigger events/=
rpm/rpm_resume/trigger events/rpm/rpm_return_int/trigger events/rpm/rpm_sta=
tus/trigger events/rpm/rpm_suspend/trigger events/rpm/rpm_usage/trigger eve=
nts/rseq/rseq_ip_fixup/trigger events/rseq/rseq_update/trigger events/rtc/r=
tc_alarm_irq_enable/trigger events/rtc/rtc_irq_set_freq/trigger events/rtc/=
rtc_irq_set_state/trigger events/rtc/rtc_read_alarm/trigger events/rtc/rtc_=
read_offset/trigger events/rtc/rtc_read_time/trigger events/rtc/rtc_set_ala=
rm/trigger events/rtc/rtc_set_offset/trigger events/rtc/rtc_set_time/trigge=
r events/rtc/rtc_timer_dequeue/trigger events/rtc/rtc_timer_enqueue/trigger=
 events/rtc/rtc_timer_fired/trigger events/rv/error_wwnr/trigger events/rv/=
event_wwnr/trigger events/rv/rv_retries_error/trigger events/sched/sched_kt=
hread_stop/trigger events/sched/sched_kthread_stop_ret/trigger events/sched=
/sched_kthread_work_execute_end/trigger events/sched/sched_kthread_work_exe=
cute_start/trigger events/sched/sched_kthread_work_queue_work/trigger event=
s/sched/sched_migrate_task/trigger events/sched/sched_move_numa/trigger eve=
nts/sched/sched_pi_setprio/trigger events/sched/sched_prepare_exec/trigger =
events/sched/sched_process_exec/trigger events/sched/sched_process_exit/tri=
gger events/sched/sched_process_fork/trigger events/sched/sched_process_fre=
e/trigger events/sched/sched_process_hang/trigger events/sched/sched_proces=
s_wait/trigger events/sched/sched_skip_cpuset_numa/trigger events/sched/sch=
ed_skip_vma_numa/trigger events/sched/sched_stat_blocked/trigger events/sch=
ed/sched_stat_iowait/trigger events/sched/sched_stat_runtime/trigger events=
/sched/sched_stat_sleep/trigger events/sched/sched_stat_wait/trigger events=
/sched/sched_stick_numa/trigger events/sched/sched_swap_numa/trigger events=
/sched/sched_switch/trigger events/sched/sched_wait_task/trigger events/sch=
ed/sched_wake_idle_without_ipi/trigger events/sched/sched_wakeup/trigger ev=
ents/sched/sched_wakeup_new/trigger events/sched/sched_waking/trigger event=
s/sched_ext/sched_ext_bypass_lb/trigger events/sched_ext/sched_ext_dump/tri=
gger events/sched_ext/sched_ext_event/trigger events/scsi/scsi_dispatch_cmd=
_done/trigger events/scsi/scsi_dispatch_cmd_error/trigger events/scsi/scsi_=
dispatch_cmd_start/trigger events/scsi/scsi_dispatch_cmd_timeout/trigger ev=
ents/scsi/scsi_eh_wakeup/trigger events/signal/signal_deliver/trigger event=
s/signal/signal_generate/trigger events/skb/consume_skb/trigger events/skb/=
kfree_skb/trigger events/skb/skb_copy_datagram_iovec/trigger events/smbus/s=
mbus_read/trigger events/smbus/smbus_reply/trigger events/smbus/smbus_resul=
t/trigger events/smbus/smbus_write/trigger events/smc/smc_rx_recvmsg/trigge=
r events/smc/smc_switch_to_fallback/trigger events/smc/smc_tx_sendmsg/trigg=
er events/smc/smcr_link_down/trigger events/sock/inet_sk_error_report/trigg=
er events/sock/inet_sock_set_state/trigger events/sock/sk_data_ready/trigge=
r events/sock/sock_exceed_buf_limit/trigger events/sock/sock_rcvqueue_full/=
trigger events/sock/sock_recv_length/trigger events/sock/sock_send_length/t=
rigger events/sof/sof_ipc3_period_elapsed_position/trigger events/sof/sof_i=
pc4_fw_config/trigger events/sof/sof_pcm_pointer_position/trigger events/so=
f/sof_stream_position_ipc_rx/trigger events/sof/sof_widget_free/trigger eve=
nts/sof/sof_widget_setup/trigger events/sof_intel/sof_intel_D0I3C_updated/t=
rigger events/sof_intel/sof_intel_hda_dsp_check_stream_irq/trigger events/s=
of_intel/sof_intel_hda_dsp_pcm/trigger events/sof_intel/sof_intel_hda_dsp_s=
tream_status/trigger events/sof_intel/sof_intel_hda_irq/trigger events/sof_=
intel/sof_intel_hda_irq_ipc_check/trigger events/sof_intel/sof_intel_ipc_fi=
rmware_initiated/trigger events/sof_intel/sof_intel_ipc_firmware_response/t=
rigger events/spi/spi_controller_busy/trigger events/spi/spi_controller_idl=
e/trigger events/spi/spi_message_done/trigger events/spi/spi_message_start/=
trigger events/spi/spi_message_submit/trigger events/spi/spi_set_cs/trigger=
 events/spi/spi_setup/trigger events/spi/spi_transfer_start/trigger events/=
spi/spi_transfer_stop/trigger events/sunrpc/cache_entry_expired/trigger eve=
nts/sunrpc/cache_entry_make_negative/trigger events/sunrpc/cache_entry_no_l=
istener/trigger events/sunrpc/cache_entry_upcall/trigger events/sunrpc/cach=
e_entry_update/trigger events/sunrpc/pmap_register/trigger events/sunrpc/rp=
c__auth_tooweak/trigger events/sunrpc/rpc__bad_creds/trigger events/sunrpc/=
rpc__garbage_args/trigger events/sunrpc/rpc__mismatch/trigger events/sunrpc=
/rpc__proc_unavail/trigger events/sunrpc/rpc__prog_mismatch/trigger events/=
sunrpc/rpc__prog_unavail/trigger events/sunrpc/rpc__stale_creds/trigger eve=
nts/sunrpc/rpc__unparsable/trigger events/sunrpc/rpc_bad_callhdr/trigger ev=
ents/sunrpc/rpc_bad_verifier/trigger events/sunrpc/rpc_buf_alloc/trigger ev=
ents/sunrpc/rpc_call_rpcerror/trigger events/sunrpc/rpc_call_status/trigger=
 events/sunrpc/rpc_clnt_clone_err/trigger events/sunrpc/rpc_clnt_free/trigg=
er events/sunrpc/rpc_clnt_killall/trigger events/sunrpc/rpc_clnt_new/trigge=
r events/sunrpc/rpc_clnt_new_err/trigger events/sunrpc/rpc_clnt_release/tri=
gger events/sunrpc/rpc_clnt_replace_xprt/trigger events/sunrpc/rpc_clnt_rep=
lace_xprt_err/trigger events/sunrpc/rpc_clnt_shutdown/trigger events/sunrpc=
/rpc_connect_status/trigger events/sunrpc/rpc_refresh_status/trigger events=
/sunrpc/rpc_request/trigger events/sunrpc/rpc_retry_refresh_status/trigger =
events/sunrpc/rpc_socket_close/trigger events/sunrpc/rpc_socket_connect/tri=
gger events/sunrpc/rpc_socket_error/trigger events/sunrpc/rpc_socket_nospac=
e/trigger events/sunrpc/rpc_socket_reset_connection/trigger events/sunrpc/r=
pc_socket_shutdown/trigger events/sunrpc/rpc_socket_state_change/trigger ev=
ents/sunrpc/rpc_stats_latency/trigger events/sunrpc/rpc_task_begin/trigger =
events/sunrpc/rpc_task_call_done/trigger events/sunrpc/rpc_task_complete/tr=
igger events/sunrpc/rpc_task_end/trigger events/sunrpc/rpc_task_run_action/=
trigger events/sunrpc/rpc_task_signalled/trigger events/sunrpc/rpc_task_sle=
ep/trigger events/sunrpc/rpc_task_sync_sleep/trigger events/sunrpc/rpc_task=
_sync_wake/trigger events/sunrpc/rpc_task_timeout/trigger events/sunrpc/rpc=
_task_wakeup/trigger events/sunrpc/rpc_timeout_status/trigger events/sunrpc=
/rpc_tls_not_started/trigger events/sunrpc/rpc_tls_unavailable/trigger even=
ts/sunrpc/rpc_xdr_alignment/trigger events/sunrpc/rpc_xdr_overflow/trigger =
events/sunrpc/rpc_xdr_recvfrom/trigger events/sunrpc/rpc_xdr_reply_pages/tr=
igger events/sunrpc/rpc_xdr_sendto/trigger events/sunrpc/rpcb_bind_version_=
err/trigger events/sunrpc/rpcb_getport/trigger events/sunrpc/rpcb_prog_unav=
ail_err/trigger events/sunrpc/rpcb_register/trigger events/sunrpc/rpcb_setp=
ort/trigger events/sunrpc/rpcb_timeout_err/trigger events/sunrpc/rpcb_unrea=
chable_err/trigger events/sunrpc/rpcb_unrecognized_err/trigger events/sunrp=
c/rpcb_unregister/trigger events/sunrpc/svc_alloc_arg_err/trigger events/su=
nrpc/svc_authenticate/trigger events/sunrpc/svc_defer/trigger events/sunrpc=
/svc_defer_drop/trigger events/sunrpc/svc_defer_queue/trigger events/sunrpc=
/svc_defer_recv/trigger events/sunrpc/svc_drop/trigger events/sunrpc/svc_no=
register/trigger events/sunrpc/svc_pool_thread_noidle/trigger events/sunrpc=
/svc_pool_thread_running/trigger events/sunrpc/svc_pool_thread_wake/trigger=
 events/sunrpc/svc_process/trigger events/sunrpc/svc_register/trigger event=
s/sunrpc/svc_replace_page_err/trigger events/sunrpc/svc_send/trigger events=
/sunrpc/svc_stats_latency/trigger events/sunrpc/svc_tls_not_started/trigger=
 events/sunrpc/svc_tls_start/trigger events/sunrpc/svc_tls_timed_out/trigge=
r events/sunrpc/svc_tls_unavailable/trigger events/sunrpc/svc_tls_upcall/tr=
igger events/sunrpc/svc_unregister/trigger events/sunrpc/svc_xdr_recvfrom/t=
rigger events/sunrpc/svc_xdr_sendto/trigger events/sunrpc/svc_xprt_accept/t=
rigger events/sunrpc/svc_xprt_close/trigger events/sunrpc/svc_xprt_create_e=
rr/trigger events/sunrpc/svc_xprt_dequeue/trigger events/sunrpc/svc_xprt_de=
tach/trigger events/sunrpc/svc_xprt_enqueue/trigger events/sunrpc/svc_xprt_=
free/trigger events/sunrpc/svc_xprt_no_write_space/trigger events/sunrpc/sv=
csock_accept_err/trigger events/sunrpc/svcsock_data_ready/trigger events/su=
nrpc/svcsock_free/trigger events/sunrpc/svcsock_getpeername_err/trigger eve=
nts/sunrpc/svcsock_marker/trigger events/sunrpc/svcsock_new/trigger events/=
sunrpc/svcsock_tcp_recv/trigger events/sunrpc/svcsock_tcp_recv_eagain/trigg=
er events/sunrpc/svcsock_tcp_recv_err/trigger events/sunrpc/svcsock_tcp_rec=
v_short/trigger events/sunrpc/svcsock_tcp_send/trigger events/sunrpc/svcsoc=
k_tcp_state/trigger events/sunrpc/svcsock_udp_recv/trigger events/sunrpc/sv=
csock_udp_recv_err/trigger events/sunrpc/svcsock_udp_send/trigger events/su=
nrpc/svcsock_write_space/trigger events/sunrpc/xprt_connect/trigger events/=
sunrpc/xprt_create/trigger events/sunrpc/xprt_destroy/trigger events/sunrpc=
/xprt_disconnect_auto/trigger events/sunrpc/xprt_disconnect_done/trigger ev=
ents/sunrpc/xprt_disconnect_force/trigger events/sunrpc/xprt_get_cong/trigg=
er events/sunrpc/xprt_lookup_rqst/trigger events/sunrpc/xprt_ping/trigger e=
vents/sunrpc/xprt_put_cong/trigger events/sunrpc/xprt_release_cong/trigger =
events/sunrpc/xprt_release_xprt/trigger events/sunrpc/xprt_reserve/trigger =
events/sunrpc/xprt_reserve_cong/trigger events/sunrpc/xprt_reserve_xprt/tri=
gger events/sunrpc/xprt_retransmit/trigger events/sunrpc/xprt_timer/trigger=
 events/sunrpc/xprt_transmit/trigger events/sunrpc/xs_data_ready/trigger ev=
ents/sunrpc/xs_stream_read_data/trigger events/sunrpc/xs_stream_read_reques=
t/trigger events/swiotlb/swiotlb_bounced/trigger events/syscalls/sys_enter_=
accept/trigger events/syscalls/sys_enter_accept4/trigger events/syscalls/sy=
s_enter_access/trigger events/syscalls/sys_enter_acct/trigger events/syscal=
ls/sys_enter_add_key/trigger events/syscalls/sys_enter_adjtimex/trigger eve=
nts/syscalls/sys_enter_alarm/trigger events/syscalls/sys_enter_arch_prctl/t=
rigger events/syscalls/sys_enter_bind/trigger events/syscalls/sys_enter_bpf=
/trigger events/syscalls/sys_enter_brk/trigger events/syscalls/sys_enter_ca=
chestat/trigger events/syscalls/sys_enter_capget/trigger events/syscalls/sy=
s_enter_capset/trigger events/syscalls/sys_enter_chdir/trigger events/sysca=
lls/sys_enter_chmod/trigger events/syscalls/sys_enter_chown/trigger events/=
syscalls/sys_enter_chroot/trigger events/syscalls/sys_enter_clock_adjtime/t=
rigger events/syscalls/sys_enter_clock_getres/trigger events/syscalls/sys_e=
nter_clock_gettime/trigger events/syscalls/sys_enter_clock_nanosleep/trigge=
r events/syscalls/sys_enter_clock_settime/trigger events/syscalls/sys_enter=
_clone/trigger events/syscalls/sys_enter_clone3/trigger events/syscalls/sys=
_enter_close/trigger events/syscalls/sys_enter_close_range/trigger events/s=
yscalls/sys_enter_connect/trigger events/syscalls/sys_enter_copy_file_range=
/trigger events/syscalls/sys_enter_creat/trigger events/syscalls/sys_enter_=
delete_module/trigger events/syscalls/sys_enter_dup/trigger events/syscalls=
/sys_enter_dup2/trigger events/syscalls/sys_enter_dup3/trigger events/sysca=
lls/sys_enter_epoll_create/trigger events/syscalls/sys_enter_epoll_create1/=
trigger events/syscalls/sys_enter_epoll_ctl/trigger events/syscalls/sys_ent=
er_epoll_pwait/trigger events/syscalls/sys_enter_epoll_pwait2/trigger event=
s/syscalls/sys_enter_epoll_wait/trigger events/syscalls/sys_enter_eventfd/t=
rigger events/syscalls/sys_enter_eventfd2/trigger events/syscalls/sys_enter=
_execve/trigger events/syscalls/sys_enter_execveat/trigger events/syscalls/=
sys_enter_exit/trigger events/syscalls/sys_enter_exit_group/trigger events/=
syscalls/sys_enter_faccessat/trigger events/syscalls/sys_enter_faccessat2/t=
rigger events/syscalls/sys_enter_fadvise64/trigger events/syscalls/sys_ente=
r_fallocate/trigger events/syscalls/sys_enter_fanotify_init/trigger events/=
syscalls/sys_enter_fanotify_mark/trigger events/syscalls/sys_enter_fchdir/t=
rigger events/syscalls/sys_enter_fchmod/trigger events/syscalls/sys_enter_f=
chmodat/trigger events/syscalls/sys_enter_fchmodat2/trigger events/syscalls=
/sys_enter_fchown/trigger events/syscalls/sys_enter_fchownat/trigger events=
/syscalls/sys_enter_fcntl/trigger events/syscalls/sys_enter_fdatasync/trigg=
er events/syscalls/sys_enter_fgetxattr/trigger events/syscalls/sys_enter_fi=
le_getattr/trigger events/syscalls/sys_enter_file_setattr/trigger events/sy=
scalls/sys_enter_finit_module/trigger events/syscalls/sys_enter_flistxattr/=
trigger events/syscalls/sys_enter_flock/trigger events/syscalls/sys_enter_f=
ork/trigger events/syscalls/sys_enter_fremovexattr/trigger events/syscalls/=
sys_enter_fsconfig/trigger events/syscalls/sys_enter_fsetxattr/trigger even=
ts/syscalls/sys_enter_fsmount/trigger events/syscalls/sys_enter_fsopen/trig=
ger events/syscalls/sys_enter_fspick/trigger events/syscalls/sys_enter_fsta=
tfs/trigger events/syscalls/sys_enter_fsync/trigger events/syscalls/sys_ent=
er_ftruncate/trigger events/syscalls/sys_enter_futex/trigger events/syscall=
s/sys_enter_futex_requeue/trigger events/syscalls/sys_enter_futex_wait/trig=
ger events/syscalls/sys_enter_futex_waitv/trigger events/syscalls/sys_enter=
_futex_wake/trigger events/syscalls/sys_enter_futimesat/trigger events/sysc=
alls/sys_enter_get_mempolicy/trigger events/syscalls/sys_enter_get_robust_l=
ist/trigger events/syscalls/sys_enter_getcpu/trigger events/syscalls/sys_en=
ter_getcwd/trigger events/syscalls/sys_enter_getdents/trigger events/syscal=
ls/sys_enter_getdents64/trigger events/syscalls/sys_enter_getegid/trigger e=
vents/syscalls/sys_enter_geteuid/trigger events/syscalls/sys_enter_getgid/t=
rigger events/syscalls/sys_enter_getgroups/trigger events/syscalls/sys_ente=
r_getitimer/trigger events/syscalls/sys_enter_getpeername/trigger events/sy=
scalls/sys_enter_getpgid/trigger events/syscalls/sys_enter_getpgrp/trigger =
events/syscalls/sys_enter_getpid/trigger events/syscalls/sys_enter_getppid/=
trigger events/syscalls/sys_enter_getpriority/trigger events/syscalls/sys_e=
nter_getrandom/trigger events/syscalls/sys_enter_getresgid/trigger events/s=
yscalls/sys_enter_getresuid/trigger events/syscalls/sys_enter_getrlimit/tri=
gger events/syscalls/sys_enter_getrusage/trigger events/syscalls/sys_enter_=
getsid/trigger events/syscalls/sys_enter_getsockname/trigger events/syscall=
s/sys_enter_getsockopt/trigger events/syscalls/sys_enter_gettid/trigger eve=
nts/syscalls/sys_enter_gettimeofday/trigger events/syscalls/sys_enter_getui=
d/trigger events/syscalls/sys_enter_getxattr/trigger events/syscalls/sys_en=
ter_getxattrat/trigger events/syscalls/sys_enter_init_module/trigger events=
/syscalls/sys_enter_inotify_add_watch/trigger events/syscalls/sys_enter_ino=
tify_init/trigger events/syscalls/sys_enter_inotify_init1/trigger events/sy=
scalls/sys_enter_inotify_rm_watch/trigger events/syscalls/sys_enter_io_canc=
el/trigger events/syscalls/sys_enter_io_destroy/trigger events/syscalls/sys=
_enter_io_getevents/trigger events/syscalls/sys_enter_io_pgetevents/trigger=
 events/syscalls/sys_enter_io_setup/trigger events/syscalls/sys_enter_io_su=
bmit/trigger events/syscalls/sys_enter_io_uring_enter/trigger events/syscal=
ls/sys_enter_io_uring_register/trigger events/syscalls/sys_enter_io_uring_s=
etup/trigger events/syscalls/sys_enter_ioctl/trigger events/syscalls/sys_en=
ter_ioperm/trigger events/syscalls/sys_enter_iopl/trigger events/syscalls/s=
ys_enter_ioprio_get/trigger events/syscalls/sys_enter_ioprio_set/trigger ev=
ents/syscalls/sys_enter_kcmp/trigger events/syscalls/sys_enter_kexec_file_l=
oad/trigger events/syscalls/sys_enter_kexec_load/trigger events/syscalls/sy=
s_enter_keyctl/trigger events/syscalls/sys_enter_kill/trigger events/syscal=
ls/sys_enter_lchown/trigger events/syscalls/sys_enter_lgetxattr/trigger eve=
nts/syscalls/sys_enter_link/trigger events/syscalls/sys_enter_linkat/trigge=
r events/syscalls/sys_enter_listen/trigger events/syscalls/sys_enter_listmo=
unt/trigger events/syscalls/sys_enter_listns/trigger events/syscalls/sys_en=
ter_listxattr/trigger events/syscalls/sys_enter_listxattrat/trigger events/=
syscalls/sys_enter_llistxattr/trigger events/syscalls/sys_enter_lremovexatt=
r/trigger events/syscalls/sys_enter_lseek/trigger events/syscalls/sys_enter=
_lsetxattr/trigger events/syscalls/sys_enter_lsm_get_self_attr/trigger even=
ts/syscalls/sys_enter_lsm_list_modules/trigger events/syscalls/sys_enter_ls=
m_set_self_attr/trigger events/syscalls/sys_enter_madvise/trigger events/sy=
scalls/sys_enter_mbind/trigger events/syscalls/sys_enter_membarrier/trigger=
 events/syscalls/sys_enter_memfd_create/trigger events/syscalls/sys_enter_m=
emfd_secret/trigger events/syscalls/sys_enter_migrate_pages/trigger events/=
syscalls/sys_enter_mincore/trigger events/syscalls/sys_enter_mkdir/trigger =
events/syscalls/sys_enter_mkdirat/trigger events/syscalls/sys_enter_mknod/t=
rigger events/syscalls/sys_enter_mknodat/trigger events/syscalls/sys_enter_=
mlock/trigger events/syscalls/sys_enter_mlock2/trigger events/syscalls/sys_=
enter_mlockall/trigger events/syscalls/sys_enter_mmap/trigger events/syscal=
ls/sys_enter_modify_ldt/trigger events/syscalls/sys_enter_mount/trigger eve=
nts/syscalls/sys_enter_mount_setattr/trigger events/syscalls/sys_enter_move=
_mount/trigger events/syscalls/sys_enter_move_pages/trigger events/syscalls=
/sys_enter_mprotect/trigger events/syscalls/sys_enter_mq_getsetattr/trigger=
 events/syscalls/sys_enter_mq_notify/trigger events/syscalls/sys_enter_mq_o=
pen/trigger events/syscalls/sys_enter_mq_timedreceive/trigger events/syscal=
ls/sys_enter_mq_timedsend/trigger events/syscalls/sys_enter_mq_unlink/trigg=
er events/syscalls/sys_enter_mremap/trigger events/syscalls/sys_enter_mseal=
/trigger events/syscalls/sys_enter_msgctl/trigger events/syscalls/sys_enter=
_msgget/trigger events/syscalls/sys_enter_msgrcv/trigger events/syscalls/sy=
s_enter_msgsnd/trigger events/syscalls/sys_enter_msync/trigger events/sysca=
lls/sys_enter_munlock/trigger events/syscalls/sys_enter_munlockall/trigger =
events/syscalls/sys_enter_munmap/trigger events/syscalls/sys_enter_name_to_=
handle_at/trigger events/syscalls/sys_enter_nanosleep/trigger events/syscal=
ls/sys_enter_newfstat/trigger events/syscalls/sys_enter_newfstatat/trigger =
events/syscalls/sys_enter_newlstat/trigger events/syscalls/sys_enter_newsta=
t/trigger events/syscalls/sys_enter_newuname/trigger events/syscalls/sys_en=
ter_open/trigger events/syscalls/sys_enter_open_by_handle_at/trigger events=
/syscalls/sys_enter_open_tree/trigger events/syscalls/sys_enter_open_tree_a=
ttr/trigger events/syscalls/sys_enter_openat/trigger events/syscalls/sys_en=
ter_openat2/trigger events/syscalls/sys_enter_pause/trigger events/syscalls=
/sys_enter_perf_event_open/trigger events/syscalls/sys_enter_personality/tr=
igger events/syscalls/sys_enter_pidfd_getfd/trigger events/syscalls/sys_ent=
er_pidfd_open/trigger events/syscalls/sys_enter_pidfd_send_signal/trigger e=
vents/syscalls/sys_enter_pipe/trigger events/syscalls/sys_enter_pipe2/trigg=
er events/syscalls/sys_enter_pivot_root/trigger events/syscalls/sys_enter_p=
key_alloc/trigger events/syscalls/sys_enter_pkey_free/trigger events/syscal=
ls/sys_enter_pkey_mprotect/trigger events/syscalls/sys_enter_poll/trigger e=
vents/syscalls/sys_enter_ppoll/trigger events/syscalls/sys_enter_prctl/trig=
ger events/syscalls/sys_enter_pread64/trigger events/syscalls/sys_enter_pre=
adv/trigger events/syscalls/sys_enter_preadv2/trigger events/syscalls/sys_e=
nter_prlimit64/trigger events/syscalls/sys_enter_process_madvise/trigger ev=
ents/syscalls/sys_enter_process_mrelease/trigger events/syscalls/sys_enter_=
process_vm_readv/trigger events/syscalls/sys_enter_process_vm_writev/trigge=
r events/syscalls/sys_enter_pselect6/trigger events/syscalls/sys_enter_ptra=
ce/trigger events/syscalls/sys_enter_pwrite64/trigger events/syscalls/sys_e=
nter_pwritev/trigger events/syscalls/sys_enter_pwritev2/trigger events/sysc=
alls/sys_enter_quotactl/trigger events/syscalls/sys_enter_quotactl_fd/trigg=
er events/syscalls/sys_enter_read/trigger events/syscalls/sys_enter_readahe=
ad/trigger events/syscalls/sys_enter_readlink/trigger events/syscalls/sys_e=
nter_readlinkat/trigger events/syscalls/sys_enter_readv/trigger events/sysc=
alls/sys_enter_reboot/trigger events/syscalls/sys_enter_recvfrom/trigger ev=
ents/syscalls/sys_enter_recvmmsg/trigger events/syscalls/sys_enter_recvmsg/=
trigger events/syscalls/sys_enter_remap_file_pages/trigger events/syscalls/=
sys_enter_removexattr/trigger events/syscalls/sys_enter_removexattrat/trigg=
er events/syscalls/sys_enter_rename/trigger events/syscalls/sys_enter_renam=
eat/trigger events/syscalls/sys_enter_renameat2/trigger events/syscalls/sys=
_enter_request_key/trigger events/syscalls/sys_enter_restart_syscall/trigge=
r events/syscalls/sys_enter_rmdir/trigger events/syscalls/sys_enter_rseq/tr=
igger events/syscalls/sys_enter_rt_sigaction/trigger events/syscalls/sys_en=
ter_rt_sigpending/trigger events/syscalls/sys_enter_rt_sigprocmask/trigger =
events/syscalls/sys_enter_rt_sigqueueinfo/trigger events/syscalls/sys_enter=
_rt_sigreturn/trigger events/syscalls/sys_enter_rt_sigsuspend/trigger event=
s/syscalls/sys_enter_rt_sigtimedwait/trigger events/syscalls/sys_enter_rt_t=
gsigqueueinfo/trigger events/syscalls/sys_enter_sched_get_priority_max/trig=
ger events/syscalls/sys_enter_sched_get_priority_min/trigger events/syscall=
s/sys_enter_sched_getaffinity/trigger events/syscalls/sys_enter_sched_getat=
tr/trigger events/syscalls/sys_enter_sched_getparam/trigger events/syscalls=
/sys_enter_sched_getscheduler/trigger events/syscalls/sys_enter_sched_rr_ge=
t_interval/trigger events/syscalls/sys_enter_sched_setaffinity/trigger even=
ts/syscalls/sys_enter_sched_setattr/trigger events/syscalls/sys_enter_sched=
_setparam/trigger events/syscalls/sys_enter_sched_setscheduler/trigger even=
ts/syscalls/sys_enter_sched_yield/trigger events/syscalls/sys_enter_seccomp=
/trigger events/syscalls/sys_enter_select/trigger events/syscalls/sys_enter=
_semctl/trigger events/syscalls/sys_enter_semget/trigger events/syscalls/sy=
s_enter_semop/trigger events/syscalls/sys_enter_semtimedop/trigger events/s=
yscalls/sys_enter_sendfile64/trigger events/syscalls/sys_enter_sendmmsg/tri=
gger events/syscalls/sys_enter_sendmsg/trigger events/syscalls/sys_enter_se=
ndto/trigger events/syscalls/sys_enter_set_mempolicy/trigger events/syscall=
s/sys_enter_set_mempolicy_home_node/trigger events/syscalls/sys_enter_set_r=
obust_list/trigger events/syscalls/sys_enter_set_tid_address/trigger events=
/syscalls/sys_enter_setdomainname/trigger events/syscalls/sys_enter_setfsgi=
d/trigger events/syscalls/sys_enter_setfsuid/trigger events/syscalls/sys_en=
ter_setgid/trigger events/syscalls/sys_enter_setgroups/trigger events/sysca=
lls/sys_enter_sethostname/trigger events/syscalls/sys_enter_setitimer/trigg=
er events/syscalls/sys_enter_setns/trigger events/syscalls/sys_enter_setpgi=
d/trigger events/syscalls/sys_enter_setpriority/trigger events/syscalls/sys=
_enter_setregid/trigger events/syscalls/sys_enter_setresgid/trigger events/=
syscalls/sys_enter_setresuid/trigger events/syscalls/sys_enter_setreuid/tri=
gger events/syscalls/sys_enter_setrlimit/trigger events/syscalls/sys_enter_=
setsid/trigger events/syscalls/sys_enter_setsockopt/trigger events/syscalls=
/sys_enter_settimeofday/trigger events/syscalls/sys_enter_setuid/trigger ev=
ents/syscalls/sys_enter_setxattr/trigger events/syscalls/sys_enter_setxattr=
at/trigger events/syscalls/sys_enter_shmat/trigger events/syscalls/sys_ente=
r_shmctl/trigger events/syscalls/sys_enter_shmdt/trigger events/syscalls/sy=
s_enter_shmget/trigger events/syscalls/sys_enter_shutdown/trigger events/sy=
scalls/sys_enter_sigaltstack/trigger events/syscalls/sys_enter_signalfd/tri=
gger events/syscalls/sys_enter_signalfd4/trigger events/syscalls/sys_enter_=
socket/trigger events/syscalls/sys_enter_socketpair/trigger events/syscalls=
/sys_enter_splice/trigger events/syscalls/sys_enter_statfs/trigger events/s=
yscalls/sys_enter_statmount/trigger events/syscalls/sys_enter_statx/trigger=
 events/syscalls/sys_enter_swapoff/trigger events/syscalls/sys_enter_swapon=
/trigger events/syscalls/sys_enter_symlink/trigger events/syscalls/sys_ente=
r_symlinkat/trigger events/syscalls/sys_enter_sync/trigger events/syscalls/=
sys_enter_sync_file_range/trigger events/syscalls/sys_enter_syncfs/trigger =
events/syscalls/sys_enter_sysfs/trigger events/syscalls/sys_enter_sysinfo/t=
rigger events/syscalls/sys_enter_syslog/trigger events/syscalls/sys_enter_t=
ee/trigger events/syscalls/sys_enter_tgkill/trigger events/syscalls/sys_ent=
er_time/trigger events/syscalls/sys_enter_timer_create/trigger events/sysca=
lls/sys_enter_timer_delete/trigger events/syscalls/sys_enter_timer_getoverr=
un/trigger events/syscalls/sys_enter_timer_gettime/trigger events/syscalls/=
sys_enter_timer_settime/trigger events/syscalls/sys_enter_timerfd_create/tr=
igger events/syscalls/sys_enter_timerfd_gettime/trigger events/syscalls/sys=
_enter_timerfd_settime/trigger events/syscalls/sys_enter_times/trigger even=
ts/syscalls/sys_enter_tkill/trigger events/syscalls/sys_enter_truncate/trig=
ger events/syscalls/sys_enter_umask/trigger events/syscalls/sys_enter_umoun=
t/trigger events/syscalls/sys_enter_unlink/trigger events/syscalls/sys_ente=
r_unlinkat/trigger events/syscalls/sys_enter_unshare/trigger events/syscall=
s/sys_enter_uprobe/trigger events/syscalls/sys_enter_uretprobe/trigger even=
ts/syscalls/sys_enter_userfaultfd/trigger events/syscalls/sys_enter_ustat/t=
rigger events/syscalls/sys_enter_utime/trigger events/syscalls/sys_enter_ut=
imensat/trigger events/syscalls/sys_enter_utimes/trigger events/syscalls/sy=
s_enter_vfork/trigger events/syscalls/sys_enter_vhangup/trigger events/sysc=
alls/sys_enter_vmsplice/trigger events/syscalls/sys_enter_wait4/trigger eve=
nts/syscalls/sys_enter_waitid/trigger events/syscalls/sys_enter_write/trigg=
er events/syscalls/sys_enter_writev/trigger events/syscalls/sys_exit_accept=
/trigger events/syscalls/sys_exit_accept4/trigger events/syscalls/sys_exit_=
access/trigger events/syscalls/sys_exit_acct/trigger events/syscalls/sys_ex=
it_add_key/trigger events/syscalls/sys_exit_adjtimex/trigger events/syscall=
s/sys_exit_alarm/trigger events/syscalls/sys_exit_arch_prctl/trigger events=
/syscalls/sys_exit_bind/trigger events/syscalls/sys_exit_bpf/trigger events=
/syscalls/sys_exit_brk/trigger events/syscalls/sys_exit_cachestat/trigger e=
vents/syscalls/sys_exit_capget/trigger events/syscalls/sys_exit_capset/trig=
ger events/syscalls/sys_exit_chdir/trigger events/syscalls/sys_exit_chmod/t=
rigger events/syscalls/sys_exit_chown/trigger events/syscalls/sys_exit_chro=
ot/trigger events/syscalls/sys_exit_clock_adjtime/trigger events/syscalls/s=
ys_exit_clock_getres/trigger events/syscalls/sys_exit_clock_gettime/trigger=
 events/syscalls/sys_exit_clock_nanosleep/trigger events/syscalls/sys_exit_=
clock_settime/trigger events/syscalls/sys_exit_clone/trigger events/syscall=
s/sys_exit_clone3/trigger events/syscalls/sys_exit_close/trigger events/sys=
calls/sys_exit_close_range/trigger events/syscalls/sys_exit_connect/trigger=
 events/syscalls/sys_exit_copy_file_range/trigger events/syscalls/sys_exit_=
creat/trigger events/syscalls/sys_exit_delete_module/trigger events/syscall=
s/sys_exit_dup/trigger events/syscalls/sys_exit_dup2/trigger events/syscall=
s/sys_exit_dup3/trigger events/syscalls/sys_exit_epoll_create/trigger event=
s/syscalls/sys_exit_epoll_create1/trigger events/syscalls/sys_exit_epoll_ct=
l/trigger events/syscalls/sys_exit_epoll_pwait/trigger events/syscalls/sys_=
exit_epoll_pwait2/trigger events/syscalls/sys_exit_epoll_wait/trigger event=
s/syscalls/sys_exit_eventfd/trigger events/syscalls/sys_exit_eventfd2/trigg=
er events/syscalls/sys_exit_execve/trigger events/syscalls/sys_exit_execvea=
t/trigger events/syscalls/sys_exit_exit/trigger events/syscalls/sys_exit_ex=
it_group/trigger events/syscalls/sys_exit_faccessat/trigger events/syscalls=
/sys_exit_faccessat2/trigger events/syscalls/sys_exit_fadvise64/trigger eve=
nts/syscalls/sys_exit_fallocate/trigger events/syscalls/sys_exit_fanotify_i=
nit/trigger events/syscalls/sys_exit_fanotify_mark/trigger events/syscalls/=
sys_exit_fchdir/trigger events/syscalls/sys_exit_fchmod/trigger events/sysc=
alls/sys_exit_fchmodat/trigger events/syscalls/sys_exit_fchmodat2/trigger e=
vents/syscalls/sys_exit_fchown/trigger events/syscalls/sys_exit_fchownat/tr=
igger events/syscalls/sys_exit_fcntl/trigger events/syscalls/sys_exit_fdata=
sync/trigger events/syscalls/sys_exit_fgetxattr/trigger events/syscalls/sys=
_exit_file_getattr/trigger events/syscalls/sys_exit_file_setattr/trigger ev=
ents/syscalls/sys_exit_finit_module/trigger events/syscalls/sys_exit_flistx=
attr/trigger events/syscalls/sys_exit_flock/trigger events/syscalls/sys_exi=
t_fork/trigger events/syscalls/sys_exit_fremovexattr/trigger events/syscall=
s/sys_exit_fsconfig/trigger events/syscalls/sys_exit_fsetxattr/trigger even=
ts/syscalls/sys_exit_fsmount/trigger events/syscalls/sys_exit_fsopen/trigge=
r events/syscalls/sys_exit_fspick/trigger events/syscalls/sys_exit_fstatfs/=
trigger events/syscalls/sys_exit_fsync/trigger events/syscalls/sys_exit_ftr=
uncate/trigger events/syscalls/sys_exit_futex/trigger events/syscalls/sys_e=
xit_futex_requeue/trigger events/syscalls/sys_exit_futex_wait/trigger event=
s/syscalls/sys_exit_futex_waitv/trigger events/syscalls/sys_exit_futex_wake=
/trigger events/syscalls/sys_exit_futimesat/trigger events/syscalls/sys_exi=
t_get_mempolicy/trigger events/syscalls/sys_exit_get_robust_list/trigger ev=
ents/syscalls/sys_exit_getcpu/trigger events/syscalls/sys_exit_getcwd/trigg=
er events/syscalls/sys_exit_getdents/trigger events/syscalls/sys_exit_getde=
nts64/trigger events/syscalls/sys_exit_getegid/trigger events/syscalls/sys_=
exit_geteuid/trigger events/syscalls/sys_exit_getgid/trigger events/syscall=
s/sys_exit_getgroups/trigger events/syscalls/sys_exit_getitimer/trigger eve=
nts/syscalls/sys_exit_getpeername/trigger events/syscalls/sys_exit_getpgid/=
trigger events/syscalls/sys_exit_getpgrp/trigger events/syscalls/sys_exit_g=
etpid/trigger events/syscalls/sys_exit_getppid/trigger events/syscalls/sys_=
exit_getpriority/trigger events/syscalls/sys_exit_getrandom/trigger events/=
syscalls/sys_exit_getresgid/trigger events/syscalls/sys_exit_getresuid/trig=
ger events/syscalls/sys_exit_getrlimit/trigger events/syscalls/sys_exit_get=
rusage/trigger events/syscalls/sys_exit_getsid/trigger events/syscalls/sys_=
exit_getsockname/trigger events/syscalls/sys_exit_getsockopt/trigger events=
/syscalls/sys_exit_gettid/trigger events/syscalls/sys_exit_gettimeofday/tri=
gger events/syscalls/sys_exit_getuid/trigger events/syscalls/sys_exit_getxa=
ttr/trigger events/syscalls/sys_exit_getxattrat/trigger events/syscalls/sys=
_exit_init_module/trigger events/syscalls/sys_exit_inotify_add_watch/trigge=
r events/syscalls/sys_exit_inotify_init/trigger events/syscalls/sys_exit_in=
otify_init1/trigger events/syscalls/sys_exit_inotify_rm_watch/trigger event=
s/syscalls/sys_exit_io_cancel/trigger events/syscalls/sys_exit_io_destroy/t=
rigger events/syscalls/sys_exit_io_getevents/trigger events/syscalls/sys_ex=
it_io_pgetevents/trigger events/syscalls/sys_exit_io_setup/trigger events/s=
yscalls/sys_exit_io_submit/trigger events/syscalls/sys_exit_io_uring_enter/=
trigger events/syscalls/sys_exit_io_uring_register/trigger events/syscalls/=
sys_exit_io_uring_setup/trigger events/syscalls/sys_exit_ioctl/trigger even=
ts/syscalls/sys_exit_ioperm/trigger events/syscalls/sys_exit_iopl/trigger e=
vents/syscalls/sys_exit_ioprio_get/trigger events/syscalls/sys_exit_ioprio_=
set/trigger events/syscalls/sys_exit_kcmp/trigger events/syscalls/sys_exit_=
kexec_file_load/trigger events/syscalls/sys_exit_kexec_load/trigger events/=
syscalls/sys_exit_keyctl/trigger events/syscalls/sys_exit_kill/trigger even=
ts/syscalls/sys_exit_lchown/trigger events/syscalls/sys_exit_lgetxattr/trig=
ger events/syscalls/sys_exit_link/trigger events/syscalls/sys_exit_linkat/t=
rigger events/syscalls/sys_exit_listen/trigger events/syscalls/sys_exit_lis=
tmount/trigger events/syscalls/sys_exit_listns/trigger events/syscalls/sys_=
exit_listxattr/trigger events/syscalls/sys_exit_listxattrat/trigger events/=
syscalls/sys_exit_llistxattr/trigger events/syscalls/sys_exit_lremovexattr/=
trigger events/syscalls/sys_exit_lseek/trigger events/syscalls/sys_exit_lse=
txattr/trigger events/syscalls/sys_exit_lsm_get_self_attr/trigger events/sy=
scalls/sys_exit_lsm_list_modules/trigger events/syscalls/sys_exit_lsm_set_s=
elf_attr/trigger events/syscalls/sys_exit_madvise/trigger events/syscalls/s=
ys_exit_mbind/trigger events/syscalls/sys_exit_membarrier/trigger events/sy=
scalls/sys_exit_memfd_create/trigger events/syscalls/sys_exit_memfd_secret/=
trigger events/syscalls/sys_exit_migrate_pages/trigger events/syscalls/sys_=
exit_mincore/trigger events/syscalls/sys_exit_mkdir/trigger events/syscalls=
/sys_exit_mkdirat/trigger events/syscalls/sys_exit_mknod/trigger events/sys=
calls/sys_exit_mknodat/trigger events/syscalls/sys_exit_mlock/trigger event=
s/syscalls/sys_exit_mlock2/trigger events/syscalls/sys_exit_mlockall/trigge=
r events/syscalls/sys_exit_mmap/trigger events/syscalls/sys_exit_modify_ldt=
/trigger events/syscalls/sys_exit_mount/trigger events/syscalls/sys_exit_mo=
unt_setattr/trigger events/syscalls/sys_exit_move_mount/trigger events/sysc=
alls/sys_exit_move_pages/trigger events/syscalls/sys_exit_mprotect/trigger =
events/syscalls/sys_exit_mq_getsetattr/trigger events/syscalls/sys_exit_mq_=
notify/trigger events/syscalls/sys_exit_mq_open/trigger events/syscalls/sys=
_exit_mq_timedreceive/trigger events/syscalls/sys_exit_mq_timedsend/trigger=
 events/syscalls/sys_exit_mq_unlink/trigger events/syscalls/sys_exit_mremap=
/trigger events/syscalls/sys_exit_mseal/trigger events/syscalls/sys_exit_ms=
gctl/trigger events/syscalls/sys_exit_msgget/trigger events/syscalls/sys_ex=
it_msgrcv/trigger events/syscalls/sys_exit_msgsnd/trigger events/syscalls/s=
ys_exit_msync/trigger events/syscalls/sys_exit_munlock/trigger events/sysca=
lls/sys_exit_munlockall/trigger events/syscalls/sys_exit_munmap/trigger eve=
nts/syscalls/sys_exit_name_to_handle_at/trigger events/syscalls/sys_exit_na=
nosleep/trigger events/syscalls/sys_exit_newfstat/trigger events/syscalls/s=
ys_exit_newfstatat/trigger events/syscalls/sys_exit_newlstat/trigger events=
/syscalls/sys_exit_newstat/trigger events/syscalls/sys_exit_newuname/trigge=
r events/syscalls/sys_exit_open/trigger events/syscalls/sys_exit_open_by_ha=
ndle_at/trigger events/syscalls/sys_exit_open_tree/trigger events/syscalls/=
sys_exit_open_tree_attr/trigger events/syscalls/sys_exit_openat/trigger eve=
nts/syscalls/sys_exit_openat2/trigger events/syscalls/sys_exit_pause/trigge=
r events/syscalls/sys_exit_perf_event_open/trigger events/syscalls/sys_exit=
_personality/trigger events/syscalls/sys_exit_pidfd_getfd/trigger events/sy=
scalls/sys_exit_pidfd_open/trigger events/syscalls/sys_exit_pidfd_send_sign=
al/trigger events/syscalls/sys_exit_pipe/trigger events/syscalls/sys_exit_p=
ipe2/trigger events/syscalls/sys_exit_pivot_root/trigger events/syscalls/sy=
s_exit_pkey_alloc/trigger events/syscalls/sys_exit_pkey_free/trigger events=
/syscalls/sys_exit_pkey_mprotect/trigger events/syscalls/sys_exit_poll/trig=
ger events/syscalls/sys_exit_ppoll/trigger events/syscalls/sys_exit_prctl/t=
rigger events/syscalls/sys_exit_pread64/trigger events/syscalls/sys_exit_pr=
eadv/trigger events/syscalls/sys_exit_preadv2/trigger events/syscalls/sys_e=
xit_prlimit64/trigger events/syscalls/sys_exit_process_madvise/trigger even=
ts/syscalls/sys_exit_process_mrelease/trigger events/syscalls/sys_exit_proc=
ess_vm_readv/trigger events/syscalls/sys_exit_process_vm_writev/trigger eve=
nts/syscalls/sys_exit_pselect6/trigger events/syscalls/sys_exit_ptrace/trig=
ger events/syscalls/sys_exit_pwrite64/trigger events/syscalls/sys_exit_pwri=
tev/trigger events/syscalls/sys_exit_pwritev2/trigger events/syscalls/sys_e=
xit_quotactl/trigger events/syscalls/sys_exit_quotactl_fd/trigger events/sy=
scalls/sys_exit_read/trigger events/syscalls/sys_exit_readahead/trigger eve=
nts/syscalls/sys_exit_readlink/trigger events/syscalls/sys_exit_readlinkat/=
trigger events/syscalls/sys_exit_readv/trigger events/syscalls/sys_exit_reb=
oot/trigger events/syscalls/sys_exit_recvfrom/trigger events/syscalls/sys_e=
xit_recvmmsg/trigger events/syscalls/sys_exit_recvmsg/trigger events/syscal=
ls/sys_exit_remap_file_pages/trigger events/syscalls/sys_exit_removexattr/t=
rigger events/syscalls/sys_exit_removexattrat/trigger events/syscalls/sys_e=
xit_rename/trigger events/syscalls/sys_exit_renameat/trigger events/syscall=
s/sys_exit_renameat2/trigger events/syscalls/sys_exit_request_key/trigger e=
vents/syscalls/sys_exit_restart_syscall/trigger events/syscalls/sys_exit_rm=
dir/trigger events/syscalls/sys_exit_rseq/trigger events/syscalls/sys_exit_=
rt_sigaction/trigger events/syscalls/sys_exit_rt_sigpending/trigger events/=
syscalls/sys_exit_rt_sigprocmask/trigger events/syscalls/sys_exit_rt_sigque=
ueinfo/trigger events/syscalls/sys_exit_rt_sigreturn/trigger events/syscall=
s/sys_exit_rt_sigsuspend/trigger events/syscalls/sys_exit_rt_sigtimedwait/t=
rigger events/syscalls/sys_exit_rt_tgsigqueueinfo/trigger events/syscalls/s=
ys_exit_sched_get_priority_max/trigger events/syscalls/sys_exit_sched_get_p=
riority_min/trigger events/syscalls/sys_exit_sched_getaffinity/trigger even=
ts/syscalls/sys_exit_sched_getattr/trigger events/syscalls/sys_exit_sched_g=
etparam/trigger events/syscalls/sys_exit_sched_getscheduler/trigger events/=
syscalls/sys_exit_sched_rr_get_interval/trigger events/syscalls/sys_exit_sc=
hed_setaffinity/trigger events/syscalls/sys_exit_sched_setattr/trigger even=
ts/syscalls/sys_exit_sched_setparam/trigger events/syscalls/sys_exit_sched_=
setscheduler/trigger events/syscalls/sys_exit_sched_yield/trigger events/sy=
scalls/sys_exit_seccomp/trigger events/syscalls/sys_exit_select/trigger eve=
nts/syscalls/sys_exit_semctl/trigger events/syscalls/sys_exit_semget/trigge=
r events/syscalls/sys_exit_semop/trigger events/syscalls/sys_exit_semtimedo=
p/trigger events/syscalls/sys_exit_sendfile64/trigger events/syscalls/sys_e=
xit_sendmmsg/trigger events/syscalls/sys_exit_sendmsg/trigger events/syscal=
ls/sys_exit_sendto/trigger events/syscalls/sys_exit_set_mempolicy/trigger e=
vents/syscalls/sys_exit_set_mempolicy_home_node/trigger events/syscalls/sys=
_exit_set_robust_list/trigger events/syscalls/sys_exit_set_tid_address/trig=
ger events/syscalls/sys_exit_setdomainname/trigger events/syscalls/sys_exit=
_setfsgid/trigger events/syscalls/sys_exit_setfsuid/trigger events/syscalls=
/sys_exit_setgid/trigger events/syscalls/sys_exit_setgroups/trigger events/=
syscalls/sys_exit_sethostname/trigger events/syscalls/sys_exit_setitimer/tr=
igger events/syscalls/sys_exit_setns/trigger events/syscalls/sys_exit_setpg=
id/trigger events/syscalls/sys_exit_setpriority/trigger events/syscalls/sys=
_exit_setregid/trigger events/syscalls/sys_exit_setresgid/trigger events/sy=
scalls/sys_exit_setresuid/trigger events/syscalls/sys_exit_setreuid/trigger=
 events/syscalls/sys_exit_setrlimit/trigger events/syscalls/sys_exit_setsid=
/trigger events/syscalls/sys_exit_setsockopt/trigger events/syscalls/sys_ex=
it_settimeofday/trigger events/syscalls/sys_exit_setuid/trigger events/sysc=
alls/sys_exit_setxattr/trigger events/syscalls/sys_exit_setxattrat/trigger =
events/syscalls/sys_exit_shmat/trigger events/syscalls/sys_exit_shmctl/trig=
ger events/syscalls/sys_exit_shmdt/trigger events/syscalls/sys_exit_shmget/=
trigger events/syscalls/sys_exit_shutdown/trigger events/syscalls/sys_exit_=
sigaltstack/trigger events/syscalls/sys_exit_signalfd/trigger events/syscal=
ls/sys_exit_signalfd4/trigger events/syscalls/sys_exit_socket/trigger event=
s/syscalls/sys_exit_socketpair/trigger events/syscalls/sys_exit_splice/trig=
ger events/syscalls/sys_exit_statfs/trigger events/syscalls/sys_exit_statmo=
unt/trigger events/syscalls/sys_exit_statx/trigger events/syscalls/sys_exit=
_swapoff/trigger events/syscalls/sys_exit_swapon/trigger events/syscalls/sy=
s_exit_symlink/trigger events/syscalls/sys_exit_symlinkat/trigger events/sy=
scalls/sys_exit_sync/trigger events/syscalls/sys_exit_sync_file_range/trigg=
er events/syscalls/sys_exit_syncfs/trigger events/syscalls/sys_exit_sysfs/t=
rigger events/syscalls/sys_exit_sysinfo/trigger events/syscalls/sys_exit_sy=
slog/trigger events/syscalls/sys_exit_tee/trigger events/syscalls/sys_exit_=
tgkill/trigger events/syscalls/sys_exit_time/trigger events/syscalls/sys_ex=
it_timer_create/trigger events/syscalls/sys_exit_timer_delete/trigger event=
s/syscalls/sys_exit_timer_getoverrun/trigger events/syscalls/sys_exit_timer=
_gettime/trigger events/syscalls/sys_exit_timer_settime/trigger events/sysc=
alls/sys_exit_timerfd_create/trigger events/syscalls/sys_exit_timerfd_getti=
me/trigger events/syscalls/sys_exit_timerfd_settime/trigger events/syscalls=
/sys_exit_times/trigger events/syscalls/sys_exit_tkill/trigger events/sysca=
lls/sys_exit_truncate/trigger events/syscalls/sys_exit_umask/trigger events=
/syscalls/sys_exit_umount/trigger events/syscalls/sys_exit_unlink/trigger e=
vents/syscalls/sys_exit_unlinkat/trigger events/syscalls/sys_exit_unshare/t=
rigger events/syscalls/sys_exit_uprobe/trigger events/syscalls/sys_exit_ure=
tprobe/trigger events/syscalls/sys_exit_userfaultfd/trigger events/syscalls=
/sys_exit_ustat/trigger events/syscalls/sys_exit_utime/trigger events/sysca=
lls/sys_exit_utimensat/trigger events/syscalls/sys_exit_utimes/trigger even=
ts/syscalls/sys_exit_vfork/trigger events/syscalls/sys_exit_vhangup/trigger=
 events/syscalls/sys_exit_vmsplice/trigger events/syscalls/sys_exit_wait4/t=
rigger events/syscalls/sys_exit_waitid/trigger events/syscalls/sys_exit_wri=
te/trigger events/syscalls/sys_exit_writev/trigger events/task/task_newtask=
/trigger events/task/task_prctl_unknown/trigger events/task/task_rename/tri=
gger events/tcp/tcp_ao_handshake_failure/trigger events/tcp/tcp_ao_key_not_=
found/trigger events/tcp/tcp_ao_mismatch/trigger events/tcp/tcp_ao_rcv_sne_=
update/trigger events/tcp/tcp_ao_rnext_request/trigger events/tcp/tcp_ao_sn=
d_sne_update/trigger events/tcp/tcp_ao_synack_no_key/trigger events/tcp/tcp=
_ao_wrong_maclen/trigger events/tcp/tcp_bad_csum/trigger events/tcp/tcp_con=
g_state_set/trigger events/tcp/tcp_destroy_sock/trigger events/tcp/tcp_hash=
_ao_required/trigger events/tcp/tcp_hash_bad_header/trigger events/tcp/tcp_=
hash_md5_mismatch/trigger events/tcp/tcp_hash_md5_required/trigger events/t=
cp/tcp_hash_md5_unexpected/trigger events/tcp/tcp_probe/trigger events/tcp/=
tcp_rcv_space_adjust/trigger events/tcp/tcp_rcvbuf_grow/trigger events/tcp/=
tcp_receive_reset/trigger events/tcp/tcp_retransmit_skb/trigger events/tcp/=
tcp_retransmit_synack/trigger events/tcp/tcp_send_reset/trigger events/tcp/=
tcp_sendmsg_locked/trigger events/thermal/cdev_update/trigger events/therma=
l/thermal_temperature/trigger events/thermal/thermal_zone_trip/trigger even=
ts/thp/remove_migration_pmd/trigger events/thp/set_migration_pmd/trigger ev=
ents/thunderbolt/tb_event/trigger events/thunderbolt/tb_rx/trigger events/t=
hunderbolt/tb_tx/trigger events/timer/hrtimer_cancel/trigger events/timer/h=
rtimer_expire_entry/trigger events/timer/hrtimer_expire_exit/trigger events=
/timer/hrtimer_rearm/trigger events/timer/hrtimer_setup/trigger events/time=
r/hrtimer_start/trigger events/timer/hrtimer_start_expired/trigger events/t=
imer/itimer_expire/trigger events/timer/itimer_state/trigger events/timer/t=
ick_stop/trigger events/timer/timer_base_idle/trigger events/timer/timer_ca=
ncel/trigger events/timer/timer_expire_entry/trigger events/timer/timer_exp=
ire_exit/trigger events/timer/timer_init/trigger events/timer/timer_start/t=
rigger events/timer_migration/tmigr_connect_child_parent/trigger events/tim=
er_migration/tmigr_connect_cpu_parent/trigger events/timer_migration/tmigr_=
cpu_active/trigger events/timer_migration/tmigr_cpu_available/trigger event=
s/timer_migration/tmigr_cpu_idle/trigger events/timer_migration/tmigr_cpu_n=
ew_timer/trigger events/timer_migration/tmigr_cpu_new_timer_idle/trigger ev=
ents/timer_migration/tmigr_cpu_unavailable/trigger events/timer_migration/t=
migr_group_set/trigger events/timer_migration/tmigr_group_set_cpu_active/tr=
igger events/timer_migration/tmigr_group_set_cpu_inactive/trigger events/ti=
mer_migration/tmigr_handle_remote/trigger events/timer_migration/tmigr_hand=
le_remote_cpu/trigger events/timer_migration/tmigr_update_events/trigger ev=
ents/timestamp/ctime_ns_xchg/trigger events/timestamp/ctime_xchg_skip/trigg=
er events/timestamp/fill_mg_cmtime/trigger events/timestamp/inode_set_ctime=
_to_ts/trigger events/tlb/tlb_flush/trigger events/tsm_mr/tsm_mr_read/trigg=
er events/tsm_mr/tsm_mr_refresh/trigger events/tsm_mr/tsm_mr_write/trigger =
events/ucsi/ucsi_connector_change/trigger events/ucsi/ucsi_register_altmode=
/trigger events/ucsi/ucsi_register_port/trigger events/ucsi/ucsi_reset_ppm/=
trigger events/ucsi/ucsi_run_command/trigger events/udp/udp_fail_queue_rcv_=
skb/trigger events/usbcore/usb_alloc_dev/trigger events/usbcore/usb_set_dev=
ice_state/trigger events/vmalloc/alloc_vmap_area/trigger events/vmalloc/fre=
e_vmap_area_noflush/trigger events/vmalloc/purge_vmap_area_lazy/trigger eve=
nts/vmscan/mm_shrink_slab_end/trigger events/vmscan/mm_shrink_slab_start/tr=
igger events/vmscan/mm_vmscan_balance_pgdat_begin/trigger events/vmscan/mm_=
vmscan_balance_pgdat_end/trigger events/vmscan/mm_vmscan_direct_reclaim_beg=
in/trigger events/vmscan/mm_vmscan_direct_reclaim_end/trigger events/vmscan=
/mm_vmscan_kswapd_clear_hopeless/trigger events/vmscan/mm_vmscan_kswapd_rec=
laim_fail/trigger events/vmscan/mm_vmscan_kswapd_sleep/trigger events/vmsca=
n/mm_vmscan_kswapd_wake/trigger events/vmscan/mm_vmscan_lru_isolate/trigger=
 events/vmscan/mm_vmscan_lru_shrink_active/trigger events/vmscan/mm_vmscan_=
lru_shrink_inactive/trigger events/vmscan/mm_vmscan_memcg_reclaim_begin/tri=
gger events/vmscan/mm_vmscan_memcg_reclaim_end/trigger events/vmscan/mm_vms=
can_memcg_softlimit_reclaim_begin/trigger events/vmscan/mm_vmscan_memcg_sof=
tlimit_reclaim_end/trigger events/vmscan/mm_vmscan_node_reclaim_begin/trigg=
er events/vmscan/mm_vmscan_node_reclaim_end/trigger events/vmscan/mm_vmscan=
_reclaim_pages/trigger events/vmscan/mm_vmscan_throttled/trigger events/vms=
can/mm_vmscan_wakeup_kswapd/trigger events/vmscan/mm_vmscan_write_folio/tri=
gger events/vsyscall/emulate_vsyscall/trigger events/watchdog/watchdog_ping=
/trigger events/watchdog/watchdog_set_timeout/trigger events/watchdog/watch=
dog_start/trigger events/watchdog/watchdog_stop/trigger events/wbt/wbt_lat/=
trigger events/wbt/wbt_stat/trigger events/wbt/wbt_step/trigger events/wbt/=
wbt_timer/trigger events/workqueue/workqueue_activate_work/trigger events/w=
orkqueue/workqueue_execute_end/trigger events/workqueue/workqueue_execute_s=
tart/trigger events/workqueue/workqueue_queue_work/trigger events/writeback=
/balance_dirty_pages/trigger events/writeback/bdi_dirty_ratelimit/trigger e=
vents/writeback/flush_foreign/trigger events/writeback/folio_wait_writeback=
/trigger events/writeback/global_dirty_state/trigger events/writeback/inode=
_foreign_history/trigger events/writeback/inode_switch_wbs/trigger events/w=
riteback/inode_switch_wbs_queue/trigger events/writeback/sb_clear_inode_wri=
teback/trigger events/writeback/sb_mark_inode_writeback/trigger events/writ=
eback/track_foreign_dirty/trigger events/writeback/wbc_writepage/trigger ev=
ents/writeback/writeback_bdi_register/trigger events/writeback/writeback_di=
rty_folio/trigger events/writeback/writeback_dirty_inode/trigger events/wri=
teback/writeback_dirty_inode_enqueue/trigger events/writeback/writeback_dir=
ty_inode_start/trigger events/writeback/writeback_exec/trigger events/write=
back/writeback_lazytime/trigger events/writeback/writeback_mark_inode_dirty=
/trigger events/writeback/writeback_pages_written/trigger events/writeback/=
writeback_queue/trigger events/writeback/writeback_queue_io/trigger events/=
writeback/writeback_sb_inodes_requeue/trigger events/writeback/writeback_si=
ngle_inode/trigger events/writeback/writeback_single_inode_start/trigger ev=
ents/writeback/writeback_start/trigger events/writeback/writeback_wait/trig=
ger events/writeback/writeback_wake_background/trigger events/writeback/wri=
teback_write_inode/trigger events/writeback/writeback_write_inode_start/tri=
gger events/writeback/writeback_written/trigger events/x86_fpu/x86_fpu_afte=
r_save/trigger events/x86_fpu/x86_fpu_before_save/trigger events/x86_fpu/x8=
6_fpu_copy_dst/trigger events/x86_fpu/x86_fpu_dropped/trigger events/x86_fp=
u/x86_fpu_regs_activated/trigger events/x86_fpu/x86_fpu_regs_deactivated/tr=
igger events/x86_fpu/x86_fpu_xstate_check_failed/trigger events/xdp/bpf_xdp=
_link_attach_failed/trigger events/xdp/mem_connect/trigger events/xdp/mem_d=
isconnect/trigger events/xdp/xdp_bulk_tx/trigger events/xdp/xdp_cpumap_enqu=
eue/trigger events/xdp/xdp_cpumap_kthread/trigger events/xdp/xdp_devmap_xmi=
t/trigger events/xdp/xdp_exception/trigger events/xdp/xdp_redirect/trigger =
events/xdp/xdp_redirect_err/trigger events/xen/xen_cpu_load_idt/trigger eve=
nts/xen/xen_cpu_set_ldt/trigger events/xen/xen_cpu_write_gdt_entry/trigger =
events/xen/xen_cpu_write_idt_entry/trigger events/xen/xen_cpu_write_ldt_ent=
ry/trigger events/xen/xen_mc_batch/trigger events/xen/xen_mc_callback/trigg=
er events/xen/xen_mc_entry/trigger events/xen/xen_mc_entry_alloc/trigger ev=
ents/xen/xen_mc_extend_args/trigger events/xen/xen_mc_flush/trigger events/=
xen/xen_mc_flush_reason/trigger events/xen/xen_mc_issue/trigger events/xen/=
xen_mmu_alloc_ptpage/trigger events/xen/xen_mmu_flush_tlb_multi/trigger eve=
nts/xen/xen_mmu_flush_tlb_one_user/trigger events/xen/xen_mmu_pgd_pin/trigg=
er events/xen/xen_mmu_pgd_unpin/trigger events/xen/xen_mmu_ptep_modify_prot=
_commit/trigger events/xen/xen_mmu_ptep_modify_prot_start/trigger events/xe=
n/xen_mmu_release_ptpage/trigger events/xen/xen_mmu_set_p4d/trigger events/=
xen/xen_mmu_set_pmd/trigger events/xen/xen_mmu_set_pte/trigger events/xen/x=
en_mmu_set_pud/trigger events/xen/xen_mmu_write_cr3/trigger events/xhci-hcd=
/xhci_add_endpoint/trigger events/xhci-hcd/xhci_address_ctrl_ctx/trigger ev=
ents/xhci-hcd/xhci_address_ctx/trigger events/xhci-hcd/xhci_alloc_dev/trigg=
er events/xhci-hcd/xhci_alloc_stream_info_ctx/trigger events/xhci-hcd/xhci_=
alloc_virt_device/trigger events/xhci-hcd/xhci_configure_endpoint/trigger e=
vents/xhci-hcd/xhci_configure_endpoint_ctrl_ctx/trigger events/xhci-hcd/xhc=
i_dbc_alloc_request/trigger events/xhci-hcd/xhci_dbc_free_request/trigger e=
vents/xhci-hcd/xhci_dbc_gadget_ep_queue/trigger events/xhci-hcd/xhci_dbc_gi=
veback_request/trigger events/xhci-hcd/xhci_dbc_handle_event/trigger events=
/xhci-hcd/xhci_dbc_handle_transfer/trigger events/xhci-hcd/xhci_dbc_queue_r=
equest/trigger events/xhci-hcd/xhci_dbg_address/trigger events/xhci-hcd/xhc=
i_dbg_cancel_urb/trigger events/xhci-hcd/xhci_dbg_context_change/trigger ev=
ents/xhci-hcd/xhci_dbg_init/trigger events/xhci-hcd/xhci_dbg_quirks/trigger=
 events/xhci-hcd/xhci_dbg_reset_ep/trigger events/xhci-hcd/xhci_dbg_ring_ex=
pansion/trigger events/xhci-hcd/xhci_discover_or_reset_device/trigger event=
s/xhci-hcd/xhci_free_dev/trigger events/xhci-hcd/xhci_free_virt_device/trig=
ger events/xhci-hcd/xhci_get_port_status/trigger events/xhci-hcd/xhci_handl=
e_cmd_addr_dev/trigger events/xhci-hcd/xhci_handle_cmd_config_ep/trigger ev=
ents/xhci-hcd/xhci_handle_cmd_disable_slot/trigger events/xhci-hcd/xhci_han=
dle_cmd_reset_dev/trigger events/xhci-hcd/xhci_handle_cmd_reset_ep/trigger =
events/xhci-hcd/xhci_handle_cmd_set_deq/trigger events/xhci-hcd/xhci_handle=
_cmd_set_deq_ep/trigger events/xhci-hcd/xhci_handle_cmd_set_deq_stream/trig=
ger events/xhci-hcd/xhci_handle_cmd_stop_ep/trigger events/xhci-hcd/xhci_ha=
ndle_command/trigger events/xhci-hcd/xhci_handle_event/trigger events/xhci-=
hcd/xhci_handle_port_status/trigger events/xhci-hcd/xhci_handle_transfer/tr=
igger events/xhci-hcd/xhci_hub_status_data/trigger events/xhci-hcd/xhci_inc=
_deq/trigger events/xhci-hcd/xhci_inc_enq/trigger events/xhci-hcd/xhci_port=
sc_writel/trigger events/xhci-hcd/xhci_queue_trb/trigger events/xhci-hcd/xh=
ci_ring_alloc/trigger events/xhci-hcd/xhci_ring_ep_doorbell/trigger events/=
xhci-hcd/xhci_ring_expansion/trigger events/xhci-hcd/xhci_ring_free/trigger=
 events/xhci-hcd/xhci_ring_host_doorbell/trigger events/xhci-hcd/xhci_setup=
_addressable_virt_device/trigger events/xhci-hcd/xhci_setup_device/trigger =
events/xhci-hcd/xhci_setup_device_slot/trigger events/xhci-hcd/xhci_stop_de=
vice/trigger events/xhci-hcd/xhci_urb_dequeue/trigger events/xhci-hcd/xhci_=
urb_enqueue/trigger events/xhci-hcd/xhci_urb_giveback/trigger
# # + read line
# # + grep -H ':on[^:]*(' events/9p/9p_client_req/trigger events/9p/9p_clie=
nt_res/trigger events/9p/9p_fid_ref/trigger events/9p/9p_protocol_dump/trig=
ger events/alarmtimer/alarmtimer_cancel/trigger events/alarmtimer/alarmtime=
r_fired/trigger events/alarmtimer/alarmtimer_start/trigger events/alarmtime=
r/alarmtimer_suspend/trigger events/amd_cpu/amd_pstate_cppc_req2/trigger ev=
ents/amd_cpu/amd_pstate_epp_perf/trigger events/amd_cpu/amd_pstate_perf/tri=
gger events/asoc/snd_soc_bias_level_done/trigger events/asoc/snd_soc_bias_l=
evel_start/trigger events/asoc/snd_soc_dapm_connected/trigger events/asoc/s=
nd_soc_dapm_done/trigger events/asoc/snd_soc_dapm_path/trigger events/asoc/=
snd_soc_dapm_start/trigger events/asoc/snd_soc_dapm_walk_done/trigger event=
s/asoc/snd_soc_dapm_widget_event_done/trigger events/asoc/snd_soc_dapm_widg=
et_event_start/trigger events/asoc/snd_soc_dapm_widget_power/trigger events=
/asoc/snd_soc_jack_irq/trigger events/asoc/snd_soc_jack_notify/trigger even=
ts/asoc/snd_soc_jack_report/trigger events/avc/selinux_audited/trigger even=
ts/block/blk_zone_append_update_request_bio/trigger events/block/blk_zone_w=
plug_bio/trigger events/block/blkdev_zone_mgmt/trigger events/block/block_b=
io_backmerge/trigger events/block/block_bio_complete/trigger events/block/b=
lock_bio_frontmerge/trigger events/block/block_bio_queue/trigger events/blo=
ck/block_bio_remap/trigger events/block/block_dirty_buffer/trigger events/b=
lock/block_getrq/trigger events/block/block_io_done/trigger events/block/bl=
ock_io_start/trigger events/block/block_plug/trigger events/block/block_rq_=
complete/trigger events/block/block_rq_error/trigger events/block/block_rq_=
insert/trigger events/block/block_rq_issue/trigger events/block/block_rq_me=
rge/trigger events/block/block_rq_remap/trigger events/block/block_rq_reque=
ue/trigger events/block/block_rq_tag_wait/trigger events/block/block_split/=
trigger events/block/block_touch_buffer/trigger events/block/block_unplug/t=
rigger events/block/disk_zone_wplug_add_bio/trigger events/bpf_test_run/bpf=
_test_finish/trigger events/bpf_test_run/bpf_trigger_tp/trigger events/bpf_=
trace/bpf_trace_printk/trigger events/bridge/br_fdb_add/trigger events/brid=
ge/br_fdb_external_learn_add/trigger events/bridge/br_fdb_update/trigger ev=
ents/bridge/br_mdb_full/trigger events/bridge/fdb_delete/trigger events/btr=
fs/add_delayed_data_ref/trigger events/btrfs/add_delayed_ref_head/trigger e=
vents/btrfs/add_delayed_tree_ref/trigger events/btrfs/btrfs_add_block_group=
/trigger events/btrfs/btrfs_add_conflicting_inode_enter/trigger events/btrf=
s/btrfs_add_conflicting_inode_exit/trigger events/btrfs/btrfs_add_reclaim_b=
lock_group/trigger events/btrfs/btrfs_add_unused_block_group/trigger events=
/btrfs/btrfs_all_work_done/trigger events/btrfs/btrfs_alloc_extent_state/tr=
igger events/btrfs/btrfs_chunk_alloc/trigger events/btrfs/btrfs_chunk_free/=
trigger events/btrfs/btrfs_clear_extent_bit/trigger events/btrfs/btrfs_conv=
ert_extent_bit/trigger events/btrfs/btrfs_cow_block/trigger events/btrfs/bt=
rfs_done_preemptive_reclaim/trigger events/btrfs/btrfs_extent_map_shrinker_=
count/trigger events/btrfs/btrfs_extent_map_shrinker_remove_em/trigger even=
ts/btrfs/btrfs_extent_map_shrinker_scan_enter/trigger events/btrfs/btrfs_ex=
tent_map_shrinker_scan_exit/trigger events/btrfs/btrfs_fail_all_tickets/tri=
gger events/btrfs/btrfs_failed_cluster_setup/trigger events/btrfs/btrfs_fin=
d_cluster/trigger events/btrfs/btrfs_find_free_extent/trigger events/btrfs/=
btrfs_find_free_extent_have_block_group/trigger events/btrfs/btrfs_find_fre=
e_extent_search_loop/trigger events/btrfs/btrfs_finish_ordered_extent/trigg=
er events/btrfs/btrfs_flush_space/trigger events/btrfs/btrfs_free_extent_st=
ate/trigger events/btrfs/btrfs_get_extent/trigger events/btrfs/btrfs_get_ex=
tent_show_fi_inline/trigger events/btrfs/btrfs_get_extent_show_fi_regular/t=
rigger events/btrfs/btrfs_get_raid_extent_offset/trigger events/btrfs/btrfs=
_handle_em_exist/trigger events/btrfs/btrfs_inode_evict/trigger events/btrf=
s/btrfs_inode_mod_outstanding_extents/trigger events/btrfs/btrfs_inode_new/=
trigger events/btrfs/btrfs_inode_request/trigger events/btrfs/btrfs_insert_=
one_raid_extent/trigger events/btrfs/btrfs_log_all_new_ancestors_enter/trig=
ger events/btrfs/btrfs_log_all_new_ancestors_exit/trigger events/btrfs/btrf=
s_log_all_parents_enter/trigger events/btrfs/btrfs_log_all_parents_exit/tri=
gger events/btrfs/btrfs_log_conflicting_inodes_enter/trigger events/btrfs/b=
trfs_log_conflicting_inodes_exit/trigger events/btrfs/btrfs_log_inode_enter=
/trigger events/btrfs/btrfs_log_inode_exit/trigger events/btrfs/btrfs_log_i=
node_parent_enter/trigger events/btrfs/btrfs_log_inode_parent_exit/trigger =
events/btrfs/btrfs_log_new_delayed_dentries_enter/trigger events/btrfs/btrf=
s_log_new_delayed_dentries_exit/trigger events/btrfs/btrfs_log_new_dir_dent=
ries_enter/trigger events/btrfs/btrfs_log_new_dir_dentries_exit/trigger eve=
nts/btrfs/btrfs_log_new_name_enter/trigger events/btrfs/btrfs_log_new_name_=
exit/trigger events/btrfs/btrfs_ordered_extent_add/trigger events/btrfs/btr=
fs_ordered_extent_dec_test_pending/trigger events/btrfs/btrfs_ordered_exten=
t_lookup/trigger events/btrfs/btrfs_ordered_extent_lookup_first/trigger eve=
nts/btrfs/btrfs_ordered_extent_lookup_first_range/trigger events/btrfs/btrf=
s_ordered_extent_lookup_for_logging/trigger events/btrfs/btrfs_ordered_exte=
nt_lookup_range/trigger events/btrfs/btrfs_ordered_extent_mark_finished/tri=
gger events/btrfs/btrfs_ordered_extent_put/trigger events/btrfs/btrfs_order=
ed_extent_remove/trigger events/btrfs/btrfs_ordered_extent_split/trigger ev=
ents/btrfs/btrfs_ordered_extent_start/trigger events/btrfs/btrfs_ordered_sc=
hed/trigger events/btrfs/btrfs_prelim_ref_insert/trigger events/btrfs/btrfs=
_prelim_ref_merge/trigger events/btrfs/btrfs_qgroup_account_extent/trigger =
events/btrfs/btrfs_qgroup_account_extents/trigger events/btrfs/btrfs_qgroup=
_meta_convert/trigger events/btrfs/btrfs_qgroup_meta_free_all_pertrans/trig=
ger events/btrfs/btrfs_qgroup_meta_reserve/trigger events/btrfs/btrfs_qgrou=
p_num_dirty_extents/trigger events/btrfs/btrfs_qgroup_release_data/trigger =
events/btrfs/btrfs_qgroup_reserve_data/trigger events/btrfs/btrfs_qgroup_tr=
ace_extent/trigger events/btrfs/btrfs_qgroup_update_counters/trigger events=
/btrfs/btrfs_qgroup_update_reserve/trigger events/btrfs/btrfs_raid_extent_d=
elete/trigger events/btrfs/btrfs_reclaim_block_group/trigger events/btrfs/b=
trfs_record_new_subvolume/trigger events/btrfs/btrfs_record_snapshot_destro=
y/trigger events/btrfs/btrfs_record_unlink_dir/trigger events/btrfs/btrfs_r=
emove_block_group/trigger events/btrfs/btrfs_reserve_extent/trigger events/=
btrfs/btrfs_reserve_extent_cluster/trigger events/btrfs/btrfs_reserve_ticke=
t/trigger events/btrfs/btrfs_reserved_extent_alloc/trigger events/btrfs/btr=
fs_reserved_extent_free/trigger events/btrfs/btrfs_search_slot_restart/trig=
ger events/btrfs/btrfs_set_extent_bit/trigger events/btrfs/btrfs_setup_clus=
ter/trigger events/btrfs/btrfs_skip_unused_block_group/trigger events/btrfs=
/btrfs_space_reservation/trigger events/btrfs/btrfs_sync_file_enter/trigger=
 events/btrfs/btrfs_sync_file_exit/trigger events/btrfs/btrfs_sync_fs/trigg=
er events/btrfs/btrfs_sync_log_enter/trigger events/btrfs/btrfs_sync_log_ex=
it/trigger events/btrfs/btrfs_transaction_abort/trigger events/btrfs/btrfs_=
transaction_commit/trigger events/btrfs/btrfs_transaction_start/trigger eve=
nts/btrfs/btrfs_tree_lock/trigger events/btrfs/btrfs_tree_read_lock/trigger=
 events/btrfs/btrfs_tree_read_unlock/trigger events/btrfs/btrfs_tree_unlock=
/trigger events/btrfs/btrfs_trigger_flush/trigger events/btrfs/btrfs_trunca=
te_show_fi_inline/trigger events/btrfs/btrfs_truncate_show_fi_regular/trigg=
er events/btrfs/btrfs_try_tree_read_lock/trigger events/btrfs/btrfs_work_qu=
eued/trigger events/btrfs/btrfs_work_sched/trigger events/btrfs/btrfs_workq=
ueue_alloc/trigger events/btrfs/btrfs_workqueue_destroy/trigger events/btrf=
s/btrfs_writepage_end_io_hook/trigger events/btrfs/extent_writepage/trigger=
 events/btrfs/raid56_read/trigger events/btrfs/raid56_write/trigger events/=
btrfs/run_delayed_data_ref/trigger events/btrfs/run_delayed_ref_head/trigge=
r events/btrfs/run_delayed_tree_ref/trigger events/btrfs/update_bytes_may_u=
se/trigger events/btrfs/update_bytes_pinned/trigger events/btrfs/update_byt=
es_zone_unusable/trigger events/capability/cap_capable/trigger events/cfg80=
211/cfg80211_assoc_comeback/trigger events/cfg80211/cfg80211_bss_color_noti=
fy/trigger events/cfg80211/cfg80211_cac_event/trigger events/cfg80211/cfg80=
211_ch_switch_notify/trigger events/cfg80211/cfg80211_ch_switch_started_not=
ify/trigger events/cfg80211/cfg80211_control_port_tx_status/trigger events/=
cfg80211/cfg80211_cqm_pktloss_notify/trigger events/cfg80211/cfg80211_cqm_r=
ssi_notify/trigger events/cfg80211/cfg80211_del_sta/trigger events/cfg80211=
/cfg80211_epcs_changed/trigger events/cfg80211/cfg80211_ft_event/trigger ev=
ents/cfg80211/cfg80211_get_bss/trigger events/cfg80211/cfg80211_gtk_rekey_n=
otify/trigger events/cfg80211/cfg80211_ibss_joined/trigger events/cfg80211/=
cfg80211_incumbent_signal_notify/trigger events/cfg80211/cfg80211_inform_bs=
s_frame/trigger events/cfg80211/cfg80211_links_removed/trigger events/cfg80=
211/cfg80211_mgmt_tx_status/trigger events/cfg80211/cfg80211_michael_mic_fa=
ilure/trigger events/cfg80211/cfg80211_mlo_reconf_add_done/trigger events/c=
fg80211/cfg80211_nan_channel_evac/trigger events/cfg80211/cfg80211_nan_clus=
ter_joined/trigger events/cfg80211/cfg80211_nan_sched_update_done/trigger e=
vents/cfg80211/cfg80211_nan_ulw_update/trigger events/cfg80211/cfg80211_new=
_sta/trigger events/cfg80211/cfg80211_next_nan_dw_notif/trigger events/cfg8=
0211/cfg80211_notify_new_peer_candidate/trigger events/cfg80211/cfg80211_pm=
ksa_candidate_notify/trigger events/cfg80211/cfg80211_pmsr_complete/trigger=
 events/cfg80211/cfg80211_pmsr_report/trigger events/cfg80211/cfg80211_prob=
e_status/trigger events/cfg80211/cfg80211_radar_event/trigger events/cfg802=
11/cfg80211_ready_on_channel/trigger events/cfg80211/cfg80211_ready_on_chan=
nel_expired/trigger events/cfg80211/cfg80211_reg_can_beacon/trigger events/=
cfg80211/cfg80211_report_obss_beacon/trigger events/cfg80211/cfg80211_repor=
t_wowlan_wakeup/trigger events/cfg80211/cfg80211_return_bool/trigger events=
/cfg80211/cfg80211_return_bss/trigger events/cfg80211/cfg80211_rx_control_p=
ort/trigger events/cfg80211/cfg80211_rx_mgmt/trigger events/cfg80211/cfg802=
11_rx_mlme_mgmt/trigger events/cfg80211/cfg80211_rx_spurious_frame/trigger =
events/cfg80211/cfg80211_rx_unexpected_4addr_frame/trigger events/cfg80211/=
cfg80211_rx_unprot_mlme_mgmt/trigger events/cfg80211/cfg80211_scan_done/tri=
gger events/cfg80211/cfg80211_sched_scan_results/trigger events/cfg80211/cf=
g80211_sched_scan_stopped/trigger events/cfg80211/cfg80211_send_assoc_failu=
re/trigger events/cfg80211/cfg80211_send_auth_timeout/trigger events/cfg802=
11/cfg80211_send_rx_assoc/trigger events/cfg80211/cfg80211_stop_link/trigge=
r events/cfg80211/cfg80211_tdls_oper_request/trigger events/cfg80211/cfg802=
11_tx_mgmt_expired/trigger events/cfg80211/cfg80211_tx_mlme_mgmt/trigger ev=
ents/cfg80211/cfg80211_update_owe_info_event/trigger events/cfg80211/rdev_a=
bort_pmsr/trigger events/cfg80211/rdev_abort_scan/trigger events/cfg80211/r=
dev_add_intf_link/trigger events/cfg80211/rdev_add_key/trigger events/cfg80=
211/rdev_add_link_station/trigger events/cfg80211/rdev_add_mpath/trigger ev=
ents/cfg80211/rdev_add_nan_func/trigger events/cfg80211/rdev_add_station/tr=
igger events/cfg80211/rdev_add_tx_ts/trigger events/cfg80211/rdev_add_virtu=
al_intf/trigger events/cfg80211/rdev_assoc/trigger events/cfg80211/rdev_ass=
oc_ml_reconf/trigger events/cfg80211/rdev_auth/trigger events/cfg80211/rdev=
_cancel_remain_on_channel/trigger events/cfg80211/rdev_change_beacon/trigge=
r events/cfg80211/rdev_change_bss/trigger events/cfg80211/rdev_change_mpath=
/trigger events/cfg80211/rdev_change_station/trigger events/cfg80211/rdev_c=
hange_virtual_intf/trigger events/cfg80211/rdev_channel_switch/trigger even=
ts/cfg80211/rdev_color_change/trigger events/cfg80211/rdev_connect/trigger =
events/cfg80211/rdev_crit_proto_start/trigger events/cfg80211/rdev_crit_pro=
to_stop/trigger events/cfg80211/rdev_deauth/trigger events/cfg80211/rdev_de=
l_intf_link/trigger events/cfg80211/rdev_del_key/trigger events/cfg80211/rd=
ev_del_link_station/trigger events/cfg80211/rdev_del_mpath/trigger events/c=
fg80211/rdev_del_nan_func/trigger events/cfg80211/rdev_del_pmk/trigger even=
ts/cfg80211/rdev_del_pmksa/trigger events/cfg80211/rdev_del_station/trigger=
 events/cfg80211/rdev_del_tx_ts/trigger events/cfg80211/rdev_del_virtual_in=
tf/trigger events/cfg80211/rdev_disassoc/trigger events/cfg80211/rdev_disco=
nnect/trigger events/cfg80211/rdev_dump_mpath/trigger events/cfg80211/rdev_=
dump_mpp/trigger events/cfg80211/rdev_dump_station/trigger events/cfg80211/=
rdev_dump_survey/trigger events/cfg80211/rdev_end_cac/trigger events/cfg802=
11/rdev_external_auth/trigger events/cfg80211/rdev_flush_pmksa/trigger even=
ts/cfg80211/rdev_get_antenna/trigger events/cfg80211/rdev_get_channel/trigg=
er events/cfg80211/rdev_get_ftm_responder_stats/trigger events/cfg80211/rde=
v_get_key/trigger events/cfg80211/rdev_get_mesh_config/trigger events/cfg80=
211/rdev_get_mpath/trigger events/cfg80211/rdev_get_mpp/trigger events/cfg8=
0211/rdev_get_station/trigger events/cfg80211/rdev_get_tx_power/trigger eve=
nts/cfg80211/rdev_get_txq_stats/trigger events/cfg80211/rdev_inform_bss/tri=
gger events/cfg80211/rdev_join_ibss/trigger events/cfg80211/rdev_join_mesh/=
trigger events/cfg80211/rdev_join_ocb/trigger events/cfg80211/rdev_leave_ib=
ss/trigger events/cfg80211/rdev_leave_mesh/trigger events/cfg80211/rdev_lea=
ve_ocb/trigger events/cfg80211/rdev_libertas_set_mesh_channel/trigger event=
s/cfg80211/rdev_mgmt_tx/trigger events/cfg80211/rdev_mgmt_tx_cancel_wait/tr=
igger events/cfg80211/rdev_mod_link_station/trigger events/cfg80211/rdev_na=
n_change_conf/trigger events/cfg80211/rdev_nan_set_local_sched/trigger even=
ts/cfg80211/rdev_nan_set_peer_sched/trigger events/cfg80211/rdev_probe_clie=
nt/trigger events/cfg80211/rdev_probe_mesh_link/trigger events/cfg80211/rde=
v_remain_on_channel/trigger events/cfg80211/rdev_reset_tid_config/trigger e=
vents/cfg80211/rdev_resume/trigger events/cfg80211/rdev_return_chandef/trig=
ger events/cfg80211/rdev_return_int/trigger events/cfg80211/rdev_return_int=
_cookie/trigger events/cfg80211/rdev_return_int_int/trigger events/cfg80211=
/rdev_return_int_mesh_config/trigger events/cfg80211/rdev_return_int_mpath_=
info/trigger events/cfg80211/rdev_return_int_station_info/trigger events/cf=
g80211/rdev_return_int_survey_info/trigger events/cfg80211/rdev_return_int_=
tx_rx/trigger events/cfg80211/rdev_return_void/trigger events/cfg80211/rdev=
_return_void_tx_rx/trigger events/cfg80211/rdev_return_wdev/trigger events/=
cfg80211/rdev_rfkill_poll/trigger events/cfg80211/rdev_scan/trigger events/=
cfg80211/rdev_sched_scan_start/trigger events/cfg80211/rdev_sched_scan_stop=
/trigger events/cfg80211/rdev_set_antenna/trigger events/cfg80211/rdev_set_=
ap_chanwidth/trigger events/cfg80211/rdev_set_bitrate_mask/trigger events/c=
fg80211/rdev_set_coalesce/trigger events/cfg80211/rdev_set_cqm_rssi_config/=
trigger events/cfg80211/rdev_set_cqm_rssi_range_config/trigger events/cfg80=
211/rdev_set_cqm_txe_config/trigger events/cfg80211/rdev_set_default_beacon=
_key/trigger events/cfg80211/rdev_set_default_key/trigger events/cfg80211/r=
dev_set_default_mgmt_key/trigger events/cfg80211/rdev_set_epcs/trigger even=
ts/cfg80211/rdev_set_fils_aad/trigger events/cfg80211/rdev_set_hw_timestamp=
/trigger events/cfg80211/rdev_set_mac_acl/trigger events/cfg80211/rdev_set_=
mcast_rate/trigger events/cfg80211/rdev_set_monitor_channel/trigger events/=
cfg80211/rdev_set_multicast_to_unicast/trigger events/cfg80211/rdev_set_noa=
ck_map/trigger events/cfg80211/rdev_set_pmk/trigger events/cfg80211/rdev_se=
t_pmksa/trigger events/cfg80211/rdev_set_power_mgmt/trigger events/cfg80211=
/rdev_set_qos_map/trigger events/cfg80211/rdev_set_radar_background/trigger=
 events/cfg80211/rdev_set_rekey_data/trigger events/cfg80211/rdev_set_sar_s=
pecs/trigger events/cfg80211/rdev_set_tid_config/trigger events/cfg80211/rd=
ev_set_ttlm/trigger events/cfg80211/rdev_set_tx_power/trigger events/cfg802=
11/rdev_set_txq_params/trigger events/cfg80211/rdev_set_wakeup/trigger even=
ts/cfg80211/rdev_set_wiphy_params/trigger events/cfg80211/rdev_start_ap/tri=
gger events/cfg80211/rdev_start_nan/trigger events/cfg80211/rdev_start_p2p_=
device/trigger events/cfg80211/rdev_start_pd/trigger events/cfg80211/rdev_s=
tart_pmsr/trigger events/cfg80211/rdev_start_radar_detection/trigger events=
/cfg80211/rdev_stop_ap/trigger events/cfg80211/rdev_stop_nan/trigger events=
/cfg80211/rdev_stop_p2p_device/trigger events/cfg80211/rdev_stop_pd/trigger=
 events/cfg80211/rdev_suspend/trigger events/cfg80211/rdev_tdls_cancel_chan=
nel_switch/trigger events/cfg80211/rdev_tdls_channel_switch/trigger events/=
cfg80211/rdev_tdls_mgmt/trigger events/cfg80211/rdev_tdls_oper/trigger even=
ts/cfg80211/rdev_tx_control_port/trigger events/cfg80211/rdev_update_connec=
t_params/trigger events/cfg80211/rdev_update_ft_ies/trigger events/cfg80211=
/rdev_update_mesh_config/trigger events/cfg80211/rdev_update_mgmt_frame_reg=
istrations/trigger events/cfg80211/rdev_update_owe_info/trigger events/cfg8=
0211/wiphy_delayed_work_queue/trigger events/cfg80211/wiphy_hrtimer_work_qu=
eue/trigger events/cfg80211/wiphy_work_cancel/trigger events/cfg80211/wiphy=
_work_flush/trigger events/cfg80211/wiphy_work_queue/trigger events/cfg8021=
1/wiphy_work_run/trigger events/cfg80211/wiphy_work_worker_start/trigger ev=
ents/cgroup/cgroup_attach_task/trigger events/cgroup/cgroup_destroy_root/tr=
igger events/cgroup/cgroup_freeze/trigger events/cgroup/cgroup_mkdir/trigge=
r events/cgroup/cgroup_notify_frozen/trigger events/cgroup/cgroup_notify_po=
pulated/trigger events/cgroup/cgroup_release/trigger events/cgroup/cgroup_r=
emount/trigger events/cgroup/cgroup_rename/trigger events/cgroup/cgroup_rmd=
ir/trigger events/cgroup/cgroup_rstat_lock_contended/trigger events/cgroup/=
cgroup_rstat_locked/trigger events/cgroup/cgroup_rstat_unlock/trigger event=
s/cgroup/cgroup_setup_root/trigger events/cgroup/cgroup_transfer_tasks/trig=
ger events/cgroup/cgroup_unfreeze/trigger events/clk/clk_disable/trigger ev=
ents/clk/clk_disable_complete/trigger events/clk/clk_enable/trigger events/=
clk/clk_enable_complete/trigger events/clk/clk_prepare/trigger events/clk/c=
lk_prepare_complete/trigger events/clk/clk_rate_request_done/trigger events=
/clk/clk_rate_request_start/trigger events/clk/clk_set_duty_cycle/trigger e=
vents/clk/clk_set_duty_cycle_complete/trigger events/clk/clk_set_max_rate/t=
rigger events/clk/clk_set_min_rate/trigger events/clk/clk_set_parent/trigge=
r events/clk/clk_set_parent_complete/trigger events/clk/clk_set_phase/trigg=
er events/clk/clk_set_phase_complete/trigger events/clk/clk_set_rate/trigge=
r events/clk/clk_set_rate_complete/trigger events/clk/clk_set_rate_range/tr=
igger events/clk/clk_unprepare/trigger events/clk/clk_unprepare_complete/tr=
igger events/cma/cma_alloc_busy_retry/trigger events/cma/cma_alloc_finish/t=
rigger events/cma/cma_alloc_start/trigger events/cma/cma_release/trigger ev=
ents/compaction/mm_compaction_begin/trigger events/compaction/mm_compaction=
_defer_compaction/trigger events/compaction/mm_compaction_defer_reset/trigg=
er events/compaction/mm_compaction_deferred/trigger events/compaction/mm_co=
mpaction_end/trigger events/compaction/mm_compaction_fast_isolate_freepages=
/trigger events/compaction/mm_compaction_finished/trigger events/compaction=
/mm_compaction_isolate_freepages/trigger events/compaction/mm_compaction_is=
olate_migratepages/trigger events/compaction/mm_compaction_kcompactd_sleep/=
trigger events/compaction/mm_compaction_kcompactd_wake/trigger events/compa=
ction/mm_compaction_migratepages/trigger events/compaction/mm_compaction_su=
itable/trigger events/compaction/mm_compaction_try_to_compact_pages/trigger=
 events/compaction/mm_compaction_wakeup_kcompactd/trigger events/context_tr=
acking/user_enter/trigger events/context_tracking/user_exit/trigger events/=
coredump/coredump/trigger events/cpuhp/cpuhp_enter/trigger events/cpuhp/cpu=
hp_exit/trigger events/cpuhp/cpuhp_multi_enter/trigger events/csd/csd_funct=
ion_entry/trigger events/csd/csd_function_exit/trigger events/csd/csd_queue=
_cpu/trigger events/damon/damon_aggregated/trigger events/damon/damon_monit=
or_intervals_tune/trigger events/damon/damon_region_aggregated/trigger even=
ts/damon/damos_before_apply/trigger events/damon/damos_esz/trigger events/d=
amon/damos_stat_after_apply_interval/trigger events/dev/devres_log/trigger =
events/devlink/devlink_health_recover_aborted/trigger events/devlink/devlin=
k_health_report/trigger events/devlink/devlink_health_reporter_state_update=
/trigger events/devlink/devlink_hwerr/trigger events/devlink/devlink_hwmsg/=
trigger events/devlink/devlink_trap_report/trigger events/dma/dma_alloc/tri=
gger events/dma/dma_alloc_pages/trigger events/dma/dma_alloc_sgt/trigger ev=
ents/dma/dma_alloc_sgt_err/trigger events/dma/dma_free/trigger events/dma/d=
ma_free_pages/trigger events/dma/dma_free_sgt/trigger events/dma/dma_map_ph=
ys/trigger events/dma/dma_map_sg/trigger events/dma/dma_map_sg_err/trigger =
events/dma/dma_sync_sg_for_cpu/trigger events/dma/dma_sync_sg_for_device/tr=
igger events/dma/dma_sync_single_for_cpu/trigger events/dma/dma_sync_single=
_for_device/trigger events/dma/dma_unmap_phys/trigger events/dma/dma_unmap_=
sg/trigger events/dma_buf/dma_buf_detach/trigger events/dma_buf/dma_buf_dyn=
amic_attach/trigger events/dma_buf/dma_buf_export/trigger events/dma_buf/dm=
a_buf_fd/trigger events/dma_buf/dma_buf_get/trigger events/dma_buf/dma_buf_=
mmap/trigger events/dma_buf/dma_buf_mmap_internal/trigger events/dma_buf/dm=
a_buf_put/trigger events/dma_fence/dma_fence_destroy/trigger events/dma_fen=
ce/dma_fence_emit/trigger events/dma_fence/dma_fence_enable_signal/trigger =
events/dma_fence/dma_fence_init/trigger events/dma_fence/dma_fence_signaled=
/trigger events/dma_fence/dma_fence_wait_end/trigger events/dma_fence/dma_f=
ence_wait_start/trigger events/drm/drm_vblank_event/trigger events/drm/drm_=
vblank_event_delivered/trigger events/drm/drm_vblank_event_queued/trigger e=
vents/e1000e_trace/e1000e_trace_mac_register/trigger events/error_report/er=
ror_report_end/trigger events/exceptions/page_fault_kernel/trigger events/e=
xceptions/page_fault_user/trigger events/ext4/ext4_alloc_da_blocks/trigger =
events/ext4/ext4_allocate_blocks/trigger events/ext4/ext4_allocate_inode/tr=
igger events/ext4/ext4_begin_ordered_truncate/trigger events/ext4/ext4_coll=
apse_range/trigger events/ext4/ext4_da_release_space/trigger events/ext4/ex=
t4_da_reserve_space/trigger events/ext4/ext4_da_update_reserve_space/trigge=
r events/ext4/ext4_da_write_begin/trigger events/ext4/ext4_da_write_end/tri=
gger events/ext4/ext4_da_write_folios_end/trigger events/ext4/ext4_da_write=
_folios_start/trigger events/ext4/ext4_da_write_pages_extent/trigger events=
/ext4/ext4_discard_blocks/trigger events/ext4/ext4_discard_preallocations/t=
rigger events/ext4/ext4_drop_inode/trigger events/ext4/ext4_error/trigger e=
vents/ext4/ext4_es_cache_extent/trigger events/ext4/ext4_es_find_extent_ran=
ge_enter/trigger events/ext4/ext4_es_find_extent_range_exit/trigger events/=
ext4/ext4_es_insert_delayed_extent/trigger events/ext4/ext4_es_insert_exten=
t/trigger events/ext4/ext4_es_lookup_extent_enter/trigger events/ext4/ext4_=
es_lookup_extent_exit/trigger events/ext4/ext4_es_remove_extent/trigger eve=
nts/ext4/ext4_es_shrink/trigger events/ext4/ext4_es_shrink_count/trigger ev=
ents/ext4/ext4_es_shrink_scan_enter/trigger events/ext4/ext4_es_shrink_scan=
_exit/trigger events/ext4/ext4_evict_inode/trigger events/ext4/ext4_ext_con=
vert_to_initialized_enter/trigger events/ext4/ext4_ext_convert_to_initializ=
ed_fastpath/trigger events/ext4/ext4_ext_handle_unwritten_extents/trigger e=
vents/ext4/ext4_ext_load_extent/trigger events/ext4/ext4_ext_map_blocks_ent=
er/trigger events/ext4/ext4_ext_map_blocks_exit/trigger events/ext4/ext4_ex=
t_remove_space/trigger events/ext4/ext4_ext_remove_space_done/trigger event=
s/ext4/ext4_ext_rm_idx/trigger events/ext4/ext4_ext_rm_leaf/trigger events/=
ext4/ext4_ext_show_extent/trigger events/ext4/ext4_fallocate_enter/trigger =
events/ext4/ext4_fallocate_exit/trigger events/ext4/ext4_fc_cleanup/trigger=
 events/ext4/ext4_fc_commit_start/trigger events/ext4/ext4_fc_commit_stop/t=
rigger events/ext4/ext4_fc_lock_updates/trigger events/ext4/ext4_fc_replay/=
trigger events/ext4/ext4_fc_replay_scan/trigger events/ext4/ext4_fc_stats/t=
rigger events/ext4/ext4_fc_track_create/trigger events/ext4/ext4_fc_track_i=
node/trigger events/ext4/ext4_fc_track_link/trigger events/ext4/ext4_fc_tra=
ck_range/trigger events/ext4/ext4_fc_track_unlink/trigger events/ext4/ext4_=
forget/trigger events/ext4/ext4_free_blocks/trigger events/ext4/ext4_free_i=
node/trigger events/ext4/ext4_fsmap_high_key/trigger events/ext4/ext4_fsmap=
_low_key/trigger events/ext4/ext4_fsmap_mapping/trigger events/ext4/ext4_ge=
t_implied_cluster_alloc_exit/trigger events/ext4/ext4_getfsmap_high_key/tri=
gger events/ext4/ext4_getfsmap_low_key/trigger events/ext4/ext4_getfsmap_ma=
pping/trigger events/ext4/ext4_ind_map_blocks_enter/trigger events/ext4/ext=
4_ind_map_blocks_exit/trigger events/ext4/ext4_insert_range/trigger events/=
ext4/ext4_invalidate_folio/trigger events/ext4/ext4_journal_start_inode/tri=
gger events/ext4/ext4_journal_start_reserved/trigger events/ext4/ext4_journ=
al_start_sb/trigger events/ext4/ext4_journalled_invalidate_folio/trigger ev=
ents/ext4/ext4_journalled_write_end/trigger events/ext4/ext4_lazy_itable_in=
it/trigger events/ext4/ext4_load_inode/trigger events/ext4/ext4_load_inode_=
bitmap/trigger events/ext4/ext4_mark_inode_dirty/trigger events/ext4/ext4_m=
b_bitmap_load/trigger events/ext4/ext4_mb_buddy_bitmap_load/trigger events/=
ext4/ext4_mb_discard_preallocations/trigger events/ext4/ext4_mb_new_group_p=
a/trigger events/ext4/ext4_mb_new_inode_pa/trigger events/ext4/ext4_mb_rele=
ase_group_pa/trigger events/ext4/ext4_mb_release_inode_pa/trigger events/ex=
t4/ext4_mballoc_alloc/trigger events/ext4/ext4_mballoc_discard/trigger even=
ts/ext4/ext4_mballoc_free/trigger events/ext4/ext4_mballoc_prealloc/trigger=
 events/ext4/ext4_move_extent_enter/trigger events/ext4/ext4_move_extent_ex=
it/trigger events/ext4/ext4_nfs_commit_metadata/trigger events/ext4/ext4_ot=
her_inode_update_time/trigger events/ext4/ext4_prefetch_bitmaps/trigger eve=
nts/ext4/ext4_punch_hole/trigger events/ext4/ext4_read_block_bitmap_load/tr=
igger events/ext4/ext4_read_folio/trigger events/ext4/ext4_release_folio/tr=
igger events/ext4/ext4_remove_blocks/trigger events/ext4/ext4_request_block=
s/trigger events/ext4/ext4_request_inode/trigger events/ext4/ext4_shutdown/=
trigger events/ext4/ext4_sync_file_enter/trigger events/ext4/ext4_sync_file=
_exit/trigger events/ext4/ext4_sync_fs/trigger events/ext4/ext4_trim_all_fr=
ee/trigger events/ext4/ext4_trim_extent/trigger events/ext4/ext4_truncate_e=
nter/trigger events/ext4/ext4_truncate_exit/trigger events/ext4/ext4_unlink=
_enter/trigger events/ext4/ext4_unlink_exit/trigger events/ext4/ext4_update=
_sb/trigger events/ext4/ext4_write_begin/trigger events/ext4/ext4_write_end=
/trigger events/ext4/ext4_writepages/trigger events/ext4/ext4_writepages_re=
sult/trigger events/ext4/ext4_zero_range/trigger events/fib/fib_table_looku=
p/trigger events/fib6/fib6_table_lookup/trigger events/filelock/break_lease=
/trigger events/filelock/break_lease_block/trigger events/filelock/break_le=
ase_noblock/trigger events/filelock/break_lease_unblock/trigger events/file=
lock/fcntl_setlk/trigger events/filelock/flock_lock_inode/trigger events/fi=
lelock/generic_add_lease/trigger events/filelock/generic_delete_lease/trigg=
er events/filelock/leases_conflict/trigger events/filelock/locks_get_lock_c=
ontext/trigger events/filelock/locks_remove_posix/trigger events/filelock/p=
osix_lock_inode/trigger events/filelock/time_out_leases/trigger events/file=
map/file_check_and_advance_wb_err/trigger events/filemap/filemap_set_wb_err=
/trigger events/filemap/mm_filemap_add_to_page_cache/trigger events/filemap=
/mm_filemap_delete_from_page_cache/trigger events/filemap/mm_filemap_fault/=
trigger events/filemap/mm_filemap_get_pages/trigger events/filemap/mm_filem=
ap_map_pages/trigger events/fs_dax/dax_insert_pfn_mkwrite/trigger events/fs=
_dax/dax_insert_pfn_mkwrite_no_entry/trigger events/fs_dax/dax_load_hole/tr=
igger events/fs_dax/dax_pmd_fault/trigger events/fs_dax/dax_pmd_fault_done/=
trigger events/fs_dax/dax_pmd_load_hole/trigger events/fs_dax/dax_pmd_load_=
hole_fallback/trigger events/fs_dax/dax_pte_fault/trigger events/fs_dax/dax=
_pte_fault_done/trigger events/fs_dax/dax_writeback_one/trigger events/fs_d=
ax/dax_writeback_range/trigger events/fs_dax/dax_writeback_range_done/trigg=
er events/fscache/fscache_access/trigger events/fscache/fscache_access_cach=
e/trigger events/fscache/fscache_access_volume/trigger events/fscache/fscac=
he_acquire/trigger events/fscache/fscache_active/trigger events/fscache/fsc=
ache_cache/trigger events/fscache/fscache_cookie/trigger events/fscache/fsc=
ache_invalidate/trigger events/fscache/fscache_relinquish/trigger events/fs=
cache/fscache_resize/trigger events/fscache/fscache_volume/trigger events/f=
snotify/fsnotify/trigger events/fsverity/fsverity_enable/trigger events/fsv=
erity/fsverity_merkle_hit/trigger events/fsverity/fsverity_tree_done/trigge=
r events/fsverity/fsverity_verify_data_block/trigger events/fsverity/fsveri=
ty_verify_merkle_block/trigger events/ftrace/print/trigger events/fuse/fuse=
_request_end/trigger events/fuse/fuse_request_send/trigger events/fuse/fuse=
_request_sent/trigger events/gpio/gpio_direction/trigger events/gpio/gpio_v=
alue/trigger events/handshake/handshake_cancel/trigger events/handshake/han=
dshake_cancel_busy/trigger events/handshake/handshake_cancel_none/trigger e=
vents/handshake/handshake_cmd_accept/trigger events/handshake/handshake_cmd=
_accept_err/trigger events/handshake/handshake_cmd_done/trigger events/hand=
shake/handshake_cmd_done_err/trigger events/handshake/handshake_complete/tr=
igger events/handshake/handshake_destruct/trigger events/handshake/handshak=
e_notify_err/trigger events/handshake/handshake_submit/trigger events/hands=
hake/handshake_submit_err/trigger events/handshake/tls_alert_recv/trigger e=
vents/handshake/tls_alert_send/trigger events/handshake/tls_contenttype/tri=
gger events/hda/hda_get_response/trigger events/hda/hda_send_cmd/trigger ev=
ents/hda/hda_unsol_event/trigger events/hda/snd_hdac_stream_start/trigger e=
vents/hda/snd_hdac_stream_stop/trigger events/hda_controller/azx_get_positi=
on/trigger events/hda_controller/azx_pcm_close/trigger events/hda_controlle=
r/azx_pcm_hw_params/trigger events/hda_controller/azx_pcm_open/trigger even=
ts/hda_controller/azx_pcm_prepare/trigger events/hda_controller/azx_pcm_tri=
gger/trigger events/hda_intel/azx_resume/trigger events/hda_intel/azx_runti=
me_resume/trigger events/hda_intel/azx_runtime_suspend/trigger events/hda_i=
ntel/azx_suspend/trigger events/huge_memory/mm_collapse_huge_page/trigger e=
vents/huge_memory/mm_collapse_huge_page_isolate/trigger events/huge_memory/=
mm_collapse_huge_page_swapin/trigger events/huge_memory/mm_khugepaged_colla=
pse_file/trigger events/huge_memory/mm_khugepaged_scan/trigger events/huge_=
memory/mm_khugepaged_scan_file/trigger events/huge_memory/mm_khugepaged_sca=
n_pmd/trigger events/hugetlbfs/hugetlbfs_alloc_inode/trigger events/hugetlb=
fs/hugetlbfs_evict_inode/trigger events/hugetlbfs/hugetlbfs_fallocate/trigg=
er events/hugetlbfs/hugetlbfs_free_inode/trigger events/hugetlbfs/hugetlbfs=
_setattr/trigger events/hwmon/hwmon_attr_show/trigger events/hwmon/hwmon_at=
tr_show_string/trigger events/hwmon/hwmon_attr_store/trigger events/i2c/i2c=
_read/trigger events/i2c/i2c_reply/trigger events/i2c/i2c_result/trigger ev=
ents/i2c/i2c_write/trigger events/i915/g4x_wm/trigger events/i915/i915_cont=
ext_create/trigger events/i915/i915_context_free/trigger events/i915/i915_g=
em_evict/trigger events/i915/i915_gem_evict_node/trigger events/i915/i915_g=
em_evict_vm/trigger events/i915/i915_gem_object_clflush/trigger events/i915=
/i915_gem_object_create/trigger events/i915/i915_gem_object_destroy/trigger=
 events/i915/i915_gem_object_fault/trigger events/i915/i915_gem_object_prea=
d/trigger events/i915/i915_gem_object_pwrite/trigger events/i915/i915_gem_s=
hrink/trigger events/i915/i915_ppgtt_create/trigger events/i915/i915_ppgtt_=
release/trigger events/i915/i915_reg_rw/trigger events/i915/i915_request_ad=
d/trigger events/i915/i915_request_queue/trigger events/i915/i915_request_r=
etire/trigger events/i915/i915_request_wait_begin/trigger events/i915/i915_=
request_wait_end/trigger events/i915/i915_vma_bind/trigger events/i915/i915=
_vma_unbind/trigger events/i915/intel_cpu_fifo_underrun/trigger events/i915=
/intel_crtc_flip_done/trigger events/i915/intel_crtc_vblank_work_end/trigge=
r events/i915/intel_crtc_vblank_work_start/trigger events/i915/intel_fbc_ac=
tivate/trigger events/i915/intel_fbc_deactivate/trigger events/i915/intel_f=
bc_nuke/trigger events/i915/intel_frontbuffer_flush/trigger events/i915/int=
el_frontbuffer_invalidate/trigger events/i915/intel_memory_cxsr/trigger eve=
nts/i915/intel_pch_fifo_underrun/trigger events/i915/intel_pipe_crc/trigger=
 events/i915/intel_pipe_disable/trigger events/i915/intel_pipe_enable/trigg=
er events/i915/intel_pipe_scaler_update_arm/trigger events/i915/intel_pipe_=
update_end/trigger events/i915/intel_pipe_update_start/trigger events/i915/=
intel_pipe_update_vblank_evaded/trigger events/i915/intel_plane_async_flip/=
trigger events/i915/intel_plane_disable_arm/trigger events/i915/intel_plane=
_scaler_update_arm/trigger events/i915/intel_plane_update_arm/trigger event=
s/i915/intel_plane_update_noarm/trigger events/i915/intel_scaler_disable_ar=
m/trigger events/i915/vlv_fifo_size/trigger events/i915/vlv_wm/trigger even=
ts/ib_cma/icm_dreq_skipped/trigger events/ib_cma/icm_dreq_unknown_err/trigg=
er events/ib_cma/icm_establish_err/trigger events/ib_cma/icm_handler_err/tr=
igger events/ib_cma/icm_insert_failed_err/trigger events/ib_cma/icm_issue_d=
rep/trigger events/ib_cma/icm_issue_rej/trigger events/ib_cma/icm_mad_send_=
err/trigger events/ib_cma/icm_mra_unknown_err/trigger events/ib_cma/icm_no_=
listener_err/trigger events/ib_cma/icm_no_priv_err/trigger events/ib_cma/ic=
m_prepare_mra_unknown_err/trigger events/ib_cma/icm_qp_init_err/trigger eve=
nts/ib_cma/icm_qp_rtr_err/trigger events/ib_cma/icm_qp_rts_err/trigger even=
ts/ib_cma/icm_rej_unknown_err/trigger events/ib_cma/icm_remote_no_priv_err/=
trigger events/ib_cma/icm_rep_unknown_err/trigger events/ib_cma/icm_send_cm=
_rtu_err/trigger events/ib_cma/icm_send_drep/trigger events/ib_cma/icm_send=
_drep_err/trigger events/ib_cma/icm_send_dreq/trigger events/ib_cma/icm_sen=
d_dup_rep/trigger events/ib_cma/icm_send_dup_req/trigger events/ib_cma/icm_=
send_mra/trigger events/ib_cma/icm_send_rej/trigger events/ib_cma/icm_send_=
rep/trigger events/ib_cma/icm_send_rep_err/trigger events/ib_cma/icm_send_r=
eq/trigger events/ib_cma/icm_send_rtu/trigger events/ib_cma/icm_send_sidr_r=
ep/trigger events/ib_cma/icm_send_sidr_req/trigger events/ib_cma/icm_send_u=
nknown_rej_err/trigger events/ib_cma/icm_staleconn_err/trigger events/ib_ma=
d/ib_mad_create_agent/trigger events/ib_mad/ib_mad_error_handler/trigger ev=
ents/ib_mad/ib_mad_handle_ib_smi/trigger events/ib_mad/ib_mad_handle_opa_sm=
i/trigger events/ib_mad/ib_mad_handle_out_ib_smi/trigger events/ib_mad/ib_m=
ad_handle_out_opa_smi/trigger events/ib_mad/ib_mad_ib_send_mad/trigger even=
ts/ib_mad/ib_mad_recv_done_agent/trigger events/ib_mad/ib_mad_recv_done_han=
dler/trigger events/ib_mad/ib_mad_send_done_agent/trigger events/ib_mad/ib_=
mad_send_done_handler/trigger events/ib_mad/ib_mad_send_done_resend/trigger=
 events/ib_mad/ib_mad_unregister_agent/trigger events/icmp/icmp_send/trigge=
r events/initcall/initcall_finish/trigger events/initcall/initcall_level/tr=
igger events/initcall/initcall_start/trigger events/intel_avs/avs_d0ix/trig=
ger events/intel_avs/avs_dsp_core_op/trigger events/intel_avs/avs_ipc_msg_p=
ayload/trigger events/intel_avs/avs_ipc_notify_msg/trigger events/intel_avs=
/avs_ipc_reply_msg/trigger events/intel_avs/avs_ipc_request_msg/trigger eve=
nts/intel_iommu/cache_tag_assign/trigger events/intel_iommu/cache_tag_flush=
_range/trigger events/intel_iommu/cache_tag_flush_range_np/trigger events/i=
ntel_iommu/cache_tag_unassign/trigger events/intel_iommu/prq_report/trigger=
 events/intel_iommu/qi_submit/trigger events/io_uring/io_uring_complete/tri=
gger events/io_uring/io_uring_cqe_overflow/trigger events/io_uring/io_uring=
_cqring_wait/trigger events/io_uring/io_uring_create/trigger events/io_urin=
g/io_uring_defer/trigger events/io_uring/io_uring_fail_link/trigger events/=
io_uring/io_uring_file_get/trigger events/io_uring/io_uring_link/trigger ev=
ents/io_uring/io_uring_local_work_run/trigger events/io_uring/io_uring_poll=
_arm/trigger events/io_uring/io_uring_queue_async_work/trigger events/io_ur=
ing/io_uring_register/trigger events/io_uring/io_uring_req_failed/trigger e=
vents/io_uring/io_uring_short_write/trigger events/io_uring/io_uring_submit=
_req/trigger events/io_uring/io_uring_task_add/trigger events/io_uring/io_u=
ring_task_work_run/trigger events/iomap/iomap_add_to_ioend/trigger events/i=
omap/iomap_dio_complete/trigger events/iomap/iomap_dio_invalidate_fail/trig=
ger events/iomap/iomap_dio_rw_begin/trigger events/iomap/iomap_dio_rw_queue=
d/trigger events/iomap/iomap_invalidate_folio/trigger events/iomap/iomap_it=
er/trigger events/iomap/iomap_iter_dstmap/trigger events/iomap/iomap_iter_s=
rcmap/trigger events/iomap/iomap_readahead/trigger events/iomap/iomap_readp=
age/trigger events/iomap/iomap_release_folio/trigger events/iomap/iomap_wri=
teback_folio/trigger events/iomap/iomap_zero_iter/trigger events/iommu/add_=
device_to_group/trigger events/iommu/attach_device_to_domain/trigger events=
/iommu/io_page_fault/trigger events/iommu/map/trigger events/iommu/remove_d=
evice_from_group/trigger events/iommu/unmap/trigger events/ipi/ipi_send_cpu=
/trigger events/ipi/ipi_send_cpumask/trigger events/irq/irq_handler_entry/t=
rigger events/irq/irq_handler_exit/trigger events/irq/softirq_entry/trigger=
 events/irq/softirq_exit/trigger events/irq/softirq_raise/trigger events/ir=
q/tasklet_entry/trigger events/irq/tasklet_exit/trigger events/irq_matrix/i=
rq_matrix_alloc/trigger events/irq_matrix/irq_matrix_alloc_managed/trigger =
events/irq_matrix/irq_matrix_assign/trigger events/irq_matrix/irq_matrix_as=
sign_system/trigger events/irq_matrix/irq_matrix_free/trigger events/irq_ma=
trix/irq_matrix_offline/trigger events/irq_matrix/irq_matrix_online/trigger=
 events/irq_matrix/irq_matrix_remove_managed/trigger events/irq_matrix/irq_=
matrix_remove_reserved/trigger events/irq_matrix/irq_matrix_reserve/trigger=
 events/irq_matrix/irq_matrix_reserve_managed/trigger events/irq_vectors/ca=
ll_function_entry/trigger events/irq_vectors/call_function_exit/trigger eve=
nts/irq_vectors/call_function_single_entry/trigger events/irq_vectors/call_=
function_single_exit/trigger events/irq_vectors/deferred_error_apic_entry/t=
rigger events/irq_vectors/deferred_error_apic_exit/trigger events/irq_vecto=
rs/error_apic_entry/trigger events/irq_vectors/error_apic_exit/trigger even=
ts/irq_vectors/irq_work_entry/trigger events/irq_vectors/irq_work_exit/trig=
ger events/irq_vectors/local_timer_entry/trigger events/irq_vectors/local_t=
imer_exit/trigger events/irq_vectors/reschedule_entry/trigger events/irq_ve=
ctors/reschedule_exit/trigger events/irq_vectors/spurious_apic_entry/trigge=
r events/irq_vectors/spurious_apic_exit/trigger events/irq_vectors/thermal_=
apic_entry/trigger events/irq_vectors/thermal_apic_exit/trigger events/irq_=
vectors/threshold_apic_entry/trigger events/irq_vectors/threshold_apic_exit=
/trigger events/irq_vectors/vector_activate/trigger events/irq_vectors/vect=
or_alloc/trigger events/irq_vectors/vector_alloc_managed/trigger events/irq=
_vectors/vector_clear/trigger events/irq_vectors/vector_config/trigger even=
ts/irq_vectors/vector_deactivate/trigger events/irq_vectors/vector_free_mov=
ed/trigger events/irq_vectors/vector_reserve/trigger events/irq_vectors/vec=
tor_reserve_managed/trigger events/irq_vectors/vector_setup/trigger events/=
irq_vectors/vector_teardown/trigger events/irq_vectors/vector_update/trigge=
r events/irq_vectors/x86_platform_ipi_entry/trigger events/irq_vectors/x86_=
platform_ipi_exit/trigger events/jbd2/jbd2_checkpoint/trigger events/jbd2/j=
bd2_checkpoint_stats/trigger events/jbd2/jbd2_commit_flushing/trigger event=
s/jbd2/jbd2_commit_locking/trigger events/jbd2/jbd2_commit_logging/trigger =
events/jbd2/jbd2_drop_transaction/trigger events/jbd2/jbd2_end_commit/trigg=
er events/jbd2/jbd2_handle_extend/trigger events/jbd2/jbd2_handle_restart/t=
rigger events/jbd2/jbd2_handle_start/trigger events/jbd2/jbd2_handle_stats/=
trigger events/jbd2/jbd2_lock_buffer_stall/trigger events/jbd2/jbd2_run_sta=
ts/trigger events/jbd2/jbd2_shrink_checkpoint_list/trigger events/jbd2/jbd2=
_shrink_count/trigger events/jbd2/jbd2_shrink_scan_enter/trigger events/jbd=
2/jbd2_shrink_scan_exit/trigger events/jbd2/jbd2_start_commit/trigger event=
s/jbd2/jbd2_submit_inode_data/trigger events/jbd2/jbd2_update_log_tail/trig=
ger events/jbd2/jbd2_write_superblock/trigger events/kmem/kfree/trigger eve=
nts/kmem/kmalloc/trigger events/kmem/kmem_cache_alloc/trigger events/kmem/k=
mem_cache_free/trigger events/kmem/mm_calculate_totalreserve_pages/trigger =
events/kmem/mm_page_alloc/trigger events/kmem/mm_page_alloc_extfrag/trigger=
 events/kmem/mm_page_alloc_zone_locked/trigger events/kmem/mm_page_free/tri=
gger events/kmem/mm_page_free_batched/trigger events/kmem/mm_page_pcpu_drai=
n/trigger events/kmem/mm_setup_per_zone_lowmem_reserve/trigger events/kmem/=
mm_setup_per_zone_wmarks/trigger events/kmem/rss_stat/trigger events/kprobe=
s/kpevent/trigger events/ksm/ksm_advisor/trigger events/ksm/ksm_enter/trigg=
er events/ksm/ksm_exit/trigger events/ksm/ksm_merge_one_page/trigger events=
/ksm/ksm_merge_with_ksm_page/trigger events/ksm/ksm_remove_ksm_page/trigger=
 events/ksm/ksm_remove_rmap_item/trigger events/ksm/ksm_start_scan/trigger =
events/ksm/ksm_stop_scan/trigger events/kvm/kvm_ack_irq/trigger events/kvm/=
kvm_age_hva/trigger events/kvm/kvm_apic/trigger events/kvm/kvm_apic_accept_=
irq/trigger events/kvm/kvm_apic_ipi/trigger events/kvm/kvm_apicv_accept_irq=
/trigger events/kvm/kvm_apicv_inhibit_changed/trigger events/kvm/kvm_async_=
pf_completed/trigger events/kvm/kvm_async_pf_not_present/trigger events/kvm=
/kvm_async_pf_ready/trigger events/kvm/kvm_async_pf_repeated_fault/trigger =
events/kvm/kvm_avic_doorbell/trigger events/kvm/kvm_avic_ga_log/trigger eve=
nts/kvm/kvm_avic_incomplete_ipi/trigger events/kvm/kvm_avic_kick_vcpu_slowp=
ath/trigger events/kvm/kvm_avic_unaccelerated_access/trigger events/kvm/kvm=
_cpuid/trigger events/kvm/kvm_cr/trigger events/kvm/kvm_dirty_ring_exit/tri=
gger events/kvm/kvm_dirty_ring_push/trigger events/kvm/kvm_dirty_ring_reset=
/trigger events/kvm/kvm_emulate_insn/trigger events/kvm/kvm_entry/trigger e=
vents/kvm/kvm_eoi/trigger events/kvm/kvm_exit/trigger events/kvm/kvm_fast_m=
mio/trigger events/kvm/kvm_fpu/trigger events/kvm/kvm_halt_poll_ns/trigger =
events/kvm/kvm_hv_flush_tlb/trigger events/kvm/kvm_hv_flush_tlb_ex/trigger =
events/kvm/kvm_hv_hypercall/trigger events/kvm/kvm_hv_hypercall_done/trigge=
r events/kvm/kvm_hv_notify_acked_sint/trigger events/kvm/kvm_hv_send_ipi/tr=
igger events/kvm/kvm_hv_send_ipi_ex/trigger events/kvm/kvm_hv_stimer_callba=
ck/trigger events/kvm/kvm_hv_stimer_cleanup/trigger events/kvm/kvm_hv_stime=
r_expiration/trigger events/kvm/kvm_hv_stimer_set_config/trigger events/kvm=
/kvm_hv_stimer_set_count/trigger events/kvm/kvm_hv_stimer_start_one_shot/tr=
igger events/kvm/kvm_hv_stimer_start_periodic/trigger events/kvm/kvm_hv_syn=
dbg_get_msr/trigger events/kvm/kvm_hv_syndbg_set_msr/trigger events/kvm/kvm=
_hv_synic_send_eoi/trigger events/kvm/kvm_hv_synic_set_irq/trigger events/k=
vm/kvm_hv_synic_set_msr/trigger events/kvm/kvm_hv_timer_state/trigger event=
s/kvm/kvm_hypercall/trigger events/kvm/kvm_inj_exception/trigger events/kvm=
/kvm_inj_virq/trigger events/kvm/kvm_invlpga/trigger events/kvm/kvm_ioapic_=
delayed_eoi_inj/trigger events/kvm/kvm_ioapic_set_irq/trigger events/kvm/kv=
m_mmio/trigger events/kvm/kvm_msi_set_irq/trigger events/kvm/kvm_msr/trigge=
r events/kvm/kvm_nested_intercepts/trigger events/kvm/kvm_nested_intr_vmexi=
t/trigger events/kvm/kvm_nested_vmenter/trigger events/kvm/kvm_nested_vment=
er_failed/trigger events/kvm/kvm_nested_vmexit/trigger events/kvm/kvm_neste=
d_vmexit_inject/trigger events/kvm/kvm_page_fault/trigger events/kvm/kvm_pi=
_irte_update/trigger events/kvm/kvm_pic_set_irq/trigger events/kvm/kvm_pio/=
trigger events/kvm/kvm_ple_window_update/trigger events/kvm/kvm_pml_full/tr=
igger events/kvm/kvm_pv_eoi/trigger events/kvm/kvm_pv_tlb_flush/trigger eve=
nts/kvm/kvm_pvclock_update/trigger events/kvm/kvm_rmp_fault/trigger events/=
kvm/kvm_set_irq/trigger events/kvm/kvm_skinit/trigger events/kvm/kvm_smm_tr=
ansition/trigger events/kvm/kvm_test_age_hva/trigger events/kvm/kvm_track_t=
sc/trigger events/kvm/kvm_try_async_get_page/trigger events/kvm/kvm_unmap_h=
va_range/trigger events/kvm/kvm_update_master_clock/trigger events/kvm/kvm_=
userspace_exit/trigger events/kvm/kvm_vcpu_wakeup/trigger events/kvm/kvm_vm=
_set_mem_attributes/trigger events/kvm/kvm_vmgexit_enter/trigger events/kvm=
/kvm_vmgexit_exit/trigger events/kvm/kvm_vmgexit_msr_protocol_enter/trigger=
 events/kvm/kvm_vmgexit_msr_protocol_exit/trigger events/kvm/kvm_wait_lapic=
_expire/trigger events/kvm/kvm_write_tsc_offset/trigger events/kvm/kvm_xen_=
hypercall/trigger events/kvm/vcpu_match_mmio/trigger events/kvmmmu/check_mm=
io_spte/trigger events/kvmmmu/fast_page_fault/trigger events/kvmmmu/handle_=
mmio_page_fault/trigger events/kvmmmu/kvm_mmu_get_page/trigger events/kvmmm=
u/kvm_mmu_pagetable_walk/trigger events/kvmmmu/kvm_mmu_paging_element/trigg=
er events/kvmmmu/kvm_mmu_prepare_zap_page/trigger events/kvmmmu/kvm_mmu_set=
_accessed_bit/trigger events/kvmmmu/kvm_mmu_set_dirty_bit/trigger events/kv=
mmmu/kvm_mmu_set_spte/trigger events/kvmmmu/kvm_mmu_split_huge_page/trigger=
 events/kvmmmu/kvm_mmu_spte_requested/trigger events/kvmmmu/kvm_mmu_sync_pa=
ge/trigger events/kvmmmu/kvm_mmu_unsync_page/trigger events/kvmmmu/kvm_mmu_=
walker_error/trigger events/kvmmmu/kvm_mmu_zap_all_fast/trigger events/kvmm=
mu/kvm_tdp_mmu_spte_changed/trigger events/kvmmmu/mark_mmio_spte/trigger ev=
ents/kyber/kyber_adjust/trigger events/kyber/kyber_latency/trigger events/k=
yber/kyber_throttled/trigger events/libata/ata_bmdma_setup/trigger events/l=
ibata/ata_bmdma_start/trigger events/libata/ata_bmdma_status/trigger events=
/libata/ata_bmdma_stop/trigger events/libata/ata_eh_about_to_do/trigger eve=
nts/libata/ata_eh_done/trigger events/libata/ata_eh_link_autopsy/trigger ev=
ents/libata/ata_eh_link_autopsy_qc/trigger events/libata/ata_exec_command/t=
rigger events/libata/ata_link_hardreset_begin/trigger events/libata/ata_lin=
k_hardreset_end/trigger events/libata/ata_link_postreset/trigger events/lib=
ata/ata_link_softreset_begin/trigger events/libata/ata_link_softreset_end/t=
rigger events/libata/ata_port_freeze/trigger events/libata/ata_port_thaw/tr=
igger events/libata/ata_qc_complete_done/trigger events/libata/ata_qc_compl=
ete_failed/trigger events/libata/ata_qc_complete_internal/trigger events/li=
bata/ata_qc_issue/trigger events/libata/ata_qc_prep/trigger events/libata/a=
ta_sff_flush_pio_task/trigger events/libata/ata_sff_hsm_command_complete/tr=
igger events/libata/ata_sff_hsm_state/trigger events/libata/ata_sff_pio_tra=
nsfer_data/trigger events/libata/ata_sff_port_intr/trigger events/libata/at=
a_slave_hardreset_begin/trigger events/libata/ata_slave_hardreset_end/trigg=
er events/libata/ata_slave_postreset/trigger events/libata/ata_std_sched_eh=
/trigger events/libata/ata_tf_load/trigger events/libata/atapi_pio_transfer=
_data/trigger events/libata/atapi_send_cdb/trigger events/lock/contended_re=
lease/trigger events/lock/contention_begin/trigger events/lock/contention_e=
nd/trigger events/lock/lock_acquire/trigger events/lock/lock_release/trigge=
r events/lockd/nlmclnt_grant/trigger events/lockd/nlmclnt_lock/trigger even=
ts/lockd/nlmclnt_test/trigger events/lockd/nlmclnt_unlock/trigger events/ma=
ple_tree/ma_op/trigger events/maple_tree/ma_read/trigger events/maple_tree/=
ma_write/trigger events/mce/mce_record/trigger events/mdio/mdio_access/trig=
ger events/mei/mei_pci_cfg_read/trigger events/mei/mei_reg_read/trigger eve=
nts/mei/mei_reg_write/trigger events/memcg/count_memcg_events/trigger event=
s/memcg/memcg_flush_stats/trigger events/memcg/mod_memcg_lruvec_state/trigg=
er events/memcg/mod_memcg_state/trigger events/memory_failure/memory_failur=
e_event/trigger events/migrate/mm_migrate_pages/trigger events/migrate/mm_m=
igrate_pages_start/trigger events/migrate/remove_migration_pte/trigger even=
ts/migrate/set_migration_pte/trigger events/mmap/exit_mmap/trigger events/m=
map/vm_unmapped_area/trigger events/mmap_lock/mmap_lock_acquire_returned/tr=
igger events/mmap_lock/mmap_lock_released/trigger events/mmap_lock/mmap_loc=
k_start_locking/trigger events/module/module_free/trigger events/module/mod=
ule_get/trigger events/module/module_load/trigger events/module/module_put/=
trigger events/module/module_request/trigger events/mptcp/ack_update_msk/tr=
igger events/mptcp/get_mapping_status/trigger events/mptcp/mptcp_rcvbuf_gro=
w/trigger events/mptcp/mptcp_sendmsg_frag/trigger events/mptcp/mptcp_subflo=
w_get_send/trigger events/mptcp/subflow_check_data_avail/trigger events/msr=
/rdpmc/trigger events/msr/read_msr/trigger events/msr/write_msr/trigger eve=
nts/napi/dql_stall_detected/trigger events/napi/napi_poll/trigger events/ne=
igh/neigh_cleanup_and_release/trigger events/neigh/neigh_create/trigger eve=
nts/neigh/neigh_event_send_dead/trigger events/neigh/neigh_event_send_done/=
trigger events/neigh/neigh_timer_handler/trigger events/neigh/neigh_update/=
trigger events/neigh/neigh_update_done/trigger events/net/napi_gro_frags_en=
try/trigger events/net/napi_gro_frags_exit/trigger events/net/napi_gro_rece=
ive_entry/trigger events/net/napi_gro_receive_exit/trigger events/net/net_d=
ev_queue/trigger events/net/net_dev_start_xmit/trigger events/net/net_dev_x=
mit/trigger events/net/net_dev_xmit_timeout/trigger events/net/netif_receiv=
e_skb/trigger events/net/netif_receive_skb_entry/trigger events/net/netif_r=
eceive_skb_exit/trigger events/net/netif_receive_skb_list_entry/trigger eve=
nts/net/netif_receive_skb_list_exit/trigger events/net/netif_rx/trigger eve=
nts/net/netif_rx_entry/trigger events/net/netif_rx_exit/trigger events/netf=
s/netfs_collect/trigger events/netfs/netfs_collect_folio/trigger events/net=
fs/netfs_collect_gap/trigger events/netfs/netfs_collect_sreq/trigger events=
/netfs/netfs_collect_state/trigger events/netfs/netfs_collect_stream/trigge=
r events/netfs/netfs_copy2cache/trigger events/netfs/netfs_failure/trigger =
events/netfs/netfs_folio/trigger events/netfs/netfs_folioq/trigger events/n=
etfs/netfs_read/trigger events/netfs/netfs_rreq/trigger events/netfs/netfs_=
rreq_ref/trigger events/netfs/netfs_sreq/trigger events/netfs/netfs_sreq_re=
f/trigger events/netfs/netfs_write/trigger events/netfs/netfs_write_iter/tr=
igger events/netlink/netlink_extack/trigger events/nfs/nfs_access_enter/tri=
gger events/nfs/nfs_access_exit/trigger events/nfs/nfs_aop_readahead/trigge=
r events/nfs/nfs_aop_readahead_done/trigger events/nfs/nfs_aop_readpage/tri=
gger events/nfs/nfs_aop_readpage_done/trigger events/nfs/nfs_async_rename_d=
one/trigger events/nfs/nfs_atomic_open_enter/trigger events/nfs/nfs_atomic_=
open_exit/trigger events/nfs/nfs_commit_done/trigger events/nfs/nfs_commit_=
error/trigger events/nfs/nfs_comp_error/trigger events/nfs/nfs_create_enter=
/trigger events/nfs/nfs_create_exit/trigger events/nfs/nfs_direct_commit_co=
mplete/trigger events/nfs/nfs_direct_resched_write/trigger events/nfs/nfs_d=
irect_write_complete/trigger events/nfs/nfs_direct_write_completion/trigger=
 events/nfs/nfs_direct_write_reschedule_io/trigger events/nfs/nfs_direct_wr=
ite_schedule_iovec/trigger events/nfs/nfs_do_writepage/trigger events/nfs/n=
fs_fh_to_dentry/trigger events/nfs/nfs_file_read/trigger events/nfs/nfs_fil=
e_write/trigger events/nfs/nfs_fsync_enter/trigger events/nfs/nfs_fsync_exi=
t/trigger events/nfs/nfs_getattr_enter/trigger events/nfs/nfs_getattr_exit/=
trigger events/nfs/nfs_initiate_commit/trigger events/nfs/nfs_initiate_read=
/trigger events/nfs/nfs_initiate_write/trigger events/nfs/nfs_invalidate_fo=
lio/trigger events/nfs/nfs_invalidate_mapping_enter/trigger events/nfs/nfs_=
invalidate_mapping_exit/trigger events/nfs/nfs_launder_folio_done/trigger e=
vents/nfs/nfs_link_enter/trigger events/nfs/nfs_link_exit/trigger events/nf=
s/nfs_local_open_fh/trigger events/nfs/nfs_lookup_enter/trigger events/nfs/=
nfs_lookup_exit/trigger events/nfs/nfs_lookup_revalidate_enter/trigger even=
ts/nfs/nfs_lookup_revalidate_exit/trigger events/nfs/nfs_mkdir_enter/trigge=
r events/nfs/nfs_mkdir_exit/trigger events/nfs/nfs_mknod_enter/trigger even=
ts/nfs/nfs_mknod_exit/trigger events/nfs/nfs_mount_assign/trigger events/nf=
s/nfs_mount_option/trigger events/nfs/nfs_mount_path/trigger events/nfs/nfs=
_pgio_error/trigger events/nfs/nfs_readdir_cache_fill/trigger events/nfs/nf=
s_readdir_cache_fill_done/trigger events/nfs/nfs_readdir_force_readdirplus/=
trigger events/nfs/nfs_readdir_invalidate_cache_range/trigger events/nfs/nf=
s_readdir_lookup/trigger events/nfs/nfs_readdir_lookup_revalidate/trigger e=
vents/nfs/nfs_readdir_lookup_revalidate_failed/trigger events/nfs/nfs_readd=
ir_uncached/trigger events/nfs/nfs_readdir_uncached_done/trigger events/nfs=
/nfs_readpage_done/trigger events/nfs/nfs_readpage_short/trigger events/nfs=
/nfs_refresh_inode_enter/trigger events/nfs/nfs_refresh_inode_exit/trigger =
events/nfs/nfs_remove_enter/trigger events/nfs/nfs_remove_exit/trigger even=
ts/nfs/nfs_rename_enter/trigger events/nfs/nfs_rename_exit/trigger events/n=
fs/nfs_revalidate_inode_enter/trigger events/nfs/nfs_revalidate_inode_exit/=
trigger events/nfs/nfs_rmdir_enter/trigger events/nfs/nfs_rmdir_exit/trigge=
r events/nfs/nfs_set_cache_invalid/trigger events/nfs/nfs_set_inode_stale/t=
rigger events/nfs/nfs_setattr_enter/trigger events/nfs/nfs_setattr_exit/tri=
gger events/nfs/nfs_sillyrename_unlink/trigger events/nfs/nfs_size_grow/tri=
gger events/nfs/nfs_size_truncate/trigger events/nfs/nfs_size_truncate_foli=
o/trigger events/nfs/nfs_size_update/trigger events/nfs/nfs_size_wcc/trigge=
r events/nfs/nfs_symlink_enter/trigger events/nfs/nfs_symlink_exit/trigger =
events/nfs/nfs_try_to_update_request/trigger events/nfs/nfs_try_to_update_r=
equest_done/trigger events/nfs/nfs_unlink_enter/trigger events/nfs/nfs_unli=
nk_exit/trigger events/nfs/nfs_update_folio/trigger events/nfs/nfs_update_f=
olio_done/trigger events/nfs/nfs_write_begin/trigger events/nfs/nfs_write_b=
egin_done/trigger events/nfs/nfs_write_end/trigger events/nfs/nfs_write_end=
_done/trigger events/nfs/nfs_write_error/trigger events/nfs/nfs_writeback_d=
one/trigger events/nfs/nfs_writeback_folio/trigger events/nfs/nfs_writeback=
_folio_done/trigger events/nfs/nfs_writeback_folio_reclaim/trigger events/n=
fs/nfs_writeback_folio_reclaim_done/trigger events/nfs/nfs_writeback_inode_=
enter/trigger events/nfs/nfs_writeback_inode_exit/trigger events/nfs/nfs_wr=
itepage_setup/trigger events/nfs/nfs_writepages/trigger events/nfs/nfs_writ=
epages_done/trigger events/nfs/nfs_xdr_bad_filehandle/trigger events/nfs/nf=
s_xdr_status/trigger events/nmi/nmi_handler/trigger events/notifier/notifie=
r_register/trigger events/notifier/notifier_run/trigger events/notifier/not=
ifier_unregister/trigger events/nvme/nvme_async_event/trigger events/nvme/n=
vme_complete_rq/trigger events/nvme/nvme_setup_cmd/trigger events/nvme/nvme=
_sq/trigger events/oom/compact_retry/trigger events/oom/finish_task_reaping=
/trigger events/oom/mark_victim/trigger events/oom/oom_score_adj_update/tri=
gger events/oom/reclaim_retry_zone/trigger events/oom/skip_task_reaping/tri=
gger events/oom/start_task_reaping/trigger events/oom/wake_reaper/trigger e=
vents/osnoise/irq_noise/trigger events/osnoise/nmi_noise/trigger events/osn=
oise/osnoise_sample/trigger events/osnoise/sample_threshold/trigger events/=
osnoise/softirq_noise/trigger events/osnoise/thread_noise/trigger events/os=
noise/timerlat_sample/trigger events/page_isolation/test_pages_isolated/tri=
gger events/page_pool/page_pool_release/trigger events/page_pool/page_pool_=
state_hold/trigger events/page_pool/page_pool_state_release/trigger events/=
page_pool/page_pool_update_nid/trigger events/pagemap/mm_lru_activate/trigg=
er events/pagemap/mm_lru_insertion/trigger events/pci/pci_hp_event/trigger =
events/pci/pcie_link_event/trigger events/pci_controller/pcie_ltssm_state_t=
ransition/trigger events/percpu/percpu_alloc_percpu/trigger events/percpu/p=
ercpu_alloc_percpu_fail/trigger events/percpu/percpu_create_chunk/trigger e=
vents/percpu/percpu_destroy_chunk/trigger events/percpu/percpu_free_percpu/=
trigger events/power/cpu_frequency/trigger events/power/cpu_frequency_limit=
s/trigger events/power/cpu_idle/trigger events/power/cpu_idle_miss/trigger =
events/power/dev_pm_qos_add_request/trigger events/power/dev_pm_qos_remove_=
request/trigger events/power/dev_pm_qos_update_request/trigger events/power=
/device_pm_callback_end/trigger events/power/device_pm_callback_start/trigg=
er events/power/guest_halt_poll_ns/trigger events/power/pm_qos_add_request/=
trigger events/power/pm_qos_remove_request/trigger events/power/pm_qos_upda=
te_flags/trigger events/power/pm_qos_update_request/trigger events/power/pm=
_qos_update_target/trigger events/power/pstate_sample/trigger events/power/=
suspend_resume/trigger events/power/wakeup_source_activate/trigger events/p=
ower/wakeup_source_deactivate/trigger events/preemptirq/irq_disable/trigger=
 events/preemptirq/irq_enable/trigger events/preemptirq/preempt_disable/tri=
gger events/preemptirq/preempt_enable/trigger events/printk/console/trigger=
 events/pwm/pwm_apply/trigger events/pwm/pwm_get/trigger events/pwm/pwm_rea=
d_waveform/trigger events/pwm/pwm_round_waveform_fromhw/trigger events/pwm/=
pwm_round_waveform_tohw/trigger events/pwm/pwm_write_waveform/trigger event=
s/qdisc/qdisc_create/trigger events/qdisc/qdisc_dequeue/trigger events/qdis=
c/qdisc_destroy/trigger events/qdisc/qdisc_drop/trigger events/qdisc/qdisc_=
enqueue/trigger events/qdisc/qdisc_reset/trigger events/ras/aer_event/trigg=
er events/ras/arm_event/trigger events/ras/extlog_mem_event/trigger events/=
ras/mc_event/trigger events/ras/non_standard_event/trigger events/raw_sysca=
lls/sys_enter/trigger events/raw_syscalls/sys_exit/trigger events/rcu/rcu_s=
tall_warning/trigger events/rcu/rcu_utilization/trigger events/rdma_cma/cm_=
add_one/trigger events/rdma_cma/cm_disconnect/trigger events/rdma_cma/cm_ev=
ent_done/trigger events/rdma_cma/cm_event_handler/trigger events/rdma_cma/c=
m_id_attach/trigger events/rdma_cma/cm_id_destroy/trigger events/rdma_cma/c=
m_prepare_mra/trigger events/rdma_cma/cm_qp_create/trigger events/rdma_cma/=
cm_qp_destroy/trigger events/rdma_cma/cm_remove_one/trigger events/rdma_cma=
/cm_req_handler/trigger events/rdma_cma/cm_send_rej/trigger events/rdma_cma=
/cm_send_rep/trigger events/rdma_cma/cm_send_req/trigger events/rdma_cma/cm=
_send_rtu/trigger events/rdma_cma/cm_send_sidr_rep/trigger events/rdma_cma/=
cm_send_sidr_req/trigger events/rdma_cma/cm_sent_drep/trigger events/rdma_c=
ma/cm_sent_dreq/trigger events/rdma_core/cq_alloc/trigger events/rdma_core/=
cq_alloc_error/trigger events/rdma_core/cq_drain_complete/trigger events/rd=
ma_core/cq_free/trigger events/rdma_core/cq_modify/trigger events/rdma_core=
/cq_poll/trigger events/rdma_core/cq_process/trigger events/rdma_core/cq_re=
schedule/trigger events/rdma_core/cq_schedule/trigger events/rdma_core/mr_a=
lloc/trigger events/rdma_core/mr_dereg/trigger events/rdma_core/mr_integ_al=
loc/trigger events/readahead/page_cache_async_ra/trigger events/readahead/p=
age_cache_ra_order/trigger events/readahead/page_cache_ra_unbounded/trigger=
 events/readahead/page_cache_sync_ra/trigger events/regmap/regcache_drop_re=
gion/trigger events/regmap/regcache_sync/trigger events/regmap/regmap_async=
_complete_done/trigger events/regmap/regmap_async_complete_start/trigger ev=
ents/regmap/regmap_async_io_complete/trigger events/regmap/regmap_async_wri=
te_start/trigger events/regmap/regmap_bulk_read/trigger events/regmap/regma=
p_bulk_write/trigger events/regmap/regmap_cache_bypass/trigger events/regma=
p/regmap_cache_only/trigger events/regmap/regmap_hw_read_done/trigger event=
s/regmap/regmap_hw_read_start/trigger events/regmap/regmap_hw_write_done/tr=
igger events/regmap/regmap_hw_write_start/trigger events/regmap/regmap_reg_=
read/trigger events/regmap/regmap_reg_read_cache/trigger events/regmap/regm=
ap_reg_write/trigger events/resctrl/mon_llc_occupancy_limbo/trigger events/=
resctrl/pseudo_lock_l2/trigger events/resctrl/pseudo_lock_l3/trigger events=
/resctrl/pseudo_lock_mem_latency/trigger events/rpm/rpm_idle/trigger events=
/rpm/rpm_resume/trigger events/rpm/rpm_return_int/trigger events/rpm/rpm_st=
atus/trigger events/rpm/rpm_suspend/trigger events/rpm/rpm_usage/trigger ev=
ents/rseq/rseq_ip_fixup/trigger events/rseq/rseq_update/trigger events/rtc/=
rtc_alarm_irq_enable/trigger events/rtc/rtc_irq_set_freq/trigger events/rtc=
/rtc_irq_set_state/trigger events/rtc/rtc_read_alarm/trigger events/rtc/rtc=
_read_offset/trigger events/rtc/rtc_read_time/trigger events/rtc/rtc_set_al=
arm/trigger events/rtc/rtc_set_offset/trigger events/rtc/rtc_set_time/trigg=
er events/rtc/rtc_timer_dequeue/trigger events/rtc/rtc_timer_enqueue/trigge=
r events/rtc/rtc_timer_fired/trigger events/rv/error_wwnr/trigger events/rv=
/event_wwnr/trigger events/rv/rv_retries_error/trigger events/sched/sched_k=
thread_stop/trigger events/sched/sched_kthread_stop_ret/trigger events/sche=
d/sched_kthread_work_execute_end/trigger events/sched/sched_kthread_work_ex=
ecute_start/trigger events/sched/sched_kthread_work_queue_work/trigger even=
ts/sched/sched_migrate_task/trigger events/sched/sched_move_numa/trigger ev=
ents/sched/sched_pi_setprio/trigger events/sched/sched_prepare_exec/trigger=
 events/sched/sched_process_exec/trigger events/sched/sched_process_exit/tr=
igger events/sched/sched_process_fork/trigger events/sched/sched_process_fr=
ee/trigger events/sched/sched_process_hang/trigger events/sched/sched_proce=
ss_wait/trigger events/sched/sched_skip_cpuset_numa/trigger events/sched/sc=
hed_skip_vma_numa/trigger events/sched/sched_stat_blocked/trigger events/sc=
hed/sched_stat_iowait/trigger events/sched/sched_stat_runtime/trigger event=
s/sched/sched_stat_sleep/trigger events/sched/sched_stat_wait/trigger event=
s/sched/sched_stick_numa/trigger events/sched/sched_swap_numa/trigger event=
s/sched/sched_switch/trigger events/sched/sched_wait_task/trigger events/sc=
hed/sched_wake_idle_without_ipi/trigger events/sched/sched_wakeup/trigger e=
vents/sched/sched_wakeup_new/trigger events/sched/sched_waking/trigger even=
ts/sched_ext/sched_ext_bypass_lb/trigger events/sched_ext/sched_ext_dump/tr=
igger events/sched_ext/sched_ext_event/trigger events/scsi/scsi_dispatch_cm=
d_done/trigger events/scsi/scsi_dispatch_cmd_error/trigger events/scsi/scsi=
_dispatch_cmd_start/trigger events/scsi/scsi_dispatch_cmd_timeout/trigger e=
vents/scsi/scsi_eh_wakeup/trigger events/signal/signal_deliver/trigger even=
ts/signal/signal_generate/trigger events/skb/consume_skb/trigger events/skb=
/kfree_skb/trigger events/skb/skb_copy_datagram_iovec/trigger events/smbus/=
smbus_read/trigger events/smbus/smbus_reply/trigger events/smbus/smbus_resu=
lt/trigger events/smbus/smbus_write/trigger events/smc/smc_rx_recvmsg/trigg=
er events/smc/smc_switch_to_fallback/trigger events/smc/smc_tx_sendmsg/trig=
ger events/smc/smcr_link_down/trigger events/sock/inet_sk_error_report/trig=
ger events/sock/inet_sock_set_state/trigger events/sock/sk_data_ready/trigg=
er events/sock/sock_exceed_buf_limit/trigger events/sock/sock_rcvqueue_full=
/trigger events/sock/sock_recv_length/trigger events/sock/sock_send_length/=
trigger events/sof/sof_ipc3_period_elapsed_position/trigger events/sof/sof_=
ipc4_fw_config/trigger events/sof/sof_pcm_pointer_position/trigger events/s=
of/sof_stream_position_ipc_rx/trigger events/sof/sof_widget_free/trigger ev=
ents/sof/sof_widget_setup/trigger events/sof_intel/sof_intel_D0I3C_updated/=
trigger events/sof_intel/sof_intel_hda_dsp_check_stream_irq/trigger events/=
sof_intel/sof_intel_hda_dsp_pcm/trigger events/sof_intel/sof_intel_hda_dsp_=
stream_status/trigger events/sof_intel/sof_intel_hda_irq/trigger events/sof=
_intel/sof_intel_hda_irq_ipc_check/trigger events/sof_intel/sof_intel_ipc_f=
irmware_initiated/trigger events/sof_intel/sof_intel_ipc_firmware_response/=
trigger events/spi/spi_controller_busy/trigger events/spi/spi_controller_id=
le/trigger events/spi/spi_message_done/trigger events/spi/spi_message_start=
/trigger events/spi/spi_message_submit/trigger events/spi/spi_set_cs/trigge=
r events/spi/spi_setup/trigger events/spi/spi_transfer_start/trigger events=
/spi/spi_transfer_stop/trigger events/sunrpc/cache_entry_expired/trigger ev=
ents/sunrpc/cache_entry_make_negative/trigger events/sunrpc/cache_entry_no_=
listener/trigger events/sunrpc/cache_entry_upcall/trigger events/sunrpc/cac=
he_entry_update/trigger events/sunrpc/pmap_register/trigger events/sunrpc/r=
pc__auth_tooweak/trigger events/sunrpc/rpc__bad_creds/trigger events/sunrpc=
/rpc__garbage_args/trigger events/sunrpc/rpc__mismatch/trigger events/sunrp=
c/rpc__proc_unavail/trigger events/sunrpc/rpc__prog_mismatch/trigger events=
/sunrpc/rpc__prog_unavail/trigger events/sunrpc/rpc__stale_creds/trigger ev=
ents/sunrpc/rpc__unparsable/trigger events/sunrpc/rpc_bad_callhdr/trigger e=
vents/sunrpc/rpc_bad_verifier/trigger events/sunrpc/rpc_buf_alloc/trigger e=
vents/sunrpc/rpc_call_rpcerror/trigger events/sunrpc/rpc_call_status/trigge=
r events/sunrpc/rpc_clnt_clone_err/trigger events/sunrpc/rpc_clnt_free/trig=
ger events/sunrpc/rpc_clnt_killall/trigger events/sunrpc/rpc_clnt_new/trigg=
er events/sunrpc/rpc_clnt_new_err/trigger events/sunrpc/rpc_clnt_release/tr=
igger events/sunrpc/rpc_clnt_replace_xprt/trigger events/sunrpc/rpc_clnt_re=
place_xprt_err/trigger events/sunrpc/rpc_clnt_shutdown/trigger events/sunrp=
c/rpc_connect_status/trigger events/sunrpc/rpc_refresh_status/trigger event=
s/sunrpc/rpc_request/trigger events/sunrpc/rpc_retry_refresh_status/trigger=
 events/sunrpc/rpc_socket_close/trigger events/sunrpc/rpc_socket_connect/tr=
igger events/sunrpc/rpc_socket_error/trigger events/sunrpc/rpc_socket_nospa=
ce/trigger events/sunrpc/rpc_socket_reset_connection/trigger events/sunrpc/=
rpc_socket_shutdown/trigger events/sunrpc/rpc_socket_state_change/trigger e=
vents/sunrpc/rpc_stats_latency/trigger events/sunrpc/rpc_task_begin/trigger=
 events/sunrpc/rpc_task_call_done/trigger events/sunrpc/rpc_task_complete/t=
rigger events/sunrpc/rpc_task_end/trigger events/sunrpc/rpc_task_run_action=
/trigger events/sunrpc/rpc_task_signalled/trigger events/sunrpc/rpc_task_sl=
eep/trigger events/sunrpc/rpc_task_sync_sleep/trigger events/sunrpc/rpc_tas=
k_sync_wake/trigger events/sunrpc/rpc_task_timeout/trigger events/sunrpc/rp=
c_task_wakeup/trigger events/sunrpc/rpc_timeout_status/trigger events/sunrp=
c/rpc_tls_not_started/trigger events/sunrpc/rpc_tls_unavailable/trigger eve=
nts/sunrpc/rpc_xdr_alignment/trigger events/sunrpc/rpc_xdr_overflow/trigger=
 events/sunrpc/rpc_xdr_recvfrom/trigger events/sunrpc/rpc_xdr_reply_pages/t=
rigger events/sunrpc/rpc_xdr_sendto/trigger events/sunrpc/rpcb_bind_version=
_err/trigger events/sunrpc/rpcb_getport/trigger events/sunrpc/rpcb_prog_una=
vail_err/trigger events/sunrpc/rpcb_register/trigger events/sunrpc/rpcb_set=
port/trigger events/sunrpc/rpcb_timeout_err/trigger events/sunrpc/rpcb_unre=
achable_err/trigger events/sunrpc/rpcb_unrecognized_err/trigger events/sunr=
pc/rpcb_unregister/trigger events/sunrpc/svc_alloc_arg_err/trigger events/s=
unrpc/svc_authenticate/trigger events/sunrpc/svc_defer/trigger events/sunrp=
c/svc_defer_drop/trigger events/sunrpc/svc_defer_queue/trigger events/sunrp=
c/svc_defer_recv/trigger events/sunrpc/svc_drop/trigger events/sunrpc/svc_n=
oregister/trigger events/sunrpc/svc_pool_thread_noidle/trigger events/sunrp=
c/svc_pool_thread_running/trigger events/sunrpc/svc_pool_thread_wake/trigge=
r events/sunrpc/svc_process/trigger events/sunrpc/svc_register/trigger even=
ts/sunrpc/svc_replace_page_err/trigger events/sunrpc/svc_send/trigger event=
s/sunrpc/svc_stats_latency/trigger events/sunrpc/svc_tls_not_started/trigge=
r events/sunrpc/svc_tls_start/trigger events/sunrpc/svc_tls_timed_out/trigg=
er events/sunrpc/svc_tls_unavailable/trigger events/sunrpc/svc_tls_upcall/t=
rigger events/sunrpc/svc_unregister/trigger events/sunrpc/svc_xdr_recvfrom/=
trigger events/sunrpc/svc_xdr_sendto/trigger events/sunrpc/svc_xprt_accept/=
trigger events/sunrpc/svc_xprt_close/trigger events/sunrpc/svc_xprt_create_=
err/trigger events/sunrpc/svc_xprt_dequeue/trigger events/sunrpc/svc_xprt_d=
etach/trigger events/sunrpc/svc_xprt_enqueue/trigger events/sunrpc/svc_xprt=
_free/trigger events/sunrpc/svc_xprt_no_write_space/trigger events/sunrpc/s=
vcsock_accept_err/trigger events/sunrpc/svcsock_data_ready/trigger events/s=
unrpc/svcsock_free/trigger events/sunrpc/svcsock_getpeername_err/trigger ev=
ents/sunrpc/svcsock_marker/trigger events/sunrpc/svcsock_new/trigger events=
/sunrpc/svcsock_tcp_recv/trigger events/sunrpc/svcsock_tcp_recv_eagain/trig=
ger events/sunrpc/svcsock_tcp_recv_err/trigger events/sunrpc/svcsock_tcp_re=
cv_short/trigger events/sunrpc/svcsock_tcp_send/trigger events/sunrpc/svcso=
ck_tcp_state/trigger events/sunrpc/svcsock_udp_recv/trigger events/sunrpc/s=
vcsock_udp_recv_err/trigger events/sunrpc/svcsock_udp_send/trigger events/s=
unrpc/svcsock_write_space/trigger events/sunrpc/xprt_connect/trigger events=
/sunrpc/xprt_create/trigger events/sunrpc/xprt_destroy/trigger events/sunrp=
c/xprt_disconnect_auto/trigger events/sunrpc/xprt_disconnect_done/trigger e=
vents/sunrpc/xprt_disconnect_force/trigger events/sunrpc/xprt_get_cong/trig=
ger events/sunrpc/xprt_lookup_rqst/trigger events/sunrpc/xprt_ping/trigger =
events/sunrpc/xprt_put_cong/trigger events/sunrpc/xprt_release_cong/trigger=
 events/sunrpc/xprt_release_xprt/trigger events/sunrpc/xprt_reserve/trigger=
 events/sunrpc/xprt_reserve_cong/trigger events/sunrpc/xprt_reserve_xprt/tr=
igger events/sunrpc/xprt_retransmit/trigger events/sunrpc/xprt_timer/trigge=
r events/sunrpc/xprt_transmit/trigger events/sunrpc/xs_data_ready/trigger e=
vents/sunrpc/xs_stream_read_data/trigger events/sunrpc/xs_stream_read_reque=
st/trigger events/swiotlb/swiotlb_bounced/trigger events/syscalls/sys_enter=
_accept/trigger events/syscalls/sys_enter_accept4/trigger events/syscalls/s=
ys_enter_access/trigger events/syscalls/sys_enter_acct/trigger events/sysca=
lls/sys_enter_add_key/trigger events/syscalls/sys_enter_adjtimex/trigger ev=
ents/syscalls/sys_enter_alarm/trigger events/syscalls/sys_enter_arch_prctl/=
trigger events/syscalls/sys_enter_bind/trigger events/syscalls/sys_enter_bp=
f/trigger events/syscalls/sys_enter_brk/trigger events/syscalls/sys_enter_c=
achestat/trigger events/syscalls/sys_enter_capget/trigger events/syscalls/s=
ys_enter_capset/trigger events/syscalls/sys_enter_chdir/trigger events/sysc=
alls/sys_enter_chmod/trigger events/syscalls/sys_enter_chown/trigger events=
/syscalls/sys_enter_chroot/trigger events/syscalls/sys_enter_clock_adjtime/=
trigger events/syscalls/sys_enter_clock_getres/trigger events/syscalls/sys_=
enter_clock_gettime/trigger events/syscalls/sys_enter_clock_nanosleep/trigg=
er events/syscalls/sys_enter_clock_settime/trigger events/syscalls/sys_ente=
r_clone/trigger events/syscalls/sys_enter_clone3/trigger events/syscalls/sy=
s_enter_close/trigger events/syscalls/sys_enter_close_range/trigger events/=
syscalls/sys_enter_connect/trigger events/syscalls/sys_enter_copy_file_rang=
e/trigger events/syscalls/sys_enter_creat/trigger events/syscalls/sys_enter=
_delete_module/trigger events/syscalls/sys_enter_dup/trigger events/syscall=
s/sys_enter_dup2/trigger events/syscalls/sys_enter_dup3/trigger events/sysc=
alls/sys_enter_epoll_create/trigger events/syscalls/sys_enter_epoll_create1=
/trigger events/syscalls/sys_enter_epoll_ctl/trigger events/syscalls/sys_en=
ter_epoll_pwait/trigger events/syscalls/sys_enter_epoll_pwait2/trigger even=
ts/syscalls/sys_enter_epoll_wait/trigger events/syscalls/sys_enter_eventfd/=
trigger events/syscalls/sys_enter_eventfd2/trigger events/syscalls/sys_ente=
r_execve/trigger events/syscalls/sys_enter_execveat/trigger events/syscalls=
/sys_enter_exit/trigger events/syscalls/sys_enter_exit_group/trigger events=
/syscalls/sys_enter_faccessat/trigger events/syscalls/sys_enter_faccessat2/=
trigger events/syscalls/sys_enter_fadvise64/trigger events/syscalls/sys_ent=
er_fallocate/trigger events/syscalls/sys_enter_fanotify_init/trigger events=
/syscalls/sys_enter_fanotify_mark/trigger events/syscalls/sys_enter_fchdir/=
trigger events/syscalls/sys_enter_fchmod/trigger events/syscalls/sys_enter_=
fchmodat/trigger events/syscalls/sys_enter_fchmodat2/trigger events/syscall=
s/sys_enter_fchown/trigger events/syscalls/sys_enter_fchownat/trigger event=
s/syscalls/sys_enter_fcntl/trigger events/syscalls/sys_enter_fdatasync/trig=
ger events/syscalls/sys_enter_fgetxattr/trigger events/syscalls/sys_enter_f=
ile_getattr/trigger events/syscalls/sys_enter_file_setattr/trigger events/s=
yscalls/sys_enter_finit_module/trigger events/syscalls/sys_enter_flistxattr=
/trigger events/syscalls/sys_enter_flock/trigger events/syscalls/sys_enter_=
fork/trigger events/syscalls/sys_enter_fremovexattr/trigger events/syscalls=
/sys_enter_fsconfig/trigger events/syscalls/sys_enter_fsetxattr/trigger eve=
nts/syscalls/sys_enter_fsmount/trigger events/syscalls/sys_enter_fsopen/tri=
gger events/syscalls/sys_enter_fspick/trigger events/syscalls/sys_enter_fst=
atfs/trigger events/syscalls/sys_enter_fsync/trigger events/syscalls/sys_en=
ter_ftruncate/trigger events/syscalls/sys_enter_futex/trigger events/syscal=
ls/sys_enter_futex_requeue/trigger events/syscalls/sys_enter_futex_wait/tri=
gger events/syscalls/sys_enter_futex_waitv/trigger events/syscalls/sys_ente=
r_futex_wake/trigger events/syscalls/sys_enter_futimesat/trigger events/sys=
calls/sys_enter_get_mempolicy/trigger events/syscalls/sys_enter_get_robust_=
list/trigger events/syscalls/sys_enter_getcpu/trigger events/syscalls/sys_e=
nter_getcwd/trigger events/syscalls/sys_enter_getdents/trigger events/sysca=
lls/sys_enter_getdents64/trigger events/syscalls/sys_enter_getegid/trigger =
events/syscalls/sys_enter_geteuid/trigger events/syscalls/sys_enter_getgid/=
trigger events/syscalls/sys_enter_getgroups/trigger events/syscalls/sys_ent=
er_getitimer/trigger events/syscalls/sys_enter_getpeername/trigger events/s=
yscalls/sys_enter_getpgid/trigger events/syscalls/sys_enter_getpgrp/trigger=
 events/syscalls/sys_enter_getpid/trigger events/syscalls/sys_enter_getppid=
/trigger events/syscalls/sys_enter_getpriority/trigger events/syscalls/sys_=
enter_getrandom/trigger events/syscalls/sys_enter_getresgid/trigger events/=
syscalls/sys_enter_getresuid/trigger events/syscalls/sys_enter_getrlimit/tr=
igger events/syscalls/sys_enter_getrusage/trigger events/syscalls/sys_enter=
_getsid/trigger events/syscalls/sys_enter_getsockname/trigger events/syscal=
ls/sys_enter_getsockopt/trigger events/syscalls/sys_enter_gettid/trigger ev=
ents/syscalls/sys_enter_gettimeofday/trigger events/syscalls/sys_enter_getu=
id/trigger events/syscalls/sys_enter_getxattr/trigger events/syscalls/sys_e=
nter_getxattrat/trigger events/syscalls/sys_enter_init_module/trigger event=
s/syscalls/sys_enter_inotify_add_watch/trigger events/syscalls/sys_enter_in=
otify_init/trigger events/syscalls/sys_enter_inotify_init1/trigger events/s=
yscalls/sys_enter_inotify_rm_watch/trigger events/syscalls/sys_enter_io_can=
cel/trigger events/syscalls/sys_enter_io_destroy/trigger events/syscalls/sy=
s_enter_io_getevents/trigger events/syscalls/sys_enter_io_pgetevents/trigge=
r events/syscalls/sys_enter_io_setup/trigger events/syscalls/sys_enter_io_s=
ubmit/trigger events/syscalls/sys_enter_io_uring_enter/trigger events/sysca=
lls/sys_enter_io_uring_register/trigger events/syscalls/sys_enter_io_uring_=
setup/trigger events/syscalls/sys_enter_ioctl/trigger events/syscalls/sys_e=
nter_ioperm/trigger events/syscalls/sys_enter_iopl/trigger events/syscalls/=
sys_enter_ioprio_get/trigger events/syscalls/sys_enter_ioprio_set/trigger e=
vents/syscalls/sys_enter_kcmp/trigger events/syscalls/sys_enter_kexec_file_=
load/trigger events/syscalls/sys_enter_kexec_load/trigger events/syscalls/s=
ys_enter_keyctl/trigger events/syscalls/sys_enter_kill/trigger events/sysca=
lls/sys_enter_lchown/trigger events/syscalls/sys_enter_lgetxattr/trigger ev=
ents/syscalls/sys_enter_link/trigger events/syscalls/sys_enter_linkat/trigg=
er events/syscalls/sys_enter_listen/trigger events/syscalls/sys_enter_listm=
ount/trigger events/syscalls/sys_enter_listns/trigger events/syscalls/sys_e=
nter_listxattr/trigger events/syscalls/sys_enter_listxattrat/trigger events=
/syscalls/sys_enter_llistxattr/trigger events/syscalls/sys_enter_lremovexat=
tr/trigger events/syscalls/sys_enter_lseek/trigger events/syscalls/sys_ente=
r_lsetxattr/trigger events/syscalls/sys_enter_lsm_get_self_attr/trigger eve=
nts/syscalls/sys_enter_lsm_list_modules/trigger events/syscalls/sys_enter_l=
sm_set_self_attr/trigger events/syscalls/sys_enter_madvise/trigger events/s=
yscalls/sys_enter_mbind/trigger events/syscalls/sys_enter_membarrier/trigge=
r events/syscalls/sys_enter_memfd_create/trigger events/syscalls/sys_enter_=
memfd_secret/trigger events/syscalls/sys_enter_migrate_pages/trigger events=
/syscalls/sys_enter_mincore/trigger events/syscalls/sys_enter_mkdir/trigger=
 events/syscalls/sys_enter_mkdirat/trigger events/syscalls/sys_enter_mknod/=
trigger events/syscalls/sys_enter_mknodat/trigger events/syscalls/sys_enter=
_mlock/trigger events/syscalls/sys_enter_mlock2/trigger events/syscalls/sys=
_enter_mlockall/trigger events/syscalls/sys_enter_mmap/trigger events/sysca=
lls/sys_enter_modify_ldt/trigger events/syscalls/sys_enter_mount/trigger ev=
ents/syscalls/sys_enter_mount_setattr/trigger events/syscalls/sys_enter_mov=
e_mount/trigger events/syscalls/sys_enter_move_pages/trigger events/syscall=
s/sys_enter_mprotect/trigger events/syscalls/sys_enter_mq_getsetattr/trigge=
r events/syscalls/sys_enter_mq_notify/trigger events/syscalls/sys_enter_mq_=
open/trigger events/syscalls/sys_enter_mq_timedreceive/trigger events/sysca=
lls/sys_enter_mq_timedsend/trigger events/syscalls/sys_enter_mq_unlink/trig=
ger events/syscalls/sys_enter_mremap/trigger events/syscalls/sys_enter_msea=
l/trigger events/syscalls/sys_enter_msgctl/trigger events/syscalls/sys_ente=
r_msgget/trigger events/syscalls/sys_enter_msgrcv/trigger events/syscalls/s=
ys_enter_msgsnd/trigger events/syscalls/sys_enter_msync/trigger events/sysc=
alls/sys_enter_munlock/trigger events/syscalls/sys_enter_munlockall/trigger=
 events/syscalls/sys_enter_munmap/trigger events/syscalls/sys_enter_name_to=
_handle_at/trigger events/syscalls/sys_enter_nanosleep/trigger events/sysca=
lls/sys_enter_newfstat/trigger events/syscalls/sys_enter_newfstatat/trigger=
 events/syscalls/sys_enter_newlstat/trigger events/syscalls/sys_enter_newst=
at/trigger events/syscalls/sys_enter_newuname/trigger events/syscalls/sys_e=
nter_open/trigger events/syscalls/sys_enter_open_by_handle_at/trigger event=
s/syscalls/sys_enter_open_tree/trigger events/syscalls/sys_enter_open_tree_=
attr/trigger events/syscalls/sys_enter_openat/trigger events/syscalls/sys_e=
nter_openat2/trigger events/syscalls/sys_enter_pause/trigger events/syscall=
s/sys_enter_perf_event_open/trigger events/syscalls/sys_enter_personality/t=
rigger events/syscalls/sys_enter_pidfd_getfd/trigger events/syscalls/sys_en=
ter_pidfd_open/trigger events/syscalls/sys_enter_pidfd_send_signal/trigger =
events/syscalls/sys_enter_pipe/trigger events/syscalls/sys_enter_pipe2/trig=
ger events/syscalls/sys_enter_pivot_root/trigger events/syscalls/sys_enter_=
pkey_alloc/trigger events/syscalls/sys_enter_pkey_free/trigger events/sysca=
lls/sys_enter_pkey_mprotect/trigger events/syscalls/sys_enter_poll/trigger =
events/syscalls/sys_enter_ppoll/trigger events/syscalls/sys_enter_prctl/tri=
gger events/syscalls/sys_enter_pread64/trigger events/syscalls/sys_enter_pr=
eadv/trigger events/syscalls/sys_enter_preadv2/trigger events/syscalls/sys_=
enter_prlimit64/trigger events/syscalls/sys_enter_process_madvise/trigger e=
vents/syscalls/sys_enter_process_mrelease/trigger events/syscalls/sys_enter=
_process_vm_readv/trigger events/syscalls/sys_enter_process_vm_writev/trigg=
er events/syscalls/sys_enter_pselect6/trigger events/syscalls/sys_enter_ptr=
ace/trigger events/syscalls/sys_enter_pwrite64/trigger events/syscalls/sys_=
enter_pwritev/trigger events/syscalls/sys_enter_pwritev2/trigger events/sys=
calls/sys_enter_quotactl/trigger events/syscalls/sys_enter_quotactl_fd/trig=
ger events/syscalls/sys_enter_read/trigger events/syscalls/sys_enter_readah=
ead/trigger events/syscalls/sys_enter_readlink/trigger events/syscalls/sys_=
enter_readlinkat/trigger events/syscalls/sys_enter_readv/trigger events/sys=
calls/sys_enter_reboot/trigger events/syscalls/sys_enter_recvfrom/trigger e=
vents/syscalls/sys_enter_recvmmsg/trigger events/syscalls/sys_enter_recvmsg=
/trigger events/syscalls/sys_enter_remap_file_pages/trigger events/syscalls=
/sys_enter_removexattr/trigger events/syscalls/sys_enter_removexattrat/trig=
ger events/syscalls/sys_enter_rename/trigger events/syscalls/sys_enter_rena=
meat/trigger events/syscalls/sys_enter_renameat2/trigger events/syscalls/sy=
s_enter_request_key/trigger events/syscalls/sys_enter_restart_syscall/trigg=
er events/syscalls/sys_enter_rmdir/trigger events/syscalls/sys_enter_rseq/t=
rigger events/syscalls/sys_enter_rt_sigaction/trigger events/syscalls/sys_e=
nter_rt_sigpending/trigger events/syscalls/sys_enter_rt_sigprocmask/trigger=
 events/syscalls/sys_enter_rt_sigqueueinfo/trigger events/syscalls/sys_ente=
r_rt_sigreturn/trigger events/syscalls/sys_enter_rt_sigsuspend/trigger even=
ts/syscalls/sys_enter_rt_sigtimedwait/trigger events/syscalls/sys_enter_rt_=
tgsigqueueinfo/trigger events/syscalls/sys_enter_sched_get_priority_max/tri=
gger events/syscalls/sys_enter_sched_get_priority_min/trigger events/syscal=
ls/sys_enter_sched_getaffinity/trigger events/syscalls/sys_enter_sched_geta=
ttr/trigger events/syscalls/sys_enter_sched_getparam/trigger events/syscall=
s/sys_enter_sched_getscheduler/trigger events/syscalls/sys_enter_sched_rr_g=
et_interval/trigger events/syscalls/sys_enter_sched_setaffinity/trigger eve=
nts/syscalls/sys_enter_sched_setattr/trigger events/syscalls/sys_enter_sche=
d_setparam/trigger events/syscalls/sys_enter_sched_setscheduler/trigger eve=
nts/syscalls/sys_enter_sched_yield/trigger events/syscalls/sys_enter_seccom=
p/trigger events/syscalls/sys_enter_select/trigger events/syscalls/sys_ente=
r_semctl/trigger events/syscalls/sys_enter_semget/trigger events/syscalls/s=
ys_enter_semop/trigger events/syscalls/sys_enter_semtimedop/trigger events/=
syscalls/sys_enter_sendfile64/trigger events/syscalls/sys_enter_sendmmsg/tr=
igger events/syscalls/sys_enter_sendmsg/trigger events/syscalls/sys_enter_s=
endto/trigger events/syscalls/sys_enter_set_mempolicy/trigger events/syscal=
ls/sys_enter_set_mempolicy_home_node/trigger events/syscalls/sys_enter_set_=
robust_list/trigger events/syscalls/sys_enter_set_tid_address/trigger event=
s/syscalls/sys_enter_setdomainname/trigger events/syscalls/sys_enter_setfsg=
id/trigger events/syscalls/sys_enter_setfsuid/trigger events/syscalls/sys_e=
nter_setgid/trigger events/syscalls/sys_enter_setgroups/trigger events/sysc=
alls/sys_enter_sethostname/trigger events/syscalls/sys_enter_setitimer/trig=
ger events/syscalls/sys_enter_setns/trigger events/syscalls/sys_enter_setpg=
id/trigger events/syscalls/sys_enter_setpriority/trigger events/syscalls/sy=
s_enter_setregid/trigger events/syscalls/sys_enter_setresgid/trigger events=
/syscalls/sys_enter_setresuid/trigger events/syscalls/sys_enter_setreuid/tr=
igger events/syscalls/sys_enter_setrlimit/trigger events/syscalls/sys_enter=
_setsid/trigger events/syscalls/sys_enter_setsockopt/trigger events/syscall=
s/sys_enter_settimeofday/trigger events/syscalls/sys_enter_setuid/trigger e=
vents/syscalls/sys_enter_setxattr/trigger events/syscalls/sys_enter_setxatt=
rat/trigger events/syscalls/sys_enter_shmat/trigger events/syscalls/sys_ent=
er_shmctl/trigger events/syscalls/sys_enter_shmdt/trigger events/syscalls/s=
ys_enter_shmget/trigger events/syscalls/sys_enter_shutdown/trigger events/s=
yscalls/sys_enter_sigaltstack/trigger events/syscalls/sys_enter_signalfd/tr=
igger events/syscalls/sys_enter_signalfd4/trigger events/syscalls/sys_enter=
_socket/trigger events/syscalls/sys_enter_socketpair/trigger events/syscall=
s/sys_enter_splice/trigger events/syscalls/sys_enter_statfs/trigger events/=
syscalls/sys_enter_statmount/trigger events/syscalls/sys_enter_statx/trigge=
r events/syscalls/sys_enter_swapoff/trigger events/syscalls/sys_enter_swapo=
n/trigger events/syscalls/sys_enter_symlink/trigger events/syscalls/sys_ent=
er_symlinkat/trigger events/syscalls/sys_enter_sync/trigger events/syscalls=
/sys_enter_sync_file_range/trigger events/syscalls/sys_enter_syncfs/trigger=
 events/syscalls/sys_enter_sysfs/trigger events/syscalls/sys_enter_sysinfo/=
trigger events/syscalls/sys_enter_syslog/trigger events/syscalls/sys_enter_=
tee/trigger events/syscalls/sys_enter_tgkill/trigger events/syscalls/sys_en=
ter_time/trigger events/syscalls/sys_enter_timer_create/trigger events/sysc=
alls/sys_enter_timer_delete/trigger events/syscalls/sys_enter_timer_getover=
run/trigger events/syscalls/sys_enter_timer_gettime/trigger events/syscalls=
/sys_enter_timer_settime/trigger events/syscalls/sys_enter_timerfd_create/t=
rigger events/syscalls/sys_enter_timerfd_gettime/trigger events/syscalls/sy=
s_enter_timerfd_settime/trigger events/syscalls/sys_enter_times/trigger eve=
nts/syscalls/sys_enter_tkill/trigger events/syscalls/sys_enter_truncate/tri=
gger events/syscalls/sys_enter_umask/trigger events/syscalls/sys_enter_umou=
nt/trigger events/syscalls/sys_enter_unlink/trigger events/syscalls/sys_ent=
er_unlinkat/trigger events/syscalls/sys_enter_unshare/trigger events/syscal=
ls/sys_enter_uprobe/trigger events/syscalls/sys_enter_uretprobe/trigger eve=
nts/syscalls/sys_enter_userfaultfd/trigger events/syscalls/sys_enter_ustat/=
trigger events/syscalls/sys_enter_utime/trigger events/syscalls/sys_enter_u=
timensat/trigger events/syscalls/sys_enter_utimes/trigger events/syscalls/s=
ys_enter_vfork/trigger events/syscalls/sys_enter_vhangup/trigger events/sys=
calls/sys_enter_vmsplice/trigger events/syscalls/sys_enter_wait4/trigger ev=
ents/syscalls/sys_enter_waitid/trigger events/syscalls/sys_enter_write/trig=
ger events/syscalls/sys_enter_writev/trigger events/syscalls/sys_exit_accep=
t/trigger events/syscalls/sys_exit_accept4/trigger events/syscalls/sys_exit=
_access/trigger events/syscalls/sys_exit_acct/trigger events/syscalls/sys_e=
xit_add_key/trigger events/syscalls/sys_exit_adjtimex/trigger events/syscal=
ls/sys_exit_alarm/trigger events/syscalls/sys_exit_arch_prctl/trigger event=
s/syscalls/sys_exit_bind/trigger events/syscalls/sys_exit_bpf/trigger event=
s/syscalls/sys_exit_brk/trigger events/syscalls/sys_exit_cachestat/trigger =
events/syscalls/sys_exit_capget/trigger events/syscalls/sys_exit_capset/tri=
gger events/syscalls/sys_exit_chdir/trigger events/syscalls/sys_exit_chmod/=
trigger events/syscalls/sys_exit_chown/trigger events/syscalls/sys_exit_chr=
oot/trigger events/syscalls/sys_exit_clock_adjtime/trigger events/syscalls/=
sys_exit_clock_getres/trigger events/syscalls/sys_exit_clock_gettime/trigge=
r events/syscalls/sys_exit_clock_nanosleep/trigger events/syscalls/sys_exit=
_clock_settime/trigger events/syscalls/sys_exit_clone/trigger events/syscal=
ls/sys_exit_clone3/trigger events/syscalls/sys_exit_close/trigger events/sy=
scalls/sys_exit_close_range/trigger events/syscalls/sys_exit_connect/trigge=
r events/syscalls/sys_exit_copy_file_range/trigger events/syscalls/sys_exit=
_creat/trigger events/syscalls/sys_exit_delete_module/trigger events/syscal=
ls/sys_exit_dup/trigger events/syscalls/sys_exit_dup2/trigger events/syscal=
ls/sys_exit_dup3/trigger events/syscalls/sys_exit_epoll_create/trigger even=
ts/syscalls/sys_exit_epoll_create1/trigger events/syscalls/sys_exit_epoll_c=
tl/trigger events/syscalls/sys_exit_epoll_pwait/trigger events/syscalls/sys=
_exit_epoll_pwait2/trigger events/syscalls/sys_exit_epoll_wait/trigger even=
ts/syscalls/sys_exit_eventfd/trigger events/syscalls/sys_exit_eventfd2/trig=
ger events/syscalls/sys_exit_execve/trigger events/syscalls/sys_exit_execve=
at/trigger events/syscalls/sys_exit_exit/trigger events/syscalls/sys_exit_e=
xit_group/trigger events/syscalls/sys_exit_faccessat/trigger events/syscall=
s/sys_exit_faccessat2/trigger events/syscalls/sys_exit_fadvise64/trigger ev=
ents/syscalls/sys_exit_fallocate/trigger events/syscalls/sys_exit_fanotify_=
init/trigger events/syscalls/sys_exit_fanotify_mark/trigger events/syscalls=
/sys_exit_fchdir/trigger events/syscalls/sys_exit_fchmod/trigger events/sys=
calls/sys_exit_fchmodat/trigger events/syscalls/sys_exit_fchmodat2/trigger =
events/syscalls/sys_exit_fchown/trigger events/syscalls/sys_exit_fchownat/t=
rigger events/syscalls/sys_exit_fcntl/trigger events/syscalls/sys_exit_fdat=
async/trigger events/syscalls/sys_exit_fgetxattr/trigger events/syscalls/sy=
s_exit_file_getattr/trigger events/syscalls/sys_exit_file_setattr/trigger e=
vents/syscalls/sys_exit_finit_module/trigger events/syscalls/sys_exit_flist=
xattr/trigger events/syscalls/sys_exit_flock/trigger events/syscalls/sys_ex=
it_fork/trigger events/syscalls/sys_exit_fremovexattr/trigger events/syscal=
ls/sys_exit_fsconfig/trigger events/syscalls/sys_exit_fsetxattr/trigger eve=
nts/syscalls/sys_exit_fsmount/trigger events/syscalls/sys_exit_fsopen/trigg=
er events/syscalls/sys_exit_fspick/trigger events/syscalls/sys_exit_fstatfs=
/trigger events/syscalls/sys_exit_fsync/trigger events/syscalls/sys_exit_ft=
runcate/trigger events/syscalls/sys_exit_futex/trigger events/syscalls/sys_=
exit_futex_requeue/trigger events/syscalls/sys_exit_futex_wait/trigger even=
ts/syscalls/sys_exit_futex_waitv/trigger events/syscalls/sys_exit_futex_wak=
e/trigger events/syscalls/sys_exit_futimesat/trigger events/syscalls/sys_ex=
it_get_mempolicy/trigger events/syscalls/sys_exit_get_robust_list/trigger e=
vents/syscalls/sys_exit_getcpu/trigger events/syscalls/sys_exit_getcwd/trig=
ger events/syscalls/sys_exit_getdents/trigger events/syscalls/sys_exit_getd=
ents64/trigger events/syscalls/sys_exit_getegid/trigger events/syscalls/sys=
_exit_geteuid/trigger events/syscalls/sys_exit_getgid/trigger events/syscal=
ls/sys_exit_getgroups/trigger events/syscalls/sys_exit_getitimer/trigger ev=
ents/syscalls/sys_exit_getpeername/trigger events/syscalls/sys_exit_getpgid=
/trigger events/syscalls/sys_exit_getpgrp/trigger events/syscalls/sys_exit_=
getpid/trigger events/syscalls/sys_exit_getppid/trigger events/syscalls/sys=
_exit_getpriority/trigger events/syscalls/sys_exit_getrandom/trigger events=
/syscalls/sys_exit_getresgid/trigger events/syscalls/sys_exit_getresuid/tri=
gger events/syscalls/sys_exit_getrlimit/trigger events/syscalls/sys_exit_ge=
trusage/trigger events/syscalls/sys_exit_getsid/trigger events/syscalls/sys=
_exit_getsockname/trigger events/syscalls/sys_exit_getsockopt/trigger event=
s/syscalls/sys_exit_gettid/trigger events/syscalls/sys_exit_gettimeofday/tr=
igger events/syscalls/sys_exit_getuid/trigger events/syscalls/sys_exit_getx=
attr/trigger events/syscalls/sys_exit_getxattrat/trigger events/syscalls/sy=
s_exit_init_module/trigger events/syscalls/sys_exit_inotify_add_watch/trigg=
er events/syscalls/sys_exit_inotify_init/trigger events/syscalls/sys_exit_i=
notify_init1/trigger events/syscalls/sys_exit_inotify_rm_watch/trigger even=
ts/syscalls/sys_exit_io_cancel/trigger events/syscalls/sys_exit_io_destroy/=
trigger events/syscalls/sys_exit_io_getevents/trigger events/syscalls/sys_e=
xit_io_pgetevents/trigger events/syscalls/sys_exit_io_setup/trigger events/=
syscalls/sys_exit_io_submit/trigger events/syscalls/sys_exit_io_uring_enter=
/trigger events/syscalls/sys_exit_io_uring_register/trigger events/syscalls=
/sys_exit_io_uring_setup/trigger events/syscalls/sys_exit_ioctl/trigger eve=
nts/syscalls/sys_exit_ioperm/trigger events/syscalls/sys_exit_iopl/trigger =
events/syscalls/sys_exit_ioprio_get/trigger events/syscalls/sys_exit_ioprio=
_set/trigger events/syscalls/sys_exit_kcmp/trigger events/syscalls/sys_exit=
_kexec_file_load/trigger events/syscalls/sys_exit_kexec_load/trigger events=
/syscalls/sys_exit_keyctl/trigger events/syscalls/sys_exit_kill/trigger eve=
nts/syscalls/sys_exit_lchown/trigger events/syscalls/sys_exit_lgetxattr/tri=
gger events/syscalls/sys_exit_link/trigger events/syscalls/sys_exit_linkat/=
trigger events/syscalls/sys_exit_listen/trigger events/syscalls/sys_exit_li=
stmount/trigger events/syscalls/sys_exit_listns/trigger events/syscalls/sys=
_exit_listxattr/trigger events/syscalls/sys_exit_listxattrat/trigger events=
/syscalls/sys_exit_llistxattr/trigger events/syscalls/sys_exit_lremovexattr=
/trigger events/syscalls/sys_exit_lseek/trigger events/syscalls/sys_exit_ls=
etxattr/trigger events/syscalls/sys_exit_lsm_get_self_attr/trigger events/s=
yscalls/sys_exit_lsm_list_modules/trigger events/syscalls/sys_exit_lsm_set_=
self_attr/trigger events/syscalls/sys_exit_madvise/trigger events/syscalls/=
sys_exit_mbind/trigger events/syscalls/sys_exit_membarrier/trigger events/s=
yscalls/sys_exit_memfd_create/trigger events/syscalls/sys_exit_memfd_secret=
/trigger events/syscalls/sys_exit_migrate_pages/trigger events/syscalls/sys=
_exit_mincore/trigger events/syscalls/sys_exit_mkdir/trigger events/syscall=
s/sys_exit_mkdirat/trigger events/syscalls/sys_exit_mknod/trigger events/sy=
scalls/sys_exit_mknodat/trigger events/syscalls/sys_exit_mlock/trigger even=
ts/syscalls/sys_exit_mlock2/trigger events/syscalls/sys_exit_mlockall/trigg=
er events/syscalls/sys_exit_mmap/trigger events/syscalls/sys_exit_modify_ld=
t/trigger events/syscalls/sys_exit_mount/trigger events/syscalls/sys_exit_m=
ount_setattr/trigger events/syscalls/sys_exit_move_mount/trigger events/sys=
calls/sys_exit_move_pages/trigger events/syscalls/sys_exit_mprotect/trigger=
 events/syscalls/sys_exit_mq_getsetattr/trigger events/syscalls/sys_exit_mq=
_notify/trigger events/syscalls/sys_exit_mq_open/trigger events/syscalls/sy=
s_exit_mq_timedreceive/trigger events/syscalls/sys_exit_mq_timedsend/trigge=
r events/syscalls/sys_exit_mq_unlink/trigger events/syscalls/sys_exit_mrema=
p/trigger events/syscalls/sys_exit_mseal/trigger events/syscalls/sys_exit_m=
sgctl/trigger events/syscalls/sys_exit_msgget/trigger events/syscalls/sys_e=
xit_msgrcv/trigger events/syscalls/sys_exit_msgsnd/trigger events/syscalls/=
sys_exit_msync/trigger events/syscalls/sys_exit_munlock/trigger events/sysc=
alls/sys_exit_munlockall/trigger events/syscalls/sys_exit_munmap/trigger ev=
ents/syscalls/sys_exit_name_to_handle_at/trigger events/syscalls/sys_exit_n=
anosleep/trigger events/syscalls/sys_exit_newfstat/trigger events/syscalls/=
sys_exit_newfstatat/trigger events/syscalls/sys_exit_newlstat/trigger event=
s/syscalls/sys_exit_newstat/trigger events/syscalls/sys_exit_newuname/trigg=
er events/syscalls/sys_exit_open/trigger events/syscalls/sys_exit_open_by_h=
andle_at/trigger events/syscalls/sys_exit_open_tree/trigger events/syscalls=
/sys_exit_open_tree_attr/trigger events/syscalls/sys_exit_openat/trigger ev=
ents/syscalls/sys_exit_openat2/trigger events/syscalls/sys_exit_pause/trigg=
er events/syscalls/sys_exit_perf_event_open/trigger events/syscalls/sys_exi=
t_personality/trigger events/syscalls/sys_exit_pidfd_getfd/trigger events/s=
yscalls/sys_exit_pidfd_open/trigger events/syscalls/sys_exit_pidfd_send_sig=
nal/trigger events/syscalls/sys_exit_pipe/trigger events/syscalls/sys_exit_=
pipe2/trigger events/syscalls/sys_exit_pivot_root/trigger events/syscalls/s=
ys_exit_pkey_alloc/trigger events/syscalls/sys_exit_pkey_free/trigger event=
s/syscalls/sys_exit_pkey_mprotect/trigger events/syscalls/sys_exit_poll/tri=
gger events/syscalls/sys_exit_ppoll/trigger events/syscalls/sys_exit_prctl/=
trigger events/syscalls/sys_exit_pread64/trigger events/syscalls/sys_exit_p=
readv/trigger events/syscalls/sys_exit_preadv2/trigger events/syscalls/sys_=
exit_prlimit64/trigger events/syscalls/sys_exit_process_madvise/trigger eve=
nts/syscalls/sys_exit_process_mrelease/trigger events/syscalls/sys_exit_pro=
cess_vm_readv/trigger events/syscalls/sys_exit_process_vm_writev/trigger ev=
ents/syscalls/sys_exit_pselect6/trigger events/syscalls/sys_exit_ptrace/tri=
gger events/syscalls/sys_exit_pwrite64/trigger events/syscalls/sys_exit_pwr=
itev/trigger events/syscalls/sys_exit_pwritev2/trigger events/syscalls/sys_=
exit_quotactl/trigger events/syscalls/sys_exit_quotactl_fd/trigger events/s=
yscalls/sys_exit_read/trigger events/syscalls/sys_exit_readahead/trigger ev=
ents/syscalls/sys_exit_readlink/trigger events/syscalls/sys_exit_readlinkat=
/trigger events/syscalls/sys_exit_readv/trigger events/syscalls/sys_exit_re=
boot/trigger events/syscalls/sys_exit_recvfrom/trigger events/syscalls/sys_=
exit_recvmmsg/trigger events/syscalls/sys_exit_recvmsg/trigger events/sysca=
lls/sys_exit_remap_file_pages/trigger events/syscalls/sys_exit_removexattr/=
trigger events/syscalls/sys_exit_removexattrat/trigger events/syscalls/sys_=
exit_rename/trigger events/syscalls/sys_exit_renameat/trigger events/syscal=
ls/sys_exit_renameat2/trigger events/syscalls/sys_exit_request_key/trigger =
events/syscalls/sys_exit_restart_syscall/trigger events/syscalls/sys_exit_r=
mdir/trigger events/syscalls/sys_exit_rseq/trigger events/syscalls/sys_exit=
_rt_sigaction/trigger events/syscalls/sys_exit_rt_sigpending/trigger events=
/syscalls/sys_exit_rt_sigprocmask/trigger events/syscalls/sys_exit_rt_sigqu=
eueinfo/trigger events/syscalls/sys_exit_rt_sigreturn/trigger events/syscal=
ls/sys_exit_rt_sigsuspend/trigger events/syscalls/sys_exit_rt_sigtimedwait/=
trigger events/syscalls/sys_exit_rt_tgsigqueueinfo/trigger events/syscalls/=
sys_exit_sched_get_priority_max/trigger events/syscalls/sys_exit_sched_get_=
priority_min/trigger events/syscalls/sys_exit_sched_getaffinity/trigger eve=
nts/syscalls/sys_exit_sched_getattr/trigger events/syscalls/sys_exit_sched_=
getparam/trigger events/syscalls/sys_exit_sched_getscheduler/trigger events=
/syscalls/sys_exit_sched_rr_get_interval/trigger events/syscalls/sys_exit_s=
ched_setaffinity/trigger events/syscalls/sys_exit_sched_setattr/trigger eve=
nts/syscalls/sys_exit_sched_setparam/trigger events/syscalls/sys_exit_sched=
_setscheduler/trigger events/syscalls/sys_exit_sched_yield/trigger events/s=
yscalls/sys_exit_seccomp/trigger events/syscalls/sys_exit_select/trigger ev=
ents/syscalls/sys_exit_semctl/trigger events/syscalls/sys_exit_semget/trigg=
er events/syscalls/sys_exit_semop/trigger events/syscalls/sys_exit_semtimed=
op/trigger events/syscalls/sys_exit_sendfile64/trigger events/syscalls/sys_=
exit_sendmmsg/trigger events/syscalls/sys_exit_sendmsg/trigger events/sysca=
lls/sys_exit_sendto/trigger events/syscalls/sys_exit_set_mempolicy/trigger =
events/syscalls/sys_exit_set_mempolicy_home_node/trigger events/syscalls/sy=
s_exit_set_robust_list/trigger events/syscalls/sys_exit_set_tid_address/tri=
gger events/syscalls/sys_exit_setdomainname/trigger events/syscalls/sys_exi=
t_setfsgid/trigger events/syscalls/sys_exit_setfsuid/trigger events/syscall=
s/sys_exit_setgid/trigger events/syscalls/sys_exit_setgroups/trigger events=
/syscalls/sys_exit_sethostname/trigger events/syscalls/sys_exit_setitimer/t=
rigger events/syscalls/sys_exit_setns/trigger events/syscalls/sys_exit_setp=
gid/trigger events/syscalls/sys_exit_setpriority/trigger events/syscalls/sy=
s_exit_setregid/trigger events/syscalls/sys_exit_setresgid/trigger events/s=
yscalls/sys_exit_setresuid/trigger events/syscalls/sys_exit_setreuid/trigge=
r events/syscalls/sys_exit_setrlimit/trigger events/syscalls/sys_exit_setsi=
d/trigger events/syscalls/sys_exit_setsockopt/trigger events/syscalls/sys_e=
xit_settimeofday/trigger events/syscalls/sys_exit_setuid/trigger events/sys=
calls/sys_exit_setxattr/trigger events/syscalls/sys_exit_setxattrat/trigger=
 events/syscalls/sys_exit_shmat/trigger events/syscalls/sys_exit_shmctl/tri=
gger events/syscalls/sys_exit_shmdt/trigger events/syscalls/sys_exit_shmget=
/trigger events/syscalls/sys_exit_shutdown/trigger events/syscalls/sys_exit=
_sigaltstack/trigger events/syscalls/sys_exit_signalfd/trigger events/sysca=
lls/sys_exit_signalfd4/trigger events/syscalls/sys_exit_socket/trigger even=
ts/syscalls/sys_exit_socketpair/trigger events/syscalls/sys_exit_splice/tri=
gger events/syscalls/sys_exit_statfs/trigger events/syscalls/sys_exit_statm=
ount/trigger events/syscalls/sys_exit_statx/trigger events/syscalls/sys_exi=
t_swapoff/trigger events/syscalls/sys_exit_swapon/trigger events/syscalls/s=
ys_exit_symlink/trigger events/syscalls/sys_exit_symlinkat/trigger events/s=
yscalls/sys_exit_sync/trigger events/syscalls/sys_exit_sync_file_range/trig=
ger events/syscalls/sys_exit_syncfs/trigger events/syscalls/sys_exit_sysfs/=
trigger events/syscalls/sys_exit_sysinfo/trigger events/syscalls/sys_exit_s=
yslog/trigger events/syscalls/sys_exit_tee/trigger events/syscalls/sys_exit=
_tgkill/trigger events/syscalls/sys_exit_time/trigger events/syscalls/sys_e=
xit_timer_create/trigger events/syscalls/sys_exit_timer_delete/trigger even=
ts/syscalls/sys_exit_timer_getoverrun/trigger events/syscalls/sys_exit_time=
r_gettime/trigger events/syscalls/sys_exit_timer_settime/trigger events/sys=
calls/sys_exit_timerfd_create/trigger events/syscalls/sys_exit_timerfd_gett=
ime/trigger events/syscalls/sys_exit_timerfd_settime/trigger events/syscall=
s/sys_exit_times/trigger events/syscalls/sys_exit_tkill/trigger events/sysc=
alls/sys_exit_truncate/trigger events/syscalls/sys_exit_umask/trigger event=
s/syscalls/sys_exit_umount/trigger events/syscalls/sys_exit_unlink/trigger =
events/syscalls/sys_exit_unlinkat/trigger events/syscalls/sys_exit_unshare/=
trigger events/syscalls/sys_exit_uprobe/trigger events/syscalls/sys_exit_ur=
etprobe/trigger events/syscalls/sys_exit_userfaultfd/trigger events/syscall=
s/sys_exit_ustat/trigger events/syscalls/sys_exit_utime/trigger events/sysc=
alls/sys_exit_utimensat/trigger events/syscalls/sys_exit_utimes/trigger eve=
nts/syscalls/sys_exit_vfork/trigger events/syscalls/sys_exit_vhangup/trigge=
r events/syscalls/sys_exit_vmsplice/trigger events/syscalls/sys_exit_wait4/=
trigger events/syscalls/sys_exit_waitid/trigger events/syscalls/sys_exit_wr=
ite/trigger events/syscalls/sys_exit_writev/trigger events/task/task_newtas=
k/trigger events/task/task_prctl_unknown/trigger events/task/task_rename/tr=
igger events/tcp/tcp_ao_handshake_failure/trigger events/tcp/tcp_ao_key_not=
_found/trigger events/tcp/tcp_ao_mismatch/trigger events/tcp/tcp_ao_rcv_sne=
_update/trigger events/tcp/tcp_ao_rnext_request/trigger events/tcp/tcp_ao_s=
nd_sne_update/trigger events/tcp/tcp_ao_synack_no_key/trigger events/tcp/tc=
p_ao_wrong_maclen/trigger events/tcp/tcp_bad_csum/trigger events/tcp/tcp_co=
ng_state_set/trigger events/tcp/tcp_destroy_sock/trigger events/tcp/tcp_has=
h_ao_required/trigger events/tcp/tcp_hash_bad_header/trigger events/tcp/tcp=
_hash_md5_mismatch/trigger events/tcp/tcp_hash_md5_required/trigger events/=
tcp/tcp_hash_md5_unexpected/trigger events/tcp/tcp_probe/trigger events/tcp=
/tcp_rcv_space_adjust/trigger events/tcp/tcp_rcvbuf_grow/trigger events/tcp=
/tcp_receive_reset/trigger events/tcp/tcp_retransmit_skb/trigger events/tcp=
/tcp_retransmit_synack/trigger events/tcp/tcp_send_reset/trigger events/tcp=
/tcp_sendmsg_locked/trigger events/thermal/cdev_update/trigger events/therm=
al/thermal_temperature/trigger events/thermal/thermal_zone_trip/trigger eve=
nts/thp/remove_migration_pmd/trigger events/thp/set_migration_pmd/trigger e=
vents/thunderbolt/tb_event/trigger events/thunderbolt/tb_rx/trigger events/=
thunderbolt/tb_tx/trigger events/timer/hrtimer_cancel/trigger events/timer/=
hrtimer_expire_entry/trigger events/timer/hrtimer_expire_exit/trigger event=
s/timer/hrtimer_rearm/trigger events/timer/hrtimer_setup/trigger events/tim=
er/hrtimer_start/trigger events/timer/hrtimer_start_expired/trigger events/=
timer/itimer_expire/trigger events/timer/itimer_state/trigger events/timer/=
tick_stop/trigger events/timer/timer_base_idle/trigger events/timer/timer_c=
ancel/trigger events/timer/timer_expire_entry/trigger events/timer/timer_ex=
pire_exit/trigger events/timer/timer_init/trigger events/timer/timer_start/=
trigger events/timer_migration/tmigr_connect_child_parent/trigger events/ti=
mer_migration/tmigr_connect_cpu_parent/trigger events/timer_migration/tmigr=
_cpu_active/trigger events/timer_migration/tmigr_cpu_available/trigger even=
ts/timer_migration/tmigr_cpu_idle/trigger events/timer_migration/tmigr_cpu_=
new_timer/trigger events/timer_migration/tmigr_cpu_new_timer_idle/trigger e=
vents/timer_migration/tmigr_cpu_unavailable/trigger events/timer_migration/=
tmigr_group_set/trigger events/timer_migration/tmigr_group_set_cpu_active/t=
rigger events/timer_migration/tmigr_group_set_cpu_inactive/trigger events/t=
imer_migration/tmigr_handle_remote/trigger events/timer_migration/tmigr_han=
dle_remote_cpu/trigger events/timer_migration/tmigr_update_events/trigger e=
vents/timestamp/ctime_ns_xchg/trigger events/timestamp/ctime_xchg_skip/trig=
ger events/timestamp/fill_mg_cmtime/trigger events/timestamp/inode_set_ctim=
e_to_ts/trigger events/tlb/tlb_flush/trigger events/tsm_mr/tsm_mr_read/trig=
ger events/tsm_mr/tsm_mr_refresh/trigger events/tsm_mr/tsm_mr_write/trigger=
 events/ucsi/ucsi_connector_change/trigger events/ucsi/ucsi_register_altmod=
e/trigger events/ucsi/ucsi_register_port/trigger events/ucsi/ucsi_reset_ppm=
/trigger events/ucsi/ucsi_run_command/trigger events/udp/udp_fail_queue_rcv=
_skb/trigger events/usbcore/usb_alloc_dev/trigger events/usbcore/usb_set_de=
vice_state/trigger events/vmalloc/alloc_vmap_area/trigger events/vmalloc/fr=
ee_vmap_area_noflush/trigger events/vmalloc/purge_vmap_area_lazy/trigger ev=
ents/vmscan/mm_shrink_slab_end/trigger events/vmscan/mm_shrink_slab_start/t=
rigger events/vmscan/mm_vmscan_balance_pgdat_begin/trigger events/vmscan/mm=
_vmscan_balance_pgdat_end/trigger events/vmscan/mm_vmscan_direct_reclaim_be=
gin/trigger events/vmscan/mm_vmscan_direct_reclaim_end/trigger events/vmsca=
n/mm_vmscan_kswapd_clear_hopeless/trigger events/vmscan/mm_vmscan_kswapd_re=
claim_fail/trigger events/vmscan/mm_vmscan_kswapd_sleep/trigger events/vmsc=
an/mm_vmscan_kswapd_wake/trigger events/vmscan/mm_vmscan_lru_isolate/trigge=
r events/vmscan/mm_vmscan_lru_shrink_active/trigger events/vmscan/mm_vmscan=
_lru_shrink_inactive/trigger events/vmscan/mm_vmscan_memcg_reclaim_begin/tr=
igger events/vmscan/mm_vmscan_memcg_reclaim_end/trigger events/vmscan/mm_vm=
scan_memcg_softlimit_reclaim_begin/trigger events/vmscan/mm_vmscan_memcg_so=
ftlimit_reclaim_end/trigger events/vmscan/mm_vmscan_node_reclaim_begin/trig=
ger events/vmscan/mm_vmscan_node_reclaim_end/trigger events/vmscan/mm_vmsca=
n_reclaim_pages/trigger events/vmscan/mm_vmscan_throttled/trigger events/vm=
scan/mm_vmscan_wakeup_kswapd/trigger events/vmscan/mm_vmscan_write_folio/tr=
igger events/vsyscall/emulate_vsyscall/trigger events/watchdog/watchdog_pin=
g/trigger events/watchdog/watchdog_set_timeout/trigger events/watchdog/watc=
hdog_start/trigger events/watchdog/watchdog_stop/trigger events/wbt/wbt_lat=
/trigger events/wbt/wbt_stat/trigger events/wbt/wbt_step/trigger events/wbt=
/wbt_timer/trigger events/workqueue/workqueue_activate_work/trigger events/=
workqueue/workqueue_execute_end/trigger events/workqueue/workqueue_execute_=
start/trigger events/workqueue/workqueue_queue_work/trigger events/writebac=
k/balance_dirty_pages/trigger events/writeback/bdi_dirty_ratelimit/trigger =
events/writeback/flush_foreign/trigger events/writeback/folio_wait_writebac=
k/trigger events/writeback/global_dirty_state/trigger events/writeback/inod=
e_foreign_history/trigger events/writeback/inode_switch_wbs/trigger events/=
writeback/inode_switch_wbs_queue/trigger events/writeback/sb_clear_inode_wr=
iteback/trigger events/writeback/sb_mark_inode_writeback/trigger events/wri=
teback/track_foreign_dirty/trigger events/writeback/wbc_writepage/trigger e=
vents/writeback/writeback_bdi_register/trigger events/writeback/writeback_d=
irty_folio/trigger events/writeback/writeback_dirty_inode/trigger events/wr=
iteback/writeback_dirty_inode_enqueue/trigger events/writeback/writeback_di=
rty_inode_start/trigger events/writeback/writeback_exec/trigger events/writ=
eback/writeback_lazytime/trigger events/writeback/writeback_mark_inode_dirt=
y/trigger events/writeback/writeback_pages_written/trigger events/writeback=
/writeback_queue/trigger events/writeback/writeback_queue_io/trigger events=
/writeback/writeback_sb_inodes_requeue/trigger events/writeback/writeback_s=
ingle_inode/trigger events/writeback/writeback_single_inode_start/trigger e=
vents/writeback/writeback_start/trigger events/writeback/writeback_wait/tri=
gger events/writeback/writeback_wake_background/trigger events/writeback/wr=
iteback_write_inode/trigger events/writeback/writeback_write_inode_start/tr=
igger events/writeback/writeback_written/trigger events/x86_fpu/x86_fpu_aft=
er_save/trigger events/x86_fpu/x86_fpu_before_save/trigger events/x86_fpu/x=
86_fpu_copy_dst/trigger events/x86_fpu/x86_fpu_dropped/trigger events/x86_f=
pu/x86_fpu_regs_activated/trigger events/x86_fpu/x86_fpu_regs_deactivated/t=
rigger events/x86_fpu/x86_fpu_xstate_check_failed/trigger events/xdp/bpf_xd=
p_link_attach_failed/trigger events/xdp/mem_connect/trigger events/xdp/mem_=
disconnect/trigger events/xdp/xdp_bulk_tx/trigger events/xdp/xdp_cpumap_enq=
ueue/trigger events/xdp/xdp_cpumap_kthread/trigger events/xdp/xdp_devmap_xm=
it/trigger events/xdp/xdp_exception/trigger events/xdp/xdp_redirect/trigger=
 events/xdp/xdp_redirect_err/trigger events/xen/xen_cpu_load_idt/trigger ev=
ents/xen/xen_cpu_set_ldt/trigger events/xen/xen_cpu_write_gdt_entry/trigger=
 events/xen/xen_cpu_write_idt_entry/trigger events/xen/xen_cpu_write_ldt_en=
try/trigger events/xen/xen_mc_batch/trigger events/xen/xen_mc_callback/trig=
ger events/xen/xen_mc_entry/trigger events/xen/xen_mc_entry_alloc/trigger e=
vents/xen/xen_mc_extend_args/trigger events/xen/xen_mc_flush/trigger events=
/xen/xen_mc_flush_reason/trigger events/xen/xen_mc_issue/trigger events/xen=
/xen_mmu_alloc_ptpage/trigger events/xen/xen_mmu_flush_tlb_multi/trigger ev=
ents/xen/xen_mmu_flush_tlb_one_user/trigger events/xen/xen_mmu_pgd_pin/trig=
ger events/xen/xen_mmu_pgd_unpin/trigger events/xen/xen_mmu_ptep_modify_pro=
t_commit/trigger events/xen/xen_mmu_ptep_modify_prot_start/trigger events/x=
en/xen_mmu_release_ptpage/trigger events/xen/xen_mmu_set_p4d/trigger events=
/xen/xen_mmu_set_pmd/trigger events/xen/xen_mmu_set_pte/trigger events/xen/=
xen_mmu_set_pud/trigger events/xen/xen_mmu_write_cr3/trigger events/xhci-hc=
d/xhci_add_endpoint/trigger events/xhci-hcd/xhci_address_ctrl_ctx/trigger e=
vents/xhci-hcd/xhci_address_ctx/trigger events/xhci-hcd/xhci_alloc_dev/trig=
ger events/xhci-hcd/xhci_alloc_stream_info_ctx/trigger events/xhci-hcd/xhci=
_alloc_virt_device/trigger events/xhci-hcd/xhci_configure_endpoint/trigger =
events/xhci-hcd/xhci_configure_endpoint_ctrl_ctx/trigger events/xhci-hcd/xh=
ci_dbc_alloc_request/trigger events/xhci-hcd/xhci_dbc_free_request/trigger =
events/xhci-hcd/xhci_dbc_gadget_ep_queue/trigger events/xhci-hcd/xhci_dbc_g=
iveback_request/trigger events/xhci-hcd/xhci_dbc_handle_event/trigger event=
s/xhci-hcd/xhci_dbc_handle_transfer/trigger events/xhci-hcd/xhci_dbc_queue_=
request/trigger events/xhci-hcd/xhci_dbg_address/trigger events/xhci-hcd/xh=
ci_dbg_cancel_urb/trigger events/xhci-hcd/xhci_dbg_context_change/trigger e=
vents/xhci-hcd/xhci_dbg_init/trigger events/xhci-hcd/xhci_dbg_quirks/trigge=
r events/xhci-hcd/xhci_dbg_reset_ep/trigger events/xhci-hcd/xhci_dbg_ring_e=
xpansion/trigger events/xhci-hcd/xhci_discover_or_reset_device/trigger even=
ts/xhci-hcd/xhci_free_dev/trigger events/xhci-hcd/xhci_free_virt_device/tri=
gger events/xhci-hcd/xhci_get_port_status/trigger events/xhci-hcd/xhci_hand=
le_cmd_addr_dev/trigger events/xhci-hcd/xhci_handle_cmd_config_ep/trigger e=
vents/xhci-hcd/xhci_handle_cmd_disable_slot/trigger events/xhci-hcd/xhci_ha=
ndle_cmd_reset_dev/trigger events/xhci-hcd/xhci_handle_cmd_reset_ep/trigger=
 events/xhci-hcd/xhci_handle_cmd_set_deq/trigger events/xhci-hcd/xhci_handl=
e_cmd_set_deq_ep/trigger events/xhci-hcd/xhci_handle_cmd_set_deq_stream/tri=
gger events/xhci-hcd/xhci_handle_cmd_stop_ep/trigger events/xhci-hcd/xhci_h=
andle_command/trigger events/xhci-hcd/xhci_handle_event/trigger events/xhci=
-hcd/xhci_handle_port_status/trigger events/xhci-hcd/xhci_handle_transfer/t=
rigger events/xhci-hcd/xhci_hub_status_data/trigger events/xhci-hcd/xhci_in=
c_deq/trigger events/xhci-hcd/xhci_inc_enq/trigger events/xhci-hcd/xhci_por=
tsc_writel/trigger events/xhci-hcd/xhci_queue_trb/trigger events/xhci-hcd/x=
hci_ring_alloc/trigger events/xhci-hcd/xhci_ring_ep_doorbell/trigger events=
/xhci-hcd/xhci_ring_expansion/trigger events/xhci-hcd/xhci_ring_free/trigge=
r events/xhci-hcd/xhci_ring_host_doorbell/trigger events/xhci-hcd/xhci_setu=
p_addressable_virt_device/trigger events/xhci-hcd/xhci_setup_device/trigger=
 events/xhci-hcd/xhci_setup_device_slot/trigger events/xhci-hcd/xhci_stop_d=
evice/trigger events/xhci-hcd/xhci_urb_dequeue/trigger events/xhci-hcd/xhci=
_urb_enqueue/trigger events/xhci-hcd/xhci_urb_giveback/trigger
# # + read line
# # + grep -Hv '^#' events/9p/9p_client_req/trigger events/9p/9p_client_res=
/trigger events/9p/9p_fid_ref/trigger events/9p/9p_protocol_dump/trigger ev=
ents/alarmtimer/alarmtimer_cancel/trigger events/alarmtimer/alarmtimer_fire=
d/trigger events/alarmtimer/alarmtimer_start/trigger events/alarmtimer/alar=
mtimer_suspend/trigger events/amd_cpu/amd_pstate_cppc_req2/trigger events/a=
md_cpu/amd_pstate_epp_perf/trigger events/amd_cpu/amd_pstate_perf/trigger e=
vents/asoc/snd_soc_bias_level_done/trigger events/asoc/snd_soc_bias_level_s=
tart/trigger events/asoc/snd_soc_dapm_connected/trigger events/asoc/snd_soc=
_dapm_done/trigger events/asoc/snd_soc_dapm_path/trigger events/asoc/snd_so=
c_dapm_start/trigger events/asoc/snd_soc_dapm_walk_done/trigger events/asoc=
/snd_soc_dapm_widget_event_done/trigger events/asoc/snd_soc_dapm_widget_eve=
nt_start/trigger events/asoc/snd_soc_dapm_widget_power/trigger events/asoc/=
snd_soc_jack_irq/trigger events/asoc/snd_soc_jack_notify/trigger events/aso=
c/snd_soc_jack_report/trigger events/avc/selinux_audited/trigger events/blo=
ck/blk_zone_append_update_request_bio/trigger events/block/blk_zone_wplug_b=
io/trigger events/block/blkdev_zone_mgmt/trigger events/block/block_bio_bac=
kmerge/trigger events/block/block_bio_complete/trigger events/block/block_b=
io_frontmerge/trigger events/block/block_bio_queue/trigger events/block/blo=
ck_bio_remap/trigger events/block/block_dirty_buffer/trigger events/block/b=
lock_getrq/trigger events/block/block_io_done/trigger events/block/block_io=
_start/trigger events/block/block_plug/trigger events/block/block_rq_comple=
te/trigger events/block/block_rq_error/trigger events/block/block_rq_insert=
/trigger events/block/block_rq_issue/trigger events/block/block_rq_merge/tr=
igger events/block/block_rq_remap/trigger events/block/block_rq_requeue/tri=
gger events/block/block_rq_tag_wait/trigger events/block/block_split/trigge=
r events/block/block_touch_buffer/trigger events/block/block_unplug/trigger=
 events/block/disk_zone_wplug_add_bio/trigger events/bpf_test_run/bpf_test_=
finish/trigger events/bpf_test_run/bpf_trigger_tp/trigger events/bpf_trace/=
bpf_trace_printk/trigger events/bridge/br_fdb_add/trigger events/bridge/br_=
fdb_external_learn_add/trigger events/bridge/br_fdb_update/trigger events/b=
ridge/br_mdb_full/trigger events/bridge/fdb_delete/trigger events/btrfs/add=
_delayed_data_ref/trigger events/btrfs/add_delayed_ref_head/trigger events/=
btrfs/add_delayed_tree_ref/trigger events/btrfs/btrfs_add_block_group/trigg=
er events/btrfs/btrfs_add_conflicting_inode_enter/trigger events/btrfs/btrf=
s_add_conflicting_inode_exit/trigger events/btrfs/btrfs_add_reclaim_block_g=
roup/trigger events/btrfs/btrfs_add_unused_block_group/trigger events/btrfs=
/btrfs_all_work_done/trigger events/btrfs/btrfs_alloc_extent_state/trigger =
events/btrfs/btrfs_chunk_alloc/trigger events/btrfs/btrfs_chunk_free/trigge=
r events/btrfs/btrfs_clear_extent_bit/trigger events/btrfs/btrfs_convert_ex=
tent_bit/trigger events/btrfs/btrfs_cow_block/trigger events/btrfs/btrfs_do=
ne_preemptive_reclaim/trigger events/btrfs/btrfs_extent_map_shrinker_count/=
trigger events/btrfs/btrfs_extent_map_shrinker_remove_em/trigger events/btr=
fs/btrfs_extent_map_shrinker_scan_enter/trigger events/btrfs/btrfs_extent_m=
ap_shrinker_scan_exit/trigger events/btrfs/btrfs_fail_all_tickets/trigger e=
vents/btrfs/btrfs_failed_cluster_setup/trigger events/btrfs/btrfs_find_clus=
ter/trigger events/btrfs/btrfs_find_free_extent/trigger events/btrfs/btrfs_=
find_free_extent_have_block_group/trigger events/btrfs/btrfs_find_free_exte=
nt_search_loop/trigger events/btrfs/btrfs_finish_ordered_extent/trigger eve=
nts/btrfs/btrfs_flush_space/trigger events/btrfs/btrfs_free_extent_state/tr=
igger events/btrfs/btrfs_get_extent/trigger events/btrfs/btrfs_get_extent_s=
how_fi_inline/trigger events/btrfs/btrfs_get_extent_show_fi_regular/trigger=
 events/btrfs/btrfs_get_raid_extent_offset/trigger events/btrfs/btrfs_handl=
e_em_exist/trigger events/btrfs/btrfs_inode_evict/trigger events/btrfs/btrf=
s_inode_mod_outstanding_extents/trigger events/btrfs/btrfs_inode_new/trigge=
r events/btrfs/btrfs_inode_request/trigger events/btrfs/btrfs_insert_one_ra=
id_extent/trigger events/btrfs/btrfs_log_all_new_ancestors_enter/trigger ev=
ents/btrfs/btrfs_log_all_new_ancestors_exit/trigger events/btrfs/btrfs_log_=
all_parents_enter/trigger events/btrfs/btrfs_log_all_parents_exit/trigger e=
vents/btrfs/btrfs_log_conflicting_inodes_enter/trigger events/btrfs/btrfs_l=
og_conflicting_inodes_exit/trigger events/btrfs/btrfs_log_inode_enter/trigg=
er events/btrfs/btrfs_log_inode_exit/trigger events/btrfs/btrfs_log_inode_p=
arent_enter/trigger events/btrfs/btrfs_log_inode_parent_exit/trigger events=
/btrfs/btrfs_log_new_delayed_dentries_enter/trigger events/btrfs/btrfs_log_=
new_delayed_dentries_exit/trigger events/btrfs/btrfs_log_new_dir_dentries_e=
nter/trigger events/btrfs/btrfs_log_new_dir_dentries_exit/trigger events/bt=
rfs/btrfs_log_new_name_enter/trigger events/btrfs/btrfs_log_new_name_exit/t=
rigger events/btrfs/btrfs_ordered_extent_add/trigger events/btrfs/btrfs_ord=
ered_extent_dec_test_pending/trigger events/btrfs/btrfs_ordered_extent_look=
up/trigger events/btrfs/btrfs_ordered_extent_lookup_first/trigger events/bt=
rfs/btrfs_ordered_extent_lookup_first_range/trigger events/btrfs/btrfs_orde=
red_extent_lookup_for_logging/trigger events/btrfs/btrfs_ordered_extent_loo=
kup_range/trigger events/btrfs/btrfs_ordered_extent_mark_finished/trigger e=
vents/btrfs/btrfs_ordered_extent_put/trigger events/btrfs/btrfs_ordered_ext=
ent_remove/trigger events/btrfs/btrfs_ordered_extent_split/trigger events/b=
trfs/btrfs_ordered_extent_start/trigger events/btrfs/btrfs_ordered_sched/tr=
igger events/btrfs/btrfs_prelim_ref_insert/trigger events/btrfs/btrfs_preli=
m_ref_merge/trigger events/btrfs/btrfs_qgroup_account_extent/trigger events=
/btrfs/btrfs_qgroup_account_extents/trigger events/btrfs/btrfs_qgroup_meta_=
convert/trigger events/btrfs/btrfs_qgroup_meta_free_all_pertrans/trigger ev=
ents/btrfs/btrfs_qgroup_meta_reserve/trigger events/btrfs/btrfs_qgroup_num_=
dirty_extents/trigger events/btrfs/btrfs_qgroup_release_data/trigger events=
/btrfs/btrfs_qgroup_reserve_data/trigger events/btrfs/btrfs_qgroup_trace_ex=
tent/trigger events/btrfs/btrfs_qgroup_update_counters/trigger events/btrfs=
/btrfs_qgroup_update_reserve/trigger events/btrfs/btrfs_raid_extent_delete/=
trigger events/btrfs/btrfs_reclaim_block_group/trigger events/btrfs/btrfs_r=
ecord_new_subvolume/trigger events/btrfs/btrfs_record_snapshot_destroy/trig=
ger events/btrfs/btrfs_record_unlink_dir/trigger events/btrfs/btrfs_remove_=
block_group/trigger events/btrfs/btrfs_reserve_extent/trigger events/btrfs/=
btrfs_reserve_extent_cluster/trigger events/btrfs/btrfs_reserve_ticket/trig=
ger events/btrfs/btrfs_reserved_extent_alloc/trigger events/btrfs/btrfs_res=
erved_extent_free/trigger events/btrfs/btrfs_search_slot_restart/trigger ev=
ents/btrfs/btrfs_set_extent_bit/trigger events/btrfs/btrfs_setup_cluster/tr=
igger events/btrfs/btrfs_skip_unused_block_group/trigger events/btrfs/btrfs=
_space_reservation/trigger events/btrfs/btrfs_sync_file_enter/trigger event=
s/btrfs/btrfs_sync_file_exit/trigger events/btrfs/btrfs_sync_fs/trigger eve=
nts/btrfs/btrfs_sync_log_enter/trigger events/btrfs/btrfs_sync_log_exit/tri=
gger events/btrfs/btrfs_transaction_abort/trigger events/btrfs/btrfs_transa=
ction_commit/trigger events/btrfs/btrfs_transaction_start/trigger events/bt=
rfs/btrfs_tree_lock/trigger events/btrfs/btrfs_tree_read_lock/trigger event=
s/btrfs/btrfs_tree_read_unlock/trigger events/btrfs/btrfs_tree_unlock/trigg=
er events/btrfs/btrfs_trigger_flush/trigger events/btrfs/btrfs_truncate_sho=
w_fi_inline/trigger events/btrfs/btrfs_truncate_show_fi_regular/trigger eve=
nts/btrfs/btrfs_try_tree_read_lock/trigger events/btrfs/btrfs_work_queued/t=
rigger events/btrfs/btrfs_work_sched/trigger events/btrfs/btrfs_workqueue_a=
lloc/trigger events/btrfs/btrfs_workqueue_destroy/trigger events/btrfs/btrf=
s_writepage_end_io_hook/trigger events/btrfs/extent_writepage/trigger event=
s/btrfs/raid56_read/trigger events/btrfs/raid56_write/trigger events/btrfs/=
run_delayed_data_ref/trigger events/btrfs/run_delayed_ref_head/trigger even=
ts/btrfs/run_delayed_tree_ref/trigger events/btrfs/update_bytes_may_use/tri=
gger events/btrfs/update_bytes_pinned/trigger events/btrfs/update_bytes_zon=
e_unusable/trigger events/capability/cap_capable/trigger events/cfg80211/cf=
g80211_assoc_comeback/trigger events/cfg80211/cfg80211_bss_color_notify/tri=
gger events/cfg80211/cfg80211_cac_event/trigger events/cfg80211/cfg80211_ch=
_switch_notify/trigger events/cfg80211/cfg80211_ch_switch_started_notify/tr=
igger events/cfg80211/cfg80211_control_port_tx_status/trigger events/cfg802=
11/cfg80211_cqm_pktloss_notify/trigger events/cfg80211/cfg80211_cqm_rssi_no=
tify/trigger events/cfg80211/cfg80211_del_sta/trigger events/cfg80211/cfg80=
211_epcs_changed/trigger events/cfg80211/cfg80211_ft_event/trigger events/c=
fg80211/cfg80211_get_bss/trigger events/cfg80211/cfg80211_gtk_rekey_notify/=
trigger events/cfg80211/cfg80211_ibss_joined/trigger events/cfg80211/cfg802=
11_incumbent_signal_notify/trigger events/cfg80211/cfg80211_inform_bss_fram=
e/trigger events/cfg80211/cfg80211_links_removed/trigger events/cfg80211/cf=
g80211_mgmt_tx_status/trigger events/cfg80211/cfg80211_michael_mic_failure/=
trigger events/cfg80211/cfg80211_mlo_reconf_add_done/trigger events/cfg8021=
1/cfg80211_nan_channel_evac/trigger events/cfg80211/cfg80211_nan_cluster_jo=
ined/trigger events/cfg80211/cfg80211_nan_sched_update_done/trigger events/=
cfg80211/cfg80211_nan_ulw_update/trigger events/cfg80211/cfg80211_new_sta/t=
rigger events/cfg80211/cfg80211_next_nan_dw_notif/trigger events/cfg80211/c=
fg80211_notify_new_peer_candidate/trigger events/cfg80211/cfg80211_pmksa_ca=
ndidate_notify/trigger events/cfg80211/cfg80211_pmsr_complete/trigger event=
s/cfg80211/cfg80211_pmsr_report/trigger events/cfg80211/cfg80211_probe_stat=
us/trigger events/cfg80211/cfg80211_radar_event/trigger events/cfg80211/cfg=
80211_ready_on_channel/trigger events/cfg80211/cfg80211_ready_on_channel_ex=
pired/trigger events/cfg80211/cfg80211_reg_can_beacon/trigger events/cfg802=
11/cfg80211_report_obss_beacon/trigger events/cfg80211/cfg80211_report_wowl=
an_wakeup/trigger events/cfg80211/cfg80211_return_bool/trigger events/cfg80=
211/cfg80211_return_bss/trigger events/cfg80211/cfg80211_rx_control_port/tr=
igger events/cfg80211/cfg80211_rx_mgmt/trigger events/cfg80211/cfg80211_rx_=
mlme_mgmt/trigger events/cfg80211/cfg80211_rx_spurious_frame/trigger events=
/cfg80211/cfg80211_rx_unexpected_4addr_frame/trigger events/cfg80211/cfg802=
11_rx_unprot_mlme_mgmt/trigger events/cfg80211/cfg80211_scan_done/trigger e=
vents/cfg80211/cfg80211_sched_scan_results/trigger events/cfg80211/cfg80211=
_sched_scan_stopped/trigger events/cfg80211/cfg80211_send_assoc_failure/tri=
gger events/cfg80211/cfg80211_send_auth_timeout/trigger events/cfg80211/cfg=
80211_send_rx_assoc/trigger events/cfg80211/cfg80211_stop_link/trigger even=
ts/cfg80211/cfg80211_tdls_oper_request/trigger events/cfg80211/cfg80211_tx_=
mgmt_expired/trigger events/cfg80211/cfg80211_tx_mlme_mgmt/trigger events/c=
fg80211/cfg80211_update_owe_info_event/trigger events/cfg80211/rdev_abort_p=
msr/trigger events/cfg80211/rdev_abort_scan/trigger events/cfg80211/rdev_ad=
d_intf_link/trigger events/cfg80211/rdev_add_key/trigger events/cfg80211/rd=
ev_add_link_station/trigger events/cfg80211/rdev_add_mpath/trigger events/c=
fg80211/rdev_add_nan_func/trigger events/cfg80211/rdev_add_station/trigger =
events/cfg80211/rdev_add_tx_ts/trigger events/cfg80211/rdev_add_virtual_int=
f/trigger events/cfg80211/rdev_assoc/trigger events/cfg80211/rdev_assoc_ml_=
reconf/trigger events/cfg80211/rdev_auth/trigger events/cfg80211/rdev_cance=
l_remain_on_channel/trigger events/cfg80211/rdev_change_beacon/trigger even=
ts/cfg80211/rdev_change_bss/trigger events/cfg80211/rdev_change_mpath/trigg=
er events/cfg80211/rdev_change_station/trigger events/cfg80211/rdev_change_=
virtual_intf/trigger events/cfg80211/rdev_channel_switch/trigger events/cfg=
80211/rdev_color_change/trigger events/cfg80211/rdev_connect/trigger events=
/cfg80211/rdev_crit_proto_start/trigger events/cfg80211/rdev_crit_proto_sto=
p/trigger events/cfg80211/rdev_deauth/trigger events/cfg80211/rdev_del_intf=
_link/trigger events/cfg80211/rdev_del_key/trigger events/cfg80211/rdev_del=
_link_station/trigger events/cfg80211/rdev_del_mpath/trigger events/cfg8021=
1/rdev_del_nan_func/trigger events/cfg80211/rdev_del_pmk/trigger events/cfg=
80211/rdev_del_pmksa/trigger events/cfg80211/rdev_del_station/trigger event=
s/cfg80211/rdev_del_tx_ts/trigger events/cfg80211/rdev_del_virtual_intf/tri=
gger events/cfg80211/rdev_disassoc/trigger events/cfg80211/rdev_disconnect/=
trigger events/cfg80211/rdev_dump_mpath/trigger events/cfg80211/rdev_dump_m=
pp/trigger events/cfg80211/rdev_dump_station/trigger events/cfg80211/rdev_d=
ump_survey/trigger events/cfg80211/rdev_end_cac/trigger events/cfg80211/rde=
v_external_auth/trigger events/cfg80211/rdev_flush_pmksa/trigger events/cfg=
80211/rdev_get_antenna/trigger events/cfg80211/rdev_get_channel/trigger eve=
nts/cfg80211/rdev_get_ftm_responder_stats/trigger events/cfg80211/rdev_get_=
key/trigger events/cfg80211/rdev_get_mesh_config/trigger events/cfg80211/rd=
ev_get_mpath/trigger events/cfg80211/rdev_get_mpp/trigger events/cfg80211/r=
dev_get_station/trigger events/cfg80211/rdev_get_tx_power/trigger events/cf=
g80211/rdev_get_txq_stats/trigger events/cfg80211/rdev_inform_bss/trigger e=
vents/cfg80211/rdev_join_ibss/trigger events/cfg80211/rdev_join_mesh/trigge=
r events/cfg80211/rdev_join_ocb/trigger events/cfg80211/rdev_leave_ibss/tri=
gger events/cfg80211/rdev_leave_mesh/trigger events/cfg80211/rdev_leave_ocb=
/trigger events/cfg80211/rdev_libertas_set_mesh_channel/trigger events/cfg8=
0211/rdev_mgmt_tx/trigger events/cfg80211/rdev_mgmt_tx_cancel_wait/trigger =
events/cfg80211/rdev_mod_link_station/trigger events/cfg80211/rdev_nan_chan=
ge_conf/trigger events/cfg80211/rdev_nan_set_local_sched/trigger events/cfg=
80211/rdev_nan_set_peer_sched/trigger events/cfg80211/rdev_probe_client/tri=
gger events/cfg80211/rdev_probe_mesh_link/trigger events/cfg80211/rdev_rema=
in_on_channel/trigger events/cfg80211/rdev_reset_tid_config/trigger events/=
cfg80211/rdev_resume/trigger events/cfg80211/rdev_return_chandef/trigger ev=
ents/cfg80211/rdev_return_int/trigger events/cfg80211/rdev_return_int_cooki=
e/trigger events/cfg80211/rdev_return_int_int/trigger events/cfg80211/rdev_=
return_int_mesh_config/trigger events/cfg80211/rdev_return_int_mpath_info/t=
rigger events/cfg80211/rdev_return_int_station_info/trigger events/cfg80211=
/rdev_return_int_survey_info/trigger events/cfg80211/rdev_return_int_tx_rx/=
trigger events/cfg80211/rdev_return_void/trigger events/cfg80211/rdev_retur=
n_void_tx_rx/trigger events/cfg80211/rdev_return_wdev/trigger events/cfg802=
11/rdev_rfkill_poll/trigger events/cfg80211/rdev_scan/trigger events/cfg802=
11/rdev_sched_scan_start/trigger events/cfg80211/rdev_sched_scan_stop/trigg=
er events/cfg80211/rdev_set_antenna/trigger events/cfg80211/rdev_set_ap_cha=
nwidth/trigger events/cfg80211/rdev_set_bitrate_mask/trigger events/cfg8021=
1/rdev_set_coalesce/trigger events/cfg80211/rdev_set_cqm_rssi_config/trigge=
r events/cfg80211/rdev_set_cqm_rssi_range_config/trigger events/cfg80211/rd=
ev_set_cqm_txe_config/trigger events/cfg80211/rdev_set_default_beacon_key/t=
rigger events/cfg80211/rdev_set_default_key/trigger events/cfg80211/rdev_se=
t_default_mgmt_key/trigger events/cfg80211/rdev_set_epcs/trigger events/cfg=
80211/rdev_set_fils_aad/trigger events/cfg80211/rdev_set_hw_timestamp/trigg=
er events/cfg80211/rdev_set_mac_acl/trigger events/cfg80211/rdev_set_mcast_=
rate/trigger events/cfg80211/rdev_set_monitor_channel/trigger events/cfg802=
11/rdev_set_multicast_to_unicast/trigger events/cfg80211/rdev_set_noack_map=
/trigger events/cfg80211/rdev_set_pmk/trigger events/cfg80211/rdev_set_pmks=
a/trigger events/cfg80211/rdev_set_power_mgmt/trigger events/cfg80211/rdev_=
set_qos_map/trigger events/cfg80211/rdev_set_radar_background/trigger event=
s/cfg80211/rdev_set_rekey_data/trigger events/cfg80211/rdev_set_sar_specs/t=
rigger events/cfg80211/rdev_set_tid_config/trigger events/cfg80211/rdev_set=
_ttlm/trigger events/cfg80211/rdev_set_tx_power/trigger events/cfg80211/rde=
v_set_txq_params/trigger events/cfg80211/rdev_set_wakeup/trigger events/cfg=
80211/rdev_set_wiphy_params/trigger events/cfg80211/rdev_start_ap/trigger e=
vents/cfg80211/rdev_start_nan/trigger events/cfg80211/rdev_start_p2p_device=
/trigger events/cfg80211/rdev_start_pd/trigger events/cfg80211/rdev_start_p=
msr/trigger events/cfg80211/rdev_start_radar_detection/trigger events/cfg80=
211/rdev_stop_ap/trigger events/cfg80211/rdev_stop_nan/trigger events/cfg80=
211/rdev_stop_p2p_device/trigger events/cfg80211/rdev_stop_pd/trigger event=
s/cfg80211/rdev_suspend/trigger events/cfg80211/rdev_tdls_cancel_channel_sw=
itch/trigger events/cfg80211/rdev_tdls_channel_switch/trigger events/cfg802=
11/rdev_tdls_mgmt/trigger events/cfg80211/rdev_tdls_oper/trigger events/cfg=
80211/rdev_tx_control_port/trigger events/cfg80211/rdev_update_connect_para=
ms/trigger events/cfg80211/rdev_update_ft_ies/trigger events/cfg80211/rdev_=
update_mesh_config/trigger events/cfg80211/rdev_update_mgmt_frame_registrat=
ions/trigger events/cfg80211/rdev_update_owe_info/trigger events/cfg80211/w=
iphy_delayed_work_queue/trigger events/cfg80211/wiphy_hrtimer_work_queue/tr=
igger events/cfg80211/wiphy_work_cancel/trigger events/cfg80211/wiphy_work_=
flush/trigger events/cfg80211/wiphy_work_queue/trigger events/cfg80211/wiph=
y_work_run/trigger events/cfg80211/wiphy_work_worker_start/trigger events/c=
group/cgroup_attach_task/trigger events/cgroup/cgroup_destroy_root/trigger =
events/cgroup/cgroup_freeze/trigger events/cgroup/cgroup_mkdir/trigger even=
ts/cgroup/cgroup_notify_frozen/trigger events/cgroup/cgroup_notify_populate=
d/trigger events/cgroup/cgroup_release/trigger events/cgroup/cgroup_remount=
/trigger events/cgroup/cgroup_rename/trigger events/cgroup/cgroup_rmdir/tri=
gger events/cgroup/cgroup_rstat_lock_contended/trigger events/cgroup/cgroup=
_rstat_locked/trigger events/cgroup/cgroup_rstat_unlock/trigger events/cgro=
up/cgroup_setup_root/trigger events/cgroup/cgroup_transfer_tasks/trigger ev=
ents/cgroup/cgroup_unfreeze/trigger events/clk/clk_disable/trigger events/c=
lk/clk_disable_complete/trigger events/clk/clk_enable/trigger events/clk/cl=
k_enable_complete/trigger events/clk/clk_prepare/trigger events/clk/clk_pre=
pare_complete/trigger events/clk/clk_rate_request_done/trigger events/clk/c=
lk_rate_request_start/trigger events/clk/clk_set_duty_cycle/trigger events/=
clk/clk_set_duty_cycle_complete/trigger events/clk/clk_set_max_rate/trigger=
 events/clk/clk_set_min_rate/trigger events/clk/clk_set_parent/trigger even=
ts/clk/clk_set_parent_complete/trigger events/clk/clk_set_phase/trigger eve=
nts/clk/clk_set_phase_complete/trigger events/clk/clk_set_rate/trigger even=
ts/clk/clk_set_rate_complete/trigger events/clk/clk_set_rate_range/trigger =
events/clk/clk_unprepare/trigger events/clk/clk_unprepare_complete/trigger =
events/cma/cma_alloc_busy_retry/trigger events/cma/cma_alloc_finish/trigger=
 events/cma/cma_alloc_start/trigger events/cma/cma_release/trigger events/c=
ompaction/mm_compaction_begin/trigger events/compaction/mm_compaction_defer=
_compaction/trigger events/compaction/mm_compaction_defer_reset/trigger eve=
nts/compaction/mm_compaction_deferred/trigger events/compaction/mm_compacti=
on_end/trigger events/compaction/mm_compaction_fast_isolate_freepages/trigg=
er events/compaction/mm_compaction_finished/trigger events/compaction/mm_co=
mpaction_isolate_freepages/trigger events/compaction/mm_compaction_isolate_=
migratepages/trigger events/compaction/mm_compaction_kcompactd_sleep/trigge=
r events/compaction/mm_compaction_kcompactd_wake/trigger events/compaction/=
mm_compaction_migratepages/trigger events/compaction/mm_compaction_suitable=
/trigger events/compaction/mm_compaction_try_to_compact_pages/trigger event=
s/compaction/mm_compaction_wakeup_kcompactd/trigger events/context_tracking=
/user_enter/trigger events/context_tracking/user_exit/trigger events/coredu=
mp/coredump/trigger events/cpuhp/cpuhp_enter/trigger events/cpuhp/cpuhp_exi=
t/trigger events/cpuhp/cpuhp_multi_enter/trigger events/csd/csd_function_en=
try/trigger events/csd/csd_function_exit/trigger events/csd/csd_queue_cpu/t=
rigger events/damon/damon_aggregated/trigger events/damon/damon_monitor_int=
ervals_tune/trigger events/damon/damon_region_aggregated/trigger events/dam=
on/damos_before_apply/trigger events/damon/damos_esz/trigger events/damon/d=
amos_stat_after_apply_interval/trigger events/dev/devres_log/trigger events=
/devlink/devlink_health_recover_aborted/trigger events/devlink/devlink_heal=
th_report/trigger events/devlink/devlink_health_reporter_state_update/trigg=
er events/devlink/devlink_hwerr/trigger events/devlink/devlink_hwmsg/trigge=
r events/devlink/devlink_trap_report/trigger events/dma/dma_alloc/trigger e=
vents/dma/dma_alloc_pages/trigger events/dma/dma_alloc_sgt/trigger events/d=
ma/dma_alloc_sgt_err/trigger events/dma/dma_free/trigger events/dma/dma_fre=
e_pages/trigger events/dma/dma_free_sgt/trigger events/dma/dma_map_phys/tri=
gger events/dma/dma_map_sg/trigger events/dma/dma_map_sg_err/trigger events=
/dma/dma_sync_sg_for_cpu/trigger events/dma/dma_sync_sg_for_device/trigger =
events/dma/dma_sync_single_for_cpu/trigger events/dma/dma_sync_single_for_d=
evice/trigger events/dma/dma_unmap_phys/trigger events/dma/dma_unmap_sg/tri=
gger events/dma_buf/dma_buf_detach/trigger events/dma_buf/dma_buf_dynamic_a=
ttach/trigger events/dma_buf/dma_buf_export/trigger events/dma_buf/dma_buf_=
fd/trigger events/dma_buf/dma_buf_get/trigger events/dma_buf/dma_buf_mmap/t=
rigger events/dma_buf/dma_buf_mmap_internal/trigger events/dma_buf/dma_buf_=
put/trigger events/dma_fence/dma_fence_destroy/trigger events/dma_fence/dma=
_fence_emit/trigger events/dma_fence/dma_fence_enable_signal/trigger events=
/dma_fence/dma_fence_init/trigger events/dma_fence/dma_fence_signaled/trigg=
er events/dma_fence/dma_fence_wait_end/trigger events/dma_fence/dma_fence_w=
ait_start/trigger events/drm/drm_vblank_event/trigger events/drm/drm_vblank=
_event_delivered/trigger events/drm/drm_vblank_event_queued/trigger events/=
e1000e_trace/e1000e_trace_mac_register/trigger events/error_report/error_re=
port_end/trigger events/exceptions/page_fault_kernel/trigger events/excepti=
ons/page_fault_user/trigger events/ext4/ext4_alloc_da_blocks/trigger events=
/ext4/ext4_allocate_blocks/trigger events/ext4/ext4_allocate_inode/trigger =
events/ext4/ext4_begin_ordered_truncate/trigger events/ext4/ext4_collapse_r=
ange/trigger events/ext4/ext4_da_release_space/trigger events/ext4/ext4_da_=
reserve_space/trigger events/ext4/ext4_da_update_reserve_space/trigger even=
ts/ext4/ext4_da_write_begin/trigger events/ext4/ext4_da_write_end/trigger e=
vents/ext4/ext4_da_write_folios_end/trigger events/ext4/ext4_da_write_folio=
s_start/trigger events/ext4/ext4_da_write_pages_extent/trigger events/ext4/=
ext4_discard_blocks/trigger events/ext4/ext4_discard_preallocations/trigger=
 events/ext4/ext4_drop_inode/trigger events/ext4/ext4_error/trigger events/=
ext4/ext4_es_cache_extent/trigger events/ext4/ext4_es_find_extent_range_ent=
er/trigger events/ext4/ext4_es_find_extent_range_exit/trigger events/ext4/e=
xt4_es_insert_delayed_extent/trigger events/ext4/ext4_es_insert_extent/trig=
ger events/ext4/ext4_es_lookup_extent_enter/trigger events/ext4/ext4_es_loo=
kup_extent_exit/trigger events/ext4/ext4_es_remove_extent/trigger events/ex=
t4/ext4_es_shrink/trigger events/ext4/ext4_es_shrink_count/trigger events/e=
xt4/ext4_es_shrink_scan_enter/trigger events/ext4/ext4_es_shrink_scan_exit/=
trigger events/ext4/ext4_evict_inode/trigger events/ext4/ext4_ext_convert_t=
o_initialized_enter/trigger events/ext4/ext4_ext_convert_to_initialized_fas=
tpath/trigger events/ext4/ext4_ext_handle_unwritten_extents/trigger events/=
ext4/ext4_ext_load_extent/trigger events/ext4/ext4_ext_map_blocks_enter/tri=
gger events/ext4/ext4_ext_map_blocks_exit/trigger events/ext4/ext4_ext_remo=
ve_space/trigger events/ext4/ext4_ext_remove_space_done/trigger events/ext4=
/ext4_ext_rm_idx/trigger events/ext4/ext4_ext_rm_leaf/trigger events/ext4/e=
xt4_ext_show_extent/trigger events/ext4/ext4_fallocate_enter/trigger events=
/ext4/ext4_fallocate_exit/trigger events/ext4/ext4_fc_cleanup/trigger event=
s/ext4/ext4_fc_commit_start/trigger events/ext4/ext4_fc_commit_stop/trigger=
 events/ext4/ext4_fc_lock_updates/trigger events/ext4/ext4_fc_replay/trigge=
r events/ext4/ext4_fc_replay_scan/trigger events/ext4/ext4_fc_stats/trigger=
 events/ext4/ext4_fc_track_create/trigger events/ext4/ext4_fc_track_inode/t=
rigger events/ext4/ext4_fc_track_link/trigger events/ext4/ext4_fc_track_ran=
ge/trigger events/ext4/ext4_fc_track_unlink/trigger events/ext4/ext4_forget=
/trigger events/ext4/ext4_free_blocks/trigger events/ext4/ext4_free_inode/t=
rigger events/ext4/ext4_fsmap_high_key/trigger events/ext4/ext4_fsmap_low_k=
ey/trigger events/ext4/ext4_fsmap_mapping/trigger events/ext4/ext4_get_impl=
ied_cluster_alloc_exit/trigger events/ext4/ext4_getfsmap_high_key/trigger e=
vents/ext4/ext4_getfsmap_low_key/trigger events/ext4/ext4_getfsmap_mapping/=
trigger events/ext4/ext4_ind_map_blocks_enter/trigger events/ext4/ext4_ind_=
map_blocks_exit/trigger events/ext4/ext4_insert_range/trigger events/ext4/e=
xt4_invalidate_folio/trigger events/ext4/ext4_journal_start_inode/trigger e=
vents/ext4/ext4_journal_start_reserved/trigger events/ext4/ext4_journal_sta=
rt_sb/trigger events/ext4/ext4_journalled_invalidate_folio/trigger events/e=
xt4/ext4_journalled_write_end/trigger events/ext4/ext4_lazy_itable_init/tri=
gger events/ext4/ext4_load_inode/trigger events/ext4/ext4_load_inode_bitmap=
/trigger events/ext4/ext4_mark_inode_dirty/trigger events/ext4/ext4_mb_bitm=
ap_load/trigger events/ext4/ext4_mb_buddy_bitmap_load/trigger events/ext4/e=
xt4_mb_discard_preallocations/trigger events/ext4/ext4_mb_new_group_pa/trig=
ger events/ext4/ext4_mb_new_inode_pa/trigger events/ext4/ext4_mb_release_gr=
oup_pa/trigger events/ext4/ext4_mb_release_inode_pa/trigger events/ext4/ext=
4_mballoc_alloc/trigger events/ext4/ext4_mballoc_discard/trigger events/ext=
4/ext4_mballoc_free/trigger events/ext4/ext4_mballoc_prealloc/trigger event=
s/ext4/ext4_move_extent_enter/trigger events/ext4/ext4_move_extent_exit/tri=
gger events/ext4/ext4_nfs_commit_metadata/trigger events/ext4/ext4_other_in=
ode_update_time/trigger events/ext4/ext4_prefetch_bitmaps/trigger events/ex=
t4/ext4_punch_hole/trigger events/ext4/ext4_read_block_bitmap_load/trigger =
events/ext4/ext4_read_folio/trigger events/ext4/ext4_release_folio/trigger =
events/ext4/ext4_remove_blocks/trigger events/ext4/ext4_request_blocks/trig=
ger events/ext4/ext4_request_inode/trigger events/ext4/ext4_shutdown/trigge=
r events/ext4/ext4_sync_file_enter/trigger events/ext4/ext4_sync_file_exit/=
trigger events/ext4/ext4_sync_fs/trigger events/ext4/ext4_trim_all_free/tri=
gger events/ext4/ext4_trim_extent/trigger events/ext4/ext4_truncate_enter/t=
rigger events/ext4/ext4_truncate_exit/trigger events/ext4/ext4_unlink_enter=
/trigger events/ext4/ext4_unlink_exit/trigger events/ext4/ext4_update_sb/tr=
igger events/ext4/ext4_write_begin/trigger events/ext4/ext4_write_end/trigg=
er events/ext4/ext4_writepages/trigger events/ext4/ext4_writepages_result/t=
rigger events/ext4/ext4_zero_range/trigger events/fib/fib_table_lookup/trig=
ger events/fib6/fib6_table_lookup/trigger events/filelock/break_lease/trigg=
er events/filelock/break_lease_block/trigger events/filelock/break_lease_no=
block/trigger events/filelock/break_lease_unblock/trigger events/filelock/f=
cntl_setlk/trigger events/filelock/flock_lock_inode/trigger events/filelock=
/generic_add_lease/trigger events/filelock/generic_delete_lease/trigger eve=
nts/filelock/leases_conflict/trigger events/filelock/locks_get_lock_context=
/trigger events/filelock/locks_remove_posix/trigger events/filelock/posix_l=
ock_inode/trigger events/filelock/time_out_leases/trigger events/filemap/fi=
le_check_and_advance_wb_err/trigger events/filemap/filemap_set_wb_err/trigg=
er events/filemap/mm_filemap_add_to_page_cache/trigger events/filemap/mm_fi=
lemap_delete_from_page_cache/trigger events/filemap/mm_filemap_fault/trigge=
r events/filemap/mm_filemap_get_pages/trigger events/filemap/mm_filemap_map=
_pages/trigger events/fs_dax/dax_insert_pfn_mkwrite/trigger events/fs_dax/d=
ax_insert_pfn_mkwrite_no_entry/trigger events/fs_dax/dax_load_hole/trigger =
events/fs_dax/dax_pmd_fault/trigger events/fs_dax/dax_pmd_fault_done/trigge=
r events/fs_dax/dax_pmd_load_hole/trigger events/fs_dax/dax_pmd_load_hole_f=
allback/trigger events/fs_dax/dax_pte_fault/trigger events/fs_dax/dax_pte_f=
ault_done/trigger events/fs_dax/dax_writeback_one/trigger events/fs_dax/dax=
_writeback_range/trigger events/fs_dax/dax_writeback_range_done/trigger eve=
nts/fscache/fscache_access/trigger events/fscache/fscache_access_cache/trig=
ger events/fscache/fscache_access_volume/trigger events/fscache/fscache_acq=
uire/trigger events/fscache/fscache_active/trigger events/fscache/fscache_c=
ache/trigger events/fscache/fscache_cookie/trigger events/fscache/fscache_i=
nvalidate/trigger events/fscache/fscache_relinquish/trigger events/fscache/=
fscache_resize/trigger events/fscache/fscache_volume/trigger events/fsnotif=
y/fsnotify/trigger events/fsverity/fsverity_enable/trigger events/fsverity/=
fsverity_merkle_hit/trigger events/fsverity/fsverity_tree_done/trigger even=
ts/fsverity/fsverity_verify_data_block/trigger events/fsverity/fsverity_ver=
ify_merkle_block/trigger events/ftrace/print/trigger events/fuse/fuse_reque=
st_end/trigger events/fuse/fuse_request_send/trigger events/fuse/fuse_reque=
st_sent/trigger events/gpio/gpio_direction/trigger events/gpio/gpio_value/t=
rigger events/handshake/handshake_cancel/trigger events/handshake/handshake=
_cancel_busy/trigger events/handshake/handshake_cancel_none/trigger events/=
handshake/handshake_cmd_accept/trigger events/handshake/handshake_cmd_accep=
t_err/trigger events/handshake/handshake_cmd_done/trigger events/handshake/=
handshake_cmd_done_err/trigger events/handshake/handshake_complete/trigger =
events/handshake/handshake_destruct/trigger events/handshake/handshake_noti=
fy_err/trigger events/handshake/handshake_submit/trigger events/handshake/h=
andshake_submit_err/trigger events/handshake/tls_alert_recv/trigger events/=
handshake/tls_alert_send/trigger events/handshake/tls_contenttype/trigger e=
vents/hda/hda_get_response/trigger events/hda/hda_send_cmd/trigger events/h=
da/hda_unsol_event/trigger events/hda/snd_hdac_stream_start/trigger events/=
hda/snd_hdac_stream_stop/trigger events/hda_controller/azx_get_position/tri=
gger events/hda_controller/azx_pcm_close/trigger events/hda_controller/azx_=
pcm_hw_params/trigger events/hda_controller/azx_pcm_open/trigger events/hda=
_controller/azx_pcm_prepare/trigger events/hda_controller/azx_pcm_trigger/t=
rigger events/hda_intel/azx_resume/trigger events/hda_intel/azx_runtime_res=
ume/trigger events/hda_intel/azx_runtime_suspend/trigger events/hda_intel/a=
zx_suspend/trigger events/huge_memory/mm_collapse_huge_page/trigger events/=
huge_memory/mm_collapse_huge_page_isolate/trigger events/huge_memory/mm_col=
lapse_huge_page_swapin/trigger events/huge_memory/mm_khugepaged_collapse_fi=
le/trigger events/huge_memory/mm_khugepaged_scan/trigger events/huge_memory=
/mm_khugepaged_scan_file/trigger events/huge_memory/mm_khugepaged_scan_pmd/=
trigger events/hugetlbfs/hugetlbfs_alloc_inode/trigger events/hugetlbfs/hug=
etlbfs_evict_inode/trigger events/hugetlbfs/hugetlbfs_fallocate/trigger eve=
nts/hugetlbfs/hugetlbfs_free_inode/trigger events/hugetlbfs/hugetlbfs_setat=
tr/trigger events/hwmon/hwmon_attr_show/trigger events/hwmon/hwmon_attr_sho=
w_string/trigger events/hwmon/hwmon_attr_store/trigger events/i2c/i2c_read/=
trigger events/i2c/i2c_reply/trigger events/i2c/i2c_result/trigger events/i=
2c/i2c_write/trigger events/i915/g4x_wm/trigger events/i915/i915_context_cr=
eate/trigger events/i915/i915_context_free/trigger events/i915/i915_gem_evi=
ct/trigger events/i915/i915_gem_evict_node/trigger events/i915/i915_gem_evi=
ct_vm/trigger events/i915/i915_gem_object_clflush/trigger events/i915/i915_=
gem_object_create/trigger events/i915/i915_gem_object_destroy/trigger event=
s/i915/i915_gem_object_fault/trigger events/i915/i915_gem_object_pread/trig=
ger events/i915/i915_gem_object_pwrite/trigger events/i915/i915_gem_shrink/=
trigger events/i915/i915_ppgtt_create/trigger events/i915/i915_ppgtt_releas=
e/trigger events/i915/i915_reg_rw/trigger events/i915/i915_request_add/trig=
ger events/i915/i915_request_queue/trigger events/i915/i915_request_retire/=
trigger events/i915/i915_request_wait_begin/trigger events/i915/i915_reques=
t_wait_end/trigger events/i915/i915_vma_bind/trigger events/i915/i915_vma_u=
nbind/trigger events/i915/intel_cpu_fifo_underrun/trigger events/i915/intel=
_crtc_flip_done/trigger events/i915/intel_crtc_vblank_work_end/trigger even=
ts/i915/intel_crtc_vblank_work_start/trigger events/i915/intel_fbc_activate=
/trigger events/i915/intel_fbc_deactivate/trigger events/i915/intel_fbc_nuk=
e/trigger events/i915/intel_frontbuffer_flush/trigger events/i915/intel_fro=
ntbuffer_invalidate/trigger events/i915/intel_memory_cxsr/trigger events/i9=
15/intel_pch_fifo_underrun/trigger events/i915/intel_pipe_crc/trigger event=
s/i915/intel_pipe_disable/trigger events/i915/intel_pipe_enable/trigger eve=
nts/i915/intel_pipe_scaler_update_arm/trigger events/i915/intel_pipe_update=
_end/trigger events/i915/intel_pipe_update_start/trigger events/i915/intel_=
pipe_update_vblank_evaded/trigger events/i915/intel_plane_async_flip/trigge=
r events/i915/intel_plane_disable_arm/trigger events/i915/intel_plane_scale=
r_update_arm/trigger events/i915/intel_plane_update_arm/trigger events/i915=
/intel_plane_update_noarm/trigger events/i915/intel_scaler_disable_arm/trig=
ger events/i915/vlv_fifo_size/trigger events/i915/vlv_wm/trigger events/ib_=
cma/icm_dreq_skipped/trigger events/ib_cma/icm_dreq_unknown_err/trigger eve=
nts/ib_cma/icm_establish_err/trigger events/ib_cma/icm_handler_err/trigger =
events/ib_cma/icm_insert_failed_err/trigger events/ib_cma/icm_issue_drep/tr=
igger events/ib_cma/icm_issue_rej/trigger events/ib_cma/icm_mad_send_err/tr=
igger events/ib_cma/icm_mra_unknown_err/trigger events/ib_cma/icm_no_listen=
er_err/trigger events/ib_cma/icm_no_priv_err/trigger events/ib_cma/icm_prep=
are_mra_unknown_err/trigger events/ib_cma/icm_qp_init_err/trigger events/ib=
_cma/icm_qp_rtr_err/trigger events/ib_cma/icm_qp_rts_err/trigger events/ib_=
cma/icm_rej_unknown_err/trigger events/ib_cma/icm_remote_no_priv_err/trigge=
r events/ib_cma/icm_rep_unknown_err/trigger events/ib_cma/icm_send_cm_rtu_e=
rr/trigger events/ib_cma/icm_send_drep/trigger events/ib_cma/icm_send_drep_=
err/trigger events/ib_cma/icm_send_dreq/trigger events/ib_cma/icm_send_dup_=
rep/trigger events/ib_cma/icm_send_dup_req/trigger events/ib_cma/icm_send_m=
ra/trigger events/ib_cma/icm_send_rej/trigger events/ib_cma/icm_send_rep/tr=
igger events/ib_cma/icm_send_rep_err/trigger events/ib_cma/icm_send_req/tri=
gger events/ib_cma/icm_send_rtu/trigger events/ib_cma/icm_send_sidr_rep/tri=
gger events/ib_cma/icm_send_sidr_req/trigger events/ib_cma/icm_send_unknown=
_rej_err/trigger events/ib_cma/icm_staleconn_err/trigger events/ib_mad/ib_m=
ad_create_agent/trigger events/ib_mad/ib_mad_error_handler/trigger events/i=
b_mad/ib_mad_handle_ib_smi/trigger events/ib_mad/ib_mad_handle_opa_smi/trig=
ger events/ib_mad/ib_mad_handle_out_ib_smi/trigger events/ib_mad/ib_mad_han=
dle_out_opa_smi/trigger events/ib_mad/ib_mad_ib_send_mad/trigger events/ib_=
mad/ib_mad_recv_done_agent/trigger events/ib_mad/ib_mad_recv_done_handler/t=
rigger events/ib_mad/ib_mad_send_done_agent/trigger events/ib_mad/ib_mad_se=
nd_done_handler/trigger events/ib_mad/ib_mad_send_done_resend/trigger event=
s/ib_mad/ib_mad_unregister_agent/trigger events/icmp/icmp_send/trigger even=
ts/initcall/initcall_finish/trigger events/initcall/initcall_level/trigger =
events/initcall/initcall_start/trigger events/intel_avs/avs_d0ix/trigger ev=
ents/intel_avs/avs_dsp_core_op/trigger events/intel_avs/avs_ipc_msg_payload=
/trigger events/intel_avs/avs_ipc_notify_msg/trigger events/intel_avs/avs_i=
pc_reply_msg/trigger events/intel_avs/avs_ipc_request_msg/trigger events/in=
tel_iommu/cache_tag_assign/trigger events/intel_iommu/cache_tag_flush_range=
/trigger events/intel_iommu/cache_tag_flush_range_np/trigger events/intel_i=
ommu/cache_tag_unassign/trigger events/intel_iommu/prq_report/trigger event=
s/intel_iommu/qi_submit/trigger events/io_uring/io_uring_complete/trigger e=
vents/io_uring/io_uring_cqe_overflow/trigger events/io_uring/io_uring_cqrin=
g_wait/trigger events/io_uring/io_uring_create/trigger events/io_uring/io_u=
ring_defer/trigger events/io_uring/io_uring_fail_link/trigger events/io_uri=
ng/io_uring_file_get/trigger events/io_uring/io_uring_link/trigger events/i=
o_uring/io_uring_local_work_run/trigger events/io_uring/io_uring_poll_arm/t=
rigger events/io_uring/io_uring_queue_async_work/trigger events/io_uring/io=
_uring_register/trigger events/io_uring/io_uring_req_failed/trigger events/=
io_uring/io_uring_short_write/trigger events/io_uring/io_uring_submit_req/t=
rigger events/io_uring/io_uring_task_add/trigger events/io_uring/io_uring_t=
ask_work_run/trigger events/iomap/iomap_add_to_ioend/trigger events/iomap/i=
omap_dio_complete/trigger events/iomap/iomap_dio_invalidate_fail/trigger ev=
ents/iomap/iomap_dio_rw_begin/trigger events/iomap/iomap_dio_rw_queued/trig=
ger events/iomap/iomap_invalidate_folio/trigger events/iomap/iomap_iter/tri=
gger events/iomap/iomap_iter_dstmap/trigger events/iomap/iomap_iter_srcmap/=
trigger events/iomap/iomap_readahead/trigger events/iomap/iomap_readpage/tr=
igger events/iomap/iomap_release_folio/trigger events/iomap/iomap_writeback=
_folio/trigger events/iomap/iomap_zero_iter/trigger events/iommu/add_device=
_to_group/trigger events/iommu/attach_device_to_domain/trigger events/iommu=
/io_page_fault/trigger events/iommu/map/trigger events/iommu/remove_device_=
from_group/trigger events/iommu/unmap/trigger events/ipi/ipi_send_cpu/trigg=
er events/ipi/ipi_send_cpumask/trigger events/irq/irq_handler_entry/trigger=
 events/irq/irq_handler_exit/trigger events/irq/softirq_entry/trigger event=
s/irq/softirq_exit/trigger events/irq/softirq_raise/trigger events/irq/task=
let_entry/trigger events/irq/tasklet_exit/trigger events/irq_matrix/irq_mat=
rix_alloc/trigger events/irq_matrix/irq_matrix_alloc_managed/trigger events=
/irq_matrix/irq_matrix_assign/trigger events/irq_matrix/irq_matrix_assign_s=
ystem/trigger events/irq_matrix/irq_matrix_free/trigger events/irq_matrix/i=
rq_matrix_offline/trigger events/irq_matrix/irq_matrix_online/trigger event=
s/irq_matrix/irq_matrix_remove_managed/trigger events/irq_matrix/irq_matrix=
_remove_reserved/trigger events/irq_matrix/irq_matrix_reserve/trigger event=
s/irq_matrix/irq_matrix_reserve_managed/trigger events/irq_vectors/call_fun=
ction_entry/trigger events/irq_vectors/call_function_exit/trigger events/ir=
q_vectors/call_function_single_entry/trigger events/irq_vectors/call_functi=
on_single_exit/trigger events/irq_vectors/deferred_error_apic_entry/trigger=
 events/irq_vectors/deferred_error_apic_exit/trigger events/irq_vectors/err=
or_apic_entry/trigger events/irq_vectors/error_apic_exit/trigger events/irq=
_vectors/irq_work_entry/trigger events/irq_vectors/irq_work_exit/trigger ev=
ents/irq_vectors/local_timer_entry/trigger events/irq_vectors/local_timer_e=
xit/trigger events/irq_vectors/reschedule_entry/trigger events/irq_vectors/=
reschedule_exit/trigger events/irq_vectors/spurious_apic_entry/trigger even=
ts/irq_vectors/spurious_apic_exit/trigger events/irq_vectors/thermal_apic_e=
ntry/trigger events/irq_vectors/thermal_apic_exit/trigger events/irq_vector=
s/threshold_apic_entry/trigger events/irq_vectors/threshold_apic_exit/trigg=
er events/irq_vectors/vector_activate/trigger events/irq_vectors/vector_all=
oc/trigger events/irq_vectors/vector_alloc_managed/trigger events/irq_vecto=
rs/vector_clear/trigger events/irq_vectors/vector_config/trigger events/irq=
_vectors/vector_deactivate/trigger events/irq_vectors/vector_free_moved/tri=
gger events/irq_vectors/vector_reserve/trigger events/irq_vectors/vector_re=
serve_managed/trigger events/irq_vectors/vector_setup/trigger events/irq_ve=
ctors/vector_teardown/trigger events/irq_vectors/vector_update/trigger even=
ts/irq_vectors/x86_platform_ipi_entry/trigger events/irq_vectors/x86_platfo=
rm_ipi_exit/trigger events/jbd2/jbd2_checkpoint/trigger events/jbd2/jbd2_ch=
eckpoint_stats/trigger events/jbd2/jbd2_commit_flushing/trigger events/jbd2=
/jbd2_commit_locking/trigger events/jbd2/jbd2_commit_logging/trigger events=
/jbd2/jbd2_drop_transaction/trigger events/jbd2/jbd2_end_commit/trigger eve=
nts/jbd2/jbd2_handle_extend/trigger events/jbd2/jbd2_handle_restart/trigger=
 events/jbd2/jbd2_handle_start/trigger events/jbd2/jbd2_handle_stats/trigge=
r events/jbd2/jbd2_lock_buffer_stall/trigger events/jbd2/jbd2_run_stats/tri=
gger events/jbd2/jbd2_shrink_checkpoint_list/trigger events/jbd2/jbd2_shrin=
k_count/trigger events/jbd2/jbd2_shrink_scan_enter/trigger events/jbd2/jbd2=
_shrink_scan_exit/trigger events/jbd2/jbd2_start_commit/trigger events/jbd2=
/jbd2_submit_inode_data/trigger events/jbd2/jbd2_update_log_tail/trigger ev=
ents/jbd2/jbd2_write_superblock/trigger events/kmem/kfree/trigger events/km=
em/kmalloc/trigger events/kmem/kmem_cache_alloc/trigger events/kmem/kmem_ca=
che_free/trigger events/kmem/mm_calculate_totalreserve_pages/trigger events=
/kmem/mm_page_alloc/trigger events/kmem/mm_page_alloc_extfrag/trigger event=
s/kmem/mm_page_alloc_zone_locked/trigger events/kmem/mm_page_free/trigger e=
vents/kmem/mm_page_free_batched/trigger events/kmem/mm_page_pcpu_drain/trig=
ger events/kmem/mm_setup_per_zone_lowmem_reserve/trigger events/kmem/mm_set=
up_per_zone_wmarks/trigger events/kmem/rss_stat/trigger events/kprobes/kpev=
ent/trigger events/ksm/ksm_advisor/trigger events/ksm/ksm_enter/trigger eve=
nts/ksm/ksm_exit/trigger events/ksm/ksm_merge_one_page/trigger events/ksm/k=
sm_merge_with_ksm_page/trigger events/ksm/ksm_remove_ksm_page/trigger event=
s/ksm/ksm_remove_rmap_item/trigger events/ksm/ksm_start_scan/trigger events=
/ksm/ksm_stop_scan/trigger events/kvm/kvm_ack_irq/trigger events/kvm/kvm_ag=
e_hva/trigger events/kvm/kvm_apic/trigger events/kvm/kvm_apic_accept_irq/tr=
igger events/kvm/kvm_apic_ipi/trigger events/kvm/kvm_apicv_accept_irq/trigg=
er events/kvm/kvm_apicv_inhibit_changed/trigger events/kvm/kvm_async_pf_com=
pleted/trigger events/kvm/kvm_async_pf_not_present/trigger events/kvm/kvm_a=
sync_pf_ready/trigger events/kvm/kvm_async_pf_repeated_fault/trigger events=
/kvm/kvm_avic_doorbell/trigger events/kvm/kvm_avic_ga_log/trigger events/kv=
m/kvm_avic_incomplete_ipi/trigger events/kvm/kvm_avic_kick_vcpu_slowpath/tr=
igger events/kvm/kvm_avic_unaccelerated_access/trigger events/kvm/kvm_cpuid=
/trigger events/kvm/kvm_cr/trigger events/kvm/kvm_dirty_ring_exit/trigger e=
vents/kvm/kvm_dirty_ring_push/trigger events/kvm/kvm_dirty_ring_reset/trigg=
er events/kvm/kvm_emulate_insn/trigger events/kvm/kvm_entry/trigger events/=
kvm/kvm_eoi/trigger events/kvm/kvm_exit/trigger events/kvm/kvm_fast_mmio/tr=
igger events/kvm/kvm_fpu/trigger events/kvm/kvm_halt_poll_ns/trigger events=
/kvm/kvm_hv_flush_tlb/trigger events/kvm/kvm_hv_flush_tlb_ex/trigger events=
/kvm/kvm_hv_hypercall/trigger events/kvm/kvm_hv_hypercall_done/trigger even=
ts/kvm/kvm_hv_notify_acked_sint/trigger events/kvm/kvm_hv_send_ipi/trigger =
events/kvm/kvm_hv_send_ipi_ex/trigger events/kvm/kvm_hv_stimer_callback/tri=
gger events/kvm/kvm_hv_stimer_cleanup/trigger events/kvm/kvm_hv_stimer_expi=
ration/trigger events/kvm/kvm_hv_stimer_set_config/trigger events/kvm/kvm_h=
v_stimer_set_count/trigger events/kvm/kvm_hv_stimer_start_one_shot/trigger =
events/kvm/kvm_hv_stimer_start_periodic/trigger events/kvm/kvm_hv_syndbg_ge=
t_msr/trigger events/kvm/kvm_hv_syndbg_set_msr/trigger events/kvm/kvm_hv_sy=
nic_send_eoi/trigger events/kvm/kvm_hv_synic_set_irq/trigger events/kvm/kvm=
_hv_synic_set_msr/trigger events/kvm/kvm_hv_timer_state/trigger events/kvm/=
kvm_hypercall/trigger events/kvm/kvm_inj_exception/trigger events/kvm/kvm_i=
nj_virq/trigger events/kvm/kvm_invlpga/trigger events/kvm/kvm_ioapic_delaye=
d_eoi_inj/trigger events/kvm/kvm_ioapic_set_irq/trigger events/kvm/kvm_mmio=
/trigger events/kvm/kvm_msi_set_irq/trigger events/kvm/kvm_msr/trigger even=
ts/kvm/kvm_nested_intercepts/trigger events/kvm/kvm_nested_intr_vmexit/trig=
ger events/kvm/kvm_nested_vmenter/trigger events/kvm/kvm_nested_vmenter_fai=
led/trigger events/kvm/kvm_nested_vmexit/trigger events/kvm/kvm_nested_vmex=
it_inject/trigger events/kvm/kvm_page_fault/trigger events/kvm/kvm_pi_irte_=
update/trigger events/kvm/kvm_pic_set_irq/trigger events/kvm/kvm_pio/trigge=
r events/kvm/kvm_ple_window_update/trigger events/kvm/kvm_pml_full/trigger =
events/kvm/kvm_pv_eoi/trigger events/kvm/kvm_pv_tlb_flush/trigger events/kv=
m/kvm_pvclock_update/trigger events/kvm/kvm_rmp_fault/trigger events/kvm/kv=
m_set_irq/trigger events/kvm/kvm_skinit/trigger events/kvm/kvm_smm_transiti=
on/trigger events/kvm/kvm_test_age_hva/trigger events/kvm/kvm_track_tsc/tri=
gger events/kvm/kvm_try_async_get_page/trigger events/kvm/kvm_unmap_hva_ran=
ge/trigger events/kvm/kvm_update_master_clock/trigger events/kvm/kvm_usersp=
ace_exit/trigger events/kvm/kvm_vcpu_wakeup/trigger events/kvm/kvm_vm_set_m=
em_attributes/trigger events/kvm/kvm_vmgexit_enter/trigger events/kvm/kvm_v=
mgexit_exit/trigger events/kvm/kvm_vmgexit_msr_protocol_enter/trigger event=
s/kvm/kvm_vmgexit_msr_protocol_exit/trigger events/kvm/kvm_wait_lapic_expir=
e/trigger events/kvm/kvm_write_tsc_offset/trigger events/kvm/kvm_xen_hyperc=
all/trigger events/kvm/vcpu_match_mmio/trigger events/kvmmmu/check_mmio_spt=
e/trigger events/kvmmmu/fast_page_fault/trigger events/kvmmmu/handle_mmio_p=
age_fault/trigger events/kvmmmu/kvm_mmu_get_page/trigger events/kvmmmu/kvm_=
mmu_pagetable_walk/trigger events/kvmmmu/kvm_mmu_paging_element/trigger eve=
nts/kvmmmu/kvm_mmu_prepare_zap_page/trigger events/kvmmmu/kvm_mmu_set_acces=
sed_bit/trigger events/kvmmmu/kvm_mmu_set_dirty_bit/trigger events/kvmmmu/k=
vm_mmu_set_spte/trigger events/kvmmmu/kvm_mmu_split_huge_page/trigger event=
s/kvmmmu/kvm_mmu_spte_requested/trigger events/kvmmmu/kvm_mmu_sync_page/tri=
gger events/kvmmmu/kvm_mmu_unsync_page/trigger events/kvmmmu/kvm_mmu_walker=
_error/trigger events/kvmmmu/kvm_mmu_zap_all_fast/trigger events/kvmmmu/kvm=
_tdp_mmu_spte_changed/trigger events/kvmmmu/mark_mmio_spte/trigger events/k=
yber/kyber_adjust/trigger events/kyber/kyber_latency/trigger events/kyber/k=
yber_throttled/trigger events/libata/ata_bmdma_setup/trigger events/libata/=
ata_bmdma_start/trigger events/libata/ata_bmdma_status/trigger events/libat=
a/ata_bmdma_stop/trigger events/libata/ata_eh_about_to_do/trigger events/li=
bata/ata_eh_done/trigger events/libata/ata_eh_link_autopsy/trigger events/l=
ibata/ata_eh_link_autopsy_qc/trigger events/libata/ata_exec_command/trigger=
 events/libata/ata_link_hardreset_begin/trigger events/libata/ata_link_hard=
reset_end/trigger events/libata/ata_link_postreset/trigger events/libata/at=
a_link_softreset_begin/trigger events/libata/ata_link_softreset_end/trigger=
 events/libata/ata_port_freeze/trigger events/libata/ata_port_thaw/trigger =
events/libata/ata_qc_complete_done/trigger events/libata/ata_qc_complete_fa=
iled/trigger events/libata/ata_qc_complete_internal/trigger events/libata/a=
ta_qc_issue/trigger events/libata/ata_qc_prep/trigger events/libata/ata_sff=
_flush_pio_task/trigger events/libata/ata_sff_hsm_command_complete/trigger =
events/libata/ata_sff_hsm_state/trigger events/libata/ata_sff_pio_transfer_=
data/trigger events/libata/ata_sff_port_intr/trigger events/libata/ata_slav=
e_hardreset_begin/trigger events/libata/ata_slave_hardreset_end/trigger eve=
nts/libata/ata_slave_postreset/trigger events/libata/ata_std_sched_eh/trigg=
er events/libata/ata_tf_load/trigger events/libata/atapi_pio_transfer_data/=
trigger events/libata/atapi_send_cdb/trigger events/lock/contended_release/=
trigger events/lock/contention_begin/trigger events/lock/contention_end/tri=
gger events/lock/lock_acquire/trigger events/lock/lock_release/trigger even=
ts/lockd/nlmclnt_grant/trigger events/lockd/nlmclnt_lock/trigger events/loc=
kd/nlmclnt_test/trigger events/lockd/nlmclnt_unlock/trigger events/maple_tr=
ee/ma_op/trigger events/maple_tree/ma_read/trigger events/maple_tree/ma_wri=
te/trigger events/mce/mce_record/trigger events/mdio/mdio_access/trigger ev=
ents/mei/mei_pci_cfg_read/trigger events/mei/mei_reg_read/trigger events/me=
i/mei_reg_write/trigger events/memcg/count_memcg_events/trigger events/memc=
g/memcg_flush_stats/trigger events/memcg/mod_memcg_lruvec_state/trigger eve=
nts/memcg/mod_memcg_state/trigger events/memory_failure/memory_failure_even=
t/trigger events/migrate/mm_migrate_pages/trigger events/migrate/mm_migrate=
_pages_start/trigger events/migrate/remove_migration_pte/trigger events/mig=
rate/set_migration_pte/trigger events/mmap/exit_mmap/trigger events/mmap/vm=
_unmapped_area/trigger events/mmap_lock/mmap_lock_acquire_returned/trigger =
events/mmap_lock/mmap_lock_released/trigger events/mmap_lock/mmap_lock_star=
t_locking/trigger events/module/module_free/trigger events/module/module_ge=
t/trigger events/module/module_load/trigger events/module/module_put/trigge=
r events/module/module_request/trigger events/mptcp/ack_update_msk/trigger =
events/mptcp/get_mapping_status/trigger events/mptcp/mptcp_rcvbuf_grow/trig=
ger events/mptcp/mptcp_sendmsg_frag/trigger events/mptcp/mptcp_subflow_get_=
send/trigger events/mptcp/subflow_check_data_avail/trigger events/msr/rdpmc=
/trigger events/msr/read_msr/trigger events/msr/write_msr/trigger events/na=
pi/dql_stall_detected/trigger events/napi/napi_poll/trigger events/neigh/ne=
igh_cleanup_and_release/trigger events/neigh/neigh_create/trigger events/ne=
igh/neigh_event_send_dead/trigger events/neigh/neigh_event_send_done/trigge=
r events/neigh/neigh_timer_handler/trigger events/neigh/neigh_update/trigge=
r events/neigh/neigh_update_done/trigger events/net/napi_gro_frags_entry/tr=
igger events/net/napi_gro_frags_exit/trigger events/net/napi_gro_receive_en=
try/trigger events/net/napi_gro_receive_exit/trigger events/net/net_dev_que=
ue/trigger events/net/net_dev_start_xmit/trigger events/net/net_dev_xmit/tr=
igger events/net/net_dev_xmit_timeout/trigger events/net/netif_receive_skb/=
trigger events/net/netif_receive_skb_entry/trigger events/net/netif_receive=
_skb_exit/trigger events/net/netif_receive_skb_list_entry/trigger events/ne=
t/netif_receive_skb_list_exit/trigger events/net/netif_rx/trigger events/ne=
t/netif_rx_entry/trigger events/net/netif_rx_exit/trigger events/netfs/netf=
s_collect/trigger events/netfs/netfs_collect_folio/trigger events/netfs/net=
fs_collect_gap/trigger events/netfs/netfs_collect_sreq/trigger events/netfs=
/netfs_collect_state/trigger events/netfs/netfs_collect_stream/trigger even=
ts/netfs/netfs_copy2cache/trigger events/netfs/netfs_failure/trigger events=
/netfs/netfs_folio/trigger events/netfs/netfs_folioq/trigger events/netfs/n=
etfs_read/trigger events/netfs/netfs_rreq/trigger events/netfs/netfs_rreq_r=
ef/trigger events/netfs/netfs_sreq/trigger events/netfs/netfs_sreq_ref/trig=
ger events/netfs/netfs_write/trigger events/netfs/netfs_write_iter/trigger =
events/netlink/netlink_extack/trigger events/nfs/nfs_access_enter/trigger e=
vents/nfs/nfs_access_exit/trigger events/nfs/nfs_aop_readahead/trigger even=
ts/nfs/nfs_aop_readahead_done/trigger events/nfs/nfs_aop_readpage/trigger e=
vents/nfs/nfs_aop_readpage_done/trigger events/nfs/nfs_async_rename_done/tr=
igger events/nfs/nfs_atomic_open_enter/trigger events/nfs/nfs_atomic_open_e=
xit/trigger events/nfs/nfs_commit_done/trigger events/nfs/nfs_commit_error/=
trigger events/nfs/nfs_comp_error/trigger events/nfs/nfs_create_enter/trigg=
er events/nfs/nfs_create_exit/trigger events/nfs/nfs_direct_commit_complete=
/trigger events/nfs/nfs_direct_resched_write/trigger events/nfs/nfs_direct_=
write_complete/trigger events/nfs/nfs_direct_write_completion/trigger event=
s/nfs/nfs_direct_write_reschedule_io/trigger events/nfs/nfs_direct_write_sc=
hedule_iovec/trigger events/nfs/nfs_do_writepage/trigger events/nfs/nfs_fh_=
to_dentry/trigger events/nfs/nfs_file_read/trigger events/nfs/nfs_file_writ=
e/trigger events/nfs/nfs_fsync_enter/trigger events/nfs/nfs_fsync_exit/trig=
ger events/nfs/nfs_getattr_enter/trigger events/nfs/nfs_getattr_exit/trigge=
r events/nfs/nfs_initiate_commit/trigger events/nfs/nfs_initiate_read/trigg=
er events/nfs/nfs_initiate_write/trigger events/nfs/nfs_invalidate_folio/tr=
igger events/nfs/nfs_invalidate_mapping_enter/trigger events/nfs/nfs_invali=
date_mapping_exit/trigger events/nfs/nfs_launder_folio_done/trigger events/=
nfs/nfs_link_enter/trigger events/nfs/nfs_link_exit/trigger events/nfs/nfs_=
local_open_fh/trigger events/nfs/nfs_lookup_enter/trigger events/nfs/nfs_lo=
okup_exit/trigger events/nfs/nfs_lookup_revalidate_enter/trigger events/nfs=
/nfs_lookup_revalidate_exit/trigger events/nfs/nfs_mkdir_enter/trigger even=
ts/nfs/nfs_mkdir_exit/trigger events/nfs/nfs_mknod_enter/trigger events/nfs=
/nfs_mknod_exit/trigger events/nfs/nfs_mount_assign/trigger events/nfs/nfs_=
mount_option/trigger events/nfs/nfs_mount_path/trigger events/nfs/nfs_pgio_=
error/trigger events/nfs/nfs_readdir_cache_fill/trigger events/nfs/nfs_read=
dir_cache_fill_done/trigger events/nfs/nfs_readdir_force_readdirplus/trigge=
r events/nfs/nfs_readdir_invalidate_cache_range/trigger events/nfs/nfs_read=
dir_lookup/trigger events/nfs/nfs_readdir_lookup_revalidate/trigger events/=
nfs/nfs_readdir_lookup_revalidate_failed/trigger events/nfs/nfs_readdir_unc=
ached/trigger events/nfs/nfs_readdir_uncached_done/trigger events/nfs/nfs_r=
eadpage_done/trigger events/nfs/nfs_readpage_short/trigger events/nfs/nfs_r=
efresh_inode_enter/trigger events/nfs/nfs_refresh_inode_exit/trigger events=
/nfs/nfs_remove_enter/trigger events/nfs/nfs_remove_exit/trigger events/nfs=
/nfs_rename_enter/trigger events/nfs/nfs_rename_exit/trigger events/nfs/nfs=
_revalidate_inode_enter/trigger events/nfs/nfs_revalidate_inode_exit/trigge=
r events/nfs/nfs_rmdir_enter/trigger events/nfs/nfs_rmdir_exit/trigger even=
ts/nfs/nfs_set_cache_invalid/trigger events/nfs/nfs_set_inode_stale/trigger=
 events/nfs/nfs_setattr_enter/trigger events/nfs/nfs_setattr_exit/trigger e=
vents/nfs/nfs_sillyrename_unlink/trigger events/nfs/nfs_size_grow/trigger e=
vents/nfs/nfs_size_truncate/trigger events/nfs/nfs_size_truncate_folio/trig=
ger events/nfs/nfs_size_update/trigger events/nfs/nfs_size_wcc/trigger even=
ts/nfs/nfs_symlink_enter/trigger events/nfs/nfs_symlink_exit/trigger events=
/nfs/nfs_try_to_update_request/trigger events/nfs/nfs_try_to_update_request=
_done/trigger events/nfs/nfs_unlink_enter/trigger events/nfs/nfs_unlink_exi=
t/trigger events/nfs/nfs_update_folio/trigger events/nfs/nfs_update_folio_d=
one/trigger events/nfs/nfs_write_begin/trigger events/nfs/nfs_write_begin_d=
one/trigger events/nfs/nfs_write_end/trigger events/nfs/nfs_write_end_done/=
trigger events/nfs/nfs_write_error/trigger events/nfs/nfs_writeback_done/tr=
igger events/nfs/nfs_writeback_folio/trigger events/nfs/nfs_writeback_folio=
_done/trigger events/nfs/nfs_writeback_folio_reclaim/trigger events/nfs/nfs=
_writeback_folio_reclaim_done/trigger events/nfs/nfs_writeback_inode_enter/=
trigger events/nfs/nfs_writeback_inode_exit/trigger events/nfs/nfs_writepag=
e_setup/trigger events/nfs/nfs_writepages/trigger events/nfs/nfs_writepages=
_done/trigger events/nfs/nfs_xdr_bad_filehandle/trigger events/nfs/nfs_xdr_=
status/trigger events/nmi/nmi_handler/trigger events/notifier/notifier_regi=
ster/trigger events/notifier/notifier_run/trigger events/notifier/notifier_=
unregister/trigger events/nvme/nvme_async_event/trigger events/nvme/nvme_co=
mplete_rq/trigger events/nvme/nvme_setup_cmd/trigger events/nvme/nvme_sq/tr=
igger events/oom/compact_retry/trigger events/oom/finish_task_reaping/trigg=
er events/oom/mark_victim/trigger events/oom/oom_score_adj_update/trigger e=
vents/oom/reclaim_retry_zone/trigger events/oom/skip_task_reaping/trigger e=
vents/oom/start_task_reaping/trigger events/oom/wake_reaper/trigger events/=
osnoise/irq_noise/trigger events/osnoise/nmi_noise/trigger events/osnoise/o=
snoise_sample/trigger events/osnoise/sample_threshold/trigger events/osnois=
e/softirq_noise/trigger events/osnoise/thread_noise/trigger events/osnoise/=
timerlat_sample/trigger events/page_isolation/test_pages_isolated/trigger e=
vents/page_pool/page_pool_release/trigger events/page_pool/page_pool_state_=
hold/trigger events/page_pool/page_pool_state_release/trigger events/page_p=
ool/page_pool_update_nid/trigger events/pagemap/mm_lru_activate/trigger eve=
nts/pagemap/mm_lru_insertion/trigger events/pci/pci_hp_event/trigger events=
/pci/pcie_link_event/trigger events/pci_controller/pcie_ltssm_state_transit=
ion/trigger events/percpu/percpu_alloc_percpu/trigger events/percpu/percpu_=
alloc_percpu_fail/trigger events/percpu/percpu_create_chunk/trigger events/=
percpu/percpu_destroy_chunk/trigger events/percpu/percpu_free_percpu/trigge=
r events/power/cpu_frequency/trigger events/power/cpu_frequency_limits/trig=
ger events/power/cpu_idle/trigger events/power/cpu_idle_miss/trigger events=
/power/dev_pm_qos_add_request/trigger events/power/dev_pm_qos_remove_reques=
t/trigger events/power/dev_pm_qos_update_request/trigger events/power/devic=
e_pm_callback_end/trigger events/power/device_pm_callback_start/trigger eve=
nts/power/guest_halt_poll_ns/trigger events/power/pm_qos_add_request/trigge=
r events/power/pm_qos_remove_request/trigger events/power/pm_qos_update_fla=
gs/trigger events/power/pm_qos_update_request/trigger events/power/pm_qos_u=
pdate_target/trigger events/power/pstate_sample/trigger events/power/suspen=
d_resume/trigger events/power/wakeup_source_activate/trigger events/power/w=
akeup_source_deactivate/trigger events/preemptirq/irq_disable/trigger event=
s/preemptirq/irq_enable/trigger events/preemptirq/preempt_disable/trigger e=
vents/preemptirq/preempt_enable/trigger events/printk/console/trigger event=
s/pwm/pwm_apply/trigger events/pwm/pwm_get/trigger events/pwm/pwm_read_wave=
form/trigger events/pwm/pwm_round_waveform_fromhw/trigger events/pwm/pwm_ro=
und_waveform_tohw/trigger events/pwm/pwm_write_waveform/trigger events/qdis=
c/qdisc_create/trigger events/qdisc/qdisc_dequeue/trigger events/qdisc/qdis=
c_destroy/trigger events/qdisc/qdisc_drop/trigger events/qdisc/qdisc_enqueu=
e/trigger events/qdisc/qdisc_reset/trigger events/ras/aer_event/trigger eve=
nts/ras/arm_event/trigger events/ras/extlog_mem_event/trigger events/ras/mc=
_event/trigger events/ras/non_standard_event/trigger events/raw_syscalls/sy=
s_enter/trigger events/raw_syscalls/sys_exit/trigger events/rcu/rcu_stall_w=
arning/trigger events/rcu/rcu_utilization/trigger events/rdma_cma/cm_add_on=
e/trigger events/rdma_cma/cm_disconnect/trigger events/rdma_cma/cm_event_do=
ne/trigger events/rdma_cma/cm_event_handler/trigger events/rdma_cma/cm_id_a=
ttach/trigger events/rdma_cma/cm_id_destroy/trigger events/rdma_cma/cm_prep=
are_mra/trigger events/rdma_cma/cm_qp_create/trigger events/rdma_cma/cm_qp_=
destroy/trigger events/rdma_cma/cm_remove_one/trigger events/rdma_cma/cm_re=
q_handler/trigger events/rdma_cma/cm_send_rej/trigger events/rdma_cma/cm_se=
nd_rep/trigger events/rdma_cma/cm_send_req/trigger events/rdma_cma/cm_send_=
rtu/trigger events/rdma_cma/cm_send_sidr_rep/trigger events/rdma_cma/cm_sen=
d_sidr_req/trigger events/rdma_cma/cm_sent_drep/trigger events/rdma_cma/cm_=
sent_dreq/trigger events/rdma_core/cq_alloc/trigger events/rdma_core/cq_all=
oc_error/trigger events/rdma_core/cq_drain_complete/trigger events/rdma_cor=
e/cq_free/trigger events/rdma_core/cq_modify/trigger events/rdma_core/cq_po=
ll/trigger events/rdma_core/cq_process/trigger events/rdma_core/cq_reschedu=
le/trigger events/rdma_core/cq_schedule/trigger events/rdma_core/mr_alloc/t=
rigger events/rdma_core/mr_dereg/trigger events/rdma_core/mr_integ_alloc/tr=
igger events/readahead/page_cache_async_ra/trigger events/readahead/page_ca=
che_ra_order/trigger events/readahead/page_cache_ra_unbounded/trigger event=
s/readahead/page_cache_sync_ra/trigger events/regmap/regcache_drop_region/t=
rigger events/regmap/regcache_sync/trigger events/regmap/regmap_async_compl=
ete_done/trigger events/regmap/regmap_async_complete_start/trigger events/r=
egmap/regmap_async_io_complete/trigger events/regmap/regmap_async_write_sta=
rt/trigger events/regmap/regmap_bulk_read/trigger events/regmap/regmap_bulk=
_write/trigger events/regmap/regmap_cache_bypass/trigger events/regmap/regm=
ap_cache_only/trigger events/regmap/regmap_hw_read_done/trigger events/regm=
ap/regmap_hw_read_start/trigger events/regmap/regmap_hw_write_done/trigger =
events/regmap/regmap_hw_write_start/trigger events/regmap/regmap_reg_read/t=
rigger events/regmap/regmap_reg_read_cache/trigger events/regmap/regmap_reg=
_write/trigger events/resctrl/mon_llc_occupancy_limbo/trigger events/resctr=
l/pseudo_lock_l2/trigger events/resctrl/pseudo_lock_l3/trigger events/resct=
rl/pseudo_lock_mem_latency/trigger events/rpm/rpm_idle/trigger events/rpm/r=
pm_resume/trigger events/rpm/rpm_return_int/trigger events/rpm/rpm_status/t=
rigger events/rpm/rpm_suspend/trigger events/rpm/rpm_usage/trigger events/r=
seq/rseq_ip_fixup/trigger events/rseq/rseq_update/trigger events/rtc/rtc_al=
arm_irq_enable/trigger events/rtc/rtc_irq_set_freq/trigger events/rtc/rtc_i=
rq_set_state/trigger events/rtc/rtc_read_alarm/trigger events/rtc/rtc_read_=
offset/trigger events/rtc/rtc_read_time/trigger events/rtc/rtc_set_alarm/tr=
igger events/rtc/rtc_set_offset/trigger events/rtc/rtc_set_time/trigger eve=
nts/rtc/rtc_timer_dequeue/trigger events/rtc/rtc_timer_enqueue/trigger even=
ts/rtc/rtc_timer_fired/trigger events/rv/error_wwnr/trigger events/rv/event=
_wwnr/trigger events/rv/rv_retries_error/trigger events/sched/sched_kthread=
_stop/trigger events/sched/sched_kthread_stop_ret/trigger events/sched/sche=
d_kthread_work_execute_end/trigger events/sched/sched_kthread_work_execute_=
start/trigger events/sched/sched_kthread_work_queue_work/trigger events/sch=
ed/sched_migrate_task/trigger events/sched/sched_move_numa/trigger events/s=
ched/sched_pi_setprio/trigger events/sched/sched_prepare_exec/trigger event=
s/sched/sched_process_exec/trigger events/sched/sched_process_exit/trigger =
events/sched/sched_process_fork/trigger events/sched/sched_process_free/tri=
gger events/sched/sched_process_hang/trigger events/sched/sched_process_wai=
t/trigger events/sched/sched_skip_cpuset_numa/trigger events/sched/sched_sk=
ip_vma_numa/trigger events/sched/sched_stat_blocked/trigger events/sched/sc=
hed_stat_iowait/trigger events/sched/sched_stat_runtime/trigger events/sche=
d/sched_stat_sleep/trigger events/sched/sched_stat_wait/trigger events/sche=
d/sched_stick_numa/trigger events/sched/sched_swap_numa/trigger events/sche=
d/sched_switch/trigger events/sched/sched_wait_task/trigger events/sched/sc=
hed_wake_idle_without_ipi/trigger events/sched/sched_wakeup/trigger events/=
sched/sched_wakeup_new/trigger events/sched/sched_waking/trigger events/sch=
ed_ext/sched_ext_bypass_lb/trigger events/sched_ext/sched_ext_dump/trigger =
events/sched_ext/sched_ext_event/trigger events/scsi/scsi_dispatch_cmd_done=
/trigger events/scsi/scsi_dispatch_cmd_error/trigger events/scsi/scsi_dispa=
tch_cmd_start/trigger events/scsi/scsi_dispatch_cmd_timeout/trigger events/=
scsi/scsi_eh_wakeup/trigger events/signal/signal_deliver/trigger events/sig=
nal/signal_generate/trigger events/skb/consume_skb/trigger events/skb/kfree=
_skb/trigger events/skb/skb_copy_datagram_iovec/trigger events/smbus/smbus_=
read/trigger events/smbus/smbus_reply/trigger events/smbus/smbus_result/tri=
gger events/smbus/smbus_write/trigger events/smc/smc_rx_recvmsg/trigger eve=
nts/smc/smc_switch_to_fallback/trigger events/smc/smc_tx_sendmsg/trigger ev=
ents/smc/smcr_link_down/trigger events/sock/inet_sk_error_report/trigger ev=
ents/sock/inet_sock_set_state/trigger events/sock/sk_data_ready/trigger eve=
nts/sock/sock_exceed_buf_limit/trigger events/sock/sock_rcvqueue_full/trigg=
er events/sock/sock_recv_length/trigger events/sock/sock_send_length/trigge=
r events/sof/sof_ipc3_period_elapsed_position/trigger events/sof/sof_ipc4_f=
w_config/trigger events/sof/sof_pcm_pointer_position/trigger events/sof/sof=
_stream_position_ipc_rx/trigger events/sof/sof_widget_free/trigger events/s=
of/sof_widget_setup/trigger events/sof_intel/sof_intel_D0I3C_updated/trigge=
r events/sof_intel/sof_intel_hda_dsp_check_stream_irq/trigger events/sof_in=
tel/sof_intel_hda_dsp_pcm/trigger events/sof_intel/sof_intel_hda_dsp_stream=
_status/trigger events/sof_intel/sof_intel_hda_irq/trigger events/sof_intel=
/sof_intel_hda_irq_ipc_check/trigger events/sof_intel/sof_intel_ipc_firmwar=
e_initiated/trigger events/sof_intel/sof_intel_ipc_firmware_response/trigge=
r events/spi/spi_controller_busy/trigger events/spi/spi_controller_idle/tri=
gger events/spi/spi_message_done/trigger events/spi/spi_message_start/trigg=
er events/spi/spi_message_submit/trigger events/spi/spi_set_cs/trigger even=
ts/spi/spi_setup/trigger events/spi/spi_transfer_start/trigger events/spi/s=
pi_transfer_stop/trigger events/sunrpc/cache_entry_expired/trigger events/s=
unrpc/cache_entry_make_negative/trigger events/sunrpc/cache_entry_no_listen=
er/trigger events/sunrpc/cache_entry_upcall/trigger events/sunrpc/cache_ent=
ry_update/trigger events/sunrpc/pmap_register/trigger events/sunrpc/rpc__au=
th_tooweak/trigger events/sunrpc/rpc__bad_creds/trigger events/sunrpc/rpc__=
garbage_args/trigger events/sunrpc/rpc__mismatch/trigger events/sunrpc/rpc_=
_proc_unavail/trigger events/sunrpc/rpc__prog_mismatch/trigger events/sunrp=
c/rpc__prog_unavail/trigger events/sunrpc/rpc__stale_creds/trigger events/s=
unrpc/rpc__unparsable/trigger events/sunrpc/rpc_bad_callhdr/trigger events/=
sunrpc/rpc_bad_verifier/trigger events/sunrpc/rpc_buf_alloc/trigger events/=
sunrpc/rpc_call_rpcerror/trigger events/sunrpc/rpc_call_status/trigger even=
ts/sunrpc/rpc_clnt_clone_err/trigger events/sunrpc/rpc_clnt_free/trigger ev=
ents/sunrpc/rpc_clnt_killall/trigger events/sunrpc/rpc_clnt_new/trigger eve=
nts/sunrpc/rpc_clnt_new_err/trigger events/sunrpc/rpc_clnt_release/trigger =
events/sunrpc/rpc_clnt_replace_xprt/trigger events/sunrpc/rpc_clnt_replace_=
xprt_err/trigger events/sunrpc/rpc_clnt_shutdown/trigger events/sunrpc/rpc_=
connect_status/trigger events/sunrpc/rpc_refresh_status/trigger events/sunr=
pc/rpc_request/trigger events/sunrpc/rpc_retry_refresh_status/trigger event=
s/sunrpc/rpc_socket_close/trigger events/sunrpc/rpc_socket_connect/trigger =
events/sunrpc/rpc_socket_error/trigger events/sunrpc/rpc_socket_nospace/tri=
gger events/sunrpc/rpc_socket_reset_connection/trigger events/sunrpc/rpc_so=
cket_shutdown/trigger events/sunrpc/rpc_socket_state_change/trigger events/=
sunrpc/rpc_stats_latency/trigger events/sunrpc/rpc_task_begin/trigger event=
s/sunrpc/rpc_task_call_done/trigger events/sunrpc/rpc_task_complete/trigger=
 events/sunrpc/rpc_task_end/trigger events/sunrpc/rpc_task_run_action/trigg=
er events/sunrpc/rpc_task_signalled/trigger events/sunrpc/rpc_task_sleep/tr=
igger events/sunrpc/rpc_task_sync_sleep/trigger events/sunrpc/rpc_task_sync=
_wake/trigger events/sunrpc/rpc_task_timeout/trigger events/sunrpc/rpc_task=
_wakeup/trigger events/sunrpc/rpc_timeout_status/trigger events/sunrpc/rpc_=
tls_not_started/trigger events/sunrpc/rpc_tls_unavailable/trigger events/su=
nrpc/rpc_xdr_alignment/trigger events/sunrpc/rpc_xdr_overflow/trigger event=
s/sunrpc/rpc_xdr_recvfrom/trigger events/sunrpc/rpc_xdr_reply_pages/trigger=
 events/sunrpc/rpc_xdr_sendto/trigger events/sunrpc/rpcb_bind_version_err/t=
rigger events/sunrpc/rpcb_getport/trigger events/sunrpc/rpcb_prog_unavail_e=
rr/trigger events/sunrpc/rpcb_register/trigger events/sunrpc/rpcb_setport/t=
rigger events/sunrpc/rpcb_timeout_err/trigger events/sunrpc/rpcb_unreachabl=
e_err/trigger events/sunrpc/rpcb_unrecognized_err/trigger events/sunrpc/rpc=
b_unregister/trigger events/sunrpc/svc_alloc_arg_err/trigger events/sunrpc/=
svc_authenticate/trigger events/sunrpc/svc_defer/trigger events/sunrpc/svc_=
defer_drop/trigger events/sunrpc/svc_defer_queue/trigger events/sunrpc/svc_=
defer_recv/trigger events/sunrpc/svc_drop/trigger events/sunrpc/svc_noregis=
ter/trigger events/sunrpc/svc_pool_thread_noidle/trigger events/sunrpc/svc_=
pool_thread_running/trigger events/sunrpc/svc_pool_thread_wake/trigger even=
ts/sunrpc/svc_process/trigger events/sunrpc/svc_register/trigger events/sun=
rpc/svc_replace_page_err/trigger events/sunrpc/svc_send/trigger events/sunr=
pc/svc_stats_latency/trigger events/sunrpc/svc_tls_not_started/trigger even=
ts/sunrpc/svc_tls_start/trigger events/sunrpc/svc_tls_timed_out/trigger eve=
nts/sunrpc/svc_tls_unavailable/trigger events/sunrpc/svc_tls_upcall/trigger=
 events/sunrpc/svc_unregister/trigger events/sunrpc/svc_xdr_recvfrom/trigge=
r events/sunrpc/svc_xdr_sendto/trigger events/sunrpc/svc_xprt_accept/trigge=
r events/sunrpc/svc_xprt_close/trigger events/sunrpc/svc_xprt_create_err/tr=
igger events/sunrpc/svc_xprt_dequeue/trigger events/sunrpc/svc_xprt_detach/=
trigger events/sunrpc/svc_xprt_enqueue/trigger events/sunrpc/svc_xprt_free/=
trigger events/sunrpc/svc_xprt_no_write_space/trigger events/sunrpc/svcsock=
_accept_err/trigger events/sunrpc/svcsock_data_ready/trigger events/sunrpc/=
svcsock_free/trigger events/sunrpc/svcsock_getpeername_err/trigger events/s=
unrpc/svcsock_marker/trigger events/sunrpc/svcsock_new/trigger events/sunrp=
c/svcsock_tcp_recv/trigger events/sunrpc/svcsock_tcp_recv_eagain/trigger ev=
ents/sunrpc/svcsock_tcp_recv_err/trigger events/sunrpc/svcsock_tcp_recv_sho=
rt/trigger events/sunrpc/svcsock_tcp_send/trigger events/sunrpc/svcsock_tcp=
_state/trigger events/sunrpc/svcsock_udp_recv/trigger events/sunrpc/svcsock=
_udp_recv_err/trigger events/sunrpc/svcsock_udp_send/trigger events/sunrpc/=
svcsock_write_space/trigger events/sunrpc/xprt_connect/trigger events/sunrp=
c/xprt_create/trigger events/sunrpc/xprt_destroy/trigger events/sunrpc/xprt=
_disconnect_auto/trigger events/sunrpc/xprt_disconnect_done/trigger events/=
sunrpc/xprt_disconnect_force/trigger events/sunrpc/xprt_get_cong/trigger ev=
ents/sunrpc/xprt_lookup_rqst/trigger events/sunrpc/xprt_ping/trigger events=
/sunrpc/xprt_put_cong/trigger events/sunrpc/xprt_release_cong/trigger event=
s/sunrpc/xprt_release_xprt/trigger events/sunrpc/xprt_reserve/trigger event=
s/sunrpc/xprt_reserve_cong/trigger events/sunrpc/xprt_reserve_xprt/trigger =
events/sunrpc/xprt_retransmit/trigger events/sunrpc/xprt_timer/trigger even=
ts/sunrpc/xprt_transmit/trigger events/sunrpc/xs_data_ready/trigger events/=
sunrpc/xs_stream_read_data/trigger events/sunrpc/xs_stream_read_request/tri=
gger events/swiotlb/swiotlb_bounced/trigger events/syscalls/sys_enter_accep=
t/trigger events/syscalls/sys_enter_accept4/trigger events/syscalls/sys_ent=
er_access/trigger events/syscalls/sys_enter_acct/trigger events/syscalls/sy=
s_enter_add_key/trigger events/syscalls/sys_enter_adjtimex/trigger events/s=
yscalls/sys_enter_alarm/trigger events/syscalls/sys_enter_arch_prctl/trigge=
r events/syscalls/sys_enter_bind/trigger events/syscalls/sys_enter_bpf/trig=
ger events/syscalls/sys_enter_brk/trigger events/syscalls/sys_enter_cachest=
at/trigger events/syscalls/sys_enter_capget/trigger events/syscalls/sys_ent=
er_capset/trigger events/syscalls/sys_enter_chdir/trigger events/syscalls/s=
ys_enter_chmod/trigger events/syscalls/sys_enter_chown/trigger events/sysca=
lls/sys_enter_chroot/trigger events/syscalls/sys_enter_clock_adjtime/trigge=
r events/syscalls/sys_enter_clock_getres/trigger events/syscalls/sys_enter_=
clock_gettime/trigger events/syscalls/sys_enter_clock_nanosleep/trigger eve=
nts/syscalls/sys_enter_clock_settime/trigger events/syscalls/sys_enter_clon=
e/trigger events/syscalls/sys_enter_clone3/trigger events/syscalls/sys_ente=
r_close/trigger events/syscalls/sys_enter_close_range/trigger events/syscal=
ls/sys_enter_connect/trigger events/syscalls/sys_enter_copy_file_range/trig=
ger events/syscalls/sys_enter_creat/trigger events/syscalls/sys_enter_delet=
e_module/trigger events/syscalls/sys_enter_dup/trigger events/syscalls/sys_=
enter_dup2/trigger events/syscalls/sys_enter_dup3/trigger events/syscalls/s=
ys_enter_epoll_create/trigger events/syscalls/sys_enter_epoll_create1/trigg=
er events/syscalls/sys_enter_epoll_ctl/trigger events/syscalls/sys_enter_ep=
oll_pwait/trigger events/syscalls/sys_enter_epoll_pwait2/trigger events/sys=
calls/sys_enter_epoll_wait/trigger events/syscalls/sys_enter_eventfd/trigge=
r events/syscalls/sys_enter_eventfd2/trigger events/syscalls/sys_enter_exec=
ve/trigger events/syscalls/sys_enter_execveat/trigger events/syscalls/sys_e=
nter_exit/trigger events/syscalls/sys_enter_exit_group/trigger events/sysca=
lls/sys_enter_faccessat/trigger events/syscalls/sys_enter_faccessat2/trigge=
r events/syscalls/sys_enter_fadvise64/trigger events/syscalls/sys_enter_fal=
locate/trigger events/syscalls/sys_enter_fanotify_init/trigger events/sysca=
lls/sys_enter_fanotify_mark/trigger events/syscalls/sys_enter_fchdir/trigge=
r events/syscalls/sys_enter_fchmod/trigger events/syscalls/sys_enter_fchmod=
at/trigger events/syscalls/sys_enter_fchmodat2/trigger events/syscalls/sys_=
enter_fchown/trigger events/syscalls/sys_enter_fchownat/trigger events/sysc=
alls/sys_enter_fcntl/trigger events/syscalls/sys_enter_fdatasync/trigger ev=
ents/syscalls/sys_enter_fgetxattr/trigger events/syscalls/sys_enter_file_ge=
tattr/trigger events/syscalls/sys_enter_file_setattr/trigger events/syscall=
s/sys_enter_finit_module/trigger events/syscalls/sys_enter_flistxattr/trigg=
er events/syscalls/sys_enter_flock/trigger events/syscalls/sys_enter_fork/t=
rigger events/syscalls/sys_enter_fremovexattr/trigger events/syscalls/sys_e=
nter_fsconfig/trigger events/syscalls/sys_enter_fsetxattr/trigger events/sy=
scalls/sys_enter_fsmount/trigger events/syscalls/sys_enter_fsopen/trigger e=
vents/syscalls/sys_enter_fspick/trigger events/syscalls/sys_enter_fstatfs/t=
rigger events/syscalls/sys_enter_fsync/trigger events/syscalls/sys_enter_ft=
runcate/trigger events/syscalls/sys_enter_futex/trigger events/syscalls/sys=
_enter_futex_requeue/trigger events/syscalls/sys_enter_futex_wait/trigger e=
vents/syscalls/sys_enter_futex_waitv/trigger events/syscalls/sys_enter_fute=
x_wake/trigger events/syscalls/sys_enter_futimesat/trigger events/syscalls/=
sys_enter_get_mempolicy/trigger events/syscalls/sys_enter_get_robust_list/t=
rigger events/syscalls/sys_enter_getcpu/trigger events/syscalls/sys_enter_g=
etcwd/trigger events/syscalls/sys_enter_getdents/trigger events/syscalls/sy=
s_enter_getdents64/trigger events/syscalls/sys_enter_getegid/trigger events=
/syscalls/sys_enter_geteuid/trigger events/syscalls/sys_enter_getgid/trigge=
r events/syscalls/sys_enter_getgroups/trigger events/syscalls/sys_enter_get=
itimer/trigger events/syscalls/sys_enter_getpeername/trigger events/syscall=
s/sys_enter_getpgid/trigger events/syscalls/sys_enter_getpgrp/trigger event=
s/syscalls/sys_enter_getpid/trigger events/syscalls/sys_enter_getppid/trigg=
er events/syscalls/sys_enter_getpriority/trigger events/syscalls/sys_enter_=
getrandom/trigger events/syscalls/sys_enter_getresgid/trigger events/syscal=
ls/sys_enter_getresuid/trigger events/syscalls/sys_enter_getrlimit/trigger =
events/syscalls/sys_enter_getrusage/trigger events/syscalls/sys_enter_getsi=
d/trigger events/syscalls/sys_enter_getsockname/trigger events/syscalls/sys=
_enter_getsockopt/trigger events/syscalls/sys_enter_gettid/trigger events/s=
yscalls/sys_enter_gettimeofday/trigger events/syscalls/sys_enter_getuid/tri=
gger events/syscalls/sys_enter_getxattr/trigger events/syscalls/sys_enter_g=
etxattrat/trigger events/syscalls/sys_enter_init_module/trigger events/sysc=
alls/sys_enter_inotify_add_watch/trigger events/syscalls/sys_enter_inotify_=
init/trigger events/syscalls/sys_enter_inotify_init1/trigger events/syscall=
s/sys_enter_inotify_rm_watch/trigger events/syscalls/sys_enter_io_cancel/tr=
igger events/syscalls/sys_enter_io_destroy/trigger events/syscalls/sys_ente=
r_io_getevents/trigger events/syscalls/sys_enter_io_pgetevents/trigger even=
ts/syscalls/sys_enter_io_setup/trigger events/syscalls/sys_enter_io_submit/=
trigger events/syscalls/sys_enter_io_uring_enter/trigger events/syscalls/sy=
s_enter_io_uring_register/trigger events/syscalls/sys_enter_io_uring_setup/=
trigger events/syscalls/sys_enter_ioctl/trigger events/syscalls/sys_enter_i=
operm/trigger events/syscalls/sys_enter_iopl/trigger events/syscalls/sys_en=
ter_ioprio_get/trigger events/syscalls/sys_enter_ioprio_set/trigger events/=
syscalls/sys_enter_kcmp/trigger events/syscalls/sys_enter_kexec_file_load/t=
rigger events/syscalls/sys_enter_kexec_load/trigger events/syscalls/sys_ent=
er_keyctl/trigger events/syscalls/sys_enter_kill/trigger events/syscalls/sy=
s_enter_lchown/trigger events/syscalls/sys_enter_lgetxattr/trigger events/s=
yscalls/sys_enter_link/trigger events/syscalls/sys_enter_linkat/trigger eve=
nts/syscalls/sys_enter_listen/trigger events/syscalls/sys_enter_listmount/t=
rigger events/syscalls/sys_enter_listns/trigger events/syscalls/sys_enter_l=
istxattr/trigger events/syscalls/sys_enter_listxattrat/trigger events/sysca=
lls/sys_enter_llistxattr/trigger events/syscalls/sys_enter_lremovexattr/tri=
gger events/syscalls/sys_enter_lseek/trigger events/syscalls/sys_enter_lset=
xattr/trigger events/syscalls/sys_enter_lsm_get_self_attr/trigger events/sy=
scalls/sys_enter_lsm_list_modules/trigger events/syscalls/sys_enter_lsm_set=
_self_attr/trigger events/syscalls/sys_enter_madvise/trigger events/syscall=
s/sys_enter_mbind/trigger events/syscalls/sys_enter_membarrier/trigger even=
ts/syscalls/sys_enter_memfd_create/trigger events/syscalls/sys_enter_memfd_=
secret/trigger events/syscalls/sys_enter_migrate_pages/trigger events/sysca=
lls/sys_enter_mincore/trigger events/syscalls/sys_enter_mkdir/trigger event=
s/syscalls/sys_enter_mkdirat/trigger events/syscalls/sys_enter_mknod/trigge=
r events/syscalls/sys_enter_mknodat/trigger events/syscalls/sys_enter_mlock=
/trigger events/syscalls/sys_enter_mlock2/trigger events/syscalls/sys_enter=
_mlockall/trigger events/syscalls/sys_enter_mmap/trigger events/syscalls/sy=
s_enter_modify_ldt/trigger events/syscalls/sys_enter_mount/trigger events/s=
yscalls/sys_enter_mount_setattr/trigger events/syscalls/sys_enter_move_moun=
t/trigger events/syscalls/sys_enter_move_pages/trigger events/syscalls/sys_=
enter_mprotect/trigger events/syscalls/sys_enter_mq_getsetattr/trigger even=
ts/syscalls/sys_enter_mq_notify/trigger events/syscalls/sys_enter_mq_open/t=
rigger events/syscalls/sys_enter_mq_timedreceive/trigger events/syscalls/sy=
s_enter_mq_timedsend/trigger events/syscalls/sys_enter_mq_unlink/trigger ev=
ents/syscalls/sys_enter_mremap/trigger events/syscalls/sys_enter_mseal/trig=
ger events/syscalls/sys_enter_msgctl/trigger events/syscalls/sys_enter_msgg=
et/trigger events/syscalls/sys_enter_msgrcv/trigger events/syscalls/sys_ent=
er_msgsnd/trigger events/syscalls/sys_enter_msync/trigger events/syscalls/s=
ys_enter_munlock/trigger events/syscalls/sys_enter_munlockall/trigger event=
s/syscalls/sys_enter_munmap/trigger events/syscalls/sys_enter_name_to_handl=
e_at/trigger events/syscalls/sys_enter_nanosleep/trigger events/syscalls/sy=
s_enter_newfstat/trigger events/syscalls/sys_enter_newfstatat/trigger event=
s/syscalls/sys_enter_newlstat/trigger events/syscalls/sys_enter_newstat/tri=
gger events/syscalls/sys_enter_newuname/trigger events/syscalls/sys_enter_o=
pen/trigger events/syscalls/sys_enter_open_by_handle_at/trigger events/sysc=
alls/sys_enter_open_tree/trigger events/syscalls/sys_enter_open_tree_attr/t=
rigger events/syscalls/sys_enter_openat/trigger events/syscalls/sys_enter_o=
penat2/trigger events/syscalls/sys_enter_pause/trigger events/syscalls/sys_=
enter_perf_event_open/trigger events/syscalls/sys_enter_personality/trigger=
 events/syscalls/sys_enter_pidfd_getfd/trigger events/syscalls/sys_enter_pi=
dfd_open/trigger events/syscalls/sys_enter_pidfd_send_signal/trigger events=
/syscalls/sys_enter_pipe/trigger events/syscalls/sys_enter_pipe2/trigger ev=
ents/syscalls/sys_enter_pivot_root/trigger events/syscalls/sys_enter_pkey_a=
lloc/trigger events/syscalls/sys_enter_pkey_free/trigger events/syscalls/sy=
s_enter_pkey_mprotect/trigger events/syscalls/sys_enter_poll/trigger events=
/syscalls/sys_enter_ppoll/trigger events/syscalls/sys_enter_prctl/trigger e=
vents/syscalls/sys_enter_pread64/trigger events/syscalls/sys_enter_preadv/t=
rigger events/syscalls/sys_enter_preadv2/trigger events/syscalls/sys_enter_=
prlimit64/trigger events/syscalls/sys_enter_process_madvise/trigger events/=
syscalls/sys_enter_process_mrelease/trigger events/syscalls/sys_enter_proce=
ss_vm_readv/trigger events/syscalls/sys_enter_process_vm_writev/trigger eve=
nts/syscalls/sys_enter_pselect6/trigger events/syscalls/sys_enter_ptrace/tr=
igger events/syscalls/sys_enter_pwrite64/trigger events/syscalls/sys_enter_=
pwritev/trigger events/syscalls/sys_enter_pwritev2/trigger events/syscalls/=
sys_enter_quotactl/trigger events/syscalls/sys_enter_quotactl_fd/trigger ev=
ents/syscalls/sys_enter_read/trigger events/syscalls/sys_enter_readahead/tr=
igger events/syscalls/sys_enter_readlink/trigger events/syscalls/sys_enter_=
readlinkat/trigger events/syscalls/sys_enter_readv/trigger events/syscalls/=
sys_enter_reboot/trigger events/syscalls/sys_enter_recvfrom/trigger events/=
syscalls/sys_enter_recvmmsg/trigger events/syscalls/sys_enter_recvmsg/trigg=
er events/syscalls/sys_enter_remap_file_pages/trigger events/syscalls/sys_e=
nter_removexattr/trigger events/syscalls/sys_enter_removexattrat/trigger ev=
ents/syscalls/sys_enter_rename/trigger events/syscalls/sys_enter_renameat/t=
rigger events/syscalls/sys_enter_renameat2/trigger events/syscalls/sys_ente=
r_request_key/trigger events/syscalls/sys_enter_restart_syscall/trigger eve=
nts/syscalls/sys_enter_rmdir/trigger events/syscalls/sys_enter_rseq/trigger=
 events/syscalls/sys_enter_rt_sigaction/trigger events/syscalls/sys_enter_r=
t_sigpending/trigger events/syscalls/sys_enter_rt_sigprocmask/trigger event=
s/syscalls/sys_enter_rt_sigqueueinfo/trigger events/syscalls/sys_enter_rt_s=
igreturn/trigger events/syscalls/sys_enter_rt_sigsuspend/trigger events/sys=
calls/sys_enter_rt_sigtimedwait/trigger events/syscalls/sys_enter_rt_tgsigq=
ueueinfo/trigger events/syscalls/sys_enter_sched_get_priority_max/trigger e=
vents/syscalls/sys_enter_sched_get_priority_min/trigger events/syscalls/sys=
_enter_sched_getaffinity/trigger events/syscalls/sys_enter_sched_getattr/tr=
igger events/syscalls/sys_enter_sched_getparam/trigger events/syscalls/sys_=
enter_sched_getscheduler/trigger events/syscalls/sys_enter_sched_rr_get_int=
erval/trigger events/syscalls/sys_enter_sched_setaffinity/trigger events/sy=
scalls/sys_enter_sched_setattr/trigger events/syscalls/sys_enter_sched_setp=
aram/trigger events/syscalls/sys_enter_sched_setscheduler/trigger events/sy=
scalls/sys_enter_sched_yield/trigger events/syscalls/sys_enter_seccomp/trig=
ger events/syscalls/sys_enter_select/trigger events/syscalls/sys_enter_semc=
tl/trigger events/syscalls/sys_enter_semget/trigger events/syscalls/sys_ent=
er_semop/trigger events/syscalls/sys_enter_semtimedop/trigger events/syscal=
ls/sys_enter_sendfile64/trigger events/syscalls/sys_enter_sendmmsg/trigger =
events/syscalls/sys_enter_sendmsg/trigger events/syscalls/sys_enter_sendto/=
trigger events/syscalls/sys_enter_set_mempolicy/trigger events/syscalls/sys=
_enter_set_mempolicy_home_node/trigger events/syscalls/sys_enter_set_robust=
_list/trigger events/syscalls/sys_enter_set_tid_address/trigger events/sysc=
alls/sys_enter_setdomainname/trigger events/syscalls/sys_enter_setfsgid/tri=
gger events/syscalls/sys_enter_setfsuid/trigger events/syscalls/sys_enter_s=
etgid/trigger events/syscalls/sys_enter_setgroups/trigger events/syscalls/s=
ys_enter_sethostname/trigger events/syscalls/sys_enter_setitimer/trigger ev=
ents/syscalls/sys_enter_setns/trigger events/syscalls/sys_enter_setpgid/tri=
gger events/syscalls/sys_enter_setpriority/trigger events/syscalls/sys_ente=
r_setregid/trigger events/syscalls/sys_enter_setresgid/trigger events/sysca=
lls/sys_enter_setresuid/trigger events/syscalls/sys_enter_setreuid/trigger =
events/syscalls/sys_enter_setrlimit/trigger events/syscalls/sys_enter_setsi=
d/trigger events/syscalls/sys_enter_setsockopt/trigger events/syscalls/sys_=
enter_settimeofday/trigger events/syscalls/sys_enter_setuid/trigger events/=
syscalls/sys_enter_setxattr/trigger events/syscalls/sys_enter_setxattrat/tr=
igger events/syscalls/sys_enter_shmat/trigger events/syscalls/sys_enter_shm=
ctl/trigger events/syscalls/sys_enter_shmdt/trigger events/syscalls/sys_ent=
er_shmget/trigger events/syscalls/sys_enter_shutdown/trigger events/syscall=
s/sys_enter_sigaltstack/trigger events/syscalls/sys_enter_signalfd/trigger =
events/syscalls/sys_enter_signalfd4/trigger events/syscalls/sys_enter_socke=
t/trigger events/syscalls/sys_enter_socketpair/trigger events/syscalls/sys_=
enter_splice/trigger events/syscalls/sys_enter_statfs/trigger events/syscal=
ls/sys_enter_statmount/trigger events/syscalls/sys_enter_statx/trigger even=
ts/syscalls/sys_enter_swapoff/trigger events/syscalls/sys_enter_swapon/trig=
ger events/syscalls/sys_enter_symlink/trigger events/syscalls/sys_enter_sym=
linkat/trigger events/syscalls/sys_enter_sync/trigger events/syscalls/sys_e=
nter_sync_file_range/trigger events/syscalls/sys_enter_syncfs/trigger event=
s/syscalls/sys_enter_sysfs/trigger events/syscalls/sys_enter_sysinfo/trigge=
r events/syscalls/sys_enter_syslog/trigger events/syscalls/sys_enter_tee/tr=
igger events/syscalls/sys_enter_tgkill/trigger events/syscalls/sys_enter_ti=
me/trigger events/syscalls/sys_enter_timer_create/trigger events/syscalls/s=
ys_enter_timer_delete/trigger events/syscalls/sys_enter_timer_getoverrun/tr=
igger events/syscalls/sys_enter_timer_gettime/trigger events/syscalls/sys_e=
nter_timer_settime/trigger events/syscalls/sys_enter_timerfd_create/trigger=
 events/syscalls/sys_enter_timerfd_gettime/trigger events/syscalls/sys_ente=
r_timerfd_settime/trigger events/syscalls/sys_enter_times/trigger events/sy=
scalls/sys_enter_tkill/trigger events/syscalls/sys_enter_truncate/trigger e=
vents/syscalls/sys_enter_umask/trigger events/syscalls/sys_enter_umount/tri=
gger events/syscalls/sys_enter_unlink/trigger events/syscalls/sys_enter_unl=
inkat/trigger events/syscalls/sys_enter_unshare/trigger events/syscalls/sys=
_enter_uprobe/trigger events/syscalls/sys_enter_uretprobe/trigger events/sy=
scalls/sys_enter_userfaultfd/trigger events/syscalls/sys_enter_ustat/trigge=
r events/syscalls/sys_enter_utime/trigger events/syscalls/sys_enter_utimens=
at/trigger events/syscalls/sys_enter_utimes/trigger events/syscalls/sys_ent=
er_vfork/trigger events/syscalls/sys_enter_vhangup/trigger events/syscalls/=
sys_enter_vmsplice/trigger events/syscalls/sys_enter_wait4/trigger events/s=
yscalls/sys_enter_waitid/trigger events/syscalls/sys_enter_write/trigger ev=
ents/syscalls/sys_enter_writev/trigger events/syscalls/sys_exit_accept/trig=
ger events/syscalls/sys_exit_accept4/trigger events/syscalls/sys_exit_acces=
s/trigger events/syscalls/sys_exit_acct/trigger events/syscalls/sys_exit_ad=
d_key/trigger events/syscalls/sys_exit_adjtimex/trigger events/syscalls/sys=
_exit_alarm/trigger events/syscalls/sys_exit_arch_prctl/trigger events/sysc=
alls/sys_exit_bind/trigger events/syscalls/sys_exit_bpf/trigger events/sysc=
alls/sys_exit_brk/trigger events/syscalls/sys_exit_cachestat/trigger events=
/syscalls/sys_exit_capget/trigger events/syscalls/sys_exit_capset/trigger e=
vents/syscalls/sys_exit_chdir/trigger events/syscalls/sys_exit_chmod/trigge=
r events/syscalls/sys_exit_chown/trigger events/syscalls/sys_exit_chroot/tr=
igger events/syscalls/sys_exit_clock_adjtime/trigger events/syscalls/sys_ex=
it_clock_getres/trigger events/syscalls/sys_exit_clock_gettime/trigger even=
ts/syscalls/sys_exit_clock_nanosleep/trigger events/syscalls/sys_exit_clock=
_settime/trigger events/syscalls/sys_exit_clone/trigger events/syscalls/sys=
_exit_clone3/trigger events/syscalls/sys_exit_close/trigger events/syscalls=
/sys_exit_close_range/trigger events/syscalls/sys_exit_connect/trigger even=
ts/syscalls/sys_exit_copy_file_range/trigger events/syscalls/sys_exit_creat=
/trigger events/syscalls/sys_exit_delete_module/trigger events/syscalls/sys=
_exit_dup/trigger events/syscalls/sys_exit_dup2/trigger events/syscalls/sys=
_exit_dup3/trigger events/syscalls/sys_exit_epoll_create/trigger events/sys=
calls/sys_exit_epoll_create1/trigger events/syscalls/sys_exit_epoll_ctl/tri=
gger events/syscalls/sys_exit_epoll_pwait/trigger events/syscalls/sys_exit_=
epoll_pwait2/trigger events/syscalls/sys_exit_epoll_wait/trigger events/sys=
calls/sys_exit_eventfd/trigger events/syscalls/sys_exit_eventfd2/trigger ev=
ents/syscalls/sys_exit_execve/trigger events/syscalls/sys_exit_execveat/tri=
gger events/syscalls/sys_exit_exit/trigger events/syscalls/sys_exit_exit_gr=
oup/trigger events/syscalls/sys_exit_faccessat/trigger events/syscalls/sys_=
exit_faccessat2/trigger events/syscalls/sys_exit_fadvise64/trigger events/s=
yscalls/sys_exit_fallocate/trigger events/syscalls/sys_exit_fanotify_init/t=
rigger events/syscalls/sys_exit_fanotify_mark/trigger events/syscalls/sys_e=
xit_fchdir/trigger events/syscalls/sys_exit_fchmod/trigger events/syscalls/=
sys_exit_fchmodat/trigger events/syscalls/sys_exit_fchmodat2/trigger events=
/syscalls/sys_exit_fchown/trigger events/syscalls/sys_exit_fchownat/trigger=
 events/syscalls/sys_exit_fcntl/trigger events/syscalls/sys_exit_fdatasync/=
trigger events/syscalls/sys_exit_fgetxattr/trigger events/syscalls/sys_exit=
_file_getattr/trigger events/syscalls/sys_exit_file_setattr/trigger events/=
syscalls/sys_exit_finit_module/trigger events/syscalls/sys_exit_flistxattr/=
trigger events/syscalls/sys_exit_flock/trigger events/syscalls/sys_exit_for=
k/trigger events/syscalls/sys_exit_fremovexattr/trigger events/syscalls/sys=
_exit_fsconfig/trigger events/syscalls/sys_exit_fsetxattr/trigger events/sy=
scalls/sys_exit_fsmount/trigger events/syscalls/sys_exit_fsopen/trigger eve=
nts/syscalls/sys_exit_fspick/trigger events/syscalls/sys_exit_fstatfs/trigg=
er events/syscalls/sys_exit_fsync/trigger events/syscalls/sys_exit_ftruncat=
e/trigger events/syscalls/sys_exit_futex/trigger events/syscalls/sys_exit_f=
utex_requeue/trigger events/syscalls/sys_exit_futex_wait/trigger events/sys=
calls/sys_exit_futex_waitv/trigger events/syscalls/sys_exit_futex_wake/trig=
ger events/syscalls/sys_exit_futimesat/trigger events/syscalls/sys_exit_get=
_mempolicy/trigger events/syscalls/sys_exit_get_robust_list/trigger events/=
syscalls/sys_exit_getcpu/trigger events/syscalls/sys_exit_getcwd/trigger ev=
ents/syscalls/sys_exit_getdents/trigger events/syscalls/sys_exit_getdents64=
/trigger events/syscalls/sys_exit_getegid/trigger events/syscalls/sys_exit_=
geteuid/trigger events/syscalls/sys_exit_getgid/trigger events/syscalls/sys=
_exit_getgroups/trigger events/syscalls/sys_exit_getitimer/trigger events/s=
yscalls/sys_exit_getpeername/trigger events/syscalls/sys_exit_getpgid/trigg=
er events/syscalls/sys_exit_getpgrp/trigger events/syscalls/sys_exit_getpid=
/trigger events/syscalls/sys_exit_getppid/trigger events/syscalls/sys_exit_=
getpriority/trigger events/syscalls/sys_exit_getrandom/trigger events/sysca=
lls/sys_exit_getresgid/trigger events/syscalls/sys_exit_getresuid/trigger e=
vents/syscalls/sys_exit_getrlimit/trigger events/syscalls/sys_exit_getrusag=
e/trigger events/syscalls/sys_exit_getsid/trigger events/syscalls/sys_exit_=
getsockname/trigger events/syscalls/sys_exit_getsockopt/trigger events/sysc=
alls/sys_exit_gettid/trigger events/syscalls/sys_exit_gettimeofday/trigger =
events/syscalls/sys_exit_getuid/trigger events/syscalls/sys_exit_getxattr/t=
rigger events/syscalls/sys_exit_getxattrat/trigger events/syscalls/sys_exit=
_init_module/trigger events/syscalls/sys_exit_inotify_add_watch/trigger eve=
nts/syscalls/sys_exit_inotify_init/trigger events/syscalls/sys_exit_inotify=
_init1/trigger events/syscalls/sys_exit_inotify_rm_watch/trigger events/sys=
calls/sys_exit_io_cancel/trigger events/syscalls/sys_exit_io_destroy/trigge=
r events/syscalls/sys_exit_io_getevents/trigger events/syscalls/sys_exit_io=
_pgetevents/trigger events/syscalls/sys_exit_io_setup/trigger events/syscal=
ls/sys_exit_io_submit/trigger events/syscalls/sys_exit_io_uring_enter/trigg=
er events/syscalls/sys_exit_io_uring_register/trigger events/syscalls/sys_e=
xit_io_uring_setup/trigger events/syscalls/sys_exit_ioctl/trigger events/sy=
scalls/sys_exit_ioperm/trigger events/syscalls/sys_exit_iopl/trigger events=
/syscalls/sys_exit_ioprio_get/trigger events/syscalls/sys_exit_ioprio_set/t=
rigger events/syscalls/sys_exit_kcmp/trigger events/syscalls/sys_exit_kexec=
_file_load/trigger events/syscalls/sys_exit_kexec_load/trigger events/sysca=
lls/sys_exit_keyctl/trigger events/syscalls/sys_exit_kill/trigger events/sy=
scalls/sys_exit_lchown/trigger events/syscalls/sys_exit_lgetxattr/trigger e=
vents/syscalls/sys_exit_link/trigger events/syscalls/sys_exit_linkat/trigge=
r events/syscalls/sys_exit_listen/trigger events/syscalls/sys_exit_listmoun=
t/trigger events/syscalls/sys_exit_listns/trigger events/syscalls/sys_exit_=
listxattr/trigger events/syscalls/sys_exit_listxattrat/trigger events/sysca=
lls/sys_exit_llistxattr/trigger events/syscalls/sys_exit_lremovexattr/trigg=
er events/syscalls/sys_exit_lseek/trigger events/syscalls/sys_exit_lsetxatt=
r/trigger events/syscalls/sys_exit_lsm_get_self_attr/trigger events/syscall=
s/sys_exit_lsm_list_modules/trigger events/syscalls/sys_exit_lsm_set_self_a=
ttr/trigger events/syscalls/sys_exit_madvise/trigger events/syscalls/sys_ex=
it_mbind/trigger events/syscalls/sys_exit_membarrier/trigger events/syscall=
s/sys_exit_memfd_create/trigger events/syscalls/sys_exit_memfd_secret/trigg=
er events/syscalls/sys_exit_migrate_pages/trigger events/syscalls/sys_exit_=
mincore/trigger events/syscalls/sys_exit_mkdir/trigger events/syscalls/sys_=
exit_mkdirat/trigger events/syscalls/sys_exit_mknod/trigger events/syscalls=
/sys_exit_mknodat/trigger events/syscalls/sys_exit_mlock/trigger events/sys=
calls/sys_exit_mlock2/trigger events/syscalls/sys_exit_mlockall/trigger eve=
nts/syscalls/sys_exit_mmap/trigger events/syscalls/sys_exit_modify_ldt/trig=
ger events/syscalls/sys_exit_mount/trigger events/syscalls/sys_exit_mount_s=
etattr/trigger events/syscalls/sys_exit_move_mount/trigger events/syscalls/=
sys_exit_move_pages/trigger events/syscalls/sys_exit_mprotect/trigger event=
s/syscalls/sys_exit_mq_getsetattr/trigger events/syscalls/sys_exit_mq_notif=
y/trigger events/syscalls/sys_exit_mq_open/trigger events/syscalls/sys_exit=
_mq_timedreceive/trigger events/syscalls/sys_exit_mq_timedsend/trigger even=
ts/syscalls/sys_exit_mq_unlink/trigger events/syscalls/sys_exit_mremap/trig=
ger events/syscalls/sys_exit_mseal/trigger events/syscalls/sys_exit_msgctl/=
trigger events/syscalls/sys_exit_msgget/trigger events/syscalls/sys_exit_ms=
grcv/trigger events/syscalls/sys_exit_msgsnd/trigger events/syscalls/sys_ex=
it_msync/trigger events/syscalls/sys_exit_munlock/trigger events/syscalls/s=
ys_exit_munlockall/trigger events/syscalls/sys_exit_munmap/trigger events/s=
yscalls/sys_exit_name_to_handle_at/trigger events/syscalls/sys_exit_nanosle=
ep/trigger events/syscalls/sys_exit_newfstat/trigger events/syscalls/sys_ex=
it_newfstatat/trigger events/syscalls/sys_exit_newlstat/trigger events/sysc=
alls/sys_exit_newstat/trigger events/syscalls/sys_exit_newuname/trigger eve=
nts/syscalls/sys_exit_open/trigger events/syscalls/sys_exit_open_by_handle_=
at/trigger events/syscalls/sys_exit_open_tree/trigger events/syscalls/sys_e=
xit_open_tree_attr/trigger events/syscalls/sys_exit_openat/trigger events/s=
yscalls/sys_exit_openat2/trigger events/syscalls/sys_exit_pause/trigger eve=
nts/syscalls/sys_exit_perf_event_open/trigger events/syscalls/sys_exit_pers=
onality/trigger events/syscalls/sys_exit_pidfd_getfd/trigger events/syscall=
s/sys_exit_pidfd_open/trigger events/syscalls/sys_exit_pidfd_send_signal/tr=
igger events/syscalls/sys_exit_pipe/trigger events/syscalls/sys_exit_pipe2/=
trigger events/syscalls/sys_exit_pivot_root/trigger events/syscalls/sys_exi=
t_pkey_alloc/trigger events/syscalls/sys_exit_pkey_free/trigger events/sysc=
alls/sys_exit_pkey_mprotect/trigger events/syscalls/sys_exit_poll/trigger e=
vents/syscalls/sys_exit_ppoll/trigger events/syscalls/sys_exit_prctl/trigge=
r events/syscalls/sys_exit_pread64/trigger events/syscalls/sys_exit_preadv/=
trigger events/syscalls/sys_exit_preadv2/trigger events/syscalls/sys_exit_p=
rlimit64/trigger events/syscalls/sys_exit_process_madvise/trigger events/sy=
scalls/sys_exit_process_mrelease/trigger events/syscalls/sys_exit_process_v=
m_readv/trigger events/syscalls/sys_exit_process_vm_writev/trigger events/s=
yscalls/sys_exit_pselect6/trigger events/syscalls/sys_exit_ptrace/trigger e=
vents/syscalls/sys_exit_pwrite64/trigger events/syscalls/sys_exit_pwritev/t=
rigger events/syscalls/sys_exit_pwritev2/trigger events/syscalls/sys_exit_q=
uotactl/trigger events/syscalls/sys_exit_quotactl_fd/trigger events/syscall=
s/sys_exit_read/trigger events/syscalls/sys_exit_readahead/trigger events/s=
yscalls/sys_exit_readlink/trigger events/syscalls/sys_exit_readlinkat/trigg=
er events/syscalls/sys_exit_readv/trigger events/syscalls/sys_exit_reboot/t=
rigger events/syscalls/sys_exit_recvfrom/trigger events/syscalls/sys_exit_r=
ecvmmsg/trigger events/syscalls/sys_exit_recvmsg/trigger events/syscalls/sy=
s_exit_remap_file_pages/trigger events/syscalls/sys_exit_removexattr/trigge=
r events/syscalls/sys_exit_removexattrat/trigger events/syscalls/sys_exit_r=
ename/trigger events/syscalls/sys_exit_renameat/trigger events/syscalls/sys=
_exit_renameat2/trigger events/syscalls/sys_exit_request_key/trigger events=
/syscalls/sys_exit_restart_syscall/trigger events/syscalls/sys_exit_rmdir/t=
rigger events/syscalls/sys_exit_rseq/trigger events/syscalls/sys_exit_rt_si=
gaction/trigger events/syscalls/sys_exit_rt_sigpending/trigger events/sysca=
lls/sys_exit_rt_sigprocmask/trigger events/syscalls/sys_exit_rt_sigqueueinf=
o/trigger events/syscalls/sys_exit_rt_sigreturn/trigger events/syscalls/sys=
_exit_rt_sigsuspend/trigger events/syscalls/sys_exit_rt_sigtimedwait/trigge=
r events/syscalls/sys_exit_rt_tgsigqueueinfo/trigger events/syscalls/sys_ex=
it_sched_get_priority_max/trigger events/syscalls/sys_exit_sched_get_priori=
ty_min/trigger events/syscalls/sys_exit_sched_getaffinity/trigger events/sy=
scalls/sys_exit_sched_getattr/trigger events/syscalls/sys_exit_sched_getpar=
am/trigger events/syscalls/sys_exit_sched_getscheduler/trigger events/sysca=
lls/sys_exit_sched_rr_get_interval/trigger events/syscalls/sys_exit_sched_s=
etaffinity/trigger events/syscalls/sys_exit_sched_setattr/trigger events/sy=
scalls/sys_exit_sched_setparam/trigger events/syscalls/sys_exit_sched_setsc=
heduler/trigger events/syscalls/sys_exit_sched_yield/trigger events/syscall=
s/sys_exit_seccomp/trigger events/syscalls/sys_exit_select/trigger events/s=
yscalls/sys_exit_semctl/trigger events/syscalls/sys_exit_semget/trigger eve=
nts/syscalls/sys_exit_semop/trigger events/syscalls/sys_exit_semtimedop/tri=
gger events/syscalls/sys_exit_sendfile64/trigger events/syscalls/sys_exit_s=
endmmsg/trigger events/syscalls/sys_exit_sendmsg/trigger events/syscalls/sy=
s_exit_sendto/trigger events/syscalls/sys_exit_set_mempolicy/trigger events=
/syscalls/sys_exit_set_mempolicy_home_node/trigger events/syscalls/sys_exit=
_set_robust_list/trigger events/syscalls/sys_exit_set_tid_address/trigger e=
vents/syscalls/sys_exit_setdomainname/trigger events/syscalls/sys_exit_setf=
sgid/trigger events/syscalls/sys_exit_setfsuid/trigger events/syscalls/sys_=
exit_setgid/trigger events/syscalls/sys_exit_setgroups/trigger events/sysca=
lls/sys_exit_sethostname/trigger events/syscalls/sys_exit_setitimer/trigger=
 events/syscalls/sys_exit_setns/trigger events/syscalls/sys_exit_setpgid/tr=
igger events/syscalls/sys_exit_setpriority/trigger events/syscalls/sys_exit=
_setregid/trigger events/syscalls/sys_exit_setresgid/trigger events/syscall=
s/sys_exit_setresuid/trigger events/syscalls/sys_exit_setreuid/trigger even=
ts/syscalls/sys_exit_setrlimit/trigger events/syscalls/sys_exit_setsid/trig=
ger events/syscalls/sys_exit_setsockopt/trigger events/syscalls/sys_exit_se=
ttimeofday/trigger events/syscalls/sys_exit_setuid/trigger events/syscalls/=
sys_exit_setxattr/trigger events/syscalls/sys_exit_setxattrat/trigger event=
s/syscalls/sys_exit_shmat/trigger events/syscalls/sys_exit_shmctl/trigger e=
vents/syscalls/sys_exit_shmdt/trigger events/syscalls/sys_exit_shmget/trigg=
er events/syscalls/sys_exit_shutdown/trigger events/syscalls/sys_exit_sigal=
tstack/trigger events/syscalls/sys_exit_signalfd/trigger events/syscalls/sy=
s_exit_signalfd4/trigger events/syscalls/sys_exit_socket/trigger events/sys=
calls/sys_exit_socketpair/trigger events/syscalls/sys_exit_splice/trigger e=
vents/syscalls/sys_exit_statfs/trigger events/syscalls/sys_exit_statmount/t=
rigger events/syscalls/sys_exit_statx/trigger events/syscalls/sys_exit_swap=
off/trigger events/syscalls/sys_exit_swapon/trigger events/syscalls/sys_exi=
t_symlink/trigger events/syscalls/sys_exit_symlinkat/trigger events/syscall=
s/sys_exit_sync/trigger events/syscalls/sys_exit_sync_file_range/trigger ev=
ents/syscalls/sys_exit_syncfs/trigger events/syscalls/sys_exit_sysfs/trigge=
r events/syscalls/sys_exit_sysinfo/trigger events/syscalls/sys_exit_syslog/=
trigger events/syscalls/sys_exit_tee/trigger events/syscalls/sys_exit_tgkil=
l/trigger events/syscalls/sys_exit_time/trigger events/syscalls/sys_exit_ti=
mer_create/trigger events/syscalls/sys_exit_timer_delete/trigger events/sys=
calls/sys_exit_timer_getoverrun/trigger events/syscalls/sys_exit_timer_gett=
ime/trigger events/syscalls/sys_exit_timer_settime/trigger events/syscalls/=
sys_exit_timerfd_create/trigger events/syscalls/sys_exit_timerfd_gettime/tr=
igger events/syscalls/sys_exit_timerfd_settime/trigger events/syscalls/sys_=
exit_times/trigger events/syscalls/sys_exit_tkill/trigger events/syscalls/s=
ys_exit_truncate/trigger events/syscalls/sys_exit_umask/trigger events/sysc=
alls/sys_exit_umount/trigger events/syscalls/sys_exit_unlink/trigger events=
/syscalls/sys_exit_unlinkat/trigger events/syscalls/sys_exit_unshare/trigge=
r events/syscalls/sys_exit_uprobe/trigger events/syscalls/sys_exit_uretprob=
e/trigger events/syscalls/sys_exit_userfaultfd/trigger events/syscalls/sys_=
exit_ustat/trigger events/syscalls/sys_exit_utime/trigger events/syscalls/s=
ys_exit_utimensat/trigger events/syscalls/sys_exit_utimes/trigger events/sy=
scalls/sys_exit_vfork/trigger events/syscalls/sys_exit_vhangup/trigger even=
ts/syscalls/sys_exit_vmsplice/trigger events/syscalls/sys_exit_wait4/trigge=
r events/syscalls/sys_exit_waitid/trigger events/syscalls/sys_exit_write/tr=
igger events/syscalls/sys_exit_writev/trigger events/task/task_newtask/trig=
ger events/task/task_prctl_unknown/trigger events/task/task_rename/trigger =
events/tcp/tcp_ao_handshake_failure/trigger events/tcp/tcp_ao_key_not_found=
/trigger events/tcp/tcp_ao_mismatch/trigger events/tcp/tcp_ao_rcv_sne_updat=
e/trigger events/tcp/tcp_ao_rnext_request/trigger events/tcp/tcp_ao_snd_sne=
_update/trigger events/tcp/tcp_ao_synack_no_key/trigger events/tcp/tcp_ao_w=
rong_maclen/trigger events/tcp/tcp_bad_csum/trigger events/tcp/tcp_cong_sta=
te_set/trigger events/tcp/tcp_destroy_sock/trigger events/tcp/tcp_hash_ao_r=
equired/trigger events/tcp/tcp_hash_bad_header/trigger events/tcp/tcp_hash_=
md5_mismatch/trigger events/tcp/tcp_hash_md5_required/trigger events/tcp/tc=
p_hash_md5_unexpected/trigger events/tcp/tcp_probe/trigger events/tcp/tcp_r=
cv_space_adjust/trigger events/tcp/tcp_rcvbuf_grow/trigger events/tcp/tcp_r=
eceive_reset/trigger events/tcp/tcp_retransmit_skb/trigger events/tcp/tcp_r=
etransmit_synack/trigger events/tcp/tcp_send_reset/trigger events/tcp/tcp_s=
endmsg_locked/trigger events/thermal/cdev_update/trigger events/thermal/the=
rmal_temperature/trigger events/thermal/thermal_zone_trip/trigger events/th=
p/remove_migration_pmd/trigger events/thp/set_migration_pmd/trigger events/=
thunderbolt/tb_event/trigger events/thunderbolt/tb_rx/trigger events/thunde=
rbolt/tb_tx/trigger events/timer/hrtimer_cancel/trigger events/timer/hrtime=
r_expire_entry/trigger events/timer/hrtimer_expire_exit/trigger events/time=
r/hrtimer_rearm/trigger events/timer/hrtimer_setup/trigger events/timer/hrt=
imer_start/trigger events/timer/hrtimer_start_expired/trigger events/timer/=
itimer_expire/trigger events/timer/itimer_state/trigger events/timer/tick_s=
top/trigger events/timer/timer_base_idle/trigger events/timer/timer_cancel/=
trigger events/timer/timer_expire_entry/trigger events/timer/timer_expire_e=
xit/trigger events/timer/timer_init/trigger events/timer/timer_start/trigge=
r events/timer_migration/tmigr_connect_child_parent/trigger events/timer_mi=
gration/tmigr_connect_cpu_parent/trigger events/timer_migration/tmigr_cpu_a=
ctive/trigger events/timer_migration/tmigr_cpu_available/trigger events/tim=
er_migration/tmigr_cpu_idle/trigger events/timer_migration/tmigr_cpu_new_ti=
mer/trigger events/timer_migration/tmigr_cpu_new_timer_idle/trigger events/=
timer_migration/tmigr_cpu_unavailable/trigger events/timer_migration/tmigr_=
group_set/trigger events/timer_migration/tmigr_group_set_cpu_active/trigger=
 events/timer_migration/tmigr_group_set_cpu_inactive/trigger events/timer_m=
igration/tmigr_handle_remote/trigger events/timer_migration/tmigr_handle_re=
mote_cpu/trigger events/timer_migration/tmigr_update_events/trigger events/=
timestamp/ctime_ns_xchg/trigger events/timestamp/ctime_xchg_skip/trigger ev=
ents/timestamp/fill_mg_cmtime/trigger events/timestamp/inode_set_ctime_to_t=
s/trigger events/tlb/tlb_flush/trigger events/tsm_mr/tsm_mr_read/trigger ev=
ents/tsm_mr/tsm_mr_refresh/trigger events/tsm_mr/tsm_mr_write/trigger event=
s/ucsi/ucsi_connector_change/trigger events/ucsi/ucsi_register_altmode/trig=
ger events/ucsi/ucsi_register_port/trigger events/ucsi/ucsi_reset_ppm/trigg=
er events/ucsi/ucsi_run_command/trigger events/udp/udp_fail_queue_rcv_skb/t=
rigger events/usbcore/usb_alloc_dev/trigger events/usbcore/usb_set_device_s=
tate/trigger events/vmalloc/alloc_vmap_area/trigger events/vmalloc/free_vma=
p_area_noflush/trigger events/vmalloc/purge_vmap_area_lazy/trigger events/v=
mscan/mm_shrink_slab_end/trigger events/vmscan/mm_shrink_slab_start/trigger=
 events/vmscan/mm_vmscan_balance_pgdat_begin/trigger events/vmscan/mm_vmsca=
n_balance_pgdat_end/trigger events/vmscan/mm_vmscan_direct_reclaim_begin/tr=
igger events/vmscan/mm_vmscan_direct_reclaim_end/trigger events/vmscan/mm_v=
mscan_kswapd_clear_hopeless/trigger events/vmscan/mm_vmscan_kswapd_reclaim_=
fail/trigger events/vmscan/mm_vmscan_kswapd_sleep/trigger events/vmscan/mm_=
vmscan_kswapd_wake/trigger events/vmscan/mm_vmscan_lru_isolate/trigger even=
ts/vmscan/mm_vmscan_lru_shrink_active/trigger events/vmscan/mm_vmscan_lru_s=
hrink_inactive/trigger events/vmscan/mm_vmscan_memcg_reclaim_begin/trigger =
events/vmscan/mm_vmscan_memcg_reclaim_end/trigger events/vmscan/mm_vmscan_m=
emcg_softlimit_reclaim_begin/trigger events/vmscan/mm_vmscan_memcg_softlimi=
t_reclaim_end/trigger events/vmscan/mm_vmscan_node_reclaim_begin/trigger ev=
ents/vmscan/mm_vmscan_node_reclaim_end/trigger events/vmscan/mm_vmscan_recl=
aim_pages/trigger events/vmscan/mm_vmscan_throttled/trigger events/vmscan/m=
m_vmscan_wakeup_kswapd/trigger events/vmscan/mm_vmscan_write_folio/trigger =
events/vsyscall/emulate_vsyscall/trigger events/watchdog/watchdog_ping/trig=
ger events/watchdog/watchdog_set_timeout/trigger events/watchdog/watchdog_s=
tart/trigger events/watchdog/watchdog_stop/trigger events/wbt/wbt_lat/trigg=
er events/wbt/wbt_stat/trigger events/wbt/wbt_step/trigger events/wbt/wbt_t=
imer/trigger events/workqueue/workqueue_activate_work/trigger events/workqu=
eue/workqueue_execute_end/trigger events/workqueue/workqueue_execute_start/=
trigger events/workqueue/workqueue_queue_work/trigger events/writeback/bala=
nce_dirty_pages/trigger events/writeback/bdi_dirty_ratelimit/trigger events=
/writeback/flush_foreign/trigger events/writeback/folio_wait_writeback/trig=
ger events/writeback/global_dirty_state/trigger events/writeback/inode_fore=
ign_history/trigger events/writeback/inode_switch_wbs/trigger events/writeb=
ack/inode_switch_wbs_queue/trigger events/writeback/sb_clear_inode_writebac=
k/trigger events/writeback/sb_mark_inode_writeback/trigger events/writeback=
/track_foreign_dirty/trigger events/writeback/wbc_writepage/trigger events/=
writeback/writeback_bdi_register/trigger events/writeback/writeback_dirty_f=
olio/trigger events/writeback/writeback_dirty_inode/trigger events/writebac=
k/writeback_dirty_inode_enqueue/trigger events/writeback/writeback_dirty_in=
ode_start/trigger events/writeback/writeback_exec/trigger events/writeback/=
writeback_lazytime/trigger events/writeback/writeback_mark_inode_dirty/trig=
ger events/writeback/writeback_pages_written/trigger events/writeback/write=
back_queue/trigger events/writeback/writeback_queue_io/trigger events/write=
back/writeback_sb_inodes_requeue/trigger events/writeback/writeback_single_=
inode/trigger events/writeback/writeback_single_inode_start/trigger events/=
writeback/writeback_start/trigger events/writeback/writeback_wait/trigger e=
vents/writeback/writeback_wake_background/trigger events/writeback/writebac=
k_write_inode/trigger events/writeback/writeback_write_inode_start/trigger =
events/writeback/writeback_written/trigger events/x86_fpu/x86_fpu_after_sav=
e/trigger events/x86_fpu/x86_fpu_before_save/trigger events/x86_fpu/x86_fpu=
_copy_dst/trigger events/x86_fpu/x86_fpu_dropped/trigger events/x86_fpu/x86=
_fpu_regs_activated/trigger events/x86_fpu/x86_fpu_regs_deactivated/trigger=
 events/x86_fpu/x86_fpu_xstate_check_failed/trigger events/xdp/bpf_xdp_link=
_attach_failed/trigger events/xdp/mem_connect/trigger events/xdp/mem_discon=
nect/trigger events/xdp/xdp_bulk_tx/trigger events/xdp/xdp_cpumap_enqueue/t=
rigger events/xdp/xdp_cpumap_kthread/trigger events/xdp/xdp_devmap_xmit/tri=
gger events/xdp/xdp_exception/trigger events/xdp/xdp_redirect/trigger event=
s/xdp/xdp_redirect_err/trigger events/xen/xen_cpu_load_idt/trigger events/x=
en/xen_cpu_set_ldt/trigger events/xen/xen_cpu_write_gdt_entry/trigger event=
s/xen/xen_cpu_write_idt_entry/trigger events/xen/xen_cpu_write_ldt_entry/tr=
igger events/xen/xen_mc_batch/trigger events/xen/xen_mc_callback/trigger ev=
ents/xen/xen_mc_entry/trigger events/xen/xen_mc_entry_alloc/trigger events/=
xen/xen_mc_extend_args/trigger events/xen/xen_mc_flush/trigger events/xen/x=
en_mc_flush_reason/trigger events/xen/xen_mc_issue/trigger events/xen/xen_m=
mu_alloc_ptpage/trigger events/xen/xen_mmu_flush_tlb_multi/trigger events/x=
en/xen_mmu_flush_tlb_one_user/trigger events/xen/xen_mmu_pgd_pin/trigger ev=
ents/xen/xen_mmu_pgd_unpin/trigger events/xen/xen_mmu_ptep_modify_prot_comm=
it/trigger events/xen/xen_mmu_ptep_modify_prot_start/trigger events/xen/xen=
_mmu_release_ptpage/trigger events/xen/xen_mmu_set_p4d/trigger events/xen/x=
en_mmu_set_pmd/trigger events/xen/xen_mmu_set_pte/trigger events/xen/xen_mm=
u_set_pud/trigger events/xen/xen_mmu_write_cr3/trigger events/xhci-hcd/xhci=
_add_endpoint/trigger events/xhci-hcd/xhci_address_ctrl_ctx/trigger events/=
xhci-hcd/xhci_address_ctx/trigger events/xhci-hcd/xhci_alloc_dev/trigger ev=
ents/xhci-hcd/xhci_alloc_stream_info_ctx/trigger events/xhci-hcd/xhci_alloc=
_virt_device/trigger events/xhci-hcd/xhci_configure_endpoint/trigger events=
/xhci-hcd/xhci_configure_endpoint_ctrl_ctx/trigger events/xhci-hcd/xhci_dbc=
_alloc_request/trigger events/xhci-hcd/xhci_dbc_free_request/trigger events=
/xhci-hcd/xhci_dbc_gadget_ep_queue/trigger events/xhci-hcd/xhci_dbc_givebac=
k_request/trigger events/xhci-hcd/xhci_dbc_handle_event/trigger events/xhci=
-hcd/xhci_dbc_handle_transfer/trigger events/xhci-hcd/xhci_dbc_queue_reques=
t/trigger events/xhci-hcd/xhci_dbg_address/trigger events/xhci-hcd/xhci_dbg=
_cancel_urb/trigger events/xhci-hcd/xhci_dbg_context_change/trigger events/=
xhci-hcd/xhci_dbg_init/trigger events/xhci-hcd/xhci_dbg_quirks/trigger even=
ts/xhci-hcd/xhci_dbg_reset_ep/trigger events/xhci-hcd/xhci_dbg_ring_expansi=
on/trigger events/xhci-hcd/xhci_discover_or_reset_device/trigger events/xhc=
i-hcd/xhci_free_dev/trigger events/xhci-hcd/xhci_free_virt_device/trigger e=
vents/xhci-hcd/xhci_get_port_status/trigger events/xhci-hcd/xhci_handle_cmd=
_addr_dev/trigger events/xhci-hcd/xhci_handle_cmd_config_ep/trigger events/=
xhci-hcd/xhci_handle_cmd_disable_slot/trigger events/xhci-hcd/xhci_handle_c=
md_reset_dev/trigger events/xhci-hcd/xhci_handle_cmd_reset_ep/trigger event=
s/xhci-hcd/xhci_handle_cmd_set_deq/trigger events/xhci-hcd/xhci_handle_cmd_=
set_deq_ep/trigger events/xhci-hcd/xhci_handle_cmd_set_deq_stream/trigger e=
vents/xhci-hcd/xhci_handle_cmd_stop_ep/trigger events/xhci-hcd/xhci_handle_=
command/trigger events/xhci-hcd/xhci_handle_event/trigger events/xhci-hcd/x=
hci_handle_port_status/trigger events/xhci-hcd/xhci_handle_transfer/trigger=
 events/xhci-hcd/xhci_hub_status_data/trigger events/xhci-hcd/xhci_inc_deq/=
trigger events/xhci-hcd/xhci_inc_enq/trigger events/xhci-hcd/xhci_portsc_wr=
itel/trigger events/xhci-hcd/xhci_queue_trb/trigger events/xhci-hcd/xhci_ri=
ng_alloc/trigger events/xhci-hcd/xhci_ring_ep_doorbell/trigger events/xhci-=
hcd/xhci_ring_expansion/trigger events/xhci-hcd/xhci_ring_free/trigger even=
ts/xhci-hcd/xhci_ring_host_doorbell/trigger events/xhci-hcd/xhci_setup_addr=
essable_virt_device/trigger events/xhci-hcd/xhci_setup_device/trigger event=
s/xhci-hcd/xhci_setup_device_slot/trigger events/xhci-hcd/xhci_stop_device/=
trigger events/xhci-hcd/xhci_urb_dequeue/trigger events/xhci-hcd/xhci_urb_e=
nqueue/trigger events/xhci-hcd/xhci_urb_giveback/trigger
# # + reset_events_filter
# # + read line
# # + grep -v '^none' events/9p/9p_client_req/filter events/9p/9p_client_re=
s/filter events/9p/9p_fid_ref/filter events/9p/9p_protocol_dump/filter even=
ts/alarmtimer/alarmtimer_cancel/filter events/alarmtimer/alarmtimer_fired/f=
ilter events/alarmtimer/alarmtimer_start/filter events/alarmtimer/alarmtime=
r_suspend/filter events/amd_cpu/amd_pstate_cppc_req2/filter events/amd_cpu/=
amd_pstate_epp_perf/filter events/amd_cpu/amd_pstate_perf/filter events/aso=
c/snd_soc_bias_level_done/filter events/asoc/snd_soc_bias_level_start/filte=
r events/asoc/snd_soc_dapm_connected/filter events/asoc/snd_soc_dapm_done/f=
ilter events/asoc/snd_soc_dapm_path/filter events/asoc/snd_soc_dapm_start/f=
ilter events/asoc/snd_soc_dapm_walk_done/filter events/asoc/snd_soc_dapm_wi=
dget_event_done/filter events/asoc/snd_soc_dapm_widget_event_start/filter e=
vents/asoc/snd_soc_dapm_widget_power/filter events/asoc/snd_soc_jack_irq/fi=
lter events/asoc/snd_soc_jack_notify/filter events/asoc/snd_soc_jack_report=
/filter events/avc/selinux_audited/filter events/block/blk_zone_append_upda=
te_request_bio/filter events/block/blk_zone_wplug_bio/filter events/block/b=
lkdev_zone_mgmt/filter events/block/block_bio_backmerge/filter events/block=
/block_bio_complete/filter events/block/block_bio_frontmerge/filter events/=
block/block_bio_queue/filter events/block/block_bio_remap/filter events/blo=
ck/block_dirty_buffer/filter events/block/block_getrq/filter events/block/b=
lock_io_done/filter events/block/block_io_start/filter events/block/block_p=
lug/filter events/block/block_rq_complete/filter events/block/block_rq_erro=
r/filter events/block/block_rq_insert/filter events/block/block_rq_issue/fi=
lter events/block/block_rq_merge/filter events/block/block_rq_remap/filter =
events/block/block_rq_requeue/filter events/block/block_rq_tag_wait/filter =
events/block/block_split/filter events/block/block_touch_buffer/filter even=
ts/block/block_unplug/filter events/block/disk_zone_wplug_add_bio/filter ev=
ents/bpf_test_run/bpf_test_finish/filter events/bpf_test_run/bpf_trigger_tp=
/filter events/bpf_trace/bpf_trace_printk/filter events/bridge/br_fdb_add/f=
ilter events/bridge/br_fdb_external_learn_add/filter events/bridge/br_fdb_u=
pdate/filter events/bridge/br_mdb_full/filter events/bridge/fdb_delete/filt=
er events/btrfs/add_delayed_data_ref/filter events/btrfs/add_delayed_ref_he=
ad/filter events/btrfs/add_delayed_tree_ref/filter events/btrfs/btrfs_add_b=
lock_group/filter events/btrfs/btrfs_add_conflicting_inode_enter/filter eve=
nts/btrfs/btrfs_add_conflicting_inode_exit/filter events/btrfs/btrfs_add_re=
claim_block_group/filter events/btrfs/btrfs_add_unused_block_group/filter e=
vents/btrfs/btrfs_all_work_done/filter events/btrfs/btrfs_alloc_extent_stat=
e/filter events/btrfs/btrfs_chunk_alloc/filter events/btrfs/btrfs_chunk_fre=
e/filter events/btrfs/btrfs_clear_extent_bit/filter events/btrfs/btrfs_conv=
ert_extent_bit/filter events/btrfs/btrfs_cow_block/filter events/btrfs/btrf=
s_done_preemptive_reclaim/filter events/btrfs/btrfs_extent_map_shrinker_cou=
nt/filter events/btrfs/btrfs_extent_map_shrinker_remove_em/filter events/bt=
rfs/btrfs_extent_map_shrinker_scan_enter/filter events/btrfs/btrfs_extent_m=
ap_shrinker_scan_exit/filter events/btrfs/btrfs_fail_all_tickets/filter eve=
nts/btrfs/btrfs_failed_cluster_setup/filter events/btrfs/btrfs_find_cluster=
/filter events/btrfs/btrfs_find_free_extent/filter events/btrfs/btrfs_find_=
free_extent_have_block_group/filter events/btrfs/btrfs_find_free_extent_sea=
rch_loop/filter events/btrfs/btrfs_finish_ordered_extent/filter events/btrf=
s/btrfs_flush_space/filter events/btrfs/btrfs_free_extent_state/filter even=
ts/btrfs/btrfs_get_extent/filter events/btrfs/btrfs_get_extent_show_fi_inli=
ne/filter events/btrfs/btrfs_get_extent_show_fi_regular/filter events/btrfs=
/btrfs_get_raid_extent_offset/filter events/btrfs/btrfs_handle_em_exist/fil=
ter events/btrfs/btrfs_inode_evict/filter events/btrfs/btrfs_inode_mod_outs=
tanding_extents/filter events/btrfs/btrfs_inode_new/filter events/btrfs/btr=
fs_inode_request/filter events/btrfs/btrfs_insert_one_raid_extent/filter ev=
ents/btrfs/btrfs_log_all_new_ancestors_enter/filter events/btrfs/btrfs_log_=
all_new_ancestors_exit/filter events/btrfs/btrfs_log_all_parents_enter/filt=
er events/btrfs/btrfs_log_all_parents_exit/filter events/btrfs/btrfs_log_co=
nflicting_inodes_enter/filter events/btrfs/btrfs_log_conflicting_inodes_exi=
t/filter events/btrfs/btrfs_log_inode_enter/filter events/btrfs/btrfs_log_i=
node_exit/filter events/btrfs/btrfs_log_inode_parent_enter/filter events/bt=
rfs/btrfs_log_inode_parent_exit/filter events/btrfs/btrfs_log_new_delayed_d=
entries_enter/filter events/btrfs/btrfs_log_new_delayed_dentries_exit/filte=
r events/btrfs/btrfs_log_new_dir_dentries_enter/filter events/btrfs/btrfs_l=
og_new_dir_dentries_exit/filter events/btrfs/btrfs_log_new_name_enter/filte=
r events/btrfs/btrfs_log_new_name_exit/filter events/btrfs/btrfs_ordered_ex=
tent_add/filter events/btrfs/btrfs_ordered_extent_dec_test_pending/filter e=
vents/btrfs/btrfs_ordered_extent_lookup/filter events/btrfs/btrfs_ordered_e=
xtent_lookup_first/filter events/btrfs/btrfs_ordered_extent_lookup_first_ra=
nge/filter events/btrfs/btrfs_ordered_extent_lookup_for_logging/filter even=
ts/btrfs/btrfs_ordered_extent_lookup_range/filter events/btrfs/btrfs_ordere=
d_extent_mark_finished/filter events/btrfs/btrfs_ordered_extent_put/filter =
events/btrfs/btrfs_ordered_extent_remove/filter events/btrfs/btrfs_ordered_=
extent_split/filter events/btrfs/btrfs_ordered_extent_start/filter events/b=
trfs/btrfs_ordered_sched/filter events/btrfs/btrfs_prelim_ref_insert/filter=
 events/btrfs/btrfs_prelim_ref_merge/filter events/btrfs/btrfs_qgroup_accou=
nt_extent/filter events/btrfs/btrfs_qgroup_account_extents/filter events/bt=
rfs/btrfs_qgroup_meta_convert/filter events/btrfs/btrfs_qgroup_meta_free_al=
l_pertrans/filter events/btrfs/btrfs_qgroup_meta_reserve/filter events/btrf=
s/btrfs_qgroup_num_dirty_extents/filter events/btrfs/btrfs_qgroup_release_d=
ata/filter events/btrfs/btrfs_qgroup_reserve_data/filter events/btrfs/btrfs=
_qgroup_trace_extent/filter events/btrfs/btrfs_qgroup_update_counters/filte=
r events/btrfs/btrfs_qgroup_update_reserve/filter events/btrfs/btrfs_raid_e=
xtent_delete/filter events/btrfs/btrfs_reclaim_block_group/filter events/bt=
rfs/btrfs_record_new_subvolume/filter events/btrfs/btrfs_record_snapshot_de=
stroy/filter events/btrfs/btrfs_record_unlink_dir/filter events/btrfs/btrfs=
_remove_block_group/filter events/btrfs/btrfs_reserve_extent/filter events/=
btrfs/btrfs_reserve_extent_cluster/filter events/btrfs/btrfs_reserve_ticket=
/filter events/btrfs/btrfs_reserved_extent_alloc/filter events/btrfs/btrfs_=
reserved_extent_free/filter events/btrfs/btrfs_search_slot_restart/filter e=
vents/btrfs/btrfs_set_extent_bit/filter events/btrfs/btrfs_setup_cluster/fi=
lter events/btrfs/btrfs_skip_unused_block_group/filter events/btrfs/btrfs_s=
pace_reservation/filter events/btrfs/btrfs_sync_file_enter/filter events/bt=
rfs/btrfs_sync_file_exit/filter events/btrfs/btrfs_sync_fs/filter events/bt=
rfs/btrfs_sync_log_enter/filter events/btrfs/btrfs_sync_log_exit/filter eve=
nts/btrfs/btrfs_transaction_abort/filter events/btrfs/btrfs_transaction_com=
mit/filter events/btrfs/btrfs_transaction_start/filter events/btrfs/btrfs_t=
ree_lock/filter events/btrfs/btrfs_tree_read_lock/filter events/btrfs/btrfs=
_tree_read_unlock/filter events/btrfs/btrfs_tree_unlock/filter events/btrfs=
/btrfs_trigger_flush/filter events/btrfs/btrfs_truncate_show_fi_inline/filt=
er events/btrfs/btrfs_truncate_show_fi_regular/filter events/btrfs/btrfs_tr=
y_tree_read_lock/filter events/btrfs/btrfs_work_queued/filter events/btrfs/=
btrfs_work_sched/filter events/btrfs/btrfs_workqueue_alloc/filter events/bt=
rfs/btrfs_workqueue_destroy/filter events/btrfs/btrfs_writepage_end_io_hook=
/filter events/btrfs/extent_writepage/filter events/btrfs/raid56_read/filte=
r events/btrfs/raid56_write/filter events/btrfs/run_delayed_data_ref/filter=
 events/btrfs/run_delayed_ref_head/filter events/btrfs/run_delayed_tree_ref=
/filter events/btrfs/update_bytes_may_use/filter events/btrfs/update_bytes_=
pinned/filter events/btrfs/update_bytes_zone_unusable/filter events/capabil=
ity/cap_capable/filter events/cfg80211/cfg80211_assoc_comeback/filter event=
s/cfg80211/cfg80211_bss_color_notify/filter events/cfg80211/cfg80211_cac_ev=
ent/filter events/cfg80211/cfg80211_ch_switch_notify/filter events/cfg80211=
/cfg80211_ch_switch_started_notify/filter events/cfg80211/cfg80211_control_=
port_tx_status/filter events/cfg80211/cfg80211_cqm_pktloss_notify/filter ev=
ents/cfg80211/cfg80211_cqm_rssi_notify/filter events/cfg80211/cfg80211_del_=
sta/filter events/cfg80211/cfg80211_epcs_changed/filter events/cfg80211/cfg=
80211_ft_event/filter events/cfg80211/cfg80211_get_bss/filter events/cfg802=
11/cfg80211_gtk_rekey_notify/filter events/cfg80211/cfg80211_ibss_joined/fi=
lter events/cfg80211/cfg80211_incumbent_signal_notify/filter events/cfg8021=
1/cfg80211_inform_bss_frame/filter events/cfg80211/cfg80211_links_removed/f=
ilter events/cfg80211/cfg80211_mgmt_tx_status/filter events/cfg80211/cfg802=
11_michael_mic_failure/filter events/cfg80211/cfg80211_mlo_reconf_add_done/=
filter events/cfg80211/cfg80211_nan_channel_evac/filter events/cfg80211/cfg=
80211_nan_cluster_joined/filter events/cfg80211/cfg80211_nan_sched_update_d=
one/filter events/cfg80211/cfg80211_nan_ulw_update/filter events/cfg80211/c=
fg80211_new_sta/filter events/cfg80211/cfg80211_next_nan_dw_notif/filter ev=
ents/cfg80211/cfg80211_notify_new_peer_candidate/filter events/cfg80211/cfg=
80211_pmksa_candidate_notify/filter events/cfg80211/cfg80211_pmsr_complete/=
filter events/cfg80211/cfg80211_pmsr_report/filter events/cfg80211/cfg80211=
_probe_status/filter events/cfg80211/cfg80211_radar_event/filter events/cfg=
80211/cfg80211_ready_on_channel/filter events/cfg80211/cfg80211_ready_on_ch=
annel_expired/filter events/cfg80211/cfg80211_reg_can_beacon/filter events/=
cfg80211/cfg80211_report_obss_beacon/filter events/cfg80211/cfg80211_report=
_wowlan_wakeup/filter events/cfg80211/cfg80211_return_bool/filter events/cf=
g80211/cfg80211_return_bss/filter events/cfg80211/cfg80211_rx_control_port/=
filter events/cfg80211/cfg80211_rx_mgmt/filter events/cfg80211/cfg80211_rx_=
mlme_mgmt/filter events/cfg80211/cfg80211_rx_spurious_frame/filter events/c=
fg80211/cfg80211_rx_unexpected_4addr_frame/filter events/cfg80211/cfg80211_=
rx_unprot_mlme_mgmt/filter events/cfg80211/cfg80211_scan_done/filter events=
/cfg80211/cfg80211_sched_scan_results/filter events/cfg80211/cfg80211_sched=
_scan_stopped/filter events/cfg80211/cfg80211_send_assoc_failure/filter eve=
nts/cfg80211/cfg80211_send_auth_timeout/filter events/cfg80211/cfg80211_sen=
d_rx_assoc/filter events/cfg80211/cfg80211_stop_link/filter events/cfg80211=
/cfg80211_tdls_oper_request/filter events/cfg80211/cfg80211_tx_mgmt_expired=
/filter events/cfg80211/cfg80211_tx_mlme_mgmt/filter events/cfg80211/cfg802=
11_update_owe_info_event/filter events/cfg80211/rdev_abort_pmsr/filter even=
ts/cfg80211/rdev_abort_scan/filter events/cfg80211/rdev_add_intf_link/filte=
r events/cfg80211/rdev_add_key/filter events/cfg80211/rdev_add_link_station=
/filter events/cfg80211/rdev_add_mpath/filter events/cfg80211/rdev_add_nan_=
func/filter events/cfg80211/rdev_add_station/filter events/cfg80211/rdev_ad=
d_tx_ts/filter events/cfg80211/rdev_add_virtual_intf/filter events/cfg80211=
/rdev_assoc/filter events/cfg80211/rdev_assoc_ml_reconf/filter events/cfg80=
211/rdev_auth/filter events/cfg80211/rdev_cancel_remain_on_channel/filter e=
vents/cfg80211/rdev_change_beacon/filter events/cfg80211/rdev_change_bss/fi=
lter events/cfg80211/rdev_change_mpath/filter events/cfg80211/rdev_change_s=
tation/filter events/cfg80211/rdev_change_virtual_intf/filter events/cfg802=
11/rdev_channel_switch/filter events/cfg80211/rdev_color_change/filter even=
ts/cfg80211/rdev_connect/filter events/cfg80211/rdev_crit_proto_start/filte=
r events/cfg80211/rdev_crit_proto_stop/filter events/cfg80211/rdev_deauth/f=
ilter events/cfg80211/rdev_del_intf_link/filter events/cfg80211/rdev_del_ke=
y/filter events/cfg80211/rdev_del_link_station/filter events/cfg80211/rdev_=
del_mpath/filter events/cfg80211/rdev_del_nan_func/filter events/cfg80211/r=
dev_del_pmk/filter events/cfg80211/rdev_del_pmksa/filter events/cfg80211/rd=
ev_del_station/filter events/cfg80211/rdev_del_tx_ts/filter events/cfg80211=
/rdev_del_virtual_intf/filter events/cfg80211/rdev_disassoc/filter events/c=
fg80211/rdev_disconnect/filter events/cfg80211/rdev_dump_mpath/filter event=
s/cfg80211/rdev_dump_mpp/filter events/cfg80211/rdev_dump_station/filter ev=
ents/cfg80211/rdev_dump_survey/filter events/cfg80211/rdev_end_cac/filter e=
vents/cfg80211/rdev_external_auth/filter events/cfg80211/rdev_flush_pmksa/f=
ilter events/cfg80211/rdev_get_antenna/filter events/cfg80211/rdev_get_chan=
nel/filter events/cfg80211/rdev_get_ftm_responder_stats/filter events/cfg80=
211/rdev_get_key/filter events/cfg80211/rdev_get_mesh_config/filter events/=
cfg80211/rdev_get_mpath/filter events/cfg80211/rdev_get_mpp/filter events/c=
fg80211/rdev_get_station/filter events/cfg80211/rdev_get_tx_power/filter ev=
ents/cfg80211/rdev_get_txq_stats/filter events/cfg80211/rdev_inform_bss/fil=
ter events/cfg80211/rdev_join_ibss/filter events/cfg80211/rdev_join_mesh/fi=
lter events/cfg80211/rdev_join_ocb/filter events/cfg80211/rdev_leave_ibss/f=
ilter events/cfg80211/rdev_leave_mesh/filter events/cfg80211/rdev_leave_ocb=
/filter events/cfg80211/rdev_libertas_set_mesh_channel/filter events/cfg802=
11/rdev_mgmt_tx/filter events/cfg80211/rdev_mgmt_tx_cancel_wait/filter even=
ts/cfg80211/rdev_mod_link_station/filter events/cfg80211/rdev_nan_change_co=
nf/filter events/cfg80211/rdev_nan_set_local_sched/filter events/cfg80211/r=
dev_nan_set_peer_sched/filter events/cfg80211/rdev_probe_client/filter even=
ts/cfg80211/rdev_probe_mesh_link/filter events/cfg80211/rdev_remain_on_chan=
nel/filter events/cfg80211/rdev_reset_tid_config/filter events/cfg80211/rde=
v_resume/filter events/cfg80211/rdev_return_chandef/filter events/cfg80211/=
rdev_return_int/filter events/cfg80211/rdev_return_int_cookie/filter events=
/cfg80211/rdev_return_int_int/filter events/cfg80211/rdev_return_int_mesh_c=
onfig/filter events/cfg80211/rdev_return_int_mpath_info/filter events/cfg80=
211/rdev_return_int_station_info/filter events/cfg80211/rdev_return_int_sur=
vey_info/filter events/cfg80211/rdev_return_int_tx_rx/filter events/cfg8021=
1/rdev_return_void/filter events/cfg80211/rdev_return_void_tx_rx/filter eve=
nts/cfg80211/rdev_return_wdev/filter events/cfg80211/rdev_rfkill_poll/filte=
r events/cfg80211/rdev_scan/filter events/cfg80211/rdev_sched_scan_start/fi=
lter events/cfg80211/rdev_sched_scan_stop/filter events/cfg80211/rdev_set_a=
ntenna/filter events/cfg80211/rdev_set_ap_chanwidth/filter events/cfg80211/=
rdev_set_bitrate_mask/filter events/cfg80211/rdev_set_coalesce/filter event=
s/cfg80211/rdev_set_cqm_rssi_config/filter events/cfg80211/rdev_set_cqm_rss=
i_range_config/filter events/cfg80211/rdev_set_cqm_txe_config/filter events=
/cfg80211/rdev_set_default_beacon_key/filter events/cfg80211/rdev_set_defau=
lt_key/filter events/cfg80211/rdev_set_default_mgmt_key/filter events/cfg80=
211/rdev_set_epcs/filter events/cfg80211/rdev_set_fils_aad/filter events/cf=
g80211/rdev_set_hw_timestamp/filter events/cfg80211/rdev_set_mac_acl/filter=
 events/cfg80211/rdev_set_mcast_rate/filter events/cfg80211/rdev_set_monito=
r_channel/filter events/cfg80211/rdev_set_multicast_to_unicast/filter event=
s/cfg80211/rdev_set_noack_map/filter events/cfg80211/rdev_set_pmk/filter ev=
ents/cfg80211/rdev_set_pmksa/filter events/cfg80211/rdev_set_power_mgmt/fil=
ter events/cfg80211/rdev_set_qos_map/filter events/cfg80211/rdev_set_radar_=
background/filter events/cfg80211/rdev_set_rekey_data/filter events/cfg8021=
1/rdev_set_sar_specs/filter events/cfg80211/rdev_set_tid_config/filter even=
ts/cfg80211/rdev_set_ttlm/filter events/cfg80211/rdev_set_tx_power/filter e=
vents/cfg80211/rdev_set_txq_params/filter events/cfg80211/rdev_set_wakeup/f=
ilter events/cfg80211/rdev_set_wiphy_params/filter events/cfg80211/rdev_sta=
rt_ap/filter events/cfg80211/rdev_start_nan/filter events/cfg80211/rdev_sta=
rt_p2p_device/filter events/cfg80211/rdev_start_pd/filter events/cfg80211/r=
dev_start_pmsr/filter events/cfg80211/rdev_start_radar_detection/filter eve=
nts/cfg80211/rdev_stop_ap/filter events/cfg80211/rdev_stop_nan/filter event=
s/cfg80211/rdev_stop_p2p_device/filter events/cfg80211/rdev_stop_pd/filter =
events/cfg80211/rdev_suspend/filter events/cfg80211/rdev_tdls_cancel_channe=
l_switch/filter events/cfg80211/rdev_tdls_channel_switch/filter events/cfg8=
0211/rdev_tdls_mgmt/filter events/cfg80211/rdev_tdls_oper/filter events/cfg=
80211/rdev_tx_control_port/filter events/cfg80211/rdev_update_connect_param=
s/filter events/cfg80211/rdev_update_ft_ies/filter events/cfg80211/rdev_upd=
ate_mesh_config/filter events/cfg80211/rdev_update_mgmt_frame_registrations=
/filter events/cfg80211/rdev_update_owe_info/filter events/cfg80211/wiphy_d=
elayed_work_queue/filter events/cfg80211/wiphy_hrtimer_work_queue/filter ev=
ents/cfg80211/wiphy_work_cancel/filter events/cfg80211/wiphy_work_flush/fil=
ter events/cfg80211/wiphy_work_queue/filter events/cfg80211/wiphy_work_run/=
filter events/cfg80211/wiphy_work_worker_start/filter events/cgroup/cgroup_=
attach_task/filter events/cgroup/cgroup_destroy_root/filter events/cgroup/c=
group_freeze/filter events/cgroup/cgroup_mkdir/filter events/cgroup/cgroup_=
notify_frozen/filter events/cgroup/cgroup_notify_populated/filter events/cg=
roup/cgroup_release/filter events/cgroup/cgroup_remount/filter events/cgrou=
p/cgroup_rename/filter events/cgroup/cgroup_rmdir/filter events/cgroup/cgro=
up_rstat_lock_contended/filter events/cgroup/cgroup_rstat_locked/filter eve=
nts/cgroup/cgroup_rstat_unlock/filter events/cgroup/cgroup_setup_root/filte=
r events/cgroup/cgroup_transfer_tasks/filter events/cgroup/cgroup_unfreeze/=
filter events/clk/clk_disable/filter events/clk/clk_disable_complete/filter=
 events/clk/clk_enable/filter events/clk/clk_enable_complete/filter events/=
clk/clk_prepare/filter events/clk/clk_prepare_complete/filter events/clk/cl=
k_rate_request_done/filter events/clk/clk_rate_request_start/filter events/=
clk/clk_set_duty_cycle/filter events/clk/clk_set_duty_cycle_complete/filter=
 events/clk/clk_set_max_rate/filter events/clk/clk_set_min_rate/filter even=
ts/clk/clk_set_parent/filter events/clk/clk_set_parent_complete/filter even=
ts/clk/clk_set_phase/filter events/clk/clk_set_phase_complete/filter events=
/clk/clk_set_rate/filter events/clk/clk_set_rate_complete/filter events/clk=
/clk_set_rate_range/filter events/clk/clk_unprepare/filter events/clk/clk_u=
nprepare_complete/filter events/cma/cma_alloc_busy_retry/filter events/cma/=
cma_alloc_finish/filter events/cma/cma_alloc_start/filter events/cma/cma_re=
lease/filter events/compaction/mm_compaction_begin/filter events/compaction=
/mm_compaction_defer_compaction/filter events/compaction/mm_compaction_defe=
r_reset/filter events/compaction/mm_compaction_deferred/filter events/compa=
ction/mm_compaction_end/filter events/compaction/mm_compaction_fast_isolate=
_freepages/filter events/compaction/mm_compaction_finished/filter events/co=
mpaction/mm_compaction_isolate_freepages/filter events/compaction/mm_compac=
tion_isolate_migratepages/filter events/compaction/mm_compaction_kcompactd_=
sleep/filter events/compaction/mm_compaction_kcompactd_wake/filter events/c=
ompaction/mm_compaction_migratepages/filter events/compaction/mm_compaction=
_suitable/filter events/compaction/mm_compaction_try_to_compact_pages/filte=
r events/compaction/mm_compaction_wakeup_kcompactd/filter events/context_tr=
acking/user_enter/filter events/context_tracking/user_exit/filter events/co=
redump/coredump/filter events/cpuhp/cpuhp_enter/filter events/cpuhp/cpuhp_e=
xit/filter events/cpuhp/cpuhp_multi_enter/filter events/csd/csd_function_en=
try/filter events/csd/csd_function_exit/filter events/csd/csd_queue_cpu/fil=
ter events/damon/damon_aggregated/filter events/damon/damon_monitor_interva=
ls_tune/filter events/damon/damon_region_aggregated/filter events/damon/dam=
os_before_apply/filter events/damon/damos_esz/filter events/damon/damos_sta=
t_after_apply_interval/filter events/dev/devres_log/filter events/devlink/d=
evlink_health_recover_aborted/filter events/devlink/devlink_health_report/f=
ilter events/devlink/devlink_health_reporter_state_update/filter events/dev=
link/devlink_hwerr/filter events/devlink/devlink_hwmsg/filter events/devlin=
k/devlink_trap_report/filter events/dma/dma_alloc/filter events/dma/dma_all=
oc_pages/filter events/dma/dma_alloc_sgt/filter events/dma/dma_alloc_sgt_er=
r/filter events/dma/dma_free/filter events/dma/dma_free_pages/filter events=
/dma/dma_free_sgt/filter events/dma/dma_map_phys/filter events/dma/dma_map_=
sg/filter events/dma/dma_map_sg_err/filter events/dma/dma_sync_sg_for_cpu/f=
ilter events/dma/dma_sync_sg_for_device/filter events/dma/dma_sync_single_f=
or_cpu/filter events/dma/dma_sync_single_for_device/filter events/dma/dma_u=
nmap_phys/filter events/dma/dma_unmap_sg/filter events/dma_buf/dma_buf_deta=
ch/filter events/dma_buf/dma_buf_dynamic_attach/filter events/dma_buf/dma_b=
uf_export/filter events/dma_buf/dma_buf_fd/filter events/dma_buf/dma_buf_ge=
t/filter events/dma_buf/dma_buf_mmap/filter events/dma_buf/dma_buf_mmap_int=
ernal/filter events/dma_buf/dma_buf_put/filter events/dma_fence/dma_fence_d=
estroy/filter events/dma_fence/dma_fence_emit/filter events/dma_fence/dma_f=
ence_enable_signal/filter events/dma_fence/dma_fence_init/filter events/dma=
_fence/dma_fence_signaled/filter events/dma_fence/dma_fence_wait_end/filter=
 events/dma_fence/dma_fence_wait_start/filter events/drm/drm_vblank_event/f=
ilter events/drm/drm_vblank_event_delivered/filter events/drm/drm_vblank_ev=
ent_queued/filter events/e1000e_trace/e1000e_trace_mac_register/filter even=
ts/error_report/error_report_end/filter events/exceptions/page_fault_kernel=
/filter events/exceptions/page_fault_user/filter events/ext4/ext4_alloc_da_=
blocks/filter events/ext4/ext4_allocate_blocks/filter events/ext4/ext4_allo=
cate_inode/filter events/ext4/ext4_begin_ordered_truncate/filter events/ext=
4/ext4_collapse_range/filter events/ext4/ext4_da_release_space/filter event=
s/ext4/ext4_da_reserve_space/filter events/ext4/ext4_da_update_reserve_spac=
e/filter events/ext4/ext4_da_write_begin/filter events/ext4/ext4_da_write_e=
nd/filter events/ext4/ext4_da_write_folios_end/filter events/ext4/ext4_da_w=
rite_folios_start/filter events/ext4/ext4_da_write_pages_extent/filter even=
ts/ext4/ext4_discard_blocks/filter events/ext4/ext4_discard_preallocations/=
filter events/ext4/ext4_drop_inode/filter events/ext4/ext4_error/filter eve=
nts/ext4/ext4_es_cache_extent/filter events/ext4/ext4_es_find_extent_range_=
enter/filter events/ext4/ext4_es_find_extent_range_exit/filter events/ext4/=
ext4_es_insert_delayed_extent/filter events/ext4/ext4_es_insert_extent/filt=
er events/ext4/ext4_es_lookup_extent_enter/filter events/ext4/ext4_es_looku=
p_extent_exit/filter events/ext4/ext4_es_remove_extent/filter events/ext4/e=
xt4_es_shrink/filter events/ext4/ext4_es_shrink_count/filter events/ext4/ex=
t4_es_shrink_scan_enter/filter events/ext4/ext4_es_shrink_scan_exit/filter =
events/ext4/ext4_evict_inode/filter events/ext4/ext4_ext_convert_to_initial=
ized_enter/filter events/ext4/ext4_ext_convert_to_initialized_fastpath/filt=
er events/ext4/ext4_ext_handle_unwritten_extents/filter events/ext4/ext4_ex=
t_load_extent/filter events/ext4/ext4_ext_map_blocks_enter/filter events/ex=
t4/ext4_ext_map_blocks_exit/filter events/ext4/ext4_ext_remove_space/filter=
 events/ext4/ext4_ext_remove_space_done/filter events/ext4/ext4_ext_rm_idx/=
filter events/ext4/ext4_ext_rm_leaf/filter events/ext4/ext4_ext_show_extent=
/filter events/ext4/ext4_fallocate_enter/filter events/ext4/ext4_fallocate_=
exit/filter events/ext4/ext4_fc_cleanup/filter events/ext4/ext4_fc_commit_s=
tart/filter events/ext4/ext4_fc_commit_stop/filter events/ext4/ext4_fc_lock=
_updates/filter events/ext4/ext4_fc_replay/filter events/ext4/ext4_fc_repla=
y_scan/filter events/ext4/ext4_fc_stats/filter events/ext4/ext4_fc_track_cr=
eate/filter events/ext4/ext4_fc_track_inode/filter events/ext4/ext4_fc_trac=
k_link/filter events/ext4/ext4_fc_track_range/filter events/ext4/ext4_fc_tr=
ack_unlink/filter events/ext4/ext4_forget/filter events/ext4/ext4_free_bloc=
ks/filter events/ext4/ext4_free_inode/filter events/ext4/ext4_fsmap_high_ke=
y/filter events/ext4/ext4_fsmap_low_key/filter events/ext4/ext4_fsmap_mappi=
ng/filter events/ext4/ext4_get_implied_cluster_alloc_exit/filter events/ext=
4/ext4_getfsmap_high_key/filter events/ext4/ext4_getfsmap_low_key/filter ev=
ents/ext4/ext4_getfsmap_mapping/filter events/ext4/ext4_ind_map_blocks_ente=
r/filter events/ext4/ext4_ind_map_blocks_exit/filter events/ext4/ext4_inser=
t_range/filter events/ext4/ext4_invalidate_folio/filter events/ext4/ext4_jo=
urnal_start_inode/filter events/ext4/ext4_journal_start_reserved/filter eve=
nts/ext4/ext4_journal_start_sb/filter events/ext4/ext4_journalled_invalidat=
e_folio/filter events/ext4/ext4_journalled_write_end/filter events/ext4/ext=
4_lazy_itable_init/filter events/ext4/ext4_load_inode/filter events/ext4/ex=
t4_load_inode_bitmap/filter events/ext4/ext4_mark_inode_dirty/filter events=
/ext4/ext4_mb_bitmap_load/filter events/ext4/ext4_mb_buddy_bitmap_load/filt=
er events/ext4/ext4_mb_discard_preallocations/filter events/ext4/ext4_mb_ne=
w_group_pa/filter events/ext4/ext4_mb_new_inode_pa/filter events/ext4/ext4_=
mb_release_group_pa/filter events/ext4/ext4_mb_release_inode_pa/filter even=
ts/ext4/ext4_mballoc_alloc/filter events/ext4/ext4_mballoc_discard/filter e=
vents/ext4/ext4_mballoc_free/filter events/ext4/ext4_mballoc_prealloc/filte=
r events/ext4/ext4_move_extent_enter/filter events/ext4/ext4_move_extent_ex=
it/filter events/ext4/ext4_nfs_commit_metadata/filter events/ext4/ext4_othe=
r_inode_update_time/filter events/ext4/ext4_prefetch_bitmaps/filter events/=
ext4/ext4_punch_hole/filter events/ext4/ext4_read_block_bitmap_load/filter =
events/ext4/ext4_read_folio/filter events/ext4/ext4_release_folio/filter ev=
ents/ext4/ext4_remove_blocks/filter events/ext4/ext4_request_blocks/filter =
events/ext4/ext4_request_inode/filter events/ext4/ext4_shutdown/filter even=
ts/ext4/ext4_sync_file_enter/filter events/ext4/ext4_sync_file_exit/filter =
events/ext4/ext4_sync_fs/filter events/ext4/ext4_trim_all_free/filter event=
s/ext4/ext4_trim_extent/filter events/ext4/ext4_truncate_enter/filter event=
s/ext4/ext4_truncate_exit/filter events/ext4/ext4_unlink_enter/filter event=
s/ext4/ext4_unlink_exit/filter events/ext4/ext4_update_sb/filter events/ext=
4/ext4_write_begin/filter events/ext4/ext4_write_end/filter events/ext4/ext=
4_writepages/filter events/ext4/ext4_writepages_result/filter events/ext4/e=
xt4_zero_range/filter events/fib/fib_table_lookup/filter events/fib6/fib6_t=
able_lookup/filter events/filelock/break_lease/filter events/filelock/break=
_lease_block/filter events/filelock/break_lease_noblock/filter events/filel=
ock/break_lease_unblock/filter events/filelock/fcntl_setlk/filter events/fi=
lelock/flock_lock_inode/filter events/filelock/generic_add_lease/filter eve=
nts/filelock/generic_delete_lease/filter events/filelock/leases_conflict/fi=
lter events/filelock/locks_get_lock_context/filter events/filelock/locks_re=
move_posix/filter events/filelock/posix_lock_inode/filter events/filelock/t=
ime_out_leases/filter events/filemap/file_check_and_advance_wb_err/filter e=
vents/filemap/filemap_set_wb_err/filter events/filemap/mm_filemap_add_to_pa=
ge_cache/filter events/filemap/mm_filemap_delete_from_page_cache/filter eve=
nts/filemap/mm_filemap_fault/filter events/filemap/mm_filemap_get_pages/fil=
ter events/filemap/mm_filemap_map_pages/filter events/fs_dax/dax_insert_pfn=
_mkwrite/filter events/fs_dax/dax_insert_pfn_mkwrite_no_entry/filter events=
/fs_dax/dax_load_hole/filter events/fs_dax/dax_pmd_fault/filter events/fs_d=
ax/dax_pmd_fault_done/filter events/fs_dax/dax_pmd_load_hole/filter events/=
fs_dax/dax_pmd_load_hole_fallback/filter events/fs_dax/dax_pte_fault/filter=
 events/fs_dax/dax_pte_fault_done/filter events/fs_dax/dax_writeback_one/fi=
lter events/fs_dax/dax_writeback_range/filter events/fs_dax/dax_writeback_r=
ange_done/filter events/fscache/fscache_access/filter events/fscache/fscach=
e_access_cache/filter events/fscache/fscache_access_volume/filter events/fs=
cache/fscache_acquire/filter events/fscache/fscache_active/filter events/fs=
cache/fscache_cache/filter events/fscache/fscache_cookie/filter events/fsca=
che/fscache_invalidate/filter events/fscache/fscache_relinquish/filter even=
ts/fscache/fscache_resize/filter events/fscache/fscache_volume/filter event=
s/fsnotify/fsnotify/filter events/fsverity/fsverity_enable/filter events/fs=
verity/fsverity_merkle_hit/filter events/fsverity/fsverity_tree_done/filter=
 events/fsverity/fsverity_verify_data_block/filter events/fsverity/fsverity=
_verify_merkle_block/filter events/fuse/fuse_request_end/filter events/fuse=
/fuse_request_send/filter events/fuse/fuse_request_sent/filter events/gpio/=
gpio_direction/filter events/gpio/gpio_value/filter events/handshake/handsh=
ake_cancel/filter events/handshake/handshake_cancel_busy/filter events/hand=
shake/handshake_cancel_none/filter events/handshake/handshake_cmd_accept/fi=
lter events/handshake/handshake_cmd_accept_err/filter events/handshake/hand=
shake_cmd_done/filter events/handshake/handshake_cmd_done_err/filter events=
/handshake/handshake_complete/filter events/handshake/handshake_destruct/fi=
lter events/handshake/handshake_notify_err/filter events/handshake/handshak=
e_submit/filter events/handshake/handshake_submit_err/filter events/handsha=
ke/tls_alert_recv/filter events/handshake/tls_alert_send/filter events/hand=
shake/tls_contenttype/filter events/hda/hda_get_response/filter events/hda/=
hda_send_cmd/filter events/hda/hda_unsol_event/filter events/hda/snd_hdac_s=
tream_start/filter events/hda/snd_hdac_stream_stop/filter events/hda_contro=
ller/azx_get_position/filter events/hda_controller/azx_pcm_close/filter eve=
nts/hda_controller/azx_pcm_hw_params/filter events/hda_controller/azx_pcm_o=
pen/filter events/hda_controller/azx_pcm_prepare/filter events/hda_controll=
er/azx_pcm_trigger/filter events/hda_intel/azx_resume/filter events/hda_int=
el/azx_runtime_resume/filter events/hda_intel/azx_runtime_suspend/filter ev=
ents/hda_intel/azx_suspend/filter events/huge_memory/mm_collapse_huge_page/=
filter events/huge_memory/mm_collapse_huge_page_isolate/filter events/huge_=
memory/mm_collapse_huge_page_swapin/filter events/huge_memory/mm_khugepaged=
_collapse_file/filter events/huge_memory/mm_khugepaged_scan/filter events/h=
uge_memory/mm_khugepaged_scan_file/filter events/huge_memory/mm_khugepaged_=
scan_pmd/filter events/hugetlbfs/hugetlbfs_alloc_inode/filter events/hugetl=
bfs/hugetlbfs_evict_inode/filter events/hugetlbfs/hugetlbfs_fallocate/filte=
r events/hugetlbfs/hugetlbfs_free_inode/filter events/hugetlbfs/hugetlbfs_s=
etattr/filter events/hwmon/hwmon_attr_show/filter events/hwmon/hwmon_attr_s=
how_string/filter events/hwmon/hwmon_attr_store/filter events/i2c/i2c_read/=
filter events/i2c/i2c_reply/filter events/i2c/i2c_result/filter events/i2c/=
i2c_write/filter events/i915/g4x_wm/filter events/i915/i915_context_create/=
filter events/i915/i915_context_free/filter events/i915/i915_gem_evict/filt=
er events/i915/i915_gem_evict_node/filter events/i915/i915_gem_evict_vm/fil=
ter events/i915/i915_gem_object_clflush/filter events/i915/i915_gem_object_=
create/filter events/i915/i915_gem_object_destroy/filter events/i915/i915_g=
em_object_fault/filter events/i915/i915_gem_object_pread/filter events/i915=
/i915_gem_object_pwrite/filter events/i915/i915_gem_shrink/filter events/i9=
15/i915_ppgtt_create/filter events/i915/i915_ppgtt_release/filter events/i9=
15/i915_reg_rw/filter events/i915/i915_request_add/filter events/i915/i915_=
request_queue/filter events/i915/i915_request_retire/filter events/i915/i91=
5_request_wait_begin/filter events/i915/i915_request_wait_end/filter events=
/i915/i915_vma_bind/filter events/i915/i915_vma_unbind/filter events/i915/i=
ntel_cpu_fifo_underrun/filter events/i915/intel_crtc_flip_done/filter event=
s/i915/intel_crtc_vblank_work_end/filter events/i915/intel_crtc_vblank_work=
_start/filter events/i915/intel_fbc_activate/filter events/i915/intel_fbc_d=
eactivate/filter events/i915/intel_fbc_nuke/filter events/i915/intel_frontb=
uffer_flush/filter events/i915/intel_frontbuffer_invalidate/filter events/i=
915/intel_memory_cxsr/filter events/i915/intel_pch_fifo_underrun/filter eve=
nts/i915/intel_pipe_crc/filter events/i915/intel_pipe_disable/filter events=
/i915/intel_pipe_enable/filter events/i915/intel_pipe_scaler_update_arm/fil=
ter events/i915/intel_pipe_update_end/filter events/i915/intel_pipe_update_=
start/filter events/i915/intel_pipe_update_vblank_evaded/filter events/i915=
/intel_plane_async_flip/filter events/i915/intel_plane_disable_arm/filter e=
vents/i915/intel_plane_scaler_update_arm/filter events/i915/intel_plane_upd=
ate_arm/filter events/i915/intel_plane_update_noarm/filter events/i915/inte=
l_scaler_disable_arm/filter events/i915/vlv_fifo_size/filter events/i915/vl=
v_wm/filter events/ib_cma/icm_dreq_skipped/filter events/ib_cma/icm_dreq_un=
known_err/filter events/ib_cma/icm_establish_err/filter events/ib_cma/icm_h=
andler_err/filter events/ib_cma/icm_insert_failed_err/filter events/ib_cma/=
icm_issue_drep/filter events/ib_cma/icm_issue_rej/filter events/ib_cma/icm_=
mad_send_err/filter events/ib_cma/icm_mra_unknown_err/filter events/ib_cma/=
icm_no_listener_err/filter events/ib_cma/icm_no_priv_err/filter events/ib_c=
ma/icm_prepare_mra_unknown_err/filter events/ib_cma/icm_qp_init_err/filter =
events/ib_cma/icm_qp_rtr_err/filter events/ib_cma/icm_qp_rts_err/filter eve=
nts/ib_cma/icm_rej_unknown_err/filter events/ib_cma/icm_remote_no_priv_err/=
filter events/ib_cma/icm_rep_unknown_err/filter events/ib_cma/icm_send_cm_r=
tu_err/filter events/ib_cma/icm_send_drep/filter events/ib_cma/icm_send_dre=
p_err/filter events/ib_cma/icm_send_dreq/filter events/ib_cma/icm_send_dup_=
rep/filter events/ib_cma/icm_send_dup_req/filter events/ib_cma/icm_send_mra=
/filter events/ib_cma/icm_send_rej/filter events/ib_cma/icm_send_rep/filter=
 events/ib_cma/icm_send_rep_err/filter events/ib_cma/icm_send_req/filter ev=
ents/ib_cma/icm_send_rtu/filter events/ib_cma/icm_send_sidr_rep/filter even=
ts/ib_cma/icm_send_sidr_req/filter events/ib_cma/icm_send_unknown_rej_err/f=
ilter events/ib_cma/icm_staleconn_err/filter events/ib_mad/ib_mad_create_ag=
ent/filter events/ib_mad/ib_mad_error_handler/filter events/ib_mad/ib_mad_h=
andle_ib_smi/filter events/ib_mad/ib_mad_handle_opa_smi/filter events/ib_ma=
d/ib_mad_handle_out_ib_smi/filter events/ib_mad/ib_mad_handle_out_opa_smi/f=
ilter events/ib_mad/ib_mad_ib_send_mad/filter events/ib_mad/ib_mad_recv_don=
e_agent/filter events/ib_mad/ib_mad_recv_done_handler/filter events/ib_mad/=
ib_mad_send_done_agent/filter events/ib_mad/ib_mad_send_done_handler/filter=
 events/ib_mad/ib_mad_send_done_resend/filter events/ib_mad/ib_mad_unregist=
er_agent/filter events/icmp/icmp_send/filter events/initcall/initcall_finis=
h/filter events/initcall/initcall_level/filter events/initcall/initcall_sta=
rt/filter events/intel_avs/avs_d0ix/filter events/intel_avs/avs_dsp_core_op=
/filter events/intel_avs/avs_ipc_msg_payload/filter events/intel_avs/avs_ip=
c_notify_msg/filter events/intel_avs/avs_ipc_reply_msg/filter events/intel_=
avs/avs_ipc_request_msg/filter events/intel_iommu/cache_tag_assign/filter e=
vents/intel_iommu/cache_tag_flush_range/filter events/intel_iommu/cache_tag=
_flush_range_np/filter events/intel_iommu/cache_tag_unassign/filter events/=
intel_iommu/prq_report/filter events/intel_iommu/qi_submit/filter events/io=
_uring/io_uring_complete/filter events/io_uring/io_uring_cqe_overflow/filte=
r events/io_uring/io_uring_cqring_wait/filter events/io_uring/io_uring_crea=
te/filter events/io_uring/io_uring_defer/filter events/io_uring/io_uring_fa=
il_link/filter events/io_uring/io_uring_file_get/filter events/io_uring/io_=
uring_link/filter events/io_uring/io_uring_local_work_run/filter events/io_=
uring/io_uring_poll_arm/filter events/io_uring/io_uring_queue_async_work/fi=
lter events/io_uring/io_uring_register/filter events/io_uring/io_uring_req_=
failed/filter events/io_uring/io_uring_short_write/filter events/io_uring/i=
o_uring_submit_req/filter events/io_uring/io_uring_task_add/filter events/i=
o_uring/io_uring_task_work_run/filter events/iomap/iomap_add_to_ioend/filte=
r events/iomap/iomap_dio_complete/filter events/iomap/iomap_dio_invalidate_=
fail/filter events/iomap/iomap_dio_rw_begin/filter events/iomap/iomap_dio_r=
w_queued/filter events/iomap/iomap_invalidate_folio/filter events/iomap/iom=
ap_iter/filter events/iomap/iomap_iter_dstmap/filter events/iomap/iomap_ite=
r_srcmap/filter events/iomap/iomap_readahead/filter events/iomap/iomap_read=
page/filter events/iomap/iomap_release_folio/filter events/iomap/iomap_writ=
eback_folio/filter events/iomap/iomap_zero_iter/filter events/iommu/add_dev=
ice_to_group/filter events/iommu/attach_device_to_domain/filter events/iomm=
u/io_page_fault/filter events/iommu/map/filter events/iommu/remove_device_f=
rom_group/filter events/iommu/unmap/filter events/ipi/ipi_send_cpu/filter e=
vents/ipi/ipi_send_cpumask/filter events/irq/irq_handler_entry/filter event=
s/irq/irq_handler_exit/filter events/irq/softirq_entry/filter events/irq/so=
ftirq_exit/filter events/irq/softirq_raise/filter events/irq/tasklet_entry/=
filter events/irq/tasklet_exit/filter events/irq_matrix/irq_matrix_alloc/fi=
lter events/irq_matrix/irq_matrix_alloc_managed/filter events/irq_matrix/ir=
q_matrix_assign/filter events/irq_matrix/irq_matrix_assign_system/filter ev=
ents/irq_matrix/irq_matrix_free/filter events/irq_matrix/irq_matrix_offline=
/filter events/irq_matrix/irq_matrix_online/filter events/irq_matrix/irq_ma=
trix_remove_managed/filter events/irq_matrix/irq_matrix_remove_reserved/fil=
ter events/irq_matrix/irq_matrix_reserve/filter events/irq_matrix/irq_matri=
x_reserve_managed/filter events/irq_vectors/call_function_entry/filter even=
ts/irq_vectors/call_function_exit/filter events/irq_vectors/call_function_s=
ingle_entry/filter events/irq_vectors/call_function_single_exit/filter even=
ts/irq_vectors/deferred_error_apic_entry/filter events/irq_vectors/deferred=
_error_apic_exit/filter events/irq_vectors/error_apic_entry/filter events/i=
rq_vectors/error_apic_exit/filter events/irq_vectors/irq_work_entry/filter =
events/irq_vectors/irq_work_exit/filter events/irq_vectors/local_timer_entr=
y/filter events/irq_vectors/local_timer_exit/filter events/irq_vectors/resc=
hedule_entry/filter events/irq_vectors/reschedule_exit/filter events/irq_ve=
ctors/spurious_apic_entry/filter events/irq_vectors/spurious_apic_exit/filt=
er events/irq_vectors/thermal_apic_entry/filter events/irq_vectors/thermal_=
apic_exit/filter events/irq_vectors/threshold_apic_entry/filter events/irq_=
vectors/threshold_apic_exit/filter events/irq_vectors/vector_activate/filte=
r events/irq_vectors/vector_alloc/filter events/irq_vectors/vector_alloc_ma=
naged/filter events/irq_vectors/vector_clear/filter events/irq_vectors/vect=
or_config/filter events/irq_vectors/vector_deactivate/filter events/irq_vec=
tors/vector_free_moved/filter events/irq_vectors/vector_reserve/filter even=
ts/irq_vectors/vector_reserve_managed/filter events/irq_vectors/vector_setu=
p/filter events/irq_vectors/vector_teardown/filter events/irq_vectors/vecto=
r_update/filter events/irq_vectors/x86_platform_ipi_entry/filter events/irq=
_vectors/x86_platform_ipi_exit/filter events/jbd2/jbd2_checkpoint/filter ev=
ents/jbd2/jbd2_checkpoint_stats/filter events/jbd2/jbd2_commit_flushing/fil=
ter events/jbd2/jbd2_commit_locking/filter events/jbd2/jbd2_commit_logging/=
filter events/jbd2/jbd2_drop_transaction/filter events/jbd2/jbd2_end_commit=
/filter events/jbd2/jbd2_handle_extend/filter events/jbd2/jbd2_handle_resta=
rt/filter events/jbd2/jbd2_handle_start/filter events/jbd2/jbd2_handle_stat=
s/filter events/jbd2/jbd2_lock_buffer_stall/filter events/jbd2/jbd2_run_sta=
ts/filter events/jbd2/jbd2_shrink_checkpoint_list/filter events/jbd2/jbd2_s=
hrink_count/filter events/jbd2/jbd2_shrink_scan_enter/filter events/jbd2/jb=
d2_shrink_scan_exit/filter events/jbd2/jbd2_start_commit/filter events/jbd2=
/jbd2_submit_inode_data/filter events/jbd2/jbd2_update_log_tail/filter even=
ts/jbd2/jbd2_write_superblock/filter events/kmem/kfree/filter events/kmem/k=
malloc/filter events/kmem/kmem_cache_alloc/filter events/kmem/kmem_cache_fr=
ee/filter events/kmem/mm_calculate_totalreserve_pages/filter events/kmem/mm=
_page_alloc/filter events/kmem/mm_page_alloc_extfrag/filter events/kmem/mm_=
page_alloc_zone_locked/filter events/kmem/mm_page_free/filter events/kmem/m=
m_page_free_batched/filter events/kmem/mm_page_pcpu_drain/filter events/kme=
m/mm_setup_per_zone_lowmem_reserve/filter events/kmem/mm_setup_per_zone_wma=
rks/filter events/kmem/rss_stat/filter events/kprobes/kpevent/filter events=
/ksm/ksm_advisor/filter events/ksm/ksm_enter/filter events/ksm/ksm_exit/fil=
ter events/ksm/ksm_merge_one_page/filter events/ksm/ksm_merge_with_ksm_page=
/filter events/ksm/ksm_remove_ksm_page/filter events/ksm/ksm_remove_rmap_it=
em/filter events/ksm/ksm_start_scan/filter events/ksm/ksm_stop_scan/filter =
events/kvm/kvm_ack_irq/filter events/kvm/kvm_age_hva/filter events/kvm/kvm_=
apic/filter events/kvm/kvm_apic_accept_irq/filter events/kvm/kvm_apic_ipi/f=
ilter events/kvm/kvm_apicv_accept_irq/filter events/kvm/kvm_apicv_inhibit_c=
hanged/filter events/kvm/kvm_async_pf_completed/filter events/kvm/kvm_async=
_pf_not_present/filter events/kvm/kvm_async_pf_ready/filter events/kvm/kvm_=
async_pf_repeated_fault/filter events/kvm/kvm_avic_doorbell/filter events/k=
vm/kvm_avic_ga_log/filter events/kvm/kvm_avic_incomplete_ipi/filter events/=
kvm/kvm_avic_kick_vcpu_slowpath/filter events/kvm/kvm_avic_unaccelerated_ac=
cess/filter events/kvm/kvm_cpuid/filter events/kvm/kvm_cr/filter events/kvm=
/kvm_dirty_ring_exit/filter events/kvm/kvm_dirty_ring_push/filter events/kv=
m/kvm_dirty_ring_reset/filter events/kvm/kvm_emulate_insn/filter events/kvm=
/kvm_entry/filter events/kvm/kvm_eoi/filter events/kvm/kvm_exit/filter even=
ts/kvm/kvm_fast_mmio/filter events/kvm/kvm_fpu/filter events/kvm/kvm_halt_p=
oll_ns/filter events/kvm/kvm_hv_flush_tlb/filter events/kvm/kvm_hv_flush_tl=
b_ex/filter events/kvm/kvm_hv_hypercall/filter events/kvm/kvm_hv_hypercall_=
done/filter events/kvm/kvm_hv_notify_acked_sint/filter events/kvm/kvm_hv_se=
nd_ipi/filter events/kvm/kvm_hv_send_ipi_ex/filter events/kvm/kvm_hv_stimer=
_callback/filter events/kvm/kvm_hv_stimer_cleanup/filter events/kvm/kvm_hv_=
stimer_expiration/filter events/kvm/kvm_hv_stimer_set_config/filter events/=
kvm/kvm_hv_stimer_set_count/filter events/kvm/kvm_hv_stimer_start_one_shot/=
filter events/kvm/kvm_hv_stimer_start_periodic/filter events/kvm/kvm_hv_syn=
dbg_get_msr/filter events/kvm/kvm_hv_syndbg_set_msr/filter events/kvm/kvm_h=
v_synic_send_eoi/filter events/kvm/kvm_hv_synic_set_irq/filter events/kvm/k=
vm_hv_synic_set_msr/filter events/kvm/kvm_hv_timer_state/filter events/kvm/=
kvm_hypercall/filter events/kvm/kvm_inj_exception/filter events/kvm/kvm_inj=
_virq/filter events/kvm/kvm_invlpga/filter events/kvm/kvm_ioapic_delayed_eo=
i_inj/filter events/kvm/kvm_ioapic_set_irq/filter events/kvm/kvm_mmio/filte=
r events/kvm/kvm_msi_set_irq/filter events/kvm/kvm_msr/filter events/kvm/kv=
m_nested_intercepts/filter events/kvm/kvm_nested_intr_vmexit/filter events/=
kvm/kvm_nested_vmenter/filter events/kvm/kvm_nested_vmenter_failed/filter e=
vents/kvm/kvm_nested_vmexit/filter events/kvm/kvm_nested_vmexit_inject/filt=
er events/kvm/kvm_page_fault/filter events/kvm/kvm_pi_irte_update/filter ev=
ents/kvm/kvm_pic_set_irq/filter events/kvm/kvm_pio/filter events/kvm/kvm_pl=
e_window_update/filter events/kvm/kvm_pml_full/filter events/kvm/kvm_pv_eoi=
/filter events/kvm/kvm_pv_tlb_flush/filter events/kvm/kvm_pvclock_update/fi=
lter events/kvm/kvm_rmp_fault/filter events/kvm/kvm_set_irq/filter events/k=
vm/kvm_skinit/filter events/kvm/kvm_smm_transition/filter events/kvm/kvm_te=
st_age_hva/filter events/kvm/kvm_track_tsc/filter events/kvm/kvm_try_async_=
get_page/filter events/kvm/kvm_unmap_hva_range/filter events/kvm/kvm_update=
_master_clock/filter events/kvm/kvm_userspace_exit/filter events/kvm/kvm_vc=
pu_wakeup/filter events/kvm/kvm_vm_set_mem_attributes/filter events/kvm/kvm=
_vmgexit_enter/filter events/kvm/kvm_vmgexit_exit/filter events/kvm/kvm_vmg=
exit_msr_protocol_enter/filter events/kvm/kvm_vmgexit_msr_protocol_exit/fil=
ter events/kvm/kvm_wait_lapic_expire/filter events/kvm/kvm_write_tsc_offset=
/filter events/kvm/kvm_xen_hypercall/filter events/kvm/vcpu_match_mmio/filt=
er events/kvmmmu/check_mmio_spte/filter events/kvmmmu/fast_page_fault/filte=
r events/kvmmmu/handle_mmio_page_fault/filter events/kvmmmu/kvm_mmu_get_pag=
e/filter events/kvmmmu/kvm_mmu_pagetable_walk/filter events/kvmmmu/kvm_mmu_=
paging_element/filter events/kvmmmu/kvm_mmu_prepare_zap_page/filter events/=
kvmmmu/kvm_mmu_set_accessed_bit/filter events/kvmmmu/kvm_mmu_set_dirty_bit/=
filter events/kvmmmu/kvm_mmu_set_spte/filter events/kvmmmu/kvm_mmu_split_hu=
ge_page/filter events/kvmmmu/kvm_mmu_spte_requested/filter events/kvmmmu/kv=
m_mmu_sync_page/filter events/kvmmmu/kvm_mmu_unsync_page/filter events/kvmm=
mu/kvm_mmu_walker_error/filter events/kvmmmu/kvm_mmu_zap_all_fast/filter ev=
ents/kvmmmu/kvm_tdp_mmu_spte_changed/filter events/kvmmmu/mark_mmio_spte/fi=
lter events/kyber/kyber_adjust/filter events/kyber/kyber_latency/filter eve=
nts/kyber/kyber_throttled/filter events/libata/ata_bmdma_setup/filter event=
s/libata/ata_bmdma_start/filter events/libata/ata_bmdma_status/filter event=
s/libata/ata_bmdma_stop/filter events/libata/ata_eh_about_to_do/filter even=
ts/libata/ata_eh_done/filter events/libata/ata_eh_link_autopsy/filter event=
s/libata/ata_eh_link_autopsy_qc/filter events/libata/ata_exec_command/filte=
r events/libata/ata_link_hardreset_begin/filter events/libata/ata_link_hard=
reset_end/filter events/libata/ata_link_postreset/filter events/libata/ata_=
link_softreset_begin/filter events/libata/ata_link_softreset_end/filter eve=
nts/libata/ata_port_freeze/filter events/libata/ata_port_thaw/filter events=
/libata/ata_qc_complete_done/filter events/libata/ata_qc_complete_failed/fi=
lter events/libata/ata_qc_complete_internal/filter events/libata/ata_qc_iss=
ue/filter events/libata/ata_qc_prep/filter events/libata/ata_sff_flush_pio_=
task/filter events/libata/ata_sff_hsm_command_complete/filter events/libata=
/ata_sff_hsm_state/filter events/libata/ata_sff_pio_transfer_data/filter ev=
ents/libata/ata_sff_port_intr/filter events/libata/ata_slave_hardreset_begi=
n/filter events/libata/ata_slave_hardreset_end/filter events/libata/ata_sla=
ve_postreset/filter events/libata/ata_std_sched_eh/filter events/libata/ata=
_tf_load/filter events/libata/atapi_pio_transfer_data/filter events/libata/=
atapi_send_cdb/filter events/lock/contended_release/filter events/lock/cont=
ention_begin/filter events/lock/contention_end/filter events/lock/lock_acqu=
ire/filter events/lock/lock_release/filter events/lockd/nlmclnt_grant/filte=
r events/lockd/nlmclnt_lock/filter events/lockd/nlmclnt_test/filter events/=
lockd/nlmclnt_unlock/filter events/maple_tree/ma_op/filter events/maple_tre=
e/ma_read/filter events/maple_tree/ma_write/filter events/mce/mce_record/fi=
lter events/mdio/mdio_access/filter events/mei/mei_pci_cfg_read/filter even=
ts/mei/mei_reg_read/filter events/mei/mei_reg_write/filter events/memcg/cou=
nt_memcg_events/filter events/memcg/memcg_flush_stats/filter events/memcg/m=
od_memcg_lruvec_state/filter events/memcg/mod_memcg_state/filter events/mem=
ory_failure/memory_failure_event/filter events/migrate/mm_migrate_pages/fil=
ter events/migrate/mm_migrate_pages_start/filter events/migrate/remove_migr=
ation_pte/filter events/migrate/set_migration_pte/filter events/mmap/exit_m=
map/filter events/mmap/vm_unmapped_area/filter events/mmap_lock/mmap_lock_a=
cquire_returned/filter events/mmap_lock/mmap_lock_released/filter events/mm=
ap_lock/mmap_lock_start_locking/filter events/module/module_free/filter eve=
nts/module/module_get/filter events/module/module_load/filter events/module=
/module_put/filter events/module/module_request/filter events/mptcp/ack_upd=
ate_msk/filter events/mptcp/get_mapping_status/filter events/mptcp/mptcp_rc=
vbuf_grow/filter events/mptcp/mptcp_sendmsg_frag/filter events/mptcp/mptcp_=
subflow_get_send/filter events/mptcp/subflow_check_data_avail/filter events=
/msr/rdpmc/filter events/msr/read_msr/filter events/msr/write_msr/filter ev=
ents/napi/dql_stall_detected/filter events/napi/napi_poll/filter events/nei=
gh/neigh_cleanup_and_release/filter events/neigh/neigh_create/filter events=
/neigh/neigh_event_send_dead/filter events/neigh/neigh_event_send_done/filt=
er events/neigh/neigh_timer_handler/filter events/neigh/neigh_update/filter=
 events/neigh/neigh_update_done/filter events/net/napi_gro_frags_entry/filt=
er events/net/napi_gro_frags_exit/filter events/net/napi_gro_receive_entry/=
filter events/net/napi_gro_receive_exit/filter events/net/net_dev_queue/fil=
ter events/net/net_dev_start_xmit/filter events/net/net_dev_xmit/filter eve=
nts/net/net_dev_xmit_timeout/filter events/net/netif_receive_skb/filter eve=
nts/net/netif_receive_skb_entry/filter events/net/netif_receive_skb_exit/fi=
lter events/net/netif_receive_skb_list_entry/filter events/net/netif_receiv=
e_skb_list_exit/filter events/net/netif_rx/filter events/net/netif_rx_entry=
/filter events/net/netif_rx_exit/filter events/netfs/netfs_collect/filter e=
vents/netfs/netfs_collect_folio/filter events/netfs/netfs_collect_gap/filte=
r events/netfs/netfs_collect_sreq/filter events/netfs/netfs_collect_state/f=
ilter events/netfs/netfs_collect_stream/filter events/netfs/netfs_copy2cach=
e/filter events/netfs/netfs_failure/filter events/netfs/netfs_folio/filter =
events/netfs/netfs_folioq/filter events/netfs/netfs_read/filter events/netf=
s/netfs_rreq/filter events/netfs/netfs_rreq_ref/filter events/netfs/netfs_s=
req/filter events/netfs/netfs_sreq_ref/filter events/netfs/netfs_write/filt=
er events/netfs/netfs_write_iter/filter events/netlink/netlink_extack/filte=
r events/nfs/nfs_access_enter/filter events/nfs/nfs_access_exit/filter even=
ts/nfs/nfs_aop_readahead/filter events/nfs/nfs_aop_readahead_done/filter ev=
ents/nfs/nfs_aop_readpage/filter events/nfs/nfs_aop_readpage_done/filter ev=
ents/nfs/nfs_async_rename_done/filter events/nfs/nfs_atomic_open_enter/filt=
er events/nfs/nfs_atomic_open_exit/filter events/nfs/nfs_commit_done/filter=
 events/nfs/nfs_commit_error/filter events/nfs/nfs_comp_error/filter events=
/nfs/nfs_create_enter/filter events/nfs/nfs_create_exit/filter events/nfs/n=
fs_direct_commit_complete/filter events/nfs/nfs_direct_resched_write/filter=
 events/nfs/nfs_direct_write_complete/filter events/nfs/nfs_direct_write_co=
mpletion/filter events/nfs/nfs_direct_write_reschedule_io/filter events/nfs=
/nfs_direct_write_schedule_iovec/filter events/nfs/nfs_do_writepage/filter =
events/nfs/nfs_fh_to_dentry/filter events/nfs/nfs_file_read/filter events/n=
fs/nfs_file_write/filter events/nfs/nfs_fsync_enter/filter events/nfs/nfs_f=
sync_exit/filter events/nfs/nfs_getattr_enter/filter events/nfs/nfs_getattr=
_exit/filter events/nfs/nfs_initiate_commit/filter events/nfs/nfs_initiate_=
read/filter events/nfs/nfs_initiate_write/filter events/nfs/nfs_invalidate_=
folio/filter events/nfs/nfs_invalidate_mapping_enter/filter events/nfs/nfs_=
invalidate_mapping_exit/filter events/nfs/nfs_launder_folio_done/filter eve=
nts/nfs/nfs_link_enter/filter events/nfs/nfs_link_exit/filter events/nfs/nf=
s_local_open_fh/filter events/nfs/nfs_lookup_enter/filter events/nfs/nfs_lo=
okup_exit/filter events/nfs/nfs_lookup_revalidate_enter/filter events/nfs/n=
fs_lookup_revalidate_exit/filter events/nfs/nfs_mkdir_enter/filter events/n=
fs/nfs_mkdir_exit/filter events/nfs/nfs_mknod_enter/filter events/nfs/nfs_m=
knod_exit/filter events/nfs/nfs_mount_assign/filter events/nfs/nfs_mount_op=
tion/filter events/nfs/nfs_mount_path/filter events/nfs/nfs_pgio_error/filt=
er events/nfs/nfs_readdir_cache_fill/filter events/nfs/nfs_readdir_cache_fi=
ll_done/filter events/nfs/nfs_readdir_force_readdirplus/filter events/nfs/n=
fs_readdir_invalidate_cache_range/filter events/nfs/nfs_readdir_lookup/filt=
er events/nfs/nfs_readdir_lookup_revalidate/filter events/nfs/nfs_readdir_l=
ookup_revalidate_failed/filter events/nfs/nfs_readdir_uncached/filter event=
s/nfs/nfs_readdir_uncached_done/filter events/nfs/nfs_readpage_done/filter =
events/nfs/nfs_readpage_short/filter events/nfs/nfs_refresh_inode_enter/fil=
ter events/nfs/nfs_refresh_inode_exit/filter events/nfs/nfs_remove_enter/fi=
lter events/nfs/nfs_remove_exit/filter events/nfs/nfs_rename_enter/filter e=
vents/nfs/nfs_rename_exit/filter events/nfs/nfs_revalidate_inode_enter/filt=
er events/nfs/nfs_revalidate_inode_exit/filter events/nfs/nfs_rmdir_enter/f=
ilter events/nfs/nfs_rmdir_exit/filter events/nfs/nfs_set_cache_invalid/fil=
ter events/nfs/nfs_set_inode_stale/filter events/nfs/nfs_setattr_enter/filt=
er events/nfs/nfs_setattr_exit/filter events/nfs/nfs_sillyrename_unlink/fil=
ter events/nfs/nfs_size_grow/filter events/nfs/nfs_size_truncate/filter eve=
nts/nfs/nfs_size_truncate_folio/filter events/nfs/nfs_size_update/filter ev=
ents/nfs/nfs_size_wcc/filter events/nfs/nfs_symlink_enter/filter events/nfs=
/nfs_symlink_exit/filter events/nfs/nfs_try_to_update_request/filter events=
/nfs/nfs_try_to_update_request_done/filter events/nfs/nfs_unlink_enter/filt=
er events/nfs/nfs_unlink_exit/filter events/nfs/nfs_update_folio/filter eve=
nts/nfs/nfs_update_folio_done/filter events/nfs/nfs_write_begin/filter even=
ts/nfs/nfs_write_begin_done/filter events/nfs/nfs_write_end/filter events/n=
fs/nfs_write_end_done/filter events/nfs/nfs_write_error/filter events/nfs/n=
fs_writeback_done/filter events/nfs/nfs_writeback_folio/filter events/nfs/n=
fs_writeback_folio_done/filter events/nfs/nfs_writeback_folio_reclaim/filte=
r events/nfs/nfs_writeback_folio_reclaim_done/filter events/nfs/nfs_writeba=
ck_inode_enter/filter events/nfs/nfs_writeback_inode_exit/filter events/nfs=
/nfs_writepage_setup/filter events/nfs/nfs_writepages/filter events/nfs/nfs=
_writepages_done/filter events/nfs/nfs_xdr_bad_filehandle/filter events/nfs=
/nfs_xdr_status/filter events/nmi/nmi_handler/filter events/notifier/notifi=
er_register/filter events/notifier/notifier_run/filter events/notifier/noti=
fier_unregister/filter events/nvme/nvme_async_event/filter events/nvme/nvme=
_complete_rq/filter events/nvme/nvme_setup_cmd/filter events/nvme/nvme_sq/f=
ilter events/oom/compact_retry/filter events/oom/finish_task_reaping/filter=
 events/oom/mark_victim/filter events/oom/oom_score_adj_update/filter event=
s/oom/reclaim_retry_zone/filter events/oom/skip_task_reaping/filter events/=
oom/start_task_reaping/filter events/oom/wake_reaper/filter events/osnoise/=
irq_noise/filter events/osnoise/nmi_noise/filter events/osnoise/osnoise_sam=
ple/filter events/osnoise/sample_threshold/filter events/osnoise/softirq_no=
ise/filter events/osnoise/thread_noise/filter events/osnoise/timerlat_sampl=
e/filter events/page_isolation/test_pages_isolated/filter events/page_pool/=
page_pool_release/filter events/page_pool/page_pool_state_hold/filter event=
s/page_pool/page_pool_state_release/filter events/page_pool/page_pool_updat=
e_nid/filter events/pagemap/mm_lru_activate/filter events/pagemap/mm_lru_in=
sertion/filter events/pci/pci_hp_event/filter events/pci/pcie_link_event/fi=
lter events/pci_controller/pcie_ltssm_state_transition/filter events/percpu=
/percpu_alloc_percpu/filter events/percpu/percpu_alloc_percpu_fail/filter e=
vents/percpu/percpu_create_chunk/filter events/percpu/percpu_destroy_chunk/=
filter events/percpu/percpu_free_percpu/filter events/power/cpu_frequency/f=
ilter events/power/cpu_frequency_limits/filter events/power/cpu_idle/filter=
 events/power/cpu_idle_miss/filter events/power/dev_pm_qos_add_request/filt=
er events/power/dev_pm_qos_remove_request/filter events/power/dev_pm_qos_up=
date_request/filter events/power/device_pm_callback_end/filter events/power=
/device_pm_callback_start/filter events/power/guest_halt_poll_ns/filter eve=
nts/power/pm_qos_add_request/filter events/power/pm_qos_remove_request/filt=
er events/power/pm_qos_update_flags/filter events/power/pm_qos_update_reque=
st/filter events/power/pm_qos_update_target/filter events/power/pstate_samp=
le/filter events/power/suspend_resume/filter events/power/wakeup_source_act=
ivate/filter events/power/wakeup_source_deactivate/filter events/preemptirq=
/irq_disable/filter events/preemptirq/irq_enable/filter events/preemptirq/p=
reempt_disable/filter events/preemptirq/preempt_enable/filter events/printk=
/console/filter events/pwm/pwm_apply/filter events/pwm/pwm_get/filter event=
s/pwm/pwm_read_waveform/filter events/pwm/pwm_round_waveform_fromhw/filter =
events/pwm/pwm_round_waveform_tohw/filter events/pwm/pwm_write_waveform/fil=
ter events/qdisc/qdisc_create/filter events/qdisc/qdisc_dequeue/filter even=
ts/qdisc/qdisc_destroy/filter events/qdisc/qdisc_drop/filter events/qdisc/q=
disc_enqueue/filter events/qdisc/qdisc_reset/filter events/ras/aer_event/fi=
lter events/ras/arm_event/filter events/ras/extlog_mem_event/filter events/=
ras/mc_event/filter events/ras/non_standard_event/filter events/raw_syscall=
s/sys_enter/filter events/raw_syscalls/sys_exit/filter events/rcu/rcu_stall=
_warning/filter events/rcu/rcu_utilization/filter events/rdma_cma/cm_add_on=
e/filter events/rdma_cma/cm_disconnect/filter events/rdma_cma/cm_event_done=
/filter events/rdma_cma/cm_event_handler/filter events/rdma_cma/cm_id_attac=
h/filter events/rdma_cma/cm_id_destroy/filter events/rdma_cma/cm_prepare_mr=
a/filter events/rdma_cma/cm_qp_create/filter events/rdma_cma/cm_qp_destroy/=
filter events/rdma_cma/cm_remove_one/filter events/rdma_cma/cm_req_handler/=
filter events/rdma_cma/cm_send_rej/filter events/rdma_cma/cm_send_rep/filte=
r events/rdma_cma/cm_send_req/filter events/rdma_cma/cm_send_rtu/filter eve=
nts/rdma_cma/cm_send_sidr_rep/filter events/rdma_cma/cm_send_sidr_req/filte=
r events/rdma_cma/cm_sent_drep/filter events/rdma_cma/cm_sent_dreq/filter e=
vents/rdma_core/cq_alloc/filter events/rdma_core/cq_alloc_error/filter even=
ts/rdma_core/cq_drain_complete/filter events/rdma_core/cq_free/filter event=
s/rdma_core/cq_modify/filter events/rdma_core/cq_poll/filter events/rdma_co=
re/cq_process/filter events/rdma_core/cq_reschedule/filter events/rdma_core=
/cq_schedule/filter events/rdma_core/mr_alloc/filter events/rdma_core/mr_de=
reg/filter events/rdma_core/mr_integ_alloc/filter events/readahead/page_cac=
he_async_ra/filter events/readahead/page_cache_ra_order/filter events/reada=
head/page_cache_ra_unbounded/filter events/readahead/page_cache_sync_ra/fil=
ter events/regmap/regcache_drop_region/filter events/regmap/regcache_sync/f=
ilter events/regmap/regmap_async_complete_done/filter events/regmap/regmap_=
async_complete_start/filter events/regmap/regmap_async_io_complete/filter e=
vents/regmap/regmap_async_write_start/filter events/regmap/regmap_bulk_read=
/filter events/regmap/regmap_bulk_write/filter events/regmap/regmap_cache_b=
ypass/filter events/regmap/regmap_cache_only/filter events/regmap/regmap_hw=
_read_done/filter events/regmap/regmap_hw_read_start/filter events/regmap/r=
egmap_hw_write_done/filter events/regmap/regmap_hw_write_start/filter event=
s/regmap/regmap_reg_read/filter events/regmap/regmap_reg_read_cache/filter =
events/regmap/regmap_reg_write/filter events/resctrl/mon_llc_occupancy_limb=
o/filter events/resctrl/pseudo_lock_l2/filter events/resctrl/pseudo_lock_l3=
/filter events/resctrl/pseudo_lock_mem_latency/filter events/rpm/rpm_idle/f=
ilter events/rpm/rpm_resume/filter events/rpm/rpm_return_int/filter events/=
rpm/rpm_status/filter events/rpm/rpm_suspend/filter events/rpm/rpm_usage/fi=
lter events/rseq/rseq_ip_fixup/filter events/rseq/rseq_update/filter events=
/rtc/rtc_alarm_irq_enable/filter events/rtc/rtc_irq_set_freq/filter events/=
rtc/rtc_irq_set_state/filter events/rtc/rtc_read_alarm/filter events/rtc/rt=
c_read_offset/filter events/rtc/rtc_read_time/filter events/rtc/rtc_set_ala=
rm/filter events/rtc/rtc_set_offset/filter events/rtc/rtc_set_time/filter e=
vents/rtc/rtc_timer_dequeue/filter events/rtc/rtc_timer_enqueue/filter even=
ts/rtc/rtc_timer_fired/filter events/rv/error_wwnr/filter events/rv/event_w=
wnr/filter events/rv/rv_retries_error/filter events/sched/sched_kthread_sto=
p/filter events/sched/sched_kthread_stop_ret/filter events/sched/sched_kthr=
ead_work_execute_end/filter events/sched/sched_kthread_work_execute_start/f=
ilter events/sched/sched_kthread_work_queue_work/filter events/sched/sched_=
migrate_task/filter events/sched/sched_move_numa/filter events/sched/sched_=
pi_setprio/filter events/sched/sched_prepare_exec/filter events/sched/sched=
_process_exec/filter events/sched/sched_process_exit/filter events/sched/sc=
hed_process_fork/filter events/sched/sched_process_free/filter events/sched=
/sched_process_hang/filter events/sched/sched_process_wait/filter events/sc=
hed/sched_skip_cpuset_numa/filter events/sched/sched_skip_vma_numa/filter e=
vents/sched/sched_stat_blocked/filter events/sched/sched_stat_iowait/filter=
 events/sched/sched_stat_runtime/filter events/sched/sched_stat_sleep/filte=
r events/sched/sched_stat_wait/filter events/sched/sched_stick_numa/filter =
events/sched/sched_swap_numa/filter events/sched/sched_switch/filter events=
/sched/sched_wait_task/filter events/sched/sched_wake_idle_without_ipi/filt=
er events/sched/sched_wakeup/filter events/sched/sched_wakeup_new/filter ev=
ents/sched/sched_waking/filter events/sched_ext/sched_ext_bypass_lb/filter =
events/sched_ext/sched_ext_dump/filter events/sched_ext/sched_ext_event/fil=
ter events/scsi/scsi_dispatch_cmd_done/filter events/scsi/scsi_dispatch_cmd=
_error/filter events/scsi/scsi_dispatch_cmd_start/filter events/scsi/scsi_d=
ispatch_cmd_timeout/filter events/scsi/scsi_eh_wakeup/filter events/signal/=
signal_deliver/filter events/signal/signal_generate/filter events/skb/consu=
me_skb/filter events/skb/kfree_skb/filter events/skb/skb_copy_datagram_iove=
c/filter events/smbus/smbus_read/filter events/smbus/smbus_reply/filter eve=
nts/smbus/smbus_result/filter events/smbus/smbus_write/filter events/smc/sm=
c_rx_recvmsg/filter events/smc/smc_switch_to_fallback/filter events/smc/smc=
_tx_sendmsg/filter events/smc/smcr_link_down/filter events/sock/inet_sk_err=
or_report/filter events/sock/inet_sock_set_state/filter events/sock/sk_data=
_ready/filter events/sock/sock_exceed_buf_limit/filter events/sock/sock_rcv=
queue_full/filter events/sock/sock_recv_length/filter events/sock/sock_send=
_length/filter events/sof/sof_ipc3_period_elapsed_position/filter events/so=
f/sof_ipc4_fw_config/filter events/sof/sof_pcm_pointer_position/filter even=
ts/sof/sof_stream_position_ipc_rx/filter events/sof/sof_widget_free/filter =
events/sof/sof_widget_setup/filter events/sof_intel/sof_intel_D0I3C_updated=
/filter events/sof_intel/sof_intel_hda_dsp_check_stream_irq/filter events/s=
of_intel/sof_intel_hda_dsp_pcm/filter events/sof_intel/sof_intel_hda_dsp_st=
ream_status/filter events/sof_intel/sof_intel_hda_irq/filter events/sof_int=
el/sof_intel_hda_irq_ipc_check/filter events/sof_intel/sof_intel_ipc_firmwa=
re_initiated/filter events/sof_intel/sof_intel_ipc_firmware_response/filter=
 events/spi/spi_controller_busy/filter events/spi/spi_controller_idle/filte=
r events/spi/spi_message_done/filter events/spi/spi_message_start/filter ev=
ents/spi/spi_message_submit/filter events/spi/spi_set_cs/filter events/spi/=
spi_setup/filter events/spi/spi_transfer_start/filter events/spi/spi_transf=
er_stop/filter events/sunrpc/cache_entry_expired/filter events/sunrpc/cache=
_entry_make_negative/filter events/sunrpc/cache_entry_no_listener/filter ev=
ents/sunrpc/cache_entry_upcall/filter events/sunrpc/cache_entry_update/filt=
er events/sunrpc/pmap_register/filter events/sunrpc/rpc__auth_tooweak/filte=
r events/sunrpc/rpc__bad_creds/filter events/sunrpc/rpc__garbage_args/filte=
r events/sunrpc/rpc__mismatch/filter events/sunrpc/rpc__proc_unavail/filter=
 events/sunrpc/rpc__prog_mismatch/filter events/sunrpc/rpc__prog_unavail/fi=
lter events/sunrpc/rpc__stale_creds/filter events/sunrpc/rpc__unparsable/fi=
lter events/sunrpc/rpc_bad_callhdr/filter events/sunrpc/rpc_bad_verifier/fi=
lter events/sunrpc/rpc_buf_alloc/filter events/sunrpc/rpc_call_rpcerror/fil=
ter events/sunrpc/rpc_call_status/filter events/sunrpc/rpc_clnt_clone_err/f=
ilter events/sunrpc/rpc_clnt_free/filter events/sunrpc/rpc_clnt_killall/fil=
ter events/sunrpc/rpc_clnt_new/filter events/sunrpc/rpc_clnt_new_err/filter=
 events/sunrpc/rpc_clnt_release/filter events/sunrpc/rpc_clnt_replace_xprt/=
filter events/sunrpc/rpc_clnt_replace_xprt_err/filter events/sunrpc/rpc_cln=
t_shutdown/filter events/sunrpc/rpc_connect_status/filter events/sunrpc/rpc=
_refresh_status/filter events/sunrpc/rpc_request/filter events/sunrpc/rpc_r=
etry_refresh_status/filter events/sunrpc/rpc_socket_close/filter events/sun=
rpc/rpc_socket_connect/filter events/sunrpc/rpc_socket_error/filter events/=
sunrpc/rpc_socket_nospace/filter events/sunrpc/rpc_socket_reset_connection/=
filter events/sunrpc/rpc_socket_shutdown/filter events/sunrpc/rpc_socket_st=
ate_change/filter events/sunrpc/rpc_stats_latency/filter events/sunrpc/rpc_=
task_begin/filter events/sunrpc/rpc_task_call_done/filter events/sunrpc/rpc=
_task_complete/filter events/sunrpc/rpc_task_end/filter events/sunrpc/rpc_t=
ask_run_action/filter events/sunrpc/rpc_task_signalled/filter events/sunrpc=
/rpc_task_sleep/filter events/sunrpc/rpc_task_sync_sleep/filter events/sunr=
pc/rpc_task_sync_wake/filter events/sunrpc/rpc_task_timeout/filter events/s=
unrpc/rpc_task_wakeup/filter events/sunrpc/rpc_timeout_status/filter events=
/sunrpc/rpc_tls_not_started/filter events/sunrpc/rpc_tls_unavailable/filter=
 events/sunrpc/rpc_xdr_alignment/filter events/sunrpc/rpc_xdr_overflow/filt=
er events/sunrpc/rpc_xdr_recvfrom/filter events/sunrpc/rpc_xdr_reply_pages/=
filter events/sunrpc/rpc_xdr_sendto/filter events/sunrpc/rpcb_bind_version_=
err/filter events/sunrpc/rpcb_getport/filter events/sunrpc/rpcb_prog_unavai=
l_err/filter events/sunrpc/rpcb_register/filter events/sunrpc/rpcb_setport/=
filter events/sunrpc/rpcb_timeout_err/filter events/sunrpc/rpcb_unreachable=
_err/filter events/sunrpc/rpcb_unrecognized_err/filter events/sunrpc/rpcb_u=
nregister/filter events/sunrpc/svc_alloc_arg_err/filter events/sunrpc/svc_a=
uthenticate/filter events/sunrpc/svc_defer/filter events/sunrpc/svc_defer_d=
rop/filter events/sunrpc/svc_defer_queue/filter events/sunrpc/svc_defer_rec=
v/filter events/sunrpc/svc_drop/filter events/sunrpc/svc_noregister/filter =
events/sunrpc/svc_pool_thread_noidle/filter events/sunrpc/svc_pool_thread_r=
unning/filter events/sunrpc/svc_pool_thread_wake/filter events/sunrpc/svc_p=
rocess/filter events/sunrpc/svc_register/filter events/sunrpc/svc_replace_p=
age_err/filter events/sunrpc/svc_send/filter events/sunrpc/svc_stats_latenc=
y/filter events/sunrpc/svc_tls_not_started/filter events/sunrpc/svc_tls_sta=
rt/filter events/sunrpc/svc_tls_timed_out/filter events/sunrpc/svc_tls_unav=
ailable/filter events/sunrpc/svc_tls_upcall/filter events/sunrpc/svc_unregi=
ster/filter events/sunrpc/svc_xdr_recvfrom/filter events/sunrpc/svc_xdr_sen=
dto/filter events/sunrpc/svc_xprt_accept/filter events/sunrpc/svc_xprt_clos=
e/filter events/sunrpc/svc_xprt_create_err/filter events/sunrpc/svc_xprt_de=
queue/filter events/sunrpc/svc_xprt_detach/filter events/sunrpc/svc_xprt_en=
queue/filter events/sunrpc/svc_xprt_free/filter events/sunrpc/svc_xprt_no_w=
rite_space/filter events/sunrpc/svcsock_accept_err/filter events/sunrpc/svc=
sock_data_ready/filter events/sunrpc/svcsock_free/filter events/sunrpc/svcs=
ock_getpeername_err/filter events/sunrpc/svcsock_marker/filter events/sunrp=
c/svcsock_new/filter events/sunrpc/svcsock_tcp_recv/filter events/sunrpc/sv=
csock_tcp_recv_eagain/filter events/sunrpc/svcsock_tcp_recv_err/filter even=
ts/sunrpc/svcsock_tcp_recv_short/filter events/sunrpc/svcsock_tcp_send/filt=
er events/sunrpc/svcsock_tcp_state/filter events/sunrpc/svcsock_udp_recv/fi=
lter events/sunrpc/svcsock_udp_recv_err/filter events/sunrpc/svcsock_udp_se=
nd/filter events/sunrpc/svcsock_write_space/filter events/sunrpc/xprt_conne=
ct/filter events/sunrpc/xprt_create/filter events/sunrpc/xprt_destroy/filte=
r events/sunrpc/xprt_disconnect_auto/filter events/sunrpc/xprt_disconnect_d=
one/filter events/sunrpc/xprt_disconnect_force/filter events/sunrpc/xprt_ge=
t_cong/filter events/sunrpc/xprt_lookup_rqst/filter events/sunrpc/xprt_ping=
/filter events/sunrpc/xprt_put_cong/filter events/sunrpc/xprt_release_cong/=
filter events/sunrpc/xprt_release_xprt/filter events/sunrpc/xprt_reserve/fi=
lter events/sunrpc/xprt_reserve_cong/filter events/sunrpc/xprt_reserve_xprt=
/filter events/sunrpc/xprt_retransmit/filter events/sunrpc/xprt_timer/filte=
r events/sunrpc/xprt_transmit/filter events/sunrpc/xs_data_ready/filter eve=
nts/sunrpc/xs_stream_read_data/filter events/sunrpc/xs_stream_read_request/=
filter events/swiotlb/swiotlb_bounced/filter events/syscalls/sys_enter_acce=
pt/filter events/syscalls/sys_enter_accept4/filter events/syscalls/sys_ente=
r_access/filter events/syscalls/sys_enter_acct/filter events/syscalls/sys_e=
nter_add_key/filter events/syscalls/sys_enter_adjtimex/filter events/syscal=
ls/sys_enter_alarm/filter events/syscalls/sys_enter_arch_prctl/filter event=
s/syscalls/sys_enter_bind/filter events/syscalls/sys_enter_bpf/filter event=
s/syscalls/sys_enter_brk/filter events/syscalls/sys_enter_cachestat/filter =
events/syscalls/sys_enter_capget/filter events/syscalls/sys_enter_capset/fi=
lter events/syscalls/sys_enter_chdir/filter events/syscalls/sys_enter_chmod=
/filter events/syscalls/sys_enter_chown/filter events/syscalls/sys_enter_ch=
root/filter events/syscalls/sys_enter_clock_adjtime/filter events/syscalls/=
sys_enter_clock_getres/filter events/syscalls/sys_enter_clock_gettime/filte=
r events/syscalls/sys_enter_clock_nanosleep/filter events/syscalls/sys_ente=
r_clock_settime/filter events/syscalls/sys_enter_clone/filter events/syscal=
ls/sys_enter_clone3/filter events/syscalls/sys_enter_close/filter events/sy=
scalls/sys_enter_close_range/filter events/syscalls/sys_enter_connect/filte=
r events/syscalls/sys_enter_copy_file_range/filter events/syscalls/sys_ente=
r_creat/filter events/syscalls/sys_enter_delete_module/filter events/syscal=
ls/sys_enter_dup/filter events/syscalls/sys_enter_dup2/filter events/syscal=
ls/sys_enter_dup3/filter events/syscalls/sys_enter_epoll_create/filter even=
ts/syscalls/sys_enter_epoll_create1/filter events/syscalls/sys_enter_epoll_=
ctl/filter events/syscalls/sys_enter_epoll_pwait/filter events/syscalls/sys=
_enter_epoll_pwait2/filter events/syscalls/sys_enter_epoll_wait/filter even=
ts/syscalls/sys_enter_eventfd/filter events/syscalls/sys_enter_eventfd2/fil=
ter events/syscalls/sys_enter_execve/filter events/syscalls/sys_enter_execv=
eat/filter events/syscalls/sys_enter_exit/filter events/syscalls/sys_enter_=
exit_group/filter events/syscalls/sys_enter_faccessat/filter events/syscall=
s/sys_enter_faccessat2/filter events/syscalls/sys_enter_fadvise64/filter ev=
ents/syscalls/sys_enter_fallocate/filter events/syscalls/sys_enter_fanotify=
_init/filter events/syscalls/sys_enter_fanotify_mark/filter events/syscalls=
/sys_enter_fchdir/filter events/syscalls/sys_enter_fchmod/filter events/sys=
calls/sys_enter_fchmodat/filter events/syscalls/sys_enter_fchmodat2/filter =
events/syscalls/sys_enter_fchown/filter events/syscalls/sys_enter_fchownat/=
filter events/syscalls/sys_enter_fcntl/filter events/syscalls/sys_enter_fda=
tasync/filter events/syscalls/sys_enter_fgetxattr/filter events/syscalls/sy=
s_enter_file_getattr/filter events/syscalls/sys_enter_file_setattr/filter e=
vents/syscalls/sys_enter_finit_module/filter events/syscalls/sys_enter_flis=
txattr/filter events/syscalls/sys_enter_flock/filter events/syscalls/sys_en=
ter_fork/filter events/syscalls/sys_enter_fremovexattr/filter events/syscal=
ls/sys_enter_fsconfig/filter events/syscalls/sys_enter_fsetxattr/filter eve=
nts/syscalls/sys_enter_fsmount/filter events/syscalls/sys_enter_fsopen/filt=
er events/syscalls/sys_enter_fspick/filter events/syscalls/sys_enter_fstatf=
s/filter events/syscalls/sys_enter_fsync/filter events/syscalls/sys_enter_f=
truncate/filter events/syscalls/sys_enter_futex/filter events/syscalls/sys_=
enter_futex_requeue/filter events/syscalls/sys_enter_futex_wait/filter even=
ts/syscalls/sys_enter_futex_waitv/filter events/syscalls/sys_enter_futex_wa=
ke/filter events/syscalls/sys_enter_futimesat/filter events/syscalls/sys_en=
ter_get_mempolicy/filter events/syscalls/sys_enter_get_robust_list/filter e=
vents/syscalls/sys_enter_getcpu/filter events/syscalls/sys_enter_getcwd/fil=
ter events/syscalls/sys_enter_getdents/filter events/syscalls/sys_enter_get=
dents64/filter events/syscalls/sys_enter_getegid/filter events/syscalls/sys=
_enter_geteuid/filter events/syscalls/sys_enter_getgid/filter events/syscal=
ls/sys_enter_getgroups/filter events/syscalls/sys_enter_getitimer/filter ev=
ents/syscalls/sys_enter_getpeername/filter events/syscalls/sys_enter_getpgi=
d/filter events/syscalls/sys_enter_getpgrp/filter events/syscalls/sys_enter=
_getpid/filter events/syscalls/sys_enter_getppid/filter events/syscalls/sys=
_enter_getpriority/filter events/syscalls/sys_enter_getrandom/filter events=
/syscalls/sys_enter_getresgid/filter events/syscalls/sys_enter_getresuid/fi=
lter events/syscalls/sys_enter_getrlimit/filter events/syscalls/sys_enter_g=
etrusage/filter events/syscalls/sys_enter_getsid/filter events/syscalls/sys=
_enter_getsockname/filter events/syscalls/sys_enter_getsockopt/filter event=
s/syscalls/sys_enter_gettid/filter events/syscalls/sys_enter_gettimeofday/f=
ilter events/syscalls/sys_enter_getuid/filter events/syscalls/sys_enter_get=
xattr/filter events/syscalls/sys_enter_getxattrat/filter events/syscalls/sy=
s_enter_init_module/filter events/syscalls/sys_enter_inotify_add_watch/filt=
er events/syscalls/sys_enter_inotify_init/filter events/syscalls/sys_enter_=
inotify_init1/filter events/syscalls/sys_enter_inotify_rm_watch/filter even=
ts/syscalls/sys_enter_io_cancel/filter events/syscalls/sys_enter_io_destroy=
/filter events/syscalls/sys_enter_io_getevents/filter events/syscalls/sys_e=
nter_io_pgetevents/filter events/syscalls/sys_enter_io_setup/filter events/=
syscalls/sys_enter_io_submit/filter events/syscalls/sys_enter_io_uring_ente=
r/filter events/syscalls/sys_enter_io_uring_register/filter events/syscalls=
/sys_enter_io_uring_setup/filter events/syscalls/sys_enter_ioctl/filter eve=
nts/syscalls/sys_enter_ioperm/filter events/syscalls/sys_enter_iopl/filter =
events/syscalls/sys_enter_ioprio_get/filter events/syscalls/sys_enter_iopri=
o_set/filter events/syscalls/sys_enter_kcmp/filter events/syscalls/sys_ente=
r_kexec_file_load/filter events/syscalls/sys_enter_kexec_load/filter events=
/syscalls/sys_enter_keyctl/filter events/syscalls/sys_enter_kill/filter eve=
nts/syscalls/sys_enter_lchown/filter events/syscalls/sys_enter_lgetxattr/fi=
lter events/syscalls/sys_enter_link/filter events/syscalls/sys_enter_linkat=
/filter events/syscalls/sys_enter_listen/filter events/syscalls/sys_enter_l=
istmount/filter events/syscalls/sys_enter_listns/filter events/syscalls/sys=
_enter_listxattr/filter events/syscalls/sys_enter_listxattrat/filter events=
/syscalls/sys_enter_llistxattr/filter events/syscalls/sys_enter_lremovexatt=
r/filter events/syscalls/sys_enter_lseek/filter events/syscalls/sys_enter_l=
setxattr/filter events/syscalls/sys_enter_lsm_get_self_attr/filter events/s=
yscalls/sys_enter_lsm_list_modules/filter events/syscalls/sys_enter_lsm_set=
_self_attr/filter events/syscalls/sys_enter_madvise/filter events/syscalls/=
sys_enter_mbind/filter events/syscalls/sys_enter_membarrier/filter events/s=
yscalls/sys_enter_memfd_create/filter events/syscalls/sys_enter_memfd_secre=
t/filter events/syscalls/sys_enter_migrate_pages/filter events/syscalls/sys=
_enter_mincore/filter events/syscalls/sys_enter_mkdir/filter events/syscall=
s/sys_enter_mkdirat/filter events/syscalls/sys_enter_mknod/filter events/sy=
scalls/sys_enter_mknodat/filter events/syscalls/sys_enter_mlock/filter even=
ts/syscalls/sys_enter_mlock2/filter events/syscalls/sys_enter_mlockall/filt=
er events/syscalls/sys_enter_mmap/filter events/syscalls/sys_enter_modify_l=
dt/filter events/syscalls/sys_enter_mount/filter events/syscalls/sys_enter_=
mount_setattr/filter events/syscalls/sys_enter_move_mount/filter events/sys=
calls/sys_enter_move_pages/filter events/syscalls/sys_enter_mprotect/filter=
 events/syscalls/sys_enter_mq_getsetattr/filter events/syscalls/sys_enter_m=
q_notify/filter events/syscalls/sys_enter_mq_open/filter events/syscalls/sy=
s_enter_mq_timedreceive/filter events/syscalls/sys_enter_mq_timedsend/filte=
r events/syscalls/sys_enter_mq_unlink/filter events/syscalls/sys_enter_mrem=
ap/filter events/syscalls/sys_enter_mseal/filter events/syscalls/sys_enter_=
msgctl/filter events/syscalls/sys_enter_msgget/filter events/syscalls/sys_e=
nter_msgrcv/filter events/syscalls/sys_enter_msgsnd/filter events/syscalls/=
sys_enter_msync/filter events/syscalls/sys_enter_munlock/filter events/sysc=
alls/sys_enter_munlockall/filter events/syscalls/sys_enter_munmap/filter ev=
ents/syscalls/sys_enter_name_to_handle_at/filter events/syscalls/sys_enter_=
nanosleep/filter events/syscalls/sys_enter_newfstat/filter events/syscalls/=
sys_enter_newfstatat/filter events/syscalls/sys_enter_newlstat/filter event=
s/syscalls/sys_enter_newstat/filter events/syscalls/sys_enter_newuname/filt=
er events/syscalls/sys_enter_open/filter events/syscalls/sys_enter_open_by_=
handle_at/filter events/syscalls/sys_enter_open_tree/filter events/syscalls=
/sys_enter_open_tree_attr/filter events/syscalls/sys_enter_openat/filter ev=
ents/syscalls/sys_enter_openat2/filter events/syscalls/sys_enter_pause/filt=
er events/syscalls/sys_enter_perf_event_open/filter events/syscalls/sys_ent=
er_personality/filter events/syscalls/sys_enter_pidfd_getfd/filter events/s=
yscalls/sys_enter_pidfd_open/filter events/syscalls/sys_enter_pidfd_send_si=
gnal/filter events/syscalls/sys_enter_pipe/filter events/syscalls/sys_enter=
_pipe2/filter events/syscalls/sys_enter_pivot_root/filter events/syscalls/s=
ys_enter_pkey_alloc/filter events/syscalls/sys_enter_pkey_free/filter event=
s/syscalls/sys_enter_pkey_mprotect/filter events/syscalls/sys_enter_poll/fi=
lter events/syscalls/sys_enter_ppoll/filter events/syscalls/sys_enter_prctl=
/filter events/syscalls/sys_enter_pread64/filter events/syscalls/sys_enter_=
preadv/filter events/syscalls/sys_enter_preadv2/filter events/syscalls/sys_=
enter_prlimit64/filter events/syscalls/sys_enter_process_madvise/filter eve=
nts/syscalls/sys_enter_process_mrelease/filter events/syscalls/sys_enter_pr=
ocess_vm_readv/filter events/syscalls/sys_enter_process_vm_writev/filter ev=
ents/syscalls/sys_enter_pselect6/filter events/syscalls/sys_enter_ptrace/fi=
lter events/syscalls/sys_enter_pwrite64/filter events/syscalls/sys_enter_pw=
ritev/filter events/syscalls/sys_enter_pwritev2/filter events/syscalls/sys_=
enter_quotactl/filter events/syscalls/sys_enter_quotactl_fd/filter events/s=
yscalls/sys_enter_read/filter events/syscalls/sys_enter_readahead/filter ev=
ents/syscalls/sys_enter_readlink/filter events/syscalls/sys_enter_readlinka=
t/filter events/syscalls/sys_enter_readv/filter events/syscalls/sys_enter_r=
eboot/filter events/syscalls/sys_enter_recvfrom/filter events/syscalls/sys_=
enter_recvmmsg/filter events/syscalls/sys_enter_recvmsg/filter events/sysca=
lls/sys_enter_remap_file_pages/filter events/syscalls/sys_enter_removexattr=
/filter events/syscalls/sys_enter_removexattrat/filter events/syscalls/sys_=
enter_rename/filter events/syscalls/sys_enter_renameat/filter events/syscal=
ls/sys_enter_renameat2/filter events/syscalls/sys_enter_request_key/filter =
events/syscalls/sys_enter_restart_syscall/filter events/syscalls/sys_enter_=
rmdir/filter events/syscalls/sys_enter_rseq/filter events/syscalls/sys_ente=
r_rt_sigaction/filter events/syscalls/sys_enter_rt_sigpending/filter events=
/syscalls/sys_enter_rt_sigprocmask/filter events/syscalls/sys_enter_rt_sigq=
ueueinfo/filter events/syscalls/sys_enter_rt_sigreturn/filter events/syscal=
ls/sys_enter_rt_sigsuspend/filter events/syscalls/sys_enter_rt_sigtimedwait=
/filter events/syscalls/sys_enter_rt_tgsigqueueinfo/filter events/syscalls/=
sys_enter_sched_get_priority_max/filter events/syscalls/sys_enter_sched_get=
_priority_min/filter events/syscalls/sys_enter_sched_getaffinity/filter eve=
nts/syscalls/sys_enter_sched_getattr/filter events/syscalls/sys_enter_sched=
_getparam/filter events/syscalls/sys_enter_sched_getscheduler/filter events=
/syscalls/sys_enter_sched_rr_get_interval/filter events/syscalls/sys_enter_=
sched_setaffinity/filter events/syscalls/sys_enter_sched_setattr/filter eve=
nts/syscalls/sys_enter_sched_setparam/filter events/syscalls/sys_enter_sche=
d_setscheduler/filter events/syscalls/sys_enter_sched_yield/filter events/s=
yscalls/sys_enter_seccomp/filter events/syscalls/sys_enter_select/filter ev=
ents/syscalls/sys_enter_semctl/filter events/syscalls/sys_enter_semget/filt=
er events/syscalls/sys_enter_semop/filter events/syscalls/sys_enter_semtime=
dop/filter events/syscalls/sys_enter_sendfile64/filter events/syscalls/sys_=
enter_sendmmsg/filter events/syscalls/sys_enter_sendmsg/filter events/sysca=
lls/sys_enter_sendto/filter events/syscalls/sys_enter_set_mempolicy/filter =
events/syscalls/sys_enter_set_mempolicy_home_node/filter events/syscalls/sy=
s_enter_set_robust_list/filter events/syscalls/sys_enter_set_tid_address/fi=
lter events/syscalls/sys_enter_setdomainname/filter events/syscalls/sys_ent=
er_setfsgid/filter events/syscalls/sys_enter_setfsuid/filter events/syscall=
s/sys_enter_setgid/filter events/syscalls/sys_enter_setgroups/filter events=
/syscalls/sys_enter_sethostname/filter events/syscalls/sys_enter_setitimer/=
filter events/syscalls/sys_enter_setns/filter events/syscalls/sys_enter_set=
pgid/filter events/syscalls/sys_enter_setpriority/filter events/syscalls/sy=
s_enter_setregid/filter events/syscalls/sys_enter_setresgid/filter events/s=
yscalls/sys_enter_setresuid/filter events/syscalls/sys_enter_setreuid/filte=
r events/syscalls/sys_enter_setrlimit/filter events/syscalls/sys_enter_sets=
id/filter events/syscalls/sys_enter_setsockopt/filter events/syscalls/sys_e=
nter_settimeofday/filter events/syscalls/sys_enter_setuid/filter events/sys=
calls/sys_enter_setxattr/filter events/syscalls/sys_enter_setxattrat/filter=
 events/syscalls/sys_enter_shmat/filter events/syscalls/sys_enter_shmctl/fi=
lter events/syscalls/sys_enter_shmdt/filter events/syscalls/sys_enter_shmge=
t/filter events/syscalls/sys_enter_shutdown/filter events/syscalls/sys_ente=
r_sigaltstack/filter events/syscalls/sys_enter_signalfd/filter events/sysca=
lls/sys_enter_signalfd4/filter events/syscalls/sys_enter_socket/filter even=
ts/syscalls/sys_enter_socketpair/filter events/syscalls/sys_enter_splice/fi=
lter events/syscalls/sys_enter_statfs/filter events/syscalls/sys_enter_stat=
mount/filter events/syscalls/sys_enter_statx/filter events/syscalls/sys_ent=
er_swapoff/filter events/syscalls/sys_enter_swapon/filter events/syscalls/s=
ys_enter_symlink/filter events/syscalls/sys_enter_symlinkat/filter events/s=
yscalls/sys_enter_sync/filter events/syscalls/sys_enter_sync_file_range/fil=
ter events/syscalls/sys_enter_syncfs/filter events/syscalls/sys_enter_sysfs=
/filter events/syscalls/sys_enter_sysinfo/filter events/syscalls/sys_enter_=
syslog/filter events/syscalls/sys_enter_tee/filter events/syscalls/sys_ente=
r_tgkill/filter events/syscalls/sys_enter_time/filter events/syscalls/sys_e=
nter_timer_create/filter events/syscalls/sys_enter_timer_delete/filter even=
ts/syscalls/sys_enter_timer_getoverrun/filter events/syscalls/sys_enter_tim=
er_gettime/filter events/syscalls/sys_enter_timer_settime/filter events/sys=
calls/sys_enter_timerfd_create/filter events/syscalls/sys_enter_timerfd_get=
time/filter events/syscalls/sys_enter_timerfd_settime/filter events/syscall=
s/sys_enter_times/filter events/syscalls/sys_enter_tkill/filter events/sysc=
alls/sys_enter_truncate/filter events/syscalls/sys_enter_umask/filter event=
s/syscalls/sys_enter_umount/filter events/syscalls/sys_enter_unlink/filter =
events/syscalls/sys_enter_unlinkat/filter events/syscalls/sys_enter_unshare=
/filter events/syscalls/sys_enter_uprobe/filter events/syscalls/sys_enter_u=
retprobe/filter events/syscalls/sys_enter_userfaultfd/filter events/syscall=
s/sys_enter_ustat/filter events/syscalls/sys_enter_utime/filter events/sysc=
alls/sys_enter_utimensat/filter events/syscalls/sys_enter_utimes/filter eve=
nts/syscalls/sys_enter_vfork/filter events/syscalls/sys_enter_vhangup/filte=
r events/syscalls/sys_enter_vmsplice/filter events/syscalls/sys_enter_wait4=
/filter events/syscalls/sys_enter_waitid/filter events/syscalls/sys_enter_w=
rite/filter events/syscalls/sys_enter_writev/filter events/syscalls/sys_exi=
t_accept/filter events/syscalls/sys_exit_accept4/filter events/syscalls/sys=
_exit_access/filter events/syscalls/sys_exit_acct/filter events/syscalls/sy=
s_exit_add_key/filter events/syscalls/sys_exit_adjtimex/filter events/sysca=
lls/sys_exit_alarm/filter events/syscalls/sys_exit_arch_prctl/filter events=
/syscalls/sys_exit_bind/filter events/syscalls/sys_exit_bpf/filter events/s=
yscalls/sys_exit_brk/filter events/syscalls/sys_exit_cachestat/filter event=
s/syscalls/sys_exit_capget/filter events/syscalls/sys_exit_capset/filter ev=
ents/syscalls/sys_exit_chdir/filter events/syscalls/sys_exit_chmod/filter e=
vents/syscalls/sys_exit_chown/filter events/syscalls/sys_exit_chroot/filter=
 events/syscalls/sys_exit_clock_adjtime/filter events/syscalls/sys_exit_clo=
ck_getres/filter events/syscalls/sys_exit_clock_gettime/filter events/sysca=
lls/sys_exit_clock_nanosleep/filter events/syscalls/sys_exit_clock_settime/=
filter events/syscalls/sys_exit_clone/filter events/syscalls/sys_exit_clone=
3/filter events/syscalls/sys_exit_close/filter events/syscalls/sys_exit_clo=
se_range/filter events/syscalls/sys_exit_connect/filter events/syscalls/sys=
_exit_copy_file_range/filter events/syscalls/sys_exit_creat/filter events/s=
yscalls/sys_exit_delete_module/filter events/syscalls/sys_exit_dup/filter e=
vents/syscalls/sys_exit_dup2/filter events/syscalls/sys_exit_dup3/filter ev=
ents/syscalls/sys_exit_epoll_create/filter events/syscalls/sys_exit_epoll_c=
reate1/filter events/syscalls/sys_exit_epoll_ctl/filter events/syscalls/sys=
_exit_epoll_pwait/filter events/syscalls/sys_exit_epoll_pwait2/filter event=
s/syscalls/sys_exit_epoll_wait/filter events/syscalls/sys_exit_eventfd/filt=
er events/syscalls/sys_exit_eventfd2/filter events/syscalls/sys_exit_execve=
/filter events/syscalls/sys_exit_execveat/filter events/syscalls/sys_exit_e=
xit/filter events/syscalls/sys_exit_exit_group/filter events/syscalls/sys_e=
xit_faccessat/filter events/syscalls/sys_exit_faccessat2/filter events/sysc=
alls/sys_exit_fadvise64/filter events/syscalls/sys_exit_fallocate/filter ev=
ents/syscalls/sys_exit_fanotify_init/filter events/syscalls/sys_exit_fanoti=
fy_mark/filter events/syscalls/sys_exit_fchdir/filter events/syscalls/sys_e=
xit_fchmod/filter events/syscalls/sys_exit_fchmodat/filter events/syscalls/=
sys_exit_fchmodat2/filter events/syscalls/sys_exit_fchown/filter events/sys=
calls/sys_exit_fchownat/filter events/syscalls/sys_exit_fcntl/filter events=
/syscalls/sys_exit_fdatasync/filter events/syscalls/sys_exit_fgetxattr/filt=
er events/syscalls/sys_exit_file_getattr/filter events/syscalls/sys_exit_fi=
le_setattr/filter events/syscalls/sys_exit_finit_module/filter events/sysca=
lls/sys_exit_flistxattr/filter events/syscalls/sys_exit_flock/filter events=
/syscalls/sys_exit_fork/filter events/syscalls/sys_exit_fremovexattr/filter=
 events/syscalls/sys_exit_fsconfig/filter events/syscalls/sys_exit_fsetxatt=
r/filter events/syscalls/sys_exit_fsmount/filter events/syscalls/sys_exit_f=
sopen/filter events/syscalls/sys_exit_fspick/filter events/syscalls/sys_exi=
t_fstatfs/filter events/syscalls/sys_exit_fsync/filter events/syscalls/sys_=
exit_ftruncate/filter events/syscalls/sys_exit_futex/filter events/syscalls=
/sys_exit_futex_requeue/filter events/syscalls/sys_exit_futex_wait/filter e=
vents/syscalls/sys_exit_futex_waitv/filter events/syscalls/sys_exit_futex_w=
ake/filter events/syscalls/sys_exit_futimesat/filter events/syscalls/sys_ex=
it_get_mempolicy/filter events/syscalls/sys_exit_get_robust_list/filter eve=
nts/syscalls/sys_exit_getcpu/filter events/syscalls/sys_exit_getcwd/filter =
events/syscalls/sys_exit_getdents/filter events/syscalls/sys_exit_getdents6=
4/filter events/syscalls/sys_exit_getegid/filter events/syscalls/sys_exit_g=
eteuid/filter events/syscalls/sys_exit_getgid/filter events/syscalls/sys_ex=
it_getgroups/filter events/syscalls/sys_exit_getitimer/filter events/syscal=
ls/sys_exit_getpeername/filter events/syscalls/sys_exit_getpgid/filter even=
ts/syscalls/sys_exit_getpgrp/filter events/syscalls/sys_exit_getpid/filter =
events/syscalls/sys_exit_getppid/filter events/syscalls/sys_exit_getpriorit=
y/filter events/syscalls/sys_exit_getrandom/filter events/syscalls/sys_exit=
_getresgid/filter events/syscalls/sys_exit_getresuid/filter events/syscalls=
/sys_exit_getrlimit/filter events/syscalls/sys_exit_getrusage/filter events=
/syscalls/sys_exit_getsid/filter events/syscalls/sys_exit_getsockname/filte=
r events/syscalls/sys_exit_getsockopt/filter events/syscalls/sys_exit_getti=
d/filter events/syscalls/sys_exit_gettimeofday/filter events/syscalls/sys_e=
xit_getuid/filter events/syscalls/sys_exit_getxattr/filter events/syscalls/=
sys_exit_getxattrat/filter events/syscalls/sys_exit_init_module/filter even=
ts/syscalls/sys_exit_inotify_add_watch/filter events/syscalls/sys_exit_inot=
ify_init/filter events/syscalls/sys_exit_inotify_init1/filter events/syscal=
ls/sys_exit_inotify_rm_watch/filter events/syscalls/sys_exit_io_cancel/filt=
er events/syscalls/sys_exit_io_destroy/filter events/syscalls/sys_exit_io_g=
etevents/filter events/syscalls/sys_exit_io_pgetevents/filter events/syscal=
ls/sys_exit_io_setup/filter events/syscalls/sys_exit_io_submit/filter event=
s/syscalls/sys_exit_io_uring_enter/filter events/syscalls/sys_exit_io_uring=
_register/filter events/syscalls/sys_exit_io_uring_setup/filter events/sysc=
alls/sys_exit_ioctl/filter events/syscalls/sys_exit_ioperm/filter events/sy=
scalls/sys_exit_iopl/filter events/syscalls/sys_exit_ioprio_get/filter even=
ts/syscalls/sys_exit_ioprio_set/filter events/syscalls/sys_exit_kcmp/filter=
 events/syscalls/sys_exit_kexec_file_load/filter events/syscalls/sys_exit_k=
exec_load/filter events/syscalls/sys_exit_keyctl/filter events/syscalls/sys=
_exit_kill/filter events/syscalls/sys_exit_lchown/filter events/syscalls/sy=
s_exit_lgetxattr/filter events/syscalls/sys_exit_link/filter events/syscall=
s/sys_exit_linkat/filter events/syscalls/sys_exit_listen/filter events/sysc=
alls/sys_exit_listmount/filter events/syscalls/sys_exit_listns/filter event=
s/syscalls/sys_exit_listxattr/filter events/syscalls/sys_exit_listxattrat/f=
ilter events/syscalls/sys_exit_llistxattr/filter events/syscalls/sys_exit_l=
removexattr/filter events/syscalls/sys_exit_lseek/filter events/syscalls/sy=
s_exit_lsetxattr/filter events/syscalls/sys_exit_lsm_get_self_attr/filter e=
vents/syscalls/sys_exit_lsm_list_modules/filter events/syscalls/sys_exit_ls=
m_set_self_attr/filter events/syscalls/sys_exit_madvise/filter events/sysca=
lls/sys_exit_mbind/filter events/syscalls/sys_exit_membarrier/filter events=
/syscalls/sys_exit_memfd_create/filter events/syscalls/sys_exit_memfd_secre=
t/filter events/syscalls/sys_exit_migrate_pages/filter events/syscalls/sys_=
exit_mincore/filter events/syscalls/sys_exit_mkdir/filter events/syscalls/s=
ys_exit_mkdirat/filter events/syscalls/sys_exit_mknod/filter events/syscall=
s/sys_exit_mknodat/filter events/syscalls/sys_exit_mlock/filter events/sysc=
alls/sys_exit_mlock2/filter events/syscalls/sys_exit_mlockall/filter events=
/syscalls/sys_exit_mmap/filter events/syscalls/sys_exit_modify_ldt/filter e=
vents/syscalls/sys_exit_mount/filter events/syscalls/sys_exit_mount_setattr=
/filter events/syscalls/sys_exit_move_mount/filter events/syscalls/sys_exit=
_move_pages/filter events/syscalls/sys_exit_mprotect/filter events/syscalls=
/sys_exit_mq_getsetattr/filter events/syscalls/sys_exit_mq_notify/filter ev=
ents/syscalls/sys_exit_mq_open/filter events/syscalls/sys_exit_mq_timedrece=
ive/filter events/syscalls/sys_exit_mq_timedsend/filter events/syscalls/sys=
_exit_mq_unlink/filter events/syscalls/sys_exit_mremap/filter events/syscal=
ls/sys_exit_mseal/filter events/syscalls/sys_exit_msgctl/filter events/sysc=
alls/sys_exit_msgget/filter events/syscalls/sys_exit_msgrcv/filter events/s=
yscalls/sys_exit_msgsnd/filter events/syscalls/sys_exit_msync/filter events=
/syscalls/sys_exit_munlock/filter events/syscalls/sys_exit_munlockall/filte=
r events/syscalls/sys_exit_munmap/filter events/syscalls/sys_exit_name_to_h=
andle_at/filter events/syscalls/sys_exit_nanosleep/filter events/syscalls/s=
ys_exit_newfstat/filter events/syscalls/sys_exit_newfstatat/filter events/s=
yscalls/sys_exit_newlstat/filter events/syscalls/sys_exit_newstat/filter ev=
ents/syscalls/sys_exit_newuname/filter events/syscalls/sys_exit_open/filter=
 events/syscalls/sys_exit_open_by_handle_at/filter events/syscalls/sys_exit=
_open_tree/filter events/syscalls/sys_exit_open_tree_attr/filter events/sys=
calls/sys_exit_openat/filter events/syscalls/sys_exit_openat2/filter events=
/syscalls/sys_exit_pause/filter events/syscalls/sys_exit_perf_event_open/fi=
lter events/syscalls/sys_exit_personality/filter events/syscalls/sys_exit_p=
idfd_getfd/filter events/syscalls/sys_exit_pidfd_open/filter events/syscall=
s/sys_exit_pidfd_send_signal/filter events/syscalls/sys_exit_pipe/filter ev=
ents/syscalls/sys_exit_pipe2/filter events/syscalls/sys_exit_pivot_root/fil=
ter events/syscalls/sys_exit_pkey_alloc/filter events/syscalls/sys_exit_pke=
y_free/filter events/syscalls/sys_exit_pkey_mprotect/filter events/syscalls=
/sys_exit_poll/filter events/syscalls/sys_exit_ppoll/filter events/syscalls=
/sys_exit_prctl/filter events/syscalls/sys_exit_pread64/filter events/sysca=
lls/sys_exit_preadv/filter events/syscalls/sys_exit_preadv2/filter events/s=
yscalls/sys_exit_prlimit64/filter events/syscalls/sys_exit_process_madvise/=
filter events/syscalls/sys_exit_process_mrelease/filter events/syscalls/sys=
_exit_process_vm_readv/filter events/syscalls/sys_exit_process_vm_writev/fi=
lter events/syscalls/sys_exit_pselect6/filter events/syscalls/sys_exit_ptra=
ce/filter events/syscalls/sys_exit_pwrite64/filter events/syscalls/sys_exit=
_pwritev/filter events/syscalls/sys_exit_pwritev2/filter events/syscalls/sy=
s_exit_quotactl/filter events/syscalls/sys_exit_quotactl_fd/filter events/s=
yscalls/sys_exit_read/filter events/syscalls/sys_exit_readahead/filter even=
ts/syscalls/sys_exit_readlink/filter events/syscalls/sys_exit_readlinkat/fi=
lter events/syscalls/sys_exit_readv/filter events/syscalls/sys_exit_reboot/=
filter events/syscalls/sys_exit_recvfrom/filter events/syscalls/sys_exit_re=
cvmmsg/filter events/syscalls/sys_exit_recvmsg/filter events/syscalls/sys_e=
xit_remap_file_pages/filter events/syscalls/sys_exit_removexattr/filter eve=
nts/syscalls/sys_exit_removexattrat/filter events/syscalls/sys_exit_rename/=
filter events/syscalls/sys_exit_renameat/filter events/syscalls/sys_exit_re=
nameat2/filter events/syscalls/sys_exit_request_key/filter events/syscalls/=
sys_exit_restart_syscall/filter events/syscalls/sys_exit_rmdir/filter event=
s/syscalls/sys_exit_rseq/filter events/syscalls/sys_exit_rt_sigaction/filte=
r events/syscalls/sys_exit_rt_sigpending/filter events/syscalls/sys_exit_rt=
_sigprocmask/filter events/syscalls/sys_exit_rt_sigqueueinfo/filter events/=
syscalls/sys_exit_rt_sigreturn/filter events/syscalls/sys_exit_rt_sigsuspen=
d/filter events/syscalls/sys_exit_rt_sigtimedwait/filter events/syscalls/sy=
s_exit_rt_tgsigqueueinfo/filter events/syscalls/sys_exit_sched_get_priority=
_max/filter events/syscalls/sys_exit_sched_get_priority_min/filter events/s=
yscalls/sys_exit_sched_getaffinity/filter events/syscalls/sys_exit_sched_ge=
tattr/filter events/syscalls/sys_exit_sched_getparam/filter events/syscalls=
/sys_exit_sched_getscheduler/filter events/syscalls/sys_exit_sched_rr_get_i=
nterval/filter events/syscalls/sys_exit_sched_setaffinity/filter events/sys=
calls/sys_exit_sched_setattr/filter events/syscalls/sys_exit_sched_setparam=
/filter events/syscalls/sys_exit_sched_setscheduler/filter events/syscalls/=
sys_exit_sched_yield/filter events/syscalls/sys_exit_seccomp/filter events/=
syscalls/sys_exit_select/filter events/syscalls/sys_exit_semctl/filter even=
ts/syscalls/sys_exit_semget/filter events/syscalls/sys_exit_semop/filter ev=
ents/syscalls/sys_exit_semtimedop/filter events/syscalls/sys_exit_sendfile6=
4/filter events/syscalls/sys_exit_sendmmsg/filter events/syscalls/sys_exit_=
sendmsg/filter events/syscalls/sys_exit_sendto/filter events/syscalls/sys_e=
xit_set_mempolicy/filter events/syscalls/sys_exit_set_mempolicy_home_node/f=
ilter events/syscalls/sys_exit_set_robust_list/filter events/syscalls/sys_e=
xit_set_tid_address/filter events/syscalls/sys_exit_setdomainname/filter ev=
ents/syscalls/sys_exit_setfsgid/filter events/syscalls/sys_exit_setfsuid/fi=
lter events/syscalls/sys_exit_setgid/filter events/syscalls/sys_exit_setgro=
ups/filter events/syscalls/sys_exit_sethostname/filter events/syscalls/sys_=
exit_setitimer/filter events/syscalls/sys_exit_setns/filter events/syscalls=
/sys_exit_setpgid/filter events/syscalls/sys_exit_setpriority/filter events=
/syscalls/sys_exit_setregid/filter events/syscalls/sys_exit_setresgid/filte=
r events/syscalls/sys_exit_setresuid/filter events/syscalls/sys_exit_setreu=
id/filter events/syscalls/sys_exit_setrlimit/filter events/syscalls/sys_exi=
t_setsid/filter events/syscalls/sys_exit_setsockopt/filter events/syscalls/=
sys_exit_settimeofday/filter events/syscalls/sys_exit_setuid/filter events/=
syscalls/sys_exit_setxattr/filter events/syscalls/sys_exit_setxattrat/filte=
r events/syscalls/sys_exit_shmat/filter events/syscalls/sys_exit_shmctl/fil=
ter events/syscalls/sys_exit_shmdt/filter events/syscalls/sys_exit_shmget/f=
ilter events/syscalls/sys_exit_shutdown/filter events/syscalls/sys_exit_sig=
altstack/filter events/syscalls/sys_exit_signalfd/filter events/syscalls/sy=
s_exit_signalfd4/filter events/syscalls/sys_exit_socket/filter events/sysca=
lls/sys_exit_socketpair/filter events/syscalls/sys_exit_splice/filter event=
s/syscalls/sys_exit_statfs/filter events/syscalls/sys_exit_statmount/filter=
 events/syscalls/sys_exit_statx/filter events/syscalls/sys_exit_swapoff/fil=
ter events/syscalls/sys_exit_swapon/filter events/syscalls/sys_exit_symlink=
/filter events/syscalls/sys_exit_symlinkat/filter events/syscalls/sys_exit_=
sync/filter events/syscalls/sys_exit_sync_file_range/filter events/syscalls=
/sys_exit_syncfs/filter events/syscalls/sys_exit_sysfs/filter events/syscal=
ls/sys_exit_sysinfo/filter events/syscalls/sys_exit_syslog/filter events/sy=
scalls/sys_exit_tee/filter events/syscalls/sys_exit_tgkill/filter events/sy=
scalls/sys_exit_time/filter events/syscalls/sys_exit_timer_create/filter ev=
ents/syscalls/sys_exit_timer_delete/filter events/syscalls/sys_exit_timer_g=
etoverrun/filter events/syscalls/sys_exit_timer_gettime/filter events/sysca=
lls/sys_exit_timer_settime/filter events/syscalls/sys_exit_timerfd_create/f=
ilter events/syscalls/sys_exit_timerfd_gettime/filter events/syscalls/sys_e=
xit_timerfd_settime/filter events/syscalls/sys_exit_times/filter events/sys=
calls/sys_exit_tkill/filter events/syscalls/sys_exit_truncate/filter events=
/syscalls/sys_exit_umask/filter events/syscalls/sys_exit_umount/filter even=
ts/syscalls/sys_exit_unlink/filter events/syscalls/sys_exit_unlinkat/filter=
 events/syscalls/sys_exit_unshare/filter events/syscalls/sys_exit_uprobe/fi=
lter events/syscalls/sys_exit_uretprobe/filter events/syscalls/sys_exit_use=
rfaultfd/filter events/syscalls/sys_exit_ustat/filter events/syscalls/sys_e=
xit_utime/filter events/syscalls/sys_exit_utimensat/filter events/syscalls/=
sys_exit_utimes/filter events/syscalls/sys_exit_vfork/filter events/syscall=
s/sys_exit_vhangup/filter events/syscalls/sys_exit_vmsplice/filter events/s=
yscalls/sys_exit_wait4/filter events/syscalls/sys_exit_waitid/filter events=
/syscalls/sys_exit_write/filter events/syscalls/sys_exit_writev/filter even=
ts/task/task_newtask/filter events/task/task_prctl_unknown/filter events/ta=
sk/task_rename/filter events/tcp/tcp_ao_handshake_failure/filter events/tcp=
/tcp_ao_key_not_found/filter events/tcp/tcp_ao_mismatch/filter events/tcp/t=
cp_ao_rcv_sne_update/filter events/tcp/tcp_ao_rnext_request/filter events/t=
cp/tcp_ao_snd_sne_update/filter events/tcp/tcp_ao_synack_no_key/filter even=
ts/tcp/tcp_ao_wrong_maclen/filter events/tcp/tcp_bad_csum/filter events/tcp=
/tcp_cong_state_set/filter events/tcp/tcp_destroy_sock/filter events/tcp/tc=
p_hash_ao_required/filter events/tcp/tcp_hash_bad_header/filter events/tcp/=
tcp_hash_md5_mismatch/filter events/tcp/tcp_hash_md5_required/filter events=
/tcp/tcp_hash_md5_unexpected/filter events/tcp/tcp_probe/filter events/tcp/=
tcp_rcv_space_adjust/filter events/tcp/tcp_rcvbuf_grow/filter events/tcp/tc=
p_receive_reset/filter events/tcp/tcp_retransmit_skb/filter events/tcp/tcp_=
retransmit_synack/filter events/tcp/tcp_send_reset/filter events/tcp/tcp_se=
ndmsg_locked/filter events/thermal/cdev_update/filter events/thermal/therma=
l_temperature/filter events/thermal/thermal_zone_trip/filter events/thp/rem=
ove_migration_pmd/filter events/thp/set_migration_pmd/filter events/thunder=
bolt/tb_event/filter events/thunderbolt/tb_rx/filter events/thunderbolt/tb_=
tx/filter events/timer/hrtimer_cancel/filter events/timer/hrtimer_expire_en=
try/filter events/timer/hrtimer_expire_exit/filter events/timer/hrtimer_rea=
rm/filter events/timer/hrtimer_setup/filter events/timer/hrtimer_start/filt=
er events/timer/hrtimer_start_expired/filter events/timer/itimer_expire/fil=
ter events/timer/itimer_state/filter events/timer/tick_stop/filter events/t=
imer/timer_base_idle/filter events/timer/timer_cancel/filter events/timer/t=
imer_expire_entry/filter events/timer/timer_expire_exit/filter events/timer=
/timer_init/filter events/timer/timer_start/filter events/timer_migration/t=
migr_connect_child_parent/filter events/timer_migration/tmigr_connect_cpu_p=
arent/filter events/timer_migration/tmigr_cpu_active/filter events/timer_mi=
gration/tmigr_cpu_available/filter events/timer_migration/tmigr_cpu_idle/fi=
lter events/timer_migration/tmigr_cpu_new_timer/filter events/timer_migrati=
on/tmigr_cpu_new_timer_idle/filter events/timer_migration/tmigr_cpu_unavail=
able/filter events/timer_migration/tmigr_group_set/filter events/timer_migr=
ation/tmigr_group_set_cpu_active/filter events/timer_migration/tmigr_group_=
set_cpu_inactive/filter events/timer_migration/tmigr_handle_remote/filter e=
vents/timer_migration/tmigr_handle_remote_cpu/filter events/timer_migration=
/tmigr_update_events/filter events/timestamp/ctime_ns_xchg/filter events/ti=
mestamp/ctime_xchg_skip/filter events/timestamp/fill_mg_cmtime/filter event=
s/timestamp/inode_set_ctime_to_ts/filter events/tlb/tlb_flush/filter events=
/tsm_mr/tsm_mr_read/filter events/tsm_mr/tsm_mr_refresh/filter events/tsm_m=
r/tsm_mr_write/filter events/ucsi/ucsi_connector_change/filter events/ucsi/=
ucsi_register_altmode/filter events/ucsi/ucsi_register_port/filter events/u=
csi/ucsi_reset_ppm/filter events/ucsi/ucsi_run_command/filter events/udp/ud=
p_fail_queue_rcv_skb/filter events/usbcore/usb_alloc_dev/filter events/usbc=
ore/usb_set_device_state/filter events/vmalloc/alloc_vmap_area/filter event=
s/vmalloc/free_vmap_area_noflush/filter events/vmalloc/purge_vmap_area_lazy=
/filter events/vmscan/mm_shrink_slab_end/filter events/vmscan/mm_shrink_sla=
b_start/filter events/vmscan/mm_vmscan_balance_pgdat_begin/filter events/vm=
scan/mm_vmscan_balance_pgdat_end/filter events/vmscan/mm_vmscan_direct_recl=
aim_begin/filter events/vmscan/mm_vmscan_direct_reclaim_end/filter events/v=
mscan/mm_vmscan_kswapd_clear_hopeless/filter events/vmscan/mm_vmscan_kswapd=
_reclaim_fail/filter events/vmscan/mm_vmscan_kswapd_sleep/filter events/vms=
can/mm_vmscan_kswapd_wake/filter events/vmscan/mm_vmscan_lru_isolate/filter=
 events/vmscan/mm_vmscan_lru_shrink_active/filter events/vmscan/mm_vmscan_l=
ru_shrink_inactive/filter events/vmscan/mm_vmscan_memcg_reclaim_begin/filte=
r events/vmscan/mm_vmscan_memcg_reclaim_end/filter events/vmscan/mm_vmscan_=
memcg_softlimit_reclaim_begin/filter events/vmscan/mm_vmscan_memcg_softlimi=
t_reclaim_end/filter events/vmscan/mm_vmscan_node_reclaim_begin/filter even=
ts/vmscan/mm_vmscan_node_reclaim_end/filter events/vmscan/mm_vmscan_reclaim=
_pages/filter events/vmscan/mm_vmscan_throttled/filter events/vmscan/mm_vms=
can_wakeup_kswapd/filter events/vmscan/mm_vmscan_write_folio/filter events/=
vsyscall/emulate_vsyscall/filter events/watchdog/watchdog_ping/filter event=
s/watchdog/watchdog_set_timeout/filter events/watchdog/watchdog_start/filte=
r events/watchdog/watchdog_stop/filter events/wbt/wbt_lat/filter events/wbt=
/wbt_stat/filter events/wbt/wbt_step/filter events/wbt/wbt_timer/filter eve=
nts/workqueue/workqueue_activate_work/filter events/workqueue/workqueue_exe=
cute_end/filter events/workqueue/workqueue_execute_start/filter events/work=
queue/workqueue_queue_work/filter events/writeback/balance_dirty_pages/filt=
er events/writeback/bdi_dirty_ratelimit/filter events/writeback/flush_forei=
gn/filter events/writeback/folio_wait_writeback/filter events/writeback/glo=
bal_dirty_state/filter events/writeback/inode_foreign_history/filter events=
/writeback/inode_switch_wbs/filter events/writeback/inode_switch_wbs_queue/=
filter events/writeback/sb_clear_inode_writeback/filter events/writeback/sb=
_mark_inode_writeback/filter events/writeback/track_foreign_dirty/filter ev=
ents/writeback/wbc_writepage/filter events/writeback/writeback_bdi_register=
/filter events/writeback/writeback_dirty_folio/filter events/writeback/writ=
eback_dirty_inode/filter events/writeback/writeback_dirty_inode_enqueue/fil=
ter events/writeback/writeback_dirty_inode_start/filter events/writeback/wr=
iteback_exec/filter events/writeback/writeback_lazytime/filter events/write=
back/writeback_mark_inode_dirty/filter events/writeback/writeback_pages_wri=
tten/filter events/writeback/writeback_queue/filter events/writeback/writeb=
ack_queue_io/filter events/writeback/writeback_sb_inodes_requeue/filter eve=
nts/writeback/writeback_single_inode/filter events/writeback/writeback_sing=
le_inode_start/filter events/writeback/writeback_start/filter events/writeb=
ack/writeback_wait/filter events/writeback/writeback_wake_background/filter=
 events/writeback/writeback_write_inode/filter events/writeback/writeback_w=
rite_inode_start/filter events/writeback/writeback_written/filter events/x8=
6_fpu/x86_fpu_after_save/filter events/x86_fpu/x86_fpu_before_save/filter e=
vents/x86_fpu/x86_fpu_copy_dst/filter events/x86_fpu/x86_fpu_dropped/filter=
 events/x86_fpu/x86_fpu_regs_activated/filter events/x86_fpu/x86_fpu_regs_d=
eactivated/filter events/x86_fpu/x86_fpu_xstate_check_failed/filter events/=
xdp/bpf_xdp_link_attach_failed/filter events/xdp/mem_connect/filter events/=
xdp/mem_disconnect/filter events/xdp/xdp_bulk_tx/filter events/xdp/xdp_cpum=
ap_enqueue/filter events/xdp/xdp_cpumap_kthread/filter events/xdp/xdp_devma=
p_xmit/filter events/xdp/xdp_exception/filter events/xdp/xdp_redirect/filte=
r events/xdp/xdp_redirect_err/filter events/xen/xen_cpu_load_idt/filter eve=
nts/xen/xen_cpu_set_ldt/filter events/xen/xen_cpu_write_gdt_entry/filter ev=
ents/xen/xen_cpu_write_idt_entry/filter events/xen/xen_cpu_write_ldt_entry/=
filter events/xen/xen_mc_batch/filter events/xen/xen_mc_callback/filter eve=
nts/xen/xen_mc_entry/filter events/xen/xen_mc_entry_alloc/filter events/xen=
/xen_mc_extend_args/filter events/xen/xen_mc_flush/filter events/xen/xen_mc=
_flush_reason/filter events/xen/xen_mc_issue/filter events/xen/xen_mmu_allo=
c_ptpage/filter events/xen/xen_mmu_flush_tlb_multi/filter events/xen/xen_mm=
u_flush_tlb_one_user/filter events/xen/xen_mmu_pgd_pin/filter events/xen/xe=
n_mmu_pgd_unpin/filter events/xen/xen_mmu_ptep_modify_prot_commit/filter ev=
ents/xen/xen_mmu_ptep_modify_prot_start/filter events/xen/xen_mmu_release_p=
tpage/filter events/xen/xen_mmu_set_p4d/filter events/xen/xen_mmu_set_pmd/f=
ilter events/xen/xen_mmu_set_pte/filter events/xen/xen_mmu_set_pud/filter e=
vents/xen/xen_mmu_write_cr3/filter events/xhci-hcd/xhci_add_endpoint/filter=
 events/xhci-hcd/xhci_address_ctrl_ctx/filter events/xhci-hcd/xhci_address_=
ctx/filter events/xhci-hcd/xhci_alloc_dev/filter events/xhci-hcd/xhci_alloc=
_stream_info_ctx/filter events/xhci-hcd/xhci_alloc_virt_device/filter event=
s/xhci-hcd/xhci_configure_endpoint/filter events/xhci-hcd/xhci_configure_en=
dpoint_ctrl_ctx/filter events/xhci-hcd/xhci_dbc_alloc_request/filter events=
/xhci-hcd/xhci_dbc_free_request/filter events/xhci-hcd/xhci_dbc_gadget_ep_q=
ueue/filter events/xhci-hcd/xhci_dbc_giveback_request/filter events/xhci-hc=
d/xhci_dbc_handle_event/filter events/xhci-hcd/xhci_dbc_handle_transfer/fil=
ter events/xhci-hcd/xhci_dbc_queue_request/filter events/xhci-hcd/xhci_dbg_=
address/filter events/xhci-hcd/xhci_dbg_cancel_urb/filter events/xhci-hcd/x=
hci_dbg_context_change/filter events/xhci-hcd/xhci_dbg_init/filter events/x=
hci-hcd/xhci_dbg_quirks/filter events/xhci-hcd/xhci_dbg_reset_ep/filter eve=
nts/xhci-hcd/xhci_dbg_ring_expansion/filter events/xhci-hcd/xhci_discover_o=
r_reset_device/filter events/xhci-hcd/xhci_free_dev/filter events/xhci-hcd/=
xhci_free_virt_device/filter events/xhci-hcd/xhci_get_port_status/filter ev=
ents/xhci-hcd/xhci_handle_cmd_addr_dev/filter events/xhci-hcd/xhci_handle_c=
md_config_ep/filter events/xhci-hcd/xhci_handle_cmd_disable_slot/filter eve=
nts/xhci-hcd/xhci_handle_cmd_reset_dev/filter events/xhci-hcd/xhci_handle_c=
md_reset_ep/filter events/xhci-hcd/xhci_handle_cmd_set_deq/filter events/xh=
ci-hcd/xhci_handle_cmd_set_deq_ep/filter events/xhci-hcd/xhci_handle_cmd_se=
t_deq_stream/filter events/xhci-hcd/xhci_handle_cmd_stop_ep/filter events/x=
hci-hcd/xhci_handle_command/filter events/xhci-hcd/xhci_handle_event/filter=
 events/xhci-hcd/xhci_handle_port_status/filter events/xhci-hcd/xhci_handle=
_transfer/filter events/xhci-hcd/xhci_hub_status_data/filter events/xhci-hc=
d/xhci_inc_deq/filter events/xhci-hcd/xhci_inc_enq/filter events/xhci-hcd/x=
hci_portsc_writel/filter events/xhci-hcd/xhci_queue_trb/filter events/xhci-=
hcd/xhci_ring_alloc/filter events/xhci-hcd/xhci_ring_ep_doorbell/filter eve=
nts/xhci-hcd/xhci_ring_expansion/filter events/xhci-hcd/xhci_ring_free/filt=
er events/xhci-hcd/xhci_ring_host_doorbell/filter events/xhci-hcd/xhci_setu=
p_addressable_virt_device/filter events/xhci-hcd/xhci_setup_device/filter e=
vents/xhci-hcd/xhci_setup_device_slot/filter events/xhci-hcd/xhci_stop_devi=
ce/filter events/xhci-hcd/xhci_urb_dequeue/filter events/xhci-hcd/xhci_urb_=
enqueue/filter events/xhci-hcd/xhci_urb_giveback/filter
# # + reset_ftrace_filter
# # + '[' '!' -f set_ftrace_filter ']'
# # + echo
# # + grep -v '^#' set_ftrace_filter
# # + read t
# # + disable_events
# # + echo 0
# # + clear_dynamic_events
# # + again=3D1
# # + stop=3D1
# # + '[' 1 -eq 1 ']'
# # + stop=3D2
# # + '[' 2 -gt 10 ']'
# # + again=3D2
# # + grep -v '^#' dynamic_events
# # + read line
# # ++ echo p:kprobes/kpevent kfree object=3Dobject
# # ++ sed -e 's/^.([^ ]*).*/-1/'
# # + del=3D-:kprobes/kpevent
# # + echo -:kprobes/kpevent
# # + read line
# # + '[' 2 -eq 1 ']'
# # + '[' -f set_event_pid ']'
# # + echo
# # + '[' -f set_ftrace_pid ']'
# # + echo
# # + '[' -f set_ftrace_notrace ']'
# # + echo
# # + '[' -f set_graph_function ']'
# # + echo
# # + tee set_graph_function set_graph_notrace
# #=20
# # + '[' -f stack_trace_filter ']'
# # + echo
# # + '[' -f kprobe_events ']'
# # + echo
# # + '[' -f uprobe_events ']'
# # + echo
# # + '[' -f synthetic_events ']'
# # + echo
# # + '[' -f snapshot ']'
# # + echo 0
# # + '[' -f options/pause-on-trace ']'
# # + echo 1
# # + clear_trace
# # + echo
# # + enable_tracing
# # + echo 1
# # + . /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-206b25c09080cc20fd4c2be=
a12d59df4b7ba2121/tools/testing/selftests/ftrace/test.d/dynevent/add_remove=
_eprobe.tc
# # ++ echo 0
# # ++ clear_dynamic_events
# # ++ again=3D1
# # ++ stop=3D1
# # ++ '[' 1 -eq 1 ']'
# # ++ stop=3D2
# # ++ '[' 2 -gt 10 ']'
# # ++ again=3D2
# # ++ grep -v '^#' dynamic_events
# # ++ read line
# # ++ '[' 2 -eq 1 ']'
# # ++ SYSTEM=3Dsyscalls
# # ++ EVENT=3Dsys_enter_openat
# # ++ FIELD=3Dfilename
# # ++ EPROBE=3Deprobe_open
# # ++ OPTIONS=3D'file=3D+0($filename):ustring'
# # ++ echo 'e:eprobe_open syscalls/sys_enter_openat file=3D+0($filename):u=
string'
# # ++ grep -q eprobe_open dynamic_events
# # ++ test -d events/eprobes/eprobe_open
# # ++ echo 1
# # ++ ls
# # README
# # available_events
# # available_filter_functions
# # available_filter_functions_addrs
# # available_tracers
# # buffer_percent
# # buffer_size_kb
# # buffer_subbuf_size_kb
# # buffer_total_size_kb
# # current_tracer
# # dyn_ftrace_total_info
# # dynamic_events
# # enabled_functions
# # error_log
# # events
# # free_buffer
# # function_profile_enabled
# # hwlat_detector
# # instances
# # kprobe_events
# # kprobe_profile
# # max_graph_depth
# # options
# # osnoise
# # per_cpu
# # printk_formats
# # rv
# # saved_cmdlines
# # saved_cmdlines_size
# # saved_tgids
# # set_event
# # set_event_notrace_pid
# # set_event_pid
# # set_ftrace_filter
# # set_ftrace_notrace
# # set_ftrace_notrace_pid
# # set_ftrace_pid
# # set_graph_function
# # set_graph_notrace
# # show_event_filters
# # show_event_triggers
# # snapshot
# # stack_max_size
# # stack_trace
# # stack_trace_filter
# # synthetic_events
# # syscall_user_buf_size
# # timestamp_mode
# # touched_functions
# # trace
# # trace_clock
# # trace_marker
# # trace_marker_raw
# # trace_options
# # trace_pipe
# # trace_stat
# # tracing_cpumask
# # tracing_max_latency
# # tracing_on
# # tracing_thresh
# # uprobe_events
# # uprobe_profile
# # ++ echo 0
# # +++ grep '^ *ls-' trace
# # +++ grep file=3D
# # ++ content=3D'              ls-5520    [006] ...1.   335.361454: eprobe=
_open: (syscalls.sys_enter_openat) file=3D"/usr/libexec/coreutils/libstdbuf=
.so"
# # ls-5520    [006] ...1.   335.361620: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"glibc-hwcaps/x86-64-v3/libselinux.so.1"
# # ls-5520    [006] ...1.   335.361649: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"glibc-hwcaps/x86-64-v2/libselinux.so.1"
# # ls-5520    [006] ...1.   335.361676: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"libselinux.so.1"
# # ls-5520    [006] ...1.   335.361704: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"/lkp/benchmarks/lib/glibc-hwcaps/x86-64-v3/libselinux.so.1"
# # ls-5520    [006] ...1.   335.361748: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"/lkp/benchmarks/lib/glibc-hwcaps/x86-64-v2/libselinux.so.1"
# # ls-5520    [006] ...1.   335.361796: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"/lkp/benchmarks/lib/libselinux.so.1"
# # ls-5520    [006] ...1.   335.361838: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"/etc/ld.so.cache"
# # ls-5520    [006] ...1.   335.361869: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"/lib/x86_64-linux-gnu/libselinux.so.1"
# # ls-5520    [006] ...1.   335.362051: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"glibc-hwcaps/x86-64-v3/libcap.so.2"
# # ls-5520    [006] ...1.   335.362080: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"glibc-hwcaps/x86-64-v2/libcap.so.2"
# # ls-5520    [006] ...1.   335.362107: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"libcap.so.2"
# # ls-5520    [006] ...1.   335.362135: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"/lib/x86_64-linux-gnu/libcap.so.2"
# # ls-5520    [006] ...1.   335.362288: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"glibc-hwcaps/x86-64-v3/libc.so.6"
# # ls-5520    [006] ...1.   335.362314: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"glibc-hwcaps/x86-64-v2/libc.so.6"
# # ls-5520    [006] ...1.   335.362340: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"libc.so.6"
# # ls-5520    [006] ...1.   335.362368: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"/lib/x86_64-linux-gnu/libc.so.6"
# # ls-5520    [006] ...1.   335.362552: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"glibc-hwcaps/x86-64-v3/libpcre2-8.so.0"
# # ls-5520    [006] ...1.   335.362581: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"glibc-hwcaps/x86-64-v2/libpcre2-8.so.0"
# # ls-5520    [006] ...1.   335.362607: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"libpcre2-8.so.0"
# # ls-5520    [006] ...1.   335.362634: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"/lib/x86_64-linux-gnu/libpcre2-8.so.0"
# # ls-5520    [006] ...1.   335.363348: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"/proc/filesystems"
# # ls-5520    [006] ...1.   335.363493: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"/usr/lib/locale/locale-archive"
# # ls-5520    [006] ...1.   335.363522: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"/usr/share/locale/locale.alias"
# # ls-5520    [006] ...1.   335.363553: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"/usr/lib/locale/C.UTF-8/LC_IDENTIFICATION"
# # ls-5520    [006] ...1.   335.363581: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"/usr/lib/locale/C.utf8/LC_IDENTIFICATION"
# # ls-5520    [006] ...1.   335.363610: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"/usr/lib/x86_64-linux-gnu/gconv/gconv-modules.cache"
# # ls-5520    [006] ...1.   335.363641: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"/usr/lib/locale/C.UTF-8/LC_MEASUREMENT"
# # ls-5520    [006] ...1.   335.363668: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"/usr/lib/locale/C.utf8/LC_MEASUREMENT"
# # ls-5520    [006] ...1.   335.363697: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"/usr/lib/locale/C.UTF-8/LC_TELEPHONE"
# # ls-5520    [006] ...1.   335.363725: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"/usr/lib/locale/C.utf8/LC_TELEPHONE"
# # ls-5520    [006] ...1.   335.363751: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"/usr/lib/locale/C.UTF-8/LC_ADDRESS"
# # ls-5520    [006] ...1.   335.363790: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"/usr/lib/locale/C.utf8/LC_ADDRESS"
# # ls-5520    [006] ...1.   335.363833: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"/usr/lib/locale/C.UTF-8/LC_NAME"
# # ls-5520    [006] ...1.   335.363861: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"/usr/lib/locale/C.utf8/LC_NAME"
# # ls-5520    [006] ...1.   335.363888: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"/usr/lib/locale/C.UTF-8/LC_PAPER"
# # ls-5520    [006] ...1.   335.363916: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"/usr/lib/locale/C.utf8/LC_PAPER"
# # ls-5520    [006] ...1.   335.363952: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"/usr/lib/locale/C.UTF-8/LC_MESSAGES"
# # ls-5520    [006] ...1.   335.363980: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"/usr/lib/locale/C.utf8/LC_MESSAGES"
# # ls-5520    [006] ...1.   335.364010: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"/usr/lib/locale/C.utf8/LC_MESSAGES/SYS_LC_MESSAGES"
# # ls-5520    [006] ...1.   335.364034: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"/usr/lib/locale/C.UTF-8/LC_MONETARY"
# # ls-5520    [006] ...1.   335.364062: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"/usr/lib/locale/C.utf8/LC_MONETARY"
# # ls-5520    [006] ...1.   335.364100: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"/usr/lib/locale/C.UTF-8/LC_COLLATE"
# # ls-5520    [006] ...1.   335.364131: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"/usr/lib/locale/C.utf8/LC_COLLATE"
# # ls-5520    [006] ...1.   335.364158: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"/usr/lib/locale/C.UTF-8/LC_TIME"
# # ls-5520    [006] ...1.   335.364185: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"/usr/lib/locale/C.utf8/LC_TIME"
# # ls-5520    [006] ...1.   335.364212: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"/usr/lib/locale/C.UTF-8/LC_NUMERIC"
# # ls-5520    [006] ...1.   335.364239: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"/usr/lib/locale/C.utf8/LC_NUMERIC"
# # ls-5520    [006] ...1.   335.364265: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"/usr/lib/locale/C.UTF-8/LC_CTYPE"
# # ls-5520    [006] ...1.   335.364292: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"/usr/lib/locale/C.utf8/LC_CTYPE"
# # ls-5520    [006] ...1.   335.364341: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"."'
# # +++ grep '^ *ls-' trace
# # +++ grep file=3D
# # +++ grep -v -e '"/' -e '"."' -e '(fault)'
# # ++ nocontent=3D'              ls-5520    [006] ...1.   335.361620: epro=
be_open: (syscalls.sys_enter_openat) file=3D"glibc-hwcaps/x86-64-v3/libseli=
nux.so.1"
# # ls-5520    [006] ...1.   335.361649: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"glibc-hwcaps/x86-64-v2/libselinux.so.1"
# # ls-5520    [006] ...1.   335.361676: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"libselinux.so.1"
# # ls-5520    [006] ...1.   335.362051: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"glibc-hwcaps/x86-64-v3/libcap.so.2"
# # ls-5520    [006] ...1.   335.362080: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"glibc-hwcaps/x86-64-v2/libcap.so.2"
# # ls-5520    [006] ...1.   335.362107: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"libcap.so.2"
# # ls-5520    [006] ...1.   335.362288: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"glibc-hwcaps/x86-64-v3/libc.so.6"
# # ls-5520    [006] ...1.   335.362314: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"glibc-hwcaps/x86-64-v2/libc.so.6"
# # ls-5520    [006] ...1.   335.362340: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"libc.so.6"
# # ls-5520    [006] ...1.   335.362552: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"glibc-hwcaps/x86-64-v3/libpcre2-8.so.0"
# # ls-5520    [006] ...1.   335.362581: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"glibc-hwcaps/x86-64-v2/libpcre2-8.so.0"
# # ls-5520    [006] ...1.   335.362607: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"libpcre2-8.so.0"'
# # ++ '[' -z '              ls-5520    [006] ...1.   335.361454: eprobe_op=
en: (syscalls.sys_enter_openat) file=3D"/usr/libexec/coreutils/libstdbuf.so=
"
# # ls-5520    [006] ...1.   335.361620: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"glibc-hwcaps/x86-64-v3/libselinux.so.1"
# # ls-5520    [006] ...1.   335.361649: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"glibc-hwcaps/x86-64-v2/libselinux.so.1"
# # ls-5520    [006] ...1.   335.361676: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"libselinux.so.1"
# # ls-5520    [006] ...1.   335.361704: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"/lkp/benchmarks/lib/glibc-hwcaps/x86-64-v3/libselinux.so.1"
# # ls-5520    [006] ...1.   335.361748: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"/lkp/benchmarks/lib/glibc-hwcaps/x86-64-v2/libselinux.so.1"
# # ls-5520    [006] ...1.   335.361796: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"/lkp/benchmarks/lib/libselinux.so.1"
# # ls-5520    [006] ...1.   335.361838: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"/etc/ld.so.cache"
# # ls-5520    [006] ...1.   335.361869: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"/lib/x86_64-linux-gnu/libselinux.so.1"
# # ls-5520    [006] ...1.   335.362051: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"glibc-hwcaps/x86-64-v3/libcap.so.2"
# # ls-5520    [006] ...1.   335.362080: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"glibc-hwcaps/x86-64-v2/libcap.so.2"
# # ls-5520    [006] ...1.   335.362107: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"libcap.so.2"
# # ls-5520    [006] ...1.   335.362135: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"/lib/x86_64-linux-gnu/libcap.so.2"
# # ls-5520    [006] ...1.   335.362288: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"glibc-hwcaps/x86-64-v3/libc.so.6"
# # ls-5520    [006] ...1.   335.362314: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"glibc-hwcaps/x86-64-v2/libc.so.6"
# # ls-5520    [006] ...1.   335.362340: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"libc.so.6"
# # ls-5520    [006] ...1.   335.362368: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"/lib/x86_64-linux-gnu/libc.so.6"
# # ls-5520    [006] ...1.   335.362552: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"glibc-hwcaps/x86-64-v3/libpcre2-8.so.0"
# # ls-5520    [006] ...1.   335.362581: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"glibc-hwcaps/x86-64-v2/libpcre2-8.so.0"
# # ls-5520    [006] ...1.   335.362607: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"libpcre2-8.so.0"
# # ls-5520    [006] ...1.   335.362634: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"/lib/x86_64-linux-gnu/libpcre2-8.so.0"
# # ls-5520    [006] ...1.   335.363348: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"/proc/filesystems"
# # ls-5520    [006] ...1.   335.363493: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"/usr/lib/locale/locale-archive"
# # ls-5520    [006] ...1.   335.363522: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"/usr/share/locale/locale.alias"
# # ls-5520    [006] ...1.   335.363553: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"/usr/lib/locale/C.UTF-8/LC_IDENTIFICATION"
# # ls-5520    [006] ...1.   335.363581: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"/usr/lib/locale/C.utf8/LC_IDENTIFICATION"
# # ls-5520    [006] ...1.   335.363610: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"/usr/lib/x86_64-linux-gnu/gconv/gconv-modules.cache"
# # ls-5520    [006] ...1.   335.363641: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"/usr/lib/locale/C.UTF-8/LC_MEASUREMENT"
# # ls-5520    [006] ...1.   335.363668: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"/usr/lib/locale/C.utf8/LC_MEASUREMENT"
# # ls-5520    [006] ...1.   335.363697: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"/usr/lib/locale/C.UTF-8/LC_TELEPHONE"
# # ls-5520    [006] ...1.   335.363725: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"/usr/lib/locale/C.utf8/LC_TELEPHONE"
# # ls-5520    [006] ...1.   335.363751: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"/usr/lib/locale/C.UTF-8/LC_ADDRESS"
# # ls-5520    [006] ...1.   335.363790: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"/usr/lib/locale/C.utf8/LC_ADDRESS"
# # ls-5520    [006] ...1.   335.363833: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"/usr/lib/locale/C.UTF-8/LC_NAME"
# # ls-5520    [006] ...1.   335.363861: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"/usr/lib/locale/C.utf8/LC_NAME"
# # ls-5520    [006] ...1.   335.363888: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"/usr/lib/locale/C.UTF-8/LC_PAPER"
# # ls-5520    [006] ...1.   335.363916: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"/usr/lib/locale/C.utf8/LC_PAPER"
# # ls-5520    [006] ...1.   335.363952: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"/usr/lib/locale/C.UTF-8/LC_MESSAGES"
# # ls-5520    [006] ...1.   335.363980: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"/usr/lib/locale/C.utf8/LC_MESSAGES"
# # ls-5520    [006] ...1.   335.364010: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"/usr/lib/locale/C.utf8/LC_MESSAGES/SYS_LC_MESSAGES"
# # ls-5520    [006] ...1.   335.364034: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"/usr/lib/locale/C.UTF-8/LC_MONETARY"
# # ls-5520    [006] ...1.   335.364062: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"/usr/lib/locale/C.utf8/LC_MONETARY"
# # ls-5520    [006] ...1.   335.364100: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"/usr/lib/locale/C.UTF-8/LC_COLLATE"
# # ls-5520    [006] ...1.   335.364131: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"/usr/lib/locale/C.utf8/LC_COLLATE"
# # ls-5520    [006] ...1.   335.364158: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"/usr/lib/locale/C.UTF-8/LC_TIME"
# # ls-5520    [006] ...1.   335.364185: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"/usr/lib/locale/C.utf8/LC_TIME"
# # ls-5520    [006] ...1.   335.364212: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"/usr/lib/locale/C.UTF-8/LC_NUMERIC"
# # ls-5520    [006] ...1.   335.364239: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"/usr/lib/locale/C.utf8/LC_NUMERIC"
# # ls-5520    [006] ...1.   335.364265: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"/usr/lib/locale/C.UTF-8/LC_CTYPE"
# # ls-5520    [006] ...1.   335.364292: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"/usr/lib/locale/C.utf8/LC_CTYPE"
# # ls-5520    [006] ...1.   335.364341: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"."' ']'
# # ++ '[' '!' -z '              ls-5520    [006] ...1.   335.361620: eprob=
e_open: (syscalls.sys_enter_openat) file=3D"glibc-hwcaps/x86-64-v3/libselin=
ux.so.1"
# # ls-5520    [006] ...1.   335.361649: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"glibc-hwcaps/x86-64-v2/libselinux.so.1"
# # ls-5520    [006] ...1.   335.361676: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"libselinux.so.1"
# # ls-5520    [006] ...1.   335.362051: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"glibc-hwcaps/x86-64-v3/libcap.so.2"
# # ls-5520    [006] ...1.   335.362080: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"glibc-hwcaps/x86-64-v2/libcap.so.2"
# # ls-5520    [006] ...1.   335.362107: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"libcap.so.2"
# # ls-5520    [006] ...1.   335.362288: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"glibc-hwcaps/x86-64-v3/libc.so.6"
# # ls-5520    [006] ...1.   335.362314: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"glibc-hwcaps/x86-64-v2/libc.so.6"
# # ls-5520    [006] ...1.   335.362340: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"libc.so.6"
# # ls-5520    [006] ...1.   335.362552: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"glibc-hwcaps/x86-64-v3/libpcre2-8.so.0"
# # ls-5520    [006] ...1.   335.362581: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"glibc-hwcaps/x86-64-v2/libpcre2-8.so.0"
# # ls-5520    [006] ...1.   335.362607: eprobe_open: (syscalls.sys_enter_o=
penat) file=3D"libpcre2-8.so.0"' ']'
# # ++ exit_fail
# # ++ exit 1

--=20
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


--rsArGZbvv6T0absu
Content-Type: application/x-xz
Content-Disposition: attachment; filename="kselftests-bpf-206b25c090.xz"
Content-Transfer-Encoding: base64

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

--rsArGZbvv6T0absu--
