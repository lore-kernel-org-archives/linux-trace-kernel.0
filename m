Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765751662E4;
	Thu, 11 Jul 2024 14:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720706624; cv=none; b=hy23e2YagWkj9O0DmFrHv64PIaWyyMOAJihYuMpxJa6VvpGvUsEQXkUZm9bzKmF8U40Coxan3aUN50BRz/rIUWy9u+XUhJFtYpyz2VurRCcMgtnSd5TZqBqCtpW+gwNS1TwnXr3IA85dB9STz5lLq4PQk+CqjJmvx5bwgAv4Al4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720706624; c=relaxed/simple;
	bh=7KJKA5WnelP0naTDs9BftH58QdMl6/EE8+GggC1qNWU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vt6bF3dC0mJA4yP4XduzeigfZxty8Fn4U86nnglzwzmR6iWnn/ph9IUfblJTD9REVmVxz4hZBS8qhcAxA8mO1ItZChGZi8x5jFyeNTEK7K30dvX+AZq0M3JVlG322elVLDT1W2ZRmimT/Mp4ejNaEhply5ucLvTvURYW6QLrOwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZtFGm1Px; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZtFGm1Px"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-367e50f71bbso642561f8f.2;
        Thu, 11 Jul 2024 07:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720706621; x=1721311421; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9YjqhU269+3cJPYEyvFdQ/uaC0QT+4BYwj2LLH95SSg=;
        b=ZtFGm1Px9gFEF/t4lDM6wSyHWGritk8HkDXYhJlhMDXHnwo3zLvAxlhzfyRt+SHJAo
         ZeIuohaVfCFhzz3a00fThDncfz+5TOcZP5D8Ztnw3uGVw4kb9JaCFPc3fZoD9X8DvSps
         TmrB7kWEZpLizYhCKDZzsIbcsRZpemZpyYKF45icKc9+wwhNq3R9I1XIA+sz196vjpGa
         PSM+PTo4jyiI4BJUCJrvLaSJ4fx529j6wqsIFZQqdKbg49yctSuMXikidWc+D8MSiVfn
         O9wevOEAYn0G2DFvSfrYm6DC8Xsc7PyZ4178bMOCJpm5Wtovu8R/TXIFVZ5VFcZOXNW+
         CLxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720706621; x=1721311421;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9YjqhU269+3cJPYEyvFdQ/uaC0QT+4BYwj2LLH95SSg=;
        b=ha6+RgVyY7AVcztphAZFC0m/QZGMssHXjlTNzvwvXTxGnQ883xjFL1ZioOHdFmSZfJ
         kyM234/CoNAW9dGB52m/wTNWhn9dYyOzLE6Z6jVxanZ1a7dXCGFAHQEtLy657JveC12m
         lJ3BmdBgfhRSqt60J6lGtlKQIN72IUf2vtgs6jg7UFf65tNZyHecGNx4XAxj/hStImRb
         H+D7BuJMyESiZz6/EyVPF8IKGEiP8+aFpmU6cMscQb2rTCbRZg9gl+n4ht7fUQaMxO2V
         Z2wr6CzOLyq930Y6HaPy2Sg+SUseH2q+RcBOjr9IOSF3lmB8peFJ4HgUcko408e7LeHH
         KW+A==
X-Forwarded-Encrypted: i=1; AJvYcCUow7WMIdoyI0Ojr96hbI3U4+8YXphDrl8Lg3GO+RrZQ/PgAsBZdjxoa1B9RXyX18hbZ4g0vk3M/zX2VU66ZvOS/b0c2OIpuXvMWGP7biCHVylj9AYcWybuRMsLuXwPqV0b8aYTIQ4KEvnRZ/DNSSRa
X-Gm-Message-State: AOJu0YwBzl8f3V3NAVO/csN0a45P9QX9jfyvIE07lU3SOcFbiiiyjpWi
	xpjWPy5uvzsLhmVTahKZQYmzBKMaHWzb/uNA6+iu3YGGY6URrpV4
X-Google-Smtp-Source: AGHT+IHjiJSdEvAdeHEu4FiABXz4APLMVNg4dGmYtCPhnluv1pbp8IMg3UQLH4tNX25fSb6fw415aw==
X-Received: by 2002:adf:fc0d:0:b0:367:8fb0:9c89 with SMTP id ffacd0b85a97d-367cea6b83bmr6437717f8f.16.1720706620502;
        Thu, 11 Jul 2024 07:03:40 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cde84707sm7757101f8f.35.2024.07.11.07.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 07:03:40 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 11 Jul 2024 16:03:38 +0200
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@kernel.org, andrii@kernel.org, oleg@redhat.com,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	rostedt@goodmis.org, mhiramat@kernel.org, clm@meta.com,
	paulmck@kernel.org
Subject: Re: [PATCH v2 08/11] perf/uprobe: Convert (some) uprobe->refcount to
 SRCU
Message-ID: <Zo_mOuq9Gr9CzRP-@krava>
References: <20240711110235.098009979@infradead.org>
 <20240711110401.096506262@infradead.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240711110401.096506262@infradead.org>

On Thu, Jul 11, 2024 at 01:02:43PM +0200, Peter Zijlstra wrote:

SNIP

>  	/* Tracing handlers use ->utask to communicate with fetch methods */
>  	if (!get_utask())
> -		goto out;
> +		return;
>  
>  	if (arch_uprobe_ignore(&uprobe->arch, regs))
> -		goto out;
> +		return;
>  
>  	handler_chain(uprobe, regs);
>  
>  	if (arch_uprobe_skip_sstep(&uprobe->arch, regs))
> -		goto out;
> -
> -	if (!pre_ssout(uprobe, regs, bp_vaddr))
>  		return;
>  
> -	/* arch_uprobe_skip_sstep() succeeded, or restart if can't singlestep */
> -out:
> -	put_uprobe(uprobe);
> +	pre_ssout(uprobe, regs, bp_vaddr);

pre_ssout could now return void

jirka

>  }
>  
>  /*
> 
> 
