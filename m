Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2842322E
	for <linux-trace-kernel@vger.kernel.org>; Fri, 11 Oct 2024 22:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728686880; cv=none; b=BXZsGyv+EdfEQlwWbGjaBQjmp33E3V2uz03W/sTDLAL6M7H5bBiUU/9zR9SqLCRSUlXucOvcW4I+5zhQGQ9zU1slEsz67gGN8/M0DAM1UsSuGt4xxX/Bm+s4cLk3mojz9+uQWDny6beuQAXsVKWI6eP+dDdTQ7PnEtQW7+13HSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728686880; c=relaxed/simple;
	bh=8Wi3JDBUsjlWjnvtJ7Q5guyK217Mdacnj2mhUbIEHjI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X27LVB1S46FoeWHRN7nM9cljcIJltZkLq/WGTdtAUxTmJs8u7LV+YrGdZxWLz+DoXUK35pCYBbX2QuORkWOcuv9V5DIWnOL3AqcCtLAP3SV9dLOOlN2UpWE69xiGcUwluT+x0lJPMGJFgaO9+wcUVtedd9+j33mG8rGC3kHvGWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GrB5jdd+; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GrB5jdd+"
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-8354851fbfaso105594239f.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 11 Oct 2024 15:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1728686878; x=1729291678; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mzp/hzrig+fA9YNT0bwYNz6N6cWFF5q15o65QRPQI4E=;
        b=GrB5jdd+qgnOo36dol5rh2/mE79EVumz1oA77KDdChc+c+ecIhVf/pnuRv9/iPSVwg
         aXht0bAdX0iNvn+dD3z0hjbgGFSaAVVpKh2lLtIB+MW4yiy2YIYAPNr64dY8Bhgfx/Rs
         qtRhDKaCepQRY8bfzTFE8UWEALiTDWXC2rVDw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728686878; x=1729291678;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mzp/hzrig+fA9YNT0bwYNz6N6cWFF5q15o65QRPQI4E=;
        b=WUh7L0V5GTi85lTNntnpAsOlFQV/+XftcnnVuBQH+JyUipKq5tL/ZvyYHqj7sGlgPL
         UVyhbJC2DGjumJKzMaQGtrfY9dpgHd+pHjDlN0D+OAu4C1MbxZQSDfyLdaOU8RmSt8e0
         VgrzMde74qABPsYhf1uOqhQaVqcT6XZ1lXs1Y5mbDxyj2pdFMnRVYlQJRe45vu2/aMcF
         4M96HLg40QLgfPKP6bfHiuw9N4exxgu7YkjHkKH7QY3C3DAXkAgocfR02leb3fTl3UPg
         JaCtdFFlsvJWkkwVpwF4xN42CQlfK4AFZb1MXdr8lprR/wOG773UuqZvboWSsyPWLGUL
         A6dA==
X-Forwarded-Encrypted: i=1; AJvYcCXdKic+OnW+qhpaOVfCsSK//hLS+ID98KPBK1IfVKFX4PkBQTy+ITsBXEgpRTLtXYJvSh2elBN9kFR5TQfSvmEITHc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq/XA+CypJrPGkdKQh3QajkfenMcTMwIlHFaqN6HQqigml7zv2
	0cQoVT6YcjgqWgLsSy29FIB9IWJW1OjlJ3EqRBhWUpdj8IeXrWr1V1pCPhurPXk=
X-Google-Smtp-Source: AGHT+IG0dUmfLDdjMZKEXCHE2/Ff048pzK4ndO/RCt5YWkpFQDA+iNmvFMCE0kNqO61/TE+gAbZIZA==
X-Received: by 2002:a05:6e02:2181:b0:3a0:c88c:e674 with SMTP id e9e14a558f8ab-3a3b5f1de0bmr37302095ab.1.1728686878155;
        Fri, 11 Oct 2024 15:47:58 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a3afdbcd1dsm8935795ab.43.2024.10.11.15.47.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2024 15:47:57 -0700 (PDT)
Message-ID: <e1e59650-0c9d-4100-8e6a-be640caea281@linuxfoundation.org>
Date: Fri, 11 Oct 2024 16:47:56 -0600
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/ftrace: Fix check of return value in
 fgraph-retval.tc test
To: Steven Rostedt <rostedt@goodmis.org>, LKML
 <linux-kernel@vger.kernel.org>,
 Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
 linux-kselftest@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Shuah Khan <shuah@kernel.org>, Donglin Peng <pengdonglin@xiaomi.com>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241011132042.435f43cc@gandalf.local.home>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241011132042.435f43cc@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/11/24 11:20, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> The addition of recording both the function name and return address to the
> function graph tracer updated the selftest to check for "=-5" from "= -5".
> But this causes the test to fail on certain configs, as "= -5" is still a
> value that can be returned if function addresses are not enabled (older kernels).
> 
> Check for both "=-5" and " -5" as a success value.
> 
> Fixes: 21e92806d39c6 ("function_graph: Support recording and printing the function return address")
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
> 
> Shuah, this update is only for changes in my tree, so you do not need to add it.

Noted. Thank you.

thanks,
-- Shuah
