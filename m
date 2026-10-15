Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342D24A5C42
	for <linux-trace-kernel@vger.kernel.org>; Thu, 15 Oct 2026 15:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792077140; cv=none; b=uyRZQSJBQ3bRZdTeNM7BIB+dkjbv1TFJ5UXksiyJRjPT4xDezVB823r3GoZryA0QgzVJm28OithHbf1TowTzsuseeTQxlAy61VZqKGYTxY8igTLrNYAnDT38jzmjRrF/iluBSWEWzaQDPM8+fdeSkJ0l793eX02V1nFslLlU1TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792077140; c=relaxed/simple;
	bh=rQ5DoMf8ZnQyBuNcuUdT0zQ4ECEYfTAmcSFNHkaDc7o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XJsCzwy9QcDMmB0LcON8ExUrdkS1+dCU598U75LovJbQMOolqdDS3zd6WXkfWhHsrEjq6Axb29EetYwrR4l21JH2JKAb2cDD5mBOq+ntHtqk5AGYIjsEkQknixRVXfpHT1Qipx8kGu3/npTgGA68Tp6Nxg/fBgynycXg+D3tepY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QhgCQAsT; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QhgCQAsT"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-8b06c0794cfso23827527b3.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 15 Oct 2026 08:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1792077137; x=1792681937; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4f47ccrTPzkKKb0Ghz6v3dOkmhYk8321RuCtsSygqc0=;
        b=QhgCQAsT7RVOz38TRpDbWHfkOSjHKnpNOby4P7lc2JBYH8LYDEEZdf0+V2/6cYqaY7
         iYMhppPh1Ydru7IqzpbkuJ6sI1uXCN6kIJuECJTiULLgQxQfZSzNzHY37oBt6umdvmbe
         dKohXThSEVKZ3D7Gca/2x4pj7hwDnXgN0yc4M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792077137; x=1792681937;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4f47ccrTPzkKKb0Ghz6v3dOkmhYk8321RuCtsSygqc0=;
        b=K9aWVuG09sQ5u7oj5OhVTGbHFYpaH+cFU1kt11p4mJgsZu2xjkW9NCJmNrRjE/C2z5
         eyf916SgwqqWTSnxrtAtl4DuLgEO1dS5ZWtgrndSD1pttix6ml1LFHKJ4kptMLvsA3VC
         kGZRorgMLKUl0JmEAiYAFL7olVW+3yLAzpQgU1fP1khFDRNoWl+QJ8L1tIZeNVNmGozi
         kJty5CqYK8CUDWRM5x48iAshSiUmdCtLFiGhfqVTZ/WJVnRVV8v49meqgaeVFhj9n3t0
         YpY6GPnztLJhaHpinL54nOlHrAfpw1+jKewK8OkZFy4pbq2RZbM92nZ/onvWroxnwc00
         iy6g==
X-Forwarded-Encrypted: i=1; AKwUvBx0SjlIcYjCM8//l7oCp+MXC56oCEYAE3vqoUmZJ3YgW+ScVq/KEtmwV1FnWY7vUzl5qo8UtHdVkQyGHu5Od0gzdYI=@vger.kernel.org
X-Gm-Message-State: AFq9FYI/y9J0NAWCFEgtRWHFaGy8CDKPmkStJgkLq0uw/v9gOF6mBbuL
	Hiu0+Xa2lOwiQLqzFDFKCrODOe6KbdfO2Yh5dr8MB6xnTVsIspnhkwPO7R00kT2//bQ=
X-Gm-Gg: AYBFou23E2G2/50TCnSzu6RgEvVBxCCN3rsp4FyPczoA9oUA1/o8HPiuF1FXMIOOfUU
	g3wWtp0X8n68ZBgorf0bFcE+W0B32Cb05uO4NmUCTMqPi0pMXVziVWOqsZQgsKzFGfP/nU8WJKi
	pcW+H2/giNWsMkjxKW6GvnGEMXtAjx3pjbkreGxrnuUZqcJKZ2eK0540h0i1vBkuigTO+EzeLFr
	JOMEYP+bfBlBBobk8+xcseKcAWOgSxYqhDgwuO/oYBV4ReWCYwr1cgMbcCzlZUYujkNQgHLuzgD
	/fhJ+i+WME8GDaIGAmISV5JJbMknP1Nj0Hp2oq31Uhai6pwvJYaYkAtcnkJmu2IghJ6ZQttt7vM
	tBfj7ULfjWOIiGo+ID5RW3Rh56mRpKRf2TnGNOHyZ3q3GZypUv6PQ3PWP86KYZMhxTJQDl2ywZ6
	0xlAMSsOCoNrrP98Rd4TSKkn4jVe17+XtbfqfhJ5cXwcUm7sJU93uITNLiWzO/I8s6yQRVJgb/w
	E+InRDHPw==
X-Received: by 2002:a05:690c:e3ca:b0:8b0:a3a8:5f9c with SMTP id 00721157ae682-8b0a3a87f2dmr46357577b3.40.1792077136707;
        Thu, 15 Oct 2026 08:12:16 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b07f263bc8sm66643697b3.45.2026.10.15.08.12.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2026 08:12:14 -0700 (PDT)
Message-ID: <97e9479a-d64e-4905-b6f3-7f8831bf7f22@linuxfoundation.org>
Date: Thu, 15 Oct 2026 09:12:12 -0600
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/ftrace: Add nice dependency
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Jaewon Jung <jaewon8868@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20261015022416.43534-1-jaewon8868@gmail.com>
 <20261015145557.7AFB41F000C4@smtp.kernel.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20261015145557.7AFB41F000C4@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/15/26 08:55, Masami Hiramatsu (Google) wrote:
> On Thu, 15 Oct 2026 11:23:39 +0900, Jaewon Jung <jaewon8868@gmail.com> wrote:
>> The tests use nice but do not list it as a requirement.
>> Add nice to the requirements so the tests are unresolved, not failed,
>> when it is not available.
>>
>> Signed-off-by: Jaewon Jung <jaewon8868@gmail.com>
> 
> Looks good to me.
> 
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Shuah, will you pick this via your selftest branch?
> 

Applied to kselftest next for Linux 7.4-rc1

thanks,
-- Shuah
