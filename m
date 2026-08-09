Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206AA361DD5;
	Sun,  9 Aug 2026 17:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786296094; cv=none; b=A5m1r3FE/moxUnuF60tIfPvlcNsMkqD2lWkrP0bRou+9jvucyHWsbd50Y/ytgM8UAhE5D1N0cCWgVu332UweIE01h9r8nx5bJ4sjx64DbTchUL3O4U8mbL/hrIr9daySAJplO2WNoYFeKraRJg3kntE/aGz3WNn5fAizDo0Pxmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786296094; c=relaxed/simple;
	bh=06eRDGSesyyikSHx5gzLOoHxQDhIMGfAYpqDapsA/vE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r8/qtn+w3ne65tK8YZopAu9hpjfkxkWxSb3u1JtxZfNu2IAFnwNe9+R2Dj6jW24qt4V9xb/zmtCR+EGh/eQRbFxbJ7qS8DVb6u1Vc1yPzHyORUB21dm5Gf083gju6a6IwrhM01vnNx0+lYoQjkvDwabc/RjHc/GTeIpKx4HO5ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HTi5RX1L; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HTi5RX1L"
Message-ID: <a2671b5d-7c74-4fbd-bd38-ef3896516436@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786296090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0eXjLu0Rt/JYzWltTiPUPJnVkCAAxkayHWx+cY5ykGI=;
	b=HTi5RX1L1ITkx+DZUyndaOFI6lX8UkwDSrHjcdX/pFYt3ppihXDcCg1XTP2vfQORLehSeI
	3lEOBJLQbKZF2aAFNt/6pAz/dgJ4hZAL2HHsLxpBdqZ99SAABcab5gI9txybCuj7+MPwzI
	KJjVvN6jrvcEpVvZ2/omzuB/DFy+tHA=
Date: Mon, 10 Aug 2026 01:21:07 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 3/4] rv/reactors: export rv_register_reactor() and
 rv_unregister_reactor()
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1785695669.git.wen.yang@linux.dev>
 <d228eefa5ae3616f3d96640583cc2be771a83c82.1785695669.git.wen.yang@linux.dev>
 <6943bc6d81388939512772b602f0c920ef0e5b01.camel@redhat.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Wen Yang <wen.yang@linux.dev>
In-Reply-To: <6943bc6d81388939512772b602f0c920ef0e5b01.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 8/3/26 14:32, Gabriele Monaco wrote:
> On Mon, 2026-08-03 at 02:43 +0800, wen.yang@linux.dev wrote:
>> From: Wen Yang <wen.yang@linux.dev>
>>
>> rv_react() is exported to modules, but the reactor registration helpers
>> are not.  Export them with EXPORT_SYMBOL_GPL() so reactor modules and
>> the tristate KUnit test module can register and unregister reactors
>> without hitting undefined symbol errors at load time.
> 
> Nit, but I believe you meant /link/ time (modpost). Linking phase would fail at
> the end of the build and you wouldn't have anything (.ko) to load.
> 
> Anyway patch looks good:
> 
> Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
> 

You are correct, thank you for the nit.  Missing EXPORT_SYMBOL_GPL() is 
caught by modpost at link time; no .ko is produced, so "load time" was 
wrong.  Fixed in v3:
   "Export them with EXPORT_SYMBOL_GPL() so reactor modules and
    the tristate KUnit test module can register and unregister reactors
    without hitting undefined symbol errors at link time(modpost)."

--
Best wishes,
Wen


> 
>>
>> Signed-off-by: Wen Yang <wen.yang@linux.dev>
>> ---
>>   kernel/trace/rv/rv_reactors.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/kernel/trace/rv/rv_reactors.c b/kernel/trace/rv/rv_reactors.c
>> index cd571b1649f5..228ed043bd73 100644
>> --- a/kernel/trace/rv/rv_reactors.c
>> +++ b/kernel/trace/rv/rv_reactors.c
>> @@ -314,6 +314,7 @@ int rv_register_reactor(struct rv_reactor *reactor)
>>   	guard(mutex)(&rv_interface_lock);
>>   	return __rv_register_reactor(reactor);
>>   }
>> +EXPORT_SYMBOL_GPL(rv_register_reactor);
>>   
>>   /**
>>    * rv_unregister_reactor - unregister a rv reactor.
>> @@ -327,6 +328,7 @@ int rv_unregister_reactor(struct rv_reactor *reactor)
>>   	list_del(&reactor->list);
>>   	return 0;
>>   }
>> +EXPORT_SYMBOL_GPL(rv_unregister_reactor);
>>   
>>   /*
>>    * reacting_on interface.
> 
