Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118D85616A3
	for <linux-trace-kernel@vger.kernel.org>; Wed, 14 Oct 2026 15:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791992866; cv=none; b=A3r2oU9AX0EWCBCzjVDX7PzQlL6U8LHIUD/PbaqlNXxwYgOYPgSOx/kyZvYErDppUiJ7ivkrkoZ9iZh8AFMd1ZRMTYu5DfzfgfuBdZ08vfQVOK9uI4++dmGCWhC8m20X9geOYlfkUZbjtBGUUyTcid02FyxlrPo72v7kxwoyaaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791992866; c=relaxed/simple;
	bh=SkAmdc7sm1QGFa88r7L2o9h1gMKzRqFxqZadMw5RWWg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rGNY8hjByGjZ1nDbA2UYCXQPut0Fz0hz42Du4PJEMz/Jwj+8Wry2cGPLIfA2nTCnVXxy/XaPg9ggYi3GHjPGXVPR1KsGMaoV5MgRfRqVt7HCIh/LCO+lx5K7ePrfT+AnKhdlPCcORbmcwdTioEUEMTr05G2aNbZbMBwvgkiCLSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YJVvz27t; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YJVvz27t"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-49de8ea072cso1763460fac.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 14 Oct 2026 08:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1791992857; x=1792597657; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w5511ufpkaRG+DS2pNSBB2urvZrk4kAcuDxdZDLA2qs=;
        b=YJVvz27tC+x47sjJCos/rtOw8nA1vqoAgxoCp8avlT6s1QnQOTPcmtgPLt4fAakC0a
         b+5qvhoW0hJg2a6lL4LIZoDOiglAZaEooDsoUO/9WTkyppA4psczRZRXk7NhRhRGHpEr
         16qMUyN1Nk21YmsdJR/3SLThCoOcU8euxgHXU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791992857; x=1792597657;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w5511ufpkaRG+DS2pNSBB2urvZrk4kAcuDxdZDLA2qs=;
        b=jeimNn6+bFvCw4tuGYPz8zuP4w9NZQs4Apf2ITEVgvDLMRTRPpljU+ly/S9XWDfpfL
         MRpQoxQTKij838crIFLofZkBsNQz01Tc6MtEmirW9M8HAU3r6SW+M8CIUfR6TdJYm1uP
         MDd1iIjQpQ7AylLCqBQtEUxs8rPQzkWcUSUSHqcUHay1UN5C0TMHDwq9ZExy7HFtF9OH
         /bam/JUj19+qnn9UeWel/gqHhlfwNCKKQH0LwGZ1U5kd3xKi5H8Xt7UfncgPpw6oswHs
         vWGQcTiPs3GCISgpgJSjo/p7w6u5rThyrWdVG2Re2yWXeJxlquKtQW2vTI9u77BrrzbR
         sFNQ==
X-Forwarded-Encrypted: i=1; AKwUvBxzdaGfI3dJL9v2N4dhX/yMlo4nAs1w54tLoFuhXvYffBNyrPq+SrUw8v2IQDb1XTTrUXFTl6OSmHvCyanUHkjsgMc=@vger.kernel.org
X-Gm-Message-State: AFq9FYJiRySNUhmfZxPHLn3VuGfmmgzPMmNhEzNAcCl/Qzki7/Hs3NyA
	5kT/H3cJhvXq5+gZYpRL8oRG2z9TgyknuBRup0eHihMzUnOXP7v/lIU5ApVQMv2rHt8=
X-Gm-Gg: AYBFou3Nw6bffBeyGB7wchXzwbDOEStG2mwqJLHyUpLlTQoec+kiQasPBU5L5kCXdqI
	/DQuCpVlIxOQfTSyRWaQGka+HlZecvKrfyMZV7OCSsOI6orNuEP2kAN1LS71zBpzGYqYuBMyYpI
	tCkLZYgmO2TnSJF2b6fQogM+xV2miGBUSyqja1G0dFjWwbpj1QnAH9bIA8cJvp6XCcShLIEbjuj
	UMurXImjsjnFplzOzbHqQ2RC4KGxhGAR5ltXz/lmC8d//8sLm4aeQLLQLbTQi07lU7jLdeoxlnn
	lgqI1eEEPGwhuI1S1OXxqH1b3bDCqAsQ7bZVuh5eBaZvYPpNEErlfk8Hfmu/zGjwU+J3jfvirvC
	KfAobc0IF2ZENP2aISthbOKtFfia9TpzGcYtsSyJ31GerMNb/uaoZ1QYKsq1EdQ51La1eEnEirj
	CChjY1ma/ZNN2do/15A2etz+XsMYQukIZod49IOK2ZdXKQTV/PACGA0hyPsbIFCCifUg0ufSE/e
	cmBkKMK
X-Received: by 2002:a05:6871:7a1:b0:49d:c9ed:21f2 with SMTP id 586e51a60fabf-4a2a8937f07mr15344175fac.18.1791992857074;
        Wed, 14 Oct 2026 08:47:37 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a6df881fbfsm2366117fac.2.2026.10.14.08.47.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2026 08:47:36 -0700 (PDT)
Message-ID: <9534e333-c44f-455a-9704-d8d0f32d0d80@linuxfoundation.org>
Date: Wed, 14 Oct 2026 09:47:33 -0600
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/ftrace: Avoid unlink error on first run
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Jaewon Jung <jaewon8868@gmail.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 "Steven Rostedt (Google)" <rostedt@goodmis.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20261014114839.6258-1-jaewon8868@gmail.com>
 <20261014142147.95DB11F000C4@smtp.kernel.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20261014142147.95DB11F000C4@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/14/26 08:21, Masami Hiramatsu (Google) wrote:
> On Wed, 14 Oct 2026 20:48:25 +0900, Jaewon Jung <jaewon8868@gmail.com> wrote:
>> On the first run, ftracetest tries to unlink a symlink that does not
>> exist.
>> Use rm -f to avoid the "No such file or directory" error.
>>
>> Fixes: 7dc1e125f07a ("ftrace/selftests: Add softlink to latest log directory")
>> Signed-off-by: Jaewon Jung <jaewon8868@gmail.com>
> 
> Looks good to me.
> 
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Shuah, will you pick this?

Done.

thanks,
-- Shuah
