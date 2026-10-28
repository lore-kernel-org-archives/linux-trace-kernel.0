Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.2
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793202567;
	b=uzZdO4KmqpwoV96SM13KO+whZbk/jCVzOhQXNGG8vNT2hkZXt+E6O8y0HXIf8llVkyeB
	 AWSbrxGfgnRWqon1PKX1E+FsTK6eNJ4EliwywursSp3TzXpCLunhOrfNdKnkIsztPkPT9
	 oC6ZswRBDG8Sz505892WMyzZChkUpkgvGA0GFnwUeoRJ610vzu99Yi33Q5xlTmdNx1jed
	 wVd0mpCL/unbOfej/nX0ctUiZXXf+21a5UUJwg4gkd3L+cr/zRPiU749esenyS1C2LU1O
	 PsUChafUz3B7NgyLZHcJATYIbAZo3+xVZb9YPEiwOJFSF/AJ5ZLBnBIgHlIfMWcto+A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793202567;
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
	bh=DMW8MEPLutuePt/qU5rX6KsSo8mqOE7y0xZsu0LDGSQ=;
	b=ZtgrSrgCz/rvwikTgB6bGbxZrQ+E6maMwrwBvP48hoUh2NMajaDbviEq9XPJwRFc5QUB
	 IXPmO48iriinv2THpAvJkuo5PfewZr6gzLqrc/P2Bft9RARoF007DoFGLwq9wLOYOdk6z
	 MYaj17YNx8Ycpeegr39Q36as+khjD3OVUuKo6GajafOPQ34saLhBRcrxO799z0xtdmFqm
	 wEU9k49qc4IuH038+HS/fstI2z//JnWZ6Y007ilPz4bpUQJm762WNaQZJQhN5WB0YLcxR
	 SIL+Kd2TuaTywkza6fS/tCRWP548QTu21BQ805Zt1HrH9Dj06wHphv2H1fMqrbk1W8Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=rOUfpJB1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.2
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010002.outbound.protection.outlook.com [52.101.61.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCEB6606A31F;
	Wed, 28 Oct 2026 15:49:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BCEB6606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=rOUfpJB1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KD+SteobB8L0oFwwZt4JnRgprxSS3pwrUu+vp/9GmDxP5Bv9WNfmVk+u2ciPetFDSn0sUFIucyEeknFLhzK77bUFinZylDjpTfyyRrBztgiMUzN8UNEs3PsLL+KU5BRGm9fcpmS3c7wh+ADxyiejseE6ghz3uGwUUtYBDHXU8/xRO1H+lBp/1N3+0P7VtQlD2854+3PDLSjoo+hGFyHXWvEITzHby6s19fBhJSPn9pj5HqtdYvScmutSoggYSLiGZkfPSeWRNvzrW6foqKyBQAgOzdf/irGHash3X5Bbdo9Q1+6GOw4oHYrSkbj7V5arN2AvJ+tPvItmhuW4H5aIEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DMW8MEPLutuePt/qU5rX6KsSo8mqOE7y0xZsu0LDGSQ=;
 b=p+gaACk+pSs3sKPc5Ek4UQXGTAf4XK0ZpSsVugiAeKdOeRxt5o+m9zExNODNXQTSnIOLK6MgTteVy+gd8ShQigunkZmu8KIGRqgREmElkBYKqB56TIMaHUGkHmgWQUAL7FSjOtm8SCm5RyhtRFw93/RFdq8YP8agBHU1492SWmmBBSWaIZJZYxrEfPYJXhDGeNciKDLBLJ6J5k+qMAJ9APhKEX/B30FaoZChS7icOp2gSUO/X594kimA8BUC6znZ/L+In8xWf+QUrPQ2xDIwFxj+xAVUvtxwvXIpk9kQvrdQWCP5UGSzv4382m8H8pFx1eqr7DODLKDJRDlLhzvZpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DMW8MEPLutuePt/qU5rX6KsSo8mqOE7y0xZsu0LDGSQ=;
 b=rOUfpJB1aIaBY6HUHsmo+il98xZL43F9Hol3Ke+f/tJFTa4rcY3e8rPEYVL1vjZnuM2FSYxLDL6tUOGGgMvbi8IpBgENHhUbfy4t4XghpxrhOoTKimXUKl4VOMySU4S9F0zSqPyDwrMj89g0ovzJiG2+UnwBc+lRdORmOxUFWn9yr/PWisWB81KB+diYzMthkWVlhGooAJfhA4unBEayxGdoZyndVKe8qMehSArSCs8TSw9+ACIUDMq7K0RKTfvlJu+weCX5hQGWjCCYR/hkagPrtne3NX1UtbRms/ux4+X6y5iscfqvEw3J6/D+ZKwp5MSQutePkauutkO3zdpLqw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by PH0PR12MB8151.namprd12.prod.outlook.com (2603:10b6:510:299::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Wed, 28 Oct
 2026 15:48:17 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 15:48:17 +0000
Date: Wed, 28 Oct 2026 11:48:16 -0400
From: Yury Norov <ynorov@nvidia.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Yury Norov <yury.norov@gmail.com>
Subject: Re: [PATCH] lockdep: Add #include <linux/instruction_pointer.h> to
 lockdep.h
Message-ID: <auIZQDojrrv43MrA@yury>
References: <20261028110558.623a92d1@gandalf.local.home>
 <auIRtQjGjb0yeYCX@yury>
 <20261028114528.137acd81@gandalf.local.home>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261028114528.137acd81@gandalf.local.home>
X-ClientProxiedBy: BN9PR03CA0177.namprd03.prod.outlook.com
 (2603:10b6:408:f4::32) To LV3PR12MB9356.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|PH0PR12MB8151:EE_
X-MS-Office365-Filtering-Correlation-Id: ee61204e-a0cb-4f96-a319-08df350ae298
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|10070799003|366016|1800799024|23010399003|22082099003|18002099003|3023799007|261028144727099003|11063799006|56012099006|4143699003|261026140227099003|261021121427099003|261026121527099003|10067099003|261022105027099003|261022075727099003;
X-Microsoft-Antispam-Message-Info:
	4Cj//G1Y4jns5BucqDb72E5byYdc5fHwaQGyQRBkY0ZZAsi2f1+5EUbWDBTZ+cSqDxqR39Wy4hSnJXaPEuX/QtdUn8+H63Vh9D9XDwEBXCNHx9oG+ZpFyatx6uT0yME+9EqjFA3GbuFq1+apwc2O9v+LmBb6uZJIRXFW4OoFJXLxXfGR/6itOU43zGblFOdb0uoaFOuM2OLDiSZV1DA01SdIGbj+ZFptmbtmBKYlDeARncSqR3EgU5yOZ2PyeMyIl/VI8c/h4RHHAjdyfMP+a/UjCUgUy1eKhVYUoVFbBj5JAfT5Ij27q/FYv0vyni9f9z/CPnZy69JQeJ1mxkz5KoBcydb2QEYvzbkFF2ECti6LQM/rfbFXwCZiha85vlm8CzuBICRo2lhUVWHzGnZaMmlZebBV7Jmk2tiL6JZbbPobvq6GhSD7vDxGtY7zaF2G5slSuIDogsWIx+ZXf5efB4C4U+crIXg15cVrpmi5QO6WNV4oCye/+3N3kSsD8HOMS72hEJ7pwJKr7FI1Z9kaliXCMbY1Dlc4W5RLGuEt6GP8Q7q90OCVbBRVIGehD+T8e/4/lYc0WS8DDYy0AT0K4Ru39fpnPB2YjUO61WtKa+/8ZVvEYY5C23qqtycjqf3ilM09DZ2wZEU5k6SZMrz8RlHIt/f6j34puYAXQB4zDyM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(366016)(1800799024)(23010399003)(22082099003)(18002099003)(3023799007)(261028144727099003)(11063799006)(56012099006)(4143699003)(261026140227099003)(261021121427099003)(261026121527099003)(10067099003)(261022105027099003)(261022075727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?s0qam2a7kqY7VeoQ6o9v/vcePrcXaRtgLeXGlsiw0yOJYRJd2CnwGrotiLZc?=
 =?us-ascii?Q?nudwxPUf7pLf9+62e6naLEexq8q3vbADycsbjklVsRurVDZ8LMBMSnVThN8B?=
 =?us-ascii?Q?uR+BKaPtO62DPp4nOZYoUrNmiBYn3JYwWWbSRHrNfjvdaLSAiPcD4aAoDSBJ?=
 =?us-ascii?Q?EDFkRFSANIzF1sj+Nj6AIdQWUtei5/9XjB46wnCc7N6Q5z6xGGP/GZgYIXQ4?=
 =?us-ascii?Q?FiSlP9tms2KQ+C42w7nJOZ6ziG9nuT3MJbCf9HIMO5bl0m7uCe/ulRyQP1lr?=
 =?us-ascii?Q?Tjq/ui9K1+Uz5UmFr8hI51LjYg0SYXDuE6oPDYVRhlVbvj1XAcHcq89ZTdsa?=
 =?us-ascii?Q?cwR/qPI3XUoXsizS/emKfHY1b37lJaC0z6uXdBB/oHM0gx1ZuAvxLTEs50dx?=
 =?us-ascii?Q?zUVxWnF3mVSP1mdsjbe7f7Zpl0EGL1xhmtrZFdpum2FO1M2Nk5f1VQwh4m2y?=
 =?us-ascii?Q?2YaRZXPAyRh9C0qWrzWzR8Cl6qv1VoTQ3iRAsECMjrVewEw/50z8y2uD0y74?=
 =?us-ascii?Q?ei43VbW4c4WyY2OqBDzo1oisl/gGa+yMs7OvA4Ha46GxCYMagSMI7T/d9QqR?=
 =?us-ascii?Q?NeE6TaKtvfCrdrzkmJ6+3WUn2Cq41yrp+lWUIoUFANogAHDRYdknDs7vnYyk?=
 =?us-ascii?Q?F6n6dJC2EnF0W2Hr3d1iVYnEj9vQlUNFEb1N1pLvpwwDAxvkyXYiBcMBFIYf?=
 =?us-ascii?Q?vAjl5VQaXfw48MYsQ2INZxto5PB9BRkjeEgrxRjZiEyMiPLc/2oB1QwfnCj8?=
 =?us-ascii?Q?bjCwDrxPpK9hXFxb0FHEL6xarkOjLOeWQx5hiqTxv2hy0bEWJR6psQvOGOCa?=
 =?us-ascii?Q?TUdTDI9Pq5tRc32oOqJHOwCMrQv6o6gDZ7ZqFJXrZz5SARcDWvhAoXKyevrE?=
 =?us-ascii?Q?0pZBvlzWg20AXz+oMlJGivSEtHzEYBuNylyoZhfp8VFlNlmtfDZnUMRnyCdv?=
 =?us-ascii?Q?kKl1/KGZVt2YjBWDg/RrXGdLFoEtx99cdwCxtMZCjbzRj5/Gh8miaIxt0zZY?=
 =?us-ascii?Q?Ht86NoTjc907oK/8BG4Mm7u8NBunI9rRQqItm+uQwGE7qDfiKtZfwNgE14jH?=
 =?us-ascii?Q?CeuRwuIZWrhAzCrzC6hrgeog3hd2L8veWdH1pMxm+WfqfUR1p4/wVgNJJ0dj?=
 =?us-ascii?Q?PHRfWhD52ksK6uk7aamT3Ps68mf1vom0L1d3b8avcM8rBOf+/+1JAH+Rjuic?=
 =?us-ascii?Q?7Rb5TewnVjqjgXpEsJ2u8hZQ+L1i8hiMyP1En/tjtTNbT+scD21RODBv0FtX?=
 =?us-ascii?Q?bCDZZiUxJd3uK8iGDS1lMku28TKcnxdkb3AgmDXmgpJ2uX8Ov1VVPjl++J/W?=
 =?us-ascii?Q?c9C+GzYjesnHVezHGI19nvxkKEnJhve7l4d9kpD762nuK6AqoMo8pZEtNRh+?=
 =?us-ascii?Q?Lenv4GtFYTMSrEI+9oycMgS4hMRV4pIj62nXQKm1mTshFRoY2anc81esaDGj?=
 =?us-ascii?Q?8+SY8E03yWboXkN5oAHVxDZ54o6EFvpoDUqHHai+dlOS7qWw0/XlFLr59Q0e?=
 =?us-ascii?Q?Jr+uDMsRn1HYlA9pCtsiTPD5c4dq+CQPmzDZ5gZidqqtEQK95z9QTpX4TdTz?=
 =?us-ascii?Q?yHp6eFAwqdPgTFCbqMUWa+h2zm0WWeanYCrOWZRh+0Ar0UBE5kyNssYu88AX?=
 =?us-ascii?Q?ZTJ9YIGjYXArHEb8iRcFYGiIgk+qXMomnb23kCP84AN2t2J0Ks2H5Z3MQE66?=
 =?us-ascii?Q?tlGIzOiIm8HbBeyJRlNFTuPEarNGfhHwm81wCCE3LJECQjUjAUStl12TGSEi?=
 =?us-ascii?Q?twz9eIYBfLTObDod23lNcaWBIn7PyLjatHQDqMadpt8blXU5vLP6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee61204e-a0cb-4f96-a319-08df350ae298
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 15:48:17.8257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e8IWzvSW1C7Qzx3U2CboI7jEF6Uk0NrMT2LZyrcF4eCx3uJ9e8hKoWUqMrHxff+OS2UwFP1GYWl+uOpMvAxJeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8151

On Wed, Oct 28, 2026 at 11:45:28AM -0400, Steven Rostedt wrote:
> On Wed, 28 Oct 2026 11:16:05 -0400
> Yury Norov <ynorov@nvidia.com> wrote:
> 
> > On Wed, Oct 28, 2026 at 11:05:58AM -0400, Steven Rostedt wrote:
> > > From: Steven Rostedt <rostedt@goodmis.org>
> > > 
> > > On 32bit x86, _THIS_IP_ is not defined in asm/linkage.h. It happens to get
> > > included into lockdep.h via kernel.h pulling in trace_printk.h which
> > > includes instruction_pointer.h that has _THIS_IP_ defined when linkage.h
> > > does not.
> > > 
> > > In order to remove trace_printk.h from kernel.h, have lockdep.h include
> > > instruction_pointer.h directly.
> > > 
> > > Signed-off-by: Steven Rostedt <rostedt@goodmis.org>  
> > 
> > Reviewed-by: Yury Norov <yury.norov@gmail.com>
> 
> Thanks Yury.
> 
> Peter, can you give me an Acked-by on this patch and then I can add it to
> my series to remove trace_printk.h from kernel.h as that depends on this
> patch.

Steven, can you share a link to the series?
