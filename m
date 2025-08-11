Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBB93FE7;
	Mon, 11 Aug 2025 05:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754889595; cv=fail; b=c6/Kwr/6sChA/26+bjgMjdX3yxb54wFXhKV0+CB+BAd6Bw9qD76RpYE2dCNOOUSlNrs41zFZPht1Zug2eSleBicutKhkRXcReIPz5xVfDbPHGoXhoxwFz2CgZ3IoFrcxhhYYzhv1SwOUILKPBcEQixa9uEs+E1C4F/0Zzb02GpI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754889595; c=relaxed/simple;
	bh=rwrOn5PCN+QmXZ5Tnt47ITdpD28QhVA0DBD1UKmgwKI=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HsmnWQ1vXy/9HZN767ne1zZg7+V/arnLYxIdXdpjTfWri+cbNgxcB2410rVXJOyiYg6WHwTJgDEOAPA0lBP0DMbJFUpacFRNezgTLPMN2FxDc1DlWMExJfHK3+n2JsB5PFIgDNoszKT+wngCy1XulqztncgH5FcvpZLhVY3JUGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T/hyvU6F; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T/hyvU6F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754889593; x=1786425593;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=rwrOn5PCN+QmXZ5Tnt47ITdpD28QhVA0DBD1UKmgwKI=;
  b=T/hyvU6Fyk1k2UDtVYEZ9bS+Hyc+7seD3DL1ZZVq8aI1GwskGVoBOYdH
   wLGV0eSDBRRw5Ccx3UAC7GnOBvNlFi/igFHKQBaaMeLJfDCMqjK6ZaDOT
   Pst7bjG8gE6kSyfow9OAjo6Axt5PwoN+qnDE5BXv/ViuX98RA7/A2K7tf
   6K5P8kM9lx1p887XlHRQNTJ1WVs5CceU0mj4Omkg8eqAyNIqm7QYCvzHC
   wMB3SbGMYrt8iwJtpw96/uEeBznHYmAUkNCnXYSWnDpqhIVWoH7xV/4rK
   KAcVkfziagCHrHmtZ5Kch/mICvRI/2dM1i26lXQIWUY0ykBmZcoJmslsL
   w==;
X-CSE-ConnectionGUID: g55ALzhVSjyY9LlzD57j/Q==
X-CSE-MsgGUID: OdyPHt2EQLe1SXkDiQwvPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="57277823"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="57277823"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2025 22:19:49 -0700
X-CSE-ConnectionGUID: JdLk9c9FS12eTLwr1HZSIg==
X-CSE-MsgGUID: aQV42005T5yDO6J/5oUh6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="166131377"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2025 22:19:49 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Sun, 10 Aug 2025 22:19:47 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Sun, 10 Aug 2025 22:19:47 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.44)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Sun, 10 Aug 2025 22:19:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SWCQEgW0XJbH/2RznpKN3f1p8Vw6Tb/x9KMa78ZvxKP05o80YOQoyWrcmO8B/wW7yQ5GiIuUjN2tkQ4aF/F2+SrSoSWFrTXUjm1BQj+UnJ3hv1nDVZKQ8T4vWpnSdC1OO8V32/IlRHDkjly/Kaz8lBQ6wL3jYTq+4QWiBmjoyAAJHUXjSsFjAoRXDXXfj9GfLyPU9UBiMXuVYD8p4AvG1rCRKkqkTFPkTYyOwa+LkOG8GrUqsi5I7v4tFczdp6IQIm83ZDIOWRDl+SlpMXHEaIcobJnmrKdNEZn8B91dwyInA58jfTw9HDnEQui15Vbg4MfNhKYBUctvMrRDh2mFcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=47X7xDsMMq/aBs9MvYW/OMG/6FaRtba/bznpBPeK+nQ=;
 b=EXOc6rcDnNhO29DwQFT7Qf1dXhu9p/C/pVdaW5yivy0eAHW5YvWjC7WP+VvNYPvC6gnmyqVq9iTBWiAfQXnuICvFaBhq9PxPVA/AT7h3EzoPKeEzladevCBEevVQLoSwXL80U6EnEXzDBx+1j/IPQ23uSpAkYSi/C9CyKwyw6LgRWx4WH1T8Sw5B2E4seKZ5H6bQbn1iH7OWiyP2JJyMQhRTF2fJxy9S42dNSbuQMjVsmIKPiTF0KtkSxrLPco+2rJ2FJvFXVCU27C01aaRJAuijVTT1hR7b9iHlP6WrhQ2ieNrpC8/tfIbE54ADsMXzsdpIrZEwVrWshAeD52FfkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CH0PR11MB5316.namprd11.prod.outlook.com (2603:10b6:610:bf::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 05:19:34 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9009.018; Mon, 11 Aug 2025
 05:19:34 +0000
Date: Mon, 11 Aug 2025 13:19:22 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Steven Rostedt <rostedt@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
	<mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>, Namhyung Kim <namhyung@kernel.org>,
	Takaya Saeki <takayas@google.com>, Tom Zanussi <zanussi@kernel.org>, "Thomas
 Gleixner" <tglx@linutronix.de>, Ian Rogers <irogers@google.com>,
	<aahringo@redhat.com>, Douglas Raillard <douglas.raillard@arm.com>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH 3/7] tracing: Have syscall trace events read user space
 string
Message-ID: <202508110616.33657b6c-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250805193235.080757106@kernel.org>
X-ClientProxiedBy: SG2PR02CA0121.apcprd02.prod.outlook.com
 (2603:1096:4:188::21) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CH0PR11MB5316:EE_
X-MS-Office365-Filtering-Correlation-Id: 587467d0-d986-4e06-7482-08ddd896a86d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qeonYSlFfuxN0RXRrfBpgnAqSXQSyDbaj3l9chi1ZquFAv52aNKJ2XinMHNT?=
 =?us-ascii?Q?AyDb+9iwAGf3HIR5GkPWqa//A9hv5dofcXQeQhH5H0shR89yYyE78FK6KATO?=
 =?us-ascii?Q?qlAV4i/dt1ZmunsjW1du+Oc+A5sU5wdPXeglXgQUAHBG8pM3cXI/lQowpmK3?=
 =?us-ascii?Q?Dkb0cl5mAnI+xi5GU6lYjQOMEvXiM2ZO/iA38s4e1+R/W8DL4g8NjoMMhAK2?=
 =?us-ascii?Q?qsiHgqJAXULuQhceLHBDvV8cJwnW1rz0JOhGcxa3O9EnD7TkeaagfdZEtTbI?=
 =?us-ascii?Q?n/bqElu89pfkayDoZBm1mhGa3hpGDlC7q3d7xEfS0HsbkqbhcGE1mcozft1v?=
 =?us-ascii?Q?a3FFqjIGQ0awPrqTFRNMqes+CUMq8zpZC4JJ9ymI4+qON+KB6Ry1Ymai8qgy?=
 =?us-ascii?Q?ep4VwmvjfictlYgcWhTL7VvRLEupH/2FoY/Rnpys3n0XHbn7BzvxnnchEOv5?=
 =?us-ascii?Q?iT2tX33ivTX/swadfyYCrXXR63eA4fwk5kKJp18U+LQ6we7nUn0ZtH/CcMhI?=
 =?us-ascii?Q?mCgdoSyfngPoBoHaR7vtI7twcjONI/HKsvry/4a02SCXIMp3lNqjNUiOd/Z7?=
 =?us-ascii?Q?pr94egfWE+PEPhU7PqAGXFOmAFL++hLtyTeXkv7lxSh05pyU8iiA9UIneeCG?=
 =?us-ascii?Q?NZEGd2BQYXQWDR703a9jkOWqa1XUZFGotFHYSJeTT0kA7JFIPucrydZlHfPI?=
 =?us-ascii?Q?8z3PvMnEF//KUL1DJks7Yyoki8m3Z9C9fJ9hSRqfp8p261msVpdAg1blIM/5?=
 =?us-ascii?Q?4+xN/uPDEoyYZrEI8lU5OqwFE9OfP/y1o051iJgDCOk6D8T4RKVxDUQHs2kF?=
 =?us-ascii?Q?7eCMBlkdKZ0IBK4UUC/xWcGO1j1b7pSeha/i/fC3WAo1bmoS10a3o4jn4vI/?=
 =?us-ascii?Q?yJbxqMtLhnqSw8fBmGi9/bxWbT1j1AYGUbQtoTcp1KdpNsMxvKFa+mKO5IWs?=
 =?us-ascii?Q?5qsm/jhByGYhGt9JHlZfKwZiOjxKf9QZ3MXTESnSYedrEWEFKyIwLOca7FuY?=
 =?us-ascii?Q?xbEQLrjT+fpICzXnRldL/P69XIB5RHHOP3MFYLWvqRtwYypn166IGFuJ8vpU?=
 =?us-ascii?Q?PMAPUfxpMro4X8z0kjUCCTvFJ5+xdQpoosBZEBy/Qs0luAzWCty12YNu12YR?=
 =?us-ascii?Q?7torgKVx4a7uL2IUtHfssF/zlboAGJ1XhUoHBVhiHeetC7x+YyLf3k5/sx+k?=
 =?us-ascii?Q?wzT9c61ijrioCZFgGFC4Krn5ehSzlvzC6RH0XDl1Hc0x6wP0pvtP1CgkhBZL?=
 =?us-ascii?Q?+5X3joNZNajcOgX8cNSjHFrtkZFcTcqk1p/zNDDaz6shIiZi3uFSutql6Pl4?=
 =?us-ascii?Q?WbUyP7aq1km146kcqmm2FQwcir+gUZJu05gMwrmBnwaTvBilyUr3gJEGcvYu?=
 =?us-ascii?Q?f4k6FTEetEiVPVCLtlqOiyMP3Nxy?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nVfUwboc3paYh5gxDrAbzVBKwD0shsQloDdmXIHQoiKSJdS7dfgSLqObO6Of?=
 =?us-ascii?Q?vUXgsJ/3C3lPK9m5xZRFrm10w79m061GXXmsL12OQ3rVuS7p8gguYtNRRwrx?=
 =?us-ascii?Q?xcdrg33JZ/ePj2/ztVEofB/aK8ANL3Zy5ZgAbmfJE/ONMNq1zZJvtT/GEzF/?=
 =?us-ascii?Q?tqNMwyJ+4syMdYIRsVv3dud960UeN8pCiabSej8RKjYWhoVV8Zf2hs+WkQfi?=
 =?us-ascii?Q?B3D8gcs99qDuiMu982B3VVwgPqdZeYCUPQde/2GoOLfJqxwtKx49vIa79w0l?=
 =?us-ascii?Q?bQD9EFJwFkR316lstdFfFHiX5Kd0/57VYgtYUnvH+DBUuEfn+lO1i44DywrW?=
 =?us-ascii?Q?+voPcqCUMtnIZKiaaaQ4WA/rEa3yCEeO3Q5gbNvh/3wFIjsIS5iBDtjrCZ/m?=
 =?us-ascii?Q?F7LdP5NvEjwJfWhk0ZxAZ33mmmVMKdfmfUcWxopoIgcWE0wXPmv8Kjv+TZK5?=
 =?us-ascii?Q?OeBainvq0tXtW81NAnhYv3XpJzZyduTH+a4GfCg+p2gKxk2DDPb70JE4QBLd?=
 =?us-ascii?Q?H2A7NJTgbMK0wd7FZ5E7WNG6kCGnl0GOXSpFqt8YogWgT+wfBkD/MB3AcFKa?=
 =?us-ascii?Q?Hbt2t7VPRkHGW5OeKFudDQ7t+z0csqmVWtrygnZBzfKK3US1aLpuTkpML/NL?=
 =?us-ascii?Q?y5H/aOJdc5cNsgUy0marJWn7P8CmGWTBB7hZpPJL6T7mFCuvbpckd+Tyxmx2?=
 =?us-ascii?Q?bfi5iUT1r44VKXxRVZPHQYWzlGZtR1ooW0oJgdybLWoFLpZf739IknBl6k8t?=
 =?us-ascii?Q?JGqyK+a9ATzQSrzWhicbIscfdMgMrJgoPoEoxbEHVaD74ltVxbwQsXCP/vpH?=
 =?us-ascii?Q?dmd8kV6XLXmdEjCpP9TxRkdhq2RuaobdYTK/9vg2paRuy39aQDdZGPzEOBgr?=
 =?us-ascii?Q?+/P11Rz/sqvlC1Q9li+6/r85cYc4WyEaXIJcd35eaB6EDMBeiy4+XRCuANTC?=
 =?us-ascii?Q?Ehwt1W9tZNbL3JYf+4pqo1NAQc4GPiFZ+NeX8ozg9w1W3sFFrQx7Z7GCghhH?=
 =?us-ascii?Q?K6f6/FDv8LJEftJ3rdl4xHXsoJTXYObDP7SrG4XYT6tT4Ai9QkArfxZD7tgA?=
 =?us-ascii?Q?af5jbDiHlbBdijTa+7d7ZvpJLDDoBpdPj/1cy0irmjtvCZ1sUeA5KO5I1BI6?=
 =?us-ascii?Q?z0cP/3U593r9k+97f//5YzDM3fRhQBN7Vk7g4QZ6cT0irbKX2qO+92u18aCE?=
 =?us-ascii?Q?/4lutF4BKn00+1xR0bHIdVWBI6ujkat6OFx3pMZf+olFB9bGY4pUqsmtJdgR?=
 =?us-ascii?Q?bYkuRZbJ/n422qPh6lu2nlr0sjb0U3UXlczx4k+Fa8zOeRXjiDMhOC59zlEu?=
 =?us-ascii?Q?qeujbjisAK18Grfn6YYg0VULZfmCMjfE4pza5YeqMq7PzCLfnNgj70rnoa0K?=
 =?us-ascii?Q?5x1HIHuqXDVnaTBi2CrZuqKP9a7eGpgXvDzp+xDNCdLJ825mJx07n+3Toe0+?=
 =?us-ascii?Q?fkRN3l0WNxExpmSCS+Yp6dBWxnxmuYHWDj7OI63FLs1fHByaGcEF4L8Dnq3Y?=
 =?us-ascii?Q?GIqjXLmO1UrHZc3uhUTV+tQnU25hQ06IvudoFT2iRedwuPrGI/8yWEiPkd2F?=
 =?us-ascii?Q?CNsX3md1Mnm+d+deMx5N5bhjB0hDLi7SN7xwXQ8mr0wq5lE+NcXlB3gLaC+e?=
 =?us-ascii?Q?HA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 587467d0-d986-4e06-7482-08ddd896a86d
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 05:19:34.1012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ReiQqH+P8GiNUmt/2oDMSn3Y1XwDApX3n///2k6HY7CXKv6VK7jKF5pMENMQzfRS/FZAq0Gh9/ws66Ko8Ucp6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5316
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "BUG:KASAN:slab-out-of-bounds_in_syscall_fault_buffer_enable" on:

commit: 6bc850d6f8f7308a184edfd60ee1acdd89ced128 ("[PATCH 3/7] tracing: Have syscall trace events read user space string")
url: https://github.com/intel-lab-lkp/linux/commits/Steven-Rostedt/tracing-Replace-syscall-RCU-pointer-assignment-with-READ-WRITE_ONCE/20250806-122312
base: https://git.kernel.org/cgit/linux/kernel/git/trace/linux-trace for-next
patch link: https://lore.kernel.org/all/20250805193235.080757106@kernel.org/
patch subject: [PATCH 3/7] tracing: Have syscall trace events read user space string

in testcase: boot

config: x86_64-rhel-9.4-kunit
compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+---------------------------------------------------------------+------------+------------+
|                                                               | 63f89ba6a0 | 6bc850d6f8 |
+---------------------------------------------------------------+------------+------------+
| BUG:KASAN:slab-out-of-bounds_in_syscall_fault_buffer_enable   | 0          | 24         |
+---------------------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202508110616.33657b6c-lkp@intel.com


[ 47.226292][ T1] BUG: KASAN: slab-out-of-bounds in syscall_fault_buffer_enable (kernel/trace/trace_syscalls.c:430) 
[   47.227603][    T1] Write of size 8 at addr ffff8881baea5f10 by task swapper/0/1
[   47.228735][    T1]
[   47.229107][    T1] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.16.0-rc7-00138-g6bc850d6f8f7 #1 PREEMPT(voluntary)
[   47.229114][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   47.229117][    T1] Call Trace:
[   47.229121][    T1]  <TASK>
[ 47.229124][ T1] dump_stack_lvl (lib/dump_stack.c:123 (discriminator 1)) 
[ 47.229134][ T1] print_address_description+0x2c/0x380 
[ 47.229142][ T1] ? syscall_fault_buffer_enable (kernel/trace/trace_syscalls.c:430) 
[ 47.229146][ T1] print_report (mm/kasan/report.c:481) 
[ 47.229150][ T1] ? syscall_fault_buffer_enable (kernel/trace/trace_syscalls.c:430) 
[ 47.229153][ T1] ? kasan_addr_to_slab (mm/kasan/common.c:37) 
[ 47.229156][ T1] ? syscall_fault_buffer_enable (kernel/trace/trace_syscalls.c:430) 
[ 47.229159][ T1] kasan_report (mm/kasan/report.c:595) 
[ 47.229164][ T1] ? syscall_fault_buffer_enable (kernel/trace/trace_syscalls.c:430) 
[ 47.229167][ T1] syscall_fault_buffer_enable (kernel/trace/trace_syscalls.c:430) 
[ 47.229171][ T1] ? mutex_unlock (arch/x86/include/asm/atomic64_64.h:101 include/linux/atomic/atomic-arch-fallback.h:4329 include/linux/atomic/atomic-long.h:1506 include/linux/atomic/atomic-instrumented.h:4481 kernel/locking/mutex.c:167 kernel/locking/mutex.c:537) 
[ 47.229177][ T1] syscall_enter_register (kernel/trace/trace_syscalls.c:729 kernel/trace/trace_syscalls.c:1259) 
[ 47.229181][ T1] __ftrace_event_enable_disable (kernel/trace/trace_events.c:860) 
[ 47.229186][ T1] ? __pfx__printk (kernel/printk/printk.c:2470) 
[ 47.229192][ T1] __ftrace_set_clr_event_nolock (kernel/trace/trace_events.c:890 kernel/trace/trace_events.c:1353) 
[ 47.229197][ T1] event_trace_self_tests (kernel/trace/trace_events.c:1384 (discriminator 1) kernel/trace/trace_events.c:4779 (discriminator 1)) 
[ 47.229203][ T1] ? __pfx_event_trace_self_tests_init (kernel/trace/trace_events.c:4892) 
[ 47.229208][ T1] event_trace_self_tests_init (include/linux/list.h:373 kernel/trace/trace.h:487 kernel/trace/trace_events.c:4871 kernel/trace/trace_events.c:4894) 
[ 47.229212][ T1] do_one_initcall (init/main.c:1274) 
[ 47.229216][ T1] ? __pfx_do_one_initcall (init/main.c:1265) 
[ 47.229219][ T1] ? __pfx_parse_args (kernel/params.c:168) 
[ 47.229223][ T1] ? __kasan_kmalloc (include/linux/kfence.h:58 mm/kasan/common.c:390) 
[ 47.229227][ T1] ? do_initcalls (include/linux/slab.h:909 include/linux/slab.h:1039 init/main.c:1345) 
[ 47.229232][ T1] do_initcalls (init/main.c:1335 init/main.c:1352) 
[ 47.229236][ T1] kernel_init_freeable (init/main.c:1586) 
[ 47.229241][ T1] ? __pfx_kernel_init (init/main.c:1466) 
[ 47.229247][ T1] kernel_init (init/main.c:1476) 
[ 47.229251][ T1] ? calculate_sigpending (kernel/signal.c:194) 
[ 47.229256][ T1] ? __pfx_kernel_init (init/main.c:1466) 
[ 47.229259][ T1] ret_from_fork (arch/x86/kernel/process.c:154) 
[ 47.229265][ T1] ? __pfx_kernel_init (init/main.c:1466) 
[ 47.229269][ T1] ret_from_fork_asm (arch/x86/entry/entry_64.S:258) 
[   47.229275][    T1]  </TASK>
[   47.229276][    T1]
[   47.262431][    T1] Allocated by task 1:
[ 47.263075][ T1] kasan_save_stack (mm/kasan/common.c:48) 
[ 47.263810][ T1] kasan_save_track (arch/x86/include/asm/current.h:25 mm/kasan/common.c:60 mm/kasan/common.c:69) 
[ 47.264530][ T1] __kasan_kmalloc (mm/kasan/common.c:377 mm/kasan/common.c:394) 
[ 47.265210][ T1] syscall_fault_buffer_enable (include/linux/slab.h:905 kernel/trace/trace_syscalls.c:426) 
[ 47.266034][ T1] syscall_enter_register (kernel/trace/trace_syscalls.c:729 kernel/trace/trace_syscalls.c:1259) 
[ 47.266825][ T1] __ftrace_event_enable_disable (kernel/trace/trace_events.c:860) 
[ 47.267743][ T1] __ftrace_set_clr_event_nolock (kernel/trace/trace_events.c:890 kernel/trace/trace_events.c:1353) 
[ 47.268609][ T1] event_trace_self_tests (kernel/trace/trace_events.c:1384 (discriminator 1) kernel/trace/trace_events.c:4779 (discriminator 1)) 
[ 47.269392][ T1] event_trace_self_tests_init (include/linux/list.h:373 kernel/trace/trace.h:487 kernel/trace/trace_events.c:4871 kernel/trace/trace_events.c:4894) 
[ 47.270229][ T1] do_one_initcall (init/main.c:1274) 
[ 47.270971][ T1] do_initcalls (init/main.c:1335 init/main.c:1352) 
[ 47.271669][ T1] kernel_init_freeable (init/main.c:1586) 
[ 47.272429][ T1] kernel_init (init/main.c:1476) 
[ 47.273127][ T1] ret_from_fork (arch/x86/kernel/process.c:154) 
[ 47.273817][ T1] ret_from_fork_asm (arch/x86/entry/entry_64.S:258) 
[   47.274547][    T1]
[   47.274977][    T1] The buggy address belongs to the object at ffff8881baea5f00
[   47.274977][    T1]  which belongs to the cache kmalloc-8 of size 8
[   47.277002][    T1] The buggy address is located 8 bytes to the right of
[   47.277002][    T1]  allocated 8-byte region [ffff8881baea5f00, ffff8881baea5f08)
[   47.279110][    T1]
[   47.279551][    T1] The buggy address belongs to the physical page:
[   47.280447][    T1] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1baea5
[   47.281773][    T1] flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
[   47.282819][    T1] page_type: f5(slab)
[   47.283449][    T1] raw: 0017ffffc0000000 ffff888100041500 dead000000000122 0000000000000000
[   47.284709][    T1] raw: 0000000000000000 0000000080800080 00000000f5000000 0000000000000000
[   47.286003][    T1] page dumped because: kasan: bad access detected
[   47.286854][    T1] page_owner tracks the page as allocated
[   47.287710][    T1] page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 1, tgid 1 (swapper/0), ts 35802055637, free_ts 0
[ 47.290101][ T1] post_alloc_hook (include/linux/page_owner.h:32 mm/page_alloc.c:1704) 
[ 47.290799][ T1] get_page_from_freelist (mm/page_alloc.c:1714 mm/page_alloc.c:3669) 
[ 47.291594][ T1] __alloc_frozen_pages_noprof (mm/page_alloc.c:4959) 
[ 47.292391][ T1] alloc_pages_mpol (mm/mempolicy.c:2421) 
[ 47.293117][ T1] allocate_slab (mm/slub.c:2451 mm/slub.c:2619) 
[ 47.293768][ T1] ___slab_alloc (mm/slub.c:3859 (discriminator 3)) 
[ 47.294447][ T1] __kmalloc_node_track_caller_noprof (mm/slub.c:3949 mm/slub.c:4024 mm/slub.c:4185 mm/slub.c:4327 mm/slub.c:4347) 
[ 47.295322][ T1] kstrdup (mm/util.c:63 mm/util.c:83) 
[ 47.295898][ T1] __kernfs_new_node (fs/kernfs/dir.c:634) 
[ 47.296626][ T1] kernfs_new_node (fs/kernfs/dir.c:713) 
[ 47.297380][ T1] kernfs_create_dir_ns (fs/kernfs/dir.c:1085) 
[ 47.298159][ T1] sysfs_create_dir_ns (fs/sysfs/dir.c:61) 
[ 47.298933][ T1] kobject_add_internal (lib/kobject.c:73 lib/kobject.c:240) 
[ 47.299712][ T1] kobject_init_and_add (lib/kobject.c:374 lib/kobject.c:457) 
[ 47.300448][ T1] net_rx_queue_update_kobjects (net/core/net-sysfs.c:1239 net/core/net-sysfs.c:1301) 
[ 47.301292][ T1] netdev_register_kobject (net/core/net-sysfs.c:2093 net/core/net-sysfs.c:2340) 
[   47.302015][    T1] page_owner free stack trace missing
[   47.302748][    T1]
[   47.303126][    T1] Memory state around the buggy address:
[   47.303914][    T1]  ffff8881baea5e00: 06 fc fc fc 06 fc fc fc 04 fc fc fc 06 fc fc fc
[   47.305085][    T1]  ffff8881baea5e80: 05 fc fc fc 05 fc fc fc 06 fc fc fc fc fc fc fc
[   47.306239][    T1] >ffff8881baea5f00: 00 fc fc fc 07 fc fc fc 00 fc fc fc fa fc fc fc
[   47.307378][    T1]                          ^
[   47.308014][    T1]  ffff8881baea5f80: fa fc fc fc fc fc fc fc 06 fc fc fc 06 fc fc fc
[   47.309220][    T1]  ffff8881baea6000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[   47.310929][    T1] ==================================================================
[   47.312186][    T1] Disabling lock debugging due to kernel taint
[   47.318329][    T1] OK
[   47.318896][    T1] Testing event system hyperv: OK


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250811/202508110616.33657b6c-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

