Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FCA168482;
	Mon, 17 Jun 2024 16:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718643174; cv=none; b=ZY1Mj+AhtEZzM4tPvTV9pz07YEDa/2ZbXl67WCt+9m0hhCSArkKL5ICGpxXun4VdWkszQ8juOAg3YUIq9H9WrwfQuU8Q4JW7KEw4EVdNa8EjAVfKrbmOD6X/+BwNem6IwrOC663DRZsgjYYvFHKucpzQ8G5/dHV09wb0GR7/X04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718643174; c=relaxed/simple;
	bh=eSnhqAm2EceuPb7GR0p97myLZRdOU10MmclXVrykcQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WZo9EVDHZITJ+RSAEuj5sKmdQ0OSE7Z//FZE3J1cZBxcX1pAfy8N6n7/WyvA3HRuDicyc0iAtRGeDpReW8+LE4r8RInEKcQotJY1R1LPUJBPFFYMAwKAp6oRcwB7NCzZkd7joSNQL2yJkuue27Cfla9Mt0Us7fWjTn/J+dtdHHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ju/Nio2e; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ju/Nio2e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 423E1C2BD10;
	Mon, 17 Jun 2024 16:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718643174;
	bh=eSnhqAm2EceuPb7GR0p97myLZRdOU10MmclXVrykcQE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ju/Nio2ekUQo8b14RA4d5uLq/NEoJTbtrPRR3ycrp0W1iGLafnBwKjFA8qysevzDj
	 x7qKSGBs7oZOc8NK6gLzhdGOzqjFfVQz3Y40KI0j1uBCDQaT3mQ0/9/xd8ICwa2pwQ
	 LSofAHNWiaTakNfXTxUASBja6ZNvN7KkmhX6DC383eLoNUeYxbs4zITnUD+vUiO/72
	 y3b0j9RHGovIx9OvW5LKQO1DsJNAmkmS9n9dcDrZHoQS71AmEDLI7gVeHZR8rNMsEq
	 jMWLkftptNFsk8lWXU/2Xo7Tvp0wvcFXv3NKuJznlFkgIV5prc1Luup8xxx78FJ/i1
	 Qra2f1kMDF83g==
Date: Mon, 17 Jun 2024 09:52:51 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Andy Chiu <andy.chiu@sifive.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Zong Li <zong.li@sifive.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, llvm@lists.linux.dev,
	Evgenii Shatokhin <e.shatokhin@yadro.com>
Subject: Re: [PATCH 4/8] riscv: ftrace: align patchable functions to 4 Byte
 boundary
Message-ID: <20240617165251.GA550301@thelio-3990X>
References: <20240613-dev-andyc-dyn-ftrace-v4-v1-0-1a538e12c01e@sifive.com>
 <20240613-dev-andyc-dyn-ftrace-v4-v1-4-1a538e12c01e@sifive.com>
 <20240613190920.GB1272931@thelio-3990X>
 <CABgGipV_6sFx8TJNrHszGLk=V9X1PJAXuOmRDxnTHPrigqJL0A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABgGipV_6sFx8TJNrHszGLk=V9X1PJAXuOmRDxnTHPrigqJL0A@mail.gmail.com>

On Mon, Jun 17, 2024 at 10:38:55AM +0800, Andy Chiu wrote:
> On Fri, Jun 14, 2024 at 3:09 AM Nathan Chancellor <nathan@kernel.org> wrote:
> >
> > Hi Andy,
> >
> > On Thu, Jun 13, 2024 at 03:11:09PM +0800, Andy Chiu wrote:
> > > We are changing ftrace code patching in order to remove dependency from
> > > stop_machine() and enable kernel preemption. This requires us to align
> > > functions entry at a 4-B align address.
> > >
> > > However, -falign-functions on older versions of GCC alone was not strong
> > > enoungh to align all functions. In fact, cold functions are not aligned
> > > after turning on optimizations. We consider this is a bug in GCC and
> > > turn off guess-branch-probility as a workaround to align all functions.
> > >
> > > GCC bug id: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=88345
> > >
> > > The option -fmin-function-alignment is able to align all functions
> > > properly on newer versions of gcc. So, we add a cc-option to test if
> > > the toolchain supports it.
> > >
> > > Suggested-by: Evgenii Shatokhin <e.shatokhin@yadro.com>
> > > Signed-off-by: Andy Chiu <andy.chiu@sifive.com>
> > > ---
> > >  arch/riscv/Kconfig  | 1 +
> > >  arch/riscv/Makefile | 7 ++++++-
> > >  2 files changed, 7 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > > index b94176e25be1..80b8d48e1e46 100644
> > > --- a/arch/riscv/Kconfig
> > > +++ b/arch/riscv/Kconfig
> > > @@ -203,6 +203,7 @@ config CLANG_SUPPORTS_DYNAMIC_FTRACE
> > >  config GCC_SUPPORTS_DYNAMIC_FTRACE
> > >       def_bool CC_IS_GCC
> > >       depends on $(cc-option,-fpatchable-function-entry=8)
> > > +     depends on $(cc-option,-fmin-function-alignment=4) || !RISCV_ISA_C
> >
> > Please use CC_HAS_MIN_FUNCTION_ALIGNMENT (from arch/Kconfig), which
> > already checks for support for this option.
> 
> Thanks for the suggestion!
> 
> >
> > >  config HAVE_SHADOW_CALL_STACK
> > >       def_bool $(cc-option,-fsanitize=shadow-call-stack)
> > > diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> > > index 06de9d365088..74628ad8dcf8 100644
> > > --- a/arch/riscv/Makefile
> > > +++ b/arch/riscv/Makefile
> > > @@ -14,8 +14,13 @@ endif
> > >  ifeq ($(CONFIG_DYNAMIC_FTRACE),y)
> > >       LDFLAGS_vmlinux += --no-relax
> > >       KBUILD_CPPFLAGS += -DCC_USING_PATCHABLE_FUNCTION_ENTRY
> > > +ifeq ($(CONFIG_CC_IS_CLANG),y)
> >
> > Same here, please invert this and use
> >
> >   ifdef CONFIG_CC_HAS_MIN_FUNCTION_ALIGNMENT
> >
> > like the main Makefile does.
> 
> Hope this makes sense to you. I am going to add the following in riscv Kconig:
> 
> select FUNCTION_ALIGNMENT_4B if DYNAMIC_FTRACE && !RISCV_ISA_C
> 
> So we will not need any of these

Yes, that definitely makes sense, I forgot that this has been abstracted
away via the use of those alignment Kconfig symbols that can be selected
when needed. Much better than my suggestions, thanks!

> >
> > > +     cflags_ftrace_align := -falign-functions=4
> > > +else
> > > +     cflags_ftrace_align := -fmin-function-alignment=4
> > > +endif
> > >  ifeq ($(CONFIG_RISCV_ISA_C),y)
> > > -     CC_FLAGS_FTRACE := -fpatchable-function-entry=4
> > > +     CC_FLAGS_FTRACE := -fpatchable-function-entry=4 $(cflags_ftrace_align)
> > >  else
> > >       CC_FLAGS_FTRACE := -fpatchable-function-entry=2
> > >  endif
> > >
> > > --
> > > 2.43.0
> > >
> > >
> 
> Thanks,
> Andy
