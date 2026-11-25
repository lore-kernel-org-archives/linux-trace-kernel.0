Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795577230;
	b=KZbpQri+1fuC3wMiSI8Jnxa6hLaAK0DHg7wFf7HfAw2a5yKt8wpbF4JeI29IRONcmykr
	 JfIFl23yUEjqMRjNjBsCvYLJ/WDJmkqeDRpbfXyWADUdOMjUq50oPVF7b0IQ+FM430dGr
	 hXO1eYpLlPWJrvhyrRs6y58Att9pEn5dRTMIkoQHPK/2FcbEb4Qqx9KUW7kjT9zMBT1iz
	 l6dylmcImTgj5EAScoCzgZYOJhQ27+lZKhC1jcIxZieUdL0aNqtd4H5fwrgnxM8qGFG0a
	 OUdx1B7zWWTW+0xAt9mq1nogMdIzd8Ez3bVb6aSzEAB/zic1Ke5wQKoTTezjkNfbScQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795577230;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=P7lMUsRJHIyWY4eUPhk9XWH72UepBgyY8amhEDGxgT8=;
	b=Ud/+f+ywBhMFTCSIvlKcqrAt9ZNlzTTIyLTsNsZFJxxCCswnyvKoTDpA9l8fd1bxEihk
	 Yo64n8pSwMr0WstspirCr8e7YWUYy7QfHeZdmzvpDl6cBKsuhTFobItST5Ub5fcJ6898u
	 NvWLxKpVLYnuUXtd9+H59GIqzrX252c36aqdwUx5CnSzES/N9+ZpZG4fKt4/zWL3H8Gxn
	 6tAnbYNb4o8rDeodF/nhRdpA1UbtKbRj37l7RL1EXghQ2LNsC4GtkaDhFtybUABztqzo2
	 2/R8ZYccAiGp9D3r3+mxx5Z4OU9Ii7ROdE6b9yOqP+HfwvWMz21VOvOO+RE0NdmfVfg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=louS09jN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.47
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6AB0606A321
	for <linux-trace-kernel@vger.kernel.org>; Wed, 25 Nov 2026 03:27:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6AB0606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=louS09jN
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-18818daa3e7so3153398c88.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Nov 2026 19:27:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795577229; cv=none;
        d=google.com; s=arc-20260327;
        b=b6NyQ/rH5zP2up8h0e07ZnVqCL/lkFlB24hzfc0k+pz0fCIXsfTrhps5pqsHnWteth
         FdcvApDJWgwbl+Kg3HgyZV/Q8HkJsAZSPVAZNJecD4DcCZ48bSoWIz3Xh0tNLDLtzIrl
         7xyhza/W9Q9QZYVHwtp5NpEtNBWwVs8q0En6w6MsqBNQu3jZuBqCtBpu+UODzTDyTEWc
         CO1tXk2pRJ3H6vg4pUJSxIgex03YHp+aEoG3pI74e25nDUjOUH4OE7n4jivUorF71oYE
         qBIx74ELxmlU9Zt22kHu8Dm4jOT/7iEYKD7WSMvb25b7OzC4hVRtq+oKh386qBExPknK
         DXBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=P7lMUsRJHIyWY4eUPhk9XWH72UepBgyY8amhEDGxgT8=;
        fh=z9kpGSyWYNKb2kPfJkAymS6jiuLklWjlc8R3ceqPvuk=;
        b=SfY5+bJRYag/SeobvRsF+LilEPAhUgs/tC8VtTjip6oik4ajBTqdIYTXDqLvQwlxET
         y/IphqC+xx7wy+3UTaJ3lVBpimCZARnwgz2n3Cg9bMXs7P3/PfwSeX/xHydN2QMRCMeq
         25O6QjyZwBsrEf0L6ewmWdO6aSoUJPU8yP/RiBRlD3k5OIj7lIfkCGzMXTFqA0gg3mK7
         OjwueVTHw+NS/9z8CkX79OMZFllil11xOSNzt3uyEsBg2D2KuFGcbq/TWYVGaIWdc5BD
         0uJJ/ZX7HBZExcvKxIApNFmc41n7rr7omb6uxfEKPejbgQVsuN+YAQEsRJw4JS+5FQpW
         d5ug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795577229; x=1796182029; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=P7lMUsRJHIyWY4eUPhk9XWH72UepBgyY8amhEDGxgT8=;
        b=louS09jNI6p4ruo2YCIqX8GKnYrTLcjhTq+Ud/LBfu1g1oa1nBX4C+SyCNkmEV3HXM
         y4aOjVwso+gykF/PsiH/IH/HJ6PD0BN4M3PjGtAVzMBkJVy8Z7ByKs+XnEeL1MTsGVb2
         kECzDZX/0EayyLWWvdM5RAF0YzzdZ97jVdHkIK4DQ66OfrA1HpMylUc5Nn37Vp/HOY0j
         AfuljYSu749pfpk5DHUY3h4dpJIEaNhId3QLvZTAkv0cI6n6vbc3lCJJmqoryVloE/9V
         T1LZbEFZ1GkZWtzazaeu0IPUt/XkxyRACpA0HLfsSmsRq+d9vT36CWEpKIdBjQlfASZP
         5aPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795577229; x=1796182029;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P7lMUsRJHIyWY4eUPhk9XWH72UepBgyY8amhEDGxgT8=;
        b=qEBNfjJtXIVkOMA+HYWcWpdvYchou3W7MYe+tX3JJTaICcubeSFbU1Ql7qsij7an7c
         J6ANIpGnX+cGm/e3dwN+iRhEQxT0GdARsAQ9TdYAJzkniDHRaJg/5lrAdgohEQbtthsC
         TnUrDhEQvGNOKkpmD6eqIOI8XUxmiHa9zLd7i4V0cF489r2ZOWTQf6vhwClz7hXtGSgN
         Jny+wmnRdqg8rrvO8CQDsdYh5cGaHtmwydVZF0vczjR3J9Ofjp3gaomMVMNomBn+BR0B
         QmS3SnHOppvk+h45CPiANV0AjoKXpsY3l59RFgXHBEqF+bA3xv81ehfhznxnqQ7Wq3N7
         7bOA==
X-Forwarded-Encrypted: i=1; AL+hErGq272Li3j4c4HNBAoUhzehOxr32tmaEXruKVA+/Jc52Qnkhd/NhBwg131n53VVGhmatG4TqDGDquMVbEM9bxtI5uw=@vger.kernel.org
X-Gm-Message-State: APuU4Z9b2nAmgCZD0mcN52ntqmsQhw47aVXzWYxhZG1sIoTBLf0PWmax
	aZmP8W2ZNFGtDrFOA8mWQOH8NBY5r6lvedyoF9TWSP/er24IYpMCEhBnF+HTVWMnWwRiMbiinDT
	nnrK14mEKR4dHMG83udIG7otw07xB7wyb6mlyf4s=
X-Gm-Gg: AZFdTZdmyIlZ9K+MsTwwrv7D+zafJVTnqao3WgQ4jX3zmhRh8fvQaUmDX9k6588wMmP
	xZxgLpwf9Z2PWSsslucSV/eMVIyFERHZ4R0l3pnr5sP7hIa0K0uAzSPky40YWLmwxWwKs51E7Pq
	ofvTMe5gUImeL+7X3k4UC1tEOkMzxRVuvzLJZ2ggOPv0MpKsTcb7iLQJ2SdDYs0g8N1gP8PZJIB
	5iLoN+AE68XtdxVvoTPedYU67xyTf2h4XlozMIDI8+It/87bCSQcLIAmNRJG7mYHbvp+ikvt9eZ
	MrvTZQIrOp8jRlpOwAbszTxHW3JzzFzbakKZ1tYKwCdc8sTX+Pvwz5oBC6i4K6jXDPX0IjZvx67
	H4myFOfaFqNXoXuaP5g9iO5SHYpmJUU2ud72ixw==
X-Received: by 2002:a05:701b:2704:b0:1ae:d447:6c84 with SMTP id
 a92af1059eb24-1b5525eed02mr15437523c88.19.1795577228861; Tue, 24 Nov 2026
 19:27:08 -0800 (PST)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261020104710.2366146-1-dolinux.peng@gmail.com>
 <CAErzpmtcDUu6dtQAvV4fJTuDyr6YqtyrLi6XBjWHLjxS55RTYQ@mail.gmail.com> <20261124093450.555bafa5@gandalf.local.home>
In-Reply-To: <20261124093450.555bafa5@gandalf.local.home>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Wed, 25 Nov 2026 11:26:56 +0800
X-Gm-Features: Aa3M54ru-ggnqw5_XTPc9MBp9eK8ndWvb9TMiJ9Dy_P4lAOFGrTXvuc0AtGBUFw
Message-ID: <CAErzpmsGh+7Jt71=y8ygLv2EUL_J9_j3Lbnh1QZZFLxDcwhnDQ@mail.gmail.com>
Subject: Re: [PATCH] fgraph: Format error pointers as signed errno values
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, pengdonglin <pengdonglin@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 24, 2026 at 10:34=E2=80=AFPM Steven Rostedt <rostedt@goodmis.or=
g> wrote:
>
> On Tue, 24 Nov 2026 19:07:55 +0800
> Donglin Peng <dolinux.peng@gmail.com> wrote:
>
> > Just a quick ping on this patch.
> >
>
> It's in queue. I have 153 patches in my todo list and unfortunately, fixe=
s
> always preempt enhancements. This patch is more of an enhancement than a
> fix. But I'll get to it.

Understood, thanks for the update!

-- Donglin

>
> -- Steve
