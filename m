Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA5832B993
	for <linux-trace-kernel@vger.kernel.org>; Thu,  8 Jan 2026 21:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767906217; cv=none; b=kOSXXpo3ZnpK0UuJdG4EtNBNnbazq+xfAPl6y3yiGrMrlhW6kIAQkm4BFPjir0cPZfg5qKeuXo0o1DkAbBSRsRiYAMnF+1KhstqoP+VRTrrTxu17Z6+DlLrKIwd04McyQaSTbnS5vdGN+O2Gs7xOZqhB46wdI9gByEzjbDdlVt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767906217; c=relaxed/simple;
	bh=/rZyep19aQDD9WNH/j+FEROaPE6P/Ny2r5xve7NTOaw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RWlEAzzemPeKA+XXaL54zVyutqLhH/5/VYk7/iE/nL8UsnKy1lO0FH7SSrXh/6Fv/WhmT0279ZHtdcdk3Bxx2vQPcfR5g/pJHgCm7g5mOsHR2C3iPiJ4CMi1qqoZJwvWvgwYOJs/nOUL4H7DJoHUrZk72Ju+9oieU1Zp2t4mZSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DE2PoDs8; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DE2PoDs8"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-65cff0b394aso2259579eaf.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 08 Jan 2026 13:03:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1767906213; x=1768511013; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KWJ9wlAAp+rcwWYxQycgsvIbLJCcypF3l4SCpiLlS3U=;
        b=DE2PoDs8metig6VptJu3LZaTInpnm0Z+DtAuqPIovbHXtrpz01rIyk768FlPX0As/y
         hXReRW5eXUNzeOvz7T+b22ASJRuncV9IjRfnePkn69qcq3jlaFtbI5LujHr+zAc7XXiB
         BhwHpRyrtP0yAZr9tddXC1NHeKxhpesJOaBLE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767906213; x=1768511013;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KWJ9wlAAp+rcwWYxQycgsvIbLJCcypF3l4SCpiLlS3U=;
        b=eL9lZ5APFzgG9qhrCS8429TrGy4te1wiIjAfLYyWcnti4VqTphivt106mkQ7wuoFJJ
         Yz5OGm9ql6jc383HSaqLCIy3Xoje/pt26fstygkyQSV+spS1SzE+LjFsxL7zwvjSMYht
         mFrU99wN51UzNPIrl9+YqbZUJ+M/bSF3VK0QnwCvg0Mb/mwcEmC/sjmMed1GMhqz2BVj
         B9UJ+RkYK6zh4nVbs9pqz8VSRw91EEMDQfLihnqp4CdeY0y28ZHUuu7UJDBroZyTjVCQ
         fY5gO+tbcsEsEZFZtvzOX5NNViISK0gODhNR/njaBvOb7FAfoAOsjYiUPq3w5n2Yb2wc
         0X0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXIOmlsSOikXu7dJx22ukhm9ymBl1ugUJqhJsFUj/Ff2eNZUl/XA4AESqDdTFWArM3VK/RD5kEg58hJoYiJtfK/iqk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzW4VRng//RyHUnUT7QzWXTzhHVGMRkHY+fFr01qzv/b96U0Us
	IGCcxMAGSAo9X8SAVT4EOE634r894O7bZ0NxiJyoJA8/5fMQbajxhmR+0NYIXlRwbYc=
X-Gm-Gg: AY/fxX5z2UDd9aqaBbvSax/7fVBo3eYcs+fJ+BvhRCAIIAdvfpBCdFQ67HvWudONsMK
	dYtFRpkcWJoMVmYdAFi6k8ZuMR19E0UAFyYr7pRWUW0L2VVU0b+psUw7QTUUap4nok3JsqIwZvY
	S8WZ/oo1jsJVndSI0TAIs1fl3ZAuLqHq6M2XpQXAQCVUubhHJu6v0FYlOSyKe5T1FV7ZVmY4jyC
	2R/Fzy8tqAIxIV3dH9RJJfW7610giLKDyay5COnai4cTShfNoDvdyqItxjrM+gkWED3VvVZm3MC
	XCaEpAmKqW5XiXG1b7/FM5i4iUI3PB8wGsw9Y8LdgQev8VnRZg8arZv5loF/DSRRN/6a+liJvPB
	sLNYcGU/owDoizs+WqisMF8rLxUFlkHOFJigvJU3w6TSj/yEevf+p5cdO34HXhvyZsbCA3s+bQo
	sIAnN7ECbzkN/9bfMC/Fsc5w8=
X-Google-Smtp-Source: AGHT+IF7oBTAj1SQq5E7x4Lp2yS5G+05oiI4AeWK5URw/2g45YlRqYJG+eRpLe6BMKwkyiOICkHLfA==
X-Received: by 2002:a05:6820:160c:b0:65f:1038:1310 with SMTP id 006d021491bc7-65f54ed4383mr3499680eaf.6.1767906213554;
        Thu, 08 Jan 2026 13:03:33 -0800 (PST)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65f48beb796sm3583117eaf.7.2026.01.08.13.03.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jan 2026 13:03:33 -0800 (PST)
Message-ID: <3d31087c-ce86-4ce2-9b70-f955720a7311@linuxfoundation.org>
Date: Thu, 8 Jan 2026 14:03:31 -0700
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests/tracing: Fix test_multiple_writes stall
To: Steven Rostedt <rostedt@goodmis.org>, Shuah <shuah@kernel.org>
Cc: Fushuai Wang <fushuai.wang@linux.dev>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 mathieu.desnoyers@efficios.com, mhiramat@kernel.org, wangfushuai@baidu.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20251227041821.75504-1-fushuai.wang@linux.dev>
 <20260107034914.22315-1-fushuai.wang@linux.dev>
 <20260107101846.61c182e0@gandalf.local.home>
 <4513bb41-e493-48bb-bd58-f1cc3ea44e5f@kernel.org>
 <20260108144842.0663008c@gandalf.local.home>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260108144842.0663008c@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/8/26 12:48, Steven Rostedt wrote:
> On Thu, 8 Jan 2026 11:27:26 -0700
> Shuah <shuah@kernel.org> wrote:
> 
>> Yes I can take this through and send this for rc5 or rc6.
>> But first the following warning needs fixing before I can
>> apply the patch
>>
>> WARNING: From:/Signed-off-by: email address mismatch: 'From: Fushuai Wang <fushuai.wang@linux.dev>' != 'Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>'
> 
> Hmm, do emails have to match? There's times I used a different SoB than the
> From. The From is different than the SoB. The important part I found was to
> make sure the name is the same. But I didn't think the email address was
> important. And this will become more of an issue, as gmail blocks my
> goodmis.org account, so I send with my kernel.org account when my goodmis
> is the only one I sign off with. Thus this restriction will fail for me on
> my patches.

I go by the warning - I don't take patches unless From address
matches the SoB.

thanks,
-- Shuah
