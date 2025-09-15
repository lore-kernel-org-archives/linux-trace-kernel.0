Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81871B4F09;
	Mon, 15 Sep 2025 11:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757934188; cv=fail; b=q7DzPSomtL8yj2ftl31oP2UJKg89zEleesyJ05LS62kHTNSFpphC2IuTsGo/OAJo1rR/52yWy/cR34RAB+1upz5D6O1HfcVoPz8rBT0+4uLHPhTU368FLgjQlC5djbmA4tyKypiL1y3LcYRrM711UBSvfYbYbc43SwmWrr5c7/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757934188; c=relaxed/simple;
	bh=gsd0OybZ2nOrcKViqMbAiMJcQ711BgxVoD6QSsechy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VsIGMT5MstRS6d2YOyPFNGqh2BOG/52NIe6JFek0e8UjnCoP62wiltv5kAIx3ojnz/M1bBdl2iUVELLWZeRn1vs+A351QbN5/dkEKV23FfRfRAxd6tIq21umQwuOxRl+KDgSE0qhM8lTpOxT7+PBu3x/cHtLZW4nzgQIuF2eE70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ScfbJF27; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=H2+fnIgy; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ScfbJF27";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="H2+fnIgy"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58FAtoL3028205;
	Mon, 15 Sep 2025 11:02:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=gsd0OybZ2nOrcKViqM
	bAiMJcQ711BgxVoD6QSsechy0=; b=ScfbJF275ES4kCO/W5VsC/JOgoC9z3/7Sz
	rVkNjxIjR1rSJxRH6Op8OdSEDvdfKf+7Y/uBgbyTeFT64f7Q1Gh/Qmnbmo7ArXzD
	G/FPVcdIksRpOvRsyO9WJgGpL8AvMHWu/+fc2g1ZuEVovSg5NV8/iBHClBcrodDg
	LoSzCoKQSsynS85MAW5VHllUnGu+NHiAGqzvZGw27iqOmM0Rk7yWV5D9bk+VRc1n
	v9i8YcQFefAeZur/aGb5ertZm4Qx0+c21Wn9bX4ZXC2aS80ioljZpuG3LtP8VAA8
	IghETeX3aeRYbf95ipXKCvdA0ZIEKWiTg8Mprz4+fY0thbXGoj3w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 494y1fj4kg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Sep 2025 11:02:14 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58F9BHBi019132;
	Mon, 15 Sep 2025 11:02:13 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010051.outbound.protection.outlook.com [52.101.201.51])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 494y2b41su-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Sep 2025 11:02:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wuk7+CBoBhrvGpzfvHz6c+RNnfW3q6QqJC13xDuhBD4gxM2hSFPmIEl0VCmcu8II4xoYiG4UogcpxA7QKnZh15vQIdekqliH2bqtdRSRQub9SIy4P4qZpdbW6/0bz+JtzOT26LPiGzlRWT43TyCgllpZlkLOFlJtSzyhSR+qwxw4cuFOhFgIFB8cxKkjmmIKjlT0jyhatIj/iqeXilhzJZKqIKkDY+U5qusDppl3QfwfPV8htOuGPYF667cFza2nf1VwQ4uSM2WMGIiBEdwg3Y3l4kUrf/q8o6lYUkaLINXyXsiXcSJyY4H/MJmocbVRIeVCVOXNjNIiOZBsYmA0lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gsd0OybZ2nOrcKViqMbAiMJcQ711BgxVoD6QSsechy0=;
 b=l6rVbwgnJ9Ma+HilP3qdDTRgynfBeYnKhlBTc9eM2pvFJa1gy7/ugAiVie3Jk5ZvsO/rx0tac2Z6v4u3TADc83DTzHU6hrOxVtp54tgf+2j1tNhrCpaaEtFavhygFNmYlJFYEYXuKL5aWurViD8yfpXWwuwUiEFpSuUo3YZVaohoHnL2ZljEYnqMIdFwP/I33zGvIQj3LhiizzHI7DGUZAByUyLni6lwNm7i+aHEp1h8g+i94dndljgg9M88HiaBZaDEoF2Owa8qdKQ9/KALRWz2WNG60z6oITlLWkRP5RWCBKk5yPx5I0QnF5mwyC1VP9yCR83NPaDHK9zCzbMjDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gsd0OybZ2nOrcKViqMbAiMJcQ711BgxVoD6QSsechy0=;
 b=H2+fnIgyWGwUeidzrN+epoRkjSuiMFM6yzDtJR2UjA0o212ig0rmKcPoxHI0lvlwu2dBa8kq3WK5GvKnEsjAGVUw6qxEC+H2+ou0i52Dvg76d7E3HoJ8tgjjVrQ0t6CGa1jM8E5XdJwmwqLl2JIhqeSPBvWWKqUVzhQSESVMRBg=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS0PR10MB8031.namprd10.prod.outlook.com (2603:10b6:8:200::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Mon, 15 Sep
 2025 11:02:10 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9115.020; Mon, 15 Sep 2025
 11:02:10 +0000
Date: Mon, 15 Sep 2025 12:02:06 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Kiryl Shutsemau <kas@kernel.org>, Nico Pache <npache@redhat.com>,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        ziy@nvidia.com, baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
        ryan.roberts@arm.com, dev.jain@arm.com, corbet@lwn.net,
        rostedt@goodmis.org, mhiramat@kernel.org,
        mathieu.desnoyers@efficios.com, akpm@linux-foundation.org,
        baohua@kernel.org, willy@infradead.org, peterx@redhat.com,
        wangkefeng.wang@huawei.com, usamaarif642@gmail.com,
        sunnanyong@huawei.com, vishal.moola@gmail.com,
        thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com,
        aarcange@redhat.com, raquini@redhat.com, anshuman.khandual@arm.com,
        catalin.marinas@arm.com, tiwai@suse.de, will@kernel.org,
        dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org,
        jglisse@google.com, surenb@google.com, zokeefe@google.com,
        hannes@cmpxchg.org, rientjes@google.com, mhocko@suse.com,
        rdunlap@infradead.org, hughd@google.com, richard.weiyang@gmail.com,
        lance.yang@linux.dev, vbabka@suse.cz, rppt@kernel.org,
        jannh@google.com, pfalcato@suse.de
Subject: Re: [PATCH v11 00/15] khugepaged: mTHP support
Message-ID: <ff4b6935-fd13-478e-9187-219fb612aac3@lucifer.local>
References: <20250912032810.197475-1-npache@redhat.com>
 <ppzgohmkll7dbf2aiwhw7f4spf6kxjtwwe3djkx26pwy4ekrnd@mgeantq5sn2z>
 <d0e81c75-ad63-4e37-9948-3ae89bc94334@redhat.com>
 <CAA1CXcA+pb5KvEnJJqdf1eSjaFiBZ82MRB+KDmyhj3DbiQqOxg@mail.gmail.com>
 <enrgrocqajwu5d3x34voghja7pbvau45oobxgabawrly44ld4u@ahch3xn6rtq5>
 <cd8e7f1c-a563-4ae9-a0fb-b0d04a4c35b4@redhat.com>
 <155c821d-402c-4627-a723-6f8c88a2f65c@lucifer.local>
 <ae9d88e2-bab9-49fc-a459-d7b9a8fe9351@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae9d88e2-bab9-49fc-a459-d7b9a8fe9351@redhat.com>
X-ClientProxiedBy: LO4P123CA0231.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a6::20) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS0PR10MB8031:EE_
X-MS-Office365-Filtering-Correlation-Id: 25e4955e-f286-4578-eb38-08ddf4475165
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vRsmya61CiMF5J0ofzgdpQRKDg5sYk6gA6ukgYUKlJ51XN2VbPdAzU+LtS4l?=
 =?us-ascii?Q?63zsnhUnu9m6nu95akJGzBSW8iPSRHc2Pjtc9tBdm8XYxRD55uOfdwHnDcKe?=
 =?us-ascii?Q?HjJlITKYlKpRaNeam+aG2ILfoFOvlf8a+kDNyW0nP28Dvf4Veor6Z6MfpyBc?=
 =?us-ascii?Q?mhiF9wVcqu4F7PxC9w5FDBSXDwaKzl6uZ3tMa4rWFBP8/Iv/ZziwsiuYYcOe?=
 =?us-ascii?Q?BKtRiJynpuM+wE7nM+djsO3bYzTpHiWdJmWbAJBG6hDX5HCGA1lpl6IQGJsl?=
 =?us-ascii?Q?Gf/uZ2Mqc8LIa6DEnsrryfj7IvIZUlc//KIRZzANyeArSeleV/ia39G/+A/2?=
 =?us-ascii?Q?TQbWGn/9YunTSh+VJsqHSn6uBWNIWa+c3ygGMEbpjwgP0tMDdmpC1ak1Sx8K?=
 =?us-ascii?Q?6TvdrYUKeBs/XkbzvXbavLwsH42pCB69D7xvBmIOkiwLUJZbYoSC7XPTnrF5?=
 =?us-ascii?Q?FQ/HS7V64yUANS23uhf+nAv25wTC3uxEueDZbNtdnV2GlLUy4FreP80rY9cN?=
 =?us-ascii?Q?TvUpFcCh9U9i9Cx4g0K0gbs2b1WiY5/lK92mYRJgNWub+0ymSdpNRN9/Am1/?=
 =?us-ascii?Q?tv+n/GjE7iKaaswkYL+0qs79ykK0Qq+euazjpeows/rJ/XV2NuUTxjjzU90G?=
 =?us-ascii?Q?PIiwmnIZwk/zmKMYWpEMQqwL+gMkiyFeq2twzpEwf6qh1kW9ZEpVU+2jV6b3?=
 =?us-ascii?Q?BXwJylgZodS4G7OGoYyn+TfLEpequD7V+eoCW0reoTUKiINksasWjUzR3F/X?=
 =?us-ascii?Q?WsfsyhT86qlCWosU7j0QPeIUUEUh1/r2cLascfLs2jMWOaTkdjLx4aTUrWKP?=
 =?us-ascii?Q?gybZcJM+ZNeVYehsL2xcyL70Xy1m9+rRkECwxVc7MQFCsfhI2DCaYrbu6Wdh?=
 =?us-ascii?Q?qFf1MoljS5c7Myb7bEPNXjFfg0LMmPNAKr308Eo5a2FfW4hyMli55ywti4vI?=
 =?us-ascii?Q?lBhrZDA/mSMCSPJANohmhlKDEo5iIZRSkqn1iX1CEDaIOvoAtU/oPJSUYXLf?=
 =?us-ascii?Q?yUeZoK4ZHvS7zuTXByShpmND5mSjMQ2u3Edr798Qh0yqNR2neWC2oe2UKEdS?=
 =?us-ascii?Q?VL3iZTCKP6sf/gHA/TTioj2FuQq5mcqz239KOKA9AYDYLqRo64P1/nlahgBj?=
 =?us-ascii?Q?/Siqn/HcMdibVDyXE16swywy7+YHtCNwUwUQng1EgthRrrAZCUxIITgIKS4o?=
 =?us-ascii?Q?qEpyq8XRLyPqhnrEoj0/hReiIAftg9VbwX5hOar01H1FKsWYpV3+9i6AoNbZ?=
 =?us-ascii?Q?VCCUZSNUBHnJJhs/r9ofqRRsn4ULJU3d6KJARS4HDvRVsUeSxej+C4byb4Mo?=
 =?us-ascii?Q?J/nODs4XS9ym2Gu7WIT3EGIabBtxCv82+rsEXzhpnywetyFJYL7u2EP6ayJ6?=
 =?us-ascii?Q?fboFK+9tPbm58U48hawHeokfp/mplwBetyewRwz40qArwj4ZuHFOi79F7QKR?=
 =?us-ascii?Q?ftQR9HXoBR8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ftchAOzsrVyW7htZGeLBJrjMCGzX9pxQwkcUr/+xBpNSNspTkaJheoxierat?=
 =?us-ascii?Q?MtB1CXAXwF9j/5bZDB5d8SRlJHqahXVwgFz0u0337oigdVoUIbD4Ebz/E4PB?=
 =?us-ascii?Q?7KO4nfMFTTOJZURU8xjRqisYPRAHmsvubPfQRxAT9/Ju2dqLfj8MXwaeQelb?=
 =?us-ascii?Q?iIFOulRO7AFzyaMoWWCRPH22IdsnZnPsroO52DWCUynpqIJIiThyJiRRjBK4?=
 =?us-ascii?Q?Jlgqv+vHC20Uf+3SWkMwYzAZ3LsyLYf9DwvbLRtZQCvTmVTIie53c5Zh4yM2?=
 =?us-ascii?Q?YMLvIbOGlVZ2v2oRGGXYA2dhm7dTw6/gdvt8VcKGGZzSGLBaar9M+1VPOEeA?=
 =?us-ascii?Q?2M4x/iQ0iDT/X2+rjcwksq0RBKnjI0BEuLHkZuS0z2NrAsEmYUOpfd1QpQXu?=
 =?us-ascii?Q?kI/J2O2t/swVVqM6ptCx0I6ZjuP4dNnT9qxbudmKsqUtVgHBFLewjiyhtb0a?=
 =?us-ascii?Q?ZYgPZC0UpbaONL5Q2G3Tm2rdJ6M44YdyTT7HIJfmmRXIC4vs9N80zigMP/lY?=
 =?us-ascii?Q?8yR14aAMCe0uh+1hYCU3cYxnwPBx2SYHb4TIAYSdJe+EAXFMs7YNMf74RLpb?=
 =?us-ascii?Q?1hmuSvxM2Edt4KR5lHIO70RNqDovBm9zBYXWuCj5lEe2z4Z9ViIFEh4Kc5Kw?=
 =?us-ascii?Q?fwar/S9hwA7ezKDRgAL4iskYoQ8qH3+39B5i8G671NpPf1+frNN/oMSxnS+v?=
 =?us-ascii?Q?I03Ac9PEj+nkDMTS60i2Yaa8MhUeaW+gHwb4n7TVzZHPcTII/cqQuvthqGCf?=
 =?us-ascii?Q?A6rn/CNDFwCfJyjGQvUg7Pnoo878dCTq5JzB6daLiz/dFOAVRBD2V1wIA7LR?=
 =?us-ascii?Q?0NJBvLA2NvB85pLdqWWcHDpk5lpFMbNNAtqnOs+uwtlZw8n3umizw169JH3x?=
 =?us-ascii?Q?zz8YXCrPEL0IlX7cXHQZAGj5iZVUZ1KK8En8dV9Bd5B+BfclTPHxRT3rQ4yp?=
 =?us-ascii?Q?hC4BlReoFpnAts0UpqVFgm04zMdOcqusdBwnkmZfavnTksA+AFF9fltbZ1M2?=
 =?us-ascii?Q?GD7dpEbbanBQxr77Z2JGs7qpzZkOoEXFY6JWuHK6SnA92Q+IVjJw3O+7Q93k?=
 =?us-ascii?Q?zoponrGUeoMte67lOHk+8pULHCXeGq95DmbhhNYr+LKQj7he4A46YYwxQ/tL?=
 =?us-ascii?Q?ZgGbXQoKyPStNVe03HL5w/GD5ve+xlzhG1/wYRPX53O0KXgQsz8hdaCT8D0T?=
 =?us-ascii?Q?4fmytV61JL64fQaFhGlylE7kfCf3HPQrST1Y/Qpoq+iVPeykOqyeKMXCFcz3?=
 =?us-ascii?Q?bdpjj/juMaHhdAyb7mOydfOMLi8Ru6mUDTjT/i9nyn0BZqKL9becgFD76j6F?=
 =?us-ascii?Q?mTOiTFtsPA3v4eGmZ2xBQy6huQ9JI0QEYX04r6zs4EXUsMkikcWO3gmGKeSp?=
 =?us-ascii?Q?wKqkvB0EH77XreyZqvGv644zjjGD84VdbBXDn8L98MYk1TPI7IXpFN7Mlb2Z?=
 =?us-ascii?Q?CExkkSggjAmIh5RiE7KNazX2ExleLDERvln2gMp28crCNgQqu8uENPN8gj66?=
 =?us-ascii?Q?36355ZaZ1WH8m80+iTwetRJEHIRn9YJgAxOXtarHWZB3MggIn/Bi3gfA1S5I?=
 =?us-ascii?Q?rKDLoG/VFk+7KpjJGlDxNLwsxrnC/N/8eVhbKDX95iPMTvkLZiJh0YkC94v0?=
 =?us-ascii?Q?2Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5R6sWqJbf9D0RngmSFWCbGIqNxckrlWaG/0WNIqlkfcaS8fV2xNQInmOt1ZNKWIEOjPimn9hFRh+JBV5kigVErN04O1ZAhDxQvNVJlAlnwQjuGKX2cP7Yu0Wf5wQr7qLi+1wo6lkGtfr9SWN04Kvhqw833BfF+VW3/4FLSHrP4wLABuO7/DAFVehbXmWzUXyskz4WEw3/csV7QRS16gTDeZGX44WNvx8U9WLGlhf8Omqd36wom6nPLpOJ4QhQ8ZukzX3GC7dqYJf50Ls57sgaXrK7JKCNNZqIk7WihOnp7kLjbY67vWLLQKg8I2JfWZpetWn1j59eYuZagO2ahDKZDLDytJlqthh/XHKLeKERJuJrensK18liYldPnkafhdCAzzt5LeOlEnRNtZRa1fT2ldrWe/zy3XcR3xajbZLg7epKYFyhuLn3oz1WWbXZ+aucTv+ZgcAE94C5T+wTQbXwdVRz8qMiMP6Q9kOurRK8+J8wdPceXtKQBe/nbITN1Vg1CxqtXeq7v7O1kSmRoghs6/5YzTrTecJdUllJuLHXVHv1+CI+IRK0oprDRXgvnPuKVnjeG8CiiqqV5G9D4DvJkQFAzfI0t/Wy9UojVDDX4Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25e4955e-f286-4578-eb38-08ddf4475165
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 11:02:10.2659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kn5Gr+YO3rGUed/MUWRYEsGEcij1bdm+98wa8cG6IbOI7wVcgl8zLmypG3n9h46rYhgGHxCyJFsRJ0FEXKYdWY6rsnveHhBUoetFyZXR4Xk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8031
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-15_04,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=950 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509150103
X-Proofpoint-ORIG-GUID: exxKYuEjn0vTf7fzuOohInHDY5ouwyTv
X-Authority-Analysis: v=2.4 cv=KNpaDEFo c=1 sm=1 tr=0 ts=68c7f236 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=4DF4tpO-lagR8TGB2tAA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: exxKYuEjn0vTf7fzuOohInHDY5ouwyTv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAxMiBTYWx0ZWRfXw28pYmGf73Eu
 NPgj9tUuKkO5wSnuo5I6n89IKIJHnNbleFEU1x8Aye1q/UD5L1etRrYgc1pYlNND4giL8O823/u
 J8JakBdeZ5nSoJzI6FLTj6CEea5Ha0N+TkvuNliCFq8OMycvA20cU/nNf28AKPQZHZdURw5GGam
 rYLbAPsJO5K8qpGdCxOG46CtEf4YoN9YH/6jIvwrHIVwJtA/AObAfoJwYekWCvArKxd9gehvszN
 3G8SEABVxfOJc/74By3Ozi2B6B8Dn+Whgu9/5zF/Ty3rB+I5dGcLjHgeqr+i02fq536nh1dpOPq
 xuN9j2mUCWJ5YbONkCa+Y3GSxmyDmujhPDbOyKaGXkoMnUJMg7cUBsDDUq6E4Bhht03j1I2co05
 LnlD148m

On Mon, Sep 15, 2025 at 12:52:03PM +0200, David Hildenbrand wrote:
> On 15.09.25 12:43, Lorenzo Stoakes wrote:
> > On Mon, Sep 15, 2025 at 12:22:07PM +0200, David Hildenbrand wrote:
> > >
> > > 0 -> ~100% used (~0% none)
> > > 1 -> ~50% used (~50% none)
> > > 2 -> ~25% used (~75% none)
> > > 3 -> ~12.5% used (~87.5% none)
> > > 4 -> ~11.25% used (~88,75% none)
> > > ...
> > > 10 -> ~0% used (~100% none)
> >
> > Oh and shouldn't this be inverted?
> >
> > 0 eagerness = we eat up all none PTE entries? Isn't that pretty eager? :P
> > 10 eagerness = we aren't eager to eat up none PTE entries at all?
> >
> > Or am I being dumb here?
>
> Good question.
>
> For swappiness it's: 0 -> no swap (conservative)
>
> So intuitively I assumed: 0 -> no pte_none (conservative)
>
> You're the native speaker, so you tell me :)

To me this is about 'eagerness to consume empty PTE entries' so 10 is more
eager, 0 is not eager at all, i.e. inversion of what you suggest :)

>
> --
> Cheers
>
> David / dhildenb
>

Cheers, Lorenzo
