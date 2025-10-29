Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE342FF17F
	for <linux-trace-kernel@vger.kernel.org>; Wed, 29 Oct 2025 10:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761733987; cv=none; b=pnZ9OL6Q0PDI6yNYtfhlYW0L94ten7vu6SGzTkgLCDgJCJXWgE+xQ8YKjlc8kPeH9TH7WEKimfzk3gKgP5s/M6oSBN+siA6LGUXLX7cFeaPbi6NoyUX2z3WbhGVCrw9EX/OSml9AEFNRn+m05ixTfdJG0f2ASGXGkFPGTlR7cS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761733987; c=relaxed/simple;
	bh=Q5IYDvPFumVfwvOYxMbJQy+19JoOnyh2TX2vd+zwxmA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aio/RJ0tdHPhYCviElyiIutE6FkFqhPKDwI5sS5BIf7fujMgpN+D9ufqJDJfY47Rf2hHGSCXuLjVHBkJQQ2qsZF6MvGLIIB7zB7q+n7n3NdHcbqMwDDfF3TNIK8e9O9hJQjei1pS2DssvOOQ0ffEiKVjAbHFNx6mnM/wdj6trA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FFiJQXx5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FFiJQXx5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761733984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8TDebEJmKrapkTDm2SQS84/R7MOsdaEIy1zvcb82V9E=;
	b=FFiJQXx5PfWuPprnhmzWir21K12qti6sHPIY8QYkvhwcdPZDv6JJQxt8jCshbUcM5/Wmew
	grZztX7evju1Asny/s6S1ERW0kPfP/LyBr+m+JSgA1j41aH2OzYF378etmU2xKUs8MItj5
	mm2saDAxq/Xy5li7r4NYwhhjGNxuvJA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-172-c8skNyxUN6Wh6DPAXz-yjw-1; Wed, 29 Oct 2025 06:33:03 -0400
X-MC-Unique: c8skNyxUN6Wh6DPAXz-yjw-1
X-Mimecast-MFC-AGG-ID: c8skNyxUN6Wh6DPAXz-yjw_1761733982
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-475da25c4c4so24203005e9.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 29 Oct 2025 03:33:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761733982; x=1762338782;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rJM20FESPr5Q3wolT/mFDxUYnwba82V6xz3P+wmiM7o=;
        b=KGUk7NnLcPJ6POKGyqMtXCM5oceKToHx2LcBQn3Ok8gASVVEvcZ4pLPtKQkCbwoyev
         En76EynF4SFx3mDXCWGvkDaELJ7ocTjvYEYxiFMguFgmCUk9/8npPiIeXMWSNg8uwALf
         BSlxy/wOSkuPuM1lxUqAEjW+Q0RdpBcB36QNwJNm8jWOe2iaJ4J3VtaVnV6NfkyP/LPC
         D/d12yUW/yN0gGS5eAE91fL0MM1N7hbOvpzXkzfAAMhzr7bWkJN5SO174K3hIa9j+mwR
         FLt/pv9eQVuFYYKbDAB7sDOkpj+DS5McFAwxoPQR0GAZGKfemFVl/DreT8EaTZtPvIE4
         LX+A==
X-Forwarded-Encrypted: i=1; AJvYcCVa93gyKDy9e4pzEUIbCGDIxx3yQOH2d/TeFQ0ZgM8TQP+fR2fsXUWX1hkut4IW2tLHeaNiH2Toa7THuIDBhEg70RI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywar81Fp9QdRSflifWWfl6YlrrXHzlElAvdUQDqv76Xxq4evTMk
	Vq81FjYc32Dgc5GphN7MKQz60ASuAJhXl3yfkY7Q9kU89tJjcbOPrxC4j2lznm0c9ZFjJGmpdkf
	Wc2RIj7p/8pBWQV0V2gWgGzSQWbcQV0djB2+7g7mssLWqwY7rGjMiqGBXT5yOu72uA66G+v7RMg
	==
X-Gm-Gg: ASbGncs0wkni9ubbJLxetjKc1+GHW5Ecb0KydyJtddZ809jv+law8fKDcvvwBHmsT8f
	RD82nK7U70u1PoeeKNVyUUdtdSJMXVzGWP3iIMhbzi8LFzAQMgSUXDIH0YYUeu0x2sxe7owu2yi
	jyCwIl4pXn8B8BK65RTpTL98cvXOgPQmYI5V8sFDj1H9Jpy1K+VfnsChtACL9ZHlF0g0ncz2Nky
	FTjWLDjsQ75Nc4oXRrpysiowZyQS6cYEQmxtqBccN3Bj9HR8i3hzQnyxp1Ltq7HPdIZM1jvk5v+
	bgxh5vAcqqAC5IHf+RrA1yiE6MXMG66hsYWgW8KX+8TBGQlve+FyUFkXRcRgKOYmPIDaEGZ92fY
	9QRgSCPyLxyn1XGznyy6CwuKopIUt0xps7j/ZyAUUweXj98WhISgmutY///rP
X-Received: by 2002:a05:600c:64c4:b0:477:bb0:7528 with SMTP id 5b1f17b1804b1-4771e1da0c8mr21409635e9.22.1761733982060;
        Wed, 29 Oct 2025 03:33:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxlh/PGW1+wNXuO1RQYN4fEeAqw5AdQXtt4ynjbr63hSK8Qg5GeiiDecSDqHTa53KxpVgVKg==
X-Received: by 2002:a05:600c:64c4:b0:477:bb0:7528 with SMTP id 5b1f17b1804b1-4771e1da0c8mr21408835e9.22.1761733981314;
        Wed, 29 Oct 2025 03:33:01 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-135-146.abo.bbox.fr. [213.44.135.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952b79cbsm25638297f8f.4.2025.10.29.03.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 03:33:00 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Frederic Weisbecker <frederic@kernel.org>, Phil Auld <pauld@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, rcu@vger.kernel.org,
 x86@kernel.org, linux-arm-kernel@lists.infradead.org,
 loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
 linux-arch@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Thomas
 Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav
 Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H.
 Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter
 Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Arnd Bergmann <arnd@arndb.de>, "Paul E. McKenney"
 <paulmck@kernel.org>, Jason Baron <jbaron@akamai.com>, Steven Rostedt
 <rostedt@goodmis.org>, Ard Biesheuvel <ardb@kernel.org>, Sami Tolvanen
 <samitolvanen@google.com>, "David S. Miller" <davem@davemloft.net>, Neeraj
 Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes
 <joelagnelf@nvidia.com>, Josh Triplett <josh@joshtriplett.org>, Boqun Feng
 <boqun.feng@gmail.com>, Uladzislau Rezki <urezki@gmail.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Mel Gorman <mgorman@suse.de>,
 Andrew Morton <akpm@linux-foundation.org>, Masahiro Yamada
 <masahiroy@kernel.org>, Han Shen <shenhan@google.com>, Rik van Riel
 <riel@surriel.com>, Jann Horn <jannh@google.com>, Dan Carpenter
 <dan.carpenter@linaro.org>, Oleg Nesterov <oleg@redhat.com>, Juri Lelli
 <juri.lelli@redhat.com>, Clark Williams <williams@redhat.com>, Yair
 Podemsky <ypodemsk@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Daniel Wagner <dwagner@suse.de>, Petr Tesarik <ptesarik@suse.com>
Subject: Re: [PATCH v6 00/29] context_tracking,x86: Defer some IPIs until a
 user->kernel transition
In-Reply-To: <aQDuY3rgOK-L8D04@localhost.localdomain>
References: <20251010153839.151763-1-vschneid@redhat.com>
 <aQDuY3rgOK-L8D04@localhost.localdomain>
Date: Wed, 29 Oct 2025 11:32:58 +0100
Message-ID: <xhsmhzf9aov51.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: P7icYh-rS_7EjCqqnm4pezT_xdpIhAJNcDTEXKX13TY_1761733982
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 28/10/25 17:25, Frederic Weisbecker wrote:
> +Cc Phil Auld
>
> Le Fri, Oct 10, 2025 at 05:38:10PM +0200, Valentin Schneider a =C3=A9crit=
 :
>> Patches
>> =3D=3D=3D=3D=3D=3D=3D
>>
>> o Patches 1-2 are standalone objtool cleanups.
>
> Would be nice to get these merged.
>
>> o Patches 3-4 add an RCU testing feature.
>
> I'm taking this one.
>

Thanks!

>>
>> o Patches 5-6 add infrastructure for annotating static keys and static c=
alls
>>   that may be used in noinstr code (courtesy of Josh).
>> o Patches 7-20 use said annotations on relevant keys / calls.
>> o Patch 21 enforces proper usage of said annotations (courtesy of Josh).
>>
>> o Patch 22 deals with detecting NOINSTR text in modules
>
> Not sure how to route those. If we wait for each individual subsystem,
> this may take a while.
>

At least the __ro_after_init ones could go as their own thing since they're
standalone, but yeah they're the ones touching all sorts of subsystems :/

>> o Patches 23-24 deal with kernel text sync IPIs
>
> I would be fine taking those (the concerns I had are just details)
> but they depend on all the annotations. Alternatively I can take the whol=
e
> thing but then we'll need some acks.
>
>> o Patches 25-29 deal with kernel range TLB flush IPIs
>
> I'll leave these more time for now ;o)
> And if they ever go somewhere, it should be through x86 tree.
>
> Also, here is another candidate usecase for this deferral thing.
> I remember Phil Auld complaining that stop_machine() on CPU offlining was
> a big problem for nohz_full. Especially while we are working on
> a cpuset interface to toggle nohz_full but this will require the CPUs
> to be offline.
>

Yeah that does ring a bell...

> So my point is that when a CPU goes offline, stop_machine() puts all
> CPUs into a loop with IRQs disabled. CPUs in userspace could possibly
> escape that since they don't touch the kernel anyway. But as soon as
> they enter the kernel, they should either acquire the final state of
> stop_machine if completed or join the global loop if in the middle.
>

I need to have a think about that one; one pain point I see is the context
tracking work has to be NMI safe since e.g. an NMI can take us out of
userspace. Another is that NOHZ-full CPUs need to be special cased in the
stop machine queueing / completion.

/me goes fetch a new notebook

> Thanks.
>
> --
> Frederic Weisbecker
> SUSE Labs

