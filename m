Received: from mx0a-007b0c01.pphosted.com (mx0a-007b0c01.pphosted.com [205.220.165.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDC31A29A;
	Mon, 14 Apr 2025 23:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744674596; cv=fail; b=YUiyMHFnaudgJeSUCJn84OmeG/MCA2QX/TeDTHQ2jn1nNQtBr0H+6yuBT6hZ/F8IWxNdqn5e6tVJsmEaLPZEGxC2z8a+DAdFxi7zAADgAbtj6WC1DnSSY/wEr/D5UwfLV6VPOHQb0bLXFyFdbJcbTjdeVR7uA/D3FQl0zgg8LIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744674596; c=relaxed/simple;
	bh=lwyD4FBFOj7s1m18PlhPF3QerX+jEU7Mfitbt23YcC0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Y8YRTFXkFBnHmbiIYZnATm0X8lp1zme7MP1pqedBgd8c/fiXEvkBWlQlKARngUPZzYnsENcVlLhP5Kcz3cgSP3zHYZWFUfMCtDfR4PA+Yp3FrGSoSfZG4awKKWPO2hj1BrA9DrPad8vo+48CZAWNmejSIx9YghiU4Hr6ZtropQo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.wisc.edu; spf=pass smtp.mailfrom=cs.wisc.edu; dkim=pass (2048-bit key) header.d=cs.wisc.edu header.i=@cs.wisc.edu header.b=Qi2y2RBK; arc=fail smtp.client-ip=205.220.165.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.wisc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.wisc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.wisc.edu header.i=@cs.wisc.edu header.b="Qi2y2RBK"
Received: from pps.filterd (m0316039.ppops.net [127.0.0.1])
	by mx0a-007b0c01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53EIsv1U016457;
	Mon, 14 Apr 2025 18:49:28 -0500
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azlp17010018.outbound.protection.outlook.com [40.93.12.18])
	by mx0a-007b0c01.pphosted.com (PPS) with ESMTPS id 460a96u013-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Apr 2025 18:49:27 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=khaPqwIgYNX42kTwF9x83VFMtQoCyANrD/gTp0lYYfcugNCn03ygxg5nRpgl6QV0syC6hqU4G/biysI7r/O+B+AErck2qSNhH9bylIxjvds6cOglan5XfF9rszwCW3unTdciFw+EXc0od2DQvTOf3L5eCwWgRQPZBZ7DMz1m6quYVvBW5KksUHEGaY4ny7YjxvuoX/gEQ1TtOtm7XNrFV22EWURsAoEPa2cbw5T74l3Q1UBRUykDPOpw5szOtV8ysyhgMSVuhkM8GsPIBP5RMo15m/r4ROPd6YKpDJK0awxPulImhOVvhI99AM2Bw3unAx70Hr0BqLGXlin5qFyirg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=56M8ziazaRL0kTq7WE21HzrJWYx9NjvFrLmqk29eT+w=;
 b=as1FJfw+uSxBqBYhLsNFCqjh2W1yFWVz79EtGBeziXCpabOHlVlYYmRFD/lLs6Fwc4yDtpG0lPNwfqjdQqA6I42TChi9frHrbOKd/5gP+wtBD7Z5QrUr2N7lIqK2dWIr8Cl8le5lc17GcYGXituvfZ08+0vB66zzSjK8sgzE32m/F/5KlCb5orRtRpck8MopGH8lSDQjgrTzOp/W8s5UW1wNQG5+64WgL8i6NyyutCKQmIk8uYt6+NxeKTFv0AzgmLqKSmyYS9CyhJ4pmb41S1Nx5JTs5+70eANi6XTJpLwR15O5orY56bAdp2+LBex9Sr0DsvlAqFTtMQfZ9ENrJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cs.wisc.edu; dmarc=pass action=none header.from=cs.wisc.edu;
 dkim=pass header.d=cs.wisc.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cs.wisc.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=56M8ziazaRL0kTq7WE21HzrJWYx9NjvFrLmqk29eT+w=;
 b=Qi2y2RBKodVm0PKR+86clDI3ZQ5PW6R1U5u00buSmi52Xbr7HvqJq443wFoWdkai5EryNLdhttOdwo1N3sMFYYKEkilxdMaA3410ER43TxfnTIEOvBU+v0UIQWugCL23jXKFHTO7m8ofJqjxiWdxZXY0/iLzQSMPdrljhcv8uTXs80yRBseejZp/t2YRuz5aMEn2cjtuZG/DunxvnHp9hZZn4O9DyXu+kmNAZqEKPqWKRXw+REsgvozBBQCMqR0NkBATU2d/WqGgb4siiUHhOspT5ACXZuwYlfQeXu9PyzTYp23A8lPsFplpg71h5cA3QLjcf9YSeK0vtFH6OXzptg==
Received: from DS7PR06MB6808.namprd06.prod.outlook.com (2603:10b6:5:2d2::10)
 by SN7PR06MB7294.namprd06.prod.outlook.com (2603:10b6:806:104::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Mon, 14 Apr
 2025 23:49:24 +0000
Received: from DS7PR06MB6808.namprd06.prod.outlook.com
 ([fe80::76b2:e1c8:9a15:7a1c]) by DS7PR06MB6808.namprd06.prod.outlook.com
 ([fe80::76b2:e1c8:9a15:7a1c%5]) with mapi id 15.20.8632.030; Mon, 14 Apr 2025
 23:48:36 +0000
Message-ID: <5fd0a429-95b8-4ed6-9e2a-83887b40bf54@cs.wisc.edu>
Date: Mon, 14 Apr 2025 18:48:32 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/tracing: introduce enter/exit tracepoint pairs for
 page faults
To: Steven Rostedt <rostedt@goodmis.org>, Dave Hansen <dave.hansen@intel.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
References: <e7d4cd81-c0a5-446c-95d2-6142d660c15b@cs.wisc.edu>
 <214abd94-7fb3-4515-a1ae-a60abe81af88@intel.com>
 <a40a1add-00a5-49bd-887a-5fc722c9814a@cs.wisc.edu>
 <41e7d947-d59f-41a9-a540-d3c07e4678c4@cs.wisc.edu>
 <d64ec287-c85e-4b50-beac-4517462882f6@intel.com>
 <20250414194346.060f96c6@gandalf.local.home>
Content-Language: en-US
From: Junxuan Liao <ljx@cs.wisc.edu>
In-Reply-To: <20250414194346.060f96c6@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9P221CA0008.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:408:10a::30) To DS7PR06MB6808.namprd06.prod.outlook.com
 (2603:10b6:5:2d2::10)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR06MB6808:EE_|SN7PR06MB7294:EE_
X-MS-Office365-Filtering-Correlation-Id: 08603552-0ee9-4c2a-f2ca-08dd7baedec8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|41320700013|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NmxNMjFjR3owUWc2ditIeHVpN2JMZGI1WGZFY3hrZEkxbkdPdXkrSlJjTzZT?=
 =?utf-8?B?aWhOaTE2VUFvNTN3MFh1U3dlVElnd1ZkeFdZKzltRE9WYlNFeUNVMTN2V0RQ?=
 =?utf-8?B?Um1UenlTR2ltdkJ4TjFVNm1tbUJJTzFuQ1ZheDI4ZlFrRzgxNEJWeWx6Tit5?=
 =?utf-8?B?NTFwSDA1WGpyY1dlMUJOV3N3STR6UThVdldjTVZSemdlMHhmZnVVT04yVHJ5?=
 =?utf-8?B?MmpqMTRtaTcwWXRhQnJyU3ZabnFXNk9xd2hvN2xBd0VjV0FZSVM2L2FrVnM5?=
 =?utf-8?B?MFcrRE1DUHo2L1ZwWXZleDNTNXFxUXJ4ZjAvTmhpWGNQbnVTUi9wSzBJN2RH?=
 =?utf-8?B?ZU9SZHZrRU1IaDNZRzUrV0FoYWZsS1JCZXROdXp3SjNkTFdoWDlmZk43aGNE?=
 =?utf-8?B?QjB0eXY4djJyRmJMdGlyR0tJNDlTRzMyQmtMS2U1RWNoTXpnMkNQaUdneEU5?=
 =?utf-8?B?MlhaQlRUb0RiYXpuVUU1b1ZhMTJzV2I5N01lellTNEJJU2FieG0ydkFDYWdq?=
 =?utf-8?B?SHQxaXhOcVBKK2NOeFRaMWNhc3dsejkvcHZiMWV0dG5ZWVFybjhBeG5XQ05k?=
 =?utf-8?B?WkxUV0VDTEhPM1VRbDJiYklkdTVLL3hQWnBXSVA4VXJybFphOWhtTkVMa2FR?=
 =?utf-8?B?UDAwNXJkSGFkYUo4RVowbEpPMmtrV1BxM3gxSFcwcEF4RE05dkVxTDFYWlNG?=
 =?utf-8?B?RXpsZzdmUVZvalNQaFA1UVArdkZreDhrNjZ3VzRLazNqNE90NjlNVkN1TG5C?=
 =?utf-8?B?N3dmSnVIWXVkU2liSExIN0hyR1Y1N3h6ZU9HQUQvN3RhWjZRTFB6WTJFMTFx?=
 =?utf-8?B?RC8rb3RhcnNCOVZRekRtSGxJaTJpOWhua3NxMXB4RU9DeXEwMzdqdnVROVdm?=
 =?utf-8?B?ZnlDSDFFT3UvYzdsdGQ3cjFZN3RqL3V4Y1hER1RCSVc1SnNhQkJPQzhVWFhv?=
 =?utf-8?B?RU9Bam5RTzVaZ0M1SkFJT3VFcWtzMmQrcVdrckhSa29UeGdwLzVCZFFKSmh4?=
 =?utf-8?B?NC84dUhRaFM0UGJqakE2MCs2emgxaWVLd2VUYjcyZ3JWaFpWSEE1TFIxTldK?=
 =?utf-8?B?dU5IbHNlckdVRFhXRE1ZQU9lMFRGZUoyRmJha3dXMi81ZDFlZGx6SWIwbEd6?=
 =?utf-8?B?UWUyOFRBVWRqdXZZR0ZhS2wrRDdKSlFkamprREJoQnlJRmhPYXloM2padjY2?=
 =?utf-8?B?M2lLWHR2bUVKNzRGZ2E5ZkYxMDVzd1FuMElwZFRiYUY1UEdnb2xLVlNMUGJr?=
 =?utf-8?B?OTd2eW93dU5SMGxrejRlU3lndHZTMHI2MTlHcUNYdGpia3FkUDBzUmdZdUts?=
 =?utf-8?B?R3BOcGNSWlhDbUxwTFpLWjB4TkUxclZZTGJsejJpaTJoWENUQm9BclBrcXdE?=
 =?utf-8?B?RVZPeGxwRDl0R0V5aFkxL3UzNG9tbi81aTljWEo5Znl2R3huTTN3V3dZTWtx?=
 =?utf-8?B?Q1ppa1p2OC9TM3lHejlrd1c3eHlOU2pxTmxWQ3JCVlRmRGdxYTFlVmRuNUNZ?=
 =?utf-8?B?M3RtZVNBZjJObjcxcm1ZSnpwMFRFNE9ZS3hrazU2UEQ1TDVEbUZieHBRU0o2?=
 =?utf-8?B?Mit5VXFxNmRhM08rRko0V09SaXlqam9lbU9uUjZieFgwWlB0eE9iTzBGOGp1?=
 =?utf-8?B?bVZZUEc2T0Mzak5QQkoyVEVIaHNBQVAyaGZhZlpIbWU3REYyUVpNaEdnSFdu?=
 =?utf-8?B?cERZaklUWDFaWFkzWkttV0FxTTNnQnpFaHJIVVF6eGtacy9QVjcrTWRBMVNH?=
 =?utf-8?B?RU56QmZoTmh0SVJsU2swUjR2di8waVlRNjdVL0xjczV2WWN3MlF2VTN5MjF5?=
 =?utf-8?B?S0xjejB0dlhOckZ1NlQydHArZWlOSEU3Rm5uSW43bDUwWndSZGNkUUJ1V1o5?=
 =?utf-8?B?TjdWSVNCNFNsNHU5MnFFczdVWC9YVzYvc2VLdk5ESmN3VVhhRzlHV1IzS0Fu?=
 =?utf-8?Q?IUYP/ikhFCM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR06MB6808.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(41320700013)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V2pqbFcvZXZkeEpqMVlQMDMzeVVId0k4SUtmU1pYWWJVdlpWOE5tRVJ2VG4r?=
 =?utf-8?B?U1REUDNCbkVWRHdvNFVuWGlnMGJqR0dtY2pIVzhMa1Bxc0dTN3VzMmFoVUto?=
 =?utf-8?B?Vkk4dWR4WlFjSmdlUEI4VXZKYVh5V084clY2Z25BZDMvUUpwSEJuS2t0bUNp?=
 =?utf-8?B?ZlpYSEJORi9OUEN4Sjc3TmRTTTRHYmFIVkNkRXJVNDZOQStoRUpyOHJvSFdR?=
 =?utf-8?B?K3B4ZWZ0T2ZHQlZyNzJnVUQxZ2dJQzYrblFSUXJYVDVpb1ViZndtL3l1b1VE?=
 =?utf-8?B?NEhzWVZ5ZkladTNLTmt1cmFoUDFnQUJRN2xLaVZlamh3aUIxVnFaSkJlMjJD?=
 =?utf-8?B?bUt4Znc3dUNWeGZFd3FwKy9NcC85b21YNGRHbDdncEdBRUtnaUNjV2hFblZU?=
 =?utf-8?B?aHlRd0dGR3p1elVNQkhISlAzckJrSzNQWS9FazlSVm5idjY2RGM3L3BDYkI3?=
 =?utf-8?B?Q3hKSjdiRTVTSVFtNWtWek1ITjJNNzAxYSsxTDFzV3RtVzY3T3pkeFJCNHQv?=
 =?utf-8?B?VGZneEFRS2taZ1FhbjdhWGlsdDZUL3l4VjJIY2ZPOUgyNHR1SXJUS3lqUkFE?=
 =?utf-8?B?R2ZKaG1rR3RoWklEVVVqUktRaklGWWJyWHFHSkRra1NlWU5pdnlTMUdlb1ZG?=
 =?utf-8?B?dVhLdmJZaWdpLzFGYllKa3laS3pWK2NIaExsTEVsT0NBY1pDRTRFS3dWQnh5?=
 =?utf-8?B?aFA5YVBTRXArN1FUekZkZEdzZnpVbXhnenhWWkxZN0dFVHQ3eFpsMVp1THBE?=
 =?utf-8?B?OTZjUG0yS1MzeUtpZmpZb2kyUkpnUEc4d2lOQi85djNyTU5icW9UcnhDNDRy?=
 =?utf-8?B?QjEvY3l4cGlNczREeGYyS3ROcXd5dHhpQVc0MEg5TDREbS8yQ1lpSloyY2NC?=
 =?utf-8?B?TW9aS043MkFXbWZOZUM3NWoxd1I4ZENoVzdWeGppaGF3S2F2YVNHR015M3kr?=
 =?utf-8?B?MG0zYWk3bGJGTE1vR2UrK1NRN0k1cGFUdUNpZytHNTlIdG1JTUVDTS9IdkpG?=
 =?utf-8?B?R09NZVgwaVdXekUwekoySWJtVjRhaVlVUEhQNUFPQjVVZHA4MGVKTU85Zk41?=
 =?utf-8?B?THMzdU9jNVZxZ0szZTVwd1pneDY0RkhFSU9zd0l1SUNJOGtqc2kyOEVxSER6?=
 =?utf-8?B?Zlc2QXhWS0s0ajV3UGFrVzVyQkticUFlc1gxWEt1VHNlRTlLdWFYUllUcVdn?=
 =?utf-8?B?M1FmR3hGSmFZL04xQTBQKytaUzQwcHZlYWRuWkJDQTlHbi9LOGtqV0FEQXpX?=
 =?utf-8?B?cC9ZMk53dy9wYnpQbEEzY0NSMXZMRjUvYzJ0WnF3MWtLWXN6ZXdZbURWU3BH?=
 =?utf-8?B?QlZzQnBoSWZlbVR0K0d1blZNaFlnYXd5b2M0NE9MMlUvYk5NTk5mcnV5SnZB?=
 =?utf-8?B?Q05TZnd1SWI3QnY3eXlHV1Zma1o3NlhDVXZHMXBsTTRjem5SdUFrWGQwWFl0?=
 =?utf-8?B?cmo5dFBRY2YxSEt5TjZ5VXlPTnNwRHpXVjJkdGsycGJiS0FkZEp6aXMrTWdR?=
 =?utf-8?B?OXFFRlJjUUwvQmMvbjR6L0hYckkvZG1vUVhZWHEvRVZvcTRvbjBYRmVjQlNO?=
 =?utf-8?B?OWxtUExQZ1FCaE9XSjU3MThYZnZjMGE0cFoyVm4rV3Zyb0lEWjVIcG9jcWZG?=
 =?utf-8?B?WUhVQXdKanhDOGFybmxkYmQ5NjZzaFd5OWtUMVN1RFNNOXpDVUVMa1k2K3Vp?=
 =?utf-8?B?a3d0Nzhkc09wZ1JzdDlzN0EwWVBQQjUxanFSTE9OOWFzVG94ekhJVUJPc29W?=
 =?utf-8?B?c1lhMURZamgrdVc3K2IraGw5VFJ4TGxKeTlZaGE4eHRzNCtYSTUxUmU0V1hD?=
 =?utf-8?B?TzI3QjVJTU9TMW9rbWVOY2kyZmVSVEJid01WbldZZWg5VGovQml0cERlOWYx?=
 =?utf-8?B?YlZxRGJyK0hwZ3BhYUd5YnBKbjFqdTBvN1kzOTBSWEt6YXRHcHVYQzNadlh4?=
 =?utf-8?B?bHF4K1VSV21EbTZXVU9KWUVGaEhMcHZNYk1ETWtCaHNnVTh3Qm5WcFc0SFRs?=
 =?utf-8?B?OU55dldzWkZ3Y2tqS1RPSlI4Qy9udGtNSi9sTklzQmJPb28rTHY5QmFqOXZw?=
 =?utf-8?B?VFV6RkdQWmVyNVJBWTdxbVMxT2RmdWFQOFU3aXJ0N0g0N293L2hOa3gvRVRz?=
 =?utf-8?Q?AQeE=3D?=
X-OriginatorOrg: cs.wisc.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 08603552-0ee9-4c2a-f2ca-08dd7baedec8
X-MS-Exchange-CrossTenant-AuthSource: DS7PR06MB6808.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 23:48:35.5984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2ca68321-0eda-4908-88b2-424a8cb4b0f9
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yUWqr35tnbjAh8F5r3mxMZQMg58AQzrv9HdPiQIKLpyP5tl6vFzkjPTNlN1LOjSU6ffhwCcFEST5EZKSpGpudg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR06MB7294
X-Proofpoint-ORIG-GUID: ewTnSW5dxnnFv0ozcns24A0VYd4BAO6-
X-Authority-Analysis: v=2.4 cv=CM4qXQrD c=1 sm=1 tr=0 ts=67fd9f07 cx=c_pps a=iOysuCQqHAn0ffzU2nlaNQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=XR8D0OoHHMoA:10 a=3-xYBkHg-QkA:10 a=ihY5QncMIhvdpeLoW5EA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: ewTnSW5dxnnFv0ozcns24A0VYd4BAO6-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-14_08,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 spamscore=0 bulkscore=0 mlxscore=0 priorityscore=1501 adultscore=0
 mlxlogscore=685 malwarescore=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504140172

>>> I think it might be good to add a field to the tracepoints to indicate
>>> whether it's in user space or not.  
>>
>> seems highly superior to having two sets of tracepoints and static keys.
> 
> I agree.

I'll implement this and delete the extra stuff then.

Thanks,
Junxuan
