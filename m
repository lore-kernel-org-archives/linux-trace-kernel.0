Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACD5262FD7;
	Wed, 16 Jul 2025 15:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752680374; cv=fail; b=Ip1v9DQyT56zGLNDoSt8kByajP0xuXy3y1u2vfoXXIRoQNj55urvujskfdKubcMNCXMX3vY6xxuW/DXHm2G2VeasHKEE2UhepvvMQjtAIAs1241+KMH/iuwnchF01ffCZeDaGUzrO7AX8wU+FxxfyUYUboFMY3KLMsRonEHpMB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752680374; c=relaxed/simple;
	bh=ao/Xd+rZBaW9ciNrlF2zV7bOy1gUooMFkqlx7lrp5y8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RgBqaDqWHAJovUu4Ty8zUZxLMXtXYBfVHpicgMmV5dscdI5dtiOOynk/p55e7HebTi9WvJqjNlSD4Lm+AywpMt3TpuZSOuIBIDFu5ajdDsLJV/sL6WfnZTqjFxwCy389WCl8GQM2/lrKGXdOHOfflgnQGQZ0bzNJ4lu+u+pJR0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZYWL49Qp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hepmMiMw; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZYWL49Qp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hepmMiMw"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56GEtlxK010850;
	Wed, 16 Jul 2025 15:38:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=/Wbwna3jeBYwR1MimI
	klK0XTk7BBUbWqvV7Kpl4HHco=; b=ZYWL49Qpb7Salw6TorrmtOi76XLVDy1fje
	u2ycg6/WaY9kjACEiNbZ6lgfVwPBn6flyLA/vuXTdXNjls9/7VU5xKmDUUrJihF/
	RoP0xqTdnJhCknLi9GhjaMlIltmGbKsDY0qdA03ZjBl8EDWfwNtAGgcJup4VxFLp
	3AtGQFBp72z825SaZNtpB1YwHwlSgOe/zgkXggzi/TJP27+AepAQUrJrzMNdAumI
	YOLsSXKEYjEntVqs/SbNRMf8Uk3YzRod+LpS+Vz3oKm68+ksAUd6eRU5iORFT+wY
	eTkEUue+CMW97rwjwrVIwWXnDglvfdYfN1g5xMCaixx4bRmtpAHg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uk1b16xp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Jul 2025 15:38:44 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56GFSUN3023912;
	Wed, 16 Jul 2025 15:38:43 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04on2069.outbound.protection.outlook.com [40.107.102.69])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5bg23c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Jul 2025 15:38:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fuWgilFh1r3hNQTJ+g5U8bACJrTtwMMKrQ0tFGqO+KNq4QM55yfZ5Vl4EWj24GuGc3nAMPthp0/EGNgbLCUtBRHknzKBm3cZK3ZsTI8QduFFas9uIMrCZOFtO+JY7/PXMLj4jx0ICr0K2/nM2QtBis8Il607TecpGTbhxdheYdIUZnNKzeTO0TSjtLtRlBzsBytW/NuWAEJmPBECpvmJ9hqterV7nxSJfKV7UZs9/yW/O5p6N9nafybnA7xTzeZMe3QnluduKiQnVYQJ3UbWFxD7lf1XrhViZ54J41n+Vo+wL6xma8oaMZJ94eU4FjwqntcIGe6SAXoj+hlI/lr9Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Wbwna3jeBYwR1MimIklK0XTk7BBUbWqvV7Kpl4HHco=;
 b=BdXyhr6z1ed5SV3dVltEtr3nsqlXUY3CKQfNZMN/1jmtGkwE6wuVJ1XzaxVpjHzQomf+Uuo/J+qST51cquMQhMH7Nteix0TGHgag59+dx0aNtnPOwuW+VwvG3oFjNZI+sbWVbww2jgiWKNDm3/TL04iqpEJj3QBYH9zjC3fIbh6e38ysuo5c9A16M4gnCEFK3Z27kAOd68cQka8V164h0N5x2sbL0Q9v5Qj5yB0kMJkhQMvjaVVivueXdeSIC9Y2bN7bTbCq9qyQhZ6xh+WIGaA8UXrGiLAJpcXnRM7vfjdomnq5iljpdYnxppb8/lX3jaI3C4UEoHnD+S5eKNbBPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Wbwna3jeBYwR1MimIklK0XTk7BBUbWqvV7Kpl4HHco=;
 b=hepmMiMwsOavywGcWzyO4unMJpKD+UrhvT45XCRuC0K4XVMKFVWa/kVoeaOC3/deREygLJLjOb6oed3j8wOy/xRri9jbS9YQAPdOtZnSOoew59SrbjrUUpO4smiJ61pEZsPSFyE9shAKUUMWx3YSLSyGRZhoXYtkWShdAM8SVE8=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by CO6PR10MB5555.namprd10.prod.outlook.com (2603:10b6:303:142::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.36; Wed, 16 Jul
 2025 15:38:39 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%6]) with mapi id 15.20.8880.015; Wed, 16 Jul 2025
 15:38:39 +0000
Date: Wed, 16 Jul 2025 11:38:24 -0400
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
        mhocko@suse.com, rdunlap@infradead.org, hughd@google.com
Subject: Re: [PATCH v9 06/14] khugepaged: introduce collapse_scan_bitmap for
 mTHP support
Message-ID: <omxfj73o756gyd2kbdggbcxnk6xomtxwrgr7p6j4gvts4272tj@zuklefzbuotf>
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
	mhocko@suse.com, rdunlap@infradead.org, hughd@google.com
References: <20250714003207.113275-1-npache@redhat.com>
 <20250714003207.113275-7-npache@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714003207.113275-7-npache@redhat.com>
User-Agent: NeoMutt/20250510
X-ClientProxiedBy: YT4PR01CA0458.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d6::11) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|CO6PR10MB5555:EE_
X-MS-Office365-Filtering-Correlation-Id: a7e65e50-da5b-4f3b-d1af-08ddc47ed62f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007|27256017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6ZKjG1QTeXe6DU5getMPtNu0VZ5ClGd5+BXwRDrEFyYWwMRaRmPxV+gY9O0c?=
 =?us-ascii?Q?vxHNh4m1O53HtfLPsnn8zEsEuuq69EIOu0T3pxDB+eUL4EpfKg/VgqZjHJhg?=
 =?us-ascii?Q?U0mx9LmObsisKBrI4+olJG69/ATpg1HJZ8702sK8ndFl/TtdWJo35w9dfReM?=
 =?us-ascii?Q?RMUAoaZU7klW9UVH/WZahU5Mh+oV897HllfNCp9BUyTQDHDne3G+i70GB5Zb?=
 =?us-ascii?Q?Ge0lhER2J4AcI2pHoB7/zaoDlRFtOt9dS5F9qwJyRKjlS8YdVSTc0Nn81xGV?=
 =?us-ascii?Q?5I2Q7P4/BPAt8OcTczonaVjXjqk8ylNa1qp9yhUKnUXUDFydHcO6FF1IG69Q?=
 =?us-ascii?Q?RD+6LRrB47f2+qOMMbHKYHMLTigr05+99bN0TvLl1xdaY4bCkFPnP5EtHNIL?=
 =?us-ascii?Q?tGOEMTDsLUHfgcggk+8L4lCVjUy/CP87KmaP9XGNUYydP8DvufClprgFv9QS?=
 =?us-ascii?Q?xBZ6W7usfW9NNVfRo5SBauRn52TRsQTrmJmpSxeWXC2CZzoLGL9Ewk9dUFm2?=
 =?us-ascii?Q?seUiNDBT8MYSP/biSBPPp9qrZ46UlYwSynX0cep22Q97szRFlozmHTGfDtYC?=
 =?us-ascii?Q?SqHqfNmEnBIHBbk2fa1y4JHGJnQU2f02Y9pUsxLw9lEJCk9FTXdXFPLcvrHV?=
 =?us-ascii?Q?qtOI0leSYwn1As4Lb7AynDZjW87yExi4SGYGc7SRWThzvNP1SrPA+2Y4bOlZ?=
 =?us-ascii?Q?10i4MJzSH77V4lW1kFWG7WIKz6WHerLoetBJfr3aN7Ohe+p/IKVdol9gvdTc?=
 =?us-ascii?Q?lJtix+qqT8Q9Nurb9cns1B1HAg2U98GfO9GU2TFj8Z0Dc4YDI9wjeN5dYILR?=
 =?us-ascii?Q?gwmFSaJFbx9fE1OANskyx5/5XrNSCqJQnTwMZm0UKr+NL88a/DEN4U9owLaS?=
 =?us-ascii?Q?w9aniejzRqHpv46zUIEgPnXCEgBGS/JLlejZN+n8f/SBjVtEEE1U08MDk+XO?=
 =?us-ascii?Q?QT3MYyQQ22LGVqeoh9blNzvpR3OiTnPa0KPjM6+tJae6tBerV2XJ94DW4x+N?=
 =?us-ascii?Q?XzSFN3pkE6K5jc/QuvixYbBNjFfOYcmceg5qY+7QYTlXuNEysF+LRnhVq7V0?=
 =?us-ascii?Q?yVAar1UO9VEnHysjeAmldmSwiwyVhQ1O0+3haQDAtNr82Ft7A8zCo/v5j2Sy?=
 =?us-ascii?Q?xqW2zeoMRKPqyUFFzvuo9Aug7dHEbT2cYQrdv9wzfPqZhltm1wsWbMZ7UVt3?=
 =?us-ascii?Q?ZPlKzKuYDhMebLQvDHLPKeIAyug6HnuQN+e52zAM+bSBUAfBsRn8CMEoXb/G?=
 =?us-ascii?Q?4b+eLbRHBtlDdWaNY/xGCSKdbUcYqRAJ/cj54cm3qDXEDA+aKkwcypVO6aHF?=
 =?us-ascii?Q?ueBSvzMTHjZ03Sp/MFkoMFaCAe7Pu+hMyKVwYox7AhMS5RBdXse//0J5+ZPN?=
 =?us-ascii?Q?MViWQbVGmt30mbEtT6550lsNiSB1JNnaVKPLt5XJzr1oBah+qo44b9CtHAWg?=
 =?us-ascii?Q?nHL+xLRurBoraOzrNNcizwqJsQ7DXs9b1KilsnKe2TBBBC1gTvNuTw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007)(27256017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o5MYhFgM264esiPMFvFT0Po+Z8DR2WDihhEkrTHjkiSvvF7BtrJ+5PwNn/kO?=
 =?us-ascii?Q?HdCZvmP23Zh7OYIp40RpWMEd16sV7V+C96gicBojMf+YvDyasAQH8MRhJR1v?=
 =?us-ascii?Q?vw9QRFe2NTnfxyJ130M+340XzsS7wIYmHMJeyl+x2LUf2pXZM+vvfEKbjq5i?=
 =?us-ascii?Q?RfbO6NzrReYFUrGtAUZxNcRx2BtaE9CCAAG5UVE1YuAvTWgGSN9OwZSRveVM?=
 =?us-ascii?Q?3ub1ekoICyeHMx14Q1TmX/G8pzXDqTqFfU4BHr27AZWlPYEdtoTOyru6E42l?=
 =?us-ascii?Q?EuPXgUxdpnSww51j1pxa1UBa//Xg0FguhIgkygjeN50PN1bwPnF811FdxsYi?=
 =?us-ascii?Q?KWAdPCfeypNvsfIVOM2lbOeDnjupx9XRrshzvkw1mWnMr1gu14PQxswnN4Xy?=
 =?us-ascii?Q?MCoQoWgapjM5GO3bfKz69Uf787P6r3jGjVWhqtITNHqgvmPGsqJHFQ7GwZn7?=
 =?us-ascii?Q?ckOjefIDtwEol/rH7fJ/j4/YVtgrOYTrmgoajIqwxwXBH4fnTZSkOpmO74NK?=
 =?us-ascii?Q?qj8x9KsygkLSusjD4SJY05IGgcq1GwDWVqRt2tp5woyv1EUn7rF3QxyZQiFE?=
 =?us-ascii?Q?yHdkk0gfMHkjnhhQNvM9uWXe/qD2ygJ1PVDfubnQaVokoZt9ktFErcdhRHSr?=
 =?us-ascii?Q?CRo3D5Atmny1hKRxNeuK9mijkBlc+kc1vwa/2xg6lrGHKG25qCxRpl7q/EFx?=
 =?us-ascii?Q?2Qd7hSHPyRYqqST1gWsJVwvLdQs6cCbRNza0+Xm9HdLvOojjU81JLn8Yxt5U?=
 =?us-ascii?Q?uibVCLfDVCLzdL53cxcXGiSqT+LBv4FXa8IhS+cyAm/oJ9ME/KMVuRMwFUz/?=
 =?us-ascii?Q?FPp+RqdxXCVq71yYEzw3z8NM+4N6oqPijnVajjObufNmnA0I5Q773HBUEx5w?=
 =?us-ascii?Q?J6ckRrmDpH7sq9whTKRB0B0SvT4B4Bg1AUHg+n09A+y1GsU10uNSSZerufqB?=
 =?us-ascii?Q?LhxIxaDOySuRN5Iw49eozrmfwtlXPsVQ3brvET2Kq+5XoMl3viBQXHw13l0O?=
 =?us-ascii?Q?x5iSG5qyzLGusAan+qLJ6FDGrKin8LnnSDQ11Ctzv9FUnn49XGU9DNN2VXaW?=
 =?us-ascii?Q?U9IxaL9Eb/Gy7O2sQVCVFTXGCT62z6Ga4sivxomasoMkEZiqzodUTdbB8qaH?=
 =?us-ascii?Q?tc7vDgrSOdHj8AZ4rIf3g5dyFe7Ndf0mzJ/hTAX1Y0mdjkolbOi0WtzHIZsK?=
 =?us-ascii?Q?uygfLltTAlqdukmHpJsFSqC9ehpw++GNI6PQ9LvKoXQA6MpnxoC9be0VPGY0?=
 =?us-ascii?Q?xBk1dWKANQdOKa6yg/87BuYgSJVIidMdLyg7fW6sKEMbQTfSrkgeFVnaENSv?=
 =?us-ascii?Q?VJlQ1b9CZKW6pp4ksN3WKXMW35/TYvMBey09IcmmegwAoRNuMtT0oA3ym5ai?=
 =?us-ascii?Q?5EAC2rwaTNPxUYwa6Vq6S7dcROkwTGGNr1Buw1fODGncK5wEAQ3Ehl8zc8k4?=
 =?us-ascii?Q?XaizbtZB/6XJpSMfP10lzt2/UHsIbqlx9XfzwriXrcJwblf5brI53MI2cw92?=
 =?us-ascii?Q?bguVUWhofC+/cXtuc8Bv25ml46BfvZI1+QL6TYCfIBcLMlPrWx75oGmr8xu0?=
 =?us-ascii?Q?vzRsNPlvLYnUaCVI1feSDrWYStw53EZFUATxOXkm?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YJEhMrgaUktvbMi4CF8Xtuq8xW6v+ITc4/HkMeVWRWZrdHs+hcB5BIcIoeR8JlpSZ22HTDI0j7EUJMoawdG+p7XnVQGWyy3buo2eV5pGiCs083imKGeN20ZFWiubBD8Af8ZnVlkQ+M4XXcPvrEEcmNjBKIvkCf0GOlmzFvfHY9gIZvaO/tFSFbPs/7jq07yNLMxQG+MTM3v1Dez/Mt6KuSMZGeXqp/InBRsmoWEeTCXsFAlJ40TbuY7ASFWf1qE4V+1GVC0vF666R+0rO95Pkd01OQIi7e853vvbrqyv0E7mAQCQwe1kMu+Z0s4Ktx6SpW7FbnZ6sKjSZ0MCOors05yh1o0Mo28nwev2ZGMdU29sZs68LuBHwNl0vAg4Qm+70srlSVtuevqIwEv6yWvRDCFGU5lTClJqQSN6pSyZVaznkdawbiHZXrROtLJxyL542GfgqQx4ouSRUPF9fLnWZKRcIUiNRZ+PB4lg4w0wzxX3yZlmI0kx2+59a56jDSweyz9KjUhOcn/BK/Fy4uDlRaw72H/eWjfcAYkc7T2VK9YCUht3rIWKTvxS8faguC1RaFj1441IRdpETxfCh8VohFDQS3+k+5F2qviYjIlFdfA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7e65e50-da5b-4f3b-d1af-08ddc47ed62f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 15:38:39.6279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kYZHmpOB+f63vp3wgkYlFn41uQp+R7xfmJqcsrVYxHGVf3qxXAWbcw2Mvqd0HuXKN+J1f7BThLCtt1B2BnHv2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5555
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_02,2025-07-16_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507160141
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDE0MSBTYWx0ZWRfX+O4mmYdn0Ra5 ll10UqsFjbLwRNePUGyDt+oarfsDX9wGXGmfIH0VSURicWi/Y6lH95jnFIyt8RePbH8L1XHksLG QlhrcUI9xzf+9IBLA7nywAN3OpbSE0sNvm2z/X7zg9X9O8JRd7RM2Uux0oFm0ySthV+r7HCK7fQ
 DYemPJcwiTfAP5S/uvMYXo1vBDpNWf+D7tLco9Y8dpUW8DUD4HwmrUeCQxYV/yK8odJWg39rv+o QSMg2oRvr6Qx0gHghsxrxHCr+RLABtjSNQDD6N7a0RB5lkumIi+vJhJJb1RpTh96mO3Z/BFm0Mq OG6i/VoL7Q+pjnEMiJTO2+UmO6UT1P+CnEcaQ0Zx3vSQ91PhQ50eW/39KYKp3JN4uUH6PxmhU/Z
 +iJtkA3GshHRWDHKR4x5007tzT1oxw/NtwHrbCAxC/CtiGE5Ult0lVJQsWXjIT5X+o6MkoGD
X-Proofpoint-GUID: LUpXssvK4QF29y9ltzMnnJmwusO6bUjD
X-Proofpoint-ORIG-GUID: LUpXssvK4QF29y9ltzMnnJmwusO6bUjD
X-Authority-Analysis: v=2.4 cv=J8mq7BnS c=1 sm=1 tr=0 ts=6877c784 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=20KFwNOVAAAA:8 a=JvTTyndsoNIOsIutUGsA:9 a=CjuIK1q_8ugA:10

* Nico Pache <npache@redhat.com> [250713 20:34]:
> khugepaged scans anons PMD ranges for potential collapse to a hugepage.
> To add mTHP support we use this scan to instead record chunks of utilized
> sections of the PMD.
> 
> collapse_scan_bitmap uses a stack struct to recursively scan a bitmap
> that represents chunks of utilized regions. We can then determine what
> mTHP size fits best and in the following patch, we set this bitmap while
> scanning the anon PMD. A minimum collapse order of 2 is used as this is
> the lowest order supported by anon memory.
> 
> max_ptes_none is used as a scale to determine how "full" an order must
> be before being considered for collapse.
> 
> When attempting to collapse an order that has its order set to "always"
> lets always collapse to that order in a greedy manner without
> considering the number of bits set.
> 

v7 had talks about having selftests of this code.  You mention you used
selftests mm in the cover letter but it seems you did not add the
reproducer that Baolin had?

Maybe I missed that?

> Signed-off-by: Nico Pache <npache@redhat.com>
> ---
>  include/linux/khugepaged.h |  4 ++
>  mm/khugepaged.c            | 94 ++++++++++++++++++++++++++++++++++----
>  2 files changed, 89 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/khugepaged.h b/include/linux/khugepaged.h
> index ff6120463745..0f957711a117 100644
> --- a/include/linux/khugepaged.h
> +++ b/include/linux/khugepaged.h
> @@ -1,6 +1,10 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>  #ifndef _LINUX_KHUGEPAGED_H
>  #define _LINUX_KHUGEPAGED_H
> +#define KHUGEPAGED_MIN_MTHP_ORDER	2
> +#define KHUGEPAGED_MIN_MTHP_NR	(1<<KHUGEPAGED_MIN_MTHP_ORDER)
> +#define MAX_MTHP_BITMAP_SIZE  (1 << (ilog2(MAX_PTRS_PER_PTE) - KHUGEPAGED_MIN_MTHP_ORDER))
> +#define MTHP_BITMAP_SIZE  (1 << (HPAGE_PMD_ORDER - KHUGEPAGED_MIN_MTHP_ORDER))
>  
>  extern unsigned int khugepaged_max_ptes_none __read_mostly;
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index ee54e3c1db4e..59b2431ca616 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -94,6 +94,11 @@ static DEFINE_READ_MOSTLY_HASHTABLE(mm_slots_hash, MM_SLOTS_HASH_BITS);
>  
>  static struct kmem_cache *mm_slot_cache __ro_after_init;
>  
> +struct scan_bit_state {
> +	u8 order;
> +	u16 offset;
> +};
> +
>  struct collapse_control {
>  	bool is_khugepaged;
>  
> @@ -102,6 +107,18 @@ struct collapse_control {
>  
>  	/* nodemask for allocation fallback */
>  	nodemask_t alloc_nmask;
> +
> +	/*
> +	 * bitmap used to collapse mTHP sizes.
> +	 * 1bit = order KHUGEPAGED_MIN_MTHP_ORDER mTHP
> +	 */
> +	DECLARE_BITMAP(mthp_bitmap, MAX_MTHP_BITMAP_SIZE);
> +	DECLARE_BITMAP(mthp_bitmap_temp, MAX_MTHP_BITMAP_SIZE);
> +	struct scan_bit_state mthp_bitmap_stack[MAX_MTHP_BITMAP_SIZE];
> +};
> +
> +struct collapse_control khugepaged_collapse_control = {
> +	.is_khugepaged = true,
>  };
>  
>  /**
> @@ -838,10 +855,6 @@ static void khugepaged_alloc_sleep(void)
>  	remove_wait_queue(&khugepaged_wait, &wait);
>  }
>  
> -struct collapse_control khugepaged_collapse_control = {
> -	.is_khugepaged = true,
> -};
> -
>  static bool collapse_scan_abort(int nid, struct collapse_control *cc)
>  {
>  	int i;
> @@ -1115,7 +1128,8 @@ static int alloc_charge_folio(struct folio **foliop, struct mm_struct *mm,
>  
>  static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
>  			      int referenced, int unmapped,
> -			      struct collapse_control *cc)
> +			      struct collapse_control *cc, bool *mmap_locked,
> +				  u8 order, u16 offset)
>  {
>  	LIST_HEAD(compound_pagelist);
>  	pmd_t *pmd, _pmd;
> @@ -1134,8 +1148,12 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
>  	 * The allocation can take potentially a long time if it involves
>  	 * sync compaction, and we do not need to hold the mmap_lock during
>  	 * that. We will recheck the vma after taking it again in write mode.
> +	 * If collapsing mTHPs we may have already released the read_lock.
>  	 */
> -	mmap_read_unlock(mm);
> +	if (*mmap_locked) {
> +		mmap_read_unlock(mm);
> +		*mmap_locked = false;
> +	}
>  
>  	result = alloc_charge_folio(&folio, mm, cc, HPAGE_PMD_ORDER);
>  	if (result != SCAN_SUCCEED)
> @@ -1272,12 +1290,72 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
>  out_up_write:
>  	mmap_write_unlock(mm);
>  out_nolock:
> +	*mmap_locked = false;
>  	if (folio)
>  		folio_put(folio);
>  	trace_mm_collapse_huge_page(mm, result == SCAN_SUCCEED, result);
>  	return result;
>  }
>  
> +/* Recursive function to consume the bitmap */
> +static int collapse_scan_bitmap(struct mm_struct *mm, unsigned long address,
> +			int referenced, int unmapped, struct collapse_control *cc,
> +			bool *mmap_locked, unsigned long enabled_orders)
> +{
> +	u8 order, next_order;
> +	u16 offset, mid_offset;
> +	int num_chunks;
> +	int bits_set, threshold_bits;
> +	int top = -1;
> +	int collapsed = 0;
> +	int ret;
> +	struct scan_bit_state state;
> +	bool is_pmd_only = (enabled_orders == (1 << HPAGE_PMD_ORDER));
> +
> +	cc->mthp_bitmap_stack[++top] = (struct scan_bit_state)
> +		{ HPAGE_PMD_ORDER - KHUGEPAGED_MIN_MTHP_ORDER, 0 };
> +
> +	while (top >= 0) {
> +		state = cc->mthp_bitmap_stack[top--];
> +		order = state.order + KHUGEPAGED_MIN_MTHP_ORDER;
> +		offset = state.offset;
> +		num_chunks = 1 << (state.order);
> +		// Skip mTHP orders that are not enabled
> +		if (!test_bit(order, &enabled_orders))
> +			goto next;
> +
> +		// copy the relavant section to a new bitmap
> +		bitmap_shift_right(cc->mthp_bitmap_temp, cc->mthp_bitmap, offset,
> +				  MTHP_BITMAP_SIZE);
> +
> +		bits_set = bitmap_weight(cc->mthp_bitmap_temp, num_chunks);
> +		threshold_bits = (HPAGE_PMD_NR - khugepaged_max_ptes_none - 1)
> +				>> (HPAGE_PMD_ORDER - state.order);
> +
> +		//Check if the region is "almost full" based on the threshold
> +		if (bits_set > threshold_bits || is_pmd_only
> +			|| test_bit(order, &huge_anon_orders_always)) {
> +			ret = collapse_huge_page(mm, address, referenced, unmapped, cc,
> +					mmap_locked, order, offset * KHUGEPAGED_MIN_MTHP_NR);
> +			if (ret == SCAN_SUCCEED) {
> +				collapsed += (1 << order);
> +				continue;
> +			}
> +		}
> +
> +next:
> +		if (state.order > 0) {
> +			next_order = state.order - 1;
> +			mid_offset = offset + (num_chunks / 2);
> +			cc->mthp_bitmap_stack[++top] = (struct scan_bit_state)
> +				{ next_order, mid_offset };
> +			cc->mthp_bitmap_stack[++top] = (struct scan_bit_state)
> +				{ next_order, offset };
> +			}
> +	}
> +	return collapsed;
> +}
> +
>  static int collapse_scan_pmd(struct mm_struct *mm,
>  				   struct vm_area_struct *vma,
>  				   unsigned long address, bool *mmap_locked,
> @@ -1444,9 +1522,7 @@ static int collapse_scan_pmd(struct mm_struct *mm,
>  	pte_unmap_unlock(pte, ptl);
>  	if (result == SCAN_SUCCEED) {
>  		result = collapse_huge_page(mm, address, referenced,
> -					    unmapped, cc);
> -		/* collapse_huge_page will return with the mmap_lock released */
> -		*mmap_locked = false;
> +					    unmapped, cc, mmap_locked, HPAGE_PMD_ORDER, 0);
>  	}
>  out:
>  	trace_mm_khugepaged_scan_pmd(mm, folio, writable, referenced,
> -- 
> 2.50.0
> 
