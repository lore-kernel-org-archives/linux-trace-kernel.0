Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153CE2773F9
	for <linux-trace-kernel@vger.kernel.org>; Mon, 18 May 2026 17:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779123698; cv=none; b=P8n6Y9aYCgPZ9GtB/uF8mUtm4XMMvmXxDdxRi/GjWzsMzlDAYShyj9OKif+KqHKcRLr5ImSO4aGZ3x/zhfOde9El8ziNSdITYGfbFJDVzsot8Xn19Ck2iT9o7M2kAP/Sa21hEn3kMXbuKojGiCdemLCngtzLOHfxFgOQk01cynw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779123698; c=relaxed/simple;
	bh=6masZgFWLsY1wGZmtQvxBGszzHLlTwVJbZ6sdXDkOsM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QtnYkKaNoKOrhg2Et6PBsfzYtixgL5/oEm+krbp+KLFrA0QGhLZ0NKv5HXNT5plNB7mRpa4dsCjMsp6Pol3eLM+3hcJfjGVfgZFH3BTgDzZH6BTyZQ36DoJX6sLyW32DrVfFdfBxKckRp2hVwwD1FdMTcYq11ynTj05u8LGF6EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LuyMlTW+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bEDde1Nl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LuyMlTW+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bEDde1Nl"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64IGddQ42685236
	for <linux-trace-kernel@vger.kernel.org>; Mon, 18 May 2026 17:01:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=GgyL6RTmFW5Y2UChe6AMki
	GlndhNLcMHYwQDILdaz5c=; b=LuyMlTW+lbGX/22M05x3nUf6g9ExcU4Hrgzpk+
	rPZYWxwgTJt7Bgn2qBhK/Vub5pIi8yTorAiTvoVCMyCaG2sgqFNpbW9xG7iESe7P
	eXIvlwLSp+O05pu21SsOKlxRjvVevzy7gdtAOAmgxzQvxFE+KmuT0Yv+WFXoHdK9
	e2ClmNEac9hWKDP5qOygGqF7rd+ddWBBgFfAtlhBojXXkY/FNkCHoxZurO5WOMct
	oRPDzFGGMpBlsM8v7IFar6rraKkBfrDGrekFrigOhQHPbntLirZRqG1oOZIROrtw
	EKkMkuQ8sWn4mqV/xMtDQDhNDjQ/b5BqoZTnXQRlShfFiGRw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e7vrbtuax-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-trace-kernel@vger.kernel.org>; Mon, 18 May 2026 17:01:36 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-36642d2f4deso5752558a91.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 18 May 2026 10:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779123695; x=1779728495; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GgyL6RTmFW5Y2UChe6AMkiGlndhNLcMHYwQDILdaz5c=;
        b=bEDde1NlopGS0/OCvnZEXIN7K3MHL8aL33dh+Lzoaj3tTdFlhHqWnOHglLZqwMgngp
         ZzCw4M616n2juNPwq1pK6VGZ06xMJUud1u03lrnh6+7Axm2RVpyMigm2fncyvrdE80l9
         /j+yJiSxte000+A06IcKmUB32fbdA7haigHXwSA7kaYiZG8edfZtZRcq/UlW41WBDqiY
         EbGXM9oatHgHHFr19L22hQfRDa3P34JH5KTrDwLemSYW2jILSR3b+lA/jSVbPFVN2dIl
         oueIlu+u+dtP/pmKc4A/muUOqE9xr+wPyAfc4+kpW0j0l/3r3kmDpHThg0vAAekQerbD
         W6wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779123695; x=1779728495;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GgyL6RTmFW5Y2UChe6AMkiGlndhNLcMHYwQDILdaz5c=;
        b=D0mke3toP5bZJcSrBMoWLVUn1QOOmb1NXy+w4LE4hDtUBR8Wfu7FF+JzOt3mlR28WO
         9kEvspVffReR0s9kITigEZF54ZRANQxpuOdakqOdeVBre0CtpXfokszR6e45YW7rgJSk
         dwJBxilNwVsZ6v4qAiYkDjAgL5UIneKLat9/4ajtoZuX9XJU4N9Oyprjqx7yuQMvmhts
         pKTiZvHmHmxcmyP22EsSsGyXjx2D1nhMttGsPb+IK2/hOCdtDD61rOqIsDmXj7PTsCj9
         W+kd5Iy3EmuwHTNQy8IKqxESuCI5lK1mOz/wIBAvLp8WwC1XLkSRr8ErD1YV3VKdTTUK
         Ok9Q==
X-Forwarded-Encrypted: i=1; AFNElJ+jzcqeFIPixzKKg141Ak8zZPNQswHlCWRx11oPX7g8dOW9yFeIarlZnBT9sm5YQO3RbyuLLFSExKwgjFCLcDJoZm4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7ex7+ElbLEyPeg6FisvWIhnjsYmgzEb+PeuHVMdzsv8PpqxDo
	lpXeath1UXR3pkBzZiCGPd28j5c5mQZv90xw4HaKUq61JWOwy3YQyifmPn2ee+X8MVWtaulxEcu
	jY7O6/gNC6NGHrB+ALroQjVYV5hiU8HYvRwYYURR/io1AjWyoCecspslUmqWUrSl7RsvtOmWJ5L
	4=
X-Gm-Gg: Acq92OGjc0yMJshDOpqfgqZeXdSdwum5fIfdTtdXomY62o9G6/OZFThpszqRnNwStRL
	CnjGSzSrjmWzAvrSvnhOvA0rrwNpG9nT40ATP0301EGyHgSUs1db0F+W7LXGSiBxwwacfPaQT+e
	vqINFZjmcavjFLSsUqK2Whdrf64yCduwmF/ZUoDYgn+QHaerAWb1wWu4KuwqfqVFGGnDJyBuzgd
	1x78OOu8VeB/0o3kXh32QaNThFz3yGi2YJ6hRkQFpubBsd9Zday3LOsYsKFUK+Cwvy6rljcNXuz
	OWm05USS/c2viJqYnFACRBn+hH7VbLqq3BhHH2a3Tf+w675f5u8+DTgZ4OrwwOiJoYQsxPnHw8o
	WLfSupXsevjxNzLKrOolFbIwoYMO1X5ddh0bxABSUjy5hOr0f9F4j7Ec=
X-Received: by 2002:a17:90b:2248:b0:368:341a:a925 with SMTP id 98e67ed59e1d1-36951c97685mr16140118a91.23.1779123681488;
        Mon, 18 May 2026 10:01:21 -0700 (PDT)
X-Received: by 2002:a17:90b:2248:b0:368:341a:a925 with SMTP id 98e67ed59e1d1-36951c97685mr16137814a91.23.1779123662967;
        Mon, 18 May 2026 10:01:02 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3695652466dsm5783808a91.0.2026.05.18.10.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 10:01:02 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Subject: [PATCH v3 0/2] Add trace events for Qualcomm GENI SPI drivers
Date: Mon, 18 May 2026 22:30:50 +0530
Message-Id: <20260518-add-tracepoints-for-qcom-geni-spi-v3-0-7928f6810a79@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMJFC2oC/5WNQQ6CMBBFr2K6dkhboIAr72Fc1DLAJEKhxUZDu
 LuFlQsXupnkTX7eW5hHR+jZ6bAwh4E82SFCejww0+mhRaA6MpNcKp5zBbquYXba4GhpmD001sF
 kbA8tDgR+JMBUZHlhpFSFYdEzOmzouTcu18gd+dm6154MYvv+Yw8COJgqBhoshKzF2XqfTA99j
 7M+iYdtkSA/xEL+IpZRnN5EmXFVommqL+J1Xd/iYFGIMgEAAA==
X-Change-ID: 20260506-add-tracepoints-for-qcom-geni-spi-e31457c2267c
To: Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        mukesh.savaliya@oss.qualcomm.com, aniket.randive@oss.qualcomm.com,
        chandana.chiluveru@oss.qualcomm.com, jyothi.seerapu@oss.qualcomm.com,
        Praveen Talari <praveen.talari@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779123658; l=2659;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=6masZgFWLsY1wGZmtQvxBGszzHLlTwVJbZ6sdXDkOsM=;
 b=ofnL7qBGmEtascjrH5VLMbmyqsyIludaIGF85epr6GyAE/f1f2Se5CUX+xK14cKZQBkSMbwx7
 aUKHwQO3ROQDj/7/WO3TYUkklPydqQxVytX4ETTjDYaKHYTEH0AXlyk
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-GUID: fi5PQh_RqNf9jkKbkb103dWzp_nspGUf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDE2OCBTYWx0ZWRfX3Jj3PA++uRRH
 2zmcVVghxzrHLWJJlEGO132Ua6vyBZSONGHpg5/I18nFbSmrL6BuoNT3+cvW9BpgTtJQt1wTSVB
 wKgLCgkYVeXZ8fNRzlMiuAuyWU2e1VhJ8orfhxJwjqA/65E8COOvKsLlu9R3bKAPb6JoSd7zDuc
 BYF1BnA41CbkTjt4/yNXHlCLmhCa0IEYQfTLqEiH+SySUKoSSobR691dNQp+JXNE/m/4OVeg8Hw
 RTlB6FtbIugQOLtBwlB6eq/MnW6xUNBOLGX2t0DiSk8y6FuSmGEWVBcvz7hpz35/zrIjr8bESdX
 a9pDo16h7/5jTrd5DmzAB6agvDR0+9uOdOJybYz/9ApdVaDfqRjOf07ZOpxNBWXFYH7I0kaQ0RP
 keZIi4TR78j1G9+jrxFp5iHJBi00jCezNYZKyEiZMEmKAS9GU8a03V5wEebdU2ZZoU4DOEJ38RK
 WMMHzaSa2Cp1tJKK8fw==
X-Authority-Analysis: v=2.4 cv=KZ3idwYD c=1 sm=1 tr=0 ts=6a0b45f0 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=vdy0y8WXZQco5u0MrGUA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: fi5PQh_RqNf9jkKbkb103dWzp_nspGUf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605180168

Add tracepoints to the Qualcomm GENI (Generic Interface) SPI driver.
These trace events enable runtime debugging and performance analysis
of SPI operations.

The trace events capture SPI clock configuration, setup parameters,
transfer details, interrupt status.

Usage examples:

Enable all SPI traces:
  echo 1 > /sys/kernel/tracing/events/spi/enable  
  echo 1 > /sys/kernel/debug/tracing/events/qcom_geni_spi/enable
  cat /sys/kernel/debug/tracing/trace_pipe

Example trace output:

1003.956560: spi_message_submit: spi16.0 000000001b20b93c
1003.956642: spi_controller_busy: spi16
1003.956643: spi_message_start: spi16.0 000000001b20b93c
1003.956646: geni_spi_setup_params: 888000.spi: cs=0 mode=0x00000020
     mode_changed=0x00000007 cs_changed=0
1003.956647: spi_set_cs: spi16.0 activate
1003.956648: spi_transfer_start: spi16.0 00000000ea1cf8b6 len=16
     tx=[4c-80-e4-ca-68-4d-95-aa-ee-99-ae-d7-69-e9-5f-39]
rx=[00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00]
1003.956653: geni_spi_clk_cfg: 888000.spi: req_hz=20000000
     sclk_hz=100000000 clk_idx=5 clk_div=5 bpw=8
1003.956691: geni_spi_transfer: 888000.spi: len=16 m_cmd=0x00000003
1003.956708: geni_spi_irq: 888000.spi: m_irq=0x08000081
     dma_tx=0x00000000 dma_rx=0x00000000
1003.956717: spi_transfer_stop: spi16.0 00000000ea1cf8b6 len=16
     tx=[4c-80-e4-ca-68-4d-95-aa-ee-99-ae-d7-69-e9-5f-39]
rx=[4c-80-e4-ca-68-4d-95-aa-ee-99-ae-d7-69-e9-5f-39]
1003.956717: spi_set_cs: spi16.0 deactivate
1003.956718: spi_message_done: spi16.0 000000001b20b93c len=16/16

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
Changes in v3:
- Replaced geni_spi_fifo_params with geni_spi_setup_params trace event.
- Updated commit text.
- Link to v2: https://lore.kernel.org/r/20260512-add-tracepoints-for-qcom-geni-spi-v2-0-3b184068ecf9@oss.qualcomm.com

Changes in v2:
- Removed tx/rx data capture since spi core had already support.
- Updated commit text in patches and cover letter.
- Link to v1: https://lore.kernel.org/r/20260506-add-tracepoints-for-qcom-geni-spi-v1-0-c957cfe712d1@oss.qualcomm.com

---
Praveen Talari (2):
      spi: qcom-geni: trace: Add trace events for Qualcomm GENI SPI
      spi: qcom-geni: Add trace events for Qualcomm GENI SPI driver

 drivers/spi/spi-geni-qcom.c          |  13 +++++
 include/trace/events/qcom_geni_spi.h | 103 +++++++++++++++++++++++++++++++++++
 2 files changed, 116 insertions(+)
---
base-commit: 1f5ffc672165ff851063a5fd044b727ab2517ae3
change-id: 20260506-add-tracepoints-for-qcom-geni-spi-e31457c2267c

Best regards,
-- 
Praveen Talari <praveen.talari@oss.qualcomm.com>

