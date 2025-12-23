Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020138.outbound.protection.outlook.com [52.101.195.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533BC2EF64F;
	Tue, 23 Dec 2025 22:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766528088; cv=fail; b=dd1BcWkhddlaIycU+wdXhBJzHlYR7m0gvBgZT/dgVx42Zitt4Edtl8ofOu1QLr4/nKp750BPVu25oEawsQjBuhwbux30OgAWkBbTjMam14sesGHOHoHzcimkgp5YeVw9Mw5XVAy2YkV6SVGFrIIn5GcKAPjxcNh7ZIEDV2dwmvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766528088; c=relaxed/simple;
	bh=9+/UvCDAVakQBkoBCygQt4+W1CZQcu5gFwIOef47Xic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XeYDbEtLvUAirZowGoMeluqF7rtrhtMLDYwvlqvjIkry4VzG8h7EiDtWzzSvFWrcAN7w4bthPy09px/lEJ45iZa4IKDuKgGmdiZxRFdNux+2emPiMqcfIo85PbK9K/e+HwSHodDr9s840G8zKbLlr5Tn08JTs0k3sNXgfn/ayuo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.195.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GJpvk5ltc5tDOCGmhivtFNoVMBm/jg/Q0x99Bhed+mP6nQnBzG1c5SrrObw94RYOc6X5e7I77UzzS1VMVQdI9Q3ULfyGnbDm//XgWawTG6AdtfXpxw5ZyWppF6hwwmgrmrABIVMvX0uP/h+cwLC5BNdvgelo/+cso4b12JfTEQzkkwYCY/zpehMYvnHNeqtFm4FPad0/47UXrCulpBrWLHVP1E5HYZgPFDHvky2JpGfYu1xOEodSt9S26wmqPhkID2expjnWgO3HFlean+BcQbjW9uJa//jC9bSn8D/KrfbJJcwqZPXj044o+j9gxqDPdgr8ZFhrdAMF5NQXq0RCcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9+/UvCDAVakQBkoBCygQt4+W1CZQcu5gFwIOef47Xic=;
 b=PiTeYVdgZ4T/Gn2Z6LJpfw5yatJ98hsUnbr1gMG4nzBW895TDnD2IBA4VEY79peUX5hC2cI2RjQM/OwRgPA7AA8oRh9WIsbsG+g7SbGEJ12JqK7fzpmr0dVx7reLllS/PXtzffDCLobbW5SuPkdztFWCWQt1MagsXVSmRFnd6Lk8qExdHOQMyHc83WTEG+jBpcVPRflh+R03bBr/WHH1ggVk4YUDwdE9gJDBlduhTUxDiwPOCUrINqih9t4qht38k6isCLU7oUjIPAlP4qXZqDxiKwKK2SDQI+vbNCQ3UfbVgDa7sl9HHOhB32LcX383DK8TiaPuSD4yRn92jUoJig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by CWXP123MB3270.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:34::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.11; Tue, 23 Dec
 2025 22:14:43 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%5]) with mapi id 15.20.9456.008; Tue, 23 Dec 2025
 22:14:41 +0000
Date: Tue, 23 Dec 2025 17:14:35 -0500
From: Aaron Tomlin <atomlin@atomlin.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, mark.rutland@arm.com, 
	mathieu.desnoyers@efficios.com, corbet@lwn.net, sean@ashe.io, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] tracing: Add bitmask-list option for human-readable
 bitmask display
Message-ID: <wgkjg2bpsyonl5qkgxgdrpmzzaduuyiti7vtifxbtdnmlrhptl@jchrtoaltfv3>
References: <20251223035622.2084081-1-atomlin@atomlin.com>
 <20251223133452.416fd539@gandalf.local.home>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aq7iusvm6mdpkhjg"
Content-Disposition: inline
In-Reply-To: <20251223133452.416fd539@gandalf.local.home>
X-ClientProxiedBy: BN0PR04CA0130.namprd04.prod.outlook.com
 (2603:10b6:408:ed::15) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|CWXP123MB3270:EE_
X-MS-Office365-Filtering-Correlation-Id: 70123868-dc31-41a3-afdc-08de4270aa5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TGQxc0NCZzdnTlVacmczZTFmQ2VHRng1ZVBpRnhHSGw1VitZV2R4bXljczhK?=
 =?utf-8?B?aWptMVZ3Nm5jOFp0U3NaVlo0bVpkekhBeHJMVFoyS3ltalIwdWJQWnYvMzdr?=
 =?utf-8?B?djZuN1M2L1h0cjhUTFpkOXBKT3BNVXNMRGNBMVpMbmpTKzZ4dW9wNThUMlFK?=
 =?utf-8?B?Z0pjRUJxc0NFa0J0MWhRKzVGUGhtbUlWcjhNblgrbWNPQmNtT1M2cVJlR1lM?=
 =?utf-8?B?Mk5QckZVRC9HMkwxNTY5SDZxYjlLWDdISFNRMHB6aDFxSWZDdjh5WjVVdFp4?=
 =?utf-8?B?RWpMT2pTamM2dCtSRnNDS1p4TGFOODhQUVArblVoSGhqOWVCSEpoQXZsMXd4?=
 =?utf-8?B?bEQvMEIyU1hFQ3dPTm1SV1dCb0srbm5HbnRYYkRTZ2tUTk1sUUIrY05nVWNn?=
 =?utf-8?B?dkUrL0xZdm4yTEM1TVk4ZGg4WWRzeElHdk1LWFQ3UmJ2bzliWkRWTDhSQ2dY?=
 =?utf-8?B?cC9IZEFRUWtoajU5clpHcUpmSElYdmVCVjRCaE1vQ29IVFZ3K0RZTHJSY3F6?=
 =?utf-8?B?b3JvdGVOVDVsdXRYTVBaTkFZbkN4WHF3VjBSTkJ2a3AwbmtKemlLOHZaOEpJ?=
 =?utf-8?B?QzBZM0hyeU90ZGNqOWp5MEFuaDdZR1BCUWEyaWV5OFNwd0pZWTNtMGRtTHc3?=
 =?utf-8?B?WGk1VWpyWGJVZ3FramMvYWdxQmtBdGJGZThzSFd6MFRDRDNHVWwrMC9yN0Yw?=
 =?utf-8?B?eGJ4VXBmdVZGMVhwM1RYclE3YWlKOEE3bXVHMSs4aEttaDZ2RHRjZndaRmNy?=
 =?utf-8?B?RVJ3cEFnTmNicTNZOWtUcGdEM3Qyd24zNEc2cUdWWHJQVjA2Vy9lbjByZTV6?=
 =?utf-8?B?S2QzWEd3K3JQcjFIUHVTeVpnZGZ6aGFMVVNvZlBjUkVGc29RMk1UVDlmVE9B?=
 =?utf-8?B?cSs2SW5aNWlYTTBnWXVhL3Q0Z0Rlc2RaYUlmVDUycXdxYVFGSU5IMGx5Lzlx?=
 =?utf-8?B?SEhucUlIMnpQUU1TZXVNOXMzSzhZWkdDLzdCT2hvZkZzaUZaZE5ITjRLdndp?=
 =?utf-8?B?TDkvQjJYYWh4cUVFaGRVbGxIU3RMSkxIQTh0NTU3Vjg2WGdoNTJSMStVSUpy?=
 =?utf-8?B?d0xOWEpMMlFxMXRFVzFQQW0vbkdpVU16NklWc3k4aXdYK2g5SXYvL0ZGa2tt?=
 =?utf-8?B?bDJUZSsva2UvcmFxYy9SSzY2R1VETzhrU0pDNGRjVXRkcCswdUlIZk5wMUZP?=
 =?utf-8?B?OHFOYThkenFCRHJHYytPSFdRRitrcFNsNWFoV1BNQzJLNmlHSS9mQjZwSWww?=
 =?utf-8?B?RnNUQUpldFdxdVNSaHRKSXQ5V0hGU3AyUUczL05vc1BtTFoxS1BqUFdQbFB5?=
 =?utf-8?B?dEFwMFFBRGpYRFQvVFpha2hQcC9jUW5zaG45a1dDQWtGWUQzVEQ2K1NKNVlE?=
 =?utf-8?B?ci95MU5Tbzd1VEJpcHlWeCs0dC9pb2QrYk1XN3JNTEJOVjMrK3NFNk44SGcr?=
 =?utf-8?B?R0NCb3JldUkrNENwUmlGYTEwOTNQR2JVTmlPbitxLy9uN3lnNFNkZkhrSDNH?=
 =?utf-8?B?a1J3TDg0a3hwVnBLVzBnemEvRTBKWUVjUWpQTWY5b1ZBSXNrcThKa1FYc3lP?=
 =?utf-8?B?VEViaitQNmJYd3pET1BqMk1MOFdXdEZ6L0dyMEtzaThOUnFRRHhZaE95eDU3?=
 =?utf-8?B?N3BCT3JZUHBmN1lPRDhodlo1OUVDdm5SMU5keHFDZm15bjRJVDlrb011eFlz?=
 =?utf-8?B?Tjd1V1hRYmErWDNSUDZYTG5nS051WGVpMlVOb1FMNlhHN3pzczJsbWJlcDRM?=
 =?utf-8?B?dXNqME9oTW02WFZSeEEvVm91czRWVlJYdVdnRFdLanNyQ0xCNVpzdFhnSVZx?=
 =?utf-8?B?b2c1M29YblJwTDd0REVlSXlTRkR2QlJacTY1NzlFWU0vNHFqWC9aT2JpK29n?=
 =?utf-8?B?RWFybncxQldjdzdwWjkxZTlsc293T1NzVHh3c3ZiMmFncWVkN1AxWklnRU5P?=
 =?utf-8?Q?+rjjC2YP+cQ15ZnXV90f7va0UMmSqegv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bEhjTUtOeTZUTkZrQllTMy9DNXRYY1gwMUdDcWtCN2xlSUlOMmllZFU3cWU1?=
 =?utf-8?B?NzNydC9HNkNITWYyUGlydUxiWStFTEdNRHlPN1E5RVU5S05oQnc4VjM1V1FO?=
 =?utf-8?B?QlNPNWNGQmVoa2RKUjhGejBsTmdQN3dueEVsS2VqUndSZ3NqYXVxS3g3K2RP?=
 =?utf-8?B?YlBBNmZDdUlRakFWUjhtNkdCaDlPVExKTGZtTmU5WDBudnZDaklmdnJmTVR5?=
 =?utf-8?B?MzJ0TGwwYkhSSDNMbmRPdWE2MUZZM29LY1gyVW14bjJjNzVVZllZZFY3UzdU?=
 =?utf-8?B?enMvUEFKdy9ZclpqMlg4bTR5aTYyQjhaYktRZ2U5dnN0eTBkc1MyWEZGTXB1?=
 =?utf-8?B?UkxBZVhwcUJmaElUdE9qazRlb3FwWlc5WDJKVHFlQVMvckgwQlkrZ3hXOThF?=
 =?utf-8?B?Z1FmUW5XemdTSExnWmV6QkJIUmlZeDlkL01VRk9ZenpBZ2Z0ZFVsTGVleHpp?=
 =?utf-8?B?VUtmNDlMSWpybGlOS2xPQ0ErWkpVZklST2dsb29HTk1jZU1ZM2EvQVYyaWFF?=
 =?utf-8?B?eWh6Zmo0SHVIOWJNSUdNTWR3Y1l0dW1KMUhlam9pRkU5Y2RFR3FWVFBPOUs0?=
 =?utf-8?B?bmJxL3B1bWk0N09JNnZaYWZ0clp2b2lXYmoxakpnd01LU1NERzVBZy9Ud3ZR?=
 =?utf-8?B?YmU1MTZWU2JINWlWbVdzMFRaNFp6VWNHcWJoQ2E5WVkvVi9ucFN5eXFpcE1M?=
 =?utf-8?B?YlF5UHpGUTg2Rk5zUjZvTzB2K2hxck5hRk5SanJsTjJiYjVCSkZvMnNoS2cv?=
 =?utf-8?B?bnNZN2pCc3c5Ukwvb2g5TTdzQ0d3SUdPeDVLa0xlQzh0K2oraUJGbTc3Q1py?=
 =?utf-8?B?UlAxNEdxQWRGdHY5ZUZLVzV5WHcvSUNPbUFJaGMwdzcvaklraEt5TXdIMVlu?=
 =?utf-8?B?VHhxbUN4RzVTbjhwWGlsN3BXYXR3RFhRMlQ3WEN3SUlhNXpCd2N1cGxrN1po?=
 =?utf-8?B?cEtVZGJKRFdsa3VtaitScVRhR2ZkbCs0dDBnV2w5elNJaTZWbkQ3Wjl5V1hs?=
 =?utf-8?B?WlRMZkcrSU9RbWVXdUR6dHRaRXVDbnRsTWd5RU9EK2FjaTUvckV5dXJNT2hi?=
 =?utf-8?B?OW5MZzRJSEdqR0pSc3JYSHlNa0RSSDlYZlNiRUM3bkQyYTRQRk13Yng3K2xh?=
 =?utf-8?B?REJJbURRVGZ1dVJ0M2tpSWN2bk1XdnpUYjdjY0RsZXRKeURmdW5sRVVRdSs2?=
 =?utf-8?B?aGZiM0Z5UlI5VExBUUgrWEJkSUZMWkUwdDU0RXJxMUU2UmlrNVc3bVdnT3Yz?=
 =?utf-8?B?RTBNSjFzVVN3a0Izck41WVJEbHdhQ0xNQUJaVzNvcC9LZFNNVUU3SEVXM0x2?=
 =?utf-8?B?STNyY3BvK213UW5lRStmYmp1bVF6VVh6M2Q0enZzdlVTRFJMVW5jZUZJN3Ji?=
 =?utf-8?B?QVg5YzZxSlpXdFk5MnBJOGlDbDNINkhKNlBNblkzSlZ0NTBFR0h0WTBSVGQ5?=
 =?utf-8?B?SFdmL2tiMWtBamwxdjFiRDBJendCSldiaVNuL295bGlpUHh1NlVSVHN6dHBq?=
 =?utf-8?B?dG43clNvQnVtQm9xWWc1Vys2OXhTbXRkQzN0aEZRckFGTUNsWkRSbERTLzV4?=
 =?utf-8?B?SUZ4TnFWNzB1Q3RCUndqNVltRVI2V2RZYTNRMHhVU2FEQmVMVFpFdkxPMkVq?=
 =?utf-8?B?UFllMlRtZnUrZHBrY0plOXVnYW90eEFkaGUxbGwwbXFYZnpYMkhjSFNmQmVB?=
 =?utf-8?B?S3c0dXFPWWx5Z28vWFh4OUVKMmhKWTVHVDFhRHN3TUFTT1pPZzZuL0ZwYXMv?=
 =?utf-8?B?cHI1ZlFGY3dFTzRHMTZoMWRmYU0rRVJwbzlFNzNLdU9MYUt6WjQ2ck43Rkpl?=
 =?utf-8?B?dmZqRS9hd0o2Mjkyb0ZsYisxQkIyWmUwOHRYNmpaRW1JUElVbmoxaTlSL3Nm?=
 =?utf-8?B?TWcwTExFdklCNGNaNWJFUllvcnFPQTZHWEY0VFpoOTBBSkM4anN1YzdDRkhm?=
 =?utf-8?B?NDlXVEVZQVhVU1VpVHNwUksycnZPcUk2dGRhTy9sUS92aGlFWFF6VjVBOWo4?=
 =?utf-8?B?eE92M2ZaS3Vod1ducENjdlhxUWlOcDM3dlZUN3pzMkJhKzlhdnBEY3MyL3lM?=
 =?utf-8?B?Z2JXeEp3M24wb3lYV0pKTWxzeTFDdW1WblNBa0VhVG5BQTRleWF5bXBSeTV3?=
 =?utf-8?B?N0RVOTg1bGtvWGtyYk1rTTVsYnJ3OTl3WmR0YW1vZDV5VVlvdmdpRDd2L0Yz?=
 =?utf-8?B?RFJSSU56R3JHVDV2aThna2ZtdHlIY3h2MGh5azVPVXBxb0E3dURPT05URHZj?=
 =?utf-8?B?b2lleXRwc2d1WWxMdUZVWWNMMDgxazMxT0JTWlhxYkVUdmdSb2pGaEI1dExt?=
 =?utf-8?B?V1dnbVJzd21OOUwvSll6Qk5VY2gwVjQveWZVbTdISEtBSGRIMWY1dz09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70123868-dc31-41a3-afdc-08de4270aa5e
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2025 22:14:40.9592
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6vATR67bkfY2tTlj2tBoMD3w9f8UD8GXnNeOVvIwFgrdlTTtYJVtKvoKJEAyJXqyeMyi0d08unTeGGpsdZ+q7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP123MB3270

--aq7iusvm6mdpkhjg
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] tracing: Add bitmask-list option for human-readable
 bitmask display
MIME-Version: 1.0

On Tue, Dec 23, 2025 at 01:34:52PM -0500, Steven Rostedt wrote:
> On Mon, 22 Dec 2025 22:56:22 -0500
> Aaron Tomlin <atomlin@atomlin.com> wrote:
>=20
> > Add support for displaying bitmasks in human-readable list format (e.g.,
> > 0,2-5,7) in addition to the default hexadecimal bitmap representation.
> > This is particularly useful when tracing CPU masks and other large
> > bitmasks where individual bit positions are more meaningful than their
> > hexadecimal encoding.
> >=20
> > When the "bitmask-list" option is enabled, the printk "%*pbl" format
> > specifier is used to render bitmasks as comma-separated ranges, making
> > trace output easier to interpret for complex CPU configurations and
> > large bitmask values.
>=20
> Hmm, I have a couple of issues with this change. One, this is global. It
> affects all instances. The other is that if this is going to be done, then
> instead of adding a parameter to trace_seq_bitmask(), another trace_seq_*
> API should be created. Perhaps trace_seq_bitmask_cnt()? And have
> trace_print_bitmask_seq() call them separately.
>=20
> I'm still not convinced that this is needed. What examples do you see?
> Should it be only for CPU bitmasks?
>=20
> I think a bit more thought needs to be made on a change like this. There's
> other options that were added that I now regret. I don't want to add
> another one I wish we didn't have.
>=20
Hi Steve,

Thank you for the feedback.

Regarding the scope, I take your point that a global flag is perhaps too
blunt an instrument. I can see how making this instance-aware would be
preferable. I can look into refactoring this to ensure we pull the flags
=66rom the specific trace_array associated with the current buffer instance
rather than the global state.

I agree with your suggestion to avoid polluting the existing
trace_seq_bitmask() signature. This would allow trace_print_bitmask_seq()
to branch between the two formats cleanly, as you suggested

As for the use case, I find this particularly invaluable when debugging IPI
latency or affinity issues on high-core-count systems. I typically run this
with the "nop" tracer enabled, focusing specifically on the
events/ipi/ipi_send_cpumask/ event.

When dealing with 128+ logical cores, interpreting a raw hexadecimal bitmap
to identify targeted CPUs is mentally taxing and prone to error. For
example, if I am investigating why CPU 6 is being interrupted, I might use
a filter such as "cpumask & CPU{6}". Seeing the resulting output as a range
list (e.g., 0-7) rather than a hexadecimal bitmask allows one to deduce
almost instantly which cluster of CPUs is involved in the IPI broadcast.



Kind regards,
--=20
Aaron Tomlin

--aq7iusvm6mdpkhjg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAEBCgAdFiEEeQaE6/qKljiNHm6b4t6WWBnMd9YFAmlLFEUACgkQ4t6WWBnM
d9YLpw/49JHFJqZq759DELT2nb0gQ2KICmrCyrEJIXxfNy4M5MOz+CUyJ/Ebb8M1
hjFJ3Q8LKn7kO3Vkmtm+8EzS+pQ5Jsv4jwSP6PJY9SNSZusfg32hnopy0l2mxJbB
xEKyZ0ox/bANoXaIrVOabjYAUY/9ZGAsW7juTtZ/akwFq3t0FlOdP8/V1ce8Q4IB
BdejCZJ+NQTFSicZ0N/vLFLfhdcjY58b36M7oVqVQg5MphV6dTL6kYSvFYS/8nZ6
M+ryUADl35YopxxKrCoYw3u4mcsltG5lT/wcaQHRLVgBsbrJYiK4myv+LpY4Yz/N
KWZC0IIznNQvFMhfbP3kF2vNBHHa6k3lDi7+SBnnE41ct4MgftTy/wHRaifXXkCW
qTJvAkOo+TBFwgv52E0RS/GTFZobqpFohft70S2RLr+OQGiK9MqkZFIjAYYv6Q+P
EU/vGhKTH8DhxQNWLxf4l4n4MpmfE8kGasF+kv5rxjtWyXwoxlIjtxZQPe0YYzOq
gpXZ2XI5//l4gGX9m/ZXgyX7wyCQU/arGQ+ipf3Q1fu02XPU95gUUACTvOgLnrke
9aZz+iX81wJd4PyAAEbxgs0r46ZFuTsGWfg7Ge/Gn8lTzuCuThRY3J5/Jx4lbH86
Q9+bnjZr5Y78YDr5/VEyRXXSOTdPRoQ2VAAr1dZooJyFHcxUpg==
=xe4f
-----END PGP SIGNATURE-----

--aq7iusvm6mdpkhjg--
