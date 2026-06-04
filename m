Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6604036AB61;
	Thu,  4 Jun 2026 15:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780587793; cv=fail; b=iPUZ/DVgxA27AOCTyJL1lPYihePdU+PpaQQcheQEOhaUiAgq5ZpBCK3MN7QFgkOx+/3XTZPs4IvGkhGFp1Yf7XwGSJnI12eJpwKNdQAPJS1AbFkxv59Bs9YeLxCFJhAaD6UyQBdnJHgxY7vphc8I95cMNOqm4iEkTGQRL7c7A38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780587793; c=relaxed/simple;
	bh=ZPaV4P2bIJBUi4MSiNLdGvI3z8ODLjImWgtxAumSxR0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rahotv6yszjCXh+S3HxR0UWlIlcgVZtuW2LWjTRi4Pp4dg88P1LF8YkA03l3o7XkU7sFoC8dVT2u7ZHmXf/f6Mk8/CtegxktPhrvazyySCCfb2ZVySPwPsEg/vJ1YZd90kZh5Djw6LbXZxrc+6CNX8w33jAiLybi6oPhc6gezxo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ydit3+Fb; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ydit3+Fb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780587792; x=1812123792;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZPaV4P2bIJBUi4MSiNLdGvI3z8ODLjImWgtxAumSxR0=;
  b=Ydit3+Fb55MmspJ8unyOwzUJ7o1MiGBc17Z/izjGbQssHEM6lmwsubbh
   F9CV7BaVekYOAjOC4qia1Y5/48qVuvBrIeHrjCGpmt2JnMS/jK37SmcNO
   gA03u2YmI9BxXDEC8zVaPT8C3YjfOGD0xPsC6E7h+LNA9GaQaOWyCR9Ep
   IyfU48E1dFHaPGnK8CwiKnXa+AZcGEYfS4uPO45tlL4dQp6tpP8JBAzkh
   kmORZg4kvxVhRWC2MgeZbqYkEFg4hOaT0sU1sz39VmEZfE03VPgxj3LVS
   d17o+flKWh5R9aAm1XkVCp0mRTqH+RkTfjJNM2D47jE+VatTbg5MWtGa/
   g==;
X-CSE-ConnectionGUID: NF8NbVStTuSBkC4IOwyZPQ==
X-CSE-MsgGUID: V1ZHs1JkRqePfMckPuCvTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="81324165"
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; 
   d="scan'208";a="81324165"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 08:43:11 -0700
X-CSE-ConnectionGUID: pkEpbVVwR3ilY4GAnE+sGg==
X-CSE-MsgGUID: iwRY+lr+TmmFILBQc/mD+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; 
   d="scan'208";a="268498397"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 08:43:10 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 4 Jun 2026 08:43:09 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 4 Jun 2026 08:43:09 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.51) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 4 Jun 2026 08:43:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jRr+7fBk4ceEdWg/Z68mPJlKvfkqzdyUYeobkJR4E/qu1p3O+MyyuqFk0uuY0fMPZna77xguGd4D9qBVVIdhkBOdHMr00thREgzcCutP3gmiSPvT/FRqqRIUsOgOm6YE0RQTUyhsM5n8czK5qu8uzsu4Y4sc8JeL3l4dOa3q8ucnUBc4mtjjWIiJeIAZgMkreCQagEm3hNGMBMvdylqEB7sKLYhxCtirfL8TyKmwzUKRjLsv8MhheZKO1MuitmTbXEV4IBldq4D1yXY8fOhEfp/LWAg33IdU8dWaxt16a0s8ZH38CVC0Dx1nYOyxGtnY24y0QPB7i9FbMHkACosbSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZPaV4P2bIJBUi4MSiNLdGvI3z8ODLjImWgtxAumSxR0=;
 b=dawveXgoaSHhb4NGhgq6w7Q9VSqd4B+Vic0TxdhPpENj/GBNW58D45mzxxhPwAJqG+VOM6B9vI05Da6oMjkdgwQjhCBkJuWJio7peXXwDK9eSyYAyp1i1vdVcUwdDY1BlBf0uEwnX13Z4tTYyp/gfn0pVCFhxu5dGl2M0pvUNBGa7Px6ppDG2ge+Xo10xqMhvnTDQiXftxnptOkrXVd+DZ9CiOYUyX7nd8YjrIQyDLdoXO8mDXSShnuZ6mpspPP1kLXsWSwl7juVnyoSaR6VrwyjoMD370GWg5Uf7UQ/HLuXsN/4Ii0/KUtPoj8w/faJZAPoW5aKpC7/4ObfxmBh8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by MW6PR11MB8309.namprd11.prod.outlook.com (2603:10b6:303:24c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 15:43:05 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::5670:5b2e:6ecb:dcaf]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::5670:5b2e:6ecb:dcaf%5]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 15:43:03 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>, Steven Rostedt
	<rostedt@goodmis.org>
CC: Borislav Petkov <bp@alien8.de>, "mchehab+huawei@kernel.org"
	<mchehab+huawei@kernel.org>, "Luck, Tony" <tony.luck@intel.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linmiaohe@huawei.com" <linmiaohe@huawei.com>, "xieyuanbin1@huawei.com"
	<xieyuanbin1@huawei.com>, "Lai, Yi1" <yi1.lai@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: RE: mm/memory-failure tracepoint change breaks userspace rasdaemon
Thread-Topic: mm/memory-failure tracepoint change breaks userspace rasdaemon
Thread-Index: AdzzWUeryVIHgoWJQJyC7gAz88QdgAABeDAAAAVQ7YAAABfXgAAAOygAAAEtTgAABKiwAAAqhkEQ
Date: Thu, 4 Jun 2026 15:43:03 +0000
Message-ID: <CY8PR11MB71340AAB7FB4C2332413615189102@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <CY8PR11MB7134346A3E4BB28ECA28D6E989132@CY8PR11MB7134.namprd11.prod.outlook.com>
 <b930678d-a1ae-458c-8705-7ca9680d4cb6@kernel.org>
 <20260603121707.7eccb9fb@gandalf.local.home>
 <20260603161947.GBaiBUI7C8WWPwD84S@fat_crate.local>
 <0c16bf3d-7c6d-4e28-b200-03b7d0ef714a@kernel.org>
 <20260603130006.7d2c4a62@gandalf.local.home>
 <b637ede2-73da-49f0-a7eb-70ec79e79624@kernel.org>
In-Reply-To: <b637ede2-73da-49f0-a7eb-70ec79e79624@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|MW6PR11MB8309:EE_
x-ms-office365-filtering-correlation-id: 4626df7b-fc3d-4164-1518-08dec24ff6bf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|4143699003|56012099006|22082099003|18002099003|11063799006|38070700021;
x-microsoft-antispam-message-info: GQyjBEh0rcQu1NRXHI4fGUIYRQiYl45NoSIteRi7mmZIywzwevHyvgplseR5yXIVF65ymDCyKjKwIQ33TCTJ9eLGNdvip8oFcKlGf78QbCRJfVeLQG1nQHrrDFocdSbwb5xn3X8NvNDIq6RPRZSEotWO5pu6dcNMGk8w1zormrR7Et41mxOEJxu5XqPo6vxACadzb572XkwvjHONNi/v6SQU9Oe5Ng+JumwoM+WP1eOlXlFuB36PO21TrOriDV51gwvEW3lAyCP+R7nQ2XXMmj0OFBdX8BveSMlBGZ10eeHnbzzMlYAsvtj1PK8W5jayQHGO3ifn83dvVk1Y1QUK3et5jbV+43M4YK7BhbV/J2oDnsDC371j/B+X8qPeODZznKgfedcA+oVdxrYT95y5QB20wujSzY3GMYk1I98AxJHZE42CY1uDD9tcJRP6+iBs+nX1t+AOwwwPIn/kX4B0HRe6wRbZWM8OEzngmUSXc4Ss2jz1tVllRl3MF0nnQh/yVCr2cviRLZSW6Fq9BWRhL7seSh4rkGno4VL6P1V4YMzla58XVFIGGPcHmXA0eFk74uSZVZUqSYX3OdOGX/hm/Ws0Keyf6FIRi1xRvPgNw//KJj0wHs3VSjwez03TytgmS6CAg4YbDRHae2mZycy6l8jbs0rpE405uQmwF9VBLBrFLaMzoVzd8GAdKwY+xiaUwvZoCtsYCjmbIW1ifTsGkt8POo1JF9ImqTMYUMQxCdpTLnNL4V1AVUrhf8n15CMz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(4143699003)(56012099006)(22082099003)(18002099003)(11063799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZFVWbm9DbmF6VkNnTkRyZitDbExQcFNhMTd5amljamY3d0lLM3ozaEF0YUl5?=
 =?utf-8?B?VUtpd3ViU2xteUM3ZjBtU2I4L0NkTlRSN1NDdDE3bVRuYnpvem54dGhyaFZx?=
 =?utf-8?B?dTViZHY5Q09manlTNGJLd3NSanhjV3hGOWFpbmt2b0dSc2xocUsxeEJjZmpV?=
 =?utf-8?B?WG1LNnRGV0F0N1U2NUdQUXBtYkc1VlRqOGw3Y0xGR1Y1cnl2OTc2VU9icy9V?=
 =?utf-8?B?N2xDcnphMzJ0cEZjUmlIL3hjbXBMRUVQVVlxY1lWRmNVckg3UXd2SHUxRytN?=
 =?utf-8?B?RU5SUVJ3MWZJRmVCdUVubGZZR055ZkJXQnNZRnJDQllpMWdaaGo1S2pwckFU?=
 =?utf-8?B?eVNVRlhQM2dpSWc2clllTTR1dC8rckdxQzJZYzhDb3ZMUlpGMGVsLzVQV1pj?=
 =?utf-8?B?WjVhTGRlNkJUak14Y2RaRm5PY2VSMEVNSmVjdWVCNWhkRW1HRmJnRDJWMDgx?=
 =?utf-8?B?c3BWcm13U2paRTRmaXJFYmlBcHVKcFR0dUJLeGcwUXNQWWcrdWFuQ3QyYzhY?=
 =?utf-8?B?MHA2b2FWVDZ2ekFCeFhsalVsRmJBN04xcjc2LzJ0L2VXRFFvVXlOSDdVamFB?=
 =?utf-8?B?Uk9ZTzdMU0txYVkxZXJpOXJUOURwT2VPendSZktzSlBmUXpOZTNVODF2cTE0?=
 =?utf-8?B?bEtDS3pIUzJoUHdXWjlJYjl3MldJWUYzUFNLWUErWUJzdm82NjRVOUEwaE0v?=
 =?utf-8?B?UDNNTDJFczJKZ1d1a1F4RVZSbWhYV3BZZ0ZxZ3JzMVZma0pZUE9vRmt6OXps?=
 =?utf-8?B?cGl1M2pYSTNxTUtkK1ljMWVDUmExZzZuTXU0RW9GcmIwbDdHOGo5Z2wwTHgz?=
 =?utf-8?B?bmhzcGpzMnFNNFZZVzRNRGhhQWlITjVJZU9qOTZOdzdaZnE5MnBTODZrOFdV?=
 =?utf-8?B?SHF3Wm1MNkl1M0lXTGJkL25PTnFucFozNmtjeTJ0YjdHWlBDdjBDSVFzcElj?=
 =?utf-8?B?WU15Ym12b082cmRDRHFwc1FVS00wZCtLVE1EL0F6Nng2REVEb2hESHZ6YmZ6?=
 =?utf-8?B?UHhweGd3aWVNcFhuR0NYK21qVW9pdmh0OHI3eWxBb2kwbVhqY1pJSVpwQzdX?=
 =?utf-8?B?aHNjZmpSNkdvNTVaNCtTajNqQ3V3aFBXRlJLZk9KZVkrSlpBQlVlb0VOamJ1?=
 =?utf-8?B?VXh4VzM1cGk4cmozTUVlVkljcEp0SUg2cXFTcnM1ejhVZDViREJIVDJiQkdx?=
 =?utf-8?B?TzI3alFwR0JhKzI5SmhkUTkzOXhvbWZZd0pSMTg1NkFqYnZ1M0RsZ002ZFlm?=
 =?utf-8?B?Y0Y4c3dNU0NJM2V4ckJ2VHowOERpWEUwbHdOdGpFZi8zK0ZaVkJZR1ZYZ2JN?=
 =?utf-8?B?cnVDd1NDeU9TY0oxT1V6VEZ1Tk9QQWNNdytBbHZmTHQxejRlSFBWd0dMYkta?=
 =?utf-8?B?VitvaUh0bnlGdVJGWmluSTlPUURwSUJxM0VQaHo5NkE5emJsQVNVQjZYcW42?=
 =?utf-8?B?TXFFeUFaNXBSL2ZidExYK1pIVnNsUTEyVE05RzBsYVd6c3h2YjBxNGFDd21K?=
 =?utf-8?B?cEVONkVyR1hkREl4OUEvWm1mQjdMbG5XSTBFeDN2bGwrRnE0TzRPSDV2ZnY3?=
 =?utf-8?B?MWpaejgvbytSd1ZNdkcxalVYZHpmcjhqV3lpRVlicktFNGdyZ0k4R1Y2YS9F?=
 =?utf-8?B?Qnp3Tmk2RjhtVUZ2U0pHRzdLejR0dEZRTWxxTWZEaHRncEloWFhpbElwZEQv?=
 =?utf-8?B?MlBhQTF6S0wwSDN6WFpNa01YVW5hcVl5OU5jNnA0R1NBRXFyWWU1OS9KTHdu?=
 =?utf-8?B?azBtYlo1Um9aUm1tTWFWWEZodGplVFBqQ2FiS3NJVnBEOEtEUVpEUGdTSS8r?=
 =?utf-8?B?WUpoWSsvRjVKcnN0QVRFSUhYWDN5VlU3MHEzbWpyek5XOHRzOTg4NGZ0cnh1?=
 =?utf-8?B?WnpXOGliZ2xlTEFnU1J2b2NTVkUxWHJhQnZCTmZhTW9xaG92eFJaMTdhSUwy?=
 =?utf-8?B?eEV2NkFKWUJmZWpVcHpnNHI5cWxYdVZzMzFtVWdEUEk5am5FcHJ3WkdwL0tQ?=
 =?utf-8?B?cTFDUUpkc2pKYWJiT3RoVFNnL3doZXpZaVBKZ0pVMkJ5TUZ4eEl1YnlrZS85?=
 =?utf-8?B?U0krSW9pb0RIaTFhTXBibllES1ZWTHdtSG1mZ1hMdWNKK2UwM0s2eFpvWWRV?=
 =?utf-8?B?SlU1aWZlT0RnMFU4M0VoUm5WS1RKek92a3hDZWtaelJzZXVVNmszVHd0Z29Y?=
 =?utf-8?B?ei9MaHd5Mlo3b2l1OEE4SnQ5cTNhTkVoN05kaCtEK3ZqS1hRQzh4R24zc0Fv?=
 =?utf-8?B?ZnR4OXNMcXhCd2t3blNPbW4waXZpM2RvbWgrSVZ0cE5xRDlHbldFS3RzeGtq?=
 =?utf-8?B?NWkzWG45c1JiVXNwa2VjOUMvKytmTDJ5VDg4VG53NU05M2QyRzRRZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ap7rbWCwtiZLnvLbbDuWsOVuSmFVgBkLsxgP+XI3RqgJVT5tLN5DEO/7EKdQBtmeeZKgJHV7P+wH8seE6QbTQFFBJ4IAuq4CAUMjt8i45Qd3KYySnho4bli0mytxL9HGhEEMreoLcTRitOeJwjiCbgmxM0OqQLf+hOFub+ti7VkY4bLLxrplWI5syfij/MWuU+yAQGjVgrHUPLg1WEyTsa60dWIF54LglMdUKUDSUP20zxMW05zprHNAmq2R0BU4/oM8cm3lobG83+eRO8GwFO0qmuVnbqfI9AuErM96T3uO+kKg5H9iiLp+W34mcjj3e+Z22pGBJtzphKZXq8y3Ag==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7134.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4626df7b-fc3d-4164-1518-08dec24ff6bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2026 15:43:03.0533
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4+ip8RjwPqF1BlIb2eoEF5MjjMlR48Vuda0qjt0DFTsqOR/iGEi5rBv3DBLie7OXzFaxIARZStfmD2Wrpc+zOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8309
X-OriginatorOrg: intel.com

PiBGcm9tOiBEYXZpZCBIaWxkZW5icmFuZCAoQXJtKSA8ZGF2aWRAa2VybmVsLm9yZz4NCj4gWy4u
Ll0NCj4gV291bGQgdGhlIGZvbGxvd2luZyBiZSBzdWZmaWNpZW50IHRvIGF2b2lkIGEgZnVsbCBy
ZXZlcnQgYW5kIHRoZSBkZXBlbmRlbmN5DQo+IG9uIENPTkZJR19SQVM/DQo+IA0KPiBkaWZmIC0t
Z2l0IGEvaW5jbHVkZS90cmFjZS9ldmVudHMvbWVtb3J5LWZhaWx1cmUuaA0KPiBiL2luY2x1ZGUv
dHJhY2UvZXZlbnRzL21lbW9yeS1mYWlsdXJlLmgNCj4gaW5kZXggYWE1N2NjOGY4OTZiLi5jNDZi
MTc2MDI1NzggMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUvdHJhY2UvZXZlbnRzL21lbW9yeS1mYWls
dXJlLmgNCj4gKysrIGIvaW5jbHVkZS90cmFjZS9ldmVudHMvbWVtb3J5LWZhaWx1cmUuaA0KPiBA
QCAtMSw2ICsxLDcgQEANCj4gIC8qIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wICov
DQo+ICAjdW5kZWYgVFJBQ0VfU1lTVEVNDQo+IC0jZGVmaW5lIFRSQUNFX1NZU1RFTSBtZW1vcnlf
ZmFpbHVyZQ0KPiArLyogU29tZSB1c2VyIHNwYWNlIHJlbGllcyBvbiByYXMvbWVtb3J5X2ZhaWx1
cmVfZXZlbnQgKi8gI2RlZmluZQ0KPiArVFJBQ0VfU1lTVEVNIHJhcw0KPiAgI2RlZmluZSBUUkFD
RV9JTkNMVURFX0ZJTEUgbWVtb3J5LWZhaWx1cmUNCj4gDQoNClRoYW5rcyBhbGwgZm9yIHRoZSBk
aXNjdXNzaW9uIG9uIHRoaXMgaXNzdWUuDQoNCldlIGFwcGxpZWQgRGF2aWQncyBhYm92ZSBmaXgg
dG8gdjcuMS1yYzMsIHRlc3RlZCBpdCwgYW5kIGNvbmZpcm1lZCB0aGF0IHJhc2RhZW1vbiANCmNh
biBhZ2FpbiBlbmFibGUgYW5kIHJlY2VpdmUgdGhlIG1lbW9yeV9mYWlsdXJlIGV2ZW50Lg0KDQog
ICBSYXNkYWVtb24gbG9nczoNCiAgICAgLi4uDQogICAgIHJhc2RhZW1vbjogcmFzOm1lbW9yeV9m
YWlsdXJlX2V2ZW50IGV2ZW50IGVuYWJsZWQNCiAgICAgcmFzZGFlbW9uOiBFbmFibGVkIGV2ZW50
IHJhczptZW1vcnlfZmFpbHVyZV9ldmVudA0KICAgIC4uLg0KICAgIDwuLi4+LTI1MTMgIFswMDBd
IC4uLi4uICAgICAwLjAwMDAyMSBtZW1vcnlfZmFpbHVyZV9ldmVudCBbQUxFUlRdIDIwMjYtMDYt
MDQgMjM6MzA6NDMgKzA4MDAgcGZuPTB4MTQ0ZTZmIHBhZ2VfdHlwZT1kaXJ0eSBMUlUgcGFnZSBh
Y3Rpb25fcmVzdWx0PVJlY292ZXJlZA0KICAgIC4uLg0KDQotUWl1eHUNCg==
