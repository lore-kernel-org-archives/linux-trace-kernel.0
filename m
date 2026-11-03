Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.95.113
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793673903;
	b=UuqsAiDCMSO1Xn9MKQubR46UxLp9686oNDSCIQ672hh7YicPNRUljaHtzGnmMDImXHsg
	 YYN8fDakvNzBE2CrSYfcJ5AWgKM4iNA043+CZJyxR1339VFMcwB/4PNeNONd3dMNzePbd
	 3u5TN9TF003oKTqC5kcUE+HT0in0Ros2SV/ztSDh8HAl3n9sH0MNryeksptuVxnXlgjnd
	 /182lbci7CcVkjeRvlrQvdfgjcTVqHOoED2T+MwJ1ccMEPBbEGlg01Cp8sJIntumJI5y8
	 7/oz6ECmoBLcwTF9m7viZeaYEncSgvgo0P85g6Sd7oztLG8ty8xH8jOpyVpuYSvhd3g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793673903;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:Content-Transfer-Encoding:
	 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=j2PzMKclJ0XXRtE8rhnZiT/fJmdBjVtkmRUeMkoGe1o=;
	b=lY7FuWhPG9SoNJwQ5D5knFZ/Ied2BUMxH/k51QkMDjdEyVdY5SbRuIGWIrxmOB5vB4+2
	 OvuOEc3JgZ7hLG0FMG2J775oXaVtj4yAJWCV9OJtbc4H0Xg67muJZ4XVuD4jO2MVr7NUl
	 H15eVzYGPGHCWeyINbp2wVoXwlas9nTV5lo2Vo+CNp6ScWPZGcuFAVMXpVsW/3Gpp8/UP
	 efIlWFlDqTufN1K+3Sd29SlpeYgpMxqU0bNzj1PJR1C56Ski5eG5OvmkdQ+C2aLWMIBZv
	 Efmb15PPCHrpyi37kOZD/k5Ab7e728J/WPn3ayl6R+TrXSlEKivJ+HH9dBtyuq37COw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=atomlin.com;
	spf=pass smtp.mailfrom=atomlin.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.95.113
Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021113.outbound.protection.outlook.com [52.101.95.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6B5606A32E;
	Tue,  3 Nov 2026 02:45:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC6B5606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RLgNaDJfLbPKbrknciQlJHtQSBuwl53EQEOmCwnqZWaFY8eJpbF0sFllRb/6XGuQHW8JRMFQQhGrgYUYFqwCAGVusavMVzXNyW5MfYvLCISXNbtoUpGiMGsKDW/Chl7IC446oQh/pvDz7CR+AlWZvWn1La3oC/1jyCpMg5LMFUsz09xWG3U4/cUZlf4tDUkH3Y6DBx5hy+xW18O/wGzAJc8kLi5s2XtmXhhjO8s96eUiKM++2DK9V7GSRWxWBpzS6oaPnXWKc0qlbsPAJHBF60Ke/7NR8UXUpvSt1Y7FN8J+NsuToAGCxgJs6XPx4cRjz4j/ihH0VOYM36nvNC3iVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=j2PzMKclJ0XXRtE8rhnZiT/fJmdBjVtkmRUeMkoGe1o=;
 b=jSSrn+aSALN396aeUl93CwFDNAI1GW5TPjDFLzXuGXBrCojzJDjcG0yJ+HaHOqS14ISMRXwI04JPyww07CqnGa8uXf4GdMb2Z3Ust51lgAAAGJQuIh+LH0oADYDa52Dit0VeKvQOYGvWoyvjbXD/NctF0N6QpPDJeq5uuuBoSqJr0KHK27Uwor/JNllb6E9ruOtpd8Qu0kJ2Rszigx0gEHXUU01vRV3aRfMiAUnRbslqvVYMW8Omb/aGZD9sOavMwO9UKkK7qLRxGyIWfgkqIxQydeP6LSH0G7fmHV0DARMy83UJhXZERiTdYZIH8A+lt/jeRipdUIVNMRMWbvNUVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:163::8)
 by LO2P123MB6972.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:31d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 02:45:00 +0000
Received: from LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f71f:a9f:c4de:687a]) by LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f71f:a9f:c4de:687a%5]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 02:45:00 +0000
From: Aaron Tomlin <atomlin@atomlin.com>
To: pmladek@suse.com,
	john.ogness@linutronix.de,
	rostedt@goodmis.org,
	senozhatsky@chromium.org,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	kprateek.nayak@amd.com,
	akpm@linux-foundation.org,
	baoquan.he@linux.dev,
	rppt@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	ruirui.yang@linux.dev,
	david@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	kees@kernel.org,
	anna-maria@linutronix.de,
	frederic@kernel.org,
	tglx@kernel.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	brendan.jackman@linux.dev,
	hannes@cmpxchg.org,
	ziy@nvidia.com,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org
Cc: linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: [RFC PATCH v2 1/5] panic, sys_info: Fix duplicate and dropped all-CPU backtraces in panic
Date: Mon,  2 Nov 2026 21:44:49 -0500
Message-ID: <20261103024453.922373-2-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261103024453.922373-1-atomlin@atomlin.com>
References: <20261103024453.922373-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN8PR04CA0066.namprd04.prod.outlook.com
 (2603:10b6:408:d4::40) To LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:163::8)
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
X-MS-TrafficTypeDiagnostic: LO2P123MB4190:EE_|LO2P123MB6972:EE_
X-MS-Office365-Filtering-Correlation-Id: f1f62944-3cfd-4731-5407-08df39547478
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|7416014|376014|1800799024|6133799003|10067099003|22082099003|261102123227099003|18002099003|261102130727099003|921020|56012099006|5023799004|261026140227099003|261022105027099003|261021121427099003|261021123027099003|261022075727099003|261026121527099003|261009223027099003|261028144727099003|261021135927099003;
X-Microsoft-Antispam-Message-Info:
	DEEsuFzEaAIPMEIC59UGqHjLCniHLOC0ny/ExPwmC4p8xvIGuUTG+kyGMDlxfSJpGiSkHxQvpkUFxdYYlLNr5nYPrzxFHKgCE2NVzRWmC96LncgucyQWT7GbT1RUMnH3JBlwKRJRQb755FQBZyYqAbiLy/DkRy58+FhxPzT1MdINAVyolkgWCGdT6NBr/2f0R6I+sk1zwJ1Ha5pilCUnjUB7uUELYG9vrObZPD5bHbxEiMCL0UZrG98mBx7TvFvOgLzJ2xnWfSlr47y6Qr5n3NeCepfraVHydSLit4yEHoANCRJbEQ4dAqrYmV4qyb8udl2BbhP9GiuyuWp1l8aPtLl3cOyL49kE9l5am2vzY3VJwNgbePK9TDV8Mdhl3sBe4EVXjbxl6lfoAVO8at+NyhsoQJvxe6rx9YN6vqD5764f4fQ0iKMR8mEbeoBfOOyBgmAky1rVIOaZ+UID/h28CGeOFiTH2jnfsGhuVzVHmwTnOgm36Pj2us1xnf00twlfPC0leBzM7+O431mO7rg/zE07oh8ATNTXvKce4I4vfumTBwVZrTkKU26zr5x2OLWylIxAYBr+mbUlqNY5dEC3eiUtIShGLzjwx44BxYBuIIojEjlvK05y1MhpnvAuwgKdAqJn0Yr4kYulYjlAEqGr6v0dAjNEnBXThYvvPuVboqrkT2qQr+fISoGP2Ovpyj5jAh1MVqa1dfCvdBZYkPf3IQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(6133799003)(10067099003)(22082099003)(261102123227099003)(18002099003)(261102130727099003)(921020)(56012099006)(5023799004)(261026140227099003)(261022105027099003)(261021121427099003)(261021123027099003)(261022075727099003)(261026121527099003)(261009223027099003)(261028144727099003)(261021135927099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bu+rvqO3I51fLboa/uhLhKXgVxpP3g6ZKzHeUKAbzBACr7PI157grrvBIxEv?=
 =?us-ascii?Q?GmVlXuMu21o5Jeq/gyS7LiBZrt58oc9dR7nMUEaNa65MfIyCnSi0MA89eDUU?=
 =?us-ascii?Q?O+EWA2n3ow7d3Tf+4YG5PiKO04azoeIQdLdCEvx40AwNqRmApGxKjmbzzUNm?=
 =?us-ascii?Q?LttsaiiELtR6xj+IEAe3PLW7JqHdpfcz8IwmKGur5zXNdNo83DZuf4Bc7rCx?=
 =?us-ascii?Q?Q0+Pm14iMHt01Zg/dsqULBIWYMwDFRKrgNAbGk66EeaiF1C8rla/PJGCbIae?=
 =?us-ascii?Q?ZikJg4XZkVJDCXoaoGPdfxFDC/oMAbpxKD5NGcc31rh3nxT+alM8MSyE0dTJ?=
 =?us-ascii?Q?7hKU40hBSrdxKJQvgcw9g803TZowQz4DEyguSlHA1Dnsnj02RUUGbXZmx1oi?=
 =?us-ascii?Q?08rLLtLyapk0pojabQu1YxhtkOsJPAjo7z+jx07WinP1q3mQAlWySMtZZVeK?=
 =?us-ascii?Q?/H7kecDGYrSqOwY7jd88TM/dKpQyLZrFt20c7HzOxfMW2J5tvHEsF0uUOT1a?=
 =?us-ascii?Q?2/C9sFIFD/SwMGUfNYSGv6tZeLPiGxEYf/0nGREtOWEDgT1eVPb7RLmvvDlo?=
 =?us-ascii?Q?VCKSCoXsCRW1257auPG/l+wvIUQMmySQVvx6hsfdfUaUpa6QM3fm8nTlAc23?=
 =?us-ascii?Q?4wlJhzEujFJ/qMR4AnZGUxlNk7x9LuCK/U0BxXHH4VPJY8Y1fMt74P3Z11s1?=
 =?us-ascii?Q?yNd08hby+aYYsKjtrvPXI1j4RV0+2QI64J+TtoMC43bBLl6WbS3StIVHAdEk?=
 =?us-ascii?Q?OlnG+12lvD+CRACsVpMt7Gfn15mmDpnAQ/t2ZUFXTU4yDmORlyE7Tq2B5dHW?=
 =?us-ascii?Q?4wcYQcnA/DlkKWce5oDAlnWaHO+aT0TLsPetUfpfNn2f60u2Z4mgLBbASHc0?=
 =?us-ascii?Q?4i0wKtqHHUc6P01vXe5QySUaYeIcgPPQMe+0MXuzDBps4h3jc/QV6nzWW0Oh?=
 =?us-ascii?Q?bXojOMvKGQn2Ll0kDrXA+k598/5MLt6TMLQeOqKdGqWFTJwlQpRtZliM/qbh?=
 =?us-ascii?Q?QSP3V7cgap6fMbSDjNd3rKjWUvUSUjoI8T4Dihuy1NGcsrN9cD6409CJSD1O?=
 =?us-ascii?Q?lqHobJd3RqNueabi0dYm+uUrlmwI2Lokw6XVR/0LrypypJ76Oht0aotkRJMX?=
 =?us-ascii?Q?63zOWNdKGNggPae0CsSqPRL2zHZc2nK50LhcHxgm77mCrNSu5OT+xMk2seV3?=
 =?us-ascii?Q?G4JZ9vQNydmpl2UisxPgWWVUAfcBBbzxkWHVVj9LlvXvJRWIIMtXs0SFTXqt?=
 =?us-ascii?Q?fsX5WakncsEGPpcFcjizWtCOdZafihsdoNVS4R6Xf1rXGWivH/6fvzsms7Nb?=
 =?us-ascii?Q?ZFXNXMoXd94tz58tt5Kz1KBDLodKOQgBic8yx9NpMXvkJqiYA9jmol/MqYcp?=
 =?us-ascii?Q?+hohjBIXAnkmxE6Z/xQWnY9WLUya1fuYgACldiwHV2wOuxcTKCxDIBCAVuGx?=
 =?us-ascii?Q?/0JrsMUeaIOFXv2JHejxYS/ueLa32v+G1uxVPzJ5cvbg97cLsnm/0OQujgLy?=
 =?us-ascii?Q?br0dlje9qUtel5+oLK966cx1anOpanYkhgh2dRKCK+V+tb0G0qkWcvqTIgEB?=
 =?us-ascii?Q?rfiDvyyYdbUSWisoa61iZhUMEU7Geap2fXroCrd18gQuIAjvK9hkF4BPni6K?=
 =?us-ascii?Q?a0AMfaYqzP3VVQJiUwBhgME5jDPycyduCHIo/uwN1ymXeKMckcknhOKDp8ih?=
 =?us-ascii?Q?MgIOmph//Wih5zWQhEXsA7OxEPse8tRxPERF1d0gDsacLYG4+kKlCZfE8+Jj?=
 =?us-ascii?Q?0kDAXGkh2Q=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1f62944-3cfd-4731-5407-08df39547478
X-MS-Exchange-CrossTenant-AuthSource: LO2P123MB4190.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 02:45:00.5994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: snS+TJ8ZAX+FWrsGp79hOQY3IBrFLpSVtXF6jzdwv9K5gkFMQxgsuE6flNqpPN/vH2kcvIxLXs3bsqSrxKdQRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P123MB6972

When sys_info() was factored out of kernel/panic.c by
commit b76e89e50fc3 ("panic: generalize panic_print's function to show
sys info"), __sys_info() gained an unconditional call to
trigger_all_cpu_backtrace() when SYS_INFO_ALL_BT is set, while
panic_other_cpus_shutdown() retained its own call to
panic_trigger_all_cpu_backtrace().

This causes two problems during a kernel panic:

    1.  vpanic() invokes panic_trigger_all_cpu_backtrace() inside
        panic_other_cpus_shutdown() before stopping secondary CPUs, and
        then invokes trigger_all_cpu_backtrace() a second time inside
        sys_info(panic_print) after secondary CPUs have already been
        shut down, stalling for up to 10 seconds waiting for offline
        CPUs to respond to NMIs. Furthermore, if SYS_INFO_ALL_BT is
        configured via the kernel.kernel_sys_info sysctl rather than
        panic_print, panic_other_cpus_shutdown() misses it prior to CPU
        shutdown.

    2.  If sys_info(SYS_INFO_ALL_BT) is invoked on the panicking CPU
        prior to panic_other_cpus_shutdown(), calling
        trigger_all_cpu_backtrace() directly bypasses
        panic_trigger_all_cpu_backtrace() and leaves
        panic_triggering_all_cpu_backtrace unset. Because panic_cpu is
        already active, vprintk_emit() silently drops all NMI backtrace
        messages originating from non-panic CPUs.

Export panic_trigger_all_cpu_backtrace() with a panic_on_this_cpu() and
one-shot guard so all-CPU backtraces are only emitted once before
secondary CPUs are stopped, consult sys_info_get_mask(panic_print) in
panic_other_cpus_shutdown(), record prior Oops stack dumps in
panic_try_start(), and route SYS_INFO_ALL_BT in __sys_info()
through panic_trigger_all_cpu_backtrace() on the panicking CPU.

Fixes: b76e89e50fc3 ("panic: generalize panic_print's function to show sys info")
Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 include/linux/panic.h    |  1 +
 include/linux/sys_info.h |  1 +
 kernel/panic.c           | 31 +++++++++++++++++++++++++++----
 lib/sys_info.c           | 17 ++++++++++++++---
 4 files changed, 43 insertions(+), 7 deletions(-)

diff --git a/include/linux/panic.h b/include/linux/panic.h
index 17e61b61c45f..3b56f873f1e2 100644
--- a/include/linux/panic.h
+++ b/include/linux/panic.h
@@ -57,6 +57,7 @@ void panic_reset(void);
 bool panic_in_progress(void);
 bool panic_on_this_cpu(void);
 bool panic_on_other_cpu(void);
+void panic_trigger_all_cpu_backtrace(void);
 
 /*
  * Only to be used by arch init code. If the user over-wrote the default
diff --git a/include/linux/sys_info.h b/include/linux/sys_info.h
index a5bc3ea3d44b..e7699b82aa49 100644
--- a/include/linux/sys_info.h
+++ b/include/linux/sys_info.h
@@ -18,6 +18,7 @@
 #define SYS_INFO_BLOCKED_TASKS		0x00000080
 
 void sys_info(unsigned long si_mask);
+unsigned long sys_info_get_mask(unsigned long si_mask);
 unsigned long sys_info_parse_param(char *str);
 
 #ifdef CONFIG_SYSCTL
diff --git a/kernel/panic.c b/kernel/panic.c
index 574ee5a12f92..4cb26914b2af 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -70,6 +70,7 @@ static bool panic_console_replay;
 
 bool panic_triggering_all_cpu_backtrace;
 static bool panic_this_cpu_backtrace_printed;
+static bool panic_all_cpu_backtrace_printed;
 
 int panic_timeout = CONFIG_PANIC_TIMEOUT;
 EXPORT_SYMBOL_GPL(panic_timeout);
@@ -451,13 +452,21 @@ bool panic_try_start(void)
 	old_cpu = PANIC_CPU_INVALID;
 	this_cpu = raw_smp_processor_id();
 
-	return atomic_try_cmpxchg(&panic_cpu, &old_cpu, this_cpu);
+	if (!atomic_try_cmpxchg(&panic_cpu, &old_cpu, this_cpu))
+		return false;
+
+	if (atomic_read(&panic_redirect_cpu) == PANIC_CPU_INVALID &&
+	    (test_taint(TAINT_DIE) || oops_in_progress))
+		panic_this_cpu_backtrace_printed = true;
+
+	return true;
 }
 EXPORT_SYMBOL(panic_try_start);
 
 void panic_reset(void)
 {
-	atomic_set(&panic_cpu, PANIC_CPU_INVALID);
+	panic_this_cpu_backtrace_printed = false;
+	atomic_set_release(&panic_cpu, PANIC_CPU_INVALID);
 }
 EXPORT_SYMBOL(panic_reset);
 
@@ -538,8 +547,21 @@ void check_panic_on_warn(const char *origin)
 		      origin, limit);
 }
 
-static void panic_trigger_all_cpu_backtrace(void)
+/**
+ * panic_trigger_all_cpu_backtrace - trigger NMI backtraces on all CPUs once
+ *
+ * Temporarily permit non-panic CPUs to emit messages into the printk ring
+ * buffer while capturing all-CPU backtraces during a panic. Subsequent calls
+ * are ignored so backtraces are not re-triggered after secondary CPUs have
+ * been shut down.
+ */
+void panic_trigger_all_cpu_backtrace(void)
 {
+	if (!panic_on_this_cpu() || panic_all_cpu_backtrace_printed)
+		return;
+
+	panic_all_cpu_backtrace_printed = true;
+
 	/* Temporary allow non-panic CPUs to write their backtraces. */
 	panic_triggering_all_cpu_backtrace = true;
 
@@ -558,8 +580,9 @@ static void panic_trigger_all_cpu_backtrace(void)
  */
 static void panic_other_cpus_shutdown(bool crash_kexec)
 {
-	if (panic_print & SYS_INFO_ALL_BT)
+	if (sys_info_get_mask(panic_print) & SYS_INFO_ALL_BT)
 		panic_trigger_all_cpu_backtrace();
+	panic_all_cpu_backtrace_printed = true;
 
 	/*
 	 * Note that smp_send_stop() is the usual SMP shutdown function,
diff --git a/lib/sys_info.c b/lib/sys_info.c
index f32a06ec9ed4..496893eb776b 100644
--- a/lib/sys_info.c
+++ b/lib/sys_info.c
@@ -7,6 +7,7 @@
 #include <linux/kernel.h>
 #include <linux/ftrace.h>
 #include <linux/nmi.h>
+#include <linux/panic.h>
 #include <linux/sched/debug.h>
 #include <linux/string.h>
 #include <linux/sysctl.h>
@@ -153,14 +154,24 @@ static void __sys_info(unsigned long si_mask)
 	if (si_mask & SYS_INFO_FTRACE)
 		ftrace_dump(DUMP_ALL);
 
-	if (si_mask & SYS_INFO_ALL_BT)
-		trigger_all_cpu_backtrace();
+	if (si_mask & SYS_INFO_ALL_BT) {
+		if (panic_on_this_cpu())
+			panic_trigger_all_cpu_backtrace();
+		else if (!panic_in_progress())
+			trigger_all_cpu_backtrace();
+	}
 
 	if (si_mask & SYS_INFO_BLOCKED_TASKS)
 		show_state_filter(TASK_UNINTERRUPTIBLE);
 }
 
+unsigned long sys_info_get_mask(unsigned long si_mask)
+{
+	return (si_mask & ~SYS_INFO_PANIC_CONSOLE_REPLAY) ? :
+		READ_ONCE(kernel_si_mask);
+}
+
 void sys_info(unsigned long si_mask)
 {
-	__sys_info(si_mask ? : kernel_si_mask);
+	__sys_info(sys_info_get_mask(si_mask));
 }
-- 
2.55.0

