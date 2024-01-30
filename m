Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279EA125CA
	for <linux-trace-kernel@vger.kernel.org>; Tue, 30 Jan 2024 00:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706572907; cv=none; b=e9pofoauWLdM226u8s0xyQojw53exdpO81Byr30o427SJ1ztR1m2wNACw7h9BLSq+M0exvCxNv5VebVLJKOOH2hdf+uuIelxtYEVKU3OtnQjknFQNFnHHiW+2a0epNBntNd+OHIJJCiwygHq8QmP+yEnTQbPriKv0NAamcVgnNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706572907; c=relaxed/simple;
	bh=mP547cxSLBLqbgPFiU7KdWOYk0hFrjdJ8bs+VrkDQz8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oYyTbGfsrvEbU8wRRzWplY0IMWZ/s06fbvQQJNmp66bqfxvKH7lCFbsmgenybyxcpYwwlNpyQIhsF0wNdjKR0yFFX4A43rB23rNHeKtWGLvhuVMYkxoGXwBKqxGWQefCrdPgyBnreFwJSNne73G5RaKuQixmH59ojnfU6sEeSRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Nd6sOV0o; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Nd6sOV0o"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5110ef21c76so2668528e87.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 29 Jan 2024 16:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706572904; x=1707177704; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qnCN62biQQqn1jm8DGkvLeUSFirrT4FwO2mAzGrxaTQ=;
        b=Nd6sOV0opppeLnDP7fGPn+CL/anUKw+fc4t5dEm2Qvoa0fqt/xBKiJHE7n1YPudZ9y
         Q4v9USVJNTMzHAhBX8d2GMzQH87sBN3SNPeTrwzpQGgPCJE2e/r35HAF2CWT1N31z5gz
         s1YF5g30uLSorPbqIC9/GuOwdUQfo5+2QYTWM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706572904; x=1707177704;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qnCN62biQQqn1jm8DGkvLeUSFirrT4FwO2mAzGrxaTQ=;
        b=hMsM/P/CXjZ8Fk3NW49rJM7ZA1oBA44AyqshyFlZRO9bI9wgvrpjYTE8/SHGPrrJvx
         79ssFmDTRCZ8nNTX+m2QI3s4hFylt4vom9KjNTSADALClWPX+KgEooboUSLrvbN/uFHV
         3hC4HWZUiI06lj9lD2anFP10HJpiuEQHCKHSsX/K7IQtUEikjNDI+4grO9rsTZ+jl57V
         r7Sta+46kxtYBLbWjEktjVrAgk/acBiNAfxPOPA/iQg7W/wzqLIZH6AX3erpRbgUgCRV
         xHq499ynfkM6VvS+dj6SLUscOL5LxCcMoBTJE+FcynaC9wJXBU6ijMW8kl/rOLc9hVHa
         CjkQ==
X-Gm-Message-State: AOJu0YyorSNsNY7MLiq+ZNoXtorwJLkkDqeabf6KkW1oLhW/Qdrs80rp
	IdV06Na9zyuFGcUOwPmEgCygTXU5+L5/mDNZwCTD0Nz5xXaCVONLw1YCLyKdEffJKHKGhIBteV6
	tg3U=
X-Google-Smtp-Source: AGHT+IFPfctnoBKagwWgkC+obBXRooeTzhVZMo6x3PXfya+YTD1PjYhnUUvyjU8QeznclyXm5xhFvQ==
X-Received: by 2002:ac2:4c14:0:b0:510:1461:d03b with SMTP id t20-20020ac24c14000000b005101461d03bmr4263936lfq.11.1706572904113;
        Mon, 29 Jan 2024 16:01:44 -0800 (PST)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id x5-20020a056512046500b00510217b6db5sm1255908lfd.216.2024.01.29.16.01.42
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 16:01:42 -0800 (PST)
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2cf2adac1ccso37810841fa.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 29 Jan 2024 16:01:42 -0800 (PST)
X-Received: by 2002:a2e:80c2:0:b0:2d0:4c65:f09f with SMTP id
 r2-20020a2e80c2000000b002d04c65f09fmr2384103ljg.7.1706572901982; Mon, 29 Jan
 2024 16:01:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202401291043.e62e89dc-oliver.sang@intel.com> <CAHk-=wh0M=e8R=ZXxa4vesLTtvGmYWJ-w1VmXxW5Mva=Nimk4Q@mail.gmail.com>
 <20240129120125.605e97af@gandalf.local.home> <CAHk-=wghx8Abyx_jcSrCDuNj96SuWS0NvNMhfU8VjFGg9bgm_g@mail.gmail.com>
 <CAHk-=whb91PWEaEJpRGsuWaQpYZGj98ji8HC2vvHD4xb_TqhJw@mail.gmail.com>
 <CAHk-=wgp7UkG31=cCcbSdhMv6-vBJ=orktUOUdiLzw4tQ4gDLg@mail.gmail.com>
 <20240129152600.7587d1aa@gandalf.local.home> <CAHk-=wghobf5qCqNUsafkQzNAZBJiS0=7CRjNXNChpoAvTbvUw@mail.gmail.com>
 <20240129172200.1725f01b@gandalf.local.home> <CAHk-=wjV6+U1FQ8wzQ5ASmqGgby+GZ6wpdh0NrJgA43mc+TEwA@mail.gmail.com>
 <CAHk-=wgOxTeTi02C=kOXsHzuD6XCrV0L1zk1XP9t+a4Wx--xvA@mail.gmail.com> <20240129174950.5a17a86c@gandalf.local.home>
In-Reply-To: <20240129174950.5a17a86c@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 29 Jan 2024 16:01:25 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjbzw3=nwR5zGH9jqXgB8jj03wxWfdFDn=oAVCoymQQJg@mail.gmail.com>
Message-ID: <CAHk-=wjbzw3=nwR5zGH9jqXgB8jj03wxWfdFDn=oAVCoymQQJg@mail.gmail.com>
Subject: Re: [linus:master] [eventfs] 852e46e239: BUG:unable_to_handle_page_fault_for_address
To: Steven Rostedt <rostedt@goodmis.org>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 29 Jan 2024 at 14:49, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Now I didn't change this last d_instantiate, because this is not called
> through the lookup code. This is the root events directory and acts more
> like debugfs. It's not "dynamically" added.

Ahh, yes, I see, the dentry was created (as a negative one) with
tracefs_start_creating() -> lookup_one_len().

So  yes, there d_instantiate() is correct, as it's exactly that "turn
negative dentry into a positive one" case.

I'll go see what's up with the "create it again" case - I don't
immediately see what's wrong.

              Linus
