Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C92E3E834C
	for <linux-trace-kernel@vger.kernel.org>; Wed, 27 May 2026 09:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779875911; cv=none; b=YR674pgzOazzO6LdYkaj+Cm56L+6lPToNdMERb1AVVjimAXBsQi2bb/x6dbNKuLziJ35Ptx3ihSo9FRNDAXumvZfn5Zv0Nd2gPu26rpArz9fhKDUSC1sgXrG++rgZP/nahtyHIYXPml/IVGslgJU/3VC60XY28DfjRWzGxoRb3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779875911; c=relaxed/simple;
	bh=s+yPe7No/7GmDOI11CX93j1HW660H6AudQ7GSwyQM7U=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s2beKemL0xemSCp4Lwa9LzrAOCxT2mFt/tDFHo8Xzh/8PMDxf35gMl0XDimcT0skyKEfmnP3nlDsqmYqsPvMMFMsbJc0NsUoXVB6wz8fBeuMTz0q3CFz+8Nhu2ArMv+e2XusY8yCZHU4yUsqbBHZu7lTrkRZ13fXk0Zw62zIGjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YYwxSKdK; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YYwxSKdK"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43fe608cb92so7034088f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 27 May 2026 02:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779875909; x=1780480709; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YikjwhEm4geCtrb1bi/FLWqvUb+NITExv3m94HQTTGE=;
        b=YYwxSKdKn+K1MGPHQlUpTiYdxrWGtuJTYa7tlEksqnR3qDvp9QDcRh0I9cMa9h2CRN
         EgzxKZj2fQRiAkVjx+cMhTeAN/dHwCKKMS3Lm6f/TpYUwwQ/uHmWXDZda8pgkBU6B+8N
         dfQT+XvcNQCv2a162FsOTvGotqkCkMt0qbZjwTPXK2zX1MQA6fEqiTaN2NvuoVo79zSR
         ljKOdnPdtpFGX0zGkN+x58szqRdERy++TA9rpJix4IU41ityNx352qzUn8Bm6Lv/2rMi
         Kvse3kfygyaGghxGx5VQFMW7hrTOh/0Pc+FvYrYQxn4I9BghZMHwVW9z2EZAXG3xlzlA
         xF/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779875909; x=1780480709;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YikjwhEm4geCtrb1bi/FLWqvUb+NITExv3m94HQTTGE=;
        b=JXqmLDCzOOti8Sdxj1g5TOXFywE0+wOoZSNsQ5p9l4fmK8z8D8HtZnSqNUWiDB50XH
         fmyp68YqF7QSfYTFRGuN+KTW6VSkUawVrKPfmJWDFd/yPu9d7UVMQyZFuQCBYcDoeYnL
         fMdtHyzBSgkwLD+1dL8dcMkfOLeSFubPfxRhnGYlA3ogWKBjZ8JQd43d2Lg9pTSzCABw
         1Zba3YxZxUchmSOu57pW4GaJV+UKQr6rosrPREji5RkfA5E2vCmtApsSf25G+CgHsfgF
         TRrP6vW5to32dJ33SWAJltBZG4LaJ2H9gveOatgtEN6Q+YJ58VaRFmp7UYr9PpS/Ki6S
         VsxA==
X-Forwarded-Encrypted: i=1; AFNElJ8YtJwoTZvGN5eKNyuRKctH59rcOswf1aCrSE7jQfM2iW0LIlpHUXwwzEz9Q1hC61wsv2yMA3ro/HI+At2t/tHSgH8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxp2AiaEkq/8p52xHHbYrD6Dv9sy0HzLiiBMHQhJ7IPBlcFpWO
	/x7x/xLof2pAxft/hTuV/9znkDjRaUo6tUXZ4ZV8xyd96+ubYcmvYBI+
X-Gm-Gg: Acq92OEcaH+InTtD3hPeP5hHVz3u1XKkJqn9MoYLRrjyLpTDi+VPpJUlFBEWL2PvRLy
	3NG6p4JXBY5fj5YDjPTHFo8sM/ZmeqzyT3TjceUa35zytTCSN8Sx4ePr8J7NW1Vw3ZgbMg3Asqv
	EAfXuS8G8QKts9rCDv6kaGiz0I34zAa3AM6wBdkIS+81BM0fbUP1Wf3K3f0kvDdeXn0D8npz/oG
	YTfYGEtzwHJJBY1pNSLWZMtcdVx2dKG33MAAbnIqNjSXcp0U0OCKJ8ChefQ3uZdPokvl+SSmTpH
	r/Fg81XbdkoEMLV4tcTukmoXd6iUfiw52HmKQRiaJ+W8yibR7GAtXhOThXT1OO8aUNj1+cEP/eG
	XuoRNhaXI6+KleZuUL8yiGJqkIiAFw7afu2xJAhLg88RjdpF6MJtB3i54M9EaxHOvxkCNGUcL0n
	6xhuKD0Ca3Y5zhceM9l90ny1QuKw==
X-Received: by 2002:a05:600c:6296:b0:490:5321:2466 with SMTP id 5b1f17b1804b1-49053212604mr277702225e9.20.1779875908611;
        Wed, 27 May 2026 02:58:28 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200:b655:ff13:e355:16a3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490838f7f35sm17953515e9.1.2026.05.27.02.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 02:58:28 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 27 May 2026 11:58:26 +0200
To: bot+bpf-ci@kernel.org
Cc: oleg@redhat.com, peterz@infradead.org, mingo@kernel.org,
	mhiramat@kernel.org, andrii@kernel.org, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, ast@kernel.org,
	daniel@iogearbox.net, martin.lau@kernel.org, eddyz87@gmail.com,
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCHv4 03/13] uprobes/x86: Allow to copy uprobe trampolines on
 fork
Message-ID: <ahbAQtZb_Gys_YlB@krava>
References: <20260526205840.173790-4-jolsa@kernel.org>
 <aa6bd23387138013e5b10a9d9bacf6dfbcf9a2981ddb132a3d29e3c8524c65fa@mail.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa6bd23387138013e5b10a9d9bacf6dfbcf9a2981ddb132a3d29e3c8524c65fa@mail.kernel.org>

On Tue, May 26, 2026 at 09:46:40PM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
> > index 733655bc610e..c8af41ed681a 100644
> > --- a/arch/x86/kernel/uprobes.c
> > +++ b/arch/x86/kernel/uprobes.c
> > @@ -697,7 +697,7 @@ static struct vm_area_struct *get_uprobe_trampoline(struct mm_struct *mm, unsign
> >  		return ERR_PTR(vaddr);
> >
> >  	return _install_special_mapping(mm, vaddr, PAGE_SIZE,
> > -				VM_READ|VM_EXEC|VM_MAYEXEC|VM_MAYREAD|VM_DONTCOPY|VM_IO,
> > +				VM_READ|VM_EXEC|VM_MAYEXEC|VM_MAYREAD|VM_IO,
> >  				&tramp_mapping);
> >  }
> 
> When a process with optimized uprobes is forked, the child inherits the
> optimized code and trampoline. This means sys_uprobe invocations in the
> child will go into the uprobe trampoline, and the syscall will keep
> returning -EPROTO since no handler is registered.
> 
> Is there a way to restore the original memory pages for clones?
> 
> This behavior seems suboptimal from a performance perspective. For
> standard int3-based uprobes, breakpoints are removed via
> UPROBE_HANDLER_REMOVE. Could something similar be implemented for
> optimized uprobes, perhaps with proper filtering in uprobe_multi?
> 
> Reference: https://lore.kernel.org/bpf/CAEf4BzYo-8PAXFJt9MHoUn9ux1O2YVxJADC0tGSsacVu_R8Stw@mail.gmail.com/

and I replied in that thread that we can address that later:
  https://lore.kernel.org/bpf/ahNzlAfUnymDDGOR@krava/

jirka
