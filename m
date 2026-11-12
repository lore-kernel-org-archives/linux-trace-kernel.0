Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.7
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794477196;
	b=u80Choxa2oj0J814lL35ynKoz5wX9df44T3nwCVBaQxAgSvZusa89V5q7yg8iipzJtv2
	 hbQl4oGel3QEHqD6svt2IJ+4ngcjwTyQYqO8MLjLuf9Aq2NXIEZc0MBLeBW2Ctv6Yadfq
	 43QMMk2/bYyl5QvXvZ5Huy2a9yimPsaVJqy7BqoTfsJATtWrXPJtOZtJD7C9cgynf5R1e
	 Gig/I2EDf+/Ix4S9Y5F5xUODXGo6SIMIRWG6tuBPe86SvXjIL3neUIOnys23vzE7FIEVj
	 PK599tw/O7jp8YCikOV6WEwpQ5P0lAW6Mw0f7tnbJ2HBVIyR+Z1JqKE+ZD5oBDReRnQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794477196;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:
	 Subject:To:CC:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=Ppe/pMv7tZC19LMOu9qi2yOdwjpR/p+vZJGY5kT50N0=;
	b=UDrdJekzWwnmaUXFlZ16PGebeCIPBF+T99Mp2cFpAXHcRYzcSDcDXFlPDnJHgjd9r4HF
	 fKN7r1WrUYXruXmpsvESn2AZojpTtmCcKD2EdBG966JDWEIlI95/6Peh+KMObWh3BqNHw
	 ko5Ms8POOLdSW8hDCjqWj0kWsejSiPWEU+hNVGmSoI20t8NTLL3Osloj4F0WMMVeGdCQ7
	 8fMeJ+9xvNrBEv04qwzJGEnhcKsO12n+LpSc9XPzSlYdrivLpdJCBN284ZuZzvzlcDfgt
	 607AnKqylzJYXton6dhypegOZL5taWaFcwyvhS7RVEZIN2EUpdLHCHmPRXhA6yBHFpA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=B2RZv4G1;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=bYNEqiYZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78ACF606A327;
	Thu, 12 Nov 2026 09:53:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78ACF606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=B2RZv4G1;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=bYNEqiYZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794477195; x=1826013195;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8S6ANc5jvqEy/eojUQ0axOC6R5NgOPzLuOk/Fw5Aysg=;
  b=B2RZv4G1RVOakuJxuYOEXACTMjVbhFLcwEygCaJF0c3wBtUTfUKvIB8K
   1UZJRR+fPHAJIRyEijRE0Jwp2bQ9T6vBeBwiZ+bdgZuLHdkkbhxciqIpc
   IlwdqccTRrfVxI2Zu7T69ziSe2R2laTY9GC7c4CwRrvd378BmOrfuJUWY
   dU0eFZDMrAnefBDj/9SYQvCQR6+8f9BRY+MjhYHNCPVhQ/hpqmSf0HIR+
   gLNHPu3RvHYQCDd3HHk4qTE+SO93FyTHSg02eB/KAJX6XoPgdQACiEu4v
   6zp36t7h9MQDGtN+cT2nwdXzF/KPkNkk2SL3LEEl5XHJe6TpaV2nTH3sA
   w==;
X-CSE-ConnectionGUID: kA3pyI90Tlym/ABQVPi60g==
X-CSE-MsgGUID: l1bQ2yOzSI67VZJcWx2jfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11963"; a="3127392"
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="3127392"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 01:53:14 -0800
X-CSE-ConnectionGUID: guGHRIVhS5KUbYd3yTpGxg==
X-CSE-MsgGUID: 8ljavJ4yQJ+3/C8wjbqtEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="8617951"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 01:53:14 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 12 Nov 2026 01:53:13 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 12 Nov 2026 01:53:13 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.35) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 12 Nov 2026 01:53:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mUEu2+RxCCvfS88ORbWVf3AbO+poeFsr4GHky31JqHlG9uIwU76CrNBuBTQi4e1phAv3xOOZh9jyAWGE23hBggzsZm0TZRfzd8PAFJtjTumNgtzlLa1pIIlJoVKGyYIozjHOFCL+RePytWOGQL/FMzJPTY9n3PJrFKL8FAxS0COsUltyQiC+UPJKSpOcRGsYMh1dbdKYPGA8c9iij4XlMVf5jt0gl4XkcX2ZlXeVPadCemTzXk1svUsSWsQd4LGRaChdSTjUIU6kg61YFGVkt5LjxZeEJxX0KWjP35mWRGY194vIWHtKSiSiBk0O8LvEB9w8RNH2AI8yjdTvwF7r1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ppe/pMv7tZC19LMOu9qi2yOdwjpR/p+vZJGY5kT50N0=;
 b=tRAVjaeJLIfxETUlUyrEzQvL9TXcq+whWOAGVCALlHUANyffkbo6zSBdtk4E2RjVMVNcKMTKmg+Lq1Vj4r1Xbovc3VDohN9kGTPLdhiNQJfeg5uIxxgLjXBTjEP+3G1488RoXRHcsdgZQoZl3kmRUjwmgOaNFlSbK2M3KRtDjFs/TyWmUKT5bQHongVSNUiiUppRr7HujOu516DQnmdoyFcN+N1BUlzdTr38Cm6hvvf8H26YPtcM0oiJ8SF7FAAecMvqMvFz+NdTF6MYykJ4fvIt7lAtyaYMGwHCgW/ZdAW3B57wf11b/ynP/c4fL57QGks1fFi/dNs2L7fahgnMtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ppe/pMv7tZC19LMOu9qi2yOdwjpR/p+vZJGY5kT50N0=;
 b=bYNEqiYZIarW0ZUJwXVlHNGI4L+tPJDqC7qO/7+0RWt33p6RA+0/HflrCIsOf4ChlwBe3jcNYM4PgblT8onXSIeXFggb4OVwKlu38rKNQTLlOcFw5yYrT2wGuyMN5baO6jjsBeQtgkuZV0C5TO5lOVDJ5Uql4Ly2rlJUzyzKalw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4952.namprd11.prod.outlook.com (2603:10b6:510:40::15)
 by SA2PR11MB5162.namprd11.prod.outlook.com (2603:10b6:806:114::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Thu, 12 Nov
 2026 09:53:09 +0000
Received: from PH0PR11MB4952.namprd11.prod.outlook.com
 ([fe80::28e0:902b:4ee:4086]) by PH0PR11MB4952.namprd11.prod.outlook.com
 ([fe80::28e0:902b:4ee:4086%5]) with mapi id 15.21.0615.008; Thu, 12 Nov 2026
 09:53:09 +0000
Message-ID: <675a6f5a-879f-49c4-a608-d7a82d09d36c@intel.com>
Date: Thu, 12 Nov 2026 10:53:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ASoC: Intel: Remove unused intel-sst.h trace header
To: Temitope obabi <obabitemitope765@gmail.com>
CC: <mhiramat@kernel.org>, <mathieu.desnoyers@efficios.com>,
	<linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<rostedt@goodmis.org>
References: <20261111223102.1310-1-obabitemitope765@gmail.com>
Content-Language: en-US
From: Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <20261111223102.1310-1-obabitemitope765@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIUP296CA0139.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:34a::12) To PH0PR11MB4952.namprd11.prod.outlook.com
 (2603:10b6:510:40::15)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4952:EE_|SA2PR11MB5162:EE_
X-MS-Office365-Filtering-Correlation-Id: afcc24d2-352e-4960-d623-08df40a2c1ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|22082099003|18002099003|6133799003|10067099003|56012099006|5023799004|261028144727099003|261026121527099003|261102123227099003|11063799006|261009223027099003|261026140227099003|261021121427099003|261022105027099003;
X-Microsoft-Antispam-Message-Info: peq+BsVV8firCV5uinfaoAiHhYYoQK5cWerdehtOr87jnFmkpQdiIQO/qoKCf+cX/918kCOyQau3KyPyNKIgKT2JNh6q6Gp4vR9PQVyD5SsoH3eXSpiMuiEF4oi21l52o6uNPZo+jxurYDI4LFl6SDZvUpVWFs2ex4G+iWzhxds2kkdU32kRkhrvt20+JEYhZZ6gZDHyJUret/AVDmiqpQm1E00wU6JDcKUboSpSMebMNZpqY3hV08ALYohUgX/YBXCkI7CddHIrTGwMeRJR7fUAW/hntGSXqZXdPEJfxH0TdzafjvCpo5hCtoFRf44jBEELDZ2/27Qb2URlR0Afa2rNQyqa1DGiz3iYBck6ouodZcYg+qAlUMn587DZPvRKxmhlBy0KIT2r6hlIF0lbX2W/Xg4C2liUsS+hYyNK6Yj4v2WcZa9twsPHHz59SArmYmHCLfiS7QrDc7GCRZzS0Szl5XIm3QMEsi6Ctq260Dp3Liyp4G5S6gOXuB7UtIvks/WRKExboXJzYYORdeCPPhf96+zLS23YVD40rqUjTfrtniIEFtk+nG+sPQoEe9Ru78fRa2gDQawONO5qJ/b+nerZbYewAVHPhRWyEHovJJF2z7cwzysdHfJronpFD5i0QznU/4lAh8jkdWBsFCMgETdB7lAJk2TCZPY0TZsjYxs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4952.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(22082099003)(18002099003)(6133799003)(10067099003)(56012099006)(5023799004)(261028144727099003)(261026121527099003)(261102123227099003)(11063799006)(261009223027099003)(261026140227099003)(261021121427099003)(261022105027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2J5U3hubjhqa2Y5S0F2S0EvdWFkT1ZpVTVMY0E5VkJDVEU4eGNGTzFDZ1Jl?=
 =?utf-8?B?YkFXTFZYQlNza29iTGdsa1dPSzIvdXg5dWZKNFhGdzM5dVNMVk96WkNZSXJQ?=
 =?utf-8?B?QTNZSEtFQXdUUThQbEdDZlNnUlpqUytZWlZXdHBsc2UzYmQweWZzeTFzVEM1?=
 =?utf-8?B?RXdLSWJCVnk5b1djR2pOQkNrRnVJb3h4V2JyaHZ5QTJ6YkFndkJwaHRnK0FX?=
 =?utf-8?B?WHVJVStrS3dOMytYbEU5SkNtWCsvRTZHSnV0U3R1bnIrVjF0N0V5MEZPaC9p?=
 =?utf-8?B?Umk4cVU0blZHM01zMkRORGFnNHBqSlhWVyt5QVprRDJkcWVmNmVzU1BDUTZl?=
 =?utf-8?B?UTl6S1NKK2crd3padjdxOEg4NkhZTWNFc2tLbmVDZWlrNkRqcWI5dWVtMk1N?=
 =?utf-8?B?S1llVXdEV050c0s3bVFKTG9GYmFHS1VLVktySThnMm1BMC9nelo2V3RNcFdC?=
 =?utf-8?B?NTRVdFVIN1BlZTJsQVdocTFZNlJJaXdFUURudm5SZUJ2OHRWTlNBSTBtQS9B?=
 =?utf-8?B?WnhWTTZxZ0t2c3ZTUnZ2NTFUNGtHL0NzeUZ0a2VEZkx4eENGL29HaEtRWnlv?=
 =?utf-8?B?dWlJdnBtLzRlYzlBKzVXLzJxa2JycEI5MzNFei9qZGV6S1VJZlN5UmxpdTEx?=
 =?utf-8?B?bjg5OWdhSUZISWkyeUVPaTduYkNCN29uUm9YQ2lKN1NHRTYvVDAvS09MNGF3?=
 =?utf-8?B?TUdNZXJCdzdMU0VPREpKL2V4N3JkdG42MzFHcGFJekdVT1k5UVhxMXNNRlQ5?=
 =?utf-8?B?eU93NE42QklYaGlyYkdmUElGeVJpWjhLWmV5cVJuOFZTandTVTYxdE5Vam03?=
 =?utf-8?B?VThzNjh5emhlOG5ocDY2TUQ3a2h2NTdvZFZIbUFEMUNuTGJlNm43YUhBZDhC?=
 =?utf-8?B?WjhnS2lMdS80d1FyaW9pcDZkb3V3YUU2Ky83ejB5UkdUSmxWY2dsbDE4VFND?=
 =?utf-8?B?eHcxdjZsMFFLZU1yNTNFYTRMRkRHQ1NvOWRvakxMNjh0T3NmQXY2cjdMN2ZZ?=
 =?utf-8?B?ZWVINzB0blFUbFZQWXpPNTJkWWRlOHR5WEhnUy9mY1Vjd25hU01TL3pXNjNY?=
 =?utf-8?B?aU9OSGFsNjJBaWhHdGE0WDRPaGZyWU5zeUpjc0VqZms2VkZBVkI1aDh2VFdx?=
 =?utf-8?B?VkpBZUQxNmJ4eHhaNjhUSmJXNVBXOGFmLzUwRnNYcnVrazArazlkdThUcVpG?=
 =?utf-8?B?NG9MeDV1d040VlhCUFRKUGtvaCtNRjRCNjlzTkRpbFZHQi9kNTJqMDJjcnNG?=
 =?utf-8?B?WUh4WDFNMzdXNFVxdmo0SDJIUlZOUTczOXZKVG4vbFg2TS9rMTFUaTh1Z3kv?=
 =?utf-8?B?YVZQZ3M1Vy9uYXlPT3VMRG9yc1J2ZFd6TENHKytQZC8rN3Z1Uno0eGkyTUpk?=
 =?utf-8?B?T1lSQ0VQa09tcTk2TDRPSmZ5QXN4ZHBPNCswbjR3eWkzeEhhY0ZaOHZkTW9N?=
 =?utf-8?B?b0M2WVRsZW9kd2JMc09ja29EMmZubjJFZm1zRzF3Z3kwS0pHUldyTTRuTFhz?=
 =?utf-8?B?NVM5RGFtSURnbkdmT1lEeWhreGJWNjF2clp6QVB5VUY3RjdOTEkrWTc2bjVk?=
 =?utf-8?B?SDlQbHYxSk5uM0p2T1EyZmRlejExcWRCRjhVRnNRcHliTnNwSkVDWDVvYkNs?=
 =?utf-8?B?bFd6QTVSN2N2ZTJLRjRZMHlLdllzWEFGUjFkSmM3dmU3MlVLOGM2dXNUWmNh?=
 =?utf-8?B?cTJkbmZZUXpwU2xVM2ZCeTRITFdhckJJUndLenJ3YlYvbFpoVzRqaGp0R2cw?=
 =?utf-8?B?bXFKcXpDVU85MnVDejNHTWVXMGltZU0vSlBNdjZvajJ0b09ZRU5ZQmhYWE9o?=
 =?utf-8?B?MlZiOHh1VWJhWlByV3VyWWJBZnJCODVVZDFMSnJkT0Q0ZUFQejhRR2ZyVDl6?=
 =?utf-8?B?bDE4akhMWnhDaU5YRzVicFM1dDNHSnpjVzI4TU9mMTlpZVNiaXg3bzFkSjh6?=
 =?utf-8?B?dGNSbzZXWnphaVJyZmV1WjZxdHNyV1BjbEVtdVJHWWlZeUNBaVlST0h1RXo3?=
 =?utf-8?B?d0RObXhWT0kxN3pvNnp3MXQwb1FvcXhJN1VITHdxeVFWRVhvRk1oajhZTkZM?=
 =?utf-8?B?YVp6eVFvV25OR0lzZFdpcW5XQVZwdEhRbjhDWXhkZGJ5am82TC9mWER5eSsy?=
 =?utf-8?B?YkVMTmF4Wm1nVThBR2dzS0NlN2JEUi92dmRIQ1QwdU1lNUI5dDdqNElZRE1O?=
 =?utf-8?B?ZkNzRFdjUFZTNFBKQW5kTnErRU41UW5VNXQ3bFVIOWNGeENmL3o0a0xvSCtO?=
 =?utf-8?B?bnpCaHRpVFBkQ08rdUc1cTMrSjd2eXB1Z1ZHRXE3ejF5MGZCYk85bC9CNWpC?=
 =?utf-8?B?VHlITmRGSzZEbEd0TU02NDF6ZmFRNjVWaTZIU3NYWkkxR0lMS0c5UT09?=
X-Exchange-RoutingPolicyChecked: gS3z4g8x+n/S3dC9zqSwbmuBoAM8s12qdLlVkDMjUrexNySLuGK/IMZoCNZG/jIX5+TmmGASmCo5rqMg44Ah69r6ieDeM8TEK8a0089dKNMVgdqJmPo9y4SSx5ibt74DbJf26M3s4Sw57uxu5yFJDtrJ7dISvtJhgLr6FAMfv+7osefrGdPuauI/ytj3VM2BaLimB15jYRUcVA0WP51OuIN9DY6qOuTQ2H7NqNtMbZq9/AsoO/GNqdREY9sw68fwKOilxeZ3IWGXj9nqEJTVyzSYdgXClxeILUoB9uvlghhTrqeszuN1Q5Kv5qIsS2lYbUBB4ZkZUTogTYMx+tl1VQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: afcc24d2-352e-4960-d623-08df40a2c1ea
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4952.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 09:53:09.4710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XbLX9CYo133AdKLrjpKppwIw8GXRFKS+XfP5jXrbu1/0EgEMu5QCsj0T8+IxrOKnmrlaKGX9Ip7PJLM9VkBMc2eH6Cv2u72JkZILRY9E/QY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5162
X-OriginatorOrg: intel.com

On 11/11/2026 11:31 PM, Temitope obabi wrote:
> Commit 970d299b0a0a ("ASoC: Intel: Remove unused code") removed
> sound/soc/intel/common/sst-dsp.c, the only file that defined
> CREATE_TRACE_POINTS and included trace/events/intel-sst.h.
> 
> Nothing includes this header anymore, so none of its tracepoints are
> built. Remove the unused header.
> 
> Signed-off-by: Temitope obabi <obabitemitope765@gmail.com>
> ---
> Changes in v2:
> - Remove the whole header instead of only sst_ipc_inbox_rdata, since
>   nothing includes it (reported by the Sashiko review of v1).
> - Drop the Fixes tag and the claim about memory used per tracepoint.
> - This also replaces the earlier sst_ipc_msg_tx patch for the same header.
Next time, please CC sound/soc/intel maintainers. The very commit starts
with "ASoC: Intel:".

Nitpick: if trace-subsystem maintainers permit ASoC-scoping for
include/trace, please update the title to: "ASoC: Intel: atom:" to
highlight which driver it does relate to.

The nitpick alone is not a reason for re-send.

Acked-by: Cezary Rojewski <cezary.rojewski@intel.com>
