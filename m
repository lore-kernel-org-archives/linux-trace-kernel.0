Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79647145B39
	for <linux-trace-kernel@vger.kernel.org>; Wed,  7 Aug 2024 20:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723063765; cv=none; b=RNEh87W9hUIBqcTC//oGmSIWwyu6fpNdgDUD0jqH+tk6YU9U2YdFtv4vMefdzHCl2vfgKAHe862NF6CmmTgvl22dD9L6vOaC3I2bV9+Oma7FnQ5Eai82O63o2QOYZneJepCkxj5+GKhFtTNnIhVarHUKRBbgX5LNvhYVDvUH1cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723063765; c=relaxed/simple;
	bh=A4ifWneIPuKomiFloatclvYw6Xk4unBhHN3C0QE/lo8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NJg0yqZHvsUE5MaD4tRfxkU63k5pm+OswmwCFeTIKuSIHE6A87PMvNLh0QfcU4fEuqAZ/2ZHzPOSEusaPIyGzhalzF7hlJaCJ3ThIeKUyjY1IEylgOqwbVZNc8KtMsjp3e1//w8lnVUVCWxtrzOIquqeiiXiSXwl3HY5fme8Cyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QGsRVJfv; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QGsRVJfv"
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-39b0826297bso208685ab.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 07 Aug 2024 13:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1723063763; x=1723668563; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A35BH8i+y+G8lGp+6rsc8DzC+k6rWSsJ3H+i3Ublu24=;
        b=QGsRVJfvlAFqqJKWctZsP2dz70cnlo8eJllS9ev8pJhI6SjgBxgzem/XDIEI2cC4Fk
         co0UNaudAY3qgDH6T/zXauFZQH0XndgOkHXw4x+7ibbu6I/0ybFMEM0swzJ7okzwcw7q
         Mk7s4/cZuXvVF/vqByZjfRX1JxMGHGBfuvYlE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723063763; x=1723668563;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A35BH8i+y+G8lGp+6rsc8DzC+k6rWSsJ3H+i3Ublu24=;
        b=dND3RbTwD+UscMGwvro6qityb5zgtVAgjjC1qUc9zgoPYYVtaKygBYyYGKdU0bL8ru
         QTk5JGRNkSkxDnpSWh81IqV4pkwLIjry3EWUvJbRsdQisHIbqM+25z8E2NRpXoM8rdlC
         PKSSn2DF5VafuuAPlpHlERjPnVbGhAjMD1m63bcNVfy2VgythH8x0MtUVoWejSqyPlj5
         NS/bjZRNHg+cMJSvHc+tuKvLFbJbbMosIiFNdIUXFUl82plFnfNJWrP8HJkElKaPRkMj
         //QE4zeDvOZMH55S2+44/RAaBT6jJSOy+xAUq+Imw9iDpq/EgABPchbUUe9qbmjIFpF2
         +lhA==
X-Forwarded-Encrypted: i=1; AJvYcCXj7j6h6b9Q4bwl2btFCW0228CdcxwIY/yfuJkNNcqS8qWVuz48IrZgoSAvvThIjDFVms9UBO3h8CYgz6DpAG3XUqA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMrAWugC9rpgOU7n4vbHn5je28zG1GgiPv9qSI4oDcjo702GNU
	UjiG2RRrmuuv54ggNF8q4QmgaIYRVqLmu7yb3Zbp+zeHAjjbPLYm3VbzjhM4JcwshrTwT//g9Rd
	h
X-Google-Smtp-Source: AGHT+IHC1uRe6tBWqp0tbGMzIoqWnCCrA+bdekxnsQrOQFruZsBen7mj3WNpnf9rnrR3Xd5pZgqJVw==
X-Received: by 2002:a5d:9052:0:b0:81f:9219:4494 with SMTP id ca18e2360f4ac-81fd43e5cdemr1169419239f.2.1723063763601;
        Wed, 07 Aug 2024 13:49:23 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c8d6a27813sm2969273173.96.2024.08.07.13.49.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Aug 2024 13:49:23 -0700 (PDT)
Message-ID: <81512257-d6ab-4488-b400-aeeda1d38649@linuxfoundation.org>
Date: Wed, 7 Aug 2024 14:49:22 -0600
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tracing/selftests: Run the ownership test twice
To: Steven Rostedt <rostedt@goodmis.org>, LKML
 <linux-kernel@vger.kernel.org>,
 Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Ali Zahraee <ahzahraee@gmail.com>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240523124541.7dd4cca9@gandalf.local.home>
 <20240614124151.33ee0dc6@rorschach.local.home>
 <20240807162900.32c8e32f@gandalf.local.home>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240807162900.32c8e32f@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/7/24 14:29, Steven Rostedt wrote:
> On Fri, 14 Jun 2024 12:41:51 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
>> Shuah,
>>
>> Can you take this through your tree?
> 
> Ping!
> 
> -- Steve
> 

Sorry for the delay.

Applied it o linux-kselftest next for Linux 6.12-rc1.

thanks,
-- Shuah

