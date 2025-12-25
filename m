Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020124.outbound.protection.outlook.com [52.101.195.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216262E6CDF;
	Thu, 25 Dec 2025 07:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766648293; cv=fail; b=qWASV9XxZNoxR1Lwhay/KITsARQ0Cf2BpKvHwVnk3gOI8awmqyFwEwID0a/1lR71IYjvGA+1evpDpDNn/xUvgwgcLosKC8Nt82JQ0XGWKQ062PD67WJh156clsJDUBE4DXfyWoFORTqPs6bisTcTA2rmjwjF+ByaXNxd4n8srWY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766648293; c=relaxed/simple;
	bh=bwxk0EMZBPnOaEKJ8E2deAXHmPkgbPbOvW+LahpPsE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EhT0OmChePpmVFVVml/cwXoHwTBcGT2CDGt4gom22zZkXKjfv3Jq4ounobpqpv4UMHvMHPxTc3xw+BGmO8C/Cpd5Zk2VE/MzMPItKaaZOkk5m5UQefdPOOCtg3dHR1HiovHNdNNIGjClgDJba28wQ4FAOhPGEOcs7BFfLFb1jkE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.195.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tDzRumlJrlkYlY+Ynx6jfwDeqAzHCzZ0e6ywdaVS2w4dyhKjmzcG1iI1AOyEpXSEIENmIDxKR9hd6UsntoenxCWTVl9TCUxjed+tR5OGcXR4s0eq74erhHp4pSIwsAeO/8JeN7WC1F6KsZ3vYZwbmLNWrq4Bh/1+eumZv3Unm1CgTZv3d4qu3KRnVqJtjprWtHhNA7oygAMVwira5JAUb49bcxUzznf7xZX4XOGSl2iwwE6GNyxUaT7c1Qs1vKhA17pZctsKsubklJNj8eeee44fww4dV5FAz54hHHLiqmbxQsoxFzO+RtyD599sScqc6VQ3UgZgxbu73xMZpXrVhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bwxk0EMZBPnOaEKJ8E2deAXHmPkgbPbOvW+LahpPsE4=;
 b=yt6tXFQx2x0k5bm5ISsye2LKxh87gAO1CyPuYq4xKzgLj0Q7SRNV4R7AGqDxNKveEOXG3imlAB9rdXNQKSPzrih1Qes33a+8+JMoPrBte7+gUASiKeooAP3vHIsMtUMWXpQGHJ+YbtM5X6H4ck3bjC3wfhXI8j2mY+04j9jAmKMoBdETWDtYULZ5HzyGXOwtZWxmVaLM3uH7g6CiTGBVZcvyQrstftSkXuD4BuKTzFQDFhe/1z9BlnbtMSYMZmDgu+UbmENo0BmDAQBjbIzeoUk5implfK4XTJ9fReltg2gnxLBnVFkRVmPLl0Gdh5gxyu501DidAJDN9+djCURk7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by CW1P123MB7820.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:243::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.11; Thu, 25 Dec
 2025 07:38:08 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%5]) with mapi id 15.20.9456.008; Thu, 25 Dec 2025
 07:38:08 +0000
Date: Thu, 25 Dec 2025 02:38:03 -0500
From: Aaron Tomlin <atomlin@atomlin.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, mark.rutland@arm.com, 
	mathieu.desnoyers@efficios.com, corbet@lwn.net, sean@ashe.io, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] tracing: Add bitmask-list option for human-readable
 bitmask display
Message-ID: <qw6wgsrmuu4vhuam3ay3zdsqxlowbe7xqrh3wolei7bnbkkwyw@jshbmlr67goc>
References: <20251223035622.2084081-1-atomlin@atomlin.com>
 <20251223133452.416fd539@gandalf.local.home>
 <wgkjg2bpsyonl5qkgxgdrpmzzaduuyiti7vtifxbtdnmlrhptl@jchrtoaltfv3>
 <20251224085848.26387f5d@gandalf.local.home>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="t453fvmlhdws3bej"
Content-Disposition: inline
In-Reply-To: <20251224085848.26387f5d@gandalf.local.home>
X-ClientProxiedBy: BN9PR03CA0535.namprd03.prod.outlook.com
 (2603:10b6:408:131::30) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|CW1P123MB7820:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c312e67-7119-4a85-561e-08de43888bf2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N1BqNXF4MDhKejR1eVlJS0ptbmpaRjNuc2NoQ3l0ZmZmL3Y2RFpsSFZ1SEdQ?=
 =?utf-8?B?UCtxZWdud0l6bXVBdDFyd0ZUVEpBdkRNQmhtU1puL1ovZC8zb0FuUWxQd1hP?=
 =?utf-8?B?dGovdTVXcjBXZEtxbGVMd09QcGJmeWNwc1FJZGkzdVNCSDZrd1FmYllOd3pT?=
 =?utf-8?B?WHhqZDg2dGFBSzZ0Uk5tcUpmKzRSbGN2Y2dxV0F3ZlBiUDVvOTUwZm1uek1X?=
 =?utf-8?B?bXZ6TWJtMUI5dURsZU11RzRmT1hzRHlMQk02SXkzQjdVdFBHRE1TOGhnbGgy?=
 =?utf-8?B?TnpoSVU4anpyV3doNzVKZzZUTG5JWXhqNmljZlBsdVJ1YXFMTG1vVzR5d1JK?=
 =?utf-8?B?RkluQWtFYVhiaTdUQ3NkUkIwdGd6RW8za25qay9HYk1KV2FEUTk0VlA2NFQ0?=
 =?utf-8?B?RXZjSUwzNFFsdUZQc3BHTWRtRXg0UXZUbWFlV0srb3Q0aU1SLzZ3TlNEYVVa?=
 =?utf-8?B?QTc5ZWcyeStFZEhqVjdWcFBPWWxqSjY1dkdSU1BlRzNLQVppY3JuNGNTbW5P?=
 =?utf-8?B?ZWJUVThqdEh2aVI4TTlPTDVxUlFGZ0NzVjVQNk1VbmM2NmFad29IbEgxWGhM?=
 =?utf-8?B?MlRtY2o1Q054SFpqdVpsYThhZXJiZWpoWERvR0VaN1V4ckRPMlNxcUdLVDVH?=
 =?utf-8?B?V2FPdGN3RGpkVW93OTJsSzFyN3FwRDcrZDAyUVFGeCtGUkwyMUJ6UG1jWGdB?=
 =?utf-8?B?RUV4cXZIc0h3bUJBZCtnVnU0NGZ2TGU4TDFwenRTck1pcHV1SlRJNDFXSlo3?=
 =?utf-8?B?Qi9aaFZzVThZWkQ5c2NvaXUzUmxRYTRCUHRHKytYRHpBUGJlSWtPMWtoY2xx?=
 =?utf-8?B?RUFTNERBbXNtbDl1L3A5eGk5cGRQMWhqRWlpUkpqd2laV2pWclZXaHpNTFk5?=
 =?utf-8?B?Qk1IMC9yRXV0d2wzUktLQk1MZ1V6TG5nSlZ4RE84ZjlUcHIrR3o0RkpwOExI?=
 =?utf-8?B?OWpaSVdzV3Fwc2RuZ0ZHdDVqS0JKcHF5S0Z4MUl5aXJkaU5SR21OckRTbFMv?=
 =?utf-8?B?dDUyckM1SEJuVDJCanRmMXZWRDFXQ2s3cVJPNUxzS2VMaUV1blFXenNTQU1k?=
 =?utf-8?B?NXc2MFVTcnY2aFJkQk5EMm9jRU9xVGk3bittbCtIOUg4VmRXL3FVZW5xdVNp?=
 =?utf-8?B?cUVUbldzU2V4TXlkT1h5dzU3UENmV0J6VGFEOTFOeFlUYkEvelB3c3VxdFJv?=
 =?utf-8?B?ZWZGZW0wTERQVEJvODVPRUVsV0c5WGtkN1RYYmJBTnM1eDhocmhkQUg4UFR2?=
 =?utf-8?B?c1Z1eFNPWFNxSC9UTUw3cFVtL1pzeFlBb1ZTYzFjZHA3NVdzbkJEZWJFZG9m?=
 =?utf-8?B?LzBpMUs3YzErQTlzdTNsZUF3OUFIN1l4cU9yUTdsb3g5MDJEQU81U2NiSVZ6?=
 =?utf-8?B?Zm5RVWRoVHNMbUNidlFDeVpONlN4M082ZldoS0l6ZmgxOTdyVmFISk5Ub3pN?=
 =?utf-8?B?UmVKT0ZvbER5QkdVeFRnNEkxYXZSWFM0Z1N6bkhveWp2SzNpYXhxKzVGWGNN?=
 =?utf-8?B?QWI4b0hpSUpRYlZjK1l6dS96R3FKdHIvVllVMWFSa3B0ZlRUSnRiMG9vTFpz?=
 =?utf-8?B?M3Zvb2ZJWkJLZmh5WGlUK2VPT0JNQmRmTHlZNHBGWjVOb1pJNjc5Nld3Z25j?=
 =?utf-8?B?aGpmNTIzMjJ6TER0THRTeXJxWFdjL2tYc05jR2I1YVd4VlpXWE4wMEZNeU9t?=
 =?utf-8?B?TFJSMGZwN214aTJHRUJxck14NjFuRWVBM251SXlIN2dnWkN3ODVNSUUzTmNi?=
 =?utf-8?B?WXQ0QWNhb1pqRUtWTW93V1VYYlFpVXViRFpHWW9vbXFMQnR0L29yRUxxOFFv?=
 =?utf-8?B?MHlNSnJXTGtJVzk0bUFtNy96WWxaTjdPMkZqNHVTSFRzVG1FRll6UEpVUHRY?=
 =?utf-8?B?ckkwQkZ2d3g3WUw0Q01HT2JJL3A1WUREaml6YXRpVlVPTmczc3NtOElUYktB?=
 =?utf-8?Q?e6ViZ2JjTDw2iwp9EqjzWhGVGIw3pOUz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cG5SWENPNzdRVXRBa2xpaVMxaTdDZ2o1Wk5sSDY4RU5oaThpTFFKazRuRk9m?=
 =?utf-8?B?SWhJY3BBd3FzV3pRb25odDdUdEl3d3NUSURvYjBGanN5NStEZ0ZvVGFIbExu?=
 =?utf-8?B?THVmRTJEaDlzRE5PVnBFR2Z5NWZMWW55ZS9rKzVRbjVIb2Nxb0kxdi8rQ3pq?=
 =?utf-8?B?elp6a0ZVUms0Y0ljaXdJR0w2WWxXQlJpME5laEtrY2lyb1NkeFkyU1ZWSFhq?=
 =?utf-8?B?YlpOU1RNaXVSMHNBbzdFUXRLc0ZmdjJHL01DZnA2MjVaS29CMkFiaFY4dWhq?=
 =?utf-8?B?bGt6RlhsQURSZnVzMUJaL2h0RVlzRkNUMzV3MUM0WHlOenFpaFlDbjdNZnVX?=
 =?utf-8?B?TThGSWpwZFp1Zk1lckdwb2l3ZnhUNWkwNjljbVlIUERGSkpRaEFDOUkyVG5U?=
 =?utf-8?B?VDRuNFllRG51M1UwanFaQmZiL3BPR1JiRDExNk1hV1dVSXpSeENnTTFrTVFX?=
 =?utf-8?B?TmRncU9WYUxyUVFLOW5kUUZ6Zm5ST0FGSkJWWmg2R2g1OGhGQXBNYVhHRmJL?=
 =?utf-8?B?ZHNsWVRFYyt0NDZBSTJJK0gvaDNYMVBCZUFsU1dscmU1NnVDekprTm12blRI?=
 =?utf-8?B?bWZaaVdoeHBzTjhFNTVUTy9yc00zRkJyVk5nY2dvTVVrcWxSc0tTNUEwbmNE?=
 =?utf-8?B?Qjc5OVU3Y2xtbmNEUU1Iam1tZkZaa1ZyNkRHSnM4TzRlVzZkeUFYQUZwNlZE?=
 =?utf-8?B?WktLWnJKaFVrMHduT01mSkF0Rkl1NGRHTUx1TVNqQzV2U00rS2t4Nm54VzBj?=
 =?utf-8?B?OWVpMCs0VWtQdlZXeVpyeXYzUmE5aU1takxUVVhCMEdSVXVvT2JDekwvdHJx?=
 =?utf-8?B?cEZmL2plWXlUVUF3SU4rK2p5VnhNTnA1bVR0M0ltSUhEbm1LK2UrcUlVL1NZ?=
 =?utf-8?B?Zk83M3VuQ0FDMDFaaEVEN0JPcm5xUXJKNElUVTYwQlJ4TnlRL3paWldoNUh2?=
 =?utf-8?B?NzNwMXZSVC9aOTVWOXJNdVNUSGdIM011aUVFNEszRVNuTnBlWis5cStoTjJw?=
 =?utf-8?B?bTRraTRlUXJ4TzNzQVBwRUpKUTBPVWJtYXpHSFY4dDl2WDVmaWk0Q3hKSmRK?=
 =?utf-8?B?WFI4Ry9DdEJNWHpVTHJXQVRJa3U3akM2QUlZKzVLVHRmcCt2UExZVDErMGtp?=
 =?utf-8?B?dEk1Q2N1ejcweEpiRlZMdHk4SVQ3b3EzSXFqT2tieG9qWk1RT0pPQ3pJWXFD?=
 =?utf-8?B?dDlwT05Oc2RaN05qcWRLbFhxTHdUVXlqQlZiRkQ5UGhSNlhKWEZZK215REVX?=
 =?utf-8?B?aTI5SVBnNnU5QjFDcUJSc3dRQ1JmdDU1L1B6amxsMC9mR3JzOHI0aDVkc1Mw?=
 =?utf-8?B?MDhxZlBrUjUxeURtMkFHMVE2T3lqV2k4K25HTEVIN1VCZi9EaTlxNSsrTFFk?=
 =?utf-8?B?VGdlaFhjdmFITWYwYTZZeVZpblRVamNlZFlqSVRNckNaTUpjVHpWVXhFalZq?=
 =?utf-8?B?Uk5OWmdoR1REK3Y3akd1bVg1RkUvcDBISjlWKytma0w3Yk15NmZYbTZiZy9l?=
 =?utf-8?B?cDFveXlxanRXSE5MUVluVlFoNUFoZnRlRUx0bmtxTUR1M1l3MlNPNG9ia0Jx?=
 =?utf-8?B?TkVBT0ZtdjBwblFUTU9CL2N6Z0swSkhxUmtvZUtXR0xGSmpHdEhXd2V6M1hr?=
 =?utf-8?B?dGMxYVRGaUhjcFJhV0NWU3BhUlFWUjRXYlBSd2lFbFVkZ2tyK3ZrMUVGTEt5?=
 =?utf-8?B?dHN0VnEwWUN4aWdjTVVPMzVHSU12VDJRQ2plUUtUTzR2VzVxV1ovUktJd0N0?=
 =?utf-8?B?dWdjNjI2WFM1eDJqSGZIWjdNb3VVZ3REZnFTNjVFRWc1SGdEQ01BelZIVkZ6?=
 =?utf-8?B?Y3FiZUJjL1pKV001a2plNUlydUtrUktrRUpPbnpKM2wwdjVwWnU0Nm8zNHd1?=
 =?utf-8?B?eVdnMzNqZjN5Z0k3Szd3UzJzWHhkb0M3YWVKSldTaVRLOUY0TzJBL0dldVN2?=
 =?utf-8?B?MElCV2NCVkNLNks4OUh0ZHJWWGUzNFE5ZlQ2OERNMFlNYXAyTEtPazBZdE9G?=
 =?utf-8?B?TDlsdlJIM3lEZjF1Ym1lYkxXTXpsRk1IWTZwRVV3eWVuUHVqUWNvNTBibFZp?=
 =?utf-8?B?QzhUdzBHUzdidEVmNk42RHFXc2RCV3NuY1UzNEswNlptakhrNk5hUHc1VklN?=
 =?utf-8?B?OGZnNVI2V1hFTVpKTGNOdGZlQS9mSW5kY1YrQmhPMDBhdmJ5cGRzWWI3WnZC?=
 =?utf-8?B?eDFDNTNZRUxWZk1WdkdMRmZndVpxdXpPb0oyZnh0TDJiVUlEeTBjRjJsT1Z4?=
 =?utf-8?B?S1dBbDVvd283Wkl2T1dSTUI4ZXdzMU4xK0YrTDNUejBZQ0lJVXBLdUt4cUVZ?=
 =?utf-8?B?dGtZa2QwRnJicGl3U3NNYm5KRDBGQnNIQkFwWldoT2NVOHUzejB4UT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c312e67-7119-4a85-561e-08de43888bf2
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Dec 2025 07:38:07.9987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ThNN3j47is8J4WUfaBLctV88mjH9Oqu9SbrMzicwgUc6+awIVDtOk8z9FSQm9nHw/vZtqM6UmmCCAeCa6VXWUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P123MB7820

--t453fvmlhdws3bej
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] tracing: Add bitmask-list option for human-readable
 bitmask display
MIME-Version: 1.0

On Wed, Dec 24, 2025 at 08:58:48AM -0500, Steven Rostedt wrote:
> Should we just make all cpu bitmask range lists instead?

Hi Steve,

I am somewhat hesitant to adopt that suggestion as I would prefer to avoid
breaking any existing tooling that relies upon the default hexadecimal
bitmask format.

Whilst range lists are undoubtedly superior for human interpretation, the
hexadecimal output is a well-established standard throughout the kernel.
For instance, the hexadecimal format is still strictly adhered to for
"Cpus_allowed:" within /proc/[pid]/status. Introducing a global change to
ftrace defaults could disrupt parsers and scripts that expect this
consistency across the system.

By leveraging the existing bitmask-list trace option via
trace_print_bitmask_seq(), we offer users the requisite flexibility for
high-core-count systems whilst preserving backward compatibility for the
wider ecosystem.

I shall send a new version of the patch shortly. This version incorporates
the use of iter->tmp_seq to ensure the implementation is robust,
instance-aware, and free from buffer contention or duplication issues.


Kind regards,
--=20
Aaron Tomlin

--t453fvmlhdws3bej
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEeQaE6/qKljiNHm6b4t6WWBnMd9YFAmlM6dsACgkQ4t6WWBnM
d9b54hAAiq7AqToFLyvBp44/jpCV/NOkEx1Pnokwa7kWphTh7gEhamJ3SZJYG/Bp
nqkAUNAlWkgBmLtrDl4u+aSzfWxBw48ViJ1+VzEEsmO7dAU4Yfgroh0irezJ0cpE
kcEQRshgDr4i5QnfipF9flzQV+qEH7k2u339scgA2Q3HsMOZKELKb0xd/4TAL2f5
QLGb7s6MFAnFL8U14YS3kJP6ezTLMrXVN2Y+KILgP2POgnnJO2lkcjrZsYOklhkT
IYnSi1glADQJdK9ta5Pxb0GCEKoVzeiXqENPA1+aX587x+PhL5j+zXUTT8LM1Oxx
cjAbLKjMq02refL1WXjIgQDWwR0u4eIMvfJUAz2mil+huqVv8/LR3wW4d1GZOx0r
usunl1fldSAXp0JQ7TYYOxlfcsFdVvnOZkp+PvCVI5sZb8b9JsXnUiQvpI15J/gH
69WvDNqaPj4xiZ87vKLuB+ZE6IDu869FqtnYSdpUhfxAqgvrkpdkGQHgnqF8/u9x
h5eopVbAscfE75NOgyo4fRd0hW4kARL+NHRQwqwxdldnTYw8H8EyH/GPEnpz16Qg
1VCmxwAwGMHTA7YnxvrZUdCJkMyTtqnx7/durK/SRor5b/drTm3tWFEf0BuObAEr
V+6r+4Px4gVjCsWdXyJUN+8i/FvhftQCjaCXijgsMPtzNb7TL+s=
=p/Pm
-----END PGP SIGNATURE-----

--t453fvmlhdws3bej--
