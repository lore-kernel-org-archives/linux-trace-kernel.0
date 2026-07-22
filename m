Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022118.outbound.protection.outlook.com [40.107.75.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853343806B6;
	Wed, 22 Jul 2026 04:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784695535; cv=fail; b=O62PF42vDN0cfkn32EKTEtosqppYvDdba4bMCE0DKQkEBVEPzFtX3TL5dLLZgFdfx3YwrQ5GGfpImdvp5uXSGKG0uVOmvG/YFEcOY8+1sqXXG03gM+8kG6txtMDhqsCfLaaoK/FmqpfX26mbEBgIIlgofgNe/W69UD4EEMUG1js=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784695535; c=relaxed/simple;
	bh=4oX/lcEeTYLFnkex4EKcBqoYOZU/+Hh4YHuwIpddHiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=b4wmyvy/BRz62FOiJeiBoY6/ZSMA1LznfjTEKc5JI32P/9PAzFlknwPlrK25dW6xJeog0nKePhOM94R/SN/8aYL2V/9QvtEJDSpURVw7O8PTvFRUEnKjdnSBw9Fah4JiFOvbCMlz8xH07MRHebrXLASMFhf6t2sG6ouuueQTS04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=processmission.com; spf=pass smtp.mailfrom=processmission.com; dkim=pass (2048-bit key) header.d=processmission.com header.i=@processmission.com header.b=WloBCFWT; arc=fail smtp.client-ip=40.107.75.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=processmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=processmission.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=processmission.com header.i=@processmission.com header.b="WloBCFWT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mQtueaYRTIlVfo8UIXE1cibFds0Ex+o4jo61YFUCm6pttiWp1hrI9ISHr+0GrikXghKb65aGFYkmU2B0/8ubJxiXvn241+qkRFKM8eYGPGoAS9UxZrrPnTGjiAe48yIm6JsP1dY8vNoJRe0x+JKyqQD34/vuQjUV3kzcMMBBvfv8Zs003C7jS+6U6l7PYzv4tLU/5xxNFLSLVmfizHPHuoZaGvM15IEqGKuc4pvuFwEOVlWLqmZaukowsMy3n3neMW2cRVNBuKaSw9y7AZplf2Te9n8W5mwxtzn4YxpysTySUcoy6e2IYIGlRUH9SO0BTL44V+0/fALRUI0gj0dOLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KOE3Ur17wZNixL1o7TTinAVMvjrF/ggu/HkkQLN8S2Q=;
 b=SbkIYXAsF+ZBzBn3grmZ9llWds8AOucnMECd1EDTfmISqJT6WxljxzUTyLHKNah1qcqukbxcP2Ih+SYeq9qvhwfiGq+S980Ntg7Gk6U96VnFyjPhCk7KoRQNbW9Z96BCNwVUHuTSR+ZxUs/hCdn4L8wmz+8U/U6Wy/PeF94yced2q9MaURF9HnhDUS68jEg7ZziiAnHH+7NfjMIp0ofLcz+4bqLcYazmgy7rjaF4e5a/nZvIRDQAwnR6tS9HNFhzAtezClHtshuXtbJinsoBvBha6ooK1/P//chFyiyukXfmaj2QJTndJB6cOuk+PVRcNBYuqNUX3BsFYbq26fYcHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KOE3Ur17wZNixL1o7TTinAVMvjrF/ggu/HkkQLN8S2Q=;
 b=WloBCFWTNvZmBq1lrDeOMyrMMHddY7g6flFne/2LIE4KXtOQc28VsHrFWDUYyp0bnSL83PKvEcMgGukIn5swJ3OjYsnWQQBr2ZHXMGvIkodQEpAuqg6ITE6aeX9athDSNga0ZtmH0sOmmBDiaJyH8tBQwtc9M5UMaVLR1fyeCZedXj3YfdLahjzL2DfFBYlnzOK8MHBapxpZ9WLw31bjQbSUnA57hBtalS7RghirbA94O1afyj60/EvGZ3Gc87Fvrrv0nM3NOKAcsPQoH1Wsny3yyWR6Vn4ME/iEVPxAkYOGdKp43rgnRRswW1PxOtKdOjr14kguiYLS00DnT9Z1Rg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by SEZPR02MB6078.apcprd02.prod.outlook.com (2603:1096:101:95::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 04:45:29 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%4]) with mapi id 15.21.0223.017; Wed, 22 Jul 2026
 04:45:29 +0000
Date: Wed, 22 Jul 2026 12:45:22 +0800
From: Chao Liu <chao.liu@processmission.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Gabriele Monaco <gmonaco@redhat.com>, 
	Steven Rostedt <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] rv/rtapp: Add wakeup monitor
Message-ID: <amBHR4JTr2InJDk8@ChaodeMacBook-Pro.local>
References: <cover.1781852967.git.namcao@linutronix.de>
 <ba5658fa13e49ada466b84a2c211f233037180b5.1781852967.git.namcao@linutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba5658fa13e49ada466b84a2c211f233037180b5.1781852967.git.namcao@linutronix.de>
X-ClientProxiedBy: PH8PR22CA0003.namprd22.prod.outlook.com
 (2603:10b6:510:2d1::6) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|SEZPR02MB6078:EE_
X-MS-Office365-Filtering-Correlation-Id: a09ace63-470a-4031-cb98-08dee7ac0e27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|34096008|56012099006|4143699003|10067099003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	RWiOtzqqt9egvOKaeRuyrLWoe6Erl0yHVAuFoh3R1fhAHRdnUqFlRFORk40+CDKhcP5IPL3PKF/Sl7ZBdRdyw4cjfw5KPr9rpeeXss0prepIXUDkZJW5AN3iTHOLTsQfmprazfSdaMPPhNDRI4XAxW/nKzUCL7BBHib8gSPSBRNLcat6A5LSwSI81IOWMxiv3iwkuPWaHQRelzLVEmwBmqpim4b5EJJvRej1Jfg0oCE3zPR92lRtkhB5e29kfQf28bK+Le8DfIM0GsdU7bxG+qoSv7S1b4JApbFrLYZm9OodN0CCmsJnQ9BwmbfLyK0nGEU2ZTl6cxeRBpPLW8Y6adnbHsnp4nLXm3WHsU/u7Ju2wOdbqN3PHsX93EMEJDtR2fvVm8ePA1BIUzzSbtOvF1luWDvuRuCf7lQoEVs0GpFDsk2PYHPQUpKpNUYcM+TZ53sJDJLWL2WIeIIjftFZdhpzvz+nBY6Lkoz0xeukLXss5SCF2EyVLdfb0goUsbApG7aXDZboXuRnNEKo61esAhj4kP1CuPliHH4mwcrfacjUG7afZnklcXren0lma01HKekVkkN5Cn8M7WxnP4jGDaVFSJYMKFtiWZLS94okkra9RSc7lCCNhws074g4axpA654dVrD6AWnceKlTHNLnXO627edGnxPtiX6vOfOsCK4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYNPR02MB9351.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(34096008)(56012099006)(4143699003)(10067099003)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8dKeRLDQASb20DUs/xInpMhswKy1i/WyUPcXA0MAT6ueifTc7ql/wWNAKqvT?=
 =?us-ascii?Q?PBuqX/EW5eOJWSqH/ylQXYv1ksR7Zqwr3+u0/LnWwLX4dePmoEEX8xT7x2bh?=
 =?us-ascii?Q?l81Nz/t+juB80sMqmKhKzaCUaKGk0dGC0MI2KvJEuiZy2G4yrH8jmAde9Pe8?=
 =?us-ascii?Q?ClaRy/w3pGdx2CMoPQo7nASfhGnGainqdbM5XnhzWSKn74feGTFnlz2cH4HC?=
 =?us-ascii?Q?2fV2xHfEg79KUtwW9kLxBLPMxYc1V1dvD+hB5txdybwXOmpjXhBeFrJNhScm?=
 =?us-ascii?Q?Fk2q7sY7AaflBOQnedwaVERF8lIaqqbhxfdmIbJY5HBkp2IHMH/REaDhq49U?=
 =?us-ascii?Q?1qOnDgWF/iNb7eF+vM4U7ordGN4kbChh1aSEgN4xkJjmACzTIZkE6xGnj1TP?=
 =?us-ascii?Q?RzQY+k7+syC7RXRR73caHs/jS3JTb0bXS7w6z3AKv4HPUlfm+aL7agFQQ2CA?=
 =?us-ascii?Q?YcPOgwUXoAOApOSOcF6RjRYEvZn+EEOtbRuN6Jfi6BA5jT1ER9y2TJDiu2h9?=
 =?us-ascii?Q?GrSioizrZ6s50zXyQVCgiXgj7/3tpVjKg9vqxqexWIYFHhRIo8sdh5Ads9pj?=
 =?us-ascii?Q?Blu0jSp5an6rzxxlqIbZr1juFd5KHHibZGEaY30OThi4UhMDAgP8BtpUtHkR?=
 =?us-ascii?Q?W+L6rkOo4XAqbxEjFpDURO2dbEtKNs8MuyQ4xrR+qlb1+B8Cx8MRB6fJVlL9?=
 =?us-ascii?Q?2matEI3x+EI7khkOFTarbdQ9xwMJXJxwPLh0z9kyhYUE2lZY6CtFG2oEoAiF?=
 =?us-ascii?Q?I4BjvbF9ZI0/1IWvLRRtVWvUSR6q0fAoA3tLqDTFnTJrX2JBOMrDPb0Mp8FT?=
 =?us-ascii?Q?iIe1oOXcBcVGtYuPBzuSJ1u9bfaXDzZEJ89AxjlRTpVGDoMrwrSqjh1ZmCr9?=
 =?us-ascii?Q?459CqykwN1dDMhYeAveki9SckD08kTOdaRLc3Tw0Fv1vZOqmo1QlOJQgeju/?=
 =?us-ascii?Q?6x5PkRpYqzUCZIUEBp593d7EORPwxKEflv4NoAcmmRxK/epZiT87JeZ+ZaUc?=
 =?us-ascii?Q?S805qjGTnCB/IF2oLvnuucMhgE7Vt0R48DbSyojZhQ+KC4n2fsGKGXzoFnO3?=
 =?us-ascii?Q?OVYgjp7hcDe5DR4sT19+ATBZZed/TgZUEGxP06lV2Oe7wp1X/DfqrdGZz2XY?=
 =?us-ascii?Q?MbV/rMGFLNvXmFib2kQ3GJB5+Gc3tULYz+Fl1oio8oBkP2V+j3s2hrdak1Wm?=
 =?us-ascii?Q?RTVgJvzRa3YzNi4BNq1C1LdEjSk1VeE0zeZP1vrzoJh6/y0IllgKeDKaVYXu?=
 =?us-ascii?Q?MWqaRXKrOQFh+S4wKswMLZsP757QSNBzB4k0MYT1Nqap74MbfXuoMMpvy5X3?=
 =?us-ascii?Q?F3aip3fI/QczKdgg6y1lcQB186dyFfJ5AFSMVvDebW5cBrZaNOy9fVRwebZe?=
 =?us-ascii?Q?5rBzv01EfDyNavOjVP60HriXWhOxkHb+Dghvrzq3241okd6t37GmN/SYaImx?=
 =?us-ascii?Q?wplNJHWhRSrXYcF+kgr3KrgDNsterfjY+Mqb0X5ukQvuTfbVOBRHm5Ss7XDX?=
 =?us-ascii?Q?TAeD1C/cjVIbS7fc6WOp+DaIye9dIXq9WP2BoO3E06Vf8BEo/ZHFg5EN02yp?=
 =?us-ascii?Q?nvi2gLpDuaw3sNxh/JbQsNrgOv12YKskWO5N3fxv6RtrvaBuDEV6ELjZ9WAM?=
 =?us-ascii?Q?nrjU1qeWTAtqrHs+DQSGlShvdfb54ykYzywSW4ZbO/Vv1qt8dkPWa01YDbdu?=
 =?us-ascii?Q?AibZTqDjNYrXQEa5QDS5gLrbJWzEeNCl2z8FJfVZLJvpynEJPBnHq1xGK8ZS?=
 =?us-ascii?Q?QwXnEMNh9Hbtf83Y4Ssj/xdgV6kD+70=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a09ace63-470a-4031-cb98-08dee7ac0e27
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 04:45:29.2824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gz6q20IhtYBq4rG/eOH6aX5oHpNlFnnIR1NzBfMA4pqk4eV4PpKTEZAGxUqRN8L0yfaJeSNJyvyHMEcVWX8m9G8odpdXfr+EYgkoweHjfp0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR02MB6078

Hi Nam,

I've been looking into the RV subsystem, and while reading this patch
I noticed a small inconsistency.

On Fri, Jun 19, 2026 at 09:21:22AM +0800, Nam Cao wrote:
> Add a wakeup monitor to detect a lower-priority task waking up a
> higher-priority task.
> 
> The rtapp/sleep monitor already detects this. However, that monitor
> triggers an error in the context of the wakee task and user only gets
> the stacktrace of that task. It is also extremely useful to get the
> stacktrace of the waker task, which this monitor offers. In other
> words, this monitor complements the rtapp/sleep monitor.
> 
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> ---

[...]

> +Monitor wakeup
> +++++++++++++++
> +
> +The `wakeup` monitor reports real-time threads being woken by lower-priority threads,
> +which is a hint of priority inversion. Its specification is::
> +
> +  RULE = always (((RT and USER_THREAD) imply
> +                (not (WOKEN_BY_LOWER_PRIO or WOKEN_BY_SOFTIRQ)) or ALLOWLIST))
> +
> +  ALLOWLIST = BLOCK_ON_RT_MUTEX
> +           or FUTEX_LOCK_PI
> +

[...]

> +static void handle_sched_waking(void *data, struct task_struct *task)
> +{
> +	if (in_task()) {
> +		if (current->prio > task->prio)
> +			ltl_atom_pulse(task, LTL_WOKEN_BY_LOWER_PRIO, true);

The implementation also reports wakeups from softirq context through
WOKEN_BY_SOFTIRQ:

> +	} else if (in_serving_softirq()) {
> +		ltl_atom_pulse(task, LTL_WOKEN_BY_SOFTIRQ, true);
> +	}

Should this description mention softirq wakeups as well?

The Kconfig help text, struct rv_monitor's .description, and
MODULE_DESCRIPTION() seem to have the same omission.

I also have a small follow-up documentation patch based on this series,
which I plan to send as an RFC shortly.

Thanks,
Chao
