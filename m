Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430FE1DE883;
	Thu, 27 Mar 2025 21:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743109270; cv=fail; b=UQtQfnMWUfQppvPtKrYiqYBQqUNj6j7itscJYKXQf6GR6mYh7DPiJSYn5n02JVAM/RlAq9gKb+NKIwhFTxpd6ZeU914lTUg7SImluF2CYDfuNNnSS4GBYtHP5qXaLqi+9sQr654Q4e9+CsBDpsXs+WB0XVd7879es5bA4c2qJn8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743109270; c=relaxed/simple;
	bh=NmC94mS9vE3IFz+OTZ/3uwn8yZjuWT/lRJU0f3aSop8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DsYvT1JxXrrvA3BkP1GAw8PLBROFog1i+cZ9M45enhOMqJk5KN4lS/+ReCaMgJxszSo0H9R6lQIMfcHtiY1q/UCwB/iN1aQjVfDBVWu8cu0sQOFkJCCKcY8+Gbfj98Ls+HOoff6qz/55GlYd/MuJiw2qTU9Fj8XWZQjyPIlLR0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jK/cmVfP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Jw7QX6WW; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jK/cmVfP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Jw7QX6WW"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52RJtv9g027994;
	Thu, 27 Mar 2025 21:00:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=RerMWp1eb/K603d9p1Euhjj2cXYFx3rRoR6kxWzXOTs=; b=
	jK/cmVfPJFRLnCp4DduKeYhgfuSkiPg1H/l9+dhbiknbtiMR1129aag4+Svf9Fhy
	cW21dZ/NXih2NoQLLdXMydDqoWRLAEKn5aNfuU3B5A0r3Z9b2tsLBkY1geas2/Xs
	zwCujN0VhJJfr5mjndqa+CjojvLXarZNog7KryX6b6aOGBUxOCt+jh4SYCognWFH
	wXS6M98CgQW7l43oh3QyQRzlplyMKSltoLgXnPB1diOmjSCaOepovoWtUIRClhGj
	XnXGSdRLq5GxWc7IwjCUeFx2wRjvCyRk0qgo81uGRgRao9BV5NE1HZ9GemonbLsh
	szVVFN0JIuWN1qcg77tAFw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45hncrwngs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Mar 2025 21:00:55 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52RJmdbq028689;
	Thu, 27 Mar 2025 21:00:53 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45jj6vx5t2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Mar 2025 21:00:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mzDil2HcQkg3UuMz8/rVQ+fTEfaHSCOUgYNzRK5tX7ZluGw9LniVvyBgpQn9Fw56Q96L5TDisf3l+HpbH34m34KlA6UGq3IBjbitqVIoubhKJGQ70JNLSSlwOpWYTTBfMeMAvrQukprIv+CXKDaicBOMpIrueavcjhkhQ4vo1YO2FXDx2QGDtotEedoOisW48fUeZ5UL9nUeJDlLPqy2fNUe9USzTuRMuMrwHZg+GZ9A7lge9/jkdfvuygMYJ5MqNw0K7icka7Yfpa5CvPeqzyQh0+Bu8JUq0mRB6N0mFEzgaKqLnOza1OOwWN/uCC9YOGcsfyS5YWCzBuwjyDkO/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RerMWp1eb/K603d9p1Euhjj2cXYFx3rRoR6kxWzXOTs=;
 b=vHUVwGWLz0H+nrB3Zi5QHBzBLUg90SJbIsbdAjyOciw/7Sl55N04PeQMInHtOmb5jVwOswSCdGypblbmfBg65J52q1GJleMuGCxvSBZB0dKDqnSBbxEWTvY9mKb6SYo/yV47UmtJDLA37pnBxL07n6NdklAFA15OA5hIpvfk1btTFGojAankd8O22J1T1qIVFUFKRwWADs2IiF+2tz40Y5GsSzqUjLeB0e9b3Ao1MIkHkySfgGcZ9haZfhdicp9VQMVc7akrROEea+ubfF0EBepWShBUBbYk9myOM6y9+fOVnbyOESREJxL8h7hoqE7pqU4KXn1hEu2LeoW936tbOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RerMWp1eb/K603d9p1Euhjj2cXYFx3rRoR6kxWzXOTs=;
 b=Jw7QX6WWlG5ZyiOLUrCsPalbbKjwofTBUuzc3YODFGveYiZ5vMNg/iy0eaUFq5EuJVMfeq9jaEyXygqeJf323Vk/XWgI1ZBz1irbFQAzrffI2NZtb1PVCuX/Y7Og/tIrlcKl3z0T1iaxHlpeppq23/KRX+kVkrnV0rGEpSYYdRE=
Received: from MW4PR10MB5749.namprd10.prod.outlook.com (2603:10b6:303:184::12)
 by SJ5PPFDEBD75B51.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::7d7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 21:00:46 +0000
Received: from MW4PR10MB5749.namprd10.prod.outlook.com
 ([fe80::9a04:a919:657a:7454]) by MW4PR10MB5749.namprd10.prod.outlook.com
 ([fe80::9a04:a919:657a:7454%3]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 21:00:46 +0000
Message-ID: <d9707265-d6bd-40df-8e7f-4213851ea33f@oracle.com>
Date: Thu, 27 Mar 2025 14:00:44 -0700
User-Agent: Betterbird (macOS/Intel)
Subject: Re: [PATCH] tracing: Verify event formats that have "%*p.."
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
References: <20250327114911.2c713511@gandalf.local.home>
 <856e7f9f-2a7f-4b94-b6b9-c1f7151a1f7b@oracle.com>
 <20250327143853.1cef38af@gandalf.local.home>
Content-Language: en-US
From: Libo Chen <libo.chen@oracle.com>
In-Reply-To: <20250327143853.1cef38af@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7P220CA0121.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:327::10) To MW4PR10MB5749.namprd10.prod.outlook.com
 (2603:10b6:303:184::12)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB5749:EE_|SJ5PPFDEBD75B51:EE_
X-MS-Office365-Filtering-Correlation-Id: 229de2bd-69c2-41d5-4ae8-08dd6d727215
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N2FXNk5YN2VmQXM5ZGR1c25lMG9XSUplUWk4ZGVZb1pVeW4vRnZ4dmxwUFlP?=
 =?utf-8?B?RjFONjg2MTgxeXRxTEJuTEhlcXYxNERuSmgvZnVQWmtkRGdNYWx6NGx1Tzll?=
 =?utf-8?B?S3lHTkFtbnpXY3labnlhZ3RlR0cvV1hjL1ZSSGNkNDlGRTl6MTlqd1ZmSXI4?=
 =?utf-8?B?TFBJaW9WVDI0WUF3WFN5Nlo5a0lmNEczcTFTWWF0RkZhbkk1eG1EamtGMVNG?=
 =?utf-8?B?R3R3MEQyNHhiaGh1U2cyRldERW1LRGxoRFBwdnhqSkNGNHFQNHUrY0dUekZ5?=
 =?utf-8?B?UmZtdk9LNlR5NkptZm5aNFZwSlFpZzBPVEIrYmpDYUpRWHhjQVplYWJEbVIx?=
 =?utf-8?B?MWRUbEdGNkQ3RFpiVWUxV0xaYWk4M2owS3NFZ0JzMldFZzQ2L2xrZjJiYTRC?=
 =?utf-8?B?dktGNmd4clRCMGd3T2NGRDF3KzZlNzFLd1l6bTFqOHY4VE85Y2N4WlBEWThh?=
 =?utf-8?B?WUlPTHh3NnErWWpKcUoya0VabUhFSGtaSVZoZlZaNGp0U3l3ZjBFNzBqUmxU?=
 =?utf-8?B?NGl3czJhanJYVFdEZXRuR1poaThQbG50Zk93U2daYlplaDA2NFBBaGpqeEJ5?=
 =?utf-8?B?dDFHWHNKYzZZSjVDUm9zdHJpeHp3WE9vT0ZqalI4TjRkSkV6ZEovYkFYdHpK?=
 =?utf-8?B?YmE1dGVuK1F3WUt2b1Zvam4rY2U4c3BPbjRadmJ2YjRJelBHbmd5S0E2NjBV?=
 =?utf-8?B?bUVPYi92UmZhRzZrcmFVWlAwenN1a2ZDem03dEcxNEtWZHQzWFFIT3QyZVZG?=
 =?utf-8?B?RWRyYXRSSHhIWnhLSDNGODd2SUdOeTZKNzVKYTNJNEV4bTBadURobDZMRnFK?=
 =?utf-8?B?YzFwM0tRQzBrckJNdlFIY1lzTFpBSDlFaFlWNmJ6d3dQRkpKakRUODdhZ2ZT?=
 =?utf-8?B?OUc5RVZKRWQxV0pBdWo2SWlUM20xT2VQb01CeVk2WTZkSmNWSEh4ZWFVcnd5?=
 =?utf-8?B?RkhsMDc3cUlBMU1iZ0Vsa0RQOHJ1NjhXNkF4Q0h3RzNKZFZ3ZVlaZ1RRdUtZ?=
 =?utf-8?B?MGFQT05uOVRNdk5pUWxTSXYrblArd3JTbmlyK281QWt4OWpEQitsOFlXZGp1?=
 =?utf-8?B?bUd0bk5LSUwrYldDSFVpMnpUVWU5U2hmYStSZmpCeDNQRGtYdHFhcElnUmN4?=
 =?utf-8?B?cExoTzNNd1RRRU1HQTZ1NWRzSDlUVDV5RW4zUC9FaVF1djBOS2U4emlPRU8v?=
 =?utf-8?B?STBHaFZqOVBGNXR2M2Q5eFl4OU1wTG5GUW52U3lWcjRKNlRaNFJEQnRkVHBW?=
 =?utf-8?B?VDNoR1pMUk80cXFoVmNlTEMxZzhtNTB3Mml4cG9ZK0lxanRuWDJwU0ZTTHI5?=
 =?utf-8?B?bDE4QkRxWUNoSTdZelpOalgrNjUzR25tNzA1aGVXZjhhN0VMOVFhWjNXRkVZ?=
 =?utf-8?B?OUI2NXA5NUsxSlNhRzRmc0paUSs1S3F2dlJIZ3pXWEZnay9BOE82WXBVYmpB?=
 =?utf-8?B?VE5EYVRGVEM0MW52cVM1ZUJLdURSYVlRcDRUOXZMODlCT3dUbnhqTnE1NG9m?=
 =?utf-8?B?c3FSWE1DREttOTFPSW1ETStwRXBpa3FXdHFyZGpjWFRuYlRHTWd0clBRNWIx?=
 =?utf-8?B?U2xTQ3hyV3dRei9SaGtjWS9kWjE3MC8ra05sOW84a2YvRytHbWdydDFpbW0y?=
 =?utf-8?B?cTY0VHR2QjRWc205R1ByOFlNblJwcFhNUER6YXpRNE94cGtxeXlWaWxmdkZK?=
 =?utf-8?B?SFZRWklLNWZhZit6SlU3TC8zUldicmtSaTlUdXpKY2M2czd4cm1HdHR5M3VE?=
 =?utf-8?B?cmpyVnF4N0FPWUJoVm9TMXV5S2loa1QxRS9XMlJZV0VESCtZNXY2ZVdlVUQz?=
 =?utf-8?B?bEFLQnJocm9YUGI3N3BHVWJYRmEzbHcvajAxWmFWYUkxb1BLcEVKdHhKNFNw?=
 =?utf-8?Q?/aHtB9uDCvifq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR10MB5749.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cnY2R2J0OWtNUkhhbmJEQWN5UExSc215NzVCdjlxQnhERE9oOUZlaWYwUGYr?=
 =?utf-8?B?OTJ6MUtsTzFiVFV0N0dKSkI1bXg5NEhoSlkrMElZV3dBdnZ2c3JERE1URlE2?=
 =?utf-8?B?TU1SY1NYb0h4ODYrR0RxRDdBZ2tHODcrMm9QNloyOXZtdDVGRGRKVDJHc0kz?=
 =?utf-8?B?eHhiWThUQjFvQjVlNkl5bXBkaiswYjBkbE5HeVFsRDZSMkY2OUhWeVhJRXg4?=
 =?utf-8?B?U1p2WFZWc1VQQUV0ZWdiMGNSRE4rMThzUnR6YjFQVG81VzMzVitkSnFZcGhr?=
 =?utf-8?B?QWoxUmFxZzJnalJSaTlwWGsrV29JU0FNNVpOS0pyemZqVDl3UW9pZUVYbllG?=
 =?utf-8?B?SFNWVDFWd1BldjliY1gzOVdDcGxkaWh1UDJ1bXZkdFNiVmlnTXpJbEJIdXB6?=
 =?utf-8?B?UnZWNXJsa2d6bFZUMllBOXR5dXVQcGFMb0JCbVVYTWdZKzN0ZEZtdlJqaTR5?=
 =?utf-8?B?YUsxc01uL1FUVzdNWi9PaHkyUmwyZE1nSHNCWGIvcWNxZ2JXU1pHZWNOa3ds?=
 =?utf-8?B?Q01YSkNhZlRaL09UMjFibGFScTJtRFhQeTlHVTdpNU1pcVhqSVBuQkVnaUpo?=
 =?utf-8?B?MDN4aEpRTmdlMVRwVmJDUEdkamdRTjNZY1laQTFjSERUcTc2Y3dZcjFuMGtB?=
 =?utf-8?B?eDlCNmdTVHNOck5Sb2FFOWN1Vitka0M1NGdHT21NOW5rNVpGYkJIZE9CZjhH?=
 =?utf-8?B?TlJ2RHdkallYNlpEbmRTMDU5YkZhT3B4YnpHMkhPY1dCRkUxbE1kdXFnbVVk?=
 =?utf-8?B?eVhXZHpNdlZaU1hhUGEyNEF3cDZteGF0SnQ0N0VBZWNMajRuNVJnajE3Z1ZT?=
 =?utf-8?B?dWYyNWNjWVh5MERCbzBzWlZPY0ZQQXNMU1hDRnBvYWtWQUNJcUpZYncwM1cv?=
 =?utf-8?B?UmlWOVBRTmk0SlVsdVNkbjBNdWhrWEVXSG5KZXN1dzB2bEhNUno1eHl1b240?=
 =?utf-8?B?ZDV0U3lTaTAzdVdVdGJOY0E0WE9kR0dmZnFLckJCUXVJbzAwNmE4UXczaVMy?=
 =?utf-8?B?WjhDdG94OEwwNW1UQkl1dXF4aEFSTk03SmJlMklYR0hDMVJuUjhNUE9mY091?=
 =?utf-8?B?VHRHU0VzcVZjUTN1SGZRTWswZ2NzRVNFSFpnTzdDZWdBa0k4WTZhaGdqbnN6?=
 =?utf-8?B?bFpyNVdBZUFhb3k3NWc2VnVNN0svRU1mU3dkdGxCZkVjK1podmgvR0RnUXEz?=
 =?utf-8?B?VUI4MEFnQTFTN0lndTgxQlF4S0NSQVRWU2QrM2hlN2Vwb2dvQ3FJWTExTWJQ?=
 =?utf-8?B?U1RoQXBYK0FBazMzWnR1d29yWDYvRnN6RmV5TDdNV0Frd2JDeTlOb3dYVldp?=
 =?utf-8?B?NEl4NlJOMThpVXlyZGp1Z1dMcFh3aDYwVTNhRVNON0ZLbjU1Z2p6UjM1eDJz?=
 =?utf-8?B?ZFRGb2Z5UmxnQytOTVZERWNGL1FReTVlZnBldTJaUzV2Y2QrUDJqQnlJUHVW?=
 =?utf-8?B?TlVxYzlzUDBCOXY1WE1Vd2x0TlFrV1JhM3o0MlllTVliaTdjQmtJWFBNaldw?=
 =?utf-8?B?ZkhYb2JCYTA1Y2RhSndLMGtyN2d3MGpqTGFEbWxibHk5cmhUYlBCU2twdHpa?=
 =?utf-8?B?TFVXS3lPbkVWRC9PNzR1Z3I3VU9vc3I4aXk0N0NndjZGYVZIempoWFZSZ1N4?=
 =?utf-8?B?dTdNYUFLa2J2d0dJc2h0TWU3d2JYbmg4cG8yYVl5b09rRnBRTDVNUXpJaEQz?=
 =?utf-8?B?QmViZ0ZrNFNwMkhMQ1VOdzhvNkp4djZSQ2h6empmaXRFQU5TSFZ5Y1Q4VUVo?=
 =?utf-8?B?WjgzcGcyTkh6N3JOV2RsU2ZmRXZsS2FGcEZZb081UWFndnA5b1lyRGpOZTB1?=
 =?utf-8?B?TTJ6aFpIN1VCTkxDNnRUVUhpaWpBK05CRVhtTG10TWRJSHp4aDRBak04Vmgz?=
 =?utf-8?B?d2NvbkMxWHJ3M2FSMHg3WHpablR1OTJWL294TWdjVzNmMFJoVVRKa3k2R3l3?=
 =?utf-8?B?V3lxUFR2eitJNEVuL3NmY3dnZlM3Y0FIV2F4R3Ura2xMYWdzZjA4R1MrOU1t?=
 =?utf-8?B?S0ZzTFJCU1gyd05tLzFGem1aazhWMnlCVjRpZ2FkcXpORldnZzhZUUsydENj?=
 =?utf-8?B?QkhyV3FlVXFsQ3Z5SXZyNG5Ud0dxVURVejNtWW5jcGVBNkJXUnNoVzNnTm10?=
 =?utf-8?Q?CFJXv9OqD9oFMNP/S8Gtu1WXC?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zcq/2F+B7voLQ8ybGZSo48fRPygido2HAP+B+Jl1r6TMdq9QV1hmjDc4sy++cQh0BiUElm+/+eiGzfTQ8dzpBmCGjKhVHKSKxG14Y0HOiev/S3ErLeDyVBBICxnvcUrOvGh2hy10QUPAO6HhIvJDtl/ugvo3s4nKtPrXurvoyOAQ2e+72aYld+ni63BK5RjLli+gAjbVUNc7C/ookUq2VhUoqIWKKSQgPGJauakUIDCnD6wX3oPyU+lVOSfbTiFphGK6d1Q6u35Iae74Cf0fL+TAmDx7QvLSmcI8EsPs3+iqAI/5KuQUU+RvtnoFZYkrEeh4WzlY9FXXbWaRxecHm2v/EI9CY1X9336HMaybY7ZKLzuM5O07biyvavoDSYj3TcrrgQyCpviftfM6CugWKlJhatkHSo2FsmSrr7LvbzX5kU0FodLFR5nXUUOG5xhJybHjieYCIxXdJeGAWKK3Gp+33+f22XHnMHl6ByCphCrc3LIJuawFXXtjV4PqAu791tzbM+jvwScs2j6ey1CMa8KCht3hFMj1nyNMaWWFJFi4w8m2Z/o6s/CQEtF9JekYfYImmG2gsSCa5ZcWdL4Z0FQtf93pN+zYMDaeBsTJo2U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 229de2bd-69c2-41d5-4ae8-08dd6d727215
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB5749.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 21:00:46.6161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vlEngHWWivFKJ3H/2k5CU2f4c9D0N7PO8um4ycT/l5edcaKD2MmcrW0x2sfquFFFI30CUOT8Zf6t4VnvRIIP5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFDEBD75B51
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-27_04,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503270141
X-Proofpoint-GUID: N4ZdIDzYppbWL61kLzGBQYCkYhiJk3sL
X-Proofpoint-ORIG-GUID: N4ZdIDzYppbWL61kLzGBQYCkYhiJk3sL



On 3/27/25 11:38, Steven Rostedt wrote:
> On Thu, 27 Mar 2025 11:32:23 -0700
> Libo Chen <libo.chen@oracle.com> wrote:
> 
>> On 3/27/25 08:49, Steven Rostedt wrote:
>>> From: Steven Rostedt <rostedt@goodmis.org>
>>>
>>> The trace event verifier checks the formats of trace events to make sure
>>> that they do not point at memory that is not in the trace event itself or
>>> in data that will never be freed. If an event references data that was
>>> allocated when the event triggered and that same data is freed before the
>>> event is read, then the kernel can crash by reading freed memory.
>>>
>>> The verifier runs at boot up (or module load) and scans the print formats
>>> of the events and checks their arguments to make sure that dereferenced
>>> pointers are safe. If the format uses "%*p.." the verifier will ignore it,
>>> and that could be dangerous. Cover this case as well.
>>>
>>> Also add to the sample code a use case of "%*pbl".
>>>
>>> Link: https://urldefense.com/v3/__https://lore.kernel.org/all/bcba4d76-2c3f-4d11-baf0-02905db953dd@oracle.com/__;!!ACWV5N9M2RV99hQ!LTIVO1_O9wY2hBAnpNF5zcB1EFlC77zOnu4oVcM4DoD77p5ZO_m1LFZdPVJPj4spzye4JntXHOqOVxirPQ$ 
>>>   
>> Thanks Steve, a minor style issue below, otherwise LGTM. I have tested it, it works. 
>>
>> Reviewed-by: Libo Chen <libo.chen@oracle.com>
>> Tested-by: Libo Chen <libo.chen@oracle.com>
> 
> Thanks for testing.
> 
>>>  /*
>>>   * Notice here the use of some helper functions. This includes:
>>> @@ -370,7 +371,10 @@ TRACE_EVENT(foo_bar,
>>>  
>>>  		  __get_str(str), __get_str(lstr),
>>>  		  __get_bitmask(cpus), __get_cpumask(cpum),
>>> -		  __get_str(vstr))
>>> +		  __get_str(vstr),
>>> +	         __get_dynamic_array_len(cpus),
>>> +	         __get_dynamic_array_len(cpus),
>>> +	         __get_dynamic_array(cpus))  
>>
>> __get_dynamic_array_len() calls don't seem to be aligned with the ones above
>>
> 
> Ah yeah. I'll update. Note, this isn't going to go into the kernel until at
> least 6.16.
> 

Okay thanks for the note. I will stick to %lx for now and change it to %*pbl
once this gets in.

Libo 

> -- Steve

