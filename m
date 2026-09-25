Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25B74F55A6
	for <linux-trace-kernel@vger.kernel.org>; Fri, 25 Sep 2026 20:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790369507; cv=none; b=K5pzfw+vpldsq2zEejHTB9ksASmpCN334RsY0AfM13MoqIAQGeLoit6ENuo4t/xR9lU15o/vlSqBGSFNqbfilsthr6Cl+cUsKZXSjF/zMLFJtFq5etdV4eNNObztKP4h+IQva+qQbK8X5M1Sa3ZAMHJSjzO3N/viG4A4tgbSB2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790369507; c=relaxed/simple;
	bh=ts9DOEaWf1lBa+eQI547Ro/oe0Z02nVSejCO7cX47qg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WSeP0D3e0/cZbAFd/58TLD+LEYGP/ee9ZGG1wU2uJyslC7nCqQSx5FQFQ/p8LSldNdGQdKG6nSWrEY0Ninr5ZqAMga9OolKNyzIenhjbSmNker0xpiseoNvdQ6w30DtbyaYFGa2+aRg2UhqtkK5olb2e4n5XDnPYqE596a8yuYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RdcZgjxJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Wx/g4gqY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RdcZgjxJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Wx/g4gqY"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68PInpoL3014846
	for <linux-trace-kernel@vger.kernel.org>; Fri, 25 Sep 2026 20:51:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=pEVAjbFWnMm/lUi5VG3+Ez
	bqFp3o1qRYwGZDsG3MLYo=; b=RdcZgjxJ9JSf1+Ey1elKEXGW4DC+8xleOCd6+m
	s8H56mFZhPaZl+QzJOVKD6Nj/nPnm7kavhuPvKe6Rd09gpl4qKO6/8pliN0YG2aq
	NUyduOpIjVz6UKBgMTGlmZwN6Pmc9qGInQTZVB+aCxLuVkWPL+etQyQlPFkh20hQ
	DPv+Iah+7YB3P33O1aGgn9AXiIzHQN7OwamTkQDhkdbqHjqVDEphDjWKGoUkFBeL
	2Yjj5/nznXIAn6isgx87DsH0MJLjY/mo8C8iy3AfZDjEykMkfT4EBqmRT52NWyoh
	abpd7cTknCLnyn4Mxxu/2Y2JgoQgo9XZqeGJIYzR4LEOmgyg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gwufk18b2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-trace-kernel@vger.kernel.org>; Fri, 25 Sep 2026 20:51:44 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-313d1015161so4461487eec.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 25 Sep 2026 13:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790369504; x=1790974304; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=pEVAjbFWnMm/lUi5VG3+EzbqFp3o1qRYwGZDsG3MLYo=;
        b=Wx/g4gqYRPigiEJJxUOtcJxoBTJH/b1upSFJyyDO82kQmBP0734R8jtt83mLt+I/sf
         MiTlr122rTPOPk1o8455OfLD2oAG0HfQS82snpgj/kZ3DO4Xd6EaCmud92Dv5+egH4DU
         FOI2k165Bj9HHht75wJvOIBgqzi7up+j6cDU/Cj4UPQ1VV5qVpIdwAgzLf9A2u9J//J5
         CQc1kHvr5cupZIrJsf5QkuMGYmINxkD+gTpM4Ii5XV3ZWJ1k3oY2xpSV1Uvz4tN1wZ+P
         XooruyLykW+kPFPQcyevQ/vdQ6akPSLd5V3h8SR34n8emm/NtmEsjjaqZw4eBnyiCT3Y
         E+oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790369504; x=1790974304;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pEVAjbFWnMm/lUi5VG3+EzbqFp3o1qRYwGZDsG3MLYo=;
        b=LIkaDlVTaUYFGvSdfJZTNtJprZBxh3YzprdOh2HDXLvMkPGyhizmkBrjiq4lrA2Jb2
         ikkvuUHHOdFnD7QUBCQxzW0LvG53qSep3WiEShFh2MA1AJqDdZ9VPpOUbnUBlqJsMcL8
         c31xgYmFcNw1kzeDER75Uj1Vk6i4UFIdN0sxchIwVlQC/At+Z2zTt58nuODJlu8CwKEX
         NK+fOgFZlQ3x5WzBG44y8s0byJJYqLJH9MRB86RrZgkQXEQSotCd2XNsSYvxvYWXACGg
         aWZfcEmEDEwSS5uyOL6iNOHX6s7gl8zZvHuLUViGzQGzzQTJ/ZVBN+GOeMFdEIqjzv+I
         LUIg==
X-Forwarded-Encrypted: i=1; AKwUvBzFyVFYmfEaTpU8Oj3RjIrV4BwtIN2oFBVUQFB/Wjgwjr0vuFEY4yV/W46ks7hxb0exU/bTIbbxAHv7D4Mr5NbogXI=@vger.kernel.org
X-Gm-Message-State: AFuF++nbXCc/HLYdmgbzov5ZKyEaYRiO7JqhGhpdOttz6hc90i2Fk50N
	bFim3Sq/AcqxPLi8RpXOWtmagWTBywYRNIqkdBcjbZIgQbcVNA37t72Gd0yb/ivHJGH+gOoYRst
	9lTAW/iI0/eCKgL7wvuAnhVhyB6TXq94uYLpsC6A0+SK5AuWgddXgolXxGyernRkYQtsV+XbcS6
	4=
X-Gm-Gg: AYBFou1TVB6Hki/j1wxh8pHvG260MwVleGWiES24K7Gy+tFnW2bbmwJyk2W1Hzn2S9t
	1z8n9gn5FCNipMIbBB3bGai36i0eGXISKiETNAsFt/TZEXn/oozDiGesglyrJ7a1qIRx5CYRdQQ
	jsuugiqfyYfyPQPQii7fvN7vVh7yQYHKJfMhrR9yGJBvGo/e6KK9nSU00jo3E1bN3XYPsRY+bUo
	5O+GFk2lGn5AkBWvYSLWULjAVXH1+uxLPxi+qPHC4N/ADolU8r9L67nLulADtN1WbAHxmCAAGSs
	QrG/UfH/Udaf2A1FCmEO+Pt4Q7jDWssxza0Qz2V8cgdt3dzjcRgCBE1Ofw78baXdBguixijms2j
	DiZU7fLw84KDAqq8CeBiTRbtwYrxAvMtX
X-Received: by 2002:a05:7300:d204:b0:33b:f8f9:c8e8 with SMTP id 5a478bee46e88-3426feb9da1mr1237307eec.1.1790369503948;
        Fri, 25 Sep 2026 13:51:43 -0700 (PDT)
X-Received: by 2002:a05:7300:d204:b0:33b:f8f9:c8e8 with SMTP id 5a478bee46e88-3426feb9da1mr1237274eec.1.1790369503231;
        Fri, 25 Sep 2026 13:51:43 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34144757f31sm13085734eec.14.2026.09.25.13.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 13:51:42 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Subject: [PATCH v3 0/2] dmaengine: qcom: gpi: Add trace event support
Date: Sat, 26 Sep 2026 02:21:34 +0530
Message-Id: <20260926-add-trace-support-gpio-v3-0-8572bf7456b2@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANbetmoC/4WNyw6CMBBFf4V0bUkfKNSV/2FctLRAjdDagUZD+
 HcLLtxozCST3OTec2YEJlgD6JjNKJhowbohBb7LUN3JoTXY6pQRI+xAKk6x1BqPQdYGw+S9CyN
 uvXVYCKP2hS5YyQRKYx9MYx8b+Hx5Z5jU1dTjSlsbnYXRhedmjnTt/ZVEigkuFWk0SacVPzmA/
 D7JW+36Pk8Pra7IPjRBxE8aSzRCm4qWXChVVV9oy7K8AE/PSo4jAQAA
X-Change-ID: 20260831-add-trace-support-gpio-99eb54d42729
To: konrad.dybcio@oss.qualcomm.com, Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>
Cc: chandana.chiluveru@oss.qualcomm.com, mukesh.savaliya@oss.qualcomm.com,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        Praveen Talari <praveen.talari@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790369498; l=1972;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=ts9DOEaWf1lBa+eQI547Ro/oe0Z02nVSejCO7cX47qg=;
 b=emdfuG2GAP2OB7/X4F59dGDE24GgzSnqsrAyM30SzdpZprd0kVmSz1qSgnQNvJIR72EjhD8NX
 MCyVhecKWc0Ai6HGkTJkvh/OA+ZZzWvsRBcN+hjzDBpp6azgPzxTFUr
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-GUID: -czXFvpzakmiTvSzZeDorDHPhTik8ATa
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA4MyBTYWx0ZWRfX1RI/L+2pVwoY
 APs0Gm4+VeyEord0W1QjvtF4NpKoB1EPWhjZa3L6S8hRvKJ8KRaj+XNcPEvom5HzDvCb8ojiNTr
 qBkoh57IzKiXuI672YaBhYXse8Mus2Q=
X-Proofpoint-ORIG-GUID: -czXFvpzakmiTvSzZeDorDHPhTik8ATa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA4MyBTYWx0ZWRfX8EVA1wPdYXSo
 dWUdVJlW/pTjABQlEJfK14WpQVOnV8NZE0Bt0BpuAkCeMJN+QNncU/6skH/eJUGGWpPbAY0YHyg
 Zg17qU+ULXlFC8vrBMYs3I82kqtUqMB6chc50N/ti0Le27QcrmHVzXBiFR1+xHP+NRwgQB3Hcg2
 N1Zr54btTBUTpNZlOdBjUO8eJxeTR6dqnRF+1MJ1nJgwRfunRs1GOu9apyQ1taiDLFfCUDdUFC7
 tqxCk3P6A9548xDS80kFWO7wvwkMcrHL0/brKeii32661ph7d4B958RRRunA7zzx1xOAld5pHFA
 Nf6x9ZLEpmfb1bRqJa0fRWzrzteG/X7LXAB3Hv7cLV3++whP7Z5+HGIgjuTPr8g/vWU/dIMc+vr
 K/zfYyA1PulrYrBIELu9mvu32rEiQRNxgn0Fv7urPAwcMDKh+nOyEKpmNqdBXL1drinbuAU4lNi
 nBE81zjFTtesaiceofg==
X-Authority-Analysis: v=2.4 cv=B+wsQ+tM c=1 sm=1 tr=0 ts=6ab6dee0 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=n0A2qb7kpkoggacqyAEA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 bulkscore=0 spamscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609250083

This series adds tracepoint support to the Qualcomm GPI DMA engine
driver, giving structured runtime visibility into GPI DMA behavior
without requiring invasive debug patches.

Patch 1 adds the qcom_gpi trace events header (private to the driver,
in drivers/dma/qcom/gpi_trace.h) and wires the tracepoints into the
driver alongside the existing dev_dbg() calls.

Patch 2 converts the remaining dev_dbg() call sites in the driver to
use the new tracepoints instead.

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
Changes in v3:
- Move the qcom_gpi trace events header from
  include/trace/events/qcom_gpi.h into drivers/dma/qcom/gpi_trace.h,
  since it has no users outside the GPI DMA driver, and squash it
  into the tracepoint-wiring patch.
- Drop the redundant per-function breakdown paragraph from the
  dev_dbg()-to-tracepoint conversion patch; the first paragraph
  already describes the change.
- Link to v2: https://patch.msgid.link/20260909-add-trace-support-gpio-v2-0-01f81739bb88@oss.qualcomm.com

Changes in v2:
- Reorder TP_STRUCT__entry() fields in gpi_ev_process, gpi_alloc_ring,
  and gpi_ring_info to avoid holes: 8/16-bit fields moved to the end,
  and 64-bit/size_t fields moved before the __string() field (treating
  __string() as 4 bytes of metadata). (Steven Rostedt)
- Link to v1: https://patch.msgid.link/20260831-add-trace-support-gpio-v1-0-7b0fd0d0ddb3@oss.qualcomm.com

---
Praveen Talari (2):
      dmaengine: qcom: gpi: Add trace event support
      dmaengine: qcom: gpi: Convert dev_dbg() calls to tracepoints

 drivers/dma/qcom/gpi.c       |  69 ++++------
 drivers/dma/qcom/gpi_trace.h | 317 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 344 insertions(+), 42 deletions(-)
---
base-commit: 4c253ac4b29b8c6cc6fdef8f92d4facde62e63b9
change-id: 20260831-add-trace-support-gpio-99eb54d42729

Best regards,
--  
Praveen Talari <praveen.talari@oss.qualcomm.com>

