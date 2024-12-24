Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2CA1C5F25;
	Tue, 24 Dec 2024 15:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735053316; cv=fail; b=X2ec35Vl0dtzNObnDufhJ8xPqDnJyalKHwtyrYNf6qLOEFRcJbC94m6p3pSdtXGHB7maIlaSbagjgpcdKkxaZzGEnH+cDCm31h8AngPi1tHtsqqnhyj8j/PRVYwfRBTWjrjrD/n/7EIF0VEmlcWN9urgX/DEDIuBI5TXDHR3r98=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735053316; c=relaxed/simple;
	bh=6vuuoAs3/fCrQJc//6Cc8ZlnBMc5QghZDZMz/oGHpmg=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=Cc/avY+1TdxBCtsHA+wtUpX53N/WWHgZuStSIYF1SBLmyw8GgnAgjRMFIKk0CYvOADFhYfJgZXP0QnYwlsPUmbK44wq1BzkoFIYHXCEKWl+34h1FiWrmdmznMQR5Qi+zi/cvMZHAEU2ZRrgOvgx9lV8p8TUeM/+Y4OlwiFfUArc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pj0saQed; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pj0saQed"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735053313; x=1766589313;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=6vuuoAs3/fCrQJc//6Cc8ZlnBMc5QghZDZMz/oGHpmg=;
  b=Pj0saQedFGEMiMbhPw1L9BWhLZJlEq7ElWxngldW1dhqIERJ/nIa9vPj
   trDMhunW8qrc1kK94zsWwtdB0G5sjvQkxedo8BJpaqKjtQKDvg25H1Nuo
   cJ/vnLLFhTS7p/xhJvRKvBzZrcRbH8P6WrxZn3YdZKvYdc8wvWmXD2nFA
   Yem8D8HELX9y3dxqs/TypY1aydSuvmzWUji2/y349Bmq64kR0Ad60fbBQ
   X1NJDYMKU0c3H1NuQ8GQ46uCJLoQG5eDUUGot40MHPzI57ePFl/vWazi5
   alyO8vQCGlojQqz5lxMyzD4g9ngKiPcy2XWTVFQAOcxkdiKGRitNfucpd
   Q==;
X-CSE-ConnectionGUID: 3ZTEAYAARFuxYOHSW4ZPIg==
X-CSE-MsgGUID: el1pGzhCR9OcpuoDQS5xew==
X-IronPort-AV: E=McAfee;i="6700,10204,11296"; a="39303005"
X-IronPort-AV: E=Sophos;i="6.12,260,1728975600"; 
   d="scan'208";a="39303005"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2024 07:15:12 -0800
X-CSE-ConnectionGUID: aR94RyW8RHy0VNFN+dm4nQ==
X-CSE-MsgGUID: +GbEVaRcSjmyZ03vEfrMsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="104583201"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Dec 2024 07:15:13 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 24 Dec 2024 07:15:12 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 24 Dec 2024 07:15:12 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 24 Dec 2024 07:15:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JJr+ihi/6C8a7F5CzgHrR2KwYsrJlzkPIeMOk1vR6xjBqNPdhRfPLERCTfBQ6psqwfZqY8iPq3pf5tJ0+D4LLjFomePDwiljpC/s92Ene+uU/Tmjb44ukzgpTnL6+8mZCQ13FxzDw4Ci/JWGL/sJzb4bRfr+aezJzjRKYMAGwz4qAKGA9PMjACiGV33WU2VKWdEf5eVxc+Eu2q5VLl4s78/cYR7qAAcp+8eU7mGF64Pl3kp935xLVZT8gRk/QrpxbEFay65tMKPdYBqriqQUzCpnNbEI+16lyvyCZgK7m6V+H5e9TVlRcEgolhM75quPm6VTvDsoTz6p/WnjGNI1FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cOiewIsFyivC43jBT/fTklpzw0IgpM3PWSTM44GRjeo=;
 b=fGNcNoYY6/EliVBDTbxoU7U9RSraMgTG1n8Kvy0FHhijkDYJl2BoB3u9sFMTyHB5bPB9F7dGHKLSLc+qkCngqb2KMv84qi7ehHJWflubB5PDmB1YoM2pYIL6YscOrPcqZjqhlMohy4hR9B1DHWobgm/DnNUzkEmCMsyy/YzM3xcqt0Swdf5+TR77AUUyfr0LN2s8XyD8LUh7toXt6ApvGLDxsPZhFGHv26ld/FCpCuibsZWILelRDBfKOlRvL6z7Sr6ine8IPjfduzDYGpCcuMiTuYRIxdKZiWQmsPafEhk5RL6QUrvjKpO3v4ME4u8uUnBlhhk/+rLKWcAD7JzT7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CY8PR11MB7778.namprd11.prod.outlook.com (2603:10b6:930:76::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.20; Tue, 24 Dec
 2024 15:14:51 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%6]) with mapi id 15.20.8293.000; Tue, 24 Dec 2024
 15:14:51 +0000
Date: Tue, 24 Dec 2024 23:14:40 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Steven Rostedt <rostedt@goodmis.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
	<akpm@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, "Linus
 Torvalds" <torvalds@linux-foundation.org>,
	<linux-trace-kernel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linus:master] [tracing]  65a25d9f7a:
 WARNING:at_kernel/trace/trace_events.c:#trace_event_raw_init
Message-ID: <202412242355.7e1a8e45-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR02CA0010.apcprd02.prod.outlook.com
 (2603:1096:3:17::22) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CY8PR11MB7778:EE_
X-MS-Office365-Filtering-Correlation-Id: a35f1a72-bbcf-4078-3a68-08dd242db664
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?znw+IgJWg9MQyZXpxaHlbk6gf9+akllmRLhU0CsiIU0x2n4PRmavpgWkzFHd?=
 =?us-ascii?Q?o2TqR3Oa1UPwmV8768dUF89JfVq8cuoT5WTzNigLr7ZJ6ws7QgyvLzbx5MpO?=
 =?us-ascii?Q?+kX+UZ+nNCYwJneUOrNnaWaqtTWomW7sbl8X3jDACNyk5vsSszQEsgkJitpo?=
 =?us-ascii?Q?Nb+S2P1oRwiVcn03phgtbHE96noIDEhyDe50N2YJNqxzp+nJESZiGtrlaKyP?=
 =?us-ascii?Q?L6ArmlCSo0QYGt+T35oC3Eaogfp6akETZ0D7OZqm+bcZrojEOGww870yamKi?=
 =?us-ascii?Q?dnbTWC7ancsmADioFbRv6aNpD/UIr+dcr8imE668qlfKxkzTeWnfl4gEgW1o?=
 =?us-ascii?Q?mqvrYOBSBRGoAnwGLpTS4toS8dRf2eqNvRBcwSqdbZa7vnOf42o810oeetDG?=
 =?us-ascii?Q?o6k4Pk9cOw+F/sKlhspejUIVKJyL7Qgiog5A3hueinT/937Ix6WiwepF453R?=
 =?us-ascii?Q?d3BRk5OPkymlwA54C7wObHyPW+i87lbEre/xpTc2aLJqD1UpQgqzK9AYuCVt?=
 =?us-ascii?Q?CQil2E6MYjiTyY4bOIuQsg8yc0AXUCiNAq+pX+Kufl4DVUqdv3/65dXrULpe?=
 =?us-ascii?Q?yc0kM6NxMf7CmqUE3AVCAcIdhD1N/GSVimt3bKeVWFIYqRSaCVM1XWxTTaw2?=
 =?us-ascii?Q?vSIm9mJVpH+gKJAMvOfQZN+o9zYp/E1jYpyuXflrgFzgK/HcCQ9hetNduRfh?=
 =?us-ascii?Q?1Ju6+zgA/JX6OMwklpI0PNiMDseiGiVvupStCOjyTB8xyi8QddTmnFsgE/Ic?=
 =?us-ascii?Q?JTRSY5mvMoLlH/TbZy62X559I9LcrOllsUWq8BGi9h7LJ0RBNc60ILLoXeDQ?=
 =?us-ascii?Q?l9RJswG9wYBiDm8XRSeSn7KajfQm/xex2DUn70wr7E6Ps6a5iyD4xzISa06N?=
 =?us-ascii?Q?klaeABo6QPjPJWIYI7FoOKOluO/RvTFVqgnWQSh1MX0NKpCo0OMt8vMNwhBz?=
 =?us-ascii?Q?tRWV+9+Ue9Rg+fXTTS4qngJ3tidI153mAy3rfckUU6rZzjQXcAReiFEMNyLi?=
 =?us-ascii?Q?fNs6xzvsQl4Oe7fiQVsKo+a523PKDsONtbhaXiVr0R2yx9syJaFWjYCINmhM?=
 =?us-ascii?Q?dZDlreGbqJaYddROuvsTJ4L2CfbZb6WWjFK2nUPa4R3TOgVhO7/5kR9jScMb?=
 =?us-ascii?Q?2W+xfQ9UEJAvIPl5Y6Y1UNeT/TrfOYqz1RdmXDtsMwOL5DlMT8BBlLydzDtK?=
 =?us-ascii?Q?o6KYsLPFd8uhtIoAnkBsemzHqWkoA1KV8cQKvf/GDthbRKVXevl31cE4oicD?=
 =?us-ascii?Q?3cUWKuS5m8PYrCyHvLUGFgNjWOtlETOvlW9ArMIbCQGstBKpE+1MjJ8RlHvt?=
 =?us-ascii?Q?UwR9WpF/3KBIBNj/PMCqGm5oIGLQPcxOUk6TDXuOE84eiw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WVSa77BZaaxWksaoGZ1uQ8rtps09GEjD+iLXsmZyFS3pLl2MXrTnI6PccYc1?=
 =?us-ascii?Q?y80H83vI4PwkEHJHcW1+5BGKMTDHLSbetwbgQoIaCsrpfu+ucBwtuixkZU++?=
 =?us-ascii?Q?TmLUanxz99kPrnjajf1BVy7UJIj5WDZPgjE/xbPM8QygdyVuiCMHRRuOOCTm?=
 =?us-ascii?Q?Sj1AtYbKmy/eNutFvLGlRElaO+AoyRQt0TrMyW9hFdCN5Yo5vtK3Uj+29un4?=
 =?us-ascii?Q?d/yBmFKiHZ6mv8q8Vw7+sFhGZ2zjToS8B/eBGL12OvvUevMCIqEU+Y3psQWm?=
 =?us-ascii?Q?w6g/1mh+yt5L5PduK6jOJQXI3iud2TfWwxJXYkc6TBYMGO8ITXJt+Ky27ov7?=
 =?us-ascii?Q?t/eodh8PEUAopt6kn57xBxNiKXbat/J1WiYXyrEfilm4hbghwfqMeez5vN9U?=
 =?us-ascii?Q?cfUzk94+YF+a0v8wJRnI2SvtsUicm6hRj2EEFY0l1/2kK6+WxE7nbCihk6Js?=
 =?us-ascii?Q?Xz3/I/7Vs3LM4liTAS0oiYs5QiKlTeiLTVWGgz6EsApHPKT82Uo72Uk0J7Ui?=
 =?us-ascii?Q?8IceM/aTOIfZZtfZjBPonyaSWIs75UqYZ9zoUA9IS/zvFwogMNjoVveI07R7?=
 =?us-ascii?Q?BWvFwiikJy1CVMNMX6SXhXJfST2H0CjD0ZdL+ezVZFMSVg6X7XsNvBl4QeXV?=
 =?us-ascii?Q?IGrIDSiVedZHq3qxIeA+rlNIBRv7s+IYGFAH1DI3cDgrgwr999O7cxpbVem9?=
 =?us-ascii?Q?Hup6S7lwyvhziUlBjjYG3nEid+/Q/QvBIHNxgAg0YqC//KvjxpGLfbq8rwzE?=
 =?us-ascii?Q?5wTWS+UnJsLtNfhMm5Is91l9CTfvAwB3g4ftxWy460fg+pp0Lh3X2ykxYlL0?=
 =?us-ascii?Q?XpOlI/GtXA+b4VMvnLQeEwTi0FBZQk7vWvR9MGDP6ADxWwfIlMTrY1EYd02L?=
 =?us-ascii?Q?/rjw5762YhWFLEKNKRkSyai5x+cVtkNAL7Gk7V27kaLdsGEEnN/IyKnWpjxN?=
 =?us-ascii?Q?SozRKYhxD6dqfd8++EgdGO1BRQvT0gNykjWYZ0lbVH0e4w9f1vTwZvlyklP5?=
 =?us-ascii?Q?q2T1H6uPnvopYLJNqSV03UsMTvgYDWuTobRXu4zacl8h+AvsnnaUPYTlDB7l?=
 =?us-ascii?Q?TGJWbvyGxgjTxBvpfTpUracVHuf111RLE71ywwlAtj94pgFjVVeX5Dy8IFtr?=
 =?us-ascii?Q?hfMnPaPkiQGlSa4sXHNCsqHylLD/Nl2mTm2wayWMOAruNlYfW3ORYHFs0gYM?=
 =?us-ascii?Q?smv5bcQpXc48oZPefYiQe7CW1AMcjDoyfhojWFk3vQX+4WC1oz9aOa3JdMQK?=
 =?us-ascii?Q?XTYn2P9acZIdixe8I3+w52pVRw3kryTItGzStORngmjQpUzpHvH8OhCKdjsO?=
 =?us-ascii?Q?rdM5CLlUsNhn1XODVeecq0tK0k5AS7xKttmkDsI8raChlb5lW7JdUw8M6PzA?=
 =?us-ascii?Q?7RA0edqHFoBfgrvAzZBs0dkZRnGkbdB3oBBEDrfYILwFsiFqiDFCRc9qpsh7?=
 =?us-ascii?Q?WJcxjnbM2pHVHC6QHLitpEP4HlvtS/l2MDr89ZbAvrPB3dVIWOUHPkhEPnIJ?=
 =?us-ascii?Q?xjUFEnvJb4x5TFF+zNLN0GRuWBvR0PCG20WHikMbkhSRLIuz9Wt4GLLA/k+R?=
 =?us-ascii?Q?c9IeQ6Ecud4bRCjmJa3fZkfGUCjQ/3udBr6oy937/5/3UJyBXl5t0+WietIB?=
 =?us-ascii?Q?xQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a35f1a72-bbcf-4078-3a68-08dd242db664
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2024 15:14:51.1929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f+PeCVw6Tgpf/Ohk5AigDHJCYKfXdhKJEfbX8wl21AgSRfTzUe9rLiU7D74xss4BajrthY8Epraj01m7FJRL7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7778
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:at_kernel/trace/trace_events.c:#trace_event_raw_init" on:

commit: 65a25d9f7ac02e0cf361356e834d1c71d36acca9 ("tracing: Add "%s" check in test_event_printk()")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master      8faabc041a001140564f718dabe37753e88b37fa]
[test failed on linux-next/master 8155b4ef3466f0e289e8fcc9e6e62f3f4dceeac2]

in testcase: boot

config: i386-randconfig-053-20241220
compiler: clang-19
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+--------------------------------------------------------------+------------+------------+
|                                                              | 917110481f | 65a25d9f7a |
+--------------------------------------------------------------+------------+------------+
| WARNING:at_kernel/trace/trace_events.c:#trace_event_raw_init | 0          | 18         |
| EIP:trace_event_raw_init                                     | 0          | 18         |
+--------------------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202412242355.7e1a8e45-lkp@intel.com


[    0.503105][    T0] ------------[ cut here ]------------
[ 0.503689][ T0] WARNING: CPU: 0 PID: 0 at kernel/trace/trace_events.c:565 trace_event_raw_init (kernel/trace/trace_events.c:565 (discriminator 12))
[    0.504700][    T0] Modules linked in:
[    0.505081][    T0] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Tainted: G                T  6.13.0-rc3-00003-g65a25d9f7ac0 #1 6c7ccd2413e19711a46a7487fb4ceeafbe928cd0
[    0.506382][    T0] Tainted: [T]=RANDSTRUCT
[    0.506662][    T0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 0.507644][ T0] EIP: trace_event_raw_init (kernel/trace/trace_events.c:565 (discriminator 12))
[ 0.508190][ T0] Code: 89 f0 83 c4 04 09 f8 75 21 b8 88 b2 60 84 89 da 31 c9 6a 00 e8 cf e5 ff ff 83 c4 04 31 c0 8d 65 f4 5e 5f 5b 5d 31 c9 31 d2 c3 <0f> 0b b8 88 b2 60 84 89 da 31 c9 6a 00 e8 ac e5 ff ff 89 f2 83 c4
All code
========
   0:	89 f0                	mov    %esi,%eax
   2:	83 c4 04             	add    $0x4,%esp
   5:	09 f8                	or     %edi,%eax
   7:	75 21                	jne    0x2a
   9:	b8 88 b2 60 84       	mov    $0x8460b288,%eax
   e:	89 da                	mov    %ebx,%edx
  10:	31 c9                	xor    %ecx,%ecx
  12:	6a 00                	push   $0x0
  14:	e8 cf e5 ff ff       	call   0xffffffffffffe5e8
  19:	83 c4 04             	add    $0x4,%esp
  1c:	31 c0                	xor    %eax,%eax
  1e:	8d 65 f4             	lea    -0xc(%rbp),%esp
  21:	5e                   	pop    %rsi
  22:	5f                   	pop    %rdi
  23:	5b                   	pop    %rbx
  24:	5d                   	pop    %rbp
  25:	31 c9                	xor    %ecx,%ecx
  27:	31 d2                	xor    %edx,%edx
  29:	c3                   	ret
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	b8 88 b2 60 84       	mov    $0x8460b288,%eax
  31:	89 da                	mov    %ebx,%edx
  33:	31 c9                	xor    %ecx,%ecx
  35:	6a 00                	push   $0x0
  37:	e8 ac e5 ff ff       	call   0xffffffffffffe5e8
  3c:	89 f2                	mov    %esi,%edx
  3e:	83                   	.byte 0x83
  3f:	c4                   	.byte 0xc4

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	b8 88 b2 60 84       	mov    $0x8460b288,%eax
   7:	89 da                	mov    %ebx,%edx
   9:	31 c9                	xor    %ecx,%ecx
   b:	6a 00                	push   $0x0
   d:	e8 ac e5 ff ff       	call   0xffffffffffffe5be
  12:	89 f2                	mov    %esi,%edx
  14:	83                   	.byte 0x83
  15:	c4                   	.byte 0xc4
[    0.510118][    T0] EAX: 00000018 EBX: 00000001 ECX: 00000000 EDX: 00000000
[    0.510764][    T0] ESI: 00000018 EDI: 00000000 EBP: 83f67f3c ESP: 83f67ea0
[    0.511422][    T0] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00210006
[    0.512164][    T0] CR0: 80050033 CR2: ff9ff000 CR3: 048d9000 CR4: 00000090
[    0.512839][    T0] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[    0.513519][    T0] DR6: fffe0ff0 DR7: 00000400
[    0.513962][    T0] Call Trace:
[ 0.514276][ T0] ? show_regs (arch/x86/kernel/dumpstack.c:478 (discriminator 1))
[ 0.514680][ T0] ? trace_event_raw_init (kernel/trace/trace_events.c:565 (discriminator 12))
[ 0.515186][ T0] ? __warn (kernel/panic.c:242 kernel/panic.c:748)
[ 0.515576][ T0] ? trace_event_raw_init (kernel/trace/trace_events.c:565 (discriminator 12))
[ 0.516094][ T0] ? report_bug (lib/bug.c:199 (discriminator 2))
[ 0.516522][ T0] ? exc_overflow (arch/x86/kernel/traps.c:301)
[ 0.516952][ T0] ? handle_bug (arch/x86/kernel/traps.c:?)
[ 0.517363][ T0] ? exc_invalid_op (arch/x86/kernel/traps.c:309 (discriminator 1))
[ 0.517815][ T0] ? handle_exception (arch/x86/entry/entry_32.S:1048)
[ 0.518296][ T0] ? exc_overflow (arch/x86/kernel/traps.c:301)
[ 0.518704][ T0] ? trace_event_raw_init (kernel/trace/trace_events.c:565 (discriminator 12))
[ 0.519182][ T0] ? exc_overflow (arch/x86/kernel/traps.c:301)
[ 0.519614][ T0] ? trace_event_raw_init (kernel/trace/trace_events.c:565 (discriminator 12))
[ 0.520146][ T0] ? __set_enter_print_fmt (kernel/trace/trace_syscalls.c:227 (discriminator 3))
[ 0.520642][ T0] ? set_syscall_print_fmt (kernel/trace/trace_syscalls.c:256)
[ 0.521139][ T0] event_init (kernel/trace/trace_events.c:2832)
[ 0.521533][ T0] event_trace_enable (kernel/trace/trace_events.c:4163)
[ 0.522007][ T0] trace_event_init (kernel/trace/trace_events.c:4256)
[ 0.522452][ T0] trace_init (kernel/trace/trace.c:10838)
[ 0.522824][ T0] start_kernel (init/main.c:999)
[ 0.523252][ T0] i386_start_kernel (arch/x86/kernel/head32.c:79 (discriminator 1))
[ 0.523740][ T0] startup_32_smp (arch/x86/kernel/head_32.S:292)
[    0.524202][    T0] irq event stamp: 0
[ 0.524575][ T0] hardirqs last enabled at (0): 0x0
[ 0.525196][ T0] hardirqs last disabled at (0): 0x0
[ 0.525821][ T0] softirqs last enabled at (0): 0x0
[ 0.526405][ T0] softirqs last disabled at (0): 0x0
[    0.526966][    T0] ---[ end trace 0000000000000000 ]---
[    0.527479][    T0] event xe_bo_move has unsafe dereference of argument 4
[    0.528145][    T0] print_fmt: "move_lacks_source:%s, migrate object %p [size %zu] from %s to %s device_id:%s", REC->move_lacks_source ? "yes" : "no", REC->bo, REC->size, xe_mem_type_to_name[REC->old_placement], xe_mem_type_to_name[REC->new_placement], __get_str(device_id)


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20241224/202412242355.7e1a8e45-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

