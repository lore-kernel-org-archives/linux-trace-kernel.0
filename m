Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010053.outbound.protection.outlook.com [52.101.84.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C311FC0;
	Thu, 27 Aug 2026 18:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787854917; cv=fail; b=iNdzAIpcCGfcMjTN2g8KU51Twk3tOJ5fx2G6a9Wi90NYaSrIr8HZozC1g9ypZMwDvlka4RCKQnQ+hUj76nzGVk58yAjp+B5jYwFjn1YRGf+Y6ayq3TUGCj7YD/DfTavDnAVsJS/KC93fooJOvqrvNwn7EjBGJOCA4y8S6ygYYiw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787854917; c=relaxed/simple;
	bh=wEJff84vuh5BjQP559KKlfrbhkyUfwImNKzfpE8HekQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BO5tW3ibGCYZ72Ohxg6lPLTBW4GkLheh1KykgUSabMuqi/oQ/nGw9/tk/5oMGSdttcc8gz7VidDKVEeKnjA4M+p+nLA/mcbdTItGJ1YzGHyPZtzAosX1Odqjg62wmE6KM8AlyYSZtARn59LBB/mwBO46V3doYgpLFvSxYNB8k9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=BOAMcXgV; arc=fail smtp.client-ip=52.101.84.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="BOAMcXgV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xb4w46HKJBM50iuz8pb3CKT+2lhxq42jH9kj6cuzDLmBtXbf1SmMryANwp8O4dBbqOUlc/mTIrt5pUy5ddTsbdCpqQVJ9c5QuERHkOkr8DAGOunJ8fua0MPaIcnWPMODaNOwBzZh3P8qCWR/jnyTrSpbH9vLW5orhgv2b1/hRC5nb74T6H9Y2Ot/3+P0SgkWLSbT653qrSk/LhbeWXpei0GwMtQzE9DI0l/7SUNCguKsbxpl4y6OXQRq0iI4KX1D8AEpekMkjoyQU6T1EhZzZUSERtXcIcaU6aRxp9rArGNPdOHD4o8gkoNkkRmB29oPnr1elPiDn1oROtEr2eqBzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9BeK+h50HdlDVI75NYSbs2LA3ON2Yh6gXBy2lIPXVho=;
 b=kfmok2w6DobPIU9X8Q3Kh5yK7z8qzoDGnp8W87vvLyhZtZAEV/ArOYOBT3E7C/2CtWrTlhs+NDUgmohg+brjdg8FQfhSzyd7RUU1wN/zHCFYtfforsyZWug4SKTvkyrYesiEktAhYa5ex/ehsVXLIUYf1+ljPRoOde9xj6ddNEsnaSSpkNooZ2Yrk4N03YnA8c5X23sLq/42NjTAmPi+whrrTiLO/E0mL+DNHgVaHu6FEFJHqtepzXiCFk9WFt1NowO4WHNKVMgSYpx8xVKJhfPpn0BH9+0L0VLrJAa8Kk86rHs8wy79iExRWPNWI4mhTM9ZEvmKfRdGvSHzxQaRKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9BeK+h50HdlDVI75NYSbs2LA3ON2Yh6gXBy2lIPXVho=;
 b=BOAMcXgVw/8p+3NaSLa84HREAU1I3t5WB5Hsk6jZNDSqghU44MJ1Sc4hjoaXjvm7C6C/p81w7e+jI0Q05AOczXjgkW4hjzyTqR37O8noBSMCZlt22noAuOJb7NlqGor5H0SqO70Z/KR5dp4tUIcpMGM0QzGqkTbO0hO3cTSxv8E8dEiax6noMzu9bAsd/qCv27n10BVH8T7mItJOtztxpwqOR/Wamug/NsurSam4pi4daY7EBzgngoTa8PxUgKj9Pn/n0Um3LjhxJoYhmQbe5HVUluhPVu91GXEKik/DxODtbctPLNvDtXOpXVl+/smEfahXBFY6PaPHSFeHGZaFMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by AS4PR10MB6088.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:583::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 18:21:52 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%6]) with mapi id 15.21.0339.008; Thu, 27 Aug 2026
 18:21:52 +0000
Message-ID: <aa25827f-5377-4e60-ac1f-c6565071bcde@siemens.com>
Date: Thu, 27 Aug 2026 20:21:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/3] rv: per-edge dwell-time statistics for per-cpu monitors
To: Gabriele Monaco <gmonaco@redhat.com>, Steven Rostedt <rostedt@goodmis.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Philippe Gerum <rpm@xenomai.org>,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260827072400.45734-1-tobias.schaffner@siemens.com>
 <40084ae4b7139fc20543a8989cdc349cf9b6bcdb.camel@redhat.com>
From: Tobias Schaffner <tobias.schaffner@siemens.com>
Content-Language: en-US
In-Reply-To: <40084ae4b7139fc20543a8989cdc349cf9b6bcdb.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0177.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::16) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|AS4PR10MB6088:EE_
X-MS-Office365-Filtering-Correlation-Id: 40c8365c-f22f-4ec7-8e03-08df0468110a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|23010399003|376014|7416014|10067099003|18002099003|22082099003|55112099003|6133799003|4143699003|56012099006|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info:
	cU32FZuhZbULxIX//xO5YHTJuvSl+LQjrv8Lay2soQPN87VycwzgnMaDmgbBqU+sRyVps/mKU8KzvRPuw6u4tqkW7N2NQS8+B2j9ZckyNYpntebGiqxowiQUPyNOzCzBDikOP9RoZhA5smSXqXZ66HftX0N+z1vBJtpAQLvL/qLfTKjzJOzCwBAKcuIctsAM4PLvWL8LYmLMGXq9G5wW2J4vooUC3O1YIqNFyUUrYdJF/2LAQd9LV//hebu13YRrfLCn+aLrkckqh5YbPBLu4azGxsvj6/kxkt/v6GXqYDTjkLvGnNOO1CTYesgVI8wFQtBBQcGkBpFwVViy36cFL4zJS8QHxfkpA/VGmxfztZ64mH3YtEm8CH8qOTCH8yUtBe+l/X6CJYb/zPwpdwChNk3N7sh9bUQzYuV+O6UB1gnL3mt7hxnyapyYUDalEApJX7jIoou8NK66uBcXN3m0XmWsELC68h+vwVVN8NxNgxdw+a72kq14VWFvnir/3FyRf3ki1r+Av1c7/BVXDOXQnQAD9Dj6xb1yM6BFMR55XLkeDdV1iOI6t06DiB1jetXmuE3/Wbmm4gwSeEZ9zpYcM48zyy42F2gQ+qUbOWh6yohXjz4A+Krg9AO8s5eTNgScDixdJFb4994gFC1510tkSpsO38/FlAUC+lnonuAM5tA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(23010399003)(376014)(7416014)(10067099003)(18002099003)(22082099003)(55112099003)(6133799003)(4143699003)(56012099006)(11063799006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dzJhdlNnNVFFMXhZNzY3aGRuWnNPeUZFMlNOSEtva2lIUTFOemtSWFpGTFhS?=
 =?utf-8?B?QTZJd3lFY3oxaE5tdG5ybzJtK0FibkVIaE1ES3RkTFVZcStIa3lad1pMU25J?=
 =?utf-8?B?MmM4MzRpVXEwWkNESUFsZ2JBdjQxZ3ZvMzNVbzBMSjRhYVVET0pTVTFqTlQx?=
 =?utf-8?B?UlBVbEZTaDU1Wi9ReCszYzY3bjV4eFh0WFBZTnZIOGVkSGw4dTdpOVI2Z0Zv?=
 =?utf-8?B?L2R5VEdIalh2UytickJuUTJxTG02anZjQTFhTnNTS2lRR2NTS2xDK2FGVVJi?=
 =?utf-8?B?cFZOdlRuTDV3cUFVNVBEOVd0Z2U3aXo0dHhmNWxlK0JQeWl6UHQwaXhwSmNN?=
 =?utf-8?B?T3FjWVlXUWpraUd0azdIM2V4TG93dGorWWhOT1F1dkhUWkRXWEZWVFlDTSs4?=
 =?utf-8?B?akx2b3lMcU9BOFo4SFNJVm1FMklRanZ4OHpuNDZwNU1Qb1hUQms3d0psdDN4?=
 =?utf-8?B?Yzg5ZDBpVzVGTVNQUk5peVVaN1NPejNPQ0xHTkt5OGczczQwQy92UndaOEs3?=
 =?utf-8?B?ZFFlN3hEdkllVGxVeU1ITnM3K2ltM055SFhrN2tBcjJoQUgyN20zYXRCclg1?=
 =?utf-8?B?aWV0dTh3U3VqZmtPb004bWwrTnNsN1dkcXZHSklxUXM4T1Y5UjR6SXRXb2FI?=
 =?utf-8?B?UENhVGNlbEVFMDl0SEZrVm5UOWRMMm5wT1VHTi80WlRWbDc1UFVrY3FudXlZ?=
 =?utf-8?B?RTVFMzFkKy9KSTNXMEZBOTVldTVHblIySDRsYUdUR1BmbmRWeWd2cnhPRlpY?=
 =?utf-8?B?elR0SFJHNGdpQWQ1M0p5Q0JJRlYzZ3ZBTnB2Mkl6YlVGbkFhdUNoNFEwQWl5?=
 =?utf-8?B?bmQ0eW0xa05aeEgwcHVkU2FWOUcyVUtQUnhueFdSaU80Rk9QNlhSclA3QmF3?=
 =?utf-8?B?QldGcmEzKzVGa2E1WER2andlN2dsYWxpMnUxdCtOYnZsYSs5Z0k3M2U2L2lo?=
 =?utf-8?B?Wm96cFMzYkVtbkpERGQwR05DaE1OSW44QjRMc1NodWRSRW1oUVdRTXRJd1R0?=
 =?utf-8?B?SUtDUGhEUG9PVm5ib2lDRlNGZEpXZTQwK1EwQWQ3Mi9zUkZYS3phNnBlWTBo?=
 =?utf-8?B?M2hMYjV1cWw3MWxIaUsyOUxLYlZPb3NjQmJvdmZuZWd6VWk4TFQvbDZtYkZr?=
 =?utf-8?B?V092eFhLa1crcjdJRUVCeWczK1dNT3F6b0pVV2ZxaDA4bXhhZUNLMUxRUlB5?=
 =?utf-8?B?MWttYk85MWRSSE5UU0N3T1pBb3NmUVpxR2RKZnY0NzY5YWtaNjhPQkZTb3Fj?=
 =?utf-8?B?RUdnRTBSMWRtVW9mM044aUFKR01lbkY4bDdBYVdqTmRWUHZ6VjF1OGw1MzFR?=
 =?utf-8?B?SVU5cnpkbnhsVE9MUUptZ1U2TnV3YnlMdFVKYUlTN1IxVFkxRFhuNE9COU5O?=
 =?utf-8?B?VEZuR2xUOXRUUE9qZjdwMkNWb2ZVRWhjMEFqd2JUNTdVa0U2OVJVRVgycjJP?=
 =?utf-8?B?YzhHQWd3cG9Ta1hBOHg4VGRhSFNMY0RoMFhyZ21TK3FTcUg3SEd5Sk5id25j?=
 =?utf-8?B?cm14ZzBNVEJDdFhvWVpGanFYdXJCMnB2S1Z0YThhWGxrQndWdWN4WU4yc0s2?=
 =?utf-8?B?aWxVZHljZjBuNXZtY0F6ZzNYeFNjNU9adnRMRnUxenRCRXNrMnFteHpsQTRK?=
 =?utf-8?B?T29VYkxvZkdYWHJXdGJnY0xDV1NqQ2xqbFlZNW1INVpIT2VDQkVXelNaMElF?=
 =?utf-8?B?blkrY1hsd1kvNC96NEpwSXFKWGtyL2dOU2V6b013eDVmS3hMaTBybzdKRlVQ?=
 =?utf-8?B?SXNlT3l2aWlKZTVxOGw5SGoycWlIdFJ0R01UUys2TVIyRE5IOFZvbm9qQ0lZ?=
 =?utf-8?B?dlM4M25VcGo4T1lrcWRWV1Y3N00rVHFxbWhaME9HcC8yU29VcnBKTEVPMTNs?=
 =?utf-8?B?TVJyMThuMC9iWDlid0lBZ0g4SVZ0MWRPL293ajBiUkU3NTFNTnlXUDZOaW5B?=
 =?utf-8?B?QmtYeC8wM1N3WDBUaTc1QlRjd3NyV0pOZ3lQam5vZjlKU0xFV1ZQdHRjSmQx?=
 =?utf-8?B?ZFRXR2IrZ0xMaElDUktBck9ZUTBwNzRZSUFoV3RWS3BXWXZnOGZhYXdOenBi?=
 =?utf-8?B?K0tHWFhvbVV6TnovUGFnQUNsMjFMbzMyVmpHOXFSb2dJQmlIZFY4cmdGcDZw?=
 =?utf-8?B?YWxRRXZjb3hJSnEyZ0F5ZmVRMEZ4cU51SjJPZ0IybDg0bW1DbFdXSGRoNjJi?=
 =?utf-8?B?OUxBdHlpRXpiL1U0WCtnTFNyeUxycmUxaTFJZjF3VGw0eTlUc1B4R2NwdEQy?=
 =?utf-8?B?dnRsSkJTMnlqVmp3ekJCTkdMY0hqbDhqYS9ZRXYxMkZSNllGclVUNGJrb0U0?=
 =?utf-8?B?elRNYS9IZlhFSGVibEhmWmIzVEFBanN3NGFma0F2ejd4Y01DUDZZUjZnNWc2?=
 =?utf-8?Q?dSYuRPLdC6LLyaZVOjeRs6sCQ8zWM1USZ7EMugiIoTWBi?=
X-MS-Exchange-AntiSpam-MessageData-1: FVK0ex/xNoYOSZ8nH4v1xCr70D19tsSHdZI=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40c8365c-f22f-4ec7-8e03-08df0468110a
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 18:21:52.1239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sbq5sG6f8OUokouipbulmSAj4qGnudmglHeO32De9J0Zr9tg/M2jZsBjAq5H9+JYzXcV17BQnyZ3Yo2lk/i9/8OqFzwbWYfj1ZACqQdGpZE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB6088

Hi Gabriele,

thanks for the quick reply and the motivating words.

On 8/27/26 10:18, Gabriele Monaco wrote:
> On Thu, 2026-08-27 at 09:23 +0200, Tobias Schaffner wrote:
>> Hi Steven, Gabriele,
>>
>> I am using the RV system for a downstream project called EVL (aka Xenomai4).
>> It is a small co-kernel system, small enough that I can model the whole
>> co-kernel with RV instead of just a fragment of it.
> 
> Hi Tobias,
> 
> Haven't heard about Xenomai in a while.. That sounds very interesting.
> 
> Since it's something out-of-tree you likely don't want to submit monitors
> upstream, but if you can trigger BPF events from your co-kernel you may want to
> have a look at RV BPF monitors, which I'm likely going to submit in a couple of
> days.

Exactly. The monitors themselves will live downstream in the Dovetail 
and EVL projects.

I will definitely have a look at the RV BPF monitors!

> Otherwise we can always get out-of-tree monitors as modules, currently not
> supported just out of a missing use-case.
> 
>> The patches in this series add a per-monitor "stats" file that exposes how
>> often an edge has been visited and the dwell time in the prior state for
>> per-cpu monitors.
> 
> The idea crossed my mind a few times, good you came up with an implementation!
> 
>> This allows me to not only check if the model is correct but also to see if
>> all paths are exercised by my stress tooling and to decompose the latency of
>> the co-kernel's wakeup path.
> 
> Your first need (see if all paths are exercised) doesn't really require the stat
> to be per-monitor-instance (i.e. per-cpu) right?
> You could have a global accumulator matrix, at least for count and sum where you
> can be atomic. This could extend the feature to other types of monitors.

Yes that's correct.

For the dwell timings, though, keeping it per-cpu matters to make
isolation effects visible. I use sum and count there to derive
the average.

> Just brainstorming here though.
> 
>> I think that some of the upstream monitors like e.g. the sts monitor could
>> also
>> profit from this.
>>
>> As an example, here is the sts monitor on a StarFive VisionFive2 running an rt
>> kernel (isolcpus=2-3), after enabling it and generating some scheduler load.
>> Only the edges the automaton actually takes are non-zero:
>>
>>    # cat monitors/sched/sts/stats
>>    # cpu edge label count max_ns sum_ns
>>    0 0 can_sched:irq_disable 367732 3998500 14773091250
>>    0 4 can_sched:schedule_entry 40282 398750 45510750
>>    0 7 cant_sched:irq_enable 367732 32500 532791750
>>    0 8 cant_sched:irq_entry 26188 6250 38357250
>>    0 13 disable_to_switch:irq_enable 4933 12500 12275000
>>    0 14 disable_to_switch:irq_entry 31 2250 35250
>>    0 15 disable_to_switch:sched_switch 35373 26750 111615750
>>    0 18 enable_to_exit:irq_disable 373 3250 649750
>>    0 19 enable_to_exit:irq_enable 373 20000 1676250
>>    0 20 enable_to_exit:irq_entry 309 4750 420000
>>    0 23 enable_to_exit:schedule_exit 40298 3000 37335000
>>    0 25 in_irq:irq_enable 31 12250 140750
>>    0 30 scheduling:irq_disable 40337 18000 45449500
>>    0 37 switching:irq_enable 35373 9250 72471000
>>    [ cpus 1-2 omitted ]
>>    3 0 can_sched:irq_disable 567 3983750 300860250
>>    3 4 can_sched:schedule_entry 150 1500 171000
>>    3 7 cant_sched:irq_enable 567 21500 1777500
>>    3 8 cant_sched:irq_entry 76 6500 164750
>>    3 15 disable_to_switch:sched_switch 150 4250 413750
>>    3 23 enable_to_exit:schedule_exit 150 1500 147750
>>    3 30 scheduling:irq_disable 150 1500 166000
>>    3 37 switching:irq_enable 150 3750 277000
>>
>> The sts model splits the schedule->switch path into separate states, so the
>> per-edge dwell decomposes the scheduler's interrupts-off window: on cpu0 the
>> prep phase (disable_to_switch, irqs off until the switch) tops out at 26.8us
>> and the switch itself (switching:irq_enable) at 9.3us, over 35k switches. The
>> counts also line up with the model, e.g. every irq_disable in can_sched has a
>> matching irq_enable in cant_sched (367732 == 367732). The isolated cpus 2-3
>> take almost no switches (150 on cpu3, versus 35k on cpu0) and their worst case
>> is tighter still (~4us), so the same file also makes the effect of cpu
>> isolation visible per cpu.
>>
>> The changes are gated by CONFIG_RV_EDGE_STAT and dormant until a monitor is
>> enabled, so existing setups are unaffected. When enabled, each accepted
>> transition adds one local_clock() and a few lock-free local64_t updates. With
>> the config off there is no code on the hot path at all.
>>
>> I focused on per-cpu monitors as a first step. Per-task and per-object
>> monitors would have to aggregate entities that share a cpu, which is harder
>> to get right, so I left them out for now.
> 
> As said before, I haven't really played with an implementation but I think
> atomic types may help here.
> 
>> What is your opinion on this? Do you think this is worth getting upstreamed?
> 
> I will have a look at your patches but it's definitely something I'd want.

Looking forward to your input! I am very open to guidance on how to get
this right.

Best,
Tobias

> Thanks,
> Gabriele
> 
>>
>> Thanks for taking a look,
>> Tobias
>>
>> Tobias Schaffner (3):
>>    rv: add per-edge dwell-time statistics primitive
>>    rv: add per-monitor edge-stat facility and stats file
>>    rv: collect per-edge dwell time for per-cpu DA/HA monitors
>>
>>   .../trace/rv/runtime-verification.rst         |  24 ++++
>>   MAINTAINERS                                   |   1 +
>>   include/linux/rv.h                            |  18 +++
>>   include/linux/rv_edge_stat.h                  |  60 +++++++++
>>   include/rv/da_monitor.h                       |  53 ++++++++
>>   kernel/trace/rv/Kconfig                       |  11 ++
>>   kernel/trace/rv/rv.c                          | 116 +++++++++++++++++-
>>   tools/testing/selftests/verification/config   |   1 +
>>   .../verification/test.d/rv_edge_stats.tc      |  32 +++++
>>   9 files changed, 315 insertions(+), 1 deletion(-)
>>   create mode 100644 include/linux/rv_edge_stat.h
>>   create mode 100644
>> tools/testing/selftests/verification/test.d/rv_edge_stats.tc
> 

