Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACBE15573F;
	Tue, 31 Dec 2024 06:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735627329; cv=fail; b=hvEmDlhj0MSBF4v1wsuzfqPNCyW4IOIhBuD3YV4a8dtpXA1Jj2fRIb1X6gSI82feMAYk8Do8n1N9ZbBN1w+9QRF1NCY9fppo5kk2nRhqEAo0k8Bd7PB8HzBF7MquRBvFiMXppTT5kjRdMjlBMjBOyi64Gy77ru8TnqPcAR+NcbQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735627329; c=relaxed/simple;
	bh=ugZcSUzt2UKdjSHQmRbtMXLyVnmYKiSJet4HTjcf/6A=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=FxtAD/A1ZUdEm5XgaCJfHa4Kz9lgYGfNFgbbyjzV5DCvW1/AqwZDx7EppFqgp+XVa9zVi+b72mNh4h9c21IBXdJth1A3cb6BGnZU3XJSW8HzD66Gm8B3rGapX1B6m/sGjTTtEYAcomgq04I0TW3OPqNQFWpvKDt+rc77xgH1nJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jNAS0tpf; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jNAS0tpf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735627324; x=1767163324;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=ugZcSUzt2UKdjSHQmRbtMXLyVnmYKiSJet4HTjcf/6A=;
  b=jNAS0tpfwBlW7rEhwJVEBKcFSYiZv3TfaHuYpzCZwcd3rLcORNs+YLGl
   ZmM08ktuLs0oCwljF1UsMXp4VxP1tr1fiHzzezENTAFuDrI17kwFloc96
   XsLyADL3FzyEkHqkWQkNsbNQTUbtLnzFNYTirHBKKeE8w2+VDn4rbef0T
   T/M2hzPZlsqFEXzgY9NdZHOxdRxTlR8kd3yEZs6zSwV2xzO36xD6vc4rr
   cyhikIjCe8j5pWokMq0q0Vpdxy6i81SSvged0cnsyjO5JOTRbuHBrRa/Q
   MYwFfIaYNcAlChz+Yd+nnEBg1jBpYVaRpIOms9TOtaAo+tcbvg0q+MufQ
   A==;
X-CSE-ConnectionGUID: otrfStrBTKq8pm4Wx7QEGw==
X-CSE-MsgGUID: Z7/odwz0SDOHpDih0W94ig==
X-IronPort-AV: E=McAfee;i="6700,10204,11301"; a="35218087"
X-IronPort-AV: E=Sophos;i="6.12,278,1728975600"; 
   d="scan'208";a="35218087"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2024 22:42:01 -0800
X-CSE-ConnectionGUID: xF6K7ZEIRFWfoEKm6FjuTA==
X-CSE-MsgGUID: co8lV+svS5eJENBgNlvTVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,278,1728975600"; 
   d="scan'208";a="100813662"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Dec 2024 22:42:02 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 30 Dec 2024 22:42:01 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 30 Dec 2024 22:42:01 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 30 Dec 2024 22:42:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j2Kr5HDGPHSeoWGIuxzUtwNOynPw+g1yeEdayOY7Ux3vqmWMOaMqyt0Fw/Eatt4bqE1/zeTjAeVSfnklKdyHED2bEwKVut9GiSpJ3CicPP7dEhmUdGa0g/CWh53YiA7+Q4Q2HEZd0qsybDDHU6fJaYkFJwscs7OYvNmg3RzWlAPclX3ccGopmWnZDJRDTE2yja+NwIvK1MDbZvCf9icXbSJWEGiDeszbX54CQJHkTZQVrbh3KmUkgY0F+S67HECv+WKHrsx1Se2BsuxUeyrbiSXAt3P6I+R5CA8i8a+qU5nTWGj1oxk8jWMkNNbzFuFK/9bDyZTQaN1MWpoiSKb+ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F4FJaVi6QBPNLnpODr7SngjYLnCW3mxi4ct8aZVkU9w=;
 b=YBLcuW367Nf426hhNWTDJofH1YWu4Uxw3GIP/6ByuZrxthbKDEMV6il/84JRe4se2e3OH8ZTLzdd/1eMajmc0gIYVhiGW25SMds98JRnS4GSwdHsKVS/HtXbuphyp+VPOzoezJthlo5rWn8+tz2uddJoyu4C+yW5dqExl5wQY/jcQBMpHIM3yuxssi4KfNknhtLlhcbPzlC5bRGJdoVfqEx9fdHYvvxoO+dO9tvkfvIaL2aagnPtu47iB1nDRUpymt+f+G4xrsmw2yhtQSaIlsXkv93hBPg/1KTl1HP43g8KWuf9KYYP5c8OpTN/JEOM4LvkEUZSrYIPDz8IF99HxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SJ1PR11MB6203.namprd11.prod.outlook.com (2603:10b6:a03:45a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.19; Tue, 31 Dec
 2024 06:41:26 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%6]) with mapi id 15.20.8293.000; Tue, 31 Dec 2024
 06:41:26 +0000
Date: Tue, 31 Dec 2024 14:41:10 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Steven Rostedt
	<rostedt@goodmis.org>, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Huacai Chen
	<chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, Michael Ellerman
	<mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy
	<christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>, "Madhavan
 Srinivasan" <maddy@linux.ibm.com>, Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
	<agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, "Mathieu
 Desnoyers" <mathieu.desnoyers@efficios.com>, Andrew Morton
	<akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [mhiramat:topic/fprobe-on-fgraph] [fprobe]  fd62ee1f3e:
 netperf.Throughput_tps 10.6% regression
Message-ID: <202412311403.3d8f903d-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0089.apcprd02.prod.outlook.com
 (2603:1096:4:90::29) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SJ1PR11MB6203:EE_
X-MS-Office365-Filtering-Correlation-Id: 2091c8b3-a768-43a9-e935-08dd29662644
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?vJJnuatgt9DhbxO6lkgaKf7Nsec/+6RtswVzwElvRbCXrbMDX+BGE8yAJy?=
 =?iso-8859-1?Q?r6DCxPhv6piSt9HOQiQXj7DmyPt47+HO/zSx1XZh6KbirUotSrGWVn9mTY?=
 =?iso-8859-1?Q?o/B/saOXA4tkzrmhdv7PX6HiQK192K/H3qk5ZImLz/AbfbEMqR+uN4rUoo?=
 =?iso-8859-1?Q?l0X7bOKP/34IAHGJQ2y1iPlcm/EN20Z+NaVQgb2bOatMVEQ49PhZ5uOMUK?=
 =?iso-8859-1?Q?BB3t0rtKsbgOtVcNQNVHDvtaAIAGAaKh5buz1odYW+PsTWoc0XSJAb0p6A?=
 =?iso-8859-1?Q?hvj00ejTHH5g+U0OJBqLhT2h1kI7yXLkCK7jePvktLZB6cjS1Do9dY3B7f?=
 =?iso-8859-1?Q?HokRGtZc/pCoZit13ZTS7T/SYor9NyOvuz+TDaALLsZqsmEjNJBAhofP0T?=
 =?iso-8859-1?Q?iGA3mJdXUAIYY7SWwJrFni4gW8gWfjD+RfY45qC8zGA1yoAZcMCrEn7TYN?=
 =?iso-8859-1?Q?usLUPZz+U/tsACtPutMonkTgycoL39mv+ZXPlwrcSyyX3WjautKIplWV+d?=
 =?iso-8859-1?Q?slO7ly4C8Qpnz6TU9jRokz1Ud0yOOY3zHSR5KyZbt5YAowC6rYHRxpUuKc?=
 =?iso-8859-1?Q?on3+lEmQ94zhRy+Lch2mX0shVubiKJ4Y7ilssWlpe6VGjBgweQVOqNxzh5?=
 =?iso-8859-1?Q?u8thW5JGT4GYFg3/WCVmqYkyHF7KXfal6mxKKGSuWfPs9BLn9oUwq9XJxD?=
 =?iso-8859-1?Q?pi37ieggrqn9/S9TBvbFUJGpVukn4OGPOHsgfbvrgCb2RTFZ+MFJmthgT9?=
 =?iso-8859-1?Q?VeGeNoJIRS+DO56uX/Ek/VgtTT78AIM78rQVkPoiT7yXWMBIdjmBYMqANg?=
 =?iso-8859-1?Q?vcWPCVLoIRtEkGikVSsgDV1mLpUCMw0qhIcGQLZ1mNx5A3Uj0OEDNBRnoh?=
 =?iso-8859-1?Q?soUHJkU3g3T5OtVF2TnhkrStz4ZvXzp69MPfOd8v+F5y4NhzXSEXzssuHW?=
 =?iso-8859-1?Q?IQFugcHE89LKPOcLp0auzefIuB8gBmzlsLteWs7MZ86M/GQSy19F+tImgE?=
 =?iso-8859-1?Q?zfJNe3PClZQCLxhzLGmiqRUH9Ps0nSlHNBlgVO7q1/cFN27VkHqGwR4P2D?=
 =?iso-8859-1?Q?sCTetkqV70Gsi//kgWsxhe8/ZaOsvgJQNkD3kkZkUGQFFA9YmZRcBcY+Q1?=
 =?iso-8859-1?Q?Zn14qPJVk4Dwo+QFcN5yyjs0c/rVfHqi/lbuNJJ6viqOpA86o9OKkARNjV?=
 =?iso-8859-1?Q?ATf62JQK4McE/DjuP6lzdZpOBYNFAgsrojE5htQGjPXh/gjeJvhNAbj8zH?=
 =?iso-8859-1?Q?DShkS2XsSSzHAaQJAweVQ6q9hGAaJNN9m3Ar1mRlNA4wPQ6xTS7Wpmsr6i?=
 =?iso-8859-1?Q?33GUZSptAKR8RlHjaATa+mQTiP2cYP+/z8ADO5rJYS8ifrSBFbAr4VGiad?=
 =?iso-8859-1?Q?QyRoCzCvwvPqLoVDDGO6QbmWDS3LqPqw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?m0Gm4dXgKBfZzN1y7HZOEuoet+c1U91Agax8wPwUwWclPp8TZ9S+piG42Q?=
 =?iso-8859-1?Q?mo8nq7lrq6VF8IzBfEdvIvezKn6NBi9EuLhzmJlQHMquibuQw7fTmUEdyC?=
 =?iso-8859-1?Q?y0QRmFmYX3hcpom5JXBZsdsD46eBiM08UmQLaFqVpNfnRlKfDgjBr4SrzD?=
 =?iso-8859-1?Q?BfX9QJ7Yp6yRRPioqEGVXzXn1xRPzTwvqFhXLUAP0QYQCWdke4VV7cYe14?=
 =?iso-8859-1?Q?sJvjEpt05nfEOtDRicVLvD0HEVgkLMt2Hc9iVuMrTCa4IqpqsohZ+WUpJH?=
 =?iso-8859-1?Q?nT+JWD5nB2LtSm6P3lf3faViS5qaDW4krLCk0NLJsrh/7gXkbI3p7j6fX6?=
 =?iso-8859-1?Q?S/t/N2EWuJi19+CHtoxgoGuJ5+Ged5T+wN9uMWZOLeRrV2bnffLdqTdPm2?=
 =?iso-8859-1?Q?DrNWZ+t/nDxpzzeIJtb+pWrSZRxgXr92F8ONFuYQXIx0tqoUQ/4AgZjhmI?=
 =?iso-8859-1?Q?42FMIL8dTedx5KjEJQeWKwH2+8/gV5kTbNbOimesK4D73+Pcimy3DV9dnz?=
 =?iso-8859-1?Q?kzzRx/+cLYO7ilA3NnAfhnnZy23lS93drh3ZYKp6euI2M0knjA4yGtVdyj?=
 =?iso-8859-1?Q?YoEQRN/1V55SNRuSEoXg6917ofJRD9k2ONyyjskx3Z1HedoJBJa1LKz/zy?=
 =?iso-8859-1?Q?WjjtlkLhn9H2l3cHmes3YtMTBHF1quuci3C/nuM+CfdHRDO0mGp3N2NEbZ?=
 =?iso-8859-1?Q?VtJph7s3sD62kZc6Ij17EuTvMmr5ifflmBpOMltBAHTrjXdiRvHhgJRrNd?=
 =?iso-8859-1?Q?903539cW5ZTWwo07Tad5BBcw+S6OxDf70LXe3/dPJY0DIRcB7qeGE53XSk?=
 =?iso-8859-1?Q?GLaLNVYAT/pL8cKtwCTsdfjhpUgDKaKl5Ji10uuASk/c4E90H2QVHcziNs?=
 =?iso-8859-1?Q?pirsW7MLDAp6sTpSqnZGStm745BBRjXA2vOis9nZ/V8yMH9s/PG1lRqfFO?=
 =?iso-8859-1?Q?qmAjGFX6V5x72jLbyPkTF9YYd8CTk6/TZX/GPbPOBHXnXwnbzQSjJKsVNv?=
 =?iso-8859-1?Q?jSrVNkiePzMl7ibhj8qdX2fvn2jBj7wMgyViZmTtrowweZTsp3JLP+EAKw?=
 =?iso-8859-1?Q?4OPx3TWV8YbbWM6PmLWQyljyJFsF1OKwxFrjShbFC8i1bHHZ+Inl4QOGeg?=
 =?iso-8859-1?Q?ptGJROG3zdap4TxTN4R33772mU14JntdVyGbdamyHF221DwvbgHlfXhq+r?=
 =?iso-8859-1?Q?tbG1lznkgP6a5Eybfr1bBbHqyMFFEARTbptIqI58ikWWXYkr/bE412f78Z?=
 =?iso-8859-1?Q?4zNDDzmq0F+H0nJqpOuJkVn+ijdQdNo0Hg0c3FOsuWYEC460n9GLc0Wxg8?=
 =?iso-8859-1?Q?BGoeA2yftDpCivp9T6o83naG9kdIPxxcO4NY27GGEwSVC/vmGUHXScRbDt?=
 =?iso-8859-1?Q?zxxYeR51Ws8sCdFjGMNVENl2KwZs83QdgD00huONDQjqhUs4e+WqN5+A3G?=
 =?iso-8859-1?Q?w3iqux4JLvW1gImIOUw4jfopSKCqj97+xpjcVG3Veumln/TdUfk0AxOYtU?=
 =?iso-8859-1?Q?X8z7nCcTJHyBz9X75Wr6zVCRd8lVSs6jJFLdJmsYXSPBwOqYzzypZwKKuw?=
 =?iso-8859-1?Q?D0sGJkcZ3ccP6jGwTS5e1fQ22KWbaA9Ugv7b/oE0qMw6mQr+Cgn7TfSPl6?=
 =?iso-8859-1?Q?9T94lMFgrFkfrjuGbS1/E9pmNsUqGztNGPyx0LALPGXyUaxcJJxJ2eFg?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2091c8b3-a768-43a9-e935-08dd29662644
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Dec 2024 06:41:26.7553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2ojoHfi1bs7qystVO4MDg8Qs7S+QLRNLilS5U7Oa/AzjkcDhf+ZWYClo8ou9BcoTEDKPYo7RGfGhGver/UxIdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6203
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 10.6% regression of netperf.Throughput_tps on:


commit: fd62ee1f3e2a2ca3ba5501d504d23bcbe3a8ef9f ("fprobe: Rewrite fprobe on function-graph tracer")
https://git.kernel.org/cgit/linux/kernel/git/mhiramat/linux.git topic/fprobe-on-fgraph

testcase: netperf
config: x86_64-rhel-9.4
compiler: gcc-12
test machine: 128 threads 2 sockets Intel(R) Xeon(R) Gold 6338 CPU @ 2.00GHz (Ice Lake) with 256G memory
parameters:

	ip: ipv4
	runtime: 300s
	nr_threads: 200%
	cluster: cs-localhost
	test: TCP_CRR
	cpufreq_governor: performance




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202412311403.3d8f903d-lkp@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20241231/202412311403.3d8f903d-lkp@intel.com

=========================================================================================
cluster/compiler/cpufreq_governor/ip/kconfig/nr_threads/rootfs/runtime/tbox_group/test/testcase:
  cs-localhost/gcc-12/performance/ipv4/x86_64-rhel-9.4/200%/debian-12-x86_64-20240206.cgz/300s/lkp-icl-2sp2/TCP_CRR/netperf

commit: 
  ddb90baf8d ("s390/tracing: Enable HAVE_FTRACE_GRAPH_FUNC")
  fd62ee1f3e ("fprobe: Rewrite fprobe on function-graph tracer")

ddb90baf8d5ec902 fd62ee1f3e2a2ca3ba5501d504d 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      2.78            -0.4        2.40        mpstat.cpu.all.usr%
   5134970 ±  2%      -8.3%    4708498        vmstat.system.cs
   5051017 ± 11%     -21.1%    3984834 ±  2%  numa-numastat.node1.local_node
   5127037 ± 11%     -20.9%    4056739 ±  2%  numa-numastat.node1.numa_hit
   5126246 ± 11%     -20.9%    4055878 ±  2%  numa-vmstat.node1.numa_hit
   5050225 ± 11%     -21.1%    3983973 ±  2%  numa-vmstat.node1.numa_local
    176.55 ±  9%     -14.6%     150.70 ± 11%  sched_debug.cfs_rq:/.util_avg.stddev
   4909928 ±  3%     -10.9%    4375151 ±  3%  sched_debug.cpu.nr_switches.min
     20483 ±  4%     +11.5%      22837        perf-c2c.DRAM.remote
     24006 ±  5%     +24.5%      29898 ±  3%  perf-c2c.HITM.local
      7086 ±  4%     -12.6%       6196 ±  3%  perf-c2c.HITM.remote
     31093 ±  4%     +16.1%      36094 ±  2%  perf-c2c.HITM.total
    200788 ±  2%      -2.0%     196693        proc-vmstat.nr_anon_pages
   8989290 ± 11%     -19.8%    7208925 ±  6%  proc-vmstat.numa_hit
   8856551 ± 11%     -20.1%    7076299 ±  6%  proc-vmstat.numa_local
   1473356 ±  3%      -3.5%    1421154        proc-vmstat.pgfault
   1944890           -10.6%    1737859        netperf.ThroughputBoth_total_tps
      7597           -10.6%       6788        netperf.ThroughputBoth_tps
   1944890           -10.6%    1737859        netperf.Throughput_total_tps
      7597           -10.6%       6788        netperf.Throughput_tps
    631.27           -14.6%     539.29        netperf.time.user_time
  3.89e+08 ±  4%     -14.5%  3.324e+08 ±  3%  netperf.time.voluntary_context_switches
 5.835e+08           -10.6%  5.214e+08        netperf.workload
      0.21 ± 20%     +34.6%       0.29 ± 19%  perf-sched.sch_delay.avg.ms.__cond_resched.__release_sock.release_sock.__inet_stream_connect.inet_stream_connect
      0.24 ± 10%     +58.3%       0.39 ± 33%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.security_inode_alloc.inode_init_always_gfp.alloc_inode
      3594 ± 23%     +42.9%       5136 ±  8%  perf-sched.total_sch_delay.max.ms
      0.52 ± 19%     +31.8%       0.68 ± 18%  perf-sched.wait_and_delay.avg.ms.__cond_resched.__release_sock.release_sock.__inet_stream_connect.inet_stream_connect
      0.21 ± 39%    +206.7%       0.65 ± 57%  perf-sched.wait_time.avg.ms.__cond_resched.dput.__fput.__x64_sys_close.do_syscall_64
      0.13         +1541.2%       2.06 ±159%  perf-sched.wait_time.avg.ms.__cond_resched.lock_sock_nested.inet_csk_accept.inet_accept.do_accept
      0.29 ± 11%     +53.3%       0.44 ± 16%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_node_noprof.kmalloc_reserve.__alloc_skb.tcp_stream_alloc_skb
      0.42 ± 15%     +53.3%       0.65 ± 39%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc_noprof.security_inode_alloc.inode_init_always_gfp.alloc_inode
      0.51 ±  3%     +54.8%       0.79        perf-stat.i.MPKI
  4.43e+10           -10.1%  3.982e+10        perf-stat.i.branch-instructions
 4.019e+08            -9.3%  3.644e+08        perf-stat.i.branch-misses
     23.97 ±  2%      -1.0       22.95        perf-stat.i.cache-miss-rate%
 1.145e+08 ±  3%     +41.6%  1.622e+08        perf-stat.i.cache-misses
 4.733e+08 ±  2%     +48.3%  7.019e+08        perf-stat.i.cache-references
   5179504 ±  2%      -8.3%    4751159        perf-stat.i.context-switches
      1.37           +11.8%       1.53        perf-stat.i.cpi
      2808 ±  3%     -29.7%       1974        perf-stat.i.cycles-between-cache-misses
  2.33e+11           -10.1%  2.094e+11        perf-stat.i.instructions
      0.73           -10.5%       0.66        perf-stat.i.ipc
     40.48 ±  2%      -8.2%      37.14        perf-stat.i.metric.K/sec
      0.49 ±  3%     +57.5%       0.77        perf-stat.overall.MPKI
     24.21 ±  3%      -1.1       23.11        perf-stat.overall.cache-miss-rate%
      1.37           +12.3%       1.54        perf-stat.overall.cpi
      2787 ±  3%     -28.8%       1984        perf-stat.overall.cycles-between-cache-misses
      0.73           -10.9%       0.65        perf-stat.overall.ipc
 4.416e+10           -10.1%  3.971e+10        perf-stat.ps.branch-instructions
 4.006e+08            -9.3%  3.633e+08        perf-stat.ps.branch-misses
 1.142e+08 ±  3%     +41.6%  1.618e+08        perf-stat.ps.cache-misses
 4.719e+08 ±  2%     +48.3%  6.999e+08        perf-stat.ps.cache-references
   5162307 ±  2%      -8.3%    4736259        perf-stat.ps.context-switches
 2.323e+11           -10.1%  2.088e+11        perf-stat.ps.instructions
 7.155e+13           -10.5%  6.404e+13        perf-stat.total.instructions
     19.32            -2.5       16.85        perf-profile.calltrace.cycles-pp.__close.send_omni_inner.send_tcp_conn_rr.main
     19.02            -2.4       16.61        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__close.send_omni_inner.send_tcp_conn_rr.main
     19.01            -2.4       16.59        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close.send_omni_inner.send_tcp_conn_rr
     18.87            -2.4       16.48        perf-profile.calltrace.cycles-pp.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close.send_omni_inner
     24.64            -1.9       22.78        perf-profile.calltrace.cycles-pp.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
     22.22            -1.7       20.56        perf-profile.calltrace.cycles-pp.__sock_release.sock_close.__fput.__x64_sys_close.do_syscall_64
     22.27            -1.7       20.61        perf-profile.calltrace.cycles-pp.sock_close.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe
     22.04            -1.6       20.39        perf-profile.calltrace.cycles-pp.inet_release.__sock_release.sock_close.__fput.__x64_sys_close
      8.70            -1.2        7.46        perf-profile.calltrace.cycles-pp.omni_create_data_socket.send_omni_inner.send_tcp_conn_rr.main
     20.85            -1.2       19.62        perf-profile.calltrace.cycles-pp.tcp_close.inet_release.__sock_release.sock_close.__fput
     20.53            -1.2       19.36        perf-profile.calltrace.cycles-pp.__tcp_close.tcp_close.inet_release.__sock_release.sock_close
      4.34 ±  2%      -0.8        3.52        perf-profile.calltrace.cycles-pp.recv.send_omni_inner.send_tcp_conn_rr.main
      3.84 ±  2%      -0.7        3.12        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.recv.send_omni_inner.send_tcp_conn_rr.main
      3.81 ±  2%      -0.7        3.10        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.recv.send_omni_inner.send_tcp_conn_rr
      4.28 ±  2%      -0.7        3.57 ±  5%  perf-profile.calltrace.cycles-pp.tcp_data_queue.tcp_rcv_state_process.tcp_v4_do_rcv.tcp_v4_rcv.ip_protocol_deliver_rcu
     12.44            -0.7       11.77        perf-profile.calltrace.cycles-pp.__tcp_transmit_skb.tcp_write_xmit.__tcp_push_pending_frames.__tcp_close.tcp_close
      5.03            -0.7        4.37        perf-profile.calltrace.cycles-pp.__sys_recvfrom.__x64_sys_recvfrom.do_syscall_64.entry_SYSCALL_64_after_hwframe.recv
      4.07 ±  2%      -0.7        3.42 ±  5%  perf-profile.calltrace.cycles-pp.tcp_fin.tcp_data_queue.tcp_rcv_state_process.tcp_v4_do_rcv.tcp_v4_rcv
      4.24 ±  2%      -0.6        3.60        perf-profile.calltrace.cycles-pp.__socket.omni_create_data_socket.send_omni_inner.send_tcp_conn_rr.main
      3.33 ±  2%      -0.6        2.70        perf-profile.calltrace.cycles-pp.__x64_sys_recvfrom.do_syscall_64.entry_SYSCALL_64_after_hwframe.recv.send_omni_inner
     11.80            -0.6       11.18        perf-profile.calltrace.cycles-pp.__ip_queue_xmit.__tcp_transmit_skb.tcp_write_xmit.__tcp_push_pending_frames.__tcp_close
      4.66            -0.6        4.05        perf-profile.calltrace.cycles-pp.sock_recvmsg.__sys_recvfrom.__x64_sys_recvfrom.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.85            -0.6        1.24 ± 19%  perf-profile.calltrace.cycles-pp.schedule.schedule_timeout.wait_woken.sk_wait_data.tcp_recvmsg_locked
      4.58            -0.6        3.97        perf-profile.calltrace.cycles-pp.inet_recvmsg.sock_recvmsg.__sys_recvfrom.__x64_sys_recvfrom.do_syscall_64
      4.45            -0.6        3.85        perf-profile.calltrace.cycles-pp.tcp_recvmsg.inet_recvmsg.sock_recvmsg.__sys_recvfrom.__x64_sys_recvfrom
      3.98 ±  2%      -0.6        3.38        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__socket.omni_create_data_socket.send_omni_inner.send_tcp_conn_rr
      3.97 ±  2%      -0.6        3.38        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__socket.omni_create_data_socket.send_omni_inner
      3.87 ±  2%      -0.6        3.29        perf-profile.calltrace.cycles-pp.__x64_sys_socket.do_syscall_64.entry_SYSCALL_64_after_hwframe.__socket.omni_create_data_socket
      3.83 ±  2%      -0.6        3.26        perf-profile.calltrace.cycles-pp.__sys_socket.__x64_sys_socket.do_syscall_64.entry_SYSCALL_64_after_hwframe.__socket
      4.11            -0.6        3.54        perf-profile.calltrace.cycles-pp.tcp_recvmsg_locked.tcp_recvmsg.inet_recvmsg.sock_recvmsg.__sys_recvfrom
      4.30            -0.6        3.74 ±  3%  perf-profile.calltrace.cycles-pp.__release_sock.__tcp_close.tcp_close.inet_release.__sock_release
      4.22 ±  2%      -0.5        3.69 ±  3%  perf-profile.calltrace.cycles-pp.tcp_v4_do_rcv.__release_sock.__tcp_close.tcp_close.inet_release
      4.20 ±  2%      -0.5        3.68 ±  3%  perf-profile.calltrace.cycles-pp.tcp_rcv_state_process.tcp_v4_do_rcv.__release_sock.__tcp_close.tcp_close
      1.70 ± 11%      -0.5        1.20 ± 19%  perf-profile.calltrace.cycles-pp.__schedule.schedule.schedule_timeout.wait_woken.sk_wait_data
      0.84 ±  4%      -0.5        0.36 ± 70%  perf-profile.calltrace.cycles-pp._raw_spin_lock_bh.inet_unhash.tcp_set_state.tcp_done.tcp_rcv_state_process
      1.92            -0.5        1.45 ± 15%  perf-profile.calltrace.cycles-pp.schedule_timeout.wait_woken.sk_wait_data.tcp_recvmsg_locked.tcp_recvmsg
     19.19            -0.5       18.72        perf-profile.calltrace.cycles-pp.ip_finish_output2.__ip_queue_xmit.__tcp_transmit_skb.tcp_write_xmit.__tcp_push_pending_frames
      0.80 ±  5%      -0.4        0.35 ± 70%  perf-profile.calltrace.cycles-pp.inet_unhash.tcp_set_state.tcp_done.tcp_fin.tcp_data_queue
     18.96            -0.4       18.55        perf-profile.calltrace.cycles-pp.__dev_queue_xmit.ip_finish_output2.__ip_queue_xmit.__tcp_transmit_skb.tcp_write_xmit
      1.24 ±  3%      -0.4        0.83        perf-profile.calltrace.cycles-pp.sk_alloc.inet_create.__sock_create.__sys_socket.__x64_sys_socket
      2.01            -0.4        1.60 ± 11%  perf-profile.calltrace.cycles-pp.wait_woken.sk_wait_data.tcp_recvmsg_locked.tcp_recvmsg.inet_recvmsg
      1.27 ±  2%      -0.4        0.86 ±  4%  perf-profile.calltrace.cycles-pp.tcp_done.tcp_fin.tcp_data_queue.tcp_rcv_state_process.tcp_v4_do_rcv
      1.40 ±  2%      -0.4        1.00        perf-profile.calltrace.cycles-pp.tcp_create_openreq_child.tcp_v4_syn_recv_sock.tcp_check_req.tcp_v4_rcv.ip_protocol_deliver_rcu
      1.06 ±  2%      -0.4        0.68 ±  4%  perf-profile.calltrace.cycles-pp.tcp_done.tcp_rcv_state_process.tcp_v4_do_rcv.__release_sock.__tcp_close
      2.78 ±  2%      -0.4        2.40        perf-profile.calltrace.cycles-pp.__sock_create.__sys_socket.__x64_sys_socket.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.99 ±  2%      -0.4        0.62        perf-profile.calltrace.cycles-pp.__sk_destruct.inet_release.__sock_release.sock_close.__fput
      2.28            -0.4        1.92        perf-profile.calltrace.cycles-pp.sk_wait_data.tcp_recvmsg_locked.tcp_recvmsg.inet_recvmsg.sock_recvmsg
      1.11 ±  3%      -0.4        0.74 ±  4%  perf-profile.calltrace.cycles-pp.tcp_set_state.tcp_done.tcp_fin.tcp_data_queue.tcp_rcv_state_process
      5.66 ±  2%      -0.4        5.30        perf-profile.calltrace.cycles-pp.__x64_sys_accept.do_syscall_64.entry_SYSCALL_64_after_hwframe.accept.process_requests
      5.62 ±  2%      -0.3        5.27        perf-profile.calltrace.cycles-pp.__sys_accept4.__x64_sys_accept.do_syscall_64.entry_SYSCALL_64_after_hwframe.accept
      1.10 ±  3%      -0.3        0.76        perf-profile.calltrace.cycles-pp.inet_csk_clone_lock.tcp_create_openreq_child.tcp_v4_syn_recv_sock.tcp_check_req.tcp_v4_rcv
      6.44 ±  2%      -0.3        6.09        perf-profile.calltrace.cycles-pp.accept.process_requests.spawn_child.accept_connection.accept_connections
      6.15 ±  2%      -0.3        5.81        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.accept.process_requests.spawn_child
      6.16 ±  2%      -0.3        5.82        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.accept.process_requests.spawn_child.accept_connection
      0.91 ±  3%      -0.3        0.57 ±  4%  perf-profile.calltrace.cycles-pp.tcp_set_state.tcp_done.tcp_rcv_state_process.tcp_v4_do_rcv.__release_sock
      5.42 ±  2%      -0.3        5.09        perf-profile.calltrace.cycles-pp.do_accept.__sys_accept4.__x64_sys_accept.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.02 ±  3%      -0.3        0.69        perf-profile.calltrace.cycles-pp.sk_clone_lock.inet_csk_clone_lock.tcp_create_openreq_child.tcp_v4_syn_recv_sock.tcp_check_req
      0.88 ±  4%      -0.3        0.56 ±  3%  perf-profile.calltrace.cycles-pp.inet_unhash.tcp_set_state.tcp_done.tcp_rcv_state_process.tcp_v4_do_rcv
      0.54 ±  2%      -0.3        0.25 ±100%  perf-profile.calltrace.cycles-pp.recv
      1.44            -0.3        1.16        perf-profile.calltrace.cycles-pp.create_data_socket.omni_create_data_socket.send_omni_inner.send_tcp_conn_rr.main
      2.02 ±  4%      -0.3        1.74 ±  4%  perf-profile.calltrace.cycles-pp.sock_def_readable.tcp_child_process.tcp_v4_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish
      1.91 ±  4%      -0.3        1.64 ±  4%  perf-profile.calltrace.cycles-pp.autoremove_wake_function.__wake_up_common.__wake_up_sync_key.sock_def_readable.tcp_child_process
      1.97 ±  4%      -0.3        1.70 ±  4%  perf-profile.calltrace.cycles-pp.__wake_up_sync_key.sock_def_readable.tcp_child_process.tcp_v4_rcv.ip_protocol_deliver_rcu
      1.93 ±  4%      -0.3        1.66 ±  4%  perf-profile.calltrace.cycles-pp.__wake_up_common.__wake_up_sync_key.sock_def_readable.tcp_child_process.tcp_v4_rcv
      1.47            -0.3        1.20        perf-profile.calltrace.cycles-pp.inet_csk_get_port.__inet_bind.inet_bind_sk.__sys_bind.__x64_sys_bind
      1.86 ±  4%      -0.3        1.60 ±  4%  perf-profile.calltrace.cycles-pp.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_sync_key.sock_def_readable
      1.30            -0.3        1.04        perf-profile.calltrace.cycles-pp.set_sock_buffer.create_data_socket.omni_create_data_socket.send_omni_inner.send_tcp_conn_rr
      1.20            -0.2        0.95        perf-profile.calltrace.cycles-pp.getsockopt.set_sock_buffer.create_data_socket.omni_create_data_socket.send_omni_inner
      3.30 ±  2%      -0.2        3.10        perf-profile.calltrace.cycles-pp.inet_accept.do_accept.__sys_accept4.__x64_sys_accept.do_syscall_64
      3.02 ±  2%      -0.2        2.84        perf-profile.calltrace.cycles-pp.inet_csk_accept.inet_accept.do_accept.__sys_accept4.__x64_sys_accept
      1.95 ±  3%      -0.2        1.76        perf-profile.calltrace.cycles-pp.schedule.schedule_timeout.inet_csk_accept.inet_accept.do_accept
      2.00 ±  3%      -0.2        1.82        perf-profile.calltrace.cycles-pp.schedule_timeout.inet_csk_accept.inet_accept.do_accept.__sys_accept4
      1.82 ±  2%      -0.2        1.64        perf-profile.calltrace.cycles-pp.inet_create.__sock_create.__sys_socket.__x64_sys_socket.do_syscall_64
      1.90 ±  3%      -0.2        1.72        perf-profile.calltrace.cycles-pp.__schedule.schedule.schedule_timeout.inet_csk_accept.inet_accept
      2.24            -0.2        2.07        perf-profile.calltrace.cycles-pp.bind.omni_create_data_socket.send_omni_inner.send_tcp_conn_rr.main
      0.83            -0.2        0.66        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.getsockopt.set_sock_buffer.create_data_socket.omni_create_data_socket
      0.85            -0.2        0.68 ±  3%  perf-profile.calltrace.cycles-pp.sock_alloc.__sock_create.__sys_socket.__x64_sys_socket.do_syscall_64
      1.78            -0.2        1.61        perf-profile.calltrace.cycles-pp.dput.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.80            -0.2        0.64        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.getsockopt.set_sock_buffer.create_data_socket
      0.86            -0.2        0.71        perf-profile.calltrace.cycles-pp.sock_alloc_file.__sys_socket.__x64_sys_socket.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.75 ±  9%      -0.2        0.60 ±  5%  perf-profile.calltrace.cycles-pp.tcp_get_metrics.tcp_init_metrics.tcp_init_transfer.tcp_finish_connect.tcp_rcv_synsent_state_process
      0.79            -0.2        0.64 ±  3%  perf-profile.calltrace.cycles-pp.alloc_inode.sock_alloc.__sock_create.__sys_socket.__x64_sys_socket
      1.53            -0.2        1.38        perf-profile.calltrace.cycles-pp.__dentry_kill.dput.__fput.__x64_sys_close.do_syscall_64
      0.69            -0.1        0.54        perf-profile.calltrace.cycles-pp.__x64_sys_getsockopt.do_syscall_64.entry_SYSCALL_64_after_hwframe.getsockopt.set_sock_buffer
      0.67            -0.1        0.52        perf-profile.calltrace.cycles-pp.__sys_getsockopt.__x64_sys_getsockopt.do_syscall_64.entry_SYSCALL_64_after_hwframe.getsockopt
      2.07            -0.1        1.93        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.bind.omni_create_data_socket.send_omni_inner.send_tcp_conn_rr
      0.72 ± 10%      -0.1        0.58 ±  5%  perf-profile.calltrace.cycles-pp.tcp_get_metrics.tcp_init_metrics.tcp_init_transfer.tcp_rcv_state_process.tcp_child_process
      0.83            -0.1        0.68        perf-profile.calltrace.cycles-pp.alloc_file_pseudo.sock_alloc_file.__sys_socket.__x64_sys_socket.do_syscall_64
      0.71 ±  9%      -0.1        0.57 ±  6%  perf-profile.calltrace.cycles-pp.__tcp_get_metrics.tcp_get_metrics.tcp_init_metrics.tcp_init_transfer.tcp_finish_connect
      2.06            -0.1        1.92        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.bind.omni_create_data_socket.send_omni_inner
      1.98            -0.1        1.85        perf-profile.calltrace.cycles-pp.__sys_bind.__x64_sys_bind.do_syscall_64.entry_SYSCALL_64_after_hwframe.bind
      0.68 ± 10%      -0.1        0.54 ±  6%  perf-profile.calltrace.cycles-pp.__tcp_get_metrics.tcp_get_metrics.tcp_init_metrics.tcp_init_transfer.tcp_rcv_state_process
      1.99            -0.1        1.86        perf-profile.calltrace.cycles-pp.__x64_sys_bind.do_syscall_64.entry_SYSCALL_64_after_hwframe.bind.omni_create_data_socket
      0.73 ±  2%      -0.1        0.60        perf-profile.calltrace.cycles-pp.setsockopt.omni_create_data_socket.send_omni_inner.send_tcp_conn_rr.main
      1.80            -0.1        1.68        perf-profile.calltrace.cycles-pp.inet_bind_sk.__sys_bind.__x64_sys_bind.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.77            -0.1        1.65        perf-profile.calltrace.cycles-pp.__inet_bind.inet_bind_sk.__sys_bind.__x64_sys_bind.do_syscall_64
      0.86 ±  4%      -0.1        0.74        perf-profile.calltrace.cycles-pp.dequeue_task_fair.try_to_block_task.__schedule.schedule.schedule_timeout
      0.81 ±  3%      -0.1        0.71        perf-profile.calltrace.cycles-pp.dequeue_entities.dequeue_task_fair.try_to_block_task.__schedule.schedule
      0.90 ±  3%      -0.1        0.80        perf-profile.calltrace.cycles-pp.try_to_block_task.__schedule.schedule.schedule_timeout.inet_csk_accept
      0.79 ±  2%      -0.1        0.70        perf-profile.calltrace.cycles-pp.inet_csk_bind_conflict.inet_csk_get_port.__inet_bind.inet_bind_sk.__sys_bind
      0.88 ±  2%      -0.1        0.78        perf-profile.calltrace.cycles-pp.sock_alloc_file.do_accept.__sys_accept4.__x64_sys_accept.do_syscall_64
      0.84 ±  2%      -0.1        0.76        perf-profile.calltrace.cycles-pp.alloc_file_pseudo.sock_alloc_file.do_accept.__sys_accept4.__x64_sys_accept
      0.60 ±  2%      -0.1        0.52        perf-profile.calltrace.cycles-pp.tcp_clean_rtx_queue.tcp_ack.tcp_rcv_synsent_state_process.tcp_rcv_state_process.tcp_v4_do_rcv
      0.68 ±  2%      -0.1        0.60        perf-profile.calltrace.cycles-pp.inet_bind_conflict.inet_csk_bind_conflict.inet_csk_get_port.__inet_bind.inet_bind_sk
      0.86 ±  2%      -0.1        0.80 ±  2%  perf-profile.calltrace.cycles-pp.sock_alloc.do_accept.__sys_accept4.__x64_sys_accept.do_syscall_64
      1.06            -0.1        1.00        perf-profile.calltrace.cycles-pp.ttwu_do_activate.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_sync_key
      0.85            -0.0        0.82        perf-profile.calltrace.cycles-pp.enqueue_task.ttwu_do_activate.try_to_wake_up.autoremove_wake_function.__wake_up_common
      1.20 ±  2%      +0.0        1.24        perf-profile.calltrace.cycles-pp.tcp_v4_send_synack.tcp_conn_request.tcp_rcv_state_process.tcp_v4_do_rcv.tcp_v4_rcv
      0.59 ±  2%      +0.0        0.64 ±  3%  perf-profile.calltrace.cycles-pp.tcp_ack.tcp_rcv_state_process.tcp_v4_do_rcv.__release_sock.__tcp_close
      1.00 ±  2%      +0.1        1.13        perf-profile.calltrace.cycles-pp.tcp_ack.tcp_rcv_synsent_state_process.tcp_rcv_state_process.tcp_v4_do_rcv.__release_sock
      0.69 ±  4%      +0.2        0.86 ±  6%  perf-profile.calltrace.cycles-pp.tcp_v4_send_reset.tcp_v4_do_rcv.tcp_v4_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish
      0.64 ±  4%      +0.2        0.82 ±  5%  perf-profile.calltrace.cycles-pp.ip_send_unicast_reply.tcp_v4_send_reset.tcp_v4_do_rcv.tcp_v4_rcv.ip_protocol_deliver_rcu
      4.33            +0.3        4.59        perf-profile.calltrace.cycles-pp.tcp_child_process.tcp_v4_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish.__netif_receive_skb_one_core
      2.31            +0.3        2.60        perf-profile.calltrace.cycles-pp.tcp_rcv_established.tcp_v4_do_rcv.__release_sock.release_sock.tcp_sendmsg
     10.35            +0.3       10.65        perf-profile.calltrace.cycles-pp.tcp_rcv_state_process.tcp_v4_do_rcv.tcp_v4_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish
      0.37 ± 71%      +0.3        0.68 ±  5%  perf-profile.calltrace.cycles-pp.tcp_time_wait.tcp_rcv_state_process.tcp_v4_do_rcv.tcp_v4_rcv.ip_protocol_deliver_rcu
      1.44            +0.3        1.78        perf-profile.calltrace.cycles-pp.tcp_ack.tcp_rcv_established.tcp_v4_do_rcv.__release_sock.release_sock
      1.42            +0.4        1.83 ±  2%  perf-profile.calltrace.cycles-pp.__tcp_transmit_skb.tcp_v4_do_rcv.tcp_v4_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish
      6.87 ±  2%      +0.4        7.30        perf-profile.calltrace.cycles-pp.__close.recv_omni.process_requests.spawn_child.accept_connection
      6.57 ±  2%      +0.4        7.01        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close.recv_omni.process_requests
      6.44 ±  2%      +0.4        6.88        perf-profile.calltrace.cycles-pp.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close.recv_omni
      6.58 ±  2%      +0.4        7.03        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__close.recv_omni.process_requests.spawn_child
      0.19 ±141%      +0.5        0.64 ±  5%  perf-profile.calltrace.cycles-pp.tcp_update_metrics.tcp_time_wait.tcp_rcv_state_process.tcp_v4_do_rcv.tcp_v4_rcv
      2.88            +0.5        3.38        perf-profile.calltrace.cycles-pp.__release_sock.release_sock.tcp_sendmsg.__sys_sendto.__x64_sys_sendto
      1.56 ±  5%      +0.5        2.08 ±  3%  perf-profile.calltrace.cycles-pp.tcp_init_transfer.tcp_rcv_state_process.tcp_child_process.tcp_v4_rcv.ip_protocol_deliver_rcu
      0.00            +0.5        0.52 ±  2%  perf-profile.calltrace.cycles-pp.tcp_connect_init.tcp_connect.tcp_v4_connect.__inet_stream_connect.inet_stream_connect
      2.46            +0.5        2.98        perf-profile.calltrace.cycles-pp.tcp_v4_do_rcv.__release_sock.release_sock.tcp_sendmsg.__sys_sendto
      3.29 ±  2%      +0.5        3.82        perf-profile.calltrace.cycles-pp.tcp_check_req.tcp_v4_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish.__netif_receive_skb_one_core
      8.44            +0.5        8.97        perf-profile.calltrace.cycles-pp.__tcp_transmit_skb.tcp_write_xmit.__tcp_push_pending_frames.tcp_sendmsg_locked.tcp_sendmsg
      2.74 ±  2%      +0.5        3.28        perf-profile.calltrace.cycles-pp.tcp_v4_syn_recv_sock.tcp_check_req.tcp_v4_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish
      1.62 ±  4%      +0.5        2.16 ±  3%  perf-profile.calltrace.cycles-pp.tcp_init_transfer.tcp_finish_connect.tcp_rcv_synsent_state_process.tcp_rcv_state_process.tcp_v4_do_rcv
      2.24 ±  3%      +0.5        2.78 ±  2%  perf-profile.calltrace.cycles-pp.tcp_rcv_state_process.tcp_child_process.tcp_v4_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish
      0.00            +0.5        0.55 ±  3%  perf-profile.calltrace.cycles-pp.ip_route_output_key_hash_rcu.ip_route_output_flow.tcp_v4_connect.__inet_stream_connect.inet_stream_connect
      5.96 ±  2%      +0.5        6.50        perf-profile.calltrace.cycles-pp.ip_finish_output2.__ip_queue_xmit.__tcp_transmit_skb.tcp_connect.tcp_v4_connect
      1.69 ±  4%      +0.6        2.25 ±  3%  perf-profile.calltrace.cycles-pp.tcp_finish_connect.tcp_rcv_synsent_state_process.tcp_rcv_state_process.tcp_v4_do_rcv.__release_sock
      5.91 ±  2%      +0.6        6.48        perf-profile.calltrace.cycles-pp.__dev_queue_xmit.ip_finish_output2.__ip_queue_xmit.__tcp_transmit_skb.tcp_connect
      3.40            +0.6        3.98        perf-profile.calltrace.cycles-pp.release_sock.tcp_sendmsg.__sys_sendto.__x64_sys_sendto.do_syscall_64
      0.00            +0.6        0.59 ±  4%  perf-profile.calltrace.cycles-pp.ip_route_output_key_hash_rcu.ip_route_output_flow.inet_csk_route_req.tcp_conn_request.tcp_rcv_state_process
      7.99            +0.6        8.60        perf-profile.calltrace.cycles-pp.__ip_queue_xmit.__tcp_transmit_skb.tcp_write_xmit.__tcp_push_pending_frames.tcp_sendmsg_locked
      0.00            +0.6        0.61        perf-profile.calltrace.cycles-pp.tcp_init_sock.tcp_v4_init_sock.inet_create.__sock_create.__sys_socket
      9.25            +0.6        9.86        perf-profile.calltrace.cycles-pp.ip_finish_output2.__ip_queue_xmit.__tcp_transmit_skb.tcp_rcv_synsent_state_process.tcp_rcv_state_process
      0.00            +0.6        0.62        perf-profile.calltrace.cycles-pp.tcp_v4_init_sock.inet_create.__sock_create.__sys_socket.__x64_sys_socket
      9.14            +0.6        9.78        perf-profile.calltrace.cycles-pp.__dev_queue_xmit.ip_finish_output2.__ip_queue_xmit.__tcp_transmit_skb.tcp_rcv_synsent_state_process
      0.00            +0.6        0.64        perf-profile.calltrace.cycles-pp.ip_route_output_key_hash.tcp_v4_connect.__inet_stream_connect.inet_stream_connect.__sys_connect
      0.00            +0.7        0.65 ±  3%  perf-profile.calltrace.cycles-pp.ip_route_output_key_hash_rcu.ip_route_output_flow.inet_csk_route_child_sock.tcp_v4_syn_recv_sock.tcp_check_req
      6.64 ±  2%      +0.7        7.34        perf-profile.calltrace.cycles-pp.__ip_queue_xmit.__tcp_transmit_skb.tcp_connect.tcp_v4_connect.__inet_stream_connect
      7.19 ±  2%      +0.7        7.88        perf-profile.calltrace.cycles-pp.__tcp_transmit_skb.tcp_connect.tcp_v4_connect.__inet_stream_connect.inet_stream_connect
      0.58            +0.8        1.37 ±  2%  perf-profile.calltrace.cycles-pp.__ip_queue_xmit.__tcp_transmit_skb.tcp_v4_do_rcv.tcp_v4_rcv.ip_protocol_deliver_rcu
      9.79            +0.9       10.65        perf-profile.calltrace.cycles-pp.__tcp_transmit_skb.tcp_rcv_synsent_state_process.tcp_rcv_state_process.tcp_v4_do_rcv.__release_sock
      9.48            +0.9       10.34        perf-profile.calltrace.cycles-pp.__ip_queue_xmit.__tcp_transmit_skb.tcp_rcv_synsent_state_process.tcp_rcv_state_process.tcp_v4_do_rcv
      0.00            +0.9        0.87 ±  3%  perf-profile.calltrace.cycles-pp.ip_route_output_flow.tcp_v4_connect.__inet_stream_connect.inet_stream_connect.__sys_connect
     13.34            +0.9       14.22        perf-profile.calltrace.cycles-pp.__send.send_omni_inner.send_tcp_conn_rr.main
     13.09            +0.9       13.99        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__send.send_omni_inner.send_tcp_conn_rr
     13.10            +0.9       14.01        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__send.send_omni_inner.send_tcp_conn_rr.main
     12.85            +0.9       13.76        perf-profile.calltrace.cycles-pp.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_hwframe.__send.send_omni_inner
      3.18 ±  2%      +0.9        4.11        perf-profile.calltrace.cycles-pp.tcp_conn_request.tcp_rcv_state_process.tcp_v4_do_rcv.tcp_v4_rcv.ip_protocol_deliver_rcu
      0.00            +0.9        0.93 ±  3%  perf-profile.calltrace.cycles-pp.ip_route_output_flow.inet_csk_route_req.tcp_conn_request.tcp_rcv_state_process.tcp_v4_do_rcv
      0.00            +1.0        0.98 ±  3%  perf-profile.calltrace.cycles-pp.inet_csk_route_req.tcp_conn_request.tcp_rcv_state_process.tcp_v4_do_rcv.tcp_v4_rcv
     32.44            +1.0       33.43        perf-profile.calltrace.cycles-pp.__local_bh_enable_ip.__dev_queue_xmit.ip_finish_output2.__ip_queue_xmit.__tcp_transmit_skb
     32.32            +1.0       33.31        perf-profile.calltrace.cycles-pp.do_softirq.__local_bh_enable_ip.__dev_queue_xmit.ip_finish_output2.__ip_queue_xmit
     11.24            +1.0       12.24        perf-profile.calltrace.cycles-pp.tcp_rcv_state_process.tcp_v4_do_rcv.__release_sock.release_sock.__inet_stream_connect
      0.00            +1.0        1.01 ±  3%  perf-profile.calltrace.cycles-pp.ip_route_output_flow.inet_csk_route_child_sock.tcp_v4_syn_recv_sock.tcp_check_req.tcp_v4_rcv
     32.04            +1.0       33.08        perf-profile.calltrace.cycles-pp.handle_softirqs.do_softirq.__local_bh_enable_ip.__dev_queue_xmit.ip_finish_output2
      0.00            +1.0        1.05 ±  3%  perf-profile.calltrace.cycles-pp.inet_csk_route_child_sock.tcp_v4_syn_recv_sock.tcp_check_req.tcp_v4_rcv.ip_protocol_deliver_rcu
      8.36 ±  2%      +1.1        9.42        perf-profile.calltrace.cycles-pp.tcp_connect.tcp_v4_connect.__inet_stream_connect.inet_stream_connect.__sys_connect
      7.12 ±  2%      +1.2        8.32        perf-profile.calltrace.cycles-pp.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_hwframe.__send.recv_omni
      7.50 ±  2%      +1.2        8.69        perf-profile.calltrace.cycles-pp.__send.recv_omni.process_requests.spawn_child.accept_connection
      7.23 ±  2%      +1.2        8.43        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__send.recv_omni.process_requests
      7.24 ±  2%      +1.2        8.44        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__send.recv_omni.process_requests.spawn_child
     30.88            +1.2       32.10        perf-profile.calltrace.cycles-pp.net_rx_action.handle_softirqs.do_softirq.__local_bh_enable_ip.__dev_queue_xmit
     23.48 ±  2%      +1.3       24.75        perf-profile.calltrace.cycles-pp.accept_connection.accept_connections.main
     23.48 ±  2%      +1.3       24.75        perf-profile.calltrace.cycles-pp.accept_connections.main
     23.48 ±  2%      +1.3       24.75        perf-profile.calltrace.cycles-pp.process_requests.spawn_child.accept_connection.accept_connections.main
     23.48 ±  2%      +1.3       24.75        perf-profile.calltrace.cycles-pp.spawn_child.accept_connection.accept_connections.main
     32.64            +1.4       34.00        perf-profile.calltrace.cycles-pp.process_backlog.__napi_poll.net_rx_action.handle_softirqs.do_softirq
     32.78            +1.4       34.13        perf-profile.calltrace.cycles-pp.__napi_poll.net_rx_action.handle_softirqs.do_softirq.__local_bh_enable_ip
     31.96            +1.4       33.35        perf-profile.calltrace.cycles-pp.__netif_receive_skb_one_core.process_backlog.__napi_poll.net_rx_action.handle_softirqs
     11.39            +1.4       12.80        perf-profile.calltrace.cycles-pp.__tcp_push_pending_frames.tcp_sendmsg_locked.tcp_sendmsg.__sys_sendto.__x64_sys_sendto
     13.45            +1.4       14.86        perf-profile.calltrace.cycles-pp.tcp_sendmsg_locked.tcp_sendmsg.__sys_sendto.__x64_sys_sendto.do_syscall_64
     11.30            +1.4       12.72        perf-profile.calltrace.cycles-pp.tcp_write_xmit.__tcp_push_pending_frames.tcp_sendmsg_locked.tcp_sendmsg.__sys_sendto
     15.97            +1.4       17.40        perf-profile.calltrace.cycles-pp.tcp_v4_do_rcv.tcp_v4_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish.__netif_receive_skb_one_core
     14.09            +1.5       15.59        perf-profile.calltrace.cycles-pp.release_sock.__inet_stream_connect.inet_stream_connect.__sys_connect.__x64_sys_connect
     14.02            +1.5       15.52        perf-profile.calltrace.cycles-pp.__release_sock.release_sock.__inet_stream_connect.inet_stream_connect.__sys_connect
     29.50            +1.5       31.04        perf-profile.calltrace.cycles-pp.ip_local_deliver_finish.__netif_receive_skb_one_core.process_backlog.__napi_poll.net_rx_action
     13.53            +1.5       15.07        perf-profile.calltrace.cycles-pp.tcp_v4_do_rcv.__release_sock.release_sock.__inet_stream_connect.inet_stream_connect
     29.38            +1.6       30.92        perf-profile.calltrace.cycles-pp.ip_protocol_deliver_rcu.ip_local_deliver_finish.__netif_receive_skb_one_core.process_backlog.__napi_poll
     13.17            +1.6       14.74        perf-profile.calltrace.cycles-pp.tcp_rcv_synsent_state_process.tcp_rcv_state_process.tcp_v4_do_rcv.__release_sock.release_sock
     16.97 ±  2%      +1.6       18.58        perf-profile.calltrace.cycles-pp.recv_omni.process_requests.spawn_child.accept_connection.accept_connections
     10.83 ±  2%      +1.6       12.48        perf-profile.calltrace.cycles-pp.tcp_v4_connect.__inet_stream_connect.inet_stream_connect.__sys_connect.__x64_sys_connect
     28.64            +1.7       30.30        perf-profile.calltrace.cycles-pp.tcp_v4_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish.__netif_receive_skb_one_core.process_backlog
     19.90            +2.1       22.00        perf-profile.calltrace.cycles-pp.__sys_sendto.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_hwframe.__send
     19.52            +2.1       21.63        perf-profile.calltrace.cycles-pp.tcp_sendmsg.__sys_sendto.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_hwframe
     26.15            +3.1       29.23        perf-profile.calltrace.cycles-pp.connect.send_omni_inner.send_tcp_conn_rr.main
     25.88            +3.1       28.99        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.connect.send_omni_inner.send_tcp_conn_rr.main
     25.88            +3.2       29.07        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.connect.send_omni_inner.send_tcp_conn_rr
     25.61            +3.2       28.82        perf-profile.calltrace.cycles-pp.__x64_sys_connect.do_syscall_64.entry_SYSCALL_64_after_hwframe.connect.send_omni_inner
     25.56            +3.2       28.78        perf-profile.calltrace.cycles-pp.__sys_connect.__x64_sys_connect.do_syscall_64.entry_SYSCALL_64_after_hwframe.connect
     25.37            +3.2       28.60        perf-profile.calltrace.cycles-pp.inet_stream_connect.__sys_connect.__x64_sys_connect.do_syscall_64.entry_SYSCALL_64_after_hwframe
     25.23            +3.2       28.48        perf-profile.calltrace.cycles-pp.__inet_stream_connect.inet_stream_connect.__sys_connect.__x64_sys_connect.do_syscall_64
     26.58            -2.1       24.43        perf-profile.children.cycles-pp.__close
     25.63            -2.1       23.57        perf-profile.children.cycles-pp.__x64_sys_close
     24.97            -2.0       23.01        perf-profile.children.cycles-pp.__fput
     22.52            -1.8       20.76        perf-profile.children.cycles-pp.__sock_release
     22.57            -1.7       20.82        perf-profile.children.cycles-pp.sock_close
     22.32            -1.7       20.59        perf-profile.children.cycles-pp.inet_release
     21.13            -1.3       19.81        perf-profile.children.cycles-pp.tcp_close
      8.86            -1.3        7.57        perf-profile.children.cycles-pp.omni_create_data_socket
     20.82            -1.3       19.56        perf-profile.children.cycles-pp.__tcp_close
     74.02            -1.0       73.02        perf-profile.children.cycles-pp.send_omni_inner
      7.29            -0.9        6.36        perf-profile.children.cycles-pp.recv
      3.08 ±  3%      -0.9        2.18        perf-profile.children.cycles-pp.tcp_done
      2.88 ±  4%      -0.8        2.03        perf-profile.children.cycles-pp.tcp_set_state
      3.02 ±  3%      -0.8        2.19        perf-profile.children.cycles-pp._raw_spin_lock_bh
      6.89            -0.8        6.11        perf-profile.children.cycles-pp.tcp_data_queue
      2.07 ±  2%      -0.7        1.34        perf-profile.children.cycles-pp.__sk_destruct
      5.44            -0.7        4.73        perf-profile.children.cycles-pp.__x64_sys_recvfrom
      2.19 ±  5%      -0.7        1.47        perf-profile.children.cycles-pp.inet_unhash
      5.38            -0.7        4.68        perf-profile.children.cycles-pp.__sys_recvfrom
      4.35            -0.7        3.68        perf-profile.children.cycles-pp.__socket
      5.02            -0.7        4.36        perf-profile.children.cycles-pp.sock_recvmsg
      4.92            -0.7        4.27        perf-profile.children.cycles-pp.inet_recvmsg
      4.81            -0.6        4.16        perf-profile.children.cycles-pp.tcp_recvmsg
      2.86 ±  9%      -0.6        2.23 ±  6%  perf-profile.children.cycles-pp.tcp_get_metrics
      4.47            -0.6        3.86        perf-profile.children.cycles-pp.tcp_recvmsg_locked
      3.94 ±  2%      -0.6        3.34        perf-profile.children.cycles-pp.__x64_sys_socket
      2.70 ± 10%      -0.6        2.11 ±  6%  perf-profile.children.cycles-pp.__tcp_get_metrics
      3.90            -0.6        3.31        perf-profile.children.cycles-pp.__sys_socket
      4.35 ±  2%      -0.6        3.78 ±  4%  perf-profile.children.cycles-pp.tcp_fin
      5.22            -0.6        4.65 ±  2%  perf-profile.children.cycles-pp.__schedule
      4.54            -0.6        3.98        perf-profile.children.cycles-pp.schedule_timeout
      4.46            -0.5        3.91        perf-profile.children.cycles-pp.schedule
      3.44            -0.5        2.99        perf-profile.children.cycles-pp.kmem_cache_free
      1.27 ±  3%      -0.4        0.84        perf-profile.children.cycles-pp.sk_alloc
      3.07 ±  5%      -0.4        2.65 ±  5%  perf-profile.children.cycles-pp.try_to_wake_up
      1.43 ±  2%      -0.4        1.02        perf-profile.children.cycles-pp.tcp_create_openreq_child
      2.61            -0.4        2.21        perf-profile.children.cycles-pp.sk_wait_data
      3.34 ±  5%      -0.4        2.94 ±  5%  perf-profile.children.cycles-pp.sock_def_readable
      2.85 ±  2%      -0.4        2.44        perf-profile.children.cycles-pp.__sock_create
      7.02 ±  2%      -0.4        6.62        perf-profile.children.cycles-pp.accept
      3.24 ±  5%      -0.4        2.84 ±  5%  perf-profile.children.cycles-pp.__wake_up_common
      3.20 ±  5%      -0.4        2.80 ±  5%  perf-profile.children.cycles-pp.__wake_up_sync_key
      5.96 ±  2%      -0.4        5.58        perf-profile.children.cycles-pp.__x64_sys_accept
      5.92 ±  2%      -0.4        5.54        perf-profile.children.cycles-pp.__sys_accept4
      2.43            -0.4        2.06        perf-profile.children.cycles-pp.tcp_clean_rtx_queue
      5.73 ±  2%      -0.4        5.36        perf-profile.children.cycles-pp.do_accept
      1.76            -0.4        1.40        perf-profile.children.cycles-pp.inet_csk_destroy_sock
      2.37            -0.4        2.01        perf-profile.children.cycles-pp.wait_woken
      1.13 ±  3%      -0.4        0.77        perf-profile.children.cycles-pp.inet_csk_clone_lock
      1.05 ±  3%      -0.3        0.71        perf-profile.children.cycles-pp.sk_clone_lock
      2.23            -0.3        1.92        perf-profile.children.cycles-pp.dev_hard_start_xmit
      1.96            -0.3        1.67        perf-profile.children.cycles-pp._raw_spin_lock
      1.49            -0.3        1.20        perf-profile.children.cycles-pp.create_data_socket
      1.95 ±  4%      -0.3        1.66 ±  4%  perf-profile.children.cycles-pp.autoremove_wake_function
      2.02            -0.3        1.73        perf-profile.children.cycles-pp.loopback_xmit
      1.50            -0.3        1.23        perf-profile.children.cycles-pp.inet_csk_get_port
      1.34            -0.3        1.07        perf-profile.children.cycles-pp.set_sock_buffer
      1.29            -0.3        1.02        perf-profile.children.cycles-pp.getsockopt
      1.43 ±  2%      -0.3        1.17        perf-profile.children.cycles-pp.dequeue_task_fair
      1.37 ±  2%      -0.3        1.11        perf-profile.children.cycles-pp.dequeue_entities
      1.35            -0.3        1.09        perf-profile.children.cycles-pp.tcp_v4_destroy_sock
      1.76            -0.3        1.51        perf-profile.children.cycles-pp.sock_alloc_file
      1.54 ±  2%      -0.2        1.29        perf-profile.children.cycles-pp.try_to_block_task
      3.61 ±  2%      -0.2        3.37        perf-profile.children.cycles-pp.inet_accept
      1.74            -0.2        1.50 ±  3%  perf-profile.children.cycles-pp.sock_alloc
      1.70            -0.2        1.46        perf-profile.children.cycles-pp.alloc_file_pseudo
      1.40            -0.2        1.16        perf-profile.children.cycles-pp.kmem_cache_alloc_noprof
      3.35 ±  2%      -0.2        3.13        perf-profile.children.cycles-pp.inet_csk_accept
      1.74            -0.2        1.53        perf-profile.children.cycles-pp.__memcg_slab_post_alloc_hook
      1.62            -0.2        1.41 ±  3%  perf-profile.children.cycles-pp.alloc_inode
      0.88            -0.2        0.68        perf-profile.children.cycles-pp.dequeue_entity
      1.89 ±  2%      -0.2        1.69        perf-profile.children.cycles-pp.inet_create
      2.36            -0.2        2.16        perf-profile.children.cycles-pp.bind
      1.76            -0.2        1.57        perf-profile.children.cycles-pp.__alloc_skb
      1.07 ±  2%      -0.2        0.89        perf-profile.children.cycles-pp.skb_release_data
      1.11            -0.2        0.93        perf-profile.children.cycles-pp.__mod_timer
      1.19            -0.2        1.02        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      1.07            -0.2        0.90        perf-profile.children.cycles-pp.sk_reset_timer
      1.80            -0.2        1.63        perf-profile.children.cycles-pp.dput
      1.38            -0.2        1.21        perf-profile.children.cycles-pp.clear_bhb_loop
      0.58            -0.2        0.42        perf-profile.children.cycles-pp.tcp_schedule_loss_probe
      0.88            -0.2        0.72        perf-profile.children.cycles-pp.__kfree_skb
      1.48            -0.2        1.32        perf-profile.children.cycles-pp.__inet_lookup_skb
      1.33            -0.2        1.17 ±  2%  perf-profile.children.cycles-pp.kmem_cache_alloc_lru_noprof
      1.28            -0.2        1.12        perf-profile.children.cycles-pp.__memcg_slab_free_hook
      1.56            -0.2        1.40        perf-profile.children.cycles-pp.__dentry_kill
      2.02            -0.2        1.87        perf-profile.children.cycles-pp.__sys_bind
      0.70            -0.2        0.56        perf-profile.children.cycles-pp.__x64_sys_getsockopt
      0.82            -0.2        0.67        perf-profile.children.cycles-pp.inet_put_port
      0.68            -0.1        0.54        perf-profile.children.cycles-pp.__sys_getsockopt
      0.78            -0.1        0.64        perf-profile.children.cycles-pp.setsockopt
      1.77            -0.1        1.62        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      1.82            -0.1        1.68        perf-profile.children.cycles-pp.__inet_bind
      1.09 ±  2%      -0.1        0.95 ±  3%  perf-profile.children.cycles-pp.update_curr
      2.02            -0.1        1.88        perf-profile.children.cycles-pp.__x64_sys_bind
      1.84            -0.1        1.70        perf-profile.children.cycles-pp.inet_bind_sk
      0.59 ±  2%      -0.1        0.46        perf-profile.children.cycles-pp.__inet_bhash2_update_saddr
      0.60            -0.1        0.46        perf-profile.children.cycles-pp.do_sock_getsockopt
      0.90            -0.1        0.77        perf-profile.children.cycles-pp.update_load_avg
      1.08            -0.1        0.95        perf-profile.children.cycles-pp.__inet_lookup_established
      0.90            -0.1        0.78 ±  3%  perf-profile.children.cycles-pp.sock_alloc_inode
      0.53 ±  4%      -0.1        0.42 ±  3%  perf-profile.children.cycles-pp.fib_table_lookup
      0.65            -0.1        0.54        perf-profile.children.cycles-pp.__d_alloc
      0.68            -0.1        0.57        perf-profile.children.cycles-pp.d_alloc_pseudo
      0.68            -0.1        0.57        perf-profile.children.cycles-pp.irqtime_account_irq
      0.95            -0.1        0.84 ±  2%  perf-profile.children.cycles-pp.__sk_mem_reduce_allocated
      0.64            -0.1        0.53        perf-profile.children.cycles-pp.lock_timer_base
      1.48 ±  2%      -0.1        1.38 ±  4%  perf-profile.children.cycles-pp.__cond_resched
      0.68            -0.1        0.57        perf-profile.children.cycles-pp.__tcp_send_ack
      0.93            -0.1        0.82 ±  3%  perf-profile.children.cycles-pp.rcu_core
      1.47            -0.1        1.36        perf-profile.children.cycles-pp.ttwu_do_activate
      1.52            -0.1        1.41        perf-profile.children.cycles-pp.ip_rcv
      0.88            -0.1        0.78 ±  4%  perf-profile.children.cycles-pp.rcu_do_batch
      0.83 ±  2%      -0.1        0.72 ±  2%  perf-profile.children.cycles-pp.mem_cgroup_uncharge_skmem
      0.98            -0.1        0.88        perf-profile.children.cycles-pp.tcp_event_new_data_sent
      1.09 ±  2%      -0.1        0.99 ±  4%  perf-profile.children.cycles-pp.__mod_memcg_state
      1.35            -0.1        1.25        perf-profile.children.cycles-pp.enqueue_task
      0.95            -0.1        0.85        perf-profile.children.cycles-pp.kmem_cache_alloc_node_noprof
      0.89            -0.1        0.79        perf-profile.children.cycles-pp.validate_xmit_skb
      0.58            -0.1        0.49        perf-profile.children.cycles-pp.ip_rcv_core
      0.76 ±  2%      -0.1        0.66 ±  2%  perf-profile.children.cycles-pp.mod_objcg_state
      0.42            -0.1        0.32        perf-profile.children.cycles-pp.sk_getsockopt
      0.81 ±  2%      -0.1        0.72        perf-profile.children.cycles-pp.inet_csk_bind_conflict
      1.42            -0.1        1.33        perf-profile.children.cycles-pp.__pick_next_task
      0.46 ±  3%      -0.1        0.36        perf-profile.children.cycles-pp.sk_stop_timer
      0.40            -0.1        0.30        perf-profile.children.cycles-pp.tcp_current_mss
      0.88            -0.1        0.78        perf-profile.children.cycles-pp.tcp_send_fin
      0.44            -0.1        0.35 ±  2%  perf-profile.children.cycles-pp.__x64_sys_setsockopt
      0.63            -0.1        0.54        perf-profile.children.cycles-pp.sk_prot_alloc
      0.54            -0.1        0.46        perf-profile.children.cycles-pp.inet_csk_reqsk_queue_hash_add
      0.48            -0.1        0.40        perf-profile.children.cycles-pp.netif_skb_features
      1.39            -0.1        1.31        perf-profile.children.cycles-pp.pick_next_task_fair
      0.42            -0.1        0.34 ±  2%  perf-profile.children.cycles-pp.__sys_setsockopt
      0.48            -0.1        0.40        perf-profile.children.cycles-pp.__inet_hash_connect
      0.57            -0.1        0.49        perf-profile.children.cycles-pp.kmalloc_reserve
      0.62            -0.1        0.54        perf-profile.children.cycles-pp.sched_clock_cpu
      0.70            -0.1        0.62        perf-profile.children.cycles-pp.inet_bind_conflict
      1.09            -0.1        1.01        perf-profile.children.cycles-pp.tcp_stream_alloc_skb
      0.44 ±  2%      -0.1        0.36        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      0.41            -0.1        0.34        perf-profile.children.cycles-pp.__inet_check_established
      0.47            -0.1        0.40        perf-profile.children.cycles-pp.__ip_finish_output
      0.38 ±  2%      -0.1        0.31        perf-profile.children.cycles-pp.inet_csk_clear_xmit_timers
      0.85            -0.1        0.78        perf-profile.children.cycles-pp.__netif_rx
      0.82 ±  2%      -0.1        0.75 ±  5%  perf-profile.children.cycles-pp.tcp_validate_incoming
      0.57            -0.1        0.50        perf-profile.children.cycles-pp.skb_copy_datagram_iter
      0.63            -0.1        0.56        perf-profile.children.cycles-pp.entry_SYSCALL_64
      0.32            -0.1        0.25        perf-profile.children.cycles-pp.__skb_clone
      0.31            -0.1        0.24        perf-profile.children.cycles-pp.tcp_init_xmit_timers
      0.27            -0.1        0.20        perf-profile.children.cycles-pp.tcp_options_write
      0.37            -0.1        0.30 ±  2%  perf-profile.children.cycles-pp.do_sock_setsockopt
      0.48            -0.1        0.41        perf-profile.children.cycles-pp.fdget
      0.54            -0.1        0.48        perf-profile.children.cycles-pp.sched_clock
      0.55            -0.1        0.48        perf-profile.children.cycles-pp.__skb_datagram_iter
      0.74            -0.1        0.67        perf-profile.children.cycles-pp.enqueue_to_backlog
      0.80            -0.1        0.73        perf-profile.children.cycles-pp.netif_rx_internal
      0.49            -0.1        0.42        perf-profile.children.cycles-pp.pick_task_fair
      0.45 ±  2%      -0.1        0.38        perf-profile.children.cycles-pp.tcp_ack_update_rtt
      0.35            -0.1        0.28        perf-profile.children.cycles-pp.timer_delete
      0.64            -0.1        0.58        perf-profile.children.cycles-pp.lock_sock_nested
      0.38 ±  2%      -0.1        0.31        perf-profile.children.cycles-pp._copy_from_user
      0.53            -0.1        0.46        perf-profile.children.cycles-pp.alloc_empty_file
      0.48            -0.1        0.42        perf-profile.children.cycles-pp.native_sched_clock
      0.35 ±  7%      -0.1        0.28 ±  9%  perf-profile.children.cycles-pp.select_task_rq
      0.28            -0.1        0.22 ±  2%  perf-profile.children.cycles-pp.ipv4_mtu
      0.58            -0.1        0.52        perf-profile.children.cycles-pp.__check_object_size
      1.14            -0.1        1.08        perf-profile.children.cycles-pp.enqueue_task_fair
      0.98            -0.1        0.92 ±  2%  perf-profile.children.cycles-pp.ktime_get
      0.23 ±  2%      -0.1        0.16 ±  2%  perf-profile.children.cycles-pp.sk_stream_kill_queues
      0.39 ±  2%      -0.1        0.33 ±  3%  perf-profile.children.cycles-pp.check_preempt_wakeup_fair
      0.49            -0.1        0.43 ±  2%  perf-profile.children.cycles-pp.wakeup_preempt
      0.34            -0.1        0.28        perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.36            -0.1        0.30        perf-profile.children.cycles-pp.dst_release
      0.45            -0.1        0.40        perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.67            -0.1        0.61 ±  3%  perf-profile.children.cycles-pp.inode_init_always_gfp
      0.50            -0.1        0.45        perf-profile.children.cycles-pp.tcp_try_rmem_schedule
      0.30 ±  8%      -0.1        0.24 ±  9%  perf-profile.children.cycles-pp.select_task_rq_fair
      0.29 ±  2%      -0.1        0.24 ±  2%  perf-profile.children.cycles-pp.sk_setsockopt
      0.67            -0.1        0.62 ±  2%  perf-profile.children.cycles-pp.enqueue_entity
      0.47            -0.1        0.41        perf-profile.children.cycles-pp.__ip_local_out
      0.44            -0.1        0.38        perf-profile.children.cycles-pp.destroy_inode
      0.34            -0.1        0.28        perf-profile.children.cycles-pp.inet_ehashfn
      0.34 ±  2%      -0.1        0.29        perf-profile.children.cycles-pp.skb_release_head_state
      0.46            -0.1        0.41        perf-profile.children.cycles-pp.ip_local_out
      0.68            -0.1        0.62        perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.20            -0.1        0.14 ±  3%  perf-profile.children.cycles-pp.xa_destroy
      0.34            -0.1        0.29        perf-profile.children.cycles-pp.ip_skb_dst_mtu
      0.34            -0.1        0.29        perf-profile.children.cycles-pp.pick_eevdf
      0.52            -0.1        0.47        perf-profile.children.cycles-pp.tcp_make_synack
      0.35            -0.1        0.30        perf-profile.children.cycles-pp.evict
      0.64            -0.1        0.59        perf-profile.children.cycles-pp.tcp_mstamp_refresh
      0.26            -0.1        0.21 ±  2%  perf-profile.children.cycles-pp.tcp_send_mss
      0.44            -0.0        0.40        perf-profile.children.cycles-pp.__sk_mem_schedule
      0.20 ±  3%      -0.0        0.15 ±  2%  perf-profile.children.cycles-pp.sk_setup_caps
      0.19 ±  2%      -0.0        0.14        perf-profile.children.cycles-pp.__hrtimer_init
      0.15 ±  3%      -0.0        0.10        perf-profile.children.cycles-pp.__copy_skb_header
      0.46            -0.0        0.42 ±  2%  perf-profile.children.cycles-pp.obj_cgroup_charge
      0.70            -0.0        0.65        perf-profile.children.cycles-pp.switch_mm_irqs_off
      0.41            -0.0        0.36        perf-profile.children.cycles-pp.__sk_mem_raise_allocated
      0.41            -0.0        0.36        perf-profile.children.cycles-pp.__destroy_inode
      0.31            -0.0        0.26        perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.26            -0.0        0.22        perf-profile.children.cycles-pp.__call_rcu_common
      0.44            -0.0        0.39        perf-profile.children.cycles-pp.inet_ehash_insert
      0.17 ±  2%      -0.0        0.12 ±  3%  perf-profile.children.cycles-pp.tcp_newly_delivered
      0.11 ±  4%      -0.0        0.07        perf-profile.children.cycles-pp.xfrm_lookup_route
      0.26            -0.0        0.22 ±  2%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.16 ±  4%      -0.0        0.12 ±  4%  perf-profile.children.cycles-pp.tcp_sync_mss
      0.14 ±  2%      -0.0        0.10        perf-profile.children.cycles-pp.vruntime_eligible
      0.18 ±  2%      -0.0        0.14 ±  3%  perf-profile.children.cycles-pp.sk_skb_reason_drop
      0.38            -0.0        0.34        perf-profile.children.cycles-pp.skb_do_copy_data_nocache
      0.37            -0.0        0.33        perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.34            -0.0        0.30 ±  3%  perf-profile.children.cycles-pp.security_inode_alloc
      0.13 ±  3%      -0.0        0.09 ±  5%  perf-profile.children.cycles-pp.inet_reqsk_alloc
      0.27            -0.0        0.24 ±  4%  perf-profile.children.cycles-pp.tcp_write_queue_purge
      0.22 ±  3%      -0.0        0.18        perf-profile.children.cycles-pp.secure_tcp_seq
      0.26 ±  2%      -0.0        0.22 ±  4%  perf-profile.children.cycles-pp.raw_local_deliver
      0.26 ±  2%      -0.0        0.22 ±  2%  perf-profile.children.cycles-pp.d_instantiate
      0.25            -0.0        0.22 ±  2%  perf-profile.children.cycles-pp.tcp_wfree
      0.30            -0.0        0.27        perf-profile.children.cycles-pp.__update_load_avg_se
      0.22 ±  2%      -0.0        0.19        perf-profile.children.cycles-pp.rcu_all_qs
      0.14            -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.neigh_hh_output
      0.18 ±  2%      -0.0        0.14 ±  2%  perf-profile.children.cycles-pp.get_random_u32
      0.75            -0.0        0.72        perf-profile.children.cycles-pp.__netif_receive_skb_core
      0.18 ±  4%      -0.0        0.15 ±  3%  perf-profile.children.cycles-pp.recv_data
      0.07 ±  7%      -0.0        0.03 ± 70%  perf-profile.children.cycles-pp.ktime_get_seconds
      0.32 ±  2%      -0.0        0.29 ±  2%  perf-profile.children.cycles-pp.skb_attempt_defer_free
      0.23 ±  2%      -0.0        0.19 ±  2%  perf-profile.children.cycles-pp.tcp_ack_update_window
      0.25            -0.0        0.22 ±  4%  perf-profile.children.cycles-pp.memset_orig
      0.09 ±  4%      -0.0        0.06        perf-profile.children.cycles-pp.xfrm_lookup_with_ifid
      0.13 ±  5%      -0.0        0.10        perf-profile.children.cycles-pp.ip_finish_output
      0.12 ±  3%      -0.0        0.09 ±  4%  perf-profile.children.cycles-pp.qdisc_pkt_len_init
      0.12 ±  4%      -0.0        0.08 ±  5%  perf-profile.children.cycles-pp.skb_push
      0.21            -0.0        0.18        perf-profile.children.cycles-pp.tcp_established_options
      0.41            -0.0        0.38 ±  2%  perf-profile.children.cycles-pp.switch_fpu_return
      0.19            -0.0        0.16        perf-profile.children.cycles-pp.tcp_check_space
      0.11 ±  3%      -0.0        0.08 ±  4%  perf-profile.children.cycles-pp.tcp_chrono_stop
      0.18 ±  2%      -0.0        0.15 ±  2%  perf-profile.children.cycles-pp.__inet_lookup_listener
      0.16 ±  2%      -0.0        0.13 ±  3%  perf-profile.children.cycles-pp.inet_bind2_bucket_create
      0.20            -0.0        0.17 ±  2%  perf-profile.children.cycles-pp.kfree_skbmem
      0.21 ±  2%      -0.0        0.18 ±  2%  perf-profile.children.cycles-pp.skb_network_protocol
      0.28            -0.0        0.25        perf-profile.children.cycles-pp.check_heap_object
      0.19 ±  3%      -0.0        0.16 ±  4%  perf-profile.children.cycles-pp.obj_cgroup_uncharge_pages
      0.25            -0.0        0.22 ±  2%  perf-profile.children.cycles-pp.__switch_to_asm
      0.15 ±  2%      -0.0        0.12        perf-profile.children.cycles-pp.pick_next_port_number
      0.14 ±  2%      -0.0        0.11        perf-profile.children.cycles-pp.inet_bind_bucket_create
      0.09 ±  4%      -0.0        0.06        perf-profile.children.cycles-pp.skb_clone
      0.25            -0.0        0.22 ±  4%  perf-profile.children.cycles-pp.memcg_list_lru_alloc
      0.26            -0.0        0.23        perf-profile.children.cycles-pp.simple_copy_to_iter
      0.31            -0.0        0.28 ±  2%  perf-profile.children.cycles-pp.rseq_ip_fixup
      0.31            -0.0        0.28        perf-profile.children.cycles-pp.sk_filter_trim_cap
      0.07 ±  5%      -0.0        0.04 ± 44%  perf-profile.children.cycles-pp.inet_csk_update_fastreuse
      0.09            -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.siphash_1u64
      0.09 ±  5%      -0.0        0.06        perf-profile.children.cycles-pp.sk_page_frag_refill
      0.29 ±  2%      -0.0        0.26 ±  2%  perf-profile.children.cycles-pp.tcp_add_backlog
      0.06            -0.0        0.03 ± 70%  perf-profile.children.cycles-pp.tcp_synack_options
      0.13 ±  2%      -0.0        0.10 ±  3%  perf-profile.children.cycles-pp.__d_instantiate
      0.13 ±  7%      -0.0        0.11 ±  6%  perf-profile.children.cycles-pp.eth_type_trans
      0.15            -0.0        0.12 ±  3%  perf-profile.children.cycles-pp.fsnotify_grab_connector
      0.14 ±  3%      -0.0        0.12 ±  3%  perf-profile.children.cycles-pp.xa_find
      0.16 ±  3%      -0.0        0.13        perf-profile.children.cycles-pp.__enqueue_entity
      0.12 ±  4%      -0.0        0.09        perf-profile.children.cycles-pp.get_random_u16
      0.14            -0.0        0.12 ±  4%  perf-profile.children.cycles-pp.sk_free
      0.13 ±  3%      -0.0        0.10 ±  3%  perf-profile.children.cycles-pp.tcp_synack_rtt_meas
      0.16 ±  4%      -0.0        0.13 ±  5%  perf-profile.children.cycles-pp.__sk_free
      0.17 ±  2%      -0.0        0.15 ±  2%  perf-profile.children.cycles-pp.fsnotify_destroy_marks
      0.23 ±  3%      -0.0        0.21 ±  2%  perf-profile.children.cycles-pp.inet_csk_complete_hashdance
      0.22            -0.0        0.20 ±  2%  perf-profile.children.cycles-pp.ip_send_check
      0.16 ±  2%      -0.0        0.14 ±  2%  perf-profile.children.cycles-pp.kfree
      0.17 ±  2%      -0.0        0.15 ±  3%  perf-profile.children.cycles-pp.tcp_urg
      0.61            -0.0        0.59        perf-profile.children.cycles-pp.read_tsc
      0.34 ±  2%      -0.0        0.32 ±  3%  perf-profile.children.cycles-pp.restore_fpregs_from_fpstate
      0.28 ±  2%      -0.0        0.26        perf-profile.children.cycles-pp.sock_def_wakeup
      0.21            -0.0        0.19        perf-profile.children.cycles-pp.refill_obj_stock
      0.23 ±  2%      -0.0        0.21 ±  3%  perf-profile.children.cycles-pp.tcp_queue_rcv
      0.17 ±  3%      -0.0        0.15 ±  3%  perf-profile.children.cycles-pp.tcp_rtt_estimator
      0.12 ±  3%      -0.0        0.10        perf-profile.children.cycles-pp.init_file
      0.23            -0.0        0.21        perf-profile.children.cycles-pp.tcp_inbound_hash
      0.10 ±  3%      -0.0        0.08        perf-profile.children.cycles-pp.__sock_wfree
      0.10 ±  5%      -0.0        0.07 ±  6%  perf-profile.children.cycles-pp.__xfrm_policy_check2
      0.09 ±  5%      -0.0        0.07 ±  5%  perf-profile.children.cycles-pp.update_curr_dl_se
      0.20            -0.0        0.18        perf-profile.children.cycles-pp._copy_to_iter
      0.15 ±  3%      -0.0        0.13 ±  2%  perf-profile.children.cycles-pp.bpf_skops_write_hdr_opt
      0.14            -0.0        0.12        perf-profile.children.cycles-pp.tcp_update_skb_after_send
      0.13 ±  3%      -0.0        0.11 ±  4%  perf-profile.children.cycles-pp._get_random_bytes
      0.08            -0.0        0.06        perf-profile.children.cycles-pp.down_write
      0.13            -0.0        0.11        perf-profile.children.cycles-pp.rb_first
      0.09            -0.0        0.07        perf-profile.children.cycles-pp.siphash_3u32
      0.24 ±  2%      -0.0        0.22 ±  3%  perf-profile.children.cycles-pp._copy_to_user
      0.11 ±  4%      -0.0        0.09 ±  5%  perf-profile.children.cycles-pp.chacha_block_generic
      0.13 ±  2%      -0.0        0.11 ±  3%  perf-profile.children.cycles-pp.sock_i_uid
      0.15            -0.0        0.13        perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      0.12            -0.0        0.10        perf-profile.children.cycles-pp.ip_output
      0.14            -0.0        0.12 ±  3%  perf-profile.children.cycles-pp.__memcpy
      0.10            -0.0        0.08 ±  4%  perf-profile.children.cycles-pp.inet_lhash2_lookup
      0.10 ±  5%      -0.0        0.08 ±  6%  perf-profile.children.cycles-pp.hrtimer_try_to_cancel
      0.16 ±  2%      -0.0        0.14 ±  3%  perf-profile.children.cycles-pp.os_xsave
      0.13 ±  3%      -0.0        0.11 ±  3%  perf-profile.children.cycles-pp.requeue_delayed_entity
      0.06            -0.0        0.04 ± 44%  perf-profile.children.cycles-pp.cubictcp_acked
      0.13            -0.0        0.11 ±  3%  perf-profile.children.cycles-pp.connect_data_socket
      0.21            -0.0        0.19        perf-profile.children.cycles-pp.update_min_vruntime
      0.10 ±  3%      -0.0        0.08 ±  4%  perf-profile.children.cycles-pp.chacha_permute
      0.08 ±  6%      -0.0        0.06        perf-profile.children.cycles-pp.init_timer_key
      0.10 ±  4%      -0.0        0.08        perf-profile.children.cycles-pp.xas_find
      0.08 ±  4%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.inet_csk_init_xmit_timers
      0.07 ±  5%      -0.0        0.06 ±  9%  perf-profile.children.cycles-pp.skb_free_head
      0.07            -0.0        0.05 ±  8%  perf-profile.children.cycles-pp.truncate_inode_pages_final
      0.09 ±  5%      -0.0        0.07        perf-profile.children.cycles-pp.skb_rbtree_purge
      0.14 ±  2%      -0.0        0.13 ±  3%  perf-profile.children.cycles-pp.enqueue_timer
      0.11 ±  3%      -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.alloc_fd
      0.11 ±  3%      -0.0        0.09 ±  5%  perf-profile.children.cycles-pp.inet_sock_destruct
      0.08 ±  5%      -0.0        0.07        perf-profile.children.cycles-pp.sock_rfree
      0.06 ±  7%      -0.0        0.05        perf-profile.children.cycles-pp.cubictcp_cong_avoid
      0.06 ±  7%      -0.0        0.05        perf-profile.children.cycles-pp.tcp_sndbuf_expand
      0.10 ±  4%      -0.0        0.09        perf-profile.children.cycles-pp.consume_skb
      0.16 ±  2%      -0.0        0.15 ±  2%  perf-profile.children.cycles-pp.rseq_get_rseq_cs
      0.07 ±  6%      -0.0        0.06        perf-profile.children.cycles-pp.disconnect_data_socket
      0.10 ±  5%      -0.0        0.08 ±  4%  perf-profile.children.cycles-pp.skb_clone_tx_timestamp
      0.07 ±  6%      -0.0        0.06        perf-profile.children.cycles-pp.tcp_push
      0.14 ±  3%      -0.0        0.13        perf-profile.children.cycles-pp.__get_user_8
      0.18 ±  2%      -0.0        0.17        perf-profile.children.cycles-pp.__virt_addr_valid
      0.08 ±  6%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.crng_make_state
      0.18 ±  2%      -0.0        0.16 ±  2%  perf-profile.children.cycles-pp.inet_ehash_nolisten
      0.08 ±  5%      -0.0        0.07 ±  5%  perf-profile.children.cycles-pp.tcp_rate_gen
      0.15 ±  2%      -0.0        0.14 ±  2%  perf-profile.children.cycles-pp.__inet_csk_reqsk_queue_drop
      0.11 ±  4%      -0.0        0.10        perf-profile.children.cycles-pp.sock_copy
      0.10            -0.0        0.09 ±  4%  perf-profile.children.cycles-pp.file_init_path
      0.17            -0.0        0.16 ±  2%  perf-profile.children.cycles-pp.tcp_rearm_rto
      0.09 ±  4%      -0.0        0.08        perf-profile.children.cycles-pp.__fput_sync
      0.09            -0.0        0.08 ±  4%  perf-profile.children.cycles-pp.__srcu_read_lock
      0.14            -0.0        0.13        perf-profile.children.cycles-pp._raw_spin_unlock_bh
      0.07            -0.0        0.06        perf-profile.children.cycles-pp._raw_write_lock_bh
      0.07            -0.0        0.06        perf-profile.children.cycles-pp.crng_fast_key_erasure
      0.09            -0.0        0.08        perf-profile.children.cycles-pp.fd_install
      0.09            -0.0        0.08        perf-profile.children.cycles-pp.filp_flush
      0.07            -0.0        0.06        perf-profile.children.cycles-pp.rcu_segcblist_enqueue
      0.13            -0.0        0.12        perf-profile.children.cycles-pp.rseq_update_cpu_node_id
      0.10            -0.0        0.09        perf-profile.children.cycles-pp.security_file_release
      0.08            -0.0        0.07        perf-profile.children.cycles-pp.netdev_core_pick_tx
      0.08            -0.0        0.07        perf-profile.children.cycles-pp.rb_erase
      0.06            -0.0        0.05        perf-profile.children.cycles-pp._raw_read_lock_bh
      0.06            -0.0        0.05        perf-profile.children.cycles-pp.calc_wheel_index
      0.06            -0.0        0.05        perf-profile.children.cycles-pp.hrtimer_active
      0.06            -0.0        0.05        perf-profile.children.cycles-pp.up_write
      0.05            +0.0        0.06        perf-profile.children.cycles-pp.make_kuid
      0.07            +0.0        0.08        perf-profile.children.cycles-pp.inet_sendmsg
      0.07            +0.0        0.08        perf-profile.children.cycles-pp.place_entity
      0.24            +0.0        0.25        perf-profile.children.cycles-pp.__dequeue_entity
      0.12 ±  4%      +0.0        0.13        perf-profile.children.cycles-pp.update_irq_load_avg
      0.45            +0.0        0.47        perf-profile.children.cycles-pp.set_next_entity
      0.05 ±  8%      +0.0        0.07        perf-profile.children.cycles-pp.rb_next
      0.07            +0.0        0.09        perf-profile.children.cycles-pp.woken_wake_function
      0.28 ±  3%      +0.0        0.30        perf-profile.children.cycles-pp.reweight_entity
      1.23 ±  2%      +0.0        1.26        perf-profile.children.cycles-pp.tcp_v4_send_synack
      0.19 ±  3%      +0.0        0.22 ±  3%  perf-profile.children.cycles-pp.move_addr_to_user
      0.21 ±  2%      +0.1        0.26 ±  3%  perf-profile.children.cycles-pp.ipv4_default_advmss
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.cookie_v4_check
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.tcp_try_fastopen
      0.10 ±  3%      +0.1        0.18 ±  2%  perf-profile.children.cycles-pp.tcp_syn_options
      0.18 ±  2%      +0.1        0.30        perf-profile.children.cycles-pp.tcp_openreq_init_rwin
      0.16 ±  2%      +0.1        0.30        perf-profile.children.cycles-pp.secure_tcp_ts_off
      5.20            +0.2        5.36        perf-profile.children.cycles-pp.tcp_rcv_established
      0.08 ±  5%      +0.2        0.25        perf-profile.children.cycles-pp.tcp_ca_openreq_child
      0.70 ±  3%      +0.2        0.88 ±  6%  perf-profile.children.cycles-pp.tcp_v4_send_reset
      0.29 ±  2%      +0.2        0.47 ±  2%  perf-profile.children.cycles-pp.__tcp_select_window
      0.67 ±  3%      +0.2        0.85 ±  5%  perf-profile.children.cycles-pp.ip_send_unicast_reply
      0.15 ±  3%      +0.2        0.34 ±  3%  perf-profile.children.cycles-pp.tcp_mtup_init
      0.35 ±  2%      +0.2        0.54 ±  2%  perf-profile.children.cycles-pp.tcp_connect_init
      0.34            +0.2        0.56        perf-profile.children.cycles-pp.tcp_parse_options
      0.12 ±  4%      +0.2        0.34 ±  2%  perf-profile.children.cycles-pp.tcp_skb_entail
      4.41            +0.3        4.66        perf-profile.children.cycles-pp.tcp_child_process
      0.13 ±  2%      +0.3        0.39 ±  2%  perf-profile.children.cycles-pp.__tcp_ack_snd_check
      0.36            +0.3        0.62        perf-profile.children.cycles-pp.tcp_init_sock
      0.36            +0.3        0.63        perf-profile.children.cycles-pp.tcp_v4_init_sock
      0.38            +0.3        0.66        perf-profile.children.cycles-pp.ip_route_output_key_hash
      0.10 ±  3%      +0.3        0.41        perf-profile.children.cycles-pp.tcp_select_initial_window
      0.14 ±  3%      +0.4        0.54 ±  2%  perf-profile.children.cycles-pp.tcp_rack_update_reo_wnd
      0.14 ±  3%      +0.4        0.54        perf-profile.children.cycles-pp.tcp_assign_congestion_control
     35.91            +0.5       36.41        perf-profile.children.cycles-pp.__dev_queue_xmit
      3.36 ±  2%      +0.5        3.87        perf-profile.children.cycles-pp.tcp_check_req
      2.82 ±  2%      +0.5        3.34        perf-profile.children.cycles-pp.tcp_v4_syn_recv_sock
      1.73 ±  4%      +0.6        2.29 ±  3%  perf-profile.children.cycles-pp.tcp_finish_connect
      4.49            +0.6        5.05        perf-profile.children.cycles-pp.tcp_ack
      0.39 ±  2%      +0.6        1.00 ±  3%  perf-profile.children.cycles-pp.inet_csk_route_req
      0.42            +0.6        1.07 ±  2%  perf-profile.children.cycles-pp.inet_csk_route_child_sock
     93.66            +0.8       94.43        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.08 ±  4%      +0.8        0.89 ±  3%  perf-profile.children.cycles-pp.inet_sk_rebuild_header
     93.12            +0.8       93.93        perf-profile.children.cycles-pp.do_syscall_64
      0.21 ±  3%      +0.9        1.12 ±  2%  perf-profile.children.cycles-pp.tcp_tso_segs
      3.25 ±  2%      +0.9        4.18        perf-profile.children.cycles-pp.tcp_conn_request
     35.94            +0.9       36.87        perf-profile.children.cycles-pp.__local_bh_enable_ip
     35.88            +0.9       36.81        perf-profile.children.cycles-pp.handle_softirqs
     35.39            +1.0       36.38        perf-profile.children.cycles-pp.do_softirq
      8.51            +1.0        9.55        perf-profile.children.cycles-pp.tcp_connect
      0.22 ±  2%      +1.0        1.26        perf-profile.children.cycles-pp.tcp_update_pacing_rate
      3.26 ±  5%      +1.1        4.32 ±  3%  perf-profile.children.cycles-pp.tcp_init_transfer
     26.05            +1.1       27.14        perf-profile.children.cycles-pp.__tcp_push_pending_frames
     25.91            +1.1       27.03        perf-profile.children.cycles-pp.tcp_write_xmit
      0.28 ±  3%      +1.1        1.42 ±  3%  perf-profile.children.cycles-pp.__mkroute_output
     28.56            +1.2       29.77        perf-profile.children.cycles-pp.tcp_rcv_state_process
     33.80            +1.2       35.03        perf-profile.children.cycles-pp.net_rx_action
     33.28            +1.2       34.52        perf-profile.children.cycles-pp.__napi_poll
     33.16            +1.2       34.41        perf-profile.children.cycles-pp.process_backlog
     23.48 ±  2%      +1.3       24.75        perf-profile.children.cycles-pp.accept_connection
     23.48 ±  2%      +1.3       24.75        perf-profile.children.cycles-pp.accept_connections
     23.48 ±  2%      +1.3       24.75        perf-profile.children.cycles-pp.process_requests
     23.48 ±  2%      +1.3       24.75        perf-profile.children.cycles-pp.spawn_child
      1.04 ±  2%      +1.3        2.31 ±  2%  perf-profile.children.cycles-pp.ip_route_output_key_hash_rcu
      0.22 ±  4%      +1.3        1.51 ±  3%  perf-profile.children.cycles-pp.__ip_dev_find
     32.47            +1.3       33.76        perf-profile.children.cycles-pp.__netif_receive_skb_one_core
     21.77            +1.4       23.13        perf-profile.children.cycles-pp.__release_sock
     13.60            +1.4       14.98        perf-profile.children.cycles-pp.tcp_sendmsg_locked
     29.96            +1.5       31.41        perf-profile.children.cycles-pp.ip_local_deliver_finish
     29.86            +1.5       31.32        perf-profile.children.cycles-pp.ip_protocol_deliver_rcu
     13.41            +1.5       14.94        perf-profile.children.cycles-pp.tcp_rcv_synsent_state_process
     29.16            +1.6       30.72        perf-profile.children.cycles-pp.tcp_v4_rcv
     16.98 ±  2%      +1.6       18.58        perf-profile.children.cycles-pp.recv_omni
     11.04            +1.6       12.66        perf-profile.children.cycles-pp.tcp_v4_connect
     40.95            +1.8       42.76        perf-profile.children.cycles-pp.__tcp_transmit_skb
     38.14            +2.0       40.12        perf-profile.children.cycles-pp.__ip_queue_xmit
     18.54            +2.0       20.51        perf-profile.children.cycles-pp.release_sock
     21.38            +2.0       23.39        perf-profile.children.cycles-pp.__send
     20.23            +2.0       22.28        perf-profile.children.cycles-pp.__sys_sendto
     19.87            +2.1       21.92        perf-profile.children.cycles-pp.tcp_sendmsg
     20.31            +2.1       22.37        perf-profile.children.cycles-pp.__x64_sys_sendto
      1.12            +2.1        3.21 ±  2%  perf-profile.children.cycles-pp.ip_route_output_flow
     36.77            +2.9       39.63        perf-profile.children.cycles-pp.tcp_v4_do_rcv
     26.84            +3.0       29.84        perf-profile.children.cycles-pp.connect
     26.16            +3.1       29.21        perf-profile.children.cycles-pp.__x64_sys_connect
     26.11            +3.1       29.17        perf-profile.children.cycles-pp.__sys_connect
     25.91            +3.1       28.99        perf-profile.children.cycles-pp.inet_stream_connect
     25.78            +3.1       28.87        perf-profile.children.cycles-pp.__inet_stream_connect
      0.28 ±  2%      +3.2        3.51 ±  3%  perf-profile.children.cycles-pp.__sk_dst_check
      0.15 ±  4%      +3.9        4.06 ±  3%  perf-profile.children.cycles-pp.ipv4_dst_check
      2.96 ±  3%      -0.8        2.12        perf-profile.self.cycles-pp._raw_spin_lock_bh
      1.31 ±  4%      -0.6        0.68        perf-profile.self.cycles-pp.__sk_destruct
      2.68 ± 10%      -0.6        2.09 ±  6%  perf-profile.self.cycles-pp.__tcp_get_metrics
      0.71 ±  4%      -0.3        0.37        perf-profile.self.cycles-pp.sk_alloc
      0.71 ±  4%      -0.3        0.41        perf-profile.self.cycles-pp.sk_clone_lock
      0.74            -0.2        0.49        perf-profile.self.cycles-pp.__tcp_close
      1.81            -0.2        1.57        perf-profile.self.cycles-pp.__tcp_transmit_skb
      1.77            -0.2        1.53        perf-profile.self.cycles-pp.kmem_cache_free
      1.49            -0.2        1.28        perf-profile.self.cycles-pp._raw_spin_lock
      1.04            -0.2        0.84        perf-profile.self.cycles-pp.tcp_ack
      0.76 ±  2%      -0.2        0.58 ±  2%  perf-profile.self.cycles-pp.ip_finish_output2
      1.12            -0.2        0.95        perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      1.36            -0.2        1.20        perf-profile.self.cycles-pp.clear_bhb_loop
      0.76            -0.1        0.63        perf-profile.self.cycles-pp.__dev_queue_xmit
      0.37            -0.1        0.24 ±  3%  perf-profile.self.cycles-pp.tcp_schedule_loss_probe
      0.38 ±  5%      -0.1        0.27 ±  3%  perf-profile.self.cycles-pp.fib_table_lookup
      0.60            -0.1        0.49        perf-profile.self.cycles-pp.tcp_clean_rtx_queue
      0.55            -0.1        0.45        perf-profile.self.cycles-pp.kmem_cache_alloc_noprof
      0.50            -0.1        0.40        perf-profile.self.cycles-pp.loopback_xmit
      0.71            -0.1        0.61        perf-profile.self.cycles-pp.__memcg_slab_post_alloc_hook
      0.87            -0.1        0.77        perf-profile.self.cycles-pp.kmem_cache_alloc_node_noprof
      0.57            -0.1        0.48        perf-profile.self.cycles-pp.ip_rcv_core
      0.84            -0.1        0.75        perf-profile.self.cycles-pp.__inet_lookup_established
      0.69 ±  2%      -0.1        0.61        perf-profile.self.cycles-pp.inet_bind_conflict
      0.60            -0.1        0.52        perf-profile.self.cycles-pp.mod_objcg_state
      0.45            -0.1        0.37        perf-profile.self.cycles-pp.handle_softirqs
      0.44 ±  3%      -0.1        0.36        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      0.26            -0.1        0.19        perf-profile.self.cycles-pp.tcp_options_write
      0.37            -0.1        0.30        perf-profile.self.cycles-pp.skb_release_data
      0.46            -0.1        0.39        perf-profile.self.cycles-pp.fdget
      0.45 ±  3%      -0.1        0.38 ±  4%  perf-profile.self.cycles-pp.update_curr
      0.57            -0.1        0.50        perf-profile.self.cycles-pp.__alloc_skb
      0.27            -0.1        0.21 ±  3%  perf-profile.self.cycles-pp.ipv4_mtu
      0.36 ±  2%      -0.1        0.30        perf-profile.self.cycles-pp._copy_from_user
      0.36            -0.1        0.30        perf-profile.self.cycles-pp.__mod_timer
      0.46 ±  2%      -0.1        0.40        perf-profile.self.cycles-pp.native_sched_clock
      0.20 ±  3%      -0.1        0.14        perf-profile.self.cycles-pp.__inet_bhash2_update_saddr
      0.43            -0.1        0.37        perf-profile.self.cycles-pp.tcp_sendmsg_locked
      0.60            -0.1        0.54        perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.34            -0.1        0.28        perf-profile.self.cycles-pp.ip_protocol_deliver_rcu
      0.33            -0.1        0.27        perf-profile.self.cycles-pp.dst_release
      0.18 ±  2%      -0.1        0.12 ±  4%  perf-profile.self.cycles-pp.inet_csk_get_port
      0.21            -0.1        0.16 ±  3%  perf-profile.self.cycles-pp.tcp_validate_incoming
      0.32            -0.1        0.27        perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.44            -0.1        0.38        perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.54            -0.1        0.49        perf-profile.self.cycles-pp.__local_bh_enable_ip
      0.35 ±  2%      -0.1        0.30        perf-profile.self.cycles-pp.update_load_avg
      0.28 ±  3%      -0.1        0.22 ±  2%  perf-profile.self.cycles-pp.netif_skb_features
      0.26            -0.1        0.21        perf-profile.self.cycles-pp.tcp_set_state
      0.49            -0.0        0.44        perf-profile.self.cycles-pp.__memcg_slab_free_hook
      0.32            -0.0        0.27        perf-profile.self.cycles-pp.inet_ehashfn
      0.18 ±  2%      -0.0        0.13 ±  2%  perf-profile.self.cycles-pp.dequeue_entities
      0.14            -0.0        0.09 ±  4%  perf-profile.self.cycles-pp.__copy_skb_header
      0.47            -0.0        0.42        perf-profile.self.cycles-pp.do_syscall_64
      0.33            -0.0        0.28 ±  2%  perf-profile.self.cycles-pp.ip_skb_dst_mtu
      0.49 ±  5%      -0.0        0.44 ±  6%  perf-profile.self.cycles-pp.__schedule
      0.32            -0.0        0.27        perf-profile.self.cycles-pp.send_omni_inner
      0.18 ±  2%      -0.0        0.14 ±  2%  perf-profile.self.cycles-pp.dequeue_entity
      0.27            -0.0        0.22 ±  2%  perf-profile.self.cycles-pp.do_softirq
      0.31            -0.0        0.26        perf-profile.self.cycles-pp.tcp_recvmsg_locked
      0.18 ±  2%      -0.0        0.14        perf-profile.self.cycles-pp.__hrtimer_init
      0.68 ±  2%      -0.0        0.64        perf-profile.self.cycles-pp.switch_mm_irqs_off
      0.27 ±  2%      -0.0        0.22 ±  2%  perf-profile.self.cycles-pp.kmem_cache_alloc_lru_noprof
      0.22 ±  2%      -0.0        0.17 ±  2%  perf-profile.self.cycles-pp.ip_rcv
      0.19 ±  3%      -0.0        0.15 ±  2%  perf-profile.self.cycles-pp.sk_setup_caps
      0.54            -0.0        0.50        perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.43 ±  3%      -0.0        0.39 ±  5%  perf-profile.self.cycles-pp.ktime_get
      0.35            -0.0        0.31        perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.26            -0.0        0.22 ±  2%  perf-profile.self.cycles-pp._raw_spin_unlock_irqrestore
      0.26            -0.0        0.22        perf-profile.self.cycles-pp.mem_cgroup_uncharge_skmem
      0.16            -0.0        0.12        perf-profile.self.cycles-pp.tcp_get_metrics
      0.13            -0.0        0.09        perf-profile.self.cycles-pp.vruntime_eligible
      0.24            -0.0        0.20        perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.24 ±  2%      -0.0        0.20 ±  5%  perf-profile.self.cycles-pp.raw_local_deliver
      0.11 ±  3%      -0.0        0.07        perf-profile.self.cycles-pp.tcp_check_req
      0.14 ±  2%      -0.0        0.10        perf-profile.self.cycles-pp.ip_route_output_flow
      0.16 ±  3%      -0.0        0.12 ±  3%  perf-profile.self.cycles-pp.tcp_newly_delivered
      0.24            -0.0        0.20 ±  2%  perf-profile.self.cycles-pp.tcp_event_new_data_sent
      0.37            -0.0        0.33        perf-profile.self.cycles-pp.__cond_resched
      0.20            -0.0        0.16 ±  3%  perf-profile.self.cycles-pp.tcp_established_options
      0.28            -0.0        0.25        perf-profile.self.cycles-pp.__update_load_avg_se
      0.14 ±  3%      -0.0        0.11 ±  3%  perf-profile.self.cycles-pp.tcp_sync_mss
      0.18 ±  2%      -0.0        0.14 ±  2%  perf-profile.self.cycles-pp.tcp_ack_update_rtt
      0.19 ±  2%      -0.0        0.16        perf-profile.self.cycles-pp.__call_rcu_common
      0.14 ±  2%      -0.0        0.11 ±  3%  perf-profile.self.cycles-pp.__tcp_push_pending_frames
      0.09 ±  4%      -0.0        0.06 ±  9%  perf-profile.self.cycles-pp.xfrm_lookup_with_ifid
      0.17 ±  2%      -0.0        0.14 ±  2%  perf-profile.self.cycles-pp.__inet_check_established
      0.25 ±  2%      -0.0        0.22 ±  2%  perf-profile.self.cycles-pp.__ip_local_out
      0.12 ±  6%      -0.0        0.09        perf-profile.self.cycles-pp.ip_finish_output
      0.19            -0.0        0.16 ±  2%  perf-profile.self.cycles-pp.irqtime_account_irq
      0.24            -0.0        0.21 ±  3%  perf-profile.self.cycles-pp.memset_orig
      0.12 ±  6%      -0.0        0.08 ±  4%  perf-profile.self.cycles-pp.select_task_rq_fair
      0.21 ±  3%      -0.0        0.18 ±  2%  perf-profile.self.cycles-pp.tcp_send_fin
      0.24            -0.0        0.21        perf-profile.self.cycles-pp.tcp_wfree
      0.13 ±  2%      -0.0        0.10 ±  5%  perf-profile.self.cycles-pp.neigh_hh_output
      0.25 ±  2%      -0.0        0.22        perf-profile.self.cycles-pp.pick_eevdf
      0.74            -0.0        0.70        perf-profile.self.cycles-pp.__netif_receive_skb_core
      0.19 ±  2%      -0.0        0.16 ±  2%  perf-profile.self.cycles-pp.tcp_rcv_established
      0.20 ±  2%      -0.0        0.17 ±  2%  perf-profile.self.cycles-pp.lock_timer_base
      0.22 ±  2%      -0.0        0.19 ±  2%  perf-profile.self.cycles-pp.__check_object_size
      0.18 ±  2%      -0.0        0.15 ±  3%  perf-profile.self.cycles-pp.recv
      0.20 ±  2%      -0.0        0.17 ±  2%  perf-profile.self.cycles-pp.skb_network_protocol
      0.18            -0.0        0.15        perf-profile.self.cycles-pp.tcp_check_space
      0.10            -0.0        0.07        perf-profile.self.cycles-pp.__x64_sys_close
      0.10            -0.0        0.07        perf-profile.self.cycles-pp.tcp_chrono_stop
      0.13 ±  5%      -0.0        0.10 ±  6%  perf-profile.self.cycles-pp.eth_type_trans
      0.27            -0.0        0.24        perf-profile.self.cycles-pp.obj_cgroup_charge
      0.18 ±  2%      -0.0        0.16 ±  3%  perf-profile.self.cycles-pp.rcu_all_qs
      0.07            -0.0        0.04 ± 44%  perf-profile.self.cycles-pp.__d_alloc
      0.14 ±  2%      -0.0        0.11        perf-profile.self.cycles-pp.sk_reset_timer
      0.06 ±  6%      -0.0        0.03 ± 70%  perf-profile.self.cycles-pp.skb_free_head
      0.22            -0.0        0.19        perf-profile.self.cycles-pp.dev_hard_start_xmit
      0.22 ±  3%      -0.0        0.19        perf-profile.self.cycles-pp.inet_create
      0.19            -0.0        0.16        perf-profile.self.cycles-pp.kfree_skbmem
      0.31            -0.0        0.28        perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.20            -0.0        0.17 ±  2%  perf-profile.self.cycles-pp.__sys_recvfrom
      0.11 ±  3%      -0.0        0.08 ±  5%  perf-profile.self.cycles-pp.qdisc_pkt_len_init
      0.11 ±  5%      -0.0        0.08 ±  5%  perf-profile.self.cycles-pp.sk_stop_timer
      0.09 ±  4%      -0.0        0.06 ±  7%  perf-profile.self.cycles-pp.skb_push
      0.20 ±  5%      -0.0        0.17 ±  6%  perf-profile.self.cycles-pp.try_to_wake_up
      0.06            -0.0        0.03 ± 70%  perf-profile.self.cycles-pp._raw_read_lock_bh
      0.13 ±  3%      -0.0        0.10        perf-profile.self.cycles-pp.tcp_current_mss
      0.25            -0.0        0.22 ±  2%  perf-profile.self.cycles-pp.__switch_to_asm
      0.16 ±  2%      -0.0        0.14 ±  3%  perf-profile.self.cycles-pp.skb_release_head_state
      0.14 ±  2%      -0.0        0.11 ±  4%  perf-profile.self.cycles-pp.__sk_mem_raise_allocated
      0.14 ±  2%      -0.0        0.11 ±  4%  perf-profile.self.cycles-pp.bpf_skops_write_hdr_opt
      0.15 ±  5%      -0.0        0.12 ±  7%  perf-profile.self.cycles-pp.recv_data
      0.14 ±  3%      -0.0        0.11        perf-profile.self.cycles-pp.sk_free
      0.15            -0.0        0.12 ±  4%  perf-profile.self.cycles-pp.__enqueue_entity
      0.20            -0.0        0.18 ±  2%  perf-profile.self.cycles-pp._copy_to_iter
      0.13 ±  2%      -0.0        0.10 ±  4%  perf-profile.self.cycles-pp.kmalloc_reserve
      0.12 ±  4%      -0.0        0.10        perf-profile.self.cycles-pp.timer_delete
      0.34 ±  2%      -0.0        0.31 ±  3%  perf-profile.self.cycles-pp.restore_fpregs_from_fpstate
      0.13 ±  3%      -0.0        0.10 ±  4%  perf-profile.self.cycles-pp.__ip_finish_output
      0.14 ±  3%      -0.0        0.12        perf-profile.self.cycles-pp.tcp_queue_rcv
      0.15 ±  2%      -0.0        0.12 ±  4%  perf-profile.self.cycles-pp.tcp_urg
      0.15 ±  3%      -0.0        0.12 ±  3%  perf-profile.self.cycles-pp.kfree
      0.08 ±  5%      -0.0        0.06        perf-profile.self.cycles-pp.siphash_1u64
      0.09 ±  4%      -0.0        0.06 ±  7%  perf-profile.self.cycles-pp.sk_getsockopt
      0.16 ±  3%      -0.0        0.13 ±  3%  perf-profile.self.cycles-pp.pick_next_task_fair
      0.20            -0.0        0.18 ±  2%  perf-profile.self.cycles-pp.refill_obj_stock
      0.16 ±  3%      -0.0        0.14 ±  3%  perf-profile.self.cycles-pp.enqueue_task_fair
      0.08 ±  5%      -0.0        0.06 ±  7%  perf-profile.self.cycles-pp.siphash_3u32
      0.15 ±  4%      -0.0        0.13        perf-profile.self.cycles-pp.tcp_rtt_estimator
      0.08 ±  5%      -0.0        0.06 ±  6%  perf-profile.self.cycles-pp.xas_load
      0.17            -0.0        0.15        perf-profile.self.cycles-pp.__skb_clone
      0.14            -0.0        0.12        perf-profile.self.cycles-pp.create_data_socket
      0.58            -0.0        0.56        perf-profile.self.cycles-pp.read_tsc
      0.08            -0.0        0.06        perf-profile.self.cycles-pp.get_random_u32
      0.08            -0.0        0.06        perf-profile.self.cycles-pp.getsockopt
      0.07            -0.0        0.05        perf-profile.self.cycles-pp.get_random_u16
      0.07            -0.0        0.05        perf-profile.self.cycles-pp.recv@plt
      0.12 ±  3%      -0.0        0.10 ±  3%  perf-profile.self.cycles-pp.__close
      0.09 ±  5%      -0.0        0.07 ±  6%  perf-profile.self.cycles-pp.__sock_wfree
      0.09 ±  4%      -0.0        0.07 ±  5%  perf-profile.self.cycles-pp.__xfrm_policy_check2
      0.11            -0.0        0.09        perf-profile.self.cycles-pp.ip_output
      0.21 ±  2%      -0.0        0.19 ±  2%  perf-profile.self.cycles-pp.ip_send_check
      0.13 ±  2%      -0.0        0.11 ±  4%  perf-profile.self.cycles-pp.inet_unhash
      0.10            -0.0        0.08 ±  4%  perf-profile.self.cycles-pp.rb_first
      0.10            -0.0        0.08 ±  4%  perf-profile.self.cycles-pp.sk_setsockopt
      0.14 ±  2%      -0.0        0.12        perf-profile.self.cycles-pp.__memcpy
      0.09            -0.0        0.07 ±  5%  perf-profile.self.cycles-pp.__srcu_read_lock
      0.08 ±  4%      -0.0        0.06        perf-profile.self.cycles-pp.enqueue_task
      0.08 ±  4%      -0.0        0.06        perf-profile.self.cycles-pp.inet_csk_destroy_sock
      0.08 ±  4%      -0.0        0.06        perf-profile.self.cycles-pp.skb_clone
      0.08            -0.0        0.06 ±  6%  perf-profile.self.cycles-pp.tcp_close
      0.13            -0.0        0.11 ±  3%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode_prepare
      0.09 ±  4%      -0.0        0.07        perf-profile.self.cycles-pp.xa_destroy
      0.15 ±  3%      -0.0        0.13 ±  2%  perf-profile.self.cycles-pp.lock_sock_nested
      0.16 ±  2%      -0.0        0.14 ±  3%  perf-profile.self.cycles-pp.os_xsave
      0.14 ±  3%      -0.0        0.12        perf-profile.self.cycles-pp.tcp_ack_update_window
      0.10 ±  3%      -0.0        0.08 ±  4%  perf-profile.self.cycles-pp.chacha_permute
      0.10 ±  3%      -0.0        0.08 ±  4%  perf-profile.self.cycles-pp.inet_lhash2_lookup
      0.09 ±  4%      -0.0        0.08 ±  6%  perf-profile.self.cycles-pp.tcp_v4_destroy_sock
      0.08 ±  5%      -0.0        0.07 ±  5%  perf-profile.self.cycles-pp.dequeue_task_fair
      0.16 ±  3%      -0.0        0.15 ±  2%  perf-profile.self.cycles-pp.sk_filter_trim_cap
      0.08            -0.0        0.06 ±  7%  perf-profile.self.cycles-pp.tcp_rate_gen
      0.19            -0.0        0.17 ±  2%  perf-profile.self.cycles-pp.update_min_vruntime
      0.07 ±  7%      -0.0        0.05        perf-profile.self.cycles-pp.init_timer_key
      0.07 ±  7%      -0.0        0.05        perf-profile.self.cycles-pp.tcp_openreq_init_rwin
      0.12 ±  4%      -0.0        0.10 ±  3%  perf-profile.self.cycles-pp.tcp_create_openreq_child
      0.16 ±  3%      -0.0        0.14        perf-profile.self.cycles-pp.tcp_make_synack
      0.13 ±  2%      -0.0        0.12 ±  4%  perf-profile.self.cycles-pp.enqueue_timer
      0.10            -0.0        0.08 ±  5%  perf-profile.self.cycles-pp.obj_cgroup_uncharge_pages
      0.08 ±  5%      -0.0        0.07        perf-profile.self.cycles-pp.__sk_free
      0.09 ±  4%      -0.0        0.08 ±  6%  perf-profile.self.cycles-pp.schedule
      0.09 ±  5%      -0.0        0.08 ±  4%  perf-profile.self.cycles-pp.sk_wait_data
      0.12            -0.0        0.10 ±  4%  perf-profile.self.cycles-pp.tcp_update_skb_after_send
      0.07 ±  7%      -0.0        0.05 ±  7%  perf-profile.self.cycles-pp.truncate_inode_pages_final
      0.15 ±  3%      -0.0        0.13 ±  2%  perf-profile.self.cycles-pp.tcp_v4_connect
      0.12 ±  4%      -0.0        0.10        perf-profile.self.cycles-pp.__send
      0.29            -0.0        0.27        perf-profile.self.cycles-pp.validate_xmit_skb
      0.17            -0.0        0.16 ±  3%  perf-profile.self.cycles-pp.__virt_addr_valid
      0.19            -0.0        0.18 ±  2%  perf-profile.self.cycles-pp.entry_SYSCALL_64
      0.07            -0.0        0.06 ±  8%  perf-profile.self.cycles-pp.tcp_push
      0.14            -0.0        0.13 ±  3%  perf-profile.self.cycles-pp.__get_user_8
      0.08 ±  5%      -0.0        0.07        perf-profile.self.cycles-pp.__inet_lookup_listener
      0.12 ±  4%      -0.0        0.10 ±  3%  perf-profile.self.cycles-pp.wait_woken
      0.10            -0.0        0.09 ±  4%  perf-profile.self.cycles-pp.check_preempt_wakeup_fair
      0.10            -0.0        0.09 ±  4%  perf-profile.self.cycles-pp.ip_local_deliver_finish
      0.14            -0.0        0.13 ±  2%  perf-profile.self.cycles-pp.tcp_rearm_rto
      0.07            -0.0        0.06 ±  6%  perf-profile.self.cycles-pp.__kfree_skb
      0.09 ±  4%      -0.0        0.08        perf-profile.self.cycles-pp.__refill_stock
      0.07 ±  5%      -0.0        0.06        perf-profile.self.cycles-pp.alloc_file_pseudo
      0.12            -0.0        0.11 ±  3%  perf-profile.self.cycles-pp.__release_sock
      0.16            -0.0        0.15 ±  2%  perf-profile.self.cycles-pp.tcp_inbound_hash
      0.06 ±  6%      -0.0        0.05        perf-profile.self.cycles-pp.tcp_sndbuf_expand
      0.09            -0.0        0.08        perf-profile.self.cycles-pp.__skb_datagram_iter
      0.07            -0.0        0.06        perf-profile.self.cycles-pp._raw_write_lock_bh
      0.07            -0.0        0.06        perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.09            -0.0        0.08        perf-profile.self.cycles-pp.schedule_timeout
      0.07            -0.0        0.06        perf-profile.self.cycles-pp.security_inode_alloc
      0.07            -0.0        0.06        perf-profile.self.cycles-pp.skb_clone_tx_timestamp
      0.07            -0.0        0.06        perf-profile.self.cycles-pp.sock_alloc
      0.07            -0.0        0.06        perf-profile.self.cycles-pp.switch_fpu_return
      0.12            -0.0        0.11        perf-profile.self.cycles-pp.__build_skb_around
      0.08            -0.0        0.07        perf-profile.self.cycles-pp.init_file
      0.08            -0.0        0.07        perf-profile.self.cycles-pp.sched_clock_cpu
      0.08            -0.0        0.07        perf-profile.self.cycles-pp.sock_rfree
      0.08            -0.0        0.07        perf-profile.self.cycles-pp.tcp_recvmsg
      0.12            -0.0        0.11        perf-profile.self.cycles-pp.update_rq_clock_task
      0.06            -0.0        0.05        perf-profile.self.cycles-pp.___slab_alloc
      0.06            -0.0        0.05        perf-profile.self.cycles-pp.cubictcp_cong_avoid
      0.06            -0.0        0.05        perf-profile.self.cycles-pp.disconnect_data_socket
      0.06            -0.0        0.05        perf-profile.self.cycles-pp.inet_csk_clone_lock
      0.06            -0.0        0.05        perf-profile.self.cycles-pp.ip_local_out
      0.06            -0.0        0.05        perf-profile.self.cycles-pp.netdev_core_pick_tx
      0.11            -0.0        0.10        perf-profile.self.cycles-pp.tcp_rate_skb_sent
      0.05            +0.0        0.06        perf-profile.self.cycles-pp.inet_sendmsg
      0.05            +0.0        0.06        perf-profile.self.cycles-pp.sock_close
      0.07            +0.0        0.09 ±  5%  perf-profile.self.cycles-pp.woken_wake_function
      0.21 ±  2%      +0.0        0.23 ±  2%  perf-profile.self.cycles-pp.x64_sys_call
      0.05            +0.0        0.07        perf-profile.self.cycles-pp.__dentry_kill
      0.22 ±  5%      +0.0        0.24 ±  2%  perf-profile.self.cycles-pp.recv_omni
      0.02 ± 99%      +0.0        0.06        perf-profile.self.cycles-pp.__rseq_handle_notify_resume
      0.20 ±  3%      +0.0        0.25 ±  2%  perf-profile.self.cycles-pp.ipv4_default_advmss
      1.04            +0.0        1.08        perf-profile.self.cycles-pp.tcp_v4_rcv
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.place_entity
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.cookie_v4_check
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.rb_next
      0.00            +0.1        0.06        perf-profile.self.cycles-pp.tcp_try_fastopen
      0.13            +0.1        0.19 ±  2%  perf-profile.self.cycles-pp.tcp_connect_init
      0.00            +0.1        0.07        perf-profile.self.cycles-pp.put_prev_entity
      0.05            +0.1        0.13 ±  3%  perf-profile.self.cycles-pp.tcp_syn_options
      0.30 ±  3%      +0.1        0.38 ±  2%  perf-profile.self.cycles-pp.ip_route_output_key_hash_rcu
      0.10 ±  3%      +0.1        0.19 ±  3%  perf-profile.self.cycles-pp.tcp_init_sock
      0.07            +0.1        0.16 ±  2%  perf-profile.self.cycles-pp.tcp_fin
      0.16 ±  2%      +0.1        0.29 ±  2%  perf-profile.self.cycles-pp.tcp_init_transfer
      0.08 ±  6%      +0.2        0.24 ±  2%  perf-profile.self.cycles-pp.secure_tcp_ts_off
      0.14 ±  3%      +0.2        0.32        perf-profile.self.cycles-pp.__inet_bind
      0.28 ±  2%      +0.2        0.46 ±  2%  perf-profile.self.cycles-pp.__tcp_select_window
      0.15 ±  2%      +0.2        0.33 ±  2%  perf-profile.self.cycles-pp.tcp_mtup_init
      0.07 ±  6%      +0.2        0.26 ±  2%  perf-profile.self.cycles-pp.tcp_v4_send_synack
      0.12 ±  4%      +0.2        0.32 ±  2%  perf-profile.self.cycles-pp.tcp_v4_syn_recv_sock
      0.10 ±  4%      +0.2        0.32 ±  2%  perf-profile.self.cycles-pp.tcp_skb_entail
      0.34 ±  2%      +0.2        0.55        perf-profile.self.cycles-pp.tcp_parse_options
      0.24            +0.2        0.48 ±  2%  perf-profile.self.cycles-pp.tcp_conn_request
      0.64            +0.2        0.89        perf-profile.self.cycles-pp.tcp_write_xmit
      0.13 ±  3%      +0.3        0.38 ±  3%  perf-profile.self.cycles-pp.__tcp_ack_snd_check
      0.10 ±  3%      +0.3        0.40 ±  2%  perf-profile.self.cycles-pp.tcp_select_initial_window
      0.14 ±  4%      +0.4        0.53 ±  2%  perf-profile.self.cycles-pp.tcp_rack_update_reo_wnd
      0.13 ±  2%      +0.4        0.53 ±  2%  perf-profile.self.cycles-pp.tcp_assign_congestion_control
      1.50 ±  8%      +0.5        1.98 ±  9%  perf-profile.self.cycles-pp.tcp_update_metrics
      1.26 ±  8%      +0.6        1.81 ±  9%  perf-profile.self.cycles-pp.tcp_init_metrics
      0.20 ±  2%      +0.9        1.10 ±  2%  perf-profile.self.cycles-pp.tcp_tso_segs
      0.21 ±  2%      +1.0        1.25        perf-profile.self.cycles-pp.tcp_update_pacing_rate
      0.25 ±  2%      +1.1        1.38 ±  2%  perf-profile.self.cycles-pp.__mkroute_output
      0.17 ±  5%      +1.3        1.47 ±  3%  perf-profile.self.cycles-pp.__ip_dev_find
      0.14 ±  3%      +3.9        4.02 ±  3%  perf-profile.self.cycles-pp.ipv4_dst_check




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

