Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740241DED57;
	Mon, 26 Jan 2026 11:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769427286; cv=fail; b=G/78P9yZ/3JhWbsiE3jIFcZrJAYRjlCaGNoTZqJjof7l+2intv8PdatBRzv5UBNE7U6wUyJL0Wvyv2XNBa1UHgpo8YP3Guk+wrTspH/az+YsZwLHhr71ZF0Sa6wCpdkghBmIhDt+qR3lACT1r6kOGzPV42supvUor10ESP7ZTF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769427286; c=relaxed/simple;
	bh=jMjBLillU77vZA6sGBsbTiDqg6Notmma0p3xN7AiblU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lfFR19dF4xjeYdoxhSGC8hBPMAyn9uBC/KvR0UPLT8fyui90lmNqFh91uDx1LaMi+vNhFJACOqkIhPcjgrUi3qHf416TSllJ7uLlKP+G+htEVAUAGCVYuKMVjzYyQRLoCJY84myiYpKu3cCmvZt5yCbU9VD8Gy19rYp77f98ksc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ctlRoiQl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nuNs0uRk; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ctlRoiQl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nuNs0uRk"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60PNkVrt414450;
	Mon, 26 Jan 2026 11:32:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=HLefm58L4Fk3tK/A/O
	AYF7q7dwQn9WMq8DqWk7XKHVY=; b=ctlRoiQllVF6xIQim3KJzmSrXRBW7lz4Ri
	o3DiWCJQC9H/kemXpJFkZUZ5VtORrrxbE9vC2EVVu905SwXMlTpufdsqBKBedyWC
	sr/sg9Rocq/y3LjEJPig/IIHVq8lMhsrGYkYrVv6f40LWJ4jy/mMg2h6ackbP9v5
	siat885zfcgwh1O7ZaKAfrNqDj3tdGjcCn8cRG5315WLWiN2toiYF9SULS/gWGuA
	0mcsCbFWcFpse2HX+lEhq6rWnEnGKoG3ScmEq2pjfDd8gVODMDtYSR9jxlAEgJpC
	25cnUHXKsQrl9LE1wShfOKLYrIqFDHe6W1dEfPHlaunFmw6J/0RA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bvmgbsq64-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Jan 2026 11:32:47 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60QB1o4W036072;
	Mon, 26 Jan 2026 11:32:46 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011028.outbound.protection.outlook.com [40.93.194.28])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4bvmhm3pbu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Jan 2026 11:32:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zua08kK6E0jtPBuUNoj5J8r6M+d87tSRnd+gmC38PZYvT0e3DWasGS9mqDq1KxMn4nQOnCZEm21TUmdaSJGWXme2Ln7+QZK4dwYgHC3Jzv06HWT4Nlf+LHHSjEYh7Dy0OJPTijs+XW17LTdSZDgJ0GSAdDV5b2GGOYU5ja4RaeXs9l4ne45eyUujfIZspuTvTIdZLU/87ZXucq/NQEgqb5rVMBZzFHt1v4dM6nvhcH+MCe+jCbhimfQmKDxXXZfwl2k767PRSWwamZ5coVgczIflpl8n5GjV2bkAFx8RkAxoDM+lktm6ewxaJVJhpNUU2s1eK092klG8ifA9g1GTHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HLefm58L4Fk3tK/A/OAYF7q7dwQn9WMq8DqWk7XKHVY=;
 b=XUypxabx7AEVIl0Rb5iX37vU8LsjOhv1rA2NFLuWeRRTFnIXmTYo7FweuKwuL/03zBojuwlnacdBJDOBysLMlaOqCb1pCaml0XjAZwdBnfgJV+sczILV9yP8uofbqOutikt5iT43+9Hl/IbPjzrB9BxO4kBo0YZu5l6iqm0lC7HLz6Cq5RR5pXV3jlQ3n4ZUO/Mv4maHrZL+ar2djbDVmeiiRdXsRRZhC1VkRRwgcmZFBWiSeyw3++5rgeTSo/s/5NaU/Ds5VwRf8o4AQVNWEysOh1RjNCPo4rlwogbiJsq5aQFTvX4yA4Qi5WIThCUbrIxCrY+E72CpwHKndk/HAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HLefm58L4Fk3tK/A/OAYF7q7dwQn9WMq8DqWk7XKHVY=;
 b=nuNs0uRkjDZFPUZp7FwMLN1SFThYzffcHl3FBq/Hmxd3KaYmXVKEWP+uUCDGjq7PJhJWs2noUmEMst5FXwIc3usMckkXfJeBT8lfKp/Gp9lauMu+pGm0ubQixfYNU/OoZywZ0YyrEFnUg60GOfeD9xuw6UsaRX/kN2wv3aijbnw=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by SA6PR10MB8206.namprd10.prod.outlook.com (2603:10b6:806:441::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Mon, 26 Jan
 2026 11:32:39 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%6]) with mapi id 15.20.9520.005; Mon, 26 Jan 2026
 11:32:44 +0000
Date: Mon, 26 Jan 2026 11:32:41 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Nico Pache <npache@redhat.com>
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        akpm@linux-foundation.org, david@kernel.org, ziy@nvidia.com,
        baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
        ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
        lance.yang@linux.dev, vbabka@suse.cz, rppt@kernel.org,
        surenb@google.com, mhocko@suse.com, corbet@lwn.net,
        rostedt@goodmis.org, mhiramat@kernel.org,
        mathieu.desnoyers@efficios.com, matthew.brost@intel.com,
        joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com,
        gourry@gourry.net, ying.huang@linux.alibaba.com, apopple@nvidia.com,
        jannh@google.com, pfalcato@suse.de, jackmanb@google.com,
        hannes@cmpxchg.org, willy@infradead.org, peterx@redhat.com,
        wangkefeng.wang@huawei.com, usamaarif642@gmail.com,
        sunnanyong@huawei.com, vishal.moola@gmail.com,
        thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com,
        kas@kernel.org, aarcange@redhat.com, raquini@redhat.com,
        anshuman.khandual@arm.com, catalin.marinas@arm.com, tiwai@suse.de,
        will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz,
        cl@gentwo.org, jglisse@google.com, zokeefe@google.com,
        rientjes@google.com, rdunlap@infradead.org, hughd@google.com,
        richard.weiyang@gmail.com
Subject: Re: [PATCH mm-unstable v14 00/16] khugepaged: mTHP support
Message-ID: <8067c5c9-491e-453a-be1b-33603744758e@lucifer.local>
References: <20260122192841.128719-1-npache@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122192841.128719-1-npache@redhat.com>
X-ClientProxiedBy: LO2P265CA0422.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a0::26) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|SA6PR10MB8206:EE_
X-MS-Office365-Filtering-Correlation-Id: 3419bc09-a157-4303-eab4-08de5cce9fc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MM9zvUUyrrpdMJub8sLBJM62D8KwmQ/NKyEVjgwTDObzlQ8ubBhcNnPKb3Bl?=
 =?us-ascii?Q?s8/8nHjdD6+MgmAjwK8KfkDH9FdzThyJ5jc8bil4puxW+SW/73A7sFar8+BK?=
 =?us-ascii?Q?FjfnrcuIrhtFCPrkaMtrSw+wnaGVHjmiWwucf9ic7DOLh2rix3lX4z5yjKvC?=
 =?us-ascii?Q?v1HxDIMho361mir66QXpPofH2jE2rhxwiNhYIQT3am9AW7TDf1RFtmAiTn6c?=
 =?us-ascii?Q?nTdArx45dC9soyrnUJlHSLewkNzgS2p1QZKBLMVESvSW01gyDxzV8SC9Lvri?=
 =?us-ascii?Q?0573z3G8YAoFjnRzPZLdfMrgKrtCRrpOszQRZwrKQR4mDxvFV451pt+sMaSB?=
 =?us-ascii?Q?kKoPI9ng+51Ag513oeGe/DorXNO5xT8BcoWdEh1+lxH0WNSxMYuEspxH1p46?=
 =?us-ascii?Q?LGbEmiDxoMGG1Wlxeu1+FEQUHwkFJHdIMtsc8pWroy1FpumFtTcCld4d0b71?=
 =?us-ascii?Q?9oV2rhHCl0ewnarz9afwk6l4n0aLYFg9DV79R72Y9ZPeev3eQPO4B2fIDV3J?=
 =?us-ascii?Q?0DreaAlLN8L07URjZpqABs2hLT9My3pRMYqFUeQ190hlk4S8bTE4x6vh53+z?=
 =?us-ascii?Q?ahAoIENp53Klo5RLNBKOBV3zIt8p6wcE2uJCvLRH/tCwK5DrigKtcFn3oFF2?=
 =?us-ascii?Q?eedzUEUp8v7SkpElK2U/x0nKLUh8UnDIVqlykfWs084jvjxW9j14k5AAVzsf?=
 =?us-ascii?Q?qeA2ePzHBVKc/cwTMfTbRjw53ayE6Z5x7aIFJpum1kfBJTY+gzzdwLwmVG92?=
 =?us-ascii?Q?eJN8QyV3nAqyVjN11Eh6Q9iAsw1QLUQ6yXUjxoxdlkOLnpCd1DqqXLfqv1zt?=
 =?us-ascii?Q?2M5lSCH6PylTcRUVyI5uUpsG4rGGvSZzrVa/FvSag2KSyabIaE9VDuPBQXKW?=
 =?us-ascii?Q?fj0JcwKGqk2RltQig/cluOYIUTJgxQ0AjJFJBoPjd039bKpc6dBmxOhK9OSK?=
 =?us-ascii?Q?4Q60lcJCo9Ea+OPO+rxaf7quZirYamrzQGwbHU/rPoucH/awbmkCJ7ZHmP2c?=
 =?us-ascii?Q?ilesCwQFaFcG7pkM3RSK6WLYn8GhmOXyVYvObn6fjtjMuLvMJTPKB6n+89dK?=
 =?us-ascii?Q?obTlxbu+a4VX/JUZce+nlDQ0DZciOl8PlOvDEMWbA72m7trusghXmGdrmyKx?=
 =?us-ascii?Q?GpEa/sqjR3BZ4qCM2L6tyorQ1nnRxzeFXAZ6c5GleqQR2OZt0xmz1UW7S8Rm?=
 =?us-ascii?Q?uV2u0VeuIu8LUOCI06OuOehSdewDisRWg5qbde3MjboWI8Hu+8M48mPntR1z?=
 =?us-ascii?Q?RPBPxToi1lCcy0tYHDL8Y6AJhoCeTEOJEJCjxX6D06fDF7FqxTTZHgWAsLJj?=
 =?us-ascii?Q?3m6tNchZV71XzwFmg1XkACeAp2FXOH5K0UR/YW8P55izHkg6D0ixdiTsl5kg?=
 =?us-ascii?Q?TWkVRAK+xcXbo4fXju8hg2fAyxHiKei60YS9pQ3HzHZ2Pr37AO9GXUGoBXKt?=
 =?us-ascii?Q?Y5Pzv72W2Xhj+6BEzrxfQTSYjeu6mY+1i/zABgwCmueZMvviadNOpC1NjjjQ?=
 =?us-ascii?Q?22KvqxJM4XBErHfav5ONZHJEmW0UZHehj4Xj69UknqlHvE40x7XdhgpGGLRE?=
 =?us-ascii?Q?4c8MyTeY1ER3f3tdtLA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YXkWh6Cz3xXraNG6f/BMVvCtiPBcWJltb7BWg3+AenfA7fbxF5lO0DAoL6QB?=
 =?us-ascii?Q?FKiCEfeKvj2QMFRqaB+qmonn6Wu8mvNwoeHrLdvGuvBo703xkvhSdBYjHFZc?=
 =?us-ascii?Q?vGX0Q16Ijo0jbY120i67iy+M/onrVI1tJ5OAkljAuvERt4nF8QZDtRO49L22?=
 =?us-ascii?Q?R1CND1Uz23QBDS2wJ87aJvH6DM+qJa0uvb6/BG1BTRShiGYeiN/51tXYnw7d?=
 =?us-ascii?Q?R/YbSkBRK1J0PWAVdCQgcv3Rp/JoQ4JmrR9qmJoAa7U3SkUMT1XU/SFvPoX9?=
 =?us-ascii?Q?REGozJcgx4xq3o/VC6iiZZAykxwZ3aV+l823uqByDgwXOtUyQ+4Ys2+sAvbK?=
 =?us-ascii?Q?KQggJxdPokQcTKlmRFQ6jZq1oL2O/yQY1wI1wx2A+dQKzBJhETeh1TGp5EfB?=
 =?us-ascii?Q?ttkVqu1uhLMpjT4q4lKJvSE/lyGAEgd0af8R0eZdYcbeD8uSTYldhIZzxW3S?=
 =?us-ascii?Q?WP4kQwmWwKVusW8vX4mgBcVLA6V/v+G3PyXVeS90emg6dLFmi5ykCRb1YNgv?=
 =?us-ascii?Q?z2rVv7ozfGsDFmzrLkp93AY4dbCPVshnzKMFyERP8CTxa7V70+S2tybDWwug?=
 =?us-ascii?Q?LCBfqPeikdnAsnd4cqlS58ft/K7Ml2g7H7atv4Mjgep00qAZgEkbkFxAeZd3?=
 =?us-ascii?Q?bcIoUQrU4DpAIJDZu2DLa1idLJPMshbVO51FQjU913/oyJXOKHJ0EUwTR8Vv?=
 =?us-ascii?Q?0m5LYOSIUYE6RfXDaTa6hH3iqsOWe7YNZURpVuq2EJcx0VNJLKAPX75haA4e?=
 =?us-ascii?Q?AD0qjL42ytipacyTiyMFIdxFPvwHNjIBlQadPk+EWV1GVertmtDYi2PbJIsy?=
 =?us-ascii?Q?N/1lvNnTHMiRMBiBs/TPnGC/WNvST5V5kzcCro0CFiqMSGxrJYK5XYDjZZKK?=
 =?us-ascii?Q?BGRrvITkhfZbLeGF3jRPbPQ7T3pXPiEj7bmUvbApi4MSgso69KI+I80yBWWz?=
 =?us-ascii?Q?2Xon4eYEunvEgLWKTZEEGBqqkihuzmXwkYAJYiMMYnFjU+qCn9X5tH4l/Rab?=
 =?us-ascii?Q?FfUnNLtMNykARj3I5j6b4vJwlZQjkL/yCuADY2Q1SZsUZsu1oq91Lmgyu8+i?=
 =?us-ascii?Q?/2S4QD4G/ijCPhmUu8GiwWAaokFBgJdCLvcUchZDu9ruo0s6m02v5aWtMqYB?=
 =?us-ascii?Q?G4Hj7lJzpvvRDlzuXbcmD9hsrv5j2Q2XDir+kDPVDVBtxm1vscon40JzDSET?=
 =?us-ascii?Q?ZS1Trh5aQ23nXNCWu83DobfhDB78xy4S3jOpowXbylarJSdUeL+FcQgf99ul?=
 =?us-ascii?Q?TGCUOfErMcl365a/ZFp/36Zon7IvvQJvmkbLkBdM38ApQfKXicJymTzu6ygl?=
 =?us-ascii?Q?aIukgUbpPWTOgzoDDKY2ennpFm8aczXC4kn0zQueAnjfIZPWqbieMWc1UnjA?=
 =?us-ascii?Q?hLa6uWjPHE/xsdTAbdKEupQhEd8YUHJuVHQPJHyk3Eu8H8TNFvxenOWIX6dC?=
 =?us-ascii?Q?pjKu9C4Aw2DvsS9gvgkbB3+/TTa8PDt8HCia6j7PsRWe+G3eHSx9DbNvQknf?=
 =?us-ascii?Q?cB5+HeRm192auBEGFNfLJO6e97yO0WfziOXRUoB24DkO+uC1cbBeBB+yytUm?=
 =?us-ascii?Q?41oJ89ANOkTaD/Yk6wMh326KMm93qO7rlTsLCLfD2S8k2+IFUyeb8+RV9MqH?=
 =?us-ascii?Q?33/YtuN5dVJL4tmJfRAUVsIKnscui8HudUoPQySmiVJySV8FmkMdue2yQbuS?=
 =?us-ascii?Q?U3zcI+7TO9QyOIZxyM1+gyM7bbf1ADPuUaV9H7hbcJ6/QKQA/HlTS4gM6Nru?=
 =?us-ascii?Q?6WDw/MrpzQH1Xpi2h1UqGNsWATm0q6w=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Uj8tzV4iPg34wiPGxEOl/q6B/BorFBK4AcDOPNYvkXiJ+WqXMeDc6geHORgCq6et7LDugkL0r6TDRRBzQHbnmFgyOkfcXDPDsQaJojjr89ufUblCtxTN8tvz7nazp0IZ4GqoFSMuJdKCgllevSzRI2upj5g3cWejZTHuwRJn0rKfYFD5TBTL0HVQt/4VpwtQz22kr4GsNm7sMCKtQgj8FomtQgCSyIYe9Kq75u6dDQ8xPRzZ5olZWH1PO5fsCffATciv3voNz+D2nDouI24AzL/lOZImKXOpPe6+tMvAjJ0c1mcpP9V3nU7sTJ+buzjIrtQiaxajRyMqoWq3sz3s4oeboAlSRMsAD/xq1ffbl2q7XyAFc4U2P6QVlg49348+wt99b9iQycC3qSkumlPeX6cISHN6Z72LT2gzMegBBzJugql2hSr31Hg7vw0bD/6WBR3kIcTmh/4V6gSV+I3H0Oh9z1ztfH35g9sdw5sjwV85kuqHmMtx2fyYJo7zFP6I4QYdc0rUh38+tS4Bp0c98Auk9KmGvFmtexlAkpFHipexEB716L4D1heu6LSbqm+4r3EXaWBgtdndA5stRI7ACmrrtVWYx0brCVMYrvQ3n3g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3419bc09-a157-4303-eab4-08de5cce9fc5
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 11:32:44.7431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qucwUeOAOaVbibY5/Rvbg7dWBaxb1LpFxuHr5Gpy999abo0KbmhLwiSuBsxKPwIXP7Vd6GJuud+BjPkkL0T3EiN8MWrknMYLgk4g5gdgxic=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR10MB8206
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-26_02,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601260098
X-Proofpoint-ORIG-GUID: E1kDCYO_wPsoiGTrXD29oMTSe7Fyciwg
X-Proofpoint-GUID: E1kDCYO_wPsoiGTrXD29oMTSe7Fyciwg
X-Authority-Analysis: v=2.4 cv=AqfjHe9P c=1 sm=1 tr=0 ts=697750df b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=BQWBZhzyFSMKdwJOL-YA:9 a=CjuIK1q_8ugA:10
 cc=ntf awl=host:12104
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI2MDA5OCBTYWx0ZWRfX7AgXaAm9chTk
 YxibwdSHCoHNlIN2pH7+jKq4Kll+XgW+7VFB42FLPzsnNMs0KcriZALRA2u2QzUcgnLcMCWZkBF
 YGB9Wh2sMNUwKd9lgysglXaH3eWvi1JvmpwzuW/9LfIJ+8onsRrV7j/TPdvGq4SsKOkly6npwHs
 rQnTiBnckvis5AnGS+Ds6rkz26/bqG75wO4OzrHcS7z0mMHQxSRt5qHs7wHoRKE/c6YiPv5kIDz
 CvxN8xk+pvKk9KeSnOlLqVNcCnEtm/9MJo5oUNZUbHMYL/rrGl/ojoCWnTsOi4M7q/pRxkMBXjQ
 ma6l54mCT3BVPmreD3dM8pkljlSLXTHCtPtLxRXIFhn1/96yEuQt9UQl0LhMj/+HlolSASdVtHj
 txB363UFxxwIy5ClgTWMqbOnSZDNMOefQnoQ2QsL2lPZr61i4NZONoedXOhrANCnn/F3sQA/pOg
 xktC5qJHRkVoXx9I3zkAJaJQJR0Lhac4zMlRrJxs=

On Thu, Jan 22, 2026 at 12:28:25PM -0700, Nico Pache wrote:
> V14 Changes:
> - Added review tags
> - refactored is_mthp_order() to is_pmd_order(), utilized it in more places, and
>   moved it to the first commit of the series
> - squashed fixup sent with v13
> - rebased and handled conflicts with new madvise_collapse writeback retry logic [3]
> - handled conflict with khugepaged cleanup series [4]

Hmm no mention of change to 3/16, unless it's folded into one of the above?

Very important to make reviewers aware of this stuff.

It's also worth separating out things at a fine-grained level, really
everything. More detail is good. See [0] for example - I practice what I preach
:)

Thanks, Lorenzo

[0]:https://lore.kernel.org/linux-mm/cover.1769198904.git.lorenzo.stoakes@oracle.com/
