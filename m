Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011044.outbound.protection.outlook.com [52.101.70.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B5678F51;
	Fri, 21 Mar 2025 14:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742566169; cv=fail; b=nl838VNNBe+o89RXDl+EMV3WoXLfgMqJg8ZKmWni0OyUIqzlEmkqrOmJzgBSNyWZurTd4bMNfqOU5Jg7MMJ1B399fdTdKopsfj583TqsjQcIWt7LzFJn9oKZD6jX1JYaqIJ05zCMdoWNJ82FkP9D4gXEMKDisIw2IFkITg8YqOg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742566169; c=relaxed/simple;
	bh=w+oaYEWd71t+sXWF/rx7CyJA3TjUspMPta5eP5HVCMM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=pCKN9AY3vszYAD6PgKDk8Uh+uGznRse6WZmuI0HlmE4Au+8/dlcvnheZDHwudwp4tWhjIDCXptkYI0NYFT1pyML4ExBvfp2fWi20TXzwlT0Se+ndVNl4fjNxsdjJazoVI82KM7QxTX3kAgwRaqs5/saAlhNY2YyYzYQ+zJxXb60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk; spf=pass smtp.mailfrom=prevas.dk; dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b=MlcW9rn/; arc=fail smtp.client-ip=52.101.70.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prevas.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b="MlcW9rn/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g02V+5K6WNIpB3TMhTGWeSATWM5vDiF+ZuSyETex3QrqDTO3MCVoDNGIR5zwxPXIqeTmsYRDBS0DhSc382rw151PzZNqyrHn12wuzB7pa/x7JqN3jObM6cKv37vvcfwrnVqhpfWG/DICFNzcYCtTDcVhuhesf8TAxBaTJDrp/wtESEEPblXQt9EU+2D+bxvYU1uwYPB4Kz86ombdx9OoxJlycBS/eJP0Mp2FK6KAvPBwkPHDkDZoSbY+1SIadanHnrGpwnMzkCBQuyL2IuFW7e/AaEMy/wSThELlVwk3aGUxysuu3rBiTLq4L1+iA9/BfH4ouqxz6wyxJjYhdTjH0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RQH5Ula5sANlRlUXkf+k/pbISU/+HXa73Z69LUqejME=;
 b=S8qJMznr4LlPNBuajMFSoe0PCdq8+Ib7W8t8ojwRB268id7Po970+9pd+jJeOyojEJinZ1IP3ikqznE89BvPFaBH+emi3iZqa/sUyc9dfCfeuKVec860UGnkcxl2GC3FO3DquzTtYi2kZdV+t8s84zkug1/bWNUOtBhVngkj1ZsA9oWEfr6xlvsn4Vjhwjer9rg0r892Y4alSGRd4cVI29YgNKJBtiG99cPl/BHroIkuYXh6g5G9WlmZ08z73z2BMjMFGAPPHjJXUAYAf4n2+ExUPFCGCriNkJ4vHz/Q+fknwq7hfJbnqhd3ew7+AMf11bw8a0K3Ut307KCYIDunVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RQH5Ula5sANlRlUXkf+k/pbISU/+HXa73Z69LUqejME=;
 b=MlcW9rn/lbApPV+2DG0kf+yIr40JuKiS+OsHGhrg3ZR+7Q5I1djXrTouvrrjGq6sKXSzmdZ02iELHl/3reEH9EQSeEar0A/zhiUlDEIEM19EVGKL1jtOTai6Wi39aa3ui4do5QuFZUlEA8rcLS+wpVpMr5/SKzq/seoLkb0YHn0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:41::17)
 by AS8PR10MB6603.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:566::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.35; Fri, 21 Mar
 2025 14:09:22 +0000
Received: from DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7e2c:5309:f792:ded4]) by DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7e2c:5309:f792:ded4%5]) with mapi id 15.20.8534.036; Fri, 21 Mar 2025
 14:09:22 +0000
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
Subject: Re: [PATCH v1 6/6] vsnprintf: Mark va_format() with __printf()
 attribute
In-Reply-To: <20250320180926.4002817-7-andriy.shevchenko@linux.intel.com>
	(Andy Shevchenko's message of "Thu, 20 Mar 2025 20:04:27 +0200")
References: <20250320180926.4002817-1-andriy.shevchenko@linux.intel.com>
	<20250320180926.4002817-7-andriy.shevchenko@linux.intel.com>
Date: Fri, 21 Mar 2025 15:09:20 +0100
Message-ID: <87iko2ear3.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MM0P280CA0104.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::21) To DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:41::17)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR10MB2475:EE_|AS8PR10MB6603:EE_
X-MS-Office365-Filtering-Correlation-Id: 87591fe4-1363-483a-a47c-08dd6881faa5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|7416014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Tk45d04vOTJJam5IbG82YUVUak9yVnp4ZzY1OGJrR0ZPci9ueWpEZlFvS3Ax?=
 =?utf-8?B?bTN1akpHNWk3YlNiNEpIMEROQjNZSmJ3SzhVaXQxVmZGdm5YdmRHN3BBNC9J?=
 =?utf-8?B?Q0JrNG5IcWVTV3RXYWk0a1BHakhsbXFoSUFNQTRZK3JEaU1va2dZMDl3NU1m?=
 =?utf-8?B?bGZxbWdPT1ZPa3RsTWQ2cklFQnhZeEFpOVNNTXN6c1BsOFhhN2dzUkJIb1cx?=
 =?utf-8?B?ZkY0ZzlNSDJnWVBlSmJxTzBxVmRVd2oydXBtcFU3OEFFWnpFKzFEK1o2T1RI?=
 =?utf-8?B?aXgwOG9CWWJmSHFxOEVxM2hLRWIzOERXSG5RbHpxbXVjR2wrK1VPNWVoN3JX?=
 =?utf-8?B?WFVhVXg3RFFjb2RENUpDbEMwdm5pSStNbEJzL2tWeVNPQkRoMUViaURRTFF3?=
 =?utf-8?B?NEJERlNGd1o3clNHMzZqVUR6Z1E3M29Nb0RIcE0zWXR1UUdzWjZWYnlOdTJL?=
 =?utf-8?B?c3MrSGtFbzFiUSt2a3k3QkhlMnpEMjgzT213bThpSGZxckRHQ3lJVHhOZWl2?=
 =?utf-8?B?VFg2endkWXhYOUJNTlNHVjd0cGtFclJ0NldVekZzc0k1eTVUMnczNWRwOS9y?=
 =?utf-8?B?T0U3dEVac1VheVRjZjE1OTZFWkQyS044bmxvTGpCUlVIWmxucVBPd0xnNDVK?=
 =?utf-8?B?b1JQdzlEY1FnL2RzbnZNVURvRHRTa0pHTmlBYmhPQW1SUUhGL3NxSDJBQlVO?=
 =?utf-8?B?WFI2T2NJVjdJNjdxSzF6V1VhM0loOTFnK3A4eTQ4c056Y3VtRWsyNlUySXox?=
 =?utf-8?B?dlNNNE5seVlERjQwN1lkcEFwam1iZGFYalBqZmNVd2g4Q25zT0lyQ2Qza1Nx?=
 =?utf-8?B?RGFJejhubEFTT3o5cmEwSVZqeEhVSVF4STVMU1E4WVg5MURNZHEyVzJMT0Fu?=
 =?utf-8?B?cGJ2U05ZdkluRGZUTDZOekJPZHdXZisvQytkcHdoTmJsTjFEMWhXT1hWNTlK?=
 =?utf-8?B?VkUydk1oUGVySW1OWDZURTNNRlhoa01qd1BVWFB5VktBalZiRkthNjJOREZN?=
 =?utf-8?B?OERyc1F5dnc3RTYwY1ExUGtzODljaFd4Mlh1TGhaYm1EZC9PV1doYVRBUU40?=
 =?utf-8?B?c012N0RKd2NSdFFrdldHdFVUSjV0ZWgvbGJDUVBlcXBtL3VOdlVua0JnYjdi?=
 =?utf-8?B?NkJ3T2JiZXpYd2wvNWJrd3hVVGdmakM2RTdqV0xIQWdYczgreEpwUE9xNCts?=
 =?utf-8?B?dzdnUU9iWUpHSy9CMVVPbi9pWFFOdlA2dFNpR09JZ3NBNnVzSjJlaTRHcFp2?=
 =?utf-8?B?MnZYRStidnA0WXdUOHJGQ2FOT2VJMnhid0kvQVNxM2JJZTk4QWpwM2p2em9l?=
 =?utf-8?B?TGIyVHRUZlNYdmJDbFNCbWhZdmhxNlFLMHI2b1M1SmlzOGNnYndNdTEzMUFn?=
 =?utf-8?B?VnF1d05RMDlvRkpZTncyQTlBVWExWEgyZW4rRlVSQURrN2hwLzNXUFkrYmlM?=
 =?utf-8?B?SVh1eVRTU05SK1d2UHBpRmlOdktBRitCNHpIRUQ3RGhrZ1FtMjNNdnNUZVVp?=
 =?utf-8?B?dDVmU1QvVkk0dmd4REhVdmczTmVTbTk3cmg1K1lxQ1ZNa3FUMWFsTjkxSXhV?=
 =?utf-8?B?UHZpdEhicmcwSmNpZmtUUWpmZ1U1YXpzVGlEZTl5aGZ6Qzl3blhYRGJpRVp0?=
 =?utf-8?B?Q2w4d2tmUDhKRitBY2dKMWFQMGI3ci9HRzRmRlBQSnFrWFUyekQ2WXFXQXRC?=
 =?utf-8?B?Y0tSTDNPWGU1c1NVZUNaWkxGdkZac1VlQm9mcUVxK3o5K3JoblJJMzM3Lyt1?=
 =?utf-8?B?TWxWWDdTdTU3MFdBRDR1aDhKUnlCOG5DZG44OGZFVGNyUlRscTMxdTE2YjdR?=
 =?utf-8?B?MytQeUJ4V0dIRVprbXI1aTRROVdLeHZ6QmdVZkZDZ3RxWmRwanI5MEVBcjVG?=
 =?utf-8?B?bXFXajh1bmJIeUJhNGVuT1Q0dzRKTlRHRnBhdGh3b3IrVFM4RW9tZEM4TFR5?=
 =?utf-8?Q?o2CTMm0gdzJmnY8ip0WWwFMTQd7wgMBp?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(7416014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K3I2Y0Jlb2ZEMmZCR2dKSlJGUE5FTmpzMmFYTllUQmFvOXlXdjhST0Rma040?=
 =?utf-8?B?VldaYTEvb3I0bGxab2g3M3gzMUVBZlJyL3NqcUxWRlQyalBrN3JzNHVJYkRB?=
 =?utf-8?B?ZmVpb3F1U0taQ3MyeUM0YTI2TWpPN0dMQyttWU1waEZNdVFvOTBST2NzcGJU?=
 =?utf-8?B?SEVDQnk3SnpSZmVpdG1TRm0wZVZXZ0tOU1hEamdGV2FyNVlFVFM1NERQRFQ0?=
 =?utf-8?B?b2FLNTgzK3U5dWFVb3JJWFRLQkhXOXV0SWV6SllZZ1NoRC8xTXAzTGVUQWlN?=
 =?utf-8?B?S3NhQnIrbVVub1R5WkVGZmhudXBubzVDb0RCNVkydkttcDdTelBTV1FKd252?=
 =?utf-8?B?cE5laTh2UkdDaExjclRQSDlPaU5Hby9KTG5KSDhoQVpDUGQ5RFF3SVdwUnR0?=
 =?utf-8?B?SDRXWU9RYm9MNGVOWjBkNGY1eHd4OFlpODFjSmlyYkdyWjZic0xpMkJQckRL?=
 =?utf-8?B?NVBORGluS0syUkFaakpsMXJuVUZ4amxnZkVJNHNRNTdJTnZLTERpUm44NGRm?=
 =?utf-8?B?T0pvc1NrTytaVlZTVFAvbjl4RjJMKzJsc0Jya3JGalpRNVV5Y1pmMTRLcWZs?=
 =?utf-8?B?THh4SG11VnR5ZWRTY2Ezc1llUHgrQkUyUXlDNnlZUWVKdkpPeURKdWdzUFJ5?=
 =?utf-8?B?SjZuY3B5dTNnQzV0am50V3lZS1p2OURHU3pZSnQ5WWtsM0hvcFpYNEFYeGE4?=
 =?utf-8?B?WUVhUlFycDZOekJlK2dNeUxxN25xWkNzUUdtd1lmSk9nYnh2RkZhcmh1dW4z?=
 =?utf-8?B?SXRpcG0xbWhnU0RZeVd5azBuWWFZaitNeWVuVlBpNjlQcmFBL1dHR3ZBSFFv?=
 =?utf-8?B?YThNOXA3OEVxcGo5WkhZZVpiT2YxNkduclBBZVJKcS9SRXJNUTVRS3RnSjFu?=
 =?utf-8?B?ZFNCN1ZIZnlCQzdkQUMrdjNURnVkd0tjNWErQTF2UFNrallBYllBdXhVQm1s?=
 =?utf-8?B?cUZQTnpuVXlYVU1ITVZhZ21WaEdITTR0ZGFhT2ZpblgzSG9PU3pwRkJqOUY4?=
 =?utf-8?B?NzFsanlLRFZySlhnVjd2TldxdnNLTkRpYWxGLzY4bjUrTU8ydFlEMFBXcWc5?=
 =?utf-8?B?Q0dFNWZoak16V0lKTHQ5QXJSY0Q5b0dSQmZ5bWU1Z0dMaXZXTDdJREcvZGVS?=
 =?utf-8?B?WDkwdnlFM3pmSmh0TWRtT3NSbC9Fd2NqVWM5SXU4b082TkZBSEYzYWZ2QTdF?=
 =?utf-8?B?L1IvcXd1M016RmpyVys4czNIQTZYOEZxS3dXamZkdS9yekh0TUEzdlBwNjVD?=
 =?utf-8?B?SWJjeWJRWVUyQkNjN25PUmlvRGx0aDFBRk52azhFZlVPRU1MQUREQ2tOWmF2?=
 =?utf-8?B?QkcwSyt3U2VXQU5GMllad1pWNDFmZlFYdmJhaStBVkpBNmFSYldFQzdBakk0?=
 =?utf-8?B?UzRiaWpMRmZuMWNTVFQyNnJ1SmdidXFkRlBYZGJOa0lSVjNmM0JyVHB3aFhD?=
 =?utf-8?B?RFZReFZSMFp4aXVRZE9xcG94VS9tOVpka3FMbUlLbkl5OXMrOERncWJXU0t6?=
 =?utf-8?B?Z3Q2U3hBcXNULzJmR2Q0RXFrSi9TcVN5ZFNDWXZmc0NkSy9sa055dnFoaHFL?=
 =?utf-8?B?b0tLRVZlaEt2QVRWRlB4WWVpdFZrODRqcEtMTlV5VmdPTlRSYnVybXk3YkpM?=
 =?utf-8?B?MFBSQnNVcUVMOEdZa21ZY2g4S1FZYTdYOTFLWnIrNDc2KzdCNGdpY0hwTUFk?=
 =?utf-8?B?Rlo5NmQ1RGR4WTRVaEpCMEd6OXdwSGluUUowL0xkYnIyVnVLSE8zMjJYbHVD?=
 =?utf-8?B?K0pKVloycHd6dmVSdVc4dmhHRUlzYkhtWGkrM2F0SFFheG1YcjkrcGlyTmEr?=
 =?utf-8?B?R24zVUgrQ1cyaGZaN2NUNktmS1hNZm00cG1JQkNNRk1YYXQ4SjlXd24wZ0dQ?=
 =?utf-8?B?Wjh4dllwRHRsNGZMQXZYd0Fvdnl2MVZ5NHZ4aVlHcXcxOS9pNDByNHo1aTJw?=
 =?utf-8?B?b3g5WGl1aStGeGorZUNsLy9QS2RrR08xMXJDbktRSTJPZ28xZmtGbEpXbG9z?=
 =?utf-8?B?T1dEQ2gvOS83NEN6M3J0UHpkd3I0L0FKM0RVaU1ybFVPWkdrNVZYRC92Tmkv?=
 =?utf-8?B?RzZ1UTZaY3RMOTM2dGFSRUV1RnNpRkhvOUVha2JJVmdUdEt0bFRCeGZwRGN3?=
 =?utf-8?B?d3YwRWNuZURhcjBnU05wZHdmdFlEQ0E4T2NqV1NGb2RhcXhTcUJOWWg1WlZ2?=
 =?utf-8?B?OWc9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 87591fe4-1363-483a-a47c-08dd6881faa5
X-MS-Exchange-CrossTenant-AuthSource: DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 14:09:22.3331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bJhz5ntQq6xJH9hnG53db7ZsPDN0ezecL/8LMtA8aFxvbzvWNjA0L7V4QOjlizCPIGSxmfrYCEUk4M51AWK/jSdMpH3JVv3nOHDbnSbAdcE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6603

On Thu, Mar 20 2025, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wr=
ote:

> va_format() is using printf() type of format, and GCC compiler
> (Debian 14.2.0-17) is not happy about this:
>
> lib/vsprintf.c:1704:9: error: function =E2=80=98va_format=E2=80=99 might =
be a candidate for =E2=80=98gnu_print =E2=80=99 format attribute [-Werror=
=3Dsuggest-attribute=3Dformat]
>
> Fix the compilation errors (`make W=3D1` when CONFIG_WERROR=3Dy, which is=
 default)                                   by adding __printf() attribute.=
 This, unfortunately, requires to reconsider
> the type of the parameter used for that. That's why I added static_assert=
()
> and used explicit casting. Any other solution I tried failed with the sim=
ilar
> or other error.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  include/linux/printk.h | 5 ++++-
>  lib/vsprintf.c         | 7 ++++---
>  2 files changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/printk.h b/include/linux/printk.h
> index 4217a9f412b2..182d48b4930f 100644
> --- a/include/linux/printk.h
> +++ b/include/linux/printk.h
> @@ -2,12 +2,13 @@
>  #ifndef __KERNEL_PRINTK__
>  #define __KERNEL_PRINTK__
> =20
> -#include <linux/stdarg.h>
>  #include <linux/init.h>
>  #include <linux/kern_levels.h>
>  #include <linux/linkage.h>
>  #include <linux/ratelimit_types.h>
>  #include <linux/once_lite.h>
> +#include <linux/stdarg.h>
> +#include <linux/stddef.h>
> =20
>  struct console;
> =20
> @@ -87,6 +88,8 @@ struct va_format {
>  	va_list *va;
>  };
> =20
> +static_assert(offsetof(struct va_format, fmt) =3D=3D 0);
> +
>  /*
>   * FW_BUG
>   * Add this to a message where you are sure the firmware is buggy or beh=
aves
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index 8ebb5f866b08..ebb3c563a7ee 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -1692,9 +1692,10 @@ char *escaped_string(char *buf, char *end, u8 *add=
r, struct printf_spec spec,
>  	return buf;
>  }
> =20
> -static char *va_format(char *buf, char *end, struct va_format *va_fmt,
> -		       struct printf_spec spec, const char *fmt)
> +static __printf(3, 0)
> +char *va_format(char *buf, char *end, const char *fmt, struct printf_spe=
c spec)
>  {
> +	struct va_format *va_fmt =3D (struct va_format *)fmt;
>  	va_list va;
> =20
>  	if (check_pointer(&buf, end, va_fmt, spec))
> @@ -2462,7 +2463,7 @@ char *pointer(const char *fmt, char *buf, char *end=
, void *ptr,
>  	case 'U':
>  		return uuid_string(buf, end, ptr, spec, fmt);
>  	case 'V':
> -		return va_format(buf, end, ptr, spec, fmt);
> +		return va_format(buf, end, ptr, spec);
>  	case 'K':
>  		return restricted_pointer(buf, end, ptr, spec);
>  	case 'N':

I'm sorry, but this is broken in so many ways I don't know where to
start.

The format string that va_format actually passes on is va_fmt->fmt, and
that is _not_ at all the same thing as va_fmt cast to (const char*),
even if ->fmt is the first member, so the static_assert doesn't do what
you think it does. So of course the ptr variable (which is (void*)) can
be passed as a (const char*) argument just as well as it can be passed
as a (struct va_format *) argument, and sure, the callee can take that
arbitrary pointer and cast to the real type of that argument. But it
seems you did that only to have _some_ random const char* parameter to
attach that __printf attribute to.

So, since the format string that va_format() passes to vsnprintf() is
not one of va_format()'s own parameters, there is no parameter to attach
that __printf() attribute to. So I actually consider this somewhat of a
gcc bug. But can't we just silence that false positive with the tool
that gcc provides for this very purpose:

#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wsuggest-attribute=3Dformat"
static char *va_format(char *buf, char *end, struct va_format *va_fmt,
...
}
#pragma GCC diagnostic pop

with whatever added sauce to also make it work for clang.

Then you don't need to annotate pointer(), and then you don't need to
annotate the BINARY_PRINTF users of pointer(), though I think those two
do make sense.

Rasmus
