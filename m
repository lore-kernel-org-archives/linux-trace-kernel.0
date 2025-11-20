Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010055.outbound.protection.outlook.com [52.101.46.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451631E0083;
	Thu, 20 Nov 2025 08:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763626688; cv=fail; b=UOLEJQtK2p7GA3swDB5Wtyx/2ZFYSJSNGCKhKYk7xfiSaGMoYnFUJ6lYbqNbsXWw24HNyz2/ljB95BprGeaV8rkI4lTw57KHqRf1Y7ahvvzXFzyUkMhTaNEi8yRfcIBV3fgikSn6fVxx5t2O91Wl15rQnOmk1st5tz7P+2rGfh0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763626688; c=relaxed/simple;
	bh=trjmuF8N6uO9Bx3e+4YHjSycLZUAfE+kcPw3cSE+bFo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CQugcTktZcG7ocEFEDsaY9Qt5uqejmAJqyvJUYbVGgeYlplhsULJPLDSYUyM5rJcTfceRtblGLTVhCSoig0InPuW4Ujtdi0vLUsGg+cpR/KSFUTpPkU16xTs9p0Pt10LRyhu2r6MWhB5ELBO1ytHVgFO3ugSGh6PrwrIoh7uIQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=asCsqtgw; arc=fail smtp.client-ip=52.101.46.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="asCsqtgw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HtgkM68YPuOEZ6McVpQC0kS8gI3d3m90gxqOm8gcQ5VEZbRaAsrexi5t0rI8amt5SwHTklrwJCQp6smDRSISVSC3Zu+k+IwcciNXeiQIX6E9ktp1w9ul++jNhXdS5k8bWfBRLwezhNZsySzztvMkTpNEPS5ou+Trb3IuMbTomN5V5BMnVEF9yhs7ik3AunLgF3/Hl9Kf3FMCdHVi9ymXTnybe+ihBF0//FsEnlUk/6/nDyUpOsZ7esgsatTVSYYm7c3KRF0rkZeuVAkHjvXOXTpxhZyFeG+4gVOC8GygDcWj5CX+wRP0zY8Lnq2MmeuL0Abq87H19lQyyH8c1Uru5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1xCNONfFZHZpBZDqEZCiaQajDnbALFKwagXC5pW44o8=;
 b=xvTTxToJp21LghYjBBIFm2+Jz2k7jbvCRLqtt4iCJF8k1pQ4FGbYJGD5MxLkclDAwdkh8x0I0c2HxLCw1Y4PMTUvWP7XKRT/ldE6maC0VSpnx00LEvov/A4Uw/ag3sxpI/9ZnMAwb+crJqDiK8B7s7qNOIPKfQoWNyRTXRJ4SbaxvNdK3IFcGxQWlxSQLxLq6FhlQ49GuLu+TbhyfEak91QiAvHNlhIdBiQF4i/xy+peLIEDcj/OMgo2nR3nQj6x1Kr3d1uU9VxlQLqoA+Vq56i8A4YiNW88gaBqm1mABePnNew4YHnmKzvUhlq18kLtyToRcRXFmLFkWl6+3I7w7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1xCNONfFZHZpBZDqEZCiaQajDnbALFKwagXC5pW44o8=;
 b=asCsqtgw2RdRjku/y2S/U+9uHq88H4OjLghOzraZ4t7/pZdLHENF2LdzIUCyd3pTAbNaf3cVkXq3ZC6djPDjozoeC3Hr2ramO62tWnuo82w7wIA1LW17WWEXzE8XDxYyIw60OyPUhb1g+52vBpTm0Hoc2rZgOc3cB+sDNx4Yx44=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB7458.namprd12.prod.outlook.com (2603:10b6:a03:48d::13)
 by DS7PR12MB9041.namprd12.prod.outlook.com (2603:10b6:8:ea::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 08:17:59 +0000
Received: from SJ0PR12MB7458.namprd12.prod.outlook.com
 ([fe80::83e7:e6cf:26ed:2f3d]) by SJ0PR12MB7458.namprd12.prod.outlook.com
 ([fe80::83e7:e6cf:26ed:2f3d%6]) with mapi id 15.20.9343.009; Thu, 20 Nov 2025
 08:17:59 +0000
Message-ID: <33476cb4-318b-49db-9cc1-a354eca9e883@amd.com>
Date: Thu, 20 Nov 2025 13:47:51 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 2/2] mm/khugepaged: map dirty/writeback pages failures
 to EAGAIN
To: Dev Jain <dev.jain@arm.com>, Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Nico Pache
 <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Zach O'Keefe <zokeefe@google.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20251120065043.41738-6-shivankg@amd.com>
 <20251120065043.41738-10-shivankg@amd.com>
 <6c1d6b80-d290-4110-9a49-53e7404136bc@arm.com>
Content-Language: en-US
From: "Garg, Shivank" <shivankg@amd.com>
In-Reply-To: <6c1d6b80-d290-4110-9a49-53e7404136bc@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0048.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:81::19) To SJ0PR12MB7458.namprd12.prod.outlook.com
 (2603:10b6:a03:48d::13)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB7458:EE_|DS7PR12MB9041:EE_
X-MS-Office365-Filtering-Correlation-Id: 746c2c86-161a-4984-08d6-08de280d50cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?akRVUW1mRlN0a3FVUHE3VGtyeE53MGlDY1hYSGVuc2JMekltSHNGblhYMFVW?=
 =?utf-8?B?RVZpSU1Ya1hTeDBXdEV6eStYTnpDUXQyVDBhemNIbnNURWN2OVFuRzVOWDBS?=
 =?utf-8?B?VFJ4MUozU0dHM3l3a0Fad0crTG5wSklTZGhPQXZYN244SEp6US85UCtJa3lr?=
 =?utf-8?B?cTlTK3BKMVd5cmM4Mkhlc1ZwemN0T3dSbHVkektzM2NMUFhQa0k3Umxra2lF?=
 =?utf-8?B?RmFtaTR3VFBtTDlLNGV5SEFVaTMwNG8wbVN6ZnBQZjEwdDVJemZ0US8yRyth?=
 =?utf-8?B?TDVnaXJ2RzZObG9ZcERnODhGWHFSaW5aak5NZit3QlQwdWc4QU9zWDNGSmlL?=
 =?utf-8?B?Y3JZZEJEbFUyR1ZWNkp4djlUT0ZodEhpd2lMM1diU1hWRisxMVQwQzZSN3ZZ?=
 =?utf-8?B?TzBrUTQ2Vk1TRmhLWnpYak40VVRKc09KWmFQcUJGV0hJZUxaR2t0L0FWZmxK?=
 =?utf-8?B?bDdFbk1vVXJsb0hlWW9WbmNrSU54SmRkdnUrZDlOMUg4amJjR3VNS0cydUx2?=
 =?utf-8?B?Y0xkVWJRSTFyWG5sTkl3N1VRWjFweGg3bXpQcldHTkkxWmh1NkI1a1hoM05P?=
 =?utf-8?B?SDYzV0FIZ2FmS2FoYmY2S1hLNXFrbm8xcEJYakowSFh4QnhhazJMY3crR3F0?=
 =?utf-8?B?SjdwQ3BQbkoxQzdtZWNoWFc5VzlOa3E5SDJTTHc2SGl5dEhCUjhneDZhL1Nh?=
 =?utf-8?B?VC9wRjdaQU0xTk1VenVVTm1XSldPN2czTmc1WHdFVXFMcWlPaXNiYzR1eklX?=
 =?utf-8?B?UjZRVk1laFhzMzMwMDhkK2pkWkh5SUNaSmtod3Q0djErbzcwVUVjUUk1UmNQ?=
 =?utf-8?B?bU5MSFl5T3NUbk5zeitIZlRIaVg1NUk1Ty9iUVJSOVFhTmp3NWhybHZoY0k5?=
 =?utf-8?B?bk5rcFdLeFRjSkFFMnBSV2tKVG0vV0Y1LzZ0bUJGbEs5azJBejhlcG9icHZm?=
 =?utf-8?B?VmZ5Ly9kVnI4WFNOK01qK1JqV3NBekRFNHd6MTFPTC9FRkFIQjN6dS8yVEp5?=
 =?utf-8?B?dG4vSFI5R0prOFhyeDVya016MnhMQVJobzNTRFIxQVpONUVSOWJySWgxeGJM?=
 =?utf-8?B?Y1VJM3BsMW5QbDEzWmxuNzVvMjFMTXphVDFQSHA4cmQvUzBML2NmclNhQlNZ?=
 =?utf-8?B?dUU1dlR0OWdZMG8rQm0yaS90UGxDOFRsYkhyNnBFQ3hzUlh6VXhPalpRY3Zo?=
 =?utf-8?B?K1ZzVWdTN3FJRkkxb3VhdncrZWRiM0UwRTRQdkJKV2ZZV2xBQm9oaGhaeS9r?=
 =?utf-8?B?d3l5OTZ1cDhUbUVyd1BNbnI2N2IvY0RFekttSFppdmNXNWw4VlVud2JKVzht?=
 =?utf-8?B?YXdMMHhiOVlFZTNtRzRvWE9wQy9EalpUZVRYVEZUR0c2S2hZeUJja2thYm5y?=
 =?utf-8?B?Z0pGZk1oY1N1UzU1dFgwbFAzOVRaS0ZDeDd0T0ZsNjJqU2VRaW54aG41TEZZ?=
 =?utf-8?B?VzZwZzNHdlRZd0h4SVNqbi9neG9VMXl6ZlRBekgyVWNRUnZuNjlDZE41SWpX?=
 =?utf-8?B?Q1lncy90VnVIUmRBaDdQVzJqR0VUSWFvNmpRN1c3VFlLZHZ4YXJ4Q0x4NlBp?=
 =?utf-8?B?My9DTzRZbS9zSGZseVNlRndtSG1zWUU2Wm95Ni9RZFExNzdxSkk3VUZOTTZS?=
 =?utf-8?B?bEQwS0RmblNobERlUHpxZnFQQlpRR3NUN1drZDBuV0loMnc4R2ZRSmRWbDBE?=
 =?utf-8?B?NWJUV25DbmhnMTRhYzRMRzcwcFBkMHNISGw3ejE4VFlkVU1JaSsyNVRudkQ0?=
 =?utf-8?B?bmQ4WFZIUFJYQ0FQcmtnQW5GbDVTcFM1d0h5MndTajJDbmpINHRlVDV1ZG42?=
 =?utf-8?B?NUt3dXlFL0ZYV25wNERBNjhpUkJWTWI1aEJ6bTBxMEM0WE91dm0rL0ZKVDVX?=
 =?utf-8?B?RmJNR1dXTnhtWGJ6cHFCY0k4VSt2bFVnQ1c5K0tKQTRrdE5jRlpNZ2ZlK1FG?=
 =?utf-8?B?MHArTUh0ZkpvSUIrdXVWYzRPSit3QzBVNUZYQktLYXQwMlFTc3I5RnJYMTRY?=
 =?utf-8?B?U3l6MElVRlR3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB7458.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(13003099007)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b0c2TVRjNzVrc3F6SlNTMEQyRHd2K0EyWk1nSGI4bmJVdFEvUDBMZzVFNHpn?=
 =?utf-8?B?cUJJZmQwcitUdkZ4UnJVb0NhZHkwVFZHTXFnY29ObkdkUncrbFpYNVdra3VR?=
 =?utf-8?B?ZEVSNjNNU0tWV29Bb2swaE1Qa2hXQ1dVUDdRbitSbklMMmJtSTgxUzF1ZnBR?=
 =?utf-8?B?Q1NBQVhkWHNFcEJIWWZ1QVpqeE9jUnJucmhGUzVENTEraFpiQ3p5emgwQ3Rl?=
 =?utf-8?B?R25sNExhQXBkdmVqMXVycU9RUmpxMXdTTHdFUHVBZUVKNTZxUzlqOXFjQUUz?=
 =?utf-8?B?aGdudFd6b2pRZEUrc0xCN0ZzOFpNSWduaHJLVXlnN21DUGFqblFZZGhEOFN0?=
 =?utf-8?B?Rm8zOXN3MTkrOVZsR0FDUzhFTnFBMHdJUk0rV1FidEhZSFVEL0krazdDcmEw?=
 =?utf-8?B?VnlSdExPL3FPUXZWMlN4YlRVeHhDckZwcjRFWmg1U0lhWUJTdW9ScTJ4cDVh?=
 =?utf-8?B?bm1yOE9mc2hiaFJCLzd5YUNDN3B5WmwweXNWN2hXcUc4RWh6empWZStXcGx5?=
 =?utf-8?B?a0pkUkpjWE1TWFltU1pma01maVB4YzdMRDhpRlBmN2ROMm5UUzB3VmIzTGhG?=
 =?utf-8?B?U1JBUUt4a2FxS0NLdVFzQkVERDd6QkRvMldDVDdTNk5hZnJtK3J5TFpMRW5q?=
 =?utf-8?B?WmE1N29BYmFubFI1NWNHaE85bTR1Q2dUVmVKcExyVk04ditTVE9iN0lxNkRz?=
 =?utf-8?B?YkljWFZCM2RFc2VZM0VGOEY0VXpoSHpmU1hXdTZmeDlQb1dXamhXTnRpRlIw?=
 =?utf-8?B?aFU4b29DYzdqZkFCY2dMSURXNjJSV2FMVDgxWUVlQWo3SmJ6S3hSazQyQkZm?=
 =?utf-8?B?MU5kbk9yVUdYRlI2NC9XdnFqK2dsY1ptUTlMQjZFM093V1JpTUwrQWtZcGhC?=
 =?utf-8?B?YTlsY0JjTEVYYzlNbWh4eDQvWW1obGI1UFNqTFg2Q2ZQbkpRWDYzQ3krZHBz?=
 =?utf-8?B?bzQrdGpIaGFJQVZCQjBZekJXMXdESnlIUEpLWGJyVnV3U0pKYzg4eW5mOTJt?=
 =?utf-8?B?dXMwWFhySWVRWkJZOFRJNTVOa3VoQmFuVHBLQTVZM3RXNnRRc3pYZ0xKWlh3?=
 =?utf-8?B?bnc0eVJsSHlhOXJGNkJITkZCQ0lZU2JzTFVrRjhPSjlORjdLZGlBNVVhYnpT?=
 =?utf-8?B?QzFkL0F0Z3JNTWZqY2tOdzc1THJrUmZaWndnOE5GcksraTFBVDNYMkUrZUtM?=
 =?utf-8?B?MWU1eEVSK2FlVDErbmRNY3pHbG1FalV4QWVsUTlWZ0hoSzF2YnZRcGcycENC?=
 =?utf-8?B?Q2hVREI1WGhVakRVdHNGMlk5aW9DSUt1VFQycjRuQzkvSzloQ0QyK2lMeTNj?=
 =?utf-8?B?ZjFreW5abHdLTnJpNUI4ek9SNXJlSlJiNGt0M1l6WEx3RWRVYTZWMmFrMW9T?=
 =?utf-8?B?aE5XclZMSEVlaWgwTS8ySDRNVjBrUUhrUklPbU42bExmSjBiS2QwQk1NRkRi?=
 =?utf-8?B?cnpOdDVDRUZSbmtSU2p5UzQ2Q1c1RUUvbXMwWWt5UHBqb0o3Q0ZjU2xOK0Zr?=
 =?utf-8?B?MWdGRTJ3NjZCTXNjKzFHVWJ4WnhPSWtzekVBOElEUExOL3dNWU5LN295azVC?=
 =?utf-8?B?RnJwVmFpOUJMSFR5a2luL0ZHQTFGYTBPc25kb2U1b1liSVVmUSthaVBLNUhv?=
 =?utf-8?B?b21IQkdFU1lGZXBkRUhaRXBXdUJISHBrWjJFRDNLYTFqTHhZQ0RSbGgvMlEr?=
 =?utf-8?B?LzJDZU96bC9sUjBSQVhhV2FHWFNFalovSHI5eUowUXJmK3ZxUjRsWVkyMUlT?=
 =?utf-8?B?YjZ3VDI4MElnTTNkZ0dCemsvenRscmMzUk1lMVc2Q3ZpdmtEY29MWG5Gd29s?=
 =?utf-8?B?N2Q3MlQyeWtMNzFxZWtUc3dpdmJTN2dTY0FHaXdKeTQyTDVKUVVBbEpMZk1u?=
 =?utf-8?B?Qnh3OWNLZFRaMUQrSHZVRzkxNFRPVldicFp2bnp5bnY4d25NTzF4WWc5VFFH?=
 =?utf-8?B?c0hkMmNoeklaS3Y4MXArMmJVT0JRZEhmYWxZOEZ1QTJIcWVvdm5PWDdDcitN?=
 =?utf-8?B?aVhOdWVteUlMUXBleVc3cUdaS0ZYbU1SaC9Zck45R1ZjSStNVWwrWW10WCtk?=
 =?utf-8?B?c1hUNWhoNkw3bFBIS25kdk1HS013bzI2Zi9EckQ5ZitPSlVTUXFIb04ydmRZ?=
 =?utf-8?Q?NYv8WA+qRsPLobfYZ7TJNBhzR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 746c2c86-161a-4984-08d6-08de280d50cf
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB7458.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 08:17:59.1987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yBNo71idlhwpSEYfb20ksiSzdtxRzrjmtNa4GeUd5mxBC+zkcBCxLIg97/UHH/vS2kOr3oyKTQ9e7ha9W0ZPyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9041



On 11/20/2025 1:33 PM, Dev Jain wrote:
> 
> On 20/11/25 12:20 pm, Shivank Garg wrote:

> SCAN_PAGE_NOT_CLEAN is confusing - NOT_CLEAN literally means dirty, so why not SCAN_PAGE_DIRTY?
> Or SCAN_PAGE_DIRTY_OR_UNDER_WRITEBACK? Since folio_test_writeback() is true as a result of
> the folio being dirty, maybe just SCAN_PAGE_DIRTY can do.
> 
> Reviewed-by: Dev Jain <dev.jain@arm.com>
> 
Thanks for the review.

I chose not to use SCAN_PAGE_DIRTY because dirty and writeback have different meanings[1]:

    Dirty: Memory that is waiting to be written back to disk
Writeback: Memory that is actively being written back to disk

[1] https://www.kernel.org/doc/Documentation/filesystems/proc.txt

IIUC, a page under writeback is no longer dirty, so using SCAN_PAGE_DIRTY would be misleading
for pages in the writeback state.

I considered SCAN_PAGE_DIRTY_OR_WRITEBACK initially but felt it was too long.

SCAN_PAGE_NOT_CLEAN covers both states that indicate the page is not in a clean/stable
state suitable for collapse.

[1] https://www.kernel.org/doc/Documentation/filesystems/proc.txt

Thanks,
Shivank
