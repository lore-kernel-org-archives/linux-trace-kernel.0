Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9C9C8C0;
	Fri, 12 Jul 2024 03:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720753462; cv=fail; b=sb+ESWG2w4StURxRXZ3tDJRNnZTcEVfW+w/3SNm9cACYomqSwBStM6yrBxGuYIt+Jkrh85wj/ghoOJbijqE34bbqW/b8ei0mxTMQ/hk1zVfkRY4/x+/+fD7Ujh48HTxCf1lN/CYXKQwaZx03XvnT8cu1N0Qa4ahu21k/LCz+I+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720753462; c=relaxed/simple;
	bh=13z2TALIXBtkvtIv2njmbnb3jqTxmmcUgYG75jSMx3I=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ewavENF6dm1d8jsuBfv/LgJkAoCZRssSWj+okvOJr+fV9jcxiwIbWZhvFkUrX0056tbJZHHbvpPR4R31xpVByddeNhT7GydIvxEekBbHR2C7zaFMVTJJRq51TiC5PmQzO0Hc9rOp7vlQAIXLFeMqyNipzN3aqKG6+FHP5gwzyN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pbe99V5M; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pbe99V5M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720753460; x=1752289460;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=13z2TALIXBtkvtIv2njmbnb3jqTxmmcUgYG75jSMx3I=;
  b=Pbe99V5MWvOIiB3QDfr6HewkZfnExN4lKKzL25+zXI47MGqTCdhzglkc
   /jC8Iwi9jfMn0rXnmURsfiYAJu4tTvCXYprq7aFoF+A5Q4u/p8sEaeD8F
   RWC1anyQkIDswbFqyu9ZxEbEE0nAsNCl0BVZyB+0AnLWtWpY2l7ey4pqs
   i+DOizXnNQwpwovTYHKZ2Z8oRrDu4k6pUV4pB0nGGTgxnq7cCey2knlaw
   WdqFhQhNbnEGOkaEZjEYtfo2AB7FHLDMd7YP2xgP0wo0wtFNx75UBK3PO
   bSrKYxl//yBCoY3sMh7dDiXs37mh9vm745s4NyTCl1k+ATdhUPkY/B25i
   Q==;
X-CSE-ConnectionGUID: ky+N/PcmSziCXlkDiGaCGA==
X-CSE-MsgGUID: TSbYYGEmSY+qVeSsHZRl1g==
X-IronPort-AV: E=McAfee;i="6700,10204,11130"; a="29329182"
X-IronPort-AV: E=Sophos;i="6.09,202,1716274800"; 
   d="scan'208";a="29329182"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 20:04:20 -0700
X-CSE-ConnectionGUID: pOE+hTXsRvig/d2vx+hzYw==
X-CSE-MsgGUID: KhbNF7zuQIyBmET4glX+Ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,202,1716274800"; 
   d="scan'208";a="48852796"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Jul 2024 20:04:19 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 11 Jul 2024 20:04:18 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 11 Jul 2024 20:04:18 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 11 Jul 2024 20:04:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HbmoFz/BtQ6lKD1GKzUhbs7WNvjdYa0M540joWOq+HH5wEVwhj35UppzIia6uXfnE5JvTEFSPVyBprhDY/Gdk8c9ALRKXTcj7JeaIeM7BI0FdRUZj3FKefcGKqAMGO9GZUZEdxLEvkW3bczVCD1kTfz7QKOlbNtEf9PI5txXt2F0IZagYVR/2oKCjNF0vnspcSMq/icBifT6VCxj4OyMZjDgxqB+cTv33OeeyRu7GrCL4F3BnFkyqfiZwcwZL8sXTCb13jp34yKqGOX5d7U/1TeW/ZgbWrbuiUvDjcKaUP5QUgcArBCk1NSqZnEiVWFlpIc+XyaM3QhBRz1lKMvhUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QHzLm3b1g+jxRjz4sWAaGYaFPGAU/q3qqEJj3cwMZQ0=;
 b=wyhrxWfvz175V3I/NiMfJm1bg7m+Dz7PAXQABfYr40+aFM6Av/d1GkRRBZw8ew+ktEYcdbTnjZVVIXr+P/3oav9e71tdWeJ/1TKIYTXt1Osylw7dIjsRHqvPlrWs9zeA268V9OnboQAFPq+VxrgUpe9H1XMVy2z7RDAQ0v8A+mzTj+ZDqm1i26A8pUej8WAZbiI52h74zuy5blF3vXqiRlq83PYj1erMR2fcv8Xldbzkc/WacsdKl9AhnT96YpsYfNcEQM3ioepddRoVEklIFyGIbcwUlcpEXu/6IDzcxvoEh5nc4IA66MHkOTCG0astryb52g79oK8tT8e+dwqSEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3768.namprd11.prod.outlook.com (2603:10b6:a03:fa::20)
 by PH0PR11MB7471.namprd11.prod.outlook.com (2603:10b6:510:28a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23; Fri, 12 Jul
 2024 03:04:17 +0000
Received: from BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::c207:cd2b:43ba:3d38]) by BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::c207:cd2b:43ba:3d38%4]) with mapi id 15.20.7741.033; Fri, 12 Jul 2024
 03:04:16 +0000
Message-ID: <1483b461-25f2-4eb7-95a8-5e150786d956@intel.com>
Date: Fri, 12 Jul 2024 08:34:07 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] platform/x86/intel/ifs: Add SBAF test support
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: Hans de Goede <hdegoede@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, Steven Rostedt
	<rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Ashok Raj
	<ashok.raj@intel.com>, Tony Luck <tony.luck@intel.com>,
	<linux-trace-kernel@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>,
	Shankar Ravi V <ravi.v.shankar@intel.com>
References: <20240711000233.684642-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20240711000233.684642-4-sathyanarayanan.kuppuswamy@linux.intel.com>
 <6f445c03-21b9-87bc-1bc1-ca211c56eaa0@linux.intel.com>
 <7e1e86b9-9578-441f-9f4a-23c274234344@linux.intel.com>
Content-Language: en-US
From: "Joseph, Jithu" <jithu.joseph@intel.com>
In-Reply-To: <7e1e86b9-9578-441f-9f4a-23c274234344@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MAXP287CA0018.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::33) To BYAPR11MB3768.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::20)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3768:EE_|PH0PR11MB7471:EE_
X-MS-Office365-Filtering-Correlation-Id: 85325d86-7ec1-4eaa-d4d2-08dca21f50b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bHJ5YXdhVk01TWp5am1GNmRSdWpjeG1jbHNXMzQ5WWV4Mm9LYlgvUzBoUXlR?=
 =?utf-8?B?ZzBvN0RrV2k3aDJMbFk1aDl5VDhVSGlJUVVMWFJTd0NUajhBQ0UvUDRpd2NF?=
 =?utf-8?B?NkowSnVEL0ZtR1hLL1ozWFdud1ZPaDBBNk9zaGpjMnczN1kwTmRlcUJLenJZ?=
 =?utf-8?B?NmpUTkpQdDRtUFgxZTI2aGtqaWl2WTY3ZVpPTnJZQmtRMmpqdHErWldYWHBa?=
 =?utf-8?B?WDdiRHc0T2VVWG9Uc3hMMVhmVTNUUWNjSkVOZW9lcTgrUkd2aGNkbWZmQSt0?=
 =?utf-8?B?VjZTejlPVTROSGxWckp5LzQ3VmNISFQ0eWxHVmRpUTNCajRqdkxWTVBTYlBN?=
 =?utf-8?B?ai9rUnhWRVVjclU4bTlrdzZneHFMRlV2bURqWDVRYWd6dDBpRWUzaEFrNXZY?=
 =?utf-8?B?MjJQOFc0TjA5L0VaVm1BWGY2OElSMHY4YjR2bm1abC9EZWZrVXlwMEcxNkd2?=
 =?utf-8?B?ZUtEVnBGSmJBYkl2aVVtY1pLeGZKeWthQkJtYjJiTmFsQnd0ajB5aXNaVWs4?=
 =?utf-8?B?R05nK1V6d1RXWlpHc2tZK0pCTUdlejNjaUJtTzRjczhCRVRXWE5jZXdUTGtN?=
 =?utf-8?B?a1RBS2pOREk5MThBdGZuRUxVVnlPZWxKa1hBeDFEbldUb2gwU1lJZXB6Y2ZB?=
 =?utf-8?B?SkU3QzY5bjdUUTNDb3NWaXYrN1BVUDVpMGNxSWcvVVlMUEk1eEdIYk5RSFZR?=
 =?utf-8?B?VUNFWFgwc1hLWXVDS2Vic2QzSjRVei8rS0psQXd5dzE3RVlPMTA0cm5HNjV6?=
 =?utf-8?B?OHJTMUdTSTRpM0luYnlUQnpOdnhKdXpVOE43dG9Oc05tekIvRHd3QTZDYy9O?=
 =?utf-8?B?UkhjQ2VyczRIYStzSnlpR0dMQmtXdWtibC9sZUpMNnJMQUpNSnNoTTNDeWp0?=
 =?utf-8?B?S2UzV1lDeW4xZWVZeXhHQkFOeE01OE9XSGdyMU1WMlM1dnJxdnBSQTFSRW9p?=
 =?utf-8?B?ZUM5V1ZXWG9kaklXaTRCcmhQY2xFR1kydjk2cnZKRFBaV0wyNnFBTDFUVlhq?=
 =?utf-8?B?MlRBZjNJQ005L0RVZ3BsSjl3KzhiZDMyOHVYS0duS1NvUFZiUTNUSWp1bVJj?=
 =?utf-8?B?Zll3QWFieG01NHlTOGNJd1l6dlUxNmp6Vm04dHA0bW4yTVZ4QmxyV0YxbjVU?=
 =?utf-8?B?WnJ6WVBySmxkekJaUTVYbnFhVTRTemVSVUk2YURXanBNUmN5MGJ5TTY2eUtS?=
 =?utf-8?B?cEs2b2MrYnQ2aXhPSytTYXN4RDRMVVllak5zdkN3Wm1lNEQxbExMMUlnVjZJ?=
 =?utf-8?B?RlVWWEtKYytod3RIZlduMDhLS0VwTitFLzY0MUgvbDVyVXBGQjlBUWQ1cmdz?=
 =?utf-8?B?SHZtY0JaWEVJSk5BSUpOWEswU012aUtsNjNCVVo5SituN0M4TmdDT0lZZ3E3?=
 =?utf-8?B?dnpsWWRJc2tvVE1sdiswR3Rqdy93aFR1ZVc5WnVzUldpQkl6eU1KZUNValJ5?=
 =?utf-8?B?Q3pkZGNycXFWYXp1Zm1rQnVtbVgwRU9hT0dkd3pHc3JNNFJySmJhbzdrTmRW?=
 =?utf-8?B?bE1wSTlBK2ZBQzRudmVKZ3ZueXZFNldIQjlydnhkRnpRelhYZ05YTUpTMVpj?=
 =?utf-8?B?YVVzY3RsUWtZamxoQnNiMmw3NU9RQ3VjWXZHQ1BrUzBDMS9sUC84UDNuc2sx?=
 =?utf-8?B?YVlJQnVnLzl0QSs4bkdiVWRHbjRjNjQ3TFEzbXkrZTZKRExoRnc1S3phUkRX?=
 =?utf-8?B?VlhNWVBrUm1MelJHd3FIUGxqa0duNVovUDNJTjlCNjNjOUY3a0JRQ0diOERm?=
 =?utf-8?B?cFo0cDd1a1lSclJQN0tvdmNId3lESTNSRE0zSWRld3FsRTFUelRZZ0VtL1cv?=
 =?utf-8?B?a1dSZmhCR2xENlZ4ajFPZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3768.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFFkWnEvUVZ4eVB0Ni92cWxRY0pvZVBha1VQOTIxMDdqR3JlZnhVZXhvV0w1?=
 =?utf-8?B?NUxDdVk5WFBrSUlsbVlHR0NVQVJJT3I3QWdNZFlzT3J6M3V3aUhqZGR1bDFj?=
 =?utf-8?B?aVQybkpBdjRuT2RuL3V1MVZSNnNtZjFBU2M0Q3MzVGhNODhwRnpzY1N3RjM3?=
 =?utf-8?B?M0VYeC9KU0tDd0ZUV2FoeHpzSzNWNlA5Y1NWcGFKYWZCcmZhV0t4dFBhUFpw?=
 =?utf-8?B?Vm9XUm9jRUdSa0I5b0wzVE9IS0pzbGVONnFlU3VBTko0aHU2TWZ0ekJQWmdD?=
 =?utf-8?B?NU0wckFrWnppbFJNUWpneFJXVTd5MXVNM2xaREhnYlhRcDFqZG5WR0djd0Qv?=
 =?utf-8?B?UjZXWm4vb0M2MnBmcHZ0WU1YN3RRaUJqd1AvVlMrclpFVjRWd0d2R0F6dG1m?=
 =?utf-8?B?TjNwYmVmbjZqMVlSN1NSSHJsSll2Y2ZFN1gyMmZqcUhyelFYOTdHa0JTU05x?=
 =?utf-8?B?VE9TZVdTdlJ1N09HdEhFdTF4ZEJMRFJiNmthWWp0U3lCYnNieGsyZ3FYN0VL?=
 =?utf-8?B?ZXNJMFhKYmpNbjFQTG4yN0k2Wkl1VGpYUzZvTUFDdGxkUVdtbWVtMks4T1NS?=
 =?utf-8?B?MGNqaU5FcHQ3Q0s1VmpUME1RMzZRYnZSWDBSUG1Ya1hqaDM4azRXcEM5cWVl?=
 =?utf-8?B?N21LR2FwczNIVTJ1V28vRk1vK1kya0dvRmp5UkdQdVlZbkJ1Uk9vcnlTc3lN?=
 =?utf-8?B?SlZKbmNxem5qMlN5bUtyYkNPYW96V3BhWHBRWHFPdDIycGpIcURFYlpZVnE0?=
 =?utf-8?B?bm5iQm9TdkM4WmF6MXZlU3RXTWxOMTlwTEtEeGlEdVh6ZTEvTE5Yb20wdUlu?=
 =?utf-8?B?NG9mLzRoMG9TUk01Vzd4Tk9vUFNqOXhQSGpHVDZkbGoyM204UUd6V0hTdU9F?=
 =?utf-8?B?TTMzVDRoZGRSUXNxZTRhZzNOakU0ZEdKYzZMY080MmZYdnVXbmg5L3ovN1FW?=
 =?utf-8?B?TDVpZ0t3VWxGQTdoR3o5NHhwM24ybm1TeEZzRTZLUytoU3EyWG02WS9Hanl3?=
 =?utf-8?B?TmtvTmNDUHYxRXZxUWEzVjQxTWpHRjdiMDB3dFJjL09CQkZOWVVCNGN2OHhQ?=
 =?utf-8?B?aU5pQnNiNjFzVVJDWXZVZTF1c3lyUlQrR092UzNpWTdyR21pODZLUVZ5eGp6?=
 =?utf-8?B?RUJ6ckdzdE5PMTRJc3I4NXJjL2plRGZQWVVjUzFwYmxYdG5BbktMSjV0WUx2?=
 =?utf-8?B?T09lUFc0Y2prMjhSOGxlMzBzY3Z4TWd3VlNsZ2FIT1paeEFnQUhHZFNydG9M?=
 =?utf-8?B?bjZNdFNYRW9PZHRKY3gvUUZNTFprWnJZSGdoTkttZURDa3l1a05wZ1dyRDRS?=
 =?utf-8?B?cEhJOFBvVTR2YTd0NENjSldjc2h3d044MDNBWGNxZlhRajJsVkI2Rml6MURN?=
 =?utf-8?B?UHNkR3N5TVBQUG5oZzF1TklTR05zK0htSkRUQlIrTDJ5NnNZVFZKL2Z6Q1A1?=
 =?utf-8?B?UVF4RGIwLzRwZWNIOUR1WWJxSno1UkdFVEU2aHJmd3FSQXkxRDhUdUZlSFFJ?=
 =?utf-8?B?akFlUUF0NHpxM3ZoaXhsckY3RUUwWU1rZUZCTGliUjlYbjh2NkFxSzA4eVps?=
 =?utf-8?B?TUd0RTNpdkxJbGJaYjlKT1FyN0lQR3lMNEw3T0JuZUFDcmYzTEtxL3VETW9T?=
 =?utf-8?B?NytNaWZaQnNVVlNOTmZQd01keFQ0WWJLQzQrcmJtU0RSWVo2ejQrZFVPSGRv?=
 =?utf-8?B?TzNNOVZBZ0llWFp6b0ZUK1dNQ3hlYXRnejBPeWJPbEZ5OGRPem5FWjNRMWdK?=
 =?utf-8?B?THlveWIrSnZSQTNGUTI5ckRjSlpJOVRyc2VIQmlTNm1BbFBhMHFDdUovbzNm?=
 =?utf-8?B?QnVCN2VlanJLT015YjNnaGQxRVREZVE2SkFaTUdQcnBvdnYwWXlvd0xYU29n?=
 =?utf-8?B?dFdLU3NSVWpjdmpydWMxUFdleTlWMFVsb1FBSmFVYmtYSGI2SHVwZzlvUVFO?=
 =?utf-8?B?LzFDM2RudUQ5UWtkZWN4S3VwbjlDTmR2OUR4YURlL1lrYkxTaUZyWWl2L05m?=
 =?utf-8?B?SEk5YUhKUUxNdzFGTk9hUXJxVlpuckhTSHplSkRXbWFvSUJqd1dsZ3kvd0Ft?=
 =?utf-8?B?c1NONGhVa3g1ay9CVmJ5NHJFbWdGYzZDNnJ2SVhUWjlRVGM3WFFhZWZjOGE5?=
 =?utf-8?B?V0xqZUN4OW5pZUptQTNkMkNOQUFoeWk3TFBYTHFHakRhSGhhZ3I3Sis3RjJn?=
 =?utf-8?B?UkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 85325d86-7ec1-4eaa-d4d2-08dca21f50b9
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3768.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 03:04:16.5007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DQz3xh6ZgpaYJ29zupVSfYLWx5qdqU/5G2CG14OwUOqkUxPNXHuLQl/IsmYXqEEXjA1v8N6h5RbMGq6ORNzrRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7471
X-OriginatorOrg: intel.com



On 7/11/2024 9:28 PM, Kuppuswamy Sathyanarayanan wrote:

>>> +
>>> +static const char * const sbaf_test_status[] = {
>>> +	[IFS_SBAF_NO_ERROR] = "SBAF no error",
>>> +	[IFS_SBAF_OTHER_THREAD_COULD_NOT_JOIN] = "Other thread could not join.",
>>> +	[IFS_SBAF_INTERRUPTED_BEFORE_RENDEZVOUS] = "Interrupt occurred prior to SBAF coordination.",
>>> +	[IFS_SBAF_UNASSIGNED_ERROR_CODE3] = "Unassigned error code 0x3",
>>> +	[IFS_SBAF_INVALID_BUNDLE_INDEX] = "Non valid sbaf bundles. Reload test image",
>> Non-valid SBAF
>>
>> ...but given your define is named "INVALID", why not use just Invalid 
>> SBAF?
> 
> Above string is from the specification document.But I think it is ok to use
> "Invalid" or "Non-valid".
> 
> Jithu, any concerns?
> 

Either seems okay, I think "Non-valid SBAF ..." is a bit more preferable as it is more in line with doc.

Jithu
