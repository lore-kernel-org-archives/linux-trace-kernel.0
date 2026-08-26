Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021126.outbound.protection.outlook.com [52.101.95.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6D13F1AD7;
	Wed, 26 Aug 2026 11:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787742833; cv=fail; b=GdKrMGRkxBqpv82Tt2s82kZvZ5lUn5Hzek/Gc7ERd0Vt+/wTZag0+fellPC34lJ3roo4yFxyHqv/JRtzzuy9IYXIho3KrCY3cLQvEzHeShUKGwLhkr2om/kXIvhzyUz3OMAPYBaJUOcNXtIHVgEuHuaxxJKadjICHAxHoT5l6ec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787742833; c=relaxed/simple;
	bh=OCL7ZGOaOTqRCJuOSR5+VKsFuAEEIsjEwxjFbWF6WAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Vcpmav79P43UBPJIKRKUuIH+pWTkMcdxXX6ssAIlvwHCCcOvwCI9J6+U/8DgRA6uPZaG//Sw060RHsAuHgmefhSd/KjUaKLaC1xU79lChRuADX+XVhB5dODYELUAYdbOrDvJTLZWrMmx2a7KXlnDNxWLmSsVu59g7xryLe0K4Vk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.95.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J5rGpPRYmJlHWgotasel0bqIg8T1+SlWGfRyDJrds0Qe7cz6BbN8vRmZGqLjUYzcOXuVJCfDM+SVoLplurARnHPf9u6tFqTj7w5Rrm7d9QHEbeJ+t6nGVK9fa4Lh6cGxiufLJauvWkM9wlBFRSmfHS0j78tGM6oX2o6/n74JXKAqBv55mE8Xqt+sGk8evi0b/mW1egeu6Ph6E3n26gZKFC0Uu/bm86y9aH3z4p+VNaZmkG2lpiBqtMCHKn2MxYO+bmikuytUnBhcjQMQGvB50iMr1UpXx7qxoDmvgpmyyTQrQS8gCPx5ml/2xOG3o8vLGg7kfN0wbXDTgJ4Gwua3zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=lgCyyzTewM08z+JKVgY6mDDF2hnul4KNHzZ61gOalDo=;
 b=wc6MyLeiEYjfp1cKoqcC869+ZetxU3t25H3vbI98tZdQuYKxN2rS4f/1AgQhnJUMQ9J3zSVwWFdIFRMDuvRcbWtoKN39ioAMXf2IBV8GnQEk3f8v0I/iycvFJyFJ+VxjLxidTdccs4Fdw+/I+TroFzlfzXsjf8rk+GJIGVQ2evvn0p3b1pmIYdrSYhyPafaKfaVvoqpCafoh044ztw/v/XwbVixU6RON0+YOGAVIDRMCmTTaPWDX0gH3Z2dCy/z/OL5u/z5HWBo9XQobFJv5AeMrI7z6dw4O3pjLQZ6oApG72gtgk3veC7zw41l2wFSTQbjNMmTAEecR6pEPi5/9fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO0P123MB7937.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:42b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.9; Wed, 26 Aug
 2026 11:13:38 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0360.008; Wed, 26 Aug 2026
 11:13:38 +0000
Date: Wed, 26 Aug 2026 07:13:36 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-usb@vger.kernel.org, driver-core@lists.linux.dev, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] module: pull out add_taint_module() to be public
Message-ID: <lnbvi6d72t7zdc3w7yc34y4hyf6gnuduqpqk4q3vqzypw23j37@5zh62c4wyr6i>
References: <20260826-bind_taint-v1-0-52b05f4a965c@linuxfoundation.org>
 <20260826-bind_taint-v1-1-52b05f4a965c@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260826-bind_taint-v1-1-52b05f4a965c@linuxfoundation.org>
X-ClientProxiedBy: LO4P123CA0042.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:152::11) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO0P123MB7937:EE_
X-MS-Office365-Filtering-Correlation-Id: ebfb1d7e-c570-4eac-8f22-08df036313fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|7416014|376014|56012099006|10067099003|18002099003|22082099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	eqQQDHEWeVpm5cfe9VLNV2w+KPPbkdb5bnIe0d9snnr3zuv0oHg8jexdNq7XX98XTEsRxTU719+AD+VSZqVmmZsOFKMkLj+PHwaNwHugOOToNHgTZjnY7OEbYIBtDCVPjZB2Cf0Ueu/Ga5AgbrJ7xDn8rGADoqBbSvl2duLBAGVqVi6zwyzWemz+MV0Fkn6ATspLYxyClbIUKLQ/e6bi/Mwu4vwNiutz4OdWSBVNpBX9Cef5ymeRSClJfZhbkPvWcLTQ0QUoRVG3r4o1CxAQbYxKsNqqqjb3+SPPcPEz1N3EXFbObNB4cWbqmg9Am299/Kauw2qk0Gj0jwgtupZJ75MMkHkCi0Pqo9fD/2icKH4z8ImyVgkJulJv2If8EOwx/SMVM75pOiZNnLVgh0SlO2tJFoiWnnuGQdHd0sMVlIplE9NoW3Q4sC7aJZvEEUZIFQ/WlHZgubfsnqZ6Vn3KfWNxEZ0nshqgx99x6jbO/QUdq+FRp+ZzvhE+GIwONRzrbLfl/HEPnLxOYbKYE4yj0kCCW91fCvnaYuuiAsHwi4LLOQbnr7V289ShbYBhm7GX+aStxotmbHEZKXEAPoOdocszGqjA9v2qOw9K9CG6YxQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(7416014)(376014)(56012099006)(10067099003)(18002099003)(22082099003)(4143699003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aGhlbGFnZmdob0dnSk5GWkE4dHhXcjF5NHE2K2NHcThIVVg4M3BGMkQwSlQr?=
 =?utf-8?B?UTUzaDZJTlNDVmE0NlpFUkxsZllqQmVkMDNBYitCbmE0eEhNblNmRnpGdTdM?=
 =?utf-8?B?SVFaRSsrdElOT2RyWHpuVy91L3RmZjJlb2R6cDAvM1Y3Y3QxRDUwcWhoRmlx?=
 =?utf-8?B?MWxkdDVCVE9rNk9WS0VsTDRMdTVTMUdadkVLNHlWTWY0Uit4NW5ZR2YxYVFC?=
 =?utf-8?B?c1ZLVWFySkZjc2dUNzRzZlcyOS91Y2VmL2Z3MU5zcU9pRmlqT0JRSmpSSVlV?=
 =?utf-8?B?QTNCbUNsQjd1d2pPYVVpUkdQZEszMDdlMFMycklFZVlkZHpadWM0VGtUOTFu?=
 =?utf-8?B?eHI2bnp6Q0RlUTcwVFFMZEZGMzI1L2k0eHdQbkxIdWpCTlcwMkNpbHozelRR?=
 =?utf-8?B?Qk5JcjN6M0ZwbU5INER0d3ZlTmxsMUZjVnE5RnU4YXFZNjFJeHdsYk51Zm1n?=
 =?utf-8?B?NlVRUllhSTN0MVVSamNRWVdTRXltRHkxNjljMW4vZmoxSWxmd3ZiYWRiK0pm?=
 =?utf-8?B?VFRWUVA1RTVnM0MyWXAvS0RMay9wWkNQNElRM0dYc3NwL1RoREJyWWRWbFlz?=
 =?utf-8?B?Q0diS0xNWkN3cHFycGxvQWxYZHpkMklXZmhZeXRyS053QnJiQncxeERlL1VI?=
 =?utf-8?B?b0FkMjdoNlJSWGNoSnFzWXJWQ1l3NkYxeVJXRTI0K3REeDdVZS9IZXlNbFJU?=
 =?utf-8?B?QXZFZXpvR1IxWTdvV1cwcG5GYW5ubjZmc2lFL2N1NDRoU0g1OG5MeGhkRVNr?=
 =?utf-8?B?WVF0cGtyZis5eXBLZ1g0cE1SV2xZTDVnWGMzN2hrK0d1cWVObnZrVGlXYkFM?=
 =?utf-8?B?cU53ZzYxczJEMDdQTVQyYkUvV3BrbTZFcTlQUWY3U1pzdk5PYWdINjRnQlhs?=
 =?utf-8?B?THRpc2ZhV1hTR3F4eDNURVI2clc3Q3ZiT3lWL29CdjFyb05BN0x4S1J6dnE1?=
 =?utf-8?B?ZFhQOHY1ZW5JLzBzRjJweUxJTXkzR25aMEhqbXBZbURwL2FROWlOUzY3YXhX?=
 =?utf-8?B?OVJGaUlzWm5QR1AxVTRyVXpYUnN2dTJ4RzBYNFFkcXdFd291YWh2NDJPMm9B?=
 =?utf-8?B?Wi81RGdacjg4RHpPeEhISXBTSHNkdzlHZXloQU9pZlB5Y21IcXpsTTF2YlF0?=
 =?utf-8?B?Z2daemlVYnVyZzJVM1p0RDllRDJRMjY1MzRrNWVkQ0pIZ1NSTlJyK04vNjdG?=
 =?utf-8?B?OGsyL2pYZHMyang1QnJyQXJKZEVPL0ZoQnBicEpMRkZhOUc1VUUyb3I2eXdR?=
 =?utf-8?B?N2VrZTEzb0NrMm9yN3loSmhRWjJtb2ozM3hHTUNiMlR3ZUU3UFpIN09YTHVD?=
 =?utf-8?B?WnVGSUNXakpYZUdLQXZaNzQwYTJ0Z3dxdHJocXFIazBXM1BrZXNwVm93Q0FD?=
 =?utf-8?B?M3kzL1NHaUdHOWQ1NHZxUmJ0RXlUaVhidGc4MS84bW1UWUUvZ0daMEJDM0tE?=
 =?utf-8?B?TzAxVlBHdzVma0ZVME1mYU1hWVFIWldzQkU3ZEtRUEpEQXBpSmdMQktLcGlK?=
 =?utf-8?B?WVFScVlrUE9BUmttSGFENEFlRXpzWkhnMllFTk9OZm9FOXFrdzJNUFpJaTZh?=
 =?utf-8?B?ejVZY21TWVdIazVWYnp2RzY1bzdVZGhUaGJMS05FZldCdlZMalB2Y2FFOGVH?=
 =?utf-8?B?c0ZSMWlVdTBVQ2l5cGovNE5kLzZXWm5QNmRFeHE5UHFiZUQ0NjJZTDl6cEVT?=
 =?utf-8?B?WUJZWHc2TytleTh0djFNT1pTYzF2L09XY2FwZHZnZlBpN3crVm9zZTMxQnZQ?=
 =?utf-8?B?R0twQkwvaVRPOGRBV2tSbE45RzdlWS91eXg5UE1WNm82RGQwaFlWanBLTnR1?=
 =?utf-8?B?djFlZzV6MFJ6VXY5QWdZcFZqbnlPY2xST0prV05QSzJyc3VxZVhnd3lMcFQw?=
 =?utf-8?B?NXlmV011UVpYeGkzSEVac1BkZ1RqYXpKNlYzeWhocUxNeXNWZEsyT1h3K2N0?=
 =?utf-8?B?UVRBOUF2Q250dUhNWnozSW8zVEllRTdVZ0N5c0tVRENwamZlNVFmNkxqc3lL?=
 =?utf-8?B?ZGJvazg5bm45dGZQSnI4ODVCZTMvNzZNSjZQNldYbFBEb3IrMVhmMlN4bFRw?=
 =?utf-8?B?QS8rQ3k4WmhYT25SMXFZdVVKSUQ0dzlHZmV4anozeXNBNnF6cUNEQVBnSDNE?=
 =?utf-8?B?eEZXeTlGb2d1M0FXdUtwdzlBUVEyczF2S2VKUTN2eWtqZitlczU5QWg0VUZz?=
 =?utf-8?B?TityOCtWc1pncXgvWG4rcDZPS0JGUzBWcXQ1eHBQL0ovbCtBQ0FJaHFlWGJB?=
 =?utf-8?B?ejJ6OHJyOHBDSDAwMkVheUREcG1HaVB4dGZqTUlUdUNyN3hqa1A2blRBQ2ZF?=
 =?utf-8?B?YkR0bE5LNDlrdSs1QnhvYlRkcFIrS0pIcjh3eDJUMndUa1JyS2xxZz09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebfb1d7e-c570-4eac-8f22-08df036313fc
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 11:13:38.3404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wcNVcBHNHLQwojLICsKar2XE2BHygl2Zl99nLQ8iyObDXxHcSMLEPg49G2kKViwz62KfJoU0HEkzEUgT1QW6ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P123MB7937

On Wed, Aug 26, 2026 at 11:19:32AM +0200, Greg Kroah-Hartman wrote:
> Other kernel code might want to call add_taint_module() so pull it out
> and make it global.  If modules are not enabled, this defaults to a call
> to add_taint(), so all is fine.
> 
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  include/linux/module.h |  8 ++++++++
>  kernel/module/main.c   | 13 +++++++++++--
>  2 files changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/module.h b/include/linux/module.h
> index 96cc98568eea..25221539e645 100644
> --- a/include/linux/module.h
> +++ b/include/linux/module.h
> @@ -29,6 +29,7 @@
>  #include <linux/srcu.h>
>  #include <linux/static_call_types.h>
>  #include <linux/dynamic_debug.h>
> +#include <linux/panic.h>
>  
>  #include <linux/percpu.h>
>  #include <asm/module.h>
> @@ -770,6 +771,8 @@ static inline bool is_livepatch_module(struct module *mod)
>  
>  void module_for_each_mod(int(*func)(struct module *mod, void *data), void *data);
>  
> +void add_taint_module(struct module *mod, unsigned flag, enum lockdep_ok);
> +
>  #else /* !CONFIG_MODULES... */
>  
>  static inline struct module *__module_address(unsigned long addr)
> @@ -877,6 +880,11 @@ static inline bool module_is_coming(struct module *mod)
>  static inline void module_for_each_mod(int(*func)(struct module *mod, void *data), void *data)
>  {
>  }
> +
> +static inline void add_taint_module(struct module *mod, unsigned flag, enum lockdep_ok)
> +{
> +	add_taint(flag, lockdep_ok);
> +}
>  #endif /* CONFIG_MODULES */
>  
>  #ifdef CONFIG_SYSFS
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index d0e1e0bd2ad0..99cedb961898 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -191,8 +191,17 @@ static inline int strong_try_module_get(struct module *mod)
>  		return -ENOENT;
>  }
>  
> -static inline void add_taint_module(struct module *mod, unsigned flag,
> -				    enum lockdep_ok lockdep_ok)
> +/**
> + * add_taint_module: add a taint flag if not already set for a specific module
> + * @mod: pointer to the module that caused the problem
> + * @flag: one of the TAINT_* constants.
> + * @lockdep_ok: whether lock debugging is still OK.
> + *
> + * If something bad has gone wrong, you'll want @lockdebug_ok = false, but for
> + * some noteworthy-but-not-corrupting cases, it can be set to true.
> + */
> +void add_taint_module(struct module *mod, unsigned flag,
> +		      enum lockdep_ok lockdep_ok)
>  {
>  	add_taint(flag, lockdep_ok);
>  	set_bit(flag, &mod->taints);
> 
> -- 
> 2.55.0
> 

Hi Greg,

I believe Sashiko [1] found a few valid concerns.

[1]: https://sashiko.dev/#/message/20260826102921.5B81B1F000E9%40smtp.kernel.org

Kind regards,
-- 
Aaron Tomlin
