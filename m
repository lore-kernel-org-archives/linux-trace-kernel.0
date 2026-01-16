Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012060.outbound.protection.outlook.com [40.107.200.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64839299947;
	Fri, 16 Jan 2026 14:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768575014; cv=fail; b=WmGmESHGPpyV82rpNyCcKqeAMxqzZZ8YGB/xNZ/5Y/u2q2Vhmrg1p9UfjUvI4mNS/cNQU6n45qcRYsm2YRWszE+nSW0bPP0yX2cOibnn3w070S3uDOm738z2p5+CR6oFn9XOfbKwFSomepvYHz5JEwP2gpb6PHwE13KUeB/csZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768575014; c=relaxed/simple;
	bh=AqaHoZ7iG2/F8K4ipK4M2XsV7Ylr2qq/43ZdvtAfK0Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=j6+7//Uif3qP/YuOn84efbSXKoexPye5m1Jj9yxEpZ5tqGLFpP5uawzdVIsx4iuj0gUAwD1OIE7avfgU92KfOUJKKryVbXCLeuh0rxwYkYD+6NmoFLNwiuSJEXeeK0e6oJFyC6VsXRmakC9bnH2zXLz1tpUp8KD3cvtEegiQutE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WFNQQM8q; arc=fail smtp.client-ip=40.107.200.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WFNQQM8q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sEflvtQM8XPiUi+BH+uvKLgD+FNPbIs0ux7mvOZcVy1iAuwGp4yDEYBwJs+s7pdT3akwj+EfsSko5CaRyIvN4WzZUe8K4R9QpCrt9W2GGvEQwN8gnFvsYUpvq6vaE27zyk509e9t2J26r3nq85Ui+I++33XHKFkygWfr41n7x0exd5gGgofw5FGQ8VfpGoE3hVW9H+S1oLteTb1JdwkypK9NrN1wmRMVNMZKnq+5VJ+ufrwgkL/dcADTq7pPJExohdcEKYH+Ro7Dzj3oJhmAjSqba1TMpw39i+hq/1LFFmnfcQ19y24covxMsgpMGWRfHujXvTcbswbYKpxGNLflbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1/0uBUA7DJH610dyt+0MX7UEW16JLZFq+0Sw9r5PiKs=;
 b=Xth/M9rir/7EAve+gPTMSo3xcokk1JrsWJ8QgzanAAqOGXOylYKSGMO/8KPAPwTvyPwHeksSo0r+vCIeYsqG/iualWOlyHTzHu9uihvYWsH225hsJ/cPJ4ZSU1XATddA1coLy0CP5O+ayTWr1E3CK9nYCbvutrp53HzLClqglt8EcKb4Vb5SjeCx0oODr3ERB7MmUG/0ck4qQNS3UjMkD/qeQoxkcNJtZy7meY2q/73rNCkEX/ZyFJ6Bhf4z4ZK5MBdWEAxlt2NUiW8zGreli0JsPPj8kTp+86liXH6aA2bP8dH8tRhL9UEnl81j/3a2LuwHsZJORpwHpOOhEpwyHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1/0uBUA7DJH610dyt+0MX7UEW16JLZFq+0Sw9r5PiKs=;
 b=WFNQQM8qXDIt5csshD4vF9/qP0HGTC85Nwh5bC0XLq2WXSa50k5fwiOOXqTGfLw8L9fXRt+IhU2lRDdR+y6Zg1ZglaJhNIDWRfU6IXyeQbtdsJgRDdUHrbJJ9OGQGf84Ng6j+lB/5XpUmorUgOtFWsN1N0FMBgt8DBgSBfEqToU=
Received: from SJ0PR05CA0174.namprd05.prod.outlook.com (2603:10b6:a03:339::29)
 by CH1PPF6B6BCC42C.namprd12.prod.outlook.com (2603:10b6:61f:fc00::612) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Fri, 16 Jan
 2026 14:50:09 +0000
Received: from MWH0EPF000971E8.namprd02.prod.outlook.com
 (2603:10b6:a03:339:cafe::46) by SJ0PR05CA0174.outlook.office365.com
 (2603:10b6:a03:339::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.5 via Frontend Transport; Fri,
 16 Jan 2026 14:50:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000971E8.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Fri, 16 Jan 2026 14:50:09 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 16 Jan
 2026 08:50:07 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 16 Jan
 2026 08:50:07 -0600
Received: from [172.31.184.125] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 16 Jan 2026 08:50:04 -0600
Message-ID: <17f243a1-8977-4d52-aa26-d4556d62e12f@amd.com>
Date: Fri, 16 Jan 2026 20:20:02 +0530
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/15] sched: Add task enqueue/dequeue trace points
To: Gabriele Monaco <gmonaco@redhat.com>, <linux-kernel@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, Nam Cao <namcao@linutronix.de>, "Juri
 Lelli" <jlelli@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>, "Ingo
 Molnar" <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	<linux-trace-kernel@vger.kernel.org>
CC: Tomas Glozar <tglozar@redhat.com>, Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
References: <20260116123911.130300-1-gmonaco@redhat.com>
 <20260116123911.130300-11-gmonaco@redhat.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20260116123911.130300-11-gmonaco@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB03.amd.com: kprateek.nayak@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E8:EE_|CH1PPF6B6BCC42C:EE_
X-MS-Office365-Filtering-Correlation-Id: c0f744c5-1ad3-40fa-08e2-08de550e8bb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SGZkdXVTaFVWMVM4WjRFTW9jZG5QK0VPREIyM0tEYXFidWxxME5yaGRlTSs4?=
 =?utf-8?B?NjgyNGh2U0lCL3JTRmZzdVh4OEJQOC9oNjhQWVIyeStaQ3lVcnE0UEtCaXNG?=
 =?utf-8?B?eDVIb1NGM3drTml2VEl3K1ROU0hTS2xhRTNXU0U3ZnpacTcvbmpmZnBrWndi?=
 =?utf-8?B?SXkrVzJvbE96RnFhUURFd2xMb25MSlpVMXlGNDM3WVVBRE5FZThra01FOGVv?=
 =?utf-8?B?bEZiZ3IyZWloemtOK0F4OFB6eTF2WkJPQzhQd1VLaUdSNzhQNUFvNXJONEhr?=
 =?utf-8?B?emVNNWpsemF2NVF4SjZwNHJKZE1rTUdPZXJIRWVQbmphaTNtcnFNelhINWFN?=
 =?utf-8?B?YXlqR2tBN0pmdmQ4OWhjZ0lqZkdGZW9JMTJYTjdxbDBhdU9HRXBRWmVPZ0tG?=
 =?utf-8?B?YTRVOE44Tlo3NCtEUFhHNkRhRmZ4MTFsREE0bzFBNExyWVY1YmlYZlF2bmYx?=
 =?utf-8?B?V2dVVFlraVR2b3BiNDhndUYvSXI5dzlTckZOVjlYaStFRGVVYkRDRXlPdnpn?=
 =?utf-8?B?TStOUlVBRkR0cEt2M09tL2h4MkRMdWcxY0RxT3JNQnZoRStHY3huTUd0ZCt3?=
 =?utf-8?B?QmhCL3gvQW1VczUxSzBmdjg0Q3duNHBjd21Pc0NzMEJ6Z1Z2TXlKZXhoRGt1?=
 =?utf-8?B?RWRablpJWC9NZ2xsSkJCam1ONTZKYXAyNzBPUHA5UENEd3lybXBQMnFaYUY1?=
 =?utf-8?B?ZlpNMUVhL0xkdlg3NEpQYytsZEtNLzQ2MEY0bzdmUWRHVzJzeVdwWDNSd2Rn?=
 =?utf-8?B?d3U2aUt3ZW9xUzM4MXZTOGE3Q3V6K0JmeVpHeUNxS25HSlZkK0RrU0VibW8y?=
 =?utf-8?B?SU5hdmh3bmtIS3dHK3pqWUovdHU5MHBzemRmOHFsYVp3QWxnZDNTNHJWUUQz?=
 =?utf-8?B?bDdBSThiQzJSb3Z2L1llcUoxbW9qUmhEbVZub1htZEkwV2o0U28wVzlFOXNj?=
 =?utf-8?B?QkgrYm5GS2lKZFE2bytNZnFsbDRsUE5nMFBSUU5LWHhYV3BkT3JKOEJhNXNK?=
 =?utf-8?B?RjR3STVFRmtmZ3hYV3NiVnkrTFFmdFFpYmgyTTdnTktNSjlEMlZvQUJVQm9i?=
 =?utf-8?B?emtrKzJEcGpOSVRScHRIT1ZOcDFuYS9uYWoxcnNkRmd0Q3J4cHUrRlc4cG03?=
 =?utf-8?B?RTRrbks0T1RUQ1BXY2JjcWs1NG9melN3ZzJ2cGRHeTdDWVd5ZmMzM1V1NHU5?=
 =?utf-8?B?dEl2SlZlK3h1TkdVaE1Md0ljVHlhbmpKTzFEdmxCMjEvSW1ac0dKOHRTOFc4?=
 =?utf-8?B?bVFEVThyRDRKUGlPVGdrNjlxWFRzeXBXQU1UbG8waCtVYzVSRENxODhHb1RZ?=
 =?utf-8?B?TlFOSjhtVVFYN1BsYWR0STc0U2wzQ0VHTG9Iem9zb1Bod0VlazdGcUx1NEtt?=
 =?utf-8?B?ZTZuTVNGYWFNbWM0aXRqcndaV0xRb0V0bllKbTlvRWVzUmQraWtUQ0YzS0cw?=
 =?utf-8?B?VDNLYkpKWmpkL01QY2YvekNUdlBSMDlWZ3N6OE5jenpFTHBYaTlpK2s4SFZW?=
 =?utf-8?B?WXovNzlXU013VGZDbWhTVWhLbGdpZ05sVGpBTU1FNjJoSzBucHNBWVhlanJO?=
 =?utf-8?B?MlFoODhJbVo4RTZIL0Y2NTJKbU55Z3l0TkM0NEFRY2JwZEFjNXo4YVIzdVZl?=
 =?utf-8?B?VklSWnNVUW5BN3NJdVlPZTh4WEF3cEdINlV6czEvdTNxVmNCcWJHeFpuNTBi?=
 =?utf-8?B?bElrOUptaGRGUzFITFgvbGI0SDBpM3d6b1MyUWpMNWlTK084T0tYN0R0MUdr?=
 =?utf-8?B?ZEdZWmpNb1VBWldsL1ZDVnZSZCtiMHo1bGVQeHNnUXJ5WTEzMHFZRlpIdG1T?=
 =?utf-8?B?Sm8xdGt3K21HS0d4Wi9uUW1wNk1WTHNiblloSzdqN25jUTYyUThTbDlMbGZT?=
 =?utf-8?B?SHF2aW1XWmYycnlLOUdxZnlWNTlseHYzb3AzY2FzdGJXS0JqUXd2NVMyQXlK?=
 =?utf-8?B?Tm1EdXhqZ01kNzRUYVlCK3F5VTd0aGFoZDZ3S2QybG9PV1BFUFBYNERGdzVK?=
 =?utf-8?B?VmFnV1JtcFlyVm0vRnVOZ2RPZHZLRHZGc3JNakNnMjNBVXovUENhMVVQVnYz?=
 =?utf-8?B?M3NKMnBZNXdsaDV5TTVvdzk4S3EwYmJVaWs3WFBMbEpWaDE3Zkw3emFKWEpV?=
 =?utf-8?B?QlBSZzlFbFQxUk5LaW85Z2RUN3ZIN2J4TWRXR1J6L3RYazYvMzhIaWI3ZUZr?=
 =?utf-8?B?czBZRGljOU5oS1AzM2NGeVpBU1hEamtkUkpmN0lHc1lLUUUvYnVlNmVIaEg3?=
 =?utf-8?B?VCtIUytSQ2cyN2hyZEdEQjRiTVRBPT0=?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 14:50:09.4068
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0f744c5-1ad3-40fa-08e2-08de550e8bb3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF6B6BCC42C

Hello Gabriele, Nam,

On 1/16/2026 6:09 PM, Gabriele Monaco wrote:
> @@ -2087,6 +2087,8 @@ unsigned long get_wchan(struct task_struct *p)
>  
>  void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
>  {

For delayed task, I think you'll need:

	if (trace_sched_enqueue_tp_enabled() && !(flags & ENQUEUE_DELAYED))

> +		trace_sched_enqueue_tp(p, rq->cpu);
> +
>  	if (!(flags & ENQUEUE_NOCLOCK))
>  		update_rq_clock(rq);

Since delayed tasks haven't hit __block_task(), they are essentially
still enqueued. Peter should be able to confirm. Other than that,
the placements of the tracepoints look good now. Feel free to include:

Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>

-- 
Thanks and Regards,
Prateek

