Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534FC43B486
	for <linux-trace-kernel@vger.kernel.org>; Fri, 10 Jul 2026 17:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783703552; cv=none; b=e2DfZ3ar6jM6JCguHb1DiDofSaJTtaJ2sElrWCYtFd86wpzvDE59G4ukK128iGZJjzN71dFJwiNkiJCDKAu4KHdZ9C3J0BtcFSwqNnmPybSF/ofN+qio53OwyuAmY9bxGfLHHl/ifCDR0CdhHNE1BF9AK83YWYHcBSmukcrz2gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783703552; c=relaxed/simple;
	bh=w/htGaYN4MRQBkBxw9Vyzouak6ZhBaXPMXN6dHtpIC8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=NoKDNPC0OFOzBfIjuH5d74hiAKLw37TvScZd3Kk74JcF/1xds58iBJNb8lnjgslCL+lQ26WpanJ+pg79MTvCVenK0rDvtSC7JdlXZtEytw6Sd0m9M5xpc80vegPqugWvagnFfS10aq7E3UmV1SsDvpsB9IQZJA9/eTqCGROWryg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UcPylpbm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GqRVxWNP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UcPylpbm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GqRVxWNP"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66AH4JlO1445375
	for <linux-trace-kernel@vger.kernel.org>; Fri, 10 Jul 2026 17:12:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=suX5GFzgtIvy+WnRpGcGhY
	1Adyg80YvOjSiOP0vhCIg=; b=UcPylpbmkwEjGg6VLB2secRcZuH651W3IBaogT
	RR8kWWYMrs40dUiEw/bDMToCyd6kIFiJJICCGjdo4rPN/qYtwqNiEMjIzZgGqPLb
	BiYnJbhD547EfXSNHsaixDbckFZj2MYNFQMSfWBHToMrP25kTXpMslZdWmwf/TKi
	3Zgj8Dewr9n9Nf6OePwXSdqtztN/dNDf7JTOz8vXHVSScGjwNo2o7A6AGR18Z9eg
	GZELNx522uiF3kBz/p/ZWomjcV1ckZGohn4qEpJTu4+p4T3Zn6zktVP2rGLKv9F9
	uB+7vZ/taBaQFxb1msEkJQtjq/2C4rXCbMQFIsLavHxT5l0w==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fanwebk49-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-trace-kernel@vger.kernel.org>; Fri, 10 Jul 2026 17:12:30 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c889d1eedcdso1780313a12.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 10 Jul 2026 10:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783703550; x=1784308350; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=suX5GFzgtIvy+WnRpGcGhY1Adyg80YvOjSiOP0vhCIg=;
        b=GqRVxWNPNQbHYYM/JYwT70yc3AZImzGlDKhyoWgwZDpQc0eDrjZ+6ZyQqjbkis7dQT
         +TtXeGkdefMRmmSseHbjiF8B4DUwSrB1gwpGp/Q2AdY4Wzine3+1/6z487nkB7p27yxB
         pu2m9TV99lXRBDGE92OhhQto7xsAm+X7LwuGBBELJm/+N+XNvJ6bAtKgm2rtDvqCqXi8
         HPuwoCl23nsY4aF6SPoWpS3U5Qu6fxkx8bSzEi7tfqZ0Z1snqnxQ/TmoEIcCEfkFHEti
         sGc23/WFmTx69uqvpQj47+eYFg3EUPuOAzNjEo+4AzOlfCoD2hGu34Z/nfMNPFv/bTVw
         JNFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783703550; x=1784308350;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=suX5GFzgtIvy+WnRpGcGhY1Adyg80YvOjSiOP0vhCIg=;
        b=npgcw01qzLA7WJzy3NsmHvOzSPfjsWqvtyAn7wg6yy87G+sEgA4Cc9fEgIS2vxutuR
         zaFMXaeNYRNwbhEJDBwyoU5M+qgPV42qV7GKt08DgBl2WdENs7FkUyy9yvtx3xvFvEmq
         1AGPFYbdDdgsaA1Rw6QuZxjprkeyO0y0J9X8i8WRVCoS2Ny5Xg+5eOGBe7v9xXIUGiVP
         G2tnzsoNu2h1NtyCd85MFaI863ROwN+xwZI6pWfhs75N/aIJn2HzHQaYLgjxhZ1gChFz
         jJjPcf33zLocNFr4brI8pblO2xctFOiLk+LMLBOI4z9JQshkdws0KEnoeVx4+wwD9oBk
         dCiw==
X-Forwarded-Encrypted: i=1; AHgh+RpC3wFmE1ePgP2ILB3SiutcFpA+YwkDUjEy6xyl7FahXNwe5PQ6plD0r5Ks0Y+A1tlcyXqUeZuPEcSMzFj4+iwh0pQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIwf9VpZ3Ak9PYytg/DDu/Svri+x3cUs44FUHCEw6kZeLD7E1f
	ndWkCequ+feku+/7i4BN44u/ABAfWk1YhgoRk7P3Ij+TPmW07Tt3mpArS0JAxxZbxt8IAMeJHPC
	MhDzqytyUTMmqcdW/ViCnLYyiIfPghVk+XSywKTqXFlRttxNiZC/vYEblhZfAL9t3QpnsEUQ1qU
	K/DuXA+gE=
X-Gm-Gg: AfdE7clVEEkcDYboEHbiDuBhf52Wg3T0adaXdnpx6nAiZitdUGXYCmBd6cZeZfEiCCv
	YT4gtdGPxj47fQ4QSrkp8LVcj6fzO6Y7qccTo2LreaOFyee2hozpL4zYxZrvbw/qR9GHDaKze1u
	M0/d4OBWCk9NH+4Bt1PkTNNSayYKqfoFCK/MsE0R2n3y8IYzOTZhRrETOTWMAGE5QSYTNesArU2
	thjr3t/KvpBElKYv1LNwzFNFGR78KWBXiG4UZkbl/2T6hhzDKCwaFZ4gZEcVqAArZZ3XyhVrgzO
	7N5YIcohDu1BDZn+RJKu2q1AUfGMXeEUyxfwIxQ1k39+FiVfmTbZxRCrqQ5sdD8qa+D64SASBjK
	UnK+msrmGb4ewYmuaGVbvekOWEbFide4DVxXb53c/P15V
X-Received: by 2002:a05:6a20:a107:b0:3bf:e291:496c with SMTP id adf61e73a8af0-3c0bc9161c4mr14798870637.17.1783703549946;
        Fri, 10 Jul 2026 10:12:29 -0700 (PDT)
X-Received: by 2002:a05:6a20:a107:b0:3bf:e291:496c with SMTP id adf61e73a8af0-3c0bc9161c4mr14798831637.17.1783703549397;
        Fri, 10 Jul 2026 10:12:29 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b659d7c8bsm46636277c88.12.2026.07.10.10.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 10:12:29 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Subject: [PATCH v6 0/2] Add tracepoints support for Qualcomm GENI Serial
 drivers
Date: Fri, 10 Jul 2026 22:42:11 +0530
Message-Id: <20260710-add-tracepoints-for-qcom-geni-serial-v6-0-2bb6b6836dfd@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOsnUWoC/42NQQ6CMBBFr0K6dkg7lhZdeQ/jokCBJkChxUZDu
 LsFNy5csJnkTX7eW4jXzmhPrslCnA7GGztEEKeElK0aGg2mikyQoqAcJaiqgtmpUo/WDLOH2jq
 YSttDowcDm011cOG5lBJZXsiCRNXodG1ee+b+iNwaP1v33quBbd9vIKPiWCAwoJBxXiAKhprmN
 +t9Oj1VF5d9Gg/ZOgF/3AwPujG6VSZRcGTFWdV/3Ou6fgC7Ew7EOwEAAA==
X-Change-ID: 20260427-add-tracepoints-for-qcom-geni-serial-948777218b7b
To: Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, konrad.dybcio@oss.qualcomm.com
Cc: Praveen Talari <praveen.talari@oss.qualcomm.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        mukesh.savaliya@oss.qualcomm.com, aniket.randive@oss.qualcomm.com,
        chandana.chiluveru@oss.qualcomm.com
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783703544; l=4142;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=w/htGaYN4MRQBkBxw9Vyzouak6ZhBaXPMXN6dHtpIC8=;
 b=K1GsQgIBTSZVK/rXxQ5gOYoYKuMaGiWWRUKkWfnth6N0YGb2DtUiR9fcobzRF1XnNYcFR24qt
 WgtmEaz8BfoB8DOkRJ+bE0dH6Msbrgh1SErGtsJanbbvcV2sZaBu4Zx
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Authority-Analysis: v=2.4 cv=LbIMLDfi c=1 sm=1 tr=0 ts=6a5127fe cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=meVymXHHAAAA:8 a=7d_E57ReAAAA:8
 a=ag1SF4gXAAAA:8 a=1hfpssHSpbbJHZzjzoIA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22 a=2JgSa4NbpEOStq-L5dxp:22 a=jhqOcbufqs7Y1TYCrUUU:22
 a=Yupwre4RP9_Eg_Bd0iYG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDE3MSBTYWx0ZWRfX7s7S3BLLNdem
 Q78Ys7B+3cUncKpF5G3ZUTAr9utBCXev8ArDZQnGDt7Eg4ARmZYuDiUM3UyKY8HTERCYBlZT7KQ
 JqyrmEZfs54UQdpN7+fOKssvzVBWPwrHzdJe6s6OJrImzlucGKqdgYBacPUmDVL4gYaSk0ooJbx
 BkkgnxK6wfZu2kllCuST6ob1LVU9mCd9vYA3IGCMgl6eZAp2dx8ifhk0TMSC6GA/n4z/2sOPuyy
 e6RiJuJ5iz2D0BST1Hy/WoIHwRZSu5yh3oeLcGrng9bp6IR8VI5FoTFbJDXHHie1jXlD5VPWp+N
 sAP6LWmU/vuSkNYZbUBxfj00w/bEu2C30F+E2Tffm2R12UP399hnZFIkNZ/usM4VBMO8xB93nIE
 HfShXBKPXOoqSIAVXEizSU3NEgRClPQucBNie7+JJwQAznJlZWGcO47kATmQ9Qx7UhVEsBj5Dfw
 jtby7Zpghu2up2nfmXw==
X-Proofpoint-ORIG-GUID: BkQkqq3lICQuI0gWr-o9EMiBpDenqB2w
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDE3MSBTYWx0ZWRfX+vnVVQ3vbsdv
 cwwL2dpWWrefHxmrLpLSFHmEnWOUe0x9YMcSDTx2R+3Lyov/FYEYxGHX0p1zXkZw3w2IB+q5JZU
 CV8LeR/BA6MdTqKHhW/Excib4xFrRhw=
X-Proofpoint-GUID: BkQkqq3lICQuI0gWr-o9EMiBpDenqB2w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_05,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100171

Add tracepoints to the Qualcomm GENI (Generic Interface) serial driver.
These trace events enable runtime debugging and performance analysis of
UART operations.

The trace events cover UART termios configuration, clock setup, manual
control state, interrupt status, and actual transmitted/received data in
hexadecimal format.

Usage examples:

Enable all serial traces:
  echo 1 > /sys/kernel/debug/tracing/events/qcom_geni_serial/enable
  cat /sys/kernel/debug/tracing/trace_pipe

Example trace output:

2517.938432: geni_serial_clk_cfg: a94000.serial: desired_rate=1843200
     clk_rate=7372800 clk_div=4 clk_idx=0
2517.938753: geni_serial_irq: a94000.serial: m_irq=0x88800000
     s_irq=0x08000111 dma_tx=0x00000000 dma_rx=0x00000000
2517.938803: geni_serial_set_termios: a94000.serial: baud=115200 bpc=8
     tx_trans=0x00000002 tx_par=0x00000000 rx_trans=0x00000000
rx_par=0x00000000 stop=0
2517.938807: geni_serial_set_mctrl: a94000.serial: mctrl=0x8006
     uart_manual_rfr=0x00000000
2517.938818: geni_serial_get_mctrl: a94000.serial: mctrl=0x0160
     geni_ios=0x00000001
2517.939165: geni_serial_irq: a94000.serial: m_irq=0x00400000
     s_irq=0x00000000 dma_tx=0x00000000 dma_rx=0x00000000
2517.939592: geni_serial_tx_data: a94000.serial: tx_len=8 data=61 62 63
     64 65 66 67 68
2517.940610: geni_serial_irq: a94000.serial: m_irq=0x00000001
     s_irq=0x00000000 dma_tx=0x00000003 dma_rx=0x00000000
2517.942174: geni_serial_irq: a94000.serial: m_irq=0x08000000
     s_irq=0x08000100 dma_tx=0x00000000 dma_rx=0x00000003
2517.942323: geni_serial_rx_data: a94000.serial: rx_len=8 data=61 62 63
     64 65 66 67 68
2517.942680: geni_serial_set_mctrl: a94000.serial: mctrl=0x8000
     uart_manual_rfr=0x80000002

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
Changes in v6:
- Rebased patch(02/02) on latest linux-next.
- Link to v5: https://lore.kernel.org/all/20260615-add-tracepoints-for-qcom-geni-serial-v5-0-2efa4c97e0e2@oss.qualcomm.com/

Changes in v5:
- Remove serial trace header patch since it was accepted and merged.
- Added a new patch to fix for remove unwanted variable len.
- Link to v4: https://lore.kernel.org/all/20260526-add-tracepoints-for-qcom-geni-serial-v4-0-e94fbaec0232@oss.qualcomm.com

Changes in v4:
- Rebased patch(02/02) on latest linux-next.
- Link to v3: https://lore.kernel.org/all/20260518-add-tracepoints-for-qcom-geni-serial-v3-0-b4addb151376@oss.qualcomm.com

Changes in v3:
- Removed \n from geni_serial_tx_data and geni_serial_rx_data events.
- Resolved aligment issues in geni_serial_data, geni_serial_tx_data and
  geni_serial_rx_data events.
- Link to v2: https://lore.kernel.org/r/20260512-add-tracepoints-for-qcom-geni-serial-v2-0-a5726421b3af@oss.qualcomm.com

Changes in v2:
- removed multiple trace events for TX/RX events, instead used
  DECLARE_EVENT_CLASS and DEFINE_EVENT.
- Link to v1: https://lore.kernel.org/r/20260506-add-tracepoints-for-qcom-geni-serial-v1-0-544b22612e08@oss.qualcomm.com

To: Steven Rostedt <rostedt@goodmis.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jiri Slaby <jirislaby@kernel.org>
To: konrad.dybcio@oss.qualcomm.com
Cc: linux-kernel@vger.kernel.org
Cc: linux-trace-kernel@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-serial@vger.kernel.org
Cc: mukesh.savaliya@oss.qualcomm.com
Cc: aniket.randive@oss.qualcomm.com
Cc: chandana.chiluveru@oss.qualcomm.com

---
Praveen Talari (2):
      serial: qcom-geni: trace: Drop redundant len field from geni_serial_data
      serial: qcom-geni: Add tracepoints for Qualcomm GENI serial driver

 drivers/tty/serial/qcom_geni_serial.c   | 27 +++++++++++++++++++++++----
 include/trace/events/qcom_geni_serial.h |  7 +++----
 2 files changed, 26 insertions(+), 8 deletions(-)
---
base-commit: bee763d5f341b99cf472afeb508d4988f62a6ca1
change-id: 20260427-add-tracepoints-for-qcom-geni-serial-948777218b7b

Best regards,
--  
Praveen Talari <praveen.talari@oss.qualcomm.com>

