Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9A9225788;
	Tue, 30 Jun 2026 02:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782786091; cv=fail; b=Sg4g8L8xugh8S7z3pTD5pPO5QKKmeEFuTW6ebhL507tlHA0j0CviNQr4ZaLqlxvhvoi97bVPn4lYjJIf33cJenQn49mFJtPrZV3/c4k7+ii1eRSN6E3Up2LcArKgtcL1JzodZ7kwH6bW3ubuZuiENaJpsK0o7t9891KOtxW/8ac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782786091; c=relaxed/simple;
	bh=OeXFCOpxuYVdmjKJWctR5cT5Y83hW2sOiocKJmETyw0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fFr5yvOS/F1GQpHhCWpUO+kx3ZkHQC6TpKWgUU6sYWTLucdRMi7Ub3kq3PnWSMYuUjHbs3P56uSnjjEg5M61r8A66BrRgiz+YAQwl4ltoM4N+2MNyfz9r9ZvFbRiVa2X02DDOFp8+c74vq9W22zRMBTgjCogpuYB2FqLQTWSSNw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OEfihwJO; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OEfihwJO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782786090; x=1814322090;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=OeXFCOpxuYVdmjKJWctR5cT5Y83hW2sOiocKJmETyw0=;
  b=OEfihwJO/50BZeieeiMMizGQvm8RDEZkHjWSDdp/1N3EviFxTeFXjIEK
   bQJ6a+vH06g6v5aaHcCKXKOIxC4EeAGnxm0oSX7w0kgZNXb1pKlUB4Yhh
   rVjPksNxSxVBoE9d9j6ycbbIUjhdQft8tvTOedGKN3ndMJG8TcarzNaF0
   Cs2vzA72QiKOvVBGIuV80XDrMxXmQR6Q/XwQYySXbMu8sXxrNfXid44qj
   wkttZVgwZmn21xdjyRgXa8vomjSygoZ2xIb4BeDaJIGLNnG105inQvdd6
   dkZSh88Nd1vONB9+0dm+GqsDcrxQfNQ5ZyzPiSVCH7+mERSg++/80Re0A
   A==;
X-CSE-ConnectionGUID: Y5aExdpPTsGEmfNy1zoByg==
X-CSE-MsgGUID: 7L/q7pozS4KkahFzqygkLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="82602062"
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; 
   d="scan'208";a="82602062"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 19:21:29 -0700
X-CSE-ConnectionGUID: yQmuN8J/QeGCoCoBiJbCEg==
X-CSE-MsgGUID: 1B4GDCdvS/ibCJ/h4w0HrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; 
   d="scan'208";a="254030383"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 19:21:27 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 29 Jun 2026 19:21:26 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 29 Jun 2026 19:21:26 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.63) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 29 Jun 2026 19:21:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wnwIa4zoVRjFX7spqpzQwfbd0MqRWsH9ttSwvgFkUwaOfz9bZMRe2tsL84rvQ6WW9A8o46s4VbjegFPlxK5zgN/tTgD1PzrvUYWilU/skASftUF1jwH6KcK2dU4F3CNqwVAh43MnjwIkps90QfiS8pCWeDejC4TEb7QMb1lv4cUBDzV8a1IHbExtS0yg8DY3TqZaZlgAVVrakgIloIgr6JxJ5eSNnBDxjX61oRFlv7QcAysDn090fe42Ao92PmfCT89jy/Q1aCwdRtQLRXGHr4K26y/RpkQRHMs20eNammxUb5ySjVCg79A1ViMtbBJJ5/P9TEt35HITOIoIKtIMEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r2RjIIIuo9a+iMDxS0z4pQaj1HZQRRRauX+nbGaNtSk=;
 b=sxvLC3uJhK+aKqFMToZ0H4EoqakZVnxylxViwKqG4bTTBEB6Z1xtW5VZKgHZEbo24fXmD3hSf4PEn20L+41fxe/93AuI3+iQnMTxYOZZJ/n+ydvqX+1c9K+BPboaN7qHQu7LZWeHr3Ilf0+DudDrI7/+NKnxoRMJu5r9kdAAIqTWzxPEMmb+mxCIEtjBqVdjAyNDuVMGXz7pVv36uF2PIr4MVaKQO3n9q30oo5nd88cLNb/JV1ebAkeDlkSE+Ty1XbDu/ePA10N7Qg9qzgXGUDdY5Ke3VTJmtWhINk7ITRZDRWz85vR83QS3k6geriu1LFfn+WgZ8F/sTDTd+WHdTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7472.namprd11.prod.outlook.com (2603:10b6:510:28c::12)
 by DM4PR11MB5245.namprd11.prod.outlook.com (2603:10b6:5:388::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.18; Tue, 30 Jun
 2026 02:21:21 +0000
Received: from PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475]) by PH0PR11MB7472.namprd11.prod.outlook.com
 ([fe80::1bad:44dd:4e60:6475%5]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 02:21:21 +0000
Date: Tue, 30 Jun 2026 10:21:10 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Sean Christopherson <seanjc@google.com>
CC: Ackerley Tng <ackerleytng@google.com>, "aik@amd.com" <aik@amd.com>,
	"andrew.jones@linux.dev" <andrew.jones@linux.dev>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, "brauner@kernel.org"
	<brauner@kernel.org>, "chao.p.peng@linux.intel.com"
	<chao.p.peng@linux.intel.com>, "david@kernel.org" <david@kernel.org>,
	"jmattson@google.com" <jmattson@google.com>, "jthoughton@google.com"
	<jthoughton@google.com>, "michael.roth@amd.com" <michael.roth@amd.com>,
	"oupton@kernel.org" <oupton@kernel.org>, "pankaj.gupta@amd.com"
	<pankaj.gupta@amd.com>, "qperret@google.com" <qperret@google.com>,
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "rientjes@google.com"
	<rientjes@google.com>, "shivankg@amd.com" <shivankg@amd.com>,
	"steven.price@arm.com" <steven.price@arm.com>, "tabba@google.com"
	<tabba@google.com>, "willy@infradead.org" <willy@infradead.org>,
	"wyihan@google.com" <wyihan@google.com>, "forkloop@google.com"
	<forkloop@google.com>, "pratyush@kernel.org" <pratyush@kernel.org>,
	"suzuki.poulose@arm.com" <suzuki.poulose@arm.com>, "aneesh.kumar@kernel.org"
	<aneesh.kumar@kernel.org>, "liam@infradead.org" <liam@infradead.org>, "Paolo
 Bonzini" <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, "H. Peter
 Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, "Masami
 Hiramatsu" <mhiramat@kernel.org>, Mathieu Desnoyers
	<mathieu.desnoyers@efficios.com>, Jonathan Corbet <corbet@lwn.net>, "Shuah
 Khan" <skhan@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>, "Annapurve,
 Vishal" <vannapurve@google.com>, Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, Kemeng Shi
	<shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, Barry Song
	<baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie
	<yuanchu@google.com>, Wei Xu <weixugc@google.com>, Youngjun Park
	<youngjun.park@lge.com>, Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt
	<shakeel.butt@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, Baoquan He
	<baoquan.he@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka
	<vbabka@kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>
Subject: Re: [PATCH v8 23/46] KVM: TDX: Make source page optional for
 KVM_TDX_INIT_MEM_REGION
Message-ID: <akMoFqj/8Af2i/Al@yzhao56-desk.sh.intel.com>
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
 <akMPZePBdwQlD74H@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <akMPZePBdwQlD74H@google.com>
X-ClientProxiedBy: PS2PR02CA0029.apcprd02.prod.outlook.com
 (2603:1096:300:59::17) To PH0PR11MB7472.namprd11.prod.outlook.com
 (2603:10b6:510:28c::12)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7472:EE_|DM4PR11MB5245:EE_
X-MS-Office365-Filtering-Correlation-Id: 5618e017-2c11-4a84-4b18-08ded64e4685
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|1800799024|7416014|376014|11063799006|22082099003|18002099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: RaJ2BUiKKzMaA623CrrMKqT4CSSbx3B3DKXpkE+O8HVdh5gQXds/F5HyBA/YJ9z231F0+aKH/JEe7psPcBUuRT91S0ixntUZoXPPuy/mJJ5K3CrxIG0thItMUuncumCH9YL4vq8hoCi5b8EBiPmXNGl+DC/eMa5+Z7GCb6NhHBhVeRuJdo8hFow1Pq8CrxD6Tn+Eg2TjxQ3q3a/NcAeWU2loX37fLpfD6/Q5/9XkpaXWEQnMYw9iMxOqqdogJgLEusvL4DnayfEa7SEOajctjSUbbbMB7EvEPlyq7Ucx4nw3oCO9FngLLuKFWYCu4JlRzIP7QFf0uBb7nWODAggHS1npadtC6VLnfHI0w2mUtX8dzpnruQJ3sAw6/wH8yCTJvCVAaWWfx6NdWrh9bu3r7s3P8y/wJjJt8a/aJ3E/2LB+oBUnVgJDKZVh8To10ux5ZBhax6ab7O8Dp/lcNH0EyXOmFlr9fNPIZunEFs1uPraI4PqKnftzQTSKVHBlPB7+SJFp07qyrQudy9bObqWHw9d1/LBjOdm8buxXhA0TttNPVX8WvUYxZNRbA4/W1KcUYFvcZfTFWe+mSn653iix/GA5c7r0qaJkcVb1ZCVQ67c0ri0hS3YXco/+ZkwNzh2Ou9RS3nmdXbnJMJGh1Y3BNeHYRGwd98X5jsdjHOatnA8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7472.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(11063799006)(22082099003)(18002099003)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OtBL3Ojn+se11+1OLUU3K8ftRCpghdGdnfzL1dTqkvMDXgTz4RiXdMuZn+Pg?=
 =?us-ascii?Q?jHn8fypjSPM3bp5SeMNc89WHaSrvAHGsMengj3dyamR5kcGyDHWebSsaE/qH?=
 =?us-ascii?Q?iij0GJ1zoD5e+ipI3YuqGSebf08NT3nF4z+P9y/8Ie8FI94o/MoZ1a4E9Xu8?=
 =?us-ascii?Q?vV7He6quPvwx9ysWa1lm3n4AZ6S3LcAO3+OzLl+0n2wHF69XPtDXc8ZV5lyd?=
 =?us-ascii?Q?JvcxuK1l7kr5gEqWmLHOEDRKnMf8QtkIMdn5FPMhGRkr/hyPl9BJKlJKOFag?=
 =?us-ascii?Q?6JPxTu6kwhagfgruom18+Zxdn8t6pMn1tOYTKKAoezHVeFKxYLkqDtwF+ThA?=
 =?us-ascii?Q?/yqI5MIwr9V1WKWnjFyx8v6yuTEhJHbVZqF6jLpbD11hcP6tpRVYm8jJ7ssy?=
 =?us-ascii?Q?Dvw1OXrj6J2xPvFLZfUQg8BA9+UTh3mCAsheuSAIQqDIRHtZfAfwaDM83X3I?=
 =?us-ascii?Q?YbXPtUmbbW3Ro4zyfZQR/u8h5EiY8chq+pOgAOX9pErVxe1zdy7ckVndcDVI?=
 =?us-ascii?Q?EQP/BRax/yBBZK/XFFEntMye3mlY8O+s5X08h7lrBjCC+doMUbF3oaD3wk61?=
 =?us-ascii?Q?TFcAQuWTYBhjKIUE+0w/7HTFxCQAai+WWhc5scWU1uUGNry5/wy6S5logjFe?=
 =?us-ascii?Q?1vj1ie5kM5cQKtigBrssMQBE9Q+zS+jG6UBM3aNCgBnjQSl0vH//qEFaJXmS?=
 =?us-ascii?Q?fUumy4JkSVvUFP6lcZ9E/9aXBEq5T6G1uoouH70e7RKjlOhGUWb3Fpql9GTh?=
 =?us-ascii?Q?gi6FxlHn7ky4qUS34SCerNOZKiDPvCSvbycToQdrn0kKXbbZXeVz4nxshMfR?=
 =?us-ascii?Q?GR5G42gGJ0FT8TbLOfbQ3anj3Asoe/4lnpGMIX9RlxpHTB9fbeZ2kq+JgsRw?=
 =?us-ascii?Q?2OPL/yq+EDGc9Syn5wirQQE+wrtpUy2IsjggpYPMnvXnPuE5F/HSNUhni7E/?=
 =?us-ascii?Q?j4P+vtVqK31D69tKm4hMBxMcPmrlS1dqNsuQO56Omv/bn+2qf4fp6ZRJBuFW?=
 =?us-ascii?Q?8DwABSwBDUxT6pCS8hwbECo+GX0kgUxrO1jFY98+XxPS82bvr55Q1eF2GoHB?=
 =?us-ascii?Q?9W9NgGcAgnZmK9BXgfvU84eNI6n+u9BD8Bo5fHSSXUvgo2n8FILJP1iOzu5k?=
 =?us-ascii?Q?TA41TrMJqmwDebK1NUKpost/sB9p2OKXH66YPGYftvOnGCQiVzE1yaNM5aIt?=
 =?us-ascii?Q?rtPTWV5RUHSJMEOg7oL3AYvTt/+UTF3GkJnBmX5HwOmlYF0tBpbFixyIQ609?=
 =?us-ascii?Q?xIQVJU+mbnLZ/Z+DF6wLPeTr21NWfZSUpiy4+HU0vVtROxTpNtcazpD0nfBd?=
 =?us-ascii?Q?VjblrQv0W9tee5PTwjO0KWLl01Pkm4w02S92fIHQuTmLs2P2pdFCkfeakAoT?=
 =?us-ascii?Q?Uh9W8/Kb4dud6sa4OzJ8znyunRhXrCQPa4foUazJu62q3XxcAhPxB/m1x1D+?=
 =?us-ascii?Q?HM3Z1v8fmUdCQmCai+jBoBZbGzXQUAUmplxmqhj711eU4gpMW0faIzr99sp+?=
 =?us-ascii?Q?4LowItEC2n7cknFzaAN6WTN7PbW8aIYjsa/xAVaSKP/Fcodb3n5kKuYJk8yE?=
 =?us-ascii?Q?o5eTZWICOBXegvTppJ9Xa9EObxXf+xByshZnftUhfTLr6frdb0C8VH2bXbw6?=
 =?us-ascii?Q?KQgnBIXHDO9EwqDbMzLSLe03Ez4h3QSpL/TBmKdQjuR1jCmGCGi39onEykV+?=
 =?us-ascii?Q?sFHs6iDer+SFGZcCnqB1tJaOzXPrgRv70rFCuc2/6v1uO29LthKhyaAANsUe?=
 =?us-ascii?Q?ory66W5e4Q=3D=3D?=
X-Exchange-RoutingPolicyChecked: i4zSehp2cGyE/9XTjyMc0iNJhaGVwhqBTcEPF87fHLp/jQlIZ4iBjE9koRWmmApUbt00giHL2lQZP6n2W1woi/aUSwRY4BMkdcU37r6kFi/5WL0q5vbmKj0Snd45TGvh3+fr7r7vPVGUaW6Mun5yP4Yv8LPyc1qdjVF4Pyok2CC176i7Q+QSrmdn7jpC+/pXGScznipB1dBk0k/kmbd3PYEvNv7mscAMLlW8yXjvIPNvsM0/soPHg9vUF/Q9D8Wt0nmsWm+4gH3DpegDv6CjH7FT76fZyXmLqD+Wq6dBem4HLGoYHK3uTI7M7dYr0qElTq0XiFNuSUnxnoHI8OTJKQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5618e017-2c11-4a84-4b18-08ded64e4685
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7472.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 02:21:21.3458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lmB9Fjrp36SKpRzxKOQPH88BWUGNQEL3HOBO67Mgmf7SNoeOoyPUhCQMHLa5SAnAUa28cnfol6HacBqoUF5PPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5245
X-OriginatorOrg: intel.com

On Tue, Jun 30, 2026 at 08:35:49AM +0800, Sean Christopherson wrote:
> Gah, I thought I had sent this out this morning, long before Ackerley's response.
> But I got distracted by a meeting and forgot to get back to this... *sigh*
> 
> Sending what I already wrote, even though there's a lot of overlap with Ackerley's
> mail.
> 
> On Mon, Jun 29, 2026, Yan Zhao wrote:
> > On Fri, Jun 26, 2026 at 08:28:32AM -0700, Ackerley Tng wrote:
> > > Yan Zhao <yan.y.zhao@intel.com> writes:
> > > > But if a user configures 0 uaddr as valid, writes to it, and then passes 0 as
> > > > source_addr(not from gmem), I'm not sure if it's good for the kernel to silently
> > > > treat 0 uaddr as an identifier for in-place copy from the private PFN in gmem.
> > > >
> > > 
> > > I'd say the original uAPI perhaps just didn't document 0 as an
> > > unsupported uaddr. Given that commit 2a62345b3052 already merged, uAPI
> > > was perhaps accidentally changed and no customer complained, I think we
> > > can move forward with 0 as an invalid src_address? I wouldn't think
> > > anyone relies on 0 intentionally being a valid address.
> > > 
> > > I could document that, if it helps?
> > What about just documenting that 0 is an unsupported uaddr which will be
> > re-purposed as an indicator to use the target pfn as the source, regardless of
> > whether gmem_in_place_conversion is true? i.e.,
> > 
> > if (!src_page) 
> > 	src_page = pfn_to_page(pfn);
> 
> Because KVM can't generally use the target page as the source without in-place
> conversion, it's not supported today, and out-of-place conversion is being
> deprecated.
By "out-of-place conversion", do you mean using per-VM memory attribute
conversion?

> > I don't get why the two scenarios should be treated differently:
> > 1. gmem_in_place_conversion==true, shared memory is not from gmem 
> > 2. gmem_in_place_conversion==false, shared memory is not from gmem
> > 
> > In both case, a 0 uaddr could be mapped to a valid page not from gmem.
> 
> That's immaterial.  KVM's ABI (that we're solidifying) is that an address of '0'
> for the source means NULL.  The fact that userspace could have a valid mapping
> at virtual address '0' is irrelevant.
So, I'm wondering if we can document that 0 uaddr could always mean using target
PFN.
i.e., for both scenarios 1 and 2, al long as 0 uaddr is specified, we always
use target PFN as source for in-place add.

> Again, just because something is technically possible doesn't mean it needs to
> be supported by every piece of KVM's uAPI.
> 
> > So why not update the uAPI to handle both cases consistently? :)
> 
> Because retroactively adding support for out-of-place conversion is pointless
> (requires a userspace update for a feature that's being deprecated), KVM can't
> generally support using the source for out-of-place conversion (it's effectively
> an obscure zero-page optimization), and IMO rejecting the out-of-place conversion
> scenario is valuable for KVM developers, e.g. to help newcomers understand what
> exactly is and isn't possible.
Ok. You mean per-VM memory attribute is deprecating, and source page from !gmem
backend is also deprecating, so we don't want to change uAPI for scenarios under
gmem_in_place_conversion==false. Right?

> Side topic, isn't TDX broken if target page has already been added to the TD?
> IIUC, kvm_tdp_mmu_map_private_pfn() will be a glorified nop due to the page
> already having a valid S-EPT mapping, and so KVM will incorrectly allow a double
Not sure if my understand out-of-place conversion correctly.
Given target PFNs and GFNs are not duplicated, what would cause double add? :)

> add.  Ahhh, no, because KVM will return RET_PF_SPURIOUS and
> kvm_tdp_mmu_map_private_pfn() will then return -EIO.
My asking was if we could document uaddr always means using target PFN, since
TDX's in-place add does not rely on gmem in-place conversion.




