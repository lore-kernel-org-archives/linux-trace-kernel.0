Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435E718EAB;
	Tue, 11 Jun 2024 22:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718145844; cv=none; b=AXjyWRhMLW/Vp3nd/XVC839r4jBi7lFNJwM0n2pQwKYUigqsdQKUdvkR5bnbmNRDkRY8pmJfy9+R7RZwzHWUA6NTjYkmz3y9LAEKDJ0ysiNnDHupbY++05dgqLEI4tDEWRknLp5Ndu/TS3TPAvECRDEoxhgtsEtd/TD+QnfvoUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718145844; c=relaxed/simple;
	bh=jkgGX6JhTSKc2JQ9lobIrsZ6+J2wG4/W1YxnzTSYc0M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jB4CqV1Q/n+3sJCiquo+60JZlRsTVugO+LJp95cNZsiPbL+Yze+Wd3Pss1eQXPBlzFEZpPDIp+qDxgUSBDpikbsXc98rQpPxDxjGVsLYIoDGCngtcg3T85C/z1QwI2ShZk5aBl8WJwSdL4whfvjEsUG+wjhRnmQv8c78qn0um20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c/WPQiCj; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c/WPQiCj"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7046211e455so2189226b3a.3;
        Tue, 11 Jun 2024 15:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718145842; x=1718750642; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=JjJgoNErYdG8LWeuzJrz+S/8auNsee/95pEsFxHhxCY=;
        b=c/WPQiCjsaq+IstRIAk0LJcO6vQi1XDo/zCq+TxVNdwRS++x9Fk2B3TDmjz6W9BxY1
         ADZhT48qQ1GjO/Le/0xWgO2YSLsRP2HrfDcnuNRlBB4goi1PlWT3KztOj+4fWs6jb42k
         S513tOdilHNojRIk7+LW1B1/Kk2fpuusDDuhtfcaHhmGk5JOoHwtCqSufd2OjjEqeD+H
         4m9h1/uj/G64i3gviDoV3OK+mgdktke55GWsLe3pInKKYIrMQQdP2L6HyQeyfs0/ZC82
         df5XUX7DmPnfOgme70YRGo2OQdaBTnOgvbd4RDJ+TkZz9tfzzdYNp673jKYQMqOgailw
         SWZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718145842; x=1718750642;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JjJgoNErYdG8LWeuzJrz+S/8auNsee/95pEsFxHhxCY=;
        b=Yu0dULZzb5vTXERNhiccFgJsRoDQ661yTSbkuIkzArySRE8z2jLfAD+NyAqHY1yN9a
         31qbNakEZWjPBiGk7p0lPNGIPqzH9elkMqD8p+VYSgQYP87nO/51tMi5M8CUJkf7YDah
         6PsjnIK/UeJaUfmG01xg4VPNWG47m9xKv/9RG/nfvjyMilC8/sVQzrSS/nMal2ajTFp7
         flmi+jvcG1w6MiruvxnB/YxQdhynxSqqp5OEEM2Cyo7QairXcNxRVBUROl/uDzwUzeDs
         PBNxSD6k8xd7QUzbjx6gRaI2Vy6EU6rSlk9c5Qg6LqN2otE+AkdO01JldHqMuBdJ33+C
         rUWg==
X-Forwarded-Encrypted: i=1; AJvYcCXZVTlLi943Jvw9uveKhI4zLuiUPCCuMryroofOxjxAruLyo3m3lYsJifHaQiJFnlHHuhpDEAjHfeNFMSiNuxGG30kTrpk6dOGZchYABkM/SAWsGRSQaY2q18QzB4ML5thtW2Q8Y5eVArHqS8QUPQ3+
X-Gm-Message-State: AOJu0YxCCytsTvJ7W6ID/f+2AMTMQ/RCvo6iq6/fiJX2XJ/23NVu8A7T
	hAWHhjRkGHoMA35iZKvUUNovGVwBgGyqu8jSl6IPG2gTRIybVbnW
X-Google-Smtp-Source: AGHT+IGnLqi75Z/wHEDBUWw1sXcMM5rmPSC0suOzMOmoeKFxDMDTOT3vEN7ZBINJJvpS3DV/wu0faQ==
X-Received: by 2002:a05:6a00:22cd:b0:704:1932:5604 with SMTP id d2e1a72fcca58-705bce75f56mr236329b3a.15.1718145842384;
        Tue, 11 Jun 2024 15:44:02 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70432977fe4sm5185237b3a.59.2024.06.11.15.44.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jun 2024 15:44:01 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <5178e22b-0c00-48d2-8a6e-85510706f145@roeck-us.net>
Date: Tue, 11 Jun 2024 15:43:59 -0700
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/13] ring-buffer: Allow mapped field to be set
 without mapping
To: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
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
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240611192907.402447387@goodmis.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/11/24 12:28, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> In preparation for having the ring buffer mapped to a dedicated location,
> which will have the same restrictions as user space memory mapped buffers,
> allow it to use the "mapped" field of the ring_buffer_per_cpu structure
> without having the user space meta page mapping.
> 
> When this starts using the mapped field, it will need to handle adding a
> user space mapping (and removing it) from a ring buffer that is using a
> dedicated memory range.
> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>   kernel/trace/ring_buffer.c | 11 ++++++++---
>   1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 28853966aa9a..78beaccf9c8c 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -5224,6 +5224,9 @@ static void rb_update_meta_page(struct ring_buffer_per_cpu *cpu_buffer)
>   {
>   	struct trace_buffer_meta *meta = cpu_buffer->meta_page;
>   
> +	if (!meta)
> +		return;
> +
>   	meta->reader.read = cpu_buffer->reader_page->read;
>   	meta->reader.id = cpu_buffer->reader_page->id;
>   	meta->reader.lost_events = cpu_buffer->lost_events;
> @@ -6167,7 +6170,7 @@ rb_get_mapped_buffer(struct trace_buffer *buffer, int cpu)
>   
>   	mutex_lock(&cpu_buffer->mapping_lock);
>   
> -	if (!cpu_buffer->mapped) {
> +	if (!cpu_buffer->mapped || !cpu_buffer->meta_page) {
>   		mutex_unlock(&cpu_buffer->mapping_lock);
>   		return ERR_PTR(-ENODEV);
>   	}
> @@ -6359,12 +6362,13 @@ int ring_buffer_map(struct trace_buffer *buffer, int cpu,
>   	 */
>   	raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
>   	rb_setup_ids_meta_page(cpu_buffer, subbuf_ids);
> +

Picky again. Is that a leftover from something ? I don't see an immediate reason
for the added newline.

>   	raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
>   
>   	err = __rb_map_vma(cpu_buffer, vma);
>   	if (!err) {
>   		raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
> -		cpu_buffer->mapped = 1;
> +		cpu_buffer->mapped++;
>   		raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
>   	} else {
>   		kfree(cpu_buffer->subbuf_ids);
> @@ -6403,7 +6407,8 @@ int ring_buffer_unmap(struct trace_buffer *buffer, int cpu)
>   	mutex_lock(&buffer->mutex);
>   	raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
>   
> -	cpu_buffer->mapped = 0;
> +	WARN_ON_ONCE(!cpu_buffer->mapped);
> +	cpu_buffer->mapped--;

This will wrap to UINT_MAX if it was 0. Is that intentional ?

>   
>   	raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
>   

