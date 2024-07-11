Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF368BFC;
	Thu, 11 Jul 2024 21:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720732920; cv=fail; b=V7HlydqjaZ1ACnrV29o770DJHGTcY5fb9ZlmsuHJ/PDo6/2ORjMbHIQ0ZtWyCrZxOP2M2WXlJCtRYnA8GclJ8xy4rzfRSl3+e1GOD+hlr2ybANWrgAy4L6M1nAbhjAWLKx1kcpR+3KC8LgO4/GlIkUXTsiHmukFDWLZJDEZCMSQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720732920; c=relaxed/simple;
	bh=lqyU3HZ5kXwg9Ud1WTW9Le8sK0NqHCtdXPsC8n9Yc80=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BNIUvjS8fbyQM/aaZwyDpmF6zExvKe2LjIlDgAj0AK7pQrIiiQAcWkodXADZsyMEvxbGg7XkIPQ3ivPVoHTP1OwI3iRd60oxdMKBSX5ICztBljecq9onb+b9EDLDA1mxnDIxjPk5QkS1QaCThNMKKISqct8ydM9bMtS8PjgjcEY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ldPR7emR; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ldPR7emR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720732919; x=1752268919;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=lqyU3HZ5kXwg9Ud1WTW9Le8sK0NqHCtdXPsC8n9Yc80=;
  b=ldPR7emRQ3tp39J2l+rLarwSCY1MxIYG43ibOjnnADlNsBgU5v49/ynX
   GJG9YCMoxkJvtdijwqYzhax3h9MDsDHuMtBdUzpOqntaX4sX0HpDfeQlB
   8GJE3U1gkaMmVkg05S2XeekjGvdeRZgwHaZ/+hn+ugv+xsu+6xVAzbDiA
   Yuyxp4YoLibFP6MovJTB8530Ztd6XTEdpqRN9ebBsxGPCVj2syTpxStrl
   Sn+XzAk3iu20rt/myHj9fcC+r1t9fEHmKsZNrniK5ACeZFGi6JWbgk46+
   e60fPyRUU3FWq1wWiXHo42Q0dn1yEPeKW9IDSpVd88HWGkQF7Kgl7S//0
   Q==;
X-CSE-ConnectionGUID: v2lLSr5ZQeaQMbOQiy+Ytg==
X-CSE-MsgGUID: JCGUhdO7RjactQj9W5GMiw==
X-IronPort-AV: E=McAfee;i="6700,10204,11130"; a="18289506"
X-IronPort-AV: E=Sophos;i="6.09,201,1716274800"; 
   d="scan'208";a="18289506"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 14:21:58 -0700
X-CSE-ConnectionGUID: 70aZetIzRhGQAvweuvuBvQ==
X-CSE-MsgGUID: 6bktJq3lQyefYQo5pctoWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,201,1716274800"; 
   d="scan'208";a="79819056"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Jul 2024 14:21:59 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 11 Jul 2024 14:21:57 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 11 Jul 2024 14:21:57 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 11 Jul 2024 14:21:57 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.175)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 11 Jul 2024 14:21:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WNIxsSzW/IWiDw9FxxsEd+QBLl5HqZgt6nwEUkRicE6x+1IoFHGh9cPigQwYx+bswrG/HfmX2f9aFD6MpH5wWwT7KOUG5G/+4zRf98/MjELQ1WLS7tBxqwGvyJnj7w98Lbe484OPOvg4MfskR/U3/hyXRoXxDtMIGZmMRjbb6JBOSiProp0n+g7+0XTCBxCTCzoaPqkfJr6AmoI2Eyx7t1ACgaBwXO7GTH7ePXBiQuKQt8Mcnhzd07wiLWiJjNWQJrSU77VY3vKYWP+2wQVzFH10NpdmutNqLwaBcdF8qQ+dIKnZlKmT7lZ1IGJw6hs2VWy29ShBhF2QgVAfXE6tFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wFfGHy5aXdaKhd57/um7LpGLzN2eo1SAzFGzzvuzuqA=;
 b=wjj+UhiOZQkbaFEigcmsHpVS1j0N28+UI3RM2btnbnVRXR3JjEgiJgDELY15UNMWKaD+F3extISAEEHkanCO/VGeLhImsHxguh1/5H+zG9BvpNKsIchu9swoXgUG/bgnfy/6SmJWaSoYJcEnMLd9eRHdhHX0tAZVzBN4eTzdzCz8Xdep7YtGt7r9qSTfQJlbMKIjtp2gKJRfpHqduLEFKe16Hg3M1mZyfDFMJjDbMNQglmr9Jk3eLGlxG6DqfWEWV4KtUnLADXeSamZdFyTdGSwzvZJ7+tX0+L2LcAeCg04O08pU3TzqpWS9bNUhJxMioCYwKj3J5jrp2Ww7hkTS0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5262.namprd11.prod.outlook.com (2603:10b6:5:389::10)
 by DS0PR11MB7407.namprd11.prod.outlook.com (2603:10b6:8:135::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23; Thu, 11 Jul
 2024 21:21:53 +0000
Received: from DM4PR11MB5262.namprd11.prod.outlook.com
 ([fe80::19d3:28f4:c53f:8431]) by DM4PR11MB5262.namprd11.prod.outlook.com
 ([fe80::19d3:28f4:c53f:8431%4]) with mapi id 15.20.7762.020; Thu, 11 Jul 2024
 21:21:53 +0000
Date: Thu, 11 Jul 2024 14:21:47 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Jithu Joseph <jithu.joseph@intel.com>, Hans de Goede <hdegoede@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
	<mhiramat@kernel.org>, Tony Luck <tony.luck@intel.com>,
	<linux-trace-kernel@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>,
	Shankar Ravi V <ravi.v.shankar@intel.com>, Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH v2 3/4] platform/x86/intel/ifs: Add SBAF test support
Message-ID: <ZpBM62dM_pKniydW@a4bf019067fa.jf.intel.com>
References: <20240711000233.684642-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20240711000233.684642-4-sathyanarayanan.kuppuswamy@linux.intel.com>
 <6f445c03-21b9-87bc-1bc1-ca211c56eaa0@linux.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6f445c03-21b9-87bc-1bc1-ca211c56eaa0@linux.intel.com>
X-ClientProxiedBy: MW4PR03CA0196.namprd03.prod.outlook.com
 (2603:10b6:303:b8::21) To DM4PR11MB5262.namprd11.prod.outlook.com
 (2603:10b6:5:389::10)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5262:EE_|DS0PR11MB7407:EE_
X-MS-Office365-Filtering-Correlation-Id: 3071688f-bfbd-4186-6e35-08dca1ef7c62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?+ZFLvcAJp6QSVVlyCgYp+wfI2aaCLFufL5+8TAUYLtyinA5mcBIWrsU87T?=
 =?iso-8859-1?Q?jxcGGNGmNxCjF04/WZcb0OOb3YcjwHGrRo+yr54siw3P7sXpd7iGCExLrU?=
 =?iso-8859-1?Q?wkmqGbx7eLn71XAkGHFmK3pPzArORTEo+P1nez+qcUR+9UN3hsfQHMWK9U?=
 =?iso-8859-1?Q?/6Sc+JFVtGjpOj15wmi9hDxqXH3UBRQJ9/cctjD7ZE8YMkDFt8jevPPRPo?=
 =?iso-8859-1?Q?jW/KM3pn+JaW2C2r2uOLg/QZjtYMqW0uUHtPB2WbEHX+iE2Q39FaVTP+by?=
 =?iso-8859-1?Q?xddiDpTsBC0AEsR0snfTKLhwWNMGklGAhuONBR6K2FruAUAV2lKpzlGlvE?=
 =?iso-8859-1?Q?+4c/8RQGzrU7H9bpPNOUtUB/vnheWvmP2vfPDqXZTITKvwQ9B96rvQYrhA?=
 =?iso-8859-1?Q?N6t0TA2DOL/gaV5NbdouEUiFo4ZN0DPu2DhYqKyNkg9tGzUX5clDA2PT52?=
 =?iso-8859-1?Q?MV0Mg9JkWdO2jDsKHqE//ZkijQ4/vOt6qcTL2K9QMJCOpzWtp6MEg5kkbl?=
 =?iso-8859-1?Q?7AzMP1jDVx24ECnzFUbG/TlBkCWjGuGHvn2G6Gqc5d3nhgFGS6AzGiQMDD?=
 =?iso-8859-1?Q?lK8phFKrGurvOVS/q2GK9Ts3tpVthjmCo1nDnSBYmlAQb4w18UntMEKEVW?=
 =?iso-8859-1?Q?r3f65lQaT1+/55+112N6r28IqoQPGg2wCdH0djT4pxjM3G1p1CXN9mZv1O?=
 =?iso-8859-1?Q?clPkG6z0pvv+w68kDVXpRn+kccyM6ItcN337izWgs9VPQA7oMRIlTQfSQ9?=
 =?iso-8859-1?Q?u0mhv5G8vr2g3o3v2vfmAk1ArzmSiWG+LToWrWdlYfZnej79z/lvpwcLFE?=
 =?iso-8859-1?Q?CtpLwnMTBQF4Y+cM/kKkdjPS0t5s2UutIcclfWG4zuiq6P2gbevo/cdLZo?=
 =?iso-8859-1?Q?xxOzGIauv5PPogqoo111Czxmpj3NqeVEixIui4sYzZojuXriTTvzNrDuVa?=
 =?iso-8859-1?Q?BQHzssivL4uU7VDol2KBU6xQ6O7H60LSDv+CTs+Eu42g6h8mgjre0LE8pn?=
 =?iso-8859-1?Q?0IXCBG2FPsnSrpb9e+MgNg+FU1QmP+b2DUZRuLXTZh2DupNqassrn501Cy?=
 =?iso-8859-1?Q?59ETG3JQzCunUJkdcve7+kHPGFtCsFYE36B413/AyYx1FA9jEUgutY9rS+?=
 =?iso-8859-1?Q?ZYxFspMhPH31yrukTW4Od063fZb3NJb+J77Mqe1Igd+S252uVsbNf69XZF?=
 =?iso-8859-1?Q?DcPY1USyKIl8+Up0EAHfLMrvyFO5jCpsPyRdMGSa3eFZUvQ6u03Sim1yFv?=
 =?iso-8859-1?Q?rk0TJ8CRUSmTKm8GryOLjW9r/VofYmSixlv6bU9jr+z8FqLswpQsCq6mfu?=
 =?iso-8859-1?Q?/9auHNvaZDKpPmIQx7jDGvaOnY4k/xCjkOmpNRE8xrpqlyp7Y7jljXSFEQ?=
 =?iso-8859-1?Q?acpiD+upDlldq//usfMAauGKBgc/DjFQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5262.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?ESnH2kZYe+pN7rpoYiYE5qC3bOIlHh5YaDPmjTV4BpKdfCB5XpYUSwtT7i?=
 =?iso-8859-1?Q?kPQ8o/LHLk1zc7++ySaoRYiezd01zT1ZALXwRy3tV8PY6wGgq9UiGrt562?=
 =?iso-8859-1?Q?2Vd1B+DNd4k8Bvm/EOJ3L1ICeyGN3ikI1obLuaHFXjkOHBHGOImh5M1dvt?=
 =?iso-8859-1?Q?IW74juwc9D9XwQgnFNXfNaBaPyrSme5PRg/FvuS6T1st4YwHhetBrQKrcG?=
 =?iso-8859-1?Q?wgRUg2eMzgzBy1j5lDO6pntTbV0qxYpu4akOFZWjJP1ICKP2hHtkkBQsbs?=
 =?iso-8859-1?Q?rcuXjBwMMFMC3MaQPsTErShOVWL2WhuaQujFdBGH9y3g8mCpLG7qp9fw2O?=
 =?iso-8859-1?Q?VgxSgLhjrY0Z5fUHYTfe3/adN8gW2HSfPDnS94+N3QqS56CT9HBzIbx0lc?=
 =?iso-8859-1?Q?WFjqlg/bUJJwKwB74NKJ6Zp1V8F4TyYETJqDFsIGZAFrF4CJI1oB5FRJZq?=
 =?iso-8859-1?Q?TiWZjuWgpLXry2eUjy4d+F8wKzWYo0DGBupJn7cFZezIHh1+iDRC5a/lax?=
 =?iso-8859-1?Q?Qi6ZJETRR7einF/9z4EQaS7QTi/IYwnzMbvuVLWXmH/N3cTRDURb+FW9vn?=
 =?iso-8859-1?Q?flqPh6o7G9MAOKTPsl9aJ/llHaGpfI2rHDzBaZGMJEApSurV/SkhRBlYVH?=
 =?iso-8859-1?Q?f1JzPkgH9FpiHUaFtQ0e2BTBfz63KCMjv2EHKBKSbaIGctc4qs9+lCBAa/?=
 =?iso-8859-1?Q?fI/FgKRe16uwsZjRcHL4hZ+dUvPQq8pLFkJ7nOKQ1vXzsYKOJHU4Lad/MK?=
 =?iso-8859-1?Q?6USmPaCiSsaqL9SPO0cdezqQcpQc/d8mpkdPx3uSwp2aOQP94B6u6Bd1rA?=
 =?iso-8859-1?Q?DBJy5AQzK5OvQab4O6LR7DDI7ogpMCq/03v8M34b6JxtkJiHkPds28qQdr?=
 =?iso-8859-1?Q?04vU6Fsf5giwqB8D1ID9qRdi66HALP5VSpRbI+lAuNexOSO5rTnWgNb2cB?=
 =?iso-8859-1?Q?m5lztgFUqPurvwocAnsSnSstUdxtK+aNLs78tIMvZ9Z6O5x2mQcTlNqaMk?=
 =?iso-8859-1?Q?xg6haMNtAJv4QTZGMtXC/pILw7cpCJkUhX2KX8FkIKMxgns+KFmYjwA+wE?=
 =?iso-8859-1?Q?NWaO2+F8VA7HaisIV0xIJPjZKFHp3P/58VyYLLYySjVhO8iT9vmyVlRlUI?=
 =?iso-8859-1?Q?W13k9YRpOFj//WN65xAJ5Z7s5Llc5EKFrmgD/he+wMXprHZwiGFOUdt2a2?=
 =?iso-8859-1?Q?BOecA2M7ESYYpXjtev56bxSbhLYgUFCVjafatNi4LGuZD97Wr+Mg+jzfdo?=
 =?iso-8859-1?Q?at5waU8kazE3Twxxooceu9P5RCyydOqOYsiabKxXxcfXYZu2XBbQGfUtur?=
 =?iso-8859-1?Q?ohHNY14yOrpA05iJmQvW4hoKU3e32GBqEPxaSvu7B1fOWP8Myv0lO5Gb2X?=
 =?iso-8859-1?Q?BBr/JjqeESwBLL6lxJLwm0ZUZ03ozV/Dhn6mbwHuCA65HJWQi5uIW/Qqla?=
 =?iso-8859-1?Q?3upfxnzwGD1Vj7qJ+X/qd+VcG/xe62G4MkCgFpTbx7v9yVgf4g1jgH/IWH?=
 =?iso-8859-1?Q?p15PtytMm+Mxzat0AuglNRViaPK2tMNSMWofGJpBV6KCnz0S2pOFvioebi?=
 =?iso-8859-1?Q?OVuqQxjERIrASdp0xzt0nz8kEUD+HQkNPD3e1kX9Bf9vvSKPCYBU2AoKR9?=
 =?iso-8859-1?Q?Tyo7ElnhXCoPW8Vf+yrrCtgHthQN6O/d6Q?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3071688f-bfbd-4186-6e35-08dca1ef7c62
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5262.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 21:21:53.7235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /LkJV6WKfxm9UUD3vmiiv11LjTfPnlUq496kKa8E6Ckg98d0hcuvN7L+e88/pMDmxHscHIs4hqCnIKg9Zx8biw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7407
X-OriginatorOrg: intel.com

On Thu, Jul 11, 2024 at 12:44:23PM +0300, Ilpo Järvinen wrote:
> > +static bool sbaf_bundle_completed(union ifs_sbaf_status status)
> > +{
> > +	if (status.sbaf_status || status.error_code)
> > +		return false;
> > +	return true;
> 
> This is same as:
> 
> 	return !status.sbaf_status && !status.error_code;
> 

Maybe another simplification

	return !(status.sbaf_status || status.error_code);


-- 
Cheers,
Ashok
