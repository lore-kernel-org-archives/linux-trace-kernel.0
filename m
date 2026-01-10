Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022106.outbound.protection.outlook.com [52.101.101.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174DD2C17B3;
	Sat, 10 Jan 2026 21:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768079174; cv=fail; b=lbpXujaAMbmc5A34ct7R56vc+omErRB/fRU0qtRgfTESna6SnbmAEDn+1pNdvSB8RnFhASJOoyk8wgFSPSZJAoAZn+7R4UNf16Duqcl04oEGn4JD+f/CtRlY1ExEXbdUPIW6rZGusY9w6V1nhbScTlj9BA/E8KFM8EsWMfm/xjU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768079174; c=relaxed/simple;
	bh=raGUrqkWXlzDOJIX7CGPo3ceA/jqtcYOE9jVMqYrYO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PvwWoVlS+FHpj9ZwJa6hLT4GvmgCFrRgMJK8eYWcT4DjLgZ9FltBPeEXU9/1v1QWNBb+Zbxioe9sC4XR6s4Bl1HpPXCQR+3K9J4dlmZlCBujg6lY8v3eNqZya++BXRIxyVXwaIF/v8k3lnXKEXj8jDdsxXTpvL9GTd7YMONPltY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.101.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=phLwdse2K4DyRphRm26FP7UJAj7q5JRQX0iWjwmZkBCrbx7ry3toLKMdObuzd8PRerWOH64j4IMyXARbsCcIYD1AK7UXv2VwL4sDyT/kDRBsHn0E6aBTcEEHb10Z/BgVJi8cHVfYaEsokHMCfuizxfMgqjAFeSSLZYTkqSOV2cfMfT496tGKXHJn9yTExfsX0tRROmT4zqKryS0tVYXZiOXkotmQ1SJNrn57DtJEznSlKaypV3aOzfqzkrHoEXrugbpmAU75063HdpsR0bCJ5X2pn66BaE2rRXigoSrxzNLu/0fS/Wr6Vn4JR8B8LJfKtC47nYaR6s+Ylq1hYf955Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=raGUrqkWXlzDOJIX7CGPo3ceA/jqtcYOE9jVMqYrYO4=;
 b=YBCwU2T6CNCEcFt27GESCgA4z9+5CMpw4Ca1kzojeJCARZBPigXudw8xEkMqTpR7WoWlV+e0dwuSFPPn3Mkj7MaV6hv6/PAgg3DGjs/8E13FvIeTFPFWYqJ43ddOFbOfCtOMf+un4c4bHXuxEdIHW6qUCmLOgM789qgu2chlJe56heM3T48QR9Y9963KkQxOxIsM+jzLHy2Fggndh9u/hQKpV0KNrM4OoacDbkNWY0NkByo8oIXccN0gt+IIoua2DgBcB+Iz4lLirsF0OOhLyRgcmE/JuPgxS7a16g2kWJ5P4fyf23u4HhDiWVA55ULPQtz7es0Kyk5hv1BRy9c1SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LOYP123MB2816.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:ef::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.6; Sat, 10 Jan
 2026 21:06:08 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%5]) with mapi id 15.20.9499.005; Sat, 10 Jan 2026
 21:06:06 +0000
Date: Sat, 10 Jan 2026 16:06:02 -0500
From: Aaron Tomlin <atomlin@atomlin.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mark.rutland@arm.com, 
	mathieu.desnoyers@efficios.com, corbet@lwn.net
Cc: sean@ashe.io, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [v3 PATCH 0/1] tracing: Add bitmask-list option for
 human-readable bitmask display
Message-ID: <sm4xoemzv7d5pkyudybpxydriukvnlkwiaxrbh3qgevpnxphha@x7gberqhyjdo>
References: <20251226160724.2246493-1-atomlin@atomlin.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tbedbsl46p6jou5g"
Content-Disposition: inline
In-Reply-To: <20251226160724.2246493-1-atomlin@atomlin.com>
X-ClientProxiedBy: BN9P221CA0022.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:408:10a::14) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LOYP123MB2816:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ecd05a7-fc8e-405e-cb97-08de508c11d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R1hDSWNCandLVVk4NWhwMytxU09NNm5zUWh1WEZjMFBEUXk2TEViL2xOWDlJ?=
 =?utf-8?B?eHl5cmdKVDBqMFU5UVVOZStIS0JEWEpzeGFOSUZoNjJnaW84NWJaTmxmeVJF?=
 =?utf-8?B?d2lXSWdjK1UzVjE3c3c5L2lTMUhsbGFnM25PVC82aWVtckNMZDVvZUpyOG1k?=
 =?utf-8?B?MjJXdkhibVFQcTJZb1oyRGdJdXVJajVRS0xVaWRjRG5BL1VlMWV4T1NTbnVF?=
 =?utf-8?B?VElYMXlEK2ljZGlYUENNajhBRmlhT3RqNzBZeHdlcVhUUTNadjJlTzZHTW5S?=
 =?utf-8?B?T3RmVnZkR3FDRk5BdTYxZ0ZIK2E4bVhjN0xZeVN4RDZsdnowVytzZ1hWZlFW?=
 =?utf-8?B?WmtnT0RxUXpBdXhURkZTNGhwTnRLMWNBZUlIT2hzOGJTR0g0UEdjbE5Sdm1R?=
 =?utf-8?B?U1F2Rjl1UUJRenZraXRnaitsVndGQWNKM21qcFBYNkgzemd0OXdzMzZoREEx?=
 =?utf-8?B?K2xpcTNYTlFQWloyRWJHTUcxdXJuNmxCUmgwNnJRTjR5aFcrNnRVMTljQ2lw?=
 =?utf-8?B?d3dLdEtZcUlrTnc1NnRFakxjNGMrZEFOSHVTY3NiVU5QV1pyMUJ3RUNsaytD?=
 =?utf-8?B?SHd3VUdDeWdsTnoyVURpL00rRXZhNnp1dU1LTHh5bnQxNDhCeldoVE1EKzZm?=
 =?utf-8?B?R21ZaWh3alRoUlZwOE5ScHg2Q1RhbFQ1clhtdVNwYVZnaCtHcEpjTTVPZ0VG?=
 =?utf-8?B?VUQ3ZDVTeS9ER0JUbTBaNElMSU1qZlcvc1RPRkxlYlFBbUE2cXRCZVZRV1RK?=
 =?utf-8?B?YzNFZGFzbHBFbjVHeWNWbUJPaU1MRDhmeG9SOW5DeVFOVURUZ0F4M3RodkhE?=
 =?utf-8?B?T3pxSWhySTRQNEZ4UWJWdDdpR0xTUGMrUFBDczBqTFlONVRid1E2Uit1cThF?=
 =?utf-8?B?UnZlbnUyLzdxT2NlZWUwRFdCR2tnN0lLRlh5Q2pnWEYvVnV3RWZIMVVzNkk4?=
 =?utf-8?B?aEcvQXIzcHpKNVRhTlJJWCtwYVhBdUd6NE0yelBZejJ2anZUN3JLOGw1NHU2?=
 =?utf-8?B?MGRvazIxQWdSSWJ1dEJZRkxtSlNnNzk4c3FHcnY0WDlUNC9KWVpHMGNSME0y?=
 =?utf-8?B?L1hlMVFMWTNuOXdjMkZVc01qdFpHTFEyOUEyenIrK2pCZ3VwVmg5WDUzY1N2?=
 =?utf-8?B?U3BJVVkwRTA3R041MFgzTlZGZ05NZm42eHdWSEJPODArdE5YMW9GY3M1cFZt?=
 =?utf-8?B?OWoxc2ZLWWF1TUlHZ3lGcnoxQmhtWDQxNVNWVlVWb0VpaDBhZEUxVEl3YjA4?=
 =?utf-8?B?U3BkOW1yWU81UmVtenpsZ09UejIyZ0orRk1RbCtlWmtnUi82MFlsTkJUbFFH?=
 =?utf-8?B?QXZiZExwUExYeGlyVlNLM1hVNlcwT1U4amszSTV1ZUwxRzhvcTdQYnVpMGQ1?=
 =?utf-8?B?dkVOUUUwZ2JVR1pCNmdMcmIwUUxtVUFEaVhEVlBzaklSQWxYMmE1VjFHQmNa?=
 =?utf-8?B?MGJNY0tieDF1cEROSGlJMllTQndzdHlSOEk1SHl0VzBmOE43aFEwL25MRUpr?=
 =?utf-8?B?K0h6T0g2VU9PVzI0eHdmRExDN2Uva29QUysycmN5MkI0TENNNFJxekV1SGpI?=
 =?utf-8?B?aHFZSEgycC92aEpEWDdxOXExU2VmQUhyQ1RIbEU1Mlh1NFk1Sk43QzNmUi94?=
 =?utf-8?B?cUpNa2NKRkFiZ1A5T0R6ZEZTVDFFOStUeEt1NGRJR2hmWFc4M25wUW0xZmtM?=
 =?utf-8?B?d2ZhZ09GUmJZRmNqbWp1eW1IWGNzMlRuaUdVMmVMQWJwVFdCcVROWVJoK2tK?=
 =?utf-8?B?SlZFa0VCM21sbDVEb3RaeGlna1Zxa2lqR2h5WHd3bUlyNkRwUFhtVkZpeDZY?=
 =?utf-8?B?QkU5bndmeVA5UVdtSGt3TThCRkhNL1V5NHFwbXFRQzlkT2R3VVZCNlBVUUlH?=
 =?utf-8?B?R2VDQ0dWcFNSakJmSDFOc1UyMXplV1pncWRwOEFQSGp6RUlSc0c5ZjhSMHMx?=
 =?utf-8?Q?eptnMH7PyaSe4NVF/TvW292K8bFgbLYb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZTdzZlJ3a0E2Sng1WVA3OFZucytJSDNyRE81WFAzcDV6ZWNLdGhJYVFnNW1X?=
 =?utf-8?B?OGszbUxOczhReThOMXF4MjhydkNjeWZONGszUjBhekxuZytxU0VnSWxjVFhy?=
 =?utf-8?B?MUNqeGE5MXNnUFBLUkEwc0hyUVU2TVdOTTZiUE9WUVpMbC9PVnUwOHNiTm9l?=
 =?utf-8?B?TEQwUFk2dHhlbUo0KzR2c3BiSGJBUXRVdmlCVS9JbUltVVZWSDZIQTJtOVlO?=
 =?utf-8?B?N05uak8xTEZLVHlncUQrWFJORVlFc3hJdGQ0WWJ6aTIzTkY5ZW1mRFdJKzhO?=
 =?utf-8?B?TkplV2cwZ093bzNrVlVPYjJjRDZiWVMzNXZuNnFHdWkxMFQzNVRGQlQzaXdp?=
 =?utf-8?B?M1BKWjltRk1KWXMzYk1CRm9RWEFBWStEaDFvOVRyOC81Z0hOMTRNblNUdW0v?=
 =?utf-8?B?Z2FNRVFjb3dUWnk5aEpZY3NGYWxEa2tBc3kreE9sbXpnUUorSHN4dENmVkpr?=
 =?utf-8?B?WWFYNWI3eXppOVQ3aXpIQ2xXdFhzdWhHdHpqVG9QZGN2bXBEeXcyWmVHdDE4?=
 =?utf-8?B?ZUl1MU1ZdWFaMmNTaDdRQ3A1M1JEVFJFYkF2NmIxVzVlKzVwQk9lRy9RWVU0?=
 =?utf-8?B?cXd0OUZEeXJxMHpvYzBIZDNPOG1CRXQxWURrNnpQUUVQbkJJd0F6YjhId0U5?=
 =?utf-8?B?UEYxY3hIb2YzUkNoZWpKdFpEanNqMzdqbkl4VTgwS2h1Y1BVT1pkaFBUS3FB?=
 =?utf-8?B?Z1pYOWFYZ2NrK3RkcFlVOEluOVY1cTNVK1oxUXdlUUJ0OWtPN3ZaNUdxK3FL?=
 =?utf-8?B?WVZncmVYeHVVZFl0ZWdGSXh2L0lBdHVPdzhlMXVGNXI4U1ZzTlo5UC9xOGhT?=
 =?utf-8?B?TFpBOWR5YXA5Rm1KUzQ0SFp6dDg2TDZkUWNkUjJ3WU9KTG42endNQXNhN1NX?=
 =?utf-8?B?bnNwZ3FGQlJUK3RMbUpjUUZ6RjVUS2RHbGd6dllFRE12UmVJTGJQT2dUZHox?=
 =?utf-8?B?U0NudmZKQ0FXK0EzTCswT2lmZnUyVEt5L3I4K3FEc05GT3NhbjNlbTZrRzQ3?=
 =?utf-8?B?ZjF0RHcwTnViclk2eUZpdlFaL2d6TzlhZW9UWHBidEE5YkF0eFVLeUJTVlNh?=
 =?utf-8?B?WDFvdkxCMUpPU25HcitJenNvdEdXbFZzZGY0dzVGb3ZTZWVvUi9NNVkrU3ly?=
 =?utf-8?B?eFJGNDB0dTBIczlXV3doVUczRmpxVEI0eGhHSEpRdTBWUExuN0Fma0xJSGt4?=
 =?utf-8?B?ZXlxcnNrdlNiUVc3eW4vRW9XZWkvL3FxTHlMZDlHSTF3SUV0b2xkR0QvU0Yv?=
 =?utf-8?B?dXdCbkxMUjlEYS80a25xRXB0Y2wvTlZicjlZTnVyRGUzU1VNWjdOOXBBSk1a?=
 =?utf-8?B?ZWlJZ0NaNlY4QnF5V2hzaS9pL2FjeGcycXVpMVpSeEdCbDUxUjFwcHdUdUcy?=
 =?utf-8?B?ODFqbUpScEVNMXFtVU82emdrT2U1T1ZiV24rck1GcTBZTUFtcVk5YWJaM0o3?=
 =?utf-8?B?RmE3VEEvc0N4RnF2TGc2dU5ldFNHOU9hUFFMMUF6dEo3ZDB0bUhMTGc1Rjlm?=
 =?utf-8?B?SUpTcGJKZXFDSDVlL0JBYkZ3SHBCYkIvZ0QyeTN4K0RFNXJBelZyRUpST3la?=
 =?utf-8?B?RHFOcmhpT1hocEttT1NLNGRFdmU1ZzZ4QUcraEhpdzVQbktzM3BwOU1HM1h5?=
 =?utf-8?B?QXVHKy9CVkV3NWhwZ00rWXhKUGR3RXRldTNDcWQxeUJFZXg2eHhYME5tOGNk?=
 =?utf-8?B?US9NQzdVMzhxZnVyMFg0M245SnJRWUxEZVFPaXZMelQ3bEZmTUg2MzFKdHFr?=
 =?utf-8?B?c1p3K2FKcVptR1RjcDVPMXJ4ZzAzci9mWGFod2NjZ3pCY0ltV2pHblVZZmZD?=
 =?utf-8?B?WWQ1K1d4MUI2UURtSGliUHA4YkRRczE1MWUrc1pMblFlMVRVWjk1bzJhaUdm?=
 =?utf-8?B?aTdrQXFYVVpqNWlPV3hsNHhOeE8xS202TDZ3N3U5Q2ZWRFRCSjV3WnF1c0dF?=
 =?utf-8?B?bENIc2ZRNzV3ZzRBUTJDYlVOaVhPUzFJbEZ6a0lpbTN6RHVWQ3ZEQWZwMCta?=
 =?utf-8?B?dnFKS2xON3I3YW93SDFwRVE2VXJjWW90OUc1WFpuWVNsTTVDOU9iQThidSt0?=
 =?utf-8?B?WTJUd25keDBJWUZuS0kwdDBiM3lCalg5TEVUYXJpVnVnRWROUVN5aTRaZHpv?=
 =?utf-8?B?VUE2UWZVeEFhdGtJa2U1VVBlaUxhNUVXek5Md3ViRDZuYUE4SVpZbEFleXlI?=
 =?utf-8?B?d1gvRnZDcFVwclF6WmdaaHZjMFhaN0xTRnJmNUNDVis0TEh4SUdlMno5akMv?=
 =?utf-8?B?QWI1aVI3WlRTTjBHQjk2bWlycWhnMCtJMFY3d2crVkFkS1ArWStDMWJ0blVt?=
 =?utf-8?B?VkFBUU1oY3N0THA1MklJQWdXY001WkJoODAzb2o2OURKSGlGYU52Zz09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ecd05a7-fc8e-405e-cb97-08de508c11d3
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2026 21:06:06.0359
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D+6mehbbii1pAwKIKC5mS+SM6/RmZSqYO/k/egecfmcSUM5r/+bOGttu2Y33Y6ViypaTAOCSdGioysZfH9Sh8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOYP123MB2816

--tbedbsl46p6jou5g
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [v3 PATCH 0/1] tracing: Add bitmask-list option for
 human-readable bitmask display
MIME-Version: 1.0

On Fri, Dec 26, 2025 at 11:07:23AM -0500, Aaron Tomlin wrote:
> Hi Steve,
>=20
> This patch adds support for displaying bitmasks in human-readable list
> format (e.g., 0,2-5,7) in addition to the default hexadecimal bitmap
> representation. This is particularly useful when tracing CPU masks and
> other large bitmasks where individual bit positions are more meaningful
> than their hexadecimal encoding.
>=20
> When the "bitmask-list" option is enabled, the printk "%*pbl" format
> specifier is used to render bitmasks as comma-separated ranges, making
> trace output easier to interpret for complex CPU configurations and
> large bitmask values.
>=20
> This iteration incorporates the use of iter->tmp_seq to ensure the
> implementation is robust, instance-aware, and free from buffer contention
> or duplication issues.
>=20
> Please let me know your thoughts.

Hi Steve,

I would like to ask if this iteration is suitable for inclusion, or should
any further refinements be made?


Kind regards,
--=20
Aaron Tomlin

--tbedbsl46p6jou5g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEeQaE6/qKljiNHm6b4t6WWBnMd9YFAmlivzEACgkQ4t6WWBnM
d9bGNw/9FPhAGITqtMT8waCWPDYB+ruDz0cn6aeQDMPBLPOvycQg+n8+PLE5NObk
IvQeZNZ5hNTmZB50Y9zgtNl4zQ/hUqDxBASB3v2gTN3b9H05uaUek60hQy/qIB52
C8U2a3vDSgtbwdsy3Rhmp13Eco9mtNqZd01iiIsM6pT6e2/4wVOyiVh1cr71Ff6K
BHWryZ2Xy9TLs/u/O9I6RXOoTqoPXpCo9gZpnEK8Ln1mqLJx0sqKNV35913PacN1
hbTdgW8nYFv0BBFPo3lTJQXA3CHQy85Jq0muTvs0hLPGgolVKzUy3eqlL5UKMd0E
AjHJtfeL3vDPOzjbSzfJ9CV+V+jOerX2TJGNVsNDKK6I1NTFZPfu4ER1PwQQefKI
j3LChhrMvjPirscutuyAs6sisYncPOR3DVkJ1UED5ZNUC96WBO4pXLdrLHzULr4a
Z8NapXxYP7OScSOjeNm4nxghbGs2p85y6Gz2/D8OU78DsReDeU6GsYO9CIuXNDFD
yTWaPU48B9fmkXHImuMonxGfLMNnGfPUtgAqDXXKmTJN4bXIqquc8XOd5IlUAQ9y
CGh/Xz72bpPIbtdu3KNZ5ATWqgKPDJyeeQ5okU96/yS+mlioj/8YNTFkBLFZlWS7
wU8CuJpOwC8rkBOAhr4SaYvJdCbpmIs99+XSVaygWdmvtsHlUUY=
=hXHb
-----END PGP SIGNATURE-----

--tbedbsl46p6jou5g--
