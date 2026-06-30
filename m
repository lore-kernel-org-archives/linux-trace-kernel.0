Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27EF82882B7;
	Tue, 30 Jun 2026 02:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782785373; cv=fail; b=X/kHpFmmwiTnGVNd29x7UI4zf81SLekZ5+KaS4e8wU1qzM+BvNRJj7PpCU52mHPKD9JX30CzW1w7EMTcYRdwOT2DlGPcMv64kN+KdOzFlykuQmaHr1D3gV5moGqaUWCLFW/AoCNyFS6K6sMo+UjcBXA7CHdLYtwSk01BzYLHhIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782785373; c=relaxed/simple;
	bh=/QHxYUGmqasLGjupC3EcuE8oJ3EyhJnUO/iBNVCbkxU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZVN3gfGaAaNNRjOFg9ZFV4IMMdWdOI6HIJipGYm2vnbOJnxv71WAtLRj/V+T5Eb5fNzaDny96xL8AGNg8kkLgVtx676V6zr7OClXQJzHV0rXNFvzYcBSDwqpUvRznsxPZzFqSl0MoeDRgJ9JQWetWgBnkbg1RtpV3anuwSCMn5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g83BgT21; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g83BgT21"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782785372; x=1814321372;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=/QHxYUGmqasLGjupC3EcuE8oJ3EyhJnUO/iBNVCbkxU=;
  b=g83BgT21INbMP4dQGzyYaSJ6ITb7WBztQzzwFnRzij1QNvTd1adjJlKC
   YdxrDebQnWfE1yrk2zMElvwdEXFA0+zmorvvZoaor6VN9SE5zWZ+JmMbD
   14AQZsiunfnEU4a+BUJQSaZMS2D9g3bpQia/cLquzkCIDnh66S9vQdx5S
   +XXLxXcrmjbTuchQ9OYo7PXtTtYJg+dli8xLSX0us/a1WQM+y0+AkOXZu
   CjHrcv9HDCDvxcxVEiFaTT6nwdM7mUMb01TcvTUppQKyvTXATmNO3MEuY
   9KwhZyNlTe1JKNn2BC421cxInpq/BGihNIzDmspWie18Ze33u9KRqL1VK
   w==;
X-CSE-ConnectionGUID: 5u75/5QwS/u4KNaJTx7m/Q==
X-CSE-MsgGUID: BQAskheRRWKMbDDBxJqquA==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="83368262"
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; 
   d="scan'208";a="83368262"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 19:09:31 -0700
X-CSE-ConnectionGUID: i14IwNXYQK2F3lp6/2jPLQ==
X-CSE-MsgGUID: uLjX+JjcTOyfl9mZJh3ZXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; 
   d="scan'208";a="250435839"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 19:09:31 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 29 Jun 2026 19:09:30 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 29 Jun 2026 19:09:30 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.15) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 29 Jun 2026 19:09:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O/mqZtRAM798q1GuMtjFNoBzGzRNVInTMWt7EZyetvJDt/BOnt+jPKeSo+C6MixSfORzVHfPmPpW5l6Qq/9zP+dPSLu1e79uI4pBp/Z+fD2xx4YOzFBmdjFRgcXclRG4VClztE4RwlpEeR7+LNcifSv0YCBEfUw5YabYn8nzN6lHJ40ROBwNcsfaIW5w6DrFVfphWEigMTuyaPhhUnH4nQjql0znWzwVksAy3UBKfJKrrqEFLDFQc12d3078H53k6bINoPSbCePHLjR0J8cHc0f4sYaCqzMnaTEeQqiRrjsoFp788WI+BonlwNVHl9WYOBGVeeDaK+329SWkSVngQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zM+Sg/OFK58WlSSYI7IjwU4t2O3LXRNazeSOdHCi5do=;
 b=UAc8cuKi7/mgM5pX5Iucpy++MMfZXUAJAJDY2oQvX5xIZuk8uqZOVsm2QnbFCXlaiR1VzjTP6QFh6KQlDC74SifA8ZBQnfP9wOIwep+vIS1LvMW9XBZ+pN75hY/jhtoHISbfeV7AnQcZYIp//kyYpplgADOG419XW1ZsQVIQN7jOmQADcOu3PkbT0No2ZSo2XfDGqX4E+umS7Tu9qXLnVpRtFWtav8AL2ybreX7Ty1Znx+xJOE7gXsFhuMXPhZzr59QewdPqzbBZ7BxUuvmG2aGVzElQcbrnHA7H3LIlm9IjKGsf0fYGeKIZUPWJnO9HhGcPwlUROxpIcHYMSloygQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7472.namprd11.prod.outlook.com (2603:10b6:510:28c::12)
 by DS0PR11MB8081.namprd11.prod.outlook.com (2603:10b6:8:15c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 02:09:21 +0000
Received: from PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475]) by PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475%5]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 02:09:21 +0000
Date: Tue, 30 Jun 2026 10:09:07 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Ackerley Tng <ackerleytng@google.com>
CC: Sean Christopherson <seanjc@google.com>, <aik@amd.com>,
	<andrew.jones@linux.dev>, <binbin.wu@linux.intel.com>, <brauner@kernel.org>,
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
Message-ID: <akMlQ1TuB2qTtKn5@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <ajoWngKaZ+wfIyR+@yzhao56-desk.sh.intel.com>
 <ajpGxu2uQys+S2F8@yzhao56-desk.sh.intel.com>
 <ajxasFBzp_9KnQLq@google.com>
 <CAEvNRgG1nHipzw4=eBgwhvyXi8xYo7FQD_sy9Ax6FDf7YDu3Og@mail.gmail.com>
 <ajyRg3BwGu5dCfOn@yzhao56-desk.sh.intel.com>
 <CAEvNRgH5KOHoemnC9QOn_oK97=KeAH1XuX3ps36-pJ0Fn0aBHQ@mail.gmail.com>
 <aj3TGLGWT1kMFIVH@yzhao56-desk.sh.intel.com>
 <CAEvNRgHb6WmOha6Pct_Tn8Ucuov95L=fj5=2R9gcHfx=b2V_+A@mail.gmail.com>
 <akI9m02jgKAdi4gX@yzhao56-desk.sh.intel.com>
 <CAEvNRgHO3T6pKDP7ye-RdqbGhAzVC7a=8uBUyaPxwbSuj9khqA@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAEvNRgHO3T6pKDP7ye-RdqbGhAzVC7a=8uBUyaPxwbSuj9khqA@mail.gmail.com>
X-ClientProxiedBy: SG2P153CA0001.APCP153.PROD.OUTLOOK.COM (2603:1096::11) To
 PH0PR11MB7472.namprd11.prod.outlook.com (2603:10b6:510:28c::12)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7472:EE_|DS0PR11MB8081:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a5f2faf-3aff-4f5e-b9b5-08ded64c993b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|4143699003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: hKMnJ2szBvLCtOX0U5ZNmW44Dqqfq7SVXS5x/XypL5NEqvzKClW6/9eZdgHDceyvRzXPemEc7h7PBI16PwkVrwU1Neh/xsXiNULSExzcX0wEASilQm5iF0AI0Td8bbqrX+9QIXj3DkIyaFTC34FIGaZaF4UJIep6C4G9zOcNMd7SIhiEo4dd78K57X8R8BDjjWE2G0r4iSanQSiN0sQOYuiPEziPIglgWV1UeznOre84QPi++sG+JmS6hw52auu37oyXpWEHPDFqpdbAsI18yvQ16/J/vRCzpUXeUgKL+s8yJH5qbdGWq9aWsdAd9Q2AZw2b7B62QDab8Ulk8pUsEeAlnPEgzFRCkNSMzY1Ur3O0zNTL2VbZ3SujQ44D0GJvUPL/T0HIzhynb5KwB4SOjuaPCGpZL37/1hgMjn5Ky79l4ZzdbqGRsDEJwbPZMZ6WpDy4cyXzZG/gWejp/DpIUSjRMY1BRcw1fBE7Z1hvWGjRhZ6Uc0J0t0nsx6oZ6absGRjQ27FMPorO7NOy1BSw0XGa3J5v/j1EjgKkCVYAFljWlqs7k4fhnsOfvdh6Dki9aHU/YRDLmHNXxtVM5UClc9zd8Q1+Q8ao57KozadmGcVM35a7dEqiCOC+pX+8wjI/n3DJYyTF9Chs7VNSlQFBLWwx0lER8hztMKxKhn5DQnI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7472.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dzUvpcyInYIf1pMBGGNudGF4kDvJ69tNv23xi7c4Y+JKgcqGBTts+yr4QQ2g?=
 =?us-ascii?Q?RzXbVjncW+Lvq1rFhbSJ5fbwgFVZpbjnK2Zm0+vD44oZ3hP562cg7xgMghmi?=
 =?us-ascii?Q?FH3MD/367O9fighU1iR4K2i7Ho6J5WUt+7CPK0W52zg4JfGMJMiOWwe4d1Xn?=
 =?us-ascii?Q?B2kbS+c7zybrPxYBN01JncueHI3YeiDwpk/beeUNLAdKZUKx9CxCJUxCfbyE?=
 =?us-ascii?Q?lp/3lrzc8ZQ99Tn7UZIzxpYjydIc2I9iHFiZGdOMctqiyhhI8egACZb37u3T?=
 =?us-ascii?Q?mTFeQ7dsBntrmDKU4K5ik3MI9QaBGowtiW+EM4m2krg/elw1eFbHw/OSQiQd?=
 =?us-ascii?Q?KLiltXqlYwUbU3pfBd9x6BE8H5PvbCfs9h24ROnolTgWZ5Q8Ok+1PRfwB7UJ?=
 =?us-ascii?Q?8RMAw55+pYzHUxAPv+VE/rpMmCUjTFJuYLwcPQ4+C0DK1hT312sQxMWqIC70?=
 =?us-ascii?Q?Rl/b1FTGx2lckCf+sOlB2I4l7Mie534MU9WzY7Ev5chvpf1xHgvUh9b/ISLM?=
 =?us-ascii?Q?EFd2t9fnSWcc/+xcLU7a3wsEFicdLBeMfmYvz/DH2Bt0sNgzLWu7Iq1em/vi?=
 =?us-ascii?Q?IJ9AlRySxVyXMTCoXToF6WSi+PifLqSdrYq+a+dEvkTqQC2miXbGtV3adSh3?=
 =?us-ascii?Q?oU3LGbT2l8MyVO8urQ/Cbo1Gv0HFsGIjNLiDannIRE7BNB8RGv6iWb2PWVGn?=
 =?us-ascii?Q?dsvLrVzwAZAHWNb0QU5OgJdLznygDePTH9/ZY7u/xr5dknkgLEBDL50yjct2?=
 =?us-ascii?Q?HyYgJel0l6ds7olnxD72vcJufNa3DHEYejdQVDswHe1kjHISLzB2YdwOQkdf?=
 =?us-ascii?Q?R7NKyfc80zj0nXhaeAT8XtaIlH5a4oNfxV/KQxpVJpGUJg8zseWngor0cXec?=
 =?us-ascii?Q?Y4vM41rx7umdmpXyWxClyw4wLj4+16ybCCErZ9Z1bjZ3P9Vv8xbKhTQvV7Rw?=
 =?us-ascii?Q?k0hWaB1X7Tv0jgymxBNFdzagUq0k8ikYyjxvZ6YiqPl7MK5pj98S84GT/4Al?=
 =?us-ascii?Q?iRbxwydxctt67vi0fj+5xOpf4jblhvkz5V6v/sSe5IrAZUD4XSUPRd5Q8xGf?=
 =?us-ascii?Q?Pvd3MsQO+8Q7NIVRg39yRs6u9iv+JU17ry/R89LnqRy6cc8XQDUYIBe4Xcva?=
 =?us-ascii?Q?KjGGXMbWOpkJCefp++T2SLBTvoC8aW4pW2ZDm+BEb5dp79LtVcc78nqyKoc9?=
 =?us-ascii?Q?omcllmf6k0WDhfTLyT1/rQg2WM7bzMMLThdOmon7Rc/KUihOnpGX0GMJMbNx?=
 =?us-ascii?Q?BbaDO7RFLe/ApgZOUZQsBys92WYL/kmeMJhsxiXUE6UnBNmOaZDDqjWm0jE4?=
 =?us-ascii?Q?6Nq6YbYa7uCgAxjIZuTJS8F3rwMtDaOiW/x5INN7U3K+8wCPf3ZwBZnDLG0r?=
 =?us-ascii?Q?qiCUhkdBIHpK+Q5Qhw6IpATNJjbtsz92dVPhngZDeEPs8NRjbkiUY7GXAknk?=
 =?us-ascii?Q?vbsyPdp6+2BvTmfP72Zq1Cn341qWmm4Q0FsFqZyKwXplkwfKGtyjhzvT9YKG?=
 =?us-ascii?Q?wGgBRjXaeh96IrMhngkzcOsj4N6PltvMHyKuiFcd8afizFijvyTr+11RRIH7?=
 =?us-ascii?Q?vtHDV9dXaXh28zFt1Eb0GQwVxxKWcqbKIm64bEzYd7A/+QozzXtH8Ut3dGE2?=
 =?us-ascii?Q?w8KPQekSFwZ6fs/c9oGgGyQVqDL6Iba6l7sXoRgMBvwLVYlY0l59kC4MCifn?=
 =?us-ascii?Q?cPbnf+Qe8pLFJRG83J9hA1iMwbTqS/u8H72v7Oqi4J+AK2hlhIzgEBNqd7xa?=
 =?us-ascii?Q?Fk5VJBateg=3D=3D?=
X-Exchange-RoutingPolicyChecked: b62VwkbXr/86Rw1EUNLGC27wgOTMu7BlVtMCk95lb2MtfGPpZTimu1HKcMgfNEzSpj2K/e+nhM8VWUErG0mUsAlez/WhhzdwrfLWaZ89Ql5uNQ+KReId5wspVoDcu9PB5cYyoaqWvXOF1qKcDrWfSSq8JZTqXsxdH1PUoHIJgV4Aw+JSMwOeeB7zQL925KyKen+LXli5p7ClXDDnbR15tz088sKHLZwHpN03uFqxKnkljeYPAeWS+YTVnLC/I1de0vHGSu1XSyJYF9l5Nknl9sB8bg2RCy2ihXFXPzWkrsmyCblEhKdgkSv91HfiEJhHlHFSy5b1DLqAL0db+o+Q9w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a5f2faf-3aff-4f5e-b9b5-08ded64c993b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7472.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 02:09:21.1133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4+QbIpemj8Br/DYZJFx+6ZAcg5dkirVBtEjG3C/k0BdIluaqljEKm51HK+TB0Q49/vINm65Zu/BxTL0mQDQcEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8081
X-OriginatorOrg: intel.com

On Mon, Jun 29, 2026 at 05:00:02PM -0700, Ackerley Tng wrote:
> >> > The original uAPI did not explicitly define 0 as an invalid uaddr. Whether 0 was
> >> > rejected depended on whether the user mmap()'d address 0. If 0 was a valid
> >> > mapping, populate() could proceed.
> >> >
> >> > commit 2a62345b3052 ("KVM: guest_memfd: GUP source pages prior to populating
> >> > guest memory") changed the behavior though. It would return -EOPNOTSUPP for a 0
> >> > uaddr.
> >> >
> >>
> >> I see, I only looked at this after commit 2a62345b3052.
> >>
> >> > But if a user configures 0 uaddr as valid, writes to it, and then passes 0 as
> >> > source_addr(not from gmem), I'm not sure if it's good for the kernel to silently
> >> > treat 0 uaddr as an identifier for in-place copy from the private PFN in gmem.
> >> >
> >>
> >> I'd say the original uAPI perhaps just didn't document 0 as an
> >> unsupported uaddr. Given that commit 2a62345b3052 already merged, uAPI
> >> was perhaps accidentally changed and no customer complained, I think we
> >> can move forward with 0 as an invalid src_address? I wouldn't think
> >> anyone relies on 0 intentionally being a valid address.
> >>
> >> I could document that, if it helps?
> > What about just documenting that 0 is an unsupported uaddr which will be
> > re-purposed as an indicator to use the target pfn as the source, regardless of
> > whether gmem_in_place_conversion is true? i.e.,
> >
> > if (!src_page)
> > 	src_page = pfn_to_page(pfn);
> >
> > I don't get why the two scenarios should be treated differently:
> > 1. gmem_in_place_conversion==true, shared memory is not from gmem
> > 2. gmem_in_place_conversion==false, shared memory is not from gmem
> >
> > In both case, a 0 uaddr could be mapped to a valid page not from gmem.
> 
> This is true, but this check isn't about whether the page is from gmem.
Hmm. TDX's in-place add does not rely on gmem in-place conversion, which means
when gmem_in_place_conversion==false, TDX's in-place add can still be successful.

Since checking gmem_in_place_conversion==true also can't guarantee the share
memory is from gmem, it makes me feel odd to reject scenario 2 while turning
scenario 1 to in-place add.

> > So why not update the uAPI to handle both cases consistently? :)
> >
> 
> Wait, but before this series, if region.src_address = 0, src_page = NULL
> and that's not supported so it returns -EOPNOTSUPP.
As in our previous discussion, no customer complaining about the previous change
to -EOPNOTSUPP means no one uses 0 uaddr today.

> If that's dropped, then suddenly if region.src_address = 0 and
> !gmem_in_place_conversion, tdx_gmem_post_populate() will now load the
> memory (zeroed) after [1] into the guest? I don't think we want to
> change that behavior.
>
> I could document that 0 is an unsupported uaddr only for TDX, and only
> when gmem_in_place_conversion = false.
>
> Since it is unsupported only when gmem_in_place_conversion = false, the
> check two lines marked with <<==== can't go away?
> 
> 	if (!src_page) {
> 		if (!gmem_in_place_conversion)  <<====
> 			return -EOPNOTSUPP;     <<====
This rejecting scenario 2.

> 		src_page = pfn_to_page(pfn);
This turning scenario 1 to in-place add.

> 	}
> 
> Also, for SNP, src_address == 0 is permitted (and desired, I believe, to
> avoid a pointless kernel memcpy) if the type of population is
> KVM_SEV_SNP_PAGE_TYPE_ZERO.
> 
> >> >> >> getting pfn" patch, ends up with the guest silently having a zero page?
> >> >> >> I think that would be found quite early in userspace VMM testing...
> >>
> >> [...snip...]
> >>
> 
