Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011010.outbound.protection.outlook.com [52.101.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEA758E2AE;
	Wed,  9 Sep 2026 20:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788987551; cv=fail; b=eeZFuEzp+u2zCD6QqGbusP0LkEjFkQT65crdcsRrxDzAksX5EAMbDcHJUjg47PwE3/nc1klrOBsoWfyzfl6D6s2+vsvvezHOoSC5+LbbEKGpx15If/kxB7isWzIJFRbebk/eMsOXxjAtrqMavOGlXeam+NC6pr5anOb1+klq08k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788987551; c=relaxed/simple;
	bh=pU786dc74wlBP+mVh61+sAvj3FrrFjehsvHZ0VIYppk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=s/1vtZASJE7tcUFHAS3JXiADXLeKEnPrFFUhSphbd+Op4UkFEOkgZbhGeVoQ59OmPEo4cQSjHCOkePldkJFkMKZz6A9iHtE3EJ/9OS0lc2XhfrTggSsdUf3T1R/7gjTQopo+Owv+NfUNyS4VJ8CjKY2SUgGoA9eYa1PJC5Xw3uc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=OGpv2YSF; arc=fail smtp.client-ip=52.101.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="OGpv2YSF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y+lcHYcCh1PQbXpA3ENZvNulYOSGCQipem2D+dcukrKs2qGoU50TuIpynCo2isI4wiIrrR0eIVfcTX9Y9LYpk1cNPCbGYrU/NX8EFz+l8B364++oFxBkeL45c9eYEYcJluLYI0913XS24H7x1/6yTN8lsBpeYDJJo+Gah2GMYs7uzL6IdWn6nl85qjE3w8CmXO2E5DGYhP7aQSugl7rEcNNyRqY/6uvBu/khicQhckurRQFUkILizd6/1RFMjhKAWVhdKyxb0SxSuz6IjzOLc2qTw057aNgz0j2aIoDx6EpGOpPpEPlEyPzWtOXe7ATP7zHDjQBun+Xc9qbtRZ21Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vUEX4eIjYAnkZe+CF4bAUJ1tGe9aKUyyBXkhtXvzwJU=;
 b=uUrIbO5fdY+hWLkbPC48nGlJt0VjUWiQaogIb2fNPkpvOx+Nxh6onuthpz3zNGeBX+qg1R9K+Yj6GZlq6UYgP3GVsbKY2lluyiKX3KgiU9kfxJHXOuK3FO6qQd1/fUYClPCVBc2b8gmMKNFBSISpAII17OgXu5HD0ZQn4SjtyVN6TC6Aj4uboEAlqX/43G4eNAXyz10CgGdqAgAiWLJ2zY/9uoeGcaUYHRs9ar33IWAwnaxGQQ9QJG6K9CKmFZqR9JB6DEJU/p23sT9XQ4jc3ru4tzcPDYwA31n1ngMAU+9tEIsD+aokDdBW2qRO0gucyPIE/Y9R1nSJiCOdUcRY5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vUEX4eIjYAnkZe+CF4bAUJ1tGe9aKUyyBXkhtXvzwJU=;
 b=OGpv2YSFTbuJMRElDN91GfjxLXUgJ/c4pjbIwjsG/3oQDzs9WIcGPpVrX1XwLdGVz+aiTQdK+mTdjZRuLAfk3YPHifLmoZR9Zx5/2vYbm+6Iu6+KE2byt6EqLPDaIJoCsjpZX1DYQCj851d+Vn4hVky5i0DZ66jIAUFxBTDvuPJwoVzg5XGuglfu6s2f6h7h1zY5cRoQEfaV9s9Qok1tJEqyD6t3P/K20aAyVQGaqtSbpOLNmN3qLnUKSq63jyts+L1OTQJRqnaborwq6JTHVjtIZv0ZkDmCPR+W35N9wTDKb5IMtrwwZmrbDIasjmTT3U3uaqc5L8IVwv62FlRN7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DB9PR04MB8495.eurprd04.prod.outlook.com (2603:10a6:10:2c7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Wed, 9 Sep 2026
 20:58:59 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 20:58:59 +0000
Date: Wed, 9 Sep 2026 15:58:48 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Praveen Talari <praveen.talari@oss.qualcomm.com>
Cc: konrad.dybcio@oss.qualcomm.com, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	chandana.chiluveru@oss.qualcomm.com,
	mukesh.savaliya@oss.qualcomm.com, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	dmaengine@vger.kernel.org
Subject: Re: [PATCH v2 3/3] dmaengine: qcom: gpi: Convert dev_dbg() calls to
 tracepoints
Message-ID: <aqHIiBMVmuBKx6lM@SMW015318>
References: <20260909-add-trace-support-gpio-v2-0-01f81739bb88@oss.qualcomm.com>
 <20260909-add-trace-support-gpio-v2-3-01f81739bb88@oss.qualcomm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909-add-trace-support-gpio-v2-3-01f81739bb88@oss.qualcomm.com>
X-ClientProxiedBy: CY5PR19CA0076.namprd19.prod.outlook.com
 (2603:10b6:930:69::22) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DB9PR04MB8495:EE_
X-MS-Office365-Filtering-Correlation-Id: 1533ac66-477e-41eb-46e3-08df0eb52b3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|19092799006|366016|23010399003|1800799024|6133799003|10067099003|5023799004|11063799006|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	1dXhXVzV0tr9b0+gb0a8bKom5wmT5Bltv8js9YEHlollOpJhcshiusGuT2rYTuZs+P/f/QsSihgCdiagaStm7fYUjLo3zbeyfFS0n8sM57AvqMWRqGQCWI9ItGgLDHe2mD+oN5ikLx/GEFCLpIk7+TPgHf40g/OrTPWJkrf3oTL+iZTaFcpQiZJitf00iEna70m2mV42oNJ+uxQ3TyOXvFvf0H1rr6B0Yk3+wcVX6rzUMyXaJENT6+dOeSCIQOjP5F03WKBOJSGzv+lbD/kwMh6sqPpo2ho8jM8QJktHAxkfaZ0h0t6csLXmQvZ7qOdkUHAi56IfuFuNMWfODt54XXJvEVTJ+qG9HDZWgHISP17HvZ9H9AIVuy3B45Bms38YshByjq8IFnhXRiWRzS+BTmsksZZR2I2NQbKqh9gJ6gK5AQYwGj/zF9iYmRJNlgKt9A9VBD9++Nbv6qIF9EslbzD3Mtv9LBymMxmDQcp1x38bCtgbKXVZ4K7yILKtdoVVgiAFcREyXTRdmCWsM35WdyyGBTk+wxtqZTuplf5W0FAPDHbiBxj34xcxwvc2JlqrnMFduRdOL1AXvkJi7ehX376MxtF6QwVYF26u3t948QKNJRxbn1yZ40r93Pb/EBCddPogghmKB8w9OAv4mm1HdD2va8Lr8UmvHI6PuTBNqNI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(19092799006)(366016)(23010399003)(1800799024)(6133799003)(10067099003)(5023799004)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eraXImC3s32yEMTcBdvnrOGrYvUsnlgxFVSxc/x+i51Xiui2xaNpbS3s7/1z?=
 =?us-ascii?Q?E6Zfnv/K0I/GDR9NwAwVXkOovxH9IEBKAXYyiiVkfYvOlKy+WxS1wblyvKr9?=
 =?us-ascii?Q?7qgiRSu+yCWbRORd8iulYSvVBzQn5OxHy8K4PjCrIBFGFzrI0o1wxqGWC7Jv?=
 =?us-ascii?Q?jDBULz1afldS1xCrBdsi5riJG346W7Rc20vtf5HxadxuzvXgUlBGw55A/qjl?=
 =?us-ascii?Q?0dz/xNlEmuVvE55EN+8NLHJAeVNHx935VCdi3zFry7FoakR70Op3tGAVNmCr?=
 =?us-ascii?Q?FJj8HrGMmS6xNgZgOO0SMUFl7JQQNOE6OoGu4s4IkMpeoKvcslaSvo/P0bCv?=
 =?us-ascii?Q?l7C5v7iwgXaBzCN0JWiaIIuqXH5HsfSuMnYlA9ygtQUInfRqU3eaMwkokFMm?=
 =?us-ascii?Q?LshJvyxA5ReDboPwLeCZwmyZO9QZz3YwveasPKfHGt40wcI5tnSgCiEH/CWR?=
 =?us-ascii?Q?qSlRhqXHUoufmDlem3c7rjJRCXBQg/8rVUjhDm1CnvPuU98l75wZDQFEoJnB?=
 =?us-ascii?Q?JYy24LQ+RLJm6zHeW1lywjJS3rN0HJQ2JVUaFs0jBLPsm3D/1M9HKkG2BgSO?=
 =?us-ascii?Q?yWa5xP6dz8hcFIPyTvligJ4AZUiamfijfzWVJ8hvO4IEiE6xGrEhiM/HLXvE?=
 =?us-ascii?Q?tlqb7ttyvgKb/ksfxDEvuVv3MmrTsO1T1NHXcKQfYWGzb1giG2nNiC3Pv1bl?=
 =?us-ascii?Q?lxEfoTThQEhYv34+Jjq07oZY7/RZCVaPROhVRXdrgQeIVM/yJVcgc3d8hG5P?=
 =?us-ascii?Q?+gIsV12tQweVkjToD8uirpxep8wcON7nQAtNVWH8zf1EqeJCX73EQwthTSOz?=
 =?us-ascii?Q?Qn/KNwNzdZCYN9UtobUkJYhJ0xg/ktF+cOgpMKsxOa/5U3hwr1s/72zOdYGI?=
 =?us-ascii?Q?uQrW9gs+KyRLK0g4v5Q7oRb8sACMltdFCjFMOfEebryzL4Zf5d9WMpA4ZdhR?=
 =?us-ascii?Q?XmAmPhZHq4CTS8NxJYHz4pFQKhnC6xEozO+VvdsQXL6lZbYTnQb0Ne/Z/WNk?=
 =?us-ascii?Q?Sr5/YhF86zquOo2swUdgGHDhnQjBhdkRg8sVaUv7VNlSMSz2hnOX6GwLBuYM?=
 =?us-ascii?Q?eWfEjKTm+MD05qv/T93qDhbHI0ybMLSRDhbU9keaPiKmz7BzZ2EKKrv0Jvvx?=
 =?us-ascii?Q?z0gRpbr+IooCMxgqRbICiV2yhySD9MIOTflLquO3weSAvpX1Sd+GNAg+F7gr?=
 =?us-ascii?Q?+/Ytg0KFN8+tnCVViEluocFZg0Q54sNxSIMlsoc54gfBZ7ATC8oLqIMBiUt+?=
 =?us-ascii?Q?+kIYgz1NgGNvq78UrV3vr47Lfxw9t0bBevVWU6wM647N1OVi0URz02IGfoH6?=
 =?us-ascii?Q?FvmozH3b68q7g2MHkcCn59DOMaaujjec1WUlsJ4Q9pKdw2cMqFjBAun2gFaU?=
 =?us-ascii?Q?OlVPSNvTZDzdhpqh1dJko4DphZwqrcHEwIl29cESQp2qzK/i65/1b0qksg/g?=
 =?us-ascii?Q?rtN1TRPuaDF7pL7G9nwH2sWeHn/ksuDHKEjp9C3VOeeNeY7loi4PuVgExR7j?=
 =?us-ascii?Q?MXnw0dvNdBwpic6tWabJHcKlNQeY1jQcxInkUWp5f9wG0byydiIoI/JGH4X2?=
 =?us-ascii?Q?pd+uV3TYEXLumQ2YQCzRTNWCI+rBBNFg7MOAuldWm5+N9KvxZp3M6vB9h9D/?=
 =?us-ascii?Q?idUZ3KsCcJRYVm1RqBEXaRnjNuL6a82EptgmyKEGq9JpEpu8Yg6js29+cZxv?=
 =?us-ascii?Q?qd0Jf5m75VKyAhlSbxrkReWiU7ywtJP0zTSaKFBXdT5B2xNWd4ODldQLl5cq?=
 =?us-ascii?Q?vVr0RaYhnxVJhnKI9A+VY2Jx98VEviuWxBsvPVRpEH4oR/k1YhOR?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1533ac66-477e-41eb-46e3-08df0eb52b3d
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 20:58:59.0030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uXQOq4suGnbUwp14agsp1oaMiRMR6GVo+oxtbjC/JtTCxObuwO56H9Un2GqNgqIkuOPLPzGDFZHI2YXfwJCzGOTwpRI5Vmym931H7cP4qINoaH9u9S3L6ffMiWUuQ+9H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8495

On Wed, Sep 09, 2026 at 10:39:43AM +0530, Praveen Talari wrote:
> Replace the remaining dev_dbg() based debug logging in the GPI DMA
> driver with the qcom_gpi tracepoints, providing structured runtime
> visibility into GPI DMA behavior without requiring invasive debug
> patches. dev_err() calls are left untouched.
>
> Tracepoints are added at the same points as the dev_dbg() calls they
> replace: channel/event command dispatch in gpi_send_cmd(), error and
> top-level interrupt status in gpi_process_gen_err_irq() and
> gpi_handle_irq(), event/channel control state transitions in the IRQ
> handler and gpi_process_ch_ctrl_irq(), completion event handling
> (including the no-pending-descriptor and transfer result paths) in
> gpi_process_imed_data_event(), gpi_process_xfer_compl_event() and
> gpi_process_events(), ring allocation details in gpi_alloc_ring(),
> already-in-state checks in gpi_pause()/gpi_resume(), TRE contents in
> gpi_create_i2c_tre()/gpi_create_spi_tre(), and TRE queuing in
> gpi_issue_pending().

needn't this paragraph. The first paragraph is clear enough.

Frank
>
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> ---
>  drivers/dma/qcom/gpi.c | 58 ++++++++++++++------------------------------------
>  1 file changed, 16 insertions(+), 42 deletions(-)
>
> diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
> index b09354a73b46..8e7d25a46147 100644
> --- a/drivers/dma/qcom/gpi.c
> +++ b/drivers/dma/qcom/gpi.c
> @@ -684,8 +684,6 @@ static int gpi_send_cmd(struct gpii *gpii, struct gchan *gchan,
>  	if (IS_CHAN_CMD(gpi_cmd))
>  		chid = gchan->chid;
>
> -	dev_dbg(gpii->gpi_dev->dev,
> -		"sending cmd: %s:%u\n", TO_GPI_CMD_STR(gpi_cmd), chid);
>  	trace_gpi_send_cmd(gpii->gpi_dev->dev, chid, gpi_cmd, TO_GPI_CMD_STR(gpi_cmd));
>
>  	/* send opcode and wait for completion */
> @@ -797,7 +795,7 @@ static void gpi_process_gen_err_irq(struct gpii *gpii)
>  	u32 irq_stts = gpi_read_reg(gpii, gpii->regs + offset);
>
>  	/* clear the status */
> -	dev_dbg(gpii->gpi_dev->dev, "irq_stts:0x%x\n", irq_stts);
> +	trace_gpi_gen_err_irq(gpii->gpi_dev->dev, gpii_id, irq_stts);
>
>  	/* Clear the register */
>  	offset = GPII_n_CNTXT_GPII_IRQ_CLR_OFFS(gpii_id);
> @@ -866,8 +864,6 @@ static irqreturn_t gpi_handle_irq(int irq, void *data)
>  			u32 ev_state;
>  			u32 ev_ch_irq;
>
> -			dev_dbg(gpii->gpi_dev->dev,
> -				"processing EV CTRL interrupt\n");
>  			offset = GPII_n_CNTXT_SRC_EV_CH_IRQ_OFFS(gpii_id);
>  			ev_ch_irq = gpi_read_reg(gpii, gpii->regs + offset);
>
> @@ -887,15 +883,14 @@ static irqreturn_t gpi_handle_irq(int irq, void *data)
>  				ev_state = DEFAULT_EV_CH_STATE;
>
>  			gpii->ev_state = ev_state;
> -			dev_dbg(gpii->gpi_dev->dev, "setting EV state to %s\n",
> -				TO_GPI_EV_STATE_STR(gpii->ev_state));
> +			trace_gpi_ev_ctrl_irq(gpii->gpi_dev->dev, gpii_id, ev_ch_irq,
> +					      gpii->ev_state);
>  			complete_all(&gpii->cmd_completion);
>  			type &= ~(GPII_n_CNTXT_TYPE_IRQ_MSK_EV_CTRL);
>  		}
>
>  		/* channel control irq */
>  		if (type & GPII_n_CNTXT_TYPE_IRQ_MSK_CH_CTRL) {
> -			dev_dbg(gpii->gpi_dev->dev, "process CH CTRL interrupts\n");
>  			gpi_process_ch_ctrl_irq(gpii);
>  			type &= ~(GPII_n_CNTXT_TYPE_IRQ_MSK_CH_CTRL);
>  		}
> @@ -945,17 +940,10 @@ static void gpi_process_imed_data_event(struct gchan *gchan,
>  		struct gpi_tre *gpi_tre;
>
>  		spin_unlock_irqrestore(&gchan->vc.lock, flags);
> -		dev_dbg(gpii->gpi_dev->dev, "event without a pending descriptor!\n");
>  		gpi_ere = (struct gpi_ere *)imed_event;
> -		dev_dbg(gpii->gpi_dev->dev,
> -			"Event: %08x %08x %08x %08x\n",
> -			gpi_ere->dword[0], gpi_ere->dword[1],
> -			gpi_ere->dword[2], gpi_ere->dword[3]);
>  		gpi_tre = tre;
> -		dev_dbg(gpii->gpi_dev->dev,
> -			"Pending TRE: %08x %08x %08x %08x\n",
> -			gpi_tre->dword[0], gpi_tre->dword[1],
> -			gpi_tre->dword[2], gpi_tre->dword[3]);
> +		trace_gpi_ev_no_desc(gpii->gpi_dev->dev, imed_event->chid,
> +				     gpi_ere->dword, gpi_tre->dword);
>  		return;
>  	}
>  	gpi_desc = to_gpi_desc(vd);
> @@ -1064,11 +1052,10 @@ static void gpi_process_xfer_compl_event(struct gchan *gchan,
>  		dev_err(gpii->gpi_dev->dev, "Error in Transaction\n");
>  		result.result = DMA_TRANS_ABORTED;
>  	} else {
> -		dev_dbg(gpii->gpi_dev->dev, "Transaction Success\n");
>  		result.result = DMA_TRANS_NOERROR;
>  	}
>  	result.residue = gpi_desc->len - compl_event->length;
> -	dev_dbg(gpii->gpi_dev->dev, "Residue %d\n", result.residue);
> +	trace_gpi_xfer_result(gpii->gpi_dev->dev, chid, result.result, result.residue);
>
>  	dma_cookie_complete(&vd->tx);
>  	dmaengine_desc_get_callback_invoke(&vd->tx, &result);
> @@ -1100,11 +1087,8 @@ static void gpi_process_events(struct gpii *gpii)
>  			chid = gpi_event->xfer_compl_event.chid;
>  			type = gpi_event->xfer_compl_event.type;
>
> -			dev_dbg(gpii->gpi_dev->dev,
> -				"Event: CHID:%u, type:%x %08x %08x %08x %08x\n",
> -				chid, type, gpi_event->gpi_ere.dword[0],
> -				gpi_event->gpi_ere.dword[1], gpi_event->gpi_ere.dword[2],
> -				gpi_event->gpi_ere.dword[3]);
> +			trace_gpi_process_event(gpii->gpi_dev->dev, chid, type,
> +						gpi_event->gpi_ere.dword);
>
>  			switch (type) {
>  			case XFER_COMPLETE_EV_TYPE:
> @@ -1113,7 +1097,6 @@ static void gpi_process_events(struct gpii *gpii)
>  							     &gpi_event->xfer_compl_event);
>  				break;
>  			case STALE_EV_TYPE:
> -				dev_dbg(gpii->gpi_dev->dev, "stale event, not processing\n");
>  				break;
>  			case IMMEDIATE_DATA_EV_TYPE:
>  				gchan = &gpii->gchan[chid];
> @@ -1121,11 +1104,8 @@ static void gpi_process_events(struct gpii *gpii)
>  							    &gpi_event->immediate_data_event);
>  				break;
>  			case QUP_NOTIF_EV_TYPE:
> -				dev_dbg(gpii->gpi_dev->dev, "QUP_NOTIF_EV_TYPE\n");
>  				break;
>  			default:
> -				dev_dbg(gpii->gpi_dev->dev,
> -					"not supported event type:0x%x\n", type);
>  			}
>  			gpi_ring_recycle_ev_element(ev_ring);
>  		}
> @@ -1409,10 +1389,8 @@ static int gpi_alloc_ring(struct gpi_ring *ring, u32 elements,
>  		bit++;
>  	len = 1 << bit;
>  	ring->alloc_size = (len + (len - 1));
> -	dev_dbg(gpii->gpi_dev->dev,
> -		"#el:%u el_size:%u len:%u actual_len:%llu alloc_size:%zu\n",
> -		  elements, el_size, (elements * el_size), len,
> -		  ring->alloc_size);
> +	trace_gpi_alloc_ring(gpii->gpi_dev->dev, elements, el_size,
> +			     (elements * el_size), len, ring->alloc_size);
>
>  	ring->pre_aligned = dma_alloc_coherent(gpii->gpi_dev->dev,
>  					       ring->alloc_size,
> @@ -1437,10 +1415,8 @@ static int gpi_alloc_ring(struct gpi_ring *ring, u32 elements,
>  	/* update to other cores */
>  	smp_wmb();
>
> -	dev_dbg(gpii->gpi_dev->dev,
> -		"phy_pre:%pad phy_alig:%pa len:%u el_size:%u elements:%u\n",
> -		&ring->dma_handle, &ring->phys_addr, ring->len,
> -		ring->el_size, ring->elements);
> +	trace_gpi_ring_info(gpii->gpi_dev->dev, ring->dma_handle, ring->phys_addr,
> +			    ring->len, ring->el_size, ring->elements);
>
>  	return 0;
>  }
> @@ -1542,7 +1518,7 @@ static int gpi_pause(struct dma_chan *chan)
>  	 * client needs to call pause only once
>  	 */
>  	if (gpii->pm_state == PAUSE_STATE) {
> -		dev_dbg(gpii->gpi_dev->dev, "channel is already paused\n");
> +		trace_gpi_already_state(gpii->gpi_dev->dev, gpii->gpii_id, gpii->pm_state);
>  		mutex_unlock(&gpii->ctrl_lock);
>  		return 0;
>  	}
> @@ -1578,7 +1554,7 @@ static int gpi_resume(struct dma_chan *chan)
>
>  	mutex_lock(&gpii->ctrl_lock);
>  	if (gpii->pm_state == ACTIVE_STATE) {
> -		dev_dbg(gpii->gpi_dev->dev, "channel is already active\n");
> +		trace_gpi_already_state(gpii->gpi_dev->dev, gpii->gpii_id, gpii->pm_state);
>  		mutex_unlock(&gpii->ctrl_lock);
>  		return 0;
>  	}
> @@ -1703,8 +1679,7 @@ static int gpi_create_i2c_tre(struct gchan *chan, struct gpi_desc *desc,
>  	}
>
>  	for (i = 0; i < tre_idx; i++)
> -		dev_dbg(dev, "TRE:%d %x:%x:%x:%x\n", i, desc->tre[i].dword[0],
> -			desc->tre[i].dword[1], desc->tre[i].dword[2], desc->tre[i].dword[3]);
> +		trace_gpi_tre(dev, chan->chid, i, desc->tre[i].dword);
>
>  	return tre_idx;
>  }
> @@ -1797,8 +1772,7 @@ static int gpi_create_spi_tre(struct gchan *chan, struct gpi_desc *desc,
>  					 TRE_FLAGS_IEOT);
>
>  	for (i = 0; i < tre_idx; i++)
> -		dev_dbg(dev, "TRE:%d %x:%x:%x:%x\n", i, desc->tre[i].dword[0],
> -			desc->tre[i].dword[1], desc->tre[i].dword[2], desc->tre[i].dword[3]);
> +		trace_gpi_tre(dev, chan->chid, i, desc->tre[i].dword);
>
>  	return tre_idx;
>  }
>
> --
> 2.34.1
>
