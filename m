Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096E8393DD8
	for <linux-trace-kernel@vger.kernel.org>; Wed,  8 Apr 2026 21:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775683363; cv=none; b=f+j+on88QT7fDQP5vz5iWGp2Tj9yYPlhJUlOl3DG7/STesQ94DDLQb6xtyn+GC+8jh3EqHnHojjCNu8Rnacuyia1BUs6Xj1aQGDYi4OlvzLMOgQ3jv8TRkRVbeFGTh/iyF51f//xPmiNsXqRrRYg4nHH3X7oD0CjAeT1faaL+v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775683363; c=relaxed/simple;
	bh=6BeHkxLyWctFUSR46MfqmCh8uAhV3DyrDuxgljfGSGw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c5aeOWT0YyX1eQ+COiPji3gnOGpB7MZqRNvAgAYs4jeb3uivOiv8x5CvphpAclgGd/Qf8NnVmCIOFpSHhizT0AuOGmUx6wFA1K5AvHAZna1NnYkO/0fXf46bWvDJPjLRYBwt8RFLWViyABo+/o8GSxek7oII031S1FnbrOufxhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fc9oSzG8; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fc9oSzG8"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7d556c1a79eso287311a34.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 08 Apr 2026 14:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1775683359; x=1776288159; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SP33wRSGcLjNkqt9PmKyMhjJTYVxYcQC6XjnQNqNNFs=;
        b=fc9oSzG87Zf6UlihO7nchOxdHK9zLnEToTfCJ9ovupyoVT1dNBAK4iKkymuusKSUt4
         pxA3WSznsQkRy0bcFgJbVKoPzaacVBV6DB0nEN2fATHuc36sbRUlH/um6zN63jccKKAL
         X/PnC3XO5tdXQjsDpBsfb1n4RI2DFhILYVNKM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775683359; x=1776288159;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SP33wRSGcLjNkqt9PmKyMhjJTYVxYcQC6XjnQNqNNFs=;
        b=FtPliQcyrdYg5F5/NsWCiS5AaMYveuTxzaJMnwZjBm27FSUHZl47Tc+O4Qn/NK3TMZ
         LhiQEW8PyIa/uKCGEqpJ+abPQ/61h9TjGINYV3PfAEukI5KeuJ1J6teHXhb6ECp0hV4I
         7YpxkzF1vj5F6fzYsJBFSyNRIcRTWmbo5jYIebXM69S4C4bcXim4KjABgQrvOHVkyPvy
         c9O1wwKOo6/uRBXmk4R80egQXjZJb7OF4tMefCmQMidOfLELNyzx4/4mbMeD8wMif/xE
         QhsTH2vwH4iDJOrW00FZcWREZHKnwiN4kGEsLGAOF29F8FDLe0VlTjybd8CySwrsggCi
         MeeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUICQRZk9pCQ7xMGUGEAtqclC9LWE/Mv2r93Evpx1rsWZ4sGF0Ekv27nZ88rapP6DP3Kp6rDIfXlgO+de/qE9N/BLo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCbxiXov1W2sbRwemFR7Pf2kp/Xy7cmgM2uD8AIuwPQ6jxaZwG
	spCx5WMQqZRoHT6mEKRgCYPiSxF4SHU8WenyOktVmkeNoCqhgu4mpBQ2k+zLdF/xzbBlvYeP8/G
	zHGRXBWg=
X-Gm-Gg: AeBDieuLXOPlszppTMXpzniqOTKbRuCs9Cmly9ytdsxqiaI4xuGJcdPTQ2kqGM7l1c7
	OfUnkcWp93vlQyqoK79oM+eRfgFA0RIbQWwClSkLcruMkwAfmJyJRxxkEnlGtblJS6WdRHbSqTj
	75NFj3D2K7iav1wlgzS2g/a9pK5jRfHNxtgjp9j7xEikhC9qLeydT1IKtXvYVlQali7GeQLCYvi
	q+vuNAZ4oM/6YawHK794yaK1D11lK5ZxdL9jsh0WML3X27iS/VWch4uEv6/QKkEe4NckXYwk+iJ
	1Hro8MM2Cf2wdis3EBYCDjCRjZQFhfPapMAvPFvBm5vNWkjq+9MfkPI2Pyhecj+P2PciOeUh7nh
	B2EhorK22dTqBYeHkeQehcLcw+KOxu+tVK0oj95Ek37ECnhn4MudjmcrzO9a0R4khAdToU3z6L7
	hR6a6NowF6Kx/yvqBjTypjafbMXzwSXmpNFro=
X-Received: by 2002:a05:6830:91f:b0:7d7:ccc7:c546 with SMTP id 46e09a7af769-7dbb755b224mr15665376a34.23.1775683358738;
        Wed, 08 Apr 2026 14:22:38 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dbfc1cb79esm3531705a34.15.2026.04.08.14.22.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2026 14:22:38 -0700 (PDT)
Message-ID: <eb5022d6-a09b-4521-b847-a9a5d66c144a@linuxfoundation.org>
Date: Wed, 8 Apr 2026 15:22:37 -0600
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/ftrace: Quote check_requires comparisons
To: Steven Rostedt <rostedt@goodmis.org>, Cao Ruichuang <create0818@163.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com, shuah@kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20260408043212.8063-1-create0818@163.com>
 <20260408171831.69520c50@gandalf.local.home>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260408171831.69520c50@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/8/26 15:18, Steven Rostedt wrote:
> On Wed,  8 Apr 2026 12:32:12 +0800
> Cao Ruichuang <create0818@163.com> wrote:
> 
>> check_requires() compares requirement strings that can contain shell
>> pattern characters such as '[' and ']'. Under /bin/sh, the unquoted
>> test expressions can emit 'unexpected operator' warnings while parsing
>> README-backed requirements.
>>
>> Quote the relevant comparisons and path checks so the helper handles
>> those patterns without spurious shell warnings.
>>
>> Validated by rerunning fprobe_syntax_errors.tc and confirming the
>> previous '/bin/sh: unexpected operator' lines disappear from the
>> detailed ftracetest log.
>>
>> Signed-off-by: Cao Ruichuang <create0818@163.com>
> 
> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> 
> Shuah,
> 
> Care to take this through your tree?
> 
> -- Steve

Yes - I can take this for the merge window.

thanks,
-- Shuah
