Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C2C3F483E;
	Fri,  5 Jun 2026 13:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780664948; cv=fail; b=J3SmDM835+y9A/HvM+/m568Do+86AFA6aPdmzb+GHrfCTJLGw32U3psXe0zDVBHFHzOfK54ZBrUppeBKb1VJ+moEZ9Nre6mcAagJ+JbuFLPG9CLXwPMcEKR/XmI3oGHwIFya/U6ht4CkTp1af97RTk6u8O2HRULqozWoXQm4S9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780664948; c=relaxed/simple;
	bh=WLAmhmbyNTHXj0SlY0wgaiI7BzKLtKQyqKCBLeiBnHk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=u452C3p+VMombUdc9k12uJmXF+ZJHtzkzFl/h8hagubq8wfO0U8fYgyMcjIpLuqGKiFjruWAR2RbfLyr7C7I0iNYcxX35K2FvJ6A9VFLbg8neU5Ji1F10GpWgI4av6WizLb8c7sToieAH4ulxeeiSyCGHHcR4Sh6erIAREvEebc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RB6jsyrz; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RB6jsyrz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780664947; x=1812200947;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WLAmhmbyNTHXj0SlY0wgaiI7BzKLtKQyqKCBLeiBnHk=;
  b=RB6jsyrzw3+ZxWdTJmobwk5DEXofVzrkYCtJQTYCBwsfks512+LuNre0
   EvLLcSWFExk97UkIY7Ase7aDt02wZpKbiXZbrKEi3ribvF2C4FzWU80dS
   o9m+rPYaQZg4nxmHB6qsurRq/xvYeZXfBB2+78yFjGPUrszuT4WVfr3+l
   Gg/khNZ25okd5JJHct+jyJZjI4rDP8rRGz2Brrb3VyojEh+AmW69S1f5H
   SjLfO1Vsdfn6dUp6XyGJsQZgpPEWlczqOHweSzgp7wpZqPfqdja38vi1b
   Y96ZZkidDYsTeja4Sw79irAx7rIqSWfSOeCcM1tngKnRxQzyADiB4e/f5
   g==;
X-CSE-ConnectionGUID: +H90qOtXRByxkelUfMO0Tw==
X-CSE-MsgGUID: Ln+2mbgUQBC6W1pYb6syIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="85117313"
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="85117313"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 06:09:06 -0700
X-CSE-ConnectionGUID: 05+0zTAfTeKeE5PYflYPbA==
X-CSE-MsgGUID: FYlw5SqETfSdnchnl1Xnhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="249180482"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 06:09:05 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 5 Jun 2026 06:09:05 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 5 Jun 2026 06:09:05 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.49) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 5 Jun 2026 06:09:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xWpj//xMY+cn2PZjZsFDQRycmXVQKOmsNovcNwpP0m4doUeB0saZXvAws1XrN99kBCY+Vp7AaqXkYzlzRxHG9u0DEJ2EHegSdY/Dmsgcf7FETrzaxKhFOozvQiGKc5XmAF2RTuIWPMr/4Xm/sYX4QJkbUVZzGtnGBRiR6vRSCu2Frn4f6pg08U+XHSuSV190d0DU8K2fKgnPeIlKHi/UETwbvYB8fVqL+elBu35CuCLjAUtZ6a1ZjEpddUSoQjfBD2ChOD/Rg+msLLD+FceyH2MVHeeKvatKUo6kOHVxNBaqkO1vdoKIy6lvjHe6ywfmKXwtA6HWSBP40ZFl7sAFlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CLP9DQXAsm5SZ8Dg87/aXjUknXcfZDU3zo+c6kV54Pk=;
 b=DUuwLDwSCwvwi16OCv7MM/2TN85g2Yf5t49c3gZHS0sKmUhIHrf9qhyG7EAFAnuQ0DDPzVm3+Pz78ZHt/UzQ95O0TeRcducWZQMfsjQc/XC6GOQt8chf9gfVs2/BCxT1Fk+7n/Cgy1T2ixSlXPsEarZSvsg6v4+OBr/QWf9RMGdxhiGHMB8TyfIlTeuYhe0rMaZ7nxJwOd5P/b66j3k/UwxveOj3sq/qaqXoD7qTWV0CXyUdnMv5ONTogzfgc1xxEQVjuIVVDK0UUMwN7MYiTI2aRbu+nJVgm6GfvO7dylg2H4u93IRqhl3EJEbPxMwKrmNVXRcVb7ZvFugy3h4MQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by MN7PR11MB628000.namprd11.prod.outlook.com (2603:10b6:208:5f2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 13:09:02 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::5670:5b2e:6ecb:dcaf]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::5670:5b2e:6ecb:dcaf%5]) with mapi id 15.21.0092.006; Fri, 5 Jun 2026
 13:09:02 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Xie Yuanbin <xieyuanbin1@huawei.com>, "david@kernel.org"
	<david@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>, "linmiaohe@huawei.com"
	<linmiaohe@huawei.com>, "nao.horiguchi@gmail.com" <nao.horiguchi@gmail.com>,
	"mhiramat@kernel.org" <mhiramat@kernel.org>, "mchehab+huawei@kernel.org"
	<mchehab+huawei@kernel.org>, "Luck, Tony" <tony.luck@intel.com>, "Lai, Yi1"
	<yi1.lai@intel.com>
CC: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	"torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
	"lilinjie8@huawei.com" <lilinjie8@huawei.com>, "liaohua4@huawei.com"
	<liaohua4@huawei.com>
Subject: RE: [PATCH] mm/memory-failure: trace: change memory_failure_event to
 ras subsystem
Thread-Topic: [PATCH] mm/memory-failure: trace: change memory_failure_event to
 ras subsystem
Thread-Index: AQHc9MMbuFRq4DBri0iidGLQ1Pc5G7Yv7Z1g
Date: Fri, 5 Jun 2026 13:09:02 +0000
Message-ID: <CY8PR11MB7134514CBDC8434CD1E2BF8F89112@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20260605081213.154660-1-xieyuanbin1@huawei.com>
In-Reply-To: <20260605081213.154660-1-xieyuanbin1@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|MN7PR11MB628000:EE_
x-ms-office365-filtering-correlation-id: 3450eea5-6f85-4d6b-86f1-08dec3039d78
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|18002099003|22082099003|38070700021|921020|56012099006|11063799006;
x-microsoft-antispam-message-info: YKbKxlef0kv22IULLgcwkb/+qfsMSplYKMWroyMnpc6CQ5ERNaYOg8cvPfkUJ7C1rRnPG8Wsk2JDL1vFIrKKEQIf4ZEamjFFN63L0ojV7QdnyIGE5bfqFMjsvZJhljoe8zIw1CpM0UShhUPak9YQE4670mfojFo/gWnB2/th6eRQ61KPBnPHeYI3aMKPNWvGRR/4+TPJ538TJ1ABd7c9K7I7C858tOfvVDfy3pcWCI9AqIbEO8LyYTZhDrvd2iLKMQ/FootFksMJU0uIFzhOCuFzQvceduuJZsMSqCXX6IbajpTQGZW4GRziCKERPuVsvkKecubfiy4ZGnhUQRwWl20xtNhF/TJKPsGgnXSNBmA3gb9uLQi2zrU8KwZSlTQNsdI8/Jywl7P4RCJ18l7yhjxyGGC+dqCNiAjSDE90lgPLraYXQRqb0YlWSZ85coD5vfrmWhjxnmc5sGS1qAppulTOTT7h0O53ptROYDJbiZWXadpTuNpzUoLq2I2PmtyksTmDUvaSAylmHaIF/M8RFsv4sloSij719eRq+Azq1w7MOPHUfm0R6wk4YI/Y2xVnUQkVelCcUZ8U+MZlGRnfbOf5uNxa4wFYCjOY3x0o6ksaMhs7dYFwPbE+aINpzQ2T7vZHv43Zg8Gwe9DM9De447njgcoW8TYT7PAnh9VJsjKD5Y4PQ2Eah768Vo+2DkjF2AMM91ISSe0GfJ46UR+P7oa/ppqNT3gx19UPQJEJIaJNhQh7Di/uOnOihkYM2s3x8uu9lja3+5kOKUhytXIf4Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(18002099003)(22082099003)(38070700021)(921020)(56012099006)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OU7VnrCyghSFyhtK7E63TMTB3oNqh1DznjhIe6KHGSREsh/UbaGNl/mvmRW4?=
 =?us-ascii?Q?GrDnk49wy2XnTjoJiA1JLegbdLnPKevcCJ8h/IoaxzeGOahW6Ql1tiaAfVhx?=
 =?us-ascii?Q?AZn/u1ZICh6i8yIRJ+MVoWBk8UCVOgOiCZ0sDEDEAEe+mu+OfRMDphT1ZnlC?=
 =?us-ascii?Q?k3VDCtWoGc3nRra61oKvQQ8VjndoFYi4WOkA4IP+ifO/XcaClVEt8i9eOTgA?=
 =?us-ascii?Q?x135TZ6ZAUu4ypWbyHq5EY2qCquqpkleavmHZViNqxHul+i6+mJLkJ21VBFu?=
 =?us-ascii?Q?/31qJ/CPB0AiqSUVbvuKBBhddCJmNUxNdBs0yTQtqh/S4P+bvliqMRNi/dhc?=
 =?us-ascii?Q?D8jrnvRBDnwTDzvSsYSkQkBERyRP/81cDC09j/w9ln7gwMh+U1lptI2RX6T5?=
 =?us-ascii?Q?JAlHoDQal/ltxaWnxxWzT9yeKrJ57vnzOUBe/pqDMeJylkJcpWHS8VoTOYOH?=
 =?us-ascii?Q?tg8E12csRIX4yiabYh4o1UZHAhN6XK4u7t/W5PCfLDEw4/QlrMlGJ9I0yUXZ?=
 =?us-ascii?Q?n0cMnLVw/AQGr6jpOcNr5Cc8wSjURmc69LH+4Z8/mNLB/3KM7T576jgzClCU?=
 =?us-ascii?Q?yuX3Z8QCTP1uCkyfI9ClB8x5M8xMr2S3Zs/gHgJUtKlFM0uJwwRAvzksf+GO?=
 =?us-ascii?Q?2lGwQhZ35t5PnR00cU/ZQym50HCmy1nTU6ZQQppgPnemC+wqznIJuku7RUTJ?=
 =?us-ascii?Q?kAXv29jiU+XIdwBpE53iTQYVIDMfxRPTCN52/k/9N7KDLBgWgYFKnYY9UQx9?=
 =?us-ascii?Q?ffh5w0wZ1JrLbvUDe0YGb323TASEBtGGS7h5E1BxISG1E2hMObYSIQbQ9NdQ?=
 =?us-ascii?Q?JZ7TeobOmzyeNYO1J0lOOLWzTwGpvb+ZOSe7nKx/rd2kp/A+JkL4PKtT5zHW?=
 =?us-ascii?Q?a5dkTfGntIOf8cZ/2rnI0ujB7vI1Qux6kv2hUWLRNwD+AJNaFiX7DeDo+NPF?=
 =?us-ascii?Q?OVTuGzF37h3CPosoZBSTs/Uc8kRnlI5xppt4ssZCaOy5PmXjePYqldW4+4FX?=
 =?us-ascii?Q?VMVNn6OtzsbnEIT5qh+to5DXcE4fwBl1oHdpDZkQ2BwmoGfKYADbgqbG5pWW?=
 =?us-ascii?Q?owBNOXotW+KY6X6MP54pDoxs3IWWtdR9NyEg4U+44gBlK+NIUZcE6jt9Kpi2?=
 =?us-ascii?Q?J2Jc0XsUBTozP8/MEI1KEgxPnW+o3G+GWYMeHr0C+16FQmaN0pAwVcs3sEqE?=
 =?us-ascii?Q?KWY+UWLwV6MM2gsqG3WroNpGNmQgQZbW4q5fsH20d4wzkolRQRehsC4jwogI?=
 =?us-ascii?Q?xbQGlcNRvXeHSbGob39PSUn0Ip4qLyaxgB5u0GccELjiYNMeyyffztp7RTX7?=
 =?us-ascii?Q?MaFVxrCyrPFsUj+rVo2TN7+QrSg/Pv17NX2tANDAvslCKsIz0dT4W3ZFONJq?=
 =?us-ascii?Q?BlZUySpeAPnn0ux/uv2L6IIRWEWVnygOv4TnTwySfry83kdTZFuD7W8JKpHn?=
 =?us-ascii?Q?G/2lv9oxERMlHJMPIghI9ajo+ZyGYoGjU1aLtJIab2fvqSeBd8cT0ixlnO1a?=
 =?us-ascii?Q?t0hRiSmLZHWcyLBcuNvB5nk6SJOai7h7KmDXemhBaq+oBFlvR8oQie/FE+IN?=
 =?us-ascii?Q?ATFVrvSAeCjmwNxNPGKBGHGZb+MYBat37tnL1tHmWWHpeLe55jLnC38k0HRj?=
 =?us-ascii?Q?/+W3np86xxoJUr6dA3tJSW3aHJFo0Z2RpO/GZBst89UdAlpU6qo+SDrH9vt7?=
 =?us-ascii?Q?S2th/AqO3cuy9IYOnNaEMB7F5BqUluyE4jsOpXwFCcC/Fwpn?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: S7Ail+6dVg992NdUrIgpB4HAKmZdsCBBO0WHNewsF5Er4FGRIJyWlD7mqj3wdYev7l9b8ctGv1fxe6vxSoPN/6lkFedVfULdW2xh2jSCi3Sp4eVNqDKLSszJ6Hx3QyxVSrRpRqPphADRor5R4CvcRwhuyS6557U9jTQdZWYReRSsUruzEjRaNpCw9K9JgOEGaw77+T1pIX7XkfxW1NdG10pItQuyeYHU4Z3H27atpwt7kbo6awSLPPSLFfyJ+MB7mQywuD4GwCZ7Co3bVAHNT+c3X0Fr8nh8hfV828WQlaloSlNTi521KN2ciAh42dUJ+CTjF7fvowyw+I9XMOexuQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7134.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3450eea5-6f85-4d6b-86f1-08dec3039d78
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2026 13:09:02.7349
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mdccPW/69DFcCMne9GivQZfzpuGwsuO6cHC936SW58y/Xi5HQW2UM2z6Na/5on5M6vju/hQfs7YLmZ1fZFJHlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN7PR11MB628000
X-OriginatorOrg: intel.com

> From: Xie Yuanbin <xieyuanbin1@huawei.com>
> [...]
> Subject: [PATCH] mm/memory-failure: trace: change memory_failure_event to
> ras subsystem
>=20
> For historical version, commit 97f0b1345219 ("tracing: add trace event fo=
r
> memory-failure") introduced memory_failure_event in ras subsystem.
> commit 31807483d395 ("mm/memory-failure: remove the selection of RAS")
> changed memory_failure_event to memory_failure subsystem. This breaks
> the backward compatibility, some user programs rely on it.
>=20
> Change memory_failure_event to ras subsystem to keep backward
> compatibility.
>=20
> Fixes: 31807483d395 ("mm/memory-failure: remove the selection of RAS")
>=20
> Reported-by: Yi Lai <yi1.lai@intel.com>
> Reported-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> Closes: https://lore.kernel.org/linux-
> mm/CY8PR11MB7134346A3E4BB28ECA28D6E989132@CY8PR11MB7134.nam
> prd11.prod.outlook.com
> Cc: David Hildenbrand <david@kernel.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Miaohe Lin <linmiaohe@huawei.com>
> Signed-off-by: Xie Yuanbin <xieyuanbin1@huawei.com>

LGTM.

  Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

Verified that rasdaemon can enable and receive memory_failure_event on
v7.1-rc3.

  Tested-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

Thanks
-Qiuxu
