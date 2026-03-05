Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3530C25392A
	for <linux-trace-kernel@vger.kernel.org>; Thu,  5 Mar 2026 14:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772719368; cv=none; b=Z0AY+HoaYIvXzvv3k8H/iYxSxeXMM850+UcKupaDfcBc5tQvdyA/w6CvDU1fEaxGo7EVvQ07sC8Q+kMaeHxv7dB/o31V9hUcUl0JQPC+D+1n+zoNcOvUZQKzU6FumFDfh8rew+s6iuexvbMAywEeLauQVxd5dacE7xqKF3O7FvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772719368; c=relaxed/simple;
	bh=Z34mdtr1b/ICs/c64EQSK4zTp2yDbOBYmoxjVqtaA8I=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KYApj1jTG3DC4uNDUivtetj8J6Fq0AnGfZPp2no48OBb/lKp0YOgwXIIubzASitz/0EISmkJlcsAoVwlVCRwVB4Yn77ZUNhupUCgvWhttAW3j0VmtyjmPE7KcOEGyiZoLi3z7nRydqcsyQweILKkB+YDCi/Lq8kUwVfk9HOzI80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gutkv2/o; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gutkv2/o"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-439b73f4ab4so4969689f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 05 Mar 2026 06:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772719365; x=1773324165; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GKxSvraDpoad+84dRp1TpOG4toWpwmDod5+UGYBJ7P8=;
        b=gutkv2/oaetcQvQMiO7Hgy8gZJQ43kXaIcRljvMYfkZcRn7DHOT0nYcaciVjcV/bh/
         vFj6MzU5Jj0TCZ4/bVRCLbEV4lIe51nc5nRN2JCaAZwVWJwNH56R6cAiNiClAyMMbCf3
         NLrsHbTaGYiiIFKiepAg1kzCtKURAm01QeA25O5pEMigd5WtdKQsIScvG9pIRyzA7r/n
         aRZqVPyUsuVcma52fWYx01IwzSoAipoEzuv2/WS6tkw0lHQA5fcIwtqEc1Q0uW/RDhop
         fW54rqAlXrfjfuCr4eg3nODTO4juKE/N4pDF0S/momvmsha2FJr/4vxjuMWF3ZtA5rSC
         GwWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772719365; x=1773324165;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GKxSvraDpoad+84dRp1TpOG4toWpwmDod5+UGYBJ7P8=;
        b=ri0zrgNfdwwGISGWUkDvxnQT3KSpfetjcsy9CS8oW+DxoT3qq1j1EGp5mWVX1KhcjC
         RU+MaIp5eikeMRtV9fd/O9OUTZWu02SAH+fCZyD8C5TE+aq+Rjdo37ucBodA709bmA06
         I/UcgZGZO2ucdNjJHLqtyaJoPqiAWXs9J7u18EqUBPjx3gtq0tY4rGtfXmqeRo63bN6Q
         SJKb/Ot/woXjaiQjJxRlbP6WG0O5zAjrL38M79AhL2Mk6HKXguJ0we5MI0jAzS8or9lN
         S4V+XoFS1l5rafbnQ+8/prekUeSkZ60cEAGxL13fKn07nes4enisICZAawhjUKCrVKqN
         otxg==
X-Forwarded-Encrypted: i=1; AJvYcCXqFHxKCB/IM9favuFCFMhexcvEYO8ECuwOdhKBGq0uC7CwZr79S1Mt8grsGx2Pv7O6XgNbxRQiQBKkSajCtBVrLzY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRfWWKXvJ7TtX6FpMWl07uAcr2bRolpmRk42VbZTfX4qFxZa3l
	F09hPpyZ09Q8fqRuf0VjVPTL3NnYbE0Qr1z82jjKcDtA9KD2pbnPcb4k
X-Gm-Gg: ATEYQzzQKg/usx54NTNJpdYugC5d8whq/adJLPSjwg/8D4sBZK+CePGDzt4oHBITRq3
	JkL1ati+f0YSFHR8S77GBPkG1xjqj0ssZTw5pHbQrYdiGJ/t8Za+5OdRTNs7SreWcCTVbIL8hzx
	z7CFyik01GA2ib4k0EqoGHfdsI6+ux860jgDXisBM7bANkjE+nystKM9V5gsijrNf3lF9sF00mO
	YMXo1roRhlUqIYparKTpBJfnvta3W/+F/AObicG3oeip4NPy8J0UxQjYqoj0Mq+MtSkMlIk9Mvq
	2NNBI1sAfkJm4n2ukCdE+KOhzWcfBnN7EJf4RtkjJlYRtC+ZX80xZ84S0dkeFHjIKbxGTUKcTFE
	DNPie+VVRHXzG8SSe6efmTkAWjfjIcgG0buYtZL8O2plFOYkEY78NTv+lN5lXgdAzdYvIGnvG
X-Received: by 2002:a05:6000:1788:b0:439:af81:1b2f with SMTP id ffacd0b85a97d-439c80154b9mr10514645f8f.46.1772719365461;
        Thu, 05 Mar 2026 06:02:45 -0800 (PST)
Received: from krava ([2a02:8308:a00c:e200::d99c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439b34b6252sm34213852f8f.10.2026.03.05.06.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 06:02:45 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 5 Mar 2026 15:02:43 +0100
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	kafai@fb.com, eddyz87@gmail.com, songliubraving@fb.com, yhs@fb.com,
	menglong8.dong@gmail.com, rostedt@kernel.org, martin.lau@kernel.org,
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCHv2 bpf-next 15/23] libbpf: Add support to create tracing
 multi link
Message-ID: <aamNA4bW5on1jD2c@krava>
References: <20260304222141.497203-16-jolsa@kernel.org>
 <625b9bd61d08db7a0cdff51817fe64752c1901d360d73455b609516a0b611d3d@mail.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <625b9bd61d08db7a0cdff51817fe64752c1901d360d73455b609516a0b611d3d@mail.kernel.org>

On Wed, Mar 04, 2026 at 11:02:25PM +0000, bot+bpf-ci@kernel.org wrote:
> > The provided <pattern> is used as 'pattern' argument in
> > bpf_program__attach_kprobe_multi_opts function.
> 
> The function referenced here should be
> bpf_program__attach_tracing_multi, not
> bpf_program__attach_kprobe_multi_opts. This was noted in v1
> review.

I'm refering to bpf_program__attach_kprobe_multi_opts intentionaly

> 
> > - bpf_program__attach_kprobe_multi_opts must either have
> >   pattern with module spec or BTF ids from the module
> 
> Same here, should be bpf_program__attach_tracing_multi.

yep, that's typo, thnx

> 
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> 
> [ ... ]
> 
> > +struct bpf_link *
> > +bpf_program__attach_tracing_multi(const struct bpf_program *prog, const char *pattern,
> > +				  const struct bpf_tracing_multi_opts *opts)
> > +{
> > +	LIBBPF_OPTS(bpf_link_create_opts, lopts);
> > +	__u32 *ids, *free_ids = NULL;
> > +	__u64 *cookies;
> > +	int prog_fd, link_fd, err, cnt;
> > +	struct bpf_link *link;
> > +
> > +	cnt = OPTS_GET(opts, cnt, 0);
> > +	ids = OPTS_GET(opts, ids, NULL);
> > +	cookies = OPTS_GET(opts, cookies, NULL);
> 
> Should this function validate opts with OPTS_VALID() before
> calling OPTS_GET()? The comparable
> bpf_program__attach_kprobe_multi_opts() does:
> 
>     if (!OPTS_VALID(opts, bpf_kprobe_multi_opts))
>         return libbpf_err_ptr(-EINVAL);
> 
> Without OPTS_VALID(), a caller passing opts with sz=0 would have
> ids, cookies and cnt silently ignored rather than getting -EINVAL
> back.

yep, should be there, will fix, thnx

jirka
