Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022134.outbound.protection.outlook.com [52.101.101.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B0C3DA7C5;
	Mon, 31 Aug 2026 11:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788176877; cv=fail; b=X646la9lU/7W18B9pEKYvYWsxjkHH494Om7SXBs3jS/2vScXq4ui1BYzTG3oMAqHxVnw6fmGQVxrUBbDp9CC3rIcf+H3Uafw58A7mBlkSFd9fzWH3ggnjxkB/PXKIfk0y/JE7DV+xhguds8Zp6QdSBGwaKdXkwbIdgnxZ2N0zsk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788176877; c=relaxed/simple;
	bh=wwX+ESasRWtZNIi2Vk1Nb6q2I5DLJyhSLMjCd/PW7zg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=X7+tpUggMZTQOsLvtiRdY2Z+EdtFGfa5h/zHSxdUmAV59Pg1ozoEnEHzHvo6L3wuOzf6ihKLzoolwNVnR2loRfjfACSyoajDbOjXj7ptICndK+opp6JUJQWo0hcg3E5xD+H2GumfaJWJ7Tt9QIgbRr+ZtqS7FbYxjlJJL0as3UE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.101.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F3WZBJdBk7Mskx7glCsr3SydQ7/pY/Uqjqsana0zy93vC5Lq5PHkNGl2dnhozAhbiKW3TgMRQsjSk1PO6A5gX6VBss9MBihjg6OvHf4MYJiEfezznaF/GReIgVq1e+37g2D+odo50iAdmCifIU+aYo/FkmGeMmuq7E2iRMC1gu0C7bcCY7x8iySGw8jAmqucucrK0g7RCuf8XO7QTt2xxg1AFbvvOhs0Ez0sKDAC9ADOUPz93umJvVbnX2H0ysshwWXT/ZWUz1sfuyzuSB2R9bzYbfywqDVhbByaKi+thtbosS7ltMT9bFQgr3u9PPFeNfzNwYc4b0ek74OWkwgM8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=/9LIOvKmEIs9CCwA5JZyE4M5oIlW3A7ldOhwEwKOMuc=;
 b=EQxwoGu5AE7Oj29skqOdjICmkx+VPGC6kf8PnlJBpwuiyuQ9YRfDWUg9jvMpjukSh61bSXV+bBN0b9coEUg+hhLTpAeNS2+eltpxhHG+tS8ozaN8mNBc3uWR5WEdldSdm7CuoPn5EdAztspfeM+8XeF0jQB6lIF/+m6KPuPADmP76Wcu1t1OKW3YRNienG2AhSeAiGgkXgm+4Q4D8PYgajbPIclVQTE0KE7cfvy3x9XOsHkQSKX2IDuad0iBPczjQy8UoHfw7gJyxDV1VJg8D4gNPXEakzefrXgvQQKq/C5gEbZZYZfkPYlntoixVrtVOJ4slehe/7j1oECZXMuk0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LOYP123MB3295.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:f2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 11:47:51 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 11:47:51 +0000
Date: Mon, 31 Aug 2026 07:47:46 -0400
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
	linux-usb@vger.kernel.org, driver-core@lists.linux.dev, linux-trace-kernel@vger.kernel.org, 
	Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v2 2/2] driver core: add TAINT_FORCED_BIND for when
 userspace manually messes with devices and drivers
Message-ID: <3wokq2ophqmanqdi72v3bmjk46cpwjlpsps25sjjijy6pzkcfu@khirtpque62f>
References: <20260831-bind_taint-v2-0-1082d631213b@linuxfoundation.org>
 <20260831-bind_taint-v2-2-1082d631213b@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260831-bind_taint-v2-2-1082d631213b@linuxfoundation.org>
X-ClientProxiedBy: BN9P222CA0026.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:408:10c::31) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LOYP123MB3295:EE_
X-MS-Office365-Filtering-Correlation-Id: b099720c-009b-4bd1-5d50-08df0755af88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|23010399003|7416014|1800799024|4143699003|6133799003|10067099003|56012099006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	+c5VXNuNC7KVUIWX8fbBL35dhngkwsAnxgmAl9ViPmy5l0UImWsHywfHBnErFGysyzqdIXyWtj4YDsyv7pgz1vuc3LsH+wuJpQMH5J+QdaEQyaiECGgbLBffbaE4DBof2Q4u7zREcfVJO9u8nCvE1gzsbBLl00ruF7chkY1RTthQ3Ue4ylPuHJcGjUyiwhcaBdbL51J5BxNUcDPIMgZ/24JCQ1Au82sPtbCekT+2ztUZtoHQt4po3SBONG+dtqxPu3hXuzqZ1UUvdNkr3jIfCkv8ykeDF/XsOxjg4EbW9Ty9pPtw6pPMvSuXgLa7TI/fTVi1ZkPXMGsKf+vopc49k2/sJKxu0APlEV+jg+1+s0JMLOf1USWRkprD8ELqdMuzPItK2iUV5zBBk9eBFfsjTESG9IgGPio06pGw4E2VGazIzFTcFYDkBngbuJ/1qbrFdLiD5neF3v3ohELAwbSe+hqHQ5aiMepqG/Rzcskdsm37b2e/l/ajgy2iLPZ0r3atmRkiRhjwCAMCK62o4xNVFBU2DlAvkBpnjYYxOgRARv/Pb0OLQIFIDj+OBhjcykK+lNDhZ8Gbz5NzbS5LvTKtTFwo6z40JwXSKm7jyZmGKu8sUsQHTz+nO5iPdPkHrrWy4UQbMXaWgHhWUYtzZMNue6SS59Z6mVMyW3EV0Cko9Dc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(7416014)(1800799024)(4143699003)(6133799003)(10067099003)(56012099006)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YkR1dHVPdFVOREN5bTN6Z3NRQ1BGMFkzblpOYkVLU1ZGeUdFcFloaXpPallG?=
 =?utf-8?B?TDhwOG95a1d1TDdWMUJFQU03bzV0RGxzWFFoOVh1N3RzN21IMjRSUURWSGV3?=
 =?utf-8?B?WHE5VGRLbm5iYkZ6SUViYktCaG5OVC9rRXJQTEdGWlZtUkJ5Qk4vUm9wTlBW?=
 =?utf-8?B?VjhiWmkwWjJSSlZXY25DOTVJcDNnVmxUTm84WGp5YytXMDVRK1BLdmNlMU9T?=
 =?utf-8?B?aHVVYUpPNERObmhaeEtHUmt3MGZEaFRodk9GUTNScUxqczNaQjNuejFvU3RH?=
 =?utf-8?B?MDF0dE1zNnowWlpWNnRjNmpLL1VTU3duTGY2VW9yZWNnNXVTVnJGdDhnaWhN?=
 =?utf-8?B?UXJLdldlMDNJQkxUNWljeHlXTU9kT0VYTEhScUp0M2pCZWVKQmpMejk2NzVy?=
 =?utf-8?B?RTBjQ2MyUGJrQmszSUd5Mis3cnplL29XT0YxYTYxRklhVEtoMUQ2YzIvZ1dP?=
 =?utf-8?B?UDg4Q3NScS9FU1M0TVY5bVdnMGZSVHFlRExpUm5RS0hWNHduU2dkWEdiTmVu?=
 =?utf-8?B?UWFrOC8vOWhyaDhIRWRqU3dHTzFwQTAyRHNpR3VjRjJLbGQrSjJudG5FcHY1?=
 =?utf-8?B?Q1gwMXhETkVnajNSbWdQbWlnRnpxc1pNQlNpV0IvaXdDSWt2cFJ0R25RbzlH?=
 =?utf-8?B?a1czT2VjTGdFUmF1Zm1FT0E1RXZVdWp2aGROTVY5K2xkaHdmKzYybWNNWkJy?=
 =?utf-8?B?Yk5jYkxSdVZhbi9QZlhmWWFFQ1ZTMmZyaUFDYk96VzJPWUcxdG0xQWQzMDEv?=
 =?utf-8?B?aHduZnhNR3ZnUU1BK2M0WlV6a0U5WGlUMy9YZjZCb0o5OHQ3d0JmV1VZV3NQ?=
 =?utf-8?B?ZXgxRkdvbUNBSmhBdm9RenpIVkl0K01BMzFKUUFkSHhzRUtKVXNXeTk1Y3NP?=
 =?utf-8?B?ajdKWDVoOWFhKytXanluK3g0aUpsVnBoeTFteCttZ0xXRDFnOHBJSE04dXdH?=
 =?utf-8?B?d08zWDQ4MFlkaXp5YUpndm4zWFVRaEpiODRvTGxFY1JkMlZYcTQ3bUdrazFV?=
 =?utf-8?B?TlhqdWkrYTM4amF4ZElGSU0rMnBPaTVUeGR6K1dTK3k1RFlxOEl2T0c1ZXFT?=
 =?utf-8?B?UXk0Y1FOMlRqMnZDWHZFM1czWEsyUElVdUZjSnVMVG1oMG80RGp3bnlES2Zx?=
 =?utf-8?B?MkNlRXRRNWppbmtoVkluV3llY1lCYUdDTWF4SWo2MEhKdHJoU2Z3QjlvSXpD?=
 =?utf-8?B?ZzF2RkRzK0xnOWczeHdVS25taDNmVkdQQy8zKzJ3cjdOMEZmYXpFWElFVG5s?=
 =?utf-8?B?MHpvNTNJQWQ0ejBZNTQ3S1ZPVk9YQ2tEZXZxQi9nMXVXVlhnTFVsUVg0Wk80?=
 =?utf-8?B?SUJXUEw1aXZZWTg3SklPS2JubXpUS3ZOYWptVnJuMFJuL0VYMDVjSWpjY0or?=
 =?utf-8?B?QnI1djF0eEtZRjJFYmhub1hIbHJPblpxaVBvSXZXbmhmblRYMkN0V1NjQ1BU?=
 =?utf-8?B?Mkw4Qm9pQ3RRMlRDdzRkUnViSlNidWUwalcreVJyU085S1IwakhwQ1hIR3R4?=
 =?utf-8?B?TkJQbWF5YUI3T1FmNmlTb1BQc1BuZXQ1YWpHYnlObkFjMHlKVXZsdExuVVRa?=
 =?utf-8?B?SnZCcVpkRHl6elUxWHJRRDhYc1hSTXZ5MTdSVHZPMVBVQk5yR0N2NkZPTGVl?=
 =?utf-8?B?bTdZdXYwNFdVbFRQY2tKRFcxblhVQnpXUjN5cExHaDBFNm5EY2syWmVRYzdW?=
 =?utf-8?B?OGMxUXVsSUpaUExnWGNRS2dsaXFjYkRwL3N2M2trcmdWM1pyUUtISGxpRkY4?=
 =?utf-8?B?eEJsZG5IK0t0Y1ZYYks5VzRXRXRJUVdnSWxxMnpibDVvNU5iSXhBSHAzSGU4?=
 =?utf-8?B?Znl2blJKeHNnQXorQmZXOGRDbkh1eWdRekh6NFV4dUNZTXkvbXBRTGZBSHNy?=
 =?utf-8?B?TE9teFA1ZUtSbnQvQlJRSHdraGY0azJDaG54RytvMjQwS2kvUEt6cENDVEdE?=
 =?utf-8?B?Vm1LajdnNWc3Y1NQWEpFbjR4QXc3RFMwTE4xbm1qOG9Hc2MwYmZUYXRZSC85?=
 =?utf-8?B?VDgxRzVYWmo3c3k3WW1OaDJURmcxcmlKU1Z3ZEZteHA1K3dOZ05UazBPblp4?=
 =?utf-8?B?ZndsWEc5T1hBelNmWjVzWjI0NzcwdjN0MFR4ekJsYmRUSHVTZ0tsMVBiTEZu?=
 =?utf-8?B?ZXF4b0lqdExFc3hpdWc1Q3pJTmdMU2FSS1c3d3d6cHRDSVEyUTFLM3F4VEFw?=
 =?utf-8?B?UGVRanNoTE16QmFidy85N2U4WFcyN09PU2pVY3NReU9HU29ETmo3UjE2Uk02?=
 =?utf-8?B?ZSsxZEQrVUc5dVQrdk5OSms5d0xndllMUjBzeGxOc3g4bnZmN2NpYWlDVnNB?=
 =?utf-8?B?L2NiY2V5YWMzL0xTdlFwL3VNMi9QTjcrZ0xLN0t3QWlhbms5cEUvdz09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b099720c-009b-4bd1-5d50-08df0755af88
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 11:47:51.0443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N1D5DE5GeV7lbujYaUv0cgaj4hPeM7mAuAOG/uJyl2BuLxqnrrDOWC1Ls8hFA5m/SC7bO5A2uDxEYPEbGCoueQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOYP123MB3295

On Mon, Aug 31, 2026 at 12:51:47PM +0200, Greg Kroah-Hartman wrote:
> The ability to add and remove devices from a driver through the sysfs
> "bind" and "unbind" files was created all those decades ago as a way
> that kernel developers can iterate faster, and provide a debugging way
> for users to attempt to add a new device to a driver without having to
> rebuild their kernel.
> 
> This api over the years has been abused and recently come under a major
> fuzzing "attack" through tools like syzbot which decided that it would
> attempt to just randomly bind any driver to any type of device, causing
> loads of unneeded errors and pointless kernel patches to be generated by
> unsuspecting new developers.
> 
> Handle all of this by adding a new taint flag, TAINT_FORCED_BIND, which
> will be set on the driver if the bind/unbind sysfs files are ever
> written to.  This lets kernel developers "know" that a user is
> attempting to do something that is not normal, and as such, if the
> kernel breaks they get to keep the shiny pieces laying around on the
> floor.
> 
> The flag is 'Y' which was unused, and can remembered as the user is
> "yeeting" the device being operated on here (thrown with force without
> regard for the thing being thrown).
> 
> Note, the taint flag gets set _BEFORE_ the bind/unbind callback happens,
> as many times crashes/oops/warnings/failures happen within the callback,
> and the taint flag needs to be there to show what was being attempted.
> If it were to be set after the callback happens, the oops report would
> not properly reflect what foolishness was being attempted.
> 
> Fuzzing tools like syzbot, that doesn't have hand-crafted rules to keep
> the tool from hitting bind/unbind, should be run with panic_on_taint
> enabled so that they fall over and don't continue on, thinking that they
> actually found a real issue.
> 
> Userspace operations that rely on the bind/unbind files to work around
> the lack of will to upgrade a kernel image to a newer version with
> proper support for new devices, or the lack of will to submit valid
> device ids to driver authors, will still work properly, but now the
> kernel will be flagged in a way that will show that perhaps those users
> should reconsider their behavior and work to have the drivers properly
> support these devices in a "native" manner.
> 
> Finally, the bind/unbind files can find real use-after-free issues with
> some drivers by forcing the process to happen virtually without having
> to rely on manual removal processes.  Those real bugs should still be
> worked on, but by adding this taint flag, developers can more easily
> determine bug reports that are actually worth looking at.
> 
> Reviewed-by: Johan Hovold <johan@kernel.org>
> Tested-by: Johan Hovold <johan@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  Documentation/admin-guide/tainted-kernels.rst | 52 ++++++++++++++-------------
>  drivers/base/bus.c                            |  3 ++
>  include/linux/panic.h                         |  3 +-
>  include/trace/events/module.h                 |  3 +-
>  kernel/panic.c                                |  5 +--
>  tools/debugging/kernel-chktaint               |  8 +++++
>  6 files changed, 46 insertions(+), 28 deletions(-)
> 
> diff --git a/Documentation/admin-guide/tainted-kernels.rst b/Documentation/admin-guide/tainted-kernels.rst
> index 9ead927a37c0..abbf5e3dd749 100644
> --- a/Documentation/admin-guide/tainted-kernels.rst
> +++ b/Documentation/admin-guide/tainted-kernels.rst
> @@ -79,30 +79,31 @@ which bits are set::
>  Table for decoding tainted state
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  
> -===  ===  ======  ========================================================
> -Bit  Log  Number  Reason that got the kernel tainted
> -===  ===  ======  ========================================================
> -  0  G/P       1  proprietary module was loaded
> -  1  _/F       2  module was force loaded
> -  2  _/S       4  kernel running on an out of specification system
> -  3  _/R       8  module was force unloaded
> -  4  _/M      16  processor reported a Machine Check Exception (MCE)
> -  5  _/B      32  bad page referenced or some unexpected page flags
> -  6  _/U      64  taint requested by userspace application
> -  7  _/D     128  kernel died recently, i.e. there was an OOPS or BUG
> -  8  _/A     256  ACPI table overridden by user
> -  9  _/W     512  kernel issued warning
> - 10  _/C    1024  staging driver was loaded
> - 11  _/I    2048  workaround for bug in platform firmware applied
> - 12  _/O    4096  externally-built ("out-of-tree") module was loaded
> - 13  _/E    8192  unsigned module was loaded
> - 14  _/L   16384  soft lockup occurred
> - 15  _/K   32768  kernel has been live patched
> - 16  _/X   65536  auxiliary taint, defined for and used by distros
> - 17  _/T  131072  kernel was built with the struct randomization plugin
> - 18  _/N  262144  an in-kernel test has been run
> - 19  _/J  524288  userspace used a mutating debug operation in fwctl
> -===  ===  ======  ========================================================
> +===  ===  =======  ========================================================
> +Bit  Log  Number   Reason that got the kernel tainted
> +===  ===  =======  ========================================================
> +  0  G/P        1  proprietary module was loaded
> +  1  _/F        2  module was force loaded
> +  2  _/S        4  kernel running on an out of specification system
> +  3  _/R        8  module was force unloaded
> +  4  _/M       16  processor reported a Machine Check Exception (MCE)
> +  5  _/B       32  bad page referenced or some unexpected page flags
> +  6  _/U       64  taint requested by userspace application
> +  7  _/D      128  kernel died recently, i.e. there was an OOPS or BUG
> +  8  _/A      256  ACPI table overridden by user
> +  9  _/W      512  kernel issued warning
> + 10  _/C     1024  staging driver was loaded
> + 11  _/I     2048  workaround for bug in platform firmware applied
> + 12  _/O     4096  externally-built ("out-of-tree") module was loaded
> + 13  _/E     8192  unsigned module was loaded
> + 14  _/L    16384  soft lockup occurred
> + 15  _/K    32768  kernel has been live patched
> + 16  _/X    65536  auxiliary taint, defined for and used by distros
> + 17  _/T   131072  kernel was built with the struct randomization plugin
> + 18  _/N   262144  an in-kernel test has been run
> + 19  _/J   524288  userspace used a mutating debug operation in fwctl
> + 20  _/Y  1048576  device was manually bound or unbound from a driver
> +===  ===  =======  ========================================================
>  
>  Note: The character ``_`` is representing a blank in this table to make reading
>  easier.
> @@ -189,3 +190,6 @@ More detailed explanation for tainting
>   19) ``J`` if userspace opened /dev/fwctl/* and performed a FWTCL_RPC_DEBUG_WRITE
>       to use the devices debugging features. Device debugging features could
>       cause the device to malfunction in undefined ways.
> +
> + 20) ``Y`` If userspace wrote to the `bind` or `unbind` sysfs files and
> +     successfully bound or removed a device from a driver.
> diff --git a/drivers/base/bus.c b/drivers/base/bus.c
> index d17bd91490ee..c51ad96d4de4 100644
> --- a/drivers/base/bus.c
> +++ b/drivers/base/bus.c
> @@ -19,6 +19,7 @@
>  #include <linux/string.h>
>  #include <linux/mutex.h>
>  #include <linux/sysfs.h>
> +#include <linux/panic.h>
>  #include "base.h"
>  #include "power/power.h"
>  
> @@ -241,6 +242,7 @@ static ssize_t unbind_store(struct device_driver *drv, const char *buf,
>  
>  	dev = bus_find_device_by_name(bus, NULL, buf);
>  	if (dev && dev->driver == drv) {
> +		add_taint_module(drv->owner, TAINT_FORCED_BIND, LOCKDEP_STILL_OK);
>  		device_driver_detach(dev);
>  		err = count;
>  	}
> @@ -264,6 +266,7 @@ static ssize_t bind_store(struct device_driver *drv, const char *buf,
>  
>  	dev = bus_find_device_by_name(bus, NULL, buf);
>  	if (dev && driver_match_device(drv, dev)) {
> +		add_taint_module(drv->owner, TAINT_FORCED_BIND, LOCKDEP_STILL_OK);
>  		err = device_driver_attach(drv, dev);
>  		if (!err) {
>  			/* success */
> diff --git a/include/linux/panic.h b/include/linux/panic.h
> index f1dd417e54b2..8e7250b0e913 100644
> --- a/include/linux/panic.h
> +++ b/include/linux/panic.h
> @@ -88,7 +88,8 @@ static inline void set_arch_panic_timeout(int timeout, int arch_default_timeout)
>  #define TAINT_RANDSTRUCT		17
>  #define TAINT_TEST			18
>  #define TAINT_FWCTL			19
> -#define TAINT_FLAGS_COUNT		20
> +#define TAINT_FORCED_BIND		20
> +#define TAINT_FLAGS_COUNT		21
>  #define TAINT_FLAGS_MAX			((1UL << TAINT_FLAGS_COUNT) - 1)
>  
>  struct taint_flag {
> diff --git a/include/trace/events/module.h b/include/trace/events/module.h
> index e5a006be9dc6..19df3e39bba4 100644
> --- a/include/trace/events/module.h
> +++ b/include/trace/events/module.h
> @@ -26,7 +26,8 @@ struct module;
>  	{ (1UL << TAINT_OOT_MODULE),		"O" },		\
>  	{ (1UL << TAINT_FORCED_MODULE),		"F" },		\
>  	{ (1UL << TAINT_CRAP),			"C" },		\
> -	{ (1UL << TAINT_UNSIGNED_MODULE),	"E" })
> +	{ (1UL << TAINT_UNSIGNED_MODULE),	"E" },		\
> +	{ (1UL << TAINT_FORCED_BIND),		"Y" })
>  
>  TRACE_EVENT(module_load,
>  
> diff --git a/kernel/panic.c b/kernel/panic.c
> index 213725b612aa..6bf60f9dd120 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -826,6 +826,7 @@ const struct taint_flag taint_flags[TAINT_FLAGS_COUNT] = {
>  	TAINT_FLAG(RANDSTRUCT,			'T', ' '),
>  	TAINT_FLAG(TEST,			'N', ' '),
>  	TAINT_FLAG(FWCTL,			'J', ' '),
> +	TAINT_FLAG(FORCED_BIND,			'Y', ' '),
>  };
>  
>  #undef TAINT_FLAG
> @@ -862,9 +863,9 @@ static void print_tainted_seq(struct seq_buf *s, bool verbose)
>   * exact size is allocated dynamically; the initial buffer remains
>   * as a fallback if allocation fails.
>   *
> - * The verbose taint string currently requires up to 327 characters.
> + * The verbose taint string currently requires up to 344 characters.
>   */
> -#define INIT_TAINT_BUF_MAX 350
> +#define INIT_TAINT_BUF_MAX 370
>  
>  static char init_taint_buf[INIT_TAINT_BUF_MAX] __initdata;
>  static char *taint_buf __refdata = init_taint_buf;
> diff --git a/tools/debugging/kernel-chktaint b/tools/debugging/kernel-chktaint
> index e1571c04afb5..d8628be37214 100755
> --- a/tools/debugging/kernel-chktaint
> +++ b/tools/debugging/kernel-chktaint
> @@ -211,6 +211,14 @@ else
>  	addout "J"
>  	echo " * fwctl's mutating debug interface was used (#19)"
>  fi
> +
> +T=`expr $T / 2`
> +if [ `expr $T % 2` -eq 0 ]; then
> +	addout " "
> +else
> +	addout "Y"
> +	echo " * device was manually bound or unbound from a driver (#20)"
> +fi
>  echo "Raw taint value as int/string: $taint/'$out'"
>  
>  # report on any tainted loadable modules
> 
> -- 
> 2.55.0
> 

Hi Greg,

After you replace the accidental comma with a space in the parameter list
of add_taint_module() in module.h under !CONFIG_MODULES:

Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>

Kind regards,
-- 
Aaron Tomlin
