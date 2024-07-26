Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BB1176AB6
	for <linux-trace-kernel@vger.kernel.org>; Fri, 26 Jul 2024 08:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721982310; cv=none; b=jjPKyP/kTYXmNU73t7mpcsLyHlDAInBrps9f3MmYAfsgri/vmvi0UlQFTQjoonLIknyYNm84Udv5zcnMhEFNU/8P8Lxr/gkMK6EgOBKTlWCjYJzbBwi7vAfX5Z2ar6omtHflbN/Urz/kx8cU/td3Vy2TQznsi9xqtwPMdnr4vF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721982310; c=relaxed/simple;
	bh=jbjIlEsz/rUHNNmvK3K3tBZC2zL1xHqph3zcFTj8ugs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s+yfN6rwNCuraeb/ciJ5TTKpWmy7ABn/0wvPrVxrmdtNgZ6vpjHgTnseDpmjazAarGuqZL+0Tm+Oy9luJOvHMzTRyzCvD2fWpWw0R2dInuAKvKrF+2zgmMSpiEqBFm4br8jqip91bLi8mKAvl13c7k8rQoetCFxPCYSxrIl+oyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=grsecurity.net; spf=pass smtp.mailfrom=opensrcsec.com; dkim=pass (2048-bit key) header.d=grsecurity.net header.i=@grsecurity.net header.b=RXWvlyzu; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=grsecurity.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensrcsec.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=grsecurity.net header.i=@grsecurity.net header.b="RXWvlyzu"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a7ad02501c3so160744366b.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 26 Jul 2024 01:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec; t=1721982307; x=1722587107; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HaNgKcqQ131GMelXGkTt/N9gIuFIqTNTFxN3e5+3Ods=;
        b=RXWvlyzu/TgFPc1QIKy7lBfTvy0G5VIC8l5KV6AFhp/kDgCsOwNsrgZVFjFlRUwyKz
         vKEGlsQ04r5S4ANQtl6dzBe6bIzSjXvYeK6j8zGUD0GiHCXO3uzX80xnHUQi1Ya3aIT4
         xjGpRbfMgIr87Zd0Baue9RrrFNdaCzT7lkYMaMmLw+sXLGND7LcBi7ByhBbQ7noeEc/G
         4VozIXEtx0sHIhwIOfmhvH5fjOMW+mxy6hAuD47sV7bwuCAOpBBGCXlrni7f1xwQzAnp
         9ygS7qc3rpZLuzo40eStw4/zdt7jmV/Kv8NLP942pIO9INUX925SG6O9okz6yJFescHh
         Wukg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721982307; x=1722587107;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HaNgKcqQ131GMelXGkTt/N9gIuFIqTNTFxN3e5+3Ods=;
        b=S9YGXpSkijS23gySIzlMADOeA66Ku6k+iNr99H2t1Gx7JPbW5ebQdC89KWhtmG+x6t
         Es1s14/Y29xDgP+OeWFf1imcZ8A8fxjaj71TyJxELSfhpRCxDnvakLHyKg7uriYmbYJu
         JCOnnXgqqrv1gMN8jZ3jaAhR5IvPckxL6a8xg+dcNHPMryxCyidoF6uTaadimNbDaEmc
         eMP11o8b15YKfJ+w+u8rvSW8anbVkOxKgAta1qS/KKxtAmyjaWo32Mq+slqzBaj2ck/A
         HQKqAyUzjaX5FfKgXnagbJWvFbWrl9WPcYGuW08/ZSYEYdxbLAXwhDEujEdzV5hPL/k7
         jErA==
X-Forwarded-Encrypted: i=1; AJvYcCVFaTv3kVJCfq+17groEfG2B6+FBO73Ey08Mq054jK3ITlLjcN/iTpepse5jJx/T3qeIlPmbAKY5dJMA7blagj7QaDNjOZVrttljut/8snTdjuq
X-Gm-Message-State: AOJu0YxmKlWqUsxUhaWOuxdM4V+bNvJJwc1Dt3D/rtnpDrgYDLu5oyJi
	89zrVK7IUEucbx0jNFEYAd+a//d8a+DEu4b6nB9u+5A9VvN8aOUxvBkhm/n7JVI=
X-Google-Smtp-Source: AGHT+IFD5ZWCc4dCfBtA9ZCYaVf+brFxoknqOvdwuFJtVkY3bhxwenyjYOSPAWlDJgICSvm+vFoTug==
X-Received: by 2002:a17:907:7244:b0:a7a:a2b7:93ff with SMTP id a640c23a62f3a-a7acb933074mr341973066b.57.1721982307120;
        Fri, 26 Jul 2024 01:25:07 -0700 (PDT)
Received: from ?IPV6:2003:f6:af24:a900:7e45:2c14:7bcc:f1b? (p200300f6af24a9007e452c147bcc0f1b.dip0.t-ipconnect.de. [2003:f6:af24:a900:7e45:2c14:7bcc:f1b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab4de12sm148075666b.51.2024.07.26.01.25.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jul 2024 01:25:06 -0700 (PDT)
Message-ID: <920258cb-d2d5-4065-874a-df5a36c6a563@grsecurity.net>
Date: Fri, 26 Jul 2024 10:25:05 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: tracing: user events UAF crash report
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ajay Kaher <ajay.kaher@broadcom.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, =?UTF-8?Q?Ilkka_Naulap=C3=A4=C3=A4?=
 <digirigawa@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>,
 Al Viro <viro@zeniv.linux.org.uk>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, regressions@leemhuis.info,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Vasavi Sirnapalli <vasavi.sirnapalli@broadcom.com>,
 Alexey Makhalov <alexey.makhalov@broadcom.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Beau Belgrave <beaub@linux.microsoft.com>
References: <20240719204701.1605950-1-minipli@grsecurity.net>
 <CAD2QZ9bDcQ46jOAc_Hxy6sG5-N5RPxw4zPuLK6R+M_GhxZR+=g@mail.gmail.com>
 <5083301c-6dc9-45c9-8106-da683ac6bfbb@grsecurity.net>
 <CAD2QZ9ZxZ+mjfju2JMw3fPATNNWkqT1p97QxXgeGo54AFzQ-Cw@mail.gmail.com>
 <CAD2QZ9bTrQ1p3zTZOXe6Gk4Xq8kjYSziAYAdbTrvRSZzAGPY9A@mail.gmail.com>
 <CAD2QZ9YAzq3jq8CyAcoG9YuMD9XWHbk3jKxAmszuSkJ3mtGoGw@mail.gmail.com>
 <20240725131021.788374d0@gandalf.local.home>
 <20240725131632.64cab267@gandalf.local.home>
 <cff51d4b-80eb-4587-b4ad-bfe7d7361b19@grsecurity.net>
 <20240725150517.3184e078@gandalf.local.home>
 <0d1a8c46-43a7-42d6-bcbf-647a5a68c3c5@grsecurity.net>
 <20240725161519.35fd3bd6@gandalf.local.home>
 <1b1b09fa-0064-429c-9f78-385119c5e691@grsecurity.net>
 <20240725171459.598d9500@gandalf.local.home>
 <a7d66736-80d3-4f3d-9cca-ec46e019b4cb@grsecurity.net>
 <20240725190632.2755cb70@gandalf.local.home>
Content-Language: en-US, de-DE
From: Mathias Krause <minipli@grsecurity.net>
Autocrypt: addr=minipli@grsecurity.net; keydata=
 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
 RzDVkdgPJkL/NFTKZHo5foFXNi89kA==
In-Reply-To: <20240725190632.2755cb70@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26.07.24 01:06, Steven Rostedt wrote:
> On Thu, 25 Jul 2024 23:32:30 +0200
> Mathias Krause <minipli@grsecurity.net> wrote:
> 
>> That was for a single run of
>> tools/testing/selftests/user_events/ftrace_test with the read loop of
>> /sys/kernel/tracing/events/user_events/__test_event/format in a
>> different shell.
>>
>>>
>>> destroy_user_event() which is under event_mutex calls
>>> user_event_set_call_visible() with false, that will then call:
>>>
>>> trace_remove_event_call() -> probe_remove_event_call() ->
>>>  __trace_remove_event_call() -> event_remove() ->
>>>  remove_event_from_tracers()
>>>
>>> Where remove_event_from_tracers() loops over all the instances and will set
>>> each of the file pointers flags associated to the event: EVENT_FILE_FL_FREED
>>>
>>> Then it returns back to destroy_user_event() that would free the event.
>>>
>>> The f_start() that was in your crash, with the new patch, should take the
>>> event_mutex before referencing the event that was freed. And with that flag
>>> being set, it should exit out.  
>>
>> Looking at the very first report:
>>
>> [   76.306946] BUG: KASAN: slab-use-after-free in f_start+0x36e/0x3d0
>>
>> That's what faddr2line gives me:
>>
>> f_start+0x36e/0x3d0:
>> f_start at kernel/trace/trace_events.c:1637 (discriminator 1)
>>
>> Which is:
>> 1635     mutex_lock(&event_mutex);
>> 1636     file = event_file_data(m->private);
>> 1637     if (!file || (file->flags & EVENT_FILE_FL_FREED))
>> 1638         return ERR_PTR(-ENODEV);
> 
> BAH! I finally figured it out.
> 
> I was able to reproduce it and this does stop the UAF from happening.
> 
> The issue was, as a short cut, I had the "format" file's i_private point to
> the "call" entry directly, and not go via the "file". This is because the
> all format files are the same for the same "call", so no reason to
> differentiate them.  The other files maintain state (like the "enable",
> "trigger", etc). But this means if the file were to disappear, the "format"
> file would be unaware of it.
> 
> This should fix it for you. It fixed it for me.

Heureka, it did!

Thanks, Steve!

> 
> -- Steve
> 
> 
> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> index 6ef29eba90ce..852643d957de 100644
> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c
> @@ -1540,7 +1540,8 @@ enum {
>  
>  static void *f_next(struct seq_file *m, void *v, loff_t *pos)
>  {
> -	struct trace_event_call *call = event_file_data(m->private);
> +	struct trace_event_file *file = event_file_data(m->private);
> +	struct trace_event_call *call = file->event_call;
>  	struct list_head *common_head = &ftrace_common_fields;
>  	struct list_head *head = trace_get_fields(call);
>  	struct list_head *node = v;
> @@ -1572,7 +1573,8 @@ static void *f_next(struct seq_file *m, void *v, loff_t *pos)
>  
>  static int f_show(struct seq_file *m, void *v)
>  {
> -	struct trace_event_call *call = event_file_data(m->private);
> +	struct trace_event_file *file = event_file_data(m->private);
> +	struct trace_event_call *call = file->event_call;
>  	struct ftrace_event_field *field;
>  	const char *array_descriptor;
>  
> @@ -1627,12 +1629,14 @@ static int f_show(struct seq_file *m, void *v)
>  
>  static void *f_start(struct seq_file *m, loff_t *pos)
>  {
> +	struct trace_event_file *file;
>  	void *p = (void *)FORMAT_HEADER;
>  	loff_t l = 0;
>  
>  	/* ->stop() is called even if ->start() fails */
>  	mutex_lock(&event_mutex);
> -	if (!event_file_data(m->private))
> +	file = event_file_data(m->private);
> +	if (!file || (file->flags & EVENT_FILE_FL_FREED))
>  		return ERR_PTR(-ENODEV);
>  
>  	while (l < *pos && p)
> @@ -2485,7 +2489,6 @@ static int event_callback(const char *name, umode_t *mode, void **data,
>  	if (strcmp(name, "format") == 0) {
>  		*mode = TRACE_MODE_READ;
>  		*fops = &ftrace_event_format_fops;
> -		*data = call;
>  		return 1;
>  	}
>  

Will ack the patch you send.

Thanks again,
Mathias
