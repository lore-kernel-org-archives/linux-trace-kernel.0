Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A50A3AEF24
	for <linux-trace-kernel@vger.kernel.org>; Thu, 10 Sep 2026 05:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789018256; cv=pass; b=UaXUFdgb9LLEBm/+s4fnWMKWBYj57ks4XUVFDH2H6/tjdVixdE+fr4apFY1Pnc9M33vLVr4gFV22pCV6w5e0WTcJIM3GkIMMKYuAS767cToD109QCycA1KipuvAibw2SuYUugPMdN4vxr0QIM4lCa8GWitB71UCdqw2aiDwgvvE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789018256; c=relaxed/simple;
	bh=dE4Bhn4aMAfw7L0+vfoJlYFnh18vk+oBsGbKmTG1fRk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E/4gnfz14+jo0WuBLHxIOiLextnSV0Zg1nZrqGtd2Bh5Z8ZN+w48vhCPLFl5pZHIYdvVFINghyG0hI4ggoU9bRCNG6E4VsRv/eIGx7IH80BJhVlIJjbHFuSze/wEpEjtPoblaDUrHufx1ZAxwufe6ZbQ7lri7Jyppy7cI3EZMXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B3J2IKjR; arc=pass smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B3J2IKjR"
Received: by mail-yx2-f12.google.com with SMTP id 956f58d0204a3-66e4ab19125so943465d50.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 09 Sep 2026 22:30:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789018254; cv=none;
        d=google.com; s=arc-20260327;
        b=bLrhcrMwmS90ZEy1N+6Q8JFln0RlhyfNe5SYBMacK2NzPAQni2C+UoKBpT6hHLALeP
         8EuY/E3Q/SLP6GY9fIef00mJfQfReCZWy2pjgnvHGiRwWP4rqR2Cq4YjSIy5G185OjNe
         bkLqlMLan0KNb0XA3Kc3cpkvjuxP65DZDAjpdOESf3seYL6rZPsIoGMONMB6tAdefpKx
         f7cqz9U0Yt4ZCHEBaj96InXzEyRAx/Hqs2OJKu/E2Sz+J2AlpKcv4XSO7RDk7ZXJy4Ci
         m+9lF+2O1/8wLqCIXcrysFYYDn8bOKTPeixmw2zl1Oz3Q8m6Ps6bWx1IaXShSLzOSFp4
         AG/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Z8BnU44OQF4n8pesOxTTujOGr5i8FN4Osn0bed3yU4M=;
        fh=zHjupNMH9SyrTyz7mJ+gJ8wZaQtl/Mn/2/Sn4L+zPDU=;
        b=HH/91A++TiflsXboDLFFBmu4God0bsoNdk9gT18LdBRckzWvdQMZxojoylrt+lpN62
         icYmc5Fy18NJNExUTcnU+0YQpoStqtzwtV8oP+C2N/vnVgrRj+PZ0+k48K2u0sCJ209a
         Lfzq1E+1Oeml/q0DauQ8urWSSlbewIHuMtNo3vlTQmY8QR7qrYE+Opb0Tk2wdtI3Ukst
         ids3da/BL2ko4dMETY/ET5XIuZwyJquZF2+hPAzj5sVD42jxZfjk1rH3+lEqjlv/5hOE
         GojEwg6fNhXuRzoDq84mR4Ug3xaGKu/SDr7fiiIv+MpbcFx+hQFRAO7VQ64D49Tb4/ey
         aOUw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789018254; x=1789623054; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Z8BnU44OQF4n8pesOxTTujOGr5i8FN4Osn0bed3yU4M=;
        b=B3J2IKjRPkI1SX4HOwfsm580EkJkKtZ5UE7i4Xo+PKAzNTyp4dcD8Kuc5g45xyX7QK
         n+scN/ETEvSiYzGUKdavuC/A/PVh6FwVM0bBnlpRF4DGwS3gVNBj+h3TwJkuhZZ3nw9L
         d5j80atz+bdmKVpMakc1IM9ErrwtfttqTSsrZWwMv9c/KkY6PTNf2HuFKeSy7ptHIbhq
         RmjcS4/55YRBLNzXLIpZi0qFVzO3uw1gndpRJPzqTJDrrAngVRk084EkSEAfovaxzxK6
         kPr/QZ1MocME4PBTB+nWOv+Wq79AWaItnMtd3jU4ou2vIs53d5pNjLDl0YVz0d+K+DK3
         8thQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789018254; x=1789623054;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z8BnU44OQF4n8pesOxTTujOGr5i8FN4Osn0bed3yU4M=;
        b=azc4w05eheR0++qOy+uyItmvLRZXsPmt7Z5zhn7//lxO54SHhGfhC8MQx4tsqf5GoE
         X0Jjnoe6m4oOQEjXSvgg8UPdiJjjaTwi0tGrbdex8fzpUWthPkC1gJ20koPpkoCcI4pA
         +zXOX1HaWbB/oX1blVgy+lGIyQVIFyaiUZGX5w4aQN51ZVZxOpRNC/YJdf5qm5gHhFq5
         vkuOpeBPmFA3EfvB5CWCxJOvF0KQRylZkOyZk+bM4faCvIKFcEz9xxWg8l8c589LL9Iz
         FnFzibOWQKxwZ41kWd9NA/Yg6kGRDmLoNqJ15/0pKnGbb+3ldjv5QmbB/6B80xAocm9b
         RGwA==
X-Forwarded-Encrypted: i=1; AKwUvBwHlB1tTQAVIn6USLseJRTR8Ryr1xv4O+UJbwJhTxuxHlNL79FxUpm2cMvNevk2kQgHOYwURyUPiSmQ+XJmPGgab1E=@vger.kernel.org
X-Gm-Message-State: AFuF++nKFOj0/nPfpNOGZk3zQuqu511cD3Dyn5JXlk7X4VYtDr75PILH
	GLLf2ncrt6r2rGQjZMJ0KmcSIht4h+h8yrWmzZXc+ZvhBdho8GiMte45TV1lXkvv16shmzSES/v
	nkjCAHd0EvQ/xjAhPjk5Kx7XLYSEiQ5A=
X-Gm-Gg: AYBFou3mrOzDNGfGtLVfC7Yi5GpMvyprv1K1gPvnVxmrlW28Vxe2hbnNXW0/WcAbQca
	rscRjkWWAPIOT9wGwcs1E/mtOrb7dzP1d9ifibqQQKCL1cyzoCWTcgC/SQMzhMLrq5pLtLiXJfF
	V7W1dnFz/6i8H+55ggph9gYaqgqVsk1hiamEuAvXZkfGZcdOOj+zfifzPG9KLjlE2ZJwCdGggTG
	WfYjacm312KtVDtdrxuL7XTF/iyYrTKGxOqXvTfqQNJgYc/G2+1AU1zRtq28rp3AqYUTgiARmhe
	qHOwWbGkuq6zfDydyxWcX7RfrebZxyxtnmPL3TIAsFTTf8Sg+2zj
X-Received: by 2002:a05:690e:408e:b0:671:1aab:4356 with SMTP id
 956f58d0204a3-6711aab4a50mr95160d50.0.1789018249516; Wed, 09 Sep 2026
 22:30:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <178896921555.177508.434402948295885560.stgit@devnote2> <178896924262.177508.71609739247457811.stgit@devnote2>
In-Reply-To: <178896924262.177508.71609739247457811.stgit@devnote2>
From: Sang-Heon Jeon <ekffu200098@gmail.com>
Date: Thu, 10 Sep 2026 14:30:37 +0900
X-Gm-Features: AcwNN1UJy0r07ZVVV7zgcFyQPB2Z0ZjgWQo3JaJAvHZUC2RTRjHxqi3cr250T0k
Message-ID: <CABFDxMGkRUt+_ymOODpMNR0KqkyP60UTgy_i_MaoU4v76d=rJg@mail.gmail.com>
Subject: Re: [PATCH 3/3] bootconfig: Skip internal tree sanity checks in kernel
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2026 at 12:54=E2=80=AFAM Masami Hiramatsu (Google)
<mhiramat@kernel.org> wrote:
>
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>
> In xbc_verify_tree(), the loop iterating through all nodes to check that
> xbc_nodes[i].next < xbc_node_num and xbc_nodes[i].child < xbc_node_num
> is a defensive sanity check against implementation regressions (such
> an out-of-bounds index cannot be produced by malformed input).
>
> Running this check in the kernel adds unnecessary boot-time overhead.
> Split this check out into xbc_sanity_check_tree() for userspace, so
> that it continues to run during userspace bootconfig validation (e.g.
> when applying or testing bootconfig with tools/bootconfig), but is
> omitted in the kernel to speed up initialization.
>
> Reported-by: Sang-Heon Jeon <ekffu200098@gmail.com>
> Closes: https://lore.kernel.org/all/20260905141637.1547429-1-ekffu200098@=
gmail.com/
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  lib/bootconfig.c |   38 ++++++++++++++++++++++++++------------
>  1 file changed, 26 insertions(+), 12 deletions(-)
>
> diff --git a/lib/bootconfig.c b/lib/bootconfig.c
> index 0ec2874db9c7..884f186b1989 100644
> --- a/lib/bootconfig.c
> +++ b/lib/bootconfig.c
> @@ -1000,9 +1000,30 @@ static int __init xbc_close_brace(char **k, char *=
n)
>         return __xbc_close_brace(n - 1);
>  }
>
> +#ifndef __KERNEL__
> +/* Sanity check for regression: node indices must be within bounds */
> +static int __init xbc_sanity_check_tree(void)
> +{
> +       int i;
> +
> +       for (i =3D 0; i < xbc_node_num; i++) {
> +               if (xbc_nodes[i].next >=3D xbc_node_num) {
> +                       return xbc_parse_error("No closing brace",
> +                               xbc_node_get_data(xbc_nodes + i));
> +               }
> +               if (xbc_nodes[i].child >=3D xbc_node_num) {
> +                       return xbc_parse_error("Broken child node",
> +                               xbc_node_get_data(xbc_nodes + i));
> +               }
> +       }
> +
> +       return 0;
> +}
> +#endif
> +
>  static int __init xbc_verify_tree(void)
>  {
> -       int i, depth;
> +       int depth;
>         size_t len, wlen;
>         struct xbc_node *n, *m;
>
> @@ -1019,17 +1040,6 @@ static int __init xbc_verify_tree(void)
>                 return -ENOENT;
>         }
>
> -       for (i =3D 0; i < xbc_node_num; i++) {
> -               if (xbc_nodes[i].next >=3D xbc_node_num) {
> -                       return xbc_parse_error("No closing brace",
> -                               xbc_node_get_data(xbc_nodes + i));
> -               }
> -               if (xbc_nodes[i].child >=3D xbc_node_num) {
> -                       return xbc_parse_error("Broken child node",
> -                               xbc_node_get_data(xbc_nodes + i));
> -               }
> -       }
> -
>         /* Key tree limitation check */
>         n =3D &xbc_nodes[0];
>         depth =3D 1;
> @@ -1199,6 +1209,10 @@ int __init xbc_init(const char *data, size_t size,=
 const char **emsg, int *epos)
>         ret =3D xbc_parse_tree();
>         if (!ret)
>                 ret =3D xbc_verify_tree();
> +#ifndef __KERNEL__
> +       if (!ret)
> +               ret =3D xbc_sanity_check_tree();
> +#endif
>
>         if (ret < 0) {
>                 if (epos)
>

Thanks for doing this.

Reviewed-by: Sang-Heon Jeon <ekffu200098@gmail.com>
