Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020115.outbound.protection.outlook.com [52.101.191.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FD518EFD4;
	Fri,  4 Apr 2025 12:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.191.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743771281; cv=fail; b=nupVT6aRrx0SxoJPXTj9MZyPEt2WjYh8F8HMT8A86/EFGbrUY0SC5K377e1sLuYTM1mCFXS8fl20GGS/A9BRQjI5V2KYJHW5XulbYoJ0WDrRPE+0zqy4u1auXzfMQRdQZ2ecUgKfp8rnOWZ2NY2qmQ0BUHz7InMrxOtQ3CHk2/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743771281; c=relaxed/simple;
	bh=X8mt0n1DAzfKufRlJRaRjJ+QEohL/qQ33j5mJfhU3lI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KcKMP1HwYmT6geU9mpMZ28IEpouyQO3gmRcL0FiCB1fIvNaoXmTE+TsdfNi4eFZw2HaSrkkpXMyX6QghybVr0ophzELCSA/rvcFYIky8CjDvT1EOkERHlGS/vZh5VxGsATEr0NtfXfseHTQFhph/5mT9QJjuOyW2tWNRCKVfGAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=s9+87+Rx; arc=fail smtp.client-ip=52.101.191.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="s9+87+Rx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hjd85yGU28K42IEutKImTBiyX3sNCkGNuuuKhiJwPPci1sHI9oCOxLGXgokr6LtZW2f2HV08PWKh2WJ2Q3haixqIfb+GREEeNqq33NcjMf8wawkeZ+CkVKVovYN9uSoE3UJk6FPiy7gdpJGuv77ekvRBLGYTeQZCPOrcNXpwYPPxNCquc163REyWj5MLqe41iYsD98FdB57N7Pk36J9kJKiq8z5APe4FckJ0SzYtOZEUCAPEka1/4/gVdItyIksp7T2UKNCRSFGyiCUcBj5BK6mfIoz249itO15TPsrdI2UOOKaCQlZOi3zBp7WtdBkZzhU+WYaC0WlN0TNKSFADtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VAm9sZwULfCxD1u03B7cmnKJ4aruAgF7YQa51gH5nWA=;
 b=bQINZ7hkvLEFXGjHBhs6O41LTWFr0oSQIvKou4xuQh7s8DZI9m4Hc1/PP11yWl8Ex1TJMeafxXEQbkCgIwfgvvBNXl8OdWRORUOvvAwQrsyscWdRX9Q6CqX8LbBEZlqrYrsauhxZ+YoI53p52vSPYOPbVuOEqv5Mxbcw/olQ9NEDYQZtdNxu6B+I8DBgoVXRNedsyuiC4bQ6de/ar/Uks1lTTvX3mz/UL1W2ygHdzF3wVRXjM6+1tihw2D/mwsRi+Cy2P3fTtXEJVLKiE6TeVUyapgJlSrln9PzWuOX21xwuRJb/IsLYknDZ0kvLjzjaIXScHzVxS18iTLOQ8BcW3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VAm9sZwULfCxD1u03B7cmnKJ4aruAgF7YQa51gH5nWA=;
 b=s9+87+Rx1jVj9jSz9bLBbuD5sEqALK11Mom8eMWBonm+nriyWfu8jkfS3NZiAhXS6PpX9KnqpNP6NrBf5vfQZ9cdG1xdh3c/QZ6V4KGyqCHkSEVH8dtpvLg7Ms7UBO2SjliEZ0Kng9URwwghpS94l7ZUtQa7fyqAWJiUx0zz+kgrEGaSd4JzHvG0R30Qo67ZD19BUJOxhJMSsca31VSJ066FYkPKLfl/ucwX9g8klhqXadQwzezLKCY0l2avpcPebc8u5yVmXN4W1gQmxYY3/yA3lihFv2WmY9BITCsia2BQDrIneCxEowJfRGwylcUBRCCzLfakgA1FLiWYr4dgOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT2PPFDFD2A9EB5.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b08::495) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.27; Fri, 4 Apr
 2025 12:54:35 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%4]) with mapi id 15.20.8534.044; Fri, 4 Apr 2025
 12:54:35 +0000
Message-ID: <2e5aae65-316a-48c1-b293-041bfbd1ed80@efficios.com>
Date: Fri, 4 Apr 2025 08:54:33 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tracing: Replace deprecated strncpy() with memcpy() for
 stack_trace_filter_buf
To: Devaansh Kumar <devaanshk840@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
 linux-kernel-mentees@lists.linuxfoundation.org
References: <20250403191342.1244863-1-devaanshk840@gmail.com>
 <20250403153651.1188135b@gandalf.local.home>
 <CA+RTe_gHo3U-tWM9MA4CMgxM13=biqkqnAbuS5Yuidrono1bvw@mail.gmail.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <CA+RTe_gHo3U-tWM9MA4CMgxM13=biqkqnAbuS5Yuidrono1bvw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0152.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8c::25) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT2PPFDFD2A9EB5:EE_
X-MS-Office365-Filtering-Correlation-Id: 76e18347-4c9e-4dd6-9ae2-08dd7377d9c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RllScDNyL3VrTFk3Q3RZV29OQzJ4ZU9ndnJtc0RhRHJkVURROFRIK0dHRWxa?=
 =?utf-8?B?MmJLZWxjNVU4OHYvWWlqeWxGVmxJclVLYkNNT2pVSDlnWEc3MUdYTjR4OFFm?=
 =?utf-8?B?Tzl6dFpDM2NrZllMNEs4amdncWlGTWMwOG9GQ3FjcmVDTnJuY2pwSXhPQUVi?=
 =?utf-8?B?djcvb2FpZGxmalY4eXJxckp6ZW9JeEJiZXV2SnJwNExEMUhMTnRBMmR6QUV3?=
 =?utf-8?B?ZytQQkNMYXpPZ0pwRGgxLzk1RCtBbFAyeXZXbkFVdkFDSlkzSnBXQ0NYWldQ?=
 =?utf-8?B?dnRJUVNoTTE2VjBkYnZjL3ZtSUdPaEIzRFEyYXErcVZYbGdZNGZyUFhTdmtI?=
 =?utf-8?B?TDlUa0h4SkV2aVBQVDVpeVJtREhnY0YvSTZuc2UzTTFzUjR5cVBjemloWkQ5?=
 =?utf-8?B?cGV6Ky9MVmwyZ2dPbDlzVjcvS25MRnFoTUFQTlFka0ZGd1lTYjJBY2loM3h0?=
 =?utf-8?B?cFlEUEtOSEdJZDc5TEcxbUVwbVRkR0pvd0sxTkh4bmU4d0dRTWhPZlhPZmx1?=
 =?utf-8?B?QlduOC9FdDU5bTIySlhiTGNkemhHV29ZakcxZFBLdDRoaElWYzJXSkVTdVdy?=
 =?utf-8?B?aU9aRmN6ZWlzcFg2VHdNZjNLTVNBR2pXZG5vV2xpMDh6bDd5TmN0UTVNcjA1?=
 =?utf-8?B?WWUrZXFoS3lJRngrSnROcll3ZXJVRzlxUlhZV1VNMHRXK3E3MzVZeE9Jd1JK?=
 =?utf-8?B?WERzMUZtM3hTSWtzbDl0SVhQajBnNFRTU0FYbGJvNjBmejZWci8vMmJpTDVN?=
 =?utf-8?B?VFVweHV1MXQrMk9wNnRMMEMrcW8wUlVZd0dqblhkYXA1LzJFUVM0ZklrR3Zp?=
 =?utf-8?B?d1JMcXlEbTNxTzFibVRTc0pKZVNpNVZCeC9QK1BlZGI0TmI2YlFBNkxHdWNR?=
 =?utf-8?B?ZHBvRmtRWUNUeUdKMnlpeDh4SDh1eGErRjNUWDBETi9uQm52RVF4ek52VkJZ?=
 =?utf-8?B?M2s1U3lIdHRwV0F1dnhLektCeUZIZDA2VWpJSVJRUVd2cGdYMklyQmo5aXdD?=
 =?utf-8?B?bURKUW5lYXlQNDhtdityb25VSzdaaWxsQ3E4Yjg4WVdRSE5DODVOUHNpTnp3?=
 =?utf-8?B?TVBjSStCRHZJcUdML0c4RGYweVJBZGFzTGdJTjZNc3l4WjJhZ0YvNWdpcmdF?=
 =?utf-8?B?ZE1RVlo2L2tnQjRCVWczalRqQnRUQVhJT3pzdlI2WHZTM0hKbUpRbGJpNDZu?=
 =?utf-8?B?MTUwamhQNHFWVjVtU2Z1Mk11ZEZCd1Z4dzk4SHd5ZzBrZGlCd2c4QjNDZmRF?=
 =?utf-8?B?QndnU0J2cUptN2xEaFBwUkZXWXJ6ZFMxTS91bFA0Wkk2ZXBuVDNwbE41ZUMv?=
 =?utf-8?B?ejdpdzRJVktKQVZtS1VOWGFDdy9nRFRkSlVadnIzWDdaNGRHQTB4QUtwWTNX?=
 =?utf-8?B?RXMvcy9BQ1R0N3JZNmtrNmxLRzFtS3U1OEZ6TUs3aEhNZVI1b1J2dFArcVV1?=
 =?utf-8?B?Ukd1V2Z1aDFxR0lwc2RXTllhRFpVMDhaQjR2aXB0ZldaTDdlaU5FS044UzUx?=
 =?utf-8?B?YWxpclBBellXRURCVmZhSUFXQ1VJWi83eUdFRER1ckdxa1Z5eW4rSEZBamJ1?=
 =?utf-8?B?eFpyWmZJUWpVWHlyK0ZVRVVsZlgzMzdKWmR0cDVtSllJWGpyaTFzWDFoSy80?=
 =?utf-8?B?WmhqU0xpZXZJNFE2VmMrQ1VucXZ2RVh0K1U2Y2ltekF1MU9KRFc4WUJDV1hy?=
 =?utf-8?B?K3pzMUxJS1o1RGNzWVZyZmZNNzZRSCsrR21aYUloaFJYbitDK0JKNVN0QzM0?=
 =?utf-8?Q?OcKNX7Z526tczzGoRzzLD7V8qg8fNTLyAUQanYA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b21yeElsaWpvQmJ5M0JvUDdHdGJsMGg3MjJ6VnJMWmZ1OHhuNDl5clBWakc1?=
 =?utf-8?B?Tk9mdTViaTZoYjhwWUkxTHhlVE52ZUUwSFVoWk1HQVNaSlEzZWZsUFRKRmps?=
 =?utf-8?B?UjBkcEVmMXhlcnJ1U1RvdjNEVWVMbHpWdmpzWnJrK1FGRkpmTmlzSmY3eVR5?=
 =?utf-8?B?RjhaUmFQRzFUdzN4UVBqcW5NWjFtR0hVbkEyNDVVSUhsYmtPeTBuK2U5VXRM?=
 =?utf-8?B?SDMwWGlZQWlxeHVvMHNobHBXb2tWdUU1Ri9zeHpURWNPLytsVHpOMC9MYVZ4?=
 =?utf-8?B?QXE4RmJ4WmQyUWNncEZNTjZnaTNoeXBVWTdtcEYrSU1kY3lVUFRtYWZiTStn?=
 =?utf-8?B?RGIzSzgrZzI5c1JNNWNpSWNxWXJjUm9Sb1JnaWNNczFOSGhyU0Job2FzOXBl?=
 =?utf-8?B?RlRjS2hpWnFvbWNwemxOSVFkbFNFMnZNZmUvQktjZUc0L1NrVXd6bk8yZFZm?=
 =?utf-8?B?RWp0ejFvMWRHeWVyMTFndVhjaU0rMUxmVnRTQlM0cWZPT3R4WTNYSHU1Zmtt?=
 =?utf-8?B?dnNTbkdUUmVHdlhLT01ya0VqbUVndWlXVmh0cmdhMXR1UXlOTHNublJoSEtz?=
 =?utf-8?B?S05rdjE0eGJ3VEw4NzExYXdxWFZpTDVVTU1takNZV2RzVDRpUWh5VjVUc3dQ?=
 =?utf-8?B?My9ZMFJ4VDErMWQ5MjNST2d4bzZnZW85SVQ4Q2NoelJnbXhieW9tRWRRZTFO?=
 =?utf-8?B?YjdJZnhZd2NEQlZEaStVWVVsaVdvZEdyUDJOajYyUGhxS2VoejNGaEdpenF0?=
 =?utf-8?B?SUZkTG5lZkplRHBFZlNsWWF1ZXowcVdqQi9ISkFZT004R3lOTWErd0JlUXFV?=
 =?utf-8?B?cE82SU01dVdueDh5MjVYajhGdEVQd0oweWpWU1ZuYmczOGdldXdiRlZHUDIx?=
 =?utf-8?B?bmc3aFlRQkxrU3VQS2RKR0pyV0tmNnZGTEJJNnBvTTgvMURpZW50b2FpcUN0?=
 =?utf-8?B?dGYzVVpWeFhjVUsxNTBrM21IclpiR3JLbm9qSmtjZ0hGTDFlNXdVR2pnRHF3?=
 =?utf-8?B?L3FZOUUvc2d0em5PYXd6eTNpNjlPK1YvMHdQME8yUndta2xtbzAwTG9kOEJW?=
 =?utf-8?B?cFNtMWxLV0EreHFRc2dUaFpsczh0WWVzaHBqMU5VblJFZnUxQjdtRVB5MDA0?=
 =?utf-8?B?K3IrYWhGdGFReEI4TEVlbmwvTEM5TmNGaUd3VWYveUNrZ0JNUTB0dHJQblpR?=
 =?utf-8?B?YnJFVmpVWXkvR0kzcjBtNU1DYXExaFVTaGRuN0o0Y2NPcGR4ZDBsakJ6VkZx?=
 =?utf-8?B?V3dkOHVKdkFyQkxCVFhsc3lISmgxYWFMd0NXemNDZ2JvejgyZS90VUQwWHE1?=
 =?utf-8?B?ekpMTkswTE1RTkUyRWdVTVRMUktBdml5YmhNOGVSZ2JUVnI1MU1NRElDa0w3?=
 =?utf-8?B?WWJFOWw2TE5KZHVPdDJ3LzJjalNCNzBmRytCRFFJNzJSdUtkMWpqYmRKS1VD?=
 =?utf-8?B?amVFVEZDSmZ1Lzc3dnBrWnRNRk1YVFpxNjVlRXh1R3JCMVo2U1BSOElUbzB4?=
 =?utf-8?B?bWJYaTVUZ3FZOUdrbFd2SUhla21TcVlxRWxTMHpvOTYvc3hwWEFwQXM1QXgx?=
 =?utf-8?B?Y2JnS2pLbnVZaVB0dStFUGRHdGR4UkpEZEQyRGRvR1VhcjR0T0tzR0xhemFv?=
 =?utf-8?B?SW4vU3Rtbi9mZmNVNUtDTGlKcVRTWThGcUpMSkRFSVc4MHMxUVBMR1N6MTYy?=
 =?utf-8?B?bzQ3NDlsTjN3OUozMUEzbDZBSUs2QS8zb1daMnlkTFY3ZnFTNXVJZHBMU2tk?=
 =?utf-8?B?VUNVcGxYQU1Td1RJOEVBQ2lhN0p1NHAvbHVRbGQ3OUc2NXBOdFc1bTNkS1ps?=
 =?utf-8?B?Vk9UUElMV1Z1d1l3a1V0bndHWm8wZGxLOEhEc2Ixd1RxclZOSTZZbzNZVWRs?=
 =?utf-8?B?THh4Z2R1YXNYb3ZsVkU5UzhTUHE2bmZBQXBCNkEwV1BFeGdrTWd5L1ROc2Rs?=
 =?utf-8?B?cDE1clJwSENoMXJSU0ZKUzRpZzBNTGEwNFJBRTc0Vmd2Tk5IclB5NHpNbmMx?=
 =?utf-8?B?cWdEUXp1blJnQXgxTnVjdWpKaHhMLzVvSXo3SFY3M2t3K3Qwa0ZYb09zNmsv?=
 =?utf-8?B?NDJUelhTY2R4Vm4yVFprREVyMHlScDVwOTZCaGpXbndaZFlqWGlaMG9HVmdC?=
 =?utf-8?B?YmtHRFQ1SlorUlRRQU4wdjdMSkNOakVYMm9Zd1MySEQwTFlXY0Z0OXJYQUM0?=
 =?utf-8?Q?qGxAQZPgtQdjC7bKNNF/5hc=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76e18347-4c9e-4dd6-9ae2-08dd7377d9c0
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2025 12:54:34.9820
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AUANg4lBFyrBJEbO/uJ0Qe0ktvNvpMkH47ueX4zNBAoNbqo0kcpO6RxjRA+mtBBeSS23r4aHVZn+DY7lrB4t0dZ89jp03uDlxb2uYeled/Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PPFDFD2A9EB5

On 2025-04-04 08:28, Devaansh Kumar wrote:
> On Fri, 4 Apr 2025 at 01:05, Steven Rostedt <rostedt@goodmis.org> wrote:
>>
>> On Fri,  4 Apr 2025 00:43:40 +0530
>> Devaansh Kumar <devaanshk840@gmail.com> wrote:
>>
>>> @@ -537,14 +538,16 @@ stack_trace_sysctl(struct ctl_table *table, int write, void *buffer,
>>>        return ret;
>>>   }
>>>
>>> -static char stack_trace_filter_buf[COMMAND_LINE_SIZE+1] __initdata;
>>> +static char stack_trace_filter_buf[COMMAND_LINE_SIZE+1] __initdata __nonstring;
>>>
>>>   static __init int enable_stacktrace(char *str)
>>>   {
>>>        int len;
>>>
>>> -     if ((len = str_has_prefix(str, "_filter=")))
>>> -             strncpy(stack_trace_filter_buf, str + len, COMMAND_LINE_SIZE);
>>> +     len = str_has_prefix(str, "_filter=");
>>> +
>>> +     if (len)
>>> +             memcpy(stack_trace_filter_buf, str + len, sizeof(stack_trace_filter_buf));
>>
>> Hmm, this location looks like it can just use strscpy().
> 
> Yes strscpy() also works. But since stack_trace_filter_buf is length
> bounded, shouldn't memcpy be the right choice?

It's not only about the destination, but also about the source length.

AFAIU, turning a strncpy into a memcpy here will overflow reading the
input @str if the input string is smaller than
sizeof(stack_trace_filter_buf) + len.

This can trigger page faults or make KASAN unhappy.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
