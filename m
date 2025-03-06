Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11023101.outbound.protection.outlook.com [40.93.201.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CC92907;
	Thu,  6 Mar 2025 02:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741228010; cv=fail; b=d53mwX8FD6i6XS/boJ0bijlTit6GmbH4Sw7qj0tTZ1w4aSS94mAcgI5MhqzE7aBWciyg1iyhaGXOT6ooiyjU36wePG02D27tngCo6g29LhPs4GmvO2H0ibrdoCjXa5Fx9FUCZ2vv7XPRII2hqeFYR2Fj/N0P8Z1FH4qzzojvLi4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741228010; c=relaxed/simple;
	bh=YW1XlnQtYcwX5df09SujO2pwintMgidbMmztTvm2KLA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ciiw3WoOyF0In9LTg+z+v4fXhLcVE2P0WAr5hg57i06U86XFCf1HbspOr7Nk3D/jDPDyUfM2ee9ELAg147dR36d/jDSzXzg7ZX3wCTRQJBmoNH1kaZBj+SagiXBEn1IjCpO9BvVaPDCnLWiPe5jBdd0ZYBlyw0/y1gT6m2QugNw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=HS4EFEYE reason="key not found in DNS"; arc=fail smtp.client-ip=40.93.201.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="HS4EFEYE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZXX7rd3K5jSGvV/mx17IvEgvyfkz9IYYnyYJdUTCyVXlGC5tRoheav+NX3Aa+bF8WEoSnu5NwapmuvOoZCQ7DfSSdMRtVcToWJzb/dX0KkSWavjZSmHlNxjawmOyAePZEJ5tvC9+B9njjtVsWPH2MEMZzq2/wQ7VTn5k/UMvheD63UGZDiZynHrFjoQK5F0pieKXsznX1ZvUiVFAlfOBbFO5De/bzDSZyf+AvSe8QvdAFCuCqH0paHT+0buZVluNKegRVBmXGyZTjnQwlMxY3lTWdoax5ibF+94yeUD+x8LnP0vb89BDhf/GZHM//UXrBvgzTeKybtxXL3tFdVHJCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1MLOluBTLYaIVJ/llQgfWcSxeZKvp0FyinmiyCVKoDI=;
 b=oM+fW1LelsLvYCqFNzhC2XEV+sSLadRy/RMLuo+rShw/sXLCZk5bLrZppxOcr5z2b6naxnJa3EaXJmpmZWBjLbBHw9zXbsmFyAcq21NYrhU8PpoBZVe/rF/pfLIjZuEPEt5gBtchXmB2p8wy+4O3FBIlWure8ceaEV6XB7uWC4fGVx2v3XGmW9Jao2pfun1md8Lz6FN9sBoJd0Kymg5GOsv9hqsjSgjHOIYtGjx/uPVeXxpb1dK7U1xJ1bBZxuDC8GroJdpYKR8W1Var021yZtPOVkajF2DJp4/lwh/jgi2Oe9/sgtGuTtZufPXq6U9A2vNgn2G7Um4fehBLFRlOTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1MLOluBTLYaIVJ/llQgfWcSxeZKvp0FyinmiyCVKoDI=;
 b=HS4EFEYE4ZcYVLeWJWZ0ESN96li2zlD/ebaNjN3sC9jhM8jI4AkrdzPdBQKO4gV0sY6NoypC9RQK+YAa79CWDGJTTCOO2vKe47Gj3Rcla27TSLiOz1/o1qe+QwEljLTupL09F+EL5cXCAraTvD7W2sXWnBuEZl2gg1P17xjd2YE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from PH0PR01MB7975.prod.exchangelabs.com (2603:10b6:510:26d::15) by
 MW4PR01MB6500.prod.exchangelabs.com (2603:10b6:303:72::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.19; Thu, 6 Mar 2025 02:26:44 +0000
Received: from PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::6926:a627:118e:8050]) by PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::6926:a627:118e:8050%4]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 02:26:43 +0000
Message-ID: <070e4579-bbe3-48ef-9e60-1daf51df4b78@amperemail.onmicrosoft.com>
Date: Thu, 6 Mar 2025 10:26:35 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH resend ] tracepoint: Print the function symbol when
 tracepoint_debug is set
To: Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Huang Shijie <shijie@os.amperecomputing.com>,
 patches@amperecomputing.com, cl@linux.com, yang@os.amperecomputing.com,
 peterz@infradead.org, jpoimboe@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
References: <20250305015505.14493-1-shijie@os.amperecomputing.com>
 <f600edd0-8855-46af-98ec-1181db1f5dd4@efficios.com>
 <20250305104749.15e57b19@gandalf.local.home>
Content-Language: en-GB
From: Shijie Huang <shijie@amperemail.onmicrosoft.com>
In-Reply-To: <20250305104749.15e57b19@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0045.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::16) To PH0PR01MB7975.prod.exchangelabs.com
 (2603:10b6:510:26d::15)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB7975:EE_|MW4PR01MB6500:EE_
X-MS-Office365-Filtering-Correlation-Id: 55b0349e-b22e-4038-457b-08dd5c5655b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZG9mVkJYanA0eHB5Z3BqWk1ZUGNPQzczc0dzWmdOZ3JQV2VOVSs1L2JVMUFi?=
 =?utf-8?B?Z3c5WlIvN2Q4N2pra3F4d0pxYTI5VTBtU0JZdmRYUFkyZnZGQ2crUWw5T3dJ?=
 =?utf-8?B?M0t0SzdqeDBtRVlSTFVOQWlwQUZsRldzQmNaTkZyWkNyN0dXOXZ0WmxUYndL?=
 =?utf-8?B?UjNNOGNja0tmWU90MHlGWTJLbHphaWhmNmxVQVJwRjNDQWRXcGtCY1ljZW1F?=
 =?utf-8?B?WWJkOVJKMmFMdURlZ2lZd2h5NjVUQWFDN0FVRmNXRXZQT3Q3SndTQ3YwZlhm?=
 =?utf-8?B?aVBRS1dDTUg2bjhCT0FOR0l4K29DTEcxRXlVU3JEQWpDUWRIZEJzS0F1dlQz?=
 =?utf-8?B?SUNJUVoxM00yZmNEY0R0S3AyTVdlc0F1Ym5MRzJiekU5UzFjbTFjN2xFQ2FP?=
 =?utf-8?B?eEltNmUrNTE5RjF1a205K0ErVHBVQmRNTERERXJLckpaK2NsRDFlSTBXU3dD?=
 =?utf-8?B?N0NjRnNJazNBUEhDcUNsckM5Wm8wc0pnbWRtcHJyc1F3NjBvZWl5WkhuSlZD?=
 =?utf-8?B?NGROTnRsQkY4OXhBa0hoOTI3Z2xjR29EZHBjaHJTeTlvUzBwcEQvbW0vWnlY?=
 =?utf-8?B?OUJrRGIzeUIxSXd1dnVYSDBCT3g0YTB5bW5RclRGeUZuSk4zb3hieFp3aDVr?=
 =?utf-8?B?VXNxNERDajVFWnFOZHFndWVGcnFlMmZVaGd6RE5aaWs5bU1mY0syei9HeWph?=
 =?utf-8?B?MjY4RVgrUDFReHdOMDlhTVdUaGtuT08yNG0vZlJXdUZjRmRxVVpQYjFMM1Zo?=
 =?utf-8?B?djJuT2NwWnB1M2hTRU9MSWZWWTgyblZaNmZueHZlcmRZeitsMWpNTGhyT3hB?=
 =?utf-8?B?Ri9CYk96SkZSbkRCVW9QK1BjYmZ0VEs4a01mM01FZEVIQmNkWHhOZDBTOG5M?=
 =?utf-8?B?ZDJCbUpmMGxYL3pnQVBBUis3eHpLMFpwY1lqVjlQd2FsOER2b1VOOVJiWmxX?=
 =?utf-8?B?cTkyZVhNeVAvOS9KR0xzQkxjb3gveitpK1puNWs1VVJQSVNiZFhyVEhjZi9n?=
 =?utf-8?B?RTZtbHRhNkN6Y2pIMlRVd3BNK2VUMUl1dHhVRis1UmVVS09yTTh5cUsrK2ds?=
 =?utf-8?B?RFhWVjFUZzlnNWpza3lMbzdqYWc4SGRid2tGTlVpczRNcGRRaVJNZWdTcVhK?=
 =?utf-8?B?TERqYnBJcmNrdkhldFZrWVhqSEU4bHlNZGpmVG5tamYrS0lpalBDNXZteWJv?=
 =?utf-8?B?KzhZRG1tODNCYllJQ00wUVlzaHZ5QW9ZN0txOHR4dGY5MU5kMTQwTjZJTTBk?=
 =?utf-8?B?dTZMbVplRldaUTR6NURkWmZkUyswck5ZaVhLMCsrbEh6MWEra3NJSEdtK2p3?=
 =?utf-8?B?bVl3Q055dGRhZllReDhCditoNmtxV1FFa2MrdjlDYlYwVWkvUWxsbElnSWlj?=
 =?utf-8?B?UUYxckVBVDZDM3EzS2lOamhPazVTc0lEUlc4MEEwTHFiVmdkc2dlSDBvMkRE?=
 =?utf-8?B?REw0b1orSXpkam1CUkliLzl3TnVVM1QxV2hjcy96aVZuRnBxbWVIajBiSm1U?=
 =?utf-8?B?eVFlM0xYNDFNNVBOMUFnbHhNWWxiZEJOMFRSYVpEL25uY0F4OVFHZkZVOVk4?=
 =?utf-8?B?UWtJcXQ4bEpia0dDcFpaUmZSVVlheTVydnhxNUZtY2JNVklQQnd3Sys2Rmpu?=
 =?utf-8?B?NkxRbGRWRWpvM1BTVUZnTEpMcmlzVVZ5UUlRT0t6WlBKay81anRZZDZaSUFt?=
 =?utf-8?B?c1ZPbzNGbDNwcjVoSC85U0tyWlo5OGpMUmFpcDRLQmdjTTlwKzJkRVNIQkhO?=
 =?utf-8?B?RDBicktGa1A4WFF3U20rbzRKdlpkZnRkVTlVU0xvSGg0L1dCem8rK3AvYUMv?=
 =?utf-8?B?YnJKUVlLU1IyRHRvTUs5eEJxeTVBR2IrM3U4UUpWSi9pS0dFYjlML2hsZDdV?=
 =?utf-8?Q?wH290FrD6zkw0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB7975.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MUtxbGlkdDBvZjdubXNEZ2JRWXUyYzRLVmJ0RTNhd2Y4UDhyZVlIdUZRVVps?=
 =?utf-8?B?b0J5N1RSdk9Ma1d2L1UxbUl2dkt0aWNkZ1BKaWNTb2VQdGFsUGpUcWVjd1V1?=
 =?utf-8?B?eW4yTFAybGkycWE0YkszWVdodEFSYVBYbUdyOS9mbEZId1lkQUozeHBKSlFp?=
 =?utf-8?B?RHVhMkNVYlZjTXRMSVBELy9BU25BRnY5NitzM2ZqTEN0TG8zSDJxMXI4VlBL?=
 =?utf-8?B?KzFLQ0QycDFIbHR2NDRpQ3ZEVHFFRWdOY3loVHZ6cUlGRnNkb3MyclgrSlE3?=
 =?utf-8?B?K3NMTkN6eFArQWRGWTgyUzg3MzN6ZGRYYnJaY29lak5kZW5tZ3VCRCtYNTVU?=
 =?utf-8?B?TjRoN0JCN2IyRVVjNU9xYWM2OG90Y29veWdwSHE1UUZFMzU3cEpxMVdsQXA1?=
 =?utf-8?B?MkNJZ1R0UzJSRlZwREF2TnB5eWhyeEF3S1l4R0xtcG5zZ0NUSmswN1dBNXlC?=
 =?utf-8?B?QVQ2bGRUcXQ0ZGU0SGRGQVVVbkhIZmJFVkNQUVlJNy9QdDhxeHVZay9RN3FL?=
 =?utf-8?B?ZHpSZUxGOUEwOEpiY2Q0ZEhxVDVIN2VQaXhDYnBiVElIRkpsaE9VaThLbXo3?=
 =?utf-8?B?U2pIQWdjWStjQjVCYktjNWtsR1owVS9MRVMwSkZmMENYb2ZYamk2YzNMVEtI?=
 =?utf-8?B?QlU0d3ZlNFdmWjdLR2c0YVBuaFlyQmwreWN2MEhTYUYvUlhQamkwamNiaEtp?=
 =?utf-8?B?SjhaZnRSZ05xUVZqU01QR3hWaS9mR3RGT2JZaVpydG1OenRJQ0o1dkFVckhV?=
 =?utf-8?B?dXhEaG5mZE54b081NXRDVkUveGtZR21Uc2pnQ2svWnhhWDhod2ZIUENaMzNa?=
 =?utf-8?B?T1ZyckNXSTJrNURCUitwVUxFRTBXTFJvQkxqdUM3c2RXNXM4ZHFTcmhmNWg2?=
 =?utf-8?B?MmVId1VJa3U4TmMyQ0xDQml1cGRjN0hGMmNNcmNNbkt5ZVZiSTNoc1l5L2RZ?=
 =?utf-8?B?M3Zmd0dFakhMbnkzSWQ0dnE0dGd6TE1pZzZuME91blFXVFpCakloV2ZSU0d5?=
 =?utf-8?B?VUlKN3JRWmYxRU5yVlVOdTMwcUM4bEJCMUUxaExLaEdkODkyVVZ4WWJOWm5j?=
 =?utf-8?B?YjBrbG9oQ0RLVVVTWHZrUG1jZVRNaTVMVndMM0piY3M4L0J1VG5VWFRKWjFR?=
 =?utf-8?B?Z2wzeEdieTJpaEFtdFlIYXZhRlE4dUJld2NsWXJvdjFsc2VRc0xMSkM3MEhs?=
 =?utf-8?B?VkFQSHRpQmNOUGQvNTcvM2VmaW1wOXBtTElCc1ZlVEwzM2RsL1B4WUlqaGFO?=
 =?utf-8?B?b0M0RFRvMTcyUDRmYjM2U2w4WlBhU3VOVXBJSklzMVBZeGdzaWxGdnF1a1ZG?=
 =?utf-8?B?Kzc4dzZnK1NCckE0SVViVno2dXBpUklsdWR0Vmx0cG1VUG9HNlVsVVo5UFJM?=
 =?utf-8?B?c0plZndMSlQyd055QWJpMU5weXNwUGJ0Qlh2MGY0RVBDaExDeGovK0xpNGsw?=
 =?utf-8?B?QXcxY1dMZG1mVmszeUt2NllnRlgwdnFuTGtKVDlIV0tnV0JvcTI5V1JxSmwx?=
 =?utf-8?B?Ukc4VHU3NWxRZ3Y1QXoxd01TazdzUWd4aUlnRlNQYzhTZmozcXpSMFA3cHZ5?=
 =?utf-8?B?ZGJ1amlGbGZVOUtKYW0zcDRGL2FSVGVBS01QVVVtaUx2dUVRYVNXYXJrT0ow?=
 =?utf-8?B?TjExelBwYy9hdDMwQXplYnVLTjZjQkhoajEyb3dzSlhqcGw5MlowNkZDWDNR?=
 =?utf-8?B?d0w3ZERBQWdwQXlVUVhuS0RjUE1WcDdsdW00SFV5SDlKL25YdXJTWjhHamJO?=
 =?utf-8?B?YWg1NjlWaW5YeGhnSnRsc0NIcDAxaElhS3NGWW5ieGMwdFZoU3Mya3ppQmVy?=
 =?utf-8?B?THFLVUVzMkZ1ZXhSMGlaeWIzaUVMSTdtWGZ0K3ZlSWZBWGhlbEIwdlhDV1JO?=
 =?utf-8?B?cVBPV3p2RmFoWWRKRUFocTE4TmJTcEhmOGFxb1haSWFmTDZXTlJiUjdvZ3gw?=
 =?utf-8?B?V2dpVE44M0dNaVptWDE3UXJmbERDWU9UbnBiYkdGM1JDUjNBTnFWbzFIUmFV?=
 =?utf-8?B?bUdlVEhCZ2xFRFBGc2VhWGk2c2NUU3FRbTlzdW5iS2lJZ2hlRkU2WEpQRGxv?=
 =?utf-8?B?SUxPOGppOGxnZVRPNGtWN01RdURkSjVNalZEYVNsV1F2cjE4eGtjSmRyRUZG?=
 =?utf-8?B?dThmNmN4dlhVZ3phSUhoSzJ1c0ZSYU9zeFlOL1F2UVpNQjRyalBiaWUwc204?=
 =?utf-8?Q?UjgY2hp8kKT//43nTyUuP4M=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55b0349e-b22e-4038-457b-08dd5c5655b0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB7975.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 02:26:43.5539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TR3kzcqZ9a/nL/cND6V0KzjtIeFsdbSf6NVNXXY7rp/9uruk6GXpSTvtANJ/8X4bsc9h96FulBn5asQ22+azQ1hLhWosDTfr/kr+aL7XOKiBckmR+Deknp3QJpEDIOGy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR01MB6500


On 2025/3/5 23:47, Steven Rostedt wrote:
> On Wed, 5 Mar 2025 08:53:43 -0500
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
>
>> On 2025-03-04 20:55, Huang Shijie wrote:
>>> When tracepoint_debug is set, we may get the output in kernel log:
>>>        [  380.013843] Probe 0 : 00000000f0d68cda
>>>
>>> It is not readable, so change to print the function symbol.
>>> After this patch, the output may becomes:
>>>        [   54.930567] Probe 0 : perf_trace_sched_wakeup_template
>> What would it print if the address is corrupted ?
>>
>> Perhaps we could do like the backtrace code and print e.g.
>>
>> [<00000000f0d68cda>] perf_trace_sched_wakeup_template+0xNN/0xMM
>>
>> ?
>>
>> I don't care about the actual layout, but removing the address
>> from the formatted output appears to be removing useful data
>> in debug situations.
>>
> Perhaps this can use "%pS" which shows both the function entry and the

okay, I can change it to use "%pS" in next version if we think it is 
good enough:

      [   55.225555] Probe 0 : perf_trace_sched_wakeup_template+0x0/0x20


Thanks

Huang Shijie

