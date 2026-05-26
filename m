Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FBF2D8771
	for <linux-trace-kernel@vger.kernel.org>; Tue, 26 May 2026 14:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779805603; cv=none; b=nh5cz0tqems+JWQh13Pp14xvERC+gbgLn6P79MRjOygodDdqW5swAA7bGpi3byJxpEgLRHavRozqBleCB8s+NGDJ7mlYozXWTVW3H0i1KhtgzBEKW1XJ2ZxydBe8hvE/GTpDC85Oy/oc7emiQje8uDpKRfdUuowHuZjCRrw0vOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779805603; c=relaxed/simple;
	bh=YeBVCeauekm9I4EZoE9KgKDLAKsaRIrAyNxRCFPDe0Q=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OmnTrpTIVCLhtzI5z7VYxPfN8YUNlGu2MXERcbZlhL/aZD284yTw/GOz6JVrn6zvHqD2dWpF1yP1JrfF09BWrKWRP3AyIURFloxsF8wAEBtzH6E50xm983zsXQ0zPixOBoQE/Ofe1aoth3BkQ+ThQO6UrSt2EEWr8QBtxF3UMk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KUawmq9n; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KUawmq9n"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-49042aeeb75so56480655e9.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 26 May 2026 07:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779805600; x=1780410400; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UyMYHXc7gW0Hm+VADntLu7+SEKFOAsvci8NMt8Y69Uc=;
        b=KUawmq9nFNY6LYNFtwpPQ5uLUaJZsTJsh3gHPeVoj933QngpNCprUuhI590HG02Ijw
         ixFgwXsux2suz1IAhwJGtEmRvW7YiVVC7GmYpEVLrH4MLXqIc9xVUchEc1LIZYEqW0J7
         92wIeliuoxTL+opCb8ItmLUQCl8LYIeWr8pQabAnXqXW5t8wEZfboGgRrBs+kqLIH9RB
         0w/6AXM9RBFO7EG4yUPGA1WuMVIJ0WFnjlUdAIUaMG5PNciqQzGnXiOpjYfLjz86bzKa
         68KKHXkbAf12BEETYUVoo5PGRvVY7tSzTE9gi4mgs+vtahQuHwsLBko4z0mA770Jtu+X
         k6dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779805600; x=1780410400;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UyMYHXc7gW0Hm+VADntLu7+SEKFOAsvci8NMt8Y69Uc=;
        b=qGQRXuI28AJ7EaLR3SqGMZEdotXDCFwHOYxPrTNsaSmtbzXsh/1jMX4eCHusQuuLKo
         ug5Njm6Ga2H3O5SO/YijbeLSq8n0cHpijOyQB6Bqr+GtG4j8F7mr1F9mPERTEBTJIb8D
         hr5K1hCcxeRhQzm5qM6C1ruVjwv3uXkEBAc2VmJetbjgVvRXEEkcf+lIek6YDrLJVdZI
         dN21jFb3gogZeqOAj9oEPijNFXhU/M2sMvNQ1FZSITKCOahYM3OazJ0GLN1T6zsapbYu
         jmxdMKmsAoWXgB+xtJJkHBXU6YHjK+A2J6vrZXlVMvrG8VEjahsVg/I53UWW4d5qSSRe
         JmQA==
X-Forwarded-Encrypted: i=1; AFNElJ9urm5ROf8/+HKrTUCcXh+Fx0fYTrHQXQIv9smlF+n9rzCD7Oj47px9HEw23tescBCd9bNo9pbpcc0i8x8cftK2Pkk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3N5+t02Nsj0QCL+lBnkF1mnxo02su4G0tCgYLxUsqlimpxycf
	k9jM/pC2v9pQyPrHZ9rS8fepx1CTvJSyVvZXuSwmbUjCkD7PCFdcOA7T
X-Gm-Gg: Acq92OHzwAO++draINMX5s7FNkI8Ndg1DgnYAuVyoN6YoA+18qcRXQzchqEQ7TXNIf/
	Mdln1tLxlfGi0DFkD3G5iqAvGCNcOV+guH91kZcjBmGLPpeVnT+UzatlLLyJnleZpwEmZ7NIKEt
	UE9HaYERxFzUd/3wEDxU9gt0se0YhbFm1rPidsX+Es8iLBYd4N7X4kbEqRfTjKx5G5DQgDCDk/Y
	2RzfljlQ4UgdtHSrI4DBYiQwDBxHdttzOZSYWdfN4CXXCZyZ0+Fu479pGwFNRAXYUk3Da4vYZyv
	Gub58VdG2gp3FiO1+9Wz0EzYgG8ZECzK/qWBstyoEJPePMgiIms8qJEQxyGKQyoF/cYOr69ZADt
	5mKVJVmM8kml2UBEZyVc2RcKQoLNda+HF0VFvqXNhZCEutbJI9SNU027kuntZg+T3u4TSA99Qzr
	mjllTT3zsIbG1UaMM/
X-Received: by 2002:a05:600c:628f:b0:490:5057:f602 with SMTP id 5b1f17b1804b1-49050580d79mr258141665e9.17.1779805599766;
        Tue, 26 May 2026 07:26:39 -0700 (PDT)
Received: from krava ([2a00:102a:403b:6530:533a:f167:d705:6aca])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6d71688sm37991070f8f.33.2026.05.26.07.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 07:26:39 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 26 May 2026 16:26:36 +0200
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Jakub Sitnicki <jakub@cloudflare.com>, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCHv3 05/12] libbpf: Change has_nop_combo to work on top of
 nop10
Message-ID: <ahWtnED2e7RU64B4@krava>
References: <20260521124411.31133-1-jolsa@kernel.org>
 <20260521124411.31133-6-jolsa@kernel.org>
 <CAEf4BzY3bV+gkA4fRm=jzaTowG1QtXogLDOKkG3CrR5EWzDPcg@mail.gmail.com>
 <ahDKatbb_ixUY_XF@krava>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ahDKatbb_ixUY_XF@krava>

On Fri, May 22, 2026 at 11:28:10PM +0200, Jiri Olsa wrote:
> On Fri, May 22, 2026 at 11:52:56AM -0700, Andrii Nakryiko wrote:
> > On Thu, May 21, 2026 at 5:45 AM Jiri Olsa <jolsa@kernel.org> wrote:
> > >
> > > We now expect nop combo with 10 bytes nop instead of 5 bytes nop,
> > > fixing has_nop_combo to reflect that.
> > >
> > > Fixes: 41a5c7df4466 ("libbpf: Add support to detect nop,nop5 instructions combo for usdt probe")
> > > Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
> > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > ---
> > >  tools/lib/bpf/usdt.c | 16 ++++++++--------
> > >  1 file changed, 8 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/tools/lib/bpf/usdt.c b/tools/lib/bpf/usdt.c
> > > index e3710933fd52..484a4354e82b 100644
> > > --- a/tools/lib/bpf/usdt.c
> > > +++ b/tools/lib/bpf/usdt.c
> > > @@ -305,7 +305,7 @@ struct usdt_manager *usdt_manager_new(struct bpf_object *obj)
> > >
> > >         /*
> > >          * Detect kernel support for uprobe() syscall, it's presence means we can
> > > -        * take advantage of faster nop5 uprobe handling.
> > > +        * take advantage of faster nop10 uprobe handling.
> > >          * Added in: 56101b69c919 ("uprobes/x86: Add uprobe syscall to speed up uprobe")
> > 
> > Would be nice to add commit that switches nop5 to nop10 (but until it
> > lands hash is not stable, so, hmmm, maybe we'll land this patch
> > separately? send it a bit later to bpf-next?)
> 
> hm, I think that would affect the subtest_optimized_attach usdt test
> which depend on this behaviour, will check

usdt/optimized_attach will fail without this change,
I'll make note to update it later when we have the hash

jirka
