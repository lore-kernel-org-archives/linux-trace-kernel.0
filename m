Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2B126B974;
	Fri, 16 May 2025 17:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747416484; cv=fail; b=Qkbu5aCig1KSU0ahm6OmHLIqRfQvR5FnAHVqBNGBuzYZSHX8F3Qc2j/HFHo39y4sQ4ZWrJ0JuOex+wyyPvh2CTUTt+7OX3eGjcdT47niiBYmA0jogNIKOK3iYicB8bLU6lIDnYNCuc9A4GTd4z2KsiuaaT/Is9l+ZlhhR7dh1Ko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747416484; c=relaxed/simple;
	bh=DPL4ISzDTLVSCYgLO15VFPlA4sCDr0WacSNRi/ge62o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=njy+oTx1BAks7kodoW52SfnYWunuu3QURA1+N2b6qxVzmTJBa5kWhejqZZEmfCOhOh52HwdOrJ6QoxwY7oJqgoUYEraLiaLBQGA47ZAkCx4B35lr+ILEZeIlPkbYVgeh5mr3B+ftjHCFkeuHE4oF7OO6fbMyRAmOVMAmjWWIJYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Lh8RkvZM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kaVpzsXm; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Lh8RkvZM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kaVpzsXm"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54GGfsa3001013;
	Fri, 16 May 2025 17:14:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=Ox4AaKhpCpRKs0YHxx
	rdUa+YMJFTcJxjA4cOw5QMt/U=; b=Lh8RkvZMcxOhz5vEoMt2/Qem+wZKHEynTW
	7u6XjnMA1VYlmVCCzFjhO8W0cVj6XWw0AbRhVSLGCo/S87bFoj04ReDNFGFiGHIV
	Qjs82kpDwaMiTKwU0s2jvOMFOaBuHVrnxxtYn3ONxPiFLqaxokStvXmjYz+o1qZ/
	Iksz9IwxeBKFP+W6L88TF5g/6uioWd1FlQfRwLi1x6Fa2keo7DAJ+tQ2Gm4c4asT
	XyhkGsQzMxni4g+LcidPjfViuUVMNSzK1MT2e5EZgn4iaca3BEZI0mPgWdfa7kdX
	yIxa+uFqH8D9rvHwmsNCO91xjtRFZ4ue04kWDZp/ClTJ4vOzwfzw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46nre01ung-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 May 2025 17:14:47 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54GH6CBa004951;
	Fri, 16 May 2025 17:14:46 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46mrmfkrdr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 May 2025 17:14:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ryaMLB5JccmstSb5uv6L676x+u2CpCgyno9rSMGyLNB6Tdp184OUkjWPZ8vSNAlCBAYP/2S3oFEec74vZ03aOIOFHgfFE0JxrUK2dMASJRuSol6xmojSLe3OvEWGsTsV2uZFfZkldnAeQQjYlnrxvMltCWKSCXLjU2RVI1nklbcGw0JgA99Xp8hl7eEbPWsYAWTWm/xNZxtE4asJbKaUPzNWfm0SBKXTlLJyIq/hICyiw03nYu7wXr6kUm0X8RSx04AS9SsQX56bG/H9iH5ItkmyPJO1MqBjT4skKfBleHcXFuuOdRLND3Y5GYbuhcPyM3Av5+7cO4Ot8xrxqoU5bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ox4AaKhpCpRKs0YHxxrdUa+YMJFTcJxjA4cOw5QMt/U=;
 b=JkCMjSg6ioBLHdOgh7uyjTzJi0BJOKaVoLsrEOmIjzTGM5cgjswaGZFvJGK0pwflDfOnSLZdgeVKIDUZQIZZXtPuXUPB8nixtzn4osFPqVxYxOYt3ovtzGaj0eGpbGC5p/LRJOj4Ww4o4Y/oDflRHP34tP+20+B3rd0m2l3jhnGVSnGYBwba5UbQRK3fkF9tobGu8tqVENUA8yl3UBOjkM5o+B8BRan0ooDuW3gc4hOE4TVkdfq5yjbkScKTXouzEZqO8NP9GrWoL3iMQ/hiDdHyeNjRoLRMNb2kHoke47201kP+qU+6PPjktTWweccPjOCMztQY4yK0kk8jITkrRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ox4AaKhpCpRKs0YHxxrdUa+YMJFTcJxjA4cOw5QMt/U=;
 b=kaVpzsXmf344NVqF/uQrigbOxqSGkoVATMpSNqA5GPRzkshD5O2KDDHH6Eo6dCaX52Y7hxPSuF5iQNzvT8uSiJ2oP9SeFR3CRagova1yqpNehJmRkbXi5zh06wkLWCUKT8Z6jwXmaGTnjFSYZI0zj21z/5jLWK1XwWGdBnflL/E=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by CO1PR10MB4642.namprd10.prod.outlook.com (2603:10b6:303:6f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Fri, 16 May
 2025 17:14:43 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%6]) with mapi id 15.20.8722.027; Fri, 16 May 2025
 17:14:43 +0000
Date: Fri, 16 May 2025 13:14:37 -0400
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
        mhocko@suse.com, rdunlap@infradead.org
Subject: Re: [PATCH v7 03/12] khugepaged: generalize hugepage_vma_revalidate
 for mTHP support
Message-ID: <5u5ealsawrsaybblcfqorwljb4delzlmcjhdd274333daxb4p2@m47iodmem2fg>
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
	mhocko@suse.com, rdunlap@infradead.org
References: <20250515032226.128900-1-npache@redhat.com>
 <20250515032226.128900-4-npache@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250515032226.128900-4-npache@redhat.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0178.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:110::22) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|CO1PR10MB4642:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cdbc041-4fa7-4963-f3b9-08dd949d268c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mtpc89NNPTzh0z3GrlARorlikLw+JAgUh/ZNM1DU2d+OZJB2O9L34Q5RKu/W?=
 =?us-ascii?Q?NlhOH9KkC4wDT0Rs5e4ahxap5lnw1/vD6BSfZYaB1eaglfxxhEIwECNyexpN?=
 =?us-ascii?Q?Ey9rLLK1Xa6dUb7leDKl9JwuFdzsLT5IYl9lzEOnEUX6QuOnfRUqlK91lL/R?=
 =?us-ascii?Q?qTuI4GSXDpK7dIeCkJg4c1JctzP0yk1XA5AzNYvqrqURlrEr37bDxnr7MRkg?=
 =?us-ascii?Q?iZRs5I62gQXNrS8CP+zVi7vEiggMhtwM57zt35159AOjzHfEEuR0TJCnWRV2?=
 =?us-ascii?Q?5UFhtZJQq5jO/UbiJ/4P/Zk89eNVOTE7b/fJk99327QTR60AXFrksR14s7vE?=
 =?us-ascii?Q?62a6S49gur+fyQ/fEqpGZLBnzrACl0jvQB247IdPtdmm2jNbNwL5ziAapTcc?=
 =?us-ascii?Q?fx0tkP3G4GPPxMf9gsT76akTJXODmxfU/5BPYJUwfx1dwnIVC/yr6DnsR3lT?=
 =?us-ascii?Q?K47FixGP1yhjl/AIGkOyNkIDp1KoZfHx2RVJjbxbc38HaBf7yNgjHr+CjQ9A?=
 =?us-ascii?Q?oKvJTZ9ndq7uCwhhD167ctpFRJA26nDxvND1E7DWcLd9bG1DQ49jRYM9SEPP?=
 =?us-ascii?Q?RTTFjAS8HmyPMEuZPCDAXaSVpzwhrBqCi1SYD1cTlD6AW3d/bAARVNiyOZ+D?=
 =?us-ascii?Q?pYlU9zhKR0oPCyfosXJcdCxxfcPozH31JeThhthp90gLuroA14hAGj7JwqNj?=
 =?us-ascii?Q?E4hZHCdRQaL/4KtBbjnW+PxLyh6TkhHTZ8UUVV+uJxJxGfeWhiT+4wpJF5M3?=
 =?us-ascii?Q?yeqb5LndwXwIVii7BZSBi/URF8yWlo6SyPnQF6oPrVLuYnZG/9FNZZFZfAe/?=
 =?us-ascii?Q?bn3qsG29P4ZI09DLjY/rB9fLO4BF62xz4fvEhuy8D5N8qWqeq4t+6bluL1Uy?=
 =?us-ascii?Q?zYEZLE8IyoiCMsV+t5rlKne+ysMNJen9nJdvW9p4rhB5KmaW/e0kxnNkmkDh?=
 =?us-ascii?Q?tamveDebgjCdTrKRL+JGh0wsNwAfMiokQw2PLea9dVqRrxkxQktpcY2dWkf1?=
 =?us-ascii?Q?0QF4qj2aWqfAN7KS7i6nAbVL9qDEP3KqiSHkBEMT7RGp4ex94TM11gClZcX2?=
 =?us-ascii?Q?NNb5d+XuLxPOoFPVn6aFHJaIPikIo4qGWK1A+TpnbnxiGEhYuUg2JYWCPnvV?=
 =?us-ascii?Q?cmW7wZzJG9OD0A/BS+xNLRxUzb05NxqdbbyyuFx/VaE5hXOFfdTBO9H1FMEo?=
 =?us-ascii?Q?k/XBRZS7y9g8xtZf2CEaBTlOKAHIfPWjN3yqmdP8Lf/GEVtL+F95vtuQRuoe?=
 =?us-ascii?Q?QWwvMEMD4O58KcmH0216wYGtwR8GLY9xzA8HX5VbBDBJsupWgLdxkTr5cAcm?=
 =?us-ascii?Q?5jNQgKJFXnC9s9AiHQDDrcdblNWR8Z5n9FznJ3ZJ69Xlno+FwswF/ctxzdl3?=
 =?us-ascii?Q?0a5xDjJ/qsBfz6DjH+0Ez7cm4Z7vx4Ci8SiHHt2nBX452BRaiGiZItdzqSmb?=
 =?us-ascii?Q?V6hHRyz5yto=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eVLLEA7xS49vN8k7VaVkjWWx2q48iWR/YxsNCJbFEw2wzE4tJMaClsNJcM+l?=
 =?us-ascii?Q?0cndfYZb5rcxagrwLsxIsdO2XQT4VwRxYSCF8YfAj5Ec2klQaeXdoJeavDiF?=
 =?us-ascii?Q?G0OOrda9kaXtHRYeHyfUGXSee9n6RFonh8Ugi1sBRnbDDDFQfgc6CxsjgaLj?=
 =?us-ascii?Q?ZDUErRzk8Bus5dap2MuKuKnnnY4qV3zdiB4MZH/pSbkTxd18xfruc7t+3jt7?=
 =?us-ascii?Q?k3F6aNdWKicwTb5WX3ePtl6k1smOC9phxAoGszFKqg4gDUaT7JUO35HZmCnp?=
 =?us-ascii?Q?BX1GLDOkVNeKVA0n2x/luyGG3o6a5YsDCAx0WWwlyUWpPkIPiQL5Nh+zb8P7?=
 =?us-ascii?Q?dWc99ppAjHutrswng3VyHpTaKOHkaPRtXxh4fVq+lCjzJlHKezsQN5rABjNP?=
 =?us-ascii?Q?B/4yY5hgQi1fTq5+24e8p4Fe8cAG/uc+cSEd12Jtjaxn3LtA1r8uRp1EkKlN?=
 =?us-ascii?Q?96IQPY/uryjidud9IHxCTijACvLA0F5nkSBfOzlteLqcZ2dYUcQEiPcehfnO?=
 =?us-ascii?Q?wTb1tSnswaPn+Uhc5/L+keqr3WfQnQMyXPWRolFQh/NgzGlTDZG8eLO2uCTZ?=
 =?us-ascii?Q?eA5O6eE2Qxx3EMxzTeIfivCK49/0y80kmTljGU+8keD7Sw75GNsI8pCbSv6R?=
 =?us-ascii?Q?O+QI0+0xKHJweRT9iitdZs1yqxZUk06I8Jz/9CJ23T1RpAdKq1K3mTlFdnXJ?=
 =?us-ascii?Q?YiKUvH+wpQLRTGMuJPttJl/csqedtrkE8GFIOLwJQ5H+RhTEzkxaA6loRh2R?=
 =?us-ascii?Q?IGf8hrMknsqZ9WbcqGU/WWSFV1kWAuDm06OKSYoty97sOT1Sord9a9mts3Dl?=
 =?us-ascii?Q?K0p5o4Vz6scARqaYdYLKO4ouMDzd/p9E0SFA1qwyEEHV1XDDapP6k2JyXEoE?=
 =?us-ascii?Q?eaF0Wk0NFoox4Hybo6SwH6etLn0zUX9ZD3xO1mSFStr30y7mRwru6Efy2j/g?=
 =?us-ascii?Q?suUQ76Rqs2WQ8O97MwN9v0IfOu1nLX8DIMdbwxDNhYmRjdBeuVQNQm4CB2KP?=
 =?us-ascii?Q?vCrcaev0/qBVH1P8Zr6NPjtRm8emILsqkXyiKK9B8LhymLPTD8yDaoYQEZcF?=
 =?us-ascii?Q?EUh4c1kuphZqQx9qlhWZ4v9p2IMJXSh3CEl4UNxdZL315geR5oaeM+EgwJ58?=
 =?us-ascii?Q?TyGixK1ut6Yikd7rGKvIvxrHthQ/8RWZ4ykGnKRg5xOx0cB3yVyKm4wxtD91?=
 =?us-ascii?Q?SvVJi3U+Kb1cAbSfmu5GE6E0LWPtkljpwsI03pdpGrAV16zwpRAW0+2az6N3?=
 =?us-ascii?Q?5f8x7FtQ9iW96pey3nah+ZnHCSN+a4ACvTTCgs6go9QoIN03SK8HcjroBTqy?=
 =?us-ascii?Q?6LtQ+7TZAt1JOEPLVRCoHpF4e3Tcy+m4c/K+MS5u4HMgWBWP+nhHxGczVZF6?=
 =?us-ascii?Q?MUbNK4ZmpxbCPgiHDZ1bIjYLu55OSf08qFQKNEMxA/ZvIViHg9bvNn4W1g9m?=
 =?us-ascii?Q?XMEUwFvjsZPnqEihEuzSrQ/qn94UNfCh06tD1jCFGfPaHpc3ociM3rZetcjO?=
 =?us-ascii?Q?JbTLrHaQbL1/9phKTJX6pWIkG4osLo2hKOB9mNZ0ahOriPJ4hKjsIaEAdwmP?=
 =?us-ascii?Q?0Va6CqkhVsa7juRevNjFpiPJ1l9ru96qrbzJiS/h?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8V54JZNQv0+2brTkY/22gtFs0PtrJDyMlBpeUF02o3MXWbdRweVuZ94+ALeTMyFzW3A1bXzl4MMcsOKX8mCHQyYWrxwwXBQlZz5Y7ZVYd6MNYUn/5JOKLlXtcdabJvWLzUC97TYk9TmPIqPwJ1bJnTOFdG8ss9n3jvV4cCSJwvZbeXCm2LqKASXaK2OtZXWsNNnJRkrrd42OKdVk4ikm+bDmY7dJ4ZhcoHp8Dh06cdyiCmcJbDY4PP4DgcCIMryZXighqKqEhoujGfRznEYQk8gevncwoVOpRz0O+Hr7fn2F9CBMakMzICvYqIjhe9+kSB7XOFUrbj+MT5mR4sOJdrdVbW6VhsJ2LHew7RvqruJlm+f4fWJ6amwGM3ImVZv7BelS9GEvxUH77BSRc5Lq8noIetPmvXyMQxsO9jHz4IhzkCEd7Y2Bf4e0WJbdxtFP4knQ4Tlq9pGBsb9lPAeAObgq/Az/SqpTfZPD2rd1CydVR5iWekhw4U+Cr40cDQnfdU0oM4FhtSByJ+QYBXociuVJN8MUIT4VwKg3lYHZCe14NdEhA6Lm0WNOALL3y+FE2oa9S9CBHydZjJ26pzzj3cW3NzghRLXIq/Ji4zEHZjY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cdbc041-4fa7-4963-f3b9-08dd949d268c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 17:14:43.5402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6lC5N0Ihih1mG7PRhidwiX5EGuND0o8JOgc3f216SZzf0Nfojm6VU0YBpmc1nmNFbMd9lMdp6Oehf22yAFabvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4642
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-16_05,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 suspectscore=0 mlxscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505070000 definitions=main-2505160168
X-Proofpoint-GUID: gU-HPqa5OyW1o7yUts7-FyyKAMEh2iTU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE2MDE2OCBTYWx0ZWRfX02PsApUnVtvd M3la4AFlIY2v7PPIPacS6IImcA0FEBlQ8UwvZODs15wDAzVUameq5fQcz/m2H1Df3ifQpElzZ9V yR/Efnh5iC+dQODVjkVqwFrAg0Xto8fQamlsFMFdrSF0A9k7LtZBDRyHgoO0ZBqStOeMzJ0zoEh
 wY3Se9Uy/P6iWKMdfFNcgeDASmg4mN1/DsiLNwTU6zrKLe4nOYRdXOYxBZK37mR58SvoPuJsZHK gsqvq8MQyjc5YqoSgv1Fa0DBOKcMBY49PO4SPlNfI9sxj0DMjDnb40f3LeSQ66U/9N+2TYLa58j lBqEGClPHjQpxtId5sLey2RQiHID9PNLihSac4KWbkun6EQ8O7Meyb+XZ3SnKLmj4tHHyoo0N9G
 TR7cH5xBQSeVo5Qhe1/yB9NoqDBtagu9Bq6oG0T6G2E1AUE8SuNNsfFMfwSh6dfXxfdrdx4u
X-Proofpoint-ORIG-GUID: gU-HPqa5OyW1o7yUts7-FyyKAMEh2iTU
X-Authority-Analysis: v=2.4 cv=O9s5vA9W c=1 sm=1 tr=0 ts=68277287 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=20KFwNOVAAAA:8 a=SRrdq9N9AAAA:8 a=7CQSdrXTAAAA:8 a=vghThWDQyLxkgOGcvckA:9 a=CjuIK1q_8ugA:10 a=a-qgeE7W1pNrGK8U0ZQC:22

* Nico Pache <npache@redhat.com> [250514 23:23]:
> For khugepaged to support different mTHP orders, we must generalize this
> to check if the PMD is not shared by another VMA and the order is
> enabled.
> 
> No functional change in this patch.

This patch needs to be with the functional change for git blame and
reviewing the changes.

> 
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Co-developed-by: Dev Jain <dev.jain@arm.com>
> Signed-off-by: Dev Jain <dev.jain@arm.com>
> Signed-off-by: Nico Pache <npache@redhat.com>
> ---
>  mm/khugepaged.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 5457571d505a..0c4d6a02d59c 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -920,7 +920,7 @@ static int khugepaged_find_target_node(struct collapse_control *cc)
>  static int hugepage_vma_revalidate(struct mm_struct *mm, unsigned long address,
>  				   bool expect_anon,
>  				   struct vm_area_struct **vmap,
> -				   struct collapse_control *cc)
> +				   struct collapse_control *cc, int order)
>  {
>  	struct vm_area_struct *vma;
>  	unsigned long tva_flags = cc->is_khugepaged ? TVA_ENFORCE_SYSFS : 0;
> @@ -934,7 +934,7 @@ static int hugepage_vma_revalidate(struct mm_struct *mm, unsigned long address,
>  
>  	if (!thp_vma_suitable_order(vma, address, PMD_ORDER))
>  		return SCAN_ADDRESS_RANGE;
> -	if (!thp_vma_allowable_order(vma, vma->vm_flags, tva_flags, PMD_ORDER))
> +	if (!thp_vma_allowable_order(vma, vma->vm_flags, tva_flags, order))
>  		return SCAN_VMA_CHECK;
>  	/*
>  	 * Anon VMA expected, the address may be unmapped then
> @@ -1130,7 +1130,7 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
>  		goto out_nolock;
>  
>  	mmap_read_lock(mm);
> -	result = hugepage_vma_revalidate(mm, address, true, &vma, cc);
> +	result = hugepage_vma_revalidate(mm, address, true, &vma, cc, HPAGE_PMD_ORDER);
>  	if (result != SCAN_SUCCEED) {
>  		mmap_read_unlock(mm);
>  		goto out_nolock;
> @@ -1164,7 +1164,7 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
>  	 * mmap_lock.
>  	 */
>  	mmap_write_lock(mm);
> -	result = hugepage_vma_revalidate(mm, address, true, &vma, cc);
> +	result = hugepage_vma_revalidate(mm, address, true, &vma, cc, HPAGE_PMD_ORDER);
>  	if (result != SCAN_SUCCEED)
>  		goto out_up_write;
>  	/* check if the pmd is still valid */
> @@ -2782,7 +2782,7 @@ int madvise_collapse(struct vm_area_struct *vma, struct vm_area_struct **prev,
>  			mmap_read_lock(mm);
>  			mmap_locked = true;
>  			result = hugepage_vma_revalidate(mm, addr, false, &vma,
> -							 cc);
> +							 cc, HPAGE_PMD_ORDER);
>  			if (result  != SCAN_SUCCEED) {
>  				last_fail = result;
>  				goto out_nolock;
> -- 
> 2.49.0
> 
