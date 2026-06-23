Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E942E364038;
	Tue, 23 Jun 2026 09:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782207427; cv=fail; b=QLa45EFO2YV/zwv7Z9UzCRZw5/GtqwS5FauN4LXtGd16lDrGGJRN48N3C70JBXy1pOfNDO+PZq/yxu5wdrCkW5W3wMdLgomjuFWH9jnTE77MUhwryjEc4J/7IUG1QSDZO5Q8jMz4MvLLrg87lPDMv4gpOM+jj2W2NSeql5I2a5U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782207427; c=relaxed/simple;
	bh=w9gsqYkHRKC3iQ1IFwJCsXt8CNWdv0cQsm1uIi9/AuQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=F3o97sPC+gMEA0sODl4wRsnV3Rj1oUWrgnrAKi0ybkYjZMxo5fY1ml7Ij2eNs5lOEc92nyXXE9ib/XfrkrN6yqXVLdtSwNmzzNuBHDSpWLPtYBses7SHqcf0HKhMAOQ8yOtT4MmEwsVuhtIxo0S6RkzM1+NtzCKL0pFymcAOYdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XF+W7PmV; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XF+W7PmV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782207424; x=1813743424;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=w9gsqYkHRKC3iQ1IFwJCsXt8CNWdv0cQsm1uIi9/AuQ=;
  b=XF+W7PmVpwFMi1sLxq27qsB+V7AVbqPxnzHlx1nuwlNwxdAcVZcaxoD5
   UG/TqRpVV1IlYb5XONkgToH+74R3zQ3LliExD2hhozdyK/G6A3coULkzU
   5rFuR0by/Uq6GqSHbXSQ2HlvRwWuBgLyLYzCqQuCZKnTNMEtGxI0ihy7y
   Z/OiBwj9cZ4XqF4sKPPsFk7MinXbMYxBTMXH50+R/jzLapDZuKZmh3hF4
   rF02g1TEO9+BTOCpeFL1atk58Bac5eZ+JSZ49Nyw4QF7KEhFRRkg1IvQ7
   tXb6oyYAv9sW4daN7EPDI26XKSWNR2hEz7DHPgePsOvH+ji99RLq14CI/
   w==;
X-CSE-ConnectionGUID: ihAzSrqqRsqXdS5NswZ/8w==
X-CSE-MsgGUID: LgflV5o0SUa0u+B5z7/DqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11825"; a="82715229"
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="82715229"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 02:37:03 -0700
X-CSE-ConnectionGUID: odrnfocOQneCgK33pzsG8Q==
X-CSE-MsgGUID: xCRqn9deRdeB1LQnULk+yQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="249596334"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 02:37:03 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 23 Jun 2026 02:37:01 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 23 Jun 2026 02:37:01 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.40) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 23 Jun 2026 02:36:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qUI++/eYTfx2LgAyt/cOWvRAgdAtT6+RClndN3fpCvL43HLTC9QzYWM9JEOW1tqHoceOUjahUKTCDvepAYnCp9vrQUvf6wVM0+Eh60k9biCJph+7o9wFV5DUebjT7VdvT3rhQommxlr7aLKOQvdr7zXA9r6nqFkfrzjrBwG8ooCERoZ/ZK0WkVcY5Uw810djGGgSvGH8gjY44l1sIozhK3uBuG1VE2xaMDTY7CSS8AjhXetfKRyh5mNV9T7Q2w035AzxK1ohg83HyJ4GNhuFF9m8Fu4aslJIO2bG7UYhyzSEZk+yD4K9Avkf0cejajyQo5thSo7XDDhaoG8LAgLT3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N36YJxrq/pqkl+F6vHiK/rEIVd+MlDD4D1qLh6QGIvM=;
 b=SbJCxyRKMeoU/jtRH8BNXSAHaCWmMQRitsl5fS/KBBgq/s2WslR9Zz4zNJz8gbcqfbR13GBHccC8oSgO00RGZvMkiQW67P5Ancv4E5qzW8ts35OpQf1f7YM5wkNatZ1o8kGat1Gg15XHxXI59u+1h4fVENEzZuUGhERJfb11QaBT0nCvWRtBxyGLh615LGlaKnfkobQesOwQjhm0PWb6jAAEFct6FycjId3eYJsyZ5I94nN406IIE2aRAJ62012qnhz2C6q6+vYXPC489mbKDmEyPmeTvYi0ZRKfs5rveiJo/Stby3uLbcAo5O0uaO1o0jtM9p0Prz2kl8FgSE5nsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7472.namprd11.prod.outlook.com (2603:10b6:510:28c::12)
 by MW6PR11MB8310.namprd11.prod.outlook.com (2603:10b6:303:249::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 09:36:48 +0000
Received: from PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475]) by PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475%5]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 09:36:47 +0000
Date: Tue, 23 Jun 2026 16:56:11 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: <ackerleytng@google.com>
CC: <aik@amd.com>, <andrew.jones@linux.dev>, <binbin.wu@linux.intel.com>,
	<brauner@kernel.org>, <chao.p.peng@linux.intel.com>, <david@kernel.org>,
	<jmattson@google.com>, <jthoughton@google.com>, <michael.roth@amd.com>,
	<oupton@kernel.org>, <pankaj.gupta@amd.com>, <qperret@google.com>,
	<rick.p.edgecombe@intel.com>, <rientjes@google.com>, <shivankg@amd.com>,
	<steven.price@arm.com>, <tabba@google.com>, <willy@infradead.org>,
	<wyihan@google.com>, <forkloop@google.com>, <pratyush@kernel.org>,
	<suzuki.poulose@arm.com>, <aneesh.kumar@kernel.org>, <liam@infradead.org>,
	Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, "Borislav
 Petkov" <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt
	<rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, "Mathieu
 Desnoyers" <mathieu.desnoyers@efficios.com>, Jonathan Corbet
	<corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Shuah Khan
	<shuah@kernel.org>, "Vishal Annapurve" <vannapurve@google.com>, Andrew Morton
	<akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, Kairui Song
	<kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham
	<nphamcs@gmail.com>, Barry Song <baohua@kernel.org>, Axel Rasmussen
	<axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, Wei Xu
	<weixugc@google.com>, Youngjun Park <youngjun.park@lge.com>, Qi Zheng
	<qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, Kiryl Shutsemau
	<kas@kernel.org>, Baoquan He <baoquan.he@linux.dev>, Jason Gunthorpe
	<jgg@ziepe.ca>, Vlastimil Babka <vbabka@kernel.org>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-coco@lists.linux.dev>
Subject: Re: [PATCH v8 21/46] KVM: guest_memfd: Zero page while getting pfn
Message-ID: <ajpKK/SyRh8LExrY@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com>
 <20260618-gmem-inplace-conversion-v8-21-9d2959357853@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260618-gmem-inplace-conversion-v8-21-9d2959357853@google.com>
X-ClientProxiedBy: SI2PR02CA0051.apcprd02.prod.outlook.com
 (2603:1096:4:196::10) To PH0PR11MB7472.namprd11.prod.outlook.com
 (2603:10b6:510:28c::12)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7472:EE_|MW6PR11MB8310:EE_
X-MS-Office365-Filtering-Correlation-Id: 13a42760-4109-407b-42ae-08ded10af22f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|1800799024|366016|7416014|376014|18002099003|22082099003|56012099006|11063799006|6133799003|4143699003;
X-Microsoft-Antispam-Message-Info: v3gpyL5SrEagXq1P+h4Xe39sjlFzyAPqJvD2AbkKJp5kWA4J5PpJlpsgJ2Xdzehq6CQ9ohNqGq3LYeKONcNb4sBVqkwih0yU0uu5UbImWO8IIw8EGCj3VP0IAsH04j9sGzxE7cnsV5wihBXC1HcTH5nH55YzaVjzISm1nymBJlCbukY3Hfjdnv/1GtJij2BuRsJhjFm6GunE6OcJjWhCg2Jh9E87RyuLxFTvWSTryvS7uLGjQveUFsbjYXO9Q5NPNm0y0k7Shj2XdqwS7NCLPawSgVvTrrU+7eu4b0C4ZAq3iys2llY/x9Qa5eGBcxUg8rdqp5jMpieJtC/OWWLVgfLq2z/VrO07uqyV3jKXpQobnITYZ7Y6CQUm3yj2zsf4ru0KdlhpkQ7/wC/FD4HfKKip5PWc86o48J2DoFyyk5zss3nrTxrRuiGrmjqBsECu+iP91qEVDl0N2cImd8CHH3pEWU1jmKIqWFQfDP3ldvXFCo/v171a4E6qhhhnuiBuRZRBlQ+Tr7OL51S99tl1DQ5qNWTTYa2Hg4C268NyKDx5gtz6WQJyj0tvDhlnCxcCw1ZIWBV3j+WgYPGohYaoIqBFUcPHBOk9jZbbKu/4umPB8Nt9ZQgUCpsLh/vXZirQp1TbQhNljN/kdWr7/KMo6W5HnhRr34Iu725nu7Tll+Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7472.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(7416014)(376014)(18002099003)(22082099003)(56012099006)(11063799006)(6133799003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+XDljrb+utMyi1D81OPvXLZadXE67DK09IkHgHvfH34v7so4lIal1RigLFrq?=
 =?us-ascii?Q?wuUlN4bB3W8HbZzFdMSlVnlc1oBz/uQAXID6UaztlD2CweSzZw68VJtMOclh?=
 =?us-ascii?Q?+XPf4AU9f907z7AobNGVyKmkluMgvaTyVPmKYLbgLSdZy2nZNulhi9Mv8HRh?=
 =?us-ascii?Q?IckagmCcpizLKWHnTfXSG6vrCNPblAxt8BISsZaCL5Kn4QcDCb3qeivPk8NA?=
 =?us-ascii?Q?bZu3SNTgH9XY5TpUvz3N0EFgi0RutPPKXD/3Idjh4ZqZLWGKkRPGFSw72kJX?=
 =?us-ascii?Q?Ew2dBMyDnleA2+55YRjMUxeJ9yu/i3neBCE8XrzYfx3MDmWPeWQrZ7okjJyI?=
 =?us-ascii?Q?Lxcs1EfUApwMWEmHraCKZGVwP+vw61XSCs3OwIvYFy9wOVNpKHpO73vMRnKj?=
 =?us-ascii?Q?SJGPaen/G7zQ/5Dv+Wgdy54W+dgW/CmeTpTZdyEz6n3igqRShw+pjQH+LhPA?=
 =?us-ascii?Q?UDeGkBDkgfW7f8rJ0MqK0ogVKXzLO3Twzj1tgOAPTAzsuv/7xxDZdaRKGoAr?=
 =?us-ascii?Q?PjHjLJU1FG/s6pfyaAfKmNbtlGty79F/lGVo5eehmDYaE+4RMcACoQkPOAnp?=
 =?us-ascii?Q?mNduKktpKglJz/uRfLiZ2BM3sxHV7i2Ddld3pv5bCWGO51qlGT/rlbTOa8Zo?=
 =?us-ascii?Q?XVho3dCj6K2l5UrKZh42Y/37rMJLwNRqwrequ5JL7wcfzHImtb6Z8HOwtq9B?=
 =?us-ascii?Q?4j4ryjQc5Evh6wZDGXCpeWHfEmqYDdDU3hKNNIgmceCLP47OWuRyg1bT5/Wd?=
 =?us-ascii?Q?ioVnpRq7dUe4EmzEKWhUSXEu5lJoyDzEhOPzyY84ob4lZ5bD4tnPQIHUimWJ?=
 =?us-ascii?Q?VlHo8eo37XYg24OU/BKZ+xQqaXQ7sd4KWk+ZIZkIAq5qFe1Up22l7C8o/nKT?=
 =?us-ascii?Q?N8T34krKw6u1poRjvpKL9mGt+PlIkodO+kGdWZLvawXDZp3gdMPzMMoNLTIm?=
 =?us-ascii?Q?Gd1M4hjbDSAmmcf6UgDuAipTqcx204IazVCQ5/9cJZ+I/eFJI3XYNuwHQizi?=
 =?us-ascii?Q?V53xwtA1tAlGrmGQCRN42bL5PHrEfCCREqhKlJxoOZPZIZ+0lB1JaMIraVDE?=
 =?us-ascii?Q?LzesSY/O8q0jCmb0qLaWPaonUW4ns8OSeZ1jppHi0jPev5KpJVojFNM7nyam?=
 =?us-ascii?Q?bk0uLeJ/gprbnSBft36tu+mGuccpBHn1NNcpagtqfrSiVecHSTSmLn1aA2gX?=
 =?us-ascii?Q?eIkEZp238e9I50bbl8V7U31Xvx2a5eJnwwY4Y5dkjknRgys3ksupFNSb2wJp?=
 =?us-ascii?Q?bYQPv0Oc/RjVR81qhh2BakzQatkqmTtabrWcexHhfz76rDkkxiXN3P4yO/a5?=
 =?us-ascii?Q?QIyscK/VqQ9qwOP+1jKkftq524twGj34tI8srPfnP8wv0WpT186TkZ7WpBKx?=
 =?us-ascii?Q?TX4YABgcHqw/6VlyDrh/W6TFEuFCcCN+4BBCDdlIDMRpr+y1R/Wgx+NX+NtH?=
 =?us-ascii?Q?w2E8nQ2FpRz4kKp4DJx7Jsik2X9zRT7Czvwxx1tucSTGGvhecairjFIuANyo?=
 =?us-ascii?Q?6J5e/sW0JWZbxHRg6/srPTGSwAXAt1+B6WCOMrT/sJCcguSX5ZvFjqai6ATH?=
 =?us-ascii?Q?moVWtfcwrpBDt6vPdh6Wkio0NjRBABptrSUkkB5W7ct9e78mqvc7ua8mOscF?=
 =?us-ascii?Q?YdDOJRp4Oz19dcSOJjYssBef9rS5nGJbNXgPMt16Kd53MDM8qteaTW6jjysJ?=
 =?us-ascii?Q?AR+EjQ44hZcMF6KMDa2J8/tqXRWeBCDXDHFtivWu87xSGv/1MjssHxY0JlzV?=
 =?us-ascii?Q?gZ/l9uPrrQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: Rn4hdcAfMOVa4++ET9g4a3HnFZdM6KdTh1AXfJ4msG6MAoY5X7H/V7kRzCugl91dbyFd7ZOr7ELhZeHUzX5f/YGP4uAQUMtInDHs66W1wWoIZQdtUyBBpcGZUFgdFeUdJAqoIkfaNp9aQJ38ESp7YXgRUwSXxDwErFqWOJbWqsTSrQGMc5q3Y0fIq/SjVN4DdnS3UDzkg7uDQWEl0hrouWtOi+hAgcaHm1UTWBwtZN3uywooR1oC40sFkar83E7DRXuwJ7zGgcfifuygdEg4X8RmIUMySwzPeyLI94GEPtuPdZJech6xGguNNwh1o+J3UTDiOd7AhxSk8NutYPIRlQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 13a42760-4109-407b-42ae-08ded10af22f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7472.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 09:36:47.7220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uXXnWr/WIvRRNqEsJ02vayC0aK6UkogonKdi+2mbAYF4NK0QkAsXo8MBaiKEUBNNGgRXZVKJnUvU/Cjx5mxhJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8310
X-OriginatorOrg: intel.com

On Thu, Jun 18, 2026 at 05:31:58PM -0700, Ackerley Tng via B4 Relay wrote:
> From: Ackerley Tng <ackerleytng@google.com>
> 
> Move the folio initialization logic from kvm_gmem_get_pfn() into
> __kvm_gmem_get_pfn() to also zero pages if the page is to be used in
> kvm_gmem_populate().
> 
> With in-place conversion, the existing data in a guest_memfd page can be
> populated into guest memory through platform-specific ioctls.
> 
> Without first zeroing the page obtained using __kvm_gmem_get_pfn(), it
> might contain uninitialized host memory, which would leak to the guest if
> the populate completes.
> 
> guest_memfd pages are zeroed at most once in the page's entire lifetime
> with guest_memfd, and that is tracked using the uptodate flag.
> 
> Zeroing the page in __kvm_gmem_get_pfn() is chosen over zeroing in
> kvm_gmem_get_folio() since other flows, such as a future write() syscall,
> can get a page, write to the page and then set page uptodate without
> zeroing.
> 
> This aligns with the concept of zeroing before first use - the other place
> where zeroing happens is in kvm_gmem_fault_user_mapping().
> 
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> ---
>  virt/kvm/guest_memfd.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index 90bc1a26512b6..86c9f5b0863cb 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -1137,6 +1137,11 @@ static struct folio *__kvm_gmem_get_pfn(struct file *file,
>  		return ERR_PTR(-EHWPOISON);
>  	}
>  
> +	if (!folio_test_uptodate(folio)) {
> +		clear_highpage(folio_page(folio, 0));
> +		folio_mark_uptodate(folio);
> +	}
Note:
In the __kvm_gmem_populate() path, this folio_mark_uptodate() call makes the
later one after post_populate() pointless.

__kvm_gmem_populate
    |1.__kvm_gmem_get_pfn
    |     |->folio = kvm_gmem_get_folio()
    |     |  if (!folio_test_uptodate(folio))
    |     |     folio_mark_uptodate(folio);
    |2. ret = post_populate()
    |3. if (!ret)
    |       folio_mark_uptodate(folio);

>  	*pfn = folio_file_pfn(folio, index);
>  	if (max_order)
>  		*max_order = 0;
> @@ -1166,11 +1171,6 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
>  		goto out;
>  	}
>  
> -	if (!folio_test_uptodate(folio)) {
> -		clear_highpage(folio_page(folio, 0));
> -		folio_mark_uptodate(folio);
> -	}
> -
>  	if (kvm_gmem_is_private_mem(inode, index))
>  		r = kvm_gmem_prepare_folio(kvm, slot, gfn, folio);
>  
>

