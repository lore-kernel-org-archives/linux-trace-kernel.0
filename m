Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022114.outbound.protection.outlook.com [40.107.193.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644351A287E;
	Tue, 28 Jan 2025 15:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.193.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738079187; cv=fail; b=C/51DRlBIJMowCOlkgnhtkQlRsNv+TSxXBA/hG7UnL1pGkfHwVuWt6xiZcCXODZJ0tow9J2fEtddFPtCqd/vvGVuaAZev7zq6EkUSQd/EdCPm8ADFvoktCRdi4qUnUi5d7/NvGWpPq/mPcWdYGV5lUEWYYRUA274qI2cYDt8oVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738079187; c=relaxed/simple;
	bh=qyPKJ6FIb8LuG/FIRr9CtDL/vTX6jMok4Ko8i84r0zg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bsnPKsyXF1WH/jOUHbdNtpGKRHrJAPrlOACd2xMxk43pZm2ygZ1f1C2sWIv/zKv9LSwqCuX1sFMUh7C+/73IwB+1XaIk8nv4tzafH5IQ4oJofDFyxSSpR1o+0VyxfGu2Q8CSDXFsVbZtwTGJ/LoFERZCHGHTs6VZXCM/pLZ5UBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=qD9xjTv/; arc=fail smtp.client-ip=40.107.193.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="qD9xjTv/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GEiFIrOwow9BdGCvUr8EX4b2fdSchpgjprLJVdRG8m+/oTaW1jT/sr0Mi64wVy6WRMclo6xusK5Mx5wcsk3aKqpCz7uz9SKpIhY4QZQoAVd2Kf90gfyvoDGCkh/tARnXZxkGXsb4sbdcfx4ymbcRT+pL8iKh7W3L4R40cJ0oBqpB+W3FerQNvp1Txjyjx4yb0IHU6IJinC9Xw94bRgd3TtR4xjuwP56MfLDU/9S/80LdhSW6+iZuVrVoWJ5mlcssnmvSpuLb1NCo7IfjS3foFNY6mcCGiaUTxwUBFC7K4+TZU6CrMN+HeL2C9vOgjVfr3TAgDL2AiCZGn2Gn2jtF2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+f8heTvGHvKnOJScsGK7K/N+HPYtUD8GqRxmNGsGIaY=;
 b=NOxwPJwSVF+FgO1VwZOBThuFM7wT9GkfuAXuCWgbZiej7f/nPq9AquVGv1x48Lj1eh1qO3bqkNpgcbqQI1neQs5n2F947swkyP6TbgXlLoScixXf9zOJ+KetNq+QJCofU59k3AYFZvxJ3oUEQDTEP2zAwlS9AeLW/oAr/yaU7H+ekmGXiInboDNP6nDXwMiIpDzKPf4+sxjaXOACOhL0XUcG4hHCmnQgZ/1TFAaVWzOc6Fm6x1FyCk9IXFHOxLMuPJJynxvsFXjzanF6KYLpeIoC494HlUQlEENSxj7ZLmAoCKklChVHoe5sXXLdiNcmuMID2zzN/ta5u2hXiPdnBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+f8heTvGHvKnOJScsGK7K/N+HPYtUD8GqRxmNGsGIaY=;
 b=qD9xjTv/ff74uNlEOxedeno2V6DpyAK4JvqgIT+a1h2H4F+Pij5IkeAjJW3/aMmTRbFWCvH/w4+l6izTs2RAFDY/9rKbMF2jwWf3az/+Iio4sGxF7CCjei3i4SZJsoB/fdYmQYSX0pbvxcjEEm73YeUZctx+JDNI1m26cs8+462c1uktSYAWzK4u5ZO8T3tkEpOFLEvWjs97XJiUR8w72OXZRlIXJ+eyCRsyjSAFR5zE1b3dq1rx0u+riY+DQdzRqp08KW4zuFN//piaiYNBf2h5MudtW3VJTU8CQIOriLuOpQRCx9dZoFjuKXbc9/sf4zh/DIAu9+leSITmmSd9Jg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT2PR01MB6175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:5b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.17; Tue, 28 Jan
 2025 15:46:23 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%6]) with mapi id 15.20.8377.021; Tue, 28 Jan 2025
 15:46:23 +0000
Message-ID: <a7a171c4-7feb-4f26-a832-18d38a3ee973@efficios.com>
Date: Tue, 28 Jan 2025 10:46:21 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/3] tracing: Introduce relative stacktrace
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
 Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez
 <da.gomez@samsung.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-modules@vger.kernel.org
References: <173807861687.1525539.15082309716909038251.stgit@mhiramat.roam.corp.google.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <173807861687.1525539.15082309716909038251.stgit@mhiramat.roam.corp.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0119.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::19) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT2PR01MB6175:EE_
X-MS-Office365-Filtering-Correlation-Id: 00b9ebd8-6967-467b-43a8-08dd3fb2eaa2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?amYrWE9zQVVPMFlDRG1hNWdJNFZ1M0RNTGd4ZlNqbzJkOHV6K0tROVQrTUYx?=
 =?utf-8?B?YXE3L0trZ1FHc1l2NmxNWllUaEJBSXd0U3dHMHoreUhya2JsU3ZzSDhDMWM4?=
 =?utf-8?B?ZlkwSGRDOXVDUkViOFVmSkFhajM4SWRiRUJxeDBjSzRuU095V1lJcTR0TXdH?=
 =?utf-8?B?MjVWYlpaU0dWM2VzMWt3UGVDL3Q5eHhFbFRwMGZvcEVsQjhIWnhuZ1Z3cnFB?=
 =?utf-8?B?c1N4K2tmN1NMa2hZR0YyQmRKSjkyOStBbXA1N00vYmlZdHhSU1B3c1o2SzZS?=
 =?utf-8?B?M3pKLzBjSndFTDNFNlVFeUdYSU05TG1ZTHN2SG9xZjhDUGFpY0dKR1U5ZlJt?=
 =?utf-8?B?cU1meHJpQllCVFh3aHZaWTBSZXlRR0NSQW41WDhEUEVweTV4VGdUazJsdDlz?=
 =?utf-8?B?Z2dFR1hQQ1ozT2x4ckdIVmlnaEZWQzIyK3hwUzl3VDlZanJVUG92WDU4TTNa?=
 =?utf-8?B?QndmMGVjdTBqSGlKeHY2MVFJSHdOUTdJQUNzaS9KUHRJM0NBbSs1bGRCQjgw?=
 =?utf-8?B?Lzh3NDNUNUlLWDF3RWNQUnJzblVtMXBSTmRMQ1ZiellJVXVQbno2VFhCd2Fm?=
 =?utf-8?B?d2lHTDZOTVZQeFpMRE83TmZmV0hiTmxZR0NhbVlxMDcwWC9DckhyVTZyNVNM?=
 =?utf-8?B?bWtTMHJzVUtlZ0d6RTNZd1R4ZzRWSEkyQ0Q0V2xhaGlQM3luYTBaSkdLampa?=
 =?utf-8?B?OENxSDBzWXpUa0RYd3E3dUhJQmJXREVmNXg2WW05bHZrVUU0cHphWWdwUnpz?=
 =?utf-8?B?V0dKMTBEYlhkR3ZZbGg3SEpWNHprcXR0OHJLalhjY1p2aHFKZko5elBRK0JO?=
 =?utf-8?B?UnZ4WDBiRnk3VmN6ZGpSRDJnZDc2Y1U4N0tLMFdHUk5yZTBpNzJPaVlhN0cv?=
 =?utf-8?B?RWdNME85Rno5ZHV5b1NVOThZQ3ljTnFjZFVBeVN5WDV1emhGREtYNnNVLzNq?=
 =?utf-8?B?UVlQWE5BcGtuMjFTVWpLWFhZSXNtdFJFblRMaVdBUm5uNXFXelFTelRSTEky?=
 =?utf-8?B?SFFvTWNpclV4L1MxZVJKWURjYkhnME5TUGFETjlzZ1hCYS9jWUorWWkwZTdn?=
 =?utf-8?B?blNWeHJ6Y3ZuT05uM1Q1VlJTRzNMUFdIQXNyUTI2UkFGR29kMTgvbXZpd29I?=
 =?utf-8?B?NGJNZUlWN1JFbjRCd0cvVjNyU3NONi9BVGxxTy9HZGgwS0hrc1YvbmVBVnJK?=
 =?utf-8?B?SEE2Z09oc0tuMnpMU21FME00WFRzSDZzdkFVTDExNXE5d1BIOHNjKzNhS2ZX?=
 =?utf-8?B?emZzdkJObW9DekVpQjl0MGN5d1BqRE4rMUNVMndydWNTK2sxQ0FvNDBaS1VE?=
 =?utf-8?B?bDdtczkrZk5WUmkzNEdOVFRodlA1VHJtZ1NzSHNUMS8xVXhlSDNFbmFDUlBy?=
 =?utf-8?B?VDdiMG5XWU1SSFFxOUx0cXZ4TFRvZ29tWlE0VjBWZjhlNUFLcnpPQ2FDc1ZZ?=
 =?utf-8?B?VmZGRFlpK3RjZGg4Zm9vOTVDTlVxcmM1WDBFbFNrZjlIb3UrVGw5VUFpUVlV?=
 =?utf-8?B?N1dPcy9RUlhJeXpaSFdZTUFzVXBUMGgvcDdKT1IwcmNoMHBDZDlSYnErVCty?=
 =?utf-8?B?RUJnR284bmllcEtmMitVRmMvSloweXEyMlJzQWFVdW53bklCSWhObWtVWmtP?=
 =?utf-8?B?M0p6OHppRFU0SVIrNGhNaE5kbm56UjdzRjRXbVQ3R0MzdGFQTUlEMmFsSS81?=
 =?utf-8?B?NU85MVp4RE05ZWphSkk5enhsazhaakNOZHF1VmYwV0VYdDN0emZQK2lxdTB5?=
 =?utf-8?Q?1MTthlsQJFLtOUnq+oOAaV04NWUiO/7hIbMhb2M?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R0tZc3RYenppb0hSSk9rdWE2dDUwSk1NdDE1K0w4cU1LZENoL3pPdWlSdlhO?=
 =?utf-8?B?TXF5dFNpUE95dXd1MCtUR29mYVlYUU4xbHlGS3JZYW5uUHdQR2dKQ1U4SVl5?=
 =?utf-8?B?SDkyYzB1RzRHWnR3bFZnRDQ0UDUxaGdqTEJkaDBDMjJVMVUzaHFld1JyL2tV?=
 =?utf-8?B?eVlTRGFNbXlOZTlDQ1dnVENiblNWb2pDZmRhSGR2SGk4ckRLck9QL2ozQWJh?=
 =?utf-8?B?bnRBT1VzYkFpdndBaEpPWkFWeDZONG1YcU83UHNuQk5sVFBIWVYrdGV5Lzc5?=
 =?utf-8?B?WkEweUtFSzg3TG94c1hnaWdyWWFDemUxckhnQ0xIRUk2UkRHM1lPVi8wL2ZM?=
 =?utf-8?B?dGRCR3U5UFRONzBReDVSVTdPZ1hpRlRKb3lGWjlJem94VUxHN0M3dE9uNzlK?=
 =?utf-8?B?Tm1WUVczNFZXMEdWMEV6aUR1NStZaU94Um5ZRDFCZ2JncmtuU2pzeWFKVzNy?=
 =?utf-8?B?QzVzc2Z6emdWV3Q0aUNDV2cwdGRKK29yWHNDZGxydTJKNy93M2tPR0I0MlYz?=
 =?utf-8?B?RUNVa2t4ZkkxeWE2ZVlLa0FxNy9URmg1NXpxZkxSa1NSQ09QdlBPbFhpSFlt?=
 =?utf-8?B?TEpYRDR0UGZ2MmszS1BMMGZkblhyMHpRc2RtOHo0dzJjNU5xNFZRenlkVkZ4?=
 =?utf-8?B?RDV5cUgweVZIV0cwdERGRjI4ZTNSMGl1TmlzNmZJYUd4L3Z5VkhPd2VaUVkv?=
 =?utf-8?B?WlBZb1V0S1JjVEtPaTd0WFpoYXgweW94NzczeWVKUi9IelhLdVBqTDFBNHhW?=
 =?utf-8?B?bk5uT2d2U2x6ZEl4bnNFMkxjenFuY0RLYXI0azNPN2dlbHZ2Yk94TVJlZkdJ?=
 =?utf-8?B?eUlhdGlNUlY1dFo2MkpGUmx4ai9DbEpVRllaanBQcUsxVEROS2VCdXFFY3Zr?=
 =?utf-8?B?OHR1a0VEbVpVNTRTdGdkOVQ3Z0tudzdRRUNuWTI4UHQ3a1NlZzcyS0M1WE5P?=
 =?utf-8?B?bTBaY2VmeW0zUWxYbDdOK3NFZm1jeElxY0F2cWpHYmxVRVd2eGZ3bFEzaS9V?=
 =?utf-8?B?UUZPS00wQmZKa3pWME5tT242T2hxbndKOTVaU0tjbytlTHkzU2hUZFV3YVJG?=
 =?utf-8?B?b0NHUnlMZXhXb2hWR3dPdVBxL1NxSkM0RVpLY3lENHpTVCtNNXAwb094UmFS?=
 =?utf-8?B?WVVKTFJLUDlYOGcvRWloencrRTBIK2FPV2ZRdWVRVHczVnRXcXVUZHcrNVBB?=
 =?utf-8?B?bnY0YmFhR2JVbnNqZkF3QkFmUjBEOW0rL3kyL0YxWFpHOHRvMS8zd25BZEQv?=
 =?utf-8?B?NUl6Y0dpcXNMWVJHRFV1M0hyS0pmNm5Dd0RyeWd0NG42UDBNaUF5ekxkbmR3?=
 =?utf-8?B?RThNczl2cjB6VGUzdEc1d1hUbkRtZXlWVlBMNjlIZjJybDZjMTNOMUIwNys5?=
 =?utf-8?B?R01ucnBleDBVQ1YyV0JLamFWQ1N4WGN6ZnBmN0xzQlBjTXprTTJtRWIrSkk0?=
 =?utf-8?B?M3hWUzBvdkFLcndmaHNVMnZuRkZiTExvM0V6NGtQOFpRbVI5eTJsVUk0cUdp?=
 =?utf-8?B?bE1QcTNJeitmNllKLzJwNHhBcDhLVTJRYWxzTkY5anJzaFA0VzQ5NGxkRWZo?=
 =?utf-8?B?a05nUHUvOTNFcnEvNWJHMEFCaC80WkU5Q2txdXpidnJWSDMwMUJoMDJiS0xw?=
 =?utf-8?B?M2hzQVUva3pxMTllM1BNSnYzaUkrYzVrS21YdWVRUEtsQ2VVeDUvK21ScDN6?=
 =?utf-8?B?SmVPaGVTTmVTUzVNZEpWajBlQkFnMFFpa1dQOUhvbnpYUVNYYysrNVFRajdi?=
 =?utf-8?B?YW1tOU0xZEN0OFlIY0FleXFVVXN3aXpIL2tvZjNRK2J1SGd0WGFZRExEY3Rr?=
 =?utf-8?B?ODF5b1lKWUFxcXFrRnc1a3Q2SEExQjBEL3lmVURKMjh3aDk1YnN0SjJQV2tr?=
 =?utf-8?B?dmRFQ1Y3NjFzZDU5ZVVOWFE5c2pXT2FweXduL3N3RXVVRlk4ZlBDVkNQdlpG?=
 =?utf-8?B?QzB2T2pEVzZhUytOeDJDS1NtUU11anJFK2x1OVJPWlgyaXFvOGZHR0ZkdXk5?=
 =?utf-8?B?Q0ozazdnenJuV0FpemU0Ykh4aEhWQjZMbWZROTJzMTJGRkd0SFJMK2MvYWFE?=
 =?utf-8?B?dzEwTnVpUDVxRHpjYUtlanpRRkl5ZDlwdGppRGNxaE9OWTFSQWl2Vmc2d0Ja?=
 =?utf-8?B?TlBsMGtWN0FreWZBcGhzeS9EQXNDaFlGTVpPY0FWNWluU29YUUN5YnZRYjV4?=
 =?utf-8?Q?LJNTMOlNFLGNV0HRM7fk+14=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00b9ebd8-6967-467b-43a8-08dd3fb2eaa2
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2025 15:46:23.0973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mp6BC8XsjMk7MJQym1s+E3QIL52BawrY9WGSJU/TbWsMm5f+/KT3z8wMuvHfiXF6SRn2nHhqyFkJYF2mm+/KtuhVqACC6l5bqOPXZbJjoHk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB6175

On 2025-01-28 10:36, Masami Hiramatsu (Google) wrote:
> Hi,
> 
> This introduces relative stacktrace, which records stacktrace entry as
> the offset from _stext instead of raw address. User can enable this
> format by setting options/relative-stacktrace.
> 
> Basically, this does not change anything for users who are using ftrace
> with 'trace' text-formatted interface. This changes how each stacktrace
> entry address is stored, so users who is using 'trace_pipe_raw' needs
> to change how to decode the stacktrace.
> 
> Currently, the stacktrace is stored as raw kernel address. Thus, for
> decoding the binary trace data, we need to refer the kallsyms. But this
> is not useful on the platform which prohibits to access /proc/kallsyms
> for security reason. Since KASLR will change the kernel text address,
> we can not decode symbols without kallsyms in userspace.
> 
> On the other hand, if we record the stacktrace entries in the offset
> from _stext, we can use System.map file to decode it. This is also good
> for the stacktrace in the persistent ring buffer, because we don't need
> to save the kallsyms before crash anymore.
> 
> The problem is to decode the address in the modules because it will be
> loaded in the different place. To solve this issue, I also introduced
> 'module_text_offsets' event, which records module's text and init_text
> info as the offset from _stext when loading it. User can store this
> event in the (another) persistent ring buffer for decoding.

This does not handle the situation where a module is already loaded
before tracing starts. In LTTng we have a statedump facility for this,
where we can iterate on all modules at trace start and dump the relevant
information.

You may want to consider a similar approach for other tracers.

Thanks,

Mathieu

> 
> Thank you,
> 
> ---
> 
> Masami Hiramatsu (Google) (3):
>        tracing: Record stacktrace as the offset from _stext
>        tracing: Introduce "rel_stack" option
>        modules: tracing: Add module_text_offsets event
> 
> 
>   include/trace/events/module.h |   40 ++++++++++++++++++++++++++++++++++++++++
>   kernel/module/main.c          |    1 +
>   kernel/trace/trace.c          |   11 ++++++++++-
>   kernel/trace/trace.h          |    2 ++
>   kernel/trace/trace_entries.h  |   22 ++++++++++++++++++++++
>   kernel/trace/trace_output.c   |   35 +++++++++++++++++++++++++++++++----
>   6 files changed, 106 insertions(+), 5 deletions(-)
> 
> --
> Signature

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

