Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A78A3A4F2D
	for <linux-trace-kernel@vger.kernel.org>; Thu,  5 Feb 2026 08:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770281830; cv=none; b=Mq12JfJxlSZhNNFlpGGYl+kADxGHiRV6lHtwYi2iHV0aGIkJVTTp5v3M5bPQy+bHhUQ1OymgriB9j0GDhQmX+0Q9Tif3MfdPoecsRR5ei1V9Spp7dBSX5r2qD1RnkXmgetdozLqSHgKGeM2mrJNedURBXM2xlkb2dojlvCTCaBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770281830; c=relaxed/simple;
	bh=u3YVewofoTs7GpAKFvpySY9gBfbVDItYWKHBYajT0Pg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N+OpUI2uTNGulcMXSsdEHSFiGEeXIyA1otKGXwt74x18LZZBAJyfU0GWVuS9MqmIiPc/bhN7bWwmOJvOMvIl85maklC9NDhKxwDBR2Iec8OlE7TXeaxvFhuvi2N94oAKIfhcnnJodhQZxEnz1WkqG1/rj0tkxJo3ffwBbqWjrjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bASPffIX; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bASPffIX"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47ee2715254so4063665e9.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 05 Feb 2026 00:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770281828; x=1770886628; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ryMAdOmf8+odSiELZLyHpyLcixKiXOuIhnOxERebJjw=;
        b=bASPffIXf3hQjFnU/fYAzL9zTuevNi+h7ipeG2b6XmigMwYyHcgySu8W+fkux7C1lV
         y8skzKBM9H+BwQce1mimaDzEx5m/TZH2whelgdD6VqoECCp0GgkdwMGLJt2vgwIpJRNC
         JotZZPO+W1p5IH2PRFubcvuIudXRPszSBVmWqdIAnAc2wZ6q95TWF6Sj/f7ID2S71VSY
         lCnEive8hcQxX7ReaMR9X0KbPBshV61wxcQVrHSB5nGH0xAeqGZq9gb9kOMgj2uh2vdb
         c0OH+2TRjg7YOWK8m17Iw6NhESsl7vk0U65/VTonnqZy7gTQhJEIc70xOpfhDRJU1siN
         Hj+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770281828; x=1770886628;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ryMAdOmf8+odSiELZLyHpyLcixKiXOuIhnOxERebJjw=;
        b=ILQzWEaBKwnGNpRu2fjLlzBfhPuZQjP6qnESwnSRekm5m4Lj+uJEKkx2Das2PnmMqG
         ukzoRhx9kq9u23CL41MzOgVtvb2ThbNqWJqV+Kcu1/6IH+PjCdfy5w90gdfiBuJ8qncl
         9xMFWvb0X3EGl+UMqyVZPu1fa/o89HSw58iKLs6cXzGP8WqfdVV01SkEQVUM37aJryW2
         47WTV/HlP3V9o7qJ7jlTilZgfCNvyBUGbiE2yOwJw9ioPGaa70Rd9x1yjZea/kwB9aD4
         V/FMhaSisamvbaaf2CmR3pMMdkk1H3Jh8We1fJpay+LJAWGu0fdQoHUdBsmfo12zh0cV
         RvpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGcjKxLUUIEyNE3Ym8Po5AT+lTuAZpatY7Z/T23OsjDjPM/X1PlndpsKFg+hBEuS7YKjYixWmVH9lhoqkkSYQQby0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSNXk0KaWwvCro/kjvGHiMdvulrElB5NdjG0QZ0Xni7f8PBTyh
	8+jK47WSYPJU0HbE/t3OQIe1xxYMn+5trrBq79fyVZwvBJNvZDZExvB0
X-Gm-Gg: AZuq6aIfdxEhFwaa4/60bXhjJZP/hA6B1RsSq+hGX1m9FJkhY6QO7ZP11myHLh9DRgG
	uFpxW0e/zdabV9CnEsulhWTqV3e8X0IQ8M4OgGwEIq4I4zoJsIYKzpOZAbIOdNSMfhKubVjTwMV
	sVM90RC9SxDXcJEXbngjoMe6zJ3QOoBD8LeRgHzWBXJpCRiOXym2XxekxxsdXwA1QT0m6SsoZVL
	+B8f9jxeb2rFs+nh/Qg5gAmILgblzz/sd2LSlVGoI1WxGMFZTUenT6itDbRLpkm3hCgm8ZVjDwN
	dfrB67rgKdQTvtYtdzaq8uxkkKfFAuZkjSR94L/7jsR3fT1b+DWFlmPcU7t0k3IgIatR77FWgE/
	zKABoZ1dtv5V7QPH2dtAMTCqvSVHFikG4nFz/o62SlmQ2we4Jm8gFmXwNCjk6
X-Received: by 2002:a05:600c:4684:b0:480:6fbc:695f with SMTP id 5b1f17b1804b1-4830e9a5491mr78359435e9.32.1770281827570;
        Thu, 05 Feb 2026 00:57:07 -0800 (PST)
Received: from krava ([2a02:8308:a00c:e200::b44f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48317d835f0sm40786655e9.14.2026.02.05.00.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 00:57:07 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 5 Feb 2026 09:57:05 +0100
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Steven Rostedt <rostedt@kernel.org>
Subject: Re: [RFC bpf-next 04/12] bpf: Add struct bpf_tramp_node object
Message-ID: <aYRbYY8f_wWoiZhk@krava>
References: <20260203093819.2105105-1-jolsa@kernel.org>
 <20260203093819.2105105-5-jolsa@kernel.org>
 <CAEf4BzYWxmg7YO_ewENt1rr4R1YT=iL0fc5yJqanfQZJk6u1nQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzYWxmg7YO_ewENt1rr4R1YT=iL0fc5yJqanfQZJk6u1nQ@mail.gmail.com>

On Wed, Feb 04, 2026 at 11:00:57AM -0800, Andrii Nakryiko wrote:
> On Tue, Feb 3, 2026 at 1:39 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Adding struct bpf_tramp_node to decouple the link out of the trampoline
> > attachment info.
> >
> > At the moment the object for attaching bpf program to the trampoline is
> > 'struct bpf_tramp_link':
> >
> >   struct bpf_tramp_link {
> >        struct bpf_link link;
> >        struct hlist_node tramp_hlist;
> >        u64 cookie;
> >   }
> >
> > The link holds the bpf_prog pointer and forces one link - one program
> > binding logic. In following changes we want to attach program to multiple
> > trampolines but have just one bpf_link object.
> >
> > Splitting struct bpf_tramp_link into:
> >
> >   struct bpf_tramp_link {
> >        struct bpf_link link;
> >        struct bpf_tramp_node node;
> >   };
> >
> >   struct bpf_tramp_node {
> >        struct hlist_node tramp_hlist;
> >        struct bpf_prog *prog;
> >        u64 cookie;
> >   };
> 
> I'm a bit confused here. For singular fentry/fexit attachment we have
> one trampoline and one program, right? For multi-fentry, we have
> multiple trampoline, but still one program pointer, no? So why put a
> prog pointer into tramp_node?.. You do want cookie in tramp_node, yes,
> but not the program.

yes, but both links:
  - single link 'struct bpf_tramp_link'
  - multi link  'struct bpf_tracing_multi_link'

are using same code to attach that code needs to have a hlist_node to
link the program to the trampoline and be able to reach the bpf_prog
(like in invoke_bpf_prog)

current code is passing whole bpf_tramp_link object so it has access
to both, but multi link needs to keep link to each trampoline (nodes
below):

struct bpf_tracing_multi_link {
       struct bpf_link link;
       enum bpf_attach_type attach_type;
       int nodes_cnt;
       struct bpf_tracing_multi_node nodes[] __counted_by(nodes_cnt);
};

and we can't get get from &nodes[x] to bpf_tracing_multi_link.link.prog

it's bit redundant, but not sure what else we can do

> Because then there is also a question what is
> bpf_link's prog pointing to?...

bpf_link.prog is still keeping the prog, I don't think we can remove that

jirka

> 
> 
> >
> > where 'struct bpf_tramp_link' defines standard single trampoline link,
> > and 'struct bpf_tramp_node' is the attachment trampoline object. This
> > will allow us to define link for multiple trampolines, like:
> >
> >   struct bpf_tracing_multi_link {
> >        struct bpf_link link;
> >        ...
> >        int nodes_cnt;
> >        struct bpf_tracing_multi_node nodes[] __counted_by(nodes_cnt);
> >   };
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  arch/arm64/net/bpf_jit_comp.c  |  58 +++++++++----------
> >  arch/s390/net/bpf_jit_comp.c   |  42 +++++++-------
> >  arch/x86/net/bpf_jit_comp.c    |  54 ++++++++---------
> >  include/linux/bpf.h            |  47 ++++++++-------
> >  kernel/bpf/bpf_struct_ops.c    |  24 ++++----
> >  kernel/bpf/syscall.c           |  25 ++++----
> >  kernel/bpf/trampoline.c        | 102 ++++++++++++++++-----------------
> >  net/bpf/bpf_dummy_struct_ops.c |  11 ++--
> >  8 files changed, 185 insertions(+), 178 deletions(-)
> >
> 
> [...]
