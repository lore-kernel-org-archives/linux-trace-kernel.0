Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013066.outbound.protection.outlook.com [52.101.83.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFED3AEF51;
	Wed,  9 Sep 2026 20:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788987401; cv=fail; b=JvYMaRpGjbyw7wtQ+WDgsIrbxdmh/MEfthvl++4ptVGmak9qy4/oLeJMyNEvlrKspTjLwVdB/qN3IUJoutG3BwfC1qwdcNZjMtNB+NNPhqrGcMMjlpv5XZRCpfqKoIBH3jyuUxGNK6Z7YHKp68D5gQfY2Xq6vwKgfqfU+vvn24I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788987401; c=relaxed/simple;
	bh=7VFo19t2sSxO4NkGC16QmXaU8jCcgz7iLJjSD/gSGHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=blQ44+gm7G+hkRi0NPrGHfGeK5pdQMAbGtMxLuOwpJcaRHDq1wDOmkI1lzJghho5q69TolV2LRfcCAW4wxnaoJQVJUpKfWV4OfxRzS8QCMx8uG7XgAm6w1g9Sp1lbEZOJiWwliLe3vcu1BVf7b1pBlnUN4H62fOc2wj3Q7FfRuM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=kAoicNJ9; arc=fail smtp.client-ip=52.101.83.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="kAoicNJ9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l9E8UbGc6DqvvZIVcrKl4uHdXKG2czUgHF1PT2os7B+k15MO456lVLYKPkiFx1tw0B9huUYmhoINn+X46XdSGwUMMC4AmeIrUbngwtr7Xk77cigPQhCBTUH2MHePdWPkTuTz5JgGY2JAi19zknU8NbQ98NAmtNoIKxWn2K64u5C4OjGwKLJF6D2aWcV+cldEqO9mtHjQZyIkggzypGVXrAJ13FzkYLdqQCMkdGYmyg/kEHEeGVSTCjNL49nr8To1dwz2ETOkqXWHp7Z4EG4QYw60B0rKuEBlARs+uibIezh9zjK3rpV7Yi9ZprRxDLDCb7KlcV+YorSI+i8VQUanGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HdDXD0FOfX6jCxzNm7lS3zUVyX7SYnpd6QltbboOJsM=;
 b=l8WGvib/jSfLJ0EbTsMbZZzQ8zBkIFPnM7HrMlbDtJ+G46V3huaAMyDYmNuJiU6+Ii4a7tb+7pK5ktmQ9kiKyEO0KAw32hVO2EeenAe2NS+xxwFYWts4k25AZxfqI3mXbuyJQe7hQaifWDyi1C27+jVT3fAJsMVkbrfimN7Csbzr82qQPBgtQ3E6NOBW1FytjWTJUYaFhSIaM12xmQekF1Vm5EF3lEWCwSdXF5vkH1uddrUd2L4J9xR7Ar+YMXTMb/BgAMqaWMQbrJjU5Uyse4QeDOA72L0ERPB68L6ZYOyITkBGKQc9+pysbpXLHqsn5x66AdLQ/IB8idmnIYAOCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HdDXD0FOfX6jCxzNm7lS3zUVyX7SYnpd6QltbboOJsM=;
 b=kAoicNJ9n4A7QBvK7k72QpbH/WyToM8P+Ljy8IyDZKbl4gfqmcAl32IEaJSRG+B2umoMpKsu8MgxRWCmnYTXzS9ymZS6tskTzCPMSOozFNgS5iubjO4Xte9d7vzpXlhqkmvX7aeupdYruWxWVFR2S2wLADl5HPWgS2rTwEiuTRQ/0yBl98xWw6vuR/vjud/kpvESW5aZyDG1BKuxQfGwdxaiF5l1f0A0Sz9YBMwKLcL2K0S6a0StAJRQboMGIM7bBlnIeyz+y8XizsNzVH3QLX2syTJTMv5HEHexERw4RuazmHKmWA09/sOQ2vsS7hI6An7m2heGXPJZvIWZfm+BUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DB9PR04MB8495.eurprd04.prod.outlook.com (2603:10a6:10:2c7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Wed, 9 Sep 2026
 20:56:29 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 20:56:28 +0000
Date: Wed, 9 Sep 2026 15:56:18 -0500
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
Subject: Re: [PATCH v2 1/3] dmaengine: qcom: gpi: trace: Add trace events
 header for Qualcomm GPI DMA
Message-ID: <aqHH8rliEDTmrW9P@SMW015318>
References: <20260909-add-trace-support-gpio-v2-0-01f81739bb88@oss.qualcomm.com>
 <20260909-add-trace-support-gpio-v2-1-01f81739bb88@oss.qualcomm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909-add-trace-support-gpio-v2-1-01f81739bb88@oss.qualcomm.com>
X-ClientProxiedBy: CYXPR03CA0017.namprd03.prod.outlook.com
 (2603:10b6:930:d0::15) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DB9PR04MB8495:EE_
X-MS-Office365-Filtering-Correlation-Id: 8877068d-e995-4ade-9a75-08df0eb4d1b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|19092799006|376014|7416014|366016|10067099003|18002099003|22082099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	rZvvIzBgYjS0xtNJRSVBwbKYUfszr5OQ+7OsrPFbU2zoOiLbtnY20lyD4ZDAvUasJd3rAljZ+CGapalh+wO3vGFmEidSlNGzAPi0JKhTfGMFGoUZW9KWguax+Y6RRnzn4fqNOBTU/IVBRHgj+54wDhZn41+Exuda1sDfNK2tjprbJ8hYduL09URe91dFqrsZfRJBoewcHJKXjOnFRnyVDVdBrzHBOCS9ZUuTYyWs/3fb/H7Ne5w1e4b0zbFaDx1GFG5p+qRHXW9Fjaek2kpKVMvFSxOzPvjx0G3S00qCZhWhsX+pSwFhXwvStYpZWHvZLOxaM1veyCBXg2YSuoE5OqeqA7AXrLbwzf6+EQGU/ny+I3x0bRbLSoEsYQFqQrJxZNXU5HdDbs8LI7p/K6/G4876A2+URH98KCJpv1Bh2yYtmj+VmROQ4lCM9qFnOhZ+QnFoA5p4I3oGzi/rX/Wl+QVC0d5sm0qHrJJFpL1zriEOpCkIt5si3zSDdIpxJc+/ZngZ9JRwnxjvgFBvxgoY1cW9WNlKMgzPMjWPb6bIqBCTy0CR50M04j1WwNk4gbqRHjL+AWm25UNWq/8rkmA8qvgtms/JOkd0f0xSvKsrslSqi6LNmMGTsFlPPVG/VpbBJin1901IZyNT3TxKNPt9EKKWQlYHVOd97BqtzwF0XU0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(19092799006)(376014)(7416014)(366016)(10067099003)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CG2lSB7zHzKKhGdGXflka6K8sErbpixZqGBCuQKmMcQGU87+noj6os5rpa3M?=
 =?us-ascii?Q?SSfvp74jdmK5sh+9Ql/cu4yrLmyA2XO7tBqBkEUVc810zllYumiO6FVuld10?=
 =?us-ascii?Q?7Ir2cdrLFABxETQNrMLaEFpqc0yPjfD1dwzrSnlc9rWL6pN2NeLykZQfPBDP?=
 =?us-ascii?Q?68bkzzzqzUwCEZS/vCH26QG1BFEobeHV/5rCtiXs5+RQ64wM6YpFa/yGnR/y?=
 =?us-ascii?Q?qtCzcyHjn8ImCXsWUzCBS3RH80qXP8pYpxQXto91AQtdMtH0y3s6uctuhzAC?=
 =?us-ascii?Q?DkpohJ1Fxp8DjAHQVZGusIHRrmsR3k4ZoyNHRKeayrRNegM0/py5AdjF/koj?=
 =?us-ascii?Q?AWyfNMi/OCa58xx1ab3m9Lj2CYFxLPe3qVPn8hcAwCvbwLOu6D7NdP1a/gLQ?=
 =?us-ascii?Q?CRrLInG/D3mhX1WOUTauCvx+NYtFiHjdC0fsiB+EaX7gYm7sQnJ5Ftxocm04?=
 =?us-ascii?Q?vyVmxT6f9rzANAlB2owVLP7bTowcrebfQ/oABZX7IErOrrYDmvEZHxTjG3K1?=
 =?us-ascii?Q?8Af3Gpm+4GF90uxfeHZOljMeWhB3w9lSq4cbuAV+Dp/5m4shcC5GcUyMVYoq?=
 =?us-ascii?Q?mXKaJwT74IqEr6vii37VWhyRsCjhfNQYieORKbBvjlyeVXjXwvNKJvcAFhUe?=
 =?us-ascii?Q?ECVc/6ksiRKXMeUNCE4WjXm082ySX8sSfffeKAq9onhQGflzy8wOl7RGdIoP?=
 =?us-ascii?Q?sCnXwvB+yIm1eq4C5SfhpiSE1jPpoguf4EpxI62D3d1jPgZ0B9s3XERyTBxp?=
 =?us-ascii?Q?JPrk8Iqgbyyj2ekLm2tt/72LgwMBeCTwaZzdykzvTBsNn3a4U1+4+zZ3Rllc?=
 =?us-ascii?Q?4qJeJ+PrXZyAM3+3jazNI2VW0SF6njMlyYyBIFPfS7jrykNyKdj/X98e9dvj?=
 =?us-ascii?Q?Smd+zYjn8wavgx1g3jrUDNIR8DV/svNii1dKAvRNwhjf7sSlhl7YUSU5LU2I?=
 =?us-ascii?Q?THWINXw0g7otp49VISHWg92j7zlK68J9hCb+5dTYsFO2ElVmoja2Ga28NDh2?=
 =?us-ascii?Q?lqHKkz9B8mXWkdDDo9DMctBHbD/v1Gun9EMubT18Urh8SOciUjID50dEkTTo?=
 =?us-ascii?Q?JWjbXIMi22MMHtZdCrEjFlt4N38fkVZ2iFW1p6qpkJgb10eQ+AHFxi641pX0?=
 =?us-ascii?Q?ulkHirn9h5WozHG00NDkoyAEINACTiTwLOgEru9rFrlxhlMyuY95+SqRroYi?=
 =?us-ascii?Q?nw0aY8nC3Q4+7gRPy8SsKnbvo5gOKvcMBRnMRSJFCbRACIEDs9+LXy0Ee6pf?=
 =?us-ascii?Q?vw7eMeciX+cduoE89WACDQCs4eQTNGyLrKZGvLiijbQBEQLx81sOsNXlTU3o?=
 =?us-ascii?Q?TmCHIA1sDthqH/c67r3jGsmn97hCHOmFR1sTc5Gy9+NRF5324Fa+KtsVSS1z?=
 =?us-ascii?Q?JMb5GQ2Mmg+4qtVvJIjL1cxumRutmBRRnZFfhQvZsLNpaS9WugTHMPYLMWk4?=
 =?us-ascii?Q?kB83oqdyJ/EEjvgPv2l80KGZ2F5nsV8bYlCvBlHLPMzRLhOlEfj5MxpCalKu?=
 =?us-ascii?Q?GhecwDtDYDydjcy3dEDRGkztP85XnklUfssL9IxViV43s858ZOFJMQUj9nFV?=
 =?us-ascii?Q?wnfAGhipXJbOCcBAZnnkLkgc/osZXU4bt5b/O2FLGn2j82WhRIQffumay5fY?=
 =?us-ascii?Q?9TgXw9ZVlXyilO7OtPAKayMb0Ygxg0LKMcWzhjOvzK/ksgKxwyJsj24ewE6a?=
 =?us-ascii?Q?tCpNsAFjDhFagAhZVTff3QzhrhnZKLUrC7j/VE/SzWJsgB4O9tWDeNPXSPt8?=
 =?us-ascii?Q?vHICLZ892SdVjJL5b1jWyJ4xGfSRiYH2tnYrvh2wYLlx0QvI54s7?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8877068d-e995-4ade-9a75-08df0eb4d1b2
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 20:56:28.8332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cMHJdkh1HDtIOVk3/la5nFrgfWUF9EH3f+KOPbFKBuZC1cedoRaBpMm/QAgXA4weZvK77PJ+SRpRoHCQc2WeE7SBGXswo7tcD8gN+qlYDjqKsa3DK/NcDtOJaaWhDjJv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8495

On Wed, Sep 09, 2026 at 10:39:41AM +0530, Praveen Talari wrote:
> Add a tracepoint header for the Qualcomm GPI DMA engine driver.
>
> The events defined here cover channel/event command dispatch, IRQ
> type handling, channel/event control state transitions, error IRQ
> status, completion event processing (including the no-pending-
> descriptor and transfer result paths), per-event processing in the
> event ring, ring allocation/programming details, already-in-state
> checks for pause/resume, and TRE queuing and contents. Together they
> give full runtime visibility into GPI DMA behavior in place of the
> driver's former dev_dbg() based debug logging.
>
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> ---
>  include/trace/events/qcom_gpi.h | 313 ++++++++++++++++++++++++++++++++++++++++

Any user use it outside drivers/dma? if no, move it in drivers/dma

and please squash to patch 2, with user together.

Frank

>  1 file changed, 313 insertions(+)
>
> diff --git a/include/trace/events/qcom_gpi.h b/include/trace/events/qcom_gpi.h
> new file mode 100644
> index 000000000000..241d76855ac8
> --- /dev/null
> +++ b/include/trace/events/qcom_gpi.h
> @@ -0,0 +1,313 @@
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
> +#include <trace/define_trace.h>
>
> --
> 2.34.1
>
