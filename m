Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3C037AA66
	for <linux-trace-kernel@vger.kernel.org>; Wed, 27 May 2026 16:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779898590; cv=none; b=AhDdd+0vQI7lcbciTy3AaE3KyQcmpXuBBUYMaEqJTJaz356lGbptfzEa6L2DUXN3dA6qDHFXiN4bu+FfX+Wl3PeDp7vwDzD7BdZdFODjfey9qHcrMLR0tl+CKIdBMH1cSI3cn0Mgh/UZuBuDRHqq28/MXg/eO0JXHG17UZskQhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779898590; c=relaxed/simple;
	bh=Mc1Kh8665aZUJz5vqgXB2LELXwVyswL8Z7BlMPFGqqk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rAB0xUYwQI+sA/8SxfZHh+g2TJ57Qh67UEhtWz/Ocj8mOaO+epfPdVSAPG+/uuB9MzqC5FOlUGA/1737W4xi3r/d/Y6ELkAYcTFV2e6InymN/WS/jDdJfHpLVcbJ7uakBIWpZsXZnVwjdGShGfh8QML7VWxikiLMCicEvB0ZmP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IdfNcVkx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=D9ECvczy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IdfNcVkx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="D9ECvczy"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64RAVGxw1401333
	for <linux-trace-kernel@vger.kernel.org>; Wed, 27 May 2026 16:16:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HHp2lK22hKEQ6Y7vMRu0PXmKWGloYhVj62upZKNboxA=; b=IdfNcVkxblBNl7Gv
	QBG0601oHKvgS/HB12PNTmtcewFojqCXlpHhShPsTLTni55SZLjEevZjZMGGgaWJ
	uLnCedSYEZY6C91Wby3zpVjhDRLj16jnN/uAwe/iJOT3SJYK8m2hL3uUvBAeO/ij
	WDKYLAbKgidVFevECp5dzv4jY9RO4o2yNCIs55NX1kNkhOTXg0HaPDAOoAOTHdf4
	5DLT6tisRhkwWtxtKHw4oeYZ6DOzR8iQpS+WIMctFveU/neLg14r4A/QJNtBEhv8
	7zW6kdqaJgFmx6s8nP6DK0sAhoISpoBK1cK+8P8lu+/D+guc7Hr7+h8WkNoObwT9
	fNaXcA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4edxxasa9x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-trace-kernel@vger.kernel.org>; Wed, 27 May 2026 16:16:28 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-304c46babe7so1816731eec.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 27 May 2026 09:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779898587; x=1780503387; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HHp2lK22hKEQ6Y7vMRu0PXmKWGloYhVj62upZKNboxA=;
        b=D9ECvczyXj/RZkHTM4FtaxjUutNdh2yFt5eQ2KQCS0ACLYuSoWr/h3N1N9iVsIX+/C
         k/dWV2NLZj5MTscRVUld3IhYpRdDuvtr//aGhDQlYP9P+qny4F4dQfcbt9lHQW929Ter
         P5zsWpiq8h7uf0S0mUIL6xygY+8mgSDT1tAcIiZENb6vhJKM7oYT6XdEG6phjpgw+NLi
         QOiYj14TOmWdKZJ12ID6xrlELlzveGTiLas6Q11auFLbsVpI2/GvaBMFqHg1tC8m79dS
         bxHuJSqBWPosUveR/K+mQZlskWi7TBqlMDnamjlJsBdQlBH/pV0VTgsdHEFdoZWWxc+a
         jHqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779898587; x=1780503387;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HHp2lK22hKEQ6Y7vMRu0PXmKWGloYhVj62upZKNboxA=;
        b=V8uU4h9+awYU7U3UNF0HKCjidEsdTNYtcQeOZg/EP8pEC4uaRLO276LcSsgP7Fbbwx
         2U1gEf6DCXjBxE5lmm4ZiuiVeifoq0jbWScroIUM5AQzVaS0MPv3XT4mnHqd+P5WBnsD
         iVTO2c5ehkuwGp+BrhSRe09ehdq+LtPtXfnNAwWvTq98w981JfZuIYlAPuRpvx9ju/wm
         PM/vRT8XvJ/wfnCHtK1qrp1qyHggkMqFiZV4L38hxyAMzXM7izja/ShCZiwQN4pRtw3h
         YT35Oa8FL+OYrGnKF5PUN2Dhob4IKW6bfRvgzLwXAhRET8AYyecp/Xp9FVga4/qG7eCz
         48Xg==
X-Forwarded-Encrypted: i=1; AFNElJ+xAMZk9pQEJzzmXzDmThPKnwZkA8Ea8ff9ss+elZkUh6BOfKvbyHX4oQSYL/tnAYibFsI4Hb6fkcaOFlws7MW6qfg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjuoG29+MBHZp92XpYAHkJrOK/vzZ8Ruibc2FjpXM2g/LjimrH
	LSMx0lI5gJraZow//4mAp6bWz6cjtqKjVQbUFkU73Pyk2rj2GW++FudDngI1B847efHK8b4OKmw
	gq97cR78reqSZGvxcZl41xbA2KhRow5dP36lnyrj0ntHVsEFDD5MCfa03OiSY8LdELURJ9JqWfM
	Y=
X-Gm-Gg: Acq92OFnZEOaOrsZSuwusCtc7k/kOcKRCRxdRu6Lsdi2clBeWWV6y885r3aQXD0UbGS
	D2UCRBv6oh7fFdXczCy6wK3fSqpPMbj+eDGyefVb7fyMqJWzlBE01uf1Ecxr2zEusc706IqjrrQ
	Ht/8pmBYv5Hu0Ak7AOSgy9pt2HtpZUeiWzduArRhwmfUpqdxMSeE3vfIgChTVPBsNilYTAj4Rs6
	slZ37+sV1rmUa3N5NosBQ0qLJmTRk0ACAmWIEbqkw+/KhusXjIClEddZBCJNFz1OaybEq5I7JYC
	r1NfGNLgO8tQEmC6leaw/MSRtOWH5ntW6TLk4ujKkwXw6V8rg0qdbge89PDkG7WiHo4d/htip3v
	tySt7fZu2hptcIxmm+AGyABn9rPryZAYZ9zLXI1jfc81tp/TG+dmQk5456NUuFi24
X-Received: by 2002:a05:7300:641a:b0:2ed:e15:c926 with SMTP id 5a478bee46e88-30449144597mr12538896eec.34.1779898587495;
        Wed, 27 May 2026 09:16:27 -0700 (PDT)
X-Received: by 2002:a05:7300:641a:b0:2ed:e15:c926 with SMTP id 5a478bee46e88-30449144597mr12538866eec.34.1779898586745;
        Wed, 27 May 2026 09:16:26 -0700 (PDT)
Received: from [192.168.0.3] ([49.204.105.193])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304522547fesm13547748eec.21.2026.05.27.09.16.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 May 2026 09:16:26 -0700 (PDT)
Message-ID: <cad163c4-2c5e-4c10-b434-d8bfe3fc0209@oss.qualcomm.com>
Date: Wed, 27 May 2026 21:46:20 +0530
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] serial: qcom-geni: Add tracepoints for Qualcomm
 GENI serial driver
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Aniket Randive <aniket.randive@oss.qualcomm.com>,
        chandana.chiluveru@oss.qualcomm.com, jyothi.seerapu@oss.qualcomm.com
References: <20260518-add-tracepoints-for-qcom-geni-serial-v3-0-b4addb151376@oss.qualcomm.com>
 <20260518-add-tracepoints-for-qcom-geni-serial-v3-2-b4addb151376@oss.qualcomm.com>
 <2026052258-scrooge-friction-fe21@gregkh>
 <c0daeac3-1c13-4389-b48d-92f3c3a1643c@oss.qualcomm.com>
 <2026052738-unexpired-diligence-10f8@gregkh>
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <2026052738-unexpired-diligence-10f8@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDE2MyBTYWx0ZWRfX4zBuf+NdWn1N
 WfW8iALEo/a0R22oVK4wF1UnZcEYV8V0QPfAc1j+tu02vBe9YeAsSEGg4s7dCvA2zQ2Tq8FVyUN
 wQDSW8h40QikP2fkMLb4TYpDUgZKXSl0pPzPtXidrWMmgoTfKywJR3Mv/5vCKgByFTehCw7KmN0
 RHpzA9KG/NNS8Xi2d+G6ir/G2v+KHc70Iq9Fhs6b0cA99nNvHkh+zj6dnjj0Uk3b7MDF95NH6hP
 4zp+1RUUSGO9FLgr1Dv0gp82IV6Uzw4YMSRCygbT698wjsCt/vWwbf7hJs6Jjz1ZUjgFWGqzXpH
 JJPDejW6BSjQN8Rev5utOEzftopiom113CZu43tTyomBGGNc/if3J2B/PIskzt3oNzk24dqNvmA
 Wj87tQi/GhMllfdYXiIK4DXv2UV5yT+U8iTZhmvcf7ekP1GLIrCYCaK6j9wYqnhDeHmUg3dnR0f
 EXjHBxWfwq+OKsRcR/g==
X-Authority-Analysis: v=2.4 cv=AureGu9P c=1 sm=1 tr=0 ts=6a1718dc cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ExCzEAt1B76v0Cu087J+OQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=dl6q9R0lG94mxgL4v_kA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: -_vSwDiiJH0n1vWmXeag-7GeeQF2j0L8
X-Proofpoint-ORIG-GUID: -_vSwDiiJH0n1vWmXeag-7GeeQF2j0L8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_03,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605270163

Hi

On 27-05-2026 13:47, Greg Kroah-Hartman wrote:
> On Tue, May 26, 2026 at 10:36:18AM +0530, Praveen Talari wrote:
>> Hi
>>
>> On 22-05-2026 15:17, Greg Kroah-Hartman wrote:
>>> On Mon, May 18, 2026 at 11:26:56PM +0530, Praveen Talari wrote:
>>>> Add tracing to the Qualcomm GENI serial driver to improve runtime
>>>> observability.
>>>>
>>>> Trace hooks are added at key points including termios and clock
>>>> configuration, manual control get/set, interrupt handling, and data
>>>> TX/RX paths.
>>>>
>>>> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>>>> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
>>>> ---
>>>> v2->v3:
>>>> - Updated commit text(removed example as it was available on cover
>>>>     letter).
>>>> ---
>>>>    drivers/tty/serial/qcom_geni_serial.c | 27 +++++++++++++++++++++++----
>>>>    1 file changed, 23 insertions(+), 4 deletions(-)
>>> This patch did not apply to my tree :(
>> Do you mean these patches are not applied cleanly?
> Yes.
>
>> If yes, i will push on linux-next tip.
> You mean rebase, right?

Yes, i have already posted V4.

  https://lore.kernel.org/all/20260526-add-tracepoints-for-qcom-geni-serial-v4-0-e94fbaec0232@oss.qualcomm.com/


Thanks,

Praveen Talari

>
> thanks,
>
> greg k-h
