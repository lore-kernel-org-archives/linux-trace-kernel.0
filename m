Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13B026B956;
	Fri, 16 May 2025 17:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747415853; cv=fail; b=r+G5J4uaSd6auPJuh6QiXbscspLsu0t+lgJqRR1LJ5RU8GsD3sjsZaMxkcbQBM/G0wG2N1urX9kOSojfsuILq2KES3BcZhKT4jB8xFkofoOswt2VOIP4JNFDzYwnwXyNBps02OjPmMVLpW6wmczUx1+qXhXxSbuEZGjFhYkq620=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747415853; c=relaxed/simple;
	bh=X2kYngezYVF7srnL3US087W25rLj+x2onkYiYbExP1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lS9XvhaHOYuS3rBfAAfivetF6OSGeRHQpEJIfLmXqiUTiRA8QeWu7b2I6u4zjzyRMKSvsdeJfOcLhLK9jHut5pfVfmV0WZJmButwlzVvhqVKkehKCCRMUhJMyqxTsY6MfTjgDXDfByObxXXML6MKHBpbTOyf32RCxO437AyBmPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CJkllwQ1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=R4ixK2ec; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CJkllwQ1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="R4ixK2ec"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54GGfsNV000984;
	Fri, 16 May 2025 17:12:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=E7UhZbTH0tA5T63w8X
	2JQBOZan0wB++Fz+Xit5kZjms=; b=CJkllwQ17q7IgTKsTNlXvr/bHcqsHKpMFj
	9UYLi+bEiribOwj2lStTrvUzkZTGOidcp6HBWOwaAS1lVowtlNIhiAFWSzzhckbJ
	UDkmZkNE+2LoUTnlaJ90xSZXxvKPjDU4MbFrgjpEhPFwOkcduKuLvcFtE0HpuIfm
	T9eiHprTi6/JkcfaPUS6u5jpB7NHwCHMvaeBThIaCqk8oKLNidmW33SskO6tTyWs
	GbyNovN1dTmUSlNDk+3v0C8b0ysqQjYMC90RY5NFWotCYfWCVgGfvxBdF8NsVWKK
	Z4nN8z7DZgiYXx3hVCQCk5jj5A4SbX7/9oSL/cypsUa5FlfME6YQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46nre01ugg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 May 2025 17:12:19 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54GFRDxN004284;
	Fri, 16 May 2025 17:12:18 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46mrmfkphw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 May 2025 17:12:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZJ/xZI9NcO0hhTiwVN/AhnHC/dD2H1gHuKsUF0GsYIElrGCAC5gMLoJ702CbhLhX+ahUU9rvF7UFx0chCIQjifObWx4UJvB0WA1p2bBKPyTjwqIS29og2Hdr+QWBf3WS1zaHn7KEesremxSYgaQMGZDyAiwkCLRIXzY0oMuDu2Zdp1scDA36hOyYwbzDz9QpE7+tCcnw1dDykDo5iHL58z5VDSUEciQPiJC3BXicAZz6ZqGOlt1uD+pfSKwmWyTfJ0E4D9+6AZ+D83TT/cQ36dXxh88n3X0GCqEWBoLGba2xh1f3KC87OO++AYjHpbKqDH1Hrey0J/KgXD2894XTpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E7UhZbTH0tA5T63w8X2JQBOZan0wB++Fz+Xit5kZjms=;
 b=SNfp3Hkx6B5VQeScw2gwb1kfLzISHM9mFkSoBiRE15/5wzc/7Sm4Hui0Kx1D+CwRxp2SM0nUk1H4VWqwUf1drLHnU/3ua2YWg+osSSG4xzGzEpN2jG5/X3g5i/SAC3Z5iEH825pa9CAo3wevkMwrmWzQXYXxwD5cQkLsCsCW9o3aEyM5ESvw/0lvHqvHufVEPF4r62g9KCPj0n1GHlCMa9+N/fGL5/TRp6NELXgCjDY5HphJBpJUg3cHpi13UVG/McR6H1cWpZeUPXRCfVtI71p+uGW9RqD2A20qoe42P/NZ2nWCmZBIWNexImSHZ0eem1NsjeiThRfUGirmSx5UVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E7UhZbTH0tA5T63w8X2JQBOZan0wB++Fz+Xit5kZjms=;
 b=R4ixK2ecLNM7FYL1UpVQ4/spFfJ4hKsallh8VNIL08t3zy4yGvXsZ4YLk4JmTGfkwIgc2M3tm5+vGSWIIdZ9iq1aRcbgKNYg7Tk/GkKCrPvC88lVER2Zr6KVWvP5dcBUx1M10FTCv4TW+R9nk0QnEpkSmYu8W+qGwnudwLpDb6c=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by DS0PR10MB8103.namprd10.prod.outlook.com (2603:10b6:8:1f9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Fri, 16 May
 2025 17:12:15 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%6]) with mapi id 15.20.8722.027; Fri, 16 May 2025
 17:12:15 +0000
Date: Fri, 16 May 2025 13:12:01 -0400
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
Subject: Re: [PATCH v7 02/12] introduce khugepaged_collapse_single_pmd to
 unify khugepaged and madvise_collapse
Message-ID: <db37bakzupqagevhjvngsu7vzcqugp6coy635bvhoy6cdrzk53@mrldbtuep3gk>
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
 <20250515032226.128900-3-npache@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250515032226.128900-3-npache@redhat.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YQXPR0101CA0003.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:15::16) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|DS0PR10MB8103:EE_
X-MS-Office365-Filtering-Correlation-Id: fe2de2b8-1fb0-4916-f330-08dd949cce33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?X/aURo2xWPgFGE/ON+Nh31f87V3OLptUJ9NvokChtWorq353Y+lAb9LNF0WS?=
 =?us-ascii?Q?fIGUPkNf7rBg9QEph55YfI3ZLjgqGVDjxJfeO4bohfFY/dBbmq2CZmbfpO7V?=
 =?us-ascii?Q?RTp4hp4Xw6R96sAJ/KLlVKv5rSx/d2cjSwf3I0Di2Q8P9BJ8CNc+fzq3Qjib?=
 =?us-ascii?Q?a12oxL29V+jrMqF2pkLWaEFSXn6YF7kHzy82fjBlZgW/DkqhN308+/Ohexzd?=
 =?us-ascii?Q?0XuILXTpSwxV62AVZmyybVdJtyvvotZU+csb3fVjCKmTRaJMtRguo/HFOor/?=
 =?us-ascii?Q?DVOshqi1KKeKg1KLap1263Cl0kCTuP1pHXrcbgMhzezHXYgQszUvwABZvHFN?=
 =?us-ascii?Q?R0D5bE9iNjU+8raahMhHBln2PuCdoaFsbQqDqkdGZI/sZ/N5qaIwcMqJ0TMS?=
 =?us-ascii?Q?oWYTqv/NnwVONrUEBRoJI4Nzr/hzu7+I/HHiVJ/27duh1sql+Wsh/h3JZ8og?=
 =?us-ascii?Q?OEqCdO61sJqCCitvNqv8Ond3k4ZU9INET1qQe5BSFddEeo3p9PrqmcDijYDT?=
 =?us-ascii?Q?2rditkm+S2QGJuDwieNMfNaKXOMj2wUA9/JaHLKsj9nrTDt7te0hebbelXsB?=
 =?us-ascii?Q?yriDQbwOEjNBEmglkdVnld5cIic2im1uU8fnHHgofjn992WG6bXhP9U3PUn6?=
 =?us-ascii?Q?l8W0qIjBFicqklOsWd0l99Q5X0BMl7VuKHKrJXO0h9r8B/go6QRPHfnidhVO?=
 =?us-ascii?Q?wfa5Rky8Gd+MoJMgJNgOu3QBLAYNXJVtauydOhDp9aZJm/k42iYuNhfxZPBl?=
 =?us-ascii?Q?sefqYl00vNsroLtRs2yaF/Ymqxrucqz/yTuTGhgFKVE+cUDPNmQH6WdQ2RR1?=
 =?us-ascii?Q?jCPAU2GsUc4lSh9WWYs9idIjPyGRm8OqsXbLFjsNj80+afqId3UXeFtP/WUx?=
 =?us-ascii?Q?Ng80WjqjvDMR9AumPF1NsuvgIwKPJnPFccgjqjzrYNGw8sf2Sm/AYHxkRhT0?=
 =?us-ascii?Q?L2LJx6YKRxRA5bhF8xcSdM179iPTb5gVn8rDjxdO6/XWNbeDLx0zjIDhmWG9?=
 =?us-ascii?Q?N+6fUhjSZvGjJ9R9JhAe7cqG3SlfbnjzqNz7rIIgas7ck1dbVUZ9bfzzliH1?=
 =?us-ascii?Q?5kstmRAJdtrTQ7v8SV3UJE2NTMefNVV9Tyurw9hPMcq5y3Eo5w0wWrgMTCA1?=
 =?us-ascii?Q?u+KmaLyCaifqsgmbFnE80Hs+4VXdVZeVgvSqnqcYGSMJDE+fDVv5QBMStII7?=
 =?us-ascii?Q?rfAXGpkqf0ZvsafesuH487HHo5cl5RtMp2oE9Ln6qYxL8uJVBgxT/3k0R+g6?=
 =?us-ascii?Q?opO0mnHHjxc6er+gKPfhFdyoWRC22r+9MGX210yJuV7f7ts0LhOMB0gE7Ag+?=
 =?us-ascii?Q?Ji/J4c7L2VU+xRws6QTvX4lqnAKQjEwtFFLnKmO0P2xmUTiO2k+pNrxHan8Z?=
 =?us-ascii?Q?spsKwQE7JFWmcxZKtRijn0M59mO/+Wqopgr2qN8Uxq3A5TCpFGUDcIWQm+JY?=
 =?us-ascii?Q?c8wLaQ1PSH4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NY4+pKI8wDvUALwvVF+lYiA/Wx0XcoBUmbmDwC76qMDvNNJ1zcdZkFQHu/li?=
 =?us-ascii?Q?pfQEWVF5ryxOKmC39swHIHdWiLd/iO5sEmoXntgHzFfbdkFDUd4LlDhBjSxX?=
 =?us-ascii?Q?VFOIic8rScybNNVUGO2IJSDxBzNLCE5Zjue0CeILjMAQUi0kaVgDiw9lC2pG?=
 =?us-ascii?Q?gFgiLnWtUvLOhuGnpba2OFeUKm0XKcyKqQTpBnARYQbJluq5Umb9lXlQOkFN?=
 =?us-ascii?Q?8WHg1Nb0oydKDkwM3Bf1XBvTuc8cs5iAqg7UDTS9myUXi2YYXAuqABgQS2wP?=
 =?us-ascii?Q?r1EjCOnylWHpqrp3I/E2s2w9uhU16swEj3Hfo8WHIzBChQnTh8yEWuberYD4?=
 =?us-ascii?Q?cfbX03mvGw5ievDRFybejNXRw2jiiV3tCr6cCJyzNJh43NTwShH531WIxVeJ?=
 =?us-ascii?Q?jZJqBfh3wAOHDw9ZecoO3z7SBJgWvqxaGRWKynau+F1NX7VtFfsTp5Nn5+cX?=
 =?us-ascii?Q?BIjuKBjml/Le4wcorFFIxvuII21ydoMDNSjbTw/AejuK2Y+7FHMIbiIEJgCP?=
 =?us-ascii?Q?y7fKWi7h/xz8katSN1uFtq36hkQ0VRe/R9y6xgzVtL+cCHnwjODJjxhmXJzd?=
 =?us-ascii?Q?2T9QLUUcJVdJCULXi5G3pINQAp7UaWAO/0ihhw/lnUdiW6zbF0NyJ9BGeGaG?=
 =?us-ascii?Q?GTkx7C82w7+xnQlRMOdL8lhEgrI8cURcW5eIjZFMbj6e7Nph8o8Xg3RH+SWW?=
 =?us-ascii?Q?/SoTw4WcaKVFEsxIVABsPjpdU1f8KJoyigvWvqykD1TzPsP2NUijXTd0fn5l?=
 =?us-ascii?Q?HdaCzHnblXLSzCSj1oo1kvWX9GIBHbuBlkRn8L4lUOFk74ir9JFkQoKOFs3m?=
 =?us-ascii?Q?UfyqcZ9X23RBx3+bv4ZsQdNSob+zbF+rJWWrgvcMrkFdfQ91hKAKxASBl914?=
 =?us-ascii?Q?Y9wvXq0cBRWZX7HDoBqc6gYIOn2zeN2yR5GfxPdseoNAhLP4xdcUlm1ufQON?=
 =?us-ascii?Q?epgb6oN3IetPmM83L759+4y3zBjjDG5gAgKziaRDn83T6iuVKVF876833AhI?=
 =?us-ascii?Q?CzR5gdso52q0V5sCeua98L7pH7wk/xJiwnyOM2KQR1pRIO+IbiJT0mPbNYAb?=
 =?us-ascii?Q?s4JEq2HrZ1nUI4x2SKQHYfVJT0RtPGyporEp8jNbB9fxoQUb1ZmgQKlyC5Hx?=
 =?us-ascii?Q?6VS4hiQIIEpLj+i6N+HYCrCm5iFMt4mUWCl8RIeWqKsQH00BFS2hft3xg5wD?=
 =?us-ascii?Q?X3rrkgwKQwviZsj/xr2BSV6911i/qkSdfDjB0rMVGGi+EJzeRSOeugRsGuAE?=
 =?us-ascii?Q?6Idwo5uySAWzeSKcJZjJdnTNyBctjgitRbiX6AE06QnmNao8ToPt9Z9cLF5h?=
 =?us-ascii?Q?6C9Le1D+4r+ke4SCTTPw2Jz2X18Ac2mzmU6LRQCZ8P7AWRanoVikrY2SGTYQ?=
 =?us-ascii?Q?MCxClLNbWYIJG1z5vDRXbC8b5vP+04ZJBDL7cqYF1r120bCUO46qxynPiy/Q?=
 =?us-ascii?Q?4vP7UZzH3bSyL90ShkJM3ygwWnMHX+H2pwOnVgTj9hSbqybWthcr6eBesR27?=
 =?us-ascii?Q?5/7Qik8Y4NJruqpjOB5qVOFEqDzFQsO24+idHNoloo49tjI/ZcsabsEtzTvj?=
 =?us-ascii?Q?9LLh/5FOg5g9b3u0gz4uDi0utcPIUE0T3dSHfjgc?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	14mhcS+Sl5UiA4R/IoBPm4Op8BzxiofohdgmGN4Ujl0rMI1I0Uc7wR8ihjDLcHkfj194ydXJvCPsT7Ndx90QOPqh2TzonCKhH645tqbl6VVmZHYJaB3AtegemiQxuFdFlnUprOVTNVfz3Yj5D8Bj+FlGM8zef4nv3Kl7yzgmczaLNQ9FsrgnIgsnrTs+dIIa1QfxuvdUVDgc+0XnVwK3xQD6JkfRJYkJPUCLWPR8TzAZintEPBTovTykC6c3tA1EA5LiIrf7+N9hZImt2vfdLcdcqTrwnA/lVzIgP52RseSnijaSbws6LE1HZqc0ZN1pEkXP6DB1+iMIRxKxhEm26zt8g+ziHTZs+y4ON9LoFKfJUdDrJtRpfqwRJkdwdcqbyrmDsL9rzKvANTeqUFrOUY9P+JZsBwhuOyH/iH8eQHAlSKJQzpHzbC3lHFWiu4PORFlCoTw+Rf2VBcG2G2KoxaHz7aIfj/C4fbQcBJ+9ZzwZOl7e+v4DeKjLU0J1HC7k2x4ELQl2i87s2gI1IRmq8IDtHkJ2tNsjBe96xJTVYpd69W5r3/gR15pC373ucbIaw/CtmjEVQoaPjY3M16HKvpGVFR3QiEJ0AXisARabvhc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe2de2b8-1fb0-4916-f330-08dd949cce33
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 17:12:15.4466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VB7hBOHGpDJ0CSnZA9e4hPtaJ3pYW/iLs3Sn2EwYuXVBZOPRG1CBBJZphctZv9xs3kdSuFu0vPVv6gxy+lqKSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8103
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-16_05,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 suspectscore=0 mlxscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505070000 definitions=main-2505160168
X-Proofpoint-GUID: 3fx4zjnLyLGMl9Cqe06n60OZFY0W4-ZW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE2MDE2OCBTYWx0ZWRfX1HHRK8DTImnC 4mGPUfJbSFSvk7kV0Qf7HT4GtJY+RRIGDh+f0ypm34EAPsb1HrCipzsssbgllVze6/Lj90Q6kRC 7ho9jf1uk0+iX9qeJbYQF8nHj3SZJt7CRrsT9Jm45kFFmEebzdoA9Cxny/wS5eAXqBRCyYbpIv1
 pC7HVXysxDvMVaev3ckHa5Jh5gPHagegHGpwHUQX4dKOiQHS8nZJwaRbtYvRa2x/Dxd8L6/7wmM +yoUZvT96Jmw3FdG7n0g1iKiEpkXGcRKYUFUZdycOj1AcGbBQPqteXvMjS0sFzTxfYy+6tWmEAz j1p3SDggOXhTlHrGSLLM3GiFKIf7oD2me74U4UfY5MiXpyKvSI9d3SYYrs7EmxnGq01/0ESEoFO
 u+TbbfKgF2ksQR8njSV24yJnHGGIgc0IahTWDqTHku1BNLrW1Uumt5uL1t+8kpXmjJto+hnQ
X-Proofpoint-ORIG-GUID: 3fx4zjnLyLGMl9Cqe06n60OZFY0W4-ZW
X-Authority-Analysis: v=2.4 cv=O9s5vA9W c=1 sm=1 tr=0 ts=682771f3 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=20KFwNOVAAAA:8 a=SRrdq9N9AAAA:8 a=1g_mlD8uFuv8L6U3cTIA:9 a=CjuIK1q_8ugA:10

* Nico Pache <npache@redhat.com> [250514 23:23]:
> The khugepaged daemon and madvise_collapse have two different
> implementations that do almost the same thing.
> 
> Create khugepaged_collapse_single_pmd to increase code
> reuse and create an entry point for future khugepaged changes.
> 
> Refactor madvise_collapse and khugepaged_scan_mm_slot to use
> the new khugepaged_collapse_single_pmd function.
> 
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Signed-off-by: Nico Pache <npache@redhat.com>
> ---
>  mm/khugepaged.c | 96 +++++++++++++++++++++++++------------------------
>  1 file changed, 49 insertions(+), 47 deletions(-)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 806bcd8c5185..5457571d505a 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -2353,6 +2353,48 @@ static int khugepaged_scan_file(struct mm_struct *mm, unsigned long addr,
>  	return result;
>  }
>  
> +/*
> + * Try to collapse a single PMD starting at a PMD aligned addr, and return
> + * the results.
> + */
> +static int khugepaged_collapse_single_pmd(unsigned long addr,
> +				   struct vm_area_struct *vma, bool *mmap_locked,
> +				   struct collapse_control *cc)
> +{
> +	int result = SCAN_FAIL;
> +	struct mm_struct *mm = vma->vm_mm;
> +
> +	if (IS_ENABLED(CONFIG_SHMEM) && !vma_is_anonymous(vma)) {

why IS_ENABLED(CONFIG_SHMEM) here, it seems new?

> +		struct file *file = get_file(vma->vm_file);
> +		pgoff_t pgoff = linear_page_index(vma, addr);
> +
> +		mmap_read_unlock(mm);
> +		*mmap_locked = false;
> +		result = khugepaged_scan_file(mm, addr, file, pgoff, cc);
> +		fput(file);
> +		if (result == SCAN_PTE_MAPPED_HUGEPAGE) {
> +			mmap_read_lock(mm);
> +			*mmap_locked = true;
> +			if (khugepaged_test_exit_or_disable(mm)) {
> +				result = SCAN_ANY_PROCESS;
> +				goto end;
> +			}
> +			result = collapse_pte_mapped_thp(mm, addr,
> +							 !cc->is_khugepaged);
> +			if (result == SCAN_PMD_MAPPED)
> +				result = SCAN_SUCCEED;
> +			mmap_read_unlock(mm);
> +			*mmap_locked = false;
> +		}
> +	} else {
> +		result = khugepaged_scan_pmd(mm, vma, addr, mmap_locked, cc);
> +	}
> +	if (cc->is_khugepaged && result == SCAN_SUCCEED)
> +		++khugepaged_pages_collapsed;
> +end:
> +	return result;

This function can return with mmap_read_locked or unlocked..

> +}
> +
>  static unsigned int khugepaged_scan_mm_slot(unsigned int pages, int *result,
>  					    struct collapse_control *cc)
>  	__releases(&khugepaged_mm_lock)
> @@ -2427,34 +2469,12 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages, int *result,
>  			VM_BUG_ON(khugepaged_scan.address < hstart ||
>  				  khugepaged_scan.address + HPAGE_PMD_SIZE >
>  				  hend);
> -			if (!vma_is_anonymous(vma)) {
> -				struct file *file = get_file(vma->vm_file);
> -				pgoff_t pgoff = linear_page_index(vma,
> -						khugepaged_scan.address);
> -
> -				mmap_read_unlock(mm);
> -				mmap_locked = false;
> -				*result = hpage_collapse_scan_file(mm,
> -					khugepaged_scan.address, file, pgoff, cc);
> -				fput(file);
> -				if (*result == SCAN_PTE_MAPPED_HUGEPAGE) {
> -					mmap_read_lock(mm);
> -					if (hpage_collapse_test_exit_or_disable(mm))
> -						goto breakouterloop;
> -					*result = collapse_pte_mapped_thp(mm,
> -						khugepaged_scan.address, false);
> -					if (*result == SCAN_PMD_MAPPED)
> -						*result = SCAN_SUCCEED;
> -					mmap_read_unlock(mm);
> -				}
> -			} else {
> -				*result = hpage_collapse_scan_pmd(mm, vma,
> -					khugepaged_scan.address, &mmap_locked, cc);
> -			}
> -
> -			if (*result == SCAN_SUCCEED)
> -				++khugepaged_pages_collapsed;
>  
> +			*ngle_pmd(khugepaged_scan.address,
> +						vma, &mmap_locked, cc);
> +			/* If we return SCAN_ANY_PROCESS we are holding the mmap_lock */

But this comment makes it obvious that you know that..

> +			if (*result == SCAN_ANY_PROCESS)
> +				goto breakouterloop;

But later..

breakouterloop:                                                                                                          
        mmap_read_unlock(mm); /* exit_mmap will destroy ptes after this */                                               
breakouterloop_mmap_lock:


So if you return with SCAN_ANY_PROCESS, we are holding the lock and go
immediately and drop it.  This seems unnecessarily complicated and
involves a lock.

That would leave just the khugepaged_scan_pmd() path with the
unfortunate locking mess - which is a static function and called in one
location..

Looking at what happens after the return seems to indicate we could
clean that up as well, sometime later.

>  			/* move to next address */
>  			khugepaged_scan.address += HPAGE_PMD_SIZE;
>  			progress += HPAGE_PMD_NR;
> @@ -2773,36 +2793,18 @@ int madvise_collapse(struct vm_area_struct *vma, struct vm_area_struct **prev,
>  		mmap_assert_locked(mm);
>  		memset(cc->node_load, 0, sizeof(cc->node_load));
>  		nodes_clear(cc->alloc_nmask);
> -		if (!vma_is_anonymous(vma)) {
> -			struct file *file = get_file(vma->vm_file);
> -			pgoff_t pgoff = linear_page_index(vma, addr);
>  
> -			mmap_read_unlock(mm);
> -			mmap_locked = false;
> -			result = hpage_collapse_scan_file(mm, addr, file, pgoff,
> -							  cc);
> -			fput(file);
> -		} else {
> -			result = hpage_collapse_scan_pmd(mm, vma, addr,
> -							 &mmap_locked, cc);
> -		}
> +		result = khugepaged_collapse_single_pmd(addr, vma, &mmap_locked, cc);
> +
>  		if (!mmap_locked)
>  			*prev = NULL;  /* Tell caller we dropped mmap_lock */
>  
> -handle_result:
>  		switch (result) {
>  		case SCAN_SUCCEED:
>  		case SCAN_PMD_MAPPED:
>  			++thps;
>  			break;
>  		case SCAN_PTE_MAPPED_HUGEPAGE:
> -			BUG_ON(mmap_locked);
> -			BUG_ON(*prev);
> -			mmap_read_lock(mm);
> -			result = collapse_pte_mapped_thp(mm, addr, true);
> -			mmap_read_unlock(mm);
> -			goto handle_result;

All of the above should probably be replaced with a BUG_ON(1) since it's
not expected now?  Or at least WARN_ON_ONCE(), but it should be safe to
continue if that's the case.

It looks like the mmap_locked boolean is used to ensure that *prev is
safe, but we are now dropping the lock and re-acquiring it (and
potentially returning here) with it set to true, so perv will not be set
to NULL like it should.

I think you can handle this by ensuring that
khugepaged_collapse_single_pmd() returns with mmap_locked false in the
SCAN_ANY_PROCESS case.

> -		/* Whitelisted set of results where continuing OK */

This seems worth keeping?

>  		case SCAN_PMD_NULL:
>  		case SCAN_PTE_NON_PRESENT:
>  		case SCAN_PTE_UFFD_WP:

I guess SCAN_ANY_PROCESS should be handled by the default case
statement?  It should probably be added to the switch?

That is to say, before your change the result would come from either
hpage_collapse_scan_file(), then lead to collapse_pte_mapped_thp()
above.

Now, you can have khugepaged_test_exit_or_disable() happen to return
SCAN_ANY_PROCESS and it will fall through to the default in this switch
statement, which seems like new behaviour?

At the very least, this information should be added to the git log on
what this patch does - if it's expected?

Thanks,
Liam
