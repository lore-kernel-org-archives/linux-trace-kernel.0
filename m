Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F553AF65C
	for <linux-trace-kernel@vger.kernel.org>; Wed, 15 Jul 2026 05:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784092865; cv=none; b=JXX2mLfoAghAqhcgBogYwzdOVPDlFhwJwPYCz42zzc8jiwPXRfFzF0J3Vd08oIszwYCY/GXZSQBz2cSSvhh3Fqy0VDdYorx4Wn4Nn6LErpWzJesMJA3+o9CMq3uoNoBM49a3wzDJrk3K4xOGaVzKQx3x+GgifD+xeoRrnaTi6yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784092865; c=relaxed/simple;
	bh=ORykrG6OPw9qdyGjq9FHHv+V4qNjByzTxutQlXJemn0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ezBWGE8ECdNNRVi0VADF/VAUgnKx9vNrpYAQY3uAIjg39cqsaAA3r5RN3hF1TLFBPfsMhXd7dBk8l4ybZNoQpRR1MxnRR3VF9Hs810w4bVKbuyXmB8PP0QlL+/DXXvNC5abhkUmn1azLR5mSVlQlM7Az8MQu+LvWLSE4rsnGkGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pPHEw+fx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Wds7uOaW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pPHEw+fx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Wds7uOaW"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66F3l4RP2679677
	for <linux-trace-kernel@vger.kernel.org>; Wed, 15 Jul 2026 05:21:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=aipnIg8ieikK/Qjeeax/5V
	B3+TOw4ZIiLbnWZtw/dmo=; b=pPHEw+fxzOLdWVDiymaXo4vbd8ZepmmN38C+YB
	BBcykCWXlOEILsDZXUu/OXxy1x+Fx8mDjIcXnlictLp1Xw4+pIMcMJj1F3PzVKA2
	z6Cs4taAzoRmtAbMdtHFY2gT6S9cEG8VkhS52LAnyVPmHr6AZo9lS5bXguM7WoRz
	KGLwyRMyjonvSa3OX89qrTOU4e6TuoXmquZ9nyPQ/AxbYGVgHvxFx55Cf2PBezYs
	9zLleLIGjLoUCx3tfKQyq5hC384oE3jtC7bccgZ+nViNOJVgWdtVz0+cwHLuyd/m
	VDld1YiyvFJcLRTXyXzivl5f8XHPN+HYxglBk0YT26Mq906Q==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fdnnuu2ue-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-trace-kernel@vger.kernel.org>; Wed, 15 Jul 2026 05:21:03 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38dbf293831so3970337a91.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 14 Jul 2026 22:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784092863; x=1784697663; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=aipnIg8ieikK/Qjeeax/5VB3+TOw4ZIiLbnWZtw/dmo=;
        b=Wds7uOaWDgIptaW02yqjekan+KIIGXLpvGWtMXWlqSxG7iW9fHUOql3MkUxmkg/g3u
         JgwJBRET/WefUx0GgVqI+T0bWBayKIFNSHJg5JKV+V9cHnT9n84JZLT4BdO/ErbnLfyF
         hNXMj2yx4OYljjmS3ndgMgvaDi90PYmmj7lQXAeQT8k86/FQlUeoY+OXzpcUKOznTBC+
         FOsW/kluvX5zLTN0FNrzNE4s2KnsNX4HeWPgJKhZBD9LqgVAOMc2PEy8Ec3CqW+Xogoy
         ymuEMtG+YYao57erppvO9Qug7vPDGHQGvHNST37phsqlyftH+x54+S82HMWy0SAhPXcv
         44Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784092863; x=1784697663;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=aipnIg8ieikK/Qjeeax/5VB3+TOw4ZIiLbnWZtw/dmo=;
        b=edWlVo7akUeI5693020O6W8gPkN8z2S3c36xyBdmf1MKQ4AeCrf2UH8oQJRGM8h/W5
         B0jLdu9sXUcAoiZtpGFXFVyXJbqgKks4l+Ae27xFIio6Xrd9o0M+gWc+YcAqX6Pv7okb
         JQXka7zcVRM1QRq/JNZy0+vTwvCpQ6U6RQQff5WZiYxT2aGW2zTv+baZPlP3jBZ98/s7
         6+KU3p/NwATsqJSuzsBNDmp1KXrzZLrYFjhj2KP5fs1Czy4WL3aG5vTkgsf+t8hbUYnt
         4jtNae1QgzGO6xTuobztOwfgG3+NSSjf5VGZvAFIwSYCaAyGDR/NUqziXJmVYzkIJv4o
         4d/g==
X-Forwarded-Encrypted: i=1; AHgh+RpgnNxWKRYkKuPgO9riwjchs6XLQf4GsxSc5O0SbnTfvjPyRslyL1hgKJJnUfAmylfsZjLrHtnR8DixzobkuaJCenk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFWYfosYQf0HWyZC6McHMTahX13Q7WotZ3900L2ZaGN1VDiASH
	b5fdb6xeBxZGuqm1sBS566eAv+LwWzFzOdO9TVQ672wmHirue1PX8D/O+JIudsQxiDiaEogM9Gq
	9JL/fvb1ElvxhVS1DsRBRevCBO4RKWZnqHQ/1Au2IE/aT+QHyhiBjr5B/50wy+UM3RgIDeUadoY
	M=
X-Gm-Gg: AfdE7clD22wbVRDnTsQGwC8//heIfTsU5GgMdB59rXDt3GqQGLtn4vePAE2EWbZakK+
	qQvJZFkjQOE8Z38LsoJlgVewbNjVCdvKucB6IBXMTwrK3ppUzfGXCskP0TZRdC1giCMgpzqM40z
	5LtO0DcMBRcRn5OqfM0oF3ObiufIofgCZktIDpJZQeZKaRXJ3KeYO8hqYZ5UUR9pW8erKrYOVeF
	zaEIZ/HG+YG44KERGHTUDbwiA8CmRH1qjAzQuHQQLuCXVpM4Mri7BqSnJrZSn49I+B9wzqOoeEs
	JCQFbFZwrWRrHDM+otOGjO195UEfSPCtDFXXxFD7LjfXTVsSjl+51m8pTrpmGAH89XjJPTUFtF8
	dRDgo+Yid27DOJbZbmHpbTWi6fTYwyvUnz7DRUQ074puR
X-Received: by 2002:a17:90b:3b50:b0:38d:f096:a1dc with SMTP id 98e67ed59e1d1-38df096a242mr9882329a91.11.1784092862490;
        Tue, 14 Jul 2026 22:21:02 -0700 (PDT)
X-Received: by 2002:a17:90b:3b50:b0:38d:f096:a1dc with SMTP id 98e67ed59e1d1-38df096a242mr9882313a91.11.1784092861837;
        Tue, 14 Jul 2026 22:21:01 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e172e46basm2526092a91.9.2026.07.14.22.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 22:21:01 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Subject: [PATCH v3 0/2] Add trace event support for GENI SE registers dump
Date: Wed, 15 Jul 2026 10:50:46 +0530
Message-Id: <20260715-add-tracepoints-for-se-reg-dump-v3-0-0f787f93badd@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAK4YV2oC/4WOTQqDMBSEr1Ky7pP4F0NXvUdxEZOnplRj86K0i
 Hdv1AN0M/DBMN+sjNBbJHa7rMzjYsm6MUJ+vTDdq7FDsCYyy3gmuMg5KGMgeKVxcnYMBK3zQAg
 eOzDzMIHOtGy0rEpRShZXJo+t/RyGR30yzc0Tddhn90ZvKTj/PS4s6d47bRUXf21LChwML0yb6
 kaqtLg7ouQ9q5d2w5DEYPW2bT9LHIAF5wAAAA==
X-Change-ID: 20260630-add-tracepoints-for-se-reg-dump-c2c8bc875658
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mark Brown <broonie@kernel.org>
Cc: Praveen Talari <praveen.talari@oss.qualcomm.com>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784092857; l=3734;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=ORykrG6OPw9qdyGjq9FHHv+V4qNjByzTxutQlXJemn0=;
 b=GXEw0cMs9m/8QTWvJNFTZ8ujDmhGHrmHAdRszpl1IygZONWs6kTH4iW0bXWMXWqZtrzhVQnb6
 RJs/MHp3UJ0D2wMA6+tCYKiQZ6xTNYc7A6c3XkcY+VEVNkHEzWOPoqC
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-ORIG-GUID: n7YnXlnTdL9o1av8PlCOzUnNHOV01Mdm
X-Authority-Analysis: v=2.4 cv=E+v9Y6dl c=1 sm=1 tr=0 ts=6a5718bf cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=meVymXHHAAAA:8 a=7d_E57ReAAAA:8
 a=7uk2dohp-bzDzRdlumcA:9 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
 a=2JgSa4NbpEOStq-L5dxp:22 a=jhqOcbufqs7Y1TYCrUUU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDA0NyBTYWx0ZWRfX5n+bWAcSUhsL
 7hTO2bKc+X/u0eOcG8AjEzvlRUckXgwg77Lksw0jS17YAl16Rtwo/vzW0xikYCsXUwD6LU+Q8oO
 pVlhOCMW0nFwobrM3Ncnl8ozvWr/b/XQh7bKv6kCaZ2ysnWxB+RUXs71Vb9fYdYyDygnMBWEbfh
 Wjxe5ihC4KgSPKlbsB37KSRdjsF9zzTdNQfvXzhA+TXOWOzt7ZsINElcZjSCfi2cTHXtvOoyXkE
 fjjuyP6sUtZfdnBCmPofyHGP2uo8dgMYoBSBwGjAWYBEaPIEBGlQdkz6d9VDDSPbNvw6sjYWzQU
 R+m5d0/X5gOkFtVm2RUmOGCDRnDsX93N+jwV2oJQ5eieG0+RZU0oSMLXski5xRXnYlqJuRGcpej
 1qAAfTa1a/I6LNG3Rjuoa5SIhqDkhoRhRWzDpinyCefa+i+U/c3zGKqtEc3Pj7lTYfIePYyHgqv
 27dYwfQka7w+fQMX9UA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDA0NyBTYWx0ZWRfXxTUfb3SLj42Q
 sWqQSNwpHf2VGvwXaWq/CHY83y8+ILDlD4Kh7x5I0qprZkYEsyfVYudq3/N9I0mGetgy+67JddK
 DlTqOOkC9JHDYw286wdhn67oxoVNMIw=
X-Proofpoint-GUID: n7YnXlnTdL9o1av8PlCOzUnNHOV01Mdm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_02,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 clxscore=1015 bulkscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607150047

The GENI framework is used by multiple drivers including UART, I2C, and
SPI. When hardware-related failures occur, each driver typically relies
on local logging, which often lacks sufficient information to determine
the exact controller state.

This series introduces a common tracing mechanism for GENI Serial Engine
debug registers and demonstrates its use in the SPI driver.

Patch 1 adds a new tracepoint that captures an extensive set of GENI SE
registers, including command state, interrupt status, FIFO state, DMA
configuration, and clock-related information.

Patch 2 hooks the tracepoint into SPI error paths so that register
snapshots are automatically generated when timeouts or transfer-related
failures occur.

Usage examples:

Enable all I2C traces:
echo 1 > /sys/kernel/tracing/events/qcom_geni_se/enable

cat /sys/kernel/debug/tracing/trace_pipe

Example trace output:
114.291299: geni_se_regs: 888000.spi: m_cmd0=0x18000000
    m_irq_status=0x00000080 s_cmd0=0x00000000 s_irq_status=0x08000000
geni_status=0x00000000 geni_ios=0x00000000 m_cmd_ctrl=0x00000000
m_cmd_err=0x00000000 m_fw_err=0x00000000 tx_fifo_sts=0x00000000
rx_fifo_sts=0x00000000 tx_watermark=0x00000000 rx_watermark=0x0000000d
rx_watermark_rfr=0x0000000e m_gp_length=0x00000004 s_gp_length=0x00000000
dma_tx_irq=0x00000000 dma_rx_irq=0x00000000 dma_tx_irq_en=0x0000000f
dma_rx_irq_en=0x0000001f dma_rx_len=0x00001400 dma_rx_len_in=0x00001400
dma_tx_len=0x00001400 dma_tx_len_in=0x00001400 dma_tx_ptr_l=0xffffc000
dma_tx_ptr_h=0x00000000 dma_rx_ptr_l=0xffffa000 dma_rx_ptr_h=0x00000000
dma_tx_attr=0x00000001 dma_tx_max_burst=0x00000002 dma_rx_attr=0x00000000
dma_rx_max_burst=0x00000002 dma_if_en=0x00000009 dma_if_en_ro=0x00000001
dma_general_cfg=0x0000000f dma_qsb_trans_cfg=0x00000000 dma_dbg=0x00000000
m_irq_en=0x7fc0007f s_irq_en=0x03003e3e gsi_event_en=0x00000000
se_irq_en=0x0000000f ser_m_clk_cfg=0x000000a1 ser_s_clk_cfg=0x00000000
general_cfg=0x00000048 output_ctrl=0x0000007f clk_ctrl_ro=0x00000001
fifo_if_dis=0x00000000 fw_multilock_msa=0x00000000 clk_sel=0x00000005

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
Changes in v3:
- Trace se registers before clearing tx watermark reg.
- Updated commit text.
- Link to v2: https://lore.kernel.org/all/20260711-add-tracepoints-for-se-reg-dump-v2-0-ca1e9ba62359@oss.qualcomm.com

Changes in v2:
- Updated SE_DMA_IF_EN to correct value.
- Sorted hearders.
- Link to v1: https://lore.kernel.org/all/20260706-add-tracepoints-for-se-reg-dump-v1-0-48bd08e28cf2@oss.qualcomm.com

To: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konradybcio@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-trace-kernel@vger.kernel.org
Cc: linux-spi@vger.kernel.org
Cc: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>

---
Praveen Talari (2):
      soc: qcom: geni-se: trace: Add trace event support for GENI SE registers dump
      spi: qcom-geni: add GENI SE registers trace event on error paths

 drivers/soc/qcom/qcom-geni-se.c     |   3 +
 drivers/spi/spi-geni-qcom.c         |  23 +++++-
 include/linux/soc/qcom/geni-se.h    |  38 +++++++++
 include/trace/events/qcom_geni_se.h | 157 ++++++++++++++++++++++++++++++++++++
 4 files changed, 217 insertions(+), 4 deletions(-)
---
base-commit: bee763d5f341b99cf472afeb508d4988f62a6ca1
change-id: 20260630-add-tracepoints-for-se-reg-dump-c2c8bc875658

Best regards,
--  
Praveen Talari <praveen.talari@oss.qualcomm.com>

