Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFB122B5A3;
	Thu,  8 Jan 2026 16:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767888498; cv=fail; b=hU9PHE2FxADQLg22PZb6WV2TQ/q2FYKK/OUo+XmBkAgn8W9z+9hPx3l7mfb5EW/UjiQClJSvsgQWiCF80MvUpQyAJJ8C+c69Qb4iQ6KkM1GgOD4zSZsYtp3qs/sDfY4HtRL6UdfIdz/RryBVLWwY/q679SJCZtntthmUMpRcCmQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767888498; c=relaxed/simple;
	bh=h7jJqs5F83MF8puBbjclvWQHp6YsLuZZMse6i9uonKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eMzl3O/oo9gHNy+7qIciUGn7uxzh72pkmPyP1X9y4fp5+Te1hXx4iQZFGzGO91oQloqv2l+D/9Vt+NRH5/kJjFM/gR2DZ+d32rFxUURtyqak5vfozw2mCRP8XHHSWq4ODOnyuAdp6cddZnUR2xlOSIX8hcc0Mly07BkyQcw0iM8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HCjmg/50; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZRZlqBxc; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HCjmg/50";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZRZlqBxc"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 608E9uYG284757;
	Thu, 8 Jan 2026 16:01:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=LQcJr9uMKNDv9T3Tpo
	lsnL4aClJGNdhK7SChGlhJ0oc=; b=HCjmg/50vyp0FT1jb80mbEIZ6/t68E84fb
	qr2jfkjNvYGe5ykQITEz+EFvtfOCoptU9Kkqz1pU2Z4HYi6RlsHX8zrEYM4BWMy+
	dCycZqxGnbAEU2EZMlXb/XWinKJ49kNT9WDgMYet7m69yqyjonZblwGZSFkbdLf0
	nMUkQ210h8SeBTLcnpJ1LoTDcYCsrB8skxJhRcRmj1V8YawpepvFxt0TgyqLHSwm
	/mocBtFE2LJsbYNZxwBUId7k/BOetnw5utM2JTSLOZWNV72/KTxPVazgm7Yxb72e
	dmWG+ffRKOrzpPZpze84fg4pdA34aZDMTHpUvzfpetkRrw78obRw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bje3vg5t3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Jan 2026 16:01:46 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 608EsgWf008662;
	Thu, 8 Jan 2026 16:01:45 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011064.outbound.protection.outlook.com [52.101.52.64])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4besjb84uq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Jan 2026 16:01:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nXwR8er83C+1UdyY/IpMAKjGNC/wo2FwoyIEg0N/YLp8v5ne0MrFzNbauPlmN5aCPOMrQzoYeVJRrGssAYLCqlMa8duTUatTnqVWdaz9CEK3cAzDTzevnZnwAq9oCym6ZkLe4bKsTIMhj3u989n5OziuZx33Da902aAt6pTOPv+lEKlkiP4senRh8itrqetjuHyrGeDbvDpKMjWcuK0j52GzeDGDp430jA6QUMuWe03zBNc28eh9206Gr3wgSuA+K3jGArhWtf0wwtKP1BRclu7iCvMS8IIqWKZNFs/zyWROjiKNHSlYerU5/RSbgUA5WjCrOi1QZ258yA15fd3kbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LQcJr9uMKNDv9T3TpolsnL4aClJGNdhK7SChGlhJ0oc=;
 b=F5azI3aqsDTFZkQCHa5xDyIKDUiVxqus/vQpzG4nt0eRaBy6O11nrcIT5D/9zEX0s+kSOKxeALl9wbKJmQrZx6gbWdPGZtSVkSavYFnPrkyWVtV39zfuDywGy2iXC39jYRPPD+LzTPQDT0nSZ/osIFT/gpJ2ttSZGRV4NAOpqhLJE+xb7h4m931G0jNu071SXhjuRygBtN1bmTjf7msJ2CirCZgyhiEOiKd5VpCWFqyW5NR3mkAT0joHxunF13idGcmQaIieUWyUK00syIusq6IiwOa/hRUesaD1TMPk3oalxirYmmkrGVAJM17QfvGlXn9DijqmSDh4jl9Wf6kv5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LQcJr9uMKNDv9T3TpolsnL4aClJGNdhK7SChGlhJ0oc=;
 b=ZRZlqBxc5C9Pqk0QO7T+XVU/ZDJ2fayGUsv7+vwergj+1iOdohbJAn+Fkblu/ejUr/9mpmDovMhwMew0oNx8/1qsbnjGCcgtrpwnORY9Urgq+9X1E7NZj2yvwpVjqG/v8A63pj+Za7UH/GeUgWgmm3IqBWyw9gGFoddQ7PbeWb0=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA3PR10MB8539.namprd10.prod.outlook.com (2603:10b6:208:580::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.4; Thu, 8 Jan
 2026 16:01:38 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::f3ea:674e:7f2e:b711]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::f3ea:674e:7f2e:b711%6]) with mapi id 15.20.9499.002; Thu, 8 Jan 2026
 16:01:38 +0000
Date: Thu, 8 Jan 2026 16:01:41 +0000
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
Subject: Re: [PATCH v13 mm-new 05/16] khugepaged: introduce is_mthp_order
 helper
Message-ID: <e01ef904-38b1-4c3b-8bad-cebdb4d0117c@lucifer.local>
References: <20251201174627.23295-1-npache@redhat.com>
 <20251201174627.23295-6-npache@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251201174627.23295-6-npache@redhat.com>
X-ClientProxiedBy: LO2P265CA0507.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13b::14) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA3PR10MB8539:EE_
X-MS-Office365-Filtering-Correlation-Id: 38912392-da2f-4485-4109-08de4ecf34e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HIC+LT0nHt26bRvVzIeS3qszHDiboMKIJfZYLr0ABx/sX87nTXjrOZJjOKpD?=
 =?us-ascii?Q?sFaYslQUUSW8YQbMRFUNiWXS2raQ3lcSs4M9Bl0yYkHSHRcr3f2JAgWuNcar?=
 =?us-ascii?Q?3rtJpozHunOBdFcCqiE7J/qEZUfSeWe9jqdxVpcHv2pxFnDcQQP1mAEZ4YYF?=
 =?us-ascii?Q?gc4CMayWCvD6hqRr21c8H57zYlXKUTPmE+p0XozdpTKw/fFQMD3nRKSRTSSz?=
 =?us-ascii?Q?TkX3KwmGAQ4W9O81TWcgH9Fe/B74HAcLT4e7dYczQJYIw+vBZP4D49AuLn+e?=
 =?us-ascii?Q?7sHNj7/Fb8BUnkQwUL1MDtDDx1CoIqAdJaV+hFjeOgZ5OgM1gtdUQU1woWGW?=
 =?us-ascii?Q?+WvpuRImRJqniha/0DcgZ0RkTota14EIgsSku9cmp7BDy9AKbjjhx2IQkiwt?=
 =?us-ascii?Q?I4yEOqU4sjaBhFqHoMuCV+ychQto3PNRlkWpemWWD1XSu1H2eaUTs7e8s2XO?=
 =?us-ascii?Q?Cx/R/dsooD5NK2ruxy6Ero8+dEQVTnBBDgpOWGf4cfwbi5RG30Ex26b3PD/f?=
 =?us-ascii?Q?ELCWqd6qsOOq0iEIrJFM7EM3t2WmWAQ9AZt1kUBD5qBOoGVoDM6TfAYbr1Gj?=
 =?us-ascii?Q?pLXCJHSlSS3Nyd/St8yrrqTCd6gBPkSTUIfo8GEK6T/aXP3uSYtR4oWp+WZj?=
 =?us-ascii?Q?llI8h+udxMHPrD7pYoZDGozbaGals5CWlg69m3L7jy7RzhLiqYOh93Jdhkba?=
 =?us-ascii?Q?+ibW/PKwww5L7eU9Xe/zACM2BFKyhclc3NyD7GQ+BOy1ku7DGlaplL7oA8+m?=
 =?us-ascii?Q?NaAyDCmXGlnSCZuqDP4xGAY7C4J8a54w7E7CmeWRZGXZ05O7SPLBNbS7JyyE?=
 =?us-ascii?Q?tNA9PpPWf9WJ7LaxxbqxTqvtnrRASN0FYqMxJYjHpw14DFU+iV5l6SyNIpmP?=
 =?us-ascii?Q?j7Z9haA1avVOd16ykUEZQ0ixONQkt58lk4YLoMmWbMl6q96OSQwGTo6zEjho?=
 =?us-ascii?Q?Pxp/EWlbM59DuwQAHLfJXQGneFxBwn6+dxmv+1P0cuyVbw5PhJHwI5c56fcF?=
 =?us-ascii?Q?rMPHhOU/6MXvz+J/8ROFJHEpumQihpfVR3CGiIfcatuAYuJJqq/HZWceJMj6?=
 =?us-ascii?Q?M6qzzNn8w8ukP+B2ux9F59iVgl9mLg0qUhAaewQBojQQh8zjYla+VsArJF0f?=
 =?us-ascii?Q?aSbLyRuZ/RccE7S87jphjGZqa7zKpNE+P/U5J1l3TU5319h2Bh/vvWjM9Xiy?=
 =?us-ascii?Q?FNc6paGOer73r8SKuP8SXDq/prsmzq+myOyT1X0c91Fk7s3X6leLz8vvUKCm?=
 =?us-ascii?Q?PYl4xDFRtRFckkmuyRKW0EQdzTiGYxIf6gMPP8hF2lkEY3CdVMgKFYaZjHVM?=
 =?us-ascii?Q?73D9YuCibRdxpNu2IdXSEabBa1yaaj8M7BWNkqnKVsgPZGnsAtZFP5rM/2mu?=
 =?us-ascii?Q?hr0X1quaQ2YZO0+zzZ4EmxB311OuS5eFcBjqN5qE6NINOBr8eOgf9LpcSg3h?=
 =?us-ascii?Q?TZu0pws+WjaFVT/mE27VQiUo+FOMy9va?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FfpA+Bw+fTunllrAsspyj/J181mXx1KO6OO5Z2qs998ie5vC8ah0lw0b33qi?=
 =?us-ascii?Q?wY/id6eGl7E82yqU3BDLNC9ub+8PS31dds3HLiVV3yPkaeqcaEy3YRQYYD50?=
 =?us-ascii?Q?+B438pAActNjbTpps0XvIYVRkfXtTDCn05YA6c8lXt0TGKQ0dLw9Ba9JLy+S?=
 =?us-ascii?Q?vl04Dj4nBZ0zsolvCgXCRsSx7K+TcN/b9BhjNlCJQjdBdhaBHFUYx+TxoITr?=
 =?us-ascii?Q?QzdPjL7fKp+ETnKFmnoXzjlEVKV0Su7U+MiTWKekbFn/B4zWKeH5gE0toGlt?=
 =?us-ascii?Q?A2pfLOtS8RuwxdDnPwHkTiU5D0c7A8qP9m5Yl4ODM7BCDE1ZWExdCU3DWroj?=
 =?us-ascii?Q?A/ifK9550UR6J5xebg9P4jYJEHj8FhgEbtedBWFbhHrOdh1h+8Ec/vZjGpw4?=
 =?us-ascii?Q?RTlpwsqRPAzE7olHA60V7FID5rbBkGXKhOTvwonS/07ed/l7kJTqZrKMFw6e?=
 =?us-ascii?Q?BZFZmyzniLnhLM19Ig3jfbfGZiss8NE8Jzvv4QnsRs9DN1N1UX4xmiUFBDCE?=
 =?us-ascii?Q?kiptXYOsL7I6OFIbUGLJNXJb2anNpa2ap8AIjlg9HvOMtjOnoF+PwfMyNHRG?=
 =?us-ascii?Q?VzoagEr9xuPIca4OKhMrcB/YDB9vxvjqTdPDQ44GeyAZ080hzzPwFsxi1hDL?=
 =?us-ascii?Q?1tw75PoDwo7qK9Ei2/Qg3OZ6v2LuvEC13Fi9kfONkf3aU75BrYgg5+j8k+N2?=
 =?us-ascii?Q?sbWMD+M0z2QxH3fw62nrf64IeVEO8RDykl55lD2zHvTgWPbTKVXi9WkbYCI4?=
 =?us-ascii?Q?WhzIyiaOGOcwkz9Oq2K8YRHKTVsBdaWR2mte/cZf+bRnMRP5ZVrenmgoGbNe?=
 =?us-ascii?Q?oJAhcPV+UF9rJLVrTFyaurgT5rqMHb91oQR6eXaa4xATPUzhuurQhxKy5C06?=
 =?us-ascii?Q?EXEFCOTYbQnzOlWF3O4UZwLbYXkaxQdULM9/cRP5ql6XhagiEoQxoV1lbbBF?=
 =?us-ascii?Q?MIy/wBhNaweH4pdCMstGtj3YFcPhAcQFWiYjNW/elCTx3bO9RPh0ICZOjDBR?=
 =?us-ascii?Q?qiZDsFQKLdlMxrLxICkJdrqX2rHKGr1nmZgVJ/J9GEJTw+owP+CRfp8e0D1V?=
 =?us-ascii?Q?W9c5lZSI1TB5BI9D9ZY7Udj8smVwmnjvxFV4i2qnkjVQttBMQSXoVH2kBED1?=
 =?us-ascii?Q?90MKqg5A/d+SbBiXXcsJ1SfYNp8TtEf2UC1se9kIISZu3i8go0imksGRw+Ib?=
 =?us-ascii?Q?MlkYZNErrMJ9FivaTh7/KF5wJTwoi0rQHwkRV4U5Le9VWWxzwhtAhXrBEwAL?=
 =?us-ascii?Q?925nUVyFUhugoYC/rxaXYGeBaD+UF9wRodkOg8iHCT8JpftUyrrM4RQ5a0Bg?=
 =?us-ascii?Q?YlHArRNPEcj7oc09iuB5ctbpK7fJYAC01zJO0yAgqsSwlIhnwLUCvnmRC9yM?=
 =?us-ascii?Q?FcghMg8pqvPqiWEctFq1dM2YBU0fyBR8rmO6+oZzHrOsW0HbXKH9K2KInE2D?=
 =?us-ascii?Q?Q5m8+jlndfWKOIT5kkI4I6T7XiFqRxEy0aFajR2kdX9P/CizfBHHgRj57a3v?=
 =?us-ascii?Q?P+YZ03wZM5sPV+PIU8Ap+qyUXbfMW5KOF1ocuo7UNCtliVpIL2luBP9yC/nw?=
 =?us-ascii?Q?nGBZ8BERG3CHxqBeYipf/XpLqNQv8gB92gntEuizcRc8rNrT0y6RbWpGnGqa?=
 =?us-ascii?Q?9FYYgdKdSmd/3Kva8sbuIbHaWtmJhG5BUPtkZUsu7/RlMD6yFcGHeRpTaoCz?=
 =?us-ascii?Q?/xj8clch5iuNzIMOlrGfC7kcYEUXwT40AisqawHnZzklExe8ht6YnV074w0I?=
 =?us-ascii?Q?ziTwNLHh2+YfuE+DyGVSvrkseqeB+IQ=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Jzo0zNcktMGQRlOHNrTTmnMnE0TB8lNm1C/6sNg/+4NHNyn+WSmW61UKbWS08XdVdwO2+0fjO98YVrgfFZkrEi6li3D29OEpkMy1J/5vMdIdB7SBApgmAKDAziMyzFjVbCrQlOWxLPJwrTBptpm5u/puF27V3ukKRjF92UiTW6YzbZzBRvDVKBS4JhmtBwC1+aJF6uk4yCYv0U3cAlXR+11RZ6p1Ay1Ye4d8Opv4dIM1567BPjTn42nn6o/ifRhk3B7EVxxDiRL4kvhQ07uToFbNorTWd8G5WQFtPhe3q1MyF1CbwwuutD7oLcUhXrWAuYwMs8rrJrTEUzisB/0j4d0KLnr7mQ7+g9A4vVYswLLsurlVjGHqsf7HZyoDTFm3HliZFuTiW7s+Y9DRZyuLT+4IvyTpgQcMV3TvlHZNFGIFxAgWEFT3Py5SgufwL/3XpdRw0js2r5K8nLKRZ1HFIihmsCqssbeo45gLTbgDFE3nnnguC87cLeYhANyS7kmPwY40JqvvrNcnTlOownl5udyk64wmrUhRWn33qrJCr+F0o//p1Oa+/n2rADbDRLcrSY0VXZ7uVi/80stPprEkk1wNnEfGuvqCClInpUsxLPM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38912392-da2f-4485-4109-08de4ecf34e1
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 16:01:38.7527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nzY5WTKdWAC6CF6ySLNv1wPnCXFH4FVoGRSUd35BSvuwrdCVPIzfzGGcvDCemsMqt2QGK1txtuAchZpHGcFVd2xDi1XPJUoe7NX1v0efuRo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8539
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-08_03,2026-01-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2512120000 definitions=main-2601080117
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA4MDExNyBTYWx0ZWRfX9iNGmj1D4ckM
 8c8D/F19y4y6LeZWS55/TWJu0DqOrjoOw440rCV/1fRdVeF3PeRMPS9sy61BG655szxlowdM3J0
 ZZoiTUKr2y2GyNhH6soL4C2nzI5qmwXNXqAkXJwGE5UjmfhHFokiRxkrBQwsP9KzrBXipftBLwR
 SIRn3+bwdm42w3I+gDzK5AjQWFqJB6FmeTk9kPYJeXNbkOa8c4copt1zhGk8XZEHdZM1VivIbme
 RA5kgmurNDdt2sTjzSkTiH+FFNGIpVUoBvZpCoNYbu1Tqs8gwKSlR17tqqd3isRhitfsQ2K9mLK
 uZkY1XcUI0xOc5WgCoh38D/ovTS6XVTU9G/y8YZYWAzo3+6C/KsdP8zJlkf/2mLUFcwdd5yQ75r
 2lnbUWWqal5biSdF+yA1MM09s/lrH516LoZOOhKQbbK+/l5w2xwuTQzq3JP70yr5B21k9mcYnor
 2Rm1qKyb5zQOTHq9q2Q==
X-Authority-Analysis: v=2.4 cv=fe+gCkQF c=1 sm=1 tr=0 ts=695fd4ea b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8 a=YfLgxWDG23JpKDAEbGMA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: odtV31I391oEQU7pjPg3uqpcArjFjDkQ
X-Proofpoint-GUID: odtV31I391oEQU7pjPg3uqpcArjFjDkQ

On Mon, Dec 01, 2025 at 10:46:16AM -0700, Nico Pache wrote:
> In order to add mTHP support, we will often be checking if a given order
> is a mTHP or PMD order. Lets create a simple helper function to keep the
> code clean and readable.
>
> Suggested-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Signed-off-by: Nico Pache <npache@redhat.com>

Notwithstanding what Zi said re: using elsewhere (please do :), LGTM so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  mm/khugepaged.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 8599c7fa112e..9c041141b2e3 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -338,6 +338,11 @@ static bool pte_none_or_zero(pte_t pte)
>  	return pte_present(pte) && is_zero_pfn(pte_pfn(pte));
>  }
>
> +static bool is_mthp_order(unsigned int order)
> +{
> +	return order != HPAGE_PMD_ORDER;
> +}
> +
>  int hugepage_madvise(struct vm_area_struct *vma,
>  		     vm_flags_t *vm_flags, int advice)
>  {
> @@ -1071,13 +1076,13 @@ static int alloc_charge_folio(struct folio **foliop, struct mm_struct *mm,
>  	folio = __folio_alloc(gfp, order, node, &cc->alloc_nmask);
>  	if (!folio) {
>  		*foliop = NULL;
> -		if (order == HPAGE_PMD_ORDER)
> +		if (!is_mthp_order(order))
>  			count_vm_event(THP_COLLAPSE_ALLOC_FAILED);
>  		count_mthp_stat(order, MTHP_STAT_COLLAPSE_ALLOC_FAILED);
>  		return SCAN_ALLOC_HUGE_PAGE_FAIL;
>  	}
>
> -	if (order == HPAGE_PMD_ORDER)
> +	if (!is_mthp_order(order))
>  		count_vm_event(THP_COLLAPSE_ALLOC);
>  	count_mthp_stat(order, MTHP_STAT_COLLAPSE_ALLOC);
>
> --
> 2.51.1
>
