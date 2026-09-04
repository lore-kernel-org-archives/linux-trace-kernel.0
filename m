Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013047.outbound.protection.outlook.com [52.101.83.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B443BCD3D;
	Fri,  4 Sep 2026 21:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788558634; cv=fail; b=t6AQtO3t7MA/oLg5ludJeq8JBEzUCJn1qedzdFaZvPjlfEFniTP3c6By2mOavM+dRlfzYgXOfjNdVRMXpIHAm2et0dQD2ch+3gRAeJNmwSl2LTDAsqPS+8bRicJ6Cjk87+cLKAke429ECYv9cyCu9YnZ+I2h0PkVEAEmgu+/QTI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788558634; c=relaxed/simple;
	bh=rhWg3LSHCKvortX7Vdt0vZH8HJlhnT8wT4nwjv6b84c=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=E5j87jJ+waDucYQhOgshxqtyEccJXzIufzJeSjXwIzs88wuSox74L8s0gwhX57O4iWXfw4Gd6LE9pwC6FxKeqnxfpkFQXnLagfCwHGgDGZFM/r9zjCdS+xBzW3jP6fiw3HG2KdmiBcOxRym8ry9pseeK2g8EekpVRV+bR0M5R7w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=COEJix1c; arc=fail smtp.client-ip=52.101.83.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="COEJix1c"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c2crF6NnWwUt6qw6u/GOclSOIw2oGy0DHHTdoDwEjEu5D8Rc1/vXODJYOVqpUeQy8Z7UKewQjx14HjDwaeOlfY45R76368F4a5VMAAeoW1oONG3fSQFxFujRv3suFDTA4FLjAHIQ48FIEpqvdGltD2vYG2PzdjVlIo5GMxUJEts7G71MptGR3CrcPjOfhb5YZg9KNo9kOVyr5/0JqJDWRLmiNXX0sEI1LSVjbxoEsq0nUDvkKOSBEb/GeqzjDwSRU2NmykhrOzGHyvhzW8Ox5Rsrc5whpM8aBMCyRHT0hac5rzZPuT/7yu1rMNnMQqV/xETKhXoXeg9uUUB+wUSg2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hNOD560T/beh09vChsbHC6Sl9qDf7RnGLO98gBcQRzI=;
 b=lTKp7ygawQc823NN+X28dSy+OosjUt4K0x1R/dWxM2Peotk4CnJBvVuLIbsBXmpBhFbsLC6Ed7Xb78kygZgPbOFBcoE+82ASPozOuVy2Y1LFso2oj10haI7BDZpYNa9tTXQjWsXv2xJHWG7r3aCYLSz2M3eMUpqZ7vwOBNXhvIi0qBh8xxmXNVSflulP/kG3Wb6wWZxOX/yWJyJU+1lpAmVJ39FILa3iWNIvhKAoX4Q2Crj9sDHbSz1xgvZp/zrcCuxKy+NdGjmaEF0REdPpwMYONiiatvzXvrZa0MaS7pPC74qD2kC2x8F+nCwmdWUGir+87ch/N+edSRSc60u+gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hNOD560T/beh09vChsbHC6Sl9qDf7RnGLO98gBcQRzI=;
 b=COEJix1chvVzvZLsbt7vx3higrI5KxuZmUOB80eVHVAbt7F/noOTs6Otyvu+mZb3ymSn6HXIztbwgTMmsvJrpZX+X1gqBuAD/2RW12F57/0qA8UpkxWS2zt7MCXisooWuI0Jsih2ZhEEHPQsoohcs8sO4D6DzNvCNIaw0vo1KRyMnALFXiVZqFPrrQwwZnw81YdhPwAxifARoja7zANJovhYqhgvgteB/LFFdq4N3YwxTNxCm/Xyn4qG5NutHJtdooZlAuZD7Po9giHnAljqeDomZch+RoAPZBfu5Vtl+suJFaZKGyTHPw4pgoQpAh3Eoj4cMw0N1pPKqiCc+HiuoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DB5PR04MB12227.eurprd04.prod.outlook.com (2603:10a6:10:64a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 21:50:24 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0382.007; Fri, 4 Sep 2026
 21:50:24 +0000
From: Frank.Li@oss.nxp.com
Date: Fri, 04 Sep 2026 17:49:46 -0400
Subject: [PATCH v3 4/4] dmaengine: add union chan_dev for dma_chan::dev for
 clarity
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-dma-chan_dev-rename-v3-4-685601b0b788@nxp.com>
References: <20260904-dma-chan_dev-rename-v3-0-685601b0b788@nxp.com>
In-Reply-To: <20260904-dma-chan_dev-rename-v3-0-685601b0b788@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788558597; l=6039;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=GbKASVJctzGGW5ONEIisdsQgE03H2P0+Bv1BV7tn5no=;
 b=AtvZpAKSXgVqIAchN2k9x2mNd21u8s0cj3POA3E/bxsQ2UM8TfAftwWkgDWqdad2W+Gw0fMlV
 2ZYe9hu+ZblAKnN7VB+J0cdnzarvRi5lvb5LVf0IZ8NtJo2Di89lALs
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: CYXPR02CA0058.namprd02.prod.outlook.com
 (2603:10b6:930:cd::27) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DB5PR04MB12227:EE_
X-MS-Office365-Filtering-Correlation-Id: f229b688-e276-4a4c-9c14-08df0ace8664
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|19092799006|376014|23010399003|366016|10067099003|56012099006|11063799006|22082099003|18002099003|921020|41080700001;
X-Microsoft-Antispam-Message-Info:
	7R3x11wLAdrn/4v8UMt7vAwguy6zdnC9ISV9xk005hv0uRcrS9maVtQ/LfFQlXYAVeolDM/QBz812xhYbPuPUpZIiH3/zLjyoBlgbdTjZI5R0Hdu2je7oidoLohp80H8ecdh9Olx26i8u85BMIuHonlSSGnyBprBm6EfIjzAXfNNY1b0K/HJUf/RZp1y9k7W/xF1+AIQNuoC0uDm1wmypZtfHcw16ruKtyjF52/eseTYGlnJTwNXsqikq4yCBGEy46NGhEM8NwowBjb95gHpoK9M8XCktefxv6hA9Ln3YMc241SLxyk4X8IIdq6Yqo/u03OWVwlxzYFLGBhb45i/lTzBMQa1HEG5WEkPGmTovtCMY5thhXAhN5FbAaU4uDZgZx1ic33hbJs2oSXr4jz1qN32QEPonn18to8mb44WgRKmAiiKYyTafe5p2BrQaI8llyz7e0LHmuFQLHo+319iixkhqUu1TXes+ktNEEAxggcV1CgcxYY7Y3czreRuaJ3bCb4RjalhydBxvAtE7//Jrtv2O9eEfrLTO1Dn4a7ryaM8gOSZ1BxZX6m8lQB9LSpWL+b1Eg7Fgl6WcjUHRvOarSo/ATQpuZxjNzj0BZNCnODPCBYGQ+6BW2MBfgT7tlGndvR/EcWqyhCFp59DU5TGL+eddJFD7HaOq1ovMoWrTEJj7HEJUZlk/sKLUq0n0RXcVL3wnEtBxmmaYt8Qqiy8jbhhZMcVlCaQEjBxQpHZTEo5I5fB0AMiM422aVfbmSjO
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(19092799006)(376014)(23010399003)(366016)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003)(921020)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RkF2SFY4THR2SWU3K2xGRWV3ZFlYbTk2QTAyQjBUN3VsR1YzOEdlM0Fva2pZ?=
 =?utf-8?B?VTJibTBKRFpmMDJNRi9FeVl4MWI2OWtRUDhIcXRZbXFick9CVFhYS3VkRk9z?=
 =?utf-8?B?RjdKV2UxNkVDT2twOXdBN3lWVU9seWc1NDUyazdWaGJxQ05GKzlXdGhaYkxN?=
 =?utf-8?B?Q0poQmdvcWJzaUZPTjU1ZWZxUVRoay8xdEZIc3lwZFJCcm1NUUNUeVd1ZE9T?=
 =?utf-8?B?aGNJZTBsNTFucVpGeFI5bW9pZmRMNWNETHRzNFRidlN3QnZYZEtiRW1qZGZ3?=
 =?utf-8?B?SlZtWE9reVc4bFFyWGpCYlJNTHpQSFkvajhVRDIyK3hocHBNSVVEMkd6WlRn?=
 =?utf-8?B?YXFKS1Z0Z0o5bVVPL1Y0U1c1Wk83aXRXR1V3S2RrTWc3Qy9IcnV2cS9XUlBT?=
 =?utf-8?B?aDN2V0lkY1pTcWx0WEdIVytCSlo2YUptQkVxWXJKWDBrcG1kQjZBRm1rWWpB?=
 =?utf-8?B?MWE2cXJMS2dYRU1oMDNxa2RxYWZWK0JEYU9rTGFWSjB2YUdEWjBUM2FRMU5n?=
 =?utf-8?B?cVVsOXFoL3VESG5wYXB3cGFrWlF6bUJYSkgzaDAxTC9KQmxrck95Tko2enN4?=
 =?utf-8?B?bFZja0E3NGQrRWRNMDVMQUJVWXBKdTV1WURsSWZkaGs2VDF4YWtFdkVRR3hI?=
 =?utf-8?B?eVdUT1c4NklWSGwzRXkyUUpQTlpSbjRaRjV1RnVZem1zMUk1bDJZVWJ2STlG?=
 =?utf-8?B?azQ3OGlBMHkyRlNVNEV3QTE1cG5QeEs1bDdPY3V0RnpPMzlJa1V2dEoxcS96?=
 =?utf-8?B?emdQQ0dSV1g3S21XRVVXMHE5QlVzcVNEc0hXU21BS1NFc0FGdis3ZE9KdlFP?=
 =?utf-8?B?ZHpVR0lDWkZMN0NGckFVQ1NZZ3d3Vy9aZTYwakpMQnhBeFM0ekZBQXJxbURh?=
 =?utf-8?B?OGFRenlTeldxNjhHYmhRQ0h0aHFjL0toc1JIdm9lNVp2WENkT3lQSFEzKzRV?=
 =?utf-8?B?S3V0MXZpcytOdVNSckVRUDlOWkpEY1ZYTlJMdU40N2QyMTRxUTZyMWdZTExX?=
 =?utf-8?B?R2ttU1h6MVROSnpUazAzMFhCa0xCdnQ5MzR2d1c2aEJSUDJNTE5oUG0rcjNx?=
 =?utf-8?B?MkRIRC9kNWpSWEt5ZFJsSzQ3cmxVbTFHby9WUmVRK2lrenJrS1c1QnRsYmpq?=
 =?utf-8?B?WTBKaGp2Uk9yYVlRVDltWlk2Wit3RWtPVlpkczE5MXhnNnhEdkprMEYzWEhX?=
 =?utf-8?B?VlRHbHdpUmhsQ0krWVR2bFZoM2JYRVlkUzVnUWd2UjVZTEhZOG1kQlpqNW02?=
 =?utf-8?B?UHdKVHdmb1FQQ0FDQWQ4QVZpSkpmUG1YanRrTHAyM1BQSjhZbDVJUGRwdndE?=
 =?utf-8?B?a3V4dTc2RXJxY1E1VjRNdlpGc0taZFBsRXBzK29ZZDJjVWVSMGJ0L2Zxa0xu?=
 =?utf-8?B?NGpvOTFBeG1BczdxVHo4TmphT3dqZC9XeS9yRjkrbXhydWlMY0VnM3Eyb2cy?=
 =?utf-8?B?WGJaZG1nanExRmxmSFJVNWpQRHlJdW1nRkVTQy9seEZjSnFsTFlBanFYU0Rk?=
 =?utf-8?B?M2R1RmhIVllnWHJrTkJFMHptTHRnQWZpVkZVRFVRclI1aXBGTDB0S1gwTnVD?=
 =?utf-8?B?OXppQ3FxbkhxUVFmQVVSTzU2NVMvbEVsM1p3SERwemR6TEI2NXA3aVFObUk4?=
 =?utf-8?B?VnNEYzFLTEdKU1dDdTFabW5aNmhOdGFiT2t3S1hxMEc5bkRwSjlTNVpwOU5W?=
 =?utf-8?B?bldQSlAwTmJhZTJFVzJxUWo2d0JRdUJEVDcxVm9xOVd0aVRZVENrSVJ6LzlI?=
 =?utf-8?B?WFYyemxlK01WRXZyZG5GUmoxMEJ6TUZxYklKeU84N2cxbHhZeVhqS0E3ZWJi?=
 =?utf-8?B?WEpoSTVpc3lHcmlGZWxWWnNWRytZc0FCb1F1bitkdFZGaHpsbVNOR2FGUTVU?=
 =?utf-8?B?VEFpWkZnNEVPalJvZlZIczdqalhGQjZialBnbjJGNkh0dWhkODZ1R1RZMmxN?=
 =?utf-8?B?TWdsdGZhdmFkUVkvUTM3QXBjRmtXOVRNV2x0MXJKVWlsYXQrNmc2WkVYdzYx?=
 =?utf-8?B?UkZxZDZQWDFLNE1kazNNR3lJS2hhWFNubHJ5VGtHT0N1SHhJVjZjR21LM2Mx?=
 =?utf-8?B?cnJZM2lPaVp1L3BBbDd6RkYvYmIrb0VsaUljTkUzSEpCTHVGV0Jsb2g2Z0lL?=
 =?utf-8?B?citxSnhYS1h4OGRPK2E0ak5OTGNQSGl2bWIzdnhrM1c5SHRKbzdQaEpvR0hL?=
 =?utf-8?B?QmZ2YmgyUndyNm1TZ2JNQ1F4dWVjdXlFdXVmUHg1U0dSR0NTL0pwY2dqVlZK?=
 =?utf-8?B?cHBaRDNlOVJlcW5iMktTdjFuKzlRbUcwRnJOalZmcS9IRmdUVWk0R3lnSEc0?=
 =?utf-8?B?U2VZN1NmT0EwQ2x5MVE0L0UrYXJVRSswN1BVWnlFMFpLVEtlLzZOdmNZSHdI?=
 =?utf-8?Q?w6OIuaX+qE4N/9+TjEv7qB3wlJFmgLyvXH186?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f229b688-e276-4a4c-9c14-08df0ace8664
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 21:50:24.5677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fWG0c+57WZt8Wux36UD5F6B4BL6YAdnaVOHyEUHBsAJO22xq/jHTB92HZWQUjlkXEIsvbiq+4h57Y52ARczz5LDnCPkOthO5qvl68AlyeG3dWeOKlOEhUARtWjeSl6yH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR04MB12227

From: Frank Li <Frank.Li@nxp.com>

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

No functional change intended.

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
there are other user use it outside drivers/dma/ directory.
---
 drivers/dma/dmaengine.c        | 14 +++++++-------
 drivers/dma/tegra186-gpc-dma.c |  2 +-
 drivers/dma/ti/k3-udma.c       |  4 ++--
 include/linux/dmaengine.h      | 18 +++++++++++++-----
 4 files changed, 23 insertions(+), 15 deletions(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index a7ac2729e4d9d..bb30a9aa54d3f 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -1083,8 +1083,8 @@ static int __dma_async_device_channel_register(struct dma_device *device,
 	chan->local = alloc_percpu(typeof(*chan->local));
 	if (!chan->local)
 		return -ENOMEM;
-	chan->dev = kzalloc_obj(*chan->dev);
-	if (!chan->dev) {
+	chan->chan_dev = kzalloc_obj(*chan->chan_dev);
+	if (!chan->chan_dev) {
 		rc = -ENOMEM;
 		goto err_free_local;
 	}
@@ -1103,8 +1103,8 @@ static int __dma_async_device_channel_register(struct dma_device *device,
 
 	dmaengine_chan_dev(chan)->class = &dma_devclass;
 	dmaengine_chan_dev(chan)->parent = device->dev;
-	chan->dev->chan = chan;
-	chan->dev->dev_id = device->dev_id;
+	chan->chan_dev->chan = chan;
+	chan->chan_dev->dev_id = device->dev_id;
 	spin_lock_init(&chan->lock);
 
 	if (!name)
@@ -1122,7 +1122,7 @@ static int __dma_async_device_channel_register(struct dma_device *device,
  err_out_ida:
 	ida_free(&device->chan_ida, chan->chan_id);
  err_free_dev:
-	kfree(chan->dev);
+	kfree(chan->chan_dev);
  err_free_local:
 	free_percpu(chan->local);
 	chan->local = NULL;
@@ -1155,7 +1155,7 @@ static void __dma_async_device_channel_unregister(struct dma_device *device,
 		  __func__, chan->client_count);
 	mutex_lock(&dma_list_mutex);
 	device->chancnt--;
-	chan->dev->chan = NULL;
+	chan->chan_dev->chan = NULL;
 	mutex_unlock(&dma_list_mutex);
 	ida_free(&device->chan_ida, chan->chan_id);
 	device_unregister(dmaengine_chan_dev(chan));
@@ -1290,7 +1290,7 @@ int dma_async_device_register(struct dma_device *device)
 		if (chan->local == NULL)
 			continue;
 		mutex_lock(&dma_list_mutex);
-		chan->dev->chan = NULL;
+		chan->chan_dev->chan = NULL;
 		mutex_unlock(&dma_list_mutex);
 		device_unregister(dmaengine_chan_dev(chan));
 		free_percpu(chan->local);
diff --git a/drivers/dma/tegra186-gpc-dma.c b/drivers/dma/tegra186-gpc-dma.c
index b3327aa35de40..e76c58f213d84 100644
--- a/drivers/dma/tegra186-gpc-dma.c
+++ b/drivers/dma/tegra186-gpc-dma.c
@@ -1554,7 +1554,7 @@ static int tegra_dma_probe(struct platform_device *pdev)
 				return dev_err_probe(chdev, -EINVAL,
 					   "Failed to get stream ID for channel %d\n", tdc->id);
 
-			chan->dev->chan_dma_dev = true;
+			chan->chan_dev->chan_dma_dev = true;
 		}
 
 		/* program stream-id for this channel */
diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index 49e2d0014d5ed..78a67cb9d6e00 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -426,12 +426,12 @@ static void k3_configure_chan_coherency(struct dma_chan *chan, u32 asel)
 
 	if (asel == 0) {
 		/* No special handling for the channel */
-		chan->dev->chan_dma_dev = false;
+		chan->chan_dev->chan_dma_dev = false;
 
 		dev_clear_dma_coherent(chan_dev);
 		chan_dev->dma_parms = NULL;
 	} else if (asel == 14 || asel == 15) {
-		chan->dev->chan_dma_dev = true;
+		chan->chan_dev->chan_dma_dev = true;
 
 		dev_set_dma_coherent(chan_dev);
 		dma_coerce_mask_and_coherent(chan_dev, DMA_BIT_MASK(48));
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 33aa1bfc8fb84..206c5dab96cd7 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -325,7 +325,8 @@ struct dma_router {
  * @lock: protect between config and prepare transfer when driver have not
  *	  implemented callback device_prep_config_sg().
  * @chan_id: channel ID for sysfs
- * @dev: class device for sysfs
+ * @chan_dev: class channel device for sysfs, some device use it for per-channel
+ *            iommu mapping.
  * @name: backlink name for sysfs
  * @dbg_client_name: slave name for debugfs in format:
  *	dev_name(requester's dev):channel name, for example: "2b00000.mcasp:tx"
@@ -351,7 +352,14 @@ struct dma_chan {
 
 	/* sysfs */
 	int chan_id;
-	struct dma_chan_dev *dev;
+	union {
+		struct dma_chan_dev *chan_dev;
+		/*
+		 * please use chan_dev, dev will be removed after all user
+		   switch to chan_dev
+		*/
+		struct dma_chan_dev *dev;
+	};
 	const char *name;
 #ifdef CONFIG_DEBUG_FS
 	char *dbg_client_name;
@@ -532,7 +540,7 @@ struct dma_slave_caps {
 
 static inline const char *dma_chan_name(struct dma_chan *chan)
 {
-	return dev_name(&chan->dev->device);
+	return dev_name(&chan->chan_dev->device);
 }
 
 /**
@@ -1805,12 +1813,12 @@ dmaengine_get_direction_text(enum dma_transfer_direction dir)
 
 static inline struct device *dmaengine_chan_dev(struct dma_chan *chan)
 {
-	return &chan->dev->device;
+	return &chan->chan_dev->device;
 }
 
 static inline struct device *dmaengine_get_dma_device(struct dma_chan *chan)
 {
-	if (chan->dev->chan_dma_dev)
+	if (chan->chan_dev->chan_dma_dev)
 		return dmaengine_chan_dev(chan);
 
 	return chan->device->dev;

-- 
2.43.0

