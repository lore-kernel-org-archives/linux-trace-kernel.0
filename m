Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2EAA1DF754;
	Tue,  8 Apr 2025 17:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744134114; cv=fail; b=qFJkdzcyRAxcAVJz/G9uJcVNFO8bqA32/jzxjJtpOxRRGCrQ1wlktsYdu3s/vF+LIYK5gNHTTosWWpSB4pnZZ9+uEqE+06UBO4Lby0O6NXvDNwXWCyqZUJlXiCJXHp3XEulBwtLh8nX9Xl1Tul5S6bUTjSVbjEpF69Hm1x1h+64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744134114; c=relaxed/simple;
	bh=H14YyFJwqR50UaTdjNHxEE4Q6NuL12q6QrHXBdUQviU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rNb1XsCfYXbNMKQi9DEmmLEQE0i0/sdljEnGUhcRUscdYfy2VW8OqpJmOASmp+EhcmvLaXhbvsFG86XMduH4i3e/ni+1ClXUaHgmv/IkL38bo6b8EWhe90rA29pCxGPVTvKi7mVMElte19ztgcNrAMGHAsRMgVi0J/5PMTdPTK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nMmzsE8/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=aG//oY5f; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nMmzsE8/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aG//oY5f"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 538HC4jw018924;
	Tue, 8 Apr 2025 17:41:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=LBWNLad1WRe+XSadh5
	UY0a/lNcRbQ+eb6nfEZXhr/v8=; b=nMmzsE8/Kmy0NTUuPll1+Qj4XC6Jz7+WvK
	8Zbo0B9O8VNFFrNCy7IbOsSIhAUN/RVK5/iX+gzXQf6O9IRPCpqC3kfonXz/aE72
	whgHESwBg+YE89VNSy8A/Sx3cdcGiqRW1satwf40Pkgwsb6Zv18WlQVNbrY3OFn9
	4oCipWrrNBah0gbr00hcYkUja/BMIiQ4VArfCvNylILGyhq8zD0WLrbtZPH31Fvv
	rruKnVTYKUyGPkcfjCOIEDTHMyky9NbPGtrZtI7LkHbwoH9OPQILlDI8At6tZ5i/
	TFZjhb2LcsjnCvbwtj31shT/l+Kqv9VdfZX0jaI9SaFxY6kLl7dg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45tv4swekh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Apr 2025 17:41:22 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 538H4l3v020955;
	Tue, 8 Apr 2025 17:41:22 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2046.outbound.protection.outlook.com [104.47.51.46])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45ttyfxmnt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Apr 2025 17:41:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x0x8YqawYAoMsxKbeJRGNOBLUIXmJPIoFQ+MptPBpfXXwfBXSstnNJyGIrw/F0mdTIizcyMkNAeQaydcLcoTf6Q7uBihzdlyRXhp3yq8gVeEhToSy75jTroCmMmFQ4wJSuPdbAIGKuaq1R6RyK3nny4lBesZrNYCbb2uvBEsc3WJFJ6w30MWNFK+ZjXpiW0y6KKWJTrNMN5FQL/+UDs+uqO2J2Nv1HNX07s7U35wI49yAMTGRqLRPoTuJ8JIVDwCKFYNf4UznbN1BHCK4QBGT862SeTvwkK9I16r5+1wXPswpIzk77m2gUfIYb1fmjk//bXGbNqxfXknbSqwkuzdeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LBWNLad1WRe+XSadh5UY0a/lNcRbQ+eb6nfEZXhr/v8=;
 b=Gg2wP/92rqdo8dsFpRD8f2ixjjkjVBOmc3CyB5BOcMfOfxotjZlYjYe6BNpOYEUvtSM86Jwp7M50gpQlQhXDX/usxy9aHLIIpA0fHbJAQNAkV6rGSH9e2ffFZqN9yTSju/UaCnW7OQNKNA/qOM7Z/I0IkEVOsLVd1PeMFUNlnwnqBoZQ+GoGmiwlpCjtHKpqZNecDM5YbKk4wXCrBY7kXP/7KJ1NiyUn7z/nZ6u01z5hehW5T23esobcE2bucutGOPAyD4UGXamV6DdHt5yHTUMiwKoVOkdxKGbgbWLrdmdj/B4IMk9I0CYqD8hRCPiOEUUFfr40zbwR9CvFYFZb7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LBWNLad1WRe+XSadh5UY0a/lNcRbQ+eb6nfEZXhr/v8=;
 b=aG//oY5foXXrBooqK/kp1SllOHMwP6bdhISRH9FlOsKOvKBEXKkhZlQJPhsHa7z/DJgq9kFgREtGIxg8EWz8YzVPWpjduDnStIB7wS+XcdSsF1XUQlFcDQo/mKUKDh42ow2FV3ntfIfJwSuqO5lvJVniWg+qkJar3Rc4nlGb1Mc=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by SN7PR10MB7004.namprd10.prod.outlook.com (2603:10b6:806:328::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.21; Tue, 8 Apr
 2025 17:41:19 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%7]) with mapi id 15.20.8606.029; Tue, 8 Apr 2025
 17:41:19 +0000
Date: Tue, 8 Apr 2025 13:41:14 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: "Christoph Lameter (Ampere)" <cl@gentwo.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Sweet Tea Dorminy <sweettea@google.com>,
        Mateusz Guzik <mjguzik@gmail.com>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Martin Liu <liumartin@google.com>,
        David Rientjes <rientjes@google.com>, christian.koenig@amd.com,
        Shakeel Butt <shakeel.butt@linux.dev>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christian Brauner <brauner@kernel.org>,
        Wei Yang <richard.weiyang@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>, Al Viro <viro@zeniv.linux.org.uk>,
        linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
        Yu Zhao <yuzhao@google.com>, Roman Gushchin <roman.gushchin@linux.dev>
Subject: Re: [RFC PATCH v2] Introduce Hierarchical Per-CPU Counters
Message-ID: <iqa7gvbcwyw76jd6cgimp5jbu4szxob5ptjvi3rzll6amfjygg@cunm5zrgm27e>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Matthew Wilcox <willy@infradead.org>, "Christoph Lameter (Ampere)" <cl@gentwo.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Sweet Tea Dorminy <sweettea@google.com>, 
	Mateusz Guzik <mjguzik@gmail.com>, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, Martin Liu <liumartin@google.com>, 
	David Rientjes <rientjes@google.com>, christian.koenig@amd.com, Shakeel Butt <shakeel.butt@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Christian Brauner <brauner@kernel.org>, Wei Yang <richard.weiyang@gmail.com>, 
	David Hildenbrand <david@redhat.com>, Miaohe Lin <linmiaohe@huawei.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, 
	Yu Zhao <yuzhao@google.com>, Roman Gushchin <roman.gushchin@linux.dev>
References: <20250408160508.991738-1-mathieu.desnoyers@efficios.com>
 <f90d7646-99a3-48f5-ba2e-850c73592080@gentwo.org>
 <Z_VWc6Z90rhfyLBp@casper.infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_VWc6Z90rhfyLBp@casper.infradead.org>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0353.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fc::7) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|SN7PR10MB7004:EE_
X-MS-Office365-Filtering-Correlation-Id: 3840623a-ff2b-43c9-cde7-08dd76c49230
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MnTS4ktbVvKGWbiV9ZU7Ley940+fUht5mqlxtQ6qPhFRo4g7DV9A0z0lFAqE?=
 =?us-ascii?Q?2Wwz7tN7myzx1KTtIRqYJ0c8/BlYHidf/3/gwSxj4WSHPokwHSHmK0jCr/NU?=
 =?us-ascii?Q?ySEQQwwkz1cfQoVaSQwY60V4LtCybVqakATIW5TJlBqrvHR9Nvw8Ma53a/+5?=
 =?us-ascii?Q?AX0Arrsfm5zM02EoGtq7g8CW2nAhTOqYFMS2C040ykTwYceHZEKo05LbHLjX?=
 =?us-ascii?Q?2iHyOQa2rAgvFPPIBHBFd388bt5P0/WZmbZLd9kArlOIbww7+gBPewS+kT0f?=
 =?us-ascii?Q?h+WnoIRKfkZX8/tGixwEFWzJoQvunbDQEeygC/Tud7ga6Nbegw1IeBqbWHks?=
 =?us-ascii?Q?WA9atguiG4dNtHHAxhmOjP3qJmka6B19MNcMy2yNIrHH4SXCTBwLusPtMPXx?=
 =?us-ascii?Q?ZCkKSxSYWB27b+UdT3CFglXLVC8StulMJWme1du2RdgNI9oLnQf+rnpNBiMH?=
 =?us-ascii?Q?c8FzCPDYJSNIrWJ00+CHhxBbJtL+h4b9yj+9hDTMNMlA5IPToyBySuaQ0k5z?=
 =?us-ascii?Q?Jmh/TDRlhrwPYFMxv6OHWhFJxP9wJv0Y82XujTtJK7XI0MqE2yg+SQ2Ogpy/?=
 =?us-ascii?Q?C9Zb3/eI08toePzWWQKY0GZqIyTTFELYOhm4UjZpY5bUKYB2+tM1xCExKexe?=
 =?us-ascii?Q?M6ljTp71B7hHByT+9HFCvRfKwm0uRTr2sOx6OOzZyRlNvniVb+Hq904MFkld?=
 =?us-ascii?Q?7dBM+kcYlIBDjLHm6mUfsY2AwTILKSWyoaxUmj7F8QCss0g41HvKndDq3Rgl?=
 =?us-ascii?Q?HJhK3VlIu9pZbjuDu2IqRH7S4qtWYiddoNeEtefROfxZ3uTmHO/h1WqA0KsE?=
 =?us-ascii?Q?NfP6OnPTr1UYlFhrfHYXOWf0j6bxRWqvkdVsHnS474kmDfptBPQYJiEtOtGv?=
 =?us-ascii?Q?JI2dq+GoqPKb+lQCafbXISuMSKz6cyVsfzNDKkci6WVgHaAiwGaBsQ8Dbg8O?=
 =?us-ascii?Q?BrevEwtgOIrMuhLoaVGSpxnE3OrElr5nFpUtdARi9T9ZNxTZas1Z67jjNK+Q?=
 =?us-ascii?Q?ZJ3R67fOGXRqanzgEc0a+mjhLGXm9rPU+sjvJp06pMpuDJ7mbQLMLeWDg7ON?=
 =?us-ascii?Q?lGgmHDIS5elsmwT9fZ5b6p9ku1lt73tkreE0v3160+XU+/tHzN6kREOmM1VR?=
 =?us-ascii?Q?SQ4gr4jUNa4R1MQwYWSHzn3xUnnqnLj4EdkGAGegOBgSDn8XQDycUEClkTHU?=
 =?us-ascii?Q?QhFWIIIaorsQmeb61sdN1e373OG8li26lHWLYGGW6R6xIOJbRMnedkYeYhYK?=
 =?us-ascii?Q?PPgKgVM346vbc4UNiNQicoyhPxOm94VjfdRgdDBUXese9T85n2pfT4YnYUGz?=
 =?us-ascii?Q?c+gv9DYQmoUY97Z/qevBwu1n5XxnKXm+LlGeHhp6rce3JuoF+gZVDhf2Ykjy?=
 =?us-ascii?Q?KVqsBUJbesfeSCtH9Ftues9EOP39?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1BlX80ZlwptKNkB7VPtWEkszFdSUTQr6zAKduphpmROWiV3mBvAkSImfdRkg?=
 =?us-ascii?Q?QWWJxRK7OEoN3rNdzLeCLMEoAepdPUQpXou6/RJMA2FFp1AwZ78Cq35vbayg?=
 =?us-ascii?Q?tT+k7m9E6iQYTiwofUavI011vJJSkjet6wtHEAyN9aD22spbIF+d03v1/M6O?=
 =?us-ascii?Q?v+nWUNB7HM57GK7BUZ0g93ZNVYq15TeKMWrd+JDxx1cnA0YrqKC8uqA/DW/U?=
 =?us-ascii?Q?dwLt6BHX2X+VaT3kZrAt1jhW/hdJD+EtWyC3jWLmENT4WI0RjT73P9ZgRkqc?=
 =?us-ascii?Q?aMZbB04xz7uTDkvv97KSmzj7R6ZrL7FyqHk2PDJiJNsSc6at25DgfZdmF2XZ?=
 =?us-ascii?Q?zNTa5gBuQtU8YmY4+i3203Zpg0VNrgSdtBK8SXUpFVmP7csKRCZBjL36qd72?=
 =?us-ascii?Q?2e8vLLBCQh8KYu5xiJVjkuTuM9z/RdB2p4mk3RhIfz1e7PWA4gmvEjc5AWvF?=
 =?us-ascii?Q?cuFbbkEKyxvNLtLLFKJ5IPXVG4T3ME/q0M6lUfYq0g+cnX9wfMMyWjMidt7k?=
 =?us-ascii?Q?gyDWPN75T2ZttAh5sBV/2rHZfWDlEdqv5fmUCbsHetXISnDsy4I6b1s81LDQ?=
 =?us-ascii?Q?P1AD8y+1dJgTe5h7BoOdMcdo+Re6d4HzB6n7s+7IFoaV/KkPhF/SJLnyhEfE?=
 =?us-ascii?Q?TlRIEGaK0uYx3IE/MMPeiK8NbHQi+JCxLcL3HHrm9OjnhCVt6MbxC6dwtOd6?=
 =?us-ascii?Q?28F636wuSqEGAr76o5VXr51Mym6oe2cjOXXZbHfFMQdhRthZT94/U5iwYIng?=
 =?us-ascii?Q?UsUWAmE1MM8FYStppxC49K4g6BfyqMpGzszPJxc0FfsMLqJ9O/jjxjevzgb3?=
 =?us-ascii?Q?dO++3aMe5QWoEHo0UwmZrJ5/t1iL85oEfwHtTn59abOMWCdHRfPJ9BaAQhf9?=
 =?us-ascii?Q?/Ongsk3Eds2VHyd2ncaDFArs1MUZbl8k68tLKGbQ/BvTE8avJ9xS9vt2Ln8U?=
 =?us-ascii?Q?PHgqvbDiWyd3efch/wkJoPjnXHY18nk5RHv+YvcSOvm2qalyIbxPejAdAN7F?=
 =?us-ascii?Q?Qy/pUGbVM7opXmm/rVTSCIncXFRbRm6uVj9k5kwGsO5ZjTcPkjKQUxC88tjp?=
 =?us-ascii?Q?LjJK5DsNcKZ+jESGYAvqBCZa/ItuCmCYvqM0SHzJ4GxVhINWg1+mMcv0xhme?=
 =?us-ascii?Q?Zv2nS943WDV5yGncitp1wz5gDPi3rvdIz7T8ZJPEHPXD2HLKjUVO0jNFxtu6?=
 =?us-ascii?Q?sNXPKJ2X2r1yTmz7XJW7WU9onRYq2V7GxgijD8fNOTBYgZmjxMF9305ZV2UD?=
 =?us-ascii?Q?Z1OSKCTDvs25fc8da0TGWu2psGSdujOX0V+0GvwzanvusuR/qYXZg0/LccB0?=
 =?us-ascii?Q?idohPpPqsK4J20fJS9JQvy9+f69l2xC4gYuwfbJ5GRzLfC19FC5sUwaVEu69?=
 =?us-ascii?Q?U0oCFQjR4zuLC7LGajg/yVxM2D4Osi76mOVLNk7a9Wu8tCyyEg2cS8261RUW?=
 =?us-ascii?Q?GnHo0eZ9i7itywlO7K8WySbwM03G1k7NhtkH+BPO/ROlaSaG6x0zFF0SCAhp?=
 =?us-ascii?Q?LAmJ/3bUm+icbUZTZRdXtlvl+syLZjgYYRDImJ2dM+g9RtVpiTZT2AocjFfZ?=
 =?us-ascii?Q?XkRjcxZjfMGkybyT4EbK53d7u5Dq4VSVA7AcNi4o?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DR8zOdCFVxC/EQq3kxLD60+zX2nMQcBXZHO2ARwY0Ga93NPxI0+fI57e9+rA+aFJPRNGR7upLWkPnC9IvQC6h8IBK9dWPAwJDwQWGmRnNkjMmzPxYj9tt0Kt8BMWOBgwt2Lw904Z7YqiTacRkFm+ksbeCbMj8YKIeyAyogMOjso/HE7H4n8m753nkv9M8/Rw2f99ib1zMupYH83cY/ED6EYkLJdiW0l180FX2Cl20FN/t311U4uQV00PmsqGc158EK1lreiG0gjS5FnHggM6gaYTiThQaCzKcu3jCrjm3og/LEN1/F2ntyW+P7cpBM0qofSUgIDoQ+JqqB0dQlsy8D0e6RhoRpRzLA5LcGYJxprleA5UonIgQ6eiJHVEleGsehgaiCC8wveX082t50GyUzScqKTHPoK2XjoglEQ/iBOvM28qBOkCogDBjv4bE1lUeyNq0N/KfT8eokSyQNKpJxFWWaEd2VZnNI+xf7RFGsO/q3ZY1lBAH5xtbcdSFeY+SAHWTsnU3NcnbIxRmRk89lDojvl1eompbCDOd/kQZrrrUuPYC2iQ7r6QeYxN2rQvbCbgn6+njtgVwqs1sZlvy6ABL5GFU08VqU5LAYMc+z8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3840623a-ff2b-43c9-cde7-08dd76c49230
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 17:41:19.6676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VaOWutzXy+XWGucWNf88itAHp+v1OwDRRfaSTDyzdH88Tc+hwNB5h4lnityr/kuuC55Gn6Ijo8Cb6ULt9vxBrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7004
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_07,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504080122
X-Proofpoint-ORIG-GUID: XANRRPXO870TWvmCS4uGNLyIjxqCCkAg
X-Proofpoint-GUID: XANRRPXO870TWvmCS4uGNLyIjxqCCkAg

* Matthew Wilcox <willy@infradead.org> [250408 13:03]:
> On Tue, Apr 08, 2025 at 09:37:18AM -0700, Christoph Lameter (Ampere) wrote:
> > > The hierarchical per-CPU counters propagate a sum approximation through
> > > a binary tree. When reaching the batch size, the carry is propagated
> > > through a binary tree which consists of log2(nr_cpu_ids) levels. The
> > > batch size for each level is twice the batch size of the prior level.
> > 
> > A binary tree? Could we do this N-way? Otherwise the tree will be 8 levels
> > on a 512 cpu machine. Given the inflation of the number of cpus this
> > scheme better work up to 8K cpus.
> 
> I find that a fan-out somewhere between 8 and 16 works well in practice.
> log16(512) gives a 3 level tree as does a log8 tree.  log16(8192) is a 4
> level tree whereas log8(8192) is a 5 level tree.  Not a big difference
> either way.
> 
> Somebody was trying to persuade me that a new tree type that maintained
> additional information at each level of the tree to make some operations
> log(log(N)) would be a better idea than a B-tree that is log(N).  I
> countered that a wider tree made the argument unsound at any size tree
> up to 100k.  And we don't tend to have _that_ many objects in a
> data structure inside the kernel.

I still maintain vEB trees are super cool, but I am glad we didn't try
to implement an RCU safe version.

> 
> ceil(log14(100,000)) = 5
> ceil(log2(log2(100,000))) = 5
> 
> at a million, there's actually a gap, 6 vs 5.  But constant factors
> become a much larger factor than scalability arguments at that point.

In retrospect, it seems more of a math win than a practical win - and
only really the O(n) bounds.  Beyond what willy points out, writes
rippling up the tree should be a concern for most users since it will
impact the restart of readers and negatively affect the writer speed -
but probably not here (hot plug?).

Working in (multiples of) cacheline sized b-tree nodes makes the most
sense, in my experience.

Thanks,
Liam

