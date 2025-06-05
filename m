Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D70139579;
	Thu,  5 Jun 2025 20:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749155505; cv=fail; b=oBfi/nSECX3OkhX2J0sdEIcjjUMwzq+nSYhrqnV3cVNKXj99LvZoYf6zz1G4bC1zQOp6LLXBFgCxPOtmCz+Nwdn0Qg1V4K4aLrWs6UZalBe7lvhWnEN18We7WSB1Ic/T2EPImwt7nIR+yi4XHAgdnu/+aX/HrYwrVPpEgTYQ7Pg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749155505; c=relaxed/simple;
	bh=v9XY84bmCFPtx0baWUV+Zei+R3WzPQX3JzpB5zAM7v8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=V/uKd3A94aVEx4RwDC6QDpO0tmJbmsurZhGZz9kUjw/MnRhCJfUP8SyG8NB2CPU1sc8li2KBPDqgGMcOGt/wr0sxyoJzeXMI5I7Acp+I+kWgIehZnxZNfzqxVbCneQoqvodu6x+wVQyrLGTf0EeWOkloJVgM52+/VPPivQFOUkY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cDwj35na; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cXz//w+N; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cDwj35na";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cXz//w+N"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 555FtWSC018940;
	Thu, 5 Jun 2025 20:31:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=9K2cWx9nij4YkCqv86obmd4VUI8SMxg+lBew+mCPM2E=; b=
	cDwj35navYJyZ/shA0z5M427eFvgjCdWI74tuD5wCnBcEtsHn+Ppyu+36lEwrtDf
	iNNN+tQ/IdmZVRZi23g+NSNNs9p7BZdlqM3BWzzQq13cV02VeyNquvBGf/WRI4ik
	71IDkEZtkdE0GPEwoBC4W6FWaod4ix05SiaBYs7xHRSjEG/PvB+QApzJ7IZancuo
	rkeQNWp0vXNaJ12TmlPqgf0cSZFJ2vBdPOZZAcVDVhvGcxZfK0uGzaWyB7kPjgjQ
	6UBekoxPcn1msv9tDL0alUhKEg/hgboKOIKTC1PumDMlaw1mda/Q7AR9Bq71B7v9
	UbNMYdmn9G9Dq0/kZ7TaIA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 471g8kexxx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Jun 2025 20:31:28 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 555K6soM040489;
	Thu, 5 Jun 2025 20:31:27 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46yr7csgq5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Jun 2025 20:31:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jGhcHP4BBS9Vj8y7ZECtbBz9acQ8b4uK97u4LpJZZdEQpXUA8nDgN7Eib317lubcoZ8uf0//Nv26p2Np9ERzM5M65DK7vWS3vEENkT+3sjgi37qe8uP3tVdS2s8N32hR6z87R/ayBVtUZtcRHtB+1AURW1m6JVAc62c/SWqFIpdL+Il3kbTdguDrVsLYbJadWItlltn8WB9q4acbUJ5XEsWIyhfo4339HRFLrZz41LTJbt+LGoKxl9JPsokwyGV0OO3OLtWPhwiarq9yoSlE5avbfmHDAVyt/K/DO75Vd9lt3XVa/8+HUu4r+vhmum2NksSusLYX9KdT5OhFzrCe0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9K2cWx9nij4YkCqv86obmd4VUI8SMxg+lBew+mCPM2E=;
 b=ltW9cnylUx2/kcfkgZgBcdO5YqNkszCyJRySVYM9UFWKubfNZhfizdx8SY5Lx9yFciVsbEz5EzNK11PRkD0ibiZ9s8q7/vg3z1zVZqarV4X3Gb9jMTTWxCc/6aVOWkfLD2KAEcsyf56xU5cM6Jp8Fm2UZWQJCKTnX2nuV4CAAOox8WSnnN0SyAc6Yn5JrlXRE0so1lXSYBnkOl5ayzld3M/7+A3Qz60wUWpUGUXJDb7Zx1ghkunY8SqfFA3btapVLxE9uvqHq6kUQyGQAlsCdYO+K7WFjZOQsVtfSsEn+30R7wkW2qyFnvL0ro2rghI7BkuNoukW9RHx1SyCfwCGgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9K2cWx9nij4YkCqv86obmd4VUI8SMxg+lBew+mCPM2E=;
 b=cXz//w+N12rBj85cbr+Owvb9qxVXKA2nPujRRjeJskcTMdCyL2SbsyenXP5tBs1Lj2MSS50u9OhOYlzSaTIW6LqMPFiz4mZTchWdhq+0MXXJ9lvcHjaNxH5FtB2UOzs8dq0poyTSEr3+GjR1RM1lEhGPeYnI/h8ul0VLZUn6l+E=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by DS0PR10MB7901.namprd10.prod.outlook.com (2603:10b6:8:1a8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.20; Thu, 5 Jun
 2025 20:31:24 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2%6]) with mapi id 15.20.8813.018; Thu, 5 Jun 2025
 20:31:24 +0000
Message-ID: <ddc95091-f43a-4c3d-baa1-058b19d477d6@oracle.com>
Date: Thu, 5 Jun 2025 16:31:20 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmap: Remove unused events vma_mas_szero and vma_store
To: Steven Rostedt <rostedt@goodmis.org>, LKML
 <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        linux-mm@kvack.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>
References: <20250605161959.328ed2a7@gandalf.local.home>
Content-Language: en-US
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <20250605161959.328ed2a7@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0013.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::18) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|DS0PR10MB7901:EE_
X-MS-Office365-Filtering-Correlation-Id: 56e0eade-b22d-4fb3-8789-08dda46ff073
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cXlkd1J0aitONTI5QUtTenN4c05pcDRXQUJPSFFqN0k0cXYyaG0zNUNhZUdm?=
 =?utf-8?B?cEIwNTJPOFJ4OW1PZ3VvUUlVbWthdHN6STVXbHovK0JwU0MyOFRpOXVySlEr?=
 =?utf-8?B?VDQ1MUx2SnZiSnBGK21BcTkzeEJORjlhYm5qckw3cHcreGxmSVBvdHpkNXQ4?=
 =?utf-8?B?cGNpRVF2Q3M0RjFhY1NSaThPRnk1S1R1dWdEMVo5VEY2QWc1V2JaMnBqNStH?=
 =?utf-8?B?NXl6TkRFYlVoMG81clhBUXE0dFVIOTdkVjQ3bXFGTGZIMW4rNTdZZ25LUlVi?=
 =?utf-8?B?aHd2VWNvNnZqWG9BNTlRRko1WkVpczJvaXFPK1R2WmVKdVlWYmZxRUJEUFRZ?=
 =?utf-8?B?cnJmdW1vS3Q1dFRCZnFkcXJISk5uUjBxQkFlNysrSXg3aHlJNjVqUFlCeFRl?=
 =?utf-8?B?L3ZtN1p2eFg5Y2R0WUdmWXRiak5iNFlqV1lnbnFzNkpXVEtGUHBheE1aNHRu?=
 =?utf-8?B?Zys5T3hjdnJSY290TjdnZGxaRDd5NlgvUkhvZHdMYmk4WmNpUDJHU1dkK2dP?=
 =?utf-8?B?eWRjQTcwT0ZLQW9LbU56WVFIWC9OWjZiWUZ2VlhwZDluSWZYaEwwWkd3RXpZ?=
 =?utf-8?B?YUtSdmRIdDdpWVR6UHhIZVJBcXZYTW5lUWY5RlBEWG94MUNXS0s2WXg4MUo4?=
 =?utf-8?B?ZjRqWUdLYkpHclMzQXl2MUlZMmNUWHRvM0xjWGl6YXk0TjJDbXZSc0JpeHFK?=
 =?utf-8?B?d1pEM0RRK2xKd1IycERBUFNSRHdkbG1wUjQwT3VlWkY4Y3VnblJZbjI4OWYz?=
 =?utf-8?B?T0JWNytrRG0yOGx0L0NmL0V6Q0lrUWsrUERXanRHaDhHaGdXV1JDMFVVVGRO?=
 =?utf-8?B?M3RVclU5NURMdWkyZnpKZHJnd0Mzd1hYTjVoQWdrVnFiQXQyM0JFVUQxSzI1?=
 =?utf-8?B?NkZmR0FtZXB5Uy94dTZwblRia2NjOURWUVk2KzErdURRMk54VmNmQVArOHNC?=
 =?utf-8?B?MlowWlhSMDVzRlJSM2FTTklWeVY4bWVLV0JiK3NqWXU3WGJjYkNVUGR2ZWMx?=
 =?utf-8?B?d0F5ZWUxdTBlSk95VU16UEIwVnpYWGNISUs4SG5mZzMyYmxoc1RhSkZpN3RD?=
 =?utf-8?B?MEE0Q0pCdmdncUVRNEdFb1dRVWE1M2M5RDBxQVI0R0dqSTlpeUNjU01hTk5J?=
 =?utf-8?B?V2l5eno4cGkzaTE0RHZFS0lSMmpvMUZjTE5CekhGRkgxQURZcitvemU3VlBM?=
 =?utf-8?B?VVFqT2VHNm1XUFUzOFBOd2xvRWU4WE9Fb3NhUWJhNnQ4R1RqWEpwRmJHNXBO?=
 =?utf-8?B?eFY0WjdwajBoanBVRTRDTXJIaExXQkRpalppOE1yL28xYmRqOVVzVzZTOFFF?=
 =?utf-8?B?Tk1Ta1lhd0RoU0VMWDZkMUdHaWRDaEpTMmtkYmc3VDh5OEM5WHE0RU90ajQy?=
 =?utf-8?B?VHJsdTNhN2ZEcHlPdTc1bEQ2NzQ1NXF2NU5EWTRialdZTzVBbVZnUkNRZWhk?=
 =?utf-8?B?TVVzUjFvZUNsKysyVjJ1NnBLc0Z3dFR6WWRJcHdYa3NRRUgvZTdzblpDaVA3?=
 =?utf-8?B?L1JFY1NoSnI5VmlQY1NJUzd6TGRDODJmMmRUeitlZFg2bmZta2I0SnhYZFNZ?=
 =?utf-8?B?aHdvT01Xc1k5M29pMWtkbWVPSm1NMEhmeGo0dFhkSFV5bk5XdEZuUjdSaEd5?=
 =?utf-8?B?UmRmUUtkN2lGVHA3ZVo4SzVvTU9OQ3hZYTRQOUtsYWY5L01xNG4rSEwzN1Bi?=
 =?utf-8?B?M3BVaHJKb1M4ZXpWbCtWOC9SaU5JbWt0YU9qRVY4RW4rTE52clluenNRb0hy?=
 =?utf-8?B?QkN5S2cvd0xnNWNGd3hteGZCK0twVHoxSHovQVpwelU4ZVc3NFlSUnVldHpS?=
 =?utf-8?B?TmplMVNxRkppRDB2N05HSWE1Uk1ZS25GS2htWmJWd1RUU0d4eWVBdmMxN1dm?=
 =?utf-8?B?UTRDaDRKSkZKMzZiRWRMSktHWHV0TmhBbEtCMkxjeVpSaHBJdk92Q1BiNHda?=
 =?utf-8?Q?chDQy22wQw8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NlZwNm9xb0FYdnFOSU5uUkZQQWt6RHRSMFlBbllwYWRZV25IK1VFcVFaSG5E?=
 =?utf-8?B?OGxDT0wrRFBVUkVMRXBDTGcyZ0lIVHdkay9mUm9ITS80eWplaTc3TERuWVdt?=
 =?utf-8?B?eXd5MVpTZEZEcFVXWUpGVFU4Rnp5QzdGSFlIa3VLb3VQZmc4bEJqSk5ON2V5?=
 =?utf-8?B?N0FyanQrYndwaDBGVmEzTXdQSHRXeEpOcVJUMkd5VVkwU0JndVdTa29lem9l?=
 =?utf-8?B?WXhEMnBUdDVpMWxJOUkwL0tVNmo4MjRPUzdrNjRDMi9nMmNBU3RqRGoyV2VF?=
 =?utf-8?B?RkVZYmNKallla3Y1Rm9WZ1ZSSWNhWEpnVUxHQ2tSVW11QlN1R3lzWHk0elVH?=
 =?utf-8?B?STZrTXFQcnJPYVd0YjNuZmFIMDBCZVFOREFtd2c5My8wN1NBVHhjd3BiYThw?=
 =?utf-8?B?aE1Mb2ptbkwxeFpDb3dIczN0M3FIRlQ3Rm1DZEdQVldKSWRCWHZlYytpY0Vy?=
 =?utf-8?B?S2o5MFNrZkFWSmtQZXNUZ3Q4ZVUzYzlMbDJvU2lEaVp0UHRzdkNGczZrN3FP?=
 =?utf-8?B?MzR3VGxkZlloUUhoekFrcmdHUEtCbHY4T2ZsT3htU3B3YmdnNmxKdm05QWh6?=
 =?utf-8?B?WHJQUzUvTDZRK0pMT21ldHB1bzgvUk8wZGYxZ0pXV3FjRjJGOVlyak9xV1Ns?=
 =?utf-8?B?VVZBeW5pK0lKeGQ0K2JyYTRQQW5hTHFZdGYvS1Y5NXRsOVIxTXZyR3hTekc0?=
 =?utf-8?B?a0FIWTN0bXNmRnFSYXRkWjF0R2VEY1F3WFFaYnBDUFRlVjlkcjFubEpjUGJr?=
 =?utf-8?B?MWdxOUtFMTM1RHlldkNESklDbk1CdW1SSjM5WEg5MHhBc3JIMVgwaUlMNUR1?=
 =?utf-8?B?UkVFUUdDOWFxMG1FQVhVMnJFZkRobmJ1ejNpQWNoNmZ3ZFNFa1NqYzhuMCtK?=
 =?utf-8?B?UHQ4N2pZMHg4ZXlvS2tBOVpyMUZBYnI4TXBSS2EzTi9PTDQrZ0c3dDVPVElU?=
 =?utf-8?B?WlR6Y2hTcTJLRjFrL3ZveVV3SmpFcTIrUXRLVUxIWG5uK29PWkMzcTVaTTVq?=
 =?utf-8?B?elFXNytrT1ZSdXpCR05pSnpodnQxaXVyb2RyZ1BVbDVtcndUa25SZWszcXJX?=
 =?utf-8?B?WFJMektvMFpSMGVvc3ZSRkF4RmMvT0NkMXpIMVpwbU4vNy9VWGVHQ09VaXlU?=
 =?utf-8?B?OEpDbEtPN2d4SW9jKzRmMTJxTFVVeEViV2hhendFcmZIZmYwVndZZlB6aDZI?=
 =?utf-8?B?ekJuazVQenJKdUJTSndTbnYxeXpxNVFRMy9YUGkxNWRUMTdQd3dJMnlPOVhj?=
 =?utf-8?B?cDNDZGRBWXh3WmFJS0FWK2xaQ2swL3hHbWtYK1lEZ3haR3BwSFRuWm9HbVg0?=
 =?utf-8?B?U1RteFlmS1g0WDF4REhjMm9JcDE0OFBCR2poT0puOVZmeHZwMVh2T0ZZbXJU?=
 =?utf-8?B?ZElCUmJNU0JFRWx4cjFhV08zOTBOTnc5OXZzd2Q0Vkg2SC82RkUvc3IvMkpO?=
 =?utf-8?B?Wm1DaGZXQ2M5STk1eDN6MnY3bFA4cWpZcFAzQ3BKN3E0SGpYK3JoUnJCVWVU?=
 =?utf-8?B?bUZtcDBvcVByR3NZMXdXZ2ZZWVE5a1lpdzJlYkVDaXpSckliaC94QUNETENw?=
 =?utf-8?B?SHpMbkpjbDZ2blNsN3VlUytTU1dENEdTSFZHaU0xeUJlbjltWHE5MkxXeFVz?=
 =?utf-8?B?R2lQTTgvQXFubVUyU0NIeTliWXhuRFNCOXl3MmNMazgyQnNEVTdyZFI1OEdq?=
 =?utf-8?B?QjNwWmJBN091SHRrd1VxS2xzRGp5Q0hnd3RaRFZORlZoRHIvL1JSZEFpYWxP?=
 =?utf-8?B?eFBvUUlGb3kvODBqVTM0aU9SYmJLSHhnUllHNUh2SXZSNStJYmMxVzVtakJC?=
 =?utf-8?B?Qk5OdTF5anZxeEJndEcyQ3NVU0FPVVg0bnNxK0FpMTVHOFNscVNMdm9UNzI3?=
 =?utf-8?B?MmFQUDhBZ2NTdGZYQU1rTlJZZEs2M3FhM1kwUEhhVGRJa2xYSXd6NEdYcWRs?=
 =?utf-8?B?L3NuUk45RTlqMy9tbWdGbGdIY2U2RlR5V2JwN1NWT2tVTWtjdFZ5Y29vQ1E0?=
 =?utf-8?B?VFI5UW9kL3FBcXljYnUvaXZnOGZjbWcyMG1qTGpNZ256dzF3NklxOFBrUVVx?=
 =?utf-8?B?Z2NDUE13andXQ2ZZdzkvNUU3WnZiNDJtaFhvUlV4SW9QMXhMVkRmUTNyTUFI?=
 =?utf-8?B?SlpjdW56ZjA4L0E0cUtHbGVLOGswakVxRXB5aWk3bWhoV2Z1QnBwMm5iQUtq?=
 =?utf-8?B?YXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VMscnl+12IlBUFCyddu2zmYEJ1bnxBNbtcKrS3/cExpDCgleVDAx/AaD61Kq8+PtBSxEnd9i87Nvs30GXLcoRBYmxZic/YE1IaP2GxbxzlNPFWkfqGveie+8VMIXH8MlDf47iLHqT1TwyWhdE9SzNjmDmYFWKUC11iEYxsW+XsA56DiDjp5z2TMGGF/D1TpAuidVBEUlDWxFKONFcMetE5zSQdwd84lce27DzBqlElvK8s+NcYH17reS79guOlQCZW0rUTDdS+mhBg7O/HKkMuJLC4EMUlxjzDQgaA+5aSljyn3MUE93HwPvWQzJ4ZVxbaQPmQxNVtQiQjVsr3L5xN85OchhKALs/rPJQ+HAQTms6AzWdjWK4gOj68+47gLz/zxKWVH+4tPj0qXh+dpixQh9TLqmdeB+8dHSyuF7Fi4CSeLoAauLRtqxVbsj/bax6PeVbBMwpe64kXLsDOLMl/gA8lUYQ+pHlWd4i+aG+ifU7NQTUu+sLvmveQb5bXa1qLOXnjMSCOsQdlX0OdyOZmLJ3vDWcTw+/R/nXK92WVU2/Nn94xaS4Lzc8IvLlDUo1UAJuBjWrsGJHKvXau3i4pU5IVp5/E+FgpSW93sJdnc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56e0eade-b22d-4fb3-8789-08dda46ff073
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2025 20:31:24.1892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X8J41BJIhRBMySetMr7tLkmFpYAi22EkVEUG99kde30yzu/4a8+bfUE1EJcH0c7IpAwtYvd7mlaqc4yHoNnuLbKeW0UlK7Xuui9VVamDEaA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7901
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-05_06,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506050184
X-Proofpoint-GUID: uXaS1HGjPr0I8WMYMioAvf_f9fj8YmJe
X-Proofpoint-ORIG-GUID: uXaS1HGjPr0I8WMYMioAvf_f9fj8YmJe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA1MDE4NSBTYWx0ZWRfX2bTa0616VWOS 6px3kvcsQoUmAM0yuuwFqdrCYwftrgJ4wxmx1c/k+xPHGPM4gtupjibHhNmapE3PjfIBbZindZt k5MjT6UrG+M+5YmJSrrJDMKHlQdCH1z/nn9+rbGPmDFK6sqW+CZmYhEoNxqEreiIV8CDIzQi3xV
 3VPGhCuQLhSe+0aQeiyET9io6dr/VOBENz/xANYAptsBJ/A4OoYcy/3fo9Zwogl73vhHQLKBbKZ g1iwC86mBxPjzrQZxoChVzqNErA3yzKnpIc9Xvdhj8lalAlrhWEqu2SPUkXMFRVYQ6v8vRUjtvM XWbh7zjDrs4/NKP0pJNdUmQN0isz288WVAdweSsn/p8B3Wn5zcIbIXeMK93yYV6o6DSb3d4CXqt
 NnmvLwoaOKfV+mJ0BoZWBTnw8a3HZOdJFMow0P25t6v6rDN+/wRxVPB7jXRjViCYhAhCmS6y
X-Authority-Analysis: v=2.4 cv=FM4bx/os c=1 sm=1 tr=0 ts=6841fea0 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=meVymXHHAAAA:8 a=yPCof4ZbAAAA:8 a=ItSNZql-cyZH1UbtJ04A:9 a=QEXdDO2ut3YA:10 a=2JgSa4NbpEOStq-L5dxp:22 cc=ntf awl=host:13206

On 6/5/25 4:19 PM, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> When the __vma_adjust() was converted to use the vma iterator it removed
> the functions vma_mas_store() and vma_mas_remove(). These functions called
> the tracepoints trace_vma_mas_store() and trace_vma_mas_szero()
> respectively. The calls to these tracepoints were removed but the trace
> events that created the tracepoints were not removed. Each trace event can
> take up to 5K of memory, and it is allocated regardless of if they are
> called or not.
> 
> Remove the unused trace events.
> 
> Link: https://lore.kernel.org/all/20250529130138.544ffec4@gandalf.local.home/
> 
> Fixes: fbcc3104b843 ("mmap: convert __vma_adjust() to use vma iterator")
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>


Reviewed-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>

> ---
>   include/trace/events/mmap.h | 52 -------------------------------------
>   1 file changed, 52 deletions(-)
> 
> diff --git a/include/trace/events/mmap.h b/include/trace/events/mmap.h
> index f8d61485de16..ee2843a5daef 100644
> --- a/include/trace/events/mmap.h
> +++ b/include/trace/events/mmap.h
> @@ -43,58 +43,6 @@ TRACE_EVENT(vm_unmapped_area,
>   		__entry->align_offset)
>   );
>   
> -TRACE_EVENT(vma_mas_szero,
> -	TP_PROTO(struct maple_tree *mt, unsigned long start,
> -		 unsigned long end),
> -
> -	TP_ARGS(mt, start, end),
> -
> -	TP_STRUCT__entry(
> -			__field(struct maple_tree *, mt)
> -			__field(unsigned long, start)
> -			__field(unsigned long, end)
> -	),
> -
> -	TP_fast_assign(
> -			__entry->mt		= mt;
> -			__entry->start		= start;
> -			__entry->end		= end;
> -	),
> -
> -	TP_printk("mt_mod %p, (NULL), SNULL, %lu, %lu,",
> -		  __entry->mt,
> -		  (unsigned long) __entry->start,
> -		  (unsigned long) __entry->end
> -	)
> -);
> -
> -TRACE_EVENT(vma_store,
> -	TP_PROTO(struct maple_tree *mt, struct vm_area_struct *vma),
> -
> -	TP_ARGS(mt, vma),
> -
> -	TP_STRUCT__entry(
> -			__field(struct maple_tree *, mt)
> -			__field(struct vm_area_struct *, vma)
> -			__field(unsigned long, vm_start)
> -			__field(unsigned long, vm_end)
> -	),
> -
> -	TP_fast_assign(
> -			__entry->mt		= mt;
> -			__entry->vma		= vma;
> -			__entry->vm_start	= vma->vm_start;
> -			__entry->vm_end		= vma->vm_end - 1;
> -	),
> -
> -	TP_printk("mt_mod %p, (%p), STORE, %lu, %lu,",
> -		  __entry->mt, __entry->vma,
> -		  (unsigned long) __entry->vm_start,
> -		  (unsigned long) __entry->vm_end
> -	)
> -);
> -
> -
>   TRACE_EVENT(exit_mmap,
>   	TP_PROTO(struct mm_struct *mm),
>   

