Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123434C62B
	for <linux-trace-kernel@vger.kernel.org>; Fri, 22 Nov 2024 15:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732287855; cv=none; b=RzgbtsNm5Qgvto0BrKWUxuJP+CquYkfY2ZvKELAFnj7MTZgYrg2rBPsFRqeyULt3vQa9fPC+eoGbU7O/e8EkmdzdXwe/WF2s195P7vc0vqaMmHeMNQYia+ynnGzrUnNj+4EAxxmkj7VyR6MmacIqslfg+YiuIWAKB76tYFYrY+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732287855; c=relaxed/simple;
	bh=JPwzMxxKiG5YAlFM7ggPNw4cNqkrUfOxQAIgSiAFjHA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TohfVi/MiR+Vo20/kXYvqQencbXOsJa1XvHwP5CknmiAp98qbbQoGC6rcP5NSi7Bsu5q025p5lgBFPZCYdSnfDMmEkbrmex5+gBlylyuTUwpNDrqhZacnFDV+nEyQOO1sDZGiFYdde0DOcsr20KUvFntTp+BE5sDZmmiu8yE7x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BKeu89N1; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BKeu89N1"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-460a8d1a9b7so233371cf.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 22 Nov 2024 07:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732287853; x=1732892653; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g8ZUSSRLGw9xTBQ7M4Y0SwWvv6Kuw0ebYJzTcfGAtqM=;
        b=BKeu89N1zweV+T8VLC/CM6PNaT7yibRv/RQ3goDgRxpYajorV2NH9JYEz4hJkBFmQC
         i/OpZfoBKXKhSFjIE8QuJmPEQsyPFRsF4eUYyMWngj2MBwv+2RYMLQjQspjxnJtcT2FQ
         QCQOU9qLxA4TtXVDgVVdgfS6t0KMwFTGz/Hr2h93fFEH6GCinELz9cd9mSpqdePICR6i
         0yKcWTgJp5Vkxr6U3NbII0LUAMThNpXPa0OeadbJ5kxPz7ZYn0Nz+Z0/4elhALCpc0S+
         eZ0PbG9HbQLRJGXqZDdROJZLFTHwv5sOtta1VLWrhLEJJqPJSTkru6nvccJLvEri8JNW
         GeZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732287853; x=1732892653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g8ZUSSRLGw9xTBQ7M4Y0SwWvv6Kuw0ebYJzTcfGAtqM=;
        b=D0QkmzKTByuuFAxmypZJBuyMhKm3oOAgquYnZOLUO5Kjmw1mVasplTP7rOcAbTQ5C3
         zN1BiqabxsKwK3BRu29c9HdHdLfxShqWSwHhmNvHnKTxaR5mc0b3bOe1uYYyivGgu2L8
         TkxVLiwcRrRTd0SjsTbPYaBR7T44KlVDaV8l2HVxY9papNS19R4K6rPcN+cpXTlRmKdu
         XfPCeRGYc/TIyuSrXLdci45S26ZNz2VO1IGmB5ZjOcX1c+Ki1gWgC4ZGVmQlijO7v6fG
         bPHYBcJsMH8NVlgvl/HF+np29zGxUzBFZg6Kw85TWga1RFjk4Q+jWDhBEfvM4t16DWij
         OQ4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVCaxRMM0s/m+HkMx6iEBwbwlpdldi8d/irjIJt4MserpHdt2zGnGpFtqYXwGI/pkvZ6cQ7CO2GJBl9U9fSUeNs7Nk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7xWGNlcHKzfMgs1U3NTR8Pd7jCHFPN/Gt5zmBxOkNrppjZPnY
	GuUwY+yONYaqb6yubvdkxeH+iZMmtv8q56T0l2MoK2r3rqhKRJTXTn2jmfGxHmViHTksQXDkrKI
	hbxFUWthmewj+021u3pXRSJxb8KUy7pwzrF5y
X-Gm-Gg: ASbGncuaF4+AXR3VOghPJs/jMc9BZvTqhjpbdB742XyVMPsBkiOSUOt582v3qiV0eQq
	He1SXh0YPCK33+6BHS4luI9eJZ91ElDQ=
X-Google-Smtp-Source: AGHT+IH/FyuQ/03I4l56fu/4U8V2wW9Bn9XSq15JGKrpMqDO7NvvvR33bmdKWIL+KU6uDt+D8KmNCQJZ8ruY0FD9UAo=
X-Received: by 2002:ac8:1188:0:b0:465:c590:ef19 with SMTP id
 d75a77b69052e-465c590f0bemr2293521cf.5.1732287852689; Fri, 22 Nov 2024
 07:04:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122035922.3321100-1-andrii@kernel.org> <20241122110737.GP24774@noisy.programming.kicks-ass.net>
In-Reply-To: <20241122110737.GP24774@noisy.programming.kicks-ass.net>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 22 Nov 2024 07:04:01 -0800
Message-ID: <CAJuCfpFvHwjMDdFGjCfg+fta2=Ccif7XReTH6TpC+V+PZ1JmAQ@mail.gmail.com>
Subject: Re: [PATCH v5 tip/perf/core 0/2] uprobes: speculative lockless
 VMA-to-uprobe lookup
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	linux-mm@kvack.org, akpm@linux-foundation.org, mingo@kernel.org, 
	torvalds@linux-foundation.org, oleg@redhat.com, rostedt@goodmis.org, 
	mhiramat@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jolsa@kernel.org, paulmck@kernel.org, willy@infradead.org, mjguzik@gmail.com, 
	brauner@kernel.org, jannh@google.com, mhocko@kernel.org, vbabka@suse.cz, 
	shakeel.butt@linux.dev, hannes@cmpxchg.org, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, david@redhat.com, arnd@arndb.de, 
	viro@zeniv.linux.org.uk, hca@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 22, 2024 at 3:07=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Thu, Nov 21, 2024 at 07:59:20PM -0800, Andrii Nakryiko wrote:
>
> > Andrii Nakryiko (2):
> >   uprobes: simplify find_active_uprobe_rcu() VMA checks
> >   uprobes: add speculative lockless VMA-to-inode-to-uprobe resolution
>
> Thanks, assuming Suren is okay with me carrying his patches through tip,
> I'll make this land in tip/perf/core after -rc1.

No objections from me. Thanks!
