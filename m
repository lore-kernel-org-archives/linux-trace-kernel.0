Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.17
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793210082;
	b=QjzV5/SORGebbofYOmjA7yDZT17bevEMO6knG9PRtvB1AqOuI5ILQTOzMnEUg/efof4H
	 kSER4185moY5yQru1aDaR+bkiq71E7/aQIe7TPnUZEgBDTNvLpDE3Wc9/ZOanmKSfZ2Ir
	 ELdTtkuVsx291TGU1G9XufRi0uBAfERQwJyl83rcFpj033CwWjquEN2p9eM205ISeqDGI
	 wnm5RF0B62IpKBUknmP1ogEtj+U1gWsqim1kpnwz21yfpEpiL86gjPpKtdyoXfig1fJDb
	 b48gjUBAOcRWcJSYPylecd/gQxN6K/SbFhmOZQyX9ZU6xa5VdqUpoApZrleE24S3l7g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793210082;
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
	bh=2G2kiG3xHgxTX7gFqGJTtrk0WpJ+QB70yLqVPUCeLms=;
	b=q5Wsi5mcDeKjf1ujIkQkqtOrUNfyWPtrMAffe8/7fe/16gcS+d2RErf1DMrwb2N1YLaN
	 dbLqJ9+eLPV8IOjjrGIGfdcLmLR2rRrnwU8G39U8eBufKKvR3X2v3ZbGClsqld1NNCDFg
	 beZdrTfwt8CGD4+YSxGoMoPkBdiUxTdDYXNLl6AxM8ic/QYLFQ51FFXzyxmVNun2ZIgo1
	 Gr2Js8UtYXFiGgJTFGmPG88l9CCx2i7KOmGZFTLed7yNdu3542yrq0wjfMUp82TQwUoR8
	 RtWoEry5T71Xh7bbVZI25DUjsoqURd1y7RQk7LbXvF1VHP0a8caxBi7kr9DpG/MMCCw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=nDe8WZCS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.17
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012017.outbound.protection.outlook.com [52.101.53.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1160606A31C;
	Wed, 28 Oct 2026 17:54:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1160606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=nDe8WZCS
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DOyksNv64G5Y8MK/un4o0r6zyvxhGcoeyMThL6CCTJTNkte/GeiIXojoYBajpPmKfJqhxrAgDccyitIeImbWDLDsxR0+VYgPCClRljGwUS9DhitfIw1DRKfOf/FVDAVdiQS1zxmJ5QHSVrXyCT083UF4bny/mTgAIW64kKE/C3y+OxGgc3M8sE/XNODRdF6FyrzdgryCQyPz8IBdOuDUHLuNK0pouty3rAEmDNVOs9z+hwWZkLh0fganftrvhJCt//G5Ozp+BzK/2agQlkLXxYaWAgJrpWz9Rzj6OTIh+2/yEj4zSAJRLe3N5HkzjiW3SIZaWxYFizoPieHjXVgSUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2G2kiG3xHgxTX7gFqGJTtrk0WpJ+QB70yLqVPUCeLms=;
 b=Bvjc5XxgdmP9Ujv97Sp9k88p9yqZbowzpp2DchWV7CZ7ncQDliYPGBo5fENrZq26bf4YN1wFJzKSCXxcMwJ3Gzxj4mN470q1RGLgmqdvvrc/FXjZOQPogqcfMHZoPh8os9bFgy1rsk5adWjfjlTf8vfHRAWqajsKk9BUHypCjf6R7alQ48mCA42SeqLxgkx2VACv6Aqx61aw1VTj3DG9W8ZKxklnKA4+rQZGtL7x9j5V0hNUeYxhIofVlSHrpQg1JDliYsJvw6nL4qJ7WCnx8N+toKLEcrQwtSzcDrV6EWKh0oeejj0v2ZbjQqNGSejB4dLzPIFBDhe4FrVFWdgQkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2G2kiG3xHgxTX7gFqGJTtrk0WpJ+QB70yLqVPUCeLms=;
 b=nDe8WZCSN8PbB3bLNyXVeJmSpV5g76NOqaWsOyplfRYPk+YGO5kIPA7S9CwtO3g/RFJPTcVFcQeSmChV9bUkRgS7ONAxUyCGE0gmXxw1O4XcfwYJV7aHGQ1Ulh5+8aWMeV/Ty66oGAoeN19DP2jxLqc3lfFvRU/QkYd9v4XBetmYKqJZyRfwUQ9IVO2u3LL5UiH2aai5O121/bc965vz2eF/gdwR1WXXPhZuEyoSy6yYwFlUhbqkahemLAqqEf8oDIUrlTosbF/zy6PFptvABkc4Y+7pgagK5rN7R5Ips0+BVfLEGqTE1i+I0yPCE3uTbxmipcPDevx0GgVxoWozWA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by SA3PR12MB9107.namprd12.prod.outlook.com (2603:10b6:806:381::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Wed, 28 Oct
 2026 17:54:38 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 17:54:38 +0000
Date: Wed, 28 Oct 2026 13:54:35 -0400
From: Yury Norov <ynorov@nvidia.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Yury Norov <yury.norov@gmail.com>
Subject: Re: [PATCH] lockdep: Add #include <linux/instruction_pointer.h> to
 lockdep.h
Message-ID: <auI22-Woy8ap8cz-@yury>
References: <20261028110558.623a92d1@gandalf.local.home>
 <auIRtQjGjb0yeYCX@yury>
 <20261028114528.137acd81@gandalf.local.home>
 <auIZQDojrrv43MrA@yury>
 <20261028123051.0c65e19f@gandalf.local.home>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261028123051.0c65e19f@gandalf.local.home>
X-ClientProxiedBy: SJ0PR03CA0241.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::6) To LV3PR12MB9356.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|SA3PR12MB9107:EE_
X-MS-Office365-Filtering-Correlation-Id: e664693f-2eff-40ca-ae33-08df351c88f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|23010399003|366016|1800799024|22082099003|18002099003|56012099006|11063799006|4143699003|10067099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	l24O9Eg34/j+Y4dtYzurxblfbPIIaYpb6/yzm3F98HeVY05kKB13CGMTdLmUyFOov9Mo00zO60UtAzsqv7WGnqSxJW+I7ybivFWGrkcPm+24EmhpPh0lp85kAiy+F78BThwyiwgqW+OQl/mu7BP8wbDeZQx0kZtYd7iTHq0SNvKnRcp+YKhp/0+Uknjva+yyRo9e17loCncDXFQq+6AmvlMd26auIAz1npGjDQM2KS13ABjILjEyzNGkqmJUWck5i9wgZEr/S68rs0QC+vWkq8ahtHrKXa3mxi0LN+7cvLgjsWk7rK4835e8l1xdxA1qvdd8FRX6ufxVGQmGAObW3ZZmc7mN9T4Wi607PGVpurFKLnn5NejVsUj62EvxLeAn5EUNWECWL3DpWFL7ACFCKTE8XUPgMV/zsIOQnXN7nO3xKbHRXYuGKY8iIeO5yus26vK/ItnqjzVwTKfP/wSCDTq1cGOmA+oyKebBVN6ItxTgyzUdXm/5NoSd/5mNNhlLrXDltfUuSXmqSErb3RxqBx4bFqxrDZ00TzMCZ/xKeEfRTG26ilE/Y2t0oNnXVUSCcYedpp3L2rssaSh9/7gCyB5pvDKUwPZK/CDcJ2vZyNpgkHs2wbrWrqdgOrKQ3jSY9dI6uwAXaUG7SU5q/7QBQkdyNe0ykXwZCENM21l6Ins=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(23010399003)(366016)(1800799024)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(10067099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gUNH8U7oeFfmSifRMNpr+oWNssIe0JRjsuQTqcH4z9QyVWP4GsD1ogCXNYE+?=
 =?us-ascii?Q?lTRPVkPkPnHrjQjYQFc6mbtknumh5vbSnVb8hVNOdj2eGbCMCT83TW/k4AK5?=
 =?us-ascii?Q?A9ssxbEpD6SVelk0hgV1ZNTVSH7TXqAWymZorvIdMYOEfsWwst3rWP9TFIV4?=
 =?us-ascii?Q?esc6wnRtcNl808CHWSxQj/A0CyMaqDVhZIkbkS3fWVMsACxnIAeuBdt5TRb5?=
 =?us-ascii?Q?txqnDSyOk8bnj3Jy1G3bV7oTY0h5sv/SkxubUpFAUAS+n1jDQbAz9ndzZvVX?=
 =?us-ascii?Q?EmOexF5RNFIIbzqe1cl+7G1sOw/wIdQZAYgtjdfh0bov7AOxZ40/mz1n82Di?=
 =?us-ascii?Q?YePp/Et11463FZipbuRVDyHRGATcYjfEEwOBiTsBRTV67v1X//c/De/8ETcn?=
 =?us-ascii?Q?pmvDpTXC7srg5oWvlXQwnKF0zgSUf4vcCjN56HPQk5th5Lsvi2HwJDmA1/n8?=
 =?us-ascii?Q?d+DHgsWs0z60WUrwNr46KollxcXpCQAHYU+2Cd9E1VIOLAlv/F+EOtJ9PQT6?=
 =?us-ascii?Q?+ZETn3/lSIdw/s8et6siRapnh5fUffApYLKqTZLEJUMeDyZ48Id6436nFAQq?=
 =?us-ascii?Q?22OuJyJBYdL6eiDUbEeoAUsAg5s7PPFk7NF/sZa48dw1fjUdM6AJ8xvYb/gi?=
 =?us-ascii?Q?fYyDFFRGIUR/8/lSTN7f63bw5WiAqCa/9HmaXI1WJ+7k3JFy3tXgGsP3ZJHu?=
 =?us-ascii?Q?8yWcsl317QklsH+FIXUnkIGJiW1+K/0Z7fUviLbq0h6byiBQY+vqLIvah4gk?=
 =?us-ascii?Q?f20s8xUE9epNsrC7KDFaQG/9TFyeVAJHCgeNhLzSwjbuy8OKjs8we9EdrjkC?=
 =?us-ascii?Q?c2kWyQX5ZoTD9y8es/VH/z41hxiDiEXrS7qDRt6dYjE1yOd8TnffOXu/f7eS?=
 =?us-ascii?Q?UwBSyiyGtXBCryDfXiVTzkxeiMldP+r8YR9WvPl1XS514MsF+L1DC9uJXRW5?=
 =?us-ascii?Q?UtxgDRdf/nuK0SuDSR08wya+Sct/6M6m8WVCr2lC4tkyG7FSDU2PnAEIAika?=
 =?us-ascii?Q?Udq0ji+UfNx418FJeSNyDMHokmscyv78sXyKb8V/NGFzePAeuv8s4K6diYEg?=
 =?us-ascii?Q?WZbxsjLRkTUJaHSoygnX4Wx4ZcAdjBVLBtZZ7YbJ3NxOvrtfmv3VBi8f9jZ/?=
 =?us-ascii?Q?L6Y8QoI/3DTL7hxJ6t9juxQ2jPm3deHjplBZvG7AU50/l6glbtK5kvnX/Cae?=
 =?us-ascii?Q?wBQXQa0ZWP2pshdYMPsHiCYsYFzEaZ+3zdKjphWpDufiOQ0InyViaYNZGCGb?=
 =?us-ascii?Q?EPeg4JVKowfK/G+NfgoZRcjXwJdty8twMqnnq1i/ds4A1PDmVkVG6mS/pAB/?=
 =?us-ascii?Q?+xe/7g+zFThTwX5Wf8OVEXAt9JaKEre564D85QLkuk4T+KzjoJPnrlJN7+QL?=
 =?us-ascii?Q?4dslmflYQutTpJepdxTifw8L+P4pfpp1s1c/J5ae6VHoq4gpe1ihuR1duMcS?=
 =?us-ascii?Q?ZHw18UwV9a0rEhYr+ppbj5iSiM7s1l4gd+gJmH8QchefWOEACGsBZqicMgmB?=
 =?us-ascii?Q?TQBC7vJeE/Gkzq2zvsar7tP8+SNzXucL0ia6OjS7gbgU841u0HuPb0fUGBl+?=
 =?us-ascii?Q?zP58lXXckaLlPk/b5oStLv/d5Sql15QEaLzTeG6NbvaWIRkA/NgQfr19ZDkc?=
 =?us-ascii?Q?a8IiJcgLBiXKreyUx1Dpkk+8O/4uWbll+YbtjLRv0vpx6JYF+IxSzPP9xace?=
 =?us-ascii?Q?Hkf8vh3sRm1v3iEqHTJqd6yDonG43CitO6h+h2frWnJfIz7qkBXGJ/MAPiVz?=
 =?us-ascii?Q?ny9eIcWayQa4SCnw4aiXoDWPChju/NdHTyvaMr1kVmDRlGYGc4k4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e664693f-2eff-40ca-ae33-08df351c88f3
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 17:54:38.4863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eLXRnPih5XhI9d2Rf3K7j/KaiBDddqgRUwyKtuRcFQwdkQ3qQuCwaqen1iSo966M0w+cf5vQFT7LXFqmiLH9hA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9107

On Wed, Oct 28, 2026 at 12:30:51PM -0400, Steven Rostedt wrote:
> On Wed, 28 Oct 2026 11:48:16 -0400
> Yury Norov <ynorov@nvidia.com> wrote:
> 
> > > Peter, can you give me an Acked-by on this patch and then I can add it to
> > > my series to remove trace_printk.h from kernel.h as that depends on this
> > > patch.  
> > 
> > Steven, can you share a link to the series?
> 
> I just applied my last series:
> 
>   https://lore.kernel.org/linux-trace-kernel/20260625104007.041432666@kernel.org/

Hmm... Seems I overlooked that v4. If not too late, please add my:

Reviewer-by: Yury Norov <ynorov@nvidia.com>

Thanks,
Yury
