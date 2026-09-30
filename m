Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8338B331EA4
	for <linux-trace-kernel@vger.kernel.org>; Wed, 30 Sep 2026 14:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790779969; cv=none; b=LaUrvKcN2wXH/dpvi/GNKznOGjJViD96LlnEv3yzAIMoww78gaJp4kHRp81sXcOXYC1dii6SMtTubAdD4Wh1XoFEUqAaWE/B/yQRLwf80VuwOfluXWGMAN+457tYp7xGaNNScTmkh9Ox2WQpgcR4n5Vpks/7pfbYOkZ+gfv3wqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790779969; c=relaxed/simple;
	bh=5GJGXU8fsHQt/qFopLvzw/9Pem+53Rp3DL4C9MNnYlA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CHaLB46mZwCmSo8hHNEchFw9U8J9bnzHAnm3bZ845IqgCRIXWLi+NOv6ccdtbRmi+joFGlwleCz2gcYRR8dC9JyLxS6v9++HQn/8rwsJ3OgRtL0fKiktTC2+6c2n0dWsYZJNoCKrJYULH5uDUCmpDjYYO2GZwkMq3QMC08EGmZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iLWuNrds; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fweErejb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iLWuNrds";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fweErejb"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68UE01XM3669208
	for <linux-trace-kernel@vger.kernel.org>; Wed, 30 Sep 2026 14:52:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=quF3R874oc+
	nzE7gwS/oZ4MN3r+xqKntIK58vfepnss=; b=iLWuNrdsLj6wcg2qoSsJPCDsBML
	jbKsI+ZMr93owVlWQ8RjqIvwOX7EolPr8zeRNSFWNWArisnvp5RewanbQ1bfN2sQ
	yxh//x8e+UzLMaPZmqnJWwPZ9RumtuBjlibPB0Pxhppy3hsucWsjcCjU41v1DAM8
	rU7nmYDu+UxIrJLAVcaH/5eUqvdezSnS+ybiiaKEPWzzFaAoPihPrJoQbpMIWpsd
	gxq3Qm8GB3O9JnWHIuNn0QFuiMipv7ySI/RX800CXpoHgymTr3j/EKE/EeeIR5yr
	zLE98yWnXqTwR8bGK+AyoJZ8U8HxIHGf/IqqU/y1/FA+6f/86y33DUgUIpA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0rj2udgn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-trace-kernel@vger.kernel.org>; Wed, 30 Sep 2026 14:52:27 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-341eff9e381so6677538eec.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 30 Sep 2026 07:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790779946; x=1791384746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=quF3R874oc+nzE7gwS/oZ4MN3r+xqKntIK58vfepnss=;
        b=fweErejbo8VT8vyZs5H+mx5ckIlaSR6aJe52n4slceuTXC4qxocewHfN7Pi6t/7Z6e
         P8gWh+dobj+GNKd0JPVvvxmS+EpcdR6+VFNPuz/fRIT+60LI/l4ww+g7FjLc01HDwVZQ
         PV2yVc2UcoRVygwqPpHnlQvBtgJ3pTv/4kf3VrLuZVsilQOMDcvUM4cFcRnLKmDSXZXL
         2TUpHwEzLJD8NnK0+9cXJGiwYN4rlMOMi/SriYo3PckK/e/FLNo93iFsTP7EIqOT508b
         BtgCrlB0nZeQjuHcZ/eQpNfGn6fuSRlkIgeNCXI0gNAZBz2QLIKnwMnN43DWVruF9sme
         6OSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790779946; x=1791384746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=quF3R874oc+nzE7gwS/oZ4MN3r+xqKntIK58vfepnss=;
        b=CLzaE6O1iN+zLvXgRkgymlLL0ZH5iTSnXUQd3NkgGh0sYA49ZvHYG8Y82G7RKGAecy
         Z8gQmvTT30J372pTbS6z/v41fPVru/qNFQccg7RQYn2YpdA4HUlNSccmQPHcKFihslIQ
         vh+QNF2iehNR/WjsEvdjuUTQoNd3EoD+myjMRJLBmOvJtC1KfPa7bS3JItD9dK+TAF7d
         mC0TLtzQyg1QCwpbkzpgPg7FwPPse3UzCSoC6IjE7eygNCNVV93QTY6V7vABDLgEMOFQ
         kDrLO1I6Uvkpb9ikqroVp8u2B1406KYh4N8Wg8phRqkf9thwErMkBSEH1+ne/sHADo4l
         9afQ==
X-Forwarded-Encrypted: i=1; AKwUvBz8wyGt3AjOIca1VYtvBi8/u73l4TlHCljoeFLexfMgiaKYIJPa1HlGkKwne0Ies2KiwUteyLpH3mdppOha8coRS9M=@vger.kernel.org
X-Gm-Message-State: AFq9FYJVYeK/42ZrcsKw843yvSwNtNzlyuBHBY0Cn05IHOeBIDrF8WK5
	QfcUU54dju0MDr1N6wMFbwnW0rbZpGwrnwaRpryGq78bkkSxIyv//L1pKidpdYo4dngnc1JwNFM
	P4Tlos5EfBLOZSMU29cjPXgR2+WX/SS8xFkcf6z0c1MQiYNbtYq1Rob8Rf4KBoFuQP+onSR1DP7
	4=
X-Gm-Gg: AYBFou3YdRbYgolMyBdOnF9qDPM0SeieRl++oQ6e3lHks2Vvfyk+Eg4Y+cudlRlgcHD
	BZ7FnylCszhCVb59vPptmsCuBe3G9/caOW/deiLfv7hEqxCja1DiYV/43EphsrVRmeYstCrJOs4
	YZnde8GjRRK3pA9HfK328MqXvlNGihDSTuzSMAePx2hsOvkDsC914SVdMtAYJuC3VLornc2oo4u
	e8FtW6zxKhTYKueFhFv6f+0U71GsqWrZFpedpqeQjhOVITAbCIGBlvL3CPDXnaMlTJKHTYi8/P5
	xdinvcaQt1KywQVDUYaZccoq+HP2ghV6Q1ulrWGsQ1XO2T7NXDkhk3YwX8z7pjbE/ZsIw1wFcI/
	xJ7C9U8DOX7jH5oECitx/pCI1vZj/slF55bCZN8Ld5ay835DcHeQJpwc=
X-Received: by 2002:a05:7301:9a81:b0:33b:c24c:d31c with SMTP id 5a478bee46e88-34cdc0cd8dfmr1890760eec.7.1790779946336;
        Wed, 30 Sep 2026 07:52:26 -0700 (PDT)
X-Received: by 2002:a05:7301:9a81:b0:33b:c24c:d31c with SMTP id 5a478bee46e88-34cdc0cd8dfmr1890729eec.7.1790779945736;
        Wed, 30 Sep 2026 07:52:25 -0700 (PDT)
Received: from hu-c-gdjako-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34cf5639339sm4524609eec.18.2026.09.30.07.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 07:52:25 -0700 (PDT)
From: Georgi Djakov <georgi.djakov@oss.qualcomm.com>
To: andersson@kernel.org, konradybcio@kernel.org, abelvesa@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        minchan@kernel.org, senozhatsky@chromium.org
Cc: axboe@kernel.dk, rostedt@goodmis.org, mhiramat@kernel.org,
        mathieu.desnoyers@efficios.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        djakov@kernel.org
Subject: [PATCH 6/6] arm64: dts: qcom: hawi: Add QPaCE DT node
Date: Wed, 30 Sep 2026 07:52:15 -0700
Message-Id: <20260930145215.3380977-7-georgi.djakov@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: 8zabqjimd4YSwpxYKKyKPWnHFfZpNwJu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA1OSBTYWx0ZWRfX0txs5Yvgt981
 olH9um01YNokOc4esMHb5KVxKmvGqloVSgF6lWlh4UXGVjiLGwhJ/ebHLiB0lGclua95GSRL+41
 s2N2H5H3YKjboitLT+o82O7vwOL7oMfgwzAzDNY3CJgZ/KFQHj3TofAVMw4E5N8TiyJVIkMbBDi
 ZAe7pQwPf9eCfoeIZVgdp68JE0zUz5IHTtHnmV2fRNf9GVH21U6420m6UfDhsBnj4K+/7MuMK1o
 iuoJ+I/SewS+Zbj6IUNbvtW68P6N8/HdUImgh4DDjx+6zgbFGnao/qRp0r6Go6zf2dd9X9t6ioF
 tth5jvowgGkDLxFo70VXjIf2/xuNfTNTyezzK41pjGPZbpaaEbRev8yDt6yPfaN49mk6bCN9x5l
 uE6RctoQ5riPbPAhcKqrKSjyEQB6VcJXTdrR+0EcaO5L1QPAfjsN4xJ3y3jVv99d8Pud6bLQYwr
 mAEpDlfSP7ARGuGeaDw==
X-Proofpoint-GUID: 8zabqjimd4YSwpxYKKyKPWnHFfZpNwJu
X-Authority-Analysis: v=2.4 cv=Ypya1IYX c=1 sm=1 tr=0 ts=6abd222b cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=caZMlNoC1EqYFQpew0QA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA1OSBTYWx0ZWRfX7YM+6WbGewlj
 hmUdP+0luDr1zfPSPe45UFNvrOb2ROArDyGAf/icMTmGLEi+jzims+ch5OINvQIPObiXj7bSfmL
 bKtpD6mX9WVRCOg8IuS9VSXjx5Lj0GQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 adultscore=0 impostorscore=0 spamscore=0 bulkscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609300059

Add the device-tree node for the Qualcomm Page Compression Engine on
the Hawi platform.

Signed-off-by: Georgi Djakov <georgi.djakov@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/hawi.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/hawi.dtsi b/arch/arm64/boot/dts/qcom/hawi.dtsi
index 6b0a0ff0faa4..283a5acfa073 100644
--- a/arch/arm64/boot/dts/qcom/hawi.dtsi
+++ b/arch/arm64/boot/dts/qcom/hawi.dtsi
@@ -5677,6 +5677,23 @@ llclpi_noc: interconnect@31310000 {
 			qcom,bcm-voters = <&apps_bcm_voter>;
 		};
 
+		qpace: compression@31400000 {
+			compatible = "qcom,hawi-qpace";
+			reg = <0x0 0x31400000 0x0 0x80000>;
+			iommus = <&apps_smmu 0x1c20 0x13>,
+				 <&apps_smmu 0x1c24 0x13>,
+				 <&apps_smmu 0x1c28 0x13>,
+				 <&apps_smmu 0x1c2c 0x13>;
+			dma-coherent;
+			interconnects = <&gem_noc MASTER_QPACE QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
+			interconnect-names = "qpace-mem";
+			interrupts = <GIC_ESPI 72 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_ESPI 71 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "ring-and-bus-err",
+					  "urgent";
+		};
+
 		system-cache-controller@31800000 {
 			compatible = "qcom,hawi-llcc";
 			reg = <0x0 0x31800000 0x0 0x200000>,
