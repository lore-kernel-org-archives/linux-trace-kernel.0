Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508D93A0EA5
	for <linux-trace-kernel@vger.kernel.org>; Fri,  3 Jul 2026 15:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783091309; cv=none; b=X+2lrkx5F1Y4dNUt0up6JzSJn2vuaXtH/UFMFkQ0DewOulq1D0CufeA8l6rBhr5ENTKNQWUdSRGz2OHfH082dTw1GCA3v+Nixvg2iiuAYC4MGsp0HzAuQ645f2V9HsCVDoWL9eCOqQ1kYDusc5VYW6EABS7M5Vea1GQpopBimBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783091309; c=relaxed/simple;
	bh=5LefAlIjcE/PzYIC0Xzc1u6687PAblmcgOZr94jJsUM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=vCgiLPH9Ch3vKzU+N2YSfo4b0N0oPyxbQVqZswRmv0Onf0h4iYLUiOJHIK8aQUSTQeLfG73AQUQNEcwkImyCur1ac1g9P9DbDqWaYgYTNpsNlQ6AlZOgwW3N0RfaJVPRWjgIvRP0qy5bx1N8gn/Lv6bvPm0gp5e1XF7YCBHQf7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nkqb+VLf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NVIk/Ibq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nkqb+VLf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NVIk/Ibq"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 663BqhF14091014
	for <linux-trace-kernel@vger.kernel.org>; Fri, 3 Jul 2026 15:08:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=LvBcjeyn9vD9s8JRnZz8Km
	rSdZM+Hn1S3FaRZGhvGEk=; b=nkqb+VLfthfcEw5lsJWR7+XCb47gdjGiS/qcti
	kxxrlFpq/3iuEpzfSUuqAfEg6gi/T8I8vt8md5q3agiibnpto+pnLdKP0Jnu+U9Y
	DZFkD67R3FfCTx2ICElEmEX0q+iDimE0kjWjMznsrKeI1g5LadUJoiB38c0YYZfo
	BGA3EUN85J87YhXIPyBru+M2ds3hmUFsd12N6EG5As31Y7vkjl3o5oI8LOiVKJa3
	qfOgk3Ziu/CX3n2j4toBx5Y297q7icRlDHi/2ddb4qq7P752RpzXu1KJvW7xOUM0
	PXhqBGqKV62NhRJAhlnzIpAeqOoUobqyKRx9Rx8Vl5tN/nEQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6ckj0n75-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-trace-kernel@vger.kernel.org>; Fri, 03 Jul 2026 15:08:23 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-37e17ec1940so841198a91.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 03 Jul 2026 08:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783091303; x=1783696103; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LvBcjeyn9vD9s8JRnZz8KmrSdZM+Hn1S3FaRZGhvGEk=;
        b=NVIk/Ibq108/yZGN+Havw2v50Rgh514mH+/LGPwruDMbYyz69QZvUa+O9+hwWJ9YD+
         pFeIQhUDXTNHaSxhmHuMd6hSQNxUmoRBHBQ7FzPkoaBVbWngyaje6jxXJh00mG/RVzju
         VmZri/V5nhijGFeKPSXpUIvOUezzV5Y7DG69OCpMEMLO78Aj3aqYXSdEpU13Uhwx+pRc
         0u/kjMxHlQqUeOOcQ6jl0TdEs52rgt1msBKfoWgXRUk5OKUfWpZg4uF6d77/+y8ASTYA
         mIsaMSBqGtCAgB9jQNDXty190NqYHI3qsVOuivJjNBXRKhEvvFodkq+B1ljqKIxHBy2Q
         WeRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783091303; x=1783696103;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LvBcjeyn9vD9s8JRnZz8KmrSdZM+Hn1S3FaRZGhvGEk=;
        b=ccTkM1IoMNRK4py0d3ovYI4jcahV4EbmAwq3TT0Gh2y+5RkguNJa9lq8wKgoKW+j3K
         aFvUy0ANYhxog/JxMKHfeZVigEvIBdzb57pU3T7Gw4Jq8tz8nQSgQHSGpQavR1UTIf3O
         8Ls8NLkCRr2ecgb5cYzf9VoofeqAWzuX+I3M9cWxcZQVO4gcJTHXlpTHICdA0BSCHyeM
         Cl0odrZSPZpBbtfRiSSadjl0W/kMggNoMPTYh+AbFnIzu5YYWJJP+033q/xA8+eEzjWM
         2OURI9ifNkTXlETavECwtpkQasb0LFL/QkiK1EE7+ts91J0SKrU3R1n7aSn6MNgR18zR
         CUuw==
X-Forwarded-Encrypted: i=1; AHgh+RpNkZM8LuTHLthx2y0w5qSxzL4KC83l5SjimM+2VyifIkS1z6ulVWAUI4kmPzyBbtfccAJC1JCMnsxmUUYhCBU1slU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIzNASZElxcqRN4b1wJpeHf7OQUFBXxgyjrueqnWSxOiRoyDAj
	OBoEOifdQsqp/+bmz/1cq/Kcr7/5relema372rEDq471UR7wemRtub23EdAtgbDHsiJ6TSiljAb
	oUQhWCDRpStTop29Ae4XAutg1vnpioUeNzUzOejklUHY+i90Zvi3tQoLMOfo8UqUkWI0qmT1fI3
	g=
X-Gm-Gg: AfdE7cmmnA/5UfPtIKqEksZ0Wdd8lgivGaEFpjJIEUmAUqXwr4zTR4JnYNc+KsYW8PU
	iBx9WFtV7O+W3BXADD9S3AwpV/7mfcrauFLLT90q2gpz4BbmSKp7SDgAuc8sr8bj3cZEiajAUoQ
	dehaOlyXj/Q7ymf3Qnh8EGTRLPk7uWoODx3PShkpUBzhwSQoIfXCCHrdJeWKPeKoQHfXINGLFkD
	A+HhsiwZ3bJqIViIPcPrI6TKN5fSLK3zvsJhz/ON9ueVTYrKcPkJvo9mpnl5LxmjC/M7iKl0Wp9
	BBUonmOOqf8d6Q5RdYhsQ2epirMMUOXiWtKBmzyBxdkR3TjxnTA6yfBu8Keeg6cI7VBhJDZ3LCo
	cD31aXIreAVdmA4NxTehqXYVOzLb6N8m9GUdHu4ls0jqQ
X-Received: by 2002:a17:90b:5404:b0:36d:9e0b:3801 with SMTP id 98e67ed59e1d1-380aa0c086amr11735962a91.8.1783091302592;
        Fri, 03 Jul 2026 08:08:22 -0700 (PDT)
X-Received: by 2002:a17:90b:5404:b0:36d:9e0b:3801 with SMTP id 98e67ed59e1d1-380aa0c086amr11735910a91.8.1783091302020;
        Fri, 03 Jul 2026 08:08:22 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0b816a42sm37007808eec.9.2026.07.03.08.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 08:08:21 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Subject: [PATCH v2 0/2] Add trace events for Qualcomm GENI I2C drivers
Date: Fri, 03 Jul 2026 20:38:08 +0530
Message-Id: <20260703-add-tracepoints-for-qcom-geni-i2c-v2-0-e8bf8b178290@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFjQR2oC/42OQQ6CMBBFr0K6dgiUCujKexgW0A4wRlpoC9EQ7
 m5BD+Bmkpe8/Dcrc2gJHbtGK7O4kCOjA/BTxGRf6w6BVGDGE54nOb9ArRR4W0scDWnvoDUWJmk
 G6FATEJeQZSoV51JwXjYs7IwWW3odjXv1ZTc3D5R+H96Nnpw39n08saS79+tlyR+9JYUERCGky
 qVqkBc341w8zfUzaEMcDqu2bfsA0nVezesAAAA=
X-Change-ID: 20260629-add-tracepoints-for-qcom-geni-i2c-33d14584228b
To: Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        aniket.randive@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com,
        Praveen Talari <praveen.talari@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783091297; l=1679;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=5LefAlIjcE/PzYIC0Xzc1u6687PAblmcgOZr94jJsUM=;
 b=HN2zlAN7FWoASXQeWDB7aoyI7VEkpA4oLeiY09i0kGoTcQ3IkBNPAaiS/2JZk50QDZTp4bEJO
 iH7Xc24a6VFBjVY/Jq73CxvrHRAPwuFrHTFF+wjLAEeOhDU9lk9/T7H
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE1MCBTYWx0ZWRfX1La7yEQdRkiC
 dMDblTkeWCNVPTbNZLUvjVm5cLRAtNj1H7v2XxKqgd6k2gK4kJCWYxzFeC42RhyT42TLERqud7w
 Dl5HMlPQ1QWJr3Q9b6lqCxt2D2ptDPQ=
X-Authority-Analysis: v=2.4 cv=E8v9Y6dl c=1 sm=1 tr=0 ts=6a47d067 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=pfqdL_FptRF-L44MAtYA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-ORIG-GUID: 1_ozTok8EOASsWDze8am2RyWsrNtkI6l
X-Proofpoint-GUID: 1_ozTok8EOASsWDze8am2RyWsrNtkI6l
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE1MCBTYWx0ZWRfX45QnD3XOPWIm
 bYOMl4mFHPtWO6EostcCO9fVmZQSd61kJzMsKYTQhwANfIWDg/+iIu2vIPRHDpsMglqH9RrGQMr
 zTsMhpha/zQGl5ehd5HN65AsNEKVa5cF1I5sBr32O1Hi9nide3zIeRk6zl37GElUNrlIjUlrl19
 jCxWEd/y6B8aUrUIbd3OqX4sLoIBiVtL7XSDBtnTby/HecmVYMHIeByOcVi3TGcRo4winfN5mIt
 H/N5rxs5JRZaMd+JCsobqAKjtlCpsrrfrAxC4eRxawX5iuB70CObvkmtV4+xvqUHbz7rIsshtiG
 YX91rSZ+ZpI2q2VNwLQj8fUPB4ErdkMPmb2lI8XYoZLAi9CLzlnqpLr98dgxeeuKlpEWSE7fp7h
 Y03/ZBKGtI3n+IHha8JloprpZEEF8/K+Kb53WJV6HzMIspN7NYebNUFL0EBipbRdJoPqo66D2zQ
 3M/YR1DkDcWLH67anhg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 adultscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030150

Add a new trace event header providing tracepoints for the Qualcomm
GENI I2C controller.

The trace events cover controller bus setup, interrupt status and 
error reporting. These events enable structured debugging and performance
analysis using ftrace.

Usage examples:

Enable all I2C traces:
echo 1 > /sys/kernel/tracing/events/i2c/enable
echo 1 > /sys/kernel/tracing/events/qcom_geni_i2c/enable

cat /sys/kernel/debug/tracing/trace_pipe

Example trace output:
79.737075: i2c_write: i2c-11 #0 a=057 f=0200 l=3 [00-00-3f]
79.737075: geni_i2c_bus_setup: a90000.i2c: clk_freq=400000 clk_div=2
   t_high=5 t_low=11 t_cycle=22
79.737084: geni_i2c_irq: a90000.i2c: m_stat=0x40000000 rx_st=0x00000000
   dm_tx=0x00000000 dm_rx=0x00000000
79.737201: geni_i2c_irq: a90000.i2c: m_stat=0x00000001 rx_st=0x00000000
   dm_tx=0x00000000 dm_rx=0x00000000
79.737211: i2c_result: i2c-11 n=1 ret=1

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
Changes in v2:
- Updated Reviewed-by tags
- Link to v1: https://patch.msgid.link/20260630-add-tracepoints-for-qcom-geni-i2c-v1-0-474cd6cdbe27@oss.qualcomm.com

---
Praveen Talari (2):
      i2c: qcom-geni: trace: Add trace events for Qualcomm GENI I2C
      i2c: qcom-geni: Add trace events for Qualcomm GENI I2C driver

 drivers/i2c/busses/i2c-qcom-geni.c   | 15 +++++++
 include/trace/events/qcom_geni_i2c.h | 82 ++++++++++++++++++++++++++++++++++++
 2 files changed, 97 insertions(+)
---
base-commit: 3d5670d672ae08b8c534b7beed6f57c8b44e7b43
change-id: 20260629-add-tracepoints-for-qcom-geni-i2c-33d14584228b

Best regards,
--  
Praveen Talari <praveen.talari@oss.qualcomm.com>

