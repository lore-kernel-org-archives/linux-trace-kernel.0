Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2731E135A4B;
	Thu, 13 Jun 2024 06:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718259122; cv=none; b=RvgMbT9V5qZglIEeXXGvHRZZgOCXt5Xpmq9hV8xl8+UeywhrXYEc2L319vNKRoScQENWnXOXZf8pwzaCCeyaWCWz1+adeYk0w1g39n3kkfefPH2pbQa4jQc+mJRwHm3OIe2O0tADqEB2Z0POm89EiJmjiBdmbPxdnE+GvJd3v6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718259122; c=relaxed/simple;
	bh=2tfIxnfDqiV8m2eUOgIRXcgva0U3ORhh129cB7f/07Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FMYfvKI4y3cOKWZDwUxgYCwqb8dO/QbtXDLLrkQgvBZ2ngtgIhNOWV2414flntPgsmPteZDEt/StyUzPGeeRDugH+dYlF5voevpcStLyCVvYzRFJNm/WJTWz+HUPyPlISqL0IayIalgRyrtQrKhEaIaQK7LAzjVBDumaOYmkMZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aLMc62CM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aLMc62CM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B62D6C4AF5F;
	Thu, 13 Jun 2024 06:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718259121;
	bh=2tfIxnfDqiV8m2eUOgIRXcgva0U3ORhh129cB7f/07Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=aLMc62CMcYbhlI0BxA1bmCKIFpC7d6uUNzAaYgoMqzg59/gCWcohnthbnkHm3+PuL
	 zVtwTkOMcMOvC7TikDQsC/2VSZMAFRluA1HBDadue43vDev0PzLlvojOLhhkNE1YCg
	 ex0oFd7VBGibaU6QGkqbCRvkNW6/ksv7xrRJ5lEsQ83WEsxJKkJWb4mTGWG3N/K9QA
	 Javtf6isZCNRW3fAseXH79Ym7TvCN4tEredwd9vy0ftIPHqUwvY2N3dddOOUW95Rbv
	 XoB1GELyN67C3bG8sUp7ZHz7I499XFVQKJJ4mMRS5J7xQEgFSJU9bmkPkIsS8G4zhH
	 lkCItH0cnFioQ==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52c7f7fdd24so937540e87.1;
        Wed, 12 Jun 2024 23:12:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUDNxy4lrQpweYxTY4V9BSZiB+J6aTiZkzC1kadm70Vx4fg4X819O/pobF4Cg+YF6jCTspFq/dK0FZckVI2MEv7N1rVed0XwAVh74r3xT5HYk4rLz5lMnfF6kpHPrxaFMD7Zr/yWMVGwh86KqehkC2rWenxnXSdRMT+nao/Wxd3B56EZBMrsMLB4ThezY2jg951
X-Gm-Message-State: AOJu0Yx1KIHlneXm5/rZ59Bjvbxv8N91tiosXzCM1Gdl7pC5cIbQQkaW
	nIIYBIu+XVidJsqnVHOi7KvZGe0Hde+XWndf5Pb2nNHJ6ATAr9MdG1E0VpvPZoeiTR+CFUiXNzn
	DOV61wV5Ge0T+vE+pGH8KKzP7xVc=
X-Google-Smtp-Source: AGHT+IFdLbYZojyhqvDEXOP8w6OnQtiDQDSpYwdN44bj4F4g15wPRxlf8c6AOb6GWfv8yK5ap3XFShBJ/euTC9+lXSo=
X-Received: by 2002:ac2:4a82:0:b0:52b:cb05:ed46 with SMTP id
 2adb3069b0e04-52c9a3c79a1mr2099464e87.21.1718259119855; Wed, 12 Jun 2024
 23:11:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240611144911.327227285@goodmis.org> <20240611144949.703297941@goodmis.org>
 <202406121145.8860502D7@keescook> <20240612145228.5bf426e0@rorschach.local.home>
 <ZmqLejL1mblOikLp@kernel.org>
In-Reply-To: <ZmqLejL1mblOikLp@kernel.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 13 Jun 2024 08:11:48 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHLSROujjc_OifzVmuAd7BpA+b4D2JrPGLJJYj2au7SfQ@mail.gmail.com>
Message-ID: <CAMj1kXHLSROujjc_OifzVmuAd7BpA+b4D2JrPGLJJYj2au7SfQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] pstore/ramoops: Add ramoops.mem_name= command line option
To: Mike Rapoport <rppt@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Tony Luck <tony.luck@intel.com>, 
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>, linux-hardening@vger.kernel.org, 
	Guenter Roeck <linux@roeck-us.net>, Ross Zwisler <zwisler@google.com>, wklin@google.com, 
	Vineeth Remanan Pillai <vineeth@bitbyteword.org>, Joel Fernandes <joel@joelfernandes.org>, 
	Suleiman Souhlal <suleiman@google.com>, Linus Torvalds <torvalds@linuxfoundation.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 13 Jun 2024 at 08:04, Mike Rapoport <rppt@kernel.org> wrote:
>
> On Wed, Jun 12, 2024 at 02:52:28PM -0400, Steven Rostedt wrote:
> > On Wed, 12 Jun 2024 11:45:57 -0700
> > Kees Cook <kees@kernel.org> wrote:
> >
> > > On Tue, Jun 11, 2024 at 10:49:13AM -0400, Steven Rostedt wrote:
> > > > From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> > > >
> > > > Add a method to find a region specified by reserve_mem=nn:align:name for
> > > > ramoops. Adding a kernel command line parameter:
> > > >
> > > >   reserve_mem=12M:4096:oops ramoops.mem_name=oops
> > > >
> > > > Will use the size and location defined by the memmap parameter where it
> > > > finds the memory and labels it "oops". The "oops" in the ramoops option
> > > > is used to search for it.
> > > >
> > > > This allows for arbitrary RAM to be used for ramoops if it is known that
> > > > the memory is not cleared on kernel crashes or soft reboots.
> > > >
> > > > Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> > >
> > > Acked-by: Kees Cook <kees@kernel.org>
> > >
> > > Let me know if this should go via the pstore tree, if you'd rather carry
> > > it?
> > >
> >
> > I'm going to send out another version to cover some more comments that
> > were made, and perhaps it's best if Mike Rapoport takes it through his
> > tree.
>
> I've added one more comment to v5, with that fixed I can take this.
>

So how is this supposed to work wrt to the rigid 'no user visible
regressions' rule, given that this whole thing is a best effort thing
to begin with. This needs at least a huge disclaimer that this rule
does not apply, and if this works today, there is no guarantee that it
will keep working on newer kernels. Otherwise, you will be making the
job of the people who work on the boot code significantly more
difficult. And even then, I wonder whether Linus and #regzcop are
going to honour such a disclaimer.

So this belongs downstream, unless some guarantees can be provided
that this functionality is exempt from the usual regression policies.
