Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF48628980F
	for <linux-trace-kernel@vger.kernel.org>; Tue, 30 Jun 2026 06:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782799388; cv=none; b=K20UMo4mpl3UQ4AS7VeGDYP72PbZ5l9hLOkUL5sfOKRlQlzQ4OdDLWpt/OUUc3XI8o+MTUiUI0yN48r2Vo2+Dm7ISCbrrZxMURYoxa9e0U9LAEK6xlunvPUva1Lj34a1QeDafx4/GogqlIrgB67JB3AWkERZBuf5b15qc3UyyRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782799388; c=relaxed/simple;
	bh=a8t2wkRvLa1JchCqybi32unoLJ9yXcc54hmZVUkgubQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=GH9DAU/MZ6TgwTKRHqBdr9J1yfZFjc+UZ90C6enqbl6odN+pE5LK/K+N4Au6RaQ9vr132KmTRNjpDmhFuXZPg54PMVfevoCsr3mJi1fcZN9+ge6+G3moYt6KZk50ivmr4nw27cfP07WV/n2lEGITpwV0ePFNFfYRGWdctugs1Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=m0I5zEQe; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MoQMELeG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="m0I5zEQe";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MoQMELeG"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U5cLiU1009336
	for <linux-trace-kernel@vger.kernel.org>; Tue, 30 Jun 2026 06:03:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=shfeln5igxAy7CPuXN0OtP
	vgBHP3xlnyt4F/aOr5BIM=; b=m0I5zEQeMHAIqK22vcOV35YhmoYgMJidyrCpd0
	wrMDmSlAxNYQPZgT+DwtkOl/GmpNoRvOKldyvZigzAdzN4YMOKRoJVP9nEmcbeLs
	ZfWG6KIX421fmm8eUJjSwake60/8ETJVzSHJDWK5JVkg0a9LZ7/oafcVuwFExShB
	5bbUFSSCw3qgwwE5PLboa7VB83O1HwoxVLvXd5z778CrbLGE5Bdf5wNM2sywsaWe
	6Hxhcj+fEBt8frHUdwO0x7O1XvuJWpHPupE+7PgELQsM1DrSktDTGPeX8VDumsBc
	yZXcz4S/jZiICX0gZcpmovURYbOOLa4FyO2P7aPUZu5d/LUA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3qhac357-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-trace-kernel@vger.kernel.org>; Tue, 30 Jun 2026 06:03:05 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8479b7c3adbso862406b3a.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 29 Jun 2026 23:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782799385; x=1783404185; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=shfeln5igxAy7CPuXN0OtPvgBHP3xlnyt4F/aOr5BIM=;
        b=MoQMELeGUNPwcynq1XcW3e5QwShW2ZbO44tlvVBRNa5Ye2Vdys3H/LqJ+HR2xhPpVs
         lP8y0PcaQk+BWGGkGp/isC7hwcs9iS7WtclMMF2J8wx4wJsyX5QqkGXqIIi2+vjn2f6a
         lEZSHB+dEMuHPvp33AQrLJXyi7L+Cklt4k6gAhlRRsqD6SkE0Y5zdhtJBY7UO5jws1FY
         dKU2ybA5djt10eiM0SxuG5v0wliLA4sED3zSJUO9DMSWzWJdBc7IXIH6tftgiwLebws5
         s0fsranqDj6BebXmNHkoy8bBE0AG5qawtnSUAPBB3a4cgGAodXAKdij8Ax81uVMtbC61
         5QGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782799385; x=1783404185;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=shfeln5igxAy7CPuXN0OtPvgBHP3xlnyt4F/aOr5BIM=;
        b=W+++MdZAsc1Eo8Kk9WSB48X69M2OH7LcvfIrEmfJohnhyZlsYVbfw8wRn/yxS+MqVC
         vv6KGJH5DAcYGmdZvPHlo4OTrWdVW2ORfMzY6FEHHtCvjc+99Mm9ttv91MkOSpRwio1s
         Bj8Z1vUjgLX2/ZB4dvqF3/GnFZrO/C0TlEcBHeMFdBSwqfwDBaQHmSmVQCCyqriCITYh
         cJBvMjrjP7W2Gjp0sukCMKEzsmtwa+TXr1gafyx63muQ91XSUY90f70/8dS4mIXUjL0U
         t9jDAWZtLBgEgCtkAducKG9dWVDPFWzv09STqso/QyzehSQOMeNzC12Ay8ouftvI9Dmn
         pPQQ==
X-Forwarded-Encrypted: i=1; AHgh+RrwtN8/6jdi3XMv8rBO5BXgtS+hlZdY8bnq8sXfky9r5aoj/h08TVooTnSQMXD8wOwQWuDvkNF6NcLHexccAwLssIE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8iOAyXUJ4g7MARSkPqzbQArHpL8EUIdndWuDX4cPKrPtxMDr0
	uQr5w/PCRw/J3PbATCD+rJMXv0WjL/bfgrC5WHcV1JP1mpyfR4CcykrO3Y5fMNYEvOGPCZ4hKAT
	/ltO6L0ymusVD42aAUj6K6vBhaGItaj7HYY8AI36KrIt6yaepKr6nKuMBJTxHdHzsgoD8C4LwFS
	k=
X-Gm-Gg: AfdE7cnyqWsJGTiWci0aG+sgiPGvncsm8I7mLEiAIRODeCu+I6YPX6BLs7OZwhRYzID
	Mm4qavkcaImAGKK/gqHAGDnfUscYTjM+Ynk64pfM3GI1zLhgT8qIhBveGmubUzap0++NXvviyhd
	BZNFulxPVl14+tXlcx2GkINSVpZBYSBdX9nGcVwoP4S16TCsAhqFmNYCGVeddXE6CC+kc568+Nd
	Hci0uXkBFMCVOxYxCR6Iut3AG23nf7jEifTSx3qRZ/kQ7UzK8G/g7/imxaAuZohx9LqylHyYJpD
	jJDuHoc9ositAMlFYwfscmD05VUaXfMR21xpXk68ODMLf5hmiAeBaWjyHsdgSOWckJAgeDbkb+g
	NCzSPKmBt3xMu5be+AICZcfLG/YWFZzWBxj4xGpuG1UsR
X-Received: by 2002:a05:6a00:1745:b0:847:8499:bd with SMTP id d2e1a72fcca58-8479eef1340mr1903070b3a.24.1782799384839;
        Mon, 29 Jun 2026 23:03:04 -0700 (PDT)
X-Received: by 2002:a05:6a00:1745:b0:847:8499:bd with SMTP id d2e1a72fcca58-8479eef1340mr1903053b3a.24.1782799384278;
        Mon, 29 Jun 2026 23:03:04 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847a00029d3sm1112600b3a.20.2026.06.29.23.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 23:03:03 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Subject: [PATCH 0/2] Add trace events for Qualcomm GENI I2C drivers
Date: Tue, 30 Jun 2026 11:32:44 +0530
Message-Id: <20260630-add-tracepoints-for-qcom-geni-i2c-v1-0-474cd6cdbe27@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAARcQ2oC/yXNwQ6CMAyA4VchPdsEChL0VQyH0RWsiRt205gQ3
 t2px+/y/xskMZUE52oDk5cmjaGgOVTAVxcWQfXFQDX1dU8ndN5jNseyRg054RwNHxzvuEhQVGJ
 sW990x6EjGiYondVk1vfvcRn/Ts/pJpy/Ydj3D1zQnkGFAAAA
X-Change-ID: 20260629-add-tracepoints-for-qcom-geni-i2c-33d14584228b
To: Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        aniket.randive@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com,
        Praveen Talari <praveen.talari@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782799380; l=1510;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=a8t2wkRvLa1JchCqybi32unoLJ9yXcc54hmZVUkgubQ=;
 b=i8JM67rWtGlc2IhNVMUH3n/LFK4bOHB1dwBqzGMdDBS8wyLV3jiFFlUL8p4voEzKXFjmkg3Cb
 GhkFt0qrdL0AfYr5wPZn5JGzB/joe1LFWrbIIKLagtOa7N7Fk+DZcCQ
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-GUID: wHWULYzhyKJS6iI5C3XkEZQ2UukQ6nRo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDA0OSBTYWx0ZWRfX2GM4ITgEU2s5
 lVHZ9dluf0l3cYlp7UqpNV8rVeBC4+wX/lYnyVP+RbDKJ2kUFswsyOeszwKBnXtB095Jrmpn3dj
 QJ5IjXOZZ7mDviRbwUBT7osDM95PwF+1TA6weqDsSvvWVp6VlOi/B5wVZR1pGFuB0ScTOstcrvE
 2+oId/A1Ad/C3DhkAZqWfOSA9tEtAvjuFjV4Z7mFKxbdmePLjsAniJLoI8joQ9QEqXV/gmzX3/X
 V+1TMP/SR6Psl5Ddhv4QFXdXnzxKRjGqihQiKOSECZIURHZu26CJwN2eojiH4xPnvoIh3OY9EgE
 dQ8m2B7smpXO+WLOA4Q9idZ6sjhWvl5wAAD3OpgoHMaOWAAAYl12LQ7VX0N8f2kXix74wdiKwF6
 okXRIlf6nnOmBU+TOiwUM5YqLjN4MrpcyphcrXi4Ta0Tt9/bZoxjLH7xQ4iiRD/ycxGgAYIh848
 BG1M8n9J1Fg154ERuzg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDA0OSBTYWx0ZWRfX5u1YC3NFqkjC
 bNEJvsJytZmCTJTUmwUw+dwZ/kxikROVWK8bZ5LhM7gJ7JxUMjN824lC4swJfpFsgmwM10CefAa
 +PNk2oM6aNnsunUYlBFZvuZjQap1Tc0=
X-Authority-Analysis: v=2.4 cv=O9UJeh9W c=1 sm=1 tr=0 ts=6a435c19 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=pfqdL_FptRF-L44MAtYA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: wHWULYzhyKJS6iI5C3XkEZQ2UukQ6nRo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300049

Add a new trace event header providing tracepoints for the Qualcomm
GENI I2C controller.

The trace events cover controller bus setup, interrupt status and 
error reporting. These events enable structured debugging and performance
analysis using ftrace.

Usage examples:

Enable all I2C traces:
echo 1 > /sys/kernel/tracing/events/i2c/enable
echo 1 > /sys/kernel/tracing/events/qcom_geni_i2c/enable

cat /sys/kernel/debug/tracing/trace_pipe

Example trace output:
79.737075: i2c_write: i2c-11 #0 a=057 f=0200 l=3 [00-00-3f]
79.737075: geni_i2c_bus_setup: a90000.i2c: clk_freq=400000 clk_div=2
   t_high=5 t_low=11 t_cycle=22
79.737084: geni_i2c_irq: a90000.i2c: m_stat=0x40000000 rx_st=0x00000000
   dm_tx=0x00000000 dm_rx=0x00000000
79.737201: geni_i2c_irq: a90000.i2c: m_stat=0x00000001 rx_st=0x00000000
   dm_tx=0x00000000 dm_rx=0x00000000
79.737211: i2c_result: i2c-11 n=1 ret=1

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
Praveen Talari (2):
      i2c: qcom-geni: trace: Add trace events for Qualcomm GENI I2C
      i2c: qcom-geni: Add trace events for Qualcomm GENI I2C driver

 drivers/i2c/busses/i2c-qcom-geni.c   | 15 +++++++
 include/trace/events/qcom_geni_i2c.h | 82 ++++++++++++++++++++++++++++++++++++
 2 files changed, 97 insertions(+)
---
base-commit: 3d5670d672ae08b8c534b7beed6f57c8b44e7b43
change-id: 20260629-add-tracepoints-for-qcom-geni-i2c-33d14584228b

Best regards,
--  
Praveen Talari <praveen.talari@oss.qualcomm.com>

