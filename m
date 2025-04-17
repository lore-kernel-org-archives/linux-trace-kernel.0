Received: from mx0a-007b0c01.pphosted.com (mx0a-007b0c01.pphosted.com [205.220.165.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C0214B092;
	Thu, 17 Apr 2025 19:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744917076; cv=fail; b=isDo6ahuJuIszY/SS5MjK6A3EpXKWY896ChrPo20l2ckFJTlZQIaDvP9QCbz3kdwl99UH9D7sB/mkFlZN2wZNqh0emVvZ6xG/e+X/NxFEhsBcHZUucYcaaoCzlDH1ob+wZDf0ld1uOWCTpSnjVengWOnZ6YnY9xaL8bH1GFrp6s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744917076; c=relaxed/simple;
	bh=JgjYcKjVIvRmD3GScMOEw1Dk3iTdHv8oYt7c+ERpLpM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=p0b+ueNX6+aPvsXavzJqp7gstwt+1pX3KGiicr68yzO4Fzn2CVVZ99hCPOj5zSa7f1AD3IwXHHMJVTTW80CyWsEMATbBlSIPbs0ewqo0e62zOWTE4bl5s2xb9c5OEJGin/4T8Dw9mlxcx96COhB9o8ods2bxqhsV9oF0w+4ljyU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.wisc.edu; spf=pass smtp.mailfrom=cs.wisc.edu; dkim=pass (2048-bit key) header.d=cs.wisc.edu header.i=@cs.wisc.edu header.b=v9LerM07; arc=fail smtp.client-ip=205.220.165.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.wisc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.wisc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.wisc.edu header.i=@cs.wisc.edu header.b="v9LerM07"
Received: from pps.filterd (m0316038.ppops.net [127.0.0.1])
	by mx0a-007b0c01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53HGi4R0027917;
	Thu, 17 Apr 2025 14:10:57 -0500
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azlp17011029.outbound.protection.outlook.com [40.93.12.29])
	by mx0a-007b0c01.pphosted.com (PPS) with ESMTPS id 4635e29b1w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Apr 2025 14:10:56 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S0My9ot9of+kY0h+APEPxt8NkF5/wyTyxybzr2apZDYtkbPkzFingQwKJ29wqc90zJ+o9ZznYQTkxie51nanzV7qb+m2i8xdspVZyd/t2HmhVQhEPW3bUhj7bFCT4e8vDTUncD++xGN8qh5PxInIPoGHHfVNEiCj8fBHXiZbaTzJ++dbstTn8lMjq9+AxdARWS3eRs9ZC19JP6GDJpkd07zZ2jBbYnKTZVZcSPgQ3cbhSvOQDq1tctmNgUJuKNPc8xTPbEvMEVjyYkGRuyu1pQ3coZfi7cfUQkdYt/7nApjoxE8/ljDJg+T7reBSscvP4b4hHrUHWhbcfKrPx76IwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BV8XcQygdczgNu3yndQ/Nm9lVhkGpbf4DeRxlVTskZE=;
 b=sSAX4pCN66yuw7QdLlbUzpp77yfs8UW//mVeYDeGh0tMtMjpS0u0hrRRh8EeccKnLmjwXJYLt1SrNW3DnJ3yvxo7Jr4DJcSZNkNdr6kKZaMR6nAnCRE+d/78pkfd2+W+SDPETthfRVckbQSXrl+pP7p7GLTJAgs9d9zlMznaQ6YJCmhHegnZm3ZqaEaUqzb7+34lpZa6r45c8PJ+0cFes2vihwInvqIrmC7cWE5OqUzE+Ur79tlL0IgQWqDwFftPNaG+nVGdHtPKxZbV6xHCVPtSabI58ehvGD4dCb2ji/2Z43NtQbFBcAbu4QWftEgRpjRZaLTJzT6hIsicUi/Fmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cs.wisc.edu; dmarc=pass action=none header.from=cs.wisc.edu;
 dkim=pass header.d=cs.wisc.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cs.wisc.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BV8XcQygdczgNu3yndQ/Nm9lVhkGpbf4DeRxlVTskZE=;
 b=v9LerM07fUQlCgP5xL1xtBWsLRzl+JcmenoN0hDmzS42FceVDBZIhLowsSWVazMWzHkdcfn8J8SmajdwV/PNNNZxQBQ3pA5tJCwj/h/kdTzXZPeATztAAC+qixJQN0FXnD6GF6pnD0X30/+3gArHsKDc5rEPy4TNWYHN8uXu9qm35XErJ8VlSgQuaYDA4qWYilEHRemRBodSjhMVdSmssg3Q9RobDLU+k9UHigmQcu+/+kn699FWDID09N0mvmLy99Zr1dV0+lIp0hfT9alYL9i7L8+lrWobZXv0fKPmfCCrJe2MkRSAy0v4x1sXBKsBdOzoBlxE/XFoq2LNSDN5Zw==
Received: from DS7PR06MB6808.namprd06.prod.outlook.com (2603:10b6:5:2d2::10)
 by PH0PR06MB7302.namprd06.prod.outlook.com (2603:10b6:510:2e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.36; Thu, 17 Apr
 2025 19:10:55 +0000
Received: from DS7PR06MB6808.namprd06.prod.outlook.com
 ([fe80::76b2:e1c8:9a15:7a1c]) by DS7PR06MB6808.namprd06.prod.outlook.com
 ([fe80::76b2:e1c8:9a15:7a1c%5]) with mapi id 15.20.8655.022; Thu, 17 Apr 2025
 19:10:54 +0000
Message-ID: <3ce02a98-0ac2-4d34-b6f7-ba85088399d7@cs.wisc.edu>
Date: Thu, 17 Apr 2025 14:10:53 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: Interface for enabling context tracking
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
References: <9e2ac1e3-d07d-4f17-970e-6b7a5248a5bb@cs.wisc.edu>
 <20250410150555.7797d195@gandalf.local.home>
Content-Language: en-US
From: Junxuan Liao <ljx@cs.wisc.edu>
In-Reply-To: <20250410150555.7797d195@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN0PR03CA0009.namprd03.prod.outlook.com
 (2603:10b6:208:52f::14) To DS7PR06MB6808.namprd06.prod.outlook.com
 (2603:10b6:5:2d2::10)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR06MB6808:EE_|PH0PR06MB7302:EE_
X-MS-Office365-Filtering-Correlation-Id: 696685e2-8364-4cbc-b184-08dd7de393cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|41320700013|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SGlmNWM3NVFlSXptcjZ3M1g0WllNZ2IyV2FNNnoxTVoxbWJhSHYxejFlUi96?=
 =?utf-8?B?N1VOKytKVE9GUEp1LzBRVCsyT29XbDhOdUgwQUpiNXVUNmdtWEF4Y3FNMU5r?=
 =?utf-8?B?T2tndnliNi9jcVN3Z3NReFZlRU9qUHhNOTRnbkxqN1hQTTFKT0I4Zk1HNkpp?=
 =?utf-8?B?NmJSdG90UmZhTWU2M3hJaWtYMWVmMVFTV254VWNWcWVScWUvcS9iR1FHbTZB?=
 =?utf-8?B?N3hZOWJKR1B6cWhlWkVFV05FM09iQjZBbVdmRnZ0MFNjOHNFem9TMmdCRzhw?=
 =?utf-8?B?TnlHa2JQOWJNa0o3dWQyMFp2L3RUcVZRMDZJZ3htQUVPeDNvS3lxZXlZRG5p?=
 =?utf-8?B?Mk5hSi9RWFV1bWZlQ2VuV01SQzRzRjNwcnFMSUx6aGppNzJQV0NITzhHZGcw?=
 =?utf-8?B?UEhiUUtDdWJ4Rk05dkxsaHhlSC9LT1hPcFR1dXprSDV0elEzWkdnWWFxWjEw?=
 =?utf-8?B?c2VUdVhlbzY1NmNuQVhKcUhuK0RkWDZhSjl0KzdRTzBGRmlaajAxZ0ladmp4?=
 =?utf-8?B?R0U5NmdQV0hKS0FSb3pIN0EwcUJkRkNjbXpWS2Z0M0hhd1YxcGJuTzhJbmk2?=
 =?utf-8?B?dHJkdE1QWEV5UnZIM0ZXeXd6b0Q5TzBwb01JSUtPb2Vsc3laTVVMZG80VGpE?=
 =?utf-8?B?ZzVrUDVMTTgrU2xxWGtuN21HcmZkdDY5LzU4UFFWc0hhUEVHVzFIU1ZLanpK?=
 =?utf-8?B?N1M4TnJJdUsvQkNydk95cE9YZ3dDRkdyU0lQQ0F3MmdHNGh3dHpjMHZZdXd3?=
 =?utf-8?B?VkF1VnB6YjlZZGNEYlRvdDFGbUZ0MmZ4SHFUK0R6akx1Q3RvaElJNm5xSFd5?=
 =?utf-8?B?S3ZRYmpvWFNxU0Z5LzlnZHhId0RpcEN3R1lFVDlLVCszY3R5V1ROQ1I0N1lR?=
 =?utf-8?B?SWx6RjBSWDB6UXlZTkhKK1BxdlQwWG16V2NxK0ZTSFlvL1RRVUFBa2tzdFNz?=
 =?utf-8?B?aFdtejNiblVZTHRPMFVDaFZBck1wVWRTRkRPMzVXK29NOGVXY2NzckkrV1RY?=
 =?utf-8?B?Q0FzdDhvaTl3TXpieGx3a2tVUlJFY1ZhcE9BREhORkIwVHlLLzFVcnVSV0lt?=
 =?utf-8?B?d0YzQ0xGNklWQVJnNlp2Q0xqcUFIaGZ2elo1LzJ6ek1QSlB5d1ZqbytNdXdV?=
 =?utf-8?B?UlZxZmlxa29sTW55bkZEb2lLTmxCNGZzdWxwN2hVaFdFU1p6YTBDbDRFU0Vu?=
 =?utf-8?B?dmVBSmhyWi9SWmtGUFBoaElXSVZzY2pndGEvRlZheFhUb2VCL1RXYW5HaElD?=
 =?utf-8?B?eGFHQTE1eXBOZlR2QUdSS1ZaeEpzYk9pRHhmR1lJSUs3SmswSE1YUkpjNk1z?=
 =?utf-8?B?Z290VFk3Yml6YTdCb3R3SEtYTHc2MTYvSFRKNVdRbnpyVkIyb1Y4TXdQU21X?=
 =?utf-8?B?blY3dDIxTGJaUU5VTnVBQVFqNnU1UytXSTB2cmZlNmVyMGszR2toL05QQm5h?=
 =?utf-8?B?OXFPSkhJcUxLWGJUcFRIZjNab2tEZ0lGS3lrSFlFQmVyVEpVOVg0ZzJ5czJC?=
 =?utf-8?B?ZWg1T3c2bVRMSTZGNjVGL0VKM2p0cVpYOWQ3MjIzWk9LVGF4Y01IQy9UTDB1?=
 =?utf-8?B?ZUE4TUg2OENzbWlER1RZNjQ4dlpHT2hsTnpwdndyUHQ3c0R2MFE3MzFieThh?=
 =?utf-8?B?d3lUNmt1UFBmc3dxbWxiRXBHL2NxRlBWMzEzMmdTbjdCQ3p2UVJsZHphVVp5?=
 =?utf-8?B?QmhzWlJoR0gzdm84NlpLS2ltZXNSREpoR1RzUDFFZXIrSWdjVXNianVxWjhh?=
 =?utf-8?B?a084OWVXR1AzZWxiaUtERmlibHFwcGxBTm1Ebk5zSlRCSGQ2azVQMFF0K0xZ?=
 =?utf-8?B?ZG9UVTBtTG9LdlEyQjZVeWtacDkydjJQRVc5eGR5V3lOTW1rRitxV2VoU0ZZ?=
 =?utf-8?B?WnRWaWZPcnlkbTdBaklsakswVEZJVG1OTFVGVVJ2MGp1SGo5cFRiajBRcjFI?=
 =?utf-8?Q?Ifvbd/xHsv0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR06MB6808.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(41320700013)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Zi82blBqaXBHZFFCR1VMOVpSMXd6N0s2TStTWUN4cFcreCtNRndnNFhOMGp0?=
 =?utf-8?B?UGtTamNndVRMVHJHSHJlN20zU1pTZjBqVUF1L00xQ084N1lXYkxEeEluY0gx?=
 =?utf-8?B?NFI2WlREL0w3VUJwTkU1cjNWc2xFRUhxMEVVTDFpc0pFRk1CWVZST3Qwd1lh?=
 =?utf-8?B?Uk1DazZKaS9TSmswWm1QTlYySUJZYmVtRVNpNEcxWnd0RXJaUjUvaERza1ZY?=
 =?utf-8?B?c3E0bSszZE5XSXNIOWFmVXNTMmVvUnVnYmY4dkRBSnhnTnVVdUhVZGJmclEz?=
 =?utf-8?B?ZjVEbWFWL2o1YlR0c2YwQTdGeEVzR1JOVEcwQmhYTEVJcHR1QVB4a3Rqb28x?=
 =?utf-8?B?Y09aT0k2WjFncjIzVFlaR2kxSXhmQnM2VFB1bWlQeDM4UzJRSHJKL2tOZm1r?=
 =?utf-8?B?bXRQQkd0a3FnbUQwUEcvWHQxSHMvQlBPWGJ1WXE0TTJxNk5ZYmFld1hBelh0?=
 =?utf-8?B?RHJxVUNsS1JwaGxsZk0rYTg3bm5rTVFhVnl3N01ZRmpRVERXekxmU1hMaEtW?=
 =?utf-8?B?ZzRpbTEyRDg0QytvaVl4dDlFMytoSUZwMEZVRVN2OTBHakxXcXQwZ1YxYXZS?=
 =?utf-8?B?Z2lDSHBhNENFVUtNQTJEcGdsSkpLTUhWYlMzSy9KRzZCQStMRzZMcGdUTGI4?=
 =?utf-8?B?YUgxUGtTbFZRQ2QvSUJrN2dBQU43Zk1MY3NkU2x3MlNyR200TUdlMHR3R0Zr?=
 =?utf-8?B?OGsxUjBkR203ZjVYTXd0Y1JLdllWTGl0QnllQldHTDVzN1hDMEpMRDQyNGRO?=
 =?utf-8?B?RTBTbDlOK1VKWnZCSCtoVXdZTTlKOEFnRXVZb2h0QnV5UlBwUDQrYVA3dkVn?=
 =?utf-8?B?TkhXRGVsejFtREw2TmZ6ampvR3laaklRS25yOVYrNXBEc2xPMzRUSFBmaFh5?=
 =?utf-8?B?R2wrNjNTczRKTlJqeFNWdFRPRXNQbU9iL0djOVNHMW9scms1TytBYWlHa0hi?=
 =?utf-8?B?anpmSFp5bm5TUmQvQ2NoUEVYS2ZMVjlBdUVOcnhNSTA5aXBYUWNWOGROYlIv?=
 =?utf-8?B?WG92OWtWL0k0RnVNY2M4QVplRkEwaHQ1TEc2aENkVmhFUmNHcFI4THcyNkg2?=
 =?utf-8?B?U1p5L3BsY0Iwd1ZPRlpBQmhCV04yZUI4MlhVcUFxZk9yWnNCYy9uRDdjeWlu?=
 =?utf-8?B?U3E2RjFHbW9zMEo1RWlJNXpkWVVHYk9RcGJGV2kyS2RnbHdnR3VKYjdONTFw?=
 =?utf-8?B?N2ErbEU3YW1LZXo3b1RvbzkvZDA1NG5GMHhYQ0gwZWx2QUk4eEtTMittRmsw?=
 =?utf-8?B?dkVtb1RybGtZZmpUL0gvWXl6OHFwMXRjMTFERk8vSTZ5UkpBaWFhSHhiSHFn?=
 =?utf-8?B?aDJMUmtvbVdBcVhhMXZNUTRxSStpK2NlM2ozSVFnWFY1WXJ5djN3QTJCeWs1?=
 =?utf-8?B?bXU0UE5Qak4ySFo2OGFZeDQzQzhYdk1XK1FiZEhIOTlLdzRlREMydjVYL25Y?=
 =?utf-8?B?WGcxSm9iaXV5WVIrREtpRHU4S0R5ekdYY2tTNXJ2cUFXYUwyM0JCZEUramly?=
 =?utf-8?B?OVo5K0ZQck45Y0sxVXByK01iTFdYUXhMM0F0VWxaTEYzSFB0aW5vdk84WWcw?=
 =?utf-8?B?Slo3bGNNbFh0R3pTdkFJeDVrZVE0UU5NV3JQT2FIei9ZVlRHcFUxb3ZzZHAx?=
 =?utf-8?B?VWV0WmJUMklhTnNOdzYrb3dnMXArQkVldld4R25KK2N2TGhOYnhxYWY3UTNl?=
 =?utf-8?B?cFpieUpJenFob1BXUFF1L01BZE5EWG9BMzZZbmVDMFJPaUI2dVlxRC9nRHlt?=
 =?utf-8?B?MGRqTUFoa05BbC84UXA2ZnBYNzdNemFQSzlDNjd6YngvYWFwZStYekoybnBO?=
 =?utf-8?B?TTZBQi8rdnF1b1lkRXFDalZadlA0T1ZPbDJ4VnZQQzRoYVpudDRBb1RBeGp5?=
 =?utf-8?B?cDRGdXlnUi9PNXVnVDdpQzkvTmNJMy82dUZVWXlSMUkvWWdWOUxJZnU1VjZW?=
 =?utf-8?B?R2Z3cXk3aGxWWjgzbVFqZW5La0FhTTlxQS9NYWZYQVlRYitnbWU4Rm9hRlY0?=
 =?utf-8?B?ZnJOV1NmWHUxWm9uSStMVmtMQ3cvc1NnbHdpSnhRNkRYWGN1L0FxWDE5Rk9Q?=
 =?utf-8?B?aEpTR1JIbVl2ZFZlODFDOUNndi9xSi9jNDk2MGhPaWVzdlJMWUNzL2E3a2J4?=
 =?utf-8?Q?nF40=3D?=
X-OriginatorOrg: cs.wisc.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 696685e2-8364-4cbc-b184-08dd7de393cd
X-MS-Exchange-CrossTenant-AuthSource: DS7PR06MB6808.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 19:10:54.8876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2ca68321-0eda-4908-88b2-424a8cb4b0f9
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /uUAIFm2X+aQ1oWSJOnUq5NCxqlzWopIyiwpHcDvLPFBlrSd4MFBPTzeliq8Gk0xpZEjMvUvaoCN+HgqP4cqPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR06MB7302
X-Proofpoint-ORIG-GUID: 5BoO2LERTgL9rG--mGfM8NAjE3BfHE56
X-Authority-Analysis: v=2.4 cv=Nu/Rc9dJ c=1 sm=1 tr=0 ts=68015240 cx=c_pps a=djVjp5eVWc/OO4qUaLGr8w==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=XR8D0OoHHMoA:10 a=3-xYBkHg-QkA:10 a=wlpZQ0607Aa1vfJP9VsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 5BoO2LERTgL9rG--mGfM8NAjE3BfHE56
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_06,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=662
 adultscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 phishscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504170140


On 4/10/25 2:05 PM, Steven Rostedt wrote:
> I think the best thing to do is to add trace events in all areas that enter
> and exit the kernel normally (where noinstr is turned off). There's already
> one for page faults on entry. It's been on my todo list to add one for page
> fault exit (as I do care for how long they last.
> 
> I believe the irq vectors also have entry and exits trace events.
> 
> What else is missing?
> 
> -- Steve

Just found out that the exit tracepoints for syscalls aren't always
exactly preceding the exit to userspace. The kernel can still spend
quite some time in task_work_run after the tracepoints are triggered.
Has that bothered you before?

--
Junxuan
