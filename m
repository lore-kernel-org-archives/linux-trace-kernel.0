Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020101.outbound.protection.outlook.com [52.101.196.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C670919F464;
	Wed, 24 Dec 2025 00:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766536931; cv=fail; b=MnsfcsB0PgBKDydyiZ0mHiu8h/a75InOI5NM4tMGoCG4+Kk26ewMrMZHWsv+sEQzO4KXNeJmmYi16HOlWwMWMM9LZPbua4+Wtkds5FkjWTbk6Hj1qfX6Rix5C28goHUjwX9pWWdgdphkP4OzVYTJfwICcK9j8UN7jMYZrnb7QJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766536931; c=relaxed/simple;
	bh=qs+BQkFbKHtE0XytV9IFYOdBtWJhz5cFA3Dz6BHQ1D8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=vAtfclIwIye6WvZtPAOh7M+lbt/v6EtWA1rIOUkADgL0FTFe5JtBUtE0Gaudgm9E37r6ugdlgOovBu/kDthly8KW1S+AJ4owPw9VtRlMeFcUKy7ybN340dYm2yaO9wdMx+pdnpyNZdQLY4E+trYNIr5zig2PpqUUV/umRzULZoc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.196.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JMAaTVx6vr/5PZ590IM1QDqx4bKstOa/XEljGVdnOqR3Kj9X8hn6/PiwKSG/XLhs742wjd8xb9tuC7lqb1LmTjMbM7E3qeK8hwLq50qUGWVQlgpz7OHU49I3aDxNq6OcUEf+jbsPOk85i13gLpqfxKRYABzZEHpQdiJnILGWKIwz8Re+Ghe1ycziXugVoWTBYw+zl+gP4MOZq/XdfEVom+nvIvy+E60PBMrF+pVwLgboqetYWBMtniJdIAYh/XNjAaHaPLuGJrVaOcZWvQKx77Burwbm10Qi4TKUHkhbI693D0h0JrNnGYHCRL/o+Nnd/LLkNvex7PVe9w9aUhvJqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XocNzMdDdnpAAgUlFMspg7E414x41ItA32F/a1fRnI4=;
 b=EM1Pn7QciZkQf7VgCLUUbTEiADOiZpAa+flejzN++hJw+q/hIDCTqxXa5NwAYB9WBVZriv9M3VVAgPeldzjuatOpQiDtCt2TfIqqSCI/xdPd2fGz9mmApNMOjnDZ693dLbfCzoCI0O5CQMGkyAY8jvKQy11WQseq7IsguGeWaTd3CbAxmy9/C+eZkDN1CYhk1hrsAGIw7iVdM3zUyASmQrFLM3QJqbLs2WmeiasFi2xAA09eXMgNlnyT+gzZXXt4RKBiEx/xIuk297iEXR9OUmbTYgh6nvfiV3CwmaFU7m9G802atye2vK7SuyxnxJBLrrVitPfv7Im2+StlqUofXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LO6P123MB6657.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:2d3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.11; Wed, 24 Dec
 2025 00:42:05 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%5]) with mapi id 15.20.9456.008; Wed, 24 Dec 2025
 00:42:03 +0000
Date: Tue, 23 Dec 2025 19:41:59 -0500
From: Aaron Tomlin <atomlin@atomlin.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, mark.rutland@arm.com, 
	mathieu.desnoyers@efficios.com, corbet@lwn.net, sean@ashe.io, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] tracing: Add bitmask-list option for human-readable
 bitmask display
Message-ID: <du3t5j4fg6nvftxjscyoxi4coan4cf6b7pvfnikmjkhdk5kusr@4xtzzrkjhmzh>
References: <20251223035622.2084081-1-atomlin@atomlin.com>
 <20251223133452.416fd539@gandalf.local.home>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fqhpq5fkjffj6e2n"
Content-Disposition: inline
In-Reply-To: <20251223133452.416fd539@gandalf.local.home>
X-ClientProxiedBy: BN0PR08CA0013.namprd08.prod.outlook.com
 (2603:10b6:408:142::21) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LO6P123MB6657:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fe728b7-0a1b-4adb-d64b-08de42854142
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K0Y0ZklBNjF1TVR3bzJESWhDSXJaQW9neE5vNnR5VGZXVlJVays1b2RoK3l2?=
 =?utf-8?B?L2NhQ1ZJbE1mdDRvY1g1VWhRdTMxQWpDZjlvNjEvQXo2Mm56YW9aU2xUcTVj?=
 =?utf-8?B?K1ZpMHpyd3EzOE9uNnFGZm9NQk1tYWVYdVIyUmg5NitJMnpCcGs1Mm5wNzky?=
 =?utf-8?B?eXhWWTFYQzJWd0w4MlBZNHVqcThUUTFvN3hMYUEwclZoT2U3QjFJRjFCOTVs?=
 =?utf-8?B?RmpwWVF5RkJkOWFSRW9Ua3Fmb3dRbTVxcjRxWldTTVg3dnc4SURJVllyZUNk?=
 =?utf-8?B?dWFETXd5SzVXdFZ0TXBmSm5FejV1K1IxZEJIUEY4dXc0cjR6MDdRTnNjYVNj?=
 =?utf-8?B?YTZocllDcW9kbTlYWnNaaXFFZ3RCRnBqZzE0d1ROSGRFWDIrbDdjeUZkUW92?=
 =?utf-8?B?TmZiUHhsbG5kMFF2eGdFS0c3N3huTXFEcnBZYllpV0JmQ1FlNkF6YmNobkZO?=
 =?utf-8?B?T2ZJdCsxcXBxMmlsQVNqZ0FIdjR3Qitkd0l1VWdhNkZtV25VZkIyOVo5UVRz?=
 =?utf-8?B?TmxUR0JYMTBJMytadjllSFk5eVUwY29xWjVFa3NTcEl6K1RsMitndzlJb0lB?=
 =?utf-8?B?b1BreHcyeVFwajU1V2NMeS9MN21NVlJmVHhCV2dEVFUxOVFlT0RzQzFhVFdr?=
 =?utf-8?B?VXRvWW9BcmlpRXhlZ2M0RFAwbzhHaHBINmVwaUNkQU1wamRpVXJoUHp1c1pQ?=
 =?utf-8?B?SXJNdDQyUzdxTnlBRGV4dDNGMFVJT0xZT3ZvdG1vVkFtOXEwSlk2UFpIdHJQ?=
 =?utf-8?B?U3FyZlFGRkk1V0NYbDNPa0tudGtnTlZXWTNyTHBVMm14OEhYWGxnVnFVVnNW?=
 =?utf-8?B?Zm1TQzJYRmtPVVphRmwrVE0yZ2xwRDdVNkRVcjZjWEVBdU54L0YxWEZtT2tu?=
 =?utf-8?B?TUZTQmtMWGoxbzZMSXB0eGIrVzMzbmhjUUV6WjlRWjBEQSszci9BUFo3a2g1?=
 =?utf-8?B?MUw3Ull6YkpBZzhJS2d1VkNTUWVlcDU2TUcrekVLWE93N2hiTmJVaFhHTnZE?=
 =?utf-8?B?VmFkMXdzUnhyS08vVWM5T095V1p0RFVIeGpWMlUrVTMrSjN3UDhsV1dLNEpV?=
 =?utf-8?B?V0hoellNWkxZNzZpNnkxRGpDcFlDOU1VT1BTb0dWbDlLT0R0VWx5WHo1OUNt?=
 =?utf-8?B?bnRJemhIZHVJT01lb2FhY0VEUkxIRWxmdHFSSjNqcHRzTlF5OFR2dityUlFO?=
 =?utf-8?B?Zi9Rak9nS1FtZnZyYm04SFJhTXdmWThNdklDS1RBNnFhSldqTHM0Rm82ZE1O?=
 =?utf-8?B?dFVUQ29nS3JqVnVybU52TVFoTkdlMGNGV2U4ZGpDd1k0bTkzdGRpdC9qZUsr?=
 =?utf-8?B?NkFFYi9ZNHdlV3FaWHBtL01UZklCTFpjcElPR2tYRTFYMlgzNTkxNjJXWkV2?=
 =?utf-8?B?SlFUWkJwU1QvQnM1cW1KbDRtQlFnZVRoVDBKRUR3R1hTaDE0VURHS005QW5N?=
 =?utf-8?B?dmdSZlRwQWhKZ0k0RHpISGY4UEV4MmFQWmk1YVg1YXN4YU04UTEvdWhQRkhY?=
 =?utf-8?B?L21jWjRLQWJ2MzdoYlNwSFEzZEhzOUpLWUxGTy9IOHA2OEltcjN4NHd1bURB?=
 =?utf-8?B?RHVEemsxbUpLSEJvUTNzWldISy9EQytOS3VwT1p4d0NqMUdKMzVWODAxalI3?=
 =?utf-8?B?aFk3RlRrTTZOWHdPZHhJcG1TVHNvTUQzOEdodGo3elltNVhKM3cwQ2p6dnJ0?=
 =?utf-8?B?eWVHZnp2aWlmRmhUaklFZDhuY2R4SEQwSkFPcWZHM3V2emtDaVF1QzZKNUxI?=
 =?utf-8?B?Nm9tTjJFTVd4RHlPcEZTaXUzZHZBdEJYbXBsMmw0WWJ3eVg2M0xnOXdZU1Iy?=
 =?utf-8?B?YkF0NEQxYy9CbVhCN3pacitUc2pOWmVmWEdseUI3RE4wQUNpelpwNjNKZUxT?=
 =?utf-8?B?R2pzdXJjM2M4L3lJc0tUc0owbzhnWjdIVElQRnFXMFZYSHphRTc5UDVyYWJm?=
 =?utf-8?Q?+R7RJrCRFEQXBjgpmEP89otv/z4RIiDe?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cFNBdVZEL2UvZHJLSm05UC9RTHJ4ZFZQVW4ydGpLLzdnbW1UUHl5TVZXNjF0?=
 =?utf-8?B?WXhSQnVYWDdCOHBNS3V1WlJzMXE3b3V0S244UnFTNkorOXBzNU1YMDZoaU40?=
 =?utf-8?B?d055Z2pVaVR4QnRlKzRrT0xvSzZJVDRiY2hTR1ZWNHI4aVhsZEp5UVhHbUp2?=
 =?utf-8?B?d1ZJUUd4UU8vTjZQQkprMkZta2YrL0tuMlgzUjdaQlNQcE5ibndWUHFWb0hK?=
 =?utf-8?B?bnBwZDB6MjV4TUhWRWVVb29nTi9OcXNaY2ZQcmpqOEsxaWxPZXNHRTdNWmpa?=
 =?utf-8?B?eFN5WlFMVzl4bnRadXZobnl0eXdCR1NBYW5IRFJFdVhTUy9EdTUxYnRxeVpN?=
 =?utf-8?B?dmYwdmxoTkpYT1FnMkFXcHN4Z2JUaGlPL1ZpVUlkbnc4SlNabTNwQlNJS293?=
 =?utf-8?B?dUdhTFMvdVFJWjlkSGRHSVNYTW83MnNFKy9ZT1dBK2p4d21qOWF0RVFUYVVM?=
 =?utf-8?B?S1NFMnlvOHgzY0VqWkcrVGZqaGdteVduUk82bGgzY1VSRTd2dHpVcmZBeFZq?=
 =?utf-8?B?RHZEczB2NlVkRGIvUWFLbjB4cm0yVlQyVGdkZHRybURyOWMvOWFKMm8wRDlt?=
 =?utf-8?B?eHgyOUxhUms3ckhWeitRNVdRcTFWUlFRd1B3QnBVdjBpR0lxemhIU0hxTGNZ?=
 =?utf-8?B?a25WTys4Mk9Yay9ER055RytRbEdySFN2NmZnbGFscVh2Wlh3REVIdTVOdlFm?=
 =?utf-8?B?cTdEam1qQzhJemd5RkhGSllpdUJLSzlDbjFFUVJuRUxQdzNmbVJJd3k0bXR1?=
 =?utf-8?B?RWRVaytMbkhxUFlSd0c3bTV5WHQwVWJXM0NjaFBPMWVpTmRTOWR1OHZUam8x?=
 =?utf-8?B?a1RpSHhidzc4SG04R3o4dWhYYXIvUjJPMlVLKzQ0ZUdmcWluRnFoTGt1K2Ir?=
 =?utf-8?B?dE8ybXdGdysvOVJITVFTY0tqdzJEaW03TkxpTWFRc1E1SFI2NVFUc1VrajRO?=
 =?utf-8?B?S05xODJENUxhVEl5L3U1anY5Q1pLSTFIaDNvZWVudGkxMk9iVGNZN1FJUXpv?=
 =?utf-8?B?TXpNR1dITXVJbzlPNGhHZzRBZkVzQkZFTC9lSWM4djMvRS9remtRNk9WMTBP?=
 =?utf-8?B?YWtGREgrTzdybmduSEpBNjlQWTV5aDdnd2U4K3B1VTlENk9MbkRVZzhXOTha?=
 =?utf-8?B?cWFhbTNEVlFsOHl3cnVQaEkrSGtPK0E1ZzAyZklBVUNFL0kzRzBRR0NiRUJl?=
 =?utf-8?B?eUJkMzVWeHZoOWQ0NEZZWHFoQUJtdjhucGJsZjBNOVBIbTk2MUQ3VnFIa1k1?=
 =?utf-8?B?WUUraUtXN09mR0dDTnh0VlRHbmlEZC9YUWIrLy8rZjg5MW01emNXUVhrSjFB?=
 =?utf-8?B?U2crSHdPVFJqa09pYnN2Rm0xT2dIc3pLZ2dUak9BOVRGZDFMMTlJMGNQallW?=
 =?utf-8?B?YzNhVkpJK0wyeTk5K09zOWN2ZThiZWdMWlpmVk1TdlZMeWxOaGt2WnVUWUxa?=
 =?utf-8?B?U3dqKzN2SUlQSnZseXV1MzVuUXJ6aGxpN3dWS2JES3lwWTF5bXBKc0FTSm40?=
 =?utf-8?B?U1FKbU5IZTRUdkFpK25LbTBUUHhHMmx2NTBSdjRiMjVYR2hZVm40dERtRmp4?=
 =?utf-8?B?K0ZGOExqS0dPbjJsV2xGRXZ2VXJSR2ZjQ2M0ZGhBWUVJUTFXdGJLZjk5UlhH?=
 =?utf-8?B?S011SWdSYTNsT0NaWWF2V1VKUk5jeDMxbnBWbFhOeWJwWXRha0YyNE04MmZw?=
 =?utf-8?B?THRiQTU1UUhpVGRqeTh6RWRhVTVFNnVGUDZycWFoUGdjZlhVWkVCaDE2NDVT?=
 =?utf-8?B?dnJHcDJGQzRSTW5FdU5ac0JzTHhaT0doU3NLTmhPVUpmUnBxM2NlU0RxNVd1?=
 =?utf-8?B?dGU1Q0NvVmhzWEJZM1F3dTRFN01tcWVTVmxDeGl4K1dud1oxSGNlaFV6MElF?=
 =?utf-8?B?RFYyZFhiUGtpNEcwclY1UDJHMWJYK2syQmlGVlZPL1lMQ1lJSVRDRGNIV0J6?=
 =?utf-8?B?Y09nWVZaR3E0M3FWK2VkYm1nMFNnS1MrTVZUZzdkU0pVbkpPb2E3alQxTnlv?=
 =?utf-8?B?S25ZUzJKTTJGczlUWGhaTldBRkFicXpoYnBxNlpjbkwwYlNXc3dQK2w0c0tL?=
 =?utf-8?B?QnBuU2tSNjdxaEN2ZC9xSzFNREFFTko1Vno2UFZhOW1UQ1JBSDBxSmVGZGRU?=
 =?utf-8?B?WFJHd3lZalZ4TlhvRDRrZENQdmhra2tmSTFuNldWMk4xcytDR08yNU11UHpr?=
 =?utf-8?B?Yzk3RUhwTmU0TEwyR2I1bEYvcEhPbU1lWjkrc2duSTk3dnpURFg1Yk5Md3Rz?=
 =?utf-8?B?SVp2VGk5STdvZ3NyZ0ptdG9sdzh5aGpWRGdQV2NQdCsrVS9Ic3AvWHpzUm5q?=
 =?utf-8?B?MlFJRldFb0hLb0twSXBrLzZidnQ5NVB4aTdyQmtadWhNaElEZm9VUT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fe728b7-0a1b-4adb-d64b-08de42854142
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2025 00:42:02.9256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 409jtFlxNtsX+nfG0VzLe1uB2MMnnWA9q30Bkrr3v4G2ytpaRvUMwtDUZFMukqlXraDZIy6X6mw7OXzi0nICoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P123MB6657

--fqhpq5fkjffj6e2n
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

Hi Steven,

Regarding the scope, I take your point that a global flag is perhaps too
blunt an instrument. I can certainly refactor this to be instance-aware by
passing the trace_iterator through the call chain.

As for the use case, I find this particularly invaluable when debugging IPI
latency or affinity issues on high-core-count systems. I typically run this
with the "nop" tracer and enable only the events/ipi/ipi_send_cpumask/
event.

When dealing with 128+ logical cores, interpreting a raw hexadecimal bitmap
to identify targeted CPUs is taxing and prone to error. For example, if I
am investigating why CPU 6 is being interrupted, I might use a filter like
"cpumask & CPU{6}". Seeing the resulting output as a range list (e.g., 0-7)
rather than a hexadecimal bitmask allows one to deduce almost instantly
which cluster of CPUs is involved in the IPI broadcast.

To avoid duplication, I am of the opinion that we should maintain a single
trace_seq_bitmask() and simply extend it. However, I am happy to extend the
API if you prefer. Given that struct trace_iterator *iter is available in
the output path, how about the following (not yet fully tested):


diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 3690221ba3d8..0a2b8229b999 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -38,7 +38,10 @@ const char *trace_print_symbols_seq_u64(struct trace_seq=
 *p,
                                                                 *symbol_ar=
ray);
 #endif
=20
-const char *trace_print_bitmask_seq(struct trace_seq *p, void *bitmask_ptr,
+struct trace_iterator;
+struct trace_event;
+
+const char *trace_print_bitmask_seq(struct trace_iterator *iter, void *bit=
mask_ptr,
                                    unsigned int bitmask_size);
=20
 const char *trace_print_hex_seq(struct trace_seq *p,
@@ -54,9 +57,6 @@ trace_print_hex_dump_seq(struct trace_seq *p, const char =
*prefix_str,
                         int prefix_type, int rowsize, int groupsize,
                         const void *buf, size_t len, bool ascii);
=20
-struct trace_iterator;
-struct trace_event;
-
 int trace_raw_output_prep(struct trace_iterator *iter,
                          struct trace_event *event);
 extern __printf(2, 3)
diff --git a/include/trace/stages/stage3_trace_output.h b/include/trace/sta=
ges/stage3_trace_output.h
index 1e7b0bef95f5..fce85ea2df1c 100644
--- a/include/trace/stages/stage3_trace_output.h
+++ b/include/trace/stages/stage3_trace_output.h
@@ -39,7 +39,7 @@
                void *__bitmask =3D __get_dynamic_array(field);           \
                unsigned int __bitmask_size;                            \
                __bitmask_size =3D __get_dynamic_array_len(field);        \
-               trace_print_bitmask_seq(p, __bitmask, __bitmask_size);  \
+               trace_print_bitmask_seq(iter, __bitmask, __bitmask_size);  =
     \
        })
=20
 #undef __get_cpumask
@@ -51,7 +51,7 @@
                void *__bitmask =3D __get_rel_dynamic_array(field);        =
       \
                unsigned int __bitmask_size;                            \
                __bitmask_size =3D __get_rel_dynamic_array_len(field);    \
-               trace_print_bitmask_seq(p, __bitmask, __bitmask_size);  \
+               trace_print_bitmask_seq(iter, __bitmask, __bitmask_size);  =
     \
        })
=20
 #undef __get_rel_cpumask
diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index cc2d3306bb60..b312d67815fa 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -195,13 +195,18 @@ EXPORT_SYMBOL(trace_print_symbols_seq_u64);
 #endif
=20
 const char *
-trace_print_bitmask_seq(struct trace_seq *p, void *bitmask_ptr,
+trace_print_bitmask_seq(struct trace_iterator *iter, void *bitmask_ptr,
 			unsigned int bitmask_size)
 {
-	const char *ret =3D trace_seq_buffer_ptr(p);
-
-	trace_seq_bitmask(p, bitmask_ptr, bitmask_size * 8);
-	trace_seq_putc(p, 0);
+	struct trace_seq *s =3D &iter->seq;
+	const struct trace_array *tr =3D iter->tr;
+	const char *ret =3D trace_seq_buffer_ptr(s);
+	bool show_bitmask_list =3D tr->trace_flags &
+				 TRACE_ITER(BITMASK_LIST);
+
+	trace_seq_bitmask(s, bitmask_ptr, bitmask_size * 8,
+			  show_bitmask_list);
+	trace_seq_putc(s, 0);
=20
 	return ret;
 }



Kind regards,
--=20
Aaron Tomlin

--fqhpq5fkjffj6e2n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEeQaE6/qKljiNHm6b4t6WWBnMd9YFAmlLNtEACgkQ4t6WWBnM
d9aVQw//YJ1TkHgySIvUcHUqFz/8OBjA4M3yq4bUe87yrNaFSQ7mmDtWDeqoqMyh
sJ32ODK5NnUtYO7p7aYn3SN6V2TBJE3DANB4DpNG5gnUD2Ed89mYID7XilnBXftv
e2nHkcDMYPkym5DSr2HFzlOCmC+W05TRc+oenJkPK4M74fKmX5xTZNb/YUNW4Dqk
0RkjFDC4sLl2u+JrovtWnRWoTZwmzpMq82UhM9kLXphmVKMdx4AJo1pv5ZUAXupv
x2POqnEST9v1IK/NHLfcZnPFWu31JEIoqyNt4Tb0PCThNOQzwQXrrU4zzPa6OmZX
HBnJU68Cn23YxSZGy2wT1aNuS2rG8wEX/JSn052CbmF/3r4f6yuHU4QdzB/eB+Ss
jAl+zKfG7yBVmN2KfK6f+vwiIIc9+zv+NVbmA1L4chU1hslZdvraR8Ph2LHRaG5Z
mzAfw07zhnjL9GqSfYoAVoT3gOtEWcEPiVq1gFBGWTM9iSStjQ+RUbRx0e+CT7S0
h+lSnK0r0p+sqnhISPIwgcMnKz6V2piPK4fHHAkdA/dlMsN3x6qZgjbCJ5XrJjGG
jyCgxXf+71vvMTDpPDkvlmu+ACV/8J+c0rXdy1iU1lZhHeIHFvGZeS91xZUssz4g
lSipve7WjEHh9anfTOCoz1mAtYaVw+S5pXId0H9OP1kUemdUdwQ=
=KWLJ
-----END PGP SIGNATURE-----

--fqhpq5fkjffj6e2n--
