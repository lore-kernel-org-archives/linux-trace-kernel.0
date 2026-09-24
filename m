Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1C7222597
	for <linux-trace-kernel@vger.kernel.org>; Thu, 24 Sep 2026 12:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790254738; cv=none; b=R+xVuhc9RCL0MAbqIHwMug3ILFVJWatGIP5kpIGQP+z87wK5mlubbopoV5UIxsjmD9VsTah1I/nM576/gECM/Gk4caYlWt+rBdHOKUDj1SePd3KcHiBQlx92/+o4e4QXS1AqveZJdiroSxPHyesYHno+itKT/KXtUfjhKWaLXvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790254738; c=relaxed/simple;
	bh=BJgGU9Fj+0i4oL+e+TBIeROIT9oFpqq3C0WFl9D1HFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cZf9eDKqove6FlwyOP6CF1Mgj2XRS5nzevfvZ/ZNJ4a1iZMdGi6RWbi4e5xuNpGY5pS0VD1eUQgDUEDEe2zVGJDHMMbgbwDMfbReYEfeTO2Z0vA1+U8lJKn4hSvXlvxPECbPiJfnpBI0tQEDjHAjMs9IiiMwrChYGqyrCtBYKXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TUynySO7; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TUynySO7"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49cc9f581c4so8117625e9.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 24 Sep 2026 05:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790254734; x=1790859534; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4ykK/QkBykPoiJ79rpm7Iuac0S65e0jYz1HTpICpqNE=;
        b=TUynySO7004spq6Et3zvBsNxVSKL64CN1AhlvtMS9gpLHycSnAKdiUxn/7maX0BF2A
         tx7QMuzYwHZdfYWobLJgZ+JY9kTH4JltjymUtfLLzB2nZ3GWUfBPahSZOGt+hvUESsY3
         DqNIQcb7SNJYBuVyThmmxT2P/6GjTouBWbw7lIu4KUXC/clcG2oxvKzq/1ei2X9xORky
         CcMPipH6d+sduawdcJT85Kw3dUkNSQLWl83/fY5ZTZ0d3x3Mraq0SSyQCKhqE/lRcGEq
         c1jf5Arh9w6yuVG/vJs3FhE/xFX/T+0E4iMoMKWiNkxZArhnum+HP0mrBwlVySO1u6eZ
         IOCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790254734; x=1790859534;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=4ykK/QkBykPoiJ79rpm7Iuac0S65e0jYz1HTpICpqNE=;
        b=G1ErwiYYISHNm+UM+JjeOD2LUAw1SUwAWr5n2ciPuFeHmRDyew4Wxfy9/dPqNgFDyS
         5SHbQGkgVQZ4IXdR1vJpZsqG0+uynrYrWYQXxvSaNnopR+s/MuRXenhzAb/WMg42741C
         VKxAuyort6DWlfikYbxmhqFSFA87+aRSgRvoGeuQopHPYBLnZ304SvvLID7q6fH1Skzu
         T14y13DYGSVlHIZgYW0ctYqXZftCA05mlkzrEv6m3ozjNq9DV+jSx+d50fYiHUJaHcm6
         z4Fc4/ctUGHf5mGhiLLtiQfr62F9U6W7bfFvfBOkLQswHbkAAoDJ+AQdDL86mJ5qOWMR
         ykvg==
X-Gm-Message-State: AFuF++mN0h3y0G8Lu4GmOOykLjaLepx3XsdVpLnB2ZJIQvdkZMKukC7S
	F7kKmi1dOSVt3r4C0rDkoHclXzvEm4T9X45Fjz3EyC34CcoTIc73CBd6puN9ZwLNxg==
X-Gm-Gg: AYBFou3n3kQe6jDPgkShsu2AGV2pSbLQkKk8RA1O+tfHApAZVZK+ktaCzzkqCQYAtWf
	l094TjVGUXlIMSVDXlHtA50f/BgGf6DB+YlCW2/P7vWa10X5ChDHhU5JUR4MTVrxvi32C2rKMLm
	gJCOs6JeNiMiohADNpaRrGZfC5pTMHdpNLvR8+1kcpcYItDYfk72aRdAdxoC4uGwXDpa8iCUKeN
	XDhO92kad/6goAvrTr+BGrya+gRHJfFFb5GazQ1KOuFCe+SPGj7eO7XCdRD/DfVEInXtP+8SfWZ
	qhkNtp1OVe5to35nP5WmmJHAcRvGrh0kDZVBFRC29ASCNYkbhZ58K1BWOBCcfzq0/Di0J/Il3xT
	sL5F8941ajoUvewjLyVqA02xKvujOSNISbPLvde7OFiHIqKms6OKmczd/iOKi8Es3gF1IBWJeA1
	PfdlUpK738Ng/wQuesYGYMskVZHECgrLfg3NNflPVLWn1Z8b7hMvk1+Wxz1xFPl3l2Tt00Q26Dy
	mMYs5HwvCzXGnqD1Qsm5p7NPui29BGCasBjZkg9o63b
X-Received: by 2002:a05:600c:468c:b0:49e:715d:95ca with SMTP id 5b1f17b1804b1-49fe66f9fc1mr40944395e9.13.1790254733024;
        Thu, 24 Sep 2026 05:58:53 -0700 (PDT)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5de187asm64662205e9.7.2026.09.24.05.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 05:58:52 -0700 (PDT)
Date: Thu, 24 Sep 2026 13:58:49 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v6 13/18] tracing/remotes: Add dump_on_panic tracefs file
Message-ID: <arUeid6jHB-mK__7@google.com>
References: <20260817135517.3919534-1-vdonnefort@google.com>
 <20260817135517.3919534-14-vdonnefort@google.com>
 <20260817141020.330011F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260817141020.330011F00A3D@smtp.kernel.org>

On Mon, Aug 17, 2026 at 02:10:19PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential issue(s) to consider:
> - [High] The panic handler unconditionally attempts to acquire a per-CPU reader spinlock that may be held by a CPU halted by smp_send_stop(), leading to a permanent deadlock during kernel panic.
> - [High] Missing touch_nmi_watchdog() in the panic dump loop can cause a secondary panic or hard reset.
> - [Medium] Mixing goto-based error handling with __free() scope-based cleanup in trace_remote_iter().
> - [Low] Missing READ_ONCE() when reading remote->panic_on in dump_on_panic_show().
> --
> 
> --- Patch [13]: [PATCH v6 13/18] tracing/remotes: Add dump_on_panic tracefs file ---
> commit 33a5774bde5e05c9ff209cc5026a9b962c22df16
> Author: Vincent Donnefort <vdonnefort@google.com>
> 
> tracing/remotes: Add dump_on_panic tracefs file
> 
> This commit adds a dump_on_panic tracefs file. When enabled, it dumps the
> content of the trace remote buffer to the console if the system panics.
> 
> > diff --git a/kernel/trace/trace_remote.c b/kernel/trace/trace_remote.c
> > index 9e78267d71f8b..5536e0df43795 100644
> > --- a/kernel/trace/trace_remote.c
> > +++ b/kernel/trace/trace_remote.c
> 
> [ ... ]
> 
> > @@ -434,58 +455,68 @@ static void trace_remote_dec_poll(struct trace_remote *remote)
> >  static struct trace_remote_iterator
> >  *trace_remote_iter(struct trace_remote *remote, int cpu, enum tri_type type)
> >  {
> > -	struct trace_remote_iterator *iter = NULL;
> > +	struct trace_remote_iterator *iter __free(kfree) = kzalloc_obj(*iter);
> 
> [Severity: Medium]
> This isn't a bug, but this function mixes scope-based cleanup (__free) with
> a goto-based error handling pattern. According to the cleanup subsystem
> guidelines, mixing goto-based cleanup labels and __free() declarations in
> the same function is forbidden because it creates confusing ownership
> semantics.
> 
> Should this function either use goto-based cleanup exclusively, or be
> fully converted to scope-based cleanup?
> 
> [ ... ]
> 
> > @@ -989,6 +1024,117 @@ static int dmesg_show(struct seq_file *s, void *unused)
> >  }
> >  DEFINE_TRACE_REMOTE_ATTRIBUTE(dmesg);
> >  
> > +static int trace_remote_panic_handler(struct notifier_block *self, unsigned long ev, void *v)
> > +{
> > +	struct trace_remote *remote = container_of(self, struct trace_remote, panic_notifier);
> > +	struct trace_remote_iterator *iter = smp_load_acquire(&remote->panic_iter);
> > +	int cpu;
> > +
> > +	if (!iter) {
> > +		pr_warn("Unexpected error: no panic iterator for the trace remote\n");
> > +		return NOTIFY_DONE;
> > +	}
> > +
> > +	for_each_possible_cpu(cpu) {
> > +		if (iter->rb_iters[cpu]) {
> > +			/* No RING_BUFFER_ALL_CPUS to avoid taking cpu_read_lock() */
> > +			ring_buffer_read_remote_meta_page(remote->trace_buffer, cpu);
> > +			ring_buffer_iter_reset(iter->rb_iters[cpu]);
> > +		}
> > +	}
> 
> [Severity: High]
> Can this loop deadlock indefinitely during a panic?
> 
> If another CPU is actively reading the remote trace buffer and holds its
> reader_lock, the panic() function will stop that CPU via smp_send_stop().
> 
> When the panicking CPU executes this loop,
> ring_buffer_read_remote_meta_page() calls rb_reader_lock(). If in_nmi() is
> false (which happens on a normal oops or SysRq-C), rb_reader_lock() will
> unconditionally attempt to acquire the lock held by the stopped CPU rather
> than using a trylock.
> 
> Will this cause the panic recovery process to hang forever?
> 
> > +
> > +	while (trace_remote_iter_read_event(iter)) {
> > +		trace_seq_init(&iter->seq);
> > +
> > +		trace_remote_iter_print_event(iter);
> > +		trace_seq_putc(&iter->seq, 0);
> > +		pr_emerg("%s", seq_buf_str(&iter->seq.seq));
> > +
> > +		trace_remote_iter_move(iter);
> > +	}
> 
> [Severity: High]
> Since serial consoles can be slow and remote trace buffers can contain
> many events, could the time spent in this printing loop trigger the NMI
> watchdog and cause a hard reset before the panic dump completes?
> 
> Does this loop need a call to touch_nmi_watchdog()?

Makes sense. And actually ftrace_dump_one does that too!

> 
> > +
> > +	return NOTIFY_DONE;
> > +}
> 
> [ ... ]
> 
> > +static int dump_on_panic_show(struct seq_file *s, void *unused)
> > +{
> > +	struct trace_remote *remote = s->private;
> > +
> > +	seq_printf(s, "%d\n", remote->panic_on);
> 
> [Severity: Low]
> Does this unprotected read of remote->panic_on need a READ_ONCE()?
> 
> Since dump_on_panic_write() modifies this flag concurrently under
> remote->lock, this is formally a data race under the Linux kernel memory
> model and might be flagged by KCSAN.
> 
> > +
> > +	return 0;
> > +}
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260817135517.3919534-1-vdonnefort@google.com?part=13

-- 
Vincent
