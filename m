Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859BC20E030
	for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Feb 2026 19:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771875343; cv=pass; b=LkMgM8CEScoWtsuuSFNso4VTmSiR7X/Eul1qGnFukeR+5eRf6+tzjMKjO4HNTzkHLyhGo302wmymHh8mYApuFNxxKW2eUPyF0DSAEll5ux4asl7Iq+WSlj1I9T1Eu0FWhd+G2SnL76F8dtO7pl6ORSX2FX+G7mmcHStO926cNXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771875343; c=relaxed/simple;
	bh=axPKsj973CJEnsqXW6JO5OGkwmZLoejWq3/4vMg+PHg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MGbyoLQzQuJ9kS5Ts5/+9wR2vysjFQigZDxy2Ey9BrU3jwgPed585LnsXS/+iTt33OlbBcENRvs4nObfhmN4/G7j+DYZaDfXTwrzaIt99sfB+S9A4xuUqhXFH9NlsAcLB0ZAGrE4Wp1IgodXgtfZzf2aU5PkaG0cfhFJmJbTSUI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UkXHs/PV; arc=pass smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UkXHs/PV"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4359108fd24so2924891f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Feb 2026 11:35:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771875341; cv=none;
        d=google.com; s=arc-20240605;
        b=aRFxO1DNtr0WXDrZW2o1obvTxAhqNWBkqJpoea/46LGZKusFeOaxyPJ4+PhZKz+Xpq
         sSZjt4ppR+FuE5H8vA1/V3U9GRR/n2EliSydE3pHps+n5dlmzbsXHkn/LgKhJXcEMgBu
         H+tolkJ8TRsvRDBy/0Rim6LorzBClazTUiXicgoC5fEXhPas8TzyIpB+uvJT0+8OoEoP
         QMCyA9iLKd00MvpjZ5zYONBCkQD5SPdJB8FBDyyp5Tug0OfqBI5+I9DNk/rq0oDFu47H
         QMPnbufMF57ggI5pvjWfcbjuTyyOV2YjkwjKworrcskCELPQCiDeVwblfl7DEDZQxuva
         h7xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MBHq3GUoAOL0w6S711awWfpqNru5IpSsWmVFqqx/NGE=;
        fh=eqAm7sk9na+xmQARZzlcx/9we6WRsdsIednYvB4tPN8=;
        b=LZkGaJC7Vm2/HQqKvHtEDwdba6Cyf15IKav67bvO7DwOaVSI5UhzuMw5GXHrO1Jpcw
         OTXx4r/68/n3w6R2s06AC/BBP0Yz01zWb77c+5F4EqLzb7/4jb5iQGdH6XGSJnCtdtY2
         O0/Tx1rwYYtcC/2JxpuiVcilisHlmH9PgNZyv4BNU1bFcCHrM1SVKrstgBUpzqI9AUn0
         0R7xxqi3AiyXHG3dP9S50EIkY3MzP36jCDia1dOn0WJ53SIzQWmZYXs/b//rqSMUQ52Z
         Vm7YHuW9FJp3Yf7AqjqNp+cQYZnm1w1DWHSQCSXNXgZye54weoO+UcWgshP7xOKm7JWp
         IO1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771875341; x=1772480141; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MBHq3GUoAOL0w6S711awWfpqNru5IpSsWmVFqqx/NGE=;
        b=UkXHs/PVkUBHkVYAv7JRvfAqkX+EdQmgAQsp/+c63qBkNyPsmaFXe9OKSdBLP5x/jk
         kEXYrqFju+cbkM5CSRapouhOz+h9Q6uPXLuCfYSd9e4iaZ22wKA56+DX5yKv/ePmj+HL
         CiAnGMEHr4y9a1EwrE8SGVcccibnX9KM5JbTlM4lHBnVHPAiu3gEMaRBkXS4Lur3qee2
         bOcQiIhwlTlsGAANkpudi5U0kYO7UpwfmdtRBn13kk/0pfkmX39bqY1nt2kSoE8/wPpv
         qvgzVMXl9nN7zC10X6Ygt/uYxSZjkf0S8Zg6ZwurTWjth7LkLwN6egBRvqHPUIOGMZ19
         lGCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771875341; x=1772480141;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MBHq3GUoAOL0w6S711awWfpqNru5IpSsWmVFqqx/NGE=;
        b=L81dKV7iJpdzvfl1xy8rXvHLVtzY3YS7XxDM7KcvaQZTovQ/7+72GaWjYrLFMWDYI+
         Qao2oL5yZfzZPQtYahyctpaUFP8siMdynedTBT74o1S9CR9raLRlKQ1IOB05Fe499L27
         PSujlfmd847FeHuUHwxvZoQI8KdBOPgTSaztwn7KmUljUofj5VW4UHvfWDwjX7ANboZN
         zq+0WjVllrpRCRqICNJj4h13I1yj685TbPkEoRyjXSyitVlu/7hfp24kFxwVICtpoGue
         eXuJt/Rd6JOuTjpcGbiUzK191J3VdY2bJim9zlEhiCtblst7Gx82XtKbTvz3OJSyC3lS
         4HNQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5Qt6jMb/Wsn6xjfC7Km0JOsd9nyXVSGcbEburwzfwHOAhJ+dZ8nYNgLTUqoNqLmiKSGPLE3R6qTejbEwUVqtgv8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhdNgA7cbgkqeUiEzUJ7+4nnhctOUTZrxiWsTuVDfQ9GKoiyfs
	P3isumstO3ftb159NUScD+m2P+k9rg//m250Hlr1Y3FUPfxRDKWi/21D/rcXiDHz0vHgx/9H5M5
	dTL6R7HlC658JU3j1NLxFyBgIGpPDoyw=
X-Gm-Gg: ATEYQzzCvrytIbzaCIcDzGuxeVBVFwqnLGwHQVALk2YABcfixxnbgJmtj7fd8G+JXpk
	2NCPO7eZtURbSVe/vs3TnWVZYeecNJVlltTR+t7ZC1lW9KPI+BMTYjZ1HmdJ59TJid0qpDJ3y3G
	p2nEMoB1KSYtRLvvZzqmyZNUhLx79f/67wfgcS+1Ad18oJrpzynh6Xi74gsE0eiqad5K7PvwXDo
	T4QKddCua0D1yvOscF3z3+nlOOlXy8Yd7FbR76If8Bg5fVieqnIu5Zc7BSmxAuixZOFGy0eBgK9
	MHq3I6Ayn9XvZhSVFchnGoSd/9BTZRkZ0A2oMtT2PtS94tP6uK0M1q9BmEo0N3fj6wfnRVZ6DEB
	iUVI4SiJT
X-Received: by 2002:a05:6000:26c3:b0:437:67b5:9bab with SMTP id
 ffacd0b85a97d-4396f1954b4mr19136260f8f.56.1771875340626; Mon, 23 Feb 2026
 11:35:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220100649.628307-1-jolsa@kernel.org> <20260220100649.628307-3-jolsa@kernel.org>
 <CAADnVQ+2-DtgWqeKmrbsP0O7Rz2ZkDjkh1kfHDSxF0K8Xs+1ww@mail.gmail.com> <aZsT6_3tkli3SPsI@krava>
In-Reply-To: <aZsT6_3tkli3SPsI@krava>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 23 Feb 2026 11:35:29 -0800
X-Gm-Features: AaiRm52XzWV142EilgaigHV4dPqGxP7EWSSexa4oS_s3WmGsUCX0T2Q1_V9DwOI
Message-ID: <CAADnVQL_Jpe_7a55HTn5CyYoxWcHahiK3+CDeOeURqZAuf+teA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 02/17] bpf: Use mutex lock pool for bpf trampolines
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, Martin KaFai Lau <kafai@fb.com>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	Menglong Dong <menglong8.dong@gmail.com>, Steven Rostedt <rostedt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 22, 2026 at 6:34=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Fri, Feb 20, 2026 at 11:58:13AM -0800, Alexei Starovoitov wrote:
> > On Fri, Feb 20, 2026 at 2:07=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wr=
ote:
> > >
> > > Adding mutex lock pool that replaces bpf trampolines mutex.
> > >
> > > For tracing_multi link coming in following changes we need to lock al=
l
> > > the involved trampolines during the attachment. This could mean thous=
ands
> > > of mutex locks, which is not convenient.
> > >
> > > As suggested by Andrii we can replace bpf trampolines mutex with mute=
x
> > > pool, where each trampoline is hash-ed to one of the locks from the p=
ool.
> > >
> > > It's better to lock all the pool mutexes (64 at the moment) than
> > > thousands of them.
> > >
> > > Removing the mutex_is_locked in bpf_trampoline_put, because we remove=
d
> > > the mutex from bpf_trampoline.
> > >
> > > Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > ---
> > >  include/linux/bpf.h     |  2 --
> > >  kernel/bpf/trampoline.c | 74 +++++++++++++++++++++++++++++++--------=
--
> > >  2 files changed, 56 insertions(+), 20 deletions(-)
> > >
> > > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > > index cd9b96434904..46bf3d86bdb2 100644
> > > --- a/include/linux/bpf.h
> > > +++ b/include/linux/bpf.h
> > > @@ -1335,8 +1335,6 @@ struct bpf_trampoline {
> > >         /* hlist for trampoline_ip_table */
> > >         struct hlist_node hlist_ip;
> > >         struct ftrace_ops *fops;
> > > -       /* serializes access to fields of this trampoline */
> > > -       struct mutex mutex;
> > >         refcount_t refcnt;
> > >         u32 flags;
> > >         u64 key;
> > > diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> > > index 952cd7932461..05dc0358654d 100644
> > > --- a/kernel/bpf/trampoline.c
> > > +++ b/kernel/bpf/trampoline.c
> > > @@ -30,6 +30,45 @@ static struct hlist_head trampoline_ip_table[TRAMP=
OLINE_TABLE_SIZE];
> > >  /* serializes access to trampoline tables */
> > >  static DEFINE_MUTEX(trampoline_mutex);
> > >
> > > +#define TRAMPOLINE_LOCKS_BITS 6
> > > +#define TRAMPOLINE_LOCKS_TABLE_SIZE (1 << TRAMPOLINE_LOCKS_BITS)
> > > +
> > > +static struct {
> > > +       struct mutex mutex;
> > > +       struct lock_class_key key;
> > > +} *trampoline_locks;
> > > +
> > > +static struct mutex *trampoline_locks_lookup(struct bpf_trampoline *=
tr)
> >
> > select_trampoline_lock() ?
>
> ok
>
> >
> > > +{
> > > +       return &trampoline_locks[hash_64((u64) tr, TRAMPOLINE_LOCKS_B=
ITS)].mutex;
> > > +}
> > > +
> > > +static void trampoline_lock(struct bpf_trampoline *tr)
> > > +{
> > > +       mutex_lock(trampoline_locks_lookup(tr));
> > > +}
> > > +
> > > +static void trampoline_unlock(struct bpf_trampoline *tr)
> > > +{
> > > +       mutex_unlock(trampoline_locks_lookup(tr));
> > > +}
> > > +
> > > +static int __init trampoline_locks_init(void)
> > > +{
> > > +       int i;
> > > +
> > > +       trampoline_locks =3D kmalloc_array(TRAMPOLINE_LOCKS_TABLE_SIZ=
E,
> > > +                                        sizeof(trampoline_locks[0]),=
 GFP_KERNEL);
> >
> > why bother with memory allocation? This is just 64 mutexes.
>
> ok, I could probably use __mutex_init directly for static key
>
> about 64.. not sure how I missed that but there's lockdep limit for
> maximum locks depth and it's 48.. so we'll need to use 32 locks,
> which is probably still ok
>
> >
> > > +       if (!trampoline_locks)
> > > +               return -ENOMEM;
> > > +
> > > +       for (i =3D 0; i < TRAMPOLINE_LOCKS_TABLE_SIZE; i++) {
> > > +               lockdep_register_key(&trampoline_locks[i].key);
> >
> > why special key?
>
> if we keep single key we will get lockdep 'recursive locking' warning
> during bpf_trampoline_multi_attach, because lockdep will think we lock
> the same mutex
>
> there's support to annotate nested locking with mutex_lock_nested but
> it allows maximum of 8 nested instances

yeah. subclass limit of 8 is there for a different use case.


I guess you never validated your earlier approach of "let's take
all trampoline mutexes" with lockdep ? ;)
MAX_LOCK_DEPTH is indeed 48.

See fs/configfs/inode.c and default_group_class.
It does:
                        lockdep_set_class(&inode->i_rwsem,
                                          &default_group_class[depth - 1]);

the idea here is that the number of lockdep keys doesn't have
to be equal to the actual number of mutexes.

I guess we can keep a total of 32 mutexes to avoid making it too fancy.
Please add a comment explaining 32 and why it needs lockdep_key.

I thought declaring all mutexes as static will avoid the need for the key,
but DEFINE_MUTEX doesn't support an array.
So since we need a loop anyway to init mutex and the key,
let's keep kmalloc_array() above. Which is now renamed to kmalloc_objs()
after 7.0-rc1.
