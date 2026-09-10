Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DDA1F8691
	for <linux-trace-kernel@vger.kernel.org>; Thu, 10 Sep 2026 05:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789018216; cv=pass; b=dpv1t2qkG7sO8K51WEgk1j7tuTRyXvvuD7ja9KIMB+n7huBwXNOONPU1a7HWvaXlSzPTRhtxwEODVIGiFxIXCQ1qtNppSz6+U9yQ+HD8op5cMpd/n7kRbMYlqpbUftkdHmYY7mGkFa1S6RyzEL8MYsVJGGR8yVXIoc85CqQ8T0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789018216; c=relaxed/simple;
	bh=6+r/l5FWByQ+n4faO2Eo/5Uc3+EXctJlMmoaEasmkFQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iveJpf9CvFOAcG34Uy9KNTohZda9opdN2svSFjXbpiNooHY0UrINAJj6+yRZVhCb6OGQHyYBZe1kCiqMOwNlqZm/otGiByyoBx5cJ2Z4RF8OPod7bCiu6zYDIlW37AVV4xpKAoOQAtJ3xZrgQnZp1lJ/psBI6ON8UzLzeLbdPYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S3BEL4jM; arc=pass smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S3BEL4jM"
Received: by mail-yx2-f12.google.com with SMTP id 956f58d0204a3-66e4ab2029eso1303447d50.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 09 Sep 2026 22:30:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789018213; cv=none;
        d=google.com; s=arc-20260327;
        b=jPk9nidwR0kn5+pwLOGnhiuDHcjmqPddqKQ8m4BVBxFGPaOij1tq6UCK9HXmCDdH4/
         d0KWQkszraPO5qfFTcTMzItecQ6w6CwVBm2Hohj3MhgHOeb29IhsKP5a85dKO4Qx5yL0
         6nv3gHpZAyJMcqZCa15ivphDo4i1rsx//LkzokiW5grdpt68jSJC8j7kBNi7/2bS21FN
         zfhLG+c7HWbjh2yQn2bBb5/amFRsP2FLwc5gGkm+5mxPOE5+DhIwGJBdYs4xSWWWLt+O
         hNAu0BuF/RaLDq2E1piw1SJys3ltXN6/iVP+IsZmJU1IOQdK7ueCj4L44WHL7AIow1kn
         /CzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SL/Ub/01ZpDBq9q8t75/9PevaRdy7NryO7lt0HzkAFI=;
        fh=5QC9ghvsKLQAtsiYJeyU6BOq7Jf2RH9YpVBtFkjzXsE=;
        b=Zh0W3e6/5QRRotML2EPTH6R91rmVnLljFeAom6dcAwRwGrkKyLBlpvNcDkLtM+PF+N
         rXYh5r6zhRwVsxZTmwoK+4vIHjaySvV6v/LC03S5FFam+EkZBfW+35AIqzuDdInfKD56
         VBF81Ezo9iSokG4s/gr0A2I1nTQ0sm3xRlM+j37CzDODNd2v+BrEyELeDuWk9dm+lhsw
         YRIX0VwDJeYBVXM64LK7wNL/cllF0SCwFEmvmwVKcm41gXIAcMhSgXz84MIpcCKa3RVi
         XBUNTz9OZ5wZudo63XkWScCoBixr/cuipNQ3LZD7i0sm1OR4IWDBs8LBdOxCuHnfflAy
         dqrA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789018213; x=1789623013; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SL/Ub/01ZpDBq9q8t75/9PevaRdy7NryO7lt0HzkAFI=;
        b=S3BEL4jMxRVfc3N14cG0KRRp2oUITRHAeU7gW9Au2Q7USemm5LzUdTWkL9+FvflH22
         QCj2CvtFDrSbWaabsWAsaM6Yza09JqoQGYzH+QXwQWnb21XsM9u1PyFxydl0AuIxExtU
         gaQ81zbfuJbgfSV3i6X9XU3mxZzIU5RfKu9jQS3QS7TgGTJDl6Q19CpvNgQP3POVQAcV
         1WZXjk9x27KTBDwu7tV+MscZLmnY0I/kmrnyif8fp9/a4e3mayis0eqfqKPCsxhrZtKq
         klzoxZ7exgiNaEaUSoGal2QDW2KL+fpxayEKAxzmQR8LKuql2PLwdnSqLUaLtCkBKkq7
         ixVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789018213; x=1789623013;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SL/Ub/01ZpDBq9q8t75/9PevaRdy7NryO7lt0HzkAFI=;
        b=KxUMMHZrg3HWM/MRL+4PFeJVTe1ZwOSeGJXlGGT6TYhDd+58TYSuBxSSVpb3IO+JGz
         ya4+Ys3UbGjzZv1DV3yr+7S7Q86+vFhrFc+U/n6t6LkviWqoungIz4LAcqxgDpqcGU21
         yhVWJbhyjOf24bYznnSo3Yhf++7ALIrEZ/baIUwhb6bXp2E2Ouc5Na03VR0zXF5ISkyT
         iiB2A3KcpVR8e4piecibVd2xkIUQw+MtK1uHZTeOcaT5zzQuqwerSHjaEWUuy2ci3nw2
         YQxfK5g93pqOOt/gkUcsy3T0i12MYjYnLNf6n9WFwvTV04kSWzvKgOR3RgWT+2sPH1mM
         tlNw==
X-Forwarded-Encrypted: i=1; AKwUvBxd3ddP+wClYijzTkbkAUolOCxiH1kLj4oxwUpKIwiGyyWSykCodUsgVseE6XY/lMr6YllQZsKwBQRmplci/F9nSCI=@vger.kernel.org
X-Gm-Message-State: AFuF++nQS2UIeFxtF0qY6Eie4Kb/7oUOSN5USDHb7oGWv9vG4SlE3tdp
	JJdnt2O2IuB5OTHUDj1ZS/0kfHEW+ZoTRZZKTAbkXguimfju71elNoS2vbwkR8zPJOgzcNEFGKO
	77VLW6jScbQ6Yn8ZmpEIbfghrIJ2KMYI=
X-Gm-Gg: AYBFou12rXMDbjrekH7VqAv2nJ5bZbktMI/OdDbH41LB22oYIPR7IEYwK3/eOiEoTUo
	DLKZszZ7B3VcEwu48QqptDvEqgIZqI0Pz2/wtWwZpCiERMXiJ7kUDPSfug/UXuCUuMi3SJWMH9p
	xTcgAs3zRAAMBaSXcNTujb26biA94t+eMsViYhjY6fTwQh3inwHtDpgTBe7GZx2XoSYnP9L8OkK
	TeJA6EuuruKO7EJ++FydEebH3AyHW1kbdbsT+1FlTzB8Gi91d5gdQ0qRUIIFp3noHrL7FewN3mW
	9of749nCrwqlgGZ3iN9qFAPONfrsF689Er8UQvDAkD+b6ddc2rAr
X-Received: by 2002:a05:690e:13c7:b0:671:1ac1:d68f with SMTP id
 956f58d0204a3-6711ac1d6d2mr41659d50.60.1789018213253; Wed, 09 Sep 2026
 22:30:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <178896921555.177508.434402948295885560.stgit@devnote2> <178896923375.177508.14682854552827605824.stgit@devnote2>
In-Reply-To: <178896923375.177508.14682854552827605824.stgit@devnote2>
From: Sang-Heon Jeon <ekffu200098@gmail.com>
Date: Thu, 10 Sep 2026 14:30:02 +0900
X-Gm-Features: AcwNN1W39DebY4-NKSzrC47yPXJPl1Spc-xzJ07-z_uT4CDOuu2q6Jgrby-ybv8
Message-ID: <CABFDxMFbHoDrGKr7039XL3BwHOjZC+4Qt2YQNeGbyuAitQPGDg@mail.gmail.com>
Subject: Re: [PATCH 2/3] tools/bootconfig: Consolidate xbc_init() to error
 message wrapper
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2026 at 12:53=E2=80=AFAM Masami Hiramatsu (Google)
<mhiramat@kernel.org> wrote:
>
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>
> Use init_xbc_with_error() for all bootconfig initialization in the
> bootconfig tool instead of showing errors in different way.
>
> This simplifies the code logic and make it easy to maintain.
>
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  tools/bootconfig/main.c |  108 ++++++++++++++++++++++-------------------=
------
>  1 file changed, 51 insertions(+), 57 deletions(-)
>
> diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
> index 6035404733c3..7117aa9b2a83 100644
> --- a/tools/bootconfig/main.c
> +++ b/tools/bootconfig/main.c
> @@ -21,6 +21,47 @@
>  #define BOOTCONFIG_FOOTER_SIZE \
>         (sizeof(uint32_t) * 2 + BOOTCONFIG_MAGIC_LEN)
>
> +static void show_xbc_error(const char *data, const char *msg, int pos)
> +{
> +       int lin =3D 1, col, i;
> +
> +       if (pos < 0) {
> +               pr_err("Error: %s.\n", msg);
> +               return;
> +       }
> +
> +       /* Note that pos starts from 0 but lin and col should start from =
1. */
> +       col =3D pos + 1;
> +       for (i =3D 0; i < pos; i++) {
> +               if (data[i] =3D=3D '\n') {
> +                       lin++;
> +                       col =3D pos - i;
> +               }
> +       }
> +       pr_err("Parse Error: %s at %d:%d\n", msg, lin, col);
> +
> +}
> +
> +static int init_xbc_with_error(char *buf, int len)
> +{
> +       char *copy =3D malloc(len);
> +       const char *msg;
> +       int ret, pos;
> +
> +       if (!copy)
> +               return -ENOMEM;
> +
> +       memcpy(copy, buf, len);

Can we remove this? xbc_init() already copies buf and does not change
it, so show_xbc_error() can use buf directly.


> +       /* We do not terminate the copy with \0 for sanity checking */
> +
> +       ret =3D xbc_init(buf, len, &msg, &pos);
> +       if (ret < 0)
> +               show_xbc_error(copy, msg, pos);
> +       free(copy);
> +
> +       return ret;
> +}
> +
>  static int xbc_show_value(struct xbc_node *node, bool semicolon)
>  {
>         const char *val, *eol;
> @@ -187,7 +228,6 @@ static int load_xbc_from_initrd(int fd, char **buf)
>         int ret;
>         uint32_t size =3D 0, csum =3D 0, rcsum;
>         char magic[BOOTCONFIG_MAGIC_LEN];
> -       const char *msg;
>
>         ret =3D fstat(fd, &stat);
>         if (ret < 0)
> @@ -238,52 +278,9 @@ static int load_xbc_from_initrd(int fd, char **buf)
>                 return -EINVAL;
>         }
>
> -       ret =3D xbc_init(*buf, size, &msg, NULL);
> -       /* Wrong data */
> -       if (ret < 0) {
> -               pr_err("parse error: %s.\n", msg);
> -               return ret;
> -       }
> +       ret =3D init_xbc_with_error(*buf, size);
>
> -       return size;
> -}
> -
> -static void show_xbc_error(const char *data, const char *msg, int pos)
> -{
> -       int lin =3D 1, col, i;
> -
> -       if (pos < 0) {
> -               pr_err("Error: %s.\n", msg);
> -               return;
> -       }
> -
> -       /* Note that pos starts from 0 but lin and col should start from =
1. */
> -       col =3D pos + 1;
> -       for (i =3D 0; i < pos; i++) {
> -               if (data[i] =3D=3D '\n') {
> -                       lin++;
> -                       col =3D pos - i;
> -               }
> -       }
> -       pr_err("Parse Error: %s at %d:%d\n", msg, lin, col);
> -
> -}
> -
> -static int init_xbc_with_error(char *buf, int len)
> -{
> -       char *copy =3D strdup(buf);
> -       const char *msg;
> -       int ret, pos;
> -
> -       if (!copy)
> -               return -ENOMEM;
> -
> -       ret =3D xbc_init(buf, len, &msg, &pos);
> -       if (ret < 0)
> -               show_xbc_error(copy, msg, pos);
> -       free(copy);
> -
> -       return ret;
> +       return ret < 0 ? ret : size;
>  }
>
>  static int show_xbc_kernel_cmdline(void)
> @@ -412,9 +409,8 @@ static int apply_xbc(const char *path, const char *xb=
c_path)
>         char *buf, *data;
>         size_t total_size;
>         struct stat stat;
> -       const char *msg;
>         uint32_t size, csum;
> -       int pos, pad;
> +       int pad;
>         int ret, fd;
>
>         ret =3D load_xbc_file(xbc_path, &buf);
> @@ -427,6 +423,13 @@ static int apply_xbc(const char *path, const char *x=
bc_path)
>                 size++;
>         csum =3D xbc_calc_checksum(buf, size);
>
> +       /* Verify the data format */
> +       ret =3D init_xbc_with_error(buf, size);
> +       if (ret < 0) {
> +               free(buf);
> +               return ret;
> +       }
> +
>         /* Backup the bootconfig data */
>         data =3D calloc(size + BOOTCONFIG_ALIGN + BOOTCONFIG_FOOTER_SIZE,=
 1);
>         if (!data) {
> @@ -435,15 +438,6 @@ static int apply_xbc(const char *path, const char *x=
bc_path)
>         }
>         memcpy(data, buf, size);
>
> -       /* Check the data format */
> -       ret =3D xbc_init(buf, size, &msg, &pos);
> -       if (ret < 0) {
> -               show_xbc_error(data, msg, pos);
> -               free(data);
> -               free(buf);
> -
> -               return ret;
> -       }
>         printf("Apply %s to %s\n", xbc_path, path);
>         xbc_get_info(&ret, NULL);
>         printf("\tNumber of nodes: %d\n", ret);
>
