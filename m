Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3DE26E6E5;
	Tue, 28 Oct 2025 18:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761674441; cv=fail; b=EaL9WoDIt6h3geLKzVZt+rKsKw4hK+Nl6CwNXbJLyFgM7i4U6EVrFVeewTPLg/7bSA5LkQ0dH1jfkkSUxCopZZGPekgXMU8VW76xT/tXeN0qEu5+vQV3DuQQwOD+hdIxbfqx1hHmpVbR/By2w+/5hWrfxMKxgw1kkhb8V6bcPCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761674441; c=relaxed/simple;
	bh=KdjA73RPAinFIx8bFXKeyUBCavnveNvu28b/XDs5mqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KVxmmH7725ERdJdMvDhFDEW3PRqh9mE52aB6pcc+EurQRcO0NUDD2Si/9VSj/iINOJQS6M32NkzImo/4nMGWVTtWTBqbplE1BYHoFNBIyw8PYbEKhBbBsQvKQto185MzR3w54b0Wo/7TSRGLieAL5JE46jQqQsk3aeqo+9ZndDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jpDVDryH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qmOJMksV; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jpDVDryH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qmOJMksV"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59SHJIVT024430;
	Tue, 28 Oct 2025 17:59:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=KdjA73RPAinFIx8bFX
	KeyUBCavnveNvu28b/XDs5mqo=; b=jpDVDryHRgV0C1DXJ6hfUMuJ+rhOjnIjQr
	dN6KKbN0TR9ayS91TRsBDS0ZbGljLQXQIwhfICbZKNQlOCxhY8G+LlFFt8xwGbnU
	zhjYyE4xGdCJiUHxqOmmcqMp5jc6UX+/SOKbR2aGwd/ufXFk2AFbq7Xbs9p6qPCx
	VdEHphL5GvlFz2ZUuLj217iUWDGVk9RB+4y6eAIoVpVeeg9LHLli3xFudgUkTkC9
	KIq7bymm5uMYkrvBkds4+dNGu1G8UI0x5FBu3QtKcr++EFjPZpieNFfCE+hg/M2y
	EnkoZb5KDaiKj+5lzsIpE2ZMN0Xdxlx7s7BDQv6DizSkFT+VuZCw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a2357ma19-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Oct 2025 17:59:53 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59SGEsBm015298;
	Tue, 28 Oct 2025 17:59:53 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010000.outbound.protection.outlook.com [52.101.46.0])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a0n08hqfe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Oct 2025 17:59:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tFqK5Q+DzwrB5c2WjvO21UFlzc0wmmqxV4+m3EetZRHlU+FYKG2MIYX3+e2lDw0jGwvi+aMdE0kBPhngHutu10dwA+7Dd2Gy8L0biv8VtZZBlWOHpUJSnMbq3Jz1Ro+G7pxssTk7pwYhACPf2lHD/VkS3iMJZSMRRoaD59yD0Lz8RmT8j4Xi1PGJto1/bpVy/v1w++Vnns9yHUzmobelnV83piAWQq4Ms3rAHqeNsiK748QebaM8uoBzmayBYbS18U5lq/15PCW1TPoeGTec2Du0pHyP+Wo/SJVqmXer1o5lrCBYYJAjLv7G3xH5fmtV4tasW82QzaybbOyPCfwHHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KdjA73RPAinFIx8bFXKeyUBCavnveNvu28b/XDs5mqo=;
 b=RMONvRiDni27R+Grsr35B8S7OV2IJ23uHw12ro/Z2i2Z+JfBpd89vRKATZJqebFB89UudPI488nepKuqpvKLxvWwCZTSO2OxdzqBBfymHCME9KDHlwVM0xc9+yFK4BmIzNxJek9GECbHvhOpNgccswvXMQGR7JJcRHnaPHonNBeDm4HlC7Q4yVre/HW1NQ3aXGfdEizcm2N3t0YCLMDZBypFRLpz/288mpCglFr4/SiLpkP+FK7NTJEUkP3yTWoi1EjLVuFJ1GIf4heUCVG9M/tj+Ng7gDaXRDinK6VA3Rwul5N5IVLnP4uVQn1yT3LOKha1hH7K9CnaKa5+Oj3iXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KdjA73RPAinFIx8bFXKeyUBCavnveNvu28b/XDs5mqo=;
 b=qmOJMksViRAjl6P/L4K6NeNfVaTS3AsETgSEt/mbq5XXOS12xuqJqoOK0ruIl7pNzSBvgV24x1uOpcFMSPUMu+rBF7vYT/QLZvYw1xr9a6jXQ6ygOJQj/mdCfpvqDwWmUtVPJiTDCGlYigEuofOER+ELKzVs7+9qfUoGbDMqm/M=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ0PR10MB4781.namprd10.prod.outlook.com (2603:10b6:a03:2d0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 17:59:49 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9253.018; Tue, 28 Oct 2025
 17:59:49 +0000
Date: Tue, 28 Oct 2025 17:59:47 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Nico Pache <npache@redhat.com>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, ziy@nvidia.com,
        baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
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
Message-ID: <922e3416-c3b2-4335-8caa-7054b07f1315@lucifer.local>
References: <20251022183717.70829-1-npache@redhat.com>
 <20251022183717.70829-7-npache@redhat.com>
 <5f8c69c1-d07b-4957-b671-b37fccf729f1@lucifer.local>
 <CAA1CXcA4AcHrw18JfAoVygRgUZW3EzsN6RPZVrC=OJwSNu_9HA@mail.gmail.com>
 <2983c165-8c13-4bb9-b2f8-bfe8508cce43@lucifer.local>
 <f36ba14b-f2e7-4efb-92c0-a4d4f58b1bfd@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f36ba14b-f2e7-4efb-92c0-a4d4f58b1bfd@redhat.com>
X-ClientProxiedBy: LO4P123CA0024.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:151::11) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ0PR10MB4781:EE_
X-MS-Office365-Filtering-Correlation-Id: c5f2c212-ed3c-498f-cfd8-08de164bc97d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DYCF/UePxJBv5F8f9yB3wjcUBGuSkiBWKba+YQH4+oC1hnzNGmeea6mmKZUG?=
 =?us-ascii?Q?L8Aaya8bw92AyK5xxSUQyNNllJJLR/zGhSW/pAb1mCIAIIXp7SgnGQl7cO5K?=
 =?us-ascii?Q?Z+rEf0r+o7+3UEF93UHg0GgXtnmtcGD7LZrn2ctFzUZmfnpP7phsZmdeWuQH?=
 =?us-ascii?Q?ORVasTrD9E02sXBmu4WCLfTKAatZubs3+3kssNVQSlMsBvQGoZHuJR1Jia17?=
 =?us-ascii?Q?SfGAEfKO7fsXnJ2Gqj9XNd6uCA9tPgSAiFD0LpLXsLQlEoeDSamqJG7QToyS?=
 =?us-ascii?Q?o/kwjdLOV4EE0/6tJUIIvOIkFGRhmSuYFw7ahuf61M2DWxhxHVijqbnYVdrM?=
 =?us-ascii?Q?CI7dR2lYgLayzIRQPx8k1v31N+esmiH3C3WyI/jZgy51SWneixYK3fqq3G0s?=
 =?us-ascii?Q?JdlKvUAbLT6RYZqlLI6EcOXpihDqLgwqyNN56IFcbs7enYbZkhjioUFXk3Ub?=
 =?us-ascii?Q?F2ATfHTnd5mclrF8pvUVFb115wbGqoUPRVdFJwbXVFyf+W85oAZr7PBxyneS?=
 =?us-ascii?Q?KV62ryEguy8LIDdj48gkj24TZW3g1FA0p312eWR2N1RIh1UVLJV8IsdiefEQ?=
 =?us-ascii?Q?HWrXm56mlYQfZp2FNlX/jcUsiiy+JOOG9YEep8omc7NE6tB7B0OIHa7i280Q?=
 =?us-ascii?Q?aomODzaO54zIE+XBkomlhqa8wm89N191Xz4Xa2t6vFDPm04xBHxuI8aQTcjk?=
 =?us-ascii?Q?NAOjJw65VnSNu+QoaGqWBGBHBqXdOpvIsEqD9cEApQfFwFc34Z3Yd0M9LIBw?=
 =?us-ascii?Q?R1s54oz94H5avwB6uSmpK/a39lxHLffRYnUDa3YcNyuPBkMB8bCfKizyK8ej?=
 =?us-ascii?Q?lMvbSJBf4LTlU6ghb1QIpZwJmMTDKZZrLaJQJJJlPoVanGdHz+ONBTCD/1DJ?=
 =?us-ascii?Q?wetMtse0pb9A3m0eWgcqupOaR0fveQxsp8sYYJzocH69J7Z1u7ELkgY1V2A6?=
 =?us-ascii?Q?3dP2qcI3+S3SuG6anJoSDyWOndeI5DL3gJEfm8wFUnzQt+9BoO4fypuB9K/k?=
 =?us-ascii?Q?Qcajcuymt/DzANVIStmP4TEvUqIZFtTL8/QQZ5M15dFk2MQXjiseZ2YlIejy?=
 =?us-ascii?Q?VMRUqmwRMLU+9oOQo2omequlPPbxn5cg3/9k5Fiur4i53oyOWHwto7oqwzvb?=
 =?us-ascii?Q?3ShlSUNaewlr4vAd1fuvoq0KXILjA64yXxMaY1w2lF70I4PLmGMpg9vn6UAb?=
 =?us-ascii?Q?idrI/8VUzTOGFvcKuvn185JxfoL4LkI7+efiHP3Lrs0nBNB5ub9WTW0Mrfmn?=
 =?us-ascii?Q?k84dLI7NT29NG+ipo7YjRWYZ+jOUB7ahfooIA5Sk9gRFBlKo+h0BmjQIaHBy?=
 =?us-ascii?Q?uj1kyaBQxFGBzNfySIsAJbTrJ37lPcsPloK98MgL1q6Q/SKiCw3pjnKn2i1g?=
 =?us-ascii?Q?LWhTjZC2JS/meDl71+HT1QaPWozYUYfNZI78lhilJf5f+4IA4LfJfq4yCOs9?=
 =?us-ascii?Q?jReLJfTicyMXhyURkIHdP0obNCUMqw3b?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3/4TJkyDzZpHnR9NcpRFLQe7yJn7vOOMThnZdVRgDgLgK6hIZx+HvMic+qwN?=
 =?us-ascii?Q?IYLYJeAoflyyszThyRfUBwmWcD39VvczujIlFP+lIoeJjdQiC50KlI1Se5eD?=
 =?us-ascii?Q?fq4Bm64j1sbOgbjGYhv1eHWGs9eby8snItSoKk+MmrYzXkgpLNZdmKU4Z/QZ?=
 =?us-ascii?Q?9468lmZcEwF62LcXrvL03/02GDTGw9EthvLEvjfMiBdKeuXUov8aOmYEvNzI?=
 =?us-ascii?Q?g6LPpgd5pkvDaY1hl3eZ6+XasUCwkOqjg5JTmalZlw64m1HrvygvIGR1o0er?=
 =?us-ascii?Q?ALIBusXZDe27iL3zbtEvYHII3mUeufsdAw+WDy4mDPM8AqnCY6iokijybOUc?=
 =?us-ascii?Q?Df8pe3PutSv0pTJBnQ5MJkXTloJNT/aqEYpLNBjJ3ACHiKS23heJxx/mqc+8?=
 =?us-ascii?Q?yLmwcSX/4LUpBVM1cuo5g5aSH7DGKQg9FZlEUfU4HHhl8eG35lylXQod0lN8?=
 =?us-ascii?Q?pAcpE0bnjbX+gtnkM4Vke+8CXrz+RPDkvGYWG/BEIYVtCUNoJQ8YA0HqGpHL?=
 =?us-ascii?Q?oqnXGE77IU9J+odlqoab2H3wMO1UwPlWHdUr2gflnktvut5FYbdh1ix2lCv+?=
 =?us-ascii?Q?kBxqsMsazQ3I2/ZZUvVZrA/UyIl0VV++znYWDXxm+67xDZULAng0wb0rxB71?=
 =?us-ascii?Q?3vXRb4hnZ2/pBoMt8/w9QM/QmPEFaeNdudPA4Cl/Qf8Q7m6ka/hHr5WifV2Q?=
 =?us-ascii?Q?pEqAa4N/fkIiaTXhdUL5wYG4pT+FVkBCp2Y1kaxTNkuXF2pRkopYST52Ntu1?=
 =?us-ascii?Q?u507E+5kAhN7grDpH9Q/andu0YsZggAC92s9/v+2SBDg6vtbhfCJEk/TvSQV?=
 =?us-ascii?Q?W5N0jXBvNZ+YwrFe3/e3Cx+lZeYLCQnMWWiySWaF5Nw9C9bDn75DDWvs8nDy?=
 =?us-ascii?Q?ZI0dgKslyAQqXtxJiu60937Z+p+P9h+btG7BHduI15PnKqLJQPKOyIgLDZre?=
 =?us-ascii?Q?XyRNXC+/wwtS1u49JUYuTimL3gnlW8Uguv2Cc//Dy50SKCfKwSJTP2SHrSOR?=
 =?us-ascii?Q?hjG8CxOT/FPtFPezOwIbXC0s43+b9ZLwNmGKQ2SghHLn4o4aO4xVg9jPIqOm?=
 =?us-ascii?Q?GPqAzB2OXvX1K/7vDKxBFMIEKD4TCfHBn6L+vOyAmXkQ/kHsh8MN0/rZAGqj?=
 =?us-ascii?Q?V4EReJhvOQ5nPr3r6RMVU3ttSX0In7dntDWeu/tD8ip1xYNePTNWwzDdWsLZ?=
 =?us-ascii?Q?SOJ5h9aaIIDEV71V08WP/yLybFvPw0CTqZUROEAFx7wU6Wgt9mCR2PdpN9Ju?=
 =?us-ascii?Q?DE1yhKf9fG2FqxuRxbBT8G+cJWyJwtPI8zuLx/HRUnPGyHFytq84XgKdYNu2?=
 =?us-ascii?Q?71HrfoQ/WqbX5O6V5i6WBVluD3PYeUbQdNW29RgH5q5c0is/TAVjID0lzmXb?=
 =?us-ascii?Q?maLuGo+QO0yFQhEPlooH8hRnwOw3aIKnELzKheIYkc+Hv+x3VGMe9mk6xp4w?=
 =?us-ascii?Q?4Qvf1Inr38zeHHGl8NSiUVOquQGIWVn6bH71ZnOxZ0v0RvbfJJppirqPjEtQ?=
 =?us-ascii?Q?7TRAdxTbeOSDZbNzVtRoJxlJ6VVwGorA5eQb7VaqxbauZ4mio88nYAjV/QkX?=
 =?us-ascii?Q?qTM0atIg/LGqG/Fyhqe1h8nfLDZZwZzmYVnkmxU9LuEIC2FC0gvyg7AJDqo6?=
 =?us-ascii?Q?Gg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	19AUy6QHcS/V1NCd2rAegZxxHZT9F/CkOi54OQxUhUFgkTg5PDUI5SPFa3dlUwifVdkPfLmILwckD7QrKne5d153nRj7oH4oLbicuSWQTfadPgYUTxze6ZWbVtgiaz3F21+i1drmomvT3A+QoXbCqgVJ0VZImU3myz9Nt3+DRUoZ1nHGPtIl0UB5vPaBD3HbjoexvZPHA7Ft/+Sra+Nd7KLxhKGv5RskauFxtziO+UCz78eMFlDuOE9Ynw3hYpiPKt0a1T189lNh29JF8WgdkEwiMjp+Uwr3VGkyb2UTkS2fZsSSGKmfan1DUOGfZ/VajiGsmZKC5LZWGCsQmaepYX3v+oGyYdWATw4/ICUdDZp8+IGrC0cWn5wyzwjG1g0yFt9rUVp7d9xiWFTVC9Hu0WKmYgAFnu1wYAJNfm+4FEnf4leygVIuRKSYc0Ff9QnvE7HxvTSqjsSeEu7DMhTXgJ2IJbI+73rv9+CIYDE7POOBXL/tG4Cwrx8eizfJi1t3hY8AHlZsFq+J1TrY59CCL4VIewxjvlp20HgfDVTYMaIubKExSjrPWQpxcU5U7T9IZaDW646gTC7TgPg694CxMyuVsBLcHKh2k/G+JYoApjc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5f2c212-ed3c-498f-cfd8-08de164bc97d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 17:59:49.2630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oVjqyatJ2BAK2S5EQp7AXQAkErddlzPmpdxmNZiXHpWFqJllmknuy/OYNsNBP6fFOHdy6PR8ol+S02xgtyumMjXJrgwoe6I6cZXep1FCP+I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4781
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_06,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 adultscore=0 bulkscore=0 phishscore=0 malwarescore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510280152
X-Authority-Analysis: v=2.4 cv=Bt2QAIX5 c=1 sm=1 tr=0 ts=6901049a cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=qCYAEQwNp4a2YlImQQoA:9 a=CjuIK1q_8ugA:10 a=UhEZJTgQB8St2RibIkdl:22
 a=Z5ABNNGmrOfJ6cZ5bIyy:22 a=QOGEsqRv6VhmHaoFNykA:22
X-Proofpoint-GUID: c9vAEszHYwFJj6Vbz8vJdOwKWbwZQR_M
X-Proofpoint-ORIG-GUID: c9vAEszHYwFJj6Vbz8vJdOwKWbwZQR_M
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDA1NCBTYWx0ZWRfX5eXmIrQerIa9
 MMcWOaQj/SHBxgcSKT0hG9QwaWC5m/Sl3LQ3SAO3xJIHm4mS25Y9CtwXK3RhWlMVgtNvIed1PaM
 3xadeIbmHZW4XXw9K7ZZhjZ5GakSt35kar1DGKa4bueUigqCxk9An83DQrvC5xzkLT61uzuCY0t
 gZUbpQcNbUHnvuRE/pSyfKia+yBm0gv/K1NNY6sljZS8SqFzZTYGtNaeZhJdQmb7MNgYIJW9OzF
 V+NM1UcdCXPV7UOZVLmCKO1u0LgDF3w4+q7KQJ53SIDO8++jzVMf9/8xXTJu4kwIrb7u7p/vOhA
 66278Rlp1rYoD6fynX9NKicZVljJxfIJ/wm5F7uqFfZKDvBpfV84g4iMngMMCiOgA0AbWwpiE4L
 0r+eoWuty7UzToDShanin5aQIgfZaQ==

On Tue, Oct 28, 2025 at 06:49:48PM +0100, David Hildenbrand wrote:
> > > Hey Lorenzo,
> > >
> > > > I mean not to beat a dead horse re: v11 commentary, but I thought we were going
> > > > to implement David's idea re: the new 'eagerness' tunable, and again we're now just
> > > > implementing the capping at HPAGE_PMD_NR/2 - 1 thing again?
> > >
> > > I spoke to David and he said to continue forward with this series; the
> > > "eagerness" tunable will take some time, and may require further
> > > considerations/discussion.
> >
> > It would be good to communicate this in the patch, I wasn't aware he had said go
> > ahead with it. Maybe I missed the mail.
>
> Just to clarify: yes, I think we should find a way to move forward with this
> series without an eagerness toggle.

OK, let's please communicate this clearly in future. Maybe I missed the comms on
that.

>
> That doesn't imply that we'll be using the capping as proposed here (I hate
> it, it's just tricky to work around it for now).

OK well this is what I thought, that you hadn't meant that we should go ahead
with the logic completely unaltered from that which was explicitly pushed back
on in v10 I think.

We obviously need to figure out a way forward on this so let's get that
done as quickly as we can.

>
> And ideally, we can do that without any temporary tunables, because I'm sure
> it is a problem we can solve internally long-term.

I went into great detail replying on the relevant thread about this, that's
have that discussion there for sanity's sake.

>
> --
> Cheers
>
> David / dhildenb
>

Thanks, Lorenzo
