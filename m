Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66041FDE39;
	Fri, 12 Sep 2025 15:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757692391; cv=fail; b=Wdj/GMJVs6fPMr3pXCW96bNUw5g7SeobYIbqP3HiVwiIxGrAb9LfdbMjo7WJzW6tOqGFYtPourHN2bkI4yymsCaakl8wVzB3WIycMNNh7zzrzk+qwD4wM7Hp+xe7LEPtkALR7mt66J8RMWxEOGeTqXlgT+gLQgYMxN5+szJ6mXw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757692391; c=relaxed/simple;
	bh=TOYWVsHIDcKkn2u5RbcQl4wzLE20TNCrgBJG8VuJzv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Nzi8EO7MukkAhy6oF8pT+oWv1CMSLVEhtaDM+94RtKDR0x89PkNdoB4oW8q86xsQYNnfEZ/2H2vx5ROp88nSDKLOo1SFOWe2rrm4jRsHMSo1Uo50nXWPFDZcNEZlR/SFlqW969VlhKAY5T+ADcDgvC6KfINIvoBorlylMnU/qPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ODItIMp+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NLJqudgm; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ODItIMp+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NLJqudgm"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58CEq1uk009771;
	Fri, 12 Sep 2025 15:51:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=TOYWVsHIDcKkn2u5Rb
	cQl4wzLE20TNCrgBJG8VuJzv8=; b=ODItIMp+hbnIYuQOPt5oyGzUmKnGDnM6yY
	dnwx5Zxlbf2PkhB9uMdvsmSAV7lfFQQ6EKHNrKUtR4LoBuike+eYoWOHtrV/7GfC
	oKxh7un/oZp0EthTaWDDj0zIDBVCgFQvFL9ItdEW7h4L9HFNGsMJUDbu4uvS6xfb
	tOea2AiQpSLIPzvfTedtjiosrRrgz6/9Zb2TCI15CgWx+GMhQ7h07gc8M0FZPCdR
	GNSOXJLJ9S74Fh1Jwh37raoXVoGp8buj6ROOYHtSh5h//yVscJdTJ0RbzJi2k2Qc
	BVnnS/cX0/5pIp0eXM9Au+GY6hcMAeg5BqLPw1DEYN8RBscq7NQg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4921d1rku0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Sep 2025 15:51:26 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58CEUImX030773;
	Fri, 12 Sep 2025 15:51:25 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012046.outbound.protection.outlook.com [40.107.209.46])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 490bde0ecj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Sep 2025 15:51:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fua1oWOW/1ta4rEz2hfYS4kvGkb9KXt3CIbxJ7bn+cnLikW1d3ywULYcitvav9aHd1UUQ6S8rrCSYbFYVXLY5YU76kx51kk1ITUfWidJKfnWY3bnlvglgfCWSMAaGKv89KzhYbTctdxuzKpybFuPqKTJrbKugXU0Qvjof2wI4RECYV3q+AduOjXlXTEq+rAn9Kp+a1o1lptM42+kwet4koT86ezuvfH1e6C2AZu9j5BNas1530UtOt1aOi3TvT/FinZGpwfibJfz86QfRKBayX+1PhtFMl8oLF5aQdsTmIZW2T3W/zyHmEkMn2txCKQgxHrZq9y8SvwZXEjRKklmfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TOYWVsHIDcKkn2u5RbcQl4wzLE20TNCrgBJG8VuJzv8=;
 b=Q+7UNzhf7eyJRxhEAbIREzZjVXESnQh28qVZQ3yw/TjReUgp1XnQL92qfSPz6yxF4v8MED+QVD7LJRs9RZgMBVoULLdJ0hdVfvbhpQ1OPiYsh0xxa2x5dnsVhtCX7w2qZeuDLmN34jUQNCMW4WSGFy9JY0LtJtHzAwbn9GIPJ7Sl0D1uXf+Qlt+uxVee9iXgMCHozIDue52tQExl4L2x0DwZjYtimF2nHq1acYUannxQbluYeGoYIZlsO9+aZf7c2+qgMzYg3vD64Zu+DbLLLQwAdJpVb7WsgJrsFABhVSc7Xx26BXOfj9uC1sgYWGQGoxRKzi/g+qeGGrQUdo7bkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TOYWVsHIDcKkn2u5RbcQl4wzLE20TNCrgBJG8VuJzv8=;
 b=NLJqudgmBfjFJJUy/AtLKrT9HhgfxdC8kOg44oa03WVx4U3500dNddVPOnr5YVZAPmry49khaMaVKYJfHJVen2p57h4b55AP7wMrwhaaexljfGnRd0HUXVuCUOKjk+zXpBkZ27vhLkgq8u8620NLBuvw+plR6X0S+lMBxl5RHrQ=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CO1PR10MB4705.namprd10.prod.outlook.com (2603:10b6:303:96::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 15:51:22 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9094.021; Fri, 12 Sep 2025
 15:51:22 +0000
Date: Fri, 12 Sep 2025 16:51:20 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Kiryl Shutsemau <kas@kernel.org>, Nico Pache <npache@redhat.com>,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        ziy@nvidia.com, baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
        ryan.roberts@arm.com, dev.jain@arm.com, corbet@lwn.net,
        rostedt@goodmis.org, mhiramat@kernel.org,
        mathieu.desnoyers@efficios.com, akpm@linux-foundation.org,
        baohua@kernel.org, willy@infradead.org, peterx@redhat.com,
        wangkefeng.wang@huawei.com, usamaarif642@gmail.com,
        sunnanyong@huawei.com, vishal.moola@gmail.com,
        thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com,
        aarcange@redhat.com, raquini@redhat.com, anshuman.khandual@arm.com,
        catalin.marinas@arm.com, tiwai@suse.de, will@kernel.org,
        dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org,
        jglisse@google.com, surenb@google.com, zokeefe@google.com,
        hannes@cmpxchg.org, rientjes@google.com, mhocko@suse.com,
        rdunlap@infradead.org, hughd@google.com, richard.weiyang@gmail.com,
        lance.yang@linux.dev, vbabka@suse.cz, rppt@kernel.org,
        jannh@google.com, pfalcato@suse.de
Subject: Re: [PATCH v11 00/15] khugepaged: mTHP support
Message-ID: <c5bcecb8-13e7-4db5-849e-2120c69b2af5@lucifer.local>
References: <20250912032810.197475-1-npache@redhat.com>
 <ppzgohmkll7dbf2aiwhw7f4spf6kxjtwwe3djkx26pwy4ekrnd@mgeantq5sn2z>
 <43f42d9d-f814-4b54-91a6-3073f7c7cedf@redhat.com>
 <ab8c2e03-53fb-402c-a674-c2c6ab11f54e@redhat.com>
 <rapl4xr55zv2nq3jh5ulk4wvfyxa2kmbnnb4uram6q43y4cbwn@dv5m52ocyqne>
 <80c50bf4-27b1-483c-9977-2519369c2630@redhat.com>
 <7ri4u7uxsv6elyohqiq2w5oxv4yhk2tyniwglfxtiueiyofb3n@l4exlmlf5ty4>
 <59641180-a0d9-400c-aaeb-0c9e93954bf5@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59641180-a0d9-400c-aaeb-0c9e93954bf5@redhat.com>
X-ClientProxiedBy: LO2P265CA0230.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:b::26) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CO1PR10MB4705:EE_
X-MS-Office365-Filtering-Correlation-Id: 21665b46-8f3c-41db-135a-08ddf21438cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NDsmkKR6l9px3QRwwYS1tULRRc+glS97G+Sqr1tymZgjh+W5qLCeTjxSZwnD?=
 =?us-ascii?Q?cAB8g2x5CPpBDpWHRyaCvlPp9l8vVm4tkz19COgy46ZGcvzvk1EGnG6GlKO7?=
 =?us-ascii?Q?/kqzYyqOfja9hPtEl8pdiquUWhz9GefdY9KzflZLEH5mRFZI/wYjM/LJcW+5?=
 =?us-ascii?Q?yrdMD1Ju3+7OzBHRsmoCr+jYYgfkYauhWXxS8IxDl2vMBmxp7pqibhWjom7P?=
 =?us-ascii?Q?ENJSQeKHoAMQyQWFCYbRLLQu1q7c2kClIZIZXyLN3k9HYKzsWKtu9KDsKCVV?=
 =?us-ascii?Q?7A0eZ4Gw0d7FldVgAjU+NyoUc7dXN+maBDw9MLUReEKfGK7O4mpTi3zYMpn/?=
 =?us-ascii?Q?xZEVC0HapOgk8U4LLe4TnZ3abC+hGWgfOSZxMkes4rIwS8VQ9RAzMdgpfZtW?=
 =?us-ascii?Q?4hMpM1y0NOqDAuid9k/QQlx3HXlkUGfzGGsOR96l+jaLuea1Z1nzk/b6/Mte?=
 =?us-ascii?Q?CX/Xsk4a71N9339sU5AeMRHAQpZkEdSQfbH9NlbO0hV2kaN4HTVo5PIReJol?=
 =?us-ascii?Q?ZH/LfN27HsYya7fwZGfEX21W8bWeWEWaeafeXX1e+iXD3Zy+xK76wbf4g5N+?=
 =?us-ascii?Q?2MyvROQfm0J1ubZx58WonoRYhATIBkzj8qTqkP+1LDx5dBbjLFa64QeRQ2TD?=
 =?us-ascii?Q?PRiv+go1hArXOOqhgnnvFv5OiwFSKHsAZsDUHFCWxJ/mvxaDL8LBNYWj1H7p?=
 =?us-ascii?Q?Ktz7q97A0Z0L8FlQPDq64+52DZOoTizABvRBYDaIMkpGI1u9wczQytB/glGW?=
 =?us-ascii?Q?R8ORxS4ZHFC+xJfUPQhBCNLFcAmjf9/+2c0EFAjMNS02joDFZVKKwsI3V26P?=
 =?us-ascii?Q?iRkFRDJclFLbLpoKRglq4eCDcvKk9LmxW8j2YCJwSC9kl/2s7dSh8XKn7Oqh?=
 =?us-ascii?Q?pq/kS0XqUdiI82naaIYz8JDFS9It71ZUo7CtLxkTjxTsPI/j32obuzZ0jlo4?=
 =?us-ascii?Q?ypB8pG2GLSkmvxJXaQ7WYOTe2tK6C/vs5KfY3BPiPOJDIDKyqoqK57dBwsD3?=
 =?us-ascii?Q?0pqKLwnZVNNcUJ5YHykYmnPr2LiNfFAGx5rJg3Pl56/ue3qW5hlxSt8OK99b?=
 =?us-ascii?Q?fQLfQFTiXODa0jpzSD73m0f8GMwst2pk8u83SMqjoGY98ReiEZAK8TAP2hwA?=
 =?us-ascii?Q?6UKfwqSsYjrnS5ihdfB5bZ7XhDVtvz/OW0EhvNI1OLcd7EfGAscAs/AhiJyu?=
 =?us-ascii?Q?141Kv55ekbFvRYSR/3Z+AOXs79SCz4gKkowYnDjIQMvRztzTNBN1pO/Hez5l?=
 =?us-ascii?Q?VHRuyZDkW9u5MOpzKe6aye4FwhGDQrlPAUKvQ+64x1WpBBDzQRGuBlx7s0hw?=
 =?us-ascii?Q?9r6xYKBDwHjUyM0G9olLsjsylGIGzq7GzwLQG3kzgMX2h3bCuTw7uhpPAgl2?=
 =?us-ascii?Q?o+kEQMXZPdexH27P9KQbMuzS/TUY43ozZPSIe5WRXxlOkXM+5Ux/VzXvJ1nn?=
 =?us-ascii?Q?bGawJjsqoyw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/5rIX9UQc+GaZV7AVMsf9eE4ea/Lug7weRHyQCt2uj/48mE7xGh8KkcB5y0b?=
 =?us-ascii?Q?eQX8gRGGtX9c0sDmppnH3bfQGVj4DRwrrMEpqN2g7/Pgl+8Hz8HPqSd5/0Zd?=
 =?us-ascii?Q?L381c8rUXkd9FVnXGRZjGRK+4nRidqNc6/mznZHmaWbANdFdYirUB201tt/G?=
 =?us-ascii?Q?Vwc6VTD4TVmXh77/YjxXWSzKLrLp9NnyKlFnDRU9zeVu90ZcDYACp1RhVGNT?=
 =?us-ascii?Q?Y+r7zAXM1v2vrUoL22shvxEKZ7PjhR71XmKwvuG7ohNo+a9DkSvIuzEffmkI?=
 =?us-ascii?Q?owQriV8RrNNDfMPBpMJPrzuWWCS0ctbEr4Q6whEUDWMm6jQVI9tocSQaGC3O?=
 =?us-ascii?Q?k4a4FOptGqQfpyvMmD+2F3VIyHEiaJHFwSLu7ktupvK3b5jt0z/a+S0vmj+4?=
 =?us-ascii?Q?D5cEpnyb9HcuQ3W+YXwQiA07T9PqlrxSJTgWjWp/7YrdQrVkvv+172VC+/6G?=
 =?us-ascii?Q?3gdzyljUZYX56VVeFVbv5feQmMtXRC6j2PC10G825J0CEJMb3cAbgx399pig?=
 =?us-ascii?Q?T0Glmul4xq+2nhjXmm/rXHvF9co6zGzIoyiVqiO2cXHIfSKWwuCjvv7hq4lw?=
 =?us-ascii?Q?MUVQS13LmTimvXkSstLuXxCgZjTyAjeeln7CxBFOggRKqO36A3QWGqgHDJ+T?=
 =?us-ascii?Q?2075g4GzhLYtaMNrA1nrqwsDkCoIgWAhlaPWuSzfNaWryG5OIxFXRWx4OqL3?=
 =?us-ascii?Q?YhitNiaJ/GOM4xyLt+C01VyDweEMT0ldhtgTWJUYAMe1dyOyROxU6NYS24rR?=
 =?us-ascii?Q?vvvFQ7QHRcVaNyzLaaN0nnCUcLopVnZg+8SPuUyxMMgrXU0nUzZAxPuovfDf?=
 =?us-ascii?Q?z360RhUJRni7t7mJSzr7F6PULyFhS/aJKSvSmtX7gNxauhPvaDa8DmjmS13K?=
 =?us-ascii?Q?2K+7ST9eWH9eoGg8MKEOLWHjS+dLt3fvcL8oUrWjQcUg3KxEZ4eMZXLOagb7?=
 =?us-ascii?Q?pS/zReMvya7oX4MW0/cppljIbVgk8j/pm3BdFa/ggfCtqpMPzaEV9ul/JLwM?=
 =?us-ascii?Q?1oRWBZpRoKr4/ojyqsLzJyKj7oNQYFhhWGuUUOJah1I79pZuFBCJDDtiV7tm?=
 =?us-ascii?Q?U6ITOgBu1VFqg6RirqljZLXcT2AZ0MuansEHfestYsk+xCYT2vsfy60wYh62?=
 =?us-ascii?Q?vt063cUAEEM8yIuD6vXeC8LoCnaYLdwzJDqmqs64SlsmcWluq7DlNtW22Z0d?=
 =?us-ascii?Q?YgOZ8wrtIxK71HZZ8l+Bv3rEH6SHDCjjCXIss8Gq5HB2/lQwYTZCLvwuqqn4?=
 =?us-ascii?Q?ufGQFDIFhXnU/6hx2d9qRjnx8xbHemgrj06BbwdXJTZ812Zr9ziKde4Yd21U?=
 =?us-ascii?Q?NDIFFtOrVNYtFyCPIU90Uc0lyJigGYGb0+cWGGKKiG9SkLXo1rV9FRxggkBt?=
 =?us-ascii?Q?ZkXAHScA7qWfesPSXOGMH1riqA1+CxshgqFAy+YPKAyo79pZ1mqphqpnYGgZ?=
 =?us-ascii?Q?PC5psCS6Mji/l3JfHeRZfgCN06IdaaRmT8zKxDExxIt8CjW8yAUouKmsGs/w?=
 =?us-ascii?Q?SPjq/qAza1O2LSOMVkP5k6Z3RrpsgCPRtl7jVQddx89vVK6MVSP3R4xqUh+J?=
 =?us-ascii?Q?24S7zjzZxgzsUNuoS7h3oPaxVAq+5Eijngrlrz2Y0R1c+aRR4HdNdjeIqG+d?=
 =?us-ascii?Q?UA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	k4PmReoy0Rxy2g8/t3OlAaXde5/QCaGrdAlE2syKR20ihXsfi87bRC+TDcDk7O4h6JZ4AiekFw8mv2sQe2qLUbjSxQwGeFcCIFNk69dJqh8hCXRrmQBUobeK9gWhW6omYebWXWL8AIlk1ii+pEXK9YbgwozE+Jq9zKOPiHZWXC4UuLXDrHsyCJsNj2TQB5wb8Blx4RvPvixi2+7spUG/pXQOr8jNvO8SE1u85qL4r0cyNEx3hSKk/2NRxsKtLZ/7acbgvIFtgbeqpHI0ZLJCxZ7PPGkHB7KaBQjU6E/+C1laOLr2Pwh/09Lszk+P9x67kvjxrWe39fVq8QQebD+rT/GPKw2naJ3SozgUiZOzSnxkT6QhfXiaKdEeV5bMxLTk5njCCZbJKfo6u9VRyXhUiqu+yuphpxjJ7s5lg+K/uT9rhC3X7at9KUJbrtHxqoUic8UEQ3+jFaV9HG6fMcNlTt2DY7pgqS+G1t+AIJZeDudk5QK6a9H/cGEEKXYqI2Czpa+wJbPj+tM4iqIOV34TYWuqYncXtFVqQNCKGXx089bfsG7kqcGrlNVkWKirdgB4gqj3WAkWgdpk9QHkKrEvwe49kHIchyjvzJpa0+vFgqc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21665b46-8f3c-41db-135a-08ddf21438cf
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 15:51:22.4457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I2YKNsSIUTX4FS5T1+AFdAV5+LVcGurwU+ycPRcojv4g6K3vlMQ0wuhNcBVHWAkNae056wfbWa3KQ0Cr1mK6SMAT7Hkx86FjejHpHrBUrLY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4705
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_05,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509120147
X-Proofpoint-ORIG-GUID: lcccWJNWUTfFouZMoC__93KZ59il1GWz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1MCBTYWx0ZWRfX8e2Ynx9BQNrJ
 9QTJCRdUBdb4CUnr+vUNbLqbP97nY9AQ2C0peKVpKo1UWfdcWh8bXCfDT76mWt6meJ5Iqg2L98O
 p+HOAoYYUlgneo+BdQbTW6TcWOv38nX4j374eC5b79RGihYGT2FAMycYBDhiCQ+X0RcS5kNIUDG
 pvFFvj/+9C6DVcpicCmTbqMYTNDNQ27A8aPcW/XGe0TEDlJOcEZG4yv50btv1M1Ig2B3HXL6LUK
 MnRNzyPTddFxxWQStbb8dG+MaxT4UfORi/iGAE7yoaLEGV/JYZN99DtUZ3rQfihRkXKk6PVFdDY
 lDjzjKUB5MTJbTdxSIXoALhAIbHonq+qOsA54aWja+VHtMlJsqWAqh2hSyp2RbNWPILeV8fsfvD
 1u0bUb4p
X-Authority-Analysis: v=2.4 cv=d6P1yQjE c=1 sm=1 tr=0 ts=68c4417e cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=hOC1VH-gHVWQEx6s-agA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: lcccWJNWUTfFouZMoC__93KZ59il1GWz

On Fri, Sep 12, 2025 at 05:45:26PM +0200, David Hildenbrand wrote:
> On 12.09.25 17:41, Kiryl Shutsemau wrote:
> > On Fri, Sep 12, 2025 at 04:56:47PM +0200, David Hildenbrand wrote:
> > > On 12.09.25 16:35, Kiryl Shutsemau wrote:
> > > > On Fri, Sep 12, 2025 at 04:28:09PM +0200, David Hildenbrand wrote:
> > > > > On 12.09.25 15:47, David Hildenbrand wrote:
> > > > > > On 12.09.25 14:19, Kiryl Shutsemau wrote:
> > > > > > > On Thu, Sep 11, 2025 at 09:27:55PM -0600, Nico Pache wrote:
> > > > > > > > The following series provides khugepaged with the capability to collapse
> > > > > > > > anonymous memory regions to mTHPs.
> > > > > > > >
> > > > > > > > To achieve this we generalize the khugepaged functions to no longer depend
> > > > > > > > on PMD_ORDER. Then during the PMD scan, we use a bitmap to track individual
> > > > > > > > pages that are occupied (!none/zero). After the PMD scan is done, we do
> > > > > > > > binary recursion on the bitmap to find the optimal mTHP sizes for the PMD
> > > > > > > > range. The restriction on max_ptes_none is removed during the scan, to make
> > > > > > > > sure we account for the whole PMD range. When no mTHP size is enabled, the
> > > > > > > > legacy behavior of khugepaged is maintained. max_ptes_none will be scaled
> > > > > > > > by the attempted collapse order to determine how full a mTHP must be to be
> > > > > > > > eligible for the collapse to occur. If a mTHP collapse is attempted, but
> > > > > > > > contains swapped out, or shared pages, we don't perform the collapse. It is
> > > > > > > > now also possible to collapse to mTHPs without requiring the PMD THP size
> > > > > > > > to be enabled.
> > > > > > > >
> > > > > > > > When enabling (m)THP sizes, if max_ptes_none >= HPAGE_PMD_NR/2 (255 on
> > > > > > > > 4K page size), it will be automatically capped to HPAGE_PMD_NR/2 - 1 for
> > > > > > > > mTHP collapses to prevent collapse "creep" behavior. This prevents
> > > > > > > > constantly promoting mTHPs to the next available size, which would occur
> > > > > > > > because a collapse introduces more non-zero pages that would satisfy the
> > > > > > > > promotion condition on subsequent scans.
> > > > > > >
> > > > > > > Hm. Maybe instead of capping at HPAGE_PMD_NR/2 - 1 we can count
> > > > > > > all-zeros 4k as none_or_zero? It mirrors the logic of shrinker.
> > > > > >
> > > > > > BTW, I thought further about this and I agree: if we count zero-filled
> > > > > > pages towards none_or_zero one we can avoid the "creep" problem.
> > > > > >
> > > > > > The scanning-for-zero part is rather nasty, though.
> > > > >
> > > > > Aaand, thinking again from the other direction, this would mean that just
> > > > > because pages became zero after some time that we would no longer collapse
> > > > > because none_or_zero would then be higher. Hm ....
> > > > >
> > > > > How I hate all of this so very very much :)
> > > >
> > > > This is not new. Shrinker has the same problem: it cannot distinguish
> > > > between hot 4k that happened to be zero from the 4k that is there just
> > > > because of we faulted in 2M a time.
> > >
> > > Right. And so far that problem is isolated to the shrinker.
> > >
> > > To me so far "none_or_zero" really meant "will I consume more memory when
> > > collapsing". That's not true for zero-filled pages, obviously.
> >
> > Well, KSM can reclaim these zero-filled memory until we collapse it.
>
> KSM is used so rarely (for good reasons) that I would never ever build an
> argument based on its existence :P
>
> But yes: during the very first shrinker discussion I raised that KSM can do
> the same thing. Obviously that was not good enough.
>
> --
> Cheers
>
> David / dhildenb
>

With all this stuff said, do we have an actual plan for what we intend to do
_now_?

As Nico has implemented a basic solution here that we all seem to agree is not
what we want.

Without needing special new hardware or major reworks, what would this parameter
look like?

What would the heuristics be? What about the eagerness scales?

I'm but a simple kernel developer, and interested in simple pragmatic stuff :)
do you have a plan right now David?

Maybe we can start with something simple like a rough percentage per eagerness
entry that then gets scaled based on utilisation?

I'd like us to ideally have something to suggest to Nico before the next respin.

Cheers, Lorenzo
