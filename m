Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9D931D386;
	Mon, 27 Oct 2025 15:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761580023; cv=fail; b=HY+3EmrmtmFz8HYthokpDshTrudRNqTToqaBMPP3WI8adlcoKcXDbHKPLr5vHXqAym9kJZyRVT5t4mW6cYZHKEnc1oTaPogH48TK0hI0yQ71QG/lkxxb8hXIBT3L2AAdxlHat4r+BoWX7KbVRHIugqRUvn/n44bLZoeorSsOiEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761580023; c=relaxed/simple;
	bh=ZXJKWsZCVNc1YKUFR6T8ASqQcLj6LNUKAjsFHRsWbAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pca0bYyRwr6vEYpe7qOmvPS10Lr4QG2K6MLaqeLg5gSeMTXJAPyyu9SFaOqYCkiUXQ6/BzJcK4v8hxmG8QR3p9hTYiZs71673KAlpM0Td2EYrNnDE3WsY8Dedj9GBm8Cv7a4XUdiSYCbsE5kTFeiuWMLW5jFjp0/RXh+jZ6hp3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=breiks8K; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CEE+XqfN; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="breiks8K";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CEE+XqfN"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59RDYAUe013880;
	Mon, 27 Oct 2025 15:45:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=yoS4i/HTWpivTh2WPc
	8ozMiQmu1FdsIyDIAiTxyswbM=; b=breiks8Kn9Z0/ClVb1FtoG51eRQqwOo68f
	XMZmKU9KkzAnVy5GUqinD17/MxyQeyrKD/11RWj6p9kEo1OcCFr6SXVS34ASpJIo
	jsizHARn7QTMtQ0Kwnqh+dHE9BuSoIAbgKtFnwI6HYjLqO3Lece2/R8Tc5PlouQU
	DodmGiDXKMpWr3HuSbUGugAbW/0rD3gi+Ho8dXwJ2C5aNHitLQQkKdE27NH3olQl
	NPoP4WMyA47EHPGo/LoMM/IglSv/sTZMZQcXATmnogOVyHrOw+xiS88BMFzFJNPy
	FrMdLbaKiKzx6A5SNZJ4Z+hU4XiRLlv/55eZX8hcbGFpZHSDCa+w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a0q3s3rcp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Oct 2025 15:45:00 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59RErf8d009142;
	Mon, 27 Oct 2025 15:44:59 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012042.outbound.protection.outlook.com [52.101.48.42])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a0n0e6vnd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Oct 2025 15:44:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nzklSPry396UIg/l9dUkzJApIQhMfC8yt7uEJWWyU8GGt3yVXK+glss7LOkhZNq76tjVuoowuZCa2fyxQYKeYynp5pNUh7Z3rFevqTz3yehAvfH+a7+t4Nlui7g5KIFPHLEkVGPTrztDwpfX8Krj7jmeREEH0g1XoYrxkDR0Pl+N9J4SH906a5VirYc/9SqrubQYkh/ryFes32aLHMB9JMP6IMQzkdQTcAuX/atOUTrBhFd/QcLxdXYxalBPkFXmZstl9hDpmWpong5jh95vt3gduV5qsb/6TYaNyFVWnGj6e+HwuyjfEx8ggr5V3lDv3D/P7yb6DL4dpHayPaYnrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yoS4i/HTWpivTh2WPc8ozMiQmu1FdsIyDIAiTxyswbM=;
 b=vCqb0b92t+xSQ/lncE6iMLiSu09H1W61cFQULbjfYNYZ+dzovGHUnMpZu5mW6vtDsdjCcsgVKdPuKdQTTh33zlFrrHb/pq2L1TGWhG2/InAnn/cNBNzaUbVTTp10CSp4dcTBzJWLiLnMDtClfr0IpX9m08C5IBrxak2blcilcYhNxV2CosuaT8KAe+fPibpDfBPnbCkSH4cEtn/e++x0a8mCUnEtkrkDLOIsZpTXeRvpfbsAK//5S5xVGSBhYRtsdv4ct+7Iq60cUDxFtpTabg24/QWHrgur/lQcLy0SX2H6q0E43CMXqD8K8C2y3QR+CfwJnySb7FRQ1vAaSNcNtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yoS4i/HTWpivTh2WPc8ozMiQmu1FdsIyDIAiTxyswbM=;
 b=CEE+XqfNJX9SLOKwWSqljOuHNBCnCBbizNYf8ZnrF/N2JFDVA+fZ22CvVg7f43iUHYLHpL4ReHuRHyOmvu06jezbzPoLlBP+FkFvw3NdCBDTmeB3NS7zr8tdaLs1PVLQrSW/t//Mjz2PJCS0fWTqEdD5DlY9KXDA/copTxrtiw0=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by BY5PR10MB4209.namprd10.prod.outlook.com (2603:10b6:a03:207::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 15:44:54 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9253.018; Mon, 27 Oct 2025
 15:44:54 +0000
Date: Mon, 27 Oct 2025 15:44:52 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Nico Pache <npache@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org, david@redhat.com,
        ziy@nvidia.com, baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
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
Subject: Re: [PATCH v12 mm-new 02/15] introduce collapse_single_pmd to unify
 khugepaged and madvise_collapse
Message-ID: <0b1d81bb-1d7c-41ab-8cd4-bbd8fa8d3785@lucifer.local>
References: <20251022183717.70829-1-npache@redhat.com>
 <20251022183717.70829-3-npache@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022183717.70829-3-npache@redhat.com>
X-ClientProxiedBy: LO2P265CA0127.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9f::19) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|BY5PR10MB4209:EE_
X-MS-Office365-Filtering-Correlation-Id: a326b8b9-e037-44e8-5be3-08de156fc645
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vTjBJc27NXH4qoqjVn3Nv6nqrh0Fdmu146N9oiAjQWGVyCIqtET7pmydZyvm?=
 =?us-ascii?Q?XJp9SJn/3SytNrJaTGQslZgdQNy0SkDTlIzmpsrMkABeFWbOs67DlgaPOb4Z?=
 =?us-ascii?Q?CwdhPZs52sekIz0jnQRad85R5n34hiJtpEDubUNOs/OiybRx0dsdfUGp4tHk?=
 =?us-ascii?Q?jxQHK5kAvyh0nKA4mv9mzwL9YqOIQGnuMpqrvtVIlM9VwwG+apYhtpeSNWnZ?=
 =?us-ascii?Q?vZJZlPXSqj+uYGhSqBJGlbr2TwgjJZsO+1mfWXBhmry7etCPysfuqlVcN+nJ?=
 =?us-ascii?Q?s/5uZPNpcBwS60yrgAx9i1oaBz7SJ4rQ+kshCV/X2MfLOTIMmCeW4/GIJ2YZ?=
 =?us-ascii?Q?tDQmfhGjhX9JTdg5Ksa49yP1VnxJlmUgfbs58zv1eBwEbf7s25uaT40xjfkh?=
 =?us-ascii?Q?8P39z5q+Cnb7xckQ0wBpBT+QZrdTnILCVxRks/1EzYzYjreCbuptRf43Hj+q?=
 =?us-ascii?Q?Q7xEsbc8POObrfsPWjphH9FAfZna2j/qkf7X8PJV5QVS81JuNvn5z+PvDADN?=
 =?us-ascii?Q?KbHryBIzgmAz1pC1GxISoSmXsN8t5cqV5dmY6B+xvwmTmQOgY7Vx3E1apy7Y?=
 =?us-ascii?Q?4o148VnnY0gSn2n1CSUDUOEO7jlO+pbQEvhH62uwH0DNGDgb3Mba+cJanPt8?=
 =?us-ascii?Q?s/WEdTpqMIU3V+ZflF5GPNHLZpmGvSO9MgjO6/IxHqLkSXjyDUziCQo5hJGN?=
 =?us-ascii?Q?uLxF2VJxg/ZbRJZXTkSARs/jMs5CuDJre4+g99xLM3v/fnsSbiO2901RNLyo?=
 =?us-ascii?Q?r0e3kav39gzuHd5drjXK3mGgkfJ1mlIf52JRSNkxA2uYbOixG9smcIfkkvrF?=
 =?us-ascii?Q?4I4hSAdPC4U06S+3quO97CtcWDdndtIkpbzvJSEyS8FMxJG7tnCZVOKVoSB1?=
 =?us-ascii?Q?NqbV4FyYQRqZmX1m7DZYExk0vM1c9Wx0BkcYOnZedytmdgCop2E+zSLo8kFN?=
 =?us-ascii?Q?0msjxBMS16lwR6SDOAf78aoj4XTJ25cT5hFC2Nb6DnhA99t3S+q8B2Y9Qk0O?=
 =?us-ascii?Q?39XkoIZzN8icuZRDigJcpkpberEuWwVy4hEfxn2aZm65wkzvpiEatXQtrVoe?=
 =?us-ascii?Q?3lNrDc1iMgNGJhHuuGT118PouvWhqJiG2H1/pjFniM8jbJ9iGjtB7oPRgutT?=
 =?us-ascii?Q?pSMS1INZR0qvdcMAEWlK0uiZcOgKpoUHfE9hcFTUvRjcUsFoiGqXh8NA0dr4?=
 =?us-ascii?Q?+86Gple2ZwSGyuyy5HPpbG3YofKD+LaJAbtjpDoWYMv79ckrRgJWJPDE0rxt?=
 =?us-ascii?Q?sbvkELB0XiNjFtdJ7IEvailGhrnbql3NnoFsuIfPmRVaADOxJxSDBu2o0kBt?=
 =?us-ascii?Q?ndbPQ7MeHsJ40pFfP2pCTCPwFTbR381U8FY051NiidhNgY2mBZQYr0d2TbqP?=
 =?us-ascii?Q?mGNvVeaemZKe3Ftx5X6P8Uwo3tBiv9BVhHyJMRPxWrJULPmh74cR9m17VVcZ?=
 =?us-ascii?Q?jaz6wqbz6mkb0trTFY2Y8y6UGTyX7r3s?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WGpw+4wevmbs+lk2ywdCi69oky/y0U6m1GgeRWTchdI/x0twGuvJaftyS5q/?=
 =?us-ascii?Q?rdHo26CzlxVnemPf5pMDZ+1scJbFVJ/3XG8KxV6mWxL2qfkUzwR30gvax2hr?=
 =?us-ascii?Q?cbJR7LzuirZRy/ZY585IaHye4wxC85PTMkZy9wkydBFMqYkYLMiHETgypYCz?=
 =?us-ascii?Q?vmxWk/mAleBU/vqnBjYJm5Zt6jl/Vs2ZxxL+AbSsWHKBjMW/jVYqALb6tXNa?=
 =?us-ascii?Q?ktgQLKOdJYXmrkb1OCfKBzZITfA3UFOYnbVha0H3TUWRnbhwP38qQTRdHXlB?=
 =?us-ascii?Q?Q0udDmJo+POpv3j5JG1kayUrfFGWwlrzXF6z9gfePVyYK9I4ADyGBWN1J3Vs?=
 =?us-ascii?Q?2jpvmvbzE6B9sLzPQW7htTPCawJx7yJ1Q1LyDQFqQ+X/S8j4rM32NA0+DZmh?=
 =?us-ascii?Q?9diklmTezgkbydimgGci+KSdcmVTf1RgFyqi+btiqmtvucYSUl2Qb6Cnmtdy?=
 =?us-ascii?Q?B45XV2TfWWYbCJ2yTMkDAsFsQKRC6Lrezx4V6iqefVVwtGtqPYYzE17llZeM?=
 =?us-ascii?Q?k3cUS9lX47LujHKl1bfWobMtnKaNjnfTb4Gz+knUh2UE7e8TXAyNxGqyWcB2?=
 =?us-ascii?Q?EO84Gpn3EQolAEzpxFXXhsC+Bde8F4x05MX5SGZ2vJN/kluAJQ/vrMUkzic+?=
 =?us-ascii?Q?i4ivGepy/DCKbJMIa9WfpirREPpTI6Mo90tVkEVpwb0Ll32o4o4g+WE6D7q1?=
 =?us-ascii?Q?3jv0Rw6rVeVbO5QrDhInVb1UEuSpYCFvtfgDN5AZRtUofU0khYM7iVFnICX+?=
 =?us-ascii?Q?+lrkYz278a/SJLmWenhk/u2Y0Miz3/55mdetmyDm7MFH1Q6VNSTKW5EIfGBp?=
 =?us-ascii?Q?bi46hEOncCQTP6lA5lFZ5XZvmMv6Bg7/oC34fXvFeRbQ8joX/zn0Uxt/KlFJ?=
 =?us-ascii?Q?gfZmpuK7YJdkNJWeUNmp+fWgadZ2lAA66VYTCkpw9PQTtZUc09rXYQ8SSvYU?=
 =?us-ascii?Q?yvSQYR9M+n3RjneejQ2bsIFIUkUlJ5NYDi6fYm3QidybybUGcSDAL0QMoXv/?=
 =?us-ascii?Q?fhmi0Tyan17Jd9Fn8uSPg9N1ufQkZhxyAFF6XtDNnSELHecGo8C132Z5mkdO?=
 =?us-ascii?Q?kyWzUe4pKGOynq8eW1JZZZFXb9t2WzMjWJTaDDbKn8Jl9hTxWKHplzSarG+W?=
 =?us-ascii?Q?/5++5kmOQbg9eUUm1kFBEsbquS5g8WMTtbVEUu0Eb7Vhdbd/J2wn3V4n41eS?=
 =?us-ascii?Q?lMG9TZbHrPCtQo3aYxbh1rXpU+Xt3OV60UGprEQBj/XGU+esd4xsbTtrpjX1?=
 =?us-ascii?Q?XUHP7LzQ1XI3oq3liXqtWAf29z7Nkg+atNulMiLUowPuo3WAZPvilhlmCDwU?=
 =?us-ascii?Q?BSTmikQHCRKO+9NdsRgVSlUHhplwgeOtSKPtjKWT4fOnWqDPYCYZYtotGvaR?=
 =?us-ascii?Q?Ux/g5MEDOdyeUTJtvBmpdgfTjwFPqYDR0TbCDOuwhBmWVajoIWtRNwIFUcdy?=
 =?us-ascii?Q?0d95SkuEmE5/YhK+WlTvrehKFzxMCt/8eU9NuwnGGp+R6U8Jn+yocOSkrHjn?=
 =?us-ascii?Q?FYUJIys/t61L0YCaw+SF+LVM14ChI8/lKAdk9DL05ygBKXDC6VH4H7z9jLbD?=
 =?us-ascii?Q?CNrOy2SPXYiqoM90sp8SjKgsiwYoNjB9Uo7FlSPKASh387AmCz5qzCs/WMjB?=
 =?us-ascii?Q?PA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wLL+1cYjixNUy5O7KoPqwZ5GHAOOV8n3d9MzuzS6gYw9WQjXL7q+RaZF2WeRgTg0ufMVwfFzF+fF5HUycPpfjozfXAQqzQkFkPJguA5tUOF/cwakgv+5buInrsN5Ylc6H/fZe1N5vWCY1pEZ2jdeCy4go3MWyXKCWuLuNpSeQvk4h1IINlMOIrmwc9ChLwdAELgMktVmatGzDruSswb8BZ9U4MP2xKkcWm7GMamrOokXERKVx0nwzWxOzqyIXPh36SKQQaJKGEVD+GnD6+8AyHzedyObkRZIgBjzpBGltS9q/+eD0uWt65DKFoPC3MYrewDRK3yKSEwSINEXDYlH5ngJ7Uf+JBfBSQuHI9Wm+/xiLdKL2QgqMLGyJZaibfxwZUhkDgYh6r0zJy2Wsm9eyGJCAc6/NTB1m1jNRFhG1YQqAynF9J7hnBsCNCXNmJbSyBhcS+P/4D2fcjXnQthtASfQKY232ahgi8b9HJfWZxX0KYFfmG0ok5e+pZ49YuZA35gG6O3t11ZquYk5SO9t5ScEYZAa1zZH5TTdH1Bxg5inps43NXTzWdTpZZ6qzWwT2CbaaapZJE8zt1FqNce0aF4WoTbgHWUYP6SORxjsM3M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a326b8b9-e037-44e8-5be3-08de156fc645
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 15:44:54.6841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bkt+Vz7bTqMhURP4k7BqOYAKfxqo6pNzoG0GO4/kV0Jfzy274Vu2ymysDOyR+da2Uksf05RNsUBLZ3X9E/gwD5LysHAoecQGN38GKrg/VIk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4209
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_06,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 phishscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510270146
X-Proofpoint-ORIG-GUID: JrY5_ZSKwtReMmOH3T4Xf6I61ccHp52d
X-Proofpoint-GUID: JrY5_ZSKwtReMmOH3T4Xf6I61ccHp52d
X-Authority-Analysis: v=2.4 cv=Q57fIo2a c=1 sm=1 tr=0 ts=68ff937d b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=SRrdq9N9AAAA:8 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=bzb4xGIMocYBTCwEUoAA:9
 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12091
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI1MDAzMSBTYWx0ZWRfXxPGVUqg4/S2l
 4OGmHmsmUvOi7PbexZciFpcYsZK2EVNIcR83vgfFVwzXaMLZU01eMcMnIF7HIPB+rSiJdtYIOfr
 OZM3ALg4w9XiP3pSOa+ZfFAymi/crkDB5ZwR11Tknd6QBd1aTh9rKzje0pYnRiIwW/OFjr8ufEb
 ST2II3MfOLCiUE947A8KDZbJwm0N7SU8w3DtbCebGESgOxuGH3AOrZKTd9lpYFBtjiZVDmjelWB
 ZQSQHH1d6zVTzzNKSH+CxexzHQlhqU7cCuTHtNGSz9o4dYmROd5PHDmqXwbvfa8kQThb+JzEo5N
 jJICnuaUMI8PqAVyAJ69ERoF2zBRyYyXmPWhShWsuXqW/yBcOOXkDRP/nzC0DnG9rPmvn9KNLBQ
 dviGDSzqPtK69J0z+tdb2wVemlSzVPqEfpKihaJ4zUf4QHRppAM=

On Wed, Oct 22, 2025 at 12:37:04PM -0600, Nico Pache wrote:
> The khugepaged daemon and madvise_collapse have two different
> implementations that do almost the same thing.
>
> Create collapse_single_pmd to increase code reuse and create an entry
> point to these two users.
>
> Refactor madvise_collapse and collapse_scan_mm_slot to use the new
> collapse_single_pmd function. This introduces a minor behavioral change
> that is most likely an undiscovered bug. The current implementation of
> khugepaged tests collapse_test_exit_or_disable before calling
> collapse_pte_mapped_thp, but we weren't doing it in the madvise_collapse
> case. By unifying these two callers madvise_collapse now also performs
> this check. We also modify the return value to be SCAN_ANY_PROCESS which
> properly indicates that this process is no longer valid to operate on.
>
> We also guard the khugepaged_pages_collapsed variable to ensure its only
> incremented for khugepaged.
>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Nico Pache <npache@redhat.com>

Thanks, this LGTM so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  mm/khugepaged.c | 97 ++++++++++++++++++++++++++-----------------------
>  1 file changed, 52 insertions(+), 45 deletions(-)
>
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 6c4abc7f45cf..36e31d99e507 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -2370,6 +2370,53 @@ static int collapse_scan_file(struct mm_struct *mm, unsigned long addr,
>  	return result;
>  }
>
> +/*
> + * Try to collapse a single PMD starting at a PMD aligned addr, and return
> + * the results.
> + */
> +static int collapse_single_pmd(unsigned long addr,
> +		struct vm_area_struct *vma, bool *mmap_locked,
> +		struct collapse_control *cc)
> +{
> +	struct mm_struct *mm = vma->vm_mm;
> +	int result;
> +	struct file *file;
> +	pgoff_t pgoff;
> +
> +	if (vma_is_anonymous(vma)) {
> +		result = collapse_scan_pmd(mm, vma, addr, mmap_locked, cc);
> +		goto end;
> +	}
> +
> +	file = get_file(vma->vm_file);
> +	pgoff = linear_page_index(vma, addr);
> +
> +	mmap_read_unlock(mm);
> +	*mmap_locked = false;
> +	result = collapse_scan_file(mm, addr, file, pgoff, cc);
> +	fput(file);
> +	if (result != SCAN_PTE_MAPPED_HUGEPAGE)
> +		goto end;
> +
> +	mmap_read_lock(mm);
> +	*mmap_locked = true;
> +	if (collapse_test_exit_or_disable(mm)) {
> +		mmap_read_unlock(mm);
> +		*mmap_locked = false;
> +		return SCAN_ANY_PROCESS;
> +	}
> +	result = collapse_pte_mapped_thp(mm, addr, !cc->is_khugepaged);
> +	if (result == SCAN_PMD_MAPPED)
> +		result = SCAN_SUCCEED;
> +	mmap_read_unlock(mm);
> +	*mmap_locked = false;
> +
> +end:
> +	if (cc->is_khugepaged && result == SCAN_SUCCEED)
> +		++khugepaged_pages_collapsed;
> +	return result;
> +}
> +
>  static unsigned int collapse_scan_mm_slot(unsigned int pages, int *result,
>  					    struct collapse_control *cc)
>  	__releases(&khugepaged_mm_lock)
> @@ -2440,34 +2487,9 @@ static unsigned int collapse_scan_mm_slot(unsigned int pages, int *result,
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
> -				*result = collapse_scan_file(mm,
> -					khugepaged_scan.address, file, pgoff, cc);
> -				fput(file);
> -				if (*result == SCAN_PTE_MAPPED_HUGEPAGE) {
> -					mmap_read_lock(mm);
> -					if (collapse_test_exit_or_disable(mm))
> -						goto breakouterloop;
> -					*result = collapse_pte_mapped_thp(mm,
> -						khugepaged_scan.address, false);
> -					if (*result == SCAN_PMD_MAPPED)
> -						*result = SCAN_SUCCEED;
> -					mmap_read_unlock(mm);
> -				}
> -			} else {
> -				*result = collapse_scan_pmd(mm, vma,
> -					khugepaged_scan.address, &mmap_locked, cc);
> -			}
> -
> -			if (*result == SCAN_SUCCEED)
> -				++khugepaged_pages_collapsed;
>
> +			*result = collapse_single_pmd(khugepaged_scan.address,
> +						      vma, &mmap_locked, cc);
>  			/* move to next address */
>  			khugepaged_scan.address += HPAGE_PMD_SIZE;
>  			progress += HPAGE_PMD_NR;
> @@ -2781,34 +2803,19 @@ int madvise_collapse(struct vm_area_struct *vma, unsigned long start,
>  		mmap_assert_locked(mm);
>  		memset(cc->node_load, 0, sizeof(cc->node_load));
>  		nodes_clear(cc->alloc_nmask);
> -		if (!vma_is_anonymous(vma)) {
> -			struct file *file = get_file(vma->vm_file);
> -			pgoff_t pgoff = linear_page_index(vma, addr);
>
> -			mmap_read_unlock(mm);
> -			mmap_locked = false;
> -			result = collapse_scan_file(mm, addr, file, pgoff, cc);
> -			fput(file);
> -		} else {
> -			result = collapse_scan_pmd(mm, vma, addr,
> -						   &mmap_locked, cc);
> -		}
> +		result = collapse_single_pmd(addr, vma, &mmap_locked, cc);
> +
>  		if (!mmap_locked)
>  			*lock_dropped = true;
>
> -handle_result:
>  		switch (result) {
>  		case SCAN_SUCCEED:
>  		case SCAN_PMD_MAPPED:
>  			++thps;
>  			break;
> -		case SCAN_PTE_MAPPED_HUGEPAGE:
> -			BUG_ON(mmap_locked);
> -			mmap_read_lock(mm);
> -			result = collapse_pte_mapped_thp(mm, addr, true);
> -			mmap_read_unlock(mm);
> -			goto handle_result;
>  		/* Whitelisted set of results where continuing OK */
> +		case SCAN_PTE_MAPPED_HUGEPAGE:
>  		case SCAN_PMD_NULL:
>  		case SCAN_PTE_NON_PRESENT:
>  		case SCAN_PTE_UFFD_WP:
> --
> 2.51.0
>
