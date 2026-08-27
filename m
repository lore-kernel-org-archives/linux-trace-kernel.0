Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011061.outbound.protection.outlook.com [52.101.70.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F5313790B;
	Thu, 27 Aug 2026 07:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787815467; cv=fail; b=pIyYeGe8kYVf4kDLHfwrZBhZzU98+YZ1z09RoOSGIeSrscFiIpxkE2a29uA2Heb4OK23MEQrG/p/sLYjHZ/zwTxvmZtNbFSDHDqrgmJRqGXlOq1F9DcNgwsyXd5ZMfieLaYCc9vxrIp95mv1VYoq7Res6+qboLLsBy8c/AxoTGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787815467; c=relaxed/simple;
	bh=sGn5IngRTQCVmxcTM3LxLeRGJNIr5a00p0Fx6Ww1yww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WPGfLrVNQZFf2epxIRwDr6gvNoCIWXrJMiTag4w6Xs44dFa7OqqXj2eOJnH2GRn5qRP2ubaNIXNiggpLgPKF6nGPJeH4QKbTa4UtXmC5r2GUhpaYsi2kA5Dns4JztMpxzl9cHBad29yrJiJVpG7gDYZ7mLZrZ1Udc+dKaYZhDDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=lzcIW4YG; arc=fail smtp.client-ip=52.101.70.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="lzcIW4YG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wFvuKTIamLbPx/yVj8MWdf3lUh1DUSki6VzsbZGnd2L56/cReuZC53oZkoBs81032gmCm/pYDLFLwPqGqMlPQtv55rabGwO7B6ojdIuq1CIeJAM7qFiKU7XO70u8581niOx4cX+pPWrVmYjWqqpAaJ+F65IYLZ5EbzB8yC/GAXxihqe9sRVal7rdIbfKqVntmpegF8h5SYD/7gIU9bluECfE8SeufPekRfs7unD5UVWj/iTygWh3cpLa9PDTUuQETmAdVMZuCEVOzLQGyd5xQTa4mDQm/+djg7L/bHFdoNmXFAJJRfyEuG47Ajl+JHwVfugAVP80HdlH0iyceThZAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YVqO33XpiYY0gncD8uqn39VcoiFOU/lhwjBFZ6oaQaI=;
 b=kVkd7fxJNaI74hIa5wF0YonwIflsr4UET8ZWHLKZCsfciNTVSq3FFEL42mR3SQNZZ11DZ5DB0RlnHU7JbCXIbLWt6xP/U4US84UEkRQpVmEQHRcTlSbN/3N99CTr1ZnA0EbcLOeVKi+aG7UtnXM77KbHXlg5QiOmFbd774N8zJMnAAZg2ZTOmlMlxyQk9y2ruMA5c1O9dJhOa5Gw5OgOu56eukoe6d7MOZxRjCSFDZnQPbWA1hyZgFeGAHiS3YFZ2Co9vGKvVu58xbzuIjwGrwTPI9RjKd48syOHyzSxzsufTtbA2s1U82bcA/xb3z+BszPa0rAskIX6bELINBtiJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YVqO33XpiYY0gncD8uqn39VcoiFOU/lhwjBFZ6oaQaI=;
 b=lzcIW4YG+KLwPaZu+d0cXcVFmxoe8ifw9uZLY22cDSmtiwKHr4nyu7K92XKGY7MCe9tWs9IYCNfsyv3GiPRlGYYM4BwSnWBK71Qo5GkufASPNiOm1kveOjsggnnYzj66J12O7gUfjHC4Zytbq+4xSaaEzUxqYUupeoOKLJmp7z2dYtDIssjguj1x0InBWk21T+xZJeMMwRLf42ynsdageGffIgqpi/uW/gGgeXQbvzg9N1oh2XQ+w09gRhelhWG1Ram5duL7O5+w+9vwCFZUFENM5VCdxwiMt91Hp5joNEXtOEm3d/N6braiHHbErgAyPJhU1zUjGWcZWFwYDTc8xA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by GV1PR10MB8608.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 07:24:11 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%6]) with mapi id 15.21.0339.008; Thu, 27 Aug 2026
 07:24:11 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Philippe Gerum <rpm@xenomai.org>,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [RFC 3/3] rv: collect per-edge dwell time for per-cpu DA/HA monitors
Date: Thu, 27 Aug 2026 09:24:00 +0200
Message-ID: <20260827072400.45734-4-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827072400.45734-1-tobias.schaffner@siemens.com>
References: <20260827072400.45734-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0071.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::7) To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|GV1PR10MB8608:EE_
X-MS-Office365-Filtering-Correlation-Id: abeafbad-58a6-448b-798f-08df040c3055
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|10070799003|366016|6133799003|10067099003|56012099006|11063799006|55112099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	hAVNQSd3AsPZ2vCGxo5KUUXsk3FuNDb/YJ3eLMA01/OEfVBZx4oKi6lnB25c6+9dcXKrjzwH/HdVuVdhikpLXX20N6bzzXf/5YKkAHV2Lh/cOFNszny1YNffOVXNILaiLr4ioo4Jj50AhGc4x3XcnAZJeLqZlTx4zs6D1knM7haLIdENxf8qlFg6OT/cbBLj2XxsNH/YkL72PF2hRkJJ4O9ZTp5BfU0iCuKKLP4rRsT2eSVGEwdQxXY8VvS8gQVOJaPVtHjba/SYU6BH/zGu3MyWqrgd5QW5rSIAzWee0wx3+wv6GNidKBAsYLLRuClJmhhz2DMpN7Koo0XZjRbQrsiHDhhSrgca2ETNLnWdSsJUAI7kkQv+1R9qAgQtP8eGnfb+T0h5ZJB3/TMCL9VIXmjBVTb+FytmXQuFYxdsf1n+a6HhWS/BuSnnvDZLHXyA2zX+3pzgAFWcJ1DH4mQ0vYgccDr9LAZUWc0Mmzrc7gHGcioLJdBv3Zl3lZqMUMpP0wnEBIDTA+qBPvQ/VFd4LxrYB72fIKFuqW3tSHs/coJ3rQngTm/A/Kx6/sBaElQaPin6yeX45p0E4JrNaIOnSVtUE+nRxTR5GK/S013cYdZFIuOh3C/FWJLPYVblNXIvNOwP8ajX6mU+hTrDOmg9yEp1wtZdSlxNXjVMOv6t+bE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(10070799003)(366016)(6133799003)(10067099003)(56012099006)(11063799006)(55112099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9WacdKKDkOxvjM64p0UuutjrvOXzJ8hk2y/hB3p/tmMzVcuXj+LPpg1PSEX0?=
 =?us-ascii?Q?RdvnmGJ5b2F40JIhYD89zpf8M+cMo4aSUQ9Zd4iEjuIWTk10QPyPVUgatmjg?=
 =?us-ascii?Q?4yjz7fOMkXHG65mmsK77P86T8AuwDhnZ/cBULFm48GPUFi0jxY+6zRVXyh45?=
 =?us-ascii?Q?MDcTA5lxTcQSB65XFtIgvS2nWIQXfJKgrrYgQEzwslMZN0AgGREo72EFcnbT?=
 =?us-ascii?Q?+DzPDa3a1LttlDs50NLlnkLoRaEI0mjsAK1NSvcNzpWyZziGkMomDiCtATO/?=
 =?us-ascii?Q?D9YOWYdsK7NX0q7gz0Og6zkzYr25oDldS4pp4+nJfDAzOrDajeyIrJCBFO3V?=
 =?us-ascii?Q?0xp8S/I+uDASOAh/jKkfctpaJUWD0p4tV/Xp/11nv432ZdEwn8PIKzmXmk1Z?=
 =?us-ascii?Q?W7CHhc4hIjXB6ruZO/wKefmlMmzRw2F9MYpuseGLWul5xAlb42FgIjM0gEMd?=
 =?us-ascii?Q?SL2OtSv4BPYA22aRt9a2XU3pV7aOpXUrNxrp2lGKq4nxPjCbywPlIqcvbhtR?=
 =?us-ascii?Q?ZLfkcf69bUEI8KyQkB2kaT2x6sngODJAoDjDzrFeQPfYcU2sexxe4hdni7ln?=
 =?us-ascii?Q?BfkPTe91btFZiBRar14yc9GLiXyKe5AhVHhOzJN7aklIG70vu5xvpgz2A5Hc?=
 =?us-ascii?Q?SNXFbO9isHnbLFYlpk4exrfA6C66GN2+W+9bZlWEaSbC0e+RZcgXpa7TlIRo?=
 =?us-ascii?Q?K3MOB0D89l6oKZSKnyp4GdFUpNe7n7ozK3m0Mbek8aFdtJKQXM0VTV0V/oH9?=
 =?us-ascii?Q?xzkPdgYaj0I8Uh5mecW4tE38tcfE1EzQtKP/zSilq77IJOpDqBSAAuRBV7zv?=
 =?us-ascii?Q?MgqkX4aLOxE0ddf3+FTZizDBJ4lqRnUHZPqW4tBRsFwFbA459RlSvPApp8nE?=
 =?us-ascii?Q?Hsz+To0egKelvJqaSTfTg70ST/OWpBheTxeG+nq5sQ9UzZ8U/wypix0DdnCR?=
 =?us-ascii?Q?nsA6zi7GfqsYB3wJvyTnPzqV5qG84oYiI0Phy20awsU9ZsXipQByFNFK6iNY?=
 =?us-ascii?Q?Siaa2qLUE1qOLCU+dTrpdbTHFOKhzenK+ECGYGkHFUKFI/9tQ/ijWO87Ed5y?=
 =?us-ascii?Q?oqnuDnBASpTS4RaHWQewPTCoOJqfcXKg6Dp7AyGFRDfNGC/AMlZGz8nBSg+r?=
 =?us-ascii?Q?5OzbjY4kLKhjZZjLIGkhea1jlrdGwpM3JP1uSqusEaeS9cuNeqXmPaOWB5Y7?=
 =?us-ascii?Q?Rg5fikeBCGWUHrSGHfJscLCavzNrBnSSYeF9mpPURmBxOvl3L+wvU6v1yfEl?=
 =?us-ascii?Q?X/Tj2X2nqMn+70M+VoT9KyQ6zix6SbnUV3XYIOHwYq//gmUkQZVMfuZtrG4k?=
 =?us-ascii?Q?PfoLmv0jHexCZzqmg2PDkLygZppiXQyPHUW8dg+ZrBCRxkYm7OJLYyDXK/5L?=
 =?us-ascii?Q?R7GQii1zW3DTJhkmqfO/BUDcJR8iqLSsvoXzuF24Gwmiuf8m0T6HWOiWBxFm?=
 =?us-ascii?Q?2MM6RJ8BELLMjlfJHSYMkw+RXJu/opy85C0mtLAr7FDcccmMmFyaC7S52Uc1?=
 =?us-ascii?Q?a6pd9nPwNTRnRamIKCgMyIhAwRYA8FCikWXVgKSnc552IvFfX4nIlfxlW23F?=
 =?us-ascii?Q?7i+6Qy7Qn9v8lp6olm/0HH4lCx3D78X6XaObfPik8FVSTQhRsApipTP6SYEj?=
 =?us-ascii?Q?Bk0qAEVnQCrzQd2C/8dTacJutuZGU4h0tmCP6ui6JYiQn4ZJTnfg5nV98sVK?=
 =?us-ascii?Q?Hzt90oH8jGsIYnaIZIgYV2SkttjKnDIXVNjK8Hg2VYcGzzGOwBOIYYXuWuk2?=
 =?us-ascii?Q?b/Xmh3NAHtp+VER+Rigw/R3SmGv+wCGsKFd6dh8cyoNEm7OVZercoESDZkVK?=
X-MS-Exchange-AntiSpam-MessageData-1: KC8cu/0T45EdLUbXUOkvmwm4V4m8QBTqCxw=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abeafbad-58a6-448b-798f-08df040c3055
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 07:24:10.9855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lek9uBzbsaa+ZmfXcqG5JmVKHI9NE2gUh/pNX2AGj+NLegxwXQFyG+DZx4RF9QbuIoRnQ9bdti7pYubMSErxjc2j8+kiBuyoU2CFPhDizAE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8608

With the core facility in place, hook it into the DA/HA layer so that any
per-cpu automaton monitor also reports how long it lingers in each state.

Add a selftest that enables a per-cpu monitor, checks the stats file
appears and is populated under load, and skips cleanly otherwise.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 include/linux/rv.h                            |  4 ++
 include/rv/da_monitor.h                       | 53 +++++++++++++++++++
 tools/testing/selftests/verification/config   |  1 +
 .../verification/test.d/rv_edge_stats.tc      | 32 +++++++++++
 4 files changed, 90 insertions(+)
 create mode 100644 tools/testing/selftests/verification/test.d/rv_edge_stats.tc

diff --git a/include/linux/rv.h b/include/linux/rv.h
index 7eeecce17e50..09363f79ca90 100644
--- a/include/linux/rv.h
+++ b/include/linux/rv.h
@@ -27,6 +27,10 @@
 struct da_monitor {
 	bool		monitoring;
 	unsigned int	curr_state;
+#ifdef CONFIG_RV_EDGE_STAT
+	/* local_clock() ns when curr_state was entered; 0 = not yet stamped. */
+	u64		state_ns;
+#endif
 };
 
 #ifdef CONFIG_RV_LTL_MONITOR
diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
index 34b8fba9ecd4..59ca9a286c10 100644
--- a/include/rv/da_monitor.h
+++ b/include/rv/da_monitor.h
@@ -16,6 +16,8 @@
 
 #include <rv/automata.h>
 #include <linux/rv.h>
+#include <linux/rv_edge_stat.h>
+#include <linux/sched/clock.h>
 #include <linux/stringify.h>
 #include <linux/bug.h>
 #include <linux/sched.h>
@@ -30,6 +32,54 @@
 
 static struct rv_monitor rv_this;
 
+/* per-edge dwell statistics, wired up for per-cpu monitors. */
+#if defined(CONFIG_RV_EDGE_STAT) && RV_MON_TYPE == RV_MON_PER_CPU
+static void
+rv_this_edge_name(unsigned int edge, char *buf, size_t len)
+{
+	snprintf(buf, len, "%s:%s", model_get_state_name(edge / EVENT_MAX),
+		 model_get_event_name(edge % EVENT_MAX));
+}
+
+static const struct rv_edge_cfg rv_this_edge_cfg = {
+	.n_edges   = STATE_MAX * EVENT_MAX,
+	.edge_name = rv_this_edge_name,
+};
+
+/* Hand the model's edge descriptor to the core; called from da_monitor_init(). */
+static inline void rv_edge_bind(void)
+{
+	rv_this.edge_cfg = &rv_this_edge_cfg;
+}
+
+/* Stamp the moment a state is entered, so its dwell can be timed on exit. */
+static __always_inline void rv_da_edge_enter(struct da_monitor *da_mon)
+{
+	da_mon->state_ns = local_clock();
+}
+
+/* Account the dwell in @curr, then stamp entry into the next state. */
+static __always_inline void
+rv_da_edge_account(struct da_monitor *da_mon, enum states curr, enum events ev)
+{
+	u64 now = local_clock();
+	u64 prev = da_mon->state_ns;
+
+	da_mon->state_ns = now;
+	/*
+	 * local_clock() is not guaranteed monotonic; drop the sample if it did
+	 * not advance so a backward step cannot underflow into a bogus dwell.
+	 */
+	if (rv_this.edge_pcpu && prev && now > prev)
+		rv_edge_account(&rv_this, curr * EVENT_MAX + ev, now - prev);
+}
+#else
+static inline void rv_edge_bind(void) { }
+static inline void rv_da_edge_enter(struct da_monitor *da_mon) { }
+static inline void
+rv_da_edge_account(struct da_monitor *da_mon, enum states curr, enum events ev) { }
+#endif /* CONFIG_RV_EDGE_STAT && RV_MON_PER_CPU */
+
 /*
  * Hook to allow the implementation of hybrid automata: define it with a
  * function that takes curr_state, event and next_state and returns true if the
@@ -113,6 +163,7 @@ static inline void da_monitor_reset(struct da_monitor *da_mon)
 static inline void da_monitor_start(struct da_monitor *da_mon)
 {
 	da_mon->curr_state = model_get_initial_state();
+	rv_da_edge_enter(da_mon);
 	da_monitor_init_hook(da_mon);
 	/* Pairs with smp_load_acquire in da_monitoring(). */
 	smp_store_release(&da_mon->monitoring, 1);
@@ -275,6 +326,7 @@ static inline void da_monitor_reset_state_all(void)
  */
 static inline int da_monitor_init(void)
 {
+	rv_edge_bind();
 	da_monitor_reset_state_all();
 	return 0;
 }
@@ -696,6 +748,7 @@ static inline bool da_event(struct da_monitor *da_mon, enum events event, da_id_
 		if (likely(try_cmpxchg(&da_mon->curr_state, &curr_state, next_state))) {
 			if (!da_monitor_event_hook(da_mon, curr_state, event, next_state, id))
 				return false;
+			rv_da_edge_account(da_mon, curr_state, event);
 			da_trace_event(da_mon, model_get_state_name(curr_state),
 				       model_get_event_name(event),
 				       model_get_state_name(next_state),
diff --git a/tools/testing/selftests/verification/config b/tools/testing/selftests/verification/config
index 43072c1c38f4..de229777d5c8 100644
--- a/tools/testing/selftests/verification/config
+++ b/tools/testing/selftests/verification/config
@@ -1 +1,2 @@
 CONFIG_RV=y
+CONFIG_RV_EDGE_STAT=y
diff --git a/tools/testing/selftests/verification/test.d/rv_edge_stats.tc b/tools/testing/selftests/verification/test.d/rv_edge_stats.tc
new file mode 100644
index 000000000000..5fb2384d938c
--- /dev/null
+++ b/tools/testing/selftests/verification/test.d/rv_edge_stats.tc
@@ -0,0 +1,32 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# description: Test per-edge dwell-time statistics (stats)
+
+MON=wip
+
+check_requires "$MON:monitor"
+
+# The "stats" file is created on first enable; if it is still missing the
+# kernel was built without CONFIG_RV_EDGE_STAT, so skip.
+echo 1 > "monitors/$MON/enable"
+if [ ! -e "monitors/$MON/stats" ]; then
+	echo 0 > "monitors/$MON/enable"
+	echo "CONFIG_RV_EDGE_STAT is not enabled."
+	exit_unsupported
+fi
+
+# The first line is the column header; the body has one line per (cpu, edge).
+head -n1 "monitors/$MON/stats" | grep -q "^# cpu edge label count max_ns sum_ns"
+[ "$(grep -cvE '^#' "monitors/$MON/stats")" -gt 0 ]
+
+# Drive some scheduler activity so the automaton records transitions.
+for _ in 1 2 3 4 5 6 7 8 9 10; do
+	(true) &
+	wait
+done
+
+# At least one edge must now show a non-zero count, with sum_ns >= max_ns > 0.
+grep -vE '^#' "monitors/$MON/stats" | \
+	awk '$4 > 0 && $5 > 0 && $6 >= $5 { hit = 1 } END { exit !hit }'
+
+echo 0 > "monitors/$MON/enable"
-- 
2.43.0

