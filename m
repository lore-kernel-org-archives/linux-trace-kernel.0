Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321A6199E89;
	Sun,  9 Aug 2026 22:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786314767; cv=fail; b=NUJVUojUii27dtnBL2xQdBrzUp+NgsldldHx0QXipbcxC+lhxhjLdP2vW/iuke4UBQfWh3JdexS9EY5NB+I2SjdyJ0aNxzJw852gZCwO+OFJRi5ibhoDEMS2wbGo0O4+lmy3QWdZb1tXxttJik0T+0j03I8yOtTHD9wG+AGFlrY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786314767; c=relaxed/simple;
	bh=Z6Nut3JqUkivUkFgfgtxRD98EUotezr0k65ZYhJfie0=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Spcn4Uf8Uh8pNCRJwYDuv7mBukMBPgz/VmDvFt5Xz0BDz+zRVLv7PpNSp+lVZwkha2wi47q5dkms6niRki3NNFXrn4QKA84bcQfkLE25/ihvcw3aEbLVUB7aDEuu9cTtlbJ3Gqcy55XR67V7AkBucXGACNEVJWMEYsLqOuJNjOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L8eO2Nrb; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L8eO2Nrb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786314766; x=1817850766;
  h=date:from:to:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=Z6Nut3JqUkivUkFgfgtxRD98EUotezr0k65ZYhJfie0=;
  b=L8eO2NrbSBBu88U4abb4ATTspgXtriZt8X/7nkmrm2xLrRoq3aX2HplS
   AbTYwuvbWD/tIfkp0OY+cH7Wlo3rRHk7MWlQ/gc83hhzQL4KiNPzqopTZ
   2Se06Q0dcIkMz5Rq8z8kVVhYzqgtr5bekJqQsCSwNVjVecMUihBSrMajO
   t3QNLBWo3bkEblWeL4Tdd753hONz7vsVBGAaCAgmGRVflvUVILCaBfmch
   hyFcF7NW/DFlhEqEeL8Lr3tMoWBK9Zu8K+1AyaGdvQLdNFMWpcXvmHPL5
   Kw6l9SU1i9Qje3cxINthcCS+WRPmAVH90G2hnk99cgZ616obgqguFjbKo
   w==;
X-CSE-ConnectionGUID: XckOTeZoQgmSqrRzNezK9Q==
X-CSE-MsgGUID: 4BUWUwu8R0a56wdZFRkZng==
X-IronPort-AV: E=McAfee;i="6800,10657,11870"; a="87046350"
X-IronPort-AV: E=Sophos;i="6.25,214,1779174000"; 
   d="scan'208";a="87046350"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2026 15:32:45 -0700
X-CSE-ConnectionGUID: uX1HnpfdSEmoso4seaYnow==
X-CSE-MsgGUID: eDht+bxPTrCiLJv7lQ0ebQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,214,1779174000"; 
   d="scan'208";a="259562115"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2026 15:32:44 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Sun, 9 Aug 2026 15:32:43 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Sun, 9 Aug 2026 15:32:43 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.8) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Sun, 9 Aug 2026 15:32:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JZ9sMxv9zkuRIdjwLjgeGeAO4gN0gnMlq32eX1uIS6mS9LTLtMGtlDXdV08Vb1zYWFgsbrULI162n5/5/BgJFDIbKEfhcQ0RpeFDDqPWv7EidgvA6sSZjConY4HY9RBo5JbExKohUMJeWAyitU0g3R3erqAaJfAm4ThQtaAJ0ZwUPZtje8CASoLzlgcVkdYCOj4+hehZhJU/evhwCa1AGwk+69SKCCAlXS18zJUeUP5yLhSEezw3kZE+3oOMcWBxRmYIdLUaQ6+l8Pizo49FR10tRC+jY9ONw/1fsUT3MkvSgFA7fHIeYSNhFVtgbZOvkhK1BtUqxb0UQCfh7LUC7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vJ15D2VIsi7yHAUnQtN26vDgyzXtl6Vy9mttyAs9J5s=;
 b=rKq2UK4qUhHRYoxpPgUjbxOlc9PgJfIM3ca49Hf0OZDVfSDFodoHR4Lomo/cyZzbEZJhCzdcZoAVjbLvhyMK+XqknIvdlfckUGVYCrPSJixQTD2Ui88pdo92dHK95gJbKdkxrXcgd//wCD1ItluFWgm83amBLMZc0mD99vtXKAGWUl+TesQyXNIDYrmMq6IBrpOZKpERnC3ThnXdTx01upth8+WsHdbmM45jPAmQ4hsDOHbpkyRzLV1ZUwOvuxkyGlCVapoygV2+GHLQkZhVZ7qOeFnws6ZhSnKIq/LK7qswTU6pUa/aumwPFE5pQ8YQC6iSpWsYQzZ8mTkj1ENMiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DSVPR11MB9579.namprd11.prod.outlook.com (2603:10b6:8:383::17)
 by SA3PR11MB689426.namprd11.prod.outlook.com (2603:10b6:806:58b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Sun, 9 Aug
 2026 22:32:40 +0000
Received: from DSVPR11MB9579.namprd11.prod.outlook.com
 ([fe80::ab5f:5d0f:fb90:9d]) by DSVPR11MB9579.namprd11.prod.outlook.com
 ([fe80::ab5f:5d0f:fb90:9d%3]) with mapi id 15.21.0292.024; Sun, 9 Aug 2026
 22:32:40 +0000
Date: Mon, 10 Aug 2026 05:51:40 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: <ackerleytng@google.com>, <aik@amd.com>, <andrew.jones@linux.dev>,
	<binbin.wu@linux.intel.com>, <brauner@kernel.org>,
	<chao.p.peng@linux.intel.com>, <david@kernel.org>, <jmattson@google.com>,
	<jthoughton@google.com>, <michael.roth@amd.com>, <oupton@kernel.org>,
	<pankaj.gupta@amd.com>, <qperret@google.com>, <rick.p.edgecombe@intel.com>,
	<rientjes@google.com>, <shivankg@amd.com>, <steven.price@arm.com>,
	<tabba@google.com>, <willy@infradead.org>, <wyihan@google.com>,
	<forkloop@google.com>, <pratyush@kernel.org>, <suzuki.poulose@arm.com>,
	<aneesh.kumar@kernel.org>, <liam@infradead.org>, Paolo Bonzini
	<pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, "Thomas
 Gleixner" <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
	<mathieu.desnoyers@efficios.com>, Jonathan Corbet <corbet@lwn.net>, "Shuah
 Khan" <skhan@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>, "Vishal
 Annapurve" <vannapurve@google.com>, Andrew Morton
	<akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, Kairui Song
	<kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham
	<nphamcs@gmail.com>, Barry Song <baohua@kernel.org>, Axel Rasmussen
	<axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, Wei Xu
	<weixugc@google.com>, Youngjun Park <youngjun.park@lge.com>, Qi Zheng
	<qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, Kiryl Shutsemau
	<kas@kernel.org>, Baoquan He <baoquan.he@linux.dev>, Jason Gunthorpe
	<jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>, Peter Xu
	<peterx@redhat.com>, <tarunsahu@google.com>, Vlastimil Babka
	<vbabka@kernel.org>, <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-coco@lists.linux.dev>
Subject: Re: [PATCH v10 11/41] KVM: guest_memfd: Ensure pages are not in use
 before conversion
Message-ID: <anj2bPrGqzZgZWMF@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260807-gmem-inplace-conversion-v10-0-2fc18ee6d3ba@google.com>
 <20260807-gmem-inplace-conversion-v10-11-2fc18ee6d3ba@google.com>
 <anZ4W9o5pTWIEgMY@yzhao56-desk.sh.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <anZ4W9o5pTWIEgMY@yzhao56-desk.sh.intel.com>
X-ClientProxiedBy: TP0P295CA0046.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:3::9)
 To DSVPR11MB9579.namprd11.prod.outlook.com (2603:10b6:8:383::17)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DSVPR11MB9579:EE_|SA3PR11MB689426:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c2ed973-4574-4cfd-8a6a-08def6661eed
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|4143699003|11063799006|10067099003|6133799003|56012099006|921020|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: kvap3r+n/nZt5B/dC76sUC+VKssvaio9bt6/oT18FaXLkJP1wgSDiHWDlnwLHY3gtB+zYonAH3e+0MZ8x8HfmA51WcqO62rCHAg+jbpPq9gt1FFM7IPaWoPLST3cSP+rVIrfJ8/eQmIrkj86cE9opllCLfQONlcUYT9GVxaEzUAMZBUJ4BAFcwa7F2eplfUPQEpzqbantwWFPsBlyyP3Q90iH78Y76ZPGdSTzKDWpOz0Qmc3NNuJlZPgJTh3mQKqN5S3Om/UiKpTji9C6aunx+9HcljYRThDTN7bZEMDnm63giSfMS150/30/yoX389Fthq7hoxoZXYvaHyj/KMMO/FJ7Io6L0YUV99kt1XUuKMjK43BAF7+8mqN/nvgZUNsvrtOs3pNC1dgUi6t0wIXLbMyfs11FmwCJeB0cMQTnrKwMjXVFAAkjKQ0neXu91+m/0J0QITS9mI43b0wOxI+BHQdI/XxNMJNUXlJ4hj5Ao2YEJegZvZTLF/yLV0lcU/lCe7Q2+ho3DK1EItbIjck7X96MSf2JbvTYai9CXju4n/fV+mNGIzeqP13wkAnkL23M0gqTkFc2r3GzyRdwoAEvxMTdhoaI8wwV/GDhuwV8cwnO2fPaYVUzHOhHRUtx/W7Xr/S6R6tM7jjdOc+utDRCDwRXul0n2Qu/9e5U5/shFPAu12GWBQv8qosTAvuKXJ6Qth7P+s5l7rWZQMWGV7J8g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSVPR11MB9579.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(4143699003)(11063799006)(10067099003)(6133799003)(56012099006)(921020)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?quxruQiV8gQjkIoHofjjJPnlSvrEpk8VhYAR1EzEoJ8SaUbW3PI79phPeUPv?=
 =?us-ascii?Q?g+jGFKhsYq18DWU7wnn8jOTqoWZOh54UJIVH+IiKA/++LvUk0Sf1bSBB/pUa?=
 =?us-ascii?Q?HLTzIyjpyYI1a4aUQdAQKBq985U7BqRDigyKQvVGL+tnK6hGyGsiRbgFkTlL?=
 =?us-ascii?Q?k6UzXIqxSfHsf9XeEy3X+1klPGuAnsuU6XZWBT6Ib5zAoREaPs1YAbRDdywD?=
 =?us-ascii?Q?8efKUZ7tOEbRVkrkyBbAHaES0pe9cK1rgDj/dnFqktPgTHqCRw0ELGm4Dcka?=
 =?us-ascii?Q?fgQKaFyF8LWyZz3e8kFh0f+qH2bgyLwVcJU9NrwSKlghMfcjkNEKkxc73XTX?=
 =?us-ascii?Q?bFqL+t2BxQh/I4OAtRfMEsYw0ppu5w5vpZQAEKEts7dDO8LQFCS9nUpxJ4zn?=
 =?us-ascii?Q?nhXyo8p6eVrOZ14gFPmBKmm+Nkjf5+U5zZfX4ZvlDKq+sFHaRa9ZY0LfAgSJ?=
 =?us-ascii?Q?f/b5CX0EENMMR37do2/CuGyfR/JNia4RV74/r/Kbm40IPjiKGHEc63TG2fR1?=
 =?us-ascii?Q?MkAYl/1AI8tmnMFNrW7I6tsVSQM05YJIx8jQu5FQNlRMcCoK/cO6KZXMztkX?=
 =?us-ascii?Q?L3eAci+2Op+5c+6sIukXkA7ZqT/9K6YfcXwrHkU3RIaWKckawhQR+IB8PP+5?=
 =?us-ascii?Q?Bxs1RyWMAg591z81UTK4OdP6bZMbUIW4DO9JHvZXrvWsqrvicVFlF4ODgDFt?=
 =?us-ascii?Q?26ODV0z2nW7rWaf35Gf6iE4S/tlIgOZBs449JmLlWfZY4JP9NSBTadj5XG4B?=
 =?us-ascii?Q?BZ9oXEoveXbJTyUUcghjFrjWN4R3yG5SG6nd03qNGu99IwaiArVqUOiLG61m?=
 =?us-ascii?Q?edZqUQBXqOTm8L7e7dFeRc6y1+W4nRxhoLapYoKL1vEJpv0Qy1JCI9CFTMc0?=
 =?us-ascii?Q?qT5EsPzzXAwnW5jfOitujQNFs4T1T0YgF2TByKPKWrvVPshJOwzWLmg6qiZL?=
 =?us-ascii?Q?+E1dLIC/ERU/zKvcDSvcqWJ5tXg28fZ+281vs2VAUnGxUUJ+X546jeXAHzPB?=
 =?us-ascii?Q?UC3ECW0Q/AelNjwTdIEQFkl8sYY1OJJqh76/P2KhS61EZVtvXfSV3p7n9PZE?=
 =?us-ascii?Q?cYWdM9rlJhTgqNRPrh8KEB/xeJch2exwkvGSSQbp3eC4tg7fVQNFRO69roRs?=
 =?us-ascii?Q?w5nPhUPUwDR6Cub+1mnfL6YKFWdAVdMk3DHFYUXL8vcWR/4xJwiXGTc+81x4?=
 =?us-ascii?Q?r1wlSobqeOqTaw5p95SKdW984Ya4SgRkOI2NVO0d6JcAyQYbSgEd9hiQG3MO?=
 =?us-ascii?Q?EzO1w/aoaxb1bh/HNclujonH/XrStCIDpqTT4nD8BYZq8e2V3XQlIyPGm8og?=
 =?us-ascii?Q?45cR+09lrP1tE4Jdcc2896m496IU/IChYiNQEw+yvprrO9dcQ4zWgbXKiIEM?=
 =?us-ascii?Q?7NPQ66rkquYvFZwaWE+dYcxBdyhGPxdNM4ZLVifgkK5F8B7W6Te60kF9Lbqd?=
 =?us-ascii?Q?RjiKpySjenZikZ8sHE08IP9RHHO5YYtzbzpI96ZEo2BO2RqLeMEsXTaSLduj?=
 =?us-ascii?Q?HMOJy2yB4aa1SlQ1B05g7zZV7jMXXtIU4Of7/dCd5JZ+EsJ3KSDy37PiSj6s?=
 =?us-ascii?Q?jg8wEvg42DbGNr2N2LjNSW1i64txWoWH5D6JPmhUUj31wxBc4an0casp2HyD?=
 =?us-ascii?Q?bii+wkpuSMgY0exPBztZe0n+OibjaOVUUcr8Rgb6hxvA2ltmhIyTgneSpqo1?=
 =?us-ascii?Q?roEQhxz09LC4tM3k9JhJduXS3B2V6KSpPJrCfQchxamk9MT+WpyGVlP6t1xj?=
 =?us-ascii?Q?deJN9GByew=3D=3D?=
X-Exchange-RoutingPolicyChecked: tOaZFxI0dTKmRT6W8ugHXxxNjcF6c2MvbM1MO6nNgc/xYy1a/t/OhYxWQQiW+n4yn71+MazK2gMCcUxOTBoWhWNbCIdWmVwfN2PiozxIpLkCKGXSxmRwZoJG4skzEgt35uizmHyzGIuN1wSKhcX2N8DhA5nZuRSN0/ve3o3ZxbeX1jyzzaZLdLkhNagmLw/+h+BDm9FsojVldGY16mr42/IPgerBdKxCvp7R/e1HndWk14L2R1ZAmBzFizfF4BLuB8TVNcpXRdCp6ZDE5M+QkT9Xsl825Tf3mLXbBOaQ/fo0nlwUXO3sIc0c9da2Fph8zch4P9yMFUzESw8dSj/6kg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c2ed973-4574-4cfd-8a6a-08def6661eed
X-MS-Exchange-CrossTenant-AuthSource: DSVPR11MB9579.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2026 22:32:40.0926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WP4n5Vj0SMv42azTYhd+fRJNo3FK8L0dN0uaAwAYo9De6Q9pxniTt9Lhgo8YMLkwfJdEdBrD1mMKiAgoXyed/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB689426
X-OriginatorOrg: intel.com

On Sat, Aug 08, 2026 at 08:29:15AM +0800, Yan Zhao wrote:
> On Fri, Aug 07, 2026 at 02:52:50PM -0700, Ackerley Tng via B4 Relay wrote:
> > +static bool kvm_gmem_is_safe_for_conversion(struct inode *inode, pgoff_t start,
> > +					    size_t nr_pages, pgoff_t *err_index)
> > +{
> > +	struct address_space *mapping = inode->i_mapping;
> > +	const int filemap_get_folios_refcount = 1;
> > +	pgoff_t last = start + nr_pages - 1;
> > +	struct folio_batch fbatch;
> > +	bool safe = true;
> > +	pgoff_t next;
> > +	int i;
> > +
> > +	folio_batch_init(&fbatch);
> > +
> > +	next = start;
> > +	while (safe && filemap_get_folios(mapping, &next, last, &fbatch)) {
> > +		for (i = 0; i < folio_batch_count(&fbatch); ++i) {
> > +			struct folio *folio = fbatch.folios[i];
> > +
> > +			if (folio_ref_count(folio) !=
> > +			    folio_nr_pages(folio) + filemap_get_folios_refcount) {
> > +				safe = false;
> > +				*err_index = max(start, folio->index);
> > +				break;
> > +			}
> > +		}
> > +
> > +		folio_batch_release(&fbatch);
> > +		cond_resched();
> > +	}
> > +
> > +	return safe;
> > +}
> > +
> >  static int __kvm_gmem_set_attributes(struct inode *inode, pgoff_t start,
> > -				     size_t nr_pages, uint64_t attrs)
> > +				     size_t nr_pages, uint64_t attrs,
> > +				     pgoff_t *err_index)
> >  {
> >  	bool to_private = attrs & KVM_MEMORY_ATTRIBUTE_PRIVATE;
> >  	struct address_space *mapping = inode->i_mapping;
> > @@ -542,8 +576,21 @@ static int __kvm_gmem_set_attributes(struct inode *inode, pgoff_t start,
> >  
> >  	mas_init(&mas, mt, start);
> >  	r = kvm_gmem_mas_preallocate(&mas, attrs, start, nr_pages);
> > -	if (r)
> > +	if (r) {
> > +		*err_index = start;
> >  		goto out;
> > +	}
> > +
> > +	if (to_private) {
> > +		unmap_mapping_pages(mapping, start, nr_pages, false);
> > +
> > +		if (!kvm_gmem_is_safe_for_conversion(inode, start, nr_pages,
> > +						     err_index)) {
> Note: conversion failures could occur if another vCPU is attempting to map a GFN
> within this range.
> 
> CPU 0 (setting attributes)          CPU 1 (attempting to map)
> --------------------------          --------------------
>                                  A: mmu_invalidate_retry_gfn_unsafe
>                                     filemap_invalidate_lock_shared
>                                     __kvm_gmem_get_pfn ==> folio refcount++
>                                     filemap_invalidate_unlock_shared
> 
> filemap_invalidate_lock
> filemap_get_folios
> check folio_ref_count(folio) ==> Not match !!
> filemap_invalidate_unlock
> 
>                                  B: read_lock(&vcpu->kvm->mmu_lock);
>                                     is_page_fault_stale
>                                     kvm_mmu_finish_page_fault ==>folio recount--
> 				    read_unlock(&vcpu->kvm->mmu_lock);
> 
> 
> Retrying in kvm_gmem_is_safe_for_conversion() or moving the invocation of
> kvm_mmu_invalidate_start() + kvm_mmu_invalidate_range_add() to an earlier
> position does not help as long as CPU 1 stays at stage A.
> 
> So, should we avoid this failure?
> e.g., by moving filemap_invalidate_unlock_shared() from stage A to after
> stage B?

Or what about having KVM always treat gmem page as non-refcounted, and have
kvm_gmem_get_pfn() put folio refcount before releasing the filemap invalidate
lock?
Below patch is applied and tested at the end of this series.

From 8c2f29bc15bceb6a8fa103cf2585ec11354fd74e Mon Sep 17 00:00:00 2001
From: Yan Zhao <yan.y.zhao@intel.com>
Date: Mon, 10 Aug 2026 06:24:52 +0800
Subject: [PATCH] KVM: guest_memfd: Return gmem page as non-refcounted

Have kvm_gmem_get_pfn() put gmem page refcount before releasing filemap
invalidate lock and return the gmem page as non-refcounted. This avoids
gmem memory attribute conversion failure caused by temporarily holding gmem
page after faulting and before completing mapping.

guest_memfd always holds gmem page in filemap cache. TDX does not increment
gmem page refcount when having gmem pages mapped in S-EPT. Additionally,
as gmem pages are not swappable, setting dirty or accessed bit is not
necessary. Therefore, there's no need to treat gmem pages as refcounted
pages.

Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
---
 virt/kvm/guest_memfd.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 2115e73e455a..e357b4ffa777 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -1332,11 +1332,10 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
 #endif
 
 	folio_unlock(folio);
+	folio_put(folio);
 
 	if (!r)
-		*page = folio_file_page(folio, index);
-	else
-		folio_put(folio);
+		*page = NULL;
 
 out:
 	filemap_invalidate_unlock_shared(file_inode(file)->i_mapping);
-- 
2.43.2
