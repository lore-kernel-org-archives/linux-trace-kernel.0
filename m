Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961F91891A9
	for <linux-trace-kernel@vger.kernel.org>; Sun, 22 Feb 2026 14:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771770865; cv=none; b=T9tpSQYpm0EwmvfQ6oZZ4+dJIgPjD8HN+c6VsCVjq4TtMRi4jEe5FF+zhNdRaSJ/7Be2MyUNBu1cjWRxptvcJrAmS63SvNlrKhQv7qbPIAAHGrvtyIUg51oZWjjCXCHbneE6p4AJ9W0gCjF3TNa+7azU7bsaaJwiYs74Rn82nEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771770865; c=relaxed/simple;
	bh=iwC5COgwgzXREL+HSnwzvudbLCHxhnMrCuFn8rsYa3c=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qvPnGxMIBv6Kqv1dgDusVv6LUDu1Ja2wMccSA8rIt9avzMLJbMEDGr53Cnlp+nDC7T03YgSSNG6UyYkc9dBMYwzmHoTx+Wp+2qnhWVi3dW9hokNjI2PbTiQDbTJvQlQOdi+U0MoBe6hMBqW9s3LeM7I4bsivUna4mEuC63mF5VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l5jmP0nz; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l5jmP0nz"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4834826e5a0so42862735e9.2
        for <linux-trace-kernel@vger.kernel.org>; Sun, 22 Feb 2026 06:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771770862; x=1772375662; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=f2iREcOuZFZngTRWXBomV3xMPmiBBixK0bNapJAqgEM=;
        b=l5jmP0nzVfONvwdPp1psmBtTgx/u9f9s42ewxUbvTmNW9D8F1ogxGsmrVEXjaGTFMp
         eoNjSvF/kUIOM7noOWXrq+HaisTmTFu2thoKVBj2CxqkYaUhrD2g6S9c3YlFYj2bG405
         QCnuRqOu7J0EloBW2RijiCmaeUQyHA0TFx/CduNSItsejXcKZ+7DvvXuuIpV+piXMEMI
         vvcAYq1+wMWhbPipvNQydYYP6SRB1vz33aXOzxY0tcyEjk5UaizuFIb0+k58de4HFH0h
         jHTOiVAD+Ffw3WxD6vwc8oHLQb+7rjIrZTfBOBkTF0+nmyzm4a4mIpPZ/DlY4uEAQDZ0
         n+sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771770862; x=1772375662;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f2iREcOuZFZngTRWXBomV3xMPmiBBixK0bNapJAqgEM=;
        b=xGx7uaoskMWdE8AkG9ACszvMsDxJeaHxYbfg/wqCXMXOcNKgwGBycJZDF1stgDAgtZ
         76zPyapqFtAITA2c8sfOOhuqA/gAxpa8nMOB+Oy3twRKVJCJb/nblzlV5GIELXgjS1kV
         UtpE36lngrs6orJ5MiFvGsupwSBLf3J9CG6YOGKLodfRyvU7hUPQvAE9TIqyvYLUF5QD
         8NDJKYhZPi6FZYbsTb/vpgtii3smDWzSBGrvYQQ3m3PmVo9/z8IuO9Tmps+gy5Zf3no/
         2b+oZovv1qy0GDQGc/aOIviaY3xuLXsYQhvEXeSJpKc2PDB8MReBbi4Yv+aVEx7OcDGg
         U3XQ==
X-Forwarded-Encrypted: i=1; AJvYcCVg9vU7FDJVGMetK5UUj5SxFWl7s0J0q1AguxkRL7Yc7nIzEsJPpSWRjQGhcUzOaiUttuFk9Wll6mhOGScALl3RFEI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp/FmDYa36vapAqN79mFVcp3VPECBSg2kngHWXumlGZH16pxbn
	7YOL6rEvOLiBJMxJAz/+Fo/0jKZOF00GnXInTImwKQW1RkiphDpS+Eg/
X-Gm-Gg: AZuq6aJudE510t3ekb/2vmmVFR6xfcR8pRpYj0hfhFhDFlvOCOjqpl2h6R3QB96GbKn
	2iefpcIrmmGnyYkA7NrnChnyUWjqt57JaNcONkhP4h0mJJKw6woclhh0xhx3ztv9uInR8VSTpVu
	9lXdD5yS3sKPZW1qc04gFAlqtncJhEDlekouJ+U+gwzoso79BxVrq6FDEhxw9Mv2ixaeXbOKs6X
	vI+LGaJbWxaLs+zgn7P2oR2G6rhjETwZ57zFy3SDYmDUbENrCSM3zraA9zcEquJfvH8CDlr1pMe
	9swlmK3A3Zj9cIfZuDWp3yf111xbh3iIH69YqWU681v4mqPzmzVv8me8pwNsYf6/K95d+iJ3RgQ
	mfcQBQTm5tHmvPRLLH0SRMCfuFvGY87xd6FVkKJybzlxLxTtRjIIqlvmYtbdCmYkN7F8OlwQO
X-Received: by 2002:a05:600c:c4a2:b0:480:20f1:7aa6 with SMTP id 5b1f17b1804b1-483a95e96e4mr88757775e9.21.1771770861802;
        Sun, 22 Feb 2026 06:34:21 -0800 (PST)
Received: from krava ([2a02:8308:a00c:e200::b44f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a3dd3391sm128593645e9.1.2026.02.22.06.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 06:34:21 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sun, 22 Feb 2026 15:34:19 +0100
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>,
	Martin KaFai Lau <kafai@fb.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Steven Rostedt <rostedt@kernel.org>
Subject: Re: [PATCH bpf-next 02/17] bpf: Use mutex lock pool for bpf
 trampolines
Message-ID: <aZsT6_3tkli3SPsI@krava>
References: <20260220100649.628307-1-jolsa@kernel.org>
 <20260220100649.628307-3-jolsa@kernel.org>
 <CAADnVQ+2-DtgWqeKmrbsP0O7Rz2ZkDjkh1kfHDSxF0K8Xs+1ww@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQ+2-DtgWqeKmrbsP0O7Rz2ZkDjkh1kfHDSxF0K8Xs+1ww@mail.gmail.com>

On Fri, Feb 20, 2026 at 11:58:13AM -0800, Alexei Starovoitov wrote:
> On Fri, Feb 20, 2026 at 2:07 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Adding mutex lock pool that replaces bpf trampolines mutex.
> >
> > For tracing_multi link coming in following changes we need to lock all
> > the involved trampolines during the attachment. This could mean thousands
> > of mutex locks, which is not convenient.
> >
> > As suggested by Andrii we can replace bpf trampolines mutex with mutex
> > pool, where each trampoline is hash-ed to one of the locks from the pool.
> >
> > It's better to lock all the pool mutexes (64 at the moment) than
> > thousands of them.
> >
> > Removing the mutex_is_locked in bpf_trampoline_put, because we removed
> > the mutex from bpf_trampoline.
> >
> > Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  include/linux/bpf.h     |  2 --
> >  kernel/bpf/trampoline.c | 74 +++++++++++++++++++++++++++++++----------
> >  2 files changed, 56 insertions(+), 20 deletions(-)
> >
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index cd9b96434904..46bf3d86bdb2 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -1335,8 +1335,6 @@ struct bpf_trampoline {
> >         /* hlist for trampoline_ip_table */
> >         struct hlist_node hlist_ip;
> >         struct ftrace_ops *fops;
> > -       /* serializes access to fields of this trampoline */
> > -       struct mutex mutex;
> >         refcount_t refcnt;
> >         u32 flags;
> >         u64 key;
> > diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> > index 952cd7932461..05dc0358654d 100644
> > --- a/kernel/bpf/trampoline.c
> > +++ b/kernel/bpf/trampoline.c
> > @@ -30,6 +30,45 @@ static struct hlist_head trampoline_ip_table[TRAMPOLINE_TABLE_SIZE];
> >  /* serializes access to trampoline tables */
> >  static DEFINE_MUTEX(trampoline_mutex);
> >
> > +#define TRAMPOLINE_LOCKS_BITS 6
> > +#define TRAMPOLINE_LOCKS_TABLE_SIZE (1 << TRAMPOLINE_LOCKS_BITS)
> > +
> > +static struct {
> > +       struct mutex mutex;
> > +       struct lock_class_key key;
> > +} *trampoline_locks;
> > +
> > +static struct mutex *trampoline_locks_lookup(struct bpf_trampoline *tr)
> 
> select_trampoline_lock() ?

ok

> 
> > +{
> > +       return &trampoline_locks[hash_64((u64) tr, TRAMPOLINE_LOCKS_BITS)].mutex;
> > +}
> > +
> > +static void trampoline_lock(struct bpf_trampoline *tr)
> > +{
> > +       mutex_lock(trampoline_locks_lookup(tr));
> > +}
> > +
> > +static void trampoline_unlock(struct bpf_trampoline *tr)
> > +{
> > +       mutex_unlock(trampoline_locks_lookup(tr));
> > +}
> > +
> > +static int __init trampoline_locks_init(void)
> > +{
> > +       int i;
> > +
> > +       trampoline_locks = kmalloc_array(TRAMPOLINE_LOCKS_TABLE_SIZE,
> > +                                        sizeof(trampoline_locks[0]), GFP_KERNEL);
> 
> why bother with memory allocation? This is just 64 mutexes.

ok, I could probably use __mutex_init directly for static key

about 64.. not sure how I missed that but there's lockdep limit for
maximum locks depth and it's 48.. so we'll need to use 32 locks,
which is probably still ok

> 
> > +       if (!trampoline_locks)
> > +               return -ENOMEM;
> > +
> > +       for (i = 0; i < TRAMPOLINE_LOCKS_TABLE_SIZE; i++) {
> > +               lockdep_register_key(&trampoline_locks[i].key);
> 
> why special key?

if we keep single key we will get lockdep 'recursive locking' warning
during bpf_trampoline_multi_attach, because lockdep will think we lock
the same mutex

there's support to annotate nested locking with mutex_lock_nested but
it allows maximum of 8 nested instances

jirka
