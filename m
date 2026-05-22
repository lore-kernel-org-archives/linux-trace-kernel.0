Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658D23A7F4B;
	Fri, 22 May 2026 08:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779439574; cv=fail; b=OeFPf54qLhIfQbxHqxR3HRWDDJKvBT4Z3VIPIdkuqmK1b5RWSYv55DEZMuVVoLJzSuFcJ3/nSCX6mieAQEVS56jN0BdPnMAsL08tw0vn9HCC+TOBBu/Mm4fkfR9xsezCQcoIuy2R7PZKXiookshlyrb1Es9Sxrth0nlL0KlqyVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779439574; c=relaxed/simple;
	bh=umX5CI0BTtmCII262y55g+2+1jjugDY0v3jfcRUDo6o=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Akm7qAoIxlVgy37M0d/fN5ENoL3FtorSTW7FD+yrtFRerRlTKG8yq3b5FTurZQYT3hx3Agi6F0NCE4tBd7sbLjO6dv2v8f4Zz/qIyUk1GNOLwsHiamMFCpZfdQaioeBBMsVIMOBiecDI5M33ES0fqpdPadkbUxkqGBybkS5+aC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TgDrgH/x; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TgDrgH/x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779439572; x=1810975572;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=umX5CI0BTtmCII262y55g+2+1jjugDY0v3jfcRUDo6o=;
  b=TgDrgH/xH7Y/SywTRtDD0whno6wzQ8kfCgI95RxAevU5FBABWmZTGeCO
   BALMAMiEz0tw4nrGNuHZb1NNatcBQRN7VcKLD0MiC6duyi43y8GeRONPu
   C1f35QirIjytTUdRuku4AJbhRH94FW/lXQnZ1TrZ/tgGdaK7g7ELb95Pq
   sgItVJZn09n9FtB+y3gfmdH2PVRk8Doze0wGAt7jLyCEqm/lYBg839JZE
   F/McEdhCEnv1J9DUN54Gcfrj69AXiwyj2nvup7XUe+iyIQFoJrLgFIBIi
   z08BHo6mFE2myxCEUJ2mj1rZDvopCcRw8wg0h9jWDUE9ZzG4bLTvjBr/X
   A==;
X-CSE-ConnectionGUID: 40AjVHEqQfOzc6ItJkQbJQ==
X-CSE-MsgGUID: axoyYEF5R4WiSnCy6GoUTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11793"; a="79517388"
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; 
   d="scan'208";a="79517388"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2026 01:46:11 -0700
X-CSE-ConnectionGUID: KDjpHVmbSomIjbm9TKgxdA==
X-CSE-MsgGUID: ygZM9rQISEmHNLCo5bGlow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; 
   d="scan'208";a="237817305"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2026 01:46:11 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 22 May 2026 01:46:10 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 22 May 2026 01:46:10 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.37) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 22 May 2026 01:46:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M4Gmj0FZ6yOc7/HnMqlSAvVvDY8ZjtPHh2rV5foeIzNRaD9I/HhRaas6qu1HfzN6UA9jQYrBImBCfvb/XYAGWPk6Bjw8mfIHLyKmHrUsewPRAiOrMxhDcKHoA3EXJCWzKV9ilnjWBVYarWe339s3wninyC88FiPxhGKcLyMZg/czY/c2g19EsgL4+wxk5Ap4wQqzdHm+zI8tdoW3QhK2NPFIj/7/AZKz+ShjzpTN2wXDH/8nYjiyJ7vNynwJNl8eVlm/tKkAUaYgNwTylcZZqMQHgoNaal8iEKydlNEyrsOp7v0FoNr3+Fh3/zM+N6xbMIOG2DPx2+gQnJLSatooOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iL9B+ooy5L6w0S1iIGw3f+7ZQpGQ4VmIznEqzAbwn1U=;
 b=lDPEByHwvxsZdma6WUgmNemGgpBO1hDV/HyaMVdAHyV5YnHszHGl5zyNg72Qh1dDJOsa2InlK5Wd8CdFuXFyRyYyGf9K8m8+Lkx+9Sa3sSzAQn4QiLV7/Lcld+xwTXOLlnKYlZwOwnJwhh45UL6DZ3kkqiMuX2DRCsnMshDHoRos0zwj1oKgMGExFTM/pq9Xw69BEja9HpSOJRZWz47UETp1UcuVO6iLESrN/uXLqOv7YQwrlwvd7SsLh0ULtHbXAJTWscgS5nqfQ6JLz6QAuJcMNPVtrnniZt6Ae0JpF8xH4TJ1S39CKP+UgYT6S4ngMlF83fVekwt8XfsUBulwpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5832.namprd11.prod.outlook.com (2603:10b6:510:141::7)
 by PH7PR11MB7664.namprd11.prod.outlook.com (2603:10b6:510:26a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Fri, 22 May
 2026 08:46:06 +0000
Received: from PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707]) by PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707%3]) with mapi id 15.21.0025.020; Fri, 22 May 2026
 08:46:06 +0000
Date: Fri, 22 May 2026 16:45:59 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Rosen Penev <rosenp@gmail.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, <oliver.sang@intel.com>
Subject: Re: [PATCH] ftrace: Use flexible array for hash buckets
Message-ID: <202605221023.2bcc5f10-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260520220030.16887-1-rosenp@gmail.com>
X-ClientProxiedBy: TP0P295CA0020.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:5::10) To PH0PR11MB5832.namprd11.prod.outlook.com
 (2603:10b6:510:141::7)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5832:EE_|PH7PR11MB7664:EE_
X-MS-Office365-Filtering-Correlation-Id: 8727983f-6697-4739-d951-08deb7de8fde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|22082099003|56012099003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: 8b/g53ebAt4uq720DCY3BXehLBDeatG5+TBSUu5GC2IiPTzAtmVo6RVRT7eO1neCzDonGXt/xC0TUCuM4aXDNlhIO37OprlABe9JMdJEyqkD69E6owuFKsTX3NL/axOO1QbdtgVSRpOL8MtXSLcbmvNVLwghYdOqqLXQLUFBOCxAw/OXOlA41gDi+8o8dn2vXtGb2ozkiB9YoMILa6rYk95JPquJJkJ5Qf/mvCvrX9i86lkXZIlxLscE++rHiZXbg8GtUfICodHVcKKesPBtPyPIN4JXKqAbzz4uallmZMcT0mWzQ7QiSBbWXyX38ktssYSiuU/AwuhjG18UZW9NCCRumnzzoyjr9Z3R2bIqkiYUNvcBwPVJXpfyJMIJKzYUToCDpHsSDujCjfPPKq8dolYzVNA6s2bNkU8HslHkMOp3VppArc+o3+CoO4YXgWsmTyIYOgVSaZjE2U1Y0ffEonGwa9jCmvv9IqkhgDd42E1GVbtpbAj0s0dPnlW6aXLpaCxX9ISqTYjtuN5fAdjDEs8kr9W0KxjKZ6T8jznlqDWJvd9u60IBaWL3g5U86zbl3CCicvyfzkA2fM8WWKvWS0eAMoSksV+lxC+XGWLOIkV9M7DnH8QfbcQ163OFOVQwZ8nNOVHMny7d2FnPrLmhhg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5832.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(56012099003)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SYS3N730iGPyikLyWVqfD0yGSVXEzHinNcfTsljwp7QDUh3+e0FQUmHNP50L?=
 =?us-ascii?Q?iE8TF1j8t9HIEjRp0rlcMs6/UbTFObpqpJtVpM+RZgsHezCAUSXYM4YvBQ6L?=
 =?us-ascii?Q?Ot55l7UzBnOQZSkaqzGuLv40NcrNLlsK3aN90inFSId4WjEtDZtybb+7jgeh?=
 =?us-ascii?Q?jvCPXDGh7CoBrVghUplLCD18NXC4M2TPlsnLSMv4N1PzvqRdTplVnTRe0MZE?=
 =?us-ascii?Q?HeM3ej+7CUcgSXhHsK3r37TxJ1NBtz4F2LvKRN1fnPGTJmFCxcgsF8OmG2oY?=
 =?us-ascii?Q?VO2eXMMKiT33bxw+n0g267zavFJ/DhHCpldS74J8UwFEhP/5JvJGPnjD6v/6?=
 =?us-ascii?Q?3hEKLPGjssG0gtF7Kg2965v21S1TipRG2sOKLj7pIvBr6P/I7D3dA6vmFNFx?=
 =?us-ascii?Q?Pr7+ODYOAyuOVkGFHaqgRCKErFZqTW69VwcobFwwx8+iUFEEGLskfCg+26a2?=
 =?us-ascii?Q?6nsf5DT6cpIOp0fRrH5H8ezIkMzc3+i5LhQKPXBVqnkA8+RGLZozCY53ZAbb?=
 =?us-ascii?Q?lx9lJsGoHeHiI7cemRHUjbQuVIc9C3nC5HwUMY0LGg81ofgB9QaWsKQDBKYv?=
 =?us-ascii?Q?M6TrwcxZAZQ2VksXVxFQCa2F9jtbjyAr07D0mBUTP4KpKEfg5lKB8CGgXbyN?=
 =?us-ascii?Q?q0vOwI5U5p6SP3Az8jD6e8rwbcFA8ULTrVDIgSIOh2B6NtT+zpPQ1i1U4toS?=
 =?us-ascii?Q?A9jBB8lHweFXxaPJNSIzYipZod8JHXyu95EvZF7fvwWE16vUZCFsa7uOvLk4?=
 =?us-ascii?Q?ARJA5GwbZHFxncEmZ4iKM5nIhOMWy+PaeZJio11rdzHmffxIIrgNp6gQzmkB?=
 =?us-ascii?Q?SseOslprwhfesfb/7ALwo2Z7fDyzqxl9sLupVMY470QmiTYFhFWIsf9pHCkU?=
 =?us-ascii?Q?5D/bS9G0TMLDpA2LyxjHuQcdldP3ATZ+u0hTxqz7iXCVWuJINkme76Tw9KoS?=
 =?us-ascii?Q?l8BXdkjFG/nHSuCYvuoL7+ACArCKlP9LQLEMFikLQ9zjpfY67BO3eTJcWbzI?=
 =?us-ascii?Q?s6tCuzcD5MU8v6WAl+5/kvm+8wfPVjXOf2KA5FyadxR3UohEVvksui4kRuKN?=
 =?us-ascii?Q?58pacuZNiBw7h6CAtAmbTpEXWuUaDT+9k2C/L0m0DoIUk3Uxz66NXJQKPI7r?=
 =?us-ascii?Q?jAouIVBHgYYzfjlkVhKm3soNxhteofZGrkLmsE29Fxntkue0T/eieiQboqLn?=
 =?us-ascii?Q?5yHYxJuWf/YQEfVBuFajS86JrGopzCpTwd/bWPL8wesFSYRCWGB59n9hYueA?=
 =?us-ascii?Q?qbiwOiyI/hR46tOyXhhxp6jX7MwxSusgUOs24e3/Jk13zVzpRIxhJN/dTxnq?=
 =?us-ascii?Q?d6/TldSazlcAq3Bi0gQr/OtDVNLNpLo4P5Rxcz6N7PQ8bzeRGlaj1OqkJpeM?=
 =?us-ascii?Q?mR1NhgzYHMGlyj5Jx0bLLSKFwsLCTNCLA/uX1WJUX2A3GqOBJdlyu0J81gyA?=
 =?us-ascii?Q?P2GDdUpovrR+D4Vxx/ZK85f7IyzsqTU6OtQG/ULIcLBC7tNPDNihv+aJjdoj?=
 =?us-ascii?Q?/teSH9Bi8W+U78dDcQWwhmgP2GsOOqSX8RBipCdbMVkv4C14tEepFfoqhYIz?=
 =?us-ascii?Q?UKAOc4kAv9otMk+n6z34IgDpX9yK/tpJU3Leb+9zGkc70CA1kTn6+3T0jHur?=
 =?us-ascii?Q?RqSTxdmCcKsToiMFQZAlyjWqfrskshYl84hjPQsP6BaeU3Dm0N376592BpUn?=
 =?us-ascii?Q?Cn3PCfjDtiUe+ESQ32OhbYWEfOdUUMbUkFtYwdPl0ZbTjrHet4Tkbl8N0KTJ?=
 =?us-ascii?Q?C9UvjLoAUg=3D=3D?=
X-Exchange-RoutingPolicyChecked: HtRCMJSYus4c1/NhtTwl4hNUQvCnqej4bE6LV/cysksIrT0F5MKjMXMDGhWcZXq5hlxJPGGRQbyUqU1Ko2LdrhepcsnYLMfzvp6yl2UYzQYB/VirGTAApZKIIrJMwYxmyc7pOYe5zrjul062UDIBK7saiT5RvZ5oaJQHuqfres1Jw2ll+FmHYTPAwRem5fUkDAdeEoxzFx9TuJ6BTqmdNu2hKUAGE6AcBYwUgIgvFjdRxEkStfO5/sGSmMcYmXy0HM9HIHqfg1PpvfzsTzPINSKbH4VGI0BEcYRd0UgZaK4Bm3Bb0kW1GwR/CeKcp//gnlnNdbhm7IGPESJkNZ8Q/w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8727983f-6697-4739-d951-08deb7de8fde
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5832.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 08:46:05.9497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8zl/ej+1S8FRRetEWBC2j+aBcGxHCKM6I2GRKndFmnZdgRxBCCAj+nRLreOFYFWuBhMNSrvSFlVj8GHF95MjNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7664
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "BUG:KASAN:global-out-of-bounds_in_ftrace_find_rec_direct" on:

commit: 42ed22b1b4ae179c78e088477950eb1dd1dc9e90 ("[PATCH] ftrace: Use flexible array for hash buckets")
url: https://github.com/intel-lab-lkp/linux/commits/Rosen-Penev/ftrace-Use-flexible-array-for-hash-buckets/20260521-060312
base: https://git.kernel.org/cgit/linux/kernel/git/trace/linux-trace for-next
patch link: https://lore.kernel.org/all/20260520220030.16887-1-rosenp@gmail.com/
patch subject: [PATCH] ftrace: Use flexible array for hash buckets

in testcase: boot

config: x86_64-rhel-9.4-kunit
compiler: gcc-14
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 32G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202605221023.2bcc5f10-lkp@intel.com



[    9.849798][    T1] BUG: KASAN: global-out-of-bounds in ftrace_find_rec_direct (trace/ftrace.c:1172 (discriminator 2) trace/ftrace.c:2611 (discriminator 2))
[    9.849798][    T1] Read of size 8 at addr ffffffff9675bd48 by task swapper/0/1
[    9.849798][    T1]
[    9.849798][    T1] CPU: 1 UID: 0 PID: 1 Comm: swapper/0 Not tainted 7.1.0-rc3+ #1 PREEMPT(lazy)
[    9.849798][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[    9.849798][    T1] Call Trace:
[    9.849798][    T1]  <TASK>
[    9.849798][    T1]  dump_stack_lvl (dump_stack.c:94 dump_stack.c:120)
[    9.849798][    T1]  print_address_description+0x70/0x300
[    9.849798][    T1]  print_report (kasan/report.c:482)
[    9.849798][    T1]  ? __virt_addr_valid (linux/mmzone.h:2198 (discriminator 1) linux/mmzone.h:2280 (discriminator 1) x86/mm/physaddr.c:54 (discriminator 1))
[    9.849798][    T1]  ? ftrace_find_rec_direct (trace/ftrace.c:1172 (discriminator 2) trace/ftrace.c:2611 (discriminator 2))
[    9.849798][    T1]  kasan_report (kasan/report.c:595)
[    9.849798][    T1]  ? ftrace_find_rec_direct (trace/ftrace.c:1172 (discriminator 2) trace/ftrace.c:2611 (discriminator 2))
[    9.849798][    T1]  ? __pfx_trace_selftest_dynamic_test_func (??:?)
[    9.849798][    T1]  ftrace_find_rec_direct (trace/ftrace.c:1172 (discriminator 2) trace/ftrace.c:2611 (discriminator 2))
[    9.849798][    T1]  register_ftrace_direct (trace/ftrace.c:6057)
[    9.849798][    T1]  ? __pfx_ftrace_stub_direct_tramp (x86/kernel/ftrace_64.S:318)
[    9.849798][    T1]  trace_selftest_startup_function_graph (trace/trace_selftest.c:1139)
[    9.849798][    T1]  ? __pfx_trace_selftest_startup_function_graph (trace/trace_selftest.c:754)
[    9.849798][    T1]  run_tracer_selftest (trace/trace.c:1335)
[    9.849798][    T1]  register_tracer (trace/trace.c:1375 trace/trace.c:1492)
[    9.849798][    T1]  ? __pfx_init_graph_trace (trace/trace_functions_graph.c:1811)
[    9.849798][    T1]  do_one_initcall (main.c:1347)
[    9.849798][    T1]  ? __pfx_do_one_initcall (trace/events/initcall.h:10)
[    9.849798][    T1]  ? asm_sysvec_apic_timer_interrupt (x86/include/asm/idtentry.h:569)
[    9.849798][    T1]  ? ret_from_fork_asm (x86/entry/entry_64.S:245)
[    9.849798][    T1]  do_initcalls (main.c:1409 (discriminator 1) main.c:1425 (discriminator 1))
[    9.849798][    T1]  kernel_init_freeable (main.c:1445 main.c:1658)
[    9.849798][    T1]  ? __pfx_kernel_init_freeable (main.c:1626)
[    9.849798][    T1]  ? __pfx_schedule_timeout (??:?)
[    9.849798][    T1]  ? __pfx__raw_spin_lock_irq (locking/spinlock.c:183)
[    9.849798][    T1]  ? __pfx_kernel_init (main.c:717)
[    9.849798][    T1]  kernel_init (main.c:1548)
[    9.849798][    T1]  ? __pfx_kernel_init (main.c:717)
[    9.849798][    T1]  ret_from_fork (x86/kernel/process.c:158)
[    9.849798][    T1]  ? __pfx_ret_from_fork (x86/include/asm/entry-common.h:54)
[    9.849798][    T1]  ? switch_fpu (linux/instrumented.h:82 asm-generic/bitops/instrumented-non-atomic.h:141 linux/thread_info.h:133 linux/sched.h:2066 x86/include/asm/fpu/sched.h:34)
[    9.849798][    T1]  ? __switch_to (x86/kernel/process_64.c:619)
[    9.849798][    T1]  ? __switch_to_asm (x86/entry/entry_64.S:206)
[    9.849798][    T1]  ? __pfx_kernel_init (main.c:717)
[    9.849798][    T1]  ret_from_fork_asm (x86/entry/entry_64.S:245)
[    9.849798][    T1]  </TASK>
[    9.849798][    T1]
[    9.849798][    T1] The buggy address belongs to the variable:
[    9.849798][    T1]  empty_hash+0x28/0xa0
[    9.849798][    T1]
[    9.849798][    T1] The buggy address belongs to the physical page:
[    9.849798][    T1] page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x77d95b
[    9.849798][    T1] flags: 0x17ffffc0002000(reserved|node=0|zone=2|lastcpupid=0x1fffff)
[    9.849798][    T1] raw: 0017ffffc0002000 ffffea001df656c8 ffffea001df656c8 0000000000000000
[    9.849798][    T1] raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
[    9.849798][    T1] page dumped because: kasan: bad access detected
[    9.849798][    T1]
[    9.849798][    T1] Memory state around the buggy address:
[    9.849798][    T1]  ffffffff9675bc00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    9.849798][    T1]  ffffffff9675bc80: 00 00 00 00 00 00 f9 f9 f9 f9 f9 f9 00 00 00 00
[    9.849798][    T1] >ffffffff9675bd00: f9 f9 f9 f9 00 00 00 00 00 f9 f9 f9 f9 f9 f9 f9
[    9.849798][    T1]                                               ^
[    9.849798][    T1]  ffffffff9675bd80: 00 02 f9 f9 f9 f9 f9 f9 00 00 00 00 00 00 00 00
[    9.849798][    T1]  ffffffff9675be00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    9.849798][    T1] ==================================================================
[    9.904835][    T1] Disabling lock debugging due to kernel taint


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260522/202605221023.2bcc5f10-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

