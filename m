Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793200577;
	b=mqZHUvZb2RbcYoW86TchqX60TbgYPpwiEqwGCBZIpjKwCA/GRLwBDoBOTvd0YyRd67dQ
	 HfkHL5Qt3KcrEelYiXrxWwtU3/qI9tHIsx0ED47FyiIIeJV8tCY2wFgxK0DICCuDpdugu
	 94DwXE3De5YLnUSpkEI/pO8KSzH75KBueVSvVJMt3ny5W+Z7pKYR/WCZDJ8A6l85HlLs9
	 xL5dpB0P0LXJ6Uf6VYsi0a9ewhdHvLHtclYKyFF8CCL2muRoZsr9QX4ruTNauu15ICeXd
	 t+upMZvM7OGVqc4UwGS5Wp0PU2tv2mB3X9gPHGwFURWK4vW5UQAxVJYuDDAqMwiUcKw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793200577;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=UHwMt0PHsLAAej3BPpd5pfJ5Jf0w8NSrv6G4HYRcLDI=;
	b=VbyL9yb1WuOBL4pgGWEBjWlbHoADn/YBUVbhi43FmfkXhs9MXesCpKaay9yuVmvKtWw9
	 loupwDKoR/3KNo2jaJH3epJppiEXUztEY5MD0DjigyIHoJZidd060VzXn+kUV6ieMIezh
	 3UIK4n+15Wogv3TX8RZQypSGmJfhsGm7+vJYyeHqjITOv4uQnVP7Nwrc1fCOPJbUfYXBe
	 cBt4t4yyqR/NrGOUz2lN6oxQqVsWwc84uP2EbM4xvvrFB+M7UOjiaI/mv/nlpgZHgULgb
	 rVIerMrlKPIIc9UMPzIbdC+t9WxCdcK5Eom35GfEOY+obU3/gpTxbRtHvYV9MRa8lJQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=IePwFqLz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.49
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012049.outbound.protection.outlook.com [52.101.53.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BD4606A31D;
	Wed, 28 Oct 2026 15:16:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51BD4606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=IePwFqLz
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XYq4U4bmZcdClbOKyF9DA/FkWAw6cbd6TPbUjS7UBqx3oUNiXaS5pFJ5417C1/zBERP89rRQHPnka9UvjCbE4dYTM9+1MATbnfe/wdBxy9P/el6+kQmNbZ/7x//s0nag7EmOS+jkyo2uZwprFQ4Wq1+OSk/OuD8xpMTJ9xyXflLb5BCCE0tkpf14XiIA4w+Etb9jjPjDcf59WMFyHwuADxFlo/TpY5HmgdAqaSKmVtJlgoJT6Snb3KS5avx0ml7qf/x88XtmD+hnGca2EUXbEzsodbflCP8viCtn0pFlRkUNLA98YBXH3KY/t/BqTs7yLL9+1Y6i5hMlTR867jDd2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UHwMt0PHsLAAej3BPpd5pfJ5Jf0w8NSrv6G4HYRcLDI=;
 b=ooWcUduILNCwPLKIzuTbHr4vMboKXZob8bKKaFK5tkPYMN1HKU8QbahV/P/zQv6z2pU6n3oRg+KocF1C94dSu1gvsqZFTWZnvocu8a4QzWEZBqHNlTOOpZZAJXhm3Z6SUF+kS6popoNRn3G+rfg5327iGNbT5aVRixaoAWIrHA9xpP9R5xtvD+q33QQ3Yr2WDYWWDSw1EBYtGlEkrYHJbdEoAPXsmHDcLjDiqD1QVWPhq9bkPgRC+JW5c9yrNUl9yr+lXDpQbEqUVWI1hJkcPDakhne2vhmAFF3XCLksLFzBT4va2RIXKSkVmg0WVvm1E0xclBZN4Axk0/9+nY2GFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UHwMt0PHsLAAej3BPpd5pfJ5Jf0w8NSrv6G4HYRcLDI=;
 b=IePwFqLzWdoe6BQ8rJimJo3JkIXnj2Ng7ApHvrPaUXGxAfFBYte21uFlBGELENKGwdIwaViyK7bFVEC8Ia9d/wYOeZAQlHyTY1YJ+Sh97tyyeSYPNiJUU37Hza2HD/zW/3c22eFDcYUeyivCAOn2d7T/CDWFH8CrIXAnswhsPHtvColqyUi8J+nZzRp7BXpSn9wGSav6mTYaifTgabxR+JRAJtXMZfEpi/YiAadkGIKdUtqN8L5jF5bAg5O9gmc8UsFJNMmUPBTSZa7pUtv55KDPgXHnWLF4+HvuS9UrJD6Wu2jQWRxdPIH75sNv7SarXdqYFp+PlC/aerXFYX7qxw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by DS7PR12MB8289.namprd12.prod.outlook.com (2603:10b6:8:d8::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.22; Wed, 28 Oct 2026 15:16:08 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 15:16:07 +0000
Date: Wed, 28 Oct 2026 11:16:05 -0400
From: Yury Norov <ynorov@nvidia.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Yury Norov <yury.norov@gmail.com>
Subject: Re: [PATCH] lockdep: Add #include <linux/instruction_pointer.h> to
 lockdep.h
Message-ID: <auIRtQjGjb0yeYCX@yury>
References: <20261028110558.623a92d1@gandalf.local.home>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261028110558.623a92d1@gandalf.local.home>
X-ClientProxiedBy: BN0PR02CA0019.namprd02.prod.outlook.com
 (2603:10b6:408:e4::24) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
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
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|DS7PR12MB8289:EE_
X-MS-Office365-Filtering-Correlation-Id: 8118fc2e-81bb-421f-afc2-08df35066404
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|10070799003|261026140227099003|56012099006|261021121427099003|261009223027099003|261022105027099003|11063799006|10067099003|261022075727099003|22082099003|18002099003|261026121527099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	XNkgSCgyNcmQfYEapPdTLD5VdPZKszBpKKWejiG1ohPNEUfO0+kUni/SZH3XrBYzUiFv4e+yIwhUKt6tiFOQszriQMhynp29DvXTX/ighORQo7rxDARNt02ss7KT3SOGtgfWrb2U+S8rp3aBDXPi8D52a0+CzTrse/LE72avc4QLraCBqI8QIC1Ir6UOdqErsH3iEVmnWbok2n8I32TEoRl/INWSPp6MKhlz2Fx+c83pdyDKhPf13OjJUvL10fAuEZSVXIUvkeapSqjcyTG4QZy/98CSyOf2QBIkzE/KFeIVEP/S7iC4xXmrIMkAOj5nSITXci1uvGMGBb7tU4jEMJtA6FPEh/VbOyyzO5H9x594BwImmfX9CVSRVVXEKvsXXpavooTtOElZgDcBUmUrrvBEVy3x4nlQdYXCslPdPK0hHg00zbl8r3LNypnHcA7XqoCaHkjJpzMS9GeBpD7K09cmger42BS3kFd5GJI3b+xtYR/9f75kLHYmRHWWeMj38773Tg1AcYn+ULaFiMuAJDEpkuk+zVOnLAAJQ7ll9B+NtyciU9BwcsW7tML4q8nP9BGnSsATiVLN0fAa4OQhTdyW0WSR4b+3Jz4tzwCPQFF3Ez+h1Vt+QFcPh5esVXhpGG6igJLOsRorExO6ma/EKuvW72TxacRt7SZ+PPc6iAw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(10070799003)(261026140227099003)(56012099006)(261021121427099003)(261009223027099003)(261022105027099003)(11063799006)(10067099003)(261022075727099003)(22082099003)(18002099003)(261026121527099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5/6CeP2Rc2KTxqVcRGjnKb/+FQV4m5vvYtvDYvRSCn8sFjru6BEtzoNzgG0q?=
 =?us-ascii?Q?WVSaKP/5RW8oImrvnWNQ4new+tA3KzMN4jj3Xf0CiwExKQgDXei3FhrjvrrF?=
 =?us-ascii?Q?KbAT+A0OfM3q2k7W2D1LbHl/6PMGku+DgiIjtMFRv1KfXcNdHYskEoSFPWfv?=
 =?us-ascii?Q?2sYoczRPGNBRpqqlnzfa83xH8dRpUcngzxQcQRU/a6QHMli7yIdnSo/2n3Qe?=
 =?us-ascii?Q?2okDzZmc7JTmleUZUR9B1X+pPx34V1I7sBf0rNO3LNyzWT/0kgPI8UHMbN/c?=
 =?us-ascii?Q?8YxWiIx44Ec2yE0HMDpsBWxk7OJIL/yomGzsRC7GBLFAUzs5jtJYwd4IrWC8?=
 =?us-ascii?Q?VZRtIAV8BtYkesFQcP/V82Y2ACYYZ30frWBC9r7V07A4kTLncb20Re4TYqIJ?=
 =?us-ascii?Q?z7Mkbkaph7Hu+NL6w3ZaF209ItkjO2VNshCF/tDU8KNiuB7RooonnJo1hXS4?=
 =?us-ascii?Q?NM+ej4SHi+Nwsl9bWiCc6cuobAbpbDQN4OX4rW9BnkmkFqkw+nJ8bjGOIjPh?=
 =?us-ascii?Q?DZSEcWGACUu85D1djcGFQDGK61buG561fx5QAV0fiQKffH+fhXLxsrwTInAo?=
 =?us-ascii?Q?eGiPUG7Mt+a+IRqH5y6YPahTVxsxPIWibNe3/BS94OqqL5mW+QnmkhVzirl2?=
 =?us-ascii?Q?eYtWPZMbqg7O81oLM2lFcEulIxd5KwRloR53PaKZNh/ZHnjasJ9OL/3LhS5n?=
 =?us-ascii?Q?lDead5Y7hjeLloY39VB4cS2EU1/DW4ST5iUnCjJlBmmHn0cAqCrQ1vHdlLAg?=
 =?us-ascii?Q?IgDwQJRHHJBtGMIAnwcnvyE9KDfOWk9RrCX1SZV7lA0E4KP9nT3NgVouKI+t?=
 =?us-ascii?Q?cVxec1FTa79g3alVhOx1alvWRrWexPCkGRls1Y+Co9LoEjMVp7GqcOCR98nG?=
 =?us-ascii?Q?0p3ZwOEb8LxmZNVuUGdqgc1uu3M94dMEluHdlXPte7LLRSLWmG+QMhWy1B7U?=
 =?us-ascii?Q?6ylBjxD1yu3oWi+6dxMaC/b0tX+1MVTD3gdALC5nsgQPJDul9WIkacTPrAW4?=
 =?us-ascii?Q?NDGItcvhcfn0Lj6BIQXzgDcAHYSru8bTP635/faSm0cM9lh5o9dhwVr0Hfjk?=
 =?us-ascii?Q?rLzDFIdc19au3P2Elanhqi1d7WVAz02SVRluRUkrJ1XiH96Zo0s7/lPWeGOM?=
 =?us-ascii?Q?JTbRMC1E0BkgCDls1P/z33PAlbZzsABtKk4hSzYosUI6IqQKfqDXCZ6VChPm?=
 =?us-ascii?Q?65ifOb+JY3XWCRf5uIn/cvykZo0g9f6DUJqrDJEUQz15cn8W6Qx6bavfdktz?=
 =?us-ascii?Q?tgHUIMl/h+ghIYUOcafsskfZDW9o8fQUBKZJ5GKhbiK6VT1U2fCTHPGoH1nB?=
 =?us-ascii?Q?VEHUumDqR8QfUw+DOy0ubqJAnFgWPyAdy6zXyIE9YMQn5rNgsxWA4ezU4kaX?=
 =?us-ascii?Q?EvFhdBKqkHFaRfiEJr6sz/DiaoLB1y+vvlrXSElXHmsiKNxehDE4HQ6OYxiR?=
 =?us-ascii?Q?ZXtIMkWmfU0jbUphYJoXBc+/2j+PB4SXaEfIdGYIXGu7n5CySdulZi4k7Ytk?=
 =?us-ascii?Q?mK5kaLcni5d9o2YIBIjUbggkXk+aeO7hr74qlCNrm34wcSTL0Jzj6YulHPh+?=
 =?us-ascii?Q?bKzJVD8tBdZVY4AV58hy2r45JHqkfmmTN+ej7bwpteSBBpbdw6kF69Fo557O?=
 =?us-ascii?Q?QKtsTAeaqSXR1ux//AX1p7GfXo2ysOMdwhrSgh6NEXIU3jyROks9d3xu3ihw?=
 =?us-ascii?Q?NrFizE876Xuc0yQxV+24SglklVyLo4P+jOwdWIx5CY+QeQcKpJjtOtiEA2aa?=
 =?us-ascii?Q?1mCjTXmr553RzSGub2ulDP4uf/RP0UwW+B7MVk4CGjlxXUluWnwM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8118fc2e-81bb-421f-afc2-08df35066404
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 15:16:07.5541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xSlygBAdWcjzYcIAl+UM0CUuQAPjodWroIygT+L8UvdE64leXqwUoDm6PhR08iT8UunxQ7vgx1T9HVEWaHiTXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8289

On Wed, Oct 28, 2026 at 11:05:58AM -0400, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> On 32bit x86, _THIS_IP_ is not defined in asm/linkage.h. It happens to get
> included into lockdep.h via kernel.h pulling in trace_printk.h which
> includes instruction_pointer.h that has _THIS_IP_ defined when linkage.h
> does not.
> 
> In order to remove trace_printk.h from kernel.h, have lockdep.h include
> instruction_pointer.h directly.
> 
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Reviewed-by: Yury Norov <yury.norov@gmail.com>

> ---
>  include/linux/lockdep.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
> index a6451ecbbe9a..c6b0168f5fc9 100644
> --- a/include/linux/lockdep.h
> +++ b/include/linux/lockdep.h
> @@ -22,6 +22,7 @@ struct task_struct;
>  #include <linux/list.h>
>  #include <linux/debug_locks.h>
>  #include <linux/stacktrace.h>
> +#include <linux/instruction_pointer.h> /* In case _THIS_IP_ isn't defined */
>  
>  static inline void lockdep_copy_map(struct lockdep_map *to,
>  				    struct lockdep_map *from)
> -- 
> 2.53.0
