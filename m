Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D36B46D09E
	for <linux-trace-kernel@vger.kernel.org>; Sat, 17 Oct 2026 11:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792235008; cv=none; b=glcSgE8jsWla4Es0eckzEsaKREVW73G9FYQaBZOyvSDDurRYU6XpHOU6DgEJep7SJFF9P91NuQYrBVO/cYMmHlU2kViboMR4aQUCfdVXelFppwmJmQfNAcCW5H6sw1DOwQVQ+fOycvercnhuOyA3Ezq0IF/EweyOJXj7wAp7thA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792235008; c=relaxed/simple;
	bh=dusSUzGVBQ4wTbcMAoraGCwZK/QKzi0RZ+ls1R2bvuc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=ihjX72NbwxjeuuAYtzLU6F1SCWtZG7o+WQcRWxLZR6+XRRtaF9iV5rSnmsgLFVY7ab+y8MkAYc+OegO6J7RE/ZexE5kCTLvO+eZ5O894iWoubw65x+z0xcX6UFjBd5MB8AlKsLEYX+IPnFQDj8aF9HMHcKkCZRtWncz1KJUzMCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I3C7BlU2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I3C7BlU2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792235005;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dusSUzGVBQ4wTbcMAoraGCwZK/QKzi0RZ+ls1R2bvuc=;
	b=I3C7BlU2ro7r2AOoNcGwUtiUvYG0bPZY1z6aJPOG1wpW3N4cQ2b1E6/FVXSnK1tPgr1OMj
	Pl9PZtHs2cH/Occrnxi+RKFNFXiy2csRwEeJCL9k0Kj2YwQSkzFSFWXZB4IhvcHWJpt/3J
	/sV3BzWcnCRurxiNZnALetvt4skc9as=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-TFKiiznhOB2u7abNl1K5xQ-1; Sat, 17 Oct 2026 11:03:23 +0000
X-MC-Unique: TFKiiznhOB2u7abNl1K5xQ-1
X-Mimecast-MFC-AGG-ID: TFKiiznhOB2u7abNl1K5xQ_1792235002
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48e011829easo383875f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Sat, 17 Oct 2026 04:03:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792235002; x=1792839802;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZfdFL+mOgr8C5/Q5zBQQ/lVzqfgyNXnS/9dewaQPMiQ=;
        b=kOkBOK+xrttdqpnV4tAgXs1QCRd6YsZYpGTZPhOx00XgSs5RReR0mrZ6NVf/+rSmjZ
         KKQfpVafl9IeUF0CQXo6WCOsIEWsxcSmOTbqAXGI/CvH3jTEIsq0IElj3aB8SrBzTaIB
         5k/XVyR5toyPpgOgW3m7sRs7aezKPYAl+NH2/A8B7H/0ecEl1PsdEtX7Z2sgnZ66T4pY
         N92+eNJNyiboZtgjpiP4Rp0iSsHf+c3TPrZKVCIn6DTRm5IvlQ726rwRzbE+MTQ2fEOG
         j8aKbUT+dHi+joqCgSqx48J57Hjz9ieV8SlCdwuC+5t5Wz/cr8LFPd9Ek93I9A6AD1SA
         V7Fg==
X-Forwarded-Encrypted: i=1; AKwUvBzFiSsAN9Erb0ZSjB52VBn6Mk9vLJ/dOt6hopDXhsSVQ1kyCDlPSniM8UOQ0xDDLV5eG3eRWiU6KsfnTrK5U5yJ28Y=@vger.kernel.org
X-Gm-Message-State: AFq9FYLmZ2KFeXooh9MXb5waeLJE7wk9xYZ8d2uropPLeYOZF+bhE8rb
	/kMs7wbECkmUa4xBmSxmmFr+Kh2d2b6K4QY16bPikTxxVb/naFFcxVXR7g1UoZ9RUXo4EJyWkRT
	dkqFKpL5Ckha9T4Xgehg4fMcY8jL10rrEJ0oVzGmZDn2/OhHZqYJ9PqhN/26D2IdH/4EhqClzFA
	==
X-Gm-Gg: AYBFou3v5ICaeI2hd86+c2261PcGv7Uor/QrRNAMuvudGVfK8EhEa3J/u6n0q+ed/KC
	PGzsPsMi+5vUAYOwJnPAEqTrrtWe1NTXs3wGIWOp3g46irTUtBc4al4TDUw6Di2NTf1zk/0UFSg
	whOwUp9gdBLii57AJiuqa82pGzcMCNFkfCjG9DtP3H3RgO8NP1lpYRb157uV2sNXcjGU2TqR5W/
	DwpuOst+s48Gc1SGr/55q71+NQqYJ8sQybWrSYElXaHsadzO8ZJV7kmm85Qi1E4nqT4b4HjQte2
	18ovKb5oOIYD0bmK0Ej8VY6pMKP1xoJ2ycF62W2u188cKRrK/Sj5sqMkY2bPEDUTkn0PT+rqw3A
	P43gpV29W
X-Received: by 2002:a05:600c:a4b:b0:4a0:eae0:b30e with SMTP id 5b1f17b1804b1-4a1d7604051mr52205125e9.22.1792235002018;
        Sat, 17 Oct 2026 04:03:22 -0700 (PDT)
X-Received: by 2002:a05:600c:a4b:b0:4a0:eae0:b30e with SMTP id 5b1f17b1804b1-4a1d7604051mr52204745e9.22.1792235001686;
        Sat, 17 Oct 2026 04:03:21 -0700 (PDT)
Received: from ehlo.thunderbird.net ([195.174.135.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd4feb6bsm11345521f8f.41.2026.10.17.04.03.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Oct 2026 04:03:21 -0700 (PDT)
Date: Sat, 17 Oct 2026 10:48:30 +0000
From: Gabriele Monaco <gmonaco@redhat.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
CC: Nam Cao <namcao@linutronix.de>, Wen Yang <wen.yang@linux.dev>,
 Tobias Schaffner <tobias.schaffner@siemens.com>,
 Viktor Malik <vmalik@redhat.com>, John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH v2 10/15] tools/rv: Add BPF monitors
In-Reply-To: <DM6H7SK4YZ7A.F0MM6C0I77OR@gmail.com>
References: <20261001152042.124445-1-gmonaco@redhat.com> <20261001152042.124445-11-gmonaco@redhat.com> <DLXSI4BSRE5F.1TLKCBUAGNDFQ@gmail.com> <b1fb01e1c58893795dd4be346f233d39fe653aaa.camel@redhat.com> <DM6H7SK4YZ7A.F0MM6C0I77OR@gmail.com>
Message-ID: <5A1AB76E-E338-4B88-8FDD-947BA0C5A294@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3Psr80Lwv6HmaCQiDAd5eWXeHQa1e-YE8-DRInFfbVI_1792235002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



Il 16 ottobre 2026 18:32:44 UTC, Alexei Starovoitov <alexei.starovoitov@gma=
il.com> ha scritto:
>On Thu, Oct 08, 2026 at 11:54 AM Gabriele Monaco <gmonaco@redhat.com> wrot=
e:
>> Reactors in this patch use bpf_printk(), which is in fact a trace_printk=
()
>> instead of a real printk, is there a technical limitation forbidding us =
to
>> create a kfunc using some flavour of printk_deferred()? Or am I missing =
an
>> existing one? (this need was brought up by John, Cc'd here)
>
>No technical limitation, and there is no such kfunc today.
>printk_deferred() is a lockless store into the ring buffer plus irq_work.
>It's ok in any context where tracing progs run.
>The closest we have is bpf_stream_vprintk(). That's stdout/stderr of
>the prog. User space has to read it.
>rv tool is around for as long as the monitor is loaded, so it can read
>the stream and log it anywhere like /dev/kmsg.
>If the message has to reach the console when user space cannot run
>then the kfunc makes sense, but using bpf_stream is imo much cleaner.
>

Thanks for the answer, I'd expect a mildly higher overhead in doing that, b=
ut since it's only on violations we can probably accept it.

I'm going to have a look at that. User space should be able to run for at l=
east most models, I'd say, but I'm not sure how fast it can pick up.

>> Not needed in this patch but potentially required for more complex monit=
ors. In
>> kernel, when timers are required, we allow monitors to use hrtimers (pre=
cise but
>> heavy), or the timer_wheel (lightweight but less precise).
>> I'm not aware of any wrapper of the wheel in BPF, but I think a few kfun=
cs for
>> these could be useful, in general, also for other programs needing a lot=
 of
>> timer instances or simply light timeouts.
>> What do you think?
>
>I don't think it's needed.
>bpf_timer is hrtimer only, but hrtimer vs wheel is not where the cost is.
>bpf_timer_start() cannot call hrtimer_start() directly.
>bpf_async_schedule_op() does kmalloc_nolock()
>and irq_work_queue() instead.
>I don't think timer wheel will help.
>

Alright, I'm going to keep that in mind once I get to work with timed autom=
ata.

Thanks,
Gabriele

