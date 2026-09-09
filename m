Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38663546CD
	for <linux-trace-kernel@vger.kernel.org>; Wed,  9 Sep 2026 05:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788930603; cv=none; b=NvmkrpYwOsluMQDZVq0CEOLxC0Bt7jqnejLbGlbkWXuvSexn17jOPuGyrWkPEqL2EvUgzQzzjpo2AFuH5VsdokwUyfqW9XiDVRCCJ7N8I3Ccuqmx/cAoYeJO60Gzf0h4ZjEOeyLEuuFF1EuUslrcLrl9JdNbatUpxCqtx3A72EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788930603; c=relaxed/simple;
	bh=dZwjR73TiTPbLIt1okXWyFpe7GP6ItOia1YqprNwiRk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZKuGAEvtRayffo25VIGjKvjW0UyeeJX15zyT29vtXk4saJ1d6SGj6PQxk0K4Jxv+kHkfNcLlz9hsoz2Hf5KVlHbZjbW0CeY84iS7/W+lxjQxo21BF9N9mhif10I1m7pgIgPLqbNu3SN5/9/SzAdDQEF1J/+9zyvyjtCoCvYK6cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TOOR6mqK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=K+7RnpjB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TOOR6mqK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="K+7RnpjB"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 688MgARw129688
	for <linux-trace-kernel@vger.kernel.org>; Wed, 9 Sep 2026 05:10:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TyGqEvTHxTDvur0qvOYGRq1YtqRdHvGUUG9LYbZe1s0=; b=TOOR6mqKTGjbH42/
	8kXTWm07xF2eOEv1YieoK2dnp1dRILL+RHo8FU6d0o5ChPq5f5ndOAD04cozvDp9
	tf+VbIMbhbwJfklcx0ZlX5C7jKNuSyOCZ1017UpXD/eP4j5PadZBk5yAlJJwci3J
	7JHlT0Xcpp5BeQJtYprExjtGTbboLbIMonu1iMPgdPzjiCOImXW8J5N++iBcqH7r
	k+r/jGttP9cVk17Qd0kR+ENshThGJapibRh2aHse+Yv3JaM3/Q6wqlqsn6+QGr04
	K1KJOQV6ElVKeV626Nmgnr6TqmYu9S5nnyr2wKnlwC4PPZmFzXEyz1qTaQGN5v3x
	imtYVg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjntpjs70-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-trace-kernel@vger.kernel.org>; Wed, 09 Sep 2026 05:10:00 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-39533bb224cso2919860a91.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 08 Sep 2026 22:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788930600; x=1789535400; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TyGqEvTHxTDvur0qvOYGRq1YtqRdHvGUUG9LYbZe1s0=;
        b=K+7RnpjBt0NgKEP8B1U4Hm9U9G9KdKiCZzwuqgkUYglfwp1dYovj2boJ/YTuE1q2ay
         BPqgjrVIwNwdEcd1pRkMI6+RvLsA67P1/oiC/seCGVvgb5C3rB3VEbuc3c7qddcbO0Xu
         oBozTDoA2FnDuM+UMv9mD0VihRC+gHnY/H4usc/yrY7Oi/AgVM1COcXXPXK5xPCXNPq+
         bYVBayt1uYQRPBbuM2ieG8U77VjVHF9RxiROwn6fp47WmHbQXXteM4wiBs94LxaheEE1
         V9kS83dZpqV02RQjsyOm9Frbtm7DmTWBVKLrnTWGNujsJqspkaus98Ox4agwbc46sGNU
         58yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788930600; x=1789535400;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TyGqEvTHxTDvur0qvOYGRq1YtqRdHvGUUG9LYbZe1s0=;
        b=gsf1zco/Lui4RXDyJJXZ+5WC4UQ7zzyM0beHEq4hnFhq7XIEtiAn2mIorlWhDkTJd0
         b9SjOCGLqDhH35tNpOFrPnaMnUYW1iqNhWk8CEQ68KXk/rz+rmphG63TtH0gGqUJHs9H
         3ywurs2lYhDnGzkma+ZWAO4s1mHnslAswVnXbacZejvkMjV0F6ikgdenXa6/psW2z2Rb
         H4puE4vDuA3YNQQLBgDdbX3ijGRbqmdvJ0CDz3B539HWuOR4KRHs/WYT218+Gv6R2De3
         WWWLk3E/0RkHG5r6wSq/dQmKjEnRNu0XUjNFXV35wVzLPaKmyZ39Qr1E9Y1isZjn3Wcd
         eyzA==
X-Forwarded-Encrypted: i=1; AKwUvBz60UfU50tkiJmB+PLzaggnJKeZMfpdCxp65TKzBB0DogS4O7VrkKb6rhiU7y0FfLhRirQng1oJK28B7MYAnnv/I+E=@vger.kernel.org
X-Gm-Message-State: AFuF++kQwcVNDZAfCYBn2tT5OTT3Lk+gtyJhRyuYz5KKFyChvpW4TQlL
	mdBn5sKgcoaL7IxITbq60T1q1C47fmn1q8Haz1whB0X+N+OIuT4QAfVnlfDrwTrMqjtUAvWQqtk
	1uqrGTJkk0CN89P+MyBLng5SP6P2EEus3viRIOeyd8UQ2D227WFNpvgcjrrTGVMhcbRpEo2NkRz
	Y=
X-Gm-Gg: AYBFou1jBiUNqCqtqHypV4plh1z1AJD17qTgIKmiEOsq8sqw9o/1k/SjYJSUdmxSzbG
	J/aslH+PL/0x246YJ2ZtZi0JjwtbP0b+5KhJMepox/kxZZe37Yf0HU7TRHtewZGmT7pwWQ1a0fe
	zGRheL0rlEhcnlYphbikBktnTdn9EYO8QeLWBjGNGdhW8qLKboTPIpL/CNTVJYUtM7mYOgSjRsB
	oJeCekvTiTfvzMppwgYsQYU06OCYIDP+cSZbbZMHROrKb8oFOLziSq+uEV+MwCbwt6QcQ6Pv1T7
	5OMaa9Zc6Xq7Al6Posa1M2KMuMtIfgwboSJ4QGjuXXOLbkk3Q0WNvzruUwJPZp7CHsuahL4MPVp
	iEulFpyMfxABK4581sfaYYM/SOWkNBAAe+A==
X-Received: by 2002:a17:90b:3c48:b0:398:e436:384 with SMTP id 98e67ed59e1d1-39b260d335dmr50535962a91.1.1788930599618;
        Tue, 08 Sep 2026 22:09:59 -0700 (PDT)
X-Received: by 2002:a17:90b:3c48:b0:398:e436:384 with SMTP id 98e67ed59e1d1-39b260d335dmr50535874a91.1.1788930598935;
        Tue, 08 Sep 2026 22:09:58 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-338f7bad290sm11082833eec.14.2026.09.08.22.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 22:09:58 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Wed, 09 Sep 2026 10:39:41 +0530
Subject: [PATCH v2 1/3] dmaengine: qcom: gpi: trace: Add trace events
 header for Qualcomm GPI DMA
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-add-trace-support-gpio-v2-1-01f81739bb88@oss.qualcomm.com>
References: <20260909-add-trace-support-gpio-v2-0-01f81739bb88@oss.qualcomm.com>
In-Reply-To: <20260909-add-trace-support-gpio-v2-0-01f81739bb88@oss.qualcomm.com>
To: konrad.dybcio@oss.qualcomm.com, Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>
Cc: chandana.chiluveru@oss.qualcomm.com, mukesh.savaliya@oss.qualcomm.com,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        Praveen Talari <praveen.talari@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788930590; l=10756;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=dZwjR73TiTPbLIt1okXWyFpe7GP6ItOia1YqprNwiRk=;
 b=/C13ajnz22mgdvaDbBShAW4sNCIIalELI/x3po0iM31hTNhhRPm3LJ2IhCMFbN/rNwHiqbhZJ
 bmZitACLVC6BaEaMemLffRkTXE0TdDdnMyG3tCG8radGWdjOzQwwa0Q
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDA1NiBTYWx0ZWRfX0kDH0En+iXqZ
 RQvF9hz2aQ0ZpW/HCSfgdP7LNgSZPVXg5Cxi6NKXO+bhnXtX9+oWqyEXdAsi7PoWSA6VGutUOKK
 QoBW+QZ65ZxQ6s5PFKu3O4iCaoxu2mCzzZ+cUtCXai5mVlTcG08X6sl7/S0TJwGZ9Tw1LwPqI+2
 +//GATfedAb5i2eKI8UIIjxbYXPMqKBq2uMuq8DoatKL+wUgRSooB5Fcp/VHdiqgWoCGjCCbuVE
 Bh1PZSNSyJSkKyoiWRki7s8DT6so7iDvtNnLpbd80zmpJa/6ddIokXa4i3M7iT9z4vQ7yJoL1PI
 fl1Fs4yPYECbEnhChOhaoHiHZW4i1V0wh/zBokRuUYqbMOMDOUKp8xAa5u2vjkGueLm7pCeOLkl
 d6D0sgczqSYgnWphxuwKBTA+UIf4khEqinu/dy1ND07KiiDH/rAmlQSaBiT6tnIKyHsW/7rpcJP
 LaQ0P3Q6i0JNTnXCJfQ==
X-Authority-Analysis: v=2.4 cv=N+AZ0W9B c=1 sm=1 tr=0 ts=6aa0ea28 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=E82JpRapckMa8tCxcIoA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: GdHocWftqaS_tDmeYIdEVv99YB4obtvu
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDA1NiBTYWx0ZWRfX9HsIGjF1dYAL
 wv66cImxflqB0uH9nmDJ9Cir1/clG1H5bjlg2Cjo5IlrbT1QT1OMKzS8D8bJgvI/hjbDhJTcPVs
 HTsCbDdnrIpVBZjxm7IYcRyzlDDoxr4=
X-Proofpoint-GUID: GdHocWftqaS_tDmeYIdEVv99YB4obtvu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 malwarescore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609090056

Add a tracepoint header for the Qualcomm GPI DMA engine driver.

The events defined here cover channel/event command dispatch, IRQ
type handling, channel/event control state transitions, error IRQ
status, completion event processing (including the no-pending-
descriptor and transfer result paths), per-event processing in the
event ring, ring allocation/programming details, already-in-state
checks for pause/resume, and TRE queuing and contents. Together they
give full runtime visibility into GPI DMA behavior in place of the
driver's former dev_dbg() based debug logging.

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
 include/trace/events/qcom_gpi.h | 313 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 313 insertions(+)

diff --git a/include/trace/events/qcom_gpi.h b/include/trace/events/qcom_gpi.h
new file mode 100644
index 000000000000..241d76855ac8
--- /dev/null
+++ b/include/trace/events/qcom_gpi.h
@@ -0,0 +1,313 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM qcom_gpi
+
+#if !defined(_TRACE_QCOM_GPI_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_QCOM_GPI_H
+
+#include <linux/tracepoint.h>
+
+TRACE_EVENT(gpi_send_cmd,
+	    TP_PROTO(struct device *dev, u32 chid, u32 cmd, const char *cmd_str),
+	    TP_ARGS(dev, chid, cmd, cmd_str),
+
+	    TP_STRUCT__entry(__string(name, dev_name(dev))
+			     __string(cmd_str, cmd_str)
+			     __field(u32, chid)
+			     __field(u32, cmd)
+	    ),
+
+	    TP_fast_assign(__assign_str(name);
+			   __assign_str(cmd_str);
+			   __entry->chid = chid;
+			   __entry->cmd = cmd;
+	    ),
+
+	    TP_printk("%s: chid=%u cmd=%s(%u)",
+		      __get_str(name), __entry->chid, __get_str(cmd_str),
+		      __entry->cmd)
+);
+
+TRACE_EVENT(gpi_irq_status,
+	    TP_PROTO(struct device *dev, u32 gpii_id, u32 irq_type),
+	    TP_ARGS(dev, gpii_id, irq_type),
+
+	    TP_STRUCT__entry(__string(name, dev_name(dev))
+			     __field(u32, gpii_id)
+			     __field(u32, irq_type)
+	    ),
+
+	    TP_fast_assign(__assign_str(name);
+			   __entry->gpii_id = gpii_id;
+			   __entry->irq_type = irq_type;
+	    ),
+
+	    TP_printk("%s: gpii=%u irq_type=0x%08x",
+		      __get_str(name), __entry->gpii_id, __entry->irq_type)
+);
+
+TRACE_EVENT(gpi_ch_ctrl_irq,
+	    TP_PROTO(struct device *dev, u32 chid, u32 ch_state),
+	    TP_ARGS(dev, chid, ch_state),
+
+	    TP_STRUCT__entry(__string(name, dev_name(dev))
+			     __field(u32, chid)
+			     __field(u32, ch_state)
+	    ),
+
+	    TP_fast_assign(__assign_str(name);
+			   __entry->chid = chid;
+			   __entry->ch_state = ch_state;
+	    ),
+
+	    TP_printk("%s: chid=%u ch_state=%u",
+		      __get_str(name), __entry->chid, __entry->ch_state)
+);
+
+TRACE_EVENT(gpi_ev_process,
+	    TP_PROTO(struct device *dev, u32 chid, u32 ev_type, u8 code,
+		     u16 status, u32 length),
+	    TP_ARGS(dev, chid, ev_type, code, status, length),
+
+	    TP_STRUCT__entry(__string(name, dev_name(dev))
+			     __field(u32, chid)
+			     __field(u32, ev_type)
+			     __field(u32, length)
+			     __field(u16, status)
+			     __field(u8, code)
+	    ),
+
+	    TP_fast_assign(__assign_str(name);
+			   __entry->chid = chid;
+			   __entry->ev_type = ev_type;
+			   __entry->code = code;
+			   __entry->status = status;
+			   __entry->length = length;
+	    ),
+
+	    TP_printk("%s: chid=%u ev_type=0x%02x code=%u status=%u length=%u",
+		      __get_str(name), __entry->chid, __entry->ev_type,
+		      __entry->code, __entry->status, __entry->length)
+);
+
+TRACE_EVENT(gpi_queue_xfer,
+	    TP_PROTO(struct device *dev, u32 chid, u32 num_tre),
+	    TP_ARGS(dev, chid, num_tre),
+
+	    TP_STRUCT__entry(__string(name, dev_name(dev))
+			     __field(u32, chid)
+			     __field(u32, num_tre)
+	    ),
+
+	    TP_fast_assign(__assign_str(name);
+			   __entry->chid = chid;
+			   __entry->num_tre = num_tre;
+	    ),
+
+	    TP_printk("%s: chid=%u num_tre=%u",
+		      __get_str(name), __entry->chid, __entry->num_tre)
+);
+
+TRACE_EVENT(gpi_gen_err_irq,
+	    TP_PROTO(struct device *dev, u32 gpii_id, u32 irq_stts),
+	    TP_ARGS(dev, gpii_id, irq_stts),
+
+	    TP_STRUCT__entry(__string(name, dev_name(dev))
+			     __field(u32, gpii_id)
+			     __field(u32, irq_stts)
+	    ),
+
+	    TP_fast_assign(__assign_str(name);
+			   __entry->gpii_id = gpii_id;
+			   __entry->irq_stts = irq_stts;
+	    ),
+
+	    TP_printk("%s: gpii=%u irq_stts=0x%08x",
+		      __get_str(name), __entry->gpii_id, __entry->irq_stts)
+);
+
+TRACE_EVENT(gpi_ev_ctrl_irq,
+	    TP_PROTO(struct device *dev, u32 gpii_id, u32 ev_ch_irq, u32 ev_state),
+	    TP_ARGS(dev, gpii_id, ev_ch_irq, ev_state),
+
+	    TP_STRUCT__entry(__string(name, dev_name(dev))
+			     __field(u32, gpii_id)
+			     __field(u32, ev_ch_irq)
+			     __field(u32, ev_state)
+	    ),
+
+	    TP_fast_assign(__assign_str(name);
+			   __entry->gpii_id = gpii_id;
+			   __entry->ev_ch_irq = ev_ch_irq;
+			   __entry->ev_state = ev_state;
+	    ),
+
+	    TP_printk("%s: gpii=%u ev_ch_irq=0x%08x ev_state=%u",
+		      __get_str(name), __entry->gpii_id, __entry->ev_ch_irq,
+		      __entry->ev_state)
+);
+
+TRACE_EVENT(gpi_ev_no_desc,
+	    TP_PROTO(struct device *dev, u32 chid, const u32 *ev_dword,
+		     const u32 *tre_dword),
+	    TP_ARGS(dev, chid, ev_dword, tre_dword),
+
+	    TP_STRUCT__entry(__string(name, dev_name(dev))
+			     __field(u32, chid)
+			     __array(u32, ev_dword, 4)
+			     __array(u32, tre_dword, 4)
+	    ),
+
+	    TP_fast_assign(__assign_str(name);
+			   __entry->chid = chid;
+			   memcpy(__entry->ev_dword, ev_dword, sizeof(__entry->ev_dword));
+			   memcpy(__entry->tre_dword, tre_dword, sizeof(__entry->tre_dword));
+	    ),
+
+	    TP_printk("%s: chid=%u event=%08x:%08x:%08x:%08x pending_tre=%08x:%08x:%08x:%08x",
+		      __get_str(name), __entry->chid,
+		      __entry->ev_dword[0], __entry->ev_dword[1],
+		      __entry->ev_dword[2], __entry->ev_dword[3],
+		      __entry->tre_dword[0], __entry->tre_dword[1],
+		      __entry->tre_dword[2], __entry->tre_dword[3])
+);
+
+TRACE_EVENT(gpi_xfer_result,
+	    TP_PROTO(struct device *dev, u32 chid, int result, u32 residue),
+	    TP_ARGS(dev, chid, result, residue),
+
+	    TP_STRUCT__entry(__string(name, dev_name(dev))
+			     __field(u32, chid)
+			     __field(int, result)
+			     __field(u32, residue)
+	    ),
+
+	    TP_fast_assign(__assign_str(name);
+			   __entry->chid = chid;
+			   __entry->result = result;
+			   __entry->residue = residue;
+	    ),
+
+	    TP_printk("%s: chid=%u result=%d residue=%u",
+		      __get_str(name), __entry->chid, __entry->result,
+		      __entry->residue)
+);
+
+TRACE_EVENT(gpi_process_event,
+	    TP_PROTO(struct device *dev, u32 chid, u32 type, const u32 *dword),
+	    TP_ARGS(dev, chid, type, dword),
+
+	    TP_STRUCT__entry(__string(name, dev_name(dev))
+			     __field(u32, chid)
+			     __field(u32, type)
+			     __array(u32, dword, 4)
+	    ),
+
+	    TP_fast_assign(__assign_str(name);
+			   __entry->chid = chid;
+			   __entry->type = type;
+			   memcpy(__entry->dword, dword, sizeof(__entry->dword));
+	    ),
+
+	    TP_printk("%s: chid=%u type=0x%02x %08x:%08x:%08x:%08x",
+		      __get_str(name), __entry->chid, __entry->type,
+		      __entry->dword[0], __entry->dword[1],
+		      __entry->dword[2], __entry->dword[3])
+);
+
+TRACE_EVENT(gpi_alloc_ring,
+	    TP_PROTO(struct device *dev, u32 elements, u32 el_size,
+		     u32 req_len, u64 len, size_t alloc_size),
+	    TP_ARGS(dev, elements, el_size, req_len, len, alloc_size),
+
+	    TP_STRUCT__entry(__field(u64, len)
+			     __field(size_t, alloc_size)
+			     __string(name, dev_name(dev))
+			     __field(u32, elements)
+			     __field(u32, el_size)
+			     __field(u32, req_len)
+	    ),
+
+	    TP_fast_assign(__assign_str(name);
+			   __entry->elements = elements;
+			   __entry->el_size = el_size;
+			   __entry->req_len = req_len;
+			   __entry->len = len;
+			   __entry->alloc_size = alloc_size;
+	    ),
+
+	    TP_printk("%s: elements=%u el_size=%u req_len=%u len=%llu alloc_size=%zu",
+		      __get_str(name), __entry->elements, __entry->el_size,
+		      __entry->req_len, __entry->len, __entry->alloc_size)
+);
+
+TRACE_EVENT(gpi_ring_info,
+	    TP_PROTO(struct device *dev, dma_addr_t dma_handle, phys_addr_t phys_addr,
+		     u32 len, u32 el_size, u32 elements),
+	    TP_ARGS(dev, dma_handle, phys_addr, len, el_size, elements),
+
+	    TP_STRUCT__entry(__field(u64, dma_handle)
+			     __field(u64, phys_addr)
+			     __string(name, dev_name(dev))
+			     __field(u32, len)
+			     __field(u32, el_size)
+			     __field(u32, elements)
+	    ),
+
+	    TP_fast_assign(__assign_str(name);
+			   __entry->dma_handle = dma_handle;
+			   __entry->phys_addr = phys_addr;
+			   __entry->len = len;
+			   __entry->el_size = el_size;
+			   __entry->elements = elements;
+	    ),
+
+	    TP_printk("%s: dma_handle=%llx phys_addr=%llx len=%u el_size=%u elements=%u",
+		      __get_str(name), __entry->dma_handle, __entry->phys_addr,
+		      __entry->len, __entry->el_size, __entry->elements)
+);
+
+TRACE_EVENT(gpi_already_state,
+	    TP_PROTO(struct device *dev, u32 gpii_id, u32 pm_state),
+	    TP_ARGS(dev, gpii_id, pm_state),
+
+	    TP_STRUCT__entry(__string(name, dev_name(dev))
+			     __field(u32, gpii_id)
+			     __field(u32, pm_state)
+	    ),
+
+	    TP_fast_assign(__assign_str(name);
+			   __entry->gpii_id = gpii_id;
+			   __entry->pm_state = pm_state;
+	    ),
+
+	    TP_printk("%s: gpii=%u already in pm_state=%u",
+		      __get_str(name), __entry->gpii_id, __entry->pm_state)
+);
+
+TRACE_EVENT(gpi_tre,
+	    TP_PROTO(struct device *dev, u32 chid, u32 idx, const u32 *dword),
+	    TP_ARGS(dev, chid, idx, dword),
+
+	    TP_STRUCT__entry(__string(name, dev_name(dev))
+			     __field(u32, chid)
+			     __field(u32, idx)
+			     __array(u32, dword, 4)
+	    ),
+
+	    TP_fast_assign(__assign_str(name);
+			   __entry->chid = chid;
+			   __entry->idx = idx;
+			   memcpy(__entry->dword, dword, sizeof(__entry->dword));
+	    ),
+
+	    TP_printk("%s: chid=%u tre[%u]=%08x:%08x:%08x:%08x",
+		      __get_str(name), __entry->chid, __entry->idx,
+		      __entry->dword[0], __entry->dword[1],
+		      __entry->dword[2], __entry->dword[3])
+);
+
+#endif /* _TRACE_QCOM_GPI_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>

-- 
2.34.1

