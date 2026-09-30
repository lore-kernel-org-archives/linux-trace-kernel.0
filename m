Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CE74FC8D2
	for <linux-trace-kernel@vger.kernel.org>; Wed, 30 Sep 2026 14:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790779957; cv=none; b=CLbCh9WSeNIXNgXo+KY5WLcJMcEhvUEKeeHHnywCY8nhgB0IDGLQWL4c3xexyyzmxYedSVnpuLiWdTqTACBMnEDlBRBf9m2/ej+lLa2KcXS7dWWvw7FQAicixi5MqikkzBIJhENvklpR+Eou5SsSnP+N6i59nFI+OTbudTpeI+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790779957; c=relaxed/simple;
	bh=XjmZ7HCZSIfcoUltaCRGXefZ8w1zKPfi3DotR5M/Yrg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Iqa+UJKLXv3j3mDV6TJoL04tPEMbKxzN7deCj9xgF31o48hxXsc7l6yNI6vJx4rOW1mfQWDtXCgobaZ17hhcq4t2wLB0vZUjhniFlm7I8lVIuk83kkoAYp+tDcx7R5axkfEGhwV0mB26U526XU40oxhzJwr8h4UbOJgeI5kAVcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Dl7B4U6L; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=G4q0MenF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Dl7B4U6L";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="G4q0MenF"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68UDxpOV704450
	for <linux-trace-kernel@vger.kernel.org>; Wed, 30 Sep 2026 14:52:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=zkTo8nTIePk
	l65P8PXm0LiFZiH9dHt4Vj2fwdowNXuE=; b=Dl7B4U6L/OfBcrryy6otn6p04/i
	UjB8WKsFOwxAf5UChh5PAuojTBPMJvIOqmSrzVZfvpEVeWZ0kgar2B6FFNe6n2pT
	lAF77UeP7IJkBQSKk4X1jAYplq9Bgds1lBvdZ+3bdv7/lZvdm1D6B7V5JGr/+oy2
	H9TsfhHhdhaNdgYHhT/Oy6miYUrYS+i0xN1DIcxEJEPjb31/pRZchhw72pxVWnpA
	k0fhvN9QuGFJhTAMFNpbpbYk+eL0zNvdn3WCV/B7dtooRqU4VrekXYajq7y9qGdl
	o2Ne9GkuLd9CGWqdtg528Qtcx2z+kWYCssOJlxVx1bbLZHZoAHApmxDkoqw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h136tgcvr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-trace-kernel@vger.kernel.org>; Wed, 30 Sep 2026 14:52:25 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-33713e5e6daso7908600eec.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 30 Sep 2026 07:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790779945; x=1791384745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zkTo8nTIePkl65P8PXm0LiFZiH9dHt4Vj2fwdowNXuE=;
        b=G4q0MenF7Ilz8g+4/LiwZpxxN/ieS+AS6Sdp50F+4DY4vJKthEy4nL8Xn90aeSqjFX
         y+oEkYliDg47OznETfdswlzfyCYBb7qqdX9gDdCSOWpvCib4Lm2Tg3XJc2mnBb9Yby+n
         +wAYo8rEpePyeyhMrWz6G/XB0aSoHVR5Yfc5aeB6BLhufpHrbnoJDixdIX8NNug8wGWX
         hFmQk1x2YohoSKfhcuGvY5eKfmYL7zHieYDTW+qrRf1foxVfOfIjvrmZg7doQ8KXMg78
         SAGeif/pMeEpI46Jp++lB8pXm99QMjc0Y28yO6mQLV8Q1ewmmvt3ylwFMyEUe+VNmBWG
         aLwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790779945; x=1791384745;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zkTo8nTIePkl65P8PXm0LiFZiH9dHt4Vj2fwdowNXuE=;
        b=UyFaqtZ/CXbbtU/aJ0cgwnqQ1Lk9gpUXjPdQ9UBEsLXEc461HJQVO9hwsol5j+cZ1t
         WjwyAbJv8SwGVGUzYjhQxTFomUEto801dmFlT2Bl5v61C9gvSOIA5sQ/SrxUims1cl/U
         LwawdEtUZPKkhvCqheYbPbHcDmBugTDSY+UpGbfjSkzyxAQz4Yp5UUrNdM+Y6NRrU8Y2
         3trJ81lgDP5/JGOmYbNkW8zprSAJV8+VMLdWT5cisudNWscoL2PCVw238G6dyV+LibhT
         f/Xp3d9i/Lc/KYjMfho3bor7JOG9a3Xym0GcQqwZTsCfsfaVk+v/aVc52MftSFHquR5K
         bnoQ==
X-Forwarded-Encrypted: i=1; AKwUvBzffBAXmxKgXu+Pjd4tcwGmTT5OqYf2XYdPAaDdgBZYCInhFUz8XI7OWDLYBBvmVMB0KERAUkeYNWK1FQX7w2Q/Lxc=@vger.kernel.org
X-Gm-Message-State: AFq9FYI0GH63rmA1rphUXdh5P7TmYFh18QDu949G/UjvqMnOUkIMpY1G
	Hb1fR76py+IZN1vwq6P0JhzOJ72ddHtmKK8sv1REJsb3+/i7yj/c4vpNX/Gde92HStgTrlaQ1r1
	yllbUEbXJ966xp8UE7oZL7ZqrnYRbDwiCb1EMrxLbmjlzUzaKUnCGyG6IKxRCXj76qCum/dJtNX
	w=
X-Gm-Gg: AYBFou1+7VRzhUZ0cACM+oaDQ3oSnNajY0x563giGrCDG7sz7AMQ8ESQSgxptbuTADB
	kBBWeGP+9wxdunJQO8Y1pb1HoawF9ljIkF0zxxWUgFd3ZCdoBAZWJkkCSNfElnguvHXa2ouvD/X
	md5QrQxPei1TZXdKbp/lxIbr6KP/bsRWLEOhlzvxRHlYs5AGxaz+JQs4Nxj1LLbha9BZk9qfVUC
	4d95Im8IrLLkqX6dEGBxl7koRLXak5gegNMnIQKkfe4xGreXtWOUPd/MkmTaqVlCLv+XJmOrnnY
	ZAo1DtM7ffy98AYrbNbyqmL5NxfVn7Oar0i+j8zQTmIdifWjw/CDXU0553oZOlBXgvJFWqC3s9h
	sQIegG/sO9FeQ6fPY+DiK83Gxkw2HdjhHED8EIsvoocq+1Il2IMV7eaA=
X-Received: by 2002:a05:693c:894c:10b0:343:fdea:998 with SMTP id 5a478bee46e88-34cdc0cf62bmr1907068eec.19.1790779944586;
        Wed, 30 Sep 2026 07:52:24 -0700 (PDT)
X-Received: by 2002:a05:693c:894c:10b0:343:fdea:998 with SMTP id 5a478bee46e88-34cdc0cf62bmr1907034eec.19.1790779943788;
        Wed, 30 Sep 2026 07:52:23 -0700 (PDT)
Received: from hu-c-gdjako-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34cf5639339sm4524609eec.18.2026.09.30.07.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 07:52:23 -0700 (PDT)
From: Georgi Djakov <georgi.djakov@oss.qualcomm.com>
To: andersson@kernel.org, konradybcio@kernel.org, abelvesa@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        minchan@kernel.org, senozhatsky@chromium.org
Cc: axboe@kernel.dk, rostedt@goodmis.org, mhiramat@kernel.org,
        mathieu.desnoyers@efficios.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        djakov@kernel.org
Subject: [PATCH 4/6] zram: Add QPaCE zcomp backend
Date: Wed, 30 Sep 2026 07:52:13 -0700
Message-Id: <20260930145215.3380977-5-georgi.djakov@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260930145215.3380977-1-georgi.djakov@oss.qualcomm.com>
References: <20260930145215.3380977-1-georgi.djakov@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA1OSBTYWx0ZWRfXytnJw6r/4MUF
 hp9UrbfTaIL90nAV1HTVM+y55mjNbF/3Q9bG3wTjjgbfuDc48ZvIaWVwxnIUgbx33CAtOgsAtt3
 7BWWcrjpvNIr4HN3hPeDDwUve4kiGYw=
X-Authority-Analysis: v=2.4 cv=aPFlOr9m c=1 sm=1 tr=0 ts=6abd2229 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=S8Xc0r_aw9f0a4gVDKgA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: T2dJuOBuPbW_HmiD5YWjE9-T-hMjytDI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA1OSBTYWx0ZWRfX/+wbu+wUhC02
 4AP7D0bwBNRY1hQuDyqdcycs37IgZvw3w0c9xPaGm2DXk6WMsgcIQbBSIXJW238We9SCO2km2sw
 92bJAvSAU8T3IayAvAnhNWfCYPclIVkqAr3znECyqr2Y+lZTAUVvqeAElg7uyjWl7gAQA0k4O9v
 /Zj8knaXs88BKyuS7Ow3tjd/Uhv4HSUVYWCkhUDRzzTLOLPv9M9DC6EavpGZn2poUpJ7r0ESFew
 Xbi2Z4/f//7ySUoiywV21IbMXE3m6C/48fnYtdiPvT4mwJt3T6lzceNgWiynmK26A3ljY4Nwgu4
 T9uTacWVU4fk/ZEc1Toa9LHUX4maCW5nMx80wtKm0vsUz8JlZk4J3LasJ/ISea/C4omYyO5yZqW
 5S0Ua2h0kPLpVWXXl461IGYdf4/3kUKnVAHuKJJyvMI1lJq5t8ca0qOwkZX/duyzxrU3m8yvXqo
 Gwb3bd/V0fANL9kqQTQ==
X-Proofpoint-GUID: T2dJuOBuPbW_HmiD5YWjE9-T-hMjytDI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 phishscore=0 spamscore=0
 malwarescore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300059

Add a zcomp backend for the Qualcomm Page Compression Engine (QPaCE) so
zram can expose qpace-lz4 as a selectable compression algorithm when the
QPaCE driver is available.

Compress and decompress operations are handled via the QPaCE urgent
synchronous path: each request DMA-maps the source and destination
buffers, issues a blocking hardware command, and returns the result size.

Signed-off-by: Georgi Djakov <georgi.djakov@oss.qualcomm.com>
---
 drivers/block/zram/Kconfig         |  11 +++
 drivers/block/zram/Makefile        |   1 +
 drivers/block/zram/backend_qpace.c | 134 +++++++++++++++++++++++++++++
 drivers/block/zram/backend_qpace.h |  13 +++
 drivers/block/zram/zcomp.c         |  11 ++-
 5 files changed, 168 insertions(+), 2 deletions(-)
 create mode 100644 drivers/block/zram/backend_qpace.c
 create mode 100644 drivers/block/zram/backend_qpace.h

diff --git a/drivers/block/zram/Kconfig b/drivers/block/zram/Kconfig
index 402b7b175863..eece67e7ea83 100644
--- a/drivers/block/zram/Kconfig
+++ b/drivers/block/zram/Kconfig
@@ -44,6 +44,17 @@ config ZRAM_BACKEND_842
 	select 842_COMPRESS
 	select 842_DECOMPRESS
 
+config ZRAM_BACKEND_QPACE
+	bool "QPaCE compression support"
+	depends on ZRAM
+	depends on QCOM_PAGE_COMPRESSION_ENGINE = y || \
+		(ZRAM = m && QCOM_PAGE_COMPRESSION_ENGINE = m)
+	help
+	  Enable Qualcomm Page Compression Engine (QPaCE) hardware
+	  acceleration as a zram backend. When selected, zram offloads
+	  synchronous compress and decompress operations to the QPaCE
+	  urgent command path, reducing CPU overhead.
+
 config ZRAM_BACKEND_FORCE_LZO
 	depends on ZRAM
 	def_bool !ZRAM_BACKEND_LZ4 && !ZRAM_BACKEND_LZ4HC && \
diff --git a/drivers/block/zram/Makefile b/drivers/block/zram/Makefile
index 0fdefd576691..9e1c35f942e0 100644
--- a/drivers/block/zram/Makefile
+++ b/drivers/block/zram/Makefile
@@ -8,5 +8,6 @@ zram-$(CONFIG_ZRAM_BACKEND_LZ4HC)	+= backend_lz4hc.o
 zram-$(CONFIG_ZRAM_BACKEND_ZSTD)	+= backend_zstd.o
 zram-$(CONFIG_ZRAM_BACKEND_DEFLATE)	+= backend_deflate.o
 zram-$(CONFIG_ZRAM_BACKEND_842)		+= backend_842.o
+zram-$(CONFIG_ZRAM_BACKEND_QPACE)	+= backend_qpace.o
 
 obj-$(CONFIG_ZRAM)	+=	zram.o
diff --git a/drivers/block/zram/backend_qpace.c b/drivers/block/zram/backend_qpace.c
new file mode 100644
index 000000000000..3af13727adef
--- /dev/null
+++ b/drivers/block/zram/backend_qpace.c
@@ -0,0 +1,134 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <linux/dma-mapping.h>
+#include <linux/slab.h>
+#include <linux/soc/qcom/qpace.h>
+
+#include "backend_qpace.h"
+
+struct qpace_ctx {
+	struct device *dev;
+	void *in_buf;
+	dma_addr_t in_dma;
+	void *out_buf;
+	dma_addr_t out_dma;
+};
+
+static int qpace_setup_lz4_params(struct zcomp_params *params)
+{
+	params->drv_data = (void *)&qpace_lz4_algorithm;
+	return 0;
+}
+
+static void qpace_release_params(struct zcomp_params *params)
+{
+}
+
+static int qpace_create_ctx(struct zcomp_params *params, struct zcomp_ctx *ctx)
+{
+	struct device *dev = qpace_get_dma_dev();
+	struct qpace_ctx *cc;
+
+	if (!dev)
+		return -ENODEV;
+
+	cc = kzalloc_obj(*cc, GFP_KERNEL);
+	if (!cc)
+		return -ENOMEM;
+
+	cc->dev = dev;
+	cc->in_buf = dma_alloc_coherent(dev, PAGE_SIZE, &cc->in_dma, GFP_KERNEL);
+	if (!cc->in_buf)
+		goto err_free;
+
+	cc->out_buf = dma_alloc_coherent(dev, PAGE_SIZE, &cc->out_dma, GFP_KERNEL);
+	if (!cc->out_buf)
+		goto err_free_in;
+
+	ctx->context = cc;
+	return 0;
+
+err_free_in:
+	dma_free_coherent(dev, PAGE_SIZE, cc->in_buf, cc->in_dma);
+err_free:
+	kfree(cc);
+	return -ENOMEM;
+}
+
+static void qpace_destroy_ctx(struct zcomp_ctx *ctx)
+{
+	struct qpace_ctx *cc = ctx->context;
+
+	if (!cc)
+		return;
+
+	dma_free_coherent(cc->dev, PAGE_SIZE, cc->out_buf, cc->out_dma);
+	dma_free_coherent(cc->dev, PAGE_SIZE, cc->in_buf, cc->in_dma);
+	kfree(cc);
+	ctx->context = NULL;
+}
+
+static int qpace_compress(struct zcomp_params *params, struct zcomp_ctx *ctx,
+			  struct zcomp_req *req)
+{
+	struct qpace_algorithm *algo = params->drv_data;
+	struct qpace_ctx *cc = ctx->context;
+	int ret;
+
+	memcpy(cc->in_buf, req->src, req->src_len);
+
+	ret = qpace_urgent_compress(cc->in_dma, cc->out_dma, algo);
+
+	if (ret == -E2BIG || ret >= PAGE_SIZE) {
+		req->dst_len = PAGE_SIZE;
+		return 0;
+	}
+	if (ret <= 0)
+		return ret < 0 ? ret : -EIO;
+
+	if (ret > req->dst_len)
+		return -EIO;
+
+	memcpy(req->dst, cc->out_buf, ret);
+	req->dst_len = ret;
+
+	return 0;
+}
+
+static int qpace_decompress(struct zcomp_params *params, struct zcomp_ctx *ctx,
+			    struct zcomp_req *req)
+{
+	struct qpace_algorithm *algo = params->drv_data;
+	struct qpace_ctx *cc = ctx->context;
+	int ret;
+
+	if (req->src_len > PAGE_SIZE)
+		return -EINVAL;
+
+	memcpy(cc->in_buf, req->src, req->src_len);
+
+	ret = qpace_urgent_decompress(cc->in_dma, cc->out_dma, req->src_len, algo);
+	if (ret <= 0)
+		return ret < 0 ? ret : -EIO;
+
+	if (ret > req->dst_len)
+		return -EIO;
+
+	memcpy(req->dst, cc->out_buf, ret);
+	req->dst_len = ret;
+
+	return 0;
+}
+
+const struct zcomp_ops backend_qpace_lz4 = {
+	.name			= "qpace-lz4",
+	.setup_params		= qpace_setup_lz4_params,
+	.release_params		= qpace_release_params,
+	.create_ctx		= qpace_create_ctx,
+	.destroy_ctx		= qpace_destroy_ctx,
+	.compress		= qpace_compress,
+	.decompress		= qpace_decompress,
+};
diff --git a/drivers/block/zram/backend_qpace.h b/drivers/block/zram/backend_qpace.h
new file mode 100644
index 000000000000..03747405edcf
--- /dev/null
+++ b/drivers/block/zram/backend_qpace.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef __BACKEND_QPACE_H__
+#define __BACKEND_QPACE_H__
+
+#include "zcomp.h"
+
+extern const struct zcomp_ops backend_qpace_lz4;
+
+#endif /* __BACKEND_QPACE_H__ */
diff --git a/drivers/block/zram/zcomp.c b/drivers/block/zram/zcomp.c
index 028e2f0f587e..b5bd0b11a975 100644
--- a/drivers/block/zram/zcomp.c
+++ b/drivers/block/zram/zcomp.c
@@ -22,6 +22,10 @@
 #include "backend_deflate.h"
 #include "backend_842.h"
 
+#if IS_ENABLED(CONFIG_ZRAM_BACKEND_QPACE)
+#include "backend_qpace.h"
+#endif
+
 static const struct zcomp_ops *backends[] = {
 #if IS_ENABLED(CONFIG_ZRAM_BACKEND_LZO)
 	&backend_lzorle,
@@ -41,6 +45,9 @@ static const struct zcomp_ops *backends[] = {
 #endif
 #if IS_ENABLED(CONFIG_ZRAM_BACKEND_842)
 	&backend_842,
+#endif
+#if IS_ENABLED(CONFIG_ZRAM_BACKEND_QPACE)
+	&backend_qpace_lz4,
 #endif
 	NULL
 };
@@ -80,10 +87,10 @@ static const struct zcomp_ops *lookup_backend_ops(const char *comp)
 
 	while (backends[i]) {
 		if (sysfs_streq(comp, backends[i]->name))
-			break;
+			return backends[i];
 		i++;
 	}
-	return backends[i];
+	return NULL;
 }
 
 const char *zcomp_lookup_backend_name(const char *comp)
