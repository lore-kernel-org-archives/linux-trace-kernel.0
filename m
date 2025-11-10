Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43A326657B;
	Mon, 10 Nov 2025 22:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762812252; cv=fail; b=qa/IvCYOD7Q2Z8rWshCX1xlHFMt8aJg+RoeA5gepGVAgqaJwWx4qA6Hx7hdwQTzYa1XP0JTf4t0aTkeHGm1ilpg2d2RYq2GuH87gfVFzccNcGLw/1YagfH88RLnhtSdSnme1k/9gUzq3B5yWNdFMVjHKOg4in2ZmhRoUKeN0EvA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762812252; c=relaxed/simple;
	bh=Qb6EPixJuliCDIz+DoEufSjG+wKfQs4E6JUS63vTJGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Oc5TKQ0oqsafvwGXEH4/vZNb8ELBuvGpbcDEX5ron0Y0uheOu9gZoZPpg76csQfAglmAUF5+Iz9Hv5mFM/7e2AeTfHrTXwHfdy/7STAtB+Mzlc7zhhywyscvDPIYUO9Vs4tgjMJs9vuYK1PoM9U7jNoGT8VEes0t08E+LS9ItqE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HMNpVBqf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LDopDlAD; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HMNpVBqf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LDopDlAD"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AAKCGmL001288;
	Mon, 10 Nov 2025 22:03:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=23295YUtXIz08TYMpG
	cWhUt5n2XOqAKfURY3HQWj8D8=; b=HMNpVBqfzLjwqHweaWCzEOIwg8pAbVYCmy
	Zx1RNCGSvKx/d5qCfhQyJQMGHO4qO18IFSms1bpL+U2LcVBNd/H5RjoMevYzeTKu
	Iy6Qk5EqTsQV1Ez6ww2izE7gm2PQsDtYXtUr7cK0YHCzV0tEIOOuRpqXMFMxM/hs
	Hwj8oPtf+qzgnhHR68DzmSjWh97OGFqEYcZxEQ04Tvi6vLzu8pZJIQozsvE64sk1
	RLTv4ha9uibjtaGMeLz+vuyX+KdPzWEchZCe1FyOnSCLk7iOpjpYMp68DttCJPSy
	uqOZMwHQXQdMmncUgpkoNzJji23C0mbF/MkDP+Esh43VbOmULHOA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4abpfy8b1d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 22:03:24 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AAJv9lH020915;
	Mon, 10 Nov 2025 22:03:23 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012006.outbound.protection.outlook.com [52.101.43.6])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9va8r0b4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 22:03:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R92O5SDwu/OFsRjE+JeK/01/hdf3KANhKR8Zex6eVDiqwBFjIC+yHYFXlpMQcqEj6YnxugLuFFFytTCaq7W4gu3A5Tqlpqah9f7GRU+/z9HxjvxPVILlUTJ1pw8+ot0fK+SGoVQkFuEVM+tRUUBh/ff4Ejc8eAZ2DkpM5ECyq2fNpPQqD0dahUzr/yAQPCWlRh3xxDO0IeDnhrOwSRoY8RSFY23qNuAezIfJLCrYu4/apOdWNBME0aB7S+l6ZGshafWeKe6zTQnJu3gLmTWP2gVULWtdpTKzjDA9KGLi2dwXpUfUlINJOwAIf5CFzV1VyAYA/wgHwoeiGgFyK+L+OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=23295YUtXIz08TYMpGcWhUt5n2XOqAKfURY3HQWj8D8=;
 b=MfTQog8MGJUvZezwJrDCFjInfEquKCv35EEj8Arwqz/AS8ECOu349sN/GbdAob8sKtG5hbD59eupHvetOKMETerp0EJ8fMJeIlvMD99Tm2ps8fChgngWY406seREpml3s07xibQd+0/VcmKp6VV324mJVyYi9CuZA8pu7M1TW7M8FvsJUke73HmZ99HeajF5w8uqRySbp0gkh063Rmg8+6VvxocDUJLuJO3EBNYvcbzb8mtIMJTxxgEeu501ExmZPwHlkznVjIRB4QGbH5+wC8JhLRTffSjSiPDL2UAR0sRFDFRWA0GRV4Ps5fzX/aQuXxkCwPG/520eFsC1IHJ2wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=23295YUtXIz08TYMpGcWhUt5n2XOqAKfURY3HQWj8D8=;
 b=LDopDlADRX3nstzE267PfDElqaPpktZNguJd+I8hHZHlF2Nk/ticZNOq5lW+Xg+gEuGif+EhLeRZ6GbppIUwHKUgkbRRocoqHpmVb+M41wSVeDbyVM+xLZ44yp6+pOCnRqB57AlpOOj7yXDSLqDJumcbK6s2FZoNy6R1nShJ7yo=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH0PR10MB7461.namprd10.prod.outlook.com (2603:10b6:610:18d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 22:03:07 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9298.010; Mon, 10 Nov 2025
 22:03:07 +0000
Date: Mon, 10 Nov 2025 22:03:04 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Zi Yan <ziy@nvidia.com>
Cc: "Garg, Shivank" <shivankg@amd.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Zach O'Keefe <zokeefe@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Branden Moore <Branden.Moore@amd.com>
Subject: Re: [PATCH 1/2] mm/khugepaged: do synchronous writeback for
 MADV_COLLAPSE
Message-ID: <031a9b4b-96aa-49fd-9005-3494f080695c@lucifer.local>
References: <f21b37bb-7a2b-412b-be76-e8968b4c375d@lucifer.local>
 <3b10d11a-3c75-4c37-8810-e238113ce75d@amd.com>
 <bc07aa10-d8d1-435f-9393-6c4ab63cc179@lucifer.local>
 <e9a0ec60-6e8c-474f-931e-2f97e5bb60c0@lucifer.local>
 <69FF5A7F-1414-4DE5-8A2D-09ECE240711C@nvidia.com>
 <77925a0b-fa06-4200-a967-a66bd93201db@amd.com>
 <27920b64-240d-40f6-a02a-0a8c433ca9e1@lucifer.local>
 <ec53bd13-42ce-46d5-a1b8-c4157663b60d@lucifer.local>
 <b12340fa-358a-4799-a040-636994beef36@lucifer.local>
 <05CAD17E-CF58-4825-A36C-EE428390AD23@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05CAD17E-CF58-4825-A36C-EE428390AD23@nvidia.com>
X-ClientProxiedBy: LO4P123CA0292.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:196::9) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH0PR10MB7461:EE_
X-MS-Office365-Filtering-Correlation-Id: bad52859-0767-48b4-4f1c-08de20a4edcc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7+aJNCG+QgFeX1h7LBuYA1sD1YHMW1AcV6z7PIUxR39Ow1qGAerdyDBX1UJF?=
 =?us-ascii?Q?J7fj0V29PuS4RxcOyvzqxYdC8Pgx3KiWeR2eqJrcz/ewgcA6phmIaDWq2i1m?=
 =?us-ascii?Q?OUuaMc/5PjNua2baAi6Sv6P4TAz+5OvEaD7pef3/yjalkgOKocFDnllhWm11?=
 =?us-ascii?Q?o5BMyKuphRGu2DpdqaIrxQHS4L7+2x5Qi+UUrZA0Pk9lfujQlDC28VB+arAi?=
 =?us-ascii?Q?5ctAzz1y1deSOVpYZnWLdsr+zDbKBRlllbgEQQBp8vuc9vctO2u4mXeiWHyy?=
 =?us-ascii?Q?cEHRTcjq23ymjsz65ZnM/pToDV4k+KfhZEVDUOI5VT3dXGhgnedOMIu40Pdx?=
 =?us-ascii?Q?JoE2+g39TdNfPnG2HyRFRONhRpTPEqVDhBOKZwh0NZ+NB0f3f4JxEFVIMOn/?=
 =?us-ascii?Q?oI7Z8eUoWlesyjE6S1fOjP8putPa/hRKVV8h7NfaY04YYtFCUTq2938Y9HiL?=
 =?us-ascii?Q?Uv3isXlxAdIPNkdn68ghrx4eYBUHOa8kN+zGnrAx8u7EIyCJf+oTK5yWKfkl?=
 =?us-ascii?Q?AWUP2uBI/xGM7hq/AyQUDGLqY2FYaToUOvB4/4rqL8V4/2nhRpFFVMKLhHV5?=
 =?us-ascii?Q?z2ZQ5kgHMD7Bx9piQLaeNEHOZ3z/KiVt194rvZq9EcMJYNviKqC4SCR9gx83?=
 =?us-ascii?Q?9EdeOZtNVZH6k/qgTk6cGCzdZacOAEJCI9Wal/ROOnsbA2rCj/ghoDdQimr/?=
 =?us-ascii?Q?ucrfqRcQjAkBItUPyH9z9nr5p1AIXacpiGMFupxrGd0Ty+rrUqBXBwovJExS?=
 =?us-ascii?Q?qbVXTmwhVizROsSsGAb6Hyj0iTXrP20inkEl3fv9lFTKL0+/ld0eGgZ0MC/f?=
 =?us-ascii?Q?lqFIbBGyNLUSFH4AJZgGHX3MttsyJkmyR7tlUqxQY6htZ2K/SWKy7kaEKleM?=
 =?us-ascii?Q?+MqVWzjLUT7tdhRcd/19DfgZ8FuadgK+MwImQA8B+YeKBD2tuNnWxKyVZoQ2?=
 =?us-ascii?Q?4XEW9YW1E/Yz08aSnNa7ShSp6enwhD3yDpDyUaG3cwpsHAfOjL4UBIqqAUrP?=
 =?us-ascii?Q?8lSj2LsiBq8wuxv5IDnI9B6rvxlV7n/xNIRZbhppvf9bvxSd8AuOcq8GTG4A?=
 =?us-ascii?Q?Tqm1Vb2plDpS0gRFc1oewkpGS2qEFTF9K65hb3fLeCl2HKImAuYGRTaUnOGZ?=
 =?us-ascii?Q?KZgKLQgmmZvSreThfZGaMizpzwFTPLDE7UHJiGycyoYssP81CCUdNgFjZcTu?=
 =?us-ascii?Q?ji8PF43hAOpeFm3kBjXjntgIuKaNIIkM78sUOMHBHrALZVIVCQ5T1iGH/vQu?=
 =?us-ascii?Q?ckM7t9tVXeKYgA0wg83IHqaD2zKhWVUdyWC1/v1mK53QuNGMDJNXh+6h8gXg?=
 =?us-ascii?Q?2FbTLQqYXt8YBin3KkEEcJeytX/ToAtGg8QOA4lgA9TtDrwbu33Aj2cXXCQ5?=
 =?us-ascii?Q?xHqhMdUz4/5EPiw0+/QSYj3ldlvEZ74OnjoUU8LJijb+Za8fLqTA58U9XEyJ?=
 =?us-ascii?Q?uC1Klp28vnNxQ/Qf+o1xiEIcIgwGiMVe?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?z87Bp+isTTfh9ns9Zm9KY1/FzlaAc54GT/W5JNo3rCR/xQ76JEjKAtdcG0zY?=
 =?us-ascii?Q?RtTdNUfpS36WxMHkAgFVntazvQviVw/UNqTNHu39Ig8Zrb35zs26hBmE3Y3I?=
 =?us-ascii?Q?BGLR4VS1laacdhxZ36jN61JIR+exrcFUK2Z6+yIo2p69/WCIzcBiAf1R4PN2?=
 =?us-ascii?Q?HQLGZEipfkvmluldTOWU552APzsuYypvpIjXg09nanavsZiKW627PAjc9InF?=
 =?us-ascii?Q?2VuA85Jr1K+NKAkrBnSh1TzOFVKKzDOXrx5ZtvbjAaH1+MS7wJO2Vuu2JdQk?=
 =?us-ascii?Q?XlP+runJD063VuRnO6fYwcYN4Wxxe8ococzU80Me3UVvIrFTClwhjiHMZs49?=
 =?us-ascii?Q?O58ICV53v3Z89ZCy5TGAyvoubAYomY/W7Zg8YZBt1ZIdifD1gXDiHAtDYR4y?=
 =?us-ascii?Q?ArRVO3ReT4LlbME9QI1oXIx/vp4BX+i/bv3kmmLOLrjEqTgp46SR0C+Y3yUY?=
 =?us-ascii?Q?2HRwzoUWeFbDovnH+5Y1eo7ifB797NR/UCGcKeoeDj3/q+v7JiHxjdZR23As?=
 =?us-ascii?Q?PuuOfeq1MIRgNUiLi/GeceaPSvIXnvRnzdJpKu+rX97GyrgM+Ma6rMXlBSwQ?=
 =?us-ascii?Q?7EviIEL8x47A0iYAu7/+mQaQzO6vgY2uDdEOf4mBkD+ytsyXV4+Smf9UijWx?=
 =?us-ascii?Q?hlnd77EInXsMvT5OwvrnYLSIhCeQmrNeJbJWvrguYtIMcClq8Apmba8KQClj?=
 =?us-ascii?Q?x/6xv1dATKaZ2o/ZNtcfh3bkONT+gCcietUgM1QeFmOXxfRcRSUKmsAgmGcL?=
 =?us-ascii?Q?7nk3j33wDRiwT7H3WBsjfTTJFIPg4ANXpqbhnObOZv6kmEW6j4nkKoqxckyH?=
 =?us-ascii?Q?UNyhr8zwHPh6d0jfWNpznMrYjxei2L6uvTrzbXwrSm830NMn3/fQCsGtnxTz?=
 =?us-ascii?Q?Ng2AxVLbMMDbrsdSw8gBQBVqUw0g19x260Qa6EZlZhPRHkb8Gt48OdOFRMCN?=
 =?us-ascii?Q?LA4MoXdRwEZzwKREfL1MfdSuogYM4TbOqGcNmsEGGWebsN/rFs3WdWk5hzNW?=
 =?us-ascii?Q?Y0S3GlFt30vUq7e4qamhHRC4ItxIlbIcsRbjSDeKdaXHz5BB3MmQ/TP3yq2K?=
 =?us-ascii?Q?B/230GQ/pHR1lfV1ezPgu9G2oQWC77YY0JcRqZReZ72dhREGvDkNMbE7/6GO?=
 =?us-ascii?Q?aHMCnVFYSkRMjasYns8kAtQhstWHUNG6IQ8+qniGSeSjvdO+GKBAsZz56ay7?=
 =?us-ascii?Q?KNCeesX0zXCuTKD8HkPS1NQrVS6gEM1u4iaaWgM8voiVt7y/KlpEQTVaszOE?=
 =?us-ascii?Q?CZM6btyqS2jC/7IyeuwX8cOSlEkOZngdxcitya6nqWFHIfhnikiDx7DSVnTg?=
 =?us-ascii?Q?v3zISoeKxxp+4+IPMcUpVC4bhC+mdmypWmyViISclWx9P2QH821qPg4vXKue?=
 =?us-ascii?Q?UQX7qOqsXe8HbYSjiF0ogK0uE8hsqFCBneXE43pIGkOMxTxJWOl/q8/FqtHu?=
 =?us-ascii?Q?/XbqftvkBexEd9rZevxDt2mo0Fwu0s+i1kd0wd0N8KrPKYzWtZmfF8UwqMCx?=
 =?us-ascii?Q?OD8fcJ+PnmIPmcMwFRTHBfLKAmznuzy3P+q3UAeH0YiH2jDesk3n2K13Nt4i?=
 =?us-ascii?Q?/grV7aa0AslMcFmxoAlHw1TXT1XwhVLmD7VgL6JObC93DxDp/XqTWZNDvviR?=
 =?us-ascii?Q?Ew=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HuuW4Y90B6shtQUeJBcY9NH+xCe6YZHhmAeQM7TzacqCp7cs4fekX9OymQNqp/ToeAWNUnIo+o+L1J5Yx9uRweUuKryCKuMuXXwuzx7hgIUZzHlDVUmFPKbHItOywGb9eJxBE94EuSfaUwZx+NqGq1AWQ51x+VSarzhSba1CA9hlKPcABiljvEFWjR7OGGY2OtIhZdBopU2sGAcsTy8H4pGHcEXQnoI0woa6UgFiFTg0VrRpQt4H5f1k1D5sNSpgFvE57FFwMCUed50zUbUzPeoUsRWnmS14oFmu/0mPUAbKjmeNlx2N3vOtc4uTLjJnbaRslgsnSkR3FM5pNsK4UeD6O/DDwK1OAb8BXE4lHXY+f6dCZdAk7UFWPVH6k0shYjK7afqlooWjRqz6ZK1PlIFPlmgZKrhx0vVtVX0LxbESqWHoLI4rrVmnT6M2rtCd24cssB0H+mgsKeij/W8sUF2m7yIpDGuBKPaxumd7vlnQ7nkMTtt1HFVPRUkZLqLoldW96sWV2upOpdmmS5devV0VAtrcJxTXsEZemrQHO+fhDATvTuVkyS/xmMv4VNZ59epJ9gOUsfPc3CnSuIO/KqP8UAyVLYVhKJLgZjbin7E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bad52859-0767-48b4-4f1c-08de20a4edcc
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 22:03:07.0131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2e7uWSP9aEDXL2RMvdVcIlsex7sNHykqmrMwRH7bnL+5ZAYG+jWuh0SpKafclsC6SJ0Ih+8ajfn9iRnbrGhYMhP7VUJ+Z84A4pm4GAZjZdc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7461
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_07,2025-11-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511100188
X-Authority-Analysis: v=2.4 cv=C83kCAP+ c=1 sm=1 tr=0 ts=6912612c cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=ebJ7kwAhUA7yWrliObgA:9 a=CjuIK1q_8ugA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDE2OCBTYWx0ZWRfX3gDJ7KUxmhqg
 L4z8o2THI99ymVEeEMHQnXq3p5/I1v7MmlOlC96U3KondiEKkrQVihAE0wY+OqxEap1S6gCOxJM
 PbolUFLh7uE7VzhhF+mMxNX2DC7Lagt5e8V3tni8LICuwA53k2XUBmGmLzfJ5x14u0RghUTYnzv
 wyAkdzfumgzkmGP6tNpFCbmAsw45pF0lJCzbxl0FOrEE0m3PQU/S/5G114qEpW9lwbPQ0RLgb19
 An8fNE1qTI3IOqOKm0xpdTBEBdF6tFR+PGu1zgEsPrBs/Kh9wDp7HgN+78Gsn30/xVBFf1EhRxC
 pLMEKNvqL66SbuJ2dWXwg+mvtxSsW5nWJyU84Zjqz4Q3slcpnWfz7IJR4lcgKyq0LziY0u6L54W
 E+8JklBmd1OCcPZJj6fvzAgb4Izmww==
X-Proofpoint-ORIG-GUID: xCF2AtyOo8DSJKfwH96v61Pmiz-ATaVQ
X-Proofpoint-GUID: xCF2AtyOo8DSJKfwH96v61Pmiz-ATaVQ

On Mon, Nov 10, 2025 at 04:56:37PM -0500, Zi Yan wrote:
> On 10 Nov 2025, at 16:16, Lorenzo Stoakes wrote:
>
> > OK ignore the past mail, I have managed to repro this locally and have a
> > fix.
> >
> > Turns out the swap code is doing something quite insane... I will send
> > fix-patches to the series shortly.
> >
> > Meanwhile I attach fix-patch! :)
> >
> > Cheers, Lorenzo
> >
> > ----8<----
> > From c705fd85a806f53017df31e6b072c4bfa839e3a2 Mon Sep 17 00:00:00 2001
> > From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > Date: Mon, 10 Nov 2025 21:11:52 +0000
> > Subject: [PATCH] fix
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > ---
> >  include/linux/leafops.h |  4 ++--
> >  mm/swapfile.c           | 12 ++++++++++--
> >  2 files changed, 12 insertions(+), 4 deletions(-)
> >
> > diff --git a/include/linux/leafops.h b/include/linux/leafops.h
> > index a464a7e08c76..c4cd36760ea0 100644
> > --- a/include/linux/leafops.h
> > +++ b/include/linux/leafops.h
> > @@ -56,7 +56,7 @@ static inline softleaf_t softleaf_from_pte(pte_t pte)
> >  {
> >  	softleaf_t arch_entry;
> >
> > -	if (pte_present(pte))
> > +	if (pte_present(pte) || pte_none(pte))
> >  		return softleaf_mk_none();
> >
> >  	pte = pte_swp_clear_flags(pte);
> > @@ -95,7 +95,7 @@ static inline softleaf_t softleaf_from_pmd(pmd_t pmd)
> >  {
> >  	softleaf_t arch_entry;
> >
> > -	if (pmd_present(pmd))
> > +	if (pmd_present(pmd) || pmd_none(pmd))
> >  		return softleaf_mk_none();
> >
> >  	if (pmd_swp_soft_dirty(pmd))
> > diff --git a/mm/swapfile.c b/mm/swapfile.c
> > index fd23d9f7ae10..f0dcf261f652 100644
> > --- a/mm/swapfile.c
> > +++ b/mm/swapfile.c
> > @@ -3202,9 +3202,17 @@ static int claim_swapfile(struct swap_info_struct *si, struct inode *inode)
> >   */
> >  unsigned long generic_max_swapfile_size(void)
> >  {
> > -	const softleaf_t entry = swp_entry(0, ~0UL);
> > +	softleaf_t entry = swp_entry(0, ~0UL);
> > +	const pte_t pte = softleaf_to_pte(entry);
> >
> > -	return swp_offset(softleaf_from_pte(softleaf_to_pte(entry))) + 1;
> > +	/*
> > +	* Since the PTE can be an invalid swap entry (i.e. the none PTE), we do
>
> So softleaf_from_pte() returns softleaf_mk_none() instead and causes the
> issue?

Yup :) fun!

It's kinda crazy that on x86-64 at least we _intentionally_ generate an invalid
swap entry but there we go.

>
> > +	* this manually.
> > +	*/
>
> This comment is not aligned, in case you plan to send this patch as is. :)

Lol ugh, well I've split out this fix with fixes for all other raised points and
plan to send a v3 of that series to make life easier.

There's a bunch of conflicts that arise from the changes so that's easier for
everyone.

>
> > +	entry = __pte_to_swp_entry(pte);
> > +	entry = swp_entry(__swp_type(entry), __swp_offset(entry));
> > +
> > +	return swp_offset(entry) + 1;
> >  }
> >
> >  /* Can be overridden by an architecture for additional checks. */
> > --
> > 2.51.0
>
> This fix looks good to me. Thanks.

Thanks!

>
> Best Regards,
> Yan, Zi

Cheers, Lorenzo
