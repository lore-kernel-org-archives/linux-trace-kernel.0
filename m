Received: from mx0a-007b0c01.pphosted.com (mx0a-007b0c01.pphosted.com [205.220.165.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A76820010A;
	Tue, 15 Apr 2025 01:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744680228; cv=fail; b=ibi8jovL0gyoxO1mxeQkvmpBFhJlylPM5gO57MTFEYW0JMIH4vF2HejUoH8wzOjMYriS4VGRUgz/GIWPBtLPBcGiYEFhtDHTZdRnrXd8b/qBEwBX54cZnE4nBbpkz6jhwKd5SfAxRzGwyQhCAE8aNDtnUjd7jx1BuwmpBOefr04=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744680228; c=relaxed/simple;
	bh=RNBCFCJLcVX58hpeetOz6AMwsClnELTHwqFTvB9rhsw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ato/Hnma0H3EjAnf2/va8dF9S0PjSekMYjL2Pzo1EN0sq6+i1FZv3UPjD+gEy8CFEwzm1gDdBXMszEpYPIKi0fgYTSUXWy2HddthOBYfD+UCgFFdpFPfWRZfomuHynWqZNYF6O/iUf7L9iTuizMv+Q+2Jc5n+JE7MMfqCLyLVCQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.wisc.edu; spf=pass smtp.mailfrom=cs.wisc.edu; dkim=pass (2048-bit key) header.d=cs.wisc.edu header.i=@cs.wisc.edu header.b=qhxWnFo8; arc=fail smtp.client-ip=205.220.165.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.wisc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.wisc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.wisc.edu header.i=@cs.wisc.edu header.b="qhxWnFo8"
Received: from pps.filterd (m0316039.ppops.net [127.0.0.1])
	by mx0a-007b0c01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53EIDBiJ013106;
	Mon, 14 Apr 2025 20:23:21 -0500
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2043.outbound.protection.outlook.com [104.47.73.43])
	by mx0a-007b0c01.pphosted.com (PPS) with ESMTPS id 460a96ueu8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Apr 2025 20:23:21 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lxZKh2C6BDwGSCPneEXS9YicAlEItu0MoXfP8xrrTvM9YSwKkNUb6p4ne2qGDIWfV/DFb07F9kmAt1Xht7CAvTu3qdx+2y4m3CeteMd2JNWHGEESSb9iafSZeiDT8y5mPxe3OsZKT6wU9pIjTL1D7FLxX5HkGQHuydyhvxLw545wvzt4AOKOqdCFTFBlvpOvZagxPmjMnd1b69wwUGSfOrRLWlwng+NoFkLGESn9ancE3++68ojHSGjyqbYau08SE3487nDQ6YVOgO0L9cNFvaLsQRUEFiO4lQF018qhTUOAcmv1Oy0fPudbTS0OHbb+q5Axu84Um1wbM4TYcw0wrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KT2MyHWhSKD4tH6UDPT2TIQ2KzLn3Ten0vU8qD/D0mc=;
 b=g4Eo/kzY9kpIQf+WXsS0iRgtWggtvahW8gH6B3vWg01+VUoL0p3tXp3MeG/bL7ddSxp5Ts+pzdeLWVM1vW0HSbBXHJqfDIppDU4ON0i3TEICsEtJ4HZXdsMPYmRfs0x4yNTC6pzXxlJBhroR/XYg8Gwmfi6UA//Y3wYWaDsMPCiXjKvlALMvkMUdGh/PkOmUG3K4jEqtTa+J+36bJ2ET2UKQ6yBlxEMFbj9KA6K1fdInfa7/W4bWgHGllQ2lYK0anEiAA/i1AkJ0AE4c3/MIH8eUvr3Htc2lEOu6Xu2qX7FJrnp77H2Fd3jhplCTUoAg9WHlhZ5IAUzdrgamfI8JdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cs.wisc.edu; dmarc=pass action=none header.from=cs.wisc.edu;
 dkim=pass header.d=cs.wisc.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cs.wisc.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KT2MyHWhSKD4tH6UDPT2TIQ2KzLn3Ten0vU8qD/D0mc=;
 b=qhxWnFo8F9n1dFA+/hUe3IaMwOBmtPA3so90eDfD6/neoldKxhZBhmlqjXBrck40j6MR3ysOL/M5J3q8kbUy4YKLPSXD4R/M6b4EUQag3EnvSbf48KSqIE5a+z75E91fALDDW26Ro+N5w9JSwlyz82GCrqT2QDijXlfomg6n8LwU/2VB23dAc1OQ0PUfF2GfeWVY9lgRm+4wFqWepQGHtnf4EYhB97l6dWsxw6Rx1S8STiMI/uTg+QPmyGyohs/aIyNg7WFdYU75ZruYmRABgXrJXU3cyHtV/s0UyipSF2wB6A5lwo+cbrTnI5C6YxOdgbmtLvNDQdhBoisaFuztqg==
Received: from DS7PR06MB6808.namprd06.prod.outlook.com (2603:10b6:5:2d2::10)
 by IA3PR06MB10404.namprd06.prod.outlook.com (2603:10b6:208:511::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Tue, 15 Apr
 2025 01:23:19 +0000
Received: from DS7PR06MB6808.namprd06.prod.outlook.com
 ([fe80::76b2:e1c8:9a15:7a1c]) by DS7PR06MB6808.namprd06.prod.outlook.com
 ([fe80::76b2:e1c8:9a15:7a1c%5]) with mapi id 15.20.8632.030; Tue, 15 Apr 2025
 01:23:19 +0000
Message-ID: <ce3acc00-6332-45b6-890d-d215488d8c46@cs.wisc.edu>
Date: Mon, 14 Apr 2025 20:23:17 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/tracing: introduce enter/exit tracepoint pairs for
 page faults
To: Steven Rostedt <rostedt@goodmis.org>, Borislav Petkov <bp@alien8.de>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
References: <e7d4cd81-c0a5-446c-95d2-6142d660c15b@cs.wisc.edu>
 <20250414205441.GGZ_12Eew18bGcPTG0@fat_crate.local>
 <20250414182050.213480aa@gandalf.local.home>
Content-Language: en-US
From: Junxuan Liao <ljx@cs.wisc.edu>
In-Reply-To: <20250414182050.213480aa@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR07CA0025.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::35) To DS7PR06MB6808.namprd06.prod.outlook.com
 (2603:10b6:5:2d2::10)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR06MB6808:EE_|IA3PR06MB10404:EE_
X-MS-Office365-Filtering-Correlation-Id: 55e6b441-b3de-486b-9c23-08dd7bbc1ad2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|41320700013|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?amdOSlhxajV4bDR4R2ptVElqaGlKSkd0TWluMDArWHZoQ2dyeWI5bmUvY0xP?=
 =?utf-8?B?dUtDak5YUWZaVG1VQzh1QjR4L2xwVFJPY2k5ajkzV1gyOUNYY2lncjZRYm1i?=
 =?utf-8?B?SGhuY3plcDcvR2FHWEFVclZmSmZENkRBQVNsOHlhZXlPajFZZ25QQVd0MG5t?=
 =?utf-8?B?aDQ5enZ5NWp4SFA2SkpHQnNrdWs3QkMxeHhBbVBJUzAzTEI4RlpiQ3UwVDZp?=
 =?utf-8?B?NFlxd0NENXZ1MSttZ3EySkgzYjl3WE5oZnJWSFlNTEtldnZaTzlXRDN0V0kw?=
 =?utf-8?B?eEFLK1VWdDJWditFSlk3aFNMNy80K3FJSmRpN0J3ditVYm9ySCtsOHV3bi91?=
 =?utf-8?B?NkRGZEVMWTVEUG1pNnRpcTh3VEpmY0lDTWhkSTJjaDhrZmVKOHFZZVFzZ1Zl?=
 =?utf-8?B?RnRhaytsRGF1bTBNdGpSUWpVNEZLd1BRZlBoSzQ1b0lTajNaOXBZYW9idVRM?=
 =?utf-8?B?cUE3TkZybWtSOHh5ZU5iSkhhS0dpU0kwQ043aUozZHVzNEhORVlnUEhMZEtY?=
 =?utf-8?B?VnVCcmJZZnBXM0J1NE82YWhvQ2FyQ3RQSmgralR4cTBZRlYzVXhVUE40ZVhk?=
 =?utf-8?B?T1FPdEplNytseDFoemQ1TUJtYUowREY2RWtzSWVvNVRhck9IdVhaMkhGUEsx?=
 =?utf-8?B?ZWk2Rm5ud1JQbFdDNEJDUHdYUnB1dmY1YzJ1WVpiYVVFZWdMTmFpU1gvbnFm?=
 =?utf-8?B?ZW1VRmMxMDhaa092bWJuUW92a2pKeld0OUpsOTU5cGNUTWdQR01lZGs2MjFU?=
 =?utf-8?B?Mklia3ZwTnV6bG1nTkhSTTN1ZkNmQkNYdjdUaW9BVlFLZUVNTnovelkzSnRN?=
 =?utf-8?B?VDJvbk9jckYveFZ6NStpRVp5eXFVWGtYczBTQVBrMDNQb3loVzhLelJ1VlZy?=
 =?utf-8?B?dFdoeXZUQWdkOHRIb0ZRamZYTE9BNW4zSWtmRlFhMkJLYUtQMnQxL1pwS2FL?=
 =?utf-8?B?U29Vd0V6aEdkbnBOMTBZbDZGTWtsOEN0N0FCb1grWE12VXRuR0ZQRzQrbTBI?=
 =?utf-8?B?a0J5bkFBOWxseG1VSmVvSi82UHF0S256cnlTVFVMVFdLVzJtd3RvMEJXL0Nk?=
 =?utf-8?B?ei9NS2J6LytBcWtsY3k2bHdDaHNyeGNPM0xxamRERnAzVEhlVFJrUDVGaWpK?=
 =?utf-8?B?Ny9Ueko1QXNJYVhOcURCTjZ5VDMwemJxU3FyQ0d1TU5LdlU0R3lWVEdTcHp3?=
 =?utf-8?B?U21iQzZKSHNJWnBFdUZnaENZaThtdW5SU3o3NGRKNmVrWVc0S2VtQ05Rb0JX?=
 =?utf-8?B?dzk2T0xIOXFGeTVSMDhHM1QzR0ZIZ2NQK0llN1Y2dWNhZ1cxbk8waitnc1pu?=
 =?utf-8?B?NFpSVXdENFBPRDZNbG1SRDN2YkM4WHg1WmpPZWdZQnpwNW91L1FWa1RlRFh5?=
 =?utf-8?B?T3JQUFJjNFhLaHdDSkdRQVJaU1NkWnRDMWo4Wm9vSEpWRFB2QjFDMVpNODFv?=
 =?utf-8?B?dUpDRmRDWlMxbjFUVk1TREtaZzlqSloranpvWndOblJsTFQ4SWdwR3lKcHNJ?=
 =?utf-8?B?V1l0bk1vSlhjVHpwMkFrTXlQZE1Eak9XRy9pL0ZkV3ZiNlpSeVNsUm4wMlZ6?=
 =?utf-8?B?SXMvaDJEaUg1OUMxOTNudkN1T0l3dHp6eEJKUXJGaEJFOGxUUlhxYzhmRzNC?=
 =?utf-8?B?VGZzcGlOb240b0I4RW91OFg5eU51dDlMUEtlS3hteXJKYXBjWVoxNXRYc3Aw?=
 =?utf-8?B?ejBIaXZuaW9jOUI2Nm42UjhxZktVbjZ0NlBua3IrSGpoQlBjYm4vOEkycXBN?=
 =?utf-8?B?bDRXU1dndnpWVTU1eHZ1dkx1WkJLTGhwclpJWnQzYnJiYVZ4OWxuOGR4MDNx?=
 =?utf-8?B?WHl4NXU1cGJ5Q0EwZCttWVdYY2Z0SnZrL29IcEVpbFJQcjM4eStPbmFvNlVC?=
 =?utf-8?B?ZjRrM2ZBT2ZRQVJLNkYzWEV1Wk1oTUZ2b01oQ3JzTWhkU1E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR06MB6808.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(41320700013)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y3lxV0NXTm5xVHdkeWlGYkxoTEVpbUI0bldpT1duN3pwSW42QnpXTnlvcVNC?=
 =?utf-8?B?Sm4vb1gvTGJ6bW02aDZwYjBReVRDYXkxamp5TEhEZHZFVmZZNC9yaTFVa2pw?=
 =?utf-8?B?UERJdUZDcVNzUXZPazE5eVlRVFlCYnR0RDF4eTdwL25WV21wMGNBMnRoRXIw?=
 =?utf-8?B?NGQ5ZHVDcUM2d3JFenhDWDU2aG8wRXZ1UzRDaDRLa3RqSDN1VFduOGU1N3FW?=
 =?utf-8?B?WHEzbEZ6eU80TXpmMS91VmJMU2tZbEVDdVJIdjRqWDcraFVTSGpNQ0p3RXBI?=
 =?utf-8?B?UUpPMTMyTTY3N1diRFV0TVhuYzVEa09QMUh3ZEJDY0MwREZxY1NtejRaUDR2?=
 =?utf-8?B?S2xpUi9BQjNodUh2dWlxckJCY0pvMUplTDNsQ1l4ZGVnRE5pRHRKSm5lRkVV?=
 =?utf-8?B?dnAxUmU1Yk96QlZsam5BOW5lOHFLTW9WbXBLeklRZC8xNGNOOHM3cVRGNnYw?=
 =?utf-8?B?UmhGaFFuZEw1S0Y4VXFpVWg2ZUxpWittdlc0YkhRYTNLYm9tLzhZQ1NxYlZv?=
 =?utf-8?B?L0tPUzJPWklrOUt2NDRtR0NPdjlwQWRPTEFKUEtZcU95YkdUeTFKOGZNOTVD?=
 =?utf-8?B?R0dEMXErWm8zZVpUNTBSbDFFV3o3NjR0b25Jb1N5VXMwcmhReGVJZjU4MUdi?=
 =?utf-8?B?aCswVlpKS2ZOZExFTE5wNStMQUNTRjZzQk1qL2JPR3dkZ2xQN2F3RFg5ZFQ2?=
 =?utf-8?B?ODVWbXV2bGYyWjY3dStpN2hxekF2UjNEZG1mNmExNXFnbUpIcnZZVERmTVFx?=
 =?utf-8?B?MndYdHlURjlYdC85QldEd3lvbkFqaXJxSGZWYUUyby9mZTVjeGQyWFRQODI1?=
 =?utf-8?B?RHdobngrUWVKWDJGK0x3ZlY1UjBSc2tDOTdrOTlJUnFQZC9Ra3VPZXhwUDR2?=
 =?utf-8?B?c1ljVklFN3VMRXF5cDN4bWxaeFZVQU5jUlVxYVMwSFlXWm51c0FBanUyMGpy?=
 =?utf-8?B?THNPVUJnRUNST1JkMkNOYzlFcXVpaCt2Ui80aUhLYTNiSGp6VFV3QjJZMGxS?=
 =?utf-8?B?SEZya2NCaFllNzNvYmtWUWpOejUxUE9WT1BJbkh0cndRRGpXTklDS3FwUEVM?=
 =?utf-8?B?dmo0UGpQR2E2VFRNNFN1VTF5RnUwRUxsaC9aWWtsaSszVDZQdmNCZ2JhaTNI?=
 =?utf-8?B?MDhHK3lNeWNEZlczT0dEaTVHQjRpZXhhRXJiZEM3NHJXd1ZJaC9nelNjRTdM?=
 =?utf-8?B?Mk9pSFBjNkdxM3JsNGpGSmJJcmIxWHdPNDhuVG5jOGZLc0U5OWFtSG8ybEUy?=
 =?utf-8?B?QTJtUExpQm5ZWXVFUWsvRkI4RzVLNnFxM1c0SGM0VkNZV3ZQSnUwbjZSaXJH?=
 =?utf-8?B?cU9kTCt0aHhSb1ZDM1ljSGNIVmV4YmJtWW5zRlp5VDhQUGUrR0dRUHRVdE5W?=
 =?utf-8?B?dlc4OEdENjJYT1ZYRHMvMFF1czRYeXRYL0wxakdLLy90cTVtMnYxTG1aNEhO?=
 =?utf-8?B?VlJpTkFnTTZnUDJISW1nY3FBdER1NUdqZUxGaDc5UjA5TGZiZGxraGxiSm5z?=
 =?utf-8?B?NVRvRDlicW85Um9YVEJkNlJYSnB6UUF1aC8xUmpwZGtKOS9GYkUvcXRja09a?=
 =?utf-8?B?eEpGRFM5Tm55U2lISTZMcG1ZRUlmdDRkb1NhbzFuWTRueGh4SGx1RHkzNlFC?=
 =?utf-8?B?aHNLa3pZYlJPQkdLcWt2bnVFV1ZqMEFFWGVwNXpXK0h5dWRXVVl4ZXd4OUlH?=
 =?utf-8?B?dFpPcUgraFdmaE9GeDh1NktWUU54eXlnWHB3OHlvYXVaVXowdjVXSXhkTzc0?=
 =?utf-8?B?bVp6RTFyZ2g0N1ArTk9zSE1nOTduUHJLOFNBZStEaFFKR2JEZXNZTlNYb0RQ?=
 =?utf-8?B?OERmak94TnZXbXdYLzZmVzM2SzErb1FVbUJ2NDBwbFpZbDU4Qk1sc0RQN0Y3?=
 =?utf-8?B?TUtjblVVVVB6aW41ZlYwd3NkSExidnVUZkFaK0hnZmNObmRZdmxSWnZzRWN5?=
 =?utf-8?B?dHdQRTlueHpHbkFXS3ljakg0dGlHZ1VFRkJYK1Z6U3c3bzVjL25oY2dLSE5H?=
 =?utf-8?B?ZVB0V1d1TUhKZ3pDWkZObm5CVUlXRzVSb3ZKekhleVkxaUhJNGJ1R1FxZ1h5?=
 =?utf-8?B?QmNJNlNVcnRxOTczdG9ZWlhKUmFqeEJQMG5QQ0dEWTB1M2JweTBVRmFYMDFU?=
 =?utf-8?Q?hjsM=3D?=
X-OriginatorOrg: cs.wisc.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 55e6b441-b3de-486b-9c23-08dd7bbc1ad2
X-MS-Exchange-CrossTenant-AuthSource: DS7PR06MB6808.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 01:23:19.6492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2ca68321-0eda-4908-88b2-424a8cb4b0f9
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M4GAL+sz8aLN5SZ94YH7wwlnrw04FrpGoGgAV4+TjnOdY2kCAoPbhTGI4rz1FDXxEA8u9S3lYsDyHc6HzNaBzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR06MB10404
X-Proofpoint-ORIG-GUID: aBwjXTkxGvtc0k2L-e4Z6euNpp_daSOa
X-Authority-Analysis: v=2.4 cv=CM4qXQrD c=1 sm=1 tr=0 ts=67fdb509 cx=c_pps a=YmitjTGdGiwdiEq1Q8pHfg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=XR8D0OoHHMoA:10 a=3-xYBkHg-QkA:10 a=WEzg3AYU7VnzdkWqtLAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: aBwjXTkxGvtc0k2L-e4Z6euNpp_daSOa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-15_01,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 spamscore=0 bulkscore=0 mlxscore=0 priorityscore=1501 adultscore=0
 mlxlogscore=558 malwarescore=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504150005

On 4/14/25 5:20 PM, Steven Rostedt wrote:
> It's useful for me ;-)
> The above shows a histogram in microseconds where the buckets increase in a
> power of two. The biggest bucket is between 2^4 (16) and 2^5 (32) microseconds
> with 108790 hits.

With patch v2, I can do something similar in bpftrace too. :)

tracepoint:exceptions:page_fault_enter
/ args.user_mode == true /
{
    @start[tid] = nsecs;
}

tracepoint:exceptions:page_fault_exit
/ args.user_mode == true /
{
    @lat[tid] = hist(nsecs - @start[tid]);
}

Junxuan
