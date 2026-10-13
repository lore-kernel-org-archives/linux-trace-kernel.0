Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013039.outbound.protection.outlook.com [52.101.83.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC825540AA;
	Tue, 13 Oct 2026 21:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791928095; cv=fail; b=s3R57OZl4zvgxbQri6tXk/B2gL1bAf5kFlL/+AiXwCoHUib1iazJV+zoVJbG0nOXtYIAMVANRQLoDoPSreJCHeFC45uhUONeTiwkd0KY7W4D+j/u5wp8yZhtM8S3HhmEPiqvfooBthbmNtQHXalH4turce3xHrgpE/EVGBLO6Jk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791928095; c=relaxed/simple;
	bh=9nsN8Xd4p+gJK2vOhb54hBWA6qVGKfXxIo6DOUjdIMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=u/u1lklsOu7+wbQpsPADmimnljp590Kw38WNFBtmBd5MIzYMEWxmvchx2EH9ngXJpRJGHtiM4h66fX6/4cIlo2ArDWkAN3nWgVe+b8gk1j2wp57PsBXoqLY158Xtbdzqpt/UnMQvT6oJB7qhTkxUo87S4UJaISydNKlY82MXPRA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=fail (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=hjtLhIeW reason="signature verification failed"; arc=fail smtp.client-ip=52.101.83.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="hjtLhIeW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hgtXSr9ZKvV3CxHN2aKXuDe/1naLOeLBVLQnDZDNkxqurjs/Q6F5vvp1tzrLHjujsiH6UyJbMIpUjW3KRxKnhQjjmv7hRalaVtUkYVdipR8oVBVuVExGgL+oxcUd2ttJIs1KS3V5+aoC98w0AHSl7JwcnbRXOKf30kHZBhS9vmLgf5dKEO9iMgnpII2qtIA8AeKfpnjSD5x/rMohDPpWpwoWyBlua4HRSG43oaNy/WBb+muRTWLWEMHJYi14T1QkEfI0z1KRiWgIn7B3YRjEOGjU/HbpGyOGdv9UPBlgibFm5WI0LgO9SMvibJ3bW7PUMR/ja6LE90Dkawui4o5JAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CqykZOwF5njgh5x6BuYV2Odw4efhFGX7hpUnMmqN1dQ=;
 b=t47hsGrvtRcGilX0rmMjgw87GV9S1Uzyjs3R7Ci+WeeZIqe+a849S5k4oR0OC2WK2lUnoAgn7mHSa02BgG7+g7Hh1yFD4mM964sl0i5KmAJdQyCknThyr7nIfl4rcOl2HDITLsNsZ4t53liplX02cNwagCFNSthcnHQKSjqcneUF+KaxFeOWv7GSbbipo5eE6F8LzUL9y4g6xG8JNOsFvunSvDMMsy630bNF82k37eNoVsgMsF+pv5NukNEXhVW2RRfzoJfHfMRVRX2KFdxlLJs0TLg+li2SgrJnI/d5FvhkABE6/JuEGZtmAyC8mx096DnYVotNl17ysihbcbxI2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CqykZOwF5njgh5x6BuYV2Odw4efhFGX7hpUnMmqN1dQ=;
 b=hjtLhIeW8aFL2JgeyeP5eZ2VyFivL4q76hVHxVTp68iKD8yJE1vLB5aJ1ekXs0f19CAZW8PLEbYQf5Ko6gFc8bFfTjyutVS+s90nDRlBX9l8YRkN4k5sSXpNNcgA3qOZwUGGHJo7IoZcyvZanw0d/Xaa0P53luq/FVcQsdnzPEMFrsNiHkxa2W7hdXBf8aAPfHfKpSlCmb18l9kI7UzXGNbmB4pPvJKkTxOhtYI4JwLDR2V5ze++d3kT6+TJ8j6oOOApz6UfGVIVrUOxtDuWcvfR8wSRw/oFVpvZcphDMifJpP2G9fKXMpKHGJPTw+j3DktnV4/5ftwBIBw5LdRn1Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by VI0PR04MB11818.eurprd04.prod.outlook.com (2603:10a6:800:2ee::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 21:48:09 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0522.011; Tue, 13 Oct 2026
 21:48:09 +0000
Date: Tue, 13 Oct 2026 17:48:02 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: sashiko-reviews@lists.linux.dev
Cc: Praveen Talari <praveen.talari@oss.qualcomm.com>,
	dmaengine@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	vkoul@kernel.org, Frank.Li@kernel.org
Subject: Re: [PATCH v3 2/2] dmaengine: qcom: gpi: Convert dev_dbg() calls to
 tracepoints
Message-ID: <as6nEloHzo_YkEW9@lizhi-Precision-Tower-5810>
References: <20260926-add-trace-support-gpio-v3-0-8572bf7456b2@oss.qualcomm.com>
 <20260926-add-trace-support-gpio-v3-2-8572bf7456b2@oss.qualcomm.com>
 <20260925210244.D6D5F1F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260925210244.D6D5F1F000FF@smtp.kernel.org>
X-ClientProxiedBy: CY5PR19CA0011.namprd19.prod.outlook.com
 (2603:10b6:930:15::13) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|VI0PR04MB11818:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d4d0a6a-99b8-4259-3902-08df2973ac24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|19092799006|23010399003|11063799006|56012099006|4143699003|261009223027099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	5lJG3ZZpvyNlk9+w9dcA7+DkysfBwyvRu6CDZ0pRalLX0vi4bNyzL+h580q6BHhV4w7iMmHZ+/T0FoTjuN5nreNsBDFCKSDIZCihR5Xrf/ahfTGZNNUnB83FtwnqV2q+tY6kj8mQeOp/hRFeIT55118j52YaIiFYGIg0xQmi21PLERqg85F37jBrYWqHGCmvKzVcWGgvQjhVb5klxRqWOPRJ2EcPBXizN01GRw4yReuuWLDhEhGxO7drD5sKoVLJGIK2QWyZTPAoheXcApWhpQz0flBWiOt8hWhOkdNC4Iab87zI21So7iY82ZFMza24jzQP/wVZZCOQHHXTbDYblIdNXVAc6VPlJ4ui8aXBgPu67/PjUAsEdY/irQeB9tFyLBgAGR7FiKwhxP3rmH/BSNjO8iaTfIhNu11e0/uYAXSFban3fNqyIPP6SahwhE5L74ntaSbMZv2s/ULmZUljhCa75CnCy1T/gLyJlSmNqQeq+N2u5CtNB6teD2v9WlfQG3+CdPWUtg2L0LxjN3Q12hYFoGOyNQ3Jx17hhfAE5WN8ivLmpMM0F1M/gE3tDDf/jjoN3BlI086B5UHXXUJNVUtgY45oqf4WgKKFJ5k3y4I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(19092799006)(23010399003)(11063799006)(56012099006)(4143699003)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?65K0nsTaM6VfPQJkfLhjfGSHmD08PseScJHZGSnwyE5zv+Gi+GPbj/A+57?=
 =?iso-8859-1?Q?MJWIPj11yYwal342LeTd/2Ep+QxFNSRm2gO/yNqDaMhmQ5qRctRtCUvZ6h?=
 =?iso-8859-1?Q?zosMUpF53oO0SZtRAgEAwWwVIddbbajeBY6vsMiPXrLT7wtOEczFxfVuxO?=
 =?iso-8859-1?Q?KqjR2NA2JE9TzIQXunkwZ2ec7rqEzV3st5QrWjQ/75FCgaf8hbxwZbuvPe?=
 =?iso-8859-1?Q?aum09t/7oC+wCPMJm1V1NLx01EQVckyIVUPrynHfvQasVbrBR85v7D2Zi7?=
 =?iso-8859-1?Q?P9aHxtZCeiJ9V1GrE/qUycNXZ5Y29ww0W+HAUr6kkcXVQt9dFn4HiKMYfA?=
 =?iso-8859-1?Q?jnhaI3KP+Btb9Poz/19FEB8mWXkicF90yrdSo/O3XNudC4uw+9dBV4gxNw?=
 =?iso-8859-1?Q?SDITGkLU3iCsnSgkfYhVcZJ+07VZsx8zugYomsImEr9KWw5k3a0sC8DSq7?=
 =?iso-8859-1?Q?lHCXQ8hHsSkB0kzb5snM6ZQq0ffaic/qgJGihVSSX+fqqzgf+oS35dVt6N?=
 =?iso-8859-1?Q?29oShkQJtuv+87gm5cFr9yq9Gdc0JOqFpJwm5sFBbF+7nKVDG+E43PCQyp?=
 =?iso-8859-1?Q?yslvwk4xWf884AuqjpJL65bX+RW4KRsWZYm40tmBuyoJxKrwK+MQjvFNTp?=
 =?iso-8859-1?Q?FdVlZb8f8SdUkQdnmZKZK5jUbn4KZvJTjc0FxSeWtMC38seuCAyPCRJD3Z?=
 =?iso-8859-1?Q?G+FAw+LEatFE14bVJO3B0me77wL8RjB56TAcsAtlsQNMVaEekTWGIXYT4U?=
 =?iso-8859-1?Q?qz6zAHXi5g2kVjPlw6y/u/E6dSewfWCuAJRrznJxQq6gZiHURqjJQXLWV0?=
 =?iso-8859-1?Q?PsC+jTiW08vPBbbqSgVMSsaYv1uWuJnZzjB+cYtyT/Iyg8jT23zrMWG8M/?=
 =?iso-8859-1?Q?C5HsPOGrPUeVgLpcG43zTr6Jo9uLbOwAj6Ehc30r0ordUBZnzyUx06Bdq2?=
 =?iso-8859-1?Q?xsfGSd4KrAppkIdGARvu8aISBUGxU7/glMfeTgYACAV6Ug7bW4BmLXhw8t?=
 =?iso-8859-1?Q?RQqOQJPta8NGQm3aLL2arq1ScLifPZ3J9M2CZezoajxTgUHix740Qm12Mz?=
 =?iso-8859-1?Q?91DiSpkLz7F7p+rCJvg9YEYXy3fIYQC/IkhUZ6BYg+dqD3jkkyQLARdml3?=
 =?iso-8859-1?Q?PEm/zflkAM4hS93OM+ho2habOZsxh60hdw5NU0qRGpHfL5028Gv1w2sZ1P?=
 =?iso-8859-1?Q?F6IbBjOHWtsSIuN+MePoFAjSP45Hi7FjL2cHo8EmcE5dUziwVM9vZURDQJ?=
 =?iso-8859-1?Q?kLFoaT2I7UnPJWOybMPVN8wWbOFGMVSemBxhxViLVL6UqNIlLLtFUbpUkB?=
 =?iso-8859-1?Q?8hJ5zCmghqW4s5F35yfdHh3bPv5S/J/2uPt7RlZxw/7yOc5MNO9JYDllk1?=
 =?iso-8859-1?Q?Y4Iu/CAS1WFQAYta61rK5I6IpH/r5lpcqSFf7Rad985BgftBhEVtME32YT?=
 =?iso-8859-1?Q?M3SNr2PRnVptOOOjjOhXKWBe33hneo2hgSeCGByN09Swies0ExPWkDPxqE?=
 =?iso-8859-1?Q?kOwQtH/UndFHPX8U1UM/ExLC59axJQ+7klOHtsuQ0kWool/3hJ+FbwUFSW?=
 =?iso-8859-1?Q?0fW4UGzztrHt4lvVMD09/ZYuGGI3AeyARiCMAaD6FmZllSiTWnLQ4lxAfI?=
 =?iso-8859-1?Q?p42oS5iehU1AhPm1SUfY6iGaN7RLxQuyN7emzdf5kks7NmDjLQKyWaPLMO?=
 =?iso-8859-1?Q?TG5MvhwIcZSdoelq2Ry/n1MzFSUZ2fSaMXDza4eosuRsrFCO8JvpI83DAs?=
 =?iso-8859-1?Q?vx8KdUOPqAy8fHc7NuzEODhbiQ69BMw5M/kf+pV0notE9B4O7i418EAwvZ?=
 =?iso-8859-1?Q?DLjHg6pL2wUanbVZJpaG5X7ukwrGKx9IH26AbRkdnt+7GdbNo7gr?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d4d0a6a-99b8-4259-3902-08df2973ac24
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 21:48:09.7611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pdhpwQUHsgSWMtTUH491aAJqas0iTPiwmeW5f/iWMh9okJA7KFmKeDzBLrIm9JfFXFVoA3p8LfTxchIih+feb5EQwEI1wiOTL8VLvXVuz9XMadP4WHLjVNA+JmUnOlDh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11818

On Fri, Sep 25, 2026 at 09:02:44PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] dmaengine: qcom: gpi: unused variable gpi_ev_state_str causes compiler warning
> --
>
> commit 16ff3240f7873902688743d98570cd5eebf13594
> Author: Praveen Talari <praveen.talari@oss.qualcomm.com>
>
> dmaengine: qcom: gpi: Convert dev_dbg() calls to tracepoints
>
> This commit replaces dev_dbg() based debug logging in the GPI DMA driver
> with tracepoints, providing structured runtime visibility.
>
> > diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
> > index fafe6ac848d94..6aff2a0d54161 100644
> > --- a/drivers/dma/qcom/gpi.c
> > +++ b/drivers/dma/qcom/gpi.c
> [ ... ]
> > @@ -887,15 +883,14 @@ static irqreturn_t gpi_handle_irq(int irq, void *data)
> >  				ev_state = DEFAULT_EV_CH_STATE;
> >
> >  			gpii->ev_state = ev_state;
> > -			dev_dbg(gpii->gpi_dev->dev, "setting EV state to %s\n",
> > -				TO_GPI_EV_STATE_STR(gpii->ev_state));
> > +			trace_gpi_ev_ctrl_irq(gpii->gpi_dev->dev, gpii_id, ev_ch_irq,
> > +					      gpii->ev_state);
>
> [Severity: Low]
> Is it possible that this change in gpi_handle_irq() within
> drivers/dma/qcom/gpi.c leaves the gpi_ev_state_str static array and
> TO_GPI_EV_STATE_STR macro as orphaned dead code?
>
> Since trace_gpi_ev_ctrl_irq() only takes the integer value, the final
> consumer of the macro is removed. Could this regression trigger a
> -Wunused-variable compiler warning for the unreferenced static array
> when compiling the driver with standard kernel warning flags enabled?
>
> For reference, the array is defined earlier in the file as:
>
> static const char *const gpi_ev_state_str[MAX_EV_STATES] = {
> 	[EV_STATE_NOT_ALLOCATED] = "NOT ALLOCATED",
> 	[EV_STATE_ALLOCATED] = "ALLOCATED",
> };

Please Remove dead code also.

Frank

>
> #define TO_GPI_EV_STATE_STR(_state) (((_state) >= MAX_EV_STATES) ? \
> 				    "INVALID" : gpi_ev_state_str[(_state)])
>
> --
> Sashiko AI review · https://sashiko.dev/#/patchset/20260926-add-trace-support-gpio-v3-0-8572bf7456b2@oss.qualcomm.com?part=2
