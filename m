Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CDD2253A1;
	Thu, 21 Aug 2025 17:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755796015; cv=fail; b=ll4WpfOu4m/D/YYtLLuo7tK6+5uQdubwxkkq7jY0DtyVC1eLVq3K3zWI3mY3ACsGm2ZRm6e1zIWGnLpoZ9Jd+koBCqxtqkLe4vJD5DZYNsPrRkQwELIqKWEgRFBo4dtwzWgZ8C98SCu6LftFV1tBVyoN+fPrnXdszRq0dvSuHOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755796015; c=relaxed/simple;
	bh=s2itdWFGJ8zXsZcu68K2IfPtYrdN5oxzvHAVriDGyRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Be/hTXFpXghU0/IM3YA8ub6pNkzDGeEWY0KV1Qd6UXV9omvR1OQ1Dp/g8G+wuAqFJp+19DlntT/pCNk/3+9WaoSdcxhCnOhzEzgucKmeCi2chQhYCU2TRhYjXSifpBoCtNYsrV7zr/2YdDTsTRIl66TW8MYbGj9syO3/NHYqmMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hcQysk7I; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rVUvi48j; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hcQysk7I";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rVUvi48j"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57LGC95v009757;
	Thu, 21 Aug 2025 17:06:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=bJDtvELWiQv5fKlCra
	D6UWsFL73bIC87VjafERFfGRs=; b=hcQysk7IHSp7HsITcjWnOz1x3ZJIN3SK2l
	0fXtwoDNlqgXn7h9GuwfeKosXwrJfMriAjBhwCHQtVWJY+QwgdhII0xFQPW4jZHd
	P3sDg1kihv/0u9JZp2FWS75leWjfWoUiDJ8Mawhb1/6oTAJ/dkvysHbysvy+0KoY
	anU/6kzyVAvlwJfHxG8myf96SBwTnYLmliEuTtwVQ9ubsmPfMcGvNugNyw9z0ZKb
	fVaWseDG7VuPuGgEN8smjXJEJUoB/BqYC3oRClnaOsMok9L8kXXc7uOiqc0w8XNk
	AR4TtHW8iApqhy+VPtL15KvGcwY5Z38amjI4Q2HgyIiynbNOFBDw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48n0tqv4uf-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Aug 2025 17:06:05 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57LGL0mQ039670;
	Thu, 21 Aug 2025 16:56:57 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11013059.outbound.protection.outlook.com [52.101.54.59])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48my3sbcxp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Aug 2025 16:56:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bKHBTtD67YivXOYsUo4SWp3VqIfKFMUTRD7CK3EEBJj7XgpgH1xa+4GdyuMWeAyWR/Gykne0FEtOgKCndmHz3kb5t0+tvaHHlYh/ybERaR+eGhMEgbjad6tzK5LwPNkfq5U3Q6r+v2TLe6dY+oCREfXdJcd+VOgxEPiZdaATBzRyF0D+4V1YX2OtI3FamYlUolymrKyTBQLA4Wd1TUAnM9Y6yEouLElMgJTRgwzZfTaIdZFHtzGo0Iiov3sXAFAwPkRCswAWJvvBDLfbSxXnogg+j1L1dQCz3sBeEPD/MZ4V8FPauksJfr7EzQ/Dxqfq1jjoKdUSdiC+nP345FcpMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bJDtvELWiQv5fKlCraD6UWsFL73bIC87VjafERFfGRs=;
 b=yOgeB1EVwB5R+WyEw5pLhuMhGBJ03p4YuFs+bsQOOTZAIoBVNrVSKuwHjg+sA4gSXNUPa7lC/nTJAc1s4PpJjVzx2ze5djZh9ZrDkGLEX0Ww2oa91FFHtyuhR2Rt6IX4KxG2KEfVyfGVfg67Mx6azYmogqJxUTEuyPboHWrO5gWVIRcJlPikbL983sKYNwgdVoLQ0xL8uoK+nhZlo9aCbCfucGUmMvryJqmU34Nv6fH1K9tSN6L2/fhp+TZSauwgsOmK2ttlMWki8Ss0acrg3tzXtcR8MFUo5ith8PCLz9/zYjKGwyBZ7KAlqAaVpmSN3OJvv2aqQlcAqe3G3S9isw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bJDtvELWiQv5fKlCraD6UWsFL73bIC87VjafERFfGRs=;
 b=rVUvi48jJ6e7oSaiVzkn9OxBJG/FBXhgJbo0EsCg+CqXfJouycmZmeb4T71bGdxFGacCM4dFCp8elEG7q2SgTROA5sEhEaksnmHEdCibB/drrgzy+madnCXHOI07ahWhhkdkyqdS5jaR8MsSEQoLpYMnoFVwsqqkMhba5I9A5wo=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ0PR10MB4703.namprd10.prod.outlook.com (2603:10b6:a03:2d3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Thu, 21 Aug
 2025 16:56:53 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9031.024; Thu, 21 Aug 2025
 16:56:53 +0000
Date: Thu, 21 Aug 2025 17:56:51 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Nico Pache <npache@redhat.com>, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, david@redhat.com, ziy@nvidia.com,
        baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
        ryan.roberts@arm.com, dev.jain@arm.com, corbet@lwn.net,
        mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
        akpm@linux-foundation.org, baohua@kernel.org, willy@infradead.org,
        peterx@redhat.com, wangkefeng.wang@huawei.com, usamaarif642@gmail.com,
        sunnanyong@huawei.com, vishal.moola@gmail.com,
        thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com,
        kirill.shutemov@linux.intel.com, aarcange@redhat.com,
        raquini@redhat.com, anshuman.khandual@arm.com, catalin.marinas@arm.com,
        tiwai@suse.de, will@kernel.org, dave.hansen@linux.intel.com,
        jack@suse.cz, cl@gentwo.org, jglisse@google.com, surenb@google.com,
        zokeefe@google.com, hannes@cmpxchg.org, rientjes@google.com,
        mhocko@suse.com, rdunlap@infradead.org, hughd@google.com
Subject: Re: [PATCH v10 07/13] khugepaged: skip collapsing mTHP to smaller
 orders
Message-ID: <e5b603f8-7617-43bc-8ee2-ef2be796795f@lucifer.local>
References: <20250819134205.622806-1-npache@redhat.com>
 <20250819134205.622806-8-npache@redhat.com>
 <b6ebe641-0a0b-40b2-a34b-07393f883985@lucifer.local>
 <20250821125445.5fb61e90@gandalf.local.home>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821125445.5fb61e90@gandalf.local.home>
X-ClientProxiedBy: MM0P280CA0072.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::30) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ0PR10MB4703:EE_
X-MS-Office365-Filtering-Correlation-Id: 352a088c-a9da-4a88-6dad-08dde0d3bafc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bmn9yBLDsELN1Na8K8o22YenEpy40sEVSh5glVloslMYukLy9MHtFppKe5Xa?=
 =?us-ascii?Q?53zf1RMS5ExnrrcaPTVQWTIkx/l/37laVEXz1Ok2Ev3Asqh0Fh26olXlrlhH?=
 =?us-ascii?Q?Gcfp3E9rbaa43z6th/3sroc5lGnqKmo0aq7I8xCOP7ymT41/Icd2iP4IL8Ba?=
 =?us-ascii?Q?WtTTH8r1nSSZevsMrXxQCRt6Il5u6fnVnJt4UDBCVuJ9HyCxWc9M2I+ZWkHr?=
 =?us-ascii?Q?0jD6u1Dy5UhOZF+Hu7yuKv8NYVGXfsUZ9GtqGTQp1OOx2rqQ7Q/NkRoCjbpo?=
 =?us-ascii?Q?CEHo9wgA0zBhgmw5jm9RpdnIIx1oQMO4cIZ3tnAK9BU4sM4XBBzRf2X3Aami?=
 =?us-ascii?Q?v3WQCpp5mxBq3063MmBHVi3shCFzZlrWQxDwTmhXyd+o9QdCSvNViQTWTp+e?=
 =?us-ascii?Q?o1Z9xNxv9ZX3ypBSlonjvjWsH0QRWr1qQDqBXaE05c25dPx6NJJtnNVUqJ5d?=
 =?us-ascii?Q?ggQqJsmGA27zW/AYcVX+kaJPZ4iI8L6GzZhR5vzuoyuqWuWWYKI90vCfT6ZF?=
 =?us-ascii?Q?3qJesaKOOokxG2wFkR7hI1MHMAyvLOPst3GQF2JlCyTgInBwjNtx1P8UqaY9?=
 =?us-ascii?Q?OHkZzh0QRBi1Dtl2kV69d1u6m7VUM2RcO57RvKw4a9lH7fR9NC+3E+bOP9xo?=
 =?us-ascii?Q?8O7gQEh99W9Z0X3d2sOL2TZ7aElmPSgIes2RKyugo7vLSatn6f7ZOipeBiVU?=
 =?us-ascii?Q?qXBw9uN7iSEzJFNaQJQJrJpoUtjEILG8twT7w9AZ4PdryYYewCm+qTqHzbwn?=
 =?us-ascii?Q?IiOfhqpVSENpWwz1DxuhOd9hWXLF2IpbwBsAg1vqHPHaxXUKWTnK/rkVF2Hy?=
 =?us-ascii?Q?cXLSSMeSbaHv1rAiIoGuXJApwBWCfgBqIyMHgJPscqHsFZaa9igy/Un+y3Tn?=
 =?us-ascii?Q?rnxYDcInYcup5SB8OZPdrPKDjdlvRZPxbvUvhPsfk2g441kbchbYDILYTL2n?=
 =?us-ascii?Q?ybyASc+rtHwRCnAyyscGSaV4bERq1cWs5y5UE5rK5bTbkbsVA4BrCZMmzkff?=
 =?us-ascii?Q?/GdX0fD7+awg1rZh7UV0imSECMfW/qgJaY8Xn7nOJFpQ5mplJoyBncZzbaHn?=
 =?us-ascii?Q?we0O1SExvLYM9K0ltHC/MVm409MhSv0Vw/84/uQGyX5qbULrdF350ulp0czB?=
 =?us-ascii?Q?NZ2nOV+TyaLSB2CjTX4HylR0OQuhfDhq+DXnau2246QbbiY1YV3S1MOUQJi4?=
 =?us-ascii?Q?b73duvxgOfMl7CdPc5acLxwhKPuB+yNV0QvHxA3vBz2o9ISec/sQsTIVIQRK?=
 =?us-ascii?Q?lsw/ocML35YLsbepsx5gEYObWvpIUsIYfyikRVbCkEQjCSUDLvtyXD15fvpe?=
 =?us-ascii?Q?2ItAVnaqqnQdoBjQ+yeZBXxllYOubmNMq6+636MSn9tGxRbLpQ8EDno1s5hg?=
 =?us-ascii?Q?30K1a49xL0PhH+oSqJgr7c3gNAwFbuZyMZU2KREIul9c8rcpZO1htLLfvMM5?=
 =?us-ascii?Q?SPkghOHq/Rc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?t6GbOJqPzkikTP8hfoZEW3tfIPQNUpboyY+qM3PNSSu+fehZzQusSBsWd5dE?=
 =?us-ascii?Q?lAhKJwnAoU22HcOy/8Ak7yzzMKSCZiCO1KBl92SnKIE2tcYrFS1R9gYyTVLH?=
 =?us-ascii?Q?m8RyJCwtm7RFwFYf8lP7E9mlSWPUYymLqBTi3Px1QtRrfTnyrd7OC5jyAb9D?=
 =?us-ascii?Q?ThudgEMna8C9gF26Dc+XUVK2rbIG8227CQgfgG8URnIDhjVUVP+Tgn66XW0r?=
 =?us-ascii?Q?kj+1IP3AzNV9i7U4qkNuh3KUYIRF4Zj0zs1M3UaSXChAbyOhVm1PhU4wPC/Z?=
 =?us-ascii?Q?bAWS3kSK44QjMufl2PEl9Q71h+bcmAU73nsWu4Y2r27dG+8osDoKMCfIKA71?=
 =?us-ascii?Q?uzvmxsVoc1IHCzxFJPUnwERBu+MOrFDyaI27JRMFzfA6epOw1NnbvPXA3Qj1?=
 =?us-ascii?Q?kz4sCw4RszrFSbG27PSsUs57prpseFLZ6WMLeTOc/O1YCpYDTyvKjotrczmq?=
 =?us-ascii?Q?qrz0tTs9dbt+D0DsLXzM5kCipNY2dy6ip/PtGMSLFsyFieU69BIM+Jz7NWuu?=
 =?us-ascii?Q?vazBCHzVQGtuSpomqStqdevEp9xHPdUfWd1IH5fKFNAnhvOz6uZ7ZsUVUOXp?=
 =?us-ascii?Q?Vya+sXLSPoqFSVJEXB/99Hci5d4LhEbZfFo3UxQHHfL/85k7wvbcoPWxsBuu?=
 =?us-ascii?Q?qqtYNeKwd6kUgWPqsYBorcvVAmDcz91ty/yS+X4XRnIzNc2+VvdrTqwPjIaV?=
 =?us-ascii?Q?CWv4MMpvDJ7fn1+FTILKA9FfSfvOEaGni9JtKfsVm5pbwSzaWcI+SPfklvcv?=
 =?us-ascii?Q?xb+090nSeyxxRMzHLk+6vHEW+OyWLUKRJfHd/DSSZmyc1/t8nv/BTTownH3z?=
 =?us-ascii?Q?stBbg47H15sp4zjx+yGXa5yXuJw58mfsjvhNs8oAPyCZaytCpajBTBepVBPf?=
 =?us-ascii?Q?UB5zhj+N995wdCZK69PkjmYt4IXTlUoGjhnD9U8smGpKvriycPAXpY7T2p1y?=
 =?us-ascii?Q?57vdh4xF/+BJP+0QLExQtpK8s88lSXECpiG1biSLkDP1guQBtcyfngID76+j?=
 =?us-ascii?Q?GrgkqFHYtA/Y187LUYDXLHvAOJLKSJjSMfrsn7mr9mjoSRl/UbiQVnSpZy5h?=
 =?us-ascii?Q?1s3wPa407SUpg6Pg7xYn89LleYMuf+PBtM7t/wI71r/HX7xprWK5/gW2MmuF?=
 =?us-ascii?Q?j+LbQOs1X9CoEbjuEPoR+p8+hvssSzi0P/Xa6eO86e2/2edO1RkzCP71n6iu?=
 =?us-ascii?Q?0VmPjPak9yF2TDYELvxkwAp7HA+tae/c+yZ+c0pE631oNg5v/cqtjQmg/Esx?=
 =?us-ascii?Q?6N92QDqbHV4GLm3az3ObrA664Us8Il0DpzIIOF1WGrx1EbgtABZSPJXBrtXy?=
 =?us-ascii?Q?R6AMYPL/rXjnlSO5I8Xz4lHCsI2vCgqnShEhVUP2dSQltDJLNJc3lJzUtUM/?=
 =?us-ascii?Q?5HRyBdGTJ5rqxbq/RhoRflsG4Gav9vw2Rez55APgDJqu6/xSk4gtrvCK61/x?=
 =?us-ascii?Q?zPOu83bT2Y22XoZh0gnW02KMDk2tGU0Axk3wZUFezqukX4HzWwTgv99hKffj?=
 =?us-ascii?Q?VsUNFaLHKG5aYGCOhKMJkM7RMxqip7xJTq2iVOYAqxE48FGI2nW6poY+eq5x?=
 =?us-ascii?Q?kqTz8Pxwp3uRbAcjKBe/tCJdjQupUVH3XUTT7v4CGA8PjOuTWjYLvVfKqnFp?=
 =?us-ascii?Q?ww=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Q2cGZc7t2FwjleCvUA85C8jazoTZJzloC7USeze2SAq5Oieb6uFKFiE9KJGK0KZXepOQ+lJhbQL7JARC8pZJmxcSx3s41sdHFAtEWAo1Jxbe8V9FsRFmwq6YFa61ZU7G0gmz8NBPQkxxLCXoKtML4PRFRHQcBcGnHGMyQk+jr+TU6Wv8zn2ObgYGvv50cfe23cCydBb+qDGVxVHCRg64iJL84fJk2GzczrHgiK/SDNHPm3CyfoXGcrxFPxd/IjZFEFZGqzctKabpg4uRmH/emODQ9rAvnVZB5Bs0wJStLTry4WAsMAncY0/GsmBlAjKtgc0FUnFRu/duy6IVhS0vSyOy/C973Fru/003990dAfMYcJyS2xM+b4dmHS91RlJDJXYAPoMRzfT22p8o6LcjumN/NoGdakge0PzYIVJlIqA4zMm1s1xaXGFqESbX8egTiOzfOJ06So0ZSsYaZksWSmOQ7V/CsTksP2gQnvEnvKoE9UvCTL4dKOYhn80qZGThWXhp/vvcaKHqzlHNZGyIB4vFNGUsU+YvwooaqgXYPN936i9FKzWXKRDkIzRAG5rfzMqiQ3TkAyN28bHEtrTedxmL61bpxJwCFHhB0+hBkXY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 352a088c-a9da-4a88-6dad-08dde0d3bafc
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 16:56:53.7075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oFyhQ23TxoYDfp5sxpL5jEoP2FC8WtbBAnQKRUxW3EvkAEgXQcRV4Bwq6SNiLEAjqIiRLXiBMdQC6YtzKCkLxLcuXFJ42VZm9ieIGoX84S4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4703
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_03,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 mlxscore=0 bulkscore=0 spamscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508210139
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDE5NyBTYWx0ZWRfXy9CjfXc4RQTq
 A3yJe9Kk8r7qzjv9b8qrepo15xHUwSehLLobpdVXPBj3H8NCyKLNqWK7HXO5j6x0My/TNa/RR0V
 en6D9BLCQQJmHBsSI33yM/uybkX0uPBPDa4QTHSdXx84KVpfx03DDwELCqSjnyVllEK0JURPYNe
 HFVKmJPXyHLGCl2Ayro14fd242R2++2QZWePwAE2tKTC9C0FfpCMqs1NmDCVcQ717DbptJ+7L6z
 F93OD7WVBUFbcOgs6qTdcstd9wuGHKH63S2YBvXOEFU+ZGYGbF2qDTKf26FlX7JiTXq1bUm7Ytd
 DFFzknJ9ytiGqKUvU2PNnmHiB4Eixs6pHtacRF+qUpaluEQE8EDrPa+cVndWan7XSyyQ4T86fCs
 ViiW+j9hXDYEG4LCebhXq2H1FU4lFQ==
X-Proofpoint-ORIG-GUID: 8htrBbrN95mOH7UKEMJA3YvZwsd90nZS
X-Proofpoint-GUID: 8htrBbrN95mOH7UKEMJA3YvZwsd90nZS
X-Authority-Analysis: v=2.4 cv=K/p73yWI c=1 sm=1 tr=0 ts=68a751fd b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=lUKcqs3P7AHZR7GaUCsA:9
 a=CjuIK1q_8ugA:10

On Thu, Aug 21, 2025 at 12:54:45PM -0400, Steven Rostedt wrote:
> On Thu, 21 Aug 2025 13:05:42 +0100
> Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
>
> > > +		/*
> > > +		 * TODO: In some cases of partially-mapped folios, we'd actually
> > > +		 * want to collapse.
> > > +		 */
> >
> > Not a fan of adding todo's in code, they have a habit of being left forever.
>
> It's a way to make the developer more depressed by reminding them that they
> will never be able to complete their TODO list :-p
>
> Personally, I enjoy the torture of these comments in the code ;-)

Well a person must at least _somewhat_ enjoy torture if they decide to do kernel
development (let alone maintainership :P) so this very much figures ;)
