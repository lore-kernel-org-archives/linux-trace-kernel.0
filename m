Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6246E2BEC22;
	Wed, 20 Aug 2025 11:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755688955; cv=fail; b=udl0YCsMApBGV47Vt5DFoT7QMBbJ/mcF4ig9L0r6G1YJ0vqRgUTR0u0DqbcCMAO8UfVLZfUgy1Braa5cDsN4IAPbfH/Egwf/eA1rfvPdBR+7KatwkB50nJwVKXsYvvy21qPKjoIStnSZW6RILfxX7MuOsAZffQcm4i5gbApTZOg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755688955; c=relaxed/simple;
	bh=dKqwDqIIWgNqYn27UPqD3ak+LP23yspn53L31FlSSz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nQs3bHGECvLI2Pdlg5f9tqzKZ5HgLhOeKLuCr9Ly44XQAYPYmuEcXPS7L0VkW6rWsKZOA6orj1cshcHjlK2MPDtVjop2lPBJzQUYOcpAm7Jm0zcl4OvRtYngOBUdQu6TjmYX5qt/ZWcdkz7GJoGBZlkufWjLr48JKB93lEr4Ax4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=T7zcOB8M; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Os/z152P; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="T7zcOB8M";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Os/z152P"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57K9lp6j010929;
	Wed, 20 Aug 2025 11:21:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=E6lBLUAB3Vb2Pv3TCp
	eofLJv9GMVIAEgGqxlYtYIKr0=; b=T7zcOB8M1R6T+lYYru9DyRiFK30CsTd27O
	Iyc14/Qe/U/N7AOsyM7CtvYqDBPm/UjE2bCHQmGrlrb231by6FzeOWCq1sLba9Oy
	S2MrlXZgLkwvqj7nU5GmBRq/2UAqnxvcp8MAzYXMsuStyvlNgM8ZPgoZOIrQZWR4
	69+17Q6D51jKubaADAOA72q81IqmgMJoZIDKZTJjkuxUthRnqTNR0hw4C8lnMLV3
	KeB+QvRH5RoivWIsfVYK+obu6GOj8BkCYZqYacsOSFoOH9UJPMjYiEFD2iZGPOWT
	pW+4MYGF646uvjoiEF5n7nT1r35L20pW+uDmX6b7eUWRhXdHQ8rQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48n0trs1w3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Aug 2025 11:21:50 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57K9sFXX026974;
	Wed, 20 Aug 2025 11:21:50 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48n3sw37ra-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Aug 2025 11:21:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V4xrjowLZydrtFCW4Y4/WF913h7ENd/D7TwPA/I2+y6F6Bc54z0EEb3LMW9PBsOtqg+PNWst/JAdgl7ZgEcMY9+KXOov4aSvAiqv6kF34bJA09ETBNmeDbCM/VlY0cKqMVjw5p58tsOk4JRM6iBbFE2mwJTX2Vm39lJCTmCjSt5o5RICyR8KmtBBMx6F/mUYlrvuLx6ds9SbR7UMiCnGNx96LH2ODzg6+2L2hcSQbMnmfabPC/zkYbyZeotVaVvk0IchLs56yLpw/04GfWGLPC7nx8Lnpq0XcHqcLUhCmVsvrPUQfS4nk0EgnaczLExc2e7Qcjo+YK0ovDCOef9dAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E6lBLUAB3Vb2Pv3TCpeofLJv9GMVIAEgGqxlYtYIKr0=;
 b=IbqrwVLuAjna1rw01yqyYw7rFzTosSJcCLPzconV9ydpJRg8+aerOyGfx1xw/DBot4AR7yp0Bl1HPwwNp328UdAaI4w/N7F6vHpXhclc7FLqeOE1Swd/fAgyffhZEjx0Vw9hTFoC+jsg06qgGu11oTg46w1azT9y3YfNcAqMObLxqmcUolgZVhaLPnd+Ta+qj+0me/LtGZ69RCdGCdg9xrMF62eGTmkmPBgwTPQZ29HV53dUf+fNNfAhbiqR9UUxu6k3Fif0Qom+++7VZlVm4OJIa0Aw14hC1f86UoWxPIYl6vYtjh6b9m6AM7my6JHJvSoETxqqHso+RfgcTrvQcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E6lBLUAB3Vb2Pv3TCpeofLJv9GMVIAEgGqxlYtYIKr0=;
 b=Os/z152PRZQUUCmLz+uFxiCtPuK/CMXi+N36er2AiGxoFJxhi7acfIGnUH+zCeUiO0/+8TNLkqTHMFzoKmq7lGWQdXN5DGrwvDcJtgVFpfxF01wv/qfuW/KByqp6Hp9jlztnZvdBb6UIyY2UIy4XEU/TKmPbGthZT8TpTHNmXww=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by MN2PR10MB4334.namprd10.prod.outlook.com (2603:10b6:208:1d9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Wed, 20 Aug
 2025 11:21:46 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9031.024; Wed, 20 Aug 2025
 11:21:46 +0000
Date: Wed, 20 Aug 2025 12:21:43 +0100
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
Subject: Re: [PATCH v10 02/13] introduce collapse_single_pmd to unify
 khugepaged and madvise_collapse
Message-ID: <248d57e5-8cd5-408b-a6c8-970df6876b6c@lucifer.local>
References: <20250819134205.622806-1-npache@redhat.com>
 <20250819134205.622806-3-npache@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819134205.622806-3-npache@redhat.com>
X-ClientProxiedBy: LO4P265CA0041.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ac::17) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|MN2PR10MB4334:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a0703d1-5907-4263-3993-08dddfdbbf95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dlsnLmqbhvO2k89DavlioWckv2SZpXZqCZSZFa5crrepZuWTp4KttfU2xLmd?=
 =?us-ascii?Q?815Aw0Ba6D8YqIesMsrprHKs96Vo9QqAn8IgNPoAWDe62gD66B8HO+vAbABf?=
 =?us-ascii?Q?HBRcuK1vSMcaL55Tw9bArDWP1lUx7mjHwNmhQZM28uDiX2kvKFcStD8oAO6f?=
 =?us-ascii?Q?IHmqPPuW4I/AvhaIQkaiawdkx00rQUn8LyvIa1SPOrOZM6Equ/VdAAS+jqrC?=
 =?us-ascii?Q?9dnBBzNpU+c1mvNHQ/SnbKMdJedPVpoEu+LFYJ8WZkg/Ijrf28yKZiOoRuMw?=
 =?us-ascii?Q?RT9q8Io97qw5HioxXk2FDSYvh509PNUc+zhvxY297PcGBBIym1uHYHN3QoYM?=
 =?us-ascii?Q?pHq1i2wkvNgoG1nmAuyK7dsQTuK8iFnpQsovBXHZtHQ9Mab9C4RmCCGe2CCo?=
 =?us-ascii?Q?W4VlSsQWjoDQNwMcnfEvW+879uiQX8TZe/xzp0HhzEVpsF+a9cQ0DCcz+YKc?=
 =?us-ascii?Q?9lefGtargfCUsSrkz8ppvuk6iXUfY2prCPvSA5YPtLVw09RtHpDxWaPHuRo2?=
 =?us-ascii?Q?rDPNTODnbKomJyx/fQfjYOOIM8OFPP/vzeAfkdEi7QQFj7Utf26DX6X8Z/P8?=
 =?us-ascii?Q?rHPmEL11nDKRvqaYsRQk6tvZIvhALULcg/+8gSDnbc/osczdne6jvKJwuDsm?=
 =?us-ascii?Q?D5y9FiaS+ViVpvg8NOskluLELa8eXRLGcL8hU7zCSdJhwxuiPJKbcyPJdAFp?=
 =?us-ascii?Q?NXkS/8MBkYY0PwBzIugTV8ZvBQ5Mq4igobbmYV1MTYBjH35b76kpJY1euBQ2?=
 =?us-ascii?Q?QMZqdXZDyIR8Z3hzwZ4VmhUy5rNZUOYovWU5bUv87yFdCy650g7bTFwJen3U?=
 =?us-ascii?Q?BWXhIOJKIjBKJPxa/Ek8Osobaa3/Xp8eOnJUgBqXSlMdP4PguMI4accvwG6w?=
 =?us-ascii?Q?EFXDz3r62zR6de70Uxrc8+3m5Ngn3IpZy/baP5XPYW862uKSm5pzDqSvoW3T?=
 =?us-ascii?Q?qDFw/n3zv5yYN12YD1fZJADyECeQyjZbmxawIMUWxhznaniyvuYFPrqDqUn+?=
 =?us-ascii?Q?CBGUZV20ir1kPSPXPnNICXt5YOyqSqiFyUe5/BSS0Wrg90TjQinC1A1DyEgv?=
 =?us-ascii?Q?aUIfd65Kbhvkr1d93HhyVK3PzZttEGeUjJN99DgGy1Yy+y9rWKACpyfSRxen?=
 =?us-ascii?Q?fpfBUqW7AFMJJj4oNgEbBi+qdhiH+do8XmFhsN2ZpzhnEFvH1/l+lNch+Kke?=
 =?us-ascii?Q?IHJyRE2sNhvnLfL6yiGdI2xrVDoI9KTNdfolDxqsJZ0XfnM4VPd06CFmxR8q?=
 =?us-ascii?Q?JqiIH+JSx/9LZUCVNbkhVwi9O0I9IISPD9T9Gyq0lnHrmaGsakKaN+T1c9S6?=
 =?us-ascii?Q?XZ/VbXNiZl1gDVTxBjGF5mkclbecHpGPDCpaJh5u6uXwgaIfuHZaD+bzd1l9?=
 =?us-ascii?Q?ZKnbML+/dqKrweWGd5pmdwmnWlSwCIAKWqVJbBUqPjRsz6dX8PGIun9y3o3W?=
 =?us-ascii?Q?mhp7kOjnW8A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?J7S2zl1j0R4Fcqvktu4jW9NppXOcFxkFjUQa2aPi4Z0wuT9SVOHI60Ubm+ef?=
 =?us-ascii?Q?5Sq1oRola3LbGx5hJrvgjn3Ehcibqi2LLcVD5RYA/pYtOITlY3dJ5RVEVg/p?=
 =?us-ascii?Q?wWv98nrZfqA3u0aHF8uSq84/HzMT4aD8i584k8n5u3weUL4XmdA0SzYx6+zM?=
 =?us-ascii?Q?nkglXNL1ppIhxlcmkXqNiN0ThfvsjazC+2/djiU9+qxjNMXU0Yaw2LxeouEO?=
 =?us-ascii?Q?1NIc0GIWjNIabHcftVr2i6jH4nkoN1kN2C11hbXv2qwpUQgccucTmC8JZRxC?=
 =?us-ascii?Q?06P/bwI1HLtXJxf8GW7iJgHozLl+bCMYiFiCRS8asjfpvQxhpTi3howRNKzb?=
 =?us-ascii?Q?Mr6HQlTuxCv2VzwsOOJ673m/zyfZBP0w9S6LiqdgPdx+dPeiIVA8fwu1y6we?=
 =?us-ascii?Q?rcltBmlhlI+onZOa4F3xFWkn+P1pbh1y6H3B3mQYZw2fgD6gvPS3gcFv94n+?=
 =?us-ascii?Q?mQz2Ewzm7DlNMfpU7ORPs/xBS1eTDfZnMae+lh6RFNMGMdku1KkD6J3Q2//2?=
 =?us-ascii?Q?3affMKhRyTaLtxjcnBUYAUnsBg2GKzdY7pkDEIrlKwALDzriTXPxze0hW8h8?=
 =?us-ascii?Q?DpXafMPP1FQt7o0WFYmSHMMz4H14BmQ6kBAVuj3Ns9JhnShCakR5qdCwqpb/?=
 =?us-ascii?Q?Ux5MraF06B63VOQQHgv/Ns/memwJAnd2SUJ5Lt/6GKf45N4swXyE5znWD6XH?=
 =?us-ascii?Q?ytkExtX5fRoxIVT8cybYEk7UftZxHEvRSiJR+fi+H4Kn+k0kYLri7+BWC2pp?=
 =?us-ascii?Q?vP2WKR6yACghMYVCq71DZET48koO3P2Vh/0D/MZfYdOTUZjwnlyLtlRAWJBh?=
 =?us-ascii?Q?Zy9U7jX/4f7v/0SdPuYDnNGeh6sOmSadkq3pHxMM+5gLt2AQCrm78JZ8TXIZ?=
 =?us-ascii?Q?yJaO8uJh9j6vw32UgcG4CwB40CiKmkUouxlY1Quj69qj5kthNskitGm7JA5i?=
 =?us-ascii?Q?h0a61P0xQtAudClOe8u0t6jehOjewegGDcFyJZt0Jzl/TIUm+rrTlVE8ECHm?=
 =?us-ascii?Q?Om2WFft7K/l3IA1lK+HutpdzVnAMRcxsdezpS6zNMS+Mk2IfnyoYuPObqOD4?=
 =?us-ascii?Q?St7Gntf4jRlaei6j1jamX78tURLOAll4QHoGtvmQQmtpYPzMjrtgk657vzDE?=
 =?us-ascii?Q?xqEsP/TnI74ePsQvkNHK4oyvwTE3d0hIVrgGHkwkgQrXvhcTwBqHiRgQ6EMc?=
 =?us-ascii?Q?tJ4IZ9nIVlJlNoRIkOPtNeiSyr7+ZCAmsNOHovqqxQmiRkiiY6RRK6d+jaXa?=
 =?us-ascii?Q?yOuvRF8hOXaXPDkCKEU2KlLTuB/YNqU1mwhyBJCsiZecvkXYZwnTNgzfyfR9?=
 =?us-ascii?Q?w2tP8UFLTmgKQZHvGQwzgCxwrRp+IAG3kXClJiXYm/uU9ItiNVNHiJq32fKH?=
 =?us-ascii?Q?bTbP2z+c+Su1/YL/bZ2tIPgnYPLyY7BN536+JiCXp4tHLvWb0GEuz1Z8C7ds?=
 =?us-ascii?Q?gB2P9XMV2g/1RTKy6teEJUP3YapUwjHUVbhq5GW66gfzrLw6immV9Z++w1uQ?=
 =?us-ascii?Q?YaNierFd0x+6zJ8Bxzh3QT0EeEs55o1ryWmyd5wmUseOYuLC5ABNbvd34aA2?=
 =?us-ascii?Q?lg5Rt8FN52Guo0C86lhtIRvG2BneoPxpGCJ7rLWBNs8iOfwl0NzJx66tXGbE?=
 =?us-ascii?Q?7g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0SCa2tGP6f7ZvdakwyMKC8KxjPUTnC6IgjZP2aa7LwrinRdaiS3sNzhck4QipNRsV+mRgKjUim/0wlxAz9CIH3KSCot2M1G3JQ4JYVrDJyxcbIqtXFNeNhE3mhaXxnads/EPJpFSrsRyPHEOgyZ6RxsNi6rrXIRdR/D8TH+8n+p9B6B8qB1ETatcH6p0Enr9onEMo2NVsd+9gwafR0Ef/S/gQ8/l67PmIQOTStvg7Ohj5Q6ijgu9LPQFmJL2kg0CbIaxfUYXb7b11Ar/w+j8IuPuRPbJf/tP751Gs7bJZHtVcH7Esp4LbSbyBbVIIinDosejCFo0QRxmyRCREbN9HsRwcF6CdOkfgv0sAnfwjoFB/T1soR9b7YIjlJzAR6MdnjotQ4g9G9/SF6jGJia9RBv0ovHld3UonZGz+qduzHRdKV0JNBegg5s9BXb06Q7DfCpXYVunB6akEC5KJOTrmUcfmPXY3DVJ1S3Bc5PLDiPPAjDFQ/gCMN3AGaQHL3FBwV7bMbh264Y14V3VYIcoFud/TzZCZiLuu1UI7x80wvltSg9eVU3TBTTKvpFi7OIQLy9gA6qETpJJ4iDgQv8khjF/dSH8i+gyBZLtWYTHxx4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a0703d1-5907-4263-3993-08dddfdbbf95
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 11:21:46.3393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IWHqyPAGNcPUzkkL1g1dl0Hy2OghIZ39w6S2sRjcSb1O9hIHAGrp9B9Ot28PiYUuo0plwMss9iXvybmLegbvjL0XBLSJHtaIztF4na72FxY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4334
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_03,2025-08-20_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 suspectscore=0
 spamscore=0 phishscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2508200099
X-Proofpoint-ORIG-GUID: hUPcZifVkwUBGNBek7vA4PsHRE0ILYnp
X-Proofpoint-GUID: hUPcZifVkwUBGNBek7vA4PsHRE0ILYnp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDE5NyBTYWx0ZWRfX9+SttvlVlr4a
 Lg9XLyT8Tzxjjs2/UkZ2zb3e9Iv8M/3W+xE1ApYWjSwiV0P8wVYfUXQzTdmlbDux/Z63mXY7g4f
 xdsQhcpC2YpLuiKEKuKfiqAwOzqbK97k0ZT7WUKIkgaimlR3KLNpt90jlUVpH+aY10qOB/Q22xe
 cnHfPbmzxEOI0ZngIVwNmRefBa6r9uGb8dszX2SBMqSIKiU6g1jefcWcvXPxTa2per94WYCQbow
 f1slebeHlhIAUrbcq8LUIwztQHoi7HgjMTdsqWnYROZQkyzxwCkqprck40z7GCBZkE1EA+j1A5q
 waATX2rGcd3pHU8/rtwQOk6lxolSwIgggKw9hT4PulXvLYBs6KEROYdZIZiA8FZq+xnrczq+xA1
 sbhcRuM/+N6uizbh42PE+vawnrq5dA==
X-Authority-Analysis: v=2.4 cv=Qp4HHVyd c=1 sm=1 tr=0 ts=68a5afce cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=SRrdq9N9AAAA:8 a=20KFwNOVAAAA:8
 a=7XSPgeH9EW_D8ys74VcA:9 a=CjuIK1q_8ugA:10 a=UhEZJTgQB8St2RibIkdl:22
 a=Z5ABNNGmrOfJ6cZ5bIyy:22 a=QOGEsqRv6VhmHaoFNykA:22

On Tue, Aug 19, 2025 at 07:41:54AM -0600, Nico Pache wrote:
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
> Acked-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Nico Pache <npache@redhat.com>
> ---
>  mm/khugepaged.c | 94 ++++++++++++++++++++++++++-----------------------
>  1 file changed, 49 insertions(+), 45 deletions(-)
>
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 0e7bbadf03ee..b7b98aebb670 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -2382,6 +2382,50 @@ static int collapse_scan_file(struct mm_struct *mm, unsigned long addr,
>  	return result;
>  }
>
> +/*
> + * Try to collapse a single PMD starting at a PMD aligned addr, and return
> + * the results.
> + */
> +static int collapse_single_pmd(unsigned long addr,
> +				struct vm_area_struct *vma, bool *mmap_locked,
> +				struct collapse_control *cc)
> +{
> +	int result = SCAN_FAIL;

You assign result in all branches, so this can be uninitialised.

> +	struct mm_struct *mm = vma->vm_mm;
> +
> +	if (!vma_is_anonymous(vma)) {
> +		struct file *file = get_file(vma->vm_file);
> +		pgoff_t pgoff = linear_page_index(vma, addr);
> +
> +		mmap_read_unlock(mm);
> +		*mmap_locked = false;
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

Don't love that in e.g. collapse_scan_mm_slot() we are using the mmap lock being
disabled as in effect an error code.

Is SCAN_ANY_PROCESS correct here? Because in collapse_scan_mm_slot() you'd
previously:

	if (*result == SCAN_PTE_MAPPED_HUGEPAGE) {
		mmap_read_lock(mm);
		if (collapse_test_exit_or_disable(mm))
			goto breakouterloop;
		...
	}

But now you're setting result = SCAN_ANY_PROCESS rather than
SCAN_PTE_MAPPED_HUGEPAGE in this instance?

You don't mention that you're changing this, or at least explicitly enough,
the commit message should state that you're changing this and explain why
it's ok.

This whole file is horrid, and it's kinda an aside, but I really wish we
had some comment going through each of the scan_result cases and explaining
what each one meant.

Also I think:

	return SCAN_ANY_PROCESS;

Is better than:

	result = SCAN_ANY_PROCESS;
	goto end;
	...
end:
	return result;

> +			}
> +			result = collapse_pte_mapped_thp(mm, addr,
> +							 !cc->is_khugepaged);

Hm another change here, in the original code in collapse_scan_mm_slot()
this is:

	*result = collapse_pte_mapped_thp(mm,
		khugepaged_scan.address, false);

Presumably collapse_scan_mm_slot() is only ever invoked with
cc->is_khugepaged?

Maybe worth adding a VM_WARN_ON_ONCE(!cc->is_khugepaged) at the top of
collapse_scan_mm_slot() to assert this (and other places where your change
assumes this to be the case).


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

Similarly, presumably because collapse_scan_mm_slot() only ever invoked
khugepaged case this didn't have the cc->is_khugepaged check?

> +end:
> +	return result;
> +}

There's a LOT of nesting going on here, I think we can simplify this a
lot. If we make the change I noted above re: returning SCAN_ANY_PROCESS< we
can move the end label up a bit and avoid a ton of nesting, e.g.:

static int collapse_single_pmd(unsigned long addr,
				struct vm_area_struct *vma, bool *mmap_locked,
				struct collapse_control *cc)
{
	struct mm_struct *mm = vma->vm_mm;
	struct file *file;
	pgoff_t pgoff;
	int result;

	if (vma_is_anonymous(vma)) {
		result = collapse_scan_pmd(mm, vma, addr, mmap_locked, cc);
		goto end:
	}

	file = get_file(vma->vm_file);
	pgoff = linear_page_index(vma, addr);

	mmap_read_unlock(mm);
	*mmap_locked = false;
	result = collapse_scan_file(mm, addr, file, pgoff, cc);
	fput(file);
	if (result != SCAN_PTE_MAPPED_HUGEPAGE)
		goto end;

	mmap_read_lock(mm);
	*mmap_locked = true;
	if (collapse_test_exit_or_disable(mm)) {
		mmap_read_unlock(mm);
		*mmap_locked = false;
		return SCAN_ANY_PROCESS;
	}
	result = collapse_pte_mapped_thp(mm, addr, !cc->is_khugepaged);
	if (result == SCAN_PMD_MAPPED)
		result = SCAN_SUCCEED;
	mmap_read_unlock(mm);
	*mmap_locked = false;

end:
	if (cc->is_khugepaged && result == SCAN_SUCCEED)
		++khugepaged_pages_collapsed;

	return result;
}

(untested, thrown together so do double check!)

> +
>  static unsigned int collapse_scan_mm_slot(unsigned int pages, int *result,
>  					    struct collapse_control *cc)
>  	__releases(&khugepaged_mm_lock)
> @@ -2455,34 +2499,9 @@ static unsigned int collapse_scan_mm_slot(unsigned int pages, int *result,
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
> -				*result = collapse_scan_file(mm,
> -					khugepaged_scan.address, file, pgoff, cc);
> -				fput(file);
> -				if (*result == SCAN_PTE_MAPPED_HUGEPAGE) {
> -					mmap_read_lock(mm);
> -					if (collapse_test_exit_or_disable(mm))
> -						goto breakouterloop;
> -					*result = collapse_pte_mapped_thp(mm,
> -						khugepaged_scan.address, false);
> -					if (*result == SCAN_PMD_MAPPED)
> -						*result = SCAN_SUCCEED;
> -					mmap_read_unlock(mm);
> -				}
> -			} else {
> -				*result = collapse_scan_pmd(mm, vma,
> -					khugepaged_scan.address, &mmap_locked, cc);
> -			}
> -
> -			if (*result == SCAN_SUCCEED)
> -				++khugepaged_pages_collapsed;
>
> +			*result = collapse_single_pmd(khugepaged_scan.address,
> +							vma, &mmap_locked, cc);
>  			/* move to next address */
>  			khugepaged_scan.address += HPAGE_PMD_SIZE;
>  			progress += HPAGE_PMD_NR;
> @@ -2799,34 +2818,19 @@ int madvise_collapse(struct vm_area_struct *vma, unsigned long start,
>  		mmap_assert_locked(mm);
>  		memset(cc->node_load, 0, sizeof(cc->node_load));
>  		nodes_clear(cc->alloc_nmask);
> -		if (!vma_is_anonymous(vma)) {
> -			struct file *file = get_file(vma->vm_file);
> -			pgoff_t pgoff = linear_page_index(vma, addr);
>
> -			mmap_read_unlock(mm);
> -			mmap_locked = false;
> -			result = collapse_scan_file(mm, addr, file, pgoff, cc);
> -			fput(file);
> -		} else {
> -			result = collapse_scan_pmd(mm, vma, addr,
> -						   &mmap_locked, cc);
> -		}
> +		result = collapse_single_pmd(addr, vma, &mmap_locked, cc);
> +

Ack the fact you noted the behaviour change re:
collapse_test_exit_or_disable() that seems fine.

>  		if (!mmap_locked)
>  			*lock_dropped = true;
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

One thing that differs with new code her is we filter SCAN_PMD_MAPPED to
SCAN_SUCCEED.

I was about to say 'but ++thps - is this correct' but now I realise this
was looping back on itself with a goto to do just that... ugh ye gads.

Anwyay that's fine because it doesn't change anything.

Re: switch statement in general, again would be good to always have each
scan possibility in switch statements, but perhaps given so many not
practical :)

(that way the compiler warns on missing a newly added enum val)

>  		/* Whitelisted set of results where continuing OK */
> +		case SCAN_PTE_MAPPED_HUGEPAGE:
>  		case SCAN_PMD_NULL:
>  		case SCAN_PTE_NON_PRESENT:
>  		case SCAN_PTE_UFFD_WP:
> --
> 2.50.1
>
