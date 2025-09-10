Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991EF23D7C8
	for <linux-trace-kernel@vger.kernel.org>; Wed, 10 Sep 2025 09:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757497681; cv=none; b=k6q2EHVGdn39YyWhVgZkzOD4tIoO5jGqHrQ/MbxgA18B73FQypgJNLIaRQbWe/ZWMEPEYWHO5dHMQU+4FdatUqgJaOi9HaFjvViIZXcH+p16GFc1U+qtcLFG4NuTT1X+sMeeJ0OF1Eu89bk1FfTRzrmJgRzgP95Cmsnh8pYsz2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757497681; c=relaxed/simple;
	bh=0V31LUAQineHaHR+Zk1fa1rB++gkt0nxE0bE4w2NcJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H/WEqh6r4lOMrgi36Z8/G7OpRc0G8W0LiFcFVtkTWWxeWVnwy/Jo2h3JjUPPbKvdZbAqDYtbYqu9Xs08WN72z/l4zaLLHj+wEAR+5YazYWCGGFzXoHQmJ1tJXOOFMsDVqppFr/NA/uvCY0VAZ5MqcbGfu2P24yux3jBBPH8j2o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cIM8hENk; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cIM8hENk"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45b4d89217aso43146625e9.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 10 Sep 2025 02:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757497678; x=1758102478; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uvtu3uafbueZeizVaV/6mc7Nfku5GeAYQMpYTXLT+4o=;
        b=cIM8hENksTTCHyw1JeXkRiSgdc4nODT2WcuLF3WBdoxMQUfE0T6KxW1DNWymmpwybx
         WFn9EXr+4pNb/4PBKoQwyOpCO6HDz6adWEH4v8c6lLBXSVrEw2ZmHsK5JLRM+sdULtsp
         jgogPgKa8XXcOziL6pMsbVczEyFc2shjm7bjhJq1oShzuBeb6twBUOvJGo0GeYu70XSK
         bKzg14dfbh/+P93qFNAklo3vhNoPe0WHLJlgNhplbJoyttroPV/JmXRZmeV4XvTzZTEn
         OJUDMnbl4pydzVfyBN4K4RbLAGI4m2Qe7RxWQVdjvxn8qag2hu47EUJyOc7CQAZGh1vp
         zC6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757497678; x=1758102478;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uvtu3uafbueZeizVaV/6mc7Nfku5GeAYQMpYTXLT+4o=;
        b=kWRcvfEeTYk3JxsWU6reuStFTGxzRSRZPPoAVlthFCLWcsMYaFZufOpcw1B+E0dtbl
         CfmFOVfNK8f8pseaRiZqhaC1BsjXkNNpt9Y9tTD5QpNX3dtBLqrh9YYVyz5MU21mI6US
         QVT67zg/wndK67kQJcdUAmbNgp/r/iuK+gMn6bBVT4OhV5eMy4nCAXg5e9iGOSmMzXFt
         6pWS0SW9N7fRcULx3EnqwUYfNmklCeD2TpfyWp4JUvUfMLMIU2Ka6WDsfPPCaLDwy/mJ
         NIpxJpvx5T+K+7Dr6B4pKZ+yTTlVlGb3FzUNMjfcq+05ojakAvzWKRB3YfA2Lk4xrwbs
         qfNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmWtJ6mPQgAuHIwpsexHWFu621YPmXvWyykpEfwKbOZoLlzXPefl7Tj6jG+aUZtNYag0GPZalbDwCW9jknY/Bt9zw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywuw8xOn2TJ2QOP3pbsrqGsqF6qlLjlNn+vXCWomBZXGz1To3hH
	yCkpAXigwd5dIxQYKoosZk5QmfggLUZ+eoRx4Z8o8DJ8DqvKiW7RWzcxAwXfqssCng==
X-Gm-Gg: ASbGnctxWcUP0peD8ijNfE79bKO2OwqZOIEUb9TP3HJTrvQVn8eZuOxrmVJWoTLRv1R
	dKYiN7O69JlA73UI1RTCJahQ0DSXHVioMPfTYi1VddjEkzXRyYfrIsu4F9SoMmfffo/ilK+mOwA
	Ynwp97vcdpujGU9RsbtpvEqZDX/xxz1kRJAEMZLwrPYZWxot7Jrh1EyQyuokdxRKsvqxtXV/g9r
	ksYModh5W/DfYzRa05e9cm23wqcuF0A3LJQ3uKSZR/xYZBY9uwhdeJBHHAaVZ544UxqWxzihHcq
	Fg0DaBr7yqUmyXobEikHAHygRO28rU/xHGoNvB9FLm8XGlpAVSmwvsj7rCwgS4V3RKqL9uPcImz
	k8Gpsd5MGukqXId796GZQ0xjKnK+lTOrpaAbw5JSx1MsmgCoe3E4lZgxmZbDkYnVm3iHRsXEuGU
	VwakJ+
X-Google-Smtp-Source: AGHT+IFWWYfR8ORYSi5S/6yVLRSE1Vl7ci8b3o8skMEhA51akRxc13pv3ScUUN6gVKKYUtaBgf3yww==
X-Received: by 2002:a05:600c:8b43:b0:45d:d718:3b9e with SMTP id 5b1f17b1804b1-45ddde92627mr142163035e9.10.1757497677772;
        Wed, 10 Sep 2025 02:47:57 -0700 (PDT)
Received: from google.com (211.29.195.35.bc.googleusercontent.com. [35.195.29.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e752238832sm6017788f8f.31.2025.09.10.02.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 02:47:57 -0700 (PDT)
Date: Wed, 10 Sep 2025 10:47:54 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
	linux-trace-kernel@vger.kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, jstultz@google.com,
	qperret@google.com, will@kernel.org, aneesh.kumar@kernel.org,
	kernel-team@android.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 10/24] tracing: Introduce simple_ring_buffer
Message-ID: <aMFJSlbHRsvzYKaF@google.com>
References: <20250821081412.1008261-1-vdonnefort@google.com>
 <20250821081412.1008261-11-vdonnefort@google.com>
 <20250909182644.092b3e85@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909182644.092b3e85@gandalf.local.home>

[...]

> > +static struct ring_buffer_event *
> > +simple_rb_reserve_next(struct simple_rb_per_cpu *cpu_buffer, unsigned long length, u64 timestamp)
> > +{
> > +	unsigned long ts_ext_size = 0, event_size = rb_event_size(length);
> > +	struct simple_buffer_page *tail = cpu_buffer->tail_page;
> > +	struct ring_buffer_event *event;
> > +	u32 write, prev_write;
> > +	u64 time_delta;
> > +
> > +	time_delta = timestamp - cpu_buffer->write_stamp;
> 
> The remote buffers never get preempted do they?
> 
> That is, it doesn't need to handle different contexts like the normal
> kernel does? (normal, softirq, irq, NMI, etc).

No, luckily, we don't need to support any of that.

> 
> -- Steve
> 
> > +
> > +	if (test_time_stamp(time_delta))
> > +		ts_ext_size = 8;
> > +
> > +	prev_write = tail->write;
> > +	write = prev_write + event_size + ts_ext_size;
> > +
> > +	if (unlikely(write > (PAGE_SIZE - BUF_PAGE_HDR_SIZE)))
> > +		tail = simple_rb_move_tail(cpu_buffer);
> > +
> > +	if (!tail->entries) {
> > +		tail->page->time_stamp = timestamp;
> > +		time_delta = 0;
> > +		ts_ext_size = 0;
> > +		write = event_size;
> > +		prev_write = 0;
> > +	}
> > +
> > +	tail->write = write;
> > +	tail->entries++;
> > +
> > +	cpu_buffer->write_stamp = timestamp;
> > +
> > +	event = (struct ring_buffer_event *)(tail->page->data + prev_write);
> > +	if (ts_ext_size) {
> > +		event = rb_event_add_ts_extend(event, time_delta);
> > +		time_delta = 0;
> > +	}
> > +
> > +	event->type_len = 0;
> > +	event->time_delta = time_delta;
> > +	event->array[0] = event_size - RB_EVNT_HDR_SIZE;
> > +
> > +	return event;
> > +}
> > +
