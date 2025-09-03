Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C3C1684B4;
	Wed,  3 Sep 2025 01:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756863302; cv=fail; b=ajReiV1geFIruZaDzZzqQrKppRyM9Hgr51WalY18iGZO/E7g/PKtUJhTFKWFxpBPw5cYvNAaSLPx8+gV7pBSpQL06aUAC/NsawnIREaEza2MFDd0W4XYIL5JySxMbwtALCUCqcQ3Z7aXnHfUYvOQDPXGzo693tuqDhqHAbj554E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756863302; c=relaxed/simple;
	bh=CYCKOTuZjqYuAShS93VveJaiOLaE5jBH1BDaroKi6KY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CBMxvyCI4RANH12Fy6VYbZT0gJcY1ZRq4pysBaSYw2fRZwslrELnA1IJdsKXPisviQZfGQQ6JyEZKua1XBTDTuhOpEtJC1xqhNS8drxheVAq0DkouxvDYNiVIDZgIw0VUAfyxiLaimc4OZBv3mVLu1StqDXU/LFKJK+/9HqDAZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EkWY5XQ5; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EkWY5XQ5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756863300; x=1788399300;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=CYCKOTuZjqYuAShS93VveJaiOLaE5jBH1BDaroKi6KY=;
  b=EkWY5XQ54d7MYkZMBLQSC/RiYLAOkVUs2q2uKfTRWJZexUrzECJDDlEE
   c1DB4hktOGWHddU13KyWB3aflZdU4F96+zzbVFrHJQwbZIh1+ZcarOWCB
   7B1aX440xLZgUg+NMrELZHw7CY5cVtzllyueMQTNkcYiaEN8PAjGFgXop
   fnAl7OhD1tD1ze4uRf1v9mrXStmHR9V7JTGAxEyLiDZEHZ4Eud5mB+Z28
   yVwrHigxnABb9iEuiMpHpu0ZzwzPVR6Amt559nUdWb/fpypIbdUB1t4JV
   7O+526iTjH0FYEZkMHpY/yRtNxqbLqJACqjr7awCLYCBBeSblBzDDzJqq
   Q==;
X-CSE-ConnectionGUID: MpYbW8JbSKaqP+BSBG51ZA==
X-CSE-MsgGUID: mJhQF160TpyYe/atyPZXBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11541"; a="84586413"
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="84586413"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 18:35:00 -0700
X-CSE-ConnectionGUID: XF2COaJ7TFS/z4HeLK2cdw==
X-CSE-MsgGUID: CDSQL8vpQ2mXBymMcK7Drw==
X-ExtLoop1: 1
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 18:35:00 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 2 Sep 2025 18:34:59 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 2 Sep 2025 18:34:59 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.58)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 2 Sep 2025 18:34:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BMkC+mZfAqIvAFHojdiSe+AksDFjmPhe1Gzt9sa0T/R6CzfwOlMOiUCOBEKKaTuuTqEG/jYgISloopcbyD/x94YbDD2IvYzcv3XzoNeHG7oWPRgcA6SsRJykk2Th5qiCYpiQdlhCRy472VSD0VaZFneUO7ErAJ7cTYgaKaCyXcT/pfMVvXXlS6OVeX2jdxGFBYqWvsF3BjPjFeDl1XrDVMIIRPu0TL+yzFfY6W4ox2F7wC7bxlauiO/j1bE8OE5G0yFpAMe3Obavu/gyxO49COtJJ5HRIq793RUi2qJvkY9hztp++bfN6Qi/ue7yYZ6xiyyCbxy79rwIABN9si2NnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EbPiAIOgx2WM2A5XCwRFTB5DrNM1YM+iUizggqmiJDs=;
 b=A7rWVsYA0VL9yi+X2Z8JxSL2LrsOOprizy8d4wRkOFLbtosSBOTH7X8wOxCC7Zg/mPCjKDkplmg4Cj39r/QCObHKsLZ7mCEGh/DUt5z8vznxi8WznHHvSk9vdIlcAhjauiZFE8TbQRMUrlafbcv9h2WPhZr4HpXAvNMeK4+/RRqbXn8gTnNzYms4Z9APjDdr/T1PUOrfMTZwxAjg7aJmrYj2VgICONpj8Zmj3Redo2sJhneg2YaPLAXMkEpUoN7UfTJ/nYqc5mGl+97hTeRVlKHAeUC7jnUzstKCR09kMA+vk9ebqpokzonDmjfFa3vrMJVyrM31CDfVnh+KF1wgGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DM4PR11MB6094.namprd11.prod.outlook.com (2603:10b6:8:ab::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 01:34:47 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 01:34:47 +0000
Date: Wed, 3 Sep 2025 09:34:38 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Steven Rostedt
	<rostedt@goodmis.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	<linux-trace-kernel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: Re: [paulmck-rcu:dev.2025.08.13a] [tracing]  364ac25d46:
 WARNING:at_arch/x86/mm/fault.c:#do_user_addr_fault
Message-ID: <aLebLoM2OQD+KPxQ@xsang-OptiPlex-9020>
References: <202508211038.c93e8603-lkp@intel.com>
 <68044ea3-32c1-4d72-9bd3-fe2031669d79@paulmck-laptop>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <68044ea3-32c1-4d72-9bd3-fe2031669d79@paulmck-laptop>
X-ClientProxiedBy: SG2PR02CA0110.apcprd02.prod.outlook.com
 (2603:1096:4:92::26) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DM4PR11MB6094:EE_
X-MS-Office365-Filtering-Correlation-Id: f267facd-8767-408c-5c8c-08ddea8a1140
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KuQn8MaS8pu4aOGeNnD9mRpGxFpfIdlAX1SbBdxhxCm9XGS3WSUQjh1KDGa4?=
 =?us-ascii?Q?nls2uBV+MWFFhs8405NvnJ7K351OMgkzb2ffLFlgFaGc5KQ6JHqB2M32FlZq?=
 =?us-ascii?Q?GTovryNAhpeQhJCIfwQaVs4LJtq57sFUMeyHCWDLf81s+U3b4PdQ7euPpm2Z?=
 =?us-ascii?Q?QYjgJg9xYFTupUG1t/Qbd4umslf218lTB+4ZBmyiP1d1qxdwk9ZylzO9HTQu?=
 =?us-ascii?Q?FTb2emUI9QD6jwnhzQGn1fMFr5m4AMHaCjtymQ6mfxpWVCupRPg3DjquQUYv?=
 =?us-ascii?Q?TZBj4xLPa9zpM9hCeiCzTyW+wis/6rh479febqarve9rKow+eyZPexEvRbJq?=
 =?us-ascii?Q?AB2i44WJm61goSzDvKY3txNhVooHyJy+jMZsrliF0xIslLMcElIELLUMiXjW?=
 =?us-ascii?Q?JPAdoo7IVAvqey+k75poyMy4Fpfj9TZ+kE2u3ZGHCptwz2DNMnuMQADqTKoo?=
 =?us-ascii?Q?NJy1kr+PmxnzI3x0l/kVVpMXXsKzkiYUEiw+oH7Vb9qx9ObNaD3hvMb5qeyr?=
 =?us-ascii?Q?VvMdSfWoK5FY+t9oDoejrqLY32cwx6TeUPw0CjANc8jOgIKHCGrdsVx51LoQ?=
 =?us-ascii?Q?jZ122pl8yiQvGgLe/fXJrD1Dr533LpIQyXxb98DLxlxpe5pZ+PL9YgmNglJP?=
 =?us-ascii?Q?w6ri3WaZDKmTCA6qwfCHwIP7N6aWvHJMbrLDq/gLUCgbiq7kRpXVt92+lkTc?=
 =?us-ascii?Q?g5kkZ9ieSWgWYC7B5V3GwLA/KIUn+RgNLEtBZ62uO5UuAd1OHFggdXC8Ev6a?=
 =?us-ascii?Q?LZJ/ptXku8TxOtbR+kRD24Vwb2bSlvjEkWt2NXGDnjN5JD6nkLjKpRygnmOu?=
 =?us-ascii?Q?zt8EL/0ZVcU3Aov+hjbWcPF+GWG5HW9vsaaTSnffLwJRnjhUdgG6oiA7m8S1?=
 =?us-ascii?Q?3HhgJ6k3ZuVZLheqmNtrTZS5BBPTK3i3UzSIUautmDe1Dgk0M8YjjwEsZAYA?=
 =?us-ascii?Q?cg/GXT0MbBKyMimrO1Ql+U/ojmAAO70a4W9fViYOI8Ke/44Sr57F5fcTgcDR?=
 =?us-ascii?Q?Z62qZOx9d4W1RCqoIr45tMOZF5WoqZDuU28FbMFleYy6kPzZcepHQIYGBW3x?=
 =?us-ascii?Q?GynXce/1V0llczBp9nP9EH+rMPVdTfY2RHJmb0yaN3A/L3aJbdG5cXOrW4uO?=
 =?us-ascii?Q?fyT0IsmZxsC62WL0nsbwNTJl3qFEYEzWHYaQRuOsqQQnfJ2iQ7gPUsSOvyoR?=
 =?us-ascii?Q?T02xWWV7i3avjDwLPycz4/OVJMcT5gnEJlJ5N2ZyL3mL2QoK/tSTW0+klrMj?=
 =?us-ascii?Q?XdbN/FJrERMsvytArnd3qEyxOXuizwiWOoN4mzNJgptiSQtJfTT+mcwQAmWm?=
 =?us-ascii?Q?qdHxzQ1z8Ccc819CNg/Q93v0Wi0u/QEElyJFv1umbtGnLAHLvDwq1Rrw8QB9?=
 =?us-ascii?Q?XetN0tKTOkRgXfZD7ewHTkyQQDrS?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Sy3HQQpyi1KLFANpOcV3aantNlxv8BaJcxwgDtrOUBAmcsd9UxnRFAQR6Kq1?=
 =?us-ascii?Q?CZm5lqcPny0txxKWSYLFIFrAv+iiEVS/WwiNJFV2xTJ/G1QpzEvfvGoQLurO?=
 =?us-ascii?Q?60tkwR8eoWCBFxgugJtVIkongULlGRwDmdfsEgsJQqJgVv4oYaqgZAYsrebS?=
 =?us-ascii?Q?KFEIBPt993eWegBdH3QVxpfAfsTqMGCnguNBdQf7g1LlTUTWA4JiVQ8oaEVp?=
 =?us-ascii?Q?dgmO4QBDN7VPbrifwIHQVDvyq998rV2AFna/GOMmsKdVRsztc+vLeuTL6ZHl?=
 =?us-ascii?Q?ylHxPMZ626oCvH74qAHBpNz3hfyDBKgS2uUODO/mPwT8YA3aK+6M5NUPAFAi?=
 =?us-ascii?Q?zUXpXa7CoKf/xj0222YcdJ9Qq+bYQCjJnu21AL/jwFeqqkYe8BK0B8uRfQLM?=
 =?us-ascii?Q?SN1fvEY6xjjPHXNBjsSg8PFuySBSnaM1E0WljCaGnipVLFpbxy+8swG180tj?=
 =?us-ascii?Q?fQSM5BRPKwXLB7sIsY2BejnfCyEVNdiyWwfHuLGPq718QjLRNaQmyuq573mh?=
 =?us-ascii?Q?Is5okNbxDYuhO+WcpWqV3k9d4PM1CNq3E12b/+vg50nGKlYtvXmhb6F1c4Gn?=
 =?us-ascii?Q?ONllm2n5CDRULvDn4CWS5rzsFuFDPLVwDGQJe0MH7cvqna/tPeqZMMQNog1w?=
 =?us-ascii?Q?+h9Ft5TvLMdiOW/nLncnoTIZvCj8+SGSibGeGjApNYz4k/sd/b0H2iLOpzTU?=
 =?us-ascii?Q?/3HSFKzmLwjFu1LJoogTsIDLsXQx6i7B6Z/z4VWduvgJATdDFtrVxRz7b6Wz?=
 =?us-ascii?Q?9RZzPXRIUWgmmCuBjIWl4vInFsDys2k10RciXNFvpWigQBKSFvJwjmS30cqw?=
 =?us-ascii?Q?wmtMyp+Usw4UzUpDpO0skAyo6QgUlZz2ASEf3H3WYhGmeeigW9y4Uh0kLnU6?=
 =?us-ascii?Q?PpV9sQ6fp5A6Ef7mDKr30xCzzHN05cUrb1mHex6hku3D8nZUxviGQdYd+8V8?=
 =?us-ascii?Q?5J+YkojmqUnAALH5yle+28OOnmNOQA/W2JuSqpVWXKpd0nUEwshYAd3eTLD6?=
 =?us-ascii?Q?FRpLGSKOJAom7e58nxz4uoPwZc5DS40NMbkdiR6v/VwVVO4eVNDQiiV9Ayta?=
 =?us-ascii?Q?nik1A1+A5S3bfjsu9ob0eVY38sAI14ZijuiG56cU98EwEb8H3SHxA48UP5my?=
 =?us-ascii?Q?0ZneBKKygfIE55pDIIQ/HLm03vPn1xz2Ku5dQUvIU3pnT9XFEVWoan5tC/iI?=
 =?us-ascii?Q?qp5006TIA+Yf5HXCyH3tFmlZ54zgBkDC07BAEVkXF7SwDx8v9VNLKFr7Uy7H?=
 =?us-ascii?Q?94fBIrQ6efSbgjtTo6b6JWmXnVLljtyLTXaVCJLQ9xB8QATNPMypqy3BRI0U?=
 =?us-ascii?Q?qI+iOrhIRnPNVTIlU9QypcGkoYxW8c8f4JmTwK4EQRjYst2eWnVkahii1Kzo?=
 =?us-ascii?Q?SwkqDijRqaHK5wNEq9GI4rPZlTcjNIy18TuU98lByJRvyuEQo3rwev9LvUu0?=
 =?us-ascii?Q?IOvInWwnbr0OtMxiRiTPHG/iRtwVSKh9dJ15V7mYv9SSmN7DMXTpn7uNRcBk?=
 =?us-ascii?Q?rED0VUeDEFN2AIK9fZuIGrpWB8wFdNO0m4yFrlEO8Khf/eyDtMK1JM1lbrG8?=
 =?us-ascii?Q?IzslI5Iq/ostndVFui1SJwTDuEgXwT5frYdMMrXlu3fb6ALzcGEcgViECVMM?=
 =?us-ascii?Q?Iw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f267facd-8767-408c-5c8c-08ddea8a1140
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 01:34:47.4127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ve7jROmcOfc8DpqgXrsvzBFxOSZh7saY4tgd5ypRQc9d36FQE3fvhivepAQ0qg2tNhrhU9olNBKLAFRIGonrNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6094
X-OriginatorOrg: intel.com

hi, Paul,

On Fri, Aug 29, 2025 at 08:07:41AM -0700, Paul E. McKenney wrote:
> On Thu, Aug 21, 2025 at 01:26:45PM +0800, kernel test robot wrote:
> > 
> > hi, Paul,
> > 
> > we also noticed there is similar commit in newer branch
> >   dev.2025.08.14a
> >   dev.2025.08.19a
> > but we didn't finish any bisect for them so far.
> > 
> > if the issue is already known and fixed in newer version, please just ignore
> > this report. sorry if any inconvenience.
> > 
> > below full report FYI.
> > 
> > 
> > Hello,
> > 
> > kernel test robot noticed "WARNING:at_arch/x86/mm/fault.c:#do_user_addr_fault" on:
> > 
> > commit: 364ac25d46eea504eb90229d2a1f92e18c1a1eae ("tracing: Guard __DECLARE_TRACE() use of __DO_TRACE_CALL() with SRCU-fast")
> > https://git.kernel.org/cgit/linux/kernel/git/paulmck/linux-rcu.git dev.2025.08.13a
> > 
> > in testcase: boot
> > 
> > config: i386-randconfig-004-20250819
> > compiler: clang-20
> > test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 4G
> > 
> > (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> Thank you for your testing efforts, and apologies for being slow!
> 
> Could you please try the diagnostic patch at the end of this email?
> 
> 							Thanx, Paul

by applying the patch, the issue gone. but since you said this is a 'diagnostic
patch', not sure if it's a real fix. anyway:

Tested-by: kernel test robot <oliver.sang@intel.com>


[...]

> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > | Closes: https://lore.kernel.org/oe-lkp/202508211038.c93e8603-lkp@intel.com

[...]

> > The kernel config and materials to reproduce are available at:
> > https://download.01.org/0day-ci/archive/20250821/202508211038.c93e8603-lkp@intel.com
> > -- 
> > 0-DAY CI Kernel Test Service
> > https://github.com/intel/lkp-tests/wiki
> 
> 
> commit 2d6142ce44dca77fb173bb96850634b169277214
> Author: Paul E. McKenney <paulmck@kernel.org>
> Date:   Thu Aug 28 12:56:42 2025 -0700
> 
>     EXP tracing: Diagnostic for __DECLARE_TRACE() use of SRCU-fast
>     
>     This patch is intended to test the theory that preemption needs to be
>     disabled in some portion of the tracing infrastructure extending from
>     the __DECLARE_TRACE() macro to the target BPF program.
>     
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
> index a22c1ab88560b8..c422e4c5ed51ed 100644
> --- a/include/linux/tracepoint.h
> +++ b/include/linux/tracepoint.h
> @@ -273,7 +273,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
>  	static inline void __do_trace_##name(proto)			\
>  	{								\
>  		if (cond) {						\
> -			guard(srcu_fast_notrace)(&tracepoint_srcu);	\
> +			guard(preempt_notrace)();			\
>  			__DO_TRACE_CALL(name, TP_ARGS(args));		\
>  		}							\
>  	}								\
