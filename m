Received: from mx0b-007b0c01.pphosted.com (mx0b-007b0c01.pphosted.com [205.220.177.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFED199947;
	Tue, 15 Apr 2025 01:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744679971; cv=fail; b=jCim4hnNfDKJaUYsC1ZPmgulg+ycmcnsyzrEc3qozFRtlenmntc6jF6aE9D9JCMjOXXGW6ZvJ9U9n6rxwWdEiIcl6riXCK1cfDB2G2tRSRqBlt/dA49O5nkFJ0jZTYqw52jQuQHA/9af+zbHVXvGK2bZ9MTr6NiPw0zbY5oNCE8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744679971; c=relaxed/simple;
	bh=v0htc9iXuOjwf/xeepH3vLtqGKOi6g56Cz6xBERX6xE=;
	h=Message-ID:Date:From:Subject:To:Cc:Content-Type:MIME-Version; b=hFDNktcxGuPc2PAXw/ZzNqOazikQ30FEYkGFkvrvt2mY6MRS7T0rlxed2uZomzRMqefT1ivSSPwmTWfPC9z6czkFtlC6678tiYk9OGjfYRSQasx5zgKLysuCAEx4yPe87nmtvAoICTH5/fbfHB05my+XX31djqHvXC4Q0mK6lTA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.wisc.edu; spf=pass smtp.mailfrom=cs.wisc.edu; dkim=pass (2048-bit key) header.d=cs.wisc.edu header.i=@cs.wisc.edu header.b=jIZFoJbu; arc=fail smtp.client-ip=205.220.177.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.wisc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.wisc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.wisc.edu header.i=@cs.wisc.edu header.b="jIZFoJbu"
Received: from pps.filterd (m0316047.ppops.net [127.0.0.1])
	by mx0b-007b0c01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53EIU1oZ017454;
	Mon, 14 Apr 2025 20:19:03 -0500
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazlp17010007.outbound.protection.outlook.com [40.93.20.7])
	by mx0b-007b0c01.pphosted.com (PPS) with ESMTPS id 46080vurr8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Apr 2025 20:19:02 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=liyj877kNKUF0VKRN8ixw8myGTBkZQ+zlSazWexUVqjhQOUOYcwe7PGizDDq+IcLZp1+oVV1Di+GfbWoPppdqFU/YOkpEAKcU3wasZ30AzU6bZMym7WGe5L8D8d/JkWIa6xPgAFQUsnyuAOb/FkkxmYx1icMWTrwY2OfzY9xjLqTBvMN/rnyDatI0t73aiAAsPL00oYxTq2Pp1blRfNKcVpFB8RC46mmPbuB8AVAbyhLxG9ofGN78f9vO0yv+ZJIHoYLquJxaDQalCMIHfwLb63ABMxXbSiRXLGTl5yPD9mHSpfL66tNHFrXtjlNxBkbCeDVQMEqEjsYBjd6zCSQiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qf3hZUhyjyqM8cCQGmdHIB72qrl2QRtTAG1MGGEMg9o=;
 b=cM0+Ag2rfimI1nWHZYpvNbLE76Bmvljr7iwGkIAUouscRQe26W3j6s84/wDhxrqBPYiKBk9WumnsjeBR5AKOyWLF0GUOy4Q0Mdnoh7kY1Vr9KtIcR2qHV3xBZ4u2xhy1IU3qKOsdurKOd1987DWkl1ubqsZlJgfR5IAJjNA81vmpHZcBiM7Hi9x5jFszqmfslbVlDU/6fAFpGveagyyAr3kZ/z4xjLP62l4L4zm+lYwdvClLfXRnJ/5crsCB1j8eiEqweQyOdraoOfz4WW2OR4cNB67h03EgXVgx9wRcL7hVPZ2ILJrvNVJ9sjLsZVZGP9WgQIpeqCPhflCqW7oYVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cs.wisc.edu; dmarc=pass action=none header.from=cs.wisc.edu;
 dkim=pass header.d=cs.wisc.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cs.wisc.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qf3hZUhyjyqM8cCQGmdHIB72qrl2QRtTAG1MGGEMg9o=;
 b=jIZFoJbuIGY+GbHWZfoAzrj62oicdqckFlFI/JWHyVsgtjuEFlr3RgkRbaaoNisq+6/NSoS781FKAJF8rJjA+KNNDPIw14nLybJf0RbIWi+LzgSKv5dKS2ZMHhyuo8l+vAQn9XaPIpHsUbCMaaODbIRCHS2YBmvuCJemTIT50R9d9rRCDwhvvBblvwQLMuiYJmSyNSXZpR8r8Y6IQ3S2a5lIQB7Z+oZvlSTYytDcdnIrRo1la0w2CnWcsu0fggcI906B++N/uV4ZXcr7FgWE3pvqkbqpemc1KxlNefbDHzQprv1lz5MbB1/LBHXnsvbZUnxX89HVz+38cnM03XnWUQ==
Received: from DS7PR06MB6808.namprd06.prod.outlook.com (2603:10b6:5:2d2::10)
 by CH2PR06MB6454.namprd06.prod.outlook.com (2603:10b6:610:81::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Tue, 15 Apr
 2025 01:18:59 +0000
Received: from DS7PR06MB6808.namprd06.prod.outlook.com
 ([fe80::76b2:e1c8:9a15:7a1c]) by DS7PR06MB6808.namprd06.prod.outlook.com
 ([fe80::76b2:e1c8:9a15:7a1c%5]) with mapi id 15.20.8632.030; Tue, 15 Apr 2025
 01:18:57 +0000
Message-ID: <6cd4879b-5cb8-4f1e-b662-d9470a95a46c@cs.wisc.edu>
Date: Mon, 14 Apr 2025 20:18:55 -0500
User-Agent: Mozilla Thunderbird
From: Junxuan Liao <ljx@cs.wisc.edu>
Subject: [PATCH v2] x86/tracing: introduce enter/exit tracepoint pairs for
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
X-ClientProxiedBy: BL1PR13CA0363.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::8) To DS7PR06MB6808.namprd06.prod.outlook.com
 (2603:10b6:5:2d2::10)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR06MB6808:EE_|CH2PR06MB6454:EE_
X-MS-Office365-Filtering-Correlation-Id: fee95bf7-7666-4922-43f5-08dd7bbb7e5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|41320700013|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L09mMkZGM3FaWFpxS2tsTm0rMjhWbE1rdEhLQS9jdEZGRW85cmx2RUIxTTQ1?=
 =?utf-8?B?MFZabWtDeUVqdlg0Z2VldkxXM1owUndEem5UNVh2Mk5HczQ2TUN3VjdqcG1l?=
 =?utf-8?B?Z1UrOXZIYVRGNkdYM2RuS3Q5bmFsS3Y1QXN1TUVPSGp0N1lJVUd2Zm9vSkQ1?=
 =?utf-8?B?czVwaVVIQnpzOTNKNWhyR0pFY04yZzhCS0FOS1Y2enFUWGo4elBkN0RwcW9M?=
 =?utf-8?B?OUFHQXYvY3R3SVk3QzgrdTFkVTNzZk1kd0ZCU0k1N0liR2JjQS9OSmtIOWxY?=
 =?utf-8?B?S0llZ0VFS1FVd1BhVEtySldGa1U3dDBqRFVNdUJYbjRrZmw5Y1B3RmZJL1VU?=
 =?utf-8?B?eEgyb0NiMmdrQ29uTi8xRkZPZ1pPL3lVUFQwVTV5eHJoVFJ3RStJa3dYU0RI?=
 =?utf-8?B?TzR5TndWTWFFM3JGOUlIZ25oc01raDl0UmdxZzhRcHY0dWJrT0hLU3NEMnUw?=
 =?utf-8?B?R0NyNCtYalVHVVRVaE5ERXFIUUVVSi8yeWE3d0ZWMWhpajB3SjVDazIydG9q?=
 =?utf-8?B?Mi9zeVphV0syUDJnSllBSVc4R1NHZlBrUnRyOS93VU5ITkVmNHQ1ajdNSjJW?=
 =?utf-8?B?T1k5d2ZaTnQzVDJod2JSSFRGQThXZmp4KzBGMVNncDN6eGV2TTJjaExkUy9B?=
 =?utf-8?B?NiszRzJvckpkbTlBYmYwRDBNZ1IrdURIcFBYRHNDYmdiRTcvQ2NYVGRUMmNQ?=
 =?utf-8?B?M2pWSFZVSnhXYTJsdklQODZyYUJ1T3lzN1lqZ1hrVVl4bDVOZE5icmRxclk4?=
 =?utf-8?B?ais0cDZ4Z25LSU83d3poVXE1Z04xNXVoWTN5T0liMGxHSHVFY0ErVWF4U0Js?=
 =?utf-8?B?QTY4dWIrMWF6R0NNa3lVZEI4ZHY5NE9CTDNvbkt2anRaSmFFYjdhM1JmaDRE?=
 =?utf-8?B?NEpmeWpSaXdUa0RhMGplU3V2aEtZRFdsVDdUTUQxUk9ubEZQcCtBRSs0NFJa?=
 =?utf-8?B?cW11Tkh4V3FpdTFkUytaOVk4TDVJRENpLy9JU2ptSjJyKzdOcXJKdm8ycnNV?=
 =?utf-8?B?WW5zUVJhZDU1RGx0K2ZrZWtDKzhZYXoxTXNGSVc4NEo0QlJHNkJDNVAvcnJO?=
 =?utf-8?B?bXJ6dnhNaElvMHgzb1R4b0UyZysvNXRndElPY3dPUE5Ra2d2WGw2cUxCZnFN?=
 =?utf-8?B?UVh0NXFseXdubG1oU0ZJU1NsYUpCWjlONzR5TUNhcm5NRm1aRUFpeHpDcVEy?=
 =?utf-8?B?OUVWTUtLb1dtZHRIdzN4QndCN3pyejZxVytUSVhEcTNkc3JaT08wSzZBYmRh?=
 =?utf-8?B?cVNWT1crWlVUcW9qTmhOZzFnR2orTXZRY2pMSVF6a1pDa3lVOExvQ2IyZTZG?=
 =?utf-8?B?VGQzUFcrVjZyUW1WQXpaWk9DeHFubFl0dXZuR0NBdEVZdFE2d2xlaVczZUMy?=
 =?utf-8?B?L3NHVUc2bmVoNzU1ei9GclNlVGRFai9oUTUwU2gvVmE2MlY5MExoK1Y2YVpw?=
 =?utf-8?B?anM3a3hyRW9NV2s2bUVUN2dYRlNxVm4zUWFPanZWTWRRd1VkdWJkSEN4R0pU?=
 =?utf-8?B?aEQ5OGg3MnJSMjVRNkx2enZrTnJyY1JQc3AvYzdEVW92NEwwTGpHS3NRNHhR?=
 =?utf-8?B?aFJsOGpmT08xS2tYOWUyZXpadmhrcHA5QUdNNWxoYjV2MHFNSll5SUVyV1Fn?=
 =?utf-8?B?NStnQUlBV2ZkOXl2RndWN2dHTzR0NU9KQ2hlS3VvYkVHekN2Qi9RcnRHNWFI?=
 =?utf-8?B?K1h0TCtNclcxR0x5dlhWLy9hVHEvQmpoSXFsWGJ2QUtBSHpyOEo1a2svTjFI?=
 =?utf-8?B?T3NOcUI3VzVha1M4MEM0T1FvVG5vTzBiWFFHU0p1b2hpUmw4dW5McUxKdElt?=
 =?utf-8?B?NGNPMDhsd1dqWDBUclQrOWlhU2crZ0Y0ZWEzRGhwVGdid1BDOUdVN3Q5bStw?=
 =?utf-8?B?WkdqSVVrTCtXS0xXTnVJeUlGOXZBMDIvY0VXZ01mV2hiWmpUWG1ZQmVQNWw3?=
 =?utf-8?Q?XqZS1XzKFzw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR06MB6808.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(41320700013)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UGFqU0I1VkM3TytCN0pBcjlyanF0NHVUMzE5Rk9BR09XYzFQUEtwWjlFT2JQ?=
 =?utf-8?B?Ym8xTU9BQzdzT3BCZnpHeHNybUhMb2twVzZ4Qjl1d281dFF3NmI3VEc1cHo1?=
 =?utf-8?B?NzhsUjREQ3l1ZG10VGNLemJHUXlsWWxyeVI5TW1KeExPaTFENVk0RVJUMGw2?=
 =?utf-8?B?UjFSQ0RXOUJZenpmSFlTNlkvNDVsQWlMZmRkOG9uV29EbEVGUVVjOVkxcDFU?=
 =?utf-8?B?NmwvNkEzMFYyU2dmY25Hb0ZPT1hTcE9GSWNHTDQ5RzREK1paOUtsNENSWisw?=
 =?utf-8?B?YndhZlA5YldLdmFYSlBaQjFUTmszNDNPZ1RidGhLTlFUVEpJUDlnT3NkbTMz?=
 =?utf-8?B?SWNlRXQ4Uk5XMlFFUVl6a0pFdjNOeXQyamFYczlhcktEZ01KTnNyaVg3eFda?=
 =?utf-8?B?MWt4Y0poNWhNREFEamp1elkwQVd5N05nL3VTSC9Sd09sbWgvTWk4SjdDNU9L?=
 =?utf-8?B?bWcvbWNDYWJPdkN3RHNJenpwd213MTlneDcyL0MycXpzQ2pLNGd3cGtKbnR6?=
 =?utf-8?B?ak9LR0hlQWtWUmU2Sit0RWw2ZDZkd2h5WG4wcndodGRCUGtoRi82bnNGNGt4?=
 =?utf-8?B?UVBCVnBFbkFrQmFPSk9mZGozVWdMVkU0RVV2dnVUbGxVMjF3Ymd6K2NpNDBt?=
 =?utf-8?B?Vi9VQndoOVhyODJtbTg5Tk45cHF1SXF3Q0VyYTlmczZhN0Qyeld3WGxJMHRt?=
 =?utf-8?B?NC81LzZTS3M3MWw0ZmljWVROWUprRVFnN0VaUHhpdWhyeVBtYTRJcU9SNEpU?=
 =?utf-8?B?T0h2ZmxEQUxndEZWaEhaNUczTE1mc0hBc0F3ZSthbmZSNEtSMkt1ZTEvSnRa?=
 =?utf-8?B?ZnFqNElyK3VoR1JSUjB3VDJPRjVQeTM1ODhucXBtb0czaVkwRUh6US9WazYv?=
 =?utf-8?B?R1VvaC9GbFpIczBaNkVVNXJjQ3BlRGlLZHkxTGVFVDB0eUZCd09jckpuZ1Nw?=
 =?utf-8?B?UnBGY0VnZVhxL2tPQVFMMTlBNEo2V3VzYWN1NVNiWU9zV1JtNUl5emV6WVd2?=
 =?utf-8?B?NzJEZEwvVloxdlZDM2h1ZmtyemNRdnV0Q0hhWkM4VVN0R0xXRXQ2dDVKb1p1?=
 =?utf-8?B?bFRxZ3hNRGhETjVkcU5SQ21oaGN1UklxR0NxYml5STA0MjlLQmZmSlo4KzNG?=
 =?utf-8?B?VzQrN3pRVXpwMFlML1JhaVg4QmxmL1BHOXViQ3gxNW9PT2E1RFV6eUNObk44?=
 =?utf-8?B?Vno2VlUyOEN6dk1hTHdrSkJqN2cxbWk4N2RjdDNvc0R1dnZ6WXRwS3pGQjhM?=
 =?utf-8?B?Mi9GS0pzZzZ3K0pkRHk1QzBBZGd6ZVVUeU5QZ1JrcG9JN3RRckFKYlp5ZWRr?=
 =?utf-8?B?aVdGM3d2MEdCN3E0ckRjYXV3c2ZuMXcwL3FsTmM1Q1JGK1RueE5ycklHNkZG?=
 =?utf-8?B?blM3THpkNi9QZlNTOXlrVTZlRnRsUlVLcUFCTDUvOWNQOGN4MDlQdjdFL3M0?=
 =?utf-8?B?YTZjaVh2TThxdWh4THlVYmpvSzVueUhoaXBkZGNoeDlvdzVQNmplazBxaktp?=
 =?utf-8?B?MmMydURjdmRwSkpOS3JNR2IzT09YVFRwQm9LQ0wybWtYZ0J3akFpQ2cyRUJh?=
 =?utf-8?B?K21NYkNHY0hmWTBac0hNclhBRXFWdWw0NVUzNWhCazQyTE1YeGZySzdxRkhB?=
 =?utf-8?B?ZFFrSk5VSzVOTTZBR1NKZTRLOTA5WHl0MVFPb3B6MEtpWGhPeGxDSGZ3SVIr?=
 =?utf-8?B?VU1PTGlNNmlIZjVpSzFNOU5GbEgzbEdYdDltYVd0bWxwZEloVHRuSTFTN1E3?=
 =?utf-8?B?Yzh0dllBOE1TYU1OVlVIYWNHenZHcUpCRXdXK3Q0MVlLb1I2ei9pakpYNmZt?=
 =?utf-8?B?NUpDWlROVlF1Rk9uak5wL21LMTU3NE5MaDcwNHFpc051NVJOWEpFUTkwTEpK?=
 =?utf-8?B?WFo5M3hIMFlwUTYvb2pESEZXZjAwQmd1TDRmUDlGTXNndmlwR3l6VnAzckNM?=
 =?utf-8?B?ampJTzFncFdKQ3lLeUQzZW1yeFZOajh0dGxiME5vU1UvckhqNVp6cmhaSkhz?=
 =?utf-8?B?V2lsVWpzeUVDWlhwejlPem9CSFlrTTBWU293YU96REVJSFlrRTh4NDJ3UXpl?=
 =?utf-8?B?NndzaVV2N09yTUUvMG1GUFhLNHNkb2EyZTQzTm5pd2FVdDFmUEJxYitkVDRw?=
 =?utf-8?Q?HchQ=3D?=
X-OriginatorOrg: cs.wisc.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: fee95bf7-7666-4922-43f5-08dd7bbb7e5c
X-MS-Exchange-CrossTenant-AuthSource: DS7PR06MB6808.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 01:18:56.8887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2ca68321-0eda-4908-88b2-424a8cb4b0f9
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0hqBXE32NoLH59n+BEc2V+bgP7dfBua49rrqqXGUhUlEnmq+4mhKbaRLqmZQDgdJ6XyFa2wUppBufAyxSMEXSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR06MB6454
X-Authority-Analysis: v=2.4 cv=TozmhCXh c=1 sm=1 tr=0 ts=67fdb406 cx=c_pps a=2D6/CIrCIWs5X5ruZf5FWQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=XR8D0OoHHMoA:10 a=3-xYBkHg-QkA:10 a=VwQbUJbxAAAA:8 a=x30EXVXcAAAA:8 a=LuFYPtAr6PD7joxTrIIA:9 a=QEXdDO2ut3YA:10 a=yI8jHdU-MAB4nH2QTHtW:22
X-Proofpoint-GUID: jRPyeeLZ79g6m-f4FIPmvIHbbA_mLCgB
X-Proofpoint-ORIG-GUID: jRPyeeLZ79g6m-f4FIPmvIHbbA_mLCgB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-14_08,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 clxscore=1015 mlxlogscore=917 adultscore=0 mlxscore=0
 suspectscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504150004

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

 arch/x86/include/asm/trace/common.h      | 12 ------------
 arch/x86/include/asm/trace/exceptions.h  | 15 +++++++--------
 arch/x86/include/asm/trace/irq_vectors.h |  1 -
 arch/x86/kernel/Makefile                 |  2 --
 arch/x86/kernel/tracepoint.c             | 21 ---------------------
 arch/x86/mm/fault.c                      | 16 ++--------------
 6 files changed, 9 insertions(+), 58 deletions(-)
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
index b43eb7e384eb..69edc88e0f2c 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -102,7 +102,6 @@ obj-$(CONFIG_FUNCTION_TRACER)	+= ftrace_$(BITS).o
 obj-$(CONFIG_FUNCTION_GRAPH_TRACER) += ftrace.o
 obj-$(CONFIG_FTRACE_SYSCALLS)	+= ftrace.o
 obj-$(CONFIG_X86_TSC)		+= trace_clock.o
-obj-$(CONFIG_TRACING)		+= trace.o
 obj-$(CONFIG_RETHOOK)		+= rethook.o
 obj-$(CONFIG_VMCORE_INFO)	+= vmcore_info_$(BITS).o
 obj-$(CONFIG_KEXEC_CORE)	+= machine_kexec_$(BITS).o
@@ -139,7 +138,6 @@ obj-$(CONFIG_OF)			+= devicetree.o
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

