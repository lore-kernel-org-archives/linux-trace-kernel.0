Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011019.outbound.protection.outlook.com [52.101.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC54E16A395;
	Fri,  4 Sep 2026 14:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788531720; cv=fail; b=MW0nWfSZ/rAc+UDd8o5XBzziPedgwXHjWmXNmxLyKXO52XfTCExSSo8Nhzq/RLjwUBizI2Wx39zvdTOYYMrDlouIwQwBPL1bmux7gjOERGe9x9yMbuqDcaEen/j6dxCTKX5pnWIUDBCk+lPQIoLTEHOi+b+X9lbrhCTyx5+ue38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788531720; c=relaxed/simple;
	bh=rQ/8Vfa6OM8cV0SWzWUFwn1cNd4Gul6sEIuluMXuB84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BFxr+0JoctPKAQkZxzccdxk2HpeL4l+SRxfkNl3UWeN3hC2WTBw6bXdoxFJfgBxrjpG1d7rbxNmR/vpsHSalQs731WNKrOwoE4lvXBuYVVtdi4LObMl9ZFrHlJ5pkhhViGOuv54gNXXX+4zWtpY0rxYnjY8JYd638qtNtslj53k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=k2STO1LT; arc=fail smtp.client-ip=52.101.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="k2STO1LT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KsTSKFyAj33BPz+3/p8Q1yvQmr/ZEPYEk4SjAC7/uE0Mxs4z68YaZN6kjOzyeusH4VPW4So9jRag26xIhTgCTnozjPgwGdAk+eIY1g6G/R6Ks9m7vnX7cAE8b4tUruZpAA6mGku7LhlkjBLbRFZmOT0iKhjcN4QAJn7KOrA1R3zGd88GVazfO9+pfDk/+5M74vkVMqhH0jjXgcH0o2dTsElMNsvUpVSvLxKHaKqx/2dqB1tCQT0/5qfiZKjczpLW8+xTLViw1L708DPmOTaa4UnKbqsUx/qWUugzmGoAMnAyQ0vroR56sRYwWGchDp36NFgWG/i6V00E1UszhatKXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rQ/8Vfa6OM8cV0SWzWUFwn1cNd4Gul6sEIuluMXuB84=;
 b=sW8tt57ga24Cryq3h/qPzE99TkG2dNuwA3AESFyq5JMuWfKsrMpZOcgF+AelljDqoip+6vVKpfg6WLOj1JVaWnAZkhpcCaQY5pRDm+zSAM2vj08JpduBTOpxhE/J3TUJYUOV534+4gopEPUfj3iIJeD3RKveAmlR7HUIeW/lrR8R/UlK2hV+93B+A7otDBIHxstQKJwYqdlNXsGymN4iGmJtEe7Bzk48XGJOkYjWsyoq6934v+uxazCrGfkcMwN22L+n+KFZxoGGeG3uAlNM+m02v/TfR7AXAlcBPOj36wyJI9r7KOV2fzKI8k9Gq1jjsYrqXgcO38fbbGpXbfOaOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rQ/8Vfa6OM8cV0SWzWUFwn1cNd4Gul6sEIuluMXuB84=;
 b=k2STO1LTKKhHXyZD1ajqGooS/T1ztEC8NJw6QDjof8yGorCNrWB088VFaj/DfBpP2ma7SB9s4iFyG5rqlevSYT0ONn5ysN7PGABj/Kk7uqOL8Nt8bOK6UciPI/LkI5ARRz/J53F6UZrsvUb1Il1AfOfuxj7C99l9m3fXRxGhF3q4MQxUH4q3+BF71lS/1Ulvx/8cwwKRjpAsY70GKe2aH6+CE/O5C6Ppeew/BVMOWUMh2VEfda/ooaUbGOQv9SFO47P4jh6L9O8b2/7bWbOoDz9om+dXuPyjrCpGpVr6SoJFE1RGdZ1Yf/XXShPC/59IoMTlIkO1dq9km0G5XbXkQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by VI2PR04MB10930.eurprd04.prod.outlook.com (2603:10a6:800:273::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 14:21:53 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 14:21:53 +0000
Date: Fri, 4 Sep 2026 09:21:37 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Amelie Delaunay <amelie.delaunay@foss.st.com>
Cc: Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Paul Cercueil <paul@crapouillou.net>,
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Ludovic Desroches <ludovic.desroches@microchip.com>,
	Viresh Kumar <vireshk@kernel.org>,
	Keguang Zhang <keguang.zhang@gmail.com>,
	Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Kelvin Cao <kelvin.cao@microchip.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	Vignesh Raghavendra <vigneshr@ti.com>, imx@lists.linux.dev,
	Frank Li <Frank.Li@nxp.com>, linux-actions@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
	linux-tegra@vger.kernel.org, dmaengine@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [Linux-stm32] [PATCH v2 1/3] dmaengine: vchan: add
 vchan_chan_name() to get channel device name
Message-ID: <aprT8bFmk372D9I-@SMW015318>
References: <20260903-dma-chan_dev-rename-v2-0-0db305b6c716@nxp.com>
 <20260903-dma-chan_dev-rename-v2-1-0db305b6c716@nxp.com>
 <4e3a2f00-ec1d-426e-b71b-fcd9fabe6b86@foss.st.com>
 <a4be2ef7-8987-481a-a329-52c809bbddb3@foss.st.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a4be2ef7-8987-481a-a329-52c809bbddb3@foss.st.com>
X-ClientProxiedBy: CY5PR19CA0041.namprd19.prod.outlook.com
 (2603:10b6:930:1a::8) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|VI2PR04MB10930:EE_
X-MS-Office365-Filtering-Correlation-Id: 35168c01-6cc0-483c-faee-08df0a8fddab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|7416014|23010399003|1800799024|366016|10067099003|4143699003|11063799006|18002099003|22082099003|56012099006|41080700001;
X-Microsoft-Antispam-Message-Info:
	tMDkPKviuvPceOZhz0ybKsapkhj1f/Jar5U3iuRRpOeye+GqrMkDyKZncV9QJBt8/NLmvj/RLYIl+g5M6a8G2DaEnCGF8c7etjZIjvQDDLdeaiMbxQeY9Rd/6qn5AEsmV/25xvE7DPMohNHUE/yUsSGOBvVv9JfsB0SiUu5qtzDwrf0x+NFci0G0/Yxwbim1d5cdDWKoOwINhvxHaulc6ESI10+RT5lkignqi37Si/fjwjPh/GRneF7LdTiTWMDgoXkQewT5vAZrO8Xvdps+c+kDOvkuYLDnejAodKP/1M5yjVcwfH39QopXdH69p/2OGvYuilozy+fxlPy87aY1DmXdqVLHNs3vPYH1VC+wEJmsuMRswAxeSyZFWB9tibl8axJs5Uf0fSVm9aRLPLKryD9wBpjactFE16kXqMpMvVSDHym4uPhLCsDe1JAJSX3UNVnk+OahpoKM0fzhd5PEpIOQNUVP1cCbW7Y4qAA9nxwDoddQibs9qijPITyo+UolEiNghVcTNRJO8OncFQIFwtrjcDdBbd0/vDS+wB7KsJpHdFxd7sAsKFo3YdLd2mm1soi/5DjgtzWLiCabCwjrLI7TAx3xQaksQPrjTDgLWwrmEqTU6YbDnZuUvaxM6MKotfJo8zCGDnWFQqGKNXqVTzmtXTyQh7thI729nlUwqcU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(23010399003)(1800799024)(366016)(10067099003)(4143699003)(11063799006)(18002099003)(22082099003)(56012099006)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U2cyS2lSZVFmKzlKWjlydUd0eE1aN0JGc0o3RDNBd2UzQ1F5bGZyeVg3cDZB?=
 =?utf-8?B?TWQrWWZvTWhIYzg5U09jV3VyWm01dFpXT0VCa01iSHoyRnY2TjZlMUw3YlF1?=
 =?utf-8?B?SUJSWlBObmlDVDZjZlZLK1BLUm51eHYwRE5RZjhmZzhtTUVHQ0g5RzIyWVpK?=
 =?utf-8?B?VC82MDRxbTY4aHpkVkh3Z2hrTGlkL2hQbkhyVHlxelRUQ3lMS1R1OTBXaTlH?=
 =?utf-8?B?SzJReXVleHhXQ3NDY0NXd0dMc1cxM05Mb3JaZHRtaTlRZFZzM0dnT1Q4Y2Zt?=
 =?utf-8?B?UUlFbmJVcThsMVhCTVMvZitTa0Fuak5kZkN0QkxkOXNUNHoycE12RUY1d2pO?=
 =?utf-8?B?VjE4WnpRRkJlMU5xZ0F0RnM2emhoVWlGcUZESFpXWmhmS0IxUExCaWJsVnJz?=
 =?utf-8?B?aDJmT1pqQXBXUEU2UmRHSnZwSE9DTlFkR0hFNnVqNS9kd2dFT0RjM2ROMnlh?=
 =?utf-8?B?d2YzWWk1dXdwQ3lHaVl5MDR6eWdOMmdCUTJBWHhDWXB2U3VHdFJHcFZlUXN5?=
 =?utf-8?B?SmVZSy9hSFVtcW9aMHY1RytGZjFzK1lQVzdtdXpDdG9yVnpaZHlvSGZMejE2?=
 =?utf-8?B?SmljTmRQMnhQWVBCWjlndCtvV0tXUm0wUUNqUHBvVFByZ203SFZOQllPSm8y?=
 =?utf-8?B?aTRhSDRlRjI0cVhvSW4zZmUxYkJhOVRRSXF3Tml0V3ZrTW1VNS9sM2NTV0dv?=
 =?utf-8?B?RE9KUFBxZkJUdnFIRTNhVDUvOTladFNlQUFnOHV6TUFkdXdMYVRmKy9wTnRC?=
 =?utf-8?B?SFU0U08xa3lkQ203TGVrR2FtWjFNdGI1aXhuTHZ3UklGdFZYejhLdU5rMlRr?=
 =?utf-8?B?N0ZDNDMzaDdrOGl5RUxsaHJhK3VVSzVJTjZmcEJQNlp4NkV2emFVdDMvWTRs?=
 =?utf-8?B?YmJBclBwYTN5MWcyOXdOZWR2d1FWVExzQjRYLzF6QW8xckVROXNlYVNiKzNs?=
 =?utf-8?B?d0dPdnBKeG5jWFFJd1VrckYvaDVkMFZnUDN5RTVWNUQyYzR6NG5FY2VHbTcx?=
 =?utf-8?B?Y05CSWxIdGd4d2VVUDJTY1BvL21YanpUSDZKUGo1bUxsYWhzQ0xYaEFyU0tM?=
 =?utf-8?B?ajlLSHBRZ3RyRDd2NEdqbklSUDBCZjJiRGNTd3B6M2pXTENDZFZlVmY3cDVI?=
 =?utf-8?B?V1B1RnJmbFZ2MCtpWitYOHV3MEFPL3ZZaDl5am9lR0txSzVQOEN3TGtnVGFK?=
 =?utf-8?B?M0xKY3N1bXpBYUhneUE5ZmNDN0dPMHNLdXA0Z3FYZW5STWFKWEJMdnJmMG1G?=
 =?utf-8?B?OURSN3JGVldEbjFuU2pYbE1SYnNncEtPTDlFeVNHTVBXQW8wa0VNNnhSZnJF?=
 =?utf-8?B?eVpqazE1VHZOTGgzZU9iQkpUQ0VldjF6TlFYSUNNWTVsdThqVnFNUFpUdlR4?=
 =?utf-8?B?bFVyaERWYWZvVnZsTTlmOW9YNW5FQlBOcEtIdy9zVXNwQ2xldmdvYVkwZFNU?=
 =?utf-8?B?UU5XazVhVGVuMlg5d1l2Z0RSYjRjblJqK3pzU0tscDhWRUUzclV4ZEJ0SVN3?=
 =?utf-8?B?M0I1OTRmdnNYUktlTUVueUppR0oxUXZOU2pxcFVLbm1DMjErZkJ3QUNLaTNu?=
 =?utf-8?B?dU95SlAzRzVIN2tXOFFqd0N0MjFHYmkxWEFFT3VaUCtKSzMyQWQ5UFgyRzNp?=
 =?utf-8?B?NFZSNndZa2RDTk5NSDZKdHNtb0kvODJBT09Qa2ZSM1k2WktwY2hKaWpCQWFk?=
 =?utf-8?B?S3pEcEV1VGh0cGoyVTJpQ3BreHFHcGE4Z1YyVFR3MHdTck82bEszYzJOV0Fv?=
 =?utf-8?B?U2p3cDZibXdneE5lbHZycmVWT2plNEZaNEQ1NXVPRGMyODE2WEtBSHA1NGlr?=
 =?utf-8?B?RDhLVEk1VXRlcjhOWlBrUUZ6T3RtdUFDTDByNEwzaTNnUTJyUlVMVlBvYmxP?=
 =?utf-8?B?bXRLbTV2dWJhcXd1dlFWMG5veUt2N0JLNlRMQUErR2VZUGhEbkFiSCtENGxZ?=
 =?utf-8?B?b01HN3Y1b25JN01MWmViNmpweXBTSFVlaGt3R3hac1FScmp4ZG5sSnFmRW9p?=
 =?utf-8?B?RnFrTnlNb2hpdzB6aFUycHdva0tGSzFIUUNiamJXYnVQaGpKWWQrYXpCRkFZ?=
 =?utf-8?B?RXNqOUhyaVBiVi9rbWJselMxenh6NmFvM2J4Q1pOQzJTWTh5L015WFYvWTJU?=
 =?utf-8?B?NngzaU5lMVlwbEJuV0ozRTJvWkZ5YjlsSHNKMFJjZm5lR01RL216RkUzUDM3?=
 =?utf-8?B?WXpRc2poQm5tbXdhUFZGZjZXVVlVOEVmQmNsVUNqaGQ4RkYxTXQxT3ZEZU1u?=
 =?utf-8?B?SDRyWENlanhodzg1Z2JtSmhNdE9NclVNSk5YL2dsZEVkdXgrT1Z4b1o1RER6?=
 =?utf-8?B?NWhWZXFzRDhrUXhKbVY5bnpzVG5rVkVWTmJYWWE0ZjFwcE16V0dkazAwUW53?=
 =?utf-8?Q?cF4Xrdm82H1hx3fGGFyX+FpUKkBu50XbVEWi5?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35168c01-6cc0-483c-faee-08df0a8fddab
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 14:21:52.9171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7xC5B7DTuyeZNyghQxv6F7nt0PB6LVvHtngjR+BzDvrL0yWispQZ37fVqCYwyN7CWF7zncgXTMCZg24grRL5dsXqtzEbF46JlLSUE3Dq+q05ELfjk57Pc6pukYmqrfX3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10930

On Fri, Sep 04, 2026 at 11:10:54AM +0200, Amelie Delaunay wrote:
> On 9/4/26 10:35, Amelie Delaunay wrote:
> > Hi Frank,
> >
> > On 9/3/26 22:53, Frank.Li@oss.nxp.com wrote:
> > > From: Frank Li <Frank.Li@nxp.com>
> > >
> > > Introduce vchan_chan_name() to obtain the DMA channel device name.
> > >
> > > Use a dedicated helper instead of directly accessing dma_chan::dev
> > > so callers remain unaffected by an upcoming rename of the struct member.
> > >
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > >   drivers/dma/arm-dma350.c                     |  2 +-
> > >   drivers/dma/loongson/loongson2-apb-cmc-dma.c |  2 +-
> > >   drivers/dma/stm32/stm32-dma.c                |  2 +-
> > >   drivers/dma/stm32/stm32-dma3.c               |  4 ++--
> >
> > Could you move the driver updates from this patch to the next one? I
> > don’t understand why the drivers above are modified here, while others
> > are deferred to "[PATCH v2 2/3] dmaengine: use dma_chan_name() helper to
> > get per-channel device name".
> >
>
> Oh, okay — my bad. I've just looked at v1, and I now understand that you
> split the vchan_chan_name() and dma_chan_name() updates.
> I didn’t catch that at first glance because your cover letter hasn’t changed
> between v1 and v2.
> "1st patch: use the existing helper dma_chan_name() to reduce rename
> differences.
> 2nd patch: rename drivers/dma"

B4 did not update it. Do you agree on this change?

Frank

>
> > Regards,
> > Amelie
> >
> > >   drivers/dma/virt-dma.h                       | 11 +++++++++++
> > >   5 files changed, 16 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/dma/arm-dma350.c b/drivers/dma/arm-dma350.c
> > > index 09403aca8bb06..52f5242ea3327 100644
> > > --- a/drivers/dma/arm-dma350.c
> > > +++ b/drivers/dma/arm-dma350.c
> > > @@ -512,7 +512,7 @@ static int d350_alloc_chan_resources(struct
> > > dma_chan *chan)
> > >   {
> > >       struct d350_chan *dch = to_d350_chan(chan);
> > >       int ret = request_irq(dch->irq, d350_irq, IRQF_SHARED,
> > > -                  dev_name(&dch->vc.chan.dev->device), dch);
> > > +                  vchan_chan_name(&dch->vc), dch);
> > >       if (!ret)
> > >           writel_relaxed(CH_INTREN_DONE | CH_INTREN_ERR, dch->base +
> > > CH_INTREN);
> > > diff --git a/drivers/dma/loongson/loongson2-apb-cmc-dma.c b/drivers/
> > > dma/loongson/loongson2-apb-cmc-dma.c
> > > index 1c9a542edc859..2f1c8c4fd0654 100644
> > > --- a/drivers/dma/loongson/loongson2-apb-cmc-dma.c
> > > +++ b/drivers/dma/loongson/loongson2-apb-cmc-dma.c
> > > @@ -678,7 +678,7 @@ static int loongson2_cmc_dma_probe(struct
> > > platform_device *pdev)
> > >               return lchan->irq;
> > >           ret = devm_request_irq(dev, lchan->irq,
> > > loongson2_cmc_dma_chan_irq, IRQF_SHARED,
> > > -                       dev_name(chan2dev(lchan)), lchan);
> > > +                       vchan_chan_name(&lchan->vchan), lchan);
> > >           if (ret)
> > >               return ret;
> > >       }
> > > diff --git a/drivers/dma/stm32/stm32-dma.c
> > > b/drivers/dma/stm32/stm32- dma.c
> > > index d3ad78562a140..3e8151e2ad75a 100644
> > > --- a/drivers/dma/stm32/stm32-dma.c
> > > +++ b/drivers/dma/stm32/stm32-dma.c
> > > @@ -1668,7 +1668,7 @@ static int stm32_dma_probe(struct
> > > platform_device *pdev)
> > >           ret = devm_request_irq(&pdev->dev, chan->irq,
> > >                          stm32_dma_chan_irq, 0,
> > > -                       dev_name(chan2dev(chan)), chan);
> > > +                       vchan_chan_name(&chan->vchan), chan);
> > >           if (ret) {
> > >               dev_err(&pdev->dev,
> > >                   "request_irq failed with err %d channel %d\n",
> > > diff --git a/drivers/dma/stm32/stm32-dma3.c
> > > b/drivers/dma/stm32/stm32- dma3.c
> > > index 4724e7fa0008e..1ee1bd22703fb 100644
> > > --- a/drivers/dma/stm32/stm32-dma3.c
> > > +++ b/drivers/dma/stm32/stm32-dma3.c
> > > @@ -1892,10 +1892,10 @@ static int stm32_dma3_probe(struct
> > > platform_device *pdev)
> > >           chan->irq = ret;
> > >           ret = devm_request_irq(&pdev->dev, chan->irq,
> > > stm32_dma3_chan_irq, 0,
> > > -                       dev_name(chan2dev(chan)), chan);
> > > +                       vchan_chan_name(&chan->vchan), chan);
> > >           if (ret) {
> > >               dev_err_probe(&pdev->dev, ret, "Failed to request
> > > channel %s IRQ\n",
> > > -                      dev_name(chan2dev(chan)));
> > > +                      vchan_chan_name(&chan->vchan));
> > >               goto err_clk_disable;
> > >           }
> > >       }
> > > diff --git a/drivers/dma/virt-dma.h b/drivers/dma/virt-dma.h
> > > index 59d9eabc8b674..dd023a3831209 100644
> > > --- a/drivers/dma/virt-dma.h
> > > +++ b/drivers/dma/virt-dma.h
> > > @@ -209,6 +209,17 @@ static inline void
> > > vchan_free_chan_resources(struct virt_dma_chan *vc)
> > >       vchan_dma_desc_free_list(vc, &head);
> > >   }
> > > +/**
> > > + * vchan_chan_name - Return vchan DMA channel device name
> > > + * @vc: virtual channel
> > > + *
> > > + * Return: The name of the DMA channel device
> > > + */
> > > +static inline const char *vchan_chan_name(struct virt_dma_chan *vc)
> > > +{
> > > +    return dma_chan_name(&vc->chan);
> > > +}
> > > +
> > >   /**
> > >    * vchan_synchronize() - synchronize callback execution to the
> > > current context
> > >    * @vc: virtual channel to synchronize
> > >
> >
> > _______________________________________________
> > Linux-stm32 mailing list
> > Linux-stm32@st-md-mailman.stormreply.com
> > https://st-md-mailman.stormreply.com/mailman/listinfo/linux-stm32
>
