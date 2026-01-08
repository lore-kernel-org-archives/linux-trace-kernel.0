Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B30C42CD49
	for <linux-trace-kernel@vger.kernel.org>; Thu,  8 Jan 2026 09:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767864027; cv=none; b=fPtp1THB1LQpDGciXwUbNtKV0ADEZfWqi9pUCZee4GBtoJXUOuYuqb1XuuVhbIRH9R2JBVVRHPI4jgQ8YEp2F8bTPMIIvx1jrLJ7gatejZZTpN+WS2IvECXRuE1osF8KSBU/8Fby/23yYwN0v1UDvng3g0iyB4c4GJDAtsJ96Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767864027; c=relaxed/simple;
	bh=FbosATJlJMrrAZDjJg3pfl9wL+jyPVTQR6KUMBPIvpk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rYvkJEWl6HP1mKATfgld+Ex5FymG2O+P74xgHt5ZaBzw7TydzMiS4sfDXbuXp+r2iny6PirJTB9cMTUhXNALTkRVqC7kvZWd78/QxsYc04zpcmqpfHTImMm35DMsiEoDbeC3Nhvu1uu8N5o0bCGeMCocRs7rR3nCxDU5hIkCHZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S31CHabP; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S31CHabP"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-431048c4068so997733f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 08 Jan 2026 01:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767864019; x=1768468819; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ibNZDSomea2Kq8JU1LII4jRZLAkzC6KvW4qElfknzVM=;
        b=S31CHabPHS7Y2m2keYKSv0z0Xp8gQjTNMEl9Rm85dEtWKWHQXgaSssoHKMSL/wzBmE
         H/FunC3+MGwPPMv4XfkPcJX9+Xxv+UMg0osNF5gxlKpBmWMErgDKI8Ol2wHcoDHgb9qZ
         QhstiggVQWhkAvZbtClCEWO15HdNncihsWjwZYC50ArOwB4vuXFHKWLRw6+SMJYdLv27
         I1Hr2uobcr0R3KHGW7SoiZfwEu3ym279PYal4FGZ1Aitn1p4ekg89VelFuXZ4SEzzySJ
         nrvBrzjDrqhLeMoigBslwON0hdTzPNIWF6bsJjLvoLv8+AAtd4XKxxdHE/EdqVgfdRX7
         kMLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767864019; x=1768468819;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ibNZDSomea2Kq8JU1LII4jRZLAkzC6KvW4qElfknzVM=;
        b=jAi70w+GebZKgjqr21md8F1WPMdI0gtuNlPLCZ9ycVi+XKj24hv6bu1PJO4xG7+d5f
         ghglzFY5paOeiI6Z4oibBneuRD0nZoaV/oSwMaBciULC/MnfWjGKnk2DkpBDgmY+ZKbo
         F6pWtfUTdxI59D0k4TdBecpqLKnD2AdM+HZofN8Q08mp+XoORnRGhyq0SrmoCLRE7D07
         +fyXVTgr7YuJmbq+YLYVu8AVeZvxFWlaXt2fKV5tvnGPV/yiwuZtzuHfLpaAbuLcVwfu
         WUdihKUQ/nXzalk3B89mh5V2pJlIFGHKBpZ7ZTmOVgbWpDw1H4/INI9FOZH5Ps/LSmY6
         bszw==
X-Forwarded-Encrypted: i=1; AJvYcCV7iWDTBNzowpsrN8Bo/hJj0BZGm3P89C6eWE6zUy9NzyV4Y5RqKcWy0LvlKkRKrS5VIUoTmc5MpQNY06uFnxrtx1A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvbSmbTmwngFysoirP7CTz8ne2KKhkNZrU9xdDV1cA4nit8b3y
	g6TqV19gEUgDWqDifmUk/+UXSF7IoHVc983Sb7WRRS2zwMnMeKmg3Gqt
X-Gm-Gg: AY/fxX4qEQgvVYWVtvg7btVOiXBQWnN7YzSFlzWW88lnnP0iIuvTqAB0khM/8Ax3kxz
	X+nK5h7SAorWYXHFKriLfcKoW0uKWCZUdbI4wopQitJ0/JHpdZP9TAUQrueUwaCuFNWQm/0gxQm
	cWHOrayz9JgGpguKqgzqhkx894zkGqsfCw//YPteB7DM4ciqhsWsCTP2hsYgeSWerPYK8WYxFR4
	r3eYy0Fwl4/ubWkau8+ft6qZMltjeVDJ0+w8NIVkMI5/nI18m7vSQ/8rON3AV+EgR0BeeCkLXSi
	YXdZPUDyne/QarrDfbjUKSEudDfml66jnBeu0QM4lOQ330D0he0c/yqHWnxKwKhKHOca2cFqpyE
	NoTiCqQxTnzBuOq8FQ3cNOBgstVm2QSy6V7z/hvqGZhlA9Cv9QApfeu7ivC3osw6Nk2SThEeSrG
	KPaRQaMuGLaA==
X-Google-Smtp-Source: AGHT+IEeTGSbCnce2NYPoDErH8a4YSRN2uHCz3Hrwe8riLU2jJcFM/suSjmul2LgFsXBuT7yKXIMaQ==
X-Received: by 2002:a05:6000:430e:b0:432:b953:b02b with SMTP id ffacd0b85a97d-432bcfd3d7cmr12200245f8f.16.1767864018804;
        Thu, 08 Jan 2026 01:20:18 -0800 (PST)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0e180csm14982921f8f.10.2026.01.08.01.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 01:20:18 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 8 Jan 2026 10:20:16 +0100
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Will Deacon <will@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
	Mahe Tardy <mahe.tardy@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, x86@kernel.org,
	Yonghong Song <yhs@fb.com>, Song Liu <songliubraving@fb.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH bpf-next 1/2] arm64/ftrace,bpf: Fix partial regs after
 bpf_prog_run
Message-ID: <aV920FGl9-1A1jW7@krava>
References: <20260107093256.54616-1-jolsa@kernel.org>
 <aV5qpZwxgVRu2Q8w@willie-the-truck>
 <20260107110814.1dfc9ec0@gandalf.local.home>
 <aV6PZKx9g_hCz4ZW@willie-the-truck>
 <20260107121432.73fccf84@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260107121432.73fccf84@gandalf.local.home>

On Wed, Jan 07, 2026 at 12:14:32PM -0500, Steven Rostedt wrote:
> On Wed, 7 Jan 2026 16:52:52 +0000
> Will Deacon <will@kernel.org> wrote:
> 
> > diff --git a/include/linux/ftrace_regs.h b/include/linux/ftrace_regs.h
> > index 15627ceea9bc..3ebd8cdac7c6 100644
> > --- a/include/linux/ftrace_regs.h
> > +++ b/include/linux/ftrace_regs.h
> > @@ -33,6 +33,15 @@ struct ftrace_regs;
> >  #define ftrace_regs_get_frame_pointer(fregs) \
> >         frame_pointer(&arch_ftrace_regs(fregs)->regs)
> >  
> > +#else
> > +
> > +static __always_inline void
> > +ftrace_partial_regs_update(const struct ftrace_regs *fregs, struct pt_regs *regs)
> > +{
> > +       ftrace_regs_set_instruction_pointer(fregs, instruction_pointer(regs));
> > +       ftrace_regs_set_return_value(fregs, regs_return_value(regs));
> > +}
> > +
> >  #endif /* HAVE_ARCH_FTRACE_REGS */
> >  
> >  /* This can be overridden by the architectures */
> 
> Hmm, maybe that would work. Of course you forgot to add the helper for the
> !HAVE_ARCH_FTRACE_REGS case ;-)

seems to work, will send new version with that

thanks,
jirka


---
diff --git a/include/linux/ftrace_regs.h b/include/linux/ftrace_regs.h
index 15627ceea9bc..4b053eb4c9d5 100644
--- a/include/linux/ftrace_regs.h
+++ b/include/linux/ftrace_regs.h
@@ -33,6 +33,18 @@ struct ftrace_regs;
 #define ftrace_regs_get_frame_pointer(fregs) \
 	frame_pointer(&arch_ftrace_regs(fregs)->regs)
 
+static __always_inline void
+ftrace_partial_regs_update(const struct ftrace_regs *fregs, struct pt_regs *regs) { }
+
+#else
+
+static __always_inline void
+ftrace_partial_regs_update(const struct ftrace_regs *fregs, struct pt_regs *regs)
+{
+	ftrace_regs_set_instruction_pointer(fregs, instruction_pointer(regs));
+	ftrace_regs_set_return_value(fregs, regs_return_value(regs));
+}
+
 #endif /* HAVE_ARCH_FTRACE_REGS */
 
 /* This can be overridden by the architectures */
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 6e076485bf70..3a17f79b20c2 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2564,6 +2564,7 @@ kprobe_multi_link_prog_run(struct bpf_kprobe_multi_link *link,
 	old_run_ctx = bpf_set_run_ctx(&run_ctx.session_ctx.run_ctx);
 	err = bpf_prog_run(link->link.prog, regs);
 	bpf_reset_run_ctx(old_run_ctx);
+	ftrace_partial_regs_update(fregs, bpf_kprobe_multi_pt_regs_ptr());
 	rcu_read_unlock();
 
  out:
