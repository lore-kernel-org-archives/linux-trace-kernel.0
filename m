Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1154367B72
	for <linux-trace-kernel@vger.kernel.org>; Tue, 23 Jun 2026 14:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782223670; cv=pass; b=tlVs+JdGxAQcdIRNc0zHwqyXm1kWfInUfSqWHsTdSJ+lGHY5c71OiJgKUYZy2j6zqKafKQ6+x9bRkLDJ7yHIqoKZwBqJygehRnjopSW7ORtHTj4BhyUnH8vY5iXfvd098/c+LuWoqDKwZ6wXLg9Tpi8efRgtmnvDT1QlDpTa/y8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782223670; c=relaxed/simple;
	bh=G67U1RwSbF+mPt7N0lSoGZbUv0SpaaN+gXs+8BGSMz4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f7f6sNBpTWpg8Gvux1s5qeaPYeF3KIxHBifC6pRl6dZsQboxE0UzoTWujmZx2/RXCVtt3fqkuEnSGAiFaePAbHz3ONtKklohnvC8Rsexor1dLK7gp+qAq9UQGz9qM2WLAWJiiEqNQzLwu5YWXukqmIy/E94txjwl5jJ1GGwWzOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G9LNQ4iK; arc=pass smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G9LNQ4iK"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-4864ebb6268so3185132b6e.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 23 Jun 2026 07:07:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782223669; cv=none;
        d=google.com; s=arc-20240605;
        b=EZrCMjJ6VJ1ur0gzjP1X4c9dF4xNqrLsJZ+XGKBdLDcYwBFJghork6r9NdKb3HKBKv
         mobNtaf8uA87vY8j3NmfBzjPWjV7edpwqdH/8o0nitPPdE9gBYdVTK6TqvKKr0z7383x
         +CqPKAzDvJfTsC3tHaQt8zUwM5Cv4nEyANc4AoqfPAz9sBQ5g8wiYB9BelRdjXEZJcKc
         pCIZmP0ZX0MrvyAFzgehJXVQK0QApCjM2DH4/9wuRGboTkJVFalsINXbSqwQEHiMR2PB
         Zo/tYs1VMue54AMqq4FGbwgzse+hOFqVIzmekQk2KidpLB1YonvpbhWuStBtilkAQsY/
         Nc/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=G67U1RwSbF+mPt7N0lSoGZbUv0SpaaN+gXs+8BGSMz4=;
        fh=zIXjqrdW++K2mtBwRNkkjpQv5eRd6AmwE+U92ZGrVtc=;
        b=SlNableSfSntAoOgIf6pE8bBVzWfVgNWQjFe0k8mQRglzr5gY+3Kd0LdLGFdc4imBK
         LdBG1vPTlW5EZU8SUJPtY3opOWsnGI/NCyx7A6QgHQ3jUvrI9+rNMVma+EL4V33DsUTd
         gTP7eWgjF5yr5QKHmTZW9+TDubox7vEeF7D5RbAqHqZykgp31ubu3aWB3HTaaxH27P9C
         IPY8oTLs8pJrJqPgvd8Wk8hJg4+yHUmfPcTIOlUMo6bVyd/Cj/ChOuq5v/PrU2sK0c65
         7udkHJGqVxnvw/hDwrxOIRZAl98wKvdbzg8GOKihdVsm6Epp2qGliHgm08Y0D8D5FlWu
         Ff0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782223669; x=1782828469; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G67U1RwSbF+mPt7N0lSoGZbUv0SpaaN+gXs+8BGSMz4=;
        b=G9LNQ4iKOngGapFwTTcCg9vD1z8ruMZzeCYxO9kVKERYXNM9gOTaQhZtCEkgT7fEYO
         vmT2sUd50U1PPmG8aBEHBx1wndUsF7JZsK9aU7Ja6NXauG6doLgs/iDShHO3+w+/s2+S
         v5GMLmXDv+/B1x4cBOwkaqrm5qNiaKA0n82JCVUDcz7ZgBpnm0PTgsuJtRTOHnu96vOH
         PyBMtqBQHq6mPVOoPORzr8+Bjq1bEI1eK8A8wHT+9QDwYkPlgzdlT+wT5cJwdGcpDVAM
         XBY+lL4oDt/gs+8EfnbSaPI3KqTvTUU1a07yKkmu1smGE4KnNjfD6YqczZ6qQ7iPhiGF
         smxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782223669; x=1782828469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G67U1RwSbF+mPt7N0lSoGZbUv0SpaaN+gXs+8BGSMz4=;
        b=KT9NLBwoaz0dzIS1Lv+R6bIdzbCNC4qqjzmoCix6HUMXmy3kgiBm6EC4Gv6iwxN9qD
         XU0zvGxZo7Zf7sChwdg/ihKg1Awq1IfMixg/Qllq2kscwVEoPjWiCdSmWYcmLJ3q9G2b
         HsLTJd7vY1eVgyccXAODFrXUbhTOo4K8ULhoTAHmjiL6YCNM9fI6A3b5oRY4izIfT+si
         pRzvROYPxxVM56UoQ5g2OPsDre1U7vDxJR4FCX567RZCTyx6hqBPc63bSI15AQusVFlu
         dQjGzaLyFRtMsto4vyMgGCgUdpPw/ZPIErto6xye9odbHFyijHdm+Rx596VonDdob3sK
         /RvA==
X-Forwarded-Encrypted: i=1; AFNElJ//UTS6O2WBYRh+2yNRxrUVyUPCxnoUqG1FZWwQdUP6qYVGJe2oXye1BAVh2hIsZES7gtL3ke4GIu+3H/r6TEQ0AI0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn8VfLNPdHF3SfV7RGl6nXa+zXiAPJrQ5xgzZ6Zz9UBbIv68bo
	Xheg5NFQOjoZFuAlQnVHfoiSz9h+TccYInkxWWv4gVadUAm7xCpmTAWDgeawjYeTosBXry2g3UB
	a1jN7CjclRM6nwLVokoD/f1gtXoFWbm0=
X-Gm-Gg: AfdE7cljhbBzw/mAkGcZIF/oDkNWLCAegY0HetcSiqWtZe6I3K6DVJOlW5L3ceUy8VI
	F6I/P7udQkzVrvIhfaLfDpP9jo7ypn9OaeAoc5R6h89Lo49LcFCzroRGQbJ5tbdD//zEnMdPJ09
	aGcsNXjI2ha5oDElK6zSkXe1GQbn2fOJbAXK5vYXoQYH9/e375VLc7uVYxP7j5FJaKatBTF70eW
	yCvxl/10N+Upqh+qll0dLDT8QgXre3fDsey8QkBmSi35dLELc6NArYJheAtmd9PGfQstjbu8yPF
	n6XyeP9491Bns3IdR7u4IXbgTwdSEo3Yw8/Mw6g=
X-Received: by 2002:a05:6808:1b06:b0:479:eb19:6e66 with SMTP id
 5614622812f47-48f29eb5fcamr2080626b6e.38.1782223668359; Tue, 23 Jun 2026
 07:07:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260622183109.1137245-1-dwindsor@gmail.com> <20260623084327.GU48970@noisy.programming.kicks-ass.net>
In-Reply-To: <20260623084327.GU48970@noisy.programming.kicks-ass.net>
From: David Windsor <dwindsor@gmail.com>
Date: Tue, 23 Jun 2026 10:07:36 -0400
X-Gm-Features: AVVi8Ce4azXvS8RMtuB5ZswOmmVhWcuumJwHulSPO1SroME3hfaP0NykDEwpcDg
Message-ID: <CAEXv5_g8NZ+dBxH_towkEzJAH1emabsmmnCiX2gzikOqoAso7Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] x86/uprobes: Keep shadow stack in sync for emulated CALLs
To: Peter Zijlstra <peterz@infradead.org>
Cc: mhiramat@kernel.org, oleg@redhat.com, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, shuah@kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026 at 4:43=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Mon, Jun 22, 2026 at 02:31:08PM -0400, David Windsor wrote:
> > Uprobe CALL emulation updates the normal user stack, but not the CET us=
er
> > shadow stack. The subsequent RET then sees a stale shadow stack entry a=
nd
> > raises #CP.
> >
> > Update the relative CALL emulation and XOL CALL fixup paths to keep the
> > shadow stack in sync.
> >
> > Fixes: 488af8ea7131 ("x86/shstk: Wire in shadow stack interface")
>
> I can confirm this patch fixes the included test case, so yay for that.
>
> However, should this not be:
>
> Fixes: 1713b63a07a2 ("x86/shstk: Make return uprobe work with shadow stac=
k")
>
> ?
>

Hmm, this commit appears to only be concerned with the uretprobe case?
