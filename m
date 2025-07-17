Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444A02F949A;
	Thu, 17 Jul 2025 15:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752767699; cv=fail; b=I3J7gv6WgtLhKy9s5OzUkXecjJyRv1m3nP/XW2M8+etcw9C5lgJ3b9thXCiz8JLVK6Us4MQvUUexyPojHpbWT8KNq8vsXB8Uze09dMHSeyqNSuEw2dFt2a3RBk5N6ZdVZ+8dASNz+i3EnkCtdUqHBdQGQNCHWVLPtwp+IxPvNMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752767699; c=relaxed/simple;
	bh=BYKI1OopGLyrJ9L87lhuxx6KYJOcCFCA1HEILqQB324=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GdbpI+n+ZVF+OX4wOxpLRpRJnjKO/KAylo+JTzg50/SxophoQ3xF/hS8FtKyoQRhcQ4Y6XMPL5iy2rGcU/0Hm7JW77RduQSGwclooxHqX3R11biHdZWv1uEFLdhreGE3Tk4ebLE9KsNg1cVPuH0VmzNNb6zymSEZNnV6SEPXZvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mLBi0Nlj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=eH3bYXdl; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mLBi0Nlj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="eH3bYXdl"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HFftrt023992;
	Thu, 17 Jul 2025 15:54:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=BYKI1OopGLyrJ9L87l
	huxx6KYJOcCFCA1HEILqQB324=; b=mLBi0NljOv5Jpe7ziPxkD/wMUP0PJX98YH
	bKtgeEv2Vq/3pkMjkI51Z8BA1i0JV9fC+uJpXCdVnHCQm32vVj9pFQO/q/Vhq/Cj
	JOfXxq0wRqRDu7P4b32nuRDyRFIVGQpDDwc1omD1e6rt993mzT3J8iwnwfESW4Fd
	NMyhZf/apAehloJsepizd3BAF3zkA8qyUrJcXNYbfYBCshnRV/ye6dpWS+WZn8jR
	QY84yKTV3YNI6lVSAs9mtXpvCDVd4VrpDinn2G2DfwqG8Ku91Wltopn1owAD17+V
	wIy6VNt3haCMZZXCPXxyrl/4nM/xfYXYfdj23wSRWleGkGUYqUJw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uk8g3gmc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Jul 2025 15:54:13 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56HEKuU0030383;
	Thu, 17 Jul 2025 15:54:12 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5cuyaq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Jul 2025 15:54:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FXscqG1lRxKQWaIGmF6kp7dV3gJpmqJ+lbK42C3umI6KZZkrk7fIBI+eITQGI48K82KquLct6oxks08AUZKU9kIZh/HJB+P6PE2U7w5NleoAbuNc0ya/fbursyklDB/t773A+dVpJ/IP+2hbSlU8UUy2xv1TKxcQn9PuBLJi/iZRmaaT/cRnPzMDCsTYl8JMn/Wm+Hyh0HTgGQwmzttjxyzg2UECptzEwzIvIAkoMqe2MnK/ZB0vi4bjPDCYdjYj1SUjg4JXEyHd/ToTBRRAsdbUBkVS0A94bcyhIiKS0qtdD1fqijfL/RaN4IdHMP230g4W9TDL8+suYAKz4lvB2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BYKI1OopGLyrJ9L87lhuxx6KYJOcCFCA1HEILqQB324=;
 b=p09XPG1LqMxNe2s/9QW4hB1WCyMj0dkk9GmYUR+renrGOQAZ7yUhPhW73ODv4qwTk84izmC7437wF0LY1VPcg7K6DC32Q8OoW8PZ70bjFhcZiwwxQ9qaLJBcvNN5EzbWKRmKmR2PtBwvRp2XNvSViQRd9OeDCZCNgcZNnzcwZAgoyMiKSTSpV5WDUO+MWpaa8VlDkr+tTLizoIkC6hXMxNjMOXPQk+T9wMMHOw1TwuyVLfszaF5Kt+7/HCb/O3Qho4EgJpRq3vowt5Sw8Ri8uILE9ntp4xiUedVPoYvBBwQUfpbyFZg84GjS88FvCbB8JIEeCpWpQGnWMTWOPb1loQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BYKI1OopGLyrJ9L87lhuxx6KYJOcCFCA1HEILqQB324=;
 b=eH3bYXdlTplZvLcFlZ9LYhI2nD3tr9gSPmh9Rtx29nBH1v3Fx9NxCPEt3YBlbwGHokCcEXCwveC+PxUjWGALtTELMc7i7Bt4Lz8TLoUhZ6xYBVcJ64F60uO4poiAjxLpqEeK7KNrMq+WwvV7/Cq4coY32naXfD13rHNaM6OerTA=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH0PR10MB5211.namprd10.prod.outlook.com (2603:10b6:610:df::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 15:54:08 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8922.037; Thu, 17 Jul 2025
 15:54:08 +0000
Date: Thu, 17 Jul 2025 16:54:05 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Nico Pache <npache@redhat.com>, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, ziy@nvidia.com,
        baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
        ryan.roberts@arm.com, dev.jain@arm.com, corbet@lwn.net,
        rostedt@goodmis.org, mhiramat@kernel.org,
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
Message-ID: <a9b204b8-54ff-4c06-8afd-146c85834c53@lucifer.local>
References: <20250714003207.113275-1-npache@redhat.com>
 <20250714003207.113275-6-npache@redhat.com>
 <5ff595db-3720-4ce3-8d92-5f08d0625c75@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ff595db-3720-4ce3-8d92-5f08d0625c75@redhat.com>
X-ClientProxiedBy: LO4P123CA0435.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a9::8) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH0PR10MB5211:EE_
X-MS-Office365-Filtering-Correlation-Id: 897ea928-2d17-4911-71c7-08ddc54a29fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HtIQ+QZ3USPF/hmVKyu0B0pw38mTDGuFe1NMph1xsnQCuhOSwSIZr8IMbzb3?=
 =?us-ascii?Q?gcsFxcB/HQ4LmKZ02R02JbHhwssjs4X9zw7ZJe9fWDaf6VDIqKg7s2622RUy?=
 =?us-ascii?Q?0dB5eZUboVV29drXZFVBJIITIFAcW22kwM9LKbMHx2pJNLsEnVX1Sl+ilp2H?=
 =?us-ascii?Q?3tVkWzmbGRxhH8TJTNBhBkz2IXaRcyJiVBecEytq8KRy2C8If6eaDsVjNP3G?=
 =?us-ascii?Q?vYiNIQJLOle7YvLoAJVY/eaOF5cdUIez4w/sPVYO6mr254KzaZYinD4x8VZV?=
 =?us-ascii?Q?E/Syb0MqQ4Kxb9MnTLZT7mZi7nOWzT/pTSglsZqOXqMY9f76xdLlg4p6QriV?=
 =?us-ascii?Q?SAX1YICtw4kz2KVbplIQttyq96SXmvZyT5wGlea2xc+A1MyY/RPKhcBq0usa?=
 =?us-ascii?Q?qoNVMGVvxk+c/t4ck6QtJvdgsmr6FFJb+QoNL2RmbsyqSIIX1TSPhDGJj/ST?=
 =?us-ascii?Q?WD7uQ9/RkYKyXWqBKjt/5Ct7+/s2cPg55pPLhu09AtDEQj6HLy4vS4iku1N5?=
 =?us-ascii?Q?Xv/dfaXtcGGYqRaT2pRAM0a66AUJfhw1Ufg38YiTlhAW+6EawyHiZGd6+/Hn?=
 =?us-ascii?Q?oIlTr64FXtrK2WImdvIA+HuQhz0s9WXXOlO9jczyEFSnCeVrfAv9EY6Ktya6?=
 =?us-ascii?Q?KFnO+BX/rsqdAjm0S2JofKcSvG5ulFv8AB8M763AwBjhoHTLv7BsRqmHLLOt?=
 =?us-ascii?Q?L1piOhVwzwqrDIja9vNcRMQNlF3vt65jw34JgRVv3somFL5Jf4zFqm99wKmh?=
 =?us-ascii?Q?EXJXaMzIRZvSgSVcsmcGJ5D5eSsOBnZkM2lORZIqKphX/zWsQwSjc4DLQ4Wk?=
 =?us-ascii?Q?4+TCZgP4w3naLfkpt84+AXzsBGtrIm/1nzqAo9X5jJkP6TeLeeozBmIjYBsR?=
 =?us-ascii?Q?O5ZiYsRxZKRNoBGO4CfpfKSpqO0sBWv77gnJDpb6mFQ95NuZg00C8C9CEhhN?=
 =?us-ascii?Q?i8UbNjBSWviFYip4YOLdI+tSXGor2W4UvRmzX3UN/NwWtL4ioJM2t4TZU2j3?=
 =?us-ascii?Q?LSMAGZjimhwskSewC92cPv5LiInwZhHKCoZ/aZ8gPbLd587zUrwdZE+ywGX7?=
 =?us-ascii?Q?azG6QUdwc8+cfae4nkAF1vXqLv+RW2HJh+P3E9Fmawk3uIWYa7xeKRFptpqW?=
 =?us-ascii?Q?Uf6pqviPPTTHll2EPktWhNzBbsCO6fkcf8dmXFWMWBFagDz+1+bOI4LbGjaZ?=
 =?us-ascii?Q?i5izpbbHEvvYsrmfaLE5pUpyJz/NwpZrhDdfYV1WFEqOVIP/gHXYkuiUrTZ5?=
 =?us-ascii?Q?aZcXJNOoRMNfSmfM6xEkJVbvLUMxzWq/TzWYsipTsgek1AR1qTF8rqeOkbNe?=
 =?us-ascii?Q?HecLTId2yR9U+YtIWNn6Tx0GPrc04CWVu+7VySjgMIOt2ETTS/anjetXHxju?=
 =?us-ascii?Q?G/HFD1xIvATLj+DqEbSTBlV11Ge+xu1p/GAOIHu22aX1pLsYzsJuLxrUs6sf?=
 =?us-ascii?Q?x4mfFya/QWk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9KNdlYuav1xHkuZ7nes2Gpiq2n0sl0TU+fcHtyTY48Mdun9m+xf1ezydt8ac?=
 =?us-ascii?Q?dNU7z23NCNuwhqqeuB1w1tAkZJ8H26wI6UsiwIqx5stWl8I3Cgd0pz7vdP5r?=
 =?us-ascii?Q?YYFwLOYRpv95o6cIaqTBchFpyd5hHOtrCNMcqmL0MxDkcYPuuZkuOchk5LsU?=
 =?us-ascii?Q?69MAOqxNiGD26bfqPQ8F1B0y/eCvA8LZkynxp6Ktoxspv/1Tvw+0Sp9g579g?=
 =?us-ascii?Q?xQ8mivZ3Z7Xwd8em+MjSfz+jSyGaKVml4GJ+dUUl3dgKbQyIiB1Ld2i9NVFm?=
 =?us-ascii?Q?crPShiznO3QZv+93LyaWNPtaQJNQ+p6UlYMBMGwH/hTQVb7uTjawf1Td9yXV?=
 =?us-ascii?Q?yzeVHYo851QrqFq49JR40WjJ1rqIyLLSkgfblsv448tM64gOfPi7d0ZoQ64x?=
 =?us-ascii?Q?o9wuV+miQTz3641Wpv3S1dvUcVjYnXQsZNZ+Sx/vX7jnmZ/D0+w03KFK4jHi?=
 =?us-ascii?Q?/Vb+RstZ9CbHdoiA47Xz+pCG2bpr8H95xiCMHbRPg+f4EufVjFGmOVYHvhQW?=
 =?us-ascii?Q?C7QVLaf6LtOe+e+V4B+zQ4GTWbbR0IjO78rS3umpcXtJ0rhulE/d1noUFl5k?=
 =?us-ascii?Q?KbYif3f2CZYTyLp+UbIrwCss73xk81aONsoigXy/KfqT9h/o2STzVl/SQQRn?=
 =?us-ascii?Q?KnBc8uVdcUAL9Xrs/C90jVIv44qTsyhzvAOyKiBTvXhFXvwjWLjNvC9U6HqD?=
 =?us-ascii?Q?3UztAlJyJjpq5eBUM8Bfi6Oxon06JQATH1vZvAxLNSRaDkkX23wTxpUTLy2y?=
 =?us-ascii?Q?AHrZ30am2HLSWvr/c0OEINE0Z7J/rADqjcKV4GpQVHdzJKhR8+S4XOA5OKi/?=
 =?us-ascii?Q?0CKWFCKqHixTYC12WpsBl+mgc5I02JH+9MPlDWjOTHHeKmcuAN2hACfDyjp2?=
 =?us-ascii?Q?WwoCvo4jxK+gDDsJ+FJ8v/5R5acJetr6tFh/tLfGPU+EvdMS87PXS9fEsHqC?=
 =?us-ascii?Q?tBprhqAukSdav3mD7vMrPjHMc6J0NeGnbPMTRrSkkMdTdPaAc4KPlaTBXp/C?=
 =?us-ascii?Q?hN20+v0kCqijMmOxGYWWaQGOKn5fy+7F5O+MF60zGkKzEC0pzPqxqJRWD5fY?=
 =?us-ascii?Q?bmFfk1dLxkUDfUgBjsxOBhTtsFLE6mFQyMT4dR6yPO1i4tKk7A7ckFPH2NHZ?=
 =?us-ascii?Q?edxdVnXuPglMcOlu4KPg3VY7KfLEBLPL47T3TpfbdWC3QP9N4FhTKxgtTQD8?=
 =?us-ascii?Q?oRj1K6t2RRzUoNjvuP74A5WNJaMUFm0j/d5RJvvlhtEYnFHDXkveRC1wavnP?=
 =?us-ascii?Q?zyl6onQzEMkI67LrySF1aP/oPbkzdcaavIBpcWW27KX8oxJv8kyYTEnpNkrk?=
 =?us-ascii?Q?lW1KQkD7y38sLom8jBjObz1zRAuINODuxi5aTbY8lfkn6m57Es/BCMU8ATTY?=
 =?us-ascii?Q?ZsI2tnhMSXWrnHOPEiwWJLjKVft5OMADDy4V7BqmG+QQ/602trf9wkPq4eMn?=
 =?us-ascii?Q?5nURANmnqtCEX+MaAv/jR0G3AkaP/TVVSavxcT/f0g2plVclO8lbbU86Ghj1?=
 =?us-ascii?Q?CwQs7taNJu3L1DrNpmUe6hl7FNKV/fZKGdAQJ7lM47rhikwd3/Fu9gF86lfc?=
 =?us-ascii?Q?z09Xu7d3jQLMzik9CxRCbspGPEDnIVcKYTqVgkBzwp9WR0HuMIs06f/aAu9v?=
 =?us-ascii?Q?wg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	pkdk6W/3VaMDq1F+sTboeYHwos/SnoSgdhUx9ZFT4eQnvDG9aOFdL3MCY9KZfUL2odSGQker8vAc96cpggPIrGC0od5zzWjzeywJhiaQJ9yk3W7cSc/1gkE8RsU1aTjQPzIBZVKxsNDtXJwhkmu/eNYNY1e1iOgg5FlmKn+sgOYTG0wnYAH1n1B8b65EmKsa865r4e+qZ8SnOuzleIRVaqXqKRwvY6PCdbBuBD4GMIzVAbn5rzyCWx+IYwHY9jxNHUj+fdlbfTFjMW2/pZt/VtgsL+GD8e4Tm/Nan06JRj3PMDFWQiq2TMyuDSZd3v9WhuEX1CC8kJNiE8O0nPgTLTP4Mol+oukjFNz0zByMi22ACUohMgxWyf0ixQhv14cEQQ9tDVdk6dWHpI9chS6U3dzRt4OFh3yBDWM12RBlLJSkvE6iPF1jzwO0JpCk6InRZAv5pP/ay2SOI8BrxSMEpazcC9BV5FElh1d06ZiPX/wW0sXifRnjNY93O1dekOGqjo6VHf0T0cjAgYmFKII6Eg1CmASWFW0F1AVkjfPnlwmri33LkuVUUOk9oF1UzSyxAZYvWJIM7rf2tjJ78pJov5S7mdP0HhQiMBMUXd3zzgw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 897ea928-2d17-4911-71c7-08ddc54a29fa
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 15:54:07.9910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YfhRUFixb64EIOnctutP5PuJuAhfoTIKhRakfwooG/CIPO5VI4HWJdKmjCMhCTmK7oYcrmr0nrgc+lNgPDcqi3RhVQ5MO7DzKCIoFM3l05A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5211
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_02,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 adultscore=0 spamscore=0 mlxlogscore=918
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507170140
X-Proofpoint-ORIG-GUID: PMSgsB01ZCDdbmA2nHA741LwP7z7j7oq
X-Authority-Analysis: v=2.4 cv=Of+YDgTY c=1 sm=1 tr=0 ts=68791ca5 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=3la7zoJyX9MPVKhI_8AA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: PMSgsB01ZCDdbmA2nHA741LwP7z7j7oq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDEzOSBTYWx0ZWRfXynGRZ8OlnLbU VHzFMNjzPdOu8SaLzatsXQpM2X0mU3dEK2dK0Rfv4dZWGeVVdclTkCnNf3Zeyc8b+c9+CwpAavP LAqCvv5m0E66xPHaZZfxC9/vCxTJc+P7J905i7BFOpMyOwCHTvUa+CZ/LRZ6uwvFHWqshcFIdb9
 IfUJpdzoNpEZzkz23nocCu1Suj4mb9B6yS8Bu7Nt5MdAsaUq6yrdav3+X9qRMJw+CAvjn455OZj rliVShis9Zd1nZiuE3kfLBZaYBKcqsMLognvKoH1xgW2iHHgYdm+SWD4qc/kWtRPcT4zZZq6S1O E8pnaJ4OvUIJFzz+/7AQApnl3EHfxqAP+Wp1WRJoKZ+o5WyJvOWyw7OAW0qpgHEP5ARmaidEAaW
 g7A7qzYhclmJxkgtaBSAMHfmnUJDKEXKtjxLzy8zevwvvQO7CD02RnoriBuudEai67tr197/

On Wed, Jul 16, 2025 at 04:02:43PM +0200, David Hildenbrand wrote:
> Doesn't compile. This is introduced way later in this series.
>
> Using something like
>
> git rebase -i mm/mm-unstable --exec "make -j16"
>
> You can efficiently make sure that individual patches compile cleanly.

Just to drive this home - I'm bisecting something and just hit this.

So this isn't just a theoretical thing :)
