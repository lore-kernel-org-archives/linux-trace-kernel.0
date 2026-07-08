Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B7F3890F0
	for <linux-trace-kernel@vger.kernel.org>; Wed,  8 Jul 2026 10:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783505208; cv=none; b=g63Wh4sb1tOFDi9LAxIfIoF00pBVAcdHvRP4sN/CHjj877KA8HaLTzB9rPe1gpX0U2Zogas5z9dmoGqA3NR2U1YQvI4FsNaBO7IWGbnEsvnoQPv6O0XMXYZYxolmsdo2VXGqDoKYWJuf1u95UcorJ1d6MlgV167SHSXTh8z1DIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783505208; c=relaxed/simple;
	bh=EoXA71ibmjqOvkjzzpn8D9oPOeu2IQ1QWWUCUKERV9Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PTywFVWwjumzFTDJ5OCYfBwBLIaf3apBDrfsit0fD64i3LzdGdIHUzg4r8GCn2aY5C234/ZoBsR8GRHTvar2AE5SNUT0tK+qqMjXkdfqx2OmF1rpup8stmMQ0gZAoUl+IxBuFyMRmP2/Z5o24a8zmhVji/cMCDFzHKM9znpJ7e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KVkjqRco; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HfkMJBiv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KVkjqRco";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HfkMJBiv"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 668890q62083256
	for <linux-trace-kernel@vger.kernel.org>; Wed, 8 Jul 2026 10:06:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RKyVHN/hTdPLVDp/F78lAoGgPhhbNMc9fh34edmUY8g=; b=KVkjqRco+xZ5SIER
	XguwaPQhCE7knmso+6amahyT25hzdC6R4Ei4ojBOrvDSt5ElGa5+5RBTdL8GQnE8
	M8prhmMyVJaesmiAwzXv8eS3OKJVA3o6U1/KG6r/eVyITIbuoR2Cwh8QBapVx8M8
	tgHGudz8IiapIFDSf3FWkGGWWHw+JRG2ouNOF6Mp6FmaZ7XUxAChgQyAzvC1jaay
	Y9xNZIyl8ChxrVg8fbGyHkreHsewTLf1xACEJMoeZF+/QJQ43lCLLqYPMCTF/9s3
	qkkq1WAhmFe4elYmvZ9bkmLKIQVDo0bVgiGhAZATT1/DH+sjlvQ7dh6YzYpB/J5K
	o3Tdfg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9gqw90x4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-trace-kernel@vger.kernel.org>; Wed, 08 Jul 2026 10:06:44 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cacd6d37edso11423875ad.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 08 Jul 2026 03:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783505204; x=1784110004; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RKyVHN/hTdPLVDp/F78lAoGgPhhbNMc9fh34edmUY8g=;
        b=HfkMJBivbQYs4ALMNdt1SqhVM/WDZuqeKDguyGwtuMDg4EmoB2pD6ybbTI9RaKVxxk
         /8Ne8K6V9YGAAy7oeNt6yeBc4x2amB36PVrd2QUbVLX7j+PGtjep6lB2lcwp5n6VAGnr
         n4WBX+vuoe+5mqn+9+QMoUcTSm2XjIiD1UDPO904VAWQhEffX/aH3/ubtYxobjO6WDhR
         vXXgaFsWC+hQ7oEUWfo5WZtVh0XqbEwrxdE5EcXSSsZAGtpntBtWi8Y9VFq+McZdjUwI
         oF/EkbS1CBz9WgE+/L4K9wBIukSkc/PSRtsc8stLmXV9Dy+vauSbfBgXY4MNS7bCr7+1
         AnjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783505204; x=1784110004;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RKyVHN/hTdPLVDp/F78lAoGgPhhbNMc9fh34edmUY8g=;
        b=mZjFvXYqON0grKWXQvOSzl86y1Zqvf0NkQsfbrIVAkGvA15ExnuiD444D5I+YS+PGD
         WLyotRrLZ7Yb2Jq1WQmGgLq5+Y4hVj/WeKWkubADn9LlVLjnrbuSqvvrxVlMCUet7Hfk
         4GVoeZvq6fGtlWGq9cZ1bYEjamporhMLEd/bwUmjqXV0ZMupzchoNumuR1PIoLjYRQzk
         cRVzRk6fWj6ODlGfoYkvzFT/kzNQLpxVGUVjUk/3HL236fTto1Ma8JDAbSg00HahVDjU
         ItCrpZJhovsibF7GNJgiZnYxTUiMv6Vl+CkzQddFjAkFTGCQq54PH48ZbwXNmameii3j
         2CAg==
X-Forwarded-Encrypted: i=1; AHgh+RpcX4kRDFTK+Rm1L4vPHucg95NSM02XokazNmjtEA6cgqajOmbr5OOhZA7RYR4ZCbujuqLMWRyGYmYteK7rmMaOQ3s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxF3HNft3WB4vJNRtxToldOqKU8VEwn5Bg58P8AtygE9xJxExyt
	/wPD/grbT2UOTPs7cx5Oz1NFgnJ1ZVAmyr7M7hxcyTZIiIXDTChL2ZoDJGOa1eM4xRu9gL6tkPM
	5oTb3DVONs3TMEEzR+eAQBEsnS1cEtWWw4ymbwvrqLAnRdVUArK7S4FEJBM8+TDU6c5o6R/+/OC
	k=
X-Gm-Gg: AfdE7cngsuwZIj+c78lLDRJVPb3Ov1G1Ml3grMyUbDU2spVdM7M0cBU36QHT4FSVwBE
	X6jbVBORMPf08pDuWiQgErlo9wvfn2aSDk7D2gNLtAZb3t1kB9rzvnOm+aIHyfpjnDp7bteDA/j
	NKWVfb8nzPoV/lmF7/uDiVTjf8gYaYPhK4YIMYKjfy5aAkv4xPlZ80PCDCBBbwjCB2K4VqSbEBL
	oceRYKQSA1VCi1cXMQXIXwIzXRpsK16oZ3VFVQfN38+BgcBzuTsPGH5Mx1FZPI3DH3Ff9aDnBBq
	DXJ2eGZhcbFcNzxNmG50GrnAjgjEXE2h5uhdi1X9psfLsg4X9b6fQdCvFuwkoNnAtFkj0zeD9ah
	5IDjD6Rm4XbeWEuQXMXW6a4cKBNyWnI9Tpm79Tik40UZr
X-Received: by 2002:a17:902:daca:b0:2ca:c4a5:84bb with SMTP id d9443c01a7336-2ccea3a737fmr19597755ad.38.1783505203760;
        Wed, 08 Jul 2026 03:06:43 -0700 (PDT)
X-Received: by 2002:a17:902:daca:b0:2ca:c4a5:84bb with SMTP id d9443c01a7336-2ccea3a737fmr19597365ad.38.1783505203310;
        Wed, 08 Jul 2026 03:06:43 -0700 (PDT)
Received: from [10.217.219.87] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bfe040sm25704505ad.31.2026.07.08.03.06.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2026 03:06:42 -0700 (PDT)
Message-ID: <7bf2e909-211b-47d5-9c95-fb1ebf917dc9@oss.qualcomm.com>
Date: Wed, 8 Jul 2026 15:36:37 +0530
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] spi: qcom-geni: add GENI SE registers trace event on
 error paths
To: Praveen Talari <praveen.talari@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Steven Rostedt
 <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        aniket.randive@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com
References: <20260706-add-tracepoints-for-se-reg-dump-v1-0-48bd08e28cf2@oss.qualcomm.com>
 <20260706-add-tracepoints-for-se-reg-dump-v1-2-48bd08e28cf2@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260706-add-tracepoints-for-se-reg-dump-v1-2-48bd08e28cf2@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDA5NyBTYWx0ZWRfX4BtGbolpSvEr
 M4FKxLeYtbuUYaD6k46UcAEeFTRhXMldAKNFUR0xl1ie6VYdWkP/sVNl17O8WHsHTBhKX80Zt39
 0+nuWXx/NumJ1trc2uP74yLRDM5f16x7bDRynLC83VUuSsrt277km56X3kzkDDg9Nmfr9mqYBu+
 Tgx7cv2VT9bltGMnGCHvWnF7Va/+Ta470YFjWCSR7BGCHDIXX7HI7wkjXyRWgX1Z3xF0vElQQJp
 0n8xPDLT0JmBh79t+r5Wp7wmokItMTcwA5z0kx6XTtXxQ5QNoDAANMwj2wfoXd3wb3ENxiFsqjs
 FxlFj50aWREkx+uiRhjR0wjCXOVWhLqRLwIhxLE5JeYgMBoT6dLnsjah8s3YDbYGy6TZifKlIze
 A8xtl5X+VtHMqgSrnybeZ0FdYcdiJ4XgQicigUGSyp1fx1eUD8qIhe37aXL0kVH5PH9eXZXYmYG
 yx26jkKFexuT+X+ytag==
X-Proofpoint-GUID: ptco01-cBnN23fDo0Ue4j2JUeqe7V_vA
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDA5NyBTYWx0ZWRfXyWCmgUM1T7FF
 HJPPG+8346krfBsj9oRpYnm4zEnQHBYd64tLBFtsedRBxQxQw4w2EOvN2YUXNlwv4Paq9RGi5/j
 gU54WFfg1CT7fVRc27hddwF7FISJsRo=
X-Proofpoint-ORIG-GUID: ptco01-cBnN23fDo0Ue4j2JUeqe7V_vA
X-Authority-Analysis: v=2.4 cv=Wf88rUhX c=1 sm=1 tr=0 ts=6a4e2134 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=wRhyhPH_MPSplg4SnB4A:9 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_01,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 bulkscore=0 impostorscore=0 malwarescore=0
 spamscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080097



On 7/6/2026 4:38 PM, Praveen Talari wrote:
> The GENI SPI driver reports various transfer failures such as command
> timeouts, DMA reset timeouts, DMA transaction errors, and unexpected
> interrupt conditions. However, diagnosing the root cause of these
> failures is difficult as the hardware state is not captured when the
> error occurs.
> 
> Add trace_geni_se_regs() calls at critical SPI error handling paths to
> automatically capture GENI serial engine debug registers when failures
> are detected. This includes:
> 
> - M_CMD abort/cancel timeout
> - DMA TX/RX FSM reset timeout
> - DMA transaction failures and pending residue conditions
> - Unexpected interrupt error status
> - Premature transfer completion with pending TX/RX data
> 
> Dumping the SE debug registers at the time of failure provides
> additional hardware context and significantly improves post-mortem
> analysis of SPI transfer issues without affecting normal operation.
> 
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> ---
>   drivers/spi/spi-geni-qcom.c | 22 ++++++++++++++++++----
>   1 file changed, 18 insertions(+), 4 deletions(-)
> 

Acked-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
