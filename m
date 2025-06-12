Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CFC19B3CB;
	Thu, 12 Jun 2025 17:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749749109; cv=fail; b=Q8DI4GsfhI45uB8kMQQZLpYJiF+6sO6Iu20Iuy88anA7l/ghbp6kUoMXsRuETEtMT9rb88ahgZJg6VqCv93F3VZLi4b3gZvqGIPF/cm6JENsTpoDzGfNI4IjjFOVz7EeK28allkLgyLLEQk8WyIBwGe/gX9sOquAXI+fhufF/E4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749749109; c=relaxed/simple;
	bh=xl0a42kb4Kbw0duB7toF1pHHYWrZGgO+AZGbyfleKT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HdPKhFIS1LLcLVPdcOkuW+q1HmQmhnRiVCqEptnEQ1I+8cCrhbHDL0/9/A34VRG17F0cluSzQXO2HjUtfhRfvoGmMiiA4ymqt1V+ObNknDEyJX0PfjVRpSsdSeAFIVCNn4afAZlZJoVqcJLl9mRxOKS7R/K/Kl4Jm2+VO2b7i8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iwX7Ujc7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LPIDKxXn; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iwX7Ujc7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LPIDKxXn"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55CEtZ5r029151;
	Thu, 12 Jun 2025 17:24:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=h/2GUG6UrGY1yMQ1EJ
	6qdHfU8h/Govb+O+RjLyO9nIs=; b=iwX7Ujc7IwtEnhnErNh0IV0d4/wmOCHpGk
	umLYThjwfsjDo7o7kWFWX3/cBPPgXEUnt7ET9c9BeLXeFtjjbPT8QUvTZPLtGkP4
	5WJJ8dFqRGRhffnCUVsS+uDve8ZLaHznqVxh+j2epuJX9GwrzcU0xSQdUb80B0mq
	cJX099oeclCKNqZop9kteQiqMsVID24aub1KknavvABuLumWcfcWHQvQlUw/6C24
	Y8iKLKrKF49wmDnH82jS3oZZW4CccIrKsnAJxEw2GF0HcEpepI0kvqbJNRqMuddl
	DhbSb/U4fyaSEmwvlALX7kYt4ifBqsZDBotcmiukojDehYMxSuXw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4752xk1na3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Jun 2025 17:24:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55CGZX9a013312;
	Thu, 12 Jun 2025 17:24:35 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 474bvbmytw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Jun 2025 17:24:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ob+NzQb0y+JlEEK1sXidH3pt83DBRrTMqvYu7FYcozuFFy24JqFY2QhkHZtTZRhfmTdYFHom5tcLh393aqCwrqAxN+ygv5UMpBv7V62SGzBwNmoVPhhPdnsK23T2mDRlf8SmL88HBc0DaiENYGRw11QULP14a8iThzunGXhUno8g/LrltdCxOtUDCWJSXaCSVuQLfeNIue4L4XZYevcAU043oGqC2VnivYUtrbg3GFyJekENrrw6sah8xLjsgJYOrPF2C9HxE7Ku/vSmkXUvkLe1S3eE2hSAT0AO2u2t5WfxqbLw8mstFFFaSczwKx47gEYAkOVgGEarEcEPF0fHkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h/2GUG6UrGY1yMQ1EJ6qdHfU8h/Govb+O+RjLyO9nIs=;
 b=klKpFtBZsNfkUh6y4XFDYW5W6QF3slGvc9eFVCx2DhKm/Dos1nyqqd4gbWYiehccW0JkKeo906ENBGwhGH4Mx1ePYd3s7e/t0XME5FO5a4l0PoO8FVXC5mWxXoJDCSbt0SK1bNSs1QpC8rsw176geC/IvX/suqytgsN7n///LOzaXF62UcHFUg9cojHRq1TWhuhTelnLh4ZuvIiGQFeMMGuljFkXQmwF6ciQ+Y6bovmJV5gHF9G5yFtWb/m/G65BUxggHQoHziU7vQ8TToU7yHW4UQ7eh3UY/1yfRZACRceP9Eq6cRvLIb1qAtPx50qtiqPEBpQC5VOlIOwq7ZSbWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h/2GUG6UrGY1yMQ1EJ6qdHfU8h/Govb+O+RjLyO9nIs=;
 b=LPIDKxXnO93Ysa+iVUqlZUQu9GR8iPhUVEBBLF8/3Nef6yoEdXq6yDEC0cGLWPIsyEUquSSvTHj6KcGRItNAvYNFRTVdwtp26DrbJ1Ufvd91qq5KFqWwxiAd3J2HRNUW56T1UghhuCURq8mwWpAhDPhm+DmGFQMgRS+gq1GV3Gw=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by BY5PR10MB4132.namprd10.prod.outlook.com (2603:10b6:a03:20b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Thu, 12 Jun
 2025 17:24:33 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8813.024; Thu, 12 Jun 2025
 17:24:32 +0000
Date: Thu, 12 Jun 2025 18:24:30 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Linux trace kernel <linux-trace-kernel@vger.kernel.org>,
        linux-mm@kvack.org, x86@kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] mm, x86/mm: Move creating the tlb_flush event back to
 x86 code
Message-ID: <65bb272d-b2d4-4d2a-9c7f-d3d5d2eba23d@lucifer.local>
References: <20250612100313.3b9a8b80@batman.local.home>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250612100313.3b9a8b80@batman.local.home>
X-ClientProxiedBy: LO4P265CA0017.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ad::15) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|BY5PR10MB4132:EE_
X-MS-Office365-Filtering-Correlation-Id: 5247659e-e0e0-483f-37ea-08dda9d5ff08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Q2J8GXuLB/CgjmJqMzM21H7WjxQPsaVubZ0OF6BV+RqEbJr5jA6Yw9Q77Yuf?=
 =?us-ascii?Q?0Clply9JHkHh0oHj7JeX/4WYRZmTAvASCfjoetP/+L81cDxtbf4ah2KSCvKK?=
 =?us-ascii?Q?ttinUhllNwCQ1OvmesvhZg1k34B4ot8rPHLMiieIWzKqOn9ZSRd6IwTLgT0i?=
 =?us-ascii?Q?pkKPl5fXiBBVic3pSceCIsrC7GNbu/opPnM7FfrUefbYx/BTAnDLetegz8UL?=
 =?us-ascii?Q?vDbTPHGsHBVnLb0iGc+bObKQc7HN0mtfyFfYEZi0h/OFbPweJRopgb6nuB7+?=
 =?us-ascii?Q?FQrDURA4I0VEj2lf3G159QMS5Gpft8x8DVH5gJdaCibE+10vhAJZgChlvzu9?=
 =?us-ascii?Q?LaSAnaJntr8F0yULS6xkdAU2pf4rkeFI0MsHdPjvfc/mb3Pe5WRHZP/JwZ7u?=
 =?us-ascii?Q?p3gYnAG5UamUb3bc8kgUDBgNNBq8junoHJrIZDVRh2cJkK42nqS5oy/5uhfq?=
 =?us-ascii?Q?nBhAsIlFH/KT8jddi4412SZ3AbN3WwHcRKvyUZWUlogDEbnyOaOSu+aptGZt?=
 =?us-ascii?Q?yt/zLdm/BCLK0DTNIiESS/sVVSaM3tjm8MjUYQkpcHvThUH435OS7lVOtNT1?=
 =?us-ascii?Q?jB46D8uprLLYE69tmkMetF4u2fdU5BzF0dw7ULasaWOI09a1ge1vRL4fBFw3?=
 =?us-ascii?Q?hIdluhO6QW9mp1Z5cAaqJ+PKSp4BM6UxDTNke7qVfDrhPFO5ifuafJV1gaNL?=
 =?us-ascii?Q?FkRfyttTjcZF1nafQMMHH3NvuO/Owx8m2bmrlFT8PC7hHUFD9eqyzT5H0TZ9?=
 =?us-ascii?Q?4oOfJRczFVSpJTli9tDbUZC5EgfL0leSA5H5ccaO9i5A+QVqu2mHL2AUzpc6?=
 =?us-ascii?Q?DaxhKzzhfUx3UX0913zPZ7Rwtm/mSYc0C4z8T1eFjaOGayr5fuu2QK7sgWzv?=
 =?us-ascii?Q?nYzijJMUBAHdqY5sxrhHb97zDl8qRwYVwluoNxHxqM+hbXnAt1SD8C+gmx3l?=
 =?us-ascii?Q?C26Hm7IwZ4zrgnBUsT/t2kUvOseUWvna689czhIW6SY459hmRcVsi5I6Z9TB?=
 =?us-ascii?Q?M88V9ue2wUpPQH4W6I0SxkMoISwwS/yAXRECs+dCxGC7O2LnECOKFshyn3D8?=
 =?us-ascii?Q?353xK+fkI9BNW9gkjT51yHou6GYMfFoqSGJs7gl5zYcyAom7PfHryEu0bKie?=
 =?us-ascii?Q?TIAajiETbXYi7B2NIX7Fzd02v92+S3e07T2E6PiJYvK1PrN1/vxUaPYgBJuW?=
 =?us-ascii?Q?hHbtSCknJdKDxP5HGgHUdKsxQCf3IWl/sXdvvVajCSaFHtEgpUQofAFLmg2w?=
 =?us-ascii?Q?grWUbPPDxuOo+RdM33kCb6g2f5PdXIfr8Jiahwxv2KYoj2fSY4bZX8DJiGvY?=
 =?us-ascii?Q?O2RpfdgnEizK9l1CeBR/Ox5NPyA+KOOERTVoq9UpL2y0qanP5AfFgVyIvWyV?=
 =?us-ascii?Q?3oD+ay8866/PEH3ToAIGn1H4nUk8ZE6Rh+G3BbVgwSGgFfOCegNCCxWMzCEd?=
 =?us-ascii?Q?KZE+ix0P5IM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JCXq12zm2fe6CanYMzrpSLNmG2juzSMhnrMT6HIye5htOYuliSBP3SbU7G2b?=
 =?us-ascii?Q?jZoF9s0B0qhScgYXEFoCTBPfdkg6E7Inqvn/lbDyDxRJaRC0962xSJbNDRYy?=
 =?us-ascii?Q?GaTuC1DkdhVw9eNpnSZqNJi7b3XGa7Nmz5+leEgX3kaOOByMbI5Y4Zo7Jly5?=
 =?us-ascii?Q?FWKsU75mRH0PWXnR5DB1OqOg6ZC5EqL73n/EkjRovjCMZ1uoDdF749ND1yDH?=
 =?us-ascii?Q?t/xwzyLqoqm8WRXPpdwaPFW34icqU0eoKJ0x+XJWL0K37rqD2Bw8wYylTSLE?=
 =?us-ascii?Q?uZ4Ai2l9w8EPHm5TmRo6jmE9430P4Q1G2Q/AE/RmAfzhnr5kgTQTdyIOs6Qa?=
 =?us-ascii?Q?ARQtNt9rpsKzbEaUff+r1nxITKS5wWdLPxfrtWWRV3E7lsq3ucEDSiEydjMP?=
 =?us-ascii?Q?iEsUxSOfATwnt7lOMAZQO3K3HrZTjLIu3nCIRt5Laov7NZYJQXA+1EwkwE6p?=
 =?us-ascii?Q?5liDjY+hGCP+M/OimiT3yeSUwXBS5+Nl+v39Yrgjd0kxctVM5P030K7PXgR1?=
 =?us-ascii?Q?JD4SLsLhxwD+JlnOEC/rW56zYpvw1EC18Gh6iQEptmrRrIkp46jqNNGz4Cyc?=
 =?us-ascii?Q?TPwwyXRdwtVNGWqIKiDoaXCEjT+bAhSU8mxx3WaDoTfXOaLuzuMTfD4ucBbB?=
 =?us-ascii?Q?UHop1kfcuQIYZ3IxLCf+qg9/x9FOjii2/XWTtySD3MCti8Vt0BnluIt7MBdS?=
 =?us-ascii?Q?wyb6JbP8EqxeMucyz1NDXmPceIkRvanZvowinLA4LVPa7GS2wgtabNvrXhHn?=
 =?us-ascii?Q?nvgxXk/rljRlo+bADXuap0ZfYfhdkuzrs1aPeyWEtkashNToBNQyMlqBc/T0?=
 =?us-ascii?Q?zI8sI6IJ1BIbuX5N0WdoYeCy2Vmk5Zcx5cZBU5eYuiCh1b2FfTgvYKdre/KQ?=
 =?us-ascii?Q?1RJh4KG+AKgN3Ze+cZ7rK1NezBNSN7gfVpx0B0letTx1Gi9Br2QPdeJIpLM7?=
 =?us-ascii?Q?opJxpmGsw1XkKUVtRlQHpujmXzkHXTtS6r7b+QxbUnlTJyGhpiryMhcUougI?=
 =?us-ascii?Q?wlq3flhGARRT4PvjcqHrrvihZa1Rlf4RxrdtKa0J+FEUPeGkpOgUkXdP1vlI?=
 =?us-ascii?Q?gXczTj/FJgGTza/+l0vkLgewzxFSGkpnapu7gX+Yzd6siKu+81AD4TJ0o/TH?=
 =?us-ascii?Q?D2aA3ce0OPFQFNn0SOSIUzx0ap1XSlrPUCWhmjsT8bDPH3B2H8IRb6e9/0Rn?=
 =?us-ascii?Q?FeySorVbrnt/1pXVXnjvoVnrPc3kZ/zNuRyCqvJkYBK8PZpko/A8hN013ZyC?=
 =?us-ascii?Q?IdlH2Vvxa3+AnE1q2CMxGFvH7DsD/7v+3vAlEPMW0lDjv45EYwPPJ+WnfrMH?=
 =?us-ascii?Q?eC4akaFSp+L3jSNNW7hIV4UKEEII8lkuquf8MNGPzAaXolP3x4AVBdD0nh8F?=
 =?us-ascii?Q?Rgg5Dlw/aDXEqZxk5/c0LvJwr1JbwA3rTd9Zx0Pav5q7QHuybBloRwdcQpkD?=
 =?us-ascii?Q?WRjQoENtzeesWP8zl9Vxdk22/WbQ3zyqsXLgLEVmK3/XsQleuI1wvKOYk6jh?=
 =?us-ascii?Q?UopyB0SShmXCC9WzSmVDhRCltg6aRhIEUdV+HNWDyAvjOKCn2lP6YakqwRxQ?=
 =?us-ascii?Q?jgKb4dws8kVyZ+SxaxqpdhXhxKmgwArL+RcD7s61DPEK21pOg1c1Dcu3PHRj?=
 =?us-ascii?Q?gA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Qo712GdMIzGT89FGdrXE/NvE1P9xxGIpIE5h/ba+5lIqun9LpB15HDG6m7RTtuFAeVagjKDJjj8EYe/eRWELmvMUMaS1+vvqQSS6RwxZvdXwhazFfdTrwGAiUtuwHNGts9d4hzuNXG0mXudwbtHMq1OKalF5t3ZY0p1uGOYgJq4aSyqE99861GEpwXIo7SOo50kgC+uUJEIjnNwv9rnkeySiYo8HrTFIQOqXejZMj2CkcUfcH6Sj4uslbOpgPH4/DvNvT2s5580ZUMfGPoukxoChvfEIhC58X8Ixh1YBqElAhQvMOn6qNfh/fpWcs2abSNWaq2lf5d0pEa7g37bxaC4DidSm05c+CDFVZ3vGCvAuPlPR55WLRYJMVtb5DFKUYkk2n5Oj91bAyoUScK+xead+ECTVaH/2gLC19lWi2AjMCpfxdulv9p7l4BsK2qsSOKcIc56nKEZteNj2hydUUC3O1O7Soc0PeegmCACbZVMPWawTO4VsEkQYVff0lIHMmZr8Ibog8i6yAHpvwKKV64MFa1/qBaBoc5EulKKTOQHVDp8URNr6fauff+96UJFrZ0k7rceV4vnxNZHlBK8dsScb2Bc0D9YvkEgAPMXMNQM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5247659e-e0e0-483f-37ea-08dda9d5ff08
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 17:24:32.9148
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JxS4JzKGVRvXrIwoLC1xp/f7wlxwfvfqdKAdM2tZGwU++66XCTyto6Q4MKqvmylnyC+WNossUDEOqhljsYbASHnZRQQlbU7cUnF3M8FX4wQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4132
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-12_10,2025-06-12_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 mlxscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506120133
X-Authority-Analysis: v=2.4 cv=K4AiHzWI c=1 sm=1 tr=0 ts=684b0d54 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=meVymXHHAAAA:8 a=yPCof4ZbAAAA:8 a=BB2kYf0vqoGAcZWAHYUA:9 a=CjuIK1q_8ugA:10 a=2JgSa4NbpEOStq-L5dxp:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEyMDEzMyBTYWx0ZWRfXxSYwVIBNWGXw ssGuSuZeM7q+bcjzaqSOcKMFG4//iv/UyhnIvsHNURXw36rabAqRhvojP42wGJgOmGfjOKtFcjO sd1+hpoWlMbYfp+xWIiqGkD2zHZHhmpd8ePja9cDIgrsOTAddT7VQuhz4br1iycG41RKD8WkSaZ
 nRBrJGZ+sJEJKe79J5u5PFiMAk0wgIdkq/WFZkBL+CJNOXJIFvU8wyMnvbfbvdr70Z2pzinNpT+ ipV5NfOAobTBYgi315TPDXGimVPLG+hLDkI+Mr8jrGZgg01YpA5+kE48bh1LeyQxTFeyrXwbJS7 rZndaXkysifLtXqE+4Zs0uhBysal6MVxdAIrdK850OKNeCgKfuxH/FDZPllsECYg+ZXGKBvvuWj
 okolV8TeiNRWCuXlk8Njv8UkU9BoyrVJUVN17VQpGzEvdGMtUogDK5/0olyYawUYXEQ0Oyh7
X-Proofpoint-ORIG-GUID: 5FlWcJKrIhkzIuB9949iyMbIAvqXKvQX
X-Proofpoint-GUID: 5FlWcJKrIhkzIuB9949iyMbIAvqXKvQX

On Thu, Jun 12, 2025 at 10:03:13AM -0400, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
>
> Commit e73ad5ff2f76 ("mm, x86/mm: Make the batched unmap TLB flush API
> more generic") moved the trace_tlb_flush out of mm/rmap.c and back into
> x86 specific architecture, but it kept the include to the events/tlb.h
> file, even though it didn't use that event.
>
> Then another commit came in and added more events to the mm/rmap.c file
> and moved the #define CREATE_TRACE_POINTS define from the x86 specific
> architecture to the generic mm/rmap.h file to create both the tlb_flush
> tracepoint and the new tracepoints.
>
> But since the tlb_flush tracepoint is only x86 specific, it now creates
> that tracepoint for all other architectures and this wastes approximately
> 5K of text and meta data that will not be used.
>
> Remove the events/tlb.h from mm/rmap.c and add the define
> CREATE_TRACE_POINTS back in the x86 code.
>
> Fixes: 4cc79b3303f22 ("mm/migration: add trace events for base page and HugeTLB migrations")
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

LGTM so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
> Note, I will be adding code soon that will make unused events cause a warning.
>
>  arch/x86/mm/init.c | 1 +
>  mm/rmap.c          | 1 -
>  2 files changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
> index 7456df985d96..f85313a8b5a9 100644
> --- a/arch/x86/mm/init.c
> +++ b/arch/x86/mm/init.c
> @@ -34,6 +34,7 @@
>   * We need to define the tracepoints somewhere, and tlb.c
>   * is only compiled when SMP=y.
>   */
> +#define CREATE_TRACE_POINTS
>  #include <trace/events/tlb.h>
>
>  #include "mm_internal.h"
> diff --git a/mm/rmap.c b/mm/rmap.c
> index fb63d9256f09..0bc00668970f 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -79,7 +79,6 @@
>  #include <asm/tlbflush.h>
>
>  #define CREATE_TRACE_POINTS
> -#include <trace/events/tlb.h>
>  #include <trace/events/migrate.h>
>
>  #include "internal.h"
> --
> 2.47.2
>
