Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07474DE725
	for <linux-trace-kernel@vger.kernel.org>; Wed, 30 Sep 2026 14:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790779947; cv=none; b=tDlXyBKPXJspUvY6dllCqAJK2oY1b2d/biZtqf6IPP5sQqjcPchqnPj1p/VjAO9MTWp2xY//VgX2zMQTkSn3oiReQcEndYI9pMGfh0ngykVv+KKS/hna4dPtH23nd3P7VCZDrNM8vnTksgEw4BnMCdFTo5oN9P0lPbPwUa81A90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790779947; c=relaxed/simple;
	bh=9cXLQQHKl6yEKaTCBAgfXYVQ5NuyFBWmetQmFW80k6Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lkN9XOQOiEkqa3ithRqU5rITWUfn1bJHZR2yyFIOoI4QDHfhfBQYcBZCW98x5fr0bIr0dr1JhspeExH/v6Ih3e8pIKd9s8DXDb4/ZOLy1k8OFAKu1+o7TkbaZzw6fNGhacbEOJC+D/b249rN6ucyr2ayHdKOZt9lHG8C1jNO5CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=g4vmgpR+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PlV9kU1i; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="g4vmgpR+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PlV9kU1i"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68UE02FZ3520179
	for <linux-trace-kernel@vger.kernel.org>; Wed, 30 Sep 2026 14:52:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=Xm8ZEn8ghmOcAG3oNkRt/e9q/WbJ/MPAnge
	ljbhU5zk=; b=g4vmgpR+Wv07QF4yjUx3TTAZx5u3STyLEcb+kOa7MSOFCac/7mS
	PBph/bxk3J8/oY00Is2fhhNR7Zk2JKpHWvQ3uE85tVrNvM8CfFKkT89kOhdf/xKv
	ORFvzE4LkDRydyo/LoN4hI44GNmZcriByZHEEI3LsfqRb+JPhn7ol8we51zLukeV
	w2q7Xt6P7OUlNufe2GoXgbNEiOINH78xsHsavpU1r2w9Ks8tmH9tACzJxm5w7GpD
	1RIA+aS/kQq7ExbmuroVz/tZ9CiD/h8Q04nHETLEOm4sa/o9V1IN22pOb6lTH5OK
	a/2RtiCDrlSYOhj3/meKR1niJOq3NgPwG4Q==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0x27hy1d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-trace-kernel@vger.kernel.org>; Wed, 30 Sep 2026 14:52:20 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-341eff9e381so6677174eec.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 30 Sep 2026 07:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790779940; x=1791384740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Xm8ZEn8ghmOcAG3oNkRt/e9q/WbJ/MPAngeljbhU5zk=;
        b=PlV9kU1iaBRQesYC3WrtcmAV+VXaPFJJaIwVSv+uKHVIm0AWhTSAwaXMw+szEb97le
         2V6ayCRnR83Z855T4PHPiw7WfhfAwnvr0FV4O2xlw1E4qqA69B16XRVzReIpicnVHMho
         vVcKCa3EH1sPMioNGkyWg+VIngy+tttk+Aow6zNshpRE3pumtlLXpI9f0XqSuEv45Y/E
         pt87MOpcFc6UpDvQHKoPBfTD/hOvv/n9t69gRNXA+J2Laq1a+sbefeMbXf9z/4BkPRV3
         E27ZUaZJ6bZUCDeJ1oC3SNMjQZ62Ta/M07O8TZy/fYmZyt7IJXv49VWtbxSqJ4y+BDdA
         T+Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790779940; x=1791384740;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Xm8ZEn8ghmOcAG3oNkRt/e9q/WbJ/MPAngeljbhU5zk=;
        b=kUYKJXon+QG7Snu0ikyBZI0xKjE2VUJQ7NCw/xRIgxOz5iBOX8/aJYwIwmiDC7KIRR
         8njPfZzQWxBwxoYqBZeGB2bijYFwwlLuvjvB/gL4YJd7b+8R6HfLIT4N7QY7mCem9Nll
         zgzYx7wdcxSMyaxaQNK7c2ZDDKjvgP9xFPl4J3tKG67H/a3Yom3FuvSSZIoOPlazgmig
         XpCjZUugFyoWA9K9Hyau6gYIofQehZGkPo1dz0PA0BUUCAGyPQzDPpStR4BGKHVIecJ/
         y131/tsmQ7QuiUFDpLQJROZVnCEfSuKAGVlbpD4J2DqxpfUApzFVBaG1UYljFD8FjY/e
         EvsA==
X-Forwarded-Encrypted: i=1; AKwUvBza6d5qL+wQGXoxtG5o1caLMc1lA9zm2fafryiaCE7hAixIs9c+sqEchaRSrOOjEuoWZOu8nSdisRgB/CS9b+kwpOY=@vger.kernel.org
X-Gm-Message-State: AFq9FYK5eG55e/gQrNzgmqvTlk//vjc75PlmmibpDvpAZYnE4db06h4v
	cofPBkDP5PoLg3gvDpgUUSz3h5wV6Sr3csr9Da7eUzKScTYgHnUdPQeYzS4yWUHC/SULLraTuSZ
	v5S3wAhO6W5RXxtcT0/G/adK0oz88/B/NQwIh4zgmzF4m3d9L2Z8FySNzTLkHdozbWsEEwtwVQH
	4=
X-Gm-Gg: AYBFou2FXLTg9qGnScv1ZZPkHjag2MTqXZ4egurgJz7biLKnI7eUwuGjra4SQZijOaI
	7Pu/fWa0vb4dD7weIytS3GU+IazCeSU/ogzv+YCnaMUqkePqIuBJ//RKiDEPlxoZOSzvdyJVpTt
	9OXdIlHKJ0bsqItj5GPS/p5bcjmNdEytnwvEdkmh4PL/j0cxRCNCHMneo4uC4o9sjQuoBknDJv/
	B1tYjl2KmHZjbU6mN3N9Rg6ftrSAYES9OKUUjfdrUEoHvw721ew3T/I6zHbIPkYHpjWr0J/O9nf
	eYOVUfPbGvJ4QT5MnwRMSmchELbeo1UKizyyGng7iyhDO8B2TZpQx4VsK36c0EXi+G0YiEc7THm
	1Vm+CPcd74+ueZmPlpuO6oaWB2phhy3K/oL/GEMixaK/WIdYM7YU5ZQI=
X-Received: by 2002:a05:7301:fc84:b0:34b:a328:c28 with SMTP id 5a478bee46e88-34cd9177b73mr1684534eec.5.1790779939761;
        Wed, 30 Sep 2026 07:52:19 -0700 (PDT)
X-Received: by 2002:a05:7301:fc84:b0:34b:a328:c28 with SMTP id 5a478bee46e88-34cd9177b73mr1684502eec.5.1790779939129;
        Wed, 30 Sep 2026 07:52:19 -0700 (PDT)
Received: from hu-c-gdjako-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34cf5639339sm4524609eec.18.2026.09.30.07.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 07:52:18 -0700 (PDT)
From: Georgi Djakov <georgi.djakov@oss.qualcomm.com>
To: andersson@kernel.org, konradybcio@kernel.org, abelvesa@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        minchan@kernel.org, senozhatsky@chromium.org
Cc: axboe@kernel.dk, rostedt@goodmis.org, mhiramat@kernel.org,
        mathieu.desnoyers@efficios.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        djakov@kernel.org
Subject: [PATCH 0/6] soc: qcom: Add Qualcomm Page Compression Engine (QPaCE) driver
Date: Wed, 30 Sep 2026 07:52:09 -0700
Message-Id: <20260930145215.3380977-1-georgi.djakov@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA1OSBTYWx0ZWRfX/ZUB5Cdu+7ms
 9WWhUjKpmcUkm1YaQ/S55vqtwncvGc1k2nXhTsW6RXj6ce01KM4ABE2L5mJ4VGVZSVodzjfvNeq
 84KCBJXrD3I+APjKu/K6Hkiz5U6FFD4=
X-Proofpoint-GUID: C_vhAwuL4U_yLyURyloMJOMbVPj35Dpa
X-Authority-Analysis: v=2.4 cv=W9GtxhWk c=1 sm=1 tr=0 ts=6abd2224 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=oM0TwoE6PClt58MffhQA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA1OSBTYWx0ZWRfX6ubgO8J/efVq
 0Jspg4AQn0mPd2IJjQQPHOQMbNhdD+ArH4uoh5Yv54fhSmxGM/J1mGNzs12H22qDC7+N7mwsHFM
 Iy10MsaRKiHxdlUmKdixuB0WBMFicYsfY5jV6hgaQ0iBU7mPgK0+P2aleei5mU82YOtBRb8eTp6
 E7wayt3plKteheSP5xYaIH6RCsKtX0redcJmmyE43sksb8AducpHKlzFB4T/w7YCpk/QmTPgJvA
 hYDN+8/0w3tElTXazpMphFUNsWMb4jPXTuB240zVlyGEG+YMnxj2rAjeE7icdPXQc9N1qtPEYEx
 Cdm1vhc2t3uyMpG6Nsvs0oB8RHT+mn1/mdZ5RSffL3VuSoPRVnQ2Sjg0pFMFvBBrtqQsu12OveF
 iRZzP3sCzf8dYOz1tcpI2nwqa/ifQfmbW75L8zZjl2fSXJ5ZVCSzjI+XAvkFi6Z5dTHQRwJ/0Nk
 vCKGJ+rVpqYtLKo7cPw==
X-Proofpoint-ORIG-GUID: C_vhAwuL4U_yLyURyloMJOMbVPj35Dpa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 clxscore=1011 phishscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609300059

QPaCE (Qualcomm Page Compression Engine) is a hardware block found on
Qualcomm SoCs that accelerates page compression and decompression for
use with the zram block device. It is composed of multiple compression,
decompression, and copy engines.

This series uses QPaCE's "urgent" (synchronous) path, intended for low-
latency single-page operations. A command is issued by writing the
source and destination DMA addresses to one of several per-CPU urgent
command registers with a single store; completion is then detected by
polling the command's status register.

The hardware also provides a ring-based (asynchronous) path for high-
throughput batched compression, where transfer and event rings allow
multiple descriptors to be queued and submitted with a single doorbell
write, with completion signalled via an interrupt. This path is not
implemented in this series.

The driver integrates with zram through a new "qpace-lz4" zcomp backend.
Both compression and decompression are performed by the QPaCE hardware
via the urgent synchronous path: each request DMA-maps the source and
destination buffers, issues a blocking hardware command, and returns the
result size.

The driver also integrates with the Qualcomm Last Level Cache Controller
(LLCC) to activate dedicated cache slices for compression and decompression
data.

This is validated on next-20260929 with the following patch applied on
top to allow booting completely to the serial console:
https://lore.kernel.org/all/20260911-rsc_read-v2-1-98675c248278@oss.qualcomm.com/

Georgi Djakov (6):
  dt-bindings: soc: qcom: Add QPaCE binding
  soc: qcom: qpace: Add Qualcomm Page Compression Engine driver
  trace: qpace: Add tracepoints for QPaCE operations
  zram: Add QPaCE zcomp backend
  soc: qcom: qpace: Add LLCC slice support
  arm64: dts: qcom: hawi: Add QPaCE DT node

 .../bindings/soc/qcom/qcom,hawi-qpace.yaml    |  94 ++
 arch/arm64/boot/dts/qcom/hawi.dtsi            |  17 +
 drivers/block/zram/Kconfig                    |  11 +
 drivers/block/zram/Makefile                   |   1 +
 drivers/block/zram/backend_qpace.c            | 134 +++
 drivers/block/zram/backend_qpace.h            |  13 +
 drivers/block/zram/zcomp.c                    |  11 +-
 drivers/soc/qcom/Kconfig                      |  14 +
 drivers/soc/qcom/Makefile                     |   1 +
 drivers/soc/qcom/qpace.c                      | 830 ++++++++++++++++++
 drivers/soc/qcom/qpace_internal.h             |  84 ++
 include/linux/soc/qcom/llcc-qcom.h            |   2 +
 include/linux/soc/qcom/qpace.h                | 154 ++++
 include/trace/events/qpace.h                  |  99 +++
 14 files changed, 1463 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,hawi-qpace.yaml
 create mode 100644 drivers/block/zram/backend_qpace.c
 create mode 100644 drivers/block/zram/backend_qpace.h
 create mode 100644 drivers/soc/qcom/qpace.c
 create mode 100644 drivers/soc/qcom/qpace_internal.h
 create mode 100644 include/linux/soc/qcom/qpace.h
 create mode 100644 include/trace/events/qpace.h

