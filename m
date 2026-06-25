Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD62F36A364;
	Thu, 25 Jun 2026 01:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782350516; cv=fail; b=MOmik61GSO5IRvnn8tPWv8mjzdxkw6jJ6O9wcF2hN8NfnVa2oDAVtAujY7UyhiBpBKtFpV/VCHYJ6ShK5l+4eznPnvFqm0cqhgdBJIoNCItCbYJJv7B12qdOGQ6HMJ0s4jrkQ/n4mUkztgGGAdf5/Z5jU6Ebq/fQTSUTFMKjDYg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782350516; c=relaxed/simple;
	bh=JUPl/lonhMVopPN1anxgGnqraQDyswtTJltSGWom5GI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nYS7qy2uLCIm+x6PFd0764gEBY5+OmvpTFgoZ0zbLrekkW/lV01AsGTC/UFnbiEtWYSMILZtA/9W85KdKsumNCLYw5zXA7n2dQy1Rf7Sir5JlqfjX8wulxdZq1VrbI5QwMoYZtj19YOsdspc2yg8y3xa+naqk41wiqTMlpYBtd4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BiYYrvD+; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BiYYrvD+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782350514; x=1813886514;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=JUPl/lonhMVopPN1anxgGnqraQDyswtTJltSGWom5GI=;
  b=BiYYrvD+t48H/IovlonqLnQVg8PrAhllVrPDTnfO6kClGzPVsuaJ+cnF
   q/SN0eG2i4FzTa+PjPr1ksoWBLz94hYzsbSBiByYyoOajq1RZgjH4CRgz
   HppMY0/zTcWDR/BT396Iqj1VQw2fAc9QNjibEXWogrTEjfK9sfwMF0cs2
   C4Q4VVpN/pS+Kxr/dMSKWe5WjLyt3es8PkqdRmvallmk2J9XYEjmaMvAV
   EeMsKQ6djqsLeJoqbIghpEx036wTC1WvyrM9UvyxZwvSG7eubeyO6HUAT
   0Q4E5+h7GN6nOfnYFsgcdvTKZkBKd5s0dxTY78jSExdPiJ4s+t9VfBIhf
   g==;
X-CSE-ConnectionGUID: NQOoY7jaRf6Rb69BME3+mw==
X-CSE-MsgGUID: m/IO3XsjT7i0XWNLvLApEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="86802280"
X-IronPort-AV: E=Sophos;i="6.24,223,1774335600"; 
   d="scan'208";a="86802280"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 18:21:52 -0700
X-CSE-ConnectionGUID: CpGS90JZQQKEv5ThtTjh3g==
X-CSE-MsgGUID: MdmjTuguRhKgwZ1HHC+wmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,223,1774335600"; 
   d="scan'208";a="249256022"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 18:21:53 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 24 Jun 2026 18:21:51 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 24 Jun 2026 18:21:51 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.20) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 24 Jun 2026 18:21:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iuul2ska7ITZoWb62ahDiY/bDr65aquUVG2Qc3VjWh90jBsk8AadsTj8ScM0h0VpEXDconIDFoTaAxmXr0gXuCYHLIIr3PVs1J5I9cgOu0BAH9lj5eebCxXyqlgSOtB9vDdQsy39MEPGNfpE5T6TLJtistjR95jjIIN+GJB0LRw7tusyiObd/mMRGEa94gVVrBN+5ndUSAeXwbcWnuIkkFh2Ijle7jWzt/PY5Zil/iCgiR0keSbKwaDGhj4iGp5fAV1VraLVRvnA9HA3UfyFqt8eYQ5qpkNZT2oSL9AIQQ2ci22dsUqlsifMXq9y6r71XolzS+XJL0lb+LUY7EFOPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z7PqDqL3q6cC8iMDYNhSqhahbCYYzb+Za+ugS7TZrm8=;
 b=LlxVzMpfnd0Sv7BCU9oqfjy6/xOWXYs9wujHQ+cqiJN7dA8HrtNr+vE8V0Wi2qZ8CsjZjRBiVn7gxUvp4qs6TZzQDosxw6Kb7hf90pVVadhaXU3Q5QmQKme9q/2C2JzrOZKL7LhPy1mQlEA4oODRx8MHS/DBoDy9PkD2a7qeSXZAbO2IKS06T/qnMJRkMsy6kivz+4TXr8dy2mNJs6jskEXdaxKUtjfrhDshe1FtJJjksfRrze1QAqL7T1M2Z3kkhcaDPNbHuxIWXRnNMZ89NGUEyDF6YhkqZCcqILKa8G0KCDeyBOSqxthK+PXE3+87lIr5YR74RAsHoYyjBCZpPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7468.namprd11.prod.outlook.com (2603:10b6:806:329::21)
 by SA1PR11MB9825.namprd11.prod.outlook.com (2603:10b6:806:4d7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.14; Thu, 25 Jun
 2026 01:21:48 +0000
Received: from SN7PR11MB7468.namprd11.prod.outlook.com
 ([fe80::c17a:b7fa:6361:dbee]) by SN7PR11MB7468.namprd11.prod.outlook.com
 ([fe80::c17a:b7fa:6361:dbee%7]) with mapi id 15.21.0139.018; Thu, 25 Jun 2026
 01:21:48 +0000
Date: Thu, 25 Jun 2026 09:21:35 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Ackerley Tng <ackerleytng@google.com>
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
Subject: Re: [PATCH v8 24/46] KVM: guest_memfd: Make in-place conversion the
 default
Message-ID: <ajyCn0PnFtQK+Nka@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com>
 <20260618-gmem-inplace-conversion-v8-24-9d2959357853@google.com>
 <aji/2svhcc84rn5w@yzhao56-desk.sh.intel.com>
 <CAEvNRgHYTFnHbsLLgMTCSitmnp1_j9Pomikm9qmpGTh1w8YE5Q@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAEvNRgHYTFnHbsLLgMTCSitmnp1_j9Pomikm9qmpGTh1w8YE5Q@mail.gmail.com>
X-ClientProxiedBy: KUZPR06CA0014.apcprd06.prod.outlook.com
 (2603:1096:d10:30::10) To SN7PR11MB7468.namprd11.prod.outlook.com
 (2603:10b6:806:329::21)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7468:EE_|SA1PR11MB9825:EE_
X-MS-Office365-Filtering-Correlation-Id: a2207427-c5f4-4870-ce3b-08ded2582081
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: It9pnsPv6YWWQranJJmCRpA9hWqQhkdh1mJCuj2BZt2KIa+qoPBQaPNnrRBMT4hb7RmrBzpNHmpN55K2F/puvLwq2iXPIEuLvDrJm2a3GbV1PKFUqu8u9C2jLGt0zlWQ0LpZNVHkfwQsCM+PStZ11Nxas45RYaVvS6xnO7lsZybGrN5/ChPhUA2RD0BPn6ClT0w8ZEP0pXhZuxgyitZd/GmaDwUZg6ZTMIDXazRo95ofO6k9ID2Eh8gIBlKFAmYFLWXiBQaXAgQAcBKvM+LFFM1fEw/S6/2Ud3P/DbU7n3cAg3kI2cmmD9R6tEbE1fdUSSZ/XiFMrAQGAXZMGkjFnKnGll85sic0RFRja8XLT52tuvj175ZXB+llWqG+bGd7bK2G5nMwvO2v8KDvttzgh9TqTxhF3vBBIt3mCBK7B/GmDC3Fbb6y0+RQmoEY3WFjBrfvGM1vgVEbqiEDGkU/2WLvBDy5G94tGJIQq3q6ALJjwDyk5IwlaMUhfEF6sPyicN1eH/KyEUu0sWvq6QfvpQ0bv7pHJO+6Ym0fMIPEmcbq7MdEijXZCQc0N3J91L+V4nyBiaKRnzxMUl3ifn5AFKCT1vX/eHhjCgWVuyQX2O6xcdujUh7pQZMOnj9UpLhVDe84FpQxbA22Dmjy1GfNIslpCIYNDUGK5Za6WoLwNcI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7468.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sghNwSRR4rNLZZLC49dVCB0KqlixIydFTqdBKGqYNnNZ1WgZOs4f8HRzmfAU?=
 =?us-ascii?Q?v63GgvDu9bNF47qI0v3jFfEVoWHD4n25A5LyeJSn66IYIc0/e1JfdqO/Cj4L?=
 =?us-ascii?Q?xkTVAyJ3IlDMZBw+ymU2XvvzqIUL/p5qn6cW1zCXVPCo3pGPYQdflDekrvQJ?=
 =?us-ascii?Q?7ttBGcwbsbMW5g36QDHUyPOgQ4xgSrciVQN6pkFRungGkGmrmnzzz3Ia3CtL?=
 =?us-ascii?Q?nBZTtoSOUMjpNnETmIpqA81qrhroVnlYXqmaENba5iB9CDWzplXCas050eGP?=
 =?us-ascii?Q?3ij5lmqDXIi7tXRdyTy1hTHXuT9QjOA2Ien5BBJYUeHdA54rStY1VxtZORIG?=
 =?us-ascii?Q?CF071zk8hegSvUOTfmPAMuOGhCobMjLs5te7dFLoQSGYsxsG7zgVP/+8G+/H?=
 =?us-ascii?Q?nMPM8tl5It8V9wzuWkiSoQaUhssHb2kTgE5VGNEnxV3KkhkQ5QRZwhh2LT7X?=
 =?us-ascii?Q?eNPsemscEUACJJ0RdHW2kuUaPsp5hpNeQhQzhliD2cvHvIsVK3N7oausxGuj?=
 =?us-ascii?Q?THAvFS7L7H0rq/UwmpiF+B5QZ61B1fMTSZN3WVUW2Gw+bdeYt+kH4hOzh7Nv?=
 =?us-ascii?Q?SUvCrhxgq8wRpwUAKo3MLdPq85NLMeOpuS4C2jUDThVHBjWooDbtqfb9tgVM?=
 =?us-ascii?Q?adQJAqTNcQ9KTi5SsHPzubOwVnjFxTjUaSqBU3zkZh/+9JgE3Elhn1qauBI3?=
 =?us-ascii?Q?h0KI/W56GeBbr4+QEHS1VyZ51RDWNwS6/382PatZhUhbO3tdRa/4m+o878Ol?=
 =?us-ascii?Q?mC3e4e+nS9RbSyYJCUHqUqKUQh3IveUMBGUAak4BLinGVMnAgXd1k9RmigDU?=
 =?us-ascii?Q?eapwFJUFVe3WwK/LpXLNg5unXe2QXWn/EbpWaycLiamFqejYT0RDyggmtvI5?=
 =?us-ascii?Q?ZW6uq72h/dzQIKoaZYMVWS5WW/TQRnAp1yS5GvjmhzuSkVxPmOSt+O/nmKuk?=
 =?us-ascii?Q?ttYpgutpA8sE4OKValAlTAKUg3Q9s86puI0GGsLK3QqOarbMcyvMcrJUSHzi?=
 =?us-ascii?Q?SWKGDM3mX/sHI7r1FvVUITzj0s0Vn7/P+dHkj072h7QZg/QyzyfJ+kQBunsd?=
 =?us-ascii?Q?SdGfbZEO8YgYtItNPFviGp1x5N81tA91mnBrwklVIx78dKNxziWY2K7Jm+of?=
 =?us-ascii?Q?bW2LPygvzSbGspV4XDTYhSGZLSQHEx2mW/EoTfZDALWSw9WBb2QoGjE4K3JM?=
 =?us-ascii?Q?Gk190vnin936QoWNb489fJD8Ar2pqczU/tWtobjxUbPO+t+JFP3HNoEg1HAD?=
 =?us-ascii?Q?Y5hTsvGQWtfNH6UO/Nv/hVkDeNkgBU9T1QKVnoc6lyi9aQiUqxxn1h03aJrt?=
 =?us-ascii?Q?zxdttk64fAMDRP9Tx/uy2s33uigEQrchCaaR16rvC/gEtcJYzFPvV4fxQs5q?=
 =?us-ascii?Q?bFqoK7+nUQCjhKiIhklfpqzoBqBfTuYucWNIs5sdW0xjbJjBoMJ3keBKEeVZ?=
 =?us-ascii?Q?wNdSEZ9sNU8h3T9KNl+bEIPN8xfPOVpCiWLcsZfLhWX27Ei0VbEP64CMQiSb?=
 =?us-ascii?Q?LTfDL92LfqzcqFID7atgr2Lh/1JUgUMUg59pDjQuVz5F2QDqkADDnG4L0u7X?=
 =?us-ascii?Q?DfkknqjTEUijvkMU3ZblLnYHEVPebOgCqrRXqfKYHr803urkeVOasjHS2njg?=
 =?us-ascii?Q?Y4y9LocEaTVG5coRbTEv0ibe66VLvjG9XyaX5Im47SB8RiTM+X8tZsWzX/ml?=
 =?us-ascii?Q?BK1bv0ZxXblRz8LTalpsgJaYLtrnv2rF0bExQ+p1av2figg94/mZk4/TQD0r?=
 =?us-ascii?Q?YCA8p6/Huw=3D=3D?=
X-Exchange-RoutingPolicyChecked: PXilt8OgSuUejZRxTFUFI7KVmpgBtrakM8nc67wa2KdxpEaFrHqcYaEN8wk6vpinJP6rNsjkJaFKNG4JTlf8iwMWKL3XR+9qhKvYICFx0/Cx7bz5HDEEh7agPcZiL7gBz7poLPzSuKXfLLZsxiT5EJXKOHoQfcgreQm+4R8B66kKb6a57jXn9BUrMiYofBXBpjau4haom3XXbbENHsGHrWtNplOtnImMtgSAMsy00hXLcEy4Avz6kGjmVTzrxGAbWQsZ32ngk81N4VKtsXfemU85s7pGm9SjcxGUqXrVa9cs29g77iTXGDBMd8lcUqEmBX1XfAcx9G4zsSDMa63r+A==
X-MS-Exchange-CrossTenant-Network-Message-Id: a2207427-c5f4-4870-ce3b-08ded2582081
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7468.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 01:21:48.2554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zTUbI2yk+s15UoVc2CCzrx07BstD3rGlb5Bw+8ALRaBODx9cTlz52yqHSKj6ImTKUDvLhk3pyOTP7enAATk6JA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB9825
X-OriginatorOrg: intel.com

On Wed, Jun 24, 2026 at 05:05:44PM -0700, Ackerley Tng wrote:
> Yan Zhao <yan.y.zhao@intel.com> writes:
> 
> >
> > [...snip...]
> >
> >>
> >>  #ifdef kvm_arch_has_private_mem
> >> -bool __ro_after_init gmem_in_place_conversion = false;
> >> +bool __ro_after_init gmem_in_place_conversion = !IS_ENABLED(CONFIG_KVM_VM_MEMORY_ATTRIBUTES);
> >> +module_param(gmem_in_place_conversion, bool, 0444);
> >
> > With gmem_in_place_conversion=true, userspace can create guest_memfd without the
> > MMAP flag. In such cases, shared memory is allocated from different backends.
> > This means this module parameter only enables per-gmem memory attribute and does
> > not guarantee that gmem in-place conversion will actually occur.
> >
> > To avoid confusion, could we rename this module parameter to something more
> > accurate, such as gmem_memory_attribute?
> >
> 
> I asked Sean about this after getting some fixes off list. Sean said
> gmem_in_place_conversion is named for a host admin to use, and something
> like gmem_memory_attributes is too much implementation details for the
> admin.
Thanks for this background.

Some more context on why I'm asking:

Currently, I'm testing TDX huge pages with the following two gmem components:
1. The gmem memory attribute in this gmem in-place conversion v8.
2. The gmem 2MB from buddy allocator. (for development/testing only). 

The gmem 2MB from buddy allocator allocates 2MB folios from buddy for private
memory, while shared memory is allocated from a different backend.
(To avoid fragmentation, only private mappings are split during private-to-shared
conversions. In this approach, the 2MB folios are always retained in the gmem
inode filemap cache without splitting.)

Since shared memory is not allocated from gmem, there're no in-place conversions.
The reason I'm using "gmem memory attribute" is that the per-VM attribute is
being deprecated, as suggested by Sean [1].

Besides my current usage, there may be other scenarios where gmem memory
attributes is preferred without allocating shared memory from gmem.
(e.g., PAGE.ADD from a temp extra shared source memory).

For such use cases, I'm concerns that the admins may find it confusing if they
enable gmem_in_place_conversion but still observe extra memory consumptions for
shared memory.

[1] https://lore.kernel.org/kvm/aWmEegVP_A613WIr@google.com/

> Sean, would you reconsider since Yan also asked? If the admin compiled
> the kernel knowing what CONFIG_KVM_VM_MEMORY_ATTRIBUTES means, then the
> admin would also be able to use a param like gmem_memory_attributes?
> 
> There's the additional benefit that the similar naming aids in
> understanding for both the admin and software engineers.
> 
> Either way, in the next revision, I'll also add this documentation for
> this module_param:
> 
>   Setting the module parameter gmem_in_place_conversion to true will
>   enable the KVM_SET_MEMORY_ATTRIBUTES2 guest_memfd ioctl and disables
>   the KVM_SET_MEMORY_ATTRIBUTES VM ioctl. If gmem_in_place_conversion is
>   true, the private/shared attribute will be tracked per-guest_memfd
>   instead of per-VM.
> 
> Let me know what y'all think of the wording!
> 
> >>
> >> [...snip...]
> >>
