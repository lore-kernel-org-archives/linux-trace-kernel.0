Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.208.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794754850;
	b=OZIt+YXIcdx5fZTMyIZCECzktOAjoNnspN6/KdJQ8u3yjrxYSREMFWfKauXZMi8krEir
	 KaGNQiYEYhDDbKaMvSXSyHvR+jKfQWPwvHvUz5CpiEV745TedpJ6/GtPGwMHy9sJ6kIGF
	 A1cbbMSmIXupk4gNjgmnBSEbES8ciI9bbKN2CmlZSepW6ajiPMWNvyIK7nzy1gGyt6GAJ
	 NqydRzVL7hBKyVhPBJ1x9A8S+hEB1UxcuSche/Zdsy6DriWDFfJFyUfxsiHHMl5bPFwl6
	 LR5Hxv11WX2F4LYkaJeEYzZMThhsWXMQckE55pUyRsRof9f7QxU6Iph1FRj9/LCi+cw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794754850;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=1MVRNS3ac0YlanU0Fwb5KpLyyO9U1oXwO9vfFA3eak4=;
	b=pWL9TkTf/c/7is0zogjefxRhpH2WTyOu2lSiggUbFWMKhGXRt67eGfNzW/9mlvpycqMr
	 +jl7wC22yV9dAQP8+TJV2f5L4Zn9LFty5O/kaHZusrPWkG79u7r5GRrCCjxBVwbu1/xXt
	 eYwX3IpHnpAJjqZ55/j/8hCL+DUWNf479m0DfGWFghQEd/H1mbdBU3dS9KweuAD+jYnVe
	 mhdxInMaK5wVT7nicMYfGmphg7oe47p49rEO3vkv6n7z2jqXiKcqwAWawHPbKV5P6O2pO
	 UT5jY2+RZwhwwXowc4tbOPHO7hmrPHPQRe+RBO+8DZu7c/MofgHjoOLKoHIpkjhrTmg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SHyOkxQw;
	arc=fail smtp.remote-ip=209.85.208.41
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443FE606A31E
	for <linux-trace-kernel@vger.kernel.org>; Sun, 15 Nov 2026 15:00:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 443FE606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SHyOkxQw
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6b547d6c07bso3753841a12.1
        for <linux-trace-kernel@vger.kernel.org>; Sun, 15 Nov 2026 07:00:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794754849; cv=none;
        d=google.com; s=arc-20260327;
        b=hpphNYYKujHYyyI+kdpUilPLEw06/dYFgLQa+nBqKJHvSt3CnuHuxLLvNH32XijnTs
         V8X/EHCel+nDRehsHfsqyVNyIf/q/ZeRiy2e6nQQBV9ijI3pclxDGjbC65zSxJeSfvcd
         HX2H/QUodVBqtxVkEJKzUv/62xFvH8gLHwj8Tkp/o0ETh9kPTuIZxolH39AdBgAC8JXd
         pT7k09z2jb39g9t/MkHfpR2RQiJySan2fsZXlijw/bv620v7hekVCcnuUGf7PD2rjdXB
         +XqLk+9REpOea+pFpt7fR3o+yDCw3dGEim2SX1ELXpnll92h9VScfzRbXTyHTQhRqrVT
         2ozg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1MVRNS3ac0YlanU0Fwb5KpLyyO9U1oXwO9vfFA3eak4=;
        fh=W3cgIGVJSPC5Kly9HGhBfAIRSQ1ttnTNvxNSgceiBT8=;
        b=hODmj1oXcG9iBKIwDwiXDQ0SFR3WpIKTdKgO7UMVmm+LR/538Z/On7iQEmtGOpyj0e
         zPSSNyzs/z/jF9dWoPMBGbfsxhvVr/sKppWCo5QGYMcpDxev98hkzYaE2f4Qmq4udT3l
         wFAjJZoI+1svLFr3LciZEVEnIEwwfRcERXs1yVb7p++8GtKeXvCyiIRaxW9x++TxIOtA
         yCqk4bdPHYoLApBoCP/MF7CtQ6tEiJ1CWmC09P1YaSNLvtarPiuAN7FjQHqvTT3o/5NJ
         yNJByMRkHHHwB/6negtofI26wfcb6BzCyFTcXWihaOEGAf63PUEhqhdDtYi8CvERU8Sj
         aH7g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794754849; x=1795359649; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1MVRNS3ac0YlanU0Fwb5KpLyyO9U1oXwO9vfFA3eak4=;
        b=SHyOkxQwYuLtL0+Qa53+jCNHfMYZrDoIhK10usTnr/SPlsQtxy3DYcaURrAaqZRP6p
         j9KX2LwDO7WvpxAFvRbeGvPMOpBnbsJEvuh/a+pWnWLMDcViXZq6b/VVaPZ68EhpaptP
         zHr4LucIEpdLZQDJogd72JZdMAkBHyXTxsReEVunL/+oJmqoO/hXoqxPt2Qr8UINUk8W
         PKisRAodcZl5vzpIsG78e9fRi2Mkv3dgu35W/QqWyi6fF9QsZX61BfySIbEHZ7oFXuQb
         7fuxV2YOwjcp9LUN7zRZYNpbm5Ey2kJzr2xgJrjMsYP1vCyRno2ESPfdF+IIuftfMTEI
         HtQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794754849; x=1795359649;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1MVRNS3ac0YlanU0Fwb5KpLyyO9U1oXwO9vfFA3eak4=;
        b=UdvcWH26of0fj/Mf8r6FyiCPO+4IDLthnHRvIXnHDvFgbBlNwitrlwWKYY5zBBvg63
         pTU+6tMGPlHsnIs5d3xH8xIcGAyV/PWp+CvPhnTbjkmtx0Qr5/cJ4reYMG6gY40Kn4x9
         CSLqoMBAGviafpY3XA6ZWSvNZV9n2wBm1saLLd1HxEvE7gh6Jr1WcRxbhUmm6HNlE3ls
         RFF2BdNqhDDaaAioFpEnDNN+kIu3WiSiLPhzdGnYCgFsUtDOCe4zpvcDtahHM+bDeJEL
         9OprKltKwR9uj8yM8iBtye88pPiggNGLZPuNIdqqhTWZ3c/FHtJGuF8QqWcizGGe7QAv
         S2Tg==
X-Forwarded-Encrypted: i=1; AL+hErH/cSF9IqMyKpmRRmonxSo8thlW3SEueLudxj229R3kTXe14+Ey5sQtsK7Z4L7JP8F30sIxBWrmslCxSEzp2STA6HU=@vger.kernel.org
X-Gm-Message-State: APuU4Z+T8jaP1HUbbKasOvjk90Khcx/odE2znbl2IexdEPKtz+OoS1ss
	wHShxpH16B47ujNHUYla+M/UQTC9KL6a/pGc+ZOdffOJ7KzpPlvphc52bsu0Oyj9ONNBDnHw2HJ
	kLqQjLUSK/+NkLWjf8Fljl3hcyK6Zme8=
X-Gm-Gg: AYBFou3PSoWZPDG9+wpSu+oYo+f1bcnD2CHlJJ1wqk4AifmysaThtemwNSKJKoIhJgt
	mRiGWkplVViQgwAGEuCbO3h/YNCV63R+7Bnl8wlLgGO+6GVzHEY8wnLiq12NQfWNe1COCfFC25V
	2+usCP9CTuJ4oq34FMIa764oDiBG+ZwGvfbiFCRajIlOCnVi5No6ffcMarvIQUde4ovkV2glREd
	il8BM8pL9ryAf3k79rmPLeAGYEGo6bDcv3ILAe9BuaxfSDcWGYcHLj/IzzzdTuuTiaXYD2C6bSY
	OMqaL19VS/tqhdO+k7G7cgCOz/QyAPuMPiLeMLJw3p3pM5nbWXG6u80k5DQQv7vQtRi3s5Gbegx
	tzXbJXrvjpcmIzpr+rtuU8bATF1o9UFzRTpGJ6Zurf554gOW1F4CVslAD9C0aBDrg3H2phA==
X-Received: by 2002:a17:907:6d11:b0:c26:2a2:b91d with SMTP id
 a640c23a62f3a-c509612a23fmr694079266b.6.1794754848470; Sun, 15 Nov 2026
 07:00:48 -0800 (PST)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261115-work-ovl-d_real-v1-0-ca155efbcb2e@kernel.org> <20261115-work-ovl-d_real-v1-2-ca155efbcb2e@kernel.org>
In-Reply-To: <20261115-work-ovl-d_real-v1-2-ca155efbcb2e@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 15 Nov 2026 16:00:36 +0100
X-Gm-Features: AclHuK_wHYShIpzO3KRe2QttGftKj9EtJqTGjYXExDCpgXdtVHvMQ3jGuPVE7gY
Message-ID: <CAOQ4uxjoHbevvu8auB4m8AVcY9H6uHdDAP6mfi9OOMh+3775xA@mail.gmail.com>
Subject: Re: [PATCH 02/13] fs: add d_real_data_inode() and d_real_metadata_inode()
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Chris Down <chris@chrisdown.name>, 
	Miklos Szeredi <mszeredi@redhat.com>, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 15, 2026 at 3:02=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> Currently, d_real() can't fail. When overlayfs fails to look up the data
> of a metacopy file in a data-only layer it hands back the overlayfs
> dentry and callers silently work with the overlayfs inode. That's more
> problematic than current callers realize.
>
> For trace_uprobe and bpf's uprobe_multi it means uprobe_register() fails
> with an -EIO that has nothing to do with the actual problem. For IMA it
> means the stacked change detection is skipped and for IPE the file is
> evaluated against an inode that has none of the properties of the real
> file.
>
> Teach d_real() to fail and teach all callers to handle errors. This adds
> two helpers for the callers to switch over to:
>
> - d_real_data_inode() returns the inode hosting the data or an ERR_PTR()
>   if that can't be resolved.
>
> - d_real_metadata_inode() returns the inode hosting the metadata. It
>   never has to look anything up and so never fails (but no promises for
>   the future).

About those promises...

>
> d_real() can't fail yet so this is a pure preparation. d_real_inode()
> stays around until all callers are converted.
>
> No functional changes.
>
> Suggested-by: Amir Goldstein <amir73il@gmail.com>
> Link: https://lore.kernel.org/all/CAOQ4uxhGxpBtMZ5kfuzR1tQAewiecoX7UjXQRo=
91QjJHH9T_Yw@mail.gmail.com
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  include/linux/dcache.h | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
>
> diff --git a/include/linux/dcache.h b/include/linux/dcache.h
> index 84b0cfe4ed0e7..674bc50b81827 100644
> --- a/include/linux/dcache.h
> +++ b/include/linux/dcache.h
> @@ -3,6 +3,7 @@
>  #define __LINUX_DCACHE_H
>
>  #include <linux/atomic.h>
> +#include <linux/err.h>
>  #include <linux/list.h>
>  #include <linux/math.h>
>  #include <linux/rculist.h>
> @@ -660,6 +661,49 @@ static inline struct inode *d_real_inode(const struc=
t dentry *dentry)
>         return d_inode(d_real((struct dentry *) dentry, D_REAL_DATA));
>  }
>
> +/**
> + * d_real_data_inode - Return the real inode hosting the data
> + * @dentry: The dentry to query
> + *
> + * If @dentry is a regular file on a union/overlay, then return the
> + * underlying, real inode that hosts its data. Otherwise return d_inode(=
).
> + *
> + * The union/overlay may have to look up the data first. This can sleep =
and it
> + * can fail, e.g., because the data is missing or because its verity dig=
est
> + * doesn't match.
> + *
> + * Return: The real inode hosting the data of @dentry, or an ERR_PTR() i=
f it
> + * can't be resolved.
> + */
> +static inline struct inode *d_real_data_inode(const struct dentry *dentr=
y)
> +{
> +       struct dentry *real;
> +
> +       /* This usage of d_real() results in const dentry */
> +       real =3D d_real((struct dentry *)dentry, D_REAL_DATA);
> +       if (IS_ERR(real))
> +               return ERR_CAST(real);
> +       return d_inode(real);
> +}
> +
> +/**
> + * d_real_metadata_inode - Return the real inode hosting the metadata
> + * @dentry: The dentry to query
> + *
> + * If @dentry is a regular file on a union/overlay, then return the
> + * underlying, real inode that hosts its metadata. Otherwise return d_in=
ode().
> + *
> + * Unlike d_real_data_inode() this never has to look anything up and so =
it
> + * never fails.
> + *
> + * Return: The real inode hosting the metadata of @dentry.
> + */
> +static inline struct inode *d_real_metadata_inode(const struct dentry *d=
entry)
> +{
> +       /* This usage of d_real() results in const dentry */
> +       return d_inode(d_real((struct dentry *)dentry, D_REAL_METADATA));
> +}
> +

Wondering out loud - since you needed to change IMA anyway and need
IMA patches reviews, do you think it is hard to also gracefully deal with e=
rrors
from d_real_metadata_inode() and not have to promise that it never fails?

This question is not intended to block your patches.
If there is a reason we should keep this promise for now,
I have no problem with it, so

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Thanks,
Amir.
