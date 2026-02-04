Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EAB3D3D16
	for <linux-trace-kernel@vger.kernel.org>; Wed,  4 Feb 2026 12:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770208613; cv=none; b=OES8Eq1mbIrsDiBWc+DPi3aEbyQmUR4UX9yb651Duy5GBT0+bZQXzYKCj/oJOeU58M6HvdCXiw+5a1P4625LDeNZLkRYxKcrwYTbPLz8npRl7xnOJlMzqy4R9Qu4+fDESxl2UqzvKQMkAPKJjhQti8EXZ2WvAoTDS6WSjkxOClY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770208613; c=relaxed/simple;
	bh=ZUtUU8w3n1Ps+0zwZM+YcPHrIvjLtPw1rNq3K3A3tpg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X0cbs+mk7Y0nd4i6GhTGQsSxx5AHDz8mEr0aKtC+0VBOnvrtBW7QPIZ98B8tEtqRsxXhz8dB7gMqu2I1FC4R8flIi8bOfxlK3E1lDKbywBDm3T+vul8O+jx79negB9AGNWnVs4PwHKeXxtiMAAiExe9C7pyYvSzw9GZJea7iPu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Igsbuvq8; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Igsbuvq8"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-482f454be5bso7343395e9.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 04 Feb 2026 04:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770208612; x=1770813412; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cmvHSszd0IlLpvYredQUSiRYBuWhyTBWjd5dWUF7dDw=;
        b=Igsbuvq8qQSvGFE/RJyabwtmp/5NWxYmDJ7yugFitx1God5CgdtDSNzkJT/w/A8r3T
         oex6L1acC6cRbU9Y/vUhNOnzdKAmtQH1tUtKm7rqr0sSwI3ID7xZgBdophD9Dp5HBkiX
         kvaH3yeMP1PmSRJEC73mtSIbsXUxSli2euC0bH3UfGhV6JTZCh1v5kBUKdb8RyA+mNGQ
         iC4RtiHy6dDFmjMeVG/dDMELakkw+XQDuu94PTbH3H8gpO2EkKxAxQc3eldD3ugfqEeL
         6BsnKD+cmyuTUXqBkpMBH/6xXovd9xA/11XlvaOHCb/OqfacpqwgMQqNqfz9yYymdTBw
         gCAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770208612; x=1770813412;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cmvHSszd0IlLpvYredQUSiRYBuWhyTBWjd5dWUF7dDw=;
        b=Seto8cVFqLHpeQs59VeLuZL5AEpBJpgdTtq+Qns7rlFIitWUWIzjBzdZLtPpspFxqG
         mi5mH0V6NPeGrz91QjzT6Zc3Q4eY3kS3VoVTaPVU5VTRy6gFoVYSJ1Wi45TkkwS2AIT7
         2kjzSyKPAoGEzZLCMcnaSrpvbL5hccN1OHtlMPcyq+kkVb7bgymlRqTuIujrufesH8y+
         906RyEikfvNTSVDOtYFC1RN3V6x/d/N7z6asHr4aHHKdachBW+ETiAm+EWoFBjYEaX87
         B3ZAgh/9tBsruU072WkVxkkeUBDEPvXepUioQoCLll6DJcPQbjbrLmJWSBdFzfunhHXC
         woIw==
X-Forwarded-Encrypted: i=1; AJvYcCXVVOGaICpMrH8uToTcRtNhG31bq0UpSBMaut+rFDImAX7EJB2MeLpAfWrKVpGKWZ4WIf3nMvr7/JTpfsZXm0EqMHI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3bGrO0nWsYPPRT62lQsYx9qVU+O2dox9CpagxApmZU7Fw7aXc
	vGeh42lEQHvef9cAw1v/2+lwiGJJQ3rZOpmEqzIVzVBkWnYu6QrJt32N
X-Gm-Gg: AZuq6aK9N7KGMJQm62cR1cNiIBLq+dgheB3XoFbE7Hbh2jEvRRTaFOeLi491z9wVxAq
	FxQedyKaXldeCL82mPPQy+BHqVHmY1gwAPMVGvlE2DybE40wnEMNStNdfZZGrN+g6cGc3C+vd13
	N1qAgI9hEP+ZUbJZ4VVc68JhEH7WGuBu5f6IoTizMNlKZBTQ7sSJfkBYLxjVek0kdJ2aCKW3dnH
	O+Zgb+47RsfsrMZwEm2i2mXu083raMyOm3vFJXljxMPm5fatIORzBPRX/Sg54bEDr3Fu1w9h4i7
	kqiAdyBDJUMmV9nhLh1jsE8secM2G6H4dr3GLnwJrBGm5v5sbmEs7RXblG0ktLOVQps8p5cLyZo
	ZRwxIKi9Y8jXGKiU/5FadZdEhWVokZgr0L6C/7wXRyFoEZjvwyWopVBM/y6sD
X-Received: by 2002:a05:600c:6209:b0:479:13e9:3d64 with SMTP id 5b1f17b1804b1-4830eb6540dmr35302075e9.15.1770208611368;
        Wed, 04 Feb 2026 04:36:51 -0800 (PST)
Received: from krava ([2a02:8308:a00c:e200::b44f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4831088ce39sm57168165e9.9.2026.02.04.04.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 04:36:51 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 4 Feb 2026 13:36:49 +0100
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>,
	Martin KaFai Lau <kafai@fb.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Steven Rostedt <rostedt@kernel.org>
Subject: Re: [RFC bpf-next 00/12] bpf: tracing_multi link
Message-ID: <aYM9YUl6xf9I2x4c@krava>
References: <20260203093819.2105105-1-jolsa@kernel.org>
 <CAADnVQ+EU_f4LVDQkqkB0Q+QYMBH5ynXU3+rGZA2XCGmYMcFqg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQ+EU_f4LVDQkqkB0Q+QYMBH5ynXU3+rGZA2XCGmYMcFqg@mail.gmail.com>

On Tue, Feb 03, 2026 at 03:17:05PM -0800, Alexei Starovoitov wrote:
> On Tue, Feb 3, 2026 at 1:38 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > hi,
> > as an option to Meglong's change [1] I'm sending proposal for tracing_multi
> > link that does not add static trampoline but attaches program to all needed
> > trampolines.
> >
> > This approach keeps the same performance but has some drawbacks:
> >
> >  - when attaching 20k functions we allocate and attach 20k trampolines
> >  - during attachment we hold each trampoline mutex, so for above
> >    20k functions we will hold 20k mutexes during the attachment,
> >    should be very prone to deadlock, but haven't hit it yet
> 
> If you check that it's sorted and always take them in the same order
> then there will be no deadlock.
> Or just grab one global mutex first and then grab trampolines mutexes
> next in any order. The global one will serialize this attach operation.
> 
> > It looks the trampoline allocations/generation might not be big a problem
> > and I'll try to find a solution for holding that many mutexes. If there's
> > no better solution I think having one read/write mutex for tracing multi
> > link attach/detach should work.
> 
> If you mean to have one global mutex as I proposed above then I don't see
> a downside. It only serializes multiple libbpf calls.

we also need to serialize it with standard single trampoline attach,
because the direct ftrace update is now done under trampoline->mutex:

  bpf_trampoline_link_prog(tr)
  {
    mutex_lock(&tr->mutex);
    ...
    update_ftrace_direct_*
    ...
    mutex_unlock(&tr->mutex);
  }

for tracing_multi we would link the program first (with tr->mutex)
and do the bulk ftrace update later (without tr->mutex)

  {
    for each involved trampoline:
      bpf_trampoline_link_prog

    --> and here we could race with some other thread doing single
        trampoline attach

    update_ftrace_direct_*
  }

note the current version locks all tr->mutex instances all the way
through the update_ftrace_direct_* update

I think we could use global rwsem and take read lock on single
trampoline attach path and write lock on tracing_multi attach,

I thought we could take direct_mutex early, but that would mean
different order with trampoline mutex than we already have in
single attach path

or just sort those btf ids

jirka
