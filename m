Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3256222599;
	Tue,  3 Feb 2026 11:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770118600; cv=fail; b=Jk6cBrQpdnc5q81hTJNmjLAoJ3++Cn+VEuPRgGCFc8QKcVxjDpORf8hKnH9W5rfpKilRxToLl+rFue1x116xPjWObpALwnBqiYoM/Ug8iF/djtJA2FQxuYEXF/AS9zkmYah+UeGfhzV76szl6uaZ+QAVdPU4CVGV14lDuW2omKk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770118600; c=relaxed/simple;
	bh=S8Qpmgj9YlGxgvj64VOxE/M2nemFQz/A+4VD3fpXkJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MYmmQjYvF8/kuNpdGRMcSgXSgaJRUVf0S0CS2rW6jyraR4a07ikdmqzWsnQ8gFynPrhsCN3Fq5eCDOtiKC7opcbTnQmN6oWfCumXMDyVRzEteE7ibmXRV4/PdJgIMZGvmWwIogZmF2Ib2Z9Mndx1hdK4X11UdlBQFM2HVWNaT4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ozdFIvRi; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ew/mvlmR; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ozdFIvRi";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ew/mvlmR"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6138vQwI3652502;
	Tue, 3 Feb 2026 11:35:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=S8Qpmgj9YlGxgvj64V
	OxE/M2nemFQz/A+4VD3fpXkJo=; b=ozdFIvRiYRSeqsvotuOfCNIjqzFtJykxKv
	E6iL4YHzpsJQn9aRrlYmmeDdiLIcNVA9kZhbSzot2E12Opscm+hQ6KSJMYZ9mDtI
	9q4B1XreOe4OuMO5k5LZwfhXAYol5CCnFPbEItOkQA8cvS8COItnOi4P3zfKvl1q
	2Lqy+/kcvsaFXAih1a3eggNZW6YacsXdRuGLjsHdRUFVoSy2VEP4TZu1xLq/bnFW
	65y6cNakB2x3n9qc3Sm0HbVg+6WWHfCpwrucmjssa6MLWiS5+yLudRPVQxRCBZfy
	Ra+JEB3Rt+VmX2WD51trxNeo313ci0Ehfc1DX/JVQWpTnSqWgUrQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c1as3bvnw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Feb 2026 11:35:32 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 6139F2Lh025884;
	Tue, 3 Feb 2026 11:35:32 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010029.outbound.protection.outlook.com [52.101.56.29])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4c2578at4e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Feb 2026 11:35:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pspEuNGFa6g7eP8ZXHVqj+Raoa7tPhc9rkxSEpJNNfHzXCP9wBv8Iv3xA0n+TSDI8M875uvcBH7qYgpUY1yCNIMfyBSbig1jKcJohTHx11zAmgY94ypGXfUbDNEZaztQPh1XzGfbFT3URO96Cb4vdCAh8kl+hCoIWiOLUo8C1Vanew/IvycDaXSI8kKqrko4n/Ps1RI0Ab8TrMYGVnNjtCZXlinfNLw3Ey2ZAXmOvUDRgsFa2q6eQy0DgJgc7aImwKSFRTwvoIRCgni4pSdH0fjFBhSNViySmU+5pMe5MegCxpvdNUmjjCDS8USa1I4CfYzq7xHacYwmwFQJ3DCWPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S8Qpmgj9YlGxgvj64VOxE/M2nemFQz/A+4VD3fpXkJo=;
 b=W4ZBOg/5fT9G1iYUHitVv5gXw98JbyoPBASuc7+LPhdA+o1Tx7WVsJC8tjq9gAb+k2LJGFb8UBrogA7gV7fuBIauQS3wvULznQElzE7loQX3y77amNxFpEXVycOc+1FhGvcLdy3wLvxv4DaO46Fvpt5CsOZKlto/R2Lo/HwJA0n/6rJXLeIyO1cyi50g7q8MxBuZlJxWhdn4LarU5pHdDZQhIr8DHM+9gR8akHRFQw/LykmrnsC/q2U8cP45tGRHMLWtr2UUv2CVc0TP6Jspx/yerwoITYUwW2mGV8crgIUMMumZCa0n6bizMAONquIZ607U8qb8JQ+bJ88hrayByQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S8Qpmgj9YlGxgvj64VOxE/M2nemFQz/A+4VD3fpXkJo=;
 b=ew/mvlmRqcDTYfeVXZZDosaEIgSkxIyBnLFL+q8Tn9gRd00aJDsFV6Z5itKAuBgXSkDV1H18kCzVTT1wCvVRWw9SXfHuhohJFTg74S/Q0OvTLqbJujAZA5fj5gIzbaMREVsHmYeCz/wifrX88Jumz4bHL9T5EDu91uZs1YJ2sO0=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by MW4PR10MB6560.namprd10.prod.outlook.com (2603:10b6:303:226::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 11:35:27 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%6]) with mapi id 15.20.9520.005; Tue, 3 Feb 2026
 11:35:27 +0000
Date: Tue, 3 Feb 2026 11:35:25 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Nico Pache <npache@redhat.com>
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        akpm@linux-foundation.org, david@kernel.org, ziy@nvidia.com,
        baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
        ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
        lance.yang@linux.dev, vbabka@suse.cz, rppt@kernel.org,
        surenb@google.com, mhocko@suse.com, corbet@lwn.net,
        rostedt@goodmis.org, mhiramat@kernel.org,
        mathieu.desnoyers@efficios.com, matthew.brost@intel.com,
        joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com,
        gourry@gourry.net, ying.huang@linux.alibaba.com, apopple@nvidia.com,
        jannh@google.com, pfalcato@suse.de, jackmanb@google.com,
        hannes@cmpxchg.org, willy@infradead.org, peterx@redhat.com,
        wangkefeng.wang@huawei.com, usamaarif642@gmail.com,
        sunnanyong@huawei.com, vishal.moola@gmail.com,
        thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com,
        kas@kernel.org, aarcange@redhat.com, raquini@redhat.com,
        anshuman.khandual@arm.com, catalin.marinas@arm.com, tiwai@suse.de,
        will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz,
        cl@gentwo.org, jglisse@google.com, zokeefe@google.com,
        rientjes@google.com, rdunlap@infradead.org, hughd@google.com,
        richard.weiyang@gmail.com, David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH mm-unstable v14 03/16] introduce collapse_single_pmd to
 unify khugepaged and madvise_collapse
Message-ID: <1f6327bc-bb44-42e6-aff3-1964f9685f2d@lucifer.local>
References: <20260122192841.128719-1-npache@redhat.com>
 <20260122192841.128719-4-npache@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122192841.128719-4-npache@redhat.com>
X-ClientProxiedBy: LO4P123CA0536.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2c5::16) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|MW4PR10MB6560:EE_
X-MS-Office365-Filtering-Correlation-Id: 03b2c7a9-df1c-4893-b541-08de631853aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mQTYZmWJrwKhWNTf9z9agZbS1TAjDDhQAPxcOimCaBtQtd2FJVaNyBasanBK?=
 =?us-ascii?Q?W6YjI164HrzHp1dfcRxxAtqJlGaVV42gZqHV7d/BwVN+y6G4Lg8fe6GihWsa?=
 =?us-ascii?Q?g/Kpv2RmcsGW7IRb9ihrtAbNdYoGxcLsNWywUi3XtCpADBpjks5WPKTmvsZc?=
 =?us-ascii?Q?7lJgTA71rvGGtUf7qwIdI808FbF2TwOdgsbPmP4too6rTy71YNuGmh3ma5Jg?=
 =?us-ascii?Q?/SolbLIPW4UemxpYRU7a8uNY8IDq8KscVogHPGocNv/Ml4US19h7KqaqO7hi?=
 =?us-ascii?Q?tLrx+El8LKuz6VO9OkWJlGHEVK7bKyKjfwT5k6BEWrlYJY54/U+p3JZHhDOA?=
 =?us-ascii?Q?HI1DyAGv7Qo4MH+mr+kGh9iHkZn5HWg2Q5thkFhzWrBpnn3fwvw0hqgxBL9q?=
 =?us-ascii?Q?Opzx7oB75tBjV+jfG1dCTKI38niDTFBR0bXZEIdc+HPYBu2AcFmrVIi2Hmu0?=
 =?us-ascii?Q?8qjxuLd7AVDcrS6JXAC97+pRz9Q0iNbiXJ5RUk69zKbm0PdRMDic0kbdoMn0?=
 =?us-ascii?Q?R/0xkUX+ejJKfGCqc+cELryihyQuQDKmInzj5w6hGNYokWbwTJkx1+vM00VB?=
 =?us-ascii?Q?Lo/vdcAAmwhd2IQC6Bzq7Mn2mpmyaUJ1TCnbw97FZLhrOPXffA/Zhg7No8yj?=
 =?us-ascii?Q?daHILS/qHyoRSvTa96Iwdl/DSSmfomihWrWUEf34MJ7kiOfz6uv8J40y8dKj?=
 =?us-ascii?Q?uPRFEN+Z/YXHPLP29hYa1l5a8iwrfrtLCbRKBYHYjO3sDzDNUHx00srMphVv?=
 =?us-ascii?Q?YRywgCCejiKdBKBTnkm1yAEADhanZtiSJaP8jQl6fFX+8+TveY3fOeDVOO2H?=
 =?us-ascii?Q?0b+f4POSKuo/vcXI+UwbE4PTjD2nSid7cbZSp2aHgLslH8Ix/p5J4u4ZAehh?=
 =?us-ascii?Q?oNpHRfbliwlp8ggKIdhSyuR78CIH/jlz/4Ro2bV+2uZ8ROuEPl7jIvCFxlKt?=
 =?us-ascii?Q?UH812Fg0kdd5g4xYs0y1/B6kPcWO43PRhgY1PJ2+JkKMtvajFqWRODUMXn5Y?=
 =?us-ascii?Q?uzEmYowGsIOIt/3BuA2fp3+EFMrVckmmnBgo9sJ81/VNZ0qf4BUvPBt+H7Yl?=
 =?us-ascii?Q?xnUMqbfHFJmxrSac18AOvE4smdbiMZlwBtpAuCgd+z2VGQb2CB6FpFfDiAka?=
 =?us-ascii?Q?5qIO4I66Ki3Qwo9kQd+BXX+JYTaDSfJu92Mlp9rQm3FjK0VXX513S6OHMND6?=
 =?us-ascii?Q?NcXWCu9FPPOPrgu1TOci0pCqa+Fx5TMtUzurMe/KQjhhCYewSprY8nK+vBKL?=
 =?us-ascii?Q?a+KH3SJ2b4X1kguarqmClhUqclpvW9GcdaFwO/bWR0wSb5cyTHjTeeZouCfC?=
 =?us-ascii?Q?vyzYzu4rSgcK08skJyc3dY6pZeGa6dc6tZEhwt2Tfr+JHCIMqe5mGQ4Xxebu?=
 =?us-ascii?Q?mv1tyUJjHkcWyazVW11L++S8xDK64fHiPO6Wn0pZEEQk+uYndC/swvM5VNDB?=
 =?us-ascii?Q?gxDw8qZ74fXlWeSz9f5+ky/4nNlX7Od4gCbdfAyNuren2YQHpbataZF8zfQq?=
 =?us-ascii?Q?dlvPnRYQ8CK3xVl97X9YoSf/DQvQGlj2Uz/ng8KwW44MsoAUGRJtCwYvP33b?=
 =?us-ascii?Q?i1agvh4cRUV4+zuCaME=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uxGDbmZENnDe15+8IAck07X8lgALpAp9jOb0Ob6jNFZsAyeitUqSbI86msEF?=
 =?us-ascii?Q?MLqkYeR/tv62evMPdjg8HZ6cwj4SqSco5Li3bvEg6vkv8doh8n9TCuS2laM/?=
 =?us-ascii?Q?SMvKC10ASBVPEWIFBgdHQUhYjGhLwH4DLrLa2vEjarzz5mIBBuzO7khzY0mB?=
 =?us-ascii?Q?qrEU/EUViHeL+o5vSqJzvgTxlEboQiXYdKCF/xfXDsiixQqIyr2gUWdfVrmM?=
 =?us-ascii?Q?Ifwxgk6v2siXounCk7UkvnoIfSQwaWHKGr0/vZ5MbSPzklygjwLtiKrffCLe?=
 =?us-ascii?Q?2CHgz5P+tCHlXtIXCaAKA7b76mdh49SQgkyHMFRrT/n1dwBNDM2jUDrsWv2z?=
 =?us-ascii?Q?JtNNvwhRj/ieJfC/YMeEKAVmcFUv56/b0co2mZc8bazGYO/r4ExyZts6NWvl?=
 =?us-ascii?Q?KuStybstcddKjS/ErZm4kPE1lQjd3tOBt5C+8WWFF8zfSH+jYe5GZDDVzDg+?=
 =?us-ascii?Q?ipl/lYhGj6NWtKBAWG8KjScoO5arfjiA1m2V8vqWhvncXAJacPUOe1AEv8C1?=
 =?us-ascii?Q?5XTjxuQ0GJfqUEcBkZmSfvy2Fzv05/LNGdLwofEZaYLAZsGK2rZqE9jFfNj0?=
 =?us-ascii?Q?iXcFPHla24iCX88jYV3YVZMa0zTy+QnHjYG2w+IxTiOjEfGyyooXg8GfdPYO?=
 =?us-ascii?Q?tmuUHmgb8/tx16C2KX2fLdiXNERwdpM0mguxjLV57mhntCZeN0kk/m5uOkjb?=
 =?us-ascii?Q?ea3Ade35i3xGuD70LVH38tSqwNtx0zKOSdO8bykoV3AgdPYJ1IvaGo/hiuC3?=
 =?us-ascii?Q?+LIZO39Phovq4mpMEsfqhigLvBy/ccaJficoiqDpj1kP27b9mFFm0TFY3u6u?=
 =?us-ascii?Q?eQFwsgMXS48BUs1twY6u5Pf1MR3D9UP44EQKLBIo+xBtqG9FDCUGd81LYjiW?=
 =?us-ascii?Q?N5rZDxjUKE4r6HrsaP76aAVRU215NKOk9zhBPBorBZ3Og62sUS4B9yBTtrgV?=
 =?us-ascii?Q?Km1YspBoQV5F66N63k4r2jZbh0rQrJZGjKhkp560NxzSpCjgkdIAihB1n6B8?=
 =?us-ascii?Q?ihzS9008FrAKGJ5CPHhnpbJ9hPQZtYcQMm/TnbJAfOkENS9GGHe/jagSUijZ?=
 =?us-ascii?Q?7WOOwZYrNZBQgUsNWUnz0KdbdHJtH3fNFfPTGkBBKAd8HI7pNeLzUTgcjRah?=
 =?us-ascii?Q?5FaunEMPFZQjGG4eOLOiPljbPsTSUxn17jXtkKGgbceJZRqzr6SYytiOwP0g?=
 =?us-ascii?Q?E3Oa+xEJq0sKjjRrbIIitl+rndZsJ2J7t3bOsDUUBGicaUKGJ8MWhBGvbeNp?=
 =?us-ascii?Q?TrP4omOxsjLAI/yfiPz4hX3kl94EGsgCkLTqKgguwNw8nflhM7kow1Fyx0ld?=
 =?us-ascii?Q?TEtXPeiJWePZ3cL0FJBQVa0QBykhmg7VNpsTuo6RhEr48LNllLhG6Abtri+D?=
 =?us-ascii?Q?leLY+2RyTUeuQr5azBjjxw03AEfSApEz4T+cFTDOtMVRwwSdkarG28Z1XNtd?=
 =?us-ascii?Q?p0DEHhvFPDSi/xs+Y1yI+dnnWKZGHLes6I0Wbyk1/OTFPzLHt2v7gfnFQPvG?=
 =?us-ascii?Q?6JGAgToeoIvGUOoDCiXlk14K7BiBGz2a/3XR0ypEir/GzP4M/hdSaizIP7km?=
 =?us-ascii?Q?6DkaXxJH0mA4Ss7qyVlHi8DpDXnZ4RlbSuqHjv1VaiXzFe56onvduq3ZLWdX?=
 =?us-ascii?Q?5WCPHR4bmD6ECKJQaMQSavWZrLnPNwALVw1alHKvyYSXCIEHHJlZi3iPnS0Y?=
 =?us-ascii?Q?Jdi/OUwML2PCWONdlsVm2TSIXJ65JFb+uMpTzPTkXyyzGmvlRr+I4KB92GO7?=
 =?us-ascii?Q?E30taExh5g8zyyovSBzZo8OEjHPu+ls=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Z5Du/orJG+sIVtWPBmLukeFa6Uo++CRTf501GNCGl4/iNld7Ld5xtVuoUin2kHQ1orLit7QgsLfp3wfCJL8jEnH2AsC8ozVWBkNPPu9v4I9X/OtopndhMAM33CrXKfKkhyKftloGrSEa8to4B47KTXHtLcNZ8mfCcS6ux0XgXxpXiPHYfXyDdJglAekMVwviF8W7WkW9R9Y0QjmWleDg+Mi4EqmZC8LMsgFNlannmGldlRqxG1B+AAru2eOkhMMe7KX5dp/HAymWb1QgL3vLbAdTxed1QdG/HNGLkEezWHJkPsy+m+YD8w+bcexLxx9UNl5Q7rp0lMmLU2MzZsdJXcjT7Qknj0GvkR/0BIF6/yLwxSOuxqzkMj7RW5s5B/GuTWA+BNI5cTieWnR0SrdW6zcGNBkqtDqvMrh1qtqGMwJEpsPg8c7zLa6Z5ryoMoztY04CuO43ZkTiSdnA5ryLge7hQOnk0/kN8N3cV9oIHXzBIMRNgrQOpPYcr/DgQ1k8zjziHbcwBc/FS2NXAWq/PPMM6ldIRKtAUvJKkHy2nqP72WEKYkucJzf5D1g57DtyKvyY1JS9KCfrQwTvLmlK+Zkz+OOYtza48N19g1gi3Q4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03b2c7a9-df1c-4893-b541-08de631853aa
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 11:35:27.1558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jk8mLCuR3Vsu7ykQncNrERICIO1qQ6G2ON4O2JKYyMWWWayGeg2io2HNINqSyaokPoJoVyvW7g73KtBsF98Ov5LUrw2yif+AtbMQJPDtN5M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6560
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-03_03,2026-02-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 spamscore=0 bulkscore=0 mlxlogscore=543 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2602030092
X-Proofpoint-ORIG-GUID: hLycPueqslweNztzP_0MmFh3PMNoSrhh
X-Authority-Analysis: v=2.4 cv=Sq6dKfO0 c=1 sm=1 tr=0 ts=6981dd84 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=wPt-YyNiS12psKYWXW8A:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13644
X-Proofpoint-GUID: hLycPueqslweNztzP_0MmFh3PMNoSrhh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAzMDA5MiBTYWx0ZWRfXyLvqQYQpNn8+
 jRHOC9HIF/YA6vzAa2nPyljukkBqJIWH47l48C74nxiFkCqIUfjJDRapcsSYK1FDdx9lu0iNU8b
 RQMZTdKNYrXeIjttvPz7ktFoBCcTW0kL8ETTF7NxLfAjCNdQqyFfletsYvq8Z23b14EX1PR2X0Y
 GFTKIxLtXobKBG5ri6goYMiaMl+UC3JKPDwQCq8AHc+pc8SJD6/mnF1dS0JGN8+BixOlJQ1ylBW
 A0ipJZAoE8wytx09+WAInqHM/V2/v1yY17Dv3yMkBt8PhXxCq2mizI3AgV5BOHSSLpXJrP07wb0
 +mg8LFvhM0efM+Ux8s8OtufnVmbMkuPxnz0WOiLoOrF/lQoZIKIyb9dHpz8jZSFmCu1LyfP5qV9
 zOAJhFAB/5d50iwXdqBtTEPi3tjvaDo3QFoTByhJ/6lPsaNzCOhKQgKSbpFEkj8F8NI4TccsxbP
 eHxbkJdO5KqSosRmwEqx840PgSY98WovpTwWR2Mg=

Another trivial point on this one, you're missing the prefix in the subject
here. In general I think better to say mm/khugepaged: rather than
khugepaged: also.

Cheers, Lorenzo
