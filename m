Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020114.outbound.protection.outlook.com [52.101.191.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B01863CB;
	Wed, 26 Mar 2025 19:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.191.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743018985; cv=fail; b=IQXe2ney0VDQIhIXlC1zknKgiYZ/LGVhlVhHG+2kviQ5I+BMR9pYta1ZfiBU29EyPgPeQObxuDGAeUnF5vSdin/2/U4n8nbUbMjcBKxuclxKcf6Z8MMojW2+1imYx4X6hz1GBpYaU3SlQu1K5MF/J59MhW4Ge8JX+irliYcPYWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743018985; c=relaxed/simple;
	bh=NHtR5AlamXQyrbab0QBRQLTwn9si89/q+PSv+sUxSnI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=t4mwidCSIeh7PhdBqcqTTt8r+A9Y/ABmNu93bGwHiUiXTjj6ild2zIGyBYnOWlvoYV6eBlBDRHuNuAfaDA/N+7j/uZIbS+BzCODOd1QfIrTu8aT1jjtJlaRaFU7bXeGmslz1MmhFVbRA4IIB6hczI4y+k6p+NkUWPrWoUwPItBo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=MzIUJ+U3; arc=fail smtp.client-ip=52.101.191.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="MzIUJ+U3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jx96z/Ldt8HsWj19PLTEDK7aHeHL0MR0jf+/79lNYdeoV0s4WwMUOnVo5+50XJ3NwVFWLbsopPWYSIi7TPwrRbwsE1Y3Te9DHHH19vOY7/6PT/IehgbGZW8qbs/b35hOTnUN3SXlAiiF3S+1Q1cn5OwNZrBifSTHl669evfSCQ6NfKj+1K8rFDe3X2xjR3OswxlXWfwjhejk8aLfIF4O/qGh0i6DSeDZ2q1f7a7xdh+fjs/M46oXogcYWnTRzOpTjXWQeo21LCy0QDQvS1OLvWGRphllR6Xgbjlph0A46IgulV2mwPSSW5pLDWXfVCb72un7KBEAE6Fye0fGUx+Cgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=btfdolz2huqbkRDWzeh+Fyv2BpAYoyTpZgwSBP1e+30=;
 b=L7uv1Di/d63GvJ/I6cfflorINZDVwcrTZNzYDkua7yW8KEEfwDeccfv2m4Jco/TXoPxVPPATNi3D5s+ZTB2ZIyFU0BlhxtSefisbl2SF7nM99P6P+CmfzLK8P0JdfK8tHWXDyqvzZesuGz7UbRffZMwHIjWwQrioQHNy+Gda8NSL5xmVIE59Qk4CUpbicBxRGGLRIsidrmAC42eqU2FT6Gd3UfBWxVD5Nrv17aCql2bCKp2iKY2hZRdpTVYcVSotMKXEkhHmwcJwWGkzPNlWCkN/DYdjyUoZMAFGf9go+cWZ4cEQSvSEYqcqkTanhPJBBl16n9Cdpgxg+i/fYaiaYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=btfdolz2huqbkRDWzeh+Fyv2BpAYoyTpZgwSBP1e+30=;
 b=MzIUJ+U3WPDqdsiUsLXmEchKSmKdkAZP3+sRZetzr6gWu6SDzNeusupWKul2+EKLTvPVpmxq9Q0rCQos7ttlr1eijotBm4OOzL/o3chqwOmQMF4T0QjpwUEw2pfObHlh6Ayca2WXzvm2J6u/VziZFP1UToIMLhUXM3aRarppKXOhM7kFwRPq4LHFUfOgeCBuHsqn1z/4gssNM4zToiK8sHq+lgKT/VYgrjuNke2kVspaeKsfY43ASmRMRSdVsf9juQZa6ppOGyl33+uZRbRwskzjvvQjqiePIfSuEf2uVX555Mxfh2/TEsKek63ejqZhijSpqXGz5cJcq2rEPfcuXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by QB1PPFFF56697F8.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c08::2af) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 26 Mar
 2025 19:56:19 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%4]) with mapi id 15.20.8534.043; Wed, 26 Mar 2025
 19:56:19 +0000
Message-ID: <67e2a6a1-8c9b-43d0-b960-10cd47c08873@efficios.com>
Date: Wed, 26 Mar 2025 15:56:15 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: use per-numa-node atomics instead of percpu_counters
To: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
 Andrew Morton <akpm@linux-foundation.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Dennis Zhou <dennis@kernel.org>,
 Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
 Martin Liu <liumartin@google.com>, David Rientjes <rientjes@google.com>,
 Jani Nikula <jani.nikula@intel.com>, Sweet Tea Dorminy
 <sweettea@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Christian Brauner <brauner@kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Suren Baghdasaryan <surenb@google.com>,
 "Liam R . Howlett" <Liam.Howlett@Oracle.com>,
 Wei Yang <richard.weiyang@gmail.com>, David Hildenbrand <david@redhat.com>,
 Miaohe Lin <linmiaohe@huawei.com>, Al Viro <viro@zeniv.linux.org.uk>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
 paulmck <paulmck@kernel.org>
Cc: Yu Zhao <yuzhao@google.com>, Roman Gushchin <roman.gushchin@linux.dev>,
 Greg Thelen <gthelen@google.com>
References: <20250325221550.396212-1-sweettea-kernel@dorminy.me>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20250325221550.396212-1-sweettea-kernel@dorminy.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0371.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::16) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|QB1PPFFF56697F8:EE_
X-MS-Office365-Filtering-Correlation-Id: 9eeca7c7-9794-4c45-f54a-08dd6ca0466d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QjlVV1Jla09tZlpXNFlCRVh1SFZPQkxYTXRpR2xVd3U1M0ZoNm5FS1psSU1W?=
 =?utf-8?B?N1I2ZnViS3Uyc0RVRW5xR2JRNjlqdS8wZm1xTzVGa1dvWEpKcElhQkcyRWFM?=
 =?utf-8?B?QWZBVkgwRitLNlQyQ1hqQjZiUXRSRkE3UFhsa1NKOVpqejdyUmMvT2ZJTWFJ?=
 =?utf-8?B?dHFjNjM2MDMyTExvbFNqUno4VVpOOUpoM0FnbEh2czR5SDkreUpGaXR6OEtJ?=
 =?utf-8?B?eWpaQXRRMG9QZEp3Y3k3TDMyT2toQTlJWHpXblJheFlUMmdRbWZUNURPVWFS?=
 =?utf-8?B?enI0clFjYk5yMzlJVVpKVzJCZ0lNbXhaenlpekh1Zms5dGw0RFlRWmRsNCsw?=
 =?utf-8?B?a1NBR2JVbVFNMkN2NVEvWXVsTEZOWHFuUENoMjdpYi9zZTdidmpHS1M0MHlu?=
 =?utf-8?B?em1aY1IwNldzRkRwZFNiN1F0cGdmZ3U3ZEozVUJnQm5jT3o2aElXWEZIdm9N?=
 =?utf-8?B?K3NHMkhCaHp0WUZycGljVlNDNUZaTENuQVZ2RFluOCtBTk1NMWE2SDBvZURF?=
 =?utf-8?B?OU1hNnpiazBDYW5CUnZvR0VKb21zY2I5VW1XS1VXZEtMaHBRVko1R25pQ3FK?=
 =?utf-8?B?VEVVRkx3UzM4YThHQ25nZnJrSE5ZN292Nk5XbVRpbzNnbmt5MDdwY0N1Yldy?=
 =?utf-8?B?ZW9PZGg3dzdnd2pybDN0SktyaUxDL241Q2lYMXlOUTNwbmVmMVA4cmh2NnFO?=
 =?utf-8?B?RjBKajZjWHBQT2hsSk1aUzl2bTNyU0JiVGgzTmkwVzVJTEVjRnpOd1pVa2RE?=
 =?utf-8?B?QjNqM3lSNmgrV3BWS3I5eFcxdWkyOHNBZlV3NFArRjh5V1FqZXhBN3R6bWlD?=
 =?utf-8?B?dnY0SWI0NGxxSC80Qkl2R3dXMEZ6TDVYdFRaZzBjSmFOTjE2NE1zVTF2NVVP?=
 =?utf-8?B?WWFOcmN3czBGb1dXckZ2UElEQU5yMkIvNnVESHFMM3dYMHk3SUlOU0xuMVEx?=
 =?utf-8?B?MklxL3h5M1k3bm1CcC9uU3YvMEVsSmh0VlJYWUF0ODhGbFJuQTgzZDVMOHdF?=
 =?utf-8?B?djlOQUhFT2JQTndKZythOUhHRFR1cGhRanNWdWdpQ0tnODliOUVHSXFsdGVw?=
 =?utf-8?B?VlJ5RUh4MXAwU1BEY0I4eDViZGJiZGZRUDQ3MHJCeWN1R0RBbWlEOEpmZGxm?=
 =?utf-8?B?Zjk1bk52YjgxYWN5dlpZRjMxVXBnV1hsMm50ZEU5SkZnd1g0WFFSTVpEU2or?=
 =?utf-8?B?c3N2djlwTVl2TUh1MEViSE8rbS9DQ2NPZkZNUk45dXE4NUMwVnUxMmx4d2tL?=
 =?utf-8?B?WnE5aWlscEVVZDlhaHhpOU42cHYrQlhoaXo3akMwdlYxSFFmV1pBOTQ3TDNy?=
 =?utf-8?B?N0p6SkxpY3hxT0VheXNML0p2WHdCaVlTNTdIenlNaXZVaEU5Wkh0ZnoxdGVw?=
 =?utf-8?B?bEloektRa2wyV21YcE1ZS3p1REptUWdMc2g5OVNSRFJRdEhvUk5CVjRUQ0Fp?=
 =?utf-8?B?Z2x4WnNyblVmMERBekNzUUE4SUJnUmV0dkQ4bTl2SldSaUd1L3VDT2hBNXNJ?=
 =?utf-8?B?TnNKTGJuOXozZVZNdWdTWlFIQlMyTGhuM2dKak0vVCtIM3VFdnkwRytIT0t0?=
 =?utf-8?B?S2RJVWpQVktzcWY0NjRrV0wrdGUyM3M4MXZCU2dJZThEcDZQMzNqbzV5Uldy?=
 =?utf-8?B?UmV5VW12YjlUNFowWXh0dUZXWmVUVlllVlBXaEZSMXl5cXFnU050VWM5SXlQ?=
 =?utf-8?B?d1g3NFRqU0R5bC9sbUF5aUNNbGdPSkJsdlBHTFhZblJocGpYU0F0QVFvZElT?=
 =?utf-8?B?QzhKc2M5T3kwR3kzT1p2bi8xNis5Rk0zZmZ6RE9kVld6a0dsK25kN2dJaE9h?=
 =?utf-8?B?SHRhTStNK0F4TU04d0VLckxjYk5QdVpkckVFNjBvMWZGSFUyZ25YWE4wZldj?=
 =?utf-8?Q?hPMi1CdSUCnhs?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K3ppZWMxbERQRDF0MkZjK0xHYmJOamFGbUdlQXJRWkxuSkQ2TTM1c2RtN1pI?=
 =?utf-8?B?Z3I4bzhNTlFLa2RDMTR6Q2c5ZWNidmloWnpmYnpySFdsL2NOVCs2TDdIczl3?=
 =?utf-8?B?WnZXaG0vN0VtaVFjOERCanptQ0VHVThIaGxEL2h6d3Y3bXZmM1J3M05Sc0ZO?=
 =?utf-8?B?YVpMbEJqL0p5a2h1SXlSYjIvdE1pUCs4OWVReWhwbHE5VXU4VzFmdTZUdmFx?=
 =?utf-8?B?UmVHTkZ1Mm9VV3pZd2FwSDNxVUhTbWJuVGcydzlsNm1UVzNmeW5MQWdtbnd0?=
 =?utf-8?B?Zjg0MkIxa3V4SXA0cjJoS1lqdWtyY25veGxCem9pdy9TMXZYcngyTE1HUFBn?=
 =?utf-8?B?V1F2S3BRbzlGMnRWNFdIWlF1RnBySHdCWmRUQjFVOHRNdFZoVWJoUmI0dUFI?=
 =?utf-8?B?RFJXbTBZczlMelBzVFkwN2IyS3ZDTFU0ZDRFNXl0NG84SG5KSDFseGRiSHBS?=
 =?utf-8?B?L2JOZ2U5M25EWG1oTjBpZTVBa2c3Vm9kZmFOOSt0dUxzNGhpTWptSVg3ZnFx?=
 =?utf-8?B?V0h0Z01ENmVXR3NHMnFxWVk5ZWdTTjIwWEtXK2tMSVN1dXV4L2VuaDc0ZzR6?=
 =?utf-8?B?T2FIazRGMDFPenpUL2t2OEl5cVFUQWl5dUx3ZS9MMWlOcnZBQXU5MUZQa3lZ?=
 =?utf-8?B?ZmZUaENBR2QxMVBtOHZXRzNFQ1lSbXZGSjhMWFFhYmR6QlprK2pmOFhOMHhF?=
 =?utf-8?B?OVV2OEpGcVBqUHFteGR1Q2pVaXNEUWI1aWg2SUx6UldOWjZQNW9KNytjZGMv?=
 =?utf-8?B?T1RrcXRrM01tRWRMZWpkNHd0K1pKRnlQS0c0Wm9BcWJUdCtocU9sem0rVnhC?=
 =?utf-8?B?cjZjdWlmamFLUnM5Y2JDTVpHampaVXZFUWZIczVCeUFOUzZxdzRyRHpQQnp6?=
 =?utf-8?B?UWxwSHZBOHVYSkl2c29sZHhnSUhyWEpONTNVQTZvWnRZaVpZd1FEUVJlSlJa?=
 =?utf-8?B?WEFkak1vVmFZK3Robk9zSWhZd2d4RmhVMlczSUI4S3l6Ykdmd2hOZys0NW82?=
 =?utf-8?B?SXlraHZGNUZqYmVxeWttUlg1L29yTGhNVGYvUUpiTVlGeTJpSDJXU3pLWS9H?=
 =?utf-8?B?Tmt1dkZlSTZOb0pNTXdMQzNXSWlDNGJwQitUczZQaExnWEpFWEtXTnZJNG92?=
 =?utf-8?B?SHplQXc2SE93aU5NS25BekZJcmZ4ZVp6Uk9TZEM0MWo5a3FPRFR5eEdPcFND?=
 =?utf-8?B?eHBHVVF3SXFwU2g4WmJVMWdlRGh2Z0VCN2V2S2ROU3dzaEpQdFFFNCtnZEJn?=
 =?utf-8?B?NnhFVEpCWEZJb3QzbERZUVdOVmw3aGZGWk4rK05sU0NIM0VtckJla2VHMC95?=
 =?utf-8?B?bXMvWng4UnRLdVloTVFqZnNIcVlxRmlNNDVjVnZLRUZ2TXA2RGlmSmNJa1lX?=
 =?utf-8?B?d1dLVWNNZlh4UmlNMnZLNFVOSjd3QklmNkVXNGY3eGJCRUZDYlRZeHdsRG1H?=
 =?utf-8?B?aXNLMU9EMzFMWDBWUFF2NWp4T1pFcDNwNHRTVnI4OGtnMTh0MnA4QTVZOHNM?=
 =?utf-8?B?VmVFWFltYmJkNGttNEJ6b25qa2E3REJ2MjNqNFErM2NGZWk1UGlnZGE0dUFO?=
 =?utf-8?B?T0lTM1dMalNmVi9MOXBpcnNvTHpoY0xNaTYrZGZsYVdla3lQMkxMT1FPUXlD?=
 =?utf-8?B?M0YxRVNFRjRWaUhlWjNvZ1o0eHpvRGxIb05CVzlkeEcvT0V6cGVTNVVpYnds?=
 =?utf-8?B?dU5zbGo0UXRoaklVazc2SVNkbzZnNjg3VCs4SjR5UmZBS0xqYjBwbWZxbnRK?=
 =?utf-8?B?SVZJOFM0eEZRQ2pjaE9wcnFoRW9xY0Jpb0U1dVhrNnVBS0gwanM5OGRSRzl4?=
 =?utf-8?B?WFYyUk14bzZnb1lQalhiS1lmdnJGTDRHTUpiaUJiSWs4aVl0b1pFbEJYaVNR?=
 =?utf-8?B?M2JUZm1IWXk2VFBsUHZYUERWb1lBUVNFVUhmTnJ2Y0JremRkaTU0WHNoT1Vp?=
 =?utf-8?B?U2JrV0lzd1dyb0V0NHVWd3FCZDBQMGJiUVdXS3J5NW5qazMwbSs2UXV2cjNM?=
 =?utf-8?B?RldYSExBbytsQ1dKb0ZGVlNtbDZrY1dGMVBIOGVpZzJ0dEkwRmV5ZzdLdUpi?=
 =?utf-8?B?d3haaS9yckxzUlJEZEdwdUt5RWovVFd0YitJQTRueUFuaTFDbC9DOXFLKzBj?=
 =?utf-8?B?YmhwZ0RENFdRTjFiN05vdFd5M0dyME1yZzJnMzBxQzFwUUtkOHl3Z2NMcmN1?=
 =?utf-8?B?VkE9PQ==?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eeca7c7-9794-4c45-f54a-08dd6ca0466d
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 19:56:19.2021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vULFCyeplCHMP6Q1IEgsyek8N9cLZQtgjGFUTwvzagZrMbQC+yG+JaxLEmpJXgYyD5RbpanZTs4u/dANx2gkj/EUpjeYghFrlvN5+FOmzvU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: QB1PPFFF56697F8

On 2025-03-25 18:15, Sweet Tea Dorminy wrote:
> From: Sweet Tea Dorminy <sweettea@google.com>
> 
> Recently, several internal services had an RSS usage regression as part of a
> kernel upgrade. Previously, they were on a pre-6.2 kernel and were able to
> read RSS statistics in a backup watchdog process to monitor and decide if
> they'd overrun their memory budget. Now, however, a representative service
> with five threads, expected to use about a hundred MB of memory, on a 250-cpu
> machine had memory usage tens of megabytes different from the expected amount
> -- this constituted a significant percentage of inaccuracy, causing the
> watchdog to act.
> 

I suspect the culprit sits here:

int percpu_counter_batch __read_mostly = 32;
EXPORT_SYMBOL(percpu_counter_batch);

static int compute_batch_value(unsigned int cpu)
{
         int nr = num_online_cpus();

         percpu_counter_batch = max(32, nr*2);
         return 0;
}

So correct me if I'm wrong, but in this case the worse-case
inaccuracy for a 256 cpu machine would be
"+/- percpu_counter_batch" within each percpu counter,
thus globally:

+/- (256 * 2) * 256, or 131072 pages, meaning an inaccuracy
of +/- 512MB with 4kB pages. This is quite significant.

So I understand that the batch size is scaled up as the
number of CPUs increases to minimize contention on the
percpu_counter lock. Unfortunately, as the number of CPUs
increases, the inaccuracy increases with the square of the
number of cpus.

Have you tried decreasing this percpu_counter_batch value on
larger machines to see if it helps ?

Thanks,

Mathieu

[...]

> 
> base-commit: b0cb56cbbdb4754918c28d6d7c294d56e28a3dd5
> prerequisite-patch-id: b7b47d1b9aa3fd887dd718ab276581f120e516e6

[...][ cutting the gazillions prerequisite-patch-id, please review you use
   of tooling when preparing/sending patches. ]

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
