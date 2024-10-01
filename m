Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D5119C549
	for <linux-trace-kernel@vger.kernel.org>; Tue,  1 Oct 2024 12:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727786060; cv=none; b=I3FnuL5Gk86DkeMSjYL8JL/u27UGPFJ1gtBkn7ufMrSbmHO6xifbMCMb5daofBV+n0EAWCzDbzLEpjkj+Pwl+G7DMinoKr4Pxs878QLk2oKpiS1Ac6xuaEotzET0XDXXSghLmEMICb0+o0ktbnrHvOHnslBGItznYDFWgtny6HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727786060; c=relaxed/simple;
	bh=r1QYbrSarLawJVBc0SzQ/bSKN6PJytzbt5M1yR0rW8w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E98EgsvPpTYqLEGbDHWmnCIqoSZ/T0lzhvvGVa6HjNOET0NEpub5R72dVfImzqL7PGc6F307gDW774FAO+Do/VG9VVyouij8fdPdO/t7yaMEqmkb44HMScgKdkNyYW2R79RD5v62n+S4yiZ0Ul1+e6HwcRtveNaAwTNJQ5jVG10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nnr/CrNQ; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nnr/CrNQ"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6dde476d3dfso43275777b3.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 01 Oct 2024 05:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727786058; x=1728390858; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dOITxQ4P5R91uHPZF0yYPyjygGVu8De0NWHH4aCLRLg=;
        b=nnr/CrNQH8+Y6l/TSjoIzc+b81PNtIN6ZMSmnYc5kFf8CSdA7gXQuplqsB3JCGVJu7
         vDQGRyOubg5tRZqN5StmJu/7OISQ0ZQ+PavU5ezFqJ0RDCKgBotEVziCxvddv5xXJVNA
         8gcXhOKPILjOfGZDmr06P6JsHB+qUQGGNo6V3PDsegBmk7k0QfNKy8Ushf/1iGTHRyoT
         djvGVqEbC32lZgOiOsjv2uZXS2diqqP9QCBFwQJN5MRdTt1TQ5VecP4nEE5IsOznxasT
         dfNtDGcb+K0FHbC7YN4PjVHEaKXNukpS5OnbP6jUdDC9i0uQaS3D9/BRWV4o7Bukj/gL
         FIng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727786058; x=1728390858;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dOITxQ4P5R91uHPZF0yYPyjygGVu8De0NWHH4aCLRLg=;
        b=mU/zkprEalqqcrC/Vy5etAbu4z0cL/7qcmRFbMqiq3YlK595AosCpLKrkJzdNbWv8r
         hH242BQZav3nBAJ0c0ySg6Se/pFl1pGxbdK9thZ1voRqmVf/6poXmxujGcVvLbbpv5oD
         qB9ZDfl0E8HJPE21vfiua56Q5LP6to3JmHR8utAu4MlXvgbw1uvBEB9Hx/FbqJ0ZCXaJ
         Q3zvrkkBh1ptThjFVpZwnX6sgRqsvOAaPOgiGW7Y51y9s2GGAm6T2R91AAQf/jji6Wox
         J1y12avIXY/BOGOaJ791TBmv73TH0N0xC6OXUQgNL592WV+C/XlAE0cWpNs9HyF5Gxe9
         AXgg==
X-Gm-Message-State: AOJu0YxVDil9Gt8um7zcNjnVq40SNfmd/t7x/hU5chsVmXAhSrf4Y9zL
	ThCue9xkPT2CYRAQHyI1ROg9i1PnKtBuxQACEgI0moZ6TczGwW7cgMLiGpAkmJ9zgH00TknHRzg
	EvTMBj9tL8MS0ED+CeCguZm0uWkmwwPNf
X-Google-Smtp-Source: AGHT+IEHFHgWluc9EF+vFwXGZ+wSquvqeYWgRtUjg1TSGL9sLVmi/ve59mkDF1ms33K/hStCUyeY+KyFVs9+mrzHuoQ=
X-Received: by 2002:a05:690c:6910:b0:6e0:763:1ffa with SMTP id
 00721157ae682-6e2475d12afmr137351957b3.34.1727786057868; Tue, 01 Oct 2024
 05:34:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALfBBTtqho0iEV5rpG=2uead0MPZQoRiins8yeXwY-WfZnR08Q@mail.gmail.com>
 <20240930112213.4dc0916e@gandalf.local.home>
In-Reply-To: <20240930112213.4dc0916e@gandalf.local.home>
From: Maverickk 78 <maverickk1778@gmail.com>
Date: Tue, 1 Oct 2024 18:04:07 +0530
Message-ID: <CALfBBTs1PsB3rGDHNa72yp-JGHmNSjZHAX0KXm5G=0Y-5kcCCQ@mail.gmail.com>
Subject: Re: ftrace not tracing pciehp probe
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Thanks Steven for the Information.

I am surprised that even probe functions are inlined which are invoked
if there is a match of entry in the pci_id_table of that module.

I will try noinline.

On Mon, 30 Sept 2024 at 20:51, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Mon, 30 Sep 2024 18:16:01 +0530
> Maverickk 78 <maverickk1778@gmail.com> wrote:
>
> > Hello,
> >
> > I enabled ftrace and set a filter on the command line as *pcie*, I
> > dont see some of the pciehp(eg: pciehp_probe from pciehp_core.c)
> > module function calls in ftrace, It does trace pciehp_isr but nothing
> > else.
> >
> > My command line is "ftrace=function_graph ftrace_graph_filter=*pcie*
> > ", is there any restriction on tracing static function calls?
>
> Only if the compiler inlines them.
>
> Ftrace only traces true function calls. That is, locations that something
> performs a jump to via the call instruction for x86, or a branch-and-link
> for several other architectures. The function has a prologue where gcc or
> clang will insert code that will allow ftrace to attach to it.
>
> If the compiler decides to inline the function, it will no longer be
> visible to ftrace as the compiler will not add the necessary logic to allow
> ftrace to hook to it. In the binary, the function simply "disappears" and
> the content of that function is injected directly into the calling function.
>
> If you do not see the function you want listed in:
>
>   /sys/kernel/tracing/available_filter_functions
>
> Then it likely was inlined by the compiler. If you don't want the compiler
> to inline your function, simply add "noinline" to that function:
>
> static noinline int foo(void)
> {
> }
>
> And that should tell gcc not to inline it.
>
> -- Steve
>
> >
> > # cat /proc/cmdline
> > BOOT_IMAGE=/boot/vmlinuz-6.11.0+
> > root=UUID=f563804b-1b93-4921-90e1-4114c8111e8f ro
> > ftrace=function_graph ftrace_graph_filter=*pcie* pciehp.pciehp_force=1
> > pciehp.pciehp_debug=1 pcie_ports=native quite splash
> > crashkernel=512M-:192M vt.handoff=7
> >
> >
> > Raghu
>
