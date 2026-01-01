Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020113.outbound.protection.outlook.com [52.101.196.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DB11A9FA7;
	Thu,  1 Jan 2026 23:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767310464; cv=fail; b=R7x6xy7I1S7nU7dlNFWRNa2Enn4sfF0nOiw/jcpal1Ega2gCh18V7EitEtG5/glMK81V/SvApCjq/eCn9Te7GNmJFX59v3Sr3QYy7jf9zPNZ5fPzvJzInAJyeWVGCpm1kGLZYI2eN2MuEASlYk6JkoJ+iKWgAaVVAr/rXBmwGcs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767310464; c=relaxed/simple;
	bh=EPAeQRoQ4rscN+7JAGuFHehrM6E5dMorIstmQ7bujOY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=BCDXU8XtQCeTBtqduNY/5AvpwBOdiLkCFH7kJQSXsm7MuFyXNX9FyKZU/3rBHNFXomKAh4KkNFqraSz0bhc7/6aoIcC5RqVET6Tk4H1Q+bKS06Aey29NID3tqKABKzfBsMZrWOwyiSqH3qXCdD/sXCTC23sqXmZ4dGLWSJjjgQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.196.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yQ9q91ulR0TRb5qvmMNuQ6zCkodzt/87avXvq4mkoQ+NatkV+oCzlvj7ozeFW+l0f8IyHIR87lHbrULL5gOd1WazD3y+oWQ9+n1jILGO8jxYa8yK+atnZSab65z533CeRDk32P6oMDwT+mW1ZEdU7PiqMs4KNjSl4ImIdmhww85PZLuTAnbtOMfGYgttcenyxN8WrntGB6UKm3ZvWnqtTNT1op23TeWZZ9mV69TkIsT3A0qAYrTgTSE7OxnkXDtMMwnwI9wJU4IQsI7brZIjl7pjaoW/NNyh1RW7mspQxkxNugnmLg5j2oRnyZ7wFFn/SHB5z1qpUAbneauf8izoYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+BOUJrdvJdfYmxWQIYEuL4VaqHAkT1gw0TUrEx2LK5M=;
 b=uD7/CG01JKrJP0C0VgyVEEN0DtG/LSkNBnR0BRxCMhuBv5r+bsmHY4RIQPIzGpnKz3diCA234chEB+i9qNTUJgfCdP7/95lCvpkqzuclVOotG2pCm0f2qaTE7IyVniyK8dVl7ErZufSBRosBWMBFvWE593udqebWCnma7Zc8WS3XNa6Iw/ZQsVR3qLJ5k2oGfHYCtZVzxFmd/Cxk7qlm9q2PqBsEqkFcHjbuP4fq4kpDfo9KErHY6zOKw8GkmOsusmx9KvGr42/AbQpTkLZxX5HOCl9rlqrSzxzAUCE/3R9IpGnuxFNUzBHYIkmBkzmf+TrVUzxyd3lSMZo6vgsyDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LOBP123MB8167.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:444::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Thu, 1 Jan
 2026 23:34:19 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%5]) with mapi id 15.20.9478.004; Thu, 1 Jan 2026
 23:34:19 +0000
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
Subject: [PATCH] tracing: Add show_event_filters to expose active event filters
Date: Thu,  1 Jan 2026 18:34:14 -0500
Message-ID: <20260101233414.2476973-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN1PR10CA0030.namprd10.prod.outlook.com
 (2603:10b6:408:e0::35) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LOBP123MB8167:EE_
X-MS-Office365-Filtering-Correlation-Id: f8052da2-7cda-4fac-2dd2-08de498e48b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QkdS2rBoVVrDCy6XgBf1fodvqxMx1yPNTTF7skSnEluM4EmmzGuijaS445bt?=
 =?us-ascii?Q?l996K71zGPkKzdmlAOVuQySQ5/jg3Kgp9aptI7sivjCSX5tOrm3+Ss8NX28n?=
 =?us-ascii?Q?7/mF+dOFp1WX7b9gyypdv5BYFNSSA/fxd59rGyj0fKxJm6jrthM0fnbn0ETZ?=
 =?us-ascii?Q?SLzwpWnhMpYHGZdwowC7NIOkfdj267/LMyoE+cJjkwmrejl4zXvSo638bl7h?=
 =?us-ascii?Q?DYUqi7ZHrusFnb4QjcraMbs8L/iup4l/st+GTxyqnQB6jsci1Tjy1MsjVuCb?=
 =?us-ascii?Q?ApUv4p46i3IyPKkknIgv2DjBP3wqO7qTVoXAZfkoJZ+kfrL5lt8M8jkOeWSw?=
 =?us-ascii?Q?8SZkpABjEW1HRPyfVK4HuD06ndvTcCBpUwlquvY8Bx6Onvu0U/ttGKoZOeOu?=
 =?us-ascii?Q?xv/INh5rVEC+2RJKprWwddAqOM4Y9NMMiT6fL7/AK+LK4ZKiUZCF4mEQfsmx?=
 =?us-ascii?Q?uNdAzPCoAJi1UFGT3953c5YZx1iDXHIWtbip7RQGWI+QN6m4xUIU9TUop2L2?=
 =?us-ascii?Q?tLiSIwdVd6PcMlj1Ez2EiaghHkzx3ki4+B6Tw3QmmaPC6v0zlOJTwana7HFz?=
 =?us-ascii?Q?LTbZe0pYKQIiHU1O0WFUbnvuy+E75Mc+WERkI9gwV8glag6yj51p+KfDBUID?=
 =?us-ascii?Q?AvKj0F0e+aWa5CIUIsIHIlJfV45FsgfnBfV0T4r5QGyw8LpxZmnhmSuh5j3f?=
 =?us-ascii?Q?3gJCGxS/PLWd+JOUSDxlFF4Zmz3NHr5nIw2Q3lkgHzkcemS9CItg6zUeNRzo?=
 =?us-ascii?Q?Ed5/ghxGPUtSlj+9h83akU5hnefCGo9wfehOA22oLBN7k1q2W/dJXj1z9yVc?=
 =?us-ascii?Q?kYXLUq4SCUTyxgyRAPpD1VwhzFyqtvJM1O7uRUEjigY5R5sD52uiqfgHX9hu?=
 =?us-ascii?Q?eZW/m/RzsCccIZPpC1/uthjdnBP18B6QSJE3q98Q/xrujAdMh2x9KDytjkzD?=
 =?us-ascii?Q?reBQ4KeIZ6yU3ZNscKxykaxOQm41HlMAnVylzFVaiP2UW9fL3jPsXpdwMnnG?=
 =?us-ascii?Q?bYT2+U7tRBmHkHgNGK19TKQcK4RUeiqHwFhiU/cGMJrwacPr31cHi4C7Imq1?=
 =?us-ascii?Q?94VNAZaw7Nt3NNFQ2DZlKpuXSVv4Idb/dtAJc04IhDa/ik/y5E/FkUvHgjmn?=
 =?us-ascii?Q?DoTUci74R1K9v6gapxPKR2k/yejxR45mDA6+4x+o45H59uExD+29fah52RUX?=
 =?us-ascii?Q?y1Jbpbyzv4lX3Ok8E4Nv1pYzuGXHP5cyu/78uCeS97u6uqIWOGPqFUWcSlP4?=
 =?us-ascii?Q?8zDqDm1f5Em1nvaxLbsYE67MfpyPcwEtuIsf19ks95nvUYByaLSUMQKL+0+H?=
 =?us-ascii?Q?dXvNwqH43CvcMwkdoZf78CdAWXuN0HymaXBsP9l2+ZYwaEsDZQbYe7/1AcAb?=
 =?us-ascii?Q?eyOQKLtZiwEPKuXcj61LBmqkxSJU87QvoxK858X2swpH838mcOE8VgVHic5U?=
 =?us-ascii?Q?Wg7neIPBKJRFu/3WTRgKfbYZHYbCRf1R?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Lt8eua8qx2nCNkkWyE9WFvKFn2sexxFzNNIXJ1c0tAgSCFeFh7nPT/ma5XTP?=
 =?us-ascii?Q?UToLB4PZJH0fkJRRtrxXECDOweuG7dWLE6bG+WoBnKN0SVvhSoOYoY3sUzh1?=
 =?us-ascii?Q?6V0dGeNqWgLaoFlhJ6VqhST/zCQJAEmfv1qfbUUcyBz9SRksl5pz18fGU4WA?=
 =?us-ascii?Q?dxf10R6zKLJudif0nLa9G4SqzljO+GSl5WDVSLHuDMMJh0BLu3XbETK7X92z?=
 =?us-ascii?Q?L9HFQizAv6sJ9EVrgCmdJ6gJ+IlW5BURGJudr1qZvgagxVSAhFaSVFS4d4aU?=
 =?us-ascii?Q?mcgeva8oZbD6IJa9GErEn7H9IKCxjmzm+DkTnEPwerh2eo/jQDg53baJzFAR?=
 =?us-ascii?Q?OWsxcJP88zejkcBdLeA2JEMJuGscnkkI6W3GjAxiH4eiVkMSTXy13f2FETcr?=
 =?us-ascii?Q?e14ZevSMP1B9mfzUfbHWxjXJ0lVa5Vr9SoTVo+REVwrBMhdUuA6/iYt7uEUR?=
 =?us-ascii?Q?GFRLCejujHboRHvC+z/jio352DApzXjCFfRp2kFisRdLWSWT8gZVaE7aqYS1?=
 =?us-ascii?Q?3vsZIHgHHsx57CqPkxNvwQd1fx6+K7KlktgK1duIepcQgLmpX6c96lM7jXB/?=
 =?us-ascii?Q?6cGgo+FnCWXT5tWm/bGL29RgBSaVUypbiXe+TVOESvpX67pwq6vmFp4i6zRF?=
 =?us-ascii?Q?E+p/piBHWwbNPWxGk8lUALmSoTPRnOfC7W1Z+poarA+4aCTTng+lC5bTt2eg?=
 =?us-ascii?Q?2FPVGPbR7UAaIfTJSUGesmGAxpiqUb8X4jbrrhMv2i4ShtsvVrT75ue/8r2N?=
 =?us-ascii?Q?CBU/8wwGzPyt1+1TrFF2MVCZ4ern67ra4JIjhNMKZTx0jTFfSdtplpqBVNnz?=
 =?us-ascii?Q?4HKNJFvmSFfV4pERH0/a2ikuO6UQIEW7LwHdod9S9q9jfvGoZFh3fw4NzSTb?=
 =?us-ascii?Q?cmiRDVbyJ/MrTnIzB+YBG6p1sBS3Rn5rvE8Pu0YXbxcfNUptlLTBszugwApS?=
 =?us-ascii?Q?quwG58Pw326YD3Ae3PiuxSImllS/mxyR0uMmP+kqsvouIVLeF/1jY1q8PA2S?=
 =?us-ascii?Q?IX4zpwLctReCzijtizXgGwTTKXpDnsSFus79tPMvFpH16rDeFMlqR5T6ZKD+?=
 =?us-ascii?Q?FKNweiw2RTn0SI6r5d/YvN/OG7HcMOd53S0RFfX+WhHzg2xTGeD4dIPgEIKE?=
 =?us-ascii?Q?8amoI8X2FSej2/tRRkVd96ipGv/n6nyiOtks7KOIA8/B8pwV636FNBEO+5U9?=
 =?us-ascii?Q?8AZjboXOxSy7lMCXCt1MMbe7I/x64mh9tXlK3kPvuguzqcr1DtDIvTbnDlmm?=
 =?us-ascii?Q?R5/MIX9nDZwAt5u1p2/bIAuMUjpWnlNJ1w3X0RlELpLUUIMMpuUogX1w7djX?=
 =?us-ascii?Q?2o1Vu0WMWPNfqmPleOGnsYF0sPQHrL91iByJjUsQxfMK5fy+SYCtuLJLYENH?=
 =?us-ascii?Q?F8h28vwTTolSOUU+v9tT/fvPJQZtiv4TjMx1HEb0TrWmUbXicYHxeuJXKuVH?=
 =?us-ascii?Q?AYX7UmnVGVUn6C1ThNPS9SbLkloJKwXFlTEeH3AnMxqMwKGcCus0UIrhKaR+?=
 =?us-ascii?Q?MTw5AgIRYChtmg/OroQZnXhpwQRodIMW8UF/tARs8V0tU1N6qLFJBlJY+lpm?=
 =?us-ascii?Q?UELZMSHF/nee2SwVsWnhHrlDNuJPj06XMdTak1/CFq6tSYenwpLyl761RIEX?=
 =?us-ascii?Q?1DoDQUieh8kwxSW/QZknZXkW7o1hel6eW+zDrgUjZ5kuXOhWcrDFPUwvOv5N?=
 =?us-ascii?Q?intwk8+ukoADYXiFFNxnda6kBqtGvA86ps41AFvreNKVRRBjK9Rfwub2o0Om?=
 =?us-ascii?Q?/BBIlGnseg=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8052da2-7cda-4fac-2dd2-08de498e48b8
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jan 2026 23:34:18.9602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fjxObxcAZJZhQw9ctfZ1El6bo0XIn71xmR9tye5gCWwTOp37ohcvicACvhkviva3V8IUO6SoR6pvqKxLWXMXPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOBP123MB8167

Currently, to audit active Ftrace event filters, userspace must
recursively traverse the events/ directory and read each individual
filter file. This is inefficient for monitoring tools and debugging.

Introduce "show_event_filters" at the trace root directory. This file
displays all events that currently have a filter applied, alongside the
actual filter string, in a consolidated system:event [tab] filter
format.

The implementation reuses the existing trace_event_file iterators to
ensure atomic traversal of the event list and utilises rcu_read_lock()
to safely access volatile filter strings.

Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 Documentation/trace/ftrace.rst |  6 ++++
 kernel/trace/trace_events.c    | 62 ++++++++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+)

diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
index 639f4d95732f..27ea54bfbc52 100644
--- a/Documentation/trace/ftrace.rst
+++ b/Documentation/trace/ftrace.rst
@@ -684,6 +684,12 @@ of ftrace. Here is a list of some of the key files:
 
 	See events.rst for more information.
 
+  show_event_filters:
+
+	A list of events that are enabled and have a filter applied.
+
+	See events.rst for more information.
+
   available_events:
 
 	A list of events that can be enabled in tracing.
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index b16a5a158040..f578ee2e5c12 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -1661,6 +1661,34 @@ static void t_stop(struct seq_file *m, void *p)
 	mutex_unlock(&event_mutex);
 }
 
+/**
+ * t_show_filters - seq_file callback to display active event filters
+ * @m: The seq_file instance
+ * @v: The current trace_event_file being iterated
+ *
+ * Traverses the trace_array event list and prints the system, name,
+ * and filter string for any event with an active filter.
+ * Uses RCU to safely dereference the volatile filter pointer.
+ */
+static int t_show_filters(struct seq_file *m, void *v)
+{
+	struct trace_event_file *file = v;
+	struct trace_event_call *call = file->event_call;
+	struct event_filter *filter;
+
+	rcu_read_lock();
+	filter = rcu_dereference(file->filter);
+	if (filter && filter->filter_string) {
+		seq_printf(m, "%s:%s\t%s\n",
+			   call->class->system,
+			   trace_event_name(call),
+			   filter->filter_string);
+	}
+	rcu_read_unlock();
+
+	return 0;
+}
+
 #ifdef CONFIG_MODULES
 static int s_show(struct seq_file *m, void *v)
 {
@@ -2488,6 +2516,7 @@ ftrace_event_npid_write(struct file *filp, const char __user *ubuf,
 
 static int ftrace_event_avail_open(struct inode *inode, struct file *file);
 static int ftrace_event_set_open(struct inode *inode, struct file *file);
+static int ftrace_event_show_filters_open(struct inode *inode, struct file *file);
 static int ftrace_event_set_pid_open(struct inode *inode, struct file *file);
 static int ftrace_event_set_npid_open(struct inode *inode, struct file *file);
 static int ftrace_event_release(struct inode *inode, struct file *file);
@@ -2506,6 +2535,13 @@ static const struct seq_operations show_set_event_seq_ops = {
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
@@ -2535,6 +2571,13 @@ static const struct file_operations ftrace_set_event_fops = {
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
@@ -2679,6 +2722,22 @@ ftrace_event_set_open(struct inode *inode, struct file *file)
 	return ret;
 }
 
+/**
+ * ftrace_event_show_filters_open - open interface for set_event_filters
+ * @inode: the inode of the file
+ * @file: the file being opened
+ *
+ * Connects the set_event_filters file to the sequence operations
+ * required to iterate over and display active event filters.
+ */
+static int
+ftrace_event_show_filters_open(struct inode *inode, struct file *file)
+{
+	const struct seq_operations *seq_ops = &show_show_event_filters_seq_ops;
+
+	return ftrace_event_open(inode, file, seq_ops);
+}
+
 static int
 ftrace_event_set_pid_open(struct inode *inode, struct file *file)
 {
@@ -4399,6 +4458,9 @@ create_event_toplevel_files(struct dentry *parent, struct trace_array *tr)
 	if (!entry)
 		return -ENOMEM;
 
+	trace_create_file("show_event_filters", TRACE_MODE_READ, parent, tr,
+			  &ftrace_show_event_filters_fops);
+
 	nr_entries = ARRAY_SIZE(events_entries);
 
 	e_events = eventfs_create_events_dir("events", parent, events_entries,
-- 
2.51.0

