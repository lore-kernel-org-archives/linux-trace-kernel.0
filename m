Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B811C5D44;
	Fri, 25 Jul 2025 16:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753460114; cv=fail; b=OIh1X3bLibpg6zQvsiXJK1JJiaxT7f0Phnc9bjQqUd5XbOGhq0Wb4Z1VI4RyiQMrMEn/wSRwb5W832gVNtoRpmRQ1oIaWUYDRBOLQShIYYiym0LyV2yyPgIczMMsjWTazqk6RT+GBr0EOEjkHcCHYInPEwjheKbrJ7KjlmCpvKk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753460114; c=relaxed/simple;
	bh=vPhg45LudzzOo9RhaW3SZODrOgEhB1Eorwwg+bB39Pw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SyUFf0P6GSW1Dkkl7/wj/c1qgpKZ5YHEvzAJIkfYmrhusd4nxEpMqGGPiYKhq9kb6LXVidv3rPcCSEnfHnOCZd1Y18D89a5ON3ppC31aTJt8jBz/UbCKu2iXXkdSHThvfSzWqocgSs4pc4wZ4rIE9iT5hTxwD1725GVY29ddC88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=M8a6V9a0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zS49BnWL; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="M8a6V9a0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zS49BnWL"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56PG8rLr023868;
	Fri, 25 Jul 2025 16:09:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=vPhg45LudzzOo9RhaW
	3SZODrOgEhB1Eorwwg+bB39Pw=; b=M8a6V9a0TNUdn3WIGxYS9W0ahJ0sX8sFHH
	qylqZFTIGXp5Un+s6yz672cv9W35lWS24Qu0CVQueKKwv9elEtsViC1D5A0AnkhT
	fisacHgSSOZce/+GlioV/eWtHmnyDuh2Uy/0qeoOdq2PkVkQ8VPhB6jFzS8EuYg+
	E7mK0c+k5tDFFBR9HI4mzjXSgYromnTK5XVONx1NR3dDLjhq5m8DoEXR+zB7JC5c
	e4VkmRLK8Rntq9dYiz5z5FLQp9IheuNGmhK+7o6dXXMvUTPzKB61wrSIB9inrzfl
	dyeTP4KxvqcGTR/CLV4oh1e55f5YopFzut6Toa+szrfqjoQ5z0LQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 483w1k1ccd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Jul 2025 16:09:19 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56PEZqQH011419;
	Fri, 25 Jul 2025 16:09:18 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2074.outbound.protection.outlook.com [40.107.236.74])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4801td703a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Jul 2025 16:09:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YxwXQ9AOb7C7wZoyqOizLtc6wYYSNz7DVvL5hX7hkFNmXL8H6xjwZ8sPJP9+ghWzB3KvnFA9m/wOZ3badhwoGq5ro/PsD+2zXtVu5O1txUz91ovYwqrDj6Z3E+Ghcc95H+DSfvctxkGpqkd3BRE8+T0/CyGdf+ufIgOeM17t2L/SNImRo5bZw09+yhUks1gd2iVFkzc2Ql+FSk1844BGBIDoSYpHAS38AQ4sP3n56J79fb87mha4rCdSGSu9j7FkyQ97Micvv5WxOiscOBRskOdobe9FSLKG9KMIxCIm8A52CsPUAF9lyKe1/2/Z4KyC/tlvdeDluD1HqfX2GvTBNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vPhg45LudzzOo9RhaW3SZODrOgEhB1Eorwwg+bB39Pw=;
 b=nDfxBX9ZQJpi9fIPXj7FATWVd6mgaqHYB2ltwH1rwkBU97kFUuJs9OHhzSWsN3Mt2gfTpBZ/fuazjAFfr/GAkkoOIPJKfmQJZgbiqfilgWRibWikzCI3ZeuWEcnOixyI44ojNAUkPXFDklI183fgbhfsYHqWK0e1I9AW7RJnP8AppEDXQ5KDNk8c4Rb1TCzIXVMs8GAlhyxywl9OvfCkiFpfgA501PtLwLk/UZ/oLFa7pAqUDWFcvRteN0bMPncnk1YvLCSWSXQajqXdocgKJGT/PeDMLuHX8L/QSMpmwuHuF27VF2CwNZhQLYRX/GwIyDUkA53ee7HrDQGoOcuKUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vPhg45LudzzOo9RhaW3SZODrOgEhB1Eorwwg+bB39Pw=;
 b=zS49BnWLdice/9NNwwRV4bkcsx/qs6SC2J8DN+vbi7GSU/dkt4054oyG3OvUxHLbbqzTQw6PIVsesEp9ORFlY77LQSFdlwK7rBCYnjJvcmO0Go46nZkLGyF3tnUuP3EMYLJdfjpVKgz59pnXTnInGveSBJdwOy7VzadhcojZ1Vw=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH3PR10MB7863.namprd10.prod.outlook.com (2603:10b6:610:1bd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.24; Fri, 25 Jul
 2025 16:09:13 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8964.023; Fri, 25 Jul 2025
 16:09:13 +0000
Date: Fri, 25 Jul 2025 17:09:10 +0100
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
        kirill.shutemov@linux.intel.com, aarcange@redhat.com,
        raquini@redhat.com, anshuman.khandual@arm.com, catalin.marinas@arm.com,
        tiwai@suse.de, will@kernel.org, dave.hansen@linux.intel.com,
        jack@suse.cz, cl@gentwo.org, jglisse@google.com, surenb@google.com,
        zokeefe@google.com, hannes@cmpxchg.org, rientjes@google.com,
        mhocko@suse.com, rdunlap@infradead.org, hughd@google.com
Subject: Re: [PATCH v9 05/14] khugepaged: generalize __collapse_huge_page_*
 for mTHP support
Message-ID: <f87dd075-59e1-463f-bc36-0f6582abf31c@lucifer.local>
References: <20250714003207.113275-1-npache@redhat.com>
 <20250714003207.113275-6-npache@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714003207.113275-6-npache@redhat.com>
X-ClientProxiedBy: LO4P265CA0266.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37c::8) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH3PR10MB7863:EE_
X-MS-Office365-Filtering-Correlation-Id: c65d3e12-62b3-469e-c680-08ddcb9598c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?c9ME58wQZl1C/pEsuFrJQIudxIA7Ql+Ym0jd7707/LSXboYTYTdNXUPTvfge?=
 =?us-ascii?Q?3AHjF9qSX3Tp1FcVSGIINKbnLdWVfTUDw6KHABDxonS3IvJ+qp+sijNYBrwB?=
 =?us-ascii?Q?aYjqv1XWivKnc5u3q+adiwDvJjflpeV36Y3K3aUQ4mVQfUePaJAjoFCOLW7H?=
 =?us-ascii?Q?rjOD4NM6ZQh8hJxj0qFoY3hxSbKGUWYlriwR/aYu8SXCc69KYs6qg5qIVr67?=
 =?us-ascii?Q?LSRQDmdLkcCo0ZfK09QS8f/1H3b9MaUWojVlU3EBCJ2zzSYSkEWm5JI8zcoa?=
 =?us-ascii?Q?jdKni5+sybw6PYiyMovA8QLdkrohkLy/TGpSLLJfxZs5wRzOyePME3FQMjy0?=
 =?us-ascii?Q?GC9YfZR0eGoMTaJQ8oM1PTBpXgf2Lalbxa8fpxbxXXiTC0NhL/A6AXB1JgFL?=
 =?us-ascii?Q?obRBP+/4t+X2D9KwwxTtUb55IE9yNyTwln0EemjSXgqOxt2qDzJ/htZJEx53?=
 =?us-ascii?Q?cN+q04tHQmupDUnrdXx9PvyY9l811LhTJOFs6jMCgovml3YPgLLVHmTZSlsz?=
 =?us-ascii?Q?/NYPeCfvaC/auWoXmhBqzJDA2Luq3JRJALcv9dWz3r+aUE3a25KkXlTlAU84?=
 =?us-ascii?Q?OtEFPbEMqT2Bpd47XPlGGzavt7n9K0iSQmNAebnx+ipUXXA5fHHst/S72n2w?=
 =?us-ascii?Q?aphDaIwu4Q+hjh8ZY6CtDk48EDI5o7z7QuePCPnyxW6tzhdsehYtibwRK/ue?=
 =?us-ascii?Q?qg6xuMz31t8D3Lwlniph7yuaxORnRs8VVs5kiZQnwBNQXzcD3hT6sFllh1qL?=
 =?us-ascii?Q?cReFbs70bo3w+qoSaU2KAaUaKpUaKSjWw+1OG+ALC7bKy2F7YJeh/3d055ZL?=
 =?us-ascii?Q?8rXURUDH+JONrCs5unWfy5YRfLr6RZ0My9Zv75dg3ywkjrEnFe7Z8zkBIbMn?=
 =?us-ascii?Q?LCrOQe8D5tJKAo1Ooa58/iHGJ/E45/6JnCzibaK5SGHPvgdOpdsrh/M/AK4K?=
 =?us-ascii?Q?HG6tp9W7liOlGafTcvMm7hob+Iqdf9B0OdvHzJboKz96pJHZg1iYHkQ2+UBL?=
 =?us-ascii?Q?rlfotYYmpHsLo7oeWSA2H9EhLEuMNYBlJXaDN/0v8+zDhsZRs+CjvgjpCfjV?=
 =?us-ascii?Q?l+UNvmVB5rucEGGGisJaraEYpdc1sjq20dzIu5pYPkWRSyZHHm+yQS2wfZmG?=
 =?us-ascii?Q?KE9wnsqZRpVk8XWugrQzDjoBDx6VbZexIIQFKq5kRylLHZ2Oijdje612EAPo?=
 =?us-ascii?Q?GlDdIGl+kG6SXoUiTY+CBiSZYblJh/kezO6jeHjGqNBXMXRSmeaTP5u6NmLT?=
 =?us-ascii?Q?2TIHkIDL6SwF7a/dOI2+zszmMpFAwkVvooB3DiiSRqgdtVMnWX+5JzRQl4e+?=
 =?us-ascii?Q?v/uF3qgUSvqdJ19uJ3WV6L5HwcgQBg/bt6n+z4m60x65wlnSli5lCF9C3pSv?=
 =?us-ascii?Q?bkdVHNdftgfQM4eiOHqQxp7HqFfAI7rT5huP80WTJXK0R2j4EF9/FB0B4Wj6?=
 =?us-ascii?Q?vInt8Xl7YmM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?K8LJ5xlEGKZuYr9ODJ+sVWC0zX15Ko91Sv2SjVjUhNxQ7EBMyjwbdgLb283W?=
 =?us-ascii?Q?25S1aZasWHwt+ByqPghZMroTY2XczLDWEwtZlGMHtwDe+E5qqSVfU7ivQQR5?=
 =?us-ascii?Q?KdUa3njczkrdL69zQvv2fXRM+6KW0weq56vsYmIdf8LGioqKTSq26V+1h2N4?=
 =?us-ascii?Q?WvViSniiOiE/Vy4qmiuTiiD7sM03rfizhxHqaOJmHcLlLVd5r/t4eX95kISp?=
 =?us-ascii?Q?9MsHi0oasShSiF/PLrxoWB9xOXlGui5gwe43KFRKgqj/EH8FiLTOfCSJDm/9?=
 =?us-ascii?Q?tZK4U9mAYH7xPaeZXX9ulNbR1Vz5nBG+6XsAhAz62A9UfoKnzkMUMUgQDloE?=
 =?us-ascii?Q?JVsfER3O/67fEQkA9Cab8fgNFbkZcSO89CiUbYwROLZY1b/f2zRyeI473qis?=
 =?us-ascii?Q?UjKLwJk0InrDN8maZKBiWoCjcm0du5z4pWw1YJrHDS4Tx7oahF9TsISTfNdB?=
 =?us-ascii?Q?9PLHW494vv7ebD4mNy9zDG3WVuhd2yq7Ux+gGKuemMwnmNBPf8EdxJpXEuzP?=
 =?us-ascii?Q?HGw5f/I0pDufr6q9yZXOzHIAg3c2Cf+XOPLpKbJK8peFdZzq5/fSXkMKlPGE?=
 =?us-ascii?Q?29WvmCLfqFUzYgTsqp5dQKObQqhbTabiB/HZhTrPn7N4MUpgqs6/c85R7faF?=
 =?us-ascii?Q?3Iv7Ox8RQJA//0VXa3eJB4KD+sLt6VkgH1ZzOlkONyJEfIUG8lHGhmsq5g4V?=
 =?us-ascii?Q?zEirD2Oak47BEcwv9P0CwQhB/o6pARelaKDqVJ57Kh1hRZD+ik7r4T1xNZHG?=
 =?us-ascii?Q?KyePb3zQ8T+y66ZGHqd1QjMVNtSDb2xxGKRSeCmQH6onMB8cgBpM82KK+c6q?=
 =?us-ascii?Q?bxfF0qTS/+ns0dhbiTH4P/6S4yInACZjd5r3EzSVqC3eIOy6VavZyZ6sougT?=
 =?us-ascii?Q?qT4bZP8l8E6VYM1tpNFnzNBEZKfN8FeM2DK8F9NS304Ekn95ALPMfAvleT3c?=
 =?us-ascii?Q?H8n2/f3xNRYmZMjJAFkcKAt3RzHHe9Lgz4Y6VNPwwRZf0JGA2NOzeylbBYnC?=
 =?us-ascii?Q?dZzTtnGeb+4msbWGAGJ5RzjqkyHhXXuzKX59eu9px3JLuprgiq6ZrIioH/gZ?=
 =?us-ascii?Q?Y+3FIf8zd0EcZ2jzWvlIC3nwRVbfMvjfk3pip1HbsGDfqeuT4BOq5VspKu/x?=
 =?us-ascii?Q?p/k75PDQVIW6uGgvRfQKk33B4lfF6lMiaL4Chbk1XojyTR3a4FYjdnYe/kDS?=
 =?us-ascii?Q?0cxKsMnwqZEaA2ghfuX0nV8LV1RiTrVvKe6yO8gIZ3RRkMjCqqmzfatd94Kd?=
 =?us-ascii?Q?+sI3vHmb31c9jibRVZUE8vgr5AZQ9nCLU6Uv8LIEI7DOwYhOtX9a8LSQ5cm9?=
 =?us-ascii?Q?7dCS+gscdOcA/Fh46ufwc+9eRN7aWOcAYwZAsbYBoPvKWFKXMz56QE9SUGDq?=
 =?us-ascii?Q?Y8mjjyBz8btPY5AzdeZXHljJTxeyh+ZVfSKXfcG+AnQn3rNJwkni+5lHP4fV?=
 =?us-ascii?Q?K6qPd2RbqxQ/wVtAnC9VN4CFEkIWgQrBTsZEVMJuMVfc4fOiPY5HyBnamWro?=
 =?us-ascii?Q?0VQUfGKQjLqNpXwdiFgCP64N/gNjZO3NcmZ8OiasA6rSVo38Bm/NEX61XRpP?=
 =?us-ascii?Q?MjeiUN8JDRED9CuqA5F12BwsmCbv3XLHjvaJBo5vDwfXrKoGfF70hMBaHxM5?=
 =?us-ascii?Q?dQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BnT33/7+Fn2c2I2VRQuEFpUYlMDS8nHsO+FqWYJ3pXsCMA08ifq+YueLkfDIJr+dyeRDix7a+icmHwrKCnjC+4iOEGnun8CLjFhHKxR2f/7opzIsAGGEF4mnXYURLA8Ff3D5zVARoyQ6+AuMfKT0IteQWrOxmTajEIA8/zlaApFLQPUQ81f2MzMGGvrfUhHt5VczgzDhigi8YcwJelVKA+3VxtwGIJnOBT+vPV5D0YqRkz0IOihvuMdTQ16nOjEKyIst+/crozksPpv1OEdLygmMcstdXkG+WAlInht0+hzF2P6yCvys8iOOTbQ++VsEzDtMUVObgPEoz3Q5J1TRHP/XJEPcIN96469CvdBOWSZGjVHYYSHpCh6Bz0FCwA3XGYUOLTw7laOIsigeL8vk+YVNmHJqUsaKR1JQl+mJbtO19z/7KXk3WMmX/QTtmPEPzqm97UdwN2Zy+CRF9Xak21ddbI6N5RkUA/wFHKUlHSKXXY04MpeUgVij97fH672wqrPYYxjjm6PddmOFowXYc7EmYdMVUyeXVH3s45TmrZc6XbOhEoUb1kWtAfZIVCBud2FPrXHfBTNRrFTFpOrmd5mXbsJHmCQ5uMwMTW/lS04=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c65d3e12-62b3-469e-c680-08ddcb9598c2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 16:09:13.0663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FDh+XCOBoNM86IOGVYVV10yDcQDSThokdQTwEpc8h9w5V3x2d1J8JXEgfHRyOmO0/Pkjv7nFdLs5+QU83uY/zvDPp6aoe+Y4zd3iHDT4axM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7863
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_04,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0
 mlxlogscore=864 bulkscore=0 adultscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507250138
X-Proofpoint-GUID: MIVoUqkiY09dPyuAJCHx0kXAC6CzAtGi
X-Authority-Analysis: v=2.4 cv=LYE86ifi c=1 sm=1 tr=0 ts=6883ac2f b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10
 a=GIgBT1j04ioqtpi1qxQA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDEzOCBTYWx0ZWRfX+ZkIugdW0kuK
 tnrDn7oW8k4hbEujWFYZhCFc1UrqUnqu3p+tMs0+TDrmrZLObA9QvPSLtPurSFOyet/27QOlhGZ
 EpHDq3zWfFgxU/3CNKPLlO07VP/SXCQddTm3FCkS3hJivLLp18EFl+70tSHrlldyDn9JBtj76o0
 jIYMUJFHZbrRb8+GA6Iqh0cf80wN+sOu72qT3mYB+3xYqlwT5dytyS3tzXE5rsQvze+lmHQ7hOH
 J+202IEXDw+cscUIfjZTB9PXzy1NuV419IB0UZ1wklXh0GGJzEu8eebq1R1v2l+YG+VytcH/yL9
 5bTP8ZPPUY5I0vmlaPeJYWf9QGIoYGW1T/kmsqbT2YKT3Ytd733Nuqx2ocxRn0VP3crtbOTKMJz
 caUF3UJrXy/V/JpJVLMV9EuL4LHzOOFEIdrQvMnEW92AxfWgLu7Iijy4G2tYfKTEmD4bGJ5T
X-Proofpoint-ORIG-GUID: MIVoUqkiY09dPyuAJCHx0kXAC6CzAtGi

FYI this seems to conflict on mm-new with Dev's "khugepaged: optimize
__collapse_huge_page_copy_succeeded() by PTE batching" patch.
