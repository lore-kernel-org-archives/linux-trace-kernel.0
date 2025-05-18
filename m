Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119321E4AE;
	Sun, 18 May 2025 03:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747537557; cv=fail; b=B6w6sdoo67xAIFGUDRdk6WwAKG+UapeQUG5sdY7lcH2x3pCgjX4nsz924R0L8sQj5+Z0FqNhAaMOOkCYP19aTyKvoEqCiPTj85Ot8zoQx9YB76UU94d384p6X0GFhZv4kAclU4GOrBFm3cwMsjkman1fXFsSNOPaRaaNZnaAHGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747537557; c=relaxed/simple;
	bh=9ZDas1f0scmQylh7y86e+PmIWqjdaJ1hMh+JGpJd9yM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZcmgQo1gMtFcLr+97HPlfLmgVHjKCd38INIbakKOsRjqJ342A1RfDAeA8eaLLZEKnvJna3iAj5bKrq4biZsaFGA/d1A4BbPk/ltSq1FMZiM2qaP8ehXJEnR9CVgoMKuilSEs6PLKMQNU9tPYf0P8pHlII9iK2LcNdLZBYpcrOa0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HiXDMUYc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QJztIriV; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HiXDMUYc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QJztIriV"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54HIi18U022618;
	Sun, 18 May 2025 03:05:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=znXk9oiIYnj3K+1N5EDXtBe9gbmbD/HcKOFPRs9gMCc=; b=
	HiXDMUYcWYGJcFhVQ8SOqi5mXwFYTPAm6vxPYys13cgg73IQyBnkg1ozaoKVGxi6
	T2Af00VBJAKcAF6bwwArTG7LJmaRzQlG3XCnT+RvjV9pVaruEDYR0DqvW4I3Sn1p
	xWXXcbVSDMdRnLQbwkcrKrc4nplbHZLbMdMwj09Xvlbj1XYj1CYtyLmWh9zkQG+d
	NJhjZXpKN6FT0pMRkxf6VPg6Ja/QWYl57EDXnxO8HpOGuZ9pjHtx84gUzXVCuLY5
	p30kkmkI/bucgAY0kpdteRp0aBQddt/2kV8suk89Qryo3D7Al384t9EtMlFHqGiv
	1B8M8DdhYVuhR8njYpiq9g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46pjbcrut4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 18 May 2025 03:05:00 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54I0uiRQ034571;
	Sun, 18 May 2025 03:04:59 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazlp17010007.outbound.protection.outlook.com [40.93.1.7])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46pgw5k6xd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 18 May 2025 03:04:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ubMR0mZZO4mHl2lq7IyRU2Iy3mN/IALquCBpJlM1ILQNv6zRIfPjpEyikzvc+SR8Fe/ymJLfK6H1rRsvhbkq/fOlEliVelH0UN3jBtmd8PxKPBvGd80T8tkjNL1R27h1MXjfSjOR6lCnZQiPH43gGr04XuJKZqZ5+QsDs2HW+ltC++ktXUuT6x2ELJoG+UYacHygHrMnHmLONwPwV6HvcZa6ZulQLxCuYI51S57aLtSdo9LVeBeqmAdn37u4hQ3VOgpo+Id/SXj2LltNC0EpGIHQ67RAVw2f59gmT0O/M5Xu3d5xebgdiMCU28jJv2b24MlpKy1nW8hkanlhFCa25g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=znXk9oiIYnj3K+1N5EDXtBe9gbmbD/HcKOFPRs9gMCc=;
 b=AOt/4lnu0HuuZkEWqR5VFSrrv3kj8NLi+zkK4mNWLyjOlydI/YfM9WZzTERIsq5fhTPyuIcmPCQPDzHqE2OZ0pFSRAeWEbJScSezXEr0DDJUWZtpIeeRSgO+gNNwcd6q33cs/XaRUY70TJYXR0/elHZNxQ9jTr8lbG95w5s/GagmBkiHIFvBB3Ud+ONJq5QOqkfPQW1pBQgDAPzY20rk1aPN7NqBTDPb8gG2KXKjjPwv5zUgNHRMgZ7jwMDzn8J+Xtjdy59vci0iel3bYXekzRXBjzgYKeAWbErVNSXxEnZEZbJtlvH7IfgFfbfwpmY7rMPm4NMRRClxGXfcGkbICA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=znXk9oiIYnj3K+1N5EDXtBe9gbmbD/HcKOFPRs9gMCc=;
 b=QJztIriVdcokY/xZBcpfXkuSk9vTuQ3mcwzcTUyU2HikBfAGzGDRG2j9wegNsKmM8b84t6pLMlyGmNz34CqQVGYeNT9wPvoChGLB2yCvLICvhtwMGG7C7qxvw74xT0yDorIR/dZY/j3z6ePDI+pcLMKY69lXqDPvLAQbSKtLcm4=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by BL3PR10MB6089.namprd10.prod.outlook.com (2603:10b6:208:3b5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Sun, 18 May
 2025 03:04:54 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%6]) with mapi id 15.20.8722.031; Sun, 18 May 2025
 03:04:54 +0000
Date: Sat, 17 May 2025 23:04:46 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Nico Pache <npache@redhat.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, david@redhat.com, ziy@nvidia.com,
        lorenzo.stoakes@oracle.com, ryan.roberts@arm.com, dev.jain@arm.com,
        corbet@lwn.net, rostedt@goodmis.org, mhiramat@kernel.org,
        mathieu.desnoyers@efficios.com, akpm@linux-foundation.org,
        baohua@kernel.org, willy@infradead.org, peterx@redhat.com,
        wangkefeng.wang@huawei.com, usamaarif642@gmail.com,
        sunnanyong@huawei.com, vishal.moola@gmail.com,
        thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com,
        kirill.shutemov@linux.intel.com, aarcange@redhat.com,
        raquini@redhat.com, anshuman.khandual@arm.com, catalin.marinas@arm.com,
        tiwai@suse.de, will@kernel.org, dave.hansen@linux.intel.com,
        jack@suse.cz, cl@gentwo.org, jglisse@google.com, surenb@google.com,
        zokeefe@google.com, hannes@cmpxchg.org, rientjes@google.com,
        mhocko@suse.com, rdunlap@infradead.org
Subject: Re: [PATCH v7 06/12] khugepaged: introduce khugepaged_scan_bitmap
 for mTHP support
Message-ID: <u5sycz2owaxowcd5mzwqztkkgb2mgt662rm5zllirgxmk6lwex@wyzh7aw44rji>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Nico Pache <npache@redhat.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	david@redhat.com, ziy@nvidia.com, lorenzo.stoakes@oracle.com, ryan.roberts@arm.com, 
	dev.jain@arm.com, corbet@lwn.net, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, akpm@linux-foundation.org, baohua@kernel.org, 
	willy@infradead.org, peterx@redhat.com, wangkefeng.wang@huawei.com, 
	usamaarif642@gmail.com, sunnanyong@huawei.com, vishal.moola@gmail.com, 
	thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com, kirill.shutemov@linux.intel.com, 
	aarcange@redhat.com, raquini@redhat.com, anshuman.khandual@arm.com, 
	catalin.marinas@arm.com, tiwai@suse.de, will@kernel.org, dave.hansen@linux.intel.com, 
	jack@suse.cz, cl@gentwo.org, jglisse@google.com, surenb@google.com, 
	zokeefe@google.com, hannes@cmpxchg.org, rientjes@google.com, mhocko@suse.com, 
	rdunlap@infradead.org
References: <20250515032226.128900-1-npache@redhat.com>
 <20250515032226.128900-7-npache@redhat.com>
 <9c54397f-3cbf-4fa2-bf69-ba89613d355f@linux.alibaba.com>
 <CAA1CXcC9MB2Nw4MmGajESfH8DhAsh4QvTj4ABG3+Rg2iPi087w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAA1CXcC9MB2Nw4MmGajESfH8DhAsh4QvTj4ABG3+Rg2iPi087w@mail.gmail.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YQBPR0101CA0351.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6b::10) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|BL3PR10MB6089:EE_
X-MS-Office365-Filtering-Correlation-Id: b04f47cb-0be7-4c7d-11e7-08dd95b8c326
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NXdCNUcvRGttQWFKYkwzUFQ5OU5LZHE4OGhEdzNPR3VsTENkTHFIblk1V21D?=
 =?utf-8?B?K2s0MnFjYVkySEpTbWVtMWpMbTFHQUxOYktzL285VjdycEk5cUtIODB2SWVF?=
 =?utf-8?B?NDNNMlB6ajV4akdEeEVwcUJlMDlJenE3a0hhRkZFWTlXVGJhdmhabkY1MzIz?=
 =?utf-8?B?cDkxZE03MGlDT0xmUEVNc0N5Ky9EVkIxa240NUVZeGdqSjIwaGpKRG40UzJh?=
 =?utf-8?B?V1ZUblIwY0hlTXZpT01zNytRbWdaS1RUckFxa2EvWkpQeHYvKzRZQk9yM01D?=
 =?utf-8?B?Q2JpdTVVN0pNQzhESkw4M255anpiWWw4ZC9JaTc2Tlp2RjNoZjJJZHNXeGUy?=
 =?utf-8?B?SFJ3aVk5R3d5R3g0SExETkpvMDJ4TDh3Y2xJMVlOd3BGRDFUMXg5aTQ4MDI0?=
 =?utf-8?B?OVA3U2xWV2k0MTJISjNXbGh5dGNRUFVoQ0dPT0E4Mm83eE9GZFJ5ZlVnSUZU?=
 =?utf-8?B?Vnp5eFNFT0poVFpsWmYrcmM1NExXdEIyTW5Vb3RrNm9kc2dWVXNNS2l3QnhR?=
 =?utf-8?B?d3IxUkc3OTU5LzB3b29yWkZpbGI3dkhrVVU2NkFQR2hBVndJdWxWQm5CYTcv?=
 =?utf-8?B?ZFZ5YmdOaFg0R0JVQU10ajhUa3UzeDFBMWw4NDBQZlVBOHBxTFlqT1JSR3I5?=
 =?utf-8?B?cFRsOXdqQjFrTFYyWFc5MU9hVXQrSEcxU3J5WE83b21wWHhQVE15V2JDdWNV?=
 =?utf-8?B?Wi8rSDZEUSt0NWtxTTRjQndnMk5aN1dNdGVEcDkvdUxZMndEUE1SRmdrb0Qr?=
 =?utf-8?B?Q1haRUVpQXJydmFJS0VIYWV0RkVNU0FQZmFUV1p6K25TU1ozazRva2FuaHV5?=
 =?utf-8?B?ZzNMMkVNTWhveExvRGFsSjViazFtbDF2eTBrbCtscTdDRlVBNmYxaXBZWUY3?=
 =?utf-8?B?K1hQR0laTlVhTzQ5OTl6ZHBvQlZFcTNiNmlCaWRhTjc4OUtRTU4wNGZraE5t?=
 =?utf-8?B?U3ZDUTN0bEM3Y29MeStJdnBiSm9CV0FvL3FXbGhjM2Vac0ZYRjY3dHlLa0Ux?=
 =?utf-8?B?ZFVjRzI3Ukxka0IxcHJzdGpKOEorb1VSa28yZzdBb0hPVEd5RVJKQXVRcmc0?=
 =?utf-8?B?SUZuWFlvQVFsdXBydlRNWmpRSjdnWmZmK1NrQ3FubWFCZENYeWFhdEU1Ky9t?=
 =?utf-8?B?cHhsK29iemZ4QzgveWVNdldFaVVocnJRV0tObGVLSHZhZ1BaTUQwVklxeklo?=
 =?utf-8?B?RmlaQnprZWhKSWcyMzM2WUxDMUxpOEZET09QdG1aNi9mMHYvV0hWazYrUDdo?=
 =?utf-8?B?dWtadTd2M1JycXh0QnF5K09CYVloQWZHRk05SmhqaGJ1T2Q1STNDSmU2N0JW?=
 =?utf-8?B?cXEyMm41M3BMdVA0dHRrSk5UV0RiSUVib3F5Rzc0bk45VWI5Q2pwKytMZ0l5?=
 =?utf-8?B?SmVza1VMZGI4VEV4YUdhRDdvd2tIUFFkaC9TV2RPcHd0aElOeHF4UlpZTGRJ?=
 =?utf-8?B?UmlvTGNPNE5Oc1B3Y0x3eW9kV2RIWWVZNmZvR1Y3WGMyMVBkZTZDUHl2WFRo?=
 =?utf-8?B?YnJsdUdCdS9RdWR4bis5QmFwTVNLeHB6eXBNUUFEVVFmaDE4TmcreVZ1S2Jo?=
 =?utf-8?B?Q3ppVk42ZnVneXJ0eW1YVy91WERjNS9zMDVwcURwa2NPa0VKVWZiVks3YVFH?=
 =?utf-8?B?ZXFUSWFKRGlhT0ttck0vRWNZOWNDTC9sN05qOFo4ZmlldDNSVWdsOGE5cjlR?=
 =?utf-8?B?aXJnRkFtTVRYVlJsTXczVHU0RjkrRDg3VURXYzMyTTY3b0VGMG41ZW43UUR2?=
 =?utf-8?B?Y1lZUmxzZ2xxellrTjlzeGZYNk1HaThVZFY1Y2xnOStYTkVsbjB6RkErdUV5?=
 =?utf-8?B?cmdqS011SHVSYVhLSDJKcUgya3JSZ3RIMVZTT1E2TlNTaVFHbDVDSmFBNkxm?=
 =?utf-8?B?N3lpWDdSMnl4SzNndy9kWXJzOXFqYVlWejNKODRHNTEvYkJOUk5SVkdsVmRC?=
 =?utf-8?Q?UR4Is7k1ATA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZjNjdWZPMU9vL1VkcUZPMDdYaTk2ODhkamRrN0hHNzhscHJSdmh5aUhhRVY2?=
 =?utf-8?B?bGRXVisxbmZlcHZOZ0YwN0o5S09aSWpkRFVWbG9pVzZJVnd6RnVBeEI0QmZ4?=
 =?utf-8?B?bWxkbExhK2dqdFFDVFFTL0xKamllRC9FVHR2dSt0aFVqL3VOM1p6T1IvZUwv?=
 =?utf-8?B?b0Q0QXp2NithcGVxV2M1dm15ZXVtdFk5bUl6VnZsSGdqN3VxS1BYTkw5NDlP?=
 =?utf-8?B?djJaNWUrUFRmQlhtQ0hmeEJDM0orR3NXbGlLMERwUnJVUTlDT3BudFZuY291?=
 =?utf-8?B?N2FVYmFFNXFNTFdPSWtSeVlnWXdycmluRkg2VmF1azl3dXN3d1VIUkY4YSs2?=
 =?utf-8?B?STV6bUczK1oraU1XSDZwOUMrQ1NmZG80MVpqdHo0UFdiRGQySkh2YWc1Mkxv?=
 =?utf-8?B?L3FybUJVd29lb0VsS1NGMXFwb0VLNndFa0V5d2ZOUWIvVXN3T2VTcjFERUpU?=
 =?utf-8?B?cDkrTGJQdzk0elpiU2JocFhZYS9zdGswY2xEWktteFc2Q2U5TTI5b2IzNW1S?=
 =?utf-8?B?U1lPcWVqZUNvRjJVODlxYmtYK2RBL1hoeHZyTWxtYmdjUHE0aUswUjFxOWtW?=
 =?utf-8?B?QUR2OHk5Z3VuRmxiMFJmV3dUbFdNcDZYQkhiT2taYVdTTHFTdkVBRDU4TVJ0?=
 =?utf-8?B?YTVmV3krZWs2TGx4UHVnVU1vWW0zVHZLNnNSZWFVaUNDcUVVSG5leCt3ckJy?=
 =?utf-8?B?NDhKczNuREZUdytmUnBKR2luUlJlMDhBZ1QybG02UDU2Zkd3eDFMSnljZTlz?=
 =?utf-8?B?RFVIdGpLbU92QVY1MVVzaEhtSlRDbFBRdWoyWVNzTnhiNTBJaHlQaW1QVjcw?=
 =?utf-8?B?MkpjUnl2K3FaNFRzOG4rbXBLc2VLMVU4eHNsaWk5VDRnUzRxeFlGVTJkZmpo?=
 =?utf-8?B?eG96UmZCdnJSZFBteklPNHgyWjFQbENxY2dGY2pvZlFKa3o1TEFCZU1LazJ6?=
 =?utf-8?B?NFducDhIZDZXRmFLYXh1SlhSQU9oZHlmbVp5QXFXYU8yc2JJNExYVk00aUdi?=
 =?utf-8?B?N2x3YkwwdTlGcHovbUhTUGN1KzdacU1lSmh2OUdBZUNjUFZmQ01yYjdCeXRi?=
 =?utf-8?B?cnpwSml4SHUreEdLS2xVZ3VVTEo1MnNxcytxMzQwVVFXOWV6VmhkQlhZd05p?=
 =?utf-8?B?b0RNWEhHcjhJeFFOakhhMzdjUlR0MEFqR1VnNFZWQUE1NHpJUG9KWW5tcDdt?=
 =?utf-8?B?RlJpUEtzeU5Zc1h1dG9WclJTaWhrcllrRWVPVzJiS0QyaU1mZlNhU2Q3SHll?=
 =?utf-8?B?amFjRnNGdUJHN21rOFUxSGF6U2tScW9JY050Y1dnNkwvbVNqSHo0ZzNTUEFK?=
 =?utf-8?B?dDFQWGZ3RzloV1JxVlMvUGNHaXJDWFhOU3BjelZMYVduZlBtbjkzeG5YaDBP?=
 =?utf-8?B?VFhvSnNZYWxISkcwNlZmQW5rU1Nyd2VKSFRtUmx3bUdDeitweUM2RzFUa2tH?=
 =?utf-8?B?RjRRTHRIaUFDYlBta1RmRUhJbHhpT25PdkIydjZxNElkOC9OQ1Z3cjJoekxs?=
 =?utf-8?B?SUJoQy9xdkYxd1YyZThJTGV2bFF6TWRaRkgzaDdvRUs5cHhIbUdETEtNbHRG?=
 =?utf-8?B?T005VEEwbUNYWm03VisyazA5azdFTmJMUGxLcitmUWpQWkZrQTZJWnVmbEpH?=
 =?utf-8?B?KzA4Z1FHUHdnandmUHVxT2krdk9CRGxENVJFa2EwNzNFLzNtMXlxdnZFRW12?=
 =?utf-8?B?SGhrL2dmaHFpbVlPYXYzenAvWWkxSTNFKzg5d01qaWRDOExVS25xbytIVXhZ?=
 =?utf-8?B?bXI2eWtIZGlObGdxY1dQNjNSMU9kQTRWUlZxUVVQK2t3czhyYnpQWFg3ZW1k?=
 =?utf-8?B?OXVrWitJS1piRWRzMmMwbjhIdUtIUVQwSzVFeG9CRHoyeno5eVh1S3BRcnBM?=
 =?utf-8?B?YmNxM2syMFIxYVRsT1YveDJrRy9GY0dxeHhPejJ2SlExZGhzZm9vUEdBY0hX?=
 =?utf-8?B?aDZ0eHl3T0lPUzg5NHk3SEtrckxGZitsb2k5Y2ZRbFI1aGNXT3djWCsvL05U?=
 =?utf-8?B?TGhMb3g1WXgrRkcyNTd0NXd5RjdpU1drQjErWHJkTnJ3R1VJSWw2WXRyQmk5?=
 =?utf-8?B?UUp5ZFhtV3lva2dUaFNtQ1NPdVFLNnZnRkJOOFUzK2RBYWpyR0tXUEVyTjMy?=
 =?utf-8?Q?Pn2f7KFAU6kY7AVCF+H+4Do4I?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZnL+30RSggTrFQGWWVQTWoYAVrGJCKlJa1PAY6aHxsNRnNMLWicyaSx6kyJ+efIn2UkBaM9L+qsNOPvY0ADueBEi3SzRhTFSGtuI1fahLMc4218b8evNfMKBL0X8ryLpi+7SrAqaqy9Lr7/Ffzwan5EwbwnlU5AR/+Zy8FCXRd7ZcwNTXqtPXrUwbfA0ZBFRQ3DIIUCguaAZxeVpDD7TvssHv+HZVWcYzwNendNduLrZnZ0r3x64E6M+Gfn6AWuGHs+a48HFZuSkoRAATTyycYGXdH0XQ+HdTcpxPwjqBl9rNS24e65uFUPBb9v2iWXs7XCf/InbObtv6mxjnEFNOkDmS15ot9jZn6jMbkQZPhMml3rr8vJegQQJ66HHJIOEPnW4P3K69pGdOLwAZ3b0WRD/d16XQ24Ejqr8PIW3DzaZmy9LONOujMo/t/uJE40HvOZO88wDUrkWlsSqoIpuI8cxQHJZQ0bmDOvBJt7Wq9RwkDAVuzMj4nQLft07PHYZ27v7f1TgVrN5J63D7xre18tQKF3JDo0EvJv2OHWCzY3dEc8UxqrLMXUHJcuGvXdLzdaRiknHq0/i1pT39YlhFPpNZXn8sQmS5rnOE/XsFC4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b04f47cb-0be7-4c7d-11e7-08dd95b8c326
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2025 03:04:53.8724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SmMNbvS/iGM9NoadweOf7WYnx1ThHk1h8rgdjcs+j/zVROQUCILLLuCP2j+A5KrKOqP51m3O8sfAbJhFo5IMcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6089
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-18_02,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505070000
 definitions=main-2505180026
X-Authority-Analysis: v=2.4 cv=ec09f6EH c=1 sm=1 tr=0 ts=68294e5c b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=SRrdq9N9AAAA:8 a=20KFwNOVAAAA:8 a=n4s8Xs2dg6neriXBFckA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: dsXay9eTqwERqg7rW16SnWgJGXvt2gfQ
X-Proofpoint-ORIG-GUID: dsXay9eTqwERqg7rW16SnWgJGXvt2gfQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE4MDAyNiBTYWx0ZWRfX2PVd95v5nquO v3WJ5F9+Vd21rwS1BelnWiqQV31q5UhlwsyMJp2AwUTq9BqmdlRv/M4NR/DKnBRRhdR1hV0viTJ FnbqsAxr91EInwWbIxMzT5lB+ug3hQX2609FD2biSuMoqqPSIL8+oswaKs34QDt21un28fQDKHC
 a3KpImPbJ+Rska4NfwuUTUVpKKOvDmmueeL1njR8FvX22LOcQ3gN43YcXgiMKwJWFqf46OhDSqf 12KgLXtk5HD2PcZoDk4CXweZLjOu8HaEwc8oTBK8dKrrxm8sk0BpskRCPpviQmTkPcP/o17Y9CG oF71Oiv9qYGcuo4oi8kmtwP3CGEKQL70OICJeuAHvXkcvnhaVrU7ZRCuHEst/kETn5rrbcEzO8Q
 QXk/lPxzpjApVya6K3GJYhdNGcIR/iul3TAhusmbOESVewNGxB9NAeqAc1ZhJrNBZJ5fqZxz

* Nico Pache <npache@redhat.com> [250517 02:48]:
> On Thu, May 15, 2025 at 9:20=E2=80=AFPM Baolin Wang
> <baolin.wang@linux.alibaba.com> wrote:
> >
> >
> >
> > On 2025/5/15 11:22, Nico Pache wrote:
> > > khugepaged scans anons PMD ranges for potential collapse to a hugepag=
e.
> > > To add mTHP support we use this scan to instead record chunks of util=
ized
> > > sections of the PMD.
> > >
> > > khugepaged_scan_bitmap uses a stack struct to recursively scan a bitm=
ap
> > > that represents chunks of utilized regions. We can then determine wha=
t
> > > mTHP size fits best and in the following patch, we set this bitmap wh=
ile
> > > scanning the anon PMD. A minimum collapse order of 2 is used as this =
is
> > > the lowest order supported by anon memory.
> > >
> > > max_ptes_none is used as a scale to determine how "full" an order mus=
t
> > > be before being considered for collapse.
> > >
> > > When attempting to collapse an order that has its order set to "alway=
s"
> > > lets always collapse to that order in a greedy manner without
> > > considering the number of bits set.
> > >
> > > Signed-off-by: Nico Pache <npache@redhat.com>
> >
> > Sigh. You still haven't addressed or explained the issues I previously
> > raised [1], so I don't know how to review this patch again...

Thanks Baolin for highlighting this.

> Can you still reproduce this issue?
> I can no longer reproduce this issue, that's why I posted... although
> I should have followed up, and looked into what the original issue
> was. Nothing really sticks out so perhaps something in mm-new was
> broken and pulled out... not sure.

This was verified as an issue by you and you didn't mention it in the
cover letter or the patches?  It's one thing if you need help testing
changes when you can't recreate the issue, but this is not the case
here.  What's worse is that you said you would look into it further, but
then dropped any mention of the issue.

Every comment on your patches should be treated as a bug report and
failure to address them (in code or reply) means your patches should not
be taken.  Otherwise things fall through the cracks (and then get picked
up by syzbot, followed by a CVE and a bounty collection - if we are
lucky).

>=20
> It should now follow the expected behavior, which is that no mTHP
> collapse occurs because if the PMD size is disabled so is khugepaged
> collapse.
>=20
> Lmk if you are still experiencing this issue please.
>=20

I'm sorry, but that's not how this process works.

Let us know if it's still an issue and detail the fix and/or cause of
the issue so that we are confident that it's handled diligently, and
know what to check to make sure the fix make sense.

Everyone misses things, but the fact that you are saying you should have
followed up, but are still requesting someone else figure it out is
troubling.  It points to an incomplete understanding of the issue(s).

Does it happen in mm-stable or mm-unstable with your patches?  Were
there other fixes that went in between the spins that may have affected
it?  Please take the time to fully understand what happened and why it
is no longer happening.

If you cannot get to the bottom of it, then don't send out another
revision - follow up to the initial comments and get help to dig deeper.
Maybe there is a bug here that has nothing to do with your patches, but
you have triggered it for some reason and we need more investigation.

I'm not willing to accept patches that now work for an unknown reason,
and neither should you.

> Cheers,
> -- Nico
> >
> > [1]
> > https://lore.kernel.org/all/83a66442-b7c7-42e7-af4e-fd211d8ed6f8@linux.=
alibaba.com/
> >
>=20

Thanks,
Liam

