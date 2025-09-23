Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283C332128B
	for <linux-trace-kernel@vger.kernel.org>; Tue, 23 Sep 2025 16:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758644758; cv=none; b=sdCGlRuP+n8i+aBXA4gv+kv+tDiq0gtEvN4vTGIYMkOk2Uux3hX5A3XTqincZ7WoNM2B+W83lh5NiQXocZ1cgQe0h6NYgYnvk/ya6G8H29l6eU4dvPWndQXOtiMzC9U14v4CuYwkaohANrep0esWMdtnyButFNeA4rGPNOkLNAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758644758; c=relaxed/simple;
	bh=N5mgVPRo+CPk2ySaxtFkjus+k/V2WydmtZQlE+k35h4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q/2e5G0Fi5DZjnXfhlawjuojGLx/smJAIUNW5GOjNag8xNufNhbHZ165VSHmsMsh3iHwmLgPX493jc/Jy5dAoyiDJ4mKeCn8Zq3MuR6/z9ZC/uuZsoKajvGdhBEklXnbm83PRFBsqPb44AL9XnZm33aHSeHDyFeOq05B2Zs0iYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SwupfOZ0; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SwupfOZ0"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3ee15b5435bso3104613f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 23 Sep 2025 09:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758644754; x=1759249554; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IvBR/uuNoM05F0Kk2G6oFxp0yBhFbfSrXeNiw0n2Ztw=;
        b=SwupfOZ0T2gm1tYUiw7SBXyroHOI4oAqQrS7wKbxqu1fh9SGZBd+Bl/1JW7auj6sMn
         IFqadrkhyItkwDeC33IfnQsF2+E9R2X3rAOvMmAaI1vzTVijHX8x89VQVMRG6kcD1JRj
         9hoyGWNpZsJAqaTqBw5N1Svx22wEKif6aZ4DtJcVSmsVvlxFW71s/3kxCMoKsxFQfiwJ
         xMgSTbhwEo/Qc0IjpgU5EsGnCaeB+qDYM7kYZKg+GmDG3kBd2Ddd/u0P0HEoLqCU7WB8
         zQdGpRNadH+/R8v0pokBgY2yXOvBJY0e9otj/VJ3vmVKG9iVoqV5ykQ+yeB/dvE9uFxP
         AbWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758644754; x=1759249554;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IvBR/uuNoM05F0Kk2G6oFxp0yBhFbfSrXeNiw0n2Ztw=;
        b=SCYwdWSzW3bOcGljBssLElFBwK4I5O6Q5BosZktmmGlPjJ9HJe+0ZBjeOr3zg12SK8
         abfaknvTVSghZvWF9XLm/SiCABN065aBrPhSiD5eSvsosKx8Y8pkFagSdKqLbT5onF9o
         JgS2qdUe6UE80ku6x7MMWmCZnZWpeSqV29QOUhpKLZtWk/rwhuHz6gOqMEzDs7lj/CuS
         y121SgaUWMdRB7J0Dl5dSEo+LhztwynDRtM5AEK/wo7IHVzjPvLd70WYZwwnpgalFOL6
         dyWppGi/eDUEZU5HOBif8Vw3EDnMwAQhJOknY7oUuDVgbGM31MUYa3cx4TtwiO5I2FVc
         6XcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCLtxIAfqEdhwQ05Pof+J7BN8ZoSyQhZWlcgbYSeOyy+ClFlR4ZJlHhRcvW7AOpqUeZEEPbNmxY0oQnkDgorZO+xY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx44IPNWGVVZ90K+JurNozpwW/a5MP/mRky6f+tctfWC+wjjq2W
	gd27SjAMFo9XXScBI44W+HA7uwiIVOGoQny0GDZPhGu9afD04jwvPKMp
X-Gm-Gg: ASbGncvFJiAYxe/ppJOtTGYyPsx9dOER/65RyZEhB3XHNgw2wA6bsakNizyrsnhR3Ld
	8EQkSh6Mu56S09D4OE3mfRRb/7WeeTzhfc4lsVB4Fuils4HTDgFXOsV7Kk06thBTeRct+r+Y33W
	BCBoeYqxd5ccWixdup5HnhcyCwQm8jS10r0sb7AkmDQ/vORsCI84eebfDEjdb2CgXq5JsIwodz2
	TJXveTS4IquuiBKbwXC2DwjAk4cPjbkN0qYDSnRFoCl0Ia8/GmBL6NK7O3Dg7y+xNNwPIgWOK3C
	qMCmByjhaOh2jGKffSJyM0zKrbNxd2bJCZzH3BVjpPQZmuiji5sgh4i8ufBrGKYL3CQhO5MlFme
	RES/jt4VBT0k=
X-Google-Smtp-Source: AGHT+IHrFSATwyg3qRX5k56eKwBNcVQdxs7GBs4B3KV5AJlT4F8HQe8L3ySqDT1kugqd/sLfdFZJ1w==
X-Received: by 2002:a05:6000:430c:b0:3f0:2ab8:710f with SMTP id ffacd0b85a97d-405c3c3e243mr2955512f8f.8.1758644754154;
        Tue, 23 Sep 2025 09:25:54 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3fd84338ca2sm9347726f8f.42.2025.09.23.09.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 09:25:53 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 23 Sep 2025 18:25:52 +0200
To: Menglong Dong <menglong.dong@linux.dev>
Cc: Jiri Olsa <olsajiri@gmail.com>, mhiramat@kernel.org,
	rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH 2/2] tracing: fprobe: optimization for entry only case
Message-ID: <aNLKEJc6Bh-dC3ab@krava>
References: <20250923092001.1087678-1-dongml2@chinatelecom.cn>
 <4681686.LvFx2qVVIh@7940hx>
 <aNKRoKTAmKpafk4F@krava>
 <5938379.DvuYhMxLoT@7950hx>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5938379.DvuYhMxLoT@7950hx>

On Tue, Sep 23, 2025 at 09:34:20PM +0800, Menglong Dong wrote:
> On 2025/9/23 20:25, Jiri Olsa wrote:
> > On Tue, Sep 23, 2025 at 07:16:55PM +0800, menglong.dong@linux.dev wrote:
> > > On 2025/9/23 19:10 Jiri Olsa <olsajiri@gmail.com> write:
> > > > On Tue, Sep 23, 2025 at 05:20:01PM +0800, Menglong Dong wrote:
> > > > > For now, fgraph is used for the fprobe, even if we need trace the entry
> > > > > only. However, the performance of ftrace is better than fgraph, and we
> > > > > can use ftrace_ops for this case.
> > > > > 
> > > > > Then performance of kprobe-multi increases from 54M to 69M. Before this
> > > > > commit:
> > > > > 
> > > > >   $ ./benchs/run_bench_trigger.sh kprobe-multi
> > > > >   kprobe-multi   :   54.663 ± 0.493M/s
> > > > > 
> > > > > After this commit:
> > > > > 
> > > > >   $ ./benchs/run_bench_trigger.sh kprobe-multi
> > > > >   kprobe-multi   :   69.447 ± 0.143M/s
> > > > > 
> > > > > Mitigation is disable during the bench testing above.
> > > > > 
> > > > > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > > > > ---
> > > > >  kernel/trace/fprobe.c | 88 +++++++++++++++++++++++++++++++++++++++----
> > > > >  1 file changed, 81 insertions(+), 7 deletions(-)
> > > > > 
> > > > > diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> > > > > index 1785fba367c9..de4ae075548d 100644
> > > > > --- a/kernel/trace/fprobe.c
> > > > > +++ b/kernel/trace/fprobe.c
> > > > > @@ -292,7 +292,7 @@ static int fprobe_fgraph_entry(struct ftrace_graph_ent *trace, struct fgraph_ops
> > > > >  				if (node->addr != func)
> > > > >  					continue;
> > > > >  				fp = READ_ONCE(node->fp);
> > > > > -				if (fp && !fprobe_disabled(fp))
> > > > > +				if (fp && !fprobe_disabled(fp) && fp->exit_handler)
> > > > >  					fp->nmissed++;
> > > > >  			}
> > > > >  			return 0;
> > > > > @@ -312,11 +312,11 @@ static int fprobe_fgraph_entry(struct ftrace_graph_ent *trace, struct fgraph_ops
> > > > >  		if (node->addr != func)
> > > > >  			continue;
> > > > >  		fp = READ_ONCE(node->fp);
> > > > > -		if (!fp || fprobe_disabled(fp))
> > > > > +		if (unlikely(!fp || fprobe_disabled(fp) || !fp->exit_handler))
> > > > >  			continue;
> > > > >  
> > > > >  		data_size = fp->entry_data_size;
> > > > > -		if (data_size && fp->exit_handler)
> > > > > +		if (data_size)
> > > > >  			data = fgraph_data + used + FPROBE_HEADER_SIZE_IN_LONG;
> > > > >  		else
> > > > >  			data = NULL;
> > > > > @@ -327,7 +327,7 @@ static int fprobe_fgraph_entry(struct ftrace_graph_ent *trace, struct fgraph_ops
> > > > >  			ret = __fprobe_handler(func, ret_ip, fp, fregs, data);
> > > > >  
> > > > >  		/* If entry_handler returns !0, nmissed is not counted but skips exit_handler. */
> > > > > -		if (!ret && fp->exit_handler) {
> > > > > +		if (!ret) {
> > > > >  			int size_words = SIZE_IN_LONG(data_size);
> > > > >  
> > > > >  			if (write_fprobe_header(&fgraph_data[used], fp, size_words))
> > > > > @@ -384,6 +384,70 @@ static struct fgraph_ops fprobe_graph_ops = {
> > > > >  };
> > > > >  static int fprobe_graph_active;
> > > > >  
> > > > > +/* ftrace_ops backend (entry-only) */
> > > > > +static void fprobe_ftrace_entry(unsigned long ip, unsigned long parent_ip,
> > > > > +	struct ftrace_ops *ops, struct ftrace_regs *fregs)
> > > > > +{
> > > > > +	struct fprobe_hlist_node *node;
> > > > > +	struct rhlist_head *head, *pos;
> > > > > +	struct fprobe *fp;
> > > > > +
> > > > > +	guard(rcu)();
> > > > > +	head = rhltable_lookup(&fprobe_ip_table, &ip, fprobe_rht_params);
> > > > 
> > > > hi,
> > > > so this is based on yout previous patch, right?
> > > >   fprobe: use rhltable for fprobe_ip_table
> > > > 
> > > > would be better to mention that..  is there latest version of that somewhere?
> > > 
> > > Yeah, this is based on that version. That patch is applied
> > > to: https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git/log/?h=probes%2Ffor-next
> > > 
> > > And I do the testing on that branches.
> > 
> > did you run 'test_progs -t kprobe_multi' ? it silently crashes the
> > kernel for me.. attaching config
> 
> Hi. I have tested the whole test_progs and it passed.
> 
> In fact, your config will panic even without this patch.
> Please don't enable CONFIG_X86_KERNEL_IBT, the recursion
> of the is_endbr() still exist until this series apply:
> 
>   tracing: fprobe: Protect return handler from recursion loop

ugh, I thought it's there already, thanks

jirka
