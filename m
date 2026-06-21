Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20B6366061
	for <linux-trace-kernel@vger.kernel.org>; Sun, 21 Jun 2026 12:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782046537; cv=none; b=f757yMtrRwz0gI+0sK2vBX34jAOfVk5mrGqZdnukKQb13Lj+hYlRNRqWdFQk2zyG351U1RDeXrnbeB4s0qAC1Pnjrtcjxf7yuXVrrjJgw++326hUhzxTWY5ypzbN4sQma8fQlJWAOyyMf4nV0DQuVzAvdRGY9JwYyllBI9+EnCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782046537; c=relaxed/simple;
	bh=FrBpf/gkssNS0FzrmeyqCp0e1iIN10xNwwkHFwdCrQE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UzzBQMfA9qo+Di7ZRTIOHn+FbQp85i0admouad8QiXXijnVSWPNK1oo3a9snUKtWLTVkFrIsYaCqgY8JTPswXA/2Lz1RhT+0cTLHaY8YhrGmgnioQqesG4AikAr7ClMahD7Np+k1R4GtFwrwQebjpKuNNgrTlvdA4zU8eJscghc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HEPnlA7i; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HEPnlA7i"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-460662fcb4eso2344025f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Sun, 21 Jun 2026 05:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782046534; x=1782651334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WU+6TPSMrQeQnOmPDKoUDmLIYSzXbxEWNqGQFFhaaZU=;
        b=HEPnlA7ilq5cBLXmRCRdE+fi/N7aST+SdfMD+MJXNx44EBemiG9rjXiFv70GGeXSoz
         OL+YA0wO4DZ+Vojg0dtpiA/+jHjShkgs9abDLGW3cDtqvdjyeSWyTCBZv9ntyUJ8YgkF
         2LlW/c9NPd35YBu9qUTAvTzk/cctdfAz/26y+X+lPsuttpW4Px8uT6A7LWPw6p25qqh3
         LN5ymox0l7svelgtmlOUVvfqkISw+y7pTMmkNCOhS+m102IwN1RYhV1E2cNi38XRGRkb
         7yoF60g0aJidx7f0xIQvNERu2I7c6x6JhnU0pe9CGHXzsLJzdkQSpMm4duLjoPK4meQd
         64yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782046534; x=1782651334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WU+6TPSMrQeQnOmPDKoUDmLIYSzXbxEWNqGQFFhaaZU=;
        b=T5Vlm+QY57PH+cMhYKAmpssRXm18qQqZGa586a0xn68hIcWo11G7vpz6m/zqrfduDB
         NX83hSmsrpAHHe0ladRK/cr8uCGttMsDtpU4QPG7jfcttnZCZirGUvwTn527gU8QzXT+
         8ZvMeJLO+JNovR2CcwWvShpR0ZY6ixAx5DhdA9PhyKHvFlGdwk1O3P3ONn2sgAkZYoTg
         DtE9WBnCzOc2Px9Bmy0eLjK65SuLBExPLwjm4O/X3dNht8sk8Th9g7+udpdjnE9TJyEb
         8Qdu4NvgAVTp7Kx2kfzi21EAqnN0PnYswqOU04Aw3XyAZmdFzQopgoktIPitWYHcUlqQ
         eHxw==
X-Forwarded-Encrypted: i=1; AFNElJ9BhgDQYi+5aMO/Cvevwj7ZsGWm0oK8o691LP/dkpUxK2d91afTcpmRWDDTUmcYeSKRp7O+YG1B5k7Nxl671MdUVdo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyeElid8vkm4CAAPt7Q+cLLQCUV4zqoUTHd1xGVwEDpNoMBp0c
	A6vAg3q/kYx4fBiih3pbzJOob53EYEIMJeoQUDtjllna1wM/t2h440JF
X-Gm-Gg: AfdE7ckgQcwAIbYCYfrulhN2Wg2sFpWi37nwmbUxG96ZzF+sav0Va96bqZZ0qHKYVl+
	Y/PtVhd4Y/3Chxkv8hqErI+c9PY3fEqRIFORUpRKNBdQJXMK5vvDWITYbNk0VMigeooubNhI9cl
	UgBgVaZUn9TU8Upj4ZFHUMUGXRbDMJa32FgfOPiYDCtcxVmUffvGaQsCdJHEwZRg8DkdBZcid77
	5q1sXXqOB1iYCKHUIbAoQuidnOoBYxYYjdG3Bp90hXFJnZ9sYU4dXoKcZAhuXCDsD0X0Yj7axHy
	G1FZmIm9CkK+2LWuav+JZ98Ao8xaDR9VbJEVWdf4Yuov/xTfBxGE41D1H4riANwY9u/T2/zFEdz
	ZsxUCDZ6eFQd8W+kisOt8vECXWoPiMxzx1v7bmwo8dVR6zlJdNpsTBM4aZvrZuJ4ndFoqxwlMNN
	7dyXI8l4emWqvS3bVpop9K9XbYLGkjkdihUxSFhgyS+Yw9ijwJ0g==
X-Received: by 2002:a05:600c:e547:20b0:48f:d5b8:5b07 with SMTP id 5b1f17b1804b1-49240e81b22mr113459545e9.20.1782046534244;
        Sun, 21 Jun 2026 05:55:34 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49249238900sm129230375e9.4.2026.06.21.05.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 05:55:33 -0700 (PDT)
Date: Sun, 21 Jun 2026 13:55:31 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Thomas Gleixner <tglx@kernel.org>
Cc: Steven Rostedt <rostedt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, John Ogness <john.ogness@linutronix.de>, Peter
 Zijlstra <peterz@infradead.org>, Julia Lawall <julia.lawall@inria.fr>, Yury
 Norov <yury.norov@gmail.com>, linux-doc@vger.kernel.org,
 linux-kbuild@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 dri-devel@lists.freedesktop.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-rdma@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-nfs@vger.kernel.org, kvm@vger.kernel.org,
 intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH 2/2] tracing: Add CONFIG_TRACE_PRINTK_DEBUGGING to clean
 up kernel.h
Message-ID: <20260621135531.243375d9@pumpkin>
In-Reply-To: <87ik7cmcb7.ffs@fw13>
References: <20260621093430.264983361@kernel.org>
	<20260621093811.168514984@kernel.org>
	<87ik7cmcb7.ffs@fw13>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 21 Jun 2026 12:13:00 +0200
Thomas Gleixner <tglx@kernel.org> wrote:

> On Sun, Jun 21 2026 at 05:34, Steven Rostedt wrote:
> > Instead of having trace_printk.h included in kernel.h, create a config
> > TRACE_PRINTK_DEBUGGING that when set will update the CFLAGS in the
> > Makefile to allow developers to add trace_printk() without the need to add
> > the include for it. Having it included in the Makefile keeps it from being
> > in the dependency chain and it will not waste extra CPU cycles for those
> > building the kernel without using trace_printk.  
> 
> IOW, you make it worse just because.
> 
> With the header being separate I add the three trace_printk()s and the
> include to the source file I'm investigating. The recompile will build
> exactly this source file.
> 
> Having to enable the config knob will result in a full kernel rebuild
> for no value.

Indeed...
Isn't trace_printk() just an extern?
Having it defined somewhere isn't going to make any difference to build times.

	David
 

> 
> Seriously?
> 
> Thanks,
> 
>         tglx
> 
> 
> 

