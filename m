Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221A5230BFD;
	Tue, 26 Aug 2025 10:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756205796; cv=fail; b=KWH7sbPi2St99t16Am11zbUwfWf/YsA6Ia82yIbh/lbNvuazXZBOnOeKWxzGddgk0YXWiEOjkPTXycCwK02Tdo2ZSCcXTa40ZgT+dtDoFKetcmKbjyy2TeZd6S5FYEIy+ePEpipBieZNX7Hkx1dqW43peAGwBfNKAl+hP2yTt8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756205796; c=relaxed/simple;
	bh=eOGxpaTf5Z/c1Ymu2sXf5vg78nGwis/rRfmDtw3azCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Z2itnfQRZBjV0cBtz+63jhRzB2DPe+KqqhZLKu1Fi5CHdQL9zm0bzp9J5WKBK+/elsY9Gj6a90y0JMAlz4RWzsnhfcjLSA3tmHngzXIwgDwJ46OWJFPL8LgR9KHdVyn+DbUTRcaRqjKmEYjwKGkxhLIdklm65Y2xPhSbbhjvN34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=pK2k+992; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SH0zorzn; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pK2k+992";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SH0zorzn"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57Q8mDve015213;
	Tue, 26 Aug 2025 10:55:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=eOGxpaTf5Z/c1Ymu2s
	Xf5vg78nGwis/rRfmDtw3azCg=; b=pK2k+992vrLG9ZYnHD6Pd5rGm03Je1CgX9
	1rf2+pPSbZp13fnoL0Vz/iLOgF854sMfRRaOzVUPhNX/U42K8RvauUxr4034yiqv
	p8X6puhwp4G87aI6kjIU3lbjk9bcv4qh4MwWJHg3GxKBP2zpqoO2eFgGf4yQEGb+
	lFDPFfVBNClJIT/ZudPHNwKluQ9J9Nvtdq1BoUonLqVHjrbkoaum5qqp1TWZ6He+
	5ndU0eL7pMzawf8qlNMR2I3ZFVfz9NIhlNy8Fxxr8Wkxl2Xo9BAgM1UmmGiOO9B7
	BwsYQtD/qx1EvTm4WTI4KP9Ig3oUvxby2wLnXyLSNf/JvewEypzQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q4e2487x-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Aug 2025 10:55:47 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57Q98uDc012211;
	Tue, 26 Aug 2025 10:44:01 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48q439bysk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Aug 2025 10:44:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pr8m7hXNhIMheDNsKmJ27BqzT3QpwOlsBZB4R1r4cn1B+eOSzomCo0GOcMfz9Qly0qanlyDf9ip/wrIp/nGdI/AwJtCLaSZZZ9L1FyS7StjWO4vaLFTkRu8lNF4bbqy31NooU3iAb8JRdSnPSlqLq7/grEycGXUdSVbU7ldtUGhdTB4tB+xfNcqOoyVlBgRO3xrnr3lVgy9GEjRzMLFvCzzIrwzNZrcA8EhvnNv9gQsdCj47+K+qhTpXyGkrxvr7rYoOJXX3GOd4MZ+Y4mUk4TNETYAGtMq5bCYifIUI3JAKNG81kRjPKsSe3PykGeeCGuEzzLAIBkd6U66mz/TItg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eOGxpaTf5Z/c1Ymu2sXf5vg78nGwis/rRfmDtw3azCg=;
 b=WmZ3l95rAoqU0lj7K4L3U1rJh+YOZ1Q3HkHgauOKEryooaLeDc0Djr0dFbnbJhwKhYl9XdmLtmIpZZiBKgD8W1GgKdp/ntK04XdalENLbQWuXjKZK2gq854KOSzWuUY5Rggs9L03xeZKGpYGTkpXamTcFm14am7cDzdwzwLUC9FLcaPFs4KU2mFyTSx0j6jP2xfvky83blxTCQ2PsgsK5tXZX7E/9Hk8InLlb4jyoJekT7HDPGuP91LdRTprUJftjwXSj8PkKOzJd/HtwlEODgpexI/yUj6JunmCdeaEhaII/1Tx4x6cI7QVzG12WQg4XQbS+BsGFDNutj+ce1kxdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eOGxpaTf5Z/c1Ymu2sXf5vg78nGwis/rRfmDtw3azCg=;
 b=SH0zorznjxdCKA3srskHc2xpLVQFppeEtPuO7t344dWX1vRKP4LiWaAgEtCY71mh9hBp41KCYFWwAFoB6PPrN6m2/53Y0tx37QRMUA0KXPSrnHWWFjQlzMKsdN2T9eu4F/5EgFY7mEmNvYZATJRmvJ/WD0sAbYhR2M8PRFJJeBs=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ0PR10MB5552.namprd10.prod.outlook.com (2603:10b6:a03:3da::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Tue, 26 Aug
 2025 10:43:57 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 10:43:57 +0000
Date: Tue, 26 Aug 2025 11:43:50 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Dev Jain <dev.jain@arm.com>
Cc: David Hildenbrand <david@redhat.com>, Nico Pache <npache@redhat.com>,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        ziy@nvidia.com, baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
        ryan.roberts@arm.com, corbet@lwn.net, rostedt@goodmis.org,
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
Subject: Re: [PATCH v10 00/13] khugepaged: mTHP support
Message-ID: <9e1b4602-2b4c-4cfb-9f06-1799d3c0d387@lucifer.local>
References: <CAA1CXcCqhFoGBvFK-ox2sJw7QHaFt+-Lw09BDYsAGKg4qc8nSw@mail.gmail.com>
 <CAA1CXcAXTL811VJxqyL18CUw8FNek6ibPr6pKJ_7rfGn-ZU-1A@mail.gmail.com>
 <5bea5efa-2efc-4c01-8aa1-a8711482153c@lucifer.local>
 <CAA1CXcBDq9PucQdfQRh1iqJLPB6Jn6mNy28v_AuHWb9kz1gpqQ@mail.gmail.com>
 <d110a84a-a827-48b4-91c5-67cec3e92874@lucifer.local>
 <95012dfc-d82d-4ae2-b4cd-1e8dcf15e44b@redhat.com>
 <bdbb5168-7657-4f11-a42d-b75cce7e0bca@lucifer.local>
 <e34e1ffe-c377-4c9a-b28b-ca873f3620ac@redhat.com>
 <a1942809-ad8b-4a8d-85c0-74ffa2fbb53d@lucifer.local>
 <f36ea21e-285e-458d-b3a1-e729825b6d89@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f36ea21e-285e-458d-b3a1-e729825b6d89@arm.com>
X-ClientProxiedBy: MM0P280CA0044.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::12) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ0PR10MB5552:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d271bde-6c0a-4ac3-4adf-08dde48d7602
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XTe2s3CGKr9lgH2ppcNNZ95QujakhAWf7vCXgpmKNrjRJPFdE2ZcWfzD+KZW?=
 =?us-ascii?Q?oXwHAsOvgtiRpLwwum12DFhjltT/B/ktNKyEtDrnmUTJFZ6RuGMmpgVTceRl?=
 =?us-ascii?Q?/ZdQHpylmbL5ITh8m/wZjG4qRHObuJzv4gtNLN4YTg6GIlX22M4Yo6jRUCrs?=
 =?us-ascii?Q?8h8GzhCJ/noC1MkonQxJrZWuS3Cs14vDSmE2r9y0dL351+CWc6hPKO5nhimL?=
 =?us-ascii?Q?329LuovrigRqstDAU4hyh0zfQPWuoMBbf1AZQV59QNRHukxU056/j/cKL93D?=
 =?us-ascii?Q?aXxvA7MR9c7lZD0F3lMfemWYf0WMH9JTZ3jZtAPuB7NrfBA/dlzoqZ1fbCuK?=
 =?us-ascii?Q?n9RvvHutS9/2J8ZIPQFxpB09080ZAfiEsJix9APwF6WwmIEpAd7yEP52gZlr?=
 =?us-ascii?Q?QnyEfTAErMOEGHVQiPebSy70xsW9G5B4zRslrRdN8xXwBe0VMFHjJyEQW/hc?=
 =?us-ascii?Q?cLim8E7z+3JvqVxpYMajM03qPvGG94oFm7WQS7i/aa5tWWuvJjf19UlZYusO?=
 =?us-ascii?Q?qCupuGSVyoK17MlsJnTfNwWcHvqhNBwb7khDItZ2gWuGwgKBPNdl7wRte6hz?=
 =?us-ascii?Q?pmn5jqRXhWVlcNH3IotmgEBURRi0JJoajhyvq6VU7R87crltyXoto4CjeATH?=
 =?us-ascii?Q?19zh8SS0+2yPtRLPwIbNHrSDqxKLMGnOim3zkRVCDbjTySVDWJFRkCTQGpCp?=
 =?us-ascii?Q?/ixqHQnGRnAgrWqK1WfRW5LSgXK7YAravyGJMZvZRq0iMgG+MyNVBOqsVpQ/?=
 =?us-ascii?Q?lKosMHLlLVOmzAzYmoyrr3xDM4if0C3zmQpBNwP6aoR+mB0/H05f87Bo/e8d?=
 =?us-ascii?Q?/sgCIpXqPE+tFoG/oprPdYYLkWeQt/kyioIz1R7qQYMYD681vWH7owLWFehF?=
 =?us-ascii?Q?Wegx1imyIh3pXawA42lbHnt5LJJhzsqdq/GKfPTBcRbl+x/avgDdGqwok9tQ?=
 =?us-ascii?Q?dO+OYbCCTzLB6X8k4q2arjv321SsAMDW/dOBLDYmoMnllEja5N8zXVIze8RQ?=
 =?us-ascii?Q?hGLj8aSQ9jAaw2Om487HAMMecx0zu9G5Wa32348R3D+cdGyBZ2DipRwyfkN0?=
 =?us-ascii?Q?LiOCEkNtxOkW5Nn3xS8hA0jKPZOlLKszHk8ysSP9Fjdg0ycqR3wL/xMbk2lU?=
 =?us-ascii?Q?J4NHr8HkI4SWOSRL2bZYlGdp2zvrN0HWToyVcEtGhSRwj/gFvPLrAtwmp3Tr?=
 =?us-ascii?Q?racOBsS0BbDx4jU8ZIikOzDiJuHxDhyeDYK/DHy+fCrADuM7z5oA9RFJy0BZ?=
 =?us-ascii?Q?bDpn0USMpuvWpyTJ/BfGgRAQoZg/ChTb7ncn93kEhDwJoFFRAPpqeBi2Wuvw?=
 =?us-ascii?Q?OWbEkAz8djZqG2Ft3vPosd/g8M25lz5zheUg4JqUxyuRyKuOsatRRG7pA4rs?=
 =?us-ascii?Q?4snBceGEmIVWiPckl8EYR4mgmLAiyRPS6+d68x7QYy/eQMrf1kQj7YuMx31B?=
 =?us-ascii?Q?tBFKMBTzKWk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+vlLccmE9VQZYQgFTb0FJG4GEIQo7f6tpPdDuMx48Aa+BcX4t3qycqFHy3i4?=
 =?us-ascii?Q?yd6l8A4I3tDhKjrIjebam5Up2sha0opgZaa/TI26t01ImqUoP/m/Sw/VYlIs?=
 =?us-ascii?Q?CgWKfPudTrGmUUEKbGysoGZZbxZVwMW/3JeAAR8Qac4EVHHH6PG0UF7rRxiw?=
 =?us-ascii?Q?0t4lLOs7ft1dcJKtOV8ZpRPaW7RHY+FlmfTwy4+ZvyliDCxZi7zkU1SEkl4y?=
 =?us-ascii?Q?sZYOkQ0zuferGuyz3y2rDC4RReTDQyeRNHEat7seVQ6irqFupwrc5CnvFdhW?=
 =?us-ascii?Q?GsT5qca6sXw5tlQBCM/U8zlQz4lILBoUS8FnVkPiqHubEzrKa9PFhl2PXMuU?=
 =?us-ascii?Q?NceMzKJqUJsKz5gk4Qxx2d/+5kNspRMaZqGel1QXssPcXe46drxadm72+lSB?=
 =?us-ascii?Q?hu0Jh+mPQqBR+S0qK/Uc+3zKBa09EAZb8CUnxbKfh7xxeIPIo8Mwlyq2OYPK?=
 =?us-ascii?Q?TBYuiRBy+aVURKWAt+WBJ3PcHyM4JPDMh+FtJZpkeIBxI0uy49aCVG8XdeAG?=
 =?us-ascii?Q?GHzFj9Q8jzIWkQvAFUNloFXauzDG6OTaXFGilOYwtLLtxgMtoiZL8xHOd5Li?=
 =?us-ascii?Q?JtOLch3TiwdSUj8kWnMiLYx3fGUrDByrqgMz/fdlqPS+GuODwB6Q6ueNU8Mf?=
 =?us-ascii?Q?y+S69MrErl5BruW99+oJUCdkvgjgCxSACHJhWMFAPjHA0qtS5BV+JJKlncPI?=
 =?us-ascii?Q?U80eoyQAYN9aNB7C/pmtSoDmndjsEc9AJGRYXTlLQR2+KXPDfV3WfPDfyDNS?=
 =?us-ascii?Q?URLVuh9mjAHIGbYrMIxYiwexthud4TvR+9pY1FbkaQB5InQmCknAvQEeAkYQ?=
 =?us-ascii?Q?dkmuBxKbFNS7wdorjXPJdbrWhGGLhfWC/JYwV7ZN7LE1cdtzZ/YajjXFzu0w?=
 =?us-ascii?Q?pJcw5VbrI+OGLVRdNS/A8IOxh29d0Nj+UoUGRVwX2Ddl5oIoKCqfNnlI2SSO?=
 =?us-ascii?Q?aBDDcJPNOZTBffwjTKXRRje9A/R77dBGwrwWL7WOwMZCbnMKmlvfm6S8Gfj5?=
 =?us-ascii?Q?uTzaONlALkiyuTiI7nTxqR206CZ+5tCCWiv7nJ8yQPSQrtpIFbUjf4EIP1Qn?=
 =?us-ascii?Q?VEvWZ/pgX6VvyRRXzt0ZZoRWUcSOhZ/X1bRw1/19iEvCcfs8Ty8ZWk25+bL/?=
 =?us-ascii?Q?yavC08rZnraKtJRduYhbTl21sIlimmoidu2IuiuQj7GOxrStv4qZUZzFVInn?=
 =?us-ascii?Q?c3LJQAjhpKEtFdOf2AXDIUFE4NG8c9aiMdIdoz7jEwONs/mOsEtj3kfLsvia?=
 =?us-ascii?Q?DkBQpd6vAICWSeFRRyQtM165zFoHHaWmaTnFmLCTs9tVR4U6rthg/TT3gvry?=
 =?us-ascii?Q?y3kNo1mIKwWcJp3lF9zW38JHiPmBZNPJ/oj7pyrSAritprVrJHlL78le6m6H?=
 =?us-ascii?Q?AYY0lv7cR9pawYYwUTowXaR4ryXSTfLE6N3Wxluzl0uVBOGsqrAH7tmdM+C0?=
 =?us-ascii?Q?FDZIVEUzT51IyeE7JoT/gorNCgBdOQ8jyf6PsVXURagBMRv55vEwLfpmLQ/R?=
 =?us-ascii?Q?VJYPA32hTjLfc3ha3Wz3F+IL9t6CWzYDbQYQhcBfGb82zMDhIAS1RGZ2cUfz?=
 =?us-ascii?Q?B8szdthmtDxtdm2PrhiwQHeLeq5d6wOD2AigbPPs24Yrl70VvGzHSJHEqAJA?=
 =?us-ascii?Q?Tw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Kt8730JdInMhWFXWhksVZvzvDjIAsqW7K7yQzuXARtYAzr8O6Hc/h7SXL3nDrF1Ge/ZAdsSEaNugIzVsmtFOCKZahCVaBgohBne8nDXr/NhPl8NPj5FsJ/8wiJGRp05qxGDkmjUpvEmtfhOBI75mX+oSxAAFQm9ysrDFVcXG0nEZlz05iJgh/CneBxZa9MZ0ShfXAD8cIayZqdrJblWgn4nTy9O47Ut+Zg2L6elRHAcCqi/6gJ/nMbofMdn+16R2l+HsxUjYVl1ZdTEzyfj3vZRmRGcz4JZfc1pnCs1TlBVYqSpy01ZiBJn/mQknvWugNd3KzfnnqR9pykCl5LK3g5Zbsac081PCmc0aTM8YwkKgzuD20TvA9aIrNHQmHBqmTSPCODrQR012/pw8WoER5fIAPkchl9LgxEFrv9XGhZiTPzqWLEV3g9yaEYedLTBoGGGJj9HwFOwlyF4faXbQeebErEmCPK4fuLdcz9phYmRVe1NOTpFVv7Oa40yF4QARnIOsqRLVn0ObaoP9+x4p4eNQwK6ZgkVeHmiqYxczgcVGHH/xShnEs8TDi1eyum+0L1vB07Ef8U/ehewCLMfr9WD0DvR47X+WyxKMu4n7p8U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d271bde-6c0a-4ac3-4adf-08dde48d7602
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 10:43:57.8620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KFWAf/q+Za4r7z1v/7FdVxi3NM6chhuFWq9GQ3mlNGwYzBrzlWUUdMB2A19pFEFJcVcGDbka3DGL176G+TvIcBbq1N8wXypUmkIFlSKZf8c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5552
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2508260094
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAxNyBTYWx0ZWRfXwzWWEJUq4Xu0
 zyZDj7c9wClmuSb61hmF6Ngk2sSYlLsLBtAVcTX93SaX8WIHZpHqCKJwFdJROIvyF6wiDOP2am8
 i1Y1VoK33tTppSRh11leB4sWLKoZT1hvtEIRZ9/tyNGvLz3kq7vp75yw2Q5Kklck3uDd+3nGFRR
 tk+s+4AwpmQ/YanCxHjfPSueXVGE6c4m4bUO1DvQjOFjOP6YgJmnQv8L9WLVP2fYL3UXVuOkd8B
 wa1u7RdpLuJzvhWPXwgokAViYRcVY8n/QwhIhreWKyAJS91YzvGA5dzIycA1Ig+/U8DWPl6vYqF
 3Hu21Gry+kCqAgI+Eh4AylzrbU3o5ZpZ1fK0prqxX2V7pILIPrJbJEwhiex9MoVwN46bm2DBmvC
 1JVS6yx9tFseRRZjJiLO1hvdD1EplQ==
X-Proofpoint-ORIG-GUID: 0knbL-Tgrl42BQOln0hbeVcp6AELJUCC
X-Proofpoint-GUID: 0knbL-Tgrl42BQOln0hbeVcp6AELJUCC
X-Authority-Analysis: v=2.4 cv=IauHWXqa c=1 sm=1 tr=0 ts=68ad92b3 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8
 a=v0vS9it5Wdf_9oVyQxMA:9 a=CjuIK1q_8ugA:10 a=a-qgeE7W1pNrGK8U0ZQC:22 cc=ntf
 awl=host:12070

On Fri, Aug 22, 2025 at 09:03:41PM +0530, Dev Jain wrote:
>
> On 22/08/25 8:19 pm, Lorenzo Stoakes wrote:
> > On Fri, Aug 22, 2025 at 04:10:35PM +0200, David Hildenbrand wrote:
> > > > > Once could also easily support the value 255 (HPAGE_PMD_NR / 2- 1), but not sure
> > > > > if we have to add that for now.
> > > > Yeah not so sure about this, this is a 'just have to know' too, and yes you
> > > > might add it to the docs, but people are going to be mightily confused, esp if
> > > > it's a calculated value.
> > > >
> > > > I don't see any other way around having a separate tunable if we don't just have
> > > > something VERY simple like on/off.
> > > Yeah, not advocating that we add support for other values than 0/511,
> > > really.
> > Yeah I'm fine with 0/511.
> >
> > > > Also the mentioned issue sounds like something that needs to be fixed elsewhere
> > > > honestly in the algorithm used to figure out mTHP ranges (I may be wrong - and
> > > > happy to stand corrected if this is somehow inherent, but reallly feels that
> > > > way).
> > > I think the creep is unavoidable for certain values.
> > >
> > > If you have the first two pages of a PMD area populated, and you allow for
> > > at least half of the #PTEs to be non/zero, you'd collapse first a
> > > order-2 folio, then and order-3 ... until you reached PMD order.
> > Feels like we should be looking at this in reverse? What's the largest, then
> > next largest, then etc.?
> >
> > Surely this is the sensible way of doing it?
>
> What David means to say is, for example, suppose all orders are enabled,
> and we fail to collapse for order-9, then order-8, then order-7, and so on,
> *only* because the distribution of ptes did not obey the scaled max_ptes_none.
> Let order-4 collapse succeed.

Ah so it is the overhead of this that's the problem?

All roads lead to David's suggestion imo.


> > By having 0/511 we can really simplify the 'scaling' logic too which would be
> > fantastic! :)
>
> FWIW here was my implementation of this thing, for ease of everyone:
> https://lore.kernel.org/all/20250211111326.14295-17-dev.jain@arm.com/

That's fine, but I really think we should just replace all this stuff with a
boolean, and change the interface to max_ptes to set boolean if 511, or clear if
0.

Cheers, Lorenzo
