Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD5A43B492
	for <linux-trace-kernel@vger.kernel.org>; Fri, 10 Jul 2026 17:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783703557; cv=none; b=JIpuusFNOs4g0tCWvRBIgWD5+iFFDRhfDZwnUYdHmQH2p7/0GDudcthqwAlL4cln8XY1/iIrXfzfmwoup7+H/F/DZQ5ExLNPQiFA9m0rUypPnt7yPJCzBD7v4FiTDeIcnKSf6PDMc9z6rk8nrQSfSszPQtIZhM7t4eeWCUaR2ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783703557; c=relaxed/simple;
	bh=KaWEDOpkUuVKoVg9qHrT7941BE+j2QnbfV/wJwii9NI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uy6jQTIz++eb6j5gFAA7rQ7S/S5Bt3OK7ggi2WCORy88o/VvJooDfU3gTVIrBtDOpPHaR4fk1zHG7Uog0WxCejOVPgxBfsEpTrLaROE+4BOng+6hmNC58WjI/F69VSLjVVSOoOIgyzwz1EGDO/GWGiEfj3z9Sdn93LI0ffC1bq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ewx7vady; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XTq1OQRQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ewx7vady";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XTq1OQRQ"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66AH3g4n1307174
	for <linux-trace-kernel@vger.kernel.org>; Fri, 10 Jul 2026 17:12:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sxIr88wu2w6WZwojybE6NAOi4XgPpY4LktqZVJRtIYw=; b=ewx7vadybWw9WIYN
	CLeYlqnO/B0nFGmPPi9AjpZ0iEC11DIMQAX3cgTNCwO6NeCfJoG/40rKrxT0x6hs
	Ai3UdrBRCiAdQwkiNUa6GV7QBq+6MQ/3i1VEZLloA14oFP87X8ZsJpmDmJC/4C1y
	dMGwM8d69tMRbHXPXx0qSln20Oe+ACgdmhPNfyK2uaRDKc/dAxORkJ55/L8qB5bl
	E7eiJdixxIZOJhaSb5IRJMOleFkhp/7tqoYDAcUOwezD/y4O0Y4qb31mihl3gApk
	JX9/y1YeaZdQs8/QN8D2IW7p/PrZkKd8MBLsPIgI0SE9UkNDBKq7wwGQ794s51U9
	xoj8Hg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fax5dhq2j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-trace-kernel@vger.kernel.org>; Fri, 10 Jul 2026 17:12:35 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c894391f000so2423127a12.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 10 Jul 2026 10:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783703555; x=1784308355; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sxIr88wu2w6WZwojybE6NAOi4XgPpY4LktqZVJRtIYw=;
        b=XTq1OQRQT+XckvtSvfuMG1y8v0Ux5hXt3oCkLxtfwk7+CBJgxdBRJ7EeJXreeWGEIJ
         ogB166PtGmWO0Aju2h+8rAUD7n6x77f3Fa7y02FrU9VneAb1ADHcr+TZ12SR9CKDxjic
         NI+6sOruMYNueMoJ3JU2y78sZE8n9Y7f0spcGm7zYQbVbYDjErT6dN2syvWl0sY1bafp
         eyfGLGNEpW0sGmLDjN33bZxzqKrnCTyr2vFjJ2rvXwZ8QYXCTqqNdWGtzu9lIGc+8EoZ
         ssZKdnCkzttNoqliTdHB/QkWuiUbhPvmByjTJbMGU8lMZkl/mAKNVi3lAmWkiwGPJAf3
         bFYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783703555; x=1784308355;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sxIr88wu2w6WZwojybE6NAOi4XgPpY4LktqZVJRtIYw=;
        b=Thn/ONDp5j3q/liAtXrYA3ktGu7Wi5gcx8gT/olJR8x05xqEr7KQpFcdSoitMk90jk
         McTa7OFW0YbJUPbrf6y6m66X4gssrjpiYF6atPWghBEmtXNntkrdx4tYt6gmngn8PHO5
         mrIPwV6mjvg6TXgdDh4K/L2/5BI+8erjosYNKLZuSeoAauzDIPTLwcQuhAuQxduYUqZe
         t8N85soB+dGZ3wg1H4i4cUXEtBgOW7m1K4M4BcfOJoJ74O0FEgahqL85Fohr4Zh4RtWG
         xDMl8K8R5bCTVM5qCHL0fAR13qAIwaVzA5pyeASSeLoCXA8cNuchW300MEIJoghtwvXD
         QPUA==
X-Forwarded-Encrypted: i=1; AHgh+RrLyJzDndYBh2HMfnuHEunWr4kkuppC5V31+E2h5O9aqxprqPHaDAUdNo7WD36Thioo3x+/9uUe4PTMG8JGoSE2a7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+8kMctYDiVI3n8VU3csKjzjnb5yZxCrTtgttjqFNBa960EWE8
	gMx6HhoreucWR1lLQ0bUOdpZGlDQxvUCT4xY7WEyqGYU5P3F9rBG+KViHKPm+TalOAY62INz7uC
	B1flzw45WKduxPiRRHcg3rxsqXtxncuj0JIpBPBXUpzAayZGMbk8OXrfhRuLcY4PmCiJe6c6GCB
	EDEu8j1Ng=
X-Gm-Gg: AfdE7cmIs/K6zEHTCZ4UJpg/Ip74rE6CGMkb3obQq+WYhi/hGxnPlpfehZUhakbZmTn
	jvwnCa4aCnZweO1/osGg4LMIBjashgaHHfYQnfWif3PyyT9eg/lV9aj6KnzpZz6ozhb4S2/oDjn
	5DNI4sNoXRtiAXQF8VvpeFpvVFJO9+yNHv16K7ToOWq4QuuHuWlAa5lkL5Y8yyoeZtkp4OCbXt7
	xr4NJBWpOAJohZhz7T8rTnTJ31WwgutSSjtlCbemI/pJEh/EI7JUXzBTBnNXuha3X5hSTzQ2D/I
	iaa/b/OH8yTrgViXH6bpH5sYDZZHD/2aUap9UtcbjhXpiTCc+YoPzqo2IFRphv+lFJjxl4/9Ipm
	0/v5eiBX+pFuKocuQOW538JJ9M/qffgxfGCGb3NRB4P6p
X-Received: by 2002:a05:6a20:1587:b0:3bd:203b:b587 with SMTP id adf61e73a8af0-3c0bd1a82c3mr14635699637.40.1783703554873;
        Fri, 10 Jul 2026 10:12:34 -0700 (PDT)
X-Received: by 2002:a05:6a20:1587:b0:3bd:203b:b587 with SMTP id adf61e73a8af0-3c0bd1a82c3mr14635674637.40.1783703554405;
        Fri, 10 Jul 2026 10:12:34 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b659d7c8bsm46636277c88.12.2026.07.10.10.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 10:12:34 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 22:42:12 +0530
Subject: [PATCH v6 1/2] serial: qcom-geni: trace: Drop redundant len field
 from geni_serial_data
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-add-tracepoints-for-qcom-geni-serial-v6-1-2bb6b6836dfd@oss.qualcomm.com>
References: <20260710-add-tracepoints-for-qcom-geni-serial-v6-0-2bb6b6836dfd@oss.qualcomm.com>
In-Reply-To: <20260710-add-tracepoints-for-qcom-geni-serial-v6-0-2bb6b6836dfd@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783703544; l=1724;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=KaWEDOpkUuVKoVg9qHrT7941BE+j2QnbfV/wJwii9NI=;
 b=IjfH90zTD7gkrIX1QapOnydV5xa43e3LHKBA3+2+LybTDgvWiz8fLKL01CFhC4xNHxh68dAQ2
 SmaLSRFSxEzDC5iyTmuEo0edgjoBDQR/2a6fsR1b+9TPsHDn75QicvC
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDE3MiBTYWx0ZWRfX4VX3L2bk2Enw
 EJIrtIEooCKNNtDPdqJ5Tde5rD3qBnNG2niyYQvlWL0oqmcDKwVasx2mJJHQ6yrgAetfc/l7wwB
 kllvSk/UPAMdEeqZAwJUc7Lo8qbE9M4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDE3MiBTYWx0ZWRfX/+a2RNpxbtmX
 LoUUMbZW3tLU0CWYUXLNKKA8a5i65dA75ykUuM2pcG9euCTWKm52i1hoyCjaSaOCI/vxIZUnB8R
 JYWV2CqNUsQrAkZsa0AT169i6/r2mlW+h+tcVXzr0AUwWooVa/Da41QHsB+n7iCNoXbd1x+Thiz
 lBUX+IhallljKNpDXNv5SuC94k7mMnGz7Bvn10P8DerqmeXd3d6t3jJQSlwIQUTi7/+3V+T2MgW
 P94qzDzIfwUi/PayELmE23+jgVKdCN57IlnMZAIyJwIzVPGa2AyKfVM4ES1x0IQD7wjtw9OC36J
 YeFv3n3KcdcsNkbeO09aVpOdRtg+qqXIt2UReEIHLBcvTCGohiQkryMW5cJme1ARbgkyt/SBeqv
 I+CLE9DQ7fSX3waugry7c64umh685YxJDKxFGMcc2T0C+o35nanuCtY6nWuv28ZJYNit9phrCFR
 QbjxTDyWu3fjGFp3q1Q==
X-Proofpoint-GUID: LfNYAYRaI1z6ONFzcRYGTpcasRa_Pgr9
X-Proofpoint-ORIG-GUID: LfNYAYRaI1z6ONFzcRYGTpcasRa_Pgr9
X-Authority-Analysis: v=2.4 cv=M/x97Sws c=1 sm=1 tr=0 ts=6a512803 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=meVymXHHAAAA:8 a=EUspDBNiAAAA:8 a=lKnyCkGSJWauGj82uDsA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22 a=2JgSa4NbpEOStq-L5dxp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_05,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 phishscore=0 spamscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100172

The dynamic array stored in the ring buffer already carries its own
length in the array metadata. There is no need to also store it as a
separate scalar field in the entry struct.

Drop __field(unsigned int, len) and the corresponding __entry->len
assignment, and use __get_dynamic_array_len(data) in the TP_printk for
both the len=%u format argument and the __print_hex() size argument.
This saves 4 bytes per event on the ring buffer.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
 include/trace/events/qcom_geni_serial.h | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/include/trace/events/qcom_geni_serial.h b/include/trace/events/qcom_geni_serial.h
index 417ec01f9fc8..e1aa551d525e 100644
--- a/include/trace/events/qcom_geni_serial.h
+++ b/include/trace/events/qcom_geni_serial.h
@@ -97,18 +97,17 @@ DECLARE_EVENT_CLASS(geni_serial_data,
 		    TP_ARGS(dev, buf, len),
 
 		    TP_STRUCT__entry(__string(name, dev_name(dev))
-				     __field(unsigned int, len)
 				     __dynamic_array(u8, data, len)
 		    ),
 
 		    TP_fast_assign(__assign_str(name);
-				   __entry->len = len;
 				   memcpy(__get_dynamic_array(data), buf, len);
 		    ),
 
 		    TP_printk("%s: len=%u data=%s",
-			      __get_str(name), __entry->len,
-			      __print_hex(__get_dynamic_array(data), __entry->len))
+			      __get_str(name), __get_dynamic_array_len(data),
+			      __print_hex(__get_dynamic_array(data),
+					  __get_dynamic_array_len(data)))
 );
 
 DEFINE_EVENT(geni_serial_data, geni_serial_tx_data,

-- 
2.34.1

