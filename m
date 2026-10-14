Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010014.outbound.protection.outlook.com [52.101.69.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABEC2D47F1;
	Wed, 14 Oct 2026 19:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792006081; cv=fail; b=TOawfl8i23W8Q9BC2pQRszR+L3QqsEu9WXuyN4q4Evsx3UjSWFwwxrR8xKvCSLhA7mmzPhykjv0cJPURjYKnGJ8H7VHL/CZpYA1I/5+sO9WyWv14zy5XyPTDwjLNhFUQV5zUn4z+gplRo+GwzL7QA4hMrm5Q2wsYousWdfkvDzM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792006081; c=relaxed/simple;
	bh=qZq5hW8prNK1AAzykpX725R/A4/P9sT9mpIA4Hs3kVc=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PpLvFEgVzTUSFYpmDcUdoDYI6hTlx5+mo0gYikvTcK123f3zDF2UsuOAllQRN0+jonj4s+aPUSonactvEtZ9xmjFxYpCgVSlyL82X8gXTlMuLGlA3SuTyY5Tj1G530f7oWm6M7pXkntRzBzd5ACaLI2OfzHCSD9isaRkr9BuSzE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=MLxpG28Z; arc=fail smtp.client-ip=52.101.69.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="MLxpG28Z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NjyWfdJr5OvHMeJTMvLF06bcpfb7Qq9DYPnaqIOWGQOwBMUpld27K+sxFawk9dkC1pTGl4CT1ljk8CKnMYAsdqRSt+z/i+ST3FTDr+mRD5S6o3m4TGHxPWCIu84BV9bR0cff+AOkAfHXl7SD9CsSZdJt24gqnrS1JZh/qsU6r9g2RzvyUQh+lsBVz2H2ye8n3S3oZHQSdrnVwRP7iMVoH1QAn0JTA+svNVCsehr0TczqmtPzc2BgObtVALGJr2vrUVuXvZz8WEhhTgmbVP44OjU3RTphDcnOUS+pdqIMza9uHFQOhmWyTvTrsHm3+AztvJdi23oRF5IV8+/DwkeI4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dGxRIABO5ZBEmdKGOyS/3pjmFdLsWcGI2L5Ldg5oqd4=;
 b=kmnxMe5lzdTu4/xmxA7Q4qtRy1sCVmo30UyNQUWk1JEWvJhi0hLchY0XNpaHjtwcScxVVxh3xORG7umrZHrPKppesglG92fqyM1W3QAAdOGRJ7Z+qgTTCkkN+vhzRYWb2zw5WQQotfB8l/gpc8GYumQ6btrkJQ2fUcO7IH7C2dTWYpd9gX8EGrR4lumQCz4XSmEZkJ/00+l/Ad880wp1F4rb8tJr4z/cucxShjYjoc+gbLOPzcteAM2jTKHtdrrmdywq8Q/KIB9TpFi+06SiSamnmAQ23W5W1hue77aj4LLj1SPbQjScbuHK6Gt1YHKgYbAJzJyPPevkTB/PDC0RkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dGxRIABO5ZBEmdKGOyS/3pjmFdLsWcGI2L5Ldg5oqd4=;
 b=MLxpG28Zf+/Nz/TGl8K0X7nPFWw/uYQBp6z7KTIrD0HXQgfHdSilgsTVzfeaWPP7kCBgf2sfa1K8EnvlVWWVTPzV5z5lfUV5uxCgTQfAM/yAfKmSYzSvMKTwZ3WEFIwxXxZpq9d6PhL/q/wXcAUD+llQm88kPzpcG+YXt6iIXSHBi7s5ykSVpd5JzJrLuVh5Fg3sa5U+AjU6kteSIGk2ePNtHftbgUBrS021bheZ9QZrkApTDe3Jn3lO9wVm1s5YA/f2NmokVWzjLj7gDl/MNg59ysBwFCTwdf5kcAbD4kNTUexMsqHH2cWqGQswZMB+fsZ9LOr8EHJOQyVIAjIK1w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by AM0PR10MB3155.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:18a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Wed, 14 Oct
 2026 19:27:56 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%6]) with mapi id 15.21.0522.012; Wed, 14 Oct 2026
 19:27:56 +0000
Message-ID: <3ac898ad-b367-449b-bb0e-841a4fc6c190@siemens.com>
Date: Wed, 14 Oct 2026 21:27:55 +0200
User-Agent: Mozilla Thunderbird
From: Tobias Schaffner <tobias.schaffner@siemens.com>
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
 <cfd7123a-e83d-490d-918b-154d45aad92d@siemens.com>
 <aa16855bc9ccc6b776ba4f513b86e3eadf889f74.camel@redhat.com>
Content-Language: en-US
In-Reply-To: <aa16855bc9ccc6b776ba4f513b86e3eadf889f74.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0072.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::11) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|AM0PR10MB3155:EE_
X-MS-Office365-Filtering-Correlation-Id: 8206d3fd-91a3-40d7-8a1d-08df2a293fb5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|1800799024|10070799003|376014|23010399003|5023799004|11063799006|4143699003|56012099006|261009223027099003|55112099003|22082099003|6133799003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	YcrnGiA1pPqBOJhmJ5WDt5trhJ1W5g5B/7rOjz4HTcD5l+9BuswHaWZc+ryMvF2Wp1tYyWPSN3pXswRaFlPfAuUG0pxcNSdb5NLWodpzfMCizedaBoZBUKvrcb/Vi+o3nKQWIj27gnB2tyB1M7OBYX12Qbjs/9OtPjDf6yjR5DlRpCjSxfyvGASLmPHtqIQHN22tTnRzNmm93A32W4DJYS7FddaloMoEXNQDOSQUttX+7BQuos1gbdKa/E9xeOdafvqQU4pqWCgI5s0HYEUJJw0wLFlm5mQiT4hy3Py8TEe9pr73JycSU/7A85CEus3OHl2f0DtcRK5yV2W0qVhP/4yAXrbDiFnqI+YjsPZqFsUmGmuWL0ByOl8Yn/R57bBdtX5Pc99c7+6r+zD+PV1TFLnRf0vhFtvjaTTrghOgEmeIZRuU+VwmO45Z0oInn8/BtvA/2Lh6SokTy0jjg/cRMVx+CTHT5XmRdLOBpJaKkS/7exljO6tRl23c6GTWGKPPwiUmsoYt0eqtjptxN75FA5RfD1+La05+NAj0lsC0RlOS9GaR1QXeEszsqvSiNYszJnRapDFZIhrQ9wRUazjXtzKsAoWJsSeooX4CPCgAYZ3huCzJWtfUZq8dMZ/8mfmHkLWi4xKmNoMcWV6F54mE2WJzuE//wkW0tSnGUV5kJT0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(10070799003)(376014)(23010399003)(5023799004)(11063799006)(4143699003)(56012099006)(261009223027099003)(55112099003)(22082099003)(6133799003)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S2xjaFFVNG5qUGxnSzIySy9XZitORmNkN3NXd2g4cC85VGNEK3RnTGhmMVU3?=
 =?utf-8?B?dysxNHFxckhsWktxWW9sNWZ5WFZjZFdaNm1nTlczbEVvNmZKL2FYY21kZFFE?=
 =?utf-8?B?NXpBb0NQTE5WdkdaSTNTbXk4czJIZndVTWcvL2k3T3ZOTTVjcnFtMENxazRR?=
 =?utf-8?B?bG15cVFBM2NaVmFpVkd2ZUI2T0c0aklMc1pQSVdScDlPZVQvSWVFUjBzZ0x4?=
 =?utf-8?B?dHJlcllQSzQ0aXNBc0U2NGhyaEkwZCthSU11ZjFzU2pabTQ4N1lLYVBWTDBV?=
 =?utf-8?B?ZFFPWDk4L3ppS0tKUTBHN254Qis3NFZId3JGUHVmRGVYOE5GVjc3RXFXYnhK?=
 =?utf-8?B?N0ZlZVhobHFEKzEyOExxTm5ieVVLa21ueHg0bmpETklGdFFWTzNLeXI3MnE1?=
 =?utf-8?B?alA2ak9aOWp1Z3kxV081WXQ0b0MzK1hlOWVRV1FzZzZqQWdad0MzNjhIUlh2?=
 =?utf-8?B?RlAwbUhtTVRzTW9Xb1JmQVZ3bnZMMWsyZUhIMVZxT2Y2UkNlakI1aytPZkNE?=
 =?utf-8?B?aUVKWWlLYlpnOTRrVXo3M1JFOE4welUyVjJyWkV0Y0hIbmxidHNRZDFSbUlt?=
 =?utf-8?B?V0QzQVhwV1RSaXY0OWdwUkU1Zm5lbXo5MDd2dGNheVVWb1BKM3BLZjlEYjd5?=
 =?utf-8?B?YUNHUi9LZWh3bm9ZUUlkSm1LL01RSUFSKy9sWmZ5SkZteFhTbUwzUC9rdWhX?=
 =?utf-8?B?VVBTZG5kS1FRc3VHd3FXdkd0ajZtalk1SktxOGljUWNKNXg1Yy9nWVZyTmJa?=
 =?utf-8?B?L2R5anNCK2xqRUltakJ6VjVMSFBvM2RFbElMYm9DVmJVNEIzMWJISDZ1cERs?=
 =?utf-8?B?cnZnSG5qeFRlZzZrN3ZvUSt2TjBUdTZ1SXZFekg5VU8zalFGV0NYRmlHM3ds?=
 =?utf-8?B?RWgrMHJyYWsxSzB2K2p3VUIwcHZ3WUpCeHErVElFcFhqazk3bXdsNjVkekVG?=
 =?utf-8?B?SEJVVDdvZmdXYTB2Zlk5amp6Ujg4eDJndnE5djEyU3YxOC9wL1RaVDR0VklB?=
 =?utf-8?B?b1l0dzM2d1VyeUV3VGljRlVmTE1lNlpFMmFKVVh0aDgvUisxYlJvVEorMFov?=
 =?utf-8?B?b0F4b29zM1lkcG1JSFRLeXdJVGF1S0VFNldLOWJ6SXRuK1NZRGhqVElmbzhh?=
 =?utf-8?B?K1h2OFU5RG1jdklRRFF0TTBIc3ZxMTk0a2xaemJtR0hBSEZJMFJtdjExc0k3?=
 =?utf-8?B?aVd1TWN0SVdDOUdvWnplOWtFSUdZNkl0cWtYSVhHWjR1b2wzSU1xZVM5Snd3?=
 =?utf-8?B?VUpwZlJ3MzB2SURGQkVwNVhyOGJiTS9rVkxrN1JqTXlFRjBOMlI0VVVreHp2?=
 =?utf-8?B?dUhCVStQaXpIVUd3QTU2NlVkTXE1eFcrbWpOdjhBWktFNUI0UnNjWlZFZFpS?=
 =?utf-8?B?TWc0bmo3dk4rQlk2ZUZpSlBUZGV3THR0UllBS1hjOXJRVkNKajVwRDhicUtt?=
 =?utf-8?B?L05iUSsrbi80US9FVnVhaWRiSEFoTFM2STFWOElodFhpVjhtS3d5Vkt4YTBj?=
 =?utf-8?B?VFVFaENhK2Q3bU9HY3U4WUVhYm5VbjFERUd6MFFKZ1N6MVUraDQ2Vm9sMFkr?=
 =?utf-8?B?RitqemhIN0dxYkoyL1h3TGhMN1drZ1Urc1ZtV3Y4K1VZeDhzSC9ibmtnbW1v?=
 =?utf-8?B?OWJTbjQrQnJvaVNzWXFVQlFFakVJV2ZJaytLYzBDZnVPcnZjNmtkaytlbVNl?=
 =?utf-8?B?WjVYV2tMMHJwd1F1aHF3ZVVFZFFnaENEellJZUd5S05sRnFodlpsVnQ2TTUr?=
 =?utf-8?B?ZVA2Z2pseWxrZlFwK3RDdW12dUQxbEVES2NheldZaDU2RVZtNm54TG5SMW9E?=
 =?utf-8?B?NnJhZlVYK2FRbEdDbkhCM2lFQkNRb243Tk1hcTlxS3J3SnJ6ME5WWjlBQ29u?=
 =?utf-8?B?RWkzdysvMy92MlBxbkRCMWQwTTJVcW93d3YwUkVpYUpOL3FtMzAyWnJoZDFy?=
 =?utf-8?B?ek13QkV4ZVNZRzlFVjI0K1kwTDA0MW8vNDRFSWJuQndrOHNWdko3UEozMk1t?=
 =?utf-8?B?NUNZMjhrRlAvckN5Z3FlQlk2RnJVS0ZsMk1QQ2g1NFFKTkxZS080dnBLZm9o?=
 =?utf-8?B?MW9uNjBBdlNiWnA3Zm5rSTFlSFl0cXF3dUhyTWFvRmVhcndROUVncmVSQ3RQ?=
 =?utf-8?B?bnN5MjVVbzJhcVBLUjBJdFozR2xPMVNFbS9seUxKSlZFSlhoRkkvdjZQNFgr?=
 =?utf-8?B?WnZ1Q09hSEtSUU55T1JubkF2V3lqaHBKVG4zNmQ0MTNkZ3BVQXFwbUZBUWxV?=
 =?utf-8?B?ZGV2cnJyM1pSeDVnbW9jVTJNNm1xZkZqaVhwdDVQd0lTTkpvOG8wU212MlFW?=
 =?utf-8?B?dFJXZWUxdjVpTGphSE9zY0JOS3VhdVBhQlo5eHhBMjd6WW9aT3E3b2l5dEM0?=
 =?utf-8?Q?2YvkwyiTOCNnqEuiz0quKoz4O7mE0vSNuXGs5A0KSs8IA?=
X-MS-Exchange-AntiSpam-MessageData-1: zA72t2qmGQyGHv9ifI+mqaeD2Orgff/Z/Hg=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8206d3fd-91a3-40d7-8a1d-08df2a293fb5
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 19:27:56.2286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EwAQiuAJ+DqedMZLXL7YL4xovogYHGvX4iu5iV5T1YV1x+ialFADWW1uRfKvtDMzs+xPAOzRxgJFczjKw1XhJ/ooTMXxbefipjK0l7wZE6g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3155

On 10/13/26 09:26, Gabriele Monaco wrote:
> On Mon, 2026-10-12 at 18:18 +0200, Tobias Schaffner wrote:
>>> First of all, would dropping RV in-kernel support negatively affect your
>>> current workflow?
>>
>> I am afraid it would, but first mine is a niche use case, and
>> second I am not very experienced with BPF, so please weigh that in.
> 
> Thanks for sharing, I'm asking this question precisely to find out all use
> cases. RV is itself a niche tool, so I'd rather not squash use-cases away!
> 
>>> About this series, I believe we could implement the same using BPF maps
>>> without too much effort, then the rv userspace tool could display them
>>> nicely.
>>>
>>> What do you think?
>>
>>   From an implementation perspective there may be a few pieces missing,
>> both in EVL and in BPF, to make this work. But I guess most of them can
>> use the patterns the kernel already has for NMIs, so I expect we would
>> find a way.
> 
> I'm curious to know how exactly you're tracing EVL right now. Are you having it
> generate NMIs to linux and catch their tracepoints?
> 
> RV attaches to tracepoints and BPF would do exactly the same.

Nothing generates NMIs. But from the linux kernel's point of view any
activity of the companion core is NMI-like, since disabling interrupts
from the linux kernel does not stop it from running.

Our co-kernel keeps control of the real interrupt mask, so Linux cannot
delay it. Most of the time what Linux disables and enables is a virtual
mask instead of the real one.

Tracing already works inside EVL, thanks to a downstream patch [1]. It
is mainly fixing all the points that rely on interrupt masking by
calling the correct wrappers.

I would expect that we have to do similar for BPF. Some of the checks
already exist to cope with NMIs and we would just have to make it
recognize our stage too.

[1] 
https://gitlab.com/Xenomai/linux-dovetail/-/commit/2fc39d2bb5d9ca1c0e898794fc0297eb04cf67d9


>> I have two more fundamental concerns though. One about verification and
>> one about recording dwell times.
>>
>> Regarding verification:
>> The path I verify is deliberately kept short and simple. RV fits well
>> because the probe is a plain function call and the state update is a
>> try_cmpxchg that cannot fail, so it adds very little. A BPF program
>> brings more machinery into the probe path doesn't it? I fear that adding
>> this would force me to verify that the new RV system does not change the
>> behavior of the system we are trying to verify, and I suspect that could
>> be harder than verifying the system itself.
> 
> I had a few conversation with some Functional Safety folks over the past weeks
> (the same people Daniel used to talk to), I now understand the problem better.
> 
> Their use-case was even stricter, that's why RV didn't take off for them,
> essentially they're trying to prove some more isolation from interference RV
> doesn't really have out of the box.
> 
> But back to the RV vs BPF case, I'm trying to reuse the exact same code in
> handlers, so the verification step should be mostly equivalent.
> 
> Assuming you'd use tracepoints (BPF can have more probes but vanilla RV does
> not), I guess you'd need to validate also the ftrace code that ends up calling
> your handler. BPF adds a bit more on top of that too, not much though.
> 
> Then obviously there's the data representation: we use BPF maps that can be
> quite complex, though simple arrays (in per-cpu/global monitors) shouldn't be.
> That would probably add more to the verification you need to make..

You are clearly much more into the topic than I am. I will have to take
a closer look to better understand the BPF data structures and,
especially, their locking mechanisms before I can answer this.

My use case is, so far, not that strict. It is more that the bigger the
tool gets, the harder it becomes to argue that it does not change the
behavior of the system under test. If the tool remains simple in the end
and I can describe its behavior as deterministic, there will be no issue.

>> Regarding dwell timings:
>> The numbers you presented look very good. But wouldn't we lose
>> determinism by using BPF? If I want to use this as a measurement tool, I
>> need it either not to add latency or to add a constant amount. The mean
>> wake-up latency of EVL on my system is around 10 us, so an observer does
>> not have to be very variable before I can no longer tell its jitter from
>> the timings I am trying to measure.
> 
> Ok that's a good point I'd like to investigate more. BPF shows great performance
> in the average case, though I fear it could have worst case spikes my quick
> tests didn't show.
> 
> I'd need to run more numbers to be absolutely sure of that, I'm not aware of any
> internal locks in the simple maps we are using (though I only quickly checked).
> BPF maps are clearly heavier (memory indirection and/or function calls,
> sometimes mitigated by the JIT). But if we properly set them up we shouldn't
> expect big determinism issues.
> Nevertheless, this is definitely something I need to look into.
> 
> The whole JIT thing shouldn't bring big problems either, once handlers are
> compiled, they should run almost natively, but again, I am not too familiar with
> everything that happens under the hood so take this with a grain of salt.

Thanks for taking a look!

It sounds to me that you think about moving the complete RV system to
BPF. Is this correct? In the end I will try to follow if you decide to
go down the BPF route. Possibly after some delay but nevertheless.

Should I wait with proposing a v3 of this patch set until you made a
final decision or do you want to merge this in the current RV system no
matter how this develops?

Best,
Tobias

> Thanks,
> Gabriele
> 

