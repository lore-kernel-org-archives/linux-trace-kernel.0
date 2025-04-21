Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11022138.outbound.protection.outlook.com [40.107.200.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC1B22A4D8;
	Mon, 21 Apr 2025 22:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745275231; cv=fail; b=iNeqBzZ8QE67m8jMkxMliuw7zx9tcSyToVKEANgkSYvtqtLaEHCaxxFiVWi6nd+cQRYZc4QZd1lLOvGyyZEMYimq7ZQ3UOZzA3Qhcnbyv1rVF+6gvSVyrPWmH7+Xtw4h6kBuyF8zzo9kkSrIhgkS9S8n7P+tJaKH0DED4hY64kg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745275231; c=relaxed/simple;
	bh=HWK1fnY89DETtxeZlbm16nSgegy8YewPTWseabnz73g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OLOJEJ6c0LgaJel4uNDIo5qAHy1+EnxikuKePAZ5KUc+mIilQTKtnpt7L88qhJEEwibr5Lyt8JT5ovBi7j/ZA1WbpeAh/fETwSkSwi39a54F7VMG5J6Q9ob0Ioaop4MZUrR4eXR/FV+X6KXiKQqONNxEVLI9+MqmtrvX3m7qn9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=GYao2E3S; arc=fail smtp.client-ip=40.107.200.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="GYao2E3S"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mtIGkS4gVqiGOiiuclVkJeyPWC/HdJNdqCIM9j0ir2yO9a/QdNc+OPyU1PwPQWrc2UV35kAJOpRQje/E8VUVckiHfHaGjG0+oN+xaC7n8SQ9hN+NSVeLlleAIy4S7SH5bgulVfu+H5SEjkKu+j5vDsO5A8lyz3bbLcP3wizzTsIeSpfdze0TihE+BpXAAODqmlDSy8dNpnXfuBuMkBDzi30CV4ZDG9QQlbm0LReK75O6wqIBoL/lzJq9O53AbSizlZ3Y6SGrK9tn7gBsLN7guiabuMzr+dkyEc28yPvS8BDzITN54ezvcIZtAUqKjAfZ06MWfBcGpdhBY1jW3L35+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D4cJmyHhSz9neOD9oCna6heOaVLFPKucWYVMe/wgxlU=;
 b=eNA6/W9NdEoyV2IfEwwv93LbovMRbGkPKmOCVmS1yRTMl/IFoEcW3GT8cVdUm/ci65uWofU5rW7By3YuvGgO5fx0n8UKuPfiS8HKQi5okD8ng4Vd9UDN5C7G0oa5EABPFs3iIU3n7X/7WL1GvIuBuVQS3yzBe56ykOHuWvK+0aXADxI0lj/Ga1MQqLfXKWQp1lzDw9nRbXqu7W0UJ93EiWz2xglAry7Md2aVlfcgN9jjNGE5dKDEo0HB3EwPgcluM4z4Mb0v89t05w2t3a/X//KHoDvYysumaZSfcwm+xk2F4YWHkodJpMw61HjfjfgkDoCGxKreu9riL9EZv28rlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D4cJmyHhSz9neOD9oCna6heOaVLFPKucWYVMe/wgxlU=;
 b=GYao2E3SDHnZJRftez7lGbq/wcWbnCOdVRloJbY0+Iw/h9UyUf1g97oE3E1+jpQWUL8CewnDE/hd1KV79lQdZjlbfVNtt82nO91bk6y3hPjpq7XJekRhkuHb8JN+3+rFV1hEodL83loM+NnYW0Oc0nbbN262MJVjXjUsY83EWeo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 MW4PR01MB6226.prod.exchangelabs.com (2603:10b6:303:77::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.34; Mon, 21 Apr 2025 22:40:26 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%4]) with mapi id 15.20.8655.033; Mon, 21 Apr 2025
 22:40:26 +0000
Message-ID: <d987a374-c83b-4067-9d47-62f3b758c8d3@os.amperecomputing.com>
Date: Mon, 21 Apr 2025 15:40:23 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] khugepaged: Refactor
 trace_mm_khugepaged_scan_pmd() to take folio instead of page
To: nifan.cxl@gmail.com, rostedt@goodmis.org, mhiramat@kernel.org,
 willy@infradead.org
Cc: akpm@linux-foundation.org, david@redhat.com, fan.ni@samsung.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-mm@kvack.org, npache@redhat.com, mcgrof@kernel.org,
 a.manzanares@samsung.com, dave@stgolabs.net
References: <20250418183920.273154-1-nifan.cxl@gmail.com>
 <20250418183920.273154-2-nifan.cxl@gmail.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <20250418183920.273154-2-nifan.cxl@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0141.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::26) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|MW4PR01MB6226:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a236172-5f89-4116-7415-08dd8125826d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OTkvNHIrc1pIcW1FSExTSGJaU25JbjZhblRrZHlQQU9nL1hIek1Fcy92QVJD?=
 =?utf-8?B?cmh5YWcrU2xTRDJITnRmZ1lJQW5iVWxLVUhvUFFHN2tmY0YxVHp4RmpiaDYw?=
 =?utf-8?B?b1pWRXBHQnFSQWZLaTJlNmpaSmNLT2dsVzFGcEQyNVJCcDNrUk9rVEsxRUV1?=
 =?utf-8?B?NDUyc3Y3a2JYQjF2bS84L3ZFK0xya0tYMkEzTWFxeUZqbEVaSHpXUFNJaFlS?=
 =?utf-8?B?ZktMakdwcFR1ZE9FUEx1RU9IUXdpTUZMSlFrZ2VIdmZ6U3V0T0lJbjdpNUZs?=
 =?utf-8?B?c1JQRlhGVHhwY290Z2F0K281dUQ3RXlXVGRwdzhqdm43OHN3cFN2djVTV3d0?=
 =?utf-8?B?b0FzZzd2Q1EydmZ5Z0QzZmtXYkgvNlh0bTlUd3orSXVyaXZUTlUwbkw3aGlo?=
 =?utf-8?B?YWZFZ2VQSTFCRlROSkVQL09GY2prQld5ZU9qU29lbjhMMTZZWDU0Y25XK09Q?=
 =?utf-8?B?eDJaMnZld29oRDgzTkE5QkZJSFozcG9hVHJrd1J5VW1ROFdkMnFkMjRDeGZP?=
 =?utf-8?B?eVd2YS9iR0RLcW0zdGhZL1dBL244cktTL25VMUhjRjU3dGFVMU1tc1hUMjRo?=
 =?utf-8?B?U3I2bWI1U3JoNDlwMHpUMUY5eC9RVVhCWGRzSndleXVxM1A3eEdVZ3o5OTkz?=
 =?utf-8?B?cWdmZzgxS2FGTkJaYVFxNzl5djBIaGZSUjc4cERtRjVRaUtMVXdoQ0pVVlh0?=
 =?utf-8?B?NzVxdzBkZDlremkvaFRaTHJmRDBkZkNFNUtIV25OMHlFNlRxRlhJRDhRbFZv?=
 =?utf-8?B?clJhRzZhWWdMeUNFcmdldDQva1BJMTc0SVJmZE9XUk52cmxKK2tSN0RWVURy?=
 =?utf-8?B?UnlrOCtnS21EVWxTcnNQUjBrbWpnQVRTZEhRSnBVd01VWTltZFY3RWJHZ3B4?=
 =?utf-8?B?U3BXYTlYZ3BZNXRyd3JYMFpqTnp0WVROcVlIRWhOQ2JONnBRMkdLTFcvOFFE?=
 =?utf-8?B?LzVreFlBOE5pRU1Kc3h2SHEva3R3VDJJVjJWbXNPcTZrVXJQNlE2VHRGMk5m?=
 =?utf-8?B?Z1lZODMzSDdoOHhFNXlORkcrRC9LdlgzS1FnelRsVTRvcGJjS3VvNTkzTnpF?=
 =?utf-8?B?dWZZWEwyeVgzSi9xY0hnLyswenNWOVhHK3BWSy9CNTZSMGxkdDYvSHlWQ255?=
 =?utf-8?B?djlTYlkzbUxLS1U2R2xrSkFDQmdHcEFsU2ExZHR0aVM2YmEwUGFVVXhzN2tV?=
 =?utf-8?B?WklaUkJ6bE43SmtoSUdOS1gxRWpGdk5WVzloZFNESWtuTFFwUmNaOFJUbzNj?=
 =?utf-8?B?cVRqeGVSK24rK0xla1dpSjFVTnhyR0F1U0Rvd1l2dVdyTmQyZ2p2SXVGVFVq?=
 =?utf-8?B?R04yL2hqcGFGZFNDOVc4cWUrWXV1a3daRzMveFdRTnBhWGc0ZE1TNCtWOTFl?=
 =?utf-8?B?MnZTd0xiL0UzNzB2OURYVWdFenVyTjNqL3JJdWttaTd4WmQ4eis4UlkrMUZu?=
 =?utf-8?B?dlhMSGxnM1JZUTVQSTVadVpNdml2c0pkUGI3SGZYUTdBaVUrME1ZZStlQ1My?=
 =?utf-8?B?VEJYcGhORjV6WTN1TmNnMGU2TU52TE83OEgvZTlPWnE5V3kxVWxQS2tDQnBT?=
 =?utf-8?B?blM3UW1DKzBJUllvZ2VoOXNGR2NtR1hZSTBKaUxCZ2tuRjFZNWxwVXUxR2tW?=
 =?utf-8?B?b2kzazBscFV1SjJXS0F4LzIyMWV0SUJHNnAwT2lCOFF3blM4TjFjYURZaWk5?=
 =?utf-8?B?c2xrNklpOUFxTUNubUlpZmRNR1BqQWJTNTlVQTZrOVZVd3U0SFVwVFUzek8z?=
 =?utf-8?B?TGFRcHF4S0o3ZlNKci9iYVdwNHBBZ2RhUVJYeStLaDJJQXlMNitSRkRSeVhU?=
 =?utf-8?B?em5vbDVhSjA2bXhvTldFSS9EZmlCWmhRVHJidVpJcWVFZEczT0tvWDNlOUtE?=
 =?utf-8?B?eHpuSVQzWVkrWWc0Nms0SHFrTmZ2ZkdVYVJEZmVIYjhmMitCdXpKcThYQVEz?=
 =?utf-8?Q?KxCx7W3Jfjs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bUxnYW01MFpFNDFZVFd1R0cxR3VsY29RNVZiNnEzK05ReVJYMnFtN0FLbDM4?=
 =?utf-8?B?OEY2Z2Z0ZFp1SEFXckw4RDBpbFpjUmxEa2txaUtyQ1hhMGFKeFNiazF4U0Qw?=
 =?utf-8?B?MXd5Z0dwdlN2dnRIMC91Qlh4Tlpzd1ZBVzExR1dvSEd4cUpjdHU4b0xFUzVn?=
 =?utf-8?B?eGZEM1RVV1ArdkZ3K2lrNjNIRytTY0c2YS9nN3VnUnh4NWVhUmFiNVMrUXpw?=
 =?utf-8?B?dFdUM3dQbE5IRUJ0dDc4L0ZmRXJVV05Ld0hMZ01pYXpKcXJYWUdtZlNkWkcz?=
 =?utf-8?B?eG1ONm55N3JoZHpNS1U3RHJHTVMvQXdxY1o1WURobFVQRnZULzA4QnI5Qmlv?=
 =?utf-8?B?Tm1sb2orSVRVRGJ3N0laSGRHUnBId0lBN05uVjFPdjA1U1FBcVo0eDhTVnNL?=
 =?utf-8?B?V08rY3R4UUxyY0xLNGkrVHhvWng3b1Y1ck1GSzlhQmw0RTVlRlR3MTRHTkNk?=
 =?utf-8?B?bkd0UnFDd2VFRFIzWXV6RHBCRWN2QUd0cUg1VGdsc0R3R01jU0tYWlFQUldk?=
 =?utf-8?B?R3RYTjVvK3NtSXhtcDdlaVhwTnR2emlvRjBxd2w3NzFCM2h3dm43Q01LbkVH?=
 =?utf-8?B?dUlpZDFqd21UQzNXci9oWUdRbUcyejhRVlJnRHA4RVBZNVI5QmcyTGZLeFJZ?=
 =?utf-8?B?bEc2NlNaSTVDOWtuRWh5SkZqdXJYbXdXVEVaNmhWYTFKWFVVcXNQc090Y21a?=
 =?utf-8?B?Sm5wVWhEMklFOUNEd1FWRzI3Q2pGWDl5aGFWMU5sREtieTNwaU9rSFlxRVNY?=
 =?utf-8?B?aGpBelcrY09uRC9LUThSdkxBcFF4bHVXczBVeVUxbzFNdldQYkV6clJWd0pJ?=
 =?utf-8?B?VFpEVXNCQ1lSUEtpcHFqZURGUFF1T0pyYzY3R29oVHBqR3BkQkdyRnB3Y2lM?=
 =?utf-8?B?QUIzRzVjNUZ3VFhEZ0MwWlNiZ2MvWHVDTGVzQW83WE54MEljT0FyTTRUVWxC?=
 =?utf-8?B?QjFtMXQ4Zzh4NFdtYjNTMEp0c0ZlV3JLVjNVZVZacU1yYTMxMUg1VHp6RS9T?=
 =?utf-8?B?Q1ZsT1Q5VWFNMVd1YUVHdFZ3RTNUN05EUTIweUV4cm8xTE5adTQxN05Bek1M?=
 =?utf-8?B?Z3dBM1VnZi9UakVjdG81djFlSFMrR203M1gzd0FkNzM2SnVEUGJOS2pZaksv?=
 =?utf-8?B?Um9HV21uZjRieVJENEVvcVpsb2o5dWtuNjBnRDVRSlBsbURVN21sWUcvZ2dZ?=
 =?utf-8?B?TlZmWHErSGN1QmdSVk9tYmx5dzhjZ01mZlgzM0JGQ2t1L3orYWVtU3g4SnJF?=
 =?utf-8?B?SjliOEI5SURIUjVFRDRGaGlab3pPT1lYeExSUlVpRzgxek04THZteGtmMzhT?=
 =?utf-8?B?ZTdDWEJ2c21xTC9XNUhSZXJXTE9WU1g2cDZtWDFJdWI3eWx3SS9mOFF5bTFO?=
 =?utf-8?B?Ym9XWktHNTRiUlVBN2c0eGR0eUR6NG5DUXNxcGliZDROSFNodjVEa0ZKMm5V?=
 =?utf-8?B?QWpFc0VnTDNoUzY3c0lyTnduMSs2NmVLSHFXRjIzQW5SK3A1VEovU0gvYkoy?=
 =?utf-8?B?QW9yTDZoZGlDcTF5ZFpqZFhUSTYzT0FGNkhUeWtDQ1B5SjhTNk1uT1lET0dY?=
 =?utf-8?B?cXo2RTdaT1RXNnlxNVNPSjJjMjVSeld6a3FxTkxwcm9vNFMyeGFTdTg5QVBC?=
 =?utf-8?B?ZFhUTU9kL1g3dVhxd3RMWW9PakN0QUJvaWVxaDF1andwcmJIcjlkU2E3Y0FI?=
 =?utf-8?B?aS9zUHlkdVQvVThoMTNrSWdrMC9wRmhxbmI3eWovbTd5aWFjdUFUdnpJNWNB?=
 =?utf-8?B?dXlzc25pVTRaVXlrQnduVUR2VkUva2NmTVE5bFJmZGt6b2tVS3NSS2phMXdD?=
 =?utf-8?B?SDdOcmdaWG1wUFIwQVhWUmVBRUNIUVR3TEVFcnY0ZEdlRDA0UTFYR1VLQUFS?=
 =?utf-8?B?ek5qeHNKOWlVeS9YQnlWK1NXZ296SVNxK0dXQXhSVVZmRllCbU9QMXpHbVAx?=
 =?utf-8?B?L3EzTnpQNUdnalhjNldJQ0xJdy8vdENjVnJFd2wrWHEyRmZZUkEvTHhLd2Q0?=
 =?utf-8?B?ZEhoU3ZTck0wd2ovUHlTLy9CZXMrbTBNWkhmVDV0SUZIK1grS25iV1RFZjhT?=
 =?utf-8?B?azljMGdRbHh1NkQ3V0huOWd6Z3FFbXE2dVg3bThLdWt0elIvcnVha0xJcVJ5?=
 =?utf-8?B?cVo2YXhNZnNCVm1WYlk2OXdvTm16ZHB1eDhuMkJwMTBPV0pNalJKcTFla3M4?=
 =?utf-8?B?YUE9PQ==?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a236172-5f89-4116-7415-08dd8125826d
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2025 22:40:25.9859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uVuwCRHRKapt+wHpzN0+2o/TT/49WkPeNdh2/6/lPjTD993exkrOdWgnPVwqtHFiRM+LUfVcNkeTCTTA68hfGm1Lqoimr+whDIGJ8tJ4XWY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR01MB6226



On 4/18/25 11:34 AM, nifan.cxl@gmail.com wrote:
> From: Fan Ni <fan.ni@samsung.com>
>
> trace_mm_khugepaged_scan_pmd() is only called in
> hpage_collapse_scan_pmd(), where the head page of a folio is passed in,
> so refactor it to take folio directly.
>
> Signed-off-by: Fan Ni <fan.ni@samsung.com>
> ---
> This is a new patch added to the series.

The change looks good to me. Reviewed-by: Yang Shi 
<yang@os.amperecomputing.com>

But I think the two patches can be squashed into one patch.

> ---
>   include/trace/events/huge_memory.h | 6 +++---
>   mm/khugepaged.c                    | 2 +-
>   2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/include/trace/events/huge_memory.h b/include/trace/events/huge_memory.h
> index a73699f000de..2305df6cb485 100644
> --- a/include/trace/events/huge_memory.h
> +++ b/include/trace/events/huge_memory.h
> @@ -55,10 +55,10 @@ SCAN_STATUS
>   
>   TRACE_EVENT(mm_khugepaged_scan_pmd,
>   
> -	TP_PROTO(struct mm_struct *mm, struct page *page, bool writable,
> +	TP_PROTO(struct mm_struct *mm, struct folio *folio, bool writable,
>   		 int referenced, int none_or_zero, int status, int unmapped),
>   
> -	TP_ARGS(mm, page, writable, referenced, none_or_zero, status, unmapped),
> +	TP_ARGS(mm, folio, writable, referenced, none_or_zero, status, unmapped),
>   
>   	TP_STRUCT__entry(
>   		__field(struct mm_struct *, mm)
> @@ -72,7 +72,7 @@ TRACE_EVENT(mm_khugepaged_scan_pmd,
>   
>   	TP_fast_assign(
>   		__entry->mm = mm;
> -		__entry->pfn = page ? page_to_pfn(page) : -1;
> +		__entry->pfn = folio ? folio_pfn(folio) : -1;
>   		__entry->writable = writable;
>   		__entry->referenced = referenced;
>   		__entry->none_or_zero = none_or_zero;
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 950d147cd95e..bf5583dca1cb 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1435,7 +1435,7 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
>   		*mmap_locked = false;
>   	}
>   out:
> -	trace_mm_khugepaged_scan_pmd(mm, &folio->page, writable, referenced,
> +	trace_mm_khugepaged_scan_pmd(mm, folio, writable, referenced,
>   				     none_or_zero, result, unmapped);
>   	return result;
>   }

