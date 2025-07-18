Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2108.outbound.protection.outlook.com [40.107.220.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D17418035;
	Fri, 18 Jul 2025 01:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752803247; cv=fail; b=Au8RK30mcdz2lOF9waL8CQuJgEplUxXSifi8TUkJPhz44uzTc311oY6LGeLUXgfWxi7nVKXx15nAXs2bKXpjuKAWkm1dKn25OvH8aAqkpGaumV3kDUrF6z33kp/jIzzQPmD2zWCRVX26mh9GZ6xIVEZ3OQCwHyInjEWVaoGmdKo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752803247; c=relaxed/simple;
	bh=OmlLqdq40nMiIanGG7SPl7DHHm8i+Xedy8oCIPzPRdc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=P1KH8XsO+xjxoHHVtKikQCrrRDPYb7+yxe4Nd4Oxaa+0XZcqr0X7dTvo4Q6yxOZjCGMC6OOSijtpxI5Z16nsCNzmOQMN+r7XVIuAklyKl1Uq9G7d/JzMlx9GAQ8cm1wPCX7tCdcodtV0ruCRDa7ihgcYi7Ux2ljWyJxccLigICc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=luxshare-ict.com; spf=pass smtp.mailfrom=luxshare-ict.com; dkim=pass (2048-bit key) header.d=luxshare-ict.com header.i=@luxshare-ict.com header.b=pQyZnY78; arc=fail smtp.client-ip=40.107.220.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=luxshare-ict.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=luxshare-ict.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=luxshare-ict.com header.i=@luxshare-ict.com header.b="pQyZnY78"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FL45iuX5iucDV5pMvY2jxxnp7r5FsQkXWDTvBNIU4o3DNTeEDRfFzIMYJAQnPt6mrr2I8T+SpZALZGorATbl1U7NSyVISQsdgw7GRkXpQOX4FFhSnL7RudKKwT8ikK+b7tQVJZJ5xdogONnif2KNZUIwI4Ks4F5dudVUmLKSYa6dGGuf41uO40u809RVnThROmoLIDs5tgKhgX9s6UdXKNWt3L+YoV2a6VorVMEiH8+uMb06TodY+o3vwS3byzfQmQ6gGf8NI3XGPExC5eR5P4Nu8+9OF4Tb5os7kDEjQHSAE6suqNYLmS8YuLTgt81vf/fpjcmGTok4uLQGQtCkxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OmlLqdq40nMiIanGG7SPl7DHHm8i+Xedy8oCIPzPRdc=;
 b=OBwf8+JQDh7oHoQ8FODje4VONu/1w9JlygICmp3LEeAuPQBTedrBRGpU6xuxWFsg2kBeylDHPrzgeKVT3K5U2sizQuRn/KuBg5XDDS6llXiusXvNlEPgBYs+g+CqvpHWKECfeAX0ZqHXJHyXVPE7QR9qebLBT0/ymIcb3PD4x2M/j2rdQEqtvbSUb5cMpQulUE1jlpm5R1ekIFYmamkzcmIzI9MM35yFIrhSvd3IDE2UTNZkVENzWiltuhzzlX7VFhyTYRmIU0p8F1M7Qh85g35zMFn1tLf29U/kIR3aMMRGyV6ZGJlXx5iFtf+ts2xvKHsker8z483lpiIn4l8+ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 153.35.214.187) smtp.rcpttodomain=goodmis.org smtp.mailfrom=luxshare-ict.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=luxshare-ict.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=luxshare-ict.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OmlLqdq40nMiIanGG7SPl7DHHm8i+Xedy8oCIPzPRdc=;
 b=pQyZnY78cnxR+fzKNl0c4voMloi9AGoqFLS00pgYFP6L730OJtHEO9nnlzvwfYWQYZC8qnuJsaLmzLOFOqjGsa3vncL4kQ4vsVmaSEdFOB6fbgeD5lSSuTejOmZvsqzrzTl3xzi6DTfqfy7FuM3EZEZ03UCn79GLA2m3vRals8gE4AY1abt73X3gAR1cSxL1MlLVk9jsYDD/RnNfvp2dc9P66gBYJ+g2/rCd5ge1SOpyGNHgY3QVWn53fBanUhFa+72Gr/mANyu4RgSXSJiw6d9hRo7y6WYWrUkdYW+d5MzZTYdPWnTrDPhuWY89c3wSQ7RSbpJnuiUEbQg+LcHZtA==
Received: from CY5P221CA0073.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:9::10) by
 DM3PPF1652C44C3.namprd10.prod.outlook.com (2603:10b6:f:fc00::c0b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.26; Fri, 18 Jul
 2025 01:47:19 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:930:9:cafe::80) by CY5P221CA0073.outlook.office365.com
 (2603:10b6:930:9::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.20 via Frontend Transport; Fri,
 18 Jul 2025 01:47:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 153.35.214.187)
 smtp.mailfrom=luxshare-ict.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=luxshare-ict.com;
Received-SPF: Pass (protection.outlook.com: domain of luxshare-ict.com
 designates 153.35.214.187 as permitted sender)
 receiver=protection.outlook.com; client-ip=153.35.214.187;
 helo=KS9P-EXG-SRV09.luxshare.com.cn; pr=C
Received: from KS9P-EXG-SRV09.luxshare.com.cn (153.35.214.187) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Fri, 18 Jul 2025 01:47:17 +0000
Received: from KS5P-EXG-SRV04.luxshare.com.cn (10.41.3.24) by
 KS9P-EXG-SRV09.luxshare.com.cn (10.41.3.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.26; Fri, 18 Jul 2025 09:47:14 +0800
Received: from KS5P-EXG-SRV04.luxshare.com.cn ([fe80::70c5:9baf:f42b:e159]) by
 KS5P-EXG-SRV04.luxshare.com.cn ([fe80::70c5:9baf:f42b:e159%4]) with mapi id
 15.01.2507.057; Fri, 18 Jul 2025 09:47:14 +0800
From: =?utf-8?B?RnVzaGVuZyBIdWFuZyjpu4Tlr4znlJ8p?=
	<Fusheng.Huang@luxshare-ict.com>
To: Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>,
	Linux trace kernel <linux-trace-kernel@vger.kernel.org>
CC: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
	<mathieu.desnoyers@efficios.com>, =?utf-8?B?R3VvSmluIERhaSjmiLTlm73ph5Ep?=
	<GuoJin.Dai@luxshare-ict.com>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0hdIHRyYWNpbmc6IEFkZCBkb3duX3dyaXRlKHRyYWNl?=
 =?utf-8?B?X2V2ZW50X3NlbSkgd2hlbiBhZGRpbmcgdHJhY2UgZXZlbnQ=?=
Thread-Topic: [PATCH] tracing: Add down_write(trace_event_sem) when adding
 trace event
Thread-Index: AQHb9z31tgYpqN/fVk2Jv/rjM4yXVLQ3G/ow
Date: Fri, 18 Jul 2025 01:47:14 +0000
Message-ID: <3ba7b2fd200642ec9a5f2a2c98b7def0@luxshare-ict.com>
References: <20250717131204.74559b88@batman.local.home>
In-Reply-To: <20250717131204.74559b88@batman.local.home>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|DM3PPF1652C44C3:EE_
X-MS-Office365-Filtering-Correlation-Id: dada95ca-5b6f-4d01-36d6-08ddc59d074d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UHdkUEFoRVM5WWdMQzVGVUFyaGUrSjJYQTIzeENTb0xQTkh1KzZGOWNlbUc4?=
 =?utf-8?B?SzgrTlA2dWtZRDM3cy81SzRvbE9yclY4MTdGbVA5UXo2SytROFVXK05Ob3Ix?=
 =?utf-8?B?UlM2TmhWL080R1hsbHZjckFTbmUyRkRoUmo1cUJXNzI4LzVEMU5nd2FJVmVS?=
 =?utf-8?B?MDVxaVc4Q2s5VHZ2VitTYUl0Q01Cb1ZGYjFxM2dUVEFFMUdwVzBIUE9qWm9D?=
 =?utf-8?B?S3pEMXpFaFk2cDh3N1ZINUYrYlhxWlVuOVlqV2dCYXhCekxMS1duSC85elh2?=
 =?utf-8?B?azEvcytiS0M3cFZlUjg2bEhKVkJ4dmxiWlZuVktYbU5yM0ZmcDVGSkNheWRX?=
 =?utf-8?B?eVlTKzFPUE1jZmJCQVNDQ1B0ZzJaRTB0VnpTTGZpSjhDdGFycmt2cERPY0xl?=
 =?utf-8?B?c1RET2Z0REhqUnRZWHljUDRYZW9QUUxCZCsrbnFyV3g3VkpBMXF2aVBLaU9X?=
 =?utf-8?B?eUlJMkZleXdEd2IwUTU3MHNHSGxNc01pbXU4eEtSRWtBYm1hRTMxN1JXcTdV?=
 =?utf-8?B?anVOc05rWGtPTHMxN2VGd1A3b3RsWklMMXdqWVZBUXFqNGhzRnlsQk41NitF?=
 =?utf-8?B?ZEl6SkxVSW0xRTVkU01XamlYMHZvZUxBWUliWFJCcjU4SUg2L0FZSUJKUWx6?=
 =?utf-8?B?RnlzK3cwejFkMWRkWFkxSmRiRmMxeW02Y3ErenR3S1RMN0p0ZG1BWDdBb3d3?=
 =?utf-8?B?a29LQ3NmNUJjajhCanZOUmJSVUhNUGJ5WG1JUmtxRmFheU9SSWVaK0tNNmZp?=
 =?utf-8?B?RGx0UzNlbWdoUHk5bzFIQVZtR1BOSEdGa1FMWUpoTE5rZVZ2RU13YTN5SzMx?=
 =?utf-8?B?KzRUZTdpUGlUbXhZQ1EzOGxPZS9nYWxlZi9sL2IyZ3hHamcwSVkxMlUwcG5Z?=
 =?utf-8?B?RWhISjE5SVZOVzU4ZXZMZjd0RFhYUzVMTVFONjlXRTlpdTJYalh5V2VGaEd0?=
 =?utf-8?B?SjcwZjA2M0NNZWNmNmdxRW1VMTZPN0lkNjdaclVtUzkyeVl4QjFnMkNscjlu?=
 =?utf-8?B?K1NpUG8vVkdGNkM5eG4wemw3aktQYjZ0YVNKUktEQUU3ZG55Y3FEK3Yvd01n?=
 =?utf-8?B?MlV6Q01iQjZTcGZwcXpmSkc2YzN4Zzh2dFEyZkhYZzFORTJzelJyekQ4TVB6?=
 =?utf-8?B?ZjVQTnJuUnl5b2pkMnUxWDErZjB1K1hya1BMTDdWSXhrUDZyMDY4U2hEYyto?=
 =?utf-8?B?U2VUKyt5MHB1VUZLYkVwZm9JQ3JtUkVHYzVFcTdmNjR6cmQyYjV3QzQyTTF2?=
 =?utf-8?B?bnNkQTNiWTNnN1hmUjF0REVhdmEzNS9JVWN4UnUrMFQrV3hqTjZmaUVROTNl?=
 =?utf-8?B?S2NxUXRWYmhIOWNNblV6T1VEV1pQZGVuOEo4Wm80RUU1bzhyMlN2WGgrKytE?=
 =?utf-8?B?RDZ3N1hkUnJkd0ZGK3FYakRHMkJOVVZjWFJYK2hENGVLeUpwazYvY2F3K0c3?=
 =?utf-8?B?TFpHYXM3QlNBSzdvRU45SlkvVlIwYlhSSWZVVTBiN2ZXdHJHUDRqRlFQVEpT?=
 =?utf-8?B?SDdRYnVYc2F3QU5oZHhETk4xODJpSVpRU2FEYTNKMVlkZDNCeUs1bHNzNzJl?=
 =?utf-8?B?UHJZK0g2WnBtWlB5Y0xmTmM2VkJGNHdtZ3ozZUpzU2p4Wk1IVERQZVp4MzBm?=
 =?utf-8?B?aEVDMHdnazZJUERzc24vVkRHRmNOZDlrZ3RLVEVnY2M3djI2dno4V0FMREpi?=
 =?utf-8?B?NXVlM0duS253bXBacTdJQVUwSXVhOUhoaFJ4ck1lVEtyNlVTanE0L3RCQmVP?=
 =?utf-8?B?WU1oZmp0S2JDam9rV0RaUmZkSjZDQkx4SnduOXFqZmhTK1dHR2U4dGQwRE1V?=
 =?utf-8?B?anhrQS9BZXZMTVMvNE5vNmxtVEwxSmxibDZUaWM0a0Qycm95cE9aeG0wOVB5?=
 =?utf-8?B?R2xOOEx0SE9MdUlqcnFMVEFZYXdYTFVTd1k0WUdrb2pLSUk5cG80MjZlSFJj?=
 =?utf-8?B?aWhoWEVPajBhNDlPb0RqUldiejh1V3pLaE15QkFIUkpOSEl1Nzk0Nkhqcitv?=
 =?utf-8?B?R21TSDNTaHRzSlJTNkh3Z25BVExlNVRSSmV2T1pSczVIWVRmYXVJanNBcUlT?=
 =?utf-8?B?Ni90Y2pjaDNRY3pTL1ZMalpjQ1EzV0o2WC9QUT09?=
X-Forefront-Antispam-Report:
	CIP:153.35.214.187;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:KS9P-EXG-SRV09.luxshare.com.cn;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024)(13003099007)(7053199007);DIR:OUT;SFP:1102;
X-OriginatorOrg: luxshare-ict.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 01:47:17.5398
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dada95ca-5b6f-4d01-36d6-08ddc59d074d
X-MS-Exchange-CrossTenant-Id: 932d66f6-19be-456c-a1ae-795987f2da41
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=932d66f6-19be-456c-a1ae-795987f2da41;Ip=[153.35.214.187];Helo=[KS9P-EXG-SRV09.luxshare.com.cn]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF1652C44C3
X-MS-Exchange-CrossPremises-OriginalClientIPAddress: 153.35.214.187
X-MS-Exchange-CrossPremises-TransportTrafficType: Email
X-MS-Exchange-CrossPremises-AuthSource:
	CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossPremises-AuthAs: Anonymous
X-MS-Exchange-CrossPremises-Antispam-ScanContext:
	DIR:Originating;SFV:NSPM;SKIP:0;
X-MS-Exchange-CrossPremises-SCL: 1
X-MS-Exchange-CrossPremises-Processed-By-Journaling: Journal Agent
X-OrganizationHeadersPreserved: DM3PPF1652C44C3.namprd10.prod.outlook.com

SGksIHN0ZXZlbu+8mg0KDQogICBUaGFuayB5b3UgdmVyeSBtdWNoLCB3ZSB3aWxsIHRlc3QgdGhp
cyBwYXRjaCBhbmQgZmVlZGJhY2sgQVNBUC4NCg0KLS0tLS3pgq7ku7bljp/ku7YtLS0tLQ0K5Y+R
5Lu25Lq6OiBTdGV2ZW4gUm9zdGVkdCA8cm9zdGVkdEBnb29kbWlzLm9yZz4gDQrlj5HpgIHml7bp
l7Q6IDIwMjXlubQ35pyIMTjml6UgMToxMg0K5pS25Lu25Lq6OiBMS01MIDxsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnPjsgTGludXggdHJhY2Uga2VybmVsIDxsaW51eC10cmFjZS1rZXJuZWxA
dmdlci5rZXJuZWwub3JnPg0K5oqE6YCBOiBNYXNhbWkgSGlyYW1hdHN1IDxtaGlyYW1hdEBrZXJu
ZWwub3JnPjsgTWF0aGlldSBEZXNub3llcnMgPG1hdGhpZXUuZGVzbm95ZXJzQGVmZmljaW9zLmNv
bT47IEZ1c2hlbmcgSHVhbmco6buE5a+M55SfKSA8RnVzaGVuZy5IdWFuZ0BsdXhzaGFyZS1pY3Qu
Y29tPg0K5Li76aKYOiBbUEFUQ0hdIHRyYWNpbmc6IEFkZCBkb3duX3dyaXRlKHRyYWNlX2V2ZW50
X3NlbSkgd2hlbiBhZGRpbmcgdHJhY2UgZXZlbnQNCg0K44CQ5aSW6YOo6YKu5Lu244CR6K+35Yu/
54K55Ye76ZO+5o6l5oiW6ZmE5Lu277yM6Zmk6Z2e5oKo6K6k6K+G5Y+R5Lu25Lq65bm25LiU55+l
6YGT5YaF5a655piv5a6J5YWo55qE44CCDQpbRXh0ZXJuYWwgRW1haWxdIERvIG5vdCBjbGljayBv
biBsaW5rcyBvciBhdHRhY2htZW50cyB1bmxlc3MgeW91IHJlY29nbml6ZSB0aGUgc2VuZGVyIGFu
ZCBlbnN1cmUgdGhlIGNvbnRlbnQgaXMgc2FmZS4NCltUaMawIGLDqm4gbmdvw6BpXSBLaMO0bmcg
bmjhuqVwIHbDoG8gbGnDqm4ga+G6v3QgaG/hurdjIHThu4dwIMSRw61uaCBrw6htIHRy4burIGto
aSBi4bqhbiBiaeG6v3QgbmfGsOG7nWkgZ+G7rWkgdsOgIGJp4bq/dCBu4buZaSBkdW5nIMSRw7Mg
YW4gdG/DoG4uDQoNCkZyb206IFN0ZXZlbiBSb3N0ZWR0IDxyb3N0ZWR0QGdvb2RtaXMub3JnPg0K
DQpXaGVuIGEgbW9kdWxlIGlzIGxvYWRlZCwgaXQgYWRkcyB0cmFjZSBldmVudHMgZGVmaW5lZCBi
eSB0aGUgbW9kdWxlLiBJdCBtYXkgYWxzbyBuZWVkIHRvIG1vZGlmeSB0aGUgbW9kdWxlcyB0cmFj
ZSBwcmludGsgZm9ybWF0cyB0byByZXBsYWNlIGVudW0gbmFtZXMgd2l0aCB0aGVpciB2YWx1ZXMu
DQoNCklmIHR3byBtb2R1bGVzIGFyZSBsb2FkZWQgYXQgdGhlIHNhbWUgdGltZSwgdGhlIGFkZGlu
ZyBvZiB0aGUgZXZlbnQgdG8gdGhlIGZ0cmFjZV9ldmVudHMgbGlzdCBjYW4gY29ycnVwdCB0aGUg
d2Fsa2luZyBvZiB0aGUgbGlzdCBpbiB0aGUgY29kZSB0aGF0IGlzIG1vZGlmeWluZyB0aGUgcHJp
bnRrIGZvcm1hdCBzdHJpbmdzIGFuZCBjcmFzaCB0aGUga2VybmVsLg0KDQpUaGUgYWRkaXRpb24g
b2YgdGhlIGV2ZW50IHNob3VsZCB0YWtlIHRoZSB0cmFjZV9ldmVudF9zZW0gZm9yIHdyaXRlIHdo
aWxlIGl0IGFkZHMgdGhlIG5ldyBldmVudC4NCg0KQWxzbyBhZGQgYSBsb2NrZGVwX2Fzc2VydF9o
ZWxkX3JlYWQoKSBvbiB0aGF0IHNlbWFwaG9yZSBpbg0KX190cmFjZV9hZGRfZXZlbnRfZGlycygp
IGFzIGl0IGl0ZXJhdGVzIHRoZSBsaXN0Lg0KDQpDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0K
UmVwb3J0ZWQtYnk6IEZ1c2hlbmcgSHVhbmco6buE5a+M55SfKSAgPEZ1c2hlbmcuSHVhbmdAbHV4
c2hhcmUtaWN0LmNvbT4NCkNsb3NlczogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjUw
NzE3MTA1MDA3LjQ2Y2NkMThmQGJhdG1hbi5sb2NhbC5ob21lLw0KRml4ZXM6IDExMGJmMmI3NjRl
YjYgKCJ0cmFjaW5nOiBhZGQgcHJvdGVjdGlvbiBhcm91bmQgbW9kdWxlIGV2ZW50cyB1bmxvYWQi
KQ0KU2lnbmVkLW9mZi1ieTogU3RldmVuIFJvc3RlZHQgKEdvb2dsZSkgPHJvc3RlZHRAZ29vZG1p
cy5vcmc+DQotLS0NCiBrZXJuZWwvdHJhY2UvdHJhY2VfZXZlbnRzLmMgfCA1ICsrKysrDQogMSBm
aWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEva2VybmVsL3RyYWNl
L3RyYWNlX2V2ZW50cy5jIGIva2VybmVsL3RyYWNlL3RyYWNlX2V2ZW50cy5jIGluZGV4IDEyMDUz
MTI2OGFiZi4uNTUyYzkyOTExZTJjIDEwMDY0NA0KLS0tIGEva2VybmVsL3RyYWNlL3RyYWNlX2V2
ZW50cy5jDQorKysgYi9rZXJuZWwvdHJhY2UvdHJhY2VfZXZlbnRzLmMNCkBAIC0zMTM2LDcgKzMx
MzYsMTAgQEAgX19yZWdpc3Rlcl9ldmVudChzdHJ1Y3QgdHJhY2VfZXZlbnRfY2FsbCAqY2FsbCwg
c3RydWN0IG1vZHVsZSAqbW9kKQ0KICAgICAgICBpZiAocmV0IDwgMCkNCiAgICAgICAgICAgICAg
ICByZXR1cm4gcmV0Ow0KDQorICAgICAgIGRvd25fd3JpdGUoJnRyYWNlX2V2ZW50X3NlbSk7DQog
ICAgICAgIGxpc3RfYWRkKCZjYWxsLT5saXN0LCAmZnRyYWNlX2V2ZW50cyk7DQorICAgICAgIHVw
X3dyaXRlKCZ0cmFjZV9ldmVudF9zZW0pOw0KKw0KICAgICAgICBpZiAoY2FsbC0+ZmxhZ3MgJiBU
UkFDRV9FVkVOVF9GTF9EWU5BTUlDKQ0KICAgICAgICAgICAgICAgIGF0b21pY19zZXQoJmNhbGwt
PnJlZmNudCwgMCk7DQogICAgICAgIGVsc2UNCkBAIC0zNzUwLDYgKzM3NTMsOCBAQCBfX3RyYWNl
X2FkZF9ldmVudF9kaXJzKHN0cnVjdCB0cmFjZV9hcnJheSAqdHIpDQogICAgICAgIHN0cnVjdCB0
cmFjZV9ldmVudF9jYWxsICpjYWxsOw0KICAgICAgICBpbnQgcmV0Ow0KDQorICAgICAgIGxvY2tk
ZXBfYXNzZXJ0X2hlbGRfcmVhZCgmdHJhY2VfZXZlbnRfc2VtKTsNCisNCiAgICAgICAgbGlzdF9m
b3JfZWFjaF9lbnRyeShjYWxsLCAmZnRyYWNlX2V2ZW50cywgbGlzdCkgew0KICAgICAgICAgICAg
ICAgIHJldCA9IF9fdHJhY2VfYWRkX25ld19ldmVudChjYWxsLCB0cik7DQogICAgICAgICAgICAg
ICAgaWYgKHJldCA8IDApDQotLQ0KMi40Ny4yDQoNCg==
