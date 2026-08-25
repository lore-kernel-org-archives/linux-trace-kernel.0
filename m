Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2DC28D831
	for <linux-trace-kernel@vger.kernel.org>; Tue, 25 Aug 2026 01:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787621325; cv=pass; b=TgWVjzuPHjwiOGbvjjsGrX7geaYB+FNBNwCq6AR8/nrPq53KKiVJZkvT3SD5w6fHowi/dPvlDK/J5D1eByRtdpojVw4YO2/zcTzU1rBM/M4KsfVB/436XmFoNv2XdgmPsCgLLdroTkxp6FVtkh+C4fYM0D4+InJaV5772ysKKLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787621325; c=relaxed/simple;
	bh=PsNLfJKtx5Pw9tcpVh3+/J8pXp8dN8CNLElXYSilKRQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H9t+tmUMSAyOBqSwJQ0TFPFzlzRiBLiIhR/ug0j8PnHBfmZDyCBq+knwcHCQMOS6qVfj7taB1FnFE4NftuUVj3EMRWNcyhtNHrY3MVpTp6qKyNcT19dzlLacEc1c4hn0B6tCaS9eMczUorUp3AKCrUkNYqVcoMGtWyICSgeZ22M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=li2FH+nT; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="li2FH+nT"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-66d07b7e704so2332940d50.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 24 Aug 2026 18:28:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787621321; cv=none;
        d=google.com; s=arc-20260327;
        b=jN2SJwIZjgYSyA0E96R4mwNQcZT5doUfaxhCT5hg8T7Mjrto9bCv21D/p8FjB9MCna
         n4iUdteH/5bXhvclHK6sSojwEspfAO0PMlRFhe0RUcNcjnHsYAbxsrXRe+983UvmJvGI
         /jN1XUngxnvnvoiSRRMt/7M4wQ40UuXI4DVUC+vo2+8vH8tX0iCuAQ1iaAm352YQCPRV
         stI0Do0sk5SaGGs4moCqJXHDeDTbnCIywLxPAp/2WtH82pZah+5OIp63TbUohpBrk97+
         LbCivSPCIYgWbGRUgtGDRiDTPWO29e7rhmVBX49qHdU11zTYK0QyGtUbbaFzBd7IROkw
         JfFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pJa7xdlFKl/U39T4Zlsu/Yw8wGqStC+43iCo9zb6Ffc=;
        fh=RUWEU55prFgVVa8iM5gSA90WM/t+uHprjdP67daymoU=;
        b=mamYdPhvtv7SrmiB6viR8Ni07n1mdBSoxx+x/D9xdqu2DBnNcDof2sUfjZvDpVDoh5
         UCQ7dtYVq3+/OA3f4nXvbTjcL0m/KgmsvfSQLuiuclcl/WnyjOSAS+0sZAqOpXDOPrUp
         IonizDE4GCDmrPwlrhI0P10CFKwvtoU1uV2FP9/tTLhTMlmTNn2jcgErEFQUCrWJjtlh
         2c2TkfgS0rR5Ah9vpq54FnFg3gFnxJZKdupWCMiPCk63pQ+LVRBAwHQohxqN9q5Bd0bz
         f37RlG8NfCnpxg/XhSMSIV32DOXZb5sME5CBIofzHcTwrLLy1IynalCwH7JsOeEMXF5x
         8CNQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787621321; x=1788226121; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pJa7xdlFKl/U39T4Zlsu/Yw8wGqStC+43iCo9zb6Ffc=;
        b=li2FH+nTCxpH7OxX7V1w4olq47hNxHuUIfFJdJRgHQQRluWFqqMXTwnI11XUf0ZVwY
         5UwvdVZvVWwsFt1dQxd2HkSSZ8NIiWq+0yq8VVxMl0MgJNHGj4NRDbtAHfmxIn4/rovy
         4P4pcF6KoBlwBh6YI2gtVGTY0bCcelE4PR+g8FZhy14+wKpPa/qL6rxOcKcz2+guBb4z
         MnxP+ndYQOS2HoNoXEOR8+scDLPJEmEXXfiVbDP6Tzue3cfuvqhUCzQPJ3x+8FiBbEeh
         tRcVFaQMFBxxL0kXdinjzDEa4xKgG1WxtlCi+OsqhVryh2DNqpPoBSV1xdrTWBchg8+3
         VoxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787621321; x=1788226121;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pJa7xdlFKl/U39T4Zlsu/Yw8wGqStC+43iCo9zb6Ffc=;
        b=FPD+ZHflhpkpC4bMaFk1Bo6D12f0gJlcCMP5GwCIK017iMjLekby//XFhkV5YJFV8s
         lnCaQFofR++empSDjdgkGk7+oIw0BvAAxeZ/0YQPDKnXZuQvsylnaf3kW4xNVcr2zhfy
         M30e8vva8+AAg32lMOLVsHxSciBJCIRKks7GOPPYiY4xL/An2dgzUeqYKCHetCGFK2y4
         pmbi1MLWateBhQrOZ7gdDpWp6qvFsVI65cvOmtZWODDxnWeQbWvgvYMsIBAnMT7J6n/w
         2ynaLLIguKvTY8C5TGCg/9KzlGUcRSa5X/smlvaEW2XxN9B1sXKKMBO+FRfcqEZQZvQ6
         kD3Q==
X-Forwarded-Encrypted: i=1; AHgh+RqajwL//p5jOWtiCxfRXDCe9BPiJhI76iwO2fgy3gJ+j0xnQti4Zgqcg2PuHBh+1HJqcYAK9MYcbN0ObddtoXoGWME=@vger.kernel.org
X-Gm-Message-State: AFuF++knkQsUxrdO+ZyG5CNfNx5iBJkmjKz1gKMZbVf62bPGI6ecEtvU
	rTkDDeL5pk687tERBj2YuLqeKmdZDDX2ew/F1cM61HP+sHjAdAjVuCEr2PEZ5hfS0sfL6ofI0Hk
	qQR7KdpdkTwiXoCnef6nb63/Y7AJ4OhA=
X-Gm-Gg: AR+sD12rnCOXW0VF9P8QqAo0hIlyn9ytAPyvEzgq13Ge1ywaJPL0QHCgguVai593STk
	nXdJ8zXK8ZD9LX14/Jkqd44eyy9s8lRQZSPdmNfST270hhfWrHZHiwDca9eC9LVIWwK0Z/WlVkn
	is2NsPjRE93d0c4Hk6lcr6QXIhrediqGXprXHiguaos+6lwmcbFkZZPL5W3U/p9jUXXNobm3Npo
	y+H2cmXxvbGet5M8FfSbvCGK7Pgt1E1Aru0lffKJJICLVMmvVTonjfJPOGTxmolNwp779rw00H+
	IR0AhQAvR//a7FgQyWTxdiY6d6pFBp8K5gLmBvn1T5lGqiMVhEGDNLC/B7dzp/hYsSMJDh/ksnJ
	uQroVQXCbWQnGh8/XkTlJzqD0XgW8swWt
X-Received: by 2002:a53:b112:0:b0:66d:bf7:450b with SMTP id
 956f58d0204a3-66d14d64794mr803701d50.54.1787621320895; Mon, 24 Aug 2026
 18:28:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260817140655.5694-1-kartikey406@gmail.com>
In-Reply-To: <20260817140655.5694-1-kartikey406@gmail.com>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Tue, 25 Aug 2026 06:58:29 +0530
X-Gm-Features: AcwNN1UukJeFHbxlrWZRvjuqkah51sjzGGwAiWq4cuBf9uUXPIeok_zTQy3mn78
Message-ID: <CADhLXY4t+qgESW4ZPOVtOfsOGcBcwiM=BRnhngMBKvb8R7MemA@mail.gmail.com>
Subject: Re: [PATCH] tracing: Fix use-after-free in trace_pipe read on
 sub-buffer order change
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com
Cc: tz.stoyanov@gmail.com, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, 
	syzbot+685955db58555575fdd2@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 17, 2026 at 7:37=E2=80=AFPM Deepanshu Kartikey
<kartikey406@gmail.com> wrote:
>
> Writing to buffer_subbuf_size_kb calls ring_buffer_subbuf_order_set(),
> which frees every sub-buffer of the ring buffer, including the reader
> page, and replaces them with newly allocated ones.
>
> Readers of trace_pipe hold pointers into those pages. ring_buffer_peek()
> looks up an event under cpu_buffer->reader_lock but returns the event
> pointer after dropping the lock, and peek_next_entry() then calls
> ring_buffer_event_length() and ring_buffer_event_data() on it. If the
> sub-buffer order is changed in that window, the reader dereferences
> freed memory:
>
>   BUG: KASAN: use-after-free in ring_buffer_peek+0x3e0/0x430
>   Read of size 1 at addr ffff88802a4cf010 by task syz-executor989/6002
>
>   Freed by:
>    free_buffer_page kernel/trace/ring_buffer.c:398 [inline]
>    ring_buffer_subbuf_order_set+0x1325/0x18e0 kernel/trace/ring_buffer.c:=
7444
>    buffer_subbuf_size_write+0x182/0x280 kernel/trace/trace.c:8221
>
> Take trace_access_lock(RING_BUFFER_ALL_CPUS) around the order change.
> This is the lock trace_pipe readers already hold across their entire
> peek-and-print loop, so the swap can no longer race with a reader that
> is dereferencing a peeked event.
>
> Fixes: f9b94daa542a ("ring-buffer: Set new size of the ring buffer sub pa=
ge")
> Reported-by: syzbot+685955db58555575fdd2@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D685955db58555575fdd2
> Tested-by: syzbot+685955db58555575fdd2@syzkaller.appspotmail.com
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> ---
>  kernel/trace/trace.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 395238b2b715..c38a5de602e0 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -8214,6 +8214,8 @@ buffer_subbuf_size_write(struct file *filp, const c=
har __user *ubuf,
>         /* Do not allow tracing while changing the order of the ring buff=
er */
>         tracing_stop_tr(tr);
>
> +       trace_access_lock(RING_BUFFER_ALL_CPUS);
> +
>         old_order =3D ring_buffer_subbuf_order_get(tr->array_buffer.buffe=
r);
>         if (old_order =3D=3D order)
>                 goto out;
> @@ -8253,6 +8255,7 @@ buffer_subbuf_size_write(struct file *filp, const c=
har __user *ubuf,
>  #endif
>         (*ppos)++;
>   out:
> +       trace_access_unlock(RING_BUFFER_ALL_CPUS);
>         if (ret)
>                 cnt =3D ret;
>         tracing_start_tr(tr);
> --
> 2.43.0
>

Gentle Reminder. Please let me know the status of this patch

Thanks

Deepanshu
