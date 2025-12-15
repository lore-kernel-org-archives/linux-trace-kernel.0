Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9E72D77EA
	for <linux-trace-kernel@vger.kernel.org>; Mon, 15 Dec 2025 04:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765774611; cv=none; b=kc/qG+76PtNY49JGXzjtiezsubdNPilDtkVDZitsUG2mAqdni3s+QrrTN+bPAQpAdDLfSolbwgV6kkDEctgklOct4YmFERjOfFFcJX1ZbAMAR6lwQxTsdwgt+VNeN4UhUL4ZjAVg0FuuhmoXkxO6et6D19G5oki2FRWIg6VhBvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765774611; c=relaxed/simple;
	bh=dyWaY6Fyj3zh8+NX1FMllbUobGrRmcg99lsPSxMvcLg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HGwU3+w8XN9l8Al8YYHJzU0RbtrvyRSCvJR+2Sf93uqXz6X5OVtPYhP+QDHhrU6yg4DQqUY2kiGO94wy1Fyj2MfEn6Z87jn7fFYsqYqmgVEhZLtbjBeg37s47AAyYH7L+xprqsRSpK8E2IXs7dKkLTh7xLOku3aTPsqznzIaO1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nUsKMGjp; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nUsKMGjp"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-64175dfc338so3635762a12.0
        for <linux-trace-kernel@vger.kernel.org>; Sun, 14 Dec 2025 20:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765774608; x=1766379408; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FPCFQP3Vt5EBLlG8b8H61bS7KpkCTlBSE7JQzBw720w=;
        b=nUsKMGjpNtn3cAi9Q0woup8ED2McdVqoTiVTkjjwDmZpdim9sgMNnkzykWgjxF2Ofz
         6xikMDW/5YZRQKOt6pOWjTcU7Ck7ZTkgP92Gq/rJ1Prltib9vcNdEGjv80u6RW7dRlxb
         BSecydXcVdlSxGZ7WjJTQXdF2fclEG/y8rvI63ggkslnodoDx8wZnt3ozU91zRVG/ee+
         pkvcoduqV3n04LpWDTFUkRI083qL7ZMJLxCHZNl5AOn9ZyQg4a634JJkCc9mqC59CQ/n
         AVgY+i1yj8MIS9zf8gHBSGW1M05yl37nJrZfBVRWNv1C6eRI6in5SwRUC6MzDheqDN1F
         B1Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765774608; x=1766379408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FPCFQP3Vt5EBLlG8b8H61bS7KpkCTlBSE7JQzBw720w=;
        b=bAREwIKPqU4dW6QRFBA27C1nYbBEQAnMUVNxqfS2UUa6lUBRr9fuEvItAeKWigt7nc
         sXpR6c8FO1kQ5eqScZWpon5Kwhg21yrZhJhTvDhWNAhKvo/XGXSJtuXErKQWrkUPXfyk
         0cit7iUIwvsxJgFLGLBcp4S5Fw5lmHTiozW5VrseHF3l5nl2STSipTYgGpfeaiMdkDHA
         c59XLFn0qQ8Q9xgQ7tUDHsKOW4hISmUMfNbsjjKQt7iRaUOWt1GvJ9fRwcN6XbhZFXEQ
         3EX7k38ykaQaocd8uMij82RN3C82dwn+OIQT+3MvbBtwWtX7F6XLIsVGQO7e7PVR3saw
         JThw==
X-Forwarded-Encrypted: i=1; AJvYcCVnPvHZ/EvdyWSTLz7btmnWRsMA0V7ALzFMrrQl+YF/2M9w0CHPCresDdg7UUv4/G4XPtupQC2SACGXC8eiT37g82o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLEO19GhvBSDr3eTIefEqvzgvw8IHLhuASAMxcuq51vzoOWVcY
	LX2dJ7E8LSl08p60C/ApuEHsTb6N1jVyJwnAfg6yUmTBTe70sg/vNrxosGWi6YLloigWpVZ0xAp
	YRqlOZe5KRqzE48MilCozlMzDtWKCb+E=
X-Gm-Gg: AY/fxX46JPiqqEaRcz+3I/Bsui8bHPOcGM8zUsC97FZ9UJXVj7g9Rl99weAMCaxnFuo
	0c5vO+4hTRV7oxDZ8QHbUE+Fa08erKPgRnm9ATv8K2yYv9qYELNovm/N6RTteqMegSIyoFplSuC
	+7t7z4pYQuwpc+ZmB4Szcq7YkXAMWIfJ40cBSD9xYy4GB2uhPqgCafvIRPToOXsEIluUhC5RVpU
	yb/g+kOxQabKOQlb7XuUxKCGZpUgM9IpVrJzs0WnK6z5493D2F9TWimzhSvgLMtNzYVv38U
X-Google-Smtp-Source: AGHT+IFrfJBBUqe+fJTs/otz3aUzkW8Pl0HnggOO5N0PlXVavpMLXgznKsETHhKbrHpJk7KNU5ZMajnlz703M/7GIhw=
X-Received: by 2002:a17:906:4fd5:b0:b76:2667:7717 with SMTP id
 a640c23a62f3a-b7d23aa4046mr1086480366b.56.1765774607557; Sun, 14 Dec 2025
 20:56:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251209121349.525641-2-dolinux.peng@gmail.com> <202512140850.JdD1lPmn-lkp@intel.com>
In-Reply-To: <202512140850.JdD1lPmn-lkp@intel.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Mon, 15 Dec 2025 12:56:35 +0800
X-Gm-Features: AQt7F2r7qaPfCZNFQJWN3FmkMI3nvzBmLh_-WHohqasKL2htaY_edIPtmNPav3E
Message-ID: <CAErzpmvxz7mthfTxc4gWFqcCW66ckuHaFnjQbakSHj31x1vOOQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] fgraph: Enhance funcgraph-retval with BTF-based
 type-aware output
To: kernel test robot <lkp@intel.com>
Cc: rostedt@goodmis.org, oe-kbuild-all@lists.linux.dev, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, pengdonglin <pengdonglin@xiaomi.com>, 
	Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 14, 2025 at 9:15=E2=80=AFAM kernel test robot <lkp@intel.com> w=
rote:
>
> Hi Donglin,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on trace/for-next]
> [also build test ERROR on linus/master v6.18 next-20251212]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Donglin-Peng/fgrap=
h-Enhance-funcgraph-retval-with-BTF-based-type-aware-output/20251209-201633
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace=
 for-next
> patch link:    https://lore.kernel.org/r/20251209121349.525641-2-dolinux.=
peng%40gmail.com
> patch subject: [PATCH v3 1/2] fgraph: Enhance funcgraph-retval with BTF-b=
ased type-aware output
> config: arm-randconfig-002-20251214 (https://download.01.org/0day-ci/arch=
ive/20251214/202512140850.JdD1lPmn-lkp@intel.com/config)
> compiler: arm-linux-gnueabi-gcc (GCC) 10.5.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20251214/202512140850.JdD1lPmn-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202512140850.JdD1lPmn-lkp=
@intel.com/
>
> All errors (new ones prefixed by >>):
>
>    arm-linux-gnueabi-ld: kernel/trace/trace_functions_graph.o: in functio=
n `trim_retval':
> >> kernel/trace/trace_functions_graph.c:888: undefined reference to `btf_=
find_func_proto'

Thanks. I will address this in the next version. The issue occurs because
CONFIG_FUNCTION_GRAPH_RETVAL and CONFIG_DEBUG_INFO_BTF
are enabled, but CONFIG_PROBE_EVENTS_BTF_ARGS is disabled.
This prevents trace_btf.c from being compiled, while the function
btf_find_func_proto
it provides is still required.

Thanks,
Donglin
>
>
> vim +888 kernel/trace/trace_functions_graph.c
>
>    872
>    873  static void trim_retval(unsigned long func, unsigned long *retval=
, bool *print_retval,
>    874                          int *fmt)
>    875  {
>    876          const struct btf_type *t;
>    877          char name[KSYM_NAME_LEN];
>    878          struct btf *btf;
>    879          u32 v, msb;
>    880          int kind;
>    881
>    882          if (!IS_ENABLED(CONFIG_DEBUG_INFO_BTF))
>    883                  return;
>    884
>    885          if (lookup_symbol_name(func, name))
>    886                  return;
>    887
>  > 888          t =3D btf_find_func_proto(name, &btf);
>    889          if (IS_ERR_OR_NULL(t))
>    890                  return;
>    891
>    892          t =3D btf_type_skip_modifiers(btf, t->type, NULL);
>    893          kind =3D t ? BTF_INFO_KIND(t->info) : BTF_KIND_UNKN;
>    894          switch (kind) {
>    895          case BTF_KIND_UNKN:
>    896                  *print_retval =3D false;
>    897                  break;
>    898          case BTF_KIND_STRUCT:
>    899          case BTF_KIND_UNION:
>    900          case BTF_KIND_ENUM:
>    901          case BTF_KIND_ENUM64:
>    902                  if (kind =3D=3D BTF_KIND_STRUCT || kind =3D=3D BT=
F_KIND_UNION)
>    903                          *fmt =3D RETVAL_FMT_HEX;
>    904                  else
>    905                          *fmt =3D RETVAL_FMT_DEC;
>    906
>    907                  if (t->size > sizeof(unsigned long)) {
>    908                          *fmt |=3D RETVAL_FMT_TRUNC;
>    909                  } else {
>    910                          msb =3D BITS_PER_BYTE * t->size - 1;
>    911                          *retval &=3D GENMASK(msb, 0);
>    912                  }
>    913                  break;
>    914          case BTF_KIND_INT:
>    915                  v =3D *(u32 *)(t + 1);
>    916                  if (BTF_INT_ENCODING(v) =3D=3D BTF_INT_BOOL) {
>    917                          *fmt =3D RETVAL_FMT_BOOL;
>    918                          msb =3D 0;
>    919                  } else {
>    920                          if (BTF_INT_ENCODING(v) =3D=3D BTF_INT_SI=
GNED)
>    921                                  *fmt =3D RETVAL_FMT_DEC;
>    922                          else
>    923                                  *fmt =3D RETVAL_FMT_HEX;
>    924
>    925                          if (t->size > sizeof(unsigned long)) {
>    926                                  *fmt |=3D RETVAL_FMT_TRUNC;
>    927                                  msb =3D BITS_PER_LONG - 1;
>    928                          } else {
>    929                                  msb =3D BTF_INT_BITS(v) - 1;
>    930                          }
>    931                  }
>    932                  *retval &=3D GENMASK(msb, 0);
>    933                  break;
>    934          default:
>    935                  *fmt =3D RETVAL_FMT_HEX;
>    936                  break;
>    937          }
>    938  }
>    939
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
