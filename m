Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC0A12AAFD;
	Sat,  6 Jul 2024 17:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720286450; cv=fail; b=dszDqazxfw48duJUr9s3J6JvBQ07IU/xa9eQU/wNmmLgbgrqGPvpRTHXyKpXz8MGTZCUUHeVuFD2JDAd4XT6FkJRMRVkxKJ5UzNd0y1EWLkLaGe4sULJtDpCl35sNLswcPpXwhGEcyKrFJkgAT313hs28z5WQOVAEwx4SNEub08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720286450; c=relaxed/simple;
	bh=wk0yBj75BKmKEButRsZqxdFrRIcTyLo/XlzQFQij0aA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YzHrXaR8m9Zdrb+3gPXOYLevmNeJVsWaUbBA1cRi+aQr7uz1e/p/7/HDbFejpbmRMA0myHo4PldYtxAS9UTsa5km4JoRy6Gi4ygcfkZN0Kbz/4FgQvSei/YDAhBTBBZFkRI0I7Fxm1bjJnoPku2kDHnWr1fLlP2rojQJP10vJSA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mLPhxvJM; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mLPhxvJM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720286449; x=1751822449;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wk0yBj75BKmKEButRsZqxdFrRIcTyLo/XlzQFQij0aA=;
  b=mLPhxvJMZY9v9PWnmRlswUI1sJiy1tHIc1bSHwlEx08wpMUDMhy3Co0V
   dHk59z25tRLmeBDeN3NUgEs2QJKaTgwL4eroob2bgI5b+7TX1LRGneNUS
   EQbxZAD7nAMA4RcfjJZj+k65UsxPcjHUma7eXkgmxsfOZrXHNZgl2BCQl
   8JnWNCUQDiD3DlqudPDZbBsn4jowB9U8+99jEBUA9NZqsxZvBmg9s8pYZ
   FBig4148eORknb/eo7UkCDeMp0VxHRso5Q1ihtG/qKxhEL29FMj7g0iqV
   GUYWaSTbmYg3iYED9cQqGIOSki0uGRE1zp/39fNQLpkSYp95kua0WB46b
   A==;
X-CSE-ConnectionGUID: eR0eQvhGS1OmwlvidSczXg==
X-CSE-MsgGUID: JKHj4kL/RDyv2cB4T9gxGQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11125"; a="28141082"
X-IronPort-AV: E=Sophos;i="6.09,187,1716274800"; 
   d="scan'208";a="28141082"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2024 10:20:48 -0700
X-CSE-ConnectionGUID: PQDsBqS4TkG4dOWyYDNkJw==
X-CSE-MsgGUID: Ud/Lwh2dSOmTbZK5C+aZjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,187,1716274800"; 
   d="scan'208";a="84656637"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Jul 2024 10:20:47 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 6 Jul 2024 10:20:47 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sat, 6 Jul 2024 10:20:47 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 6 Jul 2024 10:20:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ia5YWvMkTQ2RA3rhlERfrHfIg7OeIG65R5/gX9jteV67Lh9cZ5HdOSsdENeT5CCwaaPm5sa6XEir2y/QMiWgOKwp+acctE/Jqtc6WmIpXPW/hRg2UpUXBsemNmXxxH0gRRVMIIL+70WCT0BX+spQx75JFX5DWJYxOnmrr1pGLiwiI7aadY6z3kOMMpcOmrQ7MxYsCM5IWLGA07qBInPNBFNIE+aw/9P5lcIvjDHibf9e9WSjaaZZh+n61nANdMC1Rw8Wa+FOSdRhWYvHiu7FuN9Q9XIEdc/K4WPh9kG9hV67GCcTOxyPH1OFi31GPFxnxxdydvuK3X+LJW94bwiMdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GBDWP97cN8Wg9PlRzYcEq5eNGV3PP+ZA9GURWJxbIVk=;
 b=mJfiNidfJeqPxirdlnjoj8MLMILIzlJgFIC8MyiHWyurzhgPmn9PEtOljxUv5WYeKXY/ym1tTZSA6QXcBGecM5oNugXPUP3IDmi8Mk6Nam6IYgnuxR1iW0ZyCaQonDIjHcGawBAA+oinjvRYSC0koBaVXvhgo3F5V2woQRy4qYAIkaXEj4xwE0hpMVCAr0WBLHWJacVXO6hQMftVsaGqewza9gN8vhGXpa+T+2U/S3UJhW9FHRAX85Ge6EV8Kppzk2XIyTK0+bJyQo7sAhkKH8NoPZ9LFyRA/WMTJsmG6k/CwOQf5YRkC0RF7qO2spZ9C45QYwTy45B33TjRYhS83A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3768.namprd11.prod.outlook.com (2603:10b6:a03:fa::20)
 by DM4PR11MB6358.namprd11.prod.outlook.com (2603:10b6:8:b7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.33; Sat, 6 Jul
 2024 17:20:43 +0000
Received: from BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::c207:cd2b:43ba:3d38]) by BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::c207:cd2b:43ba:3d38%4]) with mapi id 15.20.7741.033; Sat, 6 Jul 2024
 17:20:43 +0000
Message-ID: <35482322-8200-42c5-ba4f-8d50f1b1498d@intel.com>
Date: Sat, 6 Jul 2024 22:50:29 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/4] platform/x86/intel/ifs: Add SBAF test support
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"Kuppuswamy Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>
CC: Hans de Goede <hdegoede@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, Steven Rostedt
	<rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Ashok Raj
	<ashok.raj@intel.com>, Tony Luck <tony.luck@intel.com>,
	<linux-trace-kernel@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>,
	Shankar Ravi V <ravi.v.shankar@intel.com>
References: <20240627023516.3783454-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20240627023516.3783454-4-sathyanarayanan.kuppuswamy@linux.intel.com>
 <62fd0e6b-7155-1393-ce18-f3a4ec25e63d@linux.intel.com>
Content-Language: en-US
From: "Joseph, Jithu" <jithu.joseph@intel.com>
In-Reply-To: <62fd0e6b-7155-1393-ce18-f3a4ec25e63d@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0085.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::6) To BYAPR11MB3768.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::20)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3768:EE_|DM4PR11MB6358:EE_
X-MS-Office365-Filtering-Correlation-Id: 49dfa2bc-8f95-4117-ade6-08dc9ddff731
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZTVUUXBBZ3dBb2M3bmpCUFJxNUI2K0VKWGt1dG1sRWZyVlRQVUR5cVByZm55?=
 =?utf-8?B?NU5IWkxwZGRsTU1HN0tWZ1NIMUo3TTYrUnpIdVBJMUhyclF2ejRDM1dvMnpn?=
 =?utf-8?B?UDAzUUFKZUNiVVJxcDdDZTExQVlidzFMdklMMkp3VmVlcHh0ZW1YemZJT0s2?=
 =?utf-8?B?dU5rZ2JBQTR6NGFETjJicWMxY2s4M0gweWxNUUZwVmVnRFgvbkVzM0hZN1Bv?=
 =?utf-8?B?NFFsS2dFSit6YTQ4OGxHdzhpTFhBQXE2M3RtM0MvQ3pZUFZGYkczME1YSUhP?=
 =?utf-8?B?VU02ZExoRTYrNDBrOVhvc2FKa3dUaVppQmpLL2pVVXZCR1V4dEYxenlCZmlG?=
 =?utf-8?B?MFV6NzBHODA3VnJjWkxEVTBPLzcxZUhDckN4RFRnTXUzQ1B5QzZ3L3ZCUmJU?=
 =?utf-8?B?SmZ0eis5Rm9aWlA4Yk1DSXZYSW4ySmx2TUdsL0tMU0M3Q2lmR2hOY2hRZkpS?=
 =?utf-8?B?Tk80RHVnckkwNWxQWjZPTnhtUDM1WDFuZmw4V0NkZjl1V0o4RVRWZVJqRTJw?=
 =?utf-8?B?Wk5SNG5mSkZJejlMWjRiT1hTdkFRc21kbXBaaFRkMFZhKzV0OHZSajZ3TVNm?=
 =?utf-8?B?YXVJSHJzcFBWdTRuVTdlUzNQYWpIN2lYZGRxNVJFaWFkM28wRXZiYVJueFZ5?=
 =?utf-8?B?VE1jRVBFR3pNb3ZCeVdwZGlvUGdnbEI1c2xsb25PamtVQm9YcWg5bU5KTjVB?=
 =?utf-8?B?Q3k1QzRZYzBYN0V5TmNKMTlRNTh1MnNCSURaQnZNZFhwb3lFM1Fhb21Qd2ov?=
 =?utf-8?B?cklpSUlES29sUWlaL3EzUHkwT2RqbkNZTGhzbE1aM3cwTitvWXJ0QXRxcUw2?=
 =?utf-8?B?cVA2aEdqc1B3STc5RDdYYmt0cG1MVmZYaWYzd2xwZTU0Q29qS2RnUmU0TVV2?=
 =?utf-8?B?VVhKSUg5alhqQkYrR3l3bTh0bGpzQW1iZU11OGI2L0dvWHZVeEVTSVQwcGxt?=
 =?utf-8?B?K1BKNmFvMjdIOVdQcGEyL2p3dGdTWmZzVzd0NHNqRjVVU3IrQnVWNWhpUXhS?=
 =?utf-8?B?TXl6ZXJWbEJGTkMxbFYrTEZLbUt4N0dFd3BIYkJnQithZ3FCbWVwcU9hQkNt?=
 =?utf-8?B?bXFVeTBDc2ZNQ2o1OFRqaUFuNm9rU29vMWpTb1VidXdjNmVHcWxYallmblNP?=
 =?utf-8?B?M09jS1JQYnBPR3lYUXBIYU1JM0N1ZGJnVlJVSzBKd1VvS1VQekxMVFpLRmlL?=
 =?utf-8?B?L2tpUk54MmorV2U2djA4K2dEb3lRb0Z1RGp1M2UxSGhkZzlPK1RBL3pyRlRF?=
 =?utf-8?B?WXdJejgycEg0S3JXUjZEVlVVYjBXSVIvRHF0MzZXdXNCY0QySkI4T3B4Tk80?=
 =?utf-8?B?TCswak1oL0dWcWJkL1BsOVBkNGJTVWduQXpkNWFHQmhUNUwxa1BlQzJHRytz?=
 =?utf-8?B?VnE3blBxR1NwdG82UFNFQ2RpYVVoZlVKU2VxMFBNdGVzbVhZdHRrVGpBa2NM?=
 =?utf-8?B?OEtkRFB5ZTdrdDNUV0tBME1lU0hnbE9rSnQ5VDByRGRhWGcwL2o3V2VvTjhu?=
 =?utf-8?B?eEdUKzBJeGxkemRsTzU4RmlXa3BFcC9ZUW5qWEhKbzBsR2d3bVI4bHNrWjZj?=
 =?utf-8?B?cmYzaGIwZ1RkZmdTakVSS1BzcDh6VU1EdGd0OTlRTkpaNXRweUhyRDRNb2RC?=
 =?utf-8?B?VEVUZDRBUGs4c2lkY0pKRlV6RldISUFod3c0amFwdzZ4UFpzNzh1d3NiNGov?=
 =?utf-8?B?ZmxNbUN2N04yRENpbzBDdEF1bmJzWnFoWFpPTHpqWUM2QlI5RWF6TjZSNmtv?=
 =?utf-8?B?dktuRkp6b3pqM01aTE1VbTNMcUJEampuWnoyVUx1ZVBJbTlaZWwyWkpPOElj?=
 =?utf-8?B?WlBySE1WMVBFVHBtRWZRZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3768.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WjVLUkluaHhNWnpLNTBvSExpdi9uNVlWaEg2RzZCRm9BcDAyN2xwNXZ0OWpU?=
 =?utf-8?B?cmRHeVluUG4yN3N2SGt4bzBoVVRuVHE5dnlWTnhSV0YybmZUK1RzMnBQR1p3?=
 =?utf-8?B?TVpHVUF1VHNGVGdtZmpha1lrZFo4Zk1MZEY0eEpMbk53dndIQnlCRTZDMUJH?=
 =?utf-8?B?Tk5RNjdrVHZOaHhIanpXbzdidnVCZ2Z2WmpzekVjbXM2cUdqbWpDdERxNU44?=
 =?utf-8?B?b0pvYXluMEhsTUpOaExQSVBCNytMR0FKbXIrMWVyVjFvSnNGa3pocDlQWFps?=
 =?utf-8?B?Z25UNytsTUtHNU1NTCs1d0VVSXBuanlqRlRhcGxKSFpZVUlvMkEyY2NncG8r?=
 =?utf-8?B?K0QxaGQwZ0J0bWtub0FERmRoU3VMUTNRcmRiT0VyUnpWQlFDcnM1SzVkYnkr?=
 =?utf-8?B?dEFsOTVxZjF1S0hqVEdETHAvNUdNUlYrdmlkSmdQNFcxVmtQMkUyUVhVQ2ZT?=
 =?utf-8?B?OC9kOTlOS2lCMXA2VS8wSDQ1ODhuamJZTzdBSmc5aVRxQWczWVpKbStNQm5M?=
 =?utf-8?B?QTJxNjVHOGx2VWxPYnJnUWk1ZjZnbWl0SGFWcU9mNXRNOEhjWWlMbG5DdEJo?=
 =?utf-8?B?anRSL01SQmQrZzdqeVpJeG4xcXBXZzhCNnZ6bDFoN1lOWGhRdUl3WWdMMk92?=
 =?utf-8?B?N3pnTk5CbWVReG44d1ZMb0ZQR0VmYWRlZ1hLNndMdUJSNk1ib0hlTVNCQzhr?=
 =?utf-8?B?YXN3dFN0cFYrcWZHVmlzYnpPUlZ4QjB2ZTVweTFkT0JIZTV6UytrbllXaytz?=
 =?utf-8?B?L3JSbldLWjBocnFsUlBiYkROSS9GczFiSWhCY2lwMTcwYjNJYTBrVjR6UXdq?=
 =?utf-8?B?Qk1neHBtLzB4M2U1SmZNSW51d0VnMjA0UC9FeC9uTmtsSUpINFQwdndRWEk4?=
 =?utf-8?B?ZndRR2pGMVA0STE3ak8zWkg4MUVLL29NUU9tT3NET3o3SlVjSkJaTTJUYVRU?=
 =?utf-8?B?RVhXTmpZajNkWlNtZHJBTXViUVpveDQvQXUxUGNwOXlzeEJ4azRkc0U5QzRG?=
 =?utf-8?B?U3dESEFtdWtiQVVubVVhNzNxQm5zK0NGQndzL2lqZ0NaK3VPbGpTaUxWbWZE?=
 =?utf-8?B?Z1RuZXVFZGJQMDFQNEVpRVlYU05sendibndPaUpTNDZhRlNKb3E4ZFd2RnQ1?=
 =?utf-8?B?YklMM1duTm9TVk9BT081WG5zYU1OL2l5eEJvOVhjVFViZUhLdUhsRG54bUQ4?=
 =?utf-8?B?ZjJ6NFFHU0FuZ1lCSGlTUFN3QUQ2MThrVUZoVWxPNTI0cnV4alNhQkVQUE9x?=
 =?utf-8?B?b1dGaEJGNUVaQkU3QVRUNGNTazF5Vk56ZGRBWmZLOHMrdFY5Z3lRWVU0U1Br?=
 =?utf-8?B?OHNCVUJSaEd2RVVjZmJxQVJzY0ZiU20zWFpqWVdybHdUclhwU1FYVzZFS2di?=
 =?utf-8?B?djgzMTJjcm5qdGRBNVpMZCtRSlg1d2licCtWT3NSLzhSdm55Y3crZlVnYS9s?=
 =?utf-8?B?K0hqMEpMdGcxOFFmQmdxaDhLYkNadXVmcWdHMk8vUmdwOUdEY2ZBdThjZkYv?=
 =?utf-8?B?cTVPTkRrT2JEMis3Yjcvb0E1cFNQNWZoMDU5WURITlc5SW1BT1VjTXpBQm5j?=
 =?utf-8?B?ZEJqbjFjbjlTMlJabndRZ1JBYWk2L3Zqa2FDVENoUlpGRmtheDgrMkV1UXIv?=
 =?utf-8?B?d3VteGYzcDZ1NkdndXVHUmE3b3dtS1VNdlVqZXMwQjN6VHdVVWcvZzV6UFRL?=
 =?utf-8?B?QWFxdzJRZTlCRzl6UlFwK0pLYTEvL1hlRW8vUGxFOEhmcVl1Q09XalFyZ3Zj?=
 =?utf-8?B?aWNPRjFiYnVGajdGaGtzL2lzUHhzZU9yU2xHQ2lJVlZURXh6NUMydHBSRUtU?=
 =?utf-8?B?dmZRTjVoelJDSnc5Y3FtK3FXTno0c0xObUI1ZGRmZytWT0lHQlpLd3dPdFdC?=
 =?utf-8?B?OHpRVGEwMVRxazlobk9ERjhPa3R6OXRVMldPU0xmbTJYb2l0QUs2akJyQ1Ev?=
 =?utf-8?B?S3p6eXJjMWc5Y2l2RExsSXo5ekJVVWJjYTVnOUY4b1RkL1A3RzVhL0RnaWkv?=
 =?utf-8?B?RFZuZUhmRXRRRlNtaDVMTnhvaVpxSXlUSDJDbHVzRTQ4ZHduUU9mdHNHamVv?=
 =?utf-8?B?bUxxSVAwQUdRN1BuZHllTXR4V2o4elp5MXE3bTNvNTlYaDZ4b3hLY2p0QmI0?=
 =?utf-8?B?Qk40RVZ0MXJWd0U3di9ocEh3WWsvQVVxaUxUdDBCYXkxQkZscHNXRWtiREU5?=
 =?utf-8?B?K3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 49dfa2bc-8f95-4117-ade6-08dc9ddff731
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3768.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2024 17:20:43.3219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uxk3UTMzBvnrdxrKjv2dscXkw56ZHQeyqea4p+VDsO91/Sh2MHQbaEBuuU3PTPslt9a3z2xRp7Nf70sejodGsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6358
X-OriginatorOrg: intel.com

Thanks very much for the review Ilpo,

On 7/6/2024 6:19 PM, Ilpo Järvinen wrote:
> On Thu, 27 Jun 2024, Kuppuswamy Sathyanarayanan wrote:
> 
>> From: Jithu Joseph <jithu.joseph@intel.com>
>>
>> In a core, the SBAF test engine is shared between sibling CPUs.
>>
>> An SBAF test image contains multiple bundles. Each bundle is further
>> composed of subunits called programs. When a SBAF test (for a particular
>> core) is triggered by the user, each SBAF bundle from the loaded test
>> image is executed sequentially on all the threads on the core using
>> the stop_core_cpuslocked mechanism. Each bundle execution is initiated by
>> writing to MSR_ACTIVATE_SBAF.
>>
>> SBAF test bundle execution may be aborted when an interrupt occurs or
>> if the CPU does not have enough power budget for the test. In these
>> cases the kernel restarts the test from the aborted bundle. SBAF
>> execution is not retried if the test fails or if the test makes no
>> forward progress after 5 retries.
>>
>> Reviewed-by: Ashok Raj <ashok.raj@intel.com>
>> Reviewed-by: Tony Luck <tony.luck@intel.com>
>> Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
>> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>> ---
>>  drivers/platform/x86/intel/ifs/ifs.h     |  30 +++
>>  drivers/platform/x86/intel/ifs/runtest.c | 234 +++++++++++++++++++++++
>>  2 files changed, 264 insertions(+)
>>

...

>> +
>> +static void ifs_sbaf_test_core(int cpu, struct device *dev)
>> +{
>> +	struct sbaf_run_params run_params;
>> +	union ifs_sbaf_status status;
>> +	union ifs_sbaf activate;
>> +	unsigned long timeout;
>> +	struct ifs_data *ifsd;
>> +	int stop_bundle;
>> +	int retries;
>> +
>> +	ifsd = ifs_get_data(dev);
>> +
>> +	activate.data = 0;
>> +	activate.delay = IFS_THREAD_WAIT;
>> +
>> +	timeout = jiffies + (2 * HZ);
>> +	retries = MAX_IFS_RETRIES;
>> +	activate.bundle_idx = 0;
>> +	stop_bundle = ifsd->max_bundle;
>> +
>> +	while (activate.bundle_idx <= stop_bundle) {
>> +		if (time_after(jiffies, timeout)) {
>> +			status.error_code = IFS_SW_TIMEOUT;
>> +			break;
> 
> If we take this branch on the first iteration...
> 
>> +		}
>> +
>> +		atomic_set(&sbaf_cpus_in, 0);
>> +
>> +		run_params.ifsd = ifsd;
>> +		run_params.activate = &activate;
>> +		run_params.retry_cnt = &retries;
>> +		stop_core_cpuslocked(cpu, dosbaf, &run_params);
>> +
>> +		status = run_params.status;
>> +
>> +		if (sbaf_bundle_completed(status)) {
>> +			activate.bundle_idx = status.bundle_idx + 1;
>> +			activate.pgm_idx = 0;
>> +			retries = MAX_IFS_RETRIES;
>> +			continue;
>> +		}
>> +
>> +		/* Some cases can be retried, give up for others */
>> +		if (!sbaf_can_restart(status))
>> +			break;
>> +
>> +		if (status.pgm_idx == activate.pgm_idx) {
>> +			/* If no progress retry */
>> +			if (--retries == 0) {
>> +				if (status.error_code == IFS_NO_ERROR)
>> +					status.error_code = IFS_SW_PARTIAL_COMPLETION;
>> +				break;
>> +			}
>> +		} else {
>> +			/* if some progress, more pgms remaining in bundle, reset retries */
>> +			retries = MAX_IFS_RETRIES;
>> +			activate.bundle_idx = status.bundle_idx;
>> +			activate.pgm_idx = status.pgm_idx;
>> +		}
>> +	}
>> +
>> +	/* Update status for this core */
>> +	ifsd->scan_details = status.data;
>> +
>> +	if (status.sbaf_status == SBAF_STATUS_SIGN_FAIL ||
>> +	    status.sbaf_status == SBAF_STATUS_TEST_FAIL) {
> 
> ...is status.sbar_status uninitialized? (And perhaps other fields too 
> that are used after the loop?).
Will initialize status.data to 0 (at function entry, prior to the loop) to ensure that in the unlikely scenario of taking
the aforementioned branch (on the first iteration),  all the status fields will be zeroed (apart from status.error_code, 
which would be set to IFS_SW_TIMEOUT at the branch)

> 
> It could also be that the timeout check shouldn't be before the first real 
> iteration inside the loop to ensure that kind of shortcut cannot occur?
> 

Thanks
Jithu
