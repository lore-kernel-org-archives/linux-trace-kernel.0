Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847B5331230;
	Tue, 23 Jun 2026 05:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782194230; cv=fail; b=HAz5iboisF9ELW77iMBhQPb6RTiwzfrJYSbFvZ56dZVDVO/CTjOqCYC4VWAdaF4Ye/+JhoXLYCug26FMkEaL+yZeK2WzV87BPWCalhir7GR2nU08NvgvjhjpuEX5yHgt5TM+5q4WIf4437vat5By6j8+AjMIrZp0wHDqU/kjJm4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782194230; c=relaxed/simple;
	bh=rc/0lzZxz92Wz+qQhs+B706//1Blimav0TXnSZQtH9Q=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OI5mMXWybNgNz9um6GckT+7WFM+X+K9VvH9eU1BC+i8b0a1wcRsLh+HKjd3Yht3yX91ytTJCfo0DWe9rl5PLQWDG1NjKTL7k5nxdAuPF39G+V3Ck6hcV6DrwEETQXQR2PwPUj8olPbHIVxILkdT86qCAKB16m3vX5aKQjx2UkYk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=faVhgwXU; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="faVhgwXU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782194227; x=1813730227;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=rc/0lzZxz92Wz+qQhs+B706//1Blimav0TXnSZQtH9Q=;
  b=faVhgwXUdaGwsXvOpgs8VEzmL8WtuNr74gH918z3Y1MpEaZXlxrJ5Xzy
   9zX2XX65ZSnt5VQLhfkjo4tzYDncUaGw/whOGZcGOzJ4tWGfgOAVY5Fk5
   YAiQIyrN//lPufvBubnG7NHr7sumYnjtgi/y/ZknF+cr0bzBr35zW3FVU
   1z3Rt60OFt0kZCGOtf2nqqG1KnM2af5kbJX8RPRaUKFMVyFzmgda6gu6B
   c6qn+IvNtUyjS/nOhbdVHF4wdsQ1LrzhIsRMG+/hIKaMlgGajnrr5GYiM
   K/YHmT4+Q7H0AVbxNJdTanWWD440HmKe8GgKe2GCoWiuDxAwYCmnz6mCO
   w==;
X-CSE-ConnectionGUID: 7AHDDLF6R6ulnycVDA9TAg==
X-CSE-MsgGUID: OyFACYO6RXiE5JHSpe0hEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11825"; a="94317285"
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="94317285"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 22:57:01 -0700
X-CSE-ConnectionGUID: qcEmphcCT1+B1Ht+FTM4qw==
X-CSE-MsgGUID: SYHRGV+fRlCgInwoNs9Elw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="246510446"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 22:56:59 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 22 Jun 2026 22:56:58 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 22 Jun 2026 22:56:58 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.54)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 22 Jun 2026 22:56:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZK6088QU5+XtxwQaYC2MMqwGiTWUsZHZvEXssFAykj6ihTTDad0nOhCRAfa3+gcymaPfEa5jRSkWEjeX9jHfoenZOwDle+1dHivfa1zvvGIRLiZrLrDOhUwbdR1dp3MQwUzvzE2ADTZWiehkrYAOukESnajxB8diBraNOCSHUm831ai+kgJjtDIjHNJrOmpZV5d3NNYRycOmPNAMdjb7bweGBsIkwMtCo+R5weE9P8ThYehwgBl40BmXMKQElEQjlp5/Q6+dJVSd4rpq6+tBIyc9Mw8O3RSZ4ftoyyJlfvyXAi7+JZi/UqzGvaUJmcUK7MA5OpSXDCLbAwdD7B4LUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5mz2AXRrG4arAwY+RYseUNKGdgGRmUW9N6spHFjbiZ8=;
 b=WP4zM6VZJMSPcfdJbOkKOD2vuRJ+hHcXiqKsteUjtFKsTwZbu8xsBmz9hVAchOFlc34lyeHMqLK7oIYOgPyucdywrL0P+Lcxa5KdJeFL19qtFKedSHqBGeYPJE8hj5zY/gNuI9HfZfs2qKA2OGH9Ev5iXO5LEykYxrIas/N325VKoY6dJ6nwKOqE4VEPHMZpwXBuXqZo4qPTXIfSzOD/2TARcHR1DcTwlYglURkWFhjFfgVKvOElvHgb++I7bnIO3JsQox/lcjKeTDFrV74JUWefd4L1L3+Gtd3d4FKDMqZLU/xuTJZBlPYHLwUikvjTkKj6RMfq+fyv1xVzeCVoyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7472.namprd11.prod.outlook.com (2603:10b6:510:28c::12)
 by MW4PR11MB5823.namprd11.prod.outlook.com (2603:10b6:303:186::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Tue, 23 Jun
 2026 05:56:48 +0000
Received: from PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475]) by PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475%5]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 05:56:47 +0000
Date: Tue, 23 Jun 2026 13:16:14 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Sean Christopherson <seanjc@google.com>
CC: <ackerleytng@google.com>, <aik@amd.com>, <andrew.jones@linux.dev>,
	<binbin.wu@linux.intel.com>, <brauner@kernel.org>,
	<chao.p.peng@linux.intel.com>, <david@kernel.org>, <jmattson@google.com>,
	<jthoughton@google.com>, <michael.roth@amd.com>, <oupton@kernel.org>,
	<pankaj.gupta@amd.com>, <qperret@google.com>, <rick.p.edgecombe@intel.com>,
	<rientjes@google.com>, <shivankg@amd.com>, <steven.price@arm.com>,
	<tabba@google.com>, <willy@infradead.org>, <wyihan@google.com>,
	<forkloop@google.com>, <pratyush@kernel.org>, <suzuki.poulose@arm.com>,
	<aneesh.kumar@kernel.org>, <liam@infradead.org>, Paolo Bonzini
	<pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
	<mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>,
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>,
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>, Barry Song <baohua@kernel.org>, Axel Rasmussen
	<axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, Wei Xu
	<weixugc@google.com>, Youngjun Park <youngjun.park@lge.com>, Qi Zheng
	<qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, Kiryl Shutsemau
	<kas@kernel.org>, Baoquan He <baoquan.he@linux.dev>, Jason Gunthorpe
	<jgg@ziepe.ca>, Vlastimil Babka <vbabka@kernel.org>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-coco@lists.linux.dev>
Subject: Re: [PATCH v8 23/46] KVM: TDX: Make source page optional for
 KVM_TDX_INIT_MEM_REGION
Message-ID: <ajoWngKaZ+wfIyR+@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com>
 <20260618-gmem-inplace-conversion-v8-23-9d2959357853@google.com>
 <ajjc0hw8PjGw69e9@yzhao56-desk.sh.intel.com>
 <ajnf5Z9nWZxoLS4x@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ajnf5Z9nWZxoLS4x@google.com>
X-ClientProxiedBy: TP0P295CA0043.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:4::18) To PH0PR11MB7472.namprd11.prod.outlook.com
 (2603:10b6:510:28c::12)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7472:EE_|MW4PR11MB5823:EE_
X-MS-Office365-Filtering-Correlation-Id: d4503d11-a553-40cf-9ab7-08ded0ec365d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|23010399003|18002099003|6133799003|22082099003|56012099006|4143699003|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info: FCg88oh1zuHLnqk5EsZ8QtecKBsX4QRA83DPr/X5fSOmh9iidISmPLRFjXNqB+e1WCCUepDKQKCLWiPbf+q6mCSSuAXJNHk293rYAxyw0XobOdEUpxpudPbSihh+xXz3rp4NEBnDTdRFLau8XolsIKrab+rZGb1DHQV/ErIO6bUk039YS2r5EKrDtYz7zRKekrdS+zQnPfq58R6AtNBhXP6xl03mdRV3UQpujfJhbReGRS10DmMygTAyl2cF7LSu7JOshlgU7PsBj4JXC97Ifh5eomYRh9yyAGXlzsnR8M00t09hT+18fTPGow/K7sAlgh6W41iuBbPZoN4X7Nh6i5GgxWWzeYGCsFyy/FmZrHUV7Vm+ie5j/ts+3pYnGNtb1taUhk9pQuBsQqhKThuk5fGLghfK52eL3P3/0IoaVnuWwCemYUjbn6LDEWkdY7JgqwV/z+7mQHdHPGft42oZMHyiJAqVsWgCSsk37pXYADUs9CQ5aNTWf7863nSfsHAZjUrqZR/9kx/pl83GorL/Kb7WHUPqy06CALRkkFZvnABCZgL4VX54UP/u3QKN4QJS6p42vJ5dYu65pqeJAAetQmm9GCu9Y2TMsq0ytV9O2ur5Boe11kmq91NNdQGh8sfrNYSWPVB9NRnvX8JsGpiaFQiMpFLLC6hyuqIAeuFJU2w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7472.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(18002099003)(6133799003)(22082099003)(56012099006)(4143699003)(11063799006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dCGTagAjISviA3WzoCNvi2ouxn54hvc7WKdvgUUbJE3hrKXJYbhVNYGK/6MB?=
 =?us-ascii?Q?VjtLLqYGNPU3zpLV040LBSTmeCFgkRO11u5C3f0n6c6d5kUokLVkGDXJGQR/?=
 =?us-ascii?Q?lMFZb//aOdyBnDHk5nPIwhEYgNQeOvdDHky2gp+BooaYuPO5GXDqI+j5/d7w?=
 =?us-ascii?Q?kQCyS0j52VKUYIEQSW6/t9aIZ8LuZQYwmll7BwgisHq11rYvQGNgWzBNB+De?=
 =?us-ascii?Q?L0rJnckxhEhd9eMdGgKxKoctleAlYm2ux+5LGLe0Vkrgqq2pipAwjaKlL810?=
 =?us-ascii?Q?j5xsyIb3GuzHqSZ0MDVI1pBuT3u6H+QoRxjqJdWj3CgVuByRiTUq+ooysG1V?=
 =?us-ascii?Q?NirhySGAOaLY1jvLEWRK9pIGHtEMafyPR4MYHeTnRwo3RnxBosXGrfGwse6V?=
 =?us-ascii?Q?ZIKutYAro4EwqxhW60Jfbwt0DpvSa9AIF+SNXmqe+ao0V4gJhg4DKCrDZI+X?=
 =?us-ascii?Q?J3urEOzLlUKf0mXZQC5GP8Y9xMr67BpXuKvtilfsEiQk2OEajCR2N/k6rODt?=
 =?us-ascii?Q?44uhkMO8Z33tw9aI6pjUg+fF4Qe6KIwj1fErDB05YSrz+8+uKGamXR5sq33m?=
 =?us-ascii?Q?nEr5Sr1iwIZT+m2FoyMXo4+ey0U7mXl/17bVgS12Qg2N22Sz99HzXA9BEHGN?=
 =?us-ascii?Q?VxmGG5/8RphA8omj67/qpIa1/5ur3q9IDTk4szCh1lfQMdWG5ZLG/XiLeENN?=
 =?us-ascii?Q?v5jsa0bkU6/+TMOYd4v3cxd2ur0xUCJ9exW3mLuYxiRvjxcJ3f6HhB9iedzS?=
 =?us-ascii?Q?WTR2m28iCNr725PHifyAeZLS5PONFaySl6u2RcFmkkYP0xnG76gc3wxp1AVA?=
 =?us-ascii?Q?MD17SYGkV0WvU87uWalNlswaxCbq5QqiPfCgZeqOovC6dUC5a5q9WSRlk85b?=
 =?us-ascii?Q?QGIh+m01xcx+ur9645lNrS/PZcGATfPaLw89+TYZ9w02WdlQwM7aREiC8IQB?=
 =?us-ascii?Q?NM9B0B/pmTOYY/iSJy+bSCKkq6pIUjvtO7V11HWup4UNcHLvO33AOLztQEa5?=
 =?us-ascii?Q?6SamfOMemc82D+VOss4Xrm+tSFgAUCZBYrDuWfJIaeODKErs6/035XVXSuKt?=
 =?us-ascii?Q?yKkRtoDjXFM4BFezjGgwMS5trpg14godYqOhYbfLVhmhBevvrTr4Dz5QS2d5?=
 =?us-ascii?Q?tuCV3TzclzzxsC6+owySdDR434Af1Am28ldt0QpEjXFgkG1ztLfhtH62mGN8?=
 =?us-ascii?Q?WtZxFgZYaF5gGO+l39m1ACKQwgnO0Xy9yfxdedcyTEPXt0VFgUGbM4WsburS?=
 =?us-ascii?Q?5CQFTiOVHZgXUYAXkF/2NW4g+7tRZ3D4pSJ4HsKRrdA/p5Gd5oFpJHMikHPx?=
 =?us-ascii?Q?UHysEWxBsQ4Ix3OopHj7CYfxP+q6eHRTk6cHF+DKTouRzfmFF4CnIMB4uXWi?=
 =?us-ascii?Q?3ifVShrZnicQ7OcAwIsMqhhcNfUXcLkOqGOedozMZ08noCNUFpzzb6LHkz3T?=
 =?us-ascii?Q?VXbUbAbCIbVuwSU2alTdmHWJcwBD4rkKbN+I5Mfb4hMrvq1SptdLfdTfaiTj?=
 =?us-ascii?Q?IgpgNP/2zDnukFxc9nJkqECoCB/0nkVS+p0GR4HfGgSVKH1VYzxjjRzLmr1r?=
 =?us-ascii?Q?YM1r14i8Bc1vtBdb13nAjAqra+Ua1TzE3VCQ9QIBGngAp753Gcy7ocTUt6R3?=
 =?us-ascii?Q?I02qBo505aKjQ9sPfkcU7k1GXS5RXWVcxolre83cz4hNjQjUXpc3GA0nTNwn?=
 =?us-ascii?Q?NxMopkTtS1/YCw/p0yFDi+jovdc7qmSJlNzKqRyMkrwNA4QO54gMk3y10g8/?=
 =?us-ascii?Q?kEtrd9TjlQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: aXUXQLYo5cNt2FS/P97Yi3JTkYFtE1rGP95uLzFkyOOJzHqX2IY4BMRL2Z8HGWrc1iGQ/VvYv7Lpq7UtvWun5DMmZtwU63nGxoo5qHeSgo8JIP6KlbabdZmddcdVVRkojHytYpiUOXfBebBm3fZ0iOoyAd5SnTcvqPbUe13IrIbSfPdYUx2v4Mi5LTducZvIuZM2vIJhJX94I5pHrHwJyU8NexDmhdeskhJMBn7SLziOlg1oOovzE+yfwaGwzmIR6eoSph7ndB0HKK1cgG2el1AFHPcp81Q0Mt9nIRsVvtGsAGS9neRQpKY0/SMGGs8CFXrTMrv1Aql9xdTyt+UaMA==
X-MS-Exchange-CrossTenant-Network-Message-Id: d4503d11-a553-40cf-9ab7-08ded0ec365d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7472.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 05:56:47.7414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8858BmZHYwhGY3KmvqvZX8Vc4ObJ47P84jVYXvPUxo2FtNZ5pr7PSXPNmeLb1UBF2ofxQ60hL0Uc9RJkYfM6hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5823
X-OriginatorOrg: intel.com

On Mon, Jun 22, 2026 at 06:22:45PM -0700, Sean Christopherson wrote:
> On Mon, Jun 22, 2026, Yan Zhao wrote:
> > On Thu, Jun 18, 2026 at 05:32:00PM -0700, Ackerley Tng via B4 Relay wrote:
> > > From: Ackerley Tng <ackerleytng@google.com>
> > > 
> > > Update tdx_gmem_post_populate() to handle cases where a source page is
> > > not explicitly provided. Instead of returning -EOPNOTSUPP when src_page
> > > is NULL, default to using the page associated with the destination PFN.
> > > 
> > > This change allows for in-place memory conversion where the data is
> > > already present in the target PFN, ensuring the TDX module has a valid
> > > source page reference for the TDH.MEM.PAGE.ADD operation.
> > > 
> > > Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> > > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > > ---
> > >  Documentation/virt/kvm/x86/intel-tdx.rst |  4 ++++
> > >  arch/x86/kvm/vmx/tdx.c                   | 11 ++++++++---
> > >  2 files changed, 12 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/Documentation/virt/kvm/x86/intel-tdx.rst b/Documentation/virt/kvm/x86/intel-tdx.rst
> > > index 6a222e9d09541..74357fe87f9ec 100644
> > > --- a/Documentation/virt/kvm/x86/intel-tdx.rst
> > > +++ b/Documentation/virt/kvm/x86/intel-tdx.rst
> > > @@ -158,6 +158,10 @@ KVM_TDX_INIT_MEM_REGION
> > >  Initialize @nr_pages TDX guest private memory starting from @gpa with userspace
> > >  provided data from @source_addr. @source_addr must be PAGE_SIZE-aligned.
> > >  
> > > +If guest_memfd in-place conversion is enabled, pass NULL for @source_addr to
> > > +initialize the memory region using memory contents already populated in
> > > +guest_memfd memory.
> > > +
> > >  Note, before calling this sub command, memory attribute of the range
> > >  [gpa, gpa + nr_pages] needs to be private.  Userspace can use
> > >  KVM_SET_MEMORY_ATTRIBUTES to set the attribute.
> > > diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> > > index ffe9d0db58c59..56d10333c61a7 100644
> > > --- a/arch/x86/kvm/vmx/tdx.c
> > > +++ b/arch/x86/kvm/vmx/tdx.c
> > > @@ -3198,8 +3198,12 @@ static int tdx_gmem_post_populate(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
> > >  	if (KVM_BUG_ON(kvm_tdx->page_add_src, kvm))
> > >  		return -EIO;
> > >  
> > > -	if (!src_page)
> > > -		return -EOPNOTSUPP;
> > > +	if (!src_page) {
> > > +		if (!gmem_in_place_conversion)
> > When userspace turns on gmem_in_place_conversion while creating guest_memfd
> > without the MMAP flag, the absence of src_page should still be treated as an
> > error.
> 
> Why MMAP?
Hmm, I was showing a scenario that in-place conversion couldn't occur.
I didn't mean that with the MMAP flag, mmap() and user write must occur.

> Shouldn't this be a general "if (!src_page && !up-to-date)"?  Just
> because userspace _can_ mmap() the memory doesn't mean userspace _has_ mmap()'d
> and written memory.  And when write() lands, MMAP wouldn't be necessary to
> initialize the memory.
Do you mean using up-to-date flag as below?

if (!src_page) {
	src_page = pfn_to_page(pfn);
	if (!folio_test_uptodate(page_folio(src_page)))
		return -EOPNOTSUPP;
}

One concern is that TDX now does not much care about the up-to-date flag since
TDX doesn't rely on the flag to clear pages on conversions.
I'm not sure if the flag can be reliably checked in this case. e.g.,
now the whole folio is marked up-to-date even if only part of it is faulted by
user access.
Ensuring that the up-to-date flag works correctly with huge page support seems
to have more effort than introducing a dedicated flag for TDX.

> > Additionally, to properly enable in-place copying for the TDX initial memory
> > region, userspace must not only specify source_addr to NULL, but also follow
> > a specific sequence (where steps 1/2/3/7 are required only for in-place copy):
> > 1. create guest_memfd with MMAP flag
> > 2. mmap the guest_memfd.
> > 3. convert the initial memory range to shared.
> > 4. copy initial content to the source page.
> > 5. convert the initial memory range to private
> > 6. invoke ioctl KVM_TDX_INIT_MEM_REGION.
> > 7. do not unmap the source backend.
> > 
> > So, would it be reasonable to introduce a dedicated flag that allows userspace
> > to explicitly opt into the in-place copy functionality? e.g.,
> 
> Why?  It's userspace's responsibility to get the above right.  If userspace fails
> to provide a src_page when it doesn't want in-place copy, that's a userspace bug.
I mean if userspace specifies a NULL source_addr by mistake, it's better for
kernel to detect this mistake, similar to how it validates whether source_addr
is PAGE_ALIGNED.
Since userspace already needs to perform additional steps to enable in-place
copy, specifying a dedicated flag to indicate that the NULL source_addr is
intentional seems like a reasonable burden.
