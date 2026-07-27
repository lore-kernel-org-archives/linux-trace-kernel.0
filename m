Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79EF3D6CC6
	for <linux-trace-kernel@vger.kernel.org>; Mon, 27 Jul 2026 19:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785180168; cv=pass; b=BmnJlzxZkzZ5eLhejTgMQpwpnKY45p4I+rqYwtE+n89Z8FIyH/uITvQN+NaFxe2sjeynaKfXOGn0RwyMUnZtAihkQjvLJXkgdTGDlQZzu7e/vudO4I/IWJHa1WBNyqRWpB55A0pY9Buio8xqGyX7QeI9SLEEU5QhnqE86h96UAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785180168; c=relaxed/simple;
	bh=jSXdeM+VpzIULIXVGml/CvGpBpWrkqMUFrxFbvuBuSE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QLTT/LjtIBLmT5SudNaiaf6awfpN+l4qDIe8H5dlRTyYlYDr4hbGuDvX12qf8Zm2SjCNA3n+TWntdoO9jBg8Ri7W22DcqIrWYUiOsCnknIXAlgaVY/5t3OR2UP2a9nUTkvVnUtI6+w/ahzk98czYD53iNb5GxnRyEQIuAariDIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XBkevW62; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XBkevW62"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c1c24ec9525so504475766b.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 27 Jul 2026 12:22:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785180165; cv=none;
        d=google.com; s=arc-20260327;
        b=Of4or3YkDkvqdfKTa8nra80tr6jXFPJlp043GhijXeAI6NcFZdk1RGFGLaqHMzFGGW
         PhTaqBnWiRXF3BJcVjoIBH40lMRVM4Wcfv9dT7aq7dTvi3NsbFTGRhYsQmvTIX4paILY
         iE4GIxf/XfS3+9gvDOqr5x11lWwrj8ffe5gZmWzYy0YkQzoXHuVkTyfa97mn461AmWXB
         vwlR2H5CNrZ9Jl5dZlXJzk1G4t1uhEFL7iZTtxfONYOy4npUvR0oPLh/UlJSlGkKrSho
         GbhfusFNZJlIakjSn7XQ3zQWwtkICr8VGxmRSuQdO2cQbPPZRglc7AXPUq6dZ1eOuTpH
         4GJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PzxsUu8EEz6aogAVQCyar7okPKydIEKaNYl3cOU+cbs=;
        fh=c2X7lz4aUOCnoY7Ms61AXDVT0f5FH4oaqLloGvr0gBM=;
        b=iyg82bHPZp1unTXAdIZq9th2AJDVsHfbxWVYlKT0KPoQpgBq5zk2qTRkt+vdQhpe17
         libRG1irkeJEqeaHsz9A5VvXy1IReP5CUXWoCoj5zJ920nHELtZ95XYTpUjVnAcGOM0G
         jiGCLBYEBhbzKl2macb1NEWuB4uqwyJyYFJ+gf/VKkIE0DdmU0nxBWnNupk3gVRpEuy3
         ztbYP5ApTJQ7KXKQexxJT7rpS3xX8yRVa5eJZfitrcHq/spK9g4E3meWasnkKjjrI1p8
         wjstzdS5fx5QEDu0r/Ag8hiKb8ynkS7Magm7jvqIFkPp+1ZK5oLy2UktmNI7yksOHZvI
         Qa8g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785180165; x=1785784965; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PzxsUu8EEz6aogAVQCyar7okPKydIEKaNYl3cOU+cbs=;
        b=XBkevW62mJVfiHfrfWwEcn6imwH/8jeYb/GWBqCHQjNtCjDTfZ77h6TLEXkiw8fQDf
         cfIo8XPRd8Zrv3Qe8Zd7Hv3oDG3BjIBehGRM5lCGVI6oxgSOB7ihYX8QshOrfKciZ7Dk
         crQIlNzBcmu5MPu77w7C9lB05Rr7cBe9tBeNb+4/XsWmrkyTW0PRVB3CQhSN9+HxPaU0
         MX4x8GeFeUdB/KJzacpwkipjkQeHF/Jq+6kCrL28QMaCDeTyYpjZHWdZzo9OHu/3wkCm
         rWdMLkXodzuNSAXSF19DQhRpPrbyz9sJS7MvtexEU3yDdxiHj1ZUIOsjG8C2aH/4A0BY
         lt5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785180165; x=1785784965;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PzxsUu8EEz6aogAVQCyar7okPKydIEKaNYl3cOU+cbs=;
        b=SbNV9xjnJeeA24iHxDXBtD8fL+gNitzOIILlTxWciPVceSSotu3dkNmFO1opyTto7Q
         7La+YfqoaUGSHHaz5LLFdvFc2xTv6+AfOQARRNZS+tPe8sN+ffqkPzYuZPNn5l4MdEgm
         JGImXWobwflZZR3GA3PYx/OXk0vyaFVT75/QBfm1z4IeY+uXkKpAcsbBvDwdNUB4N1Is
         MRM8IGAo+JdZ37mlAqJw6syFG3xUXmkC4EYKm7NS7NagwQD+gl4NPZ6QCITw2ibr9JOC
         eadk8hzQFl/TR7k405dYd9j+HqNf/YPog12XUIDM1DUZSQoaFfGV/SH1xEhN/GmmzRM4
         hyxA==
X-Forwarded-Encrypted: i=1; AHgh+RpRGgjTJaQMdS5lsF7n4w3bPo65a9raRkbSdLVZ/JM3M3TUOsbSAr8X0kvsMcI3JhVfrsPROxSIhesHGlOYvr2pyc0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHqYunYWCljlYM2AvCTE1gMZYZoTaajp51IN3x/EQhnoZweaHw
	13LtsJ91n7V+OUqECg4VIl/Iqo5bx0lVTXSk0XOstdNti08y2LZ6b1HaoSazfKCGHxT9d8wAct/
	kMC9ucEb9vl54ElYk3Swu9SDhu9OGLX06OalYgqrK
X-Gm-Gg: AR+sD121vwYzqMZvCvXcJPR0dhn0eDnToOpyR7IIU4ipdfl3lETc08RubJcIh/I4VSz
	NwvaRzjWjI1H1O1pL3cVvkdw+v3P27rd3+gWGnhQAqBx6rvJmjHl3WttX6OgOnmDkGfEq6R5xuS
	dI63vLMt/xQ7sFjFNVt+RZN5kehitrmICjBf8jX366NGFR3siY7i0Yfp0IagdzmcQTsHme7meHJ
	jsJt8xOMMYBBQ6QI3t04ikP86WQxHqnvW2/5HkM7A04roR99RnXUHDQuM41GrsW9/H/vEbmvFR0
	sRv4+/L/ojwPC3Gpe5n/gLBc9wRwrmL7ZJJi6wbFGxXLvovwp4sJOdagKssYjZcHadj8W1HNaw=
	=
X-Received: by 2002:a17:906:eec3:b0:c1c:62b4:1ebf with SMTP id
 a640c23a62f3a-c1f692f28c3mr17259666b.60.1785180164098; Mon, 27 Jul 2026
 12:22:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1785153469.git.hongyan.xia@transsion.com> <eb38b41ae1b3216ec69fb45555ef5df57efd7b8d.1785153469.git.hongyan.xia@transsion.com>
In-Reply-To: <eb38b41ae1b3216ec69fb45555ef5df57efd7b8d.1785153469.git.hongyan.xia@transsion.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Mon, 27 Jul 2026 12:22:32 -0700
X-Gm-Features: AUfX_myNeo2p_4eMOzizBRqY-lBcfNbJZ5LCrTo2tmMUomZNZli_Ze8j8wrUS8M
Message-ID: <CAKwvOd=HeG=z1j2qB-SX3NQ=62ERr=KpQNZyqqp2Qy4kZ54RLw@mail.gmail.com>
Subject: Re: [RFC PATCH 9/9] arm64/debug: Mark debug exception helpers __always_inline
To: Hongyan Xia <hongyan.xia@transsion.com>
Cc: Will Deacon <will@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Christoph Lameter <cl@gentwo.org>, Oleg Nesterov <oleg@redhat.com>, Naveen N Rao <naveen@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Nathan Chancellor <nathan@kernel.org>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Jiazi Li <jiazi.li@transsion.com>, Pu Hu <hupu@transsion.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>, 
	"llvm@lists.linux.dev" <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2026 at 5:25=E2=80=AFAM Hongyan Xia <hongyan.xia@transsion.=
com> wrote:
>
> From: Hongyan Xia <hongyan.xia@transsion.com>
>
> Static inline should be enough to actually inline functions for most
> compilers, but my Clang-19 somehow thinks it's better to outline them.
> These tiny helpers then live in normal .text sections instead of
> .noinstr sections, violating noinstr.

Anything special about your build or config?  For example, we've seen
a recent influx of bugs around AutoFDO not inlining functions (despite
constant propagating initdata constants into them) leading to modpost
errors.

Can you perhaps share your config so that someone else could repro and
take a look?

Happy to follow up in our issue tracker, too.
https://github.com/ClangBuiltLinux/linux/issues

>
> Mark them __always_inline so the compiler can never outline them.
>
> Signed-off-by: Hongyan Xia <hongyan.xia@transsion.com>
> ---
>  arch/arm64/include/asm/esr.h       | 2 +-
>  arch/arm64/include/asm/percpu.h    | 2 +-
>  arch/arm64/include/asm/preempt.h   | 4 ++--
>  arch/arm64/include/asm/ptrace.h    | 4 ++--
>  arch/arm64/kernel/debug-monitors.c | 2 +-
>  include/linux/kprobes.h            | 8 ++++----

It might not be appropriate for the changes to kprobes.h to go through
the arm64 tree, but maybe it is?

--=20
Thanks,
~Nick Desaulniers
