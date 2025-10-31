Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CAA333728
	for <linux-trace-kernel@vger.kernel.org>; Fri, 31 Oct 2025 09:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761904546; cv=none; b=vD05zaHLZ17DaKCpN4oMfFLB/hdiB4BhqVYjuGYOLjZ56z720q8LRFf16OQ7hhcYbwdGi/TYD5rMUoKHlH0dVHPI9yVQ3IU+aWWDheka+mdl3W7uxBSd1lr3VLz7ad4MtBcRNxE8aIJ2dpYrs0K1MhJMuuBqw8BsaSrVmiEiVps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761904546; c=relaxed/simple;
	bh=3tkSelHNNZtYzi5EY8XsAlaXp+ewc844ITqqtJnf0nc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QkbfYmttmjU32tCIudxZg8WIDVqpYVTzU3zlXKXFoyJcIm8rNy5YVGPxDTuOv17NHSER2IHkRRp6GEFoSvwbYEqClVX7uz6Ury1tIX06KnkQZg3dMbo/MfY4FRFkmxFkYxh7CFyJ8srSeYjr682Uh7BekgOS4aZPkWk66SaV1gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bpBBqzgz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bpBBqzgz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761904544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3tkSelHNNZtYzi5EY8XsAlaXp+ewc844ITqqtJnf0nc=;
	b=bpBBqzgzyBPK/o1+KI7xY2Hdl23T1HrQlMCltBf2NUq8qpOltbMBUOS818/SuRG744qQZk
	lokwwn0n59QrntvBa/EqWrwlnViS4Jh2FWjPSArTH54VrpG7sQgUw+KETRQR19jrY5p2Ur
	PoMst+vhP6HzcM+zMnc/hQomP6p4GfA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-4aILenCfPT2oK9lIx6_mgg-1; Fri, 31 Oct 2025 05:55:40 -0400
X-MC-Unique: 4aILenCfPT2oK9lIx6_mgg-1
X-Mimecast-MFC-AGG-ID: 4aILenCfPT2oK9lIx6_mgg_1761904539
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-429a7f1ed1bso933020f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 31 Oct 2025 02:55:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761904539; x=1762509339;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kTCg+N3NYwBLqF+pIITZOoHrF01dYEOCOu0+H1nRDT0=;
        b=ev9UAQn7ln79TQam6EHFaIqagubTl8cCL3Us6u8b+VM8QDZ8g/NWJRqlbv4oN85pKi
         tWS0+KDVE3NWjMSV3RHJDTv62L0fCrheI3N8+SvSP0iAxIIRh16Rs7KT04wsfgE0h7p2
         zBuHiRirlfxhAmN3RPhFBfiSLL3yN3epgy+5xTeEPZTR7Pw0PNAAJNUiP/VgQqVKFY6F
         GSjLZW8gpaME1mlaIc00RQxP9pen17c6vSsN7+1bdgoh3lRqPhMFH3WzBTpIjEChjPs7
         mBmvdBfetltyow9g89TGSRY4qUeSNpRAyucXwJVyKQYDcJXc8QtWbZgbhcopw4gW9HKU
         l4xQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxuNUUu1eXGPror9TtAFPckB/g8mLxyPsRGmyxFU4nTi8hv8JaR8/S97l+K5blmeWe93ycju04ETjgLzpGdG4R/8o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+trMkgNweDPc5rWgMxOB2L0dHg0wz/JJ2kxWxCI5a4FSflFXL
	AY9Yy44PEoaxdgjh8kOrbnPYcGNeEASBAe2MgRdcst1YZ82bWbXTWFOqQxfS9MOPY/rvnbbQCXt
	kCrMxKV7FQn/cW0PT6HWvNPeHbO3xBO+BUrA+aeiUUEZz1K78CQg3+y8gHyGFICyaIzhmKr94yQ
	==
X-Gm-Gg: ASbGnctjuIlq5egiUNd1ZRyDiUZX7hNemN9Og9zRtKtBC8kVy2D5yo+JHtL+bqCrxNZ
	A2XR2qJW0K2GLmgKrOdzanXOQn+2Bt/oYBsBFkcH6sJpcaJfDouzm6txBAdKSKEOdCbWAshJtVn
	p9HLJm3B5pNP7MNfbiTQMqSrD5NFCZY/RWepaqhn1xcORmoMXFUVes3JL5cLojUNVq8/Gi0DbMS
	Qs7B341BmBKF54tEJ0zZcjC14oKWNZQb6pZreHu0eFWNKJNgFMEQG1IqggKI4+3mBvE8kckRogY
	m6xJkdnyfJLRJEVQXmqaMeN96jbODWFw8odPHjaguAQhAfTbyH6MHCvvGrD4zs6xtC8bDPZ3vfp
	g46e6kKbNxCbx+zpw2N2JIvsidWUDhJ6LW76Noa4JZl4JU0pFNaWfn1bj+bXb
X-Received: by 2002:a05:6000:310f:b0:40f:5eb7:f24a with SMTP id ffacd0b85a97d-429bd68869amr2437815f8f.12.1761904539498;
        Fri, 31 Oct 2025 02:55:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbUxApmJAOYlrcJigfNqaTRZ7Pz52J94NiUAhMgZ/Qwj+7BmCVMNCnPqwOLJ11D9kpjdgFWQ==
X-Received: by 2002:a05:6000:310f:b0:40f:5eb7:f24a with SMTP id ffacd0b85a97d-429bd68869amr2437793f8f.12.1761904539055;
        Fri, 31 Oct 2025 02:55:39 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-135-146.abo.bbox.fr. [213.44.135.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c1406a45sm2624895f8f.47.2025.10.31.02.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 02:55:38 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Frederic Weisbecker <frederic@kernel.org>
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
Subject: Re: [RFC PATCH v6 27/29] x86/mm/pti: Implement a TLB flush
 immediately after a switch to kernel CR3
In-Reply-To: <aQIpXyX-z8ltB1i5@localhost.localdomain>
References: <20251010153839.151763-1-vschneid@redhat.com>
 <20251010153839.151763-28-vschneid@redhat.com>
 <aQDoVAs5UZwQo-ds@localhost.localdomain>
 <xhsmh3472qah4.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <aQHtBudA4aw4a3gT@localhost.localdomain>
 <xhsmhwm4dpzh4.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <aQIpXyX-z8ltB1i5@localhost.localdomain>
Date: Fri, 31 Oct 2025 10:55:36 +0100
Message-ID: <xhsmhtszfpf8n.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fgDTZtWMNhGTD9_pDks-PrFnpYEdJl3-FytZhw-Rgpc_1761904539
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 29/10/25 15:49, Frederic Weisbecker wrote:
> Le Wed, Oct 29, 2025 at 03:13:59PM +0100, Valentin Schneider a =C3=A9crit=
 :
>> Given we have ALTERNATIVE's in there I assume something like a
>> boot-time-driven static key could do, but I haven't found out yet if and
>> how that can be shoved in an ASM file.
>
> Right, I thought I had seen static keys in ASM already but I can't find i=
t
> anymore. arch/x86/include/asm/jump_label.h is full of reusable magic
> though.
>

I got something ugly that /seems/ to work, now to spend twice the time to
clean it up :-)

> Thanks.
>
> --
> Frederic Weisbecker
> SUSE Labs

