Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B402459C6
	for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Feb 2025 20:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740603361; cv=none; b=mQUv12S+s0/dbURfMwithaprCLPeJ8rZCUh4vsYJ+MSRBbbBWH8TNmaCosj7QBDO/1DiiGnM1CK/jiI4nqQVaind+gvla5crS14TYrAssexLu7dh/806tdbVhd3AZ6wMoj/fsyZzY3I8s/oprrwc/cK1dkku6A6q9UESXgpAeqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740603361; c=relaxed/simple;
	bh=mqYzICldJl61KdyHfxq8I6OeV9x311OW0csxdK20FtI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MH09v5x2Fr4luvs67nBHDmYCLLW0CS3mTNYvnm1QtpXNDOEZyLvBAIbOvS025OnpGnW7im1PVzbJRRwPgVM4FGP1B4JxndxBpQPU82b6lqA/2/ZPglinG4VH+sLXDnCV+sVplM8vSx5kGcrbPmcIzMo8Dd1hLUaZhnVa2I8Ndj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Cv3MOR7P; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Cv3MOR7P"
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-854a68f5a9cso23300139f.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Feb 2025 12:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1740603359; x=1741208159; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ACXceot6so0qEECSDnrDchyxYrTH5BMNjPgKlk4vqYE=;
        b=Cv3MOR7PfOlBCHo3kE3GZlSf4noqQpj3XAbOflR+DpQjGZAZrsPbajaNp1sPREKfny
         nUZ2l84GiLiptGORPyxWvYXwF5dNwWBzSYPRkWK6QGrhCVvkNYgylNZCLT87d30Fi+Mm
         Uat7XL9Lmj/mu2/22Ekg4F3oV8EcinwsAt7gQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740603359; x=1741208159;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ACXceot6so0qEECSDnrDchyxYrTH5BMNjPgKlk4vqYE=;
        b=q2aIJUH0PVPx15oC+hInvumHy4kMu3Wy72uLSbuxxIMpmy2YZo4wYVvV7hGEGyoYlI
         g6mlveWftgQUMQbp9jOSCXaC8WhO17y5er5Uqy4wRaxNSj+v1EW+G7IxHrGtbfVhnvtx
         bMreZnhjfRORt186kP/eBFRdxM1UapxlMVxlEj/XFSnItV0yrhQHZLaUh7VV+Oz8E7Oe
         e/no+Z8HG+jmNbeJ7wQMQqYFrB+lojGNbyoZ+O721gcd5C3iSZSmNctZQ0bqtG11dhhG
         HJBGPIzPdYoo+XbaRwwtylOP3BoTGP/+W796g3MUWHy0wsvIBh59ozTobFCgftA1bueE
         sBTw==
X-Forwarded-Encrypted: i=1; AJvYcCVX2pEvq8SQz02FYukt4BTMYBp8IKuEsDgZg+M192e4eAAN2I45hAXYifPrCtXczQOnV7vcRBiemQMxm7h26E5gHVU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYwLbCoVYzzXft6iINbznEmecDAxX2RSEPU9n1LlXKlJaGAHXs
	qR/PEDFdGckiPqaXSRjMG48pVJpYjF6yWbS50HnDo8WPcdfwh6C3MASSd+nDzXw=
X-Gm-Gg: ASbGnctINuxBRofK4RAI+lPy0Xp7VjCdoclMcm8JeySfs7fqxKLhyif6XuvZ4nKcGDy
	2p0r4zT/5rv6P/WPP15emjRtspj5z1Zp/JhXBIRfe/Sf04V5l6CoUJDQUDQCPjxWj8LeQ3xOBJ1
	jAISSNI91GI5gdCvSCZ0NInW2jOexjQVwc/hxHoife0qDRSdf3g4j14lcr1OrrA1V669whwhBh8
	FIlL3+DeQXOzRH+s8fx3kcFp8nh3NhgYlj5ZO4eSmRAQTS3dCpt3IZLXiX4Q29qM8gF8qju/NMl
	HQRhlzxhtwbRE9bU5hNM1c+O8l5Hdbqg3oNp
X-Google-Smtp-Source: AGHT+IEdrq2nDcrlokLWu5B99Vt7XXGUTSjVaYnvuG/TeLYt4skaR2JoYGjFSX/j14RH9VpA4xleeA==
X-Received: by 2002:a05:6602:3d0:b0:855:c980:6eb4 with SMTP id ca18e2360f4ac-855dabd790cmr2360259239f.1.1740603359298;
        Wed, 26 Feb 2025 12:55:59 -0800 (PST)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f061f3905fsm21244173.88.2025.02.26.12.55.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 12:55:58 -0800 (PST)
Message-ID: <04c7f895-d587-4023-9fdf-60085c329ff3@linuxfoundation.org>
Date: Wed, 26 Feb 2025 13:55:58 -0700
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/ftrace: Use readelf to find entry point in
 uprobe test
To: Steven Rostedt <rostedt@goodmis.org>, Heiko Carstens <hca@linux.ibm.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20250220130102.2079179-1-hca@linux.ibm.com>
 <20250226121316.7653ae38@gandalf.local.home>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250226121316.7653ae38@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/26/25 10:13, Steven Rostedt wrote:
> On Thu, 20 Feb 2025 14:01:02 +0100
> Heiko Carstens <hca@linux.ibm.com> wrote:
> 
>> The uprobe events test fails on s390, but also on x86 (Fedora 41). The
>> problem appears to be that there is an assumption that adding a uprobe to
>> the beginning of the executable mapping of /bin/sh is sufficient to trigger
>> a uprobe event when /bin/sh is executed.
>>
>> This assumption is not necessarily true. Therefore use "readelf -h" to find
>> the entry point address of /bin/sh and use this address when adding the
>> uprobe event.
>>
>> This adds a dependency to readelf which is not always installed. Therefore
>> add a check and exit with exit_unresolved if it is not installed.
>>
>> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> 
> Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> 
> Shuah,
> 
> Can you take this in your tree?
> 
> -- Steve

Applied to linux_kselftest next for Linux 6.15-rc1.

thanks,
-- Shuah
