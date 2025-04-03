Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022105.outbound.protection.outlook.com [40.107.193.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3B22528EF;
	Thu,  3 Apr 2025 17:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.193.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743703188; cv=fail; b=HBaz8NXwf4Uf6OSAl2bn5xIZbWOygqOmB2E8dyno07Cv7UHMkJkjnB0eM7Gz8TGqumMJfsK9puQtm67S0BoOw08gzhbV8gQ4+rQdQfBTta18T6BaXPdyNlXhHETUsFviz1UF3Sw42TvpH6dnm8sySJkHoAVkPvJG891QfB0abCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743703188; c=relaxed/simple;
	bh=IUd+MtQa9M4pbF1BufyPXKFGGHrQwYW+HJdKaEKFXrI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=b6/jQwKZ1jrleYDZkWf0WnvajWwsN/Y8ltfy1DHhrsC9wSGhIVn+6fG5baFculfq7DAeBT5DncK/3MdWn/gI78idFFj0395uHNAQfwtwICqWI843cXqAwcheWqIjJGZP3oxOmI72MV00oW0JTRURjhkIXvr04fPnuI5m2QvcD7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=kaaAc6hy; arc=fail smtp.client-ip=40.107.193.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="kaaAc6hy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b4N06myNr7nUGbak0zNypqgMKUrFgZBt/io2FK11l7x/vVwmiLsY8N6T1MWqxAc8gqqJIv8Uros/i7LKAE804wGP2QVO2mSpXsIuS3nQM9ngVY9qZrPDSp9pN1Hce0+Q9hqssAf8Zf4CLkdc9orOGKq8bpfOH9TxwdSBq0MnsDQ5GDeq7NFX0XUC5LF4g9IbrFXz7AV2ryh3jzMv8cy4YPcFcsoh7Usak28zRsLFg5QlFl5RlTQnUarWiAoRuRnvRj1JHAVUeidGnnNLJL21/Q+0rSgFB34RhcQu42+QKoF+ndJaYD9AGESQc+Rqk2O84FRSKo5F+xZhSxa+eVLK9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1l+ZrLKP68f48hejfsGtCIZBOe3+giq1cKge3+onjVc=;
 b=YLfJsh5qs1YMrzVzibmZpzifsHieF+W2Mdm1wam5J84AutFfoJDR0s1S9m6MOH5J9E61D7ldz8M9SioIqMtlf7ZyUWqwPrmnkAxcC7hAtyigFzY5QCGsppnQdWKvR7ccTmGOPMGbVUDQuRH+K3s5nyd7Lng6ld122jjkRkfyVJI7bz1+jeEimUDoK2WxdbbATeTgngEO2upMrxjRV47rZcBSp1cOkV4RsGM2TkORwf6o0D7xrtEPAcDYanBXQkpFJas8Zve5yv7OgdgvOATglCNU2f470mMQ373xs6f2j4Z9N3GYaP+HmvUm/2Z92RxCjFMitJbLtJRBFLL3NtGYRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1l+ZrLKP68f48hejfsGtCIZBOe3+giq1cKge3+onjVc=;
 b=kaaAc6hy4QITy1X0SyC0KvkPUYK6JP/7ngDJQLjlgjVAfC8omG8u604mRd0xjpznBMEeyYl6ReEPv+FH5+4kTJgPxrDzsu9x/35djy6Zu4JNS5pvY3cUm2NvDsgjwUQsQO8ziRe0V9eeCzqdkXVtT2upaxejbUYiqyONKq7z3xlrNxQ78yK+Bs1Qvye65HCz5JsndWaWh1dagzgsrLhuYNOz564sGtI0Cea+U7i1/Yrnsh0gXRMtfwC3zW/qbs4knwv/m15EIUMLLWapv7WXliAFo0nvaUNI49gFvCcNk9dxcrc4iLfqv7i3VhC8vxwIT1ASNN88uRQuSmbkmvsF8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:a0::18)
 by YQBPR0101MB8895.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:5a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.51; Thu, 3 Apr
 2025 17:59:41 +0000
Received: from YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::5393:fe91:357f:3ccf]) by YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::5393:fe91:357f:3ccf%6]) with mapi id 15.20.8534.045; Thu, 3 Apr 2025
 17:59:41 +0000
Message-ID: <55c89f03-6120-43d1-a620-46d8ca8aba4e@efficios.com>
Date: Thu, 3 Apr 2025 13:59:39 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2] mm: use per-numa-node atomics instead of
 percpu_counters
To: Shakeel Butt <shakeel.butt@linux.dev>,
 Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Dennis Zhou <dennis@kernel.org>,
 Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
 Martin Liu <liumartin@google.com>, David Rientjes <rientjes@google.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Sweet Tea Dorminy
 <sweettea@google.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
 Christian Brauner <brauner@kernel.org>, Wei Yang
 <richard.weiyang@gmail.com>, David Hildenbrand <david@redhat.com>,
 Miaohe Lin <linmiaohe@huawei.com>, Al Viro <viro@zeniv.linux.org.uk>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Yu Zhao <yuzhao@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, Mateusz Guzik <mjguzik@gmail.com>
References: <20250331223516.7810-2-sweettea-kernel@dorminy.me>
 <2m3wwqpha2jlo4zjn6xbucahfufej75gbaxxgh4j4h67pgrw7b@diodkog7ygk3>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <2m3wwqpha2jlo4zjn6xbucahfufej75gbaxxgh4j4h67pgrw7b@diodkog7ygk3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQXPR0101CA0055.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:14::32) To YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:a0::18)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT3PR01MB9171:EE_|YQBPR0101MB8895:EE_
X-MS-Office365-Filtering-Correlation-Id: 6274b485-e291-4d48-2dec-08dd72d94ee7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZERKR09mR1QrV1JIY09PNFRLU25ObXkybmFUT3A3VkxrczRrbEU0cHhkZlN1?=
 =?utf-8?B?b3pnVHhUWGM4T2VGSXZUYmlML0trRVJ6STVnM0VEWUZkRFRGdGdraVZoMDJF?=
 =?utf-8?B?TDhTMWZwSmNrNHJoQm9UbXZuWi9tUG1yT1JqOGdwamNucyswZE9hclZXb29o?=
 =?utf-8?B?R0VySVFtWk10eTMwUnhUR0lEa3ZaeDJPQkdMODM4SThSay9aZ0tvaDc4WXBG?=
 =?utf-8?B?YjN1V01BVXdtUmx2WFpOOEw5ZlhDRkxVUkdDS1BBNWlsS1BvRm1GRHZFMzE4?=
 =?utf-8?B?dFI0bThWUUR0Y3ZNK1BCMS9TYjQvdnZXQWxzNWd3OWlwUVByWU81a3lTcXk1?=
 =?utf-8?B?WlkzK1A4RHZqWE53Y3MwUmRMMFpRcWJ5VHNseWxOa3FQc3VxVGpnUlJTb2l3?=
 =?utf-8?B?blJtNkljNGZBME5LMkJOOU5rOWtucmhmenBCTW5vUXlhb0EzeHJTbkVtNi9Y?=
 =?utf-8?B?dk03Y25jZ0ZHN1RRSXRzKzc5ZjhCSmZDYTVqTGlacnZEbGNvUVBTU1FPS3NW?=
 =?utf-8?B?UXZUWklKYkwzUVl6M0FSLzhBbFhSY0RXc0pGMXVrdVQvN1QzdVZSdmVNSzFq?=
 =?utf-8?B?WXd2YXB1R2V2M2w1OTFVbW1jeWpYZW05WjJuQzMwWEpITmw1clcrV3RrYjBO?=
 =?utf-8?B?TnJQdWNGeDRkRmZ1UWhic25HTWI2TGVVWmJValk2c1hMS280Zjlvd3Bmazcw?=
 =?utf-8?B?L2xsNUEzVVZDbWRTaERpRlZBV3ZwQnEyYUxmdnRZNDNmNVFGMEg1dkNyWnVL?=
 =?utf-8?B?NmV1TW5aSGtLeFN3cWdjYU12QXVtS0VQV09kczRDRi93Q0QrT0FKOWwzZi9J?=
 =?utf-8?B?YTFLVkpJODI1ZmtBM1hyWElNai9rbTdlYlJYcVI3MTk4SkRCdW5YOTNIdEVt?=
 =?utf-8?B?U3dUNjZPNkZnMHZscThiL0pQZ1JjVlBwSE0zOGV4QkRHUUdyZmozNENBZ1BY?=
 =?utf-8?B?NVM2bFhOWE1DSEVmWkxuMVJEcmZFNUdzdTdSN1h6UmpxYTNRRzV6RG1OUUl4?=
 =?utf-8?B?ZFowSnJpSk5QZnViTzVYdkpmeXhTa1UrUC9Ta3RYZW5zelpESXNHL05JMm95?=
 =?utf-8?B?OXM1RlpxOUVZbkUxZklLbmV5c0VEUlQ4enlkZGxKZmlHUUs3SDg3MkQ4WFJQ?=
 =?utf-8?B?YkRoWUVpMTJjY28xeXlqUkt6WTF1ZUVGalh5S2dsdWVRbzBoRDRzK2thV25i?=
 =?utf-8?B?VTVUYnBkMkVXcTQ2OWYxRzdRQnFzbXVqYVoxZXMwN0NEdUVYQXZSSHN0Mlpr?=
 =?utf-8?B?ZUhZaVhqcFhUcnBWL0ZNaVFXSTZXaHpOSGRlTVZMTTY2UTFQRjhDSU5VTUdG?=
 =?utf-8?B?aFRPQ3N4WE5iK0RQcm9xMXdONDY1QndDOGZIVXJwWGExY0ZidWdkb3krWXZ3?=
 =?utf-8?B?MDVZZTJLK3BRNFB0K0s2MzNTWm1kWHlvcE13YXhHS09jNlpTTWxURU9WbXhG?=
 =?utf-8?B?Y3pDVXFxWkpiZVJIdjlVTE9Cc2U0ZXhuLzF2cFl2MkhwNyswajNNd1diYzU1?=
 =?utf-8?B?V3cvdUR1NHFybXp0TGRjdGZ5bldkQkFlaGExWE4vMmdWbkFhRnlmWk5LYzc0?=
 =?utf-8?B?YUVSalpXZmFTVStyS296WldZODFaQXY2YUZZWklYMkpWbFM2Zmpicngzd0Z6?=
 =?utf-8?B?WUhHaEtwTndNMVdYalI0RHVtaHRSTTRiSWl6aUlnYUFzbFVWUTFjb1RVaTBD?=
 =?utf-8?B?Sy9vNWZlZ0wyTDJJQ0FJUFp5SThpdkczT0l2VVhJK0NxRW9XcHRNMXo5YitN?=
 =?utf-8?Q?rzhcfiOA3pKySSAjpvMsjn/4Ep0xrgmfxLgrcM+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MGltSXBDbjgzN2FwTUtvSXBZdDBCWGxnNUdiaEw1WFY5M2tiM2Z3WURsNGVl?=
 =?utf-8?B?MkZsbmFvK1RlTkhZOTgzdm1vcnFEYW9ZUnZVOXc4dUJGSlFMRzI4Wm9UTm5E?=
 =?utf-8?B?QzBMNFplU21GMmgweENJVVQ3Rk5CNHNDeTRoWCszSlZ6NDFxZnU2dEJweG05?=
 =?utf-8?B?ckJPbUxQYlJvcHZxRHcyY042RGhhRTJKY1JsZ0FueG1IanRTdE9FaldUZmxs?=
 =?utf-8?B?R0NJNEtGbE1PZWtEVXhzSWE1YTY2akprMEtCODVqa25yMUVaNy9jMy84cldx?=
 =?utf-8?B?bVBHWXA2K1MzS1dHY2JEWEhqaDBKMGhwdFhRZkVSYzBaZ053bnhFbGw1dDlu?=
 =?utf-8?B?azF1aUV3bWxacW1nSFRYT3ExOEtyd2hzN0p2R05VVVExdW5CU3A5OG82dXo0?=
 =?utf-8?B?QVBtZU5sK2NMMFJxWm4xZ21ZL2FiV0pveVc1MU84eG95WWxTOGl1aXFENUtM?=
 =?utf-8?B?SGJ0c2JDeWsrMWpObS9BWVNBaVFvMHZzNGo2a0l2VFFad0xmd1M0QTVuTWNv?=
 =?utf-8?B?citDQ0swUjV2Sm1QK2tJakV6KzBRenptc3Yzejk1MWV6TmRGVkxXMlpRbFdG?=
 =?utf-8?B?eUtiWUhlU3Z6WmtjUVBtcmpXSTBuN2I0bVdURHB3Z2ppellzR0prR09QYUZV?=
 =?utf-8?B?RVFKWjl0Z3lJQnhyNXpsS1JOVzJ1LzgyYlYvQlhyUHo1VzNrTElITTJUZWVI?=
 =?utf-8?B?VDF2RlBzVUZKOVY4TkIxWStUR1E5bGFpTy9qckUwWENPMnVCdHJTSWl1SU9v?=
 =?utf-8?B?eCtLaWs0bDlIbVJLanhLNitBSDJoMDBtSmRhVnB3azhWeXJEZkF1MWd3bHR0?=
 =?utf-8?B?Z0M2enpxTlNIeDB2eGZFdlVPSS96ckFORWZ3Rm9rMytTVjFxdXI4bWZEUHRZ?=
 =?utf-8?B?Z2JidURWRjBJbXNJbTRyZ3VkQ0RDNUNRaUs1MmtJMlRERzFmNFhkeGdlaDI0?=
 =?utf-8?B?eGxGU21YaWw4TVFhd20wRXdWZ3ZsL01JRjA2MXBna3R1WHVQbFFpcGxPaEMy?=
 =?utf-8?B?dGNwb2gwSk5HSFhCRWU0MU55cloyS3dwQVNtVkNzTmlBY29KOGJhSVFBSnFs?=
 =?utf-8?B?T3RwODJrZHBETDBncFhCRFlGcFRKays0c3RZeklOTUtVU1JZODVyY3VJZVhM?=
 =?utf-8?B?ZFNFanFTdkx6ZENjMTNuTThkNVcydHdsWHpiZFdVYmtCRmRtd1lWV0NZbFdW?=
 =?utf-8?B?eHVabDVKRDhsNnlucDB5Vm1xa0ViVk9vVWVNR1hVZGJrMDl1ZDJCSWI5c2Vj?=
 =?utf-8?B?RzJKWHJvQUE1ck5QVVhzc0dxUTBHZjFjZXVtZjFENTF6bVhjeVl3dUlRUmNY?=
 =?utf-8?B?NW1LdHNTeGNSTmJPc056Wm4zTzV4ME93cjBrdlNWd2g4b0xLRXlwckZlMjhN?=
 =?utf-8?B?a3VETlFsNWdEby9tTlovbE9uMElJT3dQNGpCL3hlOEpGWCtieUVhYklBMDJt?=
 =?utf-8?B?bWRxeWhMSE5nV2pLZ1JmRlNQQzA4dk1xKzZYRWlkak50bzF4TjlLWWNldnQ4?=
 =?utf-8?B?RUgzUXNuaGpDOU5MYm5vbmNxNjBHcGJmWGlIUmR1YXk3SFM4aFdVRzIyM2VG?=
 =?utf-8?B?WFJ3RW1McXhPVDE0SjlqdUhkTk9KanFmVjZpeDQwVUNtZWJ1c2RvYThsTndH?=
 =?utf-8?B?aVZVbVZxK3N2VHg1WVZ1Y0lNSmFHNWRxTmF4cVl1NEJnNlBXTmt4dytTZlgx?=
 =?utf-8?B?UWtXNzJrSDJ4Tm9Wb20xTnM3MTdXbDYxeW9nZ2RlR3pzVWpHUUpVWHB4ejJh?=
 =?utf-8?B?TGQxdTltck1NdWJTaWNwS1hIanlXWkQxRk15QkRwQ3E4Lzg3a2dObzA4Tjdm?=
 =?utf-8?B?RDJ5WmE4Z015VW5ucC8zOEhvcHVZSkZ3dGtSejZhd2paOWp6ZFN6bDJSZGxo?=
 =?utf-8?B?VSsyQkY4cDFPWCtSanZnWk13bTdVWkxDUEExS201Yk5mOGxTM21YRDQrRksx?=
 =?utf-8?B?VHFVTlBobkUzVlBWcTh2L1hZbEFqam0zVlk2cTV1MFQrK0p0Nmo4TzZpWEx1?=
 =?utf-8?B?cTRiZC9OdHU3L3RVeDRXMk1Hc0Y4SnVJaEJhcWZGVTM1MFRJaVZLSjY5WWJJ?=
 =?utf-8?B?bzVxUHRYNXhrTjVHb3VReVhZNnQ2bHE4bGs0OG1CN0tSNjhqUDlVMzJpWktO?=
 =?utf-8?B?d0hpS1JGWnhGakJ0SmFkY0tueFdHTnVkMG5lcnNoR21CakQ2Tmoyc0JXVXNl?=
 =?utf-8?Q?Nv3ww+C9FBRRXH7jgfyVNgM=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6274b485-e291-4d48-2dec-08dd72d94ee7
X-MS-Exchange-CrossTenant-AuthSource: YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2025 17:59:41.5197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fz7cYmhEpNj9Ji7b5cWvC5Q8wsoWSwC4+zsnzy8hWPXQ9ed1Hd9V/T3UVd3VxQOa+fuCLl6jTD+Ay+WybYWrdEMK6fh9tvIAPD78IQRLGwc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB8895

On 2025-04-02 20:00, Shakeel Butt wrote:
> On Mon, Mar 31, 2025 at 06:35:14PM -0400, Sweet Tea Dorminy wrote:
[...]
> I am still not buying the 'good performance' point. To me we might need
> to go with reduced batch size of existing approach or multi level
> approach from Mathieu (I still have to see Mateusz and Kairui's
> proposals).

Here is an initial userspace prototype of my hierarchical split counters:

https://github.com/compudj/librseq/blob/percpu-counter/include/rseq/percpu-counter.h
https://github.com/compudj/librseq/blob/percpu-counter/src/percpu-counter.c

How to try it out:

* Install liburcu
* Clone & build  https://github.com/compudj/librseq branch: percpu-counter

(note: it's currently a POC, very lightly tested.)

Run tests/percpu_counter_test.tap :

ok 1 - Registered current thread with rseq
Counter init: approx: 0 precise: 0 inaccuracy: ±2048
Counter after sum: approx: 2998016 precise: 2996800 inaccuracy: ±2048
Counter after set=0: approx: 1216 precise: 0 inaccuracy: ±2048
ok 2 - Unregistered current thread with rseq
1..2

It implements the following operations:

Fast paths:

- counter_add
- counter_approx_sum

Function call APIs for:

- counter_add_slowpath (approximation propagation to levels > 0),
- counter_precise_sum (iterate on all per-cpu counters)
- counter_set: Set a bias to bring precise sum to a given target value.
- counter_inaccuracy: returns the maximum inaccuracy of approximation for this
                       counter configuration.
- counter_compare: Compare a counter against a value. Use approximation if value
                    is further than inaccuracy limits, else use precise sum.

Porting it to the Linux kernel and replacing lib/percpu_counter.c should be
straightforward. AFAIU, the only thing I have not implemented is a replacement
for percpu_counter_limited_add, and I'm not so sure how useful it is.

The most relevant piece of the algorithm is within counter_add as follows:

static inline
void counter_add(struct percpu_counter *counter, long inc)
{
         unsigned long bit_mask = counter->level0_bit_mask;
         intptr_t orig, res;
         int ret, cpu;

         if (!inc)
                 return;
	// This is basically a percpu_add_return() in userspace with rseq.
         do {
                 cpu = rseq_cpu_start();
                 orig = *rseq_percpu_ptr(counter->level0, cpu);
                 ret = rseq_load_cbne_store__ptr(RSEQ_MO_RELAXED, RSEQ_PERCPU_CPU_ID,
                                 rseq_percpu_ptr(counter->level0, cpu),
                                 orig, orig + inc, cpu);
         } while (ret);
         res = orig + inc;
         counter_dbg_printf("counter_add: inc: %ld, bit_mask: %ld, orig %ld, res %ld\n",
                            inc, bit_mask, orig, res);
         if (inc < 0) {
                 inc = -(-inc & ~((bit_mask << 1) - 1));
                 /* xor bit_mask, same sign: underflow */
                 if (((orig & bit_mask) ^ (res & bit_mask)) && __counter_same_sign(orig, res))
                         inc -= bit_mask;
         } else {
                 inc &= ~((bit_mask << 1) - 1);
                 /* xor bit_mask, same sign: overflow */
                 if (((orig & bit_mask) ^ (res & bit_mask)) && __counter_same_sign(orig, res))
                         inc += bit_mask;
         }
         if (inc)
                 counter_add_slowpath(counter, inc);
}

void counter_add_slowpath(struct percpu_counter *counter, long inc)
{
         struct percpu_counter_level_item *item = counter->items;
         unsigned int level_items = counter->nr_cpus >> 1;
         unsigned int level, nr_levels = counter->nr_levels;
         long bit_mask = counter->level0_bit_mask;
         int cpu = rseq_current_cpu_raw();

         for (level = 1; level < nr_levels; level++) {
                 long orig, res;
                 long *count = &item[cpu & (level_items - 1)].count;

                 bit_mask <<= 1;
                 res = uatomic_add_return(count, inc, CMM_RELAXED);
                 orig = res - inc;
                 counter_dbg_printf("counter_add_slowpath: level %d, inc: %ld, bit_mask: %ld, orig %ld, res %ld\n",
                                    level, inc, bit_mask, orig, res);
                 if (inc < 0) {
                         inc = -(-inc & ~((bit_mask << 1) - 1));
                         /* xor bit_mask, same sign: underflow */
                         if (((orig & bit_mask) ^ (res & bit_mask)) && __counter_same_sign(orig, res))
                                 inc -= bit_mask;
                 } else {
                         inc &= ~((bit_mask << 1) - 1);
                         /* xor bit_mask, same sign: overflow */
                         if (((orig & bit_mask) ^ (res & bit_mask)) && __counter_same_sign(orig, res))
                                 inc += bit_mask;
                 }
                 item += level_items;
                 level_items >>= 1;
                 if (!inc)
                         return;
         }
         counter_dbg_printf("counter_add_slowpath: last level add %ld\n", inc);
         uatomic_add(&item->count, inc, CMM_RELAXED);
}

Feedback is welcome!

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
