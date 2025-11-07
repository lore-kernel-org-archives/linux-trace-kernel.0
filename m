Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB8727A900;
	Fri,  7 Nov 2025 09:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762507191; cv=fail; b=muXibw9LqfDJUhMjNqe/olW3FOa08vibvwD6yS99ouGB4/psYQUIvPPUgCkdBNk8CKdA+PeeRtXQJaubJHtnsFawH9ncMaErCbuD/Gm/bY2DdWxK49WuXAiMNiFzBxANmotWo7HIOkt7yTHcobiYyLKCZCG9uO3EdY1FDOr08J4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762507191; c=relaxed/simple;
	bh=4oTt1JS+ApVVefMKfdrYDiC0eGXkszSJZIw/8Y+7kbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EepU3Xe+tVlmhTLidOJqCuJYDdi/HKGTLYQmSVlSuf6a+JJ9oXwWhzTNZi9e+MWzhdQC1OhlFsUuNiZ6Y2uJbIhvzWNilOVU0Bwnx0y4lVW6u43kZDARQv+seXWUi2P/Tv4mGGSOIZxOcCiG086JZJvoOFotHb+u5VOA2oCulV8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GMj5Hpnt; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XX+DeFsI; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GMj5Hpnt";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XX+DeFsI"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A78udKs009785;
	Fri, 7 Nov 2025 09:18:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=nI7sOz/uhQ+cdqtVjq
	LqeS96avmFNaf811UJE33p3UQ=; b=GMj5HpntLcLD5K3U6VS0Z7mDV0jUc9BRdU
	a1dIM/8/bJyL/lmmKVwVMVw9QvcbNiJKVcaL87Znp9npw/EKTrahiY2jmT15tGuw
	R7Zjt2qeIMiIqMfszfRYhA4sU/xW7FZvc8Pky8BrmCoZOHhgwL5tfNPRXE18xF8N
	kC5wut2KSvLLY9LEM9Zw/paSjYl29PlAKPlcPxywFSmmy0gCuUobFxWQvTfa7Hyz
	c7wvmLEc0rh3A3On4cFjH/5o8lFBYz0Uq0CfpH02NkkQ/3DgwNiYE5KlYaS4V6rO
	Cv9jAL9HK+grmbrhK7Slmn4/mzAwJEyO7+iGHoAtG5365UJAKATA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a8yw9sdgs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Nov 2025 09:18:56 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A78gqDt035963;
	Fri, 7 Nov 2025 09:18:55 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011069.outbound.protection.outlook.com [52.101.62.69])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a58nqc0n1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Nov 2025 09:18:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lh+N6QBrRBEHHoDCpELWHKKuNL3szFi7mQ3rPf18zGKYurRaku+m/8ToxVGh8il1cfNjj/QULJzqlX39iwcTvDVdb9tGKIeA6wHd0/Nss56T+xzicCaW7eF3urnbv2Lxpjv2i8i5EQvte5g4psEHAPs5pLfn/8me3cmvfAtp1CfJwprZDABhXmjtue8fhMaOpHEQsQXof93U5Z7L8JaUjy1APIHF6BUoD41jXw+8iZWlOw/te82NiBtfvLJE7vW9l6M/rO5Y/ips5UWLKGJjGdGW8mdQdhZ8E2Z0l5XmPbyg/u4ExVRZOJMqMmVytYPicRJd5HCXZJYyJM5RoJ998g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nI7sOz/uhQ+cdqtVjqLqeS96avmFNaf811UJE33p3UQ=;
 b=ZzqS1eRhydFqW+vl2fetNwMiiuFlAEP+QfZQcEQfQjlGpWIpTJ+hPkJf3AcaVDatjSmig57ZCTbDHpGmH15LCG3KBPAFVKV/NZ0/qnJbByOEHxY72SPuQIuLcs7U4IJXwsCcQJVjnEavf4E+FoXzdvCqqrFC/Q80ECKavBlm0nKgtmYqDhYpIUGoMa14ds73mNbvpnMhbPEVIYmINZYA24+DXfVs+eTqxD7gN5ccmv41QA634iDmEcj3+NkQUbNm8QY2US76+ZUrpMvSwDgN8Xhx8uLceFlO4DBD0EDGVYdXugpdWUnpUw7e0ARUw+u1WRM1lK+RlRbqeHVS3sFnHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nI7sOz/uhQ+cdqtVjqLqeS96avmFNaf811UJE33p3UQ=;
 b=XX+DeFsI9zw2tunM/hNDOwhUKPUAmJas5RQ3mcf/n4r8a3oxuVbf5PcNEr+vW7YDUNF51G2+6PMckfrCavgcBVugQhJWOaBfzh/0s1r5Pr29VqDvEppHazTo6g/lEAl+14W6uiVt5kobEm2DFr7Nn3B3k0ppzobJo2uhh21VNvs=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH0PR10MB5754.namprd10.prod.outlook.com (2603:10b6:510:148::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 09:18:51 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 09:18:51 +0000
Date: Fri, 7 Nov 2025 09:18:46 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Dev Jain <dev.jain@arm.com>
Cc: Nico Pache <npache@redhat.com>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, david@redhat.com, ziy@nvidia.com,
        baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
        ryan.roberts@arm.com, corbet@lwn.net, rostedt@goodmis.org,
        mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
        akpm@linux-foundation.org, baohua@kernel.org, willy@infradead.org,
        peterx@redhat.com, wangkefeng.wang@huawei.com, usamaarif642@gmail.com,
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
Subject: Re: [PATCH v12 mm-new 07/15] khugepaged: generalize
 collapse_huge_page for mTHP collapse
Message-ID: <4cdec7ba-373b-455a-b1d3-330246e8b2c8@lucifer.local>
References: <20251022183717.70829-1-npache@redhat.com>
 <20251022183717.70829-8-npache@redhat.com>
 <7b6b5c6b-0298-47c1-ae48-17d603401bac@lucifer.local>
 <1c05c28a-a4f7-4562-8799-6f08a03bd3eb@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c05c28a-a4f7-4562-8799-6f08a03bd3eb@arm.com>
X-ClientProxiedBy: LO4P123CA0266.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:194::19) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH0PR10MB5754:EE_
X-MS-Office365-Filtering-Correlation-Id: 836d0ae4-eefd-4d63-f7b7-08de1ddeaa67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2ZcXS+juAbyvmlaif80mMVe1c4WxoG766Zslszhz7jLz9pnTiRwQg+VFyDvp?=
 =?us-ascii?Q?m80Yocj4ySmyyWzv4UUNgEMAmHBQo4Vv9ih916yi3iMMZC4fl+9bHtPg0ryq?=
 =?us-ascii?Q?NbBNETAPEC6IDEuYpSlmX2sRonXkaXcCiczMiK9fs19x10lKzvnwHoFuNiaB?=
 =?us-ascii?Q?+c/JlaSJzjk7iF6/swPlydiVYRpkJv0RUm0X/de9l4l6OwwLf+o29M2ueemz?=
 =?us-ascii?Q?e3hsf2HY6A6W7ps+iU9JdOA27C2+uYHEureOzdGiX9dmgT221wOfpkc1KvaP?=
 =?us-ascii?Q?aHUFGVytz4HFO44pdyFCp4YdgyisvG+9hbbNU3Jp4Ki/xzt8Qqw7xa3O4otW?=
 =?us-ascii?Q?Q9YMDf54D5hcvyuo7FekIyysfdE8xZH+FGHQ7HckFWvMT5dl+jEKKLMNNiIe?=
 =?us-ascii?Q?69z+rTR+rzv+73rV4IFtc7fsGtRK+zSciX7qQ8l0z9mSq6MlwCTyKnN6B8Mb?=
 =?us-ascii?Q?0DkHFubVrB4afddLPWWLREUrX7EAEo5YH8VdW8gvlRHTtIIh7hMqtsnz6j70?=
 =?us-ascii?Q?M7JMdY7Zew7/FL5Bs6ldwKf2Ec9bnpYZn14/+FOKTI3JXbmpqqWzNLkzLnfw?=
 =?us-ascii?Q?n2IUl2pMcw6EeVBMjDVFnLkl4Taaf+Aby+fkAyQOSeShfciIeDbegpBoQtVE?=
 =?us-ascii?Q?7oiqUSIS0K5FLTvjLZoEA4y/jfG5we66J+B8h67oXT4byASSgq7KUzTVhtg5?=
 =?us-ascii?Q?LYLrLz1FfG+Swp0xYij1VNTzqszBIMWHV5l6IaAJH6Wk7OmZWgfQTlvFlGcq?=
 =?us-ascii?Q?s5H7Fhe+MZ6Luxy3/BmUwhNJlbh/U/o0C/TH0NCC5PR8mDH6RtMqFCxddTHI?=
 =?us-ascii?Q?n+0XLjuU3Ix77F9mEOlDNJvXGitJnHXU6A6iAHDXQZ1hjxwkydQrlARYscUY?=
 =?us-ascii?Q?jNZ57E95jOLHn0LLUlij9h3Xe+4xBFaaze07M/5QrVxVDR8B/+rGeEAmIm17?=
 =?us-ascii?Q?oDTYsxzVi+XSQ+9/DLgDbUhWNzhnGBTZPNw/AS1dodhtDk9OncoG9Lpf1HOw?=
 =?us-ascii?Q?DmY7+THOuxfdWa8ZH6gKBeiGrtMfd+DNABIOT5jwcLsB8oCQOHvAr9cjZcqz?=
 =?us-ascii?Q?lpD8kHVBcBrbsUvJ/PVHwE2G1ckJqLKttBrjOnnyKGT1QJfptxBauBPYLGTR?=
 =?us-ascii?Q?O6O84aGCkVe2D7FcX1DP6WnsbkDsVtympUOr/xuv9nWw6q9FRyyPygsPlOLH?=
 =?us-ascii?Q?2mZj0nk/MdaW4miORL83iwQS6gx/V1KPrzidIAuRGum0abpjwYUajbmP2xee?=
 =?us-ascii?Q?p86fLITCHGUMPni4iF1RSeY09DXZooDA2n8EDmGVLvLvNUyoJbftd6E/lebv?=
 =?us-ascii?Q?zwimZeEp6MLhQVyiDbjI8n2kPhZcFUP3nZdduR3KpzeHqy0OzZl80PqIy0Gd?=
 =?us-ascii?Q?8sDVuarbmTsfMj+uNxKS1qqBpiEoC2ddl8D0cr7W4P7xVE8t1hdzbjgpudyI?=
 =?us-ascii?Q?hHRPBxAo1noe2PfvrLn1gKeMMP3hqS62?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HpjwQgE8YBj/OfMSV++2UpecjkZpUFtLX7gZfYoY435bGu1adFJPoUVmfpAx?=
 =?us-ascii?Q?AgzazjJndh/bIfWlouR54VJk5/xtYsKGU6MURRgHW7AvP8SaWmFmZ/h4nkj/?=
 =?us-ascii?Q?yAHtn66kGDk/YqkomidyCdxaaK1NySyYC16pvNyJTR+gWbLSw3TZTuMx5bvH?=
 =?us-ascii?Q?ZjhVW3Ja11n5xPfwghSdiY64tmt1QJV+YzNofQzg5VVjY9R0DLzPhlUEZCiT?=
 =?us-ascii?Q?ypaGoczCW1F8OydX61YxeX1prGhcjZ0sPcnZuXY9wFZMAh79M68t8ZzIF78M?=
 =?us-ascii?Q?FHuqWRhTzOhtsytD7mwqA3dx7AjY87vk2yDsozMUFSDSoP7HR1zBycQnUt52?=
 =?us-ascii?Q?PRB/tlX9xnF4xt3ePlxb6RD+rGVp/IUIod1UiqN8LKhmbM0xcA8dlbRaER2j?=
 =?us-ascii?Q?GmM4bjV4TYJ5iZwKysOccELgeYjwSEt02cudLzpRLqLvj1q+DCTyrb1bI4pq?=
 =?us-ascii?Q?Tn1nktlaZN0IPqkilry/NVUgv+Aby41/UCnfkiGA9A6ndQlnAHLan9RQGF8L?=
 =?us-ascii?Q?k81tNg2uj8ydFiZgekkrWBe6NRPdGmnPvrBB9KF+8wVx1aOsyaCN1hZu9j7w?=
 =?us-ascii?Q?RMcNunoLKIwNXPhhEbUGhRAvIK9qDSR6yN0oMRKr81g5SxoTpadUlRMQf1D4?=
 =?us-ascii?Q?XmngvcMY/prtffqpXb1jcoYVzP+ppVT9lgbgbdxJWnC24PO8GgthE85HAsIL?=
 =?us-ascii?Q?8UJGy1FRa0Awe1QtB/8gr8ZKEn5gR/cIZwxfSLEmsR19Kf08huxt1/K4vM+6?=
 =?us-ascii?Q?slegdiKMRnA/AOR1M3pM/gHdY9Yo8XWNsbvm9m6WB+3E3d+wEiOXb1A5cY/1?=
 =?us-ascii?Q?4SF8ZRCZJJ178bMRdid5AXncveTq4ujGM5i8EP/VIeDuhNTMHr89ZRgDG1fo?=
 =?us-ascii?Q?1pnPyXnynCkbIWS7YSwOQHmCiCDW/W8h7UTi2AOIw4mId6suLFC9Ug6yr1J7?=
 =?us-ascii?Q?x0dMB/cna3OfbL9DSC/M4XQ8HYpCqIKjvHicBbzJnLtrj7n2WOhy2Nv/bW/t?=
 =?us-ascii?Q?FpyHGj30BtMj1rvvqY5Uu1DOPZ1+pgTp5+qIEnE7OX/xjD99F93Szixfc96w?=
 =?us-ascii?Q?yXp4urJztX6GWf25diwxBQtyVD0Wzhh34Ebn/Tkp4bCQMMCiAzctj8m5aeWW?=
 =?us-ascii?Q?yHF5b1vQmbj1ShvOvuro0jWtlW4Jss+Bdn5LHPoIFHSxZobqIEXh2uOQn2Xi?=
 =?us-ascii?Q?XnERSweJBYqsgo4QsxJHysHBo/tsgy2rH/ZKy1pepIGT+sxhxTX+yl4wv3o0?=
 =?us-ascii?Q?oj8gSqZhM6TygJLJ33Fmrlq0KkCcsZBmIa0KeIFJ8msyPAW58Bwrx0FoGnsI?=
 =?us-ascii?Q?lx9sMrIOAA0FCeGQjgBhW1ZDZjsv493m/Ie1fnLOH/lRL4CeME+wrQsf3JgH?=
 =?us-ascii?Q?6r2gdhfYuhk06cm1HmB6SRqjewaFWm4UxlKq2RCSVRyZMdIFNyYtXFDZEgr1?=
 =?us-ascii?Q?3f2/rzNFfIIStupSRtaWfgN4BDYAXv/mZkKoyqhziFzDlbrpix8Yn9+pht6d?=
 =?us-ascii?Q?9urj9SecVFB9qrZkBKTpcY3Ud5pcWJMbvaUBBRg68I08t4Ic1iCdoNu7lJ4e?=
 =?us-ascii?Q?B7p/OUPCLJsaOKERgdMjLNTlb6lRAkecTKmS100Q5KxBem9g3uNhA4YjBj9J?=
 =?us-ascii?Q?gg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ojlPwW3GsGmxertOvh6xuCfDUWeRdhphnhQd2SJRasWZmmBx+263DYrMad+2oMeJ73comW6Rctd9+55RjbbCw2KyuH/EdBac0YF+oyEYdCuxPuRsz/aBCsIPLu8BEj2GzHXmRPgAe3orVfucYIWGleKBKa4x8H5yBQaychuCVH2Rdf4jIBkLlCyzUGlQ0Dhg/bCOAOcJiPxFZsoRHKWd9ElNtPzhf3WkKWywEGlZ5NuQdz9rlCnHwR4Vcz12nQ6+ZthkvTHEOBgpuU7G5Iko3kbm9BjfE3iWqA7P89n7K8KR9SuQ75hwRGfo2VN+rL9TCMkO1Mkl8XyY9GpEyQkMr57HxlGQSwnGTFNVB0E5IHtGoGBJsoCUqrCZcS4QgESzRfFX9RO5Mnq/TdXxc8ps3+WNGG5OOMW+h9vg7rCVqzb8l3Xq8+6Qs5wD4Mp20J/M3+RSECbTpo3Ad3v8SoWICjASzcQpIoqOvaZQ6rfSsM1T4TyHIVtyRtD2o7BIUugiLF4C0rQ0HtzYG84/FezO2NHekG9sLFHk9DBs+/P9/w3dJ/yTtP0DP3uKj/Y4vBUQgiyt/p7wNLF7La182EMNgjXm7x9B6vm5rYvtft9hppc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 836d0ae4-eefd-4d63-f7b7-08de1ddeaa67
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 09:18:51.2821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oq35nsg6k/+ehPchRZZ+HMzvNY+6zEVXcHpv+te/DIwLCp4Q8e3f1h6y6LYYUjh5n6tzbBwYSq+RpOpDhvAHBuhx6PT3588/1CVOJfzblcI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5754
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-07_02,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=806 bulkscore=0 spamscore=0
 suspectscore=0 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511070074
X-Authority-Analysis: v=2.4 cv=GJ0F0+NK c=1 sm=1 tr=0 ts=690db980 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=1B0iEbWH250DWWesQxkA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12101
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA2MDEzOCBTYWx0ZWRfX1xVDEm1dbWIG
 RnFPmsj3rlD/9hY5a9WwPIEAyeSq8lR0mY38IjywGaBOvdm4jsg6qtU7yEujWnH8EjSqYCgeo5Q
 BoIWpmC8aEL4kcvMtdVLHBGPF7Yq1mZLaFsKsDRA4MGcGtstC38/9Q640JhhcKrWzxECfO2907e
 ziNvfG2CPnyrL2aLCD4InclZaIXsi1yE31qwRKZSicMXGg7jyVxz2tTK9L1DZu4BppSIASJdCg9
 FPxAgO/brd6/Nv4J/kegz344mkz2ABxzqc5d918bg255zEhNb1FzgpQCNUqZqIw4/XO7Q7unDUE
 ue3fq+Nd6mhUWEof6utKDtP9+B1zWr9AdyG+/SBalyJPp1RQNLeZ0erinZ7krWhmTZIOIChvKm+
 jf9m4mppEG1O6HrgedQPQEKJ6u0hZP78KAgM7zteG1U622ZLh48=
X-Proofpoint-ORIG-GUID: ObbOKpXAdXfnS9fYN3zOGk38wzxnMUta
X-Proofpoint-GUID: ObbOKpXAdXfnS9fYN3zOGk38wzxnMUta

On Fri, Nov 07, 2025 at 08:39:03AM +0530, Dev Jain wrote:
> > ----------[snip]------------

PLease when you snip can you not snip way the code being referenced?
That's really unhelpful and now this sub-thread loses a ton of context...

> >
> > > +
> > > +		spin_lock(pmd_ptl);
> > We're duplicating this in both branches, why not do outside if/else?
> >
> > > +		WARN_ON_ONCE(!pmd_none(*pmd));
> > Hmm so the PMD entry will still always be empty on mTHP collapse? Surely we
> > could be collapsing more than one mTHP into an existing PTE table no? I may
> > be missing something here/confused :)
>
> After this code path isolates the PTE table, we don't want any other code path
> doing "Hey, I see an empty PMD, let's install a PTE table here". One of the
> reasons why all the heavy locking is required here.

That wasn't the question, the question was why are not able to install mTHP
entries in an existing PTE table.

I'm obviously aware that we need to lock here.

>
> Also, I want to ask a question about WARN vs BUG_ON: suppose that the
> race I described above occurs. After khugepaged isolates the PTE table, someone
> faults in a PTE table there, and eventually writes data in the underlying folios.
> Then the buggy khugepaged nukes out that table and installs a new one, installing
> an mTHP folio which had old data. How do we decide whether such a condition is
> worthy of a BUG_ON (leading to system crash) vs letting this pass with WARN?

To all intents and purposes just use a WARN_ON(). A BUG_ON() is almost
never right. This has been done to death.

Probably the WARN_ON() should be a VM_WARN_ON_ONCE() because this is
something that should simply not be happening in practice.

Or can make if (WARN_ON_ONCE(...)) abort, but then we complicate already
very complciated code.

>
>
> >
> > ------------[snip]----------
> >

Thanks, Lorenzo
