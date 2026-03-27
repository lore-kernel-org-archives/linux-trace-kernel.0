Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021093.outbound.protection.outlook.com [52.101.95.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C91E349AE1;
	Fri, 27 Mar 2026 13:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774619594; cv=fail; b=ZExHfKRCZtHb2mHFVNbVnlmCoUztYTVlbPmIfVH17Qr8t1UwzNG3zpwG8hgQxkRE/Leo3DwzyooLtFXl8THDHvDJGzhtU3V1OYNZ64P4GJWTHWtfSYjQca0CKJ97vxbEzvh0SWu9dqtT6Drps4mWftRGCPk31mq0bX4xxvc7duE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774619594; c=relaxed/simple;
	bh=4UjIHXRTSneDOFqUnEDoiJU7sJ+/EvMullkMekR4Rso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SzayhQJ0YUH9c9fcEwuyLWOU4oumQJl+UphhUaIki55xU9V3maVF9VZQ2MuXhs0Xr8+QTaTFiz6WpLO1JMTjkTF9ZCDHRc2jXFTNZTv6HR2s0kD1t0n7QUVESHun9ESdqF1Y0mzeTiILxQ8hRI/MJgR84cpb8daNdoKviJEZsj8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.95.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eB/aNdd3GODpGl2JLCkZRsqogEgKWRXFy0WOod1P864h8x5C789qw2Jq7O0DoFniLYz2IEIvmxwdaA2zSrJ9WnkiJkP77I9+eN9qHaEPLFDFTDz356tl2PuTx8KMZousD5Lt4LjWtjNw47H+q4rQbm6IAz0aUSZDTi0n0oTB+HwXmX/xNoYkBpRtHbow5Ouqf2XnezJ25hD7AWH4oBMmQDKDi4UwOhS+X1l9ecszBhMaAxv0cd6bIyGfSemKiVQRX82YXZgW6hoAV9Ro1YRlXFcWMM3Fgm4uM6S4bnFFnzPNatBWP7RrKg1yg6M538nB6rKOJG/xUNNgIkkevOs/Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aYMO2iMBM5GvYe3i6liLcGrjRBFKyKIAli7NLcip3aI=;
 b=mNhhtZKQt9qFGZTRVidRHNCFDMDqAGhcJ2UTYzKaw6HhHy4OvQSzW9ay6/17rK/3tFRaKdGYVht9WgW/irzeZIFxvvUcHNcxQGBuZeSZr8aZza2jLa9WpA1c3ZucRXFwalk25ppSzCDmaYYm5GlVH9uNLbv8qJAiZ9aOLTmRdIzvMPqwxL/tU14v0a/5ko11jlVilP4s6HAEIuRlNcekTSDDq4c0nYo5/5RG92ndE5jnNjJiyZ+RGAlx1WydJ4cMAC6VNVl7rE/jkumsXBXNjYrC00cgFa+rV7zyOjJHpbPy+uyfF9K3e62h6zk8F0daU/QkNy1cz5MCAXC3SBId+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by CW1P123MB8504.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:269::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.23; Fri, 27 Mar
 2026 13:53:07 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%2]) with mapi id 15.20.9745.019; Fri, 27 Mar 2026
 13:53:07 +0000
Date: Fri, 27 Mar 2026 09:53:00 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: david.laight.linux@gmail.com
Cc: Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Petr Mladek <pmladek@suse.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH next] tracing: Remove spurious default precision from
 show_event_trigger/filter formats
Message-ID: <iqtkbsiy2z5mqqhkuzvt3c7j7ekkr4r3xdkihfpuy7uh3kdjnr@lqq4pqjgbpfw>
References: <20260326201824.3919-1-david.laight.linux@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260326201824.3919-1-david.laight.linux@gmail.com>
X-ClientProxiedBy: BN9PR03CA0956.namprd03.prod.outlook.com
 (2603:10b6:408:108::31) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|CW1P123MB8504:EE_
X-MS-Office365-Filtering-Correlation-Id: f6a9ad8a-357f-4428-eccc-08de8c082cec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	Ih6wS2H1iPCWDBhrf97sug9vBAwtl8jr3+3FqdXLLF19lv3NIqJaXqi10hniB0A2+8pHx0M821S7uaIrUoT46+bpDUcRPnJQSy5eH/VRtMIF3IUHP34cDfXf38q9rIY+si5B9Zh1sGVv68+8IqY7kEK3ZD5C30FPjvOJ/uA3fyWuiBM12PpZKTEFsckmNF9X9wzU7HDooblS90guB/Rikwu7K3v5Tq5L/nxGiq1VUEfApblG1pszt3R0D6/i0pynSpghJv3bKrjmK5SDcRD3928eTIG5jaP+xNC0eoD1o5MgJlk5p5n0iTHSSKy4sbCnQpBAZ8TYm5t32rUI139385HBLZLmJfO6QzJ91RWbBSS+oonFzwZ4WV1zqbXqo838QIvLegexUt+4njZF92SnOnm/KaQozqF4DEF0Hdz4oGHZNRQ6t0jjmQsMFh6hPy4FQnwTyHiODp7IlNGs80EXtkDYWv+Mt4uS9QeRLzH3VDOq4MCoHCTY9pifxBfKM3o8P4lc1BXIdWU7zjvCJ+G4F5Z/U/Ig9eIYFe+YUwSshGTHo3630+Fnn2qg7hzqMGLCdwjGm5a2EWClcgnyEz1Ap7R9V1wWLY0SU0iWNwlCdfZbtt3YFKAmEa9lI4v2TwVZNwN+ePqcRENlDrKugKjnnTnQYtoT9ilQy6XQbUTUJ0W54zOgB4Z6d/fAXyylwtB+LzaQTYyR25F4FbFaJR+/GmxqGrxj6Y5DgCbvwBQzldM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?alN5bnhiYnpFWlVhR2VmdlhuWXZWemlWaGhUZHFEOS8yYmFaZzdrelNCRnd3?=
 =?utf-8?B?VGhoREdwdENtQjhnOFNNdStVdm1BbzJaK09ZY1N4aUdvTllQdEc5V0RhQWQx?=
 =?utf-8?B?K0xmSytHVzRqZ2NZRFVNZUNJRGQ3Vi95RXhWeWwxeGhpZzhMRUlzdFcxdVpR?=
 =?utf-8?B?bGN0OHdjRHBKUlhtcnpzdnRTZzV3b2lTcFFQY0YyTDRGVTFmZFduazdWczdD?=
 =?utf-8?B?V0NlaGpCU0F4eXZLRXAxbUh4Ty9pMEhzM2NKdGFMQnR0ZEdzcmtRRTdISHVq?=
 =?utf-8?B?MUtqT3Q3RmxhdU9EL1ZOT3RqNUJiRXJxU0VIUVZObmF6ZmxJV3pHVHVkYm1J?=
 =?utf-8?B?eTdOMU15dndaY0g2cG9kalRHOHhHekwxMHcwWUpYZGtremdmZ3YzeldES3BB?=
 =?utf-8?B?UFNjblU4c1ZzSUIvdDdwaXQ3UjlXVGY1bDN6UDY0bVdOamtOaXlmc2hkYUpi?=
 =?utf-8?B?dG5VUHQyRGdFdXdWbkxlczdsbWMwK0taZGxjYzNoRmp2ajdtRTNCSmZOOTh4?=
 =?utf-8?B?d01YdHlEblJpaEtPUHlZWUE2cEw0NXFCa21TeVo1WXVFdnNhRHBMNys0ejZx?=
 =?utf-8?B?R0p6QkFvVFMwS3U0UzV2S1pXS29LTUdOMEs1aFBjTFRKWEVKNXdsQkQzMFd5?=
 =?utf-8?B?dEdNKzNmamVEQkNPY1pOeUxEUHRmUmE2WkZkSFlvL3ppSnZxb2oycjdxTnVP?=
 =?utf-8?B?WnZxdnQwV0RHWWNYR2RJcWo0RDV4MVlKV3NNZXMxdFRRWEQ3S21sV1htWnlW?=
 =?utf-8?B?NHB2ZnpVeWxLMWRpYVl3d0FnYm9Mc28vcEY0MXlvNmlOVG5yTkpmYnNsL25U?=
 =?utf-8?B?Vys0c2lEdi9MV0oybUJYT0pnNFlFUnVFeHIrWnpzY0liU2JWcXkyeHZ3QmNN?=
 =?utf-8?B?WitkRU5MSlBzbUhaazRXLy9kNkJDWDBzK2t1UkUvN0VOTTZta25TY3AwMnd6?=
 =?utf-8?B?M2NINDI5VGpmOW1IV09VMzhFV0drVVVGMUpPMThFQmxoS3EzREtadzZuR2FR?=
 =?utf-8?B?dWtSbHFsaGVSV1pqUjA0anhDbjlRMFdlek5qR1FHR0tnbFk1c251N0xTK1dq?=
 =?utf-8?B?emFyZWRIajkwQk5CMDFWRGlqdzdjQVdpMC8zYzNDS0N3K3U1OHh6emV4RmY3?=
 =?utf-8?B?TXhTR1hsZHJrN1RIbWtIL29GbjFZeFNJcllnK1FzaXNtMGt0TDR0R0tPbDZ5?=
 =?utf-8?B?MXFpcXhvamQvUjV2bDRMOHd3cEJ6OUdmYzlhV0h0UzFYU0hENTlTSE82NTF6?=
 =?utf-8?B?ZEdyQXRBSGEvVlpwYytRUUdabEY1YVJXLzBkclRyb0Z0Q3FUMDFVaHBtZ3pu?=
 =?utf-8?B?ZDlSQXJOZ1ZxWTdPYVVpMFlnRTRvMm1VY2dDTVd4UnBHa2pZaWtKMTZ2VVFY?=
 =?utf-8?B?NG5BQS9KVUR6VFozWlMwS0VDdVRvdDNxb1NDbEV1bHJrdDV6TkdXN1NmRUxa?=
 =?utf-8?B?ZXp1YzJYa20vTlBDV1J3VFlDZnR0ZE5aajRmOFlHeUlOOFlXZmI0OHB4SFN0?=
 =?utf-8?B?SG0wcDBnbENDT0ZnOXZYZE10YlRqa2ZndUR2enJyMnZ1dVJyUG9TYjR6R1BR?=
 =?utf-8?B?aEFiQ3dKZ3hNeWN0TzA2VTZBcXA5L3hFay91QmdyU3RhekxOZmpCSHVkZ0pG?=
 =?utf-8?B?OUhrR01KRnhqN1h6RmtUOVpDNDQ3SXdEc29uTFpoaW42VzZydWZOWGRoUU5n?=
 =?utf-8?B?aXJ1RVdGd1ZqOGZiUmY0ZTgxNFlWR0xkbkNNMWlvNnNVQ0Z3b20wYkVYRmFV?=
 =?utf-8?B?eU95TlBaWkorQnkvb1ovTlpjM0VobHFIWXRuVHArWFllZWFBdDQ1V3VsWFlJ?=
 =?utf-8?B?TmhpaCtHdDRUK3B5WkpNQnpTT3hxK0tpcGZlWHpZQ3MzSS9OVWxPMXVWdG5r?=
 =?utf-8?B?YTlWTFZ6K1RxSURXLzJmTXppbFNpL0tSZGZCZnpmZ1p2akFrMGprSEpqcU1v?=
 =?utf-8?B?NnY1RTlCZzFzV2YrUyttOG8vV3dIbGlLUVl6c3VjQnM3QjNHVEcva3dsS0Mw?=
 =?utf-8?B?Sk5YTVFrc1NnWVFRVllNQTZOSWJJeWdnSU9WWnV2U3Zka045T0FUaGFxaHVn?=
 =?utf-8?B?cG53aW5mN0F6ZzQxanBwYW8vYk16ZVNHSk9DSG40WHIveEVDcERSUlNiUzNB?=
 =?utf-8?B?UVJ3USs2MktDQlRncGI2V25hNXpTNXNVRkVObFRXZzFOU3ZkL284QmpBSGV6?=
 =?utf-8?B?MWNqaWhlQmk5VkZEekhla05xWXQ0NXIyRUs5TUpxQUo4MHA5R0t3Z2UrT1h2?=
 =?utf-8?B?U0VhUzlhbDFOaDJOTmZvTUkyTUIyenByalgvbC94eDcrUE9YaFJ0UElLTC93?=
 =?utf-8?B?WTR5blozNEsxUVZpZ3ZZM0pDRzVGamgxd05QekxaWHZud2h1RmRQdz09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6a9ad8a-357f-4428-eccc-08de8c082cec
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 13:53:07.5915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UR9mRKoGSIKksPSRXmoWSz7U7sXjNf+O97oDVUWnGDxq4SHZp59eefwbh0OLbL5KN+JIAtv+p0muSd8VbUPmYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P123MB8504

On Thu, Mar 26, 2026 at 08:18:24PM +0000, david.laight.linux@gmail.com wrote:
> From: David Laight <david.laight.linux@gmail.com>
> 
> Change 2d8b7f9bf8e6e ("tracing: Have show_event_trigger/filter format a bit more in columns")
> added space padding to align the output.
> However it used ("%*.s", len, "") which requests the default precision.
> It doesn't matter here whether the userspace default (0) or kernel
> default (no precision) is used, but the format should be "%*s".
> 
> Signed-off-by: David Laight <david.laight.linux@gmail.com>
> ---
>  kernel/trace/trace_events.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> index 249d1cba72c0..6b54c10f9ba4 100644
> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c
> @@ -1718,7 +1718,7 @@ static int t_show_filters(struct seq_file *m, void *v)
>  
>  	len = get_call_len(call);
>  
> -	seq_printf(m, "%s:%s%*.s%s\n", call->class->system,
> +	seq_printf(m, "%s:%s%*s%s\n", call->class->system,
>  		   trace_event_name(call), len, "", filter->filter_string);
>  
>  	return 0;
> @@ -1750,7 +1750,7 @@ static int t_show_triggers(struct seq_file *m, void *v)
>  	len = get_call_len(call);
>  
>  	list_for_each_entry_rcu(data, &file->triggers, list) {
> -		seq_printf(m, "%s:%s%*.s", call->class->system,
> +		seq_printf(m, "%s:%s%*s", call->class->system,
>  			   trace_event_name(call), len, "");
>  
>  		data->cmd_ops->print(m, data);
> -- 
> 2.39.5
> 

LGTM. 

Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>

-- 
Aaron Tomlin
