Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3986E41D208
	for <linux-trace-kernel@vger.kernel.org>; Tue, 15 Sep 2026 03:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789443157; cv=pass; b=dD6UleS7yGn/ELZ6QfeosNW8gbFBTSVbI0/XVy1yQYTQhZGWR3nTAT89Lr5/wDdnuAnsVGuZq2U5YhnhGqQuCdsOjpPW0nQ4HFTaKKye/IQEAI9eTuglAGjEw2Evim48V49UfYNp6DdZQ1BNqvM6o+smdMTh1OvmRuuRKsFaXHg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789443157; c=relaxed/simple;
	bh=cNyUgiHAc1OpzVC4kIHbtZu2xQfpQFZZ2m7gUGOvwQA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EeFIDMfplMssc84tGv7cjm/4dZXlL4yiTuPPhkO7Oqc+BBN7zm8kunsQ+Rmd+7SPE+4dfwg+NF+Cg1vyGLsaqAEq6cdYjxFoL0/4EHPLN9HKlWnjiOGBUPQS4HBvKK1qJdMjiLjRGolXve/6pb7LyRF91Em6txK1lm/PxAbZ6w0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sZY84jaQ; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sZY84jaQ"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-52fb7692a57so31071701cf.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 14 Sep 2026 20:32:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789443150; cv=none;
        d=google.com; s=arc-20260327;
        b=aUlooeQ7CRp0cs8IjplQQQCoIM+aYXBD9vQncIWbKQX18jFrDxmy1LdcfqPqaTX6M9
         78Kcj9tWoM5m9zRfzqV6wYZwo9AVLjfipf34PlXCaFGEvubTTDPXpdfSybqPX4NSPZrG
         LX9qq/uWU2R3kpgGiGRrvMeQ4xWq2AeY3MBf5Rt3IhxE47/Uuu4n1UmRfepPqNigbAV9
         nx6Rfmvhce7qJ74OY3g1NkDlPXdgF5xS6Lj24WfPZWzahoPkTwSc0sExkI52xjlA6oWo
         xYNTJ7o8Rm18k3gv1E8M2qYsKTku6styxKwbJLVDxwUkt5AT7mtvnMRfQixcVDwYg9C3
         e2gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aWObjhMohUFlVKMQj21hIxDdB+FomHl/XtrzQrYZUHI=;
        fh=YZU6xNLenKHyJk8mQB2bxSP3e/+TbmQjeaerY5PjtHc=;
        b=INKrq0aN5FEqfo72rDADtQMsXmFd435pmdTl9ASHi+bG+KT5lYvrLSQSMgVxVOwQn/
         D6pC/+INDD+x7HUZKS3OjIjAHwITP+DH18z3xGsl2ZWln4vyPnBUC0LrZwf9Xaa2alu9
         DTXdbxxPVaDg7b1lAZ9iP0tjrFANg4B6vXfQglBnzzhu8xMZ1rvExEYpWT6QE/t534IE
         UQgyunhN32L0dF30bLxsRhNiDNxHBB2rRje/Hf7obrnE4kbnbL27RUO2Db+dv7Pb6EYH
         sHb6g2TOJlAlkQErmsY6AZg5K2yO5RYIYVHd8EW6cLr+5nfFOghDGjlPvg7JppO+q1eO
         nZ+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789443150; x=1790047950; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aWObjhMohUFlVKMQj21hIxDdB+FomHl/XtrzQrYZUHI=;
        b=sZY84jaQWEEqduXPxmIE2bTrAubeL/Koh+dNtfx1jnADJQ646fyCbDZCt8TnhEm74K
         uu+p5LqM8dU2TrUs1Abhv3LnUjLDIfnPPugQuYa2vyPkla+quogOJFA//L0qA3kTR1fJ
         nAscOQpneOm7QeuewyUUaJlw78v6s+JLy/LFkPNH6LrR35ppYBl1WmxYrDZM0P716+J7
         GkIY5OhJGRW+UQ+PGx40ziZKkWa2THDVo0wV+IEdLxz91JA4g+U6QB36YJeBP6pvB/Ze
         McJa0g+8Rdj670/YeLKMkHWk1seYmYzilOud6t8OWLjJI57iXCLUy/YfZY3fHHyut9hZ
         nIjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789443150; x=1790047950;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aWObjhMohUFlVKMQj21hIxDdB+FomHl/XtrzQrYZUHI=;
        b=wgdqoTX3NS2/HGta5aWktO6QuS9nsKfB8xg9ogcatAtbPsOubg03bVG0byvkSIrCGD
         x6hmJfwAe85Yhb7kCOncmdgMkU3mBceOZXIrtXgdXiUSyTrj6HlHQkcEfdHsKQETfgMt
         7Q8CPd/c1q48US6K6tUpdDeyjhzXYBkuYkUaIvBPnYd0aaeP0felu68VncjoYy28fdvV
         uXGq9CiHDuv97P8P74WOil4FJxBZc7WmlcUrUeSrxenZWNepaOgcSDK3A10Vq9ANyDpz
         5b+332SDaqu59ERgA17ayMkaLQEkHrBDsN+/OjD82787VW9c3R/PWrHEPDhOefgNEHee
         +bmQ==
X-Forwarded-Encrypted: i=1; AKwUvBymy2ByLoqh78zKErABdAzDC5MLf5qI/FkpB4aXT/N7hOZouyJqq0MfLbU5Wbp4yCNZUxBnY2Bd0vHgdrBpjbNfQno=@vger.kernel.org
X-Gm-Message-State: AFuF++kKvjNuOgYayrJIEZ0IG1Zz68L8WYN68w7swFAN/hbM/ej4ouwj
	J4hQcfRk8+zbtLxUCMiFSxFu+S9V8ueRUbmkpzs5i1nMptWxE7ZQZXYzkR0ZJbDopaNMtuXbZcd
	ou8EcE3J5fFuG155wXlZHBY4aML6ESK3H1tsFgMIOVO/1Vg1x1E2PSuEMiwGGOA==
X-Gm-Gg: AYBFou0WKCtnA0/83VgrMLssGHEyfYFousESfmtta+/SCbcQJmbXMSNjsiR5VQi79n3
	R90RQoN8HqjZUctq+sVps9xmKRGfTeIBRhIrsVW6Tc6U1g6QV6IVKfgA83csYn+M+euGvKBOw4Z
	wUFrNFyJYux34EsxaOYIAXPjLDtaLVci2xwqN+/RyZijoR4Br6GBEreJoDbId9+IkXJF7yAwSvT
	p7eOV60p+WfVgCcaKH3LjzmBBrmnedhJ/BR6iemtnsLn9Sx8guSAodKv92S+3hcjsKEIkRSYeLi
	bS6svqt0b8p3n4dGMV6GejWsPc8DIQP/epqkzxvDAWKrA8TOeKpAf/gSWh0QWg7UuPzWsOphAUF
	fI+8Ecig9Rg9fchlbQLe7j9hxMkvmt+xKrwv/OloAEU3JodrXlUMuuWY/l6+yKy7VVUs=
X-Received: by 2002:a05:622a:5a0f:b0:530:42e5:f3a2 with SMTP id
 d75a77b69052e-5310d03126emr77108521cf.43.1789443149347; Mon, 14 Sep 2026
 20:32:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1789284524.git.petalzu987@gmail.com> <619733e91a715790da8c4efd88f51897ff06e253.1789284524.git.petalzu987@gmail.com>
In-Reply-To: <619733e91a715790da8c4efd88f51897ff06e253.1789284524.git.petalzu987@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 14 Sep 2026 20:32:16 -0700
X-Gm-Features: AcwNN1U7GCotunQsTYXYjB_YxjMuP5n5dmEUyI1TjjIDjqQV_GEfLMGHoJFfqMM
Message-ID: <CANn89i+YZP4X6WWvGJ2EkV5RshSiT50A0pxZe4un6jB2YKah+A@mail.gmail.com>
Subject: Re: [PATCH net 1/1] net: tcp: account zero-copy receive VMA memory
To: Ren Wei <weir@nebusec.ai>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, kuniyu@google.com, pabeni@redhat.com, 
	willemb@google.com, davem@davemloft.net, kuba@kernel.org, horms@kernel.org, 
	rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	ncardwell@google.com, vega@nebusec.ai, petalzu987@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 7:46=E2=80=AFPM Ren Wei <weir@nebusec.ai> wrote:
>
> From: Zixuan Chai <petalzu987@gmail.com>
>
> TCP_ZEROCOPY_RECEIVE installs page references in a user VMA and then
> consumes the corresponding skb. The socket charge is released at that
> point, so a process can retain an unbounded number of receive pages,
> including page-table memory, by advancing through a large VMA.
>
> Reserve the VMA size in TCP socket memory accounting while the mapping
> exists. This charges the reservation to the socket memory cgroup and
> TCP protocol budget, and releases it when the last VMA fragment is
> unmapped. Keep the reservation across same-mm VMA splits and moves,
> disallow expansion and fork inheritance, and reject inherited VMAs from
> the zero-copy path. Use a strict accounting kind so ordinary receive-
> buffer minimum allowances cannot bypass the reservation limit.
>
> Fixes: 93ab6cc69162 ("tcp: implement mmap() for zero copy receive")
> Cc: stable@vger.kernel.org
> Reported-by: VEGA <vega@nebusec.ai>
> Assisted-by: LLM
> Signed-off-by: Zixuan Chai <petalzu987@gmail.com>
> Signed-off-by: Ren Wei <weir@nebusec.ai>
> ---


This is not a bug, and this patch would be a serious regression.

NACK.

1) There is no vulnerability here.
vm_insert_pages() accounts every installed page in the RSS of the
mapping process (insert_page_into_pte_locked() does
inc_mm_counter(vma->vm_mm, mm_counter_file(folio))), and the page
tables allocated for the mapping are GFP_KERNEL_ACCOUNT, as your own
stack trace shows (pte_alloc_one).
So the memory is accounted, it is attributed to the process holding
it, and oom_badness() sees it. Your own log says so :
[  701.147561][ T5539] poc invoked oom-killer: gfp_mask=3D0x440dc0
The OOM killer was doing exactly the right thing, and was about to
kill 'poc'. The kernel only "panics" because your reproducer does :
    sysctl -w vm.panic_on_oom=3D2
With panic_on_oom=3D2, any program doing malloc()+memset() in a loop is
a "kernel vulnerability". Please do not send such reports.

Releasing the socket charge once the skb is consumed is by design :
ownership of the pages moves to user space, exactly like a recvmsg()
copying into an anonymous buffer of the same size. Nothing is
unbounded, this is bounded by the address space the process mapped
and populated, and that memory is charged to it.

The Fixes: tag and the stable Cc are therefore not appropriate.

2) The patch itself is a much better DoS than the one it claims to
fix.
You are charging *address space* to tcp_memory_allocated at mmap()
time. Address space is not memory.
An unprivileged user can mmap() a few GB on a TCP socket, without
allocating a single page, and push tcp_memory_allocated above
tcp_mem[1]. The whole host then stays under TCP memory pressure for
as long as the mapping exists : every socket on the machine starts
shrinking its buffers and dropping packets. Repeat on a few sockets
and you reach tcp_mem[2].

3) It breaks the intended use of TCP_ZEROCOPY_RECEIVE.
The expected model is to mmap() a large region once and slide a
window through it for the lifetime of the flow. With your patch these
mmap() calls fail with -ENOMEM, or start failing at random whenever
the host happens to be under TCP memory pressure. This is an ABI
break, and it is not covered by any test. tcp_mmap.c in
tools/testing/selftests/net/ was neither updated nor, apparently,
run.

4) Implementation problems, in no particular order :
- __sk_mem_raise_allocated() and __sk_mem_reduce_allocated() are
  called from mmap(), munmap() and exit_mmap(), without the socket
  lock. sk_forward_alloc is bypassed entirely, so the socket
  accounting no longer describes the charge held on its behalf.
- SK_MEM_RECV_ZEROCOPY 0x100 overloads a 'kind' argument that is a
  small enum, used in the tracepoint, and forces a change of the
  fall-through in a core function.
- Adding a .close vm_op silently disables VMA merging, see
  is_mergeable_vma().
- VM_DONTCOPY and VM_DONTEXPAND are user visible behavior changes,
  proposed here for stable kernels.
- The reservation is never reduced on partial unmap : nr_pages is the
  size of the original VMA and the refcount only tracks fragments.
  Unmapping all but one page keeps the full charge forever, on a
  socket that sock_hold() keeps alive long after close().
- mmgrab() and sock_hold() are redundant. vma->vm_file already pins
  the socket, and vma->vm_mm cannot go away under its own vma. Once
  VM_DONTCOPY is set, the zc_vma->mm =3D=3D mm test is dead code.
- kmalloc_obj() does not exist in any of the stable trees you are
  Cc'ing.
