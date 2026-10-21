Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.221.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792605094;
	b=M8rV0ITShqQjywTb3uN1m2QCDtwkkOWf2dr9zcAA+wQKLzfPtbB3V3vKvDpbdiOJZa7R
	 ttU+AGfRCZdWT+SqejTYIVA27FKepwjLJH4Go3Bqtb+R1D55z/k16X4ySdEOSBJR/1F4h
	 8eRlX8TuSdIk+LS75SeGu5oseoxnaIgPHoqcj+u5cVaSSzp2NWJB4+plW5wdYxoZvKhhP
	 XYhQ5BbIlJDV6I3gWGDKGS7aVmGQToIdwfd6XiSZIsVMJQbIkzBxKZRhoVfM51qKTRceS
	 Mhf7NME1sWWmWwhYAP/Qu104Q84lIr/1lGeOBhgLQxEn+696/V1yLMP94WwB7c0uyeA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792605094;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=D89ifvopPkh6UIf11JinhlKyeZs6JGLXLYQheO+1SnU=;
	b=0wmdsslaINOCrcheAPwVEr1Q4u3dBmzcFjcKyo+6gAYAi/3Ix+a7AzPNA8sCRFxYCJT8
	 iEaIo4yusFJ2/NZL9btCb+odmwks7oRcNlBTns4UBIhZH0Ya0qc7gC6dHGX2+L9uBjTtm
	 wwD1O0x1816fC/q6MU9FN6E0RLy83xDMATl3ZnNTvr5PXAob5qq0QNDs9PqmVQoxx9p6q
	 LEp00t8g/vQMZ0PzkjzuPrNMiqqG9mYyyipDjcS1SqvPAP6snxWEj/zWGPH8DKq6oqtXB
	 rH8uh5/AcHPdRvoWv52p0aIRfY64lRZpT1McjuG6Uppzv/vFu59XWNJS6fN2DRZMwVg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dtuZsezP;
	arc=fail smtp.remote-ip=209.85.221.170
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D48606A319
	for <linux-trace-kernel@vger.kernel.org>; Wed, 21 Oct 2026 17:51:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04D48606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dtuZsezP
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5ead4026fe6so396549e0c.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 21 Oct 2026 10:51:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792605093; cv=none;
        d=google.com; s=arc-20260327;
        b=Fy17EtEXdTMfFkVAqtbV1cS2w+M7aiMbGNgxsjYabI/Gn6spXHGYyA0yLGADqknSz2
         3eW+sa1BqAPLC2wPcczJjZZIW6n9+TBX+K24eDxo1ae91K5g6IN5Hx6k4C8zRoUi5uy4
         VZljwlWBs/X71g+qA8JdRrHjNWGHNmx2R2cRRoNswyqbQUW5wcXsPuw9owDWM9ysfSzk
         kuE+day6QsL8QfT1ZvBRzZMLQQCGRdb/QsHijxInAajvBSV9MC1naLJLfI/tmMhUxNsr
         1VFh+wOJtKRhMa8bAnlRiXseWW3LGqy89ZQRRsBYi2n6nABDlvHY6X6qiQlOZ6AlqQKn
         tJ7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=D89ifvopPkh6UIf11JinhlKyeZs6JGLXLYQheO+1SnU=;
        fh=WLqikZ3xR9vD3X1kZr2mrJoXSrvw7t4CNASsSXaU7wU=;
        b=nwnBPDIxRqiv+8bdOTrmG+cHx6NYmCfpuz60rePfy2cACWAeYKB30BZKV9B26XzZIg
         zFJDe0T2TtGn3CFjznwJegYoQE2HzYm8s05aV+SR8SlvAo4nbux3TjFvuwDZQ8MI9w87
         ow8o0s5B2x+ZUx16UkV6Idp+9rRFqhxf87ZnsgtbzoihVXpJNz+MYQP2I0MmcanRRqBv
         f6uuAVEOAQ9Y0iL3tqZOvyvDfJFys4iBqds/wYwO1FGmcKTU06JXjT6A1msuGO0I8zAs
         XAmgDN5TI59RY9qfYsM2q4uHVfv1RcWXKRgoTKpj4o82xSi7XYiQIVcXdnfRulAj3sAy
         hYEQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792605093; x=1793209893; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=D89ifvopPkh6UIf11JinhlKyeZs6JGLXLYQheO+1SnU=;
        b=dtuZsezP1THNiKON+Z+Lg0Kal6rVkc4EKw3GGI3IDivGz7UlmjuQuUEo53rDGwkJpI
         08zUoNY/rsg1fUaCVa/ilQ/tgbncGgTi3ydeLPT3Kh7jXOmm/vYhtyq4Uy1faR3dcaUb
         RMDbgkQVMIgvNKf2sAwME/RNI6G8M7ELa2IN61tVcYe7GxyFGATrG3n8i7CIpOCEwFel
         LCJ1cdZvQ+TTwbpVmG4REU8N/AD/w8Ql4Go2sZEjaBHO8Kmom0KfSE81WSrEMFUMWdsM
         ZNs5UANGWZ/GJXvqDzO8Hx3am8Buf4/K4on2OPn7kA2XDAARwKXpCgWjDCzpLByaHxNb
         YhbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792605093; x=1793209893;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D89ifvopPkh6UIf11JinhlKyeZs6JGLXLYQheO+1SnU=;
        b=dODDimedR2e3ReDIH040jH6d+6uOb66rJp/dHb83/iJsJH8eR7odKE+yOuovxPin2H
         s44dMqZh/YEJ5SgSR/dZSIGjIbH79OXXdqrQ75hhxsdUYGa8pzIRjCyaMdOvPF3nTFNR
         eZe7rr2xAi9aNN3IGzosePplKlGGSt+j2nKfYsx/xErjqwf5mAkX+F4HPL7IEmlsVQv7
         T4ZS9P0GRmpvRVxzEKQOFa6Qyw/gL0ZcTE+yPgUBMNdHcJoYr7qBpF5bsjVsk16W0o1P
         QfnRFnutBaMvZEOJtWdnTvowOp3+wX78aqHqrzNTD+xO/326mgn4Vk8tCWC2Y6X/WhCU
         ZMvg==
X-Forwarded-Encrypted: i=1; AKwUvBypfF05kVyb9ChExknuQob7mFiEQelqKUjtRbx88o5OmxY6EQsGqO1rTu56LgTdlsn/qI5XY9juD2jftDqmWXaesI0=@vger.kernel.org
X-Gm-Message-State: AFq9FYLHrOILDAO8UEMDAb5rYH0Z8S75BPMmBCvEc53bVvzKGFuaH2sP
	EmaeAhqG/xXwWBCwCpQnRoUcYGsbX52jlUYvBRfnGV6rpcgGK/gz3DcVKg42fO8QOEg8jQN2wf7
	eJ9JpBfXCceIVUMefoImy86AcGVx64RQ=
X-Gm-Gg: AYBFou1YbkJGJktTJ9XTHAG9hvMllhCUNM7N6ijEVAlVZATepddUrI8ugnEKMNr7a9G
	NhqtwMNCaMHT/R97ld22NidTOo4IgQldq3ZZXzZhZc5iDhJVh0lHhmiewvCL+1wViNpaDLjQuhR
	cZPKGi0WoEGo4xG3Cyu7VNwOm/SAp7U+wKxergeeSsoVom6ggWympqUA2dK8Ao3CQ3ooh35Vk9e
	a0ssL7L4bnTX3/Dcomt6cMyImOrtUnGPJeZ+G1Yu4oat4PAPaLOBrL72Ev42GWoy/00iHF0soQt
	w4WgJngWGuZDbhGLhtknAcleKAoH5ICGYvfJN9J5i40ZoSPW6ZCCet3puX54RhjwbP2V9zMf7hp
	mmakbp9vB7pUR25tAmP/2D4QlU5W+INHeT2SvkjC6BvDhidFFPG9U29I94+D5N3mZKu/2HDkRQp
	q85Oe728VPUWAfCqH0gJJKvoQtsjUw2qGCSbprIqXRitwbIYRdlQxI3DL0tv/AWzcDtEgZ2rhzV
	D090mOKaVvyu7vTbLkCgaExH/jHJT5SLT1ETuDOOZrOVaphOiA8B4r+9Xft
X-Received: by 2002:a05:6122:1b8f:b0:5ea:91d2:32f8 with SMTP id
 71dfb90a1353d-5eaebdd09f9mr1192005e0c.8.1792605092656; Wed, 21 Oct 2026
 10:51:32 -0700 (PDT)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019120332.553567-1-edumucelli@gmail.com> <undine-1792592451008617538-5620f2dc569b3038@undined.local>
In-Reply-To: <undine-1792592451008617538-5620f2dc569b3038@undined.local>
From: Eduardo Mucelli <edumucelli@gmail.com>
Date: Wed, 21 Oct 2026 19:50:56 +0200
X-Gm-Features: AclHuK_wu1PEBoMZwDUUmdaaxIzeIU5q0yaGhzPbnfzamDq0zX132z4TWUZdnWw
Message-ID: <CAK0NWSMQasDdxYiWSexJk1sdxLfnLeDW_Us76go2fPdx_c8Gdg@mail.gmail.com>
Subject: Re: [PATCH] tools/bootconfig: Quote CPU masks containing
 comma-separated words
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: rostedt@goodmis.org, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Masami!


On Wed, Oct 21, 2026 at 4:20=E2=80=AFPM Masami Hiramatsu <mhiramat@kernel.o=
rg> wrote:
>
> On Mon, 19 Oct 2026 14:03:32 +0200, Eduardo Mucelli Rezende Oliveira <edu=
mucelli@gmail.com> wrote:
> > ftrace2bconf.sh writes the CPU mask without quotes. For a mask selectin=
g
> > CPUs 0 and 32, the output is:
> >
> >   ftrace.cpumask =3D 00000001,00000001
> >
> > Bootconfig reads the two comma-separated words as separate array values=
.
> > When bconf2ftrace.sh applies the saved settings, it writes those values
> > on separate lines instead of restoring the original CPU mask.
> >
> > Quote the mask so the commas remain part of a single value.
> >
>
> Ah good catch! OK, let me pick it.
>
> Thank you!
>
> > Fixes: 2b86062a34a8 ("tools/bootconfig: Add a script to generates bootc=
onfig from ftrace")
> > Signed-off-by: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
> > ---
> > This is my first kernel contribution, so I'd appreciate any feedback.
> >
> > Tested with the exporter, bootconfig parser and generated replay comman=
ds
> > using tracefs fixtures for 00000001,00000001, 0f,ffffffff and 1.
> > The masks containing commas fail before the fix and pass afterwards;
> > the single-word mask passes in both cases.
> >
> >  tools/bootconfig/scripts/ftrace2bconf.sh | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> >
> > base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
> >
> > diff --git a/tools/bootconfig/scripts/ftrace2bconf.sh b/tools/bootconfi=
g/scripts/ftrace2bconf.sh
> > index 8eed445c2..f8f288f90 100755
> > --- a/tools/bootconfig/scripts/ftrace2bconf.sh
> > +++ b/tools/bootconfig/scripts/ftrace2bconf.sh
> > @@ -238,7 +238,7 @@ instance_options() { # [instance-name]
> >       fi
> >       val=3D`cat $INSTANCE/tracing_cpumask`
> >       if [ `echo $val | sed -e s/f//g`x !=3D x ]; then
> > -             emit_kv $PREFIX.cpumask =3D $val
> > +             emit_kv $PREFIX.cpumask =3D "\"$val\""
> >       fi
> >       val=3D`cat $INSTANCE/tracing_on`
> >       if [ "$val" =3D "0" ]; then
> >
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>



--=20
Eduardo Mucelli R. Oliveira -- http://eduar.do
