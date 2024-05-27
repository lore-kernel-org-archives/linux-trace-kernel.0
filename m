Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24FD50263;
	Mon, 27 May 2024 11:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.30.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716808737; cv=fail; b=Q3/WVMjXSVk0wPfczoEwpc9O5Mh6QmomLgnnCiITFaA6p6jJ1xz1PiWi+uldpWEan6qh7QFSkRytgIiflZLnGf6/9wTv0vHVBSJveqXbOqI68qflbJJoLh/bIzdmYcmYgCntb1vSqoXZiAwme3PswJgTROux/aYeGYNstJza5b0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716808737; c=relaxed/simple;
	bh=CSfcKhBMGmqF9Y4ytXBVzCcKwd1W98MbvenbkV4VK/k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=YOVp7bdM5YHZcWSlVBHs35q+mLodSI+pNj353R7wCi1kOzT09K/vG3zFwMt8J44flfM2Tkx1OvZ+94pTrKLTlvBDUsOAPgi8bSsqh/VZaBOJd+q8CbiBdTCTolhGfWJGfkh++w1vQOV+ijMdxEX/S7DJYzoTnQuGTyaX+S0XwaE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=IV0gq3sg; arc=fail smtp.client-ip=185.183.30.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="IV0gq3sg"
Received: from pps.filterd (m0209318.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44RAO72J026624;
	Mon, 27 May 2024 10:46:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from
	:to:cc:subject:date:message-id:references:in-reply-to
	:mime-version:content-type:content-transfer-encoding; s=S1; bh=R
	d7ZoGnnuBqe93/OkeG9bOf4LX6GB8kqTKpjE/+uqsU=; b=IV0gq3sg+QByg+5+E
	23VYy+5LVkc2stjDy8GStHTCLiylhd7VED9KJ+hUbn1XdsrHKdW2qJatqcswFXnz
	z/A2maNSsQZTImmeG+GLzgaTHttLmp/i9DzsXGMIT0b02hKBtU4Y9nqwrJU20mpy
	Gh2OFoAV0mZtwfdQlulVgKgvkMk0ijS/uWocnyIBuPQ5ucyPZEHRZhBHR695hu6P
	2ujP052CV0vFnzLnbn6fQmg468JxH6jQ5Q5mfaOPoupil7BMpfvRhrxz+q8KjK2T
	RkNJegH6FOWBT36fkHvs7gfgRlqxqTXZ6Jav+78ikaTrcD2YwjgxZexElGYCEvCT
	GzIRw==
Received: from jpn01-os0-obe.outbound.protection.outlook.com (mail-os0jpn01lp2105.outbound.protection.outlook.com [104.47.23.105])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3yb83b1h06-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 May 2024 10:46:25 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g3nufA9LxdXv32+/FIff146tuaLFBk3PvPDXsCsoERNhsTLkg1ZGdP7oq6jcL6BaVcoZ1euu1Fp2VojOfKQKtwIyrc03n8OBzACXV/PEtUkMmrdzsrFqdnhm4/cOPBUoSEMVMySULpXG5KpZf0JrRsLFjeGHzBDd4SdThl8Y19dQHWjQokMQ+07weQqrb2b8xOX83pJCVMiteAIGtGcu4JGQY7+btUImrBEKWHn5Pol/D+eCd+S1NNV69RAfuILeLa2m/wwNAc4ZPqzQs1y/ycslyQnHBtzAg/U9OzIOQZGx8LK6+0g18dQyOLEmWqmPb0X6M8ezvseK42XLarRLmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rd7ZoGnnuBqe93/OkeG9bOf4LX6GB8kqTKpjE/+uqsU=;
 b=AnbMg9osmUDZ23VVFMBFj2aQm69i5JYnBJj89ZtEKXZ8qnYNiskAJk0PWhgMrNgG8j+CVpy70f6xraJJ/6hNZqXv3Cf0NQ8Fuh2n4kIK4Y4dmLWIEudHZED8nAjrGdi50sZUDI6uOAHRfs1il9WokBehcEJJj/TvneoZyFVelxDMFN538bjNs7NJ/cjAAi8wG68dh9p8lHPbQzPwaRqrfN8fz8EgMiyVvMfQ1Xe3RCMulONEB0llfiIGE9mWu72drt5PzyJmfv1qzg3TGNYyF7fA4c2TMng6R4b1FCoNQ9Z5kraQzgJsMNY4p4Iqo3P2qeJAQN41XB9FhbfvvnE2/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from TYAPR01MB4048.jpnprd01.prod.outlook.com (2603:1096:404:c9::14)
 by TYCPR01MB6303.jpnprd01.prod.outlook.com (2603:1096:400:7c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Mon, 27 May
 2024 10:46:19 +0000
Received: from TYAPR01MB4048.jpnprd01.prod.outlook.com
 ([fe80::3244:9b6b:9792:e6f1]) by TYAPR01MB4048.jpnprd01.prod.outlook.com
 ([fe80::3244:9b6b:9792:e6f1%3]) with mapi id 15.20.7611.025; Mon, 27 May 2024
 10:46:19 +0000
From: "Sukrit.Bhatnagar@sony.com" <Sukrit.Bhatnagar@sony.com>
To: Matthew Wilcox <willy@infradead.org>
CC: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>,
        Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes
	<linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>, Christoph Lameter <cl@linux.com>,
        Pekka
 Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo
 Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] mm: debug: print correct information for slab folios
Thread-Topic: [PATCH 2/2] mm: debug: print correct information for slab folios
Thread-Index: AQHarBujHL/xNkAGiUyj8nEOMN94/7GjL+8AgAe8CtA=
Date: Mon, 27 May 2024 10:46:19 +0000
Message-ID: 
 <TYAPR01MB4048A7A5E95A4BB4BAE9A202F6F02@TYAPR01MB4048.jpnprd01.prod.outlook.com>
References: <20240522074629.2420423-1-Sukrit.Bhatnagar@sony.com>
 <20240522074629.2420423-3-Sukrit.Bhatnagar@sony.com>
 <Zk3lzjVbXVrLW0XR@casper.infradead.org>
In-Reply-To: <Zk3lzjVbXVrLW0XR@casper.infradead.org>
Accept-Language: en-US, ja-JP, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB4048:EE_|TYCPR01MB6303:EE_
x-ms-office365-filtering-correlation-id: 98b94482-785e-47e6-e855-08dc7e3a3df0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|366007|376005|7416005|1800799015|38070700009;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?rLzTOkzuwTvfDzj9ThsR7SkYD0bYWZ+IcrrritiaEnm8rqQ9UANr6pPQpjiC?=
 =?us-ascii?Q?HxQOndLNYoJqXCdDcZRqav2W3ozLPRHuAcKMeF+7fJVYhdJOqGulFW0GSwug?=
 =?us-ascii?Q?73aBzIPjc9ww/PPFc++AgsJTmwpn43L1VEXYQcxmdcSDsmr91vxFguaIEDxX?=
 =?us-ascii?Q?pFJIw2N8gVTt9tjUhEYpui3qfXSuG8isqawjSdFOxEKxfoFdXwm8topKYfEu?=
 =?us-ascii?Q?+j1yLgyxY4j/G0Ca2UPmeCP2CycPzbq5EypQyqT46T5c4JkJ1g43e09pHfkM?=
 =?us-ascii?Q?q36ee/Flv5GrkQ993kzwlAlkOhcKAli0zd5ob5Z8gmuhvpxLMMqEtKTj0O96?=
 =?us-ascii?Q?mpJGU8l+1gqLihgh+7rSyLZNSEgRtsSChj4L8AN0QQcwCBB8TZfv1po56pd9?=
 =?us-ascii?Q?ILHqDImM+p08XnnU/ks/916lDxVI1jnyRTkBJPPFTHBb26cdOkrO0dxlzszR?=
 =?us-ascii?Q?y/Cv4X16OiwISogSF9wJAIFP/pXGJR3Ocs1b6lwjb7V1Y8N/2YZP75Ft5gfI?=
 =?us-ascii?Q?PVXz04JKx+TJ+5oniOSLvxdlXgZsVTVp35GvZVlhiQdvTQHAnpFBH+GQvMar?=
 =?us-ascii?Q?atK3Hwu/T/sg2qTht62DkBLoCYrUMDl2M1Q0pshmwCy46CD6lFGcV9nE5S6q?=
 =?us-ascii?Q?HfuH5zeFbngS7SsWp6yPNDlCmOkEwDlXEyFOpeKOGDcoq0AN6p2M8+N05UVT?=
 =?us-ascii?Q?5FXswNWfgt94TppOJgqHNX7Gxr1QNGd1uh7pbm2vkh92V5xTsoG+wWHhGFfs?=
 =?us-ascii?Q?fFh7WKI/qajH5jcDMFHcvWUHuBTnLd2RfNiK46RvmX7LxZbnleJaSZDtEPXY?=
 =?us-ascii?Q?BtRGD3GeKTDxWODXQspPRW3Q2oZQEErv6TjZIgt22PK+j1HIGm4Mxf3LE5b8?=
 =?us-ascii?Q?ZC/avnIosRmfRHGcuWvW+7LWsBF2WtXfyiAusF/GPF3zrit2Zv9gdOF4S6zl?=
 =?us-ascii?Q?9pMQZhENRVO+Y/vOUTPzSRf/6f3w13UJM5NNPQZqLxIubnhUKBE/tOJhIIQm?=
 =?us-ascii?Q?S55bvEdHSRF4GwKA0mOMkNYQWsHu2jM4xoEOn2tijxhFZI0M7SQO6DtbGM+Y?=
 =?us-ascii?Q?t2DI6bgKIWmglPHjelB4NazH2y9FvP+Ps+vdhuU+uXyA71V5a0TYTtawUM21?=
 =?us-ascii?Q?8s5hQRrREqBQ3vY88uUq8qTNcrX9BFn93ewHv3d1mGSweNb1hkjYzu+r2BJs?=
 =?us-ascii?Q?QBZlxVmTj2cug3v3Ok5iBEVmKdnDsmL3FBOUgQhT6vZN7nGCUSodQJ5dD1zl?=
 =?us-ascii?Q?ItrheHiZmVQ6GK8IdeBTNjQqNBsbXJalofkTXUU/9db6LL1nbmKK7c63mUw2?=
 =?us-ascii?Q?Kd5VXTAfA8a2Orsi90ROGMLQHhI6Jm/DRgWEC3gD7+Ck4w=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB4048.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?+ajgu1Wp7E4QPELBh1Q6G79kflYCPc31zZYMKYVDu93GySK+IvJRGW8qzpga?=
 =?us-ascii?Q?O+pr1it4+IPDHgKPTaHyi4vTBNvJ8oihUBaCVEl7WjIOp0abjXJ0y5JOBYTQ?=
 =?us-ascii?Q?tPWpDGmrtNbhk1VyFR8wiHMGT9JcHjQ57/kbJz/N22T5VQHHpsR/h+lwLAAj?=
 =?us-ascii?Q?IjNOmymqkMg8HEL562ckxYHeZAYcKG7icG0IBRXPHHC2AoPOVb7JsQLaQ/VV?=
 =?us-ascii?Q?QuQIl9M8DHWv5HYzyy/+4ClmlWJVRSW04cms1J8olK5p+009vbhVJKXoN9nK?=
 =?us-ascii?Q?w0zgdk9XMelclQv//3vlpeRsi8Zt6CkwQmxjBO42n9ZUEDcGIr6vKfwHYzIJ?=
 =?us-ascii?Q?iFWM3j7HcHsGk2pwiEc3Pi/cIFplbq/a6s+BWCUJOFaXP6TGdyf1+w+GgJ8X?=
 =?us-ascii?Q?AVXUczWGPy1KgPMtZ4B/qJexy5jLLvEyscyjGqHqvX5UoY/B3C0cfkobBmDn?=
 =?us-ascii?Q?H8zcl9igcEh3my/n9HM9L74IK4vHJIIyuQHacKSyqmcqVwy/PhD5ewC7+KX1?=
 =?us-ascii?Q?4kAHL/lMfe9Pb2Sc918mFIOIvozsp2AlhTblQD1Uvs1FUdgyoJU7kiw/DR0P?=
 =?us-ascii?Q?r0D07LG31g7sOYR8RZbVC6Mayk8RrfHgE4gBLSPKJT3ZW/xmmX1LlftIAQLq?=
 =?us-ascii?Q?Px90OYy29CegkkqG4y7o0OhYrtMbevUOXOnp0jwHBtAvURK8grntavmngL6S?=
 =?us-ascii?Q?YNJOxQ3Q0gSscfmMvsQT+XgpCa+gX+XEQVO9fJFrKeDTxc6HS8S8IJ+cKI/q?=
 =?us-ascii?Q?jrIDWDop+7d2xG+iCPRICERQZ0FAbXGcXDUg5tmn92hc2paaaKGzm6oPnlot?=
 =?us-ascii?Q?cS/GUJZdMTnSSCv0AQUfdJgcnA/jbfBeD9l1ojQa732CoS8yq62OyalQcni4?=
 =?us-ascii?Q?JBoEp5ZVemMb0o8r8L0uMV0o8rzoadbq2cDnA/t/9r9IrJlMsCm4O9BiF4TT?=
 =?us-ascii?Q?wNm9CX7Bn5fLpQGlUhPtM1IFHZOJ34T/BDhLXLZgRyqpgzB16FGuK6WVShBL?=
 =?us-ascii?Q?8YM56fdSywyyRJp6Psyj3apfUh1nReIjT4+8MikejatSGnSlvhdAbV/azz3w?=
 =?us-ascii?Q?b2mMjKR+DIprLq9Z17FKolHGLOx0v20dZ0m4ZsLndWPXh9XufbrRzvwDAq8M?=
 =?us-ascii?Q?HiNXuMp9rXdEouSqmi1S566HyIppU0DL6xZ8sRq1y8YI6eTEtk6Kh1RIDYqN?=
 =?us-ascii?Q?lt0HDY83sQJ7Yy767bWaaoHzsvYjUELAW1h75e+fHAiD+DsyAbt0Dw1PPioe?=
 =?us-ascii?Q?8NmFaxH4vDPg6h1sU6ItRw19JzPreOy7s2egSWLt1UNyB78l2OH7H7N4Q3wu?=
 =?us-ascii?Q?mr0ijVhOrchI+CV/UhG+p4xTraabQbSYKdcn78hzU8TM42VDfag1rm4pH+xL?=
 =?us-ascii?Q?8ibyH3S9xzKY2MiV+EhWMilePzVxuQZFBRZqFSctuWQti5VdVYMFfK0ZgeiC?=
 =?us-ascii?Q?wO8Uts/gdBH4TihmtY9UOLOSc4ghJdmxieO8N/+FVD6mqjw6R3Tl2OADJLH3?=
 =?us-ascii?Q?apSrUb1BsNFXYokcF2T2BGBxOfYzeXjGSlegk3lkEswv53WYUbTb1afp7sRh?=
 =?us-ascii?Q?qHfqQwHzBtqedqycG0RzjpW/5keXlQMsXFLaS2Fj?=
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	knUGBC+SYWzlu/+CzFOSd616ppG6YMIvcZ5c6htfwrK4ZQXAGqUc9trFB+dIy7+zpBthXOp7fd2HlBJ0PIUw8bHjsZ7w2cvXVaeRcU6y76EDOQbJVx4WR25VEPmL9RjTz/k2ITMXUEJ/EpbY3gevBTKrJsVcB6Sw7G8/EeLCJNe06TgB8DieQ+MIgzN8Gp9F/g60YAH+dtpL1rr/1jX3w9cx3vniFs2DFsmfkknBATbcCV1d001sbWOS6uNepHSY2PoIbbAXLptaMKV2fc0wkZKwrZqZcBTqOvL/odtH/YZ54xuMFdWUTc2iBzAqXRVYzRORfK9BcftOSFGb+uBDBHtGJN58yhpRx7ymDZHYQIG7mldALw3cQa2PhtX01xc7ZsgJje9nrZC12olZsjnyxdRVmpV+kkmhDE7o9Ri2QlaX5CmdZsmcy5bGrvPw7jhVCGzODDFLtaxevHgkA5Z1+yYxYv/D89Bw5GXzS6T7zxd9uQ43TR3lPD4Th/75u62uoxfEqO5EQFbJM0RUBb0Yc/xMhAbYdqO2YvRJW65xLkitehFSKV4bkAgYlxQQf4jrZT2LO76wGpj2cy4QoHxjY/IbqssYAB3V8NFJyUqBHZY+zD5uLcRZqUEf1UocT0lS
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB4048.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98b94482-785e-47e6-e855-08dc7e3a3df0
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2024 10:46:19.1960
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZXsrT8qotow8fMUKLnRPIYhnUoVlNzBDiaHtvlPdXdqgM+AgygbV0KItH6uKjqW5FW5imvcJe5gpV4Pa2ivfUAKdEAEQKKDvqnATJRHx7+I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6303
X-Proofpoint-ORIG-GUID: YhF108i88Es6Oa7yQSJtmFQaYIyXdSIZ
X-Proofpoint-GUID: YhF108i88Es6Oa7yQSJtmFQaYIyXdSIZ
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Sony-Outbound-GUID: YhF108i88Es6Oa7yQSJtmFQaYIyXdSIZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-26_09,2024-05-24_01,2024-05-17_01

Hi Matthew,

On 2024-05-22 21:32, Matthew Wilcox wrote:
> On Wed, May 22, 2024 at 04:46:29PM +0900, Sukrit Bhatnagar wrote:
>> If the folio tests true for slab, do not print information that does not
>> apply to it. Instead, print the slab flags stored in the kmem_cache fiel=
d.
>>=20
>> [    7.248722] page: refcount:1 mapcount:0 mapping:0000000000000000 inde=
x:0xffff888103e6aa87>
>> [    7.249135] head: order:3 entire_mapcount:0 nr_pages_mapped:0 pincoun=
t:0
>> [    7.249429] slab flags: 0x8000000000000840(slab|head|zone=3D2)
>> [    7.249664] cache flags: 0x10310(HWCACHE_ALIGN|PANIC|TYPESAFE_BY_RCU|=
CMPXCHG_DOUBLE)
>> [    7.249999] raw: 8000000000000000 ffffea00040f9a01 ffffea00040f9bc8 d=
ead000000000400
>=20
> You haven't tested this against the current codebase ...
>
>> @@ -98,6 +101,8 @@ static void __dump_folio(struct folio *folio, struct =
page *page,
>>  		is_migrate_cma_folio(folio, pfn) ? " CMA" : "");
>>  	if (page_has_type(&folio->page))
>>  		pr_warn("page_type: %pGt\n", &folio->page.page_type);
>> +	else if (folio_test_slab(folio))
>> +		pr_warn("cache flags: %pGs\n", &((struct slab *)&folio->page)->slab_c=
ache->flags);
>>=20
>=20
> ... because page_has_type() is now true for slab; there is no more
> PG_slab.  I think you also want:
>=20
> 	folio_slab(folio)->slab_cache->flags

I didn't notice your other patch about removing PG_slab; it pretty much sol=
ves
this issue and much more.
(I had created these patches a few weeks ago.)

> Anyway, we have print_slab_info() which is currently static in slub.c.
> Maybe that needs to become non-static and dump_page() should call that
> for slabs?

Thank you for the suggestions.

print_slab_info() has a slightly different output string format, which does=
 not
match with the dump_page() output style.
Adding it as-it-is looks a bit weird to me.
Other than that, I think it may be useful to print it (which would happen o=
nly
when SLAB_DEBUG is enabled).

Also: print_slab_info() is printing the folio's flags. Maybe that needs a c=
hange?

--
Sukrit
