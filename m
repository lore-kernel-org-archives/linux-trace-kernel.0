Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8CA23D2;
	Fri, 18 Oct 2024 15:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729264698; cv=fail; b=uSWG2L31Nu4Q8uf6yXlKV+cxNNUHBmucL0wrYr3vAnoer4HeVPCjQFot+iPdtMqeJakvZU4lBYqigcj85p4oO+FOwpR/q70w6lk6p5qPxN/7Q/lSXlPFmiKQXG3QWhV53+Jrv1aAfL+5BjYQhPfXn/lvR65JeGnAIjrPtK9wAk8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729264698; c=relaxed/simple;
	bh=tKZbVgG/dMJnAOrIkm9SkArdEkiMaerfaY3fpGxwork=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lWNYr9O5hKiYQX0yhp+133iVt2Ug+fM0p73Y8nTRo/P+v0Qk0lSQwx56xzTTuxQ54oE0YCj2XyxWiFdRQRHDZ/2OAEfUKslNkzIykyVy2UnEguj1ct+QugYoWmdfFFH+2gbZC7Zc9RNtV/EIe7Ox55wNILQUzA/RncZlzz87Ixc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FVC1uWxl; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FVC1uWxl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729264696; x=1760800696;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tKZbVgG/dMJnAOrIkm9SkArdEkiMaerfaY3fpGxwork=;
  b=FVC1uWxllcW80z6DM0Cy7ti6AFDW3Q8s/Y1p/ZsYW8mswAz7LlgcvsfB
   fhR7balrYLOpPANcmlDPdLXQMsF7/Z2+pb3lZDSrBdhOEZmGNzvVGOcGY
   +z+w4DZMwtBN026rXrPBYTHj/i4W/Lm2MSrdSuXf6esKIDkpz8Zxujnkg
   YMAXkryxQ08URmiAUEvlHcqQh3lPK7V/CTnE/I+dCEvfYn5OpJTp2uEkf
   XQr6P3Uw99NOZ3/IM8gFnJ5HJ2pnl2aYw9DMpRpwfUc6+2oxFElFd44mz
   UY6G+YQQzxbNU/oLu+7F/WAcL2CWicXjkanSnVhBQoc7LMWf+KkMTeVZn
   g==;
X-CSE-ConnectionGUID: PKLnCQRDQ8yRdbmTfrax2g==
X-CSE-MsgGUID: y7GOrWxdSfOkezS24ahJ6g==
X-IronPort-AV: E=McAfee;i="6700,10204,11229"; a="32726390"
X-IronPort-AV: E=Sophos;i="6.11,214,1725346800"; 
   d="scan'208";a="32726390"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 08:18:15 -0700
X-CSE-ConnectionGUID: K+44DoxpTdWAR/eHJS31hg==
X-CSE-MsgGUID: ztJvPWD/QIeX1XZ2Zn2SWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,214,1725346800"; 
   d="scan'208";a="78852818"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Oct 2024 08:18:15 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 18 Oct 2024 08:18:14 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 18 Oct 2024 08:18:14 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 18 Oct 2024 08:18:14 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 18 Oct 2024 08:18:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VHS/Aclzo2O5AwYGoOu4nM+2ZX2UFnQi7XVcmw76EqKl8tb3NgQp38xAg2Vjt2BhMWsViTuyiDDA1ExysNWBdYByBQwkgGAZt1wvAeMd+QibPIZHfz3uaR8jQ1A1wM2amdZt3DqEUc0SROORxEOFdVrvts0fp7vhTFCk74aGOiQ6SpgXSAWIg5ER2seKC9uHqwL6SvceCDGrz4elcuiutegSuR0KCID1s9PLRv7rBcuqpiOBOsMg/rMVOGM+ovCmwHkUOfy31TD7/pALF1RFzEwmDUkV0RrV7APRlueP41AySLqXzGt9oUMsAZxBe9Rfpu3J0/UOyGalRAuAl7AAEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jK6cLASbnJ/GaBBsfoX+2c6+OsYciKBpWnpPn6BCxgY=;
 b=vEbzTHySLD2tFZkrWmwew6uaWqz5Z3vIXhc+UoLFP6aaAzGVi5SQbizP/d2aw+c4/tBzLo0DENdh5SIEL1fAjTnZTSQXPSS1G2SLNy1dmE7cyDI2Wnr9PMzwXo1dUFuLYsmDf0BoB/v6nWfkhSZONRXCBDQ4KtvUa0Eo70buM5mVX09Mp6migp+FeVWsZaOloUvoIYAqDBng4lKnHXeBg7L0hklrKV7zHeg8PTArVLP3HnUWRFDzh3FBVEhjOuBTBimJFDWvr5X9c2t1KB+xGd3aSNIv2+FywWz1vr0cwWhtrBA5yPbKZy+AgKnweCml4Xngy8W02sV35pFEoblP4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by SA1PR11MB6920.namprd11.prod.outlook.com (2603:10b6:806:2bb::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.19; Fri, 18 Oct
 2024 15:18:08 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::cd87:9086:122c:be3d%7]) with mapi id 15.20.8069.024; Fri, 18 Oct 2024
 15:18:07 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
CC: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
	<mathieu.desnoyers@efficios.com>, Avadhut Naik <avadhut.naik@amd.com>
Subject: RE: [PATCH v2] tracing: Add __print_dynamic_array() helper
Thread-Topic: [PATCH v2] tracing: Add __print_dynamic_array() helper
Thread-Index: AQHbIWaAGp5qcAKBk0ixpbgPnB+46bKMnpag
Date: Fri, 18 Oct 2024 15:18:07 +0000
Message-ID: <CY8PR11MB7134C04495732748BC8DAA5489402@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20241018100318.0fd3c33b@gandalf.local.home>
In-Reply-To: <20241018100318.0fd3c33b@gandalf.local.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|SA1PR11MB6920:EE_
x-ms-office365-filtering-correlation-id: f9f3ec66-13d9-4a66-b35e-08dcef8811f0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?/n3Lg41dAFBQ+UbHwbtL+OKS1UARoR67yAgLFLg/tLKJVePz21/FoPoJGAr/?=
 =?us-ascii?Q?aaVrLUPXw8PdVf6EkRcgnyXqYR7nU4m4iNvFbF3O5tspto/6GUNd9p4hvS3U?=
 =?us-ascii?Q?iaHizvddWSddyC3/id9kQ7I5YEMXeAHF/iCzTTyPuVhOtsvg3cDqObQlvNRg?=
 =?us-ascii?Q?3N+5yhkCypviocI5W5vtoJeBSw0D7qnn7VU+oL8S/PfVVcyhMPscC1npmNR9?=
 =?us-ascii?Q?uxxHYYJv8/cz+KkoHL2Y8zhIGVDUgCcv4ZPpqkaL9GOHI/NUt2C0Z0xyZs2N?=
 =?us-ascii?Q?ule6GJ+7Fmy55kMpmbuxzPsv33RxVsziEx2bipcYcbRZBrY6hhyYUpowTWpS?=
 =?us-ascii?Q?Dog7PDG734Z+NGySz3EAeDBFg1nhAZi7ZEKsj/LalvU+omTPf5qLEI0R5/mz?=
 =?us-ascii?Q?xezcpWXaK6eF7WlsOJjc6UCOkuCKbCebIJ4Oulo7khjekOVBYu0Cc4lTaySZ?=
 =?us-ascii?Q?nQY2o9zmN5GScn43WtktAkGRovwoE6gfe9loWbslz/+LsVbH6/ZAGuv7ZZX6?=
 =?us-ascii?Q?vHCaW/G9Lyy7Z1C5gHP+0l5VsOdon7Oa325pAsLup2pqNi63IFOeTMbKmK4P?=
 =?us-ascii?Q?eWsBujLEabkKUxREyE0uYVpgrrXp7vzlxuA+rmE9wlE99dSceLjm9Aaa7ZvP?=
 =?us-ascii?Q?ORf+EFdzKcQX1Od+bzLsvPBLQpV1CLkg8VrkzicorrSng9STSWhof0jkyVfM?=
 =?us-ascii?Q?C2sFrXPXRu3b/FrpCKJ3TITzpxbddcP8zos6G8EDZLli5d62YVV0p4u7gAtR?=
 =?us-ascii?Q?JrUQMqVjratJ9nI2IbcL/u6d5k9/bqJicZyOYkeaLgFSwFgbOOzYZOzEtZxY?=
 =?us-ascii?Q?aSPAEN3OIfp/YMvC1d/Ca0DBwOe7mVy27B4xMhMOVbARtZxh+C9Or/5psb7W?=
 =?us-ascii?Q?iorQhBl24M3dGm5fvl2SJmCR5kFQ/olRZAACClMvlHqEz016vA34QUJ4NvAU?=
 =?us-ascii?Q?ix7INw/eeihwsFPPN6ewUpzaAkkD204s54mtqz99DlVr0sYaxqkGNLEknK4V?=
 =?us-ascii?Q?KUUx9iE4jiiwJQ2s6u7wOuxRFYrD0T6CeDIf6p3keeKGbZcjw1Fy1Xgy7//s?=
 =?us-ascii?Q?4pKCsjsM1Md2DEKzAwcjQluTuFi2YzltjqpuAKY5TFhry5sXI7EG/OewSkZR?=
 =?us-ascii?Q?NxuSpvYYH6zZ6VAIFIGrzPBbnY2E8gZYURrJ67E+0JE1IS3LHhFOd+/YHUPJ?=
 =?us-ascii?Q?6Jr6DbQJ3Dv5D7z0udxjsfuwlaVazeTsdvKvtMQxbq0Ah7nwLpm9muXrh/m2?=
 =?us-ascii?Q?tEW3imu5mhyqsZSZLSF13JJRYwEm5kibxkJ1+KB3G6PHAq15jwtTab4M7M9p?=
 =?us-ascii?Q?vsM05laSb3nvLellcwWKOnI7yss1pIW3TpunrlNTSlw51/qJwW8WV7bAYzxB?=
 =?us-ascii?Q?xzSKSig=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1iUrmd6snnUFF4tu92Thm6IIuySm2KUn8q7f0Te8Fw4WOKPXTnGaOUhEMfHq?=
 =?us-ascii?Q?hzBon59rE3CybJHH2RbpZLwQYpCtgYL1uZL6YjuZ5L/wy8mTJbDzWSMsf6oy?=
 =?us-ascii?Q?XPmm4aUn3svy+vlGXtUzjekdLUlRzDNEF6FdaxnpYrs+qYUvHlUH4R/KHZ7B?=
 =?us-ascii?Q?lPHfG93WVYy2edO7Qn2JynGeEvAB4/65ijguTgfDXzrD2dTxp9qQvuzuzviQ?=
 =?us-ascii?Q?2luErtsi9KprLk2HEHkUGMsA1XEN6KGAZxb5/JzGEiiFLiQ1MpRLEQOT5flJ?=
 =?us-ascii?Q?Kj7DX8+LUWmwDhUgBs7kVQwyoemqw0OctkhEhx/IQ0Pt4InDAf1gaRzb0X8L?=
 =?us-ascii?Q?zCJw+bWEU+WkCVSXemRwzJn4e3j0h+m0/qb7+G6eyMpHODTyekFONKZA4etr?=
 =?us-ascii?Q?oThft1u4et/XdGuVfr7jcFBjzfhkzhPTP7jwJmiaNp2WpDcTjEpVW3ze+e7J?=
 =?us-ascii?Q?cPgRk8F8zmNDtJn8xD7woow/YqP+Jon5AlRfdjE8sFYPKRv85w72BmzDEAf9?=
 =?us-ascii?Q?F+Eqr7ZGkQMleSIn/AhL2Ks3F0j6FzsAAklR++raaS072XPx7fUhIplnf/Py?=
 =?us-ascii?Q?jeQxWapqIOKr66niOT9bmQg/1fWZDjle3Sy38YzeKQxFc7r/HvXGlD+SAq1N?=
 =?us-ascii?Q?uC2pjGj+QoTXz5sHRYgx0uitNu5oR1ZYixy0RmuSfWIHC8S1RJrDTdw6OeO5?=
 =?us-ascii?Q?N+kiArGciDD7xmg7n3Y+WTkSLFEK8bbKTyhHMONgTwis/0b2/Y8so2l38OV0?=
 =?us-ascii?Q?gMfMroelDuVY0IZJpSBA++CG4Z5nbaPFSj4HwDTXd7iuKrPImfaSd+hZKkJe?=
 =?us-ascii?Q?HJiio0UCqgG/jV3ep3wO4Z6PaeJECWlEVAOHfUXmry92HpRMR+2c1dRSb8ct?=
 =?us-ascii?Q?ijkd2/yFOPMwgOvT7zmUYhlRhofFUxsDoafS2RQNSPqqDFfqiXJMZVb/Yl+C?=
 =?us-ascii?Q?25zGttQpSL7uC9IwI5/vZqlm/JJP14tOMPqGUG0iyRIGAZXG2MYGdBh1VuVN?=
 =?us-ascii?Q?nT2r60RGltweVtse41eXLe5W5sPa8yKznM0r7dL2JDXD3qdyxF7PKRi4eHKd?=
 =?us-ascii?Q?xzQvppXOC+lBdHVnXc56f9AF4nJJrxtJJpjMJGgJUjNvQTS8E1vGrOHXMxcr?=
 =?us-ascii?Q?cU2LLAZngU9gUV2eghXVPrt50gaEQMRGrlrzk/yPifjZRSLtKVQHMJDBZ27w?=
 =?us-ascii?Q?zSGW6B3NjWvzn6z6bS6SqEZrdMmQKhXzKt0qfsElqU3aRPwpMz/nb8klCywD?=
 =?us-ascii?Q?B5DZYeZ+3nJl3fyTd9nYdt7YSbypmF4aTSVN362Ej6q0CHhK7pGRUv52OEZ/?=
 =?us-ascii?Q?3GmjtK/j0a15MUOQOeOYwlolwK3yMHnI4bFIw4c2mILQw9U/VedGHSGK9zKP?=
 =?us-ascii?Q?V8VHlJ7Mku7FiMr0UAJq5W/bq/+pvr9Hs8JoFcgDp0Tp3tArP0rfiE4FBCI2?=
 =?us-ascii?Q?Kp7jx0AYhK5Xo0xShqmw8IglzpeagS+uxUULqOO+7Ev6qITMhoX9O1bF2HZe?=
 =?us-ascii?Q?t6f3Z1fDsbHIU1riTOwI+Vb2JCzRTssnzzuIyjBGtlwQ4TfqlXOPQcZBOOT3?=
 =?us-ascii?Q?n8MFuzd0LGbfQiifa4wKwA4DV8jraMqofxA2Iw9P?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7134.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9f3ec66-13d9-4a66-b35e-08dcef8811f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2024 15:18:07.5114
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Av7WpqS+3B7fWvH5PCZa6xQN+eGy4VH1a4gy3EBdVOVQ2XA3ioN8Ql8w+EIzJFNLaTkZ5ikR86HsFpvqHGsvdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6920
X-OriginatorOrg: intel.com

> From: Steven Rostedt <rostedt@goodmis.org>
> [...]
> Subject: [PATCH v2] tracing: Add __print_dynamic_array() helper
>=20
> From: Steven Rostedt <rostedt@goodmis.org>
>=20
> When printing a dynamic array in a trace event, the method is rather ugly=
.
> It has the format of:
>=20
>   __print_array(__get_dynamic_array(array),
>             __get_dynmaic_array_len(array) / el_size, el_size)
>=20
> Since dynamic arrays are known to the tracing infrastructure, create a he=
lper
> macro that does the above for you.
>=20
>   __print_dynamic_array(array, el_size)
>=20
> Which would expand to the same output.
>=20
> Cc: Avadhut Naik <avadhut.naik@amd.com>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
> Changes since v1:
> https://lore.kernel.org/20240821134843.5faf9a15@gandalf.local.home
>=20
> - Added parenthesis around el_size parameter in macro

Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

Thanks!
-Qiuxu

[...]

