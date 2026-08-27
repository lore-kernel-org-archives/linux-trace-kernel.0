Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013029.outbound.protection.outlook.com [40.107.159.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D273AB274;
	Thu, 27 Aug 2026 10:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787825420; cv=fail; b=Ync/n6CJ9G17CX6KTzddN8nPG7UNxaDT1hEYbll98wg9DtdZruoH7LGXKYWRiwrQBVf9ePA3E1lT95wix7eElCNQ1oK3NJUi5AThKrgvJFQD5GExqyR4ZjGa6zl5hMhSjLEP22PC2Yke/1nbnu4nihlWzMoHjeybBThVIKgNSHc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787825420; c=relaxed/simple;
	bh=RMWLtJ5Re9mwVUZsJjujkuGByzLTFSJX1JlkeXJuRe0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nQ8PQwZEU2bcWU37ZohU/kinhdn60IxNoACPeSRHMJrIK6isrNYimDkP/QRl52gt31FLLQZirbgrf5dMJmRDUiX6VT5uR4bmzjRdMF89QCy999/oG1jsnSfWg9lAd84Hh6JwOrGWJSz7+WlCMcG4gzgjsl6TPK9HTDGwCQQmKy8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=Yho0BvOg; arc=fail smtp.client-ip=40.107.159.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Yho0BvOg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JaZohjnc0NV9KzUf0Qy2NTGkJ6npn/1MJEjZDWBO06AeSELtyNvcfBZ9sgW5AJEC79pwwFmI+oK32N67HBqjWggrDLIeEgxlgiwN3Gr4BiX3ROfwvq/nhyYgs0AsLouNTIqy+Fux04bm5R6sWwvjoVCDI6D211qeSYNf4HeEeA/pdww2l5ejf8AvjKhs0oibZDAWzeuVtedqWHGSGsVMRY7FQkQistPdxW5/u3SsSRKIeG6KLLvREfcVgsS8cCe+osRuJyZc3bhyRBJPAPxxT7Kv7KbCSUuRJXARkwV9i73rc2/VKrrp9IiD86tzX8SdNZMJ9NQSJ91XDnho3Yw8QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cWL0BlWQjMJGVfcB71HO6QnX5pE1cEN5fChoFyKgu6U=;
 b=A6XDI4YdeRC6Lbusj99RMmegWnPn9lKry4VDEb6I+0AB/SH8fYQD9B4vGNSzMGnV/oGq7V56sSRHoW6r08IuVkmjVztGF0PnM19pj8QOhaYjK99eYyaUBxFz4cNSdMjgG+i3RaYBuvehANisMVkD70jBxqTaW9fGtU67rwi/exuAbB++E/DIf+5YhT2K56SdLq7YFPHT8fhgIzwGpjtvhqLj7p6NNO7xoFjiU+e9VAO9h09DH/ip4zGCTHnS3LF8uwmFYS4IbQIsXTu5nIHOKF/rMHWDs2o3d3M8m//Z9NSBC/dzAi2rvy9s/XPRnHKG3Byem+GxHFnscQN28sD8xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cWL0BlWQjMJGVfcB71HO6QnX5pE1cEN5fChoFyKgu6U=;
 b=Yho0BvOgiebsySid4zW8m6hPkr8SEQeQScAFbSlyRcIlkEiP0Ju3iTHDCtlzQ9x+7dl5fKzO2SPBgz74tPhuvh8jSLkVGf+mM0blZ+SaAZkv+YH2cb6qNJWwm+CY5gh8nJFiq9li6CkZSYYnr5a+D+J4k7eoerz3eqpTVm2y3GBliau+uiV/FlRJizV85b37CItnwBYMIjje3HCBRpYNxwPXUbqSFYzIKwi3JHNBZsdLQN0kkSkhegb3JjU4P5pnckDrdmpXc+ijOmIUFha7Yfq3PLLq5auEvPJMjdKQ40b68GrRsz1h7xeKFtuJ/9eHpBdySiedxZio5faZwfjK4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by AM8PR10MB4001.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1e1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 10:10:06 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%6]) with mapi id 15.21.0339.008; Thu, 27 Aug 2026
 10:10:06 +0000
Message-ID: <fa535578-1386-4e29-b30b-68f175cd7062@siemens.com>
Date: Thu, 27 Aug 2026 12:10:05 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/3] rv: add per-edge dwell-time statistics primitive
To: Gabriele Monaco <gmonaco@redhat.com>, Steven Rostedt <rostedt@goodmis.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Philippe Gerum <rpm@xenomai.org>,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260827072400.45734-1-tobias.schaffner@siemens.com>
 <20260827072400.45734-2-tobias.schaffner@siemens.com>
 <ba9a55fa6aeae4ef17873afc7373302a3fadc82d.camel@redhat.com>
From: Tobias Schaffner <tobias.schaffner@siemens.com>
Content-Language: en-US
In-Reply-To: <ba9a55fa6aeae4ef17873afc7373302a3fadc82d.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0122.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::12) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|AM8PR10MB4001:EE_
X-MS-Office365-Filtering-Correlation-Id: 978d1d12-be92-48f1-23a1-08df04235e78
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|7416014|23010399003|376014|10067099003|4143699003|11063799006|56012099006|55112099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	snbOCcxvj1lAblH5NVFskTx4YTnCaV1ItysfrKgtOEH4gAFSKr+LBcNyQOoHZ0D41xpCrZTB+MJheaJ3DVCzlbBGo9P1OnfoyVd0rPEjqwNdQVqtoIh7+hRngtFcaaEXnGsftDbt6jT4ZavrEWFV4qOJsIl6Kq25ngyoJUoeadM2JscaSreOHIgYAO02rd+Mn+rq8Ideh2GhyJtIfmk72c2Mg8k+jLyk3k04ZfUw3IdccsI4oouZEUdAeP18v2JqaM3DE/SKppEFAfyI9Oo7P2eQd+xJUAZ+JM2NWfr3BqLZvmcA1oJTzwMBDr/boG3TDx8yYh4t6maiM9ZDkGrzwL7lkp5jhUB0aSJTuAXiZr0nwP2dCmdOC1+/+pbo0EEn/7tqH2URJknmFDqHerGa666AjK4oC0rcuEVeV4Pra8WO1gp/8/uIpJbAZQk976h2cKEFW+Sb5TcMh2yc81qoenGMCs1JIKXDliDIwsHCIECueGIW6E8DWxPNeEKfxDO8nA0YTFWncZjtHFYUjh5kGIoZYzlTv+jjEuBnPy5AKZ4VOkb2NdJdAGkppI7Bj2CwcFRTzOw/7t7EGSk/Y3V9zFL6GxID9lPT6jc3UFI7tSvdo4pm6FOrjmpSLjztMBuwuzHF827kiOj1hdDmUuLERp71Qul/QsgL7J98nje8Ols=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(7416014)(23010399003)(376014)(10067099003)(4143699003)(11063799006)(56012099006)(55112099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N3J1aWtYQVd4VS93RkhrdnppdEdOYnBuWEk3UDI2ZkNuUjhGbGY5ZzFGK1hR?=
 =?utf-8?B?cm9HWUJZZklTZFpSR3ZJdG5JemJadXRDdGJGK3c3T01qbjNXRFFQS05GRHBP?=
 =?utf-8?B?ZjRIbURDZjRkdFVTNlpiYmhMc0hJQ2hGTmFXeUxZditoc2NYN2pneUR0cG4v?=
 =?utf-8?B?bFVjTWN4dk1uSUt6aTVHVHoyQUtiNzNzQUxiNkZwcHhsUENDSk1Bd2cyNGxj?=
 =?utf-8?B?WVBnZmR6OS9JVGhKd2dNV28yNWgrSitMS0k2eG9OOFJFb3E5Uy9YUHNpamcx?=
 =?utf-8?B?b3ZNdkJaZHJuT3pKaVNxRWx1djlPU1o4SitVSWZhcFRzaVJOOERVL3FDTXdT?=
 =?utf-8?B?NnBudVF1UnZUKzY3Tmp1OXVESHNsdXBoOGxUcjhBZXd0eE5FS3hKN2tjdkhB?=
 =?utf-8?B?VG81cUt5UkVDOTJPM2R3enF2OEo5Wmk1ZExBR0RWZnZUckc3RkdiT1NFNEdq?=
 =?utf-8?B?U0hIZHo2cEwvd096amRYOHFzcXFuNXRIK3JOWGt2MEV5VitudzBrOGdwT2Ju?=
 =?utf-8?B?VExUaHdkb1NOVUp5KzlsR0VzS3NnRHo2blQ0SnJnWWtPMXJWMC9PanJIZ0Na?=
 =?utf-8?B?WWVPa0I4Q2ZzVVhuWHg5SnJxWDh4TGpITXF0KzA3VzNsaWNsMFNrL2lkdHJh?=
 =?utf-8?B?NnVVelI2VEtWWTZLNjFRQ1BuMlpnOEtqaEJDU21yY0Q3U3AwOE9DOGtPR21s?=
 =?utf-8?B?R24rSTBQNUJEd09ETVBYN2pvSkRJRjhJTzh3eXlwY1lvRVk0MDBuL3VhMFh5?=
 =?utf-8?B?Mjcza1V3ai9uWEc5YzdTZERSVWRzRTFtclErWDB4bGdac0VxTmhGbkZZMlNW?=
 =?utf-8?B?VlZ2Ylh2RXpLSTF5cTNGWkI4bEJsTEhSaTFSN09EaUF1a3M0MDNsZ1Erc0hj?=
 =?utf-8?B?bUpzUFdxRXpzcy9wa01ITDF3VDE0Zjl4OVdkOUxyVnNEWWx4TDRtanpWRUc2?=
 =?utf-8?B?cFVsRzNUc3dGaDZnbVFMRDJDSDdJdEFlWVcxbVhUNG1qbDlETXdmY2wwNlhY?=
 =?utf-8?B?TTQ5R0JqbFRvSW41akNnc25aUEZORzNoM21FVW84RTFEVklLZlg2cGdOZVdF?=
 =?utf-8?B?ZGs0eGdQMUVBblJ2UE8wOTdJSkwweHdYUFdWSEtJNlVzdENaczJ6RHFESFFV?=
 =?utf-8?B?bkl0UjBGRnl3ZlFXM0R0WnQyQzY5Q21xUTVBeXdnZW0wTGhaaStMK2NwcFdZ?=
 =?utf-8?B?eWRUcjlta21yNUtZUXZVY1pnL3poUnJtMEx3Uzk4ZHNBZHdiVFhCTEE2Q0FN?=
 =?utf-8?B?eDgvTjhHYW9HaVl0aEtZQVY2cXhsRy9qa3IwZ2IvbEVSaHJWQkdOWFdheGJv?=
 =?utf-8?B?Y25mcUd2NFY0Q3NTU1B1RE5GOTVSUWlqeU5GWEhuMWhCaHZQelpSR0RKV3lR?=
 =?utf-8?B?T3pyVTlqTGZTR2wxTnh2aFgwVEVXVjR6YXpzOWo2cUJBK3F3K09HNnNISHdr?=
 =?utf-8?B?SmRFL3VyNXNCdE1YVXZmMXJCUVdGZGp1cGpyVjA5aStIYjk3V21hVkZ5ZlIr?=
 =?utf-8?B?ZWg3ejhEcFhZd0x5YzJCU0w5c3MwbE14OHRpdFJib0pjUU1jRDNMV2dGUEhL?=
 =?utf-8?B?TVJiamFtbGRldmk5R3NvZm9mbnZGc0Ruc1lWVUw3eEdBVHltWDRoVitCWFJs?=
 =?utf-8?B?RFJmcDVkOXlDSFpnakxLYUlSbUxwR2dBQ1dMR09BZENQOU4xTzcxbkFzenhr?=
 =?utf-8?B?d1lNWmFXOStsZFJ4TU8zVzNmZVB0NmRWRDdNekRkU3ZLSzNWeElYdmNjZXhU?=
 =?utf-8?B?ZGtPYnJFYWdzZ0VvZmExNW5DM1VpZyt5NzB0SU9UTGdONktYbk9HTloybUQv?=
 =?utf-8?B?R2g0bHZNN3cyK2Q5Sk9zTUJodGthVGJDNWNYMU1qM2NXUWV6SDZLcS8xSmlN?=
 =?utf-8?B?RWtJbHFCR25Lcmc2SWw1dlBHUnhiMW1HWW91d0NIUGt6OW8ydmUvbVpXSVIv?=
 =?utf-8?B?SzR4WWVpdHBQYndvSk1QQ2RZUmJ5OW9hMWZDblFoQlRYcXlsSjZvZE5PcVpo?=
 =?utf-8?B?dnI0M3ZsQ21Ea3NwU0hJYUlRK0RLTXBvWlpUWjVtM1dlUnVieERjTm9US0F1?=
 =?utf-8?B?TFduQW03ZkF2Z2I4NWVlYVhtRU9OY2dZeWx2UFFMSG1INkpuZ0FsbGNQdStt?=
 =?utf-8?B?RUs2VVJEMU9nemIzVXZlZTJMVUJwellqUDhNdWdjTVRYQmMxUW1vSWNSMThr?=
 =?utf-8?B?NUNXU293R0ZqQzEyekZSVVNkakg5dDlQcSs4VWhkcFM0Q2piNVl0SVZWM2Yr?=
 =?utf-8?B?R1pYcDVJK0psMVFpNWovbTNEZW1ITTQ0SHdRNm5yQ05xcjZiTTdSNjFPNHE2?=
 =?utf-8?B?Y0YrcmhIL20rTWduTjhzTjkvZTNLblpnZnZBQlZVRUdIUkFBSmZNTEg2RDdV?=
 =?utf-8?Q?NUF464lvRo8KE3wnz1T0at5ZHjoFV7hzb8e2E9gctEHOR?=
X-MS-Exchange-AntiSpam-MessageData-1: j4h1SnA4sZt5LyweYb79qDrlZnS2iizqeu0=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 978d1d12-be92-48f1-23a1-08df04235e78
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 10:10:06.8020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 06zY4A93FSQfxoBMDCNUDamGGsEu9Try31Opjzus61af9vcIL2XFknwaffaUDnR7mZzvMkmLhitDGO00T26wI02L2ShkPkbMDqhZx+1Y1Bw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR10MB4001

On 8/27/26 10:22, Gabriele Monaco wrote:
> On Thu, 2026-08-27 at 09:23 +0200, Tobias Schaffner wrote:
>> Add a small primitive that records, per automaton edge, how long the
>> monitor dwelled before taking it with a count, a sum and a maximum.
>>
>> The counters are per-CPU and lock-free, so a monitor's hot path can update
>> them without disabling interrupts and without perturbing the very latency
>> being measured.
>>
>> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
>> ---
>>   MAINTAINERS                  |  1 +
>>   include/linux/rv_edge_stat.h | 45 ++++++++++++++++++++++++++++++++++++
>>   2 files changed, 46 insertions(+)
>>   create mode 100644 include/linux/rv_edge_stat.h
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 8014b9f8253e..04589dda0873 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -23654,6 +23654,7 @@ L:	linux-trace-kernel@vger.kernel.org
>>   S:	Maintained
>>   F:	Documentation/trace/rv/
>>   F:	include/linux/rv.h
>> +F:	include/linux/rv_edge_stat.h
>>   F:	include/rv/
> 
> Any reason why you don't use include/rv/edge_stat.h ?

No good reason. You're right. Happy to move it in a V2.

Best,
Tobias

> You wouldn't need to touch the maintainers file and could just
> 
>    #include <rv/edge_stat.h>
> 
> Thanks,
> Gabriele
> 

