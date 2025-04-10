Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411721DC9B0
	for <linux-trace-kernel@vger.kernel.org>; Thu, 10 Apr 2025 15:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744299405; cv=none; b=VWPI3I5Vgnsft9rlqX3BybLD9zN3Acf4FRy/yde4sT2zCjqNd+14jFICb9AQdZPnG2G+pWyeQVngJhQxOJN+DEodXmsNqITb7a/HEi4bhuuoyw/UkwgZic33h5C9eM5XrjEUDXVOVDVR1hZZ+bbc1jZHi9DyZMLxnSHJ+sieewQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744299405; c=relaxed/simple;
	bh=FmX3aoH1aBtX5KhUCEOGKZyMyiYbfK3Hi1ItVvkoEzc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LVcruFt27nWpBIHe4sNUSWMbvcgEZgkn1+VpQMl1INKpC9Dmk/Gd/aj9IGG8rN+8IWPToQNs/2w8kHj0kWyMkkDO08NTLKtX5pcmm6SGMan2wplRh+d/1CB+7sLt1PqeJY8DmOvFnLbMFUjTYEcQi7g/c54TAgU1wuCy61xy5N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WzRzuuVG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WzRzuuVG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744299401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t+uixq6iFVjeynAJZ/kgd5IdlPdxMY+eI4356Zi/haI=;
	b=WzRzuuVGq+sxVpA9jX1Nvn9qO5eKkXWhPjPvNAUOatbbAhWEu/hQAYwoNnKFdqH8UOBtvV
	b1HlVHqCFbQh+FiHlEZgL46f46Etq3ggO+LE+q24FNRjcPwvavdrjsp4PwRkWAkbK3M7WS
	WlyeeGAPCJST8G8TR9GjFSJYpbB9+Y8=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-413-JiScko6sMd-2fOjXCNmkHw-1; Thu, 10 Apr 2025 11:36:40 -0400
X-MC-Unique: JiScko6sMd-2fOjXCNmkHw-1
X-Mimecast-MFC-AGG-ID: JiScko6sMd-2fOjXCNmkHw_1744299399
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-ab68fbe53a4so136100766b.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 10 Apr 2025 08:36:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744299398; x=1744904198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t+uixq6iFVjeynAJZ/kgd5IdlPdxMY+eI4356Zi/haI=;
        b=uyWQfaPky1Q6XdgLhuhVi/JB5+h1v2K4r6xEZNXj4P9LEwgEbrqJI49rpwQAFr8Nav
         Y2TbJ2UebMcJIJJZ8xx0PPsxT9+01mQsFhXJ8NiBj5vYHXrFnxkA4bsZSNyPIqakAzHa
         lMiS7rbFcLBB8fbEURMqsIYedJtz377U1wflF2hlFcnN2WZ3cG4safZQHEinqjV7CP4J
         X2ePLMtxOawa8CyIXzWJkk/jjxNG7th9iucxOzBEh493PevDFen2yzAag5uMgxKgjOqD
         CDuNRgvjf+r7oYyMGuoSm12lk6eHleGpnnuCsZxN5vwIvMNruOW8zk/KcsG3WpQGmwuR
         KWCg==
X-Forwarded-Encrypted: i=1; AJvYcCVu3LcAiSXEBXBK7bOlfA9mz3mcdmG0PjElF3bpZX3RQyY03w1SPZ63K1LWDKYw29lV7JLPz9GWVGPrSBh8GUuuSHc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDYOwsQ8FSl1vOWdLkB0U7EbykFIaRVchXJQpps6STOI4Nz8OE
	/Hwq8k7jIwVJtpfAKOt0R/xiJD91MAZdVNP4JCzmtxU1tqI9hMe8mcWU3GSZEJs8F1DpMKH4bSj
	5bGEpjWz6MQSse/SuJNUwTxXjr14cL0W2otvd3NvM77yq8PUXXtVTSltNZ/j46ljcdbWJjyOHRW
	wAEtIQBOdoolZpDBTO6E7KIU8XrB0GpXYJM5GYb8hIe5saMGUB1s3zunE=
X-Gm-Gg: ASbGncsPWk+SZ2eifRiQSyvvOCirJMEwqL3oIrG/z5H+oQe/hjPhoqvNCUw0brn7o/d
	UvAwVJJKRiGwc+U7ZZJayJKPjoDk5mwvYhdcdv+hmeJ+twOeaMnTJfuMJNhC16CY069QN
X-Received: by 2002:a17:907:2d87:b0:ac2:7f28:684e with SMTP id a640c23a62f3a-acabd126b90mr273866066b.6.1744299398267;
        Thu, 10 Apr 2025 08:36:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+XC/M6wH9xagKDAi9bhg9vzgdhpHdMgqtWeDFPDrWeCmSsw/+nm+DFGhupT4ZrKArw6KRhIOnbJXaUYZxK1E=
X-Received: by 2002:a17:907:2d87:b0:ac2:7f28:684e with SMTP id
 a640c23a62f3a-acabd126b90mr273864766b.6.1744299397942; Thu, 10 Apr 2025
 08:36:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250328183858.1417835-1-bmasney@redhat.com> <20250331212337.3e9e4a5c50f5d3f16a95b120@kernel.org>
In-Reply-To: <20250331212337.3e9e4a5c50f5d3f16a95b120@kernel.org>
From: Brian Masney <bmasney@redhat.com>
Date: Thu, 10 Apr 2025 11:36:26 -0400
X-Gm-Features: ATxdqUFWXGDODT6yTtCf6BC2LWlH7sonW_FuG54wwjQcn0T593Jielx3o6yMKTs
Message-ID: <CABx5tqKFzi2-_eTmQ1K+NvW+TSZOMUz83+Z0NHb7C2FEut23UA@mail.gmail.com>
Subject: Re: [PATCH 0/2] tools/bootconfig: allow overriding CFLAGS and LDFLAGS
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	aruiz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: t79swAYFPp4pYliOQLbFofp4LmZHx6dc3It-C9QjJiE_1744299399
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Masami,

On Mon, Mar 31, 2025 at 8:23=E2=80=AFAM Masami Hiramatsu <mhiramat@kernel.o=
rg> wrote:
> On Fri, 28 Mar 2025 14:38:56 -0400
> Brian Masney <bmasney@redhat.com> wrote:
>
> > Allow the user to override the CFLAGS and LDFLAGS similar to what's
> > currently done on other kernel tools. These changes allows bootconfig t=
o
> > be compiled with the hardened compiler and linker flags.
> >
> > Brian Masney (2):
> >   tools/bootconfig: allow overriding CFLAGS assignment
> >   tools/bootconfig: specify LDFLAGS as an argument to CC
> >
>
> Both looks good to me. Let me pick those up.

Should these show up in linux-next by now? I see them in your tree at:

https://web.git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git/l=
og/?h=3Dbootconfig/tools

But not in the for-next branch.

Thanks,
Brian

