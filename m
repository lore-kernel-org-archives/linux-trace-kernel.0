Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020131.outbound.protection.outlook.com [52.101.189.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABFC2192F6;
	Thu,  6 Mar 2025 16:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.189.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741279054; cv=fail; b=AGgn01rsUzHa5+RYlUTUIecI2AiTBMQ7rM/AZ9P7VGMbCzJ9I6KD/tVaoUtLjX+GrLKDeR++aZULxVoICF2AK43YLPSKOs6QyLsxVEeXDj/yDdUz7T3W8vPClvnjav7lEGNQHdbjSX5HOmZw6dOBftEWrU/vagMv8ojhOU2dquk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741279054; c=relaxed/simple;
	bh=9YPufjKMxfHzpbcLVGI/O3ahpXG6oPucU9OVINqsnkU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jXM/Yfxy5wzJILrLgTkrr9mKptq2HxfSGyi6LRw9UCc3kYGDiVe2sAWG2bAxIqvefsFIqlBP28+D0IWux7Ck9lM3fowBqPBhb4A3MNlacz5XE4W9UzbytvPNHPBezBWLJHjx+r7AotjBI7ZZ0USWXh4swD/iG9vw8Dt82mGy3hk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=afb0FDqc; arc=fail smtp.client-ip=52.101.189.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="afb0FDqc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=egixUUR6nHD1nYWeB50Sc25196wuas8EyVjvr2ojgYOvsw45ZUM55nLLjrvWK0LIhLWgyQfjejIUb6JaHww1tGRrME2VTm2S9olQ5X4E/esQHTbUhSN2eijGfB/Nnaqoec4kmQTppUBXXpekV6+qm+82L66WQMbTy7fIRZ70IlVShrodChpb9hXwGwVdYtC4y8fi0K4/rgu3c6+9PxoF2wKcneKln5w0iMLWwB9BGtNxPy7KoUF1aT5DRCm1zv7SSJU9SOb51I6Z/TET/6N19cjcTVztWnlDbfQvnIvEAG6i50ecXm3o3+y+YfjcnRqsiUguMYZg0zmKzweruF8/Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L1qM1Ip9kmA3FsJIY0oHe5ArfA9FugPA2sbPKuUov3c=;
 b=FlQ7gqkha96Qj367wnlf3C7EUuW/s8IPtJWmhlry39GTQy46hSx4hi6rt5fYQpC1OO8FYZLPgNsfSHhcH1UcoMFqvKMz99zJ5K13tdx+Dg2/SlhDGZlzkwECXMkAoM86Cafw+zzjIq+yJ9xmoEhwI7kGbfnK655NV44+rpO0/EdVirnieCYgNubpDtHaekPtPDRVEk9OTOTf4LaeBw00qMfRIVQU1I5n9suzoNSwcf1tzzagWoSEgHERbw4PouhrqSblCKTICHcm3x+9jAzCe7Yxo8y92OiL+Y3T2oTeDKqf1V92ljJW433eihJPAisI1rYQcQONlz4RDoD0pkoKvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L1qM1Ip9kmA3FsJIY0oHe5ArfA9FugPA2sbPKuUov3c=;
 b=afb0FDqcCaniBzY8bATHOKxBOLsPd7TSfcN01S695HivxqOV+aqEDRqAoHQ5CnONonfxcvgelFyyyvsbviKRwzc7Tc2moc6fLm0m1VoBP0ABlqGP+LNn8k7Muo5CNbmbAfXFbtKwrXSeOQCCd4EA4uyWuEKops22ZKzSH2OXp70DSjRFfd+AWxqGOA1J+0xKjajDJDG/J8N58LHo1jX/P3CtN71AHeAsRzuUSJOK4OQ7uORLtRsWF16IKhyYGVk8uDP09LelMelag8QJakWpP0iHNVtpPO1Np/8q3lCOSDL94lShHxWRvnJg5If72xG1OU2M220xxzbt/VC0CqMbaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT2PR01MB5645.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:4d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Thu, 6 Mar
 2025 16:37:30 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%4]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 16:37:30 +0000
Message-ID: <0e691a3e-1406-4496-b7e4-8b1679b59b5d@efficios.com>
Date: Thu, 6 Mar 2025 11:37:27 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH resend ] tracepoint: Print the function symbol when
 tracepoint_debug is set
To: Steven Rostedt <rostedt@goodmis.org>,
 Shijie Huang <shijie@amperemail.onmicrosoft.com>
Cc: Huang Shijie <shijie@os.amperecomputing.com>,
 patches@amperecomputing.com, cl@linux.com, yang@os.amperecomputing.com,
 peterz@infradead.org, jpoimboe@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
References: <20250305015505.14493-1-shijie@os.amperecomputing.com>
 <f600edd0-8855-46af-98ec-1181db1f5dd4@efficios.com>
 <b098cbdf-394b-4f20-9dcd-393ad1b734b7@amperemail.onmicrosoft.com>
 <20250306101315.5a5f1d7f@gandalf.local.home>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20250306101315.5a5f1d7f@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0320.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6c::15) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT2PR01MB5645:EE_
X-MS-Office365-Filtering-Correlation-Id: f8949302-0272-4eab-bf41-08dd5ccd2ff9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YktzY3ZKOG93Rmx6TlltQUpFWEN0dllMcDl0VVBmeTcwcXdoUzhVcU9IRktz?=
 =?utf-8?B?ODNjRU9EMzV0NUppQTcrZmw5cG9kSHZ3Z01lSmF5S1hBTElENkM5ODBDRFpQ?=
 =?utf-8?B?NWRLcFBYRXNJa2ZqYXpYYU5uY1M0d3FJOVg5Ymp5Rit6N2pIUDZybnk5eVJ6?=
 =?utf-8?B?SzYrZXhjSFFlcnhPU1FnT0xhTGtYMXJsNERsVGJCL1VQVUt3bS81UkFJYmNs?=
 =?utf-8?B?cUIyRUxjV0I3b004TXV3N3FUTExpZUt4TmNFejI4TzYrZjREeUJXN1NaRFJv?=
 =?utf-8?B?clFNOUdBSHQrRXRLWkpYQ1FjU1dsdjJodnNnWS96dVprWVBaMldzcndVZWQ4?=
 =?utf-8?B?ZjlKczZ4UlRpVTY0OWRhcURkOWN4UytiQmR6NWlSbURUdzAvcXVEM2NaN3hE?=
 =?utf-8?B?ekxCTHE3WG5MUmhKOUFxc2JHVHd1eTVWVkFJOHBPYUtuNC9VN2QvTUxmV2JX?=
 =?utf-8?B?a3lvU3o5ekNFMGV2ckpQSVNOTE1GUDdwdk9yNmZPblhNQStBQXdhSnhnZlJG?=
 =?utf-8?B?elhvMmhVNXVlbDc4RHY5c2VMSGNzemJRbFZPdmVWaFdNd05QQ2lNOFVCeFdI?=
 =?utf-8?B?Tis1RXp2MElBbEFscW1qd3RNRlprMTRFMUVyaGxvU2ZFaFhtOUtKYzZDNVhU?=
 =?utf-8?B?Q1hxakJzQ1dmazBUWmszZ0Vwbll2bU5JSmJvNFdxZUk1SFdNY2pWYmdycGVm?=
 =?utf-8?B?ZCtxZFkrTUVaNGsvRnk0UkpYSWZ4YUNrV0NiQTZMM3V5RzgwTERBZExhb3Vz?=
 =?utf-8?B?WmV4SVZkMDY3OHdyb2dRYkpMVXQ2VjQ2bFlBN0RlNXhETlFFZlQrOEc4Zlln?=
 =?utf-8?B?TG1oa0kvQW52ak9Hb0o1ZTA5ZnBTaW9jSzBueWJkN2JiQmxBUURTL01wVGc3?=
 =?utf-8?B?NFFSaWtLK2V4VG1PRi9EYTdMd0p3RkxnUzdBUlhFNU03NldtbkdRRDZrYlh4?=
 =?utf-8?B?djd4WnMreTlhWGIwL0t5ZDB2bURZWGRwU3FUcFI5Z3c1Q3NSdGZXYWFlcUsw?=
 =?utf-8?B?b3NPODVsK2NySkJBMHpkdGxYOS9MbjZ4TC8rNVhsbytHYnhvSzZMcnB2RXpF?=
 =?utf-8?B?RVlWMzV2Nlhlb0xJRTJEUmNKYkcvSm9EWHBxYjJMdjhVWkYwUHRYalFtQ3BQ?=
 =?utf-8?B?TTJIS1BqQ0lWUzdidGkrbjBLMFhHTW40Z1V3eDRCWHI1cFMyMXNSeUZpVU5l?=
 =?utf-8?B?b0E0TVB3ckRMeEgwZXUvd0h1QStmOWUzV09id0pLNkV3NytSTTA3YWJaTEpK?=
 =?utf-8?B?Z1ZRRXNLNlZyWURxNllENzkvaml3L2R3ZE5sNzR3dHRoQjl0cXI2dDRvNHFQ?=
 =?utf-8?B?WmRibjREVWorbFI0S0xQa0MyQVZMOGlaSXNIZ2ROckNYWStSVGR4QlMyZm9Q?=
 =?utf-8?B?MDdkSHJlWjJvdVJlUFY2YktBQ2RDNC9uSEZnMDNTbU04Zzc4Z21BMU90NVM0?=
 =?utf-8?B?cGN3L1RRRWR5Q1cwT2hxS2lEeWE5SnN3aDNET21ETW5adXgxOUs4WU00YmZa?=
 =?utf-8?B?OXM4K0pxa1d1cWlkSVNFZ21EZEFUb3Nob1FXVmR1OHNETXAxeHBjMkEvbHZr?=
 =?utf-8?B?UXozaklwOGJzaWYxWXZWQVlGeFREZFp6SWcwMUZ3S3puNHFHN1RFVXNUUkZ5?=
 =?utf-8?B?RElpaXIvQlpua2pvUnYwM3dOQzVFRkYwSU9yK1paWWI5MXVCZFNMRktIM2k3?=
 =?utf-8?B?NHdyQ0hBNHRlaTVhU05tNXJKWllYL3BqRXhlTmdlTG9Lck5oUEZ6NHlYdkR5?=
 =?utf-8?Q?sbcDTwYZu88YW0j6F0eR9zuWt1N9At0utNiDF2e?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?amxzd1RnVGw3MlZqakdJb24rOXlZK1ZUbXZUSDlvQXNkOUNXWTBJNjVqNFdW?=
 =?utf-8?B?VWhiOWg3SzU1Y2hqQTFFckN1RVRkNHEwekpvQXRtK29mOGFGRjJLV3dEOFVk?=
 =?utf-8?B?WUI4NjQ0SXpLdUtXVXUvdE1Xd1pHWXZxcVVMem52eVI5NHhRekFUVkNhYkVO?=
 =?utf-8?B?QTVkTDMvTUIwRkNteFZTK3ZxRjhhdkdmbzBPT0RuSkFMTUZDRjdCc0xwY2ty?=
 =?utf-8?B?dWdOMHRIUHJVZXhudGdyMXg0TEQydFN5ck5xdmtMQjdQZFBGMS9LMTlwUGd0?=
 =?utf-8?B?bU93VDJkajYwYk9mR2JFQldLMmszdVRFR3RlT3dHUDRZK1JWNVVZcHBGMjZS?=
 =?utf-8?B?WW5rNVAvaWlMZXM4dU9PY2ZmZUk0VTllSnFQQTZ3NHZaUmhGSlZsdWszQytF?=
 =?utf-8?B?Z2Z4MDcwRzgrZmM3eDNpL3h3Tks0K3grbmN3TlZqQ1ZYcGxic1JialpJbFZh?=
 =?utf-8?B?eXlTeWRkMDJCRjNuVkdSZUtUV0ViUFNSS2NMaXB1Ynczd2Zyck9hRTBDaUJL?=
 =?utf-8?B?dmVEY0N6WEhqVkE0MzJBc0lDWkh4MU4vekVoc2trL3k3N2s0N3pVQXR5aTJs?=
 =?utf-8?B?Qm5FUHNLMFN1TDM2SU8zblMyY3dHKzR2U3RodDhuc1BOTHk2ZUttS0VTSHhK?=
 =?utf-8?B?RVBqbXZOSG1EWlNNWThaa004dVZjRE1FQVpiYWI5YlFZM01vdG1aQzJ0QkQw?=
 =?utf-8?B?S0pURzkyN3RmQ1QyaC9XV2J2RnZGNHRrZzJQS3NTWEFUMDduVURiSmVjYStL?=
 =?utf-8?B?ajFvdXRvNThWdmdvdTUxMFBrcWlzZEs4TDh1OXhGM25xeFlhMU9pazh2WXNa?=
 =?utf-8?B?cnlpQmJyVVZQcFRPYWNYd3pxU0o1ZUtvOExLcktLTUZVR3c1YjRScFkzOW9N?=
 =?utf-8?B?RGEvTW8vMG4rTXdTRUdGYVJpWjByd2FTeXBBRnN2MGpBajdyYWNWb21FSy9M?=
 =?utf-8?B?QUp1R0NST1dsMnBrV2pKZkJWVUk1NGlyWnpEd2lVcVdKdWJnZkxmd0xIeVdk?=
 =?utf-8?B?WGJoUzVCcWR0SkF0bHhidHMzdldkRUwrOS9ORlo4dkpta2xZRkc2bk9kVGpa?=
 =?utf-8?B?UDZPanA0YjFSOUV5ZjN3VkJzVkRZSHdKU1NxR2RzZ0t6TVdYeld6YllPdTFQ?=
 =?utf-8?B?aXhIME9ERFFFbnFmdktjb2NJbXR4SEJhYW1vNWlYMzFWQUhOUXRnMi83eDhp?=
 =?utf-8?B?TXVoc3JzbThVcWgxRlR6ZFFWQmFuUXpBNlgyN1d6VzJGWmQ4TEQ3dmd5K0N0?=
 =?utf-8?B?WHRoaGllaEJVRTFzd3VUbVpETjBSbVh1M3AycE5MUFQyOFpHN210cGRROEtJ?=
 =?utf-8?B?QWhybmpqQjJEbFoxSUVBdHpQd2xoTWtFTlY1UWlLSzZGVUJpZXFZUDFpUkt3?=
 =?utf-8?B?NVFXSHlwdlp2ZEFya0Z0YnV5QTB0TXQzYlBNN2EvQUdramwvU3dSdXR3c0N4?=
 =?utf-8?B?NGtTaWFQUkdwWXNEejBUWkJURWRKbmVta0UyemZJNmc0YXptUi9vOWpWc3Ux?=
 =?utf-8?B?aWx3QjFobFA0Z3hnd3FzekRaWERIRUZSUnVNblUyTWxwU3F6STVOZERCbGdE?=
 =?utf-8?B?TmhsUGpmOW5XeHBmR3l5d05UT0tSRE5hNGNSMkViUWpHSlZUMTlPYkEyZWdE?=
 =?utf-8?B?Uzk3anluWWsxY1dOT2hhR3ZDTHFYK2NiQ0pMTUtmY3U3UWhEcTRLd1VHYlVE?=
 =?utf-8?B?UnVPOWc3WXBRbkliZ3BtMmJ4MVZ0Y0NTZmVRV0U0L01obk9sZU9xUG4wMmpE?=
 =?utf-8?B?YThlL3NXSHBjQ3RuNHpyaXRBSkV5Z3B6ZGYwQkhTd05Bd2p6TmZRdVlYRE1i?=
 =?utf-8?B?OXRaTm8ydW4rcjVrTWxtQndpNHdxT29namUxNkF6RUdGM0U0TmZscGdFcFh0?=
 =?utf-8?B?dFJsVjV0NEoxVnRiT1pmbjZpMTUreGlScDR6bUNCWkw4SUdRNFQzeVVoWHRQ?=
 =?utf-8?B?aFpXQ2k0MEtpL0pMREZEdkMxekpBRmRBM2pNK3I3ZXZhUGZoUTBEUzlvWTRV?=
 =?utf-8?B?TXVjRTd6R09VUkd0M2lTeVgrMEdMNitrYnVtYW5wa3NMZWM1V0lsRlF0NTk3?=
 =?utf-8?B?Ly9OMU9LNHlvSGZtamt2Ry9aV3hTYmVDRHk0OGhndFB5Z2RNdktiMnIrUTZX?=
 =?utf-8?B?Mk94VTNRSCt3cVdsNjJwdTZZMjR1Y1FRT2V2WkpxZzJER1FVaEZ6ajBxUUYz?=
 =?utf-8?Q?X33zw/XkK/5MLnKhIcRokiU=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8949302-0272-4eab-bf41-08dd5ccd2ff9
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 16:37:30.0863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mXBVaaprE8n8L75JZ2BZ7ZMEsBRYIikswHF6IlhdLN1NANyq9vuE2MpGaj/amadFdBCmnA+jEnKdgMi0ZiXV9xUQGIwTQcyvTpHALdXvQH8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB5645

On 2025-03-06 10:13, Steven Rostedt wrote:
> On Thu, 6 Mar 2025 11:37:38 +0800
> Shijie Huang <shijie@amperemail.onmicrosoft.com> wrote:
> 
>> diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
>> index abfd0ac1177f..5a5041f32cc8 100644
>> --- a/kernel/tracepoint.c
>> +++ b/kernel/tracepoint.c
>> @@ -127,7 +127,8 @@ static void debug_print_probes(struct
>> tracepoint_func *funcs)
>>                   return;
>>
>>           for (i = 0; funcs[i].func; i++)
>> -               printk(KERN_DEBUG "Probe %d : %p\n", i, funcs[i].func);
>> +               printk(KERN_DEBUG "Probe %d : [ %p ] %pS\n",
>> +                               i, funcs[i].func, funcs[i].func);
>>    }
>>
>>
>> The output will look like:
>>
>> [   63.818829] Probe 0 : [ 0000000032848d41 ]
>> perf_trace_sched_wakeup_template+0x0/0x20
>> [   63.819287] Probe 0 : [ 00000000fe8cca4d ]
>> perf_trace_sched_switch+0x0/0x20
>> [   65.325638] Probe 0 : [ 0000000032848d41 ]
>> perf_trace_sched_wakeup_template+0x0/0x20
>> [   65.695631] Probe 0 : [ 00000000fe8cca4d ]
>> perf_trace_sched_switch+0x0/0x20
> 
> I'm fine either way. Mathieu, what's your preference?
> 
> Although the above shows a hashed %p. Is that even useful?

The hashed %p is not really useful.

I think we could just print %Sb

e.g. from core-api/printk-formats.rst:

         %pSb    versatile_init+0x0/0x110 [module_name ed5019fdf5e53be37cb1ba7899292d7e143b259e]

AFAIU, when the kallsyms_lookup_buildid fails, it prints the raw address instead
(see __sprint_symbol).

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
