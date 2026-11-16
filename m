Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=52.101.70.22
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794862665;
	b=tLonjfx1yXfRpfZuSAsYv9Q8lhDNXx1Dhr8AzQb53aV/HwXk4k941fVEeGmhuXlCZZa9
	 EGIlzInnro/83puPhXfPzZItOdX96Fyxh8J/lG0n4xrzN7hc20pe5qqN0vo20cDBXh91m
	 oz4pZ7qW678sGKXSITlobeimhdBPDpHxAHHxHNJ4BeEKwyfCETH938NZzbBNeoGMvyU7b
	 RXOktVitBVS6XBEeVVvzJUeqQ9o9y5AyOzM4ttud8rOwV7yfuOhVCibp8Ucrq73u/XDmX
	 JfARnj/zftfjXQchUEeErPb15aegwZa5I9Spp/eYxjsaAgsEWugBy4IC4zVj2a9tynw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794862665;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=4NNsO13ZfzlB2PQRWFbUZqK9a7dmjocSP1aeiOYLbRk=;
	b=AR3+HQmrWR6U7C4be+VTihJ+uCHUFgl++CsutnTWnkngRGB8Ds8PunLjN5mcsflpoBtA
	 Gc+1aftB8+FvWLGgXPFhH+k/GTboccCDj2qJ7WF6aM8Zsavg+qVAvR0fRupqc14kJA67l
	 7ZyMTfscRGxceY+RDMwQuN+bjCpckp7nF2IlCK/SFuNEOGIDvyLejS+LiczS1ZMBHQn1X
	 K1ZAbiIPhJ6tJhIw4TUoD1KJFADMFF8CirubV7j53vrF8AQ9I6li7RfR2A6DkHMLLAJt5
	 vEG5x0Nz+KvCoy3O6lrNv2thh5gBubwcRXMHfaRsUtae8JHD/LiFicie2nJWX32/HCg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=fail reason="signature verification failed" header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=tvHH7ilS;
	arc=fail smtp.remote-ip=52.101.70.22
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011022.outbound.protection.outlook.com [52.101.70.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB74D606A31C;
	Mon, 16 Nov 2026 20:57:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB74D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=tvHH7ilS
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a5VpA9BdKNolCwAniuN6YCC9t0AVzLBGPiuITCr8Ra2L9rM4d/Q+aQ6A4mOBSOo9XIjez32eCnQ6GdXpHfJ29doWyK0Ryq4nMps8vMqfI/iBdwdPidlnrc+4MgdAuzVVlMnZ29mBaAmX1OqTtOMPqa1JUbHWZEj94n6meRIng+k4p6sIt944976juxyr7GN5GRzVw92tTNWuKGzqo0BuxiFPKIj8IRGlj4wUw2IxhYSxm1qH4rR2DBX3W+H9Fg1tGh1SlpZgly+u2qwtJX0V2cuOnDVt5TiGnrs7szvcmDlugeYR23bzdWX17pakIfEhPyyEKVdouGfVfGyYb7XAvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xBABR/NvJSaoxNiaLM2R2UICkV2YPMwx2GN+TkPHuu0=;
 b=IPGGKPqtQ4hIUV5lZPJJjM11rypJ6tGdp42qle2OalKgUma50MzyEMDRm989n8rPtCP54rHlVaoFhO3YNQhx176nRFNcUCafffT0GKq/2xeA+dAWiYWRx1dYaochiwfQMYJYJV8jkwz+aOkxSW8p64sSdpnQ1VY9StilEr/6ozIOO9hiPE6L4pKax5XWNxF/0emg+rdwT2jAn/rJNoAPyryKqEu43wq0WmkAXgnKrQd5dQZNSXSEMB+V3ugAci+OC7Vwkv4yV0P7/VC/xL5x74T/mJneJLNT6rdl882EEWPyEt1ZcKX7Br5McSb1YNOSMU/BnJH+qV6iLT3Hs1HA5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xBABR/NvJSaoxNiaLM2R2UICkV2YPMwx2GN+TkPHuu0=;
 b=tvHH7ilS+bL0H6PsSGzMc8q6UA3zxT6/eCAun0VPamjY3YcEgYRitnMk3bb4wpxM6il0ICGiqMSwS7iJXzwbYlVzrnqW35FUmzadNfC4jS6ZLofR9gMvoU39deIIlAqjAZl6KekSfklDH7KK97VFnmUyFUGFKOzPhcUhF5bAbSsoRyoJ/AEH4ro/HUCH8LwUqi213hzHZZJlW2oS5JB5lsqTRle0bNgY0kWcIFB8+Ir3zMNIcGR68UO+YQrDRLJHqdRvm5aO687gVCxVj08nViowbVY6jkL0nrR1+Z0tUd8Xr+gl2wuxTAE+TkPkwtIObOpQu+fXT3AJifYRy0Grag==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by AM9PR04MB8955.eurprd04.prod.outlook.com (2603:10a6:20b:40a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Mon, 16 Nov
 2026 20:57:38 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 20:57:38 +0000
Date: Mon, 16 Nov 2026 14:57:28 -0600
From: Frank Li <Frank.li@oss.nxp.com>
To: sashiko-reviews@lists.linux.dev
Cc: Praveen Talari <praveen.talari@oss.qualcomm.com>,
	linux-trace-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
	vkoul@kernel.org, Frank.Li@kernel.org
Subject: Re: [PATCH v4 2/2] dmaengine: qcom: gpi: Convert dev_dbg() calls to
 tracepoints
Message-ID: <avtuOCLAtZEUeNg0@SMW015318>
References: <20261109-add-trace-support-gpio-v4-0-85ed08134917@oss.qualcomm.com>
 <20261109-add-trace-support-gpio-v4-2-85ed08134917@oss.qualcomm.com>
 <sashiko-outbox-204408@kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-204408@kernel.org>
X-ClientProxiedBy: PH7P220CA0001.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:326::35) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|AM9PR04MB8955:EE_
X-MS-Office365-Filtering-Correlation-Id: 338fa662-3ee2-4e13-314f-08df44243f4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|23010399003|261021121427099003|261009223027099003|261102123227099003|56012099006|261022105027099003|4143699003|11063799006|261028144727099003|261026140227099003|261026121527099003|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	gjjVp7EOQC6jK1unP8pm1yHIEis7ZtbIhbuTRlIfVOw29//a9o5rAPPhb3I7n3haYGquAcgNI3UYsPkgk5CodM9FQWu3cFz1ILxe+VNHgfoLW5ZF13dQeRbzyakDsyf8p7Boq2157u4EohbiDQLFrr0MqTs/R3wEhr15JaEHTDN9Llr/d3BQJVBmXFJ+MhmxbxaJBOVtldRfSKjlepnR8uih2y5VawT59cjkN1uBHYkjEVxIBPP9IJohe1d61jXPr6hjNat0FavMTv3vTZ+bHNsDvlloAcU9iTZ7e6MpVv2cRsQFGwPbH5HehSaBuK+IfezUWiVj1npohWaCfY8XY4PxgpFW5SgUbreHZB7XoxIHMHSOxCedLPDRgo4Kg3ntsTpkxomQMntwPQMcgrrQWGxDmr/PTaDCTWgxyh+x2IFyeIxxO8RRNpJ6Kc/HX23wXU8+ZqGB98Ffj0DRsGvYB6TgcV0/+njSxtEpUyGXj3Fi3J9sCv9VVf4sYRMNCW1dtf12viSZfEVwJseW3ES2zguRU6L/7Jb5VPWGty/QWAnjVeY6LOcZ19y5zKbH7eT0ZWDTRSXDuhOMQt6eaqGmdddcMoMSCEe65aFVq9avrgE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(23010399003)(261021121427099003)(261009223027099003)(261102123227099003)(56012099006)(261022105027099003)(4143699003)(11063799006)(261028144727099003)(261026140227099003)(261026121527099003)(22082099003)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?On/LQU3EpbC0i0qiluKhF8jtg1jjDDCRdA7SmEzXxQopjC/aJZLXHZ5+Bc?=
 =?iso-8859-1?Q?eIa2xnEty7yfV4XDyfb7U4hINThZM+/Ym7klOwiu9am6FTOueW2yHgm141?=
 =?iso-8859-1?Q?PevfDd0nwRxq5KiERQMN3CFB1CIh8v3AEA4N8QEqq9iwWcesizItAxFgTa?=
 =?iso-8859-1?Q?4TUsjjs2zjqWuUnf+le2P/y5gWrDckAkxXgYD0U3O4oBEv22o8jOaP1YH6?=
 =?iso-8859-1?Q?qmAbtwpDl5wOSGY1asm8gmvBSjSi79J5l8vsumXTHtiiLDRseaOBiRmPZd?=
 =?iso-8859-1?Q?HogTI9A691/Y8st9WCRBqVhZ7ILA4zIpYgMCLye3NsRvw70RwRU2de7506?=
 =?iso-8859-1?Q?t50lbQ/7x19sLJoHlsdK8pMtLiNLjVYa6kwq4nAwOhsza6PVRnRem0GRsw?=
 =?iso-8859-1?Q?sqpiYXfc3dfCE+lxxPtFwgzOFBYZbMCEWgRnQ+qE4Q2L2vQNAI+ij00Eaz?=
 =?iso-8859-1?Q?FG14AUg942v6Qi3ESx9KRjKqN4x7gOLTt1Oi+OqDVJOtqtgqQEr/HBOkQZ?=
 =?iso-8859-1?Q?IQX9fRhz3jp1CBlNugu56yZ5raZQqE+gPLjz86w/bX4v4vqZKrDmNg2gwU?=
 =?iso-8859-1?Q?Wz5lWtewTV916klAPyaJSyTrK6N1CEAERnmOOYLv3TB/Yrnn32dWLpcKb0?=
 =?iso-8859-1?Q?fCBvdbHIzWOcFr0i/zeNVOomhNskw+kd54NNjVRPmu5DPy5IjuyJ8z9fzw?=
 =?iso-8859-1?Q?pNtSm6fMM9iA1qALqwZKLf2RuyQCVwmHnVwbzj/yRyWRlTY6SZgUhkGhMQ?=
 =?iso-8859-1?Q?dA5+FDVwAv1HYelAMtuXgzYhEv8ymMmWfzKP6yecv2akF1FKx4dECUkQwp?=
 =?iso-8859-1?Q?yVLfaxARrGTI/s9G6MNsNzJLg7eRxHtAXeDhPI/xot1lu6JfYesHuKZ/FH?=
 =?iso-8859-1?Q?aYh7tPFO0rFWt7Je+nKA4Tl/bnG8UuxicPl/O04cFlC8U3AtPqgxU3Z/nb?=
 =?iso-8859-1?Q?MmfQpEaX8IoBBoFG4DISHdqt1K68eSOK7S5rVbKFYXGRX8pDxNZ54tOztI?=
 =?iso-8859-1?Q?FlrXDOIrwEwnpXBHes7pPwc0fGvZe6NLNUzSo2/pI3su0XnFCI6hjps6ow?=
 =?iso-8859-1?Q?djXYAJ6B3ZQKnDT6kScgC6/eHdCF7vPJMwqTC/VBTK6AmSmZzEQsq8lAOl?=
 =?iso-8859-1?Q?dLZ/7dCJaSriIrytqDmUBJZ4HC+ArhjVHyWlymxCs1foSLHSPcQ2YaSEEG?=
 =?iso-8859-1?Q?0HdACuDVuUu/j8WU1XC0IL4oTzh8m5iWiK1AO24JKzpuehLK4N5wxzJ//g?=
 =?iso-8859-1?Q?cBu3TqTEFPL6WB/y9szTlMgb6wnQox7+d7MoGl8wAPZdj3RmrcuA/KJSGg?=
 =?iso-8859-1?Q?FzEtsLqsO47LKC3M7y+4b2zRbSgRJgczSlp5u/A3txtzqKpFpRNP4QytH0?=
 =?iso-8859-1?Q?ng+Jv1/Pve6C3TOL+e9zydsGZUtenPCI0tIIlyDasvyPxDmTIr6BGPjnIe?=
 =?iso-8859-1?Q?wnfprPoHXfhjqr6qvqnK+eYtvPJmIAMHn+d1cNqQ1iyusjZXYb0ie7N0fW?=
 =?iso-8859-1?Q?46KG4UIrmRT415dc/6ZluPbhSZGUXg4pQbCyxx9K1zkGhRnSAFgMvwaCJ0?=
 =?iso-8859-1?Q?JtvBB8veYWwJxa/3nTmYCu0Lx3LnEA6GD7zBgl15ripCMyX6Tvg9dIBfay?=
 =?iso-8859-1?Q?/5HRfay8w6AhCEoJUEhRf4JphoXbHuisiFI8ODwIN+9XeC7Zpc2DMtGEvZ?=
 =?iso-8859-1?Q?3ReU0d53Tw9RgcW+WJsf5tpaTV9L6vMgYgVGD3vV0cdloFGbMqjuC4Ki9G?=
 =?iso-8859-1?Q?nk8bFRAh5YIFF0kldIYiE8ER45rZVgQ+8GUFpML+W3eHB8PR2eUrYSuRk2?=
 =?iso-8859-1?Q?1iFFWK7kLgNZK0LTm1nrc3bevkY5635zvQCAEbo4WzvCMFluqpXI?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 338fa662-3ee2-4e13-314f-08df44243f4b
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 20:57:38.2939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y3tsq1m0XtvDjIZMK6HvwsrSpxkSAcuEvT0lwZW471eKIe7HgwwpLeSsEBTaw2Y+WD3iupc1HefxO/J0sgne/ZlV/wfaPT9ZezyB2cSGFZSt14oAc3b1bBWJRVGtNkCs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8955

On Mon, Nov 09, 2026 at 04:40:34AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Medium] dmaengine: qcom: gpi: bare default label in
>   gpi_process_events()
> --
>
> commit 5129f82faa3a23c9f80811290603ff518d6e73fb
> Author: Praveen Talari <praveen.talari@oss.qualcomm.com>
>
> dmaengine: qcom: gpi: Convert dev_dbg() calls to tracepoints
>
> This commit replaces the remaining dev_dbg() calls in the Qualcomm GPI DMA
> driver with tracepoints.
>
> > diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
> > index fafe6ac848d94..8f9e55e52c616 100644
> > --- a/drivers/dma/qcom/gpi.c
> > +++ b/drivers/dma/qcom/gpi.c
>
> [ ... ]
>
> > @@ -1121,11 +1105,8 @@ static void gpi_process_events(struct gpii *gpii)
> >  							    &gpi_event->immediate_data_event);
> >  				break;
> >  			case QUP_NOTIF_EV_TYPE:
> > -				dev_dbg(gpii->gpi_dev->dev, "QUP_NOTIF_EV_TYPE\n");
> >  				break;
> >  			default:
> > -				dev_dbg(gpii->gpi_dev->dev,
> > -					"not supported event type:0x%x\n", type);
> >  			}
> >  			gpi_ring_recycle_ev_element(ev_ring);
> >  		}
>
> [Severity: Medium]
> Does removing dev_dbg() from the default: case in gpi_process_events()
> leave a label at the end of the switch block without a break statement?
> Under -std=gnu11, GCC versions prior to GCC 11 reject a bare label before
> a closing brace with a build error.

Please remove default: also

Frank

>
> --
> Sashiko AI review · https://sashiko.dev/#/patchset/20261109-add-trace-support-gpio-v4-0-85ed08134917@oss.qualcomm.com?part=2
