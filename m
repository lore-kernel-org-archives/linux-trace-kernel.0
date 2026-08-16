Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07A63CAA3B;
	Sun, 16 Aug 2026 05:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786859543; cv=fail; b=FTpxZLVHYv4XLLqmz8oAo0LyzyflbK4XIaDHrtsml8j4/JADF6zgK9Wy8x/hwKygxuwtzNgdfzm9iSSmy2IpExkgX418rOsyPmwPtVdbDKN7akkiZyqsaLkr9krb3sxV1GbkInnKG3jih1yKPUaj7ZLkBE48dDI0QDIXzf2pTZw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786859543; c=relaxed/simple;
	bh=xcifa5bkrdr2IfX5TXMzxLEVLQpK1nmioZwrFlPaUh0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uZ2oD9Yb2v4jPSbl4axHQSxomrMxBNYVXxy/AFmqXxVk/9Kq0byrRWReNqIoUjz1FyZAJeDJHyzdmaUgJv4ponCWIaMEzTP7AsMslmZTHFXz24XAlwYQx8pa+TYol4NFpJFMWsQjYdxoXFa2FkEpofyYHVulbYFXqAjNSAegSyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cACYWjQ2; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cACYWjQ2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786859542; x=1818395542;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=xcifa5bkrdr2IfX5TXMzxLEVLQpK1nmioZwrFlPaUh0=;
  b=cACYWjQ27P7vD6qeSZk/v4putf5qVOp/vKntW9byYMPK1vldhvxvOpwy
   bLe38r9BLeEffrh6S1GFXAcOo4Zo7vungTrTVUmFUp1jam2WDabXpmRKg
   3gwCR+PC5HqN4i2hFSXcrsWYWt7KrlLE4gEqh+tRzNd3vsHyqnH3rQJvG
   8mUYaG9BFG4xqcyiT2Nm3g2c/65k5YF0+IvgHCWSnINmn047QRlX2u5Xp
   AyXEFbphZnFQlNiAAsdMkD9BMoqQpb6oI9TEZ4pmZEZLhX49ACc9R/+cw
   KKx4NpmWAXayeGT6FY4pRDs0QQ9SsF0EFZIFeyFzDhh94WQwGtq+rNXn/
   A==;
X-CSE-ConnectionGUID: tLHCaRoXQPuuRMkeX/9+NQ==
X-CSE-MsgGUID: UWxYrMFdR5yjXFlWK+h1iQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11876"; a="87392380"
X-IronPort-AV: E=Sophos;i="6.25,226,1779174000"; 
   d="scan'208";a="87392380"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2026 22:52:21 -0700
X-CSE-ConnectionGUID: 6NiEn0oqRm+LC/E77SyRmw==
X-CSE-MsgGUID: 3JdNhs7hTMOU23/LJTSKXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,226,1779174000"; 
   d="scan'208";a="260825548"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2026 22:52:21 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Sat, 15 Aug 2026 22:52:20 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Sat, 15 Aug 2026 22:52:20 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.17) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Sat, 15 Aug 2026 22:52:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eYvHCmBfz6fFa/3ChyxB/VtxQdcR11V1/nxhB7i+5omhYFYs2dfhTxaCiTEwWqOt9LNcb+nImgMgeSnNG6TLr76thozfIonmXWbq2jh31B6uOsgTzrbqTca2ympRgWKfqmFmgtOZPfLaf4UrZ+MU9tX6d8G9fI8RZXgPLAWh95GDLa2g5vCJcTmE8zj9XnXgzdfhJbp7oPo/upOjhX9DWtEEXJq3kgxg6YFSqMqIY5awhfd72EA8UCqCqlCcQhDIBb606FRL0MbdEq2X+MXVmDH7EhqKf2T+JuDxzdgk89h3Bh0k/0ynNZcNlH5Wie02QUxzb8upbAOswcyxvRhEVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iXLym6+lq42oH1xDs9h0LM7tLNGIDi9nYfTQEQHp5Uk=;
 b=BHDjzymTdU9DoFuNSOJrQyGGh3fZxJoefyJsE33YnPL884feQ+Novuv+X+Wv/8rP3DkD9STOyywhdNffzdAzoX+uwEmUF332f97FddKvYvsoI1XZnqrVpSk6kt8qaHm3TNBVA6RqRhVxCvB9mOaOuBWz1oZNX6RFX8JAvj0NEuxPHlnsLFULbAZbKC67aTkXFik6eUKlY+ZQiierIx54fz3ZZKfH4TFXDO6hj0NRkOlvMfE40uDC0NUKTlmXec5ZYwHV909CPvv2LyGMwo3sLNcxMqClpHZgFupdQ0E/N9AG58tmIdHx2SQc2yiPYwfPBeTUv0KrZPIOd5Bu+Tkk7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5214.namprd11.prod.outlook.com (2603:10b6:a03:2df::22)
 by PH7PR11MB7550.namprd11.prod.outlook.com (2603:10b6:510:27d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Sun, 16 Aug
 2026 05:52:12 +0000
Received: from SJ0PR11MB5214.namprd11.prod.outlook.com
 ([fe80::5926:3836:4212:8640]) by SJ0PR11MB5214.namprd11.prod.outlook.com
 ([fe80::5926:3836:4212:8640%4]) with mapi id 15.21.0315.016; Sun, 16 Aug 2026
 05:52:12 +0000
Date: Sun, 16 Aug 2026 13:52:04 +0800
From: Philip Li <philip.li@intel.com>
To: Steven Rostedt <rostedt@goodmis.org>
CC: kernel test robot <lkp@intel.com>, LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
	<oe-kbuild-all@lists.linux.dev>, Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Markus Elfring
	<Markus.Elfring@web.de>
Subject: Re: [PATCH] tracing: Cleanup event_enable_trigger_parse() by using
 __free()
Message-ID: <aoFQBBDw9KKp9Esg@rli9-mobl>
References: <20260701174829.67ab8a33@gandalf.local.home>
 <202608050839.Ip5dU0Jz-lkp@intel.com>
 <20260806131314.771bfaea@gandalf.local.home>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260806131314.771bfaea@gandalf.local.home>
X-ClientProxiedBy: SI2PR02CA0036.apcprd02.prod.outlook.com
 (2603:1096:4:195::15) To SJ0PR11MB5214.namprd11.prod.outlook.com
 (2603:10b6:a03:2df::22)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5214:EE_|PH7PR11MB7550:EE_
X-MS-Office365-Filtering-Correlation-Id: 655868b2-a080-4252-fa7e-08defb5a8451
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|6133799003|10067099003|4143699003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: O3St7dX2FDFjLfxKAcfvVRylHfJVbfuTbpXg4R0xFezs0p0wlsrqUgKPPIuahAMOtPGuTZ++y/edcdvhkaGNOktXIbv9lhGFlyzrXEbOdbAdGTcl4w7racdbP21gMilrT/UvNco9wRKsm46yJIHqS87JIodjOFlTieV3ywxbWiUQSw8qGjrjCZuOemsxKnLAxRg4bGevQpbyvoKH2nFGgp3fHdU8APCbeEiJwcAdzqk+SV/jMAwYNDixTY4Z/PKFTGSMtbc3AzOU0P6TsGEliHGgTcIFoLwY2sAa4BQDjhh+3vMSPpmXjURybDsyelq9vgtZwNwGIMzUDET27wR0e4Yln1znAjV782b7UulceG+uXs0IUb/sDwertpvbWM2k8DnZKdnO8NQLCiXYFPCaLiyvPLX7JyLL4NTJAe5iH5vggGRVorO4Z+FDQKibmWiNOiC5WFzodKli1krsqjNscsFRNNM+bq+rXI8G+BKtEA/+sQJxD8wC+jzgq0GWJPWOyRvl0U5nDPth3ChXQRBg3qdhlSCsmTW/mYe5Y5ABRS8sDd32UN0QhloezEU6XBTZa91gkFcvTo8ve19ERU0U/Oi8X+w7Rp36I9BMFRPAlTgJAVkLHCrkSrWdWf7kjBL2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5214.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(6133799003)(10067099003)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?MLoxqfVeyzeoh6x03PKNy32PHzMVMKej6EOrcn5BDQh0BFgMjEh1fSFxg+?=
 =?iso-8859-1?Q?nde7rF43l63dPwetsgNr2ATP6aF80nSRLJfGitPpCoRIAjPTUI+YIS4Qfo?=
 =?iso-8859-1?Q?EUsyTpfXAZCDU/U8XA6WTG9q1TcmFRvWVaf/9uwGYe4jwEzk84BUfmfkK7?=
 =?iso-8859-1?Q?R8YA2OTu3B4XDYd4K/OVjMTZMbrPz0P4zA7m5bea8PY9GgAD//puszgqj6?=
 =?iso-8859-1?Q?W6TfQFOR52mJ2o2bRKHsmkRDmxRBQhy8hFAbDcjZRSlmIKYJl/7YLhaL6R?=
 =?iso-8859-1?Q?gYZSWqq4eYpbl/vigVzW3qP8H+Yy9MsL1xVZfh0F0fJDSa6GGx12v50+Cr?=
 =?iso-8859-1?Q?yYnw/dwWp8U3xCCCORkQMkugwwGl9ueIW9YTU0tBzDThSeC4EbCt9NOfyi?=
 =?iso-8859-1?Q?ggeWlK2OIU6u333ug8mbrF/gE5n8D4AwJ8iifgnB23qznPay0rb4SgY8V5?=
 =?iso-8859-1?Q?A6NsDO7Tg7L4I3l11dbDYU1tDuLNj2wK5b5XKSqWivGomwlcWgT2KX6SP9?=
 =?iso-8859-1?Q?D3k9WyJLPBrRi3niBTbFvQEKIevru6WS++OPjGgAOdnUnH3tqK5HWmuNcz?=
 =?iso-8859-1?Q?84JflhQ5XWQ1LscVFvbmQ9jGMxxnolArMNRXL1TQTmWtkG1QslxlRK6oGI?=
 =?iso-8859-1?Q?689a9gnMVSrj2pQrr2216lOwKF/pvlJSUd0Fk4ChEi3H/ew7Lya3yg5KQm?=
 =?iso-8859-1?Q?B2sVE5uqUUc6I3Fo+aj1DmdY8xXGeuEZtub1HBkWLu0Dc2/L7KWeQKY5/c?=
 =?iso-8859-1?Q?zmYUBbmcs8rg42TndYeCDyZYT61MHTWSx/0exwhXZdc2vl+kNavnJ0wFXP?=
 =?iso-8859-1?Q?19G0AM7f/Jl2CdiZPf9CYdQMoGxExcY9UGOADjv3eJks7VLzoZiFIfQ8Kx?=
 =?iso-8859-1?Q?On+pD6U5pPQBZ+lug7xHYSxL81Z9eobiST0Y+InNJKw0KS4w81I4olSpX5?=
 =?iso-8859-1?Q?kyrZr0N+ah0n7aBOoHQNpKPM47Crk6r+96NgE8uegBrBfptmvVc0NXZEHr?=
 =?iso-8859-1?Q?Bv3Coj3XMvq8LtZN7PaysS4sC2oY6NHRUIDOrd3U/o/wKDJnGidvA7AM9v?=
 =?iso-8859-1?Q?uOPIwreENv/x9B9CYE5wI/fVYs8BNjOTvOVljVoUjNXn8z9FokbWk1PKKx?=
 =?iso-8859-1?Q?9y50Sru3b4TGyhTmw6IHDX4HE7200EMR+mCPT1r2/UeJG44uONGBQdDIAo?=
 =?iso-8859-1?Q?qa/RBBjBrhpTxZSLWNKFj9ZjV/zL+vqe9X7CcWiMggb8ga5uEqkxV3eq5z?=
 =?iso-8859-1?Q?Ajg9GcjdnJkiaVRCO9tIlGDmSilkxrzgg3/0jnX4PdkSYcL2TTLR/vFywE?=
 =?iso-8859-1?Q?fyNnqgF1lX7+EwkT2BV9LJy7vFnQj4+dri5aKoE2G03sx49Acr+Hd+pUVe?=
 =?iso-8859-1?Q?jmgI2V3ztz7pfyRxyMnthv+tz2d5Pjwxm+jy/8Tv599NjAU/FhWWGlx3b+?=
 =?iso-8859-1?Q?ydY2MOqLK3gpXO04bSn6JxBaG9PaetAkY6IFza9oPFga1S6QSBO4K/aLNa?=
 =?iso-8859-1?Q?2YIMPeUil/DqMG4sSNh+pAiIIoiryutXo8fuezbhpAcAho8gy4ylv6vU19?=
 =?iso-8859-1?Q?AZWN89PEITK3/7DW7jk+aPPEVGL64CXWPOVvRDRBDxLnENoM0pw5rOZUdd?=
 =?iso-8859-1?Q?ySCOciJOQrX2ZEithuKmpIePxvdorYM0OYeuOVX43SLZHQ20Y/+vYis0hK?=
 =?iso-8859-1?Q?SPi7yNBa3d+EiKqWKKnZ0ZWplF86S7cxU/bhrfpCnzt36ZGMO8qc6FlNxo?=
 =?iso-8859-1?Q?QdU04+0u2FWKTyrVRrl82jIBsZgYYRDAKhEjeAZIL7SZsRpdb5zvVnY1F2?=
 =?iso-8859-1?Q?0mEXckUZUg=3D=3D?=
X-Exchange-RoutingPolicyChecked: ouZMFso1eYur/VO64ZzcqT1vzuFYstsZaWt7Q6oG9XNzvFhCK9/8iS57OmIMOqQsUqAo1JP4ouApPe6ACnLMVURiw71wnkXx75J3VXNlFkPEvnmA0qglThyygO0rgWmNVoicDnB5deCJbMZfiLMAy+nN0dzKQ8SEDkZ9DOZ6BATgkeYE/YUyivyukufwvlPgfRWT71Tlv20dPs3cqbmqf0RLjR8c82we4Lc/VMWt287TnMiqwKGx85dIHGs8TuW2Of8SaiBNPqX/Lk2K22rNXTkTJIsY+L0cemw2cgKtSRZFiIRwSjgQYfewQH+YxMtjPS18N3oF7si3ltHq6nbBOg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 655868b2-a080-4252-fa7e-08defb5a8451
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5214.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2026 05:52:12.1249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hN73oowqOsHFlObyvW55b3lPsscvVbX3tsb9e4Fk/U4IiJfI+UrVgWfctBG5UgGXocclV+pEqwz8FHq4ciuu0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7550
X-OriginatorOrg: intel.com

On Thu, Aug 06, 2026 at 01:13:14PM -0400, Steven Rostedt wrote:
> 
> Does the kernel test robot just keep on testing old versions of a patch?

Hi Steve, sorry about this meaningless report, we will improve the bot to check
new patches to avoid sending such report.

> Sashiko discovered this issue and I made a v2 with a fix a week ago:
> 
>   https://lore.kernel.org/all/20260727155459.202af38d@gandalf.local.home/
> 
> -- Steve
> 
> 
> On Wed, 5 Aug 2026 08:21:33 +0200
> kernel test robot <lkp@intel.com> wrote:
> 
> > Hi Steven,
> > 
> > kernel test robot noticed the following build warnings:
> > 
> > [auto build test WARNING on trace/for-next]
> > [also build test WARNING on linus/master v7.2-rc6 next-20260804]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> > 
> > url:    https://github.com/intel-lab-lkp/linux/commits/Steven-Rostedt/tracing-Cleanup-event_enable_trigger_parse-by-using-__free/20260805-073956
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace for-next
> > patch link:    https://lore.kernel.org/r/20260701174829.67ab8a33%40gandalf.local.home
> > patch subject: [PATCH] tracing: Cleanup event_enable_trigger_parse() by using __free()
> > config: s390-allnoconfig-bpf (https://download.01.org/0day-ci/archive/20260805/202608050839.Ip5dU0Jz-lkp@intel.com/config)
> > compiler: s390x-linux-gnu-gcc (Debian 14.2.0-19) 14.2.0
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260805/202608050839.Ip5dU0Jz-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202608050839.Ip5dU0Jz-lkp@intel.com/
> > 
> > All warnings (new ones prefixed by >>):
> > 
> >    In file included from ./include/linux/file.h:13,
> >                     from ./include/linux/kernel_read_file.h:5,
> >                     from ./include/linux/security.h:26,
> >                     from kernel/trace/trace_events_trigger.c:8:
> >    kernel/trace/trace_events_trigger.c: In function 'event_enable_trigger_parse':
> > >> ./include/linux/cleanup.h:228:22: warning: ignoring return value of '__must_check_fn' declared with attribute 'warn_unused_result' [-Wunused-result]  
> >      228 |         ((typeof(p)) __must_check_fn((__force const volatile void *)__get_and_null(p, NULL)))
> >          |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >    kernel/trace/trace_events_trigger.c:1842:9: note: in expansion of macro 'no_free_ptr'
> >     1842 |         no_free_ptr(enable_data);
> >          |         ^~~~~~~~~~~
> > 
> > 
> > vim +228 ./include/linux/cleanup.h
> > 
> > 85be6d84244706 Peter Zijlstra 2023-08-15  226  
> > 54da6a0924311c Peter Zijlstra 2023-05-26  227  #define no_free_ptr(p) \
> > 366fef794bd2b7 Ilpo Järvinen  2025-03-10 @228  	((typeof(p)) __must_check_fn((__force const volatile void *)__get_and_null(p, NULL)))
> > 54da6a0924311c Peter Zijlstra 2023-05-26  229  
> > 
> > --
> > 0-DAY CI Kernel Test Service
> > https://github.com/intel/lkp-tests/wiki
> 
> 
