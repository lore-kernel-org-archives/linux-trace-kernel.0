Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11020140.outbound.protection.outlook.com [52.101.51.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68411F94C;
	Fri,  7 Mar 2025 03:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.51.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741316624; cv=fail; b=LPVtxzuQVcGTzZxd2jfN2J7QUihK3nn9/hBPosuX6db1draDTV0iVzU212XcpNeHLmp7ebhYPjhyN8Uo80d7jgUP1mq1XR0gBqnWNs+5F5cuMF3NpvTGTvcgi6JNgSPsK8SjjY8uosTC1plykUPmjl3aM+lMN5Tw8rwKxQi/ljw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741316624; c=relaxed/simple;
	bh=wdTWntxrF48jx+tIp+IEJs+XqcMREcoVqojlMUVJ1Vg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iL1p5CHJpmd516N9zeO7NEqSQiX8MkxiWzjXP+wVkhQiJ4AM15jyAIyVFPoA8eM8IL3eQqlkbIGK0RqXuLVs9rD5OSq0VYAv8gE7OayjHqeafeHlKSfVSa4cvtoU1H5Y2svcXzkmSeOHVT7GWsIfn+8bpnuLiGgaypRw+0S5aZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=guhbhtOT reason="key not found in DNS"; arc=fail smtp.client-ip=52.101.51.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="guhbhtOT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pv7dv4/Erx7EKGuG6n2HNOMFEQLMSigqqtI/qb7YpoOf0nrxPlhBzNtnvJ7K6Y4oKb9QHdxRPKyvV7dOi7T/NTk8kh4uP/gpt2aVLCyVerJ9jkjQKKcRod3VgtQhsE3SwbrUaZgtef4l5RU4g0x4i69pR4x6i4+PV8KpKjMm6O3JS5xmKNhxk72TfeyUm4ihFdyshSsMihNmT6oMyHYLOE7FqGQRqmYyFYYjYFVKeMZGTFHHMDjwiIYcVzh2pA2fkeFm9wqdTx3FSTQxjLx4P0hB5VY9+9KhFHPjbaLzz/NA8I4PVUZB1bcmH26UEEt3O5lCbpq04gnn9crvCCHQXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3wGWNRQ5NIhanUqMtHbsrkonTZjAdpDOquFVFtuKZys=;
 b=oQWNjKhC9WYGixWZHfH3QR4cFC45F392YlJzJcahY5PUy/6FFknz/K/nzWY7OcL66SxlLd1fC61JFivu2D1Nbg0LO0N4Osf3JBEu9Tvn7JTcdcEaW99oFJTRCe2Wh+8qCRV8gG2cpYEsHUyBFJR5lgtEkfW+pHd/We5GrNwBg3nojnCM5Au9xQcu2iv5f7WQRe+mVKjt6bqDJcKeglmZ1C5/Z64AK8vYDfbZcCl4/UuqatDcJlY3dnzaFm5kdPGxufJOqPL2PlHMvpy5j6O100N3lTcjb8tj7/VLkClXHAtsUCpMS/KLT5zN9TGPUHDLKUZTRiDWlLZnfDfwrK3Daw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3wGWNRQ5NIhanUqMtHbsrkonTZjAdpDOquFVFtuKZys=;
 b=guhbhtOT9zSzwYd76idIrA6SxI+96IfMrdUx5qEX7ipWwYFEUhLkaat+bEnCbeApMStfTl92NozDzvO+4EaNmp1erX27u430CWruc3ZvF62zAoh1RPJOb9RPzQ94ow5G3+To4AcjvTRwC0NGRgDPUbl56AXKglQd+sxRGt23gDM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from PH0PR01MB7975.prod.exchangelabs.com (2603:10b6:510:26d::15) by
 LV2PR01MB7646.prod.exchangelabs.com (2603:10b6:408:179::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.18; Fri, 7 Mar 2025 03:03:39 +0000
Received: from PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::6926:a627:118e:8050]) by PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::6926:a627:118e:8050%4]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 03:03:39 +0000
Message-ID: <8e7618ef-ba5f-42ac-80b7-f07e3e85ec42@amperemail.onmicrosoft.com>
Date: Fri, 7 Mar 2025 11:03:30 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH resend ] tracepoint: Print the function symbol when
 tracepoint_debug is set
Content-Language: en-GB
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Steven Rostedt <rostedt@goodmis.org>
Cc: Huang Shijie <shijie@os.amperecomputing.com>,
 patches@amperecomputing.com, cl@linux.com, yang@os.amperecomputing.com,
 peterz@infradead.org, jpoimboe@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
References: <20250305015505.14493-1-shijie@os.amperecomputing.com>
 <f600edd0-8855-46af-98ec-1181db1f5dd4@efficios.com>
 <b098cbdf-394b-4f20-9dcd-393ad1b734b7@amperemail.onmicrosoft.com>
 <20250306101315.5a5f1d7f@gandalf.local.home>
 <0e691a3e-1406-4496-b7e4-8b1679b59b5d@efficios.com>
From: Shijie Huang <shijie@amperemail.onmicrosoft.com>
In-Reply-To: <0e691a3e-1406-4496-b7e4-8b1679b59b5d@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0035.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::22)
 To PH0PR01MB7975.prod.exchangelabs.com (2603:10b6:510:26d::15)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB7975:EE_|LV2PR01MB7646:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bc6b428-072b-4cc1-9d75-08dd5d24a8ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aXJ3WU9IK1pveFF1Ylc1bzVNeVRzMGpJbHdzVXUrQUpabUIwOXNRUURiYngv?=
 =?utf-8?B?VytJdStYQlpxL0xlbTVmRmp6a1RHclNFejE4dm1hOEN0YlQvc0c3eTJWUC9v?=
 =?utf-8?B?UnJUL0NPK2FtT0g0bXQwdFIrS3dlUmVrV1UrMHJVNEROZ0ZnS3FsVDZyWmZz?=
 =?utf-8?B?azgvdXVKYm1nbTFZdyt2azdqVzZyYU1aazQzYjFCd0E3djladS9IbitFdmdH?=
 =?utf-8?B?QXlrODVVdkF0QUwvMWpxeEJSd2FoWTd4d1JuMFp3azluRm1UdXVHODZpeVRL?=
 =?utf-8?B?UExiQThOMzNneUQ3NU1rYmU1MDJjNXlna1lzQ3A0eE5iaXh4a1EyYjUyRGRS?=
 =?utf-8?B?R3JVVktpcE1zazNFTXhMK0NEY0xGYVd4YnAxdnZnaHlrWE9jdkxLNDl4bnRL?=
 =?utf-8?B?M28rdXRETXJxaWhBcnFjUHRDV2pMUkZtNTl3MUFHdm8vdHo4UjdzdHFjekpT?=
 =?utf-8?B?eHlOZzFJOGQveWxkdDhNYUdmdGpWZm1ScW1qWkg3TmxWSmZLQjVkT0ZTcW5P?=
 =?utf-8?B?cFVtWlNmT3NqREtBejBBZG9SaitaUHo1UkFBeHhIMmVFSXRBeXd1WFNsTWl1?=
 =?utf-8?B?VHZJZnBSWGNSNkhFQlFRa2ZsbGVmMCtmWG5WR3ZRWjBrTzMvbWQ1S0c1dkU5?=
 =?utf-8?B?VHZDQzVjenoxMk1PUGI1MzBSY09LMmw1d3VGS21VNkd2YzNybEh3ajhzZE1l?=
 =?utf-8?B?cU9JcENORmRJakFBNmppM0hZYVloK2o1VytZWXl2S21YQ293VXlRYWZGMjJH?=
 =?utf-8?B?Nzh6ZUNsczcrWVNHTDYwWUZaelF5K085U09jNFBReCtJZ0dzNzBHamZyYlBZ?=
 =?utf-8?B?Y0pFOW9vYVZhRGpLS01LQml3TXh3aXBOb2pnbk5Ia1lCOCtTM2UvY3dZRnBl?=
 =?utf-8?B?cWtXOUJwVWVTQVRJcW5NRGZWNEFHQW43TC9CZWtxWnpFeGUwUnE2QXBMWDZk?=
 =?utf-8?B?VFhQb09IQWk2TGJUVWMrYzJ6OHlQVWVXc3Q2N1EvUkRuOXArcWc2c0g0VXow?=
 =?utf-8?B?dlJXc3d6NXBKV2dqZTBIb21XdzJuc0M4RnVUNzd2dkJqVVhkMDNmL0pGMC9U?=
 =?utf-8?B?REoyS01zTkQxZE1weHZiUkFQZnJjVjZDeGVUUlJQN1RBWnBCZERlc3Z2M3Yx?=
 =?utf-8?B?MmdkQTY0WVBnU2dsbkFxOGVEeTRmdG5OdHFUTW1nWXBCbXJqTyt0L3U5bDdz?=
 =?utf-8?B?K216ZVhGQzdDaHR4QXphMGt2VWlhOGI5SmcyRmJVeW9FVmRxcUliYldNR2xR?=
 =?utf-8?B?UXVWOWd2M3NaejI2TUR6UWUwcjhsZ3U5cjJqUnoxenloL29nNmFyaHk1aFdM?=
 =?utf-8?B?YzBndmJ5MlBnWGNyN09rOFdXTStmTFQ3NnNxaCtMZUxHc2l2WG5hT0hsZ2gx?=
 =?utf-8?B?Yk5EMmovNEVaanFhbUErWWg2QjEzSUR6YlloRnhiM2MvL2pzcko4VVdRR2Zy?=
 =?utf-8?B?TE91WE50anVJMGlZRFc1a1preG53L0xiYm9QMWFEU0pVUWpaSWdDNTlZVit6?=
 =?utf-8?B?dnhYd1BsVFpWbnM4dlJlMjhkTmkzY3VqOTdBdGdtTkdNRms2UVNKQkk3amh4?=
 =?utf-8?B?K0dmeC9mUnpjOFBXc0Y1bExzQ09YOWpZcGpEeXMxODFpS0EzNy8vQkJ4N0M0?=
 =?utf-8?B?TXlUQkVDVzZYL2pWRUNyZ1RlRnlmV2ZFUTJQUVNGRkZyKzNiT0QvNWtzVDdF?=
 =?utf-8?B?OE1YYjV4N3NYQmNSVmpqVGFaTWJocGNKZ3Z6bTlOZDVHcGdKME15b2NuSzk5?=
 =?utf-8?B?SndRdytiN3lEb3F1dVMyOU5CSTNWTWtoMjFjeE1tTmRBT29MYXRmVnFQaEps?=
 =?utf-8?B?UUQ3SU54Z1hsWkxGTW1kM3p5b2tLejZ1KzZxVXFOV1QxMnN3S0tUdVQ2ME45?=
 =?utf-8?Q?4QGcckK8Qv/rP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB7975.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MmpHZWpXclgvenp3d2Z4UzBKbmdnN1Biajc0d3A3cDhDV0YwQjVLRjRVbDNX?=
 =?utf-8?B?aUgxT29RTkEwVHYyWkZQeFg3U2Qyc0ZkMCtEY0pRai9Cbk5YaGQ3K0lCRVVz?=
 =?utf-8?B?cW94eVBJMy9vd3gwYzFUL3BVS05rSDBTdnlUcmdmWk5wSktaUUd2c1hwMjFF?=
 =?utf-8?B?OVpQdG5rQjNBOFBZbHhUOCszanY3MTBjdzZ4SnRoZ1BpTjFoT3hOTURPMncx?=
 =?utf-8?B?Zk8rVUh4U3FaQ0tteThLNzNhSzB5TmQvZGN5Z0Z6ek1Ua2F4RmpDRFc1V2JS?=
 =?utf-8?B?dFJySG1YYi9TOVJnUWhYYjRmRmVOTGRJL3Z0VzhCdm5TdW43WFhQV2w2Mi9G?=
 =?utf-8?B?L21vWFozWllCOXlZSHd6NEtKOWx6YU92U1hYMjRZZXIwNGRSajBRUGdOOC9m?=
 =?utf-8?B?ODlHNTQ0TCtVZzFKWlNNZGdVY2xlUnd0ZGUvbENSd3F3WW1xT2todEFuYlR6?=
 =?utf-8?B?c2R4WUlMWm55dElkZlk5ZUo4VFNhQmtDWG1Ua3FaVUNpR01zbTVOamZYMkNW?=
 =?utf-8?B?TTlaWWk0QWlhUGZXOWdkNHpZVVI4YWJ5bGY5ZTBhZzFqN25PMUpYbEpnL0hy?=
 =?utf-8?B?VnBkb3hHTnd0QnBwRmFnL1J5ZGxULzh5TkI4SkYrQzlOazRQL250VEVkQVY3?=
 =?utf-8?B?MFcyUVVZT1lpQUR2OFdrZjhLajdnS2t0M3NGT3U1WWlhbDR1VjhWbUR3UVE2?=
 =?utf-8?B?VVR5ZjdQSUlpY1lwWTZZY0pkeDNEOC9sa3pXRDk0WXlqQnVCbWdTQkwrRGpJ?=
 =?utf-8?B?ZlFxNmlrYUE1M3luQ2xPb3UzM3RaTGtNVys0Qnk2TmhyUk96S3BuRFJwRWRr?=
 =?utf-8?B?SFFZbWVTUXZmbDgwbDNRVlJIVGpyaTJZakE4TnNRZkJSeklMdFRzaWdmOWpm?=
 =?utf-8?B?MFJJQ09pSkZzVUwyL0lmN0ppSzBPTGYxem9GaExGdkFQU1YrUUk0MzEydWEz?=
 =?utf-8?B?Nlg3R3BtK1pZVG9SaVZTeUhUT21wenhmaHY0bjZ4VDFFQ3dCay80cTd4cmxR?=
 =?utf-8?B?djJBWFFxejRxc1VpYlhoUWpXN2pvVnlEcmpOczNDVXVOZmxWVjFzYTBBdGtx?=
 =?utf-8?B?cm4yc0VjZEtPQy9WVzU3MTh6TTZBUHdWeWFrOUFmUHlBa2ova0NlLy95M3dh?=
 =?utf-8?B?TGpQWk9zcml6TGcxd295eThESVdNbFpRVmp1c2VzcmtST2YySkUzTHNNMWFj?=
 =?utf-8?B?UFlsMmhaYzRnY1FsdVBMMk5MdUZINExvT1dOM3J0cHB6V2lNUTV1RVdWUTRM?=
 =?utf-8?B?enNIUkJoZnRzUTRoMkI1SUVYT096cEFJL28zaDY4UWxEeGNEenNKSTQzZllL?=
 =?utf-8?B?UlZMR1grRStFeVRCczlxUFBxbzJwcUdLejM0T2MxSWJsWk1kT2JaOVd5Ykxy?=
 =?utf-8?B?a0VxK0RDMGZ5TlJYZVlFa2tkVHl4TkphSVlIdmd1Y3Vrd2FtS25POXRJaC90?=
 =?utf-8?B?VkIxUUs2MTZsMERXdmNiM1RMWThBYTY5NU5RZkJqUjRRNFVFMHJyU0wyRi9H?=
 =?utf-8?B?cmZoTTFFYUNycW40QXRvVGVKRmFObkpxaFhZcksrV2dVdTkydTYzODRWRVJa?=
 =?utf-8?B?ZUR0eVp1cGU4ZlRGTnE3TVdpWWF1MUJmY3o1dk1ROElNRkhoQlBqOW1EUTUz?=
 =?utf-8?B?ZHlDUG9td2pCQ0htUER5enhJN200Zk9pMDV1K1ZzVmU0K0tMWUpPSWlhNVlI?=
 =?utf-8?B?U3VmS2JwTnNwc3Y4Wk9vZldncysrVlpKcWtZZHBRcUFpTVo3dnR0enlER2hJ?=
 =?utf-8?B?WEh0WVFBRVpZRGJ3OC9kTWc5MisyVXVaSG02a1F6eHkwNDJKOWdDZVBnZVdU?=
 =?utf-8?B?aVNnU0NOcE1Xb0x6OVpjNnRXRWxkZHZkUUVaQWRKWmpSUWZUbUFFVEw2TnRU?=
 =?utf-8?B?RXJ2dy94elN3alh4bEtaTzRCWVVkUlpNVm5KSHpsM3QzamF0cmcwS0dmaHdT?=
 =?utf-8?B?dFhrbWs4VytoNG1mcnFDVDhhYzhyZ09LeGJOMGk4QTFraTBFUTV3VzdqQmN5?=
 =?utf-8?B?K0xTazgxMlFpS0V4SnBKY2pRaDREcko4RGROOFlxSlY5eEQzb1RWMitzTjlR?=
 =?utf-8?B?Vi9RMEN2SFYvMlpLZGw3NXNxeENXQW1LbjJPcFlYUnlTVHJvUVIxa2M0Sm1L?=
 =?utf-8?B?TldWNEdQZDNwL0Nmd3o3aklrY3ZIcXlJQzRSNXg3U3lEQ0Z4NjRuVDJGYkY2?=
 =?utf-8?Q?NBgJSZ4kAHt7RfBPILaCBDw=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bc6b428-072b-4cc1-9d75-08dd5d24a8ed
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB7975.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 03:03:39.5549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PW20FKJhEg4ZcMF1erC9kap9Rq5/dAovjFAgGzq3NdGL9gxIP5h3t+zL6krtOX9bWd8gvitdsakNKlV7JxwhgjYH7VWvENFbHuA7whlFLb5Lok8qkeIMxGEIH+xiLhph
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR01MB7646


On 2025/3/7 0:37, Mathieu Desnoyers wrote:
>
> I think we could just print %Sb
>
> e.g. from core-api/printk-formats.rst:
>
>         %pSb    versatile_init+0x0/0x110 [module_name 
> ed5019fdf5e53be37cb1ba7899292d7e143b259e]
>
> AFAIU, when the kallsyms_lookup_buildid fails, it prints the raw 
> address instead
> (see __sprint_symbol).

okay, I will use "%pSb" in version v2 later.


Thanks

Huang Shijie

