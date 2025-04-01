Received: from YT5PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11021118.outbound.protection.outlook.com [40.107.192.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C132CCDB;
	Tue,  1 Apr 2025 02:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.192.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743474187; cv=fail; b=LmhbayMPpn7Lru9DMEX/c5COYWGYwGiNyLGcyw7Z06qQHRxm2mDLd7uQbz5D1uh8GDPtIAZFR2s5sOTCuvNNGqTYTmyzNtSNdflkfv/kCGDzZgI4nQYREUKyUPAt+vmAiOdl49tFFXHvFclkG7B1Z+4tCY/YjvPt7CbHx757pqs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743474187; c=relaxed/simple;
	bh=NVnoIYf1IfFBuaRC4vGCgKz780CePPWmPU6D5ZfYBls=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PGu3DZ8Owp2A0UvHOQ8Tza/yINy+ZCdCCRzx/K5r6E9kJr3eAATboPTsNwy4KEThps5WwhG8UWPidhAA6Ht6t1jvVB2lyY5qr0bhuF/luKszDlTtISoCSnCt9rnw+W4cZYyj6+7i6pBvB5qsnxfmMKqDNVsDjZuM1+tDN23Ok6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=c8s6TqC1; arc=fail smtp.client-ip=40.107.192.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="c8s6TqC1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=grdWesG16UcEHy+UbiFlWbdEEq27i8Oj0RzWZLRF71WTsrEWcAlxS62zdRlrpC1nQCV63TILVkbIP98i+2hOv/GFROXjHdf4CKKivatKiUmxtK5GPnONoaKMA6Bvc+LIvnIk4Bz69QP+qx3bouT63RYoQXubAPm8MS85St/A/dSO/LdXkk4NE4LtFJab71KaKB8Le/GJCY9jewrPgcQ5x7BCrPC0smLF/yil0x0vk6CZUGC6T01/GJe6i8lPeLbCaQMDYdUuCgeG97z1eb9wrL+RgWrY4KnC+bWILRtPWFXxEKNWgiMsRros9TxtfYZpjtRlyDzeSPpvWA5urKeVrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eszEZ9AiO7KU335XLQIgVmnQPttuTZduduf2xeyb8T8=;
 b=WDyrPT0OslmBw+CgJm3EwIWsCwFc399L4s8ezgM1P6bJvEA/UdWKvkFoaBuP/bVEFWO9R42m+PtwFrHakopXLOFcgV1ohatRzXdUONTNu1g+201THQtEhq2/wo9Nj132ikFm5HrjOZ9R8xmEOQWQrfNFxRynPaeTFJxjTviW1L/xhX3//h7NHHux2CZzGIklw22gjNU3Ag4eNDQtZ30w6M8GbAJ2E4/XLl1LuFNk/Ed7C196D/7fb2dWbkSfH8tRAY9nBUfipp1ZnI91g/keV+km6ZrphIz5J6TEHRqfWbahU8eWLznzp8kQWnSzfvXMsWv3XgwQl4YVuf0yVbmsYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eszEZ9AiO7KU335XLQIgVmnQPttuTZduduf2xeyb8T8=;
 b=c8s6TqC13EN5O6acSjrsLKMtxj+8rUp6qFCAjiVigeyerI0jk8PWxVYr8Hz5lqDDgMCMv6KDJYqW5JPlpOVZeopGyve3h9WEw22GilHE5chmQjkPwt2lh2DUoWi4XnCmszgFxh4PIVAHeROTc4Jh9l/iD/c5tlcwVgYlnbiHybJUGl/uB7fUZgDLFZjsYvJXxwMarurpd6kgfI1UOBJbs958KyxNZnG/QQIxnIG2xniDlaW6dZxMaJmvFNV/HwZLKMnCCkq+WSrwnz4/E2b5u/vvR/TuK7fIjE8R9cTfUc35kaAUZ1c0L5CzZ29U8yZQ36g7Iz+01EiRe0bE2I12Sg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT1PPF7FE2DA30E.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b08::558) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.46; Tue, 1 Apr
 2025 02:23:01 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%4]) with mapi id 15.20.8534.044; Tue, 1 Apr 2025
 02:23:01 +0000
Message-ID: <db2123c9-4777-4cc5-a00f-3df78edf5cb7@efficios.com>
Date: Mon, 31 Mar 2025 22:23:00 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] tracing: ring-buffer: Have the ring buffer code do
 the vmap of physical memory
To: Steven Rostedt <rostedt@goodmis.org>, Jann Horn <jannh@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Vincent Donnefort <vdonnefort@google.com>, Vlastimil Babka <vbabka@suse.cz>,
 Mike Rapoport <rppt@kernel.org>, Kees Cook <kees@kernel.org>,
 Tony Luck <tony.luck@intel.com>, "Guilherme G. Piccoli"
 <gpiccoli@igalia.com>, linux-hardening@vger.kernel.org,
 Matthew Wilcox <willy@infradead.org>
References: <20250331143426.947281958@goodmis.org>
 <20250331143532.459810712@goodmis.org>
 <CAHk-=whUOfVucfJRt7E0AH+GV41ELmS4wJqxHDnui6Giddfkzw@mail.gmail.com>
 <20250331133906.48e115f5@gandalf.local.home>
 <CAHk-=wi5pLoe3szxLREQGGJuWU0w_POK9Sv6717UH3b7OvvfjQ@mail.gmail.com>
 <20250331165801.715aba48@gandalf.local.home>
 <CAHk-=whRNxdkLC6Z91g-_RbrRsUo6K6+nvRWqccjsOycwUe_JQ@mail.gmail.com>
 <20250331194251.02a4c238@gandalf.local.home>
 <CAG48ez3w0my4Rwttbc5tEbNsme6tc0mrSN95thjXUFaJ3aQ6SA@mail.gmail.com>
 <20250331210245.585fff23@gandalf.local.home>
 <CAG48ez1mZ4nq-_DXHqiHe8_tSX37DdcngnULqXQ71fFt0oQPyA@mail.gmail.com>
 <20250331215051.21d77cab@gandalf.local.home>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20250331215051.21d77cab@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0183.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8b::27) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT1PPF7FE2DA30E:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b4e57f4-6a8d-4991-4215-08dd70c42030
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|366016|376014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M1ErUTlFNWtla0FDZzFuWnliQUxRdkk0Rm1ScVlBVW1iQ3lvWDJhNFNpY09t?=
 =?utf-8?B?QmNiK2hXZ0duamE4ak5vbThONHE3OWl4RnF2Qk0wRG1nUVV2Qk9EcG1neXND?=
 =?utf-8?B?SjlEc1ZGNk4raE1HcXNPdlEvN3BnWWVsUTFGYWh0WGo3K3cxS3JFQ3BBbHdT?=
 =?utf-8?B?SUxOL3FURUZEV2g2dVUvVDNkZHo5MU5rTlNVbTZad0FSVnpYM1RyQXFNK2p1?=
 =?utf-8?B?a3UyV2lHQnlkaVlXUGgvSWE3TXpxbVcrWTErdFJvRlQ4MnBwWXZQOGgvOS9n?=
 =?utf-8?B?bXRVRXJlSzRHN1IrVlY5dUp2Q2tlV0NEK0hBdFlkS3FjVEFHZTZJb0xSU205?=
 =?utf-8?B?dkswL0pDSFdqWWhGTER5WWtEYzYxbzF2bTI3dW1SalNKdzNiVlN3S1NTVjRZ?=
 =?utf-8?B?M1dOQmo0bmtLSGV2VVljKzgvS3BEay9MdHpCaTg5K2ozVmRHSHJGNlBxa1ph?=
 =?utf-8?B?VS9BRU1jVEZuQlBrZXpid3NRUWx2UERBaUhUTXVsWTIrcHdWTEpsOVpSU3R2?=
 =?utf-8?B?VGN1TUsxN09DNXI5Vm50V2h2cHZ2Y3dqRzlWbjkvN1RpYTJYT09DZ2xodmts?=
 =?utf-8?B?MncvS0lSbW1EdXVReUREcys3ZmZ2ZWFheUx4ZVFaWFlGV2VDcGpFL3h6QldC?=
 =?utf-8?B?L0pxWGJYUG02ZVI3UDlkVVc5NjM4RVdWWjZCVURmSUEvZzI0dHVudHJQRWdU?=
 =?utf-8?B?dzVuRzFNMCsvMk5hOXRueWVDSkFlNFVaSllwVzR3alVaeVR1WnZZZ1dxTytr?=
 =?utf-8?B?QkR5eUM1N3orL0xGdWd2SFZlT21FcDBOcDdZS0xZVTNucEJ4a2wzakl0dms5?=
 =?utf-8?B?K09qNWJvdnhCaUhPU0RqeXNJZHZrcHVKZHVka0RIQ0R0cXNIZW5YbU9iVjN1?=
 =?utf-8?B?MnBSZDlFVmZRS3NIN3NPeUR3WE5uRG9RNitaM0VsMFJGUGJEa1ZEWE5pTWFY?=
 =?utf-8?B?SFZJUkY1cFNBUmtGRVV1cFdDbHMwaVBNbEs3bzVadjBXaXZnNmIrQmVha0hL?=
 =?utf-8?B?eWFMV09yMkxpZGxvLzhReWNkVG5GNkRFakkwRFY3SUJRS1FMSXkwWEdDdWdF?=
 =?utf-8?B?RXJWYjZaRTRkNWJIdGk2K0Y0U0xZbVN2TWZDb0dNM3BFd2JCNnJ3dEt6NkVk?=
 =?utf-8?B?YXZZYXl3U3BYakhGT0NEWU91R0IyaWRwUEw2Rk9mdktoQm54Q2pLUXQ3Sjc1?=
 =?utf-8?B?cWlQS2pLbThjaW9xZEFyZFdUeEZYQzErWWNvdDZQbzI2WnhMVCtkSGlBNjQy?=
 =?utf-8?B?UHZxN00wSFBNWlRjUUxabDRlODlLTXZYZXV1elpDYjJrSmw4L2JHbm1xRmw5?=
 =?utf-8?B?RkJSa01pK0labXRhcS9Jd1gyRkFRWUc2TW1ENlVtWTFnMWRvdW5oNDJueWZB?=
 =?utf-8?B?azdCYVNqMHFBZ2p4KzF4OW9SMmZrcDJBZWFCdTNPbjhnTHlvRWhiS0hET200?=
 =?utf-8?B?OGFSbHowWUgxZjlUeW9ZZVZaSDJWUlNDdlI2Qy9GRXBEalBHNmlBanRkK1NJ?=
 =?utf-8?B?T1ltVXRBajNlWVlmWmxUTElpTUlnK3VkT1E4T3duWG1RMTY0YnBEazd5QzBD?=
 =?utf-8?B?Qk11WVpGNkhncm4rTXIvU2E0bE9wMCtVKzhBMUdkT3I0cEhkSk16dk1BM0Uz?=
 =?utf-8?B?UDFlbi8vZ1ZoYjdMbmJCSFFIZ1BoTjFtTUZYUTExSlpyeWlCZCtvNzJWL3Zl?=
 =?utf-8?B?ZXZDeTd1Q0ZBN3NDOHRnRUR4ZHZBeWw4TkYzdnliYVJZbDU1TmlTdjRBWWZI?=
 =?utf-8?Q?mF3w4EKW3Bxuhh5Z8KKolgj83UyGKb7LHKtNVs2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cG9tcWNRcG52elhyZHc0cmJKQVlMNko3azFwbXlWdVJLWlR1VWZvYjMwWlVC?=
 =?utf-8?B?ZG5FaGtpTUlOTlluVVRVdUdxUjh3YmJmaFREejVDNHorUDJFeUVYMUtUbnFp?=
 =?utf-8?B?V2cwenA3U1piejNudXl3WWo4akpHdTUxVDBxOWsxMW1xYnJSNm1CRzdCNmdR?=
 =?utf-8?B?VTA3MGlTT0RlVVcyeTIxRnhITzJvU2JWMzB4YzAvMzhuNHZOaG5yMUs5Umwy?=
 =?utf-8?B?Sk5td0Rrb015RVpQR29JekJKaTJQbFNYdjg5ZllaRWUreW9VQk5vSjhMTmVy?=
 =?utf-8?B?MGthQm9UM3k3dUU1WWZna1ZaOWRpb0JCVmVlQ2VhUkhEajJGTWFwTUV2Ym9F?=
 =?utf-8?B?cG9pd0hFQjFVczEzRkMrejJ5dmZ6QVc1Mm9UaGwxeXljOTh0ak0wckJIR3V4?=
 =?utf-8?B?MXZKeE9DeFRaQ0pBVWFTODhJRWJtNVMycjNOdmN1dm1XM015REN2T3JnSXdt?=
 =?utf-8?B?dWxHc0RzNzFLSHR4TkdQeTJDMjA0dUw1bWRVSGVuaDFZVFB6ckRnUGd1ZFN4?=
 =?utf-8?B?R3VlNWZvS1NtTEV5L0lLRDQvajNENUhReVFvQkE1SEJ0WlBoeHVjMFFjQU54?=
 =?utf-8?B?RTVUcTVGYXVxb0lJcGovRUZJajdWeGNST2EydjR2c1h0bDFjR2t1ZnIyZTA4?=
 =?utf-8?B?VDFsWjdFUUI1bk1sM1NzUVpDSTQ3MlAwU05aSTlTcWQ1c0IzRmRMQVZUc2dh?=
 =?utf-8?B?QjRjUHJqc0pFRzlrSjVzdVRtSDNEbkdQNmcvaE84L25TbjZzbGNic0R6Rnp5?=
 =?utf-8?B?bTN6ZktJODNYVTUzbTlFc3N3dGpaTEdHWnBmNitNQUZFeENMd2gyTm5DRTlZ?=
 =?utf-8?B?MTc3cS9Ldk9zNUxudjk1NGRLQ2JqWWpXRVhDQUxlN3c2aVlPWXlwL2k0c0FQ?=
 =?utf-8?B?UzF4d0RiNkc1VG5lVWVaaEhpRUk3WEhKMDFsdGpJUUg5MFBRSlRGTEVCT2xn?=
 =?utf-8?B?Tkd0QWZwTDY5NHR1SFJHZFltZEpzOUF5VGJ4MVV3SitWcUNxc2Z5cDN4NFBN?=
 =?utf-8?B?WTF1eGwrdE5yVDhLMHp3SWNBdGhwc1YvMXk4Zmc3SzBudHhNMks0TDNBL1V3?=
 =?utf-8?B?eTJaSmc1ZzNjaVZXVng1WjduV21WN3hqVFhnRXRORE5ZTHZFUm8zajA5dk9q?=
 =?utf-8?B?YXN0ZG1yU0pXZGlOa0tOTWd6RVROVjFoVmdaNFVlY2RENUhZQnlKVEcwaEdK?=
 =?utf-8?B?NCtvNGFpYVFvWlJQclhlVWlLMnA4YWxsT1FhVXJJMHAwendJdGs4OHF1b2Na?=
 =?utf-8?B?aWQrT3pzaXgwTmxjOW9hMU91dWcyeHA4YmtVd21XbU9KNXlqWE5zRDBLN3Nm?=
 =?utf-8?B?VGdYUmpDL2l3a2p0cVBEQVZ2cHJxWDhId1A4WCtyMDkxREx2c2VGNHlrbmVQ?=
 =?utf-8?B?bzRCMUN2alRpSEVHazBnQy9VKzBrd3M0Y3oyemV1MVp4dEZmdmNEVERFeUc2?=
 =?utf-8?B?RTM1aGwzNGQ2ckdGSE91Qis1MW5ndkMvSVZRemtGeForWit2K2tiWDhlTjla?=
 =?utf-8?B?M1ZHcjVTY2ZhUFdJSUU4amM1bVhnTGRjY2dqcFlIZlVYN0RTS3V2aVJoQkdB?=
 =?utf-8?B?M2xSUnhQUDlhUUp4ZURpSTEraTRvWG81azlqbGZJbEVZQ0NNZmJKSDZqOG5U?=
 =?utf-8?B?K1hESGpXOHlUa0E0YjhkaTlyRzdMK2l2cUVVLzZQZlJGZ00vVUl4b0ZoNGp2?=
 =?utf-8?B?RWo2Vm4xblJUL0l0M1VaSlIwWTlpYVNSUjRiK2ZjbURnM1NRK3VlZDFXUTcz?=
 =?utf-8?B?b0k2Ny93NU1DUVpMNjhUcUJ4YkdicU5QOUpVVjg5MGhXejZSUUQ1L2lQQWVa?=
 =?utf-8?B?NUJrREtHdXkyenA1RExVNTROYUdsb2Q3M2kyN3RTbm8vOFluQm56b1VONHVz?=
 =?utf-8?B?Szl0dWFYbmd3MGtrMkJrV1B3RXJDdlNkQ2h6QW9oazlGSENsYXdRS0J0WWlS?=
 =?utf-8?B?czc0aTVGd3RuZVdqTXF1NGN6bzZhQnJaRW9xNk1YYjZDOHVTVklGbTU1c0Qy?=
 =?utf-8?B?dnMzK0Q0TkdsQjJJMmJGRC9yaHNDbG9QMWtSckgyRXUxMDNBc0pPbG1pQmJi?=
 =?utf-8?B?UXplQnBSUXk1blNFSTdIdHdKaDF6UnQ1Z3NUTy9GZUJQY2RvSGtzZWw0V2RD?=
 =?utf-8?B?K2tFdkdvUDVqeWhDWVdVc3VScit1MFI5cEtLd1BnckdBSzhpN2crUW9rbWhF?=
 =?utf-8?B?M1B5eXpVa211bDZ5RE9HNUtuNmU4clQ2KzhqN2pqMXZITjc1cVRCeFowbHBL?=
 =?utf-8?Q?vSpt5H3JeIH7aWtc1HNxKvjYKqd+IUP4fbKI2xdzCo=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b4e57f4-6a8d-4991-4215-08dd70c42030
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2025 02:23:01.3983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i4yjktTHs6Q4vK/oQhzP8RyMfHwjM9ZROY7utYrA0iQoD3he1WXHSg682uKNBXZ7HHJyt6MYo0P/uRqFhPXXiQGnCfwaMAJvtGvwYHnB5N0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PPF7FE2DA30E

On 2025-03-31 21:50, Steven Rostedt wrote:
> On Tue, 1 Apr 2025 03:28:20 +0200
> Jann Horn <jannh@google.com> wrote:
> 
>> I think you probably need flushes on both sides, since you might have
>> to first flush out the dirty cacheline you wrote through the kernel
>> mapping, then discard the stale clean cacheline for the user mapping,
>> or something like that? (Unless these VIVT cache architectures provide
>> stronger guarantees on cache state than I thought.) But when you're
>> adding data to the tracing buffers, I guess maybe you only want to
>> flush the kernel mapping from the kernel, and leave flushing of the
>> user mapping to userspace? I think if you're running in some random
>> kernel context, you probably can't even reliably flush the right
>> userspace context - see how for example vivt_flush_cache_range() does
>> nothing if the MM being flushed is not running on the current CPU.
> 
> I'm assuming I need to flush both the kernel (get the updates out to
> memory) and user space (so it can read those updates).
> 
> The paths are all done via system calls from user space, so it should be on
> the same CPU. User space will do an ioctl() on the buffer file descriptor
> asking for an update, the kernel will populate the page with that update,
> and then user space will read the update after the ioctl() returns. All
> very synchronous. Thus, we don't need to worry about updates from one CPU
> happening on another CPU.
> 
> Even when it wants to read the buffer. The ioctl() will swap out the old
> reader page with one of the write pages making it the new "reader" page,
> where no more updates will happen on that page. The flush happens after
> that and before going back to user space.
FWIW, I have the following in the LTTng kernel tracer to cover this.
LTTng writes to ring buffers through the linear mapping, and reads
the buffers from userspace either through mmap or splice.

When userspace wants to get read access to a sub-buffer (an abstraction
that generalizes your ftrace ring buffer "pages") through mmap,
it does the following through a "get subbuffer" ioctl:

- Use "cpu_dcache_is_aliasing()" to check whether explicit flushing is
   needed between the kernel linear mapping and userspace mappings.

- Use flush_dcache_page() to make sure all mappings for a given page
   are flushed (both the kernel linear mapping and the userspace virtual
   mappings).

I suspect that if you go down the route of the explicit
"flush_cache_range()", then you'll need to issue it on all
mappings that alias your memory.

AFAIU, using flush_dcache_page() saves you the trouble of issuing
flush_cache_range() on all mapping aliases manually.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
