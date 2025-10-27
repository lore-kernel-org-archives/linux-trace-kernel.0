Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2251E29BD96;
	Mon, 27 Oct 2025 17:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761587693; cv=fail; b=mqkDShbR70KBnauygAO/c6J+H050sIht8UIOCMqPH2KQQR0JBiz9cz1PMN8BAUxd6St7CPS63Ju5+chc5auLyqgMCLA5pjbItkNYOEQu+SP02rv13eCu3n6ih1WU8XdOYU8WDqCY9+BZCLhq1BTyS//LBNntdAtEWCWMVeMje5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761587693; c=relaxed/simple;
	bh=MBhqZheN4hV6/dFis5w85zPYh8ySqM5v4tmH1Skvg1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=I7UtEg96RJCuW4vT6KWTP+8emwKZilKtQRz1G7AkiMTa5zwyweCWsXNbvmRk01cLXOVhVKNy28c8fx9rPcvbSsKcejjy+6xnhPThviHxHPuGG4vMjJS++cQPnNhZom9sNDxZ/jV3FoUPm6dlxCgS/acIPcwMGDXXjOS2CJ8INDE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=pWhb2Qka; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=G6zPeO8S; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pWhb2Qka";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="G6zPeO8S"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59RDY9Mb005560;
	Mon, 27 Oct 2025 17:53:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=EoHSh0eXmH5XdclPGs
	QP2ZVDdpcwBJo9FxHeD9A893Y=; b=pWhb2QkaSNbn6ChJklwMQUzHuuwE+xrrKU
	Wxbp3gj5vMiCacmxrXl7Hokwm6PTaly8RjLiPGeDzLi4m9xMbxI4BjCXEEezodzp
	VOKaJ5g6y52BNdKrAbNFt7LT6mJxLWjK7V0eaEdylW3zuHeT7LGwc0WVSFfav/PW
	twJXJansA8IC07n6wznYado+OggvWFEI8UxwB66pC50PWuFdlkOUzv8Hp8xd91TV
	zHWZ1/hX/B1rQOnEh7RzL94w9hQW/9sEvbprSv+IDll3Dl9W2kbzjId8Zlq7bIVV
	2+5zHTMblyZa1/HZ+fFksBbf2SuAi7xfyUXc+BISesbHuyL5v08Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a22uwhje4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Oct 2025 17:53:58 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59RGVnaF038712;
	Mon, 27 Oct 2025 17:53:53 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010061.outbound.protection.outlook.com [52.101.56.61])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a0n074g37-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Oct 2025 17:53:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dmdBU2hF/90+bCrdnzRS9QSJxNOQIgFo6OfKRqu4jVv4GCLAkChmWmBX3uSKvgNrjLM4x9mHxc6cPOywIeo0OOoHHRoX2WnXxGtY+KNw1Sj8neH1QS0AYFc6d+lOq9aL1HbfZikFE3RG8NQlM+qDMdX6KBTXkZ9oBiQJ+ZJwbHuHh9ENtqju89VdBTuUbafZs7zI0xhO+4Q5+IXAAb7vVxwO5EeWSuFW3sonCD3vBAtnJvWo0TlVpeNETT5Nhqc5XdabWJq1CRo7KzW3aIWfW6Oq9aUgd9ZT6rmdnCVn+pOrrzVjOgoE11yae7bipgjlP19a42nqv9+q9Wij76u7EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EoHSh0eXmH5XdclPGsQP2ZVDdpcwBJo9FxHeD9A893Y=;
 b=fuITpTDMOO52ems1k+GLMg0iEu3KJMi2MYfYiy4Jc8+545emtwQpabMQyrIAU6fIpPZs8hdwse2+tSc/ZqgOQAzRcG6U04c0wgWq8o9hvQOe5EfNzgE2IO5SOJCph1/jozJ8v/957sslXKzPRjQ5S+BWQk5TBKX+U19thTHeS53uaLp0QrkTYFJvGt8EuOVkMAlbwbL5RhG0HUiWQ5ivVkITj+OveZoGEjPvlXQrreF13nd7ZQRtCCca/3RJ4oN7XV2VMNj8yJbPBkuCxa2DwMB9Cyx+sLBzIFuEIgLcbvkIk3E3kIWID0Aoc3iJF05RGGsVqVReeRswyVivnCvmFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EoHSh0eXmH5XdclPGsQP2ZVDdpcwBJo9FxHeD9A893Y=;
 b=G6zPeO8ScOP1LHv+zNKKbiFUu7KytcceCXUUI9jhQoQk3D5JUWym6s16JsO8czg7lxQ41E/fSJaV/mLgEpeOLgovJvnU4c0683dbeGl+8CivuNxN6xBfmoOwXlLA2NwHUb/rZFmjMFq9FIvlddZpX1Y+3DWB56HuUOji7JUkLkU=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SA2PR10MB4636.namprd10.prod.outlook.com (2603:10b6:806:11e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 17:53:49 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9253.018; Mon, 27 Oct 2025
 17:53:49 +0000
Date: Mon, 27 Oct 2025 17:53:47 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Nico Pache <npache@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org, david@redhat.com,
        ziy@nvidia.com, baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
        ryan.roberts@arm.com, dev.jain@arm.com, corbet@lwn.net,
        rostedt@goodmis.org, mhiramat@kernel.org,
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
Subject: Re: [PATCH v12 mm-new 06/15] khugepaged: introduce
 collapse_max_ptes_none helper function
Message-ID: <5f8c69c1-d07b-4957-b671-b37fccf729f1@lucifer.local>
References: <20251022183717.70829-1-npache@redhat.com>
 <20251022183717.70829-7-npache@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022183717.70829-7-npache@redhat.com>
X-ClientProxiedBy: LO2P265CA0121.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9f::13) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SA2PR10MB4636:EE_
X-MS-Office365-Filtering-Correlation-Id: 7982010c-544e-45c0-76a2-08de1581c8a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?A56x/f9Lj2/qZnAXhMYHZ3M3dUmvFMIZFfCJEL+wHssQvk3aRKY+s1C/NNJK?=
 =?us-ascii?Q?2cbwR6b3gRtzYDc6TP3g9FLKJK3NPN/LEp5VyMhBeQ0C8OH7g72loAC8l18s?=
 =?us-ascii?Q?fltZz09ADPb1hNAtsBARe7PLQpmpqZD9bTQE3jZDQFr8kINzzyReV9vrj0aM?=
 =?us-ascii?Q?2XZ9K0hp3Yugm7az32E9t5ex+8C64bJwBYKW380XkJ2rfxpg7RMnLkNOEqve?=
 =?us-ascii?Q?ZrNs1LTIGOcktMsiVuy1XvWU6JA1CVLEenfrlyestEK53s8hEBsaXSiC4nbu?=
 =?us-ascii?Q?zEp3X+t7WUCqi4G+HanHS29kCn+26nf67RKRGFqS+xh9sMuYORpLcrP7EaI6?=
 =?us-ascii?Q?HsPYXZt3tszGrTBYZ1uUiOfWgkK1K5/pPf3ZpJ0O0BPXsV9EY691aV1OcI7p?=
 =?us-ascii?Q?Q55KLzpQ6xNe+CO77nTQdSBXx+c6AsUN24OcrH8d4q+GjJJbrRJyHEuE9HvO?=
 =?us-ascii?Q?yxGOOSCMYmJ4xApHVqPPxlwXruZVzPFxEDLp/4ZF0cZykLzw9OgjZftKITfV?=
 =?us-ascii?Q?hTEKxBSk9SibNUUebe82A0Ipf7iJaOK8ZNiv15BBdNqWoawNuqjlUDuTYbss?=
 =?us-ascii?Q?dR+bDdHiYgWia44wSJnjBQvYmXKlM+8KRDCu0LxFXYlteWYedMh4xPFM47N5?=
 =?us-ascii?Q?dR2OWZxP2mFu3S4RTxs972Hb5OPnb3LoE6ghoNi/lan+CES6E6Ok/YI/lH+9?=
 =?us-ascii?Q?Hzgup5AmmGy+uLxnBxDV0150iTl/qFhW0XsthIV0xtoMNV8Y56rwiFZIDGhW?=
 =?us-ascii?Q?sIMFv5wr559/EtjB1Hvng7wxv2g2DjImY7zEy7qJgVsK8sjTVYM5z57oR4G4?=
 =?us-ascii?Q?kUG0pq6gskFDuXKMssWRFwxEz+2icUzZnhsza5HGYs9NHDQEmXGPjX1TU0NN?=
 =?us-ascii?Q?U+JBId2Ar862gO5H7zXG8OJ53V6Te1Aw1Nk4TKjA8Z1z7HIFwkSRQvqgVNgs?=
 =?us-ascii?Q?Gxv1MDylOLLWXMeT0RIrUiyenCQ+042GYGt4FgTwCMAE/2PG+wDlmNBv8yAH?=
 =?us-ascii?Q?qrGwzTbyK9c0MOXDaD/+Ac7WLc6UF61e9cIMiYEie7nEVpnnXnv4puBMttPF?=
 =?us-ascii?Q?DKHjyVl1OSrk3+8ou3kpZKxowcHy+LkTRaitWGLfKOBmUxLlRmhzAU/5Zv3h?=
 =?us-ascii?Q?uMrIgVookKhOMP5U57Z75BzVXSXfdJhTeb0WOXHcz3lp+QyRaDFaYQzB+utx?=
 =?us-ascii?Q?rpWYCrYHaAt0+3Ym6zGIfvMYT0b+G/WzfOPoaOpA7jyMFgAZeyz5dnJ37xLs?=
 =?us-ascii?Q?ceN30yBBKl0V0//TU5i9bW7QPtOPMxkQ2pz/x4HktcOm3xWKCETpCBfshaz5?=
 =?us-ascii?Q?k+oCo2N2bm8p7PwpP4ygkMM4xTESXgmYvGLrEtjZZdyrngKrnOmOo2h3Tht3?=
 =?us-ascii?Q?sMya7T1pyJDdLnYLVWZv7J7Xw4EGUP3T2rrMgqhNRxa7hDM9WTxh0r0VLUE1?=
 =?us-ascii?Q?X5SWfKHUL+J5BF2J8kJeIeMnbc49coNU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gMnGVDuoU5kdMPEfleHlzUz19nBwHbhWfNkoX9vBkpjj6Y2sDQE1twDxb61R?=
 =?us-ascii?Q?7gnNrmD3yi/4o7oG4qDxyzDYkpyc/ZTgYRuQ0nh7y/bhE/kSYKjfZSMdPIfh?=
 =?us-ascii?Q?vctKmy7NxchtDpr8RzHsysYwT6qdk3JLVH2gMw41m+TBtnnaYy946fPOpz5D?=
 =?us-ascii?Q?hmzSHHCmAIdmo0llMT0IwI+3BK7Mtp+EtwrkVoYcUKR1Ld4Y0SgcSA0Vk9fm?=
 =?us-ascii?Q?IjENOXhUX56JZL+tJNFD0bS1JAvrT8A9tEj8aZIQM5OFDOJ42hEPosfCBMpX?=
 =?us-ascii?Q?JbsTXM1NyKH9fC+vNEDuNMUmx2eq3UDJ11Uddyr5kTt+Q2mh3Txb3bdZYLkJ?=
 =?us-ascii?Q?PFEQj/HqJmZXjv+kIE0RRX+t9EhPsnFG4PpLU6gzNfLYNkmP7tmFZUN4jjzT?=
 =?us-ascii?Q?JimrFgUipiPIKRIxw+mEZTvZIRjys6nahEZg6zKe6ci/3KJG+C6faSAlo7mu?=
 =?us-ascii?Q?o170eYS1KNzhN7U9aR0mwy430dF+KnMb2lhp2r+uNRaTSRLSKJ2rLnCbS9MM?=
 =?us-ascii?Q?pAmAc/GlY9RQbSmhpgyBYPDVtb1wsWxsHbTYOmLmu+LBlaaI1TkE4mJ5JoHL?=
 =?us-ascii?Q?ZqAXaH4kLfEOOdttgiw+auPMs4IUfqixXtuW/PllEesV9pyLYxIPa9KbOENb?=
 =?us-ascii?Q?Q5zC9SLmNT6D4Vxrd9xNXhF74XaXsmvZjU34K2tAoaYtiXHGa0qdesvTlZkR?=
 =?us-ascii?Q?S1ILQa5ZNGWYImUxtL2jhzOtj4y5CWYp/NIbXckKwGtbR5DjxpTiqeHrNAo+?=
 =?us-ascii?Q?UzzUcFtPaA4/NY9n4XORxtgJPn8509l8IOYApUbuTWikXMqY+sFlPbtbVxxW?=
 =?us-ascii?Q?vq/smdMP9J/tGambJeGLnnLepdogJEuDOuyFf+MYhBdYaQATml7MShOx2d/l?=
 =?us-ascii?Q?glT42+VwxNvhi7ZTwWsRKYaprVMKrKHpW7ZbXwLTK0ExLg/wIb8PuQjEsmWe?=
 =?us-ascii?Q?wVX5+Lp+uvLDVREX4lJ9sKrB+Gzyj8LBdepFY/Q8X4G9WuE6VApNy1UHmntx?=
 =?us-ascii?Q?O0TqPZjNSJ98InhscISnfVAVDILRvnWcGyIQXNX5+Jf3xwb9mwubv5Ft0hql?=
 =?us-ascii?Q?Edlqynz3lndOEZets5QfiRkPlnDL2WsobRDlR4vY2yQyhopPNRHSDTmEULPr?=
 =?us-ascii?Q?4wGvWIFXTLLxgTmfkOVl40rz9Ee/kWVnCqe0BWHI4eUIeJTiSEI/R0rQkNuK?=
 =?us-ascii?Q?m3q5dvrWOz+zifub64T0nIK4EBd2PZ2xReGCKcLLVwKDfSSTRvGY87O72qFC?=
 =?us-ascii?Q?fw8pk1Z2kz7YV9DplN4BVh+T5KH6EV8h/CZQ3AM3QBNAWBh+ZtLP4u76aok8?=
 =?us-ascii?Q?wbp3h8K87V0aqOjLLv/Qdc2cDXilPpXZtZ3r1wRbb01B6rLbmd1YzHmNGy31?=
 =?us-ascii?Q?xG8i5hwX0usRPlYievw1EExcMD7q8PPyEmvGY9Sv+Lodj6WDfeSY66fj5yIl?=
 =?us-ascii?Q?1WpkyukrOufDl2hEDxaPh8gEALKfEeqmA8frRaH4j4W8Shdi3GWwIcKv7Cf0?=
 =?us-ascii?Q?LzEqmVtZqedKRJyTNCOWZSrcfyOqjqoQI6nm9c2d78+6YV5FkvsyDosFQtB8?=
 =?us-ascii?Q?LKOWNydmbbHBQ6DKsEoYmIYmRlMy2R0sOZxQmqtw29tmjnnwcUwdBABQABzz?=
 =?us-ascii?Q?OQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	I6qGMFDgtWIvBwOKc3v015+JtoG72brojkzmX8lUH4VG2SZfIUVuYa0B17Qx3J+NzUQuiaRMRe2C/vzTsrNui38oDMni7yF6RQpMQO7c8tKO+AE151MAecdm8vZ5Q15OAahrYvGlVkOkDdIAkIrrd2dChGm+4khD4qtb3pu2kZb1GgFtxu/d7aIVEqcW+NgHdbUMCXZ89QObP4kMk8I30NjVUsWC9YgTRoZa18nOTeJWUYOwXLGtMIQv4wRSx4WU8oN/U0OYwfDBueCyMp2oqLLwMYiTyHswC+5xhYZi1vKM6GM+sslPI5GrYJTreV+Ot0QJ3kbb6IWqhg6m4b2vfOa1/glQHgLfyeXIDCEGXfCKOnvsVc6HVprm9+8fQKLf54Ve595dmB3WSXQv/BA5kZ+IuZkqFCTHD+Gjn6J2zPUCT/tyhufX7O22SCWhvnfYctCjRFRpMWvRWxdwU+T/5c3p3dWPwl6JjXpVKLcXiRzrykcWKRRuA+d1qPWk3EJKOOpDRUxmqZ2TYPYf54KmlW68y0kg3GtMYQUg1dcoCAuzBy/3IhDFLdQdVkEJqWrEJahZjxYL24FNwpp+pJyxXIrNMfDoeFYrKvuoiGO3MMc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7982010c-544e-45c0-76a2-08de1581c8a5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 17:53:49.6169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pj6PJk9vVnvCf2MuXfdiW2+rAW7739xlHhEPek6SNIZ+7cG1wTZ1V4i5i7SbVIRJKiFp4i2DfNcEIOGBkVt3/SJk9edMUmqFPBQSIWHz+CM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4636
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_07,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 malwarescore=0 adultscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510270166
X-Proofpoint-GUID: 8obI0SE38pLz5GXaMjVsesqWq4yidh6h
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDA1MSBTYWx0ZWRfXywPFDGPRxXRD
 1gFJ+CDWXCn/MyRthvnuLGiZvB5ovAOoOD3b6LxGhe2Xh/1IweLUwnnUey2fS9nSh/iy5GYncrR
 oWYxlVMVpWY884W5JyyR2humnAkGIvYSrahq+pR122N2qg67h9rKD0bXwr30iskZ3zYXg42zfJb
 hvdSkQKzmqWnSvrfOD6yEZi+zkCrFa0qoCio27vyHoUNi+XcucPiV80C255Qgsy0D8A1ZXMhrh2
 zceaLbj7Y0mTIacqlrWxip0uX2NWp4G3dSmqslHgJE5NfjJSiTBxrMaQf4yF73DtGAxvz79rs5s
 xbmsdqI3+yVPHfAR1GyQ5kIgjVWMqx/60x/WGRov41zCo4DEKgePPNYPCciHr0flkcZ+ikgXdoQ
 KNX1l6dEsa/2WUa61rtU1JK2iQ+nqA==
X-Proofpoint-ORIG-GUID: 8obI0SE38pLz5GXaMjVsesqWq4yidh6h
X-Authority-Analysis: v=2.4 cv=Ae683nXG c=1 sm=1 tr=0 ts=68ffb1b6 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=20KFwNOVAAAA:8 a=nbRkX1cIBELV1V8xH9AA:9 a=CjuIK1q_8ugA:10
 a=UhEZJTgQB8St2RibIkdl:22 a=Z5ABNNGmrOfJ6cZ5bIyy:22 a=QOGEsqRv6VhmHaoFNykA:22

On Wed, Oct 22, 2025 at 12:37:08PM -0600, Nico Pache wrote:
> The current mechanism for determining mTHP collapse scales the
> khugepaged_max_ptes_none value based on the target order. This
> introduces an undesirable feedback loop, or "creep", when max_ptes_none
> is set to a value greater than HPAGE_PMD_NR / 2.
>
> With this configuration, a successful collapse to order N will populate
> enough pages to satisfy the collapse condition on order N+1 on the next
> scan. This leads to unnecessary work and memory churn.
>
> To fix this issue introduce a helper function that caps the max_ptes_none
> to HPAGE_PMD_NR / 2 - 1 (255 on 4k page size). The function also scales
> the max_ptes_none number by the (PMD_ORDER - target collapse order).
>
> The limits can be ignored by passing full_scan=true, this is useful for
> madvise_collapse (which ignores limits), or in the case of
> collapse_scan_pmd(), allows the full PMD to be scanned when mTHP
> collapse is available.
>
> Signed-off-by: Nico Pache <npache@redhat.com>
> ---
>  mm/khugepaged.c | 35 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 34 insertions(+), 1 deletion(-)
>
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 4ccebf5dda97..286c3a7afdee 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -459,6 +459,39 @@ void __khugepaged_enter(struct mm_struct *mm)
>  		wake_up_interruptible(&khugepaged_wait);
>  }
>
> +/**
> + * collapse_max_ptes_none - Calculate maximum allowed empty PTEs for collapse
> + * @order: The folio order being collapsed to
> + * @full_scan: Whether this is a full scan (ignore limits)
> + *
> + * For madvise-triggered collapses (full_scan=true), all limits are bypassed
> + * and allow up to HPAGE_PMD_NR - 1 empty PTEs.
> + *
> + * For PMD-sized collapses (order == HPAGE_PMD_ORDER), use the configured
> + * khugepaged_max_ptes_none value.
> + *
> + * For mTHP collapses, scale down the max_ptes_none proportionally to the folio
> + * order, but caps it at HPAGE_PMD_NR/2-1 to prevent a collapse feedback loop.
> + *
> + * Return: Maximum number of empty PTEs allowed for the collapse operation
> + */
> +static unsigned int collapse_max_ptes_none(unsigned int order, bool full_scan)
> +{
> +	unsigned int max_ptes_none;
> +
> +	/* ignore max_ptes_none limits */
> +	if (full_scan)
> +		return HPAGE_PMD_NR - 1;
> +
> +	if (order == HPAGE_PMD_ORDER)
> +		return khugepaged_max_ptes_none;
> +
> +	max_ptes_none = min(khugepaged_max_ptes_none, HPAGE_PMD_NR/2 - 1);

I mean not to beat a dead horse re: v11 commentary, but I thought we were going
to implement David's idea re: the new 'eagerness' tunable, and again we're now just
implementing the capping at HPAGE_PMD_NR/2 - 1 thing again?

I'm still really quite uncomfortable with us silently capping this value.

If we're putting forward theoretical ideas that are to be later built upon, this
series should be an RFC.

But if we really intend to silently ignore user input the problem is that then
becomes established uAPI.

I think it's _sensible_ to avoid this mTHP escalation problem, but the issue is
visibility I think.

I think people are going to find it odd that you set it to something, but then
get something else.

As an alternative we could have a new sysfs field:

/sys/kernel/mm/transparent_hugepage/khugepaged/max_mthp_ptes_none

That shows the cap clearly.

In fact, it could be read-only... and just expose it to the user. That reduces
complexity.

We can then bring in eagerness later and have the same situation of
max_ptes_none being a parameter that exists (plus this additional read-only
parameter).

> +
> +	return max_ptes_none >> (HPAGE_PMD_ORDER - order);
> +
> +}
> +
>  void khugepaged_enter_vma(struct vm_area_struct *vma,
>  			  vm_flags_t vm_flags)
>  {
> @@ -546,7 +579,7 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
>  	pte_t *_pte;
>  	int none_or_zero = 0, shared = 0, result = SCAN_FAIL, referenced = 0;
>  	const unsigned long nr_pages = 1UL << order;
> -	int max_ptes_none = khugepaged_max_ptes_none >> (HPAGE_PMD_ORDER - order);
> +	int max_ptes_none = collapse_max_ptes_none(order, !cc->is_khugepaged);
>
>  	for (_pte = pte; _pte < pte + nr_pages;
>  	     _pte++, addr += PAGE_SIZE) {
> --
> 2.51.0
>
