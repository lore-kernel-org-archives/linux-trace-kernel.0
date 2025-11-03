Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9662E0B44
	for <linux-trace-kernel@vger.kernel.org>; Mon,  3 Nov 2025 08:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762159065; cv=none; b=pAjyQaGHzZdrjrAUL5KTXbPrJHm4hKRt7jizeW1Mobl3iO3M4qN4ysfqeleZkgANHJOdL3Qqk5YcztFjkF0OTqon8nk2Mve6gKlZRthn5DbJtRmiW5LVbcWR1q2J64BhjeuQrMHz4t2RcdAaWgVPtdM7hrjQ0dZ6VjOvPa3EWyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762159065; c=relaxed/simple;
	bh=VPQocaf6gUl8BS3pejlUrKCB/3VeiYl/8q6ahm5+LvI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fcT+M6P+9JXPEj7hHZz2PhGC4D9XGOqIMUrPAJ29zGdLKZMJK4qEb7V/GUK7HdIukUXCslh+r77p3TAMUWXimtWpvYO9gQRXEI05SZYX+sY8bTzUlBxfIvkgrmuOhHoyYHONvSK4PyIfGZjFxnkCf6Uwumhqj/XPsc8Oh4Y1UhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MvwJ5g3D; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MvwJ5g3D"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6409cb34fe0so344889a12.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 03 Nov 2025 00:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762159062; x=1762763862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/6+8IBdXCcTU6eZ4JMuY2we8/fQYN6+oBue210uWprk=;
        b=MvwJ5g3D9QeXtpNX4vbPGC2vaOlKDMczWZ0Nt1QQqo8YJKH2W2YIpw7r75uYQtoDw0
         qwsmUidT3QH/zmsUQrmF+7ICIi/iMx0YgO3Lt6rQlGDfUbAjNggpKeSy0/2+HUb94YuG
         Lpi63c/4Q3uTaOIyAsxon79lBupqT+6HUj95GPWt3ehNAfqClcR+lexOfSGQGN5uVWhs
         VQJ85oJFz11jVMuAmvI1u/AtElK5GBiVwm3BNTQKQ8vtlvszGoY/VO+0cGysB/zxIQp/
         5IH8Z+z5TDo3wTuibCXhnAJ+A7KID8+UItbAqkp4M/uJpO42TG2fJIyxl2WQVPu+agMe
         /9mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762159062; x=1762763862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/6+8IBdXCcTU6eZ4JMuY2we8/fQYN6+oBue210uWprk=;
        b=k4y8OEcbCJJY2dGBStWqw+0OiFTSqtjh7aMV4yOy4CiSKtjn8OgjkCGosXUZ1PE/+6
         vhAgGubSsAgkIFJ2B1a+IHBEyAnhP5ICfg8IIllm8H7nLEFM37kLZfAho++j0G++co7X
         xeYoPmsLyLFk5X4vnBdjeu8LO8J24i4vN1OkXXRmcpr4xdqgRrTGyQexlhYYV5u/DGPZ
         iVmumP+mnu/jgFZmSbwuGo1SRNGhlVeD1ekkhyUSDVwlPOKGdh+EV+FA5NnSPlHnS/mu
         NYkdUKtmFlz3K8s6Knw1LRF7L3b93rvjIUi1AaOlKm/caTGdvxqV/GmXLZgxrW15To7w
         NZIA==
X-Forwarded-Encrypted: i=1; AJvYcCX1Z9Lmo+NbV6cMHCZMGM1RKu9Oftz850Qi2XuzdJZJkidmf08DvQ+kXNEMCq5MkD41zrDvezJQK23I3ayULCQZO4g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVlAI3zCorD1/cqe6/XPhtWGOo3Psrm81VVPlt24y7yBd+/NKU
	JIEiisrE5342Ps+VFSx2AcLEti0cGCh2+7FTqYEZJV++JCDts7IiD814lYY/Yu65+UE=
X-Gm-Gg: ASbGnctjMbxtYlqyPDbXemsm8UYoyIlmuNHW1Sdx1B6wXkQBeThICQr5jAQWr/ZvZAY
	YW8qflZobX8KqTO4kpSSffp6PR2Ux9/dOh9nNXlN8zUr9SVhZP+X2C9+XnpzgpZDv7vacLQN63i
	ANzM+AB9h5qYcooNiN4/nA6igsG0qxVEEJBNOkTeZHBQt3i2kqCYvtgjkUn/DxMc9KL128KYMx+
	NOvG5mzh9d7q2sh4SBAPKSZC1l/sEfT+V4+8oWyJOBVlkeEBwrS7gLnzm55NkiXipdwSnX7RQS2
	Ib0qlzWKEiXGTN6G2xqcccH/bRcTtmLVahMw3cIAK4oYXYvwxD3Kp2Sc+P8a6cgsFsnOkRwm3Ai
	uDLWljuNY7d6byX3bdM9z7Gi+zoChJms80OeS3dIFpRpCIpeSgnduFVIdCcLqepyzBZxRnGnsGd
	woSlgkF8EmO7fSVELkozJWy8CHKiiHiCG/oNij5g4Rm0SvLFDPe27RPXj9ErsmvLsU7SXkzJVu3
	fXZ
X-Google-Smtp-Source: AGHT+IEXAMzB4Q3iZseWqc5EI+3z01yD/lkzyZQiHdGqXZRiWGSYaalZ7FPGcsDnEnqBbvKYbK1akQ==
X-Received: by 2002:a05:6402:27d3:b0:640:9eb3:3683 with SMTP id 4fb4d7f45d1cf-6409eb34460mr3244974a12.1.1762159057100;
        Mon, 03 Nov 2025 00:37:37 -0800 (PST)
Received: from mordecai (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6407b428119sm9012005a12.24.2025.11.03.00.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 00:37:36 -0800 (PST)
Date: Mon, 3 Nov 2025 09:37:28 +0100
From: Petr Tesarik <ptesarik@suse.com>
To: Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, rcu@vger.kernel.org,
 x86@kernel.org, linux-arm-kernel@lists.infradead.org,
 loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
 linux-arch@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Josh
 Poimboeuf <jpoimboe@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Andy
 Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Frederic Weisbecker
 <frederic@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, Jason Baron
 <jbaron@akamai.com>, Steven Rostedt <rostedt@goodmis.org>, Ard Biesheuvel
 <ardb@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, "David S.
 Miller" <davem@davemloft.net>, Neeraj Upadhyay
 <neeraj.upadhyay@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, Josh
 Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Uladzislau Rezki <urezki@gmail.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Mel Gorman <mgorman@suse.de>, Andrew
 Morton <akpm@linux-foundation.org>, Masahiro Yamada <masahiroy@kernel.org>,
 Han Shen <shenhan@google.com>, Rik van Riel <riel@surriel.com>, Jann Horn
 <jannh@google.com>, Dan Carpenter <dan.carpenter@linaro.org>, Oleg Nesterov
 <oleg@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, Clark Williams
 <williams@redhat.com>, Yair Podemsky <ypodemsk@redhat.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCH v6 06/29] static_call: Add read-only-after-init static
 calls
Message-ID: <20251103093728.031042d0@mordecai>
In-Reply-To: <xhsmhqzujp9t3.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
References: <20251010153839.151763-1-vschneid@redhat.com>
	<20251010153839.151763-7-vschneid@redhat.com>
	<20251030112251.5afcf9ed@mordecai>
	<xhsmhqzujp9t3.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 31 Oct 2025 12:52:56 +0100
Valentin Schneider <vschneid@redhat.com> wrote:

> On 30/10/25 11:25, Petr Tesarik wrote:
> > On Fri, 10 Oct 2025 17:38:16 +0200
> > Valentin Schneider <vschneid@redhat.com> wrote:
> >  
> >> From: Josh Poimboeuf <jpoimboe@kernel.org>
> >>
> >> Deferring a code patching IPI is unsafe if the patched code is in a
> >> noinstr region.  In that case the text poke code must trigger an
> >> immediate IPI to all CPUs, which can rudely interrupt an isolated NO_HZ
> >> CPU running in userspace.
> >>
> >> If a noinstr static call only needs to be patched during boot, its key
> >> can be made ro-after-init to ensure it will never be patched at runtime.
> >>
> >> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> >> ---
> >>  include/linux/static_call.h | 16 ++++++++++++++++
> >>  1 file changed, 16 insertions(+)
> >>
> >> diff --git a/include/linux/static_call.h b/include/linux/static_call.h
> >> index 78a77a4ae0ea8..ea6ca57e2a829 100644
> >> --- a/include/linux/static_call.h
> >> +++ b/include/linux/static_call.h
> >> @@ -192,6 +192,14 @@ extern long __static_call_return0(void);
> >>      };								\
> >>      ARCH_DEFINE_STATIC_CALL_TRAMP(name, _func)
> >>
> >> +#define DEFINE_STATIC_CALL_RO(name, _func)				\
> >> +	DECLARE_STATIC_CALL(name, _func);				\
> >> +	struct static_call_key __ro_after_init STATIC_CALL_KEY(name) = {\
> >> +		.func = _func,						\
> >> +		.type = 1,						\
> >> +	};								\
> >> +	ARCH_DEFINE_STATIC_CALL_TRAMP(name, _func)
> >> +
> >>  #define DEFINE_STATIC_CALL_NULL(name, _func)				\
> >>      DECLARE_STATIC_CALL(name, _func);				\
> >>      struct static_call_key STATIC_CALL_KEY(name) = {		\
> >> @@ -200,6 +208,14 @@ extern long __static_call_return0(void);
> >>      };								\
> >>      ARCH_DEFINE_STATIC_CALL_NULL_TRAMP(name)
> >>
> >> +#define DEFINE_STATIC_CALL_NULL_RO(name, _func)				\
> >> +	DECLARE_STATIC_CALL(name, _func);				\
> >> +	struct static_call_key __ro_after_init STATIC_CALL_KEY(name) = {\
> >> +		.func = NULL,						\
> >> +		.type = 1,						\
> >> +	};								\
> >> +	ARCH_DEFINE_STATIC_CALL_NULL_TRAMP(name)
> >> +  
> >
> > I think it would be a good idea to add a comment describing when these
> > macros are supposed to be used, similar to the explanation you wrote for
> > the _NOINSTR variants. Just to provide a clue for people adding a new
> > static key in the future, because the commit message may become a bit
> > hard to find if there are a few cleanup patches on top.
> >  
> 
> I was about to write such a comment but I had another take; The _NOINSTR
> static key helpers are special and only relevant to IPI deferral; whereas
> the _RO helpers actually change the backing storage for the keys and as a
> bonus are used by the IPI deferral instrumentation.
> 
> IMO it's the same here for the static calls, it makes sense to mark the
> relevant ones as _RO regardless of IPI deferral.
> 
> I could however add a comment to ANNOTATE_NOINSTR_ALLOWED() itself,
> something like:
> 
> ```
> /*
>  * This is used to tell objtool that a given static key is safe to be used
>  * within .noinstr code, and it doesn't need to generate a warning about it.
>  *
>  * For more information, see tools/objtool/Documentation/objtool.txt,
>  * "non-RO static key usage in noinstr code"
>  */
> #define ANNOTATE_NOINSTR_ALLOWED(key) __ANNOTATE_NOINSTR_ALLOWED(key)
> ```

I agree, this makes more sense. Thank you!

Petr T
