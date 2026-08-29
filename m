Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022092.outbound.protection.outlook.com [52.101.101.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90232146A66;
	Sat, 29 Aug 2026 08:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787991692; cv=fail; b=ug3HUgZviYuBw2k6KrY2obrJbfQjq5UeuWhoC6q61bLHjJ5FvvGdu6rpLUUAcDZ8OHx6WeQkQ5b2WDclg7ywAVBqtFBNg9ORP3of5/77fgUZ9Ahfwz+elKHpLoW70eArbWrpnRbxr+/4wYPROlkE5BRxIptTUVYv3Ao563XdhiI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787991692; c=relaxed/simple;
	bh=dbmAKv9lyweaR7opsDMpJihFCJcDCOHCWYOm99AXBoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iRteH9hr/fmp+o08H7JpmDf/ueZzzRr7EygUFSo/L1BDjqr+hUo5mP5rQR93d6WXHnvQDZxktSEyYjuObN4I4vTkSEMVB/nZS8eXsXm2DbAeqURk2Z4lXbLsvMt776yuBkVpI05PxPFxxGOGtoYNqdCUgZqhUxss2ht+veCGBXw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.101.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ecsyOAOUOWTe2IBfxUbqPqm5x3Vu/M6GWbdvEeQhPbusOkd2h3s+mC46S8kWqdt9mtYEpGJa17W15/VajUiNf8jhuK50Phsw+TvMmuCXnyQ+BB3yFNc5v19m1yI8ur2HG4lgDAHqcbHv82/NXw90Qw+DEruCdn0e38BGJLbCOKyG1X7zijncgeAY8vv/JMw9rUat4vJdNj2hIxtvON+u6X4kM8nKZksCOOzwkdOzBMBj+knxSdEylU6fy8xvwh98etFowdGbZ7QRBRFjGpNlXkwjflXsWR3Nxr0Jn+FAz6ipUdaAYlN9yW7mCeqEmb8+JBZ2R2TlTRbanUH6H4vBrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=P0Lwq58hTwKyLpKodvv8rlYvu8HyQ4FNgagCGRG5/7g=;
 b=evWPmlLWp8UfmjbSZtCisyJZAWbl0UKFhF3OR6ynbKIAxQ+o1hA5dIdNWLPScQrcRzEC4uSBh7O1Cx11e1XEBt3xCrHJpeGiCfeSSTwbmhc8X8xKD0wuUXsZuu0Q+I2RuSybpsWIhDjxSxBYxf06UPreXwo7N8GzjV36eK/K3DjtLshG+rLw0XeTPhUfzGnkaGC0c59TkwgJV47qsw5ltfGqLouAkk6Q2lQpUABSBHnIIeQhPIIyaUqlprl9fA4y1ysOynvFShJZx80fTuBfLsJgwMLT9znXmDodt0AE3VKPwAHPRAQAAybxEpaRDWkv5hUKWgms508DELuH07ghLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO2P123MB7179.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:328::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.12; Sat, 29 Aug
 2026 08:21:25 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0360.008; Sat, 29 Aug 2026
 08:21:24 +0000
Date: Sat, 29 Aug 2026 04:21:22 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Farhad Alemi <farhad.alemi@berkeley.edu>
Subject: Re: [PATCH] tracing: Have show_event_filters/triggers files take
 trace array ref
Message-ID: <zhxmr4los4tkpyb4qscbeh3qg6urnvslx7onvzxrnbuhlyfvuf@a4dpkru2jdzl>
References: <20260828094153.17b95037@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260828094153.17b95037@gandalf.local.home>
X-ClientProxiedBy: LO4P265CA0204.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:318::14) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO2P123MB7179:EE_
X-MS-Office365-Filtering-Correlation-Id: 18d8097c-6a37-4693-e922-08df05a68377
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|6133799003|10067099003|5023799004|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	wzx1OV+Yu/QPjJnkvFrfdElNLvNGz8yuRtZgyYYb4/8fQIMqWKEv+at2uAQIJqBtU++OY/Agtkd+LVK1jh3qAdIP3qqZl5GdkPwpVl37JE3jaKcVdg9cuATl5fqeAyhmhzwaADYMgzgYiwytaVu7jVnkegJM8wY7jqRV4XwPb1iKqxm2FkXbM4dW+P39AVV3gl4Ikw/XbZBc3skTaS2NunK9E+9vm722GIQvwOmbsqfXXWmmegVspCRRqPkMKROmhTuwPMy8+TlWkMEX+pz0XI56FBcLAx96sZubV9tJ0FLaAMz2hbP8ydMfOOAXXiTJNt6h9kmjAJDkcS+dwo+mwkcbPRISmkHDfH+gM2vyTKrCjKCQBJ6yYaAcJof6R197SQAF/7aDeIXOC3zvKjIDxwYeUTfkdjXIqMWbUckgarexJw2/WqptgI96glAkY7/1ALp3B41ygfZT3uCKu9trZ/RCPkbRJ3mEF5eTqlDJtPPC67ohWcIS3Ykbroc1qOfJZSn+gKXjjNK+/Yb90XJQqSoUTfwP4ycPBZeAzUiUtZxx+MTe2JWUl8zHgnbZfkl/kNRF8ekSOlYdFS85Fv2HdlTaJhajnFMKtZ2VTMg0+Cky14SfBduIbv0wKdJuTmCC
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(6133799003)(10067099003)(5023799004)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cjN1TGZIWVlTV0t4bGRDd0JkZDNDQ2t0NzllQngwbGdiOTV3SUsycWxhc3lq?=
 =?utf-8?B?bllOU1ZPTVZnS1d2TStOcHJTYWRWSnBFbkVLQW5nUGk3NEdRVFRaUVJDcGxV?=
 =?utf-8?B?NXlSdjE4N2NZdk0rSmU1MXZ2YU5YblhHV2pCNkxmMVFpckVqS0xMTzFNSmZz?=
 =?utf-8?B?NitUSnFmOGNiZWxRY2pDZzdhMk9tYnBXZUJ6ckR3QmhWSVkyQUNWaEhWZ3Na?=
 =?utf-8?B?MVc2VzJ0UXgydzFOclpzU2x1QmZ5UTVqZTFLKzF3YlJQcVhWUEtrSFpUMjlr?=
 =?utf-8?B?bG1KQ0RpM001bDd4eTV5ck41SE9JcmVjckg3cWdVN1hTa2Z1TWVkQUcrRmJW?=
 =?utf-8?B?cUVDbytVUkk5eTliQW5tSEJLOEFaUFhnREpLYXd0OVF1c0VwcEZ3eEZGLzlv?=
 =?utf-8?B?SjhnRjdMdkN0SWhhTU5BMnFFRGhITkVYU3VMQ3J4WWYzeS9hZm9DUjVITWFv?=
 =?utf-8?B?eHFTYjdVVUR4ZUFwVnNlNDVFTmVHU2ZDQTBUc1ZMN25yMTJnd3MwRE85NHhy?=
 =?utf-8?B?NzJlVkozQkRyS2w3UTJxS09wNGZLNytsMTF5WHRsUlNyTVA5amJyVXJrWFdm?=
 =?utf-8?B?VncxKzFoU2JGNmdGbkJPT2VmT2s0MS9kQnY5NHgwZnAxWnJUUmxXTUwzL0lO?=
 =?utf-8?B?dTk2dFlCemEyY0YvUmU1S3h5Qm51d0lUYVZqSFB6eUI4TDIrQlVnVmhFS005?=
 =?utf-8?B?Z0pma2Fnb2tuSVZvT0JodUNlN0NtclRabWpmbmxqL05FeEFtT3Q0eDhkNUVI?=
 =?utf-8?B?Umd1Rm9LNDNXZzg4Yk1yRXNZVi9SQkUrTS8xNUNKZGNOUHlNZHQ3UVZCWXlz?=
 =?utf-8?B?T2RjbGRNVmkvb1Z2QXVtd0p0ek9hVHprSGRsVDRHa01DSXJuM2xONkJaUUY4?=
 =?utf-8?B?bFU4ZXczVUlPYkl3a2diOEh4VW5yMENVVGo3TjNSbklVd3FqUTlFM25PN0o0?=
 =?utf-8?B?UUJ0N25NRHc0dVFzRllic3VmL2pWSmY3V3d3a1dJcW9OQkVObUhSZUVoaHhh?=
 =?utf-8?B?aWFXSE8wU1pTUjBpZTgwNFQzSVhMSnBwRnRFOTgyNmJFOTNDWS9sV0xnRm9V?=
 =?utf-8?B?cmsvOHNGSE01YkpORGlUeDY0VWFtSzh2ai8yYjBBV0YwcXFvc29xOUxpSVhp?=
 =?utf-8?B?Ui9hc3Yyd2JmM0R5bTJ2R2tFc3ZncG5CQkZ0eXZ3ZnRTQ1FORDB2b0FUTDUy?=
 =?utf-8?B?K01FdjBFNW5wNkZSN25aaEdVTE0rL2d1RnRocjgwd1pLdWl1U1hnVlkrdjlN?=
 =?utf-8?B?aFhkNnE4VGd3VFd5eGlzWmlyZ2tqaGYzV2E1cFNPcE1aUUg2cjJwRWZkZ3NM?=
 =?utf-8?B?V2xHZmZDQlRrMndaUHVuQkkvTmpkZ3A3eFMxUVNTbHdabEFORi93WVZ2TmJS?=
 =?utf-8?B?QUxKRHh3cEhDRE5UbkpuZU9DUzBtNlVkcExXMllGQ25uTS9mMHl6Z3FURVdG?=
 =?utf-8?B?dXRNdExBcjZzOGVwc1VzNzZUVTg1dVE2Vnpxa1o3L1F3TnNJU2tqTFBmMldZ?=
 =?utf-8?B?RUFpMHFYWHZONi92VklFTzN5LzZUZGtadktRQmRIdkhoZ3hHNTNmdERSa0JQ?=
 =?utf-8?B?dXVPRW1kSENQbzZBOUNtVWJIQ0QvaTYwd3hPbUNBdHYyR0FyYTBBaDQvQ3RB?=
 =?utf-8?B?bSt5OTJwdzVMTHRybkJYZGw2NURhSnE0MGptQjY0bVB0T05PcHJXaFFhTWNo?=
 =?utf-8?B?WTNlMDZ4R1BmcEhxZVJDbFNaN2VsS1g2bTlxUnFCa0RyTkZSMC93akJGL0Vk?=
 =?utf-8?B?UFpidGEwOGxUMHBXaTJtUzdLRmd6SzFwNHU0YUhtWTBaWmdiNWFYV2pIVytN?=
 =?utf-8?B?UVZUV1JJWmZ6UDBmN3FJeEdzd0FiVWpMLzVpdFRzSm0xVHc4VTRxcXdrMTJi?=
 =?utf-8?B?dCt0cENlMDUxZ3M1RmZ1QkthVGVKTWliSTBHcm5VNkxqWFB4RGtnK3JpUnNN?=
 =?utf-8?B?cklGb2doN0IreTB5eFZqNUNpTmJyQnQ4TFhsdGFudHIySXk1QmdyTmRFZi9o?=
 =?utf-8?B?cURrZXZFR1ZZTXpsYW01OWs2RXlyR0NTR2o4V245U3czV2c5WTBtbnowR1V2?=
 =?utf-8?B?K3V6aGNvbndtVU1lR1JKL2IrM2ZsanZLeFowUkdENzkwN3BnTDJJcHdCWHBq?=
 =?utf-8?B?NVRUdjZ2Z2pvNnQ0TTl3TlJtOER5MjNvWFBFUnhJN0hsUjFLRzBKYTBGVzZI?=
 =?utf-8?B?d0Qyb2JEL1ZpMkRMOXJIc241eTh2T2M1Uk53eXFhcnEvRGFiMlI5c2huekFr?=
 =?utf-8?B?M1Q2QjFLNXRkcnRNTDdtbkxZMnVSNzlmbHlyemtVN2xLS2VIRDh6MjR0c2Ry?=
 =?utf-8?B?SEJSRU1DdndDaFcxNEk3K3J4Z1Zwc1ZDdHJFSTRPQjQ0M3RTdjRRQT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18d8097c-6a37-4693-e922-08df05a68377
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2026 08:21:24.0630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h1Ys9QyLi9F2o7vYN2LybNqu7gVBq1MDs1OSLeImWG5rfG1XNEp/Px57dwZ4cyOjDQoKVXa8tjGPHvj8+tb2sA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P123MB7179

On Fri, Aug 28, 2026 at 02:41:53PM +0100, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> The newly added files show_event_filters and show_event_triggers that show
> all filters or triggers that are set within the trace array do not take a
> reference for the trace array it is showing. Without taking a reference,
> the trace_array may be freed via "rmdir" while a task is reading one of
> theses files. Those files iterate all the events within an instance
> (trace_array) and nothing prevents that instance from being freed while
> its data is being read. This causes a use-after-free crash.
> 
> Have the open of both those files take the trace_array reference via the
> trace_array_get() that prevents the trace_array from being freed while the
> files are opened.
> 
> Cc: stable@vger.kernel.org
> Fixes: 729757b96a662 ("tracing: Add show_event_filters to expose active event filters")
> Fixes: 6a80838814eea ("tracing: Add show_event_triggers to expose active event triggers")
> Reported-by: Farhad Alemi <farhad.alemi@berkeley.edu>
> Closes: https://lore.kernel.org/all/CA+0ovCjerKZJLwXScM9bF2ga2rLi4_XOpUfK41NDbENpeu98jA@mail.gmail.com/
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
> ---
>  kernel/trace/trace_events.c | 28 ++++++++++++++++++++++++----
>  1 file changed, 24 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> index 1d39eaf6a0f7..9dbc2441763b 100644
> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c
> @@ -2736,14 +2736,14 @@ static const struct file_operations ftrace_show_event_filters_fops = {
>  	.open = ftrace_event_show_filters_open,
>  	.read = seq_read,
>  	.llseek = seq_lseek,
> -	.release = seq_release,
> +	.release = ftrace_event_release,
>  };
>  
>  static const struct file_operations ftrace_show_event_triggers_fops = {
>  	.open = ftrace_event_show_triggers_open,
>  	.read = seq_read,
>  	.llseek = seq_lseek,
> -	.release = seq_release,
> +	.release = ftrace_event_release,
>  };
>  
>  static const struct file_operations ftrace_set_event_pid_fops = {
> @@ -2908,7 +2908,17 @@ ftrace_event_set_open(struct inode *inode, struct file *file)
>  static int
>  ftrace_event_show_filters_open(struct inode *inode, struct file *file)
>  {
> -	return ftrace_event_open(inode, file, &show_show_event_filters_seq_ops);
> +	struct trace_array *tr = inode->i_private;
> +	int ret;
> +
> +	ret = tracing_check_open_get_tr(tr);
> +	if (ret)
> +		return ret;
> +
> +	ret = ftrace_event_open(inode, file, &show_show_event_filters_seq_ops);
> +	if (ret < 0)
> +		trace_array_put(tr);
> +	return ret;
>  }
>  
>  /**
> @@ -2922,7 +2932,17 @@ ftrace_event_show_filters_open(struct inode *inode, struct file *file)
>  static int
>  ftrace_event_show_triggers_open(struct inode *inode, struct file *file)
>  {
> -	return ftrace_event_open(inode, file, &show_show_event_triggers_seq_ops);
> +	struct trace_array *tr = inode->i_private;
> +	int ret;
> +
> +	ret = tracing_check_open_get_tr(tr);
> +	if (ret)
> +		return ret;
> +
> +	ret = ftrace_event_open(inode, file, &show_show_event_triggers_seq_ops);
> +	if (ret < 0)
> +		trace_array_put(tr);
> +	return ret;
>  }
>  
>  static int
> -- 
> 2.53.0
> 

Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>

-- 
Aaron Tomlin
