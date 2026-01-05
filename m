Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022086.outbound.protection.outlook.com [52.101.96.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1DA2EA171;
	Mon,  5 Jan 2026 14:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767623391; cv=fail; b=s7IuuGxu55FtAjTsZBQ2syTWrz6Zs1OeJ9iLK+9cGVSC+EcgY2l9XeQ1JhD/NMtFxWBI/ph5weH68GJVdfFUTlzYcnQgLPCXDMXD64SV/Ha7xLDONrLnSd9yhRNohGhbuVdrQpbG2HPrVgAOIfZg3aK/SOi0J7T0oBkWAazbDug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767623391; c=relaxed/simple;
	bh=d7vFCkJDXontKGbckxibXT+btE7bMaM3LNKpC5ZZMDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YnhkN9isPV/AUuNOgaeLbL3ZqGnBgK3gPEXOBVZbQfoggk2pE0mGnz1j9RsgvjC0R/U3hifRARkJjyY1gxlbiApmprlovlBhG5rmDkuTW/aq4SOZNBSNUSHUm9q8SOSo/+dK/d6UTI+daFpVM5u7ltqVgacDmr4SOjCFuigLEPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.96.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cf3EvE0oMFqqpdqPPvv3xerIIElo9ihGKVZQzjyYoRrx4c2hdYLSFsYVxTmA4tVx9KDMYNCxGrE+rI1dw61YbUslONAY1pG7xmck+eZv8CcavHAK2KGQpXAP9+AU4msLZds70R6e3rJgoQgqKgNC/8DURpG345B6/L5DAUQFq97ydFqZ0LvLb09nUI0hfOKoU7apOcT7DHNwtrjdVvC0WUF3xzhw9NdEaYb2tnBx0OsILazJ3kSnaNnDfb/n9zzmZYbynEjYanwgToBoix2MWhn8rCjQQuMo2kfENF4fzQcLWT8rmXbf9MzrIA/8p6gNHjXnGLxFQAbyfLcJm1vvEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SI6WhCZfE/npcvfasJOTo0tQO2+PWUpaXcZPZzkezs8=;
 b=Aa+daOdpFgf329ouVoxbUIEjMME9fFuwld7iBuaVVa/xNVTbplF5x+7Mf/XILP3f2y40sO2/rNBvqxVjJ8maGtydb1jkHkj8V1DZMjC4eyeaZczOoFRWSBboO9aL5AZA7FGgOw64wLNKlpPmYavWP4015fnQbxdw+VUdvQCpWZUEtqMcZzhHE6kskVG52exxTamlmUyUFwO/tml1s4Glfgqt3Mp6OJcC6fwRthw9rJ6hTyTqv/eBqk+oEg8IL8WyUujQT9IfAh6oboi6PAGUWuUbRxx87aoutvUSHH4torFy2AZhG3CJ+613K1C20FC37sIB32xfMgnaLQFgyf+tSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LO6P123MB6932.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:324::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 14:29:47 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%5]) with mapi id 15.20.9478.004; Mon, 5 Jan 2026
 14:29:47 +0000
From: Aaron Tomlin <atomlin@atomlin.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com,
	corbet@lwn.net
Cc: neelx@suse.com,
	sean@ashe.io,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [v2 PATCH 1/2] tracing: Add show_event_filters to expose active event filters
Date: Mon,  5 Jan 2026 09:29:38 -0500
Message-ID: <20260105142939.2655342-2-atomlin@atomlin.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260105142939.2655342-1-atomlin@atomlin.com>
References: <20260105142939.2655342-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0921.namprd03.prod.outlook.com
 (2603:10b6:408:107::26) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LO6P123MB6932:EE_
X-MS-Office365-Filtering-Correlation-Id: 7935af67-ea7d-468e-e3fe-08de4c66e080
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FGDBXULUsvvIbplA3Ll14/F1n1dvdmsKezjBS/3jUaSzt0H6F6Z3voC+x0mi?=
 =?us-ascii?Q?8UvBY3DrCMvLW8DsEQTB4ulvAdYs4KAlHQvACG/5vnSrxqrQ8JSllw9VO3jl?=
 =?us-ascii?Q?kPv0ExCufnvLRfqX3QpU7Hm6nhC5bctaz//J/N8z/oiM8xpDMCZduAh6jln2?=
 =?us-ascii?Q?xQHEelCVN57ScSqU7ITJtOaNO14PdoDCbMybYCI8K66ge4NYkgaelxX+mR7C?=
 =?us-ascii?Q?8QNOM5qDgX3HH8azykxsOiuLdBq2imqZRQJx82nd11CEWq8ZjaV4Ae4zkDft?=
 =?us-ascii?Q?nsc9zUtrcOZJ53GOdtsfI1dBu6fBj+sq1JMAPnhZXDJskGzWL7lZs1HScg9J?=
 =?us-ascii?Q?f7T6rN57w+NXGzXhmgKio8hkDuulAhc0DWzrMjV9uhMkrk7+hTAMST+N2LtY?=
 =?us-ascii?Q?qmfoWxPG+tpo8zHEytH7xzXlclRKEPm6PE93Qa0Yo5ZnUg6FjV6Uq02IKZ7Y?=
 =?us-ascii?Q?Ln4T/nhu/MjD1h4IGPzPju9by2KvYHtvJAl1I5nUVko0x9yFH4zdindr7BCk?=
 =?us-ascii?Q?p/xjmWNOvHfNN6lJ3SObE2J8whtrzbnGAMeoBy72sy8BCEq+d35kIgiYlmFa?=
 =?us-ascii?Q?W914Pvs2vNVbwjCf6bstoJaj9Mv6EmXNZsj8TFmkwzO6fACXbVzQi+JikhNw?=
 =?us-ascii?Q?70EMl10yxJ3tUaEPo3uP7RC0cERvsQv9kdT/iPoVugGzxTTzGv1ba+uhnj/m?=
 =?us-ascii?Q?cNb4r6CSBDR9KxhrpEVMSvi+u5wQkmWf3fJt/Qk3AMXtxwAT5uHbtwgQU88z?=
 =?us-ascii?Q?SUcMryi9GEpVRdWXN2rAAzw9MDYZmdvxjvgMEATAVNqetBeFw57jbFtp+nph?=
 =?us-ascii?Q?scCRAAcl5CgAiMpu+yED8rWuUwYv2OAn91G4UjpcEWsVkqkFLdJ9W6J4UDbk?=
 =?us-ascii?Q?KD7RneDxWY9fmvDNs5O9VFPiKy78suQx+Pjp7W/0YCWBchM0ljUGiJHQ6nLn?=
 =?us-ascii?Q?Tfvg88V+Z6TefXj9ecGFmyn9Zg1HX4Dz3MMwhynPdT525O0W8ZviviYiofUF?=
 =?us-ascii?Q?G8Ac1yadiZh2YCVlN+L7yORAxATZPjIN+O28TF5iWCBgDJLbI+u1bqs/r751?=
 =?us-ascii?Q?yAx681IAS2CpbLiKGdRHI53AH5J/TaaG92xBmeKiWlFIzooSg4Q87oxSQE8Y?=
 =?us-ascii?Q?9Q2fKyNtc0TyYBj4+lyg+C2gus9j+GfkVUvYodClG2eyqJ65XaDfIknCAqJx?=
 =?us-ascii?Q?rtvNsJz6vP30HoxDAKSyvgX8KVgjVaSno5ZMUuGT706t6hZSwnXVEb9vkKVR?=
 =?us-ascii?Q?KUy1VdUH9PiXzRaNoJlfyoYYJ+NFaTqRQ247ehmkWYn8xS7hmB3svy4eRwD9?=
 =?us-ascii?Q?C7wnROOnzrudaX4MefuGuXwUJr9wdE97TC4GOaEgt4/yD/sof++tTY5EJVE9?=
 =?us-ascii?Q?wYU2uWVTYSjiLAZfHASBKdpISKpCF+w6EYU9pvTk/tQZxuce0OD2aL06Wbyf?=
 =?us-ascii?Q?D7xoIZg8L8Qc+Q+tp9btEwPgkBBN4HK8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RWL5Zn9PFNchZUPTrc90mSmujAMhWS0xnXqJooOwddeyGkTD4SMqt8xQ6wWG?=
 =?us-ascii?Q?efbp+PDSe2VMoVBBE8Cu1EHOqfhclTXfqfI6Bvz4IT26gOh3AqATzw18e0VQ?=
 =?us-ascii?Q?P4YFWc5d/CKBuk+ymKFJk8i1YQy/zMD5KqOZ4QpHYjbCIrOi0fCJg6sMRzqi?=
 =?us-ascii?Q?dw6HAy/tKf3jM0s2rb1hSHfuUk3GQOtPJBqbIkPtIpJk/i3Kps+IkvJSXirG?=
 =?us-ascii?Q?BOYuMOWlTXMfxbkAC9RfI3Bt2YNTlTv3b+exNjZeuGzSYhvKO+Gll3JvWq/J?=
 =?us-ascii?Q?jy8tkfIt464O/2UIWi2IsNSD5yGSnxn5D47evPsfa6M2pOrrACQVpFyryfJs?=
 =?us-ascii?Q?fFGvQXDzePJZOKjx6aMmQ1s3PRUUHNdSBD76PQak0Knc69666jCTzBN+1oJP?=
 =?us-ascii?Q?YSlmHQEbpi9+D2iszPz6AeaXIFakMvUAbSMSVa1znY51o3OpLv+4mrTJkNaq?=
 =?us-ascii?Q?JWwqCHwfeSILq8DEkTT0Jk6PS4eliP4IKd2OvbaMHbW3rqPZkTGPR49WE7PH?=
 =?us-ascii?Q?RJM6hBIPK8psAyteJoWsIALKNcgibPd0i6weS8MzcuVZ7zrwwB9TumLApckc?=
 =?us-ascii?Q?u6ks/hpx3M4yd8XU1HyKgo4GpaJAQDrAcxhOuGoDtZvKx4uNE8mHWe79nQBY?=
 =?us-ascii?Q?8S5rDPW5yGXEijwLtbCpE844pStHXpSfUSpQNN9Y4Uy9LzuvYRlEQ/9ao4V1?=
 =?us-ascii?Q?n4yJqgVXAYtTN9YcATmaRt5rsVrUbAplT6pG4cn4MLIHC/OARc+yv/xMCGmv?=
 =?us-ascii?Q?xrNdKya16RJtj4zv4trh4mr5xEtF17PtZc4bFECpjGKeyRbtDLA733tJGz9M?=
 =?us-ascii?Q?ZnLatU3dr6lzkzmz3XtV50RKNqKEbhxVg0csUbubArFH4ZLhRYkcuc9FBpBB?=
 =?us-ascii?Q?HxiNMBFQOarnDwmAi/fRP0rkAbn8jK27NzS+NP3FBxx4AvPEPE2ZqG83jarM?=
 =?us-ascii?Q?lqWNtxCeqvRDdKfE9zPuSTQJGgthJSq9qpf1Z4MU6KOn2/lBVH6RGmL7qQF8?=
 =?us-ascii?Q?UbF9aDP15LnuZSi5hlWV4xgxqoch+m9cYIp2dmAROkPNtSxbGTpCWohqqo2q?=
 =?us-ascii?Q?Q3aW6Kgt6Bzb784+bAq/YgIIeWraepmy/A9upajHEmFwlRvYG81poL86+ko0?=
 =?us-ascii?Q?4iSD4m+/tsQBDgLoudH/4HIQif/5O/FIg0tnIJ/2GYQBL7NSS+QKC5aKDcmJ?=
 =?us-ascii?Q?/jcK8t0kY7agsbuWKvfIfh2cXRAUjBlgHGFzhzpsANgmm5G+BUCUZErVgamC?=
 =?us-ascii?Q?+Kd6etWkCEhOyHayCrYJZNiLks4aSEOaMg04VrJqQPv3jJifaC64iWDZVWkl?=
 =?us-ascii?Q?iz9MmH9lz9tIw4ITAomOFChN5f1tBsR+SxcFRapaLpxMGCeY1YpPMCS4o8XT?=
 =?us-ascii?Q?InOODB2R/Plp5RNTjp49H/EGDLLyT437OwiYoaatPCpAS+Vtpd8P5eHdSjQ7?=
 =?us-ascii?Q?HaMJ571vfKL3Pp+GNlrSbD4rXG0WaQibBgTEJk1K/hUdNOgERj362s75OJvG?=
 =?us-ascii?Q?r6IcEY09/euy3y0HAyxH5MdJe1li/5+MXjFWOqZQ1MVdoPGnkvj1BKTbLG0i?=
 =?us-ascii?Q?ErZ/+G2V0z+8gbXqLcHubGuj75y7uq3+R8gqNcVlO2UjGesLJHjNX3xBHvQ/?=
 =?us-ascii?Q?2ymKyP5wmEq6j5Uejlkl4ifE2fBZeIzK5ja756wFUMRyOfCQ09NQTSfxKqBl?=
 =?us-ascii?Q?iPQhsEYKbdRcz+t/yJCGL1o6PQCyVoIpsTlPcN2VHpTX3rxeghVNAmiqcJCh?=
 =?us-ascii?Q?6i7FKBUb7g=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7935af67-ea7d-468e-e3fe-08de4c66e080
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2026 14:29:47.2002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uJhNKzOrMd5DivOVYjxYfAtvyQeWfAHIoZdro2d0sx2kJRdGc2RdG4rqiSBEIc2m4NXg16rJXSVgkgi4C881Yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P123MB6932

Currently, to audit active Ftrace event filters, userspace must
recursively traverse the events/ directory and read each individual
filter file. This is inefficient for monitoring tools and debugging.

Introduce "show_event_filters" at the trace root directory. This file
displays all events that currently have a filter applied, alongside the
actual filter string, in a consolidated system:event [tab] filter
format.

The implementation reuses the existing trace_event_file iterators to
ensure atomic traversal of the event list and utilises guard(rcu)() for
automatic, scope-based protection when accessing volatile filter
strings.

Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 Documentation/trace/ftrace.rst |  8 +++++
 kernel/trace/trace_events.c    | 58 ++++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+)

diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
index 639f4d95732f..4ce01e726b09 100644
--- a/Documentation/trace/ftrace.rst
+++ b/Documentation/trace/ftrace.rst
@@ -684,6 +684,14 @@ of ftrace. Here is a list of some of the key files:
 
 	See events.rst for more information.
 
+  show_event_filters:
+
+	A list of events that have filters. This shows the
+	system/event pair along with the filter that is attached to
+	the event.
+
+	See events.rst for more information.
+
   available_events:
 
 	A list of events that can be enabled in tracing.
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index b16a5a158040..5ede4214c4df 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -1661,6 +1661,32 @@ static void t_stop(struct seq_file *m, void *p)
 	mutex_unlock(&event_mutex);
 }
 
+/**
+ * t_show_filters - seq_file callback to display active event filters
+ * @m: The seq_file interface for formatted output
+ * @v: The current trace_event_file being iterated
+ *
+ * Identifies and prints active filters for the current event file in the
+ * iteration. If a filter is applied to the current event and, if so,
+ * prints the system name, event name, and the filter string.
+ */
+static int t_show_filters(struct seq_file *m, void *v)
+{
+	struct trace_event_file *file = v;
+	struct trace_event_call *call = file->event_call;
+	struct event_filter *filter;
+
+	guard(rcu)();
+	filter = rcu_dereference(file->filter);
+	if (!filter || !filter->filter_string)
+		return 0;
+
+	seq_printf(m, "%s:%s\t%s\n", call->class->system,
+		   trace_event_name(call), filter->filter_string);
+
+	return 0;
+}
+
 #ifdef CONFIG_MODULES
 static int s_show(struct seq_file *m, void *v)
 {
@@ -2488,6 +2514,7 @@ ftrace_event_npid_write(struct file *filp, const char __user *ubuf,
 
 static int ftrace_event_avail_open(struct inode *inode, struct file *file);
 static int ftrace_event_set_open(struct inode *inode, struct file *file);
+static int ftrace_event_show_filters_open(struct inode *inode, struct file *file);
 static int ftrace_event_set_pid_open(struct inode *inode, struct file *file);
 static int ftrace_event_set_npid_open(struct inode *inode, struct file *file);
 static int ftrace_event_release(struct inode *inode, struct file *file);
@@ -2506,6 +2533,13 @@ static const struct seq_operations show_set_event_seq_ops = {
 	.stop = s_stop,
 };
 
+static const struct seq_operations show_show_event_filters_seq_ops = {
+	.start = t_start,
+	.next = t_next,
+	.show = t_show_filters,
+	.stop = t_stop,
+};
+
 static const struct seq_operations show_set_pid_seq_ops = {
 	.start = p_start,
 	.next = p_next,
@@ -2535,6 +2569,13 @@ static const struct file_operations ftrace_set_event_fops = {
 	.release = ftrace_event_release,
 };
 
+static const struct file_operations ftrace_show_event_filters_fops = {
+	.open = ftrace_event_show_filters_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = seq_release,
+};
+
 static const struct file_operations ftrace_set_event_pid_fops = {
 	.open = ftrace_event_set_pid_open,
 	.read = seq_read,
@@ -2679,6 +2720,20 @@ ftrace_event_set_open(struct inode *inode, struct file *file)
 	return ret;
 }
 
+/**
+ * ftrace_event_show_filters_open - open interface for set_event_filters
+ * @inode: The inode of the file
+ * @file: The file being opened
+ *
+ * Connects the set_event_filters file to the sequence operations
+ * required to iterate over and display active event filters.
+ */
+static int
+ftrace_event_show_filters_open(struct inode *inode, struct file *file)
+{
+	return ftrace_event_open(inode, file, &show_show_event_filters_seq_ops);
+}
+
 static int
 ftrace_event_set_pid_open(struct inode *inode, struct file *file)
 {
@@ -4399,6 +4454,9 @@ create_event_toplevel_files(struct dentry *parent, struct trace_array *tr)
 	if (!entry)
 		return -ENOMEM;
 
+	trace_create_file("show_event_filters", TRACE_MODE_READ, parent, tr,
+			  &ftrace_show_event_filters_fops);
+
 	nr_entries = ARRAY_SIZE(events_entries);
 
 	e_events = eventfs_create_events_dir("events", parent, events_entries,
-- 
2.51.0

