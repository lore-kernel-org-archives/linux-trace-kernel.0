Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011021.outbound.protection.outlook.com [40.107.130.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EBF3BCD3D;
	Fri,  4 Sep 2026 21:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788558609; cv=fail; b=knBhDzzHF3l7Zb2hOrnTey+Z9lj0e+pHmqfDlbetcr9mkmgbTgSkVniyHT6iQ0wsmDDkuc8Y2vmH8tBclN+DGpj7aLMmxlYJCra7o0sccEewr1nrh4y2/j1gFjvNC9GwbR4Rt9BeBgkyoXkq6Wqia+0/YcNEUTF5yswAiG/rBoE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788558609; c=relaxed/simple;
	bh=Iz18q3YPb98fKzkmx1z2iPR386MGdkbCyCjNkYrVyAg=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=qJkHZ6Tl6ReoRDEVSvFvC4WKE22VAr3gg8Cu7+mdsGx4icD0C+ebPH73jBOxmdekg/v3/V0z3/gqcr/FKncrOugF75QY5r/FRLwM9aHbohDpdhWQxRzlfjNgONIC3f+JBQeFRviCBJ6tc8wVoP1oKNz7WjmwjAeHESsFlRDb88k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=XwY/4JAw; arc=fail smtp.client-ip=40.107.130.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="XwY/4JAw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kadPSMffQCebe7AFKBidnFNt9r0s2Wuh/Gm0QcQhym+Xj4/Z6pZ19zx/UPnFz9hV/hZz6ZGUw4RZ5PqN6d0mGm1Xgd2fYEb/x5NdaawZCE1joW98LjlehKsrh64DMEK8vVYDgFTJy0z93x5Xi/H/DhoRkOMPl+UWIF+fRf+wNYzew58f+z9jsUMxw0Flss1wax4X3otABjalk1XrJpYK6HNMr8HguIQCS2YywJY7dlPmTcks6BO3GavxJ3BWbNB8o7LwVTqmXtMyOpwxDGWedjsYWruvRXEPo+iyqDlbjGbI4JLKzNRxDwsJOzj/pSkPdJ/msFFjf7t3cHD6nvB/sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lTl/9uc6WiU9isqcRUkabGsmk3gnyr5Plk0Jxx4ED0Q=;
 b=JbYfTeVWKqlUGiy3JgYY+P61TuvO3E2PklV7Q6d8I68an6BHOf9kGRcvDgCouqnckBqPTs3OI75/kbQ3k9feJD141fFn8F0xzdkmWTgcICwXOESBMXmPjtyxLoRPYGChKJTUzFAUivxSoWtwVYNUfRSzX7t7ABK/dpoUkbKX+IaV8PNzN2TQ/ShuP8IHFTQb7wgQBVHZ2xoYF56Z6GCv/Av8U7p8ovxm5FArOM69dYueInhAfsmJg3SNocJJVChlBf7eFSSfbqLX9UjP/XGztPuxN8KyDd2AsvLCVXMQkWiMcWVUxMr7sSjfhldben4iEW8oJ+sxULQwiS8UUswrsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lTl/9uc6WiU9isqcRUkabGsmk3gnyr5Plk0Jxx4ED0Q=;
 b=XwY/4JAw+Xv9/OIjO//eQN229W+t3e/CnOZT0bssnoXIb1ClkgDwzO1gUdWFVq/Tglnwi3y4agPpKj7HMxYun89s9ZE2sp2sT5FsFlWms32UNrFfD2ql5mA0ZKMPlVF2/vGBYnCom0BlgLhujW0/PVFv+cXf9TpdTTHJW62NeNatTKZlJdlDkZ0szUBZu0sZ6v6frQdg7CN9rERvVsfP7UzfCZDJ6VjW7fvoO6Ce521SO2E6AddJwmOvrd5unkHYaqYZEGdiFPmOvTl74rTKA8CaD7jhSeGa/NEA3Z9WiQly+wkLimqD/lzP+otsewR6+z/GDRbI1g8jMsfdlDgG4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AS8PR04MB8932.eurprd04.prod.outlook.com (2603:10a6:20b:42f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 21:50:03 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0382.007; Fri, 4 Sep 2026
 21:50:02 +0000
From: Frank.Li@oss.nxp.com
Subject: [PATCH v3 0/4] dmaengine: rename dma_chan::dev to
 dma_chan::chan_dev for clarity
Date: Fri, 04 Sep 2026 17:49:42 -0400
Message-Id: <20260904-dma-chan_dev-rename-v3-0-685601b0b788@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPY8m2oC/33NQQ6CMBAF0KuQrq1pp6GIK+9hjCntIDWhkBYbD
 OHutrhgY1z+zJ/3FxLQWwzkXCzEY7TBDi4FcSiI7pR7ILUmZQIMJDtxoKZXNF/uBiP16FSPVEq
 QQukSla5J+hw9tnbe1Ovtm8OreaKeMpUbnQ3T4N/bbOS5938hcsqokhUXvK1MqeHi5vGoh55kP
 8Iu1Ez8FiAJzDSClY3UFZe7sK7rB36BfGkIAQAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788558597; l=4241;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=Iz18q3YPb98fKzkmx1z2iPR386MGdkbCyCjNkYrVyAg=;
 b=99EnACD20tdz5KQPldkdQ5SDCnj6rFMhLv7TXzNPcnmZtoWOhjqQd1m4M/TWlwfGVgQ2i+e4T
 ASsDGvoap+VAFThvwO4GMazPdn3oIGLAbBl390Pq8rDXtO+j9VfIlj/
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: CY8PR12CA0047.namprd12.prod.outlook.com
 (2603:10b6:930:49::20) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AS8PR04MB8932:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e80f738-9b55-4123-1e90-08df0ace7932
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|366016|7416014|376014|1800799024|921020|10067099003|11063799006|18002099003|56012099006|41080700001;
X-Microsoft-Antispam-Message-Info:
	wstk0lSvTtZRBxfJMUKvdTlh/zPAekIDhC71tt6mb0pOXtwlpdIAN2u+nZNjF329LFb6IW5SsgfgpCAhmpvWclckLbkyvR3w6ivgciqyC3UieyZpCkmgG/tkEXrQ9qlX+SQPxA6nLMw2t4kzOkGj/0tIzBGes/CVD8T9M8AGDWIudgxpR//IH8Y1o/McosA+yciwKlRoggjTz6NOoYj4ZoMHyulSnnjOKmU5ZAW6DWRB03ypJmyCqasxy8rUC7YSTJjZykqJLgt+5yEJP3BCLA+HRtncRuGOhhZy4o+sfawd1WwlpOb1XToxNnB4cxHbcDU9DU1/+Xzj190Gh8kwcFlIZQi8jmveD4TpKeokowuCSkvMyrFeKuZIWszGCZ9AXjUfXIiRi3djVP03JHgn8MPeGYWW6G1SjGFw2h+DCDFghVDCMO3KLALttbpYHn/31L1iM+LwGH5MlK4RRqADMRWgAjC9aOZkzIIEyqmfukSHY1zYoiLizvzc56vJVP3OkYd8GKijCsOmLSqqii+9VbcvcyGQQ5nU7E7f8PxknT4mrguxOPDRfW4fJi1Eh08y6ffh+aUSSl7uscFE2t5EsV7T38211YO/1xQ0kPI6lxBKiV1+hb/0y2nLr1JGTnqogJ8pJAYVk0CafJ+pU11cmYtJcDTW+tNXRmspjsnIcUN1JkfYu1uOlQKZ05rAoJ4B
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(366016)(7416014)(376014)(1800799024)(921020)(10067099003)(11063799006)(18002099003)(56012099006)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NnVNRDF4Kzk5T2lRalh5ell0RTk0b01KdmphSHQwdzBKRmVjT0JkWU05S1Yw?=
 =?utf-8?B?S3E1SDRkV3YyRkJza08wMkx6dmRpVTFJNC9TSU1SYzBvVXppbnJNblZ4ODdj?=
 =?utf-8?B?bHJDZkVFa0hFY1MyWVRtZVBmdmRlSDF4aCthL0tiUHgvdGxhdnlKS09iZ1Zs?=
 =?utf-8?B?bG5CMXRBRTdUOFVETjBXdEdVcXF4cy9yVGZ2UEZHK0oxR3grdXdkM214TlV3?=
 =?utf-8?B?ZUw1U2ltdXJkcHl6RC9kc1p2M3QrMlVSeU9wTFRTQ3RJTnJIeURaTFlPbGY5?=
 =?utf-8?B?WkVTbWVoUHRFd1dDM3BSbkZ0L2haamIrRkhHMmdOb2xOVEFjQXFsTFFtbWxL?=
 =?utf-8?B?YnZLZDEwVUMvTm5VWGV1RGlRZ2x4QklaeG9lVFh3SkJtUDY1eDh4UTJEc3Ro?=
 =?utf-8?B?dmxqV3NudXFJSUlkVHJ0ZXZtbmJmSmxxS0NTM0N1N2dLWXZXWVh5WCswS2Ra?=
 =?utf-8?B?Z2ZGM1gwMG0xaGdReEd0Z0VoaXFjMHhmTDljdWZUZnZEYzl6OWRUUCtEQnVF?=
 =?utf-8?B?c2dyeWU2MjUwNWYrMW0rWUlYNUtOanhHQ1UwK29RdTI3Y05WUmhpMmlsLytX?=
 =?utf-8?B?UitMazdVSlFiR1g3TDkrQWhmWTdtQXBpSFNDblZ5V2pwd3BvRHJBcFZXOW0r?=
 =?utf-8?B?Ym05YUtqMUJFVzNvZWVIQUVGNnVCSFBrWDVjZGlSbG9UM243bWNSSlljck1G?=
 =?utf-8?B?K3N6cUhhbFBMQ0Q3ZGo1N0oyMG5Kdy80RVhVRVJweE9GajhZVUt1M21WYW5W?=
 =?utf-8?B?R2NtWGNDTUdHelQrb0d0RnczeW5zTGpKSndYaFBSTUV4SHNrN2E5eWdQV0d3?=
 =?utf-8?B?RUxZaThVSWxzbGE0L1liQ1RUUXhWUWp5Y2t6TFl1dFBhcXp6bUtoQ3VQR2RK?=
 =?utf-8?B?MkFEcFVFU20wVmwxZ25YSDlrUnBCRVNTZCsvU0hSU2hTTTltR0pFeW9wckNQ?=
 =?utf-8?B?UGM3R3RUalZSMXZoMGliSW9obGVNNVRWOGNvMmtSTWJJNldhYWNJSWpEQzhL?=
 =?utf-8?B?TzZwMk9XemJlYThJd2tSOGF1aElVNEFnKzNHUXUya3pmMGNRZHUzbVpQZUtF?=
 =?utf-8?B?bEhkRmVPRUc0MFFOSGNrcXRoUTgrQkhMMGVGdDB6cDZRK0RJRkpWZlhVUndy?=
 =?utf-8?B?VGtBb1d0SVhESFBIU1ZxVWx6eEc4SEU5c2MyYlVNd0NXMTRaZVJSRWIya2FB?=
 =?utf-8?B?MEJIVllsWGF2eHVzSjE3d3lXMnRvR0dWNDVJb050ZEVCWFdrT3hjN1NhbXRY?=
 =?utf-8?B?bkZEWUFhcFZsa1U0ZWMrWi9oQmRhNW53cFQ3Rys1TitENmRTUW9TdFFuZHBq?=
 =?utf-8?B?V2VCQ0prRmZjOTRUcXEzMlU2L3pxN0dYUzVQeDF5RmFHc25sSUowWDFGSXpp?=
 =?utf-8?B?b0loYkpEcUFrSEo3dkpidTFjdzdaWTlpVWZxN0VhWmJpUUhWV1B2WS9ld2lB?=
 =?utf-8?B?azZvQnpzY1c2R0lnUVBJN09uYWtzMEprZFZRajJxejhDMkIyVFlpV2diUjQx?=
 =?utf-8?B?dlduUFFNQzVCUE44Q1BzSDlodTZ2eUx2U2JITkFCMkpQcitIK2FtWmMranF5?=
 =?utf-8?B?NTljNkdIQ0lobWNXWUt6bHNDZ0VvM0x5UUJ6NXU0TzMrWlp4Ylg5b05WbHJ3?=
 =?utf-8?B?TTFZUStVZzN5YVZHZ003Nng1Ym5hSy9LZTRrY3NEN3UrSHFQZVlSMW5XdHla?=
 =?utf-8?B?YnlJcDU0YUJyaFA3WkZ4WG0yd3k3UUwzU2F4QlBpZjZ6b1NzbVFrRDFzVmg4?=
 =?utf-8?B?MTZvVDc5RTVQYmh6TVpTQ0tuT3I4OEN5U2t2YnNEbUprZ2hFQzR4NGx2cGov?=
 =?utf-8?B?NWhsNzc4eDk4TTg5d1JTWGpvanpHMnZIV2pWdDB1UnpKQnl2ZkNhM1d3bWZ6?=
 =?utf-8?B?YXNsNFVWbkNCQVl3QUg2a0VKbzl6cCtHTnJUazg3VnhDU1lRRXNZYkptTDR4?=
 =?utf-8?B?WGpCcEpYUGswVVZZSTBmaXZXd1lLVFNzQVlwTHRrOEIvb2RhOUlYcXByREZL?=
 =?utf-8?B?NTdJb1lPWGZZT0RFeXhPbUhqZi90WGhhTUx1ZWJKZTZuYW1ZT2FmampBSHJ1?=
 =?utf-8?B?ZHBVdFV3MXREYWNKVnd0ZVNoY2FIUkh1dmlYZ2NGOCtjYVowVkY0NE40aXpP?=
 =?utf-8?B?L3NoMDJpUjRpYXBXUjhLN1FjTlNNNmlTeUNtblpXamFnbGkwS0dOTlVhUHVL?=
 =?utf-8?B?N29TWWFSZVkwSlJOK0Vkb2l1WFlXaWJ6SHVXdjlXWmxaOFBhNkZUUlFFRFhq?=
 =?utf-8?B?S0x0SWtPMW10Q2RFcmRoQW1iVDVIR3g2ZWxlTVZ6cm5hRTFVSGhGMFVtZjNH?=
 =?utf-8?B?SFlyaDROUnZjWjUyNEpjMmRUQ0xBVUIzNldmQzNzNU1FcEZSM0hVRE1MOWgv?=
 =?utf-8?Q?+wYtESNuvZqxov20VjE4CXEIzPFq7Kf0qHH6m?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e80f738-9b55-4123-1e90-08df0ace7932
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 21:50:02.6530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LmvgexrAMc0CaLAQM8fwvE5NTvti7hbc4jzXaPs04B6+Wo/Ot9K9LKG4ZdaRhMCtzi2ZLnoK23mxQ9E8EmQzFoFPc13alAuW6CcYWWe81LhMndEBUOctq/xlxThHtspK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8932

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

1st patch add help vchan_chan_name()
2nd patch use existing helper dma_chan_name() to reduce rename difference.
3rd patch add (dmaengine|vchan)_chan_dev() helper
4th patch add union chan_dev for dma_chan::dev for clarity

Need following patch to clean other dma engineer driver, which is not
in drivers/dma

After complete all rename work, dma_chan::dev can be removed.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v3:
- add new helper function dmaengine_chan_dev() and vchan_chan_dev() to
make clear.
- some reduntant error message will be addressed by new patches.
- Link to v2: https://patch.msgid.link/20260903-dma-chan_dev-rename-v2-0-0db305b6c716@nxp.com

Changes in v2:
- rebase to dmaengine/next
- add vchan_chan_name() help function for vchan case.
- Link to v1: https://patch.msgid.link/20260812-dma-chan_dev-rename-v1-0-a67131f7d5c2@nxp.com

---
Frank Li (4):
      dmaengine: vchan: add vchan_chan_name() to get channel device name
      dmaengine: use dma_chan_name() helper to get per-channel device name
      dmaengine: add (dmaengine|vchan)_chan_dev() helper
      dmaengine: add union chan_dev for dma_chan::dev for clarity

 drivers/dma/arm-dma350.c                       |   2 +-
 drivers/dma/at_hdmac.c                         |  81 ++++++-------
 drivers/dma/at_xdmac.c                         | 159 ++++++++++++-------------
 drivers/dma/dma-jz4780.c                       |  10 +-
 drivers/dma/dmaengine.c                        |  34 +++---
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c |  38 +++---
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h          |  10 --
 drivers/dma/dw/core.c                          |  47 ++++----
 drivers/dma/ep93xx_dma.c                       |  37 +++---
 drivers/dma/idma64.c                           |   9 +-
 drivers/dma/loongson/loongson1-apb-dma.c       |  23 ++--
 drivers/dma/loongson/loongson2-apb-cmc-dma.c   |  17 +--
 drivers/dma/loongson/loongson2-apb-dma.c       |   9 +-
 drivers/dma/mmp_pdma.c                         |   2 +-
 drivers/dma/moxart-dma.c                       |  23 ++--
 drivers/dma/nbpfaxi.c                          |   2 +-
 drivers/dma/owl-dma.c                          |  21 ++--
 drivers/dma/pch_dma.c                          |  41 +++----
 drivers/dma/pxa_dma.c                          |  52 ++++----
 drivers/dma/st_fdma.c                          |   2 +-
 drivers/dma/ste_dma40.c                        |  15 +--
 drivers/dma/stm32/stm32-dma.c                  |  69 +++++------
 drivers/dma/stm32/stm32-dma3.c                 |  99 ++++++++-------
 drivers/dma/stm32/stm32-mdma.c                 |  95 +++++++--------
 drivers/dma/sun4i-dma.c                        |  17 +--
 drivers/dma/sun6i-dma.c                        |  31 ++---
 drivers/dma/switchtec_dma.c                    |  14 +--
 drivers/dma/tegra186-gpc-dma.c                 |   4 +-
 drivers/dma/tegra20-apb-dma.c                  |   2 +-
 drivers/dma/ti/k3-udma.c                       |   6 +-
 drivers/dma/timb_dma.c                         |  63 +++++-----
 drivers/dma/txx9dmac.c                         |  73 ++++++------
 drivers/dma/virt-dma.h                         |  16 +++
 include/linux/dmaengine.h                      |  23 +++-
 include/trace/events/tegra_apb_dma.h           |   6 +-
 35 files changed, 538 insertions(+), 614 deletions(-)
---
base-commit: 5c7962210474adbd9874227bc5096dbc11501d34
change-id: 20260812-dma-chan_dev-rename-66263ac5eac9

Best regards,
--  
Frank Li <Frank.Li@nxp.com>

