Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732722405ED;
	Thu,  6 Nov 2025 06:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762412019; cv=fail; b=dkVtsslikdK1+dONtaNqHJT+PZDH4XmXPaUQNedGXA4nDybPir56RnX+X4+NgclEUlgPWyYdfcDoFP+INPoO4gjNnLSWS4W2XEea9lHyHcqtva1enlcL4z1x0OCVY+wM2RalPfmxWnjxUVPrfqdp7mM/pUQ7q0EMGkm85vtivuI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762412019; c=relaxed/simple;
	bh=1BkZxAgPDSFwFR40d3vOIK5yyORY8vlUcF6hZzdm8pU=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=k9tM3EWJVOVFClZKBX7hF7L1wr3zJAphcvJIsSIVUvkzZRBYndVr+sal6BVkFHFdymowWgxkNGLsA4i7Xi248qiTUggXVJINWazefdBwsBGp4d94ERRxZ73nfCfbXpDwVU0sv4JBfkiiiF+yjgqQSKCSLuRUX1qugSeEPFskYR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SDJt+5mr; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SDJt+5mr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762412017; x=1793948017;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=1BkZxAgPDSFwFR40d3vOIK5yyORY8vlUcF6hZzdm8pU=;
  b=SDJt+5mrPOuE1wZHHfOSgpCf+PZ4HPrqSsxHN864UeT7G/SpgJwZllUM
   xLksBJaZaxMXF3/fVp5VLJWaQNYZxg5tCjxlX2UQ6LfZnYhTzBMop3xhg
   NBjJQFS7up8qCOCZ4mvzOy3WXlN9Mm+ad7Mj+tP1vli1VjRuV/YBRaAEA
   ido1x2MhPjIFccBYrnXsehYH/j03WbOds2xM9UcjltWfCne7E+x//iEoU
   ExgVix5yRBokRTC+5K1OO0oAL3BxizXRhnSGdFrIAiYL+ZJP3XUci6YWe
   dRsY1DjcN6aTWZONCBRbqKCuVBu1OiusFshEEuwodsAkDV69SeVDI5aGu
   A==;
X-CSE-ConnectionGUID: qYWnF+XNSZuHgfSEAwuCtw==
X-CSE-MsgGUID: 1tCyoEVeRhiUbWA/Xn8dZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="67154516"
X-IronPort-AV: E=Sophos;i="6.19,283,1754982000"; 
   d="scan'208";a="67154516"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 22:53:33 -0800
X-CSE-ConnectionGUID: FUyaHmHxRAecUuWTbeLS0A==
X-CSE-MsgGUID: nyTx8qvqSFidZe81eLXUrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,283,1754982000"; 
   d="scan'208";a="186964599"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 22:53:33 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 5 Nov 2025 22:53:31 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 5 Nov 2025 22:53:31 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.41) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 5 Nov 2025 22:53:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ULRaGsg5p67hq7tG9mW9mcgfS3iZGke7w0MA6o4shBoQuW4LuYcU97RcQVlXyeUtFrdAjbWK6fXLfPSffPYuNUjCC2dqae1i9ShQzIi125a/HPnOy2O15Argtt2S5sr3tGyt+hDHTpAVrQHPXay9xpzdV0q88iALXgB1qAG9OWzc+1h7GH7CNrbjOaJSW5wmJ9cUY8QZBbjJBO24sbPk95jY3Ex8GNB+7mxNVrPXNE4hH7HPaCUTpVGE8+EUO3mJGk6FojQekRrsjpf/LLGpAcGTqV9eUHf09uXfTtpTicdAsifYVf0u559hPUc79J9bty85Q7e7Sr6k7Igg9SLTwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n6OzqeKOuDc5h+hySYUb6GKJE7sJrG85o1Rb2/RDIHg=;
 b=V4SP/9ylRKSMhpciHPbktepcbOoPFPhHO3pAXrH0yKBZzt4YKiXq2yFawIWm7pQiUSjthJm9Y6eJ09tcxYrZ2i6Ci5wr/mDiKOWSCQl9klOZq7sPaFk11aXmoKEJCaGjr16sRUtGNtr7M55QkMWfKuiSi0yN7QZnqZ0M32D8KEi+1q6HYZFpVcw7HchSzYnstVzilz3wEqiXH4DSfdOQRhA2EJH0+qsR4I8Bv7YWOByo3JY2Y2thuI9UhwtLGdE6R5dSR/FkyHgN+OwQKzTKonYM1yZx5HkDr4Cf9iMhR6nkpjyAR8n32PfHw9AnOIcUDSe4ZGUDhF7H7f4ZvN/hAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SA2PR11MB4780.namprd11.prod.outlook.com (2603:10b6:806:11d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Thu, 6 Nov
 2025 06:53:29 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9298.006; Thu, 6 Nov 2025
 06:53:28 +0000
Date: Thu, 6 Nov 2025 14:53:09 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Andrew Morton
	<akpm@linux-foundation.org>, "Paul E. McKenney" <paulmck@kernel.org>, "Steven
 Rostedt" <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
	"Dennis Zhou" <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, Christoph
 Lameter <cl@linux.com>, Martin Liu <liumartin@google.com>, David Rientjes
	<rientjes@google.com>, Shakeel Butt <shakeel.butt@linux.dev>, SeongJae Park
	<sj@kernel.org>, Michal Hocko <mhocko@suse.com>, Johannes Weiner
	<hannes@cmpxchg.org>, Sweet Tea Dorminy <sweettea@google.com>, "Lorenzo
 Stoakes" <lorenzo.stoakes@oracle.com>, "Liam R . Howlett"
	<liam.howlett@oracle.com>, Mike Rapoport <rppt@kernel.org>, "Suren
 Baghdasaryan" <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
	"Christian Brauner" <brauner@kernel.org>, Wei Yang
	<richard.weiyang@gmail.com>, "David Hildenbrand" <david@redhat.com>, Miaohe
 Lin <linmiaohe@huawei.com>, Al Viro <viro@zeniv.linux.org.uk>, Yu Zhao
	<yuzhao@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, Mateusz Guzik
	<mjguzik@gmail.com>, Matthew Wilcox <willy@infradead.org>, Baolin Wang
	<baolin.wang@linux.alibaba.com>, "Aboorva Devarajan"
	<aboorvad@linux.ibm.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	"Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>,
	<christian.koenig@amd.com>, <oliver.sang@intel.com>
Subject: Re: [RFC PATCH v7 2/2] mm: Fix OOM killer inaccuracy on large
 many-core systems
Message-ID: <202511061432.4e534796-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251031144232.15284-3-mathieu.desnoyers@efficios.com>
X-ClientProxiedBy: KL1PR01CA0027.apcprd01.prod.exchangelabs.com
 (2603:1096:820:1::15) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SA2PR11MB4780:EE_
X-MS-Office365-Filtering-Correlation-Id: dd7fa432-d73f-4920-fcb9-08de1d0130e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?e8eFNVjCbWkiLD9N8nLOxiikUg76GmeJwdQY4utjcpkNgqJ8q+QBGlw6wveR?=
 =?us-ascii?Q?GC5TBjODyx8HjRaw9TGq7VAY8kmUDbhuHdGE3ZbshhrlxARtcfNhgCaZlApK?=
 =?us-ascii?Q?3nhtGp0cCgupwSZSIEFV2uuA6Kh1kfn6Q6KyQI0n3gTpnUihSgkEDQufnQ0Z?=
 =?us-ascii?Q?xghzo26Aq+Q4os4Ykt1wIr9IjZCHdZyrgFm4f89t/miLhXRD7Vewps+t+Ley?=
 =?us-ascii?Q?YZjHBrqQGGW/EuUrfFEaCYJxuQ5cZnePQBRH11egCfiiGMDQOlvGP5B+FDoN?=
 =?us-ascii?Q?ESOPCkXUcLgkW8CE4Z4vX0dNbN/ipW3TFhKwq4V402SzthW13QR5ILrWTMqH?=
 =?us-ascii?Q?j1bmI2FkJx/wC6havlFvZFhF/7+KD27ZYCxqjpOhqaNn1uQ6cgMzIIPQJe0G?=
 =?us-ascii?Q?12Kff6/9W0jkl214n/tKoGOvcPtGPChe1a4KzGaJVrgQLrhrV41UmlYc6uV7?=
 =?us-ascii?Q?HqQHuFoxEUsvxaBiPtDvS+nKn46+1hduRfVA8rtSgh/30NZphANciMu7Oquw?=
 =?us-ascii?Q?/uqMGM9gmi1i7gVmF3HkN8sIuj3GniiThddNDS57G698EbQ69Dq9nHRZsz0T?=
 =?us-ascii?Q?esH5izorS+xc8FTNhEBZDlN/Fy0UmKtMOc6Wlb6bvD0KYo0u4/6tVSJZuCs1?=
 =?us-ascii?Q?Rvo2/u5BqJXjdBo27YQprtBYJyZnQLRWV3cDteQi9K4oRrha81qUmOn8Q+aI?=
 =?us-ascii?Q?ORzKwD1wsTW4Icl9UtyNx7/C30zSAdv/bX6QiOKci0to0d8jsTDzkldV7fyH?=
 =?us-ascii?Q?+Yl/ditpSb6cJnMCTplNOb7fxEZcdbAY1OKkzVq5MiXSjIZXTSQEwaDvt2oR?=
 =?us-ascii?Q?c1u8bnNrQLg/9vL/Tupqr2eQqkbWNJmcP4Mngp3dn5HeWD4n/Cb49FB8QOZ7?=
 =?us-ascii?Q?so3Lw8chMq5/jSRqCgLp/COxYsFXVY4Tb9bVDRhIbhwwOcKIMwyWMVcP3OG9?=
 =?us-ascii?Q?Lto4SSU6TgMT1aSJ+EVN2LrQXN1FcNLJudI2drHtdM1hqMD2tAmJoNVxr8Fd?=
 =?us-ascii?Q?C0AKSA4rzr1nbInLmla6LFExL5ok1rOf8A9+CyDpM2cI3fY7W97F4W8kRXnH?=
 =?us-ascii?Q?ajCR+AgGmE/X8ipVmhLM5NZH2fgcmIaTri3mKtmem49Ih6rCoCJr0czih8ba?=
 =?us-ascii?Q?6wkck2OSoECavbOUXbr9QqnDyK55eib9UeBrStSacBcDURcOcHoR98+lLWnt?=
 =?us-ascii?Q?XMslPsXIJX9PJVAnpzNM3q7cm/YROYg87ffIHNHye6sNVWvLzsgE5zH79DNp?=
 =?us-ascii?Q?e1lnNegN1MtrjaTnK9FDxqnddCDdSlAF5nAidNrJk0FfiummxDz8ltF2SwLH?=
 =?us-ascii?Q?FfqYFJu5ueOc78RyuyNKLD/dn0Zc2bXuGbFfJy0NgGl+b67CDI85kadJJ06e?=
 =?us-ascii?Q?WsR9YgTD4nSDX0f4M0vILKO+7I5cCgJeut3MeWRjSLJH8ic6LqXxpx5o+52/?=
 =?us-ascii?Q?1pzgbs5hWR/JFV2DrNh12IEdoFgOL82YfEt6dSSa1Bn2Xuv9/070vg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8Y4YXXoJSAuRY46+zOOJCriF+VzsiYnQflPWhEzu0eKgze5cc5oAhsVZgUN6?=
 =?us-ascii?Q?rWxFAZY4QzJOZH6X35fZgxbYgcyFm+Ze++gIS9JcgUyrEvj95pQhHIgnR4LZ?=
 =?us-ascii?Q?NyzJR/jg+COXqNw0+gWMNraXVk/v3jUs8F5uP+CRHR2ehV+6kLwF2lXaEPmP?=
 =?us-ascii?Q?gZloS2lDDm9YP/u4I558OWvYp93CaQlRFefNYhF6KB6jrHFDNK2FFdD1Aun1?=
 =?us-ascii?Q?Mlh2t5EOAlkTscSkjvYzZ2wEH+xUze5jjXB+zys9JBknwOO7UNw5OSLqku0H?=
 =?us-ascii?Q?nwuD1PAkNluHLvCpfDnk5UN/OxqAnQGok3teq4GM66Vt+1jJsMv+nTW623nj?=
 =?us-ascii?Q?XqJoGZSLaQRH2Bm/EOIUsSPGGdDY/uNvdslXzwo60Cu3X9dYg2PG0pYe3Mac?=
 =?us-ascii?Q?Kl9oT5jYn/0M+Oj2pCXKHL0C//pQba1fXvKUfBMk/UWJ519V9+WVeszXe1V+?=
 =?us-ascii?Q?oIRI3sNNrSbIpIh/eTdn4tqoqWwQW6FaMYC8YUY/VUgkxpkiGKaJWFD4Wy7y?=
 =?us-ascii?Q?BzMDhmvU454jdIt/ajs/zutUaYIHfZli9X++ni5odXU6fUVmsVCp+HJa6sq/?=
 =?us-ascii?Q?9GvzQ99upzjSr16saWvOE0npfKcN+ge+tPCdQVTYQNHlkWW/G6iAIBl1FPZk?=
 =?us-ascii?Q?qTA8yVwI3CGMRRibA2SAC/XV7Cpxx8DY0euyN+H+MzMorEl84NCXFEWuf6qi?=
 =?us-ascii?Q?OkNsiC8hGFUDTREGDC1tTJspqflixB8/2isOf2k4Ubq6jFfoKg0aQmYKw2LJ?=
 =?us-ascii?Q?yNgwgJfFNCS122JlD6ThY0vJpK/jhYoss9G+eBh3aKLhOVX+xGbyQYYiuopq?=
 =?us-ascii?Q?DdmbKQVgLUNWH7FyclA0efEOx26AeNJUjHFmuvfFC90mACwzIkzwiO7fICu/?=
 =?us-ascii?Q?ZrNgVHpwQ79qjsliv+HUvD+DFW3wfg3YT1gCe1I8O7joHIFisuH4AfOy7+x/?=
 =?us-ascii?Q?rWNwOnKefLcbJs8Shu3T2XJJIDWSEexwn7qHcUer12+uunRgl5ugDlkZAmjE?=
 =?us-ascii?Q?wfpR6GnPrxgRnvHjfspFYLXd6W4y1ffZ+mt6WnT4JMD8oSf8SSPrNwiQeO/G?=
 =?us-ascii?Q?TFDkMjKEhd4Dj3E+48HvDQx7o9tBoMDTvB75Z3lBm6S+PwTQFQCHvLr3uv07?=
 =?us-ascii?Q?MxIiHFx5Xys/iB0+Jp2zuSmktDSFBsFHggSzVf2BkW7AGtxqr2tWfVbe5ea6?=
 =?us-ascii?Q?Huq4BJkut8CUkd7ug2AfhQAN1PMwh+9pstYlbywBLrn+ezVckvy7r1wG7eLK?=
 =?us-ascii?Q?aMSgwYRaSjIu6wzAzILKBtfDSTFVJK5/yL724SvRnsd+FJWHlwp+mvAwWYtM?=
 =?us-ascii?Q?hRVrpT/pFALiCSV2yAy1GlxBTVZ4SICNEoSWMikBiIG+fmzZl/+noBpymiVX?=
 =?us-ascii?Q?ESHuLkx+gOljbiD/7+jougnndkM7X0UP9W72OvtC+OQeSKKzbYeagGHIrRtX?=
 =?us-ascii?Q?P6lcpk0CxDdzoALziZPMhbWtoDXxFzWb8NdPNDkn+ef5JCLXYYKYw99WTn4z?=
 =?us-ascii?Q?ZjsKRVQr7QCq2KKRTzUqraER+MgyZxrIsOA/mEcP9kn8dqEoQXHKDlGpyrac?=
 =?us-ascii?Q?Da84PJIcF1x9vuWdsq50+7b4DWzsG6x4uqouKYjE+R9JNLjF3sLOd2v/aB17?=
 =?us-ascii?Q?Ng=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dd7fa432-d73f-4920-fcb9-08de1d0130e8
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 06:53:28.7163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nrykv3yd2dUg/XL4uSDg38QY161TI3vccMPI4s++5APBHazCapny56t8Hvo32x0h8CX4hj4r3y1/rCMfLEh8WQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4780
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "BUG:Bad_rss-counter_state_mm:#type:MM_ANONPAGES_val:#Comm:kworker##Pid" on:

commit: 25ae03e80acad812e536694c1a07a3f57784ae23 ("[RFC PATCH v7 2/2] mm: Fix OOM killer inaccuracy on large many-core systems")
url: https://github.com/intel-lab-lkp/linux/commits/Mathieu-Desnoyers/lib-Introduce-hierarchical-per-cpu-counters/20251031-224455
base: https://git.kernel.org/cgit/linux/kernel/git/akpm/mm.git mm-everything
patch link: https://lore.kernel.org/all/20251031144232.15284-3-mathieu.desnoyers@efficios.com/
patch subject: [RFC PATCH v7 2/2] mm: Fix OOM killer inaccuracy on large many-core systems

in testcase: boot

config: x86_64-randconfig-002-20251103
compiler: clang-20
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


in fact, we observed various BUG:Bad_rss-counter_state_mm issues for this commit
but clean on parent, as below

+------------------------------------------------------------------------+------------+------------+
|                                                                        | 05880dc4af | 25ae03e80a |
+------------------------------------------------------------------------+------------+------------+
| BUG:Bad_rss-counter_state_mm:#type:MM_FILEPAGES_val:#Comm:kworker##Pid | 0          | 10         |
| BUG:Bad_rss-counter_state_mm:#type:MM_ANONPAGES_val:#Comm:kworker##Pid | 0          | 17         |
| BUG:Bad_rss-counter_state_mm:#type:MM_ANONPAGES_val:#Comm:swapper_Pid  | 0          | 2          |
| BUG:Bad_rss-counter_state_mm:#type:MM_ANONPAGES_val:#Comm:modprobe_Pid | 0          | 3          |
| BUG:Bad_rss-counter_state_mm:#type:MM_FILEPAGES_val:#Comm:modprobe_Pid | 0          | 1          |
+------------------------------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202511061432.4e534796-lkp@intel.com


[   14.858862][   T67] BUG: Bad rss-counter state mm:ffff8881000655c0 type:MM_ANONPAGES val:0 Comm:kworker/u9:0 Pid:67
[   14.894890][   T69] BUG: Bad rss-counter state mm:ffff888100061cc0 type:MM_FILEPAGES val:0 Comm:kworker/u9:0 Pid:69
[   14.896108][   T69] BUG: Bad rss-counter state mm:ffff888100061cc0 type:MM_ANONPAGES val:0 Comm:kworker/u9:0 Pid:69
[   14.918858][   T71] module: module-autoload: duplicate request for module crypto-aes
[   14.919479][   T71] module: module-autoload: duplicate request for module crypto-aes-all
[   14.920801][    T1] krb5: Running aes128-cts-hmac-sha256-128 enc plain<block
[   14.921844][    T1] krb5: Running aes128-cts-hmac-sha256-128 enc plain==block
[   14.922852][    T1] krb5: Running aes128-cts-hmac-sha256-128 enc plain>block
[   14.923843][    T1] krb5: Running aes256-cts-hmac-sha384-192 enc no plain
[   14.939591][    T1] krb5: Running aes256-cts-hmac-sha384-192 enc plain<block
[   14.940614][    T1] krb5: Running aes256-cts-hmac-sha384-192 enc plain==block
[   14.941586][    T1] krb5: Running aes256-cts-hmac-sha384-192 enc plain>block
[   14.942547][    T1] krb5: Running camellia128-cts-cmac enc no plain
[   15.018568][   T85] BUG: Bad rss-counter state mm:ffff888160f81340 type:MM_ANONPAGES val:0 Comm:kworker/u9:0 Pid:85
[   15.054490][   T89] module: module-autoload: duplicate request for module crypto-camellia
[   15.055466][   T89] module: module-autoload: duplicate request for module crypto-camellia-all
[   15.056999][    T1] krb5: Running camellia128-cts-cmac enc 1 plain
[   15.057912][    T1] krb5: Running camellia128-cts-cmac enc 9 plain
[   15.058781][    T1] krb5: Running camellia128-cts-cmac enc 13 plain
[   15.059603][    T1] krb5: Running camellia128-cts-cmac enc 30 plain
[   15.061279][    T1] krb5: Running camellia256-cts-cmac enc no plain
[   15.062207][    T1] krb5: Running camellia256-cts-cmac enc 1 plain
[   15.063150][    T1] krb5: Running camellia256-cts-cmac enc 9 plain
[   15.072917][    T1] krb5: Running camellia256-cts-cmac enc 13 plain
[   15.073896][    T1] krb5: Running camellia256-cts-cmac enc 30 plain
[   15.074834][    T1] krb5: Running aes128-cts-hmac-sha256-128 mic
[   15.075625][    T1] krb5: Running aes256-cts-hmac-sha384-192 mic
[   15.076396][    T1] krb5: Running camellia128-cts-cmac mic abc
[   15.077225][    T1] krb5: Running camellia128-cts-cmac mic ABC
[   15.078052][    T1] krb5: Running camellia256-cts-cmac mic 123
[   15.078853][    T1] krb5: Running camellia256-cts-cmac mic !@#
[   15.079621][    T1] krb5: Selftests succeeded
[   15.080683][    T1] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 248)
[   15.081610][    T1] io scheduler kyber registered
[   15.082527][    T1] test_mul_u64_u64_div_u64: Starting mul_u64_u64_div_u64() test
[   15.083365][    T1] test_mul_u64_u64_div_u64: ERROR: 0x000000000000000b * 0x0000000000000007 +/ 0x0000000000000003
[   15.086382][    T1] test_mul_u64_u64_div_u64: ERROR: expected result: 000000000000001a
[   15.087178][    T1] test_mul_u64_u64_div_u64: ERROR: obtained result: 0000000000000019
[   15.088064][    T1] test_mul_u64_u64_div_u64: ERROR: 0x00000000ffffffff * 0x00000000ffffffff +/ 0x0000000000000002
[   15.089105][    T1] test_mul_u64_u64_div_u64: ERROR: expected result: 7fffffff00000001
[   15.089924][    T1] test_mul_u64_u64_div_u64: ERROR: obtained result: 7fffffff00000000
[   15.090696][    T1] test_mul_u64_u64_div_u64: ERROR: 0x00000001ffffffff * 0x00000000ffffffff +/ 0x0000000000000002
[   15.091734][    T1] test_mul_u64_u64_div_u64: ERROR: expected result: fffffffe80000001
[   15.092502][    T1] test_mul_u64_u64_div_u64: ERROR: obtained result: fffffffe80000000
[   15.093281][    T1] test_mul_u64_u64_div_u64: ERROR: 0x00000001ffffffff * 0x00000001ffffffff +/ 0x0000000000000004
[   15.094337][    T1] test_mul_u64_u64_div_u64: ERROR: expected result: ffffffff00000001
[   15.095172][    T1] test_mul_u64_u64_div_u64: ERROR: obtained result: ffffffff00000000
[   15.095953][    T1] test_mul_u64_u64_div_u64: ERROR: 0xffff000000000000 * 0xffff000000000000 +/ 0xffff000000000001
[   15.097175][    T1] test_mul_u64_u64_div_u64: ERROR: expected result: ffff000000000000
[   15.098020][    T1] test_mul_u64_u64_div_u64: ERROR: obtained result: fffeffffffffffff
[   15.098837][    T1] test_mul_u64_u64_div_u64: ERROR: 0x3333333333333333 * 0x3333333333333333 +/ 0x5555555555555555
[   15.099924][    T1] test_mul_u64_u64_div_u64: ERROR: expected result: 1eb851eb851eb852
[   15.100721][    T1] test_mul_u64_u64_div_u64: ERROR: obtained result: 1eb851eb851eb851
[   15.101542][    T1] test_mul_u64_u64_div_u64: ERROR: 0x7fffffffffffffff * 0x0000000000000002 +/ 0x0000000000000003
[   15.102565][    T1] test_mul_u64_u64_div_u64: ERROR: expected result: 5555555555555555
[   15.103368][    T1] test_mul_u64_u64_div_u64: ERROR: obtained result: 5555555555555554
[   15.107134][    T1] test_mul_u64_u64_div_u64: ERROR: 0xffffffffffffffff * 0x0000000000000002 +/ 0x8000000000000000
[   15.108196][    T1] test_mul_u64_u64_div_u64: ERROR: expected result: 0000000000000004
[   15.109049][    T1] test_mul_u64_u64_div_u64: ERROR: obtained result: 0000000000000003
[   15.109887][    T1] test_mul_u64_u64_div_u64: ERROR: 0xffffffffffffffff * 0x0000000000000002 +/ 0xc000000000000000
[   15.111017][    T1] test_mul_u64_u64_div_u64: ERROR: expected result: 0000000000000003
[   15.111907][    T1] test_mul_u64_u64_div_u64: ERROR: obtained result: 0000000000000002
[   15.112666][    T1] test_mul_u64_u64_div_u64: ERROR: 0xffffffffffffffff * 0x4000000000000004 +/ 0x8000000000000000
[   15.113703][    T1] test_mul_u64_u64_div_u64: ERROR: expected result: 8000000000000008
[   15.114527][    T1] test_mul_u64_u64_div_u64: ERROR: obtained result: 8000000000000007
[   15.115424][    T1] test_mul_u64_u64_div_u64: ERROR: 0xffffffffffffffff * 0x4000000000000001 +/ 0x8000000000000000
[   15.116279][    T1] test_mul_u64_u64_div_u64: ERROR: expected result: 8000000000000002
[   15.116882][    T1] test_mul_u64_u64_div_u64: ERROR: obtained result: 8000000000000001
[   15.117490][    T1] test_mul_u64_u64_div_u64: ERROR: 0xfffffffffffffffe * 0x8000000000000001 +/ 0xffffffffffffffff
[   15.118363][    T1] test_mul_u64_u64_div_u64: ERROR: expected result: 8000000000000001
[   15.119240][    T1] test_mul_u64_u64_div_u64: ERROR: obtained result: 8000000000000000
[   15.119914][    T1] test_mul_u64_u64_div_u64: ERROR: 0xffffffffffffffff * 0x8000000000000001 +/ 0xfffffffffffffffe
[   15.120785][    T1] test_mul_u64_u64_div_u64: ERROR: expected result: 8000000000000002
[   15.121627][    T1] test_mul_u64_u64_div_u64: ERROR: obtained result: 8000000000000001
[   15.122503][    T1] test_mul_u64_u64_div_u64: ERROR: 0xffffffffffffffff * 0x8000000000000001 +/ 0xfffffffffffffffd
[   15.123624][    T1] test_mul_u64_u64_div_u64: ERROR: expected result: 8000000000000003
[   15.124521][    T1] test_mul_u64_u64_div_u64: ERROR: obtained result: 8000000000000002
[   15.125399][    T1] test_mul_u64_u64_div_u64: ERROR: 0x7fffffffffffffff * 0xffffffffffffffff +/ 0xc000000000000000
[   15.126592][    T1] test_mul_u64_u64_div_u64: ERROR: expected result: aaaaaaaaaaaaaaa9
[   15.127438][    T1] test_mul_u64_u64_div_u64: ERROR: obtained result: aaaaaaaaaaaaaaa8
[   15.128411][    T1] test_mul_u64_u64_div_u64: ERROR: 0xffffffffffffffff * 0x7fffffffffffffff +/ 0xa000000000000000
[   15.129565][    T1] test_mul_u64_u64_div_u64: ERROR: expected result: cccccccccccccccb
[   15.130454][    T1] test_mul_u64_u64_div_u64: ERROR: obtained result: ccccccccccccccca
[   15.131239][    T1] test_mul_u64_u64_div_u64: ERROR: 0xffffffffffffffff * 0x7fffffffffffffff +/ 0x9000000000000000
[   15.132213][    T1] test_mul_u64_u64_div_u64: ERROR: expected result: e38e38e38e38e38c
[   15.132793][    T1] test_mul_u64_u64_div_u64: ERROR: obtained result: e38e38e38e38e38b
[   15.133374][    T1] test_mul_u64_u64_div_u64: ERROR: 0x7fffffffffffffff * 0x7fffffffffffffff +/ 0x5000000000000000
[   15.134101][    T1] test_mul_u64_u64_div_u64: ERROR: expected result: ccccccccccccccca
[   15.134674][    T1] test_mul_u64_u64_div_u64: ERROR: obtained result: ccccccccccccccc9
[   15.135235][    T1] test_mul_u64_u64_div_u64: ERROR: 0xe6102d256d7ea3ae * 0x70a77d0be4c31201 +/ 0xd63ec35ab3220357
[   15.135984][    T1] test_mul_u64_u64_div_u64: ERROR: expected result: 78f8bf8cc86c6e19
[   15.136587][    T1] test_mul_u64_u64_div_u64: ERROR: obtained result: 78f8bf8cc86c6e18
[   15.137140][    T1] test_mul_u64_u64_div_u64: ERROR: 0xf53bae05cb86c6e1 * 0x3847b32d2f8d32e0 +/ 0xcfd4f55a647f403c
[   15.137964][    T1] test_mul_u64_u64_div_u64: ERROR: expected result: 42687f79d8998d36
[   15.138541][    T1] test_mul_u64_u64_div_u64: ERROR: obtained result: 42687f79d8998d35
[   15.139135][    T1] test_mul_u64_u64_div_u64: ERROR: 0x9951c5498f941092 * 0x1f8c8bfdf287a251 +/ 0xa3c8dc5f81ea3fe2
[   15.139884][    T1] test_mul_u64_u64_div_u64: ERROR: expected result: 1d887cb259000920
[   15.140444][    T1] test_mul_u64_u64_div_u64: ERROR: obtained result: 1d887cb25900091f
[   15.141025][    T1] test_mul_u64_u64_div_u64: ERROR: 0x374fee9daa1bb2bb * 0x0d0bfbff7b8ae3ef +/ 0xc169337bd42d5179
[   15.141759][    T1] test_mul_u64_u64_div_u64: ERROR: expected result: 03bb2dbaffcbb962
[   15.142324][    T1] test_mul_u64_u64_div_u64: ERROR: obtained result: 03bb2dbaffcbb961
[   15.142890][    T1] test_mul_u64_u64_div_u64: ERROR: 0xeac0d03ac10eeaf0 * 0x89be05dfa162ed9b +/ 0x92bb1679a41f0e4b
[   15.143618][    T1] test_mul_u64_u64_div_u64: ERROR: expected result: dc5f5cc9e270d217
[   15.144200][    T1] test_mul_u64_u64_div_u64: ERROR: obtained result: dc5f5cc9e270d216
[   15.144767][    T1] test_mul_u64_u64_div_u64: Completed mul_u64_u64_div_u64() test, 56 tests, 23 errors, 61402015 ns
[   15.147067][    T1] gpio_virtuser: Failed to create the debugfs tree: -2
[   15.148313][    T1] gpio_winbond: chip ID at 2e is ffff
[   15.148884][    T1] gpio_winbond: not an our chip
[   15.149345][    T1] gpio_winbond: chip ID at 4e is ffff
[   15.149721][    T1] gpio_winbond: not an our chip
[   15.151343][    T1] IPMI message handler: version 39.2
[   15.151885][    T1] ipmi device interface
[   15.152644][    T1] ipmi_si: IPMI System Interface driver
[   15.153494][    T1] ipmi_si: Unable to find any System Interface(s)


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20251106/202511061432.4e534796-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

