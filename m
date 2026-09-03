Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011029.outbound.protection.outlook.com [40.107.130.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22D74EE877;
	Thu,  3 Sep 2026 20:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788468818; cv=fail; b=H4gi6NGzMj9gQ245zto/BivqWoug2agyrxyVq6TdZwV8BsoBAcrZh8Nx4VMAGjeNTUu6WONkA1Q6IkugRmesEpNtg9O+3y2CvodYwekkHCm1n6DWtYgnFgzF+flXwGAscVmCkaBy1KSG8zmlhqEt9zszBphciv0Q/W48l6Ls8YA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788468818; c=relaxed/simple;
	bh=l+osikCun3Zm+swb7L9wZEvg8yEhPBGmEz72oosk4AQ=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=QQ4mjfOsMPTnfSVHRRNEYDk9r+uevSdFxoUre63KqNm32waoE/pEJDRKbL4uqjX9/FmP4WrGQL1WjSxH6ve3Pb0NOGM8IbLoLrJvQMvAshptvobFXRPT1w/0bFdrswNb8B4EuvofbdLbJzEHVKY4cd23b5WAglD4QWs3BfOS4nE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=f9D/PCcW; arc=fail smtp.client-ip=40.107.130.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="f9D/PCcW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h+PnUTa+iJWAZtjVzig3Sgdp8bv/Fok9JP+MDQs6AKl9VkVfmKlvqM/HeVXPpjYGzEvPHrGSTJ9ra9/kCVY9Y8FY6zckSLVTdqJaYPNoGEG4D2zFr4HGKiSHa0Xc6Nze1jyymoMOCGXuBcJfi8EqNAM1q+gfu6kVgfGoy6+9DJ3KO90Eb8oa1i+EyRGJQtO7gXpatxQE2E8wmOqQxvlXR/0gHxPoD8rY6IjErRKaTLLNdTt4M5sID18oY6VzM8wOqzVJgOC9/VA3IJ00QCx0yqnPICQodr6jjw59sFKos4V+1yOaoru2uVMNXL9h8Um9XkHdHwqptRLsDhfJQCZ0KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gz3n2RVE7BmPd0DVNq4a26JaULSgZ6NIwQYbKNOjTac=;
 b=HqEc1KnA8HAua5SGgf4UZJAH2c7HSjFFNAooiH7yHuUIhal0i7tkQ+5kfSU1B9Hte+0c17VRn8aZ+nESjlFSl0j6hlhrP1Zje27LRfcNAfrHtA386vyc1lWF+vCR3G69yhJM9ANFR5Xmom4m/HakmEYju+LgO6n3AY+bHFu1WAIwAdTghRaXAfklnlHM610i4ntTHx8/i+aJ+TFDUdxS9d947Wov4Z+V41uZEB5nFw6cHbSSbQf1jjpQgxAPgPLWHJhaaRYtKteyOTFbWwTyzeFm3R3ENcEZzUcHKB7LR/8EGCwZqTtUtp+rfEVY+F8jZpKDLFHS1hwAWjzDUEJwSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gz3n2RVE7BmPd0DVNq4a26JaULSgZ6NIwQYbKNOjTac=;
 b=f9D/PCcW1dJEzLoxgippF8Bee5aBx6rRmlXnXmK2yuZEHvgBOy5KgOhEY7MM+RxM7NoFKCMg0t0k+rtU2g0v44nbx0YSBvrQwk+lv7LEPirFwo3s+RnmvwC/6ceVZiaZeNkXjUdrFqUqjnQQ69SZuUT778qiMfFdhkmsH48hHIkKRkOjYXYKKqXokJ8i5Z42UPORrWfF+tvPCPwd3M8S3kBjyZvZchg7KU84gBioQIhaHYmu4nB8obRULyTMVrfUTpBSFFsc4XCJbTAvd78qlDFadrAT3r/PEzYYByJ0gu18smpTms2kndy78q8RFrXiseZ5hpIQI1CBgoz5FYhQdw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by GV4PR04MB11894.eurprd04.prod.outlook.com (2603:10a6:150:2ed::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 20:53:22 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 20:53:21 +0000
From: Frank.Li@oss.nxp.com
Subject: [PATCH v2 0/3] dmaengine: rename dma_chan::dev to
 dma_chan::chan_dev for clarity
Date: Thu, 03 Sep 2026 16:53:10 -0400
Message-Id: <20260903-dma-chan_dev-rename-v2-0-0db305b6c716@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADbemWoC/32NTQ7CIBBGr9LM2jFAU6quvIdpDMLUYgI0UElN0
 7tb6t7ly/fzFkgULSW4VAtEyjbZ4DcQhwr0oPyT0JqNQTAh2YkLNE5hSe6GMkbyyhFKKWStdEN
 Kn2FbjpF6O++vt+7H6f14kZ7KVWkMNk0hfnZt5qX335A5MlSy5TXvW9NocfXzeNTBQbeu6xfNY
 aO+xgAAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788468796; l=3460;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=l+osikCun3Zm+swb7L9wZEvg8yEhPBGmEz72oosk4AQ=;
 b=Sx9E6Ir5MDXdk30Pz2W5MomnGzx8FBC0au2T9/+OzpnPeg9v8sEZuPCrDV9sV3k/3ecy4V9sR
 OG8C3TNWbquD6a4+9iW/hrf1u2TyElxkKgnIwTAD3hYr3a0wEOsSjEy
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH8PR07CA0016.namprd07.prod.outlook.com
 (2603:10b6:510:2cd::24) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|GV4PR04MB11894:EE_
X-MS-Office365-Filtering-Correlation-Id: b68a4915-b095-48a3-5588-08df09fd63ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|376014|7416014|23010399003|1800799024|921020|11063799006|10067099003|56012099006|18002099003|41080700001;
X-Microsoft-Antispam-Message-Info:
	P8iFSfMz/BlkQcneA1gZRoE1I2LLW96Jw5bay21i6zr+nMO6miwXfaRB5bXI9uwLgIH9Ez+gwq1CrLn6jSPUaj25P2PmINF2HlHT1UPcm0CAWY7dXJKHYahKQRMG+yfnWtnhTep096U1l4oAPJijHqQGfh1yybMXnvUKLrB1oJKDfqgexu01lTmzdthAigW+Bn6b1nMkid80B8ZyKjTrIHPjUjGSLlCv91yMdXjC99kPF/gV9bF3Ix8F5d81QWvpgWhfNCbR1eVW7zZo6y2J8oUyLVIYn7axW7qm2ZJk0h0FUmoqIFuESZzaNQMgfgJSw2Xsb+tgBzrvyseH1hFYiUe3XS6+OmUXj9QReugyCuw71Rii9KptcWTnpPUg/TMWoE9QBP6H8TjO4zRSPCZI9mpa+NJFlnkqjx41GiirX25bDUu8ja+QYTyCM7/CcTj1Vp0crHgrr7GI67whrpwmNczxgoN6dLvGBXAnU+tdA79LhNSjfYkice/7SzlkuDQVlJcYKTQlkrA2YOcKyoHJ+ygRnYos6vYYa47DAzdN4e4hkmpvRwX0EBJyXpP7rlsrNvIXSPlBcCyFBaEMA86bxKQI97NXFohcHJSmOv5SvqFStJ3tTD/8a0BNhYbtYgzYAVStvIEJ3EkKVG6XvTBeJJ6el+dchi/IMKVa/3o7rVqNAuAivjfgGZIALb0K2jzR
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(7416014)(23010399003)(1800799024)(921020)(11063799006)(10067099003)(56012099006)(18002099003)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eC92QmZjalp3VS9uTUljekRKczc1UTVwekNnNU1NaGtGU0FIcVozazhGS3hP?=
 =?utf-8?B?WThFWXpOMTR6MGVCZFdFRmd3WXZvNjY2czhLUVEzK3pHbEVSWU0yOUNUdGtl?=
 =?utf-8?B?Ukw3bmlLN1p0RnFsN1BWb1FNUWw4UEd6KzRyQkdNQSsrcGV3ZGtseGpjVW8w?=
 =?utf-8?B?TU1meXZCU3VwZStLQ1hVaGFGa244blVlamF0UEV2L3ZRTEd0RWMyRjBRelVm?=
 =?utf-8?B?SE9mcEgzMXRNZFZtYzFXd3pubkpSRTNoSXg3a1RLeW5XTURyZkNuRDAyczFB?=
 =?utf-8?B?VzVndjRFL3dQTFh1SmM5SHVLbGx5S200Unc1TS9mVlNUN01ELzNpdThUNjhX?=
 =?utf-8?B?V094dE1KMkJCMHpPTG51aWNuTUFRQzVGalBVQVJORWFPb2gwR0N2azd2bks2?=
 =?utf-8?B?NGhLdnFuc3ZpNTQ2UGE3a29haUIyQm1qNzRubmRQa1NkTEVwQ2hpOGE0Rzht?=
 =?utf-8?B?Ly8vdjN3NWpMWDF0T1RlMDducmtzRzRoK2JvcjZJVmxMQTgrUEhZTHZMeU9p?=
 =?utf-8?B?b2xNUFBoTnJ3NlpLTzBDcFNtMEVBbjVuU2U0aVU5cFljRlprMzVVQkxDamk1?=
 =?utf-8?B?blh2cXdmWUVEUlJ4RDlTR3M3TCt6THBLUXBiK3VKS2cySktTa1hYZ3RrM3lF?=
 =?utf-8?B?RlQxVGFpOERPR1I0ZGE5b2dNbTg3RmxZRXJRNHRJZXBYVExDL2N5NG42M0hD?=
 =?utf-8?B?UlRFdy9rNVp5MFpiQVpIbG9Qb3lvTjUvZmV6ZWJPWVNHSnZOekhXNW1YWmpq?=
 =?utf-8?B?WThpRkYrQlI5SFdsMWFPTDQzblVxS3BNSWt6Rk56ZWlhTDBTWEpsczZYMlVT?=
 =?utf-8?B?YWw0dDZXTjVTTjFwdHJZQUhGc0g4Y0xnakRTbGNlSHcrU0NZM2FiM1EzMDIz?=
 =?utf-8?B?T09jRE5ZbnpvTXJHMElMaFF5NmFKMUsvZEx1SWxDdzJHTkZ3d21jMTFPRHZC?=
 =?utf-8?B?YU1SY3UyK3JkdURzTVRoMXlFQlY3VGZxdkFQaEJYL3NFR1hxYmtLRXVpc3Fh?=
 =?utf-8?B?QWlpc2plNjNidmQrcHZlNWVFaElXajJraUhPRVJBcjl2WXZVVXIyQWVlWWFR?=
 =?utf-8?B?bW1yL3FwRjNCdXRwZ0VLOWJKaTFReDVtM0RMNGpBVXBSY1U4SzkvSEdGWlNu?=
 =?utf-8?B?T1p1MFZ1Y1MrdjVFNXB0Z3hHYS9nbE9Gdkx0ano4SlZ0eVE5bS96RTFpV01i?=
 =?utf-8?B?djdtVkVQWXc0ajhvQVlsRS9hMk1rODRFc3VPTy9ubzlNQnc0TFd1VTlVV3Mw?=
 =?utf-8?B?eGVPWmFMT3l4UTFlejFCOVdIZTBpZmN2ZEdKdyt2Z0lHa2Qxa0laUlB4Yzky?=
 =?utf-8?B?TXdtZElOSVd0UVM4RmNJaXc3Y1VZUnlSMFJBYjBxTWlyM002QnJCWHhOM21R?=
 =?utf-8?B?Nll1L2NqdzhWcmgvSXpXbVRYRFdnMERNOUY4RFQ2Q2lLcWlnN1JXc2tmTXBl?=
 =?utf-8?B?YUhVbXhiSERCQXR6QjB4VjByT2lBczVjOEFmcFpQSUJZNXAzQ1JLVStVdTJE?=
 =?utf-8?B?REozaEhydE9ObzIwUXhOYzZJcHJGTUV3ZlR4TEtSY0Rkc0NyZVRzYU5td09U?=
 =?utf-8?B?dHd0T0EyTk1laGxUTnhzbGk1VDZwdnVYTWF2YlpwN2pPUDh2RytLNUN3OTJm?=
 =?utf-8?B?WllaUWx6NDJkWm44Q1lRM2NoRzNGS1VPeUJ5cjJ2N1AycnBRRjRJSE9lK2RK?=
 =?utf-8?B?RDV5UlRudWVhbXNIdGUvN0gvRnRjVndpOEorNWtzd0k3MFduUnpEMlhlSTJ0?=
 =?utf-8?B?T0QwMTJVdzM0NmhSdURUU3V3eVlYbXphZzROcUNCWERwUDdFRDNvWlh3ZW4w?=
 =?utf-8?B?cXFzSjNRTEZUTGxlR2F3a2ZzdTcrSi9hRnhTSUtSTDczQUl2SEE2S29weEQ2?=
 =?utf-8?B?R3B0U0ZzcDZpWERxMVYxNUhZREZ5aUMwN1ZXanF5Zmx3Rk92d0YwelBHTmc3?=
 =?utf-8?B?dktpTDZGMWdkcUdZSnZWVUFxRmJydW1qekFMQzVFdWhtSG9BdUlQQkxUNllr?=
 =?utf-8?B?Mklnc3h3bC9xZWhWOTdSUFlKcnVOT3c1YlRVdnFaOWdieXV0RmlwTTFSbHVr?=
 =?utf-8?B?cmdiazRHZStSY1pTRy92T3NuamdHL2hOMThvTEhCby9ldkxLZ1VvZ2ExT05D?=
 =?utf-8?B?RDg5dm5ranBoNE5JNVBQNXpvTldNTzBkWVV6WlMrWEVPaHFqTXpsd3B6ZlVj?=
 =?utf-8?B?YWdGVGVyRjM1SDVWOUV1TXFUQnVUMjhUYUJJeEIwSElJcVp0UGtuMnRNT21F?=
 =?utf-8?B?ZFFsSWh3OHFXNHo3ZmpaTWU2cnUveGkzcE5QaytUY3E5NUdSUU8vazRWb0s2?=
 =?utf-8?B?eXAxNEhBcktqNHY4Rjc5UDVVUGNYc0xCR25pYUo3VFpjR05Qd1UrS1FtMmRG?=
 =?utf-8?Q?N7w9gB9FGpjRBYcbQ/+HlBO1asKhV+83nVbvT?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b68a4915-b095-48a3-5588-08df09fd63ba
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 20:53:21.7007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q0lANi75yFcrM0JU1tWtsZbtvngELMhzAwHyt5+dayt/5661NrD0cqx0RSBmx53suTmjv9NibJCC20WZVGW2FpEnjBJGLY29zNZoi0p5XlVzjPX82H60eJeyAmn0lM5e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11894

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
Changes in v2:
- rebase to dmaengine/next
- add vchan_chan_name() help function for vchan case.
- Link to v1: https://patch.msgid.link/20260812-dma-chan_dev-rename-v1-0-a67131f7d5c2@nxp.com

---
Frank Li (3):
      dmaengine: vchan: add vchan_chan_name() to get channel device name
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
 drivers/dma/virt-dma.h                         | 11 ++++++
 include/linux/dmaengine.h                      | 18 ++++++---
 include/trace/events/tegra_apb_dma.h           |  6 +--
 31 files changed, 118 insertions(+), 99 deletions(-)
---
base-commit: 5c7962210474adbd9874227bc5096dbc11501d34
change-id: 20260812-dma-chan_dev-rename-66263ac5eac9

Best regards,
--  
Frank Li <Frank.Li@nxp.com>

