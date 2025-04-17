Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBE72517A7;
	Thu, 17 Apr 2025 14:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744900993; cv=fail; b=WSFjdyXLZ3gb+MOzInkKFofF5F3w1SxxwTPoXKANKbJ6pEg6NvCMJXkfK419D75NaktOp3CHzcQKz9hUH3Zr0efgQppGM/obEy4VDr1hbQgSFwPNS5vEDTOHcA+1p5rsAy3AfQccgXQron3iOz9GThC6cxGbntpKF12l4PnYCoM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744900993; c=relaxed/simple;
	bh=dygk75gjn6bI9GtUjnlgmaJ8tt20Nrq1ke62U58FfQY=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=Z+9YQK645jPS6jTTfl/SZRfuwdoJrj/4oaYmiQM8fGAdvPaeU7FY3uEEIAymFZwKG3ZWbHAwD4cg0vR1uQX4QB5MLxxn6/3IN0jYAuHpPBVcEFaIVy5BPpG5xq8VLrvznRTfG+kNUjCS5yHjCFexZ6Fu9rEdi4rcSA8GnssQKUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Uo96QvMM; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uo96QvMM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744900991; x=1776436991;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=dygk75gjn6bI9GtUjnlgmaJ8tt20Nrq1ke62U58FfQY=;
  b=Uo96QvMMyS5w9zVmJ7ofxFk02dkw0yK7lX8LB0eXo+y1zINSNRGFMkVL
   DeDNbMeXFqd2ws29cmiHaxtE+0a5WYnA+vSUFzQhlwP41Ir/3+Y4r0dE1
   bWh8XZZuCndceYyEP1aXRS+MgXVEcNjkPMh3Tes394yTulA6rdWKwsLU7
   kYUf6KSi0FpwQvIFpOQVrebqBLg70ltD0VSLVsZOyLPEtC2DFEzc8e1Cu
   mMmCOcHIZkidoAf0GK+Ocnob6eTLbW4m++S9TI2EPyZvVmXsj7f5wxPzJ
   QGhfchSQpNdjUCpaw3NB/3/vDbG4UxIDSOwFNmGIl8S+LzpbkYwqn+Jl2
   w==;
X-CSE-ConnectionGUID: J2MNX2zZTh2D0fnT+c7EFQ==
X-CSE-MsgGUID: gGudhglYTNmhcOVPRxrtsw==
X-IronPort-AV: E=McAfee;i="6700,10204,11406"; a="46662142"
X-IronPort-AV: E=Sophos;i="6.15,219,1739865600"; 
   d="scan'208";a="46662142"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 07:43:11 -0700
X-CSE-ConnectionGUID: Frc5DajWQ6eHE/zfIwTl0g==
X-CSE-MsgGUID: Bpgs36lPTzSgxkZaHFjwZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,219,1739865600"; 
   d="scan'208";a="131360474"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 07:43:10 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 17 Apr 2025 07:43:09 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 17 Apr 2025 07:43:09 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 17 Apr 2025 07:43:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OE1VMDsjSM1bAJKE5NJPFl0vK34FjdxPWqYtO5gzWKgyI8Jri1ioiHtGJABSwzmmHKWXL9S/YBeyhixxoNdD4JtuqhM78ix2m10BRvnOstZUeKlr4oSEaxUeDx7hLvWPcfB45PdJ3PcPTWh3ATYMDt92pvDkH0NEEtGhHIZIYEz8qrD7gcCgEHcUWnjqNNfBqSS4uxsO1y1tJklnfkkYpyXozkSi6kbtDB5y6FX0fLXVzOjQYALzRRTd0+YOxTRjnU2wcHczi2RcA1RkVUcbsnUFn18q8E3XcXf6jkqKhbjQr4mhf9VgI6LwgyoGSRh7+0dFiCb5vrpMbXIL9I8VhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kVEgRr6cQm78Pj3cmQx3lS9Bb5y0lh+ECxgL+lk6MG8=;
 b=xLlYLonCMWPafvaDG75K+eeSllE6InykcLo8sLkHomjU1/U4IOfFPOpvGgChrpHFFBGLCnA7l4Bw/HzsN351eZkBedtRsCxP5Zy2oiAMhE3AxNQoYmfoiKbeDb/RKjNZPSzaS9nfAcdvBdnB3jkLCZf+ey2WctMeEL9oZaIrpA6JPGrr8fCEaitGQxjI40cvqGLVTEUfzwugkQ2CO6wjHiMbyGOxgQmzE9kPI2ooyasUuVmwoLEsuKbIBma4jXpnI3erKbs8ZR0NTcNJcynvxKQqPJ6lHS7nHFRV9xlJK4G6PYQyRtguYCyVh3TOKeG6kEZUm/E3ufjVYWcbIAzA/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DS7PR11MB6037.namprd11.prod.outlook.com (2603:10b6:8:74::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.22; Thu, 17 Apr 2025 14:43:06 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%4]) with mapi id 15.20.8632.035; Thu, 17 Apr 2025
 14:43:04 +0000
Date: Thu, 17 Apr 2025 22:42:55 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linus:master] [tracing]  a3dc2983ca: WARNING:suspicious_RCU_usage
Message-ID: <202504172239.4a2422e2-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: KU0P306CA0094.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:22::16) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DS7PR11MB6037:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fbf40ac-7d4c-4ee5-d546-08dd7dbe294d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?p1qLtMNJJzahBGL0M9xcT6pnNChmtV874bO0LK5gq9nV9AwqLLEJcV3Yp7Rb?=
 =?us-ascii?Q?zXSBwnPLv675QBgH27VYPTeIn5HVAA7BAoomGoVpA6rR/s+zFB9BDK1wz/Ir?=
 =?us-ascii?Q?jJ6nLtAurfj6Dhmt/xf026WpIrxFq8EWWzgvFOQzuHN+A0tEEAVlIoLInYsa?=
 =?us-ascii?Q?NKU/iFOacBK3PrygbL9bOjLy4JnWqHKaMvtNGgsMmpIsUG4Xb557MMSveQB9?=
 =?us-ascii?Q?+6WRH+3wlXMLVFuL6pa/bryEqc2uXP4o4LyZ7oDszZ+fDF0dz1sxOilQ8mSx?=
 =?us-ascii?Q?ED+VYBKAg1fHGc1PCwCRvsdia9HIafsEDGoBQczYNLv8xtAmtfyZ4cNRte7r?=
 =?us-ascii?Q?4YSjX92C5sFpDadgB/b6NG3l/XfL7a7kFnKq82eW8rm4f7i/TTFN6KdHvYLr?=
 =?us-ascii?Q?1ya3kpQf57fet+ork42oFpsy15c3+hGV/zmuPYRJiV2J5r4pS+B7kugyFaoe?=
 =?us-ascii?Q?QKinV+Rt+JruW2jCTo2FNBmv8MQzmywPtMrVkaZWfoBOGi3oKg0EnDYzui8V?=
 =?us-ascii?Q?UaPw+qu92fY9Jr4GPHZ/+lKbPxmSn2UNffiO84AyIQmbOpOY4sKr3m5J+h3y?=
 =?us-ascii?Q?N7ESd/m9jLYmAJY1z+22LDw+0mKYqLYhXjCyprGwxJt4EhZHOtu+3rWLEXrI?=
 =?us-ascii?Q?G+eIaqmkkPl1y81u2XD92dCq6OkR0ND7QL+20iMxmn3mZIX/n+Nstc7ZwcG5?=
 =?us-ascii?Q?x6DvOf5Til7aPhSk5ARKmE0JwjwGlH7mce0OsdoPrdbSTIKGICoGlhjiXRap?=
 =?us-ascii?Q?nZcz7P2Qm5E+++QnU7RMQcX39iua5QwXG0f/qr812BLgko7gOonbmg+0YNtP?=
 =?us-ascii?Q?v+gV1s1e78XWTwobEh1/kd8U2f1TvQQIXPZDhvsTd9aJ2yqFo2IDhvnhq40P?=
 =?us-ascii?Q?ZZbw4ZTYaZUbzqTPXTaf1RbA29UpPH30l55Du5QYiTNKXl7pdH35Y9oZK+Fc?=
 =?us-ascii?Q?bg95fDBH8VBEjWVe3roe2YkddKuH0THF5rUQmoRxHu456LSfPb+b+Zo7Wa20?=
 =?us-ascii?Q?CGVRyfe5KNFZz6OC3fKr4S3+0/XpUgm74ju7hhggMgiXe47tqhLafUhXhNuu?=
 =?us-ascii?Q?FAmCLxm4XEuSY93L++idf1GOsI4jRvRHLS2kF0IMWTNFZ9vAwcvCP/oYH27p?=
 =?us-ascii?Q?E6A9ruHdJ59uLqb3Bx60SDFiKM/MwCUdKRWQPL0glPq8mR4cKu/+GlOYM06Q?=
 =?us-ascii?Q?V4+199vgE6jRI0z1lP1oo2fEfnXzrWv48+Z3F9KJ9bjXhU2ht+1/SJcwF/zZ?=
 =?us-ascii?Q?o0QjPfbF+KKh+uLl1fgDrFva5VA6XHxVwPyIjXF4CumVdvBI+Mhlg7UAaYh0?=
 =?us-ascii?Q?Dz6SVtDUxSEJen5YxWroRTlYWNtttpE4laEZY//tsXFztmVzVPiGnnpEYvnd?=
 =?us-ascii?Q?e2XzILUAZ8hSF4CM7RXuQ205ZTWq?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EIG3BDHkYG+37FwTSRk/kGlNoB8F8UTXsAPVsmXAjaDLnt5TiSTuYf4SAvlr?=
 =?us-ascii?Q?+JlhVZ7LwyPsjHLbFQIneY3j4ueVogEc5eUcowk3+Nr17+a8mzGX74IzNZta?=
 =?us-ascii?Q?dVNm+vkCPnb39w7Xpj+JfnIPjRjaLFiPkvwg9W/FUTAzvcPuvYcr/kl+m0eS?=
 =?us-ascii?Q?gMSLOd67l6Ty8wx+1ZGx92iIj5f8KQmx9mTt2J9ddPrs/hcP+Gs2uOZFjOu7?=
 =?us-ascii?Q?YDo9bn7CzdPgMNi6xbbUUAKstI4skgNX3sDMaSK8jjkgXqqMkAjOkpwlEPxX?=
 =?us-ascii?Q?TKqe/ISLf2uMLq86Jyo+P5Wf7B7yRJAFRVBaPkzr2gog0NPBpY2x8XzAJWSP?=
 =?us-ascii?Q?E75nljbU2edfAV9cpa7jL7p0eubKwOnTMiG+9t8zKjJx0jirHNAJcmIXOf9w?=
 =?us-ascii?Q?pZAWUg4R8QkNf0J0I+0fHJ7ifZfpt1KifPu+Y+/hjKkF9PimX89DZwQrPNd0?=
 =?us-ascii?Q?70Yp1lOjcAtY+m6c7jzIlpGWxXPWE/lXYeyhv0a2a/iixfKAF+wRUDcFz3kZ?=
 =?us-ascii?Q?N+74JegM2D0RkXquudOYuwrVzCwxrXnTjM8zp2fGMy6pwlBpdEpkIqtrIY6w?=
 =?us-ascii?Q?t75SKrkeIETHU8Erdiyze7UwCP1VJqA+72hD1doiWPDNpPVfOhfIekHX9rIv?=
 =?us-ascii?Q?Zl9EOQ17TM1M/N8Az6wuBV8fQISP4tM+T2WYLqp9IAIEP9hQQJwrBsiBfCQW?=
 =?us-ascii?Q?DtjvXDBr15nsTYXJllLr2vb5xOIWwyrfbkSGdxnl79lbppnHLoJzqs30ETjh?=
 =?us-ascii?Q?iOpMCjBhNAv+zl8biuS5kdyGmXFMHtOS4+DN6Kq045a8eFn8roIumPvbcmSs?=
 =?us-ascii?Q?CF13rb5E/bIVQ0YrtNRnbXk07Fd2viYBbhcnnzecNgvhji/lttwVquJskjlb?=
 =?us-ascii?Q?zCFds+uMDooRbRE7KWtB0o6bnsEaUK+SU3qSkogx6iSOBNauRhk/YM3r3m7X?=
 =?us-ascii?Q?d+TQ6sQ/fnjNMnwK1pfuR5a9kyRUugdsqkQiCL6cAg0JkTDGMZYWHED8dd8v?=
 =?us-ascii?Q?EJsUl+vL7iXlgGc0JSObSvogVXJnNhzHLQii7MPR/nQ3Jww2dtFZWHDAxR3S?=
 =?us-ascii?Q?3TcAA9UtKiJlHa1YvxLo0mvbS1wh2gD/OO3I8hJgl4wd/zqbCTfufGMBAR6g?=
 =?us-ascii?Q?/D1mRajDC/IaleV/OrxEGCKZzN0Pck4oRlLtGxEwZ35B3Ngn+aNL29wrJLnG?=
 =?us-ascii?Q?gUsnMJWICgFujRajzGLNDnLyvZ6IBMrqthrvf404HdX6Ojz7rpeVrfkm3Ozt?=
 =?us-ascii?Q?kRNZlOdkvP8iXbWO3n8vJEcfUfG8qmB9AcddKX4O6JFIsG61x2NxQ1M7zWDA?=
 =?us-ascii?Q?a4jpoqLFR8lnPgzeDgbtpKRHkUgDIo4LDDyhKNp8L7JhztI76Vskq/oYsyRr?=
 =?us-ascii?Q?yYclFqR6G8WKR7IbXbg6Nc9VOuwqpDHlxx7AN8gruxjghCCMFdOeqtJohCPU?=
 =?us-ascii?Q?ZrWCVVYGwCnMICM8lVABge4QM4GmYrt1Q28vrT2QSL2UBF5qMgqAlIzYBxkP?=
 =?us-ascii?Q?53G23Z9wJr+yHp8tCXWYR8zKe/NAmuHLZYxMeeACei1NlM1zGvNwJzrRLcW+?=
 =?us-ascii?Q?y9aWXw3wFkyc+zsCVf8KI6j41mimSkihQZp5jRaznpcsSnNaq9ci9o3FYCLl?=
 =?us-ascii?Q?xQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fbf40ac-7d4c-4ee5-d546-08dd7dbe294d
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 14:43:04.8485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5io3++T3eSL5YhAHPxWF4FvkW13pXHI0uOzzxgYLvPUEJv0/BDMCLGDiUb70V8XCSUTw4pzHsaQ8wHRQYh1MfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6037
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:suspicious_RCU_usage" on:

commit: a3dc2983ca7b90fd35f978502de6d4664d965cfb ("tracing: fprobe: Cleanup fprobe hash when module unloading")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master      834a4a689699090a406d1662b03affa8b155d025]
[test failed on linux-next/master b425262c07a6a643ebeed91046e161e20b944164]

in testcase: boot

config: x86_64-randconfig-r052-20250414
compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+-----------------------------------------------------------------+------------+------------+
|                                                                 | dd941507a9 | a3dc2983ca |
+-----------------------------------------------------------------+------------+------------+
| WARNING:suspicious_RCU_usage                                    | 0          | 12         |
| kernel/trace/fprobe.c:#RCU-list_traversed_in_non-reader_section | 0          | 12         |
+-----------------------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202504172239.4a2422e2-lkp@intel.com


[   16.078479][  T140] WARNING: suspicious RCU usage
[   16.078939][  T140] 6.14.0-00003-ga3dc2983ca7b #1 Not tainted
[   16.079450][  T140] -----------------------------
[   16.079768][  T140] kernel/trace/fprobe.c:457 RCU-list traversed in non-reader section!!
[   16.080214][  T140]
[   16.080214][  T140] other info that might help us debug this:
[   16.080214][  T140]
[   16.080781][  T140]
[   16.080781][  T140] rcu_scheduler_active = 2, debug_locks = 1
[   16.081220][  T140] 2 locks held by systemd-udevd/140:
[ 16.081511][ T140] #0: ffffffff83474cf8 ((module_notify_list).rwsem){++++}-{4:4}, at: blocking_notifier_call_chain (kernel/notifier.c:380 kernel/notifier.c:368) 
[ 16.082152][ T140] #1: ffffffff8349b610 (fprobe_mutex){+.+.}-{4:4}, at: fprobe_module_callback (kernel/trace/fprobe.c:488) 
[   16.082725][  T140]
[   16.082725][  T140] stack backtrace:
[   16.083056][  T140] CPU: 0 UID: 0 PID: 140 Comm: systemd-udevd Not tainted 6.14.0-00003-ga3dc2983ca7b #1
[   16.083059][  T140] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   16.083060][  T140] Call Trace:
[   16.083062][  T140]  <TASK>
[ 16.083064][ T140] dump_stack_lvl (lib/dump_stack.c:123) 
[ 16.083069][ T140] dump_stack (lib/dump_stack.c:130) 
[ 16.083072][ T140] lockdep_rcu_suspicious (kernel/locking/lockdep.c:6848) 
[ 16.083081][ T140] fprobe_module_callback (kernel/trace/fprobe.c:457 kernel/trace/fprobe.c:489) 
[ 16.083084][ T140] ? mutex_unlock (kernel/locking/mutex.c:524) 
[ 16.083097][ T140] notifier_call_chain (kernel/notifier.c:85) 
[ 16.083105][ T140] blocking_notifier_call_chain (kernel/notifier.c:381 kernel/notifier.c:368) 
[ 16.083110][ T140] do_init_module (kernel/module/main.c:3086) 
[ 16.083119][ T140] load_module (kernel/module/main.c:3458) 
[ 16.083130][ T140] init_module_from_file (kernel/module/main.c:3648) 
[ 16.083147][ T140] idempotent_init_module (kernel/module/main.c:3659) 
[ 16.083165][ T140] __do_sys_finit_module (include/linux/file.h:62 include/linux/file.h:83 kernel/module/main.c:3682) 
[ 16.083172][ T140] __ia32_sys_finit_module (kernel/module/main.c:3669) 
[ 16.083176][ T140] ia32_sys_call (kbuild/obj/consumer/x86_64-randconfig-r052-20250414/./arch/x86/include/generated/asm/syscalls_32.h:351) 
[ 16.083181][ T140] __do_fast_syscall_32 (arch/x86/entry/common.c:165 arch/x86/entry/common.c:387) 
[ 16.083187][ T140] do_fast_syscall_32 (arch/x86/entry/common.c:412) 
[ 16.083191][ T140] do_SYSENTER_32 (arch/x86/entry/common.c:451) 
[ 16.083194][ T140] entry_SYSENTER_compat_after_hwframe (arch/x86/entry/entry_64_compat.S:127) 
[   16.083198][  T140] RIP: 0023:0xf7ee3579
[ 16.083201][ T140] Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 cc 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
All code
========
   0:	b8 01 10 06 03       	mov    $0x3061001,%eax
   5:	74 b4                	je     0xffffffffffffffbb
   7:	01 10                	add    %edx,(%rax)
   9:	07                   	(bad)
   a:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
   e:	10 08                	adc    %cl,(%rax)
  10:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
	...
  20:	00 51 52             	add    %dl,0x52(%rcx)
  23:	55                   	push   %rbp
  24:*	89 e5                	mov    %esp,%ebp		<-- trapping instruction
  26:	0f 34                	sysenter
  28:	cd 80                	int    $0x80
  2a:	5d                   	pop    %rbp
  2b:	5a                   	pop    %rdx
  2c:	59                   	pop    %rcx
  2d:	c3                   	ret
  2e:	cc                   	int3
  2f:	90                   	nop
  30:	90                   	nop
  31:	90                   	nop
  32:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  39:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi

Code starting with the faulting instruction
===========================================
   0:	5d                   	pop    %rbp
   1:	5a                   	pop    %rdx
   2:	59                   	pop    %rcx
   3:	c3                   	ret
   4:	cc                   	int3
   5:	90                   	nop
   6:	90                   	nop
   7:	90                   	nop
   8:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
   f:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
[   16.083203][  T140] RSP: 002b:00000000ff85cc9c EFLAGS: 00200296 ORIG_RAX: 000000000000015e
[   16.083206][  T140] RAX: ffffffffffffffda RBX: 0000000000000006 RCX: 00000000f7ecdd41
[   16.083208][  T140] RDX: 0000000000000000 RSI: 000000005670d000 RDI: 00000000566fe070
[   16.083209][  T140] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
[   16.083211][  T140] R10: 0000000000000000 R11: 0000000000200246 R12: 0000000000000000
[   16.083212][  T140] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[   16.083227][  T140]  </TASK>


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250417/202504172239.4a2422e2-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

