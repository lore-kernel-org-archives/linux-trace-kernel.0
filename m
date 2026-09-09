Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011063.outbound.protection.outlook.com [52.101.65.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377FD582B8D;
	Wed,  9 Sep 2026 16:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788970974; cv=fail; b=TL9g5FxhyCh0xC9/fPvye7HGo4vEinxOjzp6rsBkblYwa0rL2KVDWeZ5zDbnDW0GBGaokBuftaeZHfeW4iDoZTMvfEPKaC8OTcbgVTZOTZMCWoPUyAU+pP5K+wiNf/L5qog/SOVi1UDxsHONhjdCvwCEslzUomJKrt4tirqk7pM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788970974; c=relaxed/simple;
	bh=8Xsdhys+/ZI7muq9HWuoOgjlbFUMaoCLjHdb6P0rGxE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=RFzh41kF6kU20saNLvWBf2k0K0VynUKdi6BDmNXdbFj6MgaxZxGW8P9mHmxOR13jWH5sxJQ2OkNzh9ry3jB0jkj+rx8JXs2Afpl85IsNZgOlcnAsdW8HENHW0MCHJuennIdXEJ+UwNpT8+uss/r4m9mWz2jCr1AiWiN8+f+VwVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=I0mYjxPg; arc=fail smtp.client-ip=52.101.65.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="I0mYjxPg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FP2mMyFJI2S2lF33SOcd0voYh2YZM8tqKvayC1s1uI89h44ybB83b3cM55oryXJUdGEiW5UmQ0RYfooSpunWDKWuUv9N9glc7nckgH42/JCFDThJTWwUcLfi6bQNJ36HrEAMVnRoJqIfZdtn7VjNYTt+d68ITa0hPZga74P5eyFhOX5Ry0K1haWbfOd/kkonaoAIwBa6HsPhw9sre54l0RQsIfn5jzfZxUb5ij543AjQifzJQX1Ka9FxOXpikVTzcS0j/ZXDQauZ1/ky82rWJZTUZ+uAMNPBJYFsRd82LvgRiCgdifAIj2m1+AMQR6kgkGyGrflsn/vIEY8hWiWnBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=riJbFukdlYUq9TPuXwu291/bikY5bgBBMl28zlk0YxU=;
 b=cJPwd4xf8MkmurG8YeYGrVvM9A7IZEprDFe1wAV5xojb6PE2BPXZZ/X6GTcE1wbT87Qqfplf97ubN2n/LMveWHvgGFwYqTpgQwhJGsP8gGzrWEAv/baZxOXWGxoHqajYe36Yvh3oltEZzieNl/oW2mcX+/P/IZEWmBC60rpcuROT6NPz129BjuRHrtO9VXwaVLNcqwXX4kF1RKdaeubDFdmu5CsxRbLEB3VrXamwyNYIs6wsTodkwZFK6JUZp8kpefJHjSaGyvZMb89/6vAr8V7QwjoUoaWfqaK0ZPif2iSel2GtnAb1GhwVm6WfAD/Dm0ZRcJPBUrDenbRBwgiepA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=riJbFukdlYUq9TPuXwu291/bikY5bgBBMl28zlk0YxU=;
 b=I0mYjxPgEUvoJ/4uJT6RXnoEdNK0x5WfgqoSdMmaCBkTzBcllnxcP6TY7p9PzzBt7hwFJ7hi8IgGBSG05m45kcn2m+6gqjNyMmf6LSE2oPm2hn82cf7nJU6muu7+BzTgMM2E+SoE6O+Y3yZM9h6qSS6dRpPKTtjCDhuwa3a0OrkntDoyrgLkVK2gWkyf7l5xwsMOxd23wwnKhL81MTvPijWfYIJ/5LhHfuCwwTmwhnTwlWfVk+APRNIYJtDwB20eLoCXkNxxxhGWTMya9E/mMQLFyxz30qv7Rw76lYU/JP2R83DE1dRA84JfqSCFTgWP0t18gUShNK7KV93RGymc5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AM0PR04MB6786.eurprd04.prod.outlook.com (2603:10a6:208:184::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Wed, 9 Sep 2026
 16:22:47 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 16:22:47 +0000
From: Frank.Li@oss.nxp.com
Date: Wed, 09 Sep 2026 12:22:29 -0400
Subject: [PATCH v4 2/4] dmaengine: use dma_chan_name() helper to get
 per-channel device name
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-dma-chan_dev-rename-v4-2-d8fb6892a70f@nxp.com>
References: <20260909-dma-chan_dev-rename-v4-0-d8fb6892a70f@nxp.com>
In-Reply-To: <20260909-dma-chan_dev-rename-v4-0-d8fb6892a70f@nxp.com>
To: Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>, 
 Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Paul Cercueil <paul@crapouillou.net>, 
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Binbin Zhou <zhoubinbin@loongson.cn>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 =?utf-8?q?Am=C3=A9lie_Delaunay?= <amelie.delaunay@foss.st.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Thierry Reding <thierry.reding@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Ludovic Desroches <ludovic.desroches@microchip.com>, 
 Viresh Kumar <vireshk@kernel.org>, Keguang Zhang <keguang.zhang@gmail.com>, 
 =?utf-8?q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, 
 Manivannan Sadhasivam <mani@kernel.org>, Daniel Mack <daniel@zonque.org>, 
 Haojian Zhuang <haojian.zhuang@gmail.com>, 
 Robert Jarzmik <robert.jarzmik@free.fr>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Kelvin Cao <kelvin.cao@microchip.com>, 
 Logan Gunthorpe <logang@deltatee.com>, 
 Laxman Dewangan <ldewangan@nvidia.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-trace-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-actions@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788970951; l=7152;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=kNbx0q8XX8sJ0EnveNvPwTp3PWp8c60u67QnuzKj1v0=;
 b=ss0So3AaFZNp7xpuLiL1I4qd28Dh7fLStR4suOFL08a+bz8uSjkTiC1qLqZzjcMSy8U09wFAC
 f3TcGbTnKLcBu4oM+QARad065C/poWAU7jvHXI6U4O3/vP8ul7SWzhP
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH7P222CA0029.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:33a::31) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AM0PR04MB6786:EE_
X-MS-Office365-Filtering-Correlation-Id: 78ac09c3-34b2-4302-6a65-08df0e8e95a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|19092799006|366016|23010399003|1800799024|921020|6133799003|10067099003|56012099006|11063799006|22082099003|18002099003|41080700001;
X-Microsoft-Antispam-Message-Info:
	LeenUkqnRnUT8bB8o/6ygeb93dXUyeVP9/nn2j6FSO5aB0iclcPT8zcwd2CZV5RoVDHqO9+zEat3+fss1d6RYPkLo8cjVCXJOris2jwdHjjECIijQoJgys2v97T82uVs1FhwyDaobnHC7ePqz9NhdROP25GOmpd7YLyBAFbS9aAXqHMu1JHAIeSpBxpu/5sdrCfJlYG7CUBJeIT/FvtUTiUI41dchVyBRa2V6TgvmoEln1Huo8unIRrnGbyYb40p0yKuKCMBNnyZvOHV/vd+ed6hT5oWfFvDyzPIRtQye6phA+YangKUmTlqNHk25Z+huUyn1WSZCGN9dKMaw9a3baYEhIflbe+XrO7a7PI5HH4EG6ujjl1+rnyqfR3QnWAgiTmr/ZDWTHrxtOFtETL2immlqI+qfjASKT3bg8DfN62cBonB1vr6baFRY3yaasht8YZdHRKXXbrR/7n9+VFDtYDv3QDLRMbgPc5JlgNA4qKaNDjHDHZH/gGgL9FpL0/yswHXA2ALHhCBPA/BJrXDAQQ4ZnIHlI/IGAKpdI+LX21tmbd2mxYq/51YkpNe3vLfZuGdEze/0wIPRuLZo7S9b6iMd1cAKz9ft5iVhruVOrJm2lwXlghGKQaWFEE7lLGU3rF1ytqCGQqRcN34EdfVOQsSdQ+e8ob+AyXVlUmm0ayY4bWgqrUp59ZpuORwmu0wU6Z9eSSXjCiVHs8v6FZpus2w5Q0ZwL275d83qzeZX+Ax/slW0LFd8ED2N7mQTZl3
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(19092799006)(366016)(23010399003)(1800799024)(921020)(6133799003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?anlLVXdUVEs1NWFkMmF4bmtCNDZvUGFBai83UFVoSnhUR05CcGhCaDBQVmJL?=
 =?utf-8?B?clJuZTlVbTBDb2UyL0tocmMwTWQ4YktxWEFRelFrUWdKT1lPemtodDFhZlJZ?=
 =?utf-8?B?Tkk2T0tWWWF6UmRmWTlzSVMwem1UMW1jRjNsdGlvZzR0M0p3Q3BvaE8yQ0lC?=
 =?utf-8?B?ZFp6ckgycllsUTJ1UGtnL01maDJJTnhVMjZjVFlZR1RHbUd5MXZidUt4UjlN?=
 =?utf-8?B?UzV3YmpReHhYbTlPOWFrMCtpMFIyV3lwalFudkx5bUZIQ2NBcnpheERaV2FQ?=
 =?utf-8?B?WXc4ZklDRFFKN042SkErUU4xdWt3Nk8zS1YvVVZLQUdVT2ZlSG53NS9kVTBy?=
 =?utf-8?B?L2dKQWpKRWlabTlkNVM2VERXd1ArMWdTd1FXUi9GTlZZK3RkcTZCamk1NjJS?=
 =?utf-8?B?V0dlVFNqaFppQUJKTmhFRkFnaEdMYlBCTzQ3Q3g5bFRRd1lhekNEUnNtNkN2?=
 =?utf-8?B?TWltOTlic00xWk04V0V2ZjhOVGxyVWdiMktjcWtUM29MYlpqbGlFL05pQjNx?=
 =?utf-8?B?QVNIOE1SYWRkSTdXZ3ZpamlMam9lOXNTYTJVZU1GOVRtdVNHdlF2a3pueFBO?=
 =?utf-8?B?RmtXemh0NkRMWW9zQVQwaGR1TkkzY1l1ek5wV1I5Z0JRajAxY3VyUjNUY1lT?=
 =?utf-8?B?ZGtQd2I4VjNna3huNURCNjZ5VmJ2V00rdVg5Qnk1aW1GMzUrbmoxc21uU1kx?=
 =?utf-8?B?LzA3NmU3NU1LeXN6L0x2ZGg4SnFsWWxacm5nVC8zK0lqYk9YTFNaOW9Oa2t6?=
 =?utf-8?B?QzBaSFBYc2pxaGludlNGVjdWQ2I4N0x6L2NNbkxsQmdBSEozZXp4Nmtma0dX?=
 =?utf-8?B?UnVBM2V4clpoRHRBS0RSQm9zSjZVOEMwb3hUQ1RWNk1SckNqS3lpQUdpOWhL?=
 =?utf-8?B?ZERxUTBrVTQwMlpYeTNBaGdMcHg3R0pkVEZCQlFMU2NsaU8xb2ZqL2x5UTBj?=
 =?utf-8?B?R3ZWV3JEakNscXBBRXBSdWhPK1NKQlZmMHJZb3FOQzZtbkYwZ3NCeUc4aElv?=
 =?utf-8?B?VW00T1Y2SDlBMlRLdWJJY0NsRkgxUEVOMGJ4cXJyaUNJd254bnBsMFhBdVp3?=
 =?utf-8?B?Z0h3RlBQSWpMZDZmWlo3cXU0aEU2M2FzeGJ4dWNVZkF5NHREbVZCWGJyaTI5?=
 =?utf-8?B?V0hRZldBemtGN0o3R0VqRFc4QnR0SmtKZ3ZRV0FUTlZJZHU4TEdSK0lpMnNN?=
 =?utf-8?B?a0tJUWxIS3FaOXhEWXFOKy9OOENRL2hMaEZVZjNEdjczdW1CL01rTlY1d3kx?=
 =?utf-8?B?YnB0M3dYSDFuOFl2YXV3RUtmT3VXSXBjWWNmTnNhVVdZSjFNWkRxeCszVWli?=
 =?utf-8?B?VS84UlpHeVJjSnFPeTBWOFpKc0ZBL3dGMjQvOGdNQWs3VERqelhaUWJMQnlE?=
 =?utf-8?B?SVZrNGpyNy96SnBtR3p1N1NrYWlPYmJiRDlNQ2FxdE9oT3Jsa2thRjc5c002?=
 =?utf-8?B?aTBLVWVpZm5mdS95cm92MGdtNm9OVlpsV1NjQm9rU3B6ZjJCTjhjaCt4ZWZw?=
 =?utf-8?B?MHZFMjMzNmR1RXcrVlJRUzIxOTQ3ZGRoTGloRkJLVW02b1RoaHB4MjAxOUVZ?=
 =?utf-8?B?aFQwK1RpN3gxaHFwSE5uNEExVTBsZmZUZU5YcUU2RGc0dlRZcUJFaVM2OUdH?=
 =?utf-8?B?d1FsUEl5N0xjd2luQ2R2eStpcHJYZXcyMDk1WlBCc1E5L1ZVM1VlMWZpNnRN?=
 =?utf-8?B?ZGZ2RjVQZGxVUVNFT25CLytIOW5iMjEzQUtrbGd2OFpaNEY5SzRvT254OXNv?=
 =?utf-8?B?R0p5WWtCYnBCZFJYZDU5WkNwcnJhV0F1aU5iNEI0emRoVTRxR20wTHpOUHF1?=
 =?utf-8?B?ZytKQ3lieG9nZTR0d0ExeUpUeWFZdDhoSDJLVDRIMGtSOXVpcEZxT3F6Z3dK?=
 =?utf-8?B?akt2QkJYVkcwL3paZCs1QTN0Yllza0NyeDRlZzdBZWttakVKVEozNmVWMzA0?=
 =?utf-8?B?M3c4bWZDSCsyb1g0U3IyZ2dUc2tuVnJjNng1RFJXUVpJcEQvZG5rNHBTWDZC?=
 =?utf-8?B?akFraTFDSGpMOUxHY0RWMkdFTm9yNmJDY0JRSEQyQkVFWjRueXk3TjBwMGxt?=
 =?utf-8?B?VWpQWXlJaHBoUDlZdEZXbngveDhTc0d6R0VOZUpjdWcwdnB1VUMwdGplWmla?=
 =?utf-8?B?NUpic2xXdnRLaDlMZkpTRzRYa0hrckpoY1ZTYXQ0d1JJdjFtc2FnSVJVVmhk?=
 =?utf-8?B?SEpZbUhaNWNjVi9UUWdGamV5QjNMcmxTb2ZBdFp5MmlORld6OUtYRDFPUVps?=
 =?utf-8?B?Wm1IWnFPclhRZlplKzRmNGxBTzR4NDc4RVpTVU1iS1YwcVp5WDN0SHEzTDly?=
 =?utf-8?B?N29Zc2UvVmE4QVkyMFlNNXNoOEVJTTgzZnBZZWlzVWRUUk1HOW5HNk1tV05P?=
 =?utf-8?Q?wv7bl12TJ+D6Gkis=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78ac09c3-34b2-4302-6a65-08df0e8e95a3
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 16:22:47.0984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F55Gk3gg3epOp9QNabFyr+rz2fUfi9SJuwUzOlz7BBBPEIHl4xkUTpJGXpgIklZbrogVxvYvRFcAH53qxg9EGEttCNq4jYP6q7vwyAW1FwtDLIbxDJS/wUVdkgexms+8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6786

From: Frank Li <Frank.Li@nxp.com>

Use the existing dma_chan_name() helper to obtain the per-channel device
name instead of open-coding: dev_name(chan->dev->device) /
dev_name(chan2dev()).

Simplify the code, improve consistency and reduce line wrapping where
possible.

No functional change intended.

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Amelie Delaunay <amelie.delaunay@foss.st.com> # For STM32
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/dma-jz4780.c                       | 2 +-
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 3 +--
 drivers/dma/idma64.c                           | 3 +--
 drivers/dma/loongson/loongson2-apb-dma.c       | 2 +-
 drivers/dma/mmp_pdma.c                         | 3 +--
 drivers/dma/st_fdma.c                          | 2 +-
 drivers/dma/stm32/stm32-dma3.c                 | 2 +-
 drivers/dma/stm32/stm32-mdma.c                 | 3 +--
 include/trace/events/tegra_apb_dma.h           | 6 +++---
 9 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
index 6070dfdb7114c..194649811d02b 100644
--- a/drivers/dma/dma-jz4780.c
+++ b/drivers/dma/dma-jz4780.c
@@ -760,7 +760,7 @@ static int jz4780_dma_alloc_chan_resources(struct dma_chan *chan)
 {
 	struct jz4780_dma_chan *jzchan = to_jz4780_dma_chan(chan);
 
-	jzchan->desc_pool = dma_pool_create(dev_name(&chan->dev->device),
+	jzchan->desc_pool = dma_pool_create(dma_chan_name(chan),
 					    chan->device->dev,
 					    JZ_DMA_DESC_BLOCK_SIZE,
 					    PAGE_SIZE, 0);
diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index 9c21a5479437d..a36b066c3c33c 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -531,8 +531,7 @@ static int dma_chan_alloc_chan_resources(struct dma_chan *dchan)
 	}
 
 	/* LLI address must be aligned to a 64-byte boundary */
-	chan->desc_pool = dma_pool_create(dev_name(chan2dev(chan)),
-					  chan->chip->dev,
+	chan->desc_pool = dma_pool_create(dma_chan_name(dchan), chan->chip->dev,
 					  sizeof(struct axi_dma_lli),
 					  64, 0);
 	if (!chan->desc_pool) {
diff --git a/drivers/dma/idma64.c b/drivers/dma/idma64.c
index 5fcd1befc92da..e1fcce07d1c10 100644
--- a/drivers/dma/idma64.c
+++ b/drivers/dma/idma64.c
@@ -507,8 +507,7 @@ static int idma64_alloc_chan_resources(struct dma_chan *chan)
 	struct idma64_chan *idma64c = to_idma64_chan(chan);
 
 	/* Create a pool of consistent memory blocks for hardware descriptors */
-	idma64c->pool = dma_pool_create(dev_name(chan2dev(chan)),
-					chan->device->dev,
+	idma64c->pool = dma_pool_create(dma_chan_name(chan), chan->device->dev,
 					sizeof(struct idma64_lli), 8, 0);
 	if (!idma64c->pool) {
 		dev_err(chan2dev(chan), "No memory for descriptors\n");
diff --git a/drivers/dma/loongson/loongson2-apb-dma.c b/drivers/dma/loongson/loongson2-apb-dma.c
index aceb069e71fca..7c3d7c3273955 100644
--- a/drivers/dma/loongson/loongson2-apb-dma.c
+++ b/drivers/dma/loongson/loongson2-apb-dma.c
@@ -282,7 +282,7 @@ static int ls2x_dma_alloc_chan_resources(struct dma_chan *chan)
 	struct ls2x_dma_chan *lchan = to_ldma_chan(chan);
 
 	/* Create a pool of consistent memory blocks for hardware descriptors */
-	lchan->pool = dma_pool_create(dev_name(chan2dev(chan)),
+	lchan->pool = dma_pool_create(dma_chan_name(chan),
 				      chan->device->dev, PAGE_SIZE,
 				      __alignof__(struct ls2x_dma_hw_desc), 0);
 	if (!lchan->pool) {
diff --git a/drivers/dma/mmp_pdma.c b/drivers/dma/mmp_pdma.c
index 386e85cd4882a..863160de3b7d5 100644
--- a/drivers/dma/mmp_pdma.c
+++ b/drivers/dma/mmp_pdma.c
@@ -565,8 +565,7 @@ static int mmp_pdma_alloc_chan_resources(struct dma_chan *dchan)
 	if (chan->desc_pool)
 		return 1;
 
-	chan->desc_pool = dma_pool_create(dev_name(&dchan->dev->device),
-					  chan->dev,
+	chan->desc_pool = dma_pool_create(dma_chan_name(dchan), chan->dev,
 					  sizeof(struct mmp_pdma_desc_sw),
 					  __alignof__(struct mmp_pdma_desc_sw),
 					  0);
diff --git a/drivers/dma/st_fdma.c b/drivers/dma/st_fdma.c
index d9547017f3bd6..35dbff5f9f1ab 100644
--- a/drivers/dma/st_fdma.c
+++ b/drivers/dma/st_fdma.c
@@ -268,7 +268,7 @@ static int st_fdma_alloc_chan_res(struct dma_chan *chan)
 	struct st_fdma_chan *fchan = to_st_fdma_chan(chan);
 
 	/* Create the dma pool for descriptor allocation */
-	fchan->node_pool = dma_pool_create(dev_name(&chan->dev->device),
+	fchan->node_pool = dma_pool_create(dma_chan_name(chan),
 					    fchan->fdev->dev,
 					    sizeof(struct st_fdma_hw_node),
 					    __alignof__(struct st_fdma_hw_node),
diff --git a/drivers/dma/stm32/stm32-dma3.c b/drivers/dma/stm32/stm32-dma3.c
index 1ee1bd22703fb..6ee7a1435efb6 100644
--- a/drivers/dma/stm32/stm32-dma3.c
+++ b/drivers/dma/stm32/stm32-dma3.c
@@ -1126,7 +1126,7 @@ static int stm32_dma3_alloc_chan_resources(struct dma_chan *c)
 		goto err_put_sync;
 	}
 
-	chan->lli_pool = dmam_pool_create(dev_name(&c->dev->device), c->device->dev,
+	chan->lli_pool = dmam_pool_create(dma_chan_name(c), c->device->dev,
 					  sizeof(struct stm32_dma3_hwdesc),
 					  __alignof__(struct stm32_dma3_hwdesc), SZ_64K);
 	if (!chan->lli_pool) {
diff --git a/drivers/dma/stm32/stm32-mdma.c b/drivers/dma/stm32/stm32-mdma.c
index e3bbdc9ee36ed..c6dc8a9a7a288 100644
--- a/drivers/dma/stm32/stm32-mdma.c
+++ b/drivers/dma/stm32/stm32-mdma.c
@@ -1484,8 +1484,7 @@ static int stm32_mdma_alloc_chan_resources(struct dma_chan *c)
 	struct stm32_mdma_device *dmadev = stm32_mdma_get_dev(chan);
 	int ret;
 
-	chan->desc_pool = dmam_pool_create(dev_name(&c->dev->device),
-					   c->device->dev,
+	chan->desc_pool = dmam_pool_create(dma_chan_name(c), c->device->dev,
 					   sizeof(struct stm32_mdma_hwdesc),
 					  __alignof__(struct stm32_mdma_hwdesc),
 					   0);
diff --git a/include/trace/events/tegra_apb_dma.h b/include/trace/events/tegra_apb_dma.h
index 6d9f5075baa3e..c38117c127ef3 100644
--- a/include/trace/events/tegra_apb_dma.h
+++ b/include/trace/events/tegra_apb_dma.h
@@ -11,7 +11,7 @@ TRACE_EVENT(tegra_dma_tx_status,
 	TP_PROTO(struct dma_chan *dc, dma_cookie_t cookie, struct dma_tx_state *state),
 	TP_ARGS(dc, cookie, state),
 	TP_STRUCT__entry(
-		__string(chan,	dev_name(&dc->dev->device))
+		__string(chan,	dma_chan_name(dc))
 		__field(dma_cookie_t, cookie)
 		__field(__u32,	residue)
 	),
@@ -28,7 +28,7 @@ TRACE_EVENT(tegra_dma_complete_cb,
 	TP_PROTO(struct dma_chan *dc, int count, void *ptr),
 	TP_ARGS(dc, count, ptr),
 	TP_STRUCT__entry(
-		__string(chan,	dev_name(&dc->dev->device))
+		__string(chan,	dma_chan_name(dc))
 		__field(int,	count)
 		__field(void *,	ptr)
 		),
@@ -45,7 +45,7 @@ TRACE_EVENT(tegra_dma_isr,
 	TP_PROTO(struct dma_chan *dc, int irq),
 	TP_ARGS(dc, irq),
 	TP_STRUCT__entry(
-		__string(chan,	dev_name(&dc->dev->device))
+		__string(chan,	dma_chan_name(dc))
 		__field(int,	irq)
 	),
 	TP_fast_assign(

-- 
2.43.0

