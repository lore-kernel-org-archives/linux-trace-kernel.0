Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D400728727D
	for <linux-trace-kernel@vger.kernel.org>; Tue, 27 Jan 2026 08:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769502413; cv=pass; b=RyNxk9tQfXcOEWbqoT2/dvzHUBQkaxt+K+RZLBZoB6xIMcY46S4ZAj7gFH3d6MxQBoiQ2Cwfm6sB69RS5wFfLUuVZZ7NulqXeEP+T5E8W87tH+uz9iHpQ6ghdeU4VYA0BYJmnU3DR0aERGsneJGevmAQaKOtdl90PATW7glHBoI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769502413; c=relaxed/simple;
	bh=Sl4m3dvsEO0VkRuYOaBX3ctrGwJsczeT19nXFnORUlQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kuf+EQ79jmfBEHFE7a8FgQcKs5/lP8xiiYm2YkFoiiGh36klRFnEc4m33ayU3KY0edEC9LQ7lzcPUcLJ14zt1EaeFZJtIPs1FcdBQw+dEfCtN37Nqpz4yWg8gyQcri5qae8LjmnJnB1fwCan1ItluYYU+W9yEV3TGEqV07YMb0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GVuwfh5r; arc=pass smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GVuwfh5r"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47ee937ecf2so45536575e9.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 27 Jan 2026 00:26:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769502410; cv=none;
        d=google.com; s=arc-20240605;
        b=fm9fUVnc4nCDg/ZeVxvLps268Mva+JHBiNax8dJdmYKSSj6pMrJWmxDhCYgjMYRPkb
         i4zbf4YEhMTBsZkjqKb1WdO5KMcEqWmgJgZrR9tQJjl9rzoZZ8jhloLWDuclsVUsgmlD
         K1RaIEyaln9HZ3BGONMPtGoGY3CtrRyeQ1fcNPYdEOs4+tLO1+z3oMp1sjO7MJ4pWavt
         XzO8xQtzSTN/Lh1+pStviQ9fYFRdFEjEDlnGQOxqNYkhOMsj+lLsKhhWRJbTS1g1VIaF
         y+XswlJQ00mVVCoqldMmSFGtUE8zSj6SI3KrtzILjQzyItj4hvpL6mFY861RHToyL8hw
         ABNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Sl4m3dvsEO0VkRuYOaBX3ctrGwJsczeT19nXFnORUlQ=;
        fh=+9wk9lfzXwEnXkQ9toho3Wo0vsN8le1TV6qCH9lCRTQ=;
        b=ik22cJUf/busAuepAwPnWD1OF3vz/qSZ7TAy4vHaGde37VNu+b2En/9i+6wMsQ+ir1
         eQb2dFSJ+LJ4zz5CWIaD9BpiHOoaLlg8PSrI7HxgoRctMnXJq18ZhWFMSAje5zd8SFYP
         GNU3+0/rBgP0ILe9FqiIayV1U74v5a0sQV5MMcMNQiJdx6kTRA3In5/bO9S3G8qtfseo
         QiBK4Yfl8SRLgx7HLrg/E9zHbZsZjevlGQi3ZMZQwVZUAOXF8ME6sh+GQBqIH/3NoamC
         LD8aFvSiS/HY3P9IGrKRbV4cTfFky0ciWGH68NkUilQ+SRMrBPycylrq7Bx1rTJA0qdg
         1kqA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769502410; x=1770107210; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sl4m3dvsEO0VkRuYOaBX3ctrGwJsczeT19nXFnORUlQ=;
        b=GVuwfh5rWga+r5e5wK/1qktVK+ue7X8olp1Ttsoz26VeLWpoO30ciFco/ODArl30Or
         /oyhAXKbwvCJbg3hsfCuoKclaF6URIW9qbytzI2avZTRPt0Ycb3TmfRCybNzAvfd5Bjx
         udVyigaJ3QgG/fGLgz3yv9NhioFkNB8gNRgqVXv++GSHUYBxqcM6tygQanC6ywEe31zo
         eTV49ytpH+hRytMYCnxgGURH1JkNKHJQNHi87AnGTiAvrnjn5AzUwKA5vCvYNTlvREWE
         9saBApihjYg5bMBq7ji18Z7zhYmcub4GuaAuqghW9YCIp//Qw7DjSWW7kJdVKm99153Q
         O8ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769502410; x=1770107210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Sl4m3dvsEO0VkRuYOaBX3ctrGwJsczeT19nXFnORUlQ=;
        b=F+RhFKd3ssczMq5MHSLigOmWloS/Ouz8/0eCeqszYwRZEhyWdFtoGPGhfZi3lkICjz
         ci0j52/vem3GrOyX8LevQW2w4DBk7xCvaQ44b7Cfr3HYJ4hCV35Or7D2ecEeGYmn/8kQ
         dSwYAXTnGLVuxDl1pR+j5wr6eooVZ2vodyH2oUrspr1MBeEyPcigWsrREidU2JzuKk/l
         1nvldyp63XEIjN9zFYoObUTqFV7TonRyF7y3s4N9Qu6e7OJPE9/WYa234I8XNnT6Q9J0
         3BvUmHO7BiUgLOw5mjd1Dw9ElGjaopPNtmMTrs31e3Y830QMN2RLTcyc5B1u3jWPnC0P
         RcEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdn0scy7JAbnU2WoVbMQjbZSVGTiEA8fXj7rToL4ROBIIch0RfNozJpcneHpdSLRrEFtynrpVl72nHd6jVIfhlSSY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyph3InwlhsbmAOXZT52bAUFDH8Q6KtqX5IMyBfSviewBui9Nb3
	cQBoIb6sMLT4WNheW2tcS5TbTER8o6SbiemTJb4LskGuY3B5qlJ2p/zkY8olSCjRe8vFrWxwga4
	Ik918k49RYK8ogSOq3OCyq2+0Nsbx+DBmD3F4/9AJ
X-Gm-Gg: AZuq6aKEC7DgdIyhvB38PG0dK0RZ7ku8y7F6Ya4n8J5G5b32csT/BS5Omib7sms4LnI
	YiWvwjzEmY2EHek0kdzWRMCiP+LOAzq0qt3OSM8L5sX69bP4RksJAJrDnnzzrpeuRSQf7DZcrrK
	i5hjw9ILF2BJR4h6zq6FxqyztoANHJEz6eELX3vmjrTHO2L1U1Bryoob10njzKnCNnoL3Gtelt5
	DVctoSmCSWQIsF6xGcjji5PgInD7GNxZ8Lx8teIXD0b7vyN7nkGLQA2kxdXvH9DTeZGPNcbqclX
	MLjduSfBHmxdqh1ma7UWnHQVpPxFkv6WJjWprLt4HO3Yrdv93CD+ErcIKg==
X-Received: by 2002:a05:600c:4e4f:b0:477:a71c:d200 with SMTP id
 5b1f17b1804b1-48069e70621mr10255735e9.11.1769502410131; Tue, 27 Jan 2026
 00:26:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260107-jump-label-rust-maintainers-v1-1-702b03482f2e@google.com>
 <CANiq72nV0Z_UjdAwT=41TjjfmKnT6WL4hVNcxg_QCe7TAEYK_Q@mail.gmail.com>
 <20260112100006.7db6d31d@gandalf.local.home> <aWUO59edshSRit-Y@google.com>
 <20260112115408.48ed4d35@gandalf.local.home> <aXddnjiHCX-XS5S9@google.com>
 <20260126213748.GR171111@noisy.programming.kicks-ass.net> <CAH5fLggpBodWYv2EQy5sgg5eSp9=7PM9ZqXcKaTuozNKN1eGGg@mail.gmail.com>
 <20260127082401.GS171111@noisy.programming.kicks-ass.net>
In-Reply-To: <20260127082401.GS171111@noisy.programming.kicks-ass.net>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 27 Jan 2026 09:26:38 +0100
X-Gm-Features: AZwV_QgANvHt6Lqy5OOiiQfMqFktPFZ9UjT4gMNqlsOKZAwYLRP9FTi1Hmw-t5o
Message-ID: <CAH5fLgiA3Cat1g69O04mnd08bwzxnVKjgV8mABTRoK2G87S4Tg@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: add Rust files to STATIC BRANCH/CALL and TRACING
To: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Jason Baron <jbaron@akamai.com>, 
	Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 27, 2026 at 9:24=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Mon, Jan 26, 2026 at 10:58:24PM +0100, Alice Ryhl wrote:
>
> > > > What about the STATIC BRANCH/CALL subsystem? Should I also leave yo=
u or
> > > > someone else as 'M:' there? It's unclear to me who usually picks up
> > > > patches for STATIC BRANCH/CALL when they are not a dependency to a =
patch
> > > > for somewhere else.
> > >
> > > I think that'd be me -- I typically do the static branch/call bits.
> >
> > Ah, thanks for the clarification.
> >
> > Are you ok with using the approach Steven suggested for STATIC
> > BRANCH/CALL subsystem too? That is, add a [RUST] entry below the
> > current one, list you and me as M:, and anyone else in the main entry
> > as R:, and patches land through the same tree as where they would have
> > landed if they were a C patch.
> >
> > I'm open to whichever setup you prefer, but I think it'd be nice to
> > get these files into MAINTAINERS somewhere.
>
> Yeah, I suppose that'll work. That [RUST] entry seems to be the
> predominant style in MAINTAINERS.
>
> My only concern is that most of the [RUST] entries don't actually
> include the F entries for the !rust part, which means that if the C bits
> change the Rust people aren't notified.
>
> So I would suggest having all F duplicated from the main entry and then
> add the rust files. Or, like we did with ATOMIC, just add you as M to
> the main entry, along with a few rust files.

Ok, that makes sense to me as well. Let's do that. Sending v2 now ...

> Some day I might actually learn enough to not see it as line noise :/
>
> See 2387fb2a9b84 ("rust: sync: Add basic atomic operation mapping framewo=
rk")
>
