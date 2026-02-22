Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA94192D97
	for <linux-trace-kernel@vger.kernel.org>; Sun, 22 Feb 2026 14:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771770912; cv=none; b=Ds/RcMa58uKHpFlx9/3JQNKxjAhlnyD+iO1OtnV1yADAPVKLXqstLJJc7W+dziKTTd4zpPx8dd0rCk9oPtJ9/S4KJdB4RXuriwIiawNv+5YoziGI2rpEpMHp+8C2ts7qgf+wZ5nLB5pBlrO3HE8G9iOZcKd/48AjM/SS/wCPfFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771770912; c=relaxed/simple;
	bh=vktM7BRk058T9EgqkKWWszp5qZZmm5bzsA9nWsQ334E=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Px0L46nSzshEKUXUe5IbkGKpeWUYcqW493BpyrfI8MHAMMKgZ/l0WPzASQqHKmKvs4wX0hgzUtr6iuf0ew3CLvHdAoJhSVrNdOhG1X/UGA3oq1KY8V2g4MaKlts+XQS4MgRZjJ3eRx0sI+E2IzpdPSeZ6sEcO94XsLeiiMRFYAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ga9RQDEg; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ga9RQDEg"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4834826e5a0so42867125e9.2
        for <linux-trace-kernel@vger.kernel.org>; Sun, 22 Feb 2026 06:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771770910; x=1772375710; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ObkTvvTUXDhmbm+XB5jZaN2+4troEqpoA0rJxjwXv7I=;
        b=ga9RQDEgCckqnCR/qnc/zRrxHSOa0GuVBXZ9i2WyxV5PbVNWteT50flwmALIM7NAuo
         AOnGaEMfSCWZc/6e3PJrqzzJgAFYAE9LuTXHospBlxw9m+1nsbPggkt2oFouD10vB0vV
         JjGSrmuL6+Se9qCLLaNlB30WhrhcVvnr2P8GyS3Wf15BgFKajuKUOUTYx+ghtk48Ai0K
         AMzpBedG2ifyjNNohf+KKt3O5TcqgTKUfenZ42LstTrZE8CyHCyiXGzFSuwDFCkxymda
         y+tbV8/2jxj1hckz+5sXrKpGu6pHGDES09VxtxnTgYy3TARqfaRDvoyfwkLuNo3J9NLF
         vBVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771770910; x=1772375710;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ObkTvvTUXDhmbm+XB5jZaN2+4troEqpoA0rJxjwXv7I=;
        b=ADNSCXPPw4EjlZK3yR+gs4QqxWMVCGO0GWzGIDh+RLKDII3T7pImdmJl7c9tuVvHmH
         RhqwuxNSInTa1f2aML/DzcVFsoDTAG8rCH25ZLb7RZ99chPtCdH+xxDxOJl9qKmcA+AK
         S3xbzrOB0UDW0kidAMMnY0DargTdWKoScYuwyiXJJ40mlfYcsNKlFj5rRGcOOPuFVDLm
         M+1l+SFmRf5sWahTSs4Yvg8jcja52AeomoJkdL2us3xYu1dtQKspjKbVZUPnDIzJmr0i
         eNdwGPO75FY6nUxEhd91WKbFrJ2e7XxP3VANBaPFJnjTIJ23r63Vkk/C0iNqUwLX/BUP
         Vo6w==
X-Forwarded-Encrypted: i=1; AJvYcCWypDSDH0txzKgXeenqw5jD7W2afGyR4S+vrWOFN+uS3gYi0S5+fT082CnYqoZ8ZALPlQz0bKD+KKAMJ6rS6E4t1w8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxgz8zCLGHta9Xb1i2VfAGhWuCTFP4CqUH+q8KBgEOYf1uv/KPJ
	s71OByMW2lMJuT1zIpm+1vjuv8FgibekHj+TjgGU8kFJ4Y7fckjskDJW
X-Gm-Gg: AZuq6aJibj1oR9Rp4hvp1e3/vFqTMizrblAAvID1x177uxenAdL2UmpB4wV1QSVIOaV
	69c91kEqsN2PhfQwhXBuHv8KZAuU8Tf1SNHGNNgNOqs6qWv1+TL/06qExUYn3OvUhDSluAnGSzf
	YnguXYd2eonZ60oCynq0xozoGsOf05qPDvNcziFQxYAJE/TKHzH8/42ZhDhhNfBWTw5v36RXWY8
	KjBlmurQ0M9Up8QZlEENokdPPBDDFZyNwRNaH+rr3G0/gHMOUWlqkvYx0/ms+UFxnFA7Cy50wl3
	ey9a0qiJF8mhWL0fjt/A/hHpl2fABae448fKOL6Y0An7QKuBnfFW7Nj+cQ7Zpwh3D4x/xkPv2s+
	e16shSFWiCtONIVYNT2g7o85BjAfd6DkXlL6C44Or65Q0msXLzP0ycOBpGAobOwN9d7uXGotZLl
	Nzj+AJQDg=
X-Received: by 2002:a05:600c:45cc:b0:477:7a53:f493 with SMTP id 5b1f17b1804b1-483a95f554amr95193665e9.23.1771770909621;
        Sun, 22 Feb 2026 06:35:09 -0800 (PST)
Received: from krava ([2a02:8308:a00c:e200::b44f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a9cb3f31sm120803945e9.13.2026.02.22.06.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 06:35:09 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sun, 22 Feb 2026 15:35:07 +0100
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	kafai@fb.com, eddyz87@gmail.com, songliubraving@fb.com, yhs@fb.com,
	menglong8.dong@gmail.com, rostedt@kernel.org, martin.lau@kernel.org,
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCH bpf-next 08/17] bpf: Add support for tracing multi link
Message-ID: <aZsUG16KRLWzpQO-@krava>
References: <20260220100649.628307-9-jolsa@kernel.org>
 <e41633c6d6d32fabb08ecc4ae8432a45afaa72aa61756601f4cdb9aebd039f86@mail.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e41633c6d6d32fabb08ecc4ae8432a45afaa72aa61756601f4cdb9aebd039f86@mail.kernel.org>

On Fri, Feb 20, 2026 at 10:57:58AM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
> > --- a/include/linux/bpf_types.h
> > +++ b/include/linux/bpf_types.h
> 
> [ ... ]
> 
> > +BPF_LINK_TYPE(BPF_LINK_TYPE_TRACING_MULTI, tracing)
> 
> The existing BPF_LINK_TYPE_TRACING also uses "tracing" as its name
> argument:
> 
>     BPF_LINK_TYPE(BPF_LINK_TYPE_TRACING, tracing)
> 
> This means bpf_link_type_strs[] will contain "tracing" for both
> BPF_LINK_TYPE_TRACING and BPF_LINK_TYPE_TRACING_MULTI, making them
> indistinguishable in fdinfo output via bpf_link_show_fdinfo().
> 
> The libbpf side correctly uses "tracing_multi":
> 
>     [BPF_LINK_TYPE_TRACING_MULTI] = "tracing_multi",
> 
> Should this be BPF_LINK_TYPE(BPF_LINK_TYPE_TRACING_MULTI, tracing_multi)
> to match?

it should, fixed

> 
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> 
> [ ... ]
> 
> > +int bpf_tracing_multi_attach(struct bpf_prog *prog, const union bpf_attr *attr)
> > +{
> 
> [ ... ]
> 
> > +	ids = kvmalloc_array(cnt, sizeof(*ids), GFP_KERNEL);
> 
> [ ... ]
> 
> > +	link = kzalloc(struct_size(link, nodes, cnt), GFP_KERNEL);
>                 ^^^^^^
> 
> The ids array above uses kvmalloc_array() to handle large allocations,
> but the link struct uses kzalloc(). With MAX_TRACING_MULTI_CNT at 1M
> and each bpf_tracing_multi_node being roughly 40 bytes,
> struct_size() can request up to ~40MB of contiguous memory. kzalloc()
> is limited to KMALLOC_MAX_SIZE (~4MB on x86_64), so this will fail
> for cnt values above roughly 100K.
> 
> Would kvzalloc() work here instead? bpf_tracing_multi_link_dealloc()
> would need to use kvfree() accordingly:
> 
> > +static void bpf_tracing_multi_link_dealloc(struct bpf_link *link)
> > +{
> > +	struct bpf_tracing_multi_link *tr_link =
> > +		container_of(link, struct bpf_tracing_multi_link, link);
> > +
> > +	kfree(tr_link);

yes, makes sense, will fix, thnx

jirka
