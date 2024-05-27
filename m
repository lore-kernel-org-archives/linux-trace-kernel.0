Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD42E26AFA;
	Mon, 27 May 2024 10:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.30.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716806982; cv=fail; b=AqtoxRegHFXAVBqCW8EED01b7/k5HzeTY1UJSTRp4uhjb/UsIBhxAC5x2Ag1iMk5GYDSEv9zkdr3KH//0V2mnAG6z1crLjvvtTqWHp/LBcJEW8LNjplW8NP96pax0ktjcj3sxCfiFMP6r7nMVFrAarg5tBjV94yUJ+d59Qyws6s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716806982; c=relaxed/simple;
	bh=6yO2Gjw6anrgbwWhZ5HAviEVn8akYSA5wI4kBUdapoo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=tOcW3fjNmad6NXW5QlMsOCDANGEtkectIpk+cALYmdN5zTB7c2FWU5zgoKwTPYLF63cDNTeW7V/4FAg8K6lhTGjX5mBp/UZkV0juWMc8UKwifMaPDMMbJc45CWPnXLKpAnRYhSOI00QwwcCBRZ3B0wVHIlyqEKHAVI12EcQWCog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=JhfiQcJO; arc=fail smtp.client-ip=185.183.30.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="JhfiQcJO"
Received: from pps.filterd (m0209321.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44RAOlRV002268;
	Mon, 27 May 2024 10:48:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from
	:to:cc:subject:date:message-id:references:in-reply-to
	:mime-version:content-type:content-transfer-encoding; s=S1; bh=6
	yO2Gjw6anrgbwWhZ5HAviEVn8akYSA5wI4kBUdapoo=; b=JhfiQcJOwJS2AcUpd
	GJeX1sn2/EXFwvs7bF8pl1yjquE3VmTDw06eTpY55lz9s2IAbGAKoiawwCUKMdQ1
	VAkYD7pXOHamrcgVwRy17MkXZBt3cIUEnX7n8U50fKxT0iDymYDPP0pHWmsbvwxi
	bigsXNrDNN+dh3T1d7RZs0Eqk1Nn7mf81sQihmxCefXn9eLS7//miiuU1uxGqnBJ
	HIVrnXOQMfONAqMhYPvTTWHYZdfFEf70nHXeZvN1lgtoGsdvylPG4xgvHoucdaIB
	IPenUn9+xyLLbbBCRx9uBefLMeYguRRBC2IPWi85Xr08JXELgZKrvOd+3ldMkACO
	oeIGg==
Received: from jpn01-os0-obe.outbound.protection.outlook.com (mail-os0jpn01lp2104.outbound.protection.outlook.com [104.47.23.104])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3yb816sh6y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 May 2024 10:48:54 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dd5qT6FjUjkCPlMueCO9b8nAx5/SwjlcpSQzee8WgdaThEJn7g/ogfhsmUUlieT+Pk0vjN7k90VIXdV+K+q6R1itGFjrodeTdjWfj17rSvDYzy4TNOdsr/z4aAg3MY3tzmbEfFBBCTbtM1+tKiJTnYDJShv78fhu7vtogNC4aJIOwfWrmKR6+eNnJrTdxu3LOEXbXgOv2rDnXGMFtM8l7S6Sv9Wg6+FMEW4xsNejFR/dcd59DyOBPszGy2Y7U+dFq3zeQ4LasGOXiyfO1msxYcs4ZD4/l7POMGyB0jJKTQG0eZepI/byak5oPRFZILWBt+OkzGyyqE+lNAKEQJGLCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6yO2Gjw6anrgbwWhZ5HAviEVn8akYSA5wI4kBUdapoo=;
 b=bchsSFn0dlwPoesVRC7PJW96QIXPweqHEWznPbZ+2mPrDNN9nli1yxQDJFH7tE7LpNUlyyEyQuZMG4ihDBA1lz7RMk2JFi/9OQ0O+8oQM8lEdcpZEeDBfU54SBgUj/AzuHVgDNmvHRWZN0qTBM+KFPmPTGg6kaaS9oEr5i+BQpyOAxhj4KwTWERMCopfgkF1sdt6RVKtJuxYQHb9+Tx3N8Nva8Z2IkrfuIoBpGcR7WlefTuG8utZMZ66xKIWC3EoSNZF9vyfsIdRxYnzOjL4LCxHF1X0p2F+qvAQ3/Muii4JqHeVpiKdlKDILqR0ywf6Yq0LDKNkuWw5E1RFSeQqRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from TYAPR01MB4048.jpnprd01.prod.outlook.com (2603:1096:404:c9::14)
 by TYCPR01MB6303.jpnprd01.prod.outlook.com (2603:1096:400:7c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Mon, 27 May
 2024 10:48:45 +0000
Received: from TYAPR01MB4048.jpnprd01.prod.outlook.com
 ([fe80::3244:9b6b:9792:e6f1]) by TYAPR01MB4048.jpnprd01.prod.outlook.com
 ([fe80::3244:9b6b:9792:e6f1%3]) with mapi id 15.20.7611.025; Mon, 27 May 2024
 10:48:45 +0000
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
Subject: RE: [PATCH 0/2] Improve dump_page() output for slab pages
Thread-Topic: [PATCH 0/2] Improve dump_page() output for slab pages
Thread-Index: AQHarBui1VU99TDfVkOfdaXpHtnA6LGjS7qAgAeiShA=
Date: Mon, 27 May 2024 10:48:44 +0000
Message-ID: 
 <TYAPR01MB40486F23D24F11E22974C802F6F02@TYAPR01MB4048.jpnprd01.prod.outlook.com>
References: <20240522074629.2420423-1-Sukrit.Bhatnagar@sony.com>
 <Zk39H2C_wxnbAvvU@casper.infradead.org>
In-Reply-To: <Zk39H2C_wxnbAvvU@casper.infradead.org>
Accept-Language: en-US, ja-JP, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB4048:EE_|TYCPR01MB6303:EE_
x-ms-office365-filtering-correlation-id: 48bb0214-d21f-4de8-b8ee-08dc7e3a949e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|366007|376005|7416005|1800799015|38070700009;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?br3NGqKfV2yhFE0MKVBlZG/bTDNuqUHU3sr9+Sp+SeqphfIPcu3++N9Ci7MD?=
 =?us-ascii?Q?PhoDSa5YLp6SEE68rmA1Ho+89kemlorWXiI4RCGakrzGIHxkt/q8vuvO4dvT?=
 =?us-ascii?Q?xP1DXoCR17VxXHuMLwcBv3gNJkXNs/PMxhcqVK6HIeNc+jRhGeq4uAm0wXGv?=
 =?us-ascii?Q?bOOnyWKTFJYCjSvQBoXe/0XV75O5okQw6fMGRMPZy1S0QjcXJD4DM5TyUBWd?=
 =?us-ascii?Q?C7LaGHijtqM0Hyk56fRJvAPq9ld8gkRJRmWSn4UbiW9wF6w8zfMxvNu+uZDt?=
 =?us-ascii?Q?ZyNTvEYkXKjv4sUPm3Aq747Xj02sF3Ov8xU2o/Y1yAhtztzr1I6UYCVkCTpx?=
 =?us-ascii?Q?57vtNu+oyoZt+Ow0mc+MykPReV1yAqfgBfciFm+U0Co03jIiqG0lOp7ALQYS?=
 =?us-ascii?Q?EARz4h3qymwq086cLINelKH3Zc2Dilve0kt6q6Gp4VeW8OsUE8bw1o0JnGil?=
 =?us-ascii?Q?UEvDYdfaJuFzUNiptW6ceZ7H9WQTDI+zNxAjqi1yrktpsDWZu+6tQ5hGcjbM?=
 =?us-ascii?Q?NIWCTVL7zPBqPHDYt+1wku9Otzox4Q991omrbcVOwL2MAh6bZLEm26aWhkpA?=
 =?us-ascii?Q?DLwESmn5xuJouzPu+pnqP4PUsmHWOX6stm3yBA6PhFucMkiMj2/Ftj6sR4XV?=
 =?us-ascii?Q?JUMletwODc1TcFsAqjAX/PyHPk4Exc65jrMUsQyRw3Xy9wVbUTOCwlNbzQDF?=
 =?us-ascii?Q?CX54ry7104CoI8/HczX5D+DhAaD8XLFNeXJQEmPJIJSIVRWV+RnP6f7rwf2b?=
 =?us-ascii?Q?O8sx2tU1NvKffP2aXBhZvkrPTy7UyNUIjxZvJ1Ewt4QhSO+PnswlgStGloYB?=
 =?us-ascii?Q?+djaqQAHyK/9TKeefwkdcCB1b6rz1DDJ4AmWiG9jDXvv47LPaH2/Fb/YOl3L?=
 =?us-ascii?Q?IXcBpdAh+Qa4qC2tn7O9W+szxPg4hpaIj0A8Htgj4vhZnixW+0xTMMiVMcIe?=
 =?us-ascii?Q?IW4CRdVyk6vfkHnQY99pAS/lY4AGiFYO3tjb6S2WRr9y66Q+ms4tvgZL6HfT?=
 =?us-ascii?Q?AEqDnH7UNfJBLu9/ydWxD9/2ruuSy5f/v4x9BGMSHyap1hBKAbjtQvDoqyED?=
 =?us-ascii?Q?aWjZzY4AnxMXYh633MxfDSS4qIgGjjO2xG3XHR6Z7p6BAh8k9CdSU64DZbYC?=
 =?us-ascii?Q?VSNS5UmQUhSpDL2WRWBKvvTMFVDwtoMHtpf5SkffkpiONHSfAU6/tjguqAaX?=
 =?us-ascii?Q?ZP/W1g+EofBzg+6L929hkh5AyGbDcSzcONyI00wbLx9nLi79k2Q7lTT2ncfn?=
 =?us-ascii?Q?7L7wk7ufNsyZwC8VBKh7gF5S5elKXO/rSBhX0EJ+jRzf4j05GVyrwa6yzaUj?=
 =?us-ascii?Q?Y4RSNw5RbzowRFv4NcNDrupFGOkxs3OjeV0TII5Qy9Qpnw=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB4048.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?A5jzPF5kygh/+RihXwTAiyiW5/8NbvNC3kL9A5e/VvIGi405K3x/yiIULQGx?=
 =?us-ascii?Q?wmaxzs8Dcx1okfoC3T/p9hGbAfXmYkgmwzmWrvZHwcoBhKPaJEd2ahc4R/k/?=
 =?us-ascii?Q?B6tb7EPTJE+qaiEwkHJT2CC1AXcikc7n88PNFB9vo645omrP6oAW/CmcTsWd?=
 =?us-ascii?Q?PTtvq9Yb+sgeslJKEoAEJ4WOzmGw1ZYtCaJ9dmaEr/YLBRnfa5ZtYw7nZ5+Y?=
 =?us-ascii?Q?1hovSUky8B6ngp0GV6iEf+FYjIdeFBeiS6AT5Dv1Q+aP3bS87qGX+W6MjYtV?=
 =?us-ascii?Q?+19cRvKhLLKnpMnrg0qxtNifTjgLZ0Ehgx6gN8IBIr5TzI0dwpjJbBXgpPq/?=
 =?us-ascii?Q?0VoK5Ri7gU8Eun1i1Kiqmwd7czMCuAv0bPiEAun/aLQd3zL9CTSAH02CQAtt?=
 =?us-ascii?Q?l1SeK1EboyjPfWJXr7BYVmzvne7mXRXskPhhhorXV26IbNJFtkmjf1I+11lb?=
 =?us-ascii?Q?9kbtJ4JimtoK8NCiV8oxWYDyPdqCwxXpXoo/p9QxwbfyNpCuZh+it7gyaA65?=
 =?us-ascii?Q?B2AlZeOURvO0XgoTa9jUVUYADClqwjNK1e9JMKd5txe7mVfONjsLZneHs/jS?=
 =?us-ascii?Q?QWZvj5xtdkd90EVQmEfo78Fs28zw+pq24r/6mzP1AldXJASXApcQFdWdRfmo?=
 =?us-ascii?Q?FFwAO+oWgxSgp1zgR4lfnzR2JLJtnxv6+pBVVSTQOucgRSW7XxKDAkaV+F+k?=
 =?us-ascii?Q?/CmyUDdWdv6kopxr25VGZfCkRpTGHQaCithZm4yZqIu4QHOyDGmSnkYY3NCi?=
 =?us-ascii?Q?CZ5LEG0WIs2rpsJ21hYNqGfgAglfs7yDPjz9jvD8c7fQvRr1SMOvVJhSeEL2?=
 =?us-ascii?Q?0Q/mWVwpJz5xaV610GUjp2DArCw8NgONsrMEnOe1GoMuShp8vf5PiV84gKBf?=
 =?us-ascii?Q?DOkPPWgafHP/06aog8oRSlUprSXiBozHd9XsjCm3ZZRrosFVxg7gJcKE4ZfG?=
 =?us-ascii?Q?M7dxIj2222KOTeGxyxQ576c05Z2lqezi0CyfMC6KLMoTEJvvgTXnRx0TNAWK?=
 =?us-ascii?Q?ul3a2mkqglG5JGdGzg/LupIq4XmjyoeGAbfZusmnHglFVJ5pHj15Q2P5t3S+?=
 =?us-ascii?Q?Gh0iRHeDU14U+GKDn2ob5Aq69K+06f+ViR3WVgTOiRYO4DDQVogEnAFlcguk?=
 =?us-ascii?Q?5AFAqZsZmuEygBlHpT2mKn6CRVBuyFHyK/cmBLBqaZfNIkunaSVf6H2ObW2d?=
 =?us-ascii?Q?rSI/WNCWf1Uw9lWKjXyBnxE0u2k0nYC7NB4jakyc+diBua35FDNs+nbBbAGk?=
 =?us-ascii?Q?20EwcW0stZYy17Fg3lSQab42TZBVZDEMm+o2C6LVYr6AtfsxIdzwAWSMKXRe?=
 =?us-ascii?Q?fnoBQ+AOCkdg8FgyCIVXSTb43Qwsdlg6JSYVXc4yt6dqkrSWaZjOeIywp19g?=
 =?us-ascii?Q?0rRvDxmTEp6q1VR0S0kvTC2PAoUJ2Q9VNfEJ/6hCEmTf7a+xdk7PIrecOQi6?=
 =?us-ascii?Q?DSXwSf6iolAMqpz3WxNwViaF6C1QVIRI3IxbowRLVXGd1lLCuv57IA9c1LB8?=
 =?us-ascii?Q?6xfqFOqiklLkP09U+u8xss+GH1JWdVQjmi2UK/Y8uLWJ43lRLWx0iqj0YLRE?=
 =?us-ascii?Q?Bjw0HVoVQTifKq8PWlacm5MfHUOHM8Jrzebh3ENS?=
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	rIsn6bWJ89NYiS2PQ0m3/B3FbOi/XQQ1+lm17m9XG1dERuFC7ItdVRlCVnMsWeIffPv8JkJ8b91QG+aXU+4/jEOzXNE3qJuaCC3R+36su7vYBZIe8656cKQUXkX1sHCZV2hLtJ8T/SvGKITmxRnajLKFNSBNzStwd+Keb5/FnSnLSSF6fpCPJRv61OT5lOjygS4eqbz/SNQ7rQ0aFiMplFLhw+ADvsT7ulC3l2q/+FkILF1pp18p0vAyhJ5DENZIM/cuKyGN+KzwKHyCell3Zk+Icb9Zh/4XuQpSY9MJf9HTZEcn1q4Nmcsi++k0OD24LWzaTdVkOrSErtLMPDBygt4Pw/2Yx77rmgYjfAyPgHk/Nf56iTOOJp8UxMzufUEuGA/TIZVdzpOz4txI8e8fW2V0enYi8oSR64rnSqNTEfUXN73hv67HEi0Q3Qj2bAhSb3ebBadH7ojsEMmsjs7lAJ0crHgkLmfXTKja5ONHQH5xG6tu6HzatYQO9CfOpp1gKpfPPDR1sW5Z/xrSDKFS0sUrEonxPFOZoUM0Bnb8EKRvTzln3VqgtpwfjvxHIv1LUyPV1aEoNWY8afk4DPyAeIrkkWDGonCmJEBXouXcSw7LMvL3Q4Gp9cPg9xlv3RuI
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB4048.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48bb0214-d21f-4de8-b8ee-08dc7e3a949e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2024 10:48:44.5809
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XRZFD1oiKFJTb397xLCR3RR/3pl3CQ67KqRnuvkxwV6VbnNaegMvxHrhtHrzdlfUe0l6Y53DT9KFxVl2bJCN8OaZOxHWePwydPUNzaGekzU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6303
X-Proofpoint-ORIG-GUID: h7qzXWtak0u2y7WJxSAWA_9DGzB1mthp
X-Proofpoint-GUID: h7qzXWtak0u2y7WJxSAWA_9DGzB1mthp
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Sony-Outbound-GUID: h7qzXWtak0u2y7WJxSAWA_9DGzB1mthp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-26_09,2024-05-24_01,2024-05-17_01

Hi Matthew,

On 2024-05-22 23:11, Matthew Wilcox wrote:
> On Wed, May 22, 2024 at 04:46:27PM +0900, Sukrit Bhatnagar wrote:
>> On the other hand, the struct slab has kmem_cache which maintains anothe=
r set
>> of flags. It would be nice to have these flags added as a part of the de=
bug
>> output, and to have a convenient way to print them.
>=20
> I don't understand why the slab cache flags are the interesting thing.
> Seems to me it'd be more useful to print slab->slab_cache->name and
> then you'd be able to look up the flags from that, as well as get a lot
> more information.

I agree on printing slab name instead which enables lookup in sysfs
entries etc.

The reason I added the print for kmem_cache flags was because
dump_page() was doing that for folio/page.

Another thing I noticed in the per-slab sysfs (/sys/kernel/slab/$name)
is that we a few entries for kmem_cache flag enabled/disabled output.
There is no entry however which shows all flags.
The slabinfo in proc does not show flag info either.

Is there a need for showing a formatted string of kmem_cache flags in
the sysfs?

Just trying to salvage the %pGs patch in this series, before I have
to discard it... :)

--
Sukrit
