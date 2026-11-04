Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.23.24
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793784118;
	b=u/zdgtUWRO6lb1Gd39X82KLl+SS8O41rY1YoIsx2Op23LAd4XpVWPuongHN/ZbOfusT2
	 Fc067+3Tj+KFjOJIWIi5jMCQtaMsIQydQVD2IUMqqrPaqBf2V1B2XQci9HIpvWetLS4BZ
	 f+mcRiBikbjAn/kfGYUng47oxPmJNJ4uhl/tYmiNujVOCPFJHSbnKdC5GapK96+ClQzP4
	 glS+/tPPHX/HuJwbIt2j8SdZig4WgWYRKP8DL/prS6wHzr8QEBF8l4NkXd06FVaH0B5Bh
	 Fxe/QmY7RF0kQpd0wkC/2rKzlgHFPn7PR8PXS/5NlkeZthPZfd/PdnSkX/dNCQNbv7w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793784118;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:
	 X-Microsoft-Original-Message-ID:MIME-Version:
	 X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=GB16gfgga40/BxKVT4QFetANKVOJ0puy21Fu/HA43wI=;
	b=uaZg5kvTwWlWQg3CAhPfhbG2G3HxT2LraL/gfJRU1VDnz36J7TIos1BN7y9J9LJcPLEM
	 t1t44AK20gQaaOICqCkrPGJjx5dP2LghUZY1+l8jRmNG6ssxEFSno9cLem65jmQEB6rD7
	 yMjy9DxAJvY5HOxs1KAsNERRNf7kM25Zi0ea+RZXnCWdB2+FOA+UYBUwsa8JOI0iO6AX5
	 hcBfl+FXszRDlOsobxsSwQSBJoJFyLq1mEo5H3bHQ8K/9p+SAJ/EXHbHHJlsAN3i6KvhZ
	 BGjwRfDAt0cPyeDWkWC+O9Scpn60axQld4oV7mazjCHitmk8Ktlg67f/YYVYpEjxrWw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hotmail.com;
	spf=pass smtp.mailfrom=hotmail.com;
	dkim=pass header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=jptBL0w3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.23.24
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19010024.outbound.protection.outlook.com [52.103.23.24])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F08F606D806;
	Wed,  4 Nov 2026 09:21:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F08F606D806
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256 header.s=selector1 header.b=jptBL0w3
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tr49kuhVyGoBGgP3bMgl6B4TosGZTymOEWned0ecG+wjheQKAk/nmlBq6/7MRKWRVtdcs7/MTsQYyTA/6zU8uNHWh4HfM1hm4AMQ6je56mMlCBfGKxY7OrOmFBD9SBuhLgYCRJXOYPwfZg4XPCBIKpRLigGZnYBHhc0mqISLdsu4Y3Hvpwo8o8KH0bVY/Q0N8zqJShjhp64zq61LC/iA085yQ0hzyz/Hz7hMc0R4w2raWRgAJlHLNnBfhdhOHJQm29ZpJ4WMk84eCiBShpgZSg6LvtPMs+hfZj8HkJ8lpucYiTlQ1ob/xRu3g/j9sqHdp6FXQTK+B/J34qgmAc3eUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GB16gfgga40/BxKVT4QFetANKVOJ0puy21Fu/HA43wI=;
 b=GQ3TvB5NRRbsKYvGW5F0eKbEa1G4A9z5whQQDC6+GqJ3+88ZDA3VuRvzo2/Ijxa6KZGIBo6MV8/LT3IazMke/r0G+1zztGT4yGolGB/H5DVNLsgzxxBzTyNOwffW2T1pirq9LHSBv2aJoJDL+WT46MHHVS7yvVg2zxSYK1fUEsC1X+8CPUxoC6a41GHVD3AMa240CRF4w+2Lwq8MRLOiTtSyjFN1p9yhmmlK0Va1acF3/ozm+5wnjVJNU9vzHSdwgO5DreXW0GtdNb50MU4nzruZ2K4dh4wM0HkoLxQ6vTuMsFmoBj+AiULFE/xz0RjXid+AB9TR4fE//z5cehUJ2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GB16gfgga40/BxKVT4QFetANKVOJ0puy21Fu/HA43wI=;
 b=jptBL0w3s74NoHjd03QcBe6ZzZYWgWgJ3XbHVq996204vnnzbEUg1ABBFFkxgkvswNCbzcwQVNsrEiI5h1d6i9H1581PWr/hnBD9CgDODTeS9KhCSZqiyqMjrjV/IhPvb2GpbivoJKYBqn+qCs/XO0v2Ep9DxJH+21+N25sCtkACFNElRRqjfJmQXTCdI0j6Xxw6UhEjUUsYxUkYK5g/lapbJJDhMlV80SyCNsS8DYXRiPVAhfXP8yPbhdooGaF1PlsTqlUxwcOCnqlIh6O61uSnlarNlKdyNOJLUNQDEs6HGXMRMGTKG6YW3tSBo2JWYlDxXy2c+ZUTdiTsX/GYQA==
Received: from CY8PR19MB7009.namprd19.prod.outlook.com (2603:10b6:930:5b::17)
 by MN2PR19MB4063.namprd19.prod.outlook.com (2603:10b6:208:1e3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 09:21:56 +0000
Received: from CY8PR19MB7009.namprd19.prod.outlook.com
 ([fe80::905f:ec34:5f65:aaeb]) by CY8PR19MB7009.namprd19.prod.outlook.com
 ([fe80::905f:ec34:5f65:aaeb%6]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 09:21:56 +0000
From: Wei Li <liwei1412@hotmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Nam Cao <namcao@linutronix.de>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	liwei391@huawei.com
Subject: [PATCH 4/6] Documentation/rv: Document the enable and reactor states
Date: Wed,  4 Nov 2026 17:21:23 +0800
Message-ID:
 <CY8PR19MB7009639C5B099493CA1E0CB2B7682@CY8PR19MB7009.namprd19.prod.outlook.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <CY8PR19MB70098BF493A3B67418C7B9ABB7682@CY8PR19MB7009.namprd19.prod.outlook.com>
References: <CY8PR19MB70098BF493A3B67418C7B9ABB7682@CY8PR19MB7009.namprd19.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SEWP216CA0095.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2bf::15) To CY8PR19MB7009.namprd19.prod.outlook.com
 (2603:10b6:930:5b::17)
X-Microsoft-Original-Message-ID:
 <20261104092125.915254-5-liwei1412@hotmail.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR19MB7009:EE_|MN2PR19MB4063:EE_
X-MS-Office365-Filtering-Correlation-Id: fa82a36e-2cf6-4341-95eb-08df3a5511f6
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799015|25010399006|19110799012|24021099003|260925184616899003|15080799012|5072599009|23021999003|25031999004|41001999006|51005399006|40105399003|26104999009|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QhX5MgZ9ysba6KZYb+yVF010puQ4tpTVIlG4gkJRGGGO8fFxcf1ltjZo2qru?=
 =?us-ascii?Q?8QZLcpCB3mV1gK08xZZm+BTMWytEHj+sSrZQWAAA9JyJfjm+wDFqYz0GTUKS?=
 =?us-ascii?Q?UFOq8vfgvmRM+smvYJwNjHM1jfFlctwAhWvgCiiQi5vuj/Cpbfe3S8vwsSY0?=
 =?us-ascii?Q?cZdIzYtJVMgj2GDqcFUWa39zFhpJbPr5cB8nUODtMB8EBGlM+3CNuVS67x9y?=
 =?us-ascii?Q?+roFTalBc7dA/uTFXTfOZCaSEFWo86t1dRlpX2CLVkBIlX+CEy8wVIRf97m1?=
 =?us-ascii?Q?MR3ODOYfksos/E0HKofTnri7R2BvthpK5lX14sTLVDP/Wulr/52Zp9B3btWy?=
 =?us-ascii?Q?+d7IPusWi0AD1naOt+69wX72Uzo9BJA2tL5inxh51wGWUKYDigJr5cgWblVI?=
 =?us-ascii?Q?IffRPNYGu7+xY2ukqakFLtdiU5tM5Y3RvAvA2AaXXY+sx1ephVbpBhLrK4ia?=
 =?us-ascii?Q?kIY+H5E5NRX9g6zI+gN3D2KAvpusGaNm7RkZxFhyWI65BW8iV2J9mKwqSb5q?=
 =?us-ascii?Q?AGIpQYgwxMqh0fOd9y+p1sx9xOZMkwSD038VciVMIHAA2CTQ60qEvI2c+Pfe?=
 =?us-ascii?Q?NN+/FIRp8LRU3pRu1X3sIMqIPhppzCgmW091aMiWLyS49hfLGXBjItuE9jAJ?=
 =?us-ascii?Q?WPNtrfki0AvaeNQWkG5OiJT6ocO9T8WNLLcNSt5JbQdCio88WjrkbzD5QvP/?=
 =?us-ascii?Q?dIAaWc3DVeqttIrbdsSL8tuAHYq33uCWr1B72DLID72lwZ1o6OJoe3hqQ0ce?=
 =?us-ascii?Q?zAZsoQorR6XYwTdV+OmAc1c3QJG3Qkbq8K8sJTqMm9nMQ+g1HS7EMnzNO9rL?=
 =?us-ascii?Q?69c5NTwmUZHUmKaO6Zqy4boMwt+xuwpTBVnegOU4gZaoFyrmmo/McNFbDqxm?=
 =?us-ascii?Q?uAUZVDfph0CovM+U40S6356Hp1Gm3EKMJeMu2dI0Ja0V+nJSgeT6ERASDHoO?=
 =?us-ascii?Q?G64Na8SLv2Zk/UeKVpesYs9kpUrMv7yqGfRnbZWEsSXiErChf3Nv3guzim0y?=
 =?us-ascii?Q?Bn0a?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aFEwXRxiFl80B6Xg/1S/pETtaReo9QJ7JsRxTqY6fOBUY+TBG5sT4UUlempy?=
 =?us-ascii?Q?S3MUigxWVCkK123rpPBzb3DnPSzWBUBxemwJ0sROHLkkuUUsU3kOi9zg9ELf?=
 =?us-ascii?Q?Y8bZ8OpK1BcmwCgRepRqwhi02ACssG7D32eDdUgv5G6m4ZVw67938SWPFIwG?=
 =?us-ascii?Q?+UAVBKobkUvK0yqIhGdBlDiqTJZkVm2fGfUode/3s+owwCA15NNaPX3BOVv8?=
 =?us-ascii?Q?TJ5vghA8hLh5MWBFxCUXZPTyJEoKWRvVX/+zGs0Gl3Kq7KdUrELkvvlHHV+W?=
 =?us-ascii?Q?FqQS/mW/UOLed6WDx7XEQUVZ+BE3DPxSfrAHQb/vycWP9tdQ/sK/Os5NOdiR?=
 =?us-ascii?Q?dvUAoRrwne30xiLqndywj4PGCiToc9GJMe6PN8XB217VlieqemAsEcybIxXy?=
 =?us-ascii?Q?l4niXpr9XXRfBASildgDZPAXM5vnR/EnYa1KyesqwQhk4aQ1Cc60L/0bYmMg?=
 =?us-ascii?Q?tq4BhnipHygvmVRqL8cvb6HjOLX7MqIlIiZZI7LAo9zbq5sBUagCSrfBk9l7?=
 =?us-ascii?Q?3gNMapNE5/xjs6mU40c+Q33WyOJS1W0ShSeTvzktm5puxrbMoqMwPhdpntUY?=
 =?us-ascii?Q?HyL+GQjjRLHoQi7nzs852lhbPTGvvqQFKnTIhXrdfDvXjzu3tpsVmI6FDAzi?=
 =?us-ascii?Q?z5POnOoJmVqJWOwX9D7YdTKMlPk+rhI0rzXKxf9Oo1RHbYnVJJz2I2m2936e?=
 =?us-ascii?Q?wJOFyZYtFRGBom+b2rGfI0QF1SQNjIexUYH8J2jppmPlIfbxMwaecPDtmkbp?=
 =?us-ascii?Q?PPJuInYcfON4ikIl1qSU2UVR/xlzAC25Fv0wpk9bl/GZ+PVyDEsznYBWQFUA?=
 =?us-ascii?Q?B2dGNtHvRKpTELa0jVZT5W70XrefuEklARAd6uBYPHT8SJx3NgOQoByNOmpm?=
 =?us-ascii?Q?F4p0GPGpvRu/jYJI4+7c0D5LKeLoVLUHVZszbzvm2OJbDbsO2doFFpwUfuoV?=
 =?us-ascii?Q?P1kGyk3VNlMAIZLeKC2rxPuIHYbPOgz1KARaI3iyWuGlnz+8wn2fRoLkIrxJ?=
 =?us-ascii?Q?Q3+ZA6BwCjHXmWFYugyhQFVq42b0MbcLyrBIeqCYKcwH4EXHRt3TSSVYsT3V?=
 =?us-ascii?Q?UM83f40eBsjQwIG6GMs9H9MG+HX4zTNDjNI8t548OH0NKoRLm1K1mtsID4r1?=
 =?us-ascii?Q?LULDucg44Cj1vWGWvu0EHsVQ9eIK8wpL6tk0dTWvRy3eKTt+W6GKcFXYO7YW?=
 =?us-ascii?Q?U+iFD1r506JKbGCeoVneOs8+b5XfOX/MfLL3Rbrxp+rQNscTjiZqa43azar4?=
 =?us-ascii?Q?fp/eQO8/95uv93Zjd1f3FnqEzrf0/nk4wwqytMnAkI+ciODqz2vfE/oZvVUU?=
 =?us-ascii?Q?2FiMhLbiOdFA3PorJLs8KjpSspAhrEhOvWBEsOKCnCd5xf3W0t66KVrGo7BM?=
 =?us-ascii?Q?o8tI1/nPqQoxGQSblmsBvm3BMTr+?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-990eb.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: fa82a36e-2cf6-4341-95eb-08df3a5511f6
X-MS-Exchange-CrossTenant-AuthSource: CY8PR19MB7009.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 09:21:56.1773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR19MB4063

From: Wei Li <liwei391@huawei.com>

The "X" value of the enable file and the "*" marker of the reactors file
are undocumented. Document both in the monitors section.

Signed-off-by: Wei Li <liwei391@huawei.com>
---
 Documentation/trace/rv/runtime-verification.rst | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/trace/rv/runtime-verification.rst b/Documentation/trace/rv/runtime-verification.rst
index c700dde9259c..0d9edb687836 100644
--- a/Documentation/trace/rv/runtime-verification.rst
+++ b/Documentation/trace/rv/runtime-verification.rst
@@ -210,12 +210,16 @@ For example::
 
 - Writing "0" disables the *MONITOR*
 - Writing "1" enables the *MONITOR*
-- Reading return the current status of the *MONITOR*
+- Reading returns "0" if the *MONITOR* is disabled, and "1" if it is
+  enabled. For a container, "X" is returned when only some of its
+  nested monitors are enabled.
 
 **monitors/MONITOR/reactors**
 
 - List available reactors, with the select reaction for the given *MONITOR*
   inside "[]". The default one is the nop (no operation) reactor.
+- A "*" after the selected reactor of a container indicates that some
+  nested monitors use a different reactor.
 - Writing the name of a reactor enables it to the given MONITOR.
 
 For example::
-- 
2.55.0

