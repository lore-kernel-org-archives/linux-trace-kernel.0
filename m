Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793058730;
	b=DweXcXqWYAjte6LfgQR67FneGa6FQy/4xbzhzbolyaqfrOOI8CorK5mgNjOxe1XZ3sKY
	 +e2mKtg+bpbt9+NehLmpy1jIDjwv2aZoxLl/GPqrlQVWvvavG8pCZw2822HITTQILbT41
	 KSH1BcEzGi41Lv7Nn6sSPMFWHtOveysFsJgv96UUVOPdEGHyMGsi/Hdhq17iGPlJIP0T6
	 zTsnftbwwgcdvhmQdSg2DdRV81iLHBcD6b2rJ5Uf9U3Wba7PEiB0j9lHDphNJp4i3bIqR
	 E2KneTL8Vu++FaP0sv6r7wlwT8EBR7oNuu1uTK7uko0XtF8pmkLXEACYfFWOD8O1RMQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793058730;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=wkDgiw/AqsIfVPHoMoSGYbq8gYoliaNoZ6zCaoCS6us=;
	b=RXEgr+5fPuqSyJaee5hMcNQjg7kuXmqY5ZnFIc3JLkhCBqUzpdP23ORx8F7pFc49jQ3W
	 jqBElxkS/U0negBSMAw6I69bsf8HJJ8lR036E4UYOHUlXDHfuP4EEqYkOsDDfHVTixRHj
	 wVcp1wyVeJbxV8x4IxShq8LsxII1ch8Q9mSDEJHrFxq/CycAM6bBU34r3l5/Jls4vGOJ6
	 jJqu5WLN5ZGc6mdL/KexyhMLH5E+aAZdsqpTJNiAOCfRreTKqnlJAb8E0GDTE9S7Bq6vr
	 LgnyIolJnh4JWbykpI0sJId+pF7aoJVMn3a4rTsKB/6+asgSkkY/td4Ec8dKElGO07Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=IrwijN25;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.46
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DE8606A320
	for <linux-trace-kernel@vger.kernel.org>; Mon, 26 Oct 2026 23:52:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3DE8606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=IrwijN25
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6b1ab2ad719so5582790a12.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 26 Oct 2026 16:52:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793058728; cv=none;
        d=google.com; s=arc-20260327;
        b=pPh5sh6nYTuWOSQo+gm0DWkAqubiSTmF+ewkJYmQANFFo6Wg+icMW4HkUtqHPfQom3
         uvKoVvy90dfQ03PhAObcWw6Es3kYrKlREPy/+6j4i6N86OXUvjEWQR4p8Kihq4hbIw4i
         MAZOL4t+9pRmV3zXfTAiJDfAmDrmFfKIgBjP6qrIEAe70sSR2SXGuiV7k8RcqaH4LiJn
         aoO8CSFL3/vhKdsuoq6hk1MHHcDEZt287WX1CnEq6qnFJttxrzxpDjCgNbOjVgZ5MTny
         5LNRXlmIkeyRRghbq1WFBI1ZiGIPVK3q53zbNue2VxivQhcTDbA2m5OZ7qIeNCCaiNjq
         YhwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wkDgiw/AqsIfVPHoMoSGYbq8gYoliaNoZ6zCaoCS6us=;
        fh=wh66yYq/DI42iKQBy4hznVnz3jxulUg7oZkqgq0L8Bo=;
        b=BOil7+Tp5y3nJoNBhsLbKrKKUQ9o/Ho5bL1r3vm4L9egqoEP6f6ePr2kKymFuDDv3e
         v9vKylI4TC24QwHgNsHi1/mbGlhSU1U9WIjNW/Qyjed1n0v5enxZzvaS0jIUeiEiRSyq
         GE63+nL9ePTaU0NIoprWIGtDXZ1jfeEQZk9ZQKqmy8BngcmkC+5UTJNffvWcMTHdo5aB
         gZrxSaZYJGViWQOyNrLLhtT2CupUN5rjVbZEE3kWWzqEYBk+I+WiFEz2Sdp1OqxV6/69
         LcLxQns5dqyQdGyx49Y57lNhqCrRhUoAAVOFNt4nLF8wogXaFw2OFdyj8gowefhR64sE
         Ns8Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1793058728; x=1793663528; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wkDgiw/AqsIfVPHoMoSGYbq8gYoliaNoZ6zCaoCS6us=;
        b=IrwijN25Y5XuhkNoEvpxTGUzu2F8Fw7yumOC6bQX+sv9sI5cIkUQ+8qDyW8Rn0leIE
         KD/M3UgHYaJH9qxw5QEzap4cvaO8QRp4WvUy/b8d8qlbP4zjT/NLwA46mVK4rk5TE67Z
         hbcIs7JRXy3S3BU1Zp46QexhDFTfTqhgb9F5yDiJoNepIvxVOAnGlUkvuMj53pVOulEq
         nY7AospiQUxyoh3b4b1zlSlhp0Xm7S9U0DWHUHqyywQpS6V9BxBGr6qPvm7+SL/x95K4
         vKS38fvl7h/D+VqUiNNcMPjyNlpB+LfGZlaoNjHo8oTsgp0eeolgiheQhrTjRg97kEV2
         ylBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793058728; x=1793663528;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wkDgiw/AqsIfVPHoMoSGYbq8gYoliaNoZ6zCaoCS6us=;
        b=Ad3WLm4n/lRq+xMl/wy3p92SarvCFWfTsr1A+SeRNvRJtRNiBLbWDX4XuBsysQQStC
         16Nk+eBFaCFgjP3puDnKTe+r6oxcr/mtYEa/pyk8PtpJ5djDLbNdLfh1tBQdjfehG9kZ
         +X/hZQsSXR1scJoTNAGO2lcTn2f4b8cusQDnfEZSNs111F+iBUohLDlYZFjosIc9Q+iY
         1izKrMc5YY1vr87/w7l/ebnJLoa0uKP4vdLrpX8RttL7NVIHgcuUpIMvpd1NgmoSTh2+
         0VtggUeYBXtJR0Yg9qCuzxcRhzBUUewuBXsEhb7aGVKvA/bNV6cYWhBMyA2xM672X4up
         ssaw==
X-Forwarded-Encrypted: i=1; AKwUvByqcswihC1S4hot8BUGlExJhCBsrEfPNB/NAoLwnZwFPAXryIjZaoNOGZiFMaaTKhJSl/8n1B5d4qvYQ1ScE1zvD6M=@vger.kernel.org
X-Gm-Message-State: AFq9FYL23ezOA7t/gxPlHe8nwBCEf8NUzVRkF8yycpJ6PrLIcV7CW/fO
	NnHHAha5xOihqgbLaHRR19IfrPCUtGhHI/Xmu+k8vGVw1EcvNro1OBkmnTzrxACggaUhhXY0Nbp
	68po5WLBnq+Ad9OSpDFMvISsh+SrMB5xCTfymTr/0
X-Gm-Gg: AYBFou2wMR8x4MsGWCcITrCmEnVtFGcorcFX1z6RFjb7HJnDOSvUlIAueoMMXR/dS6H
	OPM153I2GdZiy92KrXMmBUCtl4BpWVwHhiRWplQyN5B1gpHEmdU8QyHsshgkFJ/emx12qbfVhx4
	uW6WJwHOSaysH5itM9o+btHuI7cek2CF9M7u24d4iAjKElxp1pZ/0dybJ/1ne34h7oUdn4RHTRW
	SriDdTf3eOvsqPHEWUCKNgiTjmR6GKqLXjPhZayv2IsPVniC6bU358qwqk3xKwfh4MVRBwcYTaa
	w+4gGuSSMd0O92eZoUrytNxbqL+XL+1/stshfZMitRE6PQPhhbFUfgqxa6RB0aNDAt9Porjh116
	eTXSg/+BYTO0yZj7rOy2fCpjtFECsCYG0E/t1VUfdo4iqSv/iQYPae4EOl6FWeeCZ7czhz2Y+LK
	oM7boXAFMzptxxdX3OMuTub9XFIz3Qb5LWuLF0v5SrZq67zIC+f8Jsxn/+ufe37kgVQV92fDWnJ
	77g7L6wlQ==
X-Received: by 2002:a17:907:80c:b0:c46:6a50:40c2 with SMTP id
 a640c23a62f3a-c46bdee2675mr943075666b.39.1793058727681; Mon, 26 Oct 2026
 16:52:07 -0700 (PDT)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261026215226.3713941-1-jthoughton@google.com>
 <20261026215226.3713941-11-jthoughton@google.com> <3b0a8fc4-d140-4a90-b810-cbc1283fc083@app.fastmail.com>
In-Reply-To: <3b0a8fc4-d140-4a90-b810-cbc1283fc083@app.fastmail.com>
From: James Houghton <jthoughton@google.com>
Date: Mon, 26 Oct 2026 16:51:31 -0700
X-Gm-Features: AclHuK-Nhf6TYTDNWSq0v6hReecRKBdo5ExoV8oZWGVCIO9BK-126Jv082Kq0QQ
Message-ID: <CADrL8HUZ3t8RdMEeBPfqsy1_1rN0Ty9B2c4iP6OzNS12te6vOg@mail.gmail.com>
Subject: Re: [RFC PATCH 10/10] uaccess: Move the NULL mm warning out of line
To: Arnd Bergmann <arnd@arndb.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Thomas Gleixner <tglx@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Kees Cook <kees@kernel.org>, 
	"David Hildenbrand (Red Hat)" <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Jim Mattson <jmattson@google.com>, Jens Axboe <axboe@kernel.dk>, 
	Pavel Begunkov <asml.silence@gmail.com>, 
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <mkp@kernel.org>, David Sterba <dsterba@suse.com>, Chris Mason <mason@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org, io-uring@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-btrfs@vger.kernel.org, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2026 at 4:03=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote=
:
>
> On Mon, Oct 26, 2026, at 22:52, James Houghton wrote:
> > uaccess_without_mm() is inlined into every user copy, including every
> > copy_{to,from}_user() call site on architectures that define
> > INLINE_COPY_USER, such as arm64. Each inlined WARN_ON_ONCE() adds its
> > own __bug_table entry.
> >
> > Keep the NULL current->mm check inline, but move the warning into a
> > single out-of-line, __cold function, uaccess_warn_without_mm().
> >
> > The trade-off is that only the first offending access in the system
> > warns, rather than the first one from each call site. The stack trace
> > still identifies the caller, and the access is refused either way.
> >
> > Compared to the base of this series, with defconfig + KVM:
> >
> >                      inline WARN_ON_ONCE()    out-of-line warning
> >   x86_64 total       +5,884 B (+0.014%)       +9,714 B (+0.023%)
> >   arm64  total      +40,948 B (+0.10%)       +24,609 B (+0.06%)
> >
> > On arm64, this removes the ~16 KB of __bug_table growth, while text
> > size is unchanged, as a call is the same size as the inline brk. On
> > x86_64, the call is larger than the inline ud2 and causes more .cold
> > splitting, so this is a slight regression.
> >
> > Signed-off-by: James Houghton <jthoughton@google.com>
> > ---
> > NOTE: This patch is included for reference only, to show the cost of th=
e
> >       inline warning.
>
> I would suspect that the growth is larger on architectures that
> don't implement __WARN_FLAGS() but rely on the generic WARN_ON().
>
> This would mainly affect 32-bit arm and mips machines, some of which
> are very memory limited, most of the 64-bit architectures have it.

Thanks, Arnd! I ran some build tests on 32-bit arm and mips:

arm (multi_v7_defconfig):
 - base: 31,913,726 B
 - patches 1-9: +64,816 B (+0.20%)
 - patches 1-10: +23,193 B (+0.07%)

mips (malta_defconfig):
 - base: 11,830,177 B
 - patches 1-9: +61,168 B (+0.52%)
 - patches 1-10: +25,881 B (+0.22%)

I think it makes sense to include patch 10 with these results; cutting
>50% of the size increase for arm and mips seems worth the trade-off
of only WARNing on the violating callstack. Let me know what you
think.

Is the increase even with patch 10 too much for mips or arm? I can add
a Kconfig in that case.
