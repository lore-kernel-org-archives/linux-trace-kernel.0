Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7CEC2F2;
	Fri, 12 Jul 2024 03:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720754323; cv=fail; b=TKvORSaxLstd7+wClxVaVRVcmrdwTnqdzjlZDqfRnM1/Lo/FkWaLLPnoplsZDT5ihggBPVbEwM5tWIGbEdL7d7kfvBGRS3ldk4cdZZ6LYoSUmycGkHEvM6ALsU3NwhKGYQtskGVMFG7NNmokNrePI1bWxEf3XixPiD7fXNDPkJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720754323; c=relaxed/simple;
	bh=BSMsL5hoUrk/C5a73PzkyJfvjuIWdvPiF/qd3WYLG4w=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bQfL2xJUe5mUrFOhwWWA+X0O5sY3aaSNZvo9cxgMTbcbPQS9wNFQt3EGkeN7NOiQHOOI+3A8dtUuEf9awhbNzTKjwPHkVW+HCuPwnrwvM+P9XlZoyEiR3B2z//AGmFqILvIFJdk2BsnF9mNrvYVrVJEU5k2LC1UR4pBIGFwU6W0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LHza4XU7; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LHza4XU7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720754321; x=1752290321;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BSMsL5hoUrk/C5a73PzkyJfvjuIWdvPiF/qd3WYLG4w=;
  b=LHza4XU7bIbwXRMSy3zb3B3qgRz73pQb7ALOqabGwzzMSvS/nv4QS3Sm
   blFaZHASwcnjr39NMQABo2oY1ZOTMeNerH0yi0658ArfRPZD3N4d9lzA5
   iqOiCI7QIZCJ4G/D3Eur9BjLZ1PxBJNqc/13K8UpboH99KKuX98vW/YTy
   kEM9qdDSIeISbWy56PIvB7O0gX3zk9Pytv5NgFXvxEOISEck8OjK3b9s7
   6i0RzF9fBnYH+bODPuQuLk7kjjUKe27aeZjJvc7RCovpncglqaOpzYcjZ
   3CHMUpbK+QMieQU3zlYxNxiX29/wpA4V1xoLoiXkRMCBoAw8axa/4zUv8
   A==;
X-CSE-ConnectionGUID: MfrdIG3BTsWkbK+xnVbZ0w==
X-CSE-MsgGUID: m99pE5ifTUaQcy9aM0UXlg==
X-IronPort-AV: E=McAfee;i="6700,10204,11130"; a="18320966"
X-IronPort-AV: E=Sophos;i="6.09,202,1716274800"; 
   d="scan'208";a="18320966"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 20:18:40 -0700
X-CSE-ConnectionGUID: kvR/2eAZQsygIrp1RNFbWA==
X-CSE-MsgGUID: Y6KeuV0oScqv3UbtA9/q4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,202,1716274800"; 
   d="scan'208";a="53362879"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Jul 2024 20:18:40 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 11 Jul 2024 20:18:39 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 11 Jul 2024 20:18:39 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 11 Jul 2024 20:18:39 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 11 Jul 2024 20:18:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fEnQembF/T6ezWFwKnaQwODg9FN4z96M1jGmn19bxyG1KiJxiJONdMAehTAH4RyTERZULFyn325EdFZHIAK8feeMmPc2YwWG92vyXsMaPMPDS4U+bc+MJ7WM+4X4zNw2dd29/EtCbuy0bzMbjNYikoh9GQcNMwfpxYBZH06k9M/2G9dzfK039gXhQfH+hd6/EH+ZOr+C5eFCpxbCOgRRrd5mF4M3lWpnn8Tji3iQHLWYZMarVPJlQ6YMf4+89otfPkW+qvFiAv/AUuPEV2lRA5HSWBAwDeZ2OukLK4zyHBVnm3GGYexge/ER7oh0y/LvNUy2ZkUEtraOpIGRiUHEZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9zNLlDmyp7lVSUCZMd7fYLwcvvcNMu2IrvVRA9lrPwA=;
 b=niVqML0w3PTAuYFDu8ZsDG72Je2c7Xx2zekNxNCsIyoltYB8MNDAvWGPnUgLwP9X2p3qEMZfRf0DwZTAs9Bms7RJLFVCum41OjK1/7QWu6MzUB9BFRUP7D3srWZPwPWwFaAlNZNgjyjEwddfye90X1Xvqad77G90n3YOs+E1x1g0pXn6GQFAXQRu7dvywNASLbxjj4E0yNWlV2WjhzfL/6i3ifvfdee0WUOXZYz/kHliDrlxSQgd9m75m9y5gEZdm0OBeaPIuDYqNjm//0XX3xLkOR2hYvlW2IKixVe8g0pLOq37koyu2juLXUiYjicSNrBDdmoBnuwKWLdGQFnsUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3771.namprd11.prod.outlook.com (2603:10b6:5:13f::15)
 by CH3PR11MB7249.namprd11.prod.outlook.com (2603:10b6:610:146::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.21; Fri, 12 Jul
 2024 03:18:36 +0000
Received: from DM6PR11MB3771.namprd11.prod.outlook.com
 ([fe80::9a27:5f5b:44bd:43a5]) by DM6PR11MB3771.namprd11.prod.outlook.com
 ([fe80::9a27:5f5b:44bd:43a5%3]) with mapi id 15.20.7762.020; Fri, 12 Jul 2024
 03:18:36 +0000
Message-ID: <91a9c166-9f6f-45e4-9510-dcdf7f39a41d@intel.com>
Date: Fri, 12 Jul 2024 08:48:24 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] platform/x86/intel/ifs: Add SBAF test support
To: Ashok Raj <ashok.raj@intel.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
	<ilpo.jarvinen@linux.intel.com>
CC: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, Steven Rostedt
	<rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Tony Luck
	<tony.luck@intel.com>, <linux-trace-kernel@vger.kernel.org>,
	<platform-driver-x86@vger.kernel.org>, Shankar Ravi V
	<ravi.v.shankar@intel.com>
References: <20240711000233.684642-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20240711000233.684642-4-sathyanarayanan.kuppuswamy@linux.intel.com>
 <6f445c03-21b9-87bc-1bc1-ca211c56eaa0@linux.intel.com>
 <ZpBM62dM_pKniydW@a4bf019067fa.jf.intel.com>
Content-Language: en-US
From: "Joseph, Jithu" <jithu.joseph@intel.com>
In-Reply-To: <ZpBM62dM_pKniydW@a4bf019067fa.jf.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0P287CA0012.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::11) To BYAPR11MB3768.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::20)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3771:EE_|CH3PR11MB7249:EE_
X-MS-Office365-Filtering-Correlation-Id: 59b0935a-36cd-405d-5225-08dca2214fd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cjRaKy90MmNKcG9JM1JwUC9yNXVVQTFVczk5Q0lIMlU1OVgxWEt1ajg5OWJF?=
 =?utf-8?B?MVJIRm1PUlNvajdVdWprMmNuWGtCR2J2K3BHR0JFc3RZMGVKWkJhWDFxa01I?=
 =?utf-8?B?MlEwb1ZYT2pQNk5ETWxHN3RpRWFEeEJiMlRnU2o5aDJPdzF1Zk5lcWVtb1pk?=
 =?utf-8?B?dEJBYVZ2TlI3NEJVMVh0aC8yZ2UyVDZxR1dNVXhTaU9XVFgvdWl6S0FEakhm?=
 =?utf-8?B?R2tzNXlVTEQ2Q2NCOFVmVi9iL0ltVC9hRldDUDU0eDNPUDZvV3dCWVVCbHFD?=
 =?utf-8?B?LzVJbkloeDNvRWZMM0lpWjZ6bjlmNTUzMlh4Q0RJNCtHUFRMNlRiaGVIZVcw?=
 =?utf-8?B?dTVMb21pQlpFTXFZS3hpRUxvdVRvQVNEV0N2dDF6UGsxN1BOdmgrMVJwWUtz?=
 =?utf-8?B?L2RteDgzK2ZZS2xYWWFRRDFhZTlKY1lMRDZGQVpyRyt2M01FbWlwTTBRaHpu?=
 =?utf-8?B?aENmaFZOQlFQY3VWNGhhSmhlMTBxYStRVkZkMElIMlhEWmwzbFNPSWZHajFK?=
 =?utf-8?B?RWtJZnRGckhlYm82dzdIemFRMnV6ZjRucjZzdWdEbDlXem9pOVFWZy9hZHdv?=
 =?utf-8?B?cVh3MVdjVnpXeHhrdERVc1A4ZDZoaXREZXRhMkgySXNZRVFUK3FjTzlBcnM0?=
 =?utf-8?B?Mk13Y0ptRWlwTWFuWGtkOW9QNHB4MU03M0cyNjN6OXpqOVB3UThWZk15aERJ?=
 =?utf-8?B?NzNoZmE3OS9ZbW9NMUZ4RGpnTnhUbWZia2VtaTM2YU1tbGN5UHBaVkJ2TW5F?=
 =?utf-8?B?L2V0UWpZYlc2V3QrVXIwVGRIbXpIc3c3MFdUTUs0WE5hQko0bHk0QUYrZFNK?=
 =?utf-8?B?QW5VZ05mVkZYanorMGNTeFZ5WU5tWllhSURwejdpU0s0T05YdUIvRmR1YlBs?=
 =?utf-8?B?R0svUVNhK0d1aHZWSm5qRDJHeXRRWXBTUWRWNWRUQllGNi80WjNXVzAxMUtj?=
 =?utf-8?B?SEpvNGIxTDdRS0h5TitQQURlUlliT3lRZ1kraFpxTThueXVyV2VxcmYweXhK?=
 =?utf-8?B?S1gxTkRrbDhCMFRCNlhQdi84TWczV09HcHR1clNQOGUzRFVrc3IwUFVqRkRw?=
 =?utf-8?B?enRkVlM3aWl1WDJzZXhTUDFWT0swSzhCaG4zNXppMUk5S3RLRGc0M0N1R3ZB?=
 =?utf-8?B?aXV6NTR2SXAvclpkbnhmQnRyM1JRKzUxbitFZHBxTDVqV2dnOUpOR04yRXZU?=
 =?utf-8?B?cmFXV2NLcmlIODlLVzBaczVla1FxVStFN3d3eTRreUcwSWZJa2pmOW5iK3k4?=
 =?utf-8?B?a2hKMWhEU243OHUzd0ZjYTB1TS9oNm1SOEphVENZTFJRV0dtcWRaeW1weUV2?=
 =?utf-8?B?WVRIQUZYeGtONm84YVFZYmxjRjM1aTNkN0tlL1dtdFczY3hvN0EweTY2SGVn?=
 =?utf-8?B?cGl2TitKS1ZvUTlYL0lKbEVoNEdzdUFCRk9LelJYbUVINnVTODJ0M0NCWWNG?=
 =?utf-8?B?QVJkVVJ6SW52b2owd0tTR2l4SnF5ejhBVWZuNkpBRzRwNHJqL3JpU3dqM3RO?=
 =?utf-8?B?WWdOOXFodWRYMEpxT1JOdVdWRzVIUGhicXdHeDFuU0VLMVJEZ3dRcDR1dnZ6?=
 =?utf-8?B?UVRVK3QvSDNOVFROZVdsc1pOVmRpckg2cmJKK0M2OXI1WG5TUS9ManhFSTZR?=
 =?utf-8?B?cy90cHVwS3lmbkNqZ3prTGFpTm5ld0dhdVN1Zm1ybTJ5VXJpU2NUMkVGOFVM?=
 =?utf-8?B?bnkrMmJRWExjTWRLRDJLSGcxaDlWdWJvNTh6SE5HSGFPaXczTHlxOUxLV2s2?=
 =?utf-8?B?ek5XMVR5SEVjSjU3SzNrMkZQUzVRaHJnMFN0cXc4c2g0ZklmT1dEYkl4QVJN?=
 =?utf-8?B?dDhVZXhGVlBsY3FFY08yZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eTNWUnF1Tm9kVXd6MXAzUmowMktNTkQ2MnFMZlh5Q0tHY0JiVExQY3MvWDJq?=
 =?utf-8?B?b0Fqak1iSVpDcWUwelJUSkF5WkZwOXJqc2dTUzlBeXlVcHNSRmVGNXpZcEJr?=
 =?utf-8?B?d1lKOTBTbllDMFFYRlNKeXRiZ2lNY1hia2h5YUkxTENRTEZFc0ZvZUVVdm5v?=
 =?utf-8?B?eGRwa1FLaDM5eC9NQ1ZMYkNVNjRjeWVvNmhSczhpRUVjSXI4bTl1cVZMOVVB?=
 =?utf-8?B?YXE1VFFaT0E2eWNNNGhSU2VPWXBqMlVnNHRtVE1mWlpTTW5LS0tuK3M4TWQr?=
 =?utf-8?B?RVMzWE1wSE54a3V1L2JYMk5NWTJhdXpubFFrSEZYMWNQdjBNbFk5blkvaUsy?=
 =?utf-8?B?TmVUTlgxUCsyOTRYUk13NXRqS1psRWNNMVp4eVJmMS9VZ1dCZWlpek5sWkRB?=
 =?utf-8?B?QlBORzdkd3dYOUJ4cWJUTEljVjhnWGlTOGljWXh5Q1hZVDc3M2UyRU5aUHQ0?=
 =?utf-8?B?bWlYK0FOY1FLaGVBQUJEUjViOXFtVy9BVkNvMzdGUy9SSTBZR01FRDhDZDJq?=
 =?utf-8?B?WEJJUjdWTkJLNWlvbElieFhqWHZJalJ3YW90U0pjaHMxeEVCellwZSt4SnNB?=
 =?utf-8?B?Vkp0TjBLL25VdVdhdElXYkI4L2pvUy9WTXBUN3pxL1phQW9wZmRJU1hZVGpB?=
 =?utf-8?B?cVpaMjJoNWtDbVkyRHFzbUhSVDVSK0FMV1ZVL0dML2RsN0NXaTZUS0xkeUxn?=
 =?utf-8?B?WndPRTdtUmtTQTdQYnpzRzFJRjJkYjVmVkZBMXQ5aWNTS1lqL2pFaXhQay9j?=
 =?utf-8?B?Mzc2ZkkvRE9md2FIOGNPOHRWZGJRNUxkVmsyT3NIckNxQ3l5MDNUTEpoWjNy?=
 =?utf-8?B?VGEyL2pxa1RUc2JnV3p5aktlaCtVMHZoNUMvSlI5S0pWRUkzVkdmRXMwdU5w?=
 =?utf-8?B?TDJFWkd3OUpxMnJUeWNNVWVrZ2o1dDBsTm5yd0Q3TU5WWUpYVUdSeFhsdXNp?=
 =?utf-8?B?SUYzYmlWQkFrVWlGSUVpY2NlS2F4ZkZLQVYyaWUrLzZMWDVJUVlOaVlwN2ZV?=
 =?utf-8?B?S0piMzJ5eXg3R0E0WUROaEpkR1lTYTZoUEJXc3htcmljRFpXU2F5ZWJOWE1R?=
 =?utf-8?B?YTFNVEwxVFAwb05MaWlZc3FvcTJXalgyYTlVL2loNDZJYzJIZmx5bE50NEUr?=
 =?utf-8?B?WU5kcFlpNDk4MFRmS3ZKNi9weE9yeGVxV1BlSE1zaDlpSWNQVkg4SDlBdDVZ?=
 =?utf-8?B?c1hXQlNaK3FRdGEyeVlwOUM0aU1GY3NWTlB2RHU2RnU1Nko5YUVnTGd2MFNS?=
 =?utf-8?B?SUphcWRZSHFsUFBFKzhBZFZhRUt5OXlOWktsQVhzcUJ3bVVJWVRsWUV0Sk5n?=
 =?utf-8?B?WU1HQjJDenZPblpzSkJzZDcwRGllcEJPdUpTVzFqQlJxVEt3dGhYOUpOaW5r?=
 =?utf-8?B?QStiYjJCaVlPRnNPdGRET2V5RE1idGF3RHNTREhyMWJVLzl1YjBBWmVLVHVG?=
 =?utf-8?B?QUpRTFBlYk15Vno4c0Z1UGF1YVQyL2M1eFdvMGJxMTNKZ2RIN0R2YW9YUzhJ?=
 =?utf-8?B?dXBOSmhadWVrRllKNEpndFZhdWRkek9RZlZqR0N2emZidXc2QVJ0Ym9iNWx3?=
 =?utf-8?B?TnhONkE2NnBFd0tSTVcwa1M4QW9hNXBLcFk0UFluWFVFN2xOSmZyQTRheFcv?=
 =?utf-8?B?RFJIMllpaUExZ1FyVGtJeDJyR2F4M3d5eXZYZktIVTIzYzBvQ01jU1pUYVBa?=
 =?utf-8?B?TXJEYTd0N3hCMUFvVG44K2dsMHpMUVExb01FSEV3cGJEOEJrZHE4MzhTam1m?=
 =?utf-8?B?YzhoWGhNeDl6YjlMSDVZZlFZZUpLbis3Z0xsLzVrbU1scTVqOXFZdU9tTkNN?=
 =?utf-8?B?YjhndE93YkVpaSt6dmxnYmNjYlNhZHRJc3BrUVhsSXlVaUFIZm9MQzVJUlFE?=
 =?utf-8?B?b1dUa3R1bW5ZNmhxODZVd29oV2tUU25LV3hobFRzTm1KU0NaNGJNWVJMRmFS?=
 =?utf-8?B?cVdJeXN4QU9jUjdwejROeVZwOVJoOC9wMWY0UXQ1OGZpUkZZZUpEUFN2MXdm?=
 =?utf-8?B?VUE0bTgyY3VoQWNmM1IwOExvbS9xaDExa2p2TDRzdCsrSVJJdk93eGo2aE9h?=
 =?utf-8?B?V3Y1aUo5aVVSbCtkaWpXN2pnbVhsRnRYTFVwOUNUWnJBbUVKYzBOc1g4RGhw?=
 =?utf-8?B?MnYyWm50RUI5dWVSUnZzdlBTQm5aZ1VaanFoVnNqcjNIa0l6ampWdU96Vnpk?=
 =?utf-8?B?cGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 59b0935a-36cd-405d-5225-08dca2214fd0
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3768.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 03:18:36.4131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xtf06fIhwtzngWPRFMqu2spxuA4TnwY8ffmY/iVUQuXsK44tNd/fQQKGDFCAfufkcCLAhqXjywhZ7kgXQ5uWJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7249
X-OriginatorOrg: intel.com



On 7/12/2024 2:51 AM, Ashok Raj wrote:
> On Thu, Jul 11, 2024 at 12:44:23PM +0300, Ilpo Järvinen wrote:
>>> +static bool sbaf_bundle_completed(union ifs_sbaf_status status)
>>> +{
>>> +	if (status.sbaf_status || status.error_code)
>>> +		return false;
>>> +	return true;
>>
>> This is same as:
>>
>> 	return !status.sbaf_status && !status.error_code;
>>
> 
> Maybe another simplification
> 
> 	return !(status.sbaf_status || status.error_code);
> 

Agree, this looks simpler


Jithu
