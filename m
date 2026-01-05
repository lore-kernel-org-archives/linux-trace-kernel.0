Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022126.outbound.protection.outlook.com [52.101.96.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2FB2FE060;
	Mon,  5 Jan 2026 14:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767623395; cv=fail; b=Joc0EIJTg5FJLrwAJ+imEBG22+z893pKvO2+ent1WAZyENfNEgQO5edEc0stwNHU1iXhs83vfr8d3V/zqpbrgNF/y+nb8FIkfiUfHWKXevHb53caxfTO11rZOTT9qVWFJalCS2SntmBw/zoN9VG7FNgnk2TWHDdBRpy8IPKbDdE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767623395; c=relaxed/simple;
	bh=8Sskcd2nTUBOGFkT6aDosWrldGqp18IiEoB2T2A5yfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X1mN+ylyrs0vhfPj8gYE3H7+5yCfTaHfrZHTrIng66RtQNmtm7GH1uR7QxQJBrq60HpINUHeoXb5u8u4+2MDVzAtXCI3Uvt9nmwORd2PqKvBU3ki2a2wM/yW4VFRlBN0ou+fIVhbEaM/TunfKAWJCPhX7+Et2dIY58jK6db7mIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.96.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZeesS4WMX9A0iYx3bEnWzCwy3L5pJn+L9jXQv9rKcS7egbMKbUyo2P+ebRXQKSqBLqFu1/qPu0fUuY7z2zB8WXCmP3V0X3tge0tsu4LkxN7XzwXjwEIUaOL/vhRWwtVSP92fYJWaH7l40v0J+hVwCOUg6LI5S04mVW+lftqaG5uMymd6ky2oFBJn+wRfSu+JmoDWxHisy0C854DCHsW3aNohETmKUcU1pvtSskQG3AMwKmsPTt5EQm5/s0pis1u/iXknE5vuUGCEtT3wGUBMF4zFa+OAgK5VUHkgAlNyvC4J4Y9O/5SB/dZWFBaC6S95xZtRQZ3lUIXRXfEnlKXkSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6bqLrvkWi3tcqaqMJa5S2cjc5X7DdbcsrvEP7oDKWIg=;
 b=uuZsI55T9VhgCHZGlY4R9uonJ80f1VGSUIUWzowmnfIOeuqRWdEvcicdrut50b6Wlg14VPGCVEdG2VaiYCsKJpDXZMvSwf66Y7ctoQvS1A0Ew5bmYNvPFm48ZieSILo/bGi85UqMxNll43398v07ekVUzqj2VC5VIZMWxLG1oYC+2qSuKnqcSiUGEtdgsvwkuTzzqaz9zo4muFVo8q3z+aF4e1HzByJx5v/IvhBG3nEd09cdS1pFOirvrZ9W5mhSFlYgxa5fIoy1c9Vq9SzT2Mcpca+eIOYtJZBvLryJGImDqt4XRSdBvvuhHaaoXrH+iIvx2+dSCMv8Kyy1qbFz/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LO6P123MB6932.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:324::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 14:29:51 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%5]) with mapi id 15.20.9478.004; Mon, 5 Jan 2026
 14:29:51 +0000
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
Subject: [v2 PATCH 2/2] tracing: Add show_event_triggers to expose active event triggers
Date: Mon,  5 Jan 2026 09:29:39 -0500
Message-ID: <20260105142939.2655342-3-atomlin@atomlin.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260105142939.2655342-1-atomlin@atomlin.com>
References: <20260105142939.2655342-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR18CA0005.namprd18.prod.outlook.com
 (2603:10b6:208:23c::10) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LO6P123MB6932:EE_
X-MS-Office365-Filtering-Correlation-Id: 27a95066-118f-4a56-af5b-08de4c66e2d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?B1Sf4jC03SQTqmqOwOAaycdZe45HYKtzgyXatW0KUK0QLWb9QmGIbiNdOpy6?=
 =?us-ascii?Q?rzRHtAAUM3Re4CYmWVZTX6uqfW99h3m/N02LXspUOgkAxcQClEowGzaU3q44?=
 =?us-ascii?Q?YN/2ppGr03jD7Lbs2sTcv4sqEvCEF6pB6OTZioova87w80Cz1qTXgp91ENnN?=
 =?us-ascii?Q?jFdu8u2zB2JqlqB2is46lW7SFkGcou/0kW+6ATvUz0fn/Nk3VY9Dj3QCczY5?=
 =?us-ascii?Q?21NmNJ7lPwwwQ2DoDX5MI3IGPxMod+Pm6leOLTHYlm9wuBFVN3fvEWPtH1Sy?=
 =?us-ascii?Q?zKvgwZr+V9I0zp9CnjaykvJDypBUuGTe4pGeAuDOC0qoapmVhXXjb5cvDxIg?=
 =?us-ascii?Q?aZKBpvF2r3Jy0kRTExJZwG1a3yII+VOIw7b3Eq4h8H+1A2R+ayPNNpNr2+NJ?=
 =?us-ascii?Q?+/aR3J9rPKw03h57Ut6UcRfb+oMKDiEL8qA1asULFNgPs6FldtZPN6OZNDbp?=
 =?us-ascii?Q?NAiOtADYwxTiWumaZMTvuVfO8/1dsO9EDS7Xz3UOC8OrIaHjvO9fwi7T5ya4?=
 =?us-ascii?Q?gEW5+SDXtrrv4MznJCE0pddBIlYDfTMJi+P6JASYv6WVodkbOxX97Qd81Q+3?=
 =?us-ascii?Q?y9B+dPHQ3FQhWEhLN7TC7gt6MoBS+56d4UttTvMQJSIB3tJ1qTVt0dmcLrG4?=
 =?us-ascii?Q?5ddOh/f42/cbduCsM+WCvNls4m1CiIzq+CIoPety+8kZ+MwW/YnB+ub5PAwW?=
 =?us-ascii?Q?zCPAlJixx+uUBP+f/W0kBM11Ol4MN1n8sY6479OyKadPow0meKlJuNgm/lGO?=
 =?us-ascii?Q?LhyFfxszIFUBD4RP8T5ctLbnsc187PZ/GzvCksryT+w+thboAONV3rDVyGnU?=
 =?us-ascii?Q?bzVS9Dr403qMxPD7X295EqkJgNdgf6+MOfS24MQLal1sY+lpClPFg3TpJlE0?=
 =?us-ascii?Q?SfYsEWrbRyUjgFv+EdYkaZc+uQc71ohaLOHF/gEXxRiSTH3YzN2Dxt8/R1oe?=
 =?us-ascii?Q?Fd3qVnI3+qmjkzDzkpT1irCL+TpqsVyu4R9I4R7c2a7qgDX7lCxZ+NNA5fGD?=
 =?us-ascii?Q?Y0shTTCYSPmXoMmeL/gj/ZdzB+jA4bwcX4pUgObBckpDQGMizHSwhunIDCrY?=
 =?us-ascii?Q?gJRJZ/2AcwTp5NpvlYMQj67WZ/3HM2wZDcWO+aVYSZeZEUCPAvsEQM7/R3hE?=
 =?us-ascii?Q?nm/cop8xhkkKpJbjyL6vSNWDPDUu+DAZFxp34ZJzUnBQW9IGYuMrq4ePKmao?=
 =?us-ascii?Q?QZ5XHVIO2l2lti/dSkEbwHtIzOsM7I36UpGAZwvxKuhu5Fh/B44MXX+/opTA?=
 =?us-ascii?Q?FPYiUvGJEi9ewygV9x4MU6g+GBkUr9GlKXMolUKDJ0vv7YdfgPNvAkxvKl+M?=
 =?us-ascii?Q?J/fG8Mll+lai1TNtMN6wDRcuaqiX5iP8syC0mlVK559nRGWx8SPMR6cFlFuD?=
 =?us-ascii?Q?awUqK6PXx+QRMTnl6MXKJIp4u+YOnhfcCxEq4V/8HawJYcnVqYBivmfm1BJx?=
 =?us-ascii?Q?XvOCgjP/Nt5/FTtL/cuRMXNsm3+0u0tL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lXLpKAtiL1ZKDpgBw8rm5PPsXuUohiUy4InayjVIZyQGaRT9yyQZEuCmu91d?=
 =?us-ascii?Q?yHvL3x37AHm7iCI+l1dVnNfs2zSCDG4fikGXnn0UYF1EeWTF7fuBk6S3YYb5?=
 =?us-ascii?Q?66ZXz8roI+6S7QVN1me8to4Z4Gk9kCaZcS0nswSO87JtrnKvjpN7Ai/27Zkd?=
 =?us-ascii?Q?trFHcLsNH2KiQClbA5rjp8r1WS1QVTCIs8w/TMUwJ1DwJqdGR8V2TwPJ0LcS?=
 =?us-ascii?Q?63p+fqK+M7mcgrhQ7JTrRAqVDzViNeKVeAP7bGpEgUx9p2owNnzl2WfuDrFM?=
 =?us-ascii?Q?Cdx9mwU34VBDuJ0ojji2lhPAqMyZiT4BnJjrL09LawflNYXZmNkg8VgRJuV/?=
 =?us-ascii?Q?r0GwVIAaVkpQYz5VU7VwLuuWFJXAcNsET72OcuW1ECZ8dUXWlLQThWRkkFCr?=
 =?us-ascii?Q?Y+/AkrdeB81wCZWk7LsOnmCbLjSltIzaa75m7sBa05QyKKgYdFoKkz7R61Y/?=
 =?us-ascii?Q?T4a8pK9AU00UrpJ/Dd7HKOUGEaBQ0yMsfmkvlN9cREZnqgDwdWPvfeQfLfi0?=
 =?us-ascii?Q?eV8CXXURSYXDKw899J1Jr7Rm7/tQHqrDpOVPIgMyan8ClVtenK49QOtUMAwv?=
 =?us-ascii?Q?dKR4LhlS3K+1FhXpK3mMPA0T5TQX0+UGpkHwBa9VJMMN6Tlp+bBvB3sM7LoA?=
 =?us-ascii?Q?yhMFJWnj/ZNu3J77eS4VSILuX+uu8hVSckwF+B7GVe0hpLQsd0yPeSuG1L1v?=
 =?us-ascii?Q?ONn1uerruzJB7prBDq7khhFXrZdgN+IAmYk2DSub5hhkhEoB3zNjoLmmTcrg?=
 =?us-ascii?Q?+eHsL1qazwg3SLh+8FszqBaNjI1w2Q8gzF3yVSts7yf3S6mLFWNQrhXbsvbl?=
 =?us-ascii?Q?A2xjD9NCdapisz+ac5Zrfa84o8pWsY9wg/+WTRxqTIo2SO9mrUpFrrQHsbfD?=
 =?us-ascii?Q?+Q/YXxYVNPZX2FhoaOFe64RXbNuqshk5F23Gq4hyrIW1HkqygKLXF5406o4E?=
 =?us-ascii?Q?rE22xvtnw+yFSdJFQ4r/mLUluXyG/AnQBI8hUEJRf1N3HArIiu1WqhdkRAON?=
 =?us-ascii?Q?rCWzSDPQWKb+oUt5CCW5WT/0k17yRLLPz0e9WmFWdoYDlsQj66klafCFO6N2?=
 =?us-ascii?Q?c5Gn5EWtcs+pWWEs3TFeSrtn2ApEyR24AOC/AbKy90hX2YALgpOLWgRZ1cyL?=
 =?us-ascii?Q?LALnwAcL9MTU9IdxMSjxUbz0cpPaG4suwF++8Suowjkv/7afKOZ5BCWjjqyH?=
 =?us-ascii?Q?Sx6kTVRocR8+J2PsKmwecD6S7x2AWkFPIkEr5jLHhW6X/GG37CZrQyUzt2JY?=
 =?us-ascii?Q?+ZW641y3xpv5xFU1DBhKGE7b+l8vJfUyiWVlERHtJBAEXlZcsCdF5laDqC3P?=
 =?us-ascii?Q?pop6iOP4vkQtKzKsOxU4ZXLZO3r3o7Up4ed6lzfI6U8z5kR3OQejaqz6sh8W?=
 =?us-ascii?Q?FRQsG45gs60HXX6so5UH62eOxu/1gODlittMaJzQ/9pY90cvqtNftIe+NxVL?=
 =?us-ascii?Q?yL6oyk/SJW7D5Bmu4NxoKCDKv1cLtrX8mDi01veV4+L2CTHBztv2G/H8YN7f?=
 =?us-ascii?Q?XhjeJ+HWCoSiIE7eu+Flff+3q8MLoPGf3rDkUd+DI1ZdK+Ng9pVrKUrAfeZG?=
 =?us-ascii?Q?7laFjLgeXtXxkNYHYAfJEbabVfU84oDVs9OT/PzlnoNH4bYEkRJMx55oAnsu?=
 =?us-ascii?Q?Y/kiE02c4vwInwVpMIFc6uk3Cb3aDO4TdviXix1M3jb48U0PDUCzW71qHStc?=
 =?us-ascii?Q?bYIZvkw8ZN2d7AX/suFNvws3lK+HI49ax7EzIrRVBcpuWifDfeml0FSfS2xU?=
 =?us-ascii?Q?w9uUj4T3MA=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27a95066-118f-4a56-af5b-08de4c66e2d1
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2026 14:29:51.0912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TtdpHmnY8E+4MW4R8lfpR1y73Bn3tOwqthKjUa+tHfpA//50XBymAq8vVdIokRqJrMYUFljfwdBfIDe2QwCUyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P123MB6932

To audit active event triggers, userspace currently must traverse the
events/ directory and read each individual trigger file. This is
cumbersome for system-wide auditing or debugging.

Introduce "show_event_triggers" at the trace root directory. This file
displays all events that currently have one or more triggers applied,
alongside the trigger configuration, in a consolidated
system:event [tab] trigger format.

The implementation leverages the existing trace_event_file iterators
and uses the trigger's own print() operation to ensure output
consistency with the per-event trigger files.

Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 Documentation/trace/ftrace.rst |  8 +++++
 kernel/trace/trace_events.c    | 64 ++++++++++++++++++++++++++++++++++
 2 files changed, 72 insertions(+)

diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
index 4ce01e726b09..b9efb148a5c2 100644
--- a/Documentation/trace/ftrace.rst
+++ b/Documentation/trace/ftrace.rst
@@ -692,6 +692,14 @@ of ftrace. Here is a list of some of the key files:
 
 	See events.rst for more information.
 
+  show_event_triggers:
+
+	A list of events that have triggers. This shows the
+	system/event pair along with the trigger that is attached to
+	the event.
+
+	See events.rst for more information.
+
   available_events:
 
 	A list of events that can be enabled in tracing.
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 5ede4214c4df..e2a67561253d 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -1687,6 +1687,38 @@ static int t_show_filters(struct seq_file *m, void *v)
 	return 0;
 }
 
+/**
+ * t_show_triggers - seq_file callback to display active event triggers
+ * @m: The seq_file interface for formatted output
+ * @v: The current trace_event_file being iterated
+ *
+ * Iterates through the trigger list of the current event file and prints
+ * each active trigger's configuration using its associated print
+ * operation.
+ */
+static int t_show_triggers(struct seq_file *m, void *v)
+{
+	struct trace_event_file *file = v;
+	struct trace_event_call *call = file->event_call;
+	struct event_trigger_data *data;
+
+	/*
+	 * The event_mutex is held by t_start(), protecting the
+	 * file->triggers list traversal.
+	 */
+	if (list_empty(&file->triggers))
+		return 0;
+
+	list_for_each_entry_rcu(data, &file->triggers, list) {
+		seq_printf(m, "%s:%s\t", call->class->system,
+			   trace_event_name(call));
+
+		data->cmd_ops->print(m, data);
+	}
+
+	return 0;
+}
+
 #ifdef CONFIG_MODULES
 static int s_show(struct seq_file *m, void *v)
 {
@@ -2515,6 +2547,7 @@ ftrace_event_npid_write(struct file *filp, const char __user *ubuf,
 static int ftrace_event_avail_open(struct inode *inode, struct file *file);
 static int ftrace_event_set_open(struct inode *inode, struct file *file);
 static int ftrace_event_show_filters_open(struct inode *inode, struct file *file);
+static int ftrace_event_show_triggers_open(struct inode *inode, struct file *file);
 static int ftrace_event_set_pid_open(struct inode *inode, struct file *file);
 static int ftrace_event_set_npid_open(struct inode *inode, struct file *file);
 static int ftrace_event_release(struct inode *inode, struct file *file);
@@ -2540,6 +2573,13 @@ static const struct seq_operations show_show_event_filters_seq_ops = {
 	.stop = t_stop,
 };
 
+static const struct seq_operations show_show_event_triggers_seq_ops = {
+	.start = t_start,
+	.next = t_next,
+	.show = t_show_triggers,
+	.stop = t_stop,
+};
+
 static const struct seq_operations show_set_pid_seq_ops = {
 	.start = p_start,
 	.next = p_next,
@@ -2576,6 +2616,13 @@ static const struct file_operations ftrace_show_event_filters_fops = {
 	.release = seq_release,
 };
 
+static const struct file_operations ftrace_show_event_triggers_fops = {
+	.open = ftrace_event_show_triggers_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = seq_release,
+};
+
 static const struct file_operations ftrace_set_event_pid_fops = {
 	.open = ftrace_event_set_pid_open,
 	.read = seq_read,
@@ -2734,6 +2781,20 @@ ftrace_event_show_filters_open(struct inode *inode, struct file *file)
 	return ftrace_event_open(inode, file, &show_show_event_filters_seq_ops);
 }
 
+/**
+ * ftrace_event_show_triggers_open - open interface for show_event_triggers
+ * @inode: The inode of the file
+ * @file: The file being opened
+ *
+ * Connects the show_event_triggers file to the sequence operations
+ * required to iterate over and display active event triggers.
+ */
+static int
+ftrace_event_show_triggers_open(struct inode *inode, struct file *file)
+{
+	return ftrace_event_open(inode, file, &show_show_event_triggers_seq_ops);
+}
+
 static int
 ftrace_event_set_pid_open(struct inode *inode, struct file *file)
 {
@@ -4457,6 +4518,9 @@ create_event_toplevel_files(struct dentry *parent, struct trace_array *tr)
 	trace_create_file("show_event_filters", TRACE_MODE_READ, parent, tr,
 			  &ftrace_show_event_filters_fops);
 
+	trace_create_file("show_event_triggers", TRACE_MODE_READ, parent, tr,
+			  &ftrace_show_event_triggers_fops);
+
 	nr_entries = ARRAY_SIZE(events_entries);
 
 	e_events = eventfs_create_events_dir("events", parent, events_entries,
-- 
2.51.0

