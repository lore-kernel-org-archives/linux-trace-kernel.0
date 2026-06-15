Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A57C3F5BCF
	for <linux-trace-kernel@vger.kernel.org>; Mon, 15 Jun 2026 14:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781533029; cv=none; b=bTYRmu5JO0AIAt9+CJGoYdHjTBHINH0R0IpkxDAoH6HB96P1/yQkOTDP21EP3SjvW0mFy//rVNggBEuaFK+3CR86PJo7vsXtRdwMe3UaAhvupSe2ksiIRohaRAak0+nBDY3iFRTX8c6cmfMsv/oId7WZJGtFQDiSn7gQaZVTNv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781533029; c=relaxed/simple;
	bh=7ravXgTmMO+fNz84uqrTJ5yh8qkHxeBte3jycrujzy0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=X5oa7pDV0R1arcQN3AzNg/oKYRREo2fhWisvLY0m4ojTjmFPBoZFsYfjE7UjqVk7WOJtYwCySvVRBS4PZG3736sdHmwYpIdIcjLOvLRc1o487xqMEGPJkUEB2Kz+48oU5UHQtvn+hscRnUUpQ4DrWFgxtOeCA/KxXmCZnjpYEDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Pl92d3GC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eIfnzb7L; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Pl92d3GC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eIfnzb7L"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65FCZkv2009730
	for <linux-trace-kernel@vger.kernel.org>; Mon, 15 Jun 2026 14:17:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Vd27UIermRndpbWE6uam5b
	8AYLKUJl9f4BWkWI0HBa4=; b=Pl92d3GCYk8Is3db513cjR1Hzz794L3jhQDp9i
	X5qrXqbd80W01fSw/sPCmDJmtYxRZ+fJH1qQRy5ssGmHHb8zVBxnF4ZzvRC/NOaH
	HFefxHXBGg/DZM1ykv8J+g6fQ16uPsvBVgeVa/o+8AO/7EljE2xh18fRu0cpQ3r1
	pggbVQcc6YijrCtaA9JTuPX0+5Wf2fYYJ4vf9svD2EgbKC0a8Htu7R6kpC69T/NZ
	NYJg7b8WI77K6gJFLB35FAzYFpnvXaKPwPMTG0IOBtxG6XEW7Vjktwa1Wn28A+YY
	CvSlwRsJetrH3eBhgM6NDociV/nuARd9KDYwBYf5kb3nD0ow==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eteyd92vt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-trace-kernel@vger.kernel.org>; Mon, 15 Jun 2026 14:17:06 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-36d98b5a68fso6200154a91.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 15 Jun 2026 07:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781533026; x=1782137826; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Vd27UIermRndpbWE6uam5b8AYLKUJl9f4BWkWI0HBa4=;
        b=eIfnzb7LkprSFjFOfYZsA+xyRMr1gCrPOXg1PA4k9FKxg8Bwi63ykCEQl9c2D/ocZS
         NokVcPxhRaNoIfFgCIlp/jyplZnjl8eup3LSmCaGx86tTI3e6NilMxCTEXaq8vofMbi4
         eyyK8r0FkATK4N3sJo2X/7MldRc0dDP7op2xCBFG0n+o8ReIZI7R4UB0P4LoWJrpsRAP
         Jln9nFWhbzJaiRgnh6eBV7Im2w3g01kUENrwLVsrk6enu4/QmSfPxogwUl7I7WRg2Bs7
         lgvPI6k/mpVj30bive2dWx+jcOxAIuzl4/Wxzn3HD6FR6tfmeliJed7YD6MkjoDaHUZL
         5AMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781533026; x=1782137826;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vd27UIermRndpbWE6uam5b8AYLKUJl9f4BWkWI0HBa4=;
        b=KtUsIOh/w0KAofPfO6ZJGrsldIu5DeNMFUVl3dNQp91Z8X+IOD1c6R1o1Gb7FWY2IC
         Wa0ZBOPG77Hb24he9ydkiMKV6VWLezoM63I1cr1SPOefkrO5/fC8NWkAwofPp/Kvz43F
         iz3DCE30aicEHOo8CY9LlD/iItOac0CjGn4OUPyCc9qAEzlFpUZCx5xLDwdo+0F5Ta5W
         KXw1yjQYTCZpZN8ZpcmQ4OeKzxEmVJSchduSDw3KLLQ1t9MiIBZPjh4HQ9peCue+osCo
         ffi8np3szc6G6IkfvABYUGYxTv/lB/D/oi0DKJb8ls8F4ZbmwXeJ6E02RNPxPU+XohwD
         dY1A==
X-Forwarded-Encrypted: i=1; AFNElJ+1obeL3FvDMVkzQdXDQQvk87wv0KKRcVXGAxz8ZakIvQAUn2BDAzN+IgV4yxoeGxsZXIPcXDVcC/IOkuocUKLWRBk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvxjwuHNlEnj4fBPkZba8WfZkQPhQw13dWdOpaqvdJ9jVzHxa+
	iV1ozDuzraB/v0NlSqyRECQOy5n4KVV7HMvaEnfGn3GqqnaqE4pwHVSyr922FL+EvFkzS+nHPR6
	vlIkuF/hMnlkNN1PgEYcPDnWlctjHjuC4mXBxql69k2B9crq3fn8a6OMiQ9R49D+VvX3O5DkKLG
	Q=
X-Gm-Gg: Acq92OHCxTQ6iNBsuElgKby9fzhGVEbYbqOxp2oug2Mzp1aYk+LTTVHTqS59DEYfUEB
	FO1RluwNZ8kfsiAIDQwseosbjODUHF0Fdk0KFllURJgDfFsMP5mBTKteZzYfMLgLLvLhSB/9fgh
	odrjJCfuej9G/D4iA+rMazk8s9l4243pmWWt/SYp0FjgLCYrgUdFrCswHdlZkqO+NCOU0g07nHc
	BMmV1OEOc/Hp9Ro/35snMJYoANrywW22meMf3WzVXVVhiAyLzBU6TI4kn9rOeGUgF279dNgIfhX
	O9VBUVjoqm/kwfV4q0Ad8U3o77/8xshahX9wTPbKAUU5NHkEoGd+eQAJz6VPMs9ER36fe/J8PYr
	hYtSquYyJ+vG45bHpGBaSUUx7h0O5S0ysa86uOd0011Vty1+ZSRjuZzU=
X-Received: by 2002:a17:90b:380f:b0:36a:5d1f:7ac with SMTP id 98e67ed59e1d1-37c2bc6ed5amr11682488a91.3.1781533025721;
        Mon, 15 Jun 2026 07:17:05 -0700 (PDT)
X-Received: by 2002:a17:90b:380f:b0:36a:5d1f:7ac with SMTP id 98e67ed59e1d1-37c2bc6ed5amr11682419a91.3.1781533024975;
        Mon, 15 Jun 2026 07:17:04 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-379e8cc467csm7172476a91.2.2026.06.15.07.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 07:17:04 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Subject: [PATCH v5 0/2] Add tracepoints support for Qualcomm GENI Serial
 drivers
Date: Mon, 15 Jun 2026 19:46:51 +0530
Message-Id: <20260615-add-tracepoints-for-qcom-geni-serial-v5-0-2efa4c97e0e2@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFMJMGoC/42NQQ6CMBBFr0K6dkg7FoquvIdx0UKBJtBCi0RDu
 LsFNy5csJnkTX7eW0jQ3uhArslCvJ5NMM5GyE4JKVtpGw2mikyQYk45CpBVBZOXpR6csVOA2nk
 YS9dDo62BzSY7uPBCCIGsUEKRqBq8rs1rz9wfkVsTJuffe3Vm2/cbyGh+LDAzoJBxrhBzhpoWN
 xdCOj5lF5d9Gg/ZOjP+uBkedGN0y0xgzpGps6z/uNd1/QAqN33DOwEAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781533020; l=3953;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=7ravXgTmMO+fNz84uqrTJ5yh8qkHxeBte3jycrujzy0=;
 b=qUpAxjwRvgrjKaoC+UG+nOXyp6Agx4jXC1KvUxF4qgf5EYa6wq+WBDmeM+tBjSAgrPq7ZgND7
 NLAIzdLvCXJB9QeNqoRn2PoEpBIcjhk2Fslfe4j3zJ92Z+ausjrijYu
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-GUID: XH6LWYuYFIEgO-71FDmO8eQR-aLc5j79
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDE1MCBTYWx0ZWRfX7J6cNm+SGWxn
 ZPJp1Lppn0B7wRQp0bC9lIUOSO4dErq6iRR0ASFYMIroqLI3RGvAflYRSPk/28Ii2f58i5vMudt
 Y5XZGtLFfWKn5zwtOmEAe1MtvUM/OE4=
X-Authority-Analysis: v=2.4 cv=QrJuG1yd c=1 sm=1 tr=0 ts=6a300962 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=meVymXHHAAAA:8 a=7d_E57ReAAAA:8
 a=ag1SF4gXAAAA:8 a=kp9qP9swKWubhZvKkLUA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22 a=2JgSa4NbpEOStq-L5dxp:22 a=jhqOcbufqs7Y1TYCrUUU:22
 a=Yupwre4RP9_Eg_Bd0iYG:22
X-Proofpoint-ORIG-GUID: XH6LWYuYFIEgO-71FDmO8eQR-aLc5j79
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDE1MCBTYWx0ZWRfXyQoareHypD+P
 Xs2A/e/ZZNcSker9NAOK4slka5Ifx5TBsUPDxBU8MumrwC2XbZurKQ2QjU3PbZqtJR+68fcgMDN
 GDUO/HROgn9Q2gfFxCzgJr25enASDx+xns2xePo+7y8SyFa3WXnrZAF2vCgt+ZnziyiTE16JIWh
 beMN798cz3xr+ZbE0B1+ITRR+caK3BanB+sv/TkH0UUjICbLgh6zO89dxuhgImlN6x2gg+lVqa/
 gGy9+Sr+sNKJexHFty8mCJAxpVFkvVG8dnGt3mdsWdknPMEl3UILY9FkTC9bVS0ZxWm0Loh6YQQ
 fZIpeDV7Azv2thEtqAr0gtJa03eZ4LWZTEVNrixtgqV4j2/WHqp0w1ifRRhp7QOuZp23+WLtAI6
 ALrNTqbhRJKFE+YtFkF9xswrW3v/NO8VfwOCzthrMYrmMQQtSTJGK4pA0V9wCPzDL56KHxSiviy
 jf2Xox3gxpa8g1HDS5A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_03,2026-06-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 phishscore=0 spamscore=0 impostorscore=0 malwarescore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606150150

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
base-commit: c425609d6ac4012c8bbf01ec2e10e801b1923a7b
change-id: 20260427-add-tracepoints-for-qcom-geni-serial-948777218b7b

Best regards,
--  
Praveen Talari <praveen.talari@oss.qualcomm.com>

