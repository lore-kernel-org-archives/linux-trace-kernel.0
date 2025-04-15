Received: from mx0a-007b0c01.pphosted.com (mx0a-007b0c01.pphosted.com [205.220.165.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294DBEEA9;
	Tue, 15 Apr 2025 01:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744681172; cv=fail; b=OFT9bykcxs1M2+zrcbt8J+TLZ5JZzMvoYGOQYebLepYRC/B2oFlKQbS55UvE0ju5lJa9vFg6lf0uiZ62SHOIcViqSMSyPxWZHvpCMM5yqvsmOCGZr/V9DLbH8DfHtMMUnnKN9bolZq3TDSGyJPx9atCdZJCsZ53LvcaaOEAcv2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744681172; c=relaxed/simple;
	bh=Zki7NbayZwnu+/MiPZHEZXxq9/3KKtbm/RnKyT7IGJ8=;
	h=Message-ID:Date:From:Subject:To:Cc:Content-Type:MIME-Version; b=bsu8LZYcPu93TQGLMtELbIGubkqdJKdAlkPZiLqd/NIbGSC/6JNNiYd6zVlycvdwVsXbZaGGfN+k7MXFWb/54zMd4VyOvAAkzVW5iqXP+ss6winaNrbC7pb/G5YFtK68ac/hw1hqhzYLXLKOT6YdZzppZkdgmnInRg1O/WMBs94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.wisc.edu; spf=pass smtp.mailfrom=cs.wisc.edu; dkim=pass (2048-bit key) header.d=cs.wisc.edu header.i=@cs.wisc.edu header.b=h4fsnBHi; arc=fail smtp.client-ip=205.220.165.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.wisc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.wisc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.wisc.edu header.i=@cs.wisc.edu header.b="h4fsnBHi"
Received: from pps.filterd (m0316040.ppops.net [127.0.0.1])
	by mx0a-007b0c01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53EJTaAU014782;
	Mon, 14 Apr 2025 20:39:03 -0500
Received: from sj2pr03cu002.outbound.protection.outlook.com (mail-westusazlp17013078.outbound.protection.outlook.com [40.93.1.78])
	by mx0a-007b0c01.pphosted.com (PPS) with ESMTPS id 460b13u8my-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Apr 2025 20:39:02 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RZvQ3F0Y1MwIYvFWIiUNjCtYBeHXxXRawSOW4QgEjvholi+xHvCnQJMe6PQexMptg/qK5Gn/qxfELV/UMEnO6lwHeDEAJVUqyaZAbervL7VQkJGbCWNrg07SbrefamuOFbBFz8e6zqw61Hb5ikc+f50XImgMB3IM7k8kWVKcEKfBijJc0TGNyol3GIN6e2HApZ0PRs1iPQLZ6OSCEXjLc4IeK4PUFSoAMckW4T7Ncb2WWVXbewwXqouhkRins4uKgOoFKTdnjiavqzD0+NSuUqdoLFyJXIvqbOBDdxfbL1MR44VpJT3hgFXPLanBa35JHXlZxkep69ROxDWPxf9eWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wWepKURXVfNYrrPFCpO9tyM2kltf6fJgiw5xIX+afbE=;
 b=mZUIq1Tw3i/WUHN+xAswR/21i1m34Dvj5qp/r+YJWiPboSKEM01aWyqoCLEJW8WrXyH9Kvnl8vvSkpnu3xlNbxJq5BDQsYRqkkho8OmYKVKeWnoGnjBTD0xoIp4L3ay76V3JoIlmB+Q2cfaxG8GPmwuYdsg2j3Phg3pY01uBnEULrK0br5iWBVTbp2iAz7qsyB+WFGi+7hEcsHhj7L3JwtSsl0DSwG7xXXr6qD0+xD01/JqxRuJFCncYn+hdJ0zhnbVYnglQyqY9pONgkN/kbRBqt944IsiWPLrwqsq9MZlCcRpipN6o4t8Y5ex9FTGF4hNtKv5ggfq8WyjtEEatZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cs.wisc.edu; dmarc=pass action=none header.from=cs.wisc.edu;
 dkim=pass header.d=cs.wisc.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cs.wisc.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wWepKURXVfNYrrPFCpO9tyM2kltf6fJgiw5xIX+afbE=;
 b=h4fsnBHiGQ7l+PXYxlSCQYZygpuZTLT9OMpbG0NSwzdU5d4DUk9W1GtdhxOF1viyWEcFI3h4QbchkN/ZJfwIr/fWIRuGDdjOZ0IJukqyXvSfyWwyxULXmOyCyIvkrYeviiN0U0g+ai55j3nlF6AmkEm0r1n0+qUD6yvLNF9p47lKt9+1UGU8SYofq3/j0PdNL19JqAYOgPya3sbNnDaIyxGd8MWYY0GupPti2y3Za25bmV+b+2NSCO9Gugs0TvQW/E1wnVTCePV5/caJqmIPxTdGOcAGgIVp/RY4S83KncVPS5TlyeH8ueDQXX4H6qaXACJYH2U5DUXqN2L2/y44Ag==
Received: from DS7PR06MB6808.namprd06.prod.outlook.com (2603:10b6:5:2d2::10)
 by SA1PR06MB8420.namprd06.prod.outlook.com (2603:10b6:806:1cf::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Tue, 15 Apr
 2025 01:39:01 +0000
Received: from DS7PR06MB6808.namprd06.prod.outlook.com
 ([fe80::76b2:e1c8:9a15:7a1c]) by DS7PR06MB6808.namprd06.prod.outlook.com
 ([fe80::76b2:e1c8:9a15:7a1c%5]) with mapi id 15.20.8632.030; Tue, 15 Apr 2025
 01:39:00 +0000
Message-ID: <76ace3c5-2882-4b48-8aba-45480714cc71@cs.wisc.edu>
Date: Mon, 14 Apr 2025 20:38:58 -0500
User-Agent: Mozilla Thunderbird
From: Junxuan Liao <ljx@cs.wisc.edu>
Subject: [PATCH v3] x86/tracing: introduce enter/exit tracepoint pairs for
 page faults
To: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1P223CA0044.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:5b6::17) To DS7PR06MB6808.namprd06.prod.outlook.com
 (2603:10b6:5:2d2::10)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR06MB6808:EE_|SA1PR06MB8420:EE_
X-MS-Office365-Filtering-Correlation-Id: fdab5639-9004-44fa-f577-08dd7bbe4c18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|41320700013|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dWI4MVlndzNNK2NnZ09McnNFSW5rWE04Y0RER1dmak1LSDcxRXY0ZEkxUEhm?=
 =?utf-8?B?ZGhPOVd3WDdxMW16VE5KOFRWMnNBWml5QnF6V1hieTg0YmJpMi9zdWlHK3Zs?=
 =?utf-8?B?WkkxMDE1UURsMFFOUkdZUXhSbkpwRVEreXNxV1dvcXVMWjZ3UWVZa29pNFIv?=
 =?utf-8?B?d0dUaDVqNDRUdysxTHpOMUQrYjRvbDRVQS9iaDZuWjlZa1Z0cThUNWZUZmVz?=
 =?utf-8?B?TGcySS93L2lXVDBWZFZlMzM4dnF6V0VQcnJTaE9HNzIrUk9FUHBoTnNnVENa?=
 =?utf-8?B?MmkvbkpGM1RlK3RvSVpmZ2RVTFgvNWtETHE3cjMxMmQyM1U1RUJWOTFLYlBK?=
 =?utf-8?B?Q3hOM0xGSUNWcVp1UVZMc2swL3cvYkh0WGkvS1I3UUJPWUl5L29makxBeDRx?=
 =?utf-8?B?d0d4WXdzb0Zqa3M1UGpoS2p6NElzbVlYT3lnZElSTU9mMnJOeWNEdU9zc0RB?=
 =?utf-8?B?Z2krVGpZck96WXpCWCtCRXUxNk1jL3pYRGp3ejEvUUZNN1E2aGxUTXV2UG5n?=
 =?utf-8?B?WHpmNDdaREJjQkc0MFh5eG5CblIweXdSRkoxUDZVMXRRSXllWmFacTRFdFhZ?=
 =?utf-8?B?U0RnY3BNNWE0OHBkeWxNTUhZdkpUZmVvK0VYN08ySmpaL0pqYkZqclRyVUFE?=
 =?utf-8?B?aUF2QldSNU53SmhUcThQclB4K2NlVFg2ajFPM3duL1FlQktsZ0N0QjFDckFs?=
 =?utf-8?B?OUtQTUxEVGFUYy9GOG9IRXJuMVZJNE0zamM2aXhYZW4veXgwb1FCM3U4N1dL?=
 =?utf-8?B?dFRKNmpuM3ZsaWdMR2hDVUxEMGJaVXZSamlHWjlVTUUrQzUrOVpFaWMwYmxV?=
 =?utf-8?B?bTRCbFEySExqdm5KRUVYTG9vazQxLzgwT29Lb0lvcW5DRFhPZW9KaS9NditR?=
 =?utf-8?B?emRCd05SNTBndXp5ZmlIczF0VlZ1dXR2T2M4T0pzcjFvdWR4c1hKK2Z2SFly?=
 =?utf-8?B?M2hkcVBWZThoNE9Mdm5JZngzZW5KNC94WlkzWDU5TFJqMXI3TEMrdVVZMGVz?=
 =?utf-8?B?NTJFNWo2OWhYRnoxaTZQNEh1dzN1VWlDcldneEFiUTlTUUFRdm5aMEF0SFc4?=
 =?utf-8?B?VmRpVHZjdEM1bGh5LzJwOVl6ZlVPbHFQSkUxRVp3SDlmL3BNSVBwbWNoT2Vl?=
 =?utf-8?B?OUhYWmtFT3lBYjU4dVpYWWtsQVlUL0hIU1FYRUFvaXRRQ3RpTFdsVVd0Mng2?=
 =?utf-8?B?ZUpwckNzeVVkdnhzc3l4dVR0REwwczAwNkVJTEIyRjFyR2xkRk9mWGc1dENR?=
 =?utf-8?B?bDVEd0c2d0ZEUHNDcStKejI2eEg0bng0andwY3crZng0b1hpanhzSXpMT0hr?=
 =?utf-8?B?WkIrS0RDaU50Qm5MNkVZM3hhTnlXYStTSEdlNndvZjNPNEN4Q3hDaXlqZjhB?=
 =?utf-8?B?Y2tiM0o5Y3lYeHA1YSt0R1JXSUlsSHlLNmttVXZrSzFDMCt3V01HK2UxTVZk?=
 =?utf-8?B?YmczdkkzUHg2NWlaa1dkMVlzTHNvN01wMFBaMTFoQVF2SWFTV3N2UEwyMjBP?=
 =?utf-8?B?NUIvZHdGZlpxcDZZeUdRT3g5T3QwY1JoV1dneFpjV0pqK2pETFI1TUJ2SzY1?=
 =?utf-8?B?SFh0RHRObTY5NXlscjF4OTVYaE1Pcy9PY29jYnpMc0JyMWJJK0YyZW1uZGcw?=
 =?utf-8?B?VkMwTXlseDZibUhwM1VaN1RDY0YyRFVwTjFJVVNRWWdZZ1VmanBlczd4UTNU?=
 =?utf-8?B?WW5RSVlCbmhscGthNC80Sk9yc1BwSDNvbDVkK1I0Rk53aGlIbnhCdE9pS1Bv?=
 =?utf-8?B?dVJlTEFrUk5iMzNyMjZhUmNTVnNHcU0wVm1wUldGd2JOWWdnMmlSeDFTU2tp?=
 =?utf-8?B?RWlCTDVVRStrM1ByR1pLK0oyUUhOZURoMkF2OEJsTFMzVk5VM2NSOTZlTTc4?=
 =?utf-8?B?dytzZWlLQVEwa0NmaklLdUdCUGhYNHdybDQrWE1ycFdMOUhaQThUcDl5VE5L?=
 =?utf-8?Q?S7oBeFqKzbk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR06MB6808.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(41320700013)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?LzdIMlFFTEpBTXJlekkvajFEd0JjSm5IblRsWHI3ZEpYYWE1YnhaUVI5OTlS?=
 =?utf-8?B?VXltWmFuZVJnNWJqRHY1aytZZEpHZU52N3RLQ25lbDJPRncrdHhLa2JrQW8z?=
 =?utf-8?B?VkZpWW5LMU82NWNDVDMvZzAva005N2lvMjFLa2ZkVHdIcXFmd0hVMm5IdFNR?=
 =?utf-8?B?NDNyWG4xYmJ6NWdzZUVVeDhSTzFkQUs5UTJKUUFpcDNmdUlRMUNQU2tHRUdM?=
 =?utf-8?B?M1IzNGtJQ0ppajI5a1dGcWxDcEZGaXZHVkR0RUtFY29hbkZtWE5XektCdDZw?=
 =?utf-8?B?SnlPR1lESjJ2MU5wcW1qUzYrVWNZdi85d1o5R3dZY1ZYRTlHdGpVMXl5RG4y?=
 =?utf-8?B?SXBaNkRkcGw0MjFEV0duK2VndjFKY1N1d0Y3d0Z1NUM0RmtLSXkrd1BwSnBL?=
 =?utf-8?B?ZC9qNThHMU1uRjZzazRmTTlXVzhDNERhNUhzUEZhZko3bkcwRlFKanNPY2sx?=
 =?utf-8?B?aXJGRTdpS1JZVlFTTm45bC92YjFQaUs2UW1hVFlXK0IvUG9EdDhHeTM4bzVO?=
 =?utf-8?B?eFRsLzMvVkZKSERaUHo0MmFGZklaZ2R0QkhTV2Fma05tdjJkU1pyYlROZ29n?=
 =?utf-8?B?RnAyVk1GTEJhU3N6OURhRzZLdHpGclFxVy9aSzQxaGYyNzd1cmVweWtxM29I?=
 =?utf-8?B?MmZuSlJpUVpobUJvTHZUQVNFZnVxWm9MN2Zhc2owcS9oamNQWDYydG14T2pv?=
 =?utf-8?B?TG8zZjlMSTdrSm55VDY1VDFBdHRDV2E1WE41V2ZtZU5saXV2a0h5ME9qT21K?=
 =?utf-8?B?emVHdXdWc2lJRzNhUGVXd0UvL2hXVXYrRmpnczQ0eXdkZHV6clFoRGZESUVL?=
 =?utf-8?B?d29YSFJScXk2a0xlY3c5N29GaVVsVHRILzNuem5JTTUrRGwrS3JsZlBtMUJI?=
 =?utf-8?B?YkgrNXc0dERNRjRQVlZOejhSMFlHLzhMYWZFZTF4REZKU01MVWI2eVZmY0JL?=
 =?utf-8?B?K2NqQWVkdU5PZ2pybFlmZ2ZHZ3FiVWQvZ2RDVlo1dWJGMDFJSXJYcVNnVnMx?=
 =?utf-8?B?MysrWDVIREZoY2haZzI0K3g3b1lpZ0hDR1JCakVrdjYvYmNvdkEyTXRVZ2Nq?=
 =?utf-8?B?QUMyTlhzSDExTWY1WkdCTWplOHg4Wlpxb2pCM3U3WkZCcHRET21Eb0dSdHhx?=
 =?utf-8?B?dHQvcldjc0pJTnVTeldGaWYwSkwwSWpoSUNoZytmMFRDSHFCeG9CaUNsajBp?=
 =?utf-8?B?Sll0S0dTSVdXQm5rZVJVWWNwWmRKNG5RNHJGOERFVlpEeWVhdUQrVGorZmVl?=
 =?utf-8?B?amRoTVQ4OWw5eWk2N2MrOXRmazF2QWpNdGYzSEkyb2FJNHVwK3JtTEdXVmVh?=
 =?utf-8?B?K0xkNjFZRjdHdThNdnJwUEdob1lSSXQvV3dybGhwbXFFZW5uNEZ0WFdacnhr?=
 =?utf-8?B?RjB2amJuRFZ2MGJmRW54QTEwemc2TmR1dG81N052MVF5elJUekxDMUtGMXJt?=
 =?utf-8?B?RnZvS0x5WWZDWndVV2xrZ3JzS3hKalVCaENQTXFvbU5ZS3FucG05WHhaSE92?=
 =?utf-8?B?QnBsNGVTQ0cwdU1tV2lObXFlb2o1aUJrbjRPZDVqcVJMSW4vS3JGK0lmV3R0?=
 =?utf-8?B?MHJ2eFRJRFBoK1dmWERZckdoNGRHbzhjV3pMTWVDcUFHY2VWTXFTeWZSaU85?=
 =?utf-8?B?RVRQaXZsQkhoc2FkU29ONnBjK1ZzWjRYNXdsTit4ZU5HaVNPUkY0UG91RkNo?=
 =?utf-8?B?OEprcXhTbzVyN0hUUEY2d3NRUWxQOCtqMmtnMVh0TTNUVzRWdk9QanFlbjNq?=
 =?utf-8?B?dDQrNTVwb1pwU2ZRazgzeWZsQnR5aWIrY3NXSXFCQmxSUHIxa0cyQ2E5aVBV?=
 =?utf-8?B?bHJTdnJidENaaHFMOWNBQXBpdXRicng2UXk3bmpmRlU3ay9WMXdwZGNTai9F?=
 =?utf-8?B?Mit1RlcvS2o1dzhPQmVQQXZGbTJCbG9jUkYvRnZ5YWRiMDQzQjBmSDl1R09E?=
 =?utf-8?B?TVRkZ1NORUY3WFVpNHE3M2pET1NRYjllZTdlL2s3cEUyQ0M3ZnNaODJuR1FL?=
 =?utf-8?B?NVk2N1p5Q0g0eTRoUllpL0xmcHRpTFpoT0hPcUhuenUzUVpiWlZSM2lHcHp2?=
 =?utf-8?B?dUZnRFQ5dDNxKzRyUlFKK0tZVmVVMi9wZ1lFOTl6cXlCcGIrZmNJdlkxT1hH?=
 =?utf-8?Q?uQYT+GLQ600iVI4tvHRwPByHI?=
X-OriginatorOrg: cs.wisc.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: fdab5639-9004-44fa-f577-08dd7bbe4c18
X-MS-Exchange-CrossTenant-AuthSource: DS7PR06MB6808.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 01:39:00.8767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2ca68321-0eda-4908-88b2-424a8cb4b0f9
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oXT5B66KaiqrD41n/5K3Mb2VYHDNSfpi1M6WYk1sffsdpRj2zF1IVYZcb0hcIHQ7K3bJRM0VtHY4hCMWdGGXig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR06MB8420
X-Proofpoint-ORIG-GUID: 2_5P-a37wzg9jcTAjPfgxR0UMHOaC6dL
X-Authority-Analysis: v=2.4 cv=R4QDGcRX c=1 sm=1 tr=0 ts=67fdb8b6 cx=c_pps a=l9cCpZ6fIogKje1+qubiRw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=XR8D0OoHHMoA:10 a=3-xYBkHg-QkA:10 a=VwQbUJbxAAAA:8 a=x30EXVXcAAAA:8 a=Vjf5HUuonJV36XDs38UA:9 a=QEXdDO2ut3YA:10 a=yI8jHdU-MAB4nH2QTHtW:22
X-Proofpoint-GUID: 2_5P-a37wzg9jcTAjPfgxR0UMHOaC6dL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-15_01,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 phishscore=0 mlxlogscore=916 suspectscore=0 impostorscore=0 spamscore=0
 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504150007

Merge page_fault_{user,kernel}, rename it page_fault_enter, and add
page_fault_exit. This pair is useful for measuring page fault handling
latencies.

Add a new field to the merged tracepoints to indicate whether the page
fault happened in userspace. We no longer need the static key associated,
since it was used just to avoid checking user_mode when the tracepoints
were disabled.

Signed-off-by: Junxuan Liao <ljx@cs.wisc.edu>
Link: https://lore.kernel.org/9e2ac1e3-d07d-4f17-970e-6b7a5248a5bb@cs.wisc.edu
---
v1 -> v2:
Merge the user and kerenl tracepoints. Remove the static keys.
v2 -> v3:
Added back trace.o. Sorry that I accidentally deleted that in v2.

 arch/x86/include/asm/trace/common.h      | 12 ------------
 arch/x86/include/asm/trace/exceptions.h  | 15 +++++++--------
 arch/x86/include/asm/trace/irq_vectors.h |  1 -
 arch/x86/kernel/Makefile                 |  1 -
 arch/x86/kernel/tracepoint.c             | 21 ---------------------
 arch/x86/mm/fault.c                      | 16 ++--------------
 6 files changed, 9 insertions(+), 57 deletions(-)
 delete mode 100644 arch/x86/include/asm/trace/common.h
 delete mode 100644 arch/x86/kernel/tracepoint.c

diff --git a/arch/x86/include/asm/trace/common.h b/arch/x86/include/asm/trace/common.h
deleted file mode 100644
index f0f9bcdb74d9..000000000000
--- a/arch/x86/include/asm/trace/common.h
+++ /dev/null
@@ -1,12 +0,0 @@
-#ifndef _ASM_TRACE_COMMON_H
-#define _ASM_TRACE_COMMON_H
-
-#ifdef CONFIG_TRACING
-DECLARE_STATIC_KEY_FALSE(trace_pagefault_key);
-#define trace_pagefault_enabled()			\
-	static_branch_unlikely(&trace_pagefault_key)
-#else
-static inline bool trace_pagefault_enabled(void) { return false; }
-#endif
-
-#endif
diff --git a/arch/x86/include/asm/trace/exceptions.h b/arch/x86/include/asm/trace/exceptions.h
index 6b1e87194809..f98c9024cbe3 100644
--- a/arch/x86/include/asm/trace/exceptions.h
+++ b/arch/x86/include/asm/trace/exceptions.h
@@ -6,10 +6,6 @@
 #define _TRACE_PAGE_FAULT_H
 
 #include <linux/tracepoint.h>
-#include <asm/trace/common.h>
-
-extern int trace_pagefault_reg(void);
-extern void trace_pagefault_unreg(void);
 
 DECLARE_EVENT_CLASS(x86_exceptions,
 
@@ -21,17 +17,20 @@ DECLARE_EVENT_CLASS(x86_exceptions,
 	TP_STRUCT__entry(
 		__field(		unsigned long, address	)
 		__field(		unsigned long, ip	)
+		__field(		bool         , user_mode)
 		__field(		unsigned long, error_code )
 	),
 
 	TP_fast_assign(
 		__entry->address = address;
 		__entry->ip = regs->ip;
+		__entry->user_mode = user_mode(regs);
 		__entry->error_code = error_code;
 	),
 
-	TP_printk("address=%ps ip=%ps error_code=0x%lx",
+	TP_printk("address=%ps ip=%ps %s error_code=0x%lx",
 		  (void *)__entry->address, (void *)__entry->ip,
+		  __entry->user_mode ? "user" : "kernel",
 		  __entry->error_code) );
 
 #define DEFINE_PAGE_FAULT_EVENT(name)				\
@@ -39,10 +38,10 @@ DEFINE_EVENT_FN(x86_exceptions, name,				\
 	TP_PROTO(unsigned long address,	struct pt_regs *regs,	\
 		 unsigned long error_code),			\
 	TP_ARGS(address, regs, error_code),			\
-	trace_pagefault_reg, trace_pagefault_unreg);
+	NULL, NULL)
 
-DEFINE_PAGE_FAULT_EVENT(page_fault_user);
-DEFINE_PAGE_FAULT_EVENT(page_fault_kernel);
+DEFINE_PAGE_FAULT_EVENT(page_fault_enter);
+DEFINE_PAGE_FAULT_EVENT(page_fault_exit);
 
 #undef TRACE_INCLUDE_PATH
 #undef TRACE_INCLUDE_FILE
diff --git a/arch/x86/include/asm/trace/irq_vectors.h b/arch/x86/include/asm/trace/irq_vectors.h
index 88e7f0f3bf62..7408bebdfde0 100644
--- a/arch/x86/include/asm/trace/irq_vectors.h
+++ b/arch/x86/include/asm/trace/irq_vectors.h
@@ -6,7 +6,6 @@
 #define _TRACE_IRQ_VECTORS_H
 
 #include <linux/tracepoint.h>
-#include <asm/trace/common.h>
 
 #ifdef CONFIG_X86_LOCAL_APIC
 
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index b43eb7e384eb..e8e33ec684ba 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -139,7 +139,6 @@ obj-$(CONFIG_OF)			+= devicetree.o
 obj-$(CONFIG_UPROBES)			+= uprobes.o
 
 obj-$(CONFIG_PERF_EVENTS)		+= perf_regs.o
-obj-$(CONFIG_TRACING)			+= tracepoint.o
 obj-$(CONFIG_SCHED_MC_PRIO)		+= itmt.o
 obj-$(CONFIG_X86_UMIP)			+= umip.o
 
diff --git a/arch/x86/kernel/tracepoint.c b/arch/x86/kernel/tracepoint.c
deleted file mode 100644
index 03ae1caaa878..000000000000
--- a/arch/x86/kernel/tracepoint.c
+++ /dev/null
@@ -1,21 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (C) 2013 Seiji Aguchi <seiji.aguchi@hds.com>
- */
-#include <linux/jump_label.h>
-#include <linux/atomic.h>
-
-#include <asm/trace/exceptions.h>
-
-DEFINE_STATIC_KEY_FALSE(trace_pagefault_key);
-
-int trace_pagefault_reg(void)
-{
-	static_branch_inc(&trace_pagefault_key);
-	return 0;
-}
-
-void trace_pagefault_unreg(void)
-{
-	static_branch_dec(&trace_pagefault_key);
-}
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 296d294142c8..eda312707fde 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1451,24 +1451,10 @@ void do_user_addr_fault(struct pt_regs *regs,
 }
 NOKPROBE_SYMBOL(do_user_addr_fault);
 
-static __always_inline void
-trace_page_fault_entries(struct pt_regs *regs, unsigned long error_code,
-			 unsigned long address)
-{
-	if (!trace_pagefault_enabled())
-		return;
-
-	if (user_mode(regs))
-		trace_page_fault_user(address, regs, error_code);
-	else
-		trace_page_fault_kernel(address, regs, error_code);
-}
-
 static __always_inline void
 handle_page_fault(struct pt_regs *regs, unsigned long error_code,
 			      unsigned long address)
 {
-	trace_page_fault_entries(regs, error_code, address);
 
 	if (unlikely(kmmio_fault(regs, address)))
 		return;
@@ -1535,7 +1521,9 @@ DEFINE_IDTENTRY_RAW_ERRORCODE(exc_page_fault)
 	state = irqentry_enter(regs);
 
 	instrumentation_begin();
+	trace_page_fault_enter(address, regs, error_code);
 	handle_page_fault(regs, error_code, address);
+	trace_page_fault_exit(address, regs, error_code);
 	instrumentation_end();
 
 	irqentry_exit(regs, state);
-- 
2.48.1

