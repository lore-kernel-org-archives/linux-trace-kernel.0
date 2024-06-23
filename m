Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFBE146D57
	for <linux-trace-kernel@vger.kernel.org>; Sun, 23 Jun 2024 14:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719154501; cv=none; b=U0MLyOz8PjoS4LqwTzKMLn8lulS9OL4qDc0FjMhVYXCoqKhn6JiBSP3+3QziY+IdT9Xa0aA99D0knfS6sedEZGDcJRtAcEGJMb4ZCEynSUUxJxRklZhlDAQfXnHNNZA3G2JxRzfD3R8WC9soJ3AO6slxTIFp+7zYQRhqXHt3xSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719154501; c=relaxed/simple;
	bh=WHJyLpXJsvXpBkB3XYopVJ4ntyGCuMv9iGmRnnNXZp8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DGIHT0w6K7hwLoHpCSDIzVayUFEc1FUDa8+yBzJoFza+FQITdARfwh92VZk93usU2ZxHGT4hDJhmEIiwfqQOl7EOI5jVKuM+XF+Ir55cK8trg7LURr4vnblcRKwXLVDQGqDMGB8p0I/HLvdThWdzJ0PtZXmFS+oeNaUPStBcRdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AbSUuxGx; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AbSUuxGx"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-366e70d0330so561972f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Sun, 23 Jun 2024 07:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1719154497; x=1719759297; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qal8+/NVQ4EaUsktF5ubea5e2SmhtWYohY8n2jnwsTs=;
        b=AbSUuxGxzPQ5vBH8ZSxqd8zR7LVOh6L5KTUUIKiJo5gr9o0HPtr+p2OfhPgE/KptjM
         rYdc2IwdCxUDYKyEpQCk3qYoCGIYeurWs3iPI4j+LEyn0UsT3fl3YZREJCHKa40YUXoD
         fY+T7vXym5gj1LgXHYg+jR6A684mlJ3UiwrNHXTYvXIGeE5biilj1WdVRBpWIQggm3VD
         KTHUBIpfN9we+qxFu1MOVT6K1acsvUGXxk6WBrfENnzgaeNrTlIP61aJZychWSWdUyyO
         cEFGEcDDMlX2pIIH6CywquZvMtU2APIvwwrRr3tU7kYCfHWGQQ2jnu3JE3fULrxyyHsk
         BQzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719154497; x=1719759297;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qal8+/NVQ4EaUsktF5ubea5e2SmhtWYohY8n2jnwsTs=;
        b=ZtyzKm/W6ZRjWYu3/3w3sLrG+HKBdzuVsutFhTTsedDvJ4nDxW2LNq24KIO6JyJVre
         4wKYYG3xOH+Jtvm0zWuSDveN7DMbVGzJ14yloV5b8r9sJgzig88K4h6JAuzeOPog7nJO
         CRjIlyXT7FFWFW9dS+N+PXzdkkrvqV5n3ARJEy3odpWNOndgA0rsAhkzWdzoBB+X+KPe
         URlC8/4h9f4hvl/sMaC6cdmAX+UF8v+7Jy5O1CVg8GTU2My764REvaPDWotblGdyY0aT
         EJMrNx9spiMonewWupOTfmFlMaMKfYcRDo5IYGLzO3SE9I/vhflKJXpgFfBHLZP3SksS
         f3Ag==
X-Forwarded-Encrypted: i=1; AJvYcCWeQD9zGq9F5D6Aj8ePG7h6JsAK5U0GaofAvdVeq/kdhc6x4fIe58yCpAh57GiL4zHFRFJhDlU/UgmPBOgkc2xnb30RH0DGgpq/bqQVSBqmRhhc
X-Gm-Message-State: AOJu0Yw+2m5fcrBsUW8hUZMj2qZAOJfasMguUB5X47VJlrBjuBUayn+P
	KKUoaNpYwcH4sL3T3Qf7iSjRAIo62+yePYiJ0R9zF+YMjn/2CoDamz5DUclCeriSAaRYiQE9KLB
	u
X-Google-Smtp-Source: AGHT+IENANslWkRWKxF1ggDUKEOlpEjTlLLg7IZN3Seke0zlOE5s0EvXnCKHFi7kpDs0Y60GuNlCuw==
X-Received: by 2002:a5d:6d8c:0:b0:366:eef4:ce99 with SMTP id ffacd0b85a97d-366eef4cf70mr816268f8f.45.1719154497388;
        Sun, 23 Jun 2024 07:54:57 -0700 (PDT)
Received: from [10.100.51.161] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3663a8c8f50sm7478559f8f.109.2024.06.23.07.54.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Jun 2024 07:54:57 -0700 (PDT)
Message-ID: <a16b5720-ad2d-44af-a231-e7aa172ccf0e@suse.com>
Date: Sun, 23 Jun 2024 16:54:56 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ring-buffer: Limit time with disabled interrupts in
 rb_check_pages()
Content-Language: en-US
To: Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20240621150956.24814-1-petr.pavlu@suse.com>
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20240621150956.24814-1-petr.pavlu@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/21/24 17:09, Petr Pavlu wrote:
> Function rb_check_pages() validates the integrity of a specified per-CPU
> tracing ring buffer. It does so by walking the underlying linked
> list and checking its next and prev links.
> 
> To guarantee that the list doesn't get modified during the check,
> a caller typically needs to take cpu_buffer->reader_lock. This prevents
> the check from running concurrently with a potential reader which can
> make the list temporarily inconsistent when swapping its old reader page
> into the buffer.
> 
> A problem is that the time when interrupts are disabled is
> non-deterministic, dependent on the ring buffer size. This particularly
> affects PREEMPT_RT because the reader_lock is a raw spinlock which
> doesn't become sleepable on PREEMPT_RT kernels.
> 
> Modify the check so it still tries to walk the whole list but gives up
> the reader_lock between checking individual pages.

Sorry, I'm afraid this patch is actually buggy. It considers only the
case when rb_check_pages() is called by ring_buffer_resize() and the
ring-buffer list is potentially modified by a reader swapping its page
into the buffer from rb_get_reader_page(). However, I suspect the
opposite can happen, rb_check_pages() called by a completing reader from
ring_buffer_read_finish() and rb_remove_pages()/rb_insert_pages()
concurrently modifying the ring-buffer pages. This needs to be handled
as well.

I'm at a conference next week, I'll have a closer look afterwards.

-- 
Petr
