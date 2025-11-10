Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1250B30DD00;
	Mon, 10 Nov 2025 12:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762776114; cv=fail; b=Cu2N54JH4LQ5bcVTmBzzPwFS7F/tj9/szqMohhmuQbkZTZwsMnUt0iH2bed6Z2gZ5XufUbqaU/aSvUUFx+DYcg+D3U++nAPCufwgcbi+GFwtZkgherfndMqvaICO0mnk4zAvwYCl3EP1Er2a1GAHRLpmt+VOyTByeNVzVGbEQ/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762776114; c=relaxed/simple;
	bh=AYc5HVt/4k2c+OjXWIB7ASMN1f1hxQDhuYI6w3BMVkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LIVe5+vJ+qeuM/DK2ZD3n9yYx4bn16Z4nQQ8/LOr/i2S9r2ki/haQERWjiEFtbwdMyKUFpRvrn4nQ6xsLNzCeVm3iXnUGZinLyBFBMGBfWf2/JUoQ9nTqfI5sC1sByYu9RZZRfncfn0loBn1+fsg4piyQldea4bj7srBE52OOpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OgUC/N03; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=k8viKoDE; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OgUC/N03";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="k8viKoDE"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AAC0XGC018499;
	Mon, 10 Nov 2025 12:00:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=sVbD8ZWAUxUQVXYhET
	5nKysvQnuk3tm+SFRkWlw4aVo=; b=OgUC/N0335WvzGxt5Nz4XtwwPXLRiOs7nD
	R2M1gZkX4ULyFO+IlThpInCb3MyZny7laj1xMC5SHfpKrpzAGQB8GiAx/4MP12jF
	CWOWnDsliKumlWQWG3oUUUlpW++VknYyEp0av2CHT0TZwlMAXTB+bdjWaA7/LugB
	cDnbchoSFvYSxQtEY0TnY0fh+asQILYvp3s4G+xuoK+c9smK1UMoVBSPbifDWoEg
	UctEvdrIWewc8u8sHXftv/JlSVJfDO0sEC1VLNDzzA/It2/1eXc3wOKBvlxcSRO8
	dfmDJAQr/nzxQ34AEB7JZbcuEx6CePf8pPSFrda6kCIDAvadJ5zA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4abfhar0d0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 12:00:34 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AABE51d039926;
	Mon, 10 Nov 2025 11:56:24 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010040.outbound.protection.outlook.com [52.101.61.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9va828k2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 11:56:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jxhqj5rkA22JrsIlJmO4LYKkLKf0NAXN7stBj8OvfaZwQgeLA7n1VnPSa09RxF6T7k4wdV9HnB8b1prDOl9p8FcZ8vC1p99wBLPCSX1brzm/WIKvdxgIV14z4JJ0SsjATdshRYob4YNmSy2JhJVaiMRfvsUWzHFbzE5fC0iB6G2yp8Q6YWoNAK++VNOQS/5SEEuBgJJk5v8PcbxHzfexG9sS3P2aY6LZ/Ig6A/CiJyhCplpRnzrlCzmB55g8dXsq7KijNEM9ypdSbxpDafMmdX3jm6MSohwjcWJsTk++5exDVL7wtpFykQ+DvtzNro0loAGR2LOW35+2M1UnTl88cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sVbD8ZWAUxUQVXYhET5nKysvQnuk3tm+SFRkWlw4aVo=;
 b=OKOAdxDNI7veauP/VZcp++ok436Hy9xOyqnLB3lWOp2lDjuuS3muJcmQUPbqd4r5AEh4R+J5r5/+ieVZrMM3kPmX5i0tU6V2AO4KQFD+Ud5ZZZA3j80alHrJKX3pJydliGjseQbXrtMGifHgHooR/Bl1Y0nPvRvscgtyZKqUPQPHnCdvM/O8gPBQmCUCn8lhF93NaztOPka4FYNrWz/oxQPyO0imvfFgkWJkiNAMjtREcZqrfTYJ6Rbjj+x/AN8BtaCPI2YF3yRVMLa6MoSaAJ9rD/DKEmJx9PhGED4PlrTHCVccX4ngX8MieB9WiEuJPoa4Cv9RoiYyTTSIl+MBSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sVbD8ZWAUxUQVXYhET5nKysvQnuk3tm+SFRkWlw4aVo=;
 b=k8viKoDE1t9lyneqqylKOMlouYBMmcpqKP0MZB2mQvUEMSQA1JLwjoG9sAjqGtfaFRyKg1ZcfEL8o5XQE2+jqv8x/CgJVS3JOHLDtjLia9nEIQiy9SA8odeiVTp/7EHm7h8faDNp55Sg1r2oBWneB+M0GKMVndSH6a4qwxd5VmQ=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH0PR10MB5580.namprd10.prod.outlook.com (2603:10b6:510:ff::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 11:56:20 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9298.010; Mon, 10 Nov 2025
 11:56:20 +0000
Date: Mon, 10 Nov 2025 11:56:18 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Shivank Garg <shivankg@amd.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, Zi Yan <ziy@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Zach O'Keefe <zokeefe@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm/khugepaged: return EAGAIN for transient dirty
 pages in MADV_COLLAPSE
Message-ID: <67325651-b7d5-40d0-a9f1-3009b61c8d3a@lucifer.local>
References: <20251110113254.77822-1-shivankg@amd.com>
 <20251110113254.77822-3-shivankg@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110113254.77822-3-shivankg@amd.com>
X-ClientProxiedBy: LO4P265CA0097.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bc::16) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH0PR10MB5580:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e67a57e-7836-42d3-0d75-08de205029e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1nr7kbnwp1Gw6v8yUDUUuEU5UJY0PbqevxaUleq7fvrcDqR/HTYthQFOGdSQ?=
 =?us-ascii?Q?xhAR0zGIwoX4qM82E8HYoqSkfYtq4t941f9YTYuJsOZxUw6H+2S7lmUvD70N?=
 =?us-ascii?Q?/KlELtibQX0RahFUR7xnaqaBe+ZbbG0lAa0qD4CjwYTL54fMEkt+uzSxFDmk?=
 =?us-ascii?Q?wBSZxsQwW2xGn9yQgZuuZxqorFZtaGYjPAZciEOrfUcTmvj7MB2FnqEG6WjX?=
 =?us-ascii?Q?tlIqgPYf3X3CWCV2bNC+6petCUzlPiDGYFxY3bS1CiCSc+n0APTIV3iKREhe?=
 =?us-ascii?Q?V2o5Fvm8PNIlT191qlwYSZ9wzrbIy4aC0CVuQEa0iQdcoLkv7H9U+t89Y/uQ?=
 =?us-ascii?Q?nxmfCHV2JUu50l5rOTUT4XxbQ4AM9DnaVK0XEfP9wgPxDRFGlmpLOFdN1vZu?=
 =?us-ascii?Q?o2udZiX6sP+eIQEZoESLhJaMGPT0anB8Hi4+qrw8kk6Z9UkXyXAEZGezdSH+?=
 =?us-ascii?Q?3Eos7dxdU5dXcOl1Ze7znT/HA9IjrzuEZclja1YDOT5sh12Pj6zLoHkFK7/W?=
 =?us-ascii?Q?3a3u8RARbUYoDTR6xfRjvc3aUQeyn0QUtjmn0mbJ6fKdWEiIwL3rsfXi518i?=
 =?us-ascii?Q?hNtUpAJemUxjr7qlgvEs/TuMjcF/WasMuEe+l1aSDcuYUbAEbp0VOxWi1bG8?=
 =?us-ascii?Q?ZRT1kL/3i4nlhD+DxuASLDfV9foS9W24hI4WI/zFx9dItl6UwdSfuhKHiFj1?=
 =?us-ascii?Q?s40wQ5EcZ3cZISmA/JJFnWTPNw2QS1OoWVot0Beu22Yi5l76Vb6FPqCtYmb0?=
 =?us-ascii?Q?YcgeZAswA/4+caSIHteR0h2xNmbp8R7Xw+Ryk6U+rOVMP0jB9d4EG2T8cM1T?=
 =?us-ascii?Q?faG5GGfQXn3vRcqLENMmjDaFp6yobowfk7Efjsd6Dr1fQKKRqr8oNh7Q8LOS?=
 =?us-ascii?Q?EmV3mBFJ4GnjZUK8+ehoFUHyTrdOIRaJ7O2FtZWd4duss9YRgDuTVJ3zEkJ5?=
 =?us-ascii?Q?HfBja8RnOG6/ikFVHPAwFzn3qcbgQ2PGegU7IZ7uh9mNA+ozm3AMSrBvJ6bZ?=
 =?us-ascii?Q?rn5Swq331UiwvgTPam5SogBkAR62q2pKQrr2qFSxrO4D8gooV2AroMrIJLTI?=
 =?us-ascii?Q?DhAGWJt6zdtei5uFeMVISSfkbd7k9eL9lQNHtY4oDwNUShXThjt5bBPkLEzC?=
 =?us-ascii?Q?84qGB9y/zMxNwuxzYBI3QmKt522FU2m+ryTcEwPkXNqxgqhIAxNmuoh3Ecqt?=
 =?us-ascii?Q?jJXuWJOL1hcuLvUXw8QNnuhSQFPlgkbtQpeSSsLTga9ZJ17q/Zpd9bMomOIz?=
 =?us-ascii?Q?Om4AsfyhHaLlSH5SjEgsrPqA/8Yi+LEFfjCj/9FWua5UTQpqqH6F78eolzYi?=
 =?us-ascii?Q?+MUF9FakA5MlOL4aZj2H+5XaJLa/pmbCVYxi6aDX9CF9bpO7NuCpQ16hQGxV?=
 =?us-ascii?Q?CYWqxHCzCyPFqMF1A+iYpyTXttsghJ8GiTz17w2SYAQXkOeuyy0rHOZGiRzc?=
 =?us-ascii?Q?02VnCCV77eTzPvf22WsOFlaW0WpYH3rd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iFfBw5CRR9mms2/Q/cRVhS45BwWHDAqms5rGImRMBcvVE22Y8CMv2vsFDQwf?=
 =?us-ascii?Q?svSjRItkHL9sBt0Sol25IhKwJEdQydG0OPdwX1WNMuMetGzJaToINKv+4ipP?=
 =?us-ascii?Q?QTULPFWxbR6xR34bBG/oiljeAoxfXAv6Dua9AlDBymWh85+B6wVbfTMFn3xX?=
 =?us-ascii?Q?z2IKonNMenFjX64S08aYayi2oJ7WpyHU7bGS+MOSHDC92yyHoB7kcVS+kB/w?=
 =?us-ascii?Q?FG9nP+VhJI/MPkjkbKL5ET8zLCJH2BAc6xZM7Sn/yR71IOmihxgRHa33BXKt?=
 =?us-ascii?Q?MwonCoGYavhDYzKUbvNaEjQuEaxatgeUW9/CngWw5TQWvXCL2xvLqiO1PT+a?=
 =?us-ascii?Q?c6ZeucjJE2iBk7kRguF165t5lMKsrPaBnC55iRuVjZbtb5X+YTIMb9ZxM4Qe?=
 =?us-ascii?Q?H1zXqhzWUaSbhlnL5CyOqsv/z+zwDWx2fJi/IJ+IMaEBDfO+/xPqnm4l77D1?=
 =?us-ascii?Q?0YB5Psnx2CTTx6bqdbUS/540iNdRzRme2ttkzLkTZSJ9gVLkkXG8+HPNfPod?=
 =?us-ascii?Q?iXY3qG4eijrZCJlmolLRO2s4vVBVbfCXDmM2S/HYzOU84dCTJM7t2owIjbfO?=
 =?us-ascii?Q?HaNzeo8exvGRGiHGNh94cgPjKEwsPlgMjbLa3MNlhgrdglNaPHhElOiu5UrS?=
 =?us-ascii?Q?ieTwajhQXGpwc7lwa/Y/03p4FjEBsh2+z7X+6U0Hi+3XnBWWNZ5VjRZJKJUv?=
 =?us-ascii?Q?nnIlm55H01h980uiqk5H7H0Wdo2eyvzJL+Ra7Ef2fqvLGWgPVSblwiJ2L3ia?=
 =?us-ascii?Q?MeTnyabXH6TFDvxfxZlFiNJpYcit/gUgrCM9GRl6bmBS9eW4vXKxnRoSPOMH?=
 =?us-ascii?Q?uXtS0/rzBvYzE3vFcmRv1NGWVfgg1cw6TpfET9O+AMnEyT4vJTWqVzaL5Wk5?=
 =?us-ascii?Q?VvboeXUuVsITvEBQx5YMcXP8pDIydAgFTRgbiP5IveCLZJ7l2Sn/0o0larv0?=
 =?us-ascii?Q?xfosvz7+AGXJkoNE+uk/Qm/XnF10RKFCEfAV39BXBZN7lQBtceYEnvWFPK1/?=
 =?us-ascii?Q?bNfTRq7yqTvl6WwVyzc5Me1U9NWfQHN543YPv3hgkzysT4e/+qsfWRqGb/d0?=
 =?us-ascii?Q?BVzta/okNU15qe5mZKLARglr1VttimFZQX+UuP7J3egBnMob7zdRDdTCLaIN?=
 =?us-ascii?Q?gfnBcRxI6bWB7F/OnIVRSOTv0D6YxcUSUrxNNaHEjK2o5Jpxia0FUfsmCiCB?=
 =?us-ascii?Q?Y62tExpRJgllVVJgr15G1OW5VK6UrakpOd7pZgJ9HgRFbzEFZxXLSCQg7ENn?=
 =?us-ascii?Q?Ls/YlH93idPY7ASdxiVRpLSZ5UfnsCf+GPhD/sgSzLp695rQjTimC/fr/AVR?=
 =?us-ascii?Q?UxKFa0L8JtoxdKO3VyRG4gPsXF7aPmuKr1dNOmZ5W4tSLjY0ep8+gmay0MkH?=
 =?us-ascii?Q?9fVY84Ct2Z07QR/MWOSGiFkDuuWIJWNcuAZBhqy9C4zpj7ImevPKc1zYma0T?=
 =?us-ascii?Q?DU5OHOscRhOBgH0iAAqpgMpRr6AHNeV/Bz3Fs9OqqQgxjuARlsE3/+7d1xI6?=
 =?us-ascii?Q?ilxB8VOGJnwJsCA4Q0bs7RB7K//pYfeEA5Xks1JU9MYZ8K1NTHOws51rEYZc?=
 =?us-ascii?Q?BwO0nRSrbH8w6KLFdffkGh4KggIvB3GDQXYnggFdVeF7ATWIbzFbJAgvTpmg?=
 =?us-ascii?Q?tA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	neb8Xxa9aevsmdLH/8awJ+pr5Q7ZJO68zEu/+V9EgGZqSeGSmCppzJKextNH3l9rn3+RrfObN2e6eisLY5VcJS+nQZCQDYBB9WcONm6DFS0jIxsDoltLssw2aDQnGTnVxRG+mM2uYXWHNr15ilLPJCuRTrvEiHZ1dwaqYkeIxhw87adwpjgGNh5lLOn+qYF82zLmvbJGXHlID9oHo+VDvTHV0LYQ6/fiAA5FLw5Q7PtSVZhcAngU9LilLU2Srm1XwnU3pmG/OK9Sxp4Q7GUpJBpHZc1Sp0upKCeUZjoPoA6RR2MmLSO0SX0s6ZqRBipT4Q42rdBiPxRON44EPlMezGvqCHck8oZYQMg3eM/hmmRWh83tqJVXkJjcc26oNlzNy3RjgadxOn/Psy/0GjlCB3LTgQCkKEvyfUvqy+etsnVggp/PFMO06tR9H9oIhRDbQFl/hhMElf7YGuCe1eazUbgONIMw2iJusPgG1pZxr3SJU0XxTWPoWc338VXkICf2xB478/epFfHkpX2iPRcRA/kgt8NzMgrsqfBA8Ts5rsNSVjoDw5L1ZoggnehCjOb37dFEs/3khr2c6xMWqnOedc/ZON5vo4/I9I78ZJoK3iU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e67a57e-7836-42d3-0d75-08de205029e5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 11:56:20.6642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Q9CObM+3XD3T+6ZeeAjIg37gIQgfKvP68yLOHZ4xP/OYq6tGe9N/0PUWHGyO65mlwvZIS0CdNHEzgxnaQdtWxBFQgu2shKcKHQwwSBshCU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5580
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_04,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511100104
X-Authority-Analysis: v=2.4 cv=D7NK6/Rj c=1 sm=1 tr=0 ts=6911d3e3 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=zd2uoN0lAAAA:8 a=yPCof4ZbAAAA:8 a=LuiKAxX6E6kQ6AVJsBQA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDEwMyBTYWx0ZWRfXzObb6EWItIA5
 lo/U1Q63MGx/q+kUJxTEsz/wAbWQ+cAkrJm/HqJDL53dhMv/7qnytNkADJ7eF6t570tDRDcJ3xL
 hTCbhx2GJeE86R5DHKeazeLaLEharPtpgqXidJtSDxIj3prZfmKCvek4wABaWfr+Pol/yKEcmoy
 UwV4zUYGRO8WJ3EoqddTbw20sE5QkY3X5PApbEIjBatnvRkbs7inQkH4uyO2NSaAZBgGZZueyN8
 XkHHLTgcleTYL+gPnI3YPa0j+Pzh6rxjTpTR8rCjWHZLsh0cJqVmB3V9D//r48PNNPBmSklwCNI
 A5e4RflobqGisaU49sGp3fPZa0xORi/oQ7y0yAC8ccN0UZAb5XZMU4qX/h2PMpnYvnmar3wQ5+a
 WP8GwbiujK/DVt8G0qwEVFw9UvAXyw==
X-Proofpoint-ORIG-GUID: 5bYfI_xYg1rPTTjKhCMlx_iSMlKDN98n
X-Proofpoint-GUID: 5bYfI_xYg1rPTTjKhCMlx_iSMlKDN98n

Please, please, please send a cover letter when there's > 1 patch :)

This 2/2 replying to 1/2 is a pain (not your fault that perhaps you're not aware
of typical mm series style but FYI :P)

Also there is some tiny conflict on khugepaged.c in mm-new, but it's literally 1
#include so probably nothing to worry about.


On Mon, Nov 10, 2025 at 11:32:55AM +0000, Shivank Garg wrote:
> When MADV_COLLAPSE encounters dirty file-backed pages, it currently
> returns -EINVAL, this is misleading as EINVAL suggests invalid arguments,
> whereas dirty pages are a transient condition that may resolve on retry.
>
> Introduce SCAN_PAGE_DIRTY and map it to -EAGAIN. For khugepaged, this
> is harmless as it will revisit the range after async writeback completes.
>
> Signed-off-by: Shivank Garg <shivankg@amd.com>

With comments below addressed, LGTM so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  include/trace/events/huge_memory.h | 3 ++-
>  mm/khugepaged.c                    | 4 +++-
>  2 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/include/trace/events/huge_memory.h b/include/trace/events/huge_memory.h
> index dd94d14a2427..9014a9bbe64c 100644
> --- a/include/trace/events/huge_memory.h
> +++ b/include/trace/events/huge_memory.h
> @@ -38,7 +38,8 @@
>  	EM( SCAN_PAGE_HAS_PRIVATE,	"page_has_private")		\
>  	EM( SCAN_STORE_FAILED,		"store_failed")			\
>  	EM( SCAN_COPY_MC,		"copy_poisoned_page")		\
> -	EMe(SCAN_PAGE_FILLED,		"page_filled")
> +	EM(SCAN_PAGE_FILLED,		"page_filled")			\
> +	EMe(SCAN_PAGE_DIRTY,		"page_dirty")
>
>  #undef EM
>  #undef EMe
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index d08ed6eb9ce1..7df329c9c87d 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -60,6 +60,7 @@ enum scan_result {
>  	SCAN_STORE_FAILED,
>  	SCAN_COPY_MC,
>  	SCAN_PAGE_FILLED,
> +	SCAN_PAGE_DIRTY,

it feels like a lot to add a scan result for this, but I mean... probably
actually valid.

>  };
>
>  #define CREATE_TRACE_POINTS
> @@ -1967,7 +1968,7 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
>  				 */
>  				xas_unlock_irq(&xas);
>  				filemap_flush(mapping);
> -				result = SCAN_FAIL;
> +				result = SCAN_PAGE_DIRTY;
>  				goto xa_unlocked;

Hmmm shmem dirty is going to be weird but we also have:

		if (!is_shmem && (folio_test_dirty(folio) ||
				  folio_test_writeback(folio))) {
			/*
			 * khugepaged only works on read-only fd, so this
			 * folio is dirty because it hasn't been flushed
			 * since first write.
			 */
			result = SCAN_FAIL;
			goto out_unlock;
		}

It's weird though, why would we have writeback, surely handled by swap, and
won't it be like anon, i.e. pretty well always dirty? This comment seems
copy/pasta wrong.

We do need to at least mention in commit message that shmem is explicitly
excluded.


>  			} else if (folio_test_writeback(folio)) {
>  				xas_unlock_irq(&xas);
> @@ -2747,6 +2748,7 @@ static int madvise_collapse_errno(enum scan_result r)
>  	case SCAN_PAGE_LRU:
>  	case SCAN_DEL_PAGE_LRU:
>  	case SCAN_PAGE_FILLED:
> +	case SCAN_PAGE_DIRTY:
>  		return -EAGAIN;
>  	/*
>  	 * Other: Trying again likely not to succeed / error intrinsic to
> --
> 2.43.0
>
