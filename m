Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307561B6D06;
	Fri, 16 May 2025 17:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747417460; cv=fail; b=paQqF61r93CbU4GYRvu+vbUN/D06UGcI+fPuo+BCBFVZuCHx+FEwyCEf95dFa0I169wcKAuGSmDAE3NSJBIWdnQJ+KuYdjVOeIk5sorl/gcn6ydXuEaFzs798EEP33Wbs4syrOJe9x2EpsHoa9ELekGPlThrC8QafGLLxh89yno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747417460; c=relaxed/simple;
	bh=jil/s9HxckpSjj+PCtjiqrPyX/nihB01/YhedOc7AnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EDaKfwrscb2tshXP6Sfg3MzROl+FW897fz87BmkyfxYx5hDyyZYuRTmOGSxi6IlDWlluM58Rc/6HaV2QwQCmheKNQsneTgMXTnJ+UakOwoUlIv2aTDlNFi9HV0H1pknj66tWzb+CiLkM1vfaoSsKI35YSABpZG0OTYlKEo5NTbc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EPuMpLFv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BdKudmPZ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EPuMpLFv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BdKudmPZ"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54GGfpjp022507;
	Fri, 16 May 2025 17:30:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=prxmMZlpafAT+/wNdY
	UF/UpSvHvwBZgKhHHNmCA9Mjc=; b=EPuMpLFvtW+niseXV++bSmW80Lt1odLNKx
	Mxu0z/cSl5j2hjkw72wzco11BT/PrV3YpP54zT4C/LN3FTRsHGlavZYv4jE+OUml
	LbA9xQMk/pea2qSQ7ntkVl3v6uoZE5xCAKNJfCapJ4I1kjppU5Rv3cXEeY6+JXvX
	EUfsZNotYPXoFLJFVnEFXfRG2JymB/bZBAw6M5i/o7jI1UED5m0ErpmwY61DWtUq
	nSGzqi+HjLGzYSSMjhSZDnH7mDa5YULprr3z3PdRbiySkRulYD+WYbfNQOzeU5/f
	lBCoaXHffWO4pqzLxEI5wrNBDZpiu+f4Oki7BqVdWDlOA/cWj1Xw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46nrbf1ud2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 May 2025 17:30:21 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54GFkRPd004269;
	Fri, 16 May 2025 17:30:20 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46mrmfm68p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 May 2025 17:30:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X0iq7rjzT3bC+XQcSI642H8lI0+HJVtmRDkpNMgN+BgFwqSDuXtxoWMnf/WRmda1jchNVTpjgNiCNaFBxphkAT0BFv747gSwTY8kM4G71gt6JiqhW0YTn+E5ZaLUchIhSLMzwXHCQr79ATRZIG3qaR5+nWIjmZoPTDrqbPZeSV4QkKc2lnvAoqZLZuCNHeQHEjb/X2TI2qksSlDJe1d4JdTHb7U7Tk1QmAFP2Z4ydCWIXAsO0ncjpAjD28Xb/wBP/bNrXHTcgSKtO/5TGWuFXz9jz7Vpf/M51uE56SbL4QOpRCKQNHUmfXanK/Wzp8NRcnZHEuKvd3SDBdAxjDeE9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=prxmMZlpafAT+/wNdYUF/UpSvHvwBZgKhHHNmCA9Mjc=;
 b=NgfRxp87bBtXasv10or7HU+c60igOv0p/Qa+0r9RZ5MB2t/siXSvRm3heHj93nRdpC0bdjUKQedv9plxYW+BPUqvm8Tn/rMIbyJ/yJJ070mV046MZlNc6UALagalSi5FIk35dz+gdev0CsoG+8MQsEkJoXwhGOw3DmYE2bRn2tsFYoJDbCp1gibILk6ea83cw5YU4Cjul4VFCsH+GgaqINXPQwwS4qZdzw/N5fK1IT76/io8GKqWfyWHYlEtQRCEW8qMdcslxMw9nbIcU5pJGD9W0wSieT5VwNi6cywde47Y8V1mNMMBk5duTg7HbuNeDoE6748Sk+smD22xArdFnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=prxmMZlpafAT+/wNdYUF/UpSvHvwBZgKhHHNmCA9Mjc=;
 b=BdKudmPZXXhnQ4XCS1cMYtEImiHkM1U5mov/hyh0qYnOVwUl0wumSTXFKsomnCtgBBl4ng6q2+ixnmATqRSoPpBatzH1BCBhut6s0GN9CCJfoQQVzw7bf/0k4SD79eg7N0SEYii1vCnN/jgHxh5/RDJdkyPVPm6BEeG6HLBwX4o=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by SJ5PPF07759F8B1.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::787) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.31; Fri, 16 May
 2025 17:30:16 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%6]) with mapi id 15.20.8722.027; Fri, 16 May 2025
 17:30:16 +0000
Date: Fri, 16 May 2025 13:30:10 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Nico Pache <npache@redhat.com>
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
        lorenzo.stoakes@oracle.com, ryan.roberts@arm.com, dev.jain@arm.com,
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
        mhocko@suse.com, rdunlap@infradead.org
Subject: Re: [PATCH v7 01/12] khugepaged: rename hpage_collapse_* to
 khugepaged_*
Message-ID: <gsk47hv4pkqjstkb6mfiv2muon6yj3vp5rsho6rufq5qjfweow@scdzrvph5ah6>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Nico Pache <npache@redhat.com>, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, david@redhat.com, 
	ziy@nvidia.com, baolin.wang@linux.alibaba.com, lorenzo.stoakes@oracle.com, 
	ryan.roberts@arm.com, dev.jain@arm.com, corbet@lwn.net, rostedt@goodmis.org, 
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com, akpm@linux-foundation.org, 
	baohua@kernel.org, willy@infradead.org, peterx@redhat.com, 
	wangkefeng.wang@huawei.com, usamaarif642@gmail.com, sunnanyong@huawei.com, 
	vishal.moola@gmail.com, thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com, 
	kirill.shutemov@linux.intel.com, aarcange@redhat.com, raquini@redhat.com, 
	anshuman.khandual@arm.com, catalin.marinas@arm.com, tiwai@suse.de, will@kernel.org, 
	dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org, jglisse@google.com, 
	surenb@google.com, zokeefe@google.com, hannes@cmpxchg.org, rientjes@google.com, 
	mhocko@suse.com, rdunlap@infradead.org
References: <20250515032226.128900-1-npache@redhat.com>
 <20250515032226.128900-2-npache@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250515032226.128900-2-npache@redhat.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0330.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10a::17) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|SJ5PPF07759F8B1:EE_
X-MS-Office365-Filtering-Correlation-Id: e20014cb-7ffe-4d8a-3619-08dd949f5277
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5a1lCjRKrOgAquHpgnm8itoWZUOZ8hHZNADa2BJ2h/u5KlDFC49zI7anEp4l?=
 =?us-ascii?Q?76gT9z1jRpRQDwLwkmfKf49trzcxi7yqiP4Q+NMoa4HkjMEZjSLQp/KH8EQ4?=
 =?us-ascii?Q?FGCQAzAWRGz2u0K+AOMsNoJPS5txUU4qyni6NuBPqg0oyMzUeu7fbW++jEbC?=
 =?us-ascii?Q?4SlVv5r6+JfGGFK9IymsPkZDk7yNt8EKQ+znvfXn3CEV9y2n+VUAPxBDLIjK?=
 =?us-ascii?Q?WrecBXu2tcvwxVeY6ptakbJIKxKaKe2LaN6U5eerc4cNhXaUig+/rl9qqBBy?=
 =?us-ascii?Q?OjOcaha+bwXf6PmEL9hU8BLhJ2Naps0MvYJwcSHrAGF9UmCks2XebSM+JznS?=
 =?us-ascii?Q?h4wEEZaK/9kXOZHNfW22gvLGE15LYFXe7qBfHJScLIoq3hHo1KvXmxS1i9tV?=
 =?us-ascii?Q?GNy/zBbDmp1nVPQFnEV+SW0HqNKc61+d0Ss8TUU7q+0earxzrvTkc+91NLqV?=
 =?us-ascii?Q?2+PI77mKLSQx2udBpQWCai0ta3FfxwwPVnbGwNOZ/TZim6NLh7CICNUJS9DQ?=
 =?us-ascii?Q?kMDUdXWRXndbDbArYXZevLFEDtrNEONKterTbCIukLSC6e2Vg2U258Q1VZGi?=
 =?us-ascii?Q?RMhdGXS+JOtNNSrImAN9B5clnHskF+gWPPc8zcylY2MQrhpfOf6VHKmDGVTu?=
 =?us-ascii?Q?NbFK894fnD6T49qC1av2C2x9lTYZpS6MQCFuNvcOSjk8XwsWXRy3sPwlOEKC?=
 =?us-ascii?Q?E5iMLzAFdzXeox74ktYnCbd9GOPl/v2eilFZPI+EQDIz+jf2K1gpGb5PGDyj?=
 =?us-ascii?Q?/T82/9DBW+hfZIdQpjaQ1BOqCBu2cmkOGhp659m3XCAXW95ZGnWcjr8hj97p?=
 =?us-ascii?Q?Kg27MbOyC0i754wrq5Vv9Dog9/US6gBpD+9Mso3CIy2dMmUA0J1ek0SHbnq1?=
 =?us-ascii?Q?g6quqdAuV0bGLNu83WDp2lm97MOU/BYZJV5MnvvaU70/VQ1pujV8FUY3myhT?=
 =?us-ascii?Q?T22CwZcKtlH/fZxGZDL64E0vvc8So2QP5m3b2Olbktaja0E0UXj26KlJNyql?=
 =?us-ascii?Q?F8MOHTR6qTxl64X3TzRRpemSMOqFI8qlcZ9pRb7mHGftzgWlrSgkGckSYEgZ?=
 =?us-ascii?Q?30CDJmEJqctdPGBjRXTrXTuRSCDF5j52N5X2VZbSgarm9VKnDq/r0sZOh3wY?=
 =?us-ascii?Q?VACsgHO3iXrHAkW8G0cX961W/UgIMHXeOrFjcqbaitGnNvv5tR/E4Fq/uKVj?=
 =?us-ascii?Q?hrtp/JZnbr1jBRVhFYWGmnNQFU+CzgnSbcG3gTHSOktthQHLgJ+WJnKo0qEk?=
 =?us-ascii?Q?rS9moIhIwDJcyNcZ0awLrQDzuKuu1RXhcRxBHov1Jl+yn7UQ+JKoKekPaOWo?=
 =?us-ascii?Q?TDJ/WF+CIFTSLRQzRk4xZgwCfH4ZG/ZMCo7SowK5pZnQkhSe9vagGmRCkVn1?=
 =?us-ascii?Q?rSGjXnR6Ie/pFcL4H560ElohdwwhTJhSc9lQH3fFjz0q2BsTZL9fL04xoawr?=
 =?us-ascii?Q?dIsKtB7RV10=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Zdz0dDz/voGm0Nw9JOULIQfUxV4R9cmbnubm7gEqdNpaCvd0Wn89nj389t3d?=
 =?us-ascii?Q?uzZ2+oR6QWe9KAeNLtYVcpsst8tMGdkNUT3nicV0IMN62gP7kmfU1rbLtOKQ?=
 =?us-ascii?Q?oBOX/nHm8rpSUOIGXKyf9FJ4KNtvz9+TqNtWoll4MrI87Zg+IYuocGmFJiYa?=
 =?us-ascii?Q?MmM8+944z71tsORvKg5JJRMBRrxQ+HUo4Ja0+642gsYBWWXD9jb+F47H77os?=
 =?us-ascii?Q?FKMktcY5+91s0hokR7cmjOIMhz6waZaZlMhx8mgEvF5lPHXIr40VMrrINu6E?=
 =?us-ascii?Q?pzd4yQqKVjB+HwcZm6Mx3it9eep0hIjDClwrGJRoepO0bs4OypX6pNBbo5eB?=
 =?us-ascii?Q?KfNmI12kMIOfd5jrsrwcDzbFPE+ZTLvHnsbcXLrmy2MwQftDiDQlXWKF/68E?=
 =?us-ascii?Q?/IzAm1eQdU8wxhHaOy6hvSvqmjzLGjMilLnjRonOyZNIe1+LXNeOsNDnsN1c?=
 =?us-ascii?Q?a5lAUenkLpkkAqu5XcBW1/9e3D/6Y2I5PryGTtMPsQK7r/Q2JsJm4WBdA/fq?=
 =?us-ascii?Q?6/YhgG6muragS727NkiClJLctAgULLeb5k/9T1EsIWFDMALLaKwJflXp5O0v?=
 =?us-ascii?Q?I2xuZxZZjkbLvEVC8LsZW9oNltlNvyFUjq0YeBrULR7h2gZ1cK3ULFuphWyE?=
 =?us-ascii?Q?Y2eBQRuNInX1WxRyWJlXEvB2V+NepmM6GYr9XgbLIg+Xj5ltSdndsjHHWbPl?=
 =?us-ascii?Q?z+OZKlIp4HcXDHrfjAYYxN+fDmEOaPxaKhPcHIpsiNX6vCTgaX30ikgpPo2g?=
 =?us-ascii?Q?NC0mdaQ02bHPmRpTskLlh4fsqBBeDy3PUpXVhLQji1BQgzJdnhawJJ7/0CDc?=
 =?us-ascii?Q?qpBCTMIoYm6GPc+u/gzop277RsbGCwO4U2cp4P+E8fUBQLbDa2GQwzqx/zcN?=
 =?us-ascii?Q?Ccu2VDC/xAbMDwE5AcN9ITek1I6+8mZ+46JwbiCZBExwp6+lxoHKv79AES6q?=
 =?us-ascii?Q?0+V1W80tmoBKIIndMSuvxzIfBPd3EbIgutr8mxNgWmPJWk6mmsqSjHKXOWbp?=
 =?us-ascii?Q?3VKigwyNdk1jp5YQJQT8DD1ZX70dWCwQo90IHHONLt0i3mx4q2Lg7bQoo1Yt?=
 =?us-ascii?Q?hYvTmAWoNloTtWOmNMWiktsjjqNgXPYPjCzFX5HpXAhx4S6Yj+shEAYXvDUF?=
 =?us-ascii?Q?XYvoJaMP6jtkD0oVMKsRvL63e1bf+PDyyc7h2B16qRk5hizEDNzPIhD4ADdB?=
 =?us-ascii?Q?3EsSHYHgGv2Dfl750ZGaXgWAAIFZhXvzpBt3pogTShddkcLUMq05LuIQPisX?=
 =?us-ascii?Q?JgZp4Ls5LXmaqxrq7YVGWQky2HYL2coNUfqFUjYCpxzZxiis4x0CKFmpb2wU?=
 =?us-ascii?Q?XX9jCeGqU3jxld9SxIb7MDyhKIXppfDcqxdgqAT/mjZqIiTG4WklhFsik3XH?=
 =?us-ascii?Q?abjfFXQCth2OVHVvgJqzNKYUIwk9l9iU81lNGeONovl2NowKQrEc1wnvDASI?=
 =?us-ascii?Q?WYpf3II1CuA3Q1VsBncDZn9C6Gk26vXv5C/hD7Wtrtt6pOcm/5gOSPXkFBfj?=
 =?us-ascii?Q?Ga9zfShjubz76I0cWU5+Hx97bV2nRghmbjQZNbApDaqwoGJb59Pz6BQbgRhb?=
 =?us-ascii?Q?Gh/Q3dR6BvYncI8IDKwsK91XRO/EoMFe4Me+wfsW?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DOJNpeYbfHqHz2ELCEf2LjYTRS9NHYMV2TSP2iQE8DJaFV7haTiZLjFI8UoR8Ug8UZ0sxa8rJ0iagqyWfLaKO5sjkaYbzNajd7+dUZ8Y0l70UI0IcZgwRbwC2vo/ODkNoIovSjbb3/+YUzSqlAbbcyhY1zd7ubV3/tvP0l8aB2QNFfpsfeHe+LkC2SoofV9IU2+sG+QzRf5f0Ns9R/g10jtiXOU8SV5dA8DCafzvbE9iJWXoJM36W49m/ayTiF4McOJckgEoO1FwsKBFGTfqek0DuL2y6oKw/n5nPRf5B8iX7pfn0oS3w8s0D9fjgOyIwpF6Z3mRPaEjg9qLgYl9gc+blvhbwiZbuo79oJKb5KZC+EYWL2cFcFhEXyA8KMAQUC6WZDEC9P5LQkhle/9gcec5zvDfqmq6rLNU8AFs5lc2/9bi5j0zQ9YhlWpNvXoECf7/t3+kIkgGLw0bUvAi24qgZhCSSrq2/ak87yIXrd6xVmtI9aZktIq2FX5BBDdSww1YxAF8eDRkB641q/n7FGD6i3CZAZ4WuJBZwVexbm/6FECSu7UQO/w7j3wGsq7/CKPvXJj1mMVTKQ93CmrBGtj0BX9MfBrrWPMrAW9uq7U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e20014cb-7ffe-4d8a-3619-08dd949f5277
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 17:30:16.2787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q46KWQMt8grpNnsL4zsDgqiOP/t5AFniySg2NsYAHmGqDE0l2nrm2vLSxlM0KQ2y2yTpbIQ28j6/a+XyHcG4iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF07759F8B1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-16_05,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 suspectscore=0 mlxscore=0 phishscore=0 mlxlogscore=968 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505070000 definitions=main-2505160171
X-Authority-Analysis: v=2.4 cv=Xc2JzJ55 c=1 sm=1 tr=0 ts=6827762d cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=20KFwNOVAAAA:8 a=Ikd4Dj_1AAAA:8 a=SRrdq9N9AAAA:8 a=Co7ZSBH1HTZebSw_pVQA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE2MDE3MSBTYWx0ZWRfXxSGkP5YI7Tgv lPKXSSPgRh7xkIfz0KA+L038mchrrzehsQfG4/WGTjlwcs0pzIdpw40iY7oHxYg0IvM62mKWiZI iPi4rnoYVcEiv3EV+i4VNYmH5blH5xt+gCEtCmMoSSQE1zJkGrncd7x5RA81gPz/gBBumyPCKw7
 oibqPaxgW0BvndXzNGjZN4dyVlz+YNZB9cyPAVvgcZ+Q7Ktksa/22qBJboavqh0PCHGGN7Ay1Cz ScTs7579PxKPMHhz8B4lDU5CTSBjwDcqReGVJITxHPUbxl/dvuCSwof/+4KZ4OP0JmnUc/0uDae dp9dzUlojnV8uTLZY8g0NUwHUu2Zs/SS5J9zXfymtGipdhcwQHwTbs0AbfwqLlPbTti6K+0g7Bd
 9daBtHmNxFei7R3Gr+blR+SGE40NCOxrvf94sZpLMGPmYPUT265qI6V085/zKCREqnf6S1FE
X-Proofpoint-GUID: egWSohJfGpvOMVMIhyFTsUqst-G4iQ8b
X-Proofpoint-ORIG-GUID: egWSohJfGpvOMVMIhyFTsUqst-G4iQ8b

* Nico Pache <npache@redhat.com> [250514 23:23]:
> functions in khugepaged.c use a mix of hpage_collapse and khugepaged
> as the function prefix.
> 
> rename all of them to khugepaged to keep things consistent and slightly
> shorten the function names.

I don't like what was done here, we've lost the context of what these
functions are used for (collapse). Are they used for other things
besides collapse?

I'd rather drop the prefix entirely than drop collapse from them all.
They are all static, so do we really need khugepaged_ at the start of
every static function in khugepaged.c?


> 
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Signed-off-by: Nico Pache <npache@redhat.com>
> ---
>  mm/khugepaged.c | 42 +++++++++++++++++++++---------------------
>  1 file changed, 21 insertions(+), 21 deletions(-)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index cdf5a581368b..806bcd8c5185 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -402,14 +402,14 @@ void __init khugepaged_destroy(void)
>  	kmem_cache_destroy(mm_slot_cache);
>  }
>  
> -static inline int hpage_collapse_test_exit(struct mm_struct *mm)
> +static inline int khugepaged_test_exit(struct mm_struct *mm)
>  {
>  	return atomic_read(&mm->mm_users) == 0;
>  }
>  
> -static inline int hpage_collapse_test_exit_or_disable(struct mm_struct *mm)
> +static inline int khugepaged_test_exit_or_disable(struct mm_struct *mm)
>  {
> -	return hpage_collapse_test_exit(mm) ||
> +	return khugepaged_test_exit(mm) ||
>  	       test_bit(MMF_DISABLE_THP, &mm->flags);
>  }
>  
> @@ -444,7 +444,7 @@ void __khugepaged_enter(struct mm_struct *mm)
>  	int wakeup;
>  
>  	/* __khugepaged_exit() must not run from under us */
> -	VM_BUG_ON_MM(hpage_collapse_test_exit(mm), mm);
> +	VM_BUG_ON_MM(khugepaged_test_exit(mm), mm);
>  	if (unlikely(test_and_set_bit(MMF_VM_HUGEPAGE, &mm->flags)))
>  		return;
>  
> @@ -503,7 +503,7 @@ void __khugepaged_exit(struct mm_struct *mm)
>  	} else if (mm_slot) {
>  		/*
>  		 * This is required to serialize against
> -		 * hpage_collapse_test_exit() (which is guaranteed to run
> +		 * khugepaged_test_exit() (which is guaranteed to run
>  		 * under mmap sem read mode). Stop here (after we return all
>  		 * pagetables will be destroyed) until khugepaged has finished
>  		 * working on the pagetables under the mmap_lock.
> @@ -851,7 +851,7 @@ struct collapse_control khugepaged_collapse_control = {
>  	.is_khugepaged = true,
>  };
>  
> -static bool hpage_collapse_scan_abort(int nid, struct collapse_control *cc)
> +static bool khugepaged_scan_abort(int nid, struct collapse_control *cc)
>  {
>  	int i;
>  
> @@ -886,7 +886,7 @@ static inline gfp_t alloc_hugepage_khugepaged_gfpmask(void)
>  }
>  
>  #ifdef CONFIG_NUMA
> -static int hpage_collapse_find_target_node(struct collapse_control *cc)
> +static int khugepaged_find_target_node(struct collapse_control *cc)
>  {
>  	int nid, target_node = 0, max_value = 0;
>  
> @@ -905,7 +905,7 @@ static int hpage_collapse_find_target_node(struct collapse_control *cc)
>  	return target_node;
>  }
>  #else
> -static int hpage_collapse_find_target_node(struct collapse_control *cc)
> +static int khugepaged_find_target_node(struct collapse_control *cc)
>  {
>  	return 0;
>  }
> @@ -925,7 +925,7 @@ static int hugepage_vma_revalidate(struct mm_struct *mm, unsigned long address,
>  	struct vm_area_struct *vma;
>  	unsigned long tva_flags = cc->is_khugepaged ? TVA_ENFORCE_SYSFS : 0;
>  
> -	if (unlikely(hpage_collapse_test_exit_or_disable(mm)))
> +	if (unlikely(khugepaged_test_exit_or_disable(mm)))
>  		return SCAN_ANY_PROCESS;
>  
>  	*vmap = vma = find_vma(mm, address);
> @@ -992,7 +992,7 @@ static int check_pmd_still_valid(struct mm_struct *mm,
>  
>  /*
>   * Bring missing pages in from swap, to complete THP collapse.
> - * Only done if hpage_collapse_scan_pmd believes it is worthwhile.
> + * Only done if khugepaged_scan_pmd believes it is worthwhile.
>   *
>   * Called and returns without pte mapped or spinlocks held.
>   * Returns result: if not SCAN_SUCCEED, mmap_lock has been released.
> @@ -1078,7 +1078,7 @@ static int alloc_charge_folio(struct folio **foliop, struct mm_struct *mm,
>  {
>  	gfp_t gfp = (cc->is_khugepaged ? alloc_hugepage_khugepaged_gfpmask() :
>  		     GFP_TRANSHUGE);
> -	int node = hpage_collapse_find_target_node(cc);
> +	int node = khugepaged_find_target_node(cc);
>  	struct folio *folio;
>  
>  	folio = __folio_alloc(gfp, HPAGE_PMD_ORDER, node, &cc->alloc_nmask);
> @@ -1264,7 +1264,7 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
>  	return result;
>  }
>  
> -static int hpage_collapse_scan_pmd(struct mm_struct *mm,
> +static int khugepaged_scan_pmd(struct mm_struct *mm,
>  				   struct vm_area_struct *vma,
>  				   unsigned long address, bool *mmap_locked,
>  				   struct collapse_control *cc)
> @@ -1378,7 +1378,7 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
>  		 * hit record.
>  		 */
>  		node = folio_nid(folio);
> -		if (hpage_collapse_scan_abort(node, cc)) {
> +		if (khugepaged_scan_abort(node, cc)) {
>  			result = SCAN_SCAN_ABORT;
>  			goto out_unmap;
>  		}
> @@ -1447,7 +1447,7 @@ static void collect_mm_slot(struct khugepaged_mm_slot *mm_slot)
>  
>  	lockdep_assert_held(&khugepaged_mm_lock);
>  
> -	if (hpage_collapse_test_exit(mm)) {
> +	if (khugepaged_test_exit(mm)) {
>  		/* free mm_slot */
>  		hash_del(&slot->hash);
>  		list_del(&slot->mm_node);
> @@ -1740,7 +1740,7 @@ static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
>  		if (find_pmd_or_thp_or_none(mm, addr, &pmd) != SCAN_SUCCEED)
>  			continue;
>  
> -		if (hpage_collapse_test_exit(mm))
> +		if (khugepaged_test_exit(mm))
>  			continue;
>  		/*
>  		 * When a vma is registered with uffd-wp, we cannot recycle
> @@ -2262,7 +2262,7 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
>  	return result;
>  }
>  
> -static int hpage_collapse_scan_file(struct mm_struct *mm, unsigned long addr,
> +static int khugepaged_scan_file(struct mm_struct *mm, unsigned long addr,
>  				    struct file *file, pgoff_t start,
>  				    struct collapse_control *cc)
>  {
> @@ -2307,7 +2307,7 @@ static int hpage_collapse_scan_file(struct mm_struct *mm, unsigned long addr,
>  		}
>  
>  		node = folio_nid(folio);
> -		if (hpage_collapse_scan_abort(node, cc)) {
> +		if (khugepaged_scan_abort(node, cc)) {
>  			result = SCAN_SCAN_ABORT;
>  			break;
>  		}
> @@ -2391,7 +2391,7 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages, int *result,
>  		goto breakouterloop_mmap_lock;
>  
>  	progress++;
> -	if (unlikely(hpage_collapse_test_exit_or_disable(mm)))
> +	if (unlikely(khugepaged_test_exit_or_disable(mm)))
>  		goto breakouterloop;
>  
>  	vma_iter_init(&vmi, mm, khugepaged_scan.address);
> @@ -2399,7 +2399,7 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages, int *result,
>  		unsigned long hstart, hend;
>  
>  		cond_resched();
> -		if (unlikely(hpage_collapse_test_exit_or_disable(mm))) {
> +		if (unlikely(khugepaged_test_exit_or_disable(mm))) {
>  			progress++;
>  			break;
>  		}
> @@ -2421,7 +2421,7 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages, int *result,
>  			bool mmap_locked = true;
>  
>  			cond_resched();
> -			if (unlikely(hpage_collapse_test_exit_or_disable(mm)))
> +			if (unlikely(khugepaged_test_exit_or_disable(mm)))
>  				goto breakouterloop;
>  
>  			VM_BUG_ON(khugepaged_scan.address < hstart ||
> @@ -2481,7 +2481,7 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages, int *result,
>  	 * Release the current mm_slot if this mm is about to die, or
>  	 * if we scanned all vmas of this mm.
>  	 */
> -	if (hpage_collapse_test_exit(mm) || !vma) {
> +	if (khugepaged_test_exit(mm) || !vma) {
>  		/*
>  		 * Make sure that if mm_users is reaching zero while
>  		 * khugepaged runs here, khugepaged_exit will find
> -- 
> 2.49.0
> 
