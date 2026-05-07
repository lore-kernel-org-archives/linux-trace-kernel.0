Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4402D5926
	for <linux-trace-kernel@vger.kernel.org>; Thu,  7 May 2026 03:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778124539; cv=none; b=FhoO3kxS+1YGJvIGCq3/Trxh8UTCpPLOJN5/QY6tau7L9fD1fwJWI/6dYbaGC5rj8OqLyHyIhEZHY5szR8ny4ymLeixo7391ESCRmNKHo7XlcwlH4mfmFLHZhHM9pCg9Hr+xhYtQyFm0xu3K5zgDbTEhESVjeaaTvALwoEF4C/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778124539; c=relaxed/simple;
	bh=gi2ObkCraQrs04SQ8ny/M/6gQkScLLeAkIE525W0jVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rl4d9FbiWSFmO9/Mf7iYhzDj6wrrllg8zgaJiPSFf7HthdP368kFFyxmMKgfafldt0bTUtecZ7Xw+VfzzPZ/nAjfKH6qEL+SJ3dOiW/hFzoLnQC1C17P5sT28wX2JX/YZRRLnFEgrFlca4N1odpf3QGXtcGYwm94Azrm5sSgTkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FBga6zSa; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fWqAuJrx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FBga6zSa";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fWqAuJrx"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 646K7kvE3036592
	for <linux-trace-kernel@vger.kernel.org>; Thu, 7 May 2026 03:28:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3gqWZYqm+m8nGCsJyj2+TkIzkgEHJKGfXdeU5g5E6Bw=; b=FBga6zSadj7d/WdR
	2qYBsk60KzIOx9MCi7xA/m62yLD1w+T+Uw1UxbwYj7MS0q90ie+/sJs9xO+83SLi
	iIEY+Xo8b7eT2Jx0yltelgMBa5ni+zSaVD1sQvel+i7oXvV/GqbgY2l4bZ9krtgO
	2lDrl+uOZbI7FppHdnhEi3dO7FkdqYsJHF95GOF1zvVyhrydPSXK0z0H1WUNOilD
	Zl5i1+NvF4CAlnoOwmdvaWb3QTmzjAU8hCB6wesRoPvnG1foIVr8x4RnV5yIl7Oo
	CoAqDsaQcfqYxPL/dkngQRV0DaeJSpizvLYgErMS6ZZUlLQlBqI9++FUym9VXSin
	DjYonw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e05bf2yu2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-trace-kernel@vger.kernel.org>; Thu, 07 May 2026 03:28:57 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2f485961555so1933700eec.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 06 May 2026 20:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778124536; x=1778729336; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3gqWZYqm+m8nGCsJyj2+TkIzkgEHJKGfXdeU5g5E6Bw=;
        b=fWqAuJrxaIff0+TfXSgGXkYmkX4IqCwFY5/jIp/bCsx6vAdfsYI2dqLysBaRfhVEVI
         +tc/hooq4HoBdiVKO5tU0Z+l7oPvx6WgkHyyrR2SGxLw/7u0dAeEjL1LkmzYo7QfzMcp
         pQhr2QPPnCbbI6Toz2/ZMYLSQxK7TSNGq5SrUFAV2gU7GSkT7lr/54GSPzJuRtKI4E2H
         Ua+C1vHtbYKWWWiuKvJeLX+KiorShj7iOryMK53xibnz5pJznjsMnMMvtQ+//ADq3S8W
         HqgltY3922jQVNfqbbISHF1NoqlJ/zHpHfpufF+3OydA+cBBA0wOeAuj0fhfietjrHFM
         z5dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778124536; x=1778729336;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3gqWZYqm+m8nGCsJyj2+TkIzkgEHJKGfXdeU5g5E6Bw=;
        b=BkeOmQcqALqkJpMj11Gu1DPK+94UZTff9IjYnYftMZ4o6oK9qITWldtsAyF8b8hyHW
         WhyM2J1OpRPtAIz8Se0p4WaFDuLYpUHuXj4jCdhM9cWuowPf4ygRqoAXh1LJe2UTrstR
         +eUxVuj0Mi2BpLTOp5S8sTQw4H/Tc7Omkji8zL6Ee5gugWRGWwhIK51+DSi/TZP2CtWM
         PfqNgavE6m2Q4KZGWz/wMg53sOaOHsL5oPq1JCBQxaF38z1IbPePh7yNpIFwPrwl/PDJ
         iMO+jiz4b/VsBLJkbytExN1PBb2Y2oxdScPqJeWVf8xFveripxqH3yVGIynl1wLUMI1L
         LBOg==
X-Forwarded-Encrypted: i=1; AFNElJ86bWKZM+3CEFZgdR48WWCcF0nSUnnUgIRG8cZQpDQaOCaLHfyfcTVtlseaIGWdWeoIxY6ULU0PJAh46pJvEcdCZoo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9f8o12JtVGvNd0TqAGa6YfFHfJQzobgF5i1DQlAJq+8a4Xt+f
	3lsxFaVJL1gwF3qjhC0mP2ekp0DXNjVnk8dzwrFzDMRgZV5UPBTUUpUt3PXP7JAyF58cl4E8e8p
	eiIEl8jro/vWx8KRE2jkvwL0hGkvVH2VCYJ4sHhsCC0rypDeYV+gQc1fU6ZK30pp5sN804oSVda
	aQ0AllqLk=
X-Gm-Gg: AeBDietcEJrQRB5V2ORw3FrkMxj8IJNAFVesXwhDonrVYWEuv8JrnqAamKqCHyzbuMP
	gaEEMlm404SptetlyfmJl2bINMLWwc+6JxXskInZP8Kh1bqZ2QmWcIhPiRotTXUXp2AKTLCVlqL
	Nb1AJrWp4On54H03A4iJ4s4FS1xzdMaie83z3Jvx8UpP1VJQuoDN5dpnXIL7IPnWwt9cFM0Dc4g
	TZTRnG6M4G5b7pjkQonuuAAVgz6FqImnRHcH+YTwx3lyRbX33XyX6zhy//smpEgfEybH/fp0DGy
	fxaJxRfD0yH7+/7gPP6uX1QjYA9nysXTrSOGADOLm7wjwlOHqFTD1Df6XRM8QlXuWcpOXSbQPQB
	N4sTM1U5/xIHk2Vpc7sjiyTTNnliIm7vNfmi0lxo7i8KFeHRcgshSnclMgekP4Sk=
X-Received: by 2002:a05:7300:cc90:b0:2ed:6f94:9d94 with SMTP id 5a478bee46e88-2f549f5f684mr1839114eec.19.1778124536030;
        Wed, 06 May 2026 20:28:56 -0700 (PDT)
X-Received: by 2002:a05:7300:cc90:b0:2ed:6f94:9d94 with SMTP id 5a478bee46e88-2f549f5f684mr1839097eec.19.1778124535413;
        Wed, 06 May 2026 20:28:55 -0700 (PDT)
Received: from [10.218.14.97] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f56fd8fa8csm5660643eec.21.2026.05.06.20.28.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2026 20:28:54 -0700 (PDT)
Message-ID: <3ab480af-247f-498f-95f4-ab17526876a5@oss.qualcomm.com>
Date: Thu, 7 May 2026 08:58:49 +0530
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] spi: qcom-geni: Add trace events for Qualcomm GENI
 SPI driver
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
 <20260506-add-tracepoints-for-qcom-geni-spi-v1-2-c957cfe712d1@oss.qualcomm.com>
 <afvltFJzKLaO9weP@sirena.co.uk>
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <afvltFJzKLaO9weP@sirena.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDAzMCBTYWx0ZWRfX+jhgACt3nG8P
 n8Gs++f2Jncdel6udc9DLAxPHFCEgiGkoYeid6WKk2mcU8JQsB2/vNzcsU0HrkjhxJsk81swKJ1
 4QSELu3NICDj0V4t06n3E0DOWLhWOQXCOT3Fm/R/tvgoGf3CBehmA0vunTyWEBG+KlgwQwq9EI6
 FIeLUuR+t1p7IwdYtAEmae6YHymsbySZPkz/pJB3hHbxp469m6++gaaTX0mStHe5kEcRl/GNoNn
 AO9Tmkar1o6f4VdeWT6Z6CFOd7Q0G2HHqDFjar8tf5cI8Bp7KM/msivrT4J/aR1urbHxea2kAC4
 rP+6JgbimWfe4JRQqSJlIohGBQgofMiGGTXjMbmS4RFiX/aR2lal9vHXtyhsl7aIzYAHrSEOnXp
 Ywqr/gFMfL97J6FbdF8+QG0r8oKcoHbzbMXHFNXWqntIsdtjhH8K8x3l/wJkHedn9ihawTlCx2K
 qTE+CPXtWTg9ST886lA==
X-Authority-Analysis: v=2.4 cv=PqmjqQM3 c=1 sm=1 tr=0 ts=69fc06f9 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=1VmPbvypwqz_8yqDh7oA:9 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: jiULrdKyUTqNRdI618kfnWf0OMN6rgtZ
X-Proofpoint-ORIG-GUID: jiULrdKyUTqNRdI618kfnWf0OMN6rgtZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605070030

Hi Mark,

On 07-05-2026 06:37, Mark Brown wrote:
> On Wed, May 06, 2026 at 10:59:43PM +0530, Praveen Talari wrote:
>
>> @@ -717,6 +726,7 @@ static bool geni_spi_handle_tx(struct spi_geni_master *mas)
>>   		max_bytes = mas->tx_rem_bytes;
>>   
>>   	tx_buf = mas->cur_xfer->tx_buf + mas->cur_xfer->len - mas->tx_rem_bytes;
>> +
>>   	while (i < max_bytes) {
>>   		unsigned int j;
>>   		unsigned int bytes_to_write;
> Unrelated whitespace change.

oh its my bad. will fix in next patch set.


Thanks,

Praveen Talari

