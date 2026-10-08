Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C396C48CD63
	for <linux-trace-kernel@vger.kernel.org>; Thu,  8 Oct 2026 09:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791453309; cv=none; b=nqT2DQ6aTOS07Pz7vp4voYSwSmoYwBK+qMCPsTZtQoBxdrsbU747rZxGyqgjlwwCxIUsvpgnJwKR9wviKPiLGRnAhL08p0Ph9WlfwlJyizUWLECVnCs0h7evSA8JZ+Y2pVj7t1XtZZnl37oWdBxiTDScu3WoPsLgIqeQ0cTpbU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791453309; c=relaxed/simple;
	bh=hA3kqhop/jmWThVc8bxpiguguJ2XqWL2Dl9HzgCZueE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JhUahrXyGH9QDt3YdMulVZgq3WCw9PgZ7yzwHjxIdzdSnzvjWGrnSt3nZ7+2pI2296f6HipihL8tkBNB/npnN36hponuKeZHd7pBrTGtf4moY9U0clxSGrUx1zgHe/ZyfF3HYOQn6UsLaCEBg0xDfZTVcckXenRmoeVAiZTFGlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZnqfViF3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZnqfViF3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791453306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=hA3kqhop/jmWThVc8bxpiguguJ2XqWL2Dl9HzgCZueE=;
	b=ZnqfViF3i+wCyDVqsfMOVqJBJWyEjcBjVgottaoCIUGm0hOwumbz5Sju00G4PN1TB0oT8M
	yweu48PCcF0dLMqzi+Jcq64SW2Zd+6VCBkGXxbAw0JUNl9qsPgBaPSOl472JZV3KS+LBHQ
	WX5R3mo+cAN+uNEnPl0xDxJgYVYSd+M=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-Eq0CJ57jNceco2QmkW-mBA-1; Thu, 8 Oct 2026 09:55:03 +0000
X-MC-Unique: Eq0CJ57jNceco2QmkW-mBA-1
X-Mimecast-MFC-AGG-ID: Eq0CJ57jNceco2QmkW-mBA_1791453302
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c2e2a9fa1fcso583846366b.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 08 Oct 2026 02:55:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791453302; x=1792058102;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2rwd4c1hFdRk+8gic1oWg1e821LH97Si/hZy7R8ff64=;
        b=PxBnqwySuHvFUu3qZXbQThpGA5RAOF1zrdOz/fvVIDF4UjRWJfTQsvBIeMktzZmID2
         vnS2kdmNbfz28ZmT1UaVy1kRgKq55XaJbA12e9lx3EWluQzZ/A0ZZWqDy8p4SHXn+J8a
         qv5UwgsyLADOWAFDGLefhsnf6P0DE/0vG3qRyxVTSvdcbRJEJk8q+cBfjknsKX9xvIYZ
         D6TG57i75Gs60ZP4Sx2UvOXQULo8vy6Ar/MzoGUBwzLQe0LKb1TJDXJ2s285p+3Wxmt6
         DyV5hFah+HTJZt7wZ9r2SSlY5dNvS5YtiA1rN0SSFx5tvW4hQL6BSQHu9ShBbZ9GaCFo
         tKMQ==
X-Forwarded-Encrypted: i=1; AKwUvBx//+0Xri+2BfhJzFS90HJL7tTUUbciX5tOwNY0i0ZVnN4MSQDBkj/vZGC1N65WAEH4xxBGW2skzzJuatJKPlklr1A=@vger.kernel.org
X-Gm-Message-State: AFuF++mia1ev7vf8Mmn4gdFavBSGc5wnc5iwJLe3v5uX3cHdY2FrDBtL
	U56Ey6PnTuLP6zoO2gg4yHcY6hKbOk5Is5uvlhkCKpgiHcerSgH9qGvvg/FrUQJpCYA/cCNDM/u
	DYEPGdgQXmewgTn4xNpaa2OKijrE86S1GknCFVZern8zTxdzX7AgfQxIzXutSB/GBiGSnAxPAoA
	==
X-Gm-Gg: AYBFou00zb7Txk3KZMLOR33hqp78hVyB1I1skQJKYA+HxSKrMYScoUk6IDAguyQoQHY
	oTmQADusxfMMtbg0VSCISdpet+1EJBR7WbqPr/ASGMb9gRYUpOORw2qSov/vBOMBELqUR7QmFXt
	hEyp8QqceYFwRZknuUJ5hSqiseOq6pnvgwkUAKV8Xdwx3kXi4yBUD6yY3SyoRSixx/bo5dHkmla
	EFxSu46rTV7SmjlJoP3TwUd0v6d/1djpAfqblcvoCOznxdgQMgJk3euwsEDTJ5PEubh6PnVJmej
	BDY/kM3Z113lUpe6YCXMjTK60bwldwvBAXqqCykx2pRR80o1u+h2kj4dgHLqbk6sjYSCOnstXAY
	UgsTkaRQdzG0SqTYJS7Kh0iF6ramC9bsPybJcet91zzTySxf06j80cIEGT5tPg5ub2TRYAA==
X-Received: by 2002:a17:907:8688:b0:c2e:3f49:df04 with SMTP id a640c23a62f3a-c317bbdc08fmr523188866b.1.1791453302338;
        Thu, 08 Oct 2026 02:55:02 -0700 (PDT)
X-Received: by 2002:a17:907:8688:b0:c2e:3f49:df04 with SMTP id a640c23a62f3a-c317bbdc08fmr523186766b.1.1791453301931;
        Thu, 08 Oct 2026 02:55:01 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (212-8-243-115.hosted-by-worldstream.net. [212.8.243.115])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b00aa2b8aasm1188417a12.22.2026.10.08.02.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 02:55:01 -0700 (PDT)
Message-ID: <b1fb01e1c58893795dd4be346f233d39fe653aaa.camel@redhat.com>
Subject: Re: [PATCH v2 10/15] tools/rv: Add BPF monitors
From: Gabriele Monaco <gmonaco@redhat.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Cc: Nam Cao <namcao@linutronix.de>, Wen Yang <wen.yang@linux.dev>, Tobias
 Schaffner <tobias.schaffner@siemens.com>, Viktor Malik <vmalik@redhat.com>,
 John Ogness	 <john.ogness@linutronix.de>
Date: Thu, 08 Oct 2026 11:54:59 +0200
In-Reply-To: <DLXSI4BSRE5F.1TLKCBUAGNDFQ@gmail.com>
References: <20261001152042.124445-1-gmonaco@redhat.com>
	 <20261001152042.124445-11-gmonaco@redhat.com>
	 <DLXSI4BSRE5F.1TLKCBUAGNDFQ@gmail.com>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: LxrmllfPAg3Tkp4RdCW4n8vtLxnNHvloQ8Oaf-k8Mu8_1791453302
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2026-10-06 at 13:29 +0000, Alexei Starovoitov wrote:
> On Thu, Oct 01, 2026 at 05:20 PM Gabriele Monaco <gmonaco@redhat.com> wro=
te:
>=20
> Overall looks much better.
> Some of the code reimplements bpftool, but it's user space.
> It can be cleaned up later.

Thanks for going through these.
Indeed I tried to reduce the code reimplementing these things but probably =
I can
do better.

> > +$(BPF_DIR)/%.o: $(BPF_DIR)/%.c $(VMLINUX_H)
> > +=09$(QUIET_CLANG)$(CLANG) $(BPF_CFLAGS) -c $< -o $@
> > +=09$(Q)$(LLVM_STRIP) -g $@
> > +=09$(Q)$(LLVM_OBJCOPY) --remove-section=3D.rel.rodata $@
>=20
> What is this for?
> Released libbpf ignores it with "skipping relo section" message.
> Removing the section only hides that some pointer in .rodata is left
> without relocation. What is it? libbpf in bpf-next needs .rel.rodata to
> resolve pointers to functions. See commit b223044a68d5 ("libbpf: Resolve
> pointers to functions in read-only data").

Yeah indeed I used this to silence the warning. Apparently right now the wa=
rning
is gone (no relocation section even if I don't trim it), but I went back to=
 the
initial version and it was about a bunch of .rodata.str1.1

I'm going to test a bit more but I can probably remove this.

> > +struct {
> > +=09__uint(type, BPF_MAP_TYPE_HASH);
> > +=09__uint(max_entries, 10240);
> > +=09__type(key, da_id_type);
> > +=09__type(value, struct da_monitor_storage_bpf);
> > +} rv_mon_map SEC(".maps");
>=20
> Why hash by pid?
> Use BPF_MAP_TYPE_TASK_STORAGE for per-task monitors.
> Once there are 10240 tasks bpf_map_update_elem() in da_create_storage()
> fails, the error is ignored, and the rest of the tasks are silently
> not monitored.
> Task storage is freed with the task. No need for handle_obj_cleanup,
> id, target and PF_EXITING.

Great, I wasn't aware of it and looks much neater. Will use that.

I couldn't catch you yesterday at the conference, but I can summarise here =
what
I really wanted to ask you:

Reactors in this patch use bpf_printk(), which is in fact a trace_printk()
instead of a real printk, is there a technical limitation forbidding us to
create a kfunc using some flavour of printk_deferred()? Or am I missing an
existing one? (this need was brought up by John, Cc'd here)

Not needed in this patch but potentially required for more complex monitors=
. In
kernel, when timers are required, we allow monitors to use hrtimers (precis=
e but
heavy), or the timer_wheel (lightweight but less precise).
I'm not aware of any wrapper of the wheel in BPF, but I think a few kfuncs =
for
these could be useful, in general, also for other programs needing a lot of
timer instances or simply light timeouts.
What do you think?

Thanks,
Gabriele

