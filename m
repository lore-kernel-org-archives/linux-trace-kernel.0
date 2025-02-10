Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059D21BD01F
	for <linux-trace-kernel@vger.kernel.org>; Mon, 10 Feb 2025 13:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739192681; cv=none; b=kMm3k11Tti5aFxAef+cJIJ0LKfx2f8DdG3QppZMDYxuR6hDT1MvVWEULLQfhQo+SeBAkyHpMRzQEjI55uS7lO4Ga5VUanHhDFttOlQXFYdIA7nI/0cPSpGWFLoO0bOL/es/s1fwK6ObxAcZFDqsqy8zZTioap8FvQqS5FvnqImg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739192681; c=relaxed/simple;
	bh=TMe25nCM0BHpCbFZSwZOPmaumdXtOGeDx95yM36MDSo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IZNXpSt/Re+hw7CApZA3WFG9mNutX12ZLz+dCvtcN1Y9cEjFGossdvREk1ZUgIx7TQDA91Y2+P3zUwJUGIFdrKzf0M25OoB5+WTwg7rWj8bjnjMTlWK1RypZYbh3bif+yOZyACbJwty1OwffSWBVnMPQ21kKcIzxXT9H3LaAKMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gQ3w6er2; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gQ3w6er2"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5de6069ceb5so3164977a12.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 10 Feb 2025 05:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1739192677; x=1739797477; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hm9uRlDDCQDIAslcQYKmjR+S5BDffyTf8LS/XZbmUrI=;
        b=gQ3w6er213XUxlgk/RMCeoc0mHIlQZYk7+2lU/fswduk3U6EkRRpvM6it721Wf7H6l
         bgE+hVidsYfeOC+YTkIrNN4lvRJH4XHwtJbkvComKoGRUr2lORoYBaVrFYP1LedgRmyo
         jSCtxcLTQjUJJRci9YR5SYNnAGvPp8XvZ7+7Xb/aQBCI5F7oSNuHOiJhD5KG1IhDh2B6
         HT+VAcNuJsh5RDVsoSgB3eYunlSA3fTkRUTRiBXJ6hHouqNq/VUEhxGEbQxYt2vgtcp9
         jVc9HZPjSb91bOOfNH9+MV0kcU/PwCCH2tGwGXuUq5QxxpemtMsRI0odMv2iYbfVUk54
         D2zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739192677; x=1739797477;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hm9uRlDDCQDIAslcQYKmjR+S5BDffyTf8LS/XZbmUrI=;
        b=iULKd3nECyNrPykvVJJNgvZ5O4OiYcaJfl54HkJ/ghuNMrneqa/HrRORAsZWJOwYRD
         0mhp/Eqsxgij/jfLVDB7Wv/OQEgvx1haTjwQ0hEql3BLeJHW8DeWVysRC8AqywG5mrgZ
         LKgVoxhhox10/TkYjDcND9xfqC2njzijHcSMb6AlGkpjQMLLeNyyq4CsaWuCof2u9/Fn
         O9QT73/VL9xrWBsfwWtzR2WrTLDPMqyUBLZWGlHfY5119ksFptmjD0WWkdqUJ/B2BsDp
         RUE4ZNMaYvpIOF0AQrX+izE8NDDLXsHZ6vg8NURe97Feb3nuraeQJzcfaLdpJepAzgOc
         kzcA==
X-Forwarded-Encrypted: i=1; AJvYcCUlvLhChEh2kgLQ0oc8exKghs8TXuuvnUgRwkolGgf/WOglWK8iP7nWo6O28lwAmtLyqcfHnWDKhDylxEFQQF73wNo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRrplcQyF7Zw/PO3j0tvoehUbmWH2Xe1FfwE7TdQZYO7H/2/wQ
	1/ItvBo/SKBhcVF7z9QRqsreZ0gCSfssAiiiGgZU301lNoTKB7N+N/cDNgJOuOE=
X-Gm-Gg: ASbGncuXMTIPGIpbS/myf2VPwyUkHQJWHyB6y4ZgsRDArmb36iMmjVp3u0xrlslraYc
	Grg4ziPP7/pVkRjNQ7lLHez1iZX8lH2ed4I1zgKvD3jHH6rs4WWaT1ZJ/eyGVEG9XaLH53s5UT/
	CIn/QUb/qWYdJ7q8qT5JEWcw54XiUlupZBvuOGQfTB3s8kmUMrNp1JEYyPOSlb3K9duzjKtv6aD
	DK7TIwvDV6+6a3Cz+tCfZWVF5CEDXgJbsder18lkd6owbvKtHtbGlYCIylcg8kYDgMxK3poTy4j
	RABk0dQzEECqlKuZI4c=
X-Google-Smtp-Source: AGHT+IH5bimbp5Prf9r8LGmM1cwj8tMFGXaNtz3i9nu0Q13JcpFZkivfkOpeikGkVqCydxuQyh1dFQ==
X-Received: by 2002:a17:907:2ce1:b0:ab7:cd14:2472 with SMTP id a640c23a62f3a-ab7cd146884mr168695366b.23.1739192677096;
        Mon, 10 Feb 2025 05:04:37 -0800 (PST)
Received: from [10.100.51.161] ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab786aa2c60sm759297266b.102.2025.02.10.05.04.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Feb 2025 05:04:36 -0800 (PST)
Message-ID: <bfe05b54-9714-46bc-9b59-ad091897c62d@suse.com>
Date: Mon, 10 Feb 2025 14:04:35 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] module: Add module_for_each_mod() function
To: Steven Rostedt <rostedt@goodmis.org>,
 "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Sami Tolvanen
 <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>,
 linux-modules@vger.kernel.org,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <20250205225031.799739376@goodmis.org>
 <20250205225103.760856859@goodmis.org>
 <20250206142817.91853f475c681bc2ef7ca962@kernel.org>
 <20250206102720.0fd57129@gandalf.local.home>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20250206102720.0fd57129@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/6/25 16:27, Steven Rostedt wrote:
> On Thu, 6 Feb 2025 14:28:17 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
>>> --- a/kernel/module/main.c
>>> +++ b/kernel/module/main.c
>>> @@ -3809,6 +3809,20 @@ bool is_module_text_address(unsigned long addr)
>>>  	return ret;
>>>  }
>>>    
>>
>> It is better to add a kerneldoc for this API.
> 
> Agreed, but I was planning on this changing. Waiting to hear from the
> module maintainers.
> 
>>
>> /** 
>>  * module_for_each_mod() - iterate all modules
>>  * @func: Callback function
>>  * @data: User data
>>  *
>>  * Call the @func with each module in the system. If @func returns !0, this
>>  * stops itrating. Note that @func must not sleep since it is called under
>>  * the preemption disabled.
>>  */
>>
>> BTW, do we really need to disable preempt or is it enough to call
>> rcu_read_lock()?
> 
> Bah, as I expected this function to be changed, I didn't spend too much
> time on looking at its implementation. I just cut and pasted how the other
> loops worked. But yes, it should not be disabling preemption. In fact, I
> think the module code itself should not be disabling preemption!
> 
> I'll have to go and look into that.

The series "module: Use RCU instead of RCU-sched" from Sebastian Andrzej
Siewior cleans this up [1]. It is currently queued on modules-next (for
6.15-rc1).

The new function module_for_each_mod() should then use "guard(rcu)();".

[1] https://lore.kernel.org/linux-modules/20250108090457.512198-1-bigeasy@linutronix.de/

-- 
Thanks,
Petr

>>> +void module_for_each_mod(int(*func)(struct module *mod, void *data), void *data)
>>> +{
>>> +	struct module *mod;
>>> +
>>> +	preempt_disable();
>>> +	list_for_each_entry_rcu(mod, &modules, list) {
>>> +		if (mod->state == MODULE_STATE_UNFORMED)
>>> +			continue;
>>> +		if (func(mod, data))
>>> +			break;
>>> +	}
>>> +	preempt_enable();
>>> +}
>>> +
>>>  /**
>>>   * __module_text_address() - get the module whose code contains an address.
>>>   * @addr: the address.
>>> -- 
> 

