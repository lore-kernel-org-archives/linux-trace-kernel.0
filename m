Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3381DAC81;
	Wed,  5 Feb 2025 21:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738789790; cv=fail; b=nXcZD6k1Wsgk/I0QyIcWMPDdLzv7Q0ylIxo6MjBAz9uk/EB1cAUPrO0I/WQV4LplvuRsCd5g43g81ZvJpUPFeoSJkpq8gsRM3kDSBpQhDaX/LJdWuJem1mRw0fnR03tlMQrxqwgw/2dUfrRt9VLwJpKBlYK/YWGlMDQc9d0CJuU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738789790; c=relaxed/simple;
	bh=H7IzOe8kA+Vj43kQE1WLNP1ODJzRd6CLKd0bb1AM0yk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WwaXUfqdH9Diq8omtiS7HRI20h10lF/+DzZH9T+6Xhs2SaaKnDDLTTmBUnbULTGbyoA2Ow8jqSaevT2OmNt0SGEXLjv4ZN2D5boQKNlMmLjbSgaY538SHdUdCVdDxX/s3IsI+BBxCONq4XliRqBZ6PmbNwaHdamrckoHRQjO/pY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QmPGWjiT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oF8kueFB; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QmPGWjiT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oF8kueFB"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 515Gg0TD028469;
	Wed, 5 Feb 2025 21:08:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=H7IzOe8kA+Vj43kQE1WLNP1ODJzRd6CLKd0bb1AM0yk=; b=
	QmPGWjiTapkhoBpq/CxkULbVWs8WfzgWuw4JqLOz8kvZvYdyI3sb9RFHQGWGkfcN
	Cidv/XfuYRv3QPpLKOmTbZMuM2YHIrQRYjnhLPyrYPsL5uintY7YmJ+jWo38uRI5
	w9dzvZI5/LxLZV8Pb4ik5qP+ge5ymipjXVQdCRJiiSml1jHxefxZr4F0WjVzm6OY
	YM24/RHmXamRL+hme5cgUpQ0Uf9JVRhDFGHtDi/awLL6MKCktlJuFU3wEYcU0FkS
	MiF8oDxV16ymyK99F9+Yk462o+KDmvk9ZD/h3PbeMnVF232GtiCbHvmX4lQ5G4Rv
	4p2VaPWkDgqsFPQJdI/RfQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44hfch0885-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Feb 2025 21:08:53 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 515K5noC023577;
	Wed, 5 Feb 2025 21:08:52 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2049.outbound.protection.outlook.com [104.47.70.49])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44j8gjvb1x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Feb 2025 21:08:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FbvJMIKzduZ5w+O7bV2/eBDgQEpTzteoHdGwSfMwwjD19jDyJzyIJTTtjsUbDQpqS0DnAt24neoriNw4jNs56FHgZJGRdn23ry3S/a22qoSiebv9ritt6Js7YaCz1f2Yo3Nf0NE5uXlrwkXA8lYXygz4FPgmELiuma4luDCqRc4V3uzBeiKByCiYfsqsuk/xuQBwRfWZrdDLRHvgjCst21xUk91KUnD7y2NqdEuwWDn0IP3+Mfd92EBaKrBbhQ0FH2bydGS9hr8oQoYU1yA6wkTCg/J0xRIndG69zFA76uPvy4ajdhoZTY3t4by7C+UNmldfy7tofTBScsF8eOPXrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H7IzOe8kA+Vj43kQE1WLNP1ODJzRd6CLKd0bb1AM0yk=;
 b=QZ8trGvAY6rWPdDMc8UjoyT9M5T6/3j+E4cR8i/BIS0fd3p3apNpxrS+26QcTgSrj+VJCrMad4obZG19hogG+QqLbN6PWs9hT4/j6g01iTjuBoqUAU7Dg5IBKOCOhV6Y52zET9uKUt8ZXqiNp/FI2c02SjoPA+b0CzTrhkU6pdbxUa7QLl0CQ5dVyDFafHygSqMzHHGmydtgbY7ew9qK9UFtLVjDAZmhgM9zU0b4WbTwqzNGo5k4TL1aW/MiEmKHmfW6VGxyCoTkh1+cdjrZA4V3n/uKgC/QOUGr9Qibb3625Ob2iseWBxOQVdZ98ShJPMSbWohHe5Gcef3SnMsqcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H7IzOe8kA+Vj43kQE1WLNP1ODJzRd6CLKd0bb1AM0yk=;
 b=oF8kueFByrhss9mM1pDMy8EZV6yowDFttDJia652XlnRFuDANGsbX9yxxPReFEFtolJvNrK7cvvst2Y2wzbhax6h6631W2BhLm5pSz71yVjE8ehgIroFCl92z/tKpO1bHlc4AXTLpgtrmhSj00AUSQ+OqnGlThkr2c+Unqlth+U=
Received: from IA1PR10MB7309.namprd10.prod.outlook.com (2603:10b6:208:3fe::13)
 by BY5PR10MB4274.namprd10.prod.outlook.com (2603:10b6:a03:206::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Wed, 5 Feb
 2025 21:08:47 +0000
Received: from IA1PR10MB7309.namprd10.prod.outlook.com
 ([fe80::818c:4ed2:2a1a:757a]) by IA1PR10MB7309.namprd10.prod.outlook.com
 ([fe80::818c:4ed2:2a1a:757a%4]) with mapi id 15.20.8422.010; Wed, 5 Feb 2025
 21:08:47 +0000
From: Prakash Sangappa <prakash.sangappa@oracle.com>
To: Steven Rostedt <rostedt@goodmis.org>
CC: Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra
	<peterz@infradead.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-trace-kernel@vger.kernel.org"
	<linux-trace-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ankur Arora <ankur.a.arora@oracle.com>,
        Linus Torvalds
	<torvalds@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "luto@kernel.org" <luto@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com"
	<hpa@zytor.com>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "mgorman@suse.de"
	<mgorman@suse.de>,
        "jon.grimm@amd.com" <jon.grimm@amd.com>,
        "bharata@amd.com"
	<bharata@amd.com>,
        "raghavendra.kt@amd.com" <raghavendra.kt@amd.com>,
        Boris
 Ostrovsky <boris.ostrovsky@oracle.com>,
        Konrad Wilk <konrad.wilk@oracle.com>,
        "jgross@suse.com" <jgross@suse.com>,
        "Andrew.Cooper3@citrix.com"
	<Andrew.Cooper3@citrix.com>,
        Vineeth Pillai <vineethrp@google.com>,
        Suleiman
 Souhlal <suleiman@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>,
        Clark Williams
	<clark.williams@gmail.com>,
        "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "daniel.wagner@suse.com" <daniel.wagner@suse.com>,
        Joseph Salisbury
	<joseph.salisbury@oracle.com>,
        "broonie@gmail.com" <broonie@gmail.com>
Subject: Re: [RFC][PATCH 1/2] sched: Extended scheduler time slice
Thread-Topic: [RFC][PATCH 1/2] sched: Extended scheduler time slice
Thread-Index: AQHbd1ZTRrvVLtJtBU6gaMtAhKKjx7M34s+AgAAjzgCAACMUgIAAh/6AgACD4gA=
Date: Wed, 5 Feb 2025 21:08:47 +0000
Message-ID: <1A67C4F1-F07E-477C-9781-071546AE3A8B@oracle.com>
References: <EC77D83D-DD17-4CCD-9EF6-C4C39FCE16E7@oracle.com>
 <9DA1FAE6-A008-4785-BDF9-541457E29807@joelfernandes.org>
 <20250204220418.35949317@gandalf.local.home>
 <CAEXW_YQxTi2y_hY_e4AjLSa6RwVVLn3DPj5d4Cfewq0js-0UTA@mail.gmail.com>
 <20250205081635.397eacb0@gandalf.local.home>
In-Reply-To: <20250205081635.397eacb0@gandalf.local.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51.11.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR10MB7309:EE_|BY5PR10MB4274:EE_
x-ms-office365-filtering-correlation-id: fa16d9f9-3dec-439f-7918-08dd4629483c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?anBDYXN2cU0yQkVtNGpqZWFtbSt4MjhmN1lsVldBTHNnYUJ4ZHFqTG0rYU92?=
 =?utf-8?B?VjFkOHdPVFBXa0U5VitBL0EyOFIyNkxxdFBYZm1ZdWJUWlB0aldzb0cyeGtK?=
 =?utf-8?B?NU50MFh5ajRKTWgxVnhHd3JwQlRZUEhGc3F3S21hUnkrRTFycVZadTZRcVIz?=
 =?utf-8?B?TGxhVE1saDJ2aG56Q3NXZ3g0L1pDZmxoajVwSFVSUlpGSkd2TzRXcUJISmVr?=
 =?utf-8?B?SCtpYXJOTFliVHlSaHpackZVMjlRT0R3TmZicDVXMUxJRUNrK2ZGTHFwUHJN?=
 =?utf-8?B?RDFQSnI4aFdocUIvZWs5M1BKaG0wK3MxZittVW1OQ3FId1FQM3JaMVZrQ1FO?=
 =?utf-8?B?UEtOUHV0YTRWL1NKRlRWcFNqTG5kL0VtbEFYVWhVYmtNK2tzbWZFUDBoMUZD?=
 =?utf-8?B?VW5oazBTeHZxSWk5a0JvbnEvc3BkSWJLdXNPUmhEd2ZhWitqblMxcVhXZnp4?=
 =?utf-8?B?MHlHeVcrcXRUMHh1a1d2TytJa01FMUY0bmRNSkw2Yk83SkJLRnBnL1lObHBv?=
 =?utf-8?B?SHJOLzRmYVlqY0Nvb1dMY2VFUHhqSkVRMTM3MkE1TkFHN0V6Qlh3bGdOcFZD?=
 =?utf-8?B?cGs1b056ZjlhWTZlcHdHYnNTNmp4ZjlXbXd3MWY0Q20yV0U2UE5NWGJQYTZy?=
 =?utf-8?B?YXVsRXpjQ0k3eE1ISjR0Qm53d2hzL2g5WHBlNHZsY211S2J0Z2RrTDBiTitQ?=
 =?utf-8?B?L2hSVU9yNnJneHJQczlsUjZDK2FSdGhkeVlrczZaQkpEL24wdGIwUzk3Z3ZZ?=
 =?utf-8?B?T2Q1RjY1WlNoSU9xWHBTallNOUtyMEU2Y1JPSWF3cDFzdnVaakdkQ0IzeHNB?=
 =?utf-8?B?OUhXNmd2dTRJdnRPSWM1Z1JaS2hHSFA2NUZsWUNobC9KT1Q5M0dwWEJOWkpZ?=
 =?utf-8?B?MEpZSnNUSC81M242Rmp0N1hxVGFNcGxxVUIyUzVJbTh4bzIvaldXS3lGUUVq?=
 =?utf-8?B?RVJMUEswdWl4ZzFCeURqb245VURvV1J3djZ4c0JHSnVualpxUzBYRE53OWg4?=
 =?utf-8?B?KzE3YTZLRmNERDkrM1JqQ2MxcklNTlp3VjhnMW9lRUs1WmdLNnFOTGhjbGZv?=
 =?utf-8?B?Z3hWazZBZDhENkR1RVU4VEZnTWg4eEVSQkZ0dVZGTGt3eG0wemFFa0tMSWR1?=
 =?utf-8?B?OENhNTRpa1JKWmNjTWlwQXcvWWt0amhVU21RK0QzQ1NpYm51UkIrb3RaVDB2?=
 =?utf-8?B?MVZGYzlPOE5aR3h5MzduczR1OTdrSjZIS2p5RlpTL0JvcldkTWR4Zi8yejdM?=
 =?utf-8?B?bVdPTUFXMjRiZXdpaE9TdWJML0dZK2lhdEhhb25jbFRVVFI0dGRhSStZL3ZL?=
 =?utf-8?B?MlFTZ21XUmhLM01EMmQ5OVgyRngrS0RvZnkyOUFKS1VHc2MxdVc3SjJQQjdH?=
 =?utf-8?B?eWYyRy9TK1ZVbkFLM1NXaTgwL09VTFRUb1lkRk1WV29DVDMzcW41WGRlRCsy?=
 =?utf-8?B?d1hueVlpU0VNSXJGa1drREVOVjYydi80OU5BUU8xNjVOczQ2ZllLOTZ3ZkV6?=
 =?utf-8?B?S0dLY2VDalRKdmtEaVBPOFp6aXE5dnVjYTEzQm5PUS9qVHJnK2p4WWNJY1VI?=
 =?utf-8?B?KzlZRlB3OSsySkRYNGpDZXJsYWd2SXEweGtLRW1haFFOM2QvS2k4cnBpdGtM?=
 =?utf-8?B?U2xBY1NTSmNseWRIUGtBOGE0Q3BUbVlYZFFpVWwrTmh0azJ1TDY3d0FhU0E2?=
 =?utf-8?B?aXJBaVd3NHZhRlNoa2NmU2piOUNqaWROSjZna3NOZVVrTTZiQ01qMkU0SlRr?=
 =?utf-8?B?RnVxMmhsMDYzbTNBM0Q2RDZwQVVocjVCZVZ3eERaQmE3UGM4cHVxWUZTelJ6?=
 =?utf-8?B?aGhZMitURU1OcEQzUytkWWRUWDU3YUJGcSt4MkZWdnFQdzAreWZ6UWNHMHgy?=
 =?utf-8?B?S3piZU45dmNkTGMyYVdKNlEwdGlmRVdBTkdEU2FOdkNyYzE5eWdNNmQ1M0NQ?=
 =?utf-8?Q?DO68AiXIRYIqDJcfd6cUVaa03hKR0eEa?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7309.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eGNyd3pWNjg4bUpUNkZ0R0xXa0FnYnZHdUFCRFFMSCt5QjdGdGhxV0xuZVFs?=
 =?utf-8?B?R3FqRnBvRGVVMGJMY1duVm1KbUlWUlBiV1R1QlVFaEFBVGdFSzA2QVRDUW51?=
 =?utf-8?B?VlZTRWF2aFhONTNvNW5rUDVqR2lxWm5XelcvNzFqdUFsVWVEaW8yRjlmdHNr?=
 =?utf-8?B?SERhc1M5ZDJkV0Q2MFFqcG1GdEgzUS9wYmFWU0ZsaHQ0amNEcDh2SnNrRyt6?=
 =?utf-8?B?TkNwOENiTm1LVUxCcU1wK0pwTDdEZjIvOUFkR0MyMmc2K3d4c2V5VndGekw5?=
 =?utf-8?B?SDlBVFFkK0lGd2Q4QVV4TG40bHdpMklYQXlrVmh0d0JlY3RGa0hmVWlqdW1m?=
 =?utf-8?B?U2QwaTZxcUR0bDd3Nzc5dGFZNUZEdE84ZmxoR1NLVWRsUEQ5SVdTcm5HeXps?=
 =?utf-8?B?OTdWblR6R1BpbXZHdzNlUkV2WFd3R0FKcGl3aVJ6REE0K0V1NjVjVHdRSVgz?=
 =?utf-8?B?MnFoTVcza0UySzk5dUZla1V6SDdLTGRBbUxRM21BbGZ6Wmp6R0JnSzBKdUJ1?=
 =?utf-8?B?cDRkeUZUQ0xYT0tNN2lVK04xaUpxWUJzRGw0MGkwSEdnb0wxMDAxNDZWYk9R?=
 =?utf-8?B?dG93L091UnNvd1ZXbDJRSnJFcUZsa2JnNE9kNlY3Q1dyOFJGa2NVN0pZa1Rq?=
 =?utf-8?B?RGhRaXRuVlF0M0JQYkluV3owYkZjSUFlbktVemp3alljTlgzbFF0dStvbHVT?=
 =?utf-8?B?SGZ2MFF4NXVDWnhob3hTTGRvS08vUTRveEM1RXBvUVJNMlN2QTV5emc0Tm9r?=
 =?utf-8?B?end2bnB6OHVna2JPODBGNG10bUVHTVlqOWtBcDhWQVY1ZEtVbjdSZitvV1lU?=
 =?utf-8?B?bThuZTlwMk4ydkhxTjJORUFkZmVoSU8zTWs2VVl4UU9NMXRNSUFMbFNvdThI?=
 =?utf-8?B?bGNKZnNWR0JnaDUvYVc0VlRJNCtDVEtuNlVRUjgrQ1RrRDF5ZHFVTEFpUFpl?=
 =?utf-8?B?QjJ2ZGcycGdkZHR2eEdxMjg2VWx0UEtOdHFHMHl3UmdQZkZLcG9LcFJVSTh4?=
 =?utf-8?B?N200UVhReVNzcGFtcjBJV0N4UnFPSkRGQXdlZ0trWGlaN0JxczBrV204U0FT?=
 =?utf-8?B?cWpzd2tRSysvZU1TL2ovUytZSmFtcGFmb213VXpVRjRiNWIwcjA2RlliQXBT?=
 =?utf-8?B?bGl3Tm04czh1T2NyeXpMNXdLSlpYNmdqRWdlRldEci9uTFNlV1VaOVhsTkN6?=
 =?utf-8?B?Z0Vjc2FqMTI3RW5nWVp6MytkRjNOdm13Kzh3bmVHREZpU1diWjQ1RVJ1cGtT?=
 =?utf-8?B?Q3BzbEdCTFJralpvcTlldUwwVE1NY2JaUzZqVnZsdFNqYUJEd3ZwMXFNRVdK?=
 =?utf-8?B?T2FOa25CWTJDQ0owUUwrU1FwNk9VclVWWHVJVGlocFFxUXVKZW5OL2NCWTFy?=
 =?utf-8?B?SlUwUk5vTWpMMU5SYlJxa0c3RS9VbFExNEloWU15OWpNT1hNbmx4TFFYNEx6?=
 =?utf-8?B?RERJdTFBcGxqZFZybjZzNjVLWFpwZ0ZiSGY1SmpDVkRuWlpYR3pMei9DVU5w?=
 =?utf-8?B?bTdra3N1enRHS2F4UjZRQ2VlalJ6dWZVNGtjeGNOOHdQZFNpSG4yem9xQVli?=
 =?utf-8?B?YzY0a08yYjNFaXVBWDc5K2tCbDZQdVE4WGcvcmJoSmliMlUwV0gycWFIU2ZL?=
 =?utf-8?B?dnBXSkhjSVZ0TDFhcElGcEN6bjJpL2RGZDZ5a3dXdG1RcnZFTVN4NnVlQTZ2?=
 =?utf-8?B?dndlR1gwbEpzNWlnWFRmdjBtbFk3TlNBM1pia1dLOXhsankvTHd5RVB6TXdm?=
 =?utf-8?B?ZjF5VzdkaHlYMU4xeG5tTmpvSFdFMlp1dUtWWmVvMlNLQnlPVmJCd0RuTWV3?=
 =?utf-8?B?SkJHUVlDUFAwbTdwYW1lblAzWHVBcEhUTTh0WmdzUExNREd2TkNodWRCUWRL?=
 =?utf-8?B?Nis3WWlKSVdXOUZyV0RYajJIWTZxSkwyVXhtY09xci9CUDA1MzNhbWR2WWdm?=
 =?utf-8?B?Y2YwZFduQThrK09ZNzFGMEVwakxUVDgyaTIyMEhIdWdMRWs1SE4yNlBTZXJI?=
 =?utf-8?B?d0dnK3hVS042RTBtNTUvOGl4d0p4VnVEbTVOZjdZQ2JGamR5MzUxOXFVWkJN?=
 =?utf-8?B?UUpDQkh1SU1INDZMNFpxa0NVQmp2UmhOT3dmQW1ld2I4aTRNWVVML1ZIenZl?=
 =?utf-8?B?d0kwRlJ5dkw5TXdrSTdHZnRDYXhwMG5kRW4rTEl5RVQ1dVZ5T2FMa3BzQXU1?=
 =?utf-8?Q?QmhAIS6RGmWne1CNGSJ9cwwSb9bQ1XqS/8haJnsDeqDh?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C96BF26D281AAD4EBF7C31B7C80C061D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5Icbm7RrGgLzJ1sy84hdhe86vDtUNMc5ULQA5oUCTNwW1IqkYIsUACTG1eUMISL1fLwvA/2pLuw20WhfDRwDytmRgkUmduk/Lw9GGgwProRXyzmz6dYbG/yOkPvRC6P/sivu/Nt2rtGEBNV/MNBkMIqgLYjz9Xm0ckm9mXNdC9XhZx/JRn96gY2kVSnhJ6CbnLxe6HmMzzNuuTbp9Ecp4XUnsKfkUZEgNX+2JMvWDlchq92bhIoMbFs3rfd5gyjE0+Zn8sZ4oORb4sxx5F9uFbkRFw37nTFQUv9fgRQSI2dskfh8PQ6AEDNok1UCwwwJlYM8siF8saLQIO3/3YFeJ//X09YuwcVDbG68z+TrHkLusCEVw4m4VRD1ikwKzsXh1zrut2sdSVZoGwKKIRlaVDiYI/k6Cy9X2MNtqFdkisHDmEkYn/wAjBUVC4aBOOVVMnJZRYbUS6lwYXaD6eFIFsoh2Pn2/kfqY0jIlSrCx+IKv6pcnQVUfi+NkNJakHNKhtnoRW4GqlcE/q7Ti/0HyV/fNnNtElKDicb5iNJIX6zRrKVlXdpDDl9RUSHFsY8kSYgK99y0yhkAoZ9QiSh6VxS0ba7mAuBqOvtQq+ohx1U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7309.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa16d9f9-3dec-439f-7918-08dd4629483c
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2025 21:08:47.5671
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +kkKiDq/SrG8MuF0bHHbDsyuE4kJUWmpdDcuOTpRRcpZndW+E+4b11k0WvrKuxlqwj8UrKc6/ksBIMZ06y9a8nBCEVGUuVVuOdnqRqUUzc0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4274
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-05_07,2025-02-05_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 phishscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502050161
X-Proofpoint-GUID: w8ZlnbcWL-DljIo2o_SofqptSFDmQQwl
X-Proofpoint-ORIG-GUID: w8ZlnbcWL-DljIo2o_SofqptSFDmQQwl

DQoNCj4gT24gRmViIDUsIDIwMjUsIGF0IDU6MTbigK9BTSwgU3RldmVuIFJvc3RlZHQgPHJvc3Rl
ZHRAZ29vZG1pcy5vcmc+IHdyb3RlOg0KPiANCj4gT24gV2VkLCA1IEZlYiAyMDI1IDAwOjA5OjUx
IC0wNTAwDQo+IEpvZWwgRmVybmFuZGVzIDxqb2VsQGpvZWxmZXJuYW5kZXMub3JnPiB3cm90ZToN
Cj4gDQo+PiBPbiBUdWUsIEZlYiA0LCAyMDI1IGF0IDEwOjAz4oCvUE0gU3RldmVuIFJvc3RlZHQg
PHJvc3RlZHRAZ29vZG1pcy5vcmc+IHdyb3RlOg0KPj4+IA0KPj4+IE9uIFR1ZSwgNCBGZWIgMjAy
NSAxOTo1NjowOSAtMDUwMA0KPj4+IEpvZWwgRmVybmFuZGVzIDxqb2VsQGpvZWxmZXJuYW5kZXMu
b3JnPiB3cm90ZToNCj4+PiANCj4+Pj4+IEhlcmUgaXMgdGhlIFJGQyBJIGhhZCBzZW50IHRoYXQg
UGV0ZXIgaXMgcmVmZXJyaW5nICANCj4+Pj4gDQo+Pj4+IEZXSVcsIEkgc2Vjb25kIHRoZSBpZGVh
IG9mIGEgbmV3IHN5c2NhbGwgZm9yIHRoaXMgdGhhbiAoYWIpdXNpbmcgcnNlcQ0KPj4+PiBhbmQg
YWxzbyBpbmRlcGVuZGVuY2UgZnJvbSBwcmVlbXB0aW9uIG1ldGhvZC4gSSBhZ3JlZSB0aGF0IHNv
bWV0aGluZw0KPj4+PiBnZW5lcmljIGlzIGJldHRlciB0aGFuIHJlbHlpbmcgb24gcHJlZW1wdGlv
biBtZXRob2QuICANCj4+PiANCj4+PiBTbyB5b3UgYXJlIGZvciBhZGRpbmcgYW5vdGhlciB1c2Vy
L2tlcm5lbCBtZW1vcnkgbWFwcGVkIHNlY3Rpb24/ICANCj4+IA0KPj4gSSBkb24ndCBwZXJzb25h
bGx5IG1pbmQgdGhhdC4NCj4gDQo+IEknbSBnbGFkIHlvdSBkb24ndCBwZXJzb25hbGx5IG1pbmQg
aXQuIEFyZSB5b3UgZ29pbmcgdG8gaGVscCBtYWludGFpbg0KPiBhbm90aGVyIG1lbW9yeSBtYXBw
ZWQgc2VjdGlvbj8NCj4gDQoNClRoZSBuZXcgc3lzY2FsbC9BUEkgcHJvcG9zZWQgd2FzIHRvIHBy
b3ZpZGUgcGVyIHRocmVhZCBzaGFyZWQgbWFwcGVkIA0KYXJlYShzaGFyZWQgc3RydWN0dXJlKSB0
aGF0IGFyZSBhbGxvY2F0ZWQgZnJvbSBtZW1vcnkgcGFnZXMgdGhhdCBhcmUgcGlubmVkLiANClNv
IHRoZSBrZXJuZWwgY291bGQgYWNjZXNzIGl0IHdpdGhvdXQgdGhlIG5lZWQgZm9yIGEgY29weWlu
L2NvcHlvdXQuIA0KDQpUaGUgaWRlYSBpcyB0aGF0IGl0IHdvdWxkIGJlIGhlbHBmdWwgaW4gcGxh
Y2VzIHdoZXJlIHdlIGNhbm5vdCB0YWtlIGEgcGFnZSANCmZhdWx0IGluIHRoZSBrZXJuZWwgY29k
ZXBhdGguDQoNCg0KPj4gDQo+Pj4gQW5kIHlvdSBhcmUgYWxzbyBPSyB3aXRoIGFsbG93aW5nIGFu
eSB0YXNrIHRvIG1ha2UgYW4gUlQgdGFzayB3YWl0IGxvbmdlcj8NCj4+PiANCj4+PiBQdXR0aW5n
IG15IFJUIGhhdCBiYWNrIG9uLCBJIHdvdWxkIGRlZmluaXRlbHkgZGlzYWJsZSB0aGF0IG9uIGFu
eSBzeXN0ZW0NCj4+PiB0aGF0IHJlcXVpcmVzIFJULiAgDQo+PiANCj4+IEp1c3Qgc28gSSB1bmRl
cnN0YW5kLCB5b3UgYXJlIGJhc2ljYWxseSBzYXlpbmcgdGhhdCB5b3Ugd2FudCB0aGlzDQo+PiBm
ZWF0dXJlIG9ubHkgZm9yIEZBSVIgdGFza3MsIGFuZCBhbGxvd2luZyBSVCB0YXNrcyB0byBleHRl
bmQgdGltZQ0KPj4gc2xpY2UgbWlnaHQgYWN0dWFsbHkgaHVydCB0aGUgbGF0ZW5jeSBvZiAob3Ro
ZXIpIFJUIHRhc2tzIG9uIHRoZQ0KPj4gc3lzdGVtIHJpZ2h0PyBUaGlzIGFzc3VtZXMgUFJFRU1Q
VF9SVCBiZWNhdXNlIHRoZSBsYXRlbmN5IGlzIDUwdXMNCj4+IHJpZ2h0Pw0KPiANCj4gUlQgdGFz
a3MgZG9uJ3QgaGF2ZSBhIHRpbWUgc2xpY2UuIFRoZXkgYXJlIGFmZmVjdGVkIGJ5IGV2ZW50cy4g
QW4gZXh0ZXJuYWwNCj4gaW50ZXJydXB0IGNvbWluZyBpbiwgb3IgYSB0aW1lciBnb2luZyBvZmYg
dGhhdCBzdGF0ZXMgc29tZXRoaW5nIGlzDQo+IGhhcHBlbmluZy4gUGVyaGFwcyB3ZSBjb3VsZCB1
c2UgdGhpcyBmb3IgU0NIRURfUlIgb3IgbWF5YmUgZXZlbg0KPiBTQ0hFRF9ERUFETElORSwgYXMg
dGhvc2UgZG8gaGF2ZSB0aW1lIHNsaWNlcy4NCj4gDQo+IEJ1dCBpZiBpdCBkb2VzIGdldCB1c2Vk
LCBpdCBzaG91bGQgb25seSBiZSB1c2VkIHdoZW4gdGhlIHRhc2sgYmVpbmcNCj4gc2NoZWR1bGVk
IGlzIHRoZSBzYW1lIFNDSEVEX1JSIHByaW9yaXR5LCBvciBpZiBTQ0hFRF9ERUFETElORSB3aWxs
IG5vdCBmYWlsDQo+IGl0cyBndWFyYW50ZWVzLg0KPiANCj4+IA0KPj4gQnV0IGluIGEgcG9vcmx5
IGRlc2lnbmVkIHN5c3RlbSwgaWYgeW91IGhhdmUgUlQgdGFza3MgYXQgaGlnaGVyDQo+PiBwcmlv
cml0eSB0aGF0IHByZWVtcHQgdGhpbmdzIGxvd2VyIGluIFJULCB0aGF0IHdvdWxkIGFscmVhZHkg
Y2F1c2UNCj4+IGxhdGVuY3kgYW55d2F5LiBTaW1pbGFybHksIEkgd291bGQgYWxzbyBjb25zaWRl
ciBhbnkgUFJFRU1QVF9SVCBzeXN0ZW0NCj4gDQo+IEFuZCB0aGF0IHdvdWxkIGJlIGEgcG9vcmx5
IGRlc2lnbmVkIHN5c3RlbSwgYW5kIG5vdCB0aGUgcHJvYmxlbSBvZiB0aGUNCj4ga2VybmVsLg0K
PiANCj4+IHRoYXQgKG1pcyl1c2VzIHRoaXMgQVBJIGluIGFuIFJUIHRhc2sgYXMgYWxzbyBhIHBv
b3JseSBkZXNpZ25lZA0KPj4gc3lzdGVtLiBJIHRoaW5rIFBSRUVNUFRfUlQgc3lzdGVtcyBnZW5l
cmFsbHkgcmVxdWlyZSBjYXJlZnVsIGRlc2lnbg0KPj4gYW55d2F5LiAgU28gdGhlIGZhY3QgdGhh
dCBhIHN5c3RlbSBpcyBwb29ybHkgZGVzaWduZWQgYW5kIHRodXMgY2F1c2VzDQo+PiBsYXRlbmN5
IGlzIG5vdCB0aGUga2VybmVsJ3MgcHJvYmxlbSBJTU8uDQo+IA0KPiBDb3JyZWN0LiBBbmQgd2h5
IEkgZG9uJ3QgdGhpbmsgdGhpcyBzaG91bGQgYmUgdXNlZCBmb3IgUlQuIEl0J3MgU0NIRURfT1RI
RVINCj4gdGhhdCBkb2Vzbid0IGhhdmUgYW55IGNvbnRyb2wgb2YgdGhlIHNjaGVkIHRpY2ssIHdo
ZXJlIHRoaXMgaGludCBjYW4gaGVscC4NCj4gDQo+PiANCj4+IEluIGFueSBjYXNlLCBpZiB5b3Ug
d2FudCB0aGlzIHRvIG9ubHkgd29yayBvbiBGQUlSIHRhc2tzIGFuZCBub3QgUlQNCj4+IHRhc2tz
LCB3aHkgaXMgdGhhdCBvbmx5IHBvc3NpYmxlIHRvIGRvIHdpdGggcnNlcSgpICsgTEFaWSBwcmVl
bXB0aW9uDQo+PiBhbmQgbm90IFByYWthc2gncyBuZXcgQVBJICsgYWxsIHByZWVtcHRpb24gbW9k
ZXM/DQo+PiANCj4+IEFsc28geW91IGNhbiBqdXN0IGlnbm9yZSBSVCB0YXNrcyAobm90IHRoYXQg
SSdtIHNheWluZyB0aGF0J3MgYSBnb29kDQo+PiBpZGVhIGJ1dC4uKSBpbiB0YXNrc2hyZF9kZWxh
eV9yZXNjaGVkKCkgaW4gdGhhdCBwYXRjaCBpZiB5b3UgZXZlcg0KPj4gd2FudGVkIHRvIGRvIHRo
YXQuDQo+PiANCj4+IEkganVzdCBmZWVsIHRoZSBSVCBsYXRlbmN5IHRoaW5nIGlzIGEgbm9uLWlz
c3VlIEFGQUlDUy4NCj4gDQo+IEhhdmUgeW91IHdvcmtlZCBvbiBhbnkgUlQgcHJvamVjdHMgYmVm
b3JlPw0KPiANCj4gLS0gU3RldmUNCg0K
