Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C06F218821;
	Fri, 25 Apr 2025 23:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745623389; cv=fail; b=SR1hFGyklIpVU0ySPU6y4zjcZe3W5KhFB/ZNj5gLhAMWl5SGcDOxC9lReKj+NQR2WFItTDMBPAG5jsHE7M12owV8P9f3J2ftoLEMSvTapa0tKKrR/aVLK4uRyRekZ7SfUnJAkGfHL9SEOJFhi/XbHrIk2rtd/J2dCrA7iVYRAAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745623389; c=relaxed/simple;
	bh=SUX0Tsgd/FL8sUFx6WE1vN6GsH7kIc2ov8P1Hupw7Ds=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rOyVTY3pqLaMn4+pWnaGh+rO384/s/R+0Q7t79gnl96UaijyEb/hJp0AImkQpsWyzoF5u3Lx7zvYStcbqKLziRyFztgKlrJNqMlKStc63WCeDntDFZrMffVWYUNqBXBW+GE8gv/OKaoesVK+WmnuKURBv9IwNQ5rQ9VHNG9n580=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jvDp5Ib5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=S3cU3iJR; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jvDp5Ib5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="S3cU3iJR"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53PMq1eB015526;
	Fri, 25 Apr 2025 23:22:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=PlWEXEh65Gec2NwyihwPiSOtWhtPl2FruLGIIH/70+o=; b=
	jvDp5Ib5xR2B8Ugg76qfuJ15SYBOVhvL92jOyJScbTgK3aSd4vWNf4/iH7vxoVYZ
	jzR8kdhmcVvUo4XFBOxokcFYr8tVANQkyPXSOmJbwOMlF4mF8Is7lRFJ2dk0LYb6
	ERbDKxzkVlo2hCV7nd3Y6EGxophEQz1eeaXhPZKqLRKzDWKoVlZPgBx0MvtNfhgs
	UIcqJI8eFVbMBunolUZ9dvdtUONULt0OWczlOPwHXVtMBRs68hdxFvQzCLdfiz0D
	BqUs8o+pLBauMn1S4ZBJ7S4TqieO5/U1K1KtvAMDw+iEl/l0HdIjoJpWiKtlaxP0
	c2eBVmjO5Q7Ly9MLR8RZDw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 468kjd044q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 23:22:33 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53PMWeoD031642;
	Fri, 25 Apr 2025 23:22:32 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azlp17010003.outbound.protection.outlook.com [40.93.10.3])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 467gftc5vd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 23:22:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UV+EU1fm5CWSx3em/bp5z+296IlUmP3ub4qDskIqHc03x+SpiJbtIRb5COkIOL9XwmdgjbjGorwDFhKAFmSHEHh5tOUVkK9cyrAnVceuChqSmfnuOymNNhnyI7+uDOiSHwFBU7uGHoaw2j9xwIDj8MdDcSJGgN4K5GwPfzE9MA8GysY2DqfzJxDEAv+PuBD0KG8G77luVBahnlVpWF17c/21di1nW1AlTj/gmnkl1+sOlt+BUkX2rv047bNSPLbUMaD+9f+IH3ieX+kH7qu2YTOFpEFSb71lb68mW87FT1MU5XaLRLwNOPjDiQXdN2W122anYHfvWQtQdJUSnal74A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PlWEXEh65Gec2NwyihwPiSOtWhtPl2FruLGIIH/70+o=;
 b=CboeWJ4uBn3WBoJkWbJybZh2t6ld9BTdLpQfl9FgU8Hv/dOmEJes7sqOgiyUnEd1wqMmwlDvSKrzIBUcY+UGieve3m/Xovl34gAhmJP62qyA5I2Ma1goAvk2CSqQDFl4539b0MCbqKMaxAZG3H1emDIoAX7Lw/nnLMzhixJpx3Zgzfhf5M0z9J2XAGFsr2NsEYPSWKA066S3g3wtGHZt8vnbDhJdS7aVI/XJ3HifupU86WpsInWeLdVyC4j25qWAxgjH3QoBxxecZURQ1sReywtzmiEep2W64JD75zrgzR74pDPnNim5pmvriIbS8BnsG7hM4gCMtqK7/awZE4YloA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PlWEXEh65Gec2NwyihwPiSOtWhtPl2FruLGIIH/70+o=;
 b=S3cU3iJRPKXtFYtLSIZSaSK3gCadUMGEPW0t0XFbnMwRQdjio5ukJ+uU70MtqWN5J7OX29tP5RHZclYCnPdbYBrxENrYgOT3IhWydSxq6ZRPPfvRRgtLjuZcrCcSIMnUGbfEvcr6UEIaMJjwee9WOTgakOmnrKHhGaqvOWYshlw=
Received: from SA1PR10MB6365.namprd10.prod.outlook.com (2603:10b6:806:255::12)
 by DS0PR10MB7294.namprd10.prod.outlook.com (2603:10b6:8:f6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.28; Fri, 25 Apr
 2025 23:22:29 +0000
Received: from SA1PR10MB6365.namprd10.prod.outlook.com
 ([fe80::81bb:1fc4:37c7:a515]) by SA1PR10MB6365.namprd10.prod.outlook.com
 ([fe80::81bb:1fc4:37c7:a515%5]) with mapi id 15.20.8678.025; Fri, 25 Apr 2025
 23:22:28 +0000
Message-ID: <2d81ea94-e46e-497c-bbfb-8db38203e57c@oracle.com>
Date: Fri, 25 Apr 2025 16:22:22 -0700
User-Agent: Mozilla Thunderbird
From: Indu Bhagat <indu.bhagat@oracle.com>
Subject: Re: [PATCH 5/6] x86/vdso: Use CFI macros in
 __vdso_sgx_enter_enclave()
To: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Jens Remus <jremus@linux.ibm.com>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20250425023750.669174660@goodmis.org>
 <20250425024023.000117829@goodmis.org>
Content-Language: en-US
In-Reply-To: <20250425024023.000117829@goodmis.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0122.namprd03.prod.outlook.com
 (2603:10b6:303:8c::7) To SA1PR10MB6365.namprd10.prod.outlook.com
 (2603:10b6:806:255::12)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR10MB6365:EE_|DS0PR10MB7294:EE_
X-MS-Office365-Filtering-Correlation-Id: 110f9880-7de2-46f4-2538-08dd84500bbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|10070799003|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bCtRM3ZZU3Axa2NKWldJMmQ3OTZtai9PbWFNMG1TUExaOUQ3cXZETzR5NTc3?=
 =?utf-8?B?QjVtQVlsMTdrbW41MHFSTDJKTitLZ0k4VTRNTmVNYmV6WC96ZUhLbW9kZ2dh?=
 =?utf-8?B?VFNHdk1ZVHhyZlhwQWNmSUUxbm5kamJ5SWVSTG90b2JGbm53TTgxVGt2cWtv?=
 =?utf-8?B?MjJGK050YjBhRWlOWHlseE1GQ3lCazVXNTZ4MEt3STNYaVQrTnRYWmFuRmtF?=
 =?utf-8?B?RDVYMnZrZEllQkpWUFFKR0FZaUZMeHl2SkhNOXJoQnBNSWw0N0JkTEpOcEVG?=
 =?utf-8?B?TjErcTk4eUVVM25PRVB2OXBIRmIvUmRqelkzRjVpWWNoejZ1ZVd2KzJ2WUFu?=
 =?utf-8?B?WldqY25qMnNQbjgwNFphaFNrYk9XbHp4ZnlWbFRlQXhlNTFKTDNoNUsxOFRY?=
 =?utf-8?B?UlE5MmJ3akYybVgxaE9ZRHJCWk1yTGNlVEg1TkxLZDR3NzFOaFV3RjZEaUFm?=
 =?utf-8?B?dUF2OWFxcUs2TWtnYnA2MXhCeWlBcDJreEFhalhvcW5qMzA0T1lUdFdYZTZi?=
 =?utf-8?B?WTUzdVpYQlRqci9heXlwSFB1NXBCNXNSU1EvMFFkcHhrT0lpclRId2NwM1JC?=
 =?utf-8?B?NER5SlFhdm5PcXVlTVNOVVZsT09nY0piMlZ6N2Q3dml5REhuQTl4QUovSUdK?=
 =?utf-8?B?UlhSWEJqWG1sTVQxbHlLU0ErR0NDLzRyR1p2ZHVaZlRNQzNiYXpZSlR5ZEZC?=
 =?utf-8?B?cnZSYlhLTExITkJDRERBY040Z2w4ZmtVV3pzUE1QaW01UWJHUWFrdFQ0MVF4?=
 =?utf-8?B?eXNmSS91ellVYno3aUxRRUJPYlNzU0dOQ1VsZTRpdEw3TUltbGdIWGkwUkxI?=
 =?utf-8?B?RGd1SzBJcHFNcHFQNEJ4ZW42d3hISWZZcGxWcVJ3S1VaWm42dEF2dXdjWVll?=
 =?utf-8?B?b1dYVytRVkN6NWFWcTFlY1hQcHhraHNQTmhtcVl3Y0EzWmdYNlg3dVNxclhW?=
 =?utf-8?B?NVhqN0hOdSsvamszemxweWNDbkpiZFZxcUorSWUrS2UvTWdvQnA5RGlsVnNr?=
 =?utf-8?B?QVZrMTcvN3lUc2kwN3V4Z1VoaDFaRWN1RmNFRGpTdFlYQXRXMXdaZDVCVmVO?=
 =?utf-8?B?Sks3NVRNdFJQejJaK2Y4WW9lUDhoTnQyMTA1emJoNERzMk1IbFhCZTR6MXFm?=
 =?utf-8?B?ZGljd1UwVGo5SXpydGFDTDFVTExWNUl6ZkxQcDVZS005TU5XTWxiNHd3NE83?=
 =?utf-8?B?TEJKQU43UDNaMEp1eFZHR1BGdUxiQndxU3pRTDRCYWV1TjA0d2ZOZlppK2VX?=
 =?utf-8?B?MnRQSGJ3SUFkZGg1SVRJbklaRkp2MHUzakwvbVZqK2RJWkg1UWJaRCtqeTBW?=
 =?utf-8?B?ZGQrL3Vtc1VadHF2djhsMzdMMUlXUVJ6OVFoOU1YSVNPa1B3b3B0WnhKZjVN?=
 =?utf-8?B?V09IY2ttZm1YMmQxMU14Z2t2d2pFMmNJRUVxOGVvL0VvY0pUUFk5cDNScHgz?=
 =?utf-8?B?YlFpTGxidXA0TmZBMkdlN3YvaDFOakJQVXRxcWZNTGNONXB3S0FabnBYdUJz?=
 =?utf-8?B?cVpFZE5MZm5pQW5IOTU4RnVEUGhQNVQzSUlCbWdNT2kxejBkRDVpOVBTUm02?=
 =?utf-8?B?S2Q2REpQOHhLSEo1YkdqemJNVWIxOXhnNCszZFZid2loVkdxajdCekFHUElI?=
 =?utf-8?B?TlVPelhOOThKWmMySktDcDMva0R4V3RUT0FzSjlLajM1aUZDeUdRUndaZTNY?=
 =?utf-8?B?K0hTY1Z2OU1FUERpZnpUaFNReS9TQXpMUnFuMVRhaUw1MW11Zk9rbjE1N1Bj?=
 =?utf-8?B?NHA2Y2c5Vnk0TEtGd0h6NHdDcmpldURmenpsYks0MmJyWXBoa20zcU9BR3pj?=
 =?utf-8?B?SGZGMC90S3VMU2IrSDB1Q0dFZERPenZZZzhRWXFvOGkya3IzbW9pUzRTSmpS?=
 =?utf-8?B?T0hXLzN2U1h4MzZ3cDhtZGpTYlZZRHhXaUxVTVFKSkZmRzQ4TGxISlg5U1Y0?=
 =?utf-8?Q?74sjpYW1AGE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB6365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S3RUTys5NzByOEFkRk1OVFB3aFJ2bnRNOEgxdDV4OFhqU280K0VDY3VkSC95?=
 =?utf-8?B?L29kYTk4aFlNaTI0UXFvS1VlR0dpY25uUmo1WVh3c3U2eVBsbE5rOUdBRUlI?=
 =?utf-8?B?dkpZRWFHU0xLU0VCRXRCN0ZoYVloNGNLMUNZNURCc2luT1BtV3BlSjlRWmpI?=
 =?utf-8?B?MkNoaGYvenhJU244dHlqNGgwa3l0RUU1UXh5c2h1dHdYNXlseUhmM3Q0QWpN?=
 =?utf-8?B?NzVCUnU5WWhEWnhWU0sxNGJKODcwUzJSVHd2V0xOaWlyL2xmL1RBVzJtenhX?=
 =?utf-8?B?T2I2d1RtVUpRQlUzTDFWYU1xRmZXOFB0YjFHSWl2Z29LZlhGVzk2cEx1Y1lk?=
 =?utf-8?B?UWtESC9GeWdpUWU4TDIxUlVoaVA1T3BKYll1WVpJbTM1SHk3MkN5dGgxV3BR?=
 =?utf-8?B?Uk9GNnhrRGw1TDczMnJvTXhOVkxKSG1EQ3NjTVJNUzRiUFUwanNtS3cyZCtq?=
 =?utf-8?B?bk9ONlVOejFBc2hyL1d0VE1mcEdoVkoxMGdnSHlyTGR4aklVNDA5NGI3S080?=
 =?utf-8?B?MWIwdmdKVFpNRFl0dUYvOW1ya2Y0djdwMzNnRFJyWkhRNUt3Q0dveXo0S0ph?=
 =?utf-8?B?enhvUktnUXdyc0pzS1NpaXZwb0JEU0lKczFPZ3JTTHA3SlB5ejlTZU5QSy9C?=
 =?utf-8?B?QWpzQmY0UHlrZExyUG9hWnZQVWpTd0F3M24xOXVNSG1xV0RSSGViS09LTCsy?=
 =?utf-8?B?bUFXRis2OWY1YnNWR1Jzb3oveXVLVW53T2E4c3RyKzljM1J2bThZNlhyelha?=
 =?utf-8?B?KzIrQ0I2Y09wVzdtVFd5Zmw2cG5lU1JsTzFnS1N2RzRRNGlLcmk0UmRxT1Aw?=
 =?utf-8?B?K25UbFYvTm9QOENBa2hmRS9MZUY3M1phZE5RbHJjbHkxbHNIL2NLVUxJRWNr?=
 =?utf-8?B?b2xHY3NxdEVGSHNhdDRFQTdnZG5kTllDVTFYYUNmR2JUYk5IWTZmdC8wenVs?=
 =?utf-8?B?RDhMUXJsdC9Ed3ZQcWRoUFIvN2RJaEd1cTBHQjFCNlQrUjN5RXgvcVpJYzVJ?=
 =?utf-8?B?d1hmL0VhUjBOY1FURGdRV0dTSUZpSVA4b2pRR0J1d0M1UEMwaFJESzFETVUx?=
 =?utf-8?B?RDJrUXhMUHNzblJUTmdwd1FXTUIrRUxrcWpRSDR6T0d5WFVJUjYzS1lraXZw?=
 =?utf-8?B?LzB2UmNWazBTTDJsUkp3YlJYT1pidWxBbHNabFM5dmJMNjNZSzJsYTM0N0h5?=
 =?utf-8?B?aFo5U0phdmFrMkVxcmdMS256UWFha01aSjRnSG01WjFaZkJ2azluVGd0cUx4?=
 =?utf-8?B?V3ZSZ014RFpIaDR1bHY0aUt6aFBGWWxzVmhGbHptTHNydk1NekhObytQYk8y?=
 =?utf-8?B?RmpYV2ErTEZPZ0wvSm1rdUhja2N3QlZKODZveHdJakxSWFMwdlgxYkt5c1RG?=
 =?utf-8?B?QjErSlZhdjY2Q1ZOY3NiWkdyZnFwNElvM3AvVXFCeFVpN3JwOVl0SlpjRGFs?=
 =?utf-8?B?MTVSK1BsOXhlV0RyN1M4dCtESDVFRGxFV0Q5aDZvc3lDWk9HbWtVTUZEVHg4?=
 =?utf-8?B?T21nZUtzZU1TTXRqMDh3YmdaUFR5TUdjR25JZ3Y0QWtQOFEvcll2SFljMkU2?=
 =?utf-8?B?Ujd4N0V4eVFYMXc4aGFUaUhzaGFGaXZKL2o3OGx5Q0xTa1VXZmxhMFZTeEtS?=
 =?utf-8?B?c1l0U2dOVTdHOHA3QkpSdjJBYkpSb2hiRW5Zc1R2NS80MlI3RFE4ZlJGenBw?=
 =?utf-8?B?M1VSVTVrR1JxTHhDSndUd2xJK3dDaklzMkZzQkNHVWJrOFA2RFpNelI3Wmhu?=
 =?utf-8?B?R3BkRm1wa3ZtVHE5OWpjWkhqc3pUZlozQUhscXBlTkNHZzZZNlFLUWJUZVZZ?=
 =?utf-8?B?eVh6ZkZVejczdTlZaS9QdVUra3JLZWxLUnBHcVI3cEZ5OVhjYXlxTUZyY3lB?=
 =?utf-8?B?MFdlOUdvOVdNRzlaT3RXdVBZR0pBZGtNTmtXczhORmZRNEdlNjdWOGhsejdL?=
 =?utf-8?B?L1BibjdqeStLQmN0ODdDVnYzVEVaYmo4TnRXcWpsb2U4dXlCZjBRRUdxb3dq?=
 =?utf-8?B?QXRSam9JWnY4S0ROVWhtVi9RZTg3dDVmQlRVTGtmcHBzSjVEYUhEOXRub1FD?=
 =?utf-8?B?RXJYMDRqTFkrRzVkWWdYVmZ0YTRvUlpaVHBudGpJVkorekZiNWJ0OXRGUThM?=
 =?utf-8?B?VVVWNGhnQm9tU21yL3YrUHA3cXo3Nzcramx3aVdVQXhXaWxZWk0xOVhiQ0pW?=
 =?utf-8?Q?8OQeh5teD78yqNNqMNgPRAI=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	AEKIGAB+v2fWmhhbkkuSMgrBR/TWm/jQY2pBdWOgYDLoFjLCwSByCtL7PcBe+ZgDCkJHgOJtUW2pBWuWLE0qE6VnvF4nxoTvv3I9t/RLQSu+IMqGEeG+H8qb8PAbM7dWxXCvvbN3QlqMfkGsLWPMJORFM5bDj8SG/u+WGQWWzitHYvZ+dyTMa7xCzO9RMnzHKnf3EHETbSPvkQZ+hJD26rG3Yz6lW/JmCKFqF2yygN+aeLxMii8rjNemjMtEkR7JW8btq81nKDqnju7uQK3ZZzvB2ELYZD7G3Y69EB3uIlaqp7/AT5urM2zQnsbhFEa7+Cup5vd0s68/PV7pvz9x28VhTd8c1oymhhrNj5Gw6LtmY2Usm5D3vUmT4WsXLY1JEbV99Jz1k7Z8mtFv5V14MBT3xBy1yR3qRLCNh+GeOgfwsK655puwLWjaS93O4rAUr/oi0GAlhdKkxjVzt4QyvQH92OWfrWwZyob/XjV1t1dtXQvUHwvoJLbtTFpTG2knAhvSGoRjCoVSc7dR5mhc/PznCmRSWzxEBcevfLbiJNa7MdqMVaWtnPPrKe4B6LDN4LSqITIvSJ2QVMG7dl9IVSiAri2hiE1uq0J/5zLkDvc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 110f9880-7de2-46f4-2538-08dd84500bbb
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB6365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 23:22:28.8302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dt5FwUaY+ANrXrM2tJzepfKFMv6iJ0taNcA+A99E/J57eBB/m8lnd2wlZZB41EO0wOPipJHSnVs6wLX9EIY5HA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7294
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_07,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxlogscore=959 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2504250169
X-Proofpoint-GUID: jYvdo_W4BigleQ94lNLZbto4CMCyqNZD
X-Proofpoint-ORIG-GUID: jYvdo_W4BigleQ94lNLZbto4CMCyqNZD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDE2OSBTYWx0ZWRfX3ICMas3Pn14r ikWsLWIjqT7ciK5ncpSt2lMfRC7+zE794Klx598R/hCvYvwfIfc5gt+r34QbYwoLa/+uF3YSIJV oKx53aZju/TPZh6nPp2US49Q48cf1iaAfYhJH9VbrjfUr0wARFKIP6C/3KMqQaSsHfGDMXNoRym
 66mdGmw7qPHOZV063HoUMl2EBrfDpTW8cik3pPMB74Y07oyqO4cEMl3bcH+3ilpl/dmqHx1T9Ud 4MLnPMluRnjm0/O7uC3JlNIx2IQR1fRbRzoFWbVs8gFMe1Ly0Gn2ONBf4kCQ6bzE+Le1DnfkIbm /jlmNeAxs2AuVcTzcTa36R18H+ZDIqybGBu+5mP3N0qQnCYp0BcIQ9OqRGp9T+ejqtmtuHVQvO3 THrQH/lD

On 4/24/25 7:37 PM, Steven Rostedt wrote:
> From: Josh Poimboeuf <jpoimboe@kernel.org>
> 
> Use the CFI macros instead of the raw .cfi_* directives to be consistent
> with the rest of the VDSO asm.  It's also easier on the eyes.
> 
> No functional changes.
> 

Although unrelated to the current intent of the patch, a question:

   Why does the stub after .Linvoke_userspace_handler in vsgs.S not have 
CFI directives ?

> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>   arch/x86/entry/vdso/vsgx.S | 15 +++++++--------
>   1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/entry/vdso/vsgx.S b/arch/x86/entry/vdso/vsgx.S
> index c0342238c976..8d7b8eb45c50 100644
> --- a/arch/x86/entry/vdso/vsgx.S
> +++ b/arch/x86/entry/vdso/vsgx.S
> @@ -24,13 +24,14 @@
>   .section .text, "ax"
>   
>   SYM_FUNC_START(__vdso_sgx_enter_enclave)
> +	SYM_F_ALIGN
>   	push	%rbp
> -	.cfi_adjust_cfa_offset	8
> -	.cfi_rel_offset		%rbp, 0
> +	CFI_ADJUST_CFA_OFFSET	8
> +	CFI_REL_OFFSET		%rbp, 0
>   	mov	%rsp, %rbp
> -	.cfi_def_cfa_register	%rbp
> +	CFI_DEF_CFA_REGISTER	%rbp
>   	push	%rbx
> -	.cfi_rel_offset		%rbx, -8
> +	CFI_REL_OFFSET		%rbx, -8
>   
>   	mov	%ecx, %eax
>   .Lenter_enclave:
> @@ -77,13 +78,11 @@ SYM_FUNC_START(__vdso_sgx_enter_enclave)
>   .Lout:
>   	pop	%rbx
>   	leave
> -	.cfi_def_cfa		%rsp, 8
> +	CFI_DEF_CFA		%rsp, 8
>   	RET
>   
> -	/* The out-of-line code runs with the pre-leave stack frame. */
> -	.cfi_def_cfa		%rbp, 16
> -
>   .Linvalid_input:
> +	CFI_DEF_CFA		%rbp, 16
>   	mov	$(-EINVAL), %eax
>   	jmp	.Lout
>   

