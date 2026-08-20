Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F44B47D46D;
	Thu, 20 Aug 2026 16:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787243518; cv=fail; b=XW2X8REAPBTF9Y204bMKUmmv6udOCaKBqciZB2cwNbvOvDQBhs+elxRg9gG9dCNUqrdXqLGTD41Yx59A0lMbi5SzvP1a3/u9tTY5Ts/kb5INuw2RGH8dySfn7bnbPBXXWsZcKqfsRgnHd4Y7hit9K4Wv9g7wVtl1nRSPr2PHQpU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787243518; c=relaxed/simple;
	bh=r1q5O76HuoJ36ohTbhjldYrAEYTI31uwwb/C/l/JtrU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mRsQC6yAHiq72+YxjkE2DZurO0kP5zhfVJ8JUhMS2LhuavNw6mqg40lEzy13cyfYv/1xW2tdy9sKt/IaArU534a812uUvSToSxJHjIPjBMxNUb9CnktlTOuUVLod0W8isktgfzuI0EHt8tHCsqdFp+5YpnT65aadQCYfeoVcpO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=klJ8JkkY; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="klJ8JkkY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787243514; x=1818779514;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=r1q5O76HuoJ36ohTbhjldYrAEYTI31uwwb/C/l/JtrU=;
  b=klJ8JkkYtnRjoPJbKNk9rYJCGHbgOkaVAIJcrjTKWWx7H+SC8jNKg7ef
   kF7L1WPcmBYQuVr7AIhajsPvEOsp0jA+peTykSmlISFqriIf8joDy7Gr/
   3Rtr6/A5EKF3KqTNR+OJl8EP0rm3UgaRlOJenunzAMMqYBJbps7E1BN2z
   dnRKKAA3Bi1+S2rYOBJDJVAWS2grerZANF/1Iqphm+N9A5YX8lf6rVZHX
   O/rSZrKoHcXUWuhftE4m2R9UoAlP3Myc+gh7JddYqXCil0sGYLPcSKotH
   suIG8K/UG/Y1CQQA/UiyFkWYiOmIW9+5r/iC80+NZdHd3ChsLVq7kquFN
   w==;
X-CSE-ConnectionGUID: 4/j/MmTCTXWyFO65/6Fexg==
X-CSE-MsgGUID: lyLhihifRHqNlxl9YfHb2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11881"; a="87989528"
X-IronPort-AV: E=Sophos;i="6.25,233,1779174000"; 
   d="scan'208";a="87989528"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2026 09:31:51 -0700
X-CSE-ConnectionGUID: F0eH4gnaTOWAwsoJ/zqumw==
X-CSE-MsgGUID: 9RuW3TBvRwCaFnqTceGCqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,233,1779174000"; 
   d="scan'208";a="263449229"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2026 09:31:51 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 20 Aug 2026 09:31:50 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 20 Aug 2026 09:31:50 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.21)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 20 Aug 2026 09:31:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VYuQqnRu05uI3zWkzh2+H3fAMlPeToOYxTKXw3huHyebxNJUcVJEWor/XZglpVdlOzM8Fnheu26YfcGZMhOXpzZ50qEiklGMXEjSwtbjcmdH5tmZaxbZL5fDQIbIqgVpsdtZ3Sz0Fa4I0cdvS3hi0grPudY13oksGjir+U+bEF3MwT0ksOIj3fiTlUWMWt/I+8svsWuA4bmDCp8YdTVFSJ9qHjGOelCoe5+8n2at+7GczK1ffliVKtfkfPN2KlBlZBjLcl25hu3Q9M0rKAyYks77tWxO0bwKBDtf1nawla1oImOwPWSg1wcZfJGsp9JsUaWJpaeuvVP3+bEO8n8/fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PGhPmu//C5YR/YRH1ePolMu8915Qw3eZlBbYD5LmBQc=;
 b=OeAjmtNOD+CVhkTz8ONW7/fugKj5Qnh7u/E8pVlSFSu2ruuhiYRuPYt7drdsTSlLVFZh+sh7jt3YytJSSOCkPyy7Yof5wKi8995E7g4ZaYFUokkISmZeLM/HuDED8INxirGLdTQQRi6IEapIDufDCU0Nabp6q/deRS3mmGeBHVtF60hDbQeDeyeH7DWDhgPaaqvgjHss1Iv5zREga3b+HwKFY9U7YZuPbfK7cXHbme7xTDjijWvF0T8GvlJ7W91vmVVl9RhcqhvuoU06xN43q/YpkJ6cdPM/YS8zsoxe/DCHMInrprbcv26YwUk1jUPpkl7OsyF+8TEBmtEUPe1Vog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5214.namprd11.prod.outlook.com (2603:10b6:a03:2df::22)
 by MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Thu, 20 Aug
 2026 16:31:46 +0000
Received: from SJ0PR11MB5214.namprd11.prod.outlook.com
 ([fe80::5926:3836:4212:8640]) by SJ0PR11MB5214.namprd11.prod.outlook.com
 ([fe80::5926:3836:4212:8640%4]) with mapi id 15.21.0339.008; Thu, 20 Aug 2026
 16:31:46 +0000
From: "Li, Philip" <philip.li@intel.com>
To: lkp <lkp@intel.com>, Steven Rostedt <rostedt@goodmis.org>, LKML
	<linux-kernel@vger.kernel.org>, Linux Trace Kernel
	<linux-trace-kernel@vger.kernel.org>
CC: "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>, "Anubhav
 Shelat" <ashelat@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>, Shivank
 Garg <shivankg@amd.com>, Ackerley Tng <ackerleytng@google.com>, Fuad Tabba
	<tabba@google.com>, Christian Brauner <brauner@kernel.org>, "Sean
 Christopherson" <seanjc@google.com>
Subject: RE: [PATCH v3] tracefs: Add read-only eventfs filesystem at
 /sys/kernel/events
Thread-Topic: [PATCH v3] tracefs: Add read-only eventfs filesystem at
 /sys/kernel/events
Thread-Index: AQHdMJakMdgZTMedP0KFwu/+6a9ImranIT5A
Date: Thu, 20 Aug 2026 16:31:46 +0000
Message-ID: <SJ0PR11MB5214A6CF39B29A92458545E8E0A42@SJ0PR11MB5214.namprd11.prod.outlook.com>
References: <20260810160708.3460a2fd@gandalf.local.home>
 <202608201958.Dlhk7OGz-lkp@intel.com>
In-Reply-To: <202608201958.Dlhk7OGz-lkp@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5214:EE_|MW3PR11MB4539:EE_
x-ms-office365-filtering-correlation-id: 46ffe1f3-cda6-428e-6ecc-08defed886e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|56012099006|38070700021|10067099003|11063799006|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info: Oa/b/N/Kpq+na/sQuy0M+c/RGQh2bTQOxOILODUkxjl50vTNigF26BujrT30MOLrOaTjazIucH+zpK48asyQLkttyYcm+OGvPuG1y1uOZnHvm1N0xj3gT9avip8vkkGPZoyjWnow0Z0J1UEm1mpcvz843vL7tDDZrJ32uVU5tAnbRUOjUgNOwZTsBK3TWKBbqQyDUtNAMz14XpEfcpHFllTrvglfMZn4QD9hNRt6MNgcBPSNLUm59TIMI9RCrjuY9VpNkqaR/3i3hv5zHsv/htFEsjciFYrfBeLh7aqKpQJRKqedh16gDcW0hyP2ChhyzLYG7W+a3XGIv5IzWyKpPsVjbKoofV+bTaBjhOgafP0ekFN5A1Oc3HXAAdGkqa21el+rOAyAXS5fV5lHIrZBGzVGoHQOpcw+CSTFtcVU4M7b+u2AWp2dpsr5wUt7ynxczbWEz/Hl4Jml68A5+4cuuziVXyVIEynB9iIq/wd3AiY4SFv3i9A0jl6+lY4VmRSrfM7eE6vMeOhg+fJ1sGR+s9F3xIBtr+fRirN9WVwKigisZjb2fvXYNEsQSqdkzHdwReOYYayjwE/dPt+rTmpv71CvURYIOKp4S/QuK8EtCm93X0uK1ZfJUeq0EtNiPx5HpaLlFDx6W2tD+qvKDYSCFH4wp+B885dXN7+GDFtDBYI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5214.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(56012099006)(38070700021)(10067099003)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?msBRopkd/Jz8ZboTVwK931Uf/+1z4IDJ1Jp0V233jD41D3ipUKnBo7q4AbwH?=
 =?us-ascii?Q?/wzH+L9gGu+k6PAITXupB/U+codbGHBLeuaGEJD/Y46G9mVipJ1KpdtjMfYs?=
 =?us-ascii?Q?IKytD+1hEjKJZvDy7Uz/DkYCUGEP3e+xsLn7E3JS9biqfZGjSwr/EKLfuUaI?=
 =?us-ascii?Q?Us8q81iZw7efJJsnrhI0I4zP03AmzsGKUnJ5qX4FHfb1D+sOtx4GwCE4AULy?=
 =?us-ascii?Q?SvEvornacGpNi3nSDs8HXgKl0crDgg3Y4EVJ76RoxZC1UR2D31d/gly8A9v2?=
 =?us-ascii?Q?gufIN5d9ajlGGxZ/49J6/n3EOVzsKXk4Qi75VerxkbEZirjn4xxb53S6JZqC?=
 =?us-ascii?Q?gXQL50KgVVcwNgK5Fo2yt8IAUKnfklh4K7NQM43NxccXFv07B6iyyb/cRInQ?=
 =?us-ascii?Q?KCqoPkzKhn7A7JIASw3m4mMAc+RGv6Kypg6ThcAjHblZVqfY21J1qHELeLc6?=
 =?us-ascii?Q?MANEpREkp2mvHaZpm//WG3WGYqfv6XgnNEpUVmUMVj0Jn7yUVoUE/e1UI3xY?=
 =?us-ascii?Q?hDlaLB+ezrh4hWGauMx53M9tqFz9Bx7WiWOK2OKjozY3ANZFJssqJ6RA0f8v?=
 =?us-ascii?Q?rureFc2vxdqHB9CgZ+iDPvT0TmaGgaZRmRxaqQ4gZd5wp7ytuIqUfXoPYelX?=
 =?us-ascii?Q?eAxFEYRBrlG81EuIT3+qPavSAtjYptq7DdD1eBz8zaI+wO0dKiCfuWykewez?=
 =?us-ascii?Q?u72NW7lfVgXqnZGxymHlKK8yPvukh2/Cjh3ucvX20BeAxTPHQLfAJcjrpHzH?=
 =?us-ascii?Q?iDNtZhRFASpgsmTRUGMj0hotyrMc0f3AsZeshqmn+aUku6IAoxSNEhm03l7c?=
 =?us-ascii?Q?sWM8eriL5xseVUrpb+iKoeSBKGfxbOlpbkg7YKXYU+TZI+yJ0ProupvgtAG1?=
 =?us-ascii?Q?tjTpZEjbS0iroabpfk0YU0QBlnOoETiAsWpmFGHYDyCmk8WAe+lIdip65Fie?=
 =?us-ascii?Q?vf1Z2X5iXskcGCVC8If9R8CwiamskoDMHW034Z7hB8TxMSbyCRvzpl54Z+nY?=
 =?us-ascii?Q?hPzSLUFS0QGL3wxXQxUuGq9B7Sdeqy+aavnhg8BwlnsVEF1LqNREFfYcPm3d?=
 =?us-ascii?Q?6M37cn3swye+2TXS2Pj6Z9AMvpEz3qRuvZh4l9JU1psvvFD5ZsYmp3Bt1TUT?=
 =?us-ascii?Q?/axIibvfJxW3OY2uetE8ZYk6mOK1WY+dsa3jBqfb8C7/rgIwBBGFhIoZ23LR?=
 =?us-ascii?Q?wn8ERyuiwwm5xNO1L5SZYN1rCDZtgHKZYS77Hx89d8/t9cQxUbY72rsx1E49?=
 =?us-ascii?Q?OB4L1FQB88kBqfJXEmrIc5vdTaEhM+Cz+vJo5Uf5Ji7AFK17SceEaSgCUclE?=
 =?us-ascii?Q?9PFEHQOIP/tdZrWkF30mtEuJwP1VTb21oCnZoHo6hXrRuHLxCs4X/00W6zmT?=
 =?us-ascii?Q?2jvojyCg+NuH8m7+bmkVNHHWy8JMNJf0VD6xeP+4msedA7DN6h4shMjqOxVv?=
 =?us-ascii?Q?YIGx2nl1Hp4OarE6gpC6kc/TuH0QeUpR0XS7hZTkxpwXVvUJ9OBdeRcqSvhN?=
 =?us-ascii?Q?sdgNz56vDpHmcubPVt4jKjXWLY6sdVFn8PFdLNIFv49+hyFoJyt3tgtnmhrX?=
 =?us-ascii?Q?07/8vp/QmvpNjBhwzzh82pHmmGH7YPCrPYSRipv8olBAdbxgn4futFF+XRTM?=
 =?us-ascii?Q?5M0LY1prX+AW6v1CkdxN+oMA42DG63ivU4CqwHRd+A+6u6ypaGd4+iJ66Nrm?=
 =?us-ascii?Q?pfSLrZmNNdd5xdc1gJChJHgZRnsPI+OxdHDG1FUkDoWSr8G3?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: YayoXPIEeoC2hc0QusfxyuyDFSCQVDBC/t9KKWhsMohHa20jZRaEOcr3jJvMkFxYvMDh2Jbl/KyGaqoqnHaacA6r+HbVQ08Ad1btUJYSTJP49gkIlbwoZHtIFAal8CO2x1BGWnPnQsPuD1ZJJAm1DSZF9IpkZXF13Sw/LNL/ix1O11Gwp89HNBIHQFmJbYkemGzLEX2sK63EYhqMVJLeZXJupG+HbdhiYwVDulNnQTPkb/G42Iet51AqvQ7vwsqtydVRaSBf21s3oWya0mizoNwkFQDZ9KPfWhMje1kSPFKlpawu1/oQSj6W2DjuUDppOBrpVe2ja0TRl0gGPRgGkw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5214.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46ffe1f3-cda6-428e-6ecc-08defed886e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2026 16:31:46.2346
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TmaVGKdY0TINXB1TPi45ba5l6rCSRsXyTKbOKRyQixjCp4bqMGkk8QRMwyFZ3iTYf8VDZ4iagqy3WA7ZUaXR8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4539
X-OriginatorOrg: intel.com

> Subject: Re: [PATCH v3] tracefs: Add read-only eventfs filesystem at /sys=
/kernel/events
>=20
> Hi Steven,
>=20
> kernel test robot noticed the following build warnings:

Kindly ignore this report which is reported against old patch due to bot is=
sue,
we are actively working on the fix now.

>=20
> [auto build test WARNING on v7.2]
> [also build test WARNING on next-20260819]
> [cannot apply to trace/for-next linus/master]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>=20
> url:    https://github.com/intel-lab-lkp/linux/commits/Steven-Rostedt/tra=
cefs-Add-read-only-eventfs-filesystem-at-sys-kernel-events/20260810-160708
> base:   v7.2
> patch link:    https://lore.kernel.org/r/20260810160708.3460a2fd%40gandal=
f.local.home
> patch subject: [PATCH v3] tracefs: Add read-only eventfs filesystem at /s=
ys/kernel/events
