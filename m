Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795770186;
	b=dS/C4mflSi/b2PM0VyOXmRq/cK4+UyeXq/F9J84lDnIrkmDyZepWBecKtXMf3N8KbqmC
	 Td0e6rwb49Ytf7VuHzWLAc/7D4GTBXUq4PfQ7T9BxJR35r/DDdbNmRUamLiB2Gci3Nb8y
	 Bw5E5r7nXewJ/j0xJLiF3bBrsr2Q1kUruiwxpCzDqVpEWznt9HY6eW9gfrTFln8C1ox/S
	 RCoaGEnegs5+YErPcxsgL3H8MIYRHCEbnDSH7zJAImigCQySXQKuGLhUBtGNO5XuB+1ic
	 BPF6dJ5XQHmbh5d0ftFP7pW+P52REhE5pOG4NlymS+Vsz2TKsml7e12V77t8EewTk3g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795770186;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=cqVNK2B9ymBcUiHm7BYiOaN0S0OxDpBEFwHU9oPGGoI=;
	b=r5N1lh+QFIvHOL9pEzlMnSAtfI13uNlHOtVU691+8GwLHYMMbY6D4LgyIJY5YlgZR+zs
	 aYxU8FJK0XjES5FdnFdxGFnN8rnmcQd9/8MyPQfT964BS5kXUe0MDBOayaLBoaPcg7Dfe
	 ZhOdg2F7xd2qkPyciwNZ5wviQ4VGBYPrfBRN3zVInoy5qJ/6FNQg2xV48ILg8x25IKTUn
	 /GBDoqgeWLTt9JomjvlwdZKDfX4/xplcGV/xBQoMxaaG4npv6rY6516OCP5kcyOwtCM6E
	 nOvZIHrTwuAatDT0ZEaC1k8H68hMiGWknjgFaFtm646dx7bEvu74P3VwfzLm9FkTMkQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=DKY0P+2n;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.51
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013051.outbound.protection.outlook.com [40.107.159.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9C2606A338;
	Fri, 27 Nov 2026 09:03:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B9C2606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=DKY0P+2n
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RHnl5mfv0/5obb0SsZZtwRMNkK1uOSpVTog/Pqd/laWJsZEbPFuKXuOMaWcIYkndbabDCjCriQoNRjiK3djiDhxCh6OcFLi7D2cWKIQvtncGT7TeOr/R64NMYp0D7VQb9T0Fw9Id0OL7k371AacJEU56cSI8GNeQUqWC8EAshALo/Sl6bjlwatep2FfhP9S3YPMRcTcR4kloNxmTK2/45+EL4ITEcLiLLjdg/K7bP6RwbXOTkU2kLordnLYjSzuaM2SQZwQWPfkAjGwtgYsWjszPcIbkri0BK/FD3Q6GNx7m10JEF2bVSvePzygoll/VFHdos2vyuR+K8anWLPOF9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cqVNK2B9ymBcUiHm7BYiOaN0S0OxDpBEFwHU9oPGGoI=;
 b=JAwrIvjDVL352Y2pRiDkERiNiF6AyAlqE6COZ2oUq8pefl5aXHMds2qnRtK24KM07XC+2j/RK1w9jjd1x5clwDWjUG8uKwCMvaPbPFoCTyBm5KhmaJHQ8xHN1kKHW9/wnpUigRKsE3mGfDMi0ekRa9rtJSME1Ho5yj+e7ebv9OWvhlPeV5GFnolc8z+JCdudqJiZqhBktMQlob2C43syjZkDaKt9w74nUUmWmSJild6aCuzn9YIWYfa49Lo65DAsyJRXSq5Tv5QU08fTHT2qu4ftCNiZWcyPYl3r1AnvrfHh2sR5AZyyP6GxJok9lMGL2jWE2EKb8rtZsEsyavHg0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cqVNK2B9ymBcUiHm7BYiOaN0S0OxDpBEFwHU9oPGGoI=;
 b=DKY0P+2nWWOYJPI+aG+Z8ZkwD3fRP5ksfUzqQNixdpTlwxl4hMuaMY4AWBLANo3rX0J8t0NnCv7pYScUBsn4a+0S6ELf/zRcJhwGfo52OOJ7w5RsYv08RQ3e4UO7JHbNcScw4nzI9SGFmGlC8mezbU3dsz0i6jUL5RetU8p7eC+idR1Z6VLANU6faYZ9zWOayrjHKZjCya1hxeDWIHBlBsEuIRsqQFAj8dx4vyMk6DOkKKXkXr1MYocfL/3toTDL2LKJmvmRcVhFpHSGkLQrNTTK+1yerVLttxA9x6myLqqogn9nC2vwNF/s4qtUlU+bIk7bMmAoXIuJvetC96zH9Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by DU0PR10MB9197.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:5dd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.688.4; Fri, 27 Nov
 2026 09:02:58 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%6]) with mapi id 15.21.0688.001; Fri, 27 Nov 2026
 09:02:57 +0000
Message-ID: <9a1df2a6-27fb-4029-866d-c115d9f0b5f7@siemens.com>
Date: Fri, 27 Nov 2026 10:03:20 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/4] rv: collect per-edge dwell time for per-cpu DA/HA
 monitors
To: Gabriele Monaco <gmonaco@redhat.com>, Steven Rostedt <rostedt@goodmis.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 rpm@xenomai.org, jan.kiszka@siemens.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20261127070545.64265-1-tobias.schaffner@siemens.com>
 <20261127070545.64265-4-tobias.schaffner@siemens.com>
 <6ee9fd02caec10b09c8f25913a2c0e619f5dd4e7.camel@redhat.com>
Content-Language: en-US
From: Tobias Schaffner <tobias.schaffner@siemens.com>
In-Reply-To: <6ee9fd02caec10b09c8f25913a2c0e619f5dd4e7.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA4P292CA0004.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:2d::10) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|DU0PR10MB9197:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e4f38b3-acd8-4716-9079-08df4c653b15
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|366016|376014|1800799024|7416014|11063799006|4143699003|261009223027099003|18002099003|22082099003|55112099003|10067099003|56012099006|261028144727099003|261026140227099003|261026121527099003|261021123027099003|261022105027099003;
X-Microsoft-Antispam-Message-Info:
	FpHBtCmI1sBvm6yMZsEkADq8PsiKKKnsUySVIHKM0d84mVuIwfSTe/zUkB+++JIQUhTPw5Rhcpmke7LaqGQlmE3qOJesi7wfbV27wAnFLaPNhtnFOPy7Mlimka5UqQAv4Zgn6ZG5+Y52/OSl6FTYH5MbsghMYT58k9DosB0lbXak4PVEA9F5/2N+NBy2kZgRsP0eBCM+637KO0xvCJC8l8Jn77ZDbSyeVowJoDPFXvEhrto5c/1BvUFGnH3JE3L1HiTNKxYobW+9I2CzIAbbRaE6aMD+KXYCXPZdXEZparsOpifEa/kG7OAI6ioSCPLOfyIJBzB100d20Wkv15CfMFJ1vWvu4Cog5O4IpTtneBs29sVrGGlJ0/AMRD8KgRZKF07zM1v0sdQC7HqVF4pzthdkB83M7e2/Ei7Zg5CkXVr+CzT0d0s3yy6nHaLDBd5rLXuM8QdjzDcdyOrF6qdH3FNKshzjEOgakTMy8Losdf2AHB2OcgjAeMd8YDI6pw0kjl7QTm/BWtWx6INEqkqOX5qS0XjKGOI/Ztpt3QZdbr7xkLRXNZ0HF7QQrWibpP4eZmkaqwZGnJvhdOYcaUJD212VlFzZ+H0R8tBbWu1QjoqbyvwNXLpZ6nTeCUP68KsVqz3zoTqHN2MK2o74cfGO00vZQ7dM4MzCbiAHf3EIY+M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(366016)(376014)(1800799024)(7416014)(11063799006)(4143699003)(261009223027099003)(18002099003)(22082099003)(55112099003)(10067099003)(56012099006)(261028144727099003)(261026140227099003)(261026121527099003)(261021123027099003)(261022105027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QkFNU21SaDVXcUkva0pEUU1TVklrYU9LNGZmOHJXbzU2U1RZaXIyQ1JRaG9k?=
 =?utf-8?B?RngzYXFtMENtMHZQVWhrZzNLd1ZXMlh6SUZNNUUrQ3VOeG5EL1lQY0Z6NzBT?=
 =?utf-8?B?OHk3Rk9CYW54eUtWTmNsWTI2THpXUGlPTnRSTzhUczFIM09ra2cra1l3N1pI?=
 =?utf-8?B?UGNKY1c4OFdGcU9EY2FNTXkrakhDSDBGRkV6SE1DMzZwbkFGU1luZktSUzhG?=
 =?utf-8?B?eHl0TDVJVUhSV3JERkZid1dUVUhLR2kvMDNSZ3VGbW9leDVCcWJhMTI3aTdk?=
 =?utf-8?B?U2VEVm5adDFTbFczN1ZBK2RBWkxzZHNXeDF0WE95SGlaa1ZJZWt0UnJFU2Vp?=
 =?utf-8?B?QnIweUUyY1BPVkFpcTBValUwSzRCeEM0WlhXRElGdExnOUtHSkh2SmVOM3ph?=
 =?utf-8?B?aU90MW9MWGg3QjNlN3hNYld6bS9MSlFtWXRCOG12ajBVNDNIWCs4NEJteERU?=
 =?utf-8?B?Z2VwclIxeGNlUGhMV1phMmNWbUdaOW91YldPcEFNWnkrWFROL3A0alFFU1lK?=
 =?utf-8?B?ekhoVDJGZHNDaFpBMEkrMVAwWmk5SGxZMVNCS1FiK0xuMC9nOVo1RnY0eHp3?=
 =?utf-8?B?STdSM3lFUk80bEhJbWxDZzIxbUxZeHhEMVRsWU9HZTVtY2xGeWxGUjRYR2RQ?=
 =?utf-8?B?OS9Kb2xONEloWmFSYzlNWGJndjNjaVJhVEE5UVpMSVFCMlU5TnEyWkgrSE5k?=
 =?utf-8?B?TTVPeERyNTJRQ2hlZmdzVGYvb01ySHpzU1I3OStFZmN0UEdZb1p1S2M1VG5K?=
 =?utf-8?B?OTdOaXZua1poNDNabVVvNG1zL0NueTFTK29CcFowRllKTk5vbmpad01PSFkr?=
 =?utf-8?B?UGd3eXQ4RzJEWFVPSGdycnRUTlpiWFdrZlVFak5hK1gxUVpzSnR3L0F2bGZv?=
 =?utf-8?B?VHR0VUxkREZEWXp1eGh6bmZmd3BCMmJIVVRmaExadHdLWW9JSmovTyt0UVZG?=
 =?utf-8?B?czg0dFl4Q2dhZy9DWDNQUkpGcHdsTVdsYUNYbEJpWUlqVDNQcHZDZy80UUZa?=
 =?utf-8?B?TzhRUFVrOWh4ZUNGMWJrckM5bW4vVWREWjdvZHNWaTFUMXd5VDQzaXpMdGNT?=
 =?utf-8?B?aFlmL080cytiVWdrb1FKWUxUYTZ2VjZ6ZVdNQWFVd25kbWNqaWx3d0hmdmFj?=
 =?utf-8?B?S2dmQ2h4TE1VbkhPempSdlZqbkh0UENIclViT0l2cFV5aFFiaFltMzlROGw2?=
 =?utf-8?B?VElxaElFeUxiTFA0czc5YXJpcWcxMUNyNld4cXBtMlM5emN0KzRWUlhHdEo5?=
 =?utf-8?B?LzZrRnNheXcxcEExYlVSUUhRY01kUXdwOXVvSVBDOFZOWUZuVzJTc1YxYzJx?=
 =?utf-8?B?OGVzcHJPK2dKeWZBRWFYOXF6aUF4MzcwaS9HM1c0VWlraHNINFNBSDdCbjdl?=
 =?utf-8?B?bFdqRW96VXU5WWxkTGc5SVh0VVlzYWFBNmhyOHRHbFFNaWVIMi9sOVdIMFN0?=
 =?utf-8?B?SERJUm9jeUVzOEZWOFpHMHFMSmZ6T3JCdnlnbjdhekU4WVVkZm5qTjRYMFAr?=
 =?utf-8?B?V1p1djduZHNPbEh3UGpXblYybjMrZitFUit4S203cEF0SUN0dUVCWStCeFlt?=
 =?utf-8?B?RmJvVStNQ2gxbXJYMis0ek1HcnpxbnNOeVVrUmd5OWZpdlhEUTl2TDh5Q3Jq?=
 =?utf-8?B?MFNlWk9vendOZkoxcm0zTHBEeVp4QW95ZEU3cHZMRGFMb1NvY1dvZkhSci9o?=
 =?utf-8?B?VUsyVXFPVVk5d2kwUlNUMWFZb1BmV2YyQXd6eEROY2tKZ2tJaFhnSHIwRzlj?=
 =?utf-8?B?OE5CMTE5d0NUZjlOYTdTeHdMVUNCS09EKzdTWXRZbFAwZjRkTVRTMjBsWGtJ?=
 =?utf-8?B?RXlQS0pBeHh6L0pSdzVMRUsvVVNWVkpGSGlYSExlRWpEc1F0aDRjU1k4MFoy?=
 =?utf-8?B?SU9PMFRnb3k4VDFiOTFyNytLdEgwVmgyVVFmbGNrcWpsSGF3NXN0RjJEWmQ1?=
 =?utf-8?B?R3ZYRmNld2dkMzB4MkxiYmtHZ0lNbXVxOGJJWW1ETTFhZmYrdjlOMVVVd0U2?=
 =?utf-8?B?ek9NYnArTFg1V2dYVHZCOEU1MFRueVVWaTd4VlhtekdleW5SbGNJNHZWVGk4?=
 =?utf-8?B?U0JDSlhXOFpKRXJGc3FONmlmS1RoNkJKbWJuMU9pSDlGZmI2aVhpM3hPV2p6?=
 =?utf-8?B?anVUMVZqOTVpU0xBT0E3aHhPMEhJQzZOZTk2N2FJS1BlRmNSVlZ2NmprQmtO?=
 =?utf-8?B?NmlCWHhFelRkVUhiNUhidFBmNEdVQUxEckhDWkQzRWxJNUw5NU15RDZ5K0x5?=
 =?utf-8?B?UVVlSWo5NytjV01SSFZzL1BxK0xtMzQ1V3ppVG1STEdJNFVHbjdSUm5POVk5?=
 =?utf-8?B?NnZPWWErRnVYdy9FUER1Z2NXZHRYazBoS1hCY2pMRHdYdFR1YUJOZVBEWVg2?=
 =?utf-8?Q?hIPZKi+/e9kWybzYTaWK+mZQijqEc/pzvU90obKAoOx0s?=
X-MS-Exchange-AntiSpam-MessageData-1: OZ2gwqyOygJ249EWK/7RvWNmYkLEe0Aqp20=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e4f38b3-acd8-4716-9079-08df4c653b15
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 09:02:57.8506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W3nG34qo4xiJr6U2pvfEf6/5jiWa6x7kkyGkhg5e/zTOXH1yjA3sPDNbtjQLuwJYlnLGQNtn1kBuxQf/mq5dqP21gss1EPhrAPoZiDRYSjw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB9197

On 11/27/26 09:27, Gabriele Monaco wrote:
> On Fri, 2026-11-27 at 08:05 +0100, Tobias Schaffner wrote:
>> @@ -110,10 +111,11 @@ static inline void da_monitor_reset(struct da_monitor
>> *da_mon)
>>    *
>>    * The monitor will ignore all events until monitoring is set to true. This
>>    * function needs to be called to tell the monitor to start monitoring.
>> + * @state is the initial state, stamped with its entry time if known.
>>    */
>> -static inline void da_monitor_start(struct da_monitor *da_mon)
>> +static inline void da_monitor_start(struct da_monitor *da_mon, da_state_t
>> state)
> 
> So the idea is that monitors using da_handle_start_run_event() would end up with
> a few nanoseconds more in their initial state instead of a 0. Right?
> Maybe more if preemption is possible.

Hi Gabriele,

thanks for the quick reply.

Not quite. This was my attempt to fix the sashiko finding of the last
version. With the timestamp set in da_monitor_start() the first edge out
of the initial state would be counted with a dwell of a few nanoseconds,
even if we do not really know how long we have been in that state. Now
we just skip the first transition, so it is neither counted nor timed
and the counts still match the model.

> I don't particularly like changing the prototype of da_monitor_start(). It isn't
> used by existing monitors, but is a public API, so I don't want to send the
> message that monitors can start from any state.
> 
> We could either:
> 1. document this timing discrepancy and live with it
> 2. reset the timestamp just after da_monitor_start() (done only once)
> 3. create another da_monitor_start_notime() (can share code in a
> __da_monitor_start())

Fair. Sorry for not having this on my radar.

Do you agree that 3 is the cleanest option? I would prefer it over
always having one wrong sample (option 1) and making sure that no event
slips in between start and reset (option 2).

Best,
Tobias

> What do you think?
> 
> Thanks,
> Gabriele
> 
>>   {
>> -	da_mon->curr_state = model_get_initial_state();
>> +	da_mon->curr_state = state;
>>   	da_monitor_init_hook(da_mon);
>>   	/* Pairs with smp_load_acquire in da_monitoring(). */
>>   	smp_store_release(&da_mon->monitoring, 1);
>> @@ -276,6 +278,11 @@ static inline void da_monitor_reset_state_all(void)
>>    */
>>   static inline int da_monitor_init(void)
>>   {
>> +	int retval = rv_edge_stats_create(rv_this.root_d);
>> +
>> +	if (retval)
>> +		return retval;
>> +
>>   	da_monitor_reset_state_all();
>>   	return 0;
>>   }
>> @@ -287,6 +294,7 @@ static inline void da_monitor_destroy(void)
>>   {
>>   	da_monitor_reset_all();
>>   	da_monitor_sync_hook();
>> +	rv_edge_stats_remove();
>>   }
>>   
>>   #ifndef da_implicit_guard
>> @@ -689,9 +697,11 @@ static inline void da_trace_error(struct da_monitor
>> *da_mon,
>>   static inline bool da_event(struct da_monitor *da_mon, enum events event,
>> da_id_type id)
>>   {
>>   	enum states curr_state, next_state;
>> +	da_state_t old;
>>   
>> -	curr_state = READ_ONCE(da_mon->curr_state);
>> +	old = READ_ONCE(da_mon->curr_state);
>>   	for (int i = 0; i < MAX_DA_RETRY_RACING_EVENTS; i++) {
>> +		curr_state = da_state_of(old);
>>   		next_state = model_get_next_state(curr_state, event);
>>   		if (next_state == INVALID_STATE) {
>>   			react(curr_state, event);
>> @@ -699,7 +709,8 @@ static inline bool da_event(struct da_monitor *da_mon,
>> enum events event, da_id_
>>   				       model_get_event_name(event), id);
>>   			return false;
>>   		}
>> -		if (likely(try_cmpxchg(&da_mon->curr_state, &curr_state,
>> next_state))) {
>> +		if (likely(da_state_try_commit(&da_mon->curr_state, &old,
>> +					       next_state, event))) {
>>   			if (!da_monitor_event_hook(da_mon, curr_state, event,
>> next_state, id))
>>   				return false;
>>   			da_trace_event(da_mon,
>> model_get_state_name(curr_state),
>> @@ -737,7 +748,7 @@ static inline bool __da_handle_start_event(struct
>> da_monitor *da_mon,
>>   	if (!da_monitor_enabled())
>>   		return 0;
>>   	if (unlikely(!da_monitoring(da_mon))) {
>> -		da_monitor_start(da_mon);
>> +		da_monitor_start(da_mon,
>> da_state_entered(model_get_initial_state()));
>>   		return 0;
>>   	}
>>   
>> @@ -751,8 +762,9 @@ static inline bool __da_handle_start_run_event(struct
>> da_monitor *da_mon,
>>   {
>>   	if (!da_monitor_enabled())
>>   		return 0;
>> +	/* In the initial state since an unknown time: do not time it. */
>>   	if (unlikely(!da_monitoring(da_mon)))
>> -		da_monitor_start(da_mon);
>> +		da_monitor_start(da_mon, model_get_initial_state());
>>   
>>   	__da_handle_event_common(da_mon, event, id);
>>   
>> diff --git a/include/rv/edge_stat.h b/include/rv/edge_stat.h
>> index 8b99e8520e1e..16c28aedabdd 100644
>> --- a/include/rv/edge_stat.h
>> +++ b/include/rv/edge_stat.h
>> @@ -145,7 +145,10 @@ static void rv_edge_stats_remove(void)
>>   	rv_this_stats_file = NULL;
>>   }
>>   
>> -/* A zero timestamp marks resets, which can run on a different CPU. */
>> +/*
>> + * A zero timestamp marks an unknown entry time: resets can run on a
>> different
>> + * CPU, and da_handle_start_run_event() starts in a state entered earlier.
>> + */
>>   #define da_state_entered(s)	da_state_pack((s), local_clock())
>>   
>>   static __always_inline void
>> diff --git a/include/rv/ha_monitor.h b/include/rv/ha_monitor.h
>> index 6e1c7fe5449a..78d1bb80aefd 100644
>> --- a/include/rv/ha_monitor.h
>> +++ b/include/rv/ha_monitor.h
>> @@ -312,7 +312,7 @@ static inline void __ha_monitor_timer_callback(struct
>> ha_monitor *ha_mon)
>>   	if (unlikely(READ_ONCE(ha_mon_destroying)))
>>   		return;
>>   	/* Ensure consistent curr_state if we race with da_monitor_reset */
>> -	curr_state = smp_load_acquire(&ha_mon->da_mon.curr_state);
>> +	curr_state = da_state_of(smp_load_acquire(&ha_mon-
>>> da_mon.curr_state));
>>   	if (unlikely(!da_monitor_handling_event(&ha_mon->da_mon)))
>>   		return;
>>   
> 

