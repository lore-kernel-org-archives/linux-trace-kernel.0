Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F6432B13E
	for <linux-trace-kernel@vger.kernel.org>; Sat, 17 Oct 2026 14:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792245836; cv=pass; b=TRRtnvuw9ue+NJQKdXSUe7p4odwY1Ynug9LTTu4YFeF+3LidAFwfoWeQsFuQXON5S458Mbm792aetwZeXjTubeE/NrrSUPDnaMGahSbO7yugb6XF1uSw9FjhFMbulgI6geFEL6wnLRUWA7jNCxNowxfc9s4XFraVkvSk07rJon8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792245836; c=relaxed/simple;
	bh=Q/dWGxF+K2INO9x1LZXl2OEUxrgdNRguf9DssJID3vQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jf7CYN2Oyr1M14omTY5iSRczYU/LS+LJ/UszbfYNrZNB8VWh2a753Oo1VWuKj5Ygm/01KcIatnvfe4e2jJcJf8h42wHp9n1gSpF6SQXPdplsfUDMJr1qjWE3BP4K7KRLdYfIXaQ0nTrdSC9za8aNECJNjNDweGGNg0gGaB1VUO8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hXsvu48A; arc=pass smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hXsvu48A"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5ba3ac592faso877606e87.0
        for <linux-trace-kernel@vger.kernel.org>; Sat, 17 Oct 2026 07:03:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792245833; cv=none;
        d=google.com; s=arc-20260327;
        b=H13DcdYtP6COUwQkjFY+B5rJHpOwbiOgdtwTUriPNbYcLF1wtB7qOixmhaz/TYRv7b
         4Rh8w9EPPQVgLRSJa84HwvwO+FY++HhXApjHyBcXh3iRYWAjgn/fGO5DPuJE1Bhga8gI
         E7bODZhZHgwWdWRgVRHmG8fWEVXm6E++7HTDECjMdO63MA1NWLlItqXiQ90UO8gP18Nv
         sf+5vqIdTlwYXhOZnYH44z1smycv+McF2/Uh8oUokFpqU2CphDCDF55hru10hbQtiRec
         Lkdr7O4swhKf9ewFzYrybBjlskk4PSNXbb4sm4pP8ZroW+pcIbt1Mi12urWNSKvp6YIF
         wdWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+OsE2x5Pqitm8v/Z0qp1dkwtBd3ch11zvLF7iHqatxI=;
        fh=HPG5X85OzBsycd3DUzHXMEINQX4ml0Ijl5LLMlFBjwI=;
        b=Fm+S2T4BncWqNoglqVLND5X0W56iRkDTRaayRfKMMRrp8VNAEmnBppQFj7DwzBy5PA
         mpBndJgBJ5WCEQsxPxGQ1z+4A116Pcvi4anYpW8Tt7utyWX2kjehpqXHRb91SkbD+pFA
         xrlI0mao2Zs/cxZg11ZnQOGWpxsBa2SbINwUR6GGyl8vrAKld8nuXJDrs+SplAYrpC2J
         LYNFIqpWzE6zxw6ki08UjaVMRnY4uLhKI14ZK1td6KlJYSrl2+HoVPRaTh4CGd1kn0bu
         o6ql4hFrZSFK4Mp+X19yO6Uk+VC3qr0lOamjzzmjgjMxTivfiaQ4w62WSXXd5fda/1bX
         y1zQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792245833; x=1792850633; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+OsE2x5Pqitm8v/Z0qp1dkwtBd3ch11zvLF7iHqatxI=;
        b=hXsvu48AJy+/+LX0sQ4R11DVxj1D0bH2chCf+T4srbd5lwAx8bbc5TEIqEFj3jo4Oi
         UCciJ9g51VUIzdYf1fm0YGFS9AdMCuRwmOGRN45R+ZaAc7Ca+P/E8F/iSsD76jgAEgWr
         DfZaWi1PJ+zX/Ginb1JZN9or7savwh1lJ2Dfd5gHfMr+EkfCSmQNom7fDdLSay+jCJV5
         XxXzucUunCG2LC6qWN6ANX+KaSkx9SHL9y19ggjlZ8G7xEeejsIW8HZ/ygbyxmcRK0y4
         JGLT+vqU1/y9R/sVyZGnompKUq+ECLYwcUXVyjUWiVaPK3DMxpMwzmZmhSv75CxZQAEN
         EkFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792245833; x=1792850633;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+OsE2x5Pqitm8v/Z0qp1dkwtBd3ch11zvLF7iHqatxI=;
        b=vqk0bAg5dHqRC9BESx4OkI6V/bfh1nrIZdzs3YG8lzJ6sAYtMLY5Y2OxmQhoKa6b1R
         hufRMvbvdTlVkdvEhqGs3HMlHCIEnG442gOwaqz1qpSIqbeeRht/6rIiC3LzgAQNUcQW
         6H44tqhRXCT4bhrF9OzvddE9fmSuTIKeGGAVbMRF6NliAZuSZ4FDdeTghE0K51TeFGim
         tbbTjYFVe/qtlX5Gcj+UQn55Uyh9KFrmyco/uF97AD0NSAPeW7PyGXCizzstlbGgTZTJ
         3OdUFK9/kWknVslrP/yJL5Dh48otjKr+zP/b1EfrJ324mpdKvkw421BaAXLVVRsRsMZF
         bg9g==
X-Forwarded-Encrypted: i=1; AKwUvBz4y0dJjPp0dTpPyIBqoDrGrAubBIf41Bl4QBgOKqt++4H0Lm0WCW8mlt3sV7BsyuyRGdCnHC0WiPSnCxU1JyVfHMc=@vger.kernel.org
X-Gm-Message-State: AFq9FYIN74Vepx58OWskc/nNjxQLGqSMXbv9jdXf4aElGJNC62ATM7r3
	jk6uoTgflMIZxAaAH53HosSugnFQPjWvMAo0lgKZTR4I/U5Pa/8OlOxBW3sSdYmPIoWX3e0KwDR
	KFrd0L4/pGU95EhlmdwltbekH6CSlu58=
X-Gm-Gg: AYBFou2Ra7mMzlyDrHFOo1IbW0mcre9PiQ/bzaUXRHuUlPAnwsmKRMHQ5dn3Snl8psK
	nEa5PcHGEcunJHD7yS6xDKjOG1WxYeSdQb/ZDEwXtNjXgB0KIyoLo/iYVTISZTf5xw+84CZ21VP
	9nVg1X8I+Vgcpph8GQcU1ZBVfpcpKAdJA3twkVBGm9zzP2fZ9U7aWALPyF2u9As5rBrfiy8owKq
	AwH/vHxkwoBLTbinssFOPpBlPKgF2s6xQa2qA1AhAKGnJliBjgVGBJ3k5WAznXafE0HHEU7qoik
	Isbw4li45dYUw8cn57Pl3Y+uJzo6LlSytwb7uOHvX+s7xrmRemcjvmtjpeRSmL66GA==
X-Received: by 2002:a05:6512:3c89:b0:5bb:42a2:31fa with SMTP id
 2adb3069b0e04-5be50a7efcdmr899502e87.60.1792245832854; Sat, 17 Oct 2026
 07:03:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261015-tlb_tracepoint-v4-1-f238a2bd8f7e@gmail.com> <20261016103846.73ff2980@gandalf.local.home>
In-Reply-To: <20261016103846.73ff2980@gandalf.local.home>
From: Roman Storozhenko <romeusmeister@gmail.com>
Date: Sat, 17 Oct 2026 16:03:39 +0200
X-Gm-Features: AclHuK-r_eYg3gupJbYI7DWak9c5eTY2IipHa3Ysz4nKK_X5lXKKwE8MhWngSzk
Message-ID: <CALsPMBMeXHd1TN89bHCtS3G0M8MFiimf8w=qKayxuYCad8v_Gw@mail.gmail.com>
Subject: Re: [PATCH v4] riscv: mm: Trace TLB flush requests
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jisheng Zhang <jszhang@kernel.org>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 16, 2026 at 4:38=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
>
> [
>   I realized I replied to v2 and not v4 as the thread of v2 pushed that t=
o
>   the top. I'll repeat my statement here too.
> ]
>
> On Thu, 15 Oct 2026 19:32:34 +0200
> Roman 'Hedin' Storozhenko <romeusmeister@gmail.com> wrote:
>
> > diff --git a/include/trace/events/riscv_tlb.h b/include/trace/events/ri=
scv_tlb.h
>
> Please do not put architecture specific events in include/trace.
>
> They belong in the architecture.
>
> See the example code in samples/trace_events/trace-events-sample.[ch]
> as well as the Makefile there on how to put trace events in directories
> outside of include/trace/
>
> Thanks,
>
> -- Steve
>

Hi Steve,

Thanks for the review.

I've moved the trace event definition to
arch/riscv/include/asm/riscv_tlb.h in v5, following the existing
RISC-V tracepoint convention.

The updated patch is available here:
https://lore.kernel.org/linux-riscv/20261017-tlb_tracepoint-v5-1-256fb5393a=
7f@gmail.com/

Thanks for pointing this out.
--=20
Kind regards,
Roman 'Hedin' Storozhenko
