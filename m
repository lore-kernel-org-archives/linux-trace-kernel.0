Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750134B26F6
	for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Oct 2026 09:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792403188; cv=none; b=b/CcYgvair9jXvTtjUYUeYH3Uz0dY8Jf+j1mdnR6pkrWsQpJqlwPMnIRPBDOjDfmWD3FHe/T5H60xxbwJNeqSZU/d9ZDqWi6GY7Tx2bf70rRppaL0xzsmOoiqoTyg/8zBT6HtmDnqvAibLVol0uO5n3Zy1G508scIKka7xwSFbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792403188; c=relaxed/simple;
	bh=SmLex32CfN0i1QL4gh5elS6PvTSOZDSeNkGgujocXKw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S1T0/pRAHfOLbK3sJMwRI0/kgoIsyBCp1Olb4o8IDI+76cmeVg8EujR/bbpf5IoJim/Lq2IZeKRMS0F8OjMzPQLrRC7SlIVnLZBIIBGfxjE6gFDuKG2PRoHhnnmMFJDIvaA+UUhsKtcDjbSfdqz1KvN+YkIEvzaXvW6RPOrHveo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AcTWPhus; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AcTWPhus"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792403186;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SmLex32CfN0i1QL4gh5elS6PvTSOZDSeNkGgujocXKw=;
	b=AcTWPhus6Bmr2mdwl7BLw4Xd3s4ZUI4nOf+W74LcsBEEZrwFnucJePgIvJFqTqvxQhg8b+
	uTSZ7JCEqI34Cj26mwY831wNMmO/Oa4s1F7M1PitxlNUOzTB5HBS12rDL+Aui1gvV5b00U
	/nUny8pWFDGZ0ZSipWt4rXWCTQyWhw4=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-390-bOt5g2HlMpmei2KX-NDEkA-1; Mon, 19 Oct 2026 09:46:25 +0000
X-MC-Unique: bOt5g2HlMpmei2KX-NDEkA-1
X-Mimecast-MFC-AGG-ID: bOt5g2HlMpmei2KX-NDEkA_1792403184
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c3f8e149ccfso172568866b.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Oct 2026 02:46:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792403184; x=1793007984;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SmLex32CfN0i1QL4gh5elS6PvTSOZDSeNkGgujocXKw=;
        b=eGuidoU24lzAFcqlSRqhpB/FCGgal+14DVlcEd59kk0DpGdnFPyQwicUWAtoZGBHPf
         uKNUsnwpcJiAyY4YvQ/JC47h1WUSkNXM4A2HpRwZCPabd6RvMpIajGIlAvAs4gUjXozR
         Z0iGJmzDRx0NDEV7JcV+pLR8NEwTjbT50ygloSwZNlfY08rvreQk+HwksoZAl4QtALLA
         GzZae+zEGgs3LYn66GiM6y6BDVT/DjwzQSotMZgpdTNxUavpGnz78wZ20RTA+1sMksXj
         WnuoTaZgMOzbUua7dA7tuDcvMkUnYk3qHQ6MPSWMeOC5GYXWzcPzG42ECt2J8X5lp2gW
         r+ww==
X-Forwarded-Encrypted: i=1; AKwUvBzSH76Bsfxpin0XEx0jBTtqiYwLfn7jAy3jyDfFJvg4aMZDASnjFIL3gn6pJIVRm1U5dm97iC0QLqSF9dv/FvxP5XQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYIlK1NbYbySOk2aDwx/pgqopMf9hcarQNPpDfha4yZwp6NgUKZU
	eSiVc8UDL+zcO3qwZVdiHFl2qWOx5GYe+6JYm40zNLxlyJSQ0TIugILWoPSfXKAi0FndGhUmYby
	RkPqqEHq3HigmhvQidrChJidC9qGoYMO0KerQ5i3/6LUgxyjrJmP9b5YYPe+w7NiBuk9lQaAuZQ
	82Sb/J3vC1/uDe8RZB+r6raRGN+0pimQLvWJQ4Tbovz+WGvVK1
X-Gm-Gg: AYBFou1uzzethp3zlC8JO6eqIl0nhk0UDp4XQO2yj74ZOw8gsNtYwDOrt4pBF4VznRv
	IOTAhtFXr+DS3PDxWerXoFpmnewX5dZb9oAfILjLIbhfvZB5dbvVcUUOZRvIIk9r/Ar7m498Hr+
	jvMBN74vMSnk7ck82PDHzJsQf28opJYAA123dpk79MO/Ari56IJqoo/+FIUtnBfblpiDlYKCFgg
	46LlGO09LrcFUE=
X-Received: by 2002:a17:907:9725:b0:c41:8e21:4d58 with SMTP id a640c23a62f3a-c419a256eb9mr501680766b.5.1792403183924;
        Mon, 19 Oct 2026 02:46:23 -0700 (PDT)
X-Received: by 2002:a17:907:9725:b0:c41:8e21:4d58 with SMTP id
 a640c23a62f3a-c419a256eb9mr501677766b.5.1792403183439; Mon, 19 Oct 2026
 02:46:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261001152042.124445-1-gmonaco@redhat.com> <20261001152042.124445-11-gmonaco@redhat.com>
 <DLXSI4BSRE5F.1TLKCBUAGNDFQ@gmail.com> <b1fb01e1c58893795dd4be346f233d39fe653aaa.camel@redhat.com>
 <DM6H7SK4YZ7A.F0MM6C0I77OR@gmail.com> <878q3xtptq.fsf@jogness.linutronix.de>
 <8B3FF026-6159-48CF-8FEA-AF2FACD2E4EB@redhat.com> <87bj8s8ih9.fsf@jogness.linutronix.de>
 <DM78SVMBI2XW.2XHVC67VON48A@gmail.com> <87v770uuyr.fsf@jogness.linutronix.de>
 <DM7I2PYHNKXE.3AYY3N1HATXLW@gmail.com> <87ik2zryzo.fsf@jogness.linutronix.de>
 <0055967d4571e7c8549dfa476fa6b15b93013701.camel@redhat.com> <87y0buox9f.fsf@jogness.linutronix.de>
In-Reply-To: <87y0buox9f.fsf@jogness.linutronix.de>
From: Tomas Glozar <tglozar@redhat.com>
Date: Mon, 19 Oct 2026 11:46:12 +0200
X-Gm-Features: AclHuK_NXeaiajImg7lC8SzWuELhdtiOXhAgcdN_7Skq7dYerLf6JAXl0TbAm20
Message-ID: <CAP4=nvRXYieOtqLuE6SypkKHf1gtEjUbegb=wYiLtmAM9SHuYg@mail.gmail.com>
Subject: Re: [PATCH v2 10/15] tools/rv: Add BPF monitors
To: John Ogness <john.ogness@linutronix.de>
Cc: Gabriele Monaco <gmonaco@redhat.com>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Nam Cao <namcao@linutronix.de>, 
	Wen Yang <wen.yang@linux.dev>, Tobias Schaffner <tobias.schaffner@siemens.com>, 
	Viktor Malik <vmalik@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qUFyJRANVfHdJpBHKcBUM6JBW1wIVk9YWYVGChntyPo_1792403184
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2026 at 11:34=E2=80=AFAM John Ogness <john.ogness@linutroni=
x.de> wrote:
>
> For production environments, I expect that trace_printk's are only
> occurring for violations, in which case the cost of a string compare
> will probably be irrelevant.
>
> Are these trace_printk's available without getting the scary kernel
> warning when kernel code uses trace_printk()? We do want RV support to
> be enabled in production kernels.
>
> John
>

Since commit ac5a72ea5c89 ("bpf: Use dedicated bpf_trace_printk event
instead of trace_printk()"), bpf_trace_printk() does not use
trace_printk(). Rather, it is recorded as a separate ftrace event that
has to be enabled, in
/sys/kernel/tracing/events/bpf_trace/bpf_trace_printk, for each
instance that wants to trace it, and using it does not print any
warnings into dmesg.

The BPF documentation says otherwise [1]:

"bpf_trace_printk() is slow, and should only be used for debugging
purposes. For this reason, a notice block (spanning several lines) is
printed to kernel logs and states that the helper should not be used
"for production use" the first time this helper is used (or more
precisely, when trace_printk() buffers are allocated). For passing
values to user space, perf events should be preferred."

[1] https://docs.ebpf.io/linux/helper-function/bpf_trace_printk/

but that is clearly outdated.

Tomas

