Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E77D3E1696
	for <linux-trace-kernel@vger.kernel.org>; Tue,  6 Oct 2026 23:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791330818; cv=none; b=pHKkXwEAKcAIZ8z1OUQugW7Z0R8cQVdAHK63jLp8z4RKv5NJhryiSiYBX65dvwJzz7+lwQ8pAe8rXYEo541hTq+TeN0PxIC0hZuSZNY3BwuZ6bi2eO0C74m0O2WbN5mTer3QF5CjPbuMEFYNgRt4q7LV27Jjxd1A4GVe3BLHKEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791330818; c=relaxed/simple;
	bh=xf167AZzu0nvnTcAX1Xw8R4tyYv+cUzmt2UzRs7bslQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=imh5BvVqMqAiyPy6GhtAyteTRL/AFMK724QKMeZ+LaIQmQbZQguO10WXtDOjVW21aDKO1VTmbjOqaCNuPF/fJrwGGZLSxI6Fv2SNL/YwQGlhksIQd13dN7hFIZ/89F28LiLH3UHbj+qmunixmonnSg1XarD3tNlSCcQKw7Teh3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KkiWrAzX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=P+z66KUC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KkiWrAzX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="P+z66KUC"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 696LeLUX1029557
	for <linux-trace-kernel@vger.kernel.org>; Tue, 6 Oct 2026 23:53:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IFp8HdaEfTURv3yOkfDgaxZg9EFYUbB/frsyn4UIA0o=; b=KkiWrAzXJ0cWLYsj
	DWrvvW6RLnt3U7oadPNWuvLNs4UbwqMb8BQRas/iqGSO8pxrAF8kzD78d5B/Ltuk
	oL8+9fqfkFcty1hY9Sg3iWS91ESxCx0tej2TAhoUoFuc3sHOIIl8aQ1MheovAUDh
	Ax+ArVACEAlkOwleqh9YCYjDEMAJVoRkh055+d1JSzoE82U6W5dLfau66blM+hDn
	mvaOsS6YbEjCM7ZzId1oG2s4lfaaKPqi2I8pRFwKPcnzGrBTYgNCoa1dj3G5yCow
	XcDAkZGhMgqdjV5tWVaZdkm10tuBqqhsJ6tOMhtTQB1mtx9eIq2a4CBou4P8WPmT
	ErMHKg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h53asj18q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-trace-kernel@vger.kernel.org>; Tue, 06 Oct 2026 23:53:36 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-3510a481ae9so6564298eec.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 06 Oct 2026 16:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791330815; x=1791935615; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IFp8HdaEfTURv3yOkfDgaxZg9EFYUbB/frsyn4UIA0o=;
        b=P+z66KUCVaVdG46mJGBGEu5X1yP6CIlTB8KEhhLufX14Vq7SkRLBU2EDXVLBwUYMq8
         DT4ZlSb+O0gjvnQuJVTqr4elpS7JLns8f4erz8+90Pt3qshRCZyJLYBRU2bhj+B4lQJ+
         kAZc/fpIDQkNysIfNDXB+pYt0JQs4ucgyzROgdPkkW3S6NHMxQv/rwtmYntJsmtUj5a6
         FmgcIw0sABG9S5SPYl+cmyobYtVz7Pbq5hLlFfDtK9ZsOSTG58/mC5yJxwMNOGrVH+P8
         gFfRH+iLRUOKmVScQAd5L95o8iuYnbK17LE/7JW+krkqqovmURmRWD6ZVrr49YEvuGtz
         Mz+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791330815; x=1791935615;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IFp8HdaEfTURv3yOkfDgaxZg9EFYUbB/frsyn4UIA0o=;
        b=iUk1c0hXU1ybh7Xk1m7VlmYCzWx+kuPN8Zx3QhYWTZs/6q59CPuWvxMPEFCHD4diJa
         uaFeruxXeiTuvE9AehztR9z7muJ/zM+GmBXHnTQmBpmpJttbeFayo4XauQYEJeqjc3QC
         +5elpr2EwQNjckJ4NnRAEAZDeYnI+zb6kp7NGQuTh2sR6QXk92dt/vdmTbYKljDwy89t
         5sFkE66dN/ysFsCTW/LEJOb4zMwlLgfuDhPYqswpPqY9fJvgxfQREUq3ZZWskh+Xav/0
         fgo6NLVP/bDiJXVlwmdEwCVCKGo557by9LMI+FpkBd9+HA6gezFo+WgLrYd1Tp3FzIiS
         5saw==
X-Forwarded-Encrypted: i=1; AKwUvByU+i1FPOhv6jErfzCtBi04qlr/0hn5r3/p22xMSa47zyVJkhagZcvb08GlcxwSy5LO2DnIGFJCo64u7tpvg8PUojI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJrHxQd0SBAM502eIeLU2aGHrbcs+ExlpZpQ7C2WPIaJ4H1Wj7B
	oAoQJc2Izo+wChlWAaaZ4VNG6wDrrPy8/y/a4Jriq9djagy6a/RdjBOwu/CgPYjL1pCsYzdNQW1
	1RTw5fa7L/5vOJ3HS/ff03oaXJl+bzFVVHRYBfGN5W6WUyUo0+OqeC9j5tp/e9yRTROfPYs+wbx
	k=
X-Gm-Gg: AYBFou3yT3TQ7V965nYPMfwFRVVG472cEvyaN4pzdW0mEhZzxoFqmNJgdctv2f6zEIn
	PMqKdDRR7+rz1sVAfLgQgV1h5ZoA3zQ6VGKJys3SvfXEE9NPxI20QG4qaM5eWnQOCG0j6ESOwFE
	RiSGJxGbSrT9zdBkQVV8DdQ5L+eSI36rve8tggRl4qiAuyDVGpfw2pBrU9V5/i1IGJ54xJWqOEU
	N3felFn0JgpPL2JoEd1QAdJRgxmMP3JWya8QY8yhpKd+vWYUZDpvIk3uieoJOWgUUmL6O4x0O0H
	aLFglRRoQkUfkKpwXLUsWtMN1XzqBh1OisVKrhDolNuOsXx+jnWFk6L7XQ0lKUzQPAWvt4EGfV8
	NeKttI/UiTp1FmQwppwKccnDkFfPyPhwSz+mRcxe1TcnA76Pk8kSlmiiXOrhT798=
X-Received: by 2002:a05:7300:e5cb:b0:34b:f456:25ce with SMTP id 5a478bee46e88-3515d86f096mr371879eec.3.1791330815319;
        Tue, 06 Oct 2026 16:53:35 -0700 (PDT)
X-Received: by 2002:a05:7300:e5cb:b0:34b:f456:25ce with SMTP id 5a478bee46e88-3515d86f096mr371852eec.3.1791330814702;
        Tue, 06 Oct 2026 16:53:34 -0700 (PDT)
Received: from [10.71.184.34] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3515afa61e8sm1972503eec.22.2026.10.06.16.53.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Oct 2026 16:53:34 -0700 (PDT)
Message-ID: <4ed3f09f-74fc-4f07-8897-5c773fbde0b2@oss.qualcomm.com>
Date: Tue, 6 Oct 2026 16:53:33 -0700
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] zram: Add QPaCE zcomp backend
To: Sergey Senozhatsky <senozhatsky@chromium.org>,
        Georgi Djakov <georgi.djakov@oss.qualcomm.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, abelvesa@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        minchan@kernel.org, axboe@kernel.dk, rostedt@goodmis.org,
        mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, djakov@kernel.org
References: <20260930145215.3380977-1-georgi.djakov@oss.qualcomm.com>
 <20260930145215.3380977-5-georgi.djakov@oss.qualcomm.com>
 <ar3yt8Kl3WUV93lP@google.com>
Content-Language: en-US
From: Oreoluwa Babatunde <oreoluwa.babatunde@oss.qualcomm.com>
In-Reply-To: <ar3yt8Kl3WUV93lP@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: ohjYgn0eh9bpOwx1N1M-ZlV379nDUDWQ
X-Proofpoint-GUID: ohjYgn0eh9bpOwx1N1M-ZlV379nDUDWQ
X-Authority-Analysis: v=2.4 cv=Xt5vqlF9 c=1 sm=1 tr=0 ts=6ac58a00 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=9kMCAbyDuj7LhItxiaIA:9 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA5NSBTYWx0ZWRfXxeEHw0ucz7H8
 DihfHCx4D0W1IYyKSxrpPH6EHqoGAIxkd+5MeWldPphBy436ky/9VLeI0Z3B3Tn+uu78v02gKCf
 m1jBWWhZ5rQiSg2xDduTvYNF4Wl6AYbVWDKFFdbOxylYUZcjpXTbZwY+sXws5+EG2/UZQJ497wH
 wDJf2uBMkgsZxb4WAZGLs+u/B7JT+tnH/W1TCyvo7J8d4UDs3ttCa8XiG4E4bk14/5jYpmYtf7N
 8LSDdkLu/EOX/JZRFaBqUwTJtQDIB3Fw0X8pikCrQn58zb1z6PKuTzUj9JtmSsSApkMTwZX+5g9
 zdIQKBNWowMqf3aX7h+IzOwKWzJq62n4IMZgK9vqJ6coSzNdbqHkeJOnuTEfcxAxLV/MLWAiZnC
 j15jrElspy7GYXc2xGL4JWRg1eLODE8c70Yg6YNN3vlYyFLzbyEiaoi6wUw5rKak+sxxgqE2ULY
 G4EC3IlTELVlJGCDo8Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA5NSBTYWx0ZWRfX4q4MWRsSNY22
 9IHWl9XlXY8tsH3/iW0+0/r2MdFNLnhwqn+EiCj9hu9/13Smnaes4jDmG0kjcFnPmioqe9Cra3r
 43flYE3HJuRpN62lVk+eShxKHYGOj9Y=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_05,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 malwarescore=0 clxscore=1015 phishscore=0
 impostorscore=0 suspectscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060095

On 9/30/2026 10:43 PM, Sergey Senozhatsky wrote:
> On (26/09/30 07:52), Georgi Djakov wrote:
> [..]
>> @@ -80,10 +87,10 @@ static const struct zcomp_ops *lookup_backend_ops(const char *comp)
>>   
>>   	while (backends[i]) {
>>   		if (sysfs_streq(comp, backends[i]->name))
>> -			break;
>> +			return backends[i];
>>   		i++;
>>   	}
>> -	return backends[i];
>> +	return NULL;
>>   }
> 
> This hunk looks unrelated to the patch in question.
ACK. Will remove this.

Thanks,
Oreoluwa
