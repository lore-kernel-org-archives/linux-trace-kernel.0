Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DD11D5CFB;
	Wed, 16 Jul 2025 15:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752678852; cv=fail; b=lLmVJdi06SvSUOkRccGykvYyRXa7a9a2QG8btakyXTZWjKgZBgULkBGMkOyYPFheWhGW8qmqtY/k6oMt5GwGE3vAlxukLDvxqWnMnqxEt+MYbM8MjMRhfK9JaHHka7O5d+/rBqQUyr6aeagxkJyDdfiqGOyPaArIjlEOetKf5Tc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752678852; c=relaxed/simple;
	bh=ZKFa3W6CR8XLjQBj5mXX0PBinfFpMCxIEQpu5P8Rz3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FHOn9hTnJrfWERVGC0hy3rY5egjZ/ApEi63MSE8mh30dPIpP11lwg+OQAcwXOnRnOwJPen/FzKUtJkEiJQ0yc2skgQQNAQ2/DXgh+8Db49vgbUPKOqkGOd0C8+oQwMIquj+3GaZGZboD27sjKZUGhutXn7oRDPbM0xpdhHEg7ZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nV1Ej4oz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RxvXfGS9; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nV1Ej4oz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RxvXfGS9"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56GEtnaX031967;
	Wed, 16 Jul 2025 15:13:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=3Fs//BuVO9WQE0rhfU
	WQM0LpAxFPgv90CaRjYLMCN00=; b=nV1Ej4ozk0kf/GCljgznJcltvlJldgUCUM
	NTjQVNFkkAUYvJzCVRwFYxRF4Xs7iWzBzj2+xb0skGp3nIm3gMuZwMGLgR6hP2in
	zyFfpaSofHsJm1960nznz6kp5TfxsEJVbohb7sWOcGHvUJKb75RJC6wa8HqEJKZC
	iIBS7UZCXYyDv+3FrS/k3SeuVZhVHgB5ou6DFSr/IN35NRL9GmDkUrucQol/mCxa
	ZTTjlS8L/xF41iQXnGn+PE+G7EejxvE2ZKckxdXAIvWMTQCk3EbLv1MaH0BRD43Y
	3ACb1dNwv03b1DsjkfqzT+kOC2926zQXgNLBs0dCWV16iufiMGPQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uk8g1727-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Jul 2025 15:13:29 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56GEFtY3029634;
	Wed, 16 Jul 2025 15:13:29 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11012001.outbound.protection.outlook.com [40.93.200.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5b73v4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Jul 2025 15:13:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wBGEkJVUYoGy8vJ5GE3Wc0SU49z/fH/21ct9wdMGErRQVLf56TbJHja1QNGxvqcc2aowckDFoxdBCPv29Wu9TiY3s7J5hkADXsjq4fEO7ZGnYk7eXV80oTr39J//6OwxtYX7zGUKib4Tmw+mGP4JkE1BmtskAQPqDulxC82l8ufLgk1ISzMuIF/tiB/DEZ3LjhHVeq4ZXCpbaNCLEk9qyEQs154rtigQg30mtA0cy1vFfMvel+pl/TpWRkNC7QycGxAtZ4i/Ng9Y45XzkmTarcvB50eZCVc3+Bs8kcOWcUgdAMLIM7QEabl/Z7W8aYenX+MfTZ8Ei+3r/GRY22n0LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Fs//BuVO9WQE0rhfUWQM0LpAxFPgv90CaRjYLMCN00=;
 b=tdzIRYx4yHW20JVxg+zIPscP8c7AdaJv/9+PJRoCyiEvT16vPt2dZGiSXobCLBb8f3PQU05C2UbYHtay1OHMs727P6RC87xa45djNhFegLOZNaVSYqESC2QcgnIEJ3JfK9d/C3WUIB7bWpzYFORP1uDfX4cG8oPtaDogoxZxGOISyZ+Zsy0Yv51EubsGn8Rj6yMrJ+1VS6nK4PikcWufjdb5NCqqkFt3fOO15sR3mPik1A5t8KqYzfmUSg+yleiOUZtSVCxcwq8uz9mf48ABJ+ObRo/NHnagW3gtIRBl7AQWqkRel/wlzQ7fcbVJ2O2LqQrq9iElCptirC0WynZ4Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Fs//BuVO9WQE0rhfUWQM0LpAxFPgv90CaRjYLMCN00=;
 b=RxvXfGS9PynC5wqofB5XlzDDpoJ1+1cF/2ks+mzjWl6Fkf5c/58xEm65FQ/GsSnQyjxsXY9MmkG8k8bvHgGkRAe4YZEu3MWQVbYCSi4hEY553G7YP0c9WRoylA9H9L1y/3VheeKTCjqKD1XZthpVyEnhyfc1pLhg+RLT4jZksTM=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by IA1PR10MB6878.namprd10.prod.outlook.com (2603:10b6:208:422::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Wed, 16 Jul
 2025 15:13:04 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%6]) with mapi id 15.20.8880.015; Wed, 16 Jul 2025
 15:13:03 +0000
Date: Wed, 16 Jul 2025 11:12:57 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Nico Pache <npache@redhat.com>
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
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
        mhocko@suse.com, rdunlap@infradead.org, hughd@google.com
Subject: Re: [PATCH v9 02/14] introduce collapse_single_pmd to unify
 khugepaged and madvise_collapse
Message-ID: <ifgx5ufi3qxcw7cj2nmkui56xsen5pifd7utv4v7firbjhotuk@2fozz3b7adwk>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Nico Pache <npache@redhat.com>, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, david@redhat.com, 
	ziy@nvidia.com, baolin.wang@linux.alibaba.com, lorenzo.stoakes@oracle.com, 
	ryan.roberts@arm.com, dev.jain@arm.com, corbet@lwn.net, rostedt@goodmis.org, 
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com, akpm@linux-foundation.org, 
	baohua@kernel.org, willy@infradead.org, peterx@redhat.com, 
	wangkefeng.wang@huawei.com, usamaarif642@gmail.com, sunnanyong@huawei.com, 
	vishal.moola@gmail.com, thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com, 
	kirill.shutemov@linux.intel.com, aarcange@redhat.com, raquini@redhat.com, 
	anshuman.khandual@arm.com, catalin.marinas@arm.com, tiwai@suse.de, will@kernel.org, 
	dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org, jglisse@google.com, 
	surenb@google.com, zokeefe@google.com, hannes@cmpxchg.org, rientjes@google.com, 
	mhocko@suse.com, rdunlap@infradead.org, hughd@google.com
References: <20250714003207.113275-1-npache@redhat.com>
 <20250714003207.113275-3-npache@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714003207.113275-3-npache@redhat.com>
User-Agent: NeoMutt/20250510
X-ClientProxiedBy: YT3PR01CA0066.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::17) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|IA1PR10MB6878:EE_
X-MS-Office365-Filtering-Correlation-Id: c5d32ab6-4d3a-47dd-d028-08ddc47b4298
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4DdLXyShl06NFVHQDJAAOK6ABZysU82VVmQhASq/s1MycrJlc2Wf5wy4EitZ?=
 =?us-ascii?Q?bO95F1tvVQWqPmOVcUri9YA/HHyWOb/u/jxHrTx9/+Trp2ULWHJ8tel9kds/?=
 =?us-ascii?Q?36KyxpZTpA6nZRrhxI7VlA/3mTEQS+FkWtleObw0qAAwmPEd2Pn4stot2ZPW?=
 =?us-ascii?Q?ozRGpA67oWHXo0AJkjslzEFD5luWCusCT2x77TnfoADC/CoObREX2f8OipE3?=
 =?us-ascii?Q?TPLJoGt/BFgK363WVOzLWy/I04g4Tt2kG00/GqCzG4PEHIi5UG0nIAqgfyP0?=
 =?us-ascii?Q?WW9XYWxftftUPE5sde47D4gRz+/G/bAix27UwbD3Rp483NQgEh3SbvnYBvxr?=
 =?us-ascii?Q?aw85PXQSAirI0ST1b3EDqDPt+/EOQ2L5mSNz5hzvPoQQ55z5wv/ytM6Hsnvw?=
 =?us-ascii?Q?YYSWOYDfujlwNYgvXRp71wrcT3uyIhpWGEjx7wYZbORMPwGe0/pani4L/Fa1?=
 =?us-ascii?Q?wY9KzIURJdBFsRhFAV4Vkz1pOI0K1GvaJvX5SV9OtCLAIfThbDh6bWmxx/sA?=
 =?us-ascii?Q?He8G09y4b0Wv5/W50EMw/UdyfWvqNr8EkhQ2KpQubUPqTXhKdHuNUISfZNwP?=
 =?us-ascii?Q?9TLzjMUIQNkxVwDzYvMku8iG/PEQooXhasLrGQJDC1EwqM+UeZxm6mi3v3mQ?=
 =?us-ascii?Q?UKRQ5YvygxkHWEIpWDnkG4iMlvJUOQccNm3/HL1K2oH7Jh4qX4TNQ0CKveXA?=
 =?us-ascii?Q?MBMdy9eDcmCbNnV5AyN3nVtAXbyHB96pnf2Iv/534DVGA+1hkjOnKKz1sRfJ?=
 =?us-ascii?Q?atmYwEPrd46OzOPwYCfs9cMsroEZjfxqmhFo1FRV6TzaP8XtzkScLwsLpG2m?=
 =?us-ascii?Q?gATvQOXhZkv/CfbKFv6LgCKbo2guvzP3Yk8wZ9WXOy2yF7ca3QMV4D855eHU?=
 =?us-ascii?Q?09Nr304Sf0+iVzmZmC2mgrdRZ+HyRclDLFpr31P6YUKiVYlfPDkL8sCdf7hR?=
 =?us-ascii?Q?BSJI0lCLU1+9K797bzIjiEVi4D4t1GjeKzPm9RfIKhi/BU8u3tzF4OhalvRs?=
 =?us-ascii?Q?phvaD+J7ZgjjBXPHgvju657711wGnUKIhvB81No/cCWV16wiCPrKffxdm5Ur?=
 =?us-ascii?Q?DukXKxdRAgy5G74+nY3h7f/7fYf5I7NzptDOsl+rBfnxOFUv3/pNEu1uEJVa?=
 =?us-ascii?Q?98mfvEMpGXn+Md9Ky7trIGq9PYsGya/DkjfA1i5dylZabS0akDOiWLxkJtN9?=
 =?us-ascii?Q?s1tYqM2xDQCZCDw1jqMcRxNBzo3FfAMBwuPjMPHdNkQupmDJii0WQfDZXPCZ?=
 =?us-ascii?Q?GUPn7xgUxvCpq1gGRSnaOgAhdvcecAMK2Y7MWS96x8xWbaImxfE+Mv7LIdxh?=
 =?us-ascii?Q?zXbaHIaONNZ5Ow1p22n6PldJWK8Q1E1YJzhXmwmS62ibLwVgn5Cvx+G2EdHR?=
 =?us-ascii?Q?OLlYmlNKltO8ot5DKrx/EqgVMciC4kABVzet06aCDulq5a+XmXmnBzAVeUtd?=
 =?us-ascii?Q?ywj1sHJGH0c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?r9aBYhY/jCNEjAVnygo4iu+/C6naEMdZhi4Yw1DseIcLhGP1W8qBEzFUYqtq?=
 =?us-ascii?Q?lLMyTTiEdbdHKlZiodS/BYJ1u3nOCmYZ12AF4sztKzmGHROatUI6L2ALN4Aq?=
 =?us-ascii?Q?fVt00gSLuYMLE/BL64weDgT17+HUY3HIRgiaaU9texhsDfvGKG0vsZzq8itI?=
 =?us-ascii?Q?V4CD7rBW43kuPf3IDr5MFdDROsP7DwxqZnhHINF3xiMnlQUeBgzFoA4F4dgX?=
 =?us-ascii?Q?qVYGscBSWoua1nOOcEwMclbf8O4mpnyUNyrTSu+lSF8KfJzlY4wlJRwZ9RI3?=
 =?us-ascii?Q?QL1EUQX0SmS5f+id6OKNMKnrp4X1WOB5J8F9Y9uOQddbCtnh4RLuFg4csAzp?=
 =?us-ascii?Q?vWtBqLWbDIoEN7bn93OaKYvKitGSY63FuKO08jubuH8tOYJevGKSolBh6pH7?=
 =?us-ascii?Q?W5hG1LxHEElqO2BsgdPdjAoEgLAd90H65OHxGx6McGxzYYDqBB79ZYJGmx9H?=
 =?us-ascii?Q?v94vljtMvLV6hVlaY/5Gzkx6KG+YIaOMt2DD02l7CgkgIQ9NykTlidlX78I0?=
 =?us-ascii?Q?Zcs6rLghhZJ+Zv/2AragpPwDrbxLtLSjjGpW0lEKTsmh7PTED97IIsRunETY?=
 =?us-ascii?Q?Gp4HD3tsPeP1AYUhh1WtdVNWV/03aKHeoVzTx6B+4BciVOhSgn7wN/+XkoUt?=
 =?us-ascii?Q?EmonJwMRuNSJnBW5m+Kix96S3oppW6pJRMH2T6Y5/mC7QTjG31AjxFMpEl4c?=
 =?us-ascii?Q?GftGB+7aUWBW8Ovd58ytQpCCL4m3yIvtZE5GIELXcisdZoQh3zAEeTmUYbjr?=
 =?us-ascii?Q?HPWxL+GS9+MpYvZuLw3ao6ylCWvOsdMjXECnOjXT46lklC2mk5nnNbVj4VpL?=
 =?us-ascii?Q?70HaMkVnVR6Ws3ETGJuiF9EZrtWY2c2bLS2dwbRileV+fZWiu9RVnIPmbpcZ?=
 =?us-ascii?Q?QwxG2/MGo5S0zn966r9PQX6ReSxYknY4CDoHHH6vlogubFjtkKvERVkds8Hn?=
 =?us-ascii?Q?hhxfB5rE/03dh80+eYK/mKy9N07zNPCZg0eIX3WM13kGQxIF/b7IYLG9z0AF?=
 =?us-ascii?Q?Z7iO+bhxilXN4hFg5D8/dabxwUQEy4YM/OwiL6Jo2FAAqI1RIU/q3LkrzC1R?=
 =?us-ascii?Q?L7V5f2s94KD/ah2pJSBzg78kaI82hnvaLaqj+55CH0WuRVOY3oB+8Rbz9Thg?=
 =?us-ascii?Q?9nc8tGZzAtSaa0eAznrBQpc4wIqALHaCuKC9sYnGQTHelKRn0+1LwDR8eYFQ?=
 =?us-ascii?Q?0txK1l19oMwnMy/w4o2+ENxqHh0IIJ9/ccrrBH5UCQYy4pe+QhHXx3ZSd2no?=
 =?us-ascii?Q?aAmoUxDzVbg1eGP1+bRgFkRQ9yy10LjEg3AAkI/rq5mtJi/gzPZR8uT9Q7O4?=
 =?us-ascii?Q?+We5HqaubZq85TU946Cji4UH+HT6SmWRpCNnvUwtl5cbpbawG0ussrjy9Crq?=
 =?us-ascii?Q?t+K3IoArlFetxZ/MH8CtdwLjUrgz6YaUFz+LVOMCum5UZe/+0wLaR+bw5MSA?=
 =?us-ascii?Q?Q5Wh1m2asmhYw+6qJccWh9iaGs+GPLwdb0WWhvuyol+DYjXUR9BVCwz3uDL7?=
 =?us-ascii?Q?ynXEkTefjENMHIjqWt3iiaKMU03dpyTWuWHEP5frRYKpJG3keA7HMPskfAS9?=
 =?us-ascii?Q?qGimvyqhrWT8A0PZtMCQN/WnA3TnzhQneTbyTI9A?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DRmJeN8aNbMUC+s6K30malHPf5pAfYNgFvFiTB2m7268EPsdWKkuqvWVnz9bM3N3GON5BM0ql3fCeFNOmDSbdyytM61omU8YbHJIIaZBvzlxI3uVlXBz2Zg7jp1GSe5wxuV9glRhPY7reJnMc1Ye4eYEBO7ALk7gVaTvz/mvne+vV7LQcRgLfTubDqgm1vWrtk9FgiP8K1CbfXPNMOJy2r2biKGljLnRar2nRq0jcnPvUA9mSMtwZ76Qgr5KMxmBMdtef7VMHtLOPQ0gZWGMkHe6NbC6K6tmnQ28qbzw9rvO+ndacoHx+bdnkI8QUaoBwWjZQFhb2f1NZ3o7bv/zrNswa7wpM/5NaXxYuZi2vFeTHIcJk+awsghjNcnQoPCUnsC+SpqmO5wgOXzP8AayztzmJm7bhPP/Peg/K+kE8Fqt9KX9W413Gp9BbozrYEMJHBJN2nyp5neNZvu3royI1nxX/J+Ak4UFo4RKsezxG9/wh9nrmH50PCYCj1jittoH9ZdO73i2OC69E66RaJb5A0sMgFxSqxLbsGV+KFItCZIzXxn+TwTNMPBeBUx4rxRlKgzkBoRV3PbYiJCVX0KpJyiB2tps4b8BqnxdJqTjy3M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5d32ab6-4d3a-47dd-d028-08ddc47b4298
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 15:13:03.7922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eSMiKUlqSgjZh6aMUr0EBSXSkMHaemn5sfINW0ftpq4ppkSX+zySfRzbPZqQoSxnIdwj5ZcSgZWSaMfkW+ug3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6878
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_02,2025-07-16_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507160137
X-Proofpoint-ORIG-GUID: nr3tQdFf1Bl8ZYNtTEftHa74_WD4sXE1
X-Authority-Analysis: v=2.4 cv=Of+YDgTY c=1 sm=1 tr=0 ts=6877c199 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=20KFwNOVAAAA:8 a=SRrdq9N9AAAA:8 a=mwtmTy9cVi4GeO0HAU4A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: nr3tQdFf1Bl8ZYNtTEftHa74_WD4sXE1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDEzNyBTYWx0ZWRfXwHl4n9s9mP5H gLd+iatct23wHI1p6f/6w20Cp7lDn1mws70qB2MH7UE9bN07WeCDBbXHBxZko4xxnRICJZFfjY6 vIkRTKBklXqi6u4JqakKaeVr0SKny4jQnfDjC6EHz+D7Hlz4iq44TJ4Nki00VTt/iiwEJeD5myv
 +jrHgGbJon8b63EpZxgzK9RHVroT6v5sQUhBPLhmccxMMWOm1/vsqZkUv+1uFiHVW9Qhaovyl+T wSdbJiGuuWCplQoRWMnSqUg1LcncCfuluxz88TlLhBELh4gPu4dNeAtHEnzS59bWibvw2npXmgc TnnOMiDFRBqxkwLcovTTuwZLM78S/f5K+hbY+SiRAVeV19+awZ8zbTE+6OvWgSPqb7WoHWsmu/g
 Qnj2k+wXQSQgwuzKzjx8XLIM8ZqiEk8vT7ldX+r+v39uY1YX16PTKW7R3uNz3yn9chFmiVwC

* Nico Pache <npache@redhat.com> [250713 20:33]:
> The khugepaged daemon and madvise_collapse have two different
> implementations that do almost the same thing.
> 
> Create collapse_single_pmd to increase code reuse and create an entry
> point to these two users.
> 
> Refactor madvise_collapse and collapse_scan_mm_slot to use the new
> collapse_single_pmd function. This introduces a minor behavioral change
> that is most likely an undiscovered bug. The current implementation of
> khugepaged tests collapse_test_exit_or_disable before calling
> collapse_pte_mapped_thp, but we weren't doing it in the madvise_collapse
> case. By unifying these two callers madvise_collapse now also performs
> this check.
> 
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Signed-off-by: Nico Pache <npache@redhat.com>
> ---
>  mm/khugepaged.c | 95 +++++++++++++++++++++++++------------------------
>  1 file changed, 49 insertions(+), 46 deletions(-)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index eb0babb51868..47a80638af97 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -2362,6 +2362,50 @@ static int collapse_scan_file(struct mm_struct *mm, unsigned long addr,
>  	return result;
>  }
>  
> +/*
> + * Try to collapse a single PMD starting at a PMD aligned addr, and return
> + * the results.
> + */
> +static int collapse_single_pmd(unsigned long addr,
> +				   struct vm_area_struct *vma, bool *mmap_locked,
> +				   struct collapse_control *cc)
> +{
> +	int result = SCAN_FAIL;
> +	struct mm_struct *mm = vma->vm_mm;
> +
> +	if (!vma_is_anonymous(vma)) {
> +		struct file *file = get_file(vma->vm_file);
> +		pgoff_t pgoff = linear_page_index(vma, addr);
> +
> +		mmap_read_unlock(mm);
> +		*mmap_locked = false;

Okay, just for my sanity, when we reach this part.. mmap_locked will
be false on return.  Because we set it a bunch more below.. but it's
always false on return.

Although this is cleaner implementation of the lock, I'm just not sure
why you keep flipping the mmap_locked variable here?  We could probably
get away with comments that it will always be false.


> +		result = collapse_scan_file(mm, addr, file, pgoff, cc);
> +		fput(file);
> +		if (result == SCAN_PTE_MAPPED_HUGEPAGE) {
> +			mmap_read_lock(mm);
> +			*mmap_locked = true;
> +			if (collapse_test_exit_or_disable(mm)) {
> +				mmap_read_unlock(mm);
> +				*mmap_locked = false;
> +				result = SCAN_ANY_PROCESS;
> +				goto end;
> +			}
> +			result = collapse_pte_mapped_thp(mm, addr,
> +							 !cc->is_khugepaged);
> +			if (result == SCAN_PMD_MAPPED)
> +				result = SCAN_SUCCEED;
> +			mmap_read_unlock(mm);
> +			*mmap_locked = false;
> +		}
> +	} else {
> +		result = collapse_scan_pmd(mm, vma, addr, mmap_locked, cc);
> +	}
> +	if (cc->is_khugepaged && result == SCAN_SUCCEED)
> +		++khugepaged_pages_collapsed;
> +end:
> +	return result;
> +}
> +
>  static unsigned int collapse_scan_mm_slot(unsigned int pages, int *result,
>  					    struct collapse_control *cc)
>  	__releases(&khugepaged_mm_lock)
> @@ -2436,34 +2480,9 @@ static unsigned int collapse_scan_mm_slot(unsigned int pages, int *result,
>  			VM_BUG_ON(khugepaged_scan.address < hstart ||
>  				  khugepaged_scan.address + HPAGE_PMD_SIZE >
>  				  hend);
> -			if (!vma_is_anonymous(vma)) {
> -				struct file *file = get_file(vma->vm_file);
> -				pgoff_t pgoff = linear_page_index(vma,
> -						khugepaged_scan.address);
> -
> -				mmap_read_unlock(mm);
> -				mmap_locked = false;
> -				*result = hpage_collapse_scan_file(mm,
> -					khugepaged_scan.address, file, pgoff, cc);
> -				fput(file);
> -				if (*result == SCAN_PTE_MAPPED_HUGEPAGE) {
> -					mmap_read_lock(mm);
> -					if (hpage_collapse_test_exit_or_disable(mm))
> -						goto breakouterloop;
> -					*result = collapse_pte_mapped_thp(mm,
> -						khugepaged_scan.address, false);
> -					if (*result == SCAN_PMD_MAPPED)
> -						*result = SCAN_SUCCEED;
> -					mmap_read_unlock(mm);
> -				}
> -			} else {
> -				*result = hpage_collapse_scan_pmd(mm, vma,
> -					khugepaged_scan.address, &mmap_locked, cc);
> -			}
> -
> -			if (*result == SCAN_SUCCEED)
> -				++khugepaged_pages_collapsed;
>  
> +			*result = collapse_single_pmd(khugepaged_scan.address,
> +						vma, &mmap_locked, cc);
>  			/* move to next address */
>  			khugepaged_scan.address += HPAGE_PMD_SIZE;
>  			progress += HPAGE_PMD_NR;
> @@ -2780,35 +2799,19 @@ int madvise_collapse(struct vm_area_struct *vma, unsigned long start,
>  		mmap_assert_locked(mm);
>  		memset(cc->node_load, 0, sizeof(cc->node_load));
>  		nodes_clear(cc->alloc_nmask);
> -		if (!vma_is_anonymous(vma)) {
> -			struct file *file = get_file(vma->vm_file);
> -			pgoff_t pgoff = linear_page_index(vma, addr);
>  
> -			mmap_read_unlock(mm);
> -			mmap_locked = false;
> -			result = hpage_collapse_scan_file(mm, addr, file, pgoff,
> -							  cc);
> -			fput(file);
> -		} else {
> -			result = hpage_collapse_scan_pmd(mm, vma, addr,
> -							 &mmap_locked, cc);
> -		}
> +		result = collapse_single_pmd(addr, vma, &mmap_locked, cc);
> +
>  		if (!mmap_locked)
>  			*lock_dropped = true;

All of this locking is scary, because there are comments everywhere that
imply that mmap_locked indicates that the lock was dropped at some
point, but we are using it to indicate that the lock is currently held -
which are very different things..

Here, for example locked_dropped may not be set to true event though we
have toggled it through collapse_single_pmd() -> collapse_scan_pmd() ->
... -> collapse_huge_page().

Maybe these scenarios are safe because of known limitations of what will
or will not happen, but the code paths existing without a comment about
why it is safe seems like a good way to introduce races later.

>  
> -handle_result:
>  		switch (result) {
>  		case SCAN_SUCCEED:
>  		case SCAN_PMD_MAPPED:
>  			++thps;
>  			break;
> -		case SCAN_PTE_MAPPED_HUGEPAGE:
> -			BUG_ON(mmap_locked);
> -			mmap_read_lock(mm);
> -			result = collapse_pte_mapped_thp(mm, addr, true);
> -			mmap_read_unlock(mm);
> -			goto handle_result;
>  		/* Whitelisted set of results where continuing OK */
> +		case SCAN_PTE_MAPPED_HUGEPAGE:
>  		case SCAN_PMD_NULL:
>  		case SCAN_PTE_NON_PRESENT:
>  		case SCAN_PTE_UFFD_WP:
> -- 
> 2.50.0
> 
> 
