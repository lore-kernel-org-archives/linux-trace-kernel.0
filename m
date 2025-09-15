Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED7C2F99B8;
	Mon, 15 Sep 2025 10:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757932275; cv=fail; b=CPovKGoOwDSDYtEzIP96iXBrC168BITADVkZRyOivmePK6wX0E+fk9pGkNci3X9oA/dGe1p/nLFpCMSQORIhFKx0x9ZurO7Iz8pMNghscth3qAeZp1Afim0nZdKoD6micRneXt4uLrftGz7SuT5kKUpzaiw411+CRP1JLs4ZH10=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757932275; c=relaxed/simple;
	bh=8wiaWRD3RLJqd5feKUv2mNaBQ/1slWSz3fg6Yd37SUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=d6YgdnYAJYBhrH1XVbW4YLqGExHEGhNydSivK/qscA3Pi9yykqONKMTvWglIUkZDjcBK7hNvCEFK72L0yWnYicJ82r/sbrhc0XRQrAwCOk3WkgsxHWWyC3ugwTloyk53j9OcPDwKW3n3gN9u14Z/hH0fd4dptFJoMWa4cEt5G/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VyGP4ffx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KYn2S0I0; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VyGP4ffx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KYn2S0I0"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58F6gECm022095;
	Mon, 15 Sep 2025 10:30:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=9f+XyTVmDthrAcVNOnM9gcCAZ5yTmfhqXg6DsPWxD4w=; b=
	VyGP4ffxDjGg8d6l3ID6o5poxSrUdXs5GZAWkCxMmcyXjfKZ1pU5+Wn4KImjkMAt
	rW3GKrkCUMbUUhSoPTaHXN6dhVOEDnohjqMn2QUCF7Xsnj2E/V1VgqBRdqcNqGzk
	pNvozO2KGmRzY91ki9XpjliyCNvD7MtILzlJAyrw3WEC/OLPLNiN54wpczLSXxYG
	0Bya5wr/dgcv5xUQ+ogiP3KUWy3OTijnFA0W/QaDxqmQq49wniTeLjCQ/j3bL28a
	0Oq8vVDKWC9LPey/wwwMpWUtfYz1mvtyQ77yksTaxYUwtdCmp18T9sZ2yomlyVc0
	VzcADUMMK/8/YdB2iaF7Qg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 494yhd23jx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Sep 2025 10:30:16 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58F8tES8019506;
	Mon, 15 Sep 2025 10:30:15 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013009.outbound.protection.outlook.com [40.93.196.9])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 494y2b333f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Sep 2025 10:30:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gZWghVTIA8UQCabpIGd7vQRlcxQBiiAdjAQIfVMwiZrT9JATBqf/uzDTrZQg9S50O+Mo2xJZhAi+JRbOsGqPtl0rRRBWTff2KyaPieT4PrQvyNSpflXn760yxJ6g+yIe/v1basSxgumc5/VJzGWslY2t4adfOmR+mjsR5KPOUEXqpHuGj7A8oJWxfsq8uQOzIXtbfZOlnj8nn1niiOeEFIJfLmUOltZo8BjloVVzFAcPS9iXaY2g2L48SUeBD0cQHSZMid4bB9mPcgBNv6E2a85V94yHyjq5kfL7uMDsEgzxWP3FYFnYtdwTdAYBUg43TZY/pB20MvZHEWmakZEedw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9f+XyTVmDthrAcVNOnM9gcCAZ5yTmfhqXg6DsPWxD4w=;
 b=PWLDCWRNlEHbD+TKyPhOF9UzF3r9arj5d9odleK92pom4myS8e1Kii3NgQYW9bgukkOzl8bURcMxoyKwrwvAW2jXMTvfd2asu+nsi3NASu5+6GaP6hw1vakUCBw5sLahmZ7YxezguzMkwMlemUgH9mCwO6xE7PdW3ut7FdGfCtEsUrLHBdboPPQIui5C8fTnl4t52nIOpoyXKmSHoMfMoqEU9VZYcrjH69JLhFgZSu8HqxUhA1nqjlfdnRq4uo75S6uPjG+WBOQjrSdCQKT3Mce1wzTnpJrSognUK3pl0JlSZUtEfbguii2SD70Ip9LJC7Smx6XkHot5lgE4dCoZjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9f+XyTVmDthrAcVNOnM9gcCAZ5yTmfhqXg6DsPWxD4w=;
 b=KYn2S0I0yMqiOEPRlhOZkKWVwh/QyiG/DpZPO4l0UbR1euJQumDvVXWMe/RAoN9FREiMZpZUmbIvIfAME9+9HxcV0SezNAOYLYW0ki3fk7pThbvzXX3hIw/Mq5/8YaW5d8JKl8e5uFB40mvwM99etl17p2vJm0etAOdSKAGmdbY=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SA2PR10MB4459.namprd10.prod.outlook.com (2603:10b6:806:11f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Mon, 15 Sep
 2025 10:30:11 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9115.020; Mon, 15 Sep 2025
 10:30:11 +0000
Date: Mon, 15 Sep 2025 11:30:08 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Nico Pache <npache@redhat.com>
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
        Liam.Howlett@oracle.com, ryan.roberts@arm.com, dev.jain@arm.com,
        corbet@lwn.net, rostedt@goodmis.org, mhiramat@kernel.org,
        mathieu.desnoyers@efficios.com, akpm@linux-foundation.org,
        baohua@kernel.org, willy@infradead.org, peterx@redhat.com,
        wangkefeng.wang@huawei.com, usamaarif642@gmail.com,
        sunnanyong@huawei.com, vishal.moola@gmail.com,
        thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com,
        kas@kernel.org, aarcange@redhat.com, raquini@redhat.com,
        anshuman.khandual@arm.com, catalin.marinas@arm.com, tiwai@suse.de,
        will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz,
        cl@gentwo.org, jglisse@google.com, surenb@google.com,
        zokeefe@google.com, hannes@cmpxchg.org, rientjes@google.com,
        mhocko@suse.com, rdunlap@infradead.org, hughd@google.com,
        richard.weiyang@gmail.com, lance.yang@linux.dev, vbabka@suse.cz,
        rppt@kernel.org, jannh@google.com, pfalcato@suse.de
Subject: Re: [PATCH v11 06/15] khugepaged: introduce collapse_max_ptes_none
 helper function
Message-ID: <12ec9700-64c2-4404-bdb6-5fbddfb81164@lucifer.local>
References: <20250912032810.197475-1-npache@redhat.com>
 <20250912032810.197475-7-npache@redhat.com>
 <4e1fef74-f369-439e-83ff-c50f991c834e@lucifer.local>
 <CAA1CXcCugu0C3s2V1GcZZC=WksiNy8vkomHCcdvtGKfhxhoyfw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAA1CXcCugu0C3s2V1GcZZC=WksiNy8vkomHCcdvtGKfhxhoyfw@mail.gmail.com>
X-ClientProxiedBy: LO6P123CA0047.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:310::16) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SA2PR10MB4459:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ee27f7b-8cb0-4fca-92b4-08ddf442d9a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NnhsV2pMcCs5WDZhS01neDYyK1ovcFltS2VtWVA1NStNbzVwMlgxMjF1V0tC?=
 =?utf-8?B?KzhOVjBFOU8vTHhhdHg4TUx5blFiSFg4bUI1VHFJVUFBbE1XaVNzbjVTMWcw?=
 =?utf-8?B?WkNqL1diUlBkbjQ0R01uL2lDNEhpVlRyNjVqT2R4K3MrM1pZa29COTVWK2M0?=
 =?utf-8?B?aVFmMmJiaVhoUS81YitQOHRvaEdhTnI2V2lTRjF5K2VmUENDZmp4NDNsZ0NN?=
 =?utf-8?B?QythL0pLTHBrUG53SUZDeVBsQXgvQzgxbVhUMzRKcTQxK0xxRmtRRnV2MDZ1?=
 =?utf-8?B?anRXWjg4YkQ0R1ZTL2xGZTd4ZlJtY252RHd4NzQ5b0NkTXQ5WjlhYXhnbVh0?=
 =?utf-8?B?aGMxSFdKSEkyWjc1aU83SVJyNVBHdXozbUdFMVYzOTBWaDNqaVJPeVltckRL?=
 =?utf-8?B?N0xibmxxYjlpQmw4dHB6ajZzd0tmZ3pMUytLQVR5MHh4Wkp3Z1J3c2NpVHRS?=
 =?utf-8?B?V1NURjdBUlJTemwyai95TG5XQ2hEMTcyQUlmRWFpK0Q5b0h0Q2dxSmlvMWpw?=
 =?utf-8?B?a01TbGtVMkRiUk9odnhIakFHR2FBdG14eThpYUlvVTJTL1VxT3NXNW44M2dm?=
 =?utf-8?B?TEN4VUFhSlU2ZFZlcHYzVWJHOC9qQ2tIdG5jVGNvVlFjdkE4cHVZWXVnazVW?=
 =?utf-8?B?VUF5Z2VrSUxhWWlobUpkMXFYaDFoNkhnTlFTM2JlR2hHTnViSVBvU2x2NlZD?=
 =?utf-8?B?cW45YkZ1cmtheld4WXFMbGI3SHBWTWx0Y0FVVWY5d25jWG5IdlFrZVNFRm9m?=
 =?utf-8?B?M01tNjc1c3QwUXNaa1hjcVBPemhGTjVYNkJzQ0wxbENYTkV0aFBMMER4ejg2?=
 =?utf-8?B?NHZJYTJRclFaZUxMUFJqcGtsNDNsMzk5ZkJ1N2plSmxOanh5Y1ZZMG5ndEVx?=
 =?utf-8?B?azFNelBUQVlRUWttQ01nU2l1T2xUb21nZkpYYUladGo0VUdIUDRuRWQ5bmM1?=
 =?utf-8?B?NkNWejRneFJFUnF4U2J2alU5Y2luK1JGVlB4bC9RZlpPck4wcXZHUlNjakE0?=
 =?utf-8?B?Ullab0hXTVFIUDNWRXp3VW5sQ1ZPd0xNVmthaXpZUkNoaytTUGw2TTZ1aElQ?=
 =?utf-8?B?ajcxaUhzK2xXSXBFdGl0dEhiamJDbnJraEZuYjRVMVRBRlB2aXBYVFMvS015?=
 =?utf-8?B?R0pYZk56TjZXYVdZL3BVYUxsUDN3VkRpblJEZmlWbEtFdS9GTFg4R1o4a0wr?=
 =?utf-8?B?QzgzSjJCdEFGQTgxdmhyRjFjUFlMU1FYZjd4d2ZNZ2RUWUlnNmRrdldyKzky?=
 =?utf-8?B?UlFFbzJKNml6STZyZG80WTg5Rm9URm9uQnkwNTN0ZWE1WGhYTU1lNFZoVFNU?=
 =?utf-8?B?ZitSS0pyMHo0L3J2Z01kODg0R0NjeEFkem5iZWN6WEpnVW0xSmtneHVVeStJ?=
 =?utf-8?B?NXJJeS9pQTZHOWZlN1VrYkVDZG9hSTRSV2JwcjlNUGVQaWQ4Q05VYnNBQ3dW?=
 =?utf-8?B?WkgwalppOE51QU93T1NZVE5ud3FQdDNLTUlxTTI1UFc3RnVmNHZQamRoZTdY?=
 =?utf-8?B?dncrQ2VCd3QzdFAyZlU2VG1TU091ajhlTDdvTll1TWlIdXc3STljaXFwWXpO?=
 =?utf-8?B?ckYrUzFneUk5dkk2WFJQWktjdytjRWVrSzV4MFc0QW82amVvT0NkMXQ2NGwv?=
 =?utf-8?B?dlhvdkloRUFjRWpMS3RrVjZENUlTN01JMlZjTlFyNW9iUWRDbmUrUzMyQk9R?=
 =?utf-8?B?Z1VobkhaekYxL1BwazBLNXRtL3NMTWFiRGtQUEtTd1hWRjM1WGRRcXFzSXdy?=
 =?utf-8?B?eUhxSjRybVJTZHN2bjQxZzdCcFNXdUtjOE5RSGlGd1NCM3pVUHo3SkpWVXFz?=
 =?utf-8?B?NFUyaUFzVzBOQXJENFpsV2dWS2ZCbTlZejZxSG9uK0R5b3dWeDZmVnNUTXJh?=
 =?utf-8?B?OFkraGdsLzJjdUpJWUZ3bXkvN2dYc1RSOWJ3SVlIb2xSclJ6TkU5eTJSS2Fq?=
 =?utf-8?Q?edcEs0m8evk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WVNrQWdlbXlpeVJ1Z2g0VTZObmlodjNTcjhJNFNUcGpCaDgydDZrMnJ4Sk9X?=
 =?utf-8?B?VGlSenhiVWt0ckNSaldpeEplQ1h6VXNNMGdPWk1mWHA0NWpKVXlSMitDd0s0?=
 =?utf-8?B?VUZNWW9XRkppYmNGbFZRbEZKTjdEbzUzVDlDNmY2TFk0ZkdNZmNHNlNaUTRW?=
 =?utf-8?B?RzJHMlhuVEI4ekU1aXZXd2tDdVJraHNRUlNoeGE2Q1p5UzJROFNkSGR4Mnpu?=
 =?utf-8?B?blBaT0d6N1VIM1lBb3VPajlWcXRIRHVMWVE5d01PeDgwNmdVdnE3bjhCTEY2?=
 =?utf-8?B?MUlCazEyeW1LS1JiVnhEYisxbzRpTCttYjhOOXo5RjhvWis2UjNRQmdYYkYz?=
 =?utf-8?B?V3B4MDZxcHdGeHZZYThFUlZKL3BGV05Tdmpla3I5bG5ISzBvdUNmaFlDWHcx?=
 =?utf-8?B?cE9mNm9rbTVjSEFoVjQ5OFNZYmJWSk9hdi9WWUJ2UEZacUZVRkxWcDRzWmRw?=
 =?utf-8?B?b0xtUm1SN1djQzlaWHgraE5OY0lLQWc0YnBqSlpSUUVMOCtBdE4xYklFc04w?=
 =?utf-8?B?T3F1RUMwY1FsNmFld1doZVVEbFlCeXZPdnh0RnpJRks2NythcXJHMExpN1p6?=
 =?utf-8?B?R1VRZjh2TWFwb3Z6czJ5VmI4OU1iVVZTNzlZTEp6VlVQWk1KS0NrdEVuc3Ri?=
 =?utf-8?B?T3QrR1NXVTBuV3NJWTE1SXExVzhMSXV0ZERQbGhTYlNvaWdtRmFFL202WHp4?=
 =?utf-8?B?ekFLUGYzWTJoMmhheVJlTS9wWHpoMjBJRndibVlpa2M2MkNaL1FjbUQ1RllN?=
 =?utf-8?B?bDFmdnNOdjhnZDJWWDdma3IwN0NQYWExKzE4eDRnR2p1bkRVUEZTMzg5TEZH?=
 =?utf-8?B?UFU5NWdCWWJCTjMvM0E4SEFTamI1eDd2RVNyMHZuN3IxK0RpTm9PanFlc3p4?=
 =?utf-8?B?aUdiVUlGaEVIQ0NMVUtMc3JTVDNZQlhWbkxVa0lSclA1ZFNoeWJpYzA0Z01N?=
 =?utf-8?B?dk1tZEE5ZkJqTUgvNm14SCtZTHdURWxmc25nODJRb2FNYldlWjM0ZWcyaXZ3?=
 =?utf-8?B?N2dqOEFKekhZWWd4c2EydGxJQm1GMW90bjdVdWtXMWNxWHRXWWJFbUIzbmNx?=
 =?utf-8?B?TDB5cVJwNjdDYzNSaVlxcEgwUGgxbm1Uc2pMSVNIZGZkaE14UlZPS2l4VTBN?=
 =?utf-8?B?VjlYQjlFdWlwLzZueUQ4d0VReFNNY011UE1LYk02ZkdQOEVWaHhSS3lJV0po?=
 =?utf-8?B?QThUN2FNVGErakJQdHVKQ2NkQ1RXUGhrd21ORnJFSWZlL3pBUTdOMGpoWUpL?=
 =?utf-8?B?L3BMckxRMktjRU5PcnJJNEVqNWUxV0pDakZNTkRKTXVxMnFheE1iNUpnMCt6?=
 =?utf-8?B?cGEyUmNQZ0dvL0VicUVEWEZmaUpJb0pOZFJOYkh6T2Q2N1Zoa0FsRmY5UFgr?=
 =?utf-8?B?OVQxOWdkd3g1VFZtSFhoM2pDOVFCUExSbG1sRjBBeXdGSTBVU0NTM0V3dXpY?=
 =?utf-8?B?bmtlWEQvMytjSU4xaG43MjNUNm0xdHlwWjlvOXJCRWozZzgwYjQ3dFFXNXVB?=
 =?utf-8?B?ODMxT0VPdjUvVGhFWTdJcUFuMTZBVWw4OENYUnl4ckJ1T0ZadmF3SWo3Z3pn?=
 =?utf-8?B?RHQ5dGdqdmFlNmJCbmRXd0xGRGVMYkErMkEzMnpFanlWMnJEYXY0bWl4SVQx?=
 =?utf-8?B?cldJSldoQ2hiM2c0MUtuRjBNazkvbEwzQm1jLzF4NFhUd240bm81Y0JHNGVN?=
 =?utf-8?B?VjRyblpqdHJMdkVTS3JjOFRzRFUwbm5iS0Z0cUlhbis0RUtNK0c3QVVFWTla?=
 =?utf-8?B?VGZ3ai91WEhMZU92dW5EbWk1SC9RK2NYbWdRTzNjVWU2M1ZCWm4vckUwM0w0?=
 =?utf-8?B?SmVsVjFTM1NibFdrRng2cUZHL0h0VTZoNVpDN1FDVEtPWGZnQWFpRjc3dlk3?=
 =?utf-8?B?bFAwMjY5alBlYlZHZ3BxL1BDVkhSTXAweHVzWEs5NEN5bUJIVzQyZ3NMK1Bw?=
 =?utf-8?B?dW56MkdsMjBOaXk0QUZiNjFZT3ZOYXBTSE9kOGJmZFgwSXp0b3hvbGFlQnpa?=
 =?utf-8?B?bHBwY05ybXQ1SHhlb2pzSmpyTnJDUmJTQ2hBOCs1YVJtQUxBeGVDQmNUMnBm?=
 =?utf-8?B?ekIyZkVXWUZuYW1TWXAxbTRyc24zM2hLektONnJVWHMzNDh1ckE5US9xQmJB?=
 =?utf-8?B?WVVTMnVLMHg2dit1UGFuREh3TzFMd0ViZm5qdXIzL1QzNkhsb2tFaUU1SWVJ?=
 =?utf-8?B?TkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZPy0Upl88INjPJeN7aksKA4FmcJXtHRZbvlkBsOoCuE25rDHkXj6aY9va2nwzhWyoyv1U4fuZ/qytdW6/F/Ly9GcjeBFb4G+bgR105Wj2c1p35LS7fDLUJC82ABFuGlkYIFEDJZvVed0lSk0o+AUrRZDBZiPuN+q9HrY3JW+ZfROJPRDR1vEkIjH9WhXySg/GLxoArllz9SpGy4GP9Z6VH5VfQDfD1Q7LHWGAgTDrUQczbjz5de89s8kDUp7ZBVPyW89srE9qcmOf3Exr3bFDdXl/sCFpB6EFSZBfV6P4x9VWcWolleODvf3NE2ZzH5Zik8WJK26aTuikWB2QbD4SO3yB7f5q4bMCP8PUo3iDD4eVHB3J0keb8S40/Ko0u2en6FNL0fhJHBlVJt3ae85TsEOJe9GxJHgcjezFp4g8TY0usxsbkorOXWkl9PZ87gVvNylT6+dtptae1WHEUNtJJ3LQcURSQY3c8KVA0AmAEkkmFNas4C6icy2GXvdxzPBmBVowUouLsvKVUlXcQFTMzIkcxomEnHX/j0wzS4a9LW0xzu2fzMTjgmFABdUgC9O5gTboaBC3KrvV8T5Rd481/2UwYa4DZM+7+h5TnsjztU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ee27f7b-8cb0-4fca-92b4-08ddf442d9a4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 10:30:11.3584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bkZMFP2Yt7bmhd3vYf35hZPjKolpuQiEsoQTBE2fvduurYHabDvvp/03obJ8Bd4ZRRFWMERFYT1VqeFaPyPWy+vNx5H0V5KrPfdae7EGGJ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4459
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-15_04,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509150098
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAxOCBTYWx0ZWRfX0Qor4WkeAW4T
 ckcXK12YB6Bu1ntYveHi0OAJjZHsGa2MLyWKxJOsQ7ooxr8mMWgVTc93971yQSSGrGJ+eLQIjJR
 1kjdZO25IkjzCcFkAVOD+JerDs4WBM2lefrCYIx01f592H7VlwzCc7fiYcx1Z1Uzawlhuy5q78/
 tzK84wY+2pSqudrfY3xclvRWe/A0dMTOzCP0X7SLhM1hL1gyNG/LzRQLOHdMPAiRzL2eN7N/mh6
 O8ccEWhSF4y2oJdViAYsn6++yjb4CFaHSMEwguweUj8MpO9kIRhXD5a0H+bvBoCi/z+Ms5iC8gw
 xG/zKVdislNDlcjc/JChfv6sBEJp5pLc8/FIjmsyiNRsGpn9S63Ji1X1wJErBfPkcLcnhJEidOj
 Bnl0vSKl
X-Proofpoint-ORIG-GUID: QkFbLtI_mtz4-T1_AyGnK0dhFZ6GcLeg
X-Authority-Analysis: v=2.4 cv=YKafyQGx c=1 sm=1 tr=0 ts=68c7eab8 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=20KFwNOVAAAA:8 a=0sxmiN3xGqUjT-t3-tMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: QkFbLtI_mtz4-T1_AyGnK0dhFZ6GcLeg

On Fri, Sep 12, 2025 at 05:26:03PM -0600, Nico Pache wrote:
> On Fri, Sep 12, 2025 at 7:36 AM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> >
> > On Thu, Sep 11, 2025 at 09:28:01PM -0600, Nico Pache wrote:
> > > The current mechanism for determining mTHP collapse scales the
> > > khugepaged_max_ptes_none value based on the target order. This
> > > introduces an undesirable feedback loop, or "creep", when max_ptes_none
> > > is set to a value greater than HPAGE_PMD_NR / 2.
> > >
> > > With this configuration, a successful collapse to order N will populate
> > > enough pages to satisfy the collapse condition on order N+1 on the next
> > > scan. This leads to unnecessary work and memory churn.
> > >
> > > To fix this issue introduce a helper function that caps the max_ptes_none
> > > to HPAGE_PMD_NR / 2 - 1 (255 on 4k page size). The function also scales
> > > the max_ptes_none number by the (PMD_ORDER - target collapse order).
> >
> > I would say very clearly that this is only in the mTHP case.
>
> ack, I stole most of the verbiage here from other notes I've
> previously written, but it can be improved.

Thanks.

>
> >
> >
> > >
> > > Signed-off-by: Nico Pache <npache@redhat.com>
> >
> > Hmm I thought we were going to wait for David to investigate different
> > approaches to this?
> >
> > This is another issue with quickly going to another iteration. Though I do think
> > David explicitly said he'd come back with a solution?
>
> Sorry I thought that was being done in lockstep. The last version was
> about a month ago and I had a lot of changes queued up. Now that we
> have collapse_max_pte_none() David has a much easier entry point to
> work off :)

It'd be less problematic if this was an RFC but better to ensure all discussion
is really complete before next revision for everybody's sanity.

The ideal solution here would be to just ask David if he minded you respinning
before that was resovled I think.

But I do think generally, as I said in [0] that it'd make our lives easier if
you left perhaps a day or two after the conversation has settled just to be sure
that's that, and obviously directly ask about things like this.

I can only politely ask for this, obviously you're free to do whatever... :)

[0]: https://lore.kernel.org/all/2d5270e4-0de3-4ea3-87a4-96254eb6d446@lucifer.local/

>
> I think he will still need this groundwork for the solution he is
> working on with "eagerness". if 10 -> 511, and 9 ->255, ..., 0 -> 0.
> It will still have to do the scaling. Although I believe 0-10 should
> be more like 0-5 mapping to 0,32,64,128,255,511

Yeah, let's leave that discussion to the subthread on that.

>
> >
> > So I'm not sure why we're seeing this solution here? Unless I'm missing
> > something?
> >
> > > ---
> > >  mm/khugepaged.c | 22 +++++++++++++++++++++-
> > >  1 file changed, 21 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > > index b0ae0b63fc9b..4587f2def5c1 100644
> > > --- a/mm/khugepaged.c
> > > +++ b/mm/khugepaged.c
> > > @@ -468,6 +468,26 @@ void __khugepaged_enter(struct mm_struct *mm)
> > >               wake_up_interruptible(&khugepaged_wait);
> > >  }
> > >
> > > +/* Returns the scaled max_ptes_none for a given order.
> >
> > We don't start comments at the /*, please use a normal comment format like:
> ack

Thanks

> >
> > /*
> >  * xxxx
> >  */
> >
> > > + * Caps the value to HPAGE_PMD_NR/2 - 1 in the case of mTHP collapse to prevent
> >
> > This is super unclear.
> >
> > It start with 'caps the xxx' which seems like you're talking generally.
> >
> > You should say very clearly 'For PMD allocations we apply the
> > khugepaged_max_ptes_none parameter as normal. For mTHP ... [details about mTHP].

> ack I will clean this up.

Thanks.

> >
> > > + * a feedback loop. If max_ptes_none is greater than HPAGE_PMD_NR/2, the value
> > > + * would lead to collapses that introduces 2x more pages than the original
> > > + * number of pages. On subsequent scans, the max_ptes_none check would be
> > > + * satisfied and the collapses would continue until the largest order is reached
> > > + */
> >
> > This is a super vauge explanation. Please describe the issue with creep more
> > clearly.

> ok I will try to come up with something clearer.

Thanks.

> >
> > Also aren't we saying that 511 or 0 are the sensible choices? But now somehow
> > that's not the case?
> Oh I stated I wanted to propose this, and although there was some
> pushback I still thought it deserved another attempt. This still
> allows for some configurability, and with David's eagerness toggle
> this still seems to fit nicely.
> >
> > You're also not giving a kdoc info on what this returns.
> Ok I'll add a kdoc here, why this function in particular, I'm trying
> to understand why we dont add kdocs on other functions?
> >
> > > +static int collapse_max_ptes_none(unsigned int order)
> >
> > It's a problem that existed already, but khugepaged_max_ptes_none is an unsigned
> > int and this returns int.
> >
> > Maybe we should fix this while we're at it...

> ack

Thanks

> >
> > > +{
> > > +     int max_ptes_none;
> > > +
> > > +     if (order != HPAGE_PMD_ORDER &&
> > > +         khugepaged_max_ptes_none >= HPAGE_PMD_NR/2)
> > > +             max_ptes_none = HPAGE_PMD_NR/2 - 1;
> > > +     else
> > > +             max_ptes_none = khugepaged_max_ptes_none;
> > > +     return max_ptes_none >> (HPAGE_PMD_ORDER - order);
> > > +
> > > +}
> > > +
> >
> > I really don't like this formulation, you're making it unnecessarily unclear and
> > now, for the super common case of PMD size, you have to figure out 'oh it's this
> > second branch and we're subtracting HPAGE_PMD_ORDER from HPAGE_PMD_ORDER so just
> > return khugepaged_max_ptes_none'. When we could... just return it no?
> >
> > So something like:
> >
> > #define MAX_PTES_NONE_MTHP_CAP (HPAGE_PMD_NR / 2 - 1)
> >
> > static unsigned int collapse_max_ptes_none(unsigned int order)
> > {
> >         unsigned int max_ptes_none_pmd;
> >
> >         /* PMD-sized THPs behave precisely the same as before. */
> >         if (order == HPAGE_PMD_ORDER)
> >                 return khugepaged_max_ptes_none;
> >
> >         /*
> >         * Bizarrely, this is expressed in terms of PTEs were this PMD-sized.
> >         * For the reasons stated above, we cap this value in the case of mTHP.
> >         */
> >         max_ptes_none_pmd = MIN(MAX_PTES_NONE_MTHP_CAP,
> >                 khugepaged_max_ptes_none);
> >
> >         /* Apply PMD -> mTHP scaling. */
> >         return max_ptes_none >> (HPAGE_PMD_ORDER - order);
> > }

> yeah that's much cleaner thanks!

:) Cool thanks!

> >
> > >  void khugepaged_enter_vma(struct vm_area_struct *vma,
> > >                         vm_flags_t vm_flags)
> > >  {
> > > @@ -554,7 +574,7 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
> > >       struct folio *folio = NULL;
> > >       pte_t *_pte;
> > >       int none_or_zero = 0, shared = 0, result = SCAN_FAIL, referenced = 0;
> > > -     int scaled_max_ptes_none = khugepaged_max_ptes_none >> (HPAGE_PMD_ORDER - order);
> > > +     int scaled_max_ptes_none = collapse_max_ptes_none(order);
> > >       const unsigned long nr_pages = 1UL << order;
> > >
> > >       for (_pte = pte; _pte < pte + nr_pages;
> > > --
> > > 2.51.0
> > >
> >
> > Thanks, Lorenzo
> >
>

Cheers, Lorenzo
