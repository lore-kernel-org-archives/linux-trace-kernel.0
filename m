Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BD1D517;
	Fri, 11 Oct 2024 14:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728655761; cv=none; b=hKJodcTLFytUW0U7gpZ9gaOuodcBeDyabUmlvk8xk4/rwmhlnfgY+33S0nOcxWKGqfikg6d7FjC3QuCy6jnoka4PhkOUJLUfbdzBePLTUyzAJkd70VBNFVp5I7rSPkBedbxRDKwcn8ZmKS+VDNymqpYwdb773at5Z1EEyujHdPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728655761; c=relaxed/simple;
	bh=SWJI6AtNFeMCvy+plH9cRhAgS79km6odsVVk8npktac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uEukxSb7T15ubph2ixvkEXpgQR3jKS1I36vxAXiMMRk1CSM6cdUdZk075LXHtF4G94Pfu4YFnCMb2OC0lDHGdYLBMvnEMw08yy2M3bnyhjN1vjXqF2/SGIKsJLzsvv1KlhP2dNhu6Y+VGRbOGMPt6zIjjwaupQTLibCRX8sj3Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aqoK3Qms; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aqoK3Qms"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-71df468496fso1960209b3a.1;
        Fri, 11 Oct 2024 07:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728655759; x=1729260559; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rcg0ROco3qLe8jIJ+Thg083U2+rmvUpLmc/6AhnQr9A=;
        b=aqoK3Qms4n4IErcGOqUCQras7jnwbqRp8z7nosXhpwNCcdehb97XEuBF6Oo+Vje4PG
         012HvjlxxRc1+kXORTQNsjyAYo+rK9caVJZZ6RAys8zH8T9ak6SvctJLyO93dJ8sRUQR
         /+ITNaFUgeveYPMdbybW9UGfugcge04ioVCNAUCSZ488j9HbCjpTywLySUcaegteYy3L
         QYk2U2iIImrNRv0tD/myVmN+FFt0iJ+16mLiKclwIjy8kiwRR+BZmEv35SSLHmli3uHI
         wilGhJjTy+mkwmAgHDIjGWh3yuodlVSKQVU7KAGGWEEoxJHWblUGS+f3DurpsavnLLbu
         ktMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728655759; x=1729260559;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rcg0ROco3qLe8jIJ+Thg083U2+rmvUpLmc/6AhnQr9A=;
        b=K0xtAnwhNZTdZUyXbHJyiEGLvq4vg18HOsDRZx7ouedu2hpkOXl8lMY0O+YhQL5DWY
         +lwBlX0EuUpc8Pk/sN+RKMD8CDtZN3Lcv1KR78VkEMyOKXy/fhdiw5Z1JlqZO2dct0qO
         rrOHLLFah4B+2FHHuXfOXalRTYNeZE2cNH991TJ84AKBI5uNnvUO7H+4nBj6sencvjJY
         HbEC8bXdCs6crRVWe4GTQ2oEqRgYI4nuef+6Er5ZKkOKR6pNfVsfn6aHAORVWfRaZ3tu
         +CcFTD8C1iDVZschuRGLemZb4Tm8tSEz+AfdokxUmxdeBAg3pG1DHgEHHmZg1YYhX7/z
         srAw==
X-Forwarded-Encrypted: i=1; AJvYcCU9OWrJ+yzzTzPpZWyFcbWn/ADZMICNpeH+gcBEQzEt4d30s+H804MIewK7aXAomBPtiUWQ89oTG2k4bXW/mvcFTgan@vger.kernel.org, AJvYcCWcaQb+rNYqnrL4YjGQn2SaKuD6Rhg+J+ekwJyo5S5XZwlUXQJ10RpPRQosggbuuzPfPr7SKYg0RtA3nGm6@vger.kernel.org, AJvYcCWvu+Q2DUa7n0lysgJWOKdKLmj3pMpaZIBKNRyPFVm/PKnzyWkYFe6iWgeSbDwruxHuHnAOOR1HsH4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXyqnHGY5mkUAguAdUax0UdjDGri8oA3BkAgvQC1NSKq5aKMDJ
	R459obZfhH6KwrzAQsSsXPSu623K8pXpn9iYEyfscElFDG8Tu27Zs9OO0WwN
X-Google-Smtp-Source: AGHT+IFe0JYKeAj4bzyu3lnqsbMeGoDavyNJ+1+e78xHDD7VxRZpU8+w4HyJUo6GbvphhM+vKSYStQ==
X-Received: by 2002:a05:6a00:9a1:b0:71d:f215:1d96 with SMTP id d2e1a72fcca58-71e37e287e7mr4971182b3a.6.1728655759072;
        Fri, 11 Oct 2024 07:09:19 -0700 (PDT)
Received: from ?IPV6:2409:40c0:11a4:8d8a:49e2:9be2:176a:6b10? ([2409:40c0:11a4:8d8a:49e2:9be2:176a:6b10])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e2a9e9607sm2616856b3a.7.2024.10.11.07.09.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2024 07:09:18 -0700 (PDT)
Message-ID: <2ccc6f29-45d1-48b4-b39f-3b2a01cb6068@gmail.com>
Date: Fri, 11 Oct 2024 19:39:12 +0530
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: fix WARNING document not included in any toctree
To: Jonathan Corbet <corbet@lwn.net>, Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <20241002195817.22972-1-surajsonawane0215@gmail.com>
 <20241010154708.0bf658a3@gandalf.local.home> <87y12vzqg0.fsf@trenco.lwn.net>
 <e7851def-91ce-43e7-880a-22dc5752c4ad@gmail.com>
 <87h69izs3b.fsf@trenco.lwn.net>
Content-Language: en-US
From: Suraj Sonawane <surajsonawane0215@gmail.com>
In-Reply-To: <87h69izs3b.fsf@trenco.lwn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/10/24 18:58, Jonathan Corbet wrote:
> Suraj Sonawane <surajsonawane0215@gmail.com> writes:
> 
>> Can I send an updated patch with this change (moving debugging section
>> to the top)?
> 
> The patch is already applied, so no.  You can send a new patch against
> docs-next if that sort of movement is warranted.

Sure! I will send a patch against docs-next to move the debugging 
section to the top.

> 
> Honestly, though, just shuffling one file around only seems so useful.
> What would be nice would be to turn index.rst into a good starting point
> for people wanting to learn about tracing, rather than just a jumble of
> files.  It needs organization into sections and some connecting text; as
> an example, see the (minimal) organizational work that I did for
> Documentation/process/index.rst.
> 
> It's more work, but would certainly pay off.
> 
> Thanks,
> 
> jon

I’ve also seen the structure in Documentation/process/index.rst with the 
clear titles and descriptions.

Thanks,
Suraj Sonawane
