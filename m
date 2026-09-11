Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011017.outbound.protection.outlook.com [40.107.130.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9F64766AB;
	Fri, 11 Sep 2026 12:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789130133; cv=fail; b=ix+0up5ewgB8l/7Q6ckJ4enMkP9MWyaioqJAUrU58j4cx6sDWIRY53K7Xu8FUcRFLvH7/7x5zrnip25913cYMqNu8wOYD5gQ3Lj0Nwb1WoiNPt6zSObSnErzSTuHYXEJkl0comX7b+vq3k7P7cmUrz+6VVDniSPxv2WKtWTLAeA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789130133; c=relaxed/simple;
	bh=IpL5O1JQA4Hi/xf8TdDdp5TqcQDx+zKoTy/S3TnJsPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CoviuinWdYyRXXSoI7tBeJP8KNN21frYd8UoN5IKWlahXEPMDypHEe14OrXfg+E40BHR1Zil/xVH0lI0PjiRyGPJpCJkBfhKEYlhOt87xR6epr61PEa6ia7WyvVNBYQCs+F5V7BlCXPfzSonv3c0Fz/C/AWR2a+igLWGsy1jckY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=DHNgNtqd; arc=fail smtp.client-ip=40.107.130.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="DHNgNtqd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IebD7eDqglX4tBXQtGyCNY78K4u0F3sozgR0wV7BhNlvL6G9Bd7CjFAKCt95vvuNaXgqzNtGuB+D/SSKGknjvhUlSNIHAFW00CHbBBKPrlE3Q5XykXZXb24y45dOwVSGwxXbBa60vKzVI0R2/OtQtWk4c6M06cmI72yq8lwJ6omGS1MHA9pAA9GYWIAc29aCs4A6UT+b/x8VlgBZQWHm6cpTdQvgoyBDkl/ND1D/twQm5UMQ/EwgACageqVo14E1Cpc/rQF0dlGmfxTrEea3/JZmxtuAY2VFAm6qXLXLZEmoSm6KuPQqBy/U5j9ofW7sKdx+CTfNRPRiZzOx8yV5Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4sQCF+ocBQXtTf7aJgpTLYuw2EBeIBNCxBoDEVfsKSI=;
 b=udQpJrowAJeNxpguae03Spz4JiIkyfk+dfQVlHgCuqzKLtqCg7oVVTBEHQwqP16PcvchZY78cxg53ODtYm7RyyTO7ys+794+SZZNkVl951Jad/0V/m2pAMYDyXNHEOUWLzzyyEzjqCVeRBoGj8uo6+Q90J1jm75GQZqTbDtnoXbgFYwt2q7a77/V/IWmeamPEjNdU+iWB5H9DXLtK6VGTRq4PtEruHuObTf9uACrtNN88w4xh3mdXXj1sfFk6AGYR8/kt/cEm1k4kZ0Jje5A/J8GpHFF9exE2LcGu6O+gYja9sUUyXdlQmHaD4TayvlhBSy5PYt/Q3HKn2TTfi3sgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4sQCF+ocBQXtTf7aJgpTLYuw2EBeIBNCxBoDEVfsKSI=;
 b=DHNgNtqdXe2pxdYQEcHbGqYkH7jQ2H6Jir0sZRTFwVdg5I48tgof94bF704PIGLoqTHAmaZ1B/RnuJDsMXj0zkDWckxPlDceTkxNhdn1U/ZJUsI8p2OKlBg+uqoeWcoaIpM1NPAKqm82ChfBhqdlg8q06o1fVdgHhReGxauL5MO8JuJJkvgnr5VLf0Ed+RsOCM3lpNeAnHKP19Z7KZab2hkpszvBAf6bq9xPnMnE1vWPOgKVQ0FfWEzCuOlOXqS7CxIGeS/cjMino+kccAcHpb1NYV++rDozyhSvkMZKX+ewGZjgI96w55XCLc4dQScVHVWuOL5nU+Movsnb/jqKbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
 by PA2PR10MB8602.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:421::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 12:35:26 +0000
Received: from AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8]) by AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5f49:b0e9:d295:22d8%6]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 12:35:21 +0000
From: Tobias Schaffner <tobias.schaffner@siemens.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rpm@xenomai.org,
	jan.kiszka@siemens.com,
	Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: [PATCH v2 3/3] rv: collect per-edge dwell time for per-cpu DA/HA monitors
Date: Fri, 11 Sep 2026 14:34:38 +0200
Message-ID: <20260911123439.463052-4-tobias.schaffner@siemens.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260911123439.463052-1-tobias.schaffner@siemens.com>
References: <20260911123439.463052-1-tobias.schaffner@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: JN3P275CA0022.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:71::15)
 To AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:3dd::5)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4992:EE_|PA2PR10MB8602:EE_
X-MS-Office365-Filtering-Correlation-Id: 785d058b-b548-4ba1-c5f4-08df10012483
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|366016|10070799003|6133799003|10067099003|11063799006|18002099003|56012099006|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	LvDf/YF0pWwgPlOY04rxI8NLBR1upb+8wCcX8fXkxGRHixYk+R0F5Qo9IUZBANzQ0K7akUlZ+dDlGsh/sM8pQ5pX9bOCs4tUOXuXjDjwkLdhl1QJkMRQEB1Uomzhc/iLTED8xt3e697DQaunZpzwy3X9ZalbXlEte9BzXGb+r/N9BMKWS2zBcQ8A10eOeS7dYrB+BJ5TeY9BxXMQs3uhWQpsikdvEIe1I6lfTgkkxV0wRo3A7QkXnX1FPN7410MYsQRezAvm2snioZNncW5WKOcpttcjbNpJG3b3oOo/ZL/ADLyt/MRogqsSzSMbL8ElChBirszxyT7MpyV/jx5b+6dNM1jIJ48l7/JlWIcZOmMIeAtXZcR6vx7VSyCmbHLWRB0cKDjTlZajc61mK2yuZhGw79weycL4iFPTBcz80vYN1wk0Xf6UuWK5513+RQHwb23LNhI+ZE5WiDBMuf0iWcakxCTkkUvHoNG53PwQaajg7tT2chDXtOcs04d1ko20J6hLjaUnTzc7YlENDtqBVo/X8ciOdq07TL/3eeOWSMEQgd/M3YTkJj0b+n7aAExS9lOUFmS/sf0IocYxt3BQR3/d7JPW34NSGqq8P7wIC+pA/f7M0/lMO4uh3xTNSBT4yisQCzv/8dsSim1CvxilPlyHRrgBviMwmqW4oYbKM98=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(10070799003)(6133799003)(10067099003)(11063799006)(18002099003)(56012099006)(22082099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TNu/oN15Om2c/GkfknDTRJuEGssGQGi243BLqM0I/4hlcRlyTQ+23GFBXs6b?=
 =?us-ascii?Q?c10KxcHI/3C7GmjdOU6poU0lO4XS3FSQKOfkyo+L85zjAwpid2GD9Z6Sz1Ta?=
 =?us-ascii?Q?J4l6CepYyOxcIK4BwU5Pzd5JUn1aHTbnXDLZrEerNEB/AKIVvrg5hmydCbbp?=
 =?us-ascii?Q?imgWYs0pTLZkLbwJ0AJ6v8oee5qznZRSL3IqfN8P/XKp60puaWFeQGNviAN0?=
 =?us-ascii?Q?l6CdkUkPFA+vcL4jNfG2DUeCOwL5HYzAi3WcdMigS1rJe4xXkQzkpBZ+Kcqk?=
 =?us-ascii?Q?8akBiGVgfrlxafFPdrXbcsVBSGHyjJICwHmQquauD/sKtY6B4uctRBnVv5DB?=
 =?us-ascii?Q?7IT2RnLVnYQU8PmTQIz965StzC12f9p42yUCaVaiUblTGjBlLc1RkbVezy8G?=
 =?us-ascii?Q?RiRpHB1SRsYVAySCDR7sGdclQhyWrLqBRCKaQjezm7FmaqsBh9bkjlV9wQ/1?=
 =?us-ascii?Q?jg7Sjt37bvk2y0VPMq5pVzGRGz3AEkkJTgV/TH56vA5tfFJd+pIRK8z11JlX?=
 =?us-ascii?Q?thgcUMjyD63BSmVjzWNzidACXiYL2oSzW9yNzSEGIZ88lhhcjlK3nPkdM0U9?=
 =?us-ascii?Q?m4di+i5pt2FyWie6yUd+SMmOc97B1An3u9dsJBrXr7C7wLq3/2Tjl03cYSjS?=
 =?us-ascii?Q?GSlWsYH+5fI2roGA2x1sebtfbwidDIxYbVItOD2ax7cJRAV1ZCIPzWSdMiiG?=
 =?us-ascii?Q?NgVFsWbDVxraxiCo+GGIyVUTFLMHCTsF/8xYOMOR9rvIHBFyru9cSQIQ5Bty?=
 =?us-ascii?Q?w4tdIvNjrOHb82dkGmpOVpR7I6wNH980UeM0MAm+pP85o8XjCZtLpIBVgtXa?=
 =?us-ascii?Q?gjQUZvbvtrkCcw8/MLthUFiw2mPBYH16fxJV+evwoFJs4GXXspnFOPVNHNDe?=
 =?us-ascii?Q?fh1SsMHfaJM81XJj9k9e5HTsEDkAqNWC7LD0NEton6Ltgc5yDLJowEg/5Zxx?=
 =?us-ascii?Q?sqZpebcJVoOAs2TnKPWF+iM69Q7tOp5rLiTn3QTjloKhELSJ8i1qXVzqtKTS?=
 =?us-ascii?Q?9uznDnaroOf6Zcq6wx8E+f7Nup8mDEhZeoyoBMyj7pGzgzd+HxUM5/LL8r7/?=
 =?us-ascii?Q?GoUm5lwRcBBKoQ4yEbkmqfYtXarb9l448VE7LtQ/A4RL+zkvCmDOoY/rAh7d?=
 =?us-ascii?Q?Ewah4/ZShyYM5iq3mpB3qLV/Cw08JTybqFlsn9yL+uKHxLZLftJaataJSI69?=
 =?us-ascii?Q?sM0nYOtrNyoCdOaEQ1NguVqWw0wocc2uO8udsa2CYq/o5u5GRRj3PXXpvSsF?=
 =?us-ascii?Q?cbgpOPkPVi6eXS+Pur0SQ6sPgO1XvEOcOHL4K3kwmN9Lms8Pm+H9B2Rk7C9G?=
 =?us-ascii?Q?BmbaxpP0jKcGHDnEhk3wpGGmscDnCQ93nN6cJ9cxQCULb3if8MP8e1tFphMo?=
 =?us-ascii?Q?fF04FRHw7sZM1ZvRFpQxfSYHFx1e1D6M/zz1fBgcWXaJ4T+ugYLX082XK0VZ?=
 =?us-ascii?Q?rSEkR+gjZgorJL/hWmHYObK60nI/6+4Kr3GDtYDFvWz2+8hoLS2qTp8fuHBu?=
 =?us-ascii?Q?kHbUfAaGvldlO/O6gQzFl/bSTn9mkGceP8wn9bACOeoxwsMpzGapQ3LhGDJi?=
 =?us-ascii?Q?xZ7CkYXtARmIHTiIK/hpDILbe6oQFM5Ypn6JoGl+DRF3fXilFqJMJxwa+ACQ?=
 =?us-ascii?Q?nWkcG1Kro3H14HkmXKYxFUT/Zo3Gq3kpjJsmyPhBOK1kugrxoc5Q9TzUJ8Bl?=
 =?us-ascii?Q?nHujGuJofy2x+12bT221xR4PswMNJrr0cEY6f184sK/hB2ROvfCfNT8CICPD?=
 =?us-ascii?Q?GvjlnbPj8pzUpCpGHofMfX7Pdg99lOjIbVrqP3RIm8xRWO4+N/Yqs57p/pn5?=
X-MS-Exchange-AntiSpam-MessageData-1: SiM1GyiTB5az2P8kIqqoWEgBolA1rag3l24=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 785d058b-b548-4ba1-c5f4-08df10012483
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4992.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 12:35:20.9611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cii/h1F8Zs5Lnm/oImBT4jYJ4tf8FMJzxIzkp1VUKlXpz3plOmnMgTVddLGJZOXZFBOvPDFG6i2DbE9o0DfMH3HHaItSt0Hoh0KwM9Y8Q4I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB8602

With the core facility in place, hook it into the DA/HA layer so that any
per-CPU automaton monitor also reports how long it lingers in each state.

Pack the automaton state and its entry timestamp into one word so the
transition cmpxchg updates both atomically. This prevents nested events
from attributing dwell time to the wrong edge and requires a native
64-bit cmpxchg.

Account a transition as soon as its state change is committed. An HA
constraint that rejects the transition can therefore reset the monitor
without leaving an accounting window for nested events.

Add a selftest that enables a per-CPU monitor, checks the stats file
appears and is populated under load, and skips cleanly otherwise.

Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
---
 include/linux/rv.h                            |  9 ++++-
 include/rv/da_monitor.h                       | 16 +++++++--
 include/rv/ha_monitor.h                       |  2 +-
 tools/testing/selftests/verification/config   |  3 ++
 .../verification/test.d/rv_edge_stats.tc      | 33 +++++++++++++++++++
 5 files changed, 58 insertions(+), 5 deletions(-)
 create mode 100644 tools/testing/selftests/verification/test.d/rv_edge_stats.tc

diff --git a/include/linux/rv.h b/include/linux/rv.h
index 541ba404926a..6c5c2fa7dd68 100644
--- a/include/linux/rv.h
+++ b/include/linux/rv.h
@@ -21,12 +21,19 @@
 #include <linux/list.h>
 #include <linux/types.h>
 
+/* Edge statistics pack the state and its entry timestamp into one word. */
+#ifdef CONFIG_RV_EDGE_STAT
+#define da_state_t	unsigned long
+#else
+#define da_state_t	unsigned int
+#endif
+
 /*
  * Deterministic automaton per-object variables.
  */
 struct da_monitor {
 	bool		monitoring;
-	unsigned int	curr_state;
+	da_state_t	curr_state;
 };
 
 #ifdef CONFIG_RV_LTL_MONITOR
diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
index 34b8fba9ecd4..bd7bd422b39a 100644
--- a/include/rv/da_monitor.h
+++ b/include/rv/da_monitor.h
@@ -16,6 +16,7 @@
 
 #include <rv/automata.h>
 #include <linux/rv.h>
+#include <rv/edge_stat.h>
 #include <linux/stringify.h>
 #include <linux/bug.h>
 #include <linux/sched.h>
@@ -112,7 +113,7 @@ static inline void da_monitor_reset(struct da_monitor *da_mon)
  */
 static inline void da_monitor_start(struct da_monitor *da_mon)
 {
-	da_mon->curr_state = model_get_initial_state();
+	da_mon->curr_state = da_state_entered(model_get_initial_state());
 	da_monitor_init_hook(da_mon);
 	/* Pairs with smp_load_acquire in da_monitoring(). */
 	smp_store_release(&da_mon->monitoring, 1);
@@ -275,6 +276,11 @@ static inline void da_monitor_reset_state_all(void)
  */
 static inline int da_monitor_init(void)
 {
+	int retval = rv_edge_stats_create(rv_this.root_d);
+
+	if (retval)
+		return retval;
+
 	da_monitor_reset_state_all();
 	return 0;
 }
@@ -286,6 +292,7 @@ static inline void da_monitor_destroy(void)
 {
 	da_monitor_reset_all();
 	da_monitor_sync_hook();
+	rv_edge_stats_remove();
 }
 
 #ifndef da_implicit_guard
@@ -683,9 +690,11 @@ static inline void da_trace_error(struct da_monitor *da_mon,
 static inline bool da_event(struct da_monitor *da_mon, enum events event, da_id_type id)
 {
 	enum states curr_state, next_state;
+	da_state_t old;
 
-	curr_state = READ_ONCE(da_mon->curr_state);
+	old = READ_ONCE(da_mon->curr_state);
 	for (int i = 0; i < MAX_DA_RETRY_RACING_EVENTS; i++) {
+		curr_state = da_state_of(old);
 		next_state = model_get_next_state(curr_state, event);
 		if (next_state == INVALID_STATE) {
 			react(curr_state, event);
@@ -693,7 +702,8 @@ static inline bool da_event(struct da_monitor *da_mon, enum events event, da_id_
 				       model_get_event_name(event), id);
 			return false;
 		}
-		if (likely(try_cmpxchg(&da_mon->curr_state, &curr_state, next_state))) {
+		if (likely(da_state_try_commit(&da_mon->curr_state, &old,
+					       next_state, event))) {
 			if (!da_monitor_event_hook(da_mon, curr_state, event, next_state, id))
 				return false;
 			da_trace_event(da_mon, model_get_state_name(curr_state),
diff --git a/include/rv/ha_monitor.h b/include/rv/ha_monitor.h
index 28d3c74cabfc..4def2aac92de 100644
--- a/include/rv/ha_monitor.h
+++ b/include/rv/ha_monitor.h
@@ -312,7 +312,7 @@ static inline void __ha_monitor_timer_callback(struct ha_monitor *ha_mon)
 	if (unlikely(READ_ONCE(ha_mon_destroying)))
 		return;
 	/* Ensure consistent curr_state if we race with da_monitor_reset */
-	curr_state = smp_load_acquire(&ha_mon->da_mon.curr_state);
+	curr_state = da_state_of(smp_load_acquire(&ha_mon->da_mon.curr_state));
 	if (unlikely(!da_monitor_handling_event(&ha_mon->da_mon)))
 		return;
 
diff --git a/tools/testing/selftests/verification/config b/tools/testing/selftests/verification/config
index 43072c1c38f4..caf3a96ac8b4 100644
--- a/tools/testing/selftests/verification/config
+++ b/tools/testing/selftests/verification/config
@@ -1 +1,4 @@
 CONFIG_RV=y
+CONFIG_PREEMPT_TRACER=y
+CONFIG_RV_MON_WIP=y
+CONFIG_RV_EDGE_STAT=y
diff --git a/tools/testing/selftests/verification/test.d/rv_edge_stats.tc b/tools/testing/selftests/verification/test.d/rv_edge_stats.tc
new file mode 100644
index 000000000000..616bb0b5166e
--- /dev/null
+++ b/tools/testing/selftests/verification/test.d/rv_edge_stats.tc
@@ -0,0 +1,33 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# description: Test per-edge dwell-time statistics (stats)
+
+MON=wip
+
+check_requires "$MON:monitor"
+
+# The "stats" file is created on enable; if it is still missing the kernel was
+# built without CONFIG_RV_EDGE_STAT, so skip.
+echo 1 > "monitors/$MON/enable"
+if [ ! -e "monitors/$MON/stats" ]; then
+	echo 0 > "monitors/$MON/enable"
+	echo "CONFIG_RV_EDGE_STAT is not enabled."
+	exit_unsupported
+fi
+
+# The first line is the column header; the body has one line per (cpu, edge).
+head -n1 "monitors/$MON/stats" | grep -q "^# cpu edge label count sum_ns max_ns"
+[ "$(grep -cvE '^#' "monitors/$MON/stats")" -gt 0 ]
+
+# Drive some scheduler activity so the automaton records transitions.
+for _ in 1 2 3 4 5 6 7 8 9 10; do
+	(true) &
+	wait
+done
+
+# At least one edge must now show a non-zero count. Do not require a non-zero
+# dwell: a coarse local_clock() may legitimately return the same value twice.
+grep -vE '^#' "monitors/$MON/stats" | \
+	awk '$4 > 0 && $5 >= $6 { hit = 1 } END { exit !hit }'
+
+echo 0 > "monitors/$MON/enable"
-- 
2.43.0

