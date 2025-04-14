Received: from mx0a-007b0c01.pphosted.com (mx0a-007b0c01.pphosted.com [205.220.165.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19F31FC0EF;
	Mon, 14 Apr 2025 23:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744672973; cv=fail; b=P9ElHO1lnE4bRUTJfwLZeZDwaY9M3JU7pGZMaHMrnozoPVzTEAFddCNYV3R6NhjBOp14ussZ0Vd37bwAGSSLM7ZVfvAkkHaOY+tXs/HytLo/Mt5yKfi4CXnZxWmX2UctSxml9tpEmgFFf1dIwpYYHINHJqwzHLhpFSQ26uf8JXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744672973; c=relaxed/simple;
	bh=As+GQk4Xf/SuGfX5BlXuwX5TSz+OMCu0acY0ZW2t15Q=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=O5flsihxYHEa2r7hC8q5VL3OffBP2jP5VvqfOlXxRGxbNa8bnQOAXcwRwV4innWaD6cLA+9Clr8Xr9HWXafGpK2Y2ByRwlILviYWbUB/ljIigddzifbj5FOgDwnq864L6uz25D2tvqyZbkMFAXQG6CZN7yjbRZFRsDGILYVNrWI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.wisc.edu; spf=pass smtp.mailfrom=cs.wisc.edu; dkim=pass (2048-bit key) header.d=cs.wisc.edu header.i=@cs.wisc.edu header.b=nX8NAHB9; arc=fail smtp.client-ip=205.220.165.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.wisc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.wisc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.wisc.edu header.i=@cs.wisc.edu header.b="nX8NAHB9"
Received: from pps.filterd (m0316039.ppops.net [127.0.0.1])
	by mx0a-007b0c01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53EIiVK2006044;
	Mon, 14 Apr 2025 18:22:27 -0500
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazlp17010005.outbound.protection.outlook.com [40.93.1.5])
	by mx0a-007b0c01.pphosted.com (PPS) with ESMTPS id 460a96tuhn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Apr 2025 18:22:26 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rZnt0/SzNZCrW24Lf1tp4Mx5HPdajhKZC7iPf+Y5mpvuHO5OQXqlu7E1Kh5VLQ2++6qq9JMOjhVsyySkeELd3krWgLcTx7BM5q65TR/OKpPMYAONXWFHVaa6zhd8bBdmAEo98no56OPkcZDnMkRr/rRE4BjA+hMGJpmD5Fb2Fw8bNrlJ+OyhSj5ecPicctFrgSOuJLHjWKz7yQA07Zl4DIpEEOWZLRMct7q9v0J7/ZMIf+EJsrWPMNFG3OWbVFWi4GhgkLJlx7idvPg/X7E/I2AV0rcAi3h8mdURqcRXKgblGHmaKizq4pekG/AewCQVq1wGjQOg/2tjjyFIewH3Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=As+GQk4Xf/SuGfX5BlXuwX5TSz+OMCu0acY0ZW2t15Q=;
 b=Xjp/ZvTBdeOcKAeWIdfnsmX8Duyfj2ZbyoSfUORLfSprlwDlECvXwSLA7y/jDOk9bM0/s3Tg0k5iNLHYBwWlcPJ5ofIfnPwGPX5pkhKcFYRWg6wd0Xx9cWkdaODTsadC1kHTjdyvEMgz+rCGu+I8L127Dy37m4Dec9q46OyenSDDmhkfpHIcM1wiTj9cJGEkKqkyVZueYYlOK+DIPSYe9Ww5OrDvDK6tsbw0edev95jkdsOOPWpA3nzIBMq/eL9+YSxP3d8KLIu7Au0k5MRZ6ygITUHm3bmlGXQj5a8pda/kdTod0lUVhLV3AvEKY+YXQ/rIubnsmTjkDjQDjFfnJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cs.wisc.edu; dmarc=pass action=none header.from=cs.wisc.edu;
 dkim=pass header.d=cs.wisc.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cs.wisc.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=As+GQk4Xf/SuGfX5BlXuwX5TSz+OMCu0acY0ZW2t15Q=;
 b=nX8NAHB9ZpgWKymL2AqA/hvH/t7rfeBKa4LXW5QLxsr4+khs3IUOqMa8DPcPcIJTOVdBPTLegM/qW4oh5669eMIwrmKIgY0y/Xm+z3I179+TzKJJYq5qU/a2zdN45FwPjHc8228FIw2s4Mysv2AegaqMJHxZ7BZ3FAd0LB/o8wHjpaT/hJfuGGXr5biVzUlAz28f8o+SfMWzj0VWTInufHNHkNn1gIUeIXTEdkYxO7GYcVgdMVeC2PZmja+NYiJPI5kMqwtHKQXmjTeCVaTYUOBHh+TNI8w3CHHoOPZuxGtoVDNLJSLo4TOEdKupk7pN/WmGDjG/V2s9L1W16dLC2g==
Received: from SA0PR06MB6810.namprd06.prod.outlook.com (2603:10b6:806:bc::15)
 by CO1PR06MB7996.namprd06.prod.outlook.com (2603:10b6:303:e3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Mon, 14 Apr
 2025 23:22:25 +0000
Received: from SA0PR06MB6810.namprd06.prod.outlook.com
 ([fe80::c7d3:298c:69b0:970b]) by SA0PR06MB6810.namprd06.prod.outlook.com
 ([fe80::c7d3:298c:69b0:970b%7]) with mapi id 15.20.8632.030; Mon, 14 Apr 2025
 23:22:25 +0000
Message-ID: <41e7d947-d59f-41a9-a540-d3c07e4678c4@cs.wisc.edu>
Date: Mon, 14 Apr 2025 18:22:23 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/tracing: introduce enter/exit tracepoint pairs for
 page faults
From: Junxuan Liao <ljx@cs.wisc.edu>
To: Dave Hansen <dave.hansen@intel.com>, linux-trace-kernel@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
References: <e7d4cd81-c0a5-446c-95d2-6142d660c15b@cs.wisc.edu>
 <214abd94-7fb3-4515-a1ae-a60abe81af88@intel.com>
 <a40a1add-00a5-49bd-887a-5fc722c9814a@cs.wisc.edu>
Content-Language: en-US
In-Reply-To: <a40a1add-00a5-49bd-887a-5fc722c9814a@cs.wisc.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR04CA0028.namprd04.prod.outlook.com
 (2603:10b6:208:d4::41) To SA0PR06MB6810.namprd06.prod.outlook.com
 (2603:10b6:806:bc::15)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR06MB6810:EE_|CO1PR06MB7996:EE_
X-MS-Office365-Filtering-Correlation-Id: acdb3d86-fb7b-41e2-56ac-08dd7bab373e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|41320700013|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?KzhmNHFOZmZpRGxKRnQ4MUsxQUd5Zy96blVLSWVTY3dVQytjc281TkJHZzg2?=
 =?utf-8?B?Q3RIcnJKemdxQ2xDWjZ3YktXUDQ3Q2RURlJvV0lpRFpUa1NOU2hWQWlSQXl2?=
 =?utf-8?B?RUgzL2FhWEtoMmZUcDIveDBVWjFad09XWXI3c3JPb216cXAvbFh4WFBxY09z?=
 =?utf-8?B?ODJRcmlaUis3UElKM1RhekFuOEU4WXQwM0YreHd2Y1dPeGtnSHNRNzhFVFlR?=
 =?utf-8?B?dkE5aDFtOUpLM0d1dkEyaXRHUWlVdEpiQTVsN1J6bytKd0hhNVM1UWE2NEpU?=
 =?utf-8?B?VEZGMnphQ29FTkZoZVNKaHM4VUkvaVBMa1RoYkIyMTJuREd1VWwvVTdVS3No?=
 =?utf-8?B?ZERwWWRSenc2RjQyY05RSTRGUzJlcHlPdG9vczc5TXlyaXRmOE1ZazZ3RnBu?=
 =?utf-8?B?YUo3MnJYL2l4cnRRSXFXb0s0WkNNREdoaSs0MUdFZlljdFlQWmRZcXlrSXY0?=
 =?utf-8?B?YllMOXRwV2pCeWNFeWNURDNDVnp2TnhodXVTUmRMY3lmZHhiV1JzbXFJL21X?=
 =?utf-8?B?dHMyODZlazVxcWVLOVNMZFV2THVRRFZaRVNBdTNzV1pyeFpjbDNuZVZWcmg1?=
 =?utf-8?B?Z3FwNUpZd2IzMVBybmcwWjZyRE9YbWRGUDhwNTNvbm9rQmNrMFB1U0VHcUx6?=
 =?utf-8?B?L2xTODRFTWdhRXBuM0U2aXYvMmEyQ0ZyUm5pZnp3MXFFaURLU0xtYU9vUXFl?=
 =?utf-8?B?ZHdkK0h4S2R0RTdaUTVaKzlLeGYvRUVNbG5qL3lMOEFHVU45UUlrN0lhV2pt?=
 =?utf-8?B?SDBmL1daelptd0hEaXR6dFNnMjdzK3pERXlaSktJMSt3aUNrQWpSNVdpZjVF?=
 =?utf-8?B?ZDA3MTlaWk55bnNDU0NERk9FVzRoMGc1c0Y2Y3ZreXh2Y1hrN0ZDNmt0VWlF?=
 =?utf-8?B?bmdDdzlIL3J4T2VYbStJWUtpM1ZPS1hLVlpiM2tzQU16K3Y2OFlhMFpLYlNS?=
 =?utf-8?B?dG9LWWtUMzJkaGZYVTBucTh6MGU1bzNwMWo2cHgySDVVTm4wTFowWnArd0Jp?=
 =?utf-8?B?d01lcEEyS1h5ZG1QZHdlME91dk01Rzc2THZtbFh0c1VaK0plTmVieG1neDNY?=
 =?utf-8?B?VlY2K3czaUNTT0FpaWJRZVVBWDRPcytkQ1ZPcEdmak9ST1kyVERQV2o0cXNk?=
 =?utf-8?B?dS9WajZyUWdhQkZEQTJxTHZyOWlUVmNYWGhEWUs2ZDdoZkFtZzJzZHZ5Rmkw?=
 =?utf-8?B?bnBxOHFBY3BTTFprbW9KREFtY0RlMnFyK21xZWFkSGRJZW5WSit5QVArNXRR?=
 =?utf-8?B?OTYxNlBIaTFMSTEvZnN6WmhmYWVaak5LRnY2Sm8wSW1xTHZkY0lHajFRcHd3?=
 =?utf-8?B?SFRCOHVobzh2MWhvWjZWamNtTDA4Ni8xT1BTZlNjYUMxaEZ3QjdKK0lIV0ND?=
 =?utf-8?B?K3N5akFYZUkzTksvZUsvdUUyZTJKcGl5eC82TXVKWkF5bnNmRGVsb0Q3UWQx?=
 =?utf-8?B?MjNVb1NYVHUwV1hucmxodndOS3k3RklZYlVGbk8zWk1ma1NocFN0MER2SDhU?=
 =?utf-8?B?VHB3amxFRjkvaDlqRHZpelJPUkJ4UHZyYkg5MnRNVEcvVXo4UDB2Y040djlx?=
 =?utf-8?B?cDQxQkZVQlkwS2Npc0FsVGpsU2w0TGdGWDA1eXhFL2FWL3VzUkt1UmhWL0N3?=
 =?utf-8?B?bFdGaGh4TzI4dlA0TlZNZlU0aUtSM1VxK0twWGpuMVliZys5YlFRNU43dWo3?=
 =?utf-8?B?ZmIwS2xSdDM0Zkw2SWNkeDI2c0Jkdnorb1NnK2VXMXVtTkJwK0RXTlQ4MWYz?=
 =?utf-8?B?dkY3NER3YXZmZ0VNc0tCL0c3R3VNWUM2c2hnV0JXNmxhUXVIUVl3QUY5YnlO?=
 =?utf-8?B?NktiazhYTjNFU1BMbVBRUHQ4RHJsa2J2T09yNG82KzcvTUdCQ3ArWEdja2Qv?=
 =?utf-8?B?WnNTVW1IRUIrOHhiWXdFcjdicTNRVUpEaHVVaTd2M1Y0SklRYXd6MUVDRisv?=
 =?utf-8?Q?5fnRJI+dukk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR06MB6810.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(41320700013)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VVlOK3NKOXlZcEQycm9DRjkxMEFCbm9sTzJpU2tzeG51UGhTcXE0SEpDaHZR?=
 =?utf-8?B?QTByU21tWUVmd0M5WjQrSGJMY1I2OFVpSWpTTnpzVU5jb21KbG9HbU5qMmVx?=
 =?utf-8?B?UGw3bjMxVFBIMVhuck1hbmFKckdzY0Rpb0c3dng3MUxpbzAxR01nYWlaNWVR?=
 =?utf-8?B?b3R3U29PK1hZUHVhQnRIRElMRTJodUE4NTN0VnVjOFFaRi9qa3FFWFBDUW5O?=
 =?utf-8?B?eSs1Z0dIUFJkaWdjR2xHOTJVVzY0UkpETlN2Z3BFQlBCaHc3QTJNM3MvaXMv?=
 =?utf-8?B?MVB2UE95bGt2TTF2QXJWVzNBaEl1MGZ2OXY4K3F4T05IZzlSZXhOcjczbW9I?=
 =?utf-8?B?QnVBRzNMNUtvWVpjbFAyZjRIYzY3dlE4ck5rMDlZVHd2YXh2a0swQzdRbSsv?=
 =?utf-8?B?UDZQTkI4LzBFSVU0NUJpNmptZzROc01uWTZuVk5BWStiVStwaytzL2Z1TllB?=
 =?utf-8?B?YnR3RWUrMWFuSWhuamtrUVFvbXBKSjF4ZnYwNXZyRGk2aEdXaUxsaDBwcDYy?=
 =?utf-8?B?L3F3WkhVVkpUSjRnRkVTc0JadWZPNTVycnpZdTVGd1FMNmF0TEEyMlFGOHBi?=
 =?utf-8?B?UmR1TXQ1MHpiK1NVUGsrTWFaS20rRWJub2RDUDFZa0tVQk9wREphbExXYWpi?=
 =?utf-8?B?aUo0bFJTZjd1Z2tEZWdJMFdTcWpDaTUwVzBDbGNBT2lrcm1QR3o1SGx0Q3Fj?=
 =?utf-8?B?WFZpVnRkdGV6V0h4UVhyOXhkTVo3ckVYSHkvTUltc0JkdGM0L1pySk43d21m?=
 =?utf-8?B?VjRoeTZwNEVSVytBR2FoZUgzQ0N1WUxxdC8rSldaK1FTak56dURBVGFIMkty?=
 =?utf-8?B?MkpSdE1ycFdhYmJRcENjYXRYNkRpVURoaGJBc09nYWwyU1FoR1FvOHJFekwy?=
 =?utf-8?B?S0g1NTFPanZjQ1IyVVd0OWRZTFdsRkxKWFdwVFdIcTNaU1JVR3NSbXAwMVVZ?=
 =?utf-8?B?MS9VR1ZZcEd2VVNaK0tFV2wzSExkclJwUExnbWM0ZDBPSGYwV2JFWkcwQjV0?=
 =?utf-8?B?K0NHV2dRL3hYK1dpZGpmQUQ0ZFcydmd2TEcydmU2Z2dwc001dm9Cd21CZGo0?=
 =?utf-8?B?SjREcVN0T1BNTGV2T3dzK21QQXM5SVh5SGVIcFAyaWE2eXdTamR4SFNrblZN?=
 =?utf-8?B?ZmZiNlVhaU93UXZSZko2djltTnRiVUtBYUE0S2Rrcm1acDI2cUhIQWs1OFp2?=
 =?utf-8?B?UWtybTJkUE5MNUhhQmUxTGkyM3FmaWp4aVluSkJjekxoUFdVTG1jcGU0T0l4?=
 =?utf-8?B?TjNlaTJZamRFSjZRWVAwa3pKVTlRM0t3WVlVMXNYeWI3TkZxV0Q4VFVtdVNu?=
 =?utf-8?B?WGIveW1UWXdObkROYXhUd00vWUVpdWljZStWMXVKVTRuWHRUSXlJVk1nNmFS?=
 =?utf-8?B?cmF3T09sTDhEVjJwbmluQ3Q0ZExDMldicnByb3A5R3hwYW4rbG1yZm0rNXdM?=
 =?utf-8?B?Q0hKQTBaVTlBYmdlYTV1TUxVbEUweTdHS3REVXEzY0kvUUFiL0FWNnFwaTR0?=
 =?utf-8?B?WCtsVXVacEVEeEpZcnZmL3dFNzFucFBKNnpVSmNhVTA3dnBNcUtlR2pGK0ZE?=
 =?utf-8?B?MXlBYzNWcERzdFJNdkM3b0xnSnFXaU5zemRpbUhxNE90ZjZDOGx3dWhXS0dj?=
 =?utf-8?B?djdRZHRkbkRHcktVWktqcUlaTHpyeEN5Ym9wOWp5cEVha1JVT3ZCano5QitG?=
 =?utf-8?B?WW8xbE1LcHFBaVJXVUxHOGd5OXdsaE91Wjl4bHdXVnhnUjd2RkNlZWUvM3gw?=
 =?utf-8?B?SVFUNjVjb2NlamdaMzlnRjlOODlzZzhGbFBnOFJLaVArL2xwWXF6K0RCMXJk?=
 =?utf-8?B?a1RBeFJIM3NkR0pSbm9sQVVwQS9lMHZXa2JKclBNUXZldEw4K2U1b05FcWhT?=
 =?utf-8?B?Y3NlVlQ5UE5HVDFZNGV2R2VGUVJ0TmN6MmRvYlQyaS9oNHUwM1BsMVV1cDdT?=
 =?utf-8?B?REpHbmVWMmlYMVk4NHIwdWlHOElXOWR0SmNrdXRtbDJrTCt0U0pHSmVVRUJz?=
 =?utf-8?B?VW1pOHVzWVYyOEtRTG90SXJ5enZ5OW9wRzJ4TnBKRmFmNkxqUENvb1ZCK0dt?=
 =?utf-8?B?bDVjL2VxRDBFSmphSTRuVDUyUkU4cVQ1S2x1T0JGem8zTHEwMTc4TnhwcjRo?=
 =?utf-8?Q?vglw=3D?=
X-OriginatorOrg: cs.wisc.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: acdb3d86-fb7b-41e2-56ac-08dd7bab373e
X-MS-Exchange-CrossTenant-AuthSource: SA0PR06MB6810.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 23:22:25.4723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2ca68321-0eda-4908-88b2-424a8cb4b0f9
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zUb2F3xKeVUc0m/YdhDPQqMUNBFlv11nvzE5D7C0rFufmxjyES8cn8r27jO7w3J5gE/+aeMXuY+iaFZ+5FnkoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR06MB7996
X-Proofpoint-ORIG-GUID: 1O9IQEa908BMr_J78lLv0bBgbf34RkrY
X-Authority-Analysis: v=2.4 cv=CM4qXQrD c=1 sm=1 tr=0 ts=67fd98b2 cx=c_pps a=94i1PXq8WVRBNmfdvHlv4w==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=XR8D0OoHHMoA:10 a=3-xYBkHg-QkA:10 a=KaDtvkzE4MkbfIfcoq0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 1O9IQEa908BMr_J78lLv0bBgbf34RkrY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-14_08,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 spamscore=0 bulkscore=0 mlxscore=0 priorityscore=1501 adultscore=0
 mlxlogscore=653 malwarescore=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504140168

On 4/14/25 6:14 PM, Junxuan Liao wrote:
> Do people find separate user/kernel tracepoints useful? For me, I can
> check regs in eBPF tracing code instead.

I think it might be good to add a field to the tracepoints to indicate
whether it's in user space or not.
