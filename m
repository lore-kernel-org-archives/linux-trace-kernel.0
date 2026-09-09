Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013070.outbound.protection.outlook.com [52.101.72.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55ECE582BA2;
	Wed,  9 Sep 2026 16:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788970985; cv=fail; b=RWRC6ek30mr18IGxEOlHzRRWnnwC44ASegfUQfvg+mQhnpVHc+tWDn9+Tiugv0YF60neGkuC0k8yVTQrO9L+hY/a9C4tWxlbpBu/8UsBWpo5ww1EzouXFqEzFEPim/qYSSgMieKt/dJl46twwEQU5AlXbK4giiWqtD8TZDW+P6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788970985; c=relaxed/simple;
	bh=px9TNhLJee67q4928tK76Zcc4AHjWLKdLSrvxqKM9rk=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=PSueoaJfabXgzhmNYB8qOqe6fbdrzUforO6Olo6rn4h8U7u25P3oOoUk79qDbR2a3rYWrSFiODpm+EEANb1wNW3lgI1OifCN6JwAI5JKGvq6P9FXcat5qRLTXFUTppIc0e027efLj6CP/RozvtV47UmQa6VuwhKJeu1tUTwcPHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=JjGvQNm8; arc=fail smtp.client-ip=52.101.72.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="JjGvQNm8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lmXQjuAaLMu7yZIheLfTZJIf/JRnAddIO0thUeee/JIAHexV6JWKLi5ZNjBnGK8BV8LlI15w9Tz166m+/8f8gqY9kIbsDKzLQKIJTB+Ykrq+MhmdxVOPC79WUbAf8NkFkBE9yRd/W0MCigjFho+LrgbtWtTbfvstZIwDItXq0vUfjWium4/VhYF2Y9B8h8PZZqHna3jCasLi5UICYtS00KHmAyv4oiE577OuYTsX949T+1Ef85N6p0rgMbZgGrrALFzGTFPahIFD6gqtCDQXk42rmQCSToIggflqd4LIpZ3rYvh628gwgBC7qyAFy+NkhulV5V+/Ou3emVXWqhc6zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bD3VuV8PSqNCW6q1gda7/sLhQreEjh9RKnDiVYhvKdo=;
 b=HuikEaJ5+NqC9vkdlP3a493sK2u0hly0h73by0yzyMoG/HC1RmyAlMYBDbuySVjoMr7C74ISuU92jeUQ9tAJTs4LGvLBnQxGAuGQUh9mvSQ4ut8JBHWDaaVUpuq8AY30Fpkm/VH/B7DCBAzCMinN+aHQjAwbVuzciuNIeLR904mOYVf8s21StmlvJzBG2Q9xs8sGrNUFzqJBaMtUiCvQ62nnVJnh0fM6Z5SxSnFU1w8w4p807H8yOzaQmNd2uP0Hmennh+DK/2hViD4YSv+Z26y7TwHvg2Nh7TRiPQWeuM8Vj244kRwuau9KSrwoW4Ygh/2cXYIPfVyazzO2cOLmTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bD3VuV8PSqNCW6q1gda7/sLhQreEjh9RKnDiVYhvKdo=;
 b=JjGvQNm8GnfTZyQauuTTPry1Kg7sKVUjKmhEgv1aAE4mr5n0QzE7AXFW59PjC3ljIj8v2coHHCccqXproNmozpg//6ngtn6RiCPwPuYyHy5hiXaWRFZ2OMYRD5tR0nQDsrzGdSMpZF90IdB4v0Z8hPcoRbiZ6AugqYwz9ZcIxHAAg87sqXomgKf0ZYqFJQWTadUR/TId3DzJ34l56hN3EZnfsr8ZHiqyqhVR6Dsu0T184aKfu0aWrenbFJ7kuYMTbohIxkt0wbkFoMTXZSO+KOAzZB27E46fi5tfwH/BnmOZRwNoZf7p7BFiSrzJ+H5cyS3W4VCu//qxkznxE17+fg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AM0PR04MB6786.eurprd04.prod.outlook.com (2603:10a6:208:184::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Wed, 9 Sep 2026
 16:22:53 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 16:22:53 +0000
From: Frank.Li@oss.nxp.com
Date: Wed, 09 Sep 2026 12:22:30 -0400
Subject: [PATCH v4 3/4] dmaengine: add (dmaengine|vchan)_chan_dev() helper
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-dma-chan_dev-rename-v4-3-d8fb6892a70f@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788970951; l=166390;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=NeYBiUVs0Vuo4fgyczBfo2CbhYZkt/8RMsCu9MsWOJQ=;
 b=1cLMyuOzP82u/fJzxMMiaU2LtU8+sCLvq83RoMvmkoEa+OH6PqufFZUER1lS1BqgFWa9S+lha
 unjDSc4WC/XCz3+GHVOFwThuZUoqU2om8QWX20LzbJsJYk1uCIzXJ5r
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH3PEPF000040A3.namprd05.prod.outlook.com
 (2603:10b6:518:1::57) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AM0PR04MB6786:EE_
X-MS-Office365-Filtering-Correlation-Id: dba944ea-72ef-41b1-b4e5-08df0e8e98f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|19092799006|366016|23010399003|1800799024|921020|6133799003|3023799007|10067099003|5023799004|56012099006|11063799006|22082099003|18002099003|41080700001;
X-Microsoft-Antispam-Message-Info:
	+UQtOwBe4vxWS2Cgr/aquPaEHwWxEQhsBeYVSWCOaHyxsd7NuS6PA6Vsl/PzNd5Y2UT469uH+j9LhSjU0d1Ndpbph3WWyUAmZVzLn0cIyY3hUN+AkyvbewcaLrb4uETs24Z6g5UZXtMF1dACjwwYPgd+H9xZnH+6TGNvvR5x/2ixKD/rZ/m8i4O9RCi5Qjx4xKCl8laFG9mZwS9e6BbcW6wxlgUODAUHwGEdoTCxAxXymA1xsm+Qd4xxfHUNPlTJIXL9Af0UjFaW+vV1q4JYVicF/McGX7g3s0XkcmcfT2bxKmYbkcPkjco+APWM9NvGaHED7Vm1jivvcK0ggDOfhvfEKKHHGlxChdd8dpNKczJRrEkaAguam8sSbrmP8jz3UtxM5z2+i6vBcktW6qm8odv7qQCjdj/xg3DseTv4QoTPTNi6xmS057UJ2pX7SZM5odE3/jVvDmTfhvoSkCviQm19Mw0ezXKVs1pL5/ZQRxrhK/QjF/DTAD6TTKsvazgsW0NBbnu79ck5JQ3mNCpFOL7iLZDnLG8MlneQgQMYnKvU9cLwGYJvPqqtgrOvHZxSC/61oAX9RynxdAhTXz7/m9yqjeQQkjtU80mH+/1cebces0DpNiIPUFGZHW4jno/SSdY5pK8gahkSaE5vzn3YDm8DaPwWwCKLG8c7kPHjz6pim1Zskzzdkikhswzo7YasfA/j4yi9zj6cmvpdi9wEt/nf/q7yQnNEQl9pVJOfdtg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(19092799006)(366016)(23010399003)(1800799024)(921020)(6133799003)(3023799007)(10067099003)(5023799004)(56012099006)(11063799006)(22082099003)(18002099003)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Qm44eGxUeFFiRHRCTy9tMTlxY3UvZDE3Y09JK1Y5OFVBc3hwNHBQZHh5Wndw?=
 =?utf-8?B?OFJ3eHRzMnNuOG1TcHQ3bWEycW5yMHg2WkFpZVUxNmRoVFpJeWRNK3RQelBL?=
 =?utf-8?B?eGhwaEZxVFRFUUxIVzVvZTRpR1ZSR2t3OS9MeUlpVmZYMDY2RXR1bG5jSEZP?=
 =?utf-8?B?MHM0OFZVYTBSY3U3VXRzb2oycjBCdXdhNWJQU1ZJZTN0czd1NWhSSXNXazAw?=
 =?utf-8?B?VkRYM21iWGpaMUtieG9jT0RTNDRXOVlkTVZzaGRkc0Z5RzVyS25Fb2tGVnJS?=
 =?utf-8?B?RWJuNEptVEoySG9vVzAzMTVpb1lUUDFwY0hzN2U4cDh1c3ZwRHhtRGF2QXc4?=
 =?utf-8?B?akVpc0xlYjNiMWltV0dzSmJPSVlReU1RT3lTcENHRDZuUFlZRmFWMlFHWmhZ?=
 =?utf-8?B?Y2I0cGlqRExleHkxTnNJaUNBa0Q3dVY4YVFPTkFPR1V2b2F1TkpVMFZVOE4v?=
 =?utf-8?B?ZEZQTmVHNXBPRU5qUVZleXR2Ulh5MFZRT3FuaWxhaVMxT2xBaXFtaUFHblg2?=
 =?utf-8?B?cFZhLzVYcUVuemVRNjJ6MG9CU1BsdGxBVGxMVTl1bUszWEpiWkdLZndGSTBj?=
 =?utf-8?B?MDdNVUdtWVlBVVViQ0p3ZGJiQzIzZGErT09Yb1plVW1Ua1ZhMkpoSHJkWFNr?=
 =?utf-8?B?OE9JTWVTT09vWTZid2NaZXFnU1ZCNFFtd2NJV3ZPek9LdjM0d0pKeW1YSWhW?=
 =?utf-8?B?M3Azdmw4Zzlncm1ncEJYQWQxWStEcWhqeGlmbDBtNjkyYmFYNXhoWEdhMHZC?=
 =?utf-8?B?NHdsQ1BrZy9Ba3drYjZ4Ly9Bdm9CSFpwYWkrcDJVNnlUOWZPdEVuWlpodXdP?=
 =?utf-8?B?NkQwem1YdXBOcXBRdk54TUlqRVFCSnJJYWxTZWpaZUR0ZWV2MVlpM2pDQUlU?=
 =?utf-8?B?T2hybCtzSm1PT21FZkNUVVE5SFdUaEhyc0o2cktlTjhmRjQ3OEdyT3pld1Na?=
 =?utf-8?B?eG52YUg3T1JKUm01SDB3dlB2TDZnc0JkMjZURGJ4L2tlM2twNlh4WVl2Q3o2?=
 =?utf-8?B?cUFEWUNQZXFNUzFiUktVeTJabzlBN2xkdmlkZjZZaFE5dkhJd2l6OENHdG56?=
 =?utf-8?B?WDg5c0JwWmc1NmFGVzJycThNeTNmOHcyQ0xzQjNtanB1T1pNV1p1VFhGWHVz?=
 =?utf-8?B?bUNMa21rcEh1WlRaV3FFZi9aaU4ybHZhRlRGdkpCTFovYlpuVG53aVJTdUNw?=
 =?utf-8?B?dlRGMkREbnJNbXlaWWtHdG85ZUxKb01ZdkNzN21QZ1hEWW9WWCsvc29sTGxQ?=
 =?utf-8?B?WXJWZGs3QXZDcmVSejFleVYxbkdYVjhHWU92dWxmWlo4eFBBKzdBREVqUGds?=
 =?utf-8?B?WXF6UjZYWUNuYlBNYjBrS0k2T25Fc0dWRHVPdzdZZWVGNFhIQzhOL1VvZHhr?=
 =?utf-8?B?OGJzbVAyTVZsTFcrek9jMFZheVN2QnFmSVYxa3B1amN1cCs0UzdUTjgrNlpk?=
 =?utf-8?B?cFM2dWxnY2FVSkVPa1I1Q3o1RE9IUThkeE5MM20wcHdScDBsREJMVkFzaGhl?=
 =?utf-8?B?SFdDNU5KcnpvYVRDeXpVWHYwM0JVd29Ldk5YRWxFTWw1YmNKVzdJdFV4MnVJ?=
 =?utf-8?B?dFJHRG5NMXhzTU1tK0NRV1JlL2NGSWJLRk4xMFNFd2RwcnF0KzhBT2FCaWY3?=
 =?utf-8?B?SWtJZ3BYc0hsenFNd29UVEZSUHh0RjhxY3p2VzNWVHlQVDFPMldPTzgzOHpq?=
 =?utf-8?B?aHJ0ckdjZ0RuWmFxZkZmNzVaM2dxb000ZVRJbUZCZmZ3dFVqcS92b3JYazBz?=
 =?utf-8?B?SHdBQVJjdzhWOEFhZklKN2JCT1ZYU2VDZnhoZ05CaEpLQVEzMDNneUlCMlpv?=
 =?utf-8?B?WC9LZ09UVmZWaExUaDdlNFVsK1cwNUdLdDNmNDhUNWJpTDlSdlpveUk3TUpr?=
 =?utf-8?B?KzA0UkZFU01nM3VHSDdDZklRQ0QwVEpVc2xpS3Q3TjNIUDNuVHRmUXNSSzVq?=
 =?utf-8?B?TzhwYmN3ODB5cVJUZjhCeHYvalZwWUN5M2VHOE02Q3d0MlNMTy9LTW5pMno1?=
 =?utf-8?B?c1Z0Wnk5Z0ZxMWFadHk3VXREbHR1Ukt4MUhCeU0vb3dVWWVXeGs5KzRkZUgv?=
 =?utf-8?B?b3VWWUJuQnBmL04rVjQvNzV2akhxMVBPY1YvOUx0aGVQTkpLaFUyMzdsaUNx?=
 =?utf-8?B?cWgwVHBwdkkvNmN5OVpONFNhU1ExT2Z0cCszSUlmaFNSWXl5aGxHT3ByNXVY?=
 =?utf-8?B?MmlDR0V4SWRvTmNoZXdsWWxlckNxdGNxV0M0YjdRMHZ1NWhnVUx0bkhDWnI5?=
 =?utf-8?B?eCs2dTZOUkxvNGtDTEMwbTlzenpQSkhQNWJsK0NBMVNwckZQS2xxa2pkckFH?=
 =?utf-8?B?b1dycHB1a2Q1WmxrSmFQOXVrdVpMazAvVGJ5MWp1em9DV25JemVSWDNBWEFw?=
 =?utf-8?Q?Zulod8g/RH6xm8k02RZgcaFEkYkT7T8N/6eN4?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dba944ea-72ef-41b1-b4e5-08df0e8e98f1
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 16:22:53.1380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5OL/yZh9vtDiCIJ/D+6Br3kItYaFVAtIXlSGp9O3LXRDoXBuPx/02edNqj8ZJrEfQyhtCqvOM+j0X+iKRqslz8sVEKlfIdbERqgji8rP7Zm+g8OjkflkvZkYDoFUHoY7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6786

From: Frank Li <Frank.Li@nxp.com>

Add a new helper function (dmaengine|vchan)_chan_dev() to access the DMA
channel device embedded in struct dma_chan_dev (chan->dev->device). This
provides a cleaner API instead of open-coding &chan->dev->device throughout
the drivers.

Replay private chan2dev() and dchan2dev() with this new common APIs in
indivial DMA engine drivers.

Prepare rename dma_chan::dev field.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/at_hdmac.c                         |  81 ++++++-------
 drivers/dma/at_xdmac.c                         | 159 ++++++++++++-------------
 drivers/dma/dma-jz4780.c                       |   8 +-
 drivers/dma/dmaengine.c                        |  20 ++--
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c |  36 +++---
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h          |  10 --
 drivers/dma/dw/core.c                          |  47 ++++----
 drivers/dma/ep93xx_dma.c                       |  37 +++---
 drivers/dma/idma64.c                           |   7 +-
 drivers/dma/loongson/loongson1-apb-dma.c       |  23 ++--
 drivers/dma/loongson/loongson2-apb-cmc-dma.c   |  15 +--
 drivers/dma/loongson/loongson2-apb-dma.c       |   7 +-
 drivers/dma/moxart-dma.c                       |  23 ++--
 drivers/dma/nbpfaxi.c                          |   2 +-
 drivers/dma/owl-dma.c                          |  21 ++--
 drivers/dma/pch_dma.c                          |  41 +++----
 drivers/dma/pxa_dma.c                          |  52 ++++----
 drivers/dma/ste_dma40.c                        |  15 +--
 drivers/dma/stm32/stm32-dma.c                  |  67 +++++------
 drivers/dma/stm32/stm32-dma3.c                 |  93 +++++++--------
 drivers/dma/stm32/stm32-mdma.c                 |  93 +++++++--------
 drivers/dma/sun4i-dma.c                        |  17 +--
 drivers/dma/sun6i-dma.c                        |  31 ++---
 drivers/dma/switchtec_dma.c                    |  14 +--
 drivers/dma/tegra186-gpc-dma.c                 |   2 +-
 drivers/dma/tegra20-apb-dma.c                  |   2 +-
 drivers/dma/ti/k3-udma.c                       |   2 +-
 drivers/dma/timb_dma.c                         |  63 +++++-----
 drivers/dma/txx9dmac.c                         |  73 ++++++------
 drivers/dma/virt-dma.h                         |   5 +
 include/linux/dmaengine.h                      |   7 +-
 31 files changed, 489 insertions(+), 584 deletions(-)

diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index f4d0c72787d13..9991452286850 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -381,23 +381,18 @@ static inline struct at_dma *to_at_dma(struct dma_device *ddev)
 
 /*--  Helper functions  ------------------------------------------------*/
 
-static struct device *chan2dev(struct dma_chan *chan)
-{
-	return &chan->dev->device;
-}
-
 #if defined(VERBOSE_DEBUG)
 static void vdbg_dump_regs(struct at_dma_chan *atchan)
 {
 	struct at_dma	*atdma = to_at_dma(atchan->vc.chan.device);
 
-	dev_err(chan2dev(&atchan->vc.chan),
+	dev_err(vchan_chan_dev(&atchan->vc),
 		"  channel %d : imr = 0x%x, chsr = 0x%x\n",
 		atchan->vc.chan.chan_id,
 		dma_readl(atdma, EBCIMR),
 		dma_readl(atdma, CHSR));
 
-	dev_err(chan2dev(&atchan->vc.chan),
+	dev_err(vchan_chan_dev(&atchan->vc),
 		"  channel: s0x%x d0x%x ctrl0x%x:0x%x cfg0x%x l0x%x\n",
 		channel_readl(atchan, SADDR),
 		channel_readl(atchan, DADDR),
@@ -412,7 +407,7 @@ static void vdbg_dump_regs(struct at_dma_chan *atchan) {}
 
 static void atc_dump_lli(struct at_dma_chan *atchan, struct at_lli *lli)
 {
-	dev_crit(chan2dev(&atchan->vc.chan),
+	dev_crit(vchan_chan_dev(&atchan->vc),
 		 "desc: s%pad d%pad ctrl0x%x:0x%x l%pad\n",
 		 &lli->saddr, &lli->daddr,
 		 lli->ctrla, lli->ctrlb, &lli->dscr);
@@ -790,8 +785,8 @@ static void atc_handle_error(struct at_dma_chan *atchan, unsigned int i)
 	 * controller flagged an error instead of scribbling over
 	 * random memory locations.
 	 */
-	dev_crit(chan2dev(&atchan->vc.chan), "Bad descriptor submitted for DMA!\n");
-	dev_crit(chan2dev(&atchan->vc.chan), "cookie: %d\n",
+	dev_crit(vchan_chan_dev(&atchan->vc), "Bad descriptor submitted for DMA!\n");
+	dev_crit(vchan_chan_dev(&atchan->vc), "cookie: %d\n",
 		 desc->vd.tx.cookie);
 	for (i = 0; i < desc->sglen; i++)
 		atc_dump_lli(atchan, desc->sg[i].lli);
@@ -886,7 +881,7 @@ atc_prep_dma_interleaved(struct dma_chan *chan,
 
 	first = xt->sgl;
 
-	dev_info(chan2dev(chan),
+	dev_info(dmaengine_chan_dev(chan),
 		 "%s: src=%pad, dest=%pad, numf=%zu, frame_size=%zu, flags=0x%lx\n",
 		__func__, &xt->src_start, &xt->dst_start, xt->numf,
 		xt->frame_size, flags);
@@ -903,7 +898,7 @@ atc_prep_dma_interleaved(struct dma_chan *chan,
 		if ((chunk->size != xt->sgl->size) ||
 		    (dmaengine_get_dst_icg(xt, chunk) != dmaengine_get_dst_icg(xt, first)) ||
 		    (dmaengine_get_src_icg(xt, chunk) != dmaengine_get_src_icg(xt, first))) {
-			dev_err(chan2dev(chan),
+			dev_err(dmaengine_chan_dev(chan),
 				"%s: the controller can transfer only identical chunks\n",
 				__func__);
 			return NULL;
@@ -916,7 +911,7 @@ atc_prep_dma_interleaved(struct dma_chan *chan,
 
 	xfer_count = len >> dwidth;
 	if (xfer_count > ATC_BTSIZE_MAX) {
-		dev_err(chan2dev(chan), "%s: buffer is too big\n", __func__);
+		dev_err(dmaengine_chan_dev(chan), "%s: buffer is too big\n", __func__);
 		return NULL;
 	}
 
@@ -983,11 +978,11 @@ atc_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
 	u32			ctrla;
 	u32			ctrlb;
 
-	dev_dbg(chan2dev(chan), "prep_dma_memcpy: d%pad s%pad l0x%zx f0x%lx\n",
+	dev_dbg(dmaengine_chan_dev(chan), "prep_dma_memcpy: d%pad s%pad l0x%zx f0x%lx\n",
 		&dest, &src, len, flags);
 
 	if (unlikely(!len)) {
-		dev_err(chan2dev(chan), "prep_dma_memcpy: length is zero!\n");
+		dev_err(dmaengine_chan_dev(chan), "prep_dma_memcpy: length is zero!\n");
 		return NULL;
 	}
 
@@ -1062,7 +1057,7 @@ static int atdma_create_memset_lli(struct dma_chan *chan,
 
 	xfer_count = len >> 2;
 	if (xfer_count > ATC_BTSIZE_MAX) {
-		dev_err(chan2dev(chan), "%s: buffer is too big\n", __func__);
+		dev_err(dmaengine_chan_dev(chan), "%s: buffer is too big\n", __func__);
 		return -EINVAL;
 	}
 
@@ -1102,23 +1097,23 @@ atc_prep_dma_memset(struct dma_chan *chan, dma_addr_t dest, int value,
 	char			fill_pattern;
 	int			ret;
 
-	dev_vdbg(chan2dev(chan), "%s: d%pad v0x%x l0x%zx f0x%lx\n", __func__,
+	dev_vdbg(dmaengine_chan_dev(chan), "%s: d%pad v0x%x l0x%zx f0x%lx\n", __func__,
 		&dest, value, len, flags);
 
 	if (unlikely(!len)) {
-		dev_dbg(chan2dev(chan), "%s: length is zero!\n", __func__);
+		dev_dbg(dmaengine_chan_dev(chan), "%s: length is zero!\n", __func__);
 		return NULL;
 	}
 
 	if (!is_dma_fill_aligned(chan->device, dest, 0, len)) {
-		dev_dbg(chan2dev(chan), "%s: buffer is not aligned\n",
+		dev_dbg(dmaengine_chan_dev(chan), "%s: buffer is not aligned\n",
 			__func__);
 		return NULL;
 	}
 
 	vaddr = dma_pool_alloc(atdma->memset_pool, GFP_NOWAIT, &paddr);
 	if (!vaddr) {
-		dev_err(chan2dev(chan), "%s: couldn't allocate buffer\n",
+		dev_err(dmaengine_chan_dev(chan), "%s: couldn't allocate buffer\n",
 			__func__);
 		return NULL;
 	}
@@ -1174,18 +1169,18 @@ atc_prep_dma_memset_sg(struct dma_chan *chan,
 	int			i;
 	int			ret;
 
-	dev_vdbg(chan2dev(chan), "%s: v0x%x l0x%x f0x%lx\n", __func__,
+	dev_vdbg(dmaengine_chan_dev(chan), "%s: v0x%x l0x%x f0x%lx\n", __func__,
 		 value, sg_len, flags);
 
 	if (unlikely(!sgl || !sg_len)) {
-		dev_dbg(chan2dev(chan), "%s: scatterlist is empty!\n",
+		dev_dbg(dmaengine_chan_dev(chan), "%s: scatterlist is empty!\n",
 			__func__);
 		return NULL;
 	}
 
 	vaddr = dma_pool_alloc(atdma->memset_pool, GFP_NOWAIT, &paddr);
 	if (!vaddr) {
-		dev_err(chan2dev(chan), "%s: couldn't allocate buffer\n",
+		dev_err(dmaengine_chan_dev(chan), "%s: couldn't allocate buffer\n",
 			__func__);
 		return NULL;
 	}
@@ -1200,11 +1195,11 @@ atc_prep_dma_memset_sg(struct dma_chan *chan,
 		dma_addr_t dest = sg_dma_address(sg);
 		size_t len = sg_dma_len(sg);
 
-		dev_vdbg(chan2dev(chan), "%s: d%pad, l0x%zx\n",
+		dev_vdbg(dmaengine_chan_dev(chan), "%s: d%pad, l0x%zx\n",
 			 __func__, &dest, len);
 
 		if (!is_dma_fill_aligned(chan->device, dest, 0, len)) {
-			dev_err(chan2dev(chan), "%s: buffer is not aligned\n",
+			dev_err(dmaengine_chan_dev(chan), "%s: buffer is not aligned\n",
 				__func__);
 			goto err_free_desc;
 		}
@@ -1264,13 +1259,13 @@ atc_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 	struct scatterlist	*sg;
 	size_t			total_len = 0;
 
-	dev_vdbg(chan2dev(chan), "prep_slave_sg (%d): %s f0x%lx\n",
+	dev_vdbg(dmaengine_chan_dev(chan), "prep_slave_sg (%d): %s f0x%lx\n",
 			sg_len,
 			direction == DMA_MEM_TO_DEV ? "TO DEVICE" : "FROM DEVICE",
 			flags);
 
 	if (unlikely(!atslave || !sg_len)) {
-		dev_dbg(chan2dev(chan), "prep_slave_sg: sg length is zero!\n");
+		dev_dbg(dmaengine_chan_dev(chan), "prep_slave_sg: sg length is zero!\n");
 		return NULL;
 	}
 
@@ -1310,7 +1305,7 @@ atc_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 			mem = sg_dma_address(sg);
 			len = sg_dma_len(sg);
 			if (unlikely(!len)) {
-				dev_dbg(chan2dev(chan),
+				dev_dbg(dmaengine_chan_dev(chan),
 					"prep_slave_sg: sg(%d) data length is zero\n", i);
 				goto err;
 			}
@@ -1359,7 +1354,7 @@ atc_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 			mem = sg_dma_address(sg);
 			len = sg_dma_len(sg);
 			if (unlikely(!len)) {
-				dev_dbg(chan2dev(chan),
+				dev_dbg(dmaengine_chan_dev(chan),
 					"prep_slave_sg: sg(%d) data length is zero\n", i);
 				goto err;
 			}
@@ -1392,7 +1387,7 @@ atc_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 	return vchan_tx_prep(&atchan->vc, &desc->vd, flags);
 
 err_desc_get:
-	dev_err(chan2dev(chan), "not enough descriptors available\n");
+	dev_err(dmaengine_chan_dev(chan), "not enough descriptors available\n");
 err:
 	atdma_desc_free(&desc->vd);
 	return NULL;
@@ -1503,19 +1498,19 @@ atc_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t buf_addr, size_t buf_len,
 	unsigned int		periods = buf_len / period_len;
 	unsigned int		i;
 
-	dev_vdbg(chan2dev(chan), "prep_dma_cyclic: %s buf@%pad - %d (%zu/%zu)\n",
+	dev_vdbg(dmaengine_chan_dev(chan), "prep_dma_cyclic: %s buf@%pad - %d (%zu/%zu)\n",
 			direction == DMA_MEM_TO_DEV ? "TO DEVICE" : "FROM DEVICE",
 			&buf_addr,
 			periods, buf_len, period_len);
 
 	if (unlikely(!atslave || !buf_len || !period_len)) {
-		dev_dbg(chan2dev(chan), "prep_dma_cyclic: length is zero!\n");
+		dev_dbg(dmaengine_chan_dev(chan), "prep_dma_cyclic: length is zero!\n");
 		return NULL;
 	}
 
 	was_cyclic = test_and_set_bit(ATC_IS_CYCLIC, &atchan->status);
 	if (was_cyclic) {
-		dev_dbg(chan2dev(chan), "prep_dma_cyclic: channel in use!\n");
+		dev_dbg(dmaengine_chan_dev(chan), "prep_dma_cyclic: channel in use!\n");
 		return NULL;
 	}
 
@@ -1561,7 +1556,7 @@ static int atc_config(struct dma_chan *chan,
 {
 	struct at_dma_chan	*atchan = to_at_dma_chan(chan);
 
-	dev_vdbg(chan2dev(chan), "%s\n", __func__);
+	dev_vdbg(dmaengine_chan_dev(chan), "%s\n", __func__);
 
 	/* Check if it is chan is configured for slave transfers */
 	if (!chan->private)
@@ -1582,7 +1577,7 @@ static int atc_pause(struct dma_chan *chan)
 	int			chan_id = atchan->vc.chan.chan_id;
 	unsigned long		flags;
 
-	dev_vdbg(chan2dev(chan), "%s\n", __func__);
+	dev_vdbg(dmaengine_chan_dev(chan), "%s\n", __func__);
 
 	spin_lock_irqsave(&atchan->vc.lock, flags);
 
@@ -1601,7 +1596,7 @@ static int atc_resume(struct dma_chan *chan)
 	int			chan_id = atchan->vc.chan.chan_id;
 	unsigned long		flags;
 
-	dev_vdbg(chan2dev(chan), "%s\n", __func__);
+	dev_vdbg(dmaengine_chan_dev(chan), "%s\n", __func__);
 
 	if (!atc_chan_is_paused(atchan))
 		return 0;
@@ -1625,7 +1620,7 @@ static int atc_terminate_all(struct dma_chan *chan)
 
 	LIST_HEAD(list);
 
-	dev_vdbg(chan2dev(chan), "%s\n", __func__);
+	dev_vdbg(dmaengine_chan_dev(chan), "%s\n", __func__);
 
 	/*
 	 * This is only called when something went wrong elsewhere, so
@@ -1691,13 +1686,13 @@ atc_tx_status(struct dma_chan *chan,
 	spin_unlock_irqrestore(&atchan->vc.lock, flags);
 
 	if (unlikely(ret < 0)) {
-		dev_vdbg(chan2dev(chan), "get residual bytes error\n");
+		dev_vdbg(dmaengine_chan_dev(chan), "get residual bytes error\n");
 		return DMA_ERROR;
 	} else {
 		dma_set_residue(txstate, residue);
 	}
 
-	dev_vdbg(chan2dev(chan), "tx_status %d: cookie = %d residue = %u\n",
+	dev_vdbg(dmaengine_chan_dev(chan), "tx_status %d: cookie = %d residue = %u\n",
 		 dma_status, cookie, residue);
 
 	return dma_status;
@@ -1729,11 +1724,11 @@ static int atc_alloc_chan_resources(struct dma_chan *chan)
 	struct at_dma_slave	*atslave;
 	u32			cfg;
 
-	dev_vdbg(chan2dev(chan), "alloc_chan_resources\n");
+	dev_vdbg(dmaengine_chan_dev(chan), "alloc_chan_resources\n");
 
 	/* ASSERT:  channel is idle */
 	if (atc_chan_is_enabled(atchan)) {
-		dev_dbg(chan2dev(chan), "DMA channel not idle ?\n");
+		dev_dbg(dmaengine_chan_dev(chan), "DMA channel not idle ?\n");
 		return -EIO;
 	}
 
@@ -1782,7 +1777,7 @@ static void atc_free_chan_resources(struct dma_chan *chan)
 		chan->private = NULL;
 	}
 
-	dev_vdbg(chan2dev(chan), "free_chan_resources: done\n");
+	dev_vdbg(dmaengine_chan_dev(chan), "free_chan_resources: done\n");
 }
 
 #ifdef CONFIG_OF
@@ -2179,7 +2174,7 @@ static void atc_suspend_cyclic(struct at_dma_chan *atchan)
 	/* Channel should be paused by user
 	 * do it anyway even if it is not done already */
 	if (!atc_chan_is_paused(atchan)) {
-		dev_warn(chan2dev(chan),
+		dev_warn(dmaengine_chan_dev(chan),
 		"cyclic channel not paused, should be done by channel user\n");
 		atc_pause(chan);
 	}
diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index 901971e8bae69..d40a8b40dddc3 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -324,11 +324,6 @@ static inline struct at_xdmac_chan *to_at_xdmac_chan(struct dma_chan *dchan)
 	return container_of(dchan, struct at_xdmac_chan, chan);
 }
 
-static struct device *chan2dev(struct dma_chan *chan)
-{
-	return &chan->dev->device;
-}
-
 static inline struct at_xdmac *to_at_xdmac(struct dma_device *ddev)
 {
 	return container_of(ddev, struct at_xdmac, dma);
@@ -459,7 +454,7 @@ static void at_xdmac_start_xfer(struct at_xdmac_chan *atchan,
 	if (ret < 0)
 		return;
 
-	dev_vdbg(chan2dev(&atchan->chan), "%s: desc 0x%p\n", __func__, first);
+	dev_vdbg(dmaengine_chan_dev(&atchan->chan), "%s: desc 0x%p\n", __func__, first);
 
 	/* Set transfer as active to not try to start it again. */
 	first->active_xfer = true;
@@ -496,7 +491,7 @@ static void at_xdmac_start_xfer(struct at_xdmac_chan *atchan,
 	       | AT_XDMAC_CNDC_NDE;
 	at_xdmac_chan_write(atchan, AT_XDMAC_CNDC, reg);
 
-	dev_vdbg(chan2dev(&atchan->chan),
+	dev_vdbg(dmaengine_chan_dev(&atchan->chan),
 		 "%s: CC=0x%08x CNDA=0x%08x, CNDC=0x%08x, CSA=0x%08x, CDA=0x%08x, CUBC=0x%08x\n",
 		 __func__, at_xdmac_chan_read(atchan, AT_XDMAC_CC),
 		 at_xdmac_chan_read(atchan, AT_XDMAC_CNDA),
@@ -524,12 +519,12 @@ static void at_xdmac_start_xfer(struct at_xdmac_chan *atchan,
 		at_xdmac_chan_write(atchan, AT_XDMAC_CIE,
 				    reg | AT_XDMAC_CIE_LIE);
 	at_xdmac_write(atxdmac, AT_XDMAC_GIE, atchan->mask);
-	dev_vdbg(chan2dev(&atchan->chan),
+	dev_vdbg(dmaengine_chan_dev(&atchan->chan),
 		 "%s: enable channel (0x%08x)\n", __func__, atchan->mask);
 	wmb();
 	at_xdmac_write(atxdmac, AT_XDMAC_GE, atchan->mask);
 
-	dev_vdbg(chan2dev(&atchan->chan),
+	dev_vdbg(dmaengine_chan_dev(&atchan->chan),
 		 "%s: CC=0x%08x CNDA=0x%08x, CNDC=0x%08x, CSA=0x%08x, CDA=0x%08x, CUBC=0x%08x\n",
 		 __func__, at_xdmac_chan_read(atchan, AT_XDMAC_CC),
 		 at_xdmac_chan_read(atchan, AT_XDMAC_CNDA),
@@ -552,7 +547,7 @@ static dma_cookie_t at_xdmac_tx_submit(struct dma_async_tx_descriptor *tx)
 	list_add_tail(&desc->xfer_node, &atchan->xfers_list);
 	spin_unlock_irqrestore(&atchan->lock, irqflags);
 
-	dev_vdbg(chan2dev(tx->chan), "%s: atchan 0x%p, add desc 0x%p to xfers_list\n",
+	dev_vdbg(dmaengine_chan_dev(tx->chan), "%s: atchan 0x%p, add desc 0x%p to xfers_list\n",
 		 __func__, atchan, desc);
 
 	return cookie;
@@ -612,7 +607,7 @@ static void at_xdmac_queue_desc(struct dma_chan *chan,
 	prev->lld.mbr_nda = desc->tx_dma_desc.phys;
 	prev->lld.mbr_ubc |= AT_XDMAC_MBR_UBC_NDE;
 
-	dev_dbg(chan2dev(chan),	"%s: chain lld: prev=0x%p, mbr_nda=%pad\n",
+	dev_dbg(dmaengine_chan_dev(chan),	"%s: chain lld: prev=0x%p, mbr_nda=%pad\n",
 		__func__, prev, &prev->lld.mbr_nda);
 }
 
@@ -624,7 +619,7 @@ static inline void at_xdmac_increment_block_count(struct dma_chan *chan,
 
 	desc->lld.mbr_bc++;
 
-	dev_dbg(chan2dev(chan),
+	dev_dbg(dmaengine_chan_dev(chan),
 		"%s: incrementing the block count of the desc 0x%p\n",
 		__func__, desc);
 }
@@ -680,13 +675,13 @@ static int at_xdmac_compute_chan_conf(struct dma_chan *chan,
 
 		csize = ffs(atchan->sconfig.src_maxburst) - 1;
 		if (csize < 0) {
-			dev_err(chan2dev(chan), "invalid src maxburst value\n");
+			dev_err(dmaengine_chan_dev(chan), "invalid src maxburst value\n");
 			return -EINVAL;
 		}
 		atchan->cfg |= AT_XDMAC_CC_CSIZE(csize);
 		dwidth = ffs(atchan->sconfig.src_addr_width) - 1;
 		if (dwidth < 0) {
-			dev_err(chan2dev(chan), "invalid src addr width value\n");
+			dev_err(dmaengine_chan_dev(chan), "invalid src addr width value\n");
 			return -EINVAL;
 		}
 		atchan->cfg |= AT_XDMAC_CC_DWIDTH(dwidth);
@@ -705,19 +700,19 @@ static int at_xdmac_compute_chan_conf(struct dma_chan *chan,
 
 		csize = ffs(atchan->sconfig.dst_maxburst) - 1;
 		if (csize < 0) {
-			dev_err(chan2dev(chan), "invalid src maxburst value\n");
+			dev_err(dmaengine_chan_dev(chan), "invalid src maxburst value\n");
 			return -EINVAL;
 		}
 		atchan->cfg |= AT_XDMAC_CC_CSIZE(csize);
 		dwidth = ffs(atchan->sconfig.dst_addr_width) - 1;
 		if (dwidth < 0) {
-			dev_err(chan2dev(chan), "invalid dst addr width value\n");
+			dev_err(dmaengine_chan_dev(chan), "invalid dst addr width value\n");
 			return -EINVAL;
 		}
 		atchan->cfg |= AT_XDMAC_CC_DWIDTH(dwidth);
 	}
 
-	dev_dbg(chan2dev(chan),	"%s: cfg=0x%08x\n", __func__, atchan->cfg);
+	dev_dbg(dmaengine_chan_dev(chan),	"%s: cfg=0x%08x\n", __func__, atchan->cfg);
 
 	return 0;
 }
@@ -746,7 +741,7 @@ static int at_xdmac_set_slave_config(struct dma_chan *chan,
 	struct at_xdmac_chan	*atchan = to_at_xdmac_chan(chan);
 
 	if (at_xdmac_check_slave_config(sconfig)) {
-		dev_err(chan2dev(chan), "invalid slave configuration\n");
+		dev_err(dmaengine_chan_dev(chan), "invalid slave configuration\n");
 		return -EINVAL;
 	}
 
@@ -772,11 +767,11 @@ at_xdmac_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 		return NULL;
 
 	if (!is_slave_direction(direction)) {
-		dev_err(chan2dev(chan), "invalid DMA direction\n");
+		dev_err(dmaengine_chan_dev(chan), "invalid DMA direction\n");
 		return NULL;
 	}
 
-	dev_dbg(chan2dev(chan), "%s: sg_len=%d, dir=%s, flags=0x%lx\n",
+	dev_dbg(dmaengine_chan_dev(chan), "%s: sg_len=%d, dir=%s, flags=0x%lx\n",
 		 __func__, sg_len,
 		 direction == DMA_MEM_TO_DEV ? "to device" : "from device",
 		 flags);
@@ -795,15 +790,15 @@ at_xdmac_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 		len = sg_dma_len(sg);
 		mem = sg_dma_address(sg);
 		if (unlikely(!len)) {
-			dev_err(chan2dev(chan), "sg data length is zero\n");
+			dev_err(dmaengine_chan_dev(chan), "sg data length is zero\n");
 			goto spin_unlock;
 		}
-		dev_dbg(chan2dev(chan), "%s: * sg%d len=%u, mem=0x%08x\n",
+		dev_dbg(dmaengine_chan_dev(chan), "%s: * sg%d len=%u, mem=0x%08x\n",
 			 __func__, i, len, mem);
 
 		desc = at_xdmac_get_desc(atchan);
 		if (!desc) {
-			dev_err(chan2dev(chan), "can't get descriptor\n");
+			dev_err(dmaengine_chan_dev(chan), "can't get descriptor\n");
 			if (first)
 				list_splice_tail_init(&first->descs_list,
 						      &atchan->free_descs_list);
@@ -828,7 +823,7 @@ at_xdmac_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 			| (len >> fixed_dwidth);				/* microblock length */
 		desc->lld.mbr_cfg = (atchan->cfg & ~AT_XDMAC_CC_DWIDTH_MASK) |
 				    AT_XDMAC_CC_DWIDTH(fixed_dwidth);
-		dev_dbg(chan2dev(chan),
+		dev_dbg(dmaengine_chan_dev(chan),
 			 "%s: lld: mbr_sa=%pad, mbr_da=%pad, mbr_ubc=0x%08x\n",
 			 __func__, &desc->lld.mbr_sa, &desc->lld.mbr_da, desc->lld.mbr_ubc);
 
@@ -840,7 +835,7 @@ at_xdmac_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 		if (!first)
 			first = desc;
 
-		dev_dbg(chan2dev(chan), "%s: add desc 0x%p to descs_list 0x%p\n",
+		dev_dbg(dmaengine_chan_dev(chan), "%s: add desc 0x%p to descs_list 0x%p\n",
 			 __func__, desc, first);
 		list_add_tail(&desc->desc_node, &first->descs_list);
 		xfer_size += len;
@@ -869,17 +864,17 @@ at_xdmac_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t buf_addr,
 	int			i;
 	unsigned long		irqflags;
 
-	dev_dbg(chan2dev(chan), "%s: buf_addr=%pad, buf_len=%zd, period_len=%zd, dir=%s, flags=0x%lx\n",
+	dev_dbg(dmaengine_chan_dev(chan), "%s: buf_addr=%pad, buf_len=%zd, period_len=%zd, dir=%s, flags=0x%lx\n",
 		__func__, &buf_addr, buf_len, period_len,
 		direction == DMA_MEM_TO_DEV ? "mem2per" : "per2mem", flags);
 
 	if (!is_slave_direction(direction)) {
-		dev_err(chan2dev(chan), "invalid DMA direction\n");
+		dev_err(dmaengine_chan_dev(chan), "invalid DMA direction\n");
 		return NULL;
 	}
 
 	if (test_and_set_bit(AT_XDMAC_CHAN_IS_CYCLIC, &atchan->status)) {
-		dev_err(chan2dev(chan), "channel currently used\n");
+		dev_err(dmaengine_chan_dev(chan), "channel currently used\n");
 		return NULL;
 	}
 
@@ -892,7 +887,7 @@ at_xdmac_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t buf_addr,
 		spin_lock_irqsave(&atchan->lock, irqflags);
 		desc = at_xdmac_get_desc(atchan);
 		if (!desc) {
-			dev_err(chan2dev(chan), "can't get descriptor\n");
+			dev_err(dmaengine_chan_dev(chan), "can't get descriptor\n");
 			if (first)
 				list_splice_tail_init(&first->descs_list,
 						      &atchan->free_descs_list);
@@ -900,7 +895,7 @@ at_xdmac_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t buf_addr,
 			return NULL;
 		}
 		spin_unlock_irqrestore(&atchan->lock, irqflags);
-		dev_dbg(chan2dev(chan),
+		dev_dbg(dmaengine_chan_dev(chan),
 			"%s: desc=0x%p, tx_dma_desc.phys=%pad\n",
 			__func__, desc, &desc->tx_dma_desc.phys);
 
@@ -917,7 +912,7 @@ at_xdmac_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t buf_addr,
 			| AT_XDMAC_MBR_UBC_NSEN
 			| period_len >> at_xdmac_get_dwidth(desc->lld.mbr_cfg);
 
-		dev_dbg(chan2dev(chan),
+		dev_dbg(dmaengine_chan_dev(chan),
 			 "%s: lld: mbr_sa=%pad, mbr_da=%pad, mbr_ubc=0x%08x\n",
 			 __func__, &desc->lld.mbr_sa, &desc->lld.mbr_da, desc->lld.mbr_ubc);
 
@@ -929,7 +924,7 @@ at_xdmac_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t buf_addr,
 		if (!first)
 			first = desc;
 
-		dev_dbg(chan2dev(chan), "%s: add desc 0x%p to descs_list 0x%p\n",
+		dev_dbg(dmaengine_chan_dev(chan), "%s: add desc 0x%p to descs_list 0x%p\n",
 			 __func__, desc, first);
 		list_add_tail(&desc->desc_node, &first->descs_list);
 	}
@@ -956,16 +951,16 @@ static inline u32 at_xdmac_align_width(struct dma_chan *chan, dma_addr_t addr)
 	 */
 	if (!(addr & 7)) {
 		width = AT_XDMAC_CC_DWIDTH_DWORD;
-		dev_dbg(chan2dev(chan), "%s: dwidth: double word\n", __func__);
+		dev_dbg(dmaengine_chan_dev(chan), "%s: dwidth: double word\n", __func__);
 	} else if (!(addr & 3)) {
 		width = AT_XDMAC_CC_DWIDTH_WORD;
-		dev_dbg(chan2dev(chan), "%s: dwidth: word\n", __func__);
+		dev_dbg(dmaengine_chan_dev(chan), "%s: dwidth: word\n", __func__);
 	} else if (!(addr & 1)) {
 		width = AT_XDMAC_CC_DWIDTH_HALFWORD;
-		dev_dbg(chan2dev(chan), "%s: dwidth: half word\n", __func__);
+		dev_dbg(dmaengine_chan_dev(chan), "%s: dwidth: half word\n", __func__);
 	} else {
 		width = AT_XDMAC_CC_DWIDTH_BYTE;
-		dev_dbg(chan2dev(chan), "%s: dwidth: byte\n", __func__);
+		dev_dbg(dmaengine_chan_dev(chan), "%s: dwidth: byte\n", __func__);
 	}
 
 	return width;
@@ -1005,7 +1000,7 @@ at_xdmac_interleaved_queue_desc(struct dma_chan *chan,
 
 	dwidth = at_xdmac_align_width(chan, src | dst | chunk->size);
 	if (chunk->size >= (AT_XDMAC_MBR_UBC_UBLEN_MAX << dwidth)) {
-		dev_dbg(chan2dev(chan),
+		dev_dbg(dmaengine_chan_dev(chan),
 			"%s: chunk too big (%zu, max size %lu)...\n",
 			__func__, chunk->size,
 			AT_XDMAC_MBR_UBC_UBLEN_MAX << dwidth);
@@ -1013,7 +1008,7 @@ at_xdmac_interleaved_queue_desc(struct dma_chan *chan,
 	}
 
 	if (prev)
-		dev_dbg(chan2dev(chan),
+		dev_dbg(dmaengine_chan_dev(chan),
 			"Adding items at the end of desc 0x%p\n", prev);
 
 	if (xt->src_inc) {
@@ -1034,7 +1029,7 @@ at_xdmac_interleaved_queue_desc(struct dma_chan *chan,
 	desc = at_xdmac_get_desc(atchan);
 	spin_unlock_irqrestore(&atchan->lock, flags);
 	if (!desc) {
-		dev_err(chan2dev(chan), "can't get descriptor\n");
+		dev_err(dmaengine_chan_dev(chan), "can't get descriptor\n");
 		return NULL;
 	}
 
@@ -1053,7 +1048,7 @@ at_xdmac_interleaved_queue_desc(struct dma_chan *chan,
 		| ublen;
 	desc->lld.mbr_cfg = chan_cc;
 
-	dev_dbg(chan2dev(chan),
+	dev_dbg(dmaengine_chan_dev(chan),
 		"%s: lld: mbr_sa=%pad, mbr_da=%pad, mbr_ubc=0x%08x, mbr_cfg=0x%08x\n",
 		__func__, &desc->lld.mbr_sa, &desc->lld.mbr_da,
 		desc->lld.mbr_ubc, desc->lld.mbr_cfg);
@@ -1087,7 +1082,7 @@ at_xdmac_prep_interleaved(struct dma_chan *chan,
 	if ((xt->numf > 1) && (xt->frame_size > 1))
 		return NULL;
 
-	dev_dbg(chan2dev(chan), "%s: src=%pad, dest=%pad, numf=%zu, frame_size=%zu, flags=0x%lx\n",
+	dev_dbg(dmaengine_chan_dev(chan), "%s: src=%pad, dest=%pad, numf=%zu, frame_size=%zu, flags=0x%lx\n",
 		__func__, &xt->src_start, &xt->dst_start,	xt->numf,
 		xt->frame_size, flags);
 
@@ -1106,7 +1101,7 @@ at_xdmac_prep_interleaved(struct dma_chan *chan,
 		for (i = 0; i < xt->numf - 1; i++)
 			at_xdmac_increment_block_count(chan, first);
 
-		dev_dbg(chan2dev(chan), "%s: add desc 0x%p to descs_list 0x%p\n",
+		dev_dbg(dmaengine_chan_dev(chan), "%s: add desc 0x%p to descs_list 0x%p\n",
 			__func__, first, first);
 		list_add_tail(&first->desc_node, &first->descs_list);
 	} else {
@@ -1122,7 +1117,7 @@ at_xdmac_prep_interleaved(struct dma_chan *chan,
 			src_skip = chunk->size + src_icg;
 			dst_skip = chunk->size + dst_icg;
 
-			dev_dbg(chan2dev(chan),
+			dev_dbg(dmaengine_chan_dev(chan),
 				"%s: chunk size=%zu, src icg=%zu, dst icg=%zu\n",
 				__func__, chunk->size, src_icg, dst_icg);
 
@@ -1140,7 +1135,7 @@ at_xdmac_prep_interleaved(struct dma_chan *chan,
 			if (!first)
 				first = desc;
 
-			dev_dbg(chan2dev(chan), "%s: add desc 0x%p to descs_list 0x%p\n",
+			dev_dbg(dmaengine_chan_dev(chan), "%s: add desc 0x%p to descs_list 0x%p\n",
 				__func__, desc, first);
 			list_add_tail(&desc->desc_node, &first->descs_list);
 
@@ -1193,7 +1188,7 @@ at_xdmac_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
 					| AT_XDMAC_CC_TYPE_MEM_TRAN;
 	unsigned long		irqflags;
 
-	dev_dbg(chan2dev(chan), "%s: src=%pad, dest=%pad, len=%zd, flags=0x%lx\n",
+	dev_dbg(dmaengine_chan_dev(chan), "%s: src=%pad, dest=%pad, len=%zd, flags=0x%lx\n",
 		__func__, &src, &dest, len, flags);
 
 	if (unlikely(!len))
@@ -1205,13 +1200,13 @@ at_xdmac_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
 	while (remaining_size) {
 		struct at_xdmac_desc	*desc = NULL;
 
-		dev_dbg(chan2dev(chan), "%s: remaining_size=%zu\n", __func__, remaining_size);
+		dev_dbg(dmaengine_chan_dev(chan), "%s: remaining_size=%zu\n", __func__, remaining_size);
 
 		spin_lock_irqsave(&atchan->lock, irqflags);
 		desc = at_xdmac_get_desc(atchan);
 		spin_unlock_irqrestore(&atchan->lock, irqflags);
 		if (!desc) {
-			dev_err(chan2dev(chan), "can't get descriptor\n");
+			dev_err(dmaengine_chan_dev(chan), "can't get descriptor\n");
 			if (first)
 				list_splice_tail_init(&first->descs_list,
 						      &atchan->free_descs_list);
@@ -1227,7 +1222,7 @@ at_xdmac_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
 		else
 			xfer_size = remaining_size;
 
-		dev_dbg(chan2dev(chan), "%s: xfer_size=%zu\n", __func__, xfer_size);
+		dev_dbg(dmaengine_chan_dev(chan), "%s: xfer_size=%zu\n", __func__, xfer_size);
 
 		/* Check remaining length and change data width if needed. */
 		dwidth = at_xdmac_align_width(chan,
@@ -1246,7 +1241,7 @@ at_xdmac_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
 			| ublen;
 		desc->lld.mbr_cfg = chan_cc;
 
-		dev_dbg(chan2dev(chan),
+		dev_dbg(dmaengine_chan_dev(chan),
 			 "%s: lld: mbr_sa=%pad, mbr_da=%pad, mbr_ubc=0x%08x, mbr_cfg=0x%08x\n",
 			 __func__, &desc->lld.mbr_sa, &desc->lld.mbr_da, desc->lld.mbr_ubc, desc->lld.mbr_cfg);
 
@@ -1258,7 +1253,7 @@ at_xdmac_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
 		if (!first)
 			first = desc;
 
-		dev_dbg(chan2dev(chan), "%s: add desc 0x%p to descs_list 0x%p\n",
+		dev_dbg(dmaengine_chan_dev(chan), "%s: add desc 0x%p to descs_list 0x%p\n",
 			 __func__, desc, first);
 		list_add_tail(&desc->desc_node, &first->descs_list);
 	}
@@ -1306,7 +1301,7 @@ static struct at_xdmac_desc *at_xdmac_memset_create_desc(struct dma_chan *chan,
 	dwidth = at_xdmac_align_width(chan, dst_addr);
 
 	if (len >= (AT_XDMAC_MBR_UBC_UBLEN_MAX << dwidth)) {
-		dev_err(chan2dev(chan),
+		dev_err(dmaengine_chan_dev(chan),
 			"%s: Transfer too large, aborting...\n",
 			__func__);
 		return NULL;
@@ -1316,7 +1311,7 @@ static struct at_xdmac_desc *at_xdmac_memset_create_desc(struct dma_chan *chan,
 	desc = at_xdmac_get_desc(atchan);
 	spin_unlock_irqrestore(&atchan->lock, flags);
 	if (!desc) {
-		dev_err(chan2dev(chan), "can't get descriptor\n");
+		dev_err(dmaengine_chan_dev(chan), "can't get descriptor\n");
 		return NULL;
 	}
 
@@ -1338,7 +1333,7 @@ static struct at_xdmac_desc *at_xdmac_memset_create_desc(struct dma_chan *chan,
 		| ublen;
 	desc->lld.mbr_cfg = chan_cc;
 
-	dev_dbg(chan2dev(chan),
+	dev_dbg(dmaengine_chan_dev(chan),
 		"%s: lld: mbr_da=%pad, mbr_ds=0x%08x, mbr_ubc=0x%08x, mbr_cfg=0x%08x\n",
 		__func__, &desc->lld.mbr_da, desc->lld.mbr_ds, desc->lld.mbr_ubc,
 		desc->lld.mbr_cfg);
@@ -1353,7 +1348,7 @@ at_xdmac_prep_dma_memset(struct dma_chan *chan, dma_addr_t dest, int value,
 	struct at_xdmac_chan	*atchan = to_at_xdmac_chan(chan);
 	struct at_xdmac_desc	*desc;
 
-	dev_dbg(chan2dev(chan), "%s: dest=%pad, len=%zu, pattern=0x%x, flags=0x%lx\n",
+	dev_dbg(dmaengine_chan_dev(chan), "%s: dest=%pad, len=%zu, pattern=0x%x, flags=0x%lx\n",
 		__func__, &dest, len, value, flags);
 
 	if (unlikely(!len))
@@ -1386,12 +1381,12 @@ at_xdmac_prep_dma_memset_sg(struct dma_chan *chan, struct scatterlist *sgl,
 	if (!sgl)
 		return NULL;
 
-	dev_dbg(chan2dev(chan), "%s: sg_len=%d, value=0x%x, flags=0x%lx\n",
+	dev_dbg(dmaengine_chan_dev(chan), "%s: sg_len=%d, value=0x%x, flags=0x%lx\n",
 		__func__, sg_len, value, flags);
 
 	/* Prepare descriptors. */
 	for_each_sg(sgl, sg, sg_len, i) {
-		dev_dbg(chan2dev(chan), "%s: dest=%pad, len=%d, pattern=0x%x, flags=0x%lx\n",
+		dev_dbg(dmaengine_chan_dev(chan), "%s: dest=%pad, len=%d, pattern=0x%x, flags=0x%lx\n",
 			__func__, &sg_dma_address(sg), sg_dma_len(sg),
 			value, flags);
 		desc = at_xdmac_memset_create_desc(chan, atchan,
@@ -1433,7 +1428,7 @@ at_xdmac_prep_dma_memset_sg(struct dma_chan *chan, struct scatterlist *sgl,
 		if (ppdesc && pdesc) {
 			if ((stride == pstride) &&
 			    (sg_dma_len(ppsg) == sg_dma_len(psg))) {
-				dev_dbg(chan2dev(chan),
+				dev_dbg(dmaengine_chan_dev(chan),
 					"%s: desc 0x%p can be merged with desc 0x%p\n",
 					__func__, pdesc, ppdesc);
 
@@ -1481,7 +1476,7 @@ at_xdmac_prep_dma_memset_sg(struct dma_chan *chan, struct scatterlist *sgl,
 				 */
 				list_add_tail(&desc->desc_node,
 					      &first->descs_list);
-				dev_dbg(chan2dev(chan),
+				dev_dbg(dmaengine_chan_dev(chan),
 					"%s: add desc 0x%p to descs_list 0x%p\n",
 					__func__, desc, first);
 			}
@@ -1496,7 +1491,7 @@ at_xdmac_prep_dma_memset_sg(struct dma_chan *chan, struct scatterlist *sgl,
 		 */
 		if ((i == (sg_len - 1)) &&
 		    sg_dma_len(psg) == sg_dma_len(sg)) {
-			dev_dbg(chan2dev(chan),
+			dev_dbg(dmaengine_chan_dev(chan),
 				"%s: desc 0x%p can be merged with desc 0x%p\n",
 				__func__, desc, pdesc);
 
@@ -1667,7 +1662,7 @@ at_xdmac_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
 
 	dma_set_residue(txstate, residue);
 
-	dev_dbg(chan2dev(chan),
+	dev_dbg(dmaengine_chan_dev(chan),
 		 "%s: desc=0x%p, tx_dma_desc.phys=%pad, tx_status=%d, cookie=%d, residue=%d\n",
 		 __func__, desc, &desc->tx_dma_desc.phys, ret, cookie, residue);
 
@@ -1690,7 +1685,7 @@ static void at_xdmac_advance_work(struct at_xdmac_chan *atchan)
 
 	desc = list_first_entry(&atchan->xfers_list, struct at_xdmac_desc,
 				xfer_node);
-	dev_vdbg(chan2dev(&atchan->chan), "%s: desc 0x%p\n", __func__, desc);
+	dev_vdbg(dmaengine_chan_dev(&atchan->chan), "%s: desc 0x%p\n", __func__, desc);
 	if (!desc->active_xfer)
 		at_xdmac_start_xfer(atchan, desc);
 }
@@ -1701,7 +1696,7 @@ static void at_xdmac_handle_cyclic(struct at_xdmac_chan *atchan)
 	struct dma_async_tx_descriptor	*txd;
 
 	spin_lock_irq(&atchan->lock);
-	dev_dbg(chan2dev(&atchan->chan), "%s: status=0x%08x\n",
+	dev_dbg(dmaengine_chan_dev(&atchan->chan), "%s: status=0x%08x\n",
 		__func__, atchan->irq_status);
 	if (list_empty(&atchan->xfers_list)) {
 		spin_unlock_irq(&atchan->lock);
@@ -1733,11 +1728,11 @@ static void at_xdmac_handle_error(struct at_xdmac_chan *atchan)
 	 * descriptors queued (if any).
 	 */
 	if (atchan->irq_status & AT_XDMAC_CIS_RBEIS)
-		dev_err(chan2dev(&atchan->chan), "read bus error!!!");
+		dev_err(dmaengine_chan_dev(&atchan->chan), "read bus error!!!");
 	if (atchan->irq_status & AT_XDMAC_CIS_WBEIS)
-		dev_err(chan2dev(&atchan->chan), "write bus error!!!");
+		dev_err(dmaengine_chan_dev(&atchan->chan), "write bus error!!!");
 	if (atchan->irq_status & AT_XDMAC_CIS_ROIS)
-		dev_err(chan2dev(&atchan->chan), "request overflow error!!!");
+		dev_err(dmaengine_chan_dev(&atchan->chan), "request overflow error!!!");
 
 	/* Channel must be disabled first as it's not done automatically */
 	at_xdmac_write(atxdmac, AT_XDMAC_GD, atchan->mask);
@@ -1749,7 +1744,7 @@ static void at_xdmac_handle_error(struct at_xdmac_chan *atchan)
 				    xfer_node);
 
 	/* Print bad descriptor's details if needed */
-	dev_dbg(chan2dev(&atchan->chan),
+	dev_dbg(dmaengine_chan_dev(&atchan->chan),
 		"%s: lld: mbr_sa=%pad, mbr_da=%pad, mbr_ubc=0x%08x\n",
 		__func__, &bad_desc->lld.mbr_sa, &bad_desc->lld.mbr_da,
 		bad_desc->lld.mbr_ubc);
@@ -1775,7 +1770,7 @@ static void at_xdmac_tasklet(struct tasklet_struct *t)
 
 	spin_lock_irq(&atchan->lock);
 
-	dev_dbg(chan2dev(&atchan->chan), "%s: status=0x%08x\n",
+	dev_dbg(dmaengine_chan_dev(&atchan->chan), "%s: status=0x%08x\n",
 		__func__, atchan->irq_status);
 
 	if (!(atchan->irq_status & AT_XDMAC_CIS_LIS) &&
@@ -1789,9 +1784,9 @@ static void at_xdmac_tasklet(struct tasklet_struct *t)
 
 	desc = list_first_entry(&atchan->xfers_list, struct at_xdmac_desc,
 				xfer_node);
-	dev_vdbg(chan2dev(&atchan->chan), "%s: desc 0x%p\n", __func__, desc);
+	dev_vdbg(dmaengine_chan_dev(&atchan->chan), "%s: desc 0x%p\n", __func__, desc);
 	if (!desc->active_xfer) {
-		dev_err(chan2dev(&atchan->chan), "Xfer not active: exiting");
+		dev_err(dmaengine_chan_dev(&atchan->chan), "Xfer not active: exiting");
 		spin_unlock_irq(&atchan->lock);
 		return;
 	}
@@ -1852,7 +1847,7 @@ static irqreturn_t at_xdmac_interrupt(int irq, void *dev_id)
 			dev_vdbg(atxdmac->dma.dev,
 				 "%s: chan%d: imr=0x%x, status=0x%x\n",
 				 __func__, i, chan_imr, chan_status);
-			dev_vdbg(chan2dev(&atchan->chan),
+			dev_vdbg(dmaengine_chan_dev(&atchan->chan),
 				 "%s: CC=0x%08x CNDA=0x%08x, CNDC=0x%08x, CSA=0x%08x, CDA=0x%08x, CUBC=0x%08x\n",
 				 __func__,
 				 at_xdmac_chan_read(atchan, AT_XDMAC_CC),
@@ -1879,7 +1874,7 @@ static void at_xdmac_issue_pending(struct dma_chan *chan)
 	struct at_xdmac_chan *atchan = to_at_xdmac_chan(chan);
 	unsigned long flags;
 
-	dev_dbg(chan2dev(&atchan->chan), "%s\n", __func__);
+	dev_dbg(dmaengine_chan_dev(&atchan->chan), "%s\n", __func__);
 
 	spin_lock_irqsave(&atchan->lock, flags);
 	at_xdmac_advance_work(atchan);
@@ -1895,7 +1890,7 @@ static int at_xdmac_device_config(struct dma_chan *chan,
 	int ret;
 	unsigned long		flags;
 
-	dev_dbg(chan2dev(chan), "%s\n", __func__);
+	dev_dbg(dmaengine_chan_dev(chan), "%s\n", __func__);
 
 	spin_lock_irqsave(&atchan->lock, flags);
 	ret = at_xdmac_set_slave_config(chan, config);
@@ -1931,7 +1926,7 @@ static int at_xdmac_device_pause(struct dma_chan *chan)
 	unsigned long		flags;
 	int			ret;
 
-	dev_dbg(chan2dev(chan), "%s\n", __func__);
+	dev_dbg(dmaengine_chan_dev(chan), "%s\n", __func__);
 
 	if (test_and_set_bit(AT_XDMAC_CHAN_IS_PAUSED, &atchan->status))
 		return 0;
@@ -1971,7 +1966,7 @@ static int at_xdmac_device_resume(struct dma_chan *chan)
 	unsigned long		flags;
 	int			ret;
 
-	dev_dbg(chan2dev(chan), "%s\n", __func__);
+	dev_dbg(dmaengine_chan_dev(chan), "%s\n", __func__);
 
 	ret = pm_runtime_resume_and_get(atxdmac->dev);
 	if (ret < 0)
@@ -2004,7 +1999,7 @@ static int at_xdmac_device_terminate_all(struct dma_chan *chan)
 	unsigned long		flags;
 	int			ret;
 
-	dev_dbg(chan2dev(chan), "%s\n", __func__);
+	dev_dbg(dmaengine_chan_dev(chan), "%s\n", __func__);
 
 	ret = pm_runtime_resume_and_get(atxdmac->dev);
 	if (ret < 0)
@@ -2045,13 +2040,13 @@ static int at_xdmac_alloc_chan_resources(struct dma_chan *chan)
 	int			i;
 
 	if (at_xdmac_chan_is_enabled(atchan)) {
-		dev_err(chan2dev(chan),
+		dev_err(dmaengine_chan_dev(chan),
 			"can't allocate channel resources (channel enabled)\n");
 		return -EIO;
 	}
 
 	if (!list_empty(&atchan->free_descs_list)) {
-		dev_err(chan2dev(chan),
+		dev_err(dmaengine_chan_dev(chan),
 			"can't allocate channel resources (channel not free from a previous use)\n");
 		return -EIO;
 	}
@@ -2060,11 +2055,11 @@ static int at_xdmac_alloc_chan_resources(struct dma_chan *chan)
 		desc = at_xdmac_alloc_desc(chan, GFP_KERNEL);
 		if (!desc) {
 			if (i == 0) {
-				dev_warn(chan2dev(chan),
+				dev_warn(dmaengine_chan_dev(chan),
 					 "can't allocate any descriptors\n");
 				return -EIO;
 			}
-			dev_warn(chan2dev(chan),
+			dev_warn(dmaengine_chan_dev(chan),
 				"only %d descriptors have been allocated\n", i);
 			break;
 		}
@@ -2073,7 +2068,7 @@ static int at_xdmac_alloc_chan_resources(struct dma_chan *chan)
 
 	dma_cookie_init(chan);
 
-	dev_dbg(chan2dev(chan), "%s: allocated %d descriptors\n", __func__, i);
+	dev_dbg(dmaengine_chan_dev(chan), "%s: allocated %d descriptors\n", __func__, i);
 
 	return i;
 }
@@ -2085,7 +2080,7 @@ static void at_xdmac_free_chan_resources(struct dma_chan *chan)
 	struct at_xdmac_desc	*desc, *_desc;
 
 	list_for_each_entry_safe(desc, _desc, &atchan->free_descs_list, desc_node) {
-		dev_dbg(chan2dev(chan), "%s: freeing descriptor %p\n", __func__, desc);
+		dev_dbg(dmaengine_chan_dev(chan), "%s: freeing descriptor %p\n", __func__, desc);
 		list_del(&desc->desc_node);
 		dma_pool_free(atxdmac->at_xdmac_desc_pool, desc, desc->tx_dma_desc.phys);
 	}
@@ -2148,7 +2143,7 @@ static int __maybe_unused atmel_xdmac_suspend(struct device *dev)
 		atchan->save_cc = at_xdmac_chan_read(atchan, AT_XDMAC_CC);
 		if (at_xdmac_chan_is_cyclic(atchan)) {
 			if (!at_xdmac_chan_is_paused(atchan)) {
-				dev_warn(chan2dev(chan), "%s: channel %d not paused\n",
+				dev_warn(dmaengine_chan_dev(chan), "%s: channel %d not paused\n",
 					 __func__, chan->chan_id);
 				at_xdmac_device_pause_internal(atchan);
 				at_xdmac_runtime_suspend_descriptors(atchan);
diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
index 194649811d02b..ac2094e65ecf3 100644
--- a/drivers/dma/dma-jz4780.c
+++ b/drivers/dma/dma-jz4780.c
@@ -687,12 +687,12 @@ static bool jz4780_dma_chan_irq(struct jz4780_dma_dev *jzdma,
 	jz4780_dma_chn_writel(jzdma, jzchan->id, JZ_DMA_REG_DCS, 0);
 
 	if (dcs & JZ_DMA_DCS_AR) {
-		dev_warn(&jzchan->vchan.chan.dev->device,
+		dev_warn(vchan_chan_dev(&jzchan->vchan),
 			 "address error (DCS=0x%x)\n", dcs);
 	}
 
 	if (dcs & JZ_DMA_DCS_HLT) {
-		dev_warn(&jzchan->vchan.chan.dev->device,
+		dev_warn(vchan_chan_dev(&jzchan->vchan),
 			 "channel halt (DCS=0x%x)\n", dcs);
 	}
 
@@ -721,7 +721,7 @@ static bool jz4780_dma_chan_irq(struct jz4780_dma_dev *jzdma,
 			}
 		}
 	} else {
-		dev_err(&jzchan->vchan.chan.dev->device,
+		dev_err(vchan_chan_dev(&jzchan->vchan),
 			"channel IRQ with no active transfer\n");
 	}
 
@@ -765,7 +765,7 @@ static int jz4780_dma_alloc_chan_resources(struct dma_chan *chan)
 					    JZ_DMA_DESC_BLOCK_SIZE,
 					    PAGE_SIZE, 0);
 	if (!jzchan->desc_pool) {
-		dev_err(&chan->dev->device,
+		dev_err(dmaengine_chan_dev(chan),
 			"failed to allocate descriptor pool\n");
 		return -ENOMEM;
 	}
diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 6ffd8bd82154a..a7ac2729e4d9d 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -868,10 +868,10 @@ struct dma_chan *dma_request_chan(struct device *dev, const char *name)
 		return chan;
 	chan->slave = dev;
 
-	if (sysfs_create_link(&chan->dev->device.kobj, &dev->kobj,
+	if (sysfs_create_link(&dmaengine_chan_dev(chan)->kobj, &dev->kobj,
 			      DMA_SLAVE_NAME))
 		dev_warn(dev, "Cannot create DMA %s symlink\n", DMA_SLAVE_NAME);
-	if (sysfs_create_link(&dev->kobj, &chan->dev->device.kobj, chan->name))
+	if (sysfs_create_link(&dev->kobj, &dmaengine_chan_dev(chan)->kobj, chan->name))
 		dev_warn(dev, "Cannot create DMA %s symlink\n", chan->name);
 
 	return chan;
@@ -917,7 +917,7 @@ void dma_release_channel(struct dma_chan *chan)
 	dma_chan_put(chan);
 
 	if (chan->slave) {
-		sysfs_remove_link(&chan->dev->device.kobj, DMA_SLAVE_NAME);
+		sysfs_remove_link(&dmaengine_chan_dev(chan)->kobj, DMA_SLAVE_NAME);
 		sysfs_remove_link(&chan->slave->kobj, chan->name);
 		kfree(chan->name);
 		chan->name = NULL;
@@ -1101,17 +1101,17 @@ static int __dma_async_device_channel_register(struct dma_device *device,
 		goto err_free_dev;
 	}
 
-	chan->dev->device.class = &dma_devclass;
-	chan->dev->device.parent = device->dev;
+	dmaengine_chan_dev(chan)->class = &dma_devclass;
+	dmaengine_chan_dev(chan)->parent = device->dev;
 	chan->dev->chan = chan;
 	chan->dev->dev_id = device->dev_id;
 	spin_lock_init(&chan->lock);
 
 	if (!name)
-		dev_set_name(&chan->dev->device, "dma%dchan%d", device->dev_id, chan->chan_id);
+		dev_set_name(dmaengine_chan_dev(chan), "dma%dchan%d", device->dev_id, chan->chan_id);
 	else
-		dev_set_name(&chan->dev->device, "%s", name);
-	rc = device_register(&chan->dev->device);
+		dev_set_name(dmaengine_chan_dev(chan), "%s", name);
+	rc = device_register(dmaengine_chan_dev(chan));
 	if (rc)
 		goto err_out_ida;
 	chan->client_count = 0;
@@ -1158,7 +1158,7 @@ static void __dma_async_device_channel_unregister(struct dma_device *device,
 	chan->dev->chan = NULL;
 	mutex_unlock(&dma_list_mutex);
 	ida_free(&device->chan_ida, chan->chan_id);
-	device_unregister(&chan->dev->device);
+	device_unregister(dmaengine_chan_dev(chan));
 	free_percpu(chan->local);
 }
 
@@ -1292,7 +1292,7 @@ int dma_async_device_register(struct dma_device *device)
 		mutex_lock(&dma_list_mutex);
 		chan->dev->chan = NULL;
 		mutex_unlock(&dma_list_mutex);
-		device_unregister(&chan->dev->device);
+		device_unregister(dmaengine_chan_dev(chan));
 		free_percpu(chan->local);
 	}
 	return rc;
diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index a36b066c3c33c..42ef5c11032ee 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -316,7 +316,7 @@ static struct axi_dma_lli *axi_desc_get(struct axi_dma_chan *chan,
 
 	lli = dma_pool_zalloc(chan->desc_pool, GFP_NOWAIT, &phys);
 	if (unlikely(!lli)) {
-		dev_err(chan2dev(chan), "%s: not enough descriptors available\n",
+		dev_err(vchan_chan_dev(&chan->vc), "%s: not enough descriptors available\n",
 			axi_chan_name(chan));
 		return NULL;
 	}
@@ -342,7 +342,7 @@ static void axi_desc_put(struct axi_dma_desc *desc)
 	kfree(desc->hw_desc);
 	kfree(desc);
 	atomic_sub(descs_put, &chan->descs_allocated);
-	dev_vdbg(chan2dev(chan), "%s: %d descs put, %d still allocated\n",
+	dev_vdbg(vchan_chan_dev(&chan->vc), "%s: %d descs put, %d still allocated\n",
 		 axi_chan_name(chan), descs_put,
 		 atomic_read(&chan->descs_allocated));
 }
@@ -431,7 +431,7 @@ static void axi_chan_block_xfer_start(struct axi_dma_chan *chan,
 	u8 lms = 0; /* Select AXI0 master for LLI fetching */
 
 	if (unlikely(axi_chan_is_hw_enable(chan))) {
-		dev_err(chan2dev(chan), "%s is non-idle!\n",
+		dev_err(vchan_chan_dev(&chan->vc), "%s is non-idle!\n",
 			axi_chan_name(chan));
 
 		return;
@@ -490,7 +490,7 @@ static void axi_chan_start_first_queued(struct axi_dma_chan *chan)
 		return;
 
 	desc = vd_to_axi_desc(vd);
-	dev_vdbg(chan2dev(chan), "%s: started %u\n", axi_chan_name(chan),
+	dev_vdbg(vchan_chan_dev(&chan->vc), "%s: started %u\n", axi_chan_name(chan),
 		 vd->tx.cookie);
 	axi_chan_block_xfer_start(chan, desc);
 }
@@ -524,7 +524,7 @@ static int dma_chan_alloc_chan_resources(struct dma_chan *dchan)
 
 	/* ASSERT: channel is idle */
 	if (axi_chan_is_hw_enable(chan)) {
-		dev_err(chan2dev(chan), "%s is non-idle!\n",
+		dev_err(vchan_chan_dev(&chan->vc), "%s is non-idle!\n",
 			axi_chan_name(chan));
 		pm_runtime_put(chan->chip->dev);
 		return -EBUSY;
@@ -535,11 +535,11 @@ static int dma_chan_alloc_chan_resources(struct dma_chan *dchan)
 					  sizeof(struct axi_dma_lli),
 					  64, 0);
 	if (!chan->desc_pool) {
-		dev_err(chan2dev(chan), "No memory for descriptors\n");
+		dev_err(vchan_chan_dev(&chan->vc), "No memory for descriptors\n");
 		pm_runtime_put(chan->chip->dev);
 		return -ENOMEM;
 	}
-	dev_vdbg(dchan2dev(dchan), "%s: allocating\n", axi_chan_name(chan));
+	dev_vdbg(dmaengine_chan_dev(dchan), "%s: allocating\n", axi_chan_name(chan));
 
 	return 0;
 }
@@ -550,7 +550,7 @@ static void dma_chan_free_chan_resources(struct dma_chan *dchan)
 
 	/* ASSERT: channel is idle */
 	if (axi_chan_is_hw_enable(chan))
-		dev_err(dchan2dev(dchan), "%s is non-idle!\n",
+		dev_err(dmaengine_chan_dev(dchan), "%s is non-idle!\n",
 			axi_chan_name(chan));
 
 	axi_chan_disable(chan);
@@ -560,7 +560,7 @@ static void dma_chan_free_chan_resources(struct dma_chan *dchan)
 
 	dma_pool_destroy(chan->desc_pool);
 	chan->desc_pool = NULL;
-	dev_vdbg(dchan2dev(dchan),
+	dev_vdbg(dmaengine_chan_dev(dchan),
 		 "%s: free resources, descriptor still allocated: %u\n",
 		 axi_chan_name(chan), atomic_read(&chan->descs_allocated));
 
@@ -929,7 +929,7 @@ dma_chan_prep_dma_memcpy(struct dma_chan *dchan, dma_addr_t dst_adr,
 	u64 llp = 0;
 	u8 lms = 0; /* Select AXI0 master for LLI fetching */
 
-	dev_dbg(chan2dev(chan), "%s: memcpy: src: %pad dst: %pad length: %zd flags: %#lx",
+	dev_dbg(vchan_chan_dev(&chan->vc), "%s: memcpy: src: %pad dst: %pad length: %zd flags: %#lx",
 		axi_chan_name(chan), &src_adr, &dst_adr, len, flags);
 
 	max_block_ts = chan->chip->dw->hdata->block_size[chan->id];
@@ -1034,11 +1034,11 @@ static void axi_chan_dump_lli(struct axi_dma_chan *chan,
 			      struct axi_dma_hw_desc *desc)
 {
 	if (!desc->lli) {
-		dev_err(dchan2dev(&chan->vc.chan), "NULL LLI\n");
+		dev_err(vchan_chan_dev(&chan->vc), "NULL LLI\n");
 		return;
 	}
 
-	dev_err(dchan2dev(&chan->vc.chan),
+	dev_err(vchan_chan_dev(&chan->vc),
 		"SAR: 0x%llx DAR: 0x%llx LLP: 0x%llx BTS 0x%x CTL: 0x%x:%08x",
 		le64_to_cpu(desc->lli->sar),
 		le64_to_cpu(desc->lli->dar),
@@ -1070,7 +1070,7 @@ static noinline void axi_chan_handle_err(struct axi_dma_chan *chan, u32 status)
 	/* The bad descriptor currently is in the head of vc list */
 	vd = vchan_next_desc(&chan->vc);
 	if (!vd) {
-		dev_err(chan2dev(chan), "BUG: %s, IRQ with no descriptors\n",
+		dev_err(vchan_chan_dev(&chan->vc), "BUG: %s, IRQ with no descriptors\n",
 			axi_chan_name(chan));
 		goto out;
 	}
@@ -1078,7 +1078,7 @@ static noinline void axi_chan_handle_err(struct axi_dma_chan *chan, u32 status)
 	list_del(&vd->node);
 
 	/* WARN about bad descriptor */
-	dev_err(chan2dev(chan),
+	dev_err(vchan_chan_dev(&chan->vc),
 		"Bad descriptor submitted for %s, cookie: %d, irq: 0x%08x\n",
 		axi_chan_name(chan), vd->tx.cookie, status);
 	axi_chan_list_dump_lli(chan, vd_to_axi_desc(vd));
@@ -1104,7 +1104,7 @@ static void axi_chan_block_xfer_complete(struct axi_dma_chan *chan)
 
 	spin_lock_irqsave(&chan->vc.lock, flags);
 	if (unlikely(axi_chan_is_hw_enable(chan))) {
-		dev_err(chan2dev(chan), "BUG: %s caught DWAXIDMAC_IRQ_DMA_TRF, but channel not idle!\n",
+		dev_err(vchan_chan_dev(&chan->vc), "BUG: %s caught DWAXIDMAC_IRQ_DMA_TRF, but channel not idle!\n",
 			axi_chan_name(chan));
 		axi_chan_disable(chan);
 	}
@@ -1112,7 +1112,7 @@ static void axi_chan_block_xfer_complete(struct axi_dma_chan *chan)
 	/* The completed descriptor currently is in the head of vc list */
 	vd = vchan_next_desc(&chan->vc);
 	if (!vd) {
-		dev_err(chan2dev(chan), "BUG: %s, IRQ with no descriptors\n",
+		dev_err(vchan_chan_dev(&chan->vc), "BUG: %s, IRQ with no descriptors\n",
 			axi_chan_name(chan));
 		goto out;
 	}
@@ -1192,7 +1192,7 @@ static int dma_chan_terminate_all(struct dma_chan *dchan)
 	ret = readl_poll_timeout_atomic(chan->chip->regs + DMAC_CHEN, val,
 					!(val & chan_active), 1000, 50000);
 	if (ret == -ETIMEDOUT)
-		dev_warn(dchan2dev(dchan),
+		dev_warn(dmaengine_chan_dev(dchan),
 			 "%s failed to stop\n", axi_chan_name(chan));
 
 	if (chan->direction != DMA_MEM_TO_MEM)
@@ -1209,7 +1209,7 @@ static int dma_chan_terminate_all(struct dma_chan *dchan)
 
 	vchan_dma_desc_free_list(&chan->vc, &head);
 
-	dev_vdbg(dchan2dev(dchan), "terminated: %s\n", axi_chan_name(chan));
+	dev_vdbg(dmaengine_chan_dev(dchan), "terminated: %s\n", axi_chan_name(chan));
 
 	return 0;
 }
diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
index 039316c42f059..e3e200a058623 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
@@ -118,16 +118,6 @@ struct axi_dma_chan_config {
 	u8 hs_sel_src;
 };
 
-static inline struct device *dchan2dev(struct dma_chan *dchan)
-{
-	return &dchan->dev->device;
-}
-
-static inline struct device *chan2dev(struct axi_dma_chan *chan)
-{
-	return &chan->vc.chan.dev->device;
-}
-
 static inline struct axi_dma_desc *vd_to_axi_desc(struct virt_dma_desc *vd)
 {
 	return container_of(vd, struct axi_dma_desc, vd);
diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
index dd75f97a33b3d..575b7bb6af9a0 100644
--- a/drivers/dma/dw/core.c
+++ b/drivers/dma/dw/core.c
@@ -41,11 +41,6 @@
 
 /*----------------------------------------------------------------------*/
 
-static struct device *chan2dev(struct dma_chan *chan)
-{
-	return &chan->dev->device;
-}
-
 static struct dw_desc *dwc_first_active(struct dw_dma_chan *dwc)
 {
 	return to_dw_desc(dwc->active_list.next);
@@ -69,7 +64,7 @@ static dma_cookie_t dwc_tx_submit(struct dma_async_tx_descriptor *tx)
 
 	list_add_tail(&desc->desc_node, &dwc->queue);
 	spin_unlock_irqrestore(&dwc->lock, flags);
-	dev_vdbg(chan2dev(tx->chan), "%s: queued %u\n",
+	dev_vdbg(dmaengine_chan_dev(tx->chan), "%s: queued %u\n",
 		 __func__, desc->txd.cookie);
 
 	return cookie;
@@ -127,7 +122,7 @@ static void dwc_initialize(struct dw_dma_chan *dwc)
 
 static inline void dwc_dump_chan_regs(struct dw_dma_chan *dwc)
 {
-	dev_err(chan2dev(&dwc->chan),
+	dev_err(dmaengine_chan_dev(&dwc->chan),
 		"  SAR: 0x%x DAR: 0x%x LLP: 0x%x CTL: 0x%x:%08x\n",
 		channel_readl(dwc, SAR),
 		channel_readl(dwc, DAR),
@@ -177,7 +172,7 @@ static void dwc_dostart(struct dw_dma_chan *dwc, struct dw_desc *first)
 
 	/* ASSERT:  channel is idle */
 	if (dma_readl(dw, CH_EN) & dwc->mask) {
-		dev_err(chan2dev(&dwc->chan),
+		dev_err(dmaengine_chan_dev(&dwc->chan),
 			"%s: BUG: Attempted to start non-idle channel\n",
 			__func__);
 		dwc_dump_chan_regs(dwc);
@@ -190,7 +185,7 @@ static void dwc_dostart(struct dw_dma_chan *dwc, struct dw_desc *first)
 		was_soft_llp = test_and_set_bit(DW_DMA_IS_SOFT_LLP,
 						&dwc->flags);
 		if (was_soft_llp) {
-			dev_err(chan2dev(&dwc->chan),
+			dev_err(dmaengine_chan_dev(&dwc->chan),
 				"BUG: Attempted to start new LLP transfer inside ongoing one\n");
 			return;
 		}
@@ -223,7 +218,7 @@ static void dwc_dostart_first_queued(struct dw_dma_chan *dwc)
 
 	list_move(dwc->queue.next, &dwc->active_list);
 	desc = dwc_first_active(dwc);
-	dev_vdbg(chan2dev(&dwc->chan), "%s: started %u\n", __func__, desc->txd.cookie);
+	dev_vdbg(dmaengine_chan_dev(&dwc->chan), "%s: started %u\n", __func__, desc->txd.cookie);
 	dwc_dostart(dwc, desc);
 }
 
@@ -238,7 +233,7 @@ dwc_descriptor_complete(struct dw_dma_chan *dwc, struct dw_desc *desc,
 	unsigned long			flags;
 	struct dmaengine_desc_callback	cb;
 
-	dev_vdbg(chan2dev(&dwc->chan), "descriptor %u complete\n", txd->cookie);
+	dev_vdbg(dmaengine_chan_dev(&dwc->chan), "descriptor %u complete\n", txd->cookie);
 
 	spin_lock_irqsave(&dwc->lock, flags);
 	dma_cookie_complete(txd);
@@ -265,7 +260,7 @@ static void dwc_complete_all(struct dw_dma *dw, struct dw_dma_chan *dwc)
 
 	spin_lock_irqsave(&dwc->lock, flags);
 	if (dma_readl(dw, CH_EN) & dwc->mask) {
-		dev_err(chan2dev(&dwc->chan),
+		dev_err(dmaengine_chan_dev(&dwc->chan),
 			"BUG: XFER bit set, but channel not idle!\n");
 
 		/* Try to continue after resetting the channel... */
@@ -353,12 +348,12 @@ static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
 	}
 
 	if (test_bit(DW_DMA_IS_SOFT_LLP, &dwc->flags)) {
-		dev_vdbg(chan2dev(&dwc->chan), "%s: soft LLP mode\n", __func__);
+		dev_vdbg(dmaengine_chan_dev(&dwc->chan), "%s: soft LLP mode\n", __func__);
 		spin_unlock_irqrestore(&dwc->lock, flags);
 		return;
 	}
 
-	dev_vdbg(chan2dev(&dwc->chan), "%s: llp=%pad\n", __func__, &llp);
+	dev_vdbg(dmaengine_chan_dev(&dwc->chan), "%s: llp=%pad\n", __func__, &llp);
 
 	list_for_each_entry_safe(desc, _desc, &dwc->active_list, desc_node) {
 		/* Initial residue value */
@@ -398,7 +393,7 @@ static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
 		spin_lock_irqsave(&dwc->lock, flags);
 	}
 
-	dev_err(chan2dev(&dwc->chan),
+	dev_err(dmaengine_chan_dev(&dwc->chan),
 		"BUG: All descriptors done, but channel not idle!\n");
 
 	/* Try to continue after resetting the channel... */
@@ -410,7 +405,7 @@ static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
 
 static inline void dwc_dump_lli(struct dw_dma_chan *dwc, struct dw_desc *desc)
 {
-	dev_crit(chan2dev(&dwc->chan), "  desc: s0x%x d0x%x l0x%x c0x%x:%x\n",
+	dev_crit(dmaengine_chan_dev(&dwc->chan), "  desc: s0x%x d0x%x l0x%x c0x%x:%x\n",
 		 lli_read(desc, sar),
 		 lli_read(desc, dar),
 		 lli_read(desc, llp),
@@ -449,7 +444,7 @@ static void dwc_handle_error(struct dw_dma *dw, struct dw_dma_chan *dwc)
 	 * controller flagged an error instead of scribbling over
 	 * random memory locations.
 	 */
-	dev_WARN(chan2dev(&dwc->chan), "Bad descriptor submitted for DMA!\n"
+	dev_WARN(dmaengine_chan_dev(&dwc->chan), "Bad descriptor submitted for DMA!\n"
 				       "  cookie: %d\n", bad_desc->txd.cookie);
 	dwc_dump_lli(dwc, bad_desc);
 	list_for_each_entry(child, &bad_desc->tx_list, desc_node)
@@ -552,12 +547,12 @@ dwc_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
 	u32			ctllo, ctlhi;
 	u8			lms = DWC_LLP_LMS(m_master);
 
-	dev_vdbg(chan2dev(chan),
+	dev_vdbg(dmaengine_chan_dev(chan),
 			"%s: d%pad s%pad l0x%zx f0x%lx\n", __func__,
 			&dest, &src, len, flags);
 
 	if (unlikely(!len)) {
-		dev_dbg(chan2dev(chan), "%s: length is zero!\n", __func__);
+		dev_dbg(dmaengine_chan_dev(chan), "%s: length is zero!\n", __func__);
 		return NULL;
 	}
 
@@ -630,7 +625,7 @@ dwc_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 	struct scatterlist	*sg;
 	size_t			total_len = 0;
 
-	dev_vdbg(chan2dev(chan), "%s\n", __func__);
+	dev_vdbg(dmaengine_chan_dev(chan), "%s\n", __func__);
 
 	if (unlikely(!is_slave_direction(direction) || !sg_len))
 		return NULL;
@@ -754,7 +749,7 @@ dwc_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 	return &first->txd;
 
 err_desc_get:
-	dev_err(chan2dev(chan),
+	dev_err(dmaengine_chan_dev(chan),
 		"not enough descriptors available. Direction %d\n", direction);
 	dwc_desc_put(dwc, first);
 	return NULL;
@@ -1063,11 +1058,11 @@ static int dwc_alloc_chan_resources(struct dma_chan *chan)
 	struct dw_dma_chan	*dwc = to_dw_dma_chan(chan);
 	struct dw_dma		*dw = to_dw_dma(chan->device);
 
-	dev_vdbg(chan2dev(chan), "%s\n", __func__);
+	dev_vdbg(dmaengine_chan_dev(chan), "%s\n", __func__);
 
 	/* ASSERT:  channel is idle */
 	if (dma_readl(dw, CH_EN) & dwc->mask) {
-		dev_dbg(chan2dev(chan), "DMA channel not idle?\n");
+		dev_dbg(dmaengine_chan_dev(chan), "DMA channel not idle?\n");
 		return -EIO;
 	}
 
@@ -1083,7 +1078,7 @@ static int dwc_alloc_chan_resources(struct dma_chan *chan)
 	 * We need controller-specific data to set up slave transfers.
 	 */
 	if (chan->private && !dw_dma_filter(chan, chan->private)) {
-		dev_warn(chan2dev(chan), "Wrong controller-specific data\n");
+		dev_warn(dmaengine_chan_dev(chan), "Wrong controller-specific data\n");
 		return -EINVAL;
 	}
 
@@ -1101,7 +1096,7 @@ static void dwc_free_chan_resources(struct dma_chan *chan)
 	struct dw_dma		*dw = to_dw_dma(chan->device);
 	unsigned long		flags;
 
-	dev_dbg(chan2dev(chan), "%s: descs allocated=%u\n", __func__,
+	dev_dbg(dmaengine_chan_dev(chan), "%s: descs allocated=%u\n", __func__,
 			dwc->descs_allocated);
 
 	/* ASSERT:  channel is idle */
@@ -1126,7 +1121,7 @@ static void dwc_free_chan_resources(struct dma_chan *chan)
 	if (!dw->in_use)
 		do_dw_dma_off(dw);
 
-	dev_vdbg(chan2dev(chan), "%s: done\n", __func__);
+	dev_vdbg(dmaengine_chan_dev(chan), "%s: done\n", __func__);
 }
 
 static void dwc_caps(struct dma_chan *chan, struct dma_slave_caps *caps)
diff --git a/drivers/dma/ep93xx_dma.c b/drivers/dma/ep93xx_dma.c
index 311e55a97ba9f..cbfe74fc8d71e 100644
--- a/drivers/dma/ep93xx_dma.c
+++ b/drivers/dma/ep93xx_dma.c
@@ -250,11 +250,6 @@ struct ep93xx_edma_data {
 	size_t	num_channels;
 };
 
-static inline struct device *chan2dev(struct ep93xx_dma_chan *edmac)
-{
-	return &edmac->chan.dev->device;
-}
-
 static struct ep93xx_dma_chan *to_ep93xx_dma_chan(struct dma_chan *chan)
 {
 	return container_of(chan, struct ep93xx_dma_chan, chan);
@@ -415,7 +410,7 @@ static void m2p_hw_shutdown(struct ep93xx_dma_chan *edmac)
 	m2p_set_control(edmac, 0);
 
 	while (m2p_channel_state(edmac) != M2P_STATE_IDLE)
-		dev_warn(chan2dev(edmac), "M2P: Not yet IDLE\n");
+		dev_warn(dmaengine_chan_dev(&edmac->chan), "M2P: Not yet IDLE\n");
 }
 
 static void m2p_fill_desc(struct ep93xx_dma_chan *edmac)
@@ -425,7 +420,7 @@ static void m2p_fill_desc(struct ep93xx_dma_chan *edmac)
 
 	desc = ep93xx_dma_get_active(edmac);
 	if (!desc) {
-		dev_warn(chan2dev(edmac), "M2P: empty descriptor list\n");
+		dev_warn(dmaengine_chan_dev(&edmac->chan), "M2P: empty descriptor list\n");
 		return;
 	}
 
@@ -479,7 +474,7 @@ static int m2p_hw_interrupt(struct ep93xx_dma_chan *edmac)
 		 * Revisit this when there is a mechanism to report back the
 		 * errors.
 		 */
-		dev_err(chan2dev(edmac),
+		dev_err(dmaengine_chan_dev(&edmac->chan),
 			"DMA transfer failed! Details:\n"
 			"\tcookie	: %d\n"
 			"\tsrc_addr	: 0x%08x\n"
@@ -586,7 +581,7 @@ static void m2m_fill_desc(struct ep93xx_dma_chan *edmac)
 
 	desc = ep93xx_dma_get_active(edmac);
 	if (!desc) {
-		dev_warn(chan2dev(edmac), "M2M: empty descriptor list\n");
+		dev_warn(dmaengine_chan_dev(&edmac->chan), "M2M: empty descriptor list\n");
 		return;
 	}
 
@@ -849,7 +844,7 @@ static irqreturn_t ep93xx_dma_interrupt(int irq, void *dev_id)
 
 	desc = ep93xx_dma_get_active(edmac);
 	if (!desc) {
-		dev_warn(chan2dev(edmac),
+		dev_warn(dmaengine_chan_dev(&edmac->chan),
 			 "got interrupt while active list is empty\n");
 		spin_unlock(&edmac->lock);
 		return IRQ_NONE;
@@ -867,7 +862,7 @@ static irqreturn_t ep93xx_dma_interrupt(int irq, void *dev_id)
 		break;
 
 	default:
-		dev_warn(chan2dev(edmac), "unknown interrupt!\n");
+		dev_warn(dmaengine_chan_dev(&edmac->chan), "unknown interrupt!\n");
 		ret = IRQ_NONE;
 		break;
 	}
@@ -967,7 +962,7 @@ static int ep93xx_dma_alloc_chan_resources(struct dma_chan *chan)
 
 		desc = kzalloc_obj(*desc);
 		if (!desc) {
-			dev_warn(chan2dev(edmac), "not enough descriptors\n");
+			dev_warn(dmaengine_chan_dev(&edmac->chan), "not enough descriptors\n");
 			break;
 		}
 
@@ -1044,7 +1039,7 @@ ep93xx_dma_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dest,
 	for (offset = 0; offset < len; offset += bytes) {
 		desc = ep93xx_dma_desc_get(edmac);
 		if (!desc) {
-			dev_warn(chan2dev(edmac), "couldn't get descriptor\n");
+			dev_warn(dmaengine_chan_dev(&edmac->chan), "couldn't get descriptor\n");
 			goto fail;
 		}
 
@@ -1091,13 +1086,13 @@ ep93xx_dma_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 	int i;
 
 	if (!edmac->edma->m2m && dir != ep93xx_dma_chan_direction(chan)) {
-		dev_warn(chan2dev(edmac),
+		dev_warn(dmaengine_chan_dev(&edmac->chan),
 			 "channel was configured with different direction\n");
 		return NULL;
 	}
 
 	if (test_bit(EP93XX_DMA_IS_CYCLIC, &edmac->flags)) {
-		dev_warn(chan2dev(edmac),
+		dev_warn(dmaengine_chan_dev(&edmac->chan),
 			 "channel is already used for cyclic transfers\n");
 		return NULL;
 	}
@@ -1109,14 +1104,14 @@ ep93xx_dma_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 		size_t len = sg_dma_len(sg);
 
 		if (len > DMA_MAX_CHAN_BYTES) {
-			dev_warn(chan2dev(edmac), "too big transfer size %zu\n",
+			dev_warn(dmaengine_chan_dev(&edmac->chan), "too big transfer size %zu\n",
 				 len);
 			goto fail;
 		}
 
 		desc = ep93xx_dma_desc_get(edmac);
 		if (!desc) {
-			dev_warn(chan2dev(edmac), "couldn't get descriptor\n");
+			dev_warn(dmaengine_chan_dev(&edmac->chan), "couldn't get descriptor\n");
 			goto fail;
 		}
 
@@ -1172,19 +1167,19 @@ ep93xx_dma_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t dma_addr,
 	size_t offset = 0;
 
 	if (!edmac->edma->m2m && dir != ep93xx_dma_chan_direction(chan)) {
-		dev_warn(chan2dev(edmac),
+		dev_warn(dmaengine_chan_dev(&edmac->chan),
 			 "channel was configured with different direction\n");
 		return NULL;
 	}
 
 	if (test_and_set_bit(EP93XX_DMA_IS_CYCLIC, &edmac->flags)) {
-		dev_warn(chan2dev(edmac),
+		dev_warn(dmaengine_chan_dev(&edmac->chan),
 			 "channel is already used for cyclic transfers\n");
 		return NULL;
 	}
 
 	if (period_len > DMA_MAX_CHAN_BYTES) {
-		dev_warn(chan2dev(edmac), "too big period length %zu\n",
+		dev_warn(dmaengine_chan_dev(&edmac->chan), "too big period length %zu\n",
 			 period_len);
 		return NULL;
 	}
@@ -1196,7 +1191,7 @@ ep93xx_dma_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t dma_addr,
 	for (offset = 0; offset < buf_len; offset += period_len) {
 		desc = ep93xx_dma_desc_get(edmac);
 		if (!desc) {
-			dev_warn(chan2dev(edmac), "couldn't get descriptor\n");
+			dev_warn(dmaengine_chan_dev(&edmac->chan), "couldn't get descriptor\n");
 			goto fail;
 		}
 
diff --git a/drivers/dma/idma64.c b/drivers/dma/idma64.c
index e1fcce07d1c10..657629b100fa9 100644
--- a/drivers/dma/idma64.c
+++ b/drivers/dma/idma64.c
@@ -25,11 +25,6 @@
 
 /* ---------------------------------------------------------------------- */
 
-static struct device *chan2dev(struct dma_chan *chan)
-{
-	return &chan->dev->device;
-}
-
 /* ---------------------------------------------------------------------- */
 
 static void idma64_off(struct idma64 *idma64)
@@ -510,7 +505,7 @@ static int idma64_alloc_chan_resources(struct dma_chan *chan)
 	idma64c->pool = dma_pool_create(dma_chan_name(chan), chan->device->dev,
 					sizeof(struct idma64_lli), 8, 0);
 	if (!idma64c->pool) {
-		dev_err(chan2dev(chan), "No memory for descriptors\n");
+		dev_err(dmaengine_chan_dev(chan), "No memory for descriptors\n");
 		return -ENOMEM;
 	}
 
diff --git a/drivers/dma/loongson/loongson1-apb-dma.c b/drivers/dma/loongson/loongson1-apb-dma.c
index 89786cbd20ab5..46b4bfef45e26 100644
--- a/drivers/dma/loongson/loongson1-apb-dma.c
+++ b/drivers/dma/loongson/loongson1-apb-dma.c
@@ -89,11 +89,6 @@ static irqreturn_t ls1x_dma_irq_handler(int irq, void *data);
 #define to_ls1x_dma_desc(d)		\
 	container_of(d, struct ls1x_dma_desc, vd)
 
-static inline struct device *chan2dev(struct dma_chan *chan)
-{
-	return &chan->dev->device;
-}
-
 static inline int ls1x_dma_query(struct ls1x_dma_chan *chan,
 				 dma_addr_t *lli_phys)
 {
@@ -107,7 +102,7 @@ static inline int ls1x_dma_query(struct ls1x_dma_chan *chan,
 	ret = readl_poll_timeout_atomic(chan->reg_base + LS1X_DMA_CTRL, val,
 					!(val & LS1X_DMA_ASK_VALID), 0, 3000);
 	if (ret)
-		dev_err(chan2dev(dchan), "failed to query DMA\n");
+		dev_err(dmaengine_chan_dev(dchan), "failed to query DMA\n");
 
 	return ret;
 }
@@ -116,7 +111,7 @@ static inline int ls1x_dma_start(struct ls1x_dma_chan *chan,
 				 dma_addr_t *lli_phys)
 {
 	struct dma_chan *dchan = &chan->vc.chan;
-	struct device *dev = chan2dev(dchan);
+	struct device *dev = dmaengine_chan_dev(dchan);
 	int val, ret;
 
 	val = *lli_phys & LS1X_DMA_LLI_ADDR_MASK;
@@ -143,7 +138,7 @@ static inline void ls1x_dma_stop(struct ls1x_dma_chan *chan)
 static void ls1x_dma_free_chan_resources(struct dma_chan *dchan)
 {
 	struct ls1x_dma_chan *chan = to_ls1x_dma_chan(dchan);
-	struct device *dev = chan2dev(dchan);
+	struct device *dev = dmaengine_chan_dev(dchan);
 
 	dma_free_coherent(dev, sizeof(struct ls1x_dma_lli),
 			  chan->curr_lli, chan->curr_lli->phys);
@@ -156,7 +151,7 @@ static void ls1x_dma_free_chan_resources(struct dma_chan *dchan)
 static int ls1x_dma_alloc_chan_resources(struct dma_chan *dchan)
 {
 	struct ls1x_dma_chan *chan = to_ls1x_dma_chan(dchan);
-	struct device *dev = chan2dev(dchan);
+	struct device *dev = dmaengine_chan_dev(dchan);
 	dma_addr_t phys;
 	int ret;
 
@@ -219,7 +214,7 @@ static int ls1x_dma_prep_lli(struct dma_chan *dchan, struct ls1x_dma_desc *desc,
 {
 	struct ls1x_dma_chan *chan = to_ls1x_dma_chan(dchan);
 	struct ls1x_dma_lli *lli, *prev = NULL, *first = NULL;
-	struct device *dev = chan2dev(dchan);
+	struct device *dev = dmaengine_chan_dev(dchan);
 	struct list_head *pos = NULL;
 	struct scatterlist *sg;
 	unsigned int dev_addr, cmd, i;
@@ -299,7 +294,7 @@ ls1x_dma_prep_slave_sg(struct dma_chan *dchan, struct scatterlist *sgl,
 {
 	struct ls1x_dma_desc *desc;
 
-	dev_dbg(chan2dev(dchan), "sg_len=%u flags=0x%lx dir=%s\n",
+	dev_dbg(dmaengine_chan_dev(dchan), "sg_len=%u flags=0x%lx dir=%s\n",
 		sg_len, flags, dmaengine_get_direction_text(dir));
 
 	desc = ls1x_dma_alloc_desc();
@@ -325,7 +320,7 @@ ls1x_dma_prep_dma_cyclic(struct dma_chan *dchan, dma_addr_t buf_addr,
 	unsigned int i;
 	int ret;
 
-	dev_dbg(chan2dev(dchan),
+	dev_dbg(dmaengine_chan_dev(dchan),
 		"buf_len=%zu period_len=%zu flags=0x%lx dir=%s\n",
 		buf_len, period_len, flags, dmaengine_get_direction_text(dir));
 
@@ -450,7 +445,7 @@ static enum dma_status ls1x_dma_tx_status(struct dma_chan *dchan,
 				if (lli->hw[LS1X_DMADESC_NEXT] == next_phys)
 					break;
 
-			dev_dbg(chan2dev(dchan), "current lli_phys=%pad",
+			dev_dbg(dmaengine_chan_dev(dchan), "current lli_phys=%pad",
 				&lli->phys);
 
 			/* count the residues */
@@ -489,7 +484,7 @@ static irqreturn_t ls1x_dma_irq_handler(int irq, void *data)
 {
 	struct ls1x_dma_chan *chan = data;
 	struct dma_chan *dchan = &chan->vc.chan;
-	struct device *dev = chan2dev(dchan);
+	struct device *dev = dmaengine_chan_dev(dchan);
 	struct virt_dma_desc *vd;
 
 	scoped_guard(spinlock, &chan->vc.lock) {
diff --git a/drivers/dma/loongson/loongson2-apb-cmc-dma.c b/drivers/dma/loongson/loongson2-apb-cmc-dma.c
index 2f1c8c4fd0654..755363f4bfa2c 100644
--- a/drivers/dma/loongson/loongson2-apb-cmc-dma.c
+++ b/drivers/dma/loongson/loongson2-apb-cmc-dma.c
@@ -134,11 +134,6 @@ static struct loongson2_cmc_dma_desc *to_lmdma_desc(struct virt_dma_desc *vdesc)
 	return container_of(vdesc, struct loongson2_cmc_dma_desc, vdesc);
 }
 
-static struct device *chan2dev(struct loongson2_cmc_dma_chan *lchan)
-{
-	return &lchan->vchan.chan.dev->device;
-}
-
 static u32 loongson2_cmc_dma_read(struct loongson2_cmc_dma_dev *lddev, u32 reg, u32 id)
 {
 	return readl(lddev->base + (reg + lddev->chan_reg_offset * id));
@@ -302,7 +297,7 @@ static irqreturn_t loongson2_cmc_dma_chan_irq(int irq, void *devid)
 {
 	struct loongson2_cmc_dma_chan *lchan = devid;
 	struct loongson2_cmc_dma_dev *lddev = lmdma_get_dev(lchan);
-	struct device *dev = chan2dev(lchan);
+	struct device *dev = vchan_chan_dev(&lchan->vchan);
 	u32 ists, status, ccr;
 
 	scoped_guard(spinlock, &lchan->vchan.lock) {
@@ -337,7 +332,7 @@ static void loongson2_cmc_dma_issue_pending(struct dma_chan *chan)
 	guard(spinlock_irqsave)(&lchan->vchan.lock);
 
 	if (vchan_issue_pending(&lchan->vchan) && !lchan->desc) {
-		dev_dbg(chan2dev(lchan), "vchan %pK: issued\n", &lchan->vchan);
+		dev_dbg(vchan_chan_dev(&lchan->vchan), "vchan %pK: issued\n", &lchan->vchan);
 		loongson2_cmc_dma_start_transfer(lchan);
 	}
 }
@@ -347,7 +342,7 @@ static int loongson2_cmc_dma_set_xfer_param(struct loongson2_cmc_dma_chan *lchan
 					    enum dma_slave_buswidth *buswidth, u32 buf_len)
 {
 	struct dma_slave_config	sconfig = lchan->dma_sconfig;
-	struct device *dev = chan2dev(lchan);
+	struct device *dev = vchan_chan_dev(&lchan->vchan);
 	int dev_width;
 	u32 ccr;
 
@@ -409,7 +404,7 @@ loongson2_cmc_dma_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 
 		num_items = DIV_ROUND_UP(sg_dma_len(sg), buswidth);
 		if (num_items >= LOONSON2_CMCDMA_MAX_DATA_ITEMS) {
-			dev_err(chan2dev(lchan), "Number of items not supported\n");
+			dev_err(vchan_chan_dev(&lchan->vchan), "Number of items not supported\n");
 			kfree(desc);
 			return ERR_PTR(-EINVAL);
 		}
@@ -447,7 +442,7 @@ loongson2_cmc_dma_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t buf_addr, si
 
 	num_items = DIV_ROUND_UP(period_len, buswidth);
 	if (num_items >= LOONSON2_CMCDMA_MAX_DATA_ITEMS) {
-		dev_err(chan2dev(lchan), "Number of items not supported\n");
+		dev_err(vchan_chan_dev(&lchan->vchan), "Number of items not supported\n");
 		return ERR_PTR(-EINVAL);
 	}
 
diff --git a/drivers/dma/loongson/loongson2-apb-dma.c b/drivers/dma/loongson/loongson2-apb-dma.c
index 7c3d7c3273955..16a0c1c60d59a 100644
--- a/drivers/dma/loongson/loongson2-apb-dma.c
+++ b/drivers/dma/loongson/loongson2-apb-dma.c
@@ -161,11 +161,6 @@ static inline struct ls2x_dma_priv *to_ldma_priv(struct dma_device *ddev)
 	return container_of(ddev, struct ls2x_dma_priv, ddev);
 }
 
-static struct device *chan2dev(struct dma_chan *chan)
-{
-	return &chan->dev->device;
-}
-
 static void ls2x_dma_desc_free(struct virt_dma_desc *vdesc)
 {
 	struct ls2x_dma_chan *lchan = to_ldma_chan(vdesc->tx.chan);
@@ -286,7 +281,7 @@ static int ls2x_dma_alloc_chan_resources(struct dma_chan *chan)
 				      chan->device->dev, PAGE_SIZE,
 				      __alignof__(struct ls2x_dma_hw_desc), 0);
 	if (!lchan->pool) {
-		dev_err(chan2dev(chan), "No memory for descriptors\n");
+		dev_err(dmaengine_chan_dev(chan), "No memory for descriptors\n");
 		return -ENOMEM;
 	}
 
diff --git a/drivers/dma/moxart-dma.c b/drivers/dma/moxart-dma.c
index 442f5aa16031f..28be93eed4cce 100644
--- a/drivers/dma/moxart-dma.c
+++ b/drivers/dma/moxart-dma.c
@@ -154,11 +154,6 @@ static const unsigned int es_bytes[] = {
 	[MOXART_DMA_DATA_TYPE_S32] = 4,
 };
 
-static struct device *chan2dev(struct dma_chan *chan)
-{
-	return &chan->dev->device;
-}
-
 static inline struct moxart_chan *to_moxart_dma_chan(struct dma_chan *c)
 {
 	return container_of(c, struct moxart_chan, vc.chan);
@@ -182,7 +177,7 @@ static int moxart_terminate_all(struct dma_chan *chan)
 	LIST_HEAD(head);
 	u32 ctrl;
 
-	dev_dbg(chan2dev(chan), "%s: ch=%p\n", __func__, ch);
+	dev_dbg(dmaengine_chan_dev(chan), "%s: ch=%p\n", __func__, ch);
 
 	spin_lock_irqsave(&ch->vc.lock, flags);
 
@@ -272,7 +267,7 @@ static struct dma_async_tx_descriptor *moxart_prep_slave_sg(
 	unsigned int i;
 
 	if (!is_slave_direction(dir)) {
-		dev_err(chan2dev(chan), "%s: invalid DMA direction\n",
+		dev_err(dmaengine_chan_dev(chan), "%s: invalid DMA direction\n",
 			__func__);
 		return NULL;
 	}
@@ -296,7 +291,7 @@ static struct dma_async_tx_descriptor *moxart_prep_slave_sg(
 		es = MOXART_DMA_DATA_TYPE_S32;
 		break;
 	default:
-		dev_err(chan2dev(chan), "%s: unsupported data width (%u)\n",
+		dev_err(dmaengine_chan_dev(chan), "%s: unsupported data width (%u)\n",
 			__func__, dev_width);
 		return NULL;
 	}
@@ -341,7 +336,7 @@ static int moxart_alloc_chan_resources(struct dma_chan *chan)
 {
 	struct moxart_chan *ch = to_moxart_dma_chan(chan);
 
-	dev_dbg(chan2dev(chan), "%s: allocating channel #%u\n",
+	dev_dbg(dmaengine_chan_dev(chan), "%s: allocating channel #%u\n",
 		__func__, ch->ch_num);
 	ch->allocated = 1;
 
@@ -354,7 +349,7 @@ static void moxart_free_chan_resources(struct dma_chan *chan)
 
 	vchan_free_chan_resources(&ch->vc);
 
-	dev_dbg(chan2dev(chan), "%s: freeing channel #%u\n",
+	dev_dbg(dmaengine_chan_dev(chan), "%s: freeing channel #%u\n",
 		__func__, ch->ch_num);
 	ch->allocated = 0;
 }
@@ -379,7 +374,7 @@ static void moxart_set_transfer_params(struct moxart_chan *ch, unsigned int len)
 	 */
 	writel(d->dma_cycles, ch->base + REG_OFF_CYCLES);
 
-	dev_dbg(chan2dev(&ch->vc.chan), "%s: set %u DMA cycles (len=%u)\n",
+	dev_dbg(vchan_chan_dev(&ch->vc), "%s: set %u DMA cycles (len=%u)\n",
 		__func__, d->dma_cycles, len);
 }
 
@@ -460,7 +455,7 @@ static size_t moxart_dma_desc_size_in_flight(struct moxart_chan *ch)
 	completed_cycles = (ch->desc->dma_cycles - cycles);
 	size -= completed_cycles << es_bytes[ch->desc->es];
 
-	dev_dbg(chan2dev(&ch->vc.chan), "%s: size=%zu\n", __func__, size);
+	dev_dbg(vchan_chan_dev(&ch->vc), "%s: size=%zu\n", __func__, size);
 
 	return size;
 }
@@ -517,7 +512,7 @@ static irqreturn_t moxart_dma_interrupt(int irq, void *devid)
 	unsigned int i;
 	u32 ctrl;
 
-	dev_dbg(chan2dev(&ch->vc.chan), "%s\n", __func__);
+	dev_dbg(vchan_chan_dev(&ch->vc), "%s\n", __func__);
 
 	for (i = 0; i < APB_DMA_MAX_CHANNEL; i++, ch++) {
 		if (!ch->allocated)
@@ -525,7 +520,7 @@ static irqreturn_t moxart_dma_interrupt(int irq, void *devid)
 
 		ctrl = readl(ch->base + REG_OFF_CTRL);
 
-		dev_dbg(chan2dev(&ch->vc.chan), "%s: ch=%p ch->base=%p ctrl=%x\n",
+		dev_dbg(vchan_chan_dev(&ch->vc), "%s: ch=%p ch->base=%p ctrl=%x\n",
 			__func__, ch, ch->base, ctrl);
 
 		if (ctrl & APB_DMA_FIN_INT_STS) {
diff --git a/drivers/dma/nbpfaxi.c b/drivers/dma/nbpfaxi.c
index 05d7321629cc8..744cd14d78725 100644
--- a/drivers/dma/nbpfaxi.c
+++ b/drivers/dma/nbpfaxi.c
@@ -1202,7 +1202,7 @@ static irqreturn_t nbpf_chan_irq(int irq, void *dev)
 
 	nbpf_status_ack(chan);
 
-	dev_dbg(&chan->dma_chan.dev->device, "%s()\n", __func__);
+	dev_dbg(dmaengine_chan_dev(&chan->dma_chan), "%s()\n", __func__);
 
 	spin_lock(&chan->lock);
 	desc = chan->running;
diff --git a/drivers/dma/owl-dma.c b/drivers/dma/owl-dma.c
index 7c80572fc71d1..9dc88d804a2e4 100644
--- a/drivers/dma/owl-dma.c
+++ b/drivers/dma/owl-dma.c
@@ -292,11 +292,6 @@ static inline struct owl_dma *to_owl_dma(struct dma_device *dd)
 	return container_of(dd, struct owl_dma, dma);
 }
 
-static struct device *chan2dev(struct dma_chan *chan)
-{
-	return &chan->dev->device;
-}
-
 static inline struct owl_dma_vchan *to_owl_vchan(struct dma_chan *chan)
 {
 	return container_of(chan, struct owl_dma_vchan, vc.chan);
@@ -573,7 +568,7 @@ static int owl_dma_start_next_txd(struct owl_dma_vchan *vchan)
 
 	spin_unlock_irqrestore(&od->lock, flags);
 
-	dev_dbg(chan2dev(&vchan->vc.chan), "starting pchan %d\n", pchan->id);
+	dev_dbg(vchan_chan_dev(&vchan->vc), "starting pchan %d\n", pchan->id);
 
 	/* Start DMA transfer for this pchan */
 	pchan_writel(pchan, OWL_DMAX_START, 0x1);
@@ -757,7 +752,7 @@ static int owl_dma_resume(struct dma_chan *chan)
 	if (!vchan->pchan && !vchan->txd)
 		return 0;
 
-	dev_dbg(chan2dev(chan), "vchan %p: resume\n", &vchan->vc);
+	dev_dbg(dmaengine_chan_dev(chan), "vchan %p: resume\n", &vchan->vc);
 
 	spin_lock_irqsave(&vchan->vc.lock, flags);
 
@@ -888,7 +883,7 @@ static struct dma_async_tx_descriptor
 	for (offset = 0; offset < len; offset += bytes) {
 		lli = owl_dma_alloc_lli(od);
 		if (!lli) {
-			dev_warn(chan2dev(chan), "failed to allocate lli\n");
+			dev_warn(dmaengine_chan_dev(chan), "failed to allocate lli\n");
 			goto err_txd_free;
 		}
 
@@ -898,7 +893,7 @@ static struct dma_async_tx_descriptor
 				      bytes, DMA_MEM_TO_MEM,
 				      &vchan->cfg, txd->cyclic);
 		if (ret) {
-			dev_warn(chan2dev(chan), "failed to config lli\n");
+			dev_warn(dmaengine_chan_dev(chan), "failed to config lli\n");
 			goto err_txd_free;
 		}
 
@@ -947,7 +942,7 @@ static struct dma_async_tx_descriptor
 
 		lli = owl_dma_alloc_lli(od);
 		if (!lli) {
-			dev_err(chan2dev(chan), "failed to allocate lli");
+			dev_err(dmaengine_chan_dev(chan), "failed to allocate lli");
 			goto err_txd_free;
 		}
 
@@ -962,7 +957,7 @@ static struct dma_async_tx_descriptor
 		ret = owl_dma_cfg_lli(vchan, lli, src, dst, len, dir, sconfig,
 				      txd->cyclic);
 		if (ret) {
-			dev_warn(chan2dev(chan), "failed to config lli");
+			dev_warn(dmaengine_chan_dev(chan), "failed to config lli");
 			goto err_txd_free;
 		}
 
@@ -1003,7 +998,7 @@ static struct dma_async_tx_descriptor
 	for (i = 0; i < periods; i++) {
 		lli = owl_dma_alloc_lli(od);
 		if (!lli) {
-			dev_warn(chan2dev(chan), "failed to allocate lli");
+			dev_warn(dmaengine_chan_dev(chan), "failed to allocate lli");
 			goto err_txd_free;
 		}
 
@@ -1018,7 +1013,7 @@ static struct dma_async_tx_descriptor
 		ret = owl_dma_cfg_lli(vchan, lli, src, dst, period_len,
 				      dir, sconfig, txd->cyclic);
 		if (ret) {
-			dev_warn(chan2dev(chan), "failed to config lli");
+			dev_warn(dmaengine_chan_dev(chan), "failed to config lli");
 			goto err_txd_free;
 		}
 
diff --git a/drivers/dma/pch_dma.c b/drivers/dma/pch_dma.c
index bf805f1024f64..88baf7ffec375 100644
--- a/drivers/dma/pch_dma.c
+++ b/drivers/dma/pch_dma.c
@@ -150,11 +150,6 @@ static inline struct pch_dma *to_pd(struct dma_device *ddev)
 	return container_of(ddev, struct pch_dma, dma);
 }
 
-static inline struct device *chan2dev(struct dma_chan *chan)
-{
-	return &chan->dev->device;
-}
-
 static inline
 struct pch_dma_desc *pdc_first_active(struct pch_dma_chan *pd_chan)
 {
@@ -189,7 +184,7 @@ static void pdc_enable_irq(struct dma_chan *chan, int enable)
 
 	dma_writel(pd, CTL2, val);
 
-	dev_dbg(chan2dev(chan), "pdc_enable_irq: chan %d -> %x\n",
+	dev_dbg(dmaengine_chan_dev(chan), "pdc_enable_irq: chan %d -> %x\n",
 		chan->chan_id, val);
 }
 
@@ -237,7 +232,7 @@ static void pdc_set_dir(struct dma_chan *chan)
 		dma_writel(pd, CTL3, val);
 	}
 
-	dev_dbg(chan2dev(chan), "pdc_set_dir: chan %d -> %x\n",
+	dev_dbg(dmaengine_chan_dev(chan), "pdc_set_dir: chan %d -> %x\n",
 		chan->chan_id, val);
 }
 
@@ -271,7 +266,7 @@ static void pdc_set_mode(struct dma_chan *chan, u32 mode)
 		dma_writel(pd, CTL3, val);
 	}
 
-	dev_dbg(chan2dev(chan), "pdc_set_mode: chan %d -> %x\n",
+	dev_dbg(dmaengine_chan_dev(chan), "pdc_set_mode: chan %d -> %x\n",
 		chan->chan_id, val);
 }
 
@@ -314,18 +309,18 @@ static bool pdc_is_idle(struct pch_dma_chan *pd_chan)
 static void pdc_dostart(struct pch_dma_chan *pd_chan, struct pch_dma_desc* desc)
 {
 	if (!pdc_is_idle(pd_chan)) {
-		dev_err(chan2dev(&pd_chan->chan),
+		dev_err(dmaengine_chan_dev(&pd_chan->chan),
 			"BUG: Attempt to start non-idle channel\n");
 		return;
 	}
 
-	dev_dbg(chan2dev(&pd_chan->chan), "chan %d -> dev_addr: %x\n",
+	dev_dbg(dmaengine_chan_dev(&pd_chan->chan), "chan %d -> dev_addr: %x\n",
 		pd_chan->chan.chan_id, desc->regs.dev_addr);
-	dev_dbg(chan2dev(&pd_chan->chan), "chan %d -> mem_addr: %x\n",
+	dev_dbg(dmaengine_chan_dev(&pd_chan->chan), "chan %d -> mem_addr: %x\n",
 		pd_chan->chan.chan_id, desc->regs.mem_addr);
-	dev_dbg(chan2dev(&pd_chan->chan), "chan %d -> size: %x\n",
+	dev_dbg(dmaengine_chan_dev(&pd_chan->chan), "chan %d -> size: %x\n",
 		pd_chan->chan.chan_id, desc->regs.size);
-	dev_dbg(chan2dev(&pd_chan->chan), "chan %d -> next: %x\n",
+	dev_dbg(dmaengine_chan_dev(&pd_chan->chan), "chan %d -> next: %x\n",
 		pd_chan->chan.chan_id, desc->regs.next);
 
 	if (list_empty(&desc->tx_list)) {
@@ -382,8 +377,8 @@ static void pdc_handle_error(struct pch_dma_chan *pd_chan)
 	if (!list_empty(&pd_chan->active_list))
 		pdc_dostart(pd_chan, pdc_first_active(pd_chan));
 
-	dev_crit(chan2dev(&pd_chan->chan), "Bad descriptor submitted\n");
-	dev_crit(chan2dev(&pd_chan->chan), "descriptor cookie: %d\n",
+	dev_crit(dmaengine_chan_dev(&pd_chan->chan), "Bad descriptor submitted\n");
+	dev_crit(dmaengine_chan_dev(&pd_chan->chan), "descriptor cookie: %d\n",
 		 bad_desc->txd.cookie);
 
 	pdc_chain_complete(pd_chan, bad_desc);
@@ -450,10 +445,10 @@ static struct pch_dma_desc *pdc_desc_get(struct pch_dma_chan *pd_chan)
 			ret = desc;
 			break;
 		}
-		dev_dbg(chan2dev(&pd_chan->chan), "desc %p not ACKed\n", desc);
+		dev_dbg(dmaengine_chan_dev(&pd_chan->chan), "desc %p not ACKed\n", desc);
 	}
 	spin_unlock(&pd_chan->lock);
-	dev_dbg(chan2dev(&pd_chan->chan), "scanned %d descriptors\n", i);
+	dev_dbg(dmaengine_chan_dev(&pd_chan->chan), "scanned %d descriptors\n", i);
 
 	if (!ret) {
 		ret = pdc_alloc_desc(&pd_chan->chan, GFP_ATOMIC);
@@ -462,7 +457,7 @@ static struct pch_dma_desc *pdc_desc_get(struct pch_dma_chan *pd_chan)
 			pd_chan->descs_allocated++;
 			spin_unlock(&pd_chan->lock);
 		} else {
-			dev_err(chan2dev(&pd_chan->chan),
+			dev_err(dmaengine_chan_dev(&pd_chan->chan),
 				"failed to alloc desc\n");
 		}
 	}
@@ -489,7 +484,7 @@ static int pd_alloc_chan_resources(struct dma_chan *chan)
 	int i;
 
 	if (!pdc_is_idle(pd_chan)) {
-		dev_dbg(chan2dev(chan), "DMA channel not idle ?\n");
+		dev_dbg(dmaengine_chan_dev(chan), "DMA channel not idle ?\n");
 		return -EIO;
 	}
 
@@ -500,7 +495,7 @@ static int pd_alloc_chan_resources(struct dma_chan *chan)
 		desc = pdc_alloc_desc(chan, GFP_KERNEL);
 
 		if (!desc) {
-			dev_warn(chan2dev(chan),
+			dev_warn(dmaengine_chan_dev(chan),
 				"Only allocated %d initial descriptors\n", i);
 			break;
 		}
@@ -573,7 +568,7 @@ static struct dma_async_tx_descriptor *pd_prep_slave_sg(struct dma_chan *chan,
 	int i;
 
 	if (unlikely(!sg_len)) {
-		dev_info(chan2dev(chan), "prep_slave_sg: length is zero!\n");
+		dev_info(dmaengine_chan_dev(chan), "prep_slave_sg: length is zero!\n");
 		return NULL;
 	}
 
@@ -639,7 +634,7 @@ static struct dma_async_tx_descriptor *pd_prep_slave_sg(struct dma_chan *chan,
 	return &first->txd;
 
 err_desc_get:
-	dev_err(chan2dev(chan), "failed to get desc or wrong parameters\n");
+	dev_err(dmaengine_chan_dev(chan), "failed to get desc or wrong parameters\n");
 	pdc_desc_put(pd_chan, first);
 	return NULL;
 }
@@ -671,7 +666,7 @@ static void pdc_tasklet(struct tasklet_struct *t)
 	unsigned long flags;
 
 	if (!pdc_is_idle(pd_chan)) {
-		dev_err(chan2dev(&pd_chan->chan),
+		dev_err(dmaengine_chan_dev(&pd_chan->chan),
 			"BUG: handle non-idle channel in tasklet\n");
 		return;
 	}
diff --git a/drivers/dma/pxa_dma.c b/drivers/dma/pxa_dma.c
index fa2ee0b3e09f8..b552b34f2a672 100644
--- a/drivers/dma/pxa_dma.c
+++ b/drivers/dma/pxa_dma.c
@@ -149,7 +149,7 @@ struct pxad_device {
 	({								\
 		u32 _v;							\
 		_v = readl_relaxed((phy)->base + _reg((phy)->idx));	\
-		dev_vdbg(&phy->vchan->vc.chan.dev->device,		\
+		dev_vdbg(vchan_chan_dev(&phy->vchan->vc),		\
 			 "%s(): readl(%s): 0x%08x\n", __func__, #_reg,	\
 			  _v);						\
 		_v;							\
@@ -157,14 +157,14 @@ struct pxad_device {
 #define phy_writel(phy, val, _reg)					\
 	do {								\
 		writel((val), (phy)->base + _reg((phy)->idx));		\
-		dev_vdbg(&phy->vchan->vc.chan.dev->device,		\
+		dev_vdbg(vchan_chan_dev(&phy->vchan->vc),		\
 			 "%s(): writel(0x%08x, %s)\n",			\
 			 __func__, (u32)(val), #_reg);			\
 	} while (0)
 #define phy_writel_relaxed(phy, val, _reg)				\
 	do {								\
 		writel_relaxed((val), (phy)->base + _reg((phy)->idx));	\
-		dev_vdbg(&phy->vchan->vc.chan.dev->device,		\
+		dev_vdbg(vchan_chan_dev(&phy->vchan->vc),		\
 			 "%s(): writel_relaxed(0x%08x, %s)\n",		\
 			 __func__, (u32)(val), #_reg);			\
 	} while (0)
@@ -396,7 +396,7 @@ static struct pxad_phy *lookup_phy(struct pxad_chan *pchan)
 
 out_unlock:
 	spin_unlock_irqrestore(&pdev->phy_lock, flags);
-	dev_dbg(&pchan->vc.chan.dev->device,
+	dev_dbg(vchan_chan_dev(&pchan->vc),
 		"%s(): phy=%p(%d)\n", __func__, found,
 		found ? found->idx : -1);
 
@@ -409,7 +409,7 @@ static void pxad_free_phy(struct pxad_chan *chan)
 	unsigned long flags;
 	u32 reg;
 
-	dev_dbg(&chan->vc.chan.dev->device,
+	dev_dbg(vchan_chan_dev(&chan->vc),
 		"%s(): freeing\n", __func__);
 	if (!chan->phy)
 		return;
@@ -454,7 +454,7 @@ static void phy_enable(struct pxad_phy *phy, bool misaligned)
 	if (!phy->vchan)
 		return;
 
-	dev_dbg(&phy->vchan->vc.chan.dev->device,
+	dev_dbg(vchan_chan_dev(&phy->vchan->vc),
 		"%s(); phy=%p(%d) misaligned=%d\n", __func__,
 		phy, phy->idx, misaligned);
 
@@ -483,7 +483,7 @@ static void phy_disable(struct pxad_phy *phy)
 		return;
 
 	dcsr = phy_readl_relaxed(phy, DCSR);
-	dev_dbg(&phy->vchan->vc.chan.dev->device,
+	dev_dbg(vchan_chan_dev(&phy->vchan->vc),
 		"%s(): phy=%p(%d)\n", __func__, phy, phy->idx);
 	phy_writel(phy, dcsr & ~PXA_DCSR_RUN & ~PXA_DCSR_STOPIRQEN, DCSR);
 }
@@ -491,12 +491,12 @@ static void phy_disable(struct pxad_phy *phy)
 static void pxad_launch_chan(struct pxad_chan *chan,
 				 struct pxad_desc_sw *desc)
 {
-	dev_dbg(&chan->vc.chan.dev->device,
+	dev_dbg(vchan_chan_dev(&chan->vc),
 		"%s(): desc=%p\n", __func__, desc);
 	if (!chan->phy) {
 		chan->phy = lookup_phy(chan);
 		if (!chan->phy) {
-			dev_dbg(&chan->vc.chan.dev->device,
+			dev_dbg(vchan_chan_dev(&chan->vc),
 				"%s(): no free dma channel\n", __func__);
 			return;
 		}
@@ -592,7 +592,7 @@ static unsigned int clear_chan_irq(struct pxad_phy *phy)
 	dcsr = phy_readl_relaxed(phy, DCSR);
 	phy_writel(phy, dcsr, DCSR);
 	if ((dcsr & PXA_DCSR_BUSERR) && (phy->vchan))
-		dev_warn(&phy->vchan->vc.chan.dev->device,
+		dev_warn(vchan_chan_dev(&phy->vchan->vc),
 			 "%s(chan=%p): PXA_DCSR_BUSERR\n",
 			 __func__, &phy->vchan);
 
@@ -617,7 +617,7 @@ static irqreturn_t pxad_chan_handler(int irq, void *dev_id)
 	spin_lock(&chan->vc.lock);
 	list_for_each_entry_safe(vd, tmp, &chan->vc.desc_issued, node) {
 		vd_completed = is_desc_completed(vd);
-		dev_dbg(&chan->vc.chan.dev->device,
+		dev_dbg(vchan_chan_dev(&chan->vc),
 			"%s(): checking txd %p[%x]: completed=%d dcsr=0x%x\n",
 			__func__, vd, vd->tx.cookie, vd_completed,
 			dcsr);
@@ -640,7 +640,7 @@ static irqreturn_t pxad_chan_handler(int irq, void *dev_id)
 	}
 
 	if (!chan->bus_error && dcsr & PXA_DCSR_STOPSTATE) {
-		dev_dbg(&chan->vc.chan.dev->device,
+		dev_dbg(vchan_chan_dev(&chan->vc),
 		"%s(): channel stopped, submitted_empty=%d issued_empty=%d",
 			__func__,
 			list_empty(&chan->vc.desc_submitted),
@@ -694,7 +694,7 @@ static int pxad_alloc_chan_resources(struct dma_chan *dchan)
 					  __alignof__(struct pxad_desc_hw),
 					  0);
 	if (!chan->desc_pool) {
-		dev_err(&chan->vc.chan.dev->device,
+		dev_err(vchan_chan_dev(&chan->vc),
 			"%s(): unable to allocate descriptor pool\n",
 			__func__);
 		return -ENOMEM;
@@ -749,7 +749,7 @@ pxad_alloc_desc(struct pxad_chan *chan, unsigned int nb_hw_desc)
 	for (i = 0; i < nb_hw_desc; i++) {
 		desc = dma_pool_alloc(sw_desc->desc_pool, GFP_NOWAIT, &dma);
 		if (!desc) {
-			dev_err(&chan->vc.chan.dev->device,
+			dev_err(vchan_chan_dev(&chan->vc),
 				"%s(): Couldn't allocate the %dth hw_desc from dma_pool %p\n",
 				__func__, i, sw_desc->desc_pool);
 			goto err;
@@ -786,7 +786,7 @@ static dma_cookie_t pxad_tx_submit(struct dma_async_tx_descriptor *tx)
 
 	if (list_empty(&vc->desc_submitted) && pxad_try_hotchain(vc, vd)) {
 		list_move_tail(&vd->node, &vc->desc_issued);
-		dev_dbg(&chan->vc.chan.dev->device,
+		dev_dbg(vchan_chan_dev(&chan->vc),
 			"%s(): txd %p[%x]: submitted (hot linked)\n",
 			__func__, vd, cookie);
 		goto out;
@@ -809,7 +809,7 @@ static dma_cookie_t pxad_tx_submit(struct dma_async_tx_descriptor *tx)
 		else
 			vd_chained = NULL;
 	}
-	dev_dbg(&chan->vc.chan.dev->device,
+	dev_dbg(vchan_chan_dev(&chan->vc),
 		"%s(): txd %p[%x]: submitted (%s linked)\n",
 		__func__, vd, cookie, vd_chained ? "cold" : "not");
 	list_move_tail(&vd->node, &vc->desc_submitted);
@@ -832,7 +832,7 @@ static void pxad_issue_pending(struct dma_chan *dchan)
 
 	vd_first = list_first_entry(&chan->vc.desc_submitted,
 				    struct virt_dma_desc, node);
-	dev_dbg(&chan->vc.chan.dev->device,
+	dev_dbg(vchan_chan_dev(&chan->vc),
 		"%s(): txd %p[%x]", __func__, vd_first, vd_first->tx.cookie);
 
 	vchan_issue_pending(&chan->vc);
@@ -852,7 +852,7 @@ pxad_tx_prep(struct virt_dma_chan *vc, struct virt_dma_desc *vd,
 	INIT_LIST_HEAD(&vd->node);
 	tx = vchan_tx_prep(vc, vd, tx_flags);
 	tx->tx_submit = pxad_tx_submit;
-	dev_dbg(&chan->vc.chan.dev->device,
+	dev_dbg(vchan_chan_dev(&chan->vc),
 		"%s(): vc=%p txd=%p[%x] flags=0x%lx\n", __func__,
 		vc, vd, vd->tx.cookie,
 		tx_flags);
@@ -891,7 +891,7 @@ static void pxad_get_config(struct pxad_chan *chan,
 		*dcmd |= PXA_DCMD_BURST32 | PXA_DCMD_INCTRGADDR |
 			PXA_DCMD_INCSRCADDR;
 
-	dev_dbg(&chan->vc.chan.dev->device,
+	dev_dbg(vchan_chan_dev(&chan->vc),
 		"%s(): dev_addr=0x%x maxburst=%d width=%d  dir=%d\n",
 		__func__, dev_addr, maxburst, width, dir);
 
@@ -925,7 +925,7 @@ pxad_prep_memcpy(struct dma_chan *dchan,
 	if (!dchan || !len)
 		return NULL;
 
-	dev_dbg(&chan->vc.chan.dev->device,
+	dev_dbg(vchan_chan_dev(&chan->vc),
 		"%s(): dma_dst=0x%lx dma_src=0x%lx len=%zu flags=%lx\n",
 		__func__, (unsigned long)dma_dst, (unsigned long)dma_src,
 		len, flags);
@@ -974,7 +974,7 @@ pxad_prep_slave_sg(struct dma_chan *dchan, struct scatterlist *sgl,
 		return NULL;
 
 	pxad_get_config(chan, dir, &dcmd, &dsadr, &dtadr);
-	dev_dbg(&chan->vc.chan.dev->device,
+	dev_dbg(vchan_chan_dev(&chan->vc),
 		"%s(): dir=%d flags=%lx\n", __func__, dir, flags);
 
 	nb_desc = sg_nents_for_dma(sgl, sg_len, PDMA_MAX_DESC_BYTES);
@@ -1021,7 +1021,7 @@ pxad_prep_dma_cyclic(struct dma_chan *dchan,
 	if (!dchan || !len || !period_len)
 		return NULL;
 	if ((dir != DMA_DEV_TO_MEM) && (dir != DMA_MEM_TO_DEV)) {
-		dev_err(&chan->vc.chan.dev->device,
+		dev_err(vchan_chan_dev(&chan->vc),
 			"Unsupported direction for cyclic DMA\n");
 		return NULL;
 	}
@@ -1032,7 +1032,7 @@ pxad_prep_dma_cyclic(struct dma_chan *dchan,
 
 	pxad_get_config(chan, dir, &dcmd, &dsadr, &dtadr);
 	dcmd |= PXA_DCMD_ENDIRQEN | (PXA_DCMD_LENGTH & period_len);
-	dev_dbg(&chan->vc.chan.dev->device,
+	dev_dbg(vchan_chan_dev(&chan->vc),
 		"%s(): buf_addr=0x%lx len=%zu period=%zu dir=%d flags=%lx\n",
 		__func__, (unsigned long)buf_addr, len, period_len, dir, flags);
 
@@ -1080,14 +1080,14 @@ static int pxad_terminate_all(struct dma_chan *dchan)
 	struct pxad_phy *phy;
 	LIST_HEAD(head);
 
-	dev_dbg(&chan->vc.chan.dev->device,
+	dev_dbg(vchan_chan_dev(&chan->vc),
 		"%s(): vchan %p: terminate all\n", __func__, &chan->vc);
 
 	spin_lock_irqsave(&chan->vc.lock, flags);
 	vchan_get_all_descriptors(&chan->vc, &head);
 
 	list_for_each_entry(vd, &head, node) {
-		dev_dbg(&chan->vc.chan.dev->device,
+		dev_dbg(vchan_chan_dev(&chan->vc),
 			"%s(): cancelling txd %p[%x] (completed=%d)", __func__,
 			vd, vd->tx.cookie, is_desc_completed(vd));
 	}
@@ -1177,7 +1177,7 @@ static unsigned int pxad_residue(struct pxad_chan *chan,
 
 out:
 	spin_unlock_irqrestore(&chan->vc.lock, flags);
-	dev_dbg(&chan->vc.chan.dev->device,
+	dev_dbg(vchan_chan_dev(&chan->vc),
 		"%s(): txd %p[%x] sw_desc=%p: %d\n",
 		__func__, vd, cookie, sw_desc, residue);
 	return residue;
diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index 0d9ffa3e26639..05e797496cae7 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -623,11 +623,6 @@ struct d40_base {
 	struct d40_chan			 phy_chans[];
 };
 
-static struct device *chan2dev(struct d40_chan *d40c)
-{
-	return &d40c->chan.dev->device;
-}
-
 static bool chan_is_physical(struct d40_chan *chan)
 {
 	return chan->log_num == D40_PHY_CHAN;
@@ -648,7 +643,7 @@ static void __iomem *chan_base(struct d40_chan *chan)
 	dev_err(dev, "[%s] " format, __func__, ## arg)
 
 #define chan_err(d40c, format, arg...)		\
-	d40_err(chan2dev(d40c), format, ## arg)
+	d40_err(dmaengine_chan_dev(&d40c->chan), format, ## arg)
 
 static int d40_set_runtime_config_write(struct dma_chan *chan,
 				  struct dma_slave_config *config,
@@ -1243,7 +1238,7 @@ static void __d40_config_set_event(struct d40_chan *d40c,
 		}
 
 		if (tries != 99)
-			dev_dbg(chan2dev(d40c),
+			dev_dbg(dmaengine_chan_dev(&d40c->chan),
 				"[%s] workaround enable S%cLNK (%d tries)\n",
 				__func__, reg == D40_CHAN_REG_SSLNK ? 'S' : 'D',
 				100 - tries);
@@ -1924,7 +1919,7 @@ static int d40_allocate_channel(struct d40_chan *d40c, bool *first_phy_user)
 			i = d40c->dma_cfg.phy_channel;
 
 			if ((i != phy_num) && (i != phy_num + 1)) {
-				dev_err(chan2dev(d40c),
+				dev_err(dmaengine_chan_dev(&d40c->chan),
 					"invalid fixed phy channel %d\n", i);
 				return -EINVAL;
 			}
@@ -1933,7 +1928,7 @@ static int d40_allocate_channel(struct d40_chan *d40c, bool *first_phy_user)
 					       is_log, first_phy_user))
 				goto found_log;
 
-			dev_err(chan2dev(d40c),
+			dev_err(dmaengine_chan_dev(&d40c->chan),
 				"could not allocate fixed phy channel %d\n", i);
 			return -EINVAL;
 		}
@@ -2446,7 +2441,7 @@ static int d40_alloc_chan_resources(struct dma_chan *chan)
 		d40c->dst_def_cfg |= BIT(D40_SREG_CFG_LOG_GIM_POS);
 	}
 
-	dev_dbg(chan2dev(d40c), "allocated %s channel (phy %d%s)\n",
+	dev_dbg(dmaengine_chan_dev(&d40c->chan), "allocated %s channel (phy %d%s)\n",
 		 chan_is_logical(d40c) ? "logical" : "physical",
 		 d40c->phy_chan->num,
 		 d40c->dma_cfg.use_fixed_channel ? ", fixed" : "");
diff --git a/drivers/dma/stm32/stm32-dma.c b/drivers/dma/stm32/stm32-dma.c
index 3e8151e2ad75a..4688cebaf7f7a 100644
--- a/drivers/dma/stm32/stm32-dma.c
+++ b/drivers/dma/stm32/stm32-dma.c
@@ -248,11 +248,6 @@ static struct stm32_dma_desc *to_stm32_dma_desc(struct virt_dma_desc *vdesc)
 	return container_of(vdesc, struct stm32_dma_desc, vdesc);
 }
 
-static struct device *chan2dev(struct stm32_dma_chan *chan)
-{
-	return &chan->vchan.chan.dev->device;
-}
-
 static u32 stm32_dma_read(struct stm32_dma_device *dmadev, u32 reg)
 {
 	return readl_relaxed(dmadev->base + reg);
@@ -274,7 +269,7 @@ static int stm32_dma_get_width(struct stm32_dma_chan *chan,
 	case DMA_SLAVE_BUSWIDTH_4_BYTES:
 		return STM32_DMA_WORD;
 	default:
-		dev_err(chan2dev(chan), "Dma bus width not supported\n");
+		dev_err(vchan_chan_dev(&chan->vchan), "Dma bus width not supported\n");
 		return -EINVAL;
 	}
 }
@@ -374,7 +369,7 @@ static int stm32_dma_get_burst(struct stm32_dma_chan *chan, u32 maxburst)
 	case 16:
 		return STM32_DMA_BURST_INCR16;
 	default:
-		dev_err(chan2dev(chan), "Dma burst size not supported\n");
+		dev_err(vchan_chan_dev(&chan->vchan), "Dma burst size not supported\n");
 		return -EINVAL;
 	}
 }
@@ -487,7 +482,7 @@ static void stm32_dma_stop(struct stm32_dma_chan *chan)
 	/* Clear interrupt status if it is there */
 	status = stm32_dma_irq_status(chan);
 	if (status) {
-		dev_dbg(chan2dev(chan), "%s(): clearing interrupt: 0x%08x\n",
+		dev_dbg(vchan_chan_dev(&chan->vchan), "%s(): clearing interrupt: 0x%08x\n",
 			__func__, status);
 		stm32_dma_irq_clear(chan, status);
 	}
@@ -536,12 +531,12 @@ static void stm32_dma_dump_reg(struct stm32_dma_chan *chan)
 	u32 sm1ar = stm32_dma_read(dmadev, STM32_DMA_SM1AR(chan->id));
 	u32 sfcr = stm32_dma_read(dmadev, STM32_DMA_SFCR(chan->id));
 
-	dev_dbg(chan2dev(chan), "SCR:   0x%08x\n", scr);
-	dev_dbg(chan2dev(chan), "NDTR:  0x%08x\n", ndtr);
-	dev_dbg(chan2dev(chan), "SPAR:  0x%08x\n", spar);
-	dev_dbg(chan2dev(chan), "SM0AR: 0x%08x\n", sm0ar);
-	dev_dbg(chan2dev(chan), "SM1AR: 0x%08x\n", sm1ar);
-	dev_dbg(chan2dev(chan), "SFCR:  0x%08x\n", sfcr);
+	dev_dbg(vchan_chan_dev(&chan->vchan), "SCR:   0x%08x\n", scr);
+	dev_dbg(vchan_chan_dev(&chan->vchan), "NDTR:  0x%08x\n", ndtr);
+	dev_dbg(vchan_chan_dev(&chan->vchan), "SPAR:  0x%08x\n", spar);
+	dev_dbg(vchan_chan_dev(&chan->vchan), "SM0AR: 0x%08x\n", sm0ar);
+	dev_dbg(vchan_chan_dev(&chan->vchan), "SM1AR: 0x%08x\n", sm1ar);
+	dev_dbg(vchan_chan_dev(&chan->vchan), "SFCR:  0x%08x\n", sfcr);
 }
 
 static void stm32_dma_sg_inc(struct stm32_dma_chan *chan)
@@ -613,7 +608,7 @@ static void stm32_dma_start_transfer(struct stm32_dma_chan *chan)
 	reg->dma_scr |= STM32_DMA_SCR_EN;
 	stm32_dma_write(dmadev, STM32_DMA_SCR(chan->id), reg->dma_scr);
 
-	dev_dbg(chan2dev(chan), "vchan %p: started\n", &chan->vchan);
+	dev_dbg(vchan_chan_dev(&chan->vchan), "vchan %p: started\n", &chan->vchan);
 }
 
 static void stm32_dma_configure_next_sg(struct stm32_dma_chan *chan)
@@ -630,12 +625,12 @@ static void stm32_dma_configure_next_sg(struct stm32_dma_chan *chan)
 	if (dma_scr & STM32_DMA_SCR_CT) {
 		dma_sm0ar = sg_req->chan_reg.dma_sm0ar;
 		stm32_dma_write(dmadev, STM32_DMA_SM0AR(id), dma_sm0ar);
-		dev_dbg(chan2dev(chan), "CT=1 <=> SM0AR: 0x%08x\n",
+		dev_dbg(vchan_chan_dev(&chan->vchan), "CT=1 <=> SM0AR: 0x%08x\n",
 			stm32_dma_read(dmadev, STM32_DMA_SM0AR(id)));
 	} else {
 		dma_sm1ar = sg_req->chan_reg.dma_sm1ar;
 		stm32_dma_write(dmadev, STM32_DMA_SM1AR(id), dma_sm1ar);
-		dev_dbg(chan2dev(chan), "CT=0 <=> SM1AR: 0x%08x\n",
+		dev_dbg(vchan_chan_dev(&chan->vchan), "CT=0 <=> SM1AR: 0x%08x\n",
 			stm32_dma_read(dmadev, STM32_DMA_SM1AR(id)));
 	}
 }
@@ -676,7 +671,7 @@ static void stm32_dma_handle_chan_paused(struct stm32_dma_chan *chan)
 
 	chan->status = DMA_PAUSED;
 
-	dev_dbg(chan2dev(chan), "vchan %p: paused\n", &chan->vchan);
+	dev_dbg(vchan_chan_dev(&chan->vchan), "vchan %p: paused\n", &chan->vchan);
 }
 
 static void stm32_dma_post_resume_reconfigure(struct stm32_dma_chan *chan)
@@ -728,7 +723,7 @@ static void stm32_dma_post_resume_reconfigure(struct stm32_dma_chan *chan)
 	dma_scr |= STM32_DMA_SCR_EN;
 	stm32_dma_write(dmadev, STM32_DMA_SCR(chan->id), dma_scr);
 
-	dev_dbg(chan2dev(chan), "vchan %p: reconfigured after pause/resume\n", &chan->vchan);
+	dev_dbg(vchan_chan_dev(&chan->vchan), "vchan %p: reconfigured after pause/resume\n", &chan->vchan);
 }
 
 static void stm32_dma_handle_chan_done(struct stm32_dma_chan *chan, u32 scr)
@@ -775,16 +770,16 @@ static irqreturn_t stm32_dma_chan_irq(int irq, void *devid)
 		if (sfcr & STM32_DMA_SFCR_FEIE) {
 			if (!(scr & STM32_DMA_SCR_EN) &&
 			    !(status & STM32_DMA_TCI))
-				dev_err(chan2dev(chan), "FIFO Error\n");
+				dev_err(vchan_chan_dev(&chan->vchan), "FIFO Error\n");
 			else
-				dev_dbg(chan2dev(chan), "FIFO over/underrun\n");
+				dev_dbg(vchan_chan_dev(&chan->vchan), "FIFO over/underrun\n");
 		}
 	}
 	if (status & STM32_DMA_DMEI) {
 		stm32_dma_irq_clear(chan, STM32_DMA_DMEI);
 		status &= ~STM32_DMA_DMEI;
 		if (sfcr & STM32_DMA_SCR_DMEIE)
-			dev_dbg(chan2dev(chan), "Direct mode overrun\n");
+			dev_dbg(vchan_chan_dev(&chan->vchan), "Direct mode overrun\n");
 	}
 
 	if (status & STM32_DMA_TCI) {
@@ -803,9 +798,9 @@ static irqreturn_t stm32_dma_chan_irq(int irq, void *devid)
 
 	if (status) {
 		stm32_dma_irq_clear(chan, status);
-		dev_err(chan2dev(chan), "DMA error: status=0x%08x\n", status);
+		dev_err(vchan_chan_dev(&chan->vchan), "DMA error: status=0x%08x\n", status);
 		if (!(scr & STM32_DMA_SCR_EN))
-			dev_err(chan2dev(chan), "chan disabled by HW\n");
+			dev_err(vchan_chan_dev(&chan->vchan), "chan disabled by HW\n");
 	}
 
 	spin_unlock(&chan->vchan.lock);
@@ -820,7 +815,7 @@ static void stm32_dma_issue_pending(struct dma_chan *c)
 
 	spin_lock_irqsave(&chan->vchan.lock, flags);
 	if (vchan_issue_pending(&chan->vchan) && !chan->desc && !chan->busy) {
-		dev_dbg(chan2dev(chan), "vchan %p: issued\n", &chan->vchan);
+		dev_dbg(vchan_chan_dev(&chan->vchan), "vchan %p: issued\n", &chan->vchan);
 		stm32_dma_start_transfer(chan);
 
 	}
@@ -922,7 +917,7 @@ static int stm32_dma_resume(struct dma_chan *c)
 
 	spin_unlock_irqrestore(&chan->vchan.lock, flags);
 
-	dev_dbg(chan2dev(chan), "vchan %p: resumed\n", &chan->vchan);
+	dev_dbg(vchan_chan_dev(&chan->vchan), "vchan %p: resumed\n", &chan->vchan);
 
 	return 0;
 }
@@ -1059,7 +1054,7 @@ static int stm32_dma_set_xfer_param(struct stm32_dma_chan *chan,
 		break;
 
 	default:
-		dev_err(chan2dev(chan), "Dma direction is not supported\n");
+		dev_err(vchan_chan_dev(&chan->vchan), "Dma direction is not supported\n");
 		return -EINVAL;
 	}
 
@@ -1092,12 +1087,12 @@ static struct dma_async_tx_descriptor *stm32_dma_prep_slave_sg(
 	int i, ret;
 
 	if (!chan->config_init) {
-		dev_err(chan2dev(chan), "dma channel is not configured\n");
+		dev_err(vchan_chan_dev(&chan->vchan), "dma channel is not configured\n");
 		return NULL;
 	}
 
 	if (sg_len < 1) {
-		dev_err(chan2dev(chan), "Invalid segment length %d\n", sg_len);
+		dev_err(vchan_chan_dev(&chan->vchan), "Invalid segment length %d\n", sg_len);
 		return NULL;
 	}
 
@@ -1129,7 +1124,7 @@ static struct dma_async_tx_descriptor *stm32_dma_prep_slave_sg(
 
 		nb_data_items = desc->sg_req[i].len / buswidth;
 		if (nb_data_items > STM32_DMA_ALIGNED_MAX_DATA_ITEMS) {
-			dev_err(chan2dev(chan), "nb items not supported\n");
+			dev_err(vchan_chan_dev(&chan->vchan), "nb items not supported\n");
 			goto err;
 		}
 
@@ -1164,17 +1159,17 @@ static struct dma_async_tx_descriptor *stm32_dma_prep_dma_cyclic(
 	int i, ret;
 
 	if (!buf_len || !period_len) {
-		dev_err(chan2dev(chan), "Invalid buffer/period len\n");
+		dev_err(vchan_chan_dev(&chan->vchan), "Invalid buffer/period len\n");
 		return NULL;
 	}
 
 	if (!chan->config_init) {
-		dev_err(chan2dev(chan), "dma channel is not configured\n");
+		dev_err(vchan_chan_dev(&chan->vchan), "dma channel is not configured\n");
 		return NULL;
 	}
 
 	if (buf_len % period_len) {
-		dev_err(chan2dev(chan), "buf_len not multiple of period_len\n");
+		dev_err(vchan_chan_dev(&chan->vchan), "buf_len not multiple of period_len\n");
 		return NULL;
 	}
 
@@ -1185,7 +1180,7 @@ static struct dma_async_tx_descriptor *stm32_dma_prep_dma_cyclic(
 	 * terminating the DMA.
 	 */
 	if (chan->busy) {
-		dev_err(chan2dev(chan), "Request not allowed when dma busy\n");
+		dev_err(vchan_chan_dev(&chan->vchan), "Request not allowed when dma busy\n");
 		return NULL;
 	}
 
@@ -1196,7 +1191,7 @@ static struct dma_async_tx_descriptor *stm32_dma_prep_dma_cyclic(
 
 	nb_data_items = period_len / buswidth;
 	if (nb_data_items > STM32_DMA_ALIGNED_MAX_DATA_ITEMS) {
-		dev_err(chan2dev(chan), "number of items not supported\n");
+		dev_err(vchan_chan_dev(&chan->vchan), "number of items not supported\n");
 		return NULL;
 	}
 
@@ -1478,7 +1473,7 @@ static void stm32_dma_free_chan_resources(struct dma_chan *c)
 	struct stm32_dma_device *dmadev = stm32_dma_get_dev(chan);
 	unsigned long flags;
 
-	dev_dbg(chan2dev(chan), "Freeing channel %d\n", chan->id);
+	dev_dbg(vchan_chan_dev(&chan->vchan), "Freeing channel %d\n", chan->id);
 
 	if (chan->busy) {
 		spin_lock_irqsave(&chan->vchan.lock, flags);
diff --git a/drivers/dma/stm32/stm32-dma3.c b/drivers/dma/stm32/stm32-dma3.c
index 6ee7a1435efb6..4fe226541efa4 100644
--- a/drivers/dma/stm32/stm32-dma3.c
+++ b/drivers/dma/stm32/stm32-dma3.c
@@ -328,11 +328,6 @@ static inline struct stm32_dma3_swdesc *to_stm32_dma3_swdesc(struct virt_dma_des
 	return container_of(vdesc, struct stm32_dma3_swdesc, vdesc);
 }
 
-static struct device *chan2dev(struct stm32_dma3_chan *chan)
-{
-	return &chan->vchan.chan.dev->device;
-}
-
 static struct device *ddata2dev(struct stm32_dma3_ddata *ddata)
 {
 	return ddata->dma_dev.dev;
@@ -341,7 +336,7 @@ static struct device *ddata2dev(struct stm32_dma3_ddata *ddata)
 static void stm32_dma3_chan_dump_reg(struct stm32_dma3_chan *chan)
 {
 	struct stm32_dma3_ddata *ddata = to_stm32_dma3_ddata(chan);
-	struct device *dev = chan2dev(chan);
+	struct device *dev = vchan_chan_dev(&chan->vchan);
 	u32 id = chan->id, offset;
 
 	offset = STM32_DMA3_SECCFGR;
@@ -381,21 +376,21 @@ static void stm32_dma3_chan_dump_hwdesc(struct stm32_dma3_chan *chan,
 	for (i = 0; i < swdesc->lli_size; i++) {
 		hwdesc = swdesc->lli[i].hwdesc;
 		if (i)
-			dev_dbg(chan2dev(chan), "V\n");
-		dev_dbg(chan2dev(chan), "[%d]@%pad\n", i, &swdesc->lli[i].hwdesc_addr);
-		dev_dbg(chan2dev(chan), "| C%dTR1: %08x\n", chan->id, hwdesc->ctr1);
-		dev_dbg(chan2dev(chan), "| C%dTR2: %08x\n", chan->id, hwdesc->ctr2);
-		dev_dbg(chan2dev(chan), "| C%dBR1: %08x\n", chan->id, hwdesc->cbr1);
-		dev_dbg(chan2dev(chan), "| C%dSAR: %08x\n", chan->id, hwdesc->csar);
-		dev_dbg(chan2dev(chan), "| C%dDAR: %08x\n", chan->id, hwdesc->cdar);
-		dev_dbg(chan2dev(chan), "| C%dLLR: %08x\n", chan->id, hwdesc->cllr);
+			dev_dbg(vchan_chan_dev(&chan->vchan), "V\n");
+		dev_dbg(vchan_chan_dev(&chan->vchan), "[%d]@%pad\n", i, &swdesc->lli[i].hwdesc_addr);
+		dev_dbg(vchan_chan_dev(&chan->vchan), "| C%dTR1: %08x\n", chan->id, hwdesc->ctr1);
+		dev_dbg(vchan_chan_dev(&chan->vchan), "| C%dTR2: %08x\n", chan->id, hwdesc->ctr2);
+		dev_dbg(vchan_chan_dev(&chan->vchan), "| C%dBR1: %08x\n", chan->id, hwdesc->cbr1);
+		dev_dbg(vchan_chan_dev(&chan->vchan), "| C%dSAR: %08x\n", chan->id, hwdesc->csar);
+		dev_dbg(vchan_chan_dev(&chan->vchan), "| C%dDAR: %08x\n", chan->id, hwdesc->cdar);
+		dev_dbg(vchan_chan_dev(&chan->vchan), "| C%dLLR: %08x\n", chan->id, hwdesc->cllr);
 	}
 
 	if (swdesc->cyclic) {
-		dev_dbg(chan2dev(chan), "|\n");
-		dev_dbg(chan2dev(chan), "-->[0]@%pad\n", &swdesc->lli[0].hwdesc_addr);
+		dev_dbg(vchan_chan_dev(&chan->vchan), "|\n");
+		dev_dbg(vchan_chan_dev(&chan->vchan), "-->[0]@%pad\n", &swdesc->lli[0].hwdesc_addr);
 	} else {
-		dev_dbg(chan2dev(chan), "X\n");
+		dev_dbg(vchan_chan_dev(&chan->vchan), "X\n");
 	}
 }
 
@@ -411,7 +406,7 @@ static struct stm32_dma3_swdesc *stm32_dma3_chan_desc_alloc(struct stm32_dma3_ch
 	 * addressed, so abort the allocation.
 	 */
 	if ((count * 32) > CLLR_LA) {
-		dev_err(chan2dev(chan), "Transfer is too big (> %luB)\n", STM32_DMA3_MAX_SEG_SIZE);
+		dev_err(vchan_chan_dev(&chan->vchan), "Transfer is too big (> %luB)\n", STM32_DMA3_MAX_SEG_SIZE);
 		return NULL;
 	}
 
@@ -438,7 +433,7 @@ static struct stm32_dma3_swdesc *stm32_dma3_chan_desc_alloc(struct stm32_dma3_ch
 	return swdesc;
 
 err_pool_free:
-	dev_err(chan2dev(chan), "Failed to alloc descriptors\n");
+	dev_err(vchan_chan_dev(&chan->vchan), "Failed to alloc descriptors\n");
 	while (--i >= 0)
 		dma_pool_free(chan->lli_pool, swdesc->lli[i].hwdesc, swdesc->lli[i].hwdesc_addr);
 	kfree(swdesc);
@@ -468,7 +463,7 @@ static void stm32_dma3_chan_vdesc_free(struct virt_dma_desc *vdesc)
 static void stm32_dma3_check_user_setting(struct stm32_dma3_chan *chan)
 {
 	struct stm32_dma3_ddata *ddata = to_stm32_dma3_ddata(chan);
-	struct device *dev = chan2dev(chan);
+	struct device *dev = vchan_chan_dev(&chan->vchan);
 	u32 ctr1 = readl_relaxed(ddata->base + STM32_DMA3_CTR1(chan->id));
 	u32 cbr1 = readl_relaxed(ddata->base + STM32_DMA3_CBR1(chan->id));
 	u32 csar = readl_relaxed(ddata->base + STM32_DMA3_CSAR(chan->id));
@@ -579,7 +574,7 @@ static int stm32_dma3_chan_prep_hw(struct stm32_dma3_chan *chan, enum dma_transf
 	u32 sap = FIELD_GET(STM32_DMA3_DT_SAP, tr_conf), sap_max_dw;
 	u32 dap = FIELD_GET(STM32_DMA3_DT_DAP, tr_conf), dap_max_dw;
 
-	dev_dbg(chan2dev(chan), "%s from %pad to %pad\n",
+	dev_dbg(vchan_chan_dev(&chan->vchan), "%s from %pad to %pad\n",
 		dmaengine_get_direction_text(dir), &src_addr, &dst_addr);
 
 	sdw = chan->dma_config.src_addr_width ? : get_chan_max_dw(sap, chan->max_burst);
@@ -589,12 +584,12 @@ static int stm32_dma3_chan_prep_hw(struct stm32_dma3_chan *chan, enum dma_transf
 
 	/* Following conditions would raise User Setting Error interrupt */
 	if (!(dma_device.src_addr_widths & BIT(sdw)) || !(dma_device.dst_addr_widths & BIT(ddw))) {
-		dev_err(chan2dev(chan), "Bus width (src=%u, dst=%u) not supported\n", sdw, ddw);
+		dev_err(vchan_chan_dev(&chan->vchan), "Bus width (src=%u, dst=%u) not supported\n", sdw, ddw);
 		return -EINVAL;
 	}
 
 	if (ddata->ports_max_dw[1] == DW_INVALID && (sap || dap)) {
-		dev_err(chan2dev(chan), "Only one master port, port 1 is not supported\n");
+		dev_err(vchan_chan_dev(&chan->vchan), "Only one master port, port 1 is not supported\n");
 		return -EINVAL;
 	}
 
@@ -602,7 +597,7 @@ static int stm32_dma3_chan_prep_hw(struct stm32_dma3_chan *chan, enum dma_transf
 	dap_max_dw = ddata->ports_max_dw[dap];
 	if ((port_is_ahb(sap_max_dw) && sdw == DMA_SLAVE_BUSWIDTH_8_BYTES) ||
 	    (port_is_ahb(dap_max_dw) && ddw == DMA_SLAVE_BUSWIDTH_8_BYTES)) {
-		dev_err(chan2dev(chan),
+		dev_err(vchan_chan_dev(&chan->vchan),
 			"8 bytes buswidth (src=%u, dst=%u) not supported on port (sap=%u, dap=%u\n",
 			sdw, ddw, sap, dap);
 		return -EINVAL;
@@ -659,7 +654,7 @@ static int stm32_dma3_chan_prep_hw(struct stm32_dma3_chan *chan, enum dma_transf
 			_ctr1 |= FIELD_PREP(CTR1_PAM, CTR1_PAM_PACK_UNPACK);
 			/* Should never reach this case as ddw is clamped down */
 			if (len & (ddw - 1)) {
-				dev_err(chan2dev(chan),
+				dev_err(vchan_chan_dev(&chan->vchan),
 					"Packing mode is enabled and len is not multiple of ddw");
 				return -EINVAL;
 			}
@@ -695,7 +690,7 @@ static int stm32_dma3_chan_prep_hw(struct stm32_dma3_chan *chan, enum dma_transf
 			_ctr1 |= FIELD_PREP(CTR1_PAM, CTR1_PAM_PACK_UNPACK);
 			/* Should never reach this case as ddw is clamped down */
 			if (len & (ddw - 1)) {
-				dev_err(chan2dev(chan),
+				dev_err(vchan_chan_dev(&chan->vchan),
 					"Packing mode is enabled and len is not multiple of ddw\n");
 				return -EINVAL;
 			}
@@ -740,7 +735,7 @@ static int stm32_dma3_chan_prep_hw(struct stm32_dma3_chan *chan, enum dma_transf
 			_ctr1 |= FIELD_PREP(CTR1_PAM, CTR1_PAM_PACK_UNPACK);
 			/* Should never reach this case as ddw is clamped down */
 			if (len & (ddw - 1)) {
-				dev_err(chan2dev(chan),
+				dev_err(vchan_chan_dev(&chan->vchan),
 					"Packing mode is enabled and len is not multiple of ddw");
 				return -EINVAL;
 			}
@@ -752,7 +747,7 @@ static int stm32_dma3_chan_prep_hw(struct stm32_dma3_chan *chan, enum dma_transf
 		break;
 
 	default:
-		dev_err(chan2dev(chan), "Direction %s not supported\n",
+		dev_err(vchan_chan_dev(&chan->vchan), "Direction %s not supported\n",
 			dmaengine_get_direction_text(dir));
 		return -EINVAL;
 	}
@@ -761,7 +756,7 @@ static int stm32_dma3_chan_prep_hw(struct stm32_dma3_chan *chan, enum dma_transf
 	*ctr1 = _ctr1;
 	*ctr2 = _ctr2;
 
-	dev_dbg(chan2dev(chan), "%s: sdw=%u bytes sbl=%u beats ddw=%u bytes dbl=%u beats\n",
+	dev_dbg(vchan_chan_dev(&chan->vchan), "%s: sdw=%u bytes sbl=%u beats ddw=%u bytes dbl=%u beats\n",
 		__func__, sdw, sbl_max, ddw, dbl_max);
 
 	return 0;
@@ -807,7 +802,7 @@ static void stm32_dma3_chan_start(struct stm32_dma3_chan *chan)
 
 	chan->dma_status = DMA_IN_PROGRESS;
 
-	dev_dbg(chan2dev(chan), "vchan %p: started\n", &chan->vchan);
+	dev_dbg(vchan_chan_dev(&chan->vchan), "vchan %p: started\n", &chan->vchan);
 }
 
 static int stm32_dma3_chan_suspend(struct stm32_dma3_chan *chan, bool susp)
@@ -871,7 +866,7 @@ static void stm32_dma3_chan_set_residue(struct stm32_dma3_chan *chan,
 					struct dma_tx_state *txstate)
 {
 	struct stm32_dma3_ddata *ddata = to_stm32_dma3_ddata(chan);
-	struct device *dev = chan2dev(chan);
+	struct device *dev = vchan_chan_dev(&chan->vchan);
 	struct stm32_dma3_hwdesc *hwdesc;
 	u32 residue, curr_lli, csr, cdar, cbr1, cllr, bndt, fifol;
 	bool pack_unpack;
@@ -921,7 +916,7 @@ static void stm32_dma3_chan_set_residue(struct stm32_dma3_chan *chan,
 	/* Get current hwdesc and cumulate residue of pending hwdesc BNDT */
 	ret = stm32_dma3_chan_get_curr_hwdesc(swdesc, cllr, &residue);
 	if (ret < 0) {
-		dev_err(chan2dev(chan), "Can't get residue: current hwdesc not found\n");
+		dev_err(vchan_chan_dev(&chan->vchan), "Can't get residue: current hwdesc not found\n");
 		return;
 	}
 	curr_lli = ret;
@@ -957,7 +952,7 @@ static void stm32_dma3_chan_set_residue(struct stm32_dma3_chan *chan,
 
 skip_fifol_update:
 	if (fifol) {
-		dev_dbg(chan2dev(chan), "%u byte(s) in the FIFO\n", fifol);
+		dev_dbg(vchan_chan_dev(&chan->vchan), "%u byte(s) in the FIFO\n", fifol);
 		dma_set_in_flight_bytes(txstate, fifol);
 		/*
 		 * Residue is already accurate for DMA_MEM_TO_DEV as BNDT reflects data read from
@@ -987,7 +982,7 @@ static int stm32_dma3_chan_stop(struct stm32_dma3_chan *chan)
 		/* Suspend the channel */
 		ret = stm32_dma3_chan_suspend(chan, true);
 		if (ret)
-			dev_warn(chan2dev(chan), "%s: timeout, data might be lost\n", __func__);
+			dev_warn(vchan_chan_dev(&chan->vchan), "%s: timeout, data might be lost\n", __func__);
 	}
 
 	/*
@@ -1034,7 +1029,7 @@ static irqreturn_t stm32_dma3_chan_irq(int irq, void *devid)
 	}
 
 	if (csr & CSR_USEF && ccr & CCR_USEIE) {
-		dev_err(chan2dev(chan), "User setting error\n");
+		dev_err(vchan_chan_dev(&chan->vchan), "User setting error\n");
 		chan->dma_status = DMA_ERROR;
 		/* CCR.EN automatically cleared by HW */
 		stm32_dma3_check_user_setting(chan);
@@ -1042,14 +1037,14 @@ static irqreturn_t stm32_dma3_chan_irq(int irq, void *devid)
 	}
 
 	if (csr & CSR_ULEF && ccr & CCR_ULEIE) {
-		dev_err(chan2dev(chan), "Update link transfer error\n");
+		dev_err(vchan_chan_dev(&chan->vchan), "Update link transfer error\n");
 		chan->dma_status = DMA_ERROR;
 		/* CCR.EN automatically cleared by HW */
 		stm32_dma3_chan_reset(chan);
 	}
 
 	if (csr & CSR_DTEF && ccr & CCR_DTEIE) {
-		dev_err(chan2dev(chan), "Data transfer error\n");
+		dev_err(vchan_chan_dev(&chan->vchan), "Data transfer error\n");
 		chan->dma_status = DMA_ERROR;
 		/* CCR.EN automatically cleared by HW */
 		stm32_dma3_chan_reset(chan);
@@ -1087,13 +1082,13 @@ static int stm32_dma3_get_chan_sem(struct stm32_dma3_chan *chan)
 		goto bad_cid;
 
 	chan->semaphore_taken = true;
-	dev_dbg(chan2dev(chan), "under CID1 control (semcr=0x%08x)\n", csemcr);
+	dev_dbg(vchan_chan_dev(&chan->vchan), "under CID1 control (semcr=0x%08x)\n", csemcr);
 
 	return 0;
 
 bad_cid:
 	chan->semaphore_taken = false;
-	dev_err(chan2dev(chan), "not under CID1 control (in-use by CID%d)\n", ccid);
+	dev_err(vchan_chan_dev(&chan->vchan), "not under CID1 control (in-use by CID%d)\n", ccid);
 
 	return -EACCES;
 }
@@ -1105,7 +1100,7 @@ static void stm32_dma3_put_chan_sem(struct stm32_dma3_chan *chan)
 	if (chan->semaphore_taken) {
 		writel_relaxed(0, ddata->base + STM32_DMA3_CSEMCR(chan->id));
 		chan->semaphore_taken = false;
-		dev_dbg(chan2dev(chan), "no more under CID1 control\n");
+		dev_dbg(vchan_chan_dev(&chan->vchan), "no more under CID1 control\n");
 	}
 }
 
@@ -1130,7 +1125,7 @@ static int stm32_dma3_alloc_chan_resources(struct dma_chan *c)
 					  sizeof(struct stm32_dma3_hwdesc),
 					  __alignof__(struct stm32_dma3_hwdesc), SZ_64K);
 	if (!chan->lli_pool) {
-		dev_err(chan2dev(chan), "Failed to create LLI pool\n");
+		dev_err(vchan_chan_dev(&chan->vchan), "Failed to create LLI pool\n");
 		ret = -ENOMEM;
 		goto err_put_sync;
 	}
@@ -1366,7 +1361,7 @@ static struct dma_async_tx_descriptor *stm32_dma3_prep_slave_sg(struct dma_chan
 	}
 
 	if (count != sg_len && chan->tcem != CTR2_TCEM_CHANNEL)
-		dev_warn(chan2dev(chan), "Linked-list refactored, %d items instead of %d\n",
+		dev_warn(vchan_chan_dev(&chan->vchan), "Linked-list refactored, %d items instead of %d\n",
 			 count, sg_len);
 
 	/* Enable Error interrupts */
@@ -1401,12 +1396,12 @@ static struct dma_async_tx_descriptor *stm32_dma3_prep_dma_cyclic(struct dma_cha
 		return NULL;
 
 	if (!buf_len || !period_len || period_len > STM32_DMA3_MAX_BLOCK_SIZE) {
-		dev_err(chan2dev(chan), "Invalid buffer/period length\n");
+		dev_err(vchan_chan_dev(&chan->vchan), "Invalid buffer/period length\n");
 		return NULL;
 	}
 
 	if (buf_len % period_len) {
-		dev_err(chan2dev(chan), "Buffer length not multiple of period length\n");
+		dev_err(vchan_chan_dev(&chan->vchan), "Buffer length not multiple of period length\n");
 		return NULL;
 	}
 
@@ -1428,7 +1423,7 @@ static struct dma_async_tx_descriptor *stm32_dma3_prep_dma_cyclic(struct dma_cha
 		ret = stm32_dma3_chan_prep_hw(chan, DMA_DEV_TO_MEM, &swdesc->ccr, &ctr1, &ctr2,
 					      src, dst, period_len);
 	} else {
-		dev_err(chan2dev(chan), "Invalid direction\n");
+		dev_err(vchan_chan_dev(&chan->vchan), "Invalid direction\n");
 		ret = -EINVAL;
 	}
 
@@ -1502,7 +1497,7 @@ static int stm32_dma3_pause(struct dma_chan *c)
 
 	chan->dma_status = DMA_PAUSED;
 
-	dev_dbg(chan2dev(chan), "vchan %p: paused\n", &chan->vchan);
+	dev_dbg(vchan_chan_dev(&chan->vchan), "vchan %p: paused\n", &chan->vchan);
 
 	return 0;
 }
@@ -1515,7 +1510,7 @@ static int stm32_dma3_resume(struct dma_chan *c)
 
 	chan->dma_status = DMA_IN_PROGRESS;
 
-	dev_dbg(chan2dev(chan), "vchan %p: resumed\n", &chan->vchan);
+	dev_dbg(vchan_chan_dev(&chan->vchan), "vchan %p: resumed\n", &chan->vchan);
 
 	return 0;
 }
@@ -1540,7 +1535,7 @@ static int stm32_dma3_terminate_all(struct dma_chan *c)
 	spin_unlock_irqrestore(&chan->vchan.lock, flags);
 	vchan_dma_desc_free_list(&chan->vchan, &head);
 
-	dev_dbg(chan2dev(chan), "vchan %p: terminated\n", &chan->vchan);
+	dev_dbg(vchan_chan_dev(&chan->vchan), "vchan %p: terminated\n", &chan->vchan);
 
 	return 0;
 }
@@ -1593,7 +1588,7 @@ static void stm32_dma3_issue_pending(struct dma_chan *c)
 	spin_lock_irqsave(&chan->vchan.lock, flags);
 
 	if (vchan_issue_pending(&chan->vchan) && !chan->swdesc) {
-		dev_dbg(chan2dev(chan), "vchan %p: issued\n", &chan->vchan);
+		dev_dbg(vchan_chan_dev(&chan->vchan), "vchan %p: issued\n", &chan->vchan);
 		stm32_dma3_chan_start(chan);
 	}
 
diff --git a/drivers/dma/stm32/stm32-mdma.c b/drivers/dma/stm32/stm32-mdma.c
index c6dc8a9a7a288..04639e4b554ea 100644
--- a/drivers/dma/stm32/stm32-mdma.c
+++ b/drivers/dma/stm32/stm32-mdma.c
@@ -276,11 +276,6 @@ static struct stm32_mdma_desc *to_stm32_mdma_desc(struct virt_dma_desc *vdesc)
 	return container_of(vdesc, struct stm32_mdma_desc, vdesc);
 }
 
-static struct device *chan2dev(struct stm32_mdma_chan *chan)
-{
-	return &chan->vchan.chan.dev->device;
-}
-
 static struct device *mdma2dev(struct stm32_mdma_device *mdma_dev)
 {
 	return mdma_dev->ddev.dev;
@@ -334,7 +329,7 @@ static struct stm32_mdma_desc *stm32_mdma_alloc_desc(
 	return desc;
 
 err:
-	dev_err(chan2dev(chan), "Failed to allocate descriptor\n");
+	dev_err(vchan_chan_dev(&chan->vchan), "Failed to allocate descriptor\n");
 	while (--i >= 0)
 		dma_pool_free(chan->desc_pool, desc->node[i].hwdesc,
 			      desc->node[i].hwdesc_phys);
@@ -364,7 +359,7 @@ static int stm32_mdma_get_width(struct stm32_mdma_chan *chan,
 	case DMA_SLAVE_BUSWIDTH_8_BYTES:
 		return ffs(width) - 1;
 	default:
-		dev_err(chan2dev(chan), "Dma bus width %i not supported\n",
+		dev_err(vchan_chan_dev(&chan->vchan), "Dma bus width %i not supported\n",
 			width);
 		return -EINVAL;
 	}
@@ -422,7 +417,7 @@ static int stm32_mdma_disable_chan(struct stm32_mdma_chan *chan)
 				dmadev->base + STM32_MDMA_CISR(id), cisr,
 				(cisr & STM32_MDMA_CISR_CTCIF), 10, 1000);
 		if (ret) {
-			dev_err(chan2dev(chan), "%s: timeout!\n", __func__);
+			dev_err(vchan_chan_dev(&chan->vchan), "%s: timeout!\n", __func__);
 			return -EBUSY;
 		}
 	}
@@ -444,7 +439,7 @@ static void stm32_mdma_stop(struct stm32_mdma_chan *chan)
 	/* Clear interrupt status if it is there */
 	status = stm32_mdma_read(dmadev, STM32_MDMA_CISR(chan->id));
 	if (status) {
-		dev_dbg(chan2dev(chan), "%s(): clearing interrupt: 0x%08x\n",
+		dev_dbg(vchan_chan_dev(&chan->vchan), "%s(): clearing interrupt: 0x%08x\n",
 			__func__, status);
 		stm32_mdma_set_bits(dmadev, STM32_MDMA_CIFCR(chan->id), status);
 	}
@@ -513,7 +508,7 @@ static int stm32_mdma_set_xfer_param(struct stm32_mdma_chan *chan,
 	/* Check burst size constraints */
 	if (src_maxburst * src_addr_width > STM32_MDMA_MAX_BURST ||
 	    dst_maxburst * dst_addr_width > STM32_MDMA_MAX_BURST) {
-		dev_err(chan2dev(chan),
+		dev_err(vchan_chan_dev(&chan->vchan),
 			"burst size * bus width higher than %d bytes\n",
 			STM32_MDMA_MAX_BURST);
 		return -EINVAL;
@@ -521,7 +516,7 @@ static int stm32_mdma_set_xfer_param(struct stm32_mdma_chan *chan,
 
 	if ((!is_power_of_2(src_maxburst) && src_maxburst > 0) ||
 	    (!is_power_of_2(dst_maxburst) && dst_maxburst > 0)) {
-		dev_err(chan2dev(chan), "burst size must be a power of 2\n");
+		dev_err(vchan_chan_dev(&chan->vchan), "burst size must be a power of 2\n");
 		return -EINVAL;
 	}
 
@@ -658,7 +653,7 @@ static int stm32_mdma_set_xfer_param(struct stm32_mdma_chan *chan,
 		break;
 
 	default:
-		dev_err(chan2dev(chan), "Dma direction is not supported\n");
+		dev_err(vchan_chan_dev(&chan->vchan), "Dma direction is not supported\n");
 		return -EINVAL;
 	}
 
@@ -672,16 +667,16 @@ static int stm32_mdma_set_xfer_param(struct stm32_mdma_chan *chan,
 static void stm32_mdma_dump_hwdesc(struct stm32_mdma_chan *chan,
 				   struct stm32_mdma_desc_node *node)
 {
-	dev_dbg(chan2dev(chan), "hwdesc:  %pad\n", &node->hwdesc_phys);
-	dev_dbg(chan2dev(chan), "CTCR:    0x%08x\n", node->hwdesc->ctcr);
-	dev_dbg(chan2dev(chan), "CBNDTR:  0x%08x\n", node->hwdesc->cbndtr);
-	dev_dbg(chan2dev(chan), "CSAR:    0x%08x\n", node->hwdesc->csar);
-	dev_dbg(chan2dev(chan), "CDAR:    0x%08x\n", node->hwdesc->cdar);
-	dev_dbg(chan2dev(chan), "CBRUR:   0x%08x\n", node->hwdesc->cbrur);
-	dev_dbg(chan2dev(chan), "CLAR:    0x%08x\n", node->hwdesc->clar);
-	dev_dbg(chan2dev(chan), "CTBR:    0x%08x\n", node->hwdesc->ctbr);
-	dev_dbg(chan2dev(chan), "CMAR:    0x%08x\n", node->hwdesc->cmar);
-	dev_dbg(chan2dev(chan), "CMDR:    0x%08x\n\n", node->hwdesc->cmdr);
+	dev_dbg(vchan_chan_dev(&chan->vchan), "hwdesc:  %pad\n", &node->hwdesc_phys);
+	dev_dbg(vchan_chan_dev(&chan->vchan), "CTCR:    0x%08x\n", node->hwdesc->ctcr);
+	dev_dbg(vchan_chan_dev(&chan->vchan), "CBNDTR:  0x%08x\n", node->hwdesc->cbndtr);
+	dev_dbg(vchan_chan_dev(&chan->vchan), "CSAR:    0x%08x\n", node->hwdesc->csar);
+	dev_dbg(vchan_chan_dev(&chan->vchan), "CDAR:    0x%08x\n", node->hwdesc->cdar);
+	dev_dbg(vchan_chan_dev(&chan->vchan), "CBRUR:   0x%08x\n", node->hwdesc->cbrur);
+	dev_dbg(vchan_chan_dev(&chan->vchan), "CLAR:    0x%08x\n", node->hwdesc->clar);
+	dev_dbg(vchan_chan_dev(&chan->vchan), "CTBR:    0x%08x\n", node->hwdesc->ctbr);
+	dev_dbg(vchan_chan_dev(&chan->vchan), "CMAR:    0x%08x\n", node->hwdesc->cmar);
+	dev_dbg(vchan_chan_dev(&chan->vchan), "CMDR:    0x%08x\n\n", node->hwdesc->cmdr);
 }
 
 static void stm32_mdma_setup_hwdesc(struct stm32_mdma_chan *chan,
@@ -739,7 +734,7 @@ static int stm32_mdma_setup_xfer(struct stm32_mdma_chan *chan,
 
 	for_each_sg(sgl, sg, sg_len, i) {
 		if (sg_dma_len(sg) > STM32_MDMA_MAX_BLOCK_LEN) {
-			dev_err(chan2dev(chan), "Invalid block len\n");
+			dev_err(vchan_chan_dev(&chan->vchan), "Invalid block len\n");
 			return -EINVAL;
 		}
 
@@ -797,7 +792,7 @@ stm32_mdma_prep_slave_sg(struct dma_chan *c, struct scatterlist *sgl,
 	 * for allowing another request.
 	 */
 	if (chan->desc && chan->desc->cyclic) {
-		dev_err(chan2dev(chan),
+		dev_err(vchan_chan_dev(&chan->vchan),
 			"Request not allowed when dma in cyclic mode\n");
 		return NULL;
 	}
@@ -858,18 +853,18 @@ stm32_mdma_prep_dma_cyclic(struct dma_chan *c, dma_addr_t buf_addr,
 	 * for allowing another request.
 	 */
 	if (chan->desc && chan->desc->cyclic) {
-		dev_err(chan2dev(chan),
+		dev_err(vchan_chan_dev(&chan->vchan),
 			"Request not allowed when dma in cyclic mode\n");
 		return NULL;
 	}
 
 	if (!buf_len || !period_len || period_len > STM32_MDMA_MAX_BLOCK_LEN) {
-		dev_err(chan2dev(chan), "Invalid buffer/period len\n");
+		dev_err(vchan_chan_dev(&chan->vchan), "Invalid buffer/period len\n");
 		return NULL;
 	}
 
 	if (buf_len % period_len) {
-		dev_err(chan2dev(chan), "buf_len not multiple of period_len\n");
+		dev_err(vchan_chan_dev(&chan->vchan), "buf_len not multiple of period_len\n");
 		return NULL;
 	}
 
@@ -954,7 +949,7 @@ stm32_mdma_prep_dma_memcpy(struct dma_chan *c, dma_addr_t dest, dma_addr_t src,
 	 * to allow another request
 	 */
 	if (chan->desc && chan->desc->cyclic) {
-		dev_err(chan2dev(chan),
+		dev_err(vchan_chan_dev(&chan->vchan),
 			"Request not allowed when dma in cyclic mode\n");
 		return NULL;
 	}
@@ -1116,25 +1111,25 @@ static void stm32_mdma_dump_reg(struct stm32_mdma_chan *chan)
 {
 	struct stm32_mdma_device *dmadev = stm32_mdma_get_dev(chan);
 
-	dev_dbg(chan2dev(chan), "CCR:     0x%08x\n",
+	dev_dbg(vchan_chan_dev(&chan->vchan), "CCR:     0x%08x\n",
 		stm32_mdma_read(dmadev, STM32_MDMA_CCR(chan->id)));
-	dev_dbg(chan2dev(chan), "CTCR:    0x%08x\n",
+	dev_dbg(vchan_chan_dev(&chan->vchan), "CTCR:    0x%08x\n",
 		stm32_mdma_read(dmadev, STM32_MDMA_CTCR(chan->id)));
-	dev_dbg(chan2dev(chan), "CBNDTR:  0x%08x\n",
+	dev_dbg(vchan_chan_dev(&chan->vchan), "CBNDTR:  0x%08x\n",
 		stm32_mdma_read(dmadev, STM32_MDMA_CBNDTR(chan->id)));
-	dev_dbg(chan2dev(chan), "CSAR:    0x%08x\n",
+	dev_dbg(vchan_chan_dev(&chan->vchan), "CSAR:    0x%08x\n",
 		stm32_mdma_read(dmadev, STM32_MDMA_CSAR(chan->id)));
-	dev_dbg(chan2dev(chan), "CDAR:    0x%08x\n",
+	dev_dbg(vchan_chan_dev(&chan->vchan), "CDAR:    0x%08x\n",
 		stm32_mdma_read(dmadev, STM32_MDMA_CDAR(chan->id)));
-	dev_dbg(chan2dev(chan), "CBRUR:   0x%08x\n",
+	dev_dbg(vchan_chan_dev(&chan->vchan), "CBRUR:   0x%08x\n",
 		stm32_mdma_read(dmadev, STM32_MDMA_CBRUR(chan->id)));
-	dev_dbg(chan2dev(chan), "CLAR:    0x%08x\n",
+	dev_dbg(vchan_chan_dev(&chan->vchan), "CLAR:    0x%08x\n",
 		stm32_mdma_read(dmadev, STM32_MDMA_CLAR(chan->id)));
-	dev_dbg(chan2dev(chan), "CTBR:    0x%08x\n",
+	dev_dbg(vchan_chan_dev(&chan->vchan), "CTBR:    0x%08x\n",
 		stm32_mdma_read(dmadev, STM32_MDMA_CTBR(chan->id)));
-	dev_dbg(chan2dev(chan), "CMAR:    0x%08x\n",
+	dev_dbg(vchan_chan_dev(&chan->vchan), "CMAR:    0x%08x\n",
 		stm32_mdma_read(dmadev, STM32_MDMA_CMAR(chan->id)));
-	dev_dbg(chan2dev(chan), "CMDR:    0x%08x\n",
+	dev_dbg(vchan_chan_dev(&chan->vchan), "CMDR:    0x%08x\n",
 		stm32_mdma_read(dmadev, STM32_MDMA_CMDR(chan->id)));
 }
 
@@ -1187,7 +1182,7 @@ static void stm32_mdma_start_transfer(struct stm32_mdma_chan *chan)
 
 	chan->busy = true;
 
-	dev_dbg(chan2dev(chan), "vchan %p: started\n", &chan->vchan);
+	dev_dbg(vchan_chan_dev(&chan->vchan), "vchan %p: started\n", &chan->vchan);
 }
 
 static void stm32_mdma_issue_pending(struct dma_chan *c)
@@ -1200,7 +1195,7 @@ static void stm32_mdma_issue_pending(struct dma_chan *c)
 	if (!vchan_issue_pending(&chan->vchan))
 		goto end;
 
-	dev_dbg(chan2dev(chan), "vchan %p: issued\n", &chan->vchan);
+	dev_dbg(vchan_chan_dev(&chan->vchan), "vchan %p: issued\n", &chan->vchan);
 
 	if (!chan->desc && !chan->busy)
 		stm32_mdma_start_transfer(chan);
@@ -1220,7 +1215,7 @@ static int stm32_mdma_pause(struct dma_chan *c)
 	spin_unlock_irqrestore(&chan->vchan.lock, flags);
 
 	if (!ret)
-		dev_dbg(chan2dev(chan), "vchan %p: pause\n", &chan->vchan);
+		dev_dbg(vchan_chan_dev(&chan->vchan), "vchan %p: pause\n", &chan->vchan);
 
 	return ret;
 }
@@ -1261,7 +1256,7 @@ static int stm32_mdma_resume(struct dma_chan *c)
 
 	spin_unlock_irqrestore(&chan->vchan.lock, flags);
 
-	dev_dbg(chan2dev(chan), "vchan %p: resume\n", &chan->vchan);
+	dev_dbg(vchan_chan_dev(&chan->vchan), "vchan %p: resume\n", &chan->vchan);
 
 	return 0;
 }
@@ -1422,10 +1417,10 @@ static irqreturn_t stm32_mdma_irq_handler(int irq, void *devid)
 	if (!(status & ien)) {
 		spin_unlock(&chan->vchan.lock);
 		if (chan->busy)
-			dev_warn(chan2dev(chan),
+			dev_warn(vchan_chan_dev(&chan->vchan),
 				 "spurious it (status=0x%04x, ien=0x%04x)\n", status, ien);
 		else
-			dev_dbg(chan2dev(chan),
+			dev_dbg(vchan_chan_dev(&chan->vchan),
 				"spurious it (status=0x%04x, ien=0x%04x)\n", status, ien);
 		return IRQ_NONE;
 	}
@@ -1433,7 +1428,7 @@ static irqreturn_t stm32_mdma_irq_handler(int irq, void *devid)
 	reg = STM32_MDMA_CIFCR(id);
 
 	if (status & STM32_MDMA_CISR_TEIF) {
-		dev_err(chan2dev(chan), "Transfer Err: stat=0x%08x\n",
+		dev_err(vchan_chan_dev(&chan->vchan), "Transfer Err: stat=0x%08x\n",
 			readl_relaxed(dmadev->base + STM32_MDMA_CESR(id)));
 		stm32_mdma_set_bits(dmadev, reg, STM32_MDMA_CIFCR_CTEIF);
 		status &= ~STM32_MDMA_CISR_TEIF;
@@ -1468,9 +1463,9 @@ static irqreturn_t stm32_mdma_irq_handler(int irq, void *devid)
 
 	if (status) {
 		stm32_mdma_set_bits(dmadev, reg, status);
-		dev_err(chan2dev(chan), "DMA error: status=0x%08x\n", status);
+		dev_err(vchan_chan_dev(&chan->vchan), "DMA error: status=0x%08x\n", status);
 		if (!(ccr & STM32_MDMA_CCR_EN))
-			dev_err(chan2dev(chan), "chan disabled by HW\n");
+			dev_err(vchan_chan_dev(&chan->vchan), "chan disabled by HW\n");
 	}
 
 	spin_unlock(&chan->vchan.lock);
@@ -1489,7 +1484,7 @@ static int stm32_mdma_alloc_chan_resources(struct dma_chan *c)
 					  __alignof__(struct stm32_mdma_hwdesc),
 					   0);
 	if (!chan->desc_pool) {
-		dev_err(chan2dev(chan), "failed to allocate descriptor pool\n");
+		dev_err(vchan_chan_dev(&chan->vchan), "failed to allocate descriptor pool\n");
 		return -ENOMEM;
 	}
 
@@ -1510,7 +1505,7 @@ static void stm32_mdma_free_chan_resources(struct dma_chan *c)
 	struct stm32_mdma_device *dmadev = stm32_mdma_get_dev(chan);
 	unsigned long flags;
 
-	dev_dbg(chan2dev(chan), "Freeing channel %d\n", chan->id);
+	dev_dbg(vchan_chan_dev(&chan->vchan), "Freeing channel %d\n", chan->id);
 
 	if (chan->busy) {
 		spin_lock_irqsave(&chan->vchan.lock, flags);
diff --git a/drivers/dma/sun4i-dma.c b/drivers/dma/sun4i-dma.c
index d2321f7287d20..225e4a53502b4 100644
--- a/drivers/dma/sun4i-dma.c
+++ b/drivers/dma/sun4i-dma.c
@@ -246,11 +246,6 @@ static struct sun4i_dma_contract *to_sun4i_dma_contract(struct virt_dma_desc *vd
 	return container_of(vd, struct sun4i_dma_contract, vd);
 }
 
-static struct device *chan2dev(struct dma_chan *chan)
-{
-	return &chan->dev->device;
-}
-
 static void set_dst_data_width_a10(u32 *p_cfg, s8 data_width)
 {
 	*p_cfg |= SUN4I_DMA_CFG_DST_DATA_WIDTH(data_width);
@@ -428,7 +423,7 @@ static int __execute_vchan_pending(struct sun4i_dma_dev *priv,
 	 * has already submitted some work, we can't do anything else
 	 */
 	if (vchan->processing) {
-		dev_dbg(chan2dev(&vchan->vc.chan),
+		dev_dbg(vchan_chan_dev(&vchan->vc),
 			"processing something to this endpoint already\n");
 		ret = -EBUSY;
 		goto release_pchan;
@@ -438,7 +433,7 @@ static int __execute_vchan_pending(struct sun4i_dma_dev *priv,
 		/* Figure out which contract we're working with today */
 		vd = vchan_next_desc(&vchan->vc);
 		if (!vd) {
-			dev_dbg(chan2dev(&vchan->vc.chan),
+			dev_dbg(vchan_chan_dev(&vchan->vc),
 				"No pending contract found");
 			ret = 0;
 			goto release_pchan;
@@ -449,7 +444,7 @@ static int __execute_vchan_pending(struct sun4i_dma_dev *priv,
 			/* The contract has been completed so mark it as such */
 			list_del(&contract->vd.node);
 			vchan_cookie_complete(&contract->vd);
-			dev_dbg(chan2dev(&vchan->vc.chan),
+			dev_dbg(vchan_chan_dev(&vchan->vc),
 				"Empty contract found and marked complete");
 		}
 	} while (list_empty(&contract->demands));
@@ -542,7 +537,7 @@ generate_ndma_promise(struct dma_chan *chan, dma_addr_t src, dma_addr_t dest,
 	promise->cfg = SUN4I_DMA_CFG_LOADING |
 		SUN4I_NDMA_CFG_BYTE_COUNT_MODE_REMAIN;
 
-	dev_dbg(chan2dev(chan),
+	dev_dbg(dmaengine_chan_dev(chan),
 		"src burst %d, dst burst %d, src buswidth %d, dst buswidth %d",
 		sconfig->src_maxburst, sconfig->dst_maxburst,
 		sconfig->src_addr_width, sconfig->dst_addr_width);
@@ -769,7 +764,7 @@ sun4i_dma_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t buf, size_t len,
 	u8 ram_type, io_mode, linear_mode;
 
 	if (!is_slave_direction(dir)) {
-		dev_err(chan2dev(chan), "Invalid DMA direction\n");
+		dev_err(dmaengine_chan_dev(chan), "Invalid DMA direction\n");
 		return NULL;
 	}
 
@@ -894,7 +889,7 @@ sun4i_dma_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 		return NULL;
 
 	if (!is_slave_direction(dir)) {
-		dev_err(chan2dev(chan), "Invalid DMA direction\n");
+		dev_err(dmaengine_chan_dev(chan), "Invalid DMA direction\n");
 		return NULL;
 	}
 
diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
index c248c2dec956a..5ad9d01cff3ae 100644
--- a/drivers/dma/sun6i-dma.c
+++ b/drivers/dma/sun6i-dma.c
@@ -213,11 +213,6 @@ struct sun6i_dma_dev {
 	u32			max_request;
 };
 
-static struct device *chan2dev(struct dma_chan *chan)
-{
-	return &chan->dev->device;
-}
-
 static inline struct sun6i_dma_dev *to_sun6i_dma_dev(struct dma_device *d)
 {
 	return container_of(d, struct sun6i_dma_dev, slave);
@@ -397,7 +392,7 @@ static inline void sun6i_dma_dump_lli(struct sun6i_vchan *vchan,
 				      struct sun6i_dma_lli *v_lli,
 				      dma_addr_t p_lli)
 {
-	dev_dbg(chan2dev(&vchan->vc.chan),
+	dev_dbg(vchan_chan_dev(&vchan->vc),
 		"\n\tdesc:\tp - %pad v - 0x%p\n"
 		"\t\tc - 0x%08x s - 0x%08x d - 0x%08x\n"
 		"\t\tl - 0x%08x p - 0x%08x n - 0x%08x\n",
@@ -678,7 +673,7 @@ static struct dma_async_tx_descriptor *sun6i_dma_prep_dma_memcpy(
 	dma_addr_t p_lli;
 	s8 burst, width;
 
-	dev_dbg(chan2dev(chan),
+	dev_dbg(dmaengine_chan_dev(chan),
 		"%s; chan: %d, dest: %pad, src: %pad, len: %zu. flags: 0x%08lx\n",
 		__func__, vchan->vc.chan.chan_id, &dest, &src, len, flags);
 
@@ -739,7 +734,7 @@ static struct dma_async_tx_descriptor *sun6i_dma_prep_slave_sg(
 
 	ret = set_config(sdev, sconfig, dir, &lli_cfg);
 	if (ret) {
-		dev_err(chan2dev(chan), "Invalid DMA configuration\n");
+		dev_err(dmaengine_chan_dev(chan), "Invalid DMA configuration\n");
 		return NULL;
 	}
 
@@ -763,7 +758,7 @@ static struct dma_async_tx_descriptor *sun6i_dma_prep_slave_sg(
 			sdev->cfg->set_drq(&v_lli->cfg, DRQ_SDRAM, vchan->port);
 			sdev->cfg->set_mode(&v_lli->cfg, LINEAR_MODE, IO_MODE);
 
-			dev_dbg(chan2dev(chan),
+			dev_dbg(dmaengine_chan_dev(chan),
 				"%s; chan: %d, dest: %pad, src: %pad, len: %u. flags: 0x%08lx\n",
 				__func__, vchan->vc.chan.chan_id,
 				&sconfig->dst_addr, &sg_dma_address(sg),
@@ -777,7 +772,7 @@ static struct dma_async_tx_descriptor *sun6i_dma_prep_slave_sg(
 			sdev->cfg->set_drq(&v_lli->cfg, vchan->port, DRQ_SDRAM);
 			sdev->cfg->set_mode(&v_lli->cfg, IO_MODE, LINEAR_MODE);
 
-			dev_dbg(chan2dev(chan),
+			dev_dbg(dmaengine_chan_dev(chan),
 				"%s; chan: %d, dest: %pad, src: %pad, len: %u. flags: 0x%08lx\n",
 				__func__, vchan->vc.chan.chan_id,
 				&sg_dma_address(sg), &sconfig->src_addr,
@@ -787,7 +782,7 @@ static struct dma_async_tx_descriptor *sun6i_dma_prep_slave_sg(
 		prev = sun6i_dma_lli_add(prev, v_lli, p_lli, txd);
 	}
 
-	dev_dbg(chan2dev(chan), "First: %pad\n", &txd->p_lli);
+	dev_dbg(dmaengine_chan_dev(chan), "First: %pad\n", &txd->p_lli);
 	for (p_lli = txd->p_lli, v_lli = txd->v_lli; v_lli;
 	     p_lli = v_lli->p_lli_next, v_lli = v_lli->v_lli_next)
 		sun6i_dma_dump_lli(vchan, v_lli, p_lli);
@@ -819,7 +814,7 @@ static struct dma_async_tx_descriptor *sun6i_dma_prep_dma_cyclic(
 
 	ret = set_config(sdev, sconfig, dir, &lli_cfg);
 	if (ret) {
-		dev_err(chan2dev(chan), "Invalid DMA configuration\n");
+		dev_err(dmaengine_chan_dev(chan), "Invalid DMA configuration\n");
 		return NULL;
 	}
 
@@ -844,7 +839,7 @@ static struct dma_async_tx_descriptor *sun6i_dma_prep_dma_cyclic(
 			v_lli->cfg = lli_cfg;
 			sdev->cfg->set_drq(&v_lli->cfg, DRQ_SDRAM, vchan->port);
 			sdev->cfg->set_mode(&v_lli->cfg, LINEAR_MODE, IO_MODE);
-			dev_dbg(chan2dev(chan),
+			dev_dbg(dmaengine_chan_dev(chan),
 				"%s; chan: %d, dest: %pad, src: %pad, len: %zu. flags: 0x%08lx\n",
 				__func__, vchan->vc.chan.chan_id,
 				&sconfig->dst_addr, &buf_addr,
@@ -856,7 +851,7 @@ static struct dma_async_tx_descriptor *sun6i_dma_prep_dma_cyclic(
 			v_lli->cfg = lli_cfg;
 			sdev->cfg->set_drq(&v_lli->cfg, vchan->port, DRQ_SDRAM);
 			sdev->cfg->set_mode(&v_lli->cfg, IO_MODE, LINEAR_MODE);
-			dev_dbg(chan2dev(chan),
+			dev_dbg(dmaengine_chan_dev(chan),
 				"%s; chan: %d, dest: %pad, src: %pad, len: %zu. flags: 0x%08lx\n",
 				__func__, vchan->vc.chan.chan_id,
 				&buf_addr, &sconfig->src_addr,
@@ -893,7 +888,7 @@ static int sun6i_dma_pause(struct dma_chan *chan)
 	struct sun6i_vchan *vchan = to_sun6i_vchan(chan);
 	struct sun6i_pchan *pchan = vchan->phy;
 
-	dev_dbg(chan2dev(chan), "vchan %p: pause\n", &vchan->vc);
+	dev_dbg(dmaengine_chan_dev(chan), "vchan %p: pause\n", &vchan->vc);
 
 	if (pchan) {
 		writel(DMA_CHAN_PAUSE_PAUSE,
@@ -914,7 +909,7 @@ static int sun6i_dma_resume(struct dma_chan *chan)
 	struct sun6i_pchan *pchan = vchan->phy;
 	unsigned long flags;
 
-	dev_dbg(chan2dev(chan), "vchan %p: resume\n", &vchan->vc);
+	dev_dbg(dmaengine_chan_dev(chan), "vchan %p: resume\n", &vchan->vc);
 
 	spin_lock_irqsave(&vchan->vc.lock, flags);
 
@@ -1024,13 +1019,13 @@ static void sun6i_dma_issue_pending(struct dma_chan *chan)
 		if (!vchan->phy && list_empty(&vchan->node)) {
 			list_add_tail(&vchan->node, &sdev->pending);
 			tasklet_schedule(&sdev->task);
-			dev_dbg(chan2dev(chan), "vchan %p: issued\n",
+			dev_dbg(dmaengine_chan_dev(chan), "vchan %p: issued\n",
 				&vchan->vc);
 		}
 
 		spin_unlock(&sdev->lock);
 	} else {
-		dev_dbg(chan2dev(chan), "vchan %p: nothing to issue\n",
+		dev_dbg(dmaengine_chan_dev(chan), "vchan %p: nothing to issue\n",
 			&vchan->vc);
 	}
 
diff --git a/drivers/dma/switchtec_dma.c b/drivers/dma/switchtec_dma.c
index c133535d37656..4cc80752f5b69 100644
--- a/drivers/dma/switchtec_dma.c
+++ b/drivers/dma/switchtec_dma.c
@@ -406,7 +406,7 @@ static int disable_channel(struct switchtec_dma_chan *swdma_chan)
 static void
 switchtec_dma_cleanup_completed(struct switchtec_dma_chan *swdma_chan)
 {
-	struct device *chan_dev = &swdma_chan->dma_chan.dev->device;
+	struct device *chan_dev = dmaengine_chan_dev(&swdma_chan->dma_chan);
 	struct switchtec_dma_desc *desc;
 	struct switchtec_dma_hw_ce *ce;
 	struct dmaengine_result res;
@@ -851,7 +851,7 @@ static irqreturn_t switchtec_dma_chan_status_isr(int irq, void *dma)
 	list_for_each_entry(chan, &dma_dev->channels, device_node) {
 		swdma_chan = container_of(chan, struct switchtec_dma_chan,
 					  dma_chan);
-		chan_dev = &swdma_chan->dma_chan.dev->device;
+		chan_dev = dmaengine_chan_dev(&swdma_chan->dma_chan);
 		chan_hw = swdma_chan->mmio_chan_hw;
 
 		rcu_read_lock();
@@ -1009,19 +1009,19 @@ static int switchtec_dma_alloc_chan_resources(struct dma_chan *chan)
 	perf_cfg = readl(&swdma_chan->mmio_chan_fw->perf_cfg);
 	rcu_read_unlock();
 
-	dev_dbg(&chan->dev->device, "Burst Size:  0x%x\n",
+	dev_dbg(dmaengine_chan_dev(chan), "Burst Size:  0x%x\n",
 		FIELD_GET(PERF_BURST_SIZE_MASK, perf_cfg));
 
-	dev_dbg(&chan->dev->device, "Burst Scale: 0x%x\n",
+	dev_dbg(dmaengine_chan_dev(chan), "Burst Scale: 0x%x\n",
 		FIELD_GET(PERF_BURST_SCALE_MASK, perf_cfg));
 
-	dev_dbg(&chan->dev->device, "Interval:    0x%x\n",
+	dev_dbg(dmaengine_chan_dev(chan), "Interval:    0x%x\n",
 		FIELD_GET(PERF_INTERVAL_MASK, perf_cfg));
 
-	dev_dbg(&chan->dev->device, "Arb Weight:  0x%x\n",
+	dev_dbg(dmaengine_chan_dev(chan), "Arb Weight:  0x%x\n",
 		FIELD_GET(PERF_ARB_WEIGHT_MASK, perf_cfg));
 
-	dev_dbg(&chan->dev->device, "MRRS:        0x%x\n",
+	dev_dbg(dmaengine_chan_dev(chan), "MRRS:        0x%x\n",
 		FIELD_GET(PERF_MRRS_MASK, perf_cfg));
 
 	return SWITCHTEC_DMA_SQ_SIZE;
diff --git a/drivers/dma/tegra186-gpc-dma.c b/drivers/dma/tegra186-gpc-dma.c
index 64cedef1050ae..b3327aa35de40 100644
--- a/drivers/dma/tegra186-gpc-dma.c
+++ b/drivers/dma/tegra186-gpc-dma.c
@@ -1537,7 +1537,7 @@ static int tegra_dma_probe(struct platform_device *pdev)
 	 * the channels available and registered for the DMA device are used.
 	 */
 	list_for_each_entry(chan, &tdma->dma_dev.channels, device_node) {
-		chdev = &chan->dev->device;
+		chdev = dmaengine_chan_dev(chan);
 		tdc = to_tegra_dma_chan(chan);
 
 		if (use_iommu_map) {
diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
index 640b8a218c9ad..7ff8c0241f61f 100644
--- a/drivers/dma/tegra20-apb-dma.c
+++ b/drivers/dma/tegra20-apb-dma.c
@@ -256,7 +256,7 @@ txd_to_tegra_dma_desc(struct dma_async_tx_descriptor *td)
 
 static inline struct device *tdc2dev(struct tegra_dma_channel *tdc)
 {
-	return &tdc->dma_chan.dev->device;
+	return dmaengine_chan_dev(&tdc->dma_chan);
 }
 
 static dma_cookie_t tegra_dma_tx_submit(struct dma_async_tx_descriptor *tx);
diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index fb21e0df5ab7b..49e2d0014d5ed 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -422,7 +422,7 @@ static int navss_psil_unpair(struct udma_dev *ud, u32 src_thread,
 
 static void k3_configure_chan_coherency(struct dma_chan *chan, u32 asel)
 {
-	struct device *chan_dev = &chan->dev->device;
+	struct device *chan_dev = dmaengine_chan_dev(chan);
 
 	if (asel == 0) {
 		/* No special handling for the channel */
diff --git a/drivers/dma/timb_dma.c b/drivers/dma/timb_dma.c
index 4fc5119854ec1..0acd7a36a3d0d 100644
--- a/drivers/dma/timb_dma.c
+++ b/drivers/dma/timb_dma.c
@@ -90,14 +90,9 @@ struct timb_dma {
 	struct tasklet_struct	tasklet;
 	struct timb_dma_chan	channels[];
 };
-
-static struct device *chan2dev(struct dma_chan *chan)
-{
-	return &chan->dev->device;
-}
 static struct device *chan2dmadev(struct dma_chan *chan)
 {
-	return chan2dev(chan)->parent->parent;
+	return dmaengine_chan_dev(chan)->parent->parent;
 }
 
 static struct timb_dma *tdchantotd(struct timb_dma_chan *td_chan)
@@ -117,7 +112,7 @@ static void __td_enable_chan_irq(struct timb_dma_chan *td_chan)
 	/* enable interrupt for this channel */
 	ier = ioread32(td->membase + TIMBDMA_IER);
 	ier |= 1 << id;
-	dev_dbg(chan2dev(&td_chan->chan), "Enabling irq: %d, IER: 0x%x\n", id,
+	dev_dbg(dmaengine_chan_dev(&td_chan->chan), "Enabling irq: %d, IER: 0x%x\n", id,
 		ier);
 	iowrite32(ier, td->membase + TIMBDMA_IER);
 }
@@ -131,7 +126,7 @@ static bool __td_dma_done_ack(struct timb_dma_chan *td_chan)
 	u32 isr;
 	bool done = false;
 
-	dev_dbg(chan2dev(&td_chan->chan), "Checking irq: %d, td: %p\n", id, td);
+	dev_dbg(dmaengine_chan_dev(&td_chan->chan), "Checking irq: %d, td: %p\n", id, td);
 
 	isr = ioread32(td->membase + TIMBDMA_ISR) & (1 << id);
 	if (isr) {
@@ -146,18 +141,18 @@ static int td_fill_desc(struct timb_dma_chan *td_chan, u8 *dma_desc,
 	struct scatterlist *sg, bool last)
 {
 	if (sg_dma_len(sg) > USHRT_MAX) {
-		dev_err(chan2dev(&td_chan->chan), "Too big sg element\n");
+		dev_err(dmaengine_chan_dev(&td_chan->chan), "Too big sg element\n");
 		return -EINVAL;
 	}
 
 	/* length must be word aligned */
 	if (sg_dma_len(sg) % sizeof(u32)) {
-		dev_err(chan2dev(&td_chan->chan), "Incorrect length: %d\n",
+		dev_err(dmaengine_chan_dev(&td_chan->chan), "Incorrect length: %d\n",
 			sg_dma_len(sg));
 		return -EINVAL;
 	}
 
-	dev_dbg(chan2dev(&td_chan->chan), "desc: %p, addr: 0x%llx\n",
+	dev_dbg(dmaengine_chan_dev(&td_chan->chan), "desc: %p, addr: 0x%llx\n",
 		dma_desc, (unsigned long long)sg_dma_address(sg));
 
 	dma_desc[7] = (sg_dma_address(sg) >> 24) & 0xff;
@@ -180,7 +175,7 @@ static void __td_start_dma(struct timb_dma_chan *td_chan)
 	struct timb_dma_desc *td_desc;
 
 	if (td_chan->ongoing) {
-		dev_err(chan2dev(&td_chan->chan),
+		dev_err(dmaengine_chan_dev(&td_chan->chan),
 			"Transfer already ongoing\n");
 		return;
 	}
@@ -188,7 +183,7 @@ static void __td_start_dma(struct timb_dma_chan *td_chan)
 	td_desc = list_entry(td_chan->active_list.next, struct timb_dma_desc,
 		desc_node);
 
-	dev_dbg(chan2dev(&td_chan->chan),
+	dev_dbg(dmaengine_chan_dev(&td_chan->chan),
 		"td_chan: %p, chan: %d, membase: %p\n",
 		td_chan, td_chan->chan.chan_id, td_chan->membase);
 
@@ -230,7 +225,7 @@ static void __td_finish(struct timb_dma_chan *td_chan)
 		desc_node);
 	txd = &td_desc->txd;
 
-	dev_dbg(chan2dev(&td_chan->chan), "descriptor %u complete\n",
+	dev_dbg(dmaengine_chan_dev(&td_chan->chan), "descriptor %u complete\n",
 		txd->cookie);
 
 	/* make sure to stop the transfer */
@@ -284,7 +279,7 @@ static void __td_start_next(struct timb_dma_chan *td_chan)
 	td_desc = list_entry(td_chan->queue.next, struct timb_dma_desc,
 		desc_node);
 
-	dev_dbg(chan2dev(&td_chan->chan), "%s: started %u\n",
+	dev_dbg(dmaengine_chan_dev(&td_chan->chan), "%s: started %u\n",
 		__func__, td_desc->txd.cookie);
 
 	list_move(&td_desc->desc_node, &td_chan->active_list);
@@ -303,12 +298,12 @@ static dma_cookie_t td_tx_submit(struct dma_async_tx_descriptor *txd)
 	cookie = dma_cookie_assign(txd);
 
 	if (list_empty(&td_chan->active_list)) {
-		dev_dbg(chan2dev(txd->chan), "%s: started %u\n", __func__,
+		dev_dbg(dmaengine_chan_dev(txd->chan), "%s: started %u\n", __func__,
 			txd->cookie);
 		list_add_tail(&td_desc->desc_node, &td_chan->active_list);
 		__td_start_dma(td_chan);
 	} else {
-		dev_dbg(chan2dev(txd->chan), "tx_submit: queued %u\n",
+		dev_dbg(dmaengine_chan_dev(txd->chan), "tx_submit: queued %u\n",
 			txd->cookie);
 
 		list_add_tail(&td_desc->desc_node, &td_chan->queue);
@@ -344,7 +339,7 @@ static struct timb_dma_desc *td_alloc_init_desc(struct timb_dma_chan *td_chan)
 
 	err = dma_mapping_error(chan2dmadev(chan), td_desc->txd.phys);
 	if (err) {
-		dev_err(chan2dev(chan), "DMA mapping error: %d\n", err);
+		dev_err(dmaengine_chan_dev(chan), "DMA mapping error: %d\n", err);
 		goto err;
 	}
 
@@ -359,7 +354,7 @@ static struct timb_dma_desc *td_alloc_init_desc(struct timb_dma_chan *td_chan)
 
 static void td_free_desc(struct timb_dma_desc *td_desc)
 {
-	dev_dbg(chan2dev(td_desc->txd.chan), "Freeing desc: %p\n", td_desc);
+	dev_dbg(dmaengine_chan_dev(td_desc->txd.chan), "Freeing desc: %p\n", td_desc);
 	dma_unmap_single(chan2dmadev(td_desc->txd.chan), td_desc->txd.phys,
 		td_desc->desc_list_len, DMA_TO_DEVICE);
 
@@ -370,7 +365,7 @@ static void td_free_desc(struct timb_dma_desc *td_desc)
 static void td_desc_put(struct timb_dma_chan *td_chan,
 	struct timb_dma_desc *td_desc)
 {
-	dev_dbg(chan2dev(&td_chan->chan), "Putting desc: %p\n", td_desc);
+	dev_dbg(dmaengine_chan_dev(&td_chan->chan), "Putting desc: %p\n", td_desc);
 
 	spin_lock_bh(&td_chan->lock);
 	list_add(&td_desc->desc_node, &td_chan->free_list);
@@ -390,7 +385,7 @@ static struct timb_dma_desc *td_desc_get(struct timb_dma_chan *td_chan)
 			ret = td_desc;
 			break;
 		}
-		dev_dbg(chan2dev(&td_chan->chan), "desc %p not ACKed\n",
+		dev_dbg(dmaengine_chan_dev(&td_chan->chan), "desc %p not ACKed\n",
 			td_desc);
 	}
 	spin_unlock_bh(&td_chan->lock);
@@ -404,7 +399,7 @@ static int td_alloc_chan_resources(struct dma_chan *chan)
 		container_of(chan, struct timb_dma_chan, chan);
 	int i;
 
-	dev_dbg(chan2dev(chan), "%s: entry\n", __func__);
+	dev_dbg(dmaengine_chan_dev(chan), "%s: entry\n", __func__);
 
 	BUG_ON(!list_empty(&td_chan->free_list));
 	for (i = 0; i < td_chan->descs; i++) {
@@ -413,7 +408,7 @@ static int td_alloc_chan_resources(struct dma_chan *chan)
 			if (i)
 				break;
 			else {
-				dev_err(chan2dev(chan),
+				dev_err(dmaengine_chan_dev(chan),
 					"Couldn't allocate any descriptors\n");
 				return -ENOMEM;
 			}
@@ -436,7 +431,7 @@ static void td_free_chan_resources(struct dma_chan *chan)
 	struct timb_dma_desc *td_desc, *_td_desc;
 	LIST_HEAD(list);
 
-	dev_dbg(chan2dev(chan), "%s: Entry\n", __func__);
+	dev_dbg(dmaengine_chan_dev(chan), "%s: Entry\n", __func__);
 
 	/* check that all descriptors are free */
 	BUG_ON(!list_empty(&td_chan->active_list));
@@ -447,7 +442,7 @@ static void td_free_chan_resources(struct dma_chan *chan)
 	spin_unlock_bh(&td_chan->lock);
 
 	list_for_each_entry_safe(td_desc, _td_desc, &list, desc_node) {
-		dev_dbg(chan2dev(chan), "%s: Freeing desc: %p\n", __func__,
+		dev_dbg(dmaengine_chan_dev(chan), "%s: Freeing desc: %p\n", __func__,
 			td_desc);
 		td_free_desc(td_desc);
 	}
@@ -458,11 +453,11 @@ static enum dma_status td_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
 {
 	enum dma_status ret;
 
-	dev_dbg(chan2dev(chan), "%s: Entry\n", __func__);
+	dev_dbg(dmaengine_chan_dev(chan), "%s: Entry\n", __func__);
 
 	ret = dma_cookie_status(chan, cookie, txstate);
 
-	dev_dbg(chan2dev(chan), "%s: exit, ret: %d\n", 	__func__, ret);
+	dev_dbg(dmaengine_chan_dev(chan), "%s: exit, ret: %d\n", 	__func__, ret);
 
 	return ret;
 }
@@ -472,7 +467,7 @@ static void td_issue_pending(struct dma_chan *chan)
 	struct timb_dma_chan *td_chan =
 		container_of(chan, struct timb_dma_chan, chan);
 
-	dev_dbg(chan2dev(chan), "%s: Entry\n", __func__);
+	dev_dbg(dmaengine_chan_dev(chan), "%s: Entry\n", __func__);
 	spin_lock_bh(&td_chan->lock);
 
 	if (!list_empty(&td_chan->active_list))
@@ -499,20 +494,20 @@ static struct dma_async_tx_descriptor *td_prep_slave_sg(struct dma_chan *chan,
 	unsigned int desc_usage = 0;
 
 	if (!sgl || !sg_len) {
-		dev_err(chan2dev(chan), "%s: No SG list\n", __func__);
+		dev_err(dmaengine_chan_dev(chan), "%s: No SG list\n", __func__);
 		return NULL;
 	}
 
 	/* even channels are for RX, odd for TX */
 	if (td_chan->direction != direction) {
-		dev_err(chan2dev(chan),
+		dev_err(dmaengine_chan_dev(chan),
 			"Requesting channel in wrong direction\n");
 		return NULL;
 	}
 
 	td_desc = td_desc_get(td_chan);
 	if (!td_desc) {
-		dev_err(chan2dev(chan), "Not enough descriptors available\n");
+		dev_err(dmaengine_chan_dev(chan), "Not enough descriptors available\n");
 		return NULL;
 	}
 
@@ -521,14 +516,14 @@ static struct dma_async_tx_descriptor *td_prep_slave_sg(struct dma_chan *chan,
 	for_each_sg(sgl, sg, sg_len, i) {
 		int err;
 		if (desc_usage > td_desc->desc_list_len) {
-			dev_err(chan2dev(chan), "No descriptor space\n");
+			dev_err(dmaengine_chan_dev(chan), "No descriptor space\n");
 			return NULL;
 		}
 
 		err = td_fill_desc(td_chan, td_desc->desc_list + desc_usage, sg,
 			i == (sg_len - 1));
 		if (err) {
-			dev_err(chan2dev(chan), "Failed to update desc: %d\n",
+			dev_err(dmaengine_chan_dev(chan), "Failed to update desc: %d\n",
 				err);
 			td_desc_put(td_chan, td_desc);
 			return NULL;
@@ -548,7 +543,7 @@ static int td_terminate_all(struct dma_chan *chan)
 		container_of(chan, struct timb_dma_chan, chan);
 	struct timb_dma_desc *td_desc, *_td_desc;
 
-	dev_dbg(chan2dev(chan), "%s: Entry\n", __func__);
+	dev_dbg(dmaengine_chan_dev(chan), "%s: Entry\n", __func__);
 
 	/* first the easy part, put the queue into the free list */
 	spin_lock_bh(&td_chan->lock);
diff --git a/drivers/dma/txx9dmac.c b/drivers/dma/txx9dmac.c
index 6595a54a4b97f..ecfaa6a765167 100644
--- a/drivers/dma/txx9dmac.c
+++ b/drivers/dma/txx9dmac.c
@@ -125,14 +125,9 @@ static struct txx9dmac_regs32 __iomem *__txx9dmac_regs32(
 #define dma_writel(ddev, name, val) \
 	(__is_dmac64(ddev) ? \
 	dma64_writel(ddev, name, val) : dma32_writel(ddev, name, val))
-
-static struct device *chan2dev(struct dma_chan *chan)
-{
-	return &chan->dev->device;
-}
 static struct device *chan2parent(struct dma_chan *chan)
 {
-	return chan->dev->device.parent;
+	return dmaengine_chan_dev(chan)->parent;
 }
 
 static struct txx9dmac_desc *
@@ -218,12 +213,12 @@ static struct txx9dmac_desc *txx9dmac_desc_get(struct txx9dmac_chan *dc)
 			ret = desc;
 			break;
 		}
-		dev_dbg(chan2dev(&dc->chan), "desc %p not ACKed\n", desc);
+		dev_dbg(dmaengine_chan_dev(&dc->chan), "desc %p not ACKed\n", desc);
 		i++;
 	}
 	spin_unlock_bh(&dc->lock);
 
-	dev_vdbg(chan2dev(&dc->chan), "scanned %u descriptors on freelist\n",
+	dev_vdbg(dmaengine_chan_dev(&dc->chan), "scanned %u descriptors on freelist\n",
 		 i);
 	if (!ret) {
 		ret = txx9dmac_desc_alloc(dc, GFP_ATOMIC);
@@ -232,7 +227,7 @@ static struct txx9dmac_desc *txx9dmac_desc_get(struct txx9dmac_chan *dc)
 			dc->descs_allocated++;
 			spin_unlock_bh(&dc->lock);
 		} else
-			dev_err(chan2dev(&dc->chan),
+			dev_err(dmaengine_chan_dev(&dc->chan),
 				"not enough descriptors available\n");
 	}
 	return ret;
@@ -267,11 +262,11 @@ static void txx9dmac_desc_put(struct txx9dmac_chan *dc,
 
 		spin_lock_bh(&dc->lock);
 		list_for_each_entry(child, &desc->tx_list, desc_node)
-			dev_vdbg(chan2dev(&dc->chan),
+			dev_vdbg(dmaengine_chan_dev(&dc->chan),
 				 "moving child desc %p to freelist\n",
 				 child);
 		list_splice_init(&desc->tx_list, &dc->free_list);
-		dev_vdbg(chan2dev(&dc->chan), "moving desc %p to freelist\n",
+		dev_vdbg(dmaengine_chan_dev(&dc->chan), "moving desc %p to freelist\n",
 			 desc);
 		list_add(&desc->desc_node, &dc->free_list);
 		spin_unlock_bh(&dc->lock);
@@ -283,7 +278,7 @@ static void txx9dmac_desc_put(struct txx9dmac_chan *dc,
 static void txx9dmac_dump_regs(struct txx9dmac_chan *dc)
 {
 	if (is_dmac64(dc))
-		dev_err(chan2dev(&dc->chan),
+		dev_err(dmaengine_chan_dev(&dc->chan),
 			"  CHAR: %#llx SAR: %#llx DAR: %#llx CNTR: %#x"
 			" SAIR: %#x DAIR: %#x CCR: %#x CSR: %#x\n",
 			(u64)channel64_read_CHAR(dc),
@@ -295,7 +290,7 @@ static void txx9dmac_dump_regs(struct txx9dmac_chan *dc)
 			channel64_readl(dc, CCR),
 			channel64_readl(dc, CSR));
 	else
-		dev_err(chan2dev(&dc->chan),
+		dev_err(dmaengine_chan_dev(&dc->chan),
 			"  CHAR: %#x SAR: %#x DAR: %#x CNTR: %#x"
 			" SAIR: %#x DAIR: %#x CCR: %#x CSR: %#x\n",
 			channel32_readl(dc, CHAR),
@@ -333,11 +328,11 @@ static void txx9dmac_dostart(struct txx9dmac_chan *dc,
 	struct txx9dmac_slave *ds = dc->chan.private;
 	u32 sai, dai;
 
-	dev_vdbg(chan2dev(&dc->chan), "dostart %u %p\n",
+	dev_vdbg(dmaengine_chan_dev(&dc->chan), "dostart %u %p\n",
 		 first->txd.cookie, first);
 	/* ASSERT:  channel is idle */
 	if (channel_readl(dc, CSR) & TXX9_DMA_CSR_XFACT) {
-		dev_err(chan2dev(&dc->chan),
+		dev_err(dmaengine_chan_dev(&dc->chan),
 			"BUG: Attempted to start non-idle channel\n");
 		txx9dmac_dump_regs(dc);
 		/* The tasklet will hopefully advance the queue... */
@@ -402,7 +397,7 @@ txx9dmac_descriptor_complete(struct txx9dmac_chan *dc,
 	struct dmaengine_desc_callback cb;
 	struct dma_async_tx_descriptor *txd = &desc->txd;
 
-	dev_vdbg(chan2dev(&dc->chan), "descriptor %u %p complete\n",
+	dev_vdbg(dmaengine_chan_dev(&dc->chan), "descriptor %u %p complete\n",
 		 txd->cookie, desc);
 
 	dma_cookie_complete(txd);
@@ -469,11 +464,11 @@ static void txx9dmac_dump_desc(struct txx9dmac_chan *dc,
 {
 	if (is_dmac64(dc)) {
 #ifdef TXX9_DMA_USE_SIMPLE_CHAIN
-		dev_crit(chan2dev(&dc->chan),
+		dev_crit(dmaengine_chan_dev(&dc->chan),
 			 "  desc: ch%#llx s%#llx d%#llx c%#x\n",
 			 (u64)desc->CHAR, desc->SAR, desc->DAR, desc->CNTR);
 #else
-		dev_crit(chan2dev(&dc->chan),
+		dev_crit(dmaengine_chan_dev(&dc->chan),
 			 "  desc: ch%#llx s%#llx d%#llx c%#x"
 			 " si%#x di%#x cc%#x cs%#x\n",
 			 (u64)desc->CHAR, desc->SAR, desc->DAR, desc->CNTR,
@@ -482,11 +477,11 @@ static void txx9dmac_dump_desc(struct txx9dmac_chan *dc,
 	} else {
 		struct txx9dmac_hwdesc32 *d = (struct txx9dmac_hwdesc32 *)desc;
 #ifdef TXX9_DMA_USE_SIMPLE_CHAIN
-		dev_crit(chan2dev(&dc->chan),
+		dev_crit(dmaengine_chan_dev(&dc->chan),
 			 "  desc: ch%#x s%#x d%#x c%#x\n",
 			 d->CHAR, d->SAR, d->DAR, d->CNTR);
 #else
-		dev_crit(chan2dev(&dc->chan),
+		dev_crit(dmaengine_chan_dev(&dc->chan),
 			 "  desc: ch%#x s%#x d%#x c%#x"
 			 " si%#x di%#x cc%#x cs%#x\n",
 			 d->CHAR, d->SAR, d->DAR, d->CNTR,
@@ -506,7 +501,7 @@ static void txx9dmac_handle_error(struct txx9dmac_chan *dc, u32 csr)
 	 * borked. Since we don't have any way to report errors, we'll
 	 * just have to scream loudly and try to carry on.
 	 */
-	dev_crit(chan2dev(&dc->chan), "Abnormal Chain Completion\n");
+	dev_crit(dmaengine_chan_dev(&dc->chan), "Abnormal Chain Completion\n");
 	txx9dmac_dump_regs(dc);
 
 	bad_desc = txx9dmac_first_active(dc);
@@ -523,7 +518,7 @@ static void txx9dmac_handle_error(struct txx9dmac_chan *dc, u32 csr)
 	if (!list_empty(&dc->active_list))
 		txx9dmac_dostart(dc, txx9dmac_first_active(dc));
 
-	dev_crit(chan2dev(&dc->chan),
+	dev_crit(dmaengine_chan_dev(&dc->chan),
 		 "Bad descriptor submitted for DMA! (cookie: %d)\n",
 		 bad_desc->txd.cookie);
 	txx9dmac_dump_desc(dc, &bad_desc->hwdesc);
@@ -558,7 +553,7 @@ static void txx9dmac_scan_descriptors(struct txx9dmac_chan *dc)
 	if (!(csr & TXX9_DMA_CSR_CHNEN))
 		chain = 0;	/* last descriptor of this chain */
 
-	dev_vdbg(chan2dev(&dc->chan), "scan_descriptors: char=%#llx\n",
+	dev_vdbg(dmaengine_chan_dev(&dc->chan), "scan_descriptors: char=%#llx\n",
 		 (u64)chain);
 
 	list_for_each_entry_safe(desc, _desc, &dc->active_list, desc_node) {
@@ -589,7 +584,7 @@ static void txx9dmac_scan_descriptors(struct txx9dmac_chan *dc)
 		return;
 	}
 
-	dev_err(chan2dev(&dc->chan),
+	dev_err(dmaengine_chan_dev(&dc->chan),
 		"BUG: All descriptors done, but channel not idle!\n");
 
 	/* Try to continue after resetting the channel... */
@@ -609,7 +604,7 @@ static void txx9dmac_chan_tasklet(struct tasklet_struct *t)
 
 	dc = from_tasklet(dc, t, tasklet);
 	csr = channel_readl(dc, CSR);
-	dev_vdbg(chan2dev(&dc->chan), "tasklet: status=%x\n", csr);
+	dev_vdbg(dmaengine_chan_dev(&dc->chan), "tasklet: status=%x\n", csr);
 
 	spin_lock(&dc->lock);
 	if (csr & (TXX9_DMA_CSR_ABCHC | TXX9_DMA_CSR_NCHNC |
@@ -625,7 +620,7 @@ static irqreturn_t txx9dmac_chan_interrupt(int irq, void *dev_id)
 {
 	struct txx9dmac_chan *dc = dev_id;
 
-	dev_vdbg(chan2dev(&dc->chan), "interrupt: status=%#x\n",
+	dev_vdbg(dmaengine_chan_dev(&dc->chan), "interrupt: status=%#x\n",
 			channel_readl(dc, CSR));
 
 	tasklet_schedule(&dc->tasklet);
@@ -654,7 +649,7 @@ static void txx9dmac_tasklet(struct tasklet_struct *t)
 		if ((mcr >> (24 + i)) & 0x11) {
 			dc = ddev->chan[i];
 			csr = channel_readl(dc, CSR);
-			dev_vdbg(chan2dev(&dc->chan), "tasklet: status=%x\n",
+			dev_vdbg(dmaengine_chan_dev(&dc->chan), "tasklet: status=%x\n",
 				 csr);
 			spin_lock(&dc->lock);
 			if (csr & (TXX9_DMA_CSR_ABCHC | TXX9_DMA_CSR_NCHNC |
@@ -696,7 +691,7 @@ static dma_cookie_t txx9dmac_tx_submit(struct dma_async_tx_descriptor *tx)
 	spin_lock_bh(&dc->lock);
 	cookie = dma_cookie_assign(tx);
 
-	dev_vdbg(chan2dev(tx->chan), "tx_submit: queued %u %p\n",
+	dev_vdbg(dmaengine_chan_dev(tx->chan), "tx_submit: queued %u %p\n",
 		 desc->txd.cookie, desc);
 
 	list_add_tail(&desc->desc_node, &dc->queue);
@@ -717,11 +712,11 @@ txx9dmac_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
 	size_t xfer_count;
 	size_t offset;
 
-	dev_vdbg(chan2dev(chan), "prep_dma_memcpy d%#llx s%#llx l%#zx f%#lx\n",
+	dev_vdbg(dmaengine_chan_dev(chan), "prep_dma_memcpy d%#llx s%#llx l%#zx f%#lx\n",
 		 (u64)dest, (u64)src, len, flags);
 
 	if (unlikely(!len)) {
-		dev_dbg(chan2dev(chan), "prep_dma_memcpy: length is zero!\n");
+		dev_dbg(dmaengine_chan_dev(chan), "prep_dma_memcpy: length is zero!\n");
 		return NULL;
 	}
 
@@ -812,7 +807,7 @@ txx9dmac_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 	unsigned int i;
 	struct scatterlist *sg;
 
-	dev_vdbg(chan2dev(chan), "prep_dma_slave\n");
+	dev_vdbg(dmaengine_chan_dev(chan), "prep_dma_slave\n");
 
 	BUG_ON(!ds || !ds->reg_width);
 	if (ds->tx_reg)
@@ -900,7 +895,7 @@ static int txx9dmac_terminate_all(struct dma_chan *chan)
 	struct txx9dmac_desc *desc, *_desc;
 	LIST_HEAD(list);
 
-	dev_vdbg(chan2dev(chan), "terminate_all\n");
+	dev_vdbg(dmaengine_chan_dev(chan), "terminate_all\n");
 	spin_lock_bh(&dc->lock);
 
 	txx9dmac_reset_chan(dc);
@@ -988,11 +983,11 @@ static int txx9dmac_alloc_chan_resources(struct dma_chan *chan)
 	struct txx9dmac_desc *desc;
 	int i;
 
-	dev_vdbg(chan2dev(chan), "alloc_chan_resources\n");
+	dev_vdbg(dmaengine_chan_dev(chan), "alloc_chan_resources\n");
 
 	/* ASSERT:  channel is idle */
 	if (channel_readl(dc, CSR) & TXX9_DMA_CSR_XFACT) {
-		dev_dbg(chan2dev(chan), "DMA channel not idle?\n");
+		dev_dbg(dmaengine_chan_dev(chan), "DMA channel not idle?\n");
 		return -EIO;
 	}
 
@@ -1022,7 +1017,7 @@ static int txx9dmac_alloc_chan_resources(struct dma_chan *chan)
 
 		desc = txx9dmac_desc_alloc(dc, GFP_KERNEL);
 		if (!desc) {
-			dev_info(chan2dev(chan),
+			dev_info(dmaengine_chan_dev(chan),
 				"only allocated %d descriptors\n", i);
 			spin_lock_bh(&dc->lock);
 			break;
@@ -1034,7 +1029,7 @@ static int txx9dmac_alloc_chan_resources(struct dma_chan *chan)
 	}
 	spin_unlock_bh(&dc->lock);
 
-	dev_dbg(chan2dev(chan),
+	dev_dbg(dmaengine_chan_dev(chan),
 		"alloc_chan_resources allocated %d descriptors\n", i);
 
 	return i;
@@ -1047,7 +1042,7 @@ static void txx9dmac_free_chan_resources(struct dma_chan *chan)
 	struct txx9dmac_desc *desc, *_desc;
 	LIST_HEAD(list);
 
-	dev_dbg(chan2dev(chan), "free_chan_resources (descs allocated=%u)\n",
+	dev_dbg(dmaengine_chan_dev(chan), "free_chan_resources (descs allocated=%u)\n",
 			dc->descs_allocated);
 
 	/* ASSERT:  channel is idle */
@@ -1061,13 +1056,13 @@ static void txx9dmac_free_chan_resources(struct dma_chan *chan)
 	spin_unlock_bh(&dc->lock);
 
 	list_for_each_entry_safe(desc, _desc, &list, desc_node) {
-		dev_vdbg(chan2dev(chan), "  freeing descriptor %p\n", desc);
+		dev_vdbg(dmaengine_chan_dev(chan), "  freeing descriptor %p\n", desc);
 		dma_unmap_single(chan2parent(chan), desc->txd.phys,
 				 ddev->descsize, DMA_TO_DEVICE);
 		kfree(desc);
 	}
 
-	dev_vdbg(chan2dev(chan), "free_chan_resources done\n");
+	dev_vdbg(dmaengine_chan_dev(chan), "free_chan_resources done\n");
 }
 
 /*----------------------------------------------------------------------*/
diff --git a/drivers/dma/virt-dma.h b/drivers/dma/virt-dma.h
index dd023a3831209..abf2ae737c30c 100644
--- a/drivers/dma/virt-dma.h
+++ b/drivers/dma/virt-dma.h
@@ -41,6 +41,11 @@ static inline struct virt_dma_chan *to_virt_chan(struct dma_chan *chan)
 	return container_of(chan, struct virt_dma_chan, chan);
 }
 
+static inline struct device *vchan_chan_dev(struct virt_dma_chan *vc)
+{
+	return dmaengine_chan_dev(&vc->chan);
+}
+
 void vchan_dma_desc_free_list(struct virt_dma_chan *vc, struct list_head *head);
 void vchan_init(struct virt_dma_chan *vc, struct dma_device *dmadev);
 struct virt_dma_desc *vchan_find_desc(struct virt_dma_chan *, dma_cookie_t);
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index fe33a20abc614..33aa1bfc8fb84 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -1803,10 +1803,15 @@ dmaengine_get_direction_text(enum dma_transfer_direction dir)
 	}
 }
 
+static inline struct device *dmaengine_chan_dev(struct dma_chan *chan)
+{
+	return &chan->dev->device;
+}
+
 static inline struct device *dmaengine_get_dma_device(struct dma_chan *chan)
 {
 	if (chan->dev->chan_dma_dev)
-		return &chan->dev->device;
+		return dmaengine_chan_dev(chan);
 
 	return chan->device->dev;
 }

-- 
2.43.0

