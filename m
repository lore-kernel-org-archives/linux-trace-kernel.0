Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795779355;
	b=VGJ/02hYHgQF+uWZXRkuRC2WG9kfBITZENkET8npj63e3LVNjrfDvFJxuBV7k3Jv0GPi
	 g92pam1PcDLGAyXKtF8ITTondMxM8ZJVJG2E7CBMPy5bTi6n075METESAeZ6JIO6wUyp9
	 BbjB94iBNb1IGQEIXNvenR9rdOm8mTJjcQVzQbhSwXfA4AGzBncxyPJYETBAjVnvDa31t
	 lGnK2sMc+621ZUNoM9Rgk9koec6y9EKNoOPvKTNDbh2FRrMhKH7cAJF3l5xviQ8c+EE3A
	 dWDoaXCK9+lWO/uahLOdp7QEUuEeH3IIc3NLUqnRh+5cBUSY5ydSMql8ZTbcH8x9kjQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795779355;
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
	b=yZAV0xj8i19GAa2qKkzuk/P7OsqSMCOWpHhNZDhrKK/xEmAq/TT5dGTcoON96n0UQxjp
	 AAs8H0oa8QvZFi1mQeXCDU8X8YrOmhxOnC0ddBMLaitIJqGq23U8BTpCT2iwuryAHuN2v
	 2Ad3iEeim7EO5/G1h8TLouNF6CVR4MD/kQQo5/AJqpv++4UB/tEJIEVKJGOIWiFkyeTVi
	 iJEj6lpjQ2BtP3MaV5oLMkT1IpoQIDczJRdg1se7YTFIcYUJ8Gm6kAXhLBavU/5YxAcWp
	 gsC9DyPdNZ5N/NK6Fr2aT5cKibr5++LkBrjsjgKKz+k8AYhn4wFnqKChFVoQMRTON0A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=siemens.com;
	dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b="Rq1kpZI/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.12
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011012.outbound.protection.outlook.com [52.101.70.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496BA606A331;
	Fri, 27 Nov 2026 11:35:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 496BA606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=Rq1kpZI/
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EL5xyAjpI0iSLYulolmie7pk+NsErz8cY34g3yc+fssmc1QGUcZrToVpO28wvIO2aCbAibpzXsWK4BGahFioldpAUIZxxJGsAoJ/revqryDSBgjVtcMTltqOz9dHMA5WvjY1mlAlNBlBiI3X7iWBBYCIOG2z7hlWii9TjeW5eo4QH76TAluMH8I/4dtWrMp232ywMOXEHDLbgatVxbJei2W0NcM/fYom2OK2ToQsi9yLj4MD3zkPVvYiqVB3wcyqNyJuHva0mJc3ISlHXcO1tu+cujziYWFBNMsvgnz5ygcj9MrKHfFw5iptbeHOrHe0nu8isMtXIc7a2D5OUwVntw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TtOQiC3fcU958hMyDWD2jpHrVhi5hLk7Q9BnRH3jiUk=;
 b=XzXZj5YjFnI7APlJAOmdGR36HpgUDT816B8B9F4FyrecbHSr5pjToNhSqZflb06rl1voZZHpjGUgZxwS/Sb1vJNeq/UElENGgZff11n9Fq8FRL7zv+juZeFGPKfScbnoLFA1Phd06rrIAB7UFv4zXR/x68AyQmbBJwltL5LQdON7ohvSOJGUWKgga3Q8JnH+ldBhtJJO1/laTsFoDWfIQv4HMF8h2toi75aDd8+pwiNfsOEF9pic/nbhs0cwhhgc/8ZisCtMM3trLJLlHtSRisORIm7BSt72YmoTLYRBt5Ez2jKlK7BpXRHhZ6MvDQXNO5n5wHijmG6oLAM+jnrFJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TtOQiC3fcU958hMyDWD2jpHrVhi5hLk7Q9BnRH3jiUk=;
 b=Rq1kpZI/8bQSlWuXnOvX5iloIoLqkCj/N+GcD0SwefFv4q8tBfO8iTXcxuAceKyZDazkz0XaHEHjzfbr+UYsRhvEjqc6ylg33wy/tnQyT8H3Uav15wZf6Ov8QFhHDL3bXKWWKL4IAGdc1Pz1xvrq+PHFh7AoPlDIHZ195w8JyT7yRjq9fAPRj1v0Aw7qoAXdtMPzb32gYbrVM8+5UUWVMroGjO2fLevjEQzoY5qGXofd8GDw5701dqIpnKqW9n1uxcZUE1kj6/M/WezHcBm8NK6pJKOYHH33HVQVImAozt38JI8TaNZmL+HMRvBMPHSJdNwpLIJq8x3ztF3X/WVGKw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by AS2PR10MB6425.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:544::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.688.5; Fri, 27 Nov
 2026 11:35:52 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%6]) with mapi id 15.21.0688.001; Fri, 27 Nov 2026
 11:35:52 +0000
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
Subject: [PATCH v5 1/4] rv: guard rv.h against double inclusion
Date: Fri, 27 Nov 2026 12:36:06 +0100
Message-ID: <20261127113609.650286-2-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261127113609.650286-1-tobias.schaffner@siemens.com>
References: <20261127113609.650286-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0176.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::7) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|AS2PR10MB6425:EE_
X-MS-Office365-Filtering-Correlation-Id: 56eb12b6-d244-4d12-916e-08df4c7a97ab
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|23010399003|1800799024|10070799003|11063799006|22082099003|18002099003|10067099003|56012099006|261102123227099003|261021121427099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	8yQtjZlHh/qOozWwPa5Q1MNV+8+hJ6/LQoJon1OzSub6Cb/8EJV7w7y5CrupHF7DBWuhWy/Tpq1XTSscMatDU3bG8J2B3XrGIqwnpS+TSo3/fGGKfTcFqXI0RmUmhnG7Wj/zDAZSKAS6RXvK+87Dw5wPJ89a7TVtIiN4IDgYdYV32jloHgziCBkFN8RuZ/rq2OnHeblRvtf0ln9ZwUZOMtgb0YUGrnfhfLqsY3zyUsHajahGJES1zEc9+cVugjV4ABi7bH8MC1Dn9s0G6spEgHaf8w39lT+Aj+NT1h9rISiLsYGfTVyhtKlz2aQTugBLys5XckIC+2ZWi8SEikJamZ6kMQqLQZfLF4DiJVAoZCeJQgjAd+gh/JrTa3FC+KZEt3oTvYZ3R6oZNArrhf4dkNrJkN6fOugUACSQmtuC5cI9sJqQy0atVlgbMLAcTtjTm+jiMBzWeChLwFKUZ936L6HKP/Un576d8p+S9LvGtxPT3SrITDTlYrtPhy+USjBPc2HqaZ6/hb/DJGGGMhIRbZ1qjCuN/VRtw13qOOMcxQKsys8p5Fj6dsT6GiG2wKX+Ek3I3YqV9K2RfwJse/TXeSc8QGOeVwh+4iwMUdAu3RJY1z1BlPKWiMDSVDET+glzBUQn0wIx/HRsa98IiFuWdbxq233wqex4EeMG7eU/P9A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(23010399003)(1800799024)(10070799003)(11063799006)(22082099003)(18002099003)(10067099003)(56012099006)(261102123227099003)(261021121427099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HNU+KQWnEP0EtZhNkgvvqT2R9oHpsauF/xQe/yeUBV4N5MSSWIkjUj7SFlGS?=
 =?us-ascii?Q?RAwdCtUA+dZ/jyXc7x+EUedc1iYUcr+TwiXPKaWj59ZJKH2bt5cqxAmLNdjt?=
 =?us-ascii?Q?/u31jK7/a3kJU7HGaWJ/rw4pcRMaItD0IkJ1BQUdBoeBsbEgN+NAgw1H8hsv?=
 =?us-ascii?Q?GD/NOR6LhwGEpM4LaWh8SrRO2KDZsAFxecaNZHu5RtkBiIPwqdoWARruHUXr?=
 =?us-ascii?Q?k5yJayrv4Q5Tin/oTn5EYAo7lzTUOgTyLlw6p47vcJ7qN/o1qpWzGK7yhUmJ?=
 =?us-ascii?Q?4CPPd1Q66MMvl52Gfk9Ns96EjPuh9UtfFPD2uHnQ1vdiT5uyIIQKfIL2o2C2?=
 =?us-ascii?Q?XtXzI4U3pF4DkpTcBvJv8ceF0b+kKkVktvX4tjB0zDYXm+602L/in/ZHGuUS?=
 =?us-ascii?Q?RSzX6Ev714UDjE/JYeuUBs6ZYrxfEc5+F4XgKXc+55WYShNNT4H2o27BC9S2?=
 =?us-ascii?Q?3Q2nJYP6mAzP0dFP4iAS5mvGeyHskovsF7ENqdSj+1L6Vrjf3dqhZiu+9PRO?=
 =?us-ascii?Q?55T3ypsFpcXkBEdRxUvuKKanZ9f2xHoBDpPeOSzbN4BTn5l+X5rru6FPBhyA?=
 =?us-ascii?Q?8S7sm9GoyLCa3DZ1NJZCj/CiPREY5RSSwCOknHD0lm4hN6dEEnvSRExlZsmF?=
 =?us-ascii?Q?7Ej0p53vqGca9QjozoV9E/59a+ib/Xg43CkNJC4fkGUAyxonbPUDzIGVSc/T?=
 =?us-ascii?Q?SjDQxCtct2w6z964W8wVTiJAxORU5KoCkXJCb8jldU96ilqnAYK+EztEKvc9?=
 =?us-ascii?Q?JgBWBT3m5IJm4jFQQfv18IyNGmUXVr0GeMf1vkgMvJIO4hTReFTYVd9/ewvV?=
 =?us-ascii?Q?qk+zawuTTU1wdn7oREaFJGY54MsXQHG2XWPOAR5EfX22mYi19uCwRH6qPUFK?=
 =?us-ascii?Q?Hpr4l4LVG8A1jg6zYEjkkItm8/BYSiqd7c0v9HNZVZn9if9z3Ibp28WIenAo?=
 =?us-ascii?Q?UY98tH1N+Pi7dLy7R/UW9NHfQJfNeZ5vGHYj30q3FLMfOyUxXm2ewqIrQ/G9?=
 =?us-ascii?Q?L+vbVn55tKdpYm461j+gj2lge831Djjs8jPxYwOcse3vgTe1DkQiVFFiWKzv?=
 =?us-ascii?Q?tU2xOVOeLYR01ai3Kk1BMwIHABW5Ma70m9b0KMvEmGmC5MPk0AzodEYaBhOy?=
 =?us-ascii?Q?m+a2t2mO58PyFpS7OIcXvypm3eXTMq6xpeO21V/we0irb2CxtymAcTSFcDSe?=
 =?us-ascii?Q?C2XlTKXX+nND8pcncNPQBE3kTC+XqQ96GDTz/+Oic2WX7kZReHZyEub6MrLw?=
 =?us-ascii?Q?UvQET9bSfCMWYbkls06bi1RQ8ezWsTV/2zQ37hq4pa2CKX2Se8ZYvnhWC5LM?=
 =?us-ascii?Q?mb4m4NRH2baKb7f+JMhyYzCgJ5egG5/hIexJR+rmUkg8q761AWLBvtBAz9MF?=
 =?us-ascii?Q?2XyRAgTlLaLSM2eTGfEgr59dIwg+LBobYKUekz2NTrasMIXU0I8tfNPqvxsE?=
 =?us-ascii?Q?zZfOUq5xC38Dh/tLnwjgeATAkKfFrjtbglsTV9s2g8Gb/CDwhtMemsnyuulV?=
 =?us-ascii?Q?6X1Jho5xxEF7feSUgjCJszAunSDh0rMFQeIxXP+IVO2uTMkA06IGDPHSo5HV?=
 =?us-ascii?Q?GsfwfLj/8S2mJ5IzXOxUCnZM/Zktmg1rMVmEHw86MkKQ8BYYVn2oIo0nWDwC?=
 =?us-ascii?Q?uhZ85izrgnKpUWJLECaOC2l6l+I7T/I0M+5BJ0O97nifp9pZD+rC+zQXLUU2?=
 =?us-ascii?Q?ToqJJOu8O6mx9hZX1OcvExzQ8TZhnLb6kBT8jaA8Kkujgd1bCtvwp5IkHnt8?=
 =?us-ascii?Q?NthyyPAhAlFYuti/ziqZQQx4GdO4GNUnras8CAxQEa3t3KbBrDqsHcVEsfz4?=
X-MS-Exchange-AntiSpam-MessageData-1: fkELpabPk3Y+L4Wg9vN7qikhQtv/Zaqu8cs=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56eb12b6-d244-4d12-916e-08df4c7a97ab
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 11:35:52.6208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 26NS5+BE8ZTBqyTPkUMQqaR+UuPZAP7HFe76mtUDQcavXU4QZW2Y2gtRse3brUZiZDeDutvpCYhXzMxm2GvDUS6cMEij+K2hcqj4UVc0am0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6425

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

