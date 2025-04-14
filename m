Received: from mx0b-007b0c01.pphosted.com (mx0b-007b0c01.pphosted.com [205.220.177.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD3018E20;
	Mon, 14 Apr 2025 20:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744662994; cv=fail; b=Ya/QZeWhO+LGalexKAZUkUD/O68Cqinh5Ojqwei84w8MMZEiGrGQFz3OlIJuWBhofhjbUD2isCmz3PT2zaTiTis+g+ePZeZKXOCHWBl/8IF92+ZY0DLACFj/TMGvJelX7sjfSwPPkkRXbs0s8SiTNFSixstJdulkrran3Dk7gro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744662994; c=relaxed/simple;
	bh=v4xh7eDsEMC4aIX9XC9xr7b1tsZt+JcT3o+Qxgk+9YA=;
	h=Message-ID:Date:From:Subject:To:Cc:Content-Type:MIME-Version; b=o9Or3m/gfz4QDfsG/SYbabjTD4AIgubTfDxmgr1q1MbYU+9DktMeAcGgrUg11MoghHH8cnKdCF3Sp1MVGdXys51xwJNSRFNjdTyqef9BRlwtfjwbTVNSvRdeuRDFhj+9AVIjZWZKCVOD00cP3sdQA6bzXjzu1eknt5uxS9WJwAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.wisc.edu; spf=pass smtp.mailfrom=cs.wisc.edu; dkim=pass (2048-bit key) header.d=cs.wisc.edu header.i=@cs.wisc.edu header.b=GfDdW0be; arc=fail smtp.client-ip=205.220.177.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.wisc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.wisc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.wisc.edu header.i=@cs.wisc.edu header.b="GfDdW0be"
Received: from pps.filterd (m0316046.ppops.net [127.0.0.1])
	by mx0b-007b0c01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53EIqMKY028844;
	Mon, 14 Apr 2025 15:35:45 -0500
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2047.outbound.protection.outlook.com [104.47.57.47])
	by mx0b-007b0c01.pphosted.com (PPS) with ESMTPS id 4608n31tmp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Apr 2025 15:35:44 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tIX3QZVP3c33eYxh4hklGbW0ulGpzHqLQwD0c4IGXQPZ1+t1XAXxvkGs6L6qUwbgEfa2vqEW7qj0Uf+diiyl6a9zkyDGsYWitpmV3JqaFnkn7q48OyTdS3z8TCxEDqBtXNxDPj8qlelTr7xuR2yWdoVTuM+GcpDlRNXLwyb3k/jISxQQkVw2qkTzR3AHhHTy6CdUjEQGVxM5lO5pQbx9QZ4oEt+8W9cVPEa/Ur17VRfzQwoJq7UQAmmZCXm72TEuRDR4/3jUZ7Zjuz72X/JQSnLvkx/YNjiqtGUMQr6hYEwBw4zqwauFEbsSl9uNPT3ES1CkPwFwCNiua+JOxGZipA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nBBheZoW40t854ecFlKtBQXGV0NOwLBJrwQ4EkrYMpM=;
 b=I7SC3SQevQWl7bwyO8aU2dlYdUNkXcot0OwI2bR98ddP0URLtRiV2d/pHC19k/Fgjl82ZphUfH2dODWuq2nAAHDz0ijIozZ4TOnOaboyPPh6W16BfXmhr2kORCBpjXLk5DXsGWcWCOrYB1crmgVpuv4FGFMB6TNHlYZT4ZUiBvuH/nCyszTN7sD2v2beMxjAgpS33I4CyTVkhfIO7D4T11oxYp5S2oHs5uU8SZzCmiRSsH178KtcewUkyjwIzCY+KBQpoYzU/Wyjbia/khK9W1yzw4z24UYv48P9UFTtAZjcWeQgtZEnDSeM359MyY9RzonRNUkYJmQr8FqpJ1hUtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cs.wisc.edu; dmarc=pass action=none header.from=cs.wisc.edu;
 dkim=pass header.d=cs.wisc.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cs.wisc.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nBBheZoW40t854ecFlKtBQXGV0NOwLBJrwQ4EkrYMpM=;
 b=GfDdW0beSAHef2WHDkYFZjd1ciw/wJEusGpiFYRVA7oAJEtPcxO42E5HF9FLYjKtNBYq7xH/w21N65Vvsavb8vDHb5/10kh98jVdtsrYdbRG4pUAacyqtnbMJtmsO6T8DnRLwWkjiGL9J9MGLTBzw03Yt0zrcZjf482tkYMQukWXRyBezUR41K04imbqzUiLLc6PjN/Fs7azBXQhm64gmaLY/IaK6OgUu4Sl736jh2CfwVQ1is+XzqjD2il0oEftyIRiGWNd9brhGqPhJgqx2bC4wL0Wbm98bXWmYcEbnbSgYppLKpx+ZmmMULsw7f6CZY3pzOvOPMXTgdM9NcJ8dA==
Received: from DS7PR06MB6808.namprd06.prod.outlook.com (2603:10b6:5:2d2::10)
 by DM8PR06MB7815.namprd06.prod.outlook.com (2603:10b6:8:37::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Mon, 14 Apr
 2025 20:35:43 +0000
Received: from DS7PR06MB6808.namprd06.prod.outlook.com
 ([fe80::76b2:e1c8:9a15:7a1c]) by DS7PR06MB6808.namprd06.prod.outlook.com
 ([fe80::76b2:e1c8:9a15:7a1c%5]) with mapi id 15.20.8632.030; Mon, 14 Apr 2025
 20:35:43 +0000
Message-ID: <e7d4cd81-c0a5-446c-95d2-6142d660c15b@cs.wisc.edu>
Date: Mon, 14 Apr 2025 15:35:41 -0500
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Junxuan Liao <ljx@cs.wisc.edu>
Subject: [PATCH] x86/tracing: introduce enter/exit tracepoint pairs for page
 faults
To: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0187.namprd13.prod.outlook.com
 (2603:10b6:208:2be::12) To DS7PR06MB6808.namprd06.prod.outlook.com
 (2603:10b6:5:2d2::10)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR06MB6808:EE_|DM8PR06MB7815:EE_
X-MS-Office365-Filtering-Correlation-Id: f84048de-9307-430c-3d05-08dd7b93ed64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|41320700013|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?elZ1SmdtbDM1RVVhNlI5bXZGTTRxdjVGbEx3U1hQbUdCdk9ldW5ZNnBVMTJl?=
 =?utf-8?B?cUM2Mkc2c1ArY2xnS3VxSGVaTW5nY0hwc3E2ZXpTdnZrZldhQTRCVW15MUdz?=
 =?utf-8?B?Rkk1VGRJME5UeEhLdXRMTStpSnhwRHZkcEozdDA0VGtOWk0waGZFUjVuM2w1?=
 =?utf-8?B?WUZJa0taZVcxakZnbytjdkJ0NFk1dVc2bFd0L3Y0VWF0eVc1eVZjTllqL3M0?=
 =?utf-8?B?eWZzZ1lkOVU3bHMyQmVpeXJ0MVhyN0NZYUVTeTU3d2dRTHpGUENFL0NtYVh1?=
 =?utf-8?B?dFZsUEROQ1p6QUFHYTVXYTJGYVdMWjd3S25yam9vbjJnQnlGNXQwMzRxZE5i?=
 =?utf-8?B?cHcrcWRDWmRvMXZTOElLaXRaQ2RLcmRzRlhsSHVKUm95dE1pT1RIejhrbUsv?=
 =?utf-8?B?ZW01WXRwbjNKS05xRkJPcytjZDRSQWFMdGVISkZlUlNhMzY3L09xNXA4czlx?=
 =?utf-8?B?clNEWERoSDhGU0JjM3VFWG9uRVpJYVk0b21yby9UZ0hnWC93clJQMmVFTjdy?=
 =?utf-8?B?TStEbi9LcEhhVzRuS3N5bHN4RGIwUjFXcng4b0pqT3hJTUgvNGdPcEdkWW5w?=
 =?utf-8?B?dHh2akZ1amxVOURnRzBmcE1YYndYcGlrZWtMRGdzSEpnV1BlejZLZmdlUTM2?=
 =?utf-8?B?U3ZxMG03OG14Q3R3czJwYjV0aExsYWVxaTBiclVycmw5MlV0YkRjTXNuUFRi?=
 =?utf-8?B?a1NJZVUzeUJERUtSZTVWdTBoWHpmd1pBVDBkOGtwMXdFZ1c5R3l5QjFxbEZP?=
 =?utf-8?B?UmxhaDRhZ050Y21CS0kxS3FGRmlVYk9PbG90VjQybXc0TlE2RjFnSnpQRVBx?=
 =?utf-8?B?V2ZNS093ZlQ2bCtDL21EblJ5VFYzMzZYL3VxSTM1TE0wc2FPZXN5WmUvdTFk?=
 =?utf-8?B?YkNVUDE2b1RUMlNKb2xnWHJ1MmxMODhYLzRHS0FaYVU3eDk0OFVoNWkza0ty?=
 =?utf-8?B?L3BtL29MbW44TEEvbFNmWHd0Q2dENWp1THNOL2IwRHZLeXFndzdKaUlUcGdU?=
 =?utf-8?B?cTc0cjlrQlA0RlY1Zmp6Ti9RQTlpWUczY3dOa2xUaUtjOUhHWkZjUzN0UVNF?=
 =?utf-8?B?ek9MZmpCZ3dEZ2xEZmNsZ1RQQS92Q01Qc1IrdmlwdVFZTWlXek82d3ltT2FY?=
 =?utf-8?B?T1RweWw0OTVOVHJtZERPWWRSNjVKYmhzTEd6QkVBS0pNWnVtTkU1ZWN0VFMv?=
 =?utf-8?B?NGRibGwrNisyUm5ZY3FFYTBOU3JHK0NLRVdIVko2ZUpSM2JYNW5wK3AwQ09r?=
 =?utf-8?B?WEJjKzFsMkovRTdMak11YWljVUhKMFF4ejdta2trVWViTHhWTUEzTnhlSFY5?=
 =?utf-8?B?YXdmdEtETlRRMnpmN29KVGp3SDJTaFRmZWFPOGtGOUVqbzUydDRCNWl1VWNs?=
 =?utf-8?B?VUtpMjY0ejFONU41WW5BMUcyTFFkYzhjMGV6VUJJUWVsYVIxVEFGK2dqQXQr?=
 =?utf-8?B?ZnJndjBIVlZRQjJIbmdEUUxIbmJ4VjRzaFNDLyt6ZWQ4T0ZpT0tTcWgvUUxV?=
 =?utf-8?B?ZGhjK3NjQVRjbzJRUUlmNC81NnN4QnRMSXNTL0tMQW4weEVpN09BSDV2cWYr?=
 =?utf-8?B?bEZweEU4czBOUGJ1ZkZuUnVmYkpqS3FsQTdxbGVMbmpZMk5TL0tFNnlFMVdM?=
 =?utf-8?B?TGRsWjZ1L0o4Mktab3lCOFo5Q2dZMllOeE0ybk0zUTJMRGpUUk5FUWZ1S0Vy?=
 =?utf-8?B?QW0xQlU3MmlibmRqUGNzTlVJK0dPVnlBV1VJM29EUWpjOCt3K216bWVnOHk0?=
 =?utf-8?B?VVlNSmd5ZHVNa04rRUtQTUkvNEl0cU1wN0x1dzYyL0MwMENRKzc3SDNlQ1lr?=
 =?utf-8?B?NTArWHJvdmFCN2YzNW0wTEs1ZHpzMmZtcEFqRVNIa0xCUFV0cHMydjI4cTlu?=
 =?utf-8?B?clFCR2MrdDc1ZmdrcWt2Z0dOZ2tLakhzUVVPNXY3ajFYV1R0TStiL1krWTBM?=
 =?utf-8?Q?MdTppuaiJeY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR06MB6808.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(41320700013)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dXc5dWZFcW9zQzVWMnEzVmVlZFhDeUNyNHJzZnNHeUt1OVBBSm83R0xiZGV0?=
 =?utf-8?B?VWVkRE9YT0x0QVZoWGtVVkF1Z09nR1NhMXNlUC9jVFcxT3dCRXpQdUpDTEp1?=
 =?utf-8?B?NmxsdlFxRmI3eUxERWdwSDhjSytVc05OZURsb1N3aDk5ZERzaGZPTUU5UlJn?=
 =?utf-8?B?QjllaTRNYnlNVFpYL3JKemZLQ3lCdDl1NFlzQ21mdjI0WnhBank4MEtNU3Vo?=
 =?utf-8?B?bmNxV2R0N1lrY1hZaFNMdGJHSjVtcU44aEdNOGNzdldSZWRKNjYxUkkreDJG?=
 =?utf-8?B?c3RSbVQzN2pDYTVJVlgzU1Z1NUt4NHQyWFlhaC9zM0ZQbXB3Q3BmeFROUXhS?=
 =?utf-8?B?R0FQWHB3MVlhc2JVL3lLWkhURUpobUtWRWp5dmFxQXN6clptSmhQVW9reFJ3?=
 =?utf-8?B?cDZkNXpsRGpsZytWK1ZJYVM4MVdSeUM0NWhUV2g2L1lkZ3Q3bHJZL0xudm02?=
 =?utf-8?B?Sk1Xa09pNW9nZXIyYkR4cEtWSDlPUU5XUU52SzZXK3hhTWJoR1phclB2eUgy?=
 =?utf-8?B?eWgrNk9nWGFBRWtndTlxMThISU5pMEdNeSsxME1BOVp6L0h5MHcycFVoNjRM?=
 =?utf-8?B?Mk5kTG40K0VRamhsZUhJUW1YTE9vRTd1MHlSOHdyQ280Vy9FMTNmNjJjM3hL?=
 =?utf-8?B?bTFjLzE1SzJOaVNDMmI0T2RHS2hVYjRLcXdadWczOUJUWU4xVDBsbWVDV1E0?=
 =?utf-8?B?Q1hwWWE3QkFOQ3MyY0FXUHViU1d6Y2VDeVZVZG1xVFVQVk92NWJUV3hRMFc5?=
 =?utf-8?B?ZDIxcmhUVU5YbVBqTU5DSnZWUGhEc21pSXJIUVAxUzZnd3l1cEtFNDQ2QXdN?=
 =?utf-8?B?UVB3RTVhaGtTRy9mb3paWWp0Q2owUHdkbU03R0FObjArN2NMeTVPNlV5VDNw?=
 =?utf-8?B?VVNwTWNxcURpbjNPOE03M0ZkenBKUHlvQ0Z3cTgxUTVFdHpHWnIzVy9FeTV4?=
 =?utf-8?B?SEI4bGJrTjdqeDM5S2I5c1IwSnhyT2JOMHlFOWwrREJFc0xBeWJWbjlqVVRq?=
 =?utf-8?B?K2xhSmFCaTdGakh1WG8vVGRYYTJEWmFacjhwVUtmTWJNNWNETndxOVNCdmFJ?=
 =?utf-8?B?bU1FSld1TmdDczd5MGpabTFPYzQ4OExjdnViMVdJZ0hOTWJMczgzWE0zUzls?=
 =?utf-8?B?NTlKWXRKTGV5THpCUTNqNWJzWmF3N1p4YWZSYnJ3SDVWUzV4aUdmMk1XWVRL?=
 =?utf-8?B?RElmbnF2MnIwWWhrQW54Wk0xNDFKT3dLV3VaZlVSeWljZjkvTkRnbWVydUNv?=
 =?utf-8?B?eGRPcG90Uys5ZE4yQS9IY1JzZkpJcWpKdEVITU5Dc1VDMXRtWG1VWk5icm1C?=
 =?utf-8?B?V3RsRnhJQWZTVDM4emFjL2tzWjhieldqZzZPR1JqQmc4emxpZE42cnhCQ2Y2?=
 =?utf-8?B?MEs0QTV0Tnp2Y3VaVXBqaGJ5SXBxdmE4RVVaNnFiSlo3a1JjdExIdDY3Q2Nx?=
 =?utf-8?B?bHRWVzRYZ2hvcjhaRDJqRmtxdXljNkp4Wkg4VEFZQnNTekptbWlzQVQ2YlFw?=
 =?utf-8?B?UmR6WVR5c1h1cXlaMFdrR21XR3pjWUttVk42R3UrMWFaTTB0Z0R6OHNVeC8r?=
 =?utf-8?B?Mmg4Z054bVVnaFZxdlhnakpEUVBSUkRtSkdxaTV2ZDBjd3Rod2FIVXJnOHJC?=
 =?utf-8?B?dGxvNzFjRVd5VUlQc0RZYWdpbVlWZ0xpd0J6dnRPNVVxZGlJbnFMWU05OFNR?=
 =?utf-8?B?a1h2V0E3NGdQUCtkVGlJdHFYY3VoREhxdkhzZXNmSEhZaEFZSndlV0pLckR6?=
 =?utf-8?B?VU04UFdnVGtyWFJWeENsdEZNN0s1MTVybnJnOU54SnlBZ2F0TlAzQjNQY2Nh?=
 =?utf-8?B?WDBzZlJvcVdCMHhIK29hY2g0Z1FqMDlIZ1drQk5LTmhjWlNhd2JiYm5SMzU2?=
 =?utf-8?B?VWwrTmx5OVZRWHdlMHBmY3Q2WWlTVVMxZ2NuTytMODh3TjBQODZtek12SDJ1?=
 =?utf-8?B?VDBpL1NqY1ljcW82ZDBFNWxlMzRDNzFlRGpRSzNYM0lOam10bXM3a1FhNGtK?=
 =?utf-8?B?SmYwM1dKd0pjMU4rMFhrVVhQeHlwWG4xNTVpcmJKcXdyUVk1YlFRUk1aNTZB?=
 =?utf-8?B?aTNVZS96bGRjZ1JqaUVHRW0zVHpEdm5EdnU2aHdSNDdEd3pEZ2xVcGQzd2pU?=
 =?utf-8?Q?P9o1XQQQShyiUgZHurBfEhAcH?=
X-OriginatorOrg: cs.wisc.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: f84048de-9307-430c-3d05-08dd7b93ed64
X-MS-Exchange-CrossTenant-AuthSource: DS7PR06MB6808.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 20:35:43.1210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2ca68321-0eda-4908-88b2-424a8cb4b0f9
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5r9kuL/Su0zPHg1l4lhMtAj+9txRmjsc4z0hMtGQr67X4NyW5lx7860uphkUGmkbrmMsuRXvVuPEHQF8WP3Y1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR06MB7815
X-Proofpoint-ORIG-GUID: jfqK44b7QBNiCMD8nFYtW1ja3J_edf25
X-Authority-Analysis: v=2.4 cv=R+MDGcRX c=1 sm=1 tr=0 ts=67fd71a1 cx=c_pps a=RoG0BMNHDmmKSZcrvsSD+g==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=XR8D0OoHHMoA:10 a=3-xYBkHg-QkA:10 a=VwQbUJbxAAAA:8 a=E2wWf0L7ji8XHI0cZFEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: jfqK44b7QBNiCMD8nFYtW1ja3J_edf25
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-14_07,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 spamscore=0 impostorscore=0 mlxscore=0 lowpriorityscore=0
 malwarescore=0 clxscore=1011 phishscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=699 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504140150

Rename page_fault_{user,kernel} to page_fault_{user,kernel}_enter, and
add the exit counterparts. This might be useful for measuring page fault
handling latencies.

The exit tracepoints use a separate static key.

Signed-off-by: Junxuan Liao <ljx@cs.wisc.edu>
Link: https://lore.kernel.org/9e2ac1e3-d07d-4f17-970e-6b7a5248a5bb@cs.wisc.edu
---
 arch/x86/include/asm/trace/common.h     | 18 ++++++++++----
 arch/x86/include/asm/trace/exceptions.h | 32 ++++++++++++++++++++-----
 arch/x86/kernel/tracepoint.c            | 22 +++++++++++++----
 arch/x86/mm/fault.c                     | 21 +++++++++++++---
 4 files changed, 75 insertions(+), 18 deletions(-)

diff --git a/arch/x86/include/asm/trace/common.h b/arch/x86/include/asm/trace/common.h
index f0f9bcdb74d9..4b289be75173 100644
--- a/arch/x86/include/asm/trace/common.h
+++ b/arch/x86/include/asm/trace/common.h
@@ -2,11 +2,21 @@
 #define _ASM_TRACE_COMMON_H
 
 #ifdef CONFIG_TRACING
-DECLARE_STATIC_KEY_FALSE(trace_pagefault_key);
-#define trace_pagefault_enabled()			\
-	static_branch_unlikely(&trace_pagefault_key)
+DECLARE_STATIC_KEY_FALSE(trace_pagefault_enter_key);
+DECLARE_STATIC_KEY_FALSE(trace_pagefault_exit_key);
+#define trace_pagefault_enter_enabled() \
+	static_branch_unlikely(&trace_pagefault_enter_key)
+#define trace_pagefault_exit_enabled() \
+	static_branch_unlikely(&trace_pagefault_exit_key)
 #else
-static inline bool trace_pagefault_enabled(void) { return false; }
+static inline bool trace_pagefault_enter_enabled(void)
+{
+	return false;
+}
+static inline bool trace_pagefault_exit_enabled(void)
+{
+	return false;
+}
 #endif
 
 #endif
diff --git a/arch/x86/include/asm/trace/exceptions.h b/arch/x86/include/asm/trace/exceptions.h
index 6b1e87194809..76729fcdb249 100644
--- a/arch/x86/include/asm/trace/exceptions.h
+++ b/arch/x86/include/asm/trace/exceptions.h
@@ -8,8 +8,10 @@
 #include <linux/tracepoint.h>
 #include <asm/trace/common.h>
 
-extern int trace_pagefault_reg(void);
-extern void trace_pagefault_unreg(void);
+extern int trace_pagefault_enter_reg(void);
+extern void trace_pagefault_enter_unreg(void);
+extern int trace_pagefault_exit_reg(void);
+extern void trace_pagefault_exit_unreg(void);
 
 DECLARE_EVENT_CLASS(x86_exceptions,
 
@@ -34,15 +36,33 @@ DECLARE_EVENT_CLASS(x86_exceptions,
 		  (void *)__entry->address, (void *)__entry->ip,
 		  __entry->error_code) );
 
-#define DEFINE_PAGE_FAULT_EVENT(name)				\
+#define DEFINE_PAGE_FAULT_EVENT(name, reg, unreg)		\
 DEFINE_EVENT_FN(x86_exceptions, name,				\
 	TP_PROTO(unsigned long address,	struct pt_regs *regs,	\
 		 unsigned long error_code),			\
 	TP_ARGS(address, regs, error_code),			\
-	trace_pagefault_reg, trace_pagefault_unreg);
+	reg, unreg)
 
-DEFINE_PAGE_FAULT_EVENT(page_fault_user);
-DEFINE_PAGE_FAULT_EVENT(page_fault_kernel);
+DEFINE_PAGE_FAULT_EVENT(
+	page_fault_user_enter,
+	trace_pagefault_enter_reg,
+	trace_pagefault_enter_unreg
+);
+DEFINE_PAGE_FAULT_EVENT(
+	page_fault_user_exit,
+	trace_pagefault_exit_reg,
+	trace_pagefault_exit_unreg
+);
+DEFINE_PAGE_FAULT_EVENT(
+	page_fault_kernel_enter,
+	trace_pagefault_enter_reg,
+	trace_pagefault_enter_unreg
+);
+DEFINE_PAGE_FAULT_EVENT(
+	page_fault_kernel_exit,
+	trace_pagefault_exit_reg,
+	trace_pagefault_exit_unreg
+);
 
 #undef TRACE_INCLUDE_PATH
 #undef TRACE_INCLUDE_FILE
diff --git a/arch/x86/kernel/tracepoint.c b/arch/x86/kernel/tracepoint.c
index 03ae1caaa878..108285046226 100644
--- a/arch/x86/kernel/tracepoint.c
+++ b/arch/x86/kernel/tracepoint.c
@@ -7,15 +7,27 @@
 
 #include <asm/trace/exceptions.h>
 
-DEFINE_STATIC_KEY_FALSE(trace_pagefault_key);
+DEFINE_STATIC_KEY_FALSE(trace_pagefault_enter_key);
+DEFINE_STATIC_KEY_FALSE(trace_pagefault_exit_key);
 
-int trace_pagefault_reg(void)
+int trace_pagefault_enter_reg(void)
 {
-	static_branch_inc(&trace_pagefault_key);
+	static_branch_inc(&trace_pagefault_enter_key);
 	return 0;
 }
 
-void trace_pagefault_unreg(void)
+void trace_pagefault_enter_unreg(void)
 {
-	static_branch_dec(&trace_pagefault_key);
+	static_branch_dec(&trace_pagefault_enter_key);
+}
+
+int trace_pagefault_exit_reg(void)
+{
+	static_branch_inc(&trace_pagefault_exit_key);
+	return 0;
+}
+
+void trace_pagefault_exit_unreg(void)
+{
+	static_branch_dec(&trace_pagefault_exit_key);
 }
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 296d294142c8..cd933edf1e19 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1455,13 +1455,26 @@ static __always_inline void
 trace_page_fault_entries(struct pt_regs *regs, unsigned long error_code,
 			 unsigned long address)
 {
-	if (!trace_pagefault_enabled())
+	if (!trace_pagefault_enter_enabled())
 		return;
 
 	if (user_mode(regs))
-		trace_page_fault_user(address, regs, error_code);
+		trace_page_fault_user_enter(address, regs, error_code);
 	else
-		trace_page_fault_kernel(address, regs, error_code);
+		trace_page_fault_kernel_enter(address, regs, error_code);
+}
+
+static __always_inline void
+trace_page_fault_exits(struct pt_regs *regs, unsigned long error_code,
+			 unsigned long address)
+{
+	if (!trace_pagefault_exit_enabled())
+		return;
+
+	if (user_mode(regs))
+		trace_page_fault_user_exit(address, regs, error_code);
+	else
+		trace_page_fault_kernel_exit(address, regs, error_code);
 }
 
 static __always_inline void
@@ -1487,6 +1500,8 @@ handle_page_fault(struct pt_regs *regs, unsigned long error_code,
 		 */
 		local_irq_disable();
 	}
+
+	trace_page_fault_exits(regs, error_code, address);
 }
 
 DEFINE_IDTENTRY_RAW_ERRORCODE(exc_page_fault)
-- 
2.48.1

