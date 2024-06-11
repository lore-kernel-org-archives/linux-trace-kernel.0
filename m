Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51776155A5C;
	Tue, 11 Jun 2024 23:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718150030; cv=none; b=klpQrQ6E8yUDVFrcEWNFsaChKeNEuNr7iqL5q2DJc50jmIQpL9LMWOfUY0EhczIgSJFNKOR2isV5pCvr4rHSkYuI86zMX3VQJ/sPjViAwaAgqiiHBvS885v16S3hwc5kKSiwqfd3cst36fIkesXTMn6cmj4zGaD7cCM1K66uNY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718150030; c=relaxed/simple;
	bh=ixEi2EihRIVM1JgjBQh9oI5ZNtR8RSnwPtqwjLbu2Ms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bwXnP3AIN/p1P14ytwUyGgoMT5uOohBeuDWV6svZUTEpDp4qnKzX9IqA6UXso8YvR9+pP8585QeK+/d48ZuPNFTnpakwP0HXXMYXFrZwnA6t0ZoV75D9lmZYueV8xoKhcmIDjRYJuHecIune1KovD7+Dn+aG71LLE+aLc8HbE/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z+0RPiBw; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z+0RPiBw"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-70423e8e6c9so3218057b3a.0;
        Tue, 11 Jun 2024 16:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718150027; x=1718754827; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=B2nCf1ZS5hyGT3Pv3PgsvdwOjQ/1NGLvLUu1cRiT+Bc=;
        b=Z+0RPiBwgOtrZvSjOwHEKT3VkT9FbHv17W3ncZr5aRuBDXgnn6LV7jsUl9sAliCUit
         NY5bWC+JEzb0Dyb4GUZ9OuP1Eo8Jr77J0hug3ai5AHYoJOmEPv7Y93mWdeuGdTXBF6gT
         TPqZ8fhm38STHad0tXD/Z4BV8Ub0h5s5sAJ9h8zraNExFixAicX8q/SmF+NzRH5fEWJ9
         HsNatBAvMi8fXlp+lAEn1as6h6zIm1uhYTQQ6/fN6ly1yT+dbqcHYAjpf0IcbhNy/0MZ
         a2OCwO5GkfdCAUs5m3FBpso2SUcM6KWdpmUPGY+fdsgOPK4B6qNvZPaVJnnuYb6D5mLO
         166Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718150027; x=1718754827;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B2nCf1ZS5hyGT3Pv3PgsvdwOjQ/1NGLvLUu1cRiT+Bc=;
        b=drCKYA2wp/PGKDscG5v0zqxfMs6JTfqgAtQ7UG+/XAvrkGLm0yPaHjzdvsbJpQe1hq
         MgsujyFdzydunwi4zE036PneahXf/7v0ydnIXAOJj0kMvMEWVGhai9B3Z2oo/7TyMvn/
         XuGYxbDnMttPzPzSPtCvL0ksWDoykBL91uMrEDIBfalj1n9HWVhNPDxi9fptwjvpAAM6
         mOShkxTx+eWTJfvatYOzhYi7xCvArqFtwCjuvjJ2j2JELO7Cr/zQl13fHE/wCaC9+Ha/
         JOaj/bsVtuSYAl9GXyWc3MRcZ2HQIGm8bf+3EHvZ/vpmWA4elqWWiwB6MikVguO8XOMa
         td3Q==
X-Forwarded-Encrypted: i=1; AJvYcCV6g91eRrMI2GQDzq+7fdYweSXW/+A/QJtnvXTJKL5qHywGG8w+DE66LEyCJMdh92GbiZLJPO8QdHOLTYBk5yNssmTwUVA7Q2Kj01SEEXRDKnRF
X-Gm-Message-State: AOJu0YxXfPI6IkJZ2n9VlQ3hBaMTAHvhnWg6cD/umgXQvsCOb5CqUyAq
	cSVt2o4ozFd/GHywy4H/y3h7p89knG9uroNKaUaGSHeMCXAlW+0x
X-Google-Smtp-Source: AGHT+IGSMCuqiO81ChcNbDVYg/vg9Dw3kxYo4vMX2AsCnDys7F096ZRFjepUv7b2pi5ArNYuy+jRPw==
X-Received: by 2002:a05:6a21:2d8b:b0:1b1:fede:59cb with SMTP id adf61e73a8af0-1b8a99d637amr484362637.0.1718150027331;
        Tue, 11 Jun 2024 16:53:47 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-704333cbd2asm5327628b3a.172.2024.06.11.16.53.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jun 2024 16:53:46 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <1e74c6d8-ae74-49c2-bdc4-d9880110ab57@roeck-us.net>
Date: Tue, 11 Jun 2024 16:53:43 -0700
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/13] ring-buffer: Allow mapped field to be set
 without mapping
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Vincent Donnefort <vdonnefort@google.com>,
 Joel Fernandes <joel@joelfernandes.org>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 suleiman@google.com, Thomas Gleixner <tglx@linutronix.de>,
 Vineeth Pillai <vineeth@bitbyteword.org>,
 Youssef Esmat <youssefesmat@google.com>,
 Beau Belgrave <beaub@linux.microsoft.com>, Alexander Graf <graf@amazon.com>,
 Baoquan He <bhe@redhat.com>, Borislav Petkov <bp@alien8.de>,
 "Paul E. McKenney" <paulmck@kernel.org>, David Howells
 <dhowells@redhat.com>, Mike Rapoport <rppt@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, Tony Luck <tony.luck@intel.com>,
 Ross Zwisler <zwisler@google.com>, Kees Cook <keescook@chromium.org>
References: <20240611192828.691638177@goodmis.org>
 <20240611192907.402447387@goodmis.org>
 <5178e22b-0c00-48d2-8a6e-85510706f145@roeck-us.net>
 <20240611185319.58a52a1b@gandalf.local.home>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240611185319.58a52a1b@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/11/24 15:53, Steven Rostedt wrote:
> On Tue, 11 Jun 2024 15:43:59 -0700
> Guenter Roeck <linux@roeck-us.net> wrote:
> 
>> On 6/11/24 12:28, Steven Rostedt wrote:
>>> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
>>>
>>> In preparation for having the ring buffer mapped to a dedicated location,
>>> which will have the same restrictions as user space memory mapped buffers,
>>> allow it to use the "mapped" field of the ring_buffer_per_cpu structure
>>> without having the user space meta page mapping.
>>>
>>> When this starts using the mapped field, it will need to handle adding a
>>> user space mapping (and removing it) from a ring buffer that is using a
>>> dedicated memory range.
>>>
>>> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
>>> ---
>>>    kernel/trace/ring_buffer.c | 11 ++++++++---
>>>    1 file changed, 8 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
>>> index 28853966aa9a..78beaccf9c8c 100644
>>> --- a/kernel/trace/ring_buffer.c
>>> +++ b/kernel/trace/ring_buffer.c
>>> @@ -5224,6 +5224,9 @@ static void rb_update_meta_page(struct ring_buffer_per_cpu *cpu_buffer)
>>>    {
>>>    	struct trace_buffer_meta *meta = cpu_buffer->meta_page;
>>>    
>>> +	if (!meta)
>>> +		return;
>>> +
>>>    	meta->reader.read = cpu_buffer->reader_page->read;
>>>    	meta->reader.id = cpu_buffer->reader_page->id;
>>>    	meta->reader.lost_events = cpu_buffer->lost_events;
>>> @@ -6167,7 +6170,7 @@ rb_get_mapped_buffer(struct trace_buffer *buffer, int cpu)
>>>    
>>>    	mutex_lock(&cpu_buffer->mapping_lock);
>>>    
>>> -	if (!cpu_buffer->mapped) {
>>> +	if (!cpu_buffer->mapped || !cpu_buffer->meta_page) {
>>>    		mutex_unlock(&cpu_buffer->mapping_lock);
>>>    		return ERR_PTR(-ENODEV);
>>>    	}
>>> @@ -6359,12 +6362,13 @@ int ring_buffer_map(struct trace_buffer *buffer, int cpu,
>>>    	 */
>>>    	raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
>>>    	rb_setup_ids_meta_page(cpu_buffer, subbuf_ids);
>>> +
>>
>> Picky again. Is that a leftover from something ? I don't see an immediate reason
>> for the added newline.
> 
> Hmm, I could remove it.
> 
>>
>>>    	raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
>>>    
>>>    	err = __rb_map_vma(cpu_buffer, vma);
>>>    	if (!err) {
>>>    		raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
>>> -		cpu_buffer->mapped = 1;
>>> +		cpu_buffer->mapped++;
>>>    		raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
>>>    	} else {
>>>    		kfree(cpu_buffer->subbuf_ids);
>>> @@ -6403,7 +6407,8 @@ int ring_buffer_unmap(struct trace_buffer *buffer, int cpu)
>>>    	mutex_lock(&buffer->mutex);
>>>    	raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
>>>    
>>> -	cpu_buffer->mapped = 0;
>>> +	WARN_ON_ONCE(!cpu_buffer->mapped);
>>> +	cpu_buffer->mapped--;
>>
>> This will wrap to UINT_MAX if it was 0. Is that intentional ?
> 
> If mapped is non zero, it limits what it can do. If it enters here as zero,
> we are really in a unknown state, so yeah, wrapping will just keep it
> limited. Which is a good thing.
> 
> Do you want me to add a comment there?
> 

Maybe. I just wondered if something like
	if (!WARN_ON_ONCE(!cpu_buffer->mapped))
		cpu_buffer->mapped--;

would be better than wrapping because 'mapped' is used as flag elsewhere,
but then I can see that it is also manipulated in __rb_inc_dec_mapped(),
and that it is checked against UINT_MAX there (and not decremented if it is 0).

Maybe explain why sometimes __rb_inc_dec_mapped() is called to increment
or decrement ->mapped, and sometimes it id done directly ? I can see that
the function also acquires the buffer mutex, which isn't needed at the places
where mapped is incremented/decremented directly, but common code would
still be nice, and it is odd to see over/underflows handled sometimes but
not always.

Thanks,
Guenter

