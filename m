Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB4C211A09;
	Tue, 11 Aug 2026 01:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786412744; cv=fail; b=qVcVqpxxVbMzcMIrMqOw5l0EJl2po5z4veUr1IT5jB1/ZKLLxqd6pm6racWAAKL+5bABaaayQubggf4m7jZsvxhOyWpxn+zqVHMQhe+gwgULNIXLOkpxgE9+ycNCfiC4E8fDeaLwrzV1GCgrvLP4Yd5AWkGg7ppt/DMLF7+Y5D8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786412744; c=relaxed/simple;
	bh=Vk4jqTzQDraI6t0s7RESjjy2YDN4x0pRBvWupZelgpg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WN6tEPQqPfYqpWezYn3O7N5D9MVGdTOyuwrm0OEkA/bBN8M50bobe6Qol9X2AlHmoEqi4Ful+2Wj8/kowQq7j0aweBU8KZ8ktOyKfNbAs4w6GjzDqBVhLTGR/mQzPBsyyEceqh7JbTqsY8FID0n37o+0rK2PCWdb+sVxnl8umsM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QG3LAJoy; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QG3LAJoy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786412743; x=1817948743;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=Vk4jqTzQDraI6t0s7RESjjy2YDN4x0pRBvWupZelgpg=;
  b=QG3LAJoyB6g3ip+bmbTV8wAEKyM3cNDdWYHlwq/lmB28IEuXuwF1UN/6
   1l1P4tcmcrPnLEFg6NHlj0o0bJXuRCSEKjXXTkAVpHokmcpt7IpDxBC/S
   NDmIo0Q3xnQE5tfH8SOkeMcBB4U61Tcf0Zf+fHFB+mW3YhjUJkFd9hsey
   J9SWj0+pQf5r2F6H1lHewIcCBm47RgCC/h9a4d3pzW+ZBeMuLVxQJRQdE
   n4TTlNfJVp4NGf5nFC1KhbN1eMpSytexfpd94qZYFH+RzSB/xLdv9mtbH
   84+fVXEV2gxeImFtJsmHOgTBUHZ/OrY3Lph13gl0sRoKiiX7D9k3/UpbG
   w==;
X-CSE-ConnectionGUID: Ra7RDsopTUuPM5aekjNkPw==
X-CSE-MsgGUID: 3DQ21mCfTqylKetpNYU9aA==
X-IronPort-AV: E=McAfee;i="6800,10657,11871"; a="97593461"
X-IronPort-AV: E=Sophos;i="6.25,216,1779174000"; 
   d="scan'208";a="97593461"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 18:45:41 -0700
X-CSE-ConnectionGUID: yMqlqlm0QQi794XfU8DWaw==
X-CSE-MsgGUID: XXFllK7TTOqvmwlQX0+yUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,216,1779174000"; 
   d="scan'208";a="301417033"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 18:45:40 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 10 Aug 2026 18:45:40 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 10 Aug 2026 18:45:40 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.5) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 10 Aug 2026 18:45:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MWblL4jBTSzD0OeMzanoM7nkedaeajFvhacAVso/cA8Ts6LFSf5Too1yLF/6jBb/O6XXsgPwlUkCmSa5qROaVg3TKXxxV4Q/yP59EFdvT+Ri0QhhWalcmJ1gFvLSDD5Jf/8FGMV7WWGrnX+R6ezpJqcz6+M+SiW53ZCoTCxGmn1K30EglDCypKVUIM0MJ+OIkMkLoOCBsQa014U4QgITrVkpPtbvj+H+jDw8jR+fVJE49lACfaOAzPVUFtxMnn/Vx97sE9NHMonP5ky35hJqKYsdCK5lB0yHfJ/C4ITQyqf1UHG4p/ahq4ySGuiHCC8Q0VNhvbQQNRRrXL5TDtpy2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GFA8qpvoI63mkNE28E2NH1z4Wvg234IAeI2eLxfz338=;
 b=WBZTpWIYFilaRGrmLkshg71sUqhQk6KK+JYeI30H++ps3IjIFLLCzgmLsJ2qbmiT2PUbgswcC7iz3nLy3x2n843xCSCBU862UIfADD7DWaAREn673x7F1oU/GdPnwPJmOO0CVIbdu6x9oqncVt5G9wLIesiINXthYaJEsPYTemXUoBVeoOcjMv57VIDI1TE9TVYSRJo3Gb0kndbZHndDqrfWocxkPGYZ4kimdSguzlU2hAMFFyLPUCnOJLNF1jEKC7TgeuA9MxNH1FenRa9DGgRLgjOvdgjNtibRp2ZHUXYvmr/Hstr6JH39eSdsKjj0v4mIpvUhKE8WIFgfS902Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DSVPR11MB9579.namprd11.prod.outlook.com (2603:10b6:8:383::17)
 by MN2PR11MB4597.namprd11.prod.outlook.com (2603:10b6:208:268::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 01:45:36 +0000
Received: from DSVPR11MB9579.namprd11.prod.outlook.com
 ([fe80::ab5f:5d0f:fb90:9d]) by DSVPR11MB9579.namprd11.prod.outlook.com
 ([fe80::ab5f:5d0f:fb90:9d%3]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 01:45:36 +0000
Date: Tue, 11 Aug 2026 09:04:35 +0800
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
	<jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>, Peter Xu
	<peterx@redhat.com>, <tarunsahu@google.com>, Vlastimil Babka
	<vbabka@kernel.org>, <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-coco@lists.linux.dev>
Subject: Re: [PATCH v10 11/41] KVM: guest_memfd: Ensure pages are not in use
 before conversion
Message-ID: <anp1I64K0KeyQuyo@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260807-gmem-inplace-conversion-v10-0-2fc18ee6d3ba@google.com>
 <20260807-gmem-inplace-conversion-v10-11-2fc18ee6d3ba@google.com>
 <anZ4W9o5pTWIEgMY@yzhao56-desk.sh.intel.com>
 <anj2bPrGqzZgZWMF@yzhao56-desk.sh.intel.com>
 <CAEvNRgFzRj_=GVy8T4P8ehhQjYomYxkngzwtKBF0iEL0Cv6fuQ@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAEvNRgFzRj_=GVy8T4P8ehhQjYomYxkngzwtKBF0iEL0Cv6fuQ@mail.gmail.com>
X-ClientProxiedBy: TPYP295CA0053.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:8::10) To DSVPR11MB9579.namprd11.prod.outlook.com
 (2603:10b6:8:383::17)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DSVPR11MB9579:EE_|MN2PR11MB4597:EE_
X-MS-Office365-Filtering-Correlation-Id: 46384afa-28af-4f3c-143a-08def74a3d0f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|23010399003|4143699003|11063799006|56012099006|10067099003|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: f7RngTtbVmbdU9xxL4KQFJ9qLHTFP1j1sUalT1SzqaN4HTGBLLR9DDzr5JKVhWlrqNQgne4vY+SR0ce6KkT5DYXRin8GY4WDhZg4ck6IWCWJR1Mde1sAEO+RyVAHqWRVlZI1P83EXPrwHLd3l1jcNEyMWSwngtB33fztG3yQF5iKeGUCtDWtMWLpaAue/49yimpzrU6AGkJUstIWqMhsq2X3rmysaGW9tBW2ycI0ljoAPO72wFTcL+6ou7IrfxEoGGs2WJQJDIjV5drciZ+NJg5fbwsx9ci7HIvuN4OeS8ReaykTxTEfjg06tVbiHtdg8HRFgGBEpSIPCOtzu1Kt0q6nbxBzxmJUN+f0ILDZgPpha17GOiGnG0KespEbLMABdV2BFUBBWk9Fk80fS2RRmULZ+ajpsYdDVw/iATf7Z09+elvifOkwrOTo/793bi9iDd6uRSkYo1gCAkkl9fEM9hn3OCTIV3t9WA5IS4F6KZPu2T3CLulCSjNpjO73cBFAzVN9zJAT4OTHk93RlAbKWcPJ+dn43xWl/npfES+nIyGOVShajyVAz19ByNmf8Hih0I1JTqSmdUnEuc9tanjy+SDB6/onKbiALM0hjHBWIDw1V3+6D7u88LbGzrmHRydQ2z938zFSvkCuOX1Y+Es7K+rPR961Ex/Uwaqgd0HkVv8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSVPR11MB9579.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(4143699003)(11063799006)(56012099006)(10067099003)(3023799007)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2e1uv3sCvd+hN2uDh+Xoo+qR7mKvKgBX59j5mO32iaoVJYVDUnjBDxux3HQj?=
 =?us-ascii?Q?zTj9r4ckjEvyAuyJ5crZwn2fcG4yrKRPqRhV7gzp+E+vf7qTnn06NIzqOR2f?=
 =?us-ascii?Q?J35tNKMNwFWeI/MHtlz1MM7UlCk2J/Cr3xRupHk4IsdO+Nj9OJqp8mIy2AIx?=
 =?us-ascii?Q?z9xKGIaj4Ic+BNQYe82nD6wB8TzNc0/Jd54ZMBIzCvBVKJSz2XiCQfJgIKOx?=
 =?us-ascii?Q?JObZRr/SNnQ+kkM5tOGAP8y1HdVEGe3u//Km2HuQujctgZrZ967MOScMIM4/?=
 =?us-ascii?Q?wqhSmJ1DKpXkHyzkXFZlVyM28GZRJ2UThrsyZRCrUCsrSybQaVAAgfJknQM1?=
 =?us-ascii?Q?svCEogeS2LPSa1qKeXOstx1+eI0rkVXNP1isrzAVE6qMXBQIHXjMOKjQeMo+?=
 =?us-ascii?Q?CZgfmgpRUiLtSnf4GN3f9Y4tT7mMXvPC3N8cZY85lJw5wNQ93HdrmixLJqHZ?=
 =?us-ascii?Q?O6ikyeZhbXX+nEg4JlOPUIKB0aHTUbIHqVP8PnmWpN/jJrqpkEELtHgi07I5?=
 =?us-ascii?Q?7MUDYHSpbkBoaNlXiNa5JKI2tkJFq8FAJKy6lTbjpKdNJG51wGYVPT7TFKAB?=
 =?us-ascii?Q?G7DCTujvTvRQ7iJGSzN2XlBY6WNG/pJ64eXLUHAHELRLW8faBG7ACB3Nm7CZ?=
 =?us-ascii?Q?ZTqWF21R/75H1VlOovoJAlF1coAxBGQQUizfORFuIlHPLU0C67y17ikJ5UH/?=
 =?us-ascii?Q?2rAN6CmbmwRCjnFIZnI/8fQ1kjoxFUrKaJ5LAFwLflgJKfMMb2L5HL5TssQb?=
 =?us-ascii?Q?Pb6mkxw6xOvJohdoAUoG8oXFEfcUXEAw3uAi1BjzRRhgIahHStOqlJZqUA0/?=
 =?us-ascii?Q?fwD5yBqsRmNlqKDlWpTlLo16dyI9icGv+kbSfHPp6Re2UVmMCLvnHF3fa9CT?=
 =?us-ascii?Q?84MST9RfSavOjScT5lAowYj2dXB2Ao5Y06kdw2AOCOiLr2K77cPbEOKFyqHN?=
 =?us-ascii?Q?5e3woIx6gEf9sIh8fVj/SJuEBfiRTm85ps3NSmpu8PhWAMIZQjbvbXvVOpOs?=
 =?us-ascii?Q?R8EuG5ietAPHBLGT4AVNhML+B/HbeYiKxhzwUrDaleIzAun33eaOna2euLLY?=
 =?us-ascii?Q?p4UvGTGyiOpevlut1xdxe5IRd0kr+i84HWjGIfhg5i5GUbomNwhk7aFfUV35?=
 =?us-ascii?Q?pNvFsbadz1q443RDeU1I4wIDLsGFMcsWBRyiCl0VcgiavkiUUiMzOsXFhTep?=
 =?us-ascii?Q?uxxayV7404xukQIzXh25buBFfn0CsDsj2H8Knce6t/wdZWXakDUVNJtp7+7a?=
 =?us-ascii?Q?Qwh/GyYGQ8NBQ04bJdrYHh9miYA7RPWOehoQ22xGZVyaJ4GEQGwV3lN1t6iP?=
 =?us-ascii?Q?zvwWtCyQVyPzpqUdp82myAdzbCELBFXj88AsYHogCBBQvlDuckI0BRWfqKJH?=
 =?us-ascii?Q?FFBrFHavp5oanl7Kwp9nIbbKudJdCJRNrpfpYVbIziHEWUsZXk7H8D/dIeVM?=
 =?us-ascii?Q?cmst/J7cwzKuu7aOovKBDuqQ5uAuo5Yg0lIDSDhg0u4nVoG3Wp+3Vh8FMDxn?=
 =?us-ascii?Q?JRzTFomXP8wFFLHFdQwrUdhq/YMU4ildTlM2RB143vzJWaeQ72+JKHs5eUN9?=
 =?us-ascii?Q?8rLef2a8ECjkHPJdU6dv4x9TLmHefkGMO1st85a2woPjmKJ71CCHXumfsBUM?=
 =?us-ascii?Q?HDRwB30pDVEBYrT0ydyeOgQGCoLZOHi2NPzUZGMFgZqcnG9mYRexcF04nMJG?=
 =?us-ascii?Q?V/38xVtAaxW6JhZ8nZoqrdvW9AonvVam8wXJAqWtO+weC7Gb3Tr5fvEWOOXV?=
 =?us-ascii?Q?8Ik0cDxXJQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: IouCrL5FmnLxL+YdDKwK4U23q298Tx95wBGecIQ5GXRDIplMyOwmsytd55CP+G5qcVh6UHPrUza5BIfsT/wP9j5i6GIsr7FGU7aF7bW+NSZ4md3Qxu/mfzzHHinVjSrKMGH/SeYDKrR1rW1SROoopGsJqrSDks5W/HajjXjbH+TF0zI1hklZATZHmNRb9nw+wZOajMemmc3rYA6egKREX/OuJdFRMOaBd5c7+hXup3wflLXlb/OIaulj6Tx/x8GbjXcctpMuHFhNfUVVZoyE3q5rerzEHq/uXC4PwsBi2thHbFJimmD/RP/TkqffKXy63zXxrzTchKwCzOvcczhwlA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 46384afa-28af-4f3c-143a-08def74a3d0f
X-MS-Exchange-CrossTenant-AuthSource: DSVPR11MB9579.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 01:45:35.8439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o/AlaNQypf8Q6bmyg8ikUt9p7BPeUrw+KZA02M5WvK1z+jHC83IViJr28dsfdVMVwdsrBoR3wgM7TH+z64363g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4597
X-OriginatorOrg: intel.com

On Mon, Aug 10, 2026 at 02:06:06PM -0700, Ackerley Tng wrote:
> Yan Zhao <yan.y.zhao@intel.com> writes:
> 
> >
> > [...snip...]
> >
> >> > @@ -542,8 +576,21 @@ static int __kvm_gmem_set_attributes(struct inode *inode, pgoff_t start,
> >> >
> >> >  	mas_init(&mas, mt, start);
> >> >  	r = kvm_gmem_mas_preallocate(&mas, attrs, start, nr_pages);
> >> > -	if (r)
> >> > +	if (r) {
> >> > +		*err_index = start;
> >> >  		goto out;
> >> > +	}
> >> > +
> >> > +	if (to_private) {
> >> > +		unmap_mapping_pages(mapping, start, nr_pages, false);
> >> > +
> >> > +		if (!kvm_gmem_is_safe_for_conversion(inode, start, nr_pages,
> >> > +						     err_index)) {
> >> Note: conversion failures could occur if another vCPU is attempting to map a GFN
> >> within this range.
> >>
> >> CPU 0 (setting attributes)          CPU 1 (attempting to map)
> >> --------------------------          --------------------
> >>                                  A: mmu_invalidate_retry_gfn_unsafe
> >>                                     filemap_invalidate_lock_shared
> >>                                     __kvm_gmem_get_pfn ==> folio refcount++
> >>                                     filemap_invalidate_unlock_shared
> >>
> >> filemap_invalidate_lock
> >> filemap_get_folios
> >> check folio_ref_count(folio) ==> Not match !!
> >> filemap_invalidate_unlock
> >>
> >>                                  B: read_lock(&vcpu->kvm->mmu_lock);
> >>                                     is_page_fault_stale
> >>                                     kvm_mmu_finish_page_fault ==>folio recount--
> >> 				    read_unlock(&vcpu->kvm->mmu_lock);
> >>
> >>
> 
> Thanks for reporting this!
> 
> >> Retrying in kvm_gmem_is_safe_for_conversion() or moving the invocation of
> >> kvm_mmu_invalidate_start() + kvm_mmu_invalidate_range_add() to an earlier
> >> position does not help as long as CPU 1 stays at stage A.
> >>
> 
> IIUC CPU 1 isn't blocked by a conversion so stages A and B should
> complete fine, and CPU 0 would already be retrying for other reasons
> anyway, like speculative refcounts from elsewhere in the kernel, so the
> conversion would take longer but it'd work out.
> 
> Is that understanding right, that this doesn't completely break
> conversions?
It depends on the timing. The max retry count cannot be expected under unlucky
conditions.

> >> So, should we avoid this failure?
> >> e.g., by moving filemap_invalidate_unlock_shared() from stage A to after
> >> stage B?
> 
> Not really sure about this, how will control go back to guest_memfd
> after the fault finishes for guest_memfd to unlock the filemap?
I don't understand your question. But I find this solution is less ideal than my
below proposal.

> > Or what about having KVM always treat gmem page as non-refcounted, and have
> > kvm_gmem_get_pfn() put folio refcount before releasing the filemap invalidate
> > lock?
> > Below patch is applied and tested at the end of this series.
> >
> > From 8c2f29bc15bceb6a8fa103cf2585ec11354fd74e Mon Sep 17 00:00:00 2001
> > From: Yan Zhao <yan.y.zhao@intel.com>
> > Date: Mon, 10 Aug 2026 06:24:52 +0800
> > Subject: [PATCH] KVM: guest_memfd: Return gmem page as non-refcounted
> >
> > Have kvm_gmem_get_pfn() put gmem page refcount before releasing filemap
> > invalidate lock and return the gmem page as non-refcounted. This avoids
> > gmem memory attribute conversion failure caused by temporarily holding gmem
> > page after faulting and before completing mapping.
> >
> > guest_memfd always holds gmem page in filemap cache. TDX does not increment
> > gmem page refcount when having gmem pages mapped in S-EPT. Additionally,
> > as gmem pages are not swappable, setting dirty or accessed bit is not
> > necessary. Therefore, there's no need to treat gmem pages as refcounted
> > pages.
> >
> > Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
> > ---
> >  virt/kvm/guest_memfd.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> >
> > diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> > index 2115e73e455a..e357b4ffa777 100644
> > --- a/virt/kvm/guest_memfd.c
> > +++ b/virt/kvm/guest_memfd.c
> > @@ -1332,11 +1332,10 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
> >  #endif
> >
> >  	folio_unlock(folio);
> > +	folio_put(folio);
> >
> >  	if (!r)
> > -		*page = folio_file_page(folio, index);
> > -	else
> > -		folio_put(folio);
> > +		*page = NULL;
> >
> >  out:
> >  	filemap_invalidate_unlock_shared(file_inode(file)->i_mapping);
> > --
> > 2.43.2
> 
> Hmm going with the above CPU 0 and 1 illustration, if instead CPU 0
> truncates the folio and the folio ends up being freed, then KVM's MMU
> has a pointer to a page that is already
> freed. kvm_release_faultin_page() is passed the pointer to this page and
> will dereference the page.
Not really. It's just like KVM mapping non-refcounted pages.
kvm_release_faultin_page() does not access the non-refcounted pages. 
The invalidate protocol also ensures no mapping of stale pfn.

As below, if CPU 0 truncates the folio, it needs to hold filemap invalidate lock,
add KVM mmu invalidate range, hold mmu_lock, zap KVM mappings before the
truncation.


CPU 0                                      CPU 1
-----                                    --------
                                         Save fault->mmu_seq

                                     B1. filemap_invalidate_lock_shared
                                         __kvm_gmem_get_pfn
                                         folio_put
                                         filemap_invalidate_unlock_shared

				     B2. read_lock
                                         is_page_fault_stale

                                     B3. kvm_tdp_mmu_map
                                     B4. kvm_mmu_finish_page_fault   
                                         read_unlock
A1. filemap_invalidate_lock
    kvm_gmem_invalidate_start
    
A2. write_lock
    zap KVM MMU
    write_unlock
    truncate
    
A3. kvm_gmem_invalidate_end
    filemap_invalidate_unlock


A1 occurs either before or after B1.
1) If A1 occurs before B1, B1 will find the correct pfn.
2) If A1 occurs after B1 and before B2,
   a. if A2 is before B2, B2 must find the fault is stale, so it's fine.
   b. if A2 is after B2, A2 must be after B4 as well. So, accessing stale pfn
      in CPU 1 is fine.
3) If A1 occurs after B2 and before B3,
4) If A1 occurs after B3 and before B4,
5) If A1 occurs after B4,
   A2 must be after B4 (for 3-5 conditions).
   So, accessing stale pfn in CPU 1 is fine.
