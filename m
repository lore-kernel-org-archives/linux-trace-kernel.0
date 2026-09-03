Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011029.outbound.protection.outlook.com [40.107.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C515340DA6;
	Thu,  3 Sep 2026 20:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788468825; cv=fail; b=uaSQsBY8H+Pd+Y/fbZbYyvuvXrknw2iDScQaBXLWqGHp4930+a5PklNTMLGPBCPWw+AJPLTFp2/gE5kcUiMZXWS0Nx/1+uQ4yTjKMuEWVXZEjwac2jV1PRmaslNhxRgM5e55kkwsA99Fqi/SF4u5UKsCb0IxbCDBUC5Nc83S+T8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788468825; c=relaxed/simple;
	bh=h60rf5UbjuSAb5W0ZT2gxInSKCjwoe1HMwHZDA9Wz7k=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=VlhqcAI9+qs0s2ZOMPv9QsvQvGG1uLzx0draTpDTSQtIkHEgz4fLL8oTLNvOdNDvFQ77o8N9RM9cIWepbXTdkcHfvgHkZn3VKMOJRQj55Rx0mKXQ0LTvcKekb0DpXbzmkZSsrA99cVr7/YZen8Nv+y0OwbQ2ROBqZWLFHuWQBb4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=ES26CSjC; arc=fail smtp.client-ip=40.107.130.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ES26CSjC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D1eJUZdfSiCAqwOpYWBjfkyx/NiC0/7Kn7YzoacjeR9hPkjsGTOBSdCHfi+Xz+cmzTlqaZoWWMNWFlrlnXV4f+FEhikeFAlfXm90syDoA0kH6v0SfCN13l15nUBn6v86yfESNIfeGfIpAXEi4gkm0m3Ha0bMSsFgnkjq7zYaXeFSvC0ZVBtGQQ9zFHurWZlTjOTW6eqmq+6sxleR9t61yh3CGigUjkbZEXXXbZNrZhfj/UWwgz7i/nz2lt57yqGXzo6gXN//mSrrno9OiVb38HeH0PH6UM0WvbqAAwI1he2fn3el7Rksf/bPtwmqaNnuBahCYQW/rSN4MwBycZN9sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xIrtL3aikHbKSqShfTCH663/0vOwr1XhVsAFtET2HvE=;
 b=htsX858/nFcROY2osj7kpjNXugw4hOTTzYjEw+1cLx5ISbdoffPVXSjHfZkJ8lkr5VbJaqmGAzE/OInzLoMknACbDIy5pTjOH3gSxUXL2U7sB909tpoE8VD8LeelGEJwwJPyeQ2J/6Wq1LwFGAa9CH74DJOKaKjKPPCkSUJ6u15afbiTju93zvODDEO591897nGE3z7TXv9rvcT8RfdJh9jzz3OAjt4XNflIE8ktQfvfGxzb7I06d0v9RnNK1rwd4nm6dSuMCiclPSnOmgSCsDHQPYwe+aNs/TIlZAqCY77dll8+WQyBa+fGudiDiKGXwIzNDdPnz2x8gsQfA/4zVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xIrtL3aikHbKSqShfTCH663/0vOwr1XhVsAFtET2HvE=;
 b=ES26CSjCXukk+XIx2fKj01JJ19hr6ySRUhOYlxxeKQGZPksTYRNpHMEjkzoONQ05Mw20QhKTSDmp/ultPZ4FLpPHIKdiYHLeP26qgM0DfdbGPnAYL/ERhLj+udwn4GpS+lr3VrqYSPKN4gxeifCRqN7vDn3+Vyfxg9izefGQrB+6mtycDAaadgf1tdomCizPCgpXPXrLsxSM2YRrS/X3slkpua8vFoDIyywyaVmBmrn/pZyEjwBgsf0RzZMIp12Maf8kCJeWLIt46uiP/bNbvP1VeHGqztVrRRek+JppQGpSxKwn9le3XgfPDgXRFr1d0ExL+O93unNAwibYJP5jRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by GV4PR04MB11894.eurprd04.prod.outlook.com (2603:10a6:150:2ed::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 20:53:27 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 20:53:27 +0000
From: Frank.Li@oss.nxp.com
Date: Thu, 03 Sep 2026 16:53:11 -0400
Subject: [PATCH v2 1/3] dmaengine: vchan: add vchan_chan_name() to get
 channel device name
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-dma-chan_dev-rename-v2-1-0db305b6c716@nxp.com>
References: <20260903-dma-chan_dev-rename-v2-0-0db305b6c716@nxp.com>
In-Reply-To: <20260903-dma-chan_dev-rename-v2-0-0db305b6c716@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788468796; l=3695;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=8jHlCxUSDmTqFQA8Mc67+lAJmYQGqw16V760AwED3Qg=;
 b=bo2kXoZRCKprJEX7N9nUIx0ExG7ecn8AP/b21t9HeSQFuyu4JevCpVVqtXi/tpAmYDOrffmaz
 XyZFGDy9scEBG+tX+2na1KQs970joi0SK32VGcUVwEKY9IiPnmZkaLP
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH7PR10CA0002.namprd10.prod.outlook.com
 (2603:10b6:510:23d::28) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|GV4PR04MB11894:EE_
X-MS-Office365-Filtering-Correlation-Id: c80ac412-16e5-48d5-ed5f-08df09fd671b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|376014|7416014|23010399003|1800799024|921020|11063799006|10067099003|56012099006|18002099003|22082099003|41080700001;
X-Microsoft-Antispam-Message-Info:
	0xkzsIMqj2L7OHaLJ5Mjgej2O5xHVkLOGwJYPEfZtUHuA8xC0c7G1ya6QhopD9FC0Wuj6g5/0ko7XWsL+m1HzO1SZ4wvQVXba/WAqkB16r8GRUTgDryfBY/I6TCQYLq/oyMu3V6ElEgcT4k3d4jrCnwrI5LLCWWOgyZbMvZjDKxyT2jHeKeeLdSXx33bNM8ICJFPD3fPHmUtuWekxOTAYdAsDeWCbpCkgizPSPA9vq9Gn1ps8gx1pVlKfG9qw1xOwDIBofdZVWm5A4E5g0mRfs1v1d7RDgv1Gann0Xcf8Z7lvjBEd25B+g4lNkQDGv/n66ivcKfSTMHD8hpJV9SqnTa/0xE8D4ar/DoypPPV4pEq1pkBhWRbA0awinv3LvnIbw8G5S6yKh6kYtTbJTpAqxsQSUCXgxXAr95494zFHO/K/HLBIbGdKJkzULJkf5BgYJrNx3WGXfcjuPR9WQugJdBhCZeuLgVq1NfHB9IhD5w0sXoxCK8LQAxgznL6XaYmofJVJSinYM7PyM4mrHP8+QuslDrN9iGv9vXbT29gt8NAZgLmD/Gl85SF+8JUt6xNASL/+AEgxOmIetRxZSSRmI24cdQfBSd5CW6i85eDHBoqudZGOIK0Jd0Phe5feq4HoKeOUqInTbd41xoNbD/BDXYSbJrQHAUjyRosbXA1oeQnfmgZrbpPb/3j4HJaK8qnUVt6GEyoefH+U1w6Agq1xIaFdUCQd07YNiOlDu9HPz97I5xK5pcmafNYqjcCa86U
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(7416014)(23010399003)(1800799024)(921020)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Nkg1bzltOUs0U1BEQWVNSGlrMjl3RWZvYmNFdGwxWEVhMUJJZXZqWUQwOU9Y?=
 =?utf-8?B?OWV2N25GYUpWWHdhdDZEcnN0Qk1PcUlia1ZSVkFKVEtadnpZOTJUNTI3Zkcr?=
 =?utf-8?B?SWMyZll1U0dMK0pCYS8yY1JsbnhraU5EcmJHS2VheWpDZjZvZWNxMmExZE5P?=
 =?utf-8?B?enVtd0xUejU2cUxieGZ0d3lVbElhSUhGdHVaMFdqSTJTT0hHems3akl2VHlt?=
 =?utf-8?B?R3pQVFd6bDU4VkY4QU1ZNlBITklTOHBEVk9IL3g2YXJDMm4xL1ZvMlBUUVNu?=
 =?utf-8?B?V1dVcUV4RUIzVXA0blZZWVdPcG1PNmJRaEhuVHNrSmkycDdxTWZYYXR5bjQx?=
 =?utf-8?B?clJhQ1ZrZ1JUYXQrY2FZRmNxNXdmR3JYRGd4QVhzdUJ1end0Q3crdGZKcDlE?=
 =?utf-8?B?VHBkMzhSRnJ2Y3ZuTnM1YUJtbE04Sk5MdmEvSHFSc05SOWlOOHFvaFlEamFa?=
 =?utf-8?B?M2NrS3JzV21MdTFudUhINm9zNERCWDJCOVZJN1M3T1dLanRGbUZVeC9vakxM?=
 =?utf-8?B?WVhnK242RUFDU3VSSmdhWVFhakw0L25NeHlpazVZZ1F6VU1hVVZicCtpOFdU?=
 =?utf-8?B?aWl3MmhvUWxXWDZqbzdlMGxwcm8zRlNnQmJzYXp2RUhaOExoei9LTUI0TFpn?=
 =?utf-8?B?bm5BR2VRV29qSkh0Rm5VZ3BaUXZqakh4S0s4YlpiRE4yVFRCZ1VxQmhjRHNO?=
 =?utf-8?B?WGNVTzNSaGRhSyt5bjVhMUsxakhhWFhWbS85VjNNYlkzU05BVFlyL2YyMHRX?=
 =?utf-8?B?c0ZyT1E0UmVaV0dCdEhpTXJua0pHVVZUcXRkOHpwcFFsWG90TTFidVRYZm1I?=
 =?utf-8?B?Kzd3bEJhWUFhRnNTZXUzdG5DVU1GZ29hVjY3ZTg0b1AyK1Q1VC9OdnJnRzNn?=
 =?utf-8?B?aHh0VkF4Uml1N3ZneUU0bktlaGVSTDhQLy9oV0N0T3hIZ1dISVNpbnJNS0tW?=
 =?utf-8?B?VEgrdzdUenpFK256RFdVVDVSdnZ4RGJaMXVPUVJpd1B2aGZqWXFjNk9aaEpZ?=
 =?utf-8?B?RnMya3F6bHE0WFF0SzRacm5iS1JyVXEzcWRndHV2dWhRWVpGSUFDOHdmbDY2?=
 =?utf-8?B?UnY1SkczbytJRVN2d1RBUVV5K1BTaXZnRkx2U2psVG1wamJ0VXJ3TjVwTnlR?=
 =?utf-8?B?dllRa2VFTUovWU05Qlc4ZGkwczRHL0FJalJBdkpHajlIMWJTVzNKU0YwVnho?=
 =?utf-8?B?L254MTQ1OC9XL1VjU3ViL244QlROZXdOdWhYVmVZTnJORERVYkFVLzhJTVR2?=
 =?utf-8?B?MnlHd2d6bkhmUXBaYlQrUE9nUS9xUkE3OXVrTVdWYm9YcWJ6TGN6QXdLUlhh?=
 =?utf-8?B?YTFvUHZnL2pqbUtuMjhKUlkyRFVuRlMwTEppbHVJRWxDRVdYQ2t6NnZCUWVu?=
 =?utf-8?B?NHhXWmlaaU15UWx4TXM1SGpQU3VTM2NVRitFc0RkYU50ZjRLK3l3UnhBU2ZW?=
 =?utf-8?B?Ym1uQ0E1akcyWmdTTEtQR2h5K2xtaXlaa1RSS3VVYkgxQklaSnFNeER4WGU4?=
 =?utf-8?B?dDE2ZTB4S3F0UXM0cHpVVHBpRm1NRFhFNGpHRnZyY004djlUMitpWDZaaEFH?=
 =?utf-8?B?ZXNSeFJCNU9nTVM3d2E3UGdrWldaUGUrR1lYTkNnMjd1cDZXLzY4Vkg5RExD?=
 =?utf-8?B?YXNZMnVvRXdQaW9Tcks2eklPemxackkxUTlTaHB6amhkbUdYdCtrNkhtQ0NH?=
 =?utf-8?B?U0I5emFFRkE3c2ljdUtwYTd2aDA3eUhIbnRpK3ViNG1QaGxVOUJ5K2FjNm5N?=
 =?utf-8?B?ZitKMUtGT291dTIrQnh1d25zMk4zclV4V0hSQ1NnV0M2UmlCZThhZXZzeS9n?=
 =?utf-8?B?cXZCZHNKNkdZa0NWbU5tRWZVcTVDcmI5ckd3bXgwZmNhb0hjR1JBUFRJTVJq?=
 =?utf-8?B?UnRCK3FvVzlKR1RaNG5HSXdyTU8zeEp6R1UzcUZSa3dqenQ3VlE1YkM5VE1E?=
 =?utf-8?B?ZVBqQ2JrMmxyUGhqdklIMkU0em9RQkpDSCtYQ1pkUmVHRXFCSlR4RHlWRXFl?=
 =?utf-8?B?MktQU2E1bWdnWWNQV2xmSWl5NTNaRG1RT2g4bWQ2dkRoQVY5U21NNWtOdWM2?=
 =?utf-8?B?MEYwdDhTYWNlNU5LdGhJNExQckdjbUJob1Z4NS9xU0FObzBuKzVKQVJEdHhw?=
 =?utf-8?B?SUwzOU8xUTJSdTBZUHNaNXRoS04xdWx5dTlpTUk5SkEwVzBIVHdkQjFqaE1z?=
 =?utf-8?B?ZTFrKzJvaHBRRk5ONnNmRy93M0g4S0ROM2NDdmtnRUQwZkpoYmg4U0Z5dXpY?=
 =?utf-8?B?YjNLL2VoRUxYUjY4NkZpTGtqanlpR0tsNldhOW56WHVCU1IxMDAxWmpyaTFt?=
 =?utf-8?B?eXlVc09VcU14ajBSRlBEK0FwQnNLcjJiV1NnemJYWExmc2V5T1JtMHV5WEx4?=
 =?utf-8?Q?MjeoVGgehBmLFP9nF8KFxbM7i6WAC5MjjjqLg?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c80ac412-16e5-48d5-ed5f-08df09fd671b
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 20:53:27.2547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OeSoVYlj7G5klUkKzLoB4gX7vMJNIDJUe8nhSYlYPCv6pO3Evs+7qr4LdL/1+ENm2lHob7lYd0YT8JoONbxbu+2T1GNnXCEM7cbj1j2Vq/oVSLHD3IsTK4LfYT3RYxix
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11894

From: Frank Li <Frank.Li@nxp.com>

Introduce vchan_chan_name() to obtain the DMA channel device name.

Use a dedicated helper instead of directly accessing dma_chan::dev
so callers remain unaffected by an upcoming rename of the struct member.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/arm-dma350.c                     |  2 +-
 drivers/dma/loongson/loongson2-apb-cmc-dma.c |  2 +-
 drivers/dma/stm32/stm32-dma.c                |  2 +-
 drivers/dma/stm32/stm32-dma3.c               |  4 ++--
 drivers/dma/virt-dma.h                       | 11 +++++++++++
 5 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/arm-dma350.c b/drivers/dma/arm-dma350.c
index 09403aca8bb06..52f5242ea3327 100644
--- a/drivers/dma/arm-dma350.c
+++ b/drivers/dma/arm-dma350.c
@@ -512,7 +512,7 @@ static int d350_alloc_chan_resources(struct dma_chan *chan)
 {
 	struct d350_chan *dch = to_d350_chan(chan);
 	int ret = request_irq(dch->irq, d350_irq, IRQF_SHARED,
-			      dev_name(&dch->vc.chan.dev->device), dch);
+			      vchan_chan_name(&dch->vc), dch);
 	if (!ret)
 		writel_relaxed(CH_INTREN_DONE | CH_INTREN_ERR, dch->base + CH_INTREN);
 
diff --git a/drivers/dma/loongson/loongson2-apb-cmc-dma.c b/drivers/dma/loongson/loongson2-apb-cmc-dma.c
index 1c9a542edc859..2f1c8c4fd0654 100644
--- a/drivers/dma/loongson/loongson2-apb-cmc-dma.c
+++ b/drivers/dma/loongson/loongson2-apb-cmc-dma.c
@@ -678,7 +678,7 @@ static int loongson2_cmc_dma_probe(struct platform_device *pdev)
 			return lchan->irq;
 
 		ret = devm_request_irq(dev, lchan->irq, loongson2_cmc_dma_chan_irq, IRQF_SHARED,
-				       dev_name(chan2dev(lchan)), lchan);
+				       vchan_chan_name(&lchan->vchan), lchan);
 		if (ret)
 			return ret;
 	}
diff --git a/drivers/dma/stm32/stm32-dma.c b/drivers/dma/stm32/stm32-dma.c
index d3ad78562a140..3e8151e2ad75a 100644
--- a/drivers/dma/stm32/stm32-dma.c
+++ b/drivers/dma/stm32/stm32-dma.c
@@ -1668,7 +1668,7 @@ static int stm32_dma_probe(struct platform_device *pdev)
 
 		ret = devm_request_irq(&pdev->dev, chan->irq,
 				       stm32_dma_chan_irq, 0,
-				       dev_name(chan2dev(chan)), chan);
+				       vchan_chan_name(&chan->vchan), chan);
 		if (ret) {
 			dev_err(&pdev->dev,
 				"request_irq failed with err %d channel %d\n",
diff --git a/drivers/dma/stm32/stm32-dma3.c b/drivers/dma/stm32/stm32-dma3.c
index 4724e7fa0008e..1ee1bd22703fb 100644
--- a/drivers/dma/stm32/stm32-dma3.c
+++ b/drivers/dma/stm32/stm32-dma3.c
@@ -1892,10 +1892,10 @@ static int stm32_dma3_probe(struct platform_device *pdev)
 		chan->irq = ret;
 
 		ret = devm_request_irq(&pdev->dev, chan->irq, stm32_dma3_chan_irq, 0,
-				       dev_name(chan2dev(chan)), chan);
+				       vchan_chan_name(&chan->vchan), chan);
 		if (ret) {
 			dev_err_probe(&pdev->dev, ret, "Failed to request channel %s IRQ\n",
-				      dev_name(chan2dev(chan)));
+				      vchan_chan_name(&chan->vchan));
 			goto err_clk_disable;
 		}
 	}
diff --git a/drivers/dma/virt-dma.h b/drivers/dma/virt-dma.h
index 59d9eabc8b674..dd023a3831209 100644
--- a/drivers/dma/virt-dma.h
+++ b/drivers/dma/virt-dma.h
@@ -209,6 +209,17 @@ static inline void vchan_free_chan_resources(struct virt_dma_chan *vc)
 	vchan_dma_desc_free_list(vc, &head);
 }
 
+/**
+ * vchan_chan_name - Return vchan DMA channel device name
+ * @vc: virtual channel
+ *
+ * Return: The name of the DMA channel device
+ */
+static inline const char *vchan_chan_name(struct virt_dma_chan *vc)
+{
+	return dma_chan_name(&vc->chan);
+}
+
 /**
  * vchan_synchronize() - synchronize callback execution to the current context
  * @vc: virtual channel to synchronize

-- 
2.43.0

