Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794754480;
	b=q1eLMSNlDC1EQk5rGu3Zl8K1fWTtNfLi22SSKpTwwYMhqRTpyjtU2muhhIfJfYKHHmt4
	 R/ht/LCccZDA7/FpyOi4WJ62Bg2/2kNeewDO13yNKegdFaJCIYrlp5bp52mNlN5S5rEtc
	 yGbqW6h1cjk2Qd095Jvti+C5rkJiL4dAhqTWWgRNKvdAnbVDc6VMfI4kS0EpvXqD9nzTl
	 ci4lfzWEKnjCDRAgvhXhOgNYcSNRju6ix4SR6QZfeDEIz44i3Y96NBYHzfc35lIChtGDC
	 1OPinM/dp82sy5z0R6MxsFcr7Gvf7GXdqBaWXRTExXq34aBSFJo4nqKn4408ngfV46Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794754480;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=oqISismNDREzK3BapMQL3oVfFqMKLBzQ11G0pwa4rCw=;
	b=3GD1q77B9tnjp0fxov6dvjWChjoS++4iDgEJpwnF+loTF0TcKh4CiLmQBnjXnJY5MltC
	 7B7sV1CYtr3tacSlbqNgmuIOTvrQSY67+iiGvaacmZqxSKCsVUeYEJirfxbKDiDpbjGLm
	 J6rlOAx0a5qxr4/BUBKLdwd5LiTuEQx+Hg0AOSzZao/5VBuZlApRW8uzCojudQc+g8LYz
	 eEQqiq7hmW2zWdjdllqBQMfiNW4oSqrc9PPxL5ouaSFQCtBq7wMVUup3BisUGTtojVCrm
	 3/e8gBevH+nVhMoBzXP611gS6IZQQ3BCUS5HtYZGRtmG9BkoRscUmta/LBwDo619QFg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Nene7tW5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.42
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34840606A32C
	for <linux-trace-kernel@vger.kernel.org>; Sun, 15 Nov 2026 14:54:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34840606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Nene7tW5
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6a642495d81so4336897a12.2
        for <linux-trace-kernel@vger.kernel.org>; Sun, 15 Nov 2026 06:54:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794754478; cv=none;
        d=google.com; s=arc-20260327;
        b=hixYui8eHupcesfIRG+Nw2ENgOUgRar/2jUAKB3FrSm3D0qfO7Jd7wxn6QTJLYSAbG
         NeRAbKUwRcz4bAlKhdgdt0z6MIFBQOtPxvXP6I035HHF7XAbf2NSkco/+EfV+Y3UwTRz
         KnTrQZikJluJXjB75jn1pqlaX4G4NlgrlAWgidSR8RzEXOulYYQJPfWUZpk5PTQnzTeU
         t5OruMt6ofKrj1dT3RHy36cd/onVNL2f9aFdRUaZgRE35ySU/kGO5nr+HUHjtU/vBBgt
         M0fA8HienV85fs2zAc7SP6/+rRuBL8lZnCks6Lg7fgZbN0UHcxqMQS2E4eaIwMpNBheX
         arLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oqISismNDREzK3BapMQL3oVfFqMKLBzQ11G0pwa4rCw=;
        fh=2Ise5kcircxzqxhncZBVh8JZn6+Zv2YHsrwXcAQdPd8=;
        b=AG7iYYhnui7E+vHTwCfvstkQU4gxbouLnc8Z2IKm5QX+jvBpfY9JS6idCoGMqnBkLL
         SVBPMQiywz2Ih8LD4J9gQ50a7EnI47IdtRG58PyEl9ME7oneUwnyBmeoq6wNzkth8Qa+
         P67Ojji8iE1SHreEXbIzZbndEqWAYMWMJhTxwmiqjFHAYa6epHf8SsQ7AOCKCM/92z8w
         RXChC1Ci25TYDsjYcN6biEA2mA0OQCo3tf48d7xaHVDCXKhKD7tRw9u75aXTWa1EkkJk
         DpTkBMxea43nrGv1j9NUEBOvqJAxr0j/VM/lM1YH7wMt4mZ2iufdoPkk7Gc2XVi/8DcG
         8OwQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794754478; x=1795359278; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oqISismNDREzK3BapMQL3oVfFqMKLBzQ11G0pwa4rCw=;
        b=Nene7tW5gi/n28xM9GPcsrsbApaftwN+5VLijlNSUx682MtoFHHSTEvDl1z11fpu1X
         HvQApdaPQrGfQyiS3FbYQVWjhD4Evwt6P0rS5BC7bOQTZVXFLWaPO4OPsg6ddRko0o+q
         9oJBo3AXuMJZvhtMaEl5yxlnDv3/Y+/ZTOoPRzC8SnU76nRTNG9VsBQOFmcVN+eTzILI
         pLq9xeN6fA01RGoB9NuHnqix3fuxZlQryfHYntRw18u5V1gyWgLisGhonGsU8L2T6Lkf
         J6bkZRN93M/WAUT22qxzPXNMWojuGB568xJ5NJFT1QuthxcS4hfC3ctLRiOXitSCJ+gM
         bTMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794754478; x=1795359278;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oqISismNDREzK3BapMQL3oVfFqMKLBzQ11G0pwa4rCw=;
        b=G3l5P/5dmF5wsu2S0CDTxRO2o6eEWVwdYDSAmhn04X8v+FpmDTrC5W/0szmcs6Cmp+
         qo7LiCqQzr1La7qg3sHGjVTpUOgjW3h7TGD/e9Ufy4iFHQ3ucJLWD/fEhRjLMk+wpLjG
         efvbY1KtcipKW/7YlxRvVwATnHvM3vbrwTOHO+Z8paxeCOR3aQ6o4KhHaSVpIRBrR6j2
         O0+Nh2YPdTZSq135vVMMTYgYlzsmvN+PKZx482r8hJtlctMThfBgrUvvyd6rbElfq3tz
         uMDiytqeneeeA8bKmGPFxDrNEw2nFiBXl1Fby5AKdoHCB4mEFI99AEPIsEPqyIJEM+1t
         sKNw==
X-Forwarded-Encrypted: i=1; AL+hErGEZ5g35TrwN62wxt3uu3Z+S0lWIOmXs4gcRmWxN3/PBj9np8ELCPKSbBPZn++JgfBeqnuVUODRnv2Rohc/sXsvFTo=@vger.kernel.org
X-Gm-Message-State: APuU4Z8C6mwX6uNVw4fPmlHGZiHOYKcFsqtkpMetKdiIE25ZH2OObdOj
	HzoWUXv/dcbAYr81GgGXCkSR3ALAAWuLqxMNV02q6icZn4Y+XZ0cPbde7tusnu4KiBNSJmhXUds
	UklpKF5BnhZcMfEy6uL+UA10FKOJiAHw=
X-Gm-Gg: AYBFou1l+LBxlHUhQzkBy4oVgjTvwDkBHacz7VTB7hmcpWBAZ/6yTsayIe7Q2RKF9IQ
	YMdQ10TPQaeYuWr+YwRsbKdsHCX7brLc8NU19K5csfeAkJwj3o5fu5mDyhrQ3bW6eUh+Hx0RSXU
	KPFwUXHE8dMk+lpli0dYpPlAuerY/nsWDaXhuX8Wota9opznzYD5d4gWYit/oJBDstuw0LeZ2LU
	SJDZW2krFHR7/kGNq1uVR/6M4JbdT1KuxarZgMFqUW5Gu135zOJRHlpo/jrclgB/3ElSkXdjYc9
	7t/qPfKx3wxPavwpx9rFjwh2Gkq1AKk7YdppDED4MNxB8FLTiPdq6LP8htEG/o0EHk7w1kTiai6
	7RzcsRC1PPUhQ7ifp1dh1SStR/L1hfrm87E+TZXTC5FaXJEjre8j3ifUFe3UHlPXJLf5gIw==
X-Received: by 2002:aa7:d1ca:0:b0:6b1:c2cd:db0c with SMTP id
 4fb4d7f45d1cf-6b7c0957c1emr4306146a12.10.1794754478075; Sun, 15 Nov 2026
 06:54:38 -0800 (PST)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261115-work-ovl-d_real-v1-0-ca155efbcb2e@kernel.org> <20261115-work-ovl-d_real-v1-1-ca155efbcb2e@kernel.org>
In-Reply-To: <20261115-work-ovl-d_real-v1-1-ca155efbcb2e@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 15 Nov 2026 15:54:26 +0100
X-Gm-Features: AclHuK8KXHVL-duO-F-YZ8XPwW63n9hxew9z3khJWwo4KtxA0bTnHEz-HW4OPxU
Message-ID: <CAOQ4uxhkqQE+ONrcgJNw2Jah59bKruxUAsLohTtKnsgTVQBw-A@mail.gmail.com>
Subject: Re: [PATCH 01/13] ovl: don't warn when the lazy lowerdata lookup
 fails in ovl_d_real()
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Chris Down <chris@chrisdown.name>, 
	Miklos Szeredi <mszeredi@redhat.com>, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-mm@kvack.org, 
	stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 15, 2026 at 3:02=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> ovl_d_real() looks up the data of a metacopy file in a data-only layer
> itself if nothing has done that yet. If that lookup fails it WARN()s and
> returns the overlayfs dentry.
>
> Commit 42dd69ae1af4 ("ovl: implement lazy lookup of lowerdata in
> data-only layers") assumed that the file would be read before
> trace_uprobe places a uprobe on it so the data would be there already.
>
> But nothing actually guarantees that. trace_uprobe takes the path from
> kern_path() and calls d_real_inode() on it when the event is created and
> again when it is enabled. So a uprobe on a metacopy file whose redirect
> points at nothing warns twice:
>
>   ovl_d_real(/f, 0): real dentry not found
>   WARNING: fs/overlayfs/super.c:79 at ovl_d_real+0xc9/0x210, CPU#2: sh/27=
9
>   Call Trace:
>    <TASK>
>    __trace_uprobe_create+0x1869/0x25b0
>    trace_probe_create+0xcc/0xe0
>    dyn_event_create+0x46/0x70
>    create_or_delete_trace_uprobe+0x3c/0x70
>    trace_parse_run_command+0x1a6/0x320
>    vfs_write+0x1cd/0xfa0
>    ksys_write+0x116/0x250
>    do_syscall_64+0x10e/0x5e0
>    entry_SYSCALL_64_after_hwframe+0x77/0x7f
>    </TASK>
>
> bpf's uprobe_multi does the same.
>
> A failed lookup isn't a bug though. The data can be missing, its verity
> digest can be wrong or a signal can interrupt the wait for the inode
> lock. ovl_open() simply fails in that case and
> ovl_maybe_lookup_lowerdata() already warns ratelimited about failed
> lookups. So return the overlayfs dentry without warning. That's what the
> WARN() path returned anyway.
>
> Fixes: 42dd69ae1af4 ("ovl: implement lazy lookup of lowerdata in data-onl=
y layers")
> Fixes: 184996e92e86 ("ovl: Validate verity xattr when resolving lowerdata=
")

Nit: 42dd69ae1af4 came first and opened the possibility of goto bug
and then 184996e92e86 came later and depends on 42dd69ae1af4.
I don't really see the benefit from stable POV to name the later as Fixes

> Cc: stable@vger.kernel.org # v6.5+
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/sashiko-outbox-214581@kernel.org
> Reported-by: Chris Down <chris@chrisdown.name>
> Closes: https://lore.kernel.org/all/20261114120557.4bc1eb6e57218cdc@chris=
down.name
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  fs/overlayfs/super.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index 08695a99f4f93..1985b553a47b7 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -58,15 +58,13 @@ static struct dentry *ovl_d_real(struct dentry *dentr=
y, enum d_real_type type)
>
>         /*
>          * Best effort lazy lookup of lowerdata for D_REAL_DATA case to r=
eturn
> -        * the real lowerdata dentry.  The only current caller of d_real(=
) with
> -        * D_REAL_DATA is d_real_inode() from trace_uprobe and this calle=
r is
> -        * likely going to be followed reading from the file, before plac=
ing
> -        * uprobes on offset within the file, so lowerdata should be avai=
lable
> -        * when setting the uprobe.
> +        * the real lowerdata dentry. Callers may ask for files that were=
 never
> +        * opened, e.g. for uprobes or O_PATH files, so the lookup can fa=
il
> +        * here. Return the overlayfs dentry then.
>          */
>         err =3D ovl_verify_lowerdata(dentry);
>         if (err)
> -               goto bug;
> +               return dentry;
>         lower =3D ovl_dentry_lowerdata(dentry);
>         if (!lower)
>                 goto bug;
>
> --
> 2.53.0
>
