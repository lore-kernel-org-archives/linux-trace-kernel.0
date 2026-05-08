Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952CD3B38A4
	for <linux-trace-kernel@vger.kernel.org>; Fri,  8 May 2026 23:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778282058; cv=none; b=H4PF1Ot+2P/Ef2rHMqZzhxDx1vsKOHqnMk8YS8qzWBN45CEX8B1vbPUaa4/CTtbeVljZdSAEmkWlOX9d3TQmdWJSaO7Sg98b8tmf7PMxOL05JC9czlCI/HDFEGpAP8tuIx/fOlHrmrgd6ztTvq5rh0EfgtBya3tVbnkLsRVsAEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778282058; c=relaxed/simple;
	bh=YoASFUv8PzAeOkfxBtm2ueqBpPplOaTPeP65nBEl1AE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qh15aVeZ8HiSHVtVvUWSL1xZKSQ7f7FXpAFl/Kjm8pPxet2KFOr3LSmiCijVxP0DUpwWxXKhQqu3l7YOMHAjtTm04/d4wMfowQ8SbDL6/BEvpfkK2tPmwC2dWRFL7SZNgbG+fY+tw4nVkICscG6+1IY/36zJFrnWpSg1KliBFEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Y6qo0eiQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=D3ufiCwe; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Y6qo0eiQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="D3ufiCwe"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 648LBxdU852118
	for <linux-trace-kernel@vger.kernel.org>; Fri, 8 May 2026 23:14:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7rpPzXPNYRy4O6OFYiHX6DcpoAbonFgfwH5h+yYyQJs=; b=Y6qo0eiQeY5g6pef
	+lrLTf1w8ZhQKsjUzkdpmSdHdPeydG9wD4HeuQAwfKCCgH6CqAhEyaaQ10FGNzZi
	nZzfiP3CV0fsOVQ9BYp6Ytxhno1AzH4LIa0OA425CxEfdcPTaVt/bd9QSy3CpXih
	tzdxe7YJFnK9KOjPAzQSjkRXhUTsw73ad/qtn/zczYpzt3X7LeDSTVV8XXzB2NmF
	rO4FOmMzAuFqjB/aAKrIDSkf2SuTpHdglTi6N2TH1x3peciO+hCzSQystpyZywdM
	DS4pqq3AebQbL4Xx4h3E13AL54rviBNY+j5WbyvVUE1YzCMyQsK0TQBzEJMoh9K9
	Ka5kUw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e1fptj8c5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-trace-kernel@vger.kernel.org>; Fri, 08 May 2026 23:14:15 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2f3eb8f3419so160668eec.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 08 May 2026 16:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778282055; x=1778886855; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7rpPzXPNYRy4O6OFYiHX6DcpoAbonFgfwH5h+yYyQJs=;
        b=D3ufiCwePkW8O/i3JE+NUgx2k8aVw0Nbte/FRjkUAgKsaL1AT6AGRsJdvNx7hgVELa
         5UMRfE5hDUljHg6Fxua2JswGB5RjTgPmXk2JTG58PPBT5ZJYY5AKvm6gC8cVC+AAJADo
         3rFJxLo1/OwqNb8lkV4vJOv9dS5hDyChezYhnvWl/XF4jmTCEmDAO8/6HksBAw3hjjM8
         WomA2ZxG8fbe29BXFG9zwLmu4xcPAZmz23UanuhPD1HezcPWL+vEy6fylwDKIaW5qrAl
         w+mRcLyFxaGMwrLAgR0GosMX2g9dxsB5x7A93gOppwt6s20c5ApHPzpGkbEMKyNDH9hM
         bTUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778282055; x=1778886855;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7rpPzXPNYRy4O6OFYiHX6DcpoAbonFgfwH5h+yYyQJs=;
        b=oifJStUzJU0OEfVNCsj3+yuavuEU/wKD7RVyQRo3NZkcPs57wTIhqN3Gg5OG92hQMa
         X+K9Ykfy9j8LX82Xg3vnIvDLTSzBOfAqOAx2r4YQ8EnwkTl6+rr0f0sS0Qnoy813g9UA
         9IJjbPMAlHpeFK37XMGyzou07cDOmpsG/NbctVHeLdW0fuWD7o5n/Q74lpNDDBtd7LbJ
         XU04kO2VeX/OmZyTvOwk/GN3KDuML1EPBqgNUun8JrAqRveesuInlPmjxeg/0vBy+dQH
         bW9oad4mMpdDPrLRgEXLL1dG9g3Zn6AbI8I4of+jXByxs6LmHvJiEz/AmucLoz/91EYE
         MEMg==
X-Forwarded-Encrypted: i=1; AFNElJ/bSABhJdrpCQeNlwIi3DYCd371mhygzC4I40dzm9YDb12vFcbRtlzTmZCqt3eQe61dPgaJArJylGG3w4+LBwNYgZs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPjt8Blm9uBBacN44RgelIIwlrxHUM/xe+vupO6fdTRA13L0PK
	rdnTRRmAgf7plH62g7B7idM7ZKQBmVDktlfSaTahwjdKKqD34oIFt7F0ZBIDijyLqhD28i0pkfX
	loBO5PHTXt/D0aF4W8PPrZpBaeA4EaJsBUM/nCFWcmEEUj+rAgMHWnbgOoKP8Zh1S+ZBI6gWr4C
	o=
X-Gm-Gg: Acq92OG+7dg7yonbM+hp8qNtFhvFeFdmNqUH1myqcxi1aBR3LHsMQodtXvXaQ1Z/SoJ
	PQfUsGrBWMu7rCO1mOoBZd19gW5jmI4hPiESxLb1ECj3BzUHbTIbpbJ/nf6OZz7cNeT0PA0Vz63
	ZWQmj1CmKRcjoLPwIBIpzj3GY/al48SC2F7a1PbNVDsZf9KnAS3XO/5832hEjTvXWSlPGhOUMD0
	oyczQkjymIUDQER7qgg8EsQTfwRDwx+VDr4UZmqqUdCXVuJm/bNmx4x9SmIfKeNpucs0i42ZdSW
	LupxllJ0G9+wRUBthGgeZVY1DEUNh+EksytKYyuYv9XznO5+xcWCIe1VoRrbEVwW8pQ5stMWTzv
	xzKxMUCA5kDgLKnx6nzb3UY6OKSdxVYI69kEWYsx2Lnz415w5o7JR8Up11WpgWDmVwlmawop9bg
	==
X-Received: by 2002:a05:7300:dc04:b0:2c0:e404:8b08 with SMTP id 5a478bee46e88-2f54b79a394mr8012790eec.29.1778282054596;
        Fri, 08 May 2026 16:14:14 -0700 (PDT)
X-Received: by 2002:a05:7300:dc04:b0:2c0:e404:8b08 with SMTP id 5a478bee46e88-2f54b79a394mr8012771eec.29.1778282054018;
        Fri, 08 May 2026 16:14:14 -0700 (PDT)
Received: from [10.73.236.40] (pat_11.qualcomm.com. [192.35.156.11])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f88885b820sm4124537eec.20.2026.05.08.16.14.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 May 2026 16:14:13 -0700 (PDT)
Message-ID: <e37f2d5d-daa9-4302-8d34-9ce198e60a4a@oss.qualcomm.com>
Date: Fri, 8 May 2026 16:14:12 -0700
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] spi: qcom-geni: trace: Add trace events for
 Qualcomm GENI SPI
To: Mark Brown <broonie@kernel.org>,
        Praveen Talari <praveen.talari@oss.qualcomm.com>
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
 <59e36f20-891d-4a58-8cc4-6822d03daa23@oss.qualcomm.com>
 <af3spostNgoRU0Vv@sirena.co.uk>
Content-Language: en-US
From: Trilok Soni <trilokkumar.soni@oss.qualcomm.com>
In-Reply-To: <af3spostNgoRU0Vv@sirena.co.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: DlcUF-bdqxUtXSXT87bPyeFvOObSdNX0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDIyOSBTYWx0ZWRfX41caHEeWnsss
 XF2ZbQPvWAmOniFexmNCMf2G+H6BYajoHncDXxiHDpgLNImw88LMKErH2KvDu7tLWWfGftsh6SS
 SUmNMnYG3wRtJizwqbPxUHOg+kpRZnY7wRnbgXrEuVolZHL1x5+MScx+o5XWtoo3w4pRqS9ycCi
 7J2XiUx8+jqNqtxRweCiTuj/sRoyuf5qQJRJ0FVRzCkSf9vbVseeVMRoxKw+M972zJsfJAtPkeX
 zynKfNAYk8HP0l58J/ZL7aYv7PloSp3+EPbwBAEc6s1WmekHL4VG9kYBrEZ6f3aDICQz0PttYlo
 nx2Pso2OXYQ0ulFoH0hdJL5HpX+kTOTn/UqEES5MxC4ZY1j4B4wqVR+Y+fS3qbH5bqKfnOLYKIs
 isHuV1pPPOF+OVU1/4oNJy+EedI6aKiMYGSXlsAFPeVFDavzBik+l0l2GOSNvQYqI4zOPFnz/0v
 PVycB1RyztUGRIQibjQ==
X-Proofpoint-GUID: DlcUF-bdqxUtXSXT87bPyeFvOObSdNX0
X-Authority-Analysis: v=2.4 cv=IYi3n2qa c=1 sm=1 tr=0 ts=69fe6e47 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ZdW6uxA9NKXbfdqeeS2OGA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=V8Nljz4Om1l1OIjE0acA:9 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1011 bulkscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605080229

On 5/8/2026 7:01 AM, Mark Brown wrote:
> On Thu, May 07, 2026 at 11:03:39PM +0530, Praveen Talari wrote:
>> On 07-05-2026 13:43, Mark Brown wrote:
> 
>>> By generic I mean this should not be driver specific at all.
> 
>> I hope these changes are fine. Please let me know if you have any concerns
>> or feedback.
> 
> The data tracepoints look plausible but I would expect them to be
> generated by the core, they'll be there for everything so I'd expect
> them to work for everything.

I agree here. Praveen - this is similar to suggestion I had for the i2c
internally. 

---Trilok Soni

