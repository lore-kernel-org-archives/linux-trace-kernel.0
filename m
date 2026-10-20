Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.176
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792500144;
	b=fn10wBNy1vgzeVAnFEQJT7abu4Af8O5GHeIhtiHWeEY81SP3N36gRQ1FGJXSiW8zQ8s4
	 lU5lGsg5kgGnHGQsDg5TIarKEBtpTJGpkFfkDD8/4er2JOjT/9B132EqvAyBGILkLdrah
	 UwCloSpbzGHiL7smOd9qtq2CJoBkuOHcPA2wbtCD4a3/hCVypa9yDpD6/prn0RPvtOhwj
	 yYfl7LZZiGRC5+ltt+7IWtjJia5uA4PN8ozEVD4V7UjfI1wTejP/zcGf3XqyHqK9c+/Up
	 58bgzJXbao7R2k4JU2AtvkWpkc0NYQ5Lm7h9JUIJwbHvpbWiOO2dqgOTx3P4FPf5JCA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792500144;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=e2sTq8rdN+VW7WxDK+7MxrZLHRc/4eEUgMwJJ4qrXBE=;
	b=rDYZ7UJ8aC2fnZlROBXqEfQY3KxLIL0ifjHdGH/S1LrjPcCZS8Ql2wPcbljG/TWKG6Ox
	 nO8/MZ7FBA9OIlgJCroWkIoytLnsirRrs94GCqOrUfA52Kpstn6ljwFq5gyXRABo/SD/Z
	 NAOSs3iln7AsHCjIE/H91ursveN/eISmN2/xNgkxOA4/RlFeaZEMqlgXE4ldDRJ2Tnjgl
	 /WRBRK2y24Dz51RID0o/8QQ7Qbs9kjeqPQNRmQ9cTzy2J3+Fq3+3VIzCW5c/Jvo0Q+R/V
	 yiJZcm6Um8nJinZ8khfUH+0Byrxy9pFbjN+YUcK++ARQoT1dytzt0d6txTBY/rb+1fQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=X2bq2x1u;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.176
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51420606A319
	for <linux-trace-kernel@vger.kernel.org>; Tue, 20 Oct 2026 12:42:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51420606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=X2bq2x1u
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-8b10ac6ab7bso14675827b3.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 20 Oct 2026 05:42:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792500143; cv=none;
        d=google.com; s=arc-20260327;
        b=p4LHH+BqSyHnhajgLxfdntko0L779mVirBK9vR1WBDECI7pMSQhFgoBHW65+PelTtp
         YqJvLmCtEr70HMcNJnFp0zSIeVfLak0RHwI8FRAfoFlSVuW8Vy312lk02TOC3ujFC8No
         KceZe7DfX+oVVdVniuzv8uvT4csqroaWeQZ1gxBDfH6bpqHtdE0Dxdu2ir562etXDzJY
         rIA8oFXsQaOYX6vQNlXx6vidqMPp9desJnbLjva73ueNqI/EHzsoGQyzy3RTl7dmUud/
         tseNs8OZwbvGp6iyflWViisPNPm78kodcAICwUS2nwOO5kqNy2rEM2zeOPhXxpGBXcnc
         5TjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=e2sTq8rdN+VW7WxDK+7MxrZLHRc/4eEUgMwJJ4qrXBE=;
        fh=LrQthyZj3GYHyh9O0gjBxqK6+mntAtPkgiOJaWmqIrg=;
        b=TkYdqgiDSJaNl6K312JGTCa6lBbgr+0nkXff2Yc5Ms0a5h8j5KkSyfBfGUOi1SCYxy
         704tQ8iA926sDmJPufO5k+cwTW2QwELs0rlT1PCVr2KLrrO9HRFh56UXlHl1XcRF+GxP
         tppAq218rZx0KdxZ8F+V66e1uSmLAguoHs0+quc1jf4/SGvnQAnV6As9W7GcN8fifO/F
         bNEnCZIHo+guJIBK0YiR+oo/pgVA4CB4GqpYufGdPnlUcyDn0QmsuObM3w2HHjzp18oo
         iNl2GEb8+k2kThzzg/kDexOfN98XqyqQTkYcSMGKZqLMEwUUdBEfhhWyKJjuUhJGq2up
         RxJw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792500143; x=1793104943; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=e2sTq8rdN+VW7WxDK+7MxrZLHRc/4eEUgMwJJ4qrXBE=;
        b=X2bq2x1uOcf5SD4Z1rIbzmkbLrI8X7gjghTiiwKnGmMU+A1Mu1M+kTp6pB/kZ9Sus3
         XroLWmoKSbwvHdyA606JeKhhkAgFC/ihv2EcRN8ibH/9qA+s3IDge2aIcrh0xgb3JSZT
         p1NAQX2GQ4hBVml/rEwnJs84BiBIdrTyzbjXRVklC9JlDcc97IAScjIN4Gip86rRP6zj
         irbssSe8iodF7VxHrlGve69pUeJ8jZGMnFyDS1HvsIMcz3mv0R6kJo89dSisMrJMzcoJ
         b7aZi7N/5KSl3zOXgx7xp1JRzMU+j60PFAOqgng2uycu28XGfwT2rALZI7VfI1iNnn9m
         O7Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792500143; x=1793104943;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e2sTq8rdN+VW7WxDK+7MxrZLHRc/4eEUgMwJJ4qrXBE=;
        b=ueObrcTCNGH5S1NAEGt3jy+Uyv9oYF7XzKQSzQdnM7AynbaZdMe/+1UPbX4Xv7Kz52
         Oh3JZ6cNuqXQ9eJeq2aKBMf6eh9GznGQR2XzbtgOFV13Kdwrbc9MuTHK2vLIwHYta4BK
         6wvv/RG9wK1SDaXRfIGPkZTLGYLMkFRsxveCo4x+l9qRuEKKd646U8+1UnkSFVRIXw5u
         U7IXlU41mZVeX6KaIG2HQ64Mke0hpwbQ+VzNsfHHkwHrrgQWnTQ9WKyLB1evkySwGA9f
         2ZrWfOfEvivzOjhSIzG7UB+wHUP2XWxvGkOMGJ6PtiUJlvm1wuypu/9FjXfTX0hpGu1Z
         xBCw==
X-Forwarded-Encrypted: i=1; AKwUvBzJtUbOLiUgCJNROkK055HLYx8haAqRK+UxkU4G7fEaPasnDI42To/hDoiPmZD2Tv5DF3jp/L/F4r5aT8szLPLeG2M=@vger.kernel.org
X-Gm-Message-State: AFq9FYKIcyeR/Mvom8ci0bnF4dT4GNfPifBu0wizfaKO3IWjpwh3Z4xw
	RF2/gr6QInrAi3jwlo/qZ8tyLiaFKzs5IYfAE2CN50yliYLxQMcdtzpsoEQq3WLjNvxjlQyM9yE
	YoZ15tdUUeNaDE0KW9ALoc21uJsAz+kE=
X-Gm-Gg: AYBFou2shfzLHxwFzf3TgN7KbG9yWET7vBpMeMD8RSQkWxDixzb3+ITrLuEb2cWnUxa
	sgKWmjNwyd7QtTdkdsloJ/2QqR4iSNH6+XBI/F50ZdMz+kH3N/c5Bu4HC7seZCmO/RskCqWRE0m
	DmSDUTVtJAQr6nbqgc3GuJkwbtOWj6c4CYPPSNCiaPoQ1W72BGVMXvpFuCFIatEdDZwVl48rKHn
	aU7w59b3Jq3hyV6i5kf7vhhfa24UcphYaP9G7NYd/mv0UyecWiiBcbsfiCmzH16ES7FXS1RzVa5
	8RGeWnIx4Yfrc75VN2ORQqZ25E+J3AFAoXZ1rdWD9aYPZ2DTlSK99gZHXVUQ27dRSg==
X-Received: by 2002:a05:690c:a686:b0:871:bc3:9856 with SMTP id
 00721157ae682-8b0f21ae1a6mr25138067b3.33.1792500143092; Tue, 20 Oct 2026
 05:42:23 -0700 (PDT)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261018-tlb_tracepoint-v6-1-14476427870f@gmail.com>
 <20261019100029.32a09f71@gandalf.local.home> <CALsPMBOKENath9-6pUoPrrSRbuudg0V9tc76bLcxsnkQJJkvgQ@mail.gmail.com>
 <20261019142644.5f02d139@gandalf.local.home>
In-Reply-To: <20261019142644.5f02d139@gandalf.local.home>
From: Roman Storozhenko <romeusmeister@gmail.com>
Date: Tue, 20 Oct 2026 14:42:11 +0200
X-Gm-Features: AclHuK8dqEhVh2tz4HUjh8KpGEYzpZopHeRe1CVlc-2n0yq-l7w7CGlJ9Twyn-s
Message-ID: <CALsPMBNVuwwmf51186gu8K-KeQQtSBBVjbg+z57xuMa+nr=DEA@mail.gmail.com>
Subject: Re: [PATCH v6] riscv: mm: Trace TLB flush requests
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jisheng Zhang <jszhang@kernel.org>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2026 at 8:26=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Mon, 19 Oct 2026 19:24:17 +0200
> Roman Storozhenko <romeusmeister@gmail.com> wrote:
>
> > I've renamed the header to arch/riscv/include/asm/tlb_trace.h
> > in v7. I prefer this over riscv_trace.h because the latter
> > sounds too generic for a header dedicated to TLB tracing.
> >
> > Did you have a broader use in mind, such as including other
> > RISC-V tracepoints in this header?
> >
> > If you still prefer riscv_trace.h, I'm happy to reconsider.
>
> Either riscv_trace.h or tlb_trace.h in the riscv directory is fine with m=
e.
> It's more of a decision for the RISCV maintainers. If you plan on having
> more RISCV specific trace events, do you want them all in one header, or
> will each have their own "trace_*.h" header?
>
> I'm fine either way, as long as they are named with "trace" in them in
> order to acknowledge that they define trace events.
>
> -- Steve

Thanks for the clarification, Steve.

I'll keep tlb_trace.h for TLB-specific events. If I introduce
tracepoints for other RISC-V subsystems in the future, I'd
prefer separate headers following the <subsystem_name>_trace.h
naming convention.

--=20
Kind regards,
Roman 'Hedin' Storozhenko
