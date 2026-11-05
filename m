Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793905975;
	b=acRPjP7TsHl3IUUVBwbqSmT02KxxcVh6vhchbNMK/ra99eZa/LSCjC4ugY6C7D3NM1h8
	 iz8LvMieJfp8T7Z1xNjNbSgX5GVW1OVyXw8bfpCozuHzMIVfrgW5cz3uYIqqr34JkAcEL
	 kOoaofU7vrkjxc/+ilQkik4i5TKQW2Dkk1dMOAfe952yYIXhySXRuHvSHbUQ0vkLUyLC+
	 PHLdPrrFLL1BWoZ3yq4RVlzz5dAbqY1y2AbXa1Z38+J5lLl8agoQNguJIXOS4dt0Q+Boa
	 irX1CTlxVMxboT1W7st3GJ9OX0z9giS9tckikvGO0dbdTKVRqwOx6w0jmHhdGVeBCbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793905975;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:In-Reply-To:References:Organization:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=m0mMRhns++zcKGrTP9aBFlkK9JTY4c9NYzIr6VNARtg=;
	b=16GL3NIChH5oJXkXNLJAr04Zz2wr4dnTLs3b9gsOtV0zFKh0wPAQJwRmwPiMW/TXDd3V
	 RJS0oBpC3bmrMZibm/rOeas6oYJVU1h3ArZ+RDx/JgEKOt0JVim280OrARlJb8ADVqfFj
	 jcmX3wgTnRdlkJ1a3dbs4jCvHLnhzCdKJgtInG1LRS19DJxatvifft5JWyfgbCGFNNOHv
	 X5p+D/4w/X7nLdP1ZlrmdCMnb5v5iHg+VD0PJLCD8UUfJLDlUHMEZtWFibgNirTWWW+OZ
	 hjtCS+0jMl0lFNr9+oRxxJQajOv5pkiqvPdMDjC/YE9vkVJJ6GoSn9u7S3Z2ADBdDGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LTFS6EhJ;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eAviCzlx;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA45606A329
	for <linux-trace-kernel@vger.kernel.org>; Thu,  5 Nov 2026 19:12:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1EA45606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LTFS6EhJ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eAviCzlx
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5HeCAM1474551
	for <linux-trace-kernel@vger.kernel.org>; Thu, 5 Nov 2026 19:12:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	m0mMRhns++zcKGrTP9aBFlkK9JTY4c9NYzIr6VNARtg=; b=LTFS6EhJ9WZlv/J/
	1Er/jeH2zi7+21FYJcFpQXbEM5AYbGgVJsacUbV2u5dBmhZ2HZFmG6Xwk2raLyRC
	AonFVdNlLfY9ctnRw/YTKAJt3BdRll3iAde6TC71BPwwtBd041LiSzGxx+jcfANK
	GeQU5L2S098AfuaCKAsEst7Mnadp5WtGu+YZppJzCr3nShQdsIrfZDtId2G/pA1j
	+gAvA1QLM2LbUAXXbf1oolOrBQmwVNs0D0riGKfr4BsJFbsv1+KkPWIXiN0J5De5
	UkJ8FUE6Lvc5IZFgBu9gPaKCfB6QrBqdlL2jP1LKVE40Fgyk3or7sC7n916pNckS
	n/mK9Q==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrmcdbbrj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-trace-kernel@vger.kernel.org>; Thu, 05 Nov 2026 19:12:53 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-1af203073e0so3396575c88.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 05 Nov 2026 11:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793905973; x=1794510773; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=m0mMRhns++zcKGrTP9aBFlkK9JTY4c9NYzIr6VNARtg=;
        b=eAviCzlxBAEt/RtGxGISp20QkZvjKbupA+aOd7rWcPcaaaRaHjPyujG3mn2/rNfHf0
         XlHCdwwS63exgoAsRxdJyD+c2kvKxCIe3558FcqqJdXdS8shGzW60YX5JizE7k41Aedg
         MPKOcI9kmW+QflFjc7rH1XSfCu23vhY1t8pBtx1n+i/lU8/iZkBVMQHBjgXS4fLxC7nZ
         00SH1Lb7KvEEkpyE1PWU0c38nAefqbTuRLtXkXw3QJP0AvqlyJz/sU2XKEvKgVajtQWc
         VC6UfmUV8fkXAkHBvt+mXU9uGI5D/fcKLjOOdz1LzBhYf1LLPq8jrCCr0cwZjZ5cnsel
         n0jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793905973; x=1794510773;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m0mMRhns++zcKGrTP9aBFlkK9JTY4c9NYzIr6VNARtg=;
        b=AL05k7G8iGqmEB49srMkst2hENd6wQknB5ceFCVAz7yNsa/0AtLqy+lceHZuPfDcql
         bm//zbWqXgcTDIEaib5GHnrbWHEbjWThZHqMafdI7X8XJGVi2Kgfgs6I2BhwJbEyol2B
         3lqZAmI8Xd4sxwN2U3xvVMunluB8PmXTagayuuKp6s22RWYG7IIvlTrxIaScNyG+KvSv
         tPmJMzW5ZRqIwbNWwvVCqixjAnAcCyL5sehqxD90bj+TM536woPKRO8swXQGq3Po9VbC
         bYwA6cqLdhukQHh68YsQoxExXDzsBxF9hhx3BmM0u6sW6Z9Hafzn4TbgvXbBFO5FYrwN
         N7YQ==
X-Forwarded-Encrypted: i=1; AKwUvBzmiROz4Mf5iTnMclFXMlJKOvFmzoiB/bRQ/qcBYgrtpz+LkwzzA/DZ4ybnXkJlJO5WovfQ7wZo3ta/v1R2wEURze0=@vger.kernel.org
X-Gm-Message-State: APuU4Z9RSqcPTJkH4dg2zqgeRzn0k3C2xMebsRciW/2IvQNzAOTM3ptR
	fkiVOjuw5Tt1WItGyAf/6wuhgerzZp+XV17ZovZNlfKMIjucG1v18cimZhoQavufFiqN06pik4W
	SqLT5YSET7zBWTQscPVCtJIH0ZvfBfXRe2wbaldYgIA6SXuNBQwAuQ99cXQV7dGJMPWQffhw+8Z
	k=
X-Gm-Gg: AYBFou224MGjwH1HOLHzZrK4NvIw7ZDshOBaly+dxwBOFxt4FEX7unk1YlKmyk/cITK
	xN0TwIR2EEGTj3Ab3vShh9Eow1pUtt0mHs6msK7xAMph9EhpQWtMfjaxluNcUuuWXiBMPdoC1p/
	rdraZ7M7wFl5YDy8XyjJchESnoPqChciHqZvGVHL1wkXiiBTEXdMBAg6ZVV4gVUji4QmkGcST1z
	d7l1bHv3zT6LUIVprPd/CzgQsAppyBFWrXKpjjfVx4g/XH4HnRO4OnYwi5Cbj4Wof0lHMOtr02X
	BYYBCxNuBg4aJFGX6dR/sP9OBRcns8JYhRzEYRYZxoxt84qh56efGRKPo0rTTgWcbqfdWE9/JOs
	B6U89YM4mJv4U6PhSaYi7yJjivI5x1bQVBZ0I8iOfEXCT7v68qa9qZG+UWsxRz59HMcyRDbnzmk
	gb93iuytCu336d7mahVv1EAsRNcA==
X-Received: by 2002:a05:701b:455a:10b0:1b2:42e3:e5f0 with SMTP id a92af1059eb24-1b242e3e78bmr11296112c88.12.1793905972682;
        Thu, 05 Nov 2026 11:12:52 -0800 (PST)
X-Received: by 2002:a05:701b:455a:10b0:1b2:42e3:e5f0 with SMTP id a92af1059eb24-1b242e3e78bmr11296056c88.12.1793905971882;
        Thu, 05 Nov 2026 11:12:51 -0800 (PST)
Received: from localhost (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c748eesm17728365c88.23.2026.11.05.11.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 11:12:51 -0800 (PST)
Date: Thu, 5 Nov 2026 11:12:47 -0800
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, Steven Rostedt
 <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>,
        Linus Walleij
 <linusw@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RFC v3 00/14] I2C - detailed transfer reporting in case
 of a fault
Message-ID: <20261105111247.000074c4@oss.qualcomm.com>
In-Reply-To: <20261105-i2c-fault-reporting-v3-0-515ad74ac4c9@mobileye.com>
References: <20261105-i2c-fault-reporting-v3-0-515ad74ac4c9@mobileye.com>
Organization: Qualcomm
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=EOGTQFZC c=1 sm=1 tr=0 ts=6aecd535 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=JvO64EORAAAA:8 a=8BD2oR26EWfAhSrP7b4A:9 a=CjuIK1q_8ugA:10
 a=vr4QvYf-bLy2KjpDp97w:22 a=Qz6KxWHdQ2_aS5WpiCfK:22
X-Proofpoint-GUID: d-8VMKNHT4QgLFLdEvqp0Ibvt4K798GP
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA3NiBTYWx0ZWRfX7j8D8aMoqQMr
 IFiW6VYhz+rjxqZv/RCYxDWjd12D9JKcIhdDK7wsiy5uoyTghSDWKy3pQbEW+HpMtxzEyK0hA48
 ba7HWVIGr7AhGB2/z07iVP7Jg8vjID0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA3NiBTYWx0ZWRfX9s5Ex55jyaxQ
 f2sVqko9WUrHwlirzg6uWNV0vL8Xxo9xKv+gAWaju/GtOMKAP5KMwcx85cHuXi2mcyfTx3wBnSE
 y97P1v4XO+9eX+H4W5npOu69SN5lBlYo4wvXmNDfV486BcY+ekb/M8273rHm2jlH+/jw9iIAPfX
 dy3JfVsplqZtF6qCk97iB7HOundwQKtZ+iGcjMt4Ih+nOPEGqdptxrB+JG1v9L63LdNFC30/yT+
 d0OJuQ8vc4oU7bywDOlq/jlPJHWcOjjqHVPD0HwR9EP9zhBsjXzNF2GQOBDLpX2NAK61N6fe3Lq
 8BJMu7QwYMrIGUbJ2MGwoJimgfkgaQL/SM8aZr6xYlAMyVQ37F12Ko/YEHnkhpKxx2G/+MfuIWv
 3PwJaWpo60G/8Dvog/GscONX31P/xfMQL/AUn6QtY3V36q8fPqq8ljwDEVkUfyfD7/LmpSFAURu
 vd+bn44zHwcZ12ztjbg==
X-Proofpoint-ORIG-GUID: d-8VMKNHT4QgLFLdEvqp0Ibvt4K798GP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_05,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1011 suspectscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050076

On Thu, 05 Nov 2026 19:15:21 +0200
Dmitry Guzman <Dmitry.Guzman@mobileye.com> wrote:

> The existing API has function i2c_transfer() that transfers one or more
> messages, and it only returns a single error code if the transfer was
> failed. It doesn't allow to know how many of the messages were
> transferred successfully, neither how many bytes were transferred in the
> message that caused the fault, and also it drops all data received from
> target device before the fault. There is a comment about this in
> drivers/i2c/i2c-core-base.c: "REVISIT the fault reporting model here is
> weak".
> 
> This patch series introduces new API function i2c_transfer_v2() that does
> the same as i2c_transfer() but also returns detailed transfer report,
> including number of messages and bytes transferred before the fault. This
> also allows caller to get the bytes read from the target before the fault
> occurred.

Hi Dmitry,

Just for background, could you provide some more information on why this
information is useful?  For kernel side drivers it is remarkably rare to
find a real use case of partial transfer information and the
current i2c_transfer() return value approach complicates a lot of
drivers for very limited benefit.  Sure it is a small complication
to check for a low message count, but you do get a lot cases of it!

That leads to a mass of AI reports of bugs.  It would have been
much better for kernel side if it just returned an error code
on any short transfer. 

Given this is effectively going in the opposite direction I'd like to
know more.

Jonathan


> 
> For user space clients, new ioctl `I2C_RDWR_V2` is introduced.
> 
> Patch for `i2c-tools` user space utility that introduces support of this
> feature:
> 
> https://lore.kernel.org/linux-i2c/20260623-i2c_detailed_report-v1-1-b67259a31a9d@mobileye.com/
> 
> Below there are several usage examples with modified i2c-tools.
> 
> - Unsupported message (max length supported by I2C controller is 2047):
> 
>     # i2ctransfer -y 0 -r w1@0x19 0 r8000
>     Error: Operation not supported at message 1
>     0 out of 2 messages sent
>     #
> 
> - First two messages transferred successfully, the third one is sent to
>   non-existent target address and thus is not ACKed. The data read in the
> second message is available for the caller:
> 
>     # i2ctransfer -y 0 -r w1@0x19 0 r1 w1@0x1a 0
>     Error: No such device or address at message 2
>     2 out of 3 messages sent
>     0x32
>     #
> 
> - Target ACKs first two bytes but sends NACK on the third byte:
> 
>     # i2ctransfer -r -y 0 w4@0x09 0x80 0x80 0x55 0x55
>     Error: Input/output error at message 0
>     0 out of 1 messages sent
>     Message 0: 2 out of 4 bytes sent
>     #
> 
> - Message reading is not finished due to timeout. The data read before
>   timeout is available:
> 
>     # i2ctransfer -y 0 -r r100@0x19
>     Error: Connection timed out at message 0
>     0 out of 1 messages sent
>     Message 0: 16 out of 100 bytes sent
>     0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
>     #
> 
> - Driver does not support detailed fault reporting:
> 
>     # i2ctransfer -y 0 -r r1@0x19
>     Error: Sending messages failed: Operation not supported
>     #
