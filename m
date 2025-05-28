Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6436028C01B;
	Wed, 28 May 2025 15:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748445834; cv=fail; b=reHsK6jBhA8EM5386Ar1x340Kcliz4yLKaxrDRzgGHpUa/b44Tnl78yqCQoBLL4m4AOIycbUv1/NT0yfeeCgOijtr6V7pDEldAgXANHdBrKdVJU0G8UlxY11/1T836EwZA9uNqm0YSHhWOKOFS/SXaX1effqGUl8oKOT4+HTPrs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748445834; c=relaxed/simple;
	bh=Zesn/y+os5rKx3bWRFM+NB1J5bBgK2O2eq4fDecuU5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FfqygO17oTCifcINQn2rttNLZSZ4CUyiuIhfhH27dRhtm7bhua9+UaPkDIN2FsIyQ59cUj0c76YgTistOIJKKCeHpGSZOnlGUPrtcv/MrXPfm0NMSBpGKJ8W9PTezqlTwc4gElFaMgmrWQfajRBfEiyU/viKSoLOqTCw6KRnBV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=euStvtdY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LvbH77Mg; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="euStvtdY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LvbH77Mg"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54SCqJ4c002603;
	Wed, 28 May 2025 15:23:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=3OK9feUGTuE1UidIpgbVW102/B/pFfVnnocmKyyHBf8=; b=
	euStvtdYM1JyGyWvQMvAJCkdzvSVhOtdhVJWlsXfg0/cI2CVB3WTwu0VjaTt6LZw
	bMCeIPMEWCr3wE005qnu8khnmRfXONsdvwXNIIEvRabUng3i4M+e9A95p1AA6uwa
	pQ3L7NHa4EignPov++ov67F7F8Crejo/FyLMJxlbJBHq++XhIkMyPhx8fWSPvyck
	s7RbcKnlkFsajM7zOo8rqOr+HIYPldKHIhGVGNd6ERUpsi7+QOfImorWYdaWLLHQ
	13aY5BBu0JKTQyrH25ir7rbyFUf35CcYrsn66I4gdq8JH3C/1/6gvzPXN6X/b2OW
	z1DGm6/bjYBdODV4+PRTDg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v3pd60un-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 May 2025 15:23:32 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54SEtel4027847;
	Wed, 28 May 2025 15:23:31 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46u4jajwac-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 May 2025 15:23:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GqvQzeWi0BDB9YfM2+hTiYBw8LwvZUimdOpuFj4ezWQ+wYROC3bjdinGfGyKS1iwha+yDhmWFfYaEqcZhd7t89vTkwbiRODEdftqcs7y34QiFUnNa0LXLTe9UKi1DNtwZHFwFhp3Y7SlRMNB5/sQQoJHtk+838GNwP2UrhtBjEQzkgWEhsiUKp6VVV29FTMKxnOLIC/ylqEHEhvCEestTp8kVM4LlD1GrSbbT4ZCbJG19qvHIzlDCVyYfblTezDDjUVybmof5dTdZlRbmoNYyXcy8OfpRq+zjiF90J46YHwiYze82s9Ys/tx7GxSyKswkWp8b78Jfwu8BzF3K4KxDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3OK9feUGTuE1UidIpgbVW102/B/pFfVnnocmKyyHBf8=;
 b=xL2c5YoKaoTAnXgOwenEkV9pcdYhpPVfe/1h/KcxvYl1QbZ2GGa6beTFviVDvdgsLaYWZyZwPwkZN99l9vah5g2cfF+mwTai0FsVykFoWsGCYpnAM78Ogqe1nQxmiXTceoZA1W1rls7DAsonG1kgLBKUro3hV7dxpV1qO5OYWThwLu8fOp0d8/bizIAlIAGNVU1deDXulZaOR2k8D8MqwHJ9k7Q7PpPIoLEKlQJgVyrT78Rx5H+f9e+/5OweTLjSS29IeqQ2m+AY+fXYHOWmBgLW7dUEoyDnzuyZ6aXDDQQDnCXU3l2ZIEjWmw1j0oSGfcUfa7ORQxKCiyVYNpG1NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3OK9feUGTuE1UidIpgbVW102/B/pFfVnnocmKyyHBf8=;
 b=LvbH77Mg3jZzta+ccaqpFq+0Cx2JgAko4PAHNNjIbgmBUtFRi7w228QOdxpFbiFjspyrFbhHIOGDEH/WVtuojgocnO5axx4z0acpftt/0R3T44v+OhhxwD8ksVmFd68Kluw4e7I7tkHNvbkYUOoKxW2SK+/cx57mHy8Od//c2No=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA4PR10MB8400.namprd10.prod.outlook.com (2603:10b6:208:567::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Wed, 28 May
 2025 15:23:27 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8746.030; Wed, 28 May 2025
 15:23:27 +0000
Date: Wed, 28 May 2025 16:23:24 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Eric Mueller <emueller@purestorage.com>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>
Subject: Re: [PATCH] mm: remove unused mmap tracepoints
Message-ID: <92d947de-110e-4c17-a822-f626bac9b540@lucifer.local>
References: <20250411161746.1043239-1-csander@purestorage.com>
 <3ucksa6coiwco3wpmcjtfwezqjigzm2zwvdvkt2ryvefzojtqy@4lda47c236uz>
 <CADUfDZpPGQEY9u3p3MCU2S3qmDyKmE1JnSQ6G2jO4_J40rQeeQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZpPGQEY9u3p3MCU2S3qmDyKmE1JnSQ6G2jO4_J40rQeeQ@mail.gmail.com>
X-ClientProxiedBy: LO4P123CA0642.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:296::11) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA4PR10MB8400:EE_
X-MS-Office365-Filtering-Correlation-Id: cccbded0-8d19-432c-4be8-08dd9dfb980b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L2tmM2NzRk8rYTRwRTdVR203cDFjY24ya2FDa2VXVC9qVW4xWisvR1dJUWV1?=
 =?utf-8?B?cXRWd2xwRVRmb1kyNVFaZnNnSEN6bWVkQ25lUUczcFZ6Y0FkZUFrc1A1YkIz?=
 =?utf-8?B?a3UvYlFLRTBDYnViTE1zY1NpVmFsUmphR3NCTy9zVFNaMGRzYld3SFlrcFl1?=
 =?utf-8?B?cHEyclV6V0YzV2xUZnBHanJndkZ3b0lDdlIrQklHMHN2OG9GaUQxRmJ3UXI1?=
 =?utf-8?B?OXRCdzE4c3ViRnF1WjZBMGRtL3hLNi94SlFUbnc1OGROelJKOUdaNkRpUUFY?=
 =?utf-8?B?TGxXelRJY2lzbVREYkV4dWZBRnFKOTBaUFlRTHJQdDhqTFJSVjYwUXZXUFY1?=
 =?utf-8?B?NFE1blJIMnBxRXNyN0E1RHNZbGJJak51UWMvVkQwRWI1anY0Z1ViWG9tejVF?=
 =?utf-8?B?d2Jaa2N3OHhnM05IcU5hRmI1VkR4RStoL1BaTDZmU0Y3cW0wVWxhTjU0ZWE0?=
 =?utf-8?B?SFBQRGxoODl1Mzh2V2VNSTNhWStmS25FTlRCWXZURWlCUzF4aXRrYVkreWJB?=
 =?utf-8?B?dE0rS20xSVNjbEoxdGd5c05xblJ6KzRPb290bndxek5saWpSY2MyYWk0eElE?=
 =?utf-8?B?YjdRa2hhRzRJamloT1pqaDFRUVFkVWxQUnh1Yzl1QkRCdktkdjFVSFFjWDBL?=
 =?utf-8?B?bzF4cCtuVmN1TjVFZGg0azE0dm04WVJRMDM4K1AySUJYa29xWElnQUtIOTlj?=
 =?utf-8?B?VlQxR2FiUkp0bGRoWFpYMy8yTVVYUlZlU1dZdjhTN0U0QTdkN1c4Y0QzUXZ3?=
 =?utf-8?B?czhBbS8xVVcyZDBSbHY2Y0tNUFNVeElRbWVzY0hIYVllWDFFMXZRUWtoTlAw?=
 =?utf-8?B?SXRnSmYvTk5ucklxMnRPMDFRY1p0Q0craWJET296NTB2d3Jnb3RaUnEyS2Ur?=
 =?utf-8?B?VmNoSzZjZ3lCN0s4c1JnMmdUdC90SVNqc0JhRFJxbXdqT2dPRWorN290S1Qv?=
 =?utf-8?B?Y3hZeUd4M1p1SWR0aDQwbUdDQmN0Nlc5dExwcStjbGdtYm5YYzh4TFNUWXFO?=
 =?utf-8?B?R2JEZ3pjRmtDaWlCeElDYUUybkY3U3FJc3pQdThZRkZMYk4yK3dpVTZjSDBv?=
 =?utf-8?B?aFIrUVVkNU01c1Q4WEtUUTdlVDF6MURrYlVTMmNqcm56MzkrN2RWSS9lU1V4?=
 =?utf-8?B?Tlh2dzJWQThkeGhEMk5ua0NxSWJIbmNLcUNiT3pFYkVMZmJHdFVEMmZsSFhW?=
 =?utf-8?B?SFF1US83OHBtRWpsTnY4aUxKNWo1M2NEZ0ZwWFhsQ096R09MSlBRUVFzN3dL?=
 =?utf-8?B?WjI0Qi9GamxKMG5FTUVaanN3YlExeVd0RzhYNFprTzQzKzJPeUVZczRlYmd0?=
 =?utf-8?B?N2pjNUZsT2p1eVB1UTdIaENvWXVLbnQyV3JrSFBGVGNvejJEWllraHF4MTlU?=
 =?utf-8?B?Y2hBQ1BsdTAxWC9UWkI3dVlleWJnOXNRcXliMHBHOTMwbkNvOU90WWVQOXhs?=
 =?utf-8?B?WWtOQUFZTjFWL0RvVW8wQk5QUzk3dWVzODFhN0hqN2NvcFNibFFyYU9SVFFU?=
 =?utf-8?B?SHYzTGlhcTR5VEhmK0twSjk0cUtDUSsyeDNUT1JLaVR2c1VrczVjV01sbFFs?=
 =?utf-8?B?UXlhbC9nTnpwUHhTMy9sMWdIMEhHU0MvQmp3dWN5c3BHM3JETytJUjAwQ0Jo?=
 =?utf-8?B?YjJjbGl0UHBNVWgxTWJHaFJjbU9FNEpCdm5HSVJZMGhEQ0VGaDAyWDdtUEVs?=
 =?utf-8?B?MEFEcXBBd2hhcFJ0VWEvYTVYTWlNMkJHM3JZY1RJbUg0SEl4UUR4T1ovdzNQ?=
 =?utf-8?B?dWViRUdaVS9VT25ocVVpNWJXZXpjK2xaVDdtSVdPZXQ3NGd3azdXU2puUEFZ?=
 =?utf-8?B?SkRacy9HblRzeTRvcW0vNWVtcWFOWmdZVGFYMTlvNVJ0QVJiNngyZFJMSmh4?=
 =?utf-8?B?dDRLSlNGZUxuOXJqaktwQlFPc3RvM0lsWUhyUEo1b3BOUGU1YzdwbkxTUDlw?=
 =?utf-8?Q?4lyyaKa9ltM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TWhxMjhzTXdBck5vS3NxMjUwMGtRRVhlczNvb2VwMWtiRmUyT1BKYVhDVHFj?=
 =?utf-8?B?aldONENrajFBcGNGZCtpUmtqaVlRektlWWo4S2ZkSFpDY3VRMGRuMHpHLzd4?=
 =?utf-8?B?RmdQVFVUN3d6TzV2WmF6NVUzT0NBU3JndkV3Y1A0VExQVldwVElBTEc5TFVh?=
 =?utf-8?B?eXJmQllJNDlaSitmQzJnTjM5d1FlMmFiRm9DUVlCQWM4RVN4eTEvcSttQmRP?=
 =?utf-8?B?MHpLYUxuK09odE1iZXc1UnNTTTFPOEFpU2VKRkRjREJDTW51SmdYNXMwY2cw?=
 =?utf-8?B?WFpsZTRHanhBeVU1WDdZYjAzTTVwdCtCall1WnlpZlY5aUpjYkhFTW9sNVpX?=
 =?utf-8?B?ZHc2elkvV09wM0xyaDBBa0JVTWt1aDAvcnRYaE91c1Fub3B3TU50VmllUmpH?=
 =?utf-8?B?QUllNHVYbUFrUS9yMk5XVnZObUQxSTQ1UzlGbHhKQWVWWmxpdFRSN015Vzc3?=
 =?utf-8?B?c01vaWF1NE1zWExSd0RuV0N3T20rVzY2NHp5SmZNTVc0YkliV0RYR3h4WDlZ?=
 =?utf-8?B?eGFZNG1qRjZXTVYwZ0RpQVpJV29XaGQ5eU9hOTBWYkV6NFlFU2ZKbm9ObTRT?=
 =?utf-8?B?Y2JXbDdZRG1ENlFqOFNBcGlHTGI1Zyt4MTVhY1prSXdOOWFlaDZ5ODVFSEpD?=
 =?utf-8?B?eXVDdWRpYU9iZ3FqM1lEeldNNElNenpXZTl6ZXprRlhFdi9PZEZ0WUoyVEhp?=
 =?utf-8?B?YUY5M0J3NXJNWlcva2FaVFp5T0hpbzkrM1hEaGFYSlRReGg2Y3ZDdUxjODBy?=
 =?utf-8?B?Mit5b3JTTHJBT045bElRN2hCSi82cVlzRS84M3FxTTdDL0Zhb1FsVEc4RUM4?=
 =?utf-8?B?SkdWT2RaeTlFcmZkZkNYWkxsVTVTS3JWd0k3Z0JwQjQ1NzNDVFFDcm1LK0xS?=
 =?utf-8?B?bUxtM3U1dTZSaDdzTGpkUVFBVzR1ZHpXREhlakNTN1AvNmtFRFZxV0ZISTlF?=
 =?utf-8?B?RFBCdGprTmRXVjhaYnJkN1UrT1ZFSk9jQkFPTUlBaTdpRDJZQmsrVldscVR5?=
 =?utf-8?B?NzkyQ2pBei9GSVptZWZsMDZKSzl5cTRBc1lYYjllTk5JaEdkUk41WFpBLy94?=
 =?utf-8?B?T3k5SjM4ZFgxUzNEdEIrYlR3QllReTNHNjNHaksvUXRPZU5BMk1YaHN0MjBz?=
 =?utf-8?B?cW1ja0lLenBhczlDTVp6ekZDS0lWYktDTkxLaGJ4UWtlZ2hadEhHVWRNejhR?=
 =?utf-8?B?UzZ1b0pNR0Yxd3EvTjFaTHhESEJJT3F6bXd2eDJ0MU1BMmVkeVF4MGRRKzFy?=
 =?utf-8?B?UmRSZEs0Slptby83emVxbDVWckNPWmVYbDNoUVBjVUc3bjlYbk9qNFByUUZl?=
 =?utf-8?B?cXB0TWZ2bWUvT09sV3VPYmFMclhJZTl2cmMyQ1dzL0dtazhUQzV4VVQyVlUz?=
 =?utf-8?B?dElSVE5BK0cvOElMaStwV0t4c0NxNUhvUlU4cERGUDBwdUsrV3RERnhlT2Uz?=
 =?utf-8?B?Q2dpQVJiYUE1Zk9wQkhYVDNOamJnNThGRERKclNJMWpQV3VUR2RaYnJHNHRV?=
 =?utf-8?B?OHNGYTcvMDdyMDVocENzaCs3VXN3UkpBWmRZYndjbjAyL1VKUFNpbnYzY0RP?=
 =?utf-8?B?c09tUlNMdGF6N0REV3lRRSt3WE8yODBod0N1MVVsYm51aWN5UUhQSVVWTDk2?=
 =?utf-8?B?N0FzVHdZclcyU2w5bW94TXJOMW90ekkzUjR2cGRpa1BWclh6eThSRVp2ci9n?=
 =?utf-8?B?TnB1Vmg4amZwQTA4c0lhcmN4R0VZS3lXVnZJbytidjFqS0Irb2RYdk9uNk4v?=
 =?utf-8?B?QVJ0N2hUNEJ2SXpSTmpoaEJEdE1Jb0RCc2hOdC9BS2k0aFNnb1VrcHdlN2Iv?=
 =?utf-8?B?bVNaN3RPV2IrVGVSMkFQSlBsYUFJdjIrV3dUV3FuNW9ROWtLcjUwaW8xck9L?=
 =?utf-8?B?bGR5ZVlsanVaTVl6aTh0eDNHSVJkV1NxZDBseWxCcDlPNE1sWk5pTmVJa0x5?=
 =?utf-8?B?UlZzODNHM004WTF2dTJwUEtRRklDMXZUVFlNYnRPejFXWTIweW5VeUI0K2dm?=
 =?utf-8?B?aEp3emNEZmVOVlR5bUxvL0wyZ20vNk56RVl1clVCTEJDUlhrTExCSjA4NFN1?=
 =?utf-8?B?a0VTakZHWUxCZlZRS0xUSXA2R3BHeGxrem5qenZWbXg3bTVGZmFMbEFIWWlC?=
 =?utf-8?B?b3E3bUNXbGVleTN6a216Q2VqT2N4U1hPS3k0Q0NQNkNybno4M043ODh6a1Bj?=
 =?utf-8?B?dUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EGv7an0C2claw7OxOwYgw30NZW7x2I4R1j/mBFC0bjWMy7dLUEyJQjRFFqYxpGjj4uxl2l3h5OGnoYqGj8Mrw7EHegtQDnhWPTv957qhxqQyNroOZ7XAO9RLqkXur3E4y2cp3/jl6+ms4v7fCOnKxJlag1RJmqvSvqv1R2lsy+boovywUMWo+06RycewNL+43dbwZuHtDKIxI29jDcrFnfYqCcpLP9kJOSr/XH9AEODd31Nz1y1XLm7YX69DY1Y/y2PCgL3/zkPH3g96nVvZoK5z/hlUlVW5OKRmM81mILX0EklzFA+ZYI+pwrJd+MU8eRfoSMMvWpA3STQgJ/ve38LZUSm2Qt27SbK2bGPnimIlLoQVG1F+qydubIH286t11E1adDtSkUGj3yfX8hd0uRc3c3NHBMKDxNQqIcA7xeG5NVT2a8N6YAAmfI3d6KbHxDMpYSkLhFrQlwLLoUaqfBWNKK/HP8VQYQLaowECRzbn+jGmTWOka95JC2z3lBfSlcBvXyRr73J1/LX5NfxWFv2B4Y3ydbjoV/BRZkcfbqaEsVkGORTp3OPyh2nyI75l9Ncwp+ISps6GKJzRR1f9kWznCrFkF2vJtT336YeWvog=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cccbded0-8d19-432c-4be8-08dd9dfb980b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 15:23:27.0708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 82f88A31JJymionVETVorrNETxE8OqVegQNcwEEqNJQr/XrM7Mff69peb50hUYwTVZSB6bAIGbtbpUTjQzY1Cklc+FPMCXErzbAq2BzhdgU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8400
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-28_07,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 adultscore=0 malwarescore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505280132
X-Proofpoint-ORIG-GUID: R5niJsA3MfZU4ANhnghQgFF8OnLvedHy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDEzMyBTYWx0ZWRfX8BQlxLEU/Z3e F4tAtLQ2hfQ2uxXWYCks/53xqisvFC2XfKTRE00E/WC3I0SlMAs2lZNfaeBszQBPRzrG0P9NuDp 6o8P39d5alBxC+8vwl6uMjC5u95QTv/qit2nL+13kfZjG8YsFF30RGVIJak4hN2Q7uHRXsqxEdS
 SSqBcP+FwccRdpE28f6J1cSxM//xWmQR81uP3/1tGMPGH7WYj7q/abIYBANjvYg0fNm/fTZzXNk OYXd6UqJ2KFBje0Tq1VsnJKjzldF+3/ciQfrTurVWr9AwWmXO39oQ13HrtK9//NAL41UbRr6lod h+2O14bSl2Ular1d0+ZG/hufzv6NGUhAKRLBQsXXYR3KTzZzyDpjBvBnQHjNb/2y/gdFrWtHHU2
 lKK9sN/y7gcvOX6wNRr9kyTXS+g2LZ3EwK73shgWA4xqCXZGS5+PjtcO25jRyKJ+zeKsxhxr
X-Authority-Analysis: v=2.4 cv=UZNRSLSN c=1 sm=1 tr=0 ts=68372a74 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=WTJdmG3rAAAA:8 a=3ExrvcxlBbyKRAA43QcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=q3NGepEMMmKWaCv8Sx90:22
X-Proofpoint-GUID: R5niJsA3MfZU4ANhnghQgFF8OnLvedHy

Sorry this wasn't picked up.

Andrew - one to pick up after merge window? :)

Caleb - I'd ping again after the merge window is over if it's not picked up
this week. This isn't a great time as people tend to be busy sending stuff
over to Linus.

On Wed, May 28, 2025 at 08:16:24AM -0700, Caleb Sander Mateos wrote:
> Hi MM folks,
> Would you mind picking up this patch to remove some old tracepoints?
> Liam has already given it a review.

I am actually curious about reintroducing these at some point, but no harm
removing them for now as they are as you say, unused. If I do work on
reintroducing them I can obviously... reintroduce them :)

>
> Thanks,
> Caleb
>
> On Fri, Apr 11, 2025 at 10:23 AM Liam R. Howlett
> <Liam.Howlett@oracle.com> wrote:
> >
> > * Caleb Sander Mateos <csander@purestorage.com> [250411 12:18]:
> > > The vma_mas_szero and vma_store tracepoints are unused since commit
> > > fbcc3104b843 ("mmap: convert __vma_adjust() to use vma iterator").
> > > Remove them so they are no longer listed as available tracepoints.
> > >
> >
> > Thanks for doing this.
> >
> > Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

LGTM so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> >
> > > Reported-by: Eric Mueller <emueller@purestorage.com>
> > > Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> > > ---
> > >  include/trace/events/mmap.h | 52 -------------------------------------
> > >  1 file changed, 52 deletions(-)
> > >
> > > diff --git a/include/trace/events/mmap.h b/include/trace/events/mmap.h
> > > index f8d61485de16..ee2843a5daef 100644
> > > --- a/include/trace/events/mmap.h
> > > +++ b/include/trace/events/mmap.h
> > > @@ -41,62 +41,10 @@ TRACE_EVENT(vm_unmapped_area,
> > >               __entry->total_vm, __entry->flags, __entry->length,
> > >               __entry->low_limit, __entry->high_limit, __entry->align_mask,
> > >               __entry->align_offset)
> > >  );
> > >
> > > -TRACE_EVENT(vma_mas_szero,
> > > -     TP_PROTO(struct maple_tree *mt, unsigned long start,
> > > -              unsigned long end),
> > > -
> > > -     TP_ARGS(mt, start, end),
> > > -
> > > -     TP_STRUCT__entry(
> > > -                     __field(struct maple_tree *, mt)
> > > -                     __field(unsigned long, start)
> > > -                     __field(unsigned long, end)
> > > -     ),
> > > -
> > > -     TP_fast_assign(
> > > -                     __entry->mt             = mt;
> > > -                     __entry->start          = start;
> > > -                     __entry->end            = end;
> > > -     ),
> > > -
> > > -     TP_printk("mt_mod %p, (NULL), SNULL, %lu, %lu,",
> > > -               __entry->mt,
> > > -               (unsigned long) __entry->start,
> > > -               (unsigned long) __entry->end
> > > -     )
> > > -);
> > > -
> > > -TRACE_EVENT(vma_store,
> > > -     TP_PROTO(struct maple_tree *mt, struct vm_area_struct *vma),
> > > -
> > > -     TP_ARGS(mt, vma),
> > > -
> > > -     TP_STRUCT__entry(
> > > -                     __field(struct maple_tree *, mt)
> > > -                     __field(struct vm_area_struct *, vma)
> > > -                     __field(unsigned long, vm_start)
> > > -                     __field(unsigned long, vm_end)
> > > -     ),
> > > -
> > > -     TP_fast_assign(
> > > -                     __entry->mt             = mt;
> > > -                     __entry->vma            = vma;
> > > -                     __entry->vm_start       = vma->vm_start;
> > > -                     __entry->vm_end         = vma->vm_end - 1;
> > > -     ),
> > > -
> > > -     TP_printk("mt_mod %p, (%p), STORE, %lu, %lu,",
> > > -               __entry->mt, __entry->vma,
> > > -               (unsigned long) __entry->vm_start,
> > > -               (unsigned long) __entry->vm_end
> > > -     )
> > > -);
> > > -
> > > -
> > >  TRACE_EVENT(exit_mmap,
> > >       TP_PROTO(struct mm_struct *mm),
> > >
> > >       TP_ARGS(mm),
> > >
> > > --
> > > 2.45.2
> > >
