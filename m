Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020097.outbound.protection.outlook.com [52.101.196.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500872B9A4;
	Fri,  2 Jan 2026 20:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767385187; cv=fail; b=QSoLn2EzpUpz3j4f2GNEeLmBnDodenDRJP5m09chZDURjIMRV+BmpIdQw41jKPUMokePaeXjOUwXCfdfPPviWiKzpHhZeU12PKUILNqer+ie7Ad2REEFh4/op1ma6NaIWXSOaNbcLnrTy5MggLImNXntOAfSqp8X4LC9ejq1Goc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767385187; c=relaxed/simple;
	bh=oUF0O2CZfvkT4w8xdkLAo3/Q+nNlI8nLISCggz+ZkiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OmbdR1ivQjruUjEyFwu8Oe5HmMk5ie5rUgs7EoCPdOuXJzrpPLtcoG78hU1GYw1DfUYGuHSP1Y9FarpxV1ovyHrswNFtQyUZ3NCx08yHo5WoXhpt5NbbB1KE/Pc6fCGeILddHXEQCRdw1pkVeHPfak+rJ63+uMG+UcJgRoN4Qus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.196.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gzN+uUhutnwSzCjIZt22mqmynI+wPcPox8112u1N386P6/kDPjJbxaKSvfpRomWeyjzIqq9s83JBbCesyHsW45KULS/SCTQ9GZIzOlZjs3/y82jdJ+aOAEfSF0tl7pDQ1e0KH2ATeYM1aMzE10+FpeP4vwJMNvoQhSCxCpFru4EGwFAd9rEX/DDrbJ8qb4T+nAwRk3YvjDI4wDE3VYfhLHiWAPh18ddkw3p+EA7oY+9DplcZ3hiVdjjJ0z8cMOpQ4xUTeg6bbIiRJWoIWxJ/4XoCbAyTMro3JoYjbDemGaijfRFW+wXOBtAaw/twETX3ffG0Q5BoITkrlmKj5cDyjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hTKYVj9oX+M7xLH7IAF/aOhCMP5VuD665k/9Sx7zu4g=;
 b=y6qSC9MoOi+3ySlNIMTXlB5ap4owY4ZLMNL3IWHowTPaxR/+MkTG3wjNx1ip3XAcXW+5ahGGjRzXs6Alec5vuK07/lccH8ppzsa7CLSX86WSd5qKK+4Pgh0h/X3i8IpBwtdNvyZclWuO7yqw+Knxjnh3tkYhzFAEGxWGnUg5onsYORLoLdJMu+Agw9YTud8R/lLdnrU3+tUV/6RuM3C3eS9/NUe08FIo80nc19JlZ5RRPQQrYEKbNA9sqJUbKL+IVDopknCAxeV+JKgX4GcCIa/QNm/26XsjbX4EgxkA+1cQ59+8zpNoeN5WPavjLkCj6iJrNXcBgUPDgk2zhLgj+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LO0P123MB6249.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:262::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Fri, 2 Jan
 2026 20:19:41 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%5]) with mapi id 15.20.9478.004; Fri, 2 Jan 2026
 20:19:41 +0000
Date: Fri, 2 Jan 2026 15:19:36 -0500
From: Aaron Tomlin <atomlin@atomlin.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, mark.rutland@arm.com, 
	mathieu.desnoyers@efficios.com, corbet@lwn.net, neelx@suse.com, sean@ashe.io, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] tracing: Add show_event_filters to expose active event
 filters
Message-ID: <emnt5hxjzacdbk76bwsbuzf3kf54poosxipo3auqi4dahvulxi@muwwmqcs6tbo>
References: <20260101233414.2476973-1-atomlin@atomlin.com>
 <20260102133619.39d3e323@gandalf.local.home>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="o7grfknwrlxh27kd"
Content-Disposition: inline
In-Reply-To: <20260102133619.39d3e323@gandalf.local.home>
X-ClientProxiedBy: BN9PR03CA0281.namprd03.prod.outlook.com
 (2603:10b6:408:f5::16) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LO0P123MB6249:EE_
X-MS-Office365-Filtering-Correlation-Id: 82818053-c24f-4c14-781b-08de4a3c4277
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UjFkTSs4bjQzaE5DZ25heGNkMk0rWWxHK1lmUitJYnBKK2RpN2V6RVhxRGJu?=
 =?utf-8?B?SHBIK1VOVlFzYVRsQ0NhQjNqUWNYY0F1QmNMZ3BCR1E2VDVsRlU3b2FwYlVw?=
 =?utf-8?B?WEQyems5THJUeGsrTkZSeStYVVpIb2ZaQU5pRmh5aHV3YWpQMGdrSDJGRHFB?=
 =?utf-8?B?NTJqeHBHOStZb2toN3lXM2VqcEVIdngvSjVBaXlvSTkwSUU5RzNQclBCb3RZ?=
 =?utf-8?B?QnVvYm53SUcvSkJwTm9SbnFkR3BnMEo1TXIyblRrcnBxN1V1MU1OQVg3UVl5?=
 =?utf-8?B?dUhacllTczVTWEJWck9wdkl3aUM1V0M5bzhvc1N5bGMvNENMYnhta3RWWTFE?=
 =?utf-8?B?eXdVa091aHNEVXp1L0FBdE5DeS93MERvakthMVllaDlnNXlzVFhlRmxhTUh2?=
 =?utf-8?B?VFhvMXBnYm9vaUd2SlBWbDVYUlhtQ0dkcTRYOHBoYjd6emZGdTdabkw0eHRy?=
 =?utf-8?B?TnZQclFkMmpkL2dnN2tWaHY1VHlJeWMzNUt6dU1OVXhVNFpkeUhMcm9xYUJh?=
 =?utf-8?B?ZCtDQjJLT3hhaTYzNWdPWTRPU2lnazY0Yys2aUhJTU1qb0xwV0FFZXY5Lzdq?=
 =?utf-8?B?TVVjNGxvYStRWGhsa0R2c3FZWitjOVF4S2llSHlITkgzeUt6eTVFbWIzM0ky?=
 =?utf-8?B?cG05U3RidVBVNkwrSXNqcGc4ME0wWTVDRERpdEZDc3MrVFpxd0g2MW1Takhh?=
 =?utf-8?B?OWw4elFjblVHdzA0SEkyR281bU5ORFliMG5hQlZvWjdrcllvakhoLyttdjFx?=
 =?utf-8?B?Z2RDYzVhYnZaWGY5ZVozVXVJMStzVWI2b3EwTzk0Q2RFLzhiSEFYcGM5R3Vl?=
 =?utf-8?B?RlREcjlpY05Iekl0YlZMcmZYRHAvcHFjemRnOWlaNm5zNXBiVHdlTFZpTGlN?=
 =?utf-8?B?NC9DYU9vUjg3aWVpb1NYdHllRCtEZWhBY0tJSkxzNUx2WmR1cE5qMjA3YUo5?=
 =?utf-8?B?VmlicWJPSGtKR2xpRFJ1V2N3UnVRL3grTUp0ZUFaRytEb2lHOU9PQ0dkSGEw?=
 =?utf-8?B?azZrZ0pUL1lwSTFJK0VpK0hEb3RZUjZMcHJyT1MvbDR1UXBjSTc2QTllcWxy?=
 =?utf-8?B?Wm56VjRqVGVyUytYYU1QSnBabVZFL0x2UVRnMDdMdFVOaFk5UWYyTVowUE1o?=
 =?utf-8?B?allLbXVHTU1mb0Q2WnJtZENpcDFFUlBRQzRFTVZVTXFudnptMUVZaHZUd0JP?=
 =?utf-8?B?aUc1bkhWSDRiZlFydzIvMzhzc255WjVVR3lya0VWQTRYVHhLbmRGdWlVSGdx?=
 =?utf-8?B?TFU2YmFLVkR6U0hmTHlGcVZOWUtRQVRXOXNSM2c1c0JvYjMvOWxJRFJ2Qjlu?=
 =?utf-8?B?QU0vZnFJZ00zRmhTTnEzRkJ4djNNLzlRVDY0cnAyb01HTXBHdGhPVXFCNjBw?=
 =?utf-8?B?eTh1TTFGU040TTdvQ0djeklJOEhwQkwzMmN3TXRZRlNHNXc4ZkRpN0M0SVpL?=
 =?utf-8?B?OGJwVEJZQW03cHZlemtuWWZvL2J2WFhwSG5UejN3YWFuL1ZtV29yb3p0SEFx?=
 =?utf-8?B?VTZNNzRJRXdVaW9FYUVvYnIvUFZxbEJjMkZNWnBIVzJNVkhQd3FyRE5pWWU3?=
 =?utf-8?B?WDhjbHZrNjBocjQ0UVlTWkcvaER3SmloejgzWDNLaXFpaUY0RkpVTnR6bVoy?=
 =?utf-8?B?RnRPT2cxbTVncXVQSmVGTTVYOXVCOTBPRnA5R1VDUElrUVJkQ0tKSnZkaEI3?=
 =?utf-8?B?YUhHNVowd3labkFoMkFGOEhZRFVqb0J6QWRDL0tDRm11N2JteUhzejFVTGYw?=
 =?utf-8?B?R2J3T2QzQVZpTTdtTDN3L1dTdENLTG5lU29hVGVDTGJWRU5NcEpFQlEzWTRp?=
 =?utf-8?B?VHhUMVovdVJZM1pKeFh5TEdGL2F4R3hTV2lJaDgyMVVwV3ppYm5ycy8waVhP?=
 =?utf-8?B?RE9LbXNOU0t0T3lTang0VW5VS0dYangrVHRuS2dnYzBIb2ZYaXhpZDhHQVBV?=
 =?utf-8?Q?GJtXnFj+L8aWo9IQKWwubhPGW6/Ueaj5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?emRmanB0dGhZT0FUTDRDY3NWUUVIeVFaOFlYdFB1OFIxb1hjem9mekZxQnE2?=
 =?utf-8?B?MlNzU3ZiMWIwYUE3aTNFamJCWDhYSVM3SHQ3aTdsWjk0ekN5eVZ1OE9vMUt0?=
 =?utf-8?B?MFEzbnNldXNsSHFLYVgvTjM1Nm56NVpCUDhnR2g4eTVTMTdaUXl6WXlwekdC?=
 =?utf-8?B?TjFsTmhBSVV5RTdPVHhyQW93Z0xaek8xZ3Vic29wM3lkZ0VQOEJEN2Y1K3pR?=
 =?utf-8?B?NzM5ZURucFZydXZkdG1WdFQvTEtHcjNlelZhSHp3NHczNnFhSk9qRUlNWEdJ?=
 =?utf-8?B?OW44S0N2RTRCbW1CQTM2NGRFSVZGYVFoSGxEeW9NQTNZbUhaRVgzbUg1dE10?=
 =?utf-8?B?YzU0Ry9wOVZxdlVyYWpsTjByM3lWN3BXaHpXVGxsTHNUV3Frc0FTTkxhL1hz?=
 =?utf-8?B?alBRVmgrSEZRZldkWnZrcDJNdkZRbk82d0xaMWx5QmlDUlVra3NPWDZFZDcv?=
 =?utf-8?B?QXlzd0xsaFhzTG9JTlBvSWhFUVlKdEc5aTUxVjV3MTQxZXJtbUtZYkJxMzVN?=
 =?utf-8?B?REJqL1ZuVUVHZmpOZXN2Z0lGSjF0L2l6Sk5EL0hMRUJ6QzdDb0RDUEF1MXFx?=
 =?utf-8?B?YVF5TG1JNlJLY25qWTVVS1NaUmMxaEQzcmFkd3ltblRqSGJ3Q2JzaG8wNVM3?=
 =?utf-8?B?UXNqZ3RsbC9DYlJob0c0V2cyUDZzd0pzdld3TERKTTdZaHVCbXViTzJxYjdW?=
 =?utf-8?B?SEI4Yi95djI5bXl0UnFFeUdoQnNuWEtqLzVKb3lFbWtHdkNFOXU5VjBTcWxw?=
 =?utf-8?B?NXlycEtqU3J0VzkvazhBWHNVWXNJdHowWFV0a3pMRVNVTHdvV2tpMnpyeEtI?=
 =?utf-8?B?dUpHTm05eGJ1VlNVdjF3OWtMbDlrUjRHbnYvQVNIVVNEaTRJQ1F5SlhyOERo?=
 =?utf-8?B?VzRxbmp2RHRySUovd1dvcXRoRlRTTnlva3lvK1Q4RjlJRk1ydjJ1MEtjMFNM?=
 =?utf-8?B?TmpFMWxSblZjcDB6UUFoc1JUUjI4SlhibnZ6Nk42enptQm8zTHJkeHN6S215?=
 =?utf-8?B?R016d2I0dTNwcnhETVROVDVRU0U1bko0ZFZvamsxVGVpUmZvUjhoN1ozNzJR?=
 =?utf-8?B?T3ZValN2K2tnbXBrOGJlVnNFcEVoUWdOSVUzZ00vWmUvNi9XemMrTmJCZnBj?=
 =?utf-8?B?QTlKV1NpQ1l5eEhKaVA5cEl4cVpkL1h4VER6WjRhZk9mL1M2Wm1YRitnYWxt?=
 =?utf-8?B?WE5IRFNFY09YYXJDa2h0TXp4QjZKTjJOUis5WEZrVjBDaElXd3VRemVkOGJT?=
 =?utf-8?B?M2tmcnNKTHozNWdGL21nSEh0TStGVE1PdFo1eTlGdkpBWXVSZ0sxMGFyOVBT?=
 =?utf-8?B?VEF6RmszbHFOcExNQnl2Qmx4b3hLUG5WdWtVdkFuTDFGR3A5NzZ0aXBOY010?=
 =?utf-8?B?eUw4OUpmWE1ldDFlUHhROXhCYmFWSlpBbWdVUzJpRFBBQTNhSllSNDNFTnFW?=
 =?utf-8?B?d2J5aE0wdWFSM3ZVZUpnMG5kNzN1RjRzQVNvRjlPenorZ2dRT2xmcEJ6R09Z?=
 =?utf-8?B?OFhNQ05OSWFoRm90Y2hEY0xhYjJyTXNvUm55cC94TXNRbkcrRkdpRnlYOHJt?=
 =?utf-8?B?S0pzeE44VTNkR0N6V01aZ1YvcUFlS3pGdEp4Q1JVUHUwVXpFUWpkeFp2LzRo?=
 =?utf-8?B?VmJLRWpmQk8yMy9VanVlTmJPV3B3OEw2SHRHalhhdTYrNnRGc01oR2FpZW5S?=
 =?utf-8?B?ZWtyMUdVZmoyTFJYdW1hZXZad1BCTVJmS3NOTjdzTUdtWHMxajVKMEZqaDFD?=
 =?utf-8?B?T1NUMGFpQnRqelp6NGk1TDhuUzFxdENSRFU1Mld3czZ5UkxPWVhyMzFCM0h0?=
 =?utf-8?B?bG5Yb3BvSmZBM3JUeU16eG83azNtU01YcnpsaE1SbDlBVkhkbEJpU1lVU250?=
 =?utf-8?B?UjI0cEtjb3c3dENxWXJ4aFpxYnM0NjlJUFdHeTJKQWY1K1I2b2JwWDRlYWs1?=
 =?utf-8?B?eDVNNmFHeVhxTTBoZDBjOTluOUFmZnZoRkZtdGtxMU14K0dtVk5mUW1tVEMx?=
 =?utf-8?B?VENrYlhPV3hEZHp6L3FlV1JQenptRDhTWnpZSTBXQmFCOXNNbFlnT25NNHc4?=
 =?utf-8?B?VnZlZmg1Q1R2OVFpYXRET3hQZy9CRTFtU3FGVWF3K2ljMUtnMUlaMGc2end1?=
 =?utf-8?B?VGF1VFE1WDNaVkp5TUV2bEtiZDNFdmRFSDNvY2VpbVFSbGpFVVc3OUdtTGNK?=
 =?utf-8?B?dmUycEJqc3c0NlJvcUZtOHhSWWl3Rk10M3Q1Q0c3T25mcTNFWVI2UXNsNW94?=
 =?utf-8?B?ZjFnb0RpUnllL0lRUGh4UlBOQlJmU0ZSaTVRTWgxSTlvQU4wb3BBTXhUQ1hY?=
 =?utf-8?B?RE9JNy9VVSttbUozQ1htR1VwdmJ2djg4eFJuTmlSdkkzTG8wSi9KZz09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82818053-c24f-4c14-781b-08de4a3c4277
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2026 20:19:41.3490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9WsidiQEzI+d89xEP6fPDlGQmNFdP96Pdco1SFMd1uEqeuseU0lmTJi29G1+XtXjhxoKSyqgB8K9Mg51s/8VWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P123MB6249

--o7grfknwrlxh27kd
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] tracing: Add show_event_filters to expose active event
 filters
MIME-Version: 1.0

On Fri, Jan 02, 2026 at 01:36:19PM -0500, Steven Rostedt wrote:
> Nice. Perhaps we should do something similar for event triggers.

Hi Steve,

Thanks for the review; I=E2=80=99m glad you find the addition useful.

That is an excellent suggestion. Consolidating the active triggers
alongside the filters would certainly provide a more comprehensive
overview.

I shall incorporate a similar mechanism for event triggers and submit the
update as a formal patch series in the next revision.

> Enabled? Or just events with filters. I think this should just say:
>=20
> 	A list of events that have filters. This shows the system/event
> 	pair along with the filter that is attached to the event.

Acknowledged.

> This doesn't traverse the trace_array. The seq_file does the traversing.
> Just state that this is part of the seq_file output and shows events with
> filters.

Acknowledged.

> > + * Uses RCU to safely dereference the volatile filter pointer.
>=20
> This is internal to the function and should not be part of the kerneldoc.

Acknowledged.

> > + */
> > +static int t_show_filters(struct seq_file *m, void *v)
> > +{
> > +	struct trace_event_file *file =3D v;
> > +	struct trace_event_call *call =3D file->event_call;
> > +	struct event_filter *filter;
> > +
> > +	rcu_read_lock();
>=20
> Use:
>=20
> 	guard(rcu)();
>=20
> instead.
>=20
> > +	filter =3D rcu_dereference(file->filter);
> > +	if (filter && filter->filter_string) {
> > +		seq_printf(m, "%s:%s\t%s\n",
> > +			   call->class->system,
> > +			   trace_event_name(call),
> > +			   filter->filter_string);
> > +	}
> > +	rcu_read_unlock();
>=20
> And remove the rcu_read_unlock().
>=20
> Actually, the function may be better by just doing:
>=20
> 	guard(rcu)();
> 	filter =3D rcu_dereference(file->filter);
> 	if (!filter || !filter->filter_string)
> 		return 0;
>=20
> 	seq_printf(m, "%s:%s\t%s\n", call->class->system,
> 		   trace_event_name(call), filter->filter_string);
>=20
> 	return 0;

Agreed. Using guard(rcu)() is indeed much cleaner and aligns well with the
current preference for scoped-based resource management in the kernel.

Your proposed refactoring also helpfully reduces the indentation level,
which improves readability. I shall adopt this approach and incorporate it
into the next version of the patch.

> Why not just:
>=20
> 	return ftrace_event_open(inode, file, &show_show_event_filters_seq_ops);
>=20
> ?

Acknowledged.


Kind regards,
--=20
Aaron Tomlin

--o7grfknwrlxh27kd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEeQaE6/qKljiNHm6b4t6WWBnMd9YFAmlYKFQACgkQ4t6WWBnM
d9Zrxg/5AYuak6lEyk5lBMGPMII/ZZlN+qDGTADOS+puj+to24lDvrE1vefwHdjy
zAEoe3Y/Y2jG3S5eFLqhvE4gSBp81OKU5wlpT2xf/rv56kodL+fBaN/BhmH1eWnL
Sw9CnAncs33XSnJoMdXJ4nnnxVnr2W+k5/YiVz4Z23ieQtGGUqc3t0W98iIN5GRE
tI7qBYqdCuHUaH0A+Xk6YNEx5QZProxbl6KxtTu4h6SCDOJF6ahFdAbWI3cAo+CL
SwzUtNnbm4XD8Z6sD9Fp8TMbGQydTpGj+Rh7VP79HVpQ4MhasGduuWNmWWzBMjel
GlGyt1Aa5TZ9wQQ9WpBX+plseShuJkHY8GOS5xAHsJf1rurgoRym/GF8Bbd8CGYe
/bw2+NwrDtjPh8ySFQkWo5hIRr9AaOmPOYoTA1T2zLOEyu6EcmXrwOByULqAKz/k
arOuhS3eTrLlrZl5gf+NkUxyL7BaEYfpumU69ZJc+ktEbFl8QRpvT9jUwPb7C9bs
H9sQrz3gCbPSqsUA5GHLTOJrKMqAEd8tMENGiHQWaX6Kk/XTOF9iY2GCSuY+qgnw
fe1CKTuV8cMwjFWe0+mdH+BhhSafl/fOxr0m3nPkcMYhJc7Aeqy8lo1gquaK9Cn7
uNffZe1vIpvNWyOEvIL4D/7SnhuNSPEjcMbkmFCdYPhpXJ9NbNY=
=EfkA
-----END PGP SIGNATURE-----

--o7grfknwrlxh27kd--
