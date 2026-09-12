Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E713264D4
	for <linux-trace-kernel@vger.kernel.org>; Sat, 12 Sep 2026 14:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789222043; cv=pass; b=ZWJhxYDwigw6YF6k9sK4Ff8QBZJ6co+cTpu4Z+4ync+mrbwkHx9cR5hNX/uBqNIt/ZGPaW/voMV6DU+aU7gpLE3/37HS+Z/3MT6Om/k4Og2BYldejxX+lHWdwWAg0XJ4aEC0Nuxu1xTsscFJh25PjR6FE6c/LMXK7Qdu7czpi5U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789222043; c=relaxed/simple;
	bh=h6brpj5u/nMM7qT8pE96tt0VxTkwoueRws9I0pOLJLY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EksecHu1bGakxOXRi6dN1pJYPaOjx8apjn5NNGfQ2J71Z/BEIt9nqjz9l4qH1fiLbq+c+IBsRCW8ZHZdbEIyx0S4EequbRdSs3bwdLPATIEqtNvLRoqEy4uTYg33yNbkX37ijRxXdx3rSCvlJvRmfJuW3h0dPvhIru1hl3yrM8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TTQPdNXC; arc=pass smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TTQPdNXC"
Received: by mail-yx2-f12.google.com with SMTP id 956f58d0204a3-66e56a1fe3fso382566d50.3
        for <linux-trace-kernel@vger.kernel.org>; Sat, 12 Sep 2026 07:07:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789222040; cv=none;
        d=google.com; s=arc-20260327;
        b=L2DNaB/TyrkPkvWMKFliVul+3JzOmWOTK3vMSnxAtYCUlvrmsrsVDXQ+7/Pu+z7gey
         A7cFpaVC8vvZQpBHTB3HMwhcmbilU7yRgNdeEfCUuNLmlge7ZQItSSLMbTBydTc/ghQ9
         gq3yxEACW3USuG+bgvPZNonBSVHQZXXq/ck/zXnRxfBT+y3MTXNUDZWopCQPc7x2gPR3
         6gmiYEvary7coKKrGmOTuaazhILIN3/RQIqNNzVqdr7wmckD/bNE0cNrAIAoE2Six9nX
         vOWC0+uQTStJw7iCDrmD+B5/X8NTjLX29+/yBAjwXRf8Zm/JW095jqJZcKUX6Bvg75cv
         RLRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uP8joNivVUeq7UCg0aYPViRR5LnStG5aem+LvN65kxY=;
        fh=j3NWO7NWCVnb/bPV0zmilkuqn3aoh2KxzhHd4GfxZRA=;
        b=NeZ3YTizRcyW9bEaPH/SFgPmMQEdk8sQimzx049Kg11zzUzedjJxA4RPqiSPiZjhMo
         SLB8S9FcJWn2096bI/+A8aL/qa0Q0qSFNNYONlflybaNDF1kdrX8YanTvRRAneDnp3JX
         qXi411rspjDoyuvRGUnaH+N29Xa9/5Bvgkt5b13j7bY1E5qE55fe06ifujSiq9vNMzjP
         22Adko483FZv2u0O+xpfMu5gPKw3ZUbwBXHCduPO4DkIR/NVEKCGJJ77hwFwcdPMCSAY
         xf1qqcm0b3EhWoQ077USBwoHaCCqFZ4xxJEEhrv5mcXi/ffjAIpek+7sikcjUyzCc+KD
         IsQg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789222040; x=1789826840; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uP8joNivVUeq7UCg0aYPViRR5LnStG5aem+LvN65kxY=;
        b=TTQPdNXCcCUC0qq0kZKN9EDy182+wL0X55DX+1K0Ge3+vxbtwAz3rdWEcGywhn3MJ8
         0b9xJDInz+BFj4oFVktSCBZD6ioFWE8pwqHJcyZFA5JjRM1q1yfWNYdI1hCjzlGGBzWZ
         1GZcVYI6ar3k56xOQglyZKGrvuoKZwCXSpcvX9k3Upb76sPYAq3s0nyPLnMlp7YSjYOg
         doVZUz4MHd09yFchWzl/NdxqpSy6IhU6B/xu0cixfyrGF4Ms2OclwN9NW6itF3rtmubo
         8KaiZi2UqNSrgtasMDdlGNNkptNYjOjgQdX9Xjj/vIRxFiNfO4/eyGUQzRX9HqVpbndb
         x6KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789222040; x=1789826840;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uP8joNivVUeq7UCg0aYPViRR5LnStG5aem+LvN65kxY=;
        b=loPZGe5EP7vASRWyJIlSwegclJzWZ9CQxJ7/xYBHb3tjsX0WCPpf80tDQjsd9r5vWf
         092+dyszrz0UNe+z3B1gHwq/W8sOqlfDpYpLtkXrVVQ/uTr42mj7gbGINuJGOyI8Zis3
         7gnfaQh4d4bfQYc6NmQ59WDADN/rbT6AhyWBzbPEqH2HTeizW527D+saEnDi88Qu7BRw
         lRaA2PSezj5jyiw/5Za+6lTUgGrZcGpGN/dR0wzbhMk9S0faswqDdqyq0CEAlZZ9Aou4
         1vxSFIw2nAa5+UD+FNFSdX3mH47BsR9sesRMRrASv+IfmND9Z+z861BSf9buHnHj+Coh
         UO7w==
X-Forwarded-Encrypted: i=1; AKwUvBymPM1mLX8qQreUwAg8bZWqs0tc7js0fNOCL6ZuJViLvtntlu1UrrkrxqrgMoeNSeCv/4Hx/Cz0FhbzT5BSWRDXfy0=@vger.kernel.org
X-Gm-Message-State: AFuF++n7/p2+qVwXsQXqP4eACvn2P5Eu2iftox5NvtPEMWTf2Mspdu5W
	+jdlVA4ZvK6F7arQnXoWltfWXh8ZRdeQz1wyHz+yuO6ZST/BaPbgWG6FaCem5sp5NAtV7bGgIyt
	R8nljOJ+l+uIwVGMV35tKUVbLmqNUFZRRCo43Y/g=
X-Gm-Gg: AYBFou0NWeTtiF5gQvAb5feB0N1BZQ9mgewmOtxlnswTO7DU48CYgjI2jMfTuDl7xLj
	BQuqfiSDCS5V+KqVI43rxsvkF8KGITCCt8yU1nbRGI0c3H3VFQgsll3mBdYB2gbKPRBrQL4P8HH
	X8QpFleOKJsQmOTy9BPXxlJDUrsmo6AmE28YQUTcAsaHCFj/jk8XZZbQZnVoXnoP0c+/Q8ZK9ZU
	SpzHss2UshrtudNZKPLzoo7f6M7P+F6G7qdLXb/Pu/ArkHT4D9C80XA5l7vvQh2JzlcpqpPjF8W
	i5mU0w1EEr/v5jSZvmko0f1KPZyXXgRjaDVXPD59Kv7e/nnvbFYbPplscu7PS2o=
X-Received: by 2002:a05:690e:4092:b0:671:3392:7d68 with SMTP id
 956f58d0204a3-67135bdab56mr487328d50.90.1789222040258; Sat, 12 Sep 2026
 07:07:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <178913597653.248794.1237187523153227751.stgit@devnote2> <178913599508.248794.10388592925402087434.stgit@devnote2>
In-Reply-To: <178913599508.248794.10388592925402087434.stgit@devnote2>
From: Sang-Heon Jeon <ekffu200098@gmail.com>
Date: Sat, 12 Sep 2026 23:07:08 +0900
X-Gm-Features: AcwNN1Vr5VsseriknahGDTNoV_TO5GOKkDRiBZy77mQfG8Sm2DpAE7RopSZc0qs
Message-ID: <CABFDxMEeej-5AtJeLAsT6sFeS2DKg1pKTkFhxU-Dpqg-AVoQGQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] tools/bootconfig: Consolidate xbc_init() to error
 message wrapper
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2026 at 11:13=E2=80=AFPM Masami Hiramatsu (Google)
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
> Changes in v2:
>  - Remove redundant buffer copy in init_xbc_with_error().
> ---
>  tools/bootconfig/main.c |  100 ++++++++++++++++++++---------------------=
------
>  1 file changed, 43 insertions(+), 57 deletions(-)
>
> diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
> index aff169ba75b8..652e491b9c33 100644
> --- a/tools/bootconfig/main.c
> +++ b/tools/bootconfig/main.c
> @@ -21,6 +21,39 @@
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
> +       const char *msg;
> +       int ret, pos;
> +
> +       ret =3D xbc_init(buf, len, &msg, &pos);
> +       if (ret < 0)
> +               show_xbc_error(buf, msg, pos);
> +
> +       return ret;
> +}
> +
>  static int xbc_show_value(struct xbc_node *node, bool semicolon)
>  {
>         const char *val, *eol;
> @@ -197,7 +230,6 @@ static int load_xbc_from_initrd(int fd, char **buf)
>         int ret;
>         uint32_t size =3D 0, csum =3D 0, rcsum;
>         char magic[BOOTCONFIG_MAGIC_LEN];
> -       const char *msg;
>
>         ret =3D fstat(fd, &stat);
>         if (ret < 0)
> @@ -249,52 +281,9 @@ static int load_xbc_from_initrd(int fd, char **buf)
>                 return -EINVAL;
>         }
>
> -       ret =3D xbc_init(*buf, size, &msg, NULL);
> -       /* Wrong data */
> -       if (ret < 0) {
> -               pr_err("parse error: %s.\n", msg);
> -               return ret;
> -       }
> -
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
> +       ret =3D init_xbc_with_error(*buf, size);
>
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
> @@ -423,9 +412,8 @@ static int apply_xbc(const char *path, const char *xb=
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
> @@ -438,6 +426,13 @@ static int apply_xbc(const char *path, const char *x=
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
> @@ -446,15 +441,6 @@ static int apply_xbc(const char *path, const char *x=
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

Reviewed-by: Sang-Heon Jeon <ekffu200098@gmail.com>
