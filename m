Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011067.outbound.protection.outlook.com [40.107.130.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F769331202;
	Wed, 12 Aug 2026 21:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786569869; cv=fail; b=VwL9O38uxLpNSvApocG9dJAAAJAOwsvHM0eeZlQ2E1fZsdpNQRKLV0gf7HLRMR+jOTMV8bXXYX4Pn2YZAoopYzd5/uJHp7dnhN6G0StFo3mns8vhtIgEJgyFXgkOIghkinauaZfvb64w+qm86UWlCBmuUMeuLj/FOpAOyBmWJSw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786569869; c=relaxed/simple;
	bh=UA98GhwZovdDcfmvuuvyw+1b9God/YO8Hnwwgyhk0pE=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=eRZ9YfLfZCY3dtcLzH/Lv6/eGjXvw4hRODpIpsXz688FJtfspckxo0BxjKO/sqrXW5cE+8HZDVDnoy24UNNKY3udkiWszGDfVUKevJHHmYMLq+vDjlNjvcjyMUDmYPevQrN9gm2DPAx1HzMEMyPBei5fa2ZujwApAQiw3R310mc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=nbyOGB0P; arc=fail smtp.client-ip=40.107.130.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="nbyOGB0P"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aqOj+l3+oIYqt4FSeIFo7qY4glL4an8FdoRrj4p3FVNkfHxO9/+gTtAgg108i62MQE4MLdZ1ZBmT57i/V2JzGZd8b9KxqKv+M6fy+i8STO0ctb1EiuHsRWQ286JQkSMYIHnM/x9UH/vV2jpZ2AhM8eZuQ9VdGxFeGsihbPPoC3IH9/P+yynX5EuBITZ/PJOv4EMwwPgHU1YLtDVUawkAkQfhoj9RF7gmQtwkm/Jt3TNXaB5dwhBV2O1mgjGsv01z5tK40b5Td+akBAR6Mze7Fw9JFy3fGCGxxc3fXo3Kmc3g8QmD7dhCYvdBW2ns9Cnl4OPsQ71XrtZYfRbJ1A8Cgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6r2ven/RnLXM8I08xHMpC7ryR8CYaNWA1hJhMRAb89c=;
 b=CSaeDFQ0GH/yOK24tRH3Ps/qtd+RsB1+eAptFJ5vcNQJHM+53Qf1ySnAqCFqvV6xtaSUaUgSExUavsXbqjguTkZvBCoJnJMnTGGEaSk2oSufirVrmFb2Cv9k0RNGvbuMUd5PaeVYlWf+nIZgRI0asWzAva92Ok5mWnHmgQ3+zAfHxFXdHQDauzlcvCWigXAnQR7lVq9wqWwgMPK07iNGX2Os/AoWKk2H1qoZ2mdIdGcrBJG+VLSN07B5rEZ2+v97RdgAibvF9BG6ueFtuP23HFusROMj0Tr7pWI1fkcZ91oaDOY1X9kyBy7EB40UjJUdn6SdDQ3fp4lMZcT1nNSQEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6r2ven/RnLXM8I08xHMpC7ryR8CYaNWA1hJhMRAb89c=;
 b=nbyOGB0Pmq7RnA5jJkV/BfiSl4utlC85XQzmL2Xb8PY9VWhWlTSOJy62q89R74/GY/duKPciWsY36h0ttQYm4iLsSmoCYTPxJWZ5tmYxpKkScaSKTiKEnz1DyLGII7NyxQ0ALrVKuCsrBF000RnUyjoeBz6pt4wheJ48HxYRq+Rix78NOTwZ1cyikzegZbseHs5U5qeFQl8MvgEEoIHyekpjbg8rZmpcYvfN+4InlDcahzy6Zz8iCMD6lERd+zWNI1t33iaPVcGgRESahAUDHpvO5uUT7GhvezDtxULddcAhNnKOC5UjDK8b8QmdATc+4qbdJkCCHp2GjbE/0Mijaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by GV4PR04MB11821.eurprd04.prod.outlook.com (2603:10a6:150:2e0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Wed, 12 Aug
 2026 21:24:21 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0315.012; Wed, 12 Aug 2026
 21:24:21 +0000
From: Frank.Li@oss.nxp.com
Subject: [PATCH 0/2] dmaengine: rename dma_chan::dev to dma_chan::chan_dev
 for clarity
Date: Wed, 12 Aug 2026 17:24:07 -0400
Message-Id: <20260812-dma-chan_dev-rename-v1-0-a67131f7d5c2@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHfkfGoC/yXMUQqDMBCE4avIPndBIw2tVymlrMlot2AsSRVBv
 HujPn4M86+UEBWJmmKliFmTjiGjuhTk3hJ6sPpsMqWx5a0y7AfhfXl5zBwRZABba2wt7gpxd8r
 Pb0Sny1F9PE+nqf3A/fYUbdsfkvysUXcAAAA=
X-Change-ID: 20260812-dma-chan_dev-rename-66263ac5eac9
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786569857; l=3124;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=UA98GhwZovdDcfmvuuvyw+1b9God/YO8Hnwwgyhk0pE=;
 b=O3dG0MBa76kCus/cynthz9VVRaJUyZlGllCA1GyS7TtkPUiiAbWt+EJRiKM3kltyYQ9mddXyZ
 2E6pVBPTgOQCN8W/oz31rN+z2TGCmDz7R+dg8/8N2w4fmkPSPqqsGKN
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA0PR13CA0024.namprd13.prod.outlook.com
 (2603:10b6:806:130::29) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|GV4PR04MB11821:EE_
X-MS-Office365-Filtering-Correlation-Id: b85ae998-4783-45ad-1356-08def8b81353
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|7416014|376014|19092799006|921020|56012099006|18002099003|10067099003|11063799006|41080700001;
X-Microsoft-Antispam-Message-Info:
	p4HDzsJxh/d3bb36/4fz0Z4VqThPAv+eG6e3s2LBt1LP4O0n3rN+hzWmh4cOvm2FhhZy29dO6K6SVhqaPnNNOIrtxCJ6sFjQm2N4qN9rSAJD1Npe4aa+pK3ne9uz/9Dsrp5V7dXMUXSxvItvizoELxz9XVnaObDkwoVk3RFFV7cbpUxBAGsvLVHHU0dWS0ciLVoY7e6DF0jUDbZF23vRhjbtOuDowYRhPEfCkDWhWV0RWclAgL67Kr9ASqZsIimuj4+ubjrd50iE4OW3X93j+EjTjA/2TftLWUXrMb4QsX2QcA9+i0hRjTXmOMQEAItt10uK3YEUw/VLWpcFxDC77kefF+UASt/ghBECH84KbK1sYxxFV0Sm7iwi7Ir5bsEC7dRJSEPvi4Mduk6OZBdE7OdGAdVJzstT5ic4jjDAcIzUOFZz7lYu1DJc2M7t/iD9bSgMYyF9duTUrADj9VUPrEdZBeZnDOLQut1togueVF4uex2hUC6g0XVx1fdxX8njZ0HeoJI00Lm0MHSd0VVALRfAh8WGbA51527Ukc0pgUQ3IopZk3v0JzE5KUSjQwJR8Ujz7wm+6qE/N3tzssiByZO22ZzbxjjOCtpS3WeRYcik6FdJ6/rcYIg4AAiIz11N35+GSP1cbKtxy1P6MlI7oatyotr1LHzVdQefcble27htTdgYYRPrb28toUveqUDF9OF5lqLON1eGc5FEClbxKTgi4vY+pzvtWG9vjgAU7eA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(7416014)(376014)(19092799006)(921020)(56012099006)(18002099003)(10067099003)(11063799006)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cDc2eUlGVDIxWVB5QnM4WCtPVDkraVdFdGNpKzlBL0N5eU43S0RId09oUktL?=
 =?utf-8?B?Tnhlb1RWd3RBQkdEaTd0NWk3MUZUK01weXFyb09uOWlOeGNyRnY5cmtMQUIx?=
 =?utf-8?B?NHcrSVIrcUxsMXN2Z1plRGRtSGhjL0owTXhycTl1MFU5K204WTVpU3BxZVRT?=
 =?utf-8?B?ZUNKdjZEMHlEa0kzMEpIZWdtcUpTelJjaXZmdzVlN21LbkJ0VmsrdEdGLzlX?=
 =?utf-8?B?OUdyU0E1eFF3cTV6VzNGQkJIVHNZWVNmdUxsajZzUW1MT0d2NmRtcThIem40?=
 =?utf-8?B?d2RJdjcwQkN3a0Ira2xrYjFjS292STgyRERNK09UZG4wR25OeCs3cm45Njcy?=
 =?utf-8?B?NTZBNjBZb3JLSEdyZHp3dWtYZlhzYWpwQTNxbk9DQWgxWTFZTmZFN3FZb3JO?=
 =?utf-8?B?NW9NQ2l2RmNRYjlXemZjNXhuNEpWMDNjNSszcUp1elU5UEpDV2x3WWpScm5w?=
 =?utf-8?B?d3NlT2JETUwwN1gwL0s1RWVWSWJhZ2M0eWpFN0VpQXZkSTBUelBMamUwbmwz?=
 =?utf-8?B?RDdYNC9XWkJCaFlrZWRuOGFSa2hMR2JvSnFtMzVFd3oxNnJXeFdMRGM2eXRB?=
 =?utf-8?B?dms5WkcwZ0dwTExETkxvODNPSlVxakRWUDRPdENJOXdBM2V6WG84eENZcnV4?=
 =?utf-8?B?NVRBNnNtbDMyTFUxbU5WbzlIU1haSW9acFU2d3JFZU1JQ1hNMzdjWUoxam9r?=
 =?utf-8?B?dGJYOEZVb1d2VGZjY1dKOThpSUh6WXY1cCtHcDA1eHp5V09iTkh4UzNBWW5p?=
 =?utf-8?B?VWdxR0h4NnE5eDdlVHRsNFBrNW5JcEZLWUVnNEFLRytqaHRSQWYvcTFXbi9v?=
 =?utf-8?B?TDlTVzh1cUJvdGdndnpxblpFQVd1WVJEK1VTKzFGTEk4SVhsRGozaGRUZDBw?=
 =?utf-8?B?WFViZnhzK2MxaXBtY1lHY2VQYkFtNE8vQU82aVpJQm5zeE5CMU1sVk1OZHJV?=
 =?utf-8?B?dE5jYzNOZmV4N3RQRjRTSzN3M0QySENMRGhmWnE3YWxieDh1K2N5RWlKcnJF?=
 =?utf-8?B?WHd3allaNDlNK0gzR2VLbmsyY1dWM1V4azdrT0ErRHhqL01NdmxKOEJ2cjJX?=
 =?utf-8?B?cDRHY1QzdDJ4UEVtWDhsZFhrdzQ3bzQvNGxwQ0xZdnIrZ0F5RVl2NStFKzlY?=
 =?utf-8?B?bVA1SnpubW5FK3Vaa0RkbTlkMXYrNldKVnJERWhOTXRodUlad2JMNjFyT3FL?=
 =?utf-8?B?UzF3VFZYV1NmWXNiUDAyWDhiVGVMSzVMcFFqNTlRc21RejhtWTROeCt6WEJm?=
 =?utf-8?B?SDFneUEvSDRpMzZZb2hKWDZoQk9jUVlybXl1U0lOYy9rcHR2QWFZTWdUZk8z?=
 =?utf-8?B?SE5vQ2JYUXRjOFQyS1NYMEtwUGQzMzdMY2ZVWTNjcU4wMWl5dW1ZdlBzd1lj?=
 =?utf-8?B?ajN0ZEx4ZXJBUmxVOUQyaGdTZ05wU2dFTjVrR0xwY1ZETUU5U1hqbVhTU0Rj?=
 =?utf-8?B?SlY0cGlVRHA4dU56ekxhTlErbHIrYStDL255RGZKcFBLWXFVaG83LzRrcnhC?=
 =?utf-8?B?UWxPVEJvL1NJZktaNTUwQU4wanpPM2FtN1NtQ0R3Ylo5RFFiS2FpUG9HZ0hH?=
 =?utf-8?B?R29KOHB2c1dOYk5IcjEwUU5EMnBsdkVrUTlZMmdFWUtQZHpHVVZBYzlVOUVn?=
 =?utf-8?B?dFdpbnJEUlZiZkhMaFFXVTlNaFBCNkxqWXZpWTJ6b3gxOGJZWWs0M2wrcUlq?=
 =?utf-8?B?RStSbmxMV3NZMkZhTlhIbTg5clBwWDRndlVtRkFhTFRVMjhkSkl2VmdFSkRp?=
 =?utf-8?B?WGdCM0hya0Ntb29hWkJUVWJzVFRzRHRvOURZSmdHb3VsTjk1SmRlT0xBeFE3?=
 =?utf-8?B?TVN0VVFWYURQVHpwZ1Y4RnBVZlMrcEVLQXVIZGVGemFwbVRBb1V2OElMWm56?=
 =?utf-8?B?bUt5SVpVeGZHZjQwRmw4aWdxNW9xbmNmM3BHZXpYQjhtWGtYTnBhbCtXanVL?=
 =?utf-8?B?MTd1YkFBL1dNbjhrQzd6R0lPTXo0bWtLMHJ6UC9PQ0RDamFzdFUyWUYxNnd4?=
 =?utf-8?B?MkI1cmorS2RUektDYXNhNy9Vb0JnRnduclhRZ2NmcXVJYm9TNmhzblA5cStR?=
 =?utf-8?B?eVJVbStpaGd3VUl3YjVEb0ZBVjFEd0IvWjV5SkNlanNVQnNkM0NtVTVLQjB3?=
 =?utf-8?B?a0hrRXpac2M5MElPWUxKOUhXajJiZTRURmFkUUNzcmF0bXIvZUxkOEQ3b2Zv?=
 =?utf-8?B?Rko3d1BSZFJkNjZSbStCdXNBdG9NbGFxNUEzTE8zN3AxQTJMMUh6aDJFbXh0?=
 =?utf-8?B?RDV2cXI2bmo4aXMyQWNxdDJhUEFFWXcyU2FwbkJBZDhZZmx6UXo1N1JRWkJB?=
 =?utf-8?B?a05wS0I1YjRnTzZDb2ZLdWpJTzZvaUFFMENsL0NlN0Z4Yy9pZi9EV3g5R0xO?=
 =?utf-8?Q?7GQslGTb3wx8l4I8MalVZ7CMmVYX4QPi6vzLe?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b85ae998-4783-45ad-1356-08def8b81353
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 21:24:21.8024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4teVXYxJeLPy/7htDi1ZDbQboXNnc+vogORtO5UiVZsehF73hRh2vhjorSOy6MD0TMu/ujffe/8VU7gB9cXEXSTOro61s0ARzRw5X6if6Ef42Gg7JfK6ro1ryA77q2+U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11821

The current dma_chan structure contains both "device" and "dev". So

    chan->device->dev refers to the DMA engine device.
    chan->dev->device refers to the per-channel device instance.

Their similar naming makes the distinction unclear and increases reader
confusion.

Add union dma_chan::chan_dev to make its purpose explicit and clearly
identify it as the per-channel device. After all user switch to chan_dev,
union and dma_chan::dev will be removed.

Update the kernel-doc accordingly. Besides its sysfs usage, the per-channel
device is also used by some DMA engine drivers for IOMMU mapping and
therefore deserves a more accurate description.

1st patch use existing helper dma_chan_name() to reduce rename difference.
2nd rename drivers/dma

Need following patch to clean other dma engineer driver, which is not
in drivers/dma

After complete all rename work, dma_chan::dev can be removed.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Frank Li (2):
      dmaengine: use dma_chan_name() helper to get per-channel device name
      dmaengine: add union chan_dev for dma_chan::dev for clarity

 drivers/dma/arm-dma350.c                       |  2 +-
 drivers/dma/at_hdmac.c                         |  2 +-
 drivers/dma/at_xdmac.c                         |  2 +-
 drivers/dma/dma-jz4780.c                       | 10 ++---
 drivers/dma/dmaengine.c                        | 34 ++++++++---------
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c |  2 +-
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h          |  4 +-
 drivers/dma/dw/core.c                          |  2 +-
 drivers/dma/ep93xx_dma.c                       |  2 +-
 drivers/dma/idma64.c                           |  4 +-
 drivers/dma/loongson/loongson1-apb-dma.c       |  2 +-
 drivers/dma/loongson/loongson2-apb-cmc-dma.c   |  4 +-
 drivers/dma/loongson/loongson2-apb-dma.c       |  4 +-
 drivers/dma/mmp_pdma.c                         |  2 +-
 drivers/dma/nbpfaxi.c                          |  2 +-
 drivers/dma/owl-dma.c                          |  2 +-
 drivers/dma/pch_dma.c                          |  2 +-
 drivers/dma/pxa_dma.c                          | 52 +++++++++++++-------------
 drivers/dma/st_fdma.c                          |  2 +-
 drivers/dma/stm32/stm32-dma.c                  |  4 +-
 drivers/dma/stm32/stm32-dma3.c                 |  8 ++--
 drivers/dma/stm32/stm32-mdma.c                 |  4 +-
 drivers/dma/sun6i-dma.c                        |  2 +-
 drivers/dma/switchtec_dma.c                    | 14 +++----
 drivers/dma/tegra186-gpc-dma.c                 |  4 +-
 drivers/dma/tegra20-apb-dma.c                  |  2 +-
 drivers/dma/ti/k3-udma.c                       |  6 +--
 drivers/dma/timb_dma.c                         |  2 +-
 include/linux/dmaengine.h                      | 18 ++++++---
 include/trace/events/tegra_apb_dma.h           |  6 +--
 30 files changed, 107 insertions(+), 99 deletions(-)
---
base-commit: 28d012efb4327f9c75d5e042a7c91e9a542efa98
change-id: 20260812-dma-chan_dev-rename-66263ac5eac9

Best regards,
--  
Frank Li <Frank.Li@nxp.com>

