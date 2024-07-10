Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6AF6197A91;
	Wed, 10 Jul 2024 19:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720640326; cv=none; b=PASjtSb7bScl/6qL0x/QQUsKsoBC9ebovyEj3JeP2WYOZTr2YdDu21XlV3epAYqnnrx/JDBAHXmySCIeTuDL+9ZpcUCLewQ5WIkSDn1mffhldN7TTcfFCGJmVlRtCfakPyxB3hMuuGJi4MZh6cxNIS2dBVAF5SWKmQYPqlrNdJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720640326; c=relaxed/simple;
	bh=67Yjzf2Um2vbW/jejczx+mLuuT41TRVxg2Nb7tadK7c=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xx0QLreUgNZ5vk1J+a80nGMretWkZCafPQhLGqRS1y/g0oj3zltt+s+bV/UzSswGyc+8jMG2ntJEhxyI6lyW+CbzZ3QVPug53Puw9ZFEQTmUE1Ac+ve8Y27WcuIA66NLL7dS4MUN7N8owaELF/NSvZwe95+39X/Ip4Mj8j3w9hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LDQVz0h9; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LDQVz0h9"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52ea33671ffso137156e87.3;
        Wed, 10 Jul 2024 12:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720640323; x=1721245123; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ucNUszqGgbpRfZE5T8sdF/JDYyD263mTxEW1kpHw0MY=;
        b=LDQVz0h99rIjdNa9Hx3HQHi5NJvUPLVRmFnjSKrFJbcjyTwEOQnb9pCtdEJQolDx/X
         Roh+XzyEkOYydcVOF4E5YEjlHrjdPKJeuWw2rrVXrYz7eGGxfqIQARDUS0bG6ouESlvZ
         if5IEkmVIRf0bJqqkJV6v1mGhX0VS1cpsbOnAHJSvs0h80S1I0zG5mq8GdI1YGR/tztk
         eYAQP/qK1gEQZfy+OnO/O2LhlC9jMnFyM8fDu3UWiGWTSOfpQG5g6kYURCV7EISIJ0M5
         99Z1913hzlG4N7JQz3KAlEm1qBEzjwdi1rnMoQGig2pnl/hKNQS89JuHNfIAgAo81LRU
         WduA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720640323; x=1721245123;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ucNUszqGgbpRfZE5T8sdF/JDYyD263mTxEW1kpHw0MY=;
        b=ErOyMD6V6fhI+k+0jqe4QMh4Ni6ku5hF1MPMMrx502EqE8YTmk09PAtOQw3wK7ESa8
         FBKus76wEFu66c4E+I5ivKJ6Lge8wZH2RlfGywumiRw4CC1ICpEX5Iah0o6SDERO7PNI
         8b5rzVC/Dl435TftM6R4AeknAnKTNaf3+2L6BuZ5GkaDgI7kFJCRBt9BAGFXAbCQQ7LM
         9Gd20ERJ47MlnFeNsVJ6cyCgK3mLTDTKRopHIEGocqQcEEj3R/2gC9xJvXtZhWe5N2RK
         UmcwJ0M9Ze6YGCJd6Iz1/Oow8gVmxgzoG6V3qUQZSaVRQxrI0zjykzYWoYkBmIA4670B
         DXgg==
X-Forwarded-Encrypted: i=1; AJvYcCXOh7yzRr5AgXZaoMKUQQj0Odb8P4/x+63euQFLOZxhMoEkXJrdbo6ZZNJwqz3agyZy+R+TvVxxfrHA16qU1Gu/z/E/dA5A4DVdFzwN4WFjSV3jbDyI6s7mgzdqmlUxI6O/XvY3+0uASWx41k1qWnKa
X-Gm-Message-State: AOJu0YyBUcvUXrEPlXqu79Mqd85YlEnT+ok93FSZe0/FMpYfatO4mvqd
	Wl2IqjhtR5SWt3HkzbtbP9Xu3tyxt26w+qYYD2dHoFwUdwCfyFauzsEF5A==
X-Google-Smtp-Source: AGHT+IEuOXyyWPPNk0yoLSmKUKV5JcDXpfD54l4ptMXZhiaBuTy+1ygXqNIRx0nn3b5/jHy0OsiXEQ==
X-Received: by 2002:a05:6512:48c5:b0:52e:be14:7012 with SMTP id 2adb3069b0e04-52ebe14717emr2370217e87.32.1720640322359;
        Wed, 10 Jul 2024 12:38:42 -0700 (PDT)
Received: from krava (85-193-35-231.rib.o2.cz. [85.193.35.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4266f6e09fcsm93162645e9.4.2024.07.10.12.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 12:38:42 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 10 Jul 2024 21:38:40 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
	andrii@kernel.org, mhiramat@kernel.org, peterz@infradead.org,
	clm@meta.com, mingo@kernel.org, paulmck@kernel.org,
	rostedt@goodmis.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] uprobes: make uprobe_register() return struct uprobe
 *
Message-ID: <Zo7jQOWyUGp6YTbz@krava>
References: <20240710140017.GA1074@redhat.com>
 <20240710163022.GA13298@redhat.com>
 <20240710163133.GD13298@redhat.com>
 <Zo67c9nvbRD0h4-b@krava>
 <CAEf4BzaSDUWiSywUNrDtd-yW6p53vFYkZkr5mb461jmUgWV_2g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzaSDUWiSywUNrDtd-yW6p53vFYkZkr5mb461jmUgWV_2g@mail.gmail.com>

On Wed, Jul 10, 2024 at 11:23:10AM -0700, Andrii Nakryiko wrote:
> On Wed, Jul 10, 2024 at 9:49 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Wed, Jul 10, 2024 at 06:31:33PM +0200, Oleg Nesterov wrote:
> >
> > SNIP
> >
> > > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > > index 467f358c8ce7..7571811127a2 100644
> > > --- a/kernel/trace/bpf_trace.c
> > > +++ b/kernel/trace/bpf_trace.c
> > > @@ -3157,6 +3157,7 @@ struct bpf_uprobe {
> > >       loff_t offset;
> > >       unsigned long ref_ctr_offset;
> > >       u64 cookie;
> > > +     struct uprobe *uprobe;
> > >       struct uprobe_consumer consumer;
> > >  };
> > >
> > > @@ -3180,10 +3181,8 @@ static void bpf_uprobe_unregister(struct path *path, struct bpf_uprobe *uprobes,
> > >  {
> > >       u32 i;
> > >
> > > -     for (i = 0; i < cnt; i++) {
> > > -             uprobe_unregister(d_real_inode(path->dentry), uprobes[i].offset,
> > > -                               &uprobes[i].consumer);
> > > -     }
> >
> > nice, we could also drop path argument now
> 
> see my comments to Oleg, I think we can/should get rid of link->path
> altogether if uprobe itself keeps inode alive.

yea, I was thinking of that, but then it's kind of useful to have it in
bpf_uprobe_multi_link_fill_link_info, otherwise we have to take it from
first uprobe in the link, but ok, still probably worth to remove it ;-)

anyway as you wrote it's ok for follow up cleanup, I'll check on that

> 
> BTW, Jiri, do we have any test for multi-uprobe that simulates partial
> attachment success/failure (whichever way you want to look at it). It
> would be super useful to have to check at least some error handling
> code in the uprobe code base. If we don't, do you mind adding
> something simple to BPF selftests?

there's test_attach_api_fails, but I think all checked fails are before
actually calling uprobe_register function

I think there are few ways to fail the uprobe_register, like install it
on top of int3.. will check add some test for that

jirka

> 
> >
> > jirka
> >
> > > +     for (i = 0; i < cnt; i++)
> > > +             uprobe_unregister(uprobes[i].uprobe, &uprobes[i].consumer);
> > >  }
> > >
> > >  static void bpf_uprobe_multi_link_release(struct bpf_link *link)
> > > @@ -3477,11 +3476,12 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
> > >                     &bpf_uprobe_multi_link_lops, prog);
> > >
> > >       for (i = 0; i < cnt; i++) {
> > > -             err = uprobe_register(d_real_inode(link->path.dentry),
> > > +             uprobes[i].uprobe = uprobe_register(d_real_inode(link->path.dentry),
> > >                                            uprobes[i].offset,
> > >                                            uprobes[i].ref_ctr_offset,
> > >                                            &uprobes[i].consumer);
> > > -             if (err) {
> > > +             if (IS_ERR(uprobes[i].uprobe)) {
> > > +                     err = PTR_ERR(uprobes[i].uprobe);
> > >                       bpf_uprobe_unregister(&path, uprobes, i);
> > >                       goto error_free;
> > >               }
