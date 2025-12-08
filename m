Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020098.outbound.protection.outlook.com [52.101.191.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8256C1925BC;
	Mon,  8 Dec 2025 14:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.191.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765203777; cv=fail; b=D5kAV5d02q7Qr+WclIRYboVkpL0cwx/v3QW36N2NgIAnaQ42T4Z09R/kGp615Tww5yrj/+QhSjSbGGoik1Cc+j+r+ub6k0PSuabq3lZG7AbP+CXw6Gpdf4H6V7XAoUdKG/mw7nHGzlmqzz62RMsIWwKiEcpypML/CAAbut9UVY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765203777; c=relaxed/simple;
	bh=QMPgf14eAEtVKL7XByas76fGvk1+9w8TjqSOL65S85Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sfVZ1z9YQC2i1V36texoDbS6UQI0ZZlTm3Br/LsrEEqEw5JdfaFC50Ep5JPP/VfS+re0WnjMGd9FfLUh2OpraVcyUC4w2JR7n6GuS8+J4mUjdMUIlmGnFF+1jUFMIj1txLfSNfjw6eQJbS30hmhb50fzBgWjRqOmE3SRBk3Z1Vg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=YgbeQilC; arc=fail smtp.client-ip=52.101.191.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="YgbeQilC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hxW2pH+7e9gbPcUUaKvDwa+6VpK8WdajsC7kaisvfqoCnHYEyAZDPWBUW6Ee8W8pDq+L3OlPamAYSmiTbCdPexWnyM/waO9q+YOiGPP3wBTc2XcB+yS0icdPTHAWYqeQVps3daQ8pO+ii+UcoC4WV8yrDnx1IYqt6GQNy0lz8YaQ5xFhd8v0OD2+Np25ms8GaMdxQY8i4VRa3FNx5jmSm4J+wsef2sh51/sl28dPYFMijgPJKEMsDYcbrDNTtKjIjU56fjFGj7xPri5KC+hDSlFhC0p5091Y4v3H62G5FQ3TMEYJWbnDXtdllHd+HsNcjiiHGZwoXc1A887l8wGspA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FZJdeNALgV9m4gxEtqIg7zvW6JIfqpLuSClvJSc0PYI=;
 b=dgfsgu5xEDYwm6bc7uCihZWCgeH0ozZk+x4C9bzhZoZhiGuhPGZ8zLgTqpQMdsReL58EJ5Hh/ytgkNg749xI91MUf9sWsO1KxjDxU36llOP/WGTdSHPyo9DTo/wiIY2W+FHcUMSvMiQjC+TnI3FRWd8k6t6zfWhtwhaFryQggMTVBXcC7VQmCT3n5CLlU1mAQQoHjbXMTwJQluU7omTiqKwQAeTc1UGhAOJW4mKamnl3w1MhaPu8vM3LDHhF7NcODoBhTJrPLO0XE2HOrJ1C5BGmZAIVpFbauqt/mFAM2f+g7pZCQPapFevVpBK+KsARN5SHQa4KECQdMt7/yOgnVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FZJdeNALgV9m4gxEtqIg7zvW6JIfqpLuSClvJSc0PYI=;
 b=YgbeQilCML66YsS0IJAEOYfgByeRw82QCzxhrn9MuGbs/Z2khLd7BQJ6WjB5Qm7TQTUycQbDU2DAAbU/825Pf06en+cVbqxz8m2sF13aaHLtP7ryAhGbn+jzQdTC8AN3OfslF3LkBYxZS0tTEkzstq97CN1lJULZVvMP/P2JCUTdm2Y7IKcs52TEx33jvz1on3fS5R8jZP3jUNIbvGJUVeSh52bkqsaljSOyvb0Gb6sQbmHnJInPyw/Z6B7SluCMP1SNRYfU0UnTR4TQC1XRXkJde8MCo2K1TX4lQvuBcmjU+/Ox3gdnL3EqA004JnveaR19NfXpX91Es1LOJGGAMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT3PR01MB6502.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:71::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 14:22:50 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%2]) with mapi id 15.20.9388.013; Mon, 8 Dec 2025
 14:22:50 +0000
Message-ID: <3612840f-0c05-4797-8e75-872a306da45c@efficios.com>
Date: Mon, 8 Dec 2025 09:22:48 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: PATCH] tracing: Fix unused tracepoints when module uses only
 exported ones
To: Steven Rostedt <rostedt@goodmis.org>, LKML
 <linux-kernel@vger.kernel.org>,
 Linux trace kernel <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Masahiro Yamada <masahiroy@kernel.org>
References: <20251208085336.6658743c@debian>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20251208085336.6658743c@debian>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0335.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10a::26) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT3PR01MB6502:EE_
X-MS-Office365-Filtering-Correlation-Id: 51276d5d-bef5-4d39-d175-08de3665442c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZHJjSWRXMGc3WVE2WnNxZ3k4dWhtclRLMVN6OVdaYitvSHFKS25pRktodHdv?=
 =?utf-8?B?NE1RM2Exa1RrZ1RhTDZ4dS9pL01DYWJETHVwQlJlNExhaGFjWkhFYStZZ0xa?=
 =?utf-8?B?b2pqeXVZbjRubSs5ZmJYQmFJZXJTSXdzK08vUVVBR1p3dFdhMFUyYjdKd3dX?=
 =?utf-8?B?MjRaVUw0QXZnT1lFSjJtd015NWNUWGFMcUhkckFPblc3anh1TDRhMXJNUis5?=
 =?utf-8?B?cUxqYVhJcnlFVDZ4R2padzhMMkM4MG52TTl2Mlg5KzF0bnlVNnduTkJJRzVh?=
 =?utf-8?B?WHV5SW5qdHhZYWhndWtaN0h2ZDhGUjBnem9rKzAvUTBhSnpJc0VuWkNzVnpK?=
 =?utf-8?B?QUYxRXlnKzZ1cWtjSlNEa0hWK2Yrd1orZ0IvVzh5N2JVVkdITzNJTTVKN1I1?=
 =?utf-8?B?YklzR1VuYUFxMHdoYzF6TXBGUXd2TUJnbitzNnpOSWdPZXA4Z0JteVhiYlpx?=
 =?utf-8?B?cXZ2ZDdVMW9POXJIUnlZd0tCRHBnaHVRdlpuZ1llcXBOT3NPL04reVFHNERY?=
 =?utf-8?B?SWxoSTZTT2JTVDlNblFvK2pIYnJJNzhvV3dodW4yK1IwdmZjVGRxU1lGMSs5?=
 =?utf-8?B?NENORmR5VFp0aStIUEFPbVZwTWxDQzlBa3BnbFRyRVViSUszbS8vQ3NjbEJ1?=
 =?utf-8?B?WGtMR1N3Y0Z0MHZ2VHFmSzIzQTdtMHlMejUzYklzbkM5dnc0ZXVMTmZJQWtC?=
 =?utf-8?B?d0RoeStNSXEvSE1ENmczK0kxS0liZWdqem1LUkljUFVKT285MzJNYStaaUZQ?=
 =?utf-8?B?bWpjT05ET1V1bW93NlJNVUJBMWdUQTdBZ2E0eHJvV0tESExVZjBMMzFHMm04?=
 =?utf-8?B?c09JWmZ6M0didjFzUFZhS3U3c081SGNEWUlRSXp4dHdnWXdZeUN0Z29CbkdG?=
 =?utf-8?B?VnhWTjRUTWc4WG00OFdBbk52Mi9xTEdWWGJjbDlOck93aVFaM2VLL29jSlJ5?=
 =?utf-8?B?SVpFT3VhcXhCZnlHTTZGUDIvbzJ6TGViZWdqY0xDMzk1MWhnaGFjeTN3Znhz?=
 =?utf-8?B?UitjUkpIQzNqZXdMMjBUUmxPbVhyUlMybnlWM0NERXg2YWpVcHR4am42VmZh?=
 =?utf-8?B?VW5zcklpNll3VEo5b1dCVkJjNmFRb3Y5bXlnYy8rdldRbkdVMnpWYmtpcEFK?=
 =?utf-8?B?clp1UHp4RXVyTlVybG5Jd2ZUM1haWWkvQmNSYlJiS2cxbHg0eG94MkgwN1Vj?=
 =?utf-8?B?S1NkMEVYYWRsU0pxblJOcUd1dFZoR1A0UWFNNTZGYnVqcXRGczU0L0J6Q0k2?=
 =?utf-8?B?VUdLREIzc1pNN2VuR0R1cWYyV1p4dVVSc1VNaDJZUHQwcEdYdlBZcE84eGtO?=
 =?utf-8?B?VXdKMzZhSlE4Umx6bDZEMVh5ZU5jZ2NscTh5dHcrSHRJcFNia3Fub0s2MjB1?=
 =?utf-8?B?MTE1MTFzdGZURktWNFRVQ1I1azRZMXBJTUxmRDY1eTZ4c3l4WUh4NXE5d2hx?=
 =?utf-8?B?cmE4djc3K0dOR3ovZmg0bCtkalZOeWoyczlhUHFweFNuWThwQUNKYnFGOVVX?=
 =?utf-8?B?QXNNTzJoem9UQTA0QVRrS3FQL0hSUnNiS3lzR3R6ZGh0VUJtajg4SnhYOS9K?=
 =?utf-8?B?TWxOaUNYejE1V1FTZlNhYkJqWkxaR2ladkZOaWQ5c1BvTm1ZTmcrWXp6d2xv?=
 =?utf-8?B?WDU4amhWUFFGUkFnRHJOYUc2MnBKMnF3TXdDRHR2a1BrRmU1L25FQWg2R0Uv?=
 =?utf-8?B?Y3NsSTVVZDZkUzFYWTlxc0IrN0RXNlNRS0FQUS84TUJzU3dyMzRySkNMWmhN?=
 =?utf-8?B?VXpkZUlGZ3J1alEzcThrdm1jSE1vT21CdjlxWHRQRkVOemdVVStPcitrak03?=
 =?utf-8?B?dm5yUEwwbjVkYUE0L0M0aG1uVXpyU0o2WWNvajFZcnR2M0IzZmdOeHVoZGVG?=
 =?utf-8?B?d05XLzV6TFZmQjZ1NjJUZE8xZDQvbkxOVWtZR0R4U3pRc3c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UVNObWJqZUk3aU11OXoyS24wWGJiR25FY0NIQU1MVDFVaThzSG9wdEJyVTMw?=
 =?utf-8?B?Y0dkbHpkR0hFRit3LzhwSmdQNVNUcWNDYjJJVjJrWk54R3drd0R1ajVHSnU1?=
 =?utf-8?B?MWZNdFQwbGNqWGtaRzhXWUdQSDdWL0ErUEJQa09UMVNSRG5UdnVUSDV4TWZT?=
 =?utf-8?B?ZmlLR05kemRKUWUzYmVJdldMeDdCREZDbUpmSzVxRGpXZS9jNXNrM1NpQkVU?=
 =?utf-8?B?Q2Z4WWI1M2RBWTVsRThJNE5hQXFMd3dyaWNma3pGRDNQdU9wemROYUhNbys4?=
 =?utf-8?B?L0kyVDFld0ZzMXFrRUUvZkR3clY0akdBalA0dGZhandNVXU5a1BRMW83b1lm?=
 =?utf-8?B?RnEzRkliNEJBWVROUGtlelIrdFkxcUhqNTlwbUhXL0ZrUmVYd3VWWHhwWFY2?=
 =?utf-8?B?SzZIWm9TYjJqbG1kZUpFdGNjUThNaHdhNHYzTzVhLzlQYTc3MFpSdXdKSkh2?=
 =?utf-8?B?bnZqdXVwVk5EejJUWmNBUTl1TlZNOGFvSnZFTmJJSkVPb2tERDBuNTh6MnlJ?=
 =?utf-8?B?U2pxcXdCbkhTdzBlMUhiVzhYK09CbWd3QUwySXhFaE10dE1YZnJYZ2FqaGVi?=
 =?utf-8?B?VkxrUUlvZnNqZEd3cGQ4aUp2VzEvNVgzcFpieU5LL0xZTWw4TXdIQ0pBSVZa?=
 =?utf-8?B?cVBIYnE2VjNtcXRjcFk4TDRxblVDSmFkbEFUWklWL2xjeVhCV3IvMTAwOGVX?=
 =?utf-8?B?ZmgzdkkvL2ZGRlNWSWZic0drYjZhTTcxdjZwWFc2QTJzUFV5cHBKT2M1Zjlq?=
 =?utf-8?B?b21JK2dMMVF1dkV2dmYzNTg3VUh4ZE0zVVQ1WjVmTTd3YU5uNUs1dzhYaWt6?=
 =?utf-8?B?UitLbWVtRzV4dkp1ZjE3K01Mc21MWUNsTG1ubHVnOThQNjJRWDh3R1dSZUZx?=
 =?utf-8?B?T3doNEtyRGpNdS9xVUpybldKNG4wOStzRGUwMUFXMFEyTGFJRitUTnNYSlFp?=
 =?utf-8?B?NGJrL3NFcllneFFzc0RhcDdRZEpMdTliL1ZpenFaaWRvSlg5S0NsTWQrdlZS?=
 =?utf-8?B?Tk02anNLSnhWb25TM3FLL0ZBZGpXR2pyVUhSYUdPUTk1a1c5aWh6RWF6c2ht?=
 =?utf-8?B?WUlKbkkwcFMyVUY2cm5qMVVKSUZubmtGWk5BWjF5aHlaVmw5ZDVaclN4amtw?=
 =?utf-8?B?WEJtdXV0Q3QwRzBQc3Z4MVVvWWI3SHpoMGQzNmNIcHZtdHVsSWk2ODVzYThM?=
 =?utf-8?B?V1RKMzgzNkJ4b01nRjhFQ2xBSFRad2ZYcjYva1lleGFVa3VVUTNYS0pUeTBL?=
 =?utf-8?B?WGRWTnZENWRkeWcvcGxsazVYNVI4c2tCVVp5L25XSXZ3MWpncityRzlHUEpp?=
 =?utf-8?B?bjdZVVI5aVQvdHlIVyt3bnlKOVo1RUQ5ZUJueko3bmlGZWhld0dTQ3lqQlQv?=
 =?utf-8?B?MndyR3dtRGtVS0JnaEdSQ0ljVXowZ29VTVVQSmpRUm4xYWFqZzN2STdxVDJZ?=
 =?utf-8?B?R20vZ28yNGRVZGNKTzF1S0U3QUhSTndCRDlhVEpKeUs2WFovRjR2MVRJbFNK?=
 =?utf-8?B?bjNIVnphVEczQXBmNFJQUWt3QkZlSG02V0QvanltUGFBcWN1NzJybnhxT04w?=
 =?utf-8?B?aE5XamgrUXJXZDZYVE92amJldGM5b1cveEhPaHAveW5DK2J2eGo0ZGw3cnB5?=
 =?utf-8?B?QlZKVU8rSzFtK05wREQ3N1BRVW81TkI5dk9LZFhJR3NJZ2p0MVF0MTJkZWRa?=
 =?utf-8?B?emZPOFlER3ByZUNaK3Z3c0R4aFRBUzdOVFNuKytyOEZXOUIrZngxdDZJQnFN?=
 =?utf-8?B?dGZCNVhmS3U1RkVCRWowL3ZhalhUSG5zRWJvZUtSdW9tZWNrV0F2STVoU1p2?=
 =?utf-8?B?S1RrclZlazloWk83NWlpWmEybDhFVm54eFV5TUpmU0RIQUdQb1BuVWQ1RXVE?=
 =?utf-8?B?Skg1cG1TcERQR2M5cHNzV2M5N2RiSkY3eFBEaGRtQUFEYk1YWGJSQTcrYTVy?=
 =?utf-8?B?M2tuQnJzakpzVHcrK2xCR1hKL2xxeHcyUlA5ekdjc3ArdzFjRzFTSVgwWjU4?=
 =?utf-8?B?RU1yUUFZNzU3OUhlck5tdjA2b1laNmFMbUhSN0dTQ0E2L2s3VHNMMjMvb1ha?=
 =?utf-8?B?cVFyeGpHYnpzSmkrLzd4Sy84dnQvZGRxbmt4UmVydWlrcThiWlZHNUhlN2t6?=
 =?utf-8?B?eUo3eml2bmxIM2c3RFFkWS9QSjd0aGtKamppaERyRGdZYjV1dDV5cUEyOW1P?=
 =?utf-8?Q?ZZ/UPeC7EejqVngD6gUCbjw=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51276d5d-bef5-4d39-d175-08de3665442c
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 14:22:50.0164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pWw3GHSkxgTiVpMX3cmPtsrRD9nyn/HwW8GsJmkryYXasn0Lq0HWmZlITY3xp93lRkLcICra7q+1lFB6hrwgM5b6nWZW15p3bQ9ag8Dl2ak=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB6502

On 2025-12-08 08:53, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>

Missing bracket for [PATCH] in subject.

> 
> Building the KVM intel module failed to build with UT=1:

failed -> fails (present ?)

> 
> no __tracepoint_strings in file: arch/x86/kvm/kvm-intel.o
> make[3]: *** [/work/git/test-linux.git/scripts/Makefile.modfinal:62: arch/x86/kvm/kvm-intel.ko] Error 1
> 
> The reason is that the module only uses the tracepoints defined and
> exported by the main kvm module. The tracepoint-udpate.c code fails the

I guess you mean "tracepoint-update.c" ?

> build if a tracepoint is used, but there's no tracepoints defined. But

tracepoint

> this is acceptable in modules if the tracepoints is defined in the vmlinux

tracepoint

> proper or another module and exported.
> 
> Do not fail to build if a tracepoint is used but no tracepoints are

tracepoint .. is

Thanks,

Mathieu

> defined if the code is a module. This should still never happen for the
> vmlinux itself.
> 
> Fixes: e30f8e61e2518 ("tracing: Add a tracepoint verification check at build time")
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>   scripts/tracepoint-update.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/scripts/tracepoint-update.c b/scripts/tracepoint-update.c
> index 7f7d90df14ce..90046aedc97b 100644
> --- a/scripts/tracepoint-update.c
> +++ b/scripts/tracepoint-update.c
> @@ -210,6 +210,9 @@ static int process_tracepoints(bool mod, void *addr, const char *fname)
>   	}
>   
>   	if (!tracepoint_data_sec) {
> +		/* A module may reference only exported tracepoints */
> +		if (mod)
> +			return 0;
>   		fprintf(stderr,	"no __tracepoint_strings in file: %s\n", fname);
>   		return -1;
>   	}


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
