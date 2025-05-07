Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D150212FBE;
	Wed,  7 May 2025 07:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746601706; cv=none; b=NFfiH0QvmgFPNkcNXqPExrMiJ2ScTsDgeDFVgAW3GnVAeRg7B8Kld+64kC7EmULoTnBsCZ77JcI45I50g35zMywqdFot6yLa3bYSXYYVogIJjmCB+LG+nv38f2m28L36IKv27Jwxo+gaMOh5Q2H2EQX3nbNms5g+JjcSdxqGJfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746601706; c=relaxed/simple;
	bh=FfcO1bmJ9TwVyGmwWvdOKtV4qaOdRW/kxoyTI2FoTcM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=E+Fm8BQv6G/OUKTGTT/DL0KIuDF62t55cKQ+qKL67rgrn6Tf83Jqil7AhKTdEgX+gDgC3M9Eh52oQguRyD+MR6VBa7JxWzvqR/fCOmEqgYGpO4Y4V+TyR5XY5gPgMyZYPoD0j+aZRT0rwHWlMkWuqA5dRKSwLkxQyUFsmOlaZgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PgWa8GUl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PgWa8GUl"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5471HAQ1021674;
	Wed, 7 May 2025 07:08:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=rE1RR5SpAq6CGFJwO2E2zk
	Hp8UtvOPLpNZiWJ8e/wvE=; b=PgWa8GUlHTOq+xPAsJBz6vF2YfkyFgp0l871k3
	Xh7gPmmpsm9v9DhRgVoATMc1HO3Xvk0/RZZsefpzHlmuv78yeNnEjeQX4atDloWK
	4o7tYMEBO4q0kIe2ENSO1dvnbHGCS7mXPmpudO9bocdLbf9/LMBKQGTE4FX1AqWY
	aARDd2NFMFiZsOmyoAAJLHXzk8Uy0MayNVnnadBO280v2f1qkcUBIkxYJekEjRQE
	lDS+x4ecRLPGlHDg0TDWsg3M/2W4HsOiTUWmm+KPH2If95FCHIfEbiWijOprzz58
	aky/L1qJi7ZzuwpQkSifzppEkhRPwctSzCss59b6dMLPix+w==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46fdwtuhnh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 May 2025 07:08:19 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54778Ili009518
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 7 May 2025 07:08:18 GMT
Received: from maow2-gv.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 7 May 2025 00:07:56 -0700
From: Kassey Li <quic_yingangl@quicinc.com>
To: <rostedt@goodmis.org>, <mhiramat@kernel.org>,
        <mathieu.desnoyers@efficios.com>, <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>
CC: <quic_yingangl@quicinc.com>
Subject: [PATCH] scsi: trace: change the rtn log in hex format
Date: Wed, 7 May 2025 15:07:14 +0800
Message-ID: <20250507070714.2387602-1-quic_yingangl@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=VPPdn8PX c=1 sm=1 tr=0 ts=681b06e3 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8 a=BHyZBowvuSOj8lr59awA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: DNku1E5f6o6xlmQLYLVuw0UBWXxl-rQX
X-Proofpoint-ORIG-GUID: DNku1E5f6o6xlmQLYLVuw0UBWXxl-rQX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA3MDA2NSBTYWx0ZWRfX5aaex1hIECWg
 SKxNtxhz6wReChrG//xir3VItYZzuyawsnj/7cqby8O8DDko3Hqg8O+ARv0SBOUhH2ml0YdzSOs
 J664je4LJepbWtJq1gCRHnKxbZpH2EJmiB54LFeFvKnhopoOFOoiRjCjalZtBvS5ASKA7vUyWUS
 U3zyWrIy2oAmqyt7oxRB5CjEyBdSldqk+OyEdgKhpK+EcyeQlfNOgTSPo2JsqO9e3AzrdrD4F3C
 VruygE58+ecy29HMSD1xgF6fFvLMTEMwcuc493K1MaVxKQHCDUOX5eZ62F3o6Mvnyi0LdFoTNZQ
 DnnNUvlEcHTyxj+4pSXmMnMQalFS6gVHsC1crGc44HIrClyq5iWwnKV/jdnM4YkOBRpbZbThebz
 TpseqwYujiobjNkDwiqktkY57TSfsoc0uDs9XlxiP6RKkJWJtTZZ+kv5ecRsxK8buXshcvT7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-07_02,2025-05-06_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 suspectscore=0 adultscore=0 mlxscore=0
 bulkscore=0 clxscore=1011 lowpriorityscore=0 impostorscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505070065

In default it showed rtn in decimal.

kworker/3:1H-183 [003] ....  51.035474: scsi_dispatch_cmd_error: host_no=0 channel=0 id=0 lun=4 data_sgl=1  prot_sgl=0 prot_op=SCSI_PROT_NORMAL cmnd=(READ_10 lba=3907214  txlen=1 protect=0 raw=28 00 00 3b 9e 8e 00 00 01 00) rtn=4181

In source code we define these possible value as hexadecimal:

include/scsi/scsi.h

SCSI_MLQUEUE_HOST_BUSY   0x1055
SCSI_MLQUEUE_DEVICE_BUSY 0x1056
SCSI_MLQUEUE_EH_RETRY    0x1057
SCSI_MLQUEUE_TARGET_BUSY 0x1058

This change converts the rtn in hexadecimal.

Signed-off-by: Kassey Li <quic_yingangl@quicinc.com>
---
 include/trace/events/scsi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/trace/events/scsi.h b/include/trace/events/scsi.h
index bf6cc98d9122..a4c089ac834c 100644
--- a/include/trace/events/scsi.h
+++ b/include/trace/events/scsi.h
@@ -240,7 +240,7 @@ TRACE_EVENT(scsi_dispatch_cmd_error,
 
 	TP_printk("host_no=%u channel=%u id=%u lun=%u data_sgl=%u prot_sgl=%u" \
 		  " prot_op=%s driver_tag=%d scheduler_tag=%d cmnd=(%s %s raw=%s)" \
-		  " rtn=%d",
+		  " rtn=0x%x",
 		  __entry->host_no, __entry->channel, __entry->id,
 		  __entry->lun, __entry->data_sglen, __entry->prot_sglen,
 		  show_prot_op_name(__entry->prot_op), __entry->driver_tag,
-- 
2.34.1

