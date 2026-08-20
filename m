Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B594772B1;
	Thu, 20 Aug 2026 16:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787243560; cv=fail; b=DQkcUQL8BZc9EJDUop3DopCJeELa4XSfMhlLlHVwwtJHLT9kC4lQeVfHW9HEDyJL+G7671sYUtUw9t+yogj+fVKLTf79oCjQpfKVn++6AUZtuObqOlnQF6krywJlDHtfCjkUIgPcF7AngjPICpqBfktkF3tnNNafd9dST0J3gMQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787243560; c=relaxed/simple;
	bh=C67CQLIibrrjF/6fF+1TiVE5t/rP+KA0BtFyVxHOJgM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WnBGUkVPn3/9iG81NbASK8J6LjlC/B1sMX4QRSrjLc6nABgZNQTuiY6MUwBPhgtq4twkJz4pPawiAGuiF8Aa5fl6FVQhmUC4cLWoQLdt1PFHkRfdTgOYqrZ2KM/TieHMx1IAq3md5ZwlRG7x24fQpwwvQ4XVzCukN0GWcV3WakI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jZmuEZqi; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jZmuEZqi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787243559; x=1818779559;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=C67CQLIibrrjF/6fF+1TiVE5t/rP+KA0BtFyVxHOJgM=;
  b=jZmuEZqiJMp2N3GvRZ7jOBUUNJHSsVKgAb3nFB2R+EdChisOO0MV9pMS
   Ya2DNteHvxUyxxHOHwRgPzWnYljfmeCVCnSCL7TuN6R51b2DiyLtiQSkK
   pvkos8huyND4nAd0ObqbovNb8vOIJkjO4Fc0hg+/nRqdDfSVc3cYGoWO/
   w276R9VWfF0Lp8JP2mo7NGPfBYK2Bv4MEQyEMmpXHHB9slGVU7l1yb1Ic
   ld6i5kbUU6HOOaXaNlxwvvS7Y8qoDE6BLtdaJ7J+ZDPsRbiLRoMiSBVRd
   SwzLf0oU+Vii92WvhMcVfrvip+wCu/J16mmoqAw58+7UUp9cU+Wf65oni
   Q==;
X-CSE-ConnectionGUID: MYKCug6vRJKGtYAvSwZDnw==
X-CSE-MsgGUID: zkVsKd3zQg6GRcyLzMnPuw==
X-IronPort-AV: E=McAfee;i="6800,10657,11881"; a="87801793"
X-IronPort-AV: E=Sophos;i="6.25,233,1779174000"; 
   d="scan'208";a="87801793"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2026 09:32:39 -0700
X-CSE-ConnectionGUID: iPsUdgWSQpSuzttcwxQ5Dg==
X-CSE-MsgGUID: Y7p39ROMSCGZMc6jqiLnvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,233,1779174000"; 
   d="scan'208";a="271305450"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2026 09:32:38 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 20 Aug 2026 09:32:37 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 20 Aug 2026 09:32:37 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.0) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 20 Aug 2026 09:32:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m2qSBCRoMVfAlWD8xcizAVStLtlwQonV/HnsD5FDLTpS5v6qai5/7I2gLBCk682FcBnLssgR3sct/PHzJHNC9mF4XbFldh1rUGp7yveDfqJDJ4GV/3lt0Pmwt5f+CNPt0MNNjK0apG84sAtJFakcu10RG8VfDz5Udd2tfnZVAtem5l2lsaNu4bVs36Wxqf0ZVdiIeEd7vcaQPWfuORw/ctT2t7ktMVb6yMSzUx8jqRjNrlWlcw7B2isV6jCcVrctXKsE4WUePGI0Xyh+aIG4PrOns098lEbyPF2i3X0rzOV75ilovwyGku3bcgr4JO7om5eMbgqy0OEAIFIZ2j6+2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=51m+Wr0rKlKFEk6QOL19zkzHn5yRybEeJOKu+bUFlfA=;
 b=Qzjxrq/p6h2eH+fCwO2hZ6vxwviXQrP1yf1ZZ3uV6lfe2Wk5UEmOVdfVPoJG3F7BF/aL89dt9Qr1mREANf+4zGd/SUo3bYQL36wfbtKtKb7T5c+g0HAMe7EuDOGJmUKb4vunV5nKFaWOIVuoT2HlKBSVESxIeaDLLYq4uXKvxWIPB5pWIzCH4qqwrYtB/pu3dppE3qO5mVuBbFvBkEKVfjB8ZzmjwfGBnQ1VUagXguqrkbvPltPMkhuKDhZBTJ+S1G4P50NmmH5J2ECDsf+j1YerytJSGav5vsJXMQRvFEN+GccBn9pm4j4q9zd7EDWcut4wyiTk7VzaubGdy1Hiuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5214.namprd11.prod.outlook.com (2603:10b6:a03:2df::22)
 by MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Thu, 20 Aug
 2026 16:32:30 +0000
Received: from SJ0PR11MB5214.namprd11.prod.outlook.com
 ([fe80::5926:3836:4212:8640]) by SJ0PR11MB5214.namprd11.prod.outlook.com
 ([fe80::5926:3836:4212:8640%4]) with mapi id 15.21.0339.008; Thu, 20 Aug 2026
 16:32:30 +0000
From: "Li, Philip" <philip.li@intel.com>
To: lkp <lkp@intel.com>, Steven Rostedt <rostedt@goodmis.org>, LKML
	<linux-kernel@vger.kernel.org>, Linux Trace Kernel
	<linux-trace-kernel@vger.kernel.org>
CC: "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
	"oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>, "Anubhav
 Shelat" <ashelat@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>, Shivank
 Garg <shivankg@amd.com>, Ackerley Tng <ackerleytng@google.com>, Fuad Tabba
	<tabba@google.com>, Christian Brauner <brauner@kernel.org>, "Sean
 Christopherson" <seanjc@google.com>
Subject: RE: [PATCH v3] tracefs: Add read-only eventfs filesystem at
 /sys/kernel/events
Thread-Topic: [PATCH v3] tracefs: Add read-only eventfs filesystem at
 /sys/kernel/events
Thread-Index: AQHdMJbUMdgZTMedP0KFwu/+6a9ImranIZ4A
Date: Thu, 20 Aug 2026 16:32:29 +0000
Message-ID: <SJ0PR11MB52148E819CD23B5ADEB4EE1EE0A42@SJ0PR11MB5214.namprd11.prod.outlook.com>
References: <20260810160708.3460a2fd@gandalf.local.home>
 <202608201957.NHoAQjoy-lkp@intel.com>
In-Reply-To: <202608201957.NHoAQjoy-lkp@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5214:EE_|MW3PR11MB4539:EE_
x-ms-office365-filtering-correlation-id: 368b32f7-32d7-48bb-b801-08defed8a0f5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|56012099006|38070700021|10067099003|11063799006|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info: ySz4Me2FENws8aP1t8Kl6WY0pXtqXFoh1QVPyRvaXblmMBPKUJ3KJL7+WjFoALwFDO5+CPVTib4Rne2ZAbW+QZyrrBcigG3t21eJsB3/JhAyosQpy80feAHZGV6mZWTnbwKQ79uGjiG6LJPo4xDzb/1g6cG81myNjoZrVPrJLDQ3sctNqBrEYDbQmbCP5EpM+SZh4kHLS33UyCx/+UF+5vZm4C09/i0gglrliiVpqURFS1oAv0UEGim5UEp3IeExyJYyeMwfSe4O2bx3b4ldGQ1bWbDHFLD+nTyYOamxTrtnlmNzcFKLn6cjLjaLnN6Gzb2kvYLfLEiksVl7Gpxhb5O2cQFRzs9ndR83lRSx+tXAtJ1omjMgMYGnrrwrSLNssbsjS7QcTCDFr2ndO0jyheW6Ad2wUYQuHkDbtUVpxOoMJuRkGv3YC9TXW1uCy8Wy7Ww2qPbLcoRBItWQY/KRa0y1WY+GNKki0eTvvhqWSOh3cPZ86PLCnnIs9VF2MOQIj04JvohKSoz5r4kzB3SqJfLmVO3uHGMJU250Ds9N3dOY4wqTcOV3w1e2ZVsJi2FKw+8/rm7QowwJapDxa/CskbKN3973yGXfUbHSvnoGe+62VSDPLE4y8lk+84BSK+v51pr+wGj3eAlwYfkd25AfRUzi/cchtYmXf9NakFFPALo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5214.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(56012099006)(38070700021)(10067099003)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RyhIDHCNo0jRlrpCtJ+sKmP/J9hrxlyx1wSG1K+ecAkcM3+m8WmIRMU7bWA1?=
 =?us-ascii?Q?Nw4Ucs02h/hMNsUTYSXMrzqzjCzt4NA+OmURZMHF8hV6PakqivQsLKLace1Z?=
 =?us-ascii?Q?E+bIsPWJjY/D92LEqv7/bVCmSQJT0QMq10Wg5zGNH8LKeGNqc2lN/dVeOuux?=
 =?us-ascii?Q?//cL1EbTEFBEIZlkc2qDPIkD9M1mA7mhQ4LzNN47IDCIUXcjlNHMeNFI+Uyz?=
 =?us-ascii?Q?FR7yjLgaY+6e3wuHfr5EN6X3cuJi1yVjoRjSe7EcbDMOvGRehLLqnCPnOb5F?=
 =?us-ascii?Q?JS9VBgTQuRwoRL6cEiA1kwQmEcnOOObE/d0qAr9tPbq0GPuGx7/cxKZp6SFT?=
 =?us-ascii?Q?MOoBHi+rYINvmUVJQc1whqnGWmzfVEhTsely95WZ/LzV74ySFkRPuGGutq7t?=
 =?us-ascii?Q?g4x88ylTI9eSeqmqobf85MplMcnKfrCE4beZAtEEoskwVnB967AmTnFtTdl3?=
 =?us-ascii?Q?/NQdOhbUrkkKdU/sBNt1zcbm4cTH6zwjpK8x7TrVudBh2dF/1djfQjRq4Mh3?=
 =?us-ascii?Q?MEjSFyQTQ3sSyrIyZKQ39XNowAf3RpooHGrHbIRrLOT25tPyW26EAAN+luGp?=
 =?us-ascii?Q?NYJoSBGhyzfwaHsmTROSLKHKCfhk7aCsRscXSDI879EW2XuXmtMgo2A7wrJd?=
 =?us-ascii?Q?xm7PXoJhusu7fNudeYgolf8nHZ3HWsFFPhQBvX7MzaYDWaaRh1zJfNGLKZJ9?=
 =?us-ascii?Q?13X3Tru7t+fQJ9ZirRr8w0OySgVDKCpf4t17yQboPGUjEY2Bm7ys0zaDmPMy?=
 =?us-ascii?Q?1qfUjcQNmr9HEU8h6bUw8Jg42DlrK05/vUfAxzpGDZv3jx9Hw6TaT2QFPL1d?=
 =?us-ascii?Q?QqWmkYWzcBMAlL9IiRwMzKIs5FCgjYf0uBbpED94atLdCDon+9Cc1cFoWpF+?=
 =?us-ascii?Q?lvAg8TUrbozRfYT7JQHAhEskAtFlVZWwZMeXd+MCrHcKFRQ/I9fjIF81weeI?=
 =?us-ascii?Q?7SFp1uOdrl27eCW97nZm4TMdqhOtqMHqwMjvjKnZ8ggO03rPkgijim8pDNzT?=
 =?us-ascii?Q?l4KBELuNm3/CqJB/LOIhS8ChDeVGtI7+LidVMQpMoe9pwlj6/Qqp8j68Mozi?=
 =?us-ascii?Q?k2vrage1+7unWz0T0jOtY5/wL/1z0NUe1bS1LQ3scrAabm4xmO4550cGLOyF?=
 =?us-ascii?Q?7Y7y0DeW2BQgGVhX5OqOs477JwVBv2N7qME0OZEasCLfKYtdAgyHOsoz0EpN?=
 =?us-ascii?Q?p8eAmf+2b1p3cFTxsPJPz8NR71Uvtlg5q4kV9qDBUitmKJLae6ifEHJop0Ju?=
 =?us-ascii?Q?P4FoVDvPZvWl3WyoFn2ooZNGpynoHFOErjhtGXFb6gNcU2yIcxxd5X3sxxdu?=
 =?us-ascii?Q?lXdcb4XXpW7gvPFH4h5SPqnS9X8FybVJSTOHdzIX7RuZXIFtKXFTs8X+QYG0?=
 =?us-ascii?Q?WcZnDto3R8sXExoVj6VmZ5YSW7YCmDSnF7P2dE52DwU9adAtsKF4S5dDcbe/?=
 =?us-ascii?Q?SSe42+E087zVNmz8L9wTHRF+XqrVSgavpXzo7OpiSQhxQI9xbMPWlesWUFYS?=
 =?us-ascii?Q?lAfidEkIg//JiZpr0PM0Sl8uY8BVvSqF9L8SocnWGn/9kWnnU7FtWI4XQgQR?=
 =?us-ascii?Q?qu7UqMm8+dsGFjwwDuiuBSHeo9gFoG/WXYN73BHmIwSyYLHNs0F4rttxUUeA?=
 =?us-ascii?Q?eWlWyPMMrbrD/L7wf5pDSINQOlVFM8qsex/Ax2UzSqKIVhG8n/Tr5DdtY0Kn?=
 =?us-ascii?Q?QoqLnsjEFyoD7xUU7W6Tz56MRBuJCZUBnHQKd0R50PqzEv3N?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: XCcKD6d7aLkpdEVC+lF7aMTmxDaL3kuUIDdNSn/SCHJQNmBDhtJjeB8ENb6xq/jeuRKv16JHwNziaemRMn8jF+EM89QUvTYHjaLpkr1tp2Tn5IprCUUE29NZa8CkJlUjRf4Fp3I4iNmBgfQnCh6FlYp3XyaSDG3iyi8OPTLQFSkjsWbm8M9BL/A1P/a5e1MemCwiZ7vMdo87pYTrimV01PiFQudSG71bLA+YLwG+OlzgnnfLVkt0SElMtoC0C6529aPsl9bQdiEV0utEfCSQoc4LCAzFaJnhUWrIW2GZPNmPxHIOKf1xSy9FNRdrSUJvrAw8TDx1edRKvYcCXwANIg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5214.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 368b32f7-32d7-48bb-b801-08defed8a0f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2026 16:32:29.9750
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cOwKUisBKlQfnKIEpCdcx3Pse/mAn1jorCH35xfTJw0Wy3X7mT0xUtOCnUi0ai2hiQdzN8HIl/NKD0CrXtj/BA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4539
X-OriginatorOrg: intel.com

> Subject: Re: [PATCH v3] tracefs: Add read-only eventfs filesystem at /sys=
/kernel/events
>=20
> Hi Steven,
>=20
> kernel test robot noticed the following build errors:

Kindly ignore this report which is reported against old patch due to bot is=
sue,
we are actively working on the fix now.

>=20
> [auto build test ERROR on v7.2]
> [also build test ERROR on next-20260819]
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

