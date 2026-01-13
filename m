Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010054.outbound.protection.outlook.com [52.101.85.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DDA61FFE;
	Tue, 13 Jan 2026 18:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768328283; cv=fail; b=VYrFALmrc6QKmtyGjXYgMarvHQv8ksfmdR2l8MldsTqinO6QOfSxAiuTTQpvUuHfP53rCW1762RK7A6WBz9PYRUToTcS9kHTetjmg3BU3Hs4USRz/fo8aHK5AawkbPMOQfjQ8yccNpza6DT3/yJDa+IGWcXlWUdWORRS70Xt3ZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768328283; c=relaxed/simple;
	bh=ET5XyUc0oEn2R3m7FoSkfn1oUO+88243rQ+4UxhdUTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bMIhLiXkn0AFgSNrY4qIS72lOabWUG0NScGVVBphTIsZNR1nFt4kyOKiem4DO3k4vT+LqXzigfb9n306FCeKFiU3XVG+IoNyQMfFE6fu2AM5xVMfXaqCAvlb50ByUSX/JHbeuPv5vmOupLcauAlM3CfLSmq9WWtK21YiOP4/ZIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kXm2+yyr; arc=fail smtp.client-ip=52.101.85.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kXm2+yyr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aA26SVzz2pf7E05awV2PG1k/pe3OCJv/vATtGCFLVGxBoCCG20rxSIdtE6zxh7CIxYoyLNc0KLGD9+GtYzERwadkn4R+OnhSmZhvQ+GLvStMDxh9INJsBt96pHNTC54Kl+859U2d3q8EEbT2tG4CTgClbQH7lXECqCzaqYqoST8QctilY5KXbU5B4pWHpStRsKjm6eR1hnb9ht7PEhQ1w3U8QIrd/5fFI9envn7ga0ge4eq8AKRViAFiYBnUi334OxN+KsT+tbHcxOHOtTSeuSeWFbXgYtR1EY87yLL5d/2MXATW47vPucUfNuqnb/qU8lbuZz3AyLvYunN7IlEArg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pkdY41XR7cuf2UKzGzIJqRmchXHpV4pab8FY1ejd2Bs=;
 b=EEjlt5PsIdahyHGALH9Fmf1afsjPMSUO+CWlnAqTCjq7aDKlcw+gfv5F9uctNXRjvYeZRgjOSPb6lQXQrk1AzW0C2tbikdB8OOQ1oUeCYxplT5adhIP1cuJ8Ul8kstPo1tfRq5jgEB1y8FzoiAVNHML/bhYacU0CGjOW5t8iMmFgYMxcslUS75ECCWagjMJ9gDX3qGzZvwndLL3/FonMo0kl1mha+h8aPW0l2XYIaDlvJjIPTK/rL8ExfMyE7XWGmdj5O7riFs4KjFwVWGoEXPmSvj8LolYzts9o23Zm5dnNrLv4O13/KLcA54cCFgGrEPGd042f3ZfCcU00v120Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pkdY41XR7cuf2UKzGzIJqRmchXHpV4pab8FY1ejd2Bs=;
 b=kXm2+yyrfIfZf8cb/7hRFAr8dth499tie+3nZrD4fOe/5kCFGER1tEBSYAkyPf82Re6Y9eSSmgpTbB4FqIQKIlnH7svurOOvqeCbVdKBUtSMHXfPf8H5PhmvXk/KGT6Q683hZExLOzK/Cc4yT7NyDG6r99ShTfNoj4YyqE7iT52k/Aet9f/+5sAcC91oLWiKq1bf+tl6rqeXEaMxK6ajFC1gaptBKwohKtLUNVkxXzjJeKO8NauvJMGr+CGejOCdrgsnvhewVQBCSxi8LJfj/6kB3bJdkpUesM6vN+lGnox2Fk5slgTta+xLMTQYGSy1x4G88KgVloHyDTRoHzu2JA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB8800.namprd12.prod.outlook.com (2603:10b6:510:26f::12)
 by MW4PR12MB7440.namprd12.prod.outlook.com (2603:10b6:303:223::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 18:17:51 +0000
Received: from PH0PR12MB8800.namprd12.prod.outlook.com
 ([fe80::f79d:ddc5:2ad7:762d]) by PH0PR12MB8800.namprd12.prod.outlook.com
 ([fe80::f79d:ddc5:2ad7:762d%4]) with mapi id 15.20.9520.003; Tue, 13 Jan 2026
 18:17:49 +0000
Date: Tue, 13 Jan 2026 13:17:48 -0500
From: Yury Norov <ynorov@nvidia.com>
To: Fushuai Wang <fushuai.wang@linux.dev>
Cc: tglx@kernel.org, peterz@infradead.org, mathieu.desnoyers@efficios.com,
	akpm@linux-foundation.org, aliceryhl@google.com,
	yury.norov@gmail.com, vmalik@redhat.com, kees@kernel.org,
	dave.hansen@linux.intel.com, luto@kernel.org, mingo@redhat.com,
	bp@alien8.de, hpa@zytor.com, rostedt@goodmis.org,
	mhiramat@kernel.org, brauner@kernel.org, jack@suse.cz,
	cyphar@cyphar.com, linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-trace-kernel@vger.kernel.org, wangfushuai@baidu.com
Subject: Re: [PATCH v2 1/6] uaccess: Add copy_from_user_nul helper
Message-ID: <aWaMTOzgYV04EcaB@yury>
References: <20260112073039.1185-1-fushuai.wang@linux.dev>
 <20260112073039.1185-2-fushuai.wang@linux.dev>
 <aWaIOT_o-99G-_r-@yury>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWaIOT_o-99G-_r-@yury>
X-ClientProxiedBy: BN0PR04CA0152.namprd04.prod.outlook.com
 (2603:10b6:408:eb::7) To PH0PR12MB8800.namprd12.prod.outlook.com
 (2603:10b6:510:26f::12)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB8800:EE_|MW4PR12MB7440:EE_
X-MS-Office365-Filtering-Correlation-Id: d25f5b44-a4a5-461e-52f3-08de52d00f47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9vZPWh2QvRpNnFai/7rsZWTaF2QTzSbR9D8TvfyD7YBvbF98AqCg37Lr7PKr?=
 =?us-ascii?Q?lRPOU/bJKQOGcG8YJf8pkeFESxhjvG8wFHsNI+nz0JapbPu72tROVn3caFfm?=
 =?us-ascii?Q?OIoS1jZpDo10D7mRfQSrVM22eIhTGj+WX30OnqgE14KO3DBxiKKHBYMgWGwl?=
 =?us-ascii?Q?LGAAnc1kvLz3gh4pH2b4jJ9n+OIi8o9sYTR0plQSni/M5TdmTqni1NKpJkuN?=
 =?us-ascii?Q?gWb2DL7x6zmOPjwLJ+NXrdBi/W0HEk+iX35VMFgz0vbpbouegAeSWIO0EiYp?=
 =?us-ascii?Q?0qY8reaxxEAkL6E2n8E57Liqhsk0uhBpsQeuYgnqG0J6ePKr5iGNmVcs7CSq?=
 =?us-ascii?Q?HNEChD5txmN1otpbnVoFjGarUKYTiEszXXYrVoTVdfyH5EZeT8z+neC55bEH?=
 =?us-ascii?Q?9MTBiGrwv5sOyl2i12A+8yx0OXlVIRnZvcnvbN9Js0QeqacUeqW8d4q7U3XS?=
 =?us-ascii?Q?NXAOimsZeUGvXKOlZ9E1/Ea7gyfGz/8haDrY+QwZdm1Z7IzCkRk3YMgQ0qUX?=
 =?us-ascii?Q?EC2MhvhiL21bm9n29wW7obPDdraxqKbcRzg049G3LQJrGHJJD6cMo44vmomY?=
 =?us-ascii?Q?bDt4WYWy9+gTt9HCNvMBrObBmWHoBGmHm4K7kfudsBonUUYaww7vh3My8FU9?=
 =?us-ascii?Q?tSo5etMz10Z/aGMDMGV+jIZ7cgsz0jNNbYB3dtw+tzBi/4PULYqoA8clokUt?=
 =?us-ascii?Q?hgVR6h3H/NhruMOnV7SBIpXCyJ95wqS5Vs0ZjQ45SrawcWf+c3nE053m/6lJ?=
 =?us-ascii?Q?2xF3lbr8uqc+IMWlxQrfTkniOtwUOLy+1pKuxJwyiktJjWo5EL1A9TcUpDDF?=
 =?us-ascii?Q?Jnwyy0nARfKSJwPli7ghxZ9U6PmhAxPctBtAiAThgqIna6uS/Se70Rv6dzL9?=
 =?us-ascii?Q?R1qZMa3kMdcjBuGhirSv+sVLL5Qk8lIEF+x93RVzloBh9JOOl14Y2i5bld0d?=
 =?us-ascii?Q?fOM34oxyaTFTXSy3UDDP6e9z+EIx1BlKwrLUB+A0lVCDmgYRkZngPuW3dkmY?=
 =?us-ascii?Q?MXXyR2eOsVXAUhfyOGQ68mdojCszcMwfEaERDv40qzlv4ysEJbzWLThh+XWg?=
 =?us-ascii?Q?2jmFJChOJHDABk90p0iBxRKEo3HT5bLwMI3SI3qLaeweGfbhPCx3WDQw/jJg?=
 =?us-ascii?Q?a4e0lgP+XjXV6tljq0FJmhKGvj1R+P2aEE8tyJ0jeEouZn+6oRvqMwgfXtaU?=
 =?us-ascii?Q?ce9EBiAKoCDyYgBq+uzW3Lw2t/2JwufF5ZlPEBrX5EtBJVvJtwlSMfK8PNkB?=
 =?us-ascii?Q?kKKxK1aAd0o4isnQZz8PtA2LDBzwEax+2Y8Vg6sg8DKJQjsIB+t91oKnW2cX?=
 =?us-ascii?Q?hYecMC1h0QcS83YxVFKCa2i17k9GH7gJGlnT/hLBFq6S7nCx4Td3e/9y181R?=
 =?us-ascii?Q?7zJJW+Xjzb+Cx7yGyuVbpeupBMWSRSb3Z5SmvycLVpFWOHA2sZIEXsmccHEI?=
 =?us-ascii?Q?knztc35p5OeHlEPM1aKGqxnSJVfldwcx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB8800.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/Ml4dWwsqc5GNhipClJYYMqakLjyGg509W0e1krABi/MEWDEa7BAYyc1gnLO?=
 =?us-ascii?Q?IFHCNXRmY0JuqHGTfatfkc2SkIRXDHxtXyyykWo3M4MfOh8xUdpNeo8m32aO?=
 =?us-ascii?Q?Mg5AEPcEg74kgZKqTGubaCjAmqqz3O7DjW2NjQQtrYHkH8XeXli/l5HPq7Qf?=
 =?us-ascii?Q?4RmIIwz6TaS9wp/i1uGwubuPr5ePoO0Zqm7wfCMrf2jl90BrHrS4aeENMKVg?=
 =?us-ascii?Q?aA89i2zgiQO/GlyEpwliXDuby45h8OTWVmCdPmgC/8QHgf0Kmmhxjxc+hkZ1?=
 =?us-ascii?Q?VUa+dloHjW1vrE4h6CLQkGHeixwKJE+mSRROGX6+uJLCIClCy0N+CBdIN8HB?=
 =?us-ascii?Q?murlPPJokvyuFztmec2MHQx+K64rKsIiA/f3crNJ2d2fyj0pPizqg3OnX/6R?=
 =?us-ascii?Q?FJnCdvoB0rbB08Cbh8F+RJvD/ljbcco0dwy5UoyxAgdBpH7y5V/wMYcfVR6Q?=
 =?us-ascii?Q?EfXpuG2AwagCbCcnlNI2s8ypHkQzO+QIiJV9irWz+IGIo1UsxznAv6SwXK26?=
 =?us-ascii?Q?QYRiL90YHaNpC85qfNYRImgNZafATwWfA+nks/ZlrwZUS/AHpR4y/tNdnwbQ?=
 =?us-ascii?Q?5XVAwz3AUKg8l0RZFnbuqNCYww4LErHSl9QEsAWcPAsURjLedupzALt/PPpO?=
 =?us-ascii?Q?OyfWWbETbva57ks2DNLN66PDsms03bKLK2gcoS+B5yvqS1wp/7Ld0GHPnqrc?=
 =?us-ascii?Q?AR4RYnMV6gMRmdYxJHn2QtsufewZHdMw5zdC0ZpDT7AerFqVYsnQ4PFYzCPU?=
 =?us-ascii?Q?k8RoMizsks8Tv6J2AuajHwHdvm1VCiXmu53x7tSlUNpi+Z8LFZE/iFq9vGyV?=
 =?us-ascii?Q?H0e5YNknI62S/iw4cgUIptou+IwostJuqiLshxfqJmaYNWyykUhBt0gObbhe?=
 =?us-ascii?Q?HSr2f/ONxr62/Xx3qaXsgOCN3GWtDYoa7IM/pHJZLgnF+ogHncbgtZE9wwWF?=
 =?us-ascii?Q?UP5cwpjmfmwmygQ+cjm80EuKW+1xQWQzg7ACHjZ1lRN+YW6gmrAOb30UC3bH?=
 =?us-ascii?Q?MwfTRWWuxTqRfPkAla9ow0oZuPKmYRSvJO1Q2/arrk4oujM80DVI9lX2/OC1?=
 =?us-ascii?Q?kD8M6I27j6tAq3NZ1SvElspoAe+sAG3qx57IcaqWq2ug+KTSLqcdg001max4?=
 =?us-ascii?Q?8tj9xPVkaGdh8lOWSrW+Z1htDXoiGsR6YWsb4qTULDC6PCYeKgLSH606dM/k?=
 =?us-ascii?Q?5m7ehPKgFSseJWSvUUTMfdtvr3t2JFinr0OeA+UKd2sUFcct8+d6W4mwOq72?=
 =?us-ascii?Q?siiBy6Ahw1AAfB8jZ9djC4/WZ4t9RjtGaEmcBT7tB+bFqyhRWWeA6cI01MSH?=
 =?us-ascii?Q?uHEY0ExBaRlHhS9bFBytOOJzpFUsJkIpbh1o3uDJXq5/Yj3XssMtndrkaxEp?=
 =?us-ascii?Q?ERGb40OuEKvLGe1+xvwoM+U9Hd0tl2qgiFPjwgDBvpHN7SZGBz5VZqKtSEVm?=
 =?us-ascii?Q?eeqlKtbGF/W4od6EDHoc4eFfxUYBTDc4yfeO/EF9lLImaXEi/6IxwL3+Ll9p?=
 =?us-ascii?Q?Ilpvsa16I6AKBIJifM02TakLvWeIF5oA6QXTV9YX3vyE09EMdolK5RQ7GglY?=
 =?us-ascii?Q?s35WAsJfUR4/9y/gsOPHfQibSsjakWQ36EycJrV/YWxI1WLqoFMey9Wkc31x?=
 =?us-ascii?Q?z5seBg7zgsY+h3ck1NtaPoCFQZjDaNwqfRftHOwG/IuCWOMPEP1QS2Hq4TbS?=
 =?us-ascii?Q?NaFpUrTXsyMi3uP6i1E+vNEJlZMhi6DYbNSA6fjLttpy5dhG4eD5OybipYr6?=
 =?us-ascii?Q?+HND592m4rI77MxVTAygsEjlJF2zJY7PYUnMrXff1iuto/8hC30P?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d25f5b44-a4a5-461e-52f3-08de52d00f47
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB8800.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 18:17:49.7173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rJvNboo9VT9aCCp1RUrJ4eCPFzkQ6S9ScbN0PESU4WuaAxKTzaPRnJZ6SwBj+FBS3JtYKRA4avuxGkfw/BIfXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7440

On Tue, Jan 13, 2026 at 01:00:25PM -0500, Yury Norov wrote:
> On Mon, Jan 12, 2026 at 03:30:34PM +0800, Fushuai Wang wrote:
> > From: Fushuai Wang <wangfushuai@baidu.com>
> > 
> > Many places call copy_from_user() to copy a buffer from user space,
> > and then manually add a NULL terminator to the destination buffer,
> > e.g.:
> 
> 6 is not many
> 
> > 
> > 	if (copy_from_user(dest, src, len))
> > 		return -EFAULT;
> > 	dest[len] = '\0';
> > 
> > This is repetitive and error-prone. Add a copy_from_user_nul() helper to
> > simplify such patterns. It copied n bytes from user space to kernel space,
> > and NUL-terminates the destination buffer.
> > 
> > Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
> 
> I checked the cases you've found, and all them clearly abuse
> copy_from_user(). For example, #2 in tlbflush_write_file():
> 
>         if (copy_from_user(buf, user_buf, len))
>                 return -EFAULT;
> 
>         buf[len] = '\0';
>         if (kstrtoint(buf, 0, &ceiling))
>                 return -EINVAL;
> 
> should be:
>         
>         len = strncpy_from_user(buf, user_buf, len);
>         if (len < 0)
>                 return len;
> 
>         ret = kstrtoint(buf, 0, &ceiling);
>         if (ret)
>                 return ret;
> 
> See, if you use the right API, you don't need this weird
> copy_from_user_nul(). Also notice how nice the original version hides
> possible ERANGE in kstrtoint().

Huh, we actually already have kstrtoint_from_user, so this should be a
one-liner.
