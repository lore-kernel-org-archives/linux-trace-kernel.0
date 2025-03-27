Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F99915A87C;
	Thu, 27 Mar 2025 18:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743100360; cv=fail; b=XsO6/2kSdnRGLUvHsK/JKOJIH5yI7JwuoPd+TLLewiuzZBAGcnxTO8fiE45vJ71F8F8i+ynPmlftPIQQv7kU8C+4cf8juiceXdvIABsA9U52SJC3wimKOdoNsIvCT4zoFFVi4scIm8dpHTvEtz9CoaPDY7ElG3jCdrcQQcdgNN8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743100360; c=relaxed/simple;
	bh=Eiik+S2CXLsMyhGcx1Ql5UeyiruAUeOtuNDvGZfIdMs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RX2dVFHWWArarwhZdTXV7PLyED2i8HfiuFmi9Klop2sjC64yq81nmP4GqSwH9BvDtWFb6+WfcvGAVF45G/NshKl4MNAfKV75jSzzDilkBhZ6DCfe1uclC5mxBdPsI8j83o005W6a5JF21MjWHsljDAxOHIZHRgRbRSRjx3+LZU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=I3RRmM2f; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XUtXQKGz; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="I3RRmM2f";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XUtXQKGz"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52RIBu3h018288;
	Thu, 27 Mar 2025 18:32:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=/X4RSU8kR/i8BFbh/H4eAht3tusxv3rfZ0pZ3mBIeCA=; b=
	I3RRmM2fpf54mwWPI7oZZQtkeXjNN8BN+JkHCT5H00FOAhFqZXzNLZgRTJx7CdBh
	ZmeIqKYLuyZA+KvAnieeTEIOT2xuA+e7YSikHIia89m8dZduZXexErQg9czFAM2M
	c3vPG8o9Y1oPdcyPNXBdROM+G9rOEwt/JTybxkA9usATOuq5kG9uEZPEw/gLnei2
	iORew2gQDw7p5dQZLPi+Ii45VBVxiy5T/lFdddH/GEUh9lFsqUVGYpfzao7yP2IZ
	Dxnp9PM2lc/5hKLdqUj304YVeOOFvmx4U87CatAfmAlj5qQrHDbd2nR+hvJDvehf
	RjhFfRXy/vf9arO7DoGPJA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45hn7dwe70-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Mar 2025 18:32:30 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52RHANRE015110;
	Thu, 27 Mar 2025 18:32:29 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2040.outbound.protection.outlook.com [104.47.55.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45jj9591jr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Mar 2025 18:32:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cgjEtyMUUqGneu3ReiOtbl6IbqmzQSkE49+QggbXAxrmvz5diwRUYmWl867be13jNkjGqC/QdoXTtxW6/3SLAZdsTXQyOgRaB+s9ek6tT2azIo3+XT2UcbPgIE5YeilhgWtGC2WSVP9kEHBdWBpgvcLdkGMRfXWJVM2f1bmysBcjtDL90daP5yWXPyE26sJEtxHU99IldNzxhvSdaxYtmtbKBdiWWXCuun5bP0zHa8aphOgcXUGb3jw6uFRR0gEoxxHUhLuuakorksEVEKYKfwDTgi2C8ZhFymSrADpJSsMK1CHnDYEx26aH6FB96YHGn1C6In0OMTzfwgE/Ubwjfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/X4RSU8kR/i8BFbh/H4eAht3tusxv3rfZ0pZ3mBIeCA=;
 b=rgZUiQNZAT/Cjyr7OGnLb5UzbmF3bRLoBKV+5KuL3d3bduuzu3bjGe12LHIwyHbI5kYYGtb2AihD4SCYURhr6ea6FsejknBWuXRkpvOkc7w1svFvX3ep/aJS9StIUGSrmU54aioVE2l7dK9Sdx3KAoC8xhxnu3SDVi//p83Oci3b4BfTxjBSI+f7uXHulCvAl47ws6Te6qknhcEuOdAbVPxzGuj+TdiU7YFKEUBaDDRqiXmdFwRiJYoguX4hyIxHNUDnZe6EnkAQeya0EQXNQ+dh9LELhZr+4ARYh8+Nz8IoGC+zVebFLDZZRxZmfwUn8ydSV2cKrp/JDTJu3I+4HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/X4RSU8kR/i8BFbh/H4eAht3tusxv3rfZ0pZ3mBIeCA=;
 b=XUtXQKGzR6xy+fJlRYGJhz/3ed/Dva4z3cEVhZFes1YqOT4/nBxDl81YYW15ccIbdZa3ICjMVQ3u8Xq+TYin+PsRBH68yezGULQjGMv8iQr8/aIqJAPlTxbRRJSRgp/WkZ0cRXb5DAjXePSbgvpXD2HITxxKFYvaNUgc0C0QNfU=
Received: from MW4PR10MB5749.namprd10.prod.outlook.com (2603:10b6:303:184::12)
 by DM4PR10MB6062.namprd10.prod.outlook.com (2603:10b6:8:b7::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.44; Thu, 27 Mar 2025 18:32:25 +0000
Received: from MW4PR10MB5749.namprd10.prod.outlook.com
 ([fe80::9a04:a919:657a:7454]) by MW4PR10MB5749.namprd10.prod.outlook.com
 ([fe80::9a04:a919:657a:7454%3]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 18:32:25 +0000
Message-ID: <856e7f9f-2a7f-4b94-b6b9-c1f7151a1f7b@oracle.com>
Date: Thu, 27 Mar 2025 11:32:23 -0700
User-Agent: Betterbird (macOS/Intel)
Subject: Re: [PATCH] tracing: Verify event formats that have "%*p.."
To: Steven Rostedt <rostedt@goodmis.org>, LKML
 <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
References: <20250327114911.2c713511@gandalf.local.home>
Content-Language: en-US
From: Libo Chen <libo.chen@oracle.com>
In-Reply-To: <20250327114911.2c713511@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0013.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::18) To MW4PR10MB5749.namprd10.prod.outlook.com
 (2603:10b6:303:184::12)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB5749:EE_|DM4PR10MB6062:EE_
X-MS-Office365-Filtering-Correlation-Id: ad7a0c2d-428e-4952-b6aa-08dd6d5db8d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VzEwb1Y0eHRYZHdoNDl6Q3ZaUXRwaDAvaDgraGthNktUTG5sT0tKUkg4NGx3?=
 =?utf-8?B?akd3YlpxWVd4b1RoRjNQdGtUaG4yYlU4YzEzNW1jK3RHZzNnTVAraG5NcWE5?=
 =?utf-8?B?YU8wRlJvczIvTGxWQ2NmUVROYzdjS20vRjZBUHNpaGZOcG5jNUhvM2c4SENx?=
 =?utf-8?B?WW45dHhPak9HK252SHNaR09hODJ3Wk1RcDlaQmtPM2w3Mnk1aVFHSlZkZDRB?=
 =?utf-8?B?M1pRTEhqT0tDZml0QWlxdm9aODB5TWFsY2NJdEJ5RmZJTjI3NUJCeENidytT?=
 =?utf-8?B?WDlGa0VMRnB6Rmx6aUVBcjNBNWxmYThaMm1laWwyYTMxYUI3c1J0dUxDdzVG?=
 =?utf-8?B?NW8zZkFwMkVGcUxSMkFyUkVNUFRlNGU1Y3p3SVd1MVZ6ME92N24yb0pUdlMv?=
 =?utf-8?B?anB6R1o1aHh5eUdUS1FWV1NsV2dOaXFvRGdMR2hOb1BqRTA2eVhWbG9QVmow?=
 =?utf-8?B?blo5c0RRMmM2N3R3UkZUTGN4QXc3RTRuRUllV3lQeVZWMDdUTENqM1NpUGdB?=
 =?utf-8?B?TUNYbU5tZEc3Vkx1VnV2ZDh3eVhPZHlkS3drOFBRWHJWVUZHSVF1ZmRoK05Z?=
 =?utf-8?B?YXd6MTgyU281VlpYUTBWeE9iN3d0SnpyUHVTV2VYMEYrQ1hwUzF3TGk4ZitS?=
 =?utf-8?B?M3Z4eGJmdTFUeEpiK2I0TjlyRE9BcXh3RzhaZGxOR3h0SHphNHFHcmp5b0p1?=
 =?utf-8?B?dEtCSGRML01GUzBFTFJmWCs5NVNZTUNxdy9ucytNbHd3NGt5c0F6VWpqYStx?=
 =?utf-8?B?ZzFYdVNMUkJFWFJBblRJMWxsSVVUMFJUSXptUVorcmxpT2Y2ejVzb0ovUkhL?=
 =?utf-8?B?Rmk5c0VoNFRZWVhxdU1XVlEzY016SG1LOFphSjNKRm0rYWZDbWx5dDdxbzVC?=
 =?utf-8?B?NmxYSTg5ZDB1YW9qMWNmNGV2UjFrMUMveEwyQ3R3WWJoZDdoTUVCaHpWaXpz?=
 =?utf-8?B?OHhoMDh6OW9HU1VzTEhZNDRFelJ6WEREZE0xS0diZ2FEaWNmSUdQQ2h1Zmsv?=
 =?utf-8?B?MGNRdVltVUpoZ1N5b0hHNDMrNWNXZ1dWMCs1TUNsOGg5MVhWRlNWViszUmRx?=
 =?utf-8?B?UVlDSElsM3UwWWoyYTNBSytmcElnc0tqRGU5Zm4vOHFpVWQ0d1R1TnpuMTRC?=
 =?utf-8?B?WlVudXN1M0xCb0ZuNkptU0N4ekRtZGJFbEc2UzdXWUdRWlZNQmdvSHdRTEF4?=
 =?utf-8?B?VlVCcFNjMTBPM1NZaVM0OUwzeGphZzNFUVhQRlVkMlpxVFNmQ0svQ3B0YU52?=
 =?utf-8?B?RTlveXFRdWpudzJBUnFwYTVhWlpCTXJIRWVMRGRKV2Jva0hNYTVWN3pyTDFP?=
 =?utf-8?B?bXNpRi9JM3E3SUJrdmdhdE1Nc3lLcmk5S3hsR0xpdjhXQ0d6L05HR2lYK1JR?=
 =?utf-8?B?TnBTdmNvYkpGRk5SNWY1b0RiTzhUVUNESS9jSzlURXVWNCtSR040dG9hWTQw?=
 =?utf-8?B?MXdVQmlVTzA3RENYN3AvY0FqdkNhSXJBZFZHdVlvanpiWWlRb1V5eTMxU2hY?=
 =?utf-8?B?UmF0VFVyd1NvQWwrRVJ6YVdxOVNVZlFKcFdJeWR3OG4zcEVHdFN5SWZWOTIz?=
 =?utf-8?B?OEVxTWYzcEZHWXZ3NGhQOUJPN3VjUFZOT1lpVnNobGtjWndaRkRkd05oMHdr?=
 =?utf-8?B?S1I3UklSQXFNOHB3NXRtSDFZeFZMMDBjWVZ4YVNIWHBOMFM3QzlCaFlFWU1T?=
 =?utf-8?B?QW9FbXFXdkI4NkR5MUI4WUhWd2V2dEJtbU8rMFNNVUhLZGdNY0RreGpJdGJo?=
 =?utf-8?B?VkdOMkg5SDNyVWRtSnBic1hCbHhMbk1NVkpFSXFpcnNQZ3ZhZnZ3V0d2aThh?=
 =?utf-8?B?empCdVNoTnB0L1U4RmRmQ3FrR3BzOGNjSTNtWGw1RW5FUjhranM2UFFmSTdR?=
 =?utf-8?Q?/AgxVzaDtOCob?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR10MB5749.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZjgxNFRqaWVtaEFZeG9DYVp0WXB2dVg3SGNkWEVGSzVZTnI2R2ZybU84eDcz?=
 =?utf-8?B?eHVQVE83dW9rTlFiNzZmcllZT1BGVU1wUWo2RWlFSy9Ga1BSUWhoUmVzMFpx?=
 =?utf-8?B?T0lQTkZmdW1hU3NFYzV1SE8zMUNrU0F5UDJRaWZ1OEs2ejZ3LzFxZTl4Q1dG?=
 =?utf-8?B?ZFd4MkZ5OHFRTVIxVTRDYkxpVWdvUTZmUUgvUnUwMytZaXJIeTJoeitXVDlP?=
 =?utf-8?B?a0ZZbXhuUVhxWXlDOGRLNFJWOERXQjZFSmZIejdKMHNUcDJPUS9sYVl3RjFW?=
 =?utf-8?B?d2szNk8rSGNJZE5RSjBZVjhlUXNjZHFqTFhlOGdGeXJ2d3V0NVp2L090MGN0?=
 =?utf-8?B?cUZwVkpzVGFpOW5Vd2R3SjhhcUdYQTNoeko5QkRBWkhnQlRkYUgveDNvTi8w?=
 =?utf-8?B?c2FZK3dpNXc5RXhKMklhTmN6SzBHaXg3TFFpT0JucmRyZFhNT3N5cFRmYkZZ?=
 =?utf-8?B?SE9CVHhuNTNtUWUxK1o3WXNXQ3FSUUUxNGZBY2F2T0ZzWjBZWi9tK2lPc0J5?=
 =?utf-8?B?QlhsWlo0QTY4NzJqRG04MnNCMDcvZzNCVUR0WkJ2S3BydFlXU0lkUTFhK3Zm?=
 =?utf-8?B?b2ZtOHJ2Tm9nN2hiWEhGZS9DTTV5c3FXVlNtY3ZOcmgrVFZ0OHd0ZG1nTlFC?=
 =?utf-8?B?Lys4OEppRWJ4bW5nQnJlandJb1ppNWhHa21CNTV3d1JTWmhEY1IwQyt4ckxI?=
 =?utf-8?B?aEdaY1VHM1MySGd5WElzVDMzUWNNYzl5WWpydGNhSnhqYTc1WkRvb0p6Vjh3?=
 =?utf-8?B?Z0ZHa0ZVUUtXeTJjb1lpZHl6UklzMjJKSUFaa0FFZ2J5WXp3K1djY0RiK0M0?=
 =?utf-8?B?cHVHTngxcVByUDlPMVlRQTg5YjNJTHpnNDdnS3RvVG9ZVWNxcnFRTTdqM1Fl?=
 =?utf-8?B?UTVBRWtNbmFERlc3T1VBcVdYVG9PNEkzRUVqczJuN1NxZmo1a3NGTjNqM2dq?=
 =?utf-8?B?NzZucytyVmRObXJjNHR3Y2Y5WldIeDNCdjNzUnlLamNJT3pnbW10a2hybVkz?=
 =?utf-8?B?SkQ3bHhUZTVScURGWFJvcFNjTU5Md0RNb0xBYzZ4VUhmV0ZkRHNYcUIvWXBz?=
 =?utf-8?B?ZklkTEJjaExkUW80UmNxRlU3aGNjaXJCL1NvUytsVnRxNFd4d3dybTYvTGJT?=
 =?utf-8?B?UEYycTZsc1l6cWJ0eGxYcVI5eHJtdjNZcmUxdTEyeWVNeFNmek5JOTR0OElP?=
 =?utf-8?B?UGlHVStGVHFhRDFjUGtkTERMdnBETGNRWVQ0SmkwMGkxWTRhUTcyNCs3aXdk?=
 =?utf-8?B?TjBCbU5nSGt6cTNXNlczUDRmY2pOKzIzVURBQUtLTE9NSlpoR1VtT0c5OUdp?=
 =?utf-8?B?SFFpcVNIS2grd2xsNVVjT0h6TkIrOVcvTGQ4R01GWnErTE5JRVNaUytqQzhD?=
 =?utf-8?B?cTNIT2NYNHZQdEJwUDdzb0RKMjNzOEFZcnArWGlUUFJkMncyL1NiTkx0ZlZP?=
 =?utf-8?B?Z3BuOG9hZHl2a21lZnhVTTZ6SUNPRUFzcG5udGRuWVJaS3MwVHE5cksxR1Jo?=
 =?utf-8?B?ZW9UMlRNSjNWaDRoNnNpZ28rQTQvZklkdHV6eHhmazhVTmVYR0VqSUpLZnVk?=
 =?utf-8?B?RndwdzlOamZxMzFZd3NnUWZ2V3JaaGlGU0xXQ1FucERuM3g3clQ0UFpoRTVp?=
 =?utf-8?B?OUIrWWw2T3d6Q21ENjI2OUc4UTI1elZMcXdhQVhwK0tVbWRBM0o0YWpyOVp2?=
 =?utf-8?B?MlVaZ1VrdzczSmZua21uTzJ3bjdiMjdoVk80UkVBdFQ1QWtNTFpvalVnTHpr?=
 =?utf-8?B?dEpJbUFpeDk4M2E3NzFWbWFpK3RVMlJ0MWNYTDUyZnRhQUFoU3NtZmtUZFd4?=
 =?utf-8?B?TlBtNjNTYks4VVhFZjVsaG1yWTh1YUgzS2VoSit1U1ltVkxESklSZ1RaNUI5?=
 =?utf-8?B?ZmxoZzZINHJWa01TdFNid1BRSkJUY2pwZVZMZDVmU2laQ1hscGhMcWdsWDRS?=
 =?utf-8?B?TTNMZFp2YUpMTGpkNG1zVVl3SnB3VCtTc3QwZ3ppWWsvRW50cG1xZ2w0MUFP?=
 =?utf-8?B?UFZhZ3lCZ2o5bDZqRGpKSmxIMDhmYU1aVXZoemhwRFc2S3VVRnpwaUtpR3Bs?=
 =?utf-8?B?dStZRHRDaUJEanZObi9PNWtBa2ZsQjdFbzFHV0hmMDRBdnZvMm5yWUs5ZmlB?=
 =?utf-8?Q?1Swirn0l2XLFww0exxFj3XYIt?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	P36hnDd87fxKr3EskKzkis3Kq/Giz7wph3569FT4th5dFhUmVxXBTBoDJRd4dn/uLJgYSEslIRvxolb5If7z+sM+lAUbp4gv4VLL6HQmknaaQQb/wDxKulxC6BcPYE0rnXGMZC/dZSvNU+FU+agF3h5M7b/ACvfxUN7fodkZfxdgCtLvTga+S6kh1zZJVFG2Uxk2e7w7mL3uVLdQfrTBNrK8BxE4v8xVV/Dzj0Bj0RX9bLwQCGiSLBvsTIrRC5RSnO8lx+WbMv1Xm8azXHhrgpQxmUSSn4KpgneeKm2ZhDlhVaTgX/EBQzTD1SSvyezVwIfEdLudW4vQFFsnmLZXrOrlzLtxUVzHq6B0gKKVcWHblTPKmgqm04xl+sp31uyrezKPemj2d7exgZ/kIKxNtrnwf6cLVg31+rLeUyKXCkLFRFzddSbthpR+Of6tDBD6QPULohQuJbtNNZLVlFLcq4x2lBC5GJzZM9HkXXboxLHeSWcDRaKzcEQGvWBwn+77e72HkI18dqc5hNyylaQnxZF4+rTN1Gc96tV4FTmGfdWo8/BVwKySzGWUmJ0OxcWzbMLs2EIhZmyL5zEpPJ3uF7TO1zw8lZsEZp76jK0q9dA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad7a0c2d-428e-4952-b6aa-08dd6d5db8d5
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB5749.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 18:32:25.8288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VDLDYNGLmBF6TtOuTSud6EYKWsztu/dFZ3o6Iv2E8JDmVUQvJGg+9FhUtTgkI5AIGhu98xhH9GSX6NChUTTt/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6062
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-27_03,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503270126
X-Proofpoint-GUID: 8w4-C3KwPqt9Z8eTAYgtMh3QAb8FB7il
X-Proofpoint-ORIG-GUID: 8w4-C3KwPqt9Z8eTAYgtMh3QAb8FB7il



On 3/27/25 08:49, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> The trace event verifier checks the formats of trace events to make sure
> that they do not point at memory that is not in the trace event itself or
> in data that will never be freed. If an event references data that was
> allocated when the event triggered and that same data is freed before the
> event is read, then the kernel can crash by reading freed memory.
> 
> The verifier runs at boot up (or module load) and scans the print formats
> of the events and checks their arguments to make sure that dereferenced
> pointers are safe. If the format uses "%*p.." the verifier will ignore it,
> and that could be dangerous. Cover this case as well.
> 
> Also add to the sample code a use case of "%*pbl".
> 
> Link: https://urldefense.com/v3/__https://lore.kernel.org/all/bcba4d76-2c3f-4d11-baf0-02905db953dd@oracle.com/__;!!ACWV5N9M2RV99hQ!LTIVO1_O9wY2hBAnpNF5zcB1EFlC77zOnu4oVcM4DoD77p5ZO_m1LFZdPVJPj4spzye4JntXHOqOVxirPQ$ 
> 
Thanks Steve, a minor style issue below, otherwise LGTM. I have tested it, it works. 

Reviewed-by: Libo Chen <libo.chen@oracle.com>
Tested-by: Libo Chen <libo.chen@oracle.com>
 

-- Libo

> Reported-by: Libo Chen <libo.chen@oracle.com>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  kernel/trace/trace_events.c                | 7 +++++++
>  samples/trace_events/trace-events-sample.h | 8 ++++++--
>  2 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> index 7b3ef1d26167..34e7b4af9f88 100644
> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c
> @@ -470,6 +470,7 @@ static void test_event_printk(struct trace_event_call *call)
>  			case '%':
>  				continue;
>  			case 'p':
> + do_pointer:
>  				/* Find dereferencing fields */
>  				switch (fmt[i + 1]) {
>  				case 'B': case 'R': case 'r':
> @@ -498,6 +499,12 @@ static void test_event_printk(struct trace_event_call *call)
>  						continue;
>  					if (fmt[i + j] == '*') {
>  						star = true;
> +						/* Handle %*pbl case */
> +						if (!j && fmt[i + 1] == 'p') {
> +							arg++;
> +							i++;
> +							goto do_pointer;
> +						}
>  						continue;
>  					}
>  					if ((fmt[i + j] == 's')) {
> diff --git a/samples/trace_events/trace-events-sample.h b/samples/trace_events/trace-events-sample.h
> index 999f78d380ae..0622c9e3f2be 100644
> --- a/samples/trace_events/trace-events-sample.h
> +++ b/samples/trace_events/trace-events-sample.h
> @@ -319,7 +319,8 @@ TRACE_EVENT(foo_bar,
>  		__assign_cpumask(cpum, cpumask_bits(mask));
>  	),
>  
> -	TP_printk("foo %s %d %s %s %s %s %s %s (%s) (%s) %s", __entry->foo, __entry->bar,
> +	TP_printk("foo %s %d %s %s %s %s %s %s (%s) (%s) %s [%d] %*pbl",
> +		  __entry->foo, __entry->bar,
>  
>  /*
>   * Notice here the use of some helper functions. This includes:
> @@ -370,7 +371,10 @@ TRACE_EVENT(foo_bar,
>  
>  		  __get_str(str), __get_str(lstr),
>  		  __get_bitmask(cpus), __get_cpumask(cpum),
> -		  __get_str(vstr))
> +		  __get_str(vstr),
> +	         __get_dynamic_array_len(cpus),
> +	         __get_dynamic_array_len(cpus),
> +	         __get_dynamic_array(cpus))

__get_dynamic_array_len() calls don't seem to be aligned with the ones above

>  );
>  
>  /*

