Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D823349CD7
	for <linux-trace-kernel@vger.kernel.org>; Tue, 12 May 2026 17:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778606061; cv=none; b=q4YHyyNRKfQjJM8N231NWzGMADAoch3gRAwduFGyq18ylf3S54p3dQ5ttUNqrV6It+MplHDUz9rx6kHxt9W57H1wifUVOFWdzqPm8vLCAxMLksOxoMIIRuHy/VW5CliNDvnPY5M3cs2m1dU5CLoTadZpNmytbRK2JNRsxn7dN1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778606061; c=relaxed/simple;
	bh=0PlDmiwcFo4z1rkout4ksGTQ4/rVyvYKV/OeqURRQeU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EvwZiosrpcGP6Tg35w53ZRElhh2Y8VIDigVIYajZil1K0FDwHeZWdCHLUlqVK4cYvBwYb3Nrz6XfLljK/e8sKhDosTpqF8JYIfaK1pVgQirpmczClgmQQmPxP58CobHMB06+bjJxpRrkLk6Q4eZD6oVPD4Bx6pwjgd4ZMCmkotM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OEo0wrI1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Xz0zQEHD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OEo0wrI1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Xz0zQEHD"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64CC4QxU3320942
	for <linux-trace-kernel@vger.kernel.org>; Tue, 12 May 2026 17:14:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Hiu9pCUQoNk1GtrevrrFuJ5w2VF2RliEONdrbhBWg+E=; b=OEo0wrI1jy+OXWua
	vttotWmdvUBF3sDpAnWt6xwUt0TW9HnstrAjrCDrbyCNUjDF9gWYB34EtjrHllav
	IHz7FK+0rfBlaPqRz2AWkukFN59tcVBqamEKXjntWvd0cYMjLzj/hIUtNQphWVQd
	pYxlXI9SwgNWIURjLKjzd6z9/4ZLNlSKJ9qvc2noyfsi9G+o4/lIhvp/hT3JmJX1
	Jz2EHpyT2UnqpHoCscIP3gR4J8kiup0U3wcvYeYHJF+HXkBTYmyXnW2caGEgLtWx
	1FkAiHHhzU2IyR2AF3SZHA++rVh52ncryG0Wq8pmsCYbY4dtv6N6ly4K51vlh1o8
	d8VZOA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e43w1s722-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-trace-kernel@vger.kernel.org>; Tue, 12 May 2026 17:14:19 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2bd04e4fe3dso16903475ad.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 12 May 2026 10:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778606059; x=1779210859; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hiu9pCUQoNk1GtrevrrFuJ5w2VF2RliEONdrbhBWg+E=;
        b=Xz0zQEHDEr04W+0ihufXavwwpN/6HKU4MM9r66JEKdNkDs/wZLCba8dc8crJ5dv/5P
         cNjVhiZGgsHSBTIgFekp08SbzLdaaTNFCoJbP/Yn/p0bvbfQwgbjxN9AcZf4eRNVtoND
         Fv7mTzr33M9Vg7EWdBrNk8VaeRIn076w9t3bGh/EfXmkvr2DYktkpGetG/rxhjfRNoql
         /rVLWgMFxiCETqPaakk+N4cVzRpJPEI41FxITxzlloLnGHz0CyWULm6AIotMZmj791xB
         Sg3sentw/3YVX4x/mHKLinPdJL5MpNh2WvFxBoWXrE8eVbGaH+BiFU3hXSB8q1PtrTIh
         fiiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778606059; x=1779210859;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Hiu9pCUQoNk1GtrevrrFuJ5w2VF2RliEONdrbhBWg+E=;
        b=WwzhNZWYrMYESDozg8HMiYbT/bG7IJr+LdiZmyNOikOWAH8ecHzrLP8IA3TXXF/y7b
         sZXNHK9XugHLXiyzYS/v9kTUy1Rj43+Ra7eRhFQ/RSTZg0CTiosuh2G/rOF4dbIVoWri
         xOzsY/sxaPEkC1WHkB6k3JvH595xiqqmqk3Kyy0Ldn6WBHC/QUs2VF4y31MDOxV5a1J+
         M07nq6rNOdpfEOarYU1ZlajObSsQoesShCkrW6U2D4Tio4JD7VhQZ9FWcUc7oz03bS0t
         4bvZAoj8xWsS2w4uqxGeJxqS3TM/pTgokC2fubbqQ/oAQNtZoWo2PqLlGIH109hLYZmM
         id6w==
X-Forwarded-Encrypted: i=1; AFNElJ/157FUc5xFWy3ddYFmneG3g7iSFKsTnrOPuoaQ970aogxmmv5WTtdm66uqBD1ssu5GnrBrSGxd1yBqeJKr1fntKLg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8J5mi7CuMMC2ZTNzLpCik534doHT83RNsVFnNIPhM15Bb2NlA
	qJM1hnA/4Ixa/CQ2XhrchNCky+SjWHj57okmjlP9b2FIfI85Y8TE9cHuXk423h8QokvnD7ODmSM
	dORf+tDwSXFuKVsoEq480Qh2GLom9ccxQ96l87GMI9PljcWHw6BgTeAXy8Bs0IMWLQKTO7S05jb
	k=
X-Gm-Gg: Acq92OE+FrJlABYn81A6mwbRFMyf+510Bb73nwvk3e55t3eoxH1X54naDn9bwovcrdz
	RKN2uXB95inCc7FIKxx+yD3ufXMX4vV9MxSqb8v9u0rFPvL86ArH/5mOghKIIyULflkTrkthnot
	UG3p0oGN9nGWSe5oB2mJscSDwIdIdkaQ9NtCygdAszaMeD43+hbXWx7urBo7REH6ErT1d0PQjmK
	jV0P/X+//hB//JN5XwT9kvDqQgvvkc1SM+4FupatlMEv/C6z/SRovQLDh9EpqhBg48Til0xR5lh
	24vLyAbwOZej10x0Rcb/GXugHuGfzct/3ciNZaA2gnmrdY9//28CJHQY2iHGYIsVuJYhh7YKH0m
	Yob3qDpnH5U5tgcQsF63Xf2i/rmviv3BN5mhIzgMnnPLoeqfNubV3nPA=
X-Received: by 2002:a17:903:145:b0:2bc:7eee:200a with SMTP id d9443c01a7336-2bc7eee20a0mr126597505ad.22.1778606058385;
        Tue, 12 May 2026 10:14:18 -0700 (PDT)
X-Received: by 2002:a17:903:145:b0:2bc:7eee:200a with SMTP id d9443c01a7336-2bc7eee20a0mr126596915ad.22.1778606057666;
        Tue, 12 May 2026 10:14:17 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d40427sm149996685ad.24.2026.05.12.10.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 10:14:17 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Tue, 12 May 2026 22:44:03 +0530
Subject: [PATCH v2 1/2] serial: qcom-geni: trace: Add tracepoint support
 for Qualcomm GENI serial
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-add-tracepoints-for-qcom-geni-serial-v2-1-a5726421b3af@oss.qualcomm.com>
References: <20260512-add-tracepoints-for-qcom-geni-serial-v2-0-a5726421b3af@oss.qualcomm.com>
In-Reply-To: <20260512-add-tracepoints-for-qcom-geni-serial-v2-0-a5726421b3af@oss.qualcomm.com>
To: Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Aniket Randive <aniket.randive@oss.qualcomm.com>,
        chandana.chiluveru@oss.qualcomm.com, jyothi.seerapu@oss.qualcomm.com,
        Praveen Talari <praveen.talari@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778606047; l=6340;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=0PlDmiwcFo4z1rkout4ksGTQ4/rVyvYKV/OeqURRQeU=;
 b=lYnz+GnqLRySyw8VFns47TjpSZ17aaMDA35Wh+b7RY7gPIhx+KoJkQLoTiScXTJb9d5U2AwpU
 15r4mYllqG1CCbfgBYH073USFxDClFIQNG8H7pZdbtmlefw1QjwenQQ
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-GUID: -p0TEPRWlujaLnyTEXBY9DIY_dJrZ8Oh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDE3OSBTYWx0ZWRfXx6AcbBXHPTEP
 cV9C9pF7vedivz1AP252x6y6hE0cbbmsyNIdTp/6ya+9Az5gNL2lEsRpVZ84Hm3BSdJD46io/+9
 jGE6BMjCwOHLmS1rRxU6pIdpNtUtrD0IPmC4ZHJQDrh7a3RV9KqI3XmabF3BfTNMFSmpZBpJWx7
 60s3cSbHkcZM7tNq2876rz+UmgZDEjA4bgc6nYBM+xHKBWvjDKXyRgpDn5oMPWP9kiNclIGfZAD
 iBhAieuYIIFgZw/BmBGxAF/xCKb1Ebt9TsVIXevpqcD/FsT5QViBvnuQxMki22kRKjVgf1h98w5
 3C/WajiPeljtRUtbs2kqEf/Hgcy0SPIcK+OFapDK/mwJX9p5dLxyJ4bytIqk1P25Ks+Y3Zs00P5
 TEjJYlP3hDTjmLs/FRCxFwIBJnnmVBvwgpSGqM+obgniIrAX+tcKRJ6li1PM/iHLHetS/Rfhqqy
 eIk0Ei1X+f0PikkTytA==
X-Proofpoint-ORIG-GUID: -p0TEPRWlujaLnyTEXBY9DIY_dJrZ8Oh
X-Authority-Analysis: v=2.4 cv=BoGtB4X5 c=1 sm=1 tr=0 ts=6a035feb cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=ESrFBFgxKAYm4imzEJIA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1015
 impostorscore=0 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605120179

Add tracepoint support to the Qualcomm GENI serial driver to provide
runtime visibility into driver behavior without requiring invasive debug
patches.

The trace events cover UART termios configuration, clock setup, modem
control state, interrupt status, and TX/RX data, making it easier to
diagnose communication issues in the field.

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
v1->v2:
- Removed multiple TX/RX trace events, instead used
  DECLARE_EVENT_CLASS and DEFINE_EVENT.
---
 include/trace/events/qcom_geni_serial.h | 172 ++++++++++++++++++++++++++++++++
 1 file changed, 172 insertions(+)

diff --git a/include/trace/events/qcom_geni_serial.h b/include/trace/events/qcom_geni_serial.h
new file mode 100644
index 000000000000..5e23827881d0
--- /dev/null
+++ b/include/trace/events/qcom_geni_serial.h
@@ -0,0 +1,172 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM qcom_geni_serial
+
+#if !defined(_TRACE_QCOM_GENI_SERIAL_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_QCOM_GENI_SERIAL_H
+
+#include <linux/device.h>
+#include <linux/tracepoint.h>
+
+TRACE_EVENT(geni_serial_set_termios,
+	    TP_PROTO(struct device *dev, unsigned int baud,
+		     unsigned int bits_per_char, u32 tx_trans_cfg,
+		     u32 tx_parity_cfg, u32 rx_trans_cfg,
+		     u32 rx_parity_cfg, u32 stop_bit_len),
+	    TP_ARGS(dev, baud, bits_per_char, tx_trans_cfg, tx_parity_cfg,
+		    rx_trans_cfg, rx_parity_cfg, stop_bit_len),
+
+	    TP_STRUCT__entry(__string(name, dev_name(dev))
+			     __field(unsigned int, baud)
+			     __field(unsigned int, bits_per_char)
+			     __field(u32, tx_trans_cfg)
+			     __field(u32, tx_parity_cfg)
+			     __field(u32, rx_trans_cfg)
+			     __field(u32, rx_parity_cfg)
+			     __field(u32, stop_bit_len)
+	    ),
+
+	    TP_fast_assign(__assign_str(name);
+			   __entry->baud = baud;
+			   __entry->bits_per_char = bits_per_char;
+			   __entry->tx_trans_cfg = tx_trans_cfg;
+			   __entry->tx_parity_cfg = tx_parity_cfg;
+			   __entry->rx_trans_cfg = rx_trans_cfg;
+			   __entry->rx_parity_cfg = rx_parity_cfg;
+			   __entry->stop_bit_len = stop_bit_len;
+	    ),
+
+	    TP_printk("%s: baud=%u bpc=%u tx_trans=0x%08x tx_par=0x%08x rx_trans=0x%08x rx_par=0x%08x stop=%u",
+		      __get_str(name), __entry->baud, __entry->bits_per_char,
+		      __entry->tx_trans_cfg, __entry->tx_parity_cfg,
+		      __entry->rx_trans_cfg, __entry->rx_parity_cfg,
+		      __entry->stop_bit_len)
+);
+
+TRACE_EVENT(geni_serial_clk_cfg,
+	    TP_PROTO(struct device *dev, unsigned int desired_rate,
+		     unsigned long clk_rate, unsigned int clk_div,
+		     unsigned int clk_idx),
+	    TP_ARGS(dev, desired_rate, clk_rate, clk_div, clk_idx),
+
+	    TP_STRUCT__entry(__string(name, dev_name(dev))
+			     __field(unsigned int, desired_rate)
+			     __field(unsigned long, clk_rate)
+			     __field(unsigned int, clk_div)
+			     __field(unsigned int, clk_idx)
+	    ),
+
+	    TP_fast_assign(__assign_str(name);
+			   __entry->desired_rate = desired_rate;
+			   __entry->clk_rate = clk_rate;
+			   __entry->clk_div = clk_div;
+			   __entry->clk_idx = clk_idx;
+	    ),
+
+	    TP_printk("%s: desired_rate=%u clk_rate=%lu clk_div=%u clk_idx=%u",
+		      __get_str(name), __entry->desired_rate, __entry->clk_rate,
+		      __entry->clk_div, __entry->clk_idx)
+);
+
+TRACE_EVENT(geni_serial_irq,
+	    TP_PROTO(struct device *dev, u32 m_irq, u32 s_irq,
+		     u32 dma_tx, u32 dma_rx),
+	    TP_ARGS(dev, m_irq, s_irq, dma_tx, dma_rx),
+
+	    TP_STRUCT__entry(__string(name, dev_name(dev))
+			     __field(u32, m_irq)
+			     __field(u32, s_irq)
+			     __field(u32, dma_tx)
+			     __field(u32, dma_rx)
+	    ),
+
+	    TP_fast_assign(__assign_str(name);
+			   __entry->m_irq = m_irq;
+			   __entry->s_irq = s_irq;
+			   __entry->dma_tx = dma_tx;
+			   __entry->dma_rx = dma_rx;
+	    ),
+
+	    TP_printk("%s: m_irq=0x%08x s_irq=0x%08x dma_tx=0x%08x dma_rx=0x%08x",
+		      __get_str(name), __entry->m_irq, __entry->s_irq,
+		      __entry->dma_tx, __entry->dma_rx)
+);
+
+DECLARE_EVENT_CLASS(geni_serial_data,
+
+	TP_PROTO(struct device *dev, const u8 *buf, unsigned int len),
+
+	TP_ARGS(dev, buf, len),
+
+	TP_STRUCT__entry(__string(name, dev_name(dev))
+			 __field(unsigned int, len)
+			 __dynamic_array(u8, data, len)
+	),
+
+	TP_fast_assign(__assign_str(name);
+		       __entry->len = len;
+		       memcpy(__get_dynamic_array(data), buf, len);
+	),
+
+	TP_printk("%s: len=%u data=%s",
+		  __get_str(name), __entry->len,
+		  __print_hex(__get_dynamic_array(data), __entry->len))
+);
+
+DEFINE_EVENT(geni_serial_data, geni_serial_tx_data,
+
+	TP_PROTO(struct device *dev, const u8 *buf, unsigned int len),
+
+	TP_ARGS(dev, buf, len)
+
+);
+
+DEFINE_EVENT(geni_serial_data, geni_serial_rx_data,
+
+	TP_PROTO(struct device *dev, const u8 *buf, unsigned int len),
+
+	TP_ARGS(dev, buf, len)
+
+);
+
+TRACE_EVENT(geni_serial_set_mctrl,
+	    TP_PROTO(struct device *dev, unsigned int mctrl,
+		     u32 uart_manual_rfr),
+	    TP_ARGS(dev, mctrl, uart_manual_rfr),
+
+	    TP_STRUCT__entry(__string(name, dev_name(dev))
+			     __field(unsigned int, mctrl)
+			     __field(u32, uart_manual_rfr)
+	    ),
+
+	    TP_fast_assign(__assign_str(name);
+			   __entry->mctrl = mctrl;
+			   __entry->uart_manual_rfr = uart_manual_rfr;
+	    ),
+
+	    TP_printk("%s: mctrl=0x%04x uart_manual_rfr=0x%08x",
+		      __get_str(name), __entry->mctrl, __entry->uart_manual_rfr)
+);
+
+TRACE_EVENT(geni_serial_get_mctrl,
+	    TP_PROTO(struct device *dev, unsigned int mctrl, u32 geni_ios),
+	    TP_ARGS(dev, mctrl, geni_ios),
+
+	    TP_STRUCT__entry(__string(name, dev_name(dev))
+			     __field(unsigned int, mctrl)
+			     __field(u32, geni_ios)
+	    ),
+
+	    TP_fast_assign(__assign_str(name);
+			   __entry->mctrl = mctrl;
+			   __entry->geni_ios = geni_ios;
+	    ),
+
+	    TP_printk("%s: mctrl=0x%04x geni_ios=0x%08x",
+		      __get_str(name), __entry->mctrl, __entry->geni_ios)
+);
+
+#endif /* _TRACE_QCOM_GENI_SERIAL_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>

-- 
2.34.1

