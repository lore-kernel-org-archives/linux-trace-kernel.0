Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013004.outbound.protection.outlook.com [52.101.72.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB704A8A39;
	Mon, 12 Oct 2026 16:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791821940; cv=fail; b=l0hB4pK1dPGox1QRkNd4vNl2gm3ZJ1d1XP1i1DPKZIoCXJqFvEKRAZ/dLnT69SNyLpEtrTrHamWVGRlPy9Hc3o4yj5zpEoU0oeiGTdj3eaqwiyGniyZZLPk5NClSo1dPWrn/2Alo4xnwbyNkXv/rqXjA/s/HVb08KAN4VDJpB0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791821940; c=relaxed/simple;
	bh=7z3IPNGuUtMgalLJlXBrFS5zIHhfP39D2s61JYRRw4k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=U3OdlvAvHX27LPJiMNj/mMRzCGlqBEXr0wR4DBzcGF8e0+iIYamERpiPJ8mTL9GwZh07x70ObkQZFAJXOcTdjP0TxkJ3suCTwVQw6QrJZdZbG0Dj0nxfYEwBQVwMozcVZWqUsjiNqZBO5w6gVQbvk1YA4TmL7dt5e+3+Ssz/wIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=mDpVl/Sj; arc=fail smtp.client-ip=52.101.72.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="mDpVl/Sj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bgk9W4SNf9EkSa+Z2zK423Po73QYf6HLiK5G/Y1EQiiO0WNVRGzBWzH4enK4SGqhjfB5Uizr8Ypdrdw5GoQqBcIg/LAJsWmLxOKXoGg8ytGmmCTOU3FUB7e+OeBByF48UTN+W+7h7oo56pXly6yPuZIrcrLRSwxENo32HLTaSlCPN9HOlNYKCo2kJqQ7/9Bobngnmmpxa1Ph2vOo/quqIPK4CUXBoXk68an94FoBp2arbB3DG1ui3nhmqm8f41yuBezk/worGxh8B3ae2TeUvbE3lXGD7lZ9Amtr/xCwWD5TdNq67/vuBTxjCF7i6JKHO20SAViJtYokIJjE53Mzew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ux4aYlZq9Dg6Z/tKAXhH9ZW+uKlQFCALNJ4Y5RevYlY=;
 b=PmBpvHiDpriHtg00rua2yhScuukXJx7Rfr6avoPs63IvUkRMw6SVBKriv4f2Roo4VsGHizzxGDW14vm4Y6T2YiVLeBRxvvtvfQz+Z6mCj6Z0wNvhGohhjxNXW8mPCTjhm9VO85RgsVhwcDOvZtnvDfjaBVc5wjlVPLzK1ha/PJNzkVDGHw+ax8v8Pw6f8SYnvFZWl4Xagkz23zEvLOaFJfV+K+dDFEdF/4AynjCoTYw7JMZ/ognPXyNjbjqlyYDK7Be34W6r6X4gIn4KiaaOAQtgtD5aTsuZfCZAIo9sEmV9d3RmZWY0MVNqWqFd1DGgSP/Nrjs3LBVW9OEhl5/Dvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ux4aYlZq9Dg6Z/tKAXhH9ZW+uKlQFCALNJ4Y5RevYlY=;
 b=mDpVl/SjW2ZKWD8l1YPPLGVpKPx5TRlxtYvGAdW+yLpt/laEwXGnrW4v0+W2Jp7HYBEj+wvRMZXxN5r7u1eLfvA2rA6hkv2QSg/BG1o3kHtwWe5fwnGE//GKAiUBtXNJZcskE4twUAX/FJyNqaTUG6AnnfleULXskETFfwLjgYSA8UQ7XOSLqdBl6HZzcdrHOqspBLk9bmFSFw5QxgeB8TSvHb4x+gqlOR9gWIZQADvpGvuBchZDUHq5YfG8isuiRtPii2JO+KG60QIcSTTYW70/XSNAB81Z1iKz3F8PS0xW46wLZk/XaXOjcsjEVrdaSRaAOmfVlYm38miDzjBmWw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by MI3PR10MB500255.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:290:97::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.21; Mon, 12 Oct
 2026 16:18:54 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%6]) with mapi id 15.21.0496.021; Mon, 12 Oct 2026
 16:18:54 +0000
Message-ID: <cfd7123a-e83d-490d-918b-154d45aad92d@siemens.com>
Date: Mon, 12 Oct 2026 18:18:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] rv: per-edge dwell-time statistics for per-cpu
 monitors
To: Gabriele Monaco <gmonaco@redhat.com>, Steven Rostedt <rostedt@goodmis.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 rpm@xenomai.org, jan.kiszka@siemens.com
References: <20260911123439.463052-1-tobias.schaffner@siemens.com>
 <4759c9b0dacdf1f9c0cf47158895860dbd0ec401.camel@redhat.com>
From: Tobias Schaffner <tobias.schaffner@siemens.com>
Content-Language: en-US
In-Reply-To: <4759c9b0dacdf1f9c0cf47158895860dbd0ec401.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0095.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::17) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|MI3PR10MB500255:EE_
X-MS-Office365-Filtering-Correlation-Id: f7298824-f61e-4637-6454-08df287c828e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|23010399003|56012099006|11063799006|4143699003|10067099003|18002099003|22082099003|55112099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	Tr7KJ0BJOEMcM3ZdGVQum0zVrajo3QmJQ9h7o98M3+JzL0TrR8MrdlNDjJPtygtT1iBAGOowysn5BA1w5B9qL/f1eJ71xL/Yo79U1GICCgD68z7niJQ5O0FYE+j/rleWj23oN1HHn/7kbyldQyOQDYB4yb6/wwWjuof4TxIbfvFWgZIfo8HLJlYzZ6XCTjKM1OxGQc0Wg02QAAnckxg/viX7dIcpXinck0F5dsuWxqZ9PPzfTCLL0cteXA8f5yFbH53BmtHqrhzZyjmFnQayY7Ec568iqvDBOCdXXmhRLMptKZSI7OmUiBOS+64F3BQ2wBTz1BtsyPtofxnmgTpRcXrtUzqSBFWGX7+erUmOXBu4ntQUtN/KTPrzM5/y0pIPmq8PDNTP02bjoCgT4DNRUACoRVlE+SMYu3bQSeEN5ozZneaf0yvN9DjeEgIoE9k1RYcCsp93C1qUQ1/QZyhpRwhMhzGOmMxXnXnYWO5koItu4Y0x6lu/YqxpgINdRl221ZIScUhkqApvTqKimJWxqXpgzkECG8ZW8zF3VQxsOh1bVF1HsmweROc/C7lhFf4epbQ0J2wlAuyq9G3I+fjiMpLLIv/eV42X0UHlIXfSckHvqGGeSjgTrLFDHB9qh7PLUNzqzer1GXqmr1n/evHGUv1s3Zt1hfjJpEHlsmK/IxM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(56012099006)(11063799006)(4143699003)(10067099003)(18002099003)(22082099003)(55112099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cGQxT3N2WkJYcy9yR0hWSHBuNTlkRVNzbWMzMGl0OUJkWGo4UnVST1htN2o1?=
 =?utf-8?B?WGtyaCszdklYMjdXOXcvMHEySE14ejhVSkRDMGtscWljY1Q1SGpacmwrTzJp?=
 =?utf-8?B?K011eDA1a21XRFc4OVc2blYyWThEak9xbE1oU2EzZ0habHlyWnNDa3E2eExJ?=
 =?utf-8?B?U0FjRXk5b25WbFkvZ2d2NE5vR2VQY2FsZkZKNTZaaWRoWVRqWi9xdys3RndL?=
 =?utf-8?B?R2NxV0x3VDhLam1BOU1wS0JpQUwxUHdZL3pnS2N6ZUl2T1k4TUNpZnZ0QzNX?=
 =?utf-8?B?RWdwajc3RlpNa01MeEFHa3R2SFk5a0VPMWRsUnV0NHp6T2hERHNzbHVRdCtn?=
 =?utf-8?B?bm0xd2lkUXZSQ0hNSER2UHVkV3UyNFhWL1A5Q3g0QTlQajhOTFNYRG4vVVN0?=
 =?utf-8?B?SUowKzU3d3RqSWNvOEoxd3lBb0g5Y2ppeDBkL2pLQjcvUW5sbzFCQW5EaERG?=
 =?utf-8?B?Tnp3NHJXNzhKdWxidFBjaFBRV0JWMVJQdzJYWU5uTzAzVDVRSElDUTdiOTd1?=
 =?utf-8?B?TlN0MysxL3RnUFBQK1ZhYXVrc3ZTVUdHRW8vVUxFT3hVUXdndGxKL1hSUjlH?=
 =?utf-8?B?b0FaRklQaU80OWxNaUVYVnN1QnFTTUpackhUMEkyZ2xodmVwR0lBdjEwbVQr?=
 =?utf-8?B?blhYQ2JwNTFCNDVnWnFEUjFXR1ZaeENWbTN0T2o3LzYzMXhGYmtsczBnTjdY?=
 =?utf-8?B?b1BBUVVoVTJQZlFER1VwcUtHYnJKWnJocFFSbG1Xc1pXTXVrTEJ0c0pzR1ZJ?=
 =?utf-8?B?WFByUDVraDF0U1FCMUlRT2c1bzNJTTI4RXVITmpsY0I4MXBLdlFWcDB5R0o5?=
 =?utf-8?B?VXE5UnFqOU95UkhHRTdaRmVZQkhYaHQvSkFFQUFrTitOTm5rUkgyR1l3OFhT?=
 =?utf-8?B?K1FHbjVVL01qN3FSTUxzT204RTR5cm15eThGSHN4WFUrWWFkUFVkaThMQ2lz?=
 =?utf-8?B?MHQ2eWIwcCs1Z1J1MzZ6Zm1LTTFaKzFJMU5LV3NsSURvRG1BS1RNc09MTWNX?=
 =?utf-8?B?ejFrZXVEdjhQRDBjQTRjckhhWnRSNlMzQ1JsaEREbDYzL1RMU2RFSGVoSE1F?=
 =?utf-8?B?R1A3YzdIWFdFYWNOSis0NUxJQWpxeWpDbFNXN3lRM1FVcy9aVldKVGREZ3NL?=
 =?utf-8?B?OE5BUWwwWmlRSm5BenZwcEJnejg2aUx3TUk3WHJIbmJQVEh2VTdncGtVUzlL?=
 =?utf-8?B?dEFHUm84bHh4T0pwWWVZVDQvQXNwajFMY2dJeEl2Y2JDbWdJVVIwNmJhV1E4?=
 =?utf-8?B?VWZjWFd4L1FVU2pVVWdxakpxVjVXTDM4dGM1Z2tJdXBTSzZiajU3TExCYnhC?=
 =?utf-8?B?TTQxNnFVSWNaS1lMQmpEdzVDMGtFUHBPVGdUN05XaVFCdU1RSmY2QVBIaWxN?=
 =?utf-8?B?RlZTSkpmUC9PR1F2WjNNZ3NwZjdiVzVDUkpPYkFySEdTSXRqRU94U1YvM1po?=
 =?utf-8?B?RUwzbm1rRll0M21XTGo3bERybkZYcE1nb0FEZGlDRnFmWU9hUHZBTGVkOFZG?=
 =?utf-8?B?RjdRQ1RlQVlmdmRiaUxLN3FtVmhwTy9ucWJja1JmOEtoTzhSTmFrU0hLK0Y4?=
 =?utf-8?B?TnRINGt3M2xHNUgvbDdldmpzbmlnVFNlTXFCK0huaXBIQisxb20ySS80c3A2?=
 =?utf-8?B?eURqZXErNFdZMnc2eU0xYjZvdHlCK1Q2UlU4MjdFZWFVcExBck1memtKb0JG?=
 =?utf-8?B?M1grVXhPWXFxOTVOSk80ODQvUzJYczhubFBDNUdNZ2JLQ3ZJalJTVUttbHhJ?=
 =?utf-8?B?YzVWVjlQSGsyZ2pRbFhYbFJiRXF6MHRPMVRMdjdvMVhpQWRKNGZTUERYNmZv?=
 =?utf-8?B?ZmVxS0ZWN1ZhL25uZjhleit5YjVZNDBsSHU4bGRjTjBGWXcxTm43R2h2SlJ1?=
 =?utf-8?B?NHg5L2k0ZURWMHBJWTk0K0xGTGQrcGgvM0dLMUYyRWZVdWcyVGp3OUQyeGRG?=
 =?utf-8?B?Nm5xVXBxNFNiTFp5ZFIyODNGb2JpbksrbFAzRHZYbnREbncwRVBIdUlHT3Ju?=
 =?utf-8?B?N3hNdXJRZmY3M2xPRXJ4Ynh2SG9sNlZ1aTFiSktRMFZHdnBVR3lpYTM2WUtN?=
 =?utf-8?B?N3RYWmFaZEtwSSsvL3d6ekZDck9CQWhVSDhyVmZHUCtZeks4bG1yMjZNaVp0?=
 =?utf-8?B?OUswblRvb2Z4VzZVTGlPdS9XMnJYd1Q1VFdFK2xWVzB4WUZRa28rYm1hTDdj?=
 =?utf-8?B?eTZQU3VqUGdUSmRpWlR5Z1k3M2JRVmd2ZHFIQms5MDJ5b3M2RHZhVzhFczNt?=
 =?utf-8?B?Mm5DakJQODBQL05OM2l6SFFxYllMQ3N3eU02M3FjZUxPSUcxN3BaL3hRMDJx?=
 =?utf-8?B?THdSczRjNXhTREN5cTlkTVRic0p2Znl0SzZsVEp5cno0UnFMeUNtZk5uV1Fs?=
 =?utf-8?Q?awuT0jTOZMP6n/+k=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7298824-f61e-4637-6454-08df287c828e
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 16:18:54.3698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yZBJ/gwUuLRmmMUDooUvhbf9EyWvDxG7duo7wtQJP1KTzUXLMWbNvwh3unYUGZpeeuuydQBPgpGTXe/L13aMQam2a0uXEkzVJenDcZKJLPc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI3PR10MB500255

On 10/12/26 13:47, Gabriele Monaco wrote:
> On Fri, 2026-09-11 at 14:34 +0200, Tobias Schaffner wrote:
>> Hi Steven, Gabriele,
>>
>> I am using the RV system for a downstream project called EVL (aka Xenomai4).
>> It is a small co-kernel system, small enough that I can model the whole
>> co-kernel with RV instead of just a fragment of it.
>>
>> The patches in this series add a per-monitor "stats" file that exposes how
>> often an edge has been visited and the dwell time in the prior state for
>> per-cpu monitors.
>>
>> This allows me to not only check if the model is correct but also to see if
>> all paths are exercised by my stress tooling and to decompose the latency of
>> the co-kernel's wakeup path.
>>
>> I think that some of the upstream monitors like e.g. the sts monitor could
>> also profit from this.
> 
> Hi Tobias,
> 
> there's been a conversation at LPC about completely migrating RV to BPF.
> While we aren't sure of its feasibility yet, and it will take time, it's
> something to keep in mind for new contributions.

Hi Gabriele,

first thanks for the reviews and for keeping me in the loop, I really
appreciate it. I unfortunately was not able to attend LPC this year, but
I followed the discussions and watched your presentation.

> First of all, would dropping RV in-kernel support negatively affect your current
> workflow?

I am afraid it would, but first mine is a niche use case, and
second I am not very experienced with BPF, so please weigh that in.

> About this series, I believe we could implement the same using BPF maps without
> too much effort, then the rv userspace tool could display them nicely.
> 
> What do you think?

 From an implementation perspective there may be a few pieces missing,
both in EVL and in BPF, to make this work. But I guess most of them can
use the patterns the kernel already has for NMIs, so I expect we would
find a way.

I have two more fundamental concerns though. One about verification and
one about recording dwell times.

Regarding verification:
The path I verify is deliberately kept short and simple. RV fits well
because the probe is a plain function call and the state update is a
try_cmpxchg that cannot fail, so it adds very little. A BPF program
brings more machinery into the probe path doesn't it? I fear that adding
this would force me to verify that the new RV system does not change the
behavior of the system we are trying to verify, and I suspect that could
be harder than verifying the system itself.

Regarding dwell timings:
The numbers you presented look very good. But wouldn't we lose
determinism by using BPF? If I want to use this as a measurement tool, I
need it either not to add latency or to add a constant amount. The mean
wake-up latency of EVL on my system is around 10 us, so an observer does
not have to be very variable before I can no longer tell its jitter from
the timings I am trying to measure.

Really looking forward to your opinion on this.

Thanks and all the best,
Tobias

> 
> Thanks,
> Gabriele
> 

