Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F12BE46;
	Thu,  7 Aug 2025 05:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754546315; cv=fail; b=WDHpQCQ3XlwkNp6FL74EAWScWHzzddIVg5DO4NBSw7S/SJPDOzcjvkwm86vCuCwDhr2Jp6XUL5Z4AxhKoxBybXvkJY0wUYB3afw6RLBeDo7iz3Q6dyjYSsBHL5NFhPPSpkugYHdU0U9VmBCatg1e4FoF6dbOljSVI1LNz0bfZHc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754546315; c=relaxed/simple;
	bh=TkSM9dGDkU3CTTprAEJxFKEsCCpQmczuvFTi4atj/Qk=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=nsCW7JRToaQycQdP58PpaPv/u8irKT3ASTwPhxlDDLgGJHcKw52mfZYAppS27FTALGUAimm9K7GaCe0UCgP0o3OJ8k/2h5ePISSM4hohXnZK+YIjSdIRNIDWLIPeLY7MKDOetDCvQWsNNtj//0SJz7cGwRbIGQ0BKuEP+UPAkLI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AWNRXAgY; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AWNRXAgY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754546314; x=1786082314;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=TkSM9dGDkU3CTTprAEJxFKEsCCpQmczuvFTi4atj/Qk=;
  b=AWNRXAgY5fy3qATrot7TeoKRfNEuhiHz/TNc1/5jLHZBIb4j34wvdT3U
   l28c3G0jhXPKeYkVvwW5HezzBVxV4ReiP3hhJDIkTeTw9IBYK3Bpm75wQ
   hhM3et5qps02jkWIlRkZjjkd14CvAYsA50CKZc7bm/jr8F9GssJoDQAvs
   HC09mAft8fseVkY9mwPevmmlHfKUSq2ZH2t06VnGViHIlQuWJNx+pJiAG
   eZAe6NFNSBmEfngu/pD8FnLhDMQpKzG6KgG9E2r0wP8E0KbSKL+yZ/gL2
   emOaPKFkYPFpYrZ9JAPdfW8E1cb5C68UdK7xExg1K62nJJ8lQp7R9Rbr0
   Q==;
X-CSE-ConnectionGUID: AT7HB2fmRiGkHJy3zS7kug==
X-CSE-MsgGUID: rjWmj1sUSTGG/bvAEslIDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="67141184"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="67141184"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 22:58:34 -0700
X-CSE-ConnectionGUID: 7GBPkmhoSC6pPQHRuPTc3w==
X-CSE-MsgGUID: EcprQbEiRkWu3jokj1UlVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="169095308"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 22:58:32 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 6 Aug 2025 22:58:32 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 6 Aug 2025 22:58:32 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.66)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 6 Aug 2025 22:58:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F9qJdV1zh7/rUkpAG1qYOyV957HKkvZm2pf8z3VdQIxvAtFviacIdXSWfgQQoeBsmxQVfrqO9x4oIVDyHFU4qqb4EwojoL0abo7mrEt5oyfLA7pPCul0VjaeXulMpoNpJIQS0tmcqs/hajV7S2we6X+222vdvhhlB4reYVXqUblnCDdDqY3MWNrnQ5FYND0+FPuebtl40UXWoSfvq5PRqL1pQV/ZEtkQs9xPuwnqajJNetm1FlkiUDYHjaicmqH/+mJ0XYqwvq/kJj3Q6CZ6WgMGehY/QLOSQwuWP9PDhEUeTRjJUW3vPVoiFi0hqEijTA1Sp4+bFC2KfJRvBA/JqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=StIMYGb8ppy3UCSVyoRHyfzwwVMCFBCdVnop+GYXReY=;
 b=d9l5MPMlVw0U5uL94/oVtILL30hRkdxrcOcoJeplFIhO+QpjKgw3KH9n9M+hBnxBmRYe9KM3WSeiR6jG2oON7RRsHS1XEBYcoGKVCt51RMRm8Z6jsmkGFQx2CeyY5EVYINR6m0zCqs9dKgScAyEEm/7a2Ye2Otwde9BHgSakzzhQRObTBX/OMVjlfcRlFTiOrW9QGibK1RQeH/FYbePtrNFzodcmCi67Y1GDWs4PjVEMVyUTC/p20o8sgMcYTblVNi/4oOTnWwyD/NJF3DM1ThnhzdRb3m43pB51F0szfMvScBFtLHn/o09ZlyP2tuFPOBhlS544X5fXVKV7UtwQLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DM4PR11MB5327.namprd11.prod.outlook.com (2603:10b6:5:392::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.13; Thu, 7 Aug
 2025 05:58:29 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9009.013; Thu, 7 Aug 2025
 05:58:29 +0000
Date: Thu, 7 Aug 2025 13:58:18 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Gabriele Monaco <gmonaco@redhat.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>, "Peter
 Zijlstra" <peterz@infradead.org>, Masami Hiramatsu <mhiramat@kernel.org>,
	"Nam Cao" <namcao@linutronix.de>, Tomas Glozar <tglozar@redhat.com>, Juri
 Lelli <jlelli@redhat.com>, Clark Williams <williams@redhat.com>, John Kacur
	<jkacur@redhat.com>, <linux-trace-kernel@vger.kernel.org>,
	<aubrey.li@linux.intel.com>, <yu.c.chen@intel.com>, <oliver.sang@intel.com>
Subject: [linus:master] [sched]  adcc3bfa88:
 kunit.VCAP_API_DebugFS_Testsuite.vcap_api_show_admin_raw_test.fail
Message-ID: <202508070739.4c6e0633-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR04CA0017.apcprd04.prod.outlook.com
 (2603:1096:4:197::15) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DM4PR11MB5327:EE_
X-MS-Office365-Filtering-Correlation-Id: 825f3e78-0323-4275-f293-08ddd5776ebe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/bMoqJ786R4swbWvZUVDQneuZPkGzbgX1mgED5h00Th0lIWrDHV5aveS/Nys?=
 =?us-ascii?Q?y4UZpodnMuU0MfkrAsrTOm4f1NdJgvxenaIeAlyoDBHd6okr5fhfec/e3Y0t?=
 =?us-ascii?Q?WtZDo0lflKdPWvotClwyrmoHHoTV70Z5ZcUyy5Od1ab7MbKp+KJazF7miRNL?=
 =?us-ascii?Q?mj49GSRM/XBynbPqnj+COSaSTq4Y+Gxh+VYwVTAxSFa1AGF+TDvjyB6OFOfG?=
 =?us-ascii?Q?ddlBvw+Vs3BDlCi1LNnISJhNAq1duwCs9PgYUUQDW8Y06Hr+1lteT69B/Hdp?=
 =?us-ascii?Q?eqSIOMTQlu7bs02VqLxF/MGu9nl0iY3VNml4cGvdOWXWznQZrvnWiTj9oMvi?=
 =?us-ascii?Q?1frWAV1b0XCswE6bxyzPxnESmEEoDf05BMYTS4Yb8/or10hkCIc07PygPxqp?=
 =?us-ascii?Q?CqJiFGc313t524WbWEz9NgZhPLyTt2u6nFucv+Vjt4Fdgogk+KGfissGRjeS?=
 =?us-ascii?Q?jNpbzPuqAmpft7mAws3KDE24KC/WaaBwn5UCY6B+njkIqVnk9Ns5U1vSI3sf?=
 =?us-ascii?Q?GUf0hr7XKDs+18qyqFsIh6N3cMnu8athZwHT1p9FaSIkCLdcjhfOlFw3SKRM?=
 =?us-ascii?Q?X/7sqG1edhMwxAC8VH0Rvoccv94NUcVhEd8qpFvdEQMCmmqHyLSVMt6f8hiv?=
 =?us-ascii?Q?ybOgLQ3dbIHTioKo/AfyVm1i3z6f1E/WXAm8sJK/ATGWBurgBXepOk152Umq?=
 =?us-ascii?Q?5ujrtT5kAqKaqaYIrGnN2JfLEMMl4CKAzKc/JLT0YdIL4dtTDQYYc5dn5d5F?=
 =?us-ascii?Q?7xfjuJMhSNBIkSAT4E1GkYoZQdTPenAsLoE6CKrXY/KR6dygpaN/2BgKlqo9?=
 =?us-ascii?Q?yFYocBGwoQn+/8/VWp+g/oB0wRcB4QPweBRnij3TA+ybS1ScM0vdAZoDwh5m?=
 =?us-ascii?Q?Mnl3EUdfQFARab+ckGjGzGCqoQ5soIaKAb5V/nVNc/6nAZXG/wPyYXiimSCQ?=
 =?us-ascii?Q?hfMdoRW76M93PN6suCkFYtDnv/cmtgGUhF8C6hWVgLxK4YI7Xn3Gt4EHNfN/?=
 =?us-ascii?Q?MZWzVmctQ4Pon+mNSIOtn+rqu89S/V0BdzwhqppDpW35hK33rLy/TIMv82zc?=
 =?us-ascii?Q?sZlXJeNq/qqVabLX0PT2c8MbgUQeKqYeO+FRuZm3awK+pFWoBh+RwVLbcAKs?=
 =?us-ascii?Q?Lw0uX/9EeXGaVIuXW7ZvVavRUNAoU0a7pzTY+mZL8YUASgGJV/XPSwb9bebT?=
 =?us-ascii?Q?OnJLMLCy9UCNMw6IA+l9BpNc3OyWqEZmEb7KdB0+88iVScLJsjuPtg5gNyCB?=
 =?us-ascii?Q?WO2sypgLdpJ9TiYZQpKKgHU0rFzXvznYr5d/DNZZzx+aQr7ZeqEIJcTyxgVs?=
 =?us-ascii?Q?sx1wFaRnS/8uERWGsG2ici1DJrTlNFGuezmgd6QNIwNCpbgeiIKpTX/7rquF?=
 =?us-ascii?Q?3odl7az+rrd4K+8/hYO/gmYpD9Ua?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wEptm7vmaglNns8aAgKQYHJ0ZSJ2uNr4Mwkl0XsaOX44JBm6MyTBYSfbTNDJ?=
 =?us-ascii?Q?Cg+ZXmzrEtRi+rIIHQLqoCk3iHFBvG4Hl2dmjUapfquR+2E9fHZ24lTud2nX?=
 =?us-ascii?Q?j0ECJLp9k3oIcOMTcM7Tm0iUCkUM0utRKAuC3qDq18YG4RLJENEjhyZ4Ee5t?=
 =?us-ascii?Q?+P7iKycdzLF7yZ9B74Tst8VWQUWZeJmhBxrATGe0iNN+aAVP3untN7JuYxLk?=
 =?us-ascii?Q?PR81uED9Gu910EktJIm32MrbFam2/79MH8d4OrrP3mNBm3SBfZGqTtEGvRxh?=
 =?us-ascii?Q?yMAIQiA3LdxQv1xIPuyq6uNKGrLmC22IPAe1Xe9RagJicq5rlckZAKjNYOzY?=
 =?us-ascii?Q?0aC85nSPviaRihRH//KnS2/4bKAHnjIlQdwS/aNcbDiCLPn8xN3xr87aCSas?=
 =?us-ascii?Q?mfdJxpeN/EY/ClZbcccYw6dcOT3bCTSj5fs4NLgZiYWgV0by4FntHVjTWNS4?=
 =?us-ascii?Q?yoYNmPUV5+nuqn8WRZSSnLq0hVq+rqmczJmA6yKSme9K5Gbj2suIuTWbZb+5?=
 =?us-ascii?Q?x+l3R19T1Z5jh+lyqKf3Ix9UTNSq+ChZkBXb1vo+UZXd9tmsNsGsp0Lqj+DJ?=
 =?us-ascii?Q?4WhKYMWRE5AILYWwSSrXC+z518cVkkpbLriSYWC3LAdk/v33BTeP9aXk1ryq?=
 =?us-ascii?Q?MXRjyZUGXrqCC3gNrSh7vgcGhL1whjlXQcXsdi0Kk/tjgGQkg+kxuyvZlllt?=
 =?us-ascii?Q?eifKLLk23b+Dh/ZkNoyQMa2JvJjmxhJ7q8kq31i8pfcnvykhs5gq+PI+BRXz?=
 =?us-ascii?Q?OyFk+evBi0Y/2OUHBdG4kTlO6/6osgVng7vyAI2EKto2FBPa54b94ru6M+nr?=
 =?us-ascii?Q?R5clqfsiiWGRZO0PCzooYx+eTWvzsMYBURdmo56S8Db49+pZWP/oeB/QdxLE?=
 =?us-ascii?Q?lPXZnYUPM1k0pwQIwsihPT5y1hdWDbCLbIWbrfqs4KPdY81zYCYw5GWB80HY?=
 =?us-ascii?Q?TyT/p0LU8KvMKEzmQvmOX3YPWDuxtYNUoFScxLdLXbN2NIGRwp0WRheia0nO?=
 =?us-ascii?Q?GCob8hjuquiGlz7rpmGc0S3O0zVOvb+HKULoOKzA9AeUpIxLTsb2L2AxIlcN?=
 =?us-ascii?Q?qWAdnNSfCMB21k/+sZ1f4ZGpAvC1LRdK1+ojwM+FRwzKNdRHNxI7OWizLCUf?=
 =?us-ascii?Q?HzA8w9D9XzfTL8dSm+oZNdHjKze9YOkyjDgnMlSGgQeFJz/gGcgD/vfy1v4/?=
 =?us-ascii?Q?cGcQCIPa8Dwjy/cFJmxnJlEVPrZzoLTEF9CLjv3Dp3zJDBrgWPnzMYOG8CnC?=
 =?us-ascii?Q?OAdWP1JToqBhm150nnQfJiMUr8FD4UrwyERMegiJUm9i0QdvobNqhTzWsOcn?=
 =?us-ascii?Q?vJcwH5aQMtkEfEF/ofO5Y49D76C1z702WMHWgzb4u1ZcgnHXeCvqeEesR/Xl?=
 =?us-ascii?Q?hWyfz/8uwFOYCtO6nQJsI3B3desb/KR/Q18JuSWzE0h0vfe2yxUEia62e/dL?=
 =?us-ascii?Q?HVSSDVL+40VvJaxSbiK/63w66ulEgAgYe6m2jc70P+P2F3vKzNxe+IZW1idG?=
 =?us-ascii?Q?4Lds6ptMhzNZxbu/I6Kxmjn2T45dUJjXdEJZxcEOMQQpzR3IF1KWOc2s3aRN?=
 =?us-ascii?Q?0k42lcs2ZEbHIT5VChsx7RJ45wWmpyYlzEF9OB+9bk3YlZXXdqvJRHuNQqd2?=
 =?us-ascii?Q?sw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 825f3e78-0323-4275-f293-08ddd5776ebe
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 05:58:29.3477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: es3TStlVxo3AoVLbmxDEwrJFWjsl1jNJybilsxxCXo+UURk+cTRm7Tlv8KgRgmf1q+d1lLtOKf7pVgHAGI7IRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5327
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "kunit.VCAP_API_DebugFS_Testsuite.vcap_api_show_admin_raw_test.fail" on:

commit: adcc3bfa8806761ac21aa271f78454113ec6936e ("sched: Adapt sched tracepoints for RV task model")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master      6a68cec16b647791d448102376a7eec2820e874f]
[test failed on linux-next/master 84b92a499e7eca54ba1df6f6c6e01766025943f1]

in testcase: kunit
version: 
with following parameters:

	group: group-03



config: x86_64-rhel-9.4-kunit
compiler: gcc-12
test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-3770K CPU @ 3.50GHz (Ivy Bridge) with 16G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202508070739.4c6e0633-lkp@intel.com


[   80.925851]     # vcap_api_show_admin_raw_test: EXPECTATION FAILED at drivers/net/ethernet/microchip/vcap/vcap_api_debugfs_kunit.c:377
                   Expected test_expected == test_pr_buffer[0], but
                       test_expected == "  addr: 786, X6 rule, keysets: VCAP_KFS_MAC_ETYPE
               "
                       test_pr_buffer[0] == ""
[   80.926182]     not ok 2 vcap_api_show_admin_raw_test



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250807/202508070739.4c6e0633-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

