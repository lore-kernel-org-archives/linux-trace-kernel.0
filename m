Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EB329A9FE
	for <linux-trace-kernel@vger.kernel.org>; Tue, 30 Jun 2026 06:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782799396; cv=none; b=Rp4Qe0D6vO1gXiApI+p6ePHbLeZcpz5y11MJtFtsWp6HvMalI+S/UXkJjTtl7rGvCA026tZwRyCs1+VhmwcEB0SUIS99ZiyNW3raEkGcNXax0sZsJa1Q0Ur8ui13eyNjsV0KOWGEIfn+c7pL/P9lFEqCq1YajBHNQOUEGXoLTiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782799396; c=relaxed/simple;
	bh=IBRzc0iiDr752RyZmlrhOmlck4XRVCM5D9K2KWosX6k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VUfHBURiiPZk/T5CDOlbnDL20qx1aVF7yWqvYsc6cUwz4wvujgYbwwdc+b6Sng6sgUS2F8nf7Wg63nwbBD+ifUNwvrOzmqJXL8viTqfvwRxpfClUWtpJy9MNEGi8wpurB4SkkfMswKRDW86qBUDFMH3UaZYWaww+qEaCQ41bDW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eAIDybuO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fGbrmv/M; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eAIDybuO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fGbrmv/M"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U5cGV81019371
	for <linux-trace-kernel@vger.kernel.org>; Tue, 30 Jun 2026 06:03:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mwhlEvrUiE8Lwaf2hml9/SLLvTSWaySYB0Hb8e3qF0A=; b=eAIDybuO0PlFE4OQ
	+bURNWG5cxgvKNIeEka15ZEQEOvOvSfqh3y+uo1Ps+saXwmCcMIb797E3ONEmX/z
	Sgvcm2UMYg7G2C2jB+nNPuogTwBzmBLk1Z7fKsMmmWKbbJEBRwZLvqM+ALSnqeXX
	6g0ejkSB3LrHT+NOW1kScBtkMydkrgGbjmoFzddH5hsTn6+ukycR3+wyob6VBuyf
	qdh4bpY+VsjwMibuEM0jXcQS0+TCFE3//j+XwfXp7G+JUh/8vocBfYVjVxnAh3W2
	GQahPOrbNZ7kGDGhTM4ydu//v55Ml848D3UkZtwLg3ULCu9SujXVcLJ9LTohpdh5
	2adiPg==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f441gruk1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-trace-kernel@vger.kernel.org>; Tue, 30 Jun 2026 06:03:14 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-845bc2e658aso3110860b3a.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 29 Jun 2026 23:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782799394; x=1783404194; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mwhlEvrUiE8Lwaf2hml9/SLLvTSWaySYB0Hb8e3qF0A=;
        b=fGbrmv/MRQQYe/y/BoTA3kzXAyNMJ7b+Cx86lSH7psSaVrgyAa+VWWHT06G4TLTw6z
         ugAoPXSqQoPQX8xQiC2hTDgROZl0TY4mBfTXNQ2XZWZt+dTLQbagojcbvesGUXNEY7BF
         sltILnda8h9UKyOyoXRNZw4NQPGfBJfhGeorpW5kYlwlrpZBNzQtyX0075pSK2mCtxiJ
         oz2QHYuUJ9lnftjWElu3CNVnBpWWXUwq18DITvQabnQw/VfhOAzcheTt0gBLkUmqEcGd
         SSDRxQYQ/D5KhVnztA8dPSNKSFGQYkfrWZ6rmjZWSdKHO/N2sOg3+mBLF2ZaGZ9Z/93D
         9nCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782799394; x=1783404194;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mwhlEvrUiE8Lwaf2hml9/SLLvTSWaySYB0Hb8e3qF0A=;
        b=HoU83qvhf3BWW3wUI3VnHKBSk+xXVsYzevgK1noS1+olRJ5mQxAfYLru88oVDG0pj+
         +Gj51ZQ2NpVQaQ0SCP3Kk4+CfrZAnpvc5E/v1MNrI+TorYCpZuu3Wr5WpOt8iRJSHVsQ
         pizx/oOBZDSY93HpnEnqB2iG33ynoRBMHySlkzrUByjZ2pByljZM/Gbook/N3lzPWlFw
         KjKeXaYMeosDAyXt3E+SPb+EAZoXIsHri6V6P9kIDLBvyaIwvSOA7pGkE4XpRN6/pRgN
         ac0bVOQV4q+jhPcidjXQNXAOJ2QGhm4+q9l/4jM+GszPbwqgBBPaS3eHQ6+4LR6LMAT0
         S5+g==
X-Forwarded-Encrypted: i=1; AHgh+Ro1aLNqi6hsMsd8DgQv1uRidpvRY87ZBMXEdL0ikWnmeY8Jbq8G7WJZirYlgQcWABJqgSTP+ekRyA+CV/C9M4CjCsI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCnrEXxP2gqzJH+LG37/FhR7lj/iLmoCiuXSWVOF7mKX1r6NVL
	HMRx9qMI2bZgMhc1n+qLnVt3YOjpQIGqM9UpDIkLfGy91bWdp0+IpWG+Mp5ljl6Ov7IaE/Wl87V
	CGduQdTEUOXsf/sTrKxjsVAO7wtaNwgG5HZGQCCC2TuT18z9G15AsYWxW+lWYbnj1OMTQr4nCuJ
	o=
X-Gm-Gg: AfdE7cnV0Epoxc9lzNR2qZbnXnShy8PSyrp0Bff8Tr2PuysnbiUbRMu3okW8KyOZtVw
	ngE9+xWv3rK/QBITfmZCNsWba9tGC15VRw17uv1rPkqXnqbn0slF40zrKd1NCyek8RAn/gprZZD
	ZgCGEjfmh9E+f3MJ5Q33rNDScCOmcC6J+9sW9+OO6036ugASh0cQCjxY4PB6Kcll7d2Gbddk8Xl
	pAoDY/92i/xqvue9CU48sGo5YY0mVNWs7z1WI+9ekErEM9UaLkhIod31Hh82jNa73paQB5CTfC8
	6Q08xOaq8FZvBzeBcrKzFjKnaB9yzoFvu0VV3vypESjZfhZDg/prfLW+JIqxXet7Su59DsPWUOu
	WUitBfZpXnlhiP0589Cd22ovhdeNKTus1uPMH7GAjtmt0
X-Received: by 2002:a05:6a00:23c2:b0:847:7128:ecf1 with SMTP id d2e1a72fcca58-8479f2714cdmr1949405b3a.42.1782799393721;
        Mon, 29 Jun 2026 23:03:13 -0700 (PDT)
X-Received: by 2002:a05:6a00:23c2:b0:847:7128:ecf1 with SMTP id d2e1a72fcca58-8479f2714cdmr1949364b3a.42.1782799393145;
        Mon, 29 Jun 2026 23:03:13 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847a00029d3sm1112600b3a.20.2026.06.29.23.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 23:03:12 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Tue, 30 Jun 2026 11:32:46 +0530
Subject: [PATCH 2/2] i2c: qcom-geni: Add trace events for Qualcomm GENI I2C
 driver
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260630-add-tracepoints-for-qcom-geni-i2c-v1-2-474cd6cdbe27@oss.qualcomm.com>
References: <20260630-add-tracepoints-for-qcom-geni-i2c-v1-0-474cd6cdbe27@oss.qualcomm.com>
In-Reply-To: <20260630-add-tracepoints-for-qcom-geni-i2c-v1-0-474cd6cdbe27@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782799380; l=2683;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=IBRzc0iiDr752RyZmlrhOmlck4XRVCM5D9K2KWosX6k=;
 b=GRguIRps1Bi3/M9o4D0IBX2JCV68BDEGYAw2wtgV0LraRIlf9wFlQpXsBIPhHDiRfhFk9qBdE
 KSTkwrXjSn6BmKlkDtE9UeZzmRb7e5wTKZ/O7Gb1BrdbzXqWbcmg4d7
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDA0OSBTYWx0ZWRfX22KMgOAumSNv
 D5IWqUtMKn9ppwktgjX94+dfhRZ3Spb71ar4g+h6pyBNyNNFQaa6sd4gQfWxb12iy5VWVhN6B75
 EVck6hUHtlngucoBWN7jrjuxkr3BMgQ=
X-Proofpoint-ORIG-GUID: CdXDnyEp1bBt-CdSS2JJGBJArGRAkK0S
X-Authority-Analysis: v=2.4 cv=F8dnsKhN c=1 sm=1 tr=0 ts=6a435c22 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=0MkepCNd34v6RWspawgA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDA0OSBTYWx0ZWRfX2jiAcKo6Dhrg
 RDoFujjs3hIzgj+Q77r3Y5sg57GiKKf384pBQRDT2MgbJufK8rO533VACFZEXpuq2kSTo3DxZCu
 CG9JaMG3E+iLpjUoqBp1+Yy+N17YLotOr5sDpCyzsAwdV+XxTY5crRwzjdLjfanxvK+qq8dRr+b
 ovvhCfmKxt6doXKS5Pg8xKYFg309dUKUbvltdy4JC4X0VNe+fdfLv0RatHB0N3ho9OeSthuhKrp
 4Zl6Iq7X6CzMVwCAN5lm+FCMaln9tY6+j3mxDP/Ph0d9WyhJRO2nk4Zp0qjDRw313ymegPAOWNq
 xxeMrtkZPjiZUJeqXS1q1PbR6ui51r+t/iLBlVvxqREjBgERPmiv9nOROn8AR1tFTAihPIPrPUf
 gS0UlPIwOt1NDOIzg3QsjMkDVuA9Abg4sJhiHYayplIK1y0lEBUqiFc8vIJ9A5cKHCozI1FO1gl
 ZNsPLqezKEp/5viPmCg==
X-Proofpoint-GUID: CdXDnyEp1bBt-CdSS2JJGBJArGRAkK0S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606300049

Add trace event definitions for the Qualcomm GENI (Generic Interface)
I2C driver. These trace events enable runtime debugging and performance
analysis of I2C operations.

The trace events capture I2C clock configuration, interrupt status and
error code and message.

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
 drivers/i2c/busses/i2c-qcom-geni.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index 96dbf04138be..3227fab6d76e 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -1,6 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (c) 2017-2018, The Linux Foundation. All rights reserved.
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/qcom_geni_i2c.h>
+
 #include <linux/acpi.h>
 #include <linux/clk.h>
 #include <linux/dmaengine.h>
@@ -219,6 +222,9 @@ static int qcom_geni_i2c_conf(struct geni_se *se, unsigned long freq)
 	val |= itr->t_low_cnt << LOW_COUNTER_SHFT;
 	val |= itr->t_cycle_cnt;
 	writel_relaxed(val, gi2c->se.base + SE_I2C_SCL_COUNTERS);
+	trace_geni_i2c_bus_setup(gi2c->se.dev, gi2c->clk_freq_out,
+				 itr->clk_div, itr->t_high_cnt,
+				 itr->t_low_cnt, itr->t_cycle_cnt);
 	return 0;
 }
 
@@ -252,6 +258,8 @@ static void geni_i2c_err(struct geni_i2c_dev *gi2c, int err)
 		dev_dbg(gi2c->se.dev, "len:%d, slv-addr:0x%x, RD/WR:%d\n",
 			gi2c->cur->len, gi2c->cur->addr, gi2c->cur->flags);
 
+	trace_geni_i2c_err(gi2c->se.dev, gi2c_log[err].err, gi2c_log[err].msg);
+
 	switch (err) {
 	case GENI_ABORT_DONE:
 		gi2c->abort_done = true;
@@ -288,6 +296,8 @@ static irqreturn_t geni_i2c_irq(int irq, void *dev)
 	dma = readl_relaxed(base + SE_GENI_DMA_MODE_EN);
 	cur = gi2c->cur;
 
+	trace_geni_i2c_irq(gi2c->se.dev, m_stat, rx_st, dm_tx_st, dm_rx_st);
+
 	if (!cur ||
 	    m_stat & (M_CMD_FAILURE_EN | M_CMD_ABORT_EN) ||
 	    dm_rx_st & (DM_I2C_CB_ERR)) {
@@ -788,6 +798,10 @@ static int geni_i2c_gpi_xfer(struct geni_i2c_dev *gi2c, struct i2c_msg msgs[], i
 	peripheral.set_config = 1;
 	peripheral.multi_msg = false;
 
+	trace_geni_i2c_bus_setup(gi2c->se.dev, gi2c->clk_freq_out,
+				 itr->clk_div, itr->t_high_cnt,
+				 itr->t_low_cnt, itr->t_cycle_cnt);
+
 	gi2c->num_msgs = num;
 	gi2c->is_tx_multi_desc_xfer = false;
 
@@ -895,6 +909,7 @@ static int geni_i2c_fifo_xfer(struct geni_i2c_dev *gi2c,
 		m_param |= ((msgs[i].addr << SLV_ADDR_SHFT) & SLV_ADDR_MSK);
 
 		gi2c->cur = &msgs[i];
+
 		if (msgs[i].flags & I2C_M_RD)
 			ret = geni_i2c_rx_one_msg(gi2c, &msgs[i], m_param);
 		else

-- 
2.34.1

