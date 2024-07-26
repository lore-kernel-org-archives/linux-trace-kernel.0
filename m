Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6411149C62
	for <linux-trace-kernel@vger.kernel.org>; Fri, 26 Jul 2024 10:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721988982; cv=none; b=B0jkt+KtHzcQT2eTO1OIgsoOCchdQk1WJNjKfpSLxwNvV5obQLCqT74jGy6uLiAYl8acQzYwThldQ1FXrtj6ccn1Bjb81flOh5/lHopjizFi6fnrpfX1feRyNZIHpQAj8LtgWa6AwhOikXgOcb9C9uJVrJ1gh/6wFgt8eBpYBTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721988982; c=relaxed/simple;
	bh=S2Cw4wOqKp7rlOo/3FdPX92/BV8wem10EFtuaXR9M4s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WQ4H8wUr17KqfujRxxM5pte0asUqJ4zzhzhw8Bde3ylOOn+dAQKgw6zkCr2b8sOx2a7vsecJORzvDW+pyrwOl2L4bKfBs9TYaRAbxa9q74kscJ6Mofxg7VP2C/e1YZ04uKw6V/UwRdFzMYVQNgdLrlirvPrncC3J5lxALGOl4/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=grsecurity.net; spf=pass smtp.mailfrom=opensrcsec.com; dkim=pass (2048-bit key) header.d=grsecurity.net header.i=@grsecurity.net header.b=IdsSbbfS; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=grsecurity.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensrcsec.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=grsecurity.net header.i=@grsecurity.net header.b="IdsSbbfS"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2eecd2c6432so16036021fa.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 26 Jul 2024 03:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec; t=1721988978; x=1722593778; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WNNs2x+PGb5CySsof7Q5TyyDOU7D7ycw4aCjdYZo8dU=;
        b=IdsSbbfSnU+nOfDYlpa1YaiU5sM5tAAn/MhzXbGteoQxQYkUvgq7bvFEyvoXAoI1qW
         VtMrczbFJtPqyFKxRcAhzeDuVtFwQ3UfL1vjok8Vxam7wLrd6N48C2adCS9ygMqaX/ad
         QOEYDdmfSrlXFyITVslfcoWgkHN8rYscLH5XESJ9o6qS+pPAw7KCDbAkRIS45xqQRwgq
         dMZGPTUzc+0+pBiY+2iC8baVY4UXSVUowQ1G69ppezLSCbTQ4xfl84FvXUXQNtaeJ/qv
         S/nRDdIQkovJCjtuQCJJLzsFn8N8XfxtnvQeaaKVt5a1Y0TsJ3y7nTBgNTCeEdpALIO9
         7U8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721988978; x=1722593778;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WNNs2x+PGb5CySsof7Q5TyyDOU7D7ycw4aCjdYZo8dU=;
        b=fmIwnj+zPBalV0kI7FwrqhbQfHCCyG8nTFeDNWr8h4XHNPopirkHp6cq6jWRKQUZ4/
         n3R5VrIzDmHFwy7p9DbjeC9oo774eij1hmVKpolyxMTBUARIbMhWQl2C2no3xVLkGLVw
         ETDxpNL2TM4YkzI7+iUWaLySO5HrH2Z1kZJHcYth9mOJAiQlDB3TOuaJeI/rIBbSOORt
         xigGpjd9eN2cnLkDAwvKvQgraT+Mdo5S4Scafmf24v5lnIKw4Zawgf2/7bb1toq6itI5
         ndurgZwQTy28p953cD3HMzp/vY6tO4akHVElBiCRMiXbO7cOM9dQ3hfZ6TzO07JllQON
         /3Uw==
X-Forwarded-Encrypted: i=1; AJvYcCU2E6uE/uAzltFQhXfwnAhhlU57ByK0skrckUWPClME1vaVjOS31tYzr3EGrRJD70kPVx0PYMINDkoWdq+kfkJ35cU2nq+ZKXuXdPxDxeZQ5qHM
X-Gm-Message-State: AOJu0YzB9ubow8qK3jW5lyM6WrG1O4uRXjz0v3YyXs/Wih2NvqB86j8C
	Risg1M/svzXn9ws0UJ45jdrylDTev/mt9ELcJKxGYFrgWHCcDixSEGFt0A+qPTg=
X-Google-Smtp-Source: AGHT+IEyY6IvDlyOtYgHD+CHfInBPlkpTAZJi1Iry+kFQDhDX3pe+WEfSrOXAjIAvLh0rrwdw/mHgQ==
X-Received: by 2002:a2e:b6d0:0:b0:2ef:2c3c:512a with SMTP id 38308e7fff4ca-2f03dbc65fdmr37557921fa.42.1721988978217;
        Fri, 26 Jul 2024 03:16:18 -0700 (PDT)
Received: from ?IPV6:2003:f6:af24:a900:7e45:2c14:7bcc:f1b? (p200300f6af24a9007e452c147bcc0f1b.dip0.t-ipconnect.de. [2003:f6:af24:a900:7e45:2c14:7bcc:f1b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab22ffcsm160735366b.12.2024.07.26.03.16.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jul 2024 03:16:17 -0700 (PDT)
Message-ID: <0b80cb48-6604-44ec-bfa9-f5ec1fc5d7d7@grsecurity.net>
Date: Fri, 26 Jul 2024 12:16:16 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tracing: Have format file honor EVENT_FILE_FL_FREED
To: Steven Rostedt <rostedt@goodmis.org>, LKML
 <linux-kernel@vger.kernel.org>,
 Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Ajay Kaher <ajay.kaher@broadcom.com>, =?UTF-8?Q?Ilkka_Naulap=C3=A4=C3=A4?=
 <digirigawa@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>,
 Al Viro <viro@zeniv.linux.org.uk>, regressions@leemhuis.info,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Beau Belgrave <beaub@linux.microsoft.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Alexey Makhalov <alexey.makhalov@broadcom.com>,
 Vasavi Sirnapalli <vasavi.sirnapalli@broadcom.com>
References: <20240725201517.3c52e4b0@gandalf.local.home>
Content-Language: en-US, de-DE
From: Mathias Krause <minipli@grsecurity.net>
Autocrypt: addr=minipli@grsecurity.net; keydata=
 xsDNBF4u6F8BDAC1kCIyATzlCiDBMrbHoxLywJSUJT9pTbH9MIQIUW8K1m2Ney7a0MTKWQXp
 64/YTQNzekOmta1eZFQ3jqv+iSzfPR/xrDrOKSPrw710nVLC8WL993DrCfG9tm4z3faBPHjp
 zfXBIOuVxObXqhFGvH12vUAAgbPvCp9wwynS1QD6RNUNjnnAxh3SNMxLJbMofyyq5bWK/FVX
 897HLrg9bs12d9b48DkzAQYxcRUNfL9VZlKq1fRbMY9jAhXTV6lcgKxGEJAVqXqOxN8DgZdU
 aj7sMH8GKf3zqYLDvndTDgqqmQe/RF/hAYO+pg7yY1UXpXRlVWcWP7swp8OnfwcJ+PiuNc7E
 gyK2QEY3z5luqFfyQ7308bsawvQcFjiwg+0aPgWawJ422WG8bILV5ylC8y6xqYUeSKv/KTM1
 4zq2vq3Wow63Cd/qyWo6S4IVaEdfdGKVkUFn6FihJD/GxnDJkYJThwBYJpFAqJLj7FtDEiFz
 LXAkv0VBedKwHeBaOAVH6QEAEQEAAc0nTWF0aGlhcyBLcmF1c2UgPG1pbmlwbGlAZ3JzZWN1
 cml0eS5uZXQ+wsERBBMBCgA7AhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAFiEEd7J359B9
 wKgGsB94J4hPxYYBGYYFAmBbH/cCGQEACgkQJ4hPxYYBGYaX/gv/WYhaehD88XjpEO+yC6x7
 bNWQbk7ea+m82fU2x/x6A9L4DN/BXIxqlONzk3ehvW3wt1hcHeF43q1M/z6IthtxSRi059RO
 SarzX3xfXC1pc5YMgCozgE0VRkxH4KXcijLyFFjanXe0HzlnmpIJB6zTT2jgI70q0FvbRpgc
 rs3VKSFb+yud17KSSN/ir1W2LZPK6er6actK03L92A+jaw+F8fJ9kJZfhWDbXNtEE0+94bMa
 cdDWTaZfy6XJviO3ymVe3vBnSDakVE0HwLyIKvfAEok+YzuSYm1Nbd2T0UxgSUZHYlrUUH0y
 tVxjEFyA+iJRSdm0rbAvzpwau5FOgxRQDa9GXH6ie6/ke2EuZc3STNS6EBciJm1qJ7xb2DTf
 SNyOiWdvop+eQZoznJJte931pxkRaGwV+JXDM10jGTfyV7KT9751xdn6b6QjQANTgNnGP3qs
 TO5oU3KukRHgDcivzp6CWb0X/WtKy0Y/54bTJvI0e5KsAz/0iwH19IB0vpYLzsDNBF4u6F8B
 DADwcu4TPgD5aRHLuyGtNUdhP9fqhXxUBA7MMeQIY1kLYshkleBpuOpgTO/ikkQiFdg13yIv
 q69q/feicsjaveIEe7hUI9lbWcB9HKgVXW3SCLXBMjhCGCNLsWQsw26gRxDy62UXRCTCT3iR
 qHP82dxPdNwXuOFG7IzoGBMm3vZbBeKn0pYYWz2MbTeyRHn+ZubNHqM0cv5gh0FWsQxrg1ss
 pnhcd+qgoynfuWAhrPD2YtNB7s1Vyfk3OzmL7DkSDI4+SzS56cnl9Q4mmnsVh9eyae74pv5w
 kJXy3grazD1lLp+Fq60Iilc09FtWKOg/2JlGD6ZreSnECLrawMPTnHQZEIBHx/VLsoyCFMmO
 5P6gU0a9sQWG3F2MLwjnQ5yDPS4IRvLB0aCu+zRfx6mz1zYbcVToVxQqWsz2HTqlP2ZE5cdy
 BGrQZUkKkNH7oQYXAQyZh42WJo6UFesaRAPc3KCOCFAsDXz19cc9l6uvHnSo/OAazf/RKtTE
 0xGB6mQN34UAEQEAAcLA9gQYAQoAIAIbDBYhBHeyd+fQfcCoBrAfeCeIT8WGARmGBQJeORkW
 AAoJECeIT8WGARmGXtgL/jM4NXaPxaIptPG6XnVWxhAocjk4GyoUx14nhqxHmFi84DmHUpMz
 8P0AEACQ8eJb3MwfkGIiauoBLGMX2NroXcBQTi8gwT/4u4Gsmtv6P27Isn0hrY7hu7AfgvnK
 owfBV796EQo4i26ZgfSPng6w7hzCR+6V2ypdzdW8xXZlvA1D+gLHr1VGFA/ZCXvVcN1lQvIo
 S9yXo17bgy+/Xxi2YZGXf9AZ9C+g/EvPgmKrUPuKi7ATNqloBaN7S2UBJH6nhv618bsPgPqR
 SV11brVF8s5yMiG67WsogYl/gC2XCj5qDVjQhs1uGgSc9LLVdiKHaTMuft5gSR9hS5sMb/cL
 zz3lozuC5nsm1nIbY62mR25Kikx7N6uL7TAZQWazURzVRe1xq2MqcF+18JTDdjzn53PEbg7L
 VeNDGqQ5lJk+rATW2VAy8zasP2/aqCPmSjlCogC6vgCot9mj+lmMkRUxspxCHDEms13K41tH
 RzDVkdgPJkL/NFTKZHo5foFXNi89kA==
In-Reply-To: <20240725201517.3c52e4b0@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26.07.24 02:15, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> When eventfs was introduced, special care had to be done to coordinate the
> freeing of the file meta data with the files that are exposed to user
> space. The file meta data would have a ref count that is set when the file
> is created and would be decremented and freed after the last user that
> opened the file closed it. When the file meta data was to be freed, it
> would set a flag (EVENT_FILE_FL_FREED) to denote that the file is freed,
> and any new references made (like new opens or reads) would fail as it is
> marked freed. This allowed other meta data to be freed after this flag was
> set (under the event_mutex).
> 
> All the files that were dynamically created in the events directory had a
> pointer to the file meta data and would call event_release() when the last
> reference to the user space file was closed. This would be the time that it
> is safe to free the file meta data.
> 
> A short cut was made for the "format" file. It's i_private would point to
> the "call" entry directly and not point to the file's meta data. This is
> because all format files are the same for the same "call", so it was
> thought there was no reason to differentiate them.  The other files
> maintain state (like the "enable", "trigger", etc). But this meant if the
> file were to disappear, the "format" file would be unaware of it.
> 
> This fixes two bugs in the same code. One is a race that could be trigger
> via the user_events test (that would create dynamic events and free them),
> and running a loop that would read the user_events format files:
> 
> In one console run:
> 
>  # cd tools/testing/selftests/user_events
>  # while true; do ./ftrace_test; done
> 
> And in another console run:
> 
>  # cd /sys/kernel/tracing/
>  # while true; do cat events/user_events/__test_event/format; done 2>/dev/null
> 
> With KASAN memory checking, it would trigger a use-after-free bug. This was

The UAF bug is there even without KASAN. It's just that KASAN makes it
much easier to detect and catch early.

> because the format file was not checking the file's meta data flag
> "EVENT_FILE_FL_FREED", so it would access the event that the file meta data
> pointed to after it was freed.
> 
> The second bug is that the dynamic "format" file also registered a callback
> to decrement the meta data, but the "data" pointer passed to the callback
> was the event itself. Not the meta data to free. This would either cause a
> memory leak (the meta data never was freed) or a crash as it could have
> incorrectly freed the event itself.
> 
> Link: https://lore.kernel.org/all/20240719204701.1605950-1-minipli@grsecurity.net/
> 
> Cc: stable@vger.kernel.org
> Reported-by: Mathias Krause <minipli@grsecurity.net>
> Fixes: b63db58e2fa5d ("eventfs/tracing: Add callback for release of an eventfs_inode")

That fixes tag looks odd as it didn't introduce the bug. It's some late
change to v6.9 but my bisect run showed, it's triggering as early as in
v6.6 (commit 27152bceea1d ("eventfs: Move tracing/events to eventfs")).

git blame points to 5790b1fb3d67 ("eventfs: Remove eventfs_file and just
use eventfs_inode"), which is still too young, as it's v6.7.

IMHO, this needs at least the following additional fixes tags to ensure
all stable kernels get covered:

Fixes: 5790b1fb3d67 ("eventfs: Remove eventfs_file and just use
eventfs_inode")
Fixes: 27152bceea1d ("eventfs: Move tracing/events to eventfs")

Even if 27152bceea1d is not the real cause, just the commit making the
bug reachable. But from looking at the history, this was always wrong?

> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  kernel/trace/trace_events.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
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

Tested-by: Mathias Krause <minipli@grsecurity.net>

Thanks,
Mathias
