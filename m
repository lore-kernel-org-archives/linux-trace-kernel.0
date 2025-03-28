Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE52A1E835F;
	Fri, 28 Mar 2025 23:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743204161; cv=fail; b=EoQDYCgkMBPWwiU07oAnOdgljqHrokSNYBK0JZ/bxe7FmQ/KFdebBasl7ZBrf05IyWqmUqxPIQ+SoiEHU1mvqPHXaM3Zww08TprueWXN+/mDQulT+OACnSasUjrJ7NHLxHIi0U1GV5ejTJuhpeAfyK5zQLphW8FrEfmd7ERKZgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743204161; c=relaxed/simple;
	bh=o2DghY3yIA7x679hGdBbUdD6CN2tXtHw1MUr5O+wwEY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=neC95Q3gQtams4jBhRw8Mwva5Cb+qjrrIdiPHqRixnbx0qbGIGumxHUPELeNPqw/UB/fzRLIQl4VCy+GLF9Jufc5Y2nVLe3x2zASXScFTQXY3u+0WUqChYVjEF+2JMRxwFZGf8CaJccYuww1cmJUrbYwMBoAy+O0bXaedtT3LY4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QAOXXmN1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lSu+8cwi; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QAOXXmN1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lSu+8cwi"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52SKWDGk026700;
	Fri, 28 Mar 2025 23:22:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=/UKCS9Eeuf5nEE/B2YY1UI48ex4jHm0HadhPzcNKkOI=; b=
	QAOXXmN1JIRD4nHjFTmiUBFiJv0JRtS9Ypkfn+9MCLLAipOBoyyZK5qtGiJb9OqR
	Ydvz63zLRtLlCbqwIQPkEhgFPVyVBEgwZp5LoSehY8Q754kMyzbJWT+IZC6p6HeU
	aVkgZW2bOnJkdyfiIJJfEZWLUQtcNETqNf3aqY3c3iLuEymgFPwt3BVhvrAWPdE3
	9O/marAK/Jg6+7hHusdSqOADDjH6eVbbXzJ2D9/FW4Hkag3VhWHyX9DTui1CK5vV
	HUhpr81h8hFaDOJJCXDqLJx6wqlqz4dJbhSTKe/A0VmdVPrkSGsKSLpExIortddN
	FIKMYkDYonR/8OI7XSZWgA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45hncryub4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Mar 2025 23:22:32 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52SKuCc6022870;
	Fri, 28 Mar 2025 23:22:31 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2040.outbound.protection.outlook.com [104.47.55.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45jjcjnu1e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Mar 2025 23:22:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sh0Mlmp2xoip/2nz70xb+5T/pcpkYUfqYN2Tu8AQlxwwF8D/pJDtFW4gt9Dd2CVoj7+eKBM/wJg7oin8EXIshPEVp4dbXcwbmpJOUM/NZM8KQH+4TsYLtgXO18l9awmTWrN7NjP9mHeTMbqJiZ8ZmOXVf6lfZ6jpjPT22TaBFAV2OM96Am2Fq9ghKgN5zJmiEZmsVCE/OMmV5LdSMvn6mclOd7jU72S75PKX2dEIlQ5zZeH529HZwBDMxMqilXr0hBliMm2pNCMYlA/SAq7ntQ02C0ZBktZCzBr8cNhhk2OpQwXxpWDLNytRSHQ83Q28UUVQnS/tiN3nOOo0jYdMgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/UKCS9Eeuf5nEE/B2YY1UI48ex4jHm0HadhPzcNKkOI=;
 b=Kb0MQ4Jq9DxURyvehapYoP7Q5o4PTer/w5e7hAHVq/Bxo+JhMa/EDomS4oqLQheKYWPAJJRwF/Uc8NfBzmCaXBzTHA4zyCRmOy0PpcOpYKNFw6Bv3WxyWlv8dpR2VKMWYwqfM13x5MIbq69qyKvxHXPjgHb0S9PGkQd9g5rC6fYEJpVySmYkDSmqgipfGdq5QlggOPUrIeXWhN3eb+vCSU11WyNyR9uVD+FYT/jj3U2mDq0kkd/muuwKsI+8wCjevPICO6OXeakjY3Ws/SQ0ZqEQSbPl9csqHMnWsIc4y6leiKvB2cgFqdEGTvNQ36otYWOCdZM40peJp75wmXBbCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/UKCS9Eeuf5nEE/B2YY1UI48ex4jHm0HadhPzcNKkOI=;
 b=lSu+8cwizkUBbk8ly2cn4pLLX0mZrTVwzWzEY3/0dAPK6lR3HNpP60vjSP5MfxXJIdbhPzopBBbeeVfkHqg0TMontJuXbVf4JATkBdBAJg16XPKEFR2bygdV8wqN+Ap5ZinGvi3KBNo3xK4W8uVJd9m07Apb5kl/2L21qchvAKw=
Received: from MW4PR10MB5749.namprd10.prod.outlook.com (2603:10b6:303:184::12)
 by BY5PR10MB4147.namprd10.prod.outlook.com (2603:10b6:a03:20e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Fri, 28 Mar
 2025 23:22:28 +0000
Received: from MW4PR10MB5749.namprd10.prod.outlook.com
 ([fe80::9a04:a919:657a:7454]) by MW4PR10MB5749.namprd10.prod.outlook.com
 ([fe80::9a04:a919:657a:7454%3]) with mapi id 15.20.8534.043; Fri, 28 Mar 2025
 23:22:28 +0000
Message-ID: <ffeb5e0a-6968-42d4-bcbb-bd8fc5341a50@oracle.com>
Date: Fri, 28 Mar 2025 16:22:27 -0700
User-Agent: Betterbird (macOS/Intel)
Subject: Re: [PATCH v2] tracing: Verify event formats that have "%*p.."
To: Steven Rostedt <rostedt@goodmis.org>, LKML
 <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
References: <20250327195311.2d89ec66@gandalf.local.home>
Content-Language: en-US
From: Libo Chen <libo.chen@oracle.com>
In-Reply-To: <20250327195311.2d89ec66@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH1PEPF000132EA.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:518:1::2e) To MW4PR10MB5749.namprd10.prod.outlook.com
 (2603:10b6:303:184::12)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB5749:EE_|BY5PR10MB4147:EE_
X-MS-Office365-Filtering-Correlation-Id: 7366810b-27ca-4277-cdf8-08dd6e4f6824
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RDJCenMzLzVlRUF5eGNBZk9NVU8xOUtJb1lidHM4bkVpdngxSmFyQjlWZjE5?=
 =?utf-8?B?QkRjZFVxOHVLdHhXSURab3Njak93dnI5bUp5MnM5SHNsMEhQK1YvNUJ3WWNX?=
 =?utf-8?B?amVRWFVvTXM5MFFqVDBvTCtHLy85elhGa3VHZm9PZ1ozaW90MU56RXlaUFB2?=
 =?utf-8?B?V1R3eHF0M2VwL2lCOGRXUWpYWVhKblhDU1V3c2FLOEkxcUNiR2JMUzgxSzFk?=
 =?utf-8?B?c1Z3RDdjeFl0c0hxS1RjSVRpZmQra0lHNUxXS3NzeGpXSnFlL3dPbkV2Wkhh?=
 =?utf-8?B?b2lQc2lVRVJ6b2JPaGZDRWpjLzB3ZkJIZDJIYlliOXJCenUrc0Y0Y1Qzem0v?=
 =?utf-8?B?SnNsQXRoOXFMUnIyc1JiMU1aemdwOTVSanJCaW9aMm45YU85MTJZYk1zeHZp?=
 =?utf-8?B?Z05YQ2VrczhKMHllcmRzbjRiaTVuWHAwb3ZWV3JuLzMxVCtoVWp2ZTkvZGEr?=
 =?utf-8?B?QytTOEdYTEdmTzhtL2JyTlh3NlBtc3NvbHd5N0dCWFBjbDhvTXpvMlN3ZzRP?=
 =?utf-8?B?S2RPQ3V5TS9NNm40eDhmUnRMOWhVbWU4TlY1eU9pZFE0VVpXYitBdzM3ajJ6?=
 =?utf-8?B?OGkwRmUvWlduTXhRaGNNY2lGRGdwZ091MW5nbmJGbjdWaHkxYVBJVHJaSnVY?=
 =?utf-8?B?M2tseDFTTkNuWG1WYnpCM3hUWjR0UmhRdGxNbWxXalZORmNoaWNNQWVoMElm?=
 =?utf-8?B?SXFkVlA0RGlZcWdsdkYranFZUml1cmpLS2ZZaEVMamoxdG12Um91blJVWVdU?=
 =?utf-8?B?TVhZQ2xrb0pDaHZMamJwSWlmTk1ZWTM0Nk94NEZoRHdWZTJEdFJsdmRPZTFU?=
 =?utf-8?B?Q1MvL2dYWUp5ZlVtUXJKOGluZjhBSkJxN0RVN09aTUJoYk5sQW5FcmdIM0Ri?=
 =?utf-8?B?RWl6WmVNQmtpMk5mY0t0UDRpNG5xaUhPVFR3ZVM0Q0RQcUFWWng4T1Y3RjNQ?=
 =?utf-8?B?KzlLYXJIdFU4V3U2VENLMjFYRWcveE43NnlsYUF5eGpsY1FOVVFpeGRRRkF2?=
 =?utf-8?B?Ym1lYW1SS1lzeFlQR3pHbUJFNEdwUW13ak5Kdzd1WjE3eTM2L2x0dHVPSUJx?=
 =?utf-8?B?M1dYUEdQdFdnUkxsR1NPcnBWWVBWcEMxbUM3dVlWMTVCdHkvRTUwOWl2ZDlp?=
 =?utf-8?B?YlcwSTE2RWpWVGQxNkEzTE52SzR1OFF0UnNXeGo3NHVnTExtL1pKMGsxdjhy?=
 =?utf-8?B?S1pIVkpMQWZsd2N3eGgyZFI4Qnp6SkpDZ3d1TllDSGxIdEloZGhHN1VITDVB?=
 =?utf-8?B?YlcrT053VERsN0w5VUs3MjJFNHdjck5FNFgraC9VOTNzdXp1SjA3TFhmZ0VT?=
 =?utf-8?B?QnpHZEd6T3pjUGpabWh4ejlKTlBsZ3Q5RU9wUG1vTE02TGlYc0xtTXI0bVZp?=
 =?utf-8?B?ajdhTk14STg2SGhsZlZkMzUzcUlVOS9HOEZSdkowWnIxdmV0VURLYmRPVkFt?=
 =?utf-8?B?a0lBSXJ5QW90bmJScytiWWZYbkxxTnBPYjkxSDkzeXh4b0ZDcUJMT2g4eWtB?=
 =?utf-8?B?enJ5dkNJYmFlMmx4YzMxbi96RWhvcmN4WHBrVE5ZelZsZUtCMDZ3R0VmeDQw?=
 =?utf-8?B?S2p6OXh0OUFmV3Z0MFR5QVd4SGlxZ3BYNGdsZ0pwY2NoODJyMC9FdHdoamdS?=
 =?utf-8?B?SVJZWCs1U3hiNW1FQTZxZXJ0YllTa0h3TkpmcUFITjFJVXlydktoQXQxVURD?=
 =?utf-8?B?TjdWR0owVXRHSkNRZ1pnbmpUT0VZQkxOaFRWc00yaWlXWkpCbUJwZDF4aWhI?=
 =?utf-8?B?ckdLNkE0akdjYTZWWkJDMSsvZ29MNmpyd3NLUmtGNXpIYyt1djBHNnlzT21z?=
 =?utf-8?B?T09IQ2htV2JoZ0Vaa1BhN0RQc3dOUmdia2VaL2xtL0VQemRXcnhMcWZHU2s0?=
 =?utf-8?B?SmRqOXRhRkpjak84enI3cEhGbldONHhQdTVSQmV0MXVOYnc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR10MB5749.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Qm85d1I5bzNRclZBVnNrVWNqWHFabjJjbk5UWHdOUjNpbUlsY2R1eWxJY1ZP?=
 =?utf-8?B?QVp5dzBhemIzOFhwREI5dmJUbzN5YlhDbCtnRE5ndStleHRnelRhNmsyUE93?=
 =?utf-8?B?WmFORHlZcEVxRnR3dWJqWUpZYkFhNlFMWlk0YzJtR3N4cjE0bGZ2OXNZU1VI?=
 =?utf-8?B?UCsveXoxc2VQaFdZQkN4YVM3WDU1VjB1SFhsMEVJdXk5c1hPWStWRkNhZjNy?=
 =?utf-8?B?N2NJOWJ1Q1hxdFBmVnU0QlVkbkFxWTl2UWhzbHBaZHV0OE5RUkd6MG9SYXMz?=
 =?utf-8?B?TjZYZFZYak1ZcUd0TWU2TWRuSU04ay9uaHRMOFpJOVU3eEpyNjMrQzAxOFVQ?=
 =?utf-8?B?aWQwVnVwYitTeTdyQVpnaVhRWkJ4MjZ5L2FuSFE0eUFvbmtSaDhiRnBwNTZz?=
 =?utf-8?B?blh0T2NOcElNcEZid2xnMEk4ZzUzRVVJd3d0STlER2tPS1lWNWkvNDFWcklJ?=
 =?utf-8?B?QkdpcGFkZ0I2QVYxREVHMlU1RldwUC80V0U0cVl0Q1AxVHZNYUxhN21UeVVh?=
 =?utf-8?B?eE1haEljYk9YU29sYmQxaFZ6TjlVcHVlcWhhWThFWDZndlFoR01talFPcjRJ?=
 =?utf-8?B?REsrRkRleFRwZUZYL1l2ZFpsRW1waGVDQUlCWTJrZzZsMXBaT1V0cU5DUzA3?=
 =?utf-8?B?eU1KVEZaQ3ExbXlibTF2ZExhdW4xZ2xvK0RXVkp1Q1JzSjBCTDRvbmozckta?=
 =?utf-8?B?QlBvQnhxUGFqUm4rZ2tqeDJoVzlCYzl6d1pVeVlhOU9HYzE4NTNjNklwbXRl?=
 =?utf-8?B?Yi8rbGIxdnV3SHNYdXhWQWNUc3hIT2N2akk2TnoxTVZXdktxeGZ2UTZlMWhG?=
 =?utf-8?B?Qkl6VHRsVTgrMklFUldFdHI3NEY1YW9uaUpiMWdUN2pPRjQ5cVQ0Uk53Z2hO?=
 =?utf-8?B?S0l5ZFVHQmlPSlY2M3VwVWJuUGpHR3JCaVVlSXRvWTZFaFRDSVZlOWR1ekNM?=
 =?utf-8?B?S3ZjVTgzMnJpZktjNGI0Vyt0QkhCdGE1bHpNa2ltUGliZkJUWktzZDV2dmc2?=
 =?utf-8?B?S0Y5ZDlTeVBSanBmczhNeHVuWHp0MTZnQURKTVBnOURCM2NPdVlxWVptaCtw?=
 =?utf-8?B?Zll4NythYlgvMURTUmxTTVNSd1p4WGorWElkMy82M3BEWVg4emZVRDlBVlVs?=
 =?utf-8?B?U2x6UGxjc242ajluYmhrREhUUmNNL3JPS1pDOFVJV0NJcTlPNUZ5MENRRFha?=
 =?utf-8?B?ekpqY3REZDVmZ2tvam4yZXpJQVlsUHJvSE5wNUhBM1RPdnc4Ni9COVY3MUxJ?=
 =?utf-8?B?VnZXTUZtWmZzS0RST01JK251UXBMQm9aWXRCRGt1amcrUHl1Y3cweDlZS3FH?=
 =?utf-8?B?TGlndjNYcm0vcDk5Q0JhMHEwNHhSbGh4QUptdkluVFBWSWdoTGlzSE81cnVP?=
 =?utf-8?B?RFZKaStibnMwZXRIZlBHaTEwa3doa1RnMzA2eHlHeGVKbU42b1RYUEMvQ2Vl?=
 =?utf-8?B?Wmp4dXJkenZ0aURvaEd6dWRudHhaZ2lKNjkvZFROejZNMElzVzNWTFdMVVRz?=
 =?utf-8?B?Skg3U3E2MkV4SHY5Zk1mLzY4L0tDOWpETkdGenEyQ3l6Q2pVbE42WnRxRzRj?=
 =?utf-8?B?RTc5QStjNGJSVEl5QVo1SkZFUXZZeFBlaW8zUSsrODZxL3NzQ1JjYS9MWTk2?=
 =?utf-8?B?WVZhWVFleEtYUnpaZFdJeVAvbEQ0S3l2Ri9LNmtPMVdxZDRIeGF5L1JBazNE?=
 =?utf-8?B?TVFnSEhyRnI3OGhnaXZubHdKcW9jTmhlSFZNZWJ6MkJYcVlHa3BTRWVGWUpk?=
 =?utf-8?B?OVFIbzdZZm1CNWdDRktIOTNNRVh0aExNb3VFUDh2ejFUbU5qV1poSzIrWUFn?=
 =?utf-8?B?cmxIaDBVSUorZnh0MS9BN2JOck5SY0RtQ21oU09MazVIRlBpMjBlblVzNUl1?=
 =?utf-8?B?eEljcmF6MTBzSkJWbERnNk4zZ3VIQzVUQ2JiWEtZY0dtNlJpd1laRk1uWEpN?=
 =?utf-8?B?Ym82ODBZdzJZS3RHMzBzKzQzemV1MS9PTUtkbWp3NTVDcXkvZ0I5Um5xbUNE?=
 =?utf-8?B?UlkxaVR2TDlqQzE0R0c5Vm4wNVNBaEtsVnNPYythbGJ1Z2Vka25kUHpKZVFi?=
 =?utf-8?B?UTdHaHhHZlNSYUhtN0paUWJneW4xa1BWYjMvTmp3SDJtSUxXS3hzQlFCOVR5?=
 =?utf-8?Q?9ByxARbEzOGNxLN0Senp8FDP3?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2q1Eykp4IinkFokNZmU+XGgxi4r/+sh74hdmI1xEOV+G/5mVRmQlVQZRQ2S4pXkE9VYAuzVyyd+oFHcuzEtzpv0qcltfv6/86SV5VjOvpt2dk8gkaioRgPolLT5PNsd/daRPMMiH4z0a3dk+c74wjwwjUm1IebLUUo5iTpnJY2wpp9H0v3y6JiffgzJZT2ipvcNzuwBxeJnuMmp1msC+By1BykJPirvNL7tN9fLaw+f/x4hipvtgKohNDD/8KN/iPO306IHub81EjM3nXg3b539kCELQfrp5mM90oI+HQojlCQcfKSUT1VFJCHT6HPjYFktRGDFBl31EyCNMezC7sOZj1EjqebVonKhXMQ/KLmmNOoyTmCbiYT/L7hg5N034SSJIwEiNxDRlqpy2hvjGYTImQObeP4/ghYPWX8zVxEoeVKGXaQIDK5Ld1M4uXAOCTjoUzUVD+nNoRsbCDbMX+M8rsCbxF+H35WnUkPfQwYnYB1CJHFb/PHQhVC2/+iiqhBSEpgp+f0FFjZK3R9qvyarTI2Gf++3iMBDzS/ZqV/HjYTSKjGdDEEYGZLmihoNBI9gztCVy6I9iww/9cFHAU88/+hLyAWcGm1JvYFVdg6s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7366810b-27ca-4277-cdf8-08dd6e4f6824
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB5749.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2025 23:22:28.6416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +ni/vG9o/zm8gkmIUldmSWk4olx0r027JPIIV3fjkL7+4QZF9t6BFuoCHwBqdUb2RKwWCeJblfJDK/6Zd8BM+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4147
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-28_11,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 suspectscore=0
 adultscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503280157
X-Proofpoint-GUID: 90bsVexvbCvK3GcqJdgBtrlaH54bOQou
X-Proofpoint-ORIG-GUID: 90bsVexvbCvK3GcqJdgBtrlaH54bOQou



On 3/27/25 16:53, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> The trace event verifier checks the formats of trace events to make sure
> that they do not point at memory that is not in the trace event itself or
> in data that will never be freed. If an event references data that was
> allocated when the event triggered and that same data is freed before the
> event is read, then the kernel can crash by reading freed memory.
> 
> The verifier runs at boot up (or module load) and scans the print formats
> of the events and checks their arguments to make sure that dereferenced
> pointers are safe. If the format uses "%*p.." the verifier will ignore it,
> and that could be dangerous. Cover this case as well.
> 
> Also add to the sample code a use case of "%*pbl".
> 
> Link: https://urldefense.com/v3/__https://lore.kernel.org/all/bcba4d76-2c3f-4d11-baf0-02905db953dd@oracle.com/__;!!ACWV5N9M2RV99hQ!L9dryF2Ft0p8H1X2Q6EPsm0j03lJOixhB2V-_zkgCOBUoIS5V7B8hmOZxCpHjzNnCodkqNmxUulCC5wPbg$ 
> 

this is no longer a blocker for me, as I mentioned in a different thread:

https://lore.kernel.org/all/4f5453e8-61b6-45d1-8c6c-8b4fb99a6448@oracle.com/


Thanks,
Libo

> Reported-by: Libo Chen <libo.chen@oracle.com>
> Reviewed-by: Libo Chen <libo.chen@oracle.com>
> Tested-by: Libo Chen <libo.chen@oracle.com>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
> Changes since v1: https://urldefense.com/v3/__https://lore.kernel.org/20250327114911.2c713511@gandalf.local.home__;!!ACWV5N9M2RV99hQ!L9dryF2Ft0p8H1X2Q6EPsm0j03lJOixhB2V-_zkgCOBUoIS5V7B8hmOZxCpHjzNnCodkqNmxUumNh4GyCw$ 
> 
> - Fixed indentation in sample header.
> 
>  kernel/trace/trace_events.c                | 7 +++++++
>  samples/trace_events/trace-events-sample.h | 8 ++++++--
>  2 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> index 8e7603acca21..ceeedcb5940b 100644
> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c
> @@ -470,6 +470,7 @@ static void test_event_printk(struct trace_event_call *call)
>  			case '%':
>  				continue;
>  			case 'p':
> + do_pointer:
>  				/* Find dereferencing fields */
>  				switch (fmt[i + 1]) {
>  				case 'B': case 'R': case 'r':
> @@ -498,6 +499,12 @@ static void test_event_printk(struct trace_event_call *call)
>  						continue;
>  					if (fmt[i + j] == '*') {
>  						star = true;
> +						/* Handle %*pbl case */
> +						if (!j && fmt[i + 1] == 'p') {
> +							arg++;
> +							i++;
> +							goto do_pointer;
> +						}
>  						continue;
>  					}
>  					if ((fmt[i + j] == 's')) {
> diff --git a/samples/trace_events/trace-events-sample.h b/samples/trace_events/trace-events-sample.h
> index 999f78d380ae..1a05fc153353 100644
> --- a/samples/trace_events/trace-events-sample.h
> +++ b/samples/trace_events/trace-events-sample.h
> @@ -319,7 +319,8 @@ TRACE_EVENT(foo_bar,
>  		__assign_cpumask(cpum, cpumask_bits(mask));
>  	),
>  
> -	TP_printk("foo %s %d %s %s %s %s %s %s (%s) (%s) %s", __entry->foo, __entry->bar,
> +	TP_printk("foo %s %d %s %s %s %s %s %s (%s) (%s) %s [%d] %*pbl",
> +		  __entry->foo, __entry->bar,
>  
>  /*
>   * Notice here the use of some helper functions. This includes:
> @@ -370,7 +371,10 @@ TRACE_EVENT(foo_bar,
>  
>  		  __get_str(str), __get_str(lstr),
>  		  __get_bitmask(cpus), __get_cpumask(cpum),
> -		  __get_str(vstr))
> +		  __get_str(vstr),
> +		  __get_dynamic_array_len(cpus),
> +		  __get_dynamic_array_len(cpus),
> +		  __get_dynamic_array(cpus))
>  );
>  
>  /*

