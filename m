Received: from mx0b-007b0c01.pphosted.com (mx0b-007b0c01.pphosted.com [205.220.177.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20EA53594C;
	Mon, 16 Jun 2025 00:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750035444; cv=fail; b=ZQKzbXp/YuE9MeK2d5X1tVnXTEKeVKg2s1hJkTA97zvIZ0rKes9UUbeZzXwPxfsdPnDo1rPq4x13qC5j4PeDZ5IsK8XYZHY+CRDkG9cJTBgpll1gZLRP6H8SxJz5Wsg88bG1ZlzFvf8dz2xzgc96hTi7dIESEOYep3PRFxzs7y4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750035444; c=relaxed/simple;
	bh=LGpuHGRD1A15UDU0Ja9vxAb7tg5OyFbwOZ5pO6P4WGY=;
	h=Message-ID:Date:From:Subject:To:Cc:Content-Type:MIME-Version; b=ZmcNi3KJ5uNkr6IM48xX/uyjxv6Hw1r2CSlmncLd8qNJosHm8oRpdxYd6+Q8rOKnQ5tvem250B1rAyJNUQAFaQUIS8XIBpjuQEOYKbhEER/mIURBLvHixmz2hZVI0iHSVHX6RrDaohyfF/m4RbpBbjbYTLBNE4lDvTw+aw5HTKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.wisc.edu; spf=pass smtp.mailfrom=cs.wisc.edu; dkim=pass (2048-bit key) header.d=cs.wisc.edu header.i=@cs.wisc.edu header.b=w0RTdifG; arc=fail smtp.client-ip=205.220.177.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.wisc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.wisc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.wisc.edu header.i=@cs.wisc.edu header.b="w0RTdifG"
Received: from pps.filterd (m0316042.ppops.net [127.0.0.1])
	by mx0b-007b0c01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55FNsGnL029890;
	Sun, 15 Jun 2025 19:32:06 -0500
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010038.outbound.protection.outlook.com [52.101.85.38])
	by mx0b-007b0c01.pphosted.com (PPS) with ESMTPS id 479rm1u164-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 15 Jun 2025 19:32:05 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EhbOJPtqSU1z0wyFauNdoNps1hHl6mQpZSiadz7XwZtpWrHFNbUoswLfbtwctmtlAcWif8WQHO9eH/BlHeQe87te1f6Q2r8MkDYcAYSoBM9Cf7rUbSosbp2b3fHjDroOxj8YmZKv6wMzb3q4vAmOE/xiWGr7WZzSPuT9LX6hCpFE/K5ypKUXHEV0CaONzQeo3sdm/B+asZE7Nrisd+74l6dZksYkvEq9npVjjuJpp4yIhYN+CUG6/BNtSSSSBqP1dMirisbl7AaMvsZji4EJMCzyrX9D5DH3xuUwMpERZATER1tVqoQt0IEz7zaQOhihVgDh/H+HU03rmKeTRYfY4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r1aJJfu9iTPnnvRHpFNGLzvJbqKyz2mDzUBdjFsYD+Q=;
 b=CxIj7cY2BS2TunNytbjE67txflw3ES7sIXGBaDoIrULQoilPBJzZYRbq66qEKwxp4a5pwapxBLp0/D7tfOp98epyC2tfo278qHB3otRkSsef9+iqGYQ3/6ZfJ6OC+yj7+v39MQeLh9jnp7eH89FXTNAsk79nglgq5TGb2ZdpkPe3KthZ+WoKyzfnKIh4VrwLcRtVZ41Xq8oJg3PSuluhEL29Un4DBFVEhvNZxl5KeFFeSKzoBlBb/+kjY5wTnC2GGoCzpC7Rx7Bu1NK0web1F/I3xVOuBKDiZG1psrbT7+HEUtEpaoSGylIknz+vFBxiJYEN7kZbTK/++PjIgv2o9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cs.wisc.edu; dmarc=pass action=none header.from=cs.wisc.edu;
 dkim=pass header.d=cs.wisc.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cs.wisc.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r1aJJfu9iTPnnvRHpFNGLzvJbqKyz2mDzUBdjFsYD+Q=;
 b=w0RTdifGXQ041d7ExJN1iQQgCE/su9/IKXgyCDo4NB0JmS9lg1EZ4CD+7IjBL6qdOpD8vdA65an49257K7TiPittstjYsjmGzWV35Za6vtHNlkccIwQ64ogy8gbXBi6Wxpgk7lB+afmMsPIL2YcDo5i9ENg1B12ELiewvjoq0BwHf0s2BdvRxG21lMSTxW2Nht0tGZNXPfA5eA3oeBbK1FbNOAacOLVQwJrxagJf7hMaflUD+en75Np89YUeXSFRBoR3PM6GHMtKMSH/EDPHRBP8tOY7Tl8J8Wve5V+xBkzmvihEGZ3mkqssh4R7SmTLmuTZ8DmrvwdirK7Z+SS22w==
Received: from DS7PR06MB6808.namprd06.prod.outlook.com (2603:10b6:5:2d2::10)
 by DS0PR06MB9812.namprd06.prod.outlook.com (2603:10b6:8:1cf::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Mon, 16 Jun
 2025 00:32:02 +0000
Received: from DS7PR06MB6808.namprd06.prod.outlook.com
 ([fe80::76b2:e1c8:9a15:7a1c]) by DS7PR06MB6808.namprd06.prod.outlook.com
 ([fe80::76b2:e1c8:9a15:7a1c%7]) with mapi id 15.20.8835.027; Mon, 16 Jun 2025
 00:32:02 +0000
Message-ID: <2dda8c03-072a-43b2-af0c-bb996d64c388@cs.wisc.edu>
Date: Sun, 15 Jun 2025 19:32:00 -0500
User-Agent: Mozilla Thunderbird
From: Junxuan Liao <ljx@cs.wisc.edu>
Subject: [PATCH v3 RESEND] x86/tracing: introduce enter/exit tracepoint pairs
 for page faults
To: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Content-Language: en-US
Autocrypt: addr=ljx@cs.wisc.edu; keydata=
 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
 1LHI6us+ZjzkMldzphVeBsBvT0hcR7u3cA==
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5PR04CA0014.namprd04.prod.outlook.com
 (2603:10b6:610:1f4::26) To DS7PR06MB6808.namprd06.prod.outlook.com
 (2603:10b6:5:2d2::10)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR06MB6808:EE_|DS0PR06MB9812:EE_
X-MS-Office365-Filtering-Correlation-Id: c3a95648-2e6c-480a-f639-08ddac6d3637
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|41320700013|10070799003|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T1I0TzJ1M1BMR3NlM1lWSmN1WVRGcjRLdEdXeStRRzB4dlllYXVheXRBME02?=
 =?utf-8?B?dSt5ZCsvcWlrTnE5Vll4eFVIejA5b2pSL1VtT1RRemtRNzUxd0pVeVpqZ2lH?=
 =?utf-8?B?bEpmVnRlOEV1ZXVITVh2TnVZOXdtV2srWllPMXZlanMwZ3NBNEJLK2JlUVJJ?=
 =?utf-8?B?aDMvM3h4cEM1T1hHWWpVRGNFYkZKdEFMUGU4V1VNNTJkNVV0cTRiQ3pwTnlY?=
 =?utf-8?B?cGh4MEw2R0ZKK0Z3ZnRlNEFwZ3NzZWI5ME80OTAvbkMwY2g3bmswOFZ4MjdP?=
 =?utf-8?B?OW1uRnFqam43UlhucTRHbHVmaHBQRGsxQktLd3NqcFBxWWR2L0YzdUk3QXJq?=
 =?utf-8?B?TUZMYTUwNjhBNVd0VXJkc2VUQnRFa2UxdWtxZVN6R0NqdDZzMTd6SEVWa05C?=
 =?utf-8?B?aWpxcmV3RURYT3hJNE1SUnBOZlRnOW8xWjdNNVd6bXM5TXAxL3RLZWFnTk1S?=
 =?utf-8?B?N2M1bkppUU8wV0tSNGpzVlp3R2RVKzhsQnM2UmlnM0JXeUQrYXlEWUQwY0Vl?=
 =?utf-8?B?QmxwQUpMVENhVXpVQjcvZnpCTmtFaytTMkV5TS9QMndEazVnY2dhTzVwYmRW?=
 =?utf-8?B?cGNaVDBjM2l0d2VvNndhNi8vQTV6RzE2ZldHS0luaDd4UTBaS3lmUFVMamZl?=
 =?utf-8?B?UjV0ZDFFZEE1SUVneHAwSnpPdWJVY3NDVjRNbk5uMlNZTHZhc0dNVzEvaWVa?=
 =?utf-8?B?YTZTS1k5ZldHTDJnZVJYckdmVU81WWJBaHZ1UkZiOVFRdFB1OUFKWEVFalF6?=
 =?utf-8?B?NGd2V01icCttb1Nyc3BUcFRCR1RIajRPazhiMkxQbGNxRDJQdmFkWCtpZDFJ?=
 =?utf-8?B?RUpZM01vczV3T24yT2swMUhuV1kzZktKc0ZZY1JIQlpFdmJzZThNZTdHL2Va?=
 =?utf-8?B?T3J2N1ByeFdZK2ozYXFBeTNoUjJWUXRxcTNwNCsxVjlmRHZ6UjU5UDQ1a2I0?=
 =?utf-8?B?Q2ZmZ0k2VStRZkpnTTFDVjVzcW4xNTU3emZHNUtWYWFDdVBJeFJIT1Z3SmZH?=
 =?utf-8?B?MFI0ckgwcWZsVXhkNnUyOG5QNGJxakJUcXFES1ZhTkFlUUhQZjBJYWJySkdi?=
 =?utf-8?B?WURzKzdFVUUrdGY4allLbWY3eW9lVHh6SllPMENEUWNWZWR3ZWZ5ZmxiZEs3?=
 =?utf-8?B?MDliMGhTVmhVVFhUREZuWWxnbmdLMFc4Umc3WDZkdTd2Y3NYek1RZ1poRElS?=
 =?utf-8?B?RFpzN25iRjM1Q0lyTHVQcE8rVEFzTzRCSkk4QWsvQ3ByaGp5clNadTR2dlNr?=
 =?utf-8?B?THF5L0FMdkF4TEpUK1BnS1U1dUFGVGczbzduMlU0VUFkTGFkSnBKNDdrUEc3?=
 =?utf-8?B?S0xVMVRJbDJJQ3lKdzUzMGFUWVV4KzkwaEVjZWFNMys3NzNRYXU4SHF3K0lp?=
 =?utf-8?B?RHJiUFg0MnlhdzZkVEkyaXhlOUd5NFNTU3o3bnlyamh5YjhzOTBKZCtwaU9s?=
 =?utf-8?B?SEM1NHdodDU4WExIQ3BEcjl4ZWZxU1RROXNBSHRKWHkzaXRBOUxsTFc0a05z?=
 =?utf-8?B?dGpFaW10amdSQzRGQVpITEhxYm5tSnU3TFVtVkdlTzZNYTNzUnNQdS8ySkg5?=
 =?utf-8?B?MEE1YzJiemRqQXl0eU94S1AzMGMzNUNkcGpWS0FBSEhCRFNKN1JJa3FBdjQv?=
 =?utf-8?B?bCt4OXR4YURTWVZKZVBVN21YS1NlWlJFcWZXRTV0bUVUWC9jSHRxbDVpMEtX?=
 =?utf-8?B?VjdkM3IxNkpZQXYybVNMSHFuVlVMcVlPU1hCTnpaQ3lvWkdVaks0SlFLN3J3?=
 =?utf-8?B?T2xBTDhRdWdYT01lUytGYnNodkxXd1VsVlpraDR4bXhUUmp0OXEzZllmcEMz?=
 =?utf-8?B?MkVManliRUhxQnFTem5LQnBjNGNKYi9pSVAvaU5DbUJXcjgrWms0QnhMKzNw?=
 =?utf-8?B?dFJ3WU5pbEZJelZSMUVlRzNDaVBjUGFBcWlMOGhRcklVUWFrMGs0a0ZSNjJB?=
 =?utf-8?Q?rLaLhrEk3co=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR06MB6808.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(41320700013)(10070799003)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZWV1U0o1bHh2YmRvOFhCOWNNck81TzdYazFUSmpZNm03TktwdWlDeU5iLzZk?=
 =?utf-8?B?TDV3QUx2cHJ6WDRwc3hyTDdaQ3pCd1J4UC92a2l1Q0ljT3kwT0xxMXBoTFVZ?=
 =?utf-8?B?bklCaEF0SFdMMG1DNjE2WXFDYXF0bVlJYnZNUDZxQnVOQVRDZ2dsb25LanEy?=
 =?utf-8?B?d2hmZzZyRHJBbndtMHF0M2V2L21remsxMXQ0YTVqS1I2SmhaYjh3WVVNQW5N?=
 =?utf-8?B?eitpOExRYTcxRXRlVzdwbEc5Z29xOGtRbUovb3l6aHhvVnNOekdzQkxqZXBi?=
 =?utf-8?B?NlcwSFFXRE8rWnUwUHVNWk1CbEREVWQrS0lTeU01dk5Wdis2NmROS2ZBNWxR?=
 =?utf-8?B?aHVFbFZMcnBQK1lkVFgyZ0NrOTRZNldOMFd0TlNqQ1Y4aWJHNkJ2MVdJTk9P?=
 =?utf-8?B?OVFxeERyY05KdmtWdUR4R1VtSk52bXBtR09JNDc2QVd1Mmc1Y1RZcElaaEhX?=
 =?utf-8?B?OGR6MVN0QmZlVDhYbjRRZlZ6bHV6VzNnSk5vZmUvRjMxbUZJdzZhdlF0K3dC?=
 =?utf-8?B?V0FlVkg3SFF4SUNiT2ZWTGlSS3dyMy9pMFdBWGFFZUt1YStNU293ZWhnM1Za?=
 =?utf-8?B?SWxTV0I0T1AwdUlTODZRMGFQWWtiZnNPM3EyREtOSkgyU0pOSmRoOFZ0Rysr?=
 =?utf-8?B?di9oeDdENWxORVMvcFZ3aXA4alZXdlYzTzJBUURoK09YMVYyQUh4M1JCcUVZ?=
 =?utf-8?B?dTFuaElOMTBjbnJDSUs0c2tyRWU3Y1l5RjM3Qkh0a3JXYTF1NjVRb0VwTW5Y?=
 =?utf-8?B?T3FUNldzZjYrWG42c3NvSFp5NitOcWk1QVh6a3BkSDBBdlAwTjdtSm9wOVJs?=
 =?utf-8?B?bFFCc3Y2SFFVVmE0bnhFL0ZyWURGYlRKa2FXd3JkRjRVa1F1UDQvd3JoV0NM?=
 =?utf-8?B?V1JJcHJYR2xiRVVDMmljT0xqdCtLVE0xaHBrRXRhRytsbjZ1R1UrdkY2a25W?=
 =?utf-8?B?Y285REE1ZitodmY0VGVXb2EvdFNCaEhIK040bHhGekx2alpGblJmS013aVp1?=
 =?utf-8?B?MlpCeTljMmJFMlQ4WEl0L21BeERxU0NVQmdrekhZc0NLSUNJNFJlck5BTjVD?=
 =?utf-8?B?aWdwN3YzZWh4SG1rMWtsTGtYTGV2SzVEVHdNRFZJaDRDWFFOSmJIWnlxcVpZ?=
 =?utf-8?B?ZHp5cGlURzFKUEhhdWFOazFRY0tLdHhIdmQvcHJjbDI3TUc2UTJXR1p6MS9Z?=
 =?utf-8?B?aXdmUjBmZTk5Q0JkNGtXb2lWSjZ3ZTYyMTZnYWd0Y2QrT0FOVHRyZXg1TGpV?=
 =?utf-8?B?ODdqVEdTeFhkeDFBK2d5L0lUY3JKS2lRZU9sejhWYWFVcWtFQ3FKOVFkcmYz?=
 =?utf-8?B?MFFPdlRnVElQT3hzTEkrQjZnUUcxWWxRZDJralc1d29MN0h5VmRlQTRMQklr?=
 =?utf-8?B?Nk1UelB5YkRGM3JWdzZMdTAxM2xwWWpUczlMajVKeTBWNDJYdVptNlFHdjB2?=
 =?utf-8?B?djM2eWpaVWlYbmdxcFYvSlRjSllGNVRLZWVKWThPSUtuakc4UG1NWEFUQ0V5?=
 =?utf-8?B?SVNZbnQybm5SVkR2T3g5QW1ZWUtuYmlOZ3d2VE9RV0o5RnZwUXdRa0NCbHNw?=
 =?utf-8?B?eXpYdVV4RHBhSVVGdkI3R2RCYW9NVWVyUkh0enNJWFk2WWQybWRBZG4yR2hw?=
 =?utf-8?B?enNid3A2Y1QrdlJUZWRIVzFQMWp2ZktkL2Z1SkRQeWI5UHVHLzc3eHRGdGRS?=
 =?utf-8?B?QTkzbUdoSmJDZWR1c0RCN3hobkdybmNSMGREcU1nSUpMbWJSMkxzTllXb21B?=
 =?utf-8?B?SHBLKzVDNUFMTU9aMjBmOVJiQkxiZEZld040anZDUzBDTVhPV09ONzhQSVV2?=
 =?utf-8?B?bG9oRDcyVVl6SmJ3L3V1UklSY05qejFEVmxTUllOc0NDa2poSytEdDFKQkhK?=
 =?utf-8?B?MFNYb0J1U2lUVnRRMWhVS2VNWUx6WDcwNlQ5Z2ZxdVRleUdtcnZNdXM0RGt3?=
 =?utf-8?B?VFhsck1UV3JLWGNPcXRHeDA5MVVHNjBUNnhlSi85VFg5Nm9HMFJxbmkzR2N4?=
 =?utf-8?B?MEJDaHFMR3UzSllNUXhUK3o4MFNUUlh2MlVOVkxhWnk5RXBWVkF4azkyUTVp?=
 =?utf-8?B?dXhmUkd4aTlKYVhJWVVpdlBZVHZTQkl1UmRiKy80QndPd3dTNE1CN1hNZXhC?=
 =?utf-8?B?RTdrZFM0T2FWQU5KQXpMTlRjS2premZJcUpvZ0V3aUhKWmdCSkJBZjN6ZFhq?=
 =?utf-8?Q?Ffj9GhIs8fRc7TZNYaHnJbu6R7367wX3ZsDzNoplwCnc?=
X-OriginatorOrg: cs.wisc.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: c3a95648-2e6c-480a-f639-08ddac6d3637
X-MS-Exchange-CrossTenant-AuthSource: DS7PR06MB6808.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 00:32:01.9529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2ca68321-0eda-4908-88b2-424a8cb4b0f9
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Cqtd9BCh9qY73stcU0oGkFztMgud+t7+m01Jl8b3EsMFWWazt3l1CWUbz9Pcmk+n9b0b7UQR1yaQ2NqD0Vyag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR06MB9812
X-Proofpoint-GUID: COCy9jBPvZlBECevJrip2nVZD8MVezaV
X-Proofpoint-ORIG-GUID: COCy9jBPvZlBECevJrip2nVZD8MVezaV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE2MDAwMiBTYWx0ZWRfXxoBvVBAA/0Ht p9vOQCBOaqVKjeq/TnFPnkoCv8AApWqghLK26rHDApoBBnVJHXqQh/AIObbxBWzzGx0RFjASONx 0FZxFfjlvCXUXIJ99c1T0AGtqJ82LGe2CFuyYrV24vI4Ts02Beye1IP7ieU9Dolhf+mxEW+twgi
 FNOi5tRtzD+tX9FIMDNRsLbB6PFNDJwBYU4WXOynyaGr6qRdoNwJ03s4125owheFRbXdjxm2LCG fpk8sgGMdHV8xnIWEOjHFuJITCmmWq49gSCPVU/+Nb1OjYhgiZRizU9kACnhnXm0/7m6yyMolpZ bo5KheFW5Ljuf1NqRPjEzNS0jgKNcKY2Zh6xDkO6wb6XYFGIkXz03u8Fi+rhtb6aSJQWWf6kQpk
 h4AbVAjZTbzjMfcbiMqMqrbo7yRe1HE0CL8xIOpDuPPBdpht3y5OFjEUibLxH5lN86+WuQC8
X-Authority-Analysis: v=2.4 cv=ZMXXmW7b c=1 sm=1 tr=0 ts=684f6606 cx=c_pps a=EPZJxM4MYJNUcCtligPUUQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=3-xYBkHg-QkA:10 a=VwQbUJbxAAAA:8 a=meVymXHHAAAA:8 a=x30EXVXcAAAA:8 a=VHdtxn1oruMNMYdiAnAA:9 a=QEXdDO2ut3YA:10 a=2JgSa4NbpEOStq-L5dxp:22 a=yI8jHdU-MAB4nH2QTHtW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-15_10,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 mlxscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0 mlxlogscore=999
 clxscore=1015 adultscore=0 priorityscore=1501 malwarescore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506160002

Merge page_fault_{user,kernel}, rename it page_fault_enter, and add
page_fault_exit. This pair is useful for measuring page fault handling
latencies.

Add a new field to the merged tracepoints to indicate whether the page
fault happened in userspace. We no longer need the static key associated,
since it was used just to avoid checking user_mode when the tracepoints
were disabled.

Signed-off-by: Junxuan Liao <ljx@cs.wisc.edu>
Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Link: https://lore.kernel.org/9e2ac1e3-d07d-4f17-970e-6b7a5248a5bb@cs.wisc.edu
---
v1: https://lore.kernel.org/linux-trace-kernel/e7d4cd81-c0a5-446c-95d2-6142d660c15b@cs.wisc.edu/
v1 -> v2:
Merge the user and kerenl tracepoints. Remove the static keys.
v2 -> v3:
Added back trace.o. Sorry that I accidentally deleted that in v2.

  arch/x86/include/asm/trace/common.h      | 12 ------------
  arch/x86/include/asm/trace/exceptions.h  | 15 +++++++--------
  arch/x86/include/asm/trace/irq_vectors.h |  1 -
  arch/x86/kernel/Makefile                 |  1 -
  arch/x86/kernel/tracepoint.c             | 21 ---------------------
  arch/x86/mm/fault.c                      | 16 ++--------------
  6 files changed, 9 insertions(+), 57 deletions(-)
  delete mode 100644 arch/x86/include/asm/trace/common.h
  delete mode 100644 arch/x86/kernel/tracepoint.c

diff --git a/arch/x86/include/asm/trace/common.h b/arch/x86/include/asm/trace/common.h
deleted file mode 100644
index f0f9bcdb74d9..000000000000
--- a/arch/x86/include/asm/trace/common.h
+++ /dev/null
@@ -1,12 +0,0 @@
-#ifndef _ASM_TRACE_COMMON_H
-#define _ASM_TRACE_COMMON_H
-
-#ifdef CONFIG_TRACING
-DECLARE_STATIC_KEY_FALSE(trace_pagefault_key);
-#define trace_pagefault_enabled()			\
-	static_branch_unlikely(&trace_pagefault_key)
-#else
-static inline bool trace_pagefault_enabled(void) { return false; }
-#endif
-
-#endif
diff --git a/arch/x86/include/asm/trace/exceptions.h b/arch/x86/include/asm/trace/exceptions.h
index 6b1e87194809..f98c9024cbe3 100644
--- a/arch/x86/include/asm/trace/exceptions.h
+++ b/arch/x86/include/asm/trace/exceptions.h
@@ -6,10 +6,6 @@
  #define _TRACE_PAGE_FAULT_H
  
  #include <linux/tracepoint.h>
-#include <asm/trace/common.h>
-
-extern int trace_pagefault_reg(void);
-extern void trace_pagefault_unreg(void);
  
  DECLARE_EVENT_CLASS(x86_exceptions,
  
@@ -21,17 +17,20 @@ DECLARE_EVENT_CLASS(x86_exceptions,
  	TP_STRUCT__entry(
  		__field(		unsigned long, address	)
  		__field(		unsigned long, ip	)
+		__field(		bool         , user_mode)
  		__field(		unsigned long, error_code )
  	),
  
  	TP_fast_assign(
  		__entry->address = address;
  		__entry->ip = regs->ip;
+		__entry->user_mode = user_mode(regs);
  		__entry->error_code = error_code;
  	),
  
-	TP_printk("address=%ps ip=%ps error_code=0x%lx",
+	TP_printk("address=%ps ip=%ps %s error_code=0x%lx",
  		  (void *)__entry->address, (void *)__entry->ip,
+		  __entry->user_mode ? "user" : "kernel",
  		  __entry->error_code) );
  
  #define DEFINE_PAGE_FAULT_EVENT(name)				\
@@ -39,10 +38,10 @@ DEFINE_EVENT_FN(x86_exceptions, name,				\
  	TP_PROTO(unsigned long address,	struct pt_regs *regs,	\
  		 unsigned long error_code),			\
  	TP_ARGS(address, regs, error_code),			\
-	trace_pagefault_reg, trace_pagefault_unreg);
+	NULL, NULL)
  
-DEFINE_PAGE_FAULT_EVENT(page_fault_user);
-DEFINE_PAGE_FAULT_EVENT(page_fault_kernel);
+DEFINE_PAGE_FAULT_EVENT(page_fault_enter);
+DEFINE_PAGE_FAULT_EVENT(page_fault_exit);
  
  #undef TRACE_INCLUDE_PATH
  #undef TRACE_INCLUDE_FILE
diff --git a/arch/x86/include/asm/trace/irq_vectors.h b/arch/x86/include/asm/trace/irq_vectors.h
index 88e7f0f3bf62..7408bebdfde0 100644
--- a/arch/x86/include/asm/trace/irq_vectors.h
+++ b/arch/x86/include/asm/trace/irq_vectors.h
@@ -6,7 +6,6 @@
  #define _TRACE_IRQ_VECTORS_H
  
  #include <linux/tracepoint.h>
-#include <asm/trace/common.h>
  
  #ifdef CONFIG_X86_LOCAL_APIC
  
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index b43eb7e384eb..e8e33ec684ba 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -139,7 +139,6 @@ obj-$(CONFIG_OF)			+= devicetree.o
  obj-$(CONFIG_UPROBES)			+= uprobes.o
  
  obj-$(CONFIG_PERF_EVENTS)		+= perf_regs.o
-obj-$(CONFIG_TRACING)			+= tracepoint.o
  obj-$(CONFIG_SCHED_MC_PRIO)		+= itmt.o
  obj-$(CONFIG_X86_UMIP)			+= umip.o
  
diff --git a/arch/x86/kernel/tracepoint.c b/arch/x86/kernel/tracepoint.c
deleted file mode 100644
index 03ae1caaa878..000000000000
--- a/arch/x86/kernel/tracepoint.c
+++ /dev/null
@@ -1,21 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (C) 2013 Seiji Aguchi <seiji.aguchi@hds.com>
- */
-#include <linux/jump_label.h>
-#include <linux/atomic.h>
-
-#include <asm/trace/exceptions.h>
-
-DEFINE_STATIC_KEY_FALSE(trace_pagefault_key);
-
-int trace_pagefault_reg(void)
-{
-	static_branch_inc(&trace_pagefault_key);
-	return 0;
-}
-
-void trace_pagefault_unreg(void)
-{
-	static_branch_dec(&trace_pagefault_key);
-}
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 296d294142c8..eda312707fde 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1451,24 +1451,10 @@ void do_user_addr_fault(struct pt_regs *regs,
  }
  NOKPROBE_SYMBOL(do_user_addr_fault);
  
-static __always_inline void
-trace_page_fault_entries(struct pt_regs *regs, unsigned long error_code,
-			 unsigned long address)
-{
-	if (!trace_pagefault_enabled())
-		return;
-
-	if (user_mode(regs))
-		trace_page_fault_user(address, regs, error_code);
-	else
-		trace_page_fault_kernel(address, regs, error_code);
-}
-
  static __always_inline void
  handle_page_fault(struct pt_regs *regs, unsigned long error_code,
  			      unsigned long address)
  {
-	trace_page_fault_entries(regs, error_code, address);
  
  	if (unlikely(kmmio_fault(regs, address)))
  		return;
@@ -1535,7 +1521,9 @@ DEFINE_IDTENTRY_RAW_ERRORCODE(exc_page_fault)
  	state = irqentry_enter(regs);
  
  	instrumentation_begin();
+	trace_page_fault_enter(address, regs, error_code);
  	handle_page_fault(regs, error_code, address);
+	trace_page_fault_exit(address, regs, error_code);
  	instrumentation_end();
  
  	irqentry_exit(regs, state);
-- 
2.48.1

