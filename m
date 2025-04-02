Received: from YT5PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11021097.outbound.protection.outlook.com [40.107.192.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8D68634F;
	Wed,  2 Apr 2025 16:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.192.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743609617; cv=fail; b=CLPcdoqwSF0Z0Fm7rnH1gXvXscwoAZ1GgplcoggoxMOBpcwQewVTSe1TblWI66n/ps58ACQfU3TtpRpz1jyG+JIPgLIhtYDIqIHlNSRdx0XJm6Nys723JlVTEqVIYV1LV4Pey/LcFaPEF5CHKVZnLciy9h8Gmm6K5PpDqoTQ71M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743609617; c=relaxed/simple;
	bh=AX3CDMMEwnM6zwHdowIU6y6ryo63xFEG3Gf0ZkYEi+s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mt56KNKaxch+0GXKcPKHeZ6E8CUS4vKSN1Mn5X1I5oHVkyc4Vvm0tBWZx6ZXdIUDbANbCSnwcoYajCNr24RFzCLXTylrkFwk1bgC5bJ1eD6WqsFKCy+mg98RDh8k32RBgnu3s7Q9Xx5vLa6QHYiwShGbydKV5FmrN6CjTMUSEVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=n/DqpTSJ; arc=fail smtp.client-ip=40.107.192.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="n/DqpTSJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZnZVYrgb+XLqgXYuVsD2VZD0KhXvEduZxO1YKTSmwDDAVvvhJ3V6qvumYtmxxp6RfcgRLHBqxjm75X2/eEJIemjKmWB05SquYtsmg66/K2QQOeMauJS9VlcImmBFASQlIH4buisI8NEoscnBqCrNdX8I+G86wmcqhDXV6XuUhlZ5mzOvCt3V1ttuGOBg2NcXB+thGTQMBFND5WXad6V+hRpJBBYxseu40HneLRkpcElqicE5yJqHJE7JWJkqbulMmRlKBJzwfRqbCTr13szYoRyCddZfa/rCkP8C3ZMvf/+jlt4h31ZibT4et0r5ldXvyxUrXB6qP3Gl55/E5R5bvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ggeVY3/SvMEoAt2uvCOgWDdE4FjLpe/7JPr6pEbkPvc=;
 b=HlxcxkjThhsY66ok2+6G1JFxzS+JqXA+ftB8UbrTuL82OEKR0hVEC8tAmyKJUYmgBczhmTvl4TkN6Jqkg+dSfvp+3IxhpDJZOcdNgi+zb8A0AWApVxrtjhdEX9XyWYO6nT8OWkXfRChysYPNMEPL+VMiL0ffNacltUFVeOrHuO9n3LK67LtTNW28skbyUR/xjmumjJByabKmfT4orVZX68wXGQ4cNdwc4Rjs5KTlof4muDXu7Arc0etEkZxpvVbnXyezlYsPQdRipCFaEAHtp3DGO8cNGDXr1wg4ZCYti2BHrUaNrTvzkbm4zF4nw37hqDJr5GfrFzIef34xW3Df8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ggeVY3/SvMEoAt2uvCOgWDdE4FjLpe/7JPr6pEbkPvc=;
 b=n/DqpTSJAM9lT7hu2KAWKbnUfgKyFuFWNtullaPuDGwq1fFByErUApNWlc2XL5xuUzgdulC0BoQWJuq7dfXwDFWHocZKl93ynB+f5xzyIfkRbkSVxG4aOEMNyDyxON7hAA+VYeXP3vqS2bvZCGYkS/Pu6I7v1jHcwU+8EY+AzQbcuB1Qr1jSD0Rh1dA+Xft2aEWnx6mWaFJ73U+zV2OQt/GoO4BcCOs7zngDmF3k9ck5dP625iQSvNguoO80ER5luKIjxMBrbZWFQjCIeC9HW3ej+YlIqYo+LNMjlnz/zqo0A4EZLg7crQFniWHz5jtbtT+zUxPqAHlE31wMSEzRkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT2PR01MB5307.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:52::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 2 Apr
 2025 16:00:05 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%4]) with mapi id 15.20.8534.044; Wed, 2 Apr 2025
 16:00:05 +0000
Message-ID: <24fcfce6-6ec9-46e4-bcd6-307814fcea5c@efficios.com>
Date: Wed, 2 Apr 2025 12:00:03 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/4] tracing: Clean up persistent ring buffer code
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Vincent Donnefort <vdonnefort@google.com>, Vlastimil Babka <vbabka@suse.cz>,
 Mike Rapoport <rppt@kernel.org>, Jann Horn <jannh@google.com>
References: <20250402144903.993276623@goodmis.org>
 <c3e395d7-0c64-44d0-a0a7-57205b2ab712@efficios.com>
 <20250402114923.132217c1@gandalf.local.home>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20250402114923.132217c1@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0184.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8b::18) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT2PR01MB5307:EE_
X-MS-Office365-Filtering-Correlation-Id: 80aefd6e-8cb7-4983-5c43-08dd71ff6f09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TWRrYWZWVTRYWHhKNE14aWdiSnphbzdOd2FvR2VOR0pEeENpN0xhV1NJellj?=
 =?utf-8?B?TDZtSnlIUEIvUnNXanluSmhUUWF3K20zNEd6UGdWcURSditYUExheExrbDRr?=
 =?utf-8?B?VTYzRm5BeUhoRFBHUmFSblpGSDAwTUFVZGdXcEFLcDVkSWlmbVRxcjZUeklw?=
 =?utf-8?B?a2tsQmltL2RDc2VySjh1SzgwbVdtZktQNHlqM2o3emNtQmJsWDl3cjFoT0hY?=
 =?utf-8?B?RmN3T1RMSWxxT0dpakhuNkxnS3pUZlJHTFRPbWdTVjBzZG1ZVHU0WXZ1cHNI?=
 =?utf-8?B?aGo4NThTTVlweWo0cm9aazBiRGE3TGJKcUlpaFhyQndtRmFsRHpaQU9Kb3NH?=
 =?utf-8?B?SkVxS0pmZU1kaS9EekNKaXBpOTRUbmF0aEpsSXRPaTBKSUNlUFQrbGtheER3?=
 =?utf-8?B?VnBlR3pJOGp6ODh6dm5QRHB2Nm5odlRJQkJSL2d2UHROeEEzZU5Yb2NzN0Vm?=
 =?utf-8?B?MUZTWnd6c2RXNnQ0blhIdi96OTgzRERWc1ZBdkllVHBQbXFaK2hoMFkvRDVI?=
 =?utf-8?B?bi9SNzErQlRucGdReU5hN2FnRzJybENDK2FESzh5a0k0Rmdham5HTDF2WEdN?=
 =?utf-8?B?ZkNieTRkZWVoTGplbDNkN3grRmIzenFYRVUvMDExY3NkR0F5bmZCN2RRYmk0?=
 =?utf-8?B?czJoK1BuVWxkUVY4MHcwS2tWUHpSSU41dS91S2RqK0tuM1ozUGJJTWRxRXNZ?=
 =?utf-8?B?ejI0WDVBV09sNmJ3ek1OOHdGNkY2bFBWYUw4T2w0NVJ3SUVZcHhJb2R4dHFh?=
 =?utf-8?B?UGlmT1VnUjNiV1VvemdUNFJqSE1DUnY3WjlFb0dPV0xMVW5mSkhUbW54Y0Ji?=
 =?utf-8?B?L1FZbk5obVFkS1ZRSlNBRVBtc2xZZENRWFI2Vk43cC90OXlRM2pjOGEzNVFv?=
 =?utf-8?B?NkxSR0JDaU45V0VGcTdZSUcrTGNuTlArZStFcTkvdU9yL3lyakxCNHYxRzRV?=
 =?utf-8?B?T2hmWi9PQW8xTk5xcnZsd0tuaW1Dd1RBU01pRzRxVFV5ZDZSWjlyTFFVUEhN?=
 =?utf-8?B?RHQwMkxqSjl6d3RWcEhWT1U5cUJGT2gxa1FibHF3cWFPc0ZRRDI2Ymp3M1Er?=
 =?utf-8?B?ZDhnNVc3NzdEcWhqWnFpSHh1Vk9RRk9iUy96aUhmUk5VWklsOHEvazU1N09S?=
 =?utf-8?B?azFJQmtrMENqRURrTzh3VFBnZDlLOU1DWWJjR2xEQkowOVhucGt2Um5PQjZz?=
 =?utf-8?B?Y3g0a25meG42dVVmKzNEZGJremhRNjNUNnh0ek5hK2dQWTIvZGwyeUYyV1hL?=
 =?utf-8?B?N0MveTNIdEZZUmtMMWdNWUMxQTVlYlhqU0kyMXlrNWZSZjljeGp4V1ZkeTdI?=
 =?utf-8?B?cGpqWXM2MlZZRUtYSzROZWhxMzNndVd3Z1Z4OHpXNHE2aXV4ZVRoSU4yUnI2?=
 =?utf-8?B?L1k0L2FvOHRCVm5BSURldE02ck0xcVgzbW84bFI1cGpmWWFoQ3BJL2xtNys0?=
 =?utf-8?B?Zm1pbFBUR1k1T1pJU0ZqUFNZNVVEQkk4ZWhWUU9rbmZBU2prTmY2TjFJb2tw?=
 =?utf-8?B?WjkxTHcvNHNTTHBtUElFOHFCUjJvajUwMlFES1NxZjVQZXFFbkY5c3VVUDZX?=
 =?utf-8?B?enlNWjVNWlJUa0tEY2U4NEVubjNEanIwdkVxVWViN21iRm9NNlpDVE9objNq?=
 =?utf-8?B?ZU1hOHBaYlhISnVQSTV6cFFGakVzYXlsOXI2NkJ6N1E1WStOM2V4Q2ZCUGsy?=
 =?utf-8?B?c0QxR01Nb3RBUm5EZVRqWUgyYmQ3eVZtVHhuekJXeUNDSnJMajBKQjlpWXJ2?=
 =?utf-8?Q?y0opiAfMLqsRikEThgcbh+ZpsvqL/uK+BOxsdZO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VElWTW5NTG5LN1k2TmhLZkh3Njl1MEo4dHFkdytEc0RPZlJaeEpKaTNUSnFm?=
 =?utf-8?B?U21BZWZVL0hPVGx1QUJ2b3o1U1d0MFlWc096TXpPSm9pcWpCSWoyV2czZzFp?=
 =?utf-8?B?ak5qbkpTMGxKNkVzTWxnRHZ1WjhrOE9jYjRtUzB6alZlWTZwSUMwdFlxR1Mv?=
 =?utf-8?B?bitPMjkwWXp2WVgxZklXL05OUTFmL1FuMFVmUUZaa1UzclNoNnFmWXpyb01B?=
 =?utf-8?B?SUhSOFJoS1ErWlJiejlMb0ZTc1ppb2xSMXk1dGY5U0YvVU00U0hvbWkrVENO?=
 =?utf-8?B?K0pnN0k2V3pleUMycWJEU1FibHJtV3JSc3NsS0FhcHB2bGRpdXhkMGw1Q1U5?=
 =?utf-8?B?WSt4V1V0ZkZBRnlMaFFqWEZHYjBZMEw5TE5lWGJwTDhHaiswbFRVL1JhYlhP?=
 =?utf-8?B?eForNlRZUXlxeUhFdU92M3pDODFTRWhYdHlaVFRNTEpYSkpQc2ZFbFRJMDF0?=
 =?utf-8?B?NVBoWXhFV2liYzdmL0pKanJPNUE4b2lqMjF1Y2pjT096RmdwclAxK0VzTUdK?=
 =?utf-8?B?NE1QeFF2bWZPQ2NHcVpIdXJ1VUJGYmFTUXRvdVRqc3VnOW9TQTcwRzMvZXJa?=
 =?utf-8?B?T1VNVmlEalRQVVl1ZHVGMVdWeHpraURuaHlFR25VbVhaa3hkMlFpSVgzMWdW?=
 =?utf-8?B?OUxhK3YrTjk2aWlWOENicXIyL1lnZDJHU1c0WGhRMkR3cGF6aXZpYWh5NDd6?=
 =?utf-8?B?WHgvZlc4NFNlek5rMVY1M28wZWJIREh5d1dIVGZaT0F4N2kydU5MZ002dnZx?=
 =?utf-8?B?TXJVOVIwWFdlUFVaTDhRRlhoR0pjVHB5bXVmRGtHSkc5T0drQkVRazROTFQw?=
 =?utf-8?B?SmpFWkdUc0NFRmFTa2tLaERtVW4xTWNnN0o1SUpQckEyR2hlazgrZGN1SnlS?=
 =?utf-8?B?K01xYko1VjB6dUc4bnZOZ0tkNndjNjNhVmVFVE5ITGNOcVd4RTRnS0p4emhr?=
 =?utf-8?B?dEhGSXI0OUVpcURLRVNIZ0JpTHY4YVUvaU9OdTN4WTBGcHR1NjBSRXYwNlhF?=
 =?utf-8?B?ZnoxQ1dtTkh5cWJYbjBKTVljc2pEVkxGdnhsa0FWTWo4M3ZDdDlNd242azQ0?=
 =?utf-8?B?TjlEajdUSmU5a2p0QlJWaU00K0psRmowd2s3TlU4QmJOSithV2tTOVMzbGY0?=
 =?utf-8?B?RnF0MEY1ajcrODZ0RzNQaGVBb0t2TFVlZUU2YURVTnZPYUpaMHdxZm8yUzZD?=
 =?utf-8?B?Q0lmdWpTSEtJV1U1TDNpSGxiTTBLSXNrU1A4TFZ3L0lCajdtU2c5Q1p1NjV6?=
 =?utf-8?B?dTluaWJta0hlTlBZdDFZUnVGKy9KMEFLdWpiVlVHcmc3ZUVsVzFtQm1pUTRs?=
 =?utf-8?B?S1ZEU0pURS9xUlVVRWdUYzZnYlBMUFdNd2dSVy9wNHFGTHZ1U3EvWU80akNP?=
 =?utf-8?B?MXlKOWtqZE8xY0NhWTNuWG5pdEJFNkg5RDBPSFprS2RVR21iYUgzdTA4cWZr?=
 =?utf-8?B?RkFaTUhORUdCWTdoWGFWdnRrWDlJWGRKSEc3Q1pKcjZMazdueDV0SFdwUUF0?=
 =?utf-8?B?K0lIRi9JT0F4ekZpQlBvNDZDQ0lxUmcwck9BZCtKRWJtZ056bWNzUU56QVdZ?=
 =?utf-8?B?TVZyUFYzT0RGb0FLOGxneDBuazVwRXFYMHRQRHRrbXVONzFUWVJJSUFwaEJm?=
 =?utf-8?B?dGRQaTVuOUVDcFIybkZhQ0JsYmgzZmNIanVva24rcVlQNDFKc1RMb0tBamNz?=
 =?utf-8?B?YkhrS2lqYjRXUjJ0bWpmcEhFQ3Q5R3YxMDBkT2dSWlVRaitZUzh1MFk3eGUv?=
 =?utf-8?B?a3JoN2c0WFMyWDZmWjhQRVZyWW0rY1AwTUFSeUhVemRvSXd5U2VkaHZBZWRO?=
 =?utf-8?B?b2Z4ZkNIZHE4YndMcEwyRXM0b0V3aVk4NlFRWEozNlR1dTlvYnE1M0NrbnBs?=
 =?utf-8?B?SFdlWDlUY2tTbGJCcGphQjIxMHE5NVZMMERVRnROMlc4WUZBcVphNmNBV2FL?=
 =?utf-8?B?Z3pqS2dxa0xFUDdRZ0h4c2VVcnJkWFQwdUVleGFHNkZPRkRnbWVWdDJQWWU3?=
 =?utf-8?B?QkgwMUdtN05seVRvbUJwelh1ekE1OFdheld0dGdJWFZ5azcxcFU5R2hKYkJY?=
 =?utf-8?B?d1VMOWkwNHZ4TGEzZnhnWWlJTzBOWTA5YlBseXh4TUVHOUxlb0s5bzdIbGp5?=
 =?utf-8?B?UENoQTFXZE9aSm1hT1VyS1gwNHAxTy9reURLYktmK3dSTGxmZEdNbGV1VWFk?=
 =?utf-8?Q?EM8hwNMjcGOp6zek4rw4WUA=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80aefd6e-8cb7-4983-5c43-08dd71ff6f09
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 16:00:05.1536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h7O/Ub36A/RLhOUQSUQQdw2ZDvYdzmjH1CUybx8SvTUNE5bdZUT3DS19b2OdzZCXWwZ7A16hxPG051JGjinQUj3WhGxY5h7xkDdDPNb3VZg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB5307

On 2025-04-02 11:49, Steven Rostedt wrote:
> On Wed, 2 Apr 2025 10:56:51 -0400
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
[...]
>> Please let me know if I'm missing something,
> 
> I guess what you are missing is that the code no longer is aimed at having
> vmap_page_range() ever get mapped to user space ;-)

Thanks for the clarification!

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
