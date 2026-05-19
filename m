Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCDD32B113
	for <linux-trace-kernel@vger.kernel.org>; Tue, 19 May 2026 11:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779190502; cv=none; b=HygJY/kdXQtV+nlKzNfYUWAaiS09mVuZPte/6BnTG+kiSMUwDiuyeUh+G3CUP3YsifqBDkBJPWes6tkratHZJnxus4f/RDY1Jq48JDgnBy4kiMQj8/lyK/9wZDFU6eWZIuhxYnG9mIzaOxFf7gMKLY9tXlGBsOpUcmcEyT0eii0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779190502; c=relaxed/simple;
	bh=LQOxPGnXUTSOXlHpb6gPJJIavSLp81lHe+vVOxiyXCk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WU/z/0Fspyj1CLR1LZJ/QO52WQ5OjHsV5qKd0Jgxh6XWOOUlJ6E/UL1rtnaJenrCZe4nTlCaEbPA8y+K824M4J7gYxUsJocw0haAgopPjcacEW0FuFFKp1F3HjjPhUFM3C5UItV5XkXyu84Hao7IEaNg4zzxBfU6JyI+Cne0zgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Kyh/qtWK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dDxeuWdY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Kyh/qtWK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dDxeuWdY"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64J9bWD9254059
	for <linux-trace-kernel@vger.kernel.org>; Tue, 19 May 2026 11:35:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZAYCGahJcCtZt/TPl8oyzRpvSJVUQPm2nLTOqjEGls4=; b=Kyh/qtWK9Hfj3JEb
	JyqmPEbfysDE6W4/Gnik37xPy1t2776iMTbG1vm+O4CzM/a8dV27NfON3V9LFLsQ
	gxu2D1LLdsTdlxCfWYpjmKN7ws6lGf/zPAG7x/iNBjSs49sSgaUqBcHc4xf+NSTI
	9ALbT4TmTtHOmb8I3b33HmIySaFjGkKMwgjhtFdUttBQVn5RoGbLT2XrVjFEe+ZI
	rG59uHRQ3LKRxfEESHz7pB9TLJNm+OeIsegF8BjZLuSkYJQH9d5m9EBgfkbohLgF
	NSFgd4B+cfC3y6JPwjXvjG5SPoqX0yhcaAbEemXhspPuLNzdod0mm7hAJNmRfXJh
	5fM6PA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8h87snc7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-trace-kernel@vger.kernel.org>; Tue, 19 May 2026 11:35:00 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-50fb0b93e90so10724071cf.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 19 May 2026 04:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779190499; x=1779795299; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZAYCGahJcCtZt/TPl8oyzRpvSJVUQPm2nLTOqjEGls4=;
        b=dDxeuWdYlZL1Wt04tPOZUq0dTDNI1XbtVHGobk2lypY2CPUwl0lIvsda+/CCjWyM+n
         e4bleqtTjoC+/kdNBaz4h11Tfv8zQkIW1aoaRpiJmIW2LgfpIFYfokycD/w/psy2elC7
         VLwl11enxVVfNaUhXM/IpQtjY7fFQaQF8nnW7xYEsCA7VtBbN5rHiuyqyBJt739Fa+a2
         bUgbqBEkus5PNuHgjU8rKBhxohVhSL33tIKs5vEQ/xT8FVtDjQwFuztt4iKO5llwWLtX
         Bu6Hj0UkPEKGHwqEunDgD7wlQlgBo8liYwgwFtloKZPhFBbx/8oqAk6W6bLVV6jwFG5M
         Hd1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779190499; x=1779795299;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZAYCGahJcCtZt/TPl8oyzRpvSJVUQPm2nLTOqjEGls4=;
        b=VR6Rio63hPvh9ZIbE5kfAVov+drEvVtAUFEzg+98mzZs51qHtpIiNGyRMNcdc3k+lK
         zIU+gTXQrJ5AJo/xCaqoBFNCMgOf85OSZqfyYlzO9hncHqbxf0UrJH5yK7kT1DnUvSud
         OCyigNDygR7fdRdyy6KzjPdyIU+vtLDjYN1qygA1gWO073keA2/X8UXj3iPY2+vycT92
         LS9tZm7SqSxl9QiQk3rGnNVuZzuQ/44OWjJ9TB6rc6GGavWWN8bZTVASQCofbQeWWDia
         tf0GNW1EvYuSa7jRZ8VEMScKie5+U91597wCRIWNLhJZ1cSOXwGcijdTAbSBQqfXblPN
         Nz3Q==
X-Forwarded-Encrypted: i=1; AFNElJ+ehJ1rZv9/MAJnhdg0w3aQupJi+xS5lgC7MNLuVB/+cRSL8SE9FwnChlcY+5Fg6F8OG9vrsc15hRy3nbr6NDsYW9w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrciHJ9JtUhvSX2vYNuUtNbuEOwGD0reI7oiBzDjRI24CxnsrQ
	rNlqOrgZGvFNS2MYhajRK2TreU4oykM0GsL93x8u+3bO9XgHDr6YHmQPfmSjNtYFmFBeNETIq4I
	+284eCwFobNKSNI8X21picuxrnGjjB+42N8by1KQOY+ydNZN5IDdYrJ4Kl8IJiwh941I4yUg8J5
	8=
X-Gm-Gg: Acq92OFMmaujlboDz7mA/FDeTU7ueFne6DMCLSBdo8ny/7u8uXXP0GH2nPc9VIXAou4
	+SADJCBenFTQqJ6SHVtqyS0Ag2YZICwNo1N9G/P05FDHzKqoU14g/Oo7efPaBkvxkjgChB8b+4O
	saPAcspzhNHF03wQVKFu0WuPXCUBiwys+YE0IjU6E+2eIcLiSnIVRIVwjKI4M/1Zq1xJl3Lu8EJ
	ZacHWwOxAMHdY86qVouPOvgbUfBSrpmPMiFpq/Ua01v7t92fO+BYy6YMut0GbhkUzgLIygNuHuk
	1MgcOVgrxzUWzrTGsR9SuNbyvwtY5jyjzH1zkcmu89yO9OpszCin3zGCMaB/vXxkn0N3J1hbSTp
	eih352XqUdx86GzHNUaMXGsiG8QHPQ8kMJ4CyMcUcVFKxQk1AJmfPi4j69M/TLzLnKDY/txUl0G
	2YmTtJPu57hc/SvQ==
X-Received: by 2002:a05:622a:283:b0:50d:a978:6ece with SMTP id d75a77b69052e-5166ebd8710mr137485911cf.1.1779190499578;
        Tue, 19 May 2026 04:34:59 -0700 (PDT)
X-Received: by 2002:a05:622a:283:b0:50d:a978:6ece with SMTP id d75a77b69052e-5166ebd8710mr137485451cf.1.1779190499028;
        Tue, 19 May 2026 04:34:59 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd4f4dec855sm697523966b.37.2026.05.19.04.34.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2026 04:34:58 -0700 (PDT)
Message-ID: <5c59952f-72c5-4aee-a1a6-4b11b0a542c3@oss.qualcomm.com>
Date: Tue, 19 May 2026 13:34:55 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] spi: qcom-geni: Add trace events for Qualcomm GENI
 SPI driver
To: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Praveen Talari <praveen.talari@oss.qualcomm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu
 <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        aniket.randive@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com,
        jyothi.seerapu@oss.qualcomm.com
References: <20260518-add-tracepoints-for-qcom-geni-spi-v3-0-7928f6810a79@oss.qualcomm.com>
 <20260518-add-tracepoints-for-qcom-geni-spi-v3-2-7928f6810a79@oss.qualcomm.com>
 <12d8da90-f092-449f-af6b-14b9dd851f1e@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <12d8da90-f092-449f-af6b-14b9dd851f1e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: fbEJ5Gx_vyeNRKMSU7mxtCNHtUuNsU7w
X-Proofpoint-ORIG-GUID: fbEJ5Gx_vyeNRKMSU7mxtCNHtUuNsU7w
X-Authority-Analysis: v=2.4 cv=a9sAM0SF c=1 sm=1 tr=0 ts=6a0c4ae4 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=77sk_vpZ_aVc8lPgWwIA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDExNCBTYWx0ZWRfXxRQxQvmNPZbQ
 VUQa4kZNPpXVw1mnA5cgXRsaxafh9GDqOkEXkkj5gtKWu+IUipynXQHaYTOfLfK/eb/iyBqGyNd
 b4NuxHBQ+eyhHVNgEZxyCCmFDcHr8NWxql0LE2qnTWuUJ4ISp6HX0sPOBjrJMlYdxWst1EA58Rc
 hf0wrpsVnjlzFCiEqZDIM7H5rw/CqGPb0WT3hSfCIB/frtabF7mGeYAXQEdWksa2HBqiVL/K0l9
 1c8QvL1S9lFY5pJ979QfBqedfKUXLoZGzV8G7SKMIgRPPkQVXWgQqweHhl9a6A7FpfuwNtbanrN
 2wxC2Z7KkKNOgTf4esnwoKKoAOdK6rTAkfC01CwgXDe0DxMBgAmJi3zpAydYV4aMZR/6HFzhuPc
 wT5GGtfDn/yZcNU3XmrxyTK+KB9djQ2sQtgSJYUv781qOTGSt5lGaiW31rYX+kxR13KKxjIFQJr
 0Fb0hjoZU2/xyUfJy9w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 impostorscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605190114

On 5/19/26 12:59 PM, Mukesh Savaliya wrote:
> Hi Praveen, one question below.
> 
> On 5/18/2026 10:30 PM, Praveen Talari wrote:
>> Add tracepoints to the Qualcomm GENI (Generic Interface) SPI driver.
>> These trace events enable runtime debugging and performance analysis
>> of SPI operations.
>>
>> The trace events capture SPI clock configuration, setup parameters,
>> transfer details, interrupt status.
> Don't you need trace logs around PM operations ? ie. runtime and system PM ?

The PM core provides a couple, are those enough?

Konrad
