Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021072.outbound.protection.outlook.com [52.101.100.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C64503BCB;
	Fri, 18 Sep 2026 15:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789746257; cv=fail; b=R+WdzQU/opPWiD4bzgf7zuPp/Pq9VvoFAdm1+clncIpmqrue7l7IIOWZk36nBlLWKTMg2ZzSLJgF9DvTVfkGuPAoBexuS1QqmtJuY9YFXKzfVcLxMTTkpDNjVNriBKa4DVCiUKzjgQb3mDOPJezNF5g145B1nPQ2ioLHOiyhlUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789746257; c=relaxed/simple;
	bh=dcN+qnDLI/wBS+UK5TZ8A2iCW8xjQlDpK353mEW0Tp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YBp+Bvp5KwtR0AVBMbrhziSEPeT+uwUD3PmnQv/IRXpEGnWU0RpOWfJUfGhFGCayeHBsUK1IKf0Gl0GEpKNTO806B+eNGlFJUVmRMZijQjTTJu+q3J8dZvcBA3HWk1V44KU8n6fSqSVNKqJ6UP20nTgfcLMkNzWEOYlynl5vilw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.100.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lpE0G4UXCu/uJrsxmij+ISV55KR4eIuMofvRJ/kRFcraN2nF4Xx516QWSRazLxmfDzhFpmjGHHm/9069HQ0gOohxjBn0csJJXVWcL8FqGy1AglKv3jlnsKfKj/qbNscvafwmgdW66IG1CI8FRuZydsFkxHtZLrMnA/GpvTkELJw2eKtea4CCiU4JxCmDb4Dtbh0omZ0RrM67vXisddHhMzl/6RuCiahtkAuoCxH4cGhMj5b2QzetwkTASFuOADnfIqp9Qq5AlTelH5kqt+NzzhybGvYT+7HtqpJUx36CZuauJA/cFce35jvhkOJoSoR5Ugd89EotBzN0B402rExFQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=APNEUdWFcLdZMIaIxMndyzxJZd/tdxdGGgaeDY36WoY=;
 b=bEGo5MwFzyc4v/tXohLVafrnt2+aXyDZLT4s0e4UHKAQ23C6GRqyTZ+T7gJ2OSBZi+XmiBWsRUu23RJMdMCvsjXME/Aje21MKRAxXHz0fNU1FVOJ+9F5wPykv65qbnYkb2a2kTVhPQurJjAnQziosptyZxwo+Ztg8vhZ5ziuUoBrKsfhzCPMM6HCOa4wfJ2gYtLgCfuCeF1QkXvZgDir6Kkc+jcN+40wRkwXRFpMAzzLPZz/dbFXxOGCVzIQ/9H8FRGDoPjU+TehFhwd4KGN0USN4h/4l7gZi8o/804rW9fEUeCeBb1G9QUJ3NdlJ9XOp7AJGn/IYKLKSmsjFZN4eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO9P123MB7964.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:3e3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Fri, 18 Sep
 2026 15:44:09 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 15:44:09 +0000
Date: Fri, 18 Sep 2026 11:44:05 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Bradley Morgan <brads@mainlining.org>, Aleksandr Nogikh <nogikh@google.com>, 
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-usb@vger.kernel.org, driver-core@lists.linux.dev, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] module: fix up documentation for add_taint() and
 add_taint_module()
Message-ID: <k7pmsxqohlkatvwhd4bngycdlegc4d7ss4gj7ghanajga5zsms@ixjphhjwqbue>
References: <20260914-bind_taint-v4-0-eadf8a090903@linuxfoundation.org>
 <20260914-bind_taint-v4-2-eadf8a090903@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260914-bind_taint-v4-2-eadf8a090903@linuxfoundation.org>
X-ClientProxiedBy: BN0PR03CA0015.namprd03.prod.outlook.com
 (2603:10b6:408:e6::20) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO9P123MB7964:EE_
X-MS-Office365-Filtering-Correlation-Id: caae861a-cb6a-486a-b7de-08df159bae06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|366016|1800799024|6133799003|4143699003|22082099003|10067099003|56012099006|18002099003|27256017;
X-Microsoft-Antispam-Message-Info:
	U/ngbM+fNTf4WZnRAG/cFvTUVQs6gAXmzcOUw0yY0jtXiUb4s6CCV4b6z4XYWB71cdGmMZGDYiPbgKolmnjBQAgxWHsRgZ/H/ZVaHB/8I6vasaNx+ogzbUjkynH7NuaGFDjqhkwm+eon/mj0BXa/X7A9xhBjZbBz8V3neWJNbz1etTk4Ot2Mdykb44sGMQpGKQF114vG0fjjEXyjeKgHQOQ2dEUfE+JVtkN/SSDVQccohy3VBy88tBrAe5qR/8YXBBy0bpss3nmGEjps3yPgmdbuqs8lR38PWC6nLGQmHH3eLgluryc63e0F4mt8G7OAoLWWf+/1jMND+ZKQ1NuZlSiZBGer4AVlpwBWlto/43Q96oOcOa/rB3y5cF57XzTfwnrLQWmarxgILaJHk1wiJyStEGRj5y1JbNb8rVU+VdIM3BNWcMnRcD8HgRR5CSkFfevuW07oPz9U5fAVmsm06GuMsSs3gUzRE1dI0H0F6UckdrSVT4tXztSA5vHME1hqyl0TxKhHJ9vTPssOtnrpc+AL28BYbkVkSIf/HiKDZnlq057Sa/mb9GEBr1rSgN9RKyS7x2uFDe4V2IHEf5jfSs5gHEmsAEJWuyeXNruDZBJ11Xs8jPl3TgS0q+6Cbmtbw1qLB0MEKMwCdSTvzHBL5a8fFX24Sqi7MdtZVe0Kjzx2v1E0mXlAXq+/yK4VRq9x1le9bGk/r+Wf21EJKlnRDA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(6133799003)(4143699003)(22082099003)(10067099003)(56012099006)(18002099003)(27256017);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TWRkZTlJcHdBUVRSRHVuV2NZTThrTk5NTVd0SVBaZW5SZWJKZDRES1BXRnh0?=
 =?utf-8?B?OVdHazJieTFyMzBGVkNHTWFVSlFoMkR5ZDVBQnR5dUpxV1lSU2FqQkIwQk0z?=
 =?utf-8?B?R24vWWx6WXBKQjBweEpvcU1sYm1CeVJod1FTL0VMMm9SZTJObEtoTmJPbWJN?=
 =?utf-8?B?U0tieXN6Qzlma3I1ZUpIdDBReVNsNTNRVzNFWmJ6UHVwalRXbWY5dXNpMFB1?=
 =?utf-8?B?QlVpcWgrakhxN3c0alJoK09pT21MWlVpZ3VSMnBoYVJQMjZRTmgwZU12elhL?=
 =?utf-8?B?VEJZQVNDYjhnQjVhRE16TWxxVGpnQkdXQk90bW1KWDgwbU9QUlMrQ3BPclVY?=
 =?utf-8?B?dUNYNXZGdlUrQ3l5MStGSXhZbXErakpuRFdXbFR1T0kyK05OK1NJZDJ5dGQ2?=
 =?utf-8?B?WTBFT1NNdGp6RGZRMFZWODhNV3hiOFAwY2R0alk1VTh3dXAzc0k4REc2L1Fn?=
 =?utf-8?B?VjVlR2xNWHc4d3N4RGJsR21xV1pta3VzcHdVRGF1ckwwUWJpcFBNdU9UU3BX?=
 =?utf-8?B?SmJWUllkeDNIQUtsR0JYQlA0ZGJGRkFnTjV3anI5MFJtZWtlWlRrTVZnYnE2?=
 =?utf-8?B?T21yeHlKWDBvaXcwVXlpWTFHNzljTHpuV015L0hRRFNIZStmb1F6aC8zTXRG?=
 =?utf-8?B?QjdrYXQyRTNTNk1vMTQ0Z3pyWlFJc3dTTStCQzBFTGptS215Y1ZVOTJ3VG5y?=
 =?utf-8?B?TlZZZlFGeEdKM0FPSWdjMU44MG9RZnQ1clErWVRNRlF3c3J4Y3BLWVVBMTgv?=
 =?utf-8?B?aXNJZ0pSR0ZzOGpiaWZONEI3bnlEZ2lqdW9QaVZpYnRxbjV3R3ZTUktvM09L?=
 =?utf-8?B?SHJUd0IwbTE1OVcvNkJoWkdyRm9SK3U1Z1ZQM1hid25VRkhtWldjMXV0UUNo?=
 =?utf-8?B?SUNIcHNVakFORTR1Y3crVk1CT091UVhkdXZSck1jR1IxYytyQnIwT1p3c3l4?=
 =?utf-8?B?WUJUejUyTVFmc0creFpiK0xYNDVLalR1OVAveENoblpSc29tM1dQekwwVHht?=
 =?utf-8?B?NVdaLzFBd1pVK3ZLYUtrOWlZSHc3L0pGNklpdEpJZVk2cTZ6VmxJZHg5d1JD?=
 =?utf-8?B?Sjhvai9KaG11SHY1YktoSTYzdUpCNnBmUzh2SFV3MU81NUZ2ZWlhZHdCK2M3?=
 =?utf-8?B?M01veUF0YTFUdmkwZEFFMGpnRjFUTFl5N3l6QmlJUUt1REJ2NStqa2w0TGg4?=
 =?utf-8?B?bUpxWGF3b3JkSUdZcG1SdG40Q0x3QVZxbHlBODhwOVNqc2drR1dxWkIra3V1?=
 =?utf-8?B?amdKZU9HZ0JIdmtUTW9lQ084Zk9OQ1BVYkpPLzNWZGdodG4vTUxkVmY1T2Vy?=
 =?utf-8?B?VTJkUHJBLzE5TXNHL3R5Y1htU0JRdjZEbk9MZ3pBRzFUbFBGVFgrditJdU9U?=
 =?utf-8?B?UnBtYmZkZ2FtYzhieWR6RkJCM3lEQjE4Rk1XNWdUaDJVaWMyTWc5b013VmZt?=
 =?utf-8?B?QkNhdFl0RUNUcnlzZ3JKOWxSa01WRG1kMVpXdjZUSFBUWjQrNDFBRnRtUzdm?=
 =?utf-8?B?amVoeUxEVWkyamZJamUyRXNzT3FIdzZoQndBSnl4Zmo3NlplTkVOby9kV00x?=
 =?utf-8?B?M2QvTjdLMThWY2tzOGhWbnJaZ3REbGNlbVEwb1pLaVBjZzBEUzNGQlV6VzJB?=
 =?utf-8?B?RXM1dVRZdHpHNFBLditpaTFSQk56MUZDZ2N2SlVMVUc0OVh6Y0U5U0FjUkhS?=
 =?utf-8?B?d1puV0s5MG9NQmxlOCttME80SU1QRWYwTnpsdDBDN3JyRTNMam5uSGhGaFg2?=
 =?utf-8?B?NXZGL21QT3dmQTRheTM5aVZNVHFsMlBMMHMxTG5MelNHTmdUbjNqTEttazZy?=
 =?utf-8?B?SFowMW5NZ2xJclh1MUJOWXB6ZEhGbVVGbHRtQ2pTSWoxSERHd2I2c0ZUMjdS?=
 =?utf-8?B?a2lqZXhXd1dHaVlMbzBFRm04QmtmSGhOQ1M4dmtsNVd6aGM3ZW8wRC9Kcllp?=
 =?utf-8?B?TEJmcUI3RWVaYk1PY29ocldsVTJ3ZFE5QitiaGorWHhzV3BDazgwLzVDcDU2?=
 =?utf-8?B?VGoxdGVXM1V1UldyT2x3djJWWndFL01INTJrb2o1UEowaW04RnIyZHVvUUFE?=
 =?utf-8?B?OUlMZXVjbzFHR1hwSWRuNGlxWVMrVU5TTWdHNG83Q05RdkV3Szg0SGZGQzcv?=
 =?utf-8?B?TTN4Nk5lS0xwVEN2NmtIMGNuczQ3RjVhRmJtS0FRakxoK0I4TkhPUUNsR1pB?=
 =?utf-8?B?ZHlnQmhIRElhTS83VU5mQXo4MVE1dnVBME9OYkR1Mit6aVpWZE9nandROWVF?=
 =?utf-8?B?dUJUVkR5bUp1cStqRVJpMllaMEpib0hXVFZucE9oc0kzZzJBZzBKTk1VUjVr?=
 =?utf-8?B?djlZTGJyNzRURHZUL1IrVUF4d2QxUTcycGVPZUs5bnhlNit5VGdnQT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: caae861a-cb6a-486a-b7de-08df159bae06
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 15:44:09.4820
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P9FwN7Cf9BCRVlvjhwpdUe570gPyc2QWncyaDZuG5DB0AOtPezpYkhkfXmsUQcLvlNyh43dgSP3CNvNI5XRX3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO9P123MB7964

On Mon, Sep 14, 2026 at 04:30:32PM +0200, Greg Kroah-Hartman wrote:
> When add_taint_module() was added, the documentation for it was copied
> directly from add_taint().  But that documentation was a bit wrong
> (wrong variable name, and misleading boolean reference.)  Fix up both
> functions to have the correct documentation for how to use the
> lockdep_ok parameter to these functions.
> 
> Reported-by: Petr Pavlu <petr.pavlu@suse.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  kernel/module/main.c | 5 +++--
>  kernel/panic.c       | 5 +++--
>  2 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index 444d990c9983..369794876c3e 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -197,8 +197,9 @@ static inline int strong_try_module_get(struct module *mod)
>   * @flag: one of the TAINT_* constants.
>   * @lockdep_ok: whether lock debugging is still OK.
>   *
> - * If something bad has gone wrong, you'll want @lockdebug_ok = false, but for
> - * some noteworthy-but-not-corrupting cases, it can be set to true.
> + * If something bad has gone wrong, you'll want
> + * @lockdep_ok = LOCKDEP_NOW_UNRELIABLE, but for some
> + * noteworthy-but-not-corrupting cases, it can be set to LOCKDEP_STILL_OK.
>   */
>  void add_taint_module(struct module *mod, unsigned flag,
>  		      enum lockdep_ok lockdep_ok)
> diff --git a/kernel/panic.c b/kernel/panic.c
> index 213725b612aa..892045d8409e 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -948,8 +948,9 @@ unsigned long get_taint(void)
>   * @flag: one of the TAINT_* constants.
>   * @lockdep_ok: whether lock debugging is still OK.
>   *
> - * If something bad has gone wrong, you'll want @lockdebug_ok = false, but for
> - * some notewortht-but-not-corrupting cases, it can be set to true.
> + * If something bad has gone wrong, you'll want
> + * @lockdep_ok = LOCKDEP_NOW_UNRELIABLE, but for some
> + * noteworthy-but-not-corrupting cases, it can be set to LOCKDEP_STILL_OK.
>   */
>  void add_taint(unsigned flag, enum lockdep_ok lockdep_ok)
>  {
> 
> -- 
> 2.55.0
> 

Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>

-- 
Aaron Tomlin
