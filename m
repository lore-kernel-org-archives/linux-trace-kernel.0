Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90D53E462
	for <linux-trace-kernel@vger.kernel.org>; Wed, 31 Jan 2024 05:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706680667; cv=none; b=ugzCuIDFgNY+/DVuw1orjxcM9gugxQLnUznNagxaN3Pxhv9PPh/Z0vVoGH4tTqIMSqbAXsx3maiqPrWErPL/Q6C9pUCLk1R901uD4CTZxPjTnZTWREQHV2c1uBzFXjs+PXwbxJAgGOyTy47Q6X+JBf7+2ve8YazBkdceZsxpM/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706680667; c=relaxed/simple;
	bh=vOyih3ICf+cC/rEztfmfpM3LdNIl0b2I9wSmpv/NLFk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QIbQzBTqAp16ljZ/NVSKi+NHWSgZxc+1K9UkaIEgvggdBUk0w7fDIFcQ2m4apYJw04ngSMJVE9OpndXHzNz9IzZmC+TIzYQl1bIF7wIdIxdHEoualQK8ZYN7sQp8tYKMRC1MDjxtTyrDsdTzFyIx7dIGh5kgZtPcHv5WRtW64sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=cBPK5zEU; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cBPK5zEU"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a35e65df2d8so334888766b.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 30 Jan 2024 21:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706680664; x=1707285464; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DJmhQWnMdv5xPINffOj6QDTUCMF7DMEzkKe7lbx6KIE=;
        b=cBPK5zEUQs9ZGjlwe0sQxa8pWCYVhR/pb0wKhpLAkfs9O9yK8E7q1fKltCbD3nHaBI
         uL6V7bHSbSnzmN2ZQF+zojIHIIsbQ8j+qyzNpbue9ZjQtCKo1tV74q2nf8jXmAaQTV4+
         FwEKEMyxTWcgDFB/IXT8G1Ra67gNVqobnr8Zo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706680664; x=1707285464;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DJmhQWnMdv5xPINffOj6QDTUCMF7DMEzkKe7lbx6KIE=;
        b=ZStmQeY6nM1RgzmovPPTQoQ5+FHob7uuEywK/FMI1qKU6mzUTAthz+wYIsSJnx2eLV
         4kYL4+5TiThAQYoTYHdv0mtI6X5LQ4DxHJyTuE2K3yUupuUaPm09Uj916nzoRS9lGaYB
         wvBW0pWXcs9mmBBNDsA7kSTcCCPdEuwV8y6fva3rGVSsckpWq1q6p1FGT0oghTUJGU51
         kcKjHXCePi2JYvn2SMi2UnVfhx1x44o2A0oVB/BE5GC689T764SqW5+jNr0ru8hOVhvB
         AJyM3CrUlsSrrG8UO4o5bixDMTYCHcEENYpcliR6N073MZ2P/e/lThXwLkA1kfAz4NMT
         izjA==
X-Gm-Message-State: AOJu0YyFvq6xvl6YLCXzGacCsX/TowmYI/aHFhDUI4ikuGQpxNmMbeUw
	OTowRqgxj2O2+ll1KObQwmNiNRhNEDoRohUWE6x/V8IOsWnTQws2CpvfX+TtE48jPv7+IWGAtzU
	EtrzAMQ==
X-Google-Smtp-Source: AGHT+IF/Jke3Z9QnDOgh6pqcEyKyDJXnBKST6uXRvYuqwjkAK5UFPityhMjmeKm4NjfqaUyu1Soh+w==
X-Received: by 2002:a17:906:d114:b0:a35:e26c:e80a with SMTP id b20-20020a170906d11400b00a35e26ce80amr371123ejz.3.1706680663781;
        Tue, 30 Jan 2024 21:57:43 -0800 (PST)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id qt11-20020a170906eceb00b00a358f659989sm3602191ejb.113.2024.01.30.21.57.43
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 21:57:43 -0800 (PST)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-55ee9805da7so4061265a12.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 30 Jan 2024 21:57:43 -0800 (PST)
X-Received: by 2002:aa7:ca47:0:b0:55e:eade:fcba with SMTP id
 j7-20020aa7ca47000000b0055eeadefcbamr342103edt.5.1706680663061; Tue, 30 Jan
 2024 21:57:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130190355.11486-1-torvalds@linux-foundation.org>
 <20240130190355.11486-5-torvalds@linux-foundation.org> <20240131000956.3dbc0fc0@gandalf.local.home>
 <CAHk-=wjH+k47je4YbP=D+KOiNYp8cJh8C_gZFzSOa8HPDm=AQw@mail.gmail.com> <20240131003317.7a63e799@gandalf.local.home>
In-Reply-To: <20240131003317.7a63e799@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 30 Jan 2024 21:57:26 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg69FE2826EokkCbSKHZvCG-cM5t=9SMFLcfpNu8Yvwqw@mail.gmail.com>
Message-ID: <CAHk-=wg69FE2826EokkCbSKHZvCG-cM5t=9SMFLcfpNu8Yvwqw@mail.gmail.com>
Subject: Re: [PATCH 5/6] eventfs: get rid of dentry pointers without refcounts
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 30 Jan 2024 at 21:33, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> With even the last patch included, without the d_invalidate() I get errors
> with simply doing:
>
>  # cd /sys/kernel/tracing
>  # mkdir instances/foo
>  # ls instances/foo/events
>  # rmdir instances/foo
>
> As the rmdir calls tracefs_remove() that calls simple_recursive_removal()
> that then walks into the "events" directory. Without that d_invalidate, it
> walks beyond just the top directory and then splats on the dentries that
> are cached.

Ugh.

This is only an issue for that "events" dir, right? The one that has a
proper refcount on the dentry in 'ei->events_dir'?

Because yes, then doing d_invalidate() looks like the right thing.

           Linus
