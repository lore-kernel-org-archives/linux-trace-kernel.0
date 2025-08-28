Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8702609D6
	for <linux-trace-kernel@vger.kernel.org>; Thu, 28 Aug 2025 22:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756419518; cv=none; b=IoQpVH6lQc+Io1/WXjFHtm2XhchkR288nGGaQ12CvIrR4yokCUwPygfJ3cykcluHB5AOpw9/2Cca6UJRIWEcWSWGiXA5ZgHURYETQPlNbhyjukRZDYnerYPiMtsdN4UP16dp00zikxxKzxdkqW09or9vRSUyHuEye3C+cU9phHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756419518; c=relaxed/simple;
	bh=9WEGzCFhZV6sH6YxOCr5ztz6wxhV90gkoN+WpO2tJ3E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BKLY65811+44fHCpxxCTn66jBy+ITVdtDqcBuhrgoOej5Vz0GGMfRU2AfpXTd2YvPcz+ToN1h4jxDwjp9iedgsjnk14Je7STO6DElq+XRG6BzKBVksgm5SVLClEFxtGDCjUAnOGK14HJDVii7k9MhnrWl4k0qKHzA2u5L0qVJvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=F7Zkqnaw; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="F7Zkqnaw"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-55f4bcceed0so1690716e87.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 28 Aug 2025 15:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1756419514; x=1757024314; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PvdilKb/k6sbi3O/WOYoC5wLcLE1gCyu//e95KE+Wa0=;
        b=F7ZkqnawpphVZ+yd1beUWHJ9zhCntL8t9cSnkZq84DwK0aVxGVPZwhG+ZJ0jeB/1Wc
         h7XEd7yC1bPKncdP00kwtOJ4lU8zXoF5oH8DSO//DjwAulZXX8oQ3RWPBbpRmrJFm0aL
         a8qdVDx2uHtw3TVMNsxQElLSraEclReejMPX4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756419514; x=1757024314;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PvdilKb/k6sbi3O/WOYoC5wLcLE1gCyu//e95KE+Wa0=;
        b=QJTDJT9JEXCEngbMMQHO1D51HHmoaXTL4+mFkccDuT0np5+zPl2VHRuX44/Ygt/LEf
         P0b16anGt/P/1Svb2ZxDhqHmT5hjfr6mgot0YPnmAUsNxV8VfOqDbjD30A6gGsT45SsF
         Lq3Q/6DBzpLZZkBVydynzH6ut9ACgMhbBXnWqwJ3rN07U2fNS5AipBUUL+hROZwUeJyT
         1ie50M6m3XVus0MBVxH3aL1yOCXCZvlqYuXgsLUDMGq7I2l08HTB0JUYsdqoqrBVMg72
         /ux08ApamcCVpbq3tqRjCxpeV46X2BY9ws8kUKJtWtTGuzO8ZZXCdn1JlzlOy44YAkHj
         Jw/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVYWD9g0jQajDCRIPvidvYMr3Zr8AT5a4w6lS5b1IK0GEsSUMMRIX6RngNfNZLD/ySSwbpwCvk+PeaJ5tnkjJCYfzM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkYEMFiDh5jVZU/zhHQ5rvuLeZCnK1iza/fV1VZANLZekgPniT
	RXlLKtE6iWRDRks8dUwmTTQbhTmFzH5SLdsKk4vR7M6urh2JQhQDA94sROc/FK+ER2Jj6S6iu6w
	5hJSyEYEgrA==
X-Gm-Gg: ASbGnctMqypMnNmLK32jl5wxrTQWJEAk20xdxzyjKqdMMK5KSVPVvphBVGyuXcGQSQH
	/kGKQYaPgEY82c/7a9Kfey+faRkaTtTGQ9K214Qt/5OrQR4RRw1Nmmyqubaz6SvDWtXZyV5gVtq
	SBd8NH+hbSCluV8/bEizhBFFZOA6RzgyjbP+MRn+NH/koLa4Z9AsEHG3MYrfghckDt9Dm/YgXGV
	yLc1NW+bs9YeRsg9MkjTgJAhQP1f0ywb2ClBiZ7YQ3+ETG6MBiWq/vLjwVgSg8DJJXEL+U4Nikc
	vWOJ9TOZdGCgdT1dc6swW9ZDZbnjxz4yirxeSZi9Q9bmB+tLpuBOu8tHRUIOlMo/N+rAPkaIkSr
	lqlEVivLbx8YVzMC4UVGOpDap5VpzUS2GcKJ7XeeMkaoqRzmNRW1pnu22VMw3+5BZ5mA1ShD6FN
	rRcSwFRhQ=
X-Google-Smtp-Source: AGHT+IF5OkbAXMbXKt/nG7ZiQh8VL2x/9t+GmX5U4Ln9715bCsFZSAhWqJvV8dd7MHGL6FFwoWnjVQ==
X-Received: by 2002:a05:6512:6408:b0:55f:4bf6:efed with SMTP id 2adb3069b0e04-55f4bf6f5b3mr3807621e87.1.1756419514209;
        Thu, 28 Aug 2025 15:18:34 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f678452cbsm125463e87.75.2025.08.28.15.18.33
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Aug 2025 15:18:33 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-55f467f3c06so1205589e87.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 28 Aug 2025 15:18:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXJ6YJrMXhrAuZWGvadzRRTuvN9gaCTk3tfFlFlrr3DAhhRbwV03/lTY8MQfvcwIIH0f0pz40OaBot8wwwgdd0U4N8=@vger.kernel.org
X-Received: by 2002:a17:907:60cf:b0:af9:3116:e0f6 with SMTP id
 a640c23a62f3a-afe296e6412mr2315793666b.53.1756419069671; Thu, 28 Aug 2025
 15:11:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828180300.591225320@kernel.org> <20250828180357.223298134@kernel.org>
 <CAHk-=wi0EnrBacWYJoUesS0LXUprbLmSDY3ywDfGW94fuBDVJw@mail.gmail.com>
 <D7C36F69-23D6-4AD5-AED1-028119EAEE3F@gmail.com> <CAHk-=wiBUdyV9UdNYEeEP-1Nx3VUHxUb0FQUYSfxN1LZTuGVyg@mail.gmail.com>
 <20250828161718.77cb6e61@batman.local.home> <CAHk-=wiujYBqcZGyBgLOT+OWdY3cz7EhbZE0GidhJmLNd9VPOQ@mail.gmail.com>
 <20250828164819.51e300ec@batman.local.home> <CAHk-=wjRC0sRZio4TkqP8_S+Fr8LUypVucPDnmERrHVjWOABXw@mail.gmail.com>
 <20250828171748.07681a63@batman.local.home>
In-Reply-To: <20250828171748.07681a63@batman.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 28 Aug 2025 15:10:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh0LjoJmRPHF41eQ1ZRf085urz+rvQQ-rwp8dLQCdqohw@mail.gmail.com>
X-Gm-Features: Ac12FXx5hAxpj7R5TefcskUP8HKtgWPbH5S6RidfTf_IcaWQCyRoB2repH8EaWs
Message-ID: <CAHk-=wh0LjoJmRPHF41eQ1ZRf085urz+rvQQ-rwp8dLQCdqohw@mail.gmail.com>
Subject: Re: [PATCH v6 5/6] tracing: Show inode and device major:minor in
 deferred user space stacktrace
To: Steven Rostedt <rostedt@kernel.org>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, x86@kernel.org, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, 
	Indu Bhagat <indu.bhagat@oracle.com>, "Jose E. Marchesi" <jemarch@gnu.org>, 
	Beau Belgrave <beaub@linux.microsoft.com>, Jens Remus <jremus@linux.ibm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Florian Weimer <fweimer@redhat.com>, 
	Sam James <sam@gentoo.org>, Kees Cook <kees@kernel.org>, "Carlos O'Donell" <codonell@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 28 Aug 2025 at 14:17, Steven Rostedt <rostedt@kernel.org> wrote:
>
> But that's unique per task, right? What I liked about the f_inode
> pointer, is that it appears to be shared between tasks.

I actually think the local meaning of the file pointer is an advantage.

It not only means that you see the difference in mappings of the same
file created with different open calls, it also means that when
different processes mmap the same executable, they don't see the same
hash.

And because the file pointer doesn't have any long-term meaning, it
also means that you also can't make the mistake of thinking the hash
has a long lifetime. With an inode pointer hash, you could easily have
software bugs that end up not realizing that it's a temporary hash,
and that the same inode *will* get two different hashes if the inode
has been flushed from memory and then loaded anew due to memory
pressure.

> I only want to add a new hash and print the path for a new file. If
> several tasks are using the same file (which they are with the
> libraries), then having the hash be the same between tasks would be
> more efficient.

Why? See above why I think it's a mistake to think those hashes have
lifetimes. They don't. Two different inodes can have the same hash due
to lifetime issues, and the same inode can get two different hashes at
different times for the same reason.

So you *need* to tie these things to the only lifetime that matters:
the open/close pair (and the mmap - and the stack traces - will be
part of that lifetime).

I literally think that you are not thinking about this right if you
think you can re-use the hash.

             Linus
