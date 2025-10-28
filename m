Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AAB934F47C;
	Tue, 28 Oct 2025 19:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761678536; cv=fail; b=Lpzg8wk55/CoR/nuqUKNBxOWm3qMrlblMm6M0X7vE8wK/+8RkkFRylIq6xY6eKRAwdDwlQb8/Tp9xdq3k+Oc2X8npF2TXHBDVQiNBOLUsA8gO5HtVC9AlHNfAoSeb/V6+oIQUFb6jXqM1W9UDCz5FY3jTHOpUDo6DOmER5mL0/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761678536; c=relaxed/simple;
	bh=qTTSfENgMbdhXHjhLIHCqsU5XB7JsXBQsM/F26omSFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=A+cU66bcJfKMXqaIfpZgcJHwl34JOOsahlGvf8/StIYm9pYqCaprES00wwN6cFH2QRpIsP9bE7fQSev+qrLBxytqplmAJ/dsrBs7JqcylvE9Ol1ZYhz8jR7S31h1JCaDcu/7FkAZHCKfohITWKVF4PjhvQAjsXa7hNiba1N1fRQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cF8Devgv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bp2Mp9vs; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cF8Devgv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bp2Mp9vs"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59SHNlMU029271;
	Tue, 28 Oct 2025 19:08:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=qTTSfENgMbdhXHjhLI
	HCqsU5XB7JsXBQsM/F26omSFs=; b=cF8Devgv6MX/YZefh/ar+3hH7HdN7r2NwG
	3DABmwbTi+hv0Hp+iTkaPvI8jjlJDAK8+YYmKzKomN9+az8szirv162h8t6PI915
	7W58C/HHVEOjvjI8UrEEVHFhCfNZbNy52jx2iOGNl8NxjjDGkGO/HCWhaFpVZo2O
	3q5y9ddX/+O8ynxrqIKPHrsQZMAFc4X/yg/Jl8MU2GMRpU4PP6KcU7Ukr9lphF38
	Mt6A2njij4bGp38pBgj+TEYmo4nKezarNFyawyWx32xB7+a5Q0mXfvPbExk3nSFX
	bvG9wJKbfP+2UJZGmu7OWxC4qBw+pSMhbjGrSP1OZR1C9xHiSGZg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a22uucdqv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Oct 2025 19:08:13 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59SIIQGG037502;
	Tue, 28 Oct 2025 19:08:12 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011029.outbound.protection.outlook.com [52.101.52.29])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a0n08mxds-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Oct 2025 19:08:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qZRL1ayKscWPEquqI9U0FLs2H8aGKvmwJs0A6RvPqQUIfAv2mHo8AHLB7gQBUwKM7LM6yB/jYgs6J3Q8PzQo2ZR8q0X34KaOdGVnPneyZXVb4ySuFe4IIvqRhIndBHNAUU2AYNczX92zYXC2aDXiG5QT846rZPN3sq26in9iGCpave3WXp2/ECLdg5TmKygHNksJnUexHaOtAcs+1qqaDeBHd0twpbeBP7AjdiVrorkTEMblb3dIFiHBZSOwS3Py+j+g1/Ka2bUvWowzZ9BGOS8GoXN7qHzAQobjrZdXAexn6+nP3nrrT7tMCZThr/w/i2Ui+JnROKpOvB7MV0XuxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qTTSfENgMbdhXHjhLIHCqsU5XB7JsXBQsM/F26omSFs=;
 b=oEaI4u/Gr/TzdZ8vlJ9MJjktVzsqijGx6h2zRL9VHP2cmAXEswoif+WVy8XoXclYcTDfnpUT1HCVwsY4IFEeRQXHs7qO2OMTPiphMImD8uSbXy97Csqqi3Bnti5xEpnSVbQDWkUlffnVUnIyO+qN/7+L4S51i8aeZd9fvqhW5VtWp8FM4OVssg6CGI7HXfn71ha3YURPau5J+mgznTXHlfy1mcIgaHowFaVj7Q5WDmYOJhaguv3GrqyTOzxzIcv2Z3BvOJQkeNxL4bI7hKwRMO/wUHSbbTmAavk/W+gU2YADCAUD/A8Iwbkxhmeayl9Ra+UCdlXIXk1MygZxcTVpDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qTTSfENgMbdhXHjhLIHCqsU5XB7JsXBQsM/F26omSFs=;
 b=bp2Mp9vsBmsMhYN1UfsKAJNMJrgomnQgzJKo0wjnoE54OBRXlo0PoIqqwJgVDWJskboRpdPFVQfg1U46jzPdkt00jBGwVkQXVjoHWtQBbkRbyACvKomjEkjfrgFyRIisfm09I/Eeq+kmjmlUiSB5Wf/huHIBoygzuH0GajqhYLg=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Tue, 28 Oct
 2025 19:08:07 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9253.018; Tue, 28 Oct 2025
 19:08:07 +0000
Date: Tue, 28 Oct 2025 19:08:05 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Nico Pache <npache@redhat.com>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, ziy@nvidia.com,
        baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
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
Message-ID: <a1ff622a-fd73-4707-bae8-84706a1fc2ac@lucifer.local>
References: <20251022183717.70829-1-npache@redhat.com>
 <20251022183717.70829-7-npache@redhat.com>
 <5f8c69c1-d07b-4957-b671-b37fccf729f1@lucifer.local>
 <CAA1CXcA4AcHrw18JfAoVygRgUZW3EzsN6RPZVrC=OJwSNu_9HA@mail.gmail.com>
 <e69acbc5-0824-4b07-8744-8d5145e2580b@redhat.com>
 <e66b671f-c6df-48c1-8045-903631a8eb85@lucifer.local>
 <74583699-bd9e-496c-904c-ce6a8e1b42d9@redhat.com>
 <3dc6b17f-a3e0-4b2c-9348-c75257b0e7f6@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3dc6b17f-a3e0-4b2c-9348-c75257b0e7f6@lucifer.local>
X-ClientProxiedBy: LO4P123CA0074.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:190::7) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS0PR10MB6271:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c1ca6de-2af3-4e1b-2ac6-08de1655543b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?y8uego6helQtbK0ULNfvk/Vn6ZX2V+iI3PSN30GdFnbICsfqny2/xOCqNhvf?=
 =?us-ascii?Q?gnvoFHdvQoBguaWN4qoQVuyedLRllSN4JMtxYRgBOqbfpyaDnkCq78BGdGEp?=
 =?us-ascii?Q?ACsHO5ryJAW7zIn7lR3G6FUxETKdxKxBe2jXClQB34J2y9Is2w8hc1tY7Tp2?=
 =?us-ascii?Q?Wdx4K1tmkM7ODKiReEaBrRD8IJaSiUurfSCkW22kQQhnzQjtjz391DUSOCBF?=
 =?us-ascii?Q?DHYgSDnyy3/+yfsifjY8vioZVXkOA9IhLSItMRWc1SgGiJB79Kd1rgh338+U?=
 =?us-ascii?Q?3rAoLrnQr21r7im5mdewmoZQRlLKJQ59ABZBSZtu1pKVNNV5IGTSSb+5GpKB?=
 =?us-ascii?Q?F0T0IW3I/9GImtCDG8Ro/WSnH/HsqJy2w8qKIAKErURs2JE8ZqwaIPcdY8IY?=
 =?us-ascii?Q?d7BTli9+q3cjljlSUdW32eWlWvJAAPVuqb/isuRTJRd42P0WSYZSgMYdXQuR?=
 =?us-ascii?Q?hzBce6QvhJ23a2rHto8UqjcMzSHoW/58UAArfLo/jtPQEiLwP3WhsOHtvX3C?=
 =?us-ascii?Q?FgZIoWauOAQdZgJTaUEMlaJEp28PZvBv5SComuVzT58ricP7KureHOfytOiB?=
 =?us-ascii?Q?N9iOtjQmm+syXyTSL+pYwI6MGfipV8LQf5di/oNEEMww6jxDXwiWomp+STDj?=
 =?us-ascii?Q?mgrWF6aKDtCw9VMVc9rXf+K6ZzuogTkEQdluAvII38uBuSlW5IYaMx1AEIv0?=
 =?us-ascii?Q?NNuj5c6GvqjjwFPkPs0QgKLK6DAuSJj0vWm5E7jJaDqllOPcDyUrsEm6Qrzo?=
 =?us-ascii?Q?hUryYxgMaXi1LA60ISI/vJ+Dna5Y7JBPBtBtme9PG3joHyLUnU+yDIkMwqAt?=
 =?us-ascii?Q?n2ibNQUrKU++6J1MK9ow0fSCqPMeW4UO4G0vJ1LQDjKfNcHDk7ubqns8JDt6?=
 =?us-ascii?Q?5DZmzhGX2qba/xBfkopdVGfy+hNDvxLSXQoUZd4F6FhVm1Ve6XWRACQdzuzj?=
 =?us-ascii?Q?9m0wLmns0oSbvyecfIwj8EgHmYCgtS3ux4r0lJaRAql2xOB8QC3MZCM7mZmX?=
 =?us-ascii?Q?B6xQ/DmUmoJAimLyftWQaUrx2GlPf6Q6tUB86ezNoxVzYKbWlGBgA5pWhZyK?=
 =?us-ascii?Q?YFNgJN5ALe1yRn8CRWLokvJFWmAGtqPIJQNSqRlGIQA/SSYttZ1n57ypNS2P?=
 =?us-ascii?Q?kP/90zINcMKXduEkt/0EMf+lbFN+njICG5/H5zpvqWgQasA/pkuqYfWsP1wo?=
 =?us-ascii?Q?1IW2onMpEW2iZXOw6UJqkKOHRAdKKFcSEYDg30OedQzlBppZmwBEw+V8mx8H?=
 =?us-ascii?Q?ZXWI2tS7P93A33xnRU19BnaoQ8uDe0cKG0raCFAhdE29/C4UrR1A45ge+xbw?=
 =?us-ascii?Q?RMRL/cRyv3fYmb435OmPHDO910jneZoqoyR1ntNh1a7cwEedcKDxb+R83dQS?=
 =?us-ascii?Q?eXtf8N3n2sqXVkyn+Sp4/54i9KN4CwCY1Piu9hYnMW+MULZ4/ROx6JZ+ENz9?=
 =?us-ascii?Q?gtiK080ViYsPJDL8DHDA4wmPcQmMtvs8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bKMqwwthASuVkIZ6tHUu1uM0Ym8i6dV4yqKG+xII892wK9FHL10HSY2YUSZo?=
 =?us-ascii?Q?HEeFYWQ3IJL4csca0QoLn4lEtW8M/rzQ3b55fLjcA2pAinunEnBFXOtnLWBP?=
 =?us-ascii?Q?zpkh/RXfmtNIXTa7HNzx07aac68jHfG6Ga7S9NdANaWNFn8IEg9uE0XmBfH9?=
 =?us-ascii?Q?qg6be185eRW5JwC9NWvO0QAmnXG0jcqx+miF7MEB/LvjNm3Ijo4bYdPdiXgy?=
 =?us-ascii?Q?22DTATjqUXEbwXh61Ytjll9LGGWFLfzytNiTAvF+c9uwrqUPfXZKayC29dV/?=
 =?us-ascii?Q?cJa96YEnAVL7TSzWAXWQ4Fy7Po/wpeFX29u9uQ8pPg5wQ2yDuMx5py0ujjp3?=
 =?us-ascii?Q?GxjkdDuV+orMKrS7znZ6E5RNXxyOwQPDiZ4V69WUF27RYGguPVHidmrpet3V?=
 =?us-ascii?Q?BPn0Irs16vuZS1a3GolSe1pLp7ecQLevIu7Nbora+3NiMTUfwvYRC7NhFfsL?=
 =?us-ascii?Q?V68KmhYFXJpNFktoWZZQYp22mAHa6wtQI1quzUQiZTkMOKFn9H6GePmcf4wS?=
 =?us-ascii?Q?qJu0Tnblbhy7BGc/hf2shwo+mOW2OXMinB3XKOxCVs7aiutRLH9Tvd9Di23G?=
 =?us-ascii?Q?2x1rxzvE0KLXg2JvjZlBc1DeXGHOoaoP/3Flz0jnptlkxrnLBDXxKnxF3Xuc?=
 =?us-ascii?Q?ITW7aKWPXphY4HmBNGuGKMP+jbxPMHspNFePTrDSXWYZ7F3Z7XGa22c2uWIh?=
 =?us-ascii?Q?8VXDNY3VQBpw3icwzEEdtG3pYeiZpilXDNlN9ykhs8hF5MB2PQL1Ii2hubsM?=
 =?us-ascii?Q?RlnXSnoSbqoyWfvqGqb7kuLuOYtVBMgCj9MieVL6ZuDjql8SBlz3/hU0kA3m?=
 =?us-ascii?Q?RhdRRul8HdZRd59Exp9A48eiOkc3LSdwPiY8dc9iLRXV1ZorOws5TEDEQqsG?=
 =?us-ascii?Q?D/PgVRmpgcnC6Ryts2w4WezZD+fGyS5I/5MbV6hsGTt/7yNSJCaD0iiYxrnX?=
 =?us-ascii?Q?CjpzQJYErTf8VzmlFKv/T2pOGtkBNPEw37ussjpmRrDF7qcCKdKQgTldH22m?=
 =?us-ascii?Q?DdXXTzJMv+4FBF4vmrgsIevMyPTaMvhWxjWaa0kkG9obN9lSaOAEF5MWoPXV?=
 =?us-ascii?Q?bJryLsbL0m4o4JyzTUk1oiClJlafuCWHPyrbE7mqGh+SEHyUTurnUkiL/wX3?=
 =?us-ascii?Q?NOb8lj5W8xL8B3QhzU83qh5HKgng1tlAd8+2aH0WvY1mkSTigrWzggFt/VGd?=
 =?us-ascii?Q?gSneyt+UWPZfu1UwaW5AF8hPIEAG86CF5YbLb9MlA1iYhQREPQn5XsyxG1ef?=
 =?us-ascii?Q?8FvvJdPJiBhmbedGlRZulLxgurcF1/JYNK8/aAxg06IjZDWMFVnb6i9vpCkp?=
 =?us-ascii?Q?JkjT6UWj+M02Fxw4pCtB6XU8CfNQIjmuJ3eBNPHjr43Cdbn10f5vv7TqJJiT?=
 =?us-ascii?Q?edWz+S35TZCQtQYxpthvpJxrRWuSIfP8l29cNkaQX5SNT+MO3BrI5jeYH8C5?=
 =?us-ascii?Q?DH1eOQATfJHDmstNis1w6zicR+6ppIVirZm27L+5EEbAFu+RvcVSkw3NZyoq?=
 =?us-ascii?Q?EH/EgqeeWfTaJEZVERry0IgJse+XPhxQ+7TP2FOT3WAZUNd7hb81uvDj1wyC?=
 =?us-ascii?Q?tQttdEnfxfh8gwq11e4ea087W+fjp47G4g1sAGiWPXfWK6VbUBGx94eu5+K1?=
 =?us-ascii?Q?aQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DrGyQV1FhNyYx9be6k9JSvDLSJwy9FCXSGhwCHi2hZv15TCt6Pm8907BftljnZNiKvqKVmYAJoK8gpoNGtGE303//5neYVqVG5NOyXbjd7pQiy27U1WBAq0AKOIAGmOvb/Ynw7Ik+BoRnpvYbGEuAwaDahScpj11aXqT3ewdLGJCqv/rXmY9UZR9PfJ4w3+k/KOGHunAA02T6l78u8CfFgES7aAgVZPwMUFqADrm5UbT7jYVTwKSQScaLpwvHuN2+8D+soDKqKZkOVhC2qYj7Ju2v12hW0xG165abn5XNADNwGaWsoIvuo/grk4AOkV3sdCgOAyBZx6imNmU8P9fb4r41uy6LPOYl3Aq4uAr+lMY+7kPw+7OxVzGPz1AYhka5gRw5CMve6QkLK3823Py7itnvudMIEeT9ZkYlKAvJIDQmGTFnI+/aTMIqWUfw3egOJ+xpXAzN6g0P2YrvG3bctG9MixwjhlnvCqrxpW1LLNcT5UdV96XJuQGVNetsvLA//BH3HCd/K+ofybZ5f5MuL1jbcTwTgRSEsEZWteCs/hpKlllxXxQ+mNhh3kAl65K6Uj9Lz5JG2/Gb1WIsbcdrQAT6oqbVTQRfX+pKd7TxW0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c1ca6de-2af3-4e1b-2ac6-08de1655543b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 19:08:07.5047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tXmaLWel0XcTlIRHZKXMWUkPdErJhVrPDbjoXbuaHrBjTZnoPaBlQNgIVgsYM7yerTMDYc6EAq91UjfRImgUHN5KHt2j+FsZIvkGsX35s8M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6271
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_07,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 malwarescore=0 adultscore=0 mlxscore=0 mlxlogscore=866 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510280161
X-Proofpoint-GUID: WaZkx5uOGoYoJRttS_Sdbpn_NAnC8NOB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDA1MSBTYWx0ZWRfX35eWoKgrQQzB
 IT2Tlbi45z+hfboVkL2bsUGrGPQejrmaQov4CTXm2KJAXu1gHOJ9zTSEvyej+hMcVjnT83DZ3c8
 YqpssSCJlJJy2UpgkC7DQLzMXR7ulykyu89yK1yfBxlKxkVccTEB5cWL0jFmf0eJfqwmiRBBTsG
 9f38OVcYSiXcXFVAMO8I8k/mP86eUfj0MGW0gS2PgB3rnHdH1yUvc+NmLYbRgLhBBaIPDxyVtt7
 3xaoRXvaI/h3/Zz0iXKdHF8HD9zR/xOcNe0/pbokwztYu7F+2j41m2Mt/+rddWy8s/LaoXVUJdl
 kyB+CU/rm4RvA4FuEMH+VFAoqdJFfYDXzpqA9RiSRnGp/isw00KhQja/0LNBiSvfwROrvXnV+Qw
 QKjVaV+xdNJzcr7KkYmcZXUT0WK7xA==
X-Authority-Analysis: v=2.4 cv=Xe+EDY55 c=1 sm=1 tr=0 ts=6901149d cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=mJtke1EV2wqAupp9RccA:9 a=CjuIK1q_8ugA:10 a=UhEZJTgQB8St2RibIkdl:22
 a=Z5ABNNGmrOfJ6cZ5bIyy:22 a=QOGEsqRv6VhmHaoFNykA:22
X-Proofpoint-ORIG-GUID: WaZkx5uOGoYoJRttS_Sdbpn_NAnC8NOB

On Tue, Oct 28, 2025 at 06:59:31PM +0000, Lorenzo Stoakes wrote:
> On Tue, Oct 28, 2025 at 07:08:38PM +0100, David Hildenbrand wrote:
> > >
> > > The whole concept is that we have a paramaeter whose value is _abstracted_ and
> > > which we control what it means.
> > >
> > > I'm not sure exactly why that would now be problematic? The fundamental concept
> > > seems sound no? Last I remember of the conversation this was the case.
> >
> > The basic idea was to do something abstracted as swappiness. Turns out
> > "swappiness" is really something predictable, not something we can randomly
> > change how it behaves under the hood.
> >
> > So we'd have to find something similar for "eagerness", and that's where it
> > stops being easy.
>
> I think we shouldn't be too stuck on
>

I really am the master of the unfinished sentence :)

I was going to say we shouldn't be too stuck on the analogy to swappiness and
just maintain the broad concept that eagerness is abstracted and we get to
determine what that looks like.

But absolutely I accept that it's highly sensitive and likely embodies a great
many moving parts and we must be cautious absolutely.

This is something that can be deferred for later.

Cheers, Lorenzo
