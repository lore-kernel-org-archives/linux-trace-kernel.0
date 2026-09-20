Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013036.outbound.protection.outlook.com [52.101.72.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9541DFF0;
	Sun, 20 Sep 2026 02:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789871497; cv=fail; b=m/Rur1G1IW8dJ+TJ7cKghr79zYetIYYRS2YeTA0rx3qmT9mi8qeFvLYUIQsyopPR4rXdeCSb0uYK+KwhrclJfriMeUZuhKWmLhtHFufyONmMH7dCkaP6hZHqbOCo4vVmeQsSlSIDz+DGxxZmLmdHbZr7XlGOIdru3JHMxFDLkXE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789871497; c=relaxed/simple;
	bh=BBTmoMjGDVJ1Iiuc0tXwI+d6uIlfcsn1a4nkDWExMpo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=rSnoC7S8a/4NZe76Xh+5nLOHLDJtg/c5fuZ7BsM35iArL3n0xhUEt55M7hzGpfCuH9hCAVKYb+BczOD/hupw3flX+UpXJDwgoJNRCicQWDOtXllIXF5ifoFVNuH+vGucJvOLggtDFlAvIezE+BeApM42ejRVSz0ho5b9p6ZTf7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=w1tVqf/o; arc=fail smtp.client-ip=52.101.72.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="w1tVqf/o"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MGXaDH+cQ9P8HIls8Mz7D0PGgiHs+iNTSCJfXxOY8j0FMyoBDbNP1gZyWVmcfoie9whVi7M/58RT6DuBrARKQ8z8Ft3J3PO22q/hJvZJ+wtN2euUdlNS+1F+uwtahSpI28cFOzEHa+Bf+UBJLbTzVnTVoH7UbRILM8ouIMNqb5jVyZ4HYYQPNsHIFVpYUo9NkV2J4QrM2+EXohdW+g5/VdXlu5E6+JSU7ccoyT1Ezu8hrIopya1lxkhOScc07u6u7XuXygl2iEMipRHJLX4c/JjpGV8q94sRiu9pDcb8yETBSjt4a+CiceH36wSKrTjKYWvvJUOQ40bycT8MiDTYqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dRuJ1scbQhM5VQ4UkTG2Dq9HCKGTONl8eZGCU8eLWmM=;
 b=pEFh9v7oIO2XSjtA41kP9x2rMKVd2y67uFwNunKozfSL8YHfbS3PjAgQGh0QevdesPz8kuddjj0nJAPfLMDjKCpBpM8yWXpiUb8K+Ar2/X2zhcW7cFD8fdmufXz5uKd8p1LzhBbGITYYhJ0mgPAkXbuUqM+YmSkwqiTe/M6qCphs0AMhaymcmXx23GWYEthqQJwNWbbC869su+QG6LZ+rIwdtanCxJtWIVKVtXAUsRTL/V8KC2i/2V0MH9o4z/nOTRfPTFNH8Oisf3Zjf9HsnVr6FW8DmnDUQzyooz4hkhy6bFewESIImHZ3P9ya3S/Ex0dVIYNLvQ2tfG1qc7aCCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dRuJ1scbQhM5VQ4UkTG2Dq9HCKGTONl8eZGCU8eLWmM=;
 b=w1tVqf/ooWkAZ89fD2688tJCJwKRXBCc5C+wv2jYoYczosmW38kgs7jySP7wa0MNm0Jf5SeTQH4CMoWfrA8afqYUXWB3igpg6juSoooQC069nMVDQwwH6nPEmIlUFWMfj7lUtPmK/psi5lAVEhKNyw6h6XVYkvCcN+QXCk1/YKsAlFdhXC+qSHrK67Zc8c5NIeJU9FjsFYaoxz+W6kpQnXdoXt5TRBVCHpbAYB/Gwgy52FwU556jfvOa1awSS+Z9FLnOyx/JnheaNMHh7nKQjbGIGerkWYpMTHxpvpl7ex5drxYQXF93PO8gdfdz+ZIuIoPkOaO0HBdE+s/zW3kxHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by PAXPR04MB9596.eurprd04.prod.outlook.com (2603:10a6:102:23e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Sun, 20 Sep
 2026 02:30:41 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0428.014; Sun, 20 Sep 2026
 02:30:41 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] tracing: use assign_bit() where applicable
Date: Sun, 20 Sep 2026 10:28:10 +0800
Message-ID: <20260920022810.3145921-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI3PR01CA0001.apcprd01.prod.exchangelabs.com
 (2603:1096:4:296::17) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|PAXPR04MB9596:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e7a8a9e-00e5-4120-58ef-08df16bf2a4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|19092799006|366016|18002099003|56012099006|11063799006|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	c+zcoqRvxbYHbWK/GB3LFnM1PiDDV14FV//odlNDRp1SKDhvpkXnGlXHSXCqEk2c1ttBQlcr67FAus/orirMGX0hYXt5fAtkh+9lKTQo1aN1/tL50DclmPgWyECOslwzZG7YvvYZJHekEhFPhmG0mOfdlXGbLwo30ADFpiOwkTvuQV2EpyCMTs/+fFlVEOIzCVKLOHismd8IhExjHiKkK4R9H330ENnsiIrhODNQTVJe3x8sI/qM58ttVeG7GO9xiZh2kqVRtaLGQXHORY0D1d7qRx3sxdYNFhb4ZLov1FjeT81ooUNplzibx5gWJN7bHdEFXXbYWU/rGJfb//HUfj2UXHVguRDrc+KQF8HLMTNSH4ZRoT2XfH0vO0iQh218Wa/ZoydlDPB1zBdxEh0OANNQI/Ngg3dbvjQ/quRP5oZ81+k/4+ppJXClHB5uxG0p9nrPKERbalSLwHEBPy+6gdjUWSmtBnG5Du01oQl2E6ubnltQhnQLXxI41WqOaODeGGPzXhPeNGmBcemUDImUF0S6/cJ8q6oXSbtDNrrlon4Xp5bz6z78gqWJSioRKW4PDTv0uW0YponBUEMD1jvHqSt++zkj7A+JDWxZh5lUGiAUAWgPxFOjtQO4bVizq27G0E1+Oe2F+KNty4R0j4gjU/MlWc8FWwJu77Qd2Nsxn6w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(19092799006)(366016)(18002099003)(56012099006)(11063799006)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sgFSi8OOB5uvJjERoMzZsTcyMdSQ/YmaAmOZTl+ywoJViB6JGU3RCghYhHjh?=
 =?us-ascii?Q?b/kKNEHuDp33sKjlurMcyhkKyE+Z1478/agElTCIHm+mXG3LTkPAXKsHK4E4?=
 =?us-ascii?Q?mV51Iuj5jsQgdOK7qV1dzQiJy04JWeH0FPGIHUM+TZ95Q9JzXWMYnDxtK7hu?=
 =?us-ascii?Q?AdLj2Wa915sfLLnIcZzhADMUYwTUsI5+BeF9nGChbn5L4LyOjYWUpC4H/7Zt?=
 =?us-ascii?Q?3EKX7tTSL7rUDzTR5Vrx4P1ASuKc2d0SatfkL6qFV8P49o+BXJamjZ7JqKdL?=
 =?us-ascii?Q?/YdeR8XaP8yX6m76UysBgtUePCveCxn3HG9DbML4Guvy8BdsIS0O4HeebLqD?=
 =?us-ascii?Q?frlCf4/IGRI+4CrT4nyQmu4BFIt14Zfbb005Im71H3cy5LW0axeuk1QbqJ2d?=
 =?us-ascii?Q?tj7N4K+cqHNpj/gh8pNUyv/Oerq10J1fylA9jJsFZbjLBPIOiGT5ei4x+QH9?=
 =?us-ascii?Q?5UtCSxoOTPJUr8o2H31krl9Mx8QOqOfgcaNxUqHtF8U0psU2txYHweLQWYRu?=
 =?us-ascii?Q?nop47fsV9Zd11nGdst0QobEqG/l5owRwWyoQXb4K+twUOFbcxNJrAxqbkU+d?=
 =?us-ascii?Q?IwgnYspfVQx/N6EPAlmyGVX/oKPhVuYZs/+zHVwNNtqGTEKhOvY8Ppb7w8g4?=
 =?us-ascii?Q?fVzkFRmyNDc0MwsxcHp1ByBuItBee8cfpxPJ5EMoQMed5o07vbTCyaHIRuu3?=
 =?us-ascii?Q?+WTWvyZEsfhzaxLT6A4++TrLu1IBP2tJqfK1PXQpjqtiBOGVCYgRteLoZ+AZ?=
 =?us-ascii?Q?nTA6x3Zmr/TvGPr0W7boIM4/v04lG6Wfu02zm+Q78wQgKQCgSBeMwah73qFr?=
 =?us-ascii?Q?L4701Y0pDQelafa/dgb3WMX8/EIXBKbMSBAxAEDR6oINbivQWaqvvDn3M+PJ?=
 =?us-ascii?Q?Ea8LDHY5wi5eKzyN5iUvoM1x3jQ5OqDpsSagJ/rbfkMXsvnUDgP+coxVtSVE?=
 =?us-ascii?Q?E9QdLGvPqJzyOQe3skzWURMfrP+t7JYhpTO20jKIOWUWtQYqQjzVT838i8yW?=
 =?us-ascii?Q?SfeAaySjwC00Lfy8W/m16Gg96dU9mTpbIVOvYnX4KPl7KgzfUCbHLHgv8zC0?=
 =?us-ascii?Q?xQ4UHYEOfp4/fpfif4jjhGHF5o7vr0V/3wp/6XHqyZ0SmIRNkLOBkpATKOF9?=
 =?us-ascii?Q?9Ki/QZL5sMDO8TliZ4u5rTDwBcCzKbfCKfMSwMIEnVgCjQ61kBuwdN/XmJ0d?=
 =?us-ascii?Q?sf7V/LqGEGPM1tetg4boNNqkArkH/7eBo3FiB0kcvOcHmx1E0a2GXdSLKP5Z?=
 =?us-ascii?Q?mzYR/d54RYuDf7Kmo6M5QmpjpI/KSibjVB2cN1dKhpIqu6hpZCPuRxslQeIm?=
 =?us-ascii?Q?rWCozJ0ajX2hudXbbmHlqvV1LmnUsgP+VY1hCyb17kTHUQQKKUgLOctI4LWf?=
 =?us-ascii?Q?iARTBturNeJMo2STULBhwytlYffTyuqm6xoesKNdDQ2MsFhFD55Xqn7vZzem?=
 =?us-ascii?Q?Hsr/f3pVgmMHTV81aiyfk1j2/dmhio1jde8mL61lDH0QndKZYkGsVfV5AxaP?=
 =?us-ascii?Q?6yU0MnrVrc/73BEFWENK42BLO1x5O3AV8M/plE47NEXm0cCCdZwJG7kV0FzH?=
 =?us-ascii?Q?1EnYYxVwrfXnqDXXW3j10TT6BvNee/fR1NiEmuSKZV4SzSOFMpX+tnnvTnv9?=
 =?us-ascii?Q?RVsR6EEej4EsdIszwkvbY9qRfWuB8bcP/8lPYNi5JMUH0f7omnajwZQU+hvG?=
 =?us-ascii?Q?wm0GLhn8solSFI9XRZzekimgsSIuyIkLGFaCKbvXHur7k9tELomNt/I5YNQy?=
 =?us-ascii?Q?YP5Gon0wicIwrWbmy8UIQcDb9BkPL4i3kV1/siwZbsDadGXlVQxL?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e7a8a9e-00e5-4120-58ef-08df16bf2a4e
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2026 02:30:41.5825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 59uXIZv5e3SxgVfs2rIjLhDMU23HaqhSsuwhlEJJsHVdp/1bFytbArEL5ECZIeUSX168s95ZxXj+H6gj6fpk5h7yxlH46n0fKYG08w62Knxc96nkanedx4bgjNZ3ENCM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9596

From: Peng Fan <peng.fan@nxp.com>

Convert open-coded if/else with set_bit/clear_bit the assign_bit API.

Done with Coccinelle semantic patch:
    // set_bit -> clear_bit => assign_bit

    @@
    expression cond, bit, addr;
    @@

    -if (cond)
    -        set_bit(bit, addr);
    -else
    -        clear_bit(bit, addr);
    +assign_bit(bit, addr, cond);

    // clear_bit -> set_bit => assign_bit

    @@
    expression cond, bit, addr;
    @@

    -if (cond)
    -        clear_bit(bit, addr);
    -else
    -        set_bit(bit, addr);
    +assign_bit(bit, addr, !cond);

    // __set_bit -> __clear_bit => __assign_bit

    @@
    expression cond, bit, addr;
    @@

    -if (cond)
    -        __set_bit(bit, addr);
    -else
    -        __clear_bit(bit, addr);
    +__assign_bit(bit, addr, cond);

    // __clear_bit -> __set_bit => __assign_bit

    @@
    expression cond, bit, addr;
    @@

    -if (cond)
    -        __clear_bit(bit, addr);
    -else
    -        __set_bit(bit, addr);
    +__assign_bit(bit, addr, !cond);

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 kernel/trace/trace_events.c         | 12 ++++--------
 kernel/trace/trace_events_trigger.c | 11 +++--------
 kernel/trace/trace_events_user.c    |  5 +----
 3 files changed, 8 insertions(+), 20 deletions(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 30c0ddf90887..72a210da67d6 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -859,10 +859,8 @@ static int __ftrace_event_enable_disable(struct trace_event_file *file,
 			WARN_ON_ONCE(ret);
 		}
 		/* If in soft mode, just set the SOFT_DISABLE_BIT, else clear it */
-		if (soft_mode)
-			set_bit(EVENT_FILE_FL_SOFT_DISABLED_BIT, &file->flags);
-		else
-			clear_bit(EVENT_FILE_FL_SOFT_DISABLED_BIT, &file->flags);
+		assign_bit(EVENT_FILE_FL_SOFT_DISABLED_BIT, &file->flags,
+			   soft_mode);
 		break;
 	case 1:
 		/*
@@ -4273,10 +4271,8 @@ struct event_probe_data {
 
 static void update_event_probe(struct event_probe_data *data)
 {
-	if (data->enable)
-		clear_bit(EVENT_FILE_FL_SOFT_DISABLED_BIT, &data->file->flags);
-	else
-		set_bit(EVENT_FILE_FL_SOFT_DISABLED_BIT, &data->file->flags);
+	assign_bit(EVENT_FILE_FL_SOFT_DISABLED_BIT, &data->file->flags,
+		   !data->enable);
 }
 
 static void
diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index 4d2fde996c0f..3b5e14fd0dd9 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -674,10 +674,7 @@ void update_cond_flag(struct trace_event_file *file)
 		}
 	}
 
-	if (set_cond)
-		set_bit(EVENT_FILE_FL_TRIGGER_COND_BIT, &file->flags);
-	else
-		clear_bit(EVENT_FILE_FL_TRIGGER_COND_BIT, &file->flags);
+	assign_bit(EVENT_FILE_FL_TRIGGER_COND_BIT, &file->flags, set_cond);
 }
 
 /**
@@ -1673,10 +1670,8 @@ event_enable_trigger(struct event_trigger_data *data,
 {
 	struct enable_trigger_data *enable_data = data->private_data;
 
-	if (enable_data->enable)
-		clear_bit(EVENT_FILE_FL_SOFT_DISABLED_BIT, &enable_data->file->flags);
-	else
-		set_bit(EVENT_FILE_FL_SOFT_DISABLED_BIT, &enable_data->file->flags);
+	assign_bit(EVENT_FILE_FL_SOFT_DISABLED_BIT, &enable_data->file->flags,
+		   !enable_data->enable);
 }
 
 static bool
diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index f658c3a77aa7..055894cb999c 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -590,10 +590,7 @@ static int user_event_enabler_write(struct user_event_mm *mm,
 	ptr = kaddr + (uaddr & ~PAGE_MASK);
 
 	/* Update bit atomically, user tracers must be atomic as well */
-	if (enabler->event && enabler->event->status)
-		set_bit(bit, ptr);
-	else
-		clear_bit(bit, ptr);
+	assign_bit(bit, ptr, enabler->event && enabler->event->status);
 
 	kunmap_local(kaddr);
 	unpin_user_pages_dirty_lock(&page, 1, true);
-- 
2.51.0

