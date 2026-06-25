Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E5719C54E;
	Thu, 25 Jun 2026 02:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782354329; cv=fail; b=jsGEIppwceWzzf77ezXyrCKmAOSYeeRK+cykEO9NkjjmaXBsqlWe/ltC9NFpxjVflgQ+CaTfHmrTG/sfy8Aqa8dkN4+W8J3r0bSZ0Pr72Lvp/BNngHLE3BUKxniO8OWjL+c5Owhx6jYhC1Ju5T4yfn0RiyHzt/xNh8COgKS7tWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782354329; c=relaxed/simple;
	bh=DFRDD1A64LZnj8YqyTPBis38knm5A7y3N+1WJyYFyXo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QToGKgToCJ2SQHZZITTFXWiig8bvSDlS4LfJCBCpJhPTt20EG2smPV00f5T8aCl1YsiOZsIZn0pVnGsxVVaSvdzFxUgmot16A5LjRfUOs42AaYxP9himnyXbgX27QOnuzcLr8qo1FWEz7+kFd+H/EsWkOE5tBWZAjidXQcNe194=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JZDz3AtK; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JZDz3AtK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782354327; x=1813890327;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=DFRDD1A64LZnj8YqyTPBis38knm5A7y3N+1WJyYFyXo=;
  b=JZDz3AtKWIS/RzFj8daFP1KLs2R8XsB5v1I9NAPPf6LuipIFeWvliefl
   RXTtZf4Xxb4OhjpKzp6GMFONVvZvV6C8hbAplvz69fv5G8oIBc/uewfdG
   yyKsWJESoAABcY5mOq0WV1mEtLYwRJUSWNht8CSDwWPbdelLsrcXhUrrb
   jfv5xVzaPJmkMZp0Vc4aOOKFJWZXbzPKQKyiNK0oiSVDE9Z1m/BbW7AUU
   5wbE26PojR9mBQnQtq1KQmyr2Bai1byXf8cJhlddKuLnfxEc0invnZeIe
   ULMfi2SktuHVVRqNN3uCZCHK8Mhneco9NJO0DNTlHjw0WrHPOvOOMRLXT
   Q==;
X-CSE-ConnectionGUID: hND3jhFTTDyOy937BtVBeg==
X-CSE-MsgGUID: c/gunOSFQduM2z3w7yWHuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="83001920"
X-IronPort-AV: E=Sophos;i="6.24,223,1774335600"; 
   d="scan'208";a="83001920"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 19:25:25 -0700
X-CSE-ConnectionGUID: RtB3dPMbTcisDHAPXYItiQ==
X-CSE-MsgGUID: Ml1R05XvSxyALOjqV7EcUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,223,1774335600"; 
   d="scan'208";a="249997157"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 19:25:25 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 24 Jun 2026 19:25:24 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 24 Jun 2026 19:25:24 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.28) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 24 Jun 2026 19:25:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p286uesVRSQUe1Nx5QzotsiX+gIPtQvs4B6tWj4SQ8A6jiN/EWdVsBk+/TJ+VVBolLWjfSjE/Ee/r6Hb54fezhFBdbeoUqENyyR+E8bJcG/Y0ENIxNJn+BpU60wXoJRvgSs9nZaltZ1/KR6G7ajFP0+BCjJ51RdbelfrpXWGjd6LRxyoKJWtdHIexJddn2zOnNVyQgMlxj2Za1FodPDeQldwV1PuszHygHdUYlPNwtjM3mrMd+drmezbF1iDokPUfpDLK1zPVlrhB+N7g5eV2pQFfl6VJ2EBKA50hz4K4I5EBS8B3sr9AQC0cO2lwo3rh4/WuKjc/Wc9R4B6uhD5pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=snlQfOqR/qCQ/kWuXIomS5VXAiIIqv0RdVPIpNsduq4=;
 b=NA+NVPlQrCx3h5FjFOtE5iZKcDIV4/9J9PI2552XpJvKtROEU2T6pf4YS/uAbZchlPUNgLAZ/k/i/AjQ9nsITGJACalh0eTvy8WVq0EoyOjkYoqcClO4unhdCn67Qo2ltH30cAkLxyJbsX9cGA8TCaTIzh0M7OqxS6ruw6ZhUVDW1LmFyDntQo0aQrLwFvNJwjvD7MTWdTwTpFPu/XPZ6qSW+A+Y1Fhz01h6lOc8Yspo7QU0f9HwtYiaFpF35O3nUEWNHhWyxLSAXEF57MeKF1hPGs4NWbhnIz6HmW1ie2FK5jKaKS9eGq5vcLqR7n5POuQ/fv9Y0VivFu1igdI46w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7468.namprd11.prod.outlook.com (2603:10b6:806:329::21)
 by DSVPR11MB9742.namprd11.prod.outlook.com (2603:10b6:8:34c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Thu, 25 Jun
 2026 02:25:22 +0000
Received: from SN7PR11MB7468.namprd11.prod.outlook.com
 ([fe80::c17a:b7fa:6361:dbee]) by SN7PR11MB7468.namprd11.prod.outlook.com
 ([fe80::c17a:b7fa:6361:dbee%7]) with mapi id 15.21.0139.018; Thu, 25 Jun 2026
 02:25:21 +0000
Date: Thu, 25 Jun 2026 10:25:07 +0800
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
Message-ID: <ajyRg3BwGu5dCfOn@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com>
 <20260618-gmem-inplace-conversion-v8-23-9d2959357853@google.com>
 <ajjc0hw8PjGw69e9@yzhao56-desk.sh.intel.com>
 <ajnf5Z9nWZxoLS4x@google.com>
 <ajoWngKaZ+wfIyR+@yzhao56-desk.sh.intel.com>
 <ajpGxu2uQys+S2F8@yzhao56-desk.sh.intel.com>
 <ajxasFBzp_9KnQLq@google.com>
 <CAEvNRgG1nHipzw4=eBgwhvyXi8xYo7FQD_sy9Ax6FDf7YDu3Og@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAEvNRgG1nHipzw4=eBgwhvyXi8xYo7FQD_sy9Ax6FDf7YDu3Og@mail.gmail.com>
X-ClientProxiedBy: SG2P153CA0053.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::22)
 To SN7PR11MB7468.namprd11.prod.outlook.com (2603:10b6:806:329::21)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7468:EE_|DSVPR11MB9742:EE_
X-MS-Office365-Filtering-Correlation-Id: 60ebf2fd-ceb7-42bb-bb48-08ded2610134
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|23010399003|1800799024|5023799004|4143699003|56012099006|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: byCqABCil/qJ5ohxLa8LnWgyOeY2oBmp+/iJyVeINjAbPGjTtS2rlP3SFZzvX7IcShUGRkd6Ko95lDm4Zb7xXSBsHuASMJeVE1W2tf0jDAJD+c1qYRlnM1fJfbR3H56AlmB5HszZpE4gvtti3jx7jmztGfbOFd21owB7c8+D0pRJYkjF+oVTMiUYVvoWbU2ptPkI0PzrmkvB5JXOxd+SgTSXrziXAbEG55yuE3lBAenvGrbSs2PoWB8HxUIrAw7Z1ztxjBXD13GATum5EtGGr7PpMOHr9uYlqdlv2rfd1ULcUwpSJ7TMvWmG/qv0wnOvZD8ssOBjp3sKC4viZLPuSXdyzLEZUulGxdX2JPu67E1Rb6w8nz+eL5E1odmqPE9aJJUJoXorVZX4l1hNPsX7nxhd5nueQukeHyZ0yb37tM+eekmzwvLHZS7OitK/Jo/E2XiFoxZRtO9q7lXF0DOSpxGs0bVymp9QFRU1KtrA4nPi8xEsWHPZiRn9NOartULxu1R4TcVmjVYGAVCaZmLh1z+vwLX6/EajCiQYhtgWqqk4N53PEaEwU5SGVXmJOCAZHmPdOGDAYF4CFXqJuPzPT48vHotsM7KZkzpgZjAn/pyt+dj5u8I/McYbqhkieWdAMgIygSMhiK8MDQM0eTet01hR2dwTbBY/8EVHlPRcNdw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7468.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(23010399003)(1800799024)(5023799004)(4143699003)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UI4TLbnNcHmdUqwnbtZE96GJc95BBfBaHXyznzvkyKjGfJ68KVh4APTw64pl?=
 =?us-ascii?Q?av3Rz2lqsiF2QkCsJlrJWwxR0+zSE4kN7MavtohgXat7uZubHZMq4W6nvAkA?=
 =?us-ascii?Q?s8YYyN+hlvIZQN6P1Y+RA8Qr67FxSzM8MvUBlOgKs+uf0XPNWcguT+0lSxbQ?=
 =?us-ascii?Q?vT+0DNrRp417+buZIdW7zaR3dLY30WxXrftQUOuYqdXIDrqqHYS6SUm9zzEX?=
 =?us-ascii?Q?cE5RAA7dZTTxpNPDisfVFlU8FP0pDNFuMBHfx2Q7GbBfGDK/XUkD0zyRtCL0?=
 =?us-ascii?Q?9UCzgIvnmn54qUQozYq+sBMkA+aIDE9MnYuS9oYWStCq608R+B1ARZ9skKGr?=
 =?us-ascii?Q?S+Wd2S8Ar3QoYGY8rJu8H67r4VOejQNdsu4q9gBgaZ8u7WnzTPr3/vh/ytbF?=
 =?us-ascii?Q?gCE7S6ARmn4Ihi3EUyKWxIliQCoh6POsGnWsUbs+csFVM5HK1hVr2GfBShP/?=
 =?us-ascii?Q?dxsjnUdcgkauduEQpf+F/j/fI5Pxtccjaq8vZwasPGJc9nwsvTi6wfwRI+GV?=
 =?us-ascii?Q?a2spQc4YpKHw0rKoDddMleZLe+EhE6ii+lVETt6mqC+J2p8ZbKfc5bcEic30?=
 =?us-ascii?Q?8dG3Z4Z2BQhmOn522Y0VthF/xdIaPM2nVd3WkYlJrDvDDJj5J/pLwLC1/InZ?=
 =?us-ascii?Q?7XrabP1+XuEoXUOZAlCxW89k1FqE0dDzEbZ0P/GJxfpxb7PFj6fhW4NopvqD?=
 =?us-ascii?Q?YbJN47yai6dzFpuGrImO1DZBNEX2I/ObBOXB5d9QBLj+RtHETpBENZEVJNfa?=
 =?us-ascii?Q?0lyqqCgHtYvf4b8zx8sXVM/3p6oblfXYemHIq0p+2A0dk6nfDsm4zTL/PTob?=
 =?us-ascii?Q?DzmDFrTf4iOsMlibgnPs9NZ/bSQvtF+5rvrrdhg4en1C9wz2SvxpCFFiB+1g?=
 =?us-ascii?Q?+H6YwPlhSB8uSxhlk/a/RtIZuucJGgwOwR+jVGCAnh1Gwe3eCkoGMdUNeDxt?=
 =?us-ascii?Q?2u6jrxICpIzeFbBmyFBfC7wXP44Z+J1ePkimVIdwRb067bwSGbK7BFv9nlEg?=
 =?us-ascii?Q?fIiVFgXDp3iuHdox5x6ykkgxNBJjgBmEicXs2ivYTFpPzhpoiAulFNDZ0RLb?=
 =?us-ascii?Q?T6L2HgnEkjaXxl+15lhKTfGiWi8jkeAsoypumfMPd9i7b8IiE73C96MfODaw?=
 =?us-ascii?Q?a4Qvb2gmNEPqHsqI9/LvlDginUDam8OkS25zRRXEAIh3d5lUIl/9pYlQD+ls?=
 =?us-ascii?Q?4t9g2WPT/wE0aLHe0S4K8WQ7vHPtjMh0J0DNR/04zD6APJGlI+U8CfHFQ1EJ?=
 =?us-ascii?Q?7jIIF2IdhlJqViDoxW27zt9FExLOk0nsSYlP98pT6cyjLRXtCu/uWfX8Fml6?=
 =?us-ascii?Q?6HpqD+ztFpxuGu89SfxkM/ISYvgRtMiB8Z8lYniPOtCfIklmsMqvWDQp9VgB?=
 =?us-ascii?Q?Iq+Z72/x4yPXYx3xbhJmzbmll7TRJkDc82M15+KvyDXCS6/ozmaiNNBtV0tS?=
 =?us-ascii?Q?4pmLEzspCZmy/zCB5+TQ/7FA5OgxlwzfQvUMszxygmXZTd6bGSoqIW9W+QNU?=
 =?us-ascii?Q?cYucAmzA9xqwpqhE6SqXCXVDPf/Z28KbKxohQotiuDT0tvieNUeXqZqkD0QA?=
 =?us-ascii?Q?3IYfbOJgAstFll0XbsnqYkQllpi84L1d6dcUGDCb9HPY6ksgjjBvMJCCk+cS?=
 =?us-ascii?Q?WmNQUbnNUsY0DxIZNe4CRpqfMiWlxAxEofSZE30e9o4yUj/ybn0q6GCOjVsL?=
 =?us-ascii?Q?AT8zdcSAh+za1jIMBRe2oysydyrww+VZI3Gl3EqVpKdyhhPkIwSE4c1Q1gTj?=
 =?us-ascii?Q?WF5f+kX+dw=3D=3D?=
X-Exchange-RoutingPolicyChecked: dXOrOMDenRpEX5DkZtB5aM9Nb6AHdBI4s71j6CHdgE6XyT1cCI1rfKbB48i7+Z2y45Y9rrXZt9VBs2c4Ef8VTqYlgdnkC50A5k9cYdG9pzRDYtxaPaSOKlkikAi7NCVgkz9NfTRZHHM/nU0zTCtf/txGKdMrgEIjX/gTlLzTxtZHoqXiFufXvqei/fNxwyqYovW1gLreV0Fq8B3sE22yhpA4hI9tdAYNAO/ZLW+cKV6G+bQcKOG+XbROTdWJebAQe2o7ULGj40ZYMXFjELobYtS75n25lwAbhRwT1ZiHwggFPX+RdZjQ7yQ05iRVE5/e39WSAuo7lvkVBhUCKBAG0Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 60ebf2fd-ceb7-42bb-bb48-08ded2610134
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7468.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 02:25:21.4518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nome2A68ncNe3d2Q3EtYHn0vryBhn+nqazTRxzvWv8gPixwH8/UeyUp8lal2fPPkpNFDHHevJGHz125E3Po/qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR11MB9742
X-OriginatorOrg: intel.com

On Wed, Jun 24, 2026 at 04:00:32PM -0700, Ackerley Tng wrote:
> Sean Christopherson <seanjc@google.com> writes:
> 
> > On Tue, Jun 23, 2026, Yan Zhao wrote:
> >> On Tue, Jun 23, 2026 at 01:16:14PM +0800, Yan Zhao wrote:
> >> > On Mon, Jun 22, 2026 at 06:22:45PM -0700, Sean Christopherson wrote:
> >> > > On Mon, Jun 22, 2026, Yan Zhao wrote:
> >> > > > On Thu, Jun 18, 2026 at 05:32:00PM -0700, Ackerley Tng via B4 Relay wrote:
> >> > > > > diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> >> > > > > index ffe9d0db58c59..56d10333c61a7 100644
> >> > > > > --- a/arch/x86/kvm/vmx/tdx.c
> >> > > > > +++ b/arch/x86/kvm/vmx/tdx.c
> >> > > > > @@ -3198,8 +3198,12 @@ static int tdx_gmem_post_populate(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
> >> > > > >  	if (KVM_BUG_ON(kvm_tdx->page_add_src, kvm))
> >> > > > >  		return -EIO;
> >> > > > >
> >> > > > > -	if (!src_page)
> >> > > > > -		return -EOPNOTSUPP;
> >> > > > > +	if (!src_page) {
> >> > > > > +		if (!gmem_in_place_conversion)
> >> > > > When userspace turns on gmem_in_place_conversion while creating guest_memfd
> >> > > > without the MMAP flag, the absence of src_page should still be treated as an
> >> > > > error.
> >> > >
> >> > > Why MMAP?
> >> > Hmm, I was showing a scenario that in-place conversion couldn't occur.
> >> > I didn't mean that with the MMAP flag, mmap() and user write must occur.
> >> >
> >> > > Shouldn't this be a general "if (!src_page && !up-to-date)"?  Just
> >> > > because userspace _can_ mmap() the memory doesn't mean userspace _has_ mmap()'d
> >> > > and written memory.  And when write() lands, MMAP wouldn't be necessary to
> >> > > initialize the memory.
> >> > Do you mean using up-to-date flag as below?
> >
> > Yes?  I didn't actually look at the implementation details.
> >
> >> > if (!src_page) {
> >> > 	src_page = pfn_to_page(pfn);
> >> > 	if (!folio_test_uptodate(page_folio(src_page)))
> >> > 		return -EOPNOTSUPP;
> >> > }
> 
> Yan is right that with the earlier patch "Zero page while getting pfn",
> folio_test_uptodate() here will always return true.
> 
> Actually, this is an alternative fix for the issue Sashiko pointed out
> on v7 where userspace can do a populate() (either TDX or SNP) without
> first allocating the page, with src_address == NULL, and leak
> uninitialized memory into the guest.
> 
> Advantage of using the uptodate check in populate: if the host never
> allocates the page, populate doesn't incur zeroing before writing the
> page anyway in populate().
> 
> Disadvantage: Both TDX and SNP will have to implement this uptodate
> check. guest_memfd can't check centrally because for SNP, for a
> PAGE_TYPE_ZERO, !src_page should be allowed with a !uptodate page since
> firmware will zero and there's no leakage of uninitialized host memory?
Another disadvantage: the uptodate flag is per-folio. What if the folio
is only partially initialized by the userspace especially after huge page is
supported?


> >> Another concern with this fix is that:
> >> commit "KVM: guest_memfd: Zero page while getting pfn" [1] always marks the
> >> folio uptodate before reaching post_populate().
> >>
> >> [1] https://lore.kernel.org/all/20260618-gmem-inplace-conversion-v8-21-9d2959357853@google.com/
> >>
> >> > One concern is that TDX now does not much care about the up-to-date flag since
> >> > TDX doesn't rely on the flag to clear pages on conversions.
> >> > I'm not sure if the flag can be reliably checked in this case. e.g.,
> >> > now the whole folio is marked up-to-date even if only part of it is faulted by
> >> > user access.
> >> > Ensuring that the up-to-date flag works correctly with huge page support seems
> >> > to have more effort than introducing a dedicated flag for TDX.
> >> >
> >> > > > Additionally, to properly enable in-place copying for the TDX initial memory
> >> > > > region, userspace must not only specify source_addr to NULL, but also follow
> >> > > > a specific sequence (where steps 1/2/3/7 are required only for in-place copy):
> >> > > > 1. create guest_memfd with MMAP flag
> >> > > > 2. mmap the guest_memfd.
> >> > > > 3. convert the initial memory range to shared.
> >> > > > 4. copy initial content to the source page.
> >> > > > 5. convert the initial memory range to private
> >> > > > 6. invoke ioctl KVM_TDX_INIT_MEM_REGION.
> >> > > > 7. do not unmap the source backend.
> >> > > >
> >> > > > So, would it be reasonable to introduce a dedicated flag that allows userspace
> >> > > > to explicitly opt into the in-place copy functionality? e.g.,
> >> > >
> >> > > Why?  It's userspace's responsibility to get the above right.  If userspace fails
> >> > > to provide a src_page when it doesn't want in-place copy, that's a userspace bug.
> 
> Yan, is your concern that userspace forgot to update the code and
> forgets to provide a src_page, and if we keep the "Zero page while
Yes. Previously, it would be rejected after GUP fails.

> getting pfn" patch, ends up with the guest silently having a zero page?
> I think that would be found quite early in userspace VMM testing...
I actually encountered this during testing this patch.
I update most code path to follow this sequence. However, still some corner ones
for TDVF HOB, which are less obvious and harder to update.
The TD just booted up and hang silently.

> >> > I mean if userspace specifies a NULL source_addr by mistake, it's better for
> >> > kernel to detect this mistake, similar to how it validates whether source_addr
> >> > is PAGE_ALIGNED.
> >
> > The alignment case is different.  If userspace provides an unaligned value, KVM
> > *can't* do what userspace is asking because hardware and thus KVM only supports
> > converting on page boundaries.
> >
> > For a NULL source, KVM can still do what userspace is asking.  Rejecting userspace's
> > request would then be making assumptions about what userspace wants.
> >
> 
> Also, +1 on this, what if userspace, knowing that pages are zeroed on
> allocation, actually wants to rely on that to get a zero page in the guest?
What if 0 uaddr is a valid address? :)

> >> > Since userspace already needs to perform additional steps to enable in-place
> >> > copy, specifying a dedicated flag to indicate that the NULL source_addr is
> >> > intentional seems like a reasonable burden.
> >
> > I don't see how it adds any value.  I wouldn't be at all surprised if most VMMs
> > just wen up with code that does:
> >
> > 	if (in-place) {
> > 		src = NULL;
> > 		flags |= KVM_TDX_IN_PLACE_COPY_INITIAL_MEMORY_REGION;
> > 	}
> 
