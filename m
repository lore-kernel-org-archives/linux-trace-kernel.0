Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10AF6375F7C
	for <linux-trace-kernel@vger.kernel.org>; Fri,  3 Jul 2026 15:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783091318; cv=none; b=gPBuC2JdkSVaUnjL69Yw5PR2UruYXVTwJUGTukfDL4APBuLYMfaTfB1k+I0h1xBFtvfOfD3X2fu6Ue3pMyTvbCh3pvromztjabbKBH3/DqM5GjXEZpa3+rjjgOOqbrwt5XTHQMilCVddS/L5SZWzgO5xCCzCNLLdIoyzMD//HvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783091318; c=relaxed/simple;
	bh=SLKzc36ANlrTJ4UXlcsIz09mjFA5+gvF0IFn1cNkn98=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VzVfy/UurRvolLcR4emRF+3Y8mUAuVLcpuZuBfqy9QZqk53H8RNvcC1UqJ0TTxWMzCRgRQ/qUxlwE/BA12tQKAGJOEYIqKrG9UB+0de41HdUOc/RgbORVm69s6wITkPnI1zTIS7xqiVUESdJQlkfqe0BNtamztFc8LA5NrFm3qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nPysxJXq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fqxXtVR3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nPysxJXq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fqxXtVR3"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 663CK1mP3144699
	for <linux-trace-kernel@vger.kernel.org>; Fri, 3 Jul 2026 15:08:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AVG18AWi/7GZcB3iujp48a4REfVXmT1WDFQauOKLraY=; b=nPysxJXq1ISRuwU9
	P2PC8iBK5waFLilC4+WmGC5SzHiWxW+A9Bm4VK5fhPi0CY7uZ2A+rJasK+Zo2DyI
	O/YOCB7rNMHvCWGFf7GCTA3YbM5ywR0lvSAlDCAfc6iIbGQrvgcct2YsHDvSHT5u
	Bu0fwLZJzPYsr41RjJvTxN4Ahtg92hoqHdNNUAoDNwHh02JKOm5iz5to8wmaKUah
	tq1ASDyN7E7x4+QJJEBuXSLhHNxbZGf4yzoev/WydYbZY5olQiSlMDG4oeoqbu3H
	5BBRt1c8y7ROp1lpFkpYVIy/Hmd1CILkrckidVAYupNXFKPxyqv5Izvek7eboCXZ
	k8r13g==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f682bstfv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-trace-kernel@vger.kernel.org>; Fri, 03 Jul 2026 15:08:33 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-37e17ec1940so841342a91.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 03 Jul 2026 08:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783091313; x=1783696113; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AVG18AWi/7GZcB3iujp48a4REfVXmT1WDFQauOKLraY=;
        b=fqxXtVR3wk2iVwu9WknZ2TEjtbbH5DXKpw2febV+vZE/WkW5TeLVLcFDgn+1RZG/ju
         vf9bhLuvZkYSeHHc/NAONbs/Tevnmcee8uFaALq0dmhRV5yHVJnusCuuvPmvOS0wVCVX
         eZEt5FwSat59XS8VJMmyQqoq+KKZU7yFiAOfj7Oow6LAHuGTDwI0Z1jn/fEmmiOyOeFp
         bAlTvuj69zjspknteOTip3ua5VItKsNu3/X6IACnuSoMYImlntAORbE6I+BTAaeB0CBC
         CrvHponqp5MXAuKrsXRkzzmBLNIw2msKQXOYO1aXRwcl0iPckDBdqw49hIaFnu3iDSn6
         LUvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783091313; x=1783696113;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AVG18AWi/7GZcB3iujp48a4REfVXmT1WDFQauOKLraY=;
        b=YRPt8PILgHcgKg9C8vgqWOTGp/L3jJoHi+D5E9fkprUdd1O2A10wimZvzpivxP790I
         TBjsByRUkpX7dbLzn56NX61zmwBEuYOVhxXFA8Zr9L2A0C8xCKMTaQMMa9yT03t4QulU
         Sulu2qUpFOQ61GKwehZvQnDI16pOFQoDjgm6aN/Ah6CRxtvfFhsNsC3UfCm+aLuC1byw
         yEHGLHbM268x6pJwTEgQ5oGTBHJiTp6h5Wxvnc63334aYrVeWKHmagBnR59B6rsxax9/
         IutoUCU+u2lZgNCEQRPoqcxrpqtGQW1bGD0AACsb1DcVXG4oKYIDz6DL1VmCPq6sysi8
         74tA==
X-Forwarded-Encrypted: i=1; AHgh+RqQo4TvafNfGy0zftJ8zrCt/EgJIO5rYNUzmO0b7INSFtexSKmcRJxhpFIoxQhBvDatLZtIA80gpBHiy5JZ+K9A63Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfOvSkRyjUCrMjcz0xyaLn2toCBd05eEKP1WEVIih2rPtsFhWH
	vt8GoD2IdAoFiIwYUrXQenDKL22oNReUV3fU0jv9zsnIks06pRjIXW5LaNSdWfbEAXXqT/4FxLS
	e+Masl453YXjU7GaGBOdZoKyuOX6UZqWOYtonQISzZ6P7s1Y3UlazbL/efyUP2O3EW37R4/q+1V
	A=
X-Gm-Gg: AfdE7clO0xb3RE2HXpSTGgzj0OMYokdQYGNoXmbJvsWnmVZ36zX2A5ilOX5ZAgxAMAn
	+e/Vb3T+k00cZLDx6SxAndxz8IGVpk3kNh6krw1kh7Dy3kjIgm+0mN7iibR/N6yPFF+LJ9IPSb7
	ULpz5tExwoB4JFfvcGi0WeMlAlDEM367BRtrv1fF+uMQNUWImNeWwJYHry/ClQjDfhoOosILu2X
	hJHgYFauhJdLECC2VkIvIYZRZyAy11SjqBBkIxvSs64Rk+atqiz2ysdqJA1HFr+CNt/MJleokGQ
	SfuXjoXFR4WXKxc8vQ62q+eGeB8wBEDxSykKeTVoPmxJBC4R9B9rpQEVgLFZvR0k1yfilbTvjU1
	4lsRn7w8XGN5oYDGMZgjdi1eRmBNGs3WAhZCgMoMJd58t
X-Received: by 2002:a17:90b:4c07:b0:380:7d9f:81f1 with SMTP id 98e67ed59e1d1-380aa098483mr11495586a91.3.1783091312885;
        Fri, 03 Jul 2026 08:08:32 -0700 (PDT)
X-Received: by 2002:a17:90b:4c07:b0:380:7d9f:81f1 with SMTP id 98e67ed59e1d1-380aa098483mr11495518a91.3.1783091312156;
        Fri, 03 Jul 2026 08:08:32 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0b816a42sm37007808eec.9.2026.07.03.08.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 08:08:31 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Fri, 03 Jul 2026 20:38:10 +0530
Subject: [PATCH v2 2/2] i2c: qcom-geni: Add trace events for Qualcomm GENI
 I2C driver
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-add-tracepoints-for-qcom-geni-i2c-v2-2-e8bf8b178290@oss.qualcomm.com>
References: <20260703-add-tracepoints-for-qcom-geni-i2c-v2-0-e8bf8b178290@oss.qualcomm.com>
In-Reply-To: <20260703-add-tracepoints-for-qcom-geni-i2c-v2-0-e8bf8b178290@oss.qualcomm.com>
To: Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        aniket.randive@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com,
        Praveen Talari <praveen.talari@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783091297; l=2744;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=SLKzc36ANlrTJ4UXlcsIz09mjFA5+gvF0IFn1cNkn98=;
 b=BbTVYqz5bGt9wh4r4Hh2lALYtRHB9DlCQjB3Kn9E6j0DgfJLpHUnGcX4xVbKeyo0TT1r2Rh2p
 I8ATEYBIqkjBldCmObXaMUJOR3nHbQoRwIKWiId5ygTGWHIYb4r3M0D
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE1MCBTYWx0ZWRfX1J/u/FAv6WD4
 8VZFBR+O6p6i3gDMs9pQcbKPC7wMxiJKMz9b/FQdEhEFFDObaKbrPmSOBVVKZ34IDl7bCCJOQMF
 +UL+al1rlNdgnLW4tzYkBKLgOXa94R0wZ+4v0JxZhEOptXUdDWSWNPX1e0FAD9baQOY1GcUJhbv
 ntesRekUokzTO/TDIsl2Ug3zdeRCsuy8n8kGW2y33bcXhbpEq9gY26a39rcMgzmNzv01+r3821t
 5s7bPVrpiJJmLCf6ly5L2M6QGW6TNPI16L1Giz17BXR2GIgyweB2eg263Yr2yTy4GN3um/aRne6
 SSK2gSNmwUtJqPU68JVbIZf5h90iAH/9Dn24O1zYTQA3sPbulfi+47msEQiUKdKdhsdlSp2VclS
 8doAh9KJDXQFilOqpzO968m+aGjPMZxfYrlzKKXXLC9dxDhcSDOjlEtKjpiZp4i1Y391A7vSB/d
 DCWz4UDqrTzYC4cnLfA==
X-Proofpoint-ORIG-GUID: 8AlQZwADHVIiPcfqXcaPIRu1OhcGfCG5
X-Authority-Analysis: v=2.4 cv=cc3iaHDM c=1 sm=1 tr=0 ts=6a47d071 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=0MkepCNd34v6RWspawgA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE1MCBTYWx0ZWRfX/H1TZ+UgupMI
 YE5qMke9w2yRlGOxvp8WFXMFrBbvPu2OvOfV7Ukk3WGcLxBfTSx7iD3SpgjPuEyF6EAsrsu0t+r
 +xnGLXqP97UfhciG488Z9XKcIdKyoBg=
X-Proofpoint-GUID: 8AlQZwADHVIiPcfqXcaPIRu1OhcGfCG5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 phishscore=0 spamscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030150

Add trace event definitions for the Qualcomm GENI (Generic Interface)
I2C driver. These trace events enable runtime debugging and performance
analysis of I2C operations.

The trace events capture I2C clock configuration, interrupt status and
error code and message.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
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

