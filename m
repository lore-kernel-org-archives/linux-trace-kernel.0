Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D603517A305
	for <linux-trace-kernel@vger.kernel.org>; Tue, 25 Nov 2025 02:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764036372; cv=none; b=mt9FOCECEbsAxVp+ZTYT51VS4vQHlGN95afqEH+SVnICVnRtFFikej1N8EvkMkQha1NBFEpkzrxPMkLJLqc17UqX70b0GDf/cSSkxL8pmsztnjbPJPgKwrLhh2nwuG04t6RBp4YpG0DaEIhKIlMXobImy8J2mxuaHQKmJttrcNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764036372; c=relaxed/simple;
	bh=HJevihCscMNP7fUd98ql7iReczwRgOKOj43DJSrmcRQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jNcSTXXnhYrAHDNKcM/gAC19JmILogZBFjMObhUOTpIJ+osT6wE0MRt2VsUWIsepqwH2qtN60lA8/xwgiNK5XdE7DZFrSFW0AtxXGpuZXbz/5hIjc2R+PYPJ7GXRFJd26N4ty/Cx3BT+HHWtRr/36/mMnz5xYcAXegTjuEZISLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bEsx52kV; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bEsx52kV"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b727f452fffso983412966b.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 24 Nov 2025 18:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764036368; x=1764641168; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2r/OEYGp4msQngBltB83+Y75K8ZVzD/4keivsBWH3sQ=;
        b=bEsx52kVRmRPyEI5CbRiiWN7/Vlpb8P/0bDe5i4ELR4Je6jK74mwCTW1EsUYmfl6np
         V07TtzPLeIoxwU5TaMtZU3JgFFf4Q/2s4k0qhUVBlQB6PLpfykuAdsbn2C8DeJVMdtEI
         HfdqjoXKW4ttfUfyw2dX9yJyfk73SjVI/qNeJZkquy8A0RcioyFPf+SJaLsDmpK5PZB1
         IasZoT7EPr5j5woE0wUFAHhlTIbFn1XMaM5UxnG7x2J1ZMQmALHVYO7cbrl8/JsBlcoS
         tVDsK6Ru7Lf25c9ZIp7jGBSaXj4Ikbe/xX02Sd4pqY7EPQMprd+8J+VAyNsPSmBIbkvK
         Yw+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764036368; x=1764641168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2r/OEYGp4msQngBltB83+Y75K8ZVzD/4keivsBWH3sQ=;
        b=Hsn5NYb2hqR5TzICOAtKyx0SOhIieF0FZ2mtiW36ZcM5SRE7tFcWLt4kLUo6vkp73x
         EQiT2qZzA+eHXMhAM32SUtTG/7Qm3pUHOSbwJxdmOAHDKHmtEHKof9azQgQ2ZX0TwkcJ
         yRpAFoM6PxbaKyw8v/UfLA/2/vQUvEd6WeVIIKeTANbTtkKFHB2gZehy2eLNL6oDrPtG
         b0cI3P51tTT9ecrIVc8kx+CaGmjm/jU15z1i72bDcOM54OZ1K5N/Y03iCeQMDujOYWD6
         SQ/QTkAHdGhIP9LdmPnCCDTquP/JnKyFdTCzjOstezAtkaL/DBc5l/IDVXpLWBLeGVJ2
         CU8A==
X-Gm-Message-State: AOJu0YxhZ089bflS80jdN/YXliTKanI4Bnea4Liocg3+N9IaBLxZ7pMh
	HWNHsW+fAJJz8MmkSLR+1eX8kscT4kvbMKQR1364uMCFpGVtXIuzpZUiyclqpbiP16h/P/RTYtE
	vHULouj3F4sqrm/g3FUvoVlQ5/3IhRkk=
X-Gm-Gg: ASbGnctajaZtKsRv/hetZIIJMr+Wr2ikIrOMX7WHEXtfixz7oE+BhMzoCGpEudmsS8C
	oJFvPwsJe+MTCmuMYRjO/VQtQ53nCy4u7qFgvp/Ftl/JBL4vH+aWf7zTFrpKuNaV8fGecmVkZfR
	HxHta57htTDJF+Yxse6iSlDrPJSRb4IvhFFxNZ2uiUD3hkF3rJVStmbJhBWCoD2YQRHH3F6qGvX
	MmQ6LAiGibv5Wbyiga5pdI2oZsoZiixKbvHITxlQ/7eiGPon7xI6aqQhgPtXSXF6l+fbY8u
X-Google-Smtp-Source: AGHT+IG6UIKLHiV0Sh21vjYUWscQWVF5QTGww3GHcRZUgT8p8ef+o6dgxX1OPKX/zU0Qar5Fr0lmMns8ww1f7hNFbrw=
X-Received: by 2002:a17:907:9716:b0:b70:b161:b9a8 with SMTP id
 a640c23a62f3a-b7657132ee5mr2192987966b.2.1764036367526; Mon, 24 Nov 2025
 18:06:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114025522.2115359-1-dolinux.peng@gmail.com>
 <20251124164701.1216a073@gandalf.local.home> <20251124165440.1418ed85@gandalf.local.home>
 <20251124201258.0e34ac3b@gandalf.local.home>
In-Reply-To: <20251124201258.0e34ac3b@gandalf.local.home>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Tue, 25 Nov 2025 10:05:54 +0800
X-Gm-Features: AWmQ_bmYd3uoEle0nw07tAOqIUZBGnaJ6X1LIgWiyeiMjck7BKsvJrUvcw6JNzw
Message-ID: <CAErzpmsecSfSTKWHetu1rRnF08spunV_OLR4pKznFpB_QCYc8A@mail.gmail.com>
Subject: Re: [PATCH v7] function_graph: Enable funcgraph-args and
 funcgraph-retaddr to work simultaneously
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Donglin Peng <pengdonglin@xiaomi.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 25, 2025 at 9:12=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Mon, 24 Nov 2025 16:54:40 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
>
> > On Mon, 24 Nov 2025 16:47:01 -0500
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > > > --- a/kernel/trace/trace_entries.h
> > > > +++ b/kernel/trace/trace_entries.h
> > > > @@ -95,14 +95,14 @@ FTRACE_ENTRY_PACKED(fgraph_retaddr_entry, fgrap=
h_retaddr_ent_entry,
> > > >   TRACE_GRAPH_RETADDR_ENT,
> > > >
> > > >   F_STRUCT(
> > > > -         __field_struct( struct fgraph_retaddr_ent,      graph_ent=
       )
> > > > +         __field_struct( struct ftrace_graph_ent,        graph_ent=
       )
> > > >           __field_packed( unsigned long,  graph_ent,      func     =
       )
> > > >           __field_packed( unsigned int,   graph_ent,      depth    =
       )
> > > > -         __field_packed( unsigned long,  graph_ent,      retaddr  =
       )
> > >
> > > You can't delete the retaddr without breaking user space.
> > >
> > > Please keep that here.
> >
> > I added this, and user space works again:
> >
> > diff --git a/kernel/trace/trace_entries.h b/kernel/trace/trace_entries.=
h
> > index 593a74663c65..4666b6179056 100644
> > --- a/kernel/trace/trace_entries.h
> > +++ b/kernel/trace/trace_entries.h
> > @@ -98,6 +98,7 @@ FTRACE_ENTRY_PACKED(fgraph_retaddr_entry, fgraph_reta=
ddr_ent_entry,
> >               __field_struct( struct ftrace_graph_ent,        graph_ent=
       )
> >               __field_packed( unsigned long,  graph_ent,      func     =
       )
> >               __field_packed( unsigned int,   graph_ent,      depth    =
       )
> > +             __field_packed( unsigned long,  graph_ent,      retaddr  =
       )
> >               __dynamic_array(unsigned long,  args                     =
       )
> >       ),
> >
>
> Nope, this wasn't enough. I got garbage from this. The following patch
> appears to make it all work though (this is against your patch that was
> forward ported to my for-next branch):
>
> diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> index 88cb54d73bdb..ba180d19423e 100644
> --- a/include/linux/ftrace.h
> +++ b/include/linux/ftrace.h
> @@ -1121,12 +1121,10 @@ static inline void ftrace_init(void) { }
>
>  /*
>   * Structure that defines an entry function trace.
> - * It's already packed but the attribute "packed" is needed
> - * to remove extra padding at the end.
>   */
>  struct ftrace_graph_ent {
>         unsigned long func; /* Current function */
> -       int depth;
> +       unsigned long depth;
>  } __packed;
>
>  /*
> diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> index 05fb6c9279e3..d509a5041d38 100644
> --- a/kernel/trace/trace.h
> +++ b/kernel/trace/trace.h
> @@ -60,6 +60,13 @@ enum trace_type {
>         __TRACE_LAST_TYPE,
>  };
>
> +/*
> + * Structure that defines an entry function trace with retaddr.
> + */
> +struct fgraph_retaddr_ent {
> +       struct ftrace_graph_ent         ent;
> +       unsigned long retaddr;  /* Return address */
> +} __packed;
>
>  #undef __field
>  #define __field(type, item)            type    item;
> diff --git a/kernel/trace/trace_entries.h b/kernel/trace/trace_entries.h
> index 593a74663c65..87f4228374cd 100644
> --- a/kernel/trace/trace_entries.h
> +++ b/kernel/trace/trace_entries.h
> @@ -80,11 +80,11 @@ FTRACE_ENTRY(funcgraph_entry, ftrace_graph_ent_entry,
>         F_STRUCT(
>                 __field_struct( struct ftrace_graph_ent,        graph_ent=
       )
>                 __field_packed( unsigned long,  graph_ent,      func     =
       )
> -               __field_packed( unsigned int,   graph_ent,      depth    =
       )
> +               __field_packed( unsigned long,  graph_ent,      depth    =
       )
>                 __dynamic_array(unsigned long,  args                     =
       )
>         ),
>
> -       F_printk("--> %ps (%u)", (void *)__entry->func, __entry->depth)
> +       F_printk("--> %ps (%lu)", (void *)__entry->func, __entry->depth)
>  );
>
>  #ifdef CONFIG_FUNCTION_GRAPH_RETADDR
> @@ -95,13 +95,14 @@ FTRACE_ENTRY_PACKED(fgraph_retaddr_entry, fgraph_reta=
ddr_ent_entry,
>         TRACE_GRAPH_RETADDR_ENT,
>
>         F_STRUCT(
> -               __field_struct( struct ftrace_graph_ent,        graph_ent=
       )
> -               __field_packed( unsigned long,  graph_ent,      func     =
       )
> -               __field_packed( unsigned int,   graph_ent,      depth    =
       )
> +               __field_struct( struct fgraph_retaddr_ent,      graph_ent=
       )
> +               __field_packed( unsigned long,  graph_ent.ent,  func     =
       )
> +               __field_packed( unsigned long,  graph_ent.ent,  depth    =
       )
> +               __field_packed( unsigned long,  graph_ent,      retaddr  =
       )
>                 __dynamic_array(unsigned long,  args                     =
       )
>         ),
>
> -       F_printk("--> %ps (%u) <- %ps", (void *)__entry->func, __entry->d=
epth,
> +       F_printk("--> %ps (%lu) <- %ps", (void *)__entry->func, __entry->=
depth,
>                 (void *)__entry->args[0])

Thanks. The args[0] holds the return address in this patch, so if the retad=
dr
member is added back, we may need to reconstruct this patch to store the
return address in the retaddr member, with the args array storing only func=
tion
parameters. I will fix it in the next version.

Thanks
Donglin

>  );
>
> -- Steve
