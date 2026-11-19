Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.16
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795132760;
	b=k2HGLjrVVHjqKlK7ZN0qalLup9QUCXgRzsoxSSFEdkLygshOXRBsD14i2OicA4nyMJCG
	 j07M5jPQoo2Od1X3UafsXPk6ZLO1zwKFb2i5B3Hlg8PGrWL+JXuGiAxA9vvg8rQBPRkg2
	 9YWSvt2cE0Dww+bqdyWb6Qsk0uQU2VDnI6Td7vDiX2DncJaGuDq2hZpAKyvZSXhX9+6BE
	 IWNRXvGBa9MZgoVY+L6AybhSfiX8t1jbLE8dDQPqfZkk+8anB/H2SPFg3FUC5R/qWORzk
	 Q7vOiHZD77UY5QEXD3XrX7q88iX4Trh7KD/HDlVoXYjt37nMZsAv2x52gaHOYGruWWg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795132760;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 user-agent:x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:Content-ID:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=f5TO8y8F61TmjN1kcO1RFpfGB0WYcqzZiemWIcEBZOc=;
	b=Pl60SWtCTDpT8/uVEU2C0VWRqF9AuHfjAmwX6/Wgab2ithNaSl8jG8opVyyJiurKrQfx
	 83tejlC/SHPxoqfGbY2Z3CKnPfO9XuH8E6vw2IpaMi3EXhRtvSTX5mppMKlCqPoj2du58
	 i+3b5udTzKU3oFObkxX0wcz7VWMzn0q6baazHedyJEWBI9xio9LLAf2LMk9RBDn4fLEiR
	 tYUQ8nLxqoQbM24lNf3YKY2uAjYJ0MxjBgYueZtLExwU1vj3iXAWiVpCRxu3oHd2Klv7K
	 JxOLpdQzixqjry6NTqqO9g9ImW2DAeoPwZy9Y4KMXUci//k5/k5CLs8i2gUBPD2vLhA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=I+z5BoOU;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b="eXv6u/rp";
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.16
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF48A606A33D;
	Thu, 19 Nov 2026 23:59:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF48A606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=I+z5BoOU;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=eXv6u/rp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795132759; x=1826668759;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=f5TO8y8F61TmjN1kcO1RFpfGB0WYcqzZiemWIcEBZOc=;
  b=I+z5BoOUyo8MpxKsEIN2/j7zWM1bRQd3Lvezn0dQukhN7AjfG0oU01/w
   x/1LQe/X6JP6ZzhACfWPaKwEygmoXvfBDgV/1xpd54EBRSxuBl20iAHp7
   iY68MuSofydi2kr70+J5ZwBgrRNMRsTdEgHYghnPKxULFZhGMnExG0tp/
   N5MMpegaE88jxQNeWbLh6C3cvvALED+P3AMSO3B2SBTLVLt+Y63UY8vv5
   MXd0xjvh9r8LyTo85qlV0c8XU/B/spRf9qlCZ4v9oYpQiVJmhnYYjzRfZ
   Y+jc1YU+32OLuGgKD+tVucOJrooxPAEpq0l9yVT9R+1241xB/MhwW3x3p
   A==;
X-CSE-ConnectionGUID: DODjIqPsRLWDjfftxLekxw==
X-CSE-MsgGUID: 6xN0NtHWSd6xYteHTdutZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="4031337"
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="4031337"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 15:59:05 -0800
X-CSE-ConnectionGUID: lpVrzCH/T86kACVuAKMccg==
X-CSE-MsgGUID: Kn/CQ4nxSYWI02gABCy8TA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="10850395"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 15:59:05 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 19 Nov 2026 15:59:03 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 19 Nov 2026 15:59:03 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.60) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 19 Nov 2026 15:59:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nFcgvqdiQyWv4P6p86TH+4HxITw1jSvCkKyX9s1wOdmdvVS1Wr7JdwRV+nTgS5nRVvAtDaS0g4mnFvNW5uUuUSZ4AfUjTiXptPO4iVIejo1ok7oHe4CEw+yLqLvw9TSv7WUMwRt4MEPauMUgbLwL693dqrImkc293d5HnMcEVzFq6OzT4+Jok7hE8od7h8amAE9rw9yjrvW/N/6PjRrNKNx94e7+EQCMzf8Ub2ip2Y5U4yl4boX+Pcg4aIqvIkl7b7sf4CBEwK7sfB+Ymby9jUtjyi/cM92wDvQcobfWRqJQgaO+rq4TXI3GBmD6sWTdp1LlkyXsp8y9HU5rwB1SLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f5TO8y8F61TmjN1kcO1RFpfGB0WYcqzZiemWIcEBZOc=;
 b=FgngZvxVQgnVM4v0kmnfVUIsNoPno6gysCbONjLaxhPg11AZfIpHnXp0D7xeD0weFaTtaEP/ZZAZLMawJMsqZj+bBFUCCG1xEKK2jTi3cyLxRXzwBbsLH8yNgEu/GwE1xxKoK3F5AlncKQaCaPdQDMH5RnRUPUcsqujD5ZjVFcLFguttTMdLFi9FR2pwBlhMW6XrJP0sSsRPbScYaShFScBmJ1uo81erFAQrUJUBTsg5nUwDIouWAlwgmQgUC3Yl0diZuP1alxAO/bp9MuOamdhaB9ATiC7akQYaJOdbV/P2nxfWVssYL2BIQekz6zFBvYONn6egUN985PANTnRHCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f5TO8y8F61TmjN1kcO1RFpfGB0WYcqzZiemWIcEBZOc=;
 b=eXv6u/rpxG+PEp4hWiq5zpFB5kPxBNeC1VmPs2naQmrf5XeKwBKVHZ12ZKk3Jl/+N/QlfvfyCPnZFxJsW+ZRHFcUAA0nW5aELTwoyFA2h0E0iwKr8anZRZIhJ/iq5Bgs7+NN44xYP4Gthort+tztlU0pqWGZ7Wgb982hJt74QpI=
Received: from IA3PR11MB634048.namprd11.prod.outlook.com
 (2603:10b6:208:549::23) by DSWPR11MB9582.namprd11.prod.outlook.com
 (2603:10b6:8:36e::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Thu, 19 Nov
 2026 23:59:00 +0000
Received: from IA3PR11MB634048.namprd11.prod.outlook.com
 ([fe80::760f:f0a4:7417:6e57]) by IA3PR11MB634048.namprd11.prod.outlook.com
 ([fe80::760f:f0a4:7417:6e57%5]) with mapi id 15.21.0615.013; Thu, 19 Nov 2026
 23:59:00 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"bp@alien8.de" <bp@alien8.de>, "peterz@infradead.org" <peterz@infradead.org>,
	"x86@kernel.org" <x86@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"mhiramat@kernel.org" <mhiramat@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"tglx@kernel.org" <tglx@kernel.org>, "dvlasenk@redhat.com"
	<dvlasenk@redhat.com>, "oleg@redhat.com" <oleg@redhat.com>,
	"pablo@pablofraile.net" <pablo@pablofraile.net>
CC: "mingo@kernel.org" <mingo@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-trace-kernel@vger.kernel.org"
	<linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH] uprobes/x86: Fix bypass of two-byte opcode validation
Thread-Topic: [PATCH] uprobes/x86: Fix bypass of two-byte opcode validation
Thread-Index: AQHdeIHyAotrkAETLEe6eqCIRpu0/A==
Date: Thu, 19 Nov 2026 23:59:00 +0000
Message-ID: <ce2d62415a64636b8f31a67f8dddf0ab7fc878e9.camel@intel.com>
References: <20261116-x86-uprobes-two-byte-opcode-v1-1-2b6dbabead52@pablofraile.net>
In-Reply-To: <20261116-x86-uprobes-two-byte-opcode-v1-1-2b6dbabead52@pablofraile.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB634048:EE_|DSWPR11MB9582:EE_
x-ms-office365-filtering-correlation-id: ee5431cb-d396-45d6-5d22-08df469914f2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|366016|7416014|376014|1800799024|20046099003|22082099003|18002099003|3023799007|921020|261028144727099003|11063799006|56012099006|261022105027099003|261022075727099003|10067099003|261026140227099003|261021121427099003|261009223027099003|261021123027099003|261009223327099003|261009221227099003|261009221727099003|261009220027099003|261102123227099003|38070700021;
x-microsoft-antispam-message-info: xnQoEu+7dZwrx7mXMyp36PRELkYSSi7PvKqRLhE3mzFDYECxfiYHhkFstjL7H0GxYPL4dVv27+qTQVoJAdnRL9cw3sBj+L6nLKcBmIZIzoHtxTGr4UCeTslxiUl8/RJdGispzVCchdojO1jLgW312wjPvNlW/JMtQSB6KB8kwTtEsDbw29CjuWZ6nDfvLdvJZZz2ZrGB++jvqdFLM6kGs+Q83YnHHc4bICWDcHqpJe4JP3Z4ctLF7N2/OSalz7vpTYRrfy4sPNzoudn0Y8jR06N3EJRTzaIUyumpxxUhY0AftQn/exH34ugF1qUL1SLnbraN7/CuF6zaICjrY63XMd9qgRTfOCK5e7IUlERfjE619BB2aY3fKIno3lYWb8UJ5t8uuc2DpNvXW/CMZYGJFlxGprzOwDzZVgA0ZwCP27e9NDN60lhusfv/3rp3BLgsVaOAooxpCGECljBLM8dA8+q5e0UIxMLbzxku8qd5VCyR5kpUx1yTaUMyYrBo3bWn4PO1P83OVmlQpcL6inD9qGz9jwSGNGCFmBJoNJW9YM95KU/0BS8kcI/sNJiBvv+Eq942Q93vBm+zdC3yZL8DD+Cu9e0Mh2w/LmR6ZhXJqU/ztUeCdiMI77FAx5zNPCz80X/lGBN+rG12s1F0kh6K85qGfUOQkRE0PjNqZwTrkT4dEuvUFqaFMGz0XhmlDr/6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB634048.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(376014)(1800799024)(20046099003)(22082099003)(18002099003)(3023799007)(921020)(261028144727099003)(11063799006)(56012099006)(261022105027099003)(261022075727099003)(10067099003)(261026140227099003)(261021121427099003)(261009223027099003)(261021123027099003)(261009223327099003)(261009221227099003)(261009221727099003)(261009220027099003)(261102123227099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S05yUE4zUGtXOUo2RTNiSXpkUmY0bms2cHZ2VVRXK1pZV3Jaa1ZGQXV5VG1a?=
 =?utf-8?B?Yk1HLy9rWjZFR3MrU0tDcHZuTnBZbXQxdGZNSXYvWWc4TWF5MjBuQllvZG44?=
 =?utf-8?B?MjZnbnBCejFOQis0U2FCL1p3MGZtbi9UN0gySkFUUjVDdnc1UzQ3ZjdXNncw?=
 =?utf-8?B?U05aQ2dqMm5uY0VPUG9jT3M1L2o1Zm02UDVMUU1SbWRCQ0Jlb0IyK2JvTlh0?=
 =?utf-8?B?TkppaGNVN2R0bkordkdhcEE4UVhuUFJMT2I4bHpZNGZ6MU44U3NGYWpZZm9y?=
 =?utf-8?B?TllVS0lXSGtWblY1dkV1eHFlc2Y3cFd3M2VqZDZNZmNvMXZDOVVZVURCQVk3?=
 =?utf-8?B?YUp1KzhSdzA2bUp3YVplc0JxMGZsZlZZS1R5TUJUb21DSysvNGVkbVVDcllQ?=
 =?utf-8?B?eURSVW5DdHg0RGJTcFJCMzVyK00xT3k5Qk9LaXFYTFVXNlhvSW5PRUExM0Nk?=
 =?utf-8?B?a2NIMHZqL1d3OVkzZ1pJRVRWSVBOc2R6R0toOXcvbGtZcy9JSzRTV1g1Nm5k?=
 =?utf-8?B?SzIvWnR6UTBJeEREcC9XQ3NHRUxiZ2phN3d2TGt6UmtwczdVaGV4RXp2T2tq?=
 =?utf-8?B?SjJjbU9ZR3MvWWd5MUx4VDl1L242ZjBBSExZTWRaOXdQaFJkRTROVGpJY1lj?=
 =?utf-8?B?ZDNPOEgrZEVqdTZaNUR3N0xhcmZvNzJEM0phV08yOENwd3NmUWl1Q29HeUdH?=
 =?utf-8?B?WG1Ia2xhUnhUbzBVVVZCdENBYjdnYkFNL04vcGRJK2x4Yzh2U0JvNGlObkI2?=
 =?utf-8?B?Ri8wU1NMeWNzZEVCZThoNmxpa0pNQVNyaHUvclhXeEYxN0tSVjFvOVBQT3Z3?=
 =?utf-8?B?a3NEK0d1NlNCVlNHNjF4SVNMYm8wZVNsemhyQlhMQlNsUXFMblY2UGlxVnpY?=
 =?utf-8?B?YWNGQVBjM3crUHJ3cXFKRHlOTUlYcEtFN3dFdHdQajhHWUU1UTRzZVpycmYx?=
 =?utf-8?B?bHN2Y2txajVNSVR6dDVIQnRFZUVJNjJSQXMzNnp5THBkMXZvY3F1UHc5dVVI?=
 =?utf-8?B?eUl0MTZUbDJ3S3VHTmo1UE9razNTY0lKbW1DcEJ6MnFMZ08yemdsSHNGeWlK?=
 =?utf-8?B?OU55MjlRRjdvQXVXQkdiTVBIMm5YM3lENmpEeDJsM2VVT3c2UmtRL2Vyc0NL?=
 =?utf-8?B?STU5SkFBN0xCYXZVcjhyUVN3N1dmbkdEbnhlSlh3c290dWxmc2UyZ0swS002?=
 =?utf-8?B?Um95V2JrOS9vS1dyRERKSTB3SXEzQXIyQWk0SmIrN05rdXNIMnRER0tlUHRt?=
 =?utf-8?B?TG9kUXhlS25RbUFzWWQ5NmZFT1hObHRKN0EzelZLVG5OVDNheXlhdTkyd1hz?=
 =?utf-8?B?amtYdllrTjZzL3lQN3NaVmRZVGNDYUhoNHppMWs2OTFFZWdudm9LSnZnNFR4?=
 =?utf-8?B?N1JqTlZuWVpZdERmTGJlbnVLQ3BWU0tncTV3YjJTVHAvNkVaMW5GM3NjUUlI?=
 =?utf-8?B?OWFQSFpuMXBWSytpb1dORlpHaExpUUxRUDUybjVnNjlETFBmT1RHTEF2OXl6?=
 =?utf-8?B?WmtMajRycFh2STk4dFBiaTRMY0N1elNXc0JvNklBQXJWY2srRWRlSzMxK3FB?=
 =?utf-8?B?YUExTC8vaUdVeFBTbGY2TVJVYUx1ckNaZTNyeFlJZ0UyRTB2VmUxWHpkdnpn?=
 =?utf-8?B?SjB0d2pkcFg2Z203WEVOZmFFQnZmQmJXc1RKMGpya0hhRHI4WEI5akpuc3kr?=
 =?utf-8?B?VlZUbk1XSDRVRERvbkRkemYxTytRKzc4K1E1QkRaOUUxK1Y0Tm1QUnhGY3kw?=
 =?utf-8?B?UElFRzJDNTR2RlVNdzRPbU1rQWxFV05HakRPbnlCdHVSaEUzNUFaTXlmNC9k?=
 =?utf-8?B?anNtT1BMZGJVMU9LRSticzkvUENmZ0RFOFoveEo1bVBpR0Fuejd1NE5SUzVF?=
 =?utf-8?B?cU1ROFFGSXFNaWh0RUtwUm9MN1ozVVk0bklDN2hCUnJRci9VZ3BDd1djZzFy?=
 =?utf-8?B?Wkd6VURzb0ZrZFI1ckI1WFQ2NWdPTW5KQ3FqODFkSXNWbHFOTldLV2tUc2pE?=
 =?utf-8?B?bmxieGlyOG1kS3hIeE5vSmlCRk9mSXVqbHBEVjVOUzhvcEVUWHd2ZlRHMXc2?=
 =?utf-8?B?MW91YmdHRDRYMFkvYnd0RE02TDFDcUhYZWN4eVFDdVRPN1dRT3Rnc2hCTUNF?=
 =?utf-8?B?VFlEOXpPSUQ2Nk1EVjNzbFpKQ3ZoQmVIMlRTUERSK0RqWE9KMUROTXUyR0Jy?=
 =?utf-8?B?WFB3elhJMk5tcWlmd2RVcG01cXVGQnJ6Sk9lTEp6dWFnN01DMUljcG5YSkk2?=
 =?utf-8?B?VFRKK0pnSHArYTZwZ0ZjU1pzSEhkOTBoQlE3L0Q5VXNOTWFUU0JWaUxuMkZv?=
 =?utf-8?B?Q3R0eksxK0dkMkNhaHA2Uzc1N0ZNMUJnVVdWOGI0MG56OVJ4Sy96dHJRa1A2?=
 =?utf-8?Q?DqdVLdG78i9MtfJ0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <225FDEA6E20813428BB76E0B4B771B40@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: yRHB+8UGRRdBQ1v5dbAX93XtH3WiBito/b9/P4Hbn7k+aKGkFTzunUfE6gQgs1HsKKh2JY4CUNKJlN/4hRLpccaBTi5Fv0CfHB+tLLZI0xBdUHebKuU+chIM90DjL+reugD2Tmai0Q7Ao8gYRGn13LhL+LbsGHR8OMYhdoTu6zMZ7bLXvORpaiTyYp5mJhgt5vHLKFxqsBgZDDOS7LAMJiKwPnOalpL9cOAv9C6bQQiISgNFDlonK+uO4IW8AdhAFlP5C8UPZH6ii9DXVeUSAp8fZpY5r7erZR57p7aIolVUlhuSxZ4extpdNtYKY7qI0W1BigoEBRTnfkSH/tepqA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB634048.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee5431cb-d396-45d6-5d22-08df469914f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2026 23:59:00.5108
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dKIEew9AZxhaLWX8MaZXJL3/8qEPhVEN07IikAZcEG2f0G6tJx7aSGa6zOPvTggTG82kFlo50wTPccByc0nqwkEoR7hsQ7Wlr+aLzIo4zGE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR11MB9582
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI2LTExLTE2IGF0IDE2OjQwICswMTAwLCBQYWJsbyBGcmFpbGUgQWxvbnNvIHdy
b3RlOg0KPiBDb21taXQgNjdmYzgwOTIxN2RjICgidXByb2Jlcy94ODY6IEZpeCAxLWJ5dGUgb3Bj
b2RlIHRhYmxlcyIpIHNldA0KPiBiaXQgMHgwZiBpbiBib3RoIGdvb2RfaW5zbnNfMzIgYW5kIGdv
b2RfaW5zbnNfNjQsIGFzc3VtaW5nIHRoYXQNCj4gdGhlIG9wY29kZSBlc2NhcGUgYnl0ZSB3b3Vs
ZCBub3QgYmUgcmVwb3J0ZWQgYnkgT1BDT0RFMShpbnNuKS4NCj4gDQo+IEhvd2V2ZXIsIHVubGlr
ZSBvcmRpbmFyeSBpbnN0cnVjdGlvbiBwcmVmaXhlcywgMHgwZiBpcyBhbiBvcGNvZGUNCj4gZXNj
YXBlIGJ5dGUgcmV0YWluZWQgaW4gaW5zbi0+b3Bjb2RlLmJ5dGVzWzBdIGJ5IHRoZSB4ODYgaW5z
dHJ1Y3Rpb24NCj4gZGVjb2Rlci4gU3Vic2VxdWVudCBvcGNvZGUgYnl0ZXMgYXJlIHN0b3JlZCBp
biB0aGUgZm9sbG93aW5nIHBvc2l0aW9ucy4NCj4gDQo+IEZvciBleGFtcGxlLCBTWVNDQUxMICgw
RiAwNSkgaXMgZGVjb2RlZCBhczoNCj4gDQo+ICAgICBpbnNuLT5vcGNvZGUuYnl0ZXNbMF0gPSAw
eDBmOw0KPiAgICAgaW5zbi0+b3Bjb2RlLmJ5dGVzWzFdID0gMHgwNTsNCj4gDQo+IENvbnNlcXVl
bnRseSwgT1BDT0RFMShpbnNuKSByZXR1cm5zIDB4MGYsIGNhdXNpbmcgdGhlIGZpcnN0DQo+IHRl
c3RfYml0KCkgaW4gdXByb2JlX2luaXRfaW5zbigpIHRvIHN1Y2NlZWQgYW5kIHJldHVybiAwIGJl
Zm9yZQ0KPiBnb29kXzJieXRlX2luc25zIGlzIGNvbnN1bHRlZC4NCj4gDQo+IFRoaXMgYnlwYXNz
ZXMgdGhlIHNlY29uZGFyeSBvcGNvZGUgYWxsb3dsaXN0IGZvciBhbGwgbGVnYWN5DQo+IHR3by1i
eXRlIGluc3RydWN0aW9ucywgaW5jbHVkaW5nIFNZU0NBTEwgKDBGIDA1KSwgd2hpY2ggaXMNCj4g
ZXhwbGljaXRseSBkaXNhbGxvd2VkIGJ5IGdvb2RfMmJ5dGVfaW5zbnMuDQo+IA0KPiBUaHJlZS1i
eXRlIG9wY29kZXMgKDBGIDM4IGFuZCAwRiAzQSkgYXJlIGFsc28gYWZmZWN0ZWQgYnkgdGhlDQo+
IGVhcmx5IHJldHVybiwgc2luY2UgdGhlaXIgZGVjb2RlZCBvcGNvZGVzIGJlZ2luIHdpdGggMHgw
Zi4NCj4gDQo+IEZpeCB0aGUgdmFsaWRhdGlvbiBsb2dpYyBzbyB0aGF0IGxlZ2FjeSB0d28tYnl0
ZSBpbnN0cnVjdGlvbnMNCj4gYXJlIGNoZWNrZWQgYWdhaW5zdCBnb29kXzJieXRlX2luc25zLiBQ
cmVzZXJ2ZSB0aGUgZXhpc3RpbmcNCj4gYmVoYXZpb3IgZm9yIHRocmVlLWJ5dGUgb3Bjb2Rlcywg
d2hpY2ggYXJlIG5vdCBjdXJyZW50bHkgY2hlY2tlZA0KPiBhZ2FpbnN0IGEgZGVkaWNhdGVkIGFs
bG93bGlzdCAoaW4gbXkgb3BpbmlvbiwgdGhpcyBzaG91bGQgYmUNCj4gYXVkaXRlZCBvbiBhbm90
aGVyIHBhdGNoLCBpbnN0ZWFkIG9mIHJldHVybmluZyAtRU5PVFNVUFApLg0KPiANCj4gRml4ZXM6
IDY3ZmM4MDkyMTdkYyAoInVwcm9iZXMveDg2OiBGaXggMS1ieXRlIG9wY29kZSB0YWJsZXMiKQ0K
PiANCj4gU2lnbmVkLW9mZi1ieTogUGFibG8gRnJhaWxlIEFsb25zbyA8cGFibG9AcGFibG9mcmFp
bGUubmV0Pg0KPiAtLS0NCj4gSSBjcmVhdGVkIHR3byByZXByb2R1Y2VycyAoYW5kIGEgYnJpZWYg
ZXhwbGFuYXRpb24gb2YgdGhlbSkuIE9uZSBpdCdzIGEgc2ltcGxlIG9uZSB0aGF0IGRlbW9uc3Ry
YXRlcyB3aGF0IEkgdG9sZCAodGhhdCB5b3UgY2FuIGF0dGFjaCB0byBhIG5vbi1hbGxvd2VkIGlu
c3RydWN0aW9uKSwgYW4gYW5vdGhlciBvbmUgdGhhdCBmcmVlemVzIGEgc3lzdGVtIGJ5IGF0dGFj
aGluZyBhICJwb2lzb25lZCIgdXByb2JlIHRvIGdsaWJjLg0KPiANCj4gLSBEdW1teTogaHR0cHM6
Ly9naXN0LmdpdGh1Yi5jb20vUGFibGl0bzIwMjAvMDc3ZmM4ZDhiNmQ3YTc1YzIzYzcwMmM3MDIx
ZDY4ZTYNCg0KSXQgbG9va3MgbGlrZSB0aGlzIGlzIGEgYnVnIHRoYXQgY2FuIGNhdXNlcyBjcmFz
aGVzIGluIHRoZSB1c2Vyc3BhY2UgcHJvZ3JhbXMNCmJlaW5nIHByb2JlZC4NCg0KPiAtIFBvaXNv
bmVkIEdsaWJjOiBodHRwczovL2dpc3QuZ2l0aHViLmNvbS9QYWJsaXRvMjAyMC9iZGRhNTg2YWIw
MjNlYzQ3NjA3MTZiM2JlN2NmZjEwMg0KDQouLi5hbmQgaWYgdGhlIHByb2dyYW0gYmVpbmcgcHJv
YmVkIGhhcHBlbnMgdG8gYmUgaW1wb3J0YW50IHRvIHRoZSBzeXN0ZW0sIGENCmNyYXNoIHRoZXJl
IGNhbiBjYXVzZSBzeXN0ZW0gaXNzdWVzLiBJbml0aWFsbHkgSSB0aG91Z2h0IHRoaXMgd2FzIGEg
a2VybmVsDQpjcmFzaC4gSSB0aGluayBhIHNpbWlsYXIgc3lzdGVtIHN0YWJpbGl0eSBhcmd1bWVu
dCBjb3VsZCBiZSBtYWRlIGZvciBhbnkga2VybmVsDQpidWcuDQoNCj4gDQo+IEFmdGVyIHRoZSBm
aXgsIHJlZ2lzdHJhdGlvbiBvZiB0aGUgdXByb2JlIHNob3VsZCBmYWlsIGJlY2F1c2UNCj4gdGhl
IGluc3RydWN0aW9uIGlzIHJlamVjdGVkIGJ5IHRoZSBzZWNvbmRhcnkgb3Bjb2RlIGJpdG1hcC4N
Cj4gLS0tDQo+ICBhcmNoL3g4Ni9rZXJuZWwvdXByb2Jlcy5jIHwgMjAgKysrKysrKysrKysrKysr
LS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxNSBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygt
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC91cHJvYmVzLmMgYi9hcmNoL3g4
Ni9rZXJuZWwvdXByb2Jlcy5jDQo+IGluZGV4IDBmNjBjMGQwNzZiNi4uMWNmOTAxZDE4Njg4IDEw
MDY0NA0KPiAtLS0gYS9hcmNoL3g4Ni9rZXJuZWwvdXByb2Jlcy5jDQo+ICsrKyBiL2FyY2gveDg2
L2tlcm5lbC91cHJvYmVzLmMNCj4gQEAgLTI5MiwxNCArMjkyLDI0IEBAIHN0YXRpYyBpbnQgdXBy
b2JlX2luaXRfaW5zbihzdHJ1Y3QgYXJjaF91cHJvYmUgKmF1cHJvYmUsIHN0cnVjdCBpbnNuICpp
bnNuKQ0KPiAgCWVsc2UNCj4gIAkJZ29vZF9pbnNucyA9IGdvb2RfaW5zbnNfMzI7DQo+ICANCj4g
LQlpZiAodGVzdF9iaXQoT1BDT0RFMShpbnNuKSwgKHVuc2lnbmVkIGxvbmcgKilnb29kX2luc25z
KSkNCj4gLQkJcmV0dXJuIDA7DQo+IC0NCj4gLQlpZiAoaW5zbi0+b3Bjb2RlLm5ieXRlcyA9PSAy
KSB7DQo+ICsJc3dpdGNoIChpbnNuLT5vcGNvZGUubmJ5dGVzKSB7DQo+ICsJY2FzZSAxOg0KPiAr
CQlpZiAodGVzdF9iaXQoT1BDT0RFMShpbnNuKSwgKHVuc2lnbmVkIGxvbmcgKilnb29kX2luc25z
KSkNCj4gKwkJCXJldHVybiAwOw0KPiArCQlicmVhazsNCj4gKwljYXNlIDI6DQo+ICAJCWlmICh0
ZXN0X2JpdChPUENPREUyKGluc24pLCAodW5zaWduZWQgbG9uZyAqKWdvb2RfMmJ5dGVfaW5zbnMp
KQ0KPiAgCQkJcmV0dXJuIDA7DQo+ICsJCWJyZWFrOw0KPiArCWNhc2UgMzoNCj4gKwkJLyoNCj4g
KwkJICogQXMgb2YgdG9kYXksIGFsbG93IHRocmVlLWJ5dGUgb3Bjb2RlcywgYWx0aG91Z2gNCj4g
KwkJICogb25lIGRheSAgd2Ugc2hvdWxkIGludmVzdGlnYXRlIHdoaWNoIGluc3RydWN0aW9ucyBt
YXkNCj4gKwkJICogbm90IGJlICBjb21wYXRpYmxlIHdpdGggWE9MIGFuZCByZWplY3Qgc3BlY2lm
aWMNCj4gKwkJICogcHJvYmxlbWF0aWMgZW5jb2RpbmdzLg0KPiArCQkgKi8NCj4gKwkJcmV0dXJu
IDA7DQo+ICAJfQ0KDQpDYW4geW91IGNoZWNrIHdoZXRoZXIgdGhpcyBjaGFuZ2UgbmV3bHkgcmVq
ZWN0cyBwcmV2aW91c2x5IHdvcmtpbmcgaW5zdHJ1Y3Rpb25zPw0KVGhlIGwvbS9zZmVuY2UgaW5z
dHJ1Y3Rpb25zPw0KDQo+IC0NCj4gIAlyZXR1cm4gLUVOT1RTVVBQOw0KPiAgfQ0KPiAgDQo+IA0K
PiAtLS0NCj4gYmFzZS1jb21taXQ6IGFlYmI3Mjc0NDc2NDAzMDQwZDU4MmM2MTQ3OGRmOGY0YTdi
ZjljZDMNCj4gY2hhbmdlLWlkOiAyMDI2MTExNi14ODYtdXByb2Jlcy10d28tYnl0ZS1vcGNvZGUt
N2ZhNzQzODMwOTMxDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IC0tICANCj4gUGFibG8gRnJhaWxl
IEFsb25zbyA8cGFibG9AcGFibG9mcmFpbGUubmV0Pg0KPiANCg0K
