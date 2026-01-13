Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022084.outbound.protection.outlook.com [52.101.101.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125292727E2;
	Tue, 13 Jan 2026 01:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768269283; cv=fail; b=FqQiQLAKC+usiwBIvYgx948e1pbZzeWIbxkNDLPGDHsJNiHHkAEZF2kZab6fpY/+SB+FpMYU84sisAU+h6mfSriCaRlOM+zFFolUIXIkYE1MCRgHD9GNY34LOf5857Ztc2a/xIQYgarRHnUFq6ebEzMEk76RFFXrIYBQZz8lwYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768269283; c=relaxed/simple;
	bh=wFpa0qBAfvYuypnB+SwCrY3h2QHRwHCqzEB7As5CfVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KAn66Xgf4wWjvySfKk9VV84ZTkFPDQfHK1VkCwuJzm7wbKw7Pm/s7Z7cNKEq5jGt6Tej2mL+xXv19DL4/lp5b6MrIb6gOYHg8P5lh3OaU5xRxLDG15kVpa9fwP/gBTlejQRkfaGkfQvf9tVQLOMyIegTxrq6uLQzLjVTS9R84Eo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.101.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rOxZFudMp22Wuh9AlvRUShl4FLc1LQzVUj3pG7O1U1h09T9GOwJUdw3wlaJZR0N48ZUJ64IJHymGa+s8RX63PE123aUp90zJHs+KFdK4p2bk52RH6BxMX5jrSA3Of7gLewCS+6FPZjdOFdgoFe3RDpiqcGhXCP3JiU/if1cYspYWZ9j6tUvthn++LNG3ew+LJ5Us5GwW0slG5Z4cT28M2R45U6tSTaRz7Ybb6N49CzDPpvsACicYcnmQhGT8eY2KIGogxlZcWrJXS7VXtEFGMJOoZxc13q/8dx5cT2Lq5DKiVAEJecdVNOqpH4YAFfOyPWlftP4u900BEhgpqB5NaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3/rLMTA691AXeAEmQtw7OYjYRc/odLX8Rvm1xbfU36I=;
 b=iMrFL0ymkBALkEPOT35VTYD1oXTShZQ+o5Be98H1S0J60bMtyFiBxnR4mp7i9cm0/xw/6cROz7piWaD5a2yvtj+iaJNRKYjNkDd4p7vnf7Mpn4m5rfka1o2KVFu7nWtwHM0+YBFkRjNi9aWItFFyPa4QKGi36Wo3vI98MJCx+7uCFrU7GmJA+hn47jxSXaSqOjJuK9HD1zSniuhEoMTibM3NKtOuhJLUitdpsMKw+CIw7Ywf3i0viWUaZdgpViGtD0sVjlyPaZDmPQWXkwo1vF9LrHfON4an5dBBx0E8O0PhuYSD2br0LkTr2aYufWq8nbVV77VFNOQHe6+uxfC7MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LO0P123MB6880.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:30d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 01:54:38 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%5]) with mapi id 15.20.9499.005; Tue, 13 Jan 2026
 01:54:38 +0000
Date: Mon, 12 Jan 2026 20:54:35 -0500
From: Aaron Tomlin <atomlin@atomlin.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] tracing: Have show_event_trigger/filter format a bit
 more in columns
Message-ID: <tsrxxpunp7v3wgsc53zg5lki52gsmoibi6dbmvmjbngjnnhrhq@3ze3rtqhihst>
References: <20260112153408.18373e73@gandalf.local.home>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qjiffarteuubjong"
Content-Disposition: inline
In-Reply-To: <20260112153408.18373e73@gandalf.local.home>
X-ClientProxiedBy: BN8PR04CA0040.namprd04.prod.outlook.com
 (2603:10b6:408:d4::14) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LO0P123MB6880:EE_
X-MS-Office365-Filtering-Correlation-Id: a9262c2c-38a7-48ef-a5b1-08de5246b5c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QlNZQlF0MWJyU1A3RkFLZG5HYzJVNHErNFhwQTQxcFdUSXArTFkrbHJKQkFw?=
 =?utf-8?B?MFZkUE1hS2J4K2ZKMTlzZnJobkJUQit0cWtxVFkxZllWT2RyNGVXSEkxZ0kx?=
 =?utf-8?B?ZHhsdWQ2TzZiUDhRUUU2czBUdWN0M3g5Nk9vUHBXRFMzZDJyREdaS1IxU1ZW?=
 =?utf-8?B?NDNEOVhua3NSeXpYVytlUDZGVk5XUzJEbXZFYzljMDgvWjZ6K2E0MkhPaUZS?=
 =?utf-8?B?M3ZOZTJOTE1zSVU3VFFMcWtWZzR1RXI0eC9DajZPNzVNNU1vVXpoMlJKS01S?=
 =?utf-8?B?dThFQXhCcUlqdURjZjJ0c0hoR0lYVzduRzFjZVNwVHlLdWhhMzJCRmt2Rmhj?=
 =?utf-8?B?eERIcjBqcW5kUngycnFJaVpzUVYzR0psVkJERDNPSHlmeHdaRElibmhROXhl?=
 =?utf-8?B?UUh4TGJDQnEwV0ZjcElhMktPakIrNXpWUnFoNGRZQ3l6YkcrWHlnRk1jN0xh?=
 =?utf-8?B?RlRGRWw3R1BUVFdSdVV5QVRKSy9XNW5lZEs3MExLNTNMZk9EbVY2MHFnM0Ft?=
 =?utf-8?B?TEtQQVF5SXZpZFQxbmoxTi9OTWZNR2JDQk1pUkxwZFJxbzBlSDdnem9tZERk?=
 =?utf-8?B?RjAxdm1Na3h3Nm91MCt2RDRwbVpVR3R2YjhnOXNZWldhZGtHSGdHSWpVSWNu?=
 =?utf-8?B?OFZaRjd6dk5WZDZmNXpURTkxTXJMeTNGQitLa0dsUzRkQ1MxTDdJckVES1JU?=
 =?utf-8?B?SVp6c3FwMkRNNFEvdEhqZ3BzK25lOGtVWDVWSGYyVTlwUnl6WVBCN0dLYmlZ?=
 =?utf-8?B?bkMrdVZKS3dVR0NTNVFZMnYvelV5VnFzSUFPTFdsTC9ybHR5azkxREt1bWxB?=
 =?utf-8?B?QVhqbHRQMEVjakZjZng0bmtTT0FZY1ZYVlBLTVNhcGt3dGs3OUZ6bXRKZ2Rm?=
 =?utf-8?B?UFN2Vnc1YlVTcDRpbnlSRWRWVFVEaWdGMVNoU0g2aWlTYzhZY3pIREJjc1Mz?=
 =?utf-8?B?U1F3RG92SFFwZUU2VnJaVFRUMlUzUEV6eUtJNVptbEFHSXlnV05QdmFGOWhr?=
 =?utf-8?B?WldSQXlhRkd0Z1pabGw1UmtvTU4xUVViNWRBeXJ6MzBuWFJ2VEtLTTUxeUNK?=
 =?utf-8?B?eFVRajJ0UGwrSFExbE9qaVVwbVVjVmsvbVZlQzFXRWloSmhVbUlsRXdmYU9F?=
 =?utf-8?B?aUxKS3hTSHFDZjV1ZDJSSGRBdytlQ0dGbCtMa1FNT2gyVDVoekRoUFY1N1ZM?=
 =?utf-8?B?VWsvTTJvUmxwcCsrSmg1bmlrY0daYmNNV3grWjI2TGc0bUVJOGdxUVVhM3VJ?=
 =?utf-8?B?Y3F6ZkI3K2U2NEJQQklPQ2lSdmNrbGM4YTJXcGxnemxFQXlucmxoS2h3SW9j?=
 =?utf-8?B?SjFEejRqaGp2cU0xbUNZQ1JUcXN2eDdaUGtHc0RuazU1eitPNkwzT3dnT3oy?=
 =?utf-8?B?WnZ3S0tnSWVYQ21UdVRJUXM4eDhQalJPVC82aFFPNFZrSTlIRXNYTkRwbHpJ?=
 =?utf-8?B?WlVkYy9RNzRIZ0IrTDNVNWlyWWVIcGx4b2NiVGRQZTlZZmV3ckhscnlkUjVw?=
 =?utf-8?B?R0xjR25qTWM5YU1RTk5WcEQ2UE5aWEhZa09zblJlK01mQldLb3RLVk5ISHFl?=
 =?utf-8?B?bHN0eXljQmJneElMOS94cDllZWhYMFo5MlZrLy9sMmp3MDVOMkpGT0Y4THZq?=
 =?utf-8?B?ZGRYNWV5WDlDUmhtM29JbVErdmZVd2FZbGZvTlhPWHNpT2RUNE1PbExSZmU5?=
 =?utf-8?B?ZlExWlZMTU5Ec3U0UGZtNjJiRGtCOVd2Q0M0UFUwVHFHOHRpQytSNDBLN1BW?=
 =?utf-8?B?azdVWStQSkZkTDVUQVc3NTVTMmhlVVZscHRpays0ZFBsbkRSY1lSWVBvMjZG?=
 =?utf-8?B?V2JiQVRyQjlSOTNuZ1hST2M3a1M0dWxOVG1ia1J3QmV4MEFqSlpBZk92Ynlv?=
 =?utf-8?B?RWRoRWx2cCtjLzlqcHlEejBtZE9JODhsMHBVM08vT2NMc2hzK0g5QUw2ejZD?=
 =?utf-8?B?U3A3blhkNVhTTnh3TEVFc2d5ekxFWlI0WWNPRzBJaExUWUFpcVFPdkZFTEpk?=
 =?utf-8?B?OEtPNUQ5MUZnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UUV4N0JJY2lFVC9veDhyVGhIaDBpb1NPaXRCaU45NVAvNkh1QWsrWjgvREpJ?=
 =?utf-8?B?R3crb1hid0h5V0p6N2J4S0drNFFpVlBRVnNKT3RNRXVJNG1rSkhJZE51UktJ?=
 =?utf-8?B?MnoycFhRemZRZDRPQ1pkRU5lNGxWNmhnQlhicFBMNjZQdTNXVVVSTVdTcWZl?=
 =?utf-8?B?N3FMWlF1bnMwVDdxUDNtQU5JQVduSEVUWWVhVEtrR0hMaGZnOVVzcDU2MDVW?=
 =?utf-8?B?R2RnbXBGakQ4TmV6aUxSSzE0bEE0aU42YzJQRjhGaU1HMDErOUUzK1lPeTJl?=
 =?utf-8?B?a2ZyM0RabUtWUSt4cnVjT09LSWFkT21IcFFzK2x5OXNISi9ZQ0srTEgxT1Ey?=
 =?utf-8?B?cjBxK1pkeFU4TDAyY3BxRGErNHZwY3NiVlc2ZlFlTVo1eHlVRkFsOE0wSWpm?=
 =?utf-8?B?WXdFcEx6ek5qeWNlMEw2SFNza1JFZDRMMS9FUEJxNHVJTytkZDA1N3krd0lj?=
 =?utf-8?B?OXZFd2tkZjRQMmJZVGtaeHp2Tng3bjNWa1RjaUxmcTZPZEpvTXd0RGs2Q1g2?=
 =?utf-8?B?UEtwYkZIZkkzci9lSXBiWnVoTEQ1M25MQkxsRHRGRnZlb1ZHUlQ4cTY5LzB6?=
 =?utf-8?B?S1l0WTlqUldZd25ucSsrT3BCNW5mZ0dpSXRDd3VmUTYvR3JyMmx0NVFreVo5?=
 =?utf-8?B?d3hsV2hRQU5GdlZuRGVUTFY3WmxlWjFQVkRjbXhYNEx4dHVtTlk2R3doN0VN?=
 =?utf-8?B?ak0xTlYrUDVsajZ4YzhtNFdUb0pKcEpYaWZ6TG02bDZhd3ROaS9OUHVjcGx5?=
 =?utf-8?B?TDFJUFlKTUZyMVBTc0wyV3dLOXgzbEVWclZHVGkwSmg5S3hGRXhCY0FDNXBD?=
 =?utf-8?B?ZWpndWN6ZERVQkg1c2MvMSszOUpTcHFTWThtek96QllPbkRHT2RaeVIrVURM?=
 =?utf-8?B?ZC80OFdNU3lPRUVpMXVLTmpJTWJwalNYTHcrOWNxMjVHbE9PZXBnTUoxVVZy?=
 =?utf-8?B?N0Q4d0g1MDNXNmFmc3ZQbGkybFRiQ1B2ejlJMS9JbzZUaWR2U0lyRzlBeDBi?=
 =?utf-8?B?aGkyVURML0RsM3RsNTQ4Mmc3cml2ajM3QkliTGpkS2pvbS9QTURRVzVsYWQ0?=
 =?utf-8?B?VWRvK25mUk05MGdIU3pCOUFKeXVscDgyMm9yUW9HNVdaRGNuRGUrWlJmdnJy?=
 =?utf-8?B?SnFZZlJHRytQT1BKZ2xMVjlFS01hNjBiWXd5aERBY3luN2Jlakt1RG1sYlBj?=
 =?utf-8?B?R2g4d1NmUDNNUXhiUHpYbXgxMDBsMG9UZXlTR3ZhYm43QUNpaXpHa0Q3S1U3?=
 =?utf-8?B?bUpWa0pOUDUyd0lqU05XNjZhSXNCNGRoZitINytSaENSRzNzTExXNlcxc29h?=
 =?utf-8?B?NGtDZDV0YmlQdkJQa2g0UjdKRkNGUGNNcG90aUQvbzhQVFZuakduRjlVQVZX?=
 =?utf-8?B?QXBJSTlacnlTcVhOYUw4WFMvVktER2taMDFYK2pjTmhIWXJvN2hYdFhtczZO?=
 =?utf-8?B?ZGJnS05RQ2tWNmdaVCsrWHJnOVNVUXIrK1lSbTdvWUxPSGUxSXFCYm8rY2JR?=
 =?utf-8?B?c3BXcXNPMDhIUlYwRURyZWEyVzdpd0NtTTFHZklFeFdNeG5oWXh6aER0TGF0?=
 =?utf-8?B?enVNVHZqQzdQYXRNT2U1Vy9BZ29PUDk3U0RubWhmRnBNVmhZOU9TT0VZZ1VR?=
 =?utf-8?B?T1h5MEh0YlRRYVdva2hNVTRjOVo2K3R6akw2UkF4NlNOeHFhRGYwVG9WYjQ5?=
 =?utf-8?B?ZzhkSTlKbGlicGxWOGZEM00xN2xaOURqRW5JNWlJcHhlMmVkbisxQ2RNQnJ2?=
 =?utf-8?B?ZVU3M29KWU5sOUZrSTBCR0FFUnVXZG83NFhuQStDN3Znb24wK1k3QzVJUHpX?=
 =?utf-8?B?b3pZajgydkhlVXppMUJqcjlJVzF3KzhqQUJrbmNsQ3g3aC9uWjhqR0xEQ2w5?=
 =?utf-8?B?MVdMKzhvTjIzQTljWVdGc2J1YVRtc2FZenVkWWlNYjFmVHYycDZiTWVnSnVn?=
 =?utf-8?B?SXQwY3NZUkpDR1ZmaDZoOXdhLzNJZFBDSHRQeFZGWVV1b2sxUUloUDFITWJ4?=
 =?utf-8?B?VHEzcVYvd0I1cVZTK20yYXUxcGdnc3FqdkN6THIyOWdPV1VyWkwzTWU3OHdH?=
 =?utf-8?B?aGM1OXMxdENneG02YWIybnpZRWdUTnhudkF3QVdjVUI5V2ZUbzhUdG42cU8y?=
 =?utf-8?B?aUYweVFtS3lGSThWNTVLVFRzMjh1YlZ4cWIvK0VlODl6SkdtSlAvNkVIb1FN?=
 =?utf-8?B?TDdEc0NWd2xmYVdhZ1Z4eWkyRU9iTVBzRmhkMjNQSytPUlRCbjN6R0hSY2t3?=
 =?utf-8?B?TjF2NGtxVDV1R1JWRThwbDBOUzhyTmdQMGd4OTRjWXBNeVp3eWRrZlFsT1Yy?=
 =?utf-8?B?QWFMbmlZUllTRUxWYU5IQllGSktyL0hvSnI0LzMra2lCK1I3ZDFZQT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9262c2c-38a7-48ef-a5b1-08de5246b5c5
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 01:54:38.6239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hhlHyYhVv0e9kQ+GUlqWF7yiE2wVciAbqFyD2i1QVeSHCSLRHTVkcN4WMJoolFMSNyXrAUmRwNE8t5oYcm4RIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P123MB6880

--qjiffarteuubjong
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] tracing: Have show_event_trigger/filter format a bit
 more in columns
MIME-Version: 1.0

On Mon, Jan 12, 2026 at 03:34:08PM -0500, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
>=20
> By doing:
>=20
>  # trace-cmd sqlhist -e -n futex_wait select TIMESTAMP_DELTA_USECS as lat=
 from sys_enter_futex as start join sys_exit_futex as end on start.common_p=
id =3D end.common_pid
>=20
> and
>=20
>  # trace-cmd start -e futex_wait -f 'lat > 100' -e page_pool_state_releas=
e -f 'pfn =3D=3D 1'
>=20
> The output of the show_event_trigger and show_event_filter files are well
> aligned because of the inconsistent 'tab' spacing:
>=20
>  ~# cat /sys/kernel/tracing/show_event_triggers
> syscalls:sys_exit_futex	hist:keys=3Dcommon_pid:vals=3Dhitcount:__lat_1204=
6_2=3Dcommon_timestamp.usecs-$__arg_12046_1:sort=3Dhitcount:size=3D2048:clo=
ck=3Dglobal:onmatch(syscalls.sys_enter_futex).trace(futex_wait,$__lat_12046=
_2) [active]
> syscalls:sys_enter_futex	hist:keys=3Dcommon_pid:vals=3Dhitcount:__arg_120=
46_1=3Dcommon_timestamp.usecs:sort=3Dhitcount:size=3D2048:clock=3Dglobal [a=
ctive]
>=20
>  ~# cat /sys/kernel/tracing/show_event_filters
> synthetic:futex_wait	(lat > 100)
> page_pool:page_pool_state_release	(pfn =3D=3D 1)
>=20
> This makes it not so easy to read. Instead, force the spacing to be at
> least 32 bytes from the beginning (one space if the system:event is longer
> than 30 bytes):
>=20
>  ~# cat /sys/kernel/tracing/show_event_triggers
> syscalls:sys_exit_futex          hist:keys=3Dcommon_pid:vals=3Dhitcount:_=
_lat_8125_2=3Dcommon_timestamp.usecs-$__arg_8125_1:sort=3Dhitcount:size=3D2=
048:clock=3Dglobal:onmatch(syscalls.sys_enter_futex).trace(futex_wait,$__la=
t_8125_2) [active]
> syscalls:sys_enter_futex         hist:keys=3Dcommon_pid:vals=3Dhitcount:_=
_arg_8125_1=3Dcommon_timestamp.usecs:sort=3Dhitcount:size=3D2048:clock=3Dgl=
obal [active]
>=20
>  ~# cat /sys/kernel/tracing/show_event_filters
> synthetic:futex_wait             (lat > 100)
> page_pool:page_pool_state_release (pfn =3D=3D 1)
>=20
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
> [
>   This is based on top of these patches:
>     https://lore.kernel.org/linux-trace-kernel/20260105142939.2655342-1-a=
tomlin@atomlin.com/
> ]
>  kernel/trace/trace_events.c | 26 ++++++++++++++++++++++----
>  1 file changed, 22 insertions(+), 4 deletions(-)
>=20
> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> index 36936697fa2a..f372a6374164 100644
> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c
> @@ -1662,6 +1662,18 @@ static void t_stop(struct seq_file *m, void *p)
>  	mutex_unlock(&event_mutex);
>  }
> =20
> +static int get_call_len(struct trace_event_call *call)
> +{
> +	int len;
> +
> +	/* Get the length of "<system>:<event>" */
> +	len =3D strlen(call->class->system) + 1;
> +	len +=3D strlen(trace_event_name(call));
> +
> +	/* Set the index to 32 bytes to separate event from data */
> +	return len >=3D 32 ? 1 : 32 - len;
> +}
> +
>  /**
>   * t_show_filters - seq_file callback to display active event filters
>   * @m: The seq_file interface for formatted output
> @@ -1676,14 +1688,17 @@ static int t_show_filters(struct seq_file *m, voi=
d *v)
>  	struct trace_event_file *file =3D v;
>  	struct trace_event_call *call =3D file->event_call;
>  	struct event_filter *filter;
> +	int len;
> =20
>  	guard(rcu)();
>  	filter =3D rcu_dereference(file->filter);
>  	if (!filter || !filter->filter_string)
>  		return 0;
> =20
> -	seq_printf(m, "%s:%s\t%s\n", call->class->system,
> -		   trace_event_name(call), filter->filter_string);
> +	len =3D get_call_len(call);
> +
> +	seq_printf(m, "%s:%s%*.s%s\n", call->class->system,
> +		   trace_event_name(call), len, "", filter->filter_string);
> =20
>  	return 0;
>  }
> @@ -1702,6 +1717,7 @@ static int t_show_triggers(struct seq_file *m, void=
 *v)
>  	struct trace_event_file *file =3D v;
>  	struct trace_event_call *call =3D file->event_call;
>  	struct event_trigger_data *data;
> +	int len;
> =20
>  	/*
>  	 * The event_mutex is held by t_start(), protecting the
> @@ -1710,9 +1726,11 @@ static int t_show_triggers(struct seq_file *m, voi=
d *v)
>  	if (list_empty(&file->triggers))
>  		return 0;
> =20
> +	len =3D get_call_len(call);
> +
>  	list_for_each_entry_rcu(data, &file->triggers, list) {
> -		seq_printf(m, "%s:%s\t", call->class->system,
> -			   trace_event_name(call));
> +		seq_printf(m, "%s:%s%*.s", call->class->system,
> +			   trace_event_name(call), len, "");
> =20
>  		data->cmd_ops->print(m, data);
>  	}
> --=20
> 2.51.0
>=20

Nice!

Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>

--=20
Aaron Tomlin

--qjiffarteuubjong
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEeQaE6/qKljiNHm6b4t6WWBnMd9YFAmllpdQACgkQ4t6WWBnM
d9bTfxAAkRWlNe3oE0Xvzzb9YMzhNForLfy76m/jT4HuLLIA8axV6RD6Gu64KfKp
FiKIk2KfFg87/u8Ub00QhmJR95DE+nuvDKFWGvIbkTZcaxN9GRSnah59InEPiC8i
l/ynUNDn7WtmKLFa7EuxJpNQlrAsWfAC1U/OXEzrbohytDZ9dBDIdDWzmI4W6CtB
8slXA/Y1+d08LsKU7EqB8r6HTIzbtaAqFLdZWRh9Y0AybNpBr1w5IiCzP4WLpt5s
edfcFDoKxw7wrab5Y2Iu30phDFeORZh+VKeBWYwLwmDZyuLSYM5quB6jT9ZY1h+6
tJdFv8Bee+9xwIJZ0nKLZIoAwbb2yi9UOgXge1DVYTFf74iZB1obhocff//EHWPi
mM1SxZekPRVzKa7jMgKXDBldn8kqfOfGj2THMQJW5VdIDsuoSWmuVI2JldMKIUgn
LYINqG+ke6ou5Lecotx+8V8DSFJ96TZ+ebITOPe6bgU/7DXtZhO1O8cohhK86t8k
1xMzmOQg6+OIQydo6btAlvTuN6LV9+4h5twA7qtcVUpaA9E3k6/FKY5Z96x/Xsnz
3wppX13K/cIcitxFRbuFSCZI5rQXAOZxlfmt1cmugD+Za2ew9OW2AkXn+O7zahL3
2jMda92pVag1FUiSMjVzhofnhECUKPQBrmrY3Oj8dnMG+2e7Dt4=
=Tey4
-----END PGP SIGNATURE-----

--qjiffarteuubjong--
