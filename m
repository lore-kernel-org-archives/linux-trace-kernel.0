Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E66E28B7DA
	for <linux-trace-kernel@vger.kernel.org>; Sun, 13 Sep 2026 01:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789262820; cv=none; b=WvOUEx7fUkZ+a0ziTPagvkcNngvb6+hH+SmEgXbZ9Y81D3NmwOL+VBpUdlh+fvTaLAyhWp75y/De2rFvDtRj9mwPvGwOU2QWF52TCc4U+GlvYDRTP06IIWZ0soiUCWtHpwyz13jqg9uvqC4Hl50qQjFYhkqmp4kEmaxNsUSc0+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789262820; c=relaxed/simple;
	bh=TSHs88GMB6DHBXH5X+N97OQWghhZeYcRWgEaIBLM84o=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=lO5UGnD+VPk1Pa40nYJ2ZaJD1IWJ1c++e7oMqzHaMXgULNfWVDzbL0w3lJNnZ5vHiEWyunbs0EktvQf2sMZ9DfNEbKuYfsNH17Cm6ABpJmU0pdLIb3BUicpCLOlxEl2TOSSnsslG4GBkC3JZDPJLi91G9SJzoqixtFzTBtRQu/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b1A0Tq4q; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b1A0Tq4q"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-805453b1c0cso1181102a34.1
        for <linux-trace-kernel@vger.kernel.org>; Sat, 12 Sep 2026 18:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789262817; x=1789867617; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=TSHs88GMB6DHBXH5X+N97OQWghhZeYcRWgEaIBLM84o=;
        b=b1A0Tq4qeTahp1fZe74KI3PV5/kpr0BjIYOKlgrhpVIgvZctHXmrIKiDoUKMzgvfoy
         Ezv6LVhfXyQhFawgeYB73T5QQNtRgwDL7gpMca09Qfw686QJTGcJycl19HWP+Yc3UNhW
         uiAFXPkrGGCH3WgZvgWHmeo/faag6bKTZ3BcjBWgAw8/acS/KRyqBcaiG4rwRvupY8WK
         tXnPt/N52F4NJ8fqZqmuPCidrGFx76zT9RUWECuvUtV/Fuy7sKBlk28uAwCX/vGiewNi
         B0qWM2VPo0OjQdFlhPd7a3aVgG/sGU7iNXViVH9cRmPmyo13gtpxNc8fEwzVe5UcSiCV
         Qsyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789262817; x=1789867617;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TSHs88GMB6DHBXH5X+N97OQWghhZeYcRWgEaIBLM84o=;
        b=Mt1IPSsuVtvR6bA83gATywUmCkEH2OKAiZYQWbSoaS7l0qE8QudUklHxAxEC+giYdm
         JHyED0Z9a4tiHWLjqevS17D0IJJOylrYoO9Xac1ahRoplVE4kxPfcoHbfs1DAG13JunC
         6m+KYrydHPPgWdK3E7UG9bkaIy7WvSnaKH9EYdhIqaIRmaiwppkh4xjgoen1UXU7HXNI
         CqW5g7xYEDXRLf3m0OOUS1uj8DfQug4mCg4aECa8saQo18lS2A9PZIUBmXupXTlS6dOb
         ivVGpTiQ6+yXf6oE8r9+ZRX9Zv9HHZiw12bvvhecQfWel4AD/9WLIh8mIY4Ew2ud0o9+
         pw2w==
X-Forwarded-Encrypted: i=1; AKwUvBzrY2Ivdt6bF6F33iC0qWXexx6oCGMpKFr32aIzbpC7AHO+Lw+OEzCn2IE6+v0h/tysMH1s5DO5+WlSl1yXiBNeoJo=@vger.kernel.org
X-Gm-Message-State: AFuF++kmz122LgjZND4E79h+p0AYlWqamaxZDzRCZgtoTrsswA+Fe0MP
	YqJz6FGyRcmkpAfZoUMPXgmrji436GNw+IPbADp4Z0+24dXVR2yHVKu9
X-Gm-Gg: AYBFou33hvupAjDTY1ortK3NKBJVlFTol8gHeeRxj9O2hHZGFkWY4Cn8QZ1p3QJShi0
	lTTBoVrA/qA5YisxtZBafSf+AVv//WHml8YZhulmEb1Mxjr65YWOIH/6NiI/LuGVTJhmzlFuxVT
	C874ThmfgjHA/WjIoBhL6cdOhL+sTLY1BgphVH7ntdnzgxYICLkYaByxcM5noVHJw37tYOdnfV1
	fB3JaMdu6FyrhuBEADOSzi9dRiIc8kS902LTAvuCX9zeSxvlOvbr+awd273Em2gVp+66w2gsX8C
	eO8kXhpHsGDsc3nlDrkLrOqrDkYuNzK2/umwvJdDGnosw+FATBg4sB2fBivXFlFYVF4GhcURQx6
	sC20p79xN+1IWHhXa8uX3DEwxuFeDJVm0mevXP8NvVbqqpR3ncoJZH64MM9VTEqixKYmrHjWRO7
	tb1yqQaHOcEtQdL801OiWc8HKahnWnxC4iwHcerXD3dBPxyIKk0a3j5SgomFbVQaMfMXPWuBg6x
	MTF1GnGkEYPL875di2Me5RqFkKbGUdpdX2Cn7aHiQP/tXiM7cH9hK/up73J8LnAtQ==
X-Received: by 2002:a05:6820:160e:b0:6c2:3bff:3ef6 with SMTP id 006d021491bc7-6c23bff5dfdmr3227980eaf.29.1789262817080;
        Sat, 12 Sep 2026 18:26:57 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:17::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-47df90faa62sm5431368fac.12.2026.09.12.18.26.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Sep 2026 18:26:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 12 Sep 2026 18:26:55 -0700
Message-Id: <DLDSQDSVXFHF.18X2UQUL5Y42D@gmail.com>
Cc: "Nam Cao" <namcao@linutronix.de>, "LKML" <linux-kernel@vger.kernel.org>,
 "linux-trace-kernel" <linux-trace-kernel@vger.kernel.org>, "bpf"
 <bpf@vger.kernel.org>, "Wen Yang" <wen.yang@linux.dev>, "Tobias Schaffner"
 <tobias.schaffner@siemens.com>, "Viktor Malik" <vmalik@redhat.com>, "Linus
 Torvalds" <torvalds@linux-foundation.org>
Subject: Re: [RFC PATCH 00/20] rv: Add support for BPF monitors
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Gabriele Monaco" <gmonaco@redhat.com>, "Steven Rostedt"
 <rostedt@goodmis.org>
X-Mailer: aerc
References: <20260831090524.106845-1-gmonaco@redhat.com>
 <87se3sakgi.fsf@yellow.woof>
 <df6e9168cb06c35e21db7f9d17cfbca6bd87005b.camel@redhat.com>
 <DL5B40CU17WD.3KD75URQZ6RRR@gmail.com>
 <eb3dd8158942d663ec8ad4c529eacd666c5f96d9.camel@redhat.com>
 <20260903090211.50d15220@gandalf.local.home>
 <CAADnVQK8e1Qp9rf1zThZxb3vr4Gc_bpo0nqpEO2LdnEwHdKokA@mail.gmail.com>
 <20260904074317.01b2c0e1@robin> <DL6O0KLPXLTA.2HJJUXQUVCP5@gmail.com>
 <20260904123108.1fa1d815@gandalf.local.home>
 <20260904132421.111c0279@gandalf.local.home>
 <DL6XBKITK7ZT.3RXK9YGGUYZZE@gmail.com>
 <20260904194620.0c7a8363@gandalf.local.home>
 <CAADnVQJH1SYR_GN6gewF3w_z_Sex9HFE1T1oXkQe6+v18bDTWA@mail.gmail.com>
 <20260904201741.2986efca@gandalf.local.home>
 <CAADnVQ+x4iRNXOg69nUmuJ53pB3-JtroePcyoReATy9+V1aRPg@mail.gmail.com>
 <228FE969-EBFF-4B60-B0E7-C1E4FD82FB8B@redhat.com>
In-Reply-To: <228FE969-EBFF-4B60-B0E7-C1E4FD82FB8B@redhat.com>

On Fri Sep 4, 2026 at 9:53 PM PDT, Gabriele Monaco wrote:
>

Sorry for the delay.

> Alexei, what I read from your opinion is: if you really want to do this R=
V thing, then you should just implement it all in BPF.

yes.

> like the panic() one. Something BPF just shouldn't do, as I get it.

There is a disconnect here.
we have one KF_DESTRUCTIVE kfunc already. bpf_panic() can be another one.
It will require CAP_SYS_BOOT.

> I'd rather discuss on what is the best approach /today/. And that's preci=
sely why I submitted the talk for LPC.

Excellent. We can start this discussion over email and continue at LPC.
My understanding of RV is primitive, but from reading kernel/trace/rv/*.c
it seems to me that it's a thin glue between tracepoints and monitors,
a bit of boiler plate code via tracefs to enable monitors and seq file for =
visibility.
What you're proposing is "yet another monitor" that is reusing this glue co=
de,
and that's my main objection. I don't see the value in kernel/trace/rv/*.c.
(kernel/trace/rv/monitors/* are useful, of course)

What stops you from attaching tracing bpf progs to all tracepoints that you=
 need,
pinning few "bpf iterator" progs in bpffs that will provide text or binary
output via seq files, run a state machine inside the prog,
and do whatever "verification" logic inside them ?
You don't need the rv/*.c glue. I see no need to introduce new bpf struct-o=
ps api
just to look-like-a-monitor from RV glue perspective.
"runtime verification" as a concept makes sense, so focus on that.
