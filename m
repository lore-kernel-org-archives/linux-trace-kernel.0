Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DC51684AE;
	Tue, 30 Jul 2024 07:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722325349; cv=none; b=YMVN5NWVSAggudsfMQGrSCPNm4PJz/Nv64TQRplFjqO4Czk+3GuaVIvPQlELO8JAerOgLbrshg6IM5yXBIEsTjCPL08fmL7i0R8u39z5e1pwW1wMW+NadF3Ab0Q1Q3DvgcQYFDcNStoUdbWnEJ6TuciI7ZWbTq2Zb3X7wCRuyr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722325349; c=relaxed/simple;
	bh=JFYQ/UJgEfHYHCFp4FpTRpXxVcfpIEej3xVIW2+dB9Q=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HtQF4gn5mIxinfqCMFk3we7bfigI5odNABC8AjAbXy7Df6Ol81rE9zniZpSjIOhjnRutV/CXEGs7+qwT5iuhcYHXNMWnGLq4oin5KBEVDFcFdP0qEyjxfaHhP/VVnQv/sqoVQt19sXkrYTcB/YwwvFUkyRxpMGMAJWLpA0ObPFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xu7DRNDy; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xu7DRNDy"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5b3fff87e6bso990585a12.0;
        Tue, 30 Jul 2024 00:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722325345; x=1722930145; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kUbf8GIwSRnWe7hexy8P3dCqay1/ElftSE2lOUOGwO8=;
        b=Xu7DRNDy42va3birqmefgn3Zre1sCeBKboOdmQmie4ywT2dU0OVSwRO/pMsMrz7AW0
         pDuLaRzvnEj8nI92FEh5cve770tf603rPVVZKhFtn+8gfuLX6GZ7HdJqyVEFxDmVg38E
         0cB1iL26DJj6JRMFWhm4npJK3nAjQfZHzxq9F1SbDKbuncqb8oOdNB04+TJKxlIMjagP
         dsCAvKUmX0zYVm03zVd3SRxwVb5ntA8Nct/ZGDZOpZ0xe7XnhziPr4CtfGktAg311wfQ
         /d9hmDvixN2gM8EvF5OErGEWgqwRXqFMGPsoAQVf35E45mKpY7Px0GLeoOPDYeDlqjX+
         Od0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722325345; x=1722930145;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kUbf8GIwSRnWe7hexy8P3dCqay1/ElftSE2lOUOGwO8=;
        b=rPZCOBSbTMi0OCGGgcdbBfrjhOGS9+ek+X7rRUfQcxMXQ3gy/kDjSlxwCs7l7cY7I1
         H/ALSuGArbl99+SIL8Yf/qCC0KpRBCCiz1PP0yL22oCeglLiW5EtW2sRzI2dKIPQiFl4
         pkYCgRZ6pIQ660eMGEPupTDH1MwxcyEhAHdHEZs5p9Onzm0J9lwnXkFW9KpOj9p1jUzB
         lI6t3rfJ6kvDxkBLud1ay1cHtbnD5W7j6mQ9tTVDK/4+ElxbFNXfD/wSFz4tC3i+UJSz
         dXfSr+X2ZMQ62EI4UAF9KgQwUS1YTzmEQJ6md+xloe1jDM7hpYuIk/xTWuxMPMAPNx31
         +TYg==
X-Forwarded-Encrypted: i=1; AJvYcCXMhV1lHZhunh8n7kKc37WPMYxDoxgOy2zXBeaFyXM8z71WLW2ci9OUCj8tuNzWUAzk6le9foz85WPsMiTrHh1s/6+r6PydeEILLGh/qRBlFvFp8uBdALpWiDqhlRnDRKY+dhW0z+OROkpjOv99JSLw
X-Gm-Message-State: AOJu0YxBj7vMI1Kceb6Ucla+0PZztSo7G1xN3wtJtJFEa5lyu9cP1D08
	ebvh1Z/HZEW4nN8Wwh6/n7MHVdBPSFWp7VG0pE04cCkWxd5q7FcH
X-Google-Smtp-Source: AGHT+IHat1Z/UOAI/SM/OvQ5yfSvR65C87rOxphO40/cQVm25UuNa7KhLQqLWXKfwhNcQx5e/cjcgQ==
X-Received: by 2002:a50:aa92:0:b0:5a2:abcb:c4cf with SMTP id 4fb4d7f45d1cf-5b020bc1a42mr5272678a12.22.1722325344500;
        Tue, 30 Jul 2024 00:42:24 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac63d4720dsm6882376a12.58.2024.07.30.00.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 00:42:24 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 30 Jul 2024 09:42:22 +0200
To: Oleg Nesterov <oleg@redhat.com>
Cc: andrii@kernel.org, mhiramat@kernel.org, peterz@infradead.org,
	rostedt@goodmis.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] uprobes: misc cleanups/simplifications
Message-ID: <ZqiZXuVi4ERJA43l@krava>
References: <20240729134444.GA12293@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729134444.GA12293@redhat.com>

On Mon, Jul 29, 2024 at 03:44:44PM +0200, Oleg Nesterov wrote:
> Peter, I don't think these changes can really complicate your ongoing work.
> But again, if you are going to send the next version "soon" I can rebase
> these cleanups on top of it.
> 
> Andrii, I dared to preserve your acks, all the changes are simple.
> 
> Changes since v1:
> 
> 	- update the comment in register_for_each_vma()
> 	- remove the now unused "struct path *" arg from bpf_uprobe_unregister()
> 	- forward-declare struct uprobe in include/linux/uprobes.h
> 	- kernel-doc fixes/updates
> 	- fix use-after free in uprobe_unregister(). See "TODO:" in 5/5.

lgtm

Reviewed-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> 
> Oleg.
> ---
> 
>  include/linux/uprobes.h     | 22 +++++------
>  kernel/events/uprobes.c     | 96 +++++++++++++++++----------------------------
>  kernel/trace/bpf_trace.c    | 25 ++++++------
>  kernel/trace/trace_uprobe.c | 31 ++++++---------
>  4 files changed, 69 insertions(+), 105 deletions(-)
> 
