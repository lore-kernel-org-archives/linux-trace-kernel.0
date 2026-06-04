Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9522397E8B;
	Thu,  4 Jun 2026 15:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780588124; cv=fail; b=oadFMZUA96AlaxLseg+sbkRD3u1343aiQmNSFG093F00VEmVdbvsTxKsAF/GNCR+HxuvsiT4xAle8b9njYj0fJ7j9Fl62lz4IBe3/N713x7g8HDw03hxSqcCEfnFCuWW5VNEmsur9hKcT2qpVg9a36bMu+H/v11U/nSjqh1Y+oA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780588124; c=relaxed/simple;
	bh=/CCeCN3GyaLpPvD0FC2oZLfB/VDTaXnrXPSH8uYL+sc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EMUgNi4xNkuYA8eirgYPgCYXpC7uDEP4gj+IfX9cLvBzho6gHQBNDKuBsQybuv9XwrBwwncg0ucpLCx3FcbvHG2qJwpf0uWBPyZ1dlSPzz+aCR+sUBVcka/Pth8CscCd+ef5XxZtir8sU4+dykCRyirmhZGwvRp6l91pU1so29c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GFMAOYAQ; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GFMAOYAQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780588121; x=1812124121;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/CCeCN3GyaLpPvD0FC2oZLfB/VDTaXnrXPSH8uYL+sc=;
  b=GFMAOYAQWxxgu3yvOdGUJOb/vAKaX8rSOfJtGQw/uxyU6spkxIf2ynPE
   1Ntpy24YVZmRxbEBbCdsIHJwZw+qwaR3DTY0ohsjDHqroJ9QeoF/B6gSD
   +308GtBXSIXMDRL+qhw3c5K2Uwmn6pFJUMN4W9wM5w9F1UXuGlExdcX9t
   ntw9BDuU2Vz+TGvSNQtbWuJc7Uc2+9LYZGz1fShRD4dP1EIrmpxJS7c2J
   EVhTdBtFJgjXxrMSBbLlnXWvDNqrtqgFuUK/ruTaR+Qo7EuOUUagz2E4G
   Ug/lU3IAWSkItIjEleFicPN1TN9WxgvAGZrUC4s70/Rq181RdP/1iyYoa
   g==;
X-CSE-ConnectionGUID: YargNMABRy2b4ApD16wtyQ==
X-CSE-MsgGUID: MC4/cfXFSnG1qo45+N9/8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="81540286"
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; 
   d="scan'208";a="81540286"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 08:48:11 -0700
X-CSE-ConnectionGUID: d4Y3gbwIT4CZEgEFffs3PQ==
X-CSE-MsgGUID: 3FQ3jQ4lT6KzQPKj670bIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; 
   d="scan'208";a="244436714"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 08:48:11 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 4 Jun 2026 08:48:10 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 4 Jun 2026 08:48:10 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.66) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 4 Jun 2026 08:48:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kpvfzb1A36M0KnnnhTw8b7Z3JyJ6BZZpbRMnE2Q5O87rSSC838vbB828l0MbdxgXbW0On9gJ7ZMV/CYD6caxSEEKhCiwpLt0gba9BT7yi9+uTXcSKE15XA1uGqMdMdpCH3ARQBOgNKQ8wVdP0RHBad4D1Mb7voP4RJi8GlG28/b2gvhToMfNaS4xNGoygx66D3uyI+WTFigvna/lEyKXFR9DrTuBTSIcOPnjU36ZFboxDS0iNGuhyxwi+LnxDH1rbkE/icva3vSCPz31Or0nxYZwBfVrsk/ljVdTsB89B87C0wQMofQdpPogeerhi+hQ/DPKqM6WNcqdmtU6Iq1WoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/CCeCN3GyaLpPvD0FC2oZLfB/VDTaXnrXPSH8uYL+sc=;
 b=jL8cpRKs5o3N9iqy427ftvYzAMlIGWjb65JiUd45tsIcINvV/IQkyMkBxmzfuTFJfPHVqhDb3x6rrY1w1kJCD8p7IIRIcuJ2NUJhO/b6az50IX+U+PrdVbFvrj8kTH6QYACDpwIK29MNmTu9EBmKphrjoIVbmbbDSmujUVQMDwnMZDvglCHyu1QFcRqFQZp2zH/Y+94EQco9jtLIVDHaMJ4Hxtl/LBxyt3n+vaHdI2nwyvMp98b4re7XkTD8d2YIEQLTKGTucUgZRfdFWJ4lVrkZ+N050/bBlaoBVVI8jIeFIlM5waiVxuWL93EzK0lqArKAps36ILDV3OhYQwIKcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by MW6PR11MB8338.namprd11.prod.outlook.com (2603:10b6:303:247::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 15:48:06 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::5670:5b2e:6ecb:dcaf]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::5670:5b2e:6ecb:dcaf%5]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 15:48:06 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Xie Yuanbin <xieyuanbin1@huawei.com>, "david@kernel.org"
	<david@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>, "linmiaohe@huawei.com"
	<linmiaohe@huawei.com>
CC: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	"mchehab+huawei@kernel.org" <mchehab+huawei@kernel.org>, "Luck, Tony"
	<tony.luck@intel.com>, "torvalds@linux-foundation.org"
	<torvalds@linux-foundation.org>, "Lai, Yi1" <yi1.lai@intel.com>
Subject: RE: mm/memory-failure tracepoint change breaks userspace rasdaemon
Thread-Topic: mm/memory-failure tracepoint change breaks userspace rasdaemon
Thread-Index: AdzzWUeryVIHgoWJQJyC7gAz88QdgAABeDAAAAVQ7YAAABfXgAAAOygAAAEtTgAABKiwAAANuYuAAApXpIAADqbrgAAEVXRQ
Date: Thu, 4 Jun 2026 15:48:05 +0000
Message-ID: <CY8PR11MB7134B7F76B242515C05C0FF189102@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <4de75e51-025c-4926-871a-4b9da479cefa@kernel.org>
 <20260604134209.111533-1-xieyuanbin1@huawei.com>
In-Reply-To: <20260604134209.111533-1-xieyuanbin1@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|MW6PR11MB8338:EE_
x-ms-office365-filtering-correlation-id: f9873d02-e28a-4254-cc09-08dec250ab3f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014|38070700021|56012099006|4143699003|11063799006|22082099003|18002099003;
x-microsoft-antispam-message-info: uanOjH9vcxVNZlBu1O0yzhHpuEHBQdVPjC3vChkuJjc0OgrT8Snq9E5YI8geuxhE0PRZqKKBGjfEHMwCeENSVHsppqTjkbCPFSlO+QmwVspAUZPH7QzPqq56URgMJDs6yn4rmIJZKUgbsKAdS//bEdejkqj1GlKuDF8iK8eZlsaSQvKhkiyqjyb3FqWFuXs3GWpWUjhzzNUsV2wUqXLRd0tYly9NZDaP7APoMCXNA8985U+0xEhY0UZyP1c/LFkcJpWk0eDfxo3qSqeF1EcudDOLEkX2SicZP6T12DFPw8vfpCKAeaZFgDEMDH5dryibKwYaIgRXN7c1+C5IssaVa9AJqfsSm2sIc4Z358IODONJcsnpNr1SiyVvO/Cb+xjkN44QJtwQptWT3l1EDybJGyxPSEO6hWUpKp/aZxc0QYpCJzN7CCrXC0z3SUcjo8ivVBbmWQJjUdLSDNHCGOv8gXiOLtJT9MeG9NYueDcHNaPCJfCMI2VcofLQyJRgQFZTT1Yad5rSEtbNTI+/0xyVQ718eu+QUKj8g6o487D7YRH/vrPyhsVbYnptF4aUu7Z9fBC3x3p8r1zwAGnpelCBfgI4ojkPhxTdNilwtYlKw4vas5fp7uniuC2pV54y8KSycnVNvb/2UDdvXTKxtejDiHhNvCNgL+Ip5FbSyuWjxDDv4k+jZ/K1MA+ebofNw8DvIwDHQkTH1Npx/TB1Mi8Kl+mQGHbAICd5WWjmL2UOn4vpjZ8MSLM/Aeh3j+r5kdhy
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(38070700021)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CxMlmh/M4gN2G4+G/PWx/WeXulJ6HIX8AVkaxMKw2RyLvAgS4wJuLTlMSb+9?=
 =?us-ascii?Q?/o4Z28yFGflfyygHTIBLIKshDSMxJWIp8Vphh7szaSP2whpr2xeT9VgFofN3?=
 =?us-ascii?Q?JGH+Ms0xaN4DlTRsLmvTrp4styJOO6Ht+S5fCYyN+Z6o9Rw4e1dXfPv6xb0k?=
 =?us-ascii?Q?g1ekvgfn0ND30eW1m8ItqGG5j3vLacWJQTFXdF/WD6wMSHIUXg4CHFq99ybR?=
 =?us-ascii?Q?3qNmQEkEI6GNAgJrTSqQCEFnxjxQNT9upDy2VRCEaSmB5uVGgm4uIr1JAHIU?=
 =?us-ascii?Q?b8Fv/6geFyBiwDyUJRFDaokaBZd6q5LUYm15Y6ja/A1TVNbC5ttXXSfXXvLS?=
 =?us-ascii?Q?yPRzrvDjJZD7xBV+FEXCbT/3q3rmoba0vRnKWXKGEOcyzoPW49IlUYBgGkkR?=
 =?us-ascii?Q?k2+iPyxaAi7PlIC/23648ivuEnC4T4MdSrX7RAw0Lq5lvcKbPRQzhXzGv7jk?=
 =?us-ascii?Q?zZ64t5nTWqY3RBCa8wOOV20ZrswmNxOPHs/gurEtEqQQxrES/HZD/LCriiFN?=
 =?us-ascii?Q?iP7AmPpxubcQfg7+X8f0jIw6DRz+zvyPEvN2cu/FYNRPuQC6voKdqSMFiNAM?=
 =?us-ascii?Q?0Qz7Sk+4qR0bR15NiUJk7Cigx3WGjxvP0cv0uv3lBNR1uF+liYlej6I3kuBP?=
 =?us-ascii?Q?y9xLW3bRjGbH8RQayMc+5JuqsmquWz7XuUTYJHZ7HP34e94TJa0AF0DZyEpH?=
 =?us-ascii?Q?IB0xYPjxAp+dp4Tz47Nn0L006j+gRusMT9L7ziJpSGpZ9ujNjHbZvTKdkACR?=
 =?us-ascii?Q?kjWAla1O8sp1xv9F3SAQ1vD38lGqkjdL8GMVXXFzYlPsXLU4G/3+Puk3818R?=
 =?us-ascii?Q?ZTZmIQdk8pnK2bn3CWnMMO6a8e1xoz2Tmx76hhaAQTAK8DDEZWI8Abv+VcDP?=
 =?us-ascii?Q?EI78UW41c3b/vaAQqHmwip76X7mu5nrIQgw2wOWB3bsD30ogTrFshMdNxx+e?=
 =?us-ascii?Q?aOpzh45bEzPIj28L+7kzjUFTguFadzrTw7Gqd8h3j8CgckxWjnx5ptL/delu?=
 =?us-ascii?Q?yNh67vVieATDeVShfBSblwyOqIHW5svpTaDMHvmKp58ulbQ0N5n2NBffkqaR?=
 =?us-ascii?Q?+ea+Xb1ODg7Cd/bCruSCBAT+GsMDwQX19sNThmzOS1tDkDG0WiVbTUmz04SZ?=
 =?us-ascii?Q?b0olD0yEBowS713LM/3IHyTuO60slOZ5FJfLP5BPTeuGq8Iy5ixIRGAiGjPd?=
 =?us-ascii?Q?if+HbHn8fjueF8BTJkCUZTqmK23Hd+jT9leXCnx4q27/NGBbjMHrMB6N0DhU?=
 =?us-ascii?Q?qsDo/HwnbLz7cqBuTFc/RZI39OPOMgFJAc0wg/u+FpR9cDyZLMi4gEXARKW4?=
 =?us-ascii?Q?P8lpGNjpO3oWvG9wieRVx1SBPAtzYyQLFmDiHUcRC3gx0nDCgECRYj1mFVON?=
 =?us-ascii?Q?LbCR2kmu+w1Ejmzdo+HritYlgs5S0ZJwItLHPLjTJuDQuUZsopQ2TZfl3GdA?=
 =?us-ascii?Q?rXbfotin6Q4SxVpFRB02s1trnf1J1PMtpZzPcgdLRNCsnWXdkZ2I6ZUDj7Zv?=
 =?us-ascii?Q?f1MvmLLj41YxAAQ3fuShf9Ma04q4jScT6p1y7Lu01liHLRwx8/eP8FfyP5dK?=
 =?us-ascii?Q?yGFtP1GxDxEJkgK4Rat0jMaW3CKCF4Nekxo/Sc4OB+SEhIOZfjc9VewYsFWr?=
 =?us-ascii?Q?oY7yemGvlnt3D8jKY6OfhLVVpiIqk1eZ3asEkx+0yysUC670r6fQJ94qrxhY?=
 =?us-ascii?Q?PgYVp6UBUSkiEgpihdYrqn+xEaLgCueBh8crS1MUk7IHTRbK?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: rMTE7J3BuOnAu3acitnlnnYSoUY4xFcbeO+vQF7YnvGgIACp4LEE+U9WvkuiUOS6Zcv9p8vN1bOtfzjOYWtOE1VOKqhcVJMGRBBSpHXylAzYbfF1jRIZswafBflDH/FoxMljwQxZ5VIxPaZAvVV/us2Ob19+UPWZEKf5Lnmr1stoi/4WaWx6eMQy9/Q70klPwOGZGf6EH/3UvElmM7QxEzY/k5JK0gKFO9Y9ZX4jFIxcoYu98hh2E5pR0SYWWtg04ucLGp+PhXPzVeqAnCy3Dc66asvhUsOeVU84mGC8ad5M62POfmu/XBkXVy5GrAAwAhnQy+ZiLTs3LCl5haJYnA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7134.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9873d02-e28a-4254-cc09-08dec250ab3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2026 15:48:05.9371
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sRe7SSpzcbyWx1IlhGvh+XCTbPQoih+nhmPRwUtJ5XwHbcC8ZL9gKPtVo1IofrZRjXWrx3dHm2NG9RILpHbW/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8338
X-OriginatorOrg: intel.com

> From: Xie Yuanbin <xieyuanbin1@huawei.com>
> Sent: Thursday, June 4, 2026 9:42 PM
> To: david@kernel.org; Zhuo, Qiuxu <qiuxu.zhuo@intel.com>; bp@alien8.de;
> akpm@linux-foundation.org; rostedt@goodmis.org; linmiaohe@huawei.com
> Cc: linux-edac@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> mm@kvack.org; linux-trace-kernel@vger.kernel.org;
> mchehab+huawei@kernel.org; Luck, Tony <tony.luck@intel.com>;
> torvalds@linux-foundation.org; xieyuanbin1@huawei.com; Lai, Yi1
> <yi1.lai@intel.com>
> Subject: Re: mm/memory-failure tracepoint change breaks userspace
> rasdaemon
>=20
> On Thu, 4 Jun 2026 08:42:37 +0200, David Hildenbrand (Arm) wrote:
> > Yeah, if only I had known that we would break user space by changing
> > trace events ... now we know :)
> >
> > Do you have capacity to send a fix?
>=20
> Sure, with pleasure.

Thanks Yuanbin,

When your patch is ready, we can help test it again if needed.

-Qiuxu
