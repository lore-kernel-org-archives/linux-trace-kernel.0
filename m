Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB853A6EFC;
	Tue,  2 Jun 2026 23:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780444471; cv=fail; b=NNIl0Rg0f2RhPxyg4wHoNx4OCLJrdbHBoeRSgr8ULSRFnQHQJqT1GC89THDWG3XUC/vWExQdXuwxPlIw1AZtXjTVIyN5YOC8OX29LY6rFodWlOLklRof1/H1iAFmxohpJiqEuXabDWMAXYRcZ4h8LsXov/L0TLNaai3vz+NmFoA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780444471; c=relaxed/simple;
	bh=3+smPtJxKfsqB5xCSTvYMni9q3O8+qs0JolP2hO5H30=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=G4WnEIXQ2ZDG5vDRfcd+vNji9wbVg0Hq0xOB7E7O6HIfchgYXoROLPjQ0gGHnYwLv5C+eJdhvg03FQ1UMmwQZNSTZntCKSCsHNRpEUj7AXXFw1xpsFNBHCxFYTkYdejMROusfaE9EJdQo8x9liYBV5kLOmBDgKU/9q10/YodvGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HddglYrZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Z8MJziWM; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HddglYrZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Z8MJziWM"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 652Nedtm071504;
	Tue, 2 Jun 2026 23:53:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=PJWl35vAIJ7G/+z4bZdukUMXOrom+HnAhpUJCyzjNLI=; b=
	HddglYrZ/quL0NPgq2b2UCWP0YVZk6a8n/Tmsh8kSx9wLdHJMOf/ALMs9LC5al9K
	Jccfepg8J/P95/t+eN5HfIN/9/YQ4i8g2j6BqQOHcUQPD/pp9I/Pg+YoKELlhA3v
	JcG4Ms60uS3BZP2meHm0zEVm4cthjfUnX0e4NL+jMDm63/5sBUH74itl5Meut0PH
	siqGvD+Tzb6XxXHXfrJGTotinxyBkg6y0e/0m4zlxDhGN7lyDoG2MlaO08Dynl4S
	P28ATGxKS5ypH5OE0v/Pg3DPSz1mDdltJR1GKCyjh5xLwESHlQH0IFbxmBXml1Ju
	OQtgLhCDn78pwPgZQOMc9Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4efpp1w71t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Jun 2026 23:53:57 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 652NjQpx004172;
	Tue, 2 Jun 2026 23:53:57 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011032.outbound.protection.outlook.com [52.101.62.32])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4efpbranc1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Jun 2026 23:53:57 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F0YEgFjak4F7dP/xOw1CTIjs9FR+GuVLk/AoOT33Z0k3nUP/wLVGAZVVO876HiRiSKCTCLhiaYf3bYg1NXyL//ToFckUM+W0lNKNz6zRGaYNZjPo8XGtt/wLeWXoZVpyKdED1G/r+pGdWGLcy79N89Prly1ir9vQkEd7tee09d9LLxlxp9hj44FM02l78B83w/RTUQ641VQCUVMVatYs8QfgkEbNf/TDdNy2TORezgZXhqUQJbGYW9dPyDwz7Sz3dpD4YMrF7CB+2CYRqsAHrio2wFEXbc8w/LndHBTT9vMsSgMt8sTIk9FzK5jUsravRlBeqAtFPx64PvpZlbeVxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PJWl35vAIJ7G/+z4bZdukUMXOrom+HnAhpUJCyzjNLI=;
 b=wbKn1LMPp7wguN0MQKBYciJOSefY6Si9lgEMtB3yPKPDBulUlEdOte2GrjJ/JjS3OEHNtf/MM8IYk0/z2rzJIzUPZW6YjGOitV7BMbUujs8axTQvDnjj2AlNeqIbDUIN0ce7LlKrp36CCx1ZFWa0OC9xFXNSapM7AKLy7XNUNciVylR11BZfiO3cGRzkK3prxarUgUCX6yYNBK1Qh7FMgr2jgdjEYdSda/fnWL9eIq/StVvanGDBp+93ygrDzUQiQTs7ctCuMuQ0ifxTIwU9kroV4+xfJWITvr3uYO+eWIgH9xBjva0yWaCov4eVMj+kmE2tf/sd85rIZf9hR6LnrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PJWl35vAIJ7G/+z4bZdukUMXOrom+HnAhpUJCyzjNLI=;
 b=Z8MJziWMyi4CWB6SRwFYAmeYiRYpoqyu7ZZXrr16+73tzFs49ErFKnmrj1vkG3/Lq43XdasjhbCthjBUy1xGESK1TAQPJr3H4XCluXvj4tzTH4QaFHl/IZnk5kURKsIjX+GvZuXe7fDICBlhWZxonoVaFHUqX2jAMIUhRcdDtzg=
Received: from LV3PR10MB7796.namprd10.prod.outlook.com (2603:10b6:408:1ae::6)
 by BLAPR10MB5202.namprd10.prod.outlook.com (2603:10b6:208:306::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Tue, 2 Jun 2026
 23:53:54 +0000
Received: from LV3PR10MB7796.namprd10.prod.outlook.com
 ([fe80::a30e:ee88:c7b4:c0d8]) by LV3PR10MB7796.namprd10.prod.outlook.com
 ([fe80::a30e:ee88:c7b4:c0d8%4]) with mapi id 15.21.0071.015; Tue, 2 Jun 2026
 23:53:53 +0000
Message-ID: <6375d169-6f5d-4b39-906d-e7f29fa90ba4@oracle.com>
Date: Tue, 2 Jun 2026 16:53:51 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tracing/events: Expand ring buffer for in-kernel event
 enables
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20260601233716.2517987-1-manjunath.b.patil@oracle.com>
 <20260602090025.06ae761f@gandalf.local.home>
Content-Language: en-US
From: manjunath.b.patil@oracle.com
In-Reply-To: <20260602090025.06ae761f@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7PR02CA0011.namprd02.prod.outlook.com
 (2603:10b6:510:33d::8) To LV3PR10MB7796.namprd10.prod.outlook.com
 (2603:10b6:408:1ae::6)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR10MB7796:EE_|BLAPR10MB5202:EE_
X-MS-Office365-Filtering-Correlation-Id: dee7d659-a344-4927-5d16-08dec10233cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|22082099003|18002099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	kfny/aS3nqooiSkWSSNvH/u6xromh2AsJ+j5Pkst5Z6kuJfgrFa5Ry9D5jUiEmTDdg0U+JpmhA8qB/j+AWlZuCaCwb7WncIvKbJ0vx1MRCKsRK72aA6Gs+TpInTmlXSWXBxGSRByul28KypVFsHbH18eQFp79yLJtJ63CKkROLQITOH9ttNr6E8ZSGCbUAzhSux7p9v+fayQ5ZnzTwDTQs7q69IbzAKsNXjBow5UYXGmqj/roQWZdil8HEpnESIoZ6W/41y8EzyjLZOSLKXGaddLkfQHnGJDYGqtOMvXzZF+G6tgyqTKfuhm1Vo8KyNI0ecxWzvkNVN66rhNfDePvg6sR9Dv/ykLWrSSx+zearJI/koqcObC3Bg7Y1xEq4HLDzuKtuj/8lA0mfXg9lHIymr78K9xfpgKM2yHvuOG+0ShtFbef6ieSHxlHe3j+jt54GGZvLWDfJ1Xa4+4gz+H+qCmVhdt9BFDSIeqBwhhtrhi/GQ+tbZmWnDwcWx6hCa3laC8xr+H5fucfBah64G7btIyrdqZiErbofEZwRdGmoj1OFqScfKJqUFG0/qNDKjaQt7UzPsFZk/KZ7TugC85XAR5nlcqxncBLIz7bL94ZTO/pY5GXQDdFBQ41adIlQ3FrP911E8lSPwwaWhiWV2eu9UmHaOQAsThD5mEOfoNuDqb/wjVzyfoZhDKYjjk3L1Y
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR10MB7796.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(18002099003)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Uk1hWEZoZ3RPZlZpZTBKL0FwcFV2dUdnbFVjNGhPSU9pTk92dFRaTlRVTkEw?=
 =?utf-8?B?cnh2dCsxRXFwdVZXM2huVlNCQzhsR1BSZmVYdnYrZ0tzdUkwTGowT215M2lI?=
 =?utf-8?B?MnpBK0tMbXdGazFFMVdLb1l5MXRtaWhhR1RWT0ZVNDEzZzZtWEkwWEp4aDZq?=
 =?utf-8?B?MWpDZDZVaWg4bk5ROXhrZkozYkhyN1ZjaXc4R3dvSkFRVHFGdlRlYXJuL3Z2?=
 =?utf-8?B?a2gzYlJVR3RXOGVFNit0bDJKbXpSRER6V2VsSVhQSTVGeWFGUnB3S2J2REFo?=
 =?utf-8?B?NHFKa01TY01SSW9VVm9nU1dhNGswaFQvUEJEa2FvYm56VFpjdzltczRncmdz?=
 =?utf-8?B?dW1MNCttdFVzUFlwNGo1c1NwcjNtT2Z0RE5Eb25VRHpSQUpTWG56dWt4YW1s?=
 =?utf-8?B?dXEreUJQeHlycUNYUWN4azlHYWZxMm5qVW9oY2hYZVRXOW00WXE2VGdaYWdX?=
 =?utf-8?B?bHdpUjBZRFZ6ZC9VUGRMN1Z0UkcxYW0vNVV5Z3Z1NlBSaGsrbUtNTDAyTmJ4?=
 =?utf-8?B?MXhzWDZZVHh6cXNsNUhyeWNybzE5QTM4SUNISUVkcEdBZTU4aEM2Mm5LWFQ1?=
 =?utf-8?B?T2FnS3NPcHVYQ2RmdDZlMTRHRHEvTWRzcjdvL1dSM0pZSXBwbUw0Q2xXTVlI?=
 =?utf-8?B?bnluOG53aEtad2hXd1FUWGlLbEVoZGZ3clZYYUlCekhLRjlGSTRKcTZWQ0ln?=
 =?utf-8?B?YzlpVjZ0S0JGbkpZN2R1OFkyQytZOFlsaUVzSHlrWm5MaGMyWGhMOTZ3VVRa?=
 =?utf-8?B?N2JlMk1QRHNuMllyNHkxYzhYcEh5Wk5sbXBPa2YwZEQzSWR6blZvK3M4QXE0?=
 =?utf-8?B?QnUrdGU4SG5LYTVvUzU5V05pTGVPL05FQVUrSUdDVlNNbzFtZUJuM1ZNNE9F?=
 =?utf-8?B?U241eXJqR3N0VVNKNUZtOE9URTFWTFF6eUpUV09PY3VOTU9hTHZ5VnIvYlI3?=
 =?utf-8?B?a2gzK2lja2FsY0pLRUpqZnBSNzlQRGNUNWQya0NHMUZDVmJTRGxWQlRPK3Rj?=
 =?utf-8?B?aUJGRW5GL0g2SUdhZThUVkxEbzlyR2xkQnlEL3FCZUY5amxjME50amxkZjhh?=
 =?utf-8?B?ZjQ0MmtRYlA3a3NDRWh5SVkxcEE4K0ZERklmWEhybSt3WE1LazJlcjBuTit2?=
 =?utf-8?B?T3NlYXpmMGpMR0tmWnhtZ3l4b0RlMit1NXpIU3lWVXNNRGtUU080Zm91M3A4?=
 =?utf-8?B?eEJ4Vk9rZTdQYWU4WHZDRGtFZ3FQQXVHSUVObjZTa1Jod3JxeU9udWkzeENj?=
 =?utf-8?B?Y1JldHJxc3pCN1Q1UncwcjJjRmZWRWhrTm9kVUhrNWdsY3hZSGw1b2RtRUhx?=
 =?utf-8?B?ckRFSlc3Y0J3TEREZzY5WUFuemllMzlKM0MzR00rYVFyV05OU09UYndYLy9Q?=
 =?utf-8?B?WnQyVVQvMVkzeUI1OUdIK2pjRmZxa29GdWpUZWRucjdUKzBOdURzd1hSOHRY?=
 =?utf-8?B?bHd5Z1lxZ2NvUFdLMU9Ud0xBTllrdW5pRXBvd2RXV0d5Y1l1WThob0hDUnNU?=
 =?utf-8?B?SDEzLzMxeFdtM1dUSkFMVFdEbU1WUUJ2WlN5MkNOd1l0SkFZaSs2T3p3STFz?=
 =?utf-8?B?RnEwc3VSRjdXbnNKTGN0RXJ3MFlCNlMyNjBJUDhqMnFwVmJCRitsdnNDeWpZ?=
 =?utf-8?B?Z0NiUHRJVU5nbDVIT3pIbmhlMkEyUTdLMEYzMGpOYUdhRlFSdDBKUGZBNmRz?=
 =?utf-8?B?QmtZT2tYTXAvMk9WaXNacFBLSk9yc3ZKb3EwUmVSMGVMZmJJZUdXdzF6QkNu?=
 =?utf-8?B?aUtlM2xqYXJPRjh3aUt0R2VpR3JOeHRNbzc2N2Z2QjlIdm05VGtTSEpBWDZv?=
 =?utf-8?B?ampwb1JudDREanhwZ1JVQ1RlV2NOd2F3UnlHQk9qTGJ1dSt5SFZpS1FSdzBU?=
 =?utf-8?B?dzhzM2hUZFlIdnF6NkdWQVlMWlhqTDRJdWNlVjJVdmt3U0RVQW40Zi9NMEtS?=
 =?utf-8?B?aVlFdkhRcXVRZG9qd2xEbjhyZDFDSHExOEZNelFoTCs3S1hnbElDcG5NeTdH?=
 =?utf-8?B?MjQ5S0xSRWtQaUl0VUVaTWRQc0RiU2ZGelJ3cm9oRURqZlNpeWdxbEFkNlpP?=
 =?utf-8?B?MGVXOFZQdkJWYlVJNktXaGtwVkdFZ2E1TXA2Qzhzb2NJVWJFcUxncUg4VmJK?=
 =?utf-8?B?UVJxa1RaWVA0ZlllcXNzU215Q1p5L1k3SGgyTis0WnA4alhDQVg2UDhHY1Ir?=
 =?utf-8?B?QjN1NnVIZ3RMa2MycExFWlpCRTdhZjRPcTdtOXVBOEdTM3J5MENaa2F5U1l1?=
 =?utf-8?B?bmdkYXVtaGhQUkhZd2hCa3cwbkg1YUpKcHpCTzJldGRJeGVrVTN2RkJ1THAz?=
 =?utf-8?B?TWIzUVJEczV2RnIxaVNkVkViSldLSm9QZUpwR2RGVUxvOTBycmJSYTkzeG1E?=
 =?utf-8?Q?4LkUqAKpox73eDY8=3D?=
X-Exchange-RoutingPolicyChecked:
	eZLR+FS4HeqJ4oSg7qYSuMNjeJaD3zm75m7vN0Xa/umVQaJ5TifHJC41mVlleb6iM9NKSON2CUh49FXHlXf1w5pHS3n7a8kOUZ7OaAUUGgfxDimaN3MM1tQDQNjnYTudMepavvPw4hyJqmRSBTKXUUCqdGbjwYaB3880CIVuJumVOBEL1YWN5Z2FQHKKNV9QZHELehc1rtgB/4oRAth0+iWzwDTO60rUHVVrI9n0z1SiHxUTnvF/PCmeuKNjZSHm9/3bqo0ud/5qrfO06d9kNtSGM3iPlAz4Xicp3uZe9qzaj56STE/vsQp6Y0DO5R3mqN8Mu3tsGNqqMorTZ/bz8Q==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kpYMp0GYr7XmI6o1M0UXiIWlVT0pgBJyfzQ5duF4NkBqxzWQb6Kfmj0kNMdzvzUqt+8xZhUPvYU+VH7HurJoy1Zy4A8NZi9mjoZarSXmZ64TnCn+y3DZGGwDbILpP+8Cg5mQ3RVCuHBuIdWNKREXx4A9oFQ+DoewEdKMV2nB4jiUZqMZ0dnAmI9FWNZABBqNAGsJKKttEJ2RoqK26imBfQJvncZkufiSu1IvFDvR4DVVTd+jh3W5IAxLKTYGVaQeCc6EOrZc0uRej5VHH0eqdCq6T9LI0yaYQPJlbJ3Fo710N6wZfFffx+CVmEZ+LxActgla/HQqviqcQ1NxXH3RZUaFlRsNp0btoDNaR5CSP1pvqKsCXXd75jIu7FFY8U4jbKv5vR2RLDDUYsYMq8VLH/VQC+T+qOxuvKMjJKMlX690nj+Q9WTbu1ypi32q5gJ0hFmaGUgefwrBzzy8GKD00xgcgFRTLeDO3esz5EwLNuIg02hV9FuQlV9l+w8c6ouhAcgcSWjaK5YF1zARSyAY0RiTcpPfubXXQboDuqDXXGJ1PtDjNdFfKj9IEkmQNPvCoUF/ouk9ayiGyEK4tXA++7JLwspVvlpJ6EEnpO/Kd5o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dee7d659-a344-4927-5d16-08dec10233cd
X-MS-Exchange-CrossTenant-AuthSource: LV3PR10MB7796.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 23:53:53.8556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d0qFAPcJcEahDMfsYytK3gwAPy5JyrGi3Dg9zmBwnGfMNG0qRO5yUDHFxdGCBVrnHXxH3o3gdac9gxttn6PJcyouUDJRr4vh/wJn4wqtyuI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5202
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-02_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 malwarescore=0 spamscore=0 adultscore=0 suspectscore=0
 mlxlogscore=999 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2605130000 definitions=main-2606020231
X-Proofpoint-GUID: 3cuu95tTa_IC_GTBUTj_I4Dn9-2wzfGJ
X-Authority-Analysis: v=2.4 cv=BMWDalQG c=1 sm=1 tr=0 ts=6a1f6d16 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=o5oIOnhZENCTenyL_yNV:22 a=yPCof4ZbAAAA:8
 a=F5PHqeFzMMdEO5CUhV0A:9 a=QEXdDO2ut3YA:10 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12302
X-Proofpoint-ORIG-GUID: 3cuu95tTa_IC_GTBUTj_I4Dn9-2wzfGJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDIzMyBTYWx0ZWRfX3Pr2iYsRf3zU
 GcOcTCnTCeWjIc0gADd1RnAS6ISd4KccarcDhTmMRx96Z1tBObRn3WTOB7jvHENF8f9DuDTwgQz
 F4H1r8uyxJ8Gs6wemB+xcnJpm6ebstxClMVHJx5juVqQYJtgQi1ZAHBcHdl6xpVG2cliX//M3ed
 voL7/0pDF2qnBq23TPtmDwuc9Ypi9aNhrHzpZf01YAgpcYOIyRffla+0Hvsp14y9QN3Zj8MOntN
 YkrjCC+qI7TrcHR3nXEqX7/rCVkA27x/yWdMGQWmOCJ2QeRNMMmzYpDC+cSm2brE9cgoO8ZGe1E
 /HhxtU7akepUnMm5NicKHqcSm6zCPEqrqkXtyVJyC2cF3I8Gvf7XwEoMuBcmx+6NDtejQjoObsA
 bCaFrd6JtE9LYApXqRTU10XNPS6Tm26wgAQevVIlyjaacUWrbj6R93JOA/lrPxYH8VHhyUAG4iU
 ng9uiJ3Fcz0i7GfN4q6wubUd0Bdjj1M9DVRe43Cs=


On 6/2/26 6:00 AM, Steven Rostedt wrote:
> On Mon,  1 Jun 2026 16:24:43 -0700
> Manjunath Patil <manjunath.b.patil@oracle.com> wrote:
> 
>> Ftrace keeps trace arrays at a boot-minimum ring-buffer size until
>> tracing is used. Tracefs event-enable paths already call
>> tracing_update_buffers() before enabling events, but the exported
>> in-kernel helpers trace_set_clr_event() and trace_array_set_clr_event()
>> directly enable events through __ftrace_set_clr_event().
>>
>> This can leave events enabled by in-kernel users recording into the tiny
>> boot-minimum buffer instead of the configured default-sized buffer. Any
>> caller that enables events through these exported helpers observes
>> different buffer-expansion behavior than a userspace tracefs event enable.
>>
>> Expand the relevant trace array before enabling events through the
>> exported in-kernel helpers, matching the tracefs event-enable behavior.
>> Disabling events remains unchanged.
> 
> The above explains everything correctly, but you left out what needs this?
> 
> Internal code should not be using the main ring buffer except for
> debugging, in which case you can use trace_printk(), which will cause the
> tracing buffers to be expanded by default.
> 
> Other areas of the kernel should create their own trace array which will be
> created expanded by default too.
> 
> -- Steve


Thanks Steve, that makes sense.

The concrete case I was trying to address is not an upstream in-tree 
user. It is a downstream UEK RDS compatibility path where the legacy 
  
             rds_rt_debug_bitmap module parameter is mapped to RDS 
tracepoints by calling trace_set_clr_event() against the global trace 
array during module init. That can leave the default RDS tracepoints 
recording into the boot-minimum buffer unless userspace expands tracing 
first.

Looking at mainline again, trace-array users are already created 
expanded by default, and the remaining global-buffer use is 
debugging-style. So I agree this generic tracing/events change does not 
have a good upstream justification.

Please drop this patch. We will handle the downstream RDS compatibility 
case downstream, or move it to an explicit userspace/trace-array setup.

Thanks,
Manjunath

