Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020100.outbound.protection.outlook.com [52.101.189.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6716320E328;
	Wed,  2 Apr 2025 15:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.189.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743606215; cv=fail; b=gRC8fSYHfaOLBMqO5NP9tlcJFbxsMmnZ3LZHjDPSNqbG36LRg8KdvlleeZpAMXKTHmpfAKqrdfPcRrr0BGwO4AMiJv2KdUJj7Kz6gZQ17BV7x8hb9ATeTys265Sik3ADIAjwOTFK5bfs/USoJfBzhNNWFvkdZ5mYWLTG3dbml+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743606215; c=relaxed/simple;
	bh=mXgf2aW5eL6bWvP38yzPzrbMvBteKD8LJqIA1o1strQ=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=s7uHHUsfjc/QaY911M3mf0EgyXi5pyxqwOD2pknCuK1IeldAowSdofopEAm3jqXuv3YgOkvCp8k/Q5uYir0cGA1c7NFxwvgzpj3U2S0GDXFGIqwz+UcYjI8jhc1NihDVkNiOOog5/3Ut3A9YUsWY28NsJmgHXpyiIVJQPiNycGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=UchLVe3f; arc=fail smtp.client-ip=52.101.189.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="UchLVe3f"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KMUVVvhclb7Ls16MPqIis9b9cTtTdQtxeUDF43BQMSxq/gS4fCqbXfGIcQMyn+qDyjEJSu4PpfqHqOklW2LV4fEfvwEkfpgjM+8E3pWjD/a1ucrCYxkMZvgJKPdDOq//D1K6aU/XaYz6cwbijNWy7Z2RmBwvaxYp/+GxFaU6gbRwsIoqjtksxiRE9PzHI5ZD3YX8ug8fBcZMFwHY5vOUbYYxnR4wF/+tSelMh02NQa71QFsvclsPCwPmNPqs0VMOBCECQjjFkgR56vPHh+q+tETokaL52ZXsBVHpbTONG/6FYrNDRshlDvFqh3I/C+/wnl0udlJs0xG9U3a8si3jqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vYQeAuXnt729Ma0bTQOtUCeGZ8F7csjG/7a/I4uU5O4=;
 b=QBR8CdlM9W2fZqMJvsl2OzlY1tLBffjEObRioftbIX2js5nCdGh5Sfvb0RylF2OFhODmBMynkb3n/X4ngc+/aPLtW9bMTltSQ5l/m8zl5/Zy3Vl9NQCRJUiG53KQDuBewqMnwL8gBBIE9RnqIg8wD0D3PguriD+FKrM1IstEb7WFK5BuSRYnisD2BKxvt8Y0pFEwGyo0CPEgcIBWqdlq6607O6AvhjAqZKk3ih7fp1iZhJqhEOpq+qR6ZA4x8PaQr7bCSyGpyzBwTmNJ0w/oyrmcsoO2UwIftGSEd7DytmYJ2/TeLvv6okklQJJwT7pqY50lZQ08WFzKSMNfZjT7ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vYQeAuXnt729Ma0bTQOtUCeGZ8F7csjG/7a/I4uU5O4=;
 b=UchLVe3fIn04h+uSMzVgQokBhJ6+lIbAhbci+FHYQiYUZuRy89ZZbJflxTQWwE4Vaoy4SjoNZUe00TzlFVtk3lhABNcI0mfP5NPdS/lN6rqNvwrtWL9RnU708zViO2YCCo7bMpRLP3O4XBVWPEsKc5L5EaVof+9DxAmQz+XdjYf3l92q3Yh2um0mYtay7EuAbwoXXE59cPddoQfjXhe1PSqR4GlGi8VMuISNUh9QezkSDxRaAMiL291h4F2UTsxRE+nSCp3Oq7AUBXCx7OYxNevQORyogWSymkQ9gy7kdMJbKFd0er1so+7lD7dm1P1i8Dj1FOr2EuO6ut5/48CC0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:a0::18)
 by YT3PR01MB11060.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:13f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.50; Wed, 2 Apr
 2025 15:03:29 +0000
Received: from YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::5393:fe91:357f:3ccf]) by YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::5393:fe91:357f:3ccf%6]) with mapi id 15.20.8534.045; Wed, 2 Apr 2025
 15:03:29 +0000
Message-ID: <2bf00be2-9ab9-442b-b68e-04ae7075ed1f@efficios.com>
Date: Wed, 2 Apr 2025 11:03:28 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/4] tracing: Enforce the persistent ring buffer to be
 page aligned
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Mike Rapoport <rppt@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Vincent Donnefort <vdonnefort@google.com>, Vlastimil Babka <vbabka@suse.cz>,
 Jann Horn <jannh@google.com>
References: <20250401225811.008143218@goodmis.org>
 <20250401225842.261475465@goodmis.org> <Z-0BrT-OxGvaWM1H@kernel.org>
 <a9a816d8-ce2f-4c89-a798-ef565febb906@efficios.com>
Content-Language: en-US
In-Reply-To: <a9a816d8-ce2f-4c89-a798-ef565febb906@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: QB1P288CA0028.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c00:2d::41) To YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:a0::18)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT3PR01MB9171:EE_|YT3PR01MB11060:EE_
X-MS-Office365-Filtering-Correlation-Id: 977b6bd7-12b4-458d-fb30-08dd71f78715
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eVU2SlZzeWRROXFHcnVLaGxZbHoyOFdDU0VKbHZHek5Vc0RPa2VReHQ5eU9X?=
 =?utf-8?B?SFpuMHJad1dNMzI5UHJPTFQydHZSWlBBWHZTQUFZNHdwQTBGOVl3a2xrNjlG?=
 =?utf-8?B?OFg2ZURPOW5mM1JDWEgvUXNkSzRHeHA3OGsvbXVoeVBKMmE0QlQxeER0Si9h?=
 =?utf-8?B?QVNieGd6bS8wUDVqUWJGbjdPNU52cVJhR25LL2YvSVlvOXRvcTA3Z3pMYkQz?=
 =?utf-8?B?Zy9LSEFvMy9ZZTVVazM2U2NVOXV0MHIwdlMyQ09kZERTQnVuSXdQZHFrcmdt?=
 =?utf-8?B?VGFqV3FyN2VDdkF0UVM4ZitMbzJiYVVMekFqakJ2RkxNbThmczVtazM3WE0v?=
 =?utf-8?B?Mm84NlZlWDhXajd6dGNDaWpiTCt1WEJCT2R3VDZEU3VUbXVjVUVMYzBTYUF3?=
 =?utf-8?B?WWZrVGJNSHdIUVdaWGxtMWJmUHlMVDlUenpFcnZkUDU4ZHVPZC9pYkgyQjQz?=
 =?utf-8?B?QkoyKzdZSXY5VDRwazhKeWNZNmFrbERMZ3lyTGJ0RGJLZXJYaGhpNlZXN05v?=
 =?utf-8?B?Q1BaY05IalBYSENEVVNqdG82ak1hUDRGSXNjM0JLOGZIYytSNHpGbThOVEpR?=
 =?utf-8?B?V0tOeXBLcTMyS04xMkY4aE5SVUY0eGYyVXJYaGRKZ2xZTmhXakdhWDhJdWxQ?=
 =?utf-8?B?U3RLTVRHWmU3V1d1K0NKeHpVN2Z1SnRLeW5mSlVldWhHbjhKU0V3ZHZHaDAy?=
 =?utf-8?B?R0I4czM2aHgwSWhnaUZIMS9wd2luOUU4eW0ybUtyN0RId3BGVEt2WG5oVjkr?=
 =?utf-8?B?bmpSSHpqNjR2OWUrNGV3ZmtnRFdJT2twMXNMeHpwYWtPMU5XUEp5bGE1M0ZT?=
 =?utf-8?B?M0pXQzBuQkdZSUVpSGxCSExjS05iTzVFR1VIQVlmT0J4b0M0TkVCUHFaZjJP?=
 =?utf-8?B?cHoza2dNR09MeXJPbkNYYUczMG5NOGZGeHVIb2dmREd5Zy82Vm0xWEhRYWJo?=
 =?utf-8?B?TDNGVVZ1OU9JMERpM1ZEL041Ymp5OUhFZnZodTBJeHpNYS9seHhncFNvY3I4?=
 =?utf-8?B?YVVyNXIrY3ZZV0Z2VncrQUYyRjNpdGVFZ1pxSlJ4Mm1WK0thQWtlZ0pPeFNY?=
 =?utf-8?B?dldWV2tkTlhySWxnaGttb2NWNDA1d2xmY3gvcEhWTjk3ZldtOTRNN1hMY1FC?=
 =?utf-8?B?aFFVOG1RZHlVUmRVdXg0SU5LMldOM0RBMGdkVkRvaVdvcmQyN2hYYUlzTXNi?=
 =?utf-8?B?UHY2cnBWRmtTelhFdlhvUmcwc0VTRTlwTVFXb2NvZFNYYWwrUE5jRXVMTGps?=
 =?utf-8?B?SE4wUVdrem95MGVHaVhSUXYxTTJwSVVGRnpkOW82anU4ZnJMaS9NNlk0Uklo?=
 =?utf-8?B?T0ZieWwrUHYvZ3V3eG9USWZrZE1tdlA5WmRQYjdBeGdxRW8zbWNsekNvSWR6?=
 =?utf-8?B?RWVpOGVZQks2Vy96a2RuVW5tNFM4TlM3c2NNcXp6N0xQRzc3ZHkwUkNzRnI2?=
 =?utf-8?B?T3pBLytKYjEvdXFwRDJDYUdhTDNqMHlBRHNieEl3ZGYwM3RXUnEwRGZHTlJD?=
 =?utf-8?B?NHBOYWFtV1owamlzTVVyWHlrNTIyYUU1QzJMejlvWjNoTzB1OTFNS2NYWUpF?=
 =?utf-8?B?cHE0MzhHajlEVXNFRE1rWlZTdWpFaVVaTkM2cVBPYWplbGxUREwvcHFiZm9r?=
 =?utf-8?B?RWRPMjI4aWNzaDVDK090dFN0SStWeVVHNHVrK3ZCb2NwQ01PQ2ZvZFUxR2JT?=
 =?utf-8?B?TWk3L2daTk51dEF4OEFlRys3d1RCMEljdDRwSUZWYjA0S0gzYU5vaFZsRjJo?=
 =?utf-8?B?SmsvSTVuUWpyNjdXNzdSelZVZHFKUWlWVFRFS3hvR3VOazhGQ1Bma3VOUFQ0?=
 =?utf-8?Q?uy8a+bgz6xxMkymGVVCATOFBX+nAMisrEWM/A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aUZFWE03NUNaaS9WN1h4bGVNMis3dlcwLzJQU2dzbElUcHRSZEgxRkZqUCtY?=
 =?utf-8?B?K0wwY1VJeHdLN1BCUG00ZHBGNm5vNENqb3FraDF5WVZSeGxaNmVGUTVrTk5Y?=
 =?utf-8?B?S0ZjNUtmNGNaVzNpbWtReVRoLzM5YVgrRlhrN083SjV1Y0k2Q3BWYWIyTU5C?=
 =?utf-8?B?MWZ0SGdCOXp6bFhtT0E2b1ZLcTgyVDJWOVVXYkZkbHpzK3FTUlA3VGQ4VFZp?=
 =?utf-8?B?ZS9vR3gwcjNlRGhmLzl4QzhSb24veVBXMjN4OWMyMDlJd2lJL1JCTXRiTEtN?=
 =?utf-8?B?cGxmSkpIbkx2b014SmVMbGZzdWhrN2pOL1FXekxRNkJmdW1QRWhBTTNaUWQz?=
 =?utf-8?B?U0NkWWhMSVhrMVhKR0w1TjlWTmRORi9rTUNFSEw2YzV4YVFaQUNDanBKUUNG?=
 =?utf-8?B?akZRaEkvMDJwZjFTWUg3dXN1MnBKckJSM3htd2w2MmhrWUY3WEdBbnZIRklx?=
 =?utf-8?B?MjFTK05BZi9UMFpVS0d6dWtyRHdXMkhXR0NIM2NCWEZCN0tkQU9FRnptTWoy?=
 =?utf-8?B?eDdxTUFUSmYzK1IyS2VMR0RneHR4TFhnWGRhY21zTGRLNEFsQm9qNGl6UGk2?=
 =?utf-8?B?M1lselA0cjQ4TUsrQzFETHMwc1prR3IyTTRKaW55S3NHMDIrWW5FbWdpZWZE?=
 =?utf-8?B?OXZWUlR1OGVxbEtadk5sbGpaenhpZ2g3OUh5UklHSGJ3Y0pDY2tqaTFQK0hT?=
 =?utf-8?B?MUhNd2VHemFFcWUrVURjT2ZTaHN6V1NzSWtaNncrOXZ6RnpDSGFZU0t6dEZQ?=
 =?utf-8?B?dmpNMTRTYXlQS3ZYbkp1L1QzVE1ycE1PdjdYV2hpTG9jaXp2MDhyT3I5aTUr?=
 =?utf-8?B?LzBNUFJaam1JUXovYTVCOUQybE0rTThieTZvSmx3Qm9ZUityc09wa2dVTE01?=
 =?utf-8?B?NW16S0hhN0h4cUYyT0VLN1BVcmVuU0VOVFdRbUpJRXNUamF1bEJMcTYvTTl2?=
 =?utf-8?B?T1ZxODVLQnZHdE9wOGx5UVR3UHdTTUJLUGtycGNNQi8vQWVzVFJmVnpFOWFE?=
 =?utf-8?B?OUFGVy82ZUVQZ1JxaDBTcVF2OGRLYnJIVnhINUVraG1hc1RvT3lKRGdyNU5E?=
 =?utf-8?B?N2xtTStUZEtBN3g5d1Fnb2h5SzRUblBUK25PK3FnVGRYaHpmR1BoTlUxdEZn?=
 =?utf-8?B?NkhTUUQxRDBFWnM0TW5ZR2UvcjlIVzFLTjBYZnh0R0svcjBJWE56RlVLczNV?=
 =?utf-8?B?cjlna2tIMCtRRW5mMklFQ1ZkOXZ4RHEyZC8ybjdDOUZDZm9zOVZ4UGxUOCtL?=
 =?utf-8?B?aGUvOFg0RDhod1NqTm11MitpallTNWRqZkRIZUN0UitGOVpub2kxSjBTbkh1?=
 =?utf-8?B?ME02YVJNcHBBVklrOGo0NGFiSEZBaS8veE9tUk1xWVF5ZjNVblphKzdzb3Rw?=
 =?utf-8?B?b2hNQXpneTEwNkF3ZXVXRGlBNUNYMy9rTWZlTWtPT1M5cm9LNkZaTCs2b29R?=
 =?utf-8?B?TmlacFRDOTN2bDZUcDJEWGVIdmdyV21LWWVUWnVXMnJ0QUpVUXhJWkNsd01u?=
 =?utf-8?B?d085MDdhZmFvaERNbkRkWDRoZTI5YXhUN3AyaGxwMkRlVVhBWTE5RXNZSHJ2?=
 =?utf-8?B?aDVBTmxjeHdsM283MVFDdnNOQWhnOHNXVXhRZlZZN0E2R2xWQ0xOSXNXMDI5?=
 =?utf-8?B?dCtObGYwVDlIVHNLNU9JQnNTdWxWK0gvMy9YU3VTWXZrTGhueDBHak1VVUVX?=
 =?utf-8?B?RmFuSVdISFViUzJacDl0aXBkT2NzVXVmVFNQSVVzcEhXMUJ5NWdZc053cXMz?=
 =?utf-8?B?RC9oV3MrbjFhdGl0MGlaSjhYSVJtVXBYQlVab2xJTGpjc2hkWE1MV3VmMWxi?=
 =?utf-8?B?MTNqYUxNMUtKOElvT2V5bU5Idno4NGw1V3FFd2JWdlBYKzkzdXhOQlVvd1RO?=
 =?utf-8?B?b2FHTm9CUnd6YWZWR2hkYmpneitEQnNjaDBEZnhMMFdkcFB6TldwQ0I3WjY4?=
 =?utf-8?B?NVIvcEpBUGFSNlZXNzZVUzQvY2NSMlhDaEdZcHNHZG9MVlFEK1lHYkFmQ1Jr?=
 =?utf-8?B?SVNla0tPTVdNWjJtblJUb3MxR1AxSEkwWlVaTUdZa0RONStKbjdpTVNWTnBZ?=
 =?utf-8?B?dDNPank4NmtFQ2lmN1JONVdKSmFRMGkrQW1OZHl5dmJQWHZWWUJpeXp4aGZr?=
 =?utf-8?B?V1FNTm1NcG8yeDVNNjN3MUQ3ZWg5VENyVlRDWFRFamw2NTR5bldjdm9UQ1ds?=
 =?utf-8?Q?mQ7+r4u7O48acjglnvYB3fA=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 977b6bd7-12b4-458d-fb30-08dd71f78715
X-MS-Exchange-CrossTenant-AuthSource: YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 15:03:29.6220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: obMnvKzu5dZxHbakF7fRrtgvs/eA23nRZtGPSK/auwtX4jG5cVQeLdAc3TNhOyh8d7MsI+SL+g0Zn48Emsh2xaYxn8s8DAjFHRwwxFWnm1A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB11060

On 2025-04-02 11:01, Mathieu Desnoyers wrote:
> On 2025-04-02 05:21, Mike Rapoport wrote:
>> On Tue, Apr 01, 2025 at 06:58:12PM -0400, Steven Rostedt wrote:
>>> From: Steven Rostedt <rostedt@goodmis.org>
>>>
>>> Enforce that the address and the size of the memory used by the 
>>> persistent
>>> ring buffer is page aligned. Also update the documentation to reflect 
>>> this
>>> requirement.
> 

[ Please disregard this duplicate message and consider
   https://lore.kernel.org/lkml/c3e395d7-0c64-44d0-a0a7-57205b2ab712@efficios.com/T/#m461e6111397b33c037f6fb746ed74ffbd0a4340f
   instead. ]

> I've been loosely following this thread, and I'm confused about one
> thing.
> 
> AFAIU the goal is to have the ftrace persistent ring buffer written to
> through a memory range mapped by vmap_page_range(), and userspace maps
> the buffer with its own virtual mappings.
> 
> With respect to architectures with aliasing dcache, is the plan:
> 
> A) To make sure all persistent ring buffer mappings are aligned on
>     SHMLBA:
> 
> Quoting "Documentation/core-api/cachetlb.rst":
> 
>    Is your port susceptible to virtual aliasing in its D-cache?
>    Well, if your D-cache is virtually indexed, is larger in size than
>    PAGE_SIZE, and does not prevent multiple cache lines for the same
>    physical address from existing at once, you have this problem.
> 
>    If your D-cache has this problem, first define asm/shmparam.h SHMLBA
>    properly, it should essentially be the size of your virtually
>    addressed D-cache (or if the size is variable, the largest possible
>    size).  This setting will force the SYSv IPC layer to only allow user
>    processes to mmap shared memory at address which are a multiple of
>    this value.
> 
> or
> 
> B) to flush both the kernel and userspace mappings when a ring buffer
>     page is handed over from writer to reader ?
> 
> I've seen both approaches being discussed in the recent threads, with
> some participants recommending approach (A), but then the code
> revisions that follow take approach (B).
> 
> AFAIU, it we are aiming for approach (A), then I'm missing where
> vmap_page_range() guarantees that the _kernel_ virtual mapping is
> SHMLBA aligned. AFAIU, only user mappings are aligned on SHMLBA.
> 
> And if we aiming towards approach (A), then the explicit flushing
> is not needed when handing over pages from writer to reader.
> 
> Please let me know if I'm missing something,
> 
> Thanks,
> 
> Mathieu
> 
>>>
>>> Link: https://lore.kernel.org/all/CAHk- 
>>> =whUOfVucfJRt7E0AH+GV41ELmS4wJqxHDnui6Giddfkzw@mail.gmail.com/
>>>
>>> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
>>> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
>>> ---
>>>   Documentation/admin-guide/kernel-parameters.txt |  2 ++
>>>   Documentation/trace/debugging.rst               |  2 ++
>>>   kernel/trace/trace.c                            | 12 ++++++++++++
>>>   3 files changed, 16 insertions(+)
>>>
>>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/ 
>>> Documentation/admin-guide/kernel-parameters.txt
>>> index 3435a062a208..f904fd8481bd 100644
>>> --- a/Documentation/admin-guide/kernel-parameters.txt
>>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>>> @@ -7266,6 +7266,8 @@
>>>               This is just one of many ways that can clear memory. 
>>> Make sure your system
>>>               keeps the content of memory across reboots before 
>>> relying on this option.
>>> +            NB: Both the mapped address and size must be page 
>>> aligned for the architecture.
>>> +
>>>               See also Documentation/trace/debugging.rst
>>> diff --git a/Documentation/trace/debugging.rst b/Documentation/trace/ 
>>> debugging.rst
>>> index 54fb16239d70..d54bc500af80 100644
>>> --- a/Documentation/trace/debugging.rst
>>> +++ b/Documentation/trace/debugging.rst
>>> @@ -136,6 +136,8 @@ kernel, so only the same kernel is guaranteed to 
>>> work if the mapping is
>>>   preserved. Switching to a different kernel version may find a 
>>> different
>>>   layout and mark the buffer as invalid.
>>> +NB: Both the mapped address and size must be page aligned for the 
>>> architecture.
>>> +
>>>   Using trace_printk() in the boot instance
>>>   -----------------------------------------
>>>   By default, the content of trace_printk() goes into the top level 
>>> tracing
>>> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
>>> index de6d7f0e6206..de9c237e5826 100644
>>> --- a/kernel/trace/trace.c
>>> +++ b/kernel/trace/trace.c
>>> @@ -10788,6 +10788,18 @@ __init static void enable_instances(void)
>>>           }
>>>           if (start) {
>>> +            /* Start and size must be page aligned */
>>> +            if (start & ~PAGE_MASK) {
>>> +                pr_warn("Tracing: mapping start addr %lx is not page 
>>> aligned\n",
>>> +                    (unsigned long)start);
>>> +                continue;
>>> +            }
>>> +            if (size & ~PAGE_MASK) {
>>> +                pr_warn("Tracing: mapping size %lx is not page 
>>> aligned\n",
>>> +                    (unsigned long)size);
>>> +                continue;
>>> +            }
>>
>> Better use %pa for printing physical address as on 32-bit systems
>> phys_addr_t may be unsigned long long:
>>
>>     pr_warn("Tracing: mapping size %pa is not page aligned\n", &size);
>>
>>> +
>>>               addr = map_pages(start, size);
>>>               if (addr) {
>>>                   pr_info("Tracing: mapped boot instance %s at 
>>> physical memory %pa of size 0x%lx\n",
>>> -- 
>>> 2.47.2
>>>
>>>
>>
> 
> 


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
