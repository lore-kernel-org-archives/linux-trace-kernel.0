Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16F72D8DD0
	for <linux-trace-kernel@vger.kernel.org>; Fri, 21 Nov 2025 17:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763746637; cv=none; b=sLd8SIHwCvgaZaDsnm7Qaw+AgeU3Z/eui9m6o3kNNdiiRd6JSFwDbzspI67sQZoYVRz6C60vTqokatRTDVGmbzskzl4TVhZcsaDCC+4ai3uFv+UJfNxtTabTGcTBGEz6/A4IM3BokWGMCzly31DbrfnlUMY6JWgRiH/Uwg4utfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763746637; c=relaxed/simple;
	bh=R6+it4z+8J3tQq6khArTa00xBA3LI+Aiux4czwnNIBo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cYqOwf6E8fZ5ikoZCcb8zES4ikdhmx9nQAZtaOvjy3suOr7Fkoap0V66yiBT1o8yXl7vIxFgc0HhaEkPKmC/2WICjA3FL2nXItBtS6KdLwuJ9T6OZOzPzF42GhtVvTiUFMlJ2WmxI6Y+3P2A4fepvGBdimzIK9fn/6Ds0sX31lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OJRkF1yN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OJRkF1yN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763746634;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V3OE0zpMaGFe7FLO1SjE8KbYNBSyHZmUa+LcldBnwuQ=;
	b=OJRkF1yNZxr96JULB17P9/EUvhx1Ox0XH45RgxSDoXu12qcbb2Fsx2+fxxBe6klYybU212
	b+CpIW1WpaAYjcedmq2yVuzD9sRdjiy+lOZskX/WCBt0hAdREv4ja0gbYzdaO7ZAFZMslh
	wmXNjDsfgRVSWVwv2Koi4mQtjF9zlTE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-Q8wT3Ft1MaiHdl8AyeoHJA-1; Fri, 21 Nov 2025 12:37:13 -0500
X-MC-Unique: Q8wT3Ft1MaiHdl8AyeoHJA-1
X-Mimecast-MFC-AGG-ID: Q8wT3Ft1MaiHdl8AyeoHJA_1763746632
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-42b3086a055so1993218f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 21 Nov 2025 09:37:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763746632; x=1764351432;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V3OE0zpMaGFe7FLO1SjE8KbYNBSyHZmUa+LcldBnwuQ=;
        b=VEGqPEAeqiDRTMz/cIQMPu6MgFrgXOZyIQx7J12ahYsM7BWSLqSeRLOVyDuVb198Bd
         JYoyLgW5sipZj9PknBfFempE0UY6Ut0cJl5z38oVEWKeOMEv9QjfZLExKfAvoLJhDz6d
         jmOdKDlE7amTyWgJ5QAloVF4E64WkehzKwlk7RxvFBRk+e6wvCDbYFLVYd30psXWC2Pn
         K+RVDeJERVkXY5pLrEMgnD2FY2xweF1+ibHrgBOjrk20qPTu4SiiAkjtumE2q5wicUvh
         umjhAe/IbJoNiDtZiOSGuwyrKprbka79l+vpf/Rnat25rC23u3WlGu2hm7CaUIsTxdDd
         Nh3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUcUEb+8a5onYAkBb6BhfoUnw7XMQDYPlOQC/V5ohtKmo1fVYsmdms8Th+esi0tBLZDgHbqmLjdhE1Y9K8qeC8Lwm4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcrFK8T05jWIsABjmV+4AmJ6sRwwLa1fPvmvoK4YdiJ2tvJevD
	27Bh+Vm+pM8+SZKAVbf4OVH0HdsKl0GKKqZkoukgP7pQbutDgleazQTBvr5xn7P2uqxAobrxJJR
	nggwLaQGyciaoSBbMmkJ54AhZpgsVa5sSBgDrRSwcwkVAt4kuSyycYgYniNnMQkjCrUdfODA2Xg
	==
X-Gm-Gg: ASbGncucox2RtlCWSsN+VPTWCmijx8qK0QQILAIF388+wPosjZzZcxMQT4Iw2ZHqxpR
	tzwxgC4NvO+vEud2AjmFo2LjiHeU79nDyFJxuw+2aYOGOclJt8Q21npGOKbCi9mB0XwO1jXpflB
	fQ6FqwZgJoh5OgSc/rwNFhhZDMfouM1oF8wKfv6n9xXkrx2J97H2dK9Q9W7A2YKIPVVzN0bsCF8
	LoRbBzXp9vadqAeKD6/tMVLajFbxrv3YXQplkGNdh8RLbXGvXvq5AF95lWUAZmMRwQ0TMpvLKdg
	f6qDYysPjSzywfQJxyQ/2jTwPaazna3GQYqPpnXw7zWcbUeBSi//HFZyiH0T3hBMrEAWhhxASAD
	0KjkPhIEDaBSvA/WIZ5XWK2RnKvybexnGwjb6x9BxBu/IgH1pAihyQL01Ak2LhYKJtrrJGYs=
X-Received: by 2002:a05:6000:2282:b0:42b:3ab7:b8b9 with SMTP id ffacd0b85a97d-42cc1cbd0dcmr3334293f8f.20.1763746632014;
        Fri, 21 Nov 2025 09:37:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFwrptJrvQrMlATO+zOU3GD53XUKYoEIwVBRtwZMVM9uxcxDwDk+rU+CpbkpyNs1Ksl4qe7Bg==
X-Received: by 2002:a05:6000:2282:b0:42b:3ab7:b8b9 with SMTP id ffacd0b85a97d-42cc1cbd0dcmr3334227f8f.20.1763746631366;
        Fri, 21 Nov 2025 09:37:11 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-135-146.abo.bbox.fr. [213.44.135.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cc231dc6esm4094867f8f.7.2025.11.21.09.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 09:37:10 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, rcu@vger.kernel.org, x86@kernel.org,
 linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
 linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter
 Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, Paolo Bonzini
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
 Daniel Wagner <dwagner@suse.de>, Petr Tesarik <ptesarik@suse.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>
Subject: Re: [RFC PATCH v7 30/31] x86/mm, mm/vmalloc: Defer kernel TLB flush
 IPIs under CONFIG_COALESCE_TLBI=y
In-Reply-To: <bad9eaaa-561a-498a-90d1-fe3a3ab8ba37@intel.com>
References: <20251114150133.1056710-1-vschneid@redhat.com>
 <20251114151428.1064524-10-vschneid@redhat.com>
 <bad9eaaa-561a-498a-90d1-fe3a3ab8ba37@intel.com>
Date: Fri, 21 Nov 2025 18:37:09 +0100
Message-ID: <xhsmh5xb3thh6.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: rIRV0uyuBKu60vIucDTtiqVwALBmuwjQiqvycI_D2tc_1763746632
X-Mimecast-Originator: redhat.com
Content-Type: text/plain

On 19/11/25 10:31, Dave Hansen wrote:
> On 11/14/25 07:14, Valentin Schneider wrote:
>> +static bool flush_tlb_kernel_cond(int cpu, void *info)
>> +{
>> +	return housekeeping_cpu(cpu, HK_TYPE_KERNEL_NOISE) ||
>> +	       per_cpu(kernel_cr3_loaded, cpu);
>> +}
>
> Is it OK that 'kernel_cr3_loaded' can be be stale? Since it's not part
> of the instruction that actually sets CR3, there's a window between when
> 'kernel_cr3_loaded' is set (or cleared) and CR3 is actually written.
>
> Is that OK?
>
> It seems like it could lead to both unnecessary IPIs being sent and for
> IPIs to be missed.
>

So the pattern is

  SWITCH_TO_KERNEL_CR3
  FLUSH
  KERNEL_CR3_LOADED := 1

  KERNEL_CR3_LOADED := 0
  SWITCH_TO_USER_CR3


The 0 -> 1 transition has a window between the unconditional flush and the
write to 1 where a remote flush IPI may be omitted. Given that the write is
immediately following the unconditional flush, that would really be just
two flushes racing with each other, but I could punt the kernel_cr3_loaded
write above the unconditional flush.

The 1 -> 0 transition is less problematic, worst case a remote flush races
with the CPU returning to userspace and it'll get interrupted back to
kernelspace.

