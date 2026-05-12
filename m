Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C38F4DB54E
	for <linux-trace-kernel@vger.kernel.org>; Tue, 12 May 2026 06:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778566411; cv=none; b=JUJ10f4js4mR3+FkKAgB2HoJWrZbDRKKUHoAjSYcrXCNVxOjNtVtcJOxA2szXioFOFEO6CgxKxyTemvFQLznQ0nUB85Vb0Xsy+AHF/OaytDX7i980SWxxX7Gcx8iI2hM+tIFygXardTQuGs0yKy11A4D0EO8DPw9vZYK/bsLmQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778566411; c=relaxed/simple;
	bh=4eHF3ynPQfpm7HcGL/RGQMnHGQvyXAHActKIK0UjYN8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LxTPsAXfWIm2L7lf1bC3Uf+j4W0M6z8PN4OHF25XDQ6yQAF53RLDskNWOHER/2ZDkE3D3l1TI8TqFhZX9IjLhC2Jl+sb3JPKP4mg5CHFPG1hlHabpT1foU5np6sUjD+89FkeQFfhNBZn3MPQr6CaqodXa7PnJu/XhWbdo+mDeCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=h8qYTRa7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DigdfEWl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="h8qYTRa7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DigdfEWl"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64C5BB7E3446216
	for <linux-trace-kernel@vger.kernel.org>; Tue, 12 May 2026 06:13:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=trz5LOcpB3IsEunOaMvecw
	HRhSnLAlbyBe156eD0qCY=; b=h8qYTRa75BIb8C2HP+prA8xM8Nb07Z1D1tULew
	iOie63IRAwbWXSUQ5OKQA2kEzOyLdI4Mj0yG3PFRsdlF6QkyrIGapkxxxqAbCxVV
	iDYIx2L78zpwiruhqkm3hBlZtu9hzWy4v1L8Jvlrnlns/3wHJ8TawcYjJO8i4CHk
	HvEU7Ej1qpZ9xA+GKJxIC38KYbe5rdn9TlvabDG9u0QH9RyOwTukOhcIIfFkOmnd
	79NaA0mXojfsnCtUDSOy0xbYIDDKAI+liBqRTQ5ZjAMAKm0akp0wKygaCZou+BbU
	oBPZzZzevyNat4By25WgI3dnl49OG/5F8iQfWyPOzyDOvixg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3nv0hrj0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-trace-kernel@vger.kernel.org>; Tue, 12 May 2026 06:13:18 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-36865d109dcso1860538a91.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 11 May 2026 23:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778566398; x=1779171198; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=trz5LOcpB3IsEunOaMvecwHRhSnLAlbyBe156eD0qCY=;
        b=DigdfEWlpENn6vZWY0Mkd79vc+nya4WGGitJJ58tORl950Ic1xzYdq2e158bbakck2
         jYIrtZ5uxRt20CzCQWe34S5iUnr6rI4ubzkO3qDtjV75AcQV81ryIPcg4UuFTsKzm3FM
         ENOqCS3xk6AYyQseh631MFxdYgZhsLsVkB0kyKS4zEuoCWHDzGiBSlJ6lmSDN30Kwveh
         bOH1SVbw4rkW6msnVX4qJ6Vh6FLlfTq1LMwGb52sDjpCP1GAm2l+Q+O07MvscfjtM67s
         SjhMJcoNPD810TrfrMhzbA9OUoEsOE5aFbs5w4xILV438ic0tFzLJDEm2tKFakmqOtmE
         wioA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778566398; x=1779171198;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=trz5LOcpB3IsEunOaMvecwHRhSnLAlbyBe156eD0qCY=;
        b=N7w8Uq00iWxP2yEDjnj0ETN+RcUsq78NJgGlbExfTd4w0YqrLCsWXm/sOAiwJR960E
         C8h7eozk0BcVYL2QWM3BGn1uEHUy+cgty6WrfRFkZexTQxRqPFp2s274z/7gyMMsyzsr
         Rnj0ubphMubtcGNpf7cHiJaIhOz/DwkqtprAJQtCn8W4qOSUEFUN4wxH0F3idGUg+0EG
         Z6MVDuQM4xa1Zdz2l66berkqiLZYNYE+0ZCKCfdC3td2g+TyEPHLOLGz+KMbx+eiYfMJ
         sbY2SZy0Kt+JTssOHOuPh605hjOBWNpS+5GLkG0CPzemutjwqrxqDbKpPWc1un8tQl+9
         8Dqg==
X-Forwarded-Encrypted: i=1; AFNElJ/xplsYOZmsLlm2oEYVJcUMIqpyQGQ2FoOl3HTmbLkPpAQt8ggf4qxIUCAk8e5c0tIW5SdaJFyDQfEly4J0QZ12jKY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5JA7ud1HMxDOxWQFu02UHgSjAjoKZr7QTR9sjw+qTe/xtXVds
	FtgKVOsx7w1wyGETclcORt8PuAtl+CM+YJckuVil2LmK2PRNTvc58QJWPbFc7nVHX/K39nlV8kk
	GFH/IPKtzY+/xHirGSUPu5qcGSFcp1VCUP0m4EQj1iVDjzdbgPYgjwQ2r9Ij6co1zeuYOVJ0I9u
	agkndE+P4=
X-Gm-Gg: Acq92OHoxxO1WMinSoUPZ8CW/93McHGtSf/no5dNHbpeAxuqV9SUubpvLg1xqp7rG8B
	hXBlUTgg6Z6RZi4u3BARe7U/tzYLlVk9J7OIpWMwCtgTbe0j4mqw3uN5nXq+pWgw9EckfqrsuEK
	DrUOwtifCRA+T7kLxVwzSp2fhO3brWDPxMDGVeysBpL6hPqX/USF63xrGiFyB+1GGqTAUbYtm8s
	cvHDaWaT4E+eIo1ZoOGrrcRBlRYlOc758V+/jyt2uaJEPW9uS+sOLQRhaX8+s5PrzmEAxpcNqvT
	nOrlCynEHwWZP0IsvaUn723dDe7GtxSV+h7HEsFiq+HeZZfecbVUxMNfRKMBItRzLFdAGTQk29e
	6uKiQHyJiya7OAgRa8YvoHiqrUqKjN/aJo8CtD0QB2jpeq7xWwPpkxMU=
X-Received: by 2002:a17:90b:520d:b0:368:6998:b49d with SMTP id 98e67ed59e1d1-3686998bc21mr7059392a91.10.1778566397602;
        Mon, 11 May 2026 23:13:17 -0700 (PDT)
X-Received: by 2002:a17:90b:520d:b0:368:6998:b49d with SMTP id 98e67ed59e1d1-3686998bc21mr7059343a91.10.1778566396968;
        Mon, 11 May 2026 23:13:16 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-368b00d2131sm842518a91.1.2026.05.11.23.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 23:13:16 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Subject: [PATCH v2 0/2] Add trace events for Qualcomm GENI SPI drivers
Date: Tue, 12 May 2026 11:42:51 +0530
Message-Id: <20260512-add-tracepoints-for-qcom-geni-spi-v2-0-3b184068ecf9@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOPEAmoC/5WNQQqDMBBFryKz7kiSVqVd9R7FRUhGHaiJZqy0i
 Hdv6g26+fA+n/82EEpMArdig0QrC8eQwZwKcIMNPSH7zGCUqVWlarTe45KsoylyWAS7mHB2ccS
 eAqNMjHTWl6pxxtSNg/wzJer4fTgebeaBZYnpcyhX/Wv/eV81KnTXLOio0cbrexQp55d95tlY5
 oB23/cv2sgjLdkAAAA=
X-Change-ID: 20260506-add-tracepoints-for-qcom-geni-spi-e31457c2267c
To: Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        mukesh.savaliya@oss.qualcomm.com, aniket.randive@oss.qualcomm.com,
        chandana.chiluveru@oss.qualcomm.com, jyothi.seerapu@oss.qualcomm.com,
        Praveen Talari <praveen.talari@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778566392; l=2423;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=4eHF3ynPQfpm7HcGL/RGQMnHGQvyXAHActKIK0UjYN8=;
 b=Z0cRG7eME1C0YRZ/9uUyk54mUdaX3e7DSlAFnjJzfNp8j4L61MFEhGPEjk4n1pls8v+oti6bl
 yk+G1l7eb5uDagzpqRO1tO43DJHqQtDKVRaDekW/sMh5Zg6CJ/zRhbI
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Authority-Analysis: v=2.4 cv=V+xNF+ni c=1 sm=1 tr=0 ts=6a02c4fe cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=vdy0y8WXZQco5u0MrGUA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: f-hNcPQZk33u-kH19R1mkrZB1ba2oB9Z
X-Proofpoint-ORIG-GUID: f-hNcPQZk33u-kH19R1mkrZB1ba2oB9Z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDA1OCBTYWx0ZWRfX2O4ZSaP6j35+
 c8DlsYAPbszCz2jRCcClq2cvNkJFNMInxXJXVLsunlAd/xSk9u6IFvcjpC332F4JDmVcc8+lvxd
 tDs6w7Qpmm3L24LRWvkDDio4AYSY7N62YqPFO/D5uOJETzSiOuz7bbr7MIL+XbcU1/I2TLyu0Tz
 xzcGZr9Cx/eK3yr8HUKkA7mjQ9PGRq0yvNcz5JtLztQY6bOiC97nyUTF29qwigNkgT82H2E72o+
 Xduhv3VPkZ1DDaDAx/xB1aQgqGcoWJhrYEz8EBQBBL9uv4F5cCHK/0MwR8cpLzSgLyP+0lFAcWw
 JxflC7j9aJtPL5ngcuK8yhBwu/aybeoYPdZlEbLBMuhN3tEBASgJIonoydoJQp6FDeXcU4FWw9x
 8BGiug8O/9Xb+6fpGjFVpkO+9PzSst80s+mzAMRA/dI/YeLNArZQPSJronstufbimCpiXJWGV4+
 JN4u9uhAefDguTXMFOg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605120058

Add tracepoints to the Qualcomm GENI (Generic Interface) SPI driver.
These trace events enable runtime debugging and performance analysis
of SPI operations.

The trace events capture SPI clock configuration, FIFO parameters,
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
1003.956646: geni_spi_fifo_params: 888000.spi: cs=0 mode=0x00000020
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

