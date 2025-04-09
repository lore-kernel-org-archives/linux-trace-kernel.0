Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022076.outbound.protection.outlook.com [40.107.193.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65DE1C173C;
	Wed,  9 Apr 2025 16:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.193.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744215511; cv=fail; b=Q6CEauEf07LpXAqWWbgReQQ9jp/vki/k7XDtSUPhrrcrXcWT0FBZdovrYVTI6qdwaV41GXLYqKK/Q3e+Lmx1oh6JNlaXVOR1iBNilwEAagLt6T6pLT6KRsF17Ne6lvPm1ZT5162GHZWYW1Q294BV0Pu0/7UEZqMsW1WY5rhPxOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744215511; c=relaxed/simple;
	bh=fhIWXIVgdeN9CVmf3UDueM++ya4rL+icyuUhwsJYPQc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hte+PLUz7CWxmUdWf6KjpUEyxPBsRcROc4cQC6jRgSVql9nrBgYcw/vlLaG5BGgGyBe8ZE6uzEJHw4tt6+UiCSSA08iOBOg9lf/nQaGiewTYahA+FmHPVqyPjluj+CyXcWvbWf0UWTgJeozniWM2mYXf1yIcDW/ETKg9iVwyDRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=luleZ58A; arc=fail smtp.client-ip=40.107.193.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="luleZ58A"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gnhe7LU6bq0GQtrmuDi4F5zOLZrq2z9INWRRFMH/CqF/nFNmDLm6346gM+oqDa5JxKpsR1U96OOlPPY7yO0GwN4+FeY9wYSggGNHwWFTaE2HyHb/+oatHzue/rSWuNBUVtzRwRhgCBJ/GaXbB+v5VpfBb8x5Z+KAqqnhhGuZK5sGGt5+N7P+FCdTxHrXIJowyaipV2T8c/ZVJekha0oBtVHrAsldWyu0ieDs4Ivw2LGO7PqcIP+GA0/Awrjm2y40Hc4GzqOJ1s5xcBZ6aKj14ULy63Filgk1YT4jNRaL8sIs61gF+qdHUmJJLj+K9m7q6AzdFtE806nZ2iNH2n0MNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6XQSD5YiMQ8+X56/4tUxVC0VeUcFj1BntpZaBGrUPrI=;
 b=tiF86JVQAOvzrjZs1fP7o3nGyaFo9sqWntR6BB+9blOV+IgwYEZaqOxZ6AEGuGZGxo8biezggM7qoEJQidGzx6NuJnvzJfp99dvbU7vMSFq86BR+pB4oxPWuF4wl9XH6X9wgmEL6yZumOKOZcp6ppCNi0iBomR12vysDHLh19CV/jMqG/FPxS6sh7CspsrYT4iZGwd9WS29gO7GvaKiMC0PweH7d2ldWuYZ/dccZWwKKh0dwnt4j5T1RHDWzwCkJO18i+G8n0mXDysX5P9kee3lv+erSYAQdoKDBsXmcFv7lHb0gtnHmHrqNQVwkFtLYeJaW9s7ARUXvj+3iXta8fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6XQSD5YiMQ8+X56/4tUxVC0VeUcFj1BntpZaBGrUPrI=;
 b=luleZ58AOUVGSl3swvd9JQCaaTlYwuhkYnz4DJTQjIOAXRqz+PXlLFxCADaKcH0edif7xKio+h7QVEOXRrpHMk0SYrmZwcJl7MTnguXoQCDdlZ7RqZxg0FOhWZSS+nvWFb0AJ8y/gg29EvoPCiXijd7RyJ75R6v+TJ0uMgpXVZ+XXEIhgVtBQ+A6PzAyAgw0nRFcHHEEIczIHffIrxgl538okU+9vYdPVZQBTwnHrLyMa7T+7mg01SCbJqzCc7etu1nR7GIvWE6Yu0G4d6XUhqsQO7XkPa2DpYfzrP1DwvTKC/Pg1gpDtsJVLXQ9p4jHUvu1x9DdH9Q2cq8L8CUzZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT1PPF1CC8935A1.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b08::510) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Wed, 9 Apr
 2025 16:18:24 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%7]) with mapi id 15.20.8606.033; Wed, 9 Apr 2025
 16:18:24 +0000
Message-ID: <1516bba1-15ea-4b8a-ac83-e7db98b37397@efficios.com>
Date: Wed, 9 Apr 2025 12:18:22 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tracing: Allow the top level trace_marker to write into
 another instance
To: Steven Rostedt <rostedt@goodmis.org>, LKML
 <linux-kernel@vger.kernel.org>,
 Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
References: <20250408112714.403a4368@gandalf.local.home>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20250408112714.403a4368@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0351.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6b::10) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT1PPF1CC8935A1:EE_
X-MS-Office365-Filtering-Correlation-Id: f85019a6-b3ed-4a92-5dab-08dd778226d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NUZaUUVQUGRKVFQwaHZZYnYxV2QrR0hjelJuSnJjVHFTUnpJZjlTVDdhSzRO?=
 =?utf-8?B?L3pYRys2cEZpa1BrckVQV0xmNjljOHJCQUl6YTRNYmw3TFVMbXNBTUNnaW1T?=
 =?utf-8?B?cWhnVnZBZmh0a2NWOXJzaHozRVVId0cyMzdyK292b09wS0lMU3ZzSnNHZ3I0?=
 =?utf-8?B?LzNuRGpHRDRKdjdqZUl4dFVzUFhJSzFnR2g4ZE0ybWZPcVc2SXg3Vm82QytV?=
 =?utf-8?B?Sm5vWFV5R1ErZVhQOGVSV0w1cDcydHk4Q2gzVVRIVzBXTWsxdFE4bGY3RCtp?=
 =?utf-8?B?U2ZxRWV3b1FkZjFQNjltQUtJbWNtSVhSWDZadmxRL2VpU0FFdlN2ZWJqRTU1?=
 =?utf-8?B?Q0pobDE2bGxxeUZRcEZmQS9QQWZiOVlYV09RcFd0dVNHcFZ0cy96T3A0NzBY?=
 =?utf-8?B?ckdiSEdrZW1CQ0k3NlpYWGYxSG5xWWdqU2l5cjFGbnZIdExNOXdWTzVqMVBS?=
 =?utf-8?B?QXEvM2Q3RHNtNmF2NVNlVDBYQmZpUUY3ZWh6V290WDZzQ1Q3V3MyeThiRVBv?=
 =?utf-8?B?VXpVMzlCVVYvNkVyUnA3MlRNczRPaC9WYlBmczcwT1hqR0cveVNtV3AzZHo4?=
 =?utf-8?B?enh3R1lRdU16L29zZmlRMGFybitDdEtoK1hHZlRWakhEZzRqYy9CTld6bjds?=
 =?utf-8?B?dVlTV1kvN0ZxcEU1L0FPNzh2c2xpNXJEdHExVUNpK2NtQ1hVMnVSYVNodFBW?=
 =?utf-8?B?YVVhMEtGWXVhZ3JBeTZna3pENFN6U0M1ZHZCZTViVm12NGgwcmlwTEhGeDls?=
 =?utf-8?B?SXNJbi8rRFhsNDlRNDY2MHkrVms5UkRRM3ZrOElGT2RpdGlyYXNadXo2WTF6?=
 =?utf-8?B?aTBDUVk4YjFWdDYvYmxyczN4RDdMTHZVVUhwaThtb2o5Y1BkZkl1S0oyT28y?=
 =?utf-8?B?OE9GY29TQjB5VWsvbVdEbG0yVmJaaE9nRDE0Nm1xcHJVOFppVDhEbTJKL1M2?=
 =?utf-8?B?Znl5UnV0Z2h5N1hVeEJId25uejI5R0F1bE9wYlk2dW5DVzhmRUFxdmJNakRq?=
 =?utf-8?B?VmMzL09RbTZ3cEJjYk9Ibkk4RlFQcHpqbnBjTmViSnVmQi9JeDVPQW9DbG1j?=
 =?utf-8?B?R0tZa2orSmdLRTNTSjl6YmVENG0wTHFiQk1rL2RVeVEyM3hxWU9yS3Fic2wx?=
 =?utf-8?B?Z0JhdE9tS3UvSnh6VWd1T0MvNmJHejN2aVptdEhNRUN1MHoyZW8yOE9Oc0or?=
 =?utf-8?B?M1ZwODZoM1JyWkNCOHRtN0dtbElzSlpub2ducDFOUjlWMWw0dGc4UTYyT1Ar?=
 =?utf-8?B?Y29jb3dXbXFGUXVrWm1WTUd5aE5uNkhQY0lRQURwZHYvNHFzUXhGR2RyQnpz?=
 =?utf-8?B?UC90NGJwazduMXRyQVQxcC9BSWVMdHd3OHhZMzlqNFNuanFYdjd1bE53NVNU?=
 =?utf-8?B?eTlJSkN2a3BLTk9iSDdZelNOZGVPNVNiWGEySllMS2REd1hORkhnTitCTjBC?=
 =?utf-8?B?ZWhxYi9vOW90TFFZaDlySnFxc2h6TlJRYnQ5NDEzMTVKRktBNWhXVWxXR2hH?=
 =?utf-8?B?a29qdDE4SEV0U1NQUWdqdVJrTU4zSnNvMzlIZkxYNUhoYUk5VlZQbFZsT2Ni?=
 =?utf-8?B?d3NrWDAxbS8ycXRBZGtaZG5WTE9TYkdGamZNc0xmMW0vbERxR2o2THlGZjJN?=
 =?utf-8?B?MzYxNVJRTlVLc2JGMktXUUNkWVo1MTJqU2pyOE9BM1JGMGljRlJWN2F4Vm00?=
 =?utf-8?B?MDFZT1dYOGN2TlhEN2FSOHFpTTUvbzRaVk1sM1JvTFVZd0VnRFhLZnY4cy8v?=
 =?utf-8?Q?S9sQrxI9nZE8WaYPcxEFwGROPrv5gmU7F0pKXaQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SUFjUG5FTmN4T1h1QlVONXpzUThWMFd0RG1EQWZNTG94UFJJK29Wd0hZOTJm?=
 =?utf-8?B?NHdpbmxKeHcrbmRlQkQwTlUvdUc1MlhuWnd1Qnhvb3N5aGlWV1ZvZVplOEFL?=
 =?utf-8?B?QzM3RklKSnZvWkpEcGVaQWR6WG5QbVlKc1YvdEluM25GSVNPeVVBM2dLWkVP?=
 =?utf-8?B?ei83RWNGR3F2RnJoTm1JWGkvSHJCK0lGaFg5b2xwRmp1RVFuWW02Z2h3K3N6?=
 =?utf-8?B?OU9NNldFbmlPVE5UQUdJWjBZRXhhRUJHMFE2Rmt5SG9SYlp4ZitMYis0aXFi?=
 =?utf-8?B?Q3NsYVlvbWtRcGZZaHFVbzhhK3ZlNE1iZjlucGhpbTR2QjFhTDNsaVl6MlBZ?=
 =?utf-8?B?SysyeFViWFFsdGgwem5OWG9BcVY2NVpFMzRrNVlneERJYWJGdktoNGt1S05a?=
 =?utf-8?B?bWhxZWNReVQzRWxwUXhwSjlEQWxsV0o0c1J3aVRPeVE2ZXFLL1l3bFlaeFY4?=
 =?utf-8?B?dnhOc1Bld0dYOFBRbjluMlk2aG83RWQ4N1BSbzRPN2VaNGZVdXJyVW5KaVFL?=
 =?utf-8?B?Y1FZdnh0YS9qZ1crSmwxNGNYZ3pjSTI4VkJXMUN6aWYxOEljSXBWdkFFZlZu?=
 =?utf-8?B?c0s3ZW1qME1NUVpjM2V6T2lEUXBxcGNRYktxMlVMSlZkMFA1ZDhyMHdncy9Z?=
 =?utf-8?B?ck84bXkrdVFSdytMaUR0WU1rVEY5dXJGMGNQK0E0ZjJqdHJZOEZUNUpPaHdI?=
 =?utf-8?B?djh6UitBanpWTUNlU2tXbmVtTzRDT2paVXhrMnUvc3g2ZDM3ZXkzMzN6TnRO?=
 =?utf-8?B?Rms5UHdNS0Mwb0Z0alNqTFJIbkg4MXMwYkllUlAycEdDWG9ObHFtRFZ1ZUJp?=
 =?utf-8?B?TGFJMzUxNEFQRDFOTnNxTDlRU3o0VnM5SERCWVhWMjYyUGlEZWNRYk5nemZq?=
 =?utf-8?B?TVNDT3BPVWxpS3VuOTJpbUdrM1V3a0MyVjhvaDgrNEwxR3RMcHU0NDF3MHBh?=
 =?utf-8?B?OTAzdUNTTFVtRXozK295Q0hIbnY5OXVmUVhFdWhVVnBEaFNpUDZzYzgxMVVa?=
 =?utf-8?B?aFJPYmVMLzBQSlZhcWV2ZHI5NVY1ejlIUW55VFVHVVNKbTZjVG5rRzhIem9z?=
 =?utf-8?B?K3ZwZkZMWENIUFpqOVpBeVFzN1RmcWJhRWd0bkJtTThoOXBCaXozb0hTeTU0?=
 =?utf-8?B?UG9ITVV1VFBnNVpBVkplZlFlODZDYWhNS0k4UWk3QUtkc0l1STNKaExQQ1lE?=
 =?utf-8?B?NVIxZlFRL09BL05TTlc1MWg2NkRSVVBpWDBNbmFaYnNEZHVrS2FGNDBuV1RX?=
 =?utf-8?B?WHJDYnVLSmVhbmtlUVpIZzhQQ0FRUEJGNnR3YU92ZE9vUDIyTzlMZEtrV1Bu?=
 =?utf-8?B?emJWMlRwSEFsdGxyZHlvRVBkM2hQc3p5TUNydGJBV1hVMGh1c1JSRUp0Q2Iv?=
 =?utf-8?B?NzkvK3JZNzV6djN4dUYzWmxVazN4ZDYyU0EzWThvL1BuTVl0S2prZGZRNDNo?=
 =?utf-8?B?RXJUYzE5U0IyQ2duN1ZJWGI0WHY2MVFuNnlWa2MwY0NvTysvSlJ3STFsN2kv?=
 =?utf-8?B?azZIM09xUTIvWXlQdnFDalp3VGRlRFd4L1NENHNHQnR4YUhuQUJkYUxtQjBW?=
 =?utf-8?B?eEVna21VUjEvZng2RXdTcVRMOEx4SWtvVHFzYmFrRjFXVk5Wa0xmSmxPM0xB?=
 =?utf-8?B?R0FNQlNNMkdHQkFPaFRxdmJoSlRCZ1dYTEpURGFyRytGVWJTME1zS242V1Z6?=
 =?utf-8?B?S1piditNRDVvS0hjZ2ptREhQcG5PRkJtSVp0ZG9SbTl5b1lIVUNDbzZsOVM5?=
 =?utf-8?B?RTdXZ1dsbFRBY01GVnBJNXBINGJURk5tVzZ6NWJYT3poa3NhWWpwbFNKeit0?=
 =?utf-8?B?VHNMcUxSSFVjdGV5Vk8vakIwOUVmdnkxNnZ4L0JZUXUrNTdtUi9hRzVra1FG?=
 =?utf-8?B?ZUdsbFdwQWJmc2FFWkQxcnF4Rmo0WDNZaVEzN2M3S3lXR3RhZjVIc0JRVExL?=
 =?utf-8?B?ejVZY3pyZTdrdy83dVVjZVJwYjRIaldSNWdyczdHMFdqcERtanNTSGU3RnNp?=
 =?utf-8?B?eVVmMzRtZDdhaS9yU2c3RkxHcW84SmVNOE50amNTNWI0WVIxTVhNTTlOTm5z?=
 =?utf-8?B?WnNTSFowR29kRm8rVHJTZzZ1NWpDZnJCbGR3UXorNTB1U3hxbGxqclFzQnVS?=
 =?utf-8?B?RjN6K3hXSEVUYzZNa3p3VzVFR1pHRmxIT3hVZWFQTGdkVW9zODhZVmFXcVh6?=
 =?utf-8?Q?ZkWZKF6VxgrFpPCzc8N0mC0=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f85019a6-b3ed-4a92-5dab-08dd778226d5
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 16:18:23.9145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4IC2xWg0eq1i10A4iZAwP+iF90+o8Tc0eZEtHceblmF4dcmFMexp+A7aW/bwMvOJe5fNZNsyiaix5lvKGwp0ZosqJTCX2iASQwi8up/y3dU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PPF1CC8935A1

On 2025-04-08 11:27, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> There are applications that have it hard coded to write into the top level
> trace_marker instance (/sys/kernel/tracing/trace_marker). This can be
> annoying if a profiler is using that instance for other work, or if it
> needs all writes to go into a new instance.
> 
> A new option is created called "redirect_trace_marker". By default, the
> top level has this set, as that is the default buffer that writing into
> the top level trace_marker file will go to. But now if an instance is
> created and sets this option, all writes into the top level trace_marker
> will be redirected into that instance buffer just as if an application
> were to write into the instance's trace_marker file.
> 
> Only one instance can have this option set. If the option is set in
> another instance, then it will clear the option from the previous
> instance.
> 
> The top level instance can set this option but it can not clear it, and
> it will bring the writing of the trace_marker back to its buffer.

Why choose to redirect the top level trace marker from the global
buffer to the specific one rather than allow it to iterate on a
set of "interested" buffers ?

Thanks,

Mathieu

> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>   Documentation/trace/ftrace.rst | 15 +++++++++
>   kernel/trace/trace.c           | 60 +++++++++++++++++++++++++++++++---
>   kernel/trace/trace.h           |  1 +
>   3 files changed, 71 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
> index c9e88bf65709..6b3915139347 100644
> --- a/Documentation/trace/ftrace.rst
> +++ b/Documentation/trace/ftrace.rst
> @@ -1205,6 +1205,21 @@ Here are the available options:
>   	default instance. The only way the top level instance has this flag
>   	cleared, is by it being set in another instance.
>   
> +  redirect_trace_marker
> +	This is similar to the trace_printk_dest option above, but it works
> +	for the top level trace_marker (/sys/kernel/tracing/trace_marker).
> +	If there are applications that hard code writing into the top level
> +	trace_marker file, and the tooling would like it to go into an
> +	instance, this option can be used. Create an instance and set this
> +	option, and then all writes into the top level trace_marker file will
> +	be redirected into that instance.
> +
> +	This flag cannot be cleared by the top level instance, as it is the
> +	default instance. The only way the top level instance has this flag
> +	cleared, is by it being set in another instance. By setting this flag
> +	in the top level instance, it will put the writing into the
> +	trace_marker file back into the top level instance buffer.
> +
>     annotate
>   	It is sometimes confusing when the CPU buffers are full
>   	and one CPU buffer had a lot of events recently, thus
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 8ddf6b17215c..ec7e15434759 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -493,7 +493,8 @@ EXPORT_SYMBOL_GPL(unregister_ftrace_export);
>   	 TRACE_ITER_ANNOTATE | TRACE_ITER_CONTEXT_INFO |		\
>   	 TRACE_ITER_RECORD_CMD | TRACE_ITER_OVERWRITE |			\
>   	 TRACE_ITER_IRQ_INFO | TRACE_ITER_MARKERS |			\
> -	 TRACE_ITER_HASH_PTR | TRACE_ITER_TRACE_PRINTK)
> +	 TRACE_ITER_HASH_PTR | TRACE_ITER_TRACE_PRINTK |		\
> +	 TRACE_ITER_REDIRECT_MARKER)
>   
>   /* trace_options that are only supported by global_trace */
>   #define TOP_LEVEL_TRACE_FLAGS (TRACE_ITER_PRINTK |			\
> @@ -501,7 +502,8 @@ EXPORT_SYMBOL_GPL(unregister_ftrace_export);
>   
>   /* trace_flags that are default zero for instances */
>   #define ZEROED_TRACE_FLAGS \
> -	(TRACE_ITER_EVENT_FORK | TRACE_ITER_FUNC_FORK | TRACE_ITER_TRACE_PRINTK)
> +	(TRACE_ITER_EVENT_FORK | TRACE_ITER_FUNC_FORK | TRACE_ITER_TRACE_PRINTK | \
> +	 TRACE_ITER_REDIRECT_MARKER)
>   
>   /*
>    * The global_trace is the descriptor that holds the top-level tracing
> @@ -512,6 +514,7 @@ static struct trace_array global_trace = {
>   };
>   
>   static struct trace_array *printk_trace = &global_trace;
> +static struct trace_array *marker_trace = &global_trace;
>   
>   static __always_inline bool printk_binsafe(struct trace_array *tr)
>   {
> @@ -534,6 +537,16 @@ static void update_printk_trace(struct trace_array *tr)
>   	tr->trace_flags |= TRACE_ITER_TRACE_PRINTK;
>   }
>   
> +static void update_marker_trace(struct trace_array *tr)
> +{
> +	if (marker_trace == tr)
> +		return;
> +
> +	marker_trace->trace_flags &= ~TRACE_ITER_REDIRECT_MARKER;
> +	marker_trace = tr;
> +	tr->trace_flags |= TRACE_ITER_REDIRECT_MARKER;
> +}
> +
>   void trace_set_ring_buffer_expanded(struct trace_array *tr)
>   {
>   	if (!tr)
> @@ -4755,8 +4768,22 @@ int tracing_single_release_file_tr(struct inode *inode, struct file *filp)
>   
>   static int tracing_mark_open(struct inode *inode, struct file *filp)
>   {
> +	struct trace_array *tr = inode->i_private;
> +	int ret;
> +
>   	stream_open(inode, filp);
> -	return tracing_open_generic_tr(inode, filp);
> +
> +	/* The top level marker can have it redirected to an instance */
> +	if (tr == &global_trace)
> +		tr = marker_trace;
> +
> +	ret = tracing_check_open_get_tr(tr);
> +	if (ret)
> +		return ret;
> +
> +	filp->private_data = tr;
> +
> +	return 0;
>   }
>   
>   static int tracing_release(struct inode *inode, struct file *file)
> @@ -4799,7 +4826,7 @@ static int tracing_release(struct inode *inode, struct file *file)
>   
>   int tracing_release_generic_tr(struct inode *inode, struct file *file)
>   {
> -	struct trace_array *tr = inode->i_private;
> +	struct trace_array *tr = file->private_data;
>   
>   	trace_array_put(tr);
>   	return 0;
> @@ -5189,7 +5216,8 @@ int set_tracer_flag(struct trace_array *tr, unsigned int mask, int enabled)
>   {
>   	if ((mask == TRACE_ITER_RECORD_TGID) ||
>   	    (mask == TRACE_ITER_RECORD_CMD) ||
> -	    (mask == TRACE_ITER_TRACE_PRINTK))
> +	    (mask == TRACE_ITER_TRACE_PRINTK) ||
> +	    (mask == TRACE_ITER_REDIRECT_MARKER))
>   		lockdep_assert_held(&event_mutex);
>   
>   	/* do nothing if flag is already set */
> @@ -5220,6 +5248,25 @@ int set_tracer_flag(struct trace_array *tr, unsigned int mask, int enabled)
>   		}
>   	}
>   
> +	if (mask == TRACE_ITER_REDIRECT_MARKER) {
> +		if (enabled) {
> +			update_marker_trace(tr);
> +		} else {
> +			/*
> +			 * The global_trace cannot clear this.
> +			 * It's flag only gets cleared if another instance sets it.
> +			 */
> +			if (marker_trace == &global_trace)
> +				return -EINVAL;
> +			/*
> +			 * An instance must always have it set.
> +			 * by default, that's the global_trace instane.
> +			 */
> +			if (marker_trace == tr)
> +				update_marker_trace(&global_trace);
> +		}
> +	}
> +
>   	if (enabled)
>   		tr->trace_flags |= mask;
>   	else
> @@ -9897,6 +9944,9 @@ static int __remove_instance(struct trace_array *tr)
>   	if (printk_trace == tr)
>   		update_printk_trace(&global_trace);
>   
> +	if (marker_trace == tr)
> +		update_marker_trace(&global_trace);
> +
>   	tracing_set_nop(tr);
>   	clear_ftrace_function_probes(tr);
>   	event_trace_del_tracer(tr);
> diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> index 79be1995db44..602457eda8e8 100644
> --- a/kernel/trace/trace.h
> +++ b/kernel/trace/trace.h
> @@ -1368,6 +1368,7 @@ extern int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
>   		C(MARKERS,		"markers"),		\
>   		C(EVENT_FORK,		"event-fork"),		\
>   		C(TRACE_PRINTK,		"trace_printk_dest"),	\
> +		C(REDIRECT_MARKER,	"redirect_trace_marker"),\
>   		C(PAUSE_ON_TRACE,	"pause-on-trace"),	\
>   		C(HASH_PTR,		"hash-ptr"),	/* Print hashed pointer */ \
>   		FUNCTION_FLAGS					\


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
