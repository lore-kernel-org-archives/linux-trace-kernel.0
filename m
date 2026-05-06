Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78B44A13AF
	for <linux-trace-kernel@vger.kernel.org>; Wed,  6 May 2026 17:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778088594; cv=none; b=Ak08Mz1nYteHzxXzlffgpwyRhcekY60hHo8pzzy2STIERvt/HpAKsikKBBwEYsnhenO8xhWusqx1//6ZSaEkuhlCV0AA5yKuqOK3uQtu6r8almAYHTWhlodY0WMwXIf8Cjl4VV1cnE+pgVABR4uYY+rtGAJhOeUFaWvO8McIIJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778088594; c=relaxed/simple;
	bh=3JgXi1HK1tKOS2FgWwES+VKeMEfmbOZHDIeuXblGSrY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=RVFr5Kc1jJGttiJmHpKm7G7BaJ7691WsHmoOahpuyTTEHeU3noZSnetnFNVNxI0Uie7FpSjDvTyfBC0lnPp3iP6n68TvghCdLPMoZTNIt9I0H0NKePEH1hePg7fuLevMjIxNA+twtePCFFB9KVeYRcu4/GQ88YJvUcRxaraY8tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=joNp2DaD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NYqsXWHO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="joNp2DaD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NYqsXWHO"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 646C5KSU3036465
	for <linux-trace-kernel@vger.kernel.org>; Wed, 6 May 2026 17:29:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=xo2tEHOhCkdfyg66wDwPL/
	kmn6HqLssXnGU+DeV/8ww=; b=joNp2DaDI/zmuTFjLDXNeT8js2pv4Eb6GGoz+B
	51Ff5aGXYszrhG5vmS2EF+QMGx4FT/ByK2fjYyBsgeZSfCq2kzpsJ6XeiYeuMp5r
	TMRQRtuRy+8Yv/OhhSp09IJdFnBIp4jMqM4M83rr2JhzUWPPFCfSYjfZNnV79lzg
	0PaaO/TTOi4NQ2nVqByFEhyC0ScHhXY9w9XmZYEwYYOmgrgRH37jq2+01hGO7YLr
	GewDhjdkcB9Yev3KqFOdPKQlcIHd0BKuSEv9wuAAPvtmyyeCD+mBxH1pDgtP8pB2
	3Shu6BTh5ejjDS85Bwj+wIx0S7WNb3egHuXxXo1E7BJnRA8Q==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e05bf18yy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-trace-kernel@vger.kernel.org>; Wed, 06 May 2026 17:29:51 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-35fbaada0caso6007260a91.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 06 May 2026 10:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778088591; x=1778693391; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xo2tEHOhCkdfyg66wDwPL/kmn6HqLssXnGU+DeV/8ww=;
        b=NYqsXWHOSv7RfRnQy8REKNpelsH5K27OpeCXl4V49EnvX2ioD5W+aOa3oU6oqmjSqM
         voWFglcZRqk1BBcd+o5F6EslndtNXsOZqwjH6ISdFVeZZ41Q7ofiWZi4k3fcBF+Jr/Jm
         bbDDC+Tx1IS5gIlbYLeBYkZoEX797DCzcRuV0VPiKmKElw+dZo0lb5GH0rt5CUMHlHlx
         gGFc237SczLdcGXMVZELSV9smRA/1PTSp44YxGBiC2yct8UUDcq6ITi+LVJAZh9YdVqo
         ynHdNVkxxqC72xeyvXmyXkdNRbTk/DTmLUy/AK5XEOp7Y0rl5mIqPgKJS2ljchywsDE7
         8deA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778088591; x=1778693391;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xo2tEHOhCkdfyg66wDwPL/kmn6HqLssXnGU+DeV/8ww=;
        b=kFcSsREYFAg2XZhgoZQ1gyBV208XnrI709nj+/Lep8kU1YJNwCGbTiJYqxsV/Nwc6f
         PhhZ/sGTRj5D8proGOGshYF38E8cV0VFk03345z899eR1t1eIxcdIJtDHP306/7c/CIV
         eve4pD4tdH8wfVAfpQKMsMgMXgTyvE8Ypa1ElubfGMEe2puVqatnCNo8U8wrOZZerb63
         xjv8JdN2P7cYZU1KllloP9AfJSYZtLDnHK2FktAi5pK6mgBI72x9T9G0/1yF0EXEKXzZ
         e3vitZJMGVEeJVr5XMf5daNcuVEkOfTKxBjDQ1tz8OzxvJfO2rxYvzo2KL3uIt0FqWhK
         EUYg==
X-Forwarded-Encrypted: i=1; AFNElJ/VegKkvi09jEl0EmunR4Ku0E7lLV3NNHYNx1EJ1HQ9Xqf3aLfqCLjANWKNU0m4hX2GQpnUuhyoLZksVDXKTkNacuE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPSyZoLBQ85vfqIJ4AZAiIvLtWvC3PCjrtn/yK2t4b+X8x8lEJ
	U8JRx/FvYEmZZkTVNqHJKRZTXXGvWAee6r6y4OjpZtVWeD69Wpq7qZMe5PSAakX0+YQ8Y5YajpA
	fE0Vq2468ZkC4jHnUt2QCVXNVpMTVfTGS2GSl+2HpeUHzp6tEjDfwpXebSCKUPbD/OBHn8tyZmP
	8=
X-Gm-Gg: AeBDieuF/KhXdI8KbM098DBewqBroOGRYhPxjgTKZcgr/sDvjAAmX4vlBfxlX5fksSr
	1OVBjqejFhhFVm4KELY1gWd9ysZZqtafqmO28aIMMpnhHFk/tDulDJMmkVcJdvpv6H2usU9GfmV
	9LtXPlSb6oeRP+5TzIMhkrsyBz3qJFx6X3L9oVyr2RgRzmqrtUCkK+5p7Rn+aAjfmf9DZnwyu4E
	P7OtqDYm43l7ZrzxMUWDF6/O7xjYtMQ/u84Bqe3DXcrp+B07EvmsPsgJzVrPW8dI+9ILCtyr8zP
	E7COMEoFi83IXGiI4+mq0Gvzk6H7X0N26Eez+Ak+yKtcHxPAKSUxfPIM0sFuN2iqEhJwYQB+PlX
	/Nfk6phDbHW/LbghdR31kuzEF9bZLIOyVjgqCEBbEyP51D3WrvGhYu3XkSgedZxpn1g==
X-Received: by 2002:a17:90b:3d0b:b0:35f:b4c1:91f6 with SMTP id 98e67ed59e1d1-365abce2cd4mr4707614a91.10.1778088590514;
        Wed, 06 May 2026 10:29:50 -0700 (PDT)
X-Received: by 2002:a17:90b:3d0b:b0:35f:b4c1:91f6 with SMTP id 98e67ed59e1d1-365abce2cd4mr4707579a91.10.1778088589953;
        Wed, 06 May 2026 10:29:49 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-365c25f8cf9sm3370143a91.4.2026.05.06.10.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 10:29:49 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Subject: [PATCH 0/2] Add trace events for Qualcomm GENI SPI drivers
Date: Wed, 06 May 2026 22:59:41 +0530
Message-Id: <20260506-add-tracepoints-for-qcom-geni-spi-v1-0-c957cfe712d1@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIV6+2kC/x3NMQrDMAxA0asEzRXYbuNAr1I6GFlJNdR2pRAKI
 XePyfiW/3cwVmGD57CD8iYmtXT42wD0SWVhlNwNwYXoRhcx5YyrJuJWpayGc1X8Uf3iwkXQmiD
 f/WOcKIQ4EfROU57lfz1esHl4H8cJhAqrvncAAAA=
X-Change-ID: 20260506-add-tracepoints-for-qcom-geni-spi-e31457c2267c
To: Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        "Mukesh Kumar Savaliya mukesh.savaliya"@oss.qualcomm.com,
        "Aniket Randive aniket.randive"@oss.qualcomm.com,
        chandana.chiluveru@oss.qualcomm.com, jyothi.seerapu@oss.qualcomm.com,
        Praveen Talari <praveen.talari@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778088585; l=1724;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=3JgXi1HK1tKOS2FgWwES+VKeMEfmbOZHDIeuXblGSrY=;
 b=Bih431PHlo4jh7dQFyazOoJmUt3v017ouzPOOKfTB0Tk5csJwh3RBkfw1tz9QHHC8c/DcFRsY
 G9vi+UpKevLDt9x6OUsdEF9pgpXQDgi1knsuMrtvLqqQZzAQ/gi3PGk
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDE3MCBTYWx0ZWRfX8JFM6dtBYJ2F
 HoWYFdeJaC6MQJyRRqqtMCS2krqz+gonqynoBF4PDiVnfARh5ksG8vaiNWKqkmA7889SdsFkHZr
 Ia9bVQbEv7qP9tOFybmdztfIoPXupcvQjh+ZJMi6be3/8S2VTTbFKyNDF6Kmwrd0cnHDzGc6z8m
 P3KhXy233PpeN8LYiCWnQjpR8gufezSmi3XpXJJN9ddGXIefLjLtJ3icpc3kxE+/X1sJx9GP+5a
 wW6GYKWNxVfRyBpGnXEPIQ+04NzmQpWfru+1VbH8zQ0GrV4peurnh071uPKwYSxNzu/VPe242zV
 FFfZw08cnCzI/0oxhYU/kRRTSaaPaa5huLK7iR/iQj2ezqDFt/L1TBYCpZimQRxItBbNX4vxlNM
 r/L3eMqJuxMopgnpChr907OrfRtOvqubn7Pyx2FVcXqaI37qyyJD4P34KGSxgDQaUAl1PygWlHj
 bzajceLnmsKqIJDSMew==
X-Authority-Analysis: v=2.4 cv=PqmjqQM3 c=1 sm=1 tr=0 ts=69fb7a8f cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=7orm17Ck4mEi1eViMI4A:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: OM_tEaefoDurMkfxBQ6hbJ8dbLZSItGZ
X-Proofpoint-ORIG-GUID: OM_tEaefoDurMkfxBQ6hbJ8dbLZSItGZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605060170

Add tracepoints to the Qualcomm GENI (Generic Interface) SPI driver.
These trace events enable runtime debugging and performance analysis
of SPI operations.

The trace events capture SPI clock configuration, FIFO parameters,
transfer details, interrupt status, and actual transmitted/received
data in hexadecimal format.

Usage examples:

Enable all SPI traces:
  echo 1 > /sys/kernel/debug/tracing/events/qcom_geni_spi/enable
  cat /sys/kernel/debug/tracing/trace_pipe

Example trace output:

71.364028: geni_spi_fifo_params: 888000.spi: cs=0 mode=0x00000020
   mode_changed=0x00000020 cs_changed=0
71.364054: geni_spi_clk_cfg: 888000.spi: req_hz=10000000
   sclk_hz=100000000 clk_idx=5 clk_div=10 bpw=8
71.364095: geni_spi_transfer: 888000.spi: len=16 m_cmd=0x00000003
71.364096: geni_spi_tx_data: 888000.spi: tx_len=16 tx_rem=0 data=56 f1
   0d 95 c1 09 33 d2 27 e7 ec 9d 9c e2 11 ff
71.364121: geni_spi_irq: 888000.spi: m_irq=0x08000081 dma_tx=0x00000000
   dma_rx=0x00000000
71.364126: geni_spi_rx_data: 888000.spi: rx_len=16 rx_rem=0 data=56 f1
   0d 95 c1 09 33 d2 27 e7 ec 9d 9c e2 11 ff

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
Praveen Talari (2):
      spi: qcom-geni: trace: Add trace events for Qualcomm GENI SPI
      spi: qcom-geni: Add trace events for Qualcomm GENI SPI driver

 drivers/spi/spi-geni-qcom.c          |  17 ++++
 include/trace/events/qcom_geni_spi.h | 147 +++++++++++++++++++++++++++++++++++
 2 files changed, 164 insertions(+)
---
base-commit: 1f5ffc672165ff851063a5fd044b727ab2517ae3
change-id: 20260506-add-tracepoints-for-qcom-geni-spi-e31457c2267c

Best regards,
-- 
Praveen Talari <praveen.talari@oss.qualcomm.com>

