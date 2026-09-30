Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4A84EA39A
	for <linux-trace-kernel@vger.kernel.org>; Wed, 30 Sep 2026 14:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790779953; cv=none; b=LSOOuuqxm0UkjRZ09V77J+I59Rd5oy9JEEw/q5T45tQ+lyD11UWOmyFKOZPEn5lwYSjIZxWunVAM0c5AAjX1f5E6g9+xQz9l+zi3EfQ/3W2m/hHqU5sM+/kVyOjDHSeW4WBSZ+caev2K9ZHXdJ5WF8bpOZZp6Gdz9Oyh/rn4cEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790779953; c=relaxed/simple;
	bh=AZzAXwiHHu9XZEBWoWxjc+qlmuW/9zpL5mYJCWh3B90=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HmM/Zcm6X17OuHFz/nlmM7DyVmMYy7ZS/DkkBfPv3N8/31Z1pvST1/KwJIK1kMIKf3k9yzPymKVQDsLvPF/cxh2oeB805nNinRKRuosEO8qbzsDxIViukGrU1Awn67a/z1d+GEKMpPFLHf7kZ7EQfGDIo/IRdm5qErJUury1tTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gIXx5H4n; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bPHfbWjS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gIXx5H4n";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bPHfbWjS"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68UDxlBn3063732
	for <linux-trace-kernel@vger.kernel.org>; Wed, 30 Sep 2026 14:52:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=5MQzMnZzp1O
	3Wb7yPZlYEZEBfKkuYTfPW2YrtjSZsDs=; b=gIXx5H4nh3APUmWzu3OzN2slN4F
	77R6IZACbUdAfF4Ycfz6vlQcJAzP+ScK9V+egwmyfaepZa2TYtEMNsKwdOarI7vO
	I+JcUpJnlX/N8MKLkvovgH3P0s9+xNyIrHmP45M/1GIw0XDOpby4Rv2kGsuwweYc
	uvB4irExVRAWwyj2VTCI7i/gBd1wdf0PU/5dtOIFWqUPKHb2gUaTvs6Sxf5KspdZ
	krFWPyIF/GxDjejYHmzTQxVvZpi/irLj3NRsHnTJRxnp6B6QZ13IHcHSUjcTWW/Y
	EHz9Wyw6rHfx3FhVowCVZscOJISQhugEhALJIXyg33bGSDDpIASW927vWtw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0smjk48c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-trace-kernel@vger.kernel.org>; Wed, 30 Sep 2026 14:52:22 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-34afa104860so2738043eec.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 30 Sep 2026 07:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790779941; x=1791384741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5MQzMnZzp1O3Wb7yPZlYEZEBfKkuYTfPW2YrtjSZsDs=;
        b=bPHfbWjSEo4+pnOusnZW2mNxos2i1tifePa2RYOtEhD5B7nJle7LflwBS36sZ2sPrs
         rnHU5elv6KHh1X+cuwqERw78nRCVn1wgoLnRgyzwEzXXmICaQzw9zuq7CV24Rx4e+URa
         TPWUW7S4nbOFvFrk6cbJZsRzdnqwQLA6PRzzmFjwCZ2a22b0xxf1AMTsV0gSMFisNTGW
         uCFDFPJXgWKEl36w93vEWkNeTsFRbzBMp1LWJ6CGTQzTMVTtvIdZPx0qrYGLvQ0VXsEo
         FjEZowcFbFJXrIz8ue2eLRqziSfQWwLStSxv6QZxSFGQfqRpt/dfGIIFSELX0VsEfKmI
         DrAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790779941; x=1791384741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5MQzMnZzp1O3Wb7yPZlYEZEBfKkuYTfPW2YrtjSZsDs=;
        b=lLKYQE6Ggr9lRPi0SQCQndCoy1GMJPiIUuPeUtYEkDgZ6wTevOumY5nf55b5ymW8FA
         HohH1i9G1NBYlST0uKTJH951Vc2wyHgZ4Iw4IXOWzuy7C1QYGwH2WadU7IJm9Wba7LrG
         5/aEOfEYRYM91GRR7wmaSGBycJochs8XXRKBljTuiHCsTStNVghwu8hV1EwqMPtIO2vt
         HisZKtOMK2veV9v4rXj8Mon69/AUOxtVkKkGzQIH00TJEBYwShNx1nqSrzW8tpz2fUNf
         on5zv5BCIodHXRlhcoFLKaIkT+W3fTMQ1yWBNQwHP5qFGCIu5aX2zKI1K7+Hb0fiSx6k
         5SlA==
X-Forwarded-Encrypted: i=1; AKwUvBwLR2SKvB1+PV+2bUg5l+TB17nrgjL/PhswZHYFbVar388GO0teZu8yRZ3wvfX8Z1vLAaPemfvaMHB+Z3youOgCAgM=@vger.kernel.org
X-Gm-Message-State: AFq9FYL6a0ZCpUO2qo5uSRNI4AyV7+DERz3scBUAhRFNlfvz/PhWfpRx
	9dUYcmExO9aGR/BDhbr5y2dCQdveYizRAwTSZPv1LB8o3/PLeAm2VsNawTBCbNOCvmWGZqPIiTC
	m9llpDmrn5PspLf2+DnJyznmbHfT3KL35A5sKR7wMwSA+DXMnW3+UuHsm7sUnNQ3UuNn+ugOlvX
	E=
X-Gm-Gg: AYBFou1QNvJGk9hgJjZduKUuwYxADSM3x0EB+1dlOgF4I3vvDZYhRz0EIi3ykQpWAcz
	tllLvBYMCalHwZ4qaoiAihaibAUJzxsO9fqRkbZQOTGBt3EvkELzw6PnPF0fS24SCpas49uq+PX
	FoE5/6fiFLD8r6RewyN7GpsmJrqiKoEEpOr4VEc6NTxSaPIh3Vriph5tfovoRLwXcMvWjY/gUY0
	CRTYpSzWp+t/+/tg0KCNinf1nCLJU4WUL/M5J6ZAc5T4CNOpzmS93uGCZ9sHgAnTiOUQfvThQwl
	TkdfWWlih6lnRdTglf5yJU9yO1THD1NeppgRgINaJVzt3oBF0/KVqsg5efg4NNuTMaWVZyYNlWJ
	xun8+U/1gPQNhbzKAU5l72wSx0Rnk7M378VK++JG3MZVdGoR5mWt2n+U=
X-Received: by 2002:a05:693c:87d6:20b0:34c:6942:8a47 with SMTP id 5a478bee46e88-34cdb8e6084mr1938460eec.8.1790779941365;
        Wed, 30 Sep 2026 07:52:21 -0700 (PDT)
X-Received: by 2002:a05:693c:87d6:20b0:34c:6942:8a47 with SMTP id 5a478bee46e88-34cdb8e6084mr1938430eec.8.1790779940718;
        Wed, 30 Sep 2026 07:52:20 -0700 (PDT)
Received: from hu-c-gdjako-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34cf5639339sm4524609eec.18.2026.09.30.07.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 07:52:20 -0700 (PDT)
From: Georgi Djakov <georgi.djakov@oss.qualcomm.com>
To: andersson@kernel.org, konradybcio@kernel.org, abelvesa@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        minchan@kernel.org, senozhatsky@chromium.org
Cc: axboe@kernel.dk, rostedt@goodmis.org, mhiramat@kernel.org,
        mathieu.desnoyers@efficios.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        djakov@kernel.org
Subject: [PATCH 1/6] dt-bindings: soc: qcom: Add QPaCE binding
Date: Wed, 30 Sep 2026 07:52:10 -0700
Message-Id: <20260930145215.3380977-2-georgi.djakov@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA1OSBTYWx0ZWRfXx50lL/99Zcim
 gYkld8W6gHbvPB1Tkj3WkIbHbIeA2yfQlKnPPCxwsxniHUf0D+N8GvNw+hGeBmml/Dw2J3IoEmO
 L6TBbMM1WJ5520hqtXyWBUOU5RSYuQY=
X-Proofpoint-GUID: t62SrzUKrwZtFjm_GvNUkqQrSFrzk7Cq
X-Proofpoint-ORIG-GUID: t62SrzUKrwZtFjm_GvNUkqQrSFrzk7Cq
X-Authority-Analysis: v=2.4 cv=KfxHIgYD c=1 sm=1 tr=0 ts=6abd2226 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=gEfo2CItAAAA:8
 a=EUspDBNiAAAA:8 a=P4ADLzTW1IxIBgx77pIA:9 a=scEy_gLbYbu1JhEsrz4S:22
 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA1OSBTYWx0ZWRfX2PmyBFVe7G4s
 A0OYuTdylnMF79lXiCGVoQ9+m10T758SkLknOZRaNc53FV7O33s5jRy3Yb63RS6YvXR5EY+9Qsh
 fQpof2zWKzDlYGJscqXKOURxFqBQg1uy1z6yxqVQchZ+ML7zfaQ4XGkq/BU2lE6kfhzRzxrB3Cd
 mfv5h+CKaXiHtyWj4MT4yiVuD1espmZpfIRdYbyyktsb60SVsouiCKG4Q2gDzNgUTT8rleGO+Mz
 cVGnwBazOLrElfwN7EN5c1M0P0tsjia7kLIRSevP/U/ExtYIoFMv4/HGzBHJOlb9j6oLODXM/1m
 t5e8mlKvz5cSJName3Lrtdgz+HGZtD5v0CBjfr+zi4/zCb1yTp7VVKnizMPY/YO1ANfOrmQXqGZ
 fV3szRMGXKVMhcA3JKHuq/bKZ4J9kaNZcNwQ7hJKfdyXglUlWKXelCBLi6CYKLZIvoZ/uZmc37F
 BElHrAerANXj291gYkg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300059

Add device-tree binding documentation for the Qualcomm Page Compression
Engine (QPaCE), including the resources needed to describe it in SoC device
trees.

QPaCE accelerates page compression and decompression for use with the zram
block device.

Signed-off-by: Georgi Djakov <georgi.djakov@oss.qualcomm.com>
---
 .../bindings/soc/qcom/qcom,hawi-qpace.yaml    | 94 +++++++++++++++++++
 1 file changed, 94 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,hawi-qpace.yaml

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,hawi-qpace.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,hawi-qpace.yaml
new file mode 100644
index 000000000000..b7ae50f34f16
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,hawi-qpace.yaml
@@ -0,0 +1,94 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/qcom/qcom,hawi-qpace.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Page Compression Engine (QPaCE)
+
+maintainers:
+  - Georgi Djakov <georgi.djakov@oss.qualcomm.com>
+
+description:
+  QPaCE is a page-oriented hardware compression engine found on Qualcomm
+  SoCs. It is composed of a number of compression, decompression and copy
+  engines and exposes both a low-latency urgent path for synchronous
+  single-page operations and a high-throughput ring-based path for batched
+  asynchronous requests.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - qcom,hawi-qpace
+
+  reg:
+    maxItems: 1
+    description:
+      Single contiguous register window covering all QPaCE sub-regions
+      from the GEN registers base through the EE registers.
+
+  iommus:
+    items:
+      - description: IOMMU mapping for compression engine read DMA
+      - description: IOMMU mapping for compression engine write DMA
+      - description: IOMMU mapping for decompression engine read DMA
+      - description: IOMMU mapping for decompression engine write DMA
+
+  dma-coherent: true
+
+  interconnects:
+    maxItems: 1
+
+  interconnect-names:
+    items:
+      - const: qpace-mem
+
+  interrupts:
+    items:
+      - description: Ring completion and bus error interrupt
+      - description: Urgent command completion interrupt
+
+  interrupt-names:
+    items:
+      - const: ring-and-bus-err
+      - const: urgent
+
+required:
+  - compatible
+  - reg
+  - iommus
+  - interconnects
+  - interconnect-names
+  - interrupts
+  - interrupt-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interconnect/qcom,icc.h>
+    #include <dt-bindings/interconnect/qcom,hawi-rpmh.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        compression@31400000 {
+            compatible = "qcom,hawi-qpace";
+            reg = <0x0 0x31400000 0x0 0x80000>;
+            iommus = <&apps_smmu 0x1c20 0x13>,
+                     <&apps_smmu 0x1c24 0x13>,
+                     <&apps_smmu 0x1c28 0x13>,
+                     <&apps_smmu 0x1c2c 0x13>;
+            dma-coherent;
+            interconnects = <&gem_noc MASTER_QPACE QCOM_ICC_TAG_ALWAYS
+                             &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
+            interconnect-names = "qpace-mem";
+            interrupts = <GIC_ESPI 72 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_ESPI 71 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-names = "ring-and-bus-err",
+                              "urgent";
+        };
+    };
