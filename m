Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D023F9F48
	for <linux-trace-kernel@vger.kernel.org>; Mon, 15 Jun 2026 14:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781533032; cv=none; b=Uw9plJRcyEDXe90vECNGVv/hPU1hD9uBL5f97YmShCXQn7vR1jdBSsSA21TtzGpmFhpcsKoOqVsbyRd1tGnKg/E0iuwGOEzsxgPGLexfwygbP4FKuhxK3BXRPpx47FfDnwEgnf1tiKSg4fvlk3GRXKf1hPPOO0XvcJDrg6S9jV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781533032; c=relaxed/simple;
	bh=QHuJbNfZclwAUqET6A1WfhO2/jqOdVEs9Fpda71LKyc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nntLhhbJgxN9Jir0/jSIEAKpfnI85Ewygf3Sc6hAaRMplcacWavFNNlAsebXLbSLDEEr8hy6m3plNWhDYNULz0uN/ZB5CQL2a3HvuFRzZgQj2F4mmOlJz1K/lqMs9PK7bxvz5zhRiz7uwNTIfWRleUh6cOeejMgQ8T6wW73Q09I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RdxzjBx3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=R5epxaYz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RdxzjBx3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="R5epxaYz"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65FCZKxb4116505
	for <linux-trace-kernel@vger.kernel.org>; Mon, 15 Jun 2026 14:17:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8uZNp+VwhVSjExHeT5LvpX51VbIe9sjYP4PbK25Inpk=; b=RdxzjBx3vPSj+4Fk
	O35DdkAQivu0MDI4s114/uZR73tLeO83J7kWQRaZHoDsGMu/s3AAQ47PCbXNb3R5
	J9cKCet35nYh3DS1hF/C+/wPAK3BTFKQXOao3yjV/LqwDM3ngWiZ/BqqQAcgxeGB
	3NbZazocOJsCvFX64vLjy2vn89JTHc+PqrhJjyaa6GQrT3bqNTv1nm3ff9Ih5mDM
	dA0uP8P2iNNYXujqpMTDIVdpfW2GTYz1ogziayDvbckS9Z+2CfnGIgvAOiFWe2lm
	YQHBR4Yq1KGCkPJh5JS6A1kydnx95EIt404FO+CAV8rmcjhAABvmfyUbOAwblvXI
	cjA9ug==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4etetjs4e3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-trace-kernel@vger.kernel.org>; Mon, 15 Jun 2026 14:17:11 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-36d985df4cfso3988128a91.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 15 Jun 2026 07:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781533030; x=1782137830; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8uZNp+VwhVSjExHeT5LvpX51VbIe9sjYP4PbK25Inpk=;
        b=R5epxaYzHXJ6zVCrvYdwBM5X91xWdgQ8bzATIvo1Nmp2fkS6Va1MxY8sMInrh/3dsI
         BuFoqkA6WptDASu/M1BdOvbo7Hr/DXdNBGDYrYCk6om5/l7abC5wiac+lY625xT4XWwj
         77+CromcPBWRuc7o9bW/Oa1RKbh40BFaSmfXK8fPWsVa1WvaDFN9yV3ciVgv3AdfCe1C
         7cRNwULl/HK3W82MzYX1/FFn8xEMPSrQjvgmD+tOdz5ajL2TQ33eDyrrhS1jK7MTqSIP
         q9ohA/R1ikubUWBZCEJQLycj39kDISYMxbQGWRObFay6FjD8GqvQX7bwdWQ2ndKUs1rR
         qOdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781533030; x=1782137830;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8uZNp+VwhVSjExHeT5LvpX51VbIe9sjYP4PbK25Inpk=;
        b=WRsqk+PyY8fFNIrV0P0CFCLR49lwrO8xyT3mGLDty4jOv05l0aXyJn6GAeRyo8BCao
         +wHVWIcaTqPass6vjLNeUjtZlLfbF3dn3nq/5oWndLOVAmyF6Q09WWGTBhsUdzRyNmKG
         HQ28/zygOF5+sp+Ft5HdN9sv7eKDhyFKqvbnl0JoUkg9AZinxABRy/PhASBgd4c0SDb9
         CukS+uxtorOP0QqHDPKLwhiP5eol1Cy+D5NYjsohW6OBnhyTIL2Xd546pGDtUYawZh6D
         mKTG0/OX2DoIkqF5K6y20lT4V8/iPK/RzR9YeEOP7/62lLOZuy0XqRroFFy+XchK1VOV
         ZmWQ==
X-Forwarded-Encrypted: i=1; AFNElJ+7cW+WnnLQ4Phg6E9VvGMYvywnfd+rG4MQ+8b817muB6wWhWAU/LSq4g6cS1cLuu3h552YEkLpuNaxtDExLcsIg9k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIU6mvU7RUIFJUAhMkslsk60qHTgn927kl45hg/I82mjFuW1O4
	uqCXIVUlgrP+7Y3MYT1Z9Y+7FfcUddjS0OmSQVnhsHXzSyBo6BnDrkKUQZH8cfSeXMsxLrF886T
	QwrLa3VhnjPkWKRxHCwhkeRVEMEu6coCUngPfgfio2iKYAvkiENmxY/r+SQG1APZnYhp4bXRbQw
	w=
X-Gm-Gg: Acq92OFkJH/TAlo7joLW6l93XMnVzvj/tKUc1snFDNoEpVp2CG2bnfTaN5Cb4VU/1ZQ
	pFfDN+44s438JRKLmSo5E4APR0FIS8KmMrtLCJVVdvzEeVQSOZ42IHCzKsYjt69AQFAR8KTKyWK
	kJW78fh8lCcpM/aS0HswPhnsmchZVydIaU8Ne+/UmSvGmzexiWl2s/qRXl/GFjuFBtlsdNs1KZC
	s9iW9SMsR7poInV3772oTTE/YJ1m0VtxEqHhxgBvQ87j9L0X1X1iMKS3iDnAgA6THymFBKR0hGD
	uJRwu+ABmH0M0iMVu0TSvz5iaXNWCS7ixUSz+3FClpuc0yqd1u5qSZHF/NbaD4q9rlPT6kQXQtq
	uBIhaEJCb/0rubt5H2VfPx7VyGiLPmjfkjaWJxpmFYwExG0xXOtcI/x4=
X-Received: by 2002:a17:90b:57eb:b0:36b:ba9b:7efb with SMTP id 98e67ed59e1d1-37a01a3bfa9mr14972748a91.5.1781533030386;
        Mon, 15 Jun 2026 07:17:10 -0700 (PDT)
X-Received: by 2002:a17:90b:57eb:b0:36b:ba9b:7efb with SMTP id 98e67ed59e1d1-37a01a3bfa9mr14972697a91.5.1781533029836;
        Mon, 15 Jun 2026 07:17:09 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-379e8cc467csm7172476a91.2.2026.06.15.07.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 07:17:09 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Mon, 15 Jun 2026 19:46:52 +0530
Subject: [PATCH v5 1/2] serial: qcom-geni: trace: Drop redundant len field
 from geni_serial_data
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-add-tracepoints-for-qcom-geni-serial-v5-1-2efa4c97e0e2@oss.qualcomm.com>
References: <20260615-add-tracepoints-for-qcom-geni-serial-v5-0-2efa4c97e0e2@oss.qualcomm.com>
In-Reply-To: <20260615-add-tracepoints-for-qcom-geni-serial-v5-0-2efa4c97e0e2@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781533020; l=1611;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=QHuJbNfZclwAUqET6A1WfhO2/jqOdVEs9Fpda71LKyc=;
 b=LwNaeHXnoABG3t/pEhTPPctahozCFsxBP/IKBq8jFegkPwyzPiCxL7Yo7rTJOBH3ODTmsdmzd
 FmB9mHxSnI+BXmKaBGOvcbCvfn8r9msx+EOYbf0Ftnnq1DKmQmbQyCB
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDE1MCBTYWx0ZWRfX+ikA/Hmm2ksZ
 zCze+4eLHy0bgdFeaK4Y8UHL4HdDLwN1tG7f2maRCh8GPxTcrIKg/uC30QSigmLJWEj2k5ZadFd
 6FaxmfVtWt9/sJ/jxqMmbWbaEgabJhgLMscFUU+6Km4dPPbj/Rk6loMkiIZt5t/Vg1ueOSAvOXx
 yPKbhsh4QvM3p040vBfHhqgYC46hEE3yH0o9IRtAWoO1FfQ/hiBm0uACMqIkP5aklz98j4fzuAy
 pxbSczb9gmnmKCAqN31Mv3BPYDxt3xgySvp216aXBpDWYXSpusaFyhB2RP/NUO6s4ImrL8giJ45
 u/u/aR4GzF1Cj5G97jS+Z/JEFh/qvm9xueJwRE1nUZ8U26AYA1Jqq/efKnFEd8jHnFUTEun/s48
 HpaD3Yi1UKnlVg46IH/PpDeq9o/wfJkeAIZoBVnssLC4cCRO9hq0w1h1RwhZ3H6J4Cy3IMtaola
 /nRbqtkwk5G1+WRYU+A==
X-Proofpoint-ORIG-GUID: SArOPMqSjEoRXEoJFijm3HenbZi619_9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDE1MCBTYWx0ZWRfX+nckMLcCgHDU
 qMzGd36zNAnhJkhQbEXBlsdBAk7Zx8MlaISRMb150c5rfPiDh88NQ8r0Ain19XxZ8K3v9zmulEM
 OAw8fChd8h5SV5C1vxAZJb4QvKSWVtI=
X-Authority-Analysis: v=2.4 cv=HttG3UTS c=1 sm=1 tr=0 ts=6a300967 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=lKnyCkGSJWauGj82uDsA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: SArOPMqSjEoRXEoJFijm3HenbZi619_9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_03,2026-06-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150150

The dynamic array stored in the ring buffer already carries its own
length in the array metadata. There is no need to also store it as a
separate scalar field in the entry struct.

Drop __field(unsigned int, len) and the corresponding __entry->len
assignment, and use __get_dynamic_array_len(data) in the TP_printk for
both the len=%u format argument and the __print_hex() size argument.
This saves 4 bytes per event on the ring buffer.

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

