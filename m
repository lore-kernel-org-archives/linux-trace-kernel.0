Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB1D3EDE4E;
	Tue, 12 May 2026 17:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778608781; cv=fail; b=Qrovcyl1m7mPAPEPy7pgi4nVLxmpnHNXhaGCFYOoDw2pLng+zaOazHrRIaQu4zVQ7cT9Ri2V4rg0V7e40JjekXxTuYcR28mCxGJYjkylcG3MyEOqwLW6KhLbyn7lsJZujqtsdbnxNPYdfuVlU/655bkm4zAfniJsuDDItNHQixk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778608781; c=relaxed/simple;
	bh=jgp1kECoIQg4/RBCbF64UofKkr/iDVVyMKVwvMG9lp8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HusbeffptF33WH0xRSRsAu9ADc/wlOTbDIJMWhcPxr6OOeKxNGTffAk6K9fIFir5R5w98ZEskhjPCfSFzMloEF6GtELeU2Pwt29adVdfh9MXfhj+OpEatpGMGa/c5WzLrA0KSVM+U0f/u/2GtMJUsdpeuCT5nEUqKh6+g6gJQ3U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PRxTghjd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HPoDPapp; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PRxTghjd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HPoDPapp"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64CGffua969039;
	Tue, 12 May 2026 17:58:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=xl+nSpNeaLkwU1RllL5k+Tr7yUwP2mI/d8uwDY5u15A=; b=
	PRxTghjdB1Qh+RJh290tBtpvyyNxNStYNwd/lRSy5VIKdTFtIfsS3zlATFRq6co+
	iFxATlTAn1eASC5G1IOOPCQbEh3XvToa+r4AsnIhqtU4+sPWd8FvY2O7coiDxlHi
	Be5whOx6XhdJgzCqJNMZXHrHo0dUtRkVzyvtrf2ZaVHsrG5UlgtrotOGMPiiaHLK
	OfC2ShZQTTbAApYvp7rEfMtKlAldn29/NrU2iDbzxKa+I0sRAQMWKeLaI+l2GemS
	YzFzXDYeSrlsNTCbFH7qUncpHta03vgENZkNPHa/mqxoIaz04obq73M6dkDYf0qr
	QCh7AhyczS77UeKcOBXkBA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4e3nv39qay-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 May 2026 17:58:18 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 64CHpDSl016528;
	Tue, 12 May 2026 17:58:17 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012067.outbound.protection.outlook.com [40.93.195.67])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4e46rsbgpp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 May 2026 17:58:17 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g2ws2RDD5827IQW/9ZckSr4mexHrsT/HUEhvwgPRBBNCi9hn6M0cKMJZrTPAblbS8h4ySBbmuAZZCcisFLd95AZTJEp9lvNPUE+flU7JHjAaM3Nqg3LJwPoYznIcm9tGTm7OcRz2TgX5V0amwsoRA5MpNuEyR1g2Vs60PnH9UeVDCB+DKaRBLikB8xKgb/0Xqby/6DCmKAQ8o05Yo/cSI+IsSC+jq/EzrIrfejonmuv5Hr1fCq/qF/nBO3zb+pXtrIu2/UVlmGHufHPoKPXt2ZAOOjADduPI/D4QuHI47Yo4vg33Drou4UI3ELXlCYTNpt4F14RMqlqtVwZdAfkOEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xl+nSpNeaLkwU1RllL5k+Tr7yUwP2mI/d8uwDY5u15A=;
 b=wLmkIanSRUwmDQP5IOwPsugtuuuGr4cZmRmyOIkHv/VvGVmcvz5Ez8Twhsh2SEOjFaMQ3qgjMN/6s8znFfxDWw3ji/O4MDVUh0egSx1aIFcEq62VkoOGRKNTl8wukVseUVloZPHAIzbChHbhuMR9jCfC/MBnsh4UOkymPibzUibeFz2plc/WqTX9gqnPWC0wGp4yhLwLEsXHtEbNP4pKsWcXdjZyN1foWWP6XntcnkFNKVe2TX6Dlxa3sMC+OOwehArh1lpyCQHypjr+JULyuuKQTxDgIwOT9vrHIuGLIJs3D0xBDUbf4IYU+D52NqSaukCRygA8bPSjFXJOVZ6gWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xl+nSpNeaLkwU1RllL5k+Tr7yUwP2mI/d8uwDY5u15A=;
 b=HPoDPappU9fDKClH7CMwUnBa45eRwt1qnixNXNXeQv4FN4Tgtq0RZH101eVd1WFptvZAGxbZTost4Zby68r0iXioo1LoM4P9yowBRTLpdVxcaa/0iLHWM1hfwwZKH3KUeQDy67FfC38caesaPQ4i1RrebiiZKYu+FiSFyCvnhmQ=
Received: from DS0PR10MB7364.namprd10.prod.outlook.com (2603:10b6:8:fe::6) by
 IA4PR10MB8755.namprd10.prod.outlook.com (2603:10b6:208:566::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Tue, 12 May
 2026 17:58:12 +0000
Received: from DS0PR10MB7364.namprd10.prod.outlook.com
 ([fe80::a4df:c903:e1aa:322f]) by DS0PR10MB7364.namprd10.prod.outlook.com
 ([fe80::a4df:c903:e1aa:322f%3]) with mapi id 15.20.9913.009; Tue, 12 May 2026
 17:58:12 +0000
Message-ID: <816e3d8e-22d2-49a4-92ae-981568f38792@oracle.com>
Date: Tue, 12 May 2026 10:58:09 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/4] mm/memory-failure: report MF_MSG_KERNEL for
 reserved pages
To: "David Hildenbrand (Arm)" <david@kernel.org>,
        Breno Leitao <leitao@debian.org>, Miaohe Lin <linmiaohe@huawei.com>,
        Naoya Horiguchi <nao.horiguchi@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Shuah Khan <shuah@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Liam R. Howlett" <liam@infradead.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, kernel-team@meta.com,
        Lance Yang <lance.yang@linux.dev>
References: <20260511-ecc_panic-v6-0-183012ba7d4b@debian.org>
 <20260511-ecc_panic-v6-1-183012ba7d4b@debian.org>
 <9504c193-8c01-4d03-8f62-c50fd7fbdbc0@kernel.org>
Content-Language: en-US
From: jane.chu@oracle.com
In-Reply-To: <9504c193-8c01-4d03-8f62-c50fd7fbdbc0@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0094.namprd05.prod.outlook.com
 (2603:10b6:a03:334::9) To DS0PR10MB7364.namprd10.prod.outlook.com
 (2603:10b6:8:fe::6)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7364:EE_|IA4PR10MB8755:EE_
X-MS-Office365-Filtering-Correlation-Id: e8f29554-58ee-4817-beaa-08deb0500869
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	FNwjhNkPFXi24ccwmgoAc4E1f4XXdXBPVFv+mpgUvrt+ur9xG5XyYtQG2yHGXUt1p70ZtxM0ZRVhrmqoDMyyEDuC5tHvw5aI1Ol3lHZzkF7N98aNyhkO6Mf/XV5m9OC+1ew5GGnvYATNjZFh3SO04t1sTcWZ/qO0LqM7lNoqUc//CxnFVf0J77z1Vrs5mLVhhTKX5E0HreW2vr9RgpIALXP7nHXHXk7FV4C7CIkj5/1TtmpQzhoQ+GikorGil0b0pVbKEA51C0q21hx7Cb3unU35pp2rHFGYPwXo1NX4U1Y6lHPl6KSe4uc+vvvsAum1CSbjbQPHAv6KPJ4aDfi4dQFO3g7YT4qA7gosOurm8Rf8do4uUQkZ/UvkEVcSf0JYTTPv9Nl0n34vbwWFm6PmTsjaTLWY6rRYpWbMgCAO39pYRZgtzYX3OCgkD+faaA1EejFWOyRoEpcP2P8eJUdHqMLxS6bmggeFcGOqLZwXKc9tcNMq5YrJFsM4MA5aQoib29sddQbXV0WH/i+k3pWWfYlgCtK9DPXwGQgs+hQeOVZx+V6kojDWVEt+W6ldAmJWnlrYkZulHXYbzmc2RjMzB/hkKoKhCT2ErnP2i/F+Q74ue/8MwzK4jbi5yYWtzodBHoWXeWfyvECu3ScRSnA1vlitbwJGFL8ODj81csaVmNserkh1y34bzExbo3bXq4uzogI+y/Asrp9DPxcDU1lv0OIUOPgAu/aSE3QfvBsJ8y0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7364.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aHI0cDFSK2VhZTFhYnIvTnd1UTZ2S1JzbzkvemVBVjNaWit1eVMzNXVoNzAz?=
 =?utf-8?B?RHh3aFFUUEd2TlNOMnlPbCtNVFdxdGNVY3YzQUg1R215SGFidHdhd2pUNlNS?=
 =?utf-8?B?RzBoQVpEelVPYU9Jd2dqV2huN0JtNm5vSzlnRjNhY1JSNS8ralpiWTl4TEFE?=
 =?utf-8?B?Mm1uaTdBQVFZbFRpV1NtTiswRk4yMEo0YzRRTVVMNFpSN2dyNVU2MmI4c2Fv?=
 =?utf-8?B?cUxBWlg0d0hkRXNhV3psMFVlNmRoZTNPb3BCSGI4cjBvM05janlMM0JFMDB2?=
 =?utf-8?B?dzgvRDZaTndsOEQ2UGx0UmZzOUVKdlF4c1dKMTlyT2t2TE96NHp0aTBkaE5r?=
 =?utf-8?B?QnVtOTJLOTBpS29Sd3BKWW9DbVpiNThac2w0VzRDNEMyallrbUxuTllTODRn?=
 =?utf-8?B?MzQwc3dQTExSRWd3dXlNV09VRHRoZ3g4SkhQSzZlNDM4LzFhTkdiTHJsZk5F?=
 =?utf-8?B?RUwzYnRua3lBSFRWOFphRmdWSWVPVkEyb3p6TEZhY1FTbnEwVGtxcXlrWUpS?=
 =?utf-8?B?U3ozWjdlMllvc2xoTm14UW1oN2lIejRYRmFVbmQySVFFVVVHNlBPUytoK05V?=
 =?utf-8?B?dDZkTjIrK2VhK2IxUDBwQVpoSmErMHo1cFU4Z3hpNS9IekJya3lkN1FPcXFB?=
 =?utf-8?B?eGZhazRIRVI0N0dzOGJKUGpmVkg4RjBjaFhFMEkweTJGdnJTWjlmQ0lKcnZZ?=
 =?utf-8?B?NEx5ZDM2ZUNTV3N5R24zRGdINjBwc2tucTFpT1Zrblk1eW9GRmRwNFVQMERW?=
 =?utf-8?B?Y284Y3N2dGhWS1FVRzNuYXFJUWlTemRSSGVaa1JUdFA2azhVT3VidDd4QWNN?=
 =?utf-8?B?U1NJR2E3WlNsdWJ5U3NxTEsxVlhpSE5vRVZ6VmtuYWdmMXpBSS9ySWhzblcx?=
 =?utf-8?B?ejJSbDRBaTFSOHQyRXFGT0sycXVXZktrT1h1T1d0NlMyNW1oY2xjT2dTeHpk?=
 =?utf-8?B?YlUrSFpPb0xqby9nWEdxWklIUHRnbnByU205NGRoZ2JIMWlTRzZxVTE5NWFQ?=
 =?utf-8?B?NnhRZTk5TnAxWXp5dHdhZEVDQUVMeHFwak5ITWdvRUduSzBKOEtxMXpnUW1Q?=
 =?utf-8?B?b09kMndDVnVXRUd1WEE2RlA5aG4zNGwxZ0ZHTGNmUC9JTUVOT2U1NlhiOVZC?=
 =?utf-8?B?YTR6bU5xb0Z5dlBvcXpVM054d05EdDVBangrV3ozU0hnZHpHZ2tVUE5MNDl4?=
 =?utf-8?B?SjA0QjhXMzRCTkE1MTBSTzIvZTNJTVdiQU9ZaEQyNWR3UktjUlYxSWw3Q2Rl?=
 =?utf-8?B?YUsxOWtoVEpBaSsyMnpUZmNhdTJUNTQxSDRya2srMFJBZnkwb1pIZXdyMGVW?=
 =?utf-8?B?SG9yUjRIYUwzd3MxOUNhMXIwUFFuSWExajdib1RDQmFOSXg3Q3RNb2ozT1dn?=
 =?utf-8?B?dXExTDRpT3BGYVRpd1JySGxqTDJtVzNLWHRnaTNtQk5LWGd6cFp0TE1EajV4?=
 =?utf-8?B?YnV3LzFRUVBlSlBVa3ZLeC84SnBXdVkya2E0S1llMGV6Y2JOem1tQ3pmVXJJ?=
 =?utf-8?B?YmVkUDNPeXdXRzJPMlEyM1pLMEZlVFYyM2QrbFZpMFV0YWdaV0NhU0ZaQ0Zm?=
 =?utf-8?B?NnBVV25ML2tqeTI3NmkrUUo3LzhSeGhXcDVvam5Od2NkOFhwUHQ2b3dxc2gy?=
 =?utf-8?B?RlB2dFpRc1Vpb0xWdFlsTTd3dmdIRTBaMzk3SEFWaGJRL0VGSzc3YTBuV1hp?=
 =?utf-8?B?WTZoc2VMRTFtMVIyV1BEU0xBS1dUT0x2OFByMUJvQXlieWZJalZrSUs4Z1d0?=
 =?utf-8?B?d1J6RWM0K3JOSVFSdGlubkl2NHlHQzJLa0VKdkNBVkZpd1FkRnVlcWhsVGxK?=
 =?utf-8?B?LzB4U0kyRC9nUWsrVk5aeU5LZTAzb2hsNURpWENRcEVNRWJtbzlOR29heEZq?=
 =?utf-8?B?SlBJQVdjSGt0TkRsL24yZGViZTRmMHFSN01HU1hVeGlSUWxvS0l2MUErTTZp?=
 =?utf-8?B?SGxvQnV6T3FsOGRPTWs4aVpFZm52UUM4NkFPd0x6a0VhTFYzc1ZrdWQ0a2oy?=
 =?utf-8?B?MjBXdFpEbFBORFUyMzZKdDZEVFNyeVNBcjcrTlZXemJhdnE4bHZtRS82SjRt?=
 =?utf-8?B?UjdsdktTZTF2Tm1RZUJUOU1hSkM0OFp6dHhaOVdhYTQrQVBUb01KQVRDV3VR?=
 =?utf-8?B?d1JrSWNIQlByQ0M3bDZNWWY4bVp4ZlVjblYrR05jV3EzeEgrZ2NCQVd2cmZI?=
 =?utf-8?B?YTVrZDRjKzFJWWFHYWEyN0YwWWR2YWo0QVBRdkdDZ0RoQ05KY0FqajFrOEhU?=
 =?utf-8?B?S0RHaUkyVG15RWtvR2xqT2dSNk1GbG9VZ2VMVnd6TWovZjF3NFd2TURHL2Nq?=
 =?utf-8?B?VGlCdGh1dkhUc25PSVlJWnR0OVQ4NGZJSVcrQ0UyVFhEdThwazlidz09?=
X-Exchange-RoutingPolicyChecked:
	ni62dckbY0U4OrgzfytynP1Dipwt3Jp8kYPSYcoXyyZXgFQEbmdgJ5YBmwwFxCYcvhT+TReVXYwFLuwsaAUVVPbhJHZHOZSO0B2K8wJs90rB7w59Zxxmdu6ukIZ4Qx8Ly1QH9cWIfuGXQYkFVmWiXDWFl0xRlVtqJBkngRtrXuEupOcCoy9fBzzi3GlY8LRki7yuBsF/83/i/KzD/NDNGfEUovf27OSW4TXEGDpGGmfpUwvREGLOXWorrVeusVOaenKzvs6Na4LbwD0I1nNkiDzrWWKcuugucWzvKe82HK62zn6ZxqDXUYX6IOYh8FJFvXWyGMj2kj7heHZB9HTO3Q==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	UMwKeBcuncfozmTCFL9r9Rn1lLXOL8oj93iezyf4MJTGOz+uhS42ceEAnB5VURjrKIpqGOQ0Wl1bWDahhLJeF/PyyGKlD+THoM2LuajhUI7tR2dnZ0TZev/H+GwOAzE+z70oSkXpxsxQlyHNcj7MAYenQSr8vL+Y832Qt2Q5GfDeuCVX2TDjl35Sj80JCEtHEVewRhxlJ5RbkwW6zea7nM0up2isqQNP1C5+IjMeEIlAIGr1hgl6UADBEBqrzESKYYUXdpJ8nyF80otPq+oWniJUqkZiVm0bYkBNYOhJJvOwClfksQevLlvjlLcXWu7pCeehHqhbe2wQ9r30uCvLN0NlhY2c7oVED85ggRV1LERlBDhLPp6X472eydv+XkNuqxsA6qijpkiVd8TOBRCYx1ILkmg4aq1+zR26ZK3AjpUhaShvsvffoiTNxv+ANhqLlkKGa6qmqXv5njMeSc8JQKmJsF/VQCTr6UjhprZg1tix5NGQsrsVLZUoLuvnK4cJPAAVYY66CpXkuVkKW5AWzgx1ASwa1LG4XWvpUcuJdqvXBJjwJeT+VqnYwohqfCo7fnT5TRNwhDip/qlufyX2gKOOnmWpTiV5BEqIgsQru1g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8f29554-58ee-4817-beaa-08deb0500869
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7364.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 17:58:12.1015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /4Rz3ClByqB4eWh63bP3npex50BBRU4tXRhjp8f/uo4lP+Zovp5kw11jtNn8zDBT2rZ3khQrlhy7v7cZOLBueg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8755
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2605050000 definitions=main-2605120186
X-Authority-Analysis: v=2.4 cv=Fro1OWrq c=1 sm=1 tr=0 ts=6a036a3a cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=EIcjfB9IiI4px24ztqRk:22 a=i0EeH86SAAAA:8
 a=xNf9USuDAAAA:8 a=EW-qFs0BjTsny0NGJH8A:9 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: sEn3T-fnUkQMBTg2kx63nDAidxfz6kfD
X-Proofpoint-GUID: sEn3T-fnUkQMBTg2kx63nDAidxfz6kfD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDE4NiBTYWx0ZWRfX4ba3hucNi2Pm
 Cd0eZqoD+MtHNmedgpS+FQo5XQ40b8lH1k892j8C8SyWI6d/JZvoYa6yOSecs1ne9i9rHqV7OOf
 v0S2adcZ4/o27a/g2Rm4+F68ceTJM9P4wa7p/ScFlFJWAMVejN+DjJaLC8KdeQqM9TUGJSpG39K
 xl3k3t0bdMRptuRQfNzlq6L4s+5kz33kqJebZy0bLvP1fRr+5js2f9yBOkmot/E/LbeCnPmXb93
 IRxIxgJGB1Fe2u3wAs6srJF933PFSzpmVjzVzepoLQ/8gKDEOvhSYjSc/3WoZwaSCw7xn0K4Pqw
 RRUDHC0UcAHKqqS5kbUbxB8Md9QgRVBdtHemY2eg6tYVwCVQ9KrfI3n5qMDAyKPdIecHDqb/S07
 Im360P0kJVQzqdMJ8B+3Tby383d9GJh82RD4zDrP+jjHeFarJqXNR/phUHj7aI/xFxkbYBMLKEk
 2KuYZSleufULyBJ0Yyg==



On 5/12/2026 1:17 AM, David Hildenbrand (Arm) wrote:
> On 5/11/26 17:38, Breno Leitao wrote:
>> When get_hwpoison_page() returns a negative value, distinguish
>> reserved pages from other failure cases by reporting MF_MSG_KERNEL
>> instead of MF_MSG_GET_HWPOISON. Reserved pages belong to the kernel
>> and should be classified accordingly for proper handling.
>>
>> Sample PG_reserved before the get_hwpoison_page() call. In the
>> MF_COUNT_INCREASED path get_any_page() can drop the caller's
>> reference before returning -EIO, after which the underlying page may
>> have been freed and reallocated with page->flags reset; reading
>> PageReserved(p) at that point would observe stale or unrelated state.
>> The pre-call snapshot reflects what the page actually was at the
>> time of the failure event.
>>
>> Acked-by: Miaohe Lin <linmiaohe@huawei.com>
>> Reviewed-by: Lance Yang <lance.yang@linux.dev>
>> Signed-off-by: Breno Leitao <leitao@debian.org>
>> ---
>>   mm/memory-failure.c | 19 ++++++++++++++++++-
>>   1 file changed, 18 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>> index 866c4428ac7ef..f112fb27a8ff6 100644
>> --- a/mm/memory-failure.c
>> +++ b/mm/memory-failure.c
>> @@ -2348,6 +2348,7 @@ int memory_failure(unsigned long pfn, int flags)
>>   	unsigned long page_flags;
>>   	bool retry = true;
>>   	int hugetlb = 0;
>> +	bool is_reserved;
>>   
>>   	if (!sysctl_memory_failure_recovery)
>>   		panic("Memory failure on page %lx", pfn);
>> @@ -2411,6 +2412,18 @@ int memory_failure(unsigned long pfn, int flags)
>>   	 * In fact it's dangerous to directly bump up page count from 0,
>>   	 * that may make page_ref_freeze()/page_ref_unfreeze() mismatch.
>>   	 */
>> +	/*
>> +	 * Pages with PG_reserved set are not currently managed by the
>> +	 * page allocator (memblock-reserved memory, driver reservations,
>> +	 * etc.), so classify them as kernel-owned for reporting.
>> +	 *
>> +	 * Sample the flag before get_hwpoison_page(): in the
>> +	 * MF_COUNT_INCREASED path, get_any_page() can drop the caller's
>> +	 * reference before returning -EIO, after which page->flags may
>> +	 * have been reset by the allocator.
>> +	 */
>> +	is_reserved = PageReserved(p);
>> +
>>   	res = get_hwpoison_page(p, flags);
>>   	if (!res) {
>>   		if (is_free_buddy_page(p)) {
>> @@ -2432,7 +2445,11 @@ int memory_failure(unsigned long pfn, int flags)
>>   		}
>>   		goto unlock_mutex;
>>   	} else if (res < 0) {
>> -		res = action_result(pfn, MF_MSG_GET_HWPOISON, MF_IGNORED);
>> +		if (is_reserved)
>> +			res = action_result(pfn, MF_MSG_KERNEL, MF_IGNORED);
>> +		else
>> +			res = action_result(pfn, MF_MSG_GET_HWPOISON,
>> +					    MF_IGNORED);
>>   		goto unlock_mutex;
>>   	}
>>   
>>
> 
> It's a bit odd that we need this handling when we already have handling for
> reserved pages in error_states[].
> 
> HWPoisonHandlable() would always essentially reject PG_reserved pages. So
> __get_hwpoison_page() ... would always fail? Making
> get_hwpoison_page()->get_any_page() always fail?
> 
> But then, we never call identify_page_state()? And never call me_kernel()?
> 
> This all looks very odd.
> 
> Why would you even want to call get_hwpoison_page() in the first place if you
> find PageReserved?
> 

Ah, good point!
It seems to me that all unhandable pages should head out to 
identify_page_state:

--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -2411,6 +2411,10 @@ int memory_failure(unsigned long pfn, int flags)
          * In fact it's dangerous to directly bump up page count from 0,
          * that may make page_ref_freeze()/page_ref_unfreeze() mismatch.
          */
+
+       if (!HWPoisonHandlable(page, flags)
+               goto identify_page_state;
+
         res = get_hwpoison_page(p, flags);
         if (!res) {
                 if (is_free_buddy_page(p)) {

thanks,
-jane




