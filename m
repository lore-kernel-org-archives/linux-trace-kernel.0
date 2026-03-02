Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43603CC9EC
	for <linux-trace-kernel@vger.kernel.org>; Mon,  2 Mar 2026 13:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772459936; cv=none; b=EKFkkEMWY/NrcWCL1NyEOIqTWZFOcO7EjDCqFulNDeWSLqS1NyRaB/SyRnSZDrGGlpOBKkzOV5C8jJTlaTfyVhRWg8MLXmmHdyfSZZFmhLJ9lMtPyGVQB77pBphXQf4hNKl+UlAXSz98h15qcJuVnFu895W7DrUXrIo8YcEyjlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772459936; c=relaxed/simple;
	bh=Vup7WS03UeljBKAxRmSAsILBwKizCecVYLzL7awCpkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=GQpHgl90SQvTo3raXEE1DV7fap/CmVAmhc7lxyGqnWGsTN5RxbSUO0YdnQs1MDmdyVO1gBqn0OcrHKWUB4nzSlE1kGzH7EraAg5wxtbYxpPKu4QLFQuFtm+FGLezlPCQpx3rfVIZm2wfCUYij2J7ES2WdOj0AO1crjdQK2m+bjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bk7vU4uG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bk7vU4uG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772459933;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CeiEMsIq1M19XQRSyjWmM83RqV4mUxb0zPC+IH30st0=;
	b=Bk7vU4uG9RVlh1iV/9kJ9jVsv0KqeAswW+c7lIoJQIaW5nXnksm4fW/lyF7VmEsQSnUeZg
	c2l6FuQMo6WFC+//K1U62rhiCj+mIpcy8Hki2p6lX1yLYZpi2ACTyQ+Hcxtb/o5Ej5ltiN
	1cGoAEmZ/YDLMcSzZfI1EGWqaCbkM4s=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-fRGEMRwmOQ-hyv5ZuigqxA-1; Mon, 02 Mar 2026 08:58:52 -0500
X-MC-Unique: fRGEMRwmOQ-hyv5ZuigqxA-1
X-Mimecast-MFC-AGG-ID: fRGEMRwmOQ-hyv5ZuigqxA_1772459931
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4837c597cd5so26923665e9.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 02 Mar 2026 05:58:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772459931; x=1773064731;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CeiEMsIq1M19XQRSyjWmM83RqV4mUxb0zPC+IH30st0=;
        b=UlVxH1ZpG4nXgrfsXgJfT+o9nQ/riZK1X3wG5ODEA8gGnEi9SDkN/h3TC2jgitHS/T
         cZ+eAe0uIXly9edTjMYwjVzIhChCM/UvtU77fHzKrKKK2bIpDtqAety6362M+YuiscU8
         PcREPmC0huQSkAmjPQ3iyjTMaUWS3GJc1bnBTqMuDF8T73m4FGoEun7QjWFXIzCyJuuF
         hMSFxTOqcYojjFJtwOHnJ31570kes6w311J8fjtTKFgU/EfFZEaqAbedY2COoIM13FH7
         N8i3aFzT+ONHso7J+2enxA76vjQzmvRrIxTGA4vLEC2cCnvJTxaBRHx5TlJ5TV79wesQ
         ha5g==
X-Forwarded-Encrypted: i=1; AJvYcCUxv9ssP9sftEMdg1h0btf5Bg2SuwuGCjc8Mzfdewsdju+m+Gs0u/LMpwGK2bjcPRIuSfiyirSGkrmKGJP8sJJPoJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzO2sU+3exOXKNXoyLrTJXY357Pjb4qr7wrY7kuaiuL65/h4mCz
	ZxWCbGVwY/NtcN1nurj8OTGRxZnkfvkgkDVxsGvHTJdOV8qDIYJYDYLIk4xbxS6w/XraVhKhuam
	ozWhFcYDiKOk7rkR3gYXSmds82zxLcr00CizB2Ef6RL0vJbUe7OSauJVxmyXcKfdop4TlnCbscA
	==
X-Gm-Gg: ATEYQzwnjxVnZyhQdmMJYvrYFFqtsM0jgY2FyZzgofNxxAC2vjprxLRGXz9cuP/QPSP
	TvYzLmtM5CbYsWVf1+b0bDrIemt0YgO1szxQw0zliVIlbkXMQuCpr4RQLot57saKeAjuHPCLPUp
	haWI0B++qhnLIlni+5gdqNNYtUmA52NXNQCS6WVifWJPDlqOKr4eu888BMS8YHvaVMfNDidHH6g
	377Xo+Pm8Rz2rdBFHTO0a/Cp6MwO1CBrPtzAAGdtciXvH8Ef1zjunpb3Pc/jSROcy+EBLwKZ5Bg
	CJrxb9MTNi9RTOGABYz4nhOwUt8QLqZYm+QJKowfaSS6SB6xKe6WRtEcEkFsa3G04lKkFDmofBS
	xlLJOUNuzgxWT5fZMtmWXRse4utLgTBYiBDXwllpkJKoR0oTUAv4=
X-Received: by 2002:a05:600c:4f11:b0:477:7925:f7fb with SMTP id 5b1f17b1804b1-483c9babeaamr234251735e9.10.1772459931334;
        Mon, 02 Mar 2026 05:58:51 -0800 (PST)
X-Received: by 2002:a05:600c:4f11:b0:477:7925:f7fb with SMTP id 5b1f17b1804b1-483c9babeaamr234251295e9.10.1772459930831;
        Mon, 02 Mar 2026 05:58:50 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.73.19])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439b41831easm10784198f8f.12.2026.03.02.05.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 05:58:50 -0800 (PST)
Date: Mon, 2 Mar 2026 14:58:48 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	Nam Cao <namcao@linutronix.de>, Juri Lelli <jlelli@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	Tomas Glozar <tglozar@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH v6 05/16] Documentation/rv: Add documentation about
 hybrid automata
Message-ID: <aaWXmBVIvTlVtiRp@jlelli-thinkpadt14gen4.remote.csb>
References: <20260225095122.80683-1-gmonaco@redhat.com>
 <20260225095122.80683-6-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260225095122.80683-6-gmonaco@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: w1oGNhe_XhEMOd-bNOxMejlqaNyZsGkwRj5gs_E14zM_1772459931
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

On 25/02/26 10:51, Gabriele Monaco wrote:
> Describe theory and implementation of hybrid automata in the dedicated
> page hybrid_automata.rst
> Include a section on how to integrate a hybrid automaton in
> monitor_synthesis.rst
> Also remove a hanging $ in deterministic_automata.rst
> 
> Reviewed-by: Nam Cao <namcao@linutronix.de>
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> ---

...

> diff --git a/Documentation/trace/rv/hybrid_automata.rst b/Documentation/trace/rv/hybrid_automata.rst
> new file mode 100644
> index 000000000000..39c037a71b89
> --- /dev/null
> +++ b/Documentation/trace/rv/hybrid_automata.rst
> @@ -0,0 +1,341 @@
> +Hybrid Automata
> +===============

...

> +Stall model with invariants (iteration 2)
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +The first iteration isn't exactly what was intended, we can change the model as:
> +
> +- *X* = { ``dequeued``, ``enqueued``, ``running``}
> +- *E* = { ``enqueue``, ``dequeue``, ``switch_in``}
> +- *V* = { ``clk`` }
> +- x\ :subscript:`0` = ``dequeue``
> +- X\ :subscript:`m` = {``dequeue``}
> +- *f* =
> +   - *f*\ (``enqueued``, ``switch_in``) = ``running``
> +   - *f*\ (``running``, ``dequeue``) = ``dequeued``
> +   - *f*\ (``dequeued``, ``enqueue``, ``reset(clk)``) = ``enqueued``
                              ^^^

> +- *i* =
> +   - *i*\ (``enqueued``) = ``clk < threshold``
> +
> +Graphically::
> +
> +    |
> +    |
> +    v
> +  #=========================#
> +  H        dequeued         H <+
> +  #=========================#  |
> +    |                          |
> +    | enqueue; reset(clk)      |
> +    v                          |
> +  +-------------------------+  |
> +  |        enqueued         |  |
> +  |    clk < threshold      |  | dequeue
> +  +-------------------------+  |
> +    |                          |
> +    | switch_in                |
> +    v                          |
> +  +-------------------------+  |
> +  |         running         | -+
> +  +-------------------------+

...

> +  static bool verify_constraint(enum states curr_state, enum events event,
> +                                enum states next_state)
> +  {
> +	bool res = true;
> +
> +	/* Validate guards as part of f */
> +	if (curr_state == enqueued && event == sched_switch_in)
> +		res = get_env(clk) < threshold;
> +	else if (curr_state == dequeued && event == sched_wakeup)
> +		reset_env(clk);

Considering the spec above, does the 'event' need to be 'enqueue'
instead of 'sched_wakeup' (or the other way around)? Or maybe it's
equivalent?

Thanks,
Juri

