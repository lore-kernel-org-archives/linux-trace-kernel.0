Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD3434F47C;
	Tue, 28 Oct 2025 18:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761676955; cv=fail; b=G5aSi5bo9Zp4evZn2tc7yiCXKCBUFexQ4bVRa/MmwnhDNTEXXARcF1uPRVy3fPncDLue5+LEjwOSA05VegmyuUNRZ4tk4tPN4F8GvdI++tegfyN5elPYMXraMfdUIIVJlB28GZgaRQ53XOI5g6YBrXJZQC+Wl5Tcs1s1GPN8qKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761676955; c=relaxed/simple;
	bh=n6srmYjbS6LoxbG+BxO2avBWvdLedMrLpP0MoKpd6Cc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=p/mqfu3xL+D/Ygfxf42wvXXpoQbL2VIDBxPknrpVF/uSBpFCcNUkDatf2PlRfEE1fU1atorx/iWyTKoIZVmJQuFCh16ZoYmhgOAQYEP742XJ+CkIKFxW9YW78wrOu2F6TFbdQyDBg+c1MMSs0xJaFOJSX4apvx4aZZ1Lrg8EKk8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fqwipMk1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JK/hKOFl; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fqwipMk1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JK/hKOFl"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59SHq10D021132;
	Tue, 28 Oct 2025 18:41:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=MNoUIZukuE1KzasA2Q
	UtuzdQ35QygJxqgxkKD1NKEp4=; b=fqwipMk1821utQ6AFgti2QPRJ094FSzA4i
	f6+MmXePEQ5utAOURimhJl6/ZvWkJdR//5Q5sL3whvZhHm5FBztFiplYz637zLBx
	1Nby04+LAK4q6JqExokaMvj7R9o9W8AJcVSPLVfrZwcdbVKziBgwBiLeSVunH3Yb
	Zmv7b/v+iXhJI9Xy1FCKrhbk1vMS7LqE4Eeb2l2TU9K3SO4q8lKC4o6PuvEBBXg7
	Mqz09D3iGjV7c0avdl4Re5mYz1DzK9H4nMyTVuNfBQTWcjSKL/1jY1EH16mXQXPV
	s6t8sf5Z8oaXHfnzc7aIQ3vZ4Q+B0Jvk8U3C+kKv9WM5yeactK1A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a22uwmaae-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Oct 2025 18:41:28 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59SI8FVt015237;
	Tue, 28 Oct 2025 18:41:27 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011057.outbound.protection.outlook.com [52.101.52.57])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a0n08kcbg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Oct 2025 18:41:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cFR0ddynuScdsfwKGQxszQSyrVUdVlh393dN8WdYKrDciF6PuNR5T3IP4TfvLwNQo1YdilSAXy2AkkVb6i6HoMhnn1ROvfKdkXTUvYH0yhGaUyVHFEo1VqK6k8bltt8H6gzqw9xDHLPQvwxD6SINhnc5qfejADGsEdHLH3S+cl2HviUFweoKUFBvyjSkZ/VJnMV2mFP9HuJ40BnITU+ULb9GuBH9Jak43uPyOqVzSFcheHqETUm+PKRALVUIg0jObUIji7P7ygpjZfimFA8SWmpIWjC10Kwl/TEx2DIya14A1MWxo8wKeWQHZ5iz6eQPCeOW02dT6k8eFEzdVUwNpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MNoUIZukuE1KzasA2QUtuzdQ35QygJxqgxkKD1NKEp4=;
 b=cG/EV6ANEp3n9jtAOH1TeZAYd37kovSjTiLRYBlIoYaYcg60ua9id+9VhIhnoaJ+iHz5jmuO7NH30eCfokscDTjlJI65vFAxtJG21FJix5e6EH2i1W8LbesVSiQt3QBUHiXflD1uawo+va6XDdsKu/+L7C/HkIF6FJjbVQnw/kY22gVNGpAWA8lZWVZogxmrnNSjLgtXol/RxNrtWMwUuDVtYriKY/79Y+4I9vaY4aFGHrk4hbGe3t+pqzVJXIkYCjUetemr1+R3+s2O9Gnu9DBiShd4ZLA9AOQvRAmiS8fJ1RGiiALy7nRnjHVCnnWm+Zij/YDtbnk/+h3l4txA5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MNoUIZukuE1KzasA2QUtuzdQ35QygJxqgxkKD1NKEp4=;
 b=JK/hKOFlTsUyTRSGfMwUQ/gajU92wYKAAZ/vHvuve4Nsq6Ku1ELtHZ86xPVYh6P86/lF2ARcMf5SWzjF5Z1kRboA2bDJQiSGtqAffG/KXle5ZUTUWudclM9zP3S7tJqw7wF/qf4HdsN8eSMpRZ5Jihdy7KkcXLuQI8VXoGVKcYQ=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM3PPFB0C5EC304.namprd10.prod.outlook.com (2603:10b6:f:fc00::c43) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Tue, 28 Oct
 2025 18:41:23 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9253.018; Tue, 28 Oct 2025
 18:41:21 +0000
Date: Tue, 28 Oct 2025 18:41:19 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>,
        Nico Pache <npache@redhat.com>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, ziy@nvidia.com, Liam.Howlett@oracle.com,
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
Message-ID: <a97780ab-6256-43b7-8c0a-80ecbdc3d52d@lucifer.local>
References: <20251022183717.70829-1-npache@redhat.com>
 <20251022183717.70829-7-npache@redhat.com>
 <5f8c69c1-d07b-4957-b671-b37fccf729f1@lucifer.local>
 <063f8369-96c7-4345-ab28-7265ed7214cb@linux.alibaba.com>
 <9a3f2d8d-abd1-488c-8550-21cd12efff3e@lucifer.local>
 <e2a89e74-1533-4a83-8d0f-3f4821750e25@redhat.com>
 <64b9a6cd-d2e4-4142-bf41-abe80bf1f61a@lucifer.local>
 <dc002ef9-53ee-4466-b963-baadfd5162b7@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc002ef9-53ee-4466-b963-baadfd5162b7@redhat.com>
X-ClientProxiedBy: LO0P123CA0013.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:354::6) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM3PPFB0C5EC304:EE_
X-MS-Office365-Filtering-Correlation-Id: ddaf5104-5276-436d-a536-08de1651971b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UArkg9gFPdYvBW4G4X0idFiroBzkm8es+XB7A/1uwo74bUzxm+js8Ep2sTOh?=
 =?us-ascii?Q?WrQoe6/Y98q/g9wNTXMdH+IeYrDN42aon0yqtAuCBQdcIjH/S5QVJVSd37kL?=
 =?us-ascii?Q?dPzAwB2B1R349MqCUvOWNlldKJ5kSXGGxtHr9JI2L36I69LYK1oi/Fmpo9Ea?=
 =?us-ascii?Q?rfABZeieIK3iYZp/Ahlce6eFvfuh/E6YDyr/7YhojkXnNPcRkm6x1KCA9EFR?=
 =?us-ascii?Q?xjFkaO94/XiRcSQNVZYpbUo2Sox2Xkm2bno/KrCWwhiutBHGSUnuDUKixftL?=
 =?us-ascii?Q?l+9UKQHD0nlVQOFQE07/8as8cUslmyGEpu9U9vx7bsNjrl9tkmsjrN7pdTKs?=
 =?us-ascii?Q?H1bcoG+pHpQGgvH7vVXRMz96tCoc0UvEqzrMi0Oy0S+sSWO0VD4fmUQEyGFo?=
 =?us-ascii?Q?JnozeYxNKaWxsY14sglMAivyJ0vnBE5ynLintBslX2JCue5GgIM/xuX+bsEC?=
 =?us-ascii?Q?i87XGFr+BCzqmtUBM3S+So9XXBOgaboBZqcQl5r74kx6nVzK/kOZMC7JrlFW?=
 =?us-ascii?Q?SInupIbKlIGEiKTOxrdqwxCzyYauOtM75+yeZBpj9B6X0hjr7AmHNBk/dUPt?=
 =?us-ascii?Q?uR5udVNnh9PjkQBkA2NuIjGw0nCRdGXv/iE1+sVTZMIIGOlBRqfHVDvSTTuM?=
 =?us-ascii?Q?Q+mvdwknDE2Q5J4QbputtHIST1vv1KU9krRmPZJBiGYY6GYz35hU2WPcDnlW?=
 =?us-ascii?Q?mV3aLWN5sj+Pvxw3yqPu72Uu9LaafeF8r2RHgloNoykxmReyIJH36mWndYG6?=
 =?us-ascii?Q?u6FHUtX7f02NYXduMVOJ1SIj5UnjAGY7VWIEsP3lRa+7rSDyYCebNp8yh49B?=
 =?us-ascii?Q?QeFVQhXfU3YmaLWHM1kJe0FIPfzAI8x0hHhJljKakLmPz/0MitkY2/rppYUZ?=
 =?us-ascii?Q?VQ16OxFMJX4cKerf5nkCVFFErRzKg3sC24McvHldvsodLgL9hDiZAyciLaUg?=
 =?us-ascii?Q?j/x4qrgEoU+wdv9j7VUNsF+r4aiXaygjnmMebIMFR+pT39cOwR8zTKtcokpL?=
 =?us-ascii?Q?HuPrw8fBphqvg7XpDrCXIM+ieZcDSrmf3GctVSar3svgewG8nO0ePGU/x7pB?=
 =?us-ascii?Q?YSWPBZDGOhSKoyOPtH4BGPIIdxtDe0tum8Xah8Qhgwp6+hY+Q3MT1Hq8cXW9?=
 =?us-ascii?Q?cqZYRRhXkXkoTMCf8UtZD+fxf3sxvFUafeUX8rrL5I4YcI1DwxJ7u44Fbb7r?=
 =?us-ascii?Q?lj4pv2hzEVWy71D3QXmGPuL1eQOrmJTXlN73GqmRJQ/sWCgVzTNFf7kigolw?=
 =?us-ascii?Q?FBqkgNGEc5GeqqVNaYTGHklfDEmh+bdfP7Bq6ed8184BsBBdMDCx5Z1TcWGi?=
 =?us-ascii?Q?f2/3WepmpLxanCei3kyq6Uc2kWjlpBn1/vG9ol0mTxYwTyEsX+Y9CbHkNB3a?=
 =?us-ascii?Q?EunC2go0w39JZVrBIHiccpfXr/cv0uGjEKizqG49+MyET6qMNmaAyl3PxVxZ?=
 =?us-ascii?Q?d6uYUPz1fmiz8Dz9+WSYqfdgB/iCkC4d?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2xD+lTlmsQNrUOZTjHhIBq3QmWgxYqVNKMzzTsQO5/TFj4DXGKF4vU1REQrE?=
 =?us-ascii?Q?hJNzorGHD+XzGT5dJIfz8jd/ocUKUrtz4nzAKgSp1WIwJX+GlZrk/pQ3OB54?=
 =?us-ascii?Q?xt2nzgYlOnGd3yLmJ+GeJMp1Z9BaFmoFGnFjybVd9mO5G+aejrnI9/SvIfKI?=
 =?us-ascii?Q?nTbqX3BaJPgI8lxlQ8vg4h4NnPFu04TSCxQqj3DvkcSLHK9BJ/uQEsXfPRh1?=
 =?us-ascii?Q?BvfzSsq1Ts+/GMmOypUKO/mNWLGDv9oLlMrqqyxCGmeQ5/nP9/GSGzgVJ0Gv?=
 =?us-ascii?Q?2o7SPe+3lcHlCNoxShOmMKrPEUzoNgEvv8ixTFZ73gY6DpYFs4j9WQa1c3du?=
 =?us-ascii?Q?OH5PWIaDHz52i3Ar7B4Hz7rs879OrSXhZoe5ELTsAGwE6L5tswcJ1y+WHKaL?=
 =?us-ascii?Q?FkuBEuveA2QAVkOonvY2/X5idli7hGMzoSwXpDNDY/arOvMxMRJfc4g6yFao?=
 =?us-ascii?Q?AXDI7HY69VDs0WB07mI5JMgQI5qbKzVrQEjnrQReSSS1opeiTkykZMLSd13U?=
 =?us-ascii?Q?ijlzRM3cG9R+/nOIwyuNsulfDNf+EtGR8G/sxym8Trk6vmYE2y2C4xKs+qkB?=
 =?us-ascii?Q?zFVZ6XMYLHm1D9o7ajgqExP72Fu+iYTpOwLDntd2aY2G034t8necl1qW1IH6?=
 =?us-ascii?Q?e465MV9iZDC9h5VwBR2VFMuZ+kiWIgJTrCJEHl44J7YT/imPRRbuNHNoyPdh?=
 =?us-ascii?Q?opBO1o8uIKMbBzmmT0PoocYm2yvk+mZh3VYYbqpW9Oak6hQ/gkRuPHG3OKkF?=
 =?us-ascii?Q?Uuo+Z1j5gRhi5qNIKayaSJWl5TuC8ruMOf9X5rGxBgUFkDTjwvqi9AwXkr5m?=
 =?us-ascii?Q?ivAej7BO3EJOmlJ5ESzvFAcnomF7PpAMvlw96b6HyAuf21bmBu9Jfs8AHnF0?=
 =?us-ascii?Q?B76ula0F85ApQJbgYuL4/v3X7lcsOWHcFBSj7rQSkF2DPTDFk7IALornJqxh?=
 =?us-ascii?Q?Ltx1FOY3bj1H/11BSDfKEK504xUJ8QZmxTw6e2OQ5L1zX4BaqAQEsQSRae73?=
 =?us-ascii?Q?K6Zq9hHGZiao0JjYBpMcO6hXEg6to0JqM7VTmlLV1pAwVBXvskzmzuph3Gam?=
 =?us-ascii?Q?wMsHKm/s1pIXSmM/7YeIePQ1om6LMUHC1hgKAwRbnL5/CRK3LaKlW1z5tWTx?=
 =?us-ascii?Q?pqn+49yao33Q1s1vHmpc3sjXuevlGfN6lUAzNhE6IKAl/CdKviTYcf9b+BqA?=
 =?us-ascii?Q?UmnWT1wV4DB9mEOzKXu123zcCtwaFXGMk5TCdOKmD/MuC1VtuXb/Tk/vOuiI?=
 =?us-ascii?Q?gbQHiNqxU7Y2AcnFfshOXUvrgLWDQIPHJ0iANlVG4IDHnHiT0/bbDzkBLB76?=
 =?us-ascii?Q?yAWX/yxYPN/epFmTGgiBhhGNkrkxL45mi2IOY5lvryjmZiDyQAE/HDfMEJ/Y?=
 =?us-ascii?Q?N9g9N5B+80g5nX3JwKNkd0AmLF0kMu3uhP66B/l5xEXZxym9Ng0J+O6ZLmXR?=
 =?us-ascii?Q?EBSPptbYV4oUapC/xE5oFX203lborbkykY7X92Y3fimy47ntEI9DaLsAqC43?=
 =?us-ascii?Q?u0x9ecQ1xbWFqhZUzYDIkm78bGCtTh4NJUfc8Een4NUo0fpRJoRECrvbQSqu?=
 =?us-ascii?Q?kKX9yCYKmckOO3uvkwhiA+z3KJcOkpXnsdE/BNk5+i6t86Hm00c+3ktfq1DT?=
 =?us-ascii?Q?eQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	B3hLOz8SXY0l1cz2WoPAvWCzh0fTa72vvTg2ICGpJZnQKcUWJJ5kNxw9K6WbFAk+UVKARuRJeT8zGAIY4Vj06te2SC30knr6yb9EO+0dk7PdyCEPnSY5zhO2HgfZBSSPoddCaYqjHFV7m8mSQ+cYPyTq3rnP+fv/96uyg/s3q+KLiRVZFv+242jEjG35pDyCOVtD3tmwqrHq8BmPnM0unacGSIokAW2g9bZ8G8sN/qt6X5xBpItApaN/QM4JJ9k825C4VNBs/hH2+IqTPrh+bhY06lefxm6N0E0frorshEYPZ62/1lWKyutw63nVf0U83kxRHlA7cnD+/T+K5LFJUHKzr8mTkrUq9xzHS3fjQtkLawKZYIivvi8mlM06i+za/4LzbHkeCfqyAA+MnGNVqeFMJZnPNd58BLP4YOMsdv0DGxTKU1AXF0O4UolxLsPlQOuZcZ4qDv1jZTRPsXP2YOCtoXkFJjCBjF9vsYv/+xy4/90kAy2GNeiIFqp3+YlGchWoIZt57srmvyhMJBLqrNhGDma8F67KlyEs9tzHLyzu/CeHU66vIkux+QB3KSwB2RFJMyoRAvLgQkMzHHSxtUDT4srmKejxdk9zMzvthM4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddaf5104-5276-436d-a536-08de1651971b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 18:41:21.8192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kye2Y9CzyW9BoFvhib4/KbM6mHkisElDOkeGQnzxocfgIdDGcN1KSZeX2LV4KggAInG2Xw7EYhDU4LcKZQWi9PX6ZI3VvM/2uFEMiFFlI7I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFB0C5EC304
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_07,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 adultscore=0 bulkscore=0 phishscore=0 malwarescore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510280157
X-Proofpoint-GUID: VMea90VCCUSVbs5vUcucYy9tBYNMvzGQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDA1MSBTYWx0ZWRfX0u3M/7ulnhyK
 A8Oa6GcNlEv4bSt+Y/nzmDuBIPuHsEGdH0daXqsG73pclMFWWAaYXO6KSPz2ye595addeZbyCzp
 Yn6RZpMI5YJ0LYec6tDqzF+bvxmZfyz9YM8mXGuBdSzHXY4u3GanIvkRMBOAiJO6MORZHt3/LUC
 XH5Zfp4wXzqqblSFxzE+LnQW6wm2oHJQzXA+2fapKVzjuDzvA9fwBBCCoyVMt06dfHIAfKYxBeA
 dBAitKv87ZBKvQZoQAnfuJgLfwsSoh8Iuup8eiiHAq55D7FlhOXg9LDYZmD7mUAp3PUTi9Uxq1i
 qufHYzSJ4HVvsnwsYn8M0nDLNzFpJL45K3Xc0sYo4OOss6yCHfjVmYbHteKJ4asMyMPoNsg0N4K
 ekWKzvEANiJOWuDzOqxVyQxBCsfxkQ==
X-Proofpoint-ORIG-GUID: VMea90VCCUSVbs5vUcucYy9tBYNMvzGQ
X-Authority-Analysis: v=2.4 cv=Ae683nXG c=1 sm=1 tr=0 ts=69010e58 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=3CRimu3O46DWhcekXjoA:9 a=CjuIK1q_8ugA:10 a=UhEZJTgQB8St2RibIkdl:22
 a=Z5ABNNGmrOfJ6cZ5bIyy:22 a=QOGEsqRv6VhmHaoFNykA:22

On Tue, Oct 28, 2025 at 07:17:16PM +0100, David Hildenbrand wrote:
> On 28.10.25 19:09, Lorenzo Stoakes wrote:
> > (It'd be good if we could keep all the 'solutions' in one thread as I made a
> > detailed reply there and now all that will get lost across two threads but
> > *sigh* never mind. Insert rant about email development here.)
>
> Yeah, I focused in my other mails on things to avoid creep while allowing
> for mTHP collapse.
>
> >
> > On Tue, Oct 28, 2025 at 06:56:10PM +0100, David Hildenbrand wrote:
> > > [...]
> > >
> > > >
> > > > > towards David's earlier simplified approach:
> > > > > 	max_ptes_none == 511 -> collapse mTHP always
> > > > > 	max_ptes_none != 511 -> collapse mTHP only if all PTEs are non-none/zero
> > > >
> > > > Pretty sure David's suggestion was that max_ptes_none would literally get set to
> > > > 511 if you specified 511, or 0 if you specified anything else.
> > >
> > > We had multiple incarnations of this approach, but the first one really was:
> > >
> > > max_ptes_none == 511 -> collapse mTHP always
> >
> > But won't 511 mean we just 'creep' to maximum collapse again? Does that solve
> > anything?
>
> No creep, because you'll always collapse.

OK so in the 511 scenario, do we simply immediately collapse to the largest
possible _mTHP_ page size if based on adjacent none/zero page entries in the
PTE, and _never_ collapse to PMD on this basis even if we do have sufficient
none/zero PTE entries to do so?

And only collapse to PMD size if we have sufficient adjacent PTE entries that
are populated?

Let's really nail this down actually so we can be super clear what the issue is
here.


>
> Creep only happens if you wouldn't collapse a PMD without prior mTHP
> collapse, but suddenly would in the same scenario simply because you had
> prior mTHP collapse.
>
> At least that's my understanding.

OK, that makes sense, is the logic (this may be part of the bit I haven't
reviewed yet tbh) then that for khugepaged mTHP we have the system where we
always require prior mTHP collapse _first_?

>
> >
> > > max_ptes_none == 0 -> collapse mTHP only if all non-none/zero
> > >
> > > And for the intermediate values
> > >
> > > (1) pr_warn() when mTHPs are enabled, stating that mTHP collapse is not
> > > supported yet with other values
> >
> > It feels a bit much to issue a kernel warning every time somebody twiddles that
> > value, and it's kind of against user expectation a bit.
>
> pr_warn_once() is what I meant.

Right, but even then it feels a bit extreme, warnings are pretty serious
things. Then again there's precedent for this, and it may be the least worse
solution.

I just picture a cloud provider turning this on with mTHP then getting their
monitoring team reporting some urgent communication about warnings in dmesg :)

>
> >
> > But maybe it's the least worst way of communicating things. It's still
> > absolutely gross.
> >
> > > (2) treat it like max_ptes_none == 0 or (maybe better?) just disable mTHP
> > > collapse
> >
> > Yeah disabling mTHP collapse for these values seems sane, but it also seems that
> > we should be capping for this to work correctly no?
>
> I didn't get the interaction with capping, can you elaborate?

I think that's addressed in the discussion above, once we clarify the creep
thing then the rest should fall out.

>
> >
> > Also I think all this probably violates requirements of users who want to have
> > different behaviour for mTHP and PMD THP.
> >
> > The default is 511 so we're in creep territory even with the damn default :)
>
> I don't think so, but maybe I am wrong.

Discussed above.

>
>
> --
> Cheers
>
> David / dhildenb
>

Thanks, Lorenzo
