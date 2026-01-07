Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020096.outbound.protection.outlook.com [52.101.196.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123681624C5;
	Wed,  7 Jan 2026 01:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767748558; cv=fail; b=L05oBZZluwiaZ9xo9XXhzJIbLCKI5OCp2IpxP5UOlXKRcVEaIoVSW8woBk+JPuWDRV1WnNyLwNx66JfGfbIS0eITaOJts4XIJeURpjrQtfRvlCZuHLWmhv5esGq0gdvaPl07/ACeLsXjQbWidpsmcYf0MjQI/3NeJt/PRUeuC+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767748558; c=relaxed/simple;
	bh=6VBIdB7QsVPg+8G2XrUX1FYyv1KxN6nGxFZMzDnsa1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XdVLTMWqupV1jmkF+eI/nHiJet0x9rgjLgM2kiOms9AIn3199hVDC+r5hkTdY7CXC/fdO1M/sx9/KkVOYc7Zf9Eof7R+8sjiQx6bUUba1B8rwMDCmXdLxF7ZAHbnQoh1MJa5jYc21f4meR/uUPION1na2emhw8RsjGXzoj0aYvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.196.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wGjke1DE9B1cC+6KdmWi94QT7KkigyX5xwyyS5WpBepO77V6/cnQIDWjzGfSFNFjpVt/V/nr8/GyhXTMaesE63lewSnbeYfQtkjLtKTCjojzKrEpkb7CejZIxGL8B3Gz3CR8mCwf0pWI/TJCDD/2WPSwqp3KGHJB5EteMQ1qOqiwCTRMCvgE881eAW1e7M00npMUXZOMhb6Q8krlPp2r84CPikPlsLVGABhZwkvBZ9bc8c36QKXR9/GLamipK4jPxprsKYgpZ1S4HPTTReKcdphfXnSPWiJ3NGQvzkfMa3MJE+PeJs1UVICEgFuw/y1V+2qUlTGNPSlVYhapID2Ssg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6VBIdB7QsVPg+8G2XrUX1FYyv1KxN6nGxFZMzDnsa1o=;
 b=FwZSCUoKivs+FGzobqetpsnCdjlQJn29S/FpOvL77/Aongllvlkn3pre5H63KHj3Ymlx5qD8op5FmZnu6q1PrQ5+GTLXWjjBA+6wecqHk80hFHHyvQHg0N6idHdXKfXBncBvXEYFTBbEmYVEWVyb5AtvguhxdxSSf1D0Nn507LADm5rq4D36WKec5kzfaKVfLV3XbXLQHqs0IBCyfZ3bjZr9TUDT8FYk8jfgVaiKPxxcm9WYcW7BNwGkK15nXGTFHJr6911Ky6FXwNcW1YfiKGzpCQEfIMKj9jm1APH4p6gBnQbOjTs4y74p8ieYfdrs/t6UR6Tjkna6RtS4ZrLUtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from LO3P123MB3531.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:be::10)
 by LOYP123MB3469.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:110::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 01:15:53 +0000
Received: from LO3P123MB3531.GBRP123.PROD.OUTLOOK.COM
 ([fe80::8242:da40:efa0:8375]) by LO3P123MB3531.GBRP123.PROD.OUTLOOK.COM
 ([fe80::8242:da40:efa0:8375%4]) with mapi id 15.20.9499.002; Wed, 7 Jan 2026
 01:15:52 +0000
Date: Tue, 6 Jan 2026 20:15:45 -0500
From: Aaron Tomlin <atomlin@atomlin.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, mhiramat@kernel.org, 
	mark.rutland@arm.com, mathieu.desnoyers@efficios.com, corbet@lwn.net, neelx@suse.com, 
	sean@ashe.io, linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org
Subject: Re: [v2 PATCH 2/2] tracing: Add show_event_triggers to expose active
 event triggers
Message-ID: <z2yfuouhrpajmfr526wlmf2jt3vnqkcx2dz2333z57ljcpwuh2@g6gpqsvmgxak>
References: <20260105142939.2655342-1-atomlin@atomlin.com>
 <20260105142939.2655342-3-atomlin@atomlin.com>
 <95feb439-2298-4539-8833-e05ed06f273b@infradead.org>
 <20260106101701.7dd20845@gandalf.local.home>
 <b08ad926-8582-4a43-ba17-3a987b7a0ca6@infradead.org>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2okpre2nzxdl2cuz"
Content-Disposition: inline
In-Reply-To: <b08ad926-8582-4a43-ba17-3a987b7a0ca6@infradead.org>
X-ClientProxiedBy: BN9PR03CA0444.namprd03.prod.outlook.com
 (2603:10b6:408:113::29) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO3P123MB3531:EE_|LOYP123MB3469:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a7057e8-38d3-4ad0-2d6c-08de4d8a4b2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TjJMK1BtcC95VENzMW0vWEtoV3ErcGJPQXVJUHdId1FHUGtzV2xqQzdSUHBh?=
 =?utf-8?B?ZitQeVd1OVF2ZGRISlhBMk1YK1FpRkJ1QlJYOGs3Z3Z4MGxyVnBnMWFxM1lI?=
 =?utf-8?B?eWluY3FTN083T3R1UklUSWtORU1xY2N4S1R0UTg3RTQ0WjA5YnRyaEVNK0hN?=
 =?utf-8?B?TDB0REZhbXZ2eC91QytKNG5rcGkzUzB1OFdSKytWT2cyTVA4VUFldDVlSXgx?=
 =?utf-8?B?YmFBalJseGM2OUJ2d2EvNVRCZDh2NEtkSkVpOENoUnRyRVZIY2hKRmIxREpl?=
 =?utf-8?B?UldmS1RqR29RM29oYk9DSTkxRXRhcWNvQUFvY0ljOHl1QWNyUDNuQkZmNGhs?=
 =?utf-8?B?OWNOdVpXTS9YZjJ4RVdOVDVodi9tVjluc0piSkZBVG5ab0J5aTMxZzRZRkhJ?=
 =?utf-8?B?aVBtR3BmYUFkSEIyQVRtYzhOVEpDcUpmL29oaG44OE1PejY4N2ZTdDd3b0VY?=
 =?utf-8?B?NmZxL08zRTl2QjVZZWN2VlA4M1VxNloxM1QzbFMvKzB3WWFleDhYT2x1N0ow?=
 =?utf-8?B?Q2V1ZWx6ME5wN0NtUS9RT2hvZ0xYV2wyNXNxaFVtWVFKVUhSYkdBaGVLR3pY?=
 =?utf-8?B?ZVRFc0NnQ3dCeTkvZUNvQ1l4NmU5Q3haSWp0MGtHWWF5ZVg4MU5URjhyMEY1?=
 =?utf-8?B?Z1V3eHZHT1JwRlNjaHpyNmkzRUllbmRlM3h1emFpMEs4Ykt5WnBVajdGUER3?=
 =?utf-8?B?aFRzUUZIRGpxM1VYbFNMc0ZWakZObVlpcEFUb0M3L2hKYmJZQjFiY1JWbGlE?=
 =?utf-8?B?K3NodTdhT0pMZGNuN3FrYzF2UnJxamFyakVja1dKVmVpR2dpaXM4V24zYkZ3?=
 =?utf-8?B?SUt1U1NWNU94czFtLytHRkpMYnIyZy9wWkNDOWJMV20ySmdTbmpXRTdoQUp2?=
 =?utf-8?B?Vk1GV2JlN05HbmxWVjVxa1RWVXhYWDRjcGJrTkN2ekJOcVppV0FaajNPYVJs?=
 =?utf-8?B?OERPQ2RLOWJVaVcwaTFUU3hqMFJuMVRsQWVjV2l6L3IwZUg0ZDhXOUNvci9F?=
 =?utf-8?B?U01KMmhKb2ZuaWs4QjNmbEFrNEU4NVlhMkdNU1p4d3MweFlRS0NvSHVlUWFN?=
 =?utf-8?B?cTF2d0RVMi9WYXQrRitLUDZOVGlPN0VUc3E3KzREY3EwakVrTkNRL3NYdjlu?=
 =?utf-8?B?V0hTSFN6ZW1HaVVuUkdNdW83NGZiU3JrNFVFc3pvVkZ6VnUvWE5ETjlTdmxO?=
 =?utf-8?B?QzU3bWVlRjBCdkR6N1hBem13ei91dnlYZnlHOHhUc2I5dE8zd0pQZXA0N1Yr?=
 =?utf-8?B?eXJVckF5QWFjcDlkWnRSdzQza3ZCNnE1NjBRNVluSWpQRlVEYUFxU082Ulhr?=
 =?utf-8?B?Wjc2aEVFbzBsVjlRZzhhMFRvS0FwZ3hmMlIyaEFRc2RVdEZycW9kSVpYcXZx?=
 =?utf-8?B?ZmJyMWtGazZKblBRNmwvNGRqcWlwYzJVRDBVOUlCUk1BMVJ2dmVwclJ1Wm5Y?=
 =?utf-8?B?NE1NOG5RTDlVRUR0Q3hUemtoSVlrZjczUHAxT21SL0FZUTBKWjdxd0lrZzBE?=
 =?utf-8?B?eE53d1dvd082ODFmMXRuQ1JCSy9ybnQ0a05kbXd4b2JLdTZOdUczaG94Tm9S?=
 =?utf-8?B?RjlIT0ZvUldVM2pXRkZDTnA1TzFsSm5DeHdoeVFPVkhGZ3JWZVlxbENyTElx?=
 =?utf-8?B?NE56M3BhNUJ3OVZ1MDZLbFUyb3ZKVTdHM3ZrbERjU2pkUElOMVNSTHZaUVJ6?=
 =?utf-8?B?c0dKN3NhajBMeGpjUHJ0eDNrWlNzVkFSM0hFQUJqdXd1V1QweEFuWjM1TzF5?=
 =?utf-8?B?Wi9NQkVFSTBHdE5VaHJHck5hOTQ4dkluWlBwczAwY0JDZXNYK2NpS0lVN2ts?=
 =?utf-8?B?c2ozYjVaeFk0V2hacWRPZlJKMUlnTFV0MmdqVVFFdjFETkVSeitHeC8wb0VK?=
 =?utf-8?B?M2RRbnZObVJvV05IWUtqUUJwcitmWlYyaDRBdDkrZ0V4bGR5Ym9mQStkM0p3?=
 =?utf-8?Q?HZxzwhsIvOwbBKXCJIXFILj8XZ9emaO1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO3P123MB3531.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a2xKUkM2eUwwak9VV25TVENBZHFaeUVUaHQwODI1Ym9xUEJENlk2OGI1ZGl0?=
 =?utf-8?B?d0d3ZExJUHV3Ty9lSHZXQnBhekNSQ3JNaW1xaEZCT1BVTS9Cb3BKSUg5ZGZy?=
 =?utf-8?B?R3RzckxjdnBTU2dDeTNqTmRpM25aYjhSWGlTcTA4NzJNa2d0SHJud1AxcU9v?=
 =?utf-8?B?VXZ5SGhIUTFYczFDOUtIZDNqMU1JZk0yMWtzYUl4SDBwVnYxRHlxUnBwb0FE?=
 =?utf-8?B?ejlqTVozVkU4MXNrM2wvdy9GRW5Da0daQUNtZUhGbWFzTFdNREhLWC8xZ1Fp?=
 =?utf-8?B?Z0c4L0ZDMVZKdWNCNEMxM1UvMmNqK0ptbG1SeFFUUTFoemdBdlRTZHNVd3Ri?=
 =?utf-8?B?K1dsUDZYVHRnYW9GZEFhQTdHSzBQdncvbmJ5UTEzT0lZRy84SWRiZDZuOFR3?=
 =?utf-8?B?MDhzcHA2M1JrTU9uTzhsd0FleDFjTVdiaWJQakNGbHVObjBGcGdRaFNxdFc2?=
 =?utf-8?B?cFBxbzJKbXNxYzBiQUtJdTRmZ2c2OFZ6VEE2TXBxOTh6UUkwUTN1T0V5SXox?=
 =?utf-8?B?dE0xL1V6R2h4YWd1bkVjVWUwYUpDVWJncG1mWmMveHNHZjhkUHRadEJDVDdQ?=
 =?utf-8?B?RDV3cC8xWUsxWHc5UDdoOEhUNVFKbW1zUSsyU05acHhidWgvMGc4U0FyTE0v?=
 =?utf-8?B?TXdVY25udEt0REhuL2VCOHNDNE1zRWNoRW42M2pVUmF1ME85TzVxZy9FWDNw?=
 =?utf-8?B?VWtPZVVZY2I0cmx2cVB0YjJiRWQzZnE5WkNTanpkR0pQa0hjZnZBbnBCT0FT?=
 =?utf-8?B?anlUeERSOENqWHBMRUZzcTRDNWpIVDZPUktUSDR1RkEzaU9RVVIyNmR1bXI4?=
 =?utf-8?B?bG9Ud081aWxjOEdZdDcrakU1MW16UzdiTmVWdHIvQkN6cDJ3VTVpcHBtcFda?=
 =?utf-8?B?LzBrOG5MUzcxbmptVEg5OE4rMFFVZURHY2tPbFNRMml3SUZ1d0NiRHl0ZnEr?=
 =?utf-8?B?OFR2QklpWTk2cTgvUE9Rb0d2YWg5SEVDcjZ1cW5HeEtwRUQ2d2gvZ1ZkdDZt?=
 =?utf-8?B?Y283SzJDS2RCeTBnN0pxTXhnUVl2MXh4YVUwZmRzT1Arb2hjRzlWTzhDMTVX?=
 =?utf-8?B?RzVaOUpMZ3lRcXV1TnVGTzUvdFRLR3FuUjZHRjFBZmRKSXk1aDZMU3dOQ1kv?=
 =?utf-8?B?TTkwVHR0bHBJY0JqWFVkblZpTmRvZ1YrdGlDeHllMlp2cHpSUHZOR2E4Qmt6?=
 =?utf-8?B?d21jdk0xN2dYNHFDTE0xd3hxa2grd0lFaFJIT0tBZGlHNnppeFJJeEk5RXFZ?=
 =?utf-8?B?U3VUVU1Qa3FTNUhIZUp5WjBOd3lxVGRLZC9tYSsxSGV5aUpFWEd1L1dqeWpm?=
 =?utf-8?B?N1gwNmlpZVh5ODB4ekhEa1lIUkxhUS9uUHFXNFluOFZmbThZVWo3RWxCTEkz?=
 =?utf-8?B?Q1hYQ3dPamtXMlhiRWgra1B0SFQzK3JRRnBlQ2tvSGdkSFZ1V3BiOWRhNi9R?=
 =?utf-8?B?aGcwN1ovRXViYzZuYU0wYWsycE9JQ3dMWWJtN1JtaUZkUXJEdWZkWnFIWkk1?=
 =?utf-8?B?TWhDamFnNFNaUjE3OG4vTm45aFhZRXlUak5aQXcwZnUvcENCamc0ZnZxdlRO?=
 =?utf-8?B?Znd2R2FBK3NCQlYySW5tU3NhU29sc2NBQU54TE1wMDh2VzUybE9yL09KY3cz?=
 =?utf-8?B?YWR0dmNBYmFBR2lYNWloOVM2RktqNzFlNWJ1VEs3N0hjOUtwbmJLTTV1ak9F?=
 =?utf-8?B?TXpwUVBVd2dIaTJhTmVIUTQyYXZCbnpya3JVb2ZHSzNwb3NWTHRyMG5YSm1i?=
 =?utf-8?B?NFpQdFMxdGJCem1aVytJZ09TSjIxbzEvMFk3ZGJSV2p3MkppM0xJZUVFeEpC?=
 =?utf-8?B?dFBnRHBXZHo5YW5IenI3bTZmY1MxTU5mTXJmOVoyeHQ1bGpOTWphVU5ZVW1z?=
 =?utf-8?B?VFArZ0FuMDJncW1Kdk9UbHVhdGNkcHZHaVFWUGVFZTVxRFdRa1RJeldqcUlC?=
 =?utf-8?B?c1NzVFN6S2JJRHJqcEp3MzV0Z0NCbTd4dTR5algwVDk0c0Q0UWs0UncxaEdp?=
 =?utf-8?B?YUJNNStjRHRlZ1B4TjVSNzlEZDNsYWtsZWFaMHdSSjJZdzZTaE5MWW96WUVp?=
 =?utf-8?B?cTIxL29WNFBRK1RhUTdGeDZYc0lLNzVPN0YxTmFpMHRVRnpjdUNIZVptQi92?=
 =?utf-8?B?cHltaFdZMkRCR1ZWZGx0Z3VHdXJ3TElGSFFyTXcxSHlKUVFSVDVoOGluZ3VX?=
 =?utf-8?B?VGM5bnN3bjdGU0x6MWNsUmFvMzZ3MWI1ekVkaE42cGdmZUN3Y25vaU56ZUQr?=
 =?utf-8?B?cUNrbFhEQ05yb1pGL1hRVzJlVElhWGlvdHNqMG5XL3BkWWZKaHB0Q2VzN04v?=
 =?utf-8?B?RHBvRGZjQWY4Z1dnNGVOMEhkY1dyOXdKRXphcWRyU0l5UmdVUkQwQT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a7057e8-38d3-4ad0-2d6c-08de4d8a4b2e
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 01:15:52.2890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pAgJ73oqczDClTyPnq6NXJKU31ICkzwaXuQFbhuamHcOb8mHL9Hs/p8J7IgH2MtMxhqURQeV+IndTrjNPBIVjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOYP123MB3469

--2okpre2nzxdl2cuz
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [v2 PATCH 2/2] tracing: Add show_event_triggers to expose active
 event triggers
MIME-Version: 1.0

On Tue, Jan 06, 2026 at 08:08:17AM -0800, Randy Dunlap wrote:
> > It is simply a s/filter/trigger/g difference though.
>=20
> Ack. Thanks.

Hi Randy,

Sorry about the delay. Indeed, as per Steve.


Kind regards,
--=20
Aaron Tomlin

--2okpre2nzxdl2cuz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEeQaE6/qKljiNHm6b4t6WWBnMd9YFAmlds8EACgkQ4t6WWBnM
d9Zg5A/8CctmolpdDgnNszCWgoWhslxjLW4nwGw4wIruaiW501xRj+S+piMKSK6s
6gCbeH/oHccJaRydzNIVEVJ2T2DIaSO8Qhy9jcdRN4FADag2V0N02Y8Kl5ecTKcT
oMk5ZoycPxP9FaSnq7Wl3au4qncUeeEacc9j/dj9MrkWPxKo0L4Ag9UqXTyUOYJq
B17xeCRDb8aovGJW3xGBkgtpFlXce8xyYYtEzCiZfmots7ucga/PAbgG9g//vBIb
Xr96EdOmxy1UwKCIwZGyyGlrWWCsKbFHqzWbqCgo3ruslKhTVK4mP3rmqh6HzOQP
sXIYpGsCq9H7gTNEORuc/r1jda5PdMwgYKG/l1AnTVB2kibUdoWqBDRQrahMKUgJ
8c4JF+7aN0IUAOEat10g3w3pajuRFhuWrB7L+MB38QStKVEauCslvWX4OLWIHsKa
LOVZJUjJ64GAGdhN0+u1+CQO3RshXjjLRZLCeLBo63JwFpIF1lLdFhV4ZPBBrZTl
XGcCW+Pjc0eyULA/3EC5hbBdKAiup8GGRKgW6V5HLYLXDfAXmw1fhtBb8lJ4hWRu
9lqxgb5ZmcccvhjH65d+VilPvlnX4v/ozBmWtK5PRkWPl/U+AMZ7q8PYk8jfPowt
q+E+xG3oe8CStYtb4pYxGzIZ4ZrogbSSBXfkgkTRjQE3SBQkjYk=
=l8PO
-----END PGP SIGNATURE-----

--2okpre2nzxdl2cuz--
