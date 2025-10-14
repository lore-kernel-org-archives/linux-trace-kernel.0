Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3949C2EB85B
	for <linux-trace-kernel@vger.kernel.org>; Tue, 14 Oct 2025 11:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760439780; cv=none; b=XRKtIlHTGVzCJ3OBI48TptReaTMrCeBAHPqn0+6n1khSCwE9InyVLx6+xtuuD14ANyReRC6DK15N0dgbrQg2VtVWr0w6xAnFJDO/zkGR3EjJZT1c2J8Bro07POTZ8uqK1xrop8xZElBwQGVCfeFV+12CWFQTfeojmZIGzNzUKqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760439780; c=relaxed/simple;
	bh=/u5e/qJ2sRdwo1224SVU8XP3U/yMMEn1jbJARlu70Tk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=O7bugU8ahEDUGiYCq0JfY+S2Kvz1iIsxMH+NhUPUlsg2clVkW4W52KbuDXde1LlLzSyNC/nLcAjj9pROnPcfMnbzijDgWfXNHy+H5g4DRsmtl8ka8l0MLOmKgBr3X4sJ73V46LpXBxj7lk4ovOpi9t48He4fb3B2w1T1oWQrSIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Aiwx98kC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Aiwx98kC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760439778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s2r/L8/q4C9e2I164NDxUGdYhK/0nvlG6dMGzaNBqVg=;
	b=Aiwx98kCkH0m4vY0bP8NkMDPpsAlZjSL/yM2pxNm725ZwL2F2X1KqAbrMfmRnDeuVBEoMm
	0qNZra7t4U5X7E2Ti3cxc6gEEAXIQbv07RcUXBdUN1itnHiHAkwhaifdC/M+NEPPQ3jHep
	roIdiuHP+297Pg+pptVuRHOaE+NlCvc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-JzKA5gYcOJS1NqtH-6_YTw-1; Tue, 14 Oct 2025 07:02:57 -0400
X-MC-Unique: JzKA5gYcOJS1NqtH-6_YTw-1
X-Mimecast-MFC-AGG-ID: JzKA5gYcOJS1NqtH-6_YTw_1760439775
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-46e47d14dceso29787005e9.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 14 Oct 2025 04:02:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760439775; x=1761044575;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s2r/L8/q4C9e2I164NDxUGdYhK/0nvlG6dMGzaNBqVg=;
        b=QSIzgFG6BiyBfoEAWw4KAAAX39qK4rt2KSfdfWTduIqDdqjXkvPRIHyvVtrXzXZtHc
         3kaGCoidwvkypCTMBqj8oKab/OxpIhdEk84LTHgyglAkSxqsn+cHFojGgwme3tXI/VjN
         PNbJk0ki9/QR0oLbW3j8T6o6ePjMr4V+KE8d2X2iev+774o23FwbpUBBdlsHBoxZDbkD
         5K4XEvAPOccWJxRQzkq3W853yfoAwqQ0owyKPnm2U5k3Pxj0rAGdqmCrMsEgOSvWEY9i
         0H8oUZsQBHYPF+CUfaeJd4J1j/s8N0ktmrSEO+JxzLnj70b6Z+XA/HPKXyxK+7ptvVIr
         d6/g==
X-Forwarded-Encrypted: i=1; AJvYcCVtKgWTVPD5M94KZGLmwoS6AFEhpe3ztrIcgEl7fFd81NTT4+ocelIKrc5NbAXSPw4LCz5owsUDOtrHT32RYRVhGuI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywcm9xoq+8YHLny9p3lvQJ6ohyVQkot68t1zsQCt7CQK2h3hpnI
	qvjPDPDRTKrqiqGtILxNUGE+QmA9gq52LZIDbfvT9xisr/gqTEhe3ZWIg2MyW+mS83VcoiGWMJQ
	3M0FFwAwU476cj5MGZjBJKv0WmxT+oXE4hYfxz+U/dQYvNH+iBx1ILctMAYPFzJasc8SZFRvUyg
	==
X-Gm-Gg: ASbGncukd4Q01TqiK3fSHB5MVKz/MuPdBIFf+4Itl6Scz0PE5EqwCpqIKLSbiH3bZBq
	bwtpw4ejqRMXJIKfDkuD+k8WAwfCjGDYmOYha/JrkLnILdZA4ys7duw81QHm14O2RtSNxl3s8NG
	8uXRuOmLGp5EYhD0Q9dYiS10P4BlSLp8zMA5aBaTt4PAjTQ+IWo7g/dH6sS47w54XPP7PEkk62/
	WfDb7lL9xATbP4bZ5QSxbQRiy88HBboxyi+6RZNwm9SGRNCrrsmJuH/ezIVqVBTlWFCPOuw2sd9
	tPfvd60O7OL49VCHkYkxTWCOC9gwlJ67V2lWKXGXQDQ519VInvKzXShd1tklwrwmpiLkRerfUgh
	0c83SwtPm2MIRrPTzrhiR1sYrwA==
X-Received: by 2002:a05:600c:4752:b0:46e:3dad:31ea with SMTP id 5b1f17b1804b1-46fa9af8fb0mr181929195e9.17.1760439774550;
        Tue, 14 Oct 2025 04:02:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCodl08uTX0ubswP5nTiGxebtIpD1Qw4JnrqS3e+W7M5qhx4w6eQs0AuIjitoXX5t0l6/vwQ==
X-Received: by 2002:a05:600c:4752:b0:46e:3dad:31ea with SMTP id 5b1f17b1804b1-46fa9af8fb0mr181928825e9.17.1760439774097;
        Tue, 14 Oct 2025 04:02:54 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-135-146.abo.bbox.fr. [213.44.135.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426f2f72e18sm1737515f8f.0.2025.10.14.04.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 04:02:52 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, rcu@vger.kernel.org,
 x86@kernel.org, linux-arm-kernel@lists.infradead.org,
 loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
 linux-arch@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Josh
 Poimboeuf <jpoimboe@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave
 Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Frederic Weisbecker
 <frederic@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, Jason
 Baron <jbaron@akamai.com>, Steven Rostedt <rostedt@goodmis.org>, Ard
 Biesheuvel <ardb@kernel.org>, Sami Tolvanen <samitolvanen@google.com>,
 "David S. Miller" <davem@davemloft.net>, Neeraj Upadhyay
 <neeraj.upadhyay@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, Josh
 Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Uladzislau Rezki <urezki@gmail.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Mel Gorman <mgorman@suse.de>, Andrew
 Morton <akpm@linux-foundation.org>, Masahiro Yamada
 <masahiroy@kernel.org>, Han Shen <shenhan@google.com>, Rik van Riel
 <riel@surriel.com>, Jann Horn <jannh@google.com>, Dan Carpenter
 <dan.carpenter@linaro.org>, Oleg Nesterov <oleg@redhat.com>, Juri Lelli
 <juri.lelli@redhat.com>, Clark Williams <williams@redhat.com>, Yair
 Podemsky <ypodemsk@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Daniel Wagner <dwagner@suse.de>, Petr Tesarik <ptesarik@suse.com>
Subject: Re: [PATCH v6 19/29] KVM: VMX: Mark vmx_l1d_should flush and
 vmx_l1d_flush_cond keys as allowed in .noinstr
In-Reply-To: <aO2S3oZwOW_UgAci@google.com>
References: <20251010153839.151763-1-vschneid@redhat.com>
 <20251010153839.151763-20-vschneid@redhat.com>
 <aO2S3oZwOW_UgAci@google.com>
Date: Tue, 14 Oct 2025 13:02:50 +0200
Message-ID: <xhsmhwm4xpwyt.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: FvP-8nXv6Rmwd6yyfSqs4DqQQCbFC7VvRDG55th2BD0_1760439775
X-Mimecast-Originator: redhat.com
Content-Type: text/plain

On 13/10/25 17:01, Sean Christopherson wrote:
> On Fri, Oct 10, 2025, Valentin Schneider wrote:
>> Later commits will cause objtool to warn about static keys being used in
>> .noinstr sections in order to safely defer instruction patching IPIs
>> targeted at NOHZ_FULL CPUs.
>>
>> These keys are used in .noinstr code, and can be modified at runtime
>> (/proc/kernel/vmx* write). However it is not expected that they will be
>> flipped during latency-sensitive operations, and thus shouldn't be a source
>> of interference wrt the text patching IPI.
>>
>> Mark it to let objtool know not to warn about it.
>
> Can you elaborate in the changelog on what will happen if the key is toggle?
> IIUC, smp_text_poke_batch_finish() will force IPIs if noinstr code is being
> patched.

Right!

> Even just a small footnote like this:
>
>   Note, smp_text_poke_batch_finish() never defers IPIs if noinstr code is
>   being patched, i.e. this is purely about silencing objtool warnings.
>
> to make it clear that there's no bug/race being introduced.

Good point. How about:

"""
Later commits will cause objtool to warn about static keys being used in
.noinstr sections in order to safely defer instruction patching IPIs
targeted at NOHZ_FULL CPUs.

The VMX keys are used in .noinstr code, and can be modified at runtime
(/proc/kernel/vmx* write). However it is not expected that they will be
flipped during latency-sensitive operations, and thus shouldn't be a source
of interference for NOHZ_FULL CPUs wrt the text patching IPI.

Note, smp_text_poke_batch_finish() never defers IPIs if noinstr code is
being patched, i.e. this is purely to tell objtool we're okay with updates
to that key causing IPIs and to silence the associated objtool warning.
"""

