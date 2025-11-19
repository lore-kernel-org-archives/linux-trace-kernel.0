Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101BB2E6CB2
	for <linux-trace-kernel@vger.kernel.org>; Wed, 19 Nov 2025 15:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763567102; cv=none; b=UY5WZ3cfMaow1nVKyuAUOLNxjqme28iySWTnsGW1hTu/wTqsBxw8pjBoJCBRL/gEQiz0fvI+irRcaiDJPQe6kYdTa1HdPAeUQAf1pUd7RfMbO7NfmWLmrHPCpG2DtSRSlA715iCbIgZYXcY4kpEQLsjsUNKqw0p4K6SttG+4ag8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763567102; c=relaxed/simple;
	bh=QL7KRLmdJkHYNOg+NNX2LL57E4h9RRUgMfoI/vTkpME=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HCYP9TK3Autqa+H+vtup+I9b+eMom9XmGE1h4g+emeNhMWh0mFl/qBwNENQ6oroWllpjJpRASypPQnOOLuIBXL1b6yCWU55+cMdNn0rpTSFfMsRJrg8OlQWPwBDw49mK6YyWjGjQVr++qOxI0VZawvKyfFNUJfyxnV3c7xTtwLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AeYttVC1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AeYttVC1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763567099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8+2RMibk5qCZlj/6zmvcs/X6W3gfpL9YpQv70ggfokw=;
	b=AeYttVC174L81fsSZCyrXbteruGobwH11N4VmTsj1LnLTBvGEfqKc5QUQdnF/cAOHKnku7
	VVFSf0XD48X+Q28ADTsihAeuFxwsvXdZfoJ0Vto3wS4n/5OX6w13FGA8Bti+B5MYKsq34z
	NFPKA4k39ov/fgx73H/KqrRffdW7j6s=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-NMWkxh_6NKyBNrXfyFxt3w-1; Wed, 19 Nov 2025 10:44:57 -0500
X-MC-Unique: NMWkxh_6NKyBNrXfyFxt3w-1
X-Mimecast-MFC-AGG-ID: NMWkxh_6NKyBNrXfyFxt3w_1763567096
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4775d110fabso53013065e9.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 19 Nov 2025 07:44:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763567096; x=1764171896;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kk13dNEBENY1o2hkoOmhPMN6DaHaKFtT0pxiR0fZhjU=;
        b=bpRssSeAoDTFVf1ShehsDGRDi2n9BgWjTwKoK3BjOdwQloJXGwW3Nwtn1n4dUU3+yn
         6yiTDFzU4Yx0DF6QMeAVmd7APaqjnqu5wVQaoXXzvvvNE/aXjKllFvX9hUnOhnxB67gA
         2T8PCLnJHeHbPJ0EDDK1Ce3vk0r7irSmqrNTUgDNoF/6je0z63wmqGXtoC58xh+szXSS
         /x2ooVexXRe3/rt2XSsc08wc60/PA0nVe00M/FZz691b3XNQK9t87j4cCTlMmxMcuDO+
         an497m08FUEsdel1dDR5ATyKoRnm6xyO+OxtckCxg92fPTEtUkln1arq7ncRQXKL2HZO
         dCUg==
X-Forwarded-Encrypted: i=1; AJvYcCUxcbXf5NtTHjDMoFKpRqk/48q7lSzFz2v5ZxMzH6KsZWf8ppBGhy05kqsYIalTmX1Utv26hd3S16Y+0bdMWfyrbxU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMcok7thlnUab6SD/Tl046cDwgAtBjtPvVrC3NtZmybbeFNq5C
	Yoo8nG3C/g1c2DR/2/GJn5QM7XB1c5NuJKKy3M03x+dsY44Z/jHbZJvSV//DCD/w5eN6MfDPwWF
	6tfbkrD7fo+xKaVzpK5DNyTur9D688pvojI0gWY3CBLzgspptAaDwLAR2EH2vGIF5lV7VcpYy6g
	==
X-Gm-Gg: ASbGncv67Hzj676kD2NmRhKGc4cJnx5VdPs/twrKmb+CznR5n03wM2N5MmDl1H7MhVf
	emiAuCqOeqwZ1EIvo1NS7iR7vzZ2OpK3xb1ecaqiHlVh78WlvbJQ2RtZ0aLMV5b3DA4yhu/Zelc
	11cHiV25Lw6PM8WlnNUpF27tpumy7yaF+HD4uyOVJPGn4YpLCgEeRnNEwLZfLqzvE+C1wCIiABJ
	giDL3GNGpUauujBbwAXD2JApKdvXO8tBYb+DVeKpzrdGlg8QYYryyT56yfC1WvB7zLLs7j/i/7Y
	kxV6fbO6eUo0GG7eAb5Esqqv4jTVMswa9ao/UTgdpQMxqpu6BGFbGqaKQM6KKs50IQ2Y7MGqnuY
	zbxoXdfVMyCQqsCQLEU2zfKwYQ5UVtCfsu3Abi95OkZXJ/0TWsmbaimiCZxEd4mDlTt8yme4=
X-Received: by 2002:a05:600c:1d0e:b0:477:9cc3:7971 with SMTP id 5b1f17b1804b1-4779cc37a15mr119020875e9.20.1763567096258;
        Wed, 19 Nov 2025 07:44:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEkP+NxoN8NdgRlSeWXCmLJ99Tn2hRpBffdqlJtKvc6mMNR3Hn0LkbgzbfrqY0lLueiMZLQiA==
X-Received: by 2002:a05:600c:1d0e:b0:477:9cc3:7971 with SMTP id 5b1f17b1804b1-4779cc37a15mr119020335e9.20.1763567095710;
        Wed, 19 Nov 2025 07:44:55 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-135-146.abo.bbox.fr. [213.44.135.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477b10260adsm53340155e9.7.2025.11.19.07.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 07:44:54 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: Andy Lutomirski <luto@kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, linux-mm@kvack.org, rcu@vger.kernel.org,
 the arch/x86 maintainers <x86@kernel.org>,
 linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
 linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, "Peter Zijlstra (Intel)"
 <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Josh
 Poimboeuf <jpoimboe@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Arnd
 Bergmann <arnd@arndb.de>, Frederic Weisbecker <frederic@kernel.org>, "Paul
 E. McKenney" <paulmck@kernel.org>, Jason Baron <jbaron@akamai.com>, Steven
 Rostedt <rostedt@goodmis.org>, Ard Biesheuvel <ardb@kernel.org>, Sami
 Tolvanen <samitolvanen@google.com>, "David S. Miller"
 <davem@davemloft.net>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel
 Fernandes <joelagnelf@nvidia.com>, Josh Triplett <josh@joshtriplett.org>,
 Boqun Feng <boqun.feng@gmail.com>, Uladzislau Rezki <urezki@gmail.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Mel Gorman
 <mgorman@suse.de>, Andrew Morton <akpm@linux-foundation.org>, Masahiro
 Yamada <masahiroy@kernel.org>, Han Shen <shenhan@google.com>, Rik van Riel
 <riel@surriel.com>, Jann Horn <jannh@google.com>, Dan Carpenter
 <dan.carpenter@linaro.org>, Oleg Nesterov <oleg@redhat.com>, Juri Lelli
 <juri.lelli@redhat.com>, Clark Williams <williams@redhat.com>, Yair
 Podemsky <ypodemsk@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Daniel Wagner <dwagner@suse.de>, Petr Tesarik <ptesarik@suse.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>
Subject: Re: [RFC PATCH v7 29/31] x86/mm/pti: Implement a TLB flush
 immediately after a switch to kernel CR3
In-Reply-To: <65ae9404-5d7d-42a3-969e-7e2ceb56c433@app.fastmail.com>
References: <20251114150133.1056710-1-vschneid@redhat.com>
 <20251114151428.1064524-9-vschneid@redhat.com>
 <65ae9404-5d7d-42a3-969e-7e2ceb56c433@app.fastmail.com>
Date: Wed, 19 Nov 2025 16:44:53 +0100
Message-ID: <xhsmhecpukowa.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1Ei6AgCZ7HXnBUVmJmskx6XGv9ZLOl8M6KzDwsir6Pg_1763567096
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 19/11/25 06:31, Andy Lutomirski wrote:
> On Fri, Nov 14, 2025, at 7:14 AM, Valentin Schneider wrote:
>> Deferring kernel range TLB flushes requires the guarantee that upon
>> entering the kernel, no stale entry may be accessed. The simplest way to
>> provide such a guarantee is to issue an unconditional flush upon switchi=
ng
>> to the kernel CR3, as this is the pivoting point where such stale entrie=
s
>> may be accessed.
>>
>
> Doing this together with the PTI CR3 switch has no actual benefit: MOV CR=
3 doesn=E2=80=99t flush global pages. And doing this in asm is pretty gross=
.  We don=E2=80=99t even get a free sync_core() out of it because INVPCID i=
s not documented as being serializing.
>
> Why can=E2=80=99t we do it in C?  What=E2=80=99s the actual risk?  In ord=
er to trip over a stale TLB entry, we would need to deference a pointer to =
newly allocated kernel virtual memory that was not valid prior to our entry=
 into user mode. I can imagine BPF doing this, but plain noinstr C in the e=
ntry path?  Especially noinstr C *that has RCU disabled*?  We already can=
=E2=80=99t follow an RCU pointer, and ISTM the only style of kernel code th=
at might do this would use RCU to protect the pointer, and we are already d=
oomed if we follow an RCU pointer to any sort of memory.
>

So v4 and earlier had the TLB flush faff done in C in the context_tracking =
entry
just like sync_core().

My biggest issue with it was that I couldn't figure out a way to instrument
memory accesses such that I would get an idea of where vmalloc'd accesses
happen - even with a hackish thing just to survey the landscape. So while I
agree with your reasoning wrt entry noinstr code, I don't have any way to
prove it.
That's unlike the text_poke sync_core() deferral for which I have all of
that nice objtool instrumentation.

Dave also pointed out that the whole stale entry flush deferral is a risky
move, and that the sanest thing would be to execute the deferred flush just
after switching to the kernel CR3.

See the thread surrounding:
  https://lore.kernel.org/lkml/20250114175143.81438-30-vschneid@redhat.com/

mainly Dave's reply and subthread:
  https://lore.kernel.org/lkml/352317e3-c7dc-43b4-b4cb-9644489318d0@intel.c=
om/

> We do need to watch out for NMI/MCE hitting before we flush.

