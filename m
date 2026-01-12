Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020094.outbound.protection.outlook.com [52.101.189.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1DA26CE05;
	Mon, 12 Jan 2026 19:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.189.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768246681; cv=fail; b=jPeFxD7oBS5FZSO+5gjNVP9+2HgQ5Ctw0yo+T/SaRucMzgC+Nn/h3vjHp0fgyV76j7gWEfXtvcLfRBWRVfEIhZkW8MNjcnlZZCiw+ay05f6Azdo1unxMSPtnLq7uIfXHnWwMzSARjObF71ex4xXOPfrVEcvIRZtrLQUEaplsIp8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768246681; c=relaxed/simple;
	bh=qsGS5sUPO5m9gmgXsdHjJRyP6omJ2rJ98/GKECzCxjo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=d3D2A+jAQVpqeV8AXCXt2u/cqSKvH4bkqA/zAXaXDZeQjUaRA57E9y59C51dkS+V4KTfrvINhPB9HhQ401WF3yxSbrbtsd4nN2o+VsvueXdTY3mwX7RQtCBddZJs4YVsVa/kceOLqCJnb03PpohckwIkMDH40hcz5v4XRIqB+HQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=CZQL0hX3; arc=fail smtp.client-ip=52.101.189.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="CZQL0hX3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=msX4C88gpPE83sNbO3TvtR14UVGBX6xAwI1jIr0z2Lk2uFyJf7D4BW1H3IJaJA1//KOIAABgPNsvadYSLYJmX2hpHrb16/wichZrLAYOwWDS48pzarDTG79AVt22BqBohYbjo/txD68aHPes1NXCGWNKHXOEk2pJaDu7AU8rUrSpJZdC9o9U6Efa3JiNa4pRMpAb6lc0XeXTC4Cfrg6VD1BjeUm+A7aMwnQKaLn7C5LuyzQH4WovZTsEe62ZLVhKd8oLBsDcxBd+6POF4doc2USbhkSnEE6KK9OVgct9W2EFansYsWunuIRFAjxKpgToXc5MoRrJ1JY2AITQv1ktSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J+OPPeJ/Ahz1IkMekuQwWVijh6HerayVvJzppZ92EsQ=;
 b=EqYJP/tiQyvqvjpXYbXipic6K9Etcvgq1+O6QzhtR5xosiaGpluZIIb2Crv3315vofUICrrheB281SnT9dU90LpqBXfLR0dsma8uL9GwvirxOaIp5WeHFztbVimulSeIj7qfgACGTI/hy10SCUs8sosxyVF6iFfvYoGWcHl7gsndI3PfsYUeq+Tlf92JewhbeK7cMzBqJverv+kbaDarwYKrbh1WZ5mPy54ILJmg3ncla9uiGbMC+CgU0rQf6xKhpEw4uvX0+6viGH1boPhXQxHkgwwEBhP9JMkyjvtw37YnT6y0CdA7BAgYB7TZQIPVungc9aObb35gx8AtnSpa0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J+OPPeJ/Ahz1IkMekuQwWVijh6HerayVvJzppZ92EsQ=;
 b=CZQL0hX3Qquc43sxBgkJfoypoY7dcHFR67s8RQS8XHETiGty0DTS5i513kI6Js/UxAWgGCletxnNuXsb5SE6obaMCByXEm0PIbWzwnUp33vwe5H9G3VmAUGvB207kIvhGWW02AdbtfB//vPjd8/2IhVr3U4XkcE8TCqzyt/XootLSj299et1dAytE5lmp2MOHv926b2MJb50oQs2a0e2Ssf6uccdfOl06ZKcUgMu4Fzd7j3zEZIIwX8xPUsKTYPB/S9+faBD5rZagzU5qDMCHAc581yO6xpvqU5SYnUtkWLK7X2h+IBwdvey6CeuDoZ/uplI+WYZSs909i4YwN3UAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT4PR01MB10616.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:106::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 19:37:52 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1%5]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 19:37:51 +0000
Message-ID: <f2c04264-17ca-418f-bc43-e8aa6fa6cd0d@efficios.com>
Date: Mon, 12 Jan 2026 14:37:49 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 2/3] mm: Fix OOM killer inaccuracy on large many-core
 systems
To: Michal Hocko <mhocko@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 "Paul E. McKenney" <paulmck@kernel.org>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
 Christoph Lameter <cl@linux.com>, Martin Liu <liumartin@google.com>,
 David Rientjes <rientjes@google.com>, christian.koenig@amd.com,
 Shakeel Butt <shakeel.butt@linux.dev>, SeongJae Park <sj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R . Howlett" <liam.howlett@oracle.com>, Mike Rapoport
 <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Vlastimil Babka <vbabka@suse.cz>, Christian Brauner <brauner@kernel.org>,
 Wei Yang <richard.weiyang@gmail.com>, David Hildenbrand <david@redhat.com>,
 Miaohe Lin <linmiaohe@huawei.com>, Al Viro <viro@zeniv.linux.org.uk>,
 linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
 Yu Zhao <yuzhao@google.com>, Roman Gushchin <roman.gushchin@linux.dev>,
 Mateusz Guzik <mjguzik@gmail.com>, Matthew Wilcox <willy@infradead.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Aboorva Devarajan <aboorvad@linux.ibm.com>
References: <20260111194958.1231477-1-mathieu.desnoyers@efficios.com>
 <20260111194958.1231477-3-mathieu.desnoyers@efficios.com>
 <aWSz5OHBwtfYrruu@tiehlicka>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <aWSz5OHBwtfYrruu@tiehlicka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0111.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::11) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT4PR01MB10616:EE_
X-MS-Office365-Filtering-Correlation-Id: ae72f84d-b569-47a8-e6f3-08de521212ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a2tvM0NTaXU5d0FQVzVvbEZRNUM0SkpheXo3YXdwN0RRNndGVDN2YitEcDNZ?=
 =?utf-8?B?OVlNeGZZNk1aeHJjdzN5OFdIRnNBaTFqN0p1UEFpdENXTW9rLzkzODhkWnp4?=
 =?utf-8?B?Y0pNcEhOazF1SWIwSGFudEFOUnpZUFJCMFc2K1BxUFNtTjNjY21kM3NBelhu?=
 =?utf-8?B?c1diSS8xaUVlbFh0b3dTUExQbFRBMm10dkkvSC9UcEpndjJ4dzMxYTFpZ1Jj?=
 =?utf-8?B?RE42cEY4aGJhamllUlZWUGtMTGRxT0hzTU53N3lSUWV0U2YxMTZmenFMSGg5?=
 =?utf-8?B?SDdKckZYbExENVN0Qm16cTBNaUpYWkEzRk9hTzFlY3hwSXdiZUVvU2VaaVFr?=
 =?utf-8?B?SUtPL0tMekdwRDZobUlqWGhxKytEZW1la0xNYjRZMWphNmNFMkE1a0dMOWI5?=
 =?utf-8?B?TEVHd1VCRm5NUlIyQmFhNFVEVE5TYnRZYUlMaUlkZ24yQ2ZTbUQxNzdISjMz?=
 =?utf-8?B?U0NjQ3I3L0pVNmZ6eEtuRTh4NkZvR012bWFSbVl4WmQ5Nk5DUUVzb2lSeCsr?=
 =?utf-8?B?bXRaRFpCbFFFMmJkWGk0dHJqcXpuYWM1ZUQ3RUo2QlRUU2JBK1J5S2ZQdGNB?=
 =?utf-8?B?bzdJL3BpaFpXamRya2IyTjJOaVlRbFpFSmF0eGFidDk3Z1FkbjBPaWx5MlZW?=
 =?utf-8?B?bWcybmduM3pUNDdlUnlKMDN1OWZuQ04vSm83bU9tZ0VFajlpOUhGQjZ5ZjQy?=
 =?utf-8?B?bW1Cbms1MGhSRnk2TlI3QitLUUFnRmY3U0VmKzlaNlQ5VWdZU2tCZW5ZTXBH?=
 =?utf-8?B?NXdickJZakFDd1NVaUgvSXFiTERxdmRBbHJxWkVNb1V4em82VDVTYUZIRitl?=
 =?utf-8?B?MzFIeGJxZXlDZFZVQW5YNWVPZUhwMy93cE43UzlSTWtnWVQrL1BJOUVsNFRy?=
 =?utf-8?B?akdRK3l3eklEdTdGaGN6RkNsR1J4aS93NVM2Tkd3RlUxMllVOXJta0RIRElL?=
 =?utf-8?B?dUJKV2l2U1Q5VVNRNU5JMmNDRVY0aitnTWx1VXk0OGlhTW1GTGRrTC94cUM2?=
 =?utf-8?B?ZlFCWlVIM1VENzRXa2pGdllzazZsc0hUVlVMUmFkZkdaaVdQS3l6QkhQenBZ?=
 =?utf-8?B?OE9wMGd3R3VidVlzUTIvaGF2dWt5cDdHWXRZSGNmRi9mVmtEWFlzZjJaa0M2?=
 =?utf-8?B?cHJQSllyMFI3cnhacUR2c21ZbmNqNlg3NlVUQ2J5QVp3YWRDMTNMaklLZmt4?=
 =?utf-8?B?cloyNVZjNThXMTkrTmZoNkVSZitnbVdBaU9QdnFoU2VUNk45dzZnTVlQVkg1?=
 =?utf-8?B?UlYyeFVCK3pMcFRpcVJFczNWZTh1UHhLLzRXbUtZMmtueHpsMWhmSEJUaElr?=
 =?utf-8?B?TUdIeDEzWmRIdy82OHBZN2ZXRDZaK1VyckJ3WkV3OUFiRUVjNTlZMTFqUktt?=
 =?utf-8?B?U1JIa2k1QXJMNklkdklQdGJSU3pqU1dPM0VWUlllTlFXZGVnK3dJRGxaMVlF?=
 =?utf-8?B?UldDY0dFS3Iyd0U2bW9BemFodFZNMExGc2tSWkNZNXNVY0F6KzBJbm9XR0s1?=
 =?utf-8?B?djBsRE1vdnhmeDNmbVZ5b0RZWmE4NUk1akdLS3BBVHRhN2VRTExLWU1DeDl6?=
 =?utf-8?B?V0haNEhrTmp3QzBQdklyYVZlT0pmQVIzSTdKUFhpamh6a0NndnZvM1NDSXIr?=
 =?utf-8?B?d0g4ZDd0YVB3Um5HakRYTkhEbWdaalVsVDdZTWQ4ZkpuM0ZFQVpKajJIT1Qx?=
 =?utf-8?B?KzYzSDdDZ05oT1g3b3dBOWt6NDlkazExWXU3YzZqQmo3Wk5MTVdrQjRFWTVL?=
 =?utf-8?B?bDJHY1NCblNsYjhJU2dnWGt6WnNDaVlTek1ydm90NTVHZHVNTWNMVSs2QnZH?=
 =?utf-8?B?M2JFcnBxMmt3dnJVM2M3d2FGc3lGaktJT2krWDRjeTNwMkwwV0tBWS9BaGxC?=
 =?utf-8?B?N0xScnZJUDV0MGJIV0pUenVZOFEzYWJMdjdsbXVJUUdQT0E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ylc4UG13eVV4aitmQnRxV2FLdkRGa1VLem9kazUxRjlIbkpMM1pYcGVtNzhw?=
 =?utf-8?B?NEhqSk5EU3FueUgrZ1pYOWY3ZWlnWGxia2txZlRRZWd6WHV4Uk16YkgzcHgw?=
 =?utf-8?B?TXdFRS83QU1hT0N3UEtyM1lkSUE4alNtS1orYWFwQUQzbzRzNlo0TnVoalBS?=
 =?utf-8?B?OWUwbnh2S0c0TlNNMG9oUEJlbDNya3dLaXhKNExUdlZrVGhaMFpXdkhJdDY5?=
 =?utf-8?B?Yld4bFBXWERoUWRlL3Q4NTNHbFgxbFc3dUlLVmo2MTlFSE1peS9HM3F4dzh6?=
 =?utf-8?B?V0Y5Vlo2WnMwVG9ZT2pZV0x0QXZlMnkvc0EvYzduaGt2Sk5PV0FOeC85UmJo?=
 =?utf-8?B?cEErY05ETjdRS2w2MHhkV1hkU25vdVk1SHFuL08yVHRtVUV2WkJwekdoYVNB?=
 =?utf-8?B?dUMvTXBCcndHMWZOb3VUTVFNZ004QUNZWkZZT0JxRmtXYXI1ckI4WVBQdDV1?=
 =?utf-8?B?b0s5c2k2T01PSGdVVGVia1RNUW43cGtkYlV0eTI1TDNDZ05WUVUzeE1HUzdR?=
 =?utf-8?B?dmtzQzNCbU5kbUU0Sk42YURlYWEzdWJiQ3NnQkVIcDRjV2VnUS9xTmFhQlBL?=
 =?utf-8?B?b0pscDlGOFBWN3praXFWK1d5K1hwdlNFZGE0ZGc2ZngrMnh1ZlJqekc5U0do?=
 =?utf-8?B?dDVRaUhvZ1F4OHFLRXl2R3FFbnpXN2NKS1pQWjRESmhCTEY1OHhzNm4xbE5C?=
 =?utf-8?B?N3NMbU0xUnphaFVqNlZKY2Jlai9yS0hDL1BlWmNFRXFMSy8xTlNtK1ZTTFdl?=
 =?utf-8?B?dm56TnBlc3lmV241TFBjaVE1Tzd3QU9UaUlzK29NRStiK28wTkg4bVNjY2pr?=
 =?utf-8?B?VUloRFhINk9iaDJrZjR1bjBjMjJUMmZ6cW1qVW1hUEl5RCtJMTVZV1BaaEl0?=
 =?utf-8?B?TTJCY25nWkhtUVd2UFB1VVlaN1NCTXczM3dnWm12UDBSUFd3aGhac01kY2Vj?=
 =?utf-8?B?K2t4MTFSWFhtQXBaR05xdE4rVEJTTEtlUkk0bjEwYkIrN1p4dExTYVd0UUNU?=
 =?utf-8?B?OVQ1SVVlcktMQnIxTlg1THZuSTF1ZTRhN3locCsvd3RaZEgzQ2JudG1ROHdK?=
 =?utf-8?B?aWVKOVA4V21wcFRCZm9xQUl5LzBTT1ZRSmJlekxFbGtSSmFmV01DZm5LOWhY?=
 =?utf-8?B?VWhTZUdJeUdXZ3R5djNZZzFhRE1CcCtFMG90WldMelNrSUgrUE9ld0l2MUty?=
 =?utf-8?B?OFUyV3EySHg0THhSMGZGSWJFSlUvdmNuaTZmNVRldTdOV3NZMVI4dW1PdzY5?=
 =?utf-8?B?V3J6MGsvNG84ek54TFpuRnZsbHUxQVhLODVlZldpUFhUa0hRR3FqcGpWRGlK?=
 =?utf-8?B?MGxCaTZGS050aEZmdG9vMUJHaVAybzlMalBlVmRsNGVEZjdTRDVKbytKeWVM?=
 =?utf-8?B?c1VkZEQ4ZUxtbTZrWmNTMy94czFGV0xJTlJpNDBXYm9idW42N1RiRnB6NnEw?=
 =?utf-8?B?NHBBN1c0VVdSQkx3WEJobzF6TEE0OGExaHpmZ2tXSXgwd2M5RkJLVVhnR1Z2?=
 =?utf-8?B?OFYwNDVqZlI1bkxnTGRDM0hFQ0YwN2hmK2QzUVo0SWJ1NGFSSE9JUHVYanZP?=
 =?utf-8?B?bnZQRnhPNzlkVk5aMytYSkJ2L0RPbnI4NE9vd243c0U5MzFwOWtnQmFWVDF1?=
 =?utf-8?B?bmJlb1dnRVh6TVBidEl6UWJXY2FNd0hPeDV1clFYa2tNblRLeUlaV2dTekRQ?=
 =?utf-8?B?Nk1ialJSMHAwYUNiMWpYR1NjakJSdXBHeEdUd0JmMDFvVkREY0JmUVc5VHMw?=
 =?utf-8?B?UWJkK1hUNXlpSVhpdHk0T1hZenc5eUcwdEUyOCtVOUkzTTVxQTc5WnNESlNi?=
 =?utf-8?B?T2U0RWlOVVg3akoyMmRia0RmZ3UyVVlrQjFGUmlHYjJVYkFYRTBNRk9WeUZ1?=
 =?utf-8?B?MDBQNENQaU5RNjI4cjFkNm11VDJpU2IxRzNoRkI4cnhySVhQcmw4NjNoajhp?=
 =?utf-8?B?Y08vVGxDYTVFV2JWTUlzWXR0bDZtSjZRMHora2lXVUEyaHFWSFF5cnVXbElE?=
 =?utf-8?B?MHo3dktYYjdNbkQ0YitES0Q2S3dCL0JXbHVZZ2FIY0VqNUVJQVpEeXovcWpp?=
 =?utf-8?B?Z05Qd2tBOTRuU3pJRC8zOUhYSjlveUloR2l1OElwL3V1QnRScmZwRVU5aDhY?=
 =?utf-8?B?KzAxTzdSMm9rcWRjZ2N6R3pCRmdWWHFVRXAzRlA3MVZEbmoyU0Vwbm0vMDlJ?=
 =?utf-8?B?a2FCV1ZjdjUzdG1KU01sUGtIUUJyQjIzZnBNeWdTVXk5K0FuNi9TTjBmRkxH?=
 =?utf-8?B?UHFpTXprdU5NdnJQbGhEUGdZNFY0QXpMRDJRY1A1VjRJaXVOb21rTTg2bko0?=
 =?utf-8?B?WHk4a2IrQkcxZ24xbVJqNEtVTkl6bC82ZlpCTC9WSFFFalJJVzNUOFE5Sms1?=
 =?utf-8?Q?jU2uHrrc2zK7MU8k=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae72f84d-b569-47a8-e6f3-08de521212ed
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 19:37:51.7767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S+Y5jXhNDgNv/fNutRSC7CI2QTDMBT0WgXcnbVLa0JB+4bNJCPe0Y376OitLgZwttyFEgd/y93h/VPCeWis8tvCZ9iLZdHSyHXDOubHkdhU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT4PR01MB10616

On 2026-01-12 03:42, Michal Hocko wrote:
> Hi,
> sorry to jump in this late but the timing of previous versions didn't
> really work well for me.
> 
> On Sun 11-01-26 14:49:57, Mathieu Desnoyers wrote:
> [...]
>> Here is a (possibly incomplete) list of the prior approaches that were
>> used or proposed, along with their downside:
>>
>> 1) Per-thread rss tracking: large error on many-thread processes.
>>
>> 2) Per-CPU counters: up to 12% slower for short-lived processes and 9%
>>     increased system time in make test workloads [1]. Moreover, the
>>     inaccuracy increases with O(n^2) with the number of CPUs.
>>
>> 3) Per-NUMA-node counters: requires atomics on fast-path (overhead),
>>     error is high with systems that have lots of NUMA nodes (32 times
>>     the number of NUMA nodes).
>>
>> The approach proposed here is to replace this by the hierarchical
>> per-cpu counters, which bounds the inaccuracy based on the system
>> topology with O(N*logN).
> 
> The concept of hierarchical pcp counter is interesting and I am
> definitely not opposed if there are more users that would benefit.
> 
>  From the OOM POV, IIUC the primary problem is that get_mm_counter
> (percpu_counter_read_positive) is too imprecise on systems when the task
> is moving around a large number of cpus. In the list of alternative
> solutions I do not see percpu_counter_sum_positive to be mentioned.
> oom_badness() is a really slow path and taking the slow path to
> calculate a much more precise value seems acceptable. Have you
> considered that option?
I must admit I assumed that since there was already a mechanism in place
to ensure it's not necessary to sum per-cpu counters when the oom killer
is trying to select tasks, it must be because this

   O(nr_possible_cpus * nr_processes)

operation must be too slow for the oom killer requirements.

AFAIU, the oom killer is executed when the memory allocator fails to
allocate memory, which can be within code paths which need to progress
eventually. So even though it's a slow path compared to the allocator
fast path, there must be at least _some_ expectations about it
completing within a decent amount of time. What would that ballpark be ?

To give an order of magnitude, I've tried modifying the upstream
oom killer to use percpu_counter_sum_positive and compared it to
the hierarchical approach:

AMD EPYC 9654 96-Core (2 sockets)
Within a KVM, configured with 256 logical cpus.

                    nr_processes=40    nr_processes=10000
Counter sum:            0.4 ms             81.0 ms
HPCC with 2-pass:       0.3 ms              9.3 ms

So as we scale up the number of processes on large SMP systems,
the latency caused by the oom killer task selection greatly
increases with the counter sums compared with the hierarchical
approach.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
