Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77249331A70;
	Mon, 26 Jan 2026 11:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769427674; cv=fail; b=NxJsl2KoaM/Fr49DG51dWKFpyGDtd9SCK8nl6a+HnOlQ8VacWStChfHvfyPJ91218tz9lKpY/1h+e6IuMNSveGgTVR96QzIkzwc405M4aLGSw/usMlru97SuUpqCSOnTNmkzgrK7PE2DNpsYE7OBTSGwFN0ngpGvN9ac+Ph60LI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769427674; c=relaxed/simple;
	bh=lH+AeZeh8Kx7ICzDVUZ6fHh6Oc+H5J/XTUCh7No8iv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KeGAxntWZNsDt86mzYVhNvkUy5AYgqMvyhJBJkXPZoB2wS/59SxikMsHx0LIKDNGzkvz2Xo60iqRqbXOh44u2/1wS2QmUMzLEk33xtdfeTNYhD7hPt78IOwRG9Xg5hhonMF+g+VQLKgmyZSU2bT+TZfL5jRoNfd9BjsWYbZAjZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ouOrzDxS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UzitgjyI; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ouOrzDxS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UzitgjyI"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60Q3d8k71498687;
	Mon, 26 Jan 2026 11:40:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=G5BXf7FSbCjCYww8s6
	rfo43ETB2ZfJ9g9i3XGa7RCC0=; b=ouOrzDxSx0r3aY4ar94mt57NhjDkYJKHgK
	SOmk/3QAhOmrDaHcRZMpVr16LoFOru9POVC5IFwkOBGh3jhDbpRKYas5CDHYjZiZ
	l5dqyfL6Q/JzVyMrCVE8HW9QN5HUKExXC8rm8//rqsRLMnFR4GG1s1h72kRfea7V
	faf5+tWxY4ilyW0WdLdgdpB0rEDm+8HIt++/l5V8b1Sbi2MQsC8c/bMLCvD2X6l4
	UCq3+Xwkt+YQlCLnliePeaHI2s2UyHBLtVHqV1nAVr6b+2Zx6j83AGeeRGJ77Ok7
	t8cWYo8LidYyi4cXyHePyLAjkMEzm0/FuFIJSzk/0qG9lnM7s8KQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bvp4bsq0q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Jan 2026 11:40:28 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60Q9AVrF001961;
	Mon, 26 Jan 2026 11:40:27 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010042.outbound.protection.outlook.com [40.93.198.42])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4bvmhcc5c5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Jan 2026 11:40:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sDiKWB1HoFpRUp8b5Zh9bJ1ok39efYGHx74obFglE2vEV0m0S0N60qwEfJN3ejFca+FX2oASdPJ6oEQFgEd7N2+32XFyS4rW6Imn3bjwbne1WAKcul6ROMF97nFyrXIhauGCCdHPNYn/k+QpDdUQR9uUgt3hi6Jy3l364lL1MYgDLq6WvvPx7RkRI7sHocWaA6kSmc0+bChazNuH1muT3d/tJUFBXsHGKZ8WSOmkASplRvHFSjJafqEpeuPTS7WjY6Yn9QCC40KyccQ39FENVE0QQ6Pd5kvB0lDFKoAP+PpIO0y/HSIYczLW2AfboU+WXtt5PbicTBxGTEcuHO0r1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G5BXf7FSbCjCYww8s6rfo43ETB2ZfJ9g9i3XGa7RCC0=;
 b=XJ0ikYWCB0iylL5HzWYxHWjmtg54yt00hiX5rcjJ2jo5g5DFxGTos8zQMVK5NmmKml978FWX/PVPXAulIWwQnspROtgfI3gmfMHIfKhldc5X+Y/BmfoiPtW9qR32gHV/H0wt8ITNFoaS7qvTOmuX6cMxKCR4co08tibjpnzToZsbNw87wkYgbpIy3gisZlxtB3/zM33ws/BoEEtzpyGWq/xXfFmoU6GqEMfEglPkAkctpcrRCC4Q671QEH7xs2KGx42Gg+fUk1rR4KouShiffxn9TxKALzgWoj2J+zkILGX/32QBd17JLTovr9iUy4goYAxXMLQePSyG5jydoQ23Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G5BXf7FSbCjCYww8s6rfo43ETB2ZfJ9g9i3XGa7RCC0=;
 b=UzitgjyInP8z13g4d27M5/22ImQNCrnshz+7Nb5kvG8nu93GedwQ29CbyfEjwPAmIeJUX6jxFOg6B9s26bkfoTvVUVunI38WR9HcXxLD8Cg3YBXiYbt806ZUBhUUSwqtdyZBhohzzp2KaywloJ0tp4pZ42+9Rbdif1/IutvM9JA=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by BN0PR10MB4853.namprd10.prod.outlook.com (2603:10b6:408:115::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Mon, 26 Jan
 2026 11:40:21 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%6]) with mapi id 15.20.9520.005; Mon, 26 Jan 2026
 11:40:24 +0000
Date: Mon, 26 Jan 2026 11:40:21 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Lance Yang <lance.yang@linux.dev>
Cc: Nico Pache <npache@redhat.com>, akpm@linux-foundation.org,
        david@kernel.org, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
        Liam.Howlett@oracle.com, ryan.roberts@arm.com, dev.jain@arm.com,
        baohua@kernel.org, vbabka@suse.cz, rppt@kernel.org, surenb@google.com,
        mhocko@suse.com, linux-trace-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, corbet@lwn.net, rostedt@goodmis.org,
        mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
        linux-kernel@vger.kernel.org, matthew.brost@intel.com,
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
        richard.weiyang@gmail.com, David Hildenbrand <david@redhat.com>,
        linux-mm@kvack.org
Subject: Re: [PATCH mm-unstable v14 03/16] introduce collapse_single_pmd to
 unify khugepaged and madvise_collapse
Message-ID: <0e79a766-811d-477c-83ee-389db29d41bb@lucifer.local>
References: <20260122192841.128719-1-npache@redhat.com>
 <20260122192841.128719-4-npache@redhat.com>
 <65dcf7ab-1299-411f-9cbc-438ae72ff757@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65dcf7ab-1299-411f-9cbc-438ae72ff757@linux.dev>
X-ClientProxiedBy: LO4P302CA0041.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:317::19) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|BN0PR10MB4853:EE_
X-MS-Office365-Filtering-Correlation-Id: d6955fd5-b9e5-4e0e-b0a6-08de5ccfb1e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sihabNan3laCk4c0rIfqrRIcF0SyNVOCHwyFmcCXP9xJGDh8simtNESg2qqt?=
 =?us-ascii?Q?Zo6oEU1uumfjX9JEG3v5Y4laEkKjnDjWuOXAOESOGN2wWkgEXgzLdsiEwkhr?=
 =?us-ascii?Q?r4y9Fo0F94aXaauIRV2chhjaUvJbW0HJmGmxkklmfu7/taynf4P/n6kYhKk0?=
 =?us-ascii?Q?5+wvzRcHcl91CwAq6h1xylp9IKAY4rMU5LjQJL6R283xEKKTwUHre/F5uvdk?=
 =?us-ascii?Q?GnHTImurQ8+EX6O8mFM0a93AuPSWFmSefMKovg5JXpg1jH3hbSX7o6WD2a74?=
 =?us-ascii?Q?9FhnktSVWPnlkZSkmtI1oTqwmmd9PHcDP73DtmAThMsf2gzuna6XcgDR6qhU?=
 =?us-ascii?Q?ljBky1B0prfg0fsz4wzNJ6ySpXkWLO3GEW4ZW9FbxFZXKf5PtUlV2J0B2d9o?=
 =?us-ascii?Q?0imisKfeNqJL0k5NsumopCRCFG6GXAUsR7d9XX3M3hlmhKlXY82Y33gu1qzE?=
 =?us-ascii?Q?DzH2kUTEn6XfFTmUuNqfQQDg0ybLtkK7vSv74AQ/7A7I4zLbfeeusdPvm/hB?=
 =?us-ascii?Q?a8WwWuEBhsFvuOhJEwINz9tqo+GV2oSh/XZjfRMVO3BDaZP30/V0BT4L0VOH?=
 =?us-ascii?Q?XvOZlmlqxDBI/HegpHQc4ZpqUgeZzVm0kw0GoeWx06dwSd9cLG+QISwNyqff?=
 =?us-ascii?Q?IoFNn60go36Ey6RrUeT+FNDxM0AHXDSjbnsM27yY+X7QHJnbxL7ECJNQfjr4?=
 =?us-ascii?Q?4wIH+TRs6d2LWCvnCH8kOr3zuVucTGR1Ebq5CwPOImTmYSbT+p4XnoEPzM9q?=
 =?us-ascii?Q?72M5dCWrkdKeah2TCLnu8vRmCv3sk2U6dhYkOhTxMzE52IBiSG+504FIAACc?=
 =?us-ascii?Q?dnW7hsHPMwPSUdothrxCt1k4L1uXJYUp0Dbfrs5G6pATN2FH9TasqRkVdbhb?=
 =?us-ascii?Q?4VbmvhtK88tmd7iCzSbXH5RGlNYcu8HUcPpcoqJJNPmZv7jsK95XJ4LxTHx8?=
 =?us-ascii?Q?qufBp29MqXnE6wZ9CHlm3smm1vjMtxEDCBPDgRUx5ERQlpMCDPnD+akTllTZ?=
 =?us-ascii?Q?YoYxOg4RWOypYqAzNJYR+tNCqI16IeOLdfMwnkeN3IKHYzpu32uRbCUSMXS0?=
 =?us-ascii?Q?ToCl+QZTQg8fL7Cw7qB2vc+3YWkiXQ6pAVpaeIyB7EtYmDwqbF1puzeA0i3Y?=
 =?us-ascii?Q?w2LGgqv91TB/s/9v3By9bD8hzPd4b9DpNNS+CpNSReVU4izutmBEjCHI8wvj?=
 =?us-ascii?Q?3rkFTVzMoULodCYKkhg9481wn/dyb7+CDlnsWYsIBPPIuWx3Ya0bOPHM7iEA?=
 =?us-ascii?Q?+n3UXz2yfHEk6L3A8IB51bKhzqg2urGmFlXQmTt/ht+j7k8e8/VkFk+J4gYY?=
 =?us-ascii?Q?8vHAmN12yBYu7583ZBGztB3A69nmD9k86iJes1+dOHbt7PX2gi8ebX0vUYN3?=
 =?us-ascii?Q?MusBWqXG9xG9mjhUsM4tl4rQErPXWUsYTOSObTl7w8ZeCTxxuafgFnGk6aJ4?=
 =?us-ascii?Q?6FduL7iP0Qj53rlIjNZKhnZNtfGWrJjUca4H9D5FYdvj29nWKkk2WFJQ9q5f?=
 =?us-ascii?Q?J2kzji5dTI109iKg04kIbRVkJww4azFfvlGpSLQy9sDBycBue6XVqojAVEyZ?=
 =?us-ascii?Q?StZhzil+V317f7GmoKk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WGnCix9Gq0n/uTy0VzIOpm1vOxBOwpS/lABEm1fKboGDcLajA8nFZ42a7ei6?=
 =?us-ascii?Q?3Wymg7W7pOg60stz641ohO0PDRZVodEhfbjz3NGjb6XbcoFl5bw7ESeCB+C6?=
 =?us-ascii?Q?uRm+Im2GkV764+FM+dNb9S8L7oUmorAhvD97VvKitlz2xBBpTMXsjSiDctuk?=
 =?us-ascii?Q?PqJFU+5k9+WOdNCJo1ZHWJZyRKEHQa2PKYUVco277GL2FNaxqoqgCVAh5oxi?=
 =?us-ascii?Q?m0lFF8rARNvnIbsx9wBIADHRmawHyfHp4RMhqCdgMn8K7xSlPUg69Vkj3a8o?=
 =?us-ascii?Q?JjGpat3zHxo7V1ZqwmcgrMYz9tdT1N67rtuE1ph1yBZ3m+VoJ+MF8bWOox33?=
 =?us-ascii?Q?t/ZHK2lkjmso9BW6qnKdQP569hY7Z50HixXDCypKae+JI7epvwwH6vxLAyYT?=
 =?us-ascii?Q?lFhW3eW5KavG8/5wtQtPUrdpoaAo75O/s750q/rbcGKXwx36FnBqCwM0uRYT?=
 =?us-ascii?Q?sOYv7k2pbaAqRRpEVmnYgxp4FxfYdxhzigg5MbgYiI7FjYeNCiKlGPApY5mU?=
 =?us-ascii?Q?KE0rtXjSv4y0o3+8gtaQ/I/u6fM+vtpcZBE1Xq5QcOAS7DbcUkwyBPmPQKAZ?=
 =?us-ascii?Q?jOFqQL3blad/JocEIBTdAWlNgk5VlYY1XhBDveLsAzIVxN4jiu1mexHBiIPT?=
 =?us-ascii?Q?WIPxVk+msHDpgxw43LP3X5S2u+uJbm70Q7MA0f6YdD4K235MFGOz/z68dTGf?=
 =?us-ascii?Q?EZFEZhRa0MhoRl8NllTk7yzg1YqqsfuYmjRc+T4RzmB9jfo8kDVsHs02bgWo?=
 =?us-ascii?Q?NjYaiC/gylrPH9p3mFaDrh+8gKNO4Rc0MM+aWthHvQEmtVXwct/+rCOYUyDa?=
 =?us-ascii?Q?xsvIlUP98kxm5rvYtvqYIe1bSlAEJZUrB3d5K5R4oL1MhFBEdgEWvd1EJu1i?=
 =?us-ascii?Q?lqkYcLl3MGxIaPsONwy4goK0AHYDCckr7BY+Hm83irk0jPYJJqsMe+MgfnaB?=
 =?us-ascii?Q?wWIik2R2UZDhsQLBAYH2kM2FMRVGiV9s64BJ9EchJdNlZYaNe3g+oOzZ0cGz?=
 =?us-ascii?Q?F1IDTxHrrY1+MOQ/zOvx+z8dEWjuimM2arDPX4x6ILY+PqmXrabBJMr+LKEZ?=
 =?us-ascii?Q?ZOdz3gHxlABaU2gbduNN2Si/IxOjmAEK9vdX7iYguzKB51ECwffSmDuiPGL2?=
 =?us-ascii?Q?0xfVXS4IGo64hNzEX2xBoOW+zCm8ntDo4GdtU4IvKwBTlCVTWCjNx7dJnflI?=
 =?us-ascii?Q?t6SsBUcM45y6whPRMPAShf+bTDnQc2GWjKI06cKq8vy3otbOmLvUKTvlLVlU?=
 =?us-ascii?Q?1Zd7cqoa0+P2Coh3xC3IO20MYHd8KHf5ng8BQnzMkav4UGr+eX58lqXOWQYq?=
 =?us-ascii?Q?ob9nC4sItAef/CtycZLB8JdSONZ/DOFesZxTnerM4nZEQPkte6W7BEXZX2z/?=
 =?us-ascii?Q?4GJzvV7j14+bSYyYL+RSDZFU88kUG7vsxkBJrPBQL4RsQPtkXIBN76Dtwr38?=
 =?us-ascii?Q?uPqu9v8l34rCxmqcIi3ZjiDJJRJ+pUDUzIa4V2WhINmAv86hQMBAQKi0dtfF?=
 =?us-ascii?Q?IBf4T0Z74f7uQejSOOnV/XYjTOcto+sme1LvuM/nQJV/H8oxsyT2ZIkU/S93?=
 =?us-ascii?Q?3OHTZeW8o3r3Hb+gfKjnhU4bEvzasudPOzCVQ0xDcUA+uBtSD3suBR3t2ykX?=
 =?us-ascii?Q?ybMsK0gRXL3YMrPfxSdAeuD5XZPIuHN92FJxn9zJJjiRv2Jc/svpUmn2BUuW?=
 =?us-ascii?Q?wIGQOMxjmeUOH/mpZbGOTzbaXmhrFWaV5VtmWpyZphtqEN3mSzQkvDiwzosa?=
 =?us-ascii?Q?iw7e1y1kvGgkNTDDeGiyj9x9FBtb0DI=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rYDXvYe3UZiApEa0S5sw/h7iHgA9Wa+qwqPFuYzupTxCE4IfrxmlLTZxaEdxEAfUX2Nqp/DTI3VpUr6uRz6T9Ps/QlQeWM8DnfpoaJJ/d1L4cFxOhEQeydjKl2KYNcrl4oP3UEg8+2gQiCHB7ZqqsnKhDe0514YfePG16bTElJvu49qci7SxvPUSCFxP96awHt3jMs0c8AIJ3wErkVkMLcpMYnohm514dNYDEuqLE8nd+C5Nm7k108Mu2gf2RnGaDJFTYvhWgF9uif6ywctSlS8xfmAV78c2XEnq5KVrpLrRWZsJBDoQjzeBgsYiJnaAdq/kt/kaqYR+/LXlcAzSMr+NIrx/oYT1sI52T7YrM2f812o8dIsCjSHl2o+qJsjSZO4zl3n9RrfKdK0OlMGAhnsUdhWiDD5tFuqfWFFfEyNFCJ2SDJLP4oXk3/1ZkuDZEPB7KG51X80B+fGEM9IlhFQ8gXxNiiQCMor+G9P+ELGo7hfjnkoIy7Sk/YewmK1DYbyG5wpkgq5QqCYjw/WeH//J+QdMB/m3dekDgM6XvvMm+lv1ZHAsUh62qpqxDjgJGw06/uRHKD695jvZIFwBm6tbNGfywx2nCM4tf1ombjo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6955fd5-b9e5-4e0e-b0a6-08de5ccfb1e7
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 11:40:24.7698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NhHzk2UhekRpG8GZLy3sCz9bg1rBSd1xofApxa5UF1eG5C4JmPGN6xo3dCoYZnQggRatKbZzPtCkiegv1/TtN5kT3UDkpBt29B2v6/h7t24=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4853
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-26_02,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 spamscore=0 bulkscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2601260099
X-Proofpoint-ORIG-GUID: xBr8LEIz45LLQRdfhLSoxNJBaFzsbV_A
X-Authority-Analysis: v=2.4 cv=StidKfO0 c=1 sm=1 tr=0 ts=697752ac b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8
 a=SRrdq9N9AAAA:8 a=Ikd4Dj_1AAAA:8 a=w9PpIFtyoLv_KdPcWbUA:9 a=CjuIK1q_8ugA:10
 cc=ntf awl=host:13644
X-Proofpoint-GUID: xBr8LEIz45LLQRdfhLSoxNJBaFzsbV_A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI2MDEwMCBTYWx0ZWRfX66nlKiK7Tw6E
 8dh32dorFvpxn93gUnfHa5iBwr2yDL0aNOORYcB/lFUrnyfEOtWRnmiOj1pk0vgUXxdIhunwgxe
 gTl3f2tVFUG/rAxvSDJnguo8SRIbSDjRqi5eolYenCiNwT52GLFqtJ4IEjLXHl1tOtsn0Wr0TeA
 pml9kqflHe2Ko/GN7n7XGbrId/aZtRBY//C7pZ3AEwDyfd+1GeBUwTzF4cXOh7wEoLO63yEoUfw
 dmsQuqm/KNh7c+WkJr5SRxyV8peTcrCvKm4k5maBDQDDM+oQIzkWymW4FiQyPXI9lB6eMCAQYd+
 soiFea977BiTcxnuenY9c1qoQ3liNVuGLdNGrH9m9n4K4EIdWrEovdVTREAB8fjUsej/B8A4aRn
 mNP3UA/nvkqx61bLNrmPadEYdnExpM7D5YzUrtOCX8+kUyZoxOyg9tyTzzZ1WrMyKJT3f+AWk1k
 ZRs2kyOm/ukbMmhBQgfkuwcP8kE25V4Nn5twZfVo=

Andrew - when this goes into mm-new if there isn't a respin between, please
drop all tags except any obviously sent re: the fix-patch.

Thanks!

On Fri, Jan 23, 2026 at 01:07:16PM +0800, Lance Yang wrote:
>
>
> On 2026/1/23 03:28, Nico Pache wrote:
> > The khugepaged daemon and madvise_collapse have two different
> > implementations that do almost the same thing.
> >
> > Create collapse_single_pmd to increase code reuse and create an entry
> > point to these two users.
> >
> > Refactor madvise_collapse and collapse_scan_mm_slot to use the new
> > collapse_single_pmd function. This introduces a minor behavioral change
> > that is most likely an undiscovered bug. The current implementation of
> > khugepaged tests collapse_test_exit_or_disable before calling
> > collapse_pte_mapped_thp, but we weren't doing it in the madvise_collapse
> > case. By unifying these two callers madvise_collapse now also performs
> > this check. We also modify the return value to be SCAN_ANY_PROCESS which
> > properly indicates that this process is no longer valid to operate on.
> >
> > We also guard the khugepaged_pages_collapsed variable to ensure its only
> > incremented for khugepaged.
> >
> > Reviewed-by: Wei Yang <richard.weiyang@gmail.com>
> > Reviewed-by: Lance Yang <lance.yang@linux.dev>
> > Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> > Reviewed-by: Zi Yan <ziy@nvidia.com>
> > Acked-by: David Hildenbrand <david@redhat.com>
> > Signed-off-by: Nico Pache <npache@redhat.com>
> > ---
>
> I think this patch introduces some functional changes compared to previous
> version[1] ...
>
> Maybe we should drop the r-b tags and let folks take another look?

Yes thanks Lance, absolutely this should happen.

Especially on a small-iteration respin (I really wanted to get to v13 but the
rebase issue killed that).

I know it wasn't intentional, not suggesting that of course :) just obviously as
a process thing - it's _very_ important to make clear what you've changed and
what you haven't. For truly minor changes no need to drop the tags, but often my
workflow is:

- Check which patches I haven't reviewed yet.
- Go review those.

So I might well have missed that.

I often try to do a git range-diff, but in this case I probably wouldn't have on
basis of the v13 having merge conflicts.

But obviously given the above I went and fixed them up and applied v13 locally
so I could check everything :)

>
> There might be an issue with the vma access in madvise_collapse(). See
> below:
>
> [1]
> https://lore.kernel.org/linux-mm/20251201174627.23295-3-npache@redhat.com/
>
> >   mm/khugepaged.c | 106 +++++++++++++++++++++++++++---------------------
> >   1 file changed, 60 insertions(+), 46 deletions(-)
> >
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index fefcbdca4510..59e5a5588d85 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -2394,6 +2394,54 @@ static enum scan_result collapse_scan_file(struct mm_struct *mm, unsigned long a
> >   	return result;
> >   }
> > +/*
> > + * Try to collapse a single PMD starting at a PMD aligned addr, and return
> > + * the results.
> > + */
> > +static enum scan_result collapse_single_pmd(unsigned long addr,
> > +		struct vm_area_struct *vma, bool *mmap_locked,
> > +		struct collapse_control *cc)
> > +{
> > +	struct mm_struct *mm = vma->vm_mm;
> > +	enum scan_result result;
> > +	struct file *file;
> > +	pgoff_t pgoff;
> > +
> > +	if (vma_is_anonymous(vma)) {
> > +		result = collapse_scan_pmd(mm, vma, addr, mmap_locked, cc);
> > +		goto end;
> > +	}
> > +
> > +	file = get_file(vma->vm_file);
> > +	pgoff = linear_page_index(vma, addr);
> > +
> > +	mmap_read_unlock(mm);
> > +	*mmap_locked = false;
> > +	result = collapse_scan_file(mm, addr, file, pgoff, cc);
> > +	fput(file);
> > +
> > +	if (result != SCAN_PTE_MAPPED_HUGEPAGE)
> > +		goto end;
> > +
> > +	mmap_read_lock(mm);
> > +	*mmap_locked = true;
> > +	if (collapse_test_exit_or_disable(mm)) {
> > +		mmap_read_unlock(mm);
> > +		*mmap_locked = false;
> > +		return SCAN_ANY_PROCESS;
> > +	}
> > +	result = try_collapse_pte_mapped_thp(mm, addr, !cc->is_khugepaged);
> > +	if (result == SCAN_PMD_MAPPED)
> > +		result = SCAN_SUCCEED;
> > +	mmap_read_unlock(mm);
> > +	*mmap_locked = false;
> > +
> > +end:
> > +	if (cc->is_khugepaged && result == SCAN_SUCCEED)
> > +		++khugepaged_pages_collapsed;
> > +	return result;
> > +}
> > +
> >   static unsigned int collapse_scan_mm_slot(unsigned int pages, enum scan_result *result,
> >   					    struct collapse_control *cc)
> >   	__releases(&khugepaged_mm_lock)
> > @@ -2466,34 +2514,9 @@ static unsigned int collapse_scan_mm_slot(unsigned int pages, enum scan_result *
> >   			VM_BUG_ON(khugepaged_scan.address < hstart ||
> >   				  khugepaged_scan.address + HPAGE_PMD_SIZE >
> >   				  hend);
> > -			if (!vma_is_anonymous(vma)) {
> > -				struct file *file = get_file(vma->vm_file);
> > -				pgoff_t pgoff = linear_page_index(vma,
> > -						khugepaged_scan.address);
> > -
> > -				mmap_read_unlock(mm);
> > -				mmap_locked = false;
> > -				*result = collapse_scan_file(mm,
> > -					khugepaged_scan.address, file, pgoff, cc);
> > -				fput(file);
> > -				if (*result == SCAN_PTE_MAPPED_HUGEPAGE) {
> > -					mmap_read_lock(mm);
> > -					if (collapse_test_exit_or_disable(mm))
> > -						goto breakouterloop;
> > -					*result = try_collapse_pte_mapped_thp(mm,
> > -						khugepaged_scan.address, false);
> > -					if (*result == SCAN_PMD_MAPPED)
> > -						*result = SCAN_SUCCEED;
> > -					mmap_read_unlock(mm);
> > -				}
> > -			} else {
> > -				*result = collapse_scan_pmd(mm, vma,
> > -					khugepaged_scan.address, &mmap_locked, cc);
> > -			}
> > -
> > -			if (*result == SCAN_SUCCEED)
> > -				++khugepaged_pages_collapsed;
> > +			*result = collapse_single_pmd(khugepaged_scan.address,
> > +						      vma, &mmap_locked, cc);
> >   			/* move to next address */
> >   			khugepaged_scan.address += HPAGE_PMD_SIZE;
> >   			progress += HPAGE_PMD_NR;
> > @@ -2799,6 +2822,7 @@ int madvise_collapse(struct vm_area_struct *vma, unsigned long start,
> >   			cond_resched();
> >   			mmap_read_lock(mm);
> >   			mmap_locked = true;
> > +			*lock_dropped = true;
> >   			result = hugepage_vma_revalidate(mm, addr, false, &vma,
> >   							 cc);
> >   			if (result  != SCAN_SUCCEED) {
> > @@ -2809,17 +2833,17 @@ int madvise_collapse(struct vm_area_struct *vma, unsigned long start,
> >   			hend = min(hend, vma->vm_end & HPAGE_PMD_MASK);
> >   		}
> >   		mmap_assert_locked(mm);
> > -		if (!vma_is_anonymous(vma)) {
> > -			struct file *file = get_file(vma->vm_file);
> > -			pgoff_t pgoff = linear_page_index(vma, addr);
> > -			mmap_read_unlock(mm);
> > -			mmap_locked = false;
> > +		result = collapse_single_pmd(addr, vma, &mmap_locked, cc);
> > +
> > +		if (!mmap_locked)
> >   			*lock_dropped = true;
> > -			result = collapse_scan_file(mm, addr, file, pgoff, cc);
> > -			if (result == SCAN_PAGE_DIRTY_OR_WRITEBACK && !triggered_wb &&
> > -			    mapping_can_writeback(file->f_mapping)) {
> > +		if (result == SCAN_PAGE_DIRTY_OR_WRITEBACK && !triggered_wb) {
> > +			struct file *file = get_file(vma->vm_file);
> > +			pgoff_t pgoff = linear_page_index(vma, addr);
>
>
> After collapse_single_pmd() returns, mmap_lock might have been released.
> Between
> that unlock and here, another thread could unmap/remap the VMA, making the
> vma
> pointer stale when we access vma->vm_file?

Yeah, yikes.

The locking logic around this code is horrifying... but that's one for future
series I guess.

>
> Would it be safer to get the file reference before calling
> collapse_single_pmd()?
> Or we need to revalidate the VMA after getting the lock back?

Also obviously the pgoff.

I know Nico suggested a patch in a response, will check.

Cheers, Lorenzo
