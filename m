Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439E91E5B63
	for <linux-trace-kernel@vger.kernel.org>; Sat, 10 Jan 2026 00:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768005415; cv=none; b=JGLIdfv17Ywtu+6ns4ncY9mw0ihe/RIecBHWy4a2aP3GNnxPbsX2IlSUMYCBiF4lYW3JicCW3Pu6VFw+Ys7kacMXJ5/e+ZccqL4bAsM8YaxfTRjzCPiW2ekSmavSQ9K1HJ6ZsdoETTOWyLXp9ef7c8RyUoCI1tO60eqQaAyUuH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768005415; c=relaxed/simple;
	bh=qLjmFngL2lpBaKabuTDzsU4j7Y2e7O5Rz23xDOBslZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pwxk0E88rap/hKntd+YiKg7EHBNO2/Q/S7EttRX1ItjF0MVJGyTUYXmHIEWCHKJ85iKtBT9fsASwxxfjt0yHShFQYXPJp9aIhX5AjdsfS6fs3uVW7hsu14og/zqYuZCdMJwDdCEyOk1/NbvWOCbl4TueY1ToiiXVvCSK5qs/BtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FPfvlhZl; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FPfvlhZl"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-bc17d39ccd2so2062146a12.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 09 Jan 2026 16:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768005413; x=1768610213; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3xfM0Rfu3A5cPqn5pc0s1J4LLhtoigHkOk+JZgFzv3k=;
        b=FPfvlhZlDmfJkJxbcDfZVBfefbx1fUVtlhnbaQtNbnLHAepeUWRS8YFsFIaVe61P/9
         T9+MqL2hmEyk+miEP4cee/PZwQi8VCpTBW5iX5WjIaFFV2mFMhH7/ndYmw3nOVkOSJnQ
         H9HPaMRhniyYrmMu8LSQ7W0yQDZ1aX0tW7A6QE1aZj8eIojMiuO7EhI08jjX7wgqUXy9
         1D9PgIOpmeIiwcz48bpaatSMKZo+2bYF3nmg65+SvUHY17xm47M0igg9gN83kIU9Flqn
         tQPEthpHSEF+iZrkW17jhlyKwP3ImVNUv7mtct6DztC51sgLt1PySOvg7mtSPBzuek5A
         xFRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768005413; x=1768610213;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3xfM0Rfu3A5cPqn5pc0s1J4LLhtoigHkOk+JZgFzv3k=;
        b=bySKi2g75C4xzawn27XUClTfMf3q5vfXpqe+3s+1upUNvT4lKI0htPgoTTktLBkFm0
         aoay10Uzut0K4NXl49qfKPDJb5wSQ0BhHzqPMZgg/3O2bMhcyqcNLOatanHYG9hljNmX
         hf++zsE7CIW0e+NriKBQvFN2Bwrkxz2aMcVRCXxCI3JcDZR+Vi8fJssV/C4J/6uWUXPY
         nMjXV8pbeAZpG4bOkiRBe06ka/uhDecGRjmpnAGRXo4sN1aqVlRBqtoRd/WPgjhVRzSJ
         b6GwMe5E+ImSHLJpki9gf+rnGZOYe79KSfsgO6iN0XKtEHvd7lYwmJHPT3lzmByxH1u5
         rxDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtbnqxYV/nN/sy6xFvXUqj0SZ/gxq/kDDLyVbCfZhuA/iBwaHSaMxnCPhXLIXrzffmxK5ghONB2+kwBVeu2vHakwQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy81Vx2P3yvTQFCPSfdKgvKRHHuDaI0gcNKBgyrYFVblGZmvuIa
	7duixw43QpC1u/D3UNaNEIbCwVcjrYrMuwQFMJvdCR+5/ptnWzn1L9xfIyb3XVMWYOUVRQhbpm1
	Y5SMghfghaMyG+gb0PqfZpOi6v6c6auI=
X-Gm-Gg: AY/fxX6yO2ZUId+d1r81RnI6XjKOEsFMfKGtB91EdTu+72+pz4E8lbuZBfm2hl/MZNQ
	Ki80avIL+GNqoygVa0fYhvBAxED0ZROponxRHeIxwVc9oqH2Nz5xu+MdLPNgTK7yvvyHBZP/z6Q
	V1Wulu2usLPThteP/l62f2qyjN89wZ81hLyBvphotrQtc6J1+9pfOyrDWtrDKoy43uskDtzjyDL
	LJ02U6v6La9+imw+vZQpldF2IYxMcdGl5gofAyh+7O1vz8TIqqeD8mUhoObMMyu29w/PadMwOsh
	Df7pFDBu
X-Google-Smtp-Source: AGHT+IGuujBpONry1gvgsQzsvJXudiQyMGBcQwh475VUNcINJSDIO8LkyvpNvKKLPS3N+zwKEoYGeXXz/tJgdhtuXz8=
X-Received: by 2002:a05:6a20:7486:b0:35f:b243:46cb with SMTP id
 adf61e73a8af0-3898f8f4c75mr12372471637.12.1768005413568; Fri, 09 Jan 2026
 16:36:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251230145010.103439-1-jolsa@kernel.org> <20251230145010.103439-8-jolsa@kernel.org>
In-Reply-To: <20251230145010.103439-8-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 9 Jan 2026 16:36:41 -0800
X-Gm-Features: AQt7F2rtiT73HgLTPQ6UI1koaE9wmnP8DTvaic0PVhGcL9KRoTH943ScnrAVW1o
Message-ID: <CAEf4BzYgqWXoKTffa5Y6Xm-nPbL9aFgrStR0GfUs4-88f10EgQ@mail.gmail.com>
Subject: Re: [PATCHv6 bpf-next 7/9] bpf: Add trampoline ip hash table
To: Jiri Olsa <jolsa@kernel.org>
Cc: Steven Rostedt <rostedt@kernel.org>, Florent Revest <revest@google.com>, 
	Mark Rutland <mark.rutland@arm.com>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Menglong Dong <menglong8.dong@gmail.com>, Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 30, 2025 at 6:51=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Following changes need to lookup trampoline based on its ip address,
> adding hash table for that.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  include/linux/bpf.h     |  7 +++++--
>  kernel/bpf/trampoline.c | 30 +++++++++++++++++++-----------
>  2 files changed, 24 insertions(+), 13 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 4e7d72dfbcd4..c85677aae865 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1325,14 +1325,17 @@ struct bpf_tramp_image {
>  };
>
>  struct bpf_trampoline {
> -       /* hlist for trampoline_table */
> -       struct hlist_node hlist;
> +       /* hlist for trampoline_key_table */
> +       struct hlist_node hlist_key;
> +       /* hlist for trampoline_ip_table */
> +       struct hlist_node hlist_ip;
>         struct ftrace_ops *fops;
>         /* serializes access to fields of this trampoline */
>         struct mutex mutex;
>         refcount_t refcnt;
>         u32 flags;
>         u64 key;
> +       unsigned long ip;
>         struct {
>                 struct btf_func_model model;
>                 void *addr;
> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index 789ff4e1f40b..bdac9d673776 100644
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c
> @@ -24,9 +24,10 @@ const struct bpf_prog_ops bpf_extension_prog_ops =3D {
>  #define TRAMPOLINE_HASH_BITS 10
>  #define TRAMPOLINE_TABLE_SIZE (1 << TRAMPOLINE_HASH_BITS)
>
> -static struct hlist_head trampoline_table[TRAMPOLINE_TABLE_SIZE];
> +static struct hlist_head trampoline_key_table[TRAMPOLINE_TABLE_SIZE];
> +static struct hlist_head trampoline_ip_table[TRAMPOLINE_TABLE_SIZE];
>
> -/* serializes access to trampoline_table */
> +/* serializes access to trampoline tables */
>  static DEFINE_MUTEX(trampoline_mutex);
>
>  #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
> @@ -135,15 +136,15 @@ void bpf_image_ksym_del(struct bpf_ksym *ksym)
>                            PAGE_SIZE, true, ksym->name);
>  }
>
> -static struct bpf_trampoline *bpf_trampoline_lookup(u64 key)
> +static struct bpf_trampoline *bpf_trampoline_lookup(u64 key, unsigned lo=
ng ip)
>  {
>         struct bpf_trampoline *tr;
>         struct hlist_head *head;
>         int i;
>
>         mutex_lock(&trampoline_mutex);
> -       head =3D &trampoline_table[hash_64(key, TRAMPOLINE_HASH_BITS)];
> -       hlist_for_each_entry(tr, head, hlist) {
> +       head =3D &trampoline_key_table[hash_64(key, TRAMPOLINE_HASH_BITS)=
];
> +       hlist_for_each_entry(tr, head, hlist_key) {
>                 if (tr->key =3D=3D key) {
>                         refcount_inc(&tr->refcnt);
>                         goto out;
> @@ -164,8 +165,12 @@ static struct bpf_trampoline *bpf_trampoline_lookup(=
u64 key)
>  #endif
>
>         tr->key =3D key;
> -       INIT_HLIST_NODE(&tr->hlist);
> -       hlist_add_head(&tr->hlist, head);
> +       tr->ip =3D ftrace_location(ip);
> +       INIT_HLIST_NODE(&tr->hlist_key);
> +       INIT_HLIST_NODE(&tr->hlist_ip);
> +       hlist_add_head(&tr->hlist_key, head);
> +       head =3D &trampoline_ip_table[hash_64(tr->ip, TRAMPOLINE_HASH_BIT=
S)];

For key lookups we check that there is no existing trampoline for the
given key. Can it happen that we have two trampolines at the same IP
but using two different keys?



> +       hlist_add_head(&tr->hlist_ip, head);
>         refcount_set(&tr->refcnt, 1);
>         mutex_init(&tr->mutex);
>         for (i =3D 0; i < BPF_TRAMP_MAX; i++)
> @@ -846,7 +851,7 @@ void bpf_trampoline_unlink_cgroup_shim(struct bpf_pro=
g *prog)
>                                          prog->aux->attach_btf_id);
>
>         bpf_lsm_find_cgroup_shim(prog, &bpf_func);
> -       tr =3D bpf_trampoline_lookup(key);
> +       tr =3D bpf_trampoline_lookup(key, 0);
>         if (WARN_ON_ONCE(!tr))
>                 return;
>
> @@ -866,7 +871,7 @@ struct bpf_trampoline *bpf_trampoline_get(u64 key,
>  {
>         struct bpf_trampoline *tr;
>
> -       tr =3D bpf_trampoline_lookup(key);
> +       tr =3D bpf_trampoline_lookup(key, tgt_info->tgt_addr);
>         if (!tr)
>                 return NULL;
>
> @@ -902,7 +907,8 @@ void bpf_trampoline_put(struct bpf_trampoline *tr)
>          * fexit progs. The fentry-only trampoline will be freed via
>          * multiple rcu callbacks.
>          */
> -       hlist_del(&tr->hlist);
> +       hlist_del(&tr->hlist_key);
> +       hlist_del(&tr->hlist_ip);
>         if (tr->fops) {
>                 ftrace_free_filter(tr->fops);
>                 kfree(tr->fops);
> @@ -1175,7 +1181,9 @@ static int __init init_trampolines(void)
>         int i;
>
>         for (i =3D 0; i < TRAMPOLINE_TABLE_SIZE; i++)
> -               INIT_HLIST_HEAD(&trampoline_table[i]);
> +               INIT_HLIST_HEAD(&trampoline_key_table[i]);
> +       for (i =3D 0; i < TRAMPOLINE_TABLE_SIZE; i++)
> +               INIT_HLIST_HEAD(&trampoline_ip_table[i]);
>         return 0;
>  }
>  late_initcall(init_trampolines);
> --
> 2.52.0
>
