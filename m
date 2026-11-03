Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.101.90
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793720953;
	b=lRwO7KeAYPfoTf6g5StgEpyBRYGNTYheb7F1EBYxOHpjTOHJE9+Zx9sQdiKF6PgY2trT
	 XhKHqGEBK74XLnF8KJ624yAh9YZhCp8WYnH4lWtbtTAxx57xtNCUXlXWzIg6NFOVMhvVt
	 I/FJiDNFUik5OXi5G15ZOLO9rQLZkGhA9jIDo6bIOPQKmja92E3Y+YV9qR5GguKphzx0X
	 IrjlzCyXYDQLlId4xX99YPGmLl/4AMDx4IZ6cHiN3h9I42PTuP2yMbfrrM1vj7wq3P31M
	 GnT0wt/ceoxFcSERPu+cj2VMwvCrkXBYIQwceap60ND9YMs0KwI24MduVzwG4m3jyoQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793720953;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:Content-Type:Content-Disposition:In-Reply-To:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
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
	bh=G2XykKOaEX7XUj1gS14Gn+ztX57QDQUXLilHcM0crdY=;
	b=mgrjy9F17Df4s+MWi2rkIm1jNjrBY4xB4tUGZhmHTGgeZH0TFKk77WoCBkBuCQEp5i+g
	 TQU4u3kf74wQlQYZbdEROTnIGNaBm0zVOy/sokvLH8aLYswlbji7E5uPImMuBL1hE6oai
	 fk6+VxVq5luIZUtVzkqoijtP53LzrCyuASq95X6SKWOmJZlrJCbAMQS+sN7QTH+tFH6Xu
	 my81UPtgqc/7FX5Pr3CiN6Q2KtC0F6UqitVUAqPm51NtXcZTpQ3ZGM50OIyW9heTQ0/FQ
	 4Y0e9OIrUd2f9k927pjNurh81PJt/rxH07uwFhZE3oVyEqEG3D9xznRrTRjcXe5I3kw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=atomlin.com;
	spf=pass smtp.mailfrom=atomlin.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.101.90
Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022090.outbound.protection.outlook.com [52.101.101.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4406606A326;
	Tue,  3 Nov 2026 15:49:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4406606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ndo/vIWw1x34Mc8lXtE6ITp+Z2onAABvLJ2E5jfKRp4Jj6hs5alPbDzVjtjpPiwlmuIntoMk8gjbG9wMgA0r6QR1d7tfw6bgQp6P0W8oh9Z35aF0uTKfuWUqGVUjzz4IjYUe9xFpSpnVD5Zu4SeyXH6mbBwbWyypRCZw4WTwDqhXRGAw8W+3QPE3quRvn4bLRpqx8h7x0WiXdyPQi28KYnN1u9jBCQig7CJE0AFVJ/kH2BGUNWmGLGaeXUWbtKIbDz0cDmfuVZi70lQ0a9dLZPbYBPoANf03rY6PY27mAdrYPbdAsFvJptuevm5aHElhOTv+Vo2VchhIIdXnqTtC1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=G2XykKOaEX7XUj1gS14Gn+ztX57QDQUXLilHcM0crdY=;
 b=Yw2RrgCDYy55dUYGKVM1zjbUh2vkaBzIT7epvpMhRfcyuBXJHcxo2HrGHpg6/+ICgEWozKpZGDcSRgj5qZAKb5MS4uRNCA1s+iDDNcMUxxoPkOSeT65mgBhUCkgWN9AM6h4JQFZ+OsELZnwOE270Ridy8lU5ZSR0lKyF4M18eo5kfm2xEklsF61z+Ey9DPTDxQ18pLF1feLrmjfNhIkIgTNm6qpqPjWs4LSYmyre/hw8dYMAimRoUlZbIHQlgXU57rN5q9Y3Kehz7fAz5adL1fpE0+qLl2E26XQY2408CDF+nA1VZj1NXnd2pv4Y/1mNH2sz35D3Ixb+sPHAkPXTeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:163::8)
 by LOAP123MB8863.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:49a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 15:49:08 +0000
Received: from LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f71f:a9f:c4de:687a]) by LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f71f:a9f:c4de:687a%5]) with mapi id 15.21.0592.007; Tue, 3 Nov 2026
 15:49:08 +0000
Date: Tue, 3 Nov 2026 10:49:04 -0500
From: Aaron Tomlin <atomlin@atomlin.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: pmladek@suse.com, john.ogness@linutronix.de, senozhatsky@chromium.org, 
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de, 
	vschneid@redhat.com, kprateek.nayak@amd.com, akpm@linux-foundation.org, 
	baoquan.he@linux.dev, rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org, 
	ruirui.yang@linux.dev, david@kernel.org, ljs@kernel.org, liam@infradead.org, 
	vbabka@kernel.org, surenb@google.com, mhocko@suse.com, kees@kernel.org, 
	anna-maria@linutronix.de, frederic@kernel.org, tglx@kernel.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, brendan.jackman@linux.dev, hannes@cmpxchg.org, ziy@nvidia.com, 
	bigeasy@linutronix.de, clrkwllms@kernel.org, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org, linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev
Subject: Re: [RFC PATCH v2 4/5] printk, tracing: Support console flush
 suppression and tail pinning
Message-ID: <ow5u2gfpdarlp7b32p73j3rp42zbr5bvece5mteyir26arjq57@f7rklmb6wwk3>
References: <20261103024453.922373-1-atomlin@atomlin.com>
 <20261103024453.922373-5-atomlin@atomlin.com>
 <20261103095512.7b8c2d3f@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261103095512.7b8c2d3f@gandalf.local.home>
X-ClientProxiedBy: BN9PR03CA0956.namprd03.prod.outlook.com
 (2603:10b6:408:108::31) To LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:163::8)
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
X-MS-TrafficTypeDiagnostic: LO2P123MB4190:EE_|LOAP123MB8863:EE_
X-MS-Office365-Filtering-Correlation-Id: 181ca7cd-7f3c-475e-b7ab-08df39c1ff44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|23010399003|1800799024|4143699003|56012099006|261009223027099003|261022105027099003|261021135927099003|261102123227099003|261022075727099003|261021121427099003|261028144727099003|261026140227099003|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	7LYcTW10L6p70KlGrtPwtrGjWfFHYM0S4Jqc8UbcSguHFj2cW/3aR4Y+L8CxlkLKquXsGnEflzhWql+cNszvoK7/gFECE9M997IszXmPrw512VkyJFXDUP3IQCYEDgHeNlrTyz35QdYIeCQ8rmZDTOPMiAqc4mPW9bl5kssRBJRt1b1T3SQ6VeuY14gesNgaFUeGx8Ea7xBWfFCc5p05Ttr7mpwtJl1XY5UWzNwvlqR+fayy7Rj2b1eS2Y4eGaVBJI3lXeygm0l5HGAXjQEKgywS+/6fOQctnpJfdZoylCK54ECLcpqdV86BtdMKI/TBGlVB1NF5lWQZXn60ClOwKJJfOEwH5pYYTYqgPClKTlZwepUtfrQXRkQs3qHjcChkf9FsnqZsuKVdheEfaoR9bvDt/iELyteJBAWTqEBPIA2CWy9mqBZSxIhWQLbd1709WyCf+kRbldGqmI/Jzt/6INhVwyTvKwLU7YLOjMNa2tpXB6m7mHtTZmQDtl4bgf8mMAz5ZG0faYQpWN+VyU5/NnCbNnzj2U7KDdUMUmJd43NZzJpXAVXX9hGaqYPVsSfBjDBIy0+4IUrwMPwXucUwvNG9peMtTGZ3UYyV84G7673i4oxj9KlpiH64XkSXtJtIhkOdoOPBYFoAky1DHpKlE40jD7qxg+75P2v/sBWCNI8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(23010399003)(1800799024)(4143699003)(56012099006)(261009223027099003)(261022105027099003)(261021135927099003)(261102123227099003)(261022075727099003)(261021121427099003)(261028144727099003)(261026140227099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bVNRQk1MSEtVcWY1MENiMldpRXdFZENQd29TQnBRQUYra0pGbTJPbTNCNEI0?=
 =?utf-8?B?NTM0Si8xWGFzMFVkbWE4L0RQRjBvdVpTNlBBQ0E4eDVJdHpXYkplQXYwQmRu?=
 =?utf-8?B?OWtzVndNZWFVK3ZmTUw3M215bGNTUktzLzg1c1l2MUtNMnJTd1Bsa1RZTHRW?=
 =?utf-8?B?ZHdCdzQ5UjRBOXZQQVBJLzgyNGpMTi85T2dsclpCVU91Slc4QS9ZU0M5U0VS?=
 =?utf-8?B?SkdQVFRyRyttaFp3c01jRjZyNTB1elZKc3RPMkhpNzNKWVMvRitGa3orWUUv?=
 =?utf-8?B?VlpCZ0hKZXNGaTZ6VkRDczY5Qm5lRmxocTYvR1FtZFU4KzhId3V5cWZQdW5n?=
 =?utf-8?B?Y3BMUUFUMzdOdnRXd1cybUFaVFU2bkNVL0dENVl5eXRuQmV0QkpQNWVEQURF?=
 =?utf-8?B?WGxwTVFaU3lJOC9TTFpsZzRqOXYrandhSFJUbDRpdkxYK0dSam1NaDFLVStv?=
 =?utf-8?B?My8wRTA2VWVPWjA5QTZEbVdFTFJwY2ZuUk9CNytwM3EvWnBZeTVyS0VRUnlv?=
 =?utf-8?B?WnM1ZjVPNTlPTDRMb3NwcUxxaDJyckpCMktoM0dNbHRodU9LNVgyQ085Y0JE?=
 =?utf-8?B?NnFydldHRHNXNXVPdGlob0cwN0FQZHNpTXdoeFlrSDR0VFlJajliVWZVbThX?=
 =?utf-8?B?SG1ucGZJMnUxNy8xVkE4U29qSnFtWmgyVXVrT1UvVXRoY2h5TVlUd3BCUHR1?=
 =?utf-8?B?a0J4aHBNdXRZRWFLS1FqUlNmTldXRU15QlJ1YXZ2ZDVBdzJnWEl2MHhadWdL?=
 =?utf-8?B?TjhnYzFDWE1GSjFMZmlIaXBNV1lORjFiQkpDMktTS21VcE1LcGZWUTZvSHU5?=
 =?utf-8?B?YXJCVUlnZWQ4andFNWFmNGtJV2V1R1lTY2QzQjZTU2tTWUFTTno5LzVUY01X?=
 =?utf-8?B?ZUpmNTVNYTRVYzV2U1hNKzRIVndVcHg4WjQxOWhkcDhjakw5UFpRbHZseXBC?=
 =?utf-8?B?UUJ6Uy83Z1hiVUNpUXY2QVhHQmlQYWdDUndzODg3Tzh2MG1jelkrVEh6SlBu?=
 =?utf-8?B?Q0Qydnd6bVhUcEcvN1M5bEJhSnNjVFNpa0FCSGlTTVFTeGw0b252ZlpmUFFC?=
 =?utf-8?B?ZHh3NnYvbFRqOWx2Y210bUgyNkNYa1UwUVM1SC9Pclh5WEdybjJhcTg5Y2tW?=
 =?utf-8?B?UzVCa1JqL2hMMHR3VmxQOUQxOCtDRzFIMHY2K2R6SzRzc0RvQWtqNmpyUHpK?=
 =?utf-8?B?K3NGMkc3UnVOM0ltVGJBd2tBK0h1WEtPUmljWFQrckJXbEtJVnZNSFFhYWRU?=
 =?utf-8?B?NTFDeVo0eFpWSzJDOW5iZklkYUVSUUc4NW5RenNOenpSUHdFRWRjUUNQdFlR?=
 =?utf-8?B?eWZ3bUI5em1JeEhNQTJ3cEhLMGZNZ2IxZlRyT2pkQUp0aWV6UUNCMm5sNzZB?=
 =?utf-8?B?RHVjZXJ5b2hEcVV3aUw0STZyVld4cVZFNlIzcWRvZFZuNjdqa2dDaW4rWlE4?=
 =?utf-8?B?K2ZmMjcwdzVCYUFzQ051WEJic1hEZllYQ3NNZU1QRnhnRWZ5OURCQ1Zxdlox?=
 =?utf-8?B?Y1EvczRSb2pmQW45cXR4emZwMUFpOVI1cEtzSW1UcGpMNExZcTk3QVZYTVdj?=
 =?utf-8?B?N1VRR3R4OXZBbTUvQ2RETERrWm5hc3NmMGhIdTFnSnl6aW82VjRGQzJLUmxr?=
 =?utf-8?B?bXlhTEZwU3ZMTVYxaXVncGV4Z085ZVJCeXpXODBpZXVFbk1GZ05LWjVWOEdn?=
 =?utf-8?B?VU9kZVJpNDR5VHZFeUFlZyttRUZNTkQrclhQa2dnTlROTEg3bzI5MFlTRGNI?=
 =?utf-8?B?R3ZVSGFXc0JodC9nbUJEWUc1ck01Q1VFaWdJbDN2WDNTOVdrWFZ6Y3FYQTcw?=
 =?utf-8?B?eTFZeDFzbEVyR0FpN0ZxQzl0ZTJ0Q2xmLy9hMGNLdU5IbGpML0dtTTlnS0RB?=
 =?utf-8?B?WjhxUXIwNlVhZ01yYnZZODcycjVUNmFMR2hadVQvQUNTSnhZNkMxQTM0Vmg2?=
 =?utf-8?B?RmR5c05EQTJCTFBvb2dJbWp2NkI2WVpyMDJMVE9wOFhIa09rVUhLTnc3T1JH?=
 =?utf-8?B?dE5tYzJaUGR5ZEIvT3pCSDJML0NhcExjS2pvcC8xZFhvTmJOTVlFUFliQmJT?=
 =?utf-8?B?L0Jzd01uMG1jR2Q3TGtDdzBwQThSSUwwU3JPK2o5eUtvZXNMcEhBN01sRHZl?=
 =?utf-8?B?Y2dlWEhMWUdhRmVSNXNRNHNBUDh6SjUvZWpxV0hlMHNYZGxvSE5zdEJJMFFs?=
 =?utf-8?B?U2xxRnZzSE9HenlaVHBjVDc1ZjhEcVJUMmhkQUUxUG8remFIQ2xVd1VIQjdl?=
 =?utf-8?B?akRBbGhyQzhMNDdBSGltbnpCeFV6ZjVLWmp1MmVkRWh4Ri82RFZRR3pCd0FX?=
 =?utf-8?B?YlMwR3I3Y1hFQ2FXQXQ2RXJKQ2h2NHhvRElQTm5SVHhDaTN2YUJLZz09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 181ca7cd-7f3c-475e-b7ab-08df39c1ff44
X-MS-Exchange-CrossTenant-AuthSource: LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 15:49:08.6471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ogMQhGivZRbxD489Prv79NSdFg3UPIb7XZgc3pNmWvH55y80y8Vd5KUHhh+R4jaYPJCicHMF8RX9DMNWtWGsSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOAP123MB8863

On Tue, Nov 03, 2026 at 09:55:12AM -0500, Steven Rostedt wrote:
> On Mon,  2 Nov 2026 21:44:52 -0500
> Aaron Tomlin <atomlin@atomlin.com> wrote:
> 
> > diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> > index e8c4efa8107b..35a56f04e9b3 100644
> > --- a/kernel/trace/trace.c
> > +++ b/kernel/trace/trace.c
> > @@ -9519,6 +9519,9 @@ static void ftrace_dump_one(struct trace_array *tr, enum ftrace_dump_mode dump_m
> >  	else
> >  		iter.cpu_file = RING_BUFFER_ALL_CPUS;
> >  
> > +	if (printk_is_tail_full())
> > +		goto out_enable;
> > +
> >  	if (tr == &global_trace)
> >  		printk(KERN_TRACE "Dumping ftrace buffer:\n");
> >  	else
> > @@ -9537,10 +9540,13 @@ static void ftrace_dump_one(struct trace_array *tr, enum ftrace_dump_mode dump_m
> >  	 * and then release the locks again.
> >  	 */
> >  
> > -	while (!trace_empty(&iter)) {
> > +	while (!trace_empty(&iter) && !printk_is_tail_full()) {
> 
> Wait? Is this to prevent overwriting the printk ring buffer? If so, this
> is wrong here!

Oops!

> In your change log, you mention not losing the initial oops or registers.
> But if someone is using ftrace_dump_on_oops, that's not what they are
> after. They want to know what happened that lead to the crash. That output
> is at the *end* of the trace.
> 
> By stopping the output of the ftrace buffer early, you just lost the
> information you are looking for.

Agreed. Because ftrace_dump_one() iterates from oldest to newest, stopping
once the pinned printk ring buffer fills up retains only the oldest trace
entries and discards the end of the trace leading up to the crash.

If a user explicitly enables ftrace via panic_sys_info=ftrace alongside
crash_kexec_in_memory_sys_info, freezing the printk ring buffer tail
defeats the purpose of dumping the trace buffer for the exact reason you
described.

I will drop the kernel/trace/trace.c changes altogether and skip
printk_freeze_tail(true) in panic_in_memory_sys_info() when SYS_INFO_FTRACE
is requested. That keeps console flush suppression active so the dump still
completes at RAM speed prior to kexec, while allowing the printk ring
buffer to wrap so the end of the trace is preserved.

Thank you,
-- 
Aaron Tomlin
