Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.23
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795763133;
	b=sF7ugozsg6tE9vuTT2wqnp/xabrKRN7Uha6vjvrdi0EX11RSFVTLLj7g6a4ynmv0J9j2
	 OnfGJus4vTgEkDBrwPR4i04BlWG33e3RZcqtYDzjHskrmhpA0frNqVJ8dvMKAKVS6fjA4
	 RFBV+7gfQiBJdr8+XYK4+uvRmb2l475ufZDqnjKUwNlTH/jYDvs13pmZAXq1fuARVa+uq
	 +sBWUNmkJFFYfPNkGQGbl/hYOwAE+DzB0i0dY/pZQOw4nO6W1sdr00tl64u/KnacfaKeV
	 4j6Icyd0+6mdlQm6dpJ3Ziy5bqbkL3FicyR2IE4PDMr4uHExQdZJAC5j2qnJisi6IyA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795763133;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
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
	bh=TtOQiC3fcU958hMyDWD2jpHrVhi5hLk7Q9BnRH3jiUk=;
	b=QiFGB4mOkSKkoPVzOGu4cPcRemE27dOUNAFdwg0iNE/dHgPXKhAZ3ssfjzrNBUiMSomx
	 F+euYKVGREg873r3N/Jbf8cbuUrLM5lIbg8S5uslL8IsJIXdvNpYWqxWt6jxSKBf3xhzf
	 TiXFCmAt3/+gPrzDGrZSmC6/PiMwc7V7pMnPxxx2ZD4fCHTQqu02iD+Nn8tnKASNGlAZX
	 G8kFU2P72sowwXxEKHyjd2fkvKNz0scI7dld8oziobq2eJbSrRG0yus+0AXx7zNhUJEc5
	 fsZ3UljDOlO4YJ+MgNpiwB1kVxk0nksxcriLBYL170V/qOi1jZPtKroy/pGuO4fXfJQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=zVybK21H;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.23
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010023.outbound.protection.outlook.com [52.101.84.23])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64F9606A321;
	Fri, 27 Nov 2026 07:05:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A64F9606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=zVybK21H
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vj1OEhvjghqh7BOG6Xk6WViPukiaGlaKw/T3as7DzVOAHYhuCodhA30+iDxXZX1VGYcg32bjpyjNfUIhpDrQTv3aQXuo14e/jVv2vHyU9qTVPnYNYyHh/fJuWRrBDkLKGOy7YzdogsXfurRTdsDbaAcQk47fyW687e0gHhK5FQ2jPQM+Chj7PqtIVA+WyGpyUQ/3KEMC53wb9glzm5O3ex+xargBfGzER2m0ovBs3Q60UfsPuk3yRuadQz6bsvl6KBfBg72R4t9MdG9IuetWr1hjSPcyzkhX/iN/IkHHM27jtPcoINp6X3peH0V//ZsYivDuYkrVN4NouM96rSVMfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TtOQiC3fcU958hMyDWD2jpHrVhi5hLk7Q9BnRH3jiUk=;
 b=K1Sz5W0kV/OsJzlVWJ1JtbzkN1EfD6DzqE9ECNW354dNLqTK6jhdeMDa6fvtKYMVuaCTasiMlTO7+oEgBl3TgsxHxJeFyqp2CmCx1asin94LThTkFamy11lX55rWAQkX4bcBM22tSKE1IF6K3RpSfULPioBZlJWdRmkhjO2i4Zx6EkvAN8ByZ7zAyYtrvj2s85nYbHX5WDKj+911d2tJD5fBXlQkGNs7MrBu3AGF7ctVeTRSRqDykSBfurE5qR4V8oGJ7qHjcbdwJDuW5lChQT79L9k3Q2/Pd2BBHy8kNP8TW1oWb4vxmLpiPoqDG5QtJW/wpmQMyyVfwJOd2aCvkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TtOQiC3fcU958hMyDWD2jpHrVhi5hLk7Q9BnRH3jiUk=;
 b=zVybK21H5f/kDvvDieK92e7DjNra9yNIAJ4NI4GdhSIrSr91Kd0fhEKOvGOAwQVJ8cgbCBpXaOGT6QRLM0Nb9q6zisPAZRI+E2naEjqdVaVfLbhS3wctl1WP8KtJnbQ7V4qcD9yJLaIxfnbvKhghyFtcHvh9WINXCaChLuvUC0PRMx4zyolr9fjQVm7NUkpbLrOWfzaxSvUZ4RjxECZ/r4WybpTy8ai4VV0sBtGZ262tZZrutemMGddVxazjkJkoVIe/3qrIoYGvhYvqkc48TpUb8aeYoPGLrKxy9auq8Zl614ARdai3eGDPUhQzwiQlAZmEYHu1zKLrEjoVhRId/w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by DU0PR10MB5244.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:34c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.688.4; Fri, 27 Nov
 2026 07:05:27 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%6]) with mapi id 15.21.0688.001; Fri, 27 Nov 2026
 07:05:27 +0000
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
	Tobias Schaffner <tobias.schaffner@siemens.com>,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH v4 1/4] rv: guard rv.h against double inclusion
Date: Fri, 27 Nov 2026 08:05:42 +0100
Message-ID: <20261127070545.64265-2-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261127070545.64265-1-tobias.schaffner@siemens.com>
References: <20261127070545.64265-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0054.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::8) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|DU0PR10MB5244:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c3654bf-ea95-437a-e10b-08df4c54d0c4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|7416014|376014|1800799024|10070799003|55112099003|18002099003|22082099003|10067099003|11063799006|56012099006|261021121427099003|261102123227099003;
X-Microsoft-Antispam-Message-Info:
	vgFo6r0mkoxQHclDDl4q0lFGvnNlJVCQ7eljZDwSeEbZtnKF10+KfCeCBkDrvHhbJCgLfG8ObYjX0x9wmRRqihWA5fnNEOPrKwdeHjz0wtdBwdAb6ng0mIhHhmApsZY2yl74Y8z6YhyWx7+otzz9u/lGjIuKx47tftLmiSw2U2V5o9/eLxnWq167lbdRpwYJLoRcG3nL+MCQjrjVP/xls3AzlxeP9qFzwMcdqj/uC/UCcZqwPNLYyq48CRCCbUscPtWcctcy3U9an6EFEAX+d3JwKeSp0VnLtSy08eLquDzsGw9Sdc4BC3IQ3t4vwJVSiLOFOly6i9qAxfya8mUecAnWw1vGwkqXdlfunGzG7ImpRGJ7mQ/pvWaVpfisXZkPXI0vREKt7Y7A+dC/6N3xAy3/uMArxyePlbmiWN016sHfD1KhC246iXCxgtEyW4eY8/VafISP5sVwGofCexPlsor87z7vb9BKh6sUukcxhmN0H6kuTGfW9pLGwq2Eataui14J8fxvS8bsLGApm3v/nqWiEQobp6MA9x8/4fgSe9964dXC2I4NQsSzVtdjoYlUjgysZNsUB9HSnBadTRzytbvSIS8bELMGDtia/CSxuJEfqBTQmDdsrUfkIb1kzzoaoiwTlQ2xFHNMVRhDolTe8sbEy2a0EUD9mnJcuSeqUoI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(376014)(1800799024)(10070799003)(55112099003)(18002099003)(22082099003)(10067099003)(11063799006)(56012099006)(261021121427099003)(261102123227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1e65Qd1eDgTHpMZ/jbyF2R3rPTgul8ve0/lsu2RaM5X9uFhy5HXqEQl13F9j?=
 =?us-ascii?Q?bS9PeIr0I9j52DUEydtISjNrA4YG2QDA9cpoCvLHWfBsuTBaiXrMeowD85IN?=
 =?us-ascii?Q?7rXIAuwNClAANkxSaIwz+tOVaW7d/A/470w7BcZqEQrMRxIcHU6ux2ZFN3tm?=
 =?us-ascii?Q?Rq3Xkn7JuddNtz29rccpB5VXU3kOWi1Ga0v6njeletBzaVKOuWRtzG5zs1PZ?=
 =?us-ascii?Q?jGY/by64DLLfu24We5RYrCitAnD4qZY3UUH1BDqRPVVbpfhYM/zipbFaiD8z?=
 =?us-ascii?Q?/Wo/YFJ9WjejRMPRQCCGPl2iZ2wmuNlr3UdFQfEur9y2Bh2pDKJiNZ/c08JE?=
 =?us-ascii?Q?UgU7AMKDrKd21fcWocnJClGf7GyJmZFfUsxt2T25qtsMOddC1dx8s4YCGz3p?=
 =?us-ascii?Q?HvEqM29cxmkH81rOlsgHph7SWYrUzCt9bisw7DA1ZN6PhlXPqqzrKX6xRy8x?=
 =?us-ascii?Q?hoEzFGIbXRLomx0y7FFeuqY3C6FZ2lhBQeT4kE/kF+bHjaUAYVtDaBz4vC+m?=
 =?us-ascii?Q?TcdzgF72HCyA74ufy6kW2ZzVX4+8YIaHHMdRl/FEM5cEKCWF37NuUCl3TSgT?=
 =?us-ascii?Q?b+MN+0WMewZbGunoMgbfGHlMfU1x1ebs1ZLSEoo1lnNUZyVpgHx+/VCdbxr/?=
 =?us-ascii?Q?OrEnMyA6fe//1RPWxzDjfjSh8Nb38vv5j6nmG9DuxvoCZTQXVgoP/Mhe1pxi?=
 =?us-ascii?Q?/eWO64dlNZz7T5uK42YT8a8YFHXCkgVlPt90zza10/AiU9ZwxVx5hgro6nAA?=
 =?us-ascii?Q?KyNadRDqIKMfviW/fU9QmyqbvaKmgm9hEAcoe3wiJ4spf+U3xyG3sYIw7NrS?=
 =?us-ascii?Q?PMWb4hN0iS32ddCFD5padQcvziPyeuHKf6GpT88gwumPZn5AnV00vL0LPyxX?=
 =?us-ascii?Q?y5H3a5AQRIZMKnXvggT+9BhOvWZRF+86/mnmN7ZbhOHpmMnyfdrvyyLJyW6U?=
 =?us-ascii?Q?GDI3XtkLFcLFOG30WP9uCOA+h0qf2hm140e/KSmTmDbk/PSIHEmR1wwLYmbV?=
 =?us-ascii?Q?pBzSOX18t8gsA41uB3HdMDBc2FtU99Z8a0t6MOrEs9sVOug+FjUp9st1J2EV?=
 =?us-ascii?Q?skcjsomzj3WBYQyq6gof1N6/NR/q9y35eCUZz4TmWA+his7IBGx9JHEH/dDq?=
 =?us-ascii?Q?gwG0KDtanT8zzfpCwgR1383Xt7RquA7OrX3p1F375R0mmfMSIjDRrdt7MPRi?=
 =?us-ascii?Q?QgX6naFTTGETzrZTl7Y+Z6IK6sO+IVL7Gs5a2jbn6nktZ4O8URXCMVbtamMJ?=
 =?us-ascii?Q?A1YY9dM/INabbZoTQq9v+0hxl6YB/MxiyhSyXZRn1fyfyEOci7zEL7aVdLoa?=
 =?us-ascii?Q?hlrIQceH4Hj6xIyii8RFWFo+3rv8sZ0a9/IoqguoSfNcZ71rXd9gmXZQ80hL?=
 =?us-ascii?Q?K+OdUAlE7xjsRpfHJS7IDxzQB+Nz1DBTwhRPB6Bwff5Imk7ZT3SWhAUi6peo?=
 =?us-ascii?Q?1EUcPoUIRXNPaVE8xv88X8fkBJii4KSkZgrVwP2DUvfwUaXxW9kD7TjOYSvD?=
 =?us-ascii?Q?SRGbfNLzU6QXga7cgQCxt1SnW9AykW7+XwkzU6mxshefCnhStHSn4wpTx782?=
 =?us-ascii?Q?gReR+G1j9YUzadcB6kk2HqgLzAAZmjxI6yEr1SuPaZjQqincSx0//N/9h55m?=
 =?us-ascii?Q?nfpnUHhXeT8VHcMr4MWJ9ahDxyCvBYwm8iY216NJ3qXuTgN9s3yhuxYfm+1Y?=
 =?us-ascii?Q?VC8PRaPrUtbGHV8XXRoFJLgadTXn9knL1jS3AB9+jvJ4coVWtos18Ihtao1u?=
 =?us-ascii?Q?0lmc0uS37ywOyZXCSOn+RhU5vkNMzcT0FXs9oT4Exsfp+/PabLqKMa8ahUf5?=
X-MS-Exchange-AntiSpam-MessageData-1: ijYD+OvQ9mMHn/BpHynCR9nXjbqc3WWE3sM=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c3654bf-ea95-437a-e10b-08df4c54d0c4
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 07:05:27.6459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 42Okg0UN8ZyOZzhU13MqRR2i8HEQLUTohIEwCJSXWHyWP3OVvAoZKPFnX4+Jer8DqJBYZmJ5mxXijxI9pDTiXpSjH/MVhmLmZxFqcBWQIx0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5244

rv.h has no include guard. Only three C files include it directly and
none of them twice, but anything that includes it from a header hits
this.

Add the guard, so rv.h can be included from a header as well.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 kernel/trace/rv/rv.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/trace/rv/rv.h b/kernel/trace/rv/rv.h
index 8e8406b42436..dbcb7a3a41a8 100644
--- a/kernel/trace/rv/rv.h
+++ b/kernel/trace/rv/rv.h
@@ -1,4 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _KERNEL_TRACE_RV_H
+#define _KERNEL_TRACE_RV_H
+
 #include <linux/mutex.h>
 
 struct rv_interface {
@@ -45,3 +48,5 @@ static inline int init_rv_reactors(struct dentry *root_dir)
 	return 0;
 }
 #endif
+
+#endif /* _KERNEL_TRACE_RV_H */
-- 
2.53.0

