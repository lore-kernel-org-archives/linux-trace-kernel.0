Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A34E2DF157;
	Thu, 11 Sep 2025 08:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757579040; cv=fail; b=G98JhGQoc9YUUj0EJFAPHuNKRdwHSTn+cBUVG6tHZq/4vd7+iNNyXzy7dwaI2cgugVAZCCWmex4CgB/sNU17XL6Meu9UPvy2WTvyonhGJO638/CJ3gvOzQ5VOExsAtMrXbCBixrYmnoWGRe/dahain9gFX2shhxaCo+OaQW6/x0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757579040; c=relaxed/simple;
	bh=h/vwBEavMlVaCDlfZp3XEwT7H1uihUhB9dVxTxjX+D0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gzEeH9cyii/dDk+zkjb93eErjiOMckp6H8EqyfdsCz+ecPFzD8qTfVEFtcNpTBSWFq1JAVOVusZ8oI7fHXe+kcxJrqJPi0/ILabcQuCWqvLVTBk/Vd4Wgo5gBGRou7HdtMi/3P0GHRpgewBFtLEI9Ot6jUJymqqLaRp/TTf1izA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RIaVNszq; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RIaVNszq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757579039; x=1789115039;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=h/vwBEavMlVaCDlfZp3XEwT7H1uihUhB9dVxTxjX+D0=;
  b=RIaVNszqc6b/gwrLye6FNKsLU9uLpSZKY+pj9cAuelP7+cL9q/EJQfSk
   n672XwEUfA+53uDF+hqjy54nuMKUKFwTX1dSbk4e5Fix/uz/cjoxFEbhN
   RvJUJSezX0M5i+VPBVuWZANDdCldL+jRJ2E6/J0RplSRfCCy3W+mYv2HS
   pP5qBb3fdk4XH7UkAA4yQKQOHqhjsLwDBdSc86CWIZ7ZnT6SHAOsnCStq
   r2AdmeZinMa69+U4flKtmIFtAzcXAcfsE+6cml1/mh//HdvNzp6MYHOrN
   WzroVDZqZYRXvcR05PDhcC1trBooHGAlvyROj7OhGiW/gyu+8cr6nSl9y
   g==;
X-CSE-ConnectionGUID: QbzkDofmSsmve7ziX5OMDQ==
X-CSE-MsgGUID: mBs5rohtTj+YWvqX52UU8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11549"; a="59761833"
X-IronPort-AV: E=Sophos;i="6.18,256,1751266800"; 
   d="scan'208";a="59761833"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 01:23:49 -0700
X-CSE-ConnectionGUID: kIMDtV5hQD2dtZa4wHwOow==
X-CSE-MsgGUID: eIO0jMUYSESuABXNJj5mfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,256,1751266800"; 
   d="scan'208";a="177968497"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 01:23:48 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 11 Sep 2025 01:23:47 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 11 Sep 2025 01:23:47 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.55)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 11 Sep 2025 01:23:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NaIf8sRouf8erdvP45x3FQl13ELbD+Kt4TdQEIVdEkOYYWWt2gNxmbZGXFs5mE+kS2zIoLe/gsbRPFAA4YJ2s3OyNEXmM8X8DtaLGmJg/Ylr8GT0FKD7n8mlQ2/N1clYbwJ45DqW4uhf13rCEozYlSXNXOaJ0kEuse7SW65eOpe2HISr+eqdP7NRLvzJf8wsB/RTlJ6eWdC+dhOay1eZMMh8ke8kKtzVQB4gF6KJoASztLXEsSOwr225eM8O3DnE92KnckIvgbPO/SeE9pQ28vSagWHYipq1KhKy0LIC+0X6Lui1rhxdNWc3V6RGW90dr/BW9Ugyt797RC1kiC5Jvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jR29QLEjXu45E7+GJIdGb29YMHtBEQAvnQMfKqBONU8=;
 b=KkRU2sTbSu+4/UyhwSeQNU0sPpfKqsAn6cMSbRonRut4FG51XtUBV805ctkHKOmzZZO73M/y6D1w+TnGaFh7/VgLThY1iRv4Xpjni319PjRPh3243XOn2OXWBBFOXvb0BYvZhKQ5B9f7E7iWw78/r1fLReWxE/JNhHZ5H5OP/JgiJjq0bubiKRlYwEo1uFJZv+ElrRZ50GkFfeIJKR/lqj517SBhHsufZJNmUG+rh0NcOkTFqQTAYJYpq51Jm6UtMqKkIpGfgfpsOOPtXftK7BUYzDe1I02+42n0hANz0ZpK98Vt9x6hTsXxwoNGrkGnyS8BKPdz4aq+XNtiXHPxKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by MW4PR11MB6716.namprd11.prod.outlook.com (2603:10b6:303:20d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 08:23:45 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 08:23:45 +0000
Date: Thu, 11 Sep 2025 16:23:35 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Steven Rostedt <rostedt@goodmis.org>
CC: Pu Lehui <pulehui@huaweicloud.com>, <oe-lkp@lists.linux.dev>,
	<lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, <mhiramat@kernel.org>,
	<mathieu.desnoyers@efficios.com>, <pulehui@huawei.com>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH] tracing: Fix missing errno when zero parser->idx in
 trace_pid_write
Message-ID: <aMKHBwzgqHOhILUQ@xsang-OptiPlex-9020>
References: <20250821071721.3609109-1-pulehui@huaweicloud.com>
 <202509022339.ae20a8bb-lkp@intel.com>
 <20250905150312.02bef848@gandalf.local.home>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250905150312.02bef848@gandalf.local.home>
X-ClientProxiedBy: SG2PR04CA0159.apcprd04.prod.outlook.com (2603:1096:4::21)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|MW4PR11MB6716:EE_
X-MS-Office365-Filtering-Correlation-Id: 9480321c-42fe-4d93-5e3e-08ddf10c8621
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KQgd3UbiAglPfUkX8FR78a0xPYg4Lt8uVe8k+zKKPRNpDgr9pVsRm8o9o4Qk?=
 =?us-ascii?Q?n7onUz3LRTKhsXvFg0JU+w2MDuVKZBmHlU6mcyZ+0xTd/+SLzXnyNn+Bib0P?=
 =?us-ascii?Q?w+KP/uaTbnOg0HlAgwRPPABGl19yU6FjP+zTTs+ufJrXlvs5K4NyBqLmzFmO?=
 =?us-ascii?Q?yuJalJdnZCw0GaSjQAAVpxMANDlxXPLNeWyjitw49gwlFsPvPR6pkJTV7D1T?=
 =?us-ascii?Q?qeu+720bylmQivo0Zk2/F5Pcpm/7fFgHG2jtXExGel21IWJTZ4tqZWQF2ulh?=
 =?us-ascii?Q?XWniU/WYpZ+AkpJNce5geDhd3Mues7oJFZbc5USytWgiEB3xxWKn5Bqxqmw8?=
 =?us-ascii?Q?27mu5UP9kVGJxe5jIHDs/EpP/buxBQ+NtSNHtT55R/ROQS2YyyDRK887eNZt?=
 =?us-ascii?Q?2fK5jqJQ6Kyww7xLr7VQEaAOeAIqfIebhZneF7ie9+0+suDfPkpYm5MxBcvF?=
 =?us-ascii?Q?qxpnMYMuFGw1qgWPeY2O1/36bA0cZeDlmzkFmLuXBQy4MshHZ0pXsQnVNzGN?=
 =?us-ascii?Q?COXwbdVYHUEGYqPQJcwaalqklTWH1+sw/93gNNt4nXB4YZGjxIrXfa8YZ0dL?=
 =?us-ascii?Q?A3v9BDRHp8Mz/TdK/jyizoYt1kNwQ7+4xAHwxvXzlk5fO9kGhVMtmJFxvOMM?=
 =?us-ascii?Q?xmGfKqO6OHrbJZfrHE3X4AVgZJYSpMpqFgik+qF6SRzFVLIIJ7Im+NzUd3VF?=
 =?us-ascii?Q?F5VEc5aWtY2n3QTFnF6LJVT1XZ2Y65WxbPx+0vqy93I0+9nMremyRyKuHZA4?=
 =?us-ascii?Q?PUNe0ZbMpBV23dmvf9zTMNCXfytd1iekXVqQX4DlVCm2k7LT5ZWnbc8IWdMb?=
 =?us-ascii?Q?/m7qspchE/qcwzzC2JxKrXPfSB4bmNEXRPFWH5IrDwJ18g++c573Ablvicl1?=
 =?us-ascii?Q?pajs88o7ksWk+y/FeIsKXrLiwh67bzL1/bKpVLBBRx/f81FvROsWta87P2jg?=
 =?us-ascii?Q?ocFf7Zpx9TlbbioQV85J3G3LSiEsW3sjkwnRBoqinTUQucMkJTsYY/JCYxAw?=
 =?us-ascii?Q?Q7msBH9AgJkhxWO0LVJEyFuItVTretmaLrixLlWkxCAJuJf24qWQZobLGjH/?=
 =?us-ascii?Q?sg8ww0tuwfscTTrKM+yE1F95qo++I6iZSZ4b8pX53tfoIzULYoRs1NqAYnRD?=
 =?us-ascii?Q?CoMbKKJqAxuOLOAviWPw6J7YFzbAQIq2FimSJI/PbG/Wr63+bk4ncEg6eJ1d?=
 =?us-ascii?Q?STIrvwNLNHLAQRfegCYML0U4FylWwZtL3VhA4ciCHpBHjFZwb4jdgOmlZQt4?=
 =?us-ascii?Q?qJL/xM9BtXRTTv4Bop4tj+webrviKkyim32grdIVwZVQjAzmjrrGek32C6x2?=
 =?us-ascii?Q?V9Nm34kVdTwwtm5hYWGaViX/OkSFpt3kZMLjGyH3X//1pVCg19iQctB1qJZl?=
 =?us-ascii?Q?7Gvr7qlOwmR8IyLgshv+vL2lmkLJXMoTpJ+RCCCR5qsYCzd49KrxXrb24ebI?=
 =?us-ascii?Q?VnDUXd7tWqmtbMguJB7L2IdA5i2G5ACd?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Mj2udpYVNmmul05ITSwq6XrXHtS86kIAf558NeCTpqxDmwM3D0EDvCgDXo80?=
 =?us-ascii?Q?nW6OMM3GZbK/MhkqvxcdkhXm5A6r+0iCwnTjzqgyTpwVnrLcwjx4t5yku3Br?=
 =?us-ascii?Q?ZtRm2GZbTWBxces9V6XToW8hK7YM7YdYMQ1e+0IQsRHrvNMzV//GaPemyftz?=
 =?us-ascii?Q?woxzst6VvjPv5Z4bbFk7uvm1zrnwF4vtaSMr8AECjuKUO7YJG+zKdgODcjGu?=
 =?us-ascii?Q?/yNqojiNWElt0tCp8C3o75xD6o6Wyj2T3Iz06QoomZkqEW9Jq963x9HLla3C?=
 =?us-ascii?Q?ASVc6jtZrBQU6I0R3YueGgeCap7xmdhJ9dvadJbz4MgThlMdhgxPGYnDepNi?=
 =?us-ascii?Q?qTJGxqrEAT0JY3YkriWwR4vJDfPb2Rz+XY/oWCfKN3mJEcMc67sOZUHdp3nv?=
 =?us-ascii?Q?Uz+HwZv5thhYl4KTztQmDmaKJOQAYeZTyctM5A0F5kSJekbOuJOljaB59NX+?=
 =?us-ascii?Q?siQQsHab7DRR79BI9L/JXdwrfW3P/xd0FEVUXbKhVLYDfb1GoA1pbELmvB7a?=
 =?us-ascii?Q?FaJVJGQPmrci4zxGlUd2Ztcc3GIYXrQKfdgbr3EUumDQho/Ssz2xjTO2X7Or?=
 =?us-ascii?Q?BN5QZFpB0lGCyVEPMjAi/2/uqEXgzp/duNLa22BKZWeIbVK8TA5sGNs9Vk2k?=
 =?us-ascii?Q?E3W5QW8e2CBFDkz9QNhGIrfG6VmJxnAUCN/wqhvbVsnsE+eA+CUDxzKf5e76?=
 =?us-ascii?Q?EVgIYRdeGtlb/3qOE1LtjWHYxnlkk9Nq3TltYwskzUIUIRfDiJlcBEk04XTS?=
 =?us-ascii?Q?sKAetJ6vG+UHSL1yzxaX1t3MbWDqjIHdgpzw6rXSEbHG6tVRZcNMW0ivt3Fl?=
 =?us-ascii?Q?NMZDVm9KxvCYVwIqlgCCT1rzQg8xPfPgrTqjKHGtk9d+m5DdsqxE08qV3/xE?=
 =?us-ascii?Q?W1CQ5WDnGeX5ovAWSHOpPvVjfngzWOObQ0LrtUzGFTZpIJJYbOH9YHqzAO3C?=
 =?us-ascii?Q?W+IE4ZoLNwnYPb5O2/4lrMkwvt/LayLBkAGAAnlFH+R/nVoEV63lQdVVgAJs?=
 =?us-ascii?Q?/L5fCHXaYjW+9H9ksfZHJlAHpLJLZUT5oP0CnzSXuFQxhFktpyEU91zQJtSe?=
 =?us-ascii?Q?8f9JoN7uuAJB/t6KjShab4ZZ9RCgiJNPVRZEQWccNE9YV88bYEMIrmTTNJ7I?=
 =?us-ascii?Q?1me1+gWV7Du3sxVLFoqBM8TEJ2n171p6Di8Pqy9uZNtNpykDek6uvoznSvt6?=
 =?us-ascii?Q?bEm/RULKTKkHA0J7PTxDT0JH9ftwdTeBj/+ezSmpnAA1Nyb3e9m7qPfdTxOA?=
 =?us-ascii?Q?Bq9GwbblbVdpQfZjyK/s4PGTYnSOdKP4JUerSAMcO6JihTMwYKImASF2t7KI?=
 =?us-ascii?Q?F0bb8I2ll6wkorfxbW2kNbvNrFtVFib6xtXXPMcgozq2iV5Q5X3ioAQsWPLV?=
 =?us-ascii?Q?a86CYp+DDR4CqvoyA7gaqbEC3UPTRmsgzaf4kfFr8Ks7OZQ/sBUM4bgAlbRh?=
 =?us-ascii?Q?yM8gbW5K4zd179zn7dusLWqxyEhgtYo76n0rR0MuccbaJVZDw2zN7XXfOGWt?=
 =?us-ascii?Q?UyMwstndypNDtAbCRbw9b0f/lTEHdFuqzX0DTVDPCdwiOjzhCk7hNL26186s?=
 =?us-ascii?Q?8KJd69E3v5TU10f1iHjSIXsj/FN7vyNqgejA0UYDJILKQ9wDqUIiOAn3NcYY?=
 =?us-ascii?Q?+A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9480321c-42fe-4d93-5e3e-08ddf10c8621
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 08:23:45.0030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 55VeIIsO45hXXMQvc/ot5k8NlW74cP+MNNuq74LfcAMmD/iEH8t4U8UK1zakkdKFlm7TpWz6NUkUNf7IustXfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6716
X-OriginatorOrg: intel.com

hi, Steve,

On Fri, Sep 05, 2025 at 03:03:12PM -0400, Steven Rostedt wrote:
> On Tue, 2 Sep 2025 23:09:53 +0800
> kernel test robot <oliver.sang@intel.com> wrote:
> 
> > commit: cebdd2c9a622becc41349f32ace1795d750beda8 ("[PATCH] tracing: Fix missing errno when zero parser->idx in trace_pid_write")
> > url: https://github.com/intel-lab-lkp/linux/commits/Pu-Lehui/tracing-Fix-missing-errno-when-zero-parser-idx-in-trace_pid_write/20250821-151736
> > base: https://git.kernel.org/cgit/linux/kernel/git/trace/linux-trace for-next
> > patch link: https://lore.kernel.org/all/20250821071721.3609109-1-pulehui@huaweicloud.com/
> > patch subject: [PATCH] tracing: Fix missing errno when zero parser->idx in trace_pid_write
> > 
> > in testcase: perf-sanity-tests
> > version: 
> > with following parameters:
> > 
> > 	perf_compiler: gcc
> > 	group: group-01
> 
> This is why I hate LKP. It's huge, complex, and I never can get it working.
> 
> I did the following:
> 
>  # lkp split-job jobs/perf-sanity-tests.yaml
>  # lkp install -f ./perf-sanity-tests-defaults.yaml
> 
> [ had to fix python up a little because it wanted python3.9 where I had 3.13 ]
> 
>  # lkp run ./perf-sanity-tests-defaults.yaml
> /work/git/lkp-tests.git/programs/perf-sanity-tests/run: 7: .: cannot open /work/git/lkp-tests.git/lib/tests/perf_test.sh: No such file
> kill 37975 vmstat --timestamp -n 10 
> kill 37973 dmesg --follow --decode 
> wait for background processes: 37978 meminfo
> 
> 
> I have no idea where this "perf_test.sh" is supposed to come from, and why
> it doesn't exist :-p

sorry for inconvenience. for this "perf_test.sh" issue, we pushed a fix
https://github.com/intel/lkp-tests/commit/3ab6496813796e537d277242d220c4571790a363

however, we found there are other issues which block reproducer to work out of
our cluster env that we can not resolve shortly.

but if you have any debug/fix patch, we'll be very glad to test/verify.

> 
> 
> -- Steve
