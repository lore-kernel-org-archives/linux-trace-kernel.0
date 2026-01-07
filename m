Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133DF27281E
	for <linux-trace-kernel@vger.kernel.org>; Wed,  7 Jan 2026 08:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767774186; cv=none; b=rOxNwOcuQnvf/rC96C+fdqdo4KSxGG4r453p1AEUofqYfnWHmXxLu3GFP/MSAmmbWrtUux5Jbf9+i6nqoAyCaki+BeDyqNdiL/GTeFqHANURPdRztVQdMmpOoHqLnCIBC48uxcpDZYrX8aEILjqg6nUx2gWCAOXbgHDR5AVbJCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767774186; c=relaxed/simple;
	bh=6Y8LJF/IT28MILsR6fkqJKlCJIu/OktP8AH8ej/hsy4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kddzdl3D32IV/C0vaJuLS90zxm6VNSsTFbmeQ7czlGyyVt6e6I7fEvgTPttWfQ63H6NMprU4afVCNKH1fODfO4+Z1HRUpqtjUCNz/629k4C6dwxaf4KWHlt9DecCCj/p68KNrN48h6QGPrDiLrsfu8C8KSvX/IPzQE7l4ljIacM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IZaa/Afk; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IZaa/Afk"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-42e2ba54a6fso659858f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 07 Jan 2026 00:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767774183; x=1768378983; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=df7REDb65mq75PTRlD31qjVxgAgGX1+69KUNZyHym1g=;
        b=IZaa/AfkwErFItrcuMmDMhHZ2sLBXvBtMbH9kbrADL5zbgaf0wfy6Jjw46dQ+w+siL
         B7G+A7B+skytcVLOP8ijb9Q4gWH53XtDi0j4OPezrMH878ulAxBMjoam8fH5BPEktHD+
         sZLKV/H+Gg8y/EHzx7DoqXHD2dmwAbyn3ZSL2qyYWOZWG49kOo+0QrkiM4LRHN7D/GSp
         yEIklJWIqCA+vqpZXWO8gZKRR7TgO9cMyZHQJCOX0Ct/p+ZnyqIRiWX0YpUv+HmCJl1H
         hAZ7FfnaujtjYvNy/z2piLqKjLKYqqPNIZaZuBcjV171hNWew242Lvw57oXTDXFnuyUW
         40Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767774183; x=1768378983;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=df7REDb65mq75PTRlD31qjVxgAgGX1+69KUNZyHym1g=;
        b=raKL+7wqFwAjzqeURBJUaGCf03kLpdNQZ8SQhrUPIU3ZJ7/K0tV+pbEGVLGnB2u6qj
         TSX1j+SyzYyqhMCp6yoPiRE++NWqkYMU2+zOkAof5kVyRP9s8s0XZ2BQBaZOcEZmcGAo
         g9n4N8a6esjhSNdvOJttJwNwcQamlU0HzmtBHOqvGFs5duEbJwDoj3Zu3HP1XIx2uE+g
         BnYZ5WZ6V8ORMq0O2H8I7UPVnS+3yoZjW7p3xYo1jIHSEfYwoxyXIfrA3utAPpub45iN
         JbAKDJiNJPAacwprBKMsyMUovpa375L/dtp493cz+2/967JhPRcYTC5ri7+8pwdlFwlJ
         gJdQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5o5YA6lZhk5hy89UGNQC/oZEjNbF3uYc4baC7s5hiZIoXNFhQBHX/PdV/2Z+3pN4yIm+nOgGlvxZmXktKFTHmEig=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHV5cWfbQv9UN/egQJWDEiFOfYwvQc2nWzoRg3ZrMGahhO5ZTb
	IJoqNJvnnG/ejvh+VfavY5T6+oy7WW73ZDx9jJf9k1ss99OZWznWzj/m
X-Gm-Gg: AY/fxX75WtiqnASZDhpMvu6UbHLGdwlVlO5dxeYUCJIH6tTTaNDEaJLoUG3tFkY6NWq
	COtzlG/ovFKvzGXsj95ziQA/QdZWfbRMXmcNfJljOy7bvfUYKnu3wWxZOF9zWDoaU1cmGRux0ES
	bKMC5wiwDgWMBod+KgYvM7LXexcfsKTefdOvTdwvk8hzYnOu5XhO9ePMovCf2gJ82W0GqAEWZE8
	YENW9MkLkj1mvzA6AWa3iGaekPM9AVlHCGP26978NsOBm5DxUFjKDj3DZuPesDLJYj27nc1OxiO
	cfNDtMtEdQObcM3/kzQg2WDMtRHOKqb/1o/hNaqxQAqJjZ1FU34pGHExE/4XXNS473DzK5qoEn1
	R5yqEze9ZNK4xxSHPCbqkkGvQQI/NTk+fH4X9bPoY3liYQ7xf8MaNTDno1qOdWL+f473hT8CY5H
	w=
X-Google-Smtp-Source: AGHT+IEsMNPHr9nzJaTOIYJD2qWD9ZSw80mTVgJ/kjHVyTIrFlwwtX/5Na2psG+/SMS1rx4kKZSw8Q==
X-Received: by 2002:a05:6000:290b:b0:432:8651:4071 with SMTP id ffacd0b85a97d-432c3632942mr1904226f8f.18.1767774183031;
        Wed, 07 Jan 2026 00:23:03 -0800 (PST)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5ff319sm8920997f8f.43.2026.01.07.00.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 00:23:02 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 7 Jan 2026 09:23:01 +0100
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, x86@kernel.org,
	Yonghong Song <yhs@fb.com>, Song Liu <songliubraving@fb.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: Re: [BUG/RFC 1/2] arm64/ftrace,bpf: Fix partial regs after
 bpf_prog_run
Message-ID: <aV4X5Yx07LomQji4@krava>
References: <20251105125924.365205-1-jolsa@kernel.org>
 <aVfbqYsWdGXu4lh8@willie-the-truck>
 <20260104223415.0a31f423c861c0b651de966b@kernel.org>
 <20260105162220.6ba5129a@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260105162220.6ba5129a@gandalf.local.home>

On Mon, Jan 05, 2026 at 04:22:20PM -0500, Steven Rostedt wrote:
> On Sun, 4 Jan 2026 22:34:15 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > > This looks a bit grotty to me and presumably other architectures would
> > > need similar treatement. Wouldn't it be cleaner to reuse the existing
> > > API instead? For example, by calling ftrace_regs_set_instruction_pointer()
> > > and ftrace_regs_set_return_value() to update the relevant registers from
> > > the core code?  
> > 
> > I agreed with using the generic APIs. Also, ftrace_partial_regs_fix() is
> > not self-explained. Maybe ftrace_regs_set_by_regs()?
> 
> Or perhaps: ftrace_partial_regs_update() where you call it if you need to
> update the regs.
> 
> /*
>  * ftrace_partial_regs_update - update the original ftrace_regs from regs
>  * @fregs: The ftrace_regs to update from @regs
>  * @regs: The partial regs from ftrace_partial_regs() that was updated
>  *
>  * Some architectures have the partial regs living in the ftrace_regs
>  * structure, whereas other architectures need to make a different copy
>  * of the @regs. If a partial @regs is retrieved by ftrace_partial_regs() and
>  * if the code using @regs updates a field (like the instruction pointer or
>  * stack pointer) it may need to propagate that change to the original @fregs
>  * it retrieved the partial @regs from. Use this function to guarantee that
>  * update happens.
>  */
> static __always_inline void
> ftrace_partial_regs_update(const struct ftrace_regs *fregs, struct pt_regs *regs) {
> 	struct __arch_ftrace_regs *afregs = arch_ftrace_regs(fregs);
> 
> 	if (afregs->pc != regs->pc) {
> 		afregs->pc = regs->pc;
> 		afregs->regs[0] = regs->regs[0];
> 	}
> }
> 
> -- Steve

lgtm, the full change is below, I'll send new version of the patchset

thanks,
jirka


---
diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
index 1621c84f44b3..177c7bbf3b84 100644
--- a/arch/arm64/include/asm/ftrace.h
+++ b/arch/arm64/include/asm/ftrace.h
@@ -157,6 +157,30 @@ ftrace_partial_regs(const struct ftrace_regs *fregs, struct pt_regs *regs)
 	return regs;
 }
 
+/*
+ * ftrace_partial_regs_update - update the original ftrace_regs from regs
+ * @fregs: The ftrace_regs to update from @regs
+ * @regs: The partial regs from ftrace_partial_regs() that was updated
+ *
+ * Some architectures have the partial regs living in the ftrace_regs
+ * structure, whereas other architectures need to make a different copy
+ * of the @regs. If a partial @regs is retrieved by ftrace_partial_regs() and
+ * if the code using @regs updates a field (like the instruction pointer or
+ * stack pointer) it may need to propagate that change to the original @fregs
+ * it retrieved the partial @regs from. Use this function to guarantee that
+ * update happens.
+ */
+static __always_inline void
+ftrace_partial_regs_update(const struct ftrace_regs *fregs, struct pt_regs *regs)
+{
+	struct __arch_ftrace_regs *afregs = arch_ftrace_regs(fregs);
+
+	if (afregs->pc != regs->pc) {
+		afregs->pc = regs->pc;
+		afregs->regs[0] = regs->regs[0];
+	}
+}
+
 #define arch_ftrace_fill_perf_regs(fregs, _regs) do {		\
 		(_regs)->pc = arch_ftrace_regs(fregs)->pc;			\
 		(_regs)->regs[29] = arch_ftrace_regs(fregs)->fp;		\
diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 770f0dc993cc..ae22559b4099 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -213,6 +213,9 @@ ftrace_partial_regs(struct ftrace_regs *fregs, struct pt_regs *regs)
 	return regs;
 }
 
+static __always_inline void
+ftrace_partial_regs_update(struct ftrace_regs *fregs, struct pt_regs *regs) { }
+
 #endif /* !CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS || CONFIG_HAVE_FTRACE_REGS_HAVING_PT_REGS */
 
 #ifdef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
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
-- 
2.52.0

