Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E423749E7
	for <linux-trace-kernel@vger.kernel.org>; Fri, 10 Jul 2026 18:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783709345; cv=none; b=XEj3zRiPKuymlxdrOZ0QVFQ/SVVaK31snjoip1jiTEXkCX8MahKHOHGeqjVPE7go2Tv6ThK1Pd2XcBqHxuOq5Iaefs/g5tBJgEkOEgwl9hy1rL8jdYRROjIuGg8Ztn3Nx7cIyWPZ+dCpP3gkBF5s2Vdl41KKhAri6F9kY5gxK2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783709345; c=relaxed/simple;
	bh=m5E2MRgN8nNnYUf3x7te9EYrFhkTEy8MdD7OkkWaHR4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Eoi+JB8F5FeXEX9ORWMPcXAYPu3UMxW9sRa7Nd5af3QxrXTS4K89fC+t5grZupv/mNFOVNznkV8S2wfH+dqfWO0lToGnAym0gADgQw7+xQnhCb2whmCjyp1DOuPW4Uonr51oNWd/CtcdG2C2IeCxuKUSoKe9jJjDliyC6RlRccs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=po0iG/4M; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fr5Wgln5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="po0iG/4M";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fr5Wgln5"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66AIXF4R1649866
	for <linux-trace-kernel@vger.kernel.org>; Fri, 10 Jul 2026 18:49:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=N+yIFRVTgA1/L6OJr2cIQR
	+chz4VSwEmOlvU3TeT+yU=; b=po0iG/4MSy9q2uMoA6Xl6xu6ByBZSV3OPTQXxL
	9M3IFIToqA+b+/onPgcp9UbLyHpp94swzdkaYV8etZg978K6uBCgu8fBqlmMMOtz
	bNWDIDuPYIaG4Jed7/tF0jsTopAt/jtuTo/oeMJCrEAy+9k8H5nkIbx57OG78xY4
	dHIlDG5AeVmJnDg4Lt0Mvsy0OyFNhIpPUplkO/dDvOEBjwI8NCywn99HxVUl+V2R
	9p1fNMyobvRxlptJUtp5TVvpqmio0n6BXTb9xN5H4DS+p/uO2KUitTrrKnOPmT34
	ig9pm2ZgkOtltJIJNHRHLYLS0RTPgnK4/pi0yaH0GSrgacag==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fb649r1kd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-trace-kernel@vger.kernel.org>; Fri, 10 Jul 2026 18:49:02 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c890bac374eso2255004a12.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 10 Jul 2026 11:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783709341; x=1784314141; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=N+yIFRVTgA1/L6OJr2cIQR+chz4VSwEmOlvU3TeT+yU=;
        b=fr5Wgln5w57FxUzbkhjwp0f1mBbXxDLBXEmAJDamZOkr43SunK4O1pnftf0Ep1DSzT
         2yJ1Ub1P+WCosai+ni0Tgocts/rqUwvKUbBPrSrnTDUcQ4ObauovqVMeJKGw4uz9/D/Y
         sM/0c3X+r9watW02TdEElxTJRJouqY+OK525i+Jh15zQjLdeD88LlVtzKGxCtKIR1UA4
         IrG3Cc7QV4JFS7l81JwS7VFi6mj2px9cdZP1DDpC7Au12m2OPWsPjdzLoX46VexcZUOY
         JJUgojhxYdzeXJZD7f86AiK/9eQT8SiwBBlqAPxcLLJNIqfBFyqvT4nU3A2a5sWAZ/bR
         tIxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783709341; x=1784314141;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=N+yIFRVTgA1/L6OJr2cIQR+chz4VSwEmOlvU3TeT+yU=;
        b=BrmsyIcxQNqjFe9vMNK6jQwvVePoe7SqTccwNRE2xSdqJYLSAFq3Ue/onLLMaeQ2AG
         SyS5216Oy9ta7vzji8mUmDM4QKaG90wdqyKZIGaGnWbvzNRxxHV2TcIqu64VtfPFFj7t
         m4RqXLtnYOknWDfOdqQVTd9oOZC919nUi37X3qbDWDnQ0q2iuACNfkt+RsxzFqQXNSZ7
         EpdDSFDD/bB11p1pUV2YxImvl2aS+BOe/FqTZpKpgG5ChlBCLzS2hGfPnchd4K9H9Tw0
         nWmH6+POf6/PU/zJB7SiZxwBVlcePTXyuzE6SBiu+WAoIZQ9JV+vyxscu6lDox2Ng6yM
         XOqQ==
X-Forwarded-Encrypted: i=1; AHgh+RrQZMIhmtE6KCyuvBQGLeBfIa2AysSjGfEfZs2vH7WBxBHlC1hBeZGJu2hOsUOmphGHYyOrIVqpIhgyhBKfcf2NUeY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlRCdpKoaqwHVSke3Gyk+IU9u1KjtDXkYeKfjrxmJjPIQ9bkqG
	nAFozcZpautngftZBAvHR4B0P3vw8TgfVVDeF0akjx3BSO0SI4GunAAsLHI6wz7B/dJlr8AFql6
	8zWClDeQUyYgBjq01WEUUaqQe5DmHOYBDbJelM7ee8s9QWFLE9Y09NS78nttSgaqcHga8ouwydW
	Y=
X-Gm-Gg: AfdE7cmj9H/nIzqY/OmrAMXGopDF0ugzyWM6fFtqbn6hV2GeZMBVCa5fObl9dH0cSw0
	1tuvhS266ht+pq1kdE3b3iB5LISWYjOLzHYKwHyRoPShZOyRzBTBOHJxp1VvT9xMryKNark7ATM
	TPeZeJL46e59hkP39/CPnySMvLaIj0EI23JUodqqy8te3Y5B9j8G+oy8GPF5BDw5vNmra3eJ64T
	pfGetX/S8XOMGPuBmf9/bGHVNaA3mA9p36sRY2wH77ELZbtsXWEWeotzMbHxGfVoYqlrxDcqihk
	4L5AHO0iGoGn9W4OD1a0ZZmC13qZxD3Q8w/RJFmOjR+23mm2hxA3IKI0PdnIIF/IhuC6+Zlaa5I
	w/xCQGBftIKU+pDOTDh0QH2Hc6VrYb8osRUphyIiMuMhV
X-Received: by 2002:a05:6a21:6190:b0:3c0:b766:74f4 with SMTP id adf61e73a8af0-3c1104e1b6fmr250398637.31.1783709341364;
        Fri, 10 Jul 2026 11:49:01 -0700 (PDT)
X-Received: by 2002:a05:6a21:6190:b0:3c0:b766:74f4 with SMTP id adf61e73a8af0-3c1104e1b6fmr250361637.31.1783709340788;
        Fri, 10 Jul 2026 11:49:00 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b659d7c8bsm47226919c88.12.2026.07.10.11.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 11:49:00 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Subject: [PATCH v2 0/2] Add trace event support for GENI SE registers dump
Date: Sat, 11 Jul 2026 00:18:40 +0530
Message-Id: <20260711-add-tracepoints-for-se-reg-dump-v2-0-ca1e9ba62359@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIg+UWoC/4WOWwqDMBREtyL57pWY+qJf3UfxI95cNaUamxulR
 dx7fSygPwMHhjmzCCZvicUtWoSn2bJ1wwbqEgns9NASWLOxUFLlMr9K0MZA8BppdHYIDI3zwAS
 eWjBTPwIqLGssiyzPSrGtjJ4a+zkMj+pknuonYdhn90ZnOTj/PS7Myd47bYXM/9rmBCQYmZomw
 brUSXp3zPF70i90fR9vIap1XX+Zq+7z5wAAAA==
X-Change-ID: 20260630-add-tracepoints-for-se-reg-dump-c2c8bc875658
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Praveen Talari <praveen.talari@oss.qualcomm.com>,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783709336; l=2999;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=m5E2MRgN8nNnYUf3x7te9EYrFhkTEy8MdD7OkkWaHR4=;
 b=66s6gBwmbvNKkRPXr0SmxV8x6YcUYWwDZ7Q8g2Hwm7IP1oGuxqtqEXiE50xZXsJFtF4Q7ILLS
 h5zSes8ix2RCj91WOzUTspZi/u2lZsWU6sRAby6GwTwHkJ475xtqA8K
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-ORIG-GUID: ddC_-e9oLYRO1S6408g-aNWzd3JqvddT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDE4OSBTYWx0ZWRfXwR7+9O06wiNE
 wznbxUFzA0i0/DYF9LnyKCmbeU8pKLwo3WS5pZdLiQFPzY+A9Ktp0k0A5zJc/j16qfc7xz673EQ
 8/7cFIRVtvUzoJgSMj29xNTS/IS8hYT6Bpe7ngpYH/o9w1befVK4T4lp2vOB7sphIOCCNojbea7
 PRLy8CMG9QNiWBiZoC5zG4Rckrtm473pHtjszhMY0TNqiBTi8FzRVem71BLRwtyziyuqPL/G/VA
 J7QF1Wz1aNYsDmtq02FOyF5571c08TLIsM4zpTxtxoseGpsVbtY1/+94y5oRzYjV66uX7+ia/EL
 VUwbBA7ah2rK3o/Ux1tlMYU2QW0WL4dyeTNhD3bXuYslS8rTmoj28+EDhgL0K6jOEfvEVjCYZph
 HjeQkf1C0GsfZ2YhMR56LO/Lul7fyqoHyu+s8Z4jJGhR8ex4qfQEHRjyex0FIC+dXxu6+sHYFXW
 kT4CjzA4iHtIb58JD1A==
X-Proofpoint-GUID: ddC_-e9oLYRO1S6408g-aNWzd3JqvddT
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDE4OSBTYWx0ZWRfX2XR2tF9L8sfc
 WNIWY5YhPvvzjjjBwsf7v5mzcg1AgBpkuSVZ104O2Wwr8fiyUxpUDJNWp6I6fD+lCmocCeSkrgk
 ygUw3qOHxFynB6zUkTFX4u6T7a98V/4=
X-Authority-Analysis: v=2.4 cv=VZfH+lp9 c=1 sm=1 tr=0 ts=6a513e9e cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=U0NaQwEGjt_KokrWucUA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_05,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 impostorscore=0 phishscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100189

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
Changes in v2:
- Updated SE_DMA_IF_EN to correct value.
- Sorted hearders.
- Link to v1: https://lore.kernel.org/all/20260706-add-tracepoints-for-se-reg-dump-v1-0-48bd08e28cf2@oss.qualcomm.com

---
Praveen Talari (2):
      soc: qcom: geni-se: trace: Add trace event support for GENI SE registers dump
      spi: qcom-geni: add GENI SE registers trace event on error paths

 drivers/spi/spi-geni-qcom.c         |  22 ++++-
 include/linux/soc/qcom/geni-se.h    |  38 +++++++++
 include/trace/events/qcom_geni_se.h | 157 ++++++++++++++++++++++++++++++++++++
 3 files changed, 213 insertions(+), 4 deletions(-)
---
base-commit: bee763d5f341b99cf472afeb508d4988f62a6ca1
change-id: 20260630-add-tracepoints-for-se-reg-dump-c2c8bc875658

Best regards,
--  
Praveen Talari <praveen.talari@oss.qualcomm.com>

