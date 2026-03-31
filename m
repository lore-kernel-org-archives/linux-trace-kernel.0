Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D2F3DA5C8
	for <linux-trace-kernel@vger.kernel.org>; Tue, 31 Mar 2026 08:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774945215; cv=none; b=Wug1umBzyc1zw4YtdXHLEUEJDBxjTaYw7nX9NwH5gCDxeWmbV/vuf71X5EUBu7rmoDMJQhl8xd+WYnvH4lRNGVmB8acNL/5UhpVZyG6LcRh3rqmG1tJVHvKNEO/y9LKJ3gZp3G6SNAqSxpSeDtsDr1KgVdx2jvw1mlIzWJ2MB5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774945215; c=relaxed/simple;
	bh=7HlX7K0rB6FHxEr7PW+FOibnF3f/ezyXYVU1a+d59NI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QLRbOpXyNK019YoVDgLqoFmHRgookrZFswwFh3B67eZqATp+sdDUUWyYqmEQqq3CUqOIUsDLiIa7ziEFeO6Zy/ON/QKVBci+4hZWYX3HjMqvCVZnDSFhdiZoVQp3pyd7nhxE2AwI4Bbjf697FWeb9g8KK94msF76UGmt+3jdtcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gfkL9lU/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Vi7NlksN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gfkL9lU/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Vi7NlksN"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62V81Dkd430980
	for <linux-trace-kernel@vger.kernel.org>; Tue, 31 Mar 2026 08:20:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=q4UoNmtk4+lUy4YruyrWEo
	06Vis3pSaL7lf3dCzvzRQ=; b=gfkL9lU/GHT2FkuWnXBIs8tCe9bhU1CzuZ9cuN
	/xBRy5/qQC5viW6tqGLxwr8W3cYErVFSXsRSAJ/pwYn9U5LBhYIzXxDNfItMJe+j
	tFwRlBPAoKej6s/aDiRpb6EGWEJfLOQI5SfUIqh0QGtxPh9DEVFcVvnXEAuh9KLF
	USd3kke8rmOICXPdCzsTPyTUxEQDOo0y5yVZlJ1zvRJTgAQ3MokwrUYLRHZaNMQB
	RMm6xVFjlIBOJ4oRi309FzdP1nMEv3IfAEDiv6fCXLysLznABelzJEc+FR+cCZmE
	llEvegNcUcpoG5MCSXfFZnw4EX4wrlLaVAeLeYwL7F5YmZJA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d84bfhdtc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-trace-kernel@vger.kernel.org>; Tue, 31 Mar 2026 08:20:10 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-50b220c72bbso201345641cf.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 31 Mar 2026 01:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774945209; x=1775550009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q4UoNmtk4+lUy4YruyrWEo06Vis3pSaL7lf3dCzvzRQ=;
        b=Vi7NlksNVLRIA+e6IP5CFBiY4TubCw3QyfYBjSdYVcYlDlmBOQcZlImIznIh7t2Zb8
         uyhhRw1xicfKLrPSiObDHZwhrc+VVZNUEsjnEycfOJJ4SHi/oKvbbGklr8RlT9BBnm3P
         1DEwzw0aEsfqomqFy3J4qOXJreX5SYfgaOu5m7/2MDjDgPNkgGLbVBIErt9hwm7PU4yz
         aLgPWpfX8h2khBUiy50NWkGF1p84o/HO144NGtR27YNZbbqER/PuLcGqGmRufTmq3230
         ofbAdMf0NrwVts0q1FmKTFNv3eWA+92XTZwy/bTDFklS2rrnonkXSoL0/Pa/hb/ZnNny
         IqOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774945209; x=1775550009;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q4UoNmtk4+lUy4YruyrWEo06Vis3pSaL7lf3dCzvzRQ=;
        b=qQHWa3zXFRpL6Ywj8EUw8BfFZDmk4sxKv3fRnJKSfuFQPPlkqjRznftgI4VCAeza3w
         2lcSDUOi79l9V+SR421eXVNFc8YZXqYstRjbEovGmNdabsgbMHDnRmHfVubNkEYKEdYP
         W/3dhlzsxAD9bXUFLvQE1o03XTKezm8mLL8rCZopKBrqJP3Z0rTwMB8AaJpkPOv5QCpQ
         XzmvdmhXBlocyzNqIIlFzvGjKLELm7q5+OJs3sya3zjyDZHtL8wD/mc3J4UhgkFyaA3c
         /hp1eN8GCL275408KwEgQENboWxpqv+BdISPKyiFxiky7ZY7v1k+/yTcMsnLMX2Kss86
         rJIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpgbLol5p4Q/Go4NdhgKlgXVDBzDNpE6nBBB29urln6WBnm1TG1IMhbOb+hKB7JVi8OMHtr2AatOXoUFKleJqP68Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx61osEm2KQ5svc0vfbtaI7rV3SPflUD8x11UIjlN+qksMxaHaC
	8snmC9a16euEUC7nj/qdmmc6pJZZorN3SE45JGaQLTKqIDJHS/I+2CP3muqi01CRy9XKVO3xc6a
	dUQF+bObfZvg1tpzDFM/FQdUjVQOyTwzq2pdSrZzsr74Ffw/rmL3jBBBm4n8OD/90WBrZIKO8/D
	XFn8fPYlc=
X-Gm-Gg: ATEYQzwGSNiDrn1uzxjysY6ieJ4F7grT+c4pWHEphF+ct9jqEXe0ME6NVmsWoUdLFKk
	Sz71ERkw283TvMfPZGfTRYE9GY4qmTk61NJ1FOSquBlQ7B99CPYH7+pZn5uiQKSLguu+WhOCyyA
	cabUvcS/gymAFO1w4RLueURepsD+9/EgfDIfvBzNyOVvDlskmiz2mLFkY8DP/nKM+V5AKGMgTfG
	qfX6AcK6cd11bIjennZ3Q+0pgBWV/vCooDfcyMKd1429Fypn//t2HAhLxvgQts60+PEWD39DA+C
	WaboqFVWdzE9VnEBrGMLIagKjyKpLRHfQcoMnAV6ZFxdil4XM4kLeUlLnoNEAvN+EP1gbAc+VqL
	0wh8B6PhKUzCalCRxSdMHl+3W5TD+6ZuJNLVveni0rhnYokLOUA==
X-Received: by 2002:a05:622a:5c9b:b0:50b:483d:3669 with SMTP id d75a77b69052e-50ba39457acmr211447391cf.62.1774945209494;
        Tue, 31 Mar 2026 01:20:09 -0700 (PDT)
X-Received: by 2002:a05:622a:5c9b:b0:50b:483d:3669 with SMTP id d75a77b69052e-50ba39457acmr211447211cf.62.1774945209099;
        Tue, 31 Mar 2026 01:20:09 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:29fb:516:a90f:8dda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887c536a7fsm20175995e9.1.2026.03.31.01.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 01:20:08 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH] tracing: always provide a prototype for tracing_alloc_snapshot()
Date: Tue, 31 Mar 2026 10:20:01 +0200
Message-ID: <20260331082001.31345-1-bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=INwPywvG c=1 sm=1 tr=0 ts=69cb83ba cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=UYJXNk30lqNtw5BBiLEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDA3OCBTYWx0ZWRfX5ZNMQ5/nufv3
 uAm2vLhLz9aAOuwvyBK67MT43iFvYz0fHzs0OQ7tnUR97T+OXH+ix4x6UGUDQA+SdWsvDfu3KdV
 nFWNXhxrc6nz0t0z0LF2l+K1krT/5wBIaARoQu2mBHpGZSSIbzEfwwC5kJz85Zqkko9M3iGQreg
 S/zuBFYVK7u8NEj+men3Qr11OnDYBarItf1Nr6XAIvMeOiHcIbneCEJ2sPorpo4Wj/saE3/YFDh
 tFOOQWo6FUxFybdrrpcNW3dRWRUdC39Ieie4hkOIaP7ID6RueANg4q63/Z97guaYnAj0nSLmC6h
 8sCcn3+wRVtTBIiAcl6IxmQ/VkMd8Q9HzhV7SUgyBtIIvr5rBsv4c4GK0I4H6ii/sN70MyJN9VI
 QvBe40trlOuvy1PfF7nLpIufGofGuh/nT+rYf6A17GSqJFQCAWJG+lbr7/X1boBYzqYzf37ieVA
 JZLqXtZ9FgmQh9ewRsw==
X-Proofpoint-GUID: -QVk07K9AnxcITcSik21ciOQj5gc3E9-
X-Proofpoint-ORIG-GUID: -QVk07K9AnxcITcSik21ciOQj5gc3E9-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_02,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 clxscore=1011 malwarescore=0
 impostorscore=0 adultscore=0 phishscore=0 priorityscore=1501 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603310078

The tracing_alloc_snapshot() symbol is always exported even with
!CONFIG_TRACER_SNAPSHOT so the prototype too must be always visible or
we'll see the following warning:

kernel/trace/trace.c:820:5: warning: no previous prototype for ‘tracing_alloc_snapshot’ [-Wmissing-prototypes]
  820 | int tracing_alloc_snapshot(void)
      |     ^~~~~~~~~~~~~~~~~~~~~~

Fixes: bade44fe5462 ("tracing: Move snapshot code out of trace.c and into trace_snapshot.c")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 kernel/trace/trace.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 6abd9e16ef21..e8612b8b0a34 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -2275,6 +2275,8 @@ static inline void __init trace_event_init(void) { }
 static inline void trace_event_update_all(struct trace_eval_map **map, int len) { }
 #endif
 
+int tracing_alloc_snapshot(void);
+
 #ifdef CONFIG_TRACER_SNAPSHOT
 extern const struct file_operations snapshot_fops;
 extern const struct file_operations snapshot_raw_fops;
@@ -2282,7 +2284,6 @@ extern const struct file_operations snapshot_raw_fops;
 /* Used when creating instances */
 int trace_allocate_snapshot(struct trace_array *tr, int size);
 
-int tracing_alloc_snapshot(void);
 void tracing_snapshot_cond(struct trace_array *tr, void *cond_data);
 int tracing_snapshot_cond_enable(struct trace_array *tr, void *cond_data, cond_update_fn_t update);
 int tracing_snapshot_cond_disable(struct trace_array *tr);
-- 
2.47.3

