Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011003.outbound.protection.outlook.com [52.101.65.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287CC36923B;
	Mon, 21 Sep 2026 06:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789972024; cv=fail; b=VAW3p8rtb7ZhlsByru0xLv3BR5OEx3BvWl9+vvqa+GQNBgg58esJuSbWikVu+3GWnM6FglM69ljxLZGQg41aqS3PXcg9ToxYVB+wWNZwfIThjJKyQ7QSf7jTV2c4mS2BxIwrBv+invgA6gbIaFfZ/bQ/pdSGCUW5zlJR7zaVrnY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789972024; c=relaxed/simple;
	bh=3HAlrxZlHLS9gMBvR/6ItTwT3M62ErS5kXm1DyLcfpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LPFDdZ1Hbx5D9Dq5b9dZN7cRSnDSIAaw9byY63WUoHRmVIj2UH1/hNX6+re/3olcEYQnu0EqyMLGO7izyF8HIm4BsOzytWi8IcC8E8px6RPB+HoZUoDa9GK3pAYD5r1TUIPxrgqd0xaT3fdZ5yU6ntugUwftxaunFbErXuQkXNU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=SriwEl7a; arc=fail smtp.client-ip=52.101.65.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="SriwEl7a"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UOsKpckUaH24I8pVRiZdom4pQsjd38vms4SxXIx6HHofPGv6mVnEBwCEC+OtAHT/aTm33hGHdG0oxfdwrhBCSgEdZNBZg2uU/oV/cSVYPMD/e36RRfc51BJqY3QT3FVf90Ny1YN2oNkvqpy1Je/uj722IAsWboFKOCUtmH1djWd3qp1CoFQynAfpxggvFaiyVyZs1XJ8LDeguWqkizNP8BmMySATuZ6CvbdJOsTyQ5QJxvhibM1tvOtR1UJRL5UeiJrRh2kfwSkQsNgQoNi1IgOGFKb+Vs0m0UHlUqbDrS9oNREXoQWTbdDvdNRDd+CH1l3ykCYZcNIpGLS9NLUNaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=owXzFieGEVt5/28SPjULIEVkoCD/9lxhP5oiOADZvvU=;
 b=qIE82VdfxsgP3sdMUABQdtIQ7aE7RlxAiq7aMzQsjEtDN7VUcVP9tH8R61pPJBsQvLR4i1n9YpyLcmmb+X0ruZriv0hR6XGGmuen/8B67MgRN5GCm4xb5HOvi3gR2EzrshqKIjdCu+P11DPZcTrv8pq1dL7MQ6NRu9W79ZxANsyapRBOW3h+OuBuOJNxsAR4rcRO/0xM7xa8g5wWV5Vb49s97HElds9gzzSIHsGuE/PV1A49E9qBRbAy7+vvyEHjSouUDF7CgE95ZNJ/iYpIcx59W4V7nlYgvjrnZOZdWXSptF+i4peq5imDGCaSBgLW2EB+f4aFS+6OViuPdI/miA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=owXzFieGEVt5/28SPjULIEVkoCD/9lxhP5oiOADZvvU=;
 b=SriwEl7aMOtWqWezJPH3HB008t2l2vitnBDWuM7C5S/oBxZnapYcZKx94NtvMOnJuoNsn2TkYdSiN5TaT8gAL8I2KNkvfQS+i6CJD3LucAHaNh42/Du8HVXEAmTEK3q2ht5ldOM6S+FUniH0cM0XNwZR0wMCMw9qhO2aTJvZq0W8IedhBdxqUX7hgj/piJPSG9HFdCnq7u7Fp2cg+MXIm9ytl07Y37bYZN1ehHLwm3+8Sef0kX/rNfVh6pJeBkoJ/PX0F4mZKWaLCUmhd/Pn0In6tHGb7ZpZQI0Wcr4r5GX20++zXIfTRmut7Xf4U5uanrPrfl38kLjKLl6/HZ0jJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by AM9PR04MB7585.eurprd04.prod.outlook.com (2603:10a6:20b:280::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 06:27:00 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 06:27:00 +0000
Date: Mon, 21 Sep 2026 14:31:19 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: use assign_bit() where applicable
Message-ID: <arDPNx/dR0ppjSEK@shlinux89>
References: <20260920022810.3145921-1-peng.fan@oss.nxp.com>
 <20260920072151.40637efd@fedora>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260920072151.40637efd@fedora>
X-ClientProxiedBy: MA5P287CA0335.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:222::10) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|AM9PR04MB7585:EE_
X-MS-Office365-Filtering-Correlation-Id: 47beeb69-6778-4f6c-1acd-08df17a957f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|19092799006|366016|1800799024|6133799003|22082099003|18002099003|56012099006|11063799006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
	20hduWDJKoxUvQPgM4eBFLQYDHMP+zrdzRleo6zXC/zGtt3oX44RN/SBesdvEmUwRGcZ6uotJysY5YFC10p/u7FLHb/IFhxXh/TeIIZM07xZOAOreVksta9WhH65jP12yHQJobuEHjz6TcHovvgJOX/MAjOyaBtE2VG0O0JKhVNZfWqsgpeV0k0sWK8QAUSspvq2cjsA7d22qQdfJmv9vz3zwmxiymPCvTSw2Ij2FeQpFhfCkhwd0tz1qCUDuPKMyZfTaIjb0kDc3sJJKdtghiJ7XhXw6Fp4yAdXLIwWRY3AMkYsYoLRpM0eGJF4bfTO2WrDBzfjjMzKg2mv72hFEQXzpTBqEZywkek9Vy35+loM7fHmr4kT8x4j8UYiuJsvsXyn4P6IEmVjZyD/UyJhDjPD4khJioV/v6UOWEB5ENupj1UPB/BqVCUrxc8TJg7vg3hfiaeEjn0e6+2t7780QbYnCGfXvaVpepEuflLGqsWkfo3Fkw0AkaZa+U8gs91Db5OMIDGEJrL9bNXDxmmfoG5hugMFnzo9s0twGVlVCSGPYLpoH9+aesXka4dxn4juZC2QH5faJwZBDCB5v5RoaCuHY4SeAKa8U+LpW0u6SJtlherFuCmKQtARwf8EpD2iPfsR+ujK1Vzp8lLspEMgwQSNwf6Apm0QGDG4xEEnt0M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(19092799006)(366016)(1800799024)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jc9SBqH9KuowAjviJXKysmb+4xh1/lvCNFeJNYD5ixr7UY4W+vAOVqynYDzO?=
 =?us-ascii?Q?2uP99xQBpM01yGLKK7lnxdG9qSDAjt6dvkacyu+Obq2p1zPs6w1ied4ZhgLz?=
 =?us-ascii?Q?S8o7J798DBu6SmNc8lAsB5Q7oko9bgtdLJyX3F3ImA6PVj3rYAOK2asJK1FU?=
 =?us-ascii?Q?U83idhP9sChGD6S6GQMphPmZbA0mPq1Yo3IcjGSonSnb6T2oFZ4Y/OTh0tCm?=
 =?us-ascii?Q?GrX2SVXu5oN2lb3tUt19VroIU2kLq7u9erNdG1qAxcrETlGbDEWCm2u4heEE?=
 =?us-ascii?Q?DncmQYT+3hARPdKhZX4rsDaXOTJOqarZ7KwKKL4xdzlSPzJxk6IF2fy5ZD8Y?=
 =?us-ascii?Q?Qe7i1dzXrIgkDyX1OB4UYjU7N1nTHGc0ElyF2O3ASosiIm8JDYCPp1GA3+H4?=
 =?us-ascii?Q?hr99ht0+Reij2yRZAfCHKlqFeU5Wu4lAu9UwC9nukWmVnUP8SmGFPpnGkkf/?=
 =?us-ascii?Q?8w3im88AVEfs3PRv9v4p4If+vkG1wAgCfdEAL5T64i+broPOBHuXFY5oH6yl?=
 =?us-ascii?Q?lMCBUHBRpAod7JgnDH+XFw19D4j14xEIrD1lMo8pQ9AEV6q43HRThNR5IvFj?=
 =?us-ascii?Q?xHDXwpwxyoXFyke+yRXkYd1v6IyMSEKA0FSMbm6U6rTCHEYTKvVNjYPMGflo?=
 =?us-ascii?Q?fjYUig4abqoPJEuV0t+s4YzzdPKShpPjFCzjpZXEEntNWVW6y9E6I2WKzDRZ?=
 =?us-ascii?Q?w/V/c2BdDUsE0yLM6Yz6I2qom0tO4sVZXOrdjskjU7/I4yFegoo0/OEELmbB?=
 =?us-ascii?Q?dYDVmKpHf0WGwfc4eLl6CImasaeJ9oGJ9BO9QwhK5Y6vXmmeirIHD6mHFotU?=
 =?us-ascii?Q?UqZ8J2sx0OCqvt2XphiJX7u6Xrmd3iWwX9QwtRf6WIMWFAb+ieH9fgM1SHT3?=
 =?us-ascii?Q?zK+qLVEHlEGepqVb5Zbhi5B88E8n5gv2fdUA1ESAQvnZdL+Kbx1NfGvao5ER?=
 =?us-ascii?Q?zIFfk97ZCTx+P3fYqiNi+iZ995TYUqvdI2JYuDSEamVXciIIWNRMgRRyjdF+?=
 =?us-ascii?Q?bEy4znyapdOQS7P3k2udtczWSB6EWI8nmtA+DAK60bTB0UnRQq6nhyhIaP9j?=
 =?us-ascii?Q?DI+kUQC+m48r3EmjE1voP1UUPN10R92iq4vEwhyEifchOtho9nBakW1ume3u?=
 =?us-ascii?Q?UQ1TDZBJaOzYARTzzuqNEUCrOuKlZpF3l4B1yQtyvMugLB62EZyQsg+oxgd4?=
 =?us-ascii?Q?fvywladItcAA7NiG54ezSVVQ7WXlr1CSbuFlhgrcgrvPExJM97oOZXACJeeR?=
 =?us-ascii?Q?9m9vHqxaJhL8x02S2UR3qKwMp/vQAIjGvMJWovXScy+AkgbBzrd9pUlxx4Pj?=
 =?us-ascii?Q?xril4gutG5/YKVzez9yp8pYR30qkkaexcqoFoCbGtYE/Z0Ahhi9zxxGPpVpK?=
 =?us-ascii?Q?G6jV3+LgB35goisMqTs64TGvIOYDf1/ErTEdETRP12uBMqVt2jxzmnmj1Gst?=
 =?us-ascii?Q?hwqxE7tCtkz0XxtV3qLGaR0Lxa+ZkChn7zEr0ujpZ+1uGFcQ9BhW2a2Ro1xg?=
 =?us-ascii?Q?cs5DVzWE5ptfuHsWx1AfC/SUPEUuYcJPnpvk/weOA+vscLQVSTjEXz9JJnmb?=
 =?us-ascii?Q?wjG/1/YfonNSQaTVufXeXHp0oUHd3TpmovzYujGXGNfxC8l9Fs/O2Q0w7AF5?=
 =?us-ascii?Q?Kww97C3JpL3CeyBykqy94xqTr+lcbWXVrI3G0vuPbNMiZvD6bkqrADLhuAGs?=
 =?us-ascii?Q?XPOkTBcdhYswXoX+SDWo4/Yt4SBgPNuqIjiAPj0GbG+LbhtwThjZ6mhSiWUo?=
 =?us-ascii?Q?ZoYE2cQ6NB20QO++2dypxYYHj6dQ8GIS2VPCxPHv43xl7jMPcuAN?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47beeb69-6778-4f6c-1acd-08df17a957f3
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 06:27:00.3836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CGhVlohN/kKwAQWzyo+1aTLNtlrb1oJDKyNJeKgQdw88DANfOoo82bdKaXgC8oShX1O0vn1UE1udhrxSGKuJbZpMmWccPevl0bRw8AqfP6esFSOOcaSzV9fH5t1f+tz9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7585

On Sun, Sep 20, 2026 at 07:21:51AM -0400, Steven Rostedt wrote:
>On Sun, 20 Sep 2026 10:28:10 +0800
>"Peng Fan (OSS)" <peng.fan@oss.nxp.com> wrote:
>
>> From: Peng Fan <peng.fan@nxp.com>
>> 
>> Convert open-coded if/else with set_bit/clear_bit the assign_bit API.
>> 
>> Done with Coccinelle semantic patch:
>>  /**
>> @@ -1673,10 +1670,8 @@ event_enable_trigger(struct event_trigger_data *data,
>>  {
>>  	struct enable_trigger_data *enable_data = data->private_data;
>>  
>> -	if (enable_data->enable)
>> -		clear_bit(EVENT_FILE_FL_SOFT_DISABLED_BIT, &enable_data->file->flags);
>> -	else
>> -		set_bit(EVENT_FILE_FL_SOFT_DISABLED_BIT, &enable_data->file->flags);
>> +	assign_bit(EVENT_FILE_FL_SOFT_DISABLED_BIT, &enable_data->file->flags,
>> +		   !enable_data->enable);
>
>Ditto.

This will exceeds 100 columns. Should I keep as it is using two lines?

WARNING: line length of 101 exceeds 100 columns
#116: FILE: kernel/trace/trace_events_trigger.c:1673:
+       assign_bit(EVENT_FILE_FL_SOFT_DISABLED_BIT, &enable_data->file->flags, !enable_data->enable);

Thanks,
Peng

>
>Thanks,
>
>-- Steve
> 
>>  }
>>  
>>  static bool
>> diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
>> index f658c3a77aa7..055894cb999c 100644
>> --- a/kernel/trace/trace_events_user.c
>> +++ b/kernel/trace/trace_events_user.c
>> @@ -590,10 +590,7 @@ static int user_event_enabler_write(struct user_event_mm *mm,
>>  	ptr = kaddr + (uaddr & ~PAGE_MASK);
>>  
>>  	/* Update bit atomically, user tracers must be atomic as well */
>> -	if (enabler->event && enabler->event->status)
>> -		set_bit(bit, ptr);
>> -	else
>> -		clear_bit(bit, ptr);
>> +	assign_bit(bit, ptr, enabler->event && enabler->event->status);
>>  
>>  	kunmap_local(kaddr);
>>  	unpin_user_pages_dirty_lock(&page, 1, true);
>
>
>
