Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011051.outbound.protection.outlook.com [52.101.65.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B7E556B9F;
	Tue, 13 Oct 2026 21:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791927905; cv=fail; b=iIeY+EDS4/0lkoo6djX7mb3xhSKatom8yRsW+9MKbw+KXrXKjqWkBGig6A79x20OgJN2Jxn47MHBl1jDvFhg0jrsSdEA5t6c1qiMWaa4ugKY6V0YBQCnTrJ1XQApa7hsaql8NjJl+qb08TaiqppkonQgQoQznyAPL8aPhfTuOH8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791927905; c=relaxed/simple;
	bh=2pO/KF46KLgasBMV6+vVxMc6jcvhlDEEaZCiIAs/mEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OdJO39v+Vb1HWRMOxdK7RSGH5+pl0S1gppJAWSxREF474x2mK/YziDjhEmAcS2gI7vsDq1Vb9lRXgAYbXtLw+4h6j7xz62gWluSQ9OZcqjP+7UyeIGl8cnY81mr6zTJXo459QTbEze9r+D7XhgjHcEOLOoM4vv360aqEpV9CZmA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=uWQFsRKh; arc=fail smtp.client-ip=52.101.65.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="uWQFsRKh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n/OMwxqTlETX3ts3CIHmiQcXbG2NzwfTI4D+LGTBtI9Uz67JxDG9a7B71a8mrPTO66TZJ9Mqbf+WRsRTXmWc4I+CY4tw7g/XCPF012mZ1kJBqntimDBoUK7jmpzG48JU5foxh9q0hkd3mcgkmyGK1c3mkfFVXr/Y3EGwWuAGuRHOD/lutlDIHwsRhrjrgGG+lanxMFWmBDoyc64P6dxcHiIEjgfYL35+ksshE6n5AmHXmC8QnVYw3thVv/HOShMx7aTvLLOqyJuwHrjd2OAW7A37Qbd6h1M5UoYY7nx8JcCt4FO/zi+v9U6shdKxjWqmuKmGd/q2v+upPEkjyW9lkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TsyC7o4RCNo51pYo75swqDqrWL4tbnPp8FFv8pbmaLM=;
 b=HVrMF+Zi6HVx22hP7/kdrXL/NEvaJGxGD7LaXiExnE9Wm3TXKRncRfin4TA20iXegJUtdUBZTZnEdmrB+wgtwsh41txUl5tYrFJVQRJPtFOLlt+eqQIGeLWvTTalfoeUMw1l2vyp2D27qoytAqM3rMgt5S55uMquLvqu9tZ2dGYaKcfvqQ1YeCVizzj1tUCuFeon7MujaIz+co9LY1cxy6ChaQ47Wk/i7ijUVs4c7L6AFwVfXS9aKDLuW+GAHecXCWTtFaSaF6T4lPgRMf2b6ACsGrg9+tSZziWl9j6miz7O3V7U9oVuZo1CYTNDqqWF4wDR+Y8H6z0+Q87v6q/GWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TsyC7o4RCNo51pYo75swqDqrWL4tbnPp8FFv8pbmaLM=;
 b=uWQFsRKhIpRoHy48xfcUnaBMPXGtjTdz0amRrdjUR61ArshDgv+kyxqRjXUTorl4rMIhfJ/2EcaoJZw7vZdB86Y9zhbGRW9x+05cNIQRL6WakBOw9sn905+tVcrUaDX+V732JqekMY5Ux75h/yq6vT0VPP09Ja4HhqFaSLoFV0PlGguTgngNjvyBVQQTl4OoIDWE9cxazMCoQ0S7pDu38smp+MXrcJAIQePlMMrbNQ3ivFQ33WMPmxbgqHTYOGGfrCUcQcqCZUdkGTR3TgD5SR08m/gGt/i+721RH+t1zx6kpyiwbgMVDkfKXbhOAp09qx38jsLw/jZM5L/xtl9Bew==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DB9PR04MB9281.eurprd04.prod.outlook.com (2603:10a6:10:36f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 21:45:00 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0522.011; Tue, 13 Oct 2026
 21:45:00 +0000
Date: Tue, 13 Oct 2026 17:44:51 -0400
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
Subject: Re: [PATCH v3 1/2] dmaengine: qcom: gpi: Add trace event support
Message-ID: <as6mUwKZy8I1Kdyw@lizhi-Precision-Tower-5810>
References: <20260926-add-trace-support-gpio-v3-0-8572bf7456b2@oss.qualcomm.com>
 <20260926-add-trace-support-gpio-v3-1-8572bf7456b2@oss.qualcomm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260926-add-trace-support-gpio-v3-1-8572bf7456b2@oss.qualcomm.com>
X-ClientProxiedBy: CY5PR19CA0029.namprd19.prod.outlook.com
 (2603:10b6:930:15::7) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DB9PR04MB9281:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a94ed43-47ab-4d6d-e28c-08df29733b1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|366016|376014|19092799006|23010399003|56012099006|4143699003|11063799006|261009223027099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	pFIZaPfkoRR8gJf5c4EEXwOlK+BAA/6YZTEjdjan0hfRJ+iJOOLIG8HmdiEqAUUt8x4pHNPdUqnyaFri9pTKCZT9vU3skTDyeLq5vdLsYUvphidPfqp+L7nZfFRVgriGrRrPOKLUchqyhEzr/PBUJ/FUjma1Mg3vZmvxtgUJe54QtFKzN5paBtXKJw54mBraUN92KJtwp5iZt/WALp+M6YjCGS2RPVU/GQqB2daGt42ejYPAcX6lJJzkgMw/3xrfkxULQOqtpihffZ+3WIbr0g28Dlj9mZ0V3Dim0ugt2/AO4WA1jow1P+gF1McVX9ZzzvGlaVaab9VdF/JQH4y9n+ivGp+R6kFYSnITMD453Vl2/yxTaIH0NtuVesDDXOQWiZ7dEQh7ULfImWscIOuWbRcOtH64R4BJFjd2kuGPO9cidfSGGlbqSmK/e75vQG9YXGqVLwdqYrqI9tuqtHx8pEmdkH+eI4Zf9ESUOBMpo5rsiiS2h+H6xGj9ccF9d6dykaKrFxxAuHuFMtDGO2qZrAX+Cl8Fz63Bf1o6kTP6pyf8vWcQWkTIn2xrWxpJV0GwfEA2QwpIwq2KCTOPlOzPJnSmNy6GpWBq5lpo24Z0etHFaYXGUSfhJ5B+WbKzYhYaWjfrE+kM/nWDigL7uJvUnl6O0pdOyafEaiNGVKjVBJE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(19092799006)(23010399003)(56012099006)(4143699003)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YPaul43iGyYjX5Y9x5mdVrl8hvHt4NbhPScpBxCBqLZrV99uBdmVT0wOm40Y?=
 =?us-ascii?Q?DsULQmQpyPevvEuicgkLFXIOyseGFs14abhZxXP/3YxeXUtfbZbC5KaqM5Dt?=
 =?us-ascii?Q?vHUpVKAqa1ldNl1S7besZty987lECaEbqIIVdh2mzz1sd/QDy7LWUMlZmgQZ?=
 =?us-ascii?Q?W1WvKdqqm+4tdLWqIE54Qg7EyGqn+qwtvJSgb9+/ZEh7bXX9vUQ+AZV9u/7F?=
 =?us-ascii?Q?lGtxJ3dKQnoyP4yOBd9sW34RaK/QrNxJIKyDDmqHPAb3oWA2ZMRdpyQRlgH8?=
 =?us-ascii?Q?xakarTEhLCVoYUWXyly4qAsOn4xWGJrbI3Ol8PXL9ov+Azy20yX1KzR5nQnZ?=
 =?us-ascii?Q?KNrggrK5AiVbBG+Z2qQYWfwL7hXY6f2ohlHatzkrA0kmHD5tZvwEH/T5S4OF?=
 =?us-ascii?Q?+O3iJql0xKDNv4xoYXk0BnYVQ+dRshRojxxqVfi6f/cuqeg5g57EMsKyCuPC?=
 =?us-ascii?Q?sv/X1C90LR27S7ZZxwv3/QJhE8XbCjoZ1Hc2f4GuX8mX0J9XWooNIZ7IIj2X?=
 =?us-ascii?Q?JMcPJECIhYGkeJI++piTXyinIFQQQ31ZTVWoNAoUMQk0KJu5+Oeb16gCxCZm?=
 =?us-ascii?Q?cIZ0g/G2+kDZVD6/7shM+aiNpZzlV27V6XVuoJLFyKTOwDiJQjr0pZLyGYkm?=
 =?us-ascii?Q?nKajDvfEGo2q4GFtc8hj5u1VpjbSYUxQemb3GwkST+t0hgVB1j71JyQskrxN?=
 =?us-ascii?Q?rTBeXBtGnuyYCah/O/qSayOoiMPAzwZaeiCCJz560pN0kgoVRrrFLLzyx54w?=
 =?us-ascii?Q?DQtmuPgLMoQ19fKLJ20FePy/RY5QCmJpsFzDJoQeazD0IPOYlYZ+RJvTAKOo?=
 =?us-ascii?Q?nyYFcEk0FjjHcqItVSa1Iz19szPMTHLfhEYrPx8Le+WALhdeYf6VpxrLSS8q?=
 =?us-ascii?Q?uBnp55k1RAr5fWK3n5LKWLvw+eiPJ7iPIpuTOLnQVGbePkKj1z45ERriB0/s?=
 =?us-ascii?Q?KDKd21VZ1XKCPSmNEHY+Br06GcR2+WScHuY0tWkrI/bKO2qNuilW96ZRo25e?=
 =?us-ascii?Q?rw7TaYeqipV76MqWm3VODRkPXNy8aZsUXj6tQFUrz4QrU2oBE+NVcrKGvYos?=
 =?us-ascii?Q?1wbHW/FIf986CT78csYSIngEfPCI62VTw8QzZEBp+6ZDR8vf8Zi+cBEOEhf8?=
 =?us-ascii?Q?TFHeq/3/kggXCBZhv20v3NSXe60zh2QQyXKQV8hmFnXhoWaRtlTjklDr/lJY?=
 =?us-ascii?Q?5Ya7qVGMtAchNlhie7SevdTTACQgFz6l1tGsBu92YdAXksTrlcZ+PnrbU3ow?=
 =?us-ascii?Q?O6zUMJFLbI9udS+4xg89h4vHuEEtBG2AjvX25jncwTkoR7W5ZfWcHRwxgPpm?=
 =?us-ascii?Q?aNMKYzMQZ53uLFOuWJvx3RBa+7kJJS/JC8mvfk4DdahQ+TO5J+4SLzLkykUI?=
 =?us-ascii?Q?jXBFptZhKqUGtXCap7A6QLIpYP12wTvCfsE6nmscc6HT20tagbDpMrKQFGPg?=
 =?us-ascii?Q?IrZZg6im/W2IFnCa/AG0PMsTqj/9HdmQqXM9Z44lUd/tBYClu5Tw10DT334w?=
 =?us-ascii?Q?1BG8kc+6GUxiqkTTkRlTr916FrWdT61dsF7cX96ynzArtxU/Ugt4x9CHwJ5s?=
 =?us-ascii?Q?WH0WoVXy/6x8plE66ImJXVs/BYOXtYSrgJl6Dj5eQ+3En8BY0Z6W2gGASdsB?=
 =?us-ascii?Q?3TwKXoXZnJHNLnB1deCGk8GAjQM2w9n8wf+u1n6PJsgwRdrvdJTHdEgnomU6?=
 =?us-ascii?Q?G80OZ6dW38D060XXUpYCKa5qeqTbLdOuNK4nLAmZAtqRETk3aTwrnQu5NHI/?=
 =?us-ascii?Q?rML1pk+t7AY8OIuhYZvhXMfI3IAL0BG84ui+jyZwkcYRwXK5qF91?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a94ed43-47ab-4d6d-e28c-08df29733b1f
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 21:45:00.2813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3bGEPPOrdChvx7QeUP95lGKqf+OFC28AQGoF/qFOwAR5uhhCNJT7+lgemRcqvMRVotyt5gYyiXeC5ne02wEelhfY1bsmabL1L6r76CAK63590HbkYSjViLr/37kgV882
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9281

On Sat, Sep 26, 2026 at 02:21:35AM +0530, Praveen Talari wrote:
> Add tracepoint support to the Qualcomm GPI DMA engine driver, giving
> structured runtime visibility into GPI DMA behavior without requiring
> invasive debug patches.
>
> The events cover channel/event command dispatch, IRQ type handling,
> channel/event control state transitions, error IRQ status, completion
> event processing (including the no-pending-descriptor and transfer
> result paths), per-event processing in the event ring, ring
> allocation/programming details, already-in-state checks for
> pause/resume, and TRE queuing and contents.
>
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/qcom/gpi.c       |  11 ++
>  drivers/dma/qcom/gpi_trace.h | 317 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 328 insertions(+)
>
> diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
> index c41bfac65ddf..fafe6ac848d9 100644
> --- a/drivers/dma/qcom/gpi.c
> +++ b/drivers/dma/qcom/gpi.c
> @@ -17,6 +17,9 @@
>  #include "../dmaengine.h"
>  #include "../virt-dma.h"
>
> +#define CREATE_TRACE_POINTS
> +#include "gpi_trace.h"
> +
>  #define TRE_TYPE_DMA		0x10
>  #define TRE_TYPE_IMMEDIATE_DMA	0x11
>  #define TRE_TYPE_GO		0x20
> @@ -683,6 +686,7 @@ static int gpi_send_cmd(struct gpii *gpii, struct gchan *gchan,
>
>  	dev_dbg(gpii->gpi_dev->dev,
>  		"sending cmd: %s:%u\n", TO_GPI_CMD_STR(gpi_cmd), chid);
> +	trace_gpi_send_cmd(gpii->gpi_dev->dev, chid, gpi_cmd, TO_GPI_CMD_STR(gpi_cmd));
>
>  	/* send opcode and wait for completion */
>  	reinit_completion(&gpii->cmd_completion);
> @@ -773,6 +777,7 @@ static void gpi_process_ch_ctrl_irq(struct gpii *gpii)
>  		if (gpii->gpi_cmd == GPI_CH_CMD_DE_ALLOC)
>  			state = DEFAULT_CH_STATE;
>  		gchan->ch_state = state;
> +		trace_gpi_ch_ctrl_irq(gpii->gpi_dev->dev, chid, gchan->ch_state);
>
>  		/*
>  		 * Triggering complete all if ch_state is not a stop in process.
> @@ -841,6 +846,7 @@ static irqreturn_t gpi_handle_irq(int irq, void *data)
>
>  	offset = GPII_n_CNTXT_TYPE_IRQ_OFFS(gpii->gpii_id);
>  	type = gpi_read_reg(gpii, gpii->regs + offset);
> +	trace_gpi_irq_status(gpii->gpi_dev->dev, gpii_id, type);
>
>  	do {
>  		/* global gpii error */
> @@ -968,6 +974,8 @@ static void gpi_process_imed_data_event(struct gchan *gchan,
>  	smp_wmb();
>
>  	chid = imed_event->chid;
> +	trace_gpi_ev_process(gpii->gpi_dev->dev, chid, IMMEDIATE_DATA_EV_TYPE,
> +			     imed_event->code, imed_event->status, imed_event->length);
>  	if (imed_event->code == MSM_GPI_TCE_EOT && gpii->ieob_set) {
>  		if (chid == GPI_RX_CHAN)
>  			goto gpi_free_desc;
> @@ -1043,6 +1051,8 @@ static void gpi_process_xfer_compl_event(struct gchan *gchan,
>  	smp_wmb();
>
>  	chid = compl_event->chid;
> +	trace_gpi_ev_process(gpii->gpi_dev->dev, chid, XFER_COMPLETE_EV_TYPE,
> +			     compl_event->code, compl_event->status, compl_event->length);
>  	if (compl_event->code == MSM_GPI_TCE_EOT && gpii->ieob_set) {
>  		if (chid == GPI_RX_CHAN)
>  			goto gpi_free_desc;
> @@ -1887,6 +1897,7 @@ static void gpi_issue_pending(struct dma_chan *chan)
>  	}
>
>  	gpi_desc = to_gpi_desc(vd);
> +	trace_gpi_queue_xfer(gpii->gpi_dev->dev, gchan->chid, gpi_desc->num_tre);
>  	for (i = 0; i < gpi_desc->num_tre; i++) {
>  		tre = &gpi_desc->tre[i];
>  		gpi_queue_xfer(gpii, gchan, tre, &wp);
> diff --git a/drivers/dma/qcom/gpi_trace.h b/drivers/dma/qcom/gpi_trace.h
> new file mode 100644
> index 000000000000..f16d156833b9
> --- /dev/null
> +++ b/drivers/dma/qcom/gpi_trace.h
> @@ -0,0 +1,317 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM qcom_gpi
> +
> +#if !defined(_TRACE_QCOM_GPI_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _TRACE_QCOM_GPI_H
> +
> +#include <linux/tracepoint.h>
> +
> +TRACE_EVENT(gpi_send_cmd,
> +	    TP_PROTO(struct device *dev, u32 chid, u32 cmd, const char *cmd_str),
> +	    TP_ARGS(dev, chid, cmd, cmd_str),
> +
> +	    TP_STRUCT__entry(__string(name, dev_name(dev))
> +			     __string(cmd_str, cmd_str)
> +			     __field(u32, chid)
> +			     __field(u32, cmd)
> +	    ),
> +
> +	    TP_fast_assign(__assign_str(name);
> +			   __assign_str(cmd_str);
> +			   __entry->chid = chid;
> +			   __entry->cmd = cmd;
> +	    ),
> +
> +	    TP_printk("%s: chid=%u cmd=%s(%u)",
> +		      __get_str(name), __entry->chid, __get_str(cmd_str),
> +		      __entry->cmd)
> +);
> +
> +TRACE_EVENT(gpi_irq_status,
> +	    TP_PROTO(struct device *dev, u32 gpii_id, u32 irq_type),
> +	    TP_ARGS(dev, gpii_id, irq_type),
> +
> +	    TP_STRUCT__entry(__string(name, dev_name(dev))
> +			     __field(u32, gpii_id)
> +			     __field(u32, irq_type)
> +	    ),
> +
> +	    TP_fast_assign(__assign_str(name);
> +			   __entry->gpii_id = gpii_id;
> +			   __entry->irq_type = irq_type;
> +	    ),
> +
> +	    TP_printk("%s: gpii=%u irq_type=0x%08x",
> +		      __get_str(name), __entry->gpii_id, __entry->irq_type)
> +);
> +
> +TRACE_EVENT(gpi_ch_ctrl_irq,
> +	    TP_PROTO(struct device *dev, u32 chid, u32 ch_state),
> +	    TP_ARGS(dev, chid, ch_state),
> +
> +	    TP_STRUCT__entry(__string(name, dev_name(dev))
> +			     __field(u32, chid)
> +			     __field(u32, ch_state)
> +	    ),
> +
> +	    TP_fast_assign(__assign_str(name);
> +			   __entry->chid = chid;
> +			   __entry->ch_state = ch_state;
> +	    ),
> +
> +	    TP_printk("%s: chid=%u ch_state=%u",
> +		      __get_str(name), __entry->chid, __entry->ch_state)
> +);
> +
> +TRACE_EVENT(gpi_ev_process,
> +	    TP_PROTO(struct device *dev, u32 chid, u32 ev_type, u8 code,
> +		     u16 status, u32 length),
> +	    TP_ARGS(dev, chid, ev_type, code, status, length),
> +
> +	    TP_STRUCT__entry(__string(name, dev_name(dev))
> +			     __field(u32, chid)
> +			     __field(u32, ev_type)
> +			     __field(u32, length)
> +			     __field(u16, status)
> +			     __field(u8, code)
> +	    ),
> +
> +	    TP_fast_assign(__assign_str(name);
> +			   __entry->chid = chid;
> +			   __entry->ev_type = ev_type;
> +			   __entry->code = code;
> +			   __entry->status = status;
> +			   __entry->length = length;
> +	    ),
> +
> +	    TP_printk("%s: chid=%u ev_type=0x%02x code=%u status=%u length=%u",
> +		      __get_str(name), __entry->chid, __entry->ev_type,
> +		      __entry->code, __entry->status, __entry->length)
> +);
> +
> +TRACE_EVENT(gpi_queue_xfer,
> +	    TP_PROTO(struct device *dev, u32 chid, u32 num_tre),
> +	    TP_ARGS(dev, chid, num_tre),
> +
> +	    TP_STRUCT__entry(__string(name, dev_name(dev))
> +			     __field(u32, chid)
> +			     __field(u32, num_tre)
> +	    ),
> +
> +	    TP_fast_assign(__assign_str(name);
> +			   __entry->chid = chid;
> +			   __entry->num_tre = num_tre;
> +	    ),
> +
> +	    TP_printk("%s: chid=%u num_tre=%u",
> +		      __get_str(name), __entry->chid, __entry->num_tre)
> +);
> +
> +TRACE_EVENT(gpi_gen_err_irq,
> +	    TP_PROTO(struct device *dev, u32 gpii_id, u32 irq_stts),
> +	    TP_ARGS(dev, gpii_id, irq_stts),
> +
> +	    TP_STRUCT__entry(__string(name, dev_name(dev))
> +			     __field(u32, gpii_id)
> +			     __field(u32, irq_stts)
> +	    ),
> +
> +	    TP_fast_assign(__assign_str(name);
> +			   __entry->gpii_id = gpii_id;
> +			   __entry->irq_stts = irq_stts;
> +	    ),
> +
> +	    TP_printk("%s: gpii=%u irq_stts=0x%08x",
> +		      __get_str(name), __entry->gpii_id, __entry->irq_stts)
> +);
> +
> +TRACE_EVENT(gpi_ev_ctrl_irq,
> +	    TP_PROTO(struct device *dev, u32 gpii_id, u32 ev_ch_irq, u32 ev_state),
> +	    TP_ARGS(dev, gpii_id, ev_ch_irq, ev_state),
> +
> +	    TP_STRUCT__entry(__string(name, dev_name(dev))
> +			     __field(u32, gpii_id)
> +			     __field(u32, ev_ch_irq)
> +			     __field(u32, ev_state)
> +	    ),
> +
> +	    TP_fast_assign(__assign_str(name);
> +			   __entry->gpii_id = gpii_id;
> +			   __entry->ev_ch_irq = ev_ch_irq;
> +			   __entry->ev_state = ev_state;
> +	    ),
> +
> +	    TP_printk("%s: gpii=%u ev_ch_irq=0x%08x ev_state=%u",
> +		      __get_str(name), __entry->gpii_id, __entry->ev_ch_irq,
> +		      __entry->ev_state)
> +);
> +
> +TRACE_EVENT(gpi_ev_no_desc,
> +	    TP_PROTO(struct device *dev, u32 chid, const u32 *ev_dword,
> +		     const u32 *tre_dword),
> +	    TP_ARGS(dev, chid, ev_dword, tre_dword),
> +
> +	    TP_STRUCT__entry(__string(name, dev_name(dev))
> +			     __field(u32, chid)
> +			     __array(u32, ev_dword, 4)
> +			     __array(u32, tre_dword, 4)
> +	    ),
> +
> +	    TP_fast_assign(__assign_str(name);
> +			   __entry->chid = chid;
> +			   memcpy(__entry->ev_dword, ev_dword, sizeof(__entry->ev_dword));
> +			   memcpy(__entry->tre_dword, tre_dword, sizeof(__entry->tre_dword));
> +	    ),
> +
> +	    TP_printk("%s: chid=%u event=%08x:%08x:%08x:%08x pending_tre=%08x:%08x:%08x:%08x",
> +		      __get_str(name), __entry->chid,
> +		      __entry->ev_dword[0], __entry->ev_dword[1],
> +		      __entry->ev_dword[2], __entry->ev_dword[3],
> +		      __entry->tre_dword[0], __entry->tre_dword[1],
> +		      __entry->tre_dword[2], __entry->tre_dword[3])
> +);
> +
> +TRACE_EVENT(gpi_xfer_result,
> +	    TP_PROTO(struct device *dev, u32 chid, int result, u32 residue),
> +	    TP_ARGS(dev, chid, result, residue),
> +
> +	    TP_STRUCT__entry(__string(name, dev_name(dev))
> +			     __field(u32, chid)
> +			     __field(int, result)
> +			     __field(u32, residue)
> +	    ),
> +
> +	    TP_fast_assign(__assign_str(name);
> +			   __entry->chid = chid;
> +			   __entry->result = result;
> +			   __entry->residue = residue;
> +	    ),
> +
> +	    TP_printk("%s: chid=%u result=%d residue=%u",
> +		      __get_str(name), __entry->chid, __entry->result,
> +		      __entry->residue)
> +);
> +
> +TRACE_EVENT(gpi_process_event,
> +	    TP_PROTO(struct device *dev, u32 chid, u32 type, const u32 *dword),
> +	    TP_ARGS(dev, chid, type, dword),
> +
> +	    TP_STRUCT__entry(__string(name, dev_name(dev))
> +			     __field(u32, chid)
> +			     __field(u32, type)
> +			     __array(u32, dword, 4)
> +	    ),
> +
> +	    TP_fast_assign(__assign_str(name);
> +			   __entry->chid = chid;
> +			   __entry->type = type;
> +			   memcpy(__entry->dword, dword, sizeof(__entry->dword));
> +	    ),
> +
> +	    TP_printk("%s: chid=%u type=0x%02x %08x:%08x:%08x:%08x",
> +		      __get_str(name), __entry->chid, __entry->type,
> +		      __entry->dword[0], __entry->dword[1],
> +		      __entry->dword[2], __entry->dword[3])
> +);
> +
> +TRACE_EVENT(gpi_alloc_ring,
> +	    TP_PROTO(struct device *dev, u32 elements, u32 el_size,
> +		     u32 req_len, u64 len, size_t alloc_size),
> +	    TP_ARGS(dev, elements, el_size, req_len, len, alloc_size),
> +
> +	    TP_STRUCT__entry(__field(u64, len)
> +			     __field(size_t, alloc_size)
> +			     __string(name, dev_name(dev))
> +			     __field(u32, elements)
> +			     __field(u32, el_size)
> +			     __field(u32, req_len)
> +	    ),
> +
> +	    TP_fast_assign(__assign_str(name);
> +			   __entry->elements = elements;
> +			   __entry->el_size = el_size;
> +			   __entry->req_len = req_len;
> +			   __entry->len = len;
> +			   __entry->alloc_size = alloc_size;
> +	    ),
> +
> +	    TP_printk("%s: elements=%u el_size=%u req_len=%u len=%llu alloc_size=%zu",
> +		      __get_str(name), __entry->elements, __entry->el_size,
> +		      __entry->req_len, __entry->len, __entry->alloc_size)
> +);
> +
> +TRACE_EVENT(gpi_ring_info,
> +	    TP_PROTO(struct device *dev, dma_addr_t dma_handle, phys_addr_t phys_addr,
> +		     u32 len, u32 el_size, u32 elements),
> +	    TP_ARGS(dev, dma_handle, phys_addr, len, el_size, elements),
> +
> +	    TP_STRUCT__entry(__field(u64, dma_handle)
> +			     __field(u64, phys_addr)
> +			     __string(name, dev_name(dev))
> +			     __field(u32, len)
> +			     __field(u32, el_size)
> +			     __field(u32, elements)
> +	    ),
> +
> +	    TP_fast_assign(__assign_str(name);
> +			   __entry->dma_handle = dma_handle;
> +			   __entry->phys_addr = phys_addr;
> +			   __entry->len = len;
> +			   __entry->el_size = el_size;
> +			   __entry->elements = elements;
> +	    ),
> +
> +	    TP_printk("%s: dma_handle=%llx phys_addr=%llx len=%u el_size=%u elements=%u",
> +		      __get_str(name), __entry->dma_handle, __entry->phys_addr,
> +		      __entry->len, __entry->el_size, __entry->elements)
> +);
> +
> +TRACE_EVENT(gpi_already_state,
> +	    TP_PROTO(struct device *dev, u32 gpii_id, u32 pm_state),
> +	    TP_ARGS(dev, gpii_id, pm_state),
> +
> +	    TP_STRUCT__entry(__string(name, dev_name(dev))
> +			     __field(u32, gpii_id)
> +			     __field(u32, pm_state)
> +	    ),
> +
> +	    TP_fast_assign(__assign_str(name);
> +			   __entry->gpii_id = gpii_id;
> +			   __entry->pm_state = pm_state;
> +	    ),
> +
> +	    TP_printk("%s: gpii=%u already in pm_state=%u",
> +		      __get_str(name), __entry->gpii_id, __entry->pm_state)
> +);
> +
> +TRACE_EVENT(gpi_tre,
> +	    TP_PROTO(struct device *dev, u32 chid, u32 idx, const u32 *dword),
> +	    TP_ARGS(dev, chid, idx, dword),
> +
> +	    TP_STRUCT__entry(__string(name, dev_name(dev))
> +			     __field(u32, chid)
> +			     __field(u32, idx)
> +			     __array(u32, dword, 4)
> +	    ),
> +
> +	    TP_fast_assign(__assign_str(name);
> +			   __entry->chid = chid;
> +			   __entry->idx = idx;
> +			   memcpy(__entry->dword, dword, sizeof(__entry->dword));
> +	    ),
> +
> +	    TP_printk("%s: chid=%u tre[%u]=%08x:%08x:%08x:%08x",
> +		      __get_str(name), __entry->chid, __entry->idx,
> +		      __entry->dword[0], __entry->dword[1],
> +		      __entry->dword[2], __entry->dword[3])
> +);
> +
> +#endif /* _TRACE_QCOM_GPI_H */
> +
> +/* This part must be outside protection */
> +#undef TRACE_INCLUDE_PATH
> +#undef TRACE_INCLUDE_FILE
> +#define TRACE_INCLUDE_PATH ../../drivers/dma/qcom
> +#define TRACE_INCLUDE_FILE gpi_trace
> +#include <trace/define_trace.h>
>
> --
> 2.34.1
>
