Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5792E36FE;
	Mon,  7 Jul 2025 15:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751900853; cv=fail; b=XblFzOZwJ0a04Qr7I1yscSddEblNy0l+aN3m+KqSJtAPs/Ulx051zHtEh+87OrelrY/xKaiCZriTzfAgsOREc2zuNFpFlXhxTWGs3J763pUDPx205Y/iK3S6vp/JgRHBt9lM7VVPi6imwY8oq5BgyXJWK5Arq5Ng4HVNm4eb1LQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751900853; c=relaxed/simple;
	bh=YcBHl0cW3CWLzQ1v/nTC+XtzI8aXpX+mfhzgg3lZ1bs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=I9Fot8xSNsqC9/14QlNdf4f3D8/Juvh+8WXcdRZE4fdrRyeEfWubriPCkgsi0OGp+jVdj40BmtN09h0owhpGK2UYWiFWTNdYhdP2ufBE6BLrESCB8uWW7QNYmNXckRfcRqtz/qumLOpJfnkbsEJ0PR3sG+G/G+HAA/sHdHHWExI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UTVkAmJ6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XCdBAEUZ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UTVkAmJ6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XCdBAEUZ"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 567EMoBf015989;
	Mon, 7 Jul 2025 15:06:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=C1ipGexrFEDdukyi23
	6/6lyoYJOOjU6mJVa2blYpgxQ=; b=UTVkAmJ6PrxPCPl7Znv8qbs1imXU3mBXkP
	c5PVnPoGNndGYeSJ1hObsJwkY3dWd5l5JcHS74IxUXzwTOFn/jrmVhu8GmvZmy5J
	97rIUnrPVCsrvAoZVlhvFm7EUw4dCfy4MxplRvkL37X2j0stSvGZLOQUOiRYbOn3
	E62dAHkUB2jKDleUqJ9VhyaLyi1mmt3DKxyzSoz0Gd/eZdh8nmFvZ8k0/j4c7R5Z
	dDVM4jebFOtItgw+pXUuQ0s09v9y4OGcYBuO22/8qHkr/bSz6PN8hsCytS7g1oRl
	12CZDJHTiXCCJBfdoFABYyL45q14atgj/eMneDQ0gjErC392jnSw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47rfxgr40w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Jul 2025 15:06:35 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 567DRaW3040566;
	Mon, 7 Jul 2025 15:06:34 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ptg8m37d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Jul 2025 15:06:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yQRjGQzrspQm7QztwSx3rnxAUJkcXJ/qsG1AONPhv811m6GuepQMioueYbli/zJX6D7m4vfZYgmsaupmM0XJfMPxjuAO3wlwPsLIJKuMj5AmyhmYTkJr/ywWY5ARBJl+m+G87WtqC+6ituhLKiWX4MB1pwBgg0yBBzH+xyfzZvDfBnWAWSVhjLW8anUeH4mt0nKKQBHTAA3SyyUFNTfRvnGrcUv2a9Sn3Fey414OxS3js1ZGwhfcvMdxhGybhdviDqK2Bpb7eXobVQ7xepGrDLtitn1grOfpL9JwnnvXv8u7DqHLEfTSVJUdOr/uXaud9h8fNEjgKBnuXs0w6JgOig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C1ipGexrFEDdukyi236/6lyoYJOOjU6mJVa2blYpgxQ=;
 b=l4On/eVzMifWllCZB2HyvB9v2FU9tLVHwkoBRLy/A5/Fm6ziWOjZmdc7qaMk/tJn0hsZo5rcz8h0VyrCYswk2Wf8pQx3GA4n5ZUy2KicG1uWRmeFfXheR7vImkLLBXuoDR/uz8F9DTHpDByG1GgyOoHZxhMtElJiJc5STcsFYA6CYTDtgjt8NKxJoowLHRwa5gTJl3zaSh51yGcTXbSk7offvD+GYsgbIpiSdSXlYo6/zz3Baz4k9Qxm494F+oIUiDY60CsxjkNJIS8JRe0LCuIg+SeBCRs0bA5zabQsgkLlcDn8tSkv17Of+3Slyvx27l/8lDCx7t3xEi7X9TFuFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C1ipGexrFEDdukyi236/6lyoYJOOjU6mJVa2blYpgxQ=;
 b=XCdBAEUZQVIqB34WBp3RGZ1F78rYj3SILgYzW6DnsG/0Ffsc8Rc18IJM15KIJ7lSzn/NzFCeqMUbyJaDLVGofa6gE0YqUtsGjNSedpYXhwJjDS/StagXJT1/XUsi7kH+PlLJuDAB5L84pUyp5wetJjaBIcRBxLUo1e2yqmlY1YA=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by DM3PPF905D77450.namprd10.prod.outlook.com (2603:10b6:f:fc00::c37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 7 Jul
 2025 15:06:30 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%6]) with mapi id 15.20.8880.015; Mon, 7 Jul 2025
 15:06:30 +0000
Date: Mon, 7 Jul 2025 11:06:25 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Daniel Gomez <da.gomez@samsung.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Luis Chamberlain <mcgrof@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Petr Pavlu <petr.pavlu@suse.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-modules@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH 3/8] execmem: rework execmem_cache_free()
Message-ID: <oez2aoegd2dfq4h4fg2on2rsgwp36aumpedmobxkj7dlmaoeyr@sqz27uhgf3f7>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Mike Rapoport <rppt@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, 
	Borislav Petkov <bp@alien8.de>, Daniel Gomez <da.gomez@samsung.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, 
	Luis Chamberlain <mcgrof@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, 
	Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen <samitolvanen@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-modules@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org
References: <20250704134943.3524829-1-rppt@kernel.org>
 <20250704134943.3524829-4-rppt@kernel.org>
 <20250707111102.GF1613200@noisy.programming.kicks-ass.net>
 <aGuwMtxsouXvdiCK@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGuwMtxsouXvdiCK@kernel.org>
User-Agent: NeoMutt/20250510
X-ClientProxiedBy: YT1PR01CA0129.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::8) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|DM3PPF905D77450:EE_
X-MS-Office365-Filtering-Correlation-Id: 33714a62-a003-4138-3e34-08ddbd67da6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?t/MUs+V/84BwH59BlBjU3rEHWoYIGSM25iArHB2G3EomOppLWZJF94Mj6Kua?=
 =?us-ascii?Q?e6aQU2E2mmVRy655tts1Jntk5omW7OYAS0UgpxZ1G5PP3TnWZocvAZubp7i9?=
 =?us-ascii?Q?osjKhaoeWS0kLQ4TZR1Tgx2rtKVKg1rPJZgQQP3+LJ3gh8L+6jreHnco8jg/?=
 =?us-ascii?Q?Ko6lUD6aFvMkJF/mEuJi3ri6Jv/t+vwGnSStp1ZHlrLsLr0qCp/o3NV3JehM?=
 =?us-ascii?Q?LBnXYaVUEmlxFFKCBGzIla0ruZoHsm9R7yrlqiLMIpYLOcgDdg/FtH6Em+Z4?=
 =?us-ascii?Q?Ia2QizhtXaxTWXM+ksIoEi58TjJMh8vj8U8JLiGfZ8xhFCbqXhnEglTKyCDP?=
 =?us-ascii?Q?OsY1EF+S5gDrF+zl1CmLqTgOINW+vVnhEmquTLV/Kx2WH1NryjgUp5wLPoMg?=
 =?us-ascii?Q?/VCkXRLGHZhVSJMuBNNNZQk5SIMLeYsBt6ufK/1q5nMcJXBOhPOxJk18Lgiv?=
 =?us-ascii?Q?HLZptjAW4JnATBWMfDQE8gW4cUFC81aGCxaAJH2gaRwuOW1tXrg993YRV229?=
 =?us-ascii?Q?g52ltsdJAjjJ11XldfF6WzM/WBdjeaNa0pM0e3KUKpg2Sks69Ar1psFexO/u?=
 =?us-ascii?Q?SNJKDHJq9BoXzuKVABIiFuEWBcoL+Q32sbaW/UpkB93LSdpP5Ney9URq8Z65?=
 =?us-ascii?Q?m0dr5R6XNjUiPi/xjKyJ9eW1W4v1UlZv1OvbhB97h7Aa73i61N2qPXQ9Hrj2?=
 =?us-ascii?Q?2MxvEf5bMV/9LFxLaNi0wh0i2UB1qumnGh1Jwx2/fZYr/4o/ykgqaM1Mt3kM?=
 =?us-ascii?Q?+03+TRIQz+M0tPJpCMPpTXJML0NOXnesGfjUSHrS0HgmKTaVRfUi+v1Ct+2e?=
 =?us-ascii?Q?9/WE+6ucPcEChiiy0fDmPOHdTTdoyFIqxTjIDyKcAWnmHvKtXSaX1LVjXFlF?=
 =?us-ascii?Q?25ZltzJVX924dkOH9jQBCmUmLSvjTpSfQY6i+tPKqIdeLwCrE1NqfEXk07Nh?=
 =?us-ascii?Q?1xCiJcGOObob57w4N20ZHJhzWfBGW95QMtZrSG1H7fToYqGVhsL7S+lHkWgR?=
 =?us-ascii?Q?cSi4TLHHwtn07PBLBv5PF6kbMe13cBE+pJ31q6OWuTCY5E2vzmWn+LbF2AJr?=
 =?us-ascii?Q?V4Q4xoeqZsRC63A2y1fmDxRUG1iMGwluYpeAge/mODJEDTwTEvQK0WDD/k0B?=
 =?us-ascii?Q?4zY3p2UeGQSn9OX6PXmjiQbXn8ScR2qW/cqGuQQ6Dw+zKzjiE1H33SIhY3AG?=
 =?us-ascii?Q?PYyW6d2QV0K5hmUyewQ6pk1RZ1VB3McyaO8+LiyfncdcDk7K6IFk74hRcKf+?=
 =?us-ascii?Q?EkqnERZI8P51+yHikGXeMlKCjrBFEsU4DF1hisI0OkxSoFrtc61tFQEmBqxg?=
 =?us-ascii?Q?2lIVR/+kQAz6h1HZn9ms9pm7wzJ6Jn1d5daE2DlHUEQe1LHdwyFxiacWx8+r?=
 =?us-ascii?Q?NItwccETlnUYhTSvr0dhBrmX6htSSkOaupnOo0g7rqvWlY83BA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Bt46qWRABvizY7n3Fb7YzP9N287Aom4Z+Vp4e7D/8AyBN5o69WCZWts0K276?=
 =?us-ascii?Q?5mBoNtSw64+xIN0oKNTFnl2J7fmplLZ3eA1Yc0cfwpubq/0iMybSG+t/mUlh?=
 =?us-ascii?Q?9UBF6bQ/cyeWEOw4zs26dM9/oyDW9R0A8Gca2Gy//cPJS8qt4uKM6PFDgqqJ?=
 =?us-ascii?Q?W0AUtALaGfYqSFvxz1hCAcFUuEngjFjfwQInWTUCIR5F8RYeS4F5PbGuU/RG?=
 =?us-ascii?Q?KoNReHCksMDCev+YzUkU5F8KxgkBmiVMRA/G2lfQ7eCLaoJIIo7PZD7HtwfC?=
 =?us-ascii?Q?zgRApaTKgTVMYz0Y6JPFTuRRs7jD32ERcjg3zNTn46Fv3y9gQnN1089plioH?=
 =?us-ascii?Q?u9BDXUDbfU3wqtxD3GShMQHyP395wHuL+yOW694pBD3LPELKiyBYyF7PSk29?=
 =?us-ascii?Q?vP6Z435g0C0tLCPqaeFUuzhBse/Z4lGrCpQtGR912Pgy4B+0nJebBZm/VyCM?=
 =?us-ascii?Q?nRsZfvWybt3CX31AQ/Hb9ApCTUNFr22XJjHo0AxJONmye33KR7/UFmmKvZxE?=
 =?us-ascii?Q?7cSqnil5kRZCTylGidiA1HqOtePyErfZD5qK0nmIb3AQOZqjpl+wFmO9jaa7?=
 =?us-ascii?Q?Qdxu4tHACJh3JcZ5avpP9P+yOXi1Hp/VEKwamMcaem4jDlHF+YK2GI9Hjpe2?=
 =?us-ascii?Q?yCOBcIMhzbOKRqmTWU/E3IlH7empIVS3D9OJi0ddm1QzCOgP3hN2r+rbVgfZ?=
 =?us-ascii?Q?MrAf7t/JAJcylE1hSssANt9kFP1ltwoTcvS3/EZzR4o9rAFsP3+mGoFsFg8r?=
 =?us-ascii?Q?oBKcp0W16yXjINpPFUAxaoKLj5vP8U73pg4zCJIQ2/bIFZ8P/e0Mfn/tdb95?=
 =?us-ascii?Q?8NOA+af6XmAOtNVZ2pzJPbh5jE5P2ijZFDmQFwtvVsCYfb78vuT4xfPnTajr?=
 =?us-ascii?Q?6hVCOjj/EjEMA5qfhZe4OC+uyieXLXXCPR1UFyBwSBvKmw0Batv3hWi+nF6r?=
 =?us-ascii?Q?t8AtZbr4ZLZskWFk1kXgX70oMcdJXEqw8RE4QGLUlUvxB3QHXPfhlNXUFI04?=
 =?us-ascii?Q?E+nrND6rTtIvgkZeFX+L89U4/egwsMgaUsjFzOPkmPg+WMNoW2fzISmNfUVL?=
 =?us-ascii?Q?9GxiiNHgBc0HudHEIGRIqcB7jrAwrFdDi1aJ4vt6nUzPplsqGMXLWSRst+9F?=
 =?us-ascii?Q?arv9j4v6RMr8ZV0mudaF5oXWp+48W5OuJ9dDBBxIdVAACBxz4rLCoAc/x8cZ?=
 =?us-ascii?Q?SBSjl1XqE3i7//soH0U5fbmWn0Mc3mtFStAGcyg2vq4DgYm79CYH19JrcoUs?=
 =?us-ascii?Q?IbeYQ4CY5rzUYBEGNI7kM1jJzY/nAQQ2qIZUBpZoUEH5406BH7JiRFYPjG31?=
 =?us-ascii?Q?SyZb0SwyS2a/1Nz2EwOv99bOz7fDJR8G20SY8Z4hXbO+bzyuxWs1Q07SsFG5?=
 =?us-ascii?Q?qmsIMnh2VAmWwVde0D59/jyRsmhLPZlY3MyexoUSDBHub5gol9JvNuhvIOTK?=
 =?us-ascii?Q?+b9f3sRLNxkfmYQjiIvyeiCYU6nGy3zZhwx/G5EKvzNL2WbNn36pXxTdcIa8?=
 =?us-ascii?Q?BXkV13XM/nPretMXMTde8xgYgf15PRiB94r1Wr3PBg3hbAipct9kJ+FZy50W?=
 =?us-ascii?Q?sWC/Ro7ArdYEIgENmmlguK2jz7EakIrx6HYtLG4O?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Cveradww2skkRjUi+dvu1IrncwtnLLIGnU5uSKiZ0PaJS6VqsgCaSBq+RRy45j7I9Z2ThyHoayhB7atx7mB06UZ2tgD7VfTRfa5v2NkjgA/Va684lKcYckgrDBx/jhuUM3smHomcgMJZfmAyxp9AuUeRjlibYpc/6Exa845Y9ZCjxBqTUEylN1HSJoenaA9dYA1q/BWCXiV1DrOjouQPwk3ORBIYywFViPs6jyaGyhPagoMjaNVsuk1yxw3AJbX8Ur0fApMZ1MeNPJHs3ahVpQiayROLMAg9NWEE9mM2bAO2Ns2OxxrdokWMAVy1A7O8rCtV1epqzIXebsHvAav+XSpuoNS4ZKYh6CPWbwSlTLEtzrQu6E+Vd/j77j/+de5jQ/06bfQ9YMhzUD0lSawcw8eHPaDtFL7MqUJ1zaJo4hu2neNBAFEfTULmEpMDioRsKf8rgHC4IwoUc9n6dTMNlt+nn4xteG3H28NR71/08zc7rxfhAK2p205306d44q+u5MQvjVdLtFQPIHrUZtvj8t0Ttby92dTr1s5TvZQGfQom13anL7wX3qcLOpvilRpRfO8txXqILp3/Va/tiLlhnaJ2TvNHi/BjJkbPvOFEuqY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33714a62-a003-4138-3e34-08ddbd67da6e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 15:06:30.1860
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CH9ELfhVcQSM2L/MtRL5ZZ3kSCPX/R+em9wYxjrCO6QQhSnmgQldgPIosrzqolOWAuZUlESoB9cHPbE7iq/wiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF905D77450
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-07_03,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 phishscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507070089
X-Authority-Analysis: v=2.4 cv=YMyfyQGx c=1 sm=1 tr=0 ts=686be27b cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=lg6h33418Od_XcSoiEEA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: Rb4_2TVe7vcpZJ-LfBdiOFiXePZV0T5e
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA3MDA4OSBTYWx0ZWRfXyjnv8IrxMeGR Bln+vhgK6QwWWSYHMXHpFYl66ENr4CNyuvw9NAzwpeRKcCkUt47ahtyTvd09FxZBYd/YZJbay4A vM9fnqcByIhk94W+uKhoI+8KVbJoacRGFSUbKMMUlDxQiKmVP1QcEd5NA/8AttC6v8j95t2Rmh7
 m9qRE3M/bBKnHc261fNcqOfZe7UjPMeUc819OWhfh6hikDxaINsCC4q2TPzm8fg8vmykaBg5wcR Xtx1hZdxCMs0HAhvhHK3VjNXQuHJiTyyF5cS0ZHLPr65jVbo4A5X5FdS8Kparu4Jbbw/Fj/3/8+ OYLh4YXjr4r1c8cntsb8pVrVzPoY2wL1yrAztJsKFyTKG98MYyQmUQfjhGXSrOQ1ZvHnxNA77kn
 xYe2PDh8cGOeKVQBQxFUOCpQ42zE+rl/JZuPn6cTGIZqTdNYGCTgpkfywnhupE7eY2TaOwZJ
X-Proofpoint-GUID: Rb4_2TVe7vcpZJ-LfBdiOFiXePZV0T5e

* Mike Rapoport <rppt@kernel.org> [250707 07:32]:
> On Mon, Jul 07, 2025 at 01:11:02PM +0200, Peter Zijlstra wrote:
> > On Fri, Jul 04, 2025 at 04:49:38PM +0300, Mike Rapoport wrote:
> > >  static bool execmem_cache_free(void *ptr)
> > >  {
> > >  	struct maple_tree *busy_areas = &execmem_cache.busy_areas;
> > >  	unsigned long addr = (unsigned long)ptr;
> > >  	MA_STATE(mas, busy_areas, addr, addr);
> > >  	void *area;
> > > +	int err;
> > > +
> > > +	guard(mutex)(&execmem_cache.mutex);
> > >  
> > >  	area = mas_walk(&mas);
> > > +	if (!area)
> > >  		return false;
> > >  
> > > +	err = __execmem_cache_free(&mas, ptr, GFP_KERNEL | __GFP_NORETRY);
> > > +	if (err)
> > > +		goto err_slowpath;
> > >  
> > >  	schedule_work(&execmem_cache_clean_work);
> > >  
> > >  	return true;
> > > +
> > > +err_slowpath:
> > > +	mas_store_gfp(&mas, pending_free_set(ptr), GFP_KERNEL);
> > > +	execmem_cache.pending_free_cnt++;
> > > +	schedule_delayed_work(&execmem_cache_free_work, FREE_DELAY);
> > > +	return true;
> > >  }
> > 
> > This is a bit if an anti-pattern, using guard() and error goto. Since
> 
> Good to know :)
> 
> > there is only the one site, its best to write it like so:
> > 
> > static bool execmem_cache_free(void *ptr)
> > {
> > 	struct maple_tree *busy_areas = &execmem_cache.busy_areas;
> > 	unsigned long addr = (unsigned long)ptr;
> > 	MA_STATE(mas, busy_areas, addr, addr);
> > 	void *area;
> > 	int err;
> > 
> > 	guard(mutex)(&execmem_cache.mutex);
> > 
> > 	area = mas_walk(&mas);
> > 	if (!area)
> > 		return false;
> > 
> > 	err = __execmem_cache_free(&mas, ptr, GFP_KERNEL | __GFP_NORETRY);
> > 	if (err) {
> > 		mas_store_gfp(&mas, pending_free_set(ptr), GFP_KERNEL);
> > 		execmem_cache.pending_free_cnt++;
> > 		schedule_delayed_work(&execmem_cache_free_work, FREE_DELAY);
> > 		return true;
> > 	}
> > 
> > 	schedule_work(&execmem_cache_clean_work);
> > 	return true;
> > }
> > 
> > And now I have to ask what happens if mas_store_gfp() returns an error?
> 
> AFAIU it won't. mas points to exact slot we've got the area from, nothing else
> can modify the tree because of the mutex, so that mas_store_gfp()
> essentially updates the value at an existing entry.
> 
> I'll add a comment about it.
> 
> Added @Liam to make sure I'm not saying nonsense :)
> 

Yes, if there is already a node with a value with the same range, there
will be no allocations that will happen, so it'll just change the
pointer for you.  This is a slot store operation.

But, if it's possible to have no entries (an empty tree, or a single
value at 0), you will most likely allocate a node to store it, which is
256B.

I don't think this is a concern in this particular case though as you
are searching for an entry and storing, so it needs to exist.  So
really, the only scenario here is if you store 1 - ULONG_MAX (without
having expanded a root node) or 0 - ULONG_MAX, and that seems invalid.

Thanks,
Liam
