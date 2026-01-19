Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C4B3002BA;
	Mon, 19 Jan 2026 07:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768807826; cv=fail; b=DmOhXxW+7+LnU25SZJitXCtnfiwr2OJvwPMWSrzAfBzCQv7Mg1Kh2AZWGAmpSLYiYrkHAwfd4GhAaLN5zBe1S8c+jBhl1HvbuCpMn7vaYmPuktAP+sj68Wh/5TWTlKKeHdv4bDSAyVQmANJtSiRJHwVpnEt6jiecr/yxWLNu+4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768807826; c=relaxed/simple;
	bh=OZGwg0Kr/B7idZIiZ8bduN5o8XCcXlvut0nDLGC/29A=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EBQ3aaMYxfDzKcP8MUlsQ2E6ViXvOYrC0F0+SbuyrGOqMWcngE2sU/2UkkUcDw7HwWNHUBSElemJCUkWCSHo9lbiPzRVgbKz8aoTL3AS3yE82rwAkAKmgspIeGYuQ1UQJuWyePvznrH5gD2OQD4yLItQjXQBGDsMdPg7UFzXuPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NbMm0+ZT; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NbMm0+ZT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768807820; x=1800343820;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=OZGwg0Kr/B7idZIiZ8bduN5o8XCcXlvut0nDLGC/29A=;
  b=NbMm0+ZTE4OV/g/AU46YvgZA5rTkgkpXfQmjBNj6gdvzby5wDY0m8Nw4
   drvNm2/EVHchAMcsIBs2/fOi5NtT8nbsshTHjdby6LzppzhXGegNLBBoS
   TO6fnKtUIVTMeMJZJlxMf5Rssq8AkrgS3Elka0eUKdOU52gC9oIMkND18
   mCtfC2XKTLXGbU6lYmMLFD8DecvwsEM4y/Rsvfvb46yJd/lnTIpHB9HGR
   FqoVn/HrJymcWo1FtkN8KzCMSI9I3R7V9bN0gGqVJoG5aKFkYfUhPmuLG
   p9uw4NwjB7adt6R+3Axy0t1x03asosGVgavkH2cpLr4OvFoQLYn+O2nSe
   g==;
X-CSE-ConnectionGUID: QkSXCy6QRPO9yLhpmR7Vdg==
X-CSE-MsgGUID: iWlXH4LzR3GaP61GvjRuKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11675"; a="87429502"
X-IronPort-AV: E=Sophos;i="6.21,237,1763452800"; 
   d="scan'208";a="87429502"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2026 23:30:18 -0800
X-CSE-ConnectionGUID: r5Qa3YdmT/Cju5UO3VQ1lA==
X-CSE-MsgGUID: p1JGIiUfQWmexsN30uxbIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,237,1763452800"; 
   d="scan'208";a="206153582"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2026 23:30:17 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Sun, 18 Jan 2026 23:30:16 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Sun, 18 Jan 2026 23:30:16 -0800
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.12) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Sun, 18 Jan 2026 23:30:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jfjf5yeUReqB36zUcrsvY+tpcCl61DsERKGVeouAecDMan4EVSC5qW6ftlFx5T/GCFlBvVhoiRLd7leEFhJyXmF//4NfBgdnDxUmBIIdVyOf7+j0SklgV1cK4m4Ko7/3oLBeT5zDtiJjY2qqERxHrGUcHrlv16iP45/olnh9Tcz7f1IRNvdIL05M9cvD7EibkJOXGi5xPaW4W4HnEWoSQ4HzsrR8awnEqSt1LQdMZ8DYO6jwL5iSvXFUlpA2dj1vMfxiEm1/K8kJozrQOsjm79cx9MbWhGGfuPw1TDgVScovkfytyEUy7aJVTvc/8FGo5CMULu/9CChG7o1kGn0+XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MegOCeHG2B7fQy3JOBH1jx7iyQyuS9Tvtr5reMLCatk=;
 b=Tk1Slf+90zsSv3HEzEUMGIfVXI+9tIDGWsKqmpdf7ainwDLJED7MMddBS8AQJsTbV9cfv+snOrlLranmiqCe6YYPXGBEj+fBjJKRO6tcTqNzKlDZZyPyo85k5SjatfLHyoQgD0cK2Hgu5H4rHHpE0FDBoBId5CZEK1xnYjkNW9eRCcxzQRuUXZQGVq3aSc2/zeVF445JHiEN97SzRUm8BovNW8bLejFJyOHolVxBfe+XG+CcHYSU2rEPVfkAY5hex5qx6XyTPJusoHdm4XUG2xNrGEYVkxJsHCmq2kCBwbm71hfojXQtf8WE2bdyrb6uQvxXK5WzKFl4hvMnnv3rGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DM4PR11MB6480.namprd11.prod.outlook.com (2603:10b6:8:8d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.10; Mon, 19 Jan
 2026 07:30:08 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9520.009; Mon, 19 Jan 2026
 07:30:08 +0000
Date: Mon, 19 Jan 2026 15:29:58 +0800
From: kernel test robot <oliver.sang@intel.com>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Steven Rostedt
	<rostedt@goodmis.org>, <linux-kernel@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, Naveen N Rao <naveen@kernel.org>,
	"David S . Miller" <davem@davemloft.net>, Masami Hiramatsu
	<mhiramat@kernel.org>, <oliver.sang@intel.com>
Subject: Re: [PATCH v2] kprobes: Use dedicated kthread for kprobe optimizer
Message-ID: <202601191507.74fccd0c-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <176826884613.429923.16578111751623731056.stgit@devnote2>
X-ClientProxiedBy: SI2PR01CA0029.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::8) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DM4PR11MB6480:EE_
X-MS-Office365-Filtering-Correlation-Id: c0d6f11c-cd61-4b6c-efb2-08de572c9278
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dYoajYlWZ7SUQkQAE3QS7EyiH/MmS+Ipbonw5TphO3rUcphschcnp0HUX9s+?=
 =?us-ascii?Q?BPkkmc41kdlslR2/g2q8bx3ukXNqPQVWOz8Wtzfk9B4bCiYtpPVdhUL3ubXu?=
 =?us-ascii?Q?9v5VjgNFCCuww2guY80TyOBg/sRCEUcBGfi1VNRSTZ2ys5ieTCpgIALK2NyW?=
 =?us-ascii?Q?IAWJ1OlJC6Dk8YM3eDKs5LS40fRR63ptexhRQuatsYt2y6HtUk8hkiedga1N?=
 =?us-ascii?Q?9kwG7pbUcvtdoQpSbC/9Mkwm3ckcH1yVlAaFyJm44KcYQIb4YJQYkp4Y2vPM?=
 =?us-ascii?Q?Ai3MWeX/7kphL0osij7HMPdYcc0Ed2Vw+g2BTliRyDbU3v1yvAEUYpUZ29xf?=
 =?us-ascii?Q?aJG/VzN71JkD7QiHZ0uGVRoTQCrHpXIrju5fxbAUtYjOldFYl+nNFOkWKeF7?=
 =?us-ascii?Q?TRqBQdRQdMts75aeP5sTlgtqXq5aoU2RjkMOGgAxBnw/N07OEl3At3bk4xBi?=
 =?us-ascii?Q?gZEKfsv7sdfNwZ8VzFEj50/3IgboBFWodj1OydEMXUplJ56GPhwhBkF/yKMY?=
 =?us-ascii?Q?ry4jvyVNDzd9wkE+QAqqeuGmOue0nyZjZ9euhOBIP0Q4mTyNwN/bN5xxR7g2?=
 =?us-ascii?Q?QEIip2xQGEJXBrygD94ZBLlDaiId+TePrTpBCL2mgNFUDfNyKw6g0Kx+QGzD?=
 =?us-ascii?Q?OCdKHj0svgL8HWcJ2OQUSbYdSXle76CRrpdoXhUDt3Cr2xl91CHzbLfqcdcq?=
 =?us-ascii?Q?H/q4cGs97XtNHLJYW8XYf4UxgQc8LjHYjgH2hcHTZyLGPD/IuHB9Iv4ZJHNn?=
 =?us-ascii?Q?61Vm7ocDYs7EghJjx9S6v9thwh/Ek+geyZ5JAw2mZQNhIHT2RpyC4hdFWf/j?=
 =?us-ascii?Q?AFd5+9EoJ69F4O7ETnRckG+b0GLJ9XeurDl8WWvFfe5K3N2X9iNRtsIPz9Yf?=
 =?us-ascii?Q?cD3MRVsbI9IWWHAoqyRlzo9t3hmr8uB1CDlQYdIzPzPwCjdeBznIMRCuLEI7?=
 =?us-ascii?Q?tijjrQEVYovYU0XgmF9S98JuOBN7Nfac0E2ZXqI9OzEs0c48B08lFa/HageV?=
 =?us-ascii?Q?Qw8jussfJGDcEdmbz+Lcx+iLda1WxcP+/ZFWMYZlnyA5o9JsOdNcN+F7EhNa?=
 =?us-ascii?Q?pUth7AXZv0I51NYDw6ffx4sMKlJMYQmfIHS2bQUFXYB3ToGuLA9dSjW6Ydxe?=
 =?us-ascii?Q?MRF4InCoDl6ioobVPoEWpngVWkn1lDTt6eldx4zP2QynK5OOhSTVCDZgR+gD?=
 =?us-ascii?Q?JxZrQ8/NGObCmK71J/5EH+D3YAnsCIPplUheca5IEc2Y2JYZ9x0qD7LJ0BMR?=
 =?us-ascii?Q?F5JDAssvLDaGGGdUu+imBR/XyGgXjVqzefhIo6q9Xby1/j/hJXeH/5c0DoX/?=
 =?us-ascii?Q?cpacjqgndUnr42InmcFRb6rw3EQQxNxGmdScB7e3A5VK7SWhbyuD1TNPtHSX?=
 =?us-ascii?Q?/ey51iOplSnZhe4wh4aqYtmQ3kNSgVOH54V+8iBfW+GxwhLEOT6dWXmxj3if?=
 =?us-ascii?Q?zjAMQSvp/SkRsK4pmD8wOVhCTZVdecxBBP3UVt3A47t/C5UujWuCvc1lTFU+?=
 =?us-ascii?Q?8D8OtBCgRau2+MGlfG2JPl1CnbDJ2JKf96hvSd+f0FP9pPvj7iSJxdI7n5vj?=
 =?us-ascii?Q?zwy+rJkT4qrX74oYf8sGiKSc1QQyu4ehkBXpJBUv?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NCXRL8j6ABoJkO+EMZsQXt54jH7zOGDIS0tK2jdX2XuX9xhxaEFd9laIHR9o?=
 =?us-ascii?Q?o1H4BYkGMSv/UFrx1YDnG7etb5DoeJnrM9pOTy6k7scPsNCCLf/Kvwie/3QN?=
 =?us-ascii?Q?yWT+U4gcf3F8Azv+tcjGHJEe6QwGVTDRMvcfQFd8MJa5WtEyGiINq2v802W5?=
 =?us-ascii?Q?Is0JJzPyLgPmRg43JKqZeEgCWr9kRXJM9O5MHsCLEE98HtqeXHZe6JCBbmCT?=
 =?us-ascii?Q?rE74tqAlOQGH2uWUZSWHpFPfWnVoV8gdi6LOQACMD+7z3CsZnCqjbp1+CEEP?=
 =?us-ascii?Q?UvuGnRRZobpyBUXsdGF5+UTSTKtze54SL5gLpBwPVB+0MS/cMeRQFi/ipH47?=
 =?us-ascii?Q?nReTphL9mb0WQOXF6hqzZpZArMsp4lP8fNct/0F0Io03lYgRQxlH/uYr0mA5?=
 =?us-ascii?Q?TOhOJjbsZ2VUFyrJOuw9tEfYyIVrAcl4iK2FksT/dpoJA/pI0Lkk4KBy7Uyk?=
 =?us-ascii?Q?X5uHkK7dCFHTSHn5JRz3emjLbBQ4//+D87y10aJArJyF71PhKk+V4wxP5FIC?=
 =?us-ascii?Q?fh1ncIJSg3gpDI8AA6MGvNOsT90ssJCuHcaz5+CJFpDOS5BnWdvYgT5KU8H5?=
 =?us-ascii?Q?Q0l+TrbVMOa4UfU49tBivHbaNWk+RyFl0oYikpqleY/4dBO07mk4Dd9LsmmV?=
 =?us-ascii?Q?wz8gTNQJqCLySxIZeKbCKPRHyju/n/kjIhHJVmwkquT7oejwmIGCoqEYEkIB?=
 =?us-ascii?Q?0CMHaOGGXs7bTvhpcLWXIYBZNmDHhjEEI0Fy/McSJRlc2LTZSuL196pp5yH1?=
 =?us-ascii?Q?oBjCUQWAkxnPXiNhRhYPPXy+8z3My5PolwCJlqedA8kSt+fb1yW+tpym2Xxg?=
 =?us-ascii?Q?F/yXF0f2PC3y+wSEwQAjhvKkgd1PI/thPR3HfnGI50MOLR3rvR6LAp/nqHwo?=
 =?us-ascii?Q?9yDNdLg05HcjqN/uIM0KioLpAV+i58D2LoEe3YVDa4y1C706u4zbcEW6GFTz?=
 =?us-ascii?Q?N2gELVm8gR3Z/b6mpJM2SYexn4nBGTeUbEkkNqujnYDUAOq8U8erTHwj05oE?=
 =?us-ascii?Q?D+BeZS4ERmObOa7yErtONj6ZPRAdZeZVJad+1eesgFC93aPsD0Tn0VEO7YgG?=
 =?us-ascii?Q?NAASRd0yvC0Npv6YuD+HRcWnxEYGoH3k1KpyHNWqRm3VmjYHaxFcYq3+U9rM?=
 =?us-ascii?Q?1K8oOlGNcYEwf5o2Nm121niaAHpR48ZnAuv6+T5NwW0yVUamYuSTwWtr5kZ3?=
 =?us-ascii?Q?/D7wdaRYSxT1sJwK17K8EW9Z37e5SFLqZuGR2bf73UgOLQTnLma8kvkL9NP6?=
 =?us-ascii?Q?l6GRzKcLZBERUCmlw7mctzQRpReeLCOsAKpV/yiULT1n2MHVk6zp//SAb/bB?=
 =?us-ascii?Q?wSZv/RDgSaRI2YeDowHx/G9vTuA8uTzXLwfo1nCAGMO7W7q/62JJ2+PQdaen?=
 =?us-ascii?Q?sdvRdq2RoW7sXAtrNmsvpvHULeaiQ1YCMDPL5mf17870QVxwJALD28ZXYKCJ?=
 =?us-ascii?Q?qJJ++I7pszviWsV83GQFo1D09jzOVad59y8OTrk0lgyuOXFzEpt8sbFwg4Mp?=
 =?us-ascii?Q?PrHWMj9905T4IMmAq3F2xNhvetPbOPXsPf2ILMiflz/eJApfhySa/U9FZNUy?=
 =?us-ascii?Q?zE5XxfHcgYQO14MWz237UJCJMsRR0BETMGGzdfyIug2EbZ5zIABoxWWae73T?=
 =?us-ascii?Q?gUVqGvmDZ9lumZ56omxXJpjlETSCZjTU91CLWft0sPPR5CY/bXMEZNCI2sB1?=
 =?us-ascii?Q?YeRE9QNQaym8IH+XsHTXHK1MqTqYMNBLBXuWilcx1Ep2v28nZISWW7qzx+3x?=
 =?us-ascii?Q?2bLCBAOJEA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c0d6f11c-cd61-4b6c-efb2-08de572c9278
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 07:30:08.2868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XgMtYgyoP4mfe+XeL/38S/2HmmvDAgpqIYJrkxfo8+1hqKzUypI9dGOdaIABALrlMz96eMD9/wfsL3GiGIJGTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6480
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "INFO:task_blocked_for_more_than#seconds" on:

commit: 62f65c2531ad66e84c1a5ef91389322357ef6db4 ("[PATCH v2] kprobes: Use dedicated kthread for kprobe optimizer")
url: https://github.com/intel-lab-lkp/linux/commits/Masami-Hiramatsu-Google/kprobes-Use-dedicated-kthread-for-kprobe-optimizer/20260113-094928
base: https://git.kernel.org/cgit/linux/kernel/git/trace/linux-trace for-next
patch link: https://lore.kernel.org/all/176826884613.429923.16578111751623731056.stgit@devnote2/
patch subject: [PATCH v2] kprobes: Use dedicated kthread for kprobe optimizer

in testcase: trinity
version: trinity-x86_64-294c4652-1_20251011
with following parameters:

	runtime: 300s
	group: group-03
	nr_groups: 5



config: x86_64-kexec
compiler: clang-20
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 32G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+-----------------------------------------+------------+------------+
|                                         | 78a419b44e | 62f65c2531 |
+-----------------------------------------+------------+------------+
| INFO:task_blocked_for_more_than#seconds | 0          | 6          |
+-----------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202601191507.74fccd0c-lkp@intel.com



[  972.359932][   T32] INFO: task kprobe-optimize:18 blocked for more than 491 seconds.
[  972.361221][   T32]       Not tainted 6.19.0-rc5-00040-g62f65c2531ad #1
[  972.362516][   T32] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  972.364322][   T32] task:kprobe-optimize state:D stack:0     pid:18    tgid:18    ppid:2      task_flags:0x208040 flags:0x00080000
[  972.366628][   T32] Call Trace:
[  972.367378][   T32]  <TASK>
[  972.368066][   T32]  __schedule (kernel/sched/core.c:5259)
[  972.370837][   T32]  schedule (arch/x86/include/asm/preempt.h:85 kernel/sched/core.c:6946 kernel/sched/core.c:6960)
[  972.371679][   T32]  kprobe_optimizer_thread (kernel/kprobes.c:656)
[  972.373219][   T32]  ? __pfx_autoremove_wake_function (kernel/sched/wait.c:402)
[  972.374017][   T32]  kthread (kernel/kthread.c:465)
[  972.374573][   T32]  ? __pfx_kprobe_optimizer_thread (kernel/kprobes.c:654)
[  972.375364][   T32]  ? __pfx_kthread (kernel/kthread.c:412)
[  972.376005][   T32]  ret_from_fork (arch/x86/kernel/process.c:164)
[  972.376679][   T32]  ? __pfx_kthread (kernel/kthread.c:412)
[  972.377305][   T32]  ret_from_fork_asm (arch/x86/entry/entry_64.S:256)
[  972.377958][   T32]  </TASK>
[ 1463.879952][   T32] INFO: task kprobe-optimize:18 blocked for more than 983 seconds.
[ 1463.882239][   T32]       Not tainted 6.19.0-rc5-00040-g62f65c2531ad #1
[ 1463.884371][   T32] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 1463.887443][   T32] task:kprobe-optimize state:D stack:0     pid:18    tgid:18    ppid:2      task_flags:0x208040 flags:0x00080000
[ 1463.891867][   T32] Call Trace:
[ 1463.893396][   T32]  <TASK>
[ 1463.894468][   T32]  __schedule (kernel/sched/core.c:5259)
[ 1463.903984][   T32]  schedule (arch/x86/include/asm/preempt.h:85 kernel/sched/core.c:6946 kernel/sched/core.c:6960)
[ 1463.904926][   T32]  kprobe_optimizer_thread (kernel/kprobes.c:656)
[ 1463.905949][   T32]  ? __pfx_autoremove_wake_function (kernel/sched/wait.c:402)
[ 1463.907111][   T32]  kthread (kernel/kthread.c:465)
[ 1463.907954][   T32]  ? __pfx_kprobe_optimizer_thread (kernel/kprobes.c:654)
[ 1463.909157][   T32]  ? __pfx_kthread (kernel/kthread.c:412)
[ 1463.910045][   T32]  ret_from_fork (arch/x86/kernel/process.c:164)
[ 1463.910939][   T32]  ? __pfx_kthread (kernel/kthread.c:412)
[ 1463.911933][   T32]  ret_from_fork_asm (arch/x86/entry/entry_64.S:256)
[ 1463.912947][   T32]  </TASK>
[ 1955.399991][   T32] INFO: task kprobe-optimize:18 blocked for more than 1474 seconds.
[ 1955.404266][   T32]       Not tainted 6.19.0-rc5-00040-g62f65c2531ad #1
[ 1955.407452][   T32] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 1955.414557][   T32] task:kprobe-optimize state:D stack:0     pid:18    tgid:18    ppid:2      task_flags:0x208040 flags:0x00080000
[ 1955.416961][   T32] Call Trace:
[ 1955.417705][   T32]  <TASK>
[ 1955.418382][   T32]  __schedule (kernel/sched/core.c:5259)
[ 1955.419274][   T32]  schedule (arch/x86/include/asm/preempt.h:85 kernel/sched/core.c:6946 kernel/sched/core.c:6960)
[ 1955.419929][   T32]  kprobe_optimizer_thread (kernel/kprobes.c:656)
[ 1955.421071][   T32]  ? __pfx_autoremove_wake_function (kernel/sched/wait.c:402)
[ 1955.422303][   T32]  kthread (kernel/kthread.c:465)
[ 1955.423217][   T32]  ? __pfx_kprobe_optimizer_thread (kernel/kprobes.c:654)
[ 1955.424452][   T32]  ? __pfx_kthread (kernel/kthread.c:412)
[ 1955.425189][   T32]  ret_from_fork (arch/x86/kernel/process.c:164)
[ 1955.425913][   T32]  ? __pfx_kthread (kernel/kthread.c:412)
[ 1955.426645][   T32]  ret_from_fork_asm (arch/x86/entry/entry_64.S:256)
[ 1955.427357][   T32]  </TASK>
[ 2446.919964][   T32] INFO: task kprobe-optimize:18 blocked for more than 1966 seconds.
[ 2446.922105][   T32]       Not tainted 6.19.0-rc5-00040-g62f65c2531ad #1
[ 2446.925697][   T32] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 2446.926569][   T32] task:kprobe-optimize state:D stack:0     pid:18    tgid:18    ppid:2      task_flags:0x208040 flags:0x00080000
[ 2446.927775][   T32] Call Trace:
[ 2446.928242][   T32]  <TASK>
[ 2446.928609][   T32]  __schedule (kernel/sched/core.c:5259)
[ 2446.929827][   T32]  schedule (arch/x86/include/asm/preempt.h:85 kernel/sched/core.c:6946 kernel/sched/core.c:6960)
[ 2446.930256][   T32]  kprobe_optimizer_thread (kernel/kprobes.c:656)
[ 2446.930789][   T32]  ? __pfx_autoremove_wake_function (kernel/sched/wait.c:402)
[ 2446.931434][   T32]  kthread (kernel/kthread.c:465)
[ 2446.931926][   T32]  ? __pfx_kprobe_optimizer_thread (kernel/kprobes.c:654)
[ 2446.932624][   T32]  ? __pfx_kthread (kernel/kthread.c:412)
[ 2446.933079][   T32]  ret_from_fork (arch/x86/kernel/process.c:164)
[ 2446.933534][   T32]  ? __pfx_kthread (kernel/kthread.c:412)
[ 2446.933983][   T32]  ret_from_fork_asm (arch/x86/entry/entry_64.S:256)
[ 2446.934450][   T32]  </TASK>
[ 2938.439916][   T32] INFO: task kprobe-optimize:18 blocked for more than 2457 seconds.
[ 2938.441278][   T32]       Not tainted 6.19.0-rc5-00040-g62f65c2531ad #1
[ 2938.442281][   T32] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 2938.444599][   T32] task:kprobe-optimize state:D stack:0     pid:18    tgid:18    ppid:2      task_flags:0x208040 flags:0x00080000
[ 2938.446316][   T32] Call Trace:
[ 2938.446892][   T32]  <TASK>
[ 2938.447449][   T32]  __schedule (kernel/sched/core.c:5259)
[ 2938.449286][   T32]  schedule (arch/x86/include/asm/preempt.h:85 kernel/sched/core.c:6946 kernel/sched/core.c:6960)
[ 2938.450230][   T32]  kprobe_optimizer_thread (kernel/kprobes.c:656)
[ 2938.451347][   T32]  ? __pfx_autoremove_wake_function (kernel/sched/wait.c:402)
[ 2938.452611][   T32]  kthread (kernel/kthread.c:465)
[ 2938.453462][   T32]  ? __pfx_kprobe_optimizer_thread (kernel/kprobes.c:654)
[ 2938.454622][   T32]  ? __pfx_kthread (kernel/kthread.c:412)
[ 2938.455583][   T32]  ret_from_fork (arch/x86/kernel/process.c:164)
[ 2938.456604][   T32]  ? __pfx_kthread (kernel/kthread.c:412)
[ 2938.457614][   T32]  ret_from_fork_asm (arch/x86/entry/entry_64.S:256)
[ 2938.458645][   T32]  </TASK>
[ 3429.960057][   T32] INFO: task kprobe-optimize:18 blocked for more than 2949 seconds.
[ 3429.962853][   T32]       Not tainted 6.19.0-rc5-00040-g62f65c2531ad #1
[ 3429.965133][   T32] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 3429.967986][   T32] task:kprobe-optimize state:D stack:0     pid:18    tgid:18    ppid:2      task_flags:0x208040 flags:0x00080000
[ 3429.971731][   T32] Call Trace:
[ 3429.973021][   T32]  <TASK>
[ 3429.974169][   T32]  __schedule (kernel/sched/core.c:5259)
[ 3429.975713][   T32]  schedule (arch/x86/include/asm/preempt.h:85 kernel/sched/core.c:6946 kernel/sched/core.c:6960)
[ 3429.977206][   T32]  kprobe_optimizer_thread (kernel/kprobes.c:656)
[ 3429.978375][   T32]  ? __pfx_autoremove_wake_function (kernel/sched/wait.c:402)
[ 3429.979623][   T32]  kthread (kernel/kthread.c:465)
[ 3429.980602][   T32]  ? __pfx_kprobe_optimizer_thread (kernel/kprobes.c:654)
[ 3429.981810][   T32]  ? __pfx_kthread (kernel/kthread.c:412)
[ 3429.982797][   T32]  ret_from_fork (arch/x86/kernel/process.c:164)
[ 3429.983793][   T32]  ? __pfx_kthread (kernel/kthread.c:412)
[ 3429.984838][   T32]  ret_from_fork_asm (arch/x86/entry/entry_64.S:256)
[ 3429.985864][   T32]  </TASK>
[ 3921.480064][   T32] INFO: task kprobe-optimize:18 blocked for more than 3440 seconds.
[ 3921.482942][   T32]       Not tainted 6.19.0-rc5-00040-g62f65c2531ad #1
[ 3921.485260][   T32] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 3921.488269][   T32] task:kprobe-optimize state:D stack:0     pid:18    tgid:18    ppid:2      task_flags:0x208040 flags:0x00080000
[ 3921.491811][   T32] Call Trace:
[ 3921.493488][   T32]  <TASK>
[ 3921.494960][   T32]  __schedule (kernel/sched/core.c:5259)
[ 3921.508616][   T32]  schedule (arch/x86/include/asm/preempt.h:85 kernel/sched/core.c:6946 kernel/sched/core.c:6960)
[ 3921.509430][   T32]  kprobe_optimizer_thread (kernel/kprobes.c:656)
[ 3921.510413][   T32]  ? __pfx_autoremove_wake_function (kernel/sched/wait.c:402)
[ 3921.511467][   T32]  kthread (kernel/kthread.c:465)
[ 3921.512331][   T32]  ? __pfx_kprobe_optimizer_thread (kernel/kprobes.c:654)
[ 3921.513388][   T32]  ? __pfx_kthread (kernel/kthread.c:412)
[ 3921.514202][   T32]  ret_from_fork (arch/x86/kernel/process.c:164)
[ 3921.514976][   T32]  ? __pfx_kthread (kernel/kthread.c:412)
[ 3921.515773][   T32]  ret_from_fork_asm (arch/x86/entry/entry_64.S:256)
[ 3921.516817][   T32]  </TASK>
[ 4413.000017][   T32] INFO: task kprobe-optimize:18 blocked for more than 3932 seconds.
[ 4413.004653][   T32]       Not tainted 6.19.0-rc5-00040-g62f65c2531ad #1
[ 4413.007745][   T32] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 4413.010446][   T32] task:kprobe-optimize state:D stack:0     pid:18    tgid:18    ppid:2      task_flags:0x208040 flags:0x00080000
[ 4413.013906][   T32] Call Trace:
[ 4413.015027][   T32]  <TASK>
[ 4413.016134][   T32]  __schedule (kernel/sched/core.c:5259)
[ 4413.017465][   T32]  schedule (arch/x86/include/asm/preempt.h:85 kernel/sched/core.c:6946 kernel/sched/core.c:6960)
[ 4413.018294][   T32]  kprobe_optimizer_thread (kernel/kprobes.c:656)
[ 4413.019366][   T32]  ? __pfx_autoremove_wake_function (kernel/sched/wait.c:402)
[ 4413.020594][   T32]  kthread (kernel/kthread.c:465)
[ 4413.021350][   T32]  ? __pfx_kprobe_optimizer_thread (kernel/kprobes.c:654)
[ 4413.022331][   T32]  ? __pfx_kthread (kernel/kthread.c:412)
[ 4413.023124][   T32]  ret_from_fork (arch/x86/kernel/process.c:164)
[ 4413.023925][   T32]  ? __pfx_kthread (kernel/kthread.c:412)
[ 4413.025015][   T32]  ret_from_fork_asm (arch/x86/entry/entry_64.S:256)
[ 4413.026074][   T32]  </TASK>
[ 4904.520028][   T32] INFO: task kprobe-optimize:18 blocked for more than 4423 seconds.
[ 4904.521949][   T32]       Not tainted 6.19.0-rc5-00040-g62f65c2531ad #1
[ 4904.528612][   T32] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 4904.529924][   T32] task:kprobe-optimize state:D stack:0     pid:18    tgid:18    ppid:2      task_flags:0x208040 flags:0x00080000
[ 4904.531461][   T32] Call Trace:
[ 4904.531896][   T32]  <TASK>
[ 4904.532406][   T32]  __schedule (kernel/sched/core.c:5259)
[ 4904.532947][   T32]  schedule (arch/x86/include/asm/preempt.h:85 kernel/sched/core.c:6946 kernel/sched/core.c:6960)
[ 4904.533381][   T32]  kprobe_optimizer_thread (kernel/kprobes.c:656)
[ 4904.533944][   T32]  ? __pfx_autoremove_wake_function (kernel/sched/wait.c:402)
[ 4904.534547][   T32]  kthread (kernel/kthread.c:465)
[ 4904.534985][   T32]  ? __pfx_kprobe_optimizer_thread (kernel/kprobes.c:654)
[ 4904.535670][   T32]  ? __pfx_kthread (kernel/kthread.c:412)
[ 4904.536359][   T32]  ret_from_fork (arch/x86/kernel/process.c:164)
[ 4904.536831][   T32]  ? __pfx_kthread (kernel/kthread.c:412)
[ 4904.537310][   T32]  ret_from_fork_asm (arch/x86/entry/entry_64.S:256)
[ 4904.537788][   T32]  </TASK>
[ 5396.039936][   T32] INFO: task kprobe-optimize:18 blocked for more than 4915 seconds.
[ 5396.040939][   T32]       Not tainted 6.19.0-rc5-00040-g62f65c2531ad #1
[ 5396.041631][   T32] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 5396.042742][   T32] task:kprobe-optimize state:D stack:0     pid:18    tgid:18    ppid:2      task_flags:0x208040 flags:0x00080000
[ 5396.045182][   T32] Call Trace:
[ 5396.045723][   T32]  <TASK>
[ 5396.046266][   T32]  __schedule (kernel/sched/core.c:5259)
[ 5396.046928][   T32]  schedule (arch/x86/include/asm/preempt.h:85 kernel/sched/core.c:6946 kernel/sched/core.c:6960)
[ 5396.047542][   T32]  kprobe_optimizer_thread (kernel/kprobes.c:656)
[ 5396.048329][   T32]  ? __pfx_autoremove_wake_function (kernel/sched/wait.c:402)
[ 5396.049182][   T32]  kthread (kernel/kthread.c:465)
[ 5396.049803][   T32]  ? __pfx_kprobe_optimizer_thread (kernel/kprobes.c:654)
[ 5396.050654][   T32]  ? __pfx_kthread (kernel/kthread.c:412)
[ 5396.051353][   T32]  ret_from_fork (arch/x86/kernel/process.c:164)
[ 5396.052048][   T32]  ? __pfx_kthread (kernel/kthread.c:412)
[ 5396.052723][   T32]  ret_from_fork_asm (arch/x86/entry/entry_64.S:256)
[ 5396.053187][   T32]  </TASK>
[ 5396.053524][   T32] Future hung task reports are suppressed, see sysctl kernel.hung_task_warnings
BUG: kernel hang in test stage



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260119/202601191507.74fccd0c-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

