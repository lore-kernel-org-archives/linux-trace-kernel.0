Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B79339397;
	Tue, 11 Aug 2026 17:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786470438; cv=fail; b=leVurnvVIHDQu7nDENDobhwEN2Uorj5kBP1qea+NBnir7tidn9O2IHyTnnH+PLewUKHucv7TVRpsGjNXrR5A77y4qCfwElGbkc6VRI2uSb0vMWg8z9sqZTwCMj1VFeqccQY5cmJyW6ziOkUlZ7DFsntJXduBTTIsUP7NC5FzAlQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786470438; c=relaxed/simple;
	bh=BAqU+9l9Ly95lBefsXRHuvy9zf/fGgfMzTCPO5ivDwE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UJdPV2+pYWFNioNyjW1IeVxRZgoTwqd3XMVKzKBJwXUhzV7CXe1zgfgqpCbiP7jThfnUg7rDGx4pfs8qViKDHTNUy9c0CfT0PZP01p3RRBLrPj/IV+kVX9Swy4aW7sv2sGB9zlhHZcnWcQk634nj4y02wC5x66igudpxFLjk5EY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jyP2VjFt; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jyP2VjFt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786470436; x=1818006436;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=BAqU+9l9Ly95lBefsXRHuvy9zf/fGgfMzTCPO5ivDwE=;
  b=jyP2VjFtMd1yveGYOoSUs6kdNlP6kj61Mu4jSBJDv5AuxDBqfnGUp+5S
   qM/6v3dCqH+zIGVFWwKSfiX/tHkYVdcOTuB1s79yE3iBkHOo7dIMTOUch
   USw++TCRuUbsiL+hAUHx8dkrX65XFRFHM0WkozHUnszJUHRQcghljTt5t
   34Yd1rVPYMUxxRQjtt5opRguLObNdguqPfwjjPdmlLJBHemR4fG6PGKAD
   ZX7hQo3Ri/Yty7Ovg2q1KK3MKUatKRi4WIrF7/gsOuSoPnXp0WsRu7LCX
   JyoMEQGesj+pzbJX9eiIiRYB2/vCJ0Mc+1zMfkkSWXYbpbWdQPu4pHxJg
   g==;
X-CSE-ConnectionGUID: jLLZ/TaXTYWqkXtfm1Ypdw==
X-CSE-MsgGUID: PV14z/ItSf6i6q+9cB1pBQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="87033147"
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; 
   d="scan'208";a="87033147"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 10:47:13 -0700
X-CSE-ConnectionGUID: zjtG3WMsT+euKQUehtjGZg==
X-CSE-MsgGUID: cEJ5Zu4cQviBT4GflEMWSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; 
   d="scan'208";a="263994024"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 10:47:11 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 11 Aug 2026 10:47:11 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 11 Aug 2026 10:47:11 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.69) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 11 Aug 2026 10:47:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rYbaL3fBqlUtNZd0P8d5YfuIDiqxy9yqO8eQqf/uCQwqUMuiGLnwVhZJFLECGqSOgMZh8wziJW68qtKhljv+6Ds02zzd0hD//6xy5e/r6cjmVg198XhALOYnDWzwmW6t7dF/h6cU+NxGku+87CLBgg5YfjgA9mi38dQfb2Cldxzsijg7SXVuO7p1NnSxGd6VmzOWbsLVEgj5gDyOkAdi0yLijOv4CyLg0M3QIwUedt2Zq4CwFUv6GrG+VV1fGeAfqyNYVyQtnOfjFVVH48jOkXc1jOnOPkqZUH8RDcf4CtGpR+rAF9V07BK3hE52OcCTTtioy0msNoI9ckv6OiGkRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BAqU+9l9Ly95lBefsXRHuvy9zf/fGgfMzTCPO5ivDwE=;
 b=y8SVbnHbPxyQIVyWnVBhlZ+ifRkmv63crBnaHnasVM5S4ON7J6efQnJoXAYwohgP1QXHNvlkdjX/+nLV8a2QhlwbWkBr4XqpehyO9n9RDvpw/FYV1aMAkGrQpzGmbXhpvHWGxITn3XHxsz2EfUbp4c5TG21IgcezsquyFDDSyWlrUZLH2BhsggNncUJ7ze1ScDurHYM6/XYCkcmPTiNSvlB2ipHDPAxQ0kvgWekwrM6gtRXSgjbYk84WbU8jUb+SOdZ9WdvqCP4sSmXzJNFnUzgE3yobXLxHP5IzzYa64T+nq8nQLKsa9WfiNJVtg8Oj4GBZk4f20nd/iGKjBZr+Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by DS0PR11MB7632.namprd11.prod.outlook.com (2603:10b6:8:14f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Tue, 11 Aug
 2026 17:47:04 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0315.011; Tue, 11 Aug 2026
 17:47:04 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "ackerleytng@google.com" <ackerleytng@google.com>, "Zhao, Yan Y"
	<yan.y.zhao@intel.com>
CC: "david@kernel.org" <david@kernel.org>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "steven.price@arm.com" <steven.price@arm.com>,
	"peterx@redhat.com" <peterx@redhat.com>, "x86@kernel.org" <x86@kernel.org>,
	"tabba@google.com" <tabba@google.com>, "linux-trace-kernel@vger.kernel.org"
	<linux-trace-kernel@vger.kernel.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "forkloop@google.com" <forkloop@google.com>,
	"Annapurve, Vishal" <vannapurve@google.com>, "willy@infradead.org"
	<willy@infradead.org>, "tglx@kernel.org" <tglx@kernel.org>,
	"wyihan@google.com" <wyihan@google.com>, "pratyush@kernel.org"
	<pratyush@kernel.org>, "aik@amd.com" <aik@amd.com>, "jmattson@google.com"
	<jmattson@google.com>, "aneesh.kumar@kernel.org" <aneesh.kumar@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>,
	"rientjes@google.com" <rientjes@google.com>, "andrew.jones@linux.dev"
	<andrew.jones@linux.dev>, "chrisl@kernel.org" <chrisl@kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"shakeel.butt@linux.dev" <shakeel.butt@linux.dev>,
	"mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
	"tarunsahu@google.com" <tarunsahu@google.com>, "mhiramat@kernel.org"
	<mhiramat@kernel.org>, "baohua@kernel.org" <baohua@kernel.org>,
	"oupton@kernel.org" <oupton@kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "jhubbard@nvidia.com" <jhubbard@nvidia.com>,
	"jthoughton@google.com" <jthoughton@google.com>, "yuanchu@google.com"
	<yuanchu@google.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"shikemeng@huaweicloud.com" <shikemeng@huaweicloud.com>, "nphamcs@gmail.com"
	<nphamcs@gmail.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "shivankg@amd.com"
	<shivankg@amd.com>, "shuah@kernel.org" <shuah@kernel.org>,
	"youngjun.park@lge.com" <youngjun.park@lge.com>, "kasong@tencent.com"
	<kasong@tencent.com>, "pankaj.gupta@amd.com" <pankaj.gupta@amd.com>,
	"suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
	"chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "vbabka@kernel.org"
	<vbabka@kernel.org>, "weixugc@google.com" <weixugc@google.com>,
	"michael.roth@amd.com" <michael.roth@amd.com>, "rostedt@goodmis.org"
	<rostedt@goodmis.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"qperret@google.com" <qperret@google.com>, "brauner@kernel.org"
	<brauner@kernel.org>, "bp@alien8.de" <bp@alien8.de>, "corbet@lwn.net"
	<corbet@lwn.net>, "baoquan.he@linux.dev" <baoquan.he@linux.dev>,
	"liam@infradead.org" <liam@infradead.org>, "skhan@linuxfoundation.org"
	<skhan@linuxfoundation.org>, "axelrasmussen@google.com"
	<axelrasmussen@google.com>, "kas@kernel.org" <kas@kernel.org>,
	"qi.zheng@linux.dev" <qi.zheng@linux.dev>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>, "seanjc@google.com" <seanjc@google.com>
Subject: Re: [PATCH v10 11/41] KVM: guest_memfd: Ensure pages are not in use
 before conversion
Thread-Topic: [PATCH v10 11/41] KVM: guest_memfd: Ensure pages are not in use
 before conversion
Thread-Index: AQHdJrce/nCTYwCmf0aQh99M4VuIhraTTHOAgAL4owCAAYWZAIAAQqKAgAAUSYCAACrrAIAA1bYAgAAEIoA=
Date: Tue, 11 Aug 2026 17:47:04 +0000
Message-ID: <a71d4fccdffd1f6a12332ddd18fa812542ea2118.camel@intel.com>
References: <20260807-gmem-inplace-conversion-v10-0-2fc18ee6d3ba@google.com>
	 <20260807-gmem-inplace-conversion-v10-11-2fc18ee6d3ba@google.com>
	 <anZ4W9o5pTWIEgMY@yzhao56-desk.sh.intel.com>
	 <anj2bPrGqzZgZWMF@yzhao56-desk.sh.intel.com>
	 <CAEvNRgFzRj_=GVy8T4P8ehhQjYomYxkngzwtKBF0iEL0Cv6fuQ@mail.gmail.com>
	 <anp1I64K0KeyQuyo@yzhao56-desk.sh.intel.com>
	 <CAEvNRgFWcndQKJE_q+ZATFZEMYd=6uRLygozLvg7L77bPX0cEQ@mail.gmail.com>
	 <anqqKH6kuwpvuwp9@yzhao56-desk.sh.intel.com>
	 <CAEvNRgGWDY_fxbyBM-5sMdYMevMe0HzVP9kbC1cCGLE_dV=_Gw@mail.gmail.com>
In-Reply-To: <CAEvNRgGWDY_fxbyBM-5sMdYMevMe0HzVP9kbC1cCGLE_dV=_Gw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|DS0PR11MB7632:EE_
x-ms-office365-filtering-correlation-id: e417a131-6da3-4e39-c74a-08def7d08e59
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014|23010399003|11063799006|18002099003|22082099003|4143699003|56012099006|38070700021|10067099003;
x-microsoft-antispam-message-info: rjYDV0SrYh79DqkipTrzW4zfePjksh89GfSO+A64kyCFjsTSOc2aQPpeRyEB0lcmnZ49DimuvDuSpgoHwFe1JOpwN7tI/T0YGUK+DlcL/QegnJzioDEYOqcbtt6cWz4kQAbJqZub9QhQEatJmEth8fkt/FhrINxPI8g/TU+idisyVs8XGQISrSmH3ys6UeW7PjtnZoca5s6CEYkYOeB3idJs4qS7vriffTPs3/fNMm/kUTv4yIdLG9PYujIblhrCb+5BN5irOeI1JTZI4lqVCSNOjbJay/dEM8jAPNzkQ39sEtgoE7OoSpiMpioQKRq/0la+DWslF7smtxf6aNOEcqS9Z0MxmBStNa4x9FbuqU3KIxyzeIDKDdeD60OdVR6tB3pj8dmqo/0dlv3E6468az/H61nmxSUPiLNlHPFKH7dRUvk4Hd9J6h3mnizCQH4wyK4yc1LpYNrt2w1Ohyc1K3WqRtOkSGQZIvWeYJAN2DMBjOedASnBO8qgX4VfkqRkdZMGLX/YAm3dJmJ+hyPwx56dO8E2u5EQB9DvlkkKLGmvRQqVtBa32miOfRcVm42jL7hI6bmVe0uWZMQ2oqKFUe9xCnxsTBXsUT0Y/1e64USv9TMDcxRkNM6RcPk4dXis6dKDWyr6w9133j4ZGknWrLNOHZUIw5EPd7fEZzrYoUQ+AIt9ylGxSk5MUAxWfzDzxDpe+Vmrm65GCqrxAwPkkw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(23010399003)(11063799006)(18002099003)(22082099003)(4143699003)(56012099006)(38070700021)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dy91MG9qNVk3RUF0dWpFVUk4dDc2UTV5SmJ4NGtjRTcyT0RGOURaWG1ibHgy?=
 =?utf-8?B?OUVjcWhLb0xubGlTR1hncDlyRjZnSlFhMCtDaW1JSFl3ZGVhTXhjN0lxWnVM?=
 =?utf-8?B?QlJtTFB5ZWtnRGJ1bTVVUTRhb3JHdHhDUjF5Ym9Na0hKSHRjbGNhM3FmR2Jv?=
 =?utf-8?B?eGZrK2RSSVJnZXcwYUNMUzdQT2RLMUdrblErRm94VkR1SDliNVgzTlc0UVpU?=
 =?utf-8?B?YURkUjhlN1hDdWhKVlAxaFN5Qk02eEVXVXQ2TzRjUkh5T1lscFE2cU9CT2Rw?=
 =?utf-8?B?eVRUMFZOT0tNdThGbW4zTjU4UDl0WEFNQjlIYnR6b3pXTFAvUmtkdENzbjN0?=
 =?utf-8?B?L2Z4aVBzcjY1QmFNd1lMUU9XNGlNTkovRlh5MllkREFIWXZVcGlBS3NFL2RR?=
 =?utf-8?B?MGhSMEFuQjFCWkxOL0R2cWRWc3dRdk1ad2lvdUg2VFpoeHlwUGxmc0hCeG1n?=
 =?utf-8?B?ZUpFTVZWOXJPb1l2a0tpS2I5RWdQL0cxVzQ1UFV2U2hKVGRjNUllN2lLTG1C?=
 =?utf-8?B?Z2FTZzIyVEc3Tm53K2I3bnA4OFNGbE9nT01KTGhZc3RCUVZvOVJUTExRNEI2?=
 =?utf-8?B?V1QzV0ZZV1ZVcTM2ZmNzNXErbXB0dVFEWVBWUHROWHhRM3ZvOFJITElMNG5J?=
 =?utf-8?B?UXdXcTJDUlBHTkxxWU9NcStxeHJDVk1oSHQ5RWJqcFUyeGFiRmU0d0l0czlj?=
 =?utf-8?B?MnJZNVBaMUdQbDMyYXlwU3B5UFlpc2dmT0c1NWpKMk5ydHJVNU9qUWZ6WXRL?=
 =?utf-8?B?MCtEd2tFM1BweE15N0lzMXBzL0JGNnRTaTJySThNY3VvMTJ5alF4RVorMUpZ?=
 =?utf-8?B?b3JacXNPTXpUWFhUNGw3eWxaRHJkTlc1V0U5OHdDenhJK2E5Lyt5V0RBTUZK?=
 =?utf-8?B?ejZRckJ1cllkQUh1elY5dkZ3VDJxeEdlZllDblVVNGVBTGdBY25RNzhTVnVh?=
 =?utf-8?B?bXZQd3NCNnkzdkY1QTRORXZYa0Jvby91T2VXTlpJSlloZTA0Rm5YMFM0QUhE?=
 =?utf-8?B?NzAwaWs2ejdpVTIxWmdYdGNrME9pb1hpbUFKQWlMT1hZZ3ZnOC81dXNUZSsz?=
 =?utf-8?B?UEdJUXBQK3NkVjYrRnRjMURJOEc3ZmJwYk4wMUljLzBGRVVZR01RRnhOd2dy?=
 =?utf-8?B?V3c1S0hyaEpVaVpDMWRod29OMUFKNXJsWDlKQVZFckt2eFNsTCtpcW9mSWQx?=
 =?utf-8?B?MHRwZVRLbVRnOU1LSDBCZTBkVFYvUmJuazlUUHFLQUtCOHZQYWp2eGhYSVcw?=
 =?utf-8?B?TU9pS01BbXF1VUE0ekEvQldibUZkRUVXemI0RTV5dWtoQmlIVkdLMUdtZzFv?=
 =?utf-8?B?QnRkcEhNcVlQMS9aSXlGMWl1blhHaUEzWGs1Vk1SbE5xdlZnT1hIWUo0NjdP?=
 =?utf-8?B?S080TTQxdGdGSFZiekJwOEZlV3MxR2t5K3hjcjNLU3QraDhKNTdlakdvcjhT?=
 =?utf-8?B?MEdhSVJyOHljcHM3STdBR0oxQ3ZQNThqeWE4ejhXNjNyNlFTcmg1UjlkSWlh?=
 =?utf-8?B?NUlpdW94S3VuMVV3aUZxUjlHOGo3ekNJYTVFcHg5cURRSkFZK0l1Z2YvRURo?=
 =?utf-8?B?aWd3QVFRSXlEeUp1blIyanA0c2hsUjExbTRFYW5seXhxa25zandDS3Q0amdn?=
 =?utf-8?B?SHRoNkNKU0FGTkNmY1lOdUJnSUJqaDBveHVIVVIrS1o1UGdmaEhwVzAzUDIw?=
 =?utf-8?B?dTl0UlQrU0tOa3lrYWFxTllldm4wRFk1N1NvSVFZeFpqbzBoaXpKNlErbGNh?=
 =?utf-8?B?dklwUHBTbFdmOWpRa0pKVXNaQ21OV1FKRm1ZL1crOStnY0dMc3pxdy8zWnpq?=
 =?utf-8?B?N1owMk9OQjdJc0ZMSTBlSTlPblRxV2huNmtieFFvbGM2SFV6NHYrMVI5UUhR?=
 =?utf-8?B?OVVpRUJXVklaeTN5RTZkTU5SVVRwZGczdjBKSFplZ1BVSS8zVXJReVU2M1Ro?=
 =?utf-8?B?d25DeTVmNFdISjhubjZDdFcyR0hkMnpSZ0Z4QTRneHpCQzRoMkhlc24vbXFK?=
 =?utf-8?B?empyeXBPc0d0TTlFUitWWDV0NEs1YUFFRlgrdTVmVE8wdGtBMWd6MG1Ia1Z6?=
 =?utf-8?B?T2QzNW9xajF5ek51akxVZjJveEFwaytCSVJ0b2JiajMyME51bVk5MHJyUVY0?=
 =?utf-8?B?WjY5MzJDaFBMUXdTUmF3TmN6N0Y3YWtDWmpWSEFmazNJcDlvSitXdys0QzBF?=
 =?utf-8?B?U1ZyYkhDVldpaHFQUmllSzh5cmNvRXk4M1phUXFOY1doSWVpZURRM3JiRnNm?=
 =?utf-8?B?a0NJR2hzdE5Sb1U0OW50dEloNTcxaEpZVmtFQldBaEtvdmdxMDZ0a3VIc1or?=
 =?utf-8?B?U3l6R2U0T0Q5NElWblBmVVoxSCtyWGREWnlFZjdRblEwRytBS0FxaU1JWllR?=
 =?utf-8?Q?yzvgSlzcbZohQ15o=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <69C712BAE8C9DB4F8D98EAC53B2928BA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: mN0MH2v9Oy4BNhmPzfeBcvOL7wB2Anfa9H0G3Zw5YK9Im5aarVMOjqox1cI0sup6zyJAHULmQXNbdmiC32xfXKxHCxcqkNE3dJlLtOgqo2oWpBc9z53GDsjWt4FS5w5r/TidSyljyurWCqyNvFx319oRui+6Ho3xlQRuRMEukzykJXO8VMiiY/SeVMKejuzhsqC0wKSpMaBDX+fpGHV+kSV2qXX1ValcOXvoXI6beM4qMgG/IO2XoU3HGKOYraO9g19XGKnX1AL6sAF1Kz+69s8k1MCXn2FK9CJzQ8ED2ExFiDewT4H/o7hCYdnT3xPw7yXG15WPST8i55U3CpWxMg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e417a131-6da3-4e39-c74a-08def7d08e59
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2026 17:47:04.6162
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MRtOWUM8wo3mQGnNdykBk0SHesTN0Dd007io/3+a2+jJfDaQF3DglpCYrNLmDl5YjKVznS6JpNCpMkvdTY3+GNl9dvIjnMIOyzD8crMT8Wg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7632
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI2LTA4LTExIGF0IDEwOjM1IC0wNzAwLCBBY2tlcmxleSBUbmcgd3JvdGU6DQo+
ID4gPiBXb3VsZCBsaWtlIHRvIHNlZSB3aGF0IFNlYW4gdGhpbmtzIG9mIHRoaXMuIEVpdGhlciB3
YXksIGlzIGl0IG9rYXkgdG8NCj4gPiA+IGZvbGxvdyB1cCBhZnRlciBjb252ZXJzaW9ucyBsYW5k
cz8NCj4gPiBMZXQncyBzZWUgd2hhdCBTZWFuIHRoaW5rcyBvZiB0aGlzIDopDQo+ID4gSSByYWlz
ZWQgdGhpcyBiZWNhdXNlIHRoZSBpc3N1ZSB3YXMgZW5jb3VudGVyZWQgYnkgb25lIFREWCdzIHN0
cmVzcw0KPiA+IHNlbGZ0ZXN0Lg0KPiANCj4gV2hpY2ggc3RyZXNzIHNlbGZ0ZXN0IGlzIHRoaXM/
IEkgY2FuIHRyeSBydW5uaW5nIHRoaXMgb24gbXkgc2lkZSB0b28uDQoNCldlIGhhdmUgc29tZSBz
ZWxmdGVzdHMgdGhhdCBhcmUgYnVpbHQgb24gdGhlIGJhc2ljIFREWCBzZWxmdGVzdHMuIE9uZSBq
dXN0DQpoYW1tZXJzIHRoZSBNTVUgc3R1ZmYgd2l0aCBhIGJ1bmNoIG9mIHphcHMgYW5kIGFsc28g
d2VpcmQgc3R1ZmYgZnJvbSB0aGUgZ3Vlc3QuDQpJdCB3YXMgZXZlbnR1YWxseSB0b28gbXVjaCB3
b3JrIHRvIHRyeSB0byBrZWVwIHRoZSBpbnRlcm5hbCBlbmhhbmNlbWVudHMgcmViYXNlZA0Kbmlj
ZWx5IHNvIHdlIGFjdHVhbGx5IGp1c3QgcnVuIGFuIG9sZCBicmFuY2gncyBURFggc2VsZnRlc3Rz
IGFnYWluc3QgbmV3ZXINCmtlcm5lbHMuIFNvIHRoZSBicmFuY2ggaXMgYSBiaXQgb2YgYSBwaWxl
LCBhbmQgbm90IHJlYWxseSBzdWl0YWJsZSBmb3Igc2hhcmluZy4NCldlIHBsYW4gdG8gY2xlYW4g
aXQgYW5kIHVwc3RyZWFtIGl0IHdoZW4gdGhlIHBhdGggY2xlYXJzLiBTbyBpdCB3b3VsZCByZWFs
bHkNCmhlbHAgdG8gZ2V0IHRob3NlIGJhc2ljIG9uZXMgdXBzdHJlYW0uIFdlIHJlbWFpbiBoYXBw
eSB0byBoZWxwLCBzbyBwbGVhc2UgbGV0IHVzDQprbm93Lg0K
