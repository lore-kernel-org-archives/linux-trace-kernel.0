Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9423128C6
	for <linux-trace-kernel@vger.kernel.org>; Thu,  7 May 2026 17:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778175229; cv=none; b=pcGqzE5IdufzaelUMXK5XI2zdF9PZ9B9NF7cB+D+nHFCZF92ap5YsG4RfAKz0jVx/J8aMoliLvX0ryZ5/tr0C3vBCIIxjiBf9NxRPQ6qUatsJor26af7ilrvwLqVYahy4yuJqHVbc7rgcfxedR8+JKVHOz5QlsZZ9pPW2JtBcHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778175229; c=relaxed/simple;
	bh=cLQZJH2kGtnDZyrn1tg3E2cgngZlOy76lIc1/a36KWo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZNYs3HLnnHKBzPy37vMGZHy9cok9BhPwkTGt4OjKMzvYm4vuVuWYxFaB+01Slq0W1/2X/shvOVtlVKdml6+MrkJIwsxY3PmHzmdwy/GIS0BVaT5TfYmChIK/SDjc7Nw2MK6h0VmAcUBmAHtj0j66+KwgaOymgQrCXn5zBr95s9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NiiHzniW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=j8+Z/Dpm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NiiHzniW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="j8+Z/Dpm"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 647FiC9o258795
	for <linux-trace-kernel@vger.kernel.org>; Thu, 7 May 2026 17:33:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fsf86z252hMHtoLYavCefPTQKf7GBUSrOYzr87mZoo0=; b=NiiHzniWe8XPtoO+
	k2zosy55anP+pxjUMCfpPcPKPlkMuirP6ETTll6iRH+mMryJneYpZVd3MO/OKwsS
	Ze9Xfhvnin3VULp3DJmXwu2WWksdCCF6OrNX4VmExftuNO2mpypXr8CnsqDXOarh
	JVDIdegiIo4HoXGnfy/Lol1PW6BAN+bBIuvGvHStxfZYsA9tpZPQF13pGe5Ni4Af
	0kSJr3RBilAYHC0SDRX/+JfebjooCvFMBY/3jzg5TA7YOqRzOwKuomDtxFwylLF8
	ye1bD8ZytO0kaFhSe9Lnsfe/aU2omjl6Codk3ft0z36wmhX+CfXWza/IQpj37Jqa
	zF8qNg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0hr8ue5t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-trace-kernel@vger.kernel.org>; Thu, 07 May 2026 17:33:47 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2c0f6593ef5so2003349eec.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 07 May 2026 10:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778175226; x=1778780026; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fsf86z252hMHtoLYavCefPTQKf7GBUSrOYzr87mZoo0=;
        b=j8+Z/Dpmz+mgxNfSMolwuFMqjWrfbWijLqfKT4YHB0Cdq/Bydcz4xDt2NUU5aHYM6h
         3l1RtSMwTTd5xD0hXsFyH0WVnuV0x4r0R0ObBH4gLH8FXiY4Dy2htLtaE48P5rka27au
         jzk212RRZpwBG8/x+veeyNlkN27g6ij0fCf5wy+R2spZIeVhll5dPy+dgG7dVWxJdKZ5
         zCFcfD4W2fkCX7TiUCOV1h5Gk2yIhP6S9CwRZiUMILJodqVhVueNDd8y5XvbKnRBHIu7
         MAfR0bp+8x7yyt85Q0anksyrh66zb5KDVLELrfNJYigl7qiTwMOUO82O+9WDemg5VL29
         al5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778175226; x=1778780026;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fsf86z252hMHtoLYavCefPTQKf7GBUSrOYzr87mZoo0=;
        b=CUwaA9V9MF1PgWK82G3eiGaj2ZIMdbYVhEaWZsNbzm8rqJWhTaSoSd+o41PxChjTVH
         bKUta+sdg+/aTIgRJcCeLX/zQc6pgZRUXxP6LlNLjlPkd4nmZov+jalBGLpKYgy9ln+L
         KoQ+zq4Mt68Zla31KTH+B3mmpxQv1uzSdO1qApscb5a7rjWNFKjdzy2pgQH2dRp1xdwM
         iWaUFcXUZswgOkOfLuhddo2TDYpw1mj6/DPpvRSKgfr3FP+WbnCEukcOMnAT/JnB6ACk
         75WMk96Hlr2LTBd12KhcUSgtMXNJ//8QS0gFxKdkVaqnpyvGU3pxHfwhqwUFrPMm8nMj
         irSg==
X-Forwarded-Encrypted: i=1; AFNElJ97eCDi3a3mFloKTd2PWK7K6IPRHp9Cf1sFsqIfoEY/h0UmkzVI4CIQ71UkaVmNvb5hqqt57q+TINQrg/D6gscEkLg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBwlxWES5447mzR/4qCJXYrgRz0HkzMsimHn4ETaWFp/aj6PGo
	g3CbOSIMbwEKucmHBr31Zh2H/WWRmhg635aUZ9z3pSPp8Ffrbbkh/tPJDo3iPx6oRP3OoSOU42t
	c3s8ZsJR7O9Xr0a4w5wPhBT3cjn8/WsQg8D7dcTis+QzSAOg4nEqZFGD1/BJdxZwQE4gSWXMZUL
	4=
X-Gm-Gg: AeBDieuedQ8MeZBNl0rPFV+m0Mwb2nkavam0FIbpYqmLpMeO+/vsXzl/nApP8e7PKO5
	ilTPVXTjROepGUUNACgV5qTYh8K1D3NY/R1N48cEEialUszIIRlwy8RLjxIENZtiiTUfwXYmZuM
	nUV6008msqVolP/C/1TTYYpkg+HNA+F2TgAMT4GAz3kOEME4S/JoxD7+ntkabBtxNpoH9Ds+DkE
	bbtu+A1SaeC7wwBNz5W6bayJXgCbdBW3jNTYIu+qz+b2SUBnuRx0LCBM0VIc0+kQu8tt0TKWERP
	UsF4MFCoSK8ykeVPibieWZeDxG73kN/9FuewuUv4eJzyyH5zGbDroX5wcmxWNr2Ycj8Qf7Q4OJg
	MU9ZrirsZ/rxbIFAcJeh7s0i81k3XbeXfAlQp4d/3QJQpsVkJPP8zog==
X-Received: by 2002:a05:7301:3f16:b0:2ea:e93a:ff9b with SMTP id 5a478bee46e88-2f54919160dmr3866052eec.13.1778175226292;
        Thu, 07 May 2026 10:33:46 -0700 (PDT)
X-Received: by 2002:a05:7301:3f16:b0:2ea:e93a:ff9b with SMTP id 5a478bee46e88-2f54919160dmr3866033eec.13.1778175225596;
        Thu, 07 May 2026 10:33:45 -0700 (PDT)
Received: from [192.168.1.6] ([49.204.109.195])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f56f7967cfsm9440324eec.19.2026.05.07.10.33.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2026 10:33:45 -0700 (PDT)
Message-ID: <59e36f20-891d-4a58-8cc4-6822d03daa23@oss.qualcomm.com>
Date: Thu, 7 May 2026 23:03:39 +0530
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] spi: qcom-geni: trace: Add trace events for
 Qualcomm GENI SPI
To: Mark Brown <broonie@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        MukeshKumarSavaliyamukesh.savaliya@oss.qualcomm.com,
        AniketRandiveaniket.randive@oss.qualcomm.com,
        chandana.chiluveru@oss.qualcomm.com, jyothi.seerapu@oss.qualcomm.com
References: <20260506-add-tracepoints-for-qcom-geni-spi-v1-0-c957cfe712d1@oss.qualcomm.com>
 <20260506-add-tracepoints-for-qcom-geni-spi-v1-1-c957cfe712d1@oss.qualcomm.com>
 <afvkiT50ZUEXZ-YO@sirena.co.uk>
 <e4651363-7c1c-4ae0-a97b-b64841424c83@oss.qualcomm.com>
 <afxJmZ9MkP5eJkQC@sirena.co.uk>
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <afxJmZ9MkP5eJkQC@sirena.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: nQsqp_l_6X7l0bl1hwB50zeg6AIWGUo9
X-Authority-Analysis: v=2.4 cv=caHiaHDM c=1 sm=1 tr=0 ts=69fcccfb cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=TOgzk8GLwxQW6KRttr6vHg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=1cC0H0qRpQ7oy3NfP0gA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: nQsqp_l_6X7l0bl1hwB50zeg6AIWGUo9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDE3NyBTYWx0ZWRfX6KMK8GI2NWt5
 NgRatWNd1By7T5p/QrpXzqNqLsMfZIe2pgoR11wcw6B3V/VnOp9S8vreUveZsM5xs2Ua65JItM0
 a9fnY6ZGFDmhPWhcCWYfdKa3JVo4uLypUe0eYjJ5c4jl9iZl9QhhoSZfFYemQSUvYtV4uvBehwm
 iw5oHht5f93N/knVODzy/YXWIybXOeqnJz7OCixLUgx1JB6OLFNCVExfBCHXdjXO/ScBj5W+rgq
 5nnddRrAVeQASzEjtdr+EPgxw4oklzluk1FqQk+ItwNgQ73gRoA6xJcIMQuXsFfUPxjSIzVO27p
 nFNSc0OvlcMBp7nEPLF+8IWCdQ+uoMgHaOwLN2lSGkIxQIs7ZEDAAWudCfVgDE+bjliFY/t5Yyo
 BzAl8I/GjBZrsYhMGbP28axFGvD2i0DBbJQMJ7kke25X7+AUcP6ICjM8zbLs2/6sdZBzucahace
 IJjVJIFcXeBQi8uDWaQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 suspectscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070177

Hi Mark,

On 07-05-2026 13:43, Mark Brown wrote:
> On Thu, May 07, 2026 at 08:58:02AM +0530, Praveen Talari wrote:
>> On 07-05-2026 06:32, Mark Brown wrote:
>>> At least these feel like they really should be generic events, there
>>> hopefully isn't anything driver specific about them.
>> Initially implemented as a generic event; however, splitting into separate
>> TX and RX events may be more appropriate.
>> Which approach would you prefer?
> By generic I mean this should not be driver specific at all.
I hope these changes are fine. Please let me know if you have any 
concerns or feedback.

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index 4da888359cfc..9abb5f4f719b 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -1,6 +1,8 @@
  // SPDX-License-Identifier: GPL-2.0
  // Copyright (c) 2017-2018, The Linux foundation. All rights reserved.

+#include <trace/events/spi.h>
+
  #define CREATE_TRACE_POINTS
  #include <trace/events/qcom_geni_spi.h>

@@ -709,6 +711,7 @@ static unsigned int geni_byte_per_fifo_word(struct 
spi_geni_master *mas)

  static bool geni_spi_handle_tx(struct spi_geni_master *mas)
  {
+       struct spi_controller *spi = dev_get_drvdata(mas->dev);
         struct geni_se *se = &mas->se;
         unsigned int max_bytes;
         const u8 *tx_buf;
@@ -739,7 +742,7 @@ static bool geni_spi_handle_tx(struct 
spi_geni_master *mas)
                 iowrite32_rep(se->base + SE_GENI_TX_FIFOn, &fifo_word, 1);
         }
         mas->tx_rem_bytes -= max_bytes;
-       trace_geni_spi_tx_data(mas->dev, tx_buf, max_bytes, 
mas->tx_rem_bytes);
+       trace_spi_tx_data(spi->cur_msg->spi, tx_buf, max_bytes, 
mas->tx_rem_bytes);
         if (!mas->tx_rem_bytes) {
                 writel(0, se->base + SE_GENI_TX_WATERMARK_REG);
                 return false;
@@ -749,6 +752,7 @@ static bool geni_spi_handle_tx(struct 
spi_geni_master *mas)

  static void geni_spi_handle_rx(struct spi_geni_master *mas)
  {
+       struct spi_controller *spi = dev_get_drvdata(mas->dev);
         struct geni_se *se = &mas->se;
         u32 rx_fifo_status;
         unsigned int rx_bytes;
@@ -790,7 +794,7 @@ static void geni_spi_handle_rx(struct 
spi_geni_master *mas)
         }
         mas->rx_rem_bytes -= rx_bytes;

-       trace_geni_spi_rx_data(mas->dev, rx_buf, rx_bytes, 
mas->rx_rem_bytes);
+       trace_spi_rx_data(spi->cur_msg->spi, rx_buf, rx_bytes, 
mas->rx_rem_bytes);
  }

  static int setup_se_xfer(struct spi_transfer *xfer,
diff --git a/include/trace/events/spi.h b/include/trace/events/spi.h
index e63d4a24d879..4907625e019d 100644
--- a/include/trace/events/spi.h
+++ b/include/trace/events/spi.h
@@ -233,6 +233,53 @@ DEFINE_EVENT(spi_transfer, spi_transfer_stop,

  );

+DECLARE_EVENT_CLASS(spi_data,
+
+       TP_PROTO(struct spi_device *spi, const u8 *buf, unsigned int len,
+                unsigned int rem),
+
+       TP_ARGS(spi, buf, len, rem),
+
+       TP_STRUCT__entry(
+               __field(        int,            bus_num         )
+               __field(        int,            chip_select     )
+               __field(        unsigned int,   len             )
+               __field(        unsigned int,   rem             )
+               __dynamic_array(u8,     data,           len     )
+       ),
+
+       TP_fast_assign(
+               __entry->bus_num = spi->controller->bus_num;
+               __entry->chip_select = spi_get_chipselect(spi, 0);
+               __entry->len = len;
+               __entry->rem = rem;
+               memcpy(__get_dynamic_array(data), buf, len);
+       ),
+
+       TP_printk("spi%d.%d len=%u rem=%u data=%s",
+                 __entry->bus_num, __entry->chip_select,
+                 __entry->len, __entry->rem,
+                 __print_hex(__get_dynamic_array(data), __entry->len))
+);
+
+DEFINE_EVENT(spi_data, spi_tx_data,
+
+       TP_PROTO(struct spi_device *spi, const u8 *buf, unsigned int len,
+                unsigned int rem),
+
+       TP_ARGS(spi, buf, len, rem)
+
+);
+
+DEFINE_EVENT(spi_data, spi_rx_data,
+
+       TP_PROTO(struct spi_device *spi, const u8 *buf, unsigned int len,
+                unsigned int rem),
+
+       TP_ARGS(spi, buf, len, rem)
+
+);
+
  #endif /* _TRACE_POWER_H */



Thanks,

Praveen Talari

