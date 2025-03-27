Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A508462;
	Thu, 27 Mar 2025 21:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743111335; cv=fail; b=cVrLhOkLw/1G7RG5fgyzLa1mTPenUhWbe7wiE7zzCHbKIiaMFCnFq/gNucd+M+4bvq2XbJtqoUL/p0p+mzUmKMyQx8gq4jG25mOkq85XdGAg0SiL4qZethEr1/SrcailwlkCS8rTSz9nyfrXqo+V9SRbcIMdhH+04YcymFrFwWE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743111335; c=relaxed/simple;
	bh=hjnj01sqANwg9gHf9ENM5aFzDGuERDnSlrvrKSxOIyE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZBNgE19ssdAQW3w3cPiD+yJn8W/k4O79M6iOhaAsBm+bL0sxl+85oGhoibxblMTR4JTavA8jn7iKYoTdUuakfecffu3J4ttYwLJ6SKCBde37HsjNV8bHLgy+rRqyo8suyGEJFeLVKFic+WQn2sydrraG1WAEPxbi7yOJwRYEYjc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nr1K7tit; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XbOr7gJR; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nr1K7tit";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XbOr7gJR"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52RLMvS8013055;
	Thu, 27 Mar 2025 21:35:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=0uGbjrrVpN+ILu7QKkbS86D6lYMQo10SEYvZ3RdUYhI=; b=
	nr1K7titV+mYWMPSAc4lcG5Unlz+5sQDG0VRUDalcmUQQGkzIPuvkl1u8sFV/Mdz
	M6xpl1NTxRKEI5+abctR+JDi2+UfL70Zy5vErFKG7+P3LqDqygVbxhBPf5FRbgpd
	Z9RYMvtFHxigN0M96H2QzmBmibTqs1N+PrAlkozo9o82yQozmnc327nU+BLxtERp
	jyvLq+68vw++FHiVaOWBtAmoqLf5NbKarPrOUSuv14gKRJnXqa9yZuBemJzClwUN
	rOPNUBsrxM/4L+zLOiQustHh+cDpCMk/3qAbOk1Omz4w9u0HQaZ2kp+fnzkSqQxM
	cy241+sV2ay9TDuChwE4gg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45hncrwq2d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Mar 2025 21:35:28 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52RJmdsI028689;
	Thu, 27 Mar 2025 21:35:26 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45jj6vy9sm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Mar 2025 21:35:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JtOV1bAi2xziLMqxM30ejAwDkdL8qXZd15ypS4u6nIS3bm8SCS/y9H6eJ+MXCkJ74Bt3EVy4bxRlef9ZD2hbct6djm8tRYyVmw9sjlUvn0zBFZMtB8NismcuuEog9yVlUQpqVLEupmGw4CxLqW4O+ib0V5xGAagkaO8/EY9DBy7k73ndX3JywEdEH7xRdD6n4q2Ef0apjJO/XbcqMwFZT+ULT51Oo0m0VDwcGps4Y4Qn+esnbLdgAPf88LdI3Uva5vjs0bNmJkXbgqIJFAYUc5mCQkJ0rDAJX9qaBMF3Cqkkx5fw3hCwpU3g31yarY1PR/Z0MeQ9o8KGRXWOCR2O5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0uGbjrrVpN+ILu7QKkbS86D6lYMQo10SEYvZ3RdUYhI=;
 b=BXlyolcRLAy9S7Kd0rQ4itNcsPhq5SZn5sR32bTo7AWw1Xd2dY/lv+z2axtCc7bg+XOR1crLN1qR6Stxywh+/yweBLHuyd/3v0WDOE4ypSGh5HURb/flPjZhP7jfZRBRhJbzYkhaVlW6dduNyDoflomLCyfHheQaGp8b6v4m75TzmRT7M9SdA+h0WucgwzoaAji37j8rQw9L6f9BfEhn1yJ1SFQzQP7PT3rcNYRHoYheuNGwEWH+cIBn6Gm3DyP9NF2fuKGsktusxhgJtjUwuhNEFeQhDRtJ7DMvBIAu5mYPCslp3+rpkva0uwnDVW+7/B5IazdMwMd5Dw5P1H4Zmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0uGbjrrVpN+ILu7QKkbS86D6lYMQo10SEYvZ3RdUYhI=;
 b=XbOr7gJRMv0YJnv2QGg6IAzisrYdtpwTN8ICn54gZl/8FOk/6iNQfKDNexmHZk7+1LlNxS9nZa1ynTzO1Ai2Ydr56rFZ96vY2V3zpV18dA3qMIGrMAnhqPU/d8GWPzn7Y8UuNIK+zF2seWUp50LMN0GApUZ2JhH9aPROXTlH21Y=
Received: from MW4PR10MB5749.namprd10.prod.outlook.com (2603:10b6:303:184::12)
 by CH3PR10MB7531.namprd10.prod.outlook.com (2603:10b6:610:139::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 21:35:23 +0000
Received: from MW4PR10MB5749.namprd10.prod.outlook.com
 ([fe80::9a04:a919:657a:7454]) by MW4PR10MB5749.namprd10.prod.outlook.com
 ([fe80::9a04:a919:657a:7454%3]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 21:35:23 +0000
Message-ID: <1c580335-a794-4307-a24f-39236064f8e8@oracle.com>
Date: Thu, 27 Mar 2025 14:35:20 -0700
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
 <d9707265-d6bd-40df-8e7f-4213851ea33f@oracle.com>
 <20250327172050.2be5b38a@gandalf.local.home>
Content-Language: en-US
From: Libo Chen <libo.chen@oracle.com>
In-Reply-To: <20250327172050.2be5b38a@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0128.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::13) To MW4PR10MB5749.namprd10.prod.outlook.com
 (2603:10b6:303:184::12)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB5749:EE_|CH3PR10MB7531:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fd89439-cba2-4cd9-cccb-08dd6d7747ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RlNETDI1amdZSlFTUVAzdVhBWlE2WkJkL1VGUjBYalowVW1ybHJSNi93cHZl?=
 =?utf-8?B?eTBDdFBVMHRsd0JIa25aRXA2LzkzQUVlUm1JZllLTVg2TDh2S1VwLzY5TENm?=
 =?utf-8?B?ZUpjbzVZWDE3M0hzYzJrZVI5OVo5M3VRMTZKU1VHMk1hazRnK05MVVFaZU8z?=
 =?utf-8?B?ZFBIODNLNlR3ak5KWFU3cUh6UVdDamtldGZOdFZoSEVNUzVTN3M4d2dub20w?=
 =?utf-8?B?Wms1YjJkV0ovbGF5SmFmT2UxZEM5c25FQW01UUMzOW9CL0ZVVlVVRHB4VWJK?=
 =?utf-8?B?dkhNK1E5VHlQL3BIRjdqQm04aTFoUGR5UlA0SEttTGc1QTIzN2VYZUZUZzM3?=
 =?utf-8?B?RUFFS20zOXRqdWN4SFdhZlExSWJsWncxVFVnNnlqYXBaNU4rQXUycm5FVENa?=
 =?utf-8?B?eFdnb1pkRHVvYmduY1JnUDlFcXdmWW80b3ZObW5RZDVPanRJcStKaGNGMFp2?=
 =?utf-8?B?VWM2R3E1Z0VlVjY0d3E0TTBVK2F1NkpQQVdieEJhcWhPMmpPRy8rVzFEY2dx?=
 =?utf-8?B?OUt1UWFJd3ZBYk1mUTVJczZwd0FjdHNqNG1Ra3d3ZUpCaE9ENjVxU0h0R3po?=
 =?utf-8?B?UHdvZjluOWxTbUpNMTBwWC9iS1pELzRMLzh6bDJPRjJVL0ZzY0lsNGRPcEpP?=
 =?utf-8?B?aG5qUk5IOHo1YU9aTlV2Rm15L0VUQmxNVXNMQmhaZ1NxendYUFlGeisrN3RS?=
 =?utf-8?B?VWZ4cExIZ1dMdGE5MGVXRjRoY0JVbnhZQVhvVXBzZUJXdmRYNDJYZVpPbVR4?=
 =?utf-8?B?UFR5SFFTM0VKT2hVZElTdVN5Y2hBU0cybWIyQTFZUS85M0RXb1R0TXc4eGJM?=
 =?utf-8?B?R1I4WnIvMGNFUkM2dHB0L3RySFF5NXNHUkFTUEhMb0RsQ1I3WXBleXdpdGpN?=
 =?utf-8?B?Ull5eWF5R2NMNmN2bnpFR0ZrUU5iSnRpSFR1T09YdW02bnEyRmFPVnVYbmU1?=
 =?utf-8?B?dmpQVU1JMGlmWWtLampJd2FwRlRXTkU1Rk4vSVpENnVGTjNjWHhPYmVFbWJi?=
 =?utf-8?B?TEhvL01CU2cxMEh4VDdnb3FyU1JyekI4WFFBR0hjRXhoYVQzR0p4aWRlRDhw?=
 =?utf-8?B?eHFhRGVRR2Z4VXBtd041OVJvZVV0cmVIQldtYnF1TEdCS08zaFFoK1VVMm52?=
 =?utf-8?B?M2pvTjAxUlE4RWphL1FjNXdiUnNYRENOUFdQUENCRW9IRDNKNFVETzNLL1Qz?=
 =?utf-8?B?T3pLVk9VcDJGTitZOU9LOTJZU2NNU3cvODY2SXArNCtyY1pUSFJSaFBrSHNw?=
 =?utf-8?B?elRGV1BlcURIb0pYWGNKT3laWFR6Y3Zlb3VTck84Mk9yV3B3dzhrOFNwbVNi?=
 =?utf-8?B?SlYyd3lkRTNVbVFZUDF3aXpFM2JwTU4wZEFOUlExSFRJbXJQRCtwS00xaHFm?=
 =?utf-8?B?K2h3NWJsWVJtWk1zVWhLRVlaUHFMVjIxWW41ekZvb3hobXU4dFRyWmFIenlv?=
 =?utf-8?B?ZFppam05UFNPanBSbDRPUUJnaldyZmtZYU9xa0c2Sk82ZkFRT3pQelgwdUJR?=
 =?utf-8?B?K3ZGWjEyUmZRNGZsSGJNMFdkZTEzajkvZ2VrdXVVRWVyZnRjUUY5aE1NNXFB?=
 =?utf-8?B?WFhxcUtaRkFOQjNDbEk2dlhnWEpUcjNOdHl0YlgydnZtUW9qUmNnN0cvUUY2?=
 =?utf-8?B?YVAwamFybEdYQUZraWMrdXBqc3lBSWNmM0xKWXFPR2Z2Zys1UmVpVW5ua3lI?=
 =?utf-8?B?QkQwS0FqdmNKRHRCNGk2ZGNDQWUwVXo5ZW8zYXQyZzl6WHExNVJTdnRaTW81?=
 =?utf-8?B?NmlQS1lDNktzOUFRQ3JzUHkxYld1dkRHcHFlZXJHZjRZWUd4eFJrQW0wRFdE?=
 =?utf-8?B?OUlsbTNlOVNxMUU0eEpvV0VVL1puTnREZFhRMkZkenN3aUhiVkRPUFZCTS8y?=
 =?utf-8?Q?2eJF5dzPzvt5Z?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR10MB5749.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RnNDOURBSzRwMm5EbWtjQ1JmZnMwS3V2Q29aaW9kZWZpOG5mKzJjZU9aOTAz?=
 =?utf-8?B?NmRBUXlnOXdMcFRqdXFZQjlhOGF4OWJ2amZ0cEVHdmZKZlFkWTlzdFRJVmRS?=
 =?utf-8?B?ZENYWjcwVGZNY0Zvc21mZDRPRW1oUDdqNHdTc1JhR2pSUUFVOFhKZjlaZmto?=
 =?utf-8?B?N2ZRNm9qUmdzb1h0RFlIQWdTRHFuQTdLcjRBNXVXK2VQN0FoQzhZa0xOcHVx?=
 =?utf-8?B?NXBYWW9BS1lOckdtS0hSZ0laRVJWT3JXSFFrU1MyOXhiaTYxOW5lRHRDUnRT?=
 =?utf-8?B?Y05mcjIrZnFueVMvdjYyRnVMSU5kemlRa01QUEl0NjAvcnlUazdzSXJRZko4?=
 =?utf-8?B?dlZCd1Z5MUJhTWRPVENMVytxa0JxSUxYdmFmSnRlc3FIVGk1dFFDNjBabGsr?=
 =?utf-8?B?dFIwRHBSMElNZU8veVo1Vm5qZTAwR0JRRlY0Z0JVMG50OHJBMjM3RkJUcHRS?=
 =?utf-8?B?c2QyclFBaHVId2lJZDZnd09jbGFtbnBzRWhTSFRiWFh5ZWtIUXRhQlBWemtG?=
 =?utf-8?B?RXhSY3lWd3V2dzlXWXdIQmE3cklqZ3RlM1h4OGNJMEovVndGbGNoTlVKdmpz?=
 =?utf-8?B?WE1VVGtHSmtWWWZCOUJsSk1IK2tqejJaMEdQbnJ2cGlkcWtSM3BDWElSZmli?=
 =?utf-8?B?ckhQUnZ1ZVRUa0YwQVNKQ05uYStmYm94MWxzRGFTU2JKVTBqZUcxY1ZEQ3pn?=
 =?utf-8?B?T2lzemEySHdHUVNsdWdxclNvR3Foc21YYjF2YWRJekt0eGR3RjZzVFFWbDBB?=
 =?utf-8?B?bEVndDNjNGF0MG55MmtvL0Q1ZVRXSnJteFRTaWZKYXBQOElFclNYZm5xMUht?=
 =?utf-8?B?WXJyZ3N2cTNtWE9ZanRVWkZDWjlSV09CVFl2R1RZUW9VOFBDanJmQ3NJSGtE?=
 =?utf-8?B?OERhb240VE9QZUx4ZWxISUtTeVdYVEhyNXk2djZNdUpKZ0pRNDNTMkZmT3NP?=
 =?utf-8?B?MERXT0hXUUdzd0ppNmZIMDRhOVhQSm9tTTY5aU5LcDVTNnZ0b08vb2Z6cXl3?=
 =?utf-8?B?UnV0c0FkWHBtY3NLeU1IQ285ZU8zbDNocmxMY0NXZ05FdEg0em1qNFpKR1BE?=
 =?utf-8?B?QjQ5Ui91MHN4U3o4dStkV0FBeW9CdWNIOVlOZjNaVXpkcjVZTVNmcEFjUDhr?=
 =?utf-8?B?L3hmbnlXYlE1MXRXOC9NcEM0QUQ5NE5YNzRIQkxuMkNmbVRrd0lrdHBWVk9v?=
 =?utf-8?B?UkRNSVVkRlcxZ0xpOXdhcnlzU2hSTnZDM05maG8wQWRVMzhuMldGa2RoYWVY?=
 =?utf-8?B?VlQyL0dXTFlHV2EwYVJQQzh6dzFSaHFNZDd2M3FGYjQzWDE5azBKVERYVEhP?=
 =?utf-8?B?N1VuQ3VGUjVVd0dyQk5VZTAvUEVjWC84SSs1TTdGaXBZeWJDODRnM08wYVQ1?=
 =?utf-8?B?eHd4c2xmcXRNTHMxTVEvaEhrS1RnLzgzV1FmUTRsc0ovdjM1aFNoMlUwSmJo?=
 =?utf-8?B?RkZDVFgxalRzRml2ajB5SjBXbEpzM2dEVnVZajlrQlQrbE10RjJhdkwxd3Z2?=
 =?utf-8?B?SVVKSUNqdTIyTlFld1FLSUlhdytnS05RbDhxNk1GZnpJa0RUWWRHMFB2WGVZ?=
 =?utf-8?B?c1hCenZpNDZGTVFQMHFUeDVDMThZZmh4bElTWURPMTR4ZEp2TnE2S09sUkhm?=
 =?utf-8?B?SHhZdGlKVXErb2pRMzBaaVR0c2pRTTRVUHhKK0lrQitSakhUSFpNRDdDR0l4?=
 =?utf-8?B?VS8xejRROG96alk2dU9zUFlBakpwR1JCTDFWdjI1aUZIM1VSWnpZbm1rRWl6?=
 =?utf-8?B?c3VSaHhBQXRvcWdGakZWSS92VTJraXMxT2p6QlV0eTJVbkwwU3JBMVpoWWVv?=
 =?utf-8?B?SUF3ak4zRlVyZHl1Nk5qdndsUGRCRnAxdi9Sbi9YNlhZOEJBS21wekdIS3Mz?=
 =?utf-8?B?ekVjUTFNakd3MzVtc2FDOFhsbjhUVExQYzAva0lJbW5VL0FiaEMzVHdicEFE?=
 =?utf-8?B?TmJGdWdab2Q2dFV2LzFDeG5Ud3lXcGJ1QVlqOHVlOUFqeGZJWk1sRHZYQ21M?=
 =?utf-8?B?aWRLWUtqbXFTTEhXaHY4czZzQ2ZjeHFtUWw1MGNaUlNSMFRMd00xNFd0eVhH?=
 =?utf-8?B?azBNcnpmeUtwY1puQWRyVW1udVkxTkVhNlAwd0FSM3ZXTVkzMkgrU3pLZFhs?=
 =?utf-8?Q?VDUpZd5/qlt7syaoeOTp1PufU?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jM+YsCIVMQD/IJhi/Haso08L7OowfCfsNfM1TvsMr6ZMeZvMkO16krwxT5cw1SB6rDqltIkPTo0WvQcD5ygkQJti8r4wQBt0VdrwZ9hCN7naPtGybqiAgfT8wt/75qkJWA8owaemAo3gYdgA4z3vPyf3DFS6gPp/hsih7gdl9xvKa98Q6hOVUXhcRMeDckzYyj2SKxwvfFcV3Or1SFktuV078lOGvNuP3W1w+FRxDu1shpVYB/CQYLaQGKRUnGCv8CIyGD3Dt1ysoyT/FhV8TR9x37V+y8ArlgGN8t9wlI8tdfsQcEPuG4Q9ECsHd0r8badPHfAUVO4cGM3Z0ZLORRyoQVU1qIVFMeETKSS1kFw7SaINEaGYiETF7pAXrLkAfB1lgOV0gY/bQVmrM6MrcJoMZVIciPr0G/gDgyR1AKGVomguw5u+hAIOBjOn838HMdFIe+dlduoK7J4Qwo4eAnQAv/BHlLrHBhX3OFO4U7ohZJonF8VCl7naGXYdUMWgiP1OplmbDuaP1yDowYXPhJvVxTSdb0cM8Ou6YeMfnom+hscSoumja3HCcHjOhYxp/2j/XI25ZJcuSV9G7KpYca7UoVPGsgdPZshQJkNanfw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fd89439-cba2-4cd9-cccb-08dd6d7747ce
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB5749.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 21:35:23.0879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HuFlo+JwqYNZ5VZ/AZoXyHv9lpovNiZnPOo2IwzuHTiO7ZopXgUr99W5Sb5sa5uubjB63rgdSDzyKAFiFj0l+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7531
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-27_04,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503270145
X-Proofpoint-GUID: WHYkTZxJxB4fJw6_u2FQx6SBOOOThWX_
X-Proofpoint-ORIG-GUID: WHYkTZxJxB4fJw6_u2FQx6SBOOOThWX_



On 3/27/25 14:20, Steven Rostedt wrote:
> On Thu, 27 Mar 2025 14:00:44 -0700
> Libo Chen <libo.chen@oracle.com> wrote:
> 
>>> Ah yeah. I'll update. Note, this isn't going to go into the kernel until at
>>> least 6.16.
>>>   
>>
>> Okay thanks for the note. I will stick to %lx for now and change it to %*pbl
>> once this gets in.
> 
> This shouldn't be a blocker for you. Do you get any errors?
> 
> Hmm, if this causes bugs (perhaps you have arguments after the %*pbl) then
> I can add this as a fix and not an enhancement.

Not sure if I will call it an error. But without this patch, I will just get
"nil" when using %*p so this information is lost here. If I go ahead with
%*pbl, nodemask value will not show up in the trace until this one is merged.

Libo

> 
> -- Steve

