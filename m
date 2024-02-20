Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AD3151CDC
	for <linux-trace-kernel@vger.kernel.org>; Tue, 20 Feb 2024 21:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708465354; cv=none; b=Rx/DZJgSzvQdN7BrJCnHOj1m3HgngYChWnanAmBY7ghpq0nEHcQgvcJSvPR6GXTnOGdfwZ0dpjpfwmk/XAESF8puejZZVAsUmtqj8AwjnIBaFBpwzf1n0xEkOzp9uCuAWbWmxHDpb1O0/4V0Tjy/3eoO9Xbpi4IUwziZW6ID9wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708465354; c=relaxed/simple;
	bh=mtupyzKIl5eBAyObXYu7ClNxTFVklxdyXiEEeWiAjZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GR0vmdRQucHW7WDFiH8wYiOpucPQeGIxzex9zdUqB9mYqbZ8hmL27d63Eb281me3PCBawl+ptopnqTopeEA571WVysqNQjLUZzzDxfmx/ispjhlNMbB1hYFZ71PB/6oTfhzgQf+BBm4cA9cHjQQulRPoa0w4vl1WpuUrsKvvCrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JDaOXDIE; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JDaOXDIE"
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7c00a2cbcf6so43784639f.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 20 Feb 2024 13:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1708465352; x=1709070152; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8YmZq+TqFKLGPsrxtUBc2VJOHI+Gof9vUlvjw7Nb9oM=;
        b=JDaOXDIENlYfpBvMtDuSwXQi+fwhV/VwAo/Mhi8BwN8NgwMvybrZglIcSALwViTXzc
         uVKFsrwi9y9tNX+WqoBHn/RCPqPWNPkmKeaiMkQZQBM+7dCNEW6Uf73s1h6qRcHEd+D4
         jQKfDmPCngpN/SvDI/r2Y55DVR6ByDzmM+Jtk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708465352; x=1709070152;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8YmZq+TqFKLGPsrxtUBc2VJOHI+Gof9vUlvjw7Nb9oM=;
        b=tGMVNavye9Qa3mRzp22WQnRrTzl/SR+2Sgj436hGKPZWkgVnt9PN0R/2lobZkLxA5Z
         0ffZ1Phg4SAJbzRdMXfC03wiu0lJel8Dv2BpNUyEsfE0aSSWu7DNOG7YGPdABIgNrEiT
         rh62qKBiihFPDKtP11JvqBdElIsMElg7Qo6gowCvJAkRDYB1rw1xF9/SgWhDr0bLdviE
         6lNlftJlNQKqy4Ky/riUzcnXs4dNxfcOV3JW5m3fYOMuah3PGo9qg+Wk+NLJAXP4qHjj
         868KMxkDlHj1Gc06ous93Dm8+n35JBXi8L0ChX1QlaxotghivC1PKL42YmkwqkZVx7oA
         mxEw==
X-Forwarded-Encrypted: i=1; AJvYcCU2XVhDpSD+/xvPkPYsz9Vv5OpdqfQyCh5apT4mBc54TOTtIah2YEke92ZL/Cm4w9lSkMraAoiGZ79deBacu7A0lU9YQcQODrhr7ntCZKvp3dpi
X-Gm-Message-State: AOJu0Yyt+45I2IiAQ3v7CThvPAezbLkUpo3z4ZFknrlDz4qKRb8183Vx
	/yCKN8v2hFl2KppL5aPcjYr94V3p1ewII0wf/4niDvqOfY4RKDjKsutGA3ZY71U=
X-Google-Smtp-Source: AGHT+IGTdEv4tR+53aX1QG+WHVi5+VE2vQLF7l6s4x8x85tEGwuTMVQ1weUBlQPOS70VbsvR8ISSPg==
X-Received: by 2002:a5e:970a:0:b0:7c4:9ed9:8e7c with SMTP id w10-20020a5e970a000000b007c49ed98e7cmr12773521ioj.0.1708465351791;
        Tue, 20 Feb 2024 13:42:31 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id k24-20020a023358000000b004743a0b8b8csm486095jak.153.2024.02.20.13.42.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 13:42:31 -0800 (PST)
Message-ID: <13d43811-8f3b-41ff-8e9a-2bd989bf4047@linuxfoundation.org>
Date: Tue, 20 Feb 2024 14:42:31 -0700
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: ftrace: fix typo in test description
Content-Language: en-US
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Ali Zahraee <ahzahraee@gmail.com>
Cc: rostedt@goodmis.org, mathieu.desnoyers@efficios.com, shuah@kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240131133306.7723-1-ahzahraee@gmail.com>
 <20240201001308.c206e16376a173d4129ba8ab@kernel.org>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240201001308.c206e16376a173d4129ba8ab@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/31/24 08:13, Masami Hiramatsu (Google) wrote:
> On Wed, 31 Jan 2024 14:33:06 +0100
> Ali Zahraee <ahzahraee@gmail.com> wrote:
> 
>> The typo in the description shows up in test logs and output.
>> This patch submission is part of my application to the Linux Foundation
>> mentorship program: Linux kernel Bug Fixing Spring Unpaid 2024.
>>
> 
> Looks good to me.
> 
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
>> Signed-off-by: Ali Zahraee <ahzahraee@gmail.com>
>> ---

Applied to linux-kselftest next for Linux 6.9-rc1

thanks,
-- Shuah

