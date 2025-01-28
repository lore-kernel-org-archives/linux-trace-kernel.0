Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022104.outbound.protection.outlook.com [40.107.193.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5924319E967;
	Tue, 28 Jan 2025 16:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.193.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738082791; cv=fail; b=GqOJmNO8fx8xBA4m/vZtKFh/WGJDVz23tJnfRINw/R9dGyjqirz6tAfB/nrIkuWRUD5y2c5uB4J1ZF1OlEQoZfRTZs0A92X1OyMsYmvOGSzek3z7PWlnlosWH6Hj8/w2/D10W+Gw2FBF5a/x5xvw7kekR2qvsfV4jzcajD3O6l8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738082791; c=relaxed/simple;
	bh=OGZ60b6hVsZBEMQWTwlTae9sncZBwK9pqPXCpXPEJ/I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DXyL2SfjHUk8fmZteYZeyV31Q9LudBr7wTw9pF5mveVbcx2w+jAKGM/9+gbdTcYuoBrzEzHU6vLB10l3DY26WxhZgC89IF0AomyxF+isahG+TUdqs/KHXNNrdMC6UVD7iZz8Hz5LW8j3o4nEd8c+k7tal7Qg0/6ibKEdyDVWzsw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=p2VSf0JO; arc=fail smtp.client-ip=40.107.193.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="p2VSf0JO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oPLuKsu2h7hSV+zpk96LSc/eRvCamjLU2YrkoaA2aE9CPxYvLkamK360j/83rYtvfcRabEdzpMnaVqSCPqV/dw+aAlHnJtl5OwNxNHDHQZob6Nq2lThDCRuM0OEZdVywgo/buLVVQhh1OGypy4EahVnjOCu/TjsLEDCRh2QzbNCiGfJ4dQI/cGD7zKPr0P3X9/NkqUaEVeGvPnGHpWCH04QfOLyD6+Xa2u3ENlM3r6RZWiOJXfepflJBuauU9q21ibd149dG4gpiMc5GnJLA+/JVX4zbaQpt3BRrTbccBqeuplsj2BmPheItEaWUr3+A6cI+NXz7nmCc1/dEVAagLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4RLep+leQGhPm14+WBR4gloVNREa/cZQS1FgSsLhWUs=;
 b=zQK6Ngb2uC5tm3vYejJhUvgtG+GDm0yJ9Gq++L8P+Gf3V38uTEHBbGrxa+WDiUQYI8/3ItPv4hHFYRAWkAORHcJ9BBIm+elGsj/Eh+LheHkKD+ME9ZyXnNSg0lTPfmGXqhy+SUuSVHa08+7wY7Ue+/3ALKABiScipMFDhT/1lzZpS1zjxCQc2ZRxtKq3ycKIFwrIBsNGYbJ40sDMb2I9GDTP+M//wUEciS//wnDeJr5lgI2yXgy9PU6oGacykcW8PSuO8P7IClRlEhSqq3qT416FUO+7PEppcZFRGd1wEgo/q7Dk+/tYGemkKV+ywB5QeUz7xvU80DGDqBUc6mBU0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4RLep+leQGhPm14+WBR4gloVNREa/cZQS1FgSsLhWUs=;
 b=p2VSf0JO0vQ8RCIb2C/guA6O8z01CHQabbzSnJVMgg2gcsYBpEkut9k6tS1AoO9lXkL5BRmS4QKGFoBfyN6pPEsIpJqTvDJdvInaoX40ujbeou5vNCQlPPs5DYZh5ww/Xd4+Ghx4bb/Laqzcu95LzaIvOaXCxccSdj18WrDrzFqJXcJhlJHUBr4vVfxGHWqyns1G13zZxF93ObKn4Kdx2HCygDijOATwyU5lGZzsRrHPanfISm+lc+m6Gi2W6SSk+UmiKXzHYY6UJT1meoThAvKQpHDcv+gEdd34Qe4aDyDyFJ7lpoNXDMrsdrzcg5vsO8jlv4QMx4chAnJrcTu95A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT2PR01MB5588.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:51::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.17; Tue, 28 Jan
 2025 16:46:26 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%6]) with mapi id 15.20.8377.021; Tue, 28 Jan 2025
 16:46:26 +0000
Message-ID: <c3842632-cb15-469f-a6e8-8e9ccb3fff56@efficios.com>
Date: Tue, 28 Jan 2025 11:46:25 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/3] tracing: Introduce relative stacktrace
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
 Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez
 <da.gomez@samsung.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-modules@vger.kernel.org
References: <173807861687.1525539.15082309716909038251.stgit@mhiramat.roam.corp.google.com>
 <a7a171c4-7feb-4f26-a832-18d38a3ee973@efficios.com>
 <20250128112733.37d7c771@gandalf.local.home>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20250128112733.37d7c771@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0117.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::17) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT2PR01MB5588:EE_
X-MS-Office365-Filtering-Correlation-Id: dd562844-1e9a-4e9f-26ba-08dd3fbb4ea5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZDgwU0FWbWs1VDk3UmFQaTF3dmFoK0J6QTFjL2pIZUVaVEZzai9YZnFZbStV?=
 =?utf-8?B?ZGdKOUFUUFFERlVPQ3ZOOTdqRVhQdXI3ZHU4YXREemh5MWJ6TjJ5MlJMTWdD?=
 =?utf-8?B?TVFnc3l3SmJZVEIwMGQvS1dYY3k0MHpjeExBY3VMa3kvZHpnQk5DMy9qQm5Q?=
 =?utf-8?B?Q0ppaThlZCtVVHpHZUVrWHFTWWRxVGx1cjQ4TXdaeFlZV1pGRzdGRXFzWCtq?=
 =?utf-8?B?YmtTQ3JpY1AzcmFGcTJyd2txbzNqc21lNTZxek1uQWhvdnZUUExFeGN5SzM2?=
 =?utf-8?B?VDI4OWVLMThOc0Fqb21mRThLazd3eWtxYzcvREJlRTZaR3BreGZ4RkhuZlBK?=
 =?utf-8?B?aFZ2SnlKOXFSendDU0J3bzIwVm9OQUpiZ1dDV1A4ZUdwZ0hBeHJ0N2RGZTFo?=
 =?utf-8?B?dXRMVEpDRG9vNjVRQW1Xa09EaHdQUFFIQVBPSWdQMGhINkJVQXNnTkJiSEd6?=
 =?utf-8?B?c1ZhVWJjS3JxNkZKS3l2OTdVUnBqd0tsT1ROejRrMnlqVkhVUWxwMG5jNDI0?=
 =?utf-8?B?UWp5UmJNRGpCUWI1ZC9WNzk0OGhZMmFPcFBRUjFuc2lMcUdKaFkydnB5OEYy?=
 =?utf-8?B?VlJjNlVtMmlZeC9ZVk81VCtxUzQwamxBcmlXTmpwQmdseXFraHRCbVE2eCt2?=
 =?utf-8?B?cGJOTTA3KzYrUlNDQ1ZDcmVZaDhwempOTlhPMUVlSFpIeE93YVNsbXNQek41?=
 =?utf-8?B?T0t2eTJjTGYzeVdTYkVtZHI2ejM1eW50QnE4Znc0UUV0dC9yeC9NSlpHNmFS?=
 =?utf-8?B?K1pOQ3VyR1g3c0twWGdrb2hCdERVb3c5MFpUV1pTb2RHZHdnd2crUk56QTRF?=
 =?utf-8?B?M0tEbDZFVldOV3N3aEhQVTU2eWNFQVpTc05xbnFhekR6Q3p2QlRmTGJsWUFF?=
 =?utf-8?B?TktxamdhRlNmY1hHUmpoVy94ckJPS2VGNHM5Z0VOazVqSnpMOGRvNU1LenQ1?=
 =?utf-8?B?cmVFYzRIbDZZakRQdlJjU2FkMC81MFdnT3lVQm5lQzVNbU9SUUJ3cDRUNGkw?=
 =?utf-8?B?YnFDTXJ5RzZQMmFhVDdIcGpHU3lzZDhkVUwxNE42UDFQRjRVZlBCWXkxcU9L?=
 =?utf-8?B?dkVyUnBtZjVYR3ZQdWZ5TmVjYW1sdHdXdWd0N3FXNXhmeHFIdmIxZXIwME9u?=
 =?utf-8?B?dUpRUXFPQ21pcCt2VGpKazRUV3YrU1VLTXRBc0VPbmxSUHlWamRka0xsZnRw?=
 =?utf-8?B?RGZsc3crYVdJbnM1ZmhuMitKKzU5QUVaUnJ2L1Y4TkNUMHFqblRuRHdrdWEx?=
 =?utf-8?B?ZFp2Y01IQ0VRMW55M3R0VXV5K3JvTmtjcU90OWIyOHFubnAxYzdleS81aDRZ?=
 =?utf-8?B?S1pzdnQzTXRwRzlBRU16QzM2MmRiQXl2OVk4Sk9Iem5WVkJtRDI5Yy9JNGFn?=
 =?utf-8?B?OFBGNUhnWCt0dUxWUGljUEpUTjNhVkRjanBJQSs5TzBWOWZGUEZCcFhJOU92?=
 =?utf-8?B?bnpQRnU3UjJwdGR5clJxQWNodnJnKzlTOHBxOW9KVk5VNG96WjNzQkRnQzRP?=
 =?utf-8?B?VlZEaFZZS3h6NHFOaXQ2dXFXdGFVME9heWZJNHZQM2VLQTBReXF2dGxWcWw1?=
 =?utf-8?B?TEU0akpoQnB2dEtPTG5pMVVMOGlncDJLYWpoMC83czdwYldiRGJzbTRxMGNG?=
 =?utf-8?B?RlpsQmJxeUxtcHJGY2xGTUpRTWlqUGFFMEIwbk43djZKN0FXZ3p5L081ZlR4?=
 =?utf-8?B?ZVpUKzA2SlhLVlhiYVA0UWNLbWpjRGR3ajQ2RDJkM2EzV1Nra1Zwcmxnb2lW?=
 =?utf-8?Q?1/XAJm2sV6f0Np9/jyMbkj0RekjzkLPAcGsbyLA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QzVFczIrUGtXd251VWVvQ0QxSkJoUDNGM0FFQ2xmdWYrOHZlWEt0dVVpdEtm?=
 =?utf-8?B?QnR0dlBmckhwYnBzSmgwYXMyQVVJTFFmdXQ4ckRDbm9NSzhwNW9jU2h0ZmdP?=
 =?utf-8?B?QUlhNUFWTUwrL0hqbHN6dFlKSkR6UXJmUS85K2l4L24zQlhZR0o1ZzI4Tjln?=
 =?utf-8?B?NlZkK2xxa0Rma0pnZWQ3VGM3ZGR1c3UzMjBWRTRoc2hTTWNMZ0NTaFkxMWhs?=
 =?utf-8?B?U1ZneFRXYmJ4c0o4THBFUXZNemtjT2x4Qk1zK1lsd3FHaHFRL1I2T0ppeVFK?=
 =?utf-8?B?SlVLSmhKMFVQQ0xTN1ZlbW9iaWNGVHpSK1BERTg2VkJXQmtOSnNpMmJhbVdV?=
 =?utf-8?B?TGNhWno5Um0zc3FMdzBqZUczK3lsakgweFlGRkd0L0xub0VVS0wwSjhOYUho?=
 =?utf-8?B?V2FtUW96Mnc0QytYeENaUzFRR1lQb3JodE11bXV4bmJHZzMxVnozTjV4UUV1?=
 =?utf-8?B?Z1o4c2VpWXpPSU95N3Q1Mm1BY013WndBTG9WQU5DZU5SS01sK0NGV2xxSTVi?=
 =?utf-8?B?SC9rUHc5Z2o0U1FUT3pkbVV0U0hJK3FsaDAvd1NkWTlPYi91ZGxETzJZeGNy?=
 =?utf-8?B?QmxBcUJzeStPQmdwMzZESWRKQnpvN2c4MEo4cGE1T3NFak5SRUYzUkhHeFVn?=
 =?utf-8?B?aEtZNHRMdE5XRytuT1NBcHVZeXU4bnB4aWVtOVhnS2dqUjhGRDBzWUtra0VU?=
 =?utf-8?B?NCtGZDlJUktjc1pjbnVJZWU5dVovVkRTajR4S0ZEMWN0blhuZjNrS0F6aytC?=
 =?utf-8?B?aVhjY0RBTU1uak9zSnVVaWZaeTFVUk1UYTJDZm5ZZGpGWC9lK3BrOHhWRUxG?=
 =?utf-8?B?akxhUk84SUNMUWtSVklsby9UbHJ1SUphUmVIazFMcEN0WXM1bWtPVndRSXkx?=
 =?utf-8?B?M1hYRDhIZnpJREduQ0JRY0Zad2tPenZPVXFuUjZWbXM4OTFwV2FEZkZ5SFNh?=
 =?utf-8?B?WEt3VnNvSmJHaytCZlF6Wk5XQkFkSnVwYW9qVkRmZ3FvY1g0VFU4a1k1VWhi?=
 =?utf-8?B?bmgvRmJaSVBTdmVheEVaRjBUdlFyVnczTWZSU3p2OUVYNU1sY3A1T2lYNTlK?=
 =?utf-8?B?TXFrdUdWV2NSbnVEc3FSQnp2WGZ0TGNOSGxKMERMM09YdHNsU3FPVEdWcnRx?=
 =?utf-8?B?K2xvVkhXV3pHQWpRVFBrenJ2VWErcTNEMEE3S1dDVExSeWtycHJCUEFwbTE2?=
 =?utf-8?B?S1k4S28vRHAvWDBRRDBWcW5OZUlkUTU0MTRTc2FTRDJhbkR5aTFxZnp2a3Ra?=
 =?utf-8?B?d2N4dHBGM1dzdCtVTGU4S3VGU1d1Q2RoMFJ1eDVCZnpkSHNFbERrMDQ2VnBC?=
 =?utf-8?B?OWluYnEzanlXc1ZWUFlZL2lzM3IrSDZXeVJOTTRiZU5na1hRUEVUdkZOcUEx?=
 =?utf-8?B?cVJRekZaMUx4Q1FKVmFkelhHdVY0SWVqS0JRNWZLTUZhQ3U1U21jRC85YXFK?=
 =?utf-8?B?QkJUQm56OU9PdTNjVVdsU3RUaTVRVjEzNWxMdHR3RUNDNzFBRkp0REF6cmND?=
 =?utf-8?B?b2R5NW5BTFVkME1ycXBRK3M0V2Fncm5kc201MEpuR1F4YWd6bktHVVJtOTVv?=
 =?utf-8?B?NUg5Q3g0Y2loNGZhUjBDaVd6cnZiRFpzV0EvclN6UVkrMElhSzNDVGJRYmJX?=
 =?utf-8?B?Z1NMeGY5ZU5nVDhCcGpmT0ZyZHJDYXAyelBJaE5ERDdkTUtWTk80TlFvR2xB?=
 =?utf-8?B?bEs3TURKSHdtUUZpMXFjakRRREtnQ3F5dGI4UFUxUUZpVmc1MDA0bnJEbWZW?=
 =?utf-8?B?YWoveXRjbmFNNXNwekhGZTVaYnlvbExwOVpadS9sWHE1QXFDdXZDeFdXNko0?=
 =?utf-8?B?eDE1b0hGWFZwem4xYXNrVzBrZFhWTHZ5dG5oa0JyYXVxdGF4RDN5Y3lUTEJZ?=
 =?utf-8?B?b0RFdERXQVFSOUd0TG1ITnZQQU8xR2VqKzRqa091R0Q3bFpxSVdmTHlENk1P?=
 =?utf-8?B?K1ZHQUI5RXZibFdVNUMzbUt2ZWlSSENrU2wvNm1ucUZjcS9na1kzUmluSklB?=
 =?utf-8?B?b3NuTmFaYjRRVlMvK2JHdDh3VVcwaXVtSGttWG5kdVRxMFU2UkJKSkdtMStS?=
 =?utf-8?B?RGlhdmh0ZkxzMmFaNjVvTXhOeTlkcFliZjhvbUVBZXRkWjR5aG5aR0V2RXVR?=
 =?utf-8?B?MjE0d1YwYUUzOWdZcHpESEhHOHdpQ2xNVnRKZnpIYjRrdThnK1FqMldVdTR5?=
 =?utf-8?Q?8V1XSPc6A46JdThxRZQEel8=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd562844-1e9a-4e9f-26ba-08dd3fbb4ea5
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2025 16:46:26.8259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vCwGG5Qz3+xp46Zr/KEmqfoonIb7i3beGE5X2UZdtxYlqGY7OTSDlXz3YXBx8BYWjKTgkq8ytZshDHnY774roe+uD9T7swVke6BDR8ereYY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB5588

On 2025-01-28 11:27, Steven Rostedt wrote:
> On Tue, 28 Jan 2025 10:46:21 -0500
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
>> This does not handle the situation where a module is already loaded
>> before tracing starts. In LTTng we have a statedump facility for this,
>> where we can iterate on all modules at trace start and dump the relevant
>> information.
>>
>> You may want to consider a similar approach for other tracers.
> 
> Last night Masami and I were talking about this. The idea I was thinking of
> was to simply have a module load notifier that would add modules to an
> array. It would only keep track of loaded modules, and when the trace hit,
> if the address was outside of core text, it would search the array for the
> module, and use that. When a module is removed, it would also be removed
> from the array. We currently do not support tracing module removal (if the
> module is traced, the buffers are cleared when the module is removed).

I'm trying to wrap my head around what you are trying to achieve here.

So AFAIU you are aiming to store the relative offset from kernel _text
and module base text address into the traced events rather than the
actual address.

Based on Masami's cover letter, this appears to be  done to make sure
users can get to this base+offset information even if they cannot read
kallsyms.

Why make the tracing fast path more complex for a simple matter of
accessing this base address information ?

All you need to have to convert from kernel address to base + offset is:

- The kernel _text base address,
- Each loaded module text base address,
- Unloaded modules events to prune this information.

What is wrong with simply exporting this base address information in the
trace buffers rather than rely on kallsyms, and deal with the conversion
to module name / base+offset at post-processing ?

Thanks,

Mathieu

> 
> If it is a module address, set the MSB, and for 32 bit machines use the
> next 7 bits as an index into the module array, and for 64 bit machines, use
> the next 10 bits as an index. This would be exposed in the format file for
> the kernel_stack_rel event, so if these numbers change, user space can cope
> with it. In fact, it would need to use the format file to distinguish the
> 32 bit and 64 bit values.
> 
> That is, a stack trace will contain addresses that are core kernel simply
> subtracted from ".text", and the modules address would have the MSB set,
> the next bits would be an index into that array that holds the module
> information, and the address would be the address minus the module address
> where it was loaded.
> 
> This way we do not need to save the information from any events. Also, for
> the persistent ring buffer, this array could live in that memory, so that
> it will be available on the next boot.





-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

