Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE232566C4;
	Fri,  2 May 2025 15:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746199553; cv=fail; b=qFoWlfgsdDqA5+5NHBMX3HNyBXA08zqh/FfDn3e49tiygUupNqPa1juEIXjg1DLvipfX/TNvyAhH6dYJLEsctyriSedGuiWVzTLblDFULl/Nu2krkF2eCx052Kt2Mz9lTJuuu7W0sCav8QRpEyST+Oj0bKgATb0uXlBpwAkGl6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746199553; c=relaxed/simple;
	bh=3E/7PIDSlIQO7dBtGCzv+LdnO5SkqnmRCzt1QI/P+rI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cR6cenhdBpfRWoUWlI7bo2kEKnl3nH/UF0gmsxSg6DvWtNQiGtkTrJTlfcLeAQCY98xwAc7ZqASgm0IYsGgYldAk/TCEThwzqTCbe0DqIDr6b9D4bpDrDD+FV9G+AhWY+Ja06Jw6cC+ufgGgFs6bV5UxL8BwmKQZlP2UlnjrvOY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GKAyLdtP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OBVSp6e4; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GKAyLdtP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OBVSp6e4"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 542EZ1lw023779;
	Fri, 2 May 2025 15:24:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=w0ZeRQ/sl4NavPbRSIOiGV463T3FRJCADdStDUXt4y8=; b=
	GKAyLdtP3gg8AOArDf+Z2l6EMjs+1n0sP65ZDoqF7HoPw14rvUlFIkeIMQteOMYQ
	vijOrsE//6j0BsTdEqgJwKd1e7CeJpekJdZqBPnc1UG5M0VNCxP4h/VPNGYidhyU
	K8p1x0/BTA9SuVXmxn55VNN/bko3fUWfkDZR0B4fTh+xWLSpxt9Lfd1+chTpeEK2
	G0aVTueSeNBhzu/yrGaYtXe59TSj5/hUbN2NE8TFPmM72qtT/hj1RGvR6KqhwQhC
	liXamc1IYVeqmur3DSNNlgevYjN0pfi6LiNPez6dHaKpTlCBUBQd1b0nFImGqLk/
	jMlEXY1Cf6KLjrqU490ptw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b6umdh0m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 May 2025 15:24:25 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 542EdvOK011244;
	Fri, 2 May 2025 15:24:24 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 468nxee0g1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 May 2025 15:24:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AoYPQsknk0IbJJcywHKYM0Fqebg+6Gg1lEHbNsDji+WvIgr9Bc4GKPCYzRgC5LgM5eJctvD9c2YGmgHIfsZIYbs3hV7+aTX/7+SLtFseC6Fi+gdoUFFk8NreGSJyr6aUHPg3vz2iqBX5VXAtMtVnscMfWrxFzX2OjgNGpu6ft3RnDuuIawWjTPlWHK5+AZ+yBpkYmlZkwBRSNo7ZFZTGFmaZnJVSoQ42jgzLygdEka4vlmlIx0KgD88GUQfSqf8Yg3PbkaX7D8oPVfdHFaiP+Z+Er58k1ka+gfRv0wS0DcLAucL7YfGHHKgRm/Z25fRcxQqTt6FtE3BelLQD90nQ9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w0ZeRQ/sl4NavPbRSIOiGV463T3FRJCADdStDUXt4y8=;
 b=qH0D+3T53yRwFgooi427pjkn3hXsgM5YkIrAi71s3pvxm9SVx2VFAhPzT+06kw1D8iWl1m1jLmiD64tHAjAjxjM91MSDyoALzAe14dhBaQTGuW1DCdJQcDljCKoqIA1i4tBkfPSDX19sqWZtKQSawo0nwFItfKba7AJowdtstS4zWMJEyc8ZTF6VvpwJnrAl8zvijKuUu7zrwlO+r2bkGd/pcg91w3cOvqQ0msqy3IekIFTTtv20IzasHugyuAOAJsYWH6RDJLtnB9xse4BRdv84AJO2v7TZsjSdTuXT0fSKekPWIn+8I/0pqJGUnQVAeHKhmHCWnrDXCPLUZrFnTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w0ZeRQ/sl4NavPbRSIOiGV463T3FRJCADdStDUXt4y8=;
 b=OBVSp6e4bHeqo4uKRM28usdWJjVwDfDb/IDUV3DR4S+R7wyIDbggj/ve2JceTMnnb6JP5ipOFtj9JSR9MRZPxr30mRZ2PeGdEOOgq0MEiGjwAE3GWiVulKvIzP5EPVcTNtwR2zH1tjlcIQ6ijXBn5dWyD2C5dgJHeOYvGS3yTJA=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS0PR10MB8128.namprd10.prod.outlook.com (2603:10b6:8:204::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Fri, 2 May
 2025 15:24:21 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8699.022; Fri, 2 May 2025
 15:24:21 +0000
Date: Fri, 2 May 2025 16:24:18 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Jann Horn <jannh@google.com>, Nico Pache <npache@redhat.com>,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        akpm@linux-foundation.org, corbet@lwn.net, rostedt@goodmis.org,
        mhiramat@kernel.org, mathieu.desnoyers@efficios.com, baohua@kernel.org,
        baolin.wang@linux.alibaba.com, ryan.roberts@arm.com,
        willy@infradead.org, peterx@redhat.com, ziy@nvidia.com,
        wangkefeng.wang@huawei.com, usamaarif642@gmail.com,
        sunnanyong@huawei.com, vishal.moola@gmail.com,
        thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com,
        kirill.shutemov@linux.intel.com, aarcange@redhat.com,
        raquini@redhat.com, dev.jain@arm.com, anshuman.khandual@arm.com,
        catalin.marinas@arm.com, tiwai@suse.de, will@kernel.org,
        dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org,
        jglisse@google.com, surenb@google.com, zokeefe@google.com,
        hannes@cmpxchg.org, rientjes@google.com, mhocko@suse.com,
        rdunlap@infradead.org, Liam.Howlett@oracle.com
Subject: Re: [PATCH v5 07/12] khugepaged: add mTHP support
Message-ID: <35fc73ea-39f7-4d60-9d78-d700b8ef6ff6@lucifer.local>
References: <20250428181218.85925-1-npache@redhat.com>
 <20250428181218.85925-8-npache@redhat.com>
 <CAG48ez2oge4xs1pSz_T9L46g=wQnFyC63kQKsXwbHGRWAxQ+aw@mail.gmail.com>
 <CAA1CXcBHJbs7_DGVR929NOD5G4nkJ3LguDrL9itV8-QS+BNUpg@mail.gmail.com>
 <b6093db0-9b18-4b70-81bd-6c02e80ac9fa@redhat.com>
 <CAG48ez0oe6oZ0QTDWr1rtUJFFTLO69sVpdoCmo+CxZUb6L1seg@mail.gmail.com>
 <b91af3df-643e-4131-96e7-2680f322194d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b91af3df-643e-4131-96e7-2680f322194d@redhat.com>
X-ClientProxiedBy: LO4P123CA0267.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:194::20) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS0PR10MB8128:EE_
X-MS-Office365-Filtering-Correlation-Id: e165e2aa-81ea-4742-cf07-08dd898d696a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y1NBTlhqVDNtczBaalFPQ1cyU2xoNStyVEJ3MkhIZzVDM1VtUmtCU0MrOXNh?=
 =?utf-8?B?dUhRbVVSdzhDcE1HTldGWVBjUWFoQTd3b1diREhObjhtcEhsSGg5ODRLbyt5?=
 =?utf-8?B?aWE3dzJ0WWpMOVNucnJqaElNSDNoN2NUY2Z3elBxWEtWazJWNnNrdU9qNXBK?=
 =?utf-8?B?dzZVZnpYVS9WN0VoUG54WkhSR1R5Q3JDb1o2Zm5peWx3MFBscnRncEViNVBG?=
 =?utf-8?B?cytJRTBMdkgvTzR5SmFJMS9ZUWhGSXRTaVZLSVpoQlpVTWluRk5PbVN4L2cz?=
 =?utf-8?B?QjFIS0JuT2xIWDRNUG56b2RaS3VuSm13MVFpZEhXbUt3MHpYQ0c2QlI0UmVV?=
 =?utf-8?B?cjlGWWwyNHV4NGZjMFRpYkIyQW1EaVJHUnFPUCtteXNLTE1hZWpBaDNDOXUy?=
 =?utf-8?B?RU5kM0FlZVY2TU1FaDQxOWk4cUFFbkpUSlJvQk10dkl5V1ZETVpWUGZxTzYr?=
 =?utf-8?B?TmlEYi9jcENrMjNabHpuTUNFUUNQbU9yekJIbGl4VlRxVGh2enhQZzNJRENu?=
 =?utf-8?B?MGJobitPNm1OclpnSkFtNGI3WUtqS1k2Zk4rSTdOSm5XTGpLVG96aG1xbmdC?=
 =?utf-8?B?YkpzQjNpOXY2eVp3T2pYdXErWnBDbjZVdGowb2tYK1J6S21TME5veTYrWVRX?=
 =?utf-8?B?NlYwVG02NEdhR0ZYcURRbGdvMzNuWHBmYkc0c0ErNlNibjBjL2Q3UWpybWdm?=
 =?utf-8?B?dllQR3pTS0dMODJhQ2w3M0hVRHB1Z054TWNuYzBZRnBIbTJ3cjZZL0lWcy9X?=
 =?utf-8?B?ZXoybHJpV21zUEJ4bStwaVpnTzl2eUh2NW0zRTI4aklqR2YzSjI4b0czNHlP?=
 =?utf-8?B?MExUMnRHTVlQeDg0REljTU1vdFdOODFEQTluT0c0MHFGS1hvVmovLzNMSHc5?=
 =?utf-8?B?WXVMOFRaODVrTEtlVWlQNkd3K0ljZXJQSE01SllhZ3FXNCthZ3VKdTNXcU01?=
 =?utf-8?B?ck1aaWxRdU94UFFtZk9mZTAvL0RuVTRLWWZHbGFKdStLMEpBckZtRGhpQWhy?=
 =?utf-8?B?TzlPb0FzUlUzMkRuUzM3ZnFqbFpicUF0eFVLK1JwR1IzaFVndDNJS2cxZHdN?=
 =?utf-8?B?TEdSS1MvWmNGa3FHSGJvbW1kZTg0Y00xZ2hHM1RoKzBxczVSSlJWd1VwdERZ?=
 =?utf-8?B?TzRzaHNwdkNMMjJSKzJCNXZWT2I3NDYzcWovOWduS25xbjZqdkZ5VWNWaHNM?=
 =?utf-8?B?SkFJU0MwM3pGQ29STFk5MzVKZGVCUThrUmNWVWpqV2hRRTJ5clBKRmhsK3Bp?=
 =?utf-8?B?L1hPR05Ic1lQRzhMNm1VVS8zWGJpdWh5ektoQ1E2Qnh4NEdrK1diOVV0bGx5?=
 =?utf-8?B?d0Z5aDhqRU9SdnozZElIaEVkWWJtenhoS2U3Qk8rZzNWa3hTZStNekE5U0xh?=
 =?utf-8?B?SzlGdnN1WTJHSFNIVDh3Nzg4V1JlMTZmZzNzMktUQTVJa3JrbEpyWFlNcjQw?=
 =?utf-8?B?dVNHMHRhNDB2UTBxNnQzbUFnQWpseE5laUdMTUxSMGhXTU44NGxGWHdLSnBv?=
 =?utf-8?B?ekw5bnZmVmJuRzVMemorY3cwV0RHWTc2MXUyQ0pzTUY0TGZRL0krQ1JneWtw?=
 =?utf-8?B?N2k3R0NLR1gvbXFMeGFjLzI4d2VIbXF6ZUFOTWNlVzFNVVhYKzFzTGVhZnBF?=
 =?utf-8?B?MjlWL1dlUlhpSVUrdnRweHZaY0NnWE5FODRCUGx5dlNWNG1KTGdlZU1lK3Fu?=
 =?utf-8?B?d0tSMk5OU3RqZWlqc0dYUHJacHFxR1pIbHVCVnV1SThJWDVlRHowQVN3R3R0?=
 =?utf-8?B?ZnFYL3lLL2xnaGR4UDU3cmVQR2hmQTc4dlN1SEs4NytnYU5leURDSEprYmth?=
 =?utf-8?B?bmRXaHlWNkNnT0pBR21GejhSbER6R2hNZ3p3MGJCMFcyRDhhVTdhZlJuUG9T?=
 =?utf-8?B?d0tYNGRudTd3UllRZlRvU0l6aXRRSWRRVzJIZUpkRmxOajI3aktUSW81MEtZ?=
 =?utf-8?Q?8ee4vKb6OxA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZlpmbGlkdGpVYjFYSzhyOWxFMW9VQ3dWNFhScXV1dnZoUTVRQVAvcFNOaDRQ?=
 =?utf-8?B?VDJhdVZLb1FNb280U042KysyZFFqWWU0Nm9HWGhyeUhRSGsyNlEzR1NkaVln?=
 =?utf-8?B?bFhJT3JUK1RVQzVwZmRNaVFkcHgzVGlSNlJOVG9RK2EvY0ErcDhkRS9xcjZp?=
 =?utf-8?B?K2ZCK3Z0WFNpalFGTTJUTUpUTFhDNndsS1NpVi9rdnBJY2NpWFlkNWVMOTkx?=
 =?utf-8?B?NTVhelN3MXgzaUo0Q2pLOWllS0VVVWkxb0NtRHdCV2tGVGNOZGNwaGR2Zm9t?=
 =?utf-8?B?b2p0QjNrSGdmVnFmZ0FzUHM1a1piWUZ6VmRFSUxNbW9XOXhHZVNhMTN2bnJN?=
 =?utf-8?B?N2N3emFaVTYyVmxNenU2NGMxak11dlFLYmZhcmYxaVZ6enhRNVFkR2VCYlRK?=
 =?utf-8?B?U2ZONzg3MW1TU3M2OEttVnlNVFRJWFNxNjd0K01TNVZVbGF1SEFpWFNVajdw?=
 =?utf-8?B?dUE2dHJPdGlhU1UyZFdBcmpSNThOZEZJWWh0TjJDQ01HSHVqbXA1YmwyTUl4?=
 =?utf-8?B?VFRCMDdHU3lhYW1VdFFyUWVGNWZFSmZHU0JZQ0tQSVo4VURIRk1BZmxFN2E5?=
 =?utf-8?B?amR5aUdQMVhiSUFCQUp3UVp1T1YzQ2ZEM2tRMjJSd3N0K1RmRzkwbmIrRnRo?=
 =?utf-8?B?U1JSMmxxL3lNcVJZZzBpdU02VmhMOGNkT1E0TG45MU51Nml1N1JsZExwMDE4?=
 =?utf-8?B?TjdmNlNkVEZjYS9Pa2UvSUszb0JFenlVT0FKWk9VeHhxcnpzbG5DRkNtUEJl?=
 =?utf-8?B?QzNpY0xSR3pwdS9NNnRaOWxhbVM1a0hBbEw0VHgwVG5haG5NSkU2K1NuVm1B?=
 =?utf-8?B?SnlhOUFKV3RESWhxUHkzeFAyNzgyeElSd010OHNCOXUyQzUwell3ckpyU1A0?=
 =?utf-8?B?ZCtXWEMwZTVJZ1ZKNERsR0pwOXdxSW5ScXN1SCt6ZjJDSkdaMEM3MmJxTFh4?=
 =?utf-8?B?WDBJd1Y3ZTIzWDJLTXoxMmxIbnBPTWVuOWVCVzRZb3hpVkRWczdwNFhkRktG?=
 =?utf-8?B?b0tFakdxcTc4OXgzM0ZudmRtSHNwaUFZOCtvRlBNNDRXenVQaTRSTEEvYWNU?=
 =?utf-8?B?L3FpM1o2NVZscGNjRHpiZEtYVGFTTHE3VXRWOW9sS1J2Tk9PUXJ4UnBLSWZW?=
 =?utf-8?B?SUR1Yng5bkZFYXVvSkROQUVVWDJUOHdGUDhiVXB5dGRNMUpscUQzdFA5V2pH?=
 =?utf-8?B?YTk2MGZreUNxcDBwVTRzNlB4T2NVM1ZKT0RyT1BEaTBwYkdUNExvWmMxV1Nt?=
 =?utf-8?B?NVdSMDlLZWtUdkIxejhORUdISTQ2bVZTdmxqRUVkN3BtUHNyWnowRzNCVmhB?=
 =?utf-8?B?RDVyWDdScVpBU3QxMjBuL3JRaWVtZGZ4NHNzN1c4Y25zTklwdmdnZ09obnhU?=
 =?utf-8?B?cU1uZ1Q0akVHUmNablBaNU5La2VTc1VnRDNoQ2JPWWg3RGxmckxSMWpQY04x?=
 =?utf-8?B?OEhRRHFkWEtPSUp0UXNzT0s2TEtQL0tSZnlBMnVSY05MVEFqejlHTHBtaWUy?=
 =?utf-8?B?MzVBY3U1YndjblhvZE9hSHh1dEMwUUxyT1l0MWVhdHNmTkN2eWRzS0h4OXND?=
 =?utf-8?B?YUEzRDQ4SFl4c25GUnpmUWg3Q1lwTHJGOXR5UVBFa2xwNFM0V1RMR0J0ODBQ?=
 =?utf-8?B?aG5MdGVPdzA0WkFNbXBXdWs0Qllqci9aY0E5VlYydGUvNk9yN3BCdGl4aWlm?=
 =?utf-8?B?WXpJMEZSdHptSEZyR3hHZmRJVHh0QXp3bUNzZitXSjY1WkdqVkJLRUVscHpM?=
 =?utf-8?B?eUt5Y1VtcFdvZ3lDcUFkb2MyYzRJNUkzUzlCUmhPWm9Tb3RhRG9kN2JlcXFn?=
 =?utf-8?B?WlJrOFRXbUQxck1Zb29TckdZKzMzMjNCWXIzeC9wbDRWK29ic2NXTk1uc012?=
 =?utf-8?B?SnY3QjdGVzhTL0I5WjBVaEtnY255dTdhSjhLRGJsRElhME5IZmkreEtoeEpx?=
 =?utf-8?B?OUZzTTJvQVVEeEVOazN6UVp4NXozd3Z5T1kraUF5cVZjbCtzNlQ4RnB2aWtB?=
 =?utf-8?B?K0Q0em51eDAzZEQwSWxWSlp2ZW00L3N5NE0xQU1OOHRnb0ZxZ3QxckgvRVhH?=
 =?utf-8?B?WkRRT1g1anRiUEp1WmlGaUl4Qm1MY0I2T0dVK3pBUkc0YW1IZ0ZCc1JZL0Nm?=
 =?utf-8?B?bEsyZ1d5KzBkaXowTVY5V0g3R3FiZ2o4NkRQemNYdVVGWk43a1dSdEJYUmQr?=
 =?utf-8?B?OHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	IlpFybivSq+zTXT+BBtDVZH/TKujCC6a1ZjUk/wEaKaiMJoa+Gzyaq93hxp5gZDOS2f1SUqn4EdCYl91/WTrhnTKDKQdC0T9tlLFeyLclRw7kTxa6/DluhvPMjNBOL1WPhWBZuT7yRPUnss2M43jbQe8LGGRkEUU7RHWh0gj9P8CsM0Y8BWty6kiZ6dLr7lh4djkH/HHwVr+ZEx5Oa/jqdHM1AvAG9OIBtyaDFLXrTpZKy08IAXYUNAJpuFhsX+9yu69PoTwysEeZZ65y77GO7gPfOkBlrs9r9Ab+qGAWO9PgP34hLIjLNejFmTeIyNxPVgG8tqoBd4Lfr/Waj4zdNmvY6QmJcI5QczMW+0C6p+sEcRFUOLAxiEJyDaS0aqATowro6fv7RId8wAFedCSdZwTf++OPPrFMYO+XsmVOlsl0IdodoiFodRD1Lha/syo55RRXsM0FPEizYd2H+o8VjgKLPQWZ2MBLjnX5o/NluZDfdNPkEzMPl1R67HnWTdsb31NLRrtZw5edTwJml4TOqIxXHFb6GqZsCoW+1LsoaEf9ZPqlaoeAVimBAmqQuESHFfJ7ymXgrydSgN9vGerofYuhXN3bvBqE5bTzn3yLIM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e165e2aa-81ea-4742-cf07-08dd898d696a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2025 15:24:20.9756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I3syv3Flr/Zd4KTdD5WHOdkkMBKWGkHbK5el8vqlib4XSRnB1/H+c1zQvRFIRv9PTX3ZPcbwolEhijLnVRX8Jy3FDCdcM3aUNcmXqwbMUrE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8128
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-02_02,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505020123
X-Authority-Analysis: v=2.4 cv=dfSA3WXe c=1 sm=1 tr=0 ts=6814e3a9 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=1XWaLZrsAAAA:8 a=Z9IJzZhQsot9hskOVcwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=PG6Q-FFm6skA:10
X-Proofpoint-GUID: oLQALXve87ittKf5LViiFMXILHkzaCTc
X-Proofpoint-ORIG-GUID: oLQALXve87ittKf5LViiFMXILHkzaCTc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAyMDEyMyBTYWx0ZWRfX97e5nydb/tlJ J54OwkGGBhNXHQ0kkB4MURxaKMnBx3EmgflA0YFG2mjhYTRwGMMQaiviMALqlf7YYIGKhk2XnbG HHIfMQGn8j6DPMDPZwPhJNsEzn7qqOboSYpgThvP6B+2g1K0+QzTXLJwgB5Y/JJkhacFkd7Vuyg
 BXR6R+m8wjn3gunNPm3SXh7WB3oq2M4IsSpjpVKQWLkA2x59ZfsAttOGDNsXmCsy3j+wcuvqArW HhR2Q8++aHLZzLIORT3ANXKzzGEG5UKcDRetCoH2l6nqkSBAgMSn2TATBliuR9NDBOOc4d84+T0 0oM9R3aV5tqum0V1ALuSHZZKTayn7Z4whAFcEVUHWo7rjMrosgp+aaKprvuZKE+J9PEx5RXVbQP
 lL6ozeGBoT8v1VH95YSDcFosZS9G69FY3K/0CP9gM3tHWp2dTTHwipFWu6qDH2PTIykP78Ob

On Fri, May 02, 2025 at 05:18:54PM +0200, David Hildenbrand wrote:
> On 02.05.25 14:50, Jann Horn wrote:
> > On Fri, May 2, 2025 at 8:29 AM David Hildenbrand <david@redhat.com> wrote:
> > > On 02.05.25 00:29, Nico Pache wrote:
> > > > On Wed, Apr 30, 2025 at 2:53 PM Jann Horn <jannh@google.com> wrote:
> > > > >
> > > > > On Mon, Apr 28, 2025 at 8:12 PM Nico Pache <npache@redhat.com> wrote:
> > > > > > Introduce the ability for khugepaged to collapse to different mTHP sizes.
> > > > > > While scanning PMD ranges for potential collapse candidates, keep track
> > > > > > of pages in KHUGEPAGED_MIN_MTHP_ORDER chunks via a bitmap. Each bit
> > > > > > represents a utilized region of order KHUGEPAGED_MIN_MTHP_ORDER ptes. If
> > > > > > mTHPs are enabled we remove the restriction of max_ptes_none during the
> > > > > > scan phase so we dont bailout early and miss potential mTHP candidates.
> > > > > >
> > > > > > After the scan is complete we will perform binary recursion on the
> > > > > > bitmap to determine which mTHP size would be most efficient to collapse
> > > > > > to. max_ptes_none will be scaled by the attempted collapse order to
> > > > > > determine how full a THP must be to be eligible.
> > > > > >
> > > > > > If a mTHP collapse is attempted, but contains swapped out, or shared
> > > > > > pages, we dont perform the collapse.
> > > > > [...]
> > > > > > @@ -1208,11 +1211,12 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
> > > > > >           vma_start_write(vma);
> > > > > >           anon_vma_lock_write(vma->anon_vma);
> > > > > >
> > > > > > -       mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm, address,
> > > > > > -                               address + HPAGE_PMD_SIZE);
> > > > > > +       mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm, _address,
> > > > > > +                               _address + (PAGE_SIZE << order));
> > > > > >           mmu_notifier_invalidate_range_start(&range);
> > > > > >
> > > > > >           pmd_ptl = pmd_lock(mm, pmd); /* probably unnecessary */
> > > > > > +
> > > > > >           /*
> > > > > >            * This removes any huge TLB entry from the CPU so we won't allow
> > > > > >            * huge and small TLB entries for the same virtual address to
> > > > >
> > > > > It's not visible in this diff, but we're about to do a
> > > > > pmdp_collapse_flush() here. pmdp_collapse_flush() tears down the
> > > > > entire page table, meaning it tears down 2MiB of address space; and it
> > > > > assumes that the entire page table exclusively corresponds to the
> > > > > current VMA.
> > > > >
> > > > > I think you'll need to ensure that the pmdp_collapse_flush() only
> > > > > happens for full-size THP, and that mTHP only tears down individual
> > > > > PTEs in the relevant range. (That code might get a bit messy, since
> > > > > the existing THP code tears down PTEs in a detached page table, while
> > > > > mTHP would have to do it in a still-attached page table.)
> > > > Hi Jann!
> > > >
> > > > I was under the impression that this is needed to prevent GUP-fast
> > > > races (and potentially others).
> >
> > Why would you need to touch the PMD entry to prevent GUP-fast races for mTHP?
> >
> > > > As you state here, conceptually the PMD case is, detach the PMD, do
> > > > the collapse, then reinstall the PMD (similarly to how the system
> > > > recovers from a failed PMD collapse). I tried to keep the current
> > > > locking behavior as it seemed the easiest way to get it right (and not
> > > > break anything). So I keep the PMD detaching and reinstalling for the
> > > > mTHP case too. As Hugh points out I am releasing the anon lock too
> > > > early. I will comment further on his response.
> >
> > As I see it, you're not "keeping" the current locking behavior; you're
> > making a big implicit locking change by reusing a codepath designed
> > for PMD THP for mTHP, where the page table may not be exclusively
> > owned by one VMA.
>
> That is not the intention. The intention in this series (at least as we
> discussed) was to not do it across VMAs; that is considered the next logical
> step (which will be especially relevant on arm64 IMHO).
>
> >
> > > > As I familiarize myself with the code more, I do see potential code
> > > > improvements/cleanups and locking improvements, but I was going to
> > > > leave those to a later series.
> > >
> > > Right, the simplest approach on top of the current PMD collapse is to do
> > > exactly what we do in the PMD case, including the locking: which
> > > apparently is no completely the same yet :).
> > >
> > > Instead of installing a PMD THP, we modify the page table and remap that.
> > >
> > > Moving from the PMD lock to the PTE lock will not make a big change in
> > > practice for most cases: we already must disable essentially all page
> > > table walkers (vma lock, mmap lock in write, rmap lock in write).
> > >
> > > The PMDP clear+flush is primarily to disable the last possible set of
> > > page table walkers: (1) HW modifications and (2) GUP-fast.
> > >
> > > So after the PMDP clear+flush we know that (A) HW can not modify the
> > > pages concurrently and (B) GUP-fast cannot succeed anymore.
> > >
> > > The issue with PTEP clear+flush is that we will have to remember all PTE
> > > values, to reset them if anything goes wrong. Using a single PMD value
> > > is arguably simpler. And then, the benefit vs. complexity is unclear.
> > >
> > > Certainly something to look into later, but not a requirement for the
> > > first support,
> >
> > As I understand, one rule we currently have in MM is that an operation
> > that logically operates on one VMA (VMA 1) does not touch the page
> > tables of other VMAs (VMA 2) in any way, except that it may walk page
> > tables that cover address space that intersects with both VMA 1 and
> > VMA 2, and create such page tables if they are missing.
>
> Yes, absolutely. That must not happen. And I think I raised it as a problem
> in reply to one of Dev's series.
>
> If this series does not rely on that it must be fixed.
>
> >
> > This proposed patch changes that, without explicitly discussing this
> > locking change.
>
> Yes, that must not happen. We must not zap a PMD to temporarily replace it
> with a pmd_none() entry if any other sane page table walker could stumble
> over it.
>
> This includes another VMA that is not write-locked that could span the PMD.

I feel like we should document these restrictions somewhere :)

Perhaps in a new page table walker doc, or on the
https://origin.kernel.org/doc/html/latest/mm/process_addrs.html page.

Which sounds like I'm volunteering myself to do so doesn't it...

[adds to todo...]

>
> --
> Cheers,
>
> David / dhildenb
>
