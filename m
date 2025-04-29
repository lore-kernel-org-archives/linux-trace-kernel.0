Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B546B25335B;
	Tue, 29 Apr 2025 17:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745949247; cv=fail; b=gdFWbInzNhXErHGa3JGbZN+4t/53DkSruGGT8etQJKSKPK4nY8/MpWzoRmG5DqT8ZPyCzmHzZoyenrZd2VylAIvCe1t5DM2GROS94S84Rhn+RoAP8lTPdpjZH55GbWfS0s2W85y9RXJX+ZG7ZeRbzCoKjescI8Iq6MIR0u06Imk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745949247; c=relaxed/simple;
	bh=fyjPRZCREqVVYcnjSdzG+dlGv+H7ubUXV4S9yBmljQc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FlayxnXfZLfylicGd14YUj7hCd2izDoaSS+nPipIsTIs8W9b/AhJbZ/kAJDgcAdMNW5A/2DUrqtlSrysym+qrUTwwmu2X3mqywzzBL5FC+hcD3qNWUhmFl+Xf6rqERJhXqfLYi6vTi3t9tZvUQtSGkJ/vN3PCS7fFrUayhCi4Ns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=U54v5HNo; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Xib3CKaA; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="U54v5HNo";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Xib3CKaA"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53THoGO1018849;
	Tue, 29 Apr 2025 17:53:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=11gUwAEsSbn1jd8b4HJbLaLc/ZotzMcDFpVl+AUDJbs=; b=
	U54v5HNoOsC2YdtYW7f/y66McvG09J4JTcn+PPXsHSiCdPFyd+ovn21zuTFJsbzr
	Au4FWTMHLW1qiZp3n6dQDcqtwzwyXr3Wjelu33/3myas/UF8HNG3PNSUFN1Pw+xZ
	h53YBLqanT5qsn2H0MaFQji1l4GcRCCDYbj+7fRz7IMaLeed9XbWzZZpqvH6zGkc
	NDKjdWYzAUcIQw7nw7ghJDMlUTKm7dEzW9pOkScVN0YJXSPwmvBMs838bTWEdn/e
	vCrmOwcMX+7en2307ytVdjAC80qZQXWS2WA23dnyb08dp2M01C2oHvYSY8oVdFHO
	jxYeltAklG3nwZGf73TTfw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b3gh808r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Apr 2025 17:53:03 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53TGvInm013778;
	Tue, 29 Apr 2025 17:53:03 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 468nxa8erh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Apr 2025 17:53:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mofZF/sFAL7wVwW3J5gLw76Xn/cHVODDuR5Yoy6DpJL6Jn1tF5eEJcLolyV9eRu5pFt0JBIXBMu3fk0CI/I6jcJGJf913MXZX41mm6FZ+0v99IqlSauFeNLrVmgrVrAEafa7IK3yEFZ6Qi/b0hSHFWMK2sttEGhneYqMtRKrT0Gi+NUObbaoK8ymx2kHVDyjVIDh/mJJ+WrNHrkn9Iv4/98yUgsjvgG6v8Gzx198W/1hJMLBBlWDc6+OMJlohBG5XtL2CJt98290pEmVtiur7Gamj0xpZwq+OaTCdU/UdmWYC5Q4h18/9JpXHmEnWIMaNqnIH+AH2V05jaRLtXhdmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=11gUwAEsSbn1jd8b4HJbLaLc/ZotzMcDFpVl+AUDJbs=;
 b=b3moOg31W1c4v8n7Bdu3t5R2k/2tqqwX+7QQgDbG0tqV+AJSMbjK2vasGoevUinmCpenJH7qD0cl+0aEGRMM2bV/A8EVeoHJAKShYJGVwIaLlWDSPs5yub+6ROBqAz/RbnP5GjZrrvGAA2rV7poL3AdxQoZ6/8ExW8O3Y9+4JUT9wiv8rYpw0ah5npbsljt9s6fbnCxSI5HZal0/nY3LLdongaVx4vai6j1RTWQXXf0E14bwMQZKWtcKemVSoUJKaUzynq97e/o9uRgWk5JViXL5gwGPK7M0TCYBse10PabAOGmDh4kjNRwRWLrgB0ARRN6USEJF7AJzcWJlhXXrtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=11gUwAEsSbn1jd8b4HJbLaLc/ZotzMcDFpVl+AUDJbs=;
 b=Xib3CKaAr8BJuZMU9UPuWifqnx02f7IewgmX8dbMyjHl96DbA89KZcdhJ5byUepufusN7hC0m6xE4yj1ke2xqUzZKHc+V5P10KTLDPpWZTxF8wkDJT/IfpCEVoTna8KR+cJmVJR6lmQyImazxQwaZ29cwEkZA2oYwON3rTHVvwg=
Received: from SA1PR10MB6365.namprd10.prod.outlook.com (2603:10b6:806:255::12)
 by BL3PR10MB6209.namprd10.prod.outlook.com (2603:10b6:208:3bd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Tue, 29 Apr
 2025 17:52:59 +0000
Received: from SA1PR10MB6365.namprd10.prod.outlook.com
 ([fe80::81bb:1fc4:37c7:a515]) by SA1PR10MB6365.namprd10.prod.outlook.com
 ([fe80::81bb:1fc4:37c7:a515%5]) with mapi id 15.20.8678.028; Tue, 29 Apr 2025
 17:52:53 +0000
Message-ID: <dc1ce226-9fdc-4a1e-9984-3b968b70681f@oracle.com>
Date: Tue, 29 Apr 2025 10:52:50 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] x86/vdso: Use CFI macros in
 __vdso_sgx_enter_enclave()
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Remus
 <jremus@linux.ibm.com>, x86@kernel.org,
        Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20250425023750.669174660@goodmis.org>
 <20250425024023.000117829@goodmis.org>
 <2d81ea94-e46e-497c-bbfb-8db38203e57c@oracle.com>
 <nl5qjjmdqgd6hrxefkhihjmzzdzt6lsjsil74pemlrywvsezkr@syb6jbpc2fav>
 <btzpfx5l43y5sp2j6zco4yh74g6zafo3jtmqumbjggjrwcoscn@vaorx7xtcmye>
Content-Language: en-US
From: Indu Bhagat <indu.bhagat@oracle.com>
In-Reply-To: <btzpfx5l43y5sp2j6zco4yh74g6zafo3jtmqumbjggjrwcoscn@vaorx7xtcmye>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0233.namprd04.prod.outlook.com
 (2603:10b6:303:87::28) To SA1PR10MB6365.namprd10.prod.outlook.com
 (2603:10b6:806:255::12)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR10MB6365:EE_|BL3PR10MB6209:EE_
X-MS-Office365-Filtering-Correlation-Id: 8025c7e0-6721-4cdc-df50-08dd8746aa96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|10070799003|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VUhpUi9uVXJPU0d2Zmlob0tRbm4xdWdYNmR0L3FiQk9oVHUwNlRDbGJqenJQ?=
 =?utf-8?B?NVc5dnlORU44NFhhQnkwZVdmRk9TYnl1WXl3RzJiK0ZxZTNtVC9EM2Nub01S?=
 =?utf-8?B?OTlSQ25tSzFXc2NEaHFCeTBHYzE4dGZCcWRYaWtIVlVLVmdOTC9wODBYRXVo?=
 =?utf-8?B?K2RqS3AvMlBuVTFpUVM5Y09qSGxmKzRpelMxbjVta0ROZ1RuenVKaFF5OUJy?=
 =?utf-8?B?T2xSd2k2Vlh0L1gxNHZxVnhpSXRNdHZSajBuOEVJNDdRYTFieklDWlJCMW9F?=
 =?utf-8?B?WDljTmoxeEFJRWd2QUNoSklaa2VkN3owQjhvY3ZZZDV3TnUvaW9ucXRIRFdw?=
 =?utf-8?B?NlZXZ2lpV2ZQQXdCUWdTOUtxci9LcWVRSENuZmhJV2xUTVpQWExMdmg5T0pM?=
 =?utf-8?B?WXFHRmp1ckd0ZnFCYkEyOU9MeFJEd2JTWms1Sm5rRkR6a3c1eUtmNEovdHRM?=
 =?utf-8?B?VVdXS2IvWnA5N05URWhERXNxUlVISjVHaFZjTEgxMzNaS2x5WlkrZ01uSnZh?=
 =?utf-8?B?TDk0eW92Z2xiSmwwck5tbmkyd0kxdzRxQlBUY1M2U21kVm9YNFF5emlsV2tk?=
 =?utf-8?B?K05ENC9VMXFPUmtYY3d5MlpTT2h3ZVJnNDk5ZkNRUm15YzA2K0FmN2VvNGNU?=
 =?utf-8?B?aUdxTnpHdVR1L1lYdWl5K21pNkV1SmpBSUV1ZmRPc2FNdWplcnplS0kwOThk?=
 =?utf-8?B?K0dYUlJLYW1JREFVQURXbUJyaVV0dkhmNmxscHpsYk9LWkhEYzdWNWtWSjJi?=
 =?utf-8?B?SmtUZTlnVzAyUmRyK3B2bXQ2Ly9uZGFLcEpMQWJLV1JIbEFLZ2RLQ0x0RVo1?=
 =?utf-8?B?Z2gzeUVudjB2ejdJdlAyTEIyNFd3RTFwZ3NwbXZlbDVOZmtSdklZeE81clFE?=
 =?utf-8?B?WXdCMXNpOHhoRjNtdFlMS3h4elBtWTY1RFlidjZzYlozUjVDZ0c0UzZPS08z?=
 =?utf-8?B?eEdHS3g1SElhdldua0NKK0JvZDFtbER3SER2WFFKanFVdjB0eTY2b04vTWtr?=
 =?utf-8?B?L3R4djJ5ZEhjRUl0Q3ByOVZDK21QU0N5ZjlBRmNadnhwcWhEdzE0OTk1R1VC?=
 =?utf-8?B?S0tQL2NDV1hxYlhQV2owN1NhbDlkaDFYVlVFMHVwcytOU21LWTNnYWVrT1NZ?=
 =?utf-8?B?UEF0ekloRDJJTE01cDN4NGFncC9FZmpsMU05a1JDbGgvazhhRjNXcEF1SEJD?=
 =?utf-8?B?QlJOTlBYaWhET0Rpd3lia0YrcWhIOVBEblZydWJOQlNTNmNEOStlejg0OUVv?=
 =?utf-8?B?OUUrekVOYS9rcG8zNmdnWVQ2U1FKWDQ2eHozS1E5M0NQUmRKL1lUcEJzZUdE?=
 =?utf-8?B?Ym0wNk54ZG51aldCblJqVjNXNzRDRVpBclk3QTNHSFFrMGo0NDJ4Z0VqaFpj?=
 =?utf-8?B?TVlzb0VRSllUd0x1RFdRelNEUURIYlBSZTZvZUlwZ1UrelJWZkxpRGxDRy9Y?=
 =?utf-8?B?RjBLRkxiV0EyNFFOR3M2N0V0YnlFTVF4K2ZtMk8xWWhPeVlYVEcwQm44NElu?=
 =?utf-8?B?QlZLRzdoMTVzd1ZvdmxhcG5nZ0U3WVFQWTBkWnJkTy80WUsrclFsc1FYVitu?=
 =?utf-8?B?ekFINkFhK29hNytFek5iajd1YmVPQVduamc4bzNVTTRLcHJKcUFxc1N1bng0?=
 =?utf-8?B?UStlSnFnV0dhTDZkLzZwTzZrUldlUk1OczBTeU50Q0Zkb2pIQnJlZmxGY0VP?=
 =?utf-8?B?Zlppc1NtZlpRakRZcE1hVU9jWGRUL0RNbWh5T2NQSjVhMWpKbVZkS1F1V2J0?=
 =?utf-8?B?a1I2QUZQQlVKb3QrVmtFSFNIUjROQ3RoWmwvZ2JjUDE2ZEJGUGpuYUlpYWxF?=
 =?utf-8?B?Y0t0Ry8rNTJaK0pCSjRtMm1Ic0gzSDNhRjVCUi9LOVFubHQ2WmFSTmpNZStn?=
 =?utf-8?B?ZTJPREFRRjJRbzg3MkxWK0lQM2taYi92SHlnTmQ2ZEN2N0g5dlQ3Y1VsY1lL?=
 =?utf-8?Q?jEHLRn7D7yg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB6365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(10070799003)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cHhmR250bTJaQmNPZUN1M29Rd0tCek04VkwyalVrdDBoR1daa05aQmdpV3Ur?=
 =?utf-8?B?dnFNOFFGajBENCt1dGI4MHFhOFByRUp1ZTRRMkFKNFp0YTJ4aGlLMDEyY2pj?=
 =?utf-8?B?M3JaUW5laWtHT2w4ZjB6elhheDNzRWVQdCtUNk9WK25pcElmRys5TzMxOEVw?=
 =?utf-8?B?aUR3aDdtMThtZ2tGeUVKLzB2bUhmTTZBRGFTKzlTdURaRVordGFNem5YMUZJ?=
 =?utf-8?B?SEtUVXZIUndvN0M1RFIydWhONHNrMGxWUEQzLzZuNTFUYUs4SXRJU0ZNdWc1?=
 =?utf-8?B?ZHZYNHRIb2VobXBnd3c1ekJ4R3Z3RnJGVFQySnRTMUdGMGViQXJKVDVTMDVr?=
 =?utf-8?B?NmhkOGVCSGFadldXRW41clZhczJ1QnB6djFHS0ZTVmcrZm0yMkZuYWRPam1r?=
 =?utf-8?B?TlRjdUF2YmM5VXl6RFluWkUvZldheTFMdXhndGZPQ1pnemMvWTBNM2s2am5T?=
 =?utf-8?B?WVpHa3ZhQ2R1U3hNcktuUVJCdHpGbFZsUDVsR0RTNWNZV1prWUhrRU95dkp1?=
 =?utf-8?B?SzVwRVNYd1lLY1JqTUlOZFNYNjBzU1ZycitTRCtyUndFWGEvd3MxdWM0RmpO?=
 =?utf-8?B?OXY0S0VNdlJQVjB6czRNYSsyRk1nMFBoMStzaGoxVkd4Uk1HVVk4OWtkbk1u?=
 =?utf-8?B?UHYva0JvZUNUYURzYjIyd1NaRVYrRERpZkZyL2d5WnRLbXY3QnZWVGxwSTM0?=
 =?utf-8?B?eVRLbEdodHpYZzVvU0NpaFNrbHltbHBSTkd2Q2NFSk9RaTVvd0FuRU1PV3lC?=
 =?utf-8?B?anBBaGkvRm5EMFhmKzZsU0xUN3p1STJQdkYvSGtQQXBlU1FKK2RoNkxPVm1J?=
 =?utf-8?B?eEpLbm8rQzhIZVRvVHJ2bXdzMDFCUk5iQTdlaFpQU0k0amFUWEtiWWdjZ0JI?=
 =?utf-8?B?anR6R25ua3NJK2RKanlJLzFwd09pVkRMMUdCQ1k3ZTYrcE1TUmR0SWFid1FY?=
 =?utf-8?B?MFRIbUZyQmZTL0JQT0hpdGFpNUhzenFmZTlvYi9FWlFMMnJtNys3Mk1VVHA0?=
 =?utf-8?B?aDR6WlFhYjZpcVVJM2RURXhlV1djVmt5SkRqTmp4bWpkTjhHM01HYzZWTUlN?=
 =?utf-8?B?aXEwUkx1cGZIcTQvN2Z3bm1NSVRDaEU4VEJicFZGaktsZ3MzbDlUclovSGZi?=
 =?utf-8?B?TTR5N296NUg2Zzk5WG1McmlZVHc2Ky9LVnMzeHJXUVRka2JJaUZCY2h2c21x?=
 =?utf-8?B?V3Y1aFZab0hZMDNwdlhoc1Z1QXluK0wybFNXT2lQdzJpT0VOaVRwS1BkRnVT?=
 =?utf-8?B?VXlDVFp2SlNSWmlxU0hRcE5BbHJsRDFLdGpiNk9wK3ptTU9JNnpoZlB2amc3?=
 =?utf-8?B?ZTIvREpkanZROVYzMVNTTm9rS1pETmU1eGlyREl4bmJNSUJDOXdCU2YrTi9n?=
 =?utf-8?B?ZGUxSUtDMVZydWVORVRVQWhPTjZtSnd3eW5DZDIyUkFsTkhnb1NVQ2Z5NE8v?=
 =?utf-8?B?OTNZbWJIeFI1NjludUVoYmFYbDhYWEZhUmExS3AzK1Y4VXdzeEhDcWoreE9L?=
 =?utf-8?B?Z0Mvcll5QkJPenM5MlIzZFY4U0g2NlJlUmZRK1VjQU9neVdkd1pwTm9OQnln?=
 =?utf-8?B?bndyWExWelVvRjlKd1dpTko2OE4xdFpBak85eDlCRFQvYm1rb2h4YXRqR0hT?=
 =?utf-8?B?SDNISzdxREJUc3VkWGJpcUNFQmltWTBZamRHSFRJRkJ3UHZialk5UlhaYkNj?=
 =?utf-8?B?UGxOT1BaTmxjWW96VU5DZHRVeFNCdkRaOHU1SnNrc2p6akw1UjRBWGp4T2tv?=
 =?utf-8?B?a1VNWW9lY0tQUXdCcHMrNUEzcTY2UTN6QVhFZ1NkZTl3YWRIN0hHbHIyU2Vy?=
 =?utf-8?B?VWVmSGRGeW9zNlJ1a01HdklKWmR0WVRJdHZxcXgvNTdHYWZtdHBLbm5pSHZz?=
 =?utf-8?B?L1l3V2pWbzdQTGlNQzhPc3cwVE5iOVBXajFoQjZoN1h3NG0rb2hDR0lHWExy?=
 =?utf-8?B?TmFKU05QMmxJSGhyZytWUlo1dm1oQjBVK3dHaVQxNmY1SDVzNkp2cXRacysw?=
 =?utf-8?B?S2dUcGNhMHk0SGRnRFNMTFBRWHJCUUhoSWFXZDJieDN4VFdHeDlOSXM5Ly8y?=
 =?utf-8?B?Wm9QamR3eEFXeUFsMlBCQi8zbUVGblNQbTdNd1V5SHpqdEJta2MwSlRoRjNB?=
 =?utf-8?B?L2VIakIrckRHUHNsS2J4R2VtdDdWYUJZUU9NanFWRWVPTXNRRWVoYmxsOUZT?=
 =?utf-8?Q?iLKtWMsPw22tuf4XCcLyUWo=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DF2hXiii5/h11hlRCltwmw77HYxHqoGwaHeyE3FMED+Xhu+c/ZWkz0aVWidUuh7we5GPZLdKZtqFknrEn1cUUP99ty6dGeGux5lTYBlavn2Gf0sWOhF5Vjo2QiMborJ9SzO7rTo8DRe3RCi59quqOiFTs/UV5FWALaYt43FXZD3W7u9S/qpIIgLjqMPn6/19vRBv9t9TVtcKvL1ltgSCLA/WIQfsN7FlyrPZeh+x6oO+MUCRGyr64K5O5ke00lBFvdP8VZpNJYrWd2z4avDnn2nDEBv7saDvgWoGhrervGY0KKQumtf/j6q2B0amuJBH6gAUomjQ+oSR3HgfxGpirVMyAu3wLt1CnYSQI9Cx5NfCdapIi9BJD7VAJSbnq822PXpQqSCtbqEu+I20uRFbNKV/EBNn9dqdN8qltV+nZRavaUGorEdXBspwEm66AtHLmXakvscYZUdHSEbku6/YMcMAD6WYgcA2Hk1nnpwKAhLZ0A57wVb1ReLTpN69b5qZzK6VdelrVLvBJq1c1LyZPYg27/+GcDXEgg/tb5Nz0PBWmjn6kIGkQiyfCeBv+KUQfi7nD/gmYnLH+aASDwMFau+gR9xteTGCiY205/r7OnI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8025c7e0-6721-4cdc-df50-08dd8746aa96
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB6365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2025 17:52:53.8297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SQ8HL7neXgek5+QIZMGkhcAG+f2rrdhcfraSiZAB4ns8YXx0hWhBRCJEc+HEpB0I9gdMPkge7ktrB7d8aRYjQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6209
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-29_06,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 mlxlogscore=637 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2504290131
X-Proofpoint-ORIG-GUID: 9rSUrbBCOP9ifkr37Et-hOmnGsndNu7k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI5MDEzMiBTYWx0ZWRfXwznWFlKS16fz EO7P4EK2QaiLD4FmPzT3KU/uqTbLwnlWv/6Jg0nyqjs3EYoIp+DlvQXn6LC8cJN++hWRzLsQnpk qnqxTP2GuU7It4+tb2VKkrI79hjKlgii5cldLmyak5NDkJRf+X7Tj9b2j+J+dFlKpJKh+YLmK+O
 XxP+O3dwxIocJP+nJCZ/epLsLnqusOG/UKrKd4Xf0tKujHcoLt79wzY7o5aHqTO2CIA+2g7AqI0 ssjEdO3798M5Apb4MleE9nf8YPAVbYD+mf4LjtffMtMc2HrU6sw/Mn2am7aB1LzFDEkHu4Pcbk1 dMXMyxOCKenQiWX1g/QsmNuLkgDw5bN1176GzndOhR0u7KgjzHdq+ehtD9+t/njaFh74zAlPo4n FIFNMbZ0
X-Authority-Analysis: v=2.4 cv=ct6bk04i c=1 sm=1 tr=0 ts=681111ff b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=enh3lwfvCW8j3T8NJUQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 9rSUrbBCOP9ifkr37Et-hOmnGsndNu7k

On 4/28/25 10:10 AM, Josh Poimboeuf wrote:
> On Mon, Apr 28, 2025 at 09:17:01AM -0700, Josh Poimboeuf wrote:
>> On Fri, Apr 25, 2025 at 04:22:22PM -0700, Indu Bhagat wrote:
>>> On 4/24/25 7:37 PM, Steven Rostedt wrote:
>>>> From: Josh Poimboeuf <jpoimboe@kernel.org>
>>>>
>>>> Use the CFI macros instead of the raw .cfi_* directives to be consistent
>>>> with the rest of the VDSO asm.  It's also easier on the eyes.
>>>>
>>>> No functional changes.
>>>>
>>>
>>> Although unrelated to the current intent of the patch, a question:
>>>
>>>    Why does the stub after .Linvoke_userspace_handler in vsgs.S not have CFI
>>> directives ?
>>
>> Yeah, looks like that stack alignment code needs some CFI.
> 
> Actually, this function uses a frame pointer so I think the stack
> pointer alignment shouldn't affect the CFI?
> 

You are right.  rbx is already handled too with the required CFI in the 
prologue.


