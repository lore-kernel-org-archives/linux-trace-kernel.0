Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012031.outbound.protection.outlook.com [52.101.71.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B7C216E01;
	Fri, 21 Mar 2025 13:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742564610; cv=fail; b=CwfHaNhWynSDo/BKWUZ/cbK25pNKukC44nQQNAM8bofn37VMwvpCiNuy0QDjdcgFg0Cb5nBGHsJVoQ+8iv/GVfjx5r9ac3O7Mvfk8drCAfR87A0eHtsc/GZS9A1WuBUqZBxLsCjfwKMzpbNmNQM/rfn0sdgIhQULrPFV+6a14KI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742564610; c=relaxed/simple;
	bh=/SAmJxnBsEycjZ83PzHdIstb7Ulxr+x9o32/blfwKpM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=n8l38XRMXDzhbBnhm9VUZDOic97ak/CSagT+u8BiShC1+OPHG11TO2aBwDvlfEjAe+J4df/n0G0BBzmn3Fn3oc3nm89K21dC98nIgs3FYcZ5h5ozactD6HJNaWpcQ5278hi2bOOmH1q4TgrUVj2u0HvRjRd8aYkNBMBDZIoI/mQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk; spf=pass smtp.mailfrom=prevas.dk; dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b=m7VKXuAX; arc=fail smtp.client-ip=52.101.71.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prevas.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b="m7VKXuAX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yWuTAJEi3KjEv/iJvVnnMD5CuxxMfRFfTB7kj2dD8owJCPl9W0eTS/jLuovXSCF8jEYc8xj4JPiDtd3OXU2otHgF8S6OsWDz412BrGgXZdzfcMVFICWhQY7M5tXd1KEXGeK8WEXXPULhwQMr8QCzEvinhSoZ7wbwZ7XqV0u7jHt+Nk5mNALf2LGMT9tV3VErci/YPxBgfCK2lPaE1ys1qwpo9sphb+S40qfyNL03OLp+NVxPxY+meu/BijNVKkOaOYH2WyEQP484UVfIOn2cv23au0IBu0yORdl/HDRcHCP080/cssRsJpIclsJgzzv40Xg8vPcqWAtZujIrm3GIxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+tLAbtA7SVpx5Fv/3JpTBkfVNDCrMQA/b7i4mcIEgtw=;
 b=Z1C8hczScAZ55jwUDHw+qQQNREtAaANmJSyz9g9cVNnK/dzyopLAJU2C74DQuk9rI2UOJP9VPMoqXShIMvBGzmgCwgQDNWalxy4qgTbl1/fXO7rvADpgOiCAht1d5AR40nNv+N82ibPkcyx4AnDnYBWVV12GMH0j0uwWm0f7KgDvjeicuxEvIE81WKPhnGvfVHWiBGh4/Ildfyl0SDwOq7oWlp1FBU0bpPnHWuJ3JHpQkzGioJLb3FbwQq5GISk7pfb1aMRbT4g0dpapz+MygxXTW8MdVDQgIu+efjIzs5gkCcBWzgjxWMQhTi7aWQ9AMYMjZlyhk4yRsV3FcRUD0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+tLAbtA7SVpx5Fv/3JpTBkfVNDCrMQA/b7i4mcIEgtw=;
 b=m7VKXuAXrywyZ/hdWYVPlX/sZk93xudNVv3aHcSymSVWFKf1ec4hVz0I5HxMTPIdsQupjeCgn9ocv2j8JDKz0xLc0fdLa0Zizn/0S0v5t8vPgxadAvO7qnv+67vNBXf0xwN3WOIYwqVoX9ZPtCPfQbTWYsx1Mv8krnbPDm3konQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:41::17)
 by AS4PR10MB5917.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:518::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Fri, 21 Mar
 2025 13:43:20 +0000
Received: from DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7e2c:5309:f792:ded4]) by DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7e2c:5309:f792:ded4%5]) with mapi id 15.20.8534.036; Fri, 21 Mar 2025
 13:43:20 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Petr Mladek <pmladek@suse.com>,  Christophe JAILLET
 <christophe.jaillet@wanadoo.fr>,  Kees Cook <kees@kernel.org>,  Steven
 Rostedt <rostedt@goodmis.org>,  "Masami Hiramatsu (Google)"
 <mhiramat@kernel.org>,  linux-kernel@vger.kernel.org,
  linux-hardening@vger.kernel.org,  linux-trace-kernel@vger.kernel.org,
  John Ogness <john.ogness@linutronix.de>,  Sergey Senozhatsky
 <senozhatsky@chromium.org>,  Andy Shevchenko <andy@kernel.org>,  Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>,  Andrew Morton
 <akpm@linux-foundation.org>
Subject: Re: [PATCH v1 5/6] vsnprintf: Mark pointer() with __printf() attribute
In-Reply-To: <20250320180926.4002817-6-andriy.shevchenko@linux.intel.com>
	(Andy Shevchenko's message of "Thu, 20 Mar 2025 20:04:26 +0200")
References: <20250320180926.4002817-1-andriy.shevchenko@linux.intel.com>
	<20250320180926.4002817-6-andriy.shevchenko@linux.intel.com>
Date: Fri, 21 Mar 2025 14:43:18 +0100
Message-ID: <87msdeebyh.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MM0P280CA0101.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::27) To DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:41::17)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR10MB2475:EE_|AS4PR10MB5917:EE_
X-MS-Office365-Filtering-Correlation-Id: 63979c0a-5579-4efa-8fd9-08dd687e576a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|52116014|376014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RVRvMzZNMHp0SnJmN2FnNm82RWtiY2tQOTN4MFpLUjVrVXUxdFZaWTNDK2t4?=
 =?utf-8?B?Q2RqZlpUaVhvNWd0VVR3Z3M1T1FTdWdRdFp4V1dzNHJ1T3BTRkR1WU4wL1N6?=
 =?utf-8?B?M1ROT0o4c1lFeFFuNVB3RzR5WVZvbDE1aUpKQmFtdjNFeEdaaVoyWFRoMW1h?=
 =?utf-8?B?aGN6N2F1MlJ0OEUrMTc3Nm9hSUduaFVITm5VS3V0MC9vRUZ3dHg1V1Z6WEpK?=
 =?utf-8?B?SUxabmN4ZG5Qei96K3hqY2FjeE9xOW00SmpuMkxpMTEvSnFUT0tDRCtPN3Ew?=
 =?utf-8?B?c04xb2NCeHpaS2VFZHZUd1V6d2xXa1pXdzVBUm55SGtldnl0cGo3ZnJtbm1a?=
 =?utf-8?B?WlBQa0RKQktWQ29tMVBEelAxZFFtVUE2QnRqMFQxd1dGanQrTGNod2tucDFa?=
 =?utf-8?B?N21CWmdIVm1jSjF4RmVuOVlHOWRGRU14UFZwMXJNdDRVeDBLZ2ZlWG5JRDZX?=
 =?utf-8?B?QjBQNWFZOE1XYVAzK0liWWVSZFBhdmtWbFVqNzN3TGRES1ZUQTFhVzBvMndI?=
 =?utf-8?B?bkoycUtjd0tQMWQ2Z0N1UGVqYkJzR0tmV2JqR2kxeWdpMnBzc1dhQ0UvdFZV?=
 =?utf-8?B?ZHRMT3BlS1k5ZitqaDZWc1hEOFdEZEVhZFNUUW85WlEyQUFoaGczNUdNNllD?=
 =?utf-8?B?MTV1cnhHT2M5L21zT2g2aitzWkZRYkhTM1V4cnh0VHQ1QUR6a1pXNFREaGFi?=
 =?utf-8?B?c3JuVmxRd0ZGSzdDaEw4WlpYR2paYy80MXhHbnppeXJGWTRMVHo4ajJrbnFv?=
 =?utf-8?B?alNRSXBkUDFTeTJiTU01VEFNUEZncFJVZDV1MzRVYTZVYmRuMjFRb1l4NHM0?=
 =?utf-8?B?OUJDRm5UckxEWUpKejB4d01mRjdMUUwxVDZ0Y1ZjTWNlbXJBWGpydERaV2NZ?=
 =?utf-8?B?ZXZKM2JwWkdBanJlWHhMdS8xMTRNbXVEQjNBaDRFU2o1eHBtSXFrZTArVDZl?=
 =?utf-8?B?ODJjYjhBWWloRmp4TUppMEJ0US9vTXk1cUk5L2wrR24yZ2huQ0hHWFl0VkRv?=
 =?utf-8?B?UWx3THZrZk41djZ5bnh6WlVMdU1ybmZwNC9OYTBycVNIdmJVeTFiTHhmL2w5?=
 =?utf-8?B?bVdZQnpJdEltL2FxbmY2Mzl2UWd3SkJEd0wzNGlWWG5WRXVXV0NOYk5sM25X?=
 =?utf-8?B?NzNNRWVFY2l5MkNlRzBIQ1htM3UwQkd3RytGaHhHQkJ4UGRXOXZZcE45WFZk?=
 =?utf-8?B?VTFRR0tlTGxHd2czZkdFKzRha25DZWxwM3hPZzdjejFoVWo2STVRaWl4eVVU?=
 =?utf-8?B?c3hCUEFuZ1RPdCtJMW42REc0ZjZyWFlqQmZ4V0dtYnN2MDJRVytTSFQ5clFo?=
 =?utf-8?B?eFA2c3BZb3RuU1J0enVOZmZteTkwQzBhdHlDVkxLUEtrZ3JxVXQ5em5rcHI4?=
 =?utf-8?B?eGJaWE5UdWcxTVp3RllpUnd1MXBmMkpRSkJPSmFGdWFQbnpyRlJ4cUFiNVg3?=
 =?utf-8?B?T0E3TjJNaytjVlZuOTBCMSszOHQzc0RLaDJLQjVXNlgxNC9ZUlA0aHZXNGFq?=
 =?utf-8?B?M29NZWltNkw1emlEZmNiUjg5RVdlOXIzandzeVZYVDFOOHhiN0RDVUF1SkdG?=
 =?utf-8?B?SEVmTys4emN1ODNEL1RmRmU2V0tEaTkrWnZNaXo0NmdsMDJWRW9DNk85REdW?=
 =?utf-8?B?NVEvZWg3UUVDUDdIR0VONXFvSEtHcmM2dW9GMHFwSlR2Z3REbU1UajVNVHRp?=
 =?utf-8?B?OXhKMzl6THgyUytMY1VsR2dORm1lMWQ2WUkxWG9IVWRhWFBnTEpqaTFOMEta?=
 =?utf-8?B?KytySko4UVBJRlFkU21PQ1FXT3FCeWxJZVptWVdyU1VlbVFvRjd3U1lzcHlS?=
 =?utf-8?B?dXJLMHhhR3FtL1FrYUZSTWxQQStRRUNsN2drR0c1Rjk1R3hDZ1VCVDZiM3ZV?=
 =?utf-8?B?ckZWbk5PWXp4aWJjYXdCbURVd2R0RUlpcmh3eUwxd1F4UDVKT3JDNHpXZnJP?=
 =?utf-8?Q?NnefC4oz5/X7dNgFESAdGcUYsN/a0pr5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YUlySDMxanFuclVzeUE3OVJMV2ErQy9NbEFqZ25aN2pEd2FnNWxsMDFkMmNs?=
 =?utf-8?B?alBpK0Vic2FiMERUYmpobFJDdlFXQnAyd3RUU1hmeFVSUEhVSGgzNm82SDIz?=
 =?utf-8?B?VWNveklWZG1aRFo3MmZrb0xadU9qbml4U2c2cmxobEZCcjB0OFZvSWl2SFlu?=
 =?utf-8?B?Q1RDVFArT3NtbENYb3JYelFqNklVRFk4U2FNRklBRjA1UjFJSDBhY2Ixb0tD?=
 =?utf-8?B?V25VOVlPZS9pL2gwTjg0UXF1WGx0aEN1THAxUjVrc0pjd1FFOTlUZHNkMXJY?=
 =?utf-8?B?N1pPMDFqcE9mV2xNZkE4clNINGJuNWlvbzUzUCtBTGNmRUllV1pTYlE3Vzky?=
 =?utf-8?B?VGVQcVVyY3VGN3ZMTkxmU2ZLMTZwR3FIcmpuVVovaGlkZStCSDNHRHVJdnRF?=
 =?utf-8?B?NnZpY2RQYWNxR2xOcHlldGZsWWhWcWlDSzBBbm1zc2RkVktXVVZOeU03WkU4?=
 =?utf-8?B?L04rQTFjbytyTVpHSHNIc0MzR3VyUHM5cGdxdDlHNXd2eGpRVjNrOVVrdUMw?=
 =?utf-8?B?SlFNcU5YOHRaRGFzb2F0Mlo1dG1HVEdGU2NuNDExQW4ra3NjRnhpTzhUWDBZ?=
 =?utf-8?B?bjljK282ejJhMEJzZFlubjE0bVhPZ3VFWEY5TWhJeklUaTJOcklnRXdsSDlM?=
 =?utf-8?B?ZzdITUtadXY4bHByTFdBR2REVCtyUVdPM2l2ZHR6TXFKZm55MXE0U3kxV1ds?=
 =?utf-8?B?SWExdmNLSnIvV0xsdk5Oc0xPQ3RTR2RiUnpZOFdFUFM2b0NtdVVqWm5DTlRE?=
 =?utf-8?B?b01DdmYzUkJSeU9yNDBlWjlFMDROY0JRVzZiNHo4NW5WY2xQKzVwSUF5WDUw?=
 =?utf-8?B?WnR0ZnhlZ05aSmd5SjBmbmxGaXlGTmNOcURzKzYyWHB1QlN1YzdpdjNVayt5?=
 =?utf-8?B?SVJGdGNHS085cWhzWGs0T1B1TXpNZVF6OVJHNk03NkZtS05KK0t4NFFHMkor?=
 =?utf-8?B?L1VBWGt6T2lpclBpcFBuZnAwYU5ITmk2SlNrZ3lseHBMaUc4ck9aMHV1d29C?=
 =?utf-8?B?dUdVK255Y1A3Vk0rVTNaUTZkcVBpcUJqUG54b1RCMnY2MkEyTjNNVm92U3pZ?=
 =?utf-8?B?M0FueXVCbldkVFNFd1BMZXFibGErVEkxWU1tSXlmSHZ0ZGR3R0VtbU5ET09I?=
 =?utf-8?B?Wm10S2wxd3hLb3phV0lCd0hmTWFJUkRUaXZiVnZOVHIvWUVQeHJJNEZJL1c5?=
 =?utf-8?B?eXB5MzVrc2F3VVNac2VjM2NhcFNlRytLalBFYmtPZnd3Y1RvQlp3ejRDZUFm?=
 =?utf-8?B?MDFrYTN5TlV6UzFYczlzYm1FT3I5QWJyZm1nVHlXYVBUM3JXQ01JM3h5NzFl?=
 =?utf-8?B?blB1T1NYWGQ1QnBCZmw2dkIzYVYzdkFrb0VxTU9KaWM4TzF0ZElobnBlNDE5?=
 =?utf-8?B?SFpDL2grWkRNaXFhcDNGZDU2WU5oelVYY0lYLzFaelFvWW4yci9hYi9QT01J?=
 =?utf-8?B?dnhPUzFxaG5xL3NYd0c2Z09QQ3podUxobVA0Um1qZHE3eUx4WEx2UHVucUVt?=
 =?utf-8?B?WFFlOWdRNi9MVkVjZU0ydGhiM3NpeExTMHZ3WDVURFI0U0pkc3ZobVViSFRx?=
 =?utf-8?B?Z0k5QkFUU0xSUTl1VkQ0S21RNHRncnpHYm95ODh0V0FrelU5RTlyVlhLVldq?=
 =?utf-8?B?NkF1aHZ5cmk0am93RSttZEFBTkZlc2p0YVh1QnB3TXU0YVJzNVRHbmpXcEs3?=
 =?utf-8?B?V25URnVocEtCckMrYmZ5aE9sRnR0QmVCQUhRR1BuaGEvZXZhNlIzZnRMM3ZJ?=
 =?utf-8?B?UEFYVXgzWHN2U0haUVVDd2pTQkhWd0FJT2lrUVNrWk5nZ2I3bUdFM2MxdElq?=
 =?utf-8?B?dzdYdnlvLzRsVTFwc0h3U2R5SEIwemNqVE91am9mMVRFekVrNXJiSkdacE5q?=
 =?utf-8?B?b2ovQzRiUFEzZkNFUUc4akxXcTcxTnNUdU5aQnhxdWJSY3Z0a2NBM1o4WWpm?=
 =?utf-8?B?TnRkTzlxYzFHUnYyeDhCd0lZb2dEa1FUd3lOaFdrUjhuM0F3NzBqNnl4QUJF?=
 =?utf-8?B?ZVlnVWNjeEJTSEF4TUowOS80cEQxMzlOenliL05ULzJCR2JYNEtlelJoVGFw?=
 =?utf-8?B?U09oRWJuaEhNbGZaSWt5bUxsa2crMHpmOGk0YVhwdDcrVkNnR1J4bDJlemlu?=
 =?utf-8?B?bEh2UHRJamFaU0NZRXVSOFJQa3ZHSE1NVWpJTTR5cmJtM0U4WmdmeVpRcnpt?=
 =?utf-8?B?WVE9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 63979c0a-5579-4efa-8fd9-08dd687e576a
X-MS-Exchange-CrossTenant-AuthSource: DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 13:43:20.2914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TwKEThf159wJDcQDQjS4SjqVxqONPOUR1IDgzg7kojLRaJE2d0SoWMNeAjurf/aI1tLRAW6Ei5kVNbwx1WMKJSlNokzh5U4On85NS06DF7w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5917

On Thu, Mar 20 2025, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wr=
ote:

> pointer() is using printf() type of format, and GCC compiler
> (Debian 14.2.0-17) is not happy about this:
>
> lib/vsprintf.c:2466:17: error: function =E2=80=98pointer=E2=80=99 might b=
e a candidate for =E2=80=98gnu_printf=E2=80=99 format attribute [-Werror=3D=
suggest-attribute=3Dformat]
>
> Fix the compilation errors (`make W=3D1` when CONFIG_WERROR=3Dy, which is=
 default)
> by adding __printf() attribute.
>

I had quite a bit of trouble reproducing, until I realized I had to
apply your patches in reverse order, because adding the attribute to one
function will then "taint" its callers.

So this one seems to be self-inflicted pain by the annotation of
va_format (which is completely broken, I'll reply separately to that
one). This doesn't solve the false warning for va_format(), but how
about we at least do

 static char *va_format(char *buf, char *end, struct va_format *va_fmt,
-                      struct printf_spec spec, const char *fmt)
+                      struct printf_spec spec)
 {

        case 'V':
-               return va_format(buf, end, ptr, spec, fmt);
+               return va_format(buf, end, ptr, spec);
        case 'K':

because va_format() doesn't use that fmt argument at all.

Rasmus
