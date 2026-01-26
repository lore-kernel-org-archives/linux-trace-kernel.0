Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC2533290D;
	Mon, 26 Jan 2026 11:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769426577; cv=fail; b=uORyDkjjrivi49AmTad84BRX8RPdbbgCHsOGPetUkpCm/Kw4TIBIRBfPntxCaOCRe6FOnJiRj3Xr0pMDC2AhHuwLVrWhxFe9Mn5zYyhAi3PG++8oPgMzz+b0qe6kKrGjDDqNFANxCZkjxkAWH4T0Fd07SQBhXCIZqBfessM6u0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769426577; c=relaxed/simple;
	bh=KX562cgbUWzcY0rQzVVZfQ6uTbNoCGWHYwLLSceO7sI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XQASF2yIEU+oitTSh2yL4Ey0RAkrw19a0rMGWpgS1o0/3HRiAmfo+yAVJajnR44EPzT3a0PBk6lrBa4ujdhbLHGEBwfV+CRJxjDMg02hxY0Ra4p+6ZEhWFhkCklpV50rHluA1aXQR92+aWFz7UeAc4wqiSECJ8eMCd1H5DcjK6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jd5c7DXU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=O5LIkG36; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jd5c7DXU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="O5LIkG36"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60Q23qS0247091;
	Mon, 26 Jan 2026 11:21:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=KX562cgbUWzcY0rQzV
	VZfQ6uTbNoCGWHYwLLSceO7sI=; b=jd5c7DXUeF/lET8c6JpPTz1Dyiby4jTAmt
	A51bmFzXVQT8u95uyXvZ/nZ2Q+SoF8IcdIMyiWxhqfXq5raNkq5U+UA527lLVunt
	+xiO+LShYzLiLw+vYlH7ZwWMBIgK5E8dZtm4yTE4NLe091eOH7snWxo2iB68Qoey
	ICIdIXAj8IJTED4CxtPEE7/Px7wL5JVeiDiQaPHv6qSuwbH3DaKJNRHdUl04PWuJ
	wS41F9vESWdPeVqY9iK59IEB1GSbub2bvBVv/Qs59jRGZbIbv/WecXJs4o1BV8f1
	mn5H7lHT6p15AzADAa27z+Go5FqSYkfkFxu85n+IVf8TpzqJrKrg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bvn09hqgp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Jan 2026 11:21:50 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60QA1CQW012554;
	Mon, 26 Jan 2026 11:21:50 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013020.outbound.protection.outlook.com [40.93.201.20])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4bvmh7ukt8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Jan 2026 11:21:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TcmFA4Eaa8/1GMHrm/PI8dXx6JHriSF6aTUWTqXY6Li2o+a7Oo2gjD7nlmOw6f8Qs0SpFSOjxjlSvwE33WcHbI6v8vc1W7nM1hgCDrnqnsnZiDPuUrjaueJXAKI0ImF5Apo2GytT8UgYYQYbfVonkbGnKi2PhpKQLfAYIjeJCNXFZSN7MiNmYTFyYx0s5uKjDWI5pjeiBxglC241aD650EbycbrjFBwnyE2DtUHabSlczt7Ud3vNyBC7E8dNCotEp67HQUoCrAnWsq6TkBS7RhAqdoAgtDKWfQKOCAB4/hbFdS6F1ignnhsxwNeRcBiVRqKzfEjGaMLAXQPudFuQTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KX562cgbUWzcY0rQzVVZfQ6uTbNoCGWHYwLLSceO7sI=;
 b=nfyN9Yw+0wIVMYpjy+G+YQk47sltnZ9hghNeulY5VYqhPr8e8xehQ9QbXkMarYU2+JCC6Q/yGVibt1sIUudUVQkXsp/lljAWm2I1INCbdSaSbHtXv1UK8trl73ihPOuFxwgp7ZPm0pNV8Lf3URlS6yV6y8jyDYjr0msB2oJCSa/IWclDfj6NnUBMtip5xVTgnbw9ZkAaZhzQUAVlJXpAm3rcKzM5Ss9lT0e5gnjR/uPmNcDsSOxZ7FD6bzknLxvmpIXJt5C99bOyDqTfR3g/iu/UPy5y8LR//E5Xw6mj/oVGeeZWIdcufU/Ee8t4pBdYjD27zqsgeJIvtArzINhp1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KX562cgbUWzcY0rQzVVZfQ6uTbNoCGWHYwLLSceO7sI=;
 b=O5LIkG36/+ivOwOhgncgBaOpKIxDs5kvHymkI1IVCZG5V5EsUaGdSfYc3u5uLVd/PAa1X3s6UbknmdGFcrIL5ot42WBWp2fdrCVNRyEVjPemwmtBdH1C2Ddu3xH5UY+4nTxAw7wn8JD///vw3Q139lAjbfogfabcvkCnEzwFA1I=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Mon, 26 Jan
 2026 11:21:44 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%6]) with mapi id 15.20.9520.005; Mon, 26 Jan 2026
 11:21:47 +0000
Date: Mon, 26 Jan 2026 11:21:43 +0000
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
Message-ID: <e1766db5-14f7-4907-82e1-a887ab134463@lucifer.local>
References: <20260122192841.128719-1-npache@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122192841.128719-1-npache@redhat.com>
X-ClientProxiedBy: LO2P265CA0298.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a5::22) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|CH2PR10MB4150:EE_
X-MS-Office365-Filtering-Correlation-Id: 92c5c815-a652-4f02-a103-08de5ccd1781
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fl/TFjrrztmPofg7x3zQ9D5Y/G6LlPF/ZbjYBDEU2elbPncFDiTrKukUoZ8/?=
 =?us-ascii?Q?bYJSfnWhcyZJxE6BdIL6G6RCWLhnCb5Q5rcEZ1qQCXAr+pq1WKXVk9k7Yv6R?=
 =?us-ascii?Q?ffLupn+RInBEp2hBEZAGgGPQdDJXgngvXI0EFtzOXkKtp534FWOrEzkd3hPL?=
 =?us-ascii?Q?CxOTYiNTVMWgIKhyoTBUxpaY0lzAOaObBPzxTllTsrRmftWH0jUcQtbM/RWj?=
 =?us-ascii?Q?KeSwQKysiTvytuCYIpUSGKTchpYY8M6akRjcLvom2xAYsgETUR2lEsED+2ET?=
 =?us-ascii?Q?81MTzcSLot2as4zBNe7OnD2YNj6W8yK0afgT7kggDSwt+xgYgaU8n5PaS+O4?=
 =?us-ascii?Q?NbXLo4N25NFnbPDMAm1Evpmknel4XOsyaM5/R7/191rVi0Iacne/zox3RAAg?=
 =?us-ascii?Q?fdmTluh6d/h2oPd2WNLPkcMW38dQJeG9ut+x+31TnmPLv9tZdZ1j0lPYM9rm?=
 =?us-ascii?Q?oFE2rCeUluvA6ctUynSadNs4V6YtIuq4hdjr5Zo9iESxA+1gNQZhI5x3HDsF?=
 =?us-ascii?Q?FihgFYh6g45zpdqf87mf26yxC3HnKOX3ZWBslzo8TmUGv1KeVzxvOKPOI3mP?=
 =?us-ascii?Q?tgAzKOn7fSovYgtylhnrehbpXCZ2aM77L/UVLZSJHXpbf1rmVPwAwmjJBK/o?=
 =?us-ascii?Q?CKlvk5FI5uL+t1A0A3qVfu3SfpIabGDkRW8NpQY8E3q9wWSIpqRqwrVK3G0g?=
 =?us-ascii?Q?vYFiJFLx+i1k2xBEN+3xoEU6kf7/KFnxXcjV5vstINBsI73WseX7u3QAKJ82?=
 =?us-ascii?Q?9QE4jiNwUYw09oBaRYqy1TV8Fxz9exTjo2L1F87ZRWS6EpfXz+3J/TG74wH6?=
 =?us-ascii?Q?kLBvc3YD7ADaqhqbcKl8e2xOQMtiMdddbhxEAP3DN4gL9WUmYNqHLIdOfQrg?=
 =?us-ascii?Q?23D24/MetA+VVwgcT2NeVZfgt95BVFbJUsRv2TVCshhRWh1OJAq0NVRJAADs?=
 =?us-ascii?Q?7GdxIppKo0VY/iqHS3oRC034RlDVODJyi/VD9E5PPUCqYx5vPkLvXl0AmcbV?=
 =?us-ascii?Q?ZTrzJhPQdkKcVXj5ivJFE21wYtvowf0m43P8ntItU6Qr/JQCOL67b703UenO?=
 =?us-ascii?Q?zYuyNHIB/D9m06SyQ+iTgn2J0s7HK8hjn5LfUYPmKs2IwWYZsLTGgf/XHLMl?=
 =?us-ascii?Q?9ij0pqpdJ0aDqAssXQyB5hsIn38GFJ18AcU2ki/qgIbGUfbw5KaUiINwkQe/?=
 =?us-ascii?Q?SwMnmoO+OrSLYeYFU4tRYldu0QGMr3lm70W+icj9b21TpfHEfbEQrspNdb7Y?=
 =?us-ascii?Q?LbrNq2egDZo4FM7IOxcdVI364JZyDC+Eivukgc53Azar7bkUUeRN5OPM4zXp?=
 =?us-ascii?Q?YtI/3dDPM4h4mE3+T2fM8gn67Y4WI0z7FDVzv08J3aZkyxiSFNW8E12nVFZq?=
 =?us-ascii?Q?ZbSL9n54DjYuUnsx4Oj0JO5Ivb+6oDHVCaZbyfKW4TnIj0uUnnoSqWmNIZc7?=
 =?us-ascii?Q?4HQ5ditpGp2q+yJpNlLcZpVCQaX9PpBSBBPr3Wc0i/Ca6IZpW+H2p39t5/aM?=
 =?us-ascii?Q?LKaWXTvz+MecFHoudkgLXxcOJmvbCeNMYouyNC//5xUVtnVxQo+TJ3SK86Kf?=
 =?us-ascii?Q?CVg319BiFc/I3TQKvLg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FmwsolFykSyNOKuOX5QtHXUgBG1Zsv2NuHY8F0wdCmpGpcqqHkryiRVhna6V?=
 =?us-ascii?Q?0YqJTR98rfBnkLtDa1/XXvtjaEN9CdxvciXGuQoDsMzMjid3aJrJ4WJodiun?=
 =?us-ascii?Q?Am+mH3lc6LfeEJw5FWZAlc/FJBRHi7rUx2+GBsd2LccNzGVqrKm88iNO6odA?=
 =?us-ascii?Q?sclPDZr8TD060Hh43rlp8DM5Ehnu6e70bqfmBHmQ01R5NgBqrcppCco2BHf9?=
 =?us-ascii?Q?aqpHX6Tv0uCe0ixzoLXeLwQdBrVqQCVHXl9svJEq2JcQ6OYWP52Z+bpAolGG?=
 =?us-ascii?Q?OkgDJxc+mNdG0LMmhuBfMvTt1SevAv/uwU2EMsPQPaHeCtDqEB9fkqNCp3ha?=
 =?us-ascii?Q?xHXGDeHnVUiqwO6VyXPRLTeRnAwz/wAhIwgMprhTJSz9gCpkNkmfjqpNUGzh?=
 =?us-ascii?Q?Sgmwt9hygddYBH4FYZgRAKhs2un4ASVbZ4emUxs9nuclJ4WtFI5dctIDZl//?=
 =?us-ascii?Q?lOd7ZxILIeuGSalDsEPpB8cLR4oSMoh/CcIU/UaveL5JXCLjeJFtCx4evvDV?=
 =?us-ascii?Q?lq5G/bl0byxH8lEuQZXzamY2MhUbTTb22tKuxQIdl9nRkHNWRow8skD96h4y?=
 =?us-ascii?Q?4uB1yQkwjk9XXHNEnh0jrci5vIiFgE66pJ3LmY+/QKvozUTpIlvsut6LArAJ?=
 =?us-ascii?Q?a7l7pErlwoOziahdGn8B200meaRTzgSCXi/kPnER9jcMFYN04e28eAIGiSY0?=
 =?us-ascii?Q?piaT0K0bk7WSRemtWPXAGqA1zP206vzMS9OeQCf8n748p7k57qlmon/HdgmG?=
 =?us-ascii?Q?lJdZesUC2dhtGcxYMxcdhxD3nqeeLbVemXUwmbo4nEVzwiW9ZG/2L7QvRCqY?=
 =?us-ascii?Q?7qVEVv+R3G7KMTAlNYaZsrfMu3jsrI4O6TDEneWUFYk1I2/V/ZHbdbD2Fnlr?=
 =?us-ascii?Q?0D0pSylKSZbZ8ENyHnKq/Yc0nGheMWvthf3cb4K1YsYn8iVAjn3J1SdrgFKh?=
 =?us-ascii?Q?Si92ItsQg1wfQde2g9vv6WR6hxERddYruqujAabsPSPh71K8LRlBkSRLQoI0?=
 =?us-ascii?Q?MLDZHI7XHDm9BF9iW+c+hWU4Nv2qgfU4MC35HZJk8jWZoXPtHMBUR0F94wiU?=
 =?us-ascii?Q?rRqEiuSskE+odZF2OEJFLIvK+LA9RIOmUwJiRvGnNYdX8dbzrE5/TfplQZLf?=
 =?us-ascii?Q?6ZcMR+LqMgb8kHCvcX+1DcS2EG2rT5K12tRpUL4MQdugKEsA9N7Pp0EHDIZz?=
 =?us-ascii?Q?t1QcZyGBzXHZ396ZBpwhLGn7S8t1tz5wQMsBs8Pt/mx1PEOqW8XWW/ytGKkn?=
 =?us-ascii?Q?a3byWzTaZwMq2ot5TGXKhqs4NqxL5FfxGYpHsNCSjIz6lOzJSyuHDcI0/b8V?=
 =?us-ascii?Q?0CRFbhsXogQKAwZK4qhka65TWRbkHtS0dPxHsuEJ7mkkhCm8iHcUVpEESzfH?=
 =?us-ascii?Q?faJ5/k8IuPAdb4rO7nkAhrBxKgl93HPCkcI6l108/VWFbYG36qOvLy+LWEpX?=
 =?us-ascii?Q?tlDK7283kjbJJ0iFPkQRpujojLVK5ZA/HLd1BDYrZb5yKHkzD2HkPudFCnkw?=
 =?us-ascii?Q?z+g5Bu2bvwHfK17C+LsWZCJ9JHups7548joG/p87PZGPLTdOkc9DEhozf0/q?=
 =?us-ascii?Q?7tImRF6QYFhjugCixW5OXVicRGQ1PB5Ld5sF8De0nwE1hrB3wZo+ut4kKpb5?=
 =?us-ascii?Q?xiq54Bt+4DZCbsWZc/yWNb2uacG66pSOdBqrCqK5lfyduMbwKSVu5QD34dif?=
 =?us-ascii?Q?MnrOCV25keyo3JTpy6w2hjg9CPB9Ay5dNpWAUPktwM0ZmtaDhp3R0Kh1h/Ao?=
 =?us-ascii?Q?JEylaSMJhEWSPCDh9HC3Vt6QIPAZ5Iw=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/JWomUWsxvaCjOFUY7NmoOQ18bTH5YAzr+76xXH70DDaw9xANqqePJ5NcIjt/icSSHQVi8eexF+Nzy0HnvzutLUWYDqe+rp+fVU7WBR7m+vGyI+1OsHX4zU00KYD2r7JwQtCDc3hgVbh2Us2lFOUk2K6cZhzhFtgBqx+OlzWpl5ROxx/Wkk4Gw9deiOMAqhFAeDOMVmlzNOQEr5Tb7ILhHZkHa0Kgo7tpOsIGGjwy7kFKo91UUip4+sJcOKhJAAM1YaEHTHv2PfbdQ4bc7sIrrAmPQjAJm0q2yGNQsBVtKLHCeT8CbhFgv1FtKAlEpKIJiez7BmeuCnF7ZfAdVSVBvP5mv21CQJq0hyLQ2k7yr9HjaA49DUOrKxsTZzGB52AYWOnELJuab3+5YdvpqXVlrPrUGYROBYXKiRLvC+um26ya+Cv0R857sUhibifz0n7kZPDdyRm4mT5dCvpW7XziyA5Etvv7ik24G9MIJv6ut1vsINymOpaf6pkCYEccBYeanhyI+MgS40vRCks+5TbYyzXZgn2GMRDSp24pCyZ/POU3+tizDibFT3BQ3aQ2VJVKCyWj45psAjByYQv4ejGq6nD9IVFilXjeXEJqKtnvBQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92c5c815-a652-4f02-a103-08de5ccd1781
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 11:21:47.6392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vTwbYRJLCLpvGV33h+gG/HAZTXmdsVRLedCpPV/RkyvlrsW1ODf8cLgjhE/GlAVZjUWTZ14lPkhnf3hXGXv45DpiWFkRII5e1McN/RuK2ws=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4150
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-26_02,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=951
 bulkscore=0 mlxscore=0 spamscore=0 phishscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2601260096
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI2MDA5NyBTYWx0ZWRfX8epn2pgX/d8s
 NL0lgARDaVERlBbu9HVXueK9+pCgS5VeYQamXekSZroVYuTmDTUXdPY1XXQ2DMoiACfJ91jCmdj
 vl0wJ0S48p2oq28RjIjYSPROUgVhyxbB0rU/kzY0R5DkjmeeWOq2mi+yhxSnOhYqEMcBiYCdq07
 IES6sMSYYj9neCO4JrdUc+9JE40VQpBMpFMDg+QVL5PyjBQAvQ/VPTNrO6JYcBn9AM2N/xbGepW
 vTgQSBpmkNqB1wLnDsGvvkqQdrpf2OJJzn3WBXWhDDCElemh5CqmM6A7heYggM7vnlPcyEAEL3q
 VwwtvOpnGMwafv7MV1uvtH1u6AQjPDSSUkIXDbKGTIGIa8E8SLkDYGQxzupfziqRFFrl64UWti8
 FHEkITC66YbP7tV5UoLz9K189JGFO86Ku3LLZiGbdssvy9gItSWddC+uLfHCoHEv/6hf+dYK8CP
 QeSUx/oBZ4//ZHLREbw==
X-Proofpoint-ORIG-GUID: L3N4T3EUCD12hhUY73a2TDGmX1yeMUSr
X-Authority-Analysis: v=2.4 cv=Rp7I7SmK c=1 sm=1 tr=0 ts=69774e4e cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7R3lrGI7S7rcZwMTRgUA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: L3N4T3EUCD12hhUY73a2TDGmX1yeMUSr

One small point on this - I don't necessarily blame you for wrapping up some
other stuff in review with the rebase, BUT - it makes difficult for reviewers
when it comes to picking up changes between v13 and v14.

You're going to have issues anyway given the flurry of THP patches we get every
cycle, but part of the review process often is to use git range-diff to check
what _actually_ change between revisions.

And in this case, I had to resolve a whole bunch of merge conflicts just to get
v13 to a point where it _kind of_ represents what was there before on a common
base.

Obviously I'm not asking you to constantly rebase series :P but I'd say in
future it might be useful to separate out the rebase step from the respin, when
asked for a resend to just do a resend, THEN if the time is right for a respin,
to do that separately.

Really more applicable to larger series like this and it's all a bit fuzzy, but
in this case it definitely would have helped!

Thanks, Lorenzo
