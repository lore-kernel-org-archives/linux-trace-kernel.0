Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E85022A7E2
	for <linux-trace-kernel@vger.kernel.org>; Thu, 16 Jan 2025 19:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737055182; cv=none; b=tV7/dShKoXikZTggj2u2t/Xcz1iXotavOjVi2qY6VCCp+E+aHxTugBMrRIDiYXn/cEWbQR3S+KvinQcIGyX1NLVhGAjri9oHPpQB/V6Epu1WEwDteG/HrfbEyXNFAHq+bqCInkpfYjaBnzORo5Pw80HUELj+HoGyLjmzQUs8Wc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737055182; c=relaxed/simple;
	bh=ItsA9WAJW3Z0yXShllb7DAx8lDn67Fd29vJcuLxBrIM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m28FgEn6NwawrNFLOZhkN/FSw7PkEK6hY9bf7OF2t2fiSat6O9rVYq8elYEQk4nioG06CEcUMz06afJ5VV3F4bqo383Oh68zX0+lUcuM7TmRCj8MX+mOEQzIhDrwSRT+eQUPjqgpUsG/9AL6zbaptYPCTnvPF/hPk65HufSNzho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=DTXP7Ama; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DTXP7Ama"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aaf6b1a5f2bso475476366b.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 16 Jan 2025 11:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1737055178; x=1737659978; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6gcQzKPEsH7SJLFz3SKJ8LnmQg3nduMJmA39KnbM02E=;
        b=DTXP7AmaJ3CXkj1otgOKqdDCbAW2NqhcjpbszE0Kt6Xfz8gSKsnFf1VYldrTWtuzht
         uMXsEWWhnSQcs0uj9xKy0CV+ijrSU935GWtIUXHhcksGmJO9slDWq+MjLXw0HOkampwQ
         7Nsz/5tYc45+YbC7aPPD8G5ZCDivhQdo0IvjA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737055178; x=1737659978;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6gcQzKPEsH7SJLFz3SKJ8LnmQg3nduMJmA39KnbM02E=;
        b=wpFATvffgYexWfExJ2QovjQG3OjC1DeOKM41OMvQD+AtLhJ5ZXKuGhcfun/NGaVJ5q
         rebMYqCH6FPbyOpTbd/MHNtGP4Gy7McegY8T9v9+EqTzOUGioIDxyh1XTwMD5sjSuvep
         XFEqpAqH7g+/TCZyKJYnVIKV5RzshvhLj5il/ma1jpnrPhHp17iYYksmA0FmVedmgBnk
         d/NtaLhQVDmQOFkNEBJ7c1QhPkFZ950nksgVCPSZMV9lB8lf2WfsprtTZvs3juIBBM3b
         Uw1PuKX1Rauoj8Sa/nwsyRTY2+LUr4ddKOMbuQqB2zZWIJYF76KX2EbCv4Ht+7NtiMIA
         dliw==
X-Forwarded-Encrypted: i=1; AJvYcCVo8FVUYaVBA8gpZsSmDyHjSG5hRPkk6MXo4ZWUbxNhGuYffJonxoTJiokTO89U5D5HcBt3UApznQiZppuEvFplQBk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGigT1670azBNoF+M6lr8jRrOck4rtMUEhKASXpf72NtXGNIGA
	H6noyj7VoSUPZDahlybWu7jlb/kxpFbsJG7yhjghQupbpXvQVLHmN0cy/weZjmdeQWxIwuFGqMB
	NzCM=
X-Gm-Gg: ASbGncuNpLdMjvnPgGXxZr+Y/3feZI86oxqL/JAXelNJUaktWje3/dzywss+Se69gI1
	2cZ2Ldt2Yv2lVHsaQRNfcCNi7os+gKGisMJdtnDUpocJMwFkM8AgorsP5ExgLfycXrrtlyILXF0
	fwDVDGfm8JYHM8h76zxMuzKv0oDN4yRxYwXTS/ZMO8c1JACtWpVVaLaUDi00L+rJngXwb7RTjc2
	NChWbg6o0RGjK6OneFNR83YivDcyvz/oIfB0howoBlbPPbFO6H8Qx20K/qWc11Ld+cjgCN42dRq
	9cpg3p3h/FoaTryguKIDq/U88X6h01I=
X-Google-Smtp-Source: AGHT+IETVhMMt15y7axaT2Z+Jnp9dvg72ybhq4zRpihEtXQuMN6urRx0TwZnbHxEBZV17555IM1+EA==
X-Received: by 2002:a17:907:3d88:b0:a9a:e0b8:5bac with SMTP id a640c23a62f3a-ab36e479c00mr380009366b.23.1737055178485;
        Thu, 16 Jan 2025 11:19:38 -0800 (PST)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab384fcc926sm35726466b.164.2025.01.16.11.19.37
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2025 11:19:37 -0800 (PST)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ab2e308a99bso288232366b.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 16 Jan 2025 11:19:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUHy5pRhIz5PbeXxZ5vbmmUa+CBGFA/3f19bwSPBweb/oawJeReoYgYT4LTECpCPmhYs5IfVTRI3w63Mon8zghD0vE=@vger.kernel.org
X-Received: by 2002:a17:907:268a:b0:aa6:938a:3c40 with SMTP id
 a640c23a62f3a-ab36e479602mr443599066b.24.1737055177248; Thu, 16 Jan 2025
 11:19:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250116132359.1f20cdec@gandalf.local.home> <CAHk-=wiFEeyY5HE3NMvDYd254yHynzaQyzwYhv5gzRj7KU+gjA@mail.gmail.com>
 <20250116141800.31d519eb@gandalf.local.home>
In-Reply-To: <20250116141800.31d519eb@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 16 Jan 2025 11:19:20 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg_2zXOKH2kDAnAyvC6MDWWgyuMRqQDNTGzKJBhfVzHVQ@mail.gmail.com>
X-Gm-Features: AbW1kvYN_xkKuoMBiyXoBE-Yb4E0lys8CoCXX5qnJ0myflXFLJitmhUkkLkbhmw
Message-ID: <CAHk-=wg_2zXOKH2kDAnAyvC6MDWWgyuMRqQDNTGzKJBhfVzHVQ@mail.gmail.com>
Subject: Re: [PATCH] tracing: gfp: Fix the GFP enum values shown for user
 space tracing tools
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, linux-mm@kvack.org, 
	linux-perf-users@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Michael Petlan <mpetlan@redhat.com>, Veronika Molnarova <vmolnaro@redhat.com>, 
	Suren Baghdasaryan <surenb@google.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 16 Jan 2025 at 11:17, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> But they are only defines, they are not created until used. Are you worried
> that it will slow down the compile?

Yes, and the whole "pointless noise" thing.

I *look* at header files sometimes. I don't want to see pointless
noise that isn't relevant to the context.

This is not relevant to non-tracing users.

                 Linus
