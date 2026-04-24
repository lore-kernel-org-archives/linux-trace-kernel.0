Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1707036C9E5;
	Fri, 24 Apr 2026 14:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777039547; cv=fail; b=hJ4R+9I4FVXLskIIrNO13pM2e6YQVxKGMvgSfdf377uwcpDVMDYe1nPoDmy9vkoQ6vn2aGSuQVVB3yJRhM/ZACmP7VA6O3hfofrZpOWk34oKvHoDWSIV9FhLdNxsqlPyu7KqTuHyKkCdz1gE9p6geS2OEeYRaBl2xqeiiz/uJh8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777039547; c=relaxed/simple;
	bh=M2dHbLjt0tmTzXZL/mnaurlx0mONY0sSPHfvMZ0xVwM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RVanefmOHZku15UmIUJqSA75FgBFFDojY8RBTCHfhVpeK7DAurNV34yZkZMlUFxX8QYHOsOY6K/lWUGMvin2dVF40W1nHzlK4cl+vn6omJZS17U/Zw6jeY++WPgjlr/KWCCEF5YHCTaPjNbXkLweuYjRcsg0KMXroTQrbzJ03K8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oEc52eCy; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oEc52eCy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777039546; x=1808575546;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=M2dHbLjt0tmTzXZL/mnaurlx0mONY0sSPHfvMZ0xVwM=;
  b=oEc52eCykqFj4vGKaiH2SMJx5O81B2Nzg6aJp7isi4GlimP+yTm1qPnH
   DWrmnZSl3spc+hOpnm1On9LFQ54+9APIMu3LUryYufsVWHoA0cVKtE8gB
   rY4HVoCHjka1PUAVkuYukxeMifROP9Gz6tKL/hFBV5wh3jmCVuXbGHmUP
   /Rb0yIKpbSkK+VThpM88NxsLpv1wnU5z8P1p0235mGbdbZiS5EQ61gf9i
   6U5Ig1gZLKR96bewdiH0fWNMOhwWfi9a/AhQQ7VjEdcFN80Az8sWsyTpJ
   RanO8kf3BoCyzodUtPewVXNzfUepMPtHeu2o+w2ndm+3FOa6QFC0Elp4g
   w==;
X-CSE-ConnectionGUID: 1PE9/qwcTcKAALH/iH6N6A==
X-CSE-MsgGUID: OH3BgD0JR72WowuAiV91bw==
X-IronPort-AV: E=McAfee;i="6800,10657,11765"; a="100672998"
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; 
   d="scan'208";a="100672998"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 07:05:36 -0700
X-CSE-ConnectionGUID: DyVt9kljTamXGG1NSy4wAg==
X-CSE-MsgGUID: WhQR0mGsRkKyoActkOSWaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; 
   d="scan'208";a="236931417"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 07:05:34 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 24 Apr 2026 07:05:33 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 24 Apr 2026 07:05:33 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.59) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 24 Apr 2026 07:05:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XFW7rPvfrLmhVoqd2tjymNuTX7KnBkhiJW8DkOqkqq48r7NG+AnC7AneTL6Gk4YDzgiGe0Bl1PvgmLnzKkRBNM2J5DVml/GHsCRVChhAY2pAy5XQRIyzr0TCevMpTKy6mzioRXBfs6A8LMBLRliQouwnUeOxKaCP21DHfplc2sIc6qwqOVjG/qhL/lGtQrd70R+LRfDREPcXCEhfXT8i+O8FLwieACslA0RoFVyb0IioS/clJ6+9YAiirBO9/AvwvALE3GZpOePbfJ9C6Upjf5C/VPqqRtWbf/mkK3TmMZbKxZ97Hg14C5PqcdJUQJU7n4lLWE+qwhUUCCCqspWmlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G5Te0Iw7q1R76p6cn4zGnISjWREyJOyuM6KkxOjoBt8=;
 b=b4Q5EUWD+L4llvjSlBawUicRfTAzwdMx/h6WCx7jymLopZecomraq+0PxvVIxCWu+4B804e9sW9mEuMCPz5aX9nS5Gxs2REeATRqfhdlaDnIRqx3ErG7SURsmgQPhocspvnZGTpMP5i+d1iIjcSxWGVGl7tMj2CR8ahhrIvQWcNTp2xANLfrf1YYuFIr211Qj0UrbfEn/zMnjUOp1ksyew5eWP7bitwOyvAWAwJkDn0bTODzvvoCICSZ/MWFKTd9HEz42DRJK+pIxNtX0xG5NYvCwalHjrgTbHZfLM/NGLy7XjQr4p2jWssJPmuGKXinwKhGOu/hrSBuEY9BQT8/1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by SA1PR11MB8838.namprd11.prod.outlook.com (2603:10b6:806:46b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Fri, 24 Apr
 2026 14:05:24 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%7]) with mapi id 15.20.9846.021; Fri, 24 Apr 2026
 14:05:23 +0000
Date: Fri, 24 Apr 2026 07:05:19 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
CC: Nico Pache <npache@redhat.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-trace-kernel@vger.kernel.org>, <aarcange@redhat.com>,
	<anshuman.khandual@arm.com>, <apopple@nvidia.com>, <baohua@kernel.org>,
	<baolin.wang@linux.alibaba.com>, <byungchul@sk.com>,
	<catalin.marinas@arm.com>, <cl@gentwo.org>, <corbet@lwn.net>,
	<dave.hansen@linux.intel.com>, <david@kernel.org>, <dev.jain@arm.com>,
	<gourry@gourry.net>, <hannes@cmpxchg.org>, <hughd@google.com>,
	<jack@suse.cz>, <jackmanb@google.com>, <jannh@google.com>,
	<jglisse@google.com>, <joshua.hahnjy@gmail.com>, <kas@kernel.org>,
	<lance.yang@linux.dev>, <Liam.Howlett@oracle.com>, <ljs@kernel.org>,
	<mathieu.desnoyers@efficios.com>, <mhiramat@kernel.org>, <mhocko@suse.com>,
	<peterx@redhat.com>, <pfalcato@suse.de>, <rakie.kim@sk.com>,
	<raquini@redhat.com>, <rdunlap@infradead.org>, <richard.weiyang@gmail.com>,
	<rientjes@google.com>, <rostedt@goodmis.org>, <rppt@kernel.org>,
	<ryan.roberts@arm.com>, <shivankg@amd.com>, <sunnanyong@huawei.com>,
	<surenb@google.com>, <thomas.hellstrom@linux.intel.com>, <tiwai@suse.de>,
	<usamaarif642@gmail.com>, <vbabka@suse.cz>, <vishal.moola@gmail.com>,
	<wangkefeng.wang@huawei.com>, <will@kernel.org>, <willy@infradead.org>,
	<yang@os.amperecomputing.com>, <ying.huang@linux.alibaba.com>,
	<ziy@nvidia.com>, <zokeefe@google.com>
Subject: Re: [PATCH 7.2 v16 00/13] khugepaged: mTHP support
Message-ID: <aet4nz/Ljn0kDjDk@gsse-cloud1.jf.intel.com>
References: <20260419185750.260784-1-npache@redhat.com>
 <20260424065828.031775921990de37f83a2468@linux-foundation.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260424065828.031775921990de37f83a2468@linux-foundation.org>
X-ClientProxiedBy: BYAPR21CA0002.namprd21.prod.outlook.com
 (2603:10b6:a03:114::12) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|SA1PR11MB8838:EE_
X-MS-Office365-Filtering-Correlation-Id: f4c588c1-a26d-416a-9dba-08dea20a8745
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 0BXS497zJY5rrCuTSdweoenbFz0zFNP/Q6E2dCoOvYEPJ2RtFNmpjaS2PZJUE2Af4pKpi4DMINiG96ifFv7FeR1/pS0jk+I7V1bDcGAzH2xU31GUiP9qhVoP6twDvfyqSvDN0HqhZkSHVTHq+2Fzo5HxazYmhGfesbm1PNndoIUTXNUYPHzD6KemADrG67rpClQnEnpjyACrP/l9+vRf1MvCMojPuBVWsjwNMb07vqZcm2t5VZkHpKsuD6Bf2bkIyopr9dEeFZpa/P/lkjSq05INyExvU9zID17XqefKMwrcgONDHsJTlnZOvFhlgqI/ocfnn7Hpv48JKbOO6q+LAtQ99IVIAKfyyAJmpqclC67bstmW95BH+XLcOrL8slxVZX9KgauznhGM5x5uQaQidF5x0tQXQApna8fC6g9nmCv6KCsGUlWNImDJRGKnPA8OQWbZOQvX3sH63stTeG7Z6Tan5SJIsdJzMjnvbin1lmGOIPncUE5KGrrqrd1Y1l0q6M4T9p52YPJoS6iT3O0XAl6MZf/XI8bobG59u9hwEmbzVnqs3gSXE/FePnzVllhh/oUn2owk8/q5ynjwp4xUhOZ6kNKHY//Rcnps1HE1LEE6SrOWXQctSiWxClvIjNQltbQRliP+74qFvlh5AWVft1mUQJUaCkkmwLl1gQfmGhLlLIzycVsg6f2M7wODsa0M
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VYCn7ZvXWDN6M6ufiTgtfRNRmK99nDfgr03f3ZjNZY2WIjQf1dbUttCq1f74?=
 =?us-ascii?Q?L2isJRmwrENN9KkY8B7M74Vn40eh/tYWCBc3KawdUoB3oMEDX9vsjIeKuZZn?=
 =?us-ascii?Q?K6AsFJ/nDJAaF3GSGfw+xdYL2Z5NKvMntkTdj+JvA0fnt6KJXltaHjQV/qug?=
 =?us-ascii?Q?NYodk9YBflyXPRkTK/fAUrqJNN3aqOBLV8e4tBGzyV2IVrl8WcPyxKE7inf4?=
 =?us-ascii?Q?omIx/veQR0PnV2JjKysXdaoEExEN3ReUMXXiycAira6CLtjSzDEH3BsKFJ+t?=
 =?us-ascii?Q?4T7ms+nwG8aVyHG7/RScByn4EsLtXH0tIc//8s9kIHM1meLpC9Lhq4q7NpwW?=
 =?us-ascii?Q?6756eHXo+RjfA8uXuJf3Mi37CFEnpc4V4bUYHltrNSuFLw6FSrhnOlUlGvlH?=
 =?us-ascii?Q?VIEbHuEAdlpk+9O/Rlem3IxkUJMVjOST6q9ShcjHByPYr5Ma/sJtmqI5PumE?=
 =?us-ascii?Q?h28f5PTZbhlxOXzBaDCb3se89C3kNbFom6743aqsFq3N+nDf65OhJ1jqvyPM?=
 =?us-ascii?Q?idicnpjlrriBkwzPhHlibFyx52EyLx6sfTLYnona7coNypV2chZEE3whiipK?=
 =?us-ascii?Q?iKdy4Ug49K6dgwHpCaI6Jj4e2qWoSuFNQswf7wpWWnPneTXaxFqMd38IiKcN?=
 =?us-ascii?Q?4qx/0LVnA5mH6LIcP6jgUTkxmx2eyIORDNXgvlCt94k4E2t/4Y8UJrqvwZ6Z?=
 =?us-ascii?Q?52LmvA5xA9XTeJLijrOz/No5QlgiBBZeUA+WeufAuYkdSlllAw4mD3BPgsLi?=
 =?us-ascii?Q?uu223QzwKiH37w1RSrjfnKXkbqpszirmLyOA9ycTA5VnN1QURm+9hDOe7T6i?=
 =?us-ascii?Q?C3s3erg913aBZSwCsdeXbFOYdhfDwQWI5D5B3HGVpG3qLGaX2Hbn7G/gQTZ+?=
 =?us-ascii?Q?pg/fqjib1RaM/uD+n/O/T0vWOS6eqm505qUvb/RqWzYZ2GGyXsstrm8AZ/hn?=
 =?us-ascii?Q?Bt9itKUUWYxo/Odn1GHfqU+JfmS+i3VqhpKKm2nYmzQpsOjAFOYT92r3hB3u?=
 =?us-ascii?Q?wY1jHMwfbMwo3aZaQGrxb/8wko0nxEb2+KPPWPRSf+/y5eFdEG6LENcl4f0G?=
 =?us-ascii?Q?QizGW3yyLOJLaopqbV+u06++2K25YS+9MkHHsdGR7EjQAEiROK/JqHtxchzn?=
 =?us-ascii?Q?Rfq+zFvocZw4wz5uaczKHffEX4k+EeQ3m9aglVfXcPM9hxnHntv+1lhAX0rh?=
 =?us-ascii?Q?yGdLEFJHkkMQFEXycoun5WQJyCsYy48QgsbCJwfNW0vhjDT+q93Nn5rWAvPx?=
 =?us-ascii?Q?QFs+5suBAP2hBsapRrYV9QXuKxxlEefoyUwhgiFo+9TwBgNnjUX9ZcDoE5hY?=
 =?us-ascii?Q?zgjw4T8SdPgVyTZZk0ZxR8W4ACLOHZyTMieoTR/ryB15mRLhKmHhYd6mmiDe?=
 =?us-ascii?Q?a4gkGApxQ8BPHmNQDLOH1snojApwEjTHpH4JPavtvhrNiyvGd6hDNaKNiEkG?=
 =?us-ascii?Q?hiVE128OxybMyWLasbvIu25f0f+bnBMLioyMAJNep/Fq48p+WzjzHA+pkwv3?=
 =?us-ascii?Q?tbXNW1xgKY2JkS/JjgRSk5WvyLAewhHFNcgAMFGOzmu632fCVbVfwHNnnzqq?=
 =?us-ascii?Q?/QBau70+WfLO70qbTNMVLCKC9WNdGadP8kELFtq8HUUSDdPKF2JrRDGN8Xw0?=
 =?us-ascii?Q?m6SOeboSTbZB3VrxaesqM1XBfU9JU+wKz+u0VLIvbJ4Tw3VQ3FQOiasxmqO4?=
 =?us-ascii?Q?hghgqPS8D7hvhmfAeM7hJtMX6RePLNxK3ILh6p5NQQ5LWAiH22KrZ6SCnZ0M?=
 =?us-ascii?Q?VbhLTjgJeA=3D=3D?=
X-Exchange-RoutingPolicyChecked: rUb7j6t7zg5yR6Q+RonvBHT9oguVSqBGfBh4d5kUxxzqR7mx23ma64XaABzWeliUocs7o4iAhrBGlm3e8pCp5By7dCxAhdbX51l8J5CnpKaKUBixb9shYz0LO1nCPEIAac7iXqdONn7M1byhDfSSqUMHYcY3nx7/r+/YPww+arFRa9VsUJzJ0gAbFTQFL/BXXm435MFRRTpNZ6ioILvJ8t5xrzwVR+kekmMU1teZiStlPxxs5580HR6EQ3/RuLCJCEErC4NzmfDk0m38tUOf5Q4m7WvffldGEjMcakHL2r+UCjaKZV+2W/WaifC9IUe2IsnkU+hRNtrSQpbfdjwcWg==
X-MS-Exchange-CrossTenant-Network-Message-Id: f4c588c1-a26d-416a-9dba-08dea20a8745
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 14:05:23.7760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZjXZpnXLyNos+ehWUv9R2m1wBTCCK261wtRGWnzz6y9WqZVifm38PfrkcEOFWypHAkrUDm9lu8EFjKl9HFG6hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8838
X-OriginatorOrg: intel.com

On Fri, Apr 24, 2026 at 06:58:28AM -0700, Andrew Morton wrote:
> On Sun, 19 Apr 2026 12:57:37 -0600 Nico Pache <npache@redhat.com> wrote:
> 
> > The following series provides khugepaged with the capability to collapse
> > anonymous memory regions to mTHPs.
> 
> Lots of stuff here:
> 	https://sashiko.dev/#/patchset/20260419185750.260784-1-npache@redhat.com
> 
> It's going to take some time.  Hopefully worthwhile.
> 
> As always, it's useful to hear about the usefulness of the AI review.

Drive by comment.

On the DRM side sashiko batting average is about .500 but even on misses
it is generally is helpful in questioning assumptions made in patches.

Matt sashiko
