Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.40
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792490126;
	b=rR46D/0NNvUS8JFZcyW7QWN3J81FYEkCeUFbVNTyBdbwn7akY7TRlX1B6Io8QlPEp9Yp
	 X3fqbLKDTxq1a+a58sSrLDOaLJsxIKNtGlfBSyh9rpKwhcBwHDSv3icJKmkpfLMm4TAYB
	 2bH4bCr+tvAC66mlI6FLa/pfM+UHt61Y6aCQph2wBjAZYkVk4z0Znfpa39JJcPJ0SaxWn
	 86/CXL+UvN1M8xOcwBa1hog33iLEI/yPvxMOwuP9OEEhIO5q4KnWg8Qll8FgReMx7LKIJ
	 EZASrN4Kucr7QfPHdhIO9WsHmUMf0c+j5wNgB+MT4pI/aEEF3n1uK+hgo1q8Ys00WhQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792490126;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=+4nop3qYks4i/3gadIAXdSJFwwLIo2/nwhKzEvler/g=;
	b=qkCKlPRDjqTLnpWgw6nhIog8m5YKjn9gMTEXwXklaUfTkfDfx+0QLY4Scxsw1h9LxJ0F
	 X+6Klupi8uVLC98H6ez0ofoNFvriy89h9MJAJQKqfZpx95w6cWGDLkBhpbsSAEoq/+Da+
	 0RiZGFDJ9kYTlYsDriDpo3dTaCYjTMZuSVWA9vBVPgxq2IbZO+JRsmT0CDfs/GEZd7WVH
	 F2K5HBqjePbHLN9D07gPF/XOh7UMBcD1fiQE1gY1WDtRyWYDEnfuZ/6NRXLBXkUN2Gzvo
	 qJlPiLndu0nYWggoy+32aqSKmOnsJ9EbfiP0I1wJWRl7GYK4R23n7qd5JtDKNBNrzMQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=tHnjjoT1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.40
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013040.outbound.protection.outlook.com [40.107.159.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F784606A31A;
	Tue, 20 Oct 2026 09:55:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F784606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=tHnjjoT1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QCBSIg1+mjStZN7mnzcr/g+xVr9uAPHxPquNEp0PaxgGTtLDjwUEC5CeDtaIgrZrDmnBuR/TSfKCualEoq2VWAwMY6ScmsvcQIV/znxoJqa3bzYgvBd4BHkmJke4e9Yu1oxCEq9Z6nBMqbzB+A6sM7xyvoSv+pYRWJY/KNypEUcUB5yIilZGyP0X9xmT6jsacrmBAERSMF/ZnbclCU44/B3CGw7Vb+3DvEcRJofS4QexGIJvY2KT15t/ze1O0mBSR3ctuiaEO/4krQaON+MNFLCdQ3D7mUtNpeqvNVPB0jds+cOFEBwe4ouM9cT4WSzrynSjvpskzdAv7YXddMIFkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+4nop3qYks4i/3gadIAXdSJFwwLIo2/nwhKzEvler/g=;
 b=VH2a+0ZnwfUQVNZ4FCfiHErzj0vHXGacgLj1r2g0JsJSZ7s96qfGYWl6tEZdNVqEoyAD7e4FsMJqAnlTvAH8Z2KlxyzOBYsCck73JNg8crblt9EDwh7TqImNEo3+eNT9NbgHWcnddYsKJERZyWGR3VL4TZvo6LRjV7vw4sUE5MV2M6xexfOXl3U/YMseM9KnSBtQX7ET8vAAZlAFvn//D0TW5R6+s7esGjGU/h6lSbNfVz0B900gvXoRwqBre/A33FYg62j+o9TKvE4yOCxBVhD4z9OvFZ/JKe749qsGSKFPGuXhgP+9JM465pYeaelkOM1eII2MSsHf6FlPxe1MAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+4nop3qYks4i/3gadIAXdSJFwwLIo2/nwhKzEvler/g=;
 b=tHnjjoT1kk/poeMnsNZijd1J0DKa3i33Ea5O2GjC6GQLWZpJotPfwjZtmdOfLBFEWCKVZxzMUhjSN0AJwYg3juLxTcahDMsUezGnCSwL0PyX60/J9TDgKuXwmaPSqvUCuJCIAEBlWH0xkwzCSeVwH2jI3rBY7rJwQZg3L16gzn2jmmrYzcOao6WnakrrcM00rogmiCKWTklQxy/Uzfl8mvFXyjLVzuCmCVOwgvWpREKg2spglbuaR6wiuy2PlkcSKqMHP9lPqfFkcW1otmb5O2gN1cYf1pdYRmS62Qb4eNS/1HlCQf28yuqAQIta5y1Cuv1OS/Uz+FVqJ0OetUjN0g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by AS4PR10MB5872.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:517::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 09:55:21 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%6]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 09:55:21 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rpm@xenomai.org,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH v3 0/4] rv: per-edge dwell-time statistics for per-cpu monitors
Date: Tue, 20 Oct 2026 11:55:08 +0200
Message-ID: <20261020095512.863754-1-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0241.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::19) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
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
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|AS4PR10MB5872:EE_
X-MS-Office365-Filtering-Correlation-Id: 9898ed43-b24e-44b5-6efc-08df2e904102
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|10070799003|1800799024|23010399003|366016|6133799003|10067099003|55112099003|18002099003|260925022911599003|11063799006|260925021911599003|260925021311599003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	yW4HQkZFBPAdRtOAmAKAiSc3m0i7bxtbp50tMzGWI1m4+Qip7UbFVaY5bYogRUM227SKInQutpMIw2RJ6lR31qj7D+jJg/1RfGEel/HLcJNMz9DHzzwmwRJ/dKBJtLUrr/q83xiZbz/y3qzEq2E1JYBfoE35pgiILV3xUx+gTDcBbIDMFQFw30F9l2I9orkIoHxxr0NGdRwsGbmf6U3Glzux3auU+QOox/okJxSUyQ5OrdB6MaKmrVwGbEUMijxOpkxA+SXQQIkZiBdNm24dtfBwMEsoHJP9HEtSn0SYXtiv+gYCDyLXnvclmPp7tR4BmquP3Fr1u1cseTob6SZQbzPWE1IPywrJNdL8RaVtj3BtwJeYH8z8OnPaAcfHQkkwBmJg54SSbFeD7UXmN9rzypGpogNJY0ov547dqKWdxExKUBEQE68t2p7sbF4ywfU19ed7BPGoYw6KsR5g/uJ25jYogtix+Z2a4R+jxw0Ie7Euzi//XcJxtnHRp36O/8I1h4iFPhTkgHfOMsPtYX0RJ65rvGdmfih6pgrTJh8c/rd1rYMplcnJB7U5KxOfH6YhOli//PEbGfmMG7s00OggqsRMVA1ZTmrmFz3IoXcr36+q9aDNuyRaOP0ffPycHiMVTvdPiN8Fx+ZVlr/j3HNolx05Y2PZLIDdzDzFbIjOALc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(1800799024)(23010399003)(366016)(6133799003)(10067099003)(55112099003)(18002099003)(260925022911599003)(11063799006)(260925021911599003)(260925021311599003)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4wXYFp1giEqSiph22KEBas5q7QPyIvtoN4B5yyvYmuqGFwcQqu69/1QnODB7?=
 =?us-ascii?Q?LB/x7EEO9HKyU22iVwygmf5HuXloAMajsx7nqVh+ucdUkYeoQgNgWfyFuMCs?=
 =?us-ascii?Q?Z+Nl9BIGFz2bAes1U/DCS3sw34QLAX3mqSSLpTzSY0bwqoEvwdVps/2IB4qt?=
 =?us-ascii?Q?BXgpT+ZxiXu5QzroWXD1erbFarNwnjEG95dHsiTkQIsjocmCE7tZWEWx1GhX?=
 =?us-ascii?Q?PmUjDDZysnmRN7EoqffGv2YzJh0VGq3GHFnkCRVsMc4mexsCUbjC1ll2qSU+?=
 =?us-ascii?Q?oqoHeQr8EO8vw5jFmxYRPF9Hin3j4qMutSoFY/GHteU4dzUIkmYszzzELVMH?=
 =?us-ascii?Q?96pzf22YIlkLnHxwLrrzdEJfZuQwguyTU6LJcCdBMe1Ww2nw/KjE1GKyFJrs?=
 =?us-ascii?Q?7Fsq8AvE0GCl0e2xZvBLfvlV2MwCs5lm9WY+zKb2RExuoeZLdaSTX0HT8Za6?=
 =?us-ascii?Q?5+TWcu7VVAqOjX1HhhWX/GaCn1E5aM7ako6Tg4+79MsUysVhOTaEBe0lvI5M?=
 =?us-ascii?Q?QWGL07LF6I3ZB9voq245BRndW437e5L7DpuaZGUDaIaGYSPLvhtAFRJx7Fu2?=
 =?us-ascii?Q?fTLwBV9aHRWUTaado9pygjte7B2zypWbgjNt6f4r2rqRxIJ6r5IDWNRqAo3/?=
 =?us-ascii?Q?ReMnx7cFREiItVJGtYAJQfkdLtwflRAjHW0hu3WfH9VZgeU1EFSGTjPjHub8?=
 =?us-ascii?Q?Ci7/EJ+P8SRsYgJdAowEl5BhdVpQ7GDXAtXObM8jScl2P40nyW9nZfTnyB4m?=
 =?us-ascii?Q?D3ZLnuO59athmmh/siLDaNyWK85vMG5rnkUvSDg1/bBa+xVjoWnJL9nC3q4B?=
 =?us-ascii?Q?oDO/DQvSxgvHrLXK7vpC81D8LJ3WNNsQAawHXUX1w/+Ll6ACRyPcNv2QIn2a?=
 =?us-ascii?Q?HR3RxmGX3eDM41YkN4EM7fDE2sfF+97PHqkZ+1zFlVF19d5gJHZlZVTlCbeH?=
 =?us-ascii?Q?8Teb31cM/8JUyOoSRfEep+xUiS3sWWm8pFupC2t2Y3L1Ee3zeUaLQqboAgsV?=
 =?us-ascii?Q?/SoLN0DmP+09KtlhsQ7YiQxN1Hgy1jwoy+QesXX7WxdSJBCZCKeuiLIduP51?=
 =?us-ascii?Q?HFhurwzJ+SSdXgX8Bo9u0d2FfK78RBm9Gch09jgqNjvKFPLgknSpVPFgREax?=
 =?us-ascii?Q?fA4t6Dhu+06QSFoCkUbC0DYhaTRCriNV6TsJPqre3n+tBRRTYpINWM8gQkxx?=
 =?us-ascii?Q?abzy48gil242EUCIgqpFiYUrNrCR6mxjrefVwGyvWN/TC3S73OoUY/VSR1Am?=
 =?us-ascii?Q?RF+Razo4ta2jsoTEi7xn6/WtSE52WOj5DI/tOY0773dpFAsVrWY1n3QIWODW?=
 =?us-ascii?Q?uzv5eXcAFBI1+Hyz8D+smZw54efpfyf8/04MbfSQ+8rcw5Q5n8n0bqsh1lP2?=
 =?us-ascii?Q?fk39iPOVejECfiFgpnKj7Vre/uDiQVFWdIcX/51IuX5TPPHvG3r/FfWa1N9p?=
 =?us-ascii?Q?Scutp0+ebqfsrkYGirbdbUZkJQ9LFzbGWzIqRKaoxO7+dwmmkxA7i1CfgCWU?=
 =?us-ascii?Q?y/MfsTNeLU5//rHer3mhZYDC0y0lrHPBD9THDg+YzU4VZdbgi8XkSI0UBZvz?=
 =?us-ascii?Q?YqsYUE1dddnVnUNInveacudDKaBLBN58YaikM7x2YtN8xkcLr1Th3QIZ3oph?=
 =?us-ascii?Q?roYBcXFU2lzHXPIh0v3E2ov+0ccgDk4wfVAkh4/f1p14xWbGWX9uLdRmkHgn?=
 =?us-ascii?Q?x1UDSneyezIgpx0nCpQOwdxC9dOPQZy9fzNoqfAsE5EDrVYcSNLpgDbFD1En?=
 =?us-ascii?Q?Dj4uZPxvGmhjqCn8pz+hg6XHZ6g00psUwIkan5XL8qXtp4SP43MJrENodIk+?=
X-MS-Exchange-AntiSpam-MessageData-1: J9Bfx4frH9qx+bF4h/YpgUX0AEY/jkWYBh8=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9898ed43-b24e-44b5-6efc-08df2e904102
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 09:55:21.1872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3yXC4iBWfNxjP9qzTA/MwRyv0aT5wl95SegNwuK25S7vzNkOwu89nNeQAQwBzyOoK1F5v+P5gzTM8jBsJClqL2VyyAMwZfxkBwjuIYC1qHM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5872

Hi Steven, Gabriele,

I am using the RV system for a downstream project called EVL (aka Xenomai4).
It is a small co-kernel system, small enough that I can model the whole
co-kernel with RV instead of just a fragment of it.

The patches in this series add a per-monitor "stats" file that exposes how
often an edge has been visited and the dwell time in the prior state for
per-cpu monitors.

This allows me to not only check if the model is correct but also to see if
all paths are exercised by my stress tooling and to decompose the latency of
the co-kernel's wakeup path.

I think that some of the upstream monitors like e.g. the sts monitor could also
profit from this.

As an example, here is the sts monitor on a StarFive VisionFive2 running an rt
kernel (isolcpus=2-3), after enabling it and generating some scheduler load.
Only the edges the automaton actually takes are non-zero:

  # cat monitors/sched/sts/stats
  # cpu edge label count max_ns sum_ns
  0 0 can_sched:irq_disable 367732 3998500 14773091250
  0 4 can_sched:schedule_entry 40282 398750 45510750
  0 7 cant_sched:irq_enable 367732 32500 532791750
  0 8 cant_sched:irq_entry 26188 6250 38357250
  0 13 disable_to_switch:irq_enable 4933 12500 12275000
  0 14 disable_to_switch:irq_entry 31 2250 35250
  0 15 disable_to_switch:sched_switch 35373 26750 111615750
  0 18 enable_to_exit:irq_disable 373 3250 649750
  0 19 enable_to_exit:irq_enable 373 20000 1676250
  0 20 enable_to_exit:irq_entry 309 4750 420000
  0 23 enable_to_exit:schedule_exit 40298 3000 37335000
  0 25 in_irq:irq_enable 31 12250 140750
  0 30 scheduling:irq_disable 40337 18000 45449500
  0 37 switching:irq_enable 35373 9250 72471000
  [ cpus 1-2 omitted ]
  3 0 can_sched:irq_disable 567 3983750 300860250
  3 4 can_sched:schedule_entry 150 1500 171000
  3 7 cant_sched:irq_enable 567 21500 1777500
  3 8 cant_sched:irq_entry 76 6500 164750
  3 15 disable_to_switch:sched_switch 150 4250 413750
  3 23 enable_to_exit:schedule_exit 150 1500 147750
  3 30 scheduling:irq_disable 150 1500 166000
  3 37 switching:irq_enable 150 3750 277000

The sts model splits the schedule->switch path into separate states, so the
per-edge dwell decomposes the scheduler's interrupts-off window: on cpu0 the
prep phase (disable_to_switch, irqs off until the switch) tops out at 26.8us
and the switch itself (switching:irq_enable) at 9.3us, over 35k switches. The
counts also line up with the model, e.g. every irq_disable in can_sched has a
matching irq_enable in cant_sched (367732 == 367732). The isolated cpus 2-3
take almost no switches (150 on cpu3, versus 35k on cpu0) and their worst case
is tighter still (~4us), so the same file also makes the effect of cpu
isolation visible per cpu.

The changes are gated by CONFIG_RV_EDGE_STAT and dormant until a monitor is
enabled, so existing setups are unaffected. When enabled, each accepted
transition adds one local_clock() and a few lock-free local64_t updates. With
the config off there is no code on the hot path at all.

I focused on per-cpu monitors as a first step. Per-task and per-object
monitors would have to aggregate entities that share a cpu, which is harder
to get right, so I left them out for now.

What is your opinion on this? Do you think this is worth getting upstreamed?

Thanks for taking a look,
Tobias

---

Changes since v2 (addressing Garbrieles suggestions):
 - Resplit the series: one patch adds the facility, one wires it into the
   DA/HA layer and one adds the selftest. da_state_t is now defined before
   its first use.
 - I used rv_create_file() / rv_remove() with RV_MODE_READ and included
   "rv.h" rather than <linux/tracefs.h> as you suggested. That makes rv.h
   reachable from a header every monitor pulls in, so patch 1 guards it
   against double inclusion first.
 - Replaced the pack/unpack macros with FIELD_GET() and FIELD_PREP() as
   suggested.
 - Dropped struct rv_this_edges in favour of a plain per-cpu array of
   struct rv_edge_stat, used through per_cpu_ptr() and sizeof().
 - Added DA_EDGE(), DA_EDGE_STATE() and DA_EDGE_EVENT() instead of open
   coding the state * EVENT_MAX + event arithmetic.
 - New "valid" column, from model_get_next_state() != INVALID_STATE, so a
   non-zero count on an edge the model does not define is visible instead
   of having to be inferred from the label. I also added this to the test.
 - unlikely() on the first-sample check, and dropped the (unsigned int)
   casts from both da_state_of() variants.

Changes since v1:
 - Packed the state and its entry timestamp into one word, so one cmpxchg
   commits both and a nested IRQ can no longer charge a dwell to the
   wrong edge. Hope this approach is fine.
 - Moved the header to include/rv/edge_stat.h (Gabriele).
 - Implemented it all in the da_monitor layer so that rv.c is untouched
   and the file is created from da_monitor_init() (Gabriele). I did not
   create a matrix living in struct da_monitor though. I think that this
   would need a fixed upper bound as rv.h does not know how many states
   and events the monitor will have. But this would lead to a large array
   in any monitor including per-task monitors.
 - Used local64_try_cmpxchg(), bound the loop at
   MAX_DA_RETRY_RACING_EVENTS and warn now if it is hit (Gabriele).
 - Static per-cpu matrix instead of alloc_percpu() (sashiko).
 - depend on 64BIT, so GENERIC_ATOMIC64 is unreachable and the 32-bit
   NMI deadlock cannot happen at all (sashiko).
 - Reset and report for_each_possible_cpu(), and reset before the
   tracepoints are registered (sashiko).
 - stats file is 0440 now, and a failed create is propagated.
 - Columns are now count sum_ns max_ns.

Tobias Schaffner (4):
  rv: guard rv.h against double inclusion
  rv: add per-edge dwell-time statistics
  rv: collect per-edge dwell time for per-cpu DA/HA monitors
  selftests/verification: test per-edge dwell-time statistics

 .../trace/rv/runtime-verification.rst         |  28 +++
 include/linux/rv.h                            |   9 +-
 include/rv/da_monitor.h                       |  16 +-
 include/rv/edge_stat.h                        | 211 ++++++++++++++++++
 include/rv/ha_monitor.h                       |   2 +-
 kernel/trace/rv/Kconfig                       |  12 +
 kernel/trace/rv/rv.h                          |   5 +
 tools/testing/selftests/verification/config   |   3 +
 .../verification/test.d/rv_edge_stats.tc      |  37 +++
 9 files changed, 318 insertions(+), 5 deletions(-)
 create mode 100644 include/rv/edge_stat.h
 create mode 100644 tools/testing/selftests/verification/test.d/rv_edge_stats.tc

-- 
2.53.0

