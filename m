Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA48C450417
	for <linux-trace-kernel@vger.kernel.org>; Mon, 31 Aug 2026 16:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788194214; cv=none; b=W+2xWAqEbX9o/2LZOogwRc8f4X9xYIAKHRSdYniP9xQGvogrQSOiwJfXhvl7usD9ocQnJP58tMTp5wffDW6/MwG/Ss9k7LHmd69HyUBnhun4v8fKlBrbKDCPAV56moW3MyoDutuGi1OpNyh6tEbOrhqQVyAV+XE0dbpQM6IB3PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788194214; c=relaxed/simple;
	bh=xTpOhfVqaVWaoOJVZbGCxX2ZY6YXW6oOFEBei85ggi0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hCcm9gUqVt6qsNCfCBDb8hiC33QCTwe/BMapBsfAnJkFE13uxf/Un9CzoDMD1m8rZ5XF/MkWtOFlDN57HAim9SNm8PwfALIIcJj6e2zOqjygKcUKCaPPpkOmk6VTGlHlUrAGKjpZOJF9Lq3bxK/wVU3GfP/p5RNrsWCS1GBbDdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mDeB5fzm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CHd2B/vu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mDeB5fzm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CHd2B/vu"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VFpYOS037009
	for <linux-trace-kernel@vger.kernel.org>; Mon, 31 Aug 2026 16:36:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=rqfzRoa8lzdVEVcPPhGUKT
	zLirYY2hrbQz5zAHTrgZE=; b=mDeB5fzmXNU+c62b++t3Wdhu/8Z838ZL7VTpg1
	NfziV25EY3d1RXRCyO0jNknPMtkp4Ymean83WXcD3VP+Tv2GtAg3LJXZb8D8/sdQ
	XxZAFtfxx3K2VuM+ufNCpfKur3wa6s8IYPqsSYR7GxfKUa+A/aUx+u4IJYbI4yFU
	f6znz1Sw7CsMUYzt5DygpfPfpjhVSw0N01ULqctku3VejE8e0cmBXtbpRAz+uHtw
	zQWd6V3Voes2rYvXUQgiSRh2ygsHgn139k+mTnrcoQB49atDanV1EfBWaYHh8WtU
	35hsMrVUdCtWehG3Ufb3TLGocFJx244KV+0ORa9TXcRFm2KQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gd6jghy2s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-trace-kernel@vger.kernel.org>; Mon, 31 Aug 2026 16:36:51 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-396638f9a18so6334300a91.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 31 Aug 2026 09:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788194210; x=1788799010; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=rqfzRoa8lzdVEVcPPhGUKTzLirYY2hrbQz5zAHTrgZE=;
        b=CHd2B/vuUEzMMrwCkNL8zfnFfD/NpBhbCpqTP/w9S++YWQqmA8cROXcI/tjspTowd9
         bMOqSYe6Ji8Bf2EBJDwk6XY2I4UdGhz+ht3Wa1pmIAsCtf3XKOajBGapS339+NkeQLjg
         WzlmpBf8FlAXZLHmDsSrK3LDkoZTTpQMZs7hzaMUYfr2zx8SmRtuEtOmBfDGCA0vtHQR
         fjacNmJi56RnMenFxWODLJ7Y4GA/VcT2Xom/A23UQoszzz27crX5LJmWPcrnQX4axss8
         MU4LSUrGq/R2dYEmzLM4TDyc6yCe7BEkoscFsMdZVZKw+YETWN9Jx/5svH+4SR/66VCQ
         YKcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788194210; x=1788799010;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rqfzRoa8lzdVEVcPPhGUKTzLirYY2hrbQz5zAHTrgZE=;
        b=QGYf47NKjoE0qj+epArVGQu9R8REkJbNS0FbG5serHQkWh4gX4M09Gt1mLRCBrFSC+
         ufBLD43Zv7wyjB1qSt7gtVr1PPDh3Exnh9wPa7Th6jONCyItYASIg9s3ekoHwRF/C1VH
         QUyfY4+nYOLJOpAY2cBFYQFcqLlAZjvu2RVd1Ukir3+Au6o8UEfKCHqFgTirxwuuHlVS
         ux3t2agYj0iLq0JG1qS7UtgdSxfo8uokccljuqd0F2iFgv7PBAWcs0arVsPCieGDiyhF
         EHDlPSL4N3ixx8GniS/S/vPqXSTw8itgjaEsmeiITwy/No8Z6grsErgjdEz3URE0IRin
         54/g==
X-Forwarded-Encrypted: i=1; AKwUvBwjtDagJcozc1rYQJJU/vjH3/OkNdlB3OOCdqwE9is+CHUyPyhYIpHN6RoNxO1urXuxC2jGlAzSBovjol87gZ2HXI8=@vger.kernel.org
X-Gm-Message-State: AFuF++mBN1FDuMFhxKwZ5tozNgQnQzb/qpRc47FgnoYgDhIiA1mnXZT1
	iNfSDFOHbr3sl5eyejTImCFE2vZVu+rxqnbVn8bXnihI3KAmX6TATNQPCaPNVPg6lPS9LxGQgiw
	/5VI2ZRkhqLpdB5jl2U4X2Vipno+if3PMDaZG6LP60mBQ5RiOlHUrugaXK2fou8PlIZ+CZjIIzG
	Y=
X-Gm-Gg: AYBFou1+FLKp0ErKLrxtHo3PEhTu/+tlv51JxK53G9pd012PTuJuXdfhqX/PGt/6QC8
	qrkyqmMBbIsT4c+otpN0X8My9LjRai8CuN58MU4zwkhY9K0S0HcMXK84s3hdePNuw964nMpGQdD
	4awMLBfah+yCaLG58Zu+jL0xu0SV57BiCoP+igZS+TuP/p6uSKmW4Uf3qqrRVtqUxukJOeAMM/4
	Wf59r3x2HiuxX3QY1tAjC0GiHa4v9OqIGBPsX3MZiNiPER9FFRO6mQZTXhJjMh1mldsj/nBRBrv
	4KC5cCzvAPWUiOMDdJte1vDvIH/rPhVjTRAsanxnRyxp4M0b6Nb9AcdWtIpv3NcB/WHvL28bBP7
	qtKR4z/5plTLHxvF3hJqrPkrvo0nwk0vBYA==
X-Received: by 2002:a17:90b:224c:b0:398:9c00:29ec with SMTP id 98e67ed59e1d1-3989c003c31mr24472875a91.20.1788194210420;
        Mon, 31 Aug 2026 09:36:50 -0700 (PDT)
X-Received: by 2002:a17:90b:224c:b0:398:9c00:29ec with SMTP id 98e67ed59e1d1-3989c003c31mr24472805a91.20.1788194209805;
        Mon, 31 Aug 2026 09:36:49 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3990d75fc49sm271260a91.12.2026.08.31.09.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 09:36:49 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Subject: [PATCH 0/3] dmaengine: qcom: gpi: Add trace event support
Date: Mon, 31 Aug 2026 22:06:34 +0530
Message-Id: <20260831-add-trace-support-gpio-v1-0-7b0fd0d0ddb3@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJOtlWoC/yXMQQ6CMBBA0auQWTsJVBTrVYiL0o44LGgzUwgJ4
 e5UXb7F/zsoCZPCs9pBaGXlOBc0lwr8x80jIYdiMLW5149rgy4EzOI8oS4pRck4Jo5oLQ23NrS
 mMxZKnITevP3G/etvXYaJfP7e4DhO8hCwq3oAAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788194205; l=1247;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=xTpOhfVqaVWaoOJVZbGCxX2ZY6YXW6oOFEBei85ggi0=;
 b=95Frxty43ymUylU6j5YTJArM/YAiljzCRUdfAAIdm6roQZxJ33T2TqX/e48F2m6i62dODAzZU
 NKPKK3fBFs4BzlnXNky/J3IxpcExdaCEmQVqCPCzDWy795gULL/MMSB
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-GUID: GIyNfwErkYPYUq0O7YZMcSvVfEi3wevP
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDE0MyBTYWx0ZWRfX41mQG28bZ0lB
 N8ah2Z4qilDWEcvVrz4bSBfwzyOiIOz0fTsSWNgGdGazyk0wX/ALboybF1rj7e0vBbcaXy2ioGu
 zvTzDPoPz+5eigWGcODKIdywUUmjLFM=
X-Proofpoint-ORIG-GUID: GIyNfwErkYPYUq0O7YZMcSvVfEi3wevP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDE0MyBTYWx0ZWRfX2PvR+v7cdKGb
 VYpGhHKZ428/jgs41DCFmDyLymfmyuJW7wAf3rZ13WtrKHYOPYj0AV2PaILGxnGw/RZIe8hWz1z
 RVRA7h4DedriiMTmO7iF+rwejxoIorlTm+5xTBQUI96LBRs5REYuWpG86ZDvquYfo6cXFzmP5rG
 YFr08jNxJapcY0Uv0meSMqI7pMjMZLEasIBE0SfpD80YqFYjN8C72H7cLHfLje4RDEfjFfw1yvW
 k8sWNdAqtWyWSuY4U7QAQcK63GYPP/vwtV2SVygvUoUjxWZYe2g94/9AJ0Y0muF1iX/GDlBBRUd
 kTvpHHvAsG8j0/4Z3N5JUKpyp059thZ+C6p/gECArMk+NpzQaWRpZWM6qwzMREeDWK8yVQkyirU
 CflkT6H+rHvrSJapliL9SMdl9ieyiGx0MeurEzbzJ3CEQaMi09qz+XSV58jzMsgqIxXN+msAPt9
 nJL+5NFuJRK2VJ2e8bA==
X-Authority-Analysis: v=2.4 cv=YsY/gYYX c=1 sm=1 tr=0 ts=6a95ada3 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=bEzAOnUhC74fLp94dtcA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 suspectscore=0 phishscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310143

This series adds tracepoint support to the Qualcomm GPI DMA engine
driver, giving structured runtime visibility into GPI DMA behavior
without requiring invasive debug patches.

Patch 1 adds the qcom_gpi trace events header, covering command
dispatch, IRQ handling, channel/event control state transitions,
completion event processing, ring allocation, and TRE contents.

Patch 2 wires these tracepoints into the driver alongside the
existing dev_dbg() calls.

Patch 3 converts the remaining dev_dbg() call sites in the driver to
use the new tracepoints instead.

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
Praveen Talari (3):
      dmaengine: qcom: gpi: trace: Add trace events header for Qualcomm GPI DMA
      dmaengine: qcom: gpi: Add trace event support
      dmaengine: qcom: gpi: Convert dev_dbg() calls to tracepoints

 drivers/dma/qcom/gpi.c          |  69 ++++-----
 include/trace/events/qcom_gpi.h | 313 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 340 insertions(+), 42 deletions(-)
---
base-commit: e30626823a406725ce29bc75cb8ec467d3e1e326
change-id: 20260831-add-trace-support-gpio-99eb54d42729

Best regards,
--  
Praveen Talari <praveen.talari@oss.qualcomm.com>

