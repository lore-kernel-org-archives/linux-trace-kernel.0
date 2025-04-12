Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA08C16BE17;
	Sat, 12 Apr 2025 13:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744463876; cv=fail; b=JbhRrxhR1eEFRuF5yRvWbZJaKUNj2ygYhV5pteWOpV8WyiY5Y6c7gMN3UKdsdW92xnVifOK7OL+1eazYnUrPCF+E2m0IGXC9cxb4KyVuCQZ/4y2l+Fvbkdbp7LBvMfxcDme0J0T+57fe/zrBb3H9UKJycIYjfwICIW3QDynag6g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744463876; c=relaxed/simple;
	bh=qFNHepz3K6mkkbUcujuZrHKNDyxwm9yTsiqR6ucoUyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qbmfxu2PVncMpNsg6+A8Po73QSDfMy309jv2Tv16v09oKPWL2nt4tyLwL6zdRYMLKOiP/RWuFQXjZ8HU5/uS3Wv/DqdQEcDAxxwkCeh0APfl2ldOhWE6ZX6OhRoMskWCclF+4lwjloyjRIJCOarNb+nbnHnsdPaEd2JIYZpFx/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AZo5idV/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xFKa/ehH; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AZo5idV/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xFKa/ehH"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53CBnsBL005870;
	Sat, 12 Apr 2025 13:17:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=zv7I7at6sMI8YbgN/e
	3KKqyr4dFMr7YUM1Wl7VlytqM=; b=AZo5idV/wyCBfZ5rLjgToDHIwKNOqmpIUc
	UZE5oO4/cN+II1pXnZBy4/Lo0hnxt+dhObI9Pudvp1vKzhwoCIQfloVxIQjQA1Ev
	jPTJAyS5S+StEq8ZE5eM4uQt9eACKQovNs7nFZR8InYZ3DCxIe3OhOh6PD0YLYvy
	sT96etdbXVLB2ik5t1feqkN6EguWuf+qNwa2Lh6dqNaP5D+oeh6F3WOYFggUhcyc
	Y7kGiR/hsj2HYKPbAuRG9qtoTOzxPZdtsGUxaD4dh45ber1176N+FKnISyLX0X/g
	TkRBBzMlKqMul4RoLNUyBpyOuynAhMLUOyzUUyFPS7At3V+rOLvA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45yqkq01h0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 12 Apr 2025 13:17:29 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53CC24Bv032145;
	Sat, 12 Apr 2025 13:17:29 GMT
Received: from cy4pr02cu008.outbound.protection.outlook.com (mail-westcentralusazlp17011028.outbound.protection.outlook.com [40.93.6.28])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45yem6c72r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 12 Apr 2025 13:17:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JeqnZ5BdXGnC4WUta0jSvfrhA7U96SB6le7r+q9EqDa8qXCPWQOtsdTofiHsS8N0pvgHrhb5q7doQNkOYzLb0pCk5GKyewMxSf4mOD+MPL8QzKEKWtvisTC4bgRuQkCQ42IxxBH2t9fIBjj228efky1qxZdL+Zc10j7rkKW0kcBbz0+EsfJmN9HWW8JEmnXDyp4/zj6vonSyf5jMf+/Im8Ip/n7xVtnfzcGeie/dR0YEK+vcdlJFDZpWAcHLmfeeuAyqVvcb/RHejsSjUfv6ORcF1C/m0X21nvCG+OOcwR6FplCCwvcukW+7xLP4iEG2f8drzXcsbL0pY2qGm9leWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zv7I7at6sMI8YbgN/e3KKqyr4dFMr7YUM1Wl7VlytqM=;
 b=Lr3ec0JgQqtmmI7jiL678zrbD/H2a973oSxGzAR5wkwKBcC70iw3977BVCYnplTNBvdcFARyjU3Pw1vTrXMQU1EBRhXLQGKNG3n5DB5v0ORvMTHY2h5gEAykCz6hZCtRWUbQMY9NWjGcRjqSfP6NuvuFQFKNNOP6XOXJHYkzAzM92e0dBf4tEOyCp4JklVxwaQ+rjV4IjtypseaIMQhlF1mTpdRtXJo6cAkB5iVwIlJL6//0DOaK8tnLoIE4w56coxsEisgGIg6pumzCLWsBnYV7BkAdVrUb9gPL0m5tQaGfK8N7ZhaHT8JywnZi9qZQ+g6AkB9jrLVH5PHjgpLY9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zv7I7at6sMI8YbgN/e3KKqyr4dFMr7YUM1Wl7VlytqM=;
 b=xFKa/ehHEiIlltU2u2TR5nGBvS//mLyjj+EFeoDx1FufHmoGmUz4qubn32+2MA6Q8+xgvu+tXtw/LCK8q0gyJtJXHOsLfeem7VGxsDfVEliF+cjsLHaXxxI4/R77nAcdwnf0Y0MsFscRoWL/noOBM2ThECEoD6B7chbtBi5zt4I=
Received: from MW5PR10MB5764.namprd10.prod.outlook.com (2603:10b6:303:190::15)
 by PH7PR10MB6554.namprd10.prod.outlook.com (2603:10b6:510:205::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.28; Sat, 12 Apr
 2025 13:17:24 +0000
Received: from MW5PR10MB5764.namprd10.prod.outlook.com
 ([fe80::8d9b:9200:a7f5:19a9]) by MW5PR10MB5764.namprd10.prod.outlook.com
 ([fe80::8d9b:9200:a7f5:19a9%6]) with mapi id 15.20.8606.033; Sat, 12 Apr 2025
 13:17:24 +0000
Date: Sat, 12 Apr 2025 09:17:21 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>
Subject: Re: [PATCH] MAINTAINERS: Add mmap trace events to MEMORY MAPPING
Message-ID: <mcz3dhxkjpgp2qv72dx2lttwnzdvujvnosdx5a7lkjpuj3r4iu@jevlyctotoay>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	SeongJae Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>
References: <20250411173328.8172-1-Liam.Howlett@oracle.com>
 <20250411174734.51719-1-sj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250411174734.51719-1-sj@kernel.org>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4P288CA0048.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d3::25) To MW5PR10MB5764.namprd10.prod.outlook.com
 (2603:10b6:303:190::15)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR10MB5764:EE_|PH7PR10MB6554:EE_
X-MS-Office365-Filtering-Correlation-Id: 824aebf7-e970-4662-c05c-08dd79c45d67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007|27256017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?B1kQ6eoOGf5Q7AcCLGUOY+d4o+e2lkb9Vkv0YsxeznuV4d9ajHW3nt0BrlRi?=
 =?us-ascii?Q?P3VABDo0Ytb282r/a3GroRWjc6Opgx5iUCsMFhlonJpMTiI/DRkJnAEQnXAj?=
 =?us-ascii?Q?IrHUNJziIdbLfqvc3C27myz4vZpvlkeMnR9/+QirO590eIGI1QFdagrZyk2A?=
 =?us-ascii?Q?nkStKoz23DB8NA0S3FNNv1zHWNVolRHr+N5ZXeIV4+lnK1uUTKMJ3lbXep5D?=
 =?us-ascii?Q?hhsUZwzjBd1Nl0ECmU48uQCQ7HSjVrd+qYBsvFd4JLaal2fJQjQgUNRwaA2J?=
 =?us-ascii?Q?SbIHO/UKn20ExYlddgJy+xiPvhqIzKcvQimMf8rlLtzoyX4NrU9xfdc4lYNV?=
 =?us-ascii?Q?E4AgX3UMfmEkC+2iWNgKf8REiDcRN6GuvTXbHW/axVDTuHBMvl0MG/+Qnapu?=
 =?us-ascii?Q?D/4fT9S72bzltDQCDZHwlJO7CLlIUdjotbbd8zCvZcG43PWll6bGZaLVSH1e?=
 =?us-ascii?Q?f52cDUKCNZCM9rFRp442d/JnFRcF0ttwxe9UjfevtTEh/ffSFYpuKcEQM5ZN?=
 =?us-ascii?Q?MuS6nM5f4NsD3Nz0gdVOcsDtxkMGPJeGSAw4ojXDPw6K/vQcnZuH3jZq/ffL?=
 =?us-ascii?Q?qek62ShnfA0BTDyIIrTWgPLSeds/9+TEUdpUNlg3fvqVMDB7NfQrFFc6p0LG?=
 =?us-ascii?Q?CLEnMwKV4znPAo4CFdct3PgvOb/d/ZG9l7CjRGpFfePSTm3qTnvVSy13rqyn?=
 =?us-ascii?Q?2U2oJFma0EuMIobz0fWvWaABosxlQYY6hnzFUcU9n7RWQvp5y+xPv6INDgrG?=
 =?us-ascii?Q?3TroOv2P5zrTyBfYN/btjHyiVf0/GzcC2XeD0rDIbp49Me9sFheVoEC5RXos?=
 =?us-ascii?Q?6vyLSBy5Dm7hC+7ETxqFev78l1f1AuywdjyLyNYMu2e7gVi1H2LIfcRmM6nj?=
 =?us-ascii?Q?MYV9BCuCoRCEQC/JpoNy1bwHR6P7H7HQFEB2hgCwuqpiQ7h/Vj8F+vrRRy8w?=
 =?us-ascii?Q?Q79BNQts5DAXZT97TRvkA8fpoKiV3QFwj1+hAeWTBviFl6ZIv3QihOlYCilU?=
 =?us-ascii?Q?4B5AQAngslpuJrbg0ukcImsjgXBhC8w9bTTTVoU6iZ9qXoYdM65NzIW4Ml4X?=
 =?us-ascii?Q?ly6BLZ6TlHvS0+TdVf5/BHWpqN59rLaPIPIik+GRnHvPM0YUy/I2Rynhrpmt?=
 =?us-ascii?Q?Uxwp5LWDH/AQCuU4kmEfiV7atd2X2zbo2Sd0HXPiX1GEJRsjqk//Ri7a/HXV?=
 =?us-ascii?Q?Y69sEDHaQ8jPXTXcJnEHogp1psZZHGBOe9IHbUjDnKMbBF2ltwm8NjAcN6qu?=
 =?us-ascii?Q?Gs8tt9NnhaNWDfzNaXxumSfrXnUgUHnMVzxLDbKx2gf/CUcE0RfTYL30PaCW?=
 =?us-ascii?Q?p/oJymFenWCZCVP7QGkjrpU5oCr9BzkSMdawMAZfvPnviIPm2Ci2pfoPZzuW?=
 =?us-ascii?Q?EHUe8fqfaO9l6JuvtuKgPcQdKgcFENQsVWOj/sfa2jjBp43sPQ3jvTUbfkPz?=
 =?us-ascii?Q?71GgFZaXpmg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5764.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007)(27256017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hETbU/pB1uPtlcp3cCBivIm17zm2d3DPQfZchp9DxSMrZ/Uu9mvouoqGtEEt?=
 =?us-ascii?Q?Y5/nJa5+rRLUBHWwFMILuCKd67Jdp/MVUo6i9skjgZbmJWLmNXQGnUlHnU7x?=
 =?us-ascii?Q?ZbD9Gn7M34LajBfRS79eFom1XI2nQl59B2KWTfvBjWcpxie9DSXAvElKweLd?=
 =?us-ascii?Q?pSBrXQfsDv14lQfGXOfk2hd69fTumO3rI3WoPWTnktQes9kYwO/BTL23PD4s?=
 =?us-ascii?Q?ZE+rnXzQmZJArKzY1aFQBhZUHYE+OCqnTDSEy5kZk+btwEcFJF4E545EJ1Eq?=
 =?us-ascii?Q?cOpEYjgdEoGtq8iDggMNB20qRMLhRO/QWP6EPI6Ph6Ej1ZAPX7z5Uio8F7tt?=
 =?us-ascii?Q?rAH6aiAWPPVyrlHPKR/ZKLcib0AnH+d1ikZTKogxgFhfSddkb25COiSt4Air?=
 =?us-ascii?Q?0i+ySYR9V6ERccX+/gWj8DR2m07eY+XtP/P1QngNxoC/1u/7/1pUgEApv79T?=
 =?us-ascii?Q?QMVuRevdMJa2tPcZpEmJCGULfz61tCDI4loNYQWH/7Hb934GuYGFb3bRe20D?=
 =?us-ascii?Q?nhpRtCOmbTOhmYHXFN4e/jmSWlu3htAI4ANtHv0XkPM/PUrHZyTNbGHb7dsh?=
 =?us-ascii?Q?o9iKK42ZPqlKkIg+cd00e69jxTGNHxavGux4Hp/Wqwb/Vk5Tw7U9wttHQ6q2?=
 =?us-ascii?Q?JtjYs9sBrcqjvvn8TlsPCaCZUp/4gMYZ7vnxQfXi/nn4YPVrXwsZG1tZO7In?=
 =?us-ascii?Q?s8zgmgZByBlAxIOleLll/w6gMG0cMXksRkmjevsF59IcykidAk31XgA42syT?=
 =?us-ascii?Q?WfOr1WsSc0v+0oYhmB3Wx/vFbdnF2TADQNiwSMM/UvqMLlKOlh994vBirgA9?=
 =?us-ascii?Q?HvXStb4sX6+nxV4l1ltmzmeihzjM2hxMXMXNhY/gtPtWaFh1exIy2p5d97+e?=
 =?us-ascii?Q?brqd3NSr5HyjlBC7UfezHVSqSYViCRgMHqDTcW/LXb/+MzU+/+Rpw+z+4w7A?=
 =?us-ascii?Q?cmxHJT3J9PFBmsdqKcAtwjvaxp+RCuhkpuYSxyYSV6ZRa6SWVey5HQoAUCVi?=
 =?us-ascii?Q?JHnQjKdUVckfsWzYkgHIeV+rrhPe1svP0ccoyGwO1aG+rV3/a/oT/E+BnolX?=
 =?us-ascii?Q?YrJFX1cfPzKZY0d6I3zI2Ra8EmwpsFNeBG9WpEY1Qz+fWVAJJJoyVedq4j4Y?=
 =?us-ascii?Q?dMDK1IhZhO3FY6E/tAO+LXVnwPrJPQ9HUKOUrNHRauGCxJXhaIliGpCHRdxI?=
 =?us-ascii?Q?Cs3aTm/kCeBk7qReUTW7K5AliBYIGRjQACY+HbVYHJwrjJuLWiGqw9Fwj2Y4?=
 =?us-ascii?Q?b6UyFyujZr2FqEgA+H07ioMV/kUSQ1T6MEF+V3tb/zSgwrcnNoSvf6Z0bBO6?=
 =?us-ascii?Q?eUCvNunUx3PpiUEmiSbiJdgb0EA+GmooMfwRmwziXfrL+GJmZQN65C4CH4pr?=
 =?us-ascii?Q?MvSuqqDnzoMCo5H4aaGnRS7RPi9S8SacQKMOcZ00TUYL8MDOw7c8VEUOZb1h?=
 =?us-ascii?Q?k3THTUuoNNwPjP5bvUjnCcDqL4JKFWoeWiSHy3yfu0qc3qwJwdNudRRg3BXQ?=
 =?us-ascii?Q?131K3izbOjFIlTF/Z4yjDSE2FcPxK2T9DtSYcVpUI7sFrzDtIV7fTiYvlFNo?=
 =?us-ascii?Q?g9FHs4nuFVslinwkro5oB7Z1i2fGWnXmimZbR2R7?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SoUGC5iGGJBsp8PfMlE+4asjkBsUo/uxF1SB31i7/vqfjvkhLG+MM2dcgzncEfamHPZToT/8TM2gafgXu000W/TeifYNoTt2+Gfp2l7zA6XUbhxIKcI9ot03tIiTf+uV8S3VaIgwz2eSn7TJ4F4/ldtNMTFQY4ymrDcfrTdmlzDlp6HjzKLCkM+n31j1JU/1Z7qRgvkHIg8Sa8FNN8X0XWPKIMIAxawVGMD0/FbietIQPvRAv8XGsDYSaQhTt6DkllAp8FFWNiYRBMoKb1D6qqzGIQV2xOq3QUplgzyxVlOd2UnElPrhr4cWvNPuLNdzrIw9CLjzkG+Ps6PZF5HIQfptCak0hroktA5K/GrYqkCH4v1teNcd1+6kNPjVnoPpVND3dVjQYfNnSvDoHuzGAH4D0jm+/+UXrCEVXfK6rao5iSxH+aNEzlwMm0c6lQIIZoqQzcHKIhfQ9pFC4HyuoONrIMKkpDu1vnKHpQaSPlftnYKcnq2q9rl2NAgHU0OUMOrrRmEPQ02A+rw+GZzbvRARqaD6HbLIr1EmlNbk9qH6jblUmg2nrwc2biuS9/zATNuJEf0HMOH+YJxq/THGRpMIQxNPvJSO39sJbZ6mIDA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 824aebf7-e970-4662-c05c-08dd79c45d67
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5764.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2025 13:17:24.5852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NbI2hYuqn/AwJjdt5E/NZIfIiUGT2oJqBQ8hlG/hrVCNj9ouCc5AI59sa2Z0V85O3P1kAv6ZzcgwR4bOVxyILQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6554
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-12_06,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504120100
X-Proofpoint-ORIG-GUID: zlPT5AGAGqcmUlVaidJnbn0kQ6G-6X4S
X-Proofpoint-GUID: zlPT5AGAGqcmUlVaidJnbn0kQ6G-6X4S

* SeongJae Park <sj@kernel.org> [250411 13:47]:
> On Fri, 11 Apr 2025 13:33:28 -0400 "Liam R. Howlett" <Liam.Howlett@oracle.com> wrote:
> 
> > MEMORY MAPPING does not list the mmap.h trace point file, but does list
> > the mmap.c file.  Couple the trace points with the users and authors of
> > the trace points for notifications of updates.
> > 
> > Cc:Andrew Morton <akpm@linux-foundation.org>
> > Cc:Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > Cc:Vlastimil Babka <vbabka@suse.cz>
> > Cc:Jann Horn <jannh@google.com>
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> 
> Aced-by: SeongJae Park <sj@kernel.org>
> 
> > ---
> >  MAINTAINERS | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 4c7fdc41a6bfb..d8e9a10adc81d 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -15571,6 +15571,7 @@ L:	linux-mm@kvack.org
> >  S:	Maintained
> >  W:	http://www.linux-mm.org
> >  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> > +F:	include/trace/events/mmap.h
> 
> Should mmap_lock.h also be added here?

Oh, well..

mmap_lock.h (include/trace/events/mmap_lock.h) has to do with
mm/mmap_lock.c, which also isn't listed here.  Both exist for tracing as
well.

There is also include/linux/mmap_lock.h, which is the locking itself.
The mmap lock is used more broadly than just these files: mm/pagewalk.c
and mm/ksm.c, for instance.

So I guess that's a more difficult decision.

Thanks for bringing this up,
Liam
