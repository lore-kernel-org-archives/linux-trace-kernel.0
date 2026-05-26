Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2A935B650
	for <linux-trace-kernel@vger.kernel.org>; Tue, 26 May 2026 05:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779771988; cv=none; b=Ftupnldj3qoyIR1N+Xha+qkQfNRFD+k6XaxJtNuntoXKjVpRkgk6unPSyjPuloPLd/yQH8IfF0fErDi2icSOxy/Izv78WZnBrXacozGE3YMts5tDuzUxIiwCQP8Hq1b8TG135HSzK0SApufSkqL6Mm4Vej/s2oH1twwfi8FaJdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779771988; c=relaxed/simple;
	bh=CNyn68J5G4M9q4KLWttx8rNk0/rLkzFbuBx79srQ3mQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m0IDsOTSk/UUv/4nY0am2vLN6fU2qoXugplVZShHj1S9PmCwl6Y9wIAElMLZ1o6b7z6+zcEIIbg4ZSCod601BL+4tjnmHpZynYBnZ3VcJdCYuuAZWhfwSPY85omgqjXMPJtnG4vvA7OJePH/JfBVTeWbMNYP3aAbauU5/AfBhu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Mb67mpL/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Bb1O73cR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Mb67mpL/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Bb1O73cR"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64Q2nS8K3063355
	for <linux-trace-kernel@vger.kernel.org>; Tue, 26 May 2026 05:06:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vyeclYrLbQjRr+lJ6lGO9a+S8wl5YIcUP6BYDVwCF68=; b=Mb67mpL/fX44Hpiu
	KHzcgtZjLMYk/mD+nL8xBrliSGTKWAOy/EZYMIlIrMa5zLQs1GoqsE691QBRnMrh
	n30by6FDs2zxW2xIrDEdnpn5oZzgZyFuvzlWDrjs+ZuMnK+ooVNML4OfhtbaMrlW
	he5/H6d9SO3kXp2KxbvfBM2S/b5QUWrbUKPIz2Toxy+YkSEkxd294BmViZofwdNq
	bXRWBftBqWSk2lITtIDOYmpjafL0f2KhojTyaa5SAE7ipc9OUFVhEoetXYgYOUU0
	2+LASQN8fWvd89xJV5Vg7Ix59H4Qlc2V0SPr5BShfdQLLNTHuKErN5pSSG5alyQG
	ysX6Kg==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ecj1gkj1k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-trace-kernel@vger.kernel.org>; Tue, 26 May 2026 05:06:26 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-135de949041so8980917c88.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 25 May 2026 22:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779771985; x=1780376785; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vyeclYrLbQjRr+lJ6lGO9a+S8wl5YIcUP6BYDVwCF68=;
        b=Bb1O73cRat3sEYtD/HoSjvyyisKgdE6a8j3jA0JuzwfGOr8lQmSyNrUt4Y8VED9k5b
         3kZm1xvjFbc8CuhqSnUBc3WOnoHtqoMxNWHgwx7tQ2q3qvKbKe2sq6e0HtNwHBxBV7sy
         4DfoCoNJodtXVvyMvvkgs6pOZDtXB7mS2jk9vHZrKIQTirx6eI3mkpaDbkIKUScfrQju
         jn5JV/ctKqwaM+FzesqLjZN92XsqhwGe/ASajjwLDcsUUpAxpP9mWg7D2UM5tMH8yRi3
         aEN6SingtslL4ac7RnALN47EXYji1PUah4dMVrquOIFvRyiuifQalzrRk2HTQtNDBh2Z
         QG8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779771985; x=1780376785;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vyeclYrLbQjRr+lJ6lGO9a+S8wl5YIcUP6BYDVwCF68=;
        b=X1V/wwGuHIBJ6tTQuxQKCAteJjpIFh8mmN60bwh+zxgvdNzeYKf/iGWwNe2fLEFAfi
         Akav2r2ZnBYl6tBr72bdkdZL6vW53GF/xfaSl0GO0ZG8AQkf8c56YApHClbdZDoMlPqN
         gjbsa68mPGcx3YvgYqKOWqxsbRZloKHKH8T1evH1z54mD93O0NEc+l4VEcXx7+/6y+7b
         4cqDdBzL/n313tJXradWmJbYz+K87Cn7gkEZuCPLrppUV5OOr5lFo6vDID2hRZUzxJCn
         a+1wh3aC+QnXPMnnnc4+EikZLr3Vl3PlLW+HXyMbp642RFd9WML/nkjnG7eqjkn/3lgV
         IOvg==
X-Forwarded-Encrypted: i=1; AFNElJ8wp6biSF3071oHAozu3Ge6lYnxR8EQ9tdYPFlmegymzasJB8fFNiiGWqw+2dQ/XMWLWTP/favLCm/Z4HUfK6u5HUM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4Joh+665Ky2TbA4q+r6xHcK07z8l8rcFZtR6h1h3/08SgRBPi
	Ek1k4o2ojYOgGJlWIq/2j5f43q3r5BRgKmU7884HMwsKYrCb0lLHadcTKsXMKmB4ZwMkFfuIS1I
	eAR2nR7e3lPDQTS+YBmlPiPoON44x2cvQxJ+E9Igy+OjDDK78eCv023hv3zyIbIY1KHmIRoumCw
	s=
X-Gm-Gg: Acq92OH3uv5BDCF4jsAjA+c3hgOIjCP1DSjRsIAoke6RAjcG7E5xxMquz3oy6QRaj6p
	I+WSMkWAokpVi9+QBVABv9+s4es8jBEaGn+yfv5XSAIEb/x7MR5f2droV6MyepOl47B6lQ9X8ZB
	x4QPMAVpaGhew3rUk1zLpzjylGC8cRd1NhTzUAFogBDFc0HfFMpG+btjNAs6iZIVwP0RHOfWVVn
	kkqu5BCTUd+4JkWl0qlApZCc1uRWgVvvTqVitg1WTGvUrQNAJijSOfuMR5jm2MtAmUSCijxOIWh
	V4bavmq89EmBNhnNmiIGIDsNICUI6iRUw2hQHZoAzmugiLF5TMblMt/l4pxpYZe1/hc2VXTI5rp
	y7JysdeUaEhdJVJ4dpTLKEzXTjoVMxJIIxRqjXaN6KUNWd0/HW6yDVg==
X-Received: by 2002:a05:7022:4b:b0:127:3f2a:af21 with SMTP id a92af1059eb24-1365f715d57mr5333428c88.15.1779771985330;
        Mon, 25 May 2026 22:06:25 -0700 (PDT)
X-Received: by 2002:a05:7022:4b:b0:127:3f2a:af21 with SMTP id a92af1059eb24-1365f715d57mr5333399c88.15.1779771984083;
        Mon, 25 May 2026 22:06:24 -0700 (PDT)
Received: from [192.168.0.6] ([49.204.106.123])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1366aa88c7esm7477591c88.10.2026.05.25.22.06.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 May 2026 22:06:23 -0700 (PDT)
Message-ID: <c0daeac3-1c13-4389-b48d-92f3c3a1643c@oss.qualcomm.com>
Date: Tue, 26 May 2026 10:36:18 +0530
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
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <2026052258-scrooge-friction-fe21@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: kMsmgrPqos8qFu2oH8OOTZ_iwOglHkX0
X-Proofpoint-GUID: kMsmgrPqos8qFu2oH8OOTZ_iwOglHkX0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDA0MSBTYWx0ZWRfX9xt+gML3b6H4
 8HX+ubaJNFLJjy/Dfy2siOYHai1S/ZKEBMomcQGv18AzRZipLx0qLgBBIn1vSp8x14PWvw3Wu+q
 uFgbE4940sngHgjIMipulcnDq5JCJsD2T634md7lUL1Z/Xu6lsDjVR7Yczalp+prhQXzPftYZTr
 ppwUEnTrhrFM/GsEhmUN+67FoWL75rdd5ZCp0hGuny3SYxh8xRERlRj8eS8/pHdnNr6WDfUburk
 bRQipJZysJi2cLx1yPkasR+fFgEJawLsKQVpmWLGiLbSMZe8U1pUUP49brEfYY82WjN2vY8YgFz
 sP0zgcuFJTkYUR5Hh837EcIXTCt3iXvYE9vRrl4ztOiEEi+oi6snj58pSPU8gf4kft7BtIssIC2
 ZpdS+2S+jTONW3vmC+kcZLHvWkf6wxI5Esk3g8WOmCCbkkr1NhuTfOQHAYCFo73RYcHL9ENVYn4
 vKIT5ATm9Z1nYRZ9cHg==
X-Authority-Analysis: v=2.4 cv=D8F37PRj c=1 sm=1 tr=0 ts=6a152a52 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=RqynvdPmTcCa9fdhPO8jTQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=reC4vt8OQQWefjZzLvgA:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-26_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 malwarescore=0 priorityscore=1501 spamscore=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605260041

Hi

On 22-05-2026 15:17, Greg Kroah-Hartman wrote:
> On Mon, May 18, 2026 at 11:26:56PM +0530, Praveen Talari wrote:
>> Add tracing to the Qualcomm GENI serial driver to improve runtime
>> observability.
>>
>> Trace hooks are added at key points including termios and clock
>> configuration, manual control get/set, interrupt handling, and data
>> TX/RX paths.
>>
>> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
>> ---
>> v2->v3:
>> - Updated commit text(removed example as it was available on cover
>>    letter).
>> ---
>>   drivers/tty/serial/qcom_geni_serial.c | 27 +++++++++++++++++++++++----
>>   1 file changed, 23 insertions(+), 4 deletions(-)
> This patch did not apply to my tree :(
Do you mean these patches are not applied cleanly?If yes, i will push on 
linux-next tip.


Thanks,

Praveen Talari

