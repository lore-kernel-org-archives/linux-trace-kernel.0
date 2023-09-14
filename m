Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F56AEDE99C
	for <linux-trace-kernel@archiver.kernel.org>; Thu, 14 Sep 2023 10:03:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237811AbjINKDj (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Thu, 14 Sep 2023 06:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237853AbjINKDi (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 06:03:38 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F5E1BE3;
        Thu, 14 Sep 2023 03:03:33 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38E7ZxiM029921;
        Thu, 14 Sep 2023 10:03:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=KyA+nEmdtk8R8MKRTZzpPubH7GT/dfjPww38WZEEuFc=;
 b=djXKd/mmX1r/g8PksYwrzZw/00zbC6Ld2fQVTCtQLHD73ci4/wdgWlwe/srkCDzasglL
 9iisxFIoLVN7mMgL+PUaagkY71h5W6ULNsKvyWscFIG6/h92XTjAM2HeExUkOvqoKMnE
 lcpzArKAuxvGqOGyLTkVzGhhv3kTZcCY+f3vEBhEEwdrkkRAaqH5Q/hnM3B0gc8s4ZQ4
 MfpyULBPyDy6tInifz54Gip6GjzwNDKgF+5ox+fVHWbZDovcaA1i7eQpqJksi9iKWeVh
 rBqc3kqPxtUgZ2rBBYHq/8QzNzvITBkh+H8lpMW+P5CSDi5jwh2NjZLknRSjW6pneKx2 Kw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t3wx18c49-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 10:03:21 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38EA3KbT008939
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 10:03:20 GMT
Received: from linyyuan-gv.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Thu, 14 Sep 2023 03:03:16 -0700
From:   Linyu Yuan <quic_linyyuan@quicinc.com>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Bin Liu <b-liu@ti.com>, Peter Chen <peter.chen@kernel.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Roger Quadros <rogerq@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
        "Linyu Yuan" <quic_linyyuan@quicinc.com>
Subject: [PATCH 1/8] trace: add new DECLARE_EVENT_CLASS_PRINT_INIT class type
Date:   Thu, 14 Sep 2023 18:02:55 +0800
Message-ID: <20230914100302.30274-2-quic_linyyuan@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230914100302.30274-1-quic_linyyuan@quicinc.com>
References: <20230914100302.30274-1-quic_linyyuan@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 75pivQ8dbKe6h2AeL6mmjhjzybE7ZgZd
X-Proofpoint-ORIG-GUID: 75pivQ8dbKe6h2AeL6mmjhjzybE7ZgZd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-14_08,2023-09-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 adultscore=0 clxscore=1015
 phishscore=0 mlxlogscore=949 impostorscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309140085
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

This class almost same as DECLARE_EVENT_CLASS, it allow user add some
init operation before print at output stage.

Add a new macro TP_printk_init(), user can add operation in it.

Also add a new TRACE_EVENT_PRINT_INIT() macro.

Signed-off-by: Linyu Yuan <quic_linyyuan@quicinc.com>
---
 include/linux/tracepoint.h                 |  22 ++++
 include/trace/bpf_probe.h                  |   4 +
 include/trace/perf.h                       |  43 ++++++++
 include/trace/stages/stage3_trace_output.h |   3 +
 include/trace/trace_events.h               | 118 +++++++++++++++++++++
 5 files changed, 190 insertions(+)

diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 88c0ba623ee6..3fd42640236a 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -551,6 +551,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
  */
 
 #define DECLARE_EVENT_CLASS(name, proto, args, tstruct, assign, print)
+#define DECLARE_EVENT_CLASS_PRINT_INIT(name, proto, args, tstruct, assign, print, init)
 #define DEFINE_EVENT(template, name, proto, args)		\
 	DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
 #define DEFINE_EVENT_FN(template, name, proto, args, reg, unreg)\
@@ -576,6 +577,20 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 	DECLARE_TRACE_CONDITION(name, PARAMS(proto),		\
 				PARAMS(args), PARAMS(cond))
 
+#define TRACE_EVENT_PRINT_INIT(name, proto, args, struct, assign, print, init)	\
+	DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
+#define TRACE_EVENT_FN_PRINT_INIT(name, proto, args, struct,		\
+		assign, print, reg, unreg, init)			\
+	DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
+#define TRACE_EVENT_FN_COND_PRINT_INIT(name, proto, args, cond, struct,		\
+		assign, print, reg, unreg, init)			\
+	DECLARE_TRACE_CONDITION(name, PARAMS(proto),	\
+			PARAMS(args), PARAMS(cond))
+#define TRACE_EVENT_CONDITION_PRINT_INIT(name, proto, args, cond,		\
+			      struct, assign, print, init)		\
+	DECLARE_TRACE_CONDITION(name, PARAMS(proto),		\
+				PARAMS(args), PARAMS(cond))
+
 #define TRACE_EVENT_FLAGS(event, flag)
 
 #define TRACE_EVENT_PERF_PERM(event, expr...)
@@ -595,4 +610,11 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 #define DEFINE_EVENT_NOP(template, name, proto, args)			\
 	DECLARE_EVENT_NOP(name, PARAMS(proto), PARAMS(args))
 
+#define TRACE_EVENT_NOP_PRINT_INIT(name, proto, args, struct, assign, print, init)	\
+	DECLARE_EVENT_NOP(name, PARAMS(proto), PARAMS(args))
+
+#define DECLARE_EVENT_CLASS_NOP_PRINT_INIT(name, proto, args, tstruct, assign, print, init)
+#define DEFINE_EVENT_NOP(template, name, proto, args)			\
+	DECLARE_EVENT_NOP(name, PARAMS(proto), PARAMS(args))
+
 #endif /* ifdef TRACE_EVENT (see note above) */
diff --git a/include/trace/bpf_probe.h b/include/trace/bpf_probe.h
index e609cd7da47e..99b5594a4a8e 100644
--- a/include/trace/bpf_probe.h
+++ b/include/trace/bpf_probe.h
@@ -54,6 +54,10 @@ __bpf_trace_##call(void *__data, proto)					\
 #define DECLARE_EVENT_CLASS(call, proto, args, tstruct, assign, print)	\
 	__BPF_DECLARE_TRACE(call, PARAMS(proto), PARAMS(args))
 
+#undef DECLARE_EVENT_CLASS_PRINT_INIT
+#define DECLARE_EVENT_CLASS_PRINT_INIT(call, proto, args, tstruct, assign, print, init)	\
+	__BPF_DECLARE_TRACE(call, PARAMS(proto), PARAMS(args))
+
 /*
  * This part is compiled out, it is only here as a build time check
  * to make sure that if the tracepoint handling changes, the
diff --git a/include/trace/perf.h b/include/trace/perf.h
index 2c11181c82e0..bee78e8eef5d 100644
--- a/include/trace/perf.h
+++ b/include/trace/perf.h
@@ -55,6 +55,49 @@ perf_trace_##call(void *__data, proto)					\
 				  head, __task);			\
 }
 
+#undef DECLARE_EVENT_CLASS_PRINT_INIT
+#define DECLARE_EVENT_CLASS_PRINT_INIT(call, proto, args, tstruct, assign, print, init)	\
+static notrace void							\
+perf_trace_##call(void *__data, proto)					\
+{									\
+	struct trace_event_call *event_call = __data;			\
+	struct trace_event_data_offsets_##call __maybe_unused __data_offsets;\
+	struct trace_event_raw_##call *entry;				\
+	struct pt_regs *__regs;						\
+	u64 __count = 1;						\
+	struct task_struct *__task = NULL;				\
+	struct hlist_head *head;					\
+	int __entry_size;						\
+	int __data_size;						\
+	int rctx;							\
+									\
+	__data_size = trace_event_get_offsets_##call(&__data_offsets, args); \
+									\
+	head = this_cpu_ptr(event_call->perf_events);			\
+	if (!bpf_prog_array_valid(event_call) &&			\
+	    __builtin_constant_p(!__task) && !__task &&			\
+	    hlist_empty(head))						\
+		return;							\
+									\
+	__entry_size = ALIGN(__data_size + sizeof(*entry) + sizeof(u32),\
+			     sizeof(u64));				\
+	__entry_size -= sizeof(u32);					\
+									\
+	entry = perf_trace_buf_alloc(__entry_size, &__regs, &rctx);	\
+	if (!entry)							\
+		return;							\
+									\
+	perf_fetch_caller_regs(__regs);					\
+									\
+	tstruct								\
+									\
+	{ assign; }							\
+									\
+	perf_trace_run_bpf_submit(entry, __entry_size, rctx,		\
+				  event_call, __count, __regs,		\
+				  head, __task);			\
+}
+
 /*
  * This part is compiled out, it is only here as a build time check
  * to make sure that if the tracepoint handling changes, the
diff --git a/include/trace/stages/stage3_trace_output.h b/include/trace/stages/stage3_trace_output.h
index c1fb1355d309..121425e695f5 100644
--- a/include/trace/stages/stage3_trace_output.h
+++ b/include/trace/stages/stage3_trace_output.h
@@ -142,3 +142,6 @@
 
 #undef __get_buf
 #define __get_buf(len)		trace_seq_acquire(p, (len))
+
+#undef TP_printk_init
+#define TP_printk_init(args...) args
diff --git a/include/trace/trace_events.h b/include/trace/trace_events.h
index c2f9cabf154d..9a8872544a8b 100644
--- a/include/trace/trace_events.h
+++ b/include/trace/trace_events.h
@@ -45,6 +45,17 @@
 			     PARAMS(print));		       \
 	DEFINE_EVENT(name, name, PARAMS(proto), PARAMS(args));
 
+#undef TRACE_EVENT_PRINT_INIT
+#define TRACE_EVENT_PRINT_INIT(name, proto, args, tstruct, assign, print, init) \
+	DECLARE_EVENT_CLASS_PRINT_INIT(name,			       \
+			     PARAMS(proto),		       \
+			     PARAMS(args),		       \
+			     PARAMS(tstruct),		       \
+			     PARAMS(assign),		       \
+			     PARAMS(print),			\
+			     PARAMS(init));		       \
+	DEFINE_EVENT(name, name, PARAMS(proto), PARAMS(args));
+
 #include "stages/stage1_struct_define.h"
 
 #undef DECLARE_EVENT_CLASS
@@ -57,6 +68,16 @@
 									\
 	static struct trace_event_class event_class_##name;
 
+#undef DECLARE_EVENT_CLASS_PRINT_INIT
+#define DECLARE_EVENT_CLASS_PRINT_INIT(name, proto, args, tstruct, assign, print, init)	\
+	struct trace_event_raw_##name {					\
+		struct trace_entry	ent;				\
+		tstruct							\
+		char			__data[];			\
+	};								\
+									\
+	static struct trace_event_class event_class_##name;
+
 #undef DEFINE_EVENT
 #define DEFINE_EVENT(template, name, proto, args)	\
 	static struct trace_event_call	__used		\
@@ -117,6 +138,12 @@
 		tstruct;						\
 	};
 
+#undef DECLARE_EVENT_CLASS_PRINT_INIT
+#define DECLARE_EVENT_CLASS_PRINT_INIT(call, proto, args, tstruct, assign, print, init)	\
+	struct trace_event_data_offsets_##call {			\
+		tstruct;						\
+	};
+
 #undef DEFINE_EVENT
 #define DEFINE_EVENT(template, name, proto, args)
 
@@ -208,6 +235,32 @@ static struct trace_event_functions trace_event_type_funcs_##call = {	\
 	.trace			= trace_raw_output_##call,		\
 };
 
+#undef DECLARE_EVENT_CLASS_PRINT_INIT
+#define DECLARE_EVENT_CLASS_PRINT_INIT(call, proto, args, tstruct, assign, print, init)	\
+static notrace enum print_line_t					\
+trace_raw_output_##call(struct trace_iterator *iter, int flags,		\
+			struct trace_event *trace_event)		\
+{									\
+	struct trace_seq *s = &iter->seq;				\
+	struct trace_seq __maybe_unused *p = &iter->tmp_seq;		\
+	struct trace_event_raw_##call *field;				\
+	int ret;							\
+									\
+	field = (typeof(field))iter->ent;				\
+									\
+	ret = trace_raw_output_prep(iter, trace_event);			\
+	if (ret != TRACE_TYPE_HANDLED)					\
+		return ret;						\
+									\
+	init								\
+	trace_event_printf(iter, print);				\
+									\
+	return trace_handle_return(s);					\
+}									\
+static struct trace_event_functions trace_event_type_funcs_##call = {	\
+	.trace			= trace_raw_output_##call,		\
+};
+
 #undef DEFINE_EVENT_PRINT
 #define DEFINE_EVENT_PRINT(template, call, proto, args, print)		\
 static notrace enum print_line_t					\
@@ -244,6 +297,12 @@ static struct trace_event_fields trace_event_fields_##call[] = {	\
 	tstruct								\
 	{} };
 
+#undef DECLARE_EVENT_CLASS_PRINT_INIT
+#define DECLARE_EVENT_CLASS_PRINT_INIT(call, proto, args, tstruct, func, print, init)	\
+static struct trace_event_fields trace_event_fields_##call[] = {	\
+	tstruct								\
+	{} };
+
 #undef DEFINE_EVENT_PRINT
 #define DEFINE_EVENT_PRINT(template, name, proto, args, print)
 
@@ -265,6 +324,20 @@ static inline notrace int trace_event_get_offsets_##call(		\
 	return __data_size;						\
 }
 
+#undef DECLARE_EVENT_CLASS_PRINT_INIT
+#define DECLARE_EVENT_CLASS_PRINT_INIT(call, proto, args, tstruct, assign, print, init)	\
+static inline notrace int trace_event_get_offsets_##call(		\
+	struct trace_event_data_offsets_##call *__data_offsets, proto)	\
+{									\
+	int __data_size = 0;						\
+	int __maybe_unused __item_length;				\
+	struct trace_event_raw_##call __maybe_unused *entry;		\
+									\
+	tstruct;							\
+									\
+	return __data_size;						\
+}
+
 #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
 
 /*
@@ -403,6 +476,37 @@ trace_event_raw_event_##call(void *__data, proto)			\
 									\
 	trace_event_buffer_commit(&fbuffer);				\
 }
+
+#undef DECLARE_EVENT_CLASS_PRINT_INIT
+#define DECLARE_EVENT_CLASS_PRINT_INIT(call, proto, args, tstruct, assign, print, init)	\
+									\
+static notrace void							\
+trace_event_raw_event_##call(void *__data, proto)			\
+{									\
+	struct trace_event_file *trace_file = __data;			\
+	struct trace_event_data_offsets_##call __maybe_unused __data_offsets;\
+	struct trace_event_buffer fbuffer;				\
+	struct trace_event_raw_##call *entry;				\
+	int __data_size;						\
+									\
+	if (trace_trigger_soft_disabled(trace_file))			\
+		return;							\
+									\
+	__data_size = trace_event_get_offsets_##call(&__data_offsets, args); \
+									\
+	entry = trace_event_buffer_reserve(&fbuffer, trace_file,	\
+				 sizeof(*entry) + __data_size);		\
+									\
+	if (!entry)							\
+		return;							\
+									\
+	tstruct								\
+									\
+	{ assign; }							\
+									\
+	trace_event_buffer_commit(&fbuffer);				\
+}
+
 /*
  * The ftrace_test_probe is compiled out, it is only here as a build time check
  * to make sure that if the tracepoint handling changes, the ftrace probe will
@@ -434,6 +538,20 @@ static struct trace_event_class __used __refdata event_class_##call = { \
 	_TRACE_PERF_INIT(call)						\
 };
 
+#undef DECLARE_EVENT_CLASS_PRINT_INIT
+#define DECLARE_EVENT_CLASS_PRINT_INIT(call, proto, args, tstruct, assign, print, init)	\
+_TRACE_PERF_PROTO(call, PARAMS(proto));					\
+static char print_fmt_##call[] = print;					\
+static struct trace_event_class __used __refdata event_class_##call = { \
+	.system			= TRACE_SYSTEM_STRING,			\
+	.fields_array		= trace_event_fields_##call,		\
+	.fields			= LIST_HEAD_INIT(event_class_##call.fields),\
+	.raw_init		= trace_event_raw_init,			\
+	.probe			= trace_event_raw_event_##call,		\
+	.reg			= trace_event_reg,			\
+	_TRACE_PERF_INIT(call)						\
+};
+
 #undef DEFINE_EVENT
 #define DEFINE_EVENT(template, call, proto, args)			\
 									\
-- 
2.17.1

