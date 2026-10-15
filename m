Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA06141D4FE
	for <linux-trace-kernel@vger.kernel.org>; Thu, 15 Oct 2026 17:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792084111; cv=pass; b=URYeroxiVFjMfomVVg9PQN2IEV841zuuFnmyrRBVW7ReBf9QJtnDlNd23zGbugXSnSt7QqVnXELU8IkLUXw+2UZ/niN21oJ5QfDWfMuBVx0ItCcvzgq/tyfSgwxgMmx2MmKIDr1Cr1IwNc/C0mX3S010oxMaQweB2Y3jE8agaEM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792084111; c=relaxed/simple;
	bh=EOjLYNLitfJIInUWIMI+uegThTaF0Q0MItF25km4ERw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZdiVXmlp2cB339wFQhUb3wHkCaAKdkxkiCS1Ors1JiqtDAojl7FYxGXUYpKRd4XSQXDKM328rq4+yz1vC1JiU5qRiWUEyF232naGOJULM3rmGIj+XqA5KlUHtzGSrpxx/W8Mjpqa4ODJPuSE76Lft+RA/rwjRw+124GJmDztvUU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KluOiBYR; arc=pass smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KluOiBYR"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-885cf67963eso46886887b3.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 15 Oct 2026 10:08:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792084099; cv=none;
        d=google.com; s=arc-20260327;
        b=fP7K6iMN5yl1+9rBl/g27mcdq9j+DT2eIpyYBCB+w+ogZOde2WBOuIu0vS7Qs+KwWU
         HzDHmdzhbaQmxCgqSLCqGIvyJS/ASShDRu5p7q3xdfjGW35aef9jI1jTCV3I1sV1AlL8
         ePkhJnXRWR5WPQGPTAIzR7Om717pfllhuOlhqNa180gdDP3L7MwZs+nAZNoXXv2aiUF4
         vYLax6ntiJXE0AmyYFENqydqKV4UMFlxb7gmO9Ruhbm5KjvPfq/I2FZZ6DgdPOxNZn7S
         7IRAoWTk/zeG6qtERS3xOgNqvwN93ujzGE2dV+Jb1VaLce0Ju007EFfDekq+bCen41x0
         I2Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EOjLYNLitfJIInUWIMI+uegThTaF0Q0MItF25km4ERw=;
        fh=dsqqzPxbsvBtEstr/DhOp8vQW7Xp5v1ehC4kB1zLcTQ=;
        b=QBcis7/MNld1/QwIVt+50FrRZslRu77z21UGvHQyjpyb+HCSZE2pShPykrfJ8LgZOY
         1qgqYvOuvsSBvED00nwsqJ7tc3iIunYzEXCnZKGaZpA5lmgrF/25hGlv3sLigzUi2NZG
         pOx1rurX33QXIETMVjEIFTxbitHr1996wAi0JlI3UJ2f1qmmY//W1BPge9sZU2mLehpP
         vF1JCOY78KzTeyoMDUFN4z2PNEUtfZ99zk61pW+Jgn9ma8immzZOwijI0FXhc9dTGvpi
         7Evi/hd3NhbNLPy3mgyOlrY7D3cJAynRCG/KUvAo14NChRxGceRlCGIT6XIBvn4JIgRn
         Aj2w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792084099; x=1792688899; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EOjLYNLitfJIInUWIMI+uegThTaF0Q0MItF25km4ERw=;
        b=KluOiBYR+Gc9ncxw0pNcpcD/PdE3PjObqMvaHbPT1JihX3nk8yDwvZziqUatYEm4cE
         KKKla/62ENBwAB6amjByEuAbJIW9c+Vpz6IdLIxbggtD2NC/vMcotHX9KXZxYZR3c+M/
         AkfC9hSE+rTTG7IPAXPyiqoz1fpW6MnDjGQAROjCLiQRFpleX4d7bTdOS06flb9pST6Y
         CGcPgRupacOdbBmGmJwiR0l3RkQhaau0sjd9Lr51L9zunPDcoHYlU/rYryFOcBOoIQqn
         hwzOc8gaa3S/dlLCVn4mJiSXyyRXjY8dQ5SOrICW//eeRPPB9RY7d4cFKZaZd9M5BAcC
         yDRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792084099; x=1792688899;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EOjLYNLitfJIInUWIMI+uegThTaF0Q0MItF25km4ERw=;
        b=cP8sg9WM98Zj86ocQq7ENZjjO43HyGrLivpg9hGByJJs84A9lwzAyoW+d7My0fwhOI
         c0k+O7P2/EOH+1qSqbnMgZsQWxJCOmZtGBbqdHSWqZMJkjvVmTIdHybkc2z8k836P0p3
         I93RU5c3MxScdEktYdEoZkXV6AHQRGPqK/3qFLrUzYO2vPqMF5spbaum3OsuwtQenhLb
         IDNHLCYF6WE8Nl2cVUO+cOCsfox1x3x9Q5wG3wO4Ocgn/iozXT44B3uYFG2eQ/CrGnb9
         Oac7kI0zj6Z/j4lvKrYx8BsOLnVnKk5XKsfFSCfPpZvHdaDMYDuIEA+O1urx2sM0oOEJ
         xUYw==
X-Forwarded-Encrypted: i=1; AKwUvBwVLgIeGsYYI3FzOBFy7d2foqep4OEcND1vcgtloPeryCkdl05Is1BnWY2roOLf/aYSB88Mx6iTAHSFyis2Pn2zgIE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJGEhGiaXRQJTc3EFWISkeoBQt31cJOkHgCJBpIZiON7DTFckpR
	l615r9sDLYv+dzn/iminYI6uCnMfVxyd3jams3u/a2zjR3IPpRNQNI3g4tG2ZnbDXeafhku6PIe
	he9wKgWuxtcWlTe6aBiHyPGAMVMzGzxA=
X-Gm-Gg: AYBFou20TYcbrpMTtnJ4xGehbAtRNo6+Jlus3M2NZbU7253WJ4luixTz9wFSOnTn0mf
	eLaMooPqACtXe0FEtqAd6wVgSMvr8Ng2/jC+pUXwaibec/PS2K4q08bYf+yf+d8VG3qebgdheZX
	c6/k2m9kzOhyDa99267t+yZfWOhfVQhXzst7DYTJG5PbTEQq2px1Djdllo6O+ypFY5anlsAxALe
	lsjAuz4NlM9GpAZbzP/7c6gmtQpbmOh0SOQ4fO1k+2EtBj8ZCFsPqrS1hvq8fazPoR5wkZc5kxv
	6KVDM2gOQAty1LAxFUBGn9gW7auTTyV07aHo7MkXbHlEMu5X5vpn0ghG
X-Received: by 2002:a05:690c:e681:10b0:88f:73b0:fa87 with SMTP id
 00721157ae682-8b07edb0e20mr57149977b3.11.1792084099608; Thu, 15 Oct 2026
 10:08:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260830-tlb_tracepoint-v2-1-e3c88c24df5b@gmail.com>
 <ar_Rathmoj2aP-H7@xhacker> <CALsPMBOYQbro2gZTQR=DSUowmVDs9kujH4ua2UzCoHAQrncuiw@mail.gmail.com>
 <asm95GdbmMpc81p3@xhacker> <CALsPMBPMHc7q-YZvqLLYDSr5RfLmDRwBSq-TFeB8Fc8bPBjQGg@mail.gmail.com>
 <as8NpaT0g9Tsl6PS@xhacker> <CALsPMBOdy4ZDWfnkYokUFuB3UYPV27wTUpBCZaxLWEV10ZuS=A@mail.gmail.com>
 <atAROTefufggiFPO@xhacker> <atBWGQ2iWpm2VKcY@xhacker>
In-Reply-To: <atBWGQ2iWpm2VKcY@xhacker>
From: Roman Storozhenko <romeusmeister@gmail.com>
Date: Thu, 15 Oct 2026 19:08:08 +0200
X-Gm-Features: AclHuK_WwwJkKlFZfudhhQDlIMbwbspdMnarcp4gCr6CQeC65hQ3jIZC2-gsXTE
Message-ID: <CALsPMBPNKsnSAczyVm3LFFQjwRg8eiGgpB2hJN19iipRZ0mASA@mail.gmail.com>
Subject: Re: [PATCH v2] riscv: mm: Trace TLB flush path selection
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	=?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 6:47=E2=80=AFAM Jisheng Zhang <jszhang@kernel.org> =
wrote:
>
> On Thu, Oct 15, 2026 at 07:33:13AM +0800, Jisheng Zhang wrote:
> > On Wed, Oct 14, 2026 at 05:58:42PM +0200, Roman Storozhenko wrote:
> > I think you misunderstood something. A riscv platform uses either
> > SBI RFENCE or IPI for tlb shootdown, and won't change. So you can
> > know whether the system is SBI RFENCE powered or IPI powered by
> > cat /proc/interrupts. It's much simpler.
>
> Aha, I missed aclint sswi case, if sswi, no explict /proc/interrupts
> difference between sswi and traditonal plic. However, whether TLB is
> powered by SBI RFENCE or IPI can still be known by checking
> "providing IPIs using SBI IPI extension" in dmesg.

Thanks, I see your point now.

I was treating SBI RFENCE vs the Linux cross-CPU path as part of the
per-request selection, but with the current implementation
riscv_sbi_for_rfence is effectively a system-wide choice established
during initialization.

I reworked the patch in v3 based on your feedback. The tracepoint no
longer reports the local/SBI RFENCE/cross-CPU implementation path.
Instead, it describes the semantic TLB invalidation request itself,
including the range, stride, ASID, target CPU mask and request scope.

I still think there is value in exposing this information as one
semantic event. The individual pieces can be reconstructed with dynamic
tracing, but having them together makes it straightforward to analyze
the distribution and characteristics of TLB invalidations across a
workload without depending on the current implementation details.

The v3 patch is here:

https://lore.kernel.org/all/20261015-tlb_tracepoint-v3-1-eef305a3bb63@gmail=
.com/

Thanks for pointing out the distinction. It helped simplify the event
and make its abstraction clearer.

--=20
Kind regards,
Roman 'Hedin' Storozhenko
