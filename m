Received: from mx0a-007b0c01.pphosted.com (mx0a-007b0c01.pphosted.com [205.220.165.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA001E98E0;
	Thu, 10 Apr 2025 19:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744312607; cv=fail; b=NQd6vpLF2WX+BaDkzCZd7fdU3tGGY9KyhKCrwu9kVuvzy71YEmxxNk/7QsWp1S58Ym0O0cQ2f8Ioznn/y+OXdDum/xNdhGZ1TOISUaK47fNyAKM0fT1Wt9ZFNzwN7KB9cpV6IgsNgx22Ed1QxZM1sGCRlE+zAqUKgOtnws8ESZo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744312607; c=relaxed/simple;
	bh=9cNhPIAZrPWgEMwsPYzWPCTZF6/TpPnR382ywQ/SsO4=;
	h=Message-ID:Date:From:To:Cc:Subject:Content-Type:MIME-Version; b=nLEdOTgRxoOQc1M7W7eiwgNZxBmFgt2xNmMOukkhlVp2XGTAj1mYLjLQxFwOyrsMEVzEgevQalU7Zadr45ODjB3L898R/x+kDhL3BmzRwCslCvzRb3y8h8y9dudfphCobfpGWZ+EmN4ICcYwL6PShPgFtxzZfQKOUq/3lFVvfWQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.wisc.edu; spf=pass smtp.mailfrom=cs.wisc.edu; dkim=pass (2048-bit key) header.d=cs.wisc.edu header.i=@cs.wisc.edu header.b=sQJ9UDzW; arc=fail smtp.client-ip=205.220.165.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.wisc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.wisc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.wisc.edu header.i=@cs.wisc.edu header.b="sQJ9UDzW"
Received: from pps.filterd (m0316039.ppops.net [127.0.0.1])
	by mx0a-007b0c01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53AFVtGg011638;
	Thu, 10 Apr 2025 13:51:44 -0500
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazlp17010002.outbound.protection.outlook.com [40.93.11.2])
	by mx0a-007b0c01.pphosted.com (PPS) with ESMTPS id 45xgq39w36-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Apr 2025 13:51:44 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RDDIY5i7WIdzjv5zsGhCB9M4x43pJyEu6+TE/QJVRe+HlOC2W5b7tBQFXGOgGzNJOXfXsWDvIz2D3MNt6oKpCcSV2xwgeSGkXjYtH/TTc63xT6svgSEgRfLKfLwMYCSiLg9ETL+A4lH2d/KwaZFi+N1/sxNIPblxWMSFtpmCSBJQkxdg6s3rtxqJ48CWCLAP4GxrGSGNsU+ybutB9E3wxwzlhCCvP/HZzPCsiI4sLCo8utIAItuopvSrfisu88DkQVxcLBuTxFdE9WeGzKzh0pwF1qVdP17IaSo/c3qTdP0d+9tYHVPtJFj+jXiJhqTMad6GlGC+jmzIspVEQ1vbBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9cNhPIAZrPWgEMwsPYzWPCTZF6/TpPnR382ywQ/SsO4=;
 b=P3TKwFkpDfqxPbiLzj70KXV2y/TEAr31B6QjZasDm1gi7S/LyAAuOroUbT7Nid4zjQuLWHdvf5rQt5c76+HSPw55KmQMlMVRqaCZIY8PuszTzp2QPBzvjfvjoxUTlJYgr44Dq7P7hlHGAwhx+hh7nZXU4fMUNB7glp+Konpu/Ae4RaxFXkuYuTJ21WPSiqPf0BVX2V9dbss3ka84yL3rpznHBOt4n6REGdjYSxhhQiFOgJDVrUN1Rjx/ZQxv7DoQofBCDU+BlPcPZLXh2VY9o+8K1HEyE9g/HFugEBA8yYjR6M4uDhbEirmlwmc00bm/YTWRzR9vSlL5BwlsCFr+rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cs.wisc.edu; dmarc=pass action=none header.from=cs.wisc.edu;
 dkim=pass header.d=cs.wisc.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cs.wisc.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9cNhPIAZrPWgEMwsPYzWPCTZF6/TpPnR382ywQ/SsO4=;
 b=sQJ9UDzW+8z+qqk/tpaFd+Yl5rpWH+sNPklinW5IjmapZtw+PAy5h40VaeckAQkK7IM86shsj0THA14zVilXD1bBT7Cb0rOk8Qyu/0KhRweQV96Aouc9tpFCpbZu/9I4zVG/iqsEAJWVeENtoWIKoog1ZtcfkeYh37XI7+G/6GV90BXu4X8nB6k9cuGgFk+DpPXjNqqOfIS8YQHRWCLq3up/VgkfmhYzCtK+9758kijPpuWzjesbccNa5UHzVTgCWtdI9wSqlD4rTv2U06/lbC4h85idKYg4gSrtcdCIP5modAMZd2L1VWQGDnx/gChFVdEfaGrpw5GOJNR9BieLYA==
Received: from DS7PR06MB6808.namprd06.prod.outlook.com (2603:10b6:5:2d2::10)
 by MW4PR06MB8283.namprd06.prod.outlook.com (2603:10b6:303:126::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.21; Thu, 10 Apr
 2025 18:51:41 +0000
Received: from DS7PR06MB6808.namprd06.prod.outlook.com
 ([fe80::76b2:e1c8:9a15:7a1c]) by DS7PR06MB6808.namprd06.prod.outlook.com
 ([fe80::76b2:e1c8:9a15:7a1c%5]) with mapi id 15.20.8632.017; Thu, 10 Apr 2025
 18:51:41 +0000
Message-ID: <9e2ac1e3-d07d-4f17-970e-6b7a5248a5bb@cs.wisc.edu>
Date: Thu, 10 Apr 2025 13:51:39 -0500
User-Agent: Mozilla Thunderbird
From: Junxuan Liao <ljx@cs.wisc.edu>
Content-Language: en-US
To: Frederic Weisbecker <frederic@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu
 <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Interface for enabling context tracking
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR07CA0003.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::13) To DS7PR06MB6808.namprd06.prod.outlook.com
 (2603:10b6:5:2d2::10)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR06MB6808:EE_|MW4PR06MB8283:EE_
X-MS-Office365-Filtering-Correlation-Id: 034f3824-141f-4428-c24d-08dd7860bb66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|41320700013|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YnBjeDBuZ0xJQWczeUpDTXBCVC9QclRIRkVMenRrYkNTTThXNWx2Q0VRSlQ0?=
 =?utf-8?B?cHRRY2lqRi8wTjNOUXl2bjY4VGwyM1dBZ2hFWGZ5c3R2ZjM1RDZ6MitWem9F?=
 =?utf-8?B?OW1PTFhRcS9vRkN1dnliZVJsZVpPNGpudEprb1QvWHpaZWdybEk4amo1dlBm?=
 =?utf-8?B?dWJYVVlnSmtnd0Jlc0xmb0lrczV3OHRxMzlwR3FDSHJDbDdQVzVkUjlDdk5K?=
 =?utf-8?B?ak5WRVk2bWtaa1ZYclp0S1prRklYQ1JKNWRkQWVadC9CQWZkSE1GWWdEOE1U?=
 =?utf-8?B?a3ZhYi92Q3VNbExRU09nQWhjUW9ScHZIWmoyYW03eE1IaGFSYXp4OWxHNWlZ?=
 =?utf-8?B?a2ZpeXE4V3ZsWGxXMlFmNGREQm45aWljbHcvL3VXN0QxaTN1YVUrdWhVVGJh?=
 =?utf-8?B?Slo4RENPMVBoVE1Wbm1aUStiMnYxVTVOelFyZUd4L3hyaG00Wll3RnRNTUtv?=
 =?utf-8?B?bjE2NitDMTRaMzlLbFdxa2p4bEorWml6UWYwTGdRbEV6OU1iNFk5cUxlZmJZ?=
 =?utf-8?B?aUlnck5qYitINTFqdEthRk1CYkpkMUwrMGlrWUcyaXk2ZkFrTVc0cUdQWkNo?=
 =?utf-8?B?bXhGRnI5Q0NVSDRwcUYvS1ZRRkJjSVljaUdKRUF4MWhOU0JwQ3ljNUpXa1pI?=
 =?utf-8?B?RkYxMEh2Rzh1ZzBLcm1vMzMvVWNTZ3VLckZ1T2x0VUo3ZStKSnpHTG1vUEtP?=
 =?utf-8?B?QTJna3hWV05vRmdUSFpTSkVyYnBBUnM5NUFPZVVOTDQ0RHAwVmVZWjdzcnVL?=
 =?utf-8?B?c2RsUVdjQnhqV1A0Ynd4NXdxQVQ4Z05hbW05cWYxMXNXbDVmZ3dpMm5pSHlR?=
 =?utf-8?B?VVBmcC9MTXF2dDBXVWlFRjY2UlAwS1VvL1VRNGZKenRFZ09idXdJampyOVZP?=
 =?utf-8?B?QXdoVGZHMDcxTVpHcUV2MDR4REJ2cStwYVBFR1NESkw2Y0VleGhscExZNy84?=
 =?utf-8?B?ZEZPbFBhcDFUWUVlcFl4WHA5bHZqZ3UwOVVKNGJjUkxJbFRvY1FNaDF1bWpy?=
 =?utf-8?B?YmwxYkRWNnBWUUdGMitRVEJFZWh1K2ZRdkNDSUk5b1J5bWFYUk42ck9SQnV1?=
 =?utf-8?B?dGF2bVBZL3lDTzRJWkEyM0E4ZTVjNEs5T2JWY0t4VURrSm9YUjBKaS9MckIy?=
 =?utf-8?B?ZFh1ZEl2aW1MUlRRYyt3L2FnNjdZdUpzeloyNVZjWjVYZTlCczU3VnpoM2pN?=
 =?utf-8?B?TTNpNm9WNWV2MWkyZjhLcTBPeDFadkxyalhhMkx1dFFVTzFQZlBLSEQ5UkFj?=
 =?utf-8?B?MnVvVVczdm91MjVnOTkrcGZIdm9uVXdUUW43d0ZGSnptaVRVQ0dHK0xobzNu?=
 =?utf-8?B?NG9mU0RxWVBqQVlqL2JJMlFpUzN3dTVjOHpTZWtrSnh6emhLUGlSdm9iMXZa?=
 =?utf-8?B?b2NNK05uM3NOWGcrL0xIaGtuSXdiZXJGVVVrOW9lQys1MjV0NDF5OVdNK2du?=
 =?utf-8?B?UnVhNlBaNTNyczJjelNhSCtQUkIxRGh5ZUx2Y2NoVHNkZVNzNS9wME9US1Ba?=
 =?utf-8?B?TzF2dWRyVVJlbFdoS1NNeEJIWW8xM255MXozV3I4YlJBWWh2bVVCL0tNaTNk?=
 =?utf-8?B?YlZoMVFWTVJyKy8yb1BUOEhKdG9DL05kd1kzWk9aMGF1RTNKbGRISDFlN0p4?=
 =?utf-8?B?WkJLVlZlT3lPNmpTSUhsOG1ObnQvbjN1Vk1kc1hIZklRckNOUkdEOUtoTE4z?=
 =?utf-8?B?eUZyYi9PK0ZUNGkwK2UvbzY5d0d5NnEwUXAwL1VCUUtRS3luZ3JoT3d5YnI2?=
 =?utf-8?B?OUxZWllsWUlxbkVMT00xeUVxcDF1U3BWVXNnR3NteTlMQzJHZGY3SThmMEd0?=
 =?utf-8?B?cUVWN21uWmZlNjN4K3RINVl6eFI0VkFEbnR3ak84NmZZbC8wR3plSC9ZMVZO?=
 =?utf-8?B?bTNDZ1lEVHZhMzNrMlQxRXo0QUQ5dFBYeDdHK3hIanhqTDBuSWM2WHVyK1JS?=
 =?utf-8?Q?T2SrqrsnPCU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR06MB6808.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(41320700013)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TGZQUE15aFN3QTZLUitxSU15Rk1lOHZqWkNQY0hxMlo5d3pnUXZuTUZUd25B?=
 =?utf-8?B?MzFZV0puVFUyQk5RaGpEWUFvaU9QTmJKN0lQMmpTc0V3NGVEcFlMdVJnUWhD?=
 =?utf-8?B?ZEJneUxNNGs5R3pBdXhBR3AzUXduN0szM08wTTFQQUkyOWthNVJuWmp4dTVE?=
 =?utf-8?B?eFN1MDI5YmJqNUpEMVYvWEF4akVocGxNY0hyRGl6MkZSMDlvVGNZYXhTZUdq?=
 =?utf-8?B?eFkzaGRibmNkVzVQbXF4U3VrZEpuTHo1WmZ2dW9KTXcxc3FkZU5JTVJvNHJM?=
 =?utf-8?B?NVNRbkRnQVNac0QvYmNrZmhVcTk0RlZRZ2V3VkR1UU9uQy90R1locXhCeTVt?=
 =?utf-8?B?NGJaTFZHS3YvTy9JOXAxUjc0UStDVGVnYUVPbTM4M1NxblhnR21VVUpvRjRy?=
 =?utf-8?B?eGF2UWVGeUpFZ3VJRFlVa09ONEhMQlZjMEJ5TnYrV1pQeEVWRGw4Qjg0YVdN?=
 =?utf-8?B?d0xJM2ZhRzlsR1hyMFo4d2Y5YXdnSENhUzRMNW9RWGdkMzFsNTR0dGFsRi9W?=
 =?utf-8?B?QmFsUzZOQ1ZwUGQ4SERFK2l6ZVk5SnU4SGtVdVhNQkRzakwvMk1SV2RQUk5o?=
 =?utf-8?B?S29xODQxcVJsT0d4WGNFVHpFdnFJZWJtWHZ6S0daMy9FdzhlOHpIVjJFUlpE?=
 =?utf-8?B?RXZJTE91dVZBMWprRXZtcCswVVFDRm81Z1NMQ2haU3FUUkYraVdhM24xa1A1?=
 =?utf-8?B?eU1pVGcwTkdteTRHVWEvZGtaaWFCNHdHNUx2N0RMQjV2bE42S1M3bXdsaUls?=
 =?utf-8?B?VkgwWHNrTllNeXVnVy96eFp3cjZ2SVJKTzVTeWsrNGxXQ0ZwV2lWY0djR3da?=
 =?utf-8?B?TnJGM2J6MGNqRUdHMlREODIvYitGOG15VkxrUU9pRkVlOXB0SEJSSjhmK1hr?=
 =?utf-8?B?Q1pRTWxsSlY4NVJlVEcrZXlnYXNjeTloT0hKK0hkbmhNdmVGczRmYVJPMW9C?=
 =?utf-8?B?ODVKMTErVU5TQi9kZFlTUlIya1IwVEVhMTdSVE9wWitESG1Ebm96R0Z6TWJa?=
 =?utf-8?B?QTJsY1hucHFwU0M3NmRqcDFhMmo0YS9OY3RpTGtHdUErUWVOYnRramlZSXlK?=
 =?utf-8?B?cU1YTjdNcjJXRHZ2b2IrakFqSzJqdFBwUWk3SEV3eVRlaExEMTQ2S2dwY1h3?=
 =?utf-8?B?dVU2ekNYa0E5MzJhNkxqdnVXd0JVQzdhZi9xM3dPNzQyRHBYdDhlT1k1S2hO?=
 =?utf-8?B?Q1FlNTVqRlZWN0Nrb3FsQTNYaFZ2TGJ6WHQ4TDJ6MmQxOVg1ZXd1TVFUd1V5?=
 =?utf-8?B?YzRpYXFjVTRSOVkrWGVlTXZuYURXWUtEOFBTTW11bkhYb1FRdVRHSlVzMS9K?=
 =?utf-8?B?MWxPUGhzMFFsc29WQVR6ZXZTNzNCd1cvbmFqTTZiaTBod2l0UURwcVVSQXVz?=
 =?utf-8?B?UE5qcHp2ZHBPTjREa0h0QnJHbW5kVGNFd2EvWVlEOThJL0F0YXEzWVdTN2dq?=
 =?utf-8?B?ZHErMFZSWVduTzlpLzlFa2VoNzUwdUFhcDI3RVRoMVBGOUQvM0xVS2c3ZWJh?=
 =?utf-8?B?d1p4TnJYb2hzSExYY2dvbWdqTjVESWhQK3d6cEptQVhOYjhoWTRSbkxvNS90?=
 =?utf-8?B?c3JkUXRrL21ONjV3VElMeThZb1JaU0FTMTZFYm1qNnUyVlREYVhWNzVDQVVC?=
 =?utf-8?B?c1RuWlJSbjJua0VJNTRWWWZ0eUlHSlZsWVRlTlY3ZTJNdFA5NTlTeEhSN1NS?=
 =?utf-8?B?TzJ1QlBaem1iMTFQTWl4R3d5N1BvOThlK3BsQ0QvTmRObmFzWDA0WFhRdEtU?=
 =?utf-8?B?VmhLajlsekJpRmdGSVYzTTlBeWhtbXdVSnFiOUZkbjNWOEZITnB3ZE1EMTBo?=
 =?utf-8?B?UFJxb2MwQVBEUWl4d3U1cU1NdklCRGMwWUN5cjRVc1FBV3JlUG9ZYVFIZjlW?=
 =?utf-8?B?NnNURVREK2hyRXcwdHJVWlhleXV2dGhqR1BuL3E3OFQ2M0NKKzFsbU1QVmov?=
 =?utf-8?B?NlU2UCtWSW9taDkrbU1yQlV1cDIycjZXNkpTL055eEZMKzJITC9XaFhCRG9h?=
 =?utf-8?B?aHZDaUh3NzhuMzFWcWkxZVJEdU5sekpRT2M0K3dXSk9KbzhtWnB3dnkxTVVU?=
 =?utf-8?B?QWhOR01oWXdCRGo3QTNMOE9rMjU2d0NHSnN6TFVsSFdHMXdMNWhFMnZPck5w?=
 =?utf-8?Q?tjcU=3D?=
X-OriginatorOrg: cs.wisc.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 034f3824-141f-4428-c24d-08dd7860bb66
X-MS-Exchange-CrossTenant-AuthSource: DS7PR06MB6808.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 18:51:41.4723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2ca68321-0eda-4908-88b2-424a8cb4b0f9
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pyvgJxR9zi8jPAU0uaOxmma2bwf5hkhOOPKo8V243Ar53Vl+uO/R2GpyWul7oAtEbQKOdDjZedIL4RJPpqK+6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR06MB8283
X-Proofpoint-GUID: YqB4P-j8eRgsPPaQluqbrKNRrZApV6-h
X-Authority-Analysis: v=2.4 cv=Qe5mvtbv c=1 sm=1 tr=0 ts=67f81340 cx=c_pps a=CQ+uznrK75NoT8CVPM1Etw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=XR8D0OoHHMoA:10 a=3-xYBkHg-QkA:10 a=SLsbHhmqxccL7Wsfgy0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: YqB4P-j8eRgsPPaQluqbrKNRrZApV6-h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-10_05,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 phishscore=0 adultscore=0 mlxlogscore=526 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 mlxscore=0 spamscore=0 clxscore=1011
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504100136

Hi all,

 From what I can tell, tracepoints context_tracking:user_enter and
user_exit might be useful for performance analysis. e.g. Figuring out how
much time is spent handling page faults or in system calls. However
context tracking is by default inactive and the only way to enable it is
to turn on nohz_full for some CPUs.

Is it a good idea to support turning on and off context tracking through
some interface accessible from the userspace?

Thanks,
Junxuan
