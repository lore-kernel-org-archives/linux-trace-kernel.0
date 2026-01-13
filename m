Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012003.outbound.protection.outlook.com [52.101.43.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AEA34FF75;
	Tue, 13 Jan 2026 17:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768323921; cv=fail; b=lWL2ECWpCMmYa37Hb8qCGTM2D7fBr4R5poq8RnSOwWeWpxEM6FkcWBkjDQY0rCL/E9dtHTWPB1Lo60Arc+EWnZdpPHAnFs6XElesJeTsw7ymhRIEV+D6MRFGxcRtbr6IZZILmNZMSRXqE/aq+9bLADbrJNlTYxFW8eAuY3NQpTw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768323921; c=relaxed/simple;
	bh=5h0ipY0gx0ybD3k9nQsSFo7Ts0TPrXkQHxrWKBv/ktY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=vDBEBsJ3ckNfIzHJKy3n6uLX9hoj0iq6orxULTAWUC+0DxQ2M37VAwDQsEpHxImuRGOulHS9d+8BUzcqrIHebNHD/G0UbhnwjC/n9nU/4ihlLvew7SbicujCGt5IZjrqiaiUdwJcGHPp+f/nnayeVPfU6iyrFQqLcqihL8V4fqY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GRkX/I00; arc=fail smtp.client-ip=52.101.43.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GRkX/I00"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mTtmvmI5BbfGvQAujkovnWCKyxbF7xWm0cFF6WS4DDCyXqi1UZOQWaJMRLk3NR5nxgxBZ42yftwSOMbF1Q4ZFj9GSkMllC6h8OLT3NwZq9cPsfWQpUffUQbYc9MIKQc065NL/NX4S9SuGl+RJZBtp3jLjBjCLwK0F3bKWiLCb/o4FTneTYqFKYHztSpyWCw01ZwMRY9B7SJa33voX64LTvhunhrq9M9MVRVhThbdK2YCHAPiUQ0uwoTN07qOSBScE4O165RZ4GrJqwmQ3RWcE+AndrN3py77YSa4IVbJ0MU7cP+ZX3woQmR3G4nDDxWQCAmew5pt+kmRSGAwVwygcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UuIa0rS11qZ1jqsKIiwVBpE83f6TJuoEvnXHYOg35ME=;
 b=RQ4NynaotslsSN1pVwGw4oG2bVeZhmay0yQWuCYJVgJOUkfqd7IEeG3OI/TNGPVOINEtlsbKaJ9smf8sl2fb8MRw6ahbjCtH+1ik9uza+n/6SeCb+qmaV81nSiGS+Cjv7pb2lEka/lNj6uQVsy4H3l+nYlB8a06pDwdytl+UFea8lWILcATjRdFD0W9kshfpl1LqGi8tm6rJOM/yxGW5cSiAEx2ojFyLVSh5k7uCFJzdoFmSGAx5DDB5qug9QeXOoONeAYdoGMk/5+Nz9h9rJymawLY9ESRXrt2uZCeSLmkUxb2Q1q2wSJr3mE+6T94Uztv+lqd4IUObspU1hAnuow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UuIa0rS11qZ1jqsKIiwVBpE83f6TJuoEvnXHYOg35ME=;
 b=GRkX/I00+a2tuvm7g1IumH5nIeplLZCzF126JmodkDev11jUqZ34xUJZCo4pKvR+NWyj/ETO6Py8+NFx9hyy4GRkbr3P8pDRJzNAl6qlzpNI33gJMwlbPXvXeuhYs+qFmQf2epnoYQnoYrjCFvGyPtWpTbs8NJHzw80TcJuehQDDe2sfcxzkLUus1o9559JtC8wgGrjNDTr+mJqt9MtyCGrs/168doZ1LMYk1QII0VO35q/7aToNzgidGL4gM1378c92igSP2gFEF8J9sfG4JR+cbZwEzMWdEVnUvcT2Yan50X1d5TkNZ7TJcH5P7Hfe5apMdeSjPD8X9dd4iu9yJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB8800.namprd12.prod.outlook.com (2603:10b6:510:26f::12)
 by DM4PR12MB7622.namprd12.prod.outlook.com (2603:10b6:8:109::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 17:05:17 +0000
Received: from PH0PR12MB8800.namprd12.prod.outlook.com
 ([fe80::f79d:ddc5:2ad7:762d]) by PH0PR12MB8800.namprd12.prod.outlook.com
 ([fe80::f79d:ddc5:2ad7:762d%4]) with mapi id 15.20.9520.003; Tue, 13 Jan 2026
 17:05:17 +0000
Date: Tue, 13 Jan 2026 12:05:13 -0500
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
Subject: Re: [PATCH v2 3/6] tracing: Use copy_from_user_nul() instead of
 copy_from_user()
Message-ID: <aWZ7SXpUm8TwtUIT@yury>
References: <20260112073039.1185-1-fushuai.wang@linux.dev>
 <20260112073039.1185-4-fushuai.wang@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260112073039.1185-4-fushuai.wang@linux.dev>
X-ClientProxiedBy: BN9P221CA0017.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:408:10a::8) To PH0PR12MB8800.namprd12.prod.outlook.com
 (2603:10b6:510:26f::12)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB8800:EE_|DM4PR12MB7622:EE_
X-MS-Office365-Filtering-Correlation-Id: a7935a25-98e6-4fac-a700-08de52c5ecd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BAI8pEWsgliLzi6s5M2cbkTaYZ/VW2ffexzXpP66tNmQjskIgYnvOXGLSn28?=
 =?us-ascii?Q?vkxZysppqK9FM78ajOGkP7WRZiNk/vW6hV8MNCwdCN6dGolgTA9gRJu/14ut?=
 =?us-ascii?Q?4DikdKyxT6BmlqPbX8B6DAmTGzv5rzXAYnG2CCD2rFP9hKokyUQOCzbuvUfn?=
 =?us-ascii?Q?DOZXqx3M4cdYojkqjYqfeKnwl53eqy1qIBM1tpCAf+jz3YXjiLa46Nmqoqdk?=
 =?us-ascii?Q?QUG8UhyCM80pXDtpEDF8nhKY5I618WN60FG9fTigLlYVemiI9tA6qlwDLSFs?=
 =?us-ascii?Q?mQsZZG6FE0UDDww5a5VwSsimytRZQ/VPeSBmzZsPjLEydM6O1LR/M65xxlRB?=
 =?us-ascii?Q?lD3z4EPa50vsH6LoAC1xN6j75xEX2ObczZ9jStEmF3x8ZDZOENN2rbI/yz+S?=
 =?us-ascii?Q?cDhMF4NgFqaurBCLDIagEUSx+smrE8u5KyPuxWFHAMXJiFcO/73E86fKhvSn?=
 =?us-ascii?Q?jWeA29y3uLN+cAaPxmYSw6WRhFJ5paaQ+cdtHCepyAr/+ujPh/zblzHxflyZ?=
 =?us-ascii?Q?pHE8qu3box5L9wOcBlv7FNNgHJY5Z4r/ivuqRWohvkxf+7J2qVonkxEwrQq4?=
 =?us-ascii?Q?i6uu/FS1Q5MzNI431Wz1/ppEkAgaKFU8yOf3Ha8Qoal2906TmtNUzTCWx8j5?=
 =?us-ascii?Q?UjMCZrBwgr04WgHkPibOe/Oc8BSY3VY3NF2l9mQTGnsbXEqg8NrlLA/rSG4c?=
 =?us-ascii?Q?E18it4FbdibH/G/dZNiq+t5qIXefmBxLUgxHbQ+/92+kW+hSwD3+z266wFXH?=
 =?us-ascii?Q?t1nxxa+KodqbcKVs+H/IyyaOc74mU0XhG0aepg33+RqTxnWpOsQWV4748x4c?=
 =?us-ascii?Q?33LKc53V99j3GhsKyjXKWxtzmFsrrJ14k+YHmTWJFcaX09S163y1U0iC/hxC?=
 =?us-ascii?Q?ODlc1cGFjHFWU0PElKTqaIlBTTi2wHQHIQDz3tr0frR922uAS7ksQINB+XkV?=
 =?us-ascii?Q?+S9SnCB2OZzuh52aadPW7h5am4dHemAHe0TWQ1lPHfarpfPjU8xwo2N2/hjq?=
 =?us-ascii?Q?KKVgFZJMBU3zDJIKkrnrVLnHPIYDZNGZdrG0q6ct5RZw8QC/5CIljUxBhv0e?=
 =?us-ascii?Q?DcvZbuhZ5PUeCAUHFiTh1SAifDaZhD+McVG9YFIu6XEC9fbHUkdgydWkUZQO?=
 =?us-ascii?Q?r/a/cV5lMX9M1f/ZzDwapsD8XwjEH3qfZf7nmDjqpD9Or7HJs4PDVwOje5oh?=
 =?us-ascii?Q?qCVuWiCwg21AMKfOGkwf7Th4CrAEPFiRJA6KoVMcKt3tCb8YKcK8KiCXS9Kz?=
 =?us-ascii?Q?lm0O0b30w2pJ9bibP/l+XIGMm/8GjROt83Vm3NU6PBQoS4QPXSuA4RXL6ODt?=
 =?us-ascii?Q?z3UTL3/n/wn36QaCWjvrrl5mjftlzHPRbmplXLd4fz7fpTb1GxNFIdT2G6xz?=
 =?us-ascii?Q?i1cFjWe1l/vk5IYzshB9bvgXegH5Tu+FL1evlvPK2xDRV7TWsrDOC8fOte3M?=
 =?us-ascii?Q?aG8OVqSM7lvQQVPK3NqBMDPJRmrqbzru?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB8800.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+wqdPJ4JR6QzrsFnaj5XiCBdS3Slgl9ixbnYsg0YcmR1ME1WFKQbUFTWmKCb?=
 =?us-ascii?Q?h4WchgcuaeMRgAw96ilZeXCwwsX2FHJfFqzUmdsMR4Uwe65nnjdH3X9UimJ9?=
 =?us-ascii?Q?KX3s2gv9LrtIT9jqxaR6zl8SqqWaUSiIDmft7gi+EoGVQd/Gs45BPyMu5FCS?=
 =?us-ascii?Q?Wg+3dB0lvfC7Y793ku7NWPcIZjcfHe7Id9dfLy8YGzP66bBENufTluzedRgk?=
 =?us-ascii?Q?zi7OYPHndlr3f5dcZCgFqMf2ncRnDlMjPb9BDqrPJ827TiYmybvaSVZbW1pb?=
 =?us-ascii?Q?Oau6gmjCEA7iGSC15Mqci9lhh6uYY1xFwuGIdJ3lwZPJwVwsv9lKkUOEo6ZF?=
 =?us-ascii?Q?4Hk9n2RrunO3BtXbuK5ZVkZ10qhGnBz9yWs/yBuo9o8TfHBcqz0vQfhUz840?=
 =?us-ascii?Q?QPDg5vUTcPwrhGFJIyUG1yN3JufsAgpJ9ZHHJUg/LDHY2ifQ7uQIOXxLlarn?=
 =?us-ascii?Q?BT55aCvpF7pe2u6ZctdCJfMd3o0a4EhCINBeLlwGFisV1gScAljt5QmPKBHM?=
 =?us-ascii?Q?j+J8SuqUKoVmUdDiPmrarZMR8Rdoo3Sye2dbfvOwuhfArmqU98GwCc31BMmI?=
 =?us-ascii?Q?euKbQByZvpc5tU6VFliqHZ37NJDUqS6UK0KNrgMOYOdCkkr7XLjaj2zLhoE9?=
 =?us-ascii?Q?8AXQ2WHRNzP3JxjXvF92aDfBJzPH4lrExdvFowMXwuQjjsP5D1tputYCInCO?=
 =?us-ascii?Q?4j3VBHuJfl2ZcC4skzrRgjb1enlsjZBAkjN3LtfspOkROSs77bSj2G8mOEDu?=
 =?us-ascii?Q?AP1O/tr373LaalmAUs1XPM7z2AxYbLGFsqYHX+wlD0deJuQbZ8sbmvhKNFPJ?=
 =?us-ascii?Q?XNghEqhP5HWp1txg2Tfil8jpFqcy3sA2X8xHBHTCNxx3X7l4LoRH8JXdDJzB?=
 =?us-ascii?Q?qRgAnmnh5UMeP0tyKN/iH+1Y8BbnpAUljhTaVlu55rZ7c5sddZzscPnpGiLk?=
 =?us-ascii?Q?oUX1+FMurJNDwSmAMftQowWRyC4czZ4U5cDkx1Msqwiyn1VylpPJhHslvuio?=
 =?us-ascii?Q?Xy805jEImm/FOy7bPy6inJhy1sSgi5aypMJyuDBhfFcXMfHqrVsAJEAO045a?=
 =?us-ascii?Q?8HM7CqKTwjPuzzO1S8jpjhS/cR84YA+93oxBwGlCwEJv0t3JkOTcdkcnc4ei?=
 =?us-ascii?Q?/E5ThOx5rHOLXbiRs9b4V3g3X9sAmuhJa7dlg9k5qpLxj3Vugqdi/DTU6jhR?=
 =?us-ascii?Q?UiVERsrmQwk1F5IgGkwetvgpXeCdaMJIXE3+xpSCPpNNr6hvHpP0FW7q+7Lv?=
 =?us-ascii?Q?Ll3+HiDnfdzcdpl79rnmVJAN2Tc1Gvtq5ynv/7vCohgSP8Rr1NV5a+jK9DMD?=
 =?us-ascii?Q?FMTY2Z5ePcoi72QxJlciIXvWINQOfyj5hXy0gRCwJ7VX56PQxEhK19qo0Qgr?=
 =?us-ascii?Q?4NXlayN3Gsu72bhbPxna/z22cwHcIhriXniwPZ8gHXQB0VEaAlitnBzpfIj+?=
 =?us-ascii?Q?ftawXwQJaYpcm/59urhwMp2+KdACTPp9KVVkLtrwZMBl9hPKX5Jkt2Butayf?=
 =?us-ascii?Q?nYhi3hGqc4MjMnoazsQVjgsVWtdkV4eLm69ykFavNF9fbk3tWD40BkY7Lqza?=
 =?us-ascii?Q?CuTwQL/L8ZoeN+C1wERger0mGKtswfEzMXFZKz9A/kmcobFMoF1ZFHTtIRIr?=
 =?us-ascii?Q?8COmu7SxcUcP7jk1j0TkDL6U+ov/pvt/aYy/cUdEby13ZwxG8h9usDb2KsCo?=
 =?us-ascii?Q?h2ZBdIEb5FeLken8mwJTf5OTLV/cFEUa0ycI+KfkgYXDSlRSW/chm1ArUbkb?=
 =?us-ascii?Q?nDd31JbSJul3LcEcmjhS63ZTe8vLAWooxFFNCifdCoH/neGsH1eD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7935a25-98e6-4fac-a700-08de52c5ecd3
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB8800.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 17:05:17.1971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hlE/GxmROWP77Wm/AC38Z5TVwTu8iVK8O4vS8P6GbanB06OH2j/xZ5hM+hFEEOG68YdcJqE70WTU1hzKTxiYhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7622

On Mon, Jan 12, 2026 at 03:30:36PM +0800, Fushuai Wang wrote:
> From: Fushuai Wang <wangfushuai@baidu.com>
> 
> Use copy_from_user_nul() instead of copy_from_user() to simplify
> the code.
> 
> No functional change.
> 
> Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
> ---
>  kernel/trace/trace.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index baec63134ab6..b6ffd006fcf9 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -11266,10 +11266,9 @@ ssize_t trace_parse_run_command(struct file *file, const char __user *buffer,
>  		if (size >= WRITE_BUFSIZE)
>  			size = WRITE_BUFSIZE - 1;
>  
> -		if (copy_from_user(kbuf, buffer + done, size))
> +		if (copy_from_user_nul(kbuf, buffer + done, size))
>  			return -EFAULT;

This hides the original error. Can you switch it to:

                err = copy_xxx();
                if (err)
                        return err;

I understand that in this case EFAULT is the only possible error, but
the above pattern is really error-prone, and is reproduced again and
again over the kernel.

> -		kbuf[size] = '\0';
>  		buf = kbuf;
>  		do {
>  			tmp = strchr(buf, '\n');
> -- 
> 2.36.1
