Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DF32F360E;
	Mon, 15 Sep 2025 11:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757935494; cv=fail; b=oIz862vGfK1w+mFdTAXlh9yjdSaLyDgqg2g+kgXaLFr5nQohdb0fA5LwjQ+oLsf4SzKonuTiDOJYtR12nAup6oa0MUT8SCgh5tZDW0/Y7Y4XLHfiR2lbqcAw+3iQiIzrxM+pDw4PRvvTfZTnmUUQkVvJhDPyhaWmz8Cqb3S/9xM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757935494; c=relaxed/simple;
	bh=eHDrBLPhMo5KG0Xy/6OVCdvxvbW3De7KQFwPfdZw7Dg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ALw42cJehlajOkod6txeQCj9nCjpHO+lmbHDEv6oFOy1dcFlR1vbvBQGEArXYIeVFn0YaGuSV2sHkSvrwJ2Bue3izERMzevD+dWfRemS6M18Dwhg4/vxerhGkT7lsUQvZCNRQBNC0undGaGzdKQFIfXemgaIIuCqyyiyPWJOeCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WfPfSBBX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PL9Hh/e4; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WfPfSBBX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PL9Hh/e4"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58FAttsG018504;
	Mon, 15 Sep 2025 11:24:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=eHDrBLPhMo5KG0Xy/6
	OVCdvxvbW3De7KQFwPfdZw7Dg=; b=WfPfSBBX8ffpN+wWCmk4xUc8OdSwHANKnK
	KbYOWIhtJC4EmJnEDaBbCVOzNtKivUBPgh+/kGos7W86IUEPwg6HkjdUhcY+QIV/
	paYDUK1qSQToSEWMWLsQ1U3XuuKK91zjDgMytW0sEPIfHh/FROTa9CsDWkW4Df3s
	cYp1QvkN+ZxISQoXyBO5oau9fHY5XYgNF8hnVToLi92+N2sM0h/vs0KsIcg30Jdq
	Dst5QjLP9QnyqQM26V0y+hdUctNULqfyjqEeJIAAPhg1T3wYfQNrBo1Vdldc3LVC
	3bxY8VVmdMBsc9VXhcb4u487lUr3LSOosRNf5gmI2dDqmxWuN3sw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49507w24ta-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Sep 2025 11:24:00 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58FAVmFS019231;
	Mon, 15 Sep 2025 11:23:59 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010019.outbound.protection.outlook.com [52.101.201.19])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 494y2b52a4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Sep 2025 11:23:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UXVjpUWBqpkTCr+mHi9H2sxRtJ3JZEtcnW8ekidMOWUr3QobHAqNnS5omMFqdpgwdAssVc27LAy/7uxcLp6CPdbQXd3JXX+kUuLUjgVbQwrJdeGPVcEoR1AJCrlVqvzvhgjr2lOM+V9j+IsbOUwSTb15xSpgsjhmFEescC+cEzI978CuNfX2/iYfIxz4gdshl91/QmVggux1GLskSlAwCpNJASyUZHwO+EFs1kv7CXXx0eFjElNSRF+GViRaGmF3/sYo9PCBRyeVGJq86wkWzskD3InxA36WtW3ocDaAjMPk8/oBxRcNaysqBYWKZDT/YEtAWv1EsG2R0yLGn9ufvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eHDrBLPhMo5KG0Xy/6OVCdvxvbW3De7KQFwPfdZw7Dg=;
 b=YG/xJJ5zQ4W8gNfa9WH2DMI4yWBWa7rL8THaJ1YFf9oHqR3JycIuEU3RTJ5PCbTHmpmSzfFpoGrYNu52QgK+Njb8MPQs/k4KMIMywcCij8VUHZcjdeHt+4afH825D64AYM28Vd3zhaTNNqHABwsCQyVlrKuZikGhEvJKrz5VrNXxaG/7AHnyPmF17VrZlcsEhamQyn3Pne6cwVkSgEY0JZM7OfOMWLqxvg9PDucquI8xO23eERNKlFkXE0G+UqzmS84xQfB+4deDS05xPpdLNJAe0IqaFbiHJLeQhonIgZKW9s006ISFkIc4hjrxtSYXnEIXD4UOvZA1aHiwE8YC4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eHDrBLPhMo5KG0Xy/6OVCdvxvbW3De7KQFwPfdZw7Dg=;
 b=PL9Hh/e411BFsdy+53w8kdvOt7w2Ux7xhAzUQWziR8fF9DN8pEq29Nz3oweGn+d+yfmcj1mOpF2dQXYX8XwUjrH6yU+OF7ACNjj9MdbVulk+wCvYkBGQtMkzI8I39tLZsXOjbxmsg/gc6HzP5dcEnowP5gfIxw8yjpBf52zmTm0=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM4PR10MB6695.namprd10.prod.outlook.com (2603:10b6:8:111::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Mon, 15 Sep
 2025 11:23:55 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9115.020; Mon, 15 Sep 2025
 11:23:55 +0000
Date: Mon, 15 Sep 2025 12:23:52 +0100
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
Message-ID: <2757fb07-78bf-4a39-8c60-8ca8be200994@lucifer.local>
References: <20250912032810.197475-1-npache@redhat.com>
 <ppzgohmkll7dbf2aiwhw7f4spf6kxjtwwe3djkx26pwy4ekrnd@mgeantq5sn2z>
 <d0e81c75-ad63-4e37-9948-3ae89bc94334@redhat.com>
 <CAA1CXcA+pb5KvEnJJqdf1eSjaFiBZ82MRB+KDmyhj3DbiQqOxg@mail.gmail.com>
 <enrgrocqajwu5d3x34voghja7pbvau45oobxgabawrly44ld4u@ahch3xn6rtq5>
 <cd8e7f1c-a563-4ae9-a0fb-b0d04a4c35b4@redhat.com>
 <155c821d-402c-4627-a723-6f8c88a2f65c@lucifer.local>
 <ae9d88e2-bab9-49fc-a459-d7b9a8fe9351@redhat.com>
 <ff4b6935-fd13-478e-9187-219fb612aac3@lucifer.local>
 <e450009a-56c9-4820-bd0c-da1d782d3962@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e450009a-56c9-4820-bd0c-da1d782d3962@redhat.com>
X-ClientProxiedBy: LO4P123CA0008.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:150::13) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM4PR10MB6695:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b104465-051b-4eb0-209f-08ddf44a5b99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XHwZ+sR0TVegrVa3Higbw48s+lDL7viWHYJC0d7J5Agebw9TSStUalnzqs8y?=
 =?us-ascii?Q?HIi7naA/XAXq4u0OBqx2wJ2Os/fbJVauXwYlSoWSrCutoZeE5amhUZvfXCUX?=
 =?us-ascii?Q?Md7iDm7A37hFxmEot3dVBwt0le1kQqhFLTV1oMJ+2kfmUtT9xj0aScKZCEux?=
 =?us-ascii?Q?RW8n8laqFmk8oVDjvQeY51FxAd30oBbQJLBntGlh/V70qiqNzPRqjlrKlXKH?=
 =?us-ascii?Q?FXCVRpGVjSV7O8VCd5VE5VWiSfOMdhCL7hom5o6NEp7O2ngfdpB6/LQdS7uV?=
 =?us-ascii?Q?dnZpY2EldFKGTramKRGcG0pIBHUrOg4Vx4w267i2cj4ze0xsQTNt3hrI1cfo?=
 =?us-ascii?Q?ACcdeu3q1pYh0Z+DEy/cUjXfVViRztgeVfUBdFtg5bxrCiY3YBISDEQ+Kly1?=
 =?us-ascii?Q?cT6ga/gjEgjKHLGZ7EJyA1+LVdQGhu8DPJaKvXjAbTOvFV12dZuV2olyYho6?=
 =?us-ascii?Q?AhGN9RerrOC1bUy9dWKPKTYFlWSjYLFYPcFsNQYOlkirJNRmaxWeD+b3s29d?=
 =?us-ascii?Q?IwKQzxwZqZavsnW0QPJgsuAETls56A3w8QE40+Z8fzy5XcBcf+JDY9vgkvSb?=
 =?us-ascii?Q?ep2wN5HRyzE2PAJxJ3N+iPns+PEXNeJfDj+19K7VtNXCqS9dYYIDYTkaRqGb?=
 =?us-ascii?Q?UDhIb5LQRUxTCMU1lOG/4RMsxrqy9kS9oZeS891E77KSPAeH66lshUDwRRzc?=
 =?us-ascii?Q?zkJMw4NbF6Ia8hNZrUoWUt/cp0RRShuuwZhSvfU9PQNomYrZmP5d7LtCcf6R?=
 =?us-ascii?Q?WZ81uC3wm7xlv98jr0tHtCH8S0DtrAvyrPpyyD2ptEyDhulYduOOuIsLez81?=
 =?us-ascii?Q?tPQaC8a8Vp65wt6O2m+0lOVZqjouyEuY3WALxvB80Y9PXj7FsbkO7rsjQ/KH?=
 =?us-ascii?Q?kB99YVAcDQh0MO31+dhQQKtgQpY86SvcrkbX0kxDdfpP/i7OYBSGpQs80LJ3?=
 =?us-ascii?Q?u8MWo6lA55qQ7tSvrYXMpZ8fh/y2Lt7BZuHqELO7JCh5RKqVweZprJPyqSK6?=
 =?us-ascii?Q?DM4L28+0EaJKSfzkh4xsZvQI7SF6uTB/ga8TOqB9oR2/hhHX9UXxfZM7nqPR?=
 =?us-ascii?Q?juhe0j2y3yhf7LbbD6nVxv1BqtbO1qTco+YXBddvQVd9kQsrnrcLosHPU+uc?=
 =?us-ascii?Q?5BcfU1SGqktKEMwvVYLJTzBw3zDxQcp/bs90MlF1Qe/uCBZcrwoK33AGolQo?=
 =?us-ascii?Q?5q+x5dySgfUac+hFSWrdd7Kxoe4m+A2UlqYE5XC7LptyFrig2OXvaYArrknU?=
 =?us-ascii?Q?BL+0WVqs10LMPTCs/3mDZ+WeM0yvh5rHATfMNSdaYe1/qWStzjO4GzHzBqk4?=
 =?us-ascii?Q?54U1S4IAsMTskRKGW8nPWYmoDs+EEE1AuULLyecuu4eCSVAWtQ7ST1S7sdmB?=
 =?us-ascii?Q?GujYM1Ydb+zcDt18KKYc7CSvU8p9lye+ZNB9ObbXPE1yUWpwCyw/xKqmbhAt?=
 =?us-ascii?Q?ZFPCLNkr9Qc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?n58hgg24z2Xm85p/bza//HqKzxjP/6K8ncEnBa64pL6Nd4nKgXau+OXosrwu?=
 =?us-ascii?Q?vH2PtNbnbddxNkIJtBO3zzPT+HzH+lqRjk/9oKv7gFu4Z+cBkY9fuVR/GiNN?=
 =?us-ascii?Q?cXeH8DntcKKyaa2j5+htba5mgBHoV8Ju4JJ2JdKA17SyHcgw/vV+UjQytjX+?=
 =?us-ascii?Q?vV8RsSIqH8inGjRRhmCsg0S8sjM6B4aK7K8iZUwH4MRx09CtoFnAjG4WSAQf?=
 =?us-ascii?Q?Q4553TEl5DmmLLfqHDix7XcpPB4v5b03pFehO5uFhH0y+7nBbwSaoBCU+KOA?=
 =?us-ascii?Q?b7iSb7GPcDvTVAknKBax6DkW2iRyRTNdY4cse6aiTTAveZwZnwIU6PBU76WX?=
 =?us-ascii?Q?Yf3RX+K8QD57DFkra9bMMbCUhkPOmafVVbkpJazLbwDIY+4AwHEmMvyGJhEa?=
 =?us-ascii?Q?MHOJXlMl7Xh0lQ1gWMlkIe1fwaLT3pg0ykXtr2rmgKAM0B2ZhEuSRWvpA0wY?=
 =?us-ascii?Q?ZvuP4lXRfRBWi9szPIpTXH4wXTTdeCqUAkrWaUgbWveaKo1QmA/1cyk/nSqo?=
 =?us-ascii?Q?RMfzDrHg/b71hA6gwVChYBomblOvobwCLRVfdd6Vy92+SK2pfAc+OuWgaHjh?=
 =?us-ascii?Q?b4E1rxkJQQKq62+uA8vCPmkb+CxkOuAcoELHudDIl04WoLLk4LWHHkj2yrL5?=
 =?us-ascii?Q?3pB2kY2ZC5brZkxtI3/hyeH9XI2gZfEaI92UVqYHvxfQmmGcdqSPVX3vG7he?=
 =?us-ascii?Q?VAkcMmKYCOtSX83+gpaGulc+UiqDHbS6wlSae9Kc1BFXZ80aQ5OW3uAj8RWT?=
 =?us-ascii?Q?Ajy7lqLtlHyMEXx96/Eijrb9PChAN1SuoJGmYJom24hguUraKBFj6tuyDgH9?=
 =?us-ascii?Q?BU6J6pHSQBvpqLlbL2hQRptDSmIlMiIi1x2La2isybNEg8f8Iq2OModlvSJG?=
 =?us-ascii?Q?2zDCDfQ2L/denPyw1BJyzg1GeH1Z9e/+bYZAXli6MhOHlBAa8A1Ju+KSsBaP?=
 =?us-ascii?Q?nr9rORKlTcNwX2i6rT04T4Xu+X51EHk9WJGoD5W+feg5/RVmo8ETIA7oBvfL?=
 =?us-ascii?Q?fHpeU0BgteiQFltvT7ep8TCtId6bvs5davGZrN85VXWwnNBvaz39ykz9VT8k?=
 =?us-ascii?Q?F7T6hQu4+kjg13O/BCLjuz4/QiQs94rLlgiUr6PqUMf38kwyLj+MbcvIzFwa?=
 =?us-ascii?Q?sa11nMLE7nHauteL8J/ePSJjDPjmzrD6Nr7EclnWxMbLrlMjMdPE8KCyHAlK?=
 =?us-ascii?Q?wGo2dsE+kMnUwTpX+rXNZ+hSimqEmZqlYCFt7mYgzh6On0DOpp7A7QNDjFc4?=
 =?us-ascii?Q?E6kzA7RfGrJp0dFDycT4t7Q6KKAsKtWsCMjIb5tDI1NVf2X5IjuNXS4velX8?=
 =?us-ascii?Q?FD3UUSAbfpQ5Vj9e2urv67wQNzKTIQHWlN84EeBC7o1HnUix84U3hJTsVyRP?=
 =?us-ascii?Q?eyZ1wRs3UWH744zhnr74r8gle7K76NFCOZEu47EoXB6QVCSzXX9LALdLbyEA?=
 =?us-ascii?Q?gZ8EH98vV6d1iK5RoOTwXKa9CdSW8CRwbHa92BWKbtS2xcSN7oHAgFmJTgjn?=
 =?us-ascii?Q?4qDl8o1fniSBcOMIESVWYeG4hTUNnI4CQV4cXNyEjR/+iC/h2lyh2y+u7ktF?=
 =?us-ascii?Q?IA/YQffF34F92UveWJ4ZsoOFIjfGjVWfuxTgc2SmkOEwVXrr3JPXrc77ZwfU?=
 =?us-ascii?Q?Dg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MwiFqBoOQVDBCzXJ72wJhvdMP5I5IHU45AMH9sZKJY+qgrYFqhS+H7sJaJouVzm1NQRS9al34JKvPj55s2EQ19+L/Sp19fyuEgGgaBVdiTIIR3p8IhV6yJasOBMa3ONcTpsS01sIWPu7T1kXwEevFEny2BheIjLfNuusqK7fr2NjudtV1yiPf7FbJbFL2e6Vr4ujD5tc7pS5HLUo48PQD7SKmRppSsG2xsTjNJ6AdTuzXsFzanp31M3w4kaoaiK4DDB8QfsL5RE5j1gZVoRI8CGL9R1AWjUPNx39Txh3yTmTdIGXp0ZUSSa78sDKSJhRZTKHgD3Q7QLSyNVzd0rRQkUo1TDJYbm0toXBe+9HwU7OCE/cxGZygRF/ifBY0j9uEcw7exf0PYz3Ts42/vUgof4dtKaAFDYryblfljQ+s728w+jfYQBC+aXO70vaf8rvINUX9vrtgBj9+LutMpvf+rFBRn2L/Wo61aDFMWazG0qN8GasLWQX7ZKVl8wkMO4CTaUsjrJXcer3HDPmOaLzfGijCn0FIQEUGfLL/0ZpPb7XAxkVTMrE4oUuh7UyNMVYfPSlVPB+kYIynf+izJ2uVj0QihjQZVIhRvjKGyHyzmc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b104465-051b-4eb0-209f-08ddf44a5b99
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 11:23:55.8642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A018bPnzvarm0L4UqZIFilbiPkTB3L6h5BjBas6OPNt6ozWTMJ2w3RRcxmzHFKWbA3fxnnA6EIIzgOxcJ9cJFuGqcQdUPjSz/e2HjmcrdYE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6695
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-15_04,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509150107
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAyNSBTYWx0ZWRfX2NsA3cS3aVkJ
 mwv4KctpabRnHu4StTnq/NRIhvunp9F4c2JcSKsIr5OsggF7PpgV9tmBVrebUBN/ktoPkyddDCm
 QRU2pojqTB7Xv4WZKdjmx0CqkMI17Sdl5YKCJHry18zemmE1miK25a862CpRBUN0oHl5IlCCMGm
 IiNBb94b8O+PoPfjOoKfauvMnGTYfi22P1u9OFaWYcoCDwTUMvGaAWzJ0EzHirLc0ZzmHuiB6IW
 WItN2t8g3SA4UApfYF/YX4v0Cw/qjadW+FfQ3tLm32UFZ31Xs1ut3zUklndr4WQPE6Vp4lwARQ1
 WxmXCTikjfWu+71whonPMSjZr7hIZv2GMtERbsUxM3xtaXYbi9VoGVuQxwdXyRC9qNmXD+YQckI
 xmCC/Cq5
X-Proofpoint-ORIG-GUID: sryukA6liTGOtehJ_-8k4CqooRpiYhTC
X-Authority-Analysis: v=2.4 cv=RtPFLDmK c=1 sm=1 tr=0 ts=68c7f750 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=DF67TyndBhzntY03E2IA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: sryukA6liTGOtehJ_-8k4CqooRpiYhTC

On Mon, Sep 15, 2025 at 01:14:32PM +0200, David Hildenbrand wrote:
> On 15.09.25 13:02, Lorenzo Stoakes wrote:
> > On Mon, Sep 15, 2025 at 12:52:03PM +0200, David Hildenbrand wrote:
> > > On 15.09.25 12:43, Lorenzo Stoakes wrote:
> > > > On Mon, Sep 15, 2025 at 12:22:07PM +0200, David Hildenbrand wrote:
> > > > >
> > > > > 0 -> ~100% used (~0% none)
> > > > > 1 -> ~50% used (~50% none)
> > > > > 2 -> ~25% used (~75% none)
> > > > > 3 -> ~12.5% used (~87.5% none)
> > > > > 4 -> ~11.25% used (~88,75% none)
> > > > > ...
> > > > > 10 -> ~0% used (~100% none)
> > > >
> > > > Oh and shouldn't this be inverted?
> > > >
> > > > 0 eagerness = we eat up all none PTE entries? Isn't that pretty eager? :P
> > > > 10 eagerness = we aren't eager to eat up none PTE entries at all?
> > > >
> > > > Or am I being dumb here?
> > >
> > > Good question.
> > >
> > > For swappiness it's: 0 -> no swap (conservative)
> > >
> > > So intuitively I assumed: 0 -> no pte_none (conservative)
> > >
> > > You're the native speaker, so you tell me :)
> >
> > To me this is about 'eagerness to consume empty PTE entries' so 10 is more
> > eager, 0 is not eager at all, i.e. inversion of what you suggest :)
>
> Just so we are on the same page: it is about "eagerness to collapse", right?
>
> Wouldn't a 0 mean "I am not eager, I will not waste any memory, I am very
> careful and bail out on any pte_none" vs. 10 meaning "I am very eager, I
> will collapse no matter what I find in the page table, waste as much memory
> as I want"?

Yeah, this is my understanding of your scale, or is my understanding also
inverted? :)

Right now it's:

eagerness max_ptes_none

0 -> 511
...
10 -> 0

Right?

So we're saying, currently, 0 means 'I will tolerate up to 511 pte_none, and eat
them all I am very very eager', and 10 means 'I will not tolerate any pte_none'
right?

Correct me if I'm wrong here! :>)

>
> --
> Cheers
>
> David / dhildenb
>

Cheers, Lorenzo
