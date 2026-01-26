Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF33445BE3
	for <linux-trace-kernel@vger.kernel.org>; Mon, 26 Jan 2026 21:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769463124; cv=pass; b=unUTpPduPEeRoh8E40AAMOG7qnq0ZRmBOvagdGTUYi548/AMhLUB+3QuxrEiUmDNZdmxgQjuRj3RIYrtFchuTCMZHswYVusVKdr4OebMcy0SvG+fV9TSOzVynNJulpZgU5J29118TkGnw1l8djQ8UTo2HOtTRWk+5VSW1tlJeX8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769463124; c=relaxed/simple;
	bh=x4ddBnE6UlmuM4UnSaFJuF1X0KUypj4oAt9SZYS5klo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Eiekak/VlJpSi9hvuCFqkxhwWFetfJKqn534aYdWHsRh7yZmr/e19TLqKtU7BB2IbmtDXQ9f9bRPc6i0SELaJYHerpK8CXLgFJPlSwdSXUOaeb5cwnm92R6BHztAVHW85qpo12Fo2dJqnWxautMTAbOMPwYu7VziAyOrXWU+9Qw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4g+6H54s; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4g+6H54s"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2a0d06cfa93so6935ad.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 26 Jan 2026 13:32:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769463122; cv=none;
        d=google.com; s=arc-20240605;
        b=VXxyNLHAMmV8Dl/woihHfJDJzoi3WtJOYgFT97MQqJ9xb7BLjU1dNFu6l3BmtLvhaX
         QRCn1HF7H5xggsz5K2yPGXzehDDJubcYQVmxeJe5xop9986KBMi4jfwiibDxrszmYjUU
         P1KhPF1cSircrOuBtIhoe8YV3Le1KfJh1PIWKeLR3vENtvhFnPBOFkbC8XanP1lEr5x7
         Ngr6hb1SAefeZGwX6/DbkQ1/qurZ3850MZAgCZ+dvTQ+NueVIaePsgKFXsV28axMM6/v
         mQw2pfPxoPwLG2+Yrimi6npgfNKbwoXv4bLrlGSLJ1x9Mbqo9nnNTfR0jaFQMJHwyS4p
         dCww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GdffSHeo/iYpRVNWqMXBIRygwWn3EwsHPHsZ8am4tRk=;
        fh=6XdFMi7EMc624ILaV5wCCYrgI3UnQoNEcTRqBg49IqM=;
        b=AWjnE2Pe9dOiO0vWK3REp2psbNfVwnhYotCZR51gvb8KIEamkxYZZrRotW7gNWVzoR
         l4F4Ca5HzMWvgcfvHlUFs3hg3uJoLxFsNE2L73mYxzNKohbtVEdHjDLA5WsvqIhDrrQe
         XA40ScnenK5sgyKnMzxUBLl5qF+5f4it96oC/6MT1shCmqjVBtHPHIIm0Int8VGcjtrL
         4PnlI6IgUwSws4S7xgeVLyj/ZuP8JCKtAZyxjA4XMHFHvWSY+CWFrfUmcZo2Ztc0Ql/W
         2EAbbL6W3c6Kgx0DDeGy+vX0TDK4Op04rwZI8lKClumXZ0418CVOKNEJIM3FB29Wd6iw
         OZ3w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769463122; x=1770067922; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GdffSHeo/iYpRVNWqMXBIRygwWn3EwsHPHsZ8am4tRk=;
        b=4g+6H54sdoDXPNQlVcBwztJd/NXTmjZk58DM3HWPH4d+rPszlNYfmrlmclVTVimOIx
         UeY6fIhk7EVnQpFj8uIZ5wCtCSYPaucqFNUaT/25Aq8vWl5hDAspnykk3kmjyY2ho7Yb
         Y4tpW9u6EMkB7OqnPoOk4XClMx51UxVTQE+gdqPPOFdvTtcYJd9/ZNuQYyoubzimjmpL
         M3QXLdlijO6T8YSCJjCs1kkvVj8+vT9EFGm1prKaWGU/coAhj9r2MNKZq2q/EBMrrmyY
         9js0v0zoPz8a7zs16RpLU9Zqn5W8sc17e1+Vmj8qMk0BHiVB3tUxKKsSEgrruCfWvGjA
         PB6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769463122; x=1770067922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GdffSHeo/iYpRVNWqMXBIRygwWn3EwsHPHsZ8am4tRk=;
        b=NGnE6ZJVQw5o0UblbTqMLr+x91uSQCgUDww+qWz8OodIMQMRyxcHzilaU9s+ry7Tyq
         LI2nuqaK01KuP7Pv+tUSqffRoYFNS3rB0r6slcVqf2VenIwSEYr9gAc+wtAPp3gR5FJ2
         1ypwkV0OHa2DiLZt02ChaPm+6QcgsNIqQO6pbtwtKUAgY4FMRazHTlPQn0oXc5wDwOd6
         SDuyvMTSTtMKBSu+2lTAvnR96ynfQorDOKLtgZALc4ZxyHN133cxXwh38aEkz/+L/w04
         7RxnBaM4bXk9oc7OQhmPxWeiTMyTR0+vCDIZLHQuVkS/FTlOWHxVCMjNEI1GdNhneTro
         FLAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsLXlgMXjEepXibi+fidT2ft1vf11QwhqSWCE/CjJaABp1DNL5nZiskaWVrpO6iGtXHza13KT7K4+WUTlhzF8enhk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHkuexYgqmXjvMX0Ny9PRq9d0/JNJvJTj9OU7DofJ0dCamTBIg
	M69HH+nrsRMwpG2fG06JuUjvZuLHhz3tkTaBAD0KeSD6miUdOG7hLQGlwLi0yjQizEVuVS6Sqza
	9oH62R2yQx3OzlIg+xWTJpeqD6yimSTCM0/r2rour
X-Gm-Gg: AZuq6aIZVg/GPOiX1NokqAkd4OrTb01N7PQfmf3kAa9y+LTPEFlUiVMrrQ8Oqz1jxck
	eiHDRPUPuD83nvuw28TM9UGwvEvvrulXjKJQUHrfJD/q48jr+IRRLQ9gondfXyP/RehDVzkaHdq
	XIqnC+acgWG2im4hSuoMWiz5qNxkIjKyivU8O+60dpVnlc+OkHmHDlub7tilc/jC4GmCFkA92cG
	PHmAnJ1ZX3zxGizXB9QMmUnb/Nds6J0GbhIfv3eeLBG0WI9Rphv2fI3SRVXGR6KZVDJzbriuIyy
	4PVLnQ6/lwIENxt/5QVxa9C4
X-Received: by 2002:a17:903:18b:b0:2a0:7fac:c031 with SMTP id
 d9443c01a7336-2a844e78abcmr3049555ad.14.1769463121618; Mon, 26 Jan 2026
 13:32:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126104419.1649811-1-vdonnefort@google.com> <20260126104419.1649811-20-vdonnefort@google.com>
In-Reply-To: <20260126104419.1649811-20-vdonnefort@google.com>
From: Kalesh Singh <kaleshsingh@google.com>
Date: Mon, 26 Jan 2026 13:31:49 -0800
X-Gm-Features: AZwV_QjRVAsI7BYNB-SSd0KqV-MZmQcJjsc_0anhfEHofc202jxoz2KReva1YZQ
Message-ID: <CAC_TJvfzETz53ZXCk89ndqhj0+nuMUxPsB=NNT8kSZP-iwLm7A@mail.gmail.com>
Subject: Re: [PATCH v10 19/30] KVM: arm64: Add PKVM_DISABLE_STAGE2_ON_PANIC
To: Vincent Donnefort <vdonnefort@google.com>
Cc: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, 
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	jstultz@google.com, qperret@google.com, will@kernel.org, 
	aneesh.kumar@kernel.org, kernel-team@android.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 26, 2026 at 2:44=E2=80=AFAM Vincent Donnefort <vdonnefort@googl=
e.com> wrote:
>
> On NVHE_EL2_DEBUG, when using pKVM, the host stage-2 is relaxed to grant
> the kernel access to the stacktrace, hypervisor bug table and text to
> symbolize addresses. This is unsafe for production. In preparation for
> adding more debug options to NVHE_EL2_DEBUG, decouple the stage-2
> relaxation into a separate option.
>
> While at it, rename PROTECTED_NVHE_STACKTRACE into PKVM_STACKTRACE,
> following the same naming scheme as PKVM_DISABLE_STAGE2_ON_PANIC.
>
> Cc: Kalesh Singh <kaleshsingh@google.com>
> Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

Reviewed-by: Kalesh Singh <kaleshsingh@google.com>

Thanks,
Kalesh

>
> diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
> index 4f803fd1c99a..6498dec00fe9 100644
> --- a/arch/arm64/kvm/Kconfig
> +++ b/arch/arm64/kvm/Kconfig
> @@ -43,9 +43,27 @@ menuconfig KVM
>
>           If unsure, say N.
>
> +if KVM
> +
> +config PTDUMP_STAGE2_DEBUGFS
> +       bool "Present the stage-2 pagetables to debugfs"
> +       depends on DEBUG_KERNEL
> +       depends on DEBUG_FS
> +       depends on ARCH_HAS_PTDUMP
> +       select PTDUMP
> +       default n
> +       help
> +         Say Y here if you want to show the stage-2 kernel pagetables
> +         layout in a debugfs file. This information is only useful for k=
ernel developers
> +         who are working in architecture specific areas of the kernel.
> +         It is probably not a good idea to enable this feature in a prod=
uction
> +         kernel.
> +
> +         If in doubt, say N.
> +
>  config NVHE_EL2_DEBUG
>         bool "Debug mode for non-VHE EL2 object"
> -       depends on KVM
> +       default n
>         help
>           Say Y here to enable the debug mode for the non-VHE KVM EL2 obj=
ect.
>           Failure reports will BUG() in the hypervisor. This is intended =
for
> @@ -53,10 +71,23 @@ config NVHE_EL2_DEBUG
>
>           If unsure, say N.
>
> -config PROTECTED_NVHE_STACKTRACE
> -       bool "Protected KVM hypervisor stacktraces"
> -       depends on NVHE_EL2_DEBUG
> +if NVHE_EL2_DEBUG
> +
> +config PKVM_DISABLE_STAGE2_ON_PANIC
> +       bool "Disable the host stage-2 on panic"
>         default n
> +       help
> +         Relax the host stage-2 on hypervisor panic to allow the kernel =
to
> +         unwind and symbolize the hypervisor stacktrace. This however ta=
mpers
> +         the system security. This is intended for local EL2 hypervisor
> +         development.
> +
> +         If unsure, say N.
> +
> +config PKVM_STACKTRACE
> +       bool "Protected KVM hypervisor stacktraces"
> +       depends on PKVM_DISABLE_STAGE2_ON_PANIC
> +       default y
>         help
>           Say Y here to enable pKVM hypervisor stacktraces on hyp_panic()
>
> @@ -66,21 +97,6 @@ config PROTECTED_NVHE_STACKTRACE
>
>           If unsure, or not using protected nVHE (pKVM), say N.
>
> -config PTDUMP_STAGE2_DEBUGFS
> -       bool "Present the stage-2 pagetables to debugfs"
> -       depends on KVM
> -       depends on DEBUG_KERNEL
> -       depends on DEBUG_FS
> -       depends on ARCH_HAS_PTDUMP
> -       select PTDUMP
> -       default n
> -       help
> -         Say Y here if you want to show the stage-2 kernel pagetables
> -         layout in a debugfs file. This information is only useful for k=
ernel developers
> -         who are working in architecture specific areas of the kernel.
> -         It is probably not a good idea to enable this feature in a prod=
uction
> -         kernel.
> -
> -         If in doubt, say N.
> -
> +endif # NVHE_EL2_DEBUG
> +endif # KVM
>  endif # VIRTUALIZATION
> diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
> index cc7d5d1709cb..54aedf93c78b 100644
> --- a/arch/arm64/kvm/handle_exit.c
> +++ b/arch/arm64/kvm/handle_exit.c
> @@ -539,7 +539,7 @@ void __noreturn __cold nvhe_hyp_panic_handler(u64 esr=
, u64 spsr,
>
>                 /* All hyp bugs, including warnings, are treated as fatal=
. */
>                 if (!is_protected_kvm_enabled() ||
> -                   IS_ENABLED(CONFIG_NVHE_EL2_DEBUG)) {
> +                   IS_ENABLED(CONFIG_PKVM_DISABLE_STAGE2_ON_PANIC)) {
>                         struct bug_entry *bug =3D find_bug(elr_in_kimg);
>
>                         if (bug)
> diff --git a/arch/arm64/kvm/hyp/nvhe/host.S b/arch/arm64/kvm/hyp/nvhe/hos=
t.S
> index eef15b374abb..3092befcd97c 100644
> --- a/arch/arm64/kvm/hyp/nvhe/host.S
> +++ b/arch/arm64/kvm/hyp/nvhe/host.S
> @@ -120,7 +120,7 @@ SYM_FUNC_START(__hyp_do_panic)
>
>         mov     x29, x0
>
> -#ifdef CONFIG_NVHE_EL2_DEBUG
> +#ifdef PKVM_DISABLE_STAGE2_ON_PANIC
>         /* Ensure host stage-2 is disabled */
>         mrs     x0, hcr_el2
>         bic     x0, x0, #HCR_VM
> diff --git a/arch/arm64/kvm/hyp/nvhe/stacktrace.c b/arch/arm64/kvm/hyp/nv=
he/stacktrace.c
> index 5b6eeab1a774..7c832d60d22b 100644
> --- a/arch/arm64/kvm/hyp/nvhe/stacktrace.c
> +++ b/arch/arm64/kvm/hyp/nvhe/stacktrace.c
> @@ -34,7 +34,7 @@ static void hyp_prepare_backtrace(unsigned long fp, uns=
igned long pc)
>         stacktrace_info->pc =3D pc;
>  }
>
> -#ifdef CONFIG_PROTECTED_NVHE_STACKTRACE
> +#ifdef CONFIG_PKVM_STACKTRACE
>  #include <asm/stacktrace/nvhe.h>
>
>  DEFINE_PER_CPU(unsigned long [NVHE_STACKTRACE_SIZE/sizeof(long)], pkvm_s=
tacktrace);
> @@ -134,11 +134,11 @@ static void pkvm_save_backtrace(unsigned long fp, u=
nsigned long pc)
>
>         unwind(&state, pkvm_save_backtrace_entry, &idx);
>  }
> -#else /* !CONFIG_PROTECTED_NVHE_STACKTRACE */
> +#else /* !CONFIG_PKVM_STACKTRACE */
>  static void pkvm_save_backtrace(unsigned long fp, unsigned long pc)
>  {
>  }
> -#endif /* CONFIG_PROTECTED_NVHE_STACKTRACE */
> +#endif /* CONFIG_PKVM_STACKTRACE */
>
>  /*
>   * kvm_nvhe_prepare_backtrace - prepare to dump the nVHE backtrace
> diff --git a/arch/arm64/kvm/stacktrace.c b/arch/arm64/kvm/stacktrace.c
> index af5eec681127..9724c320126b 100644
> --- a/arch/arm64/kvm/stacktrace.c
> +++ b/arch/arm64/kvm/stacktrace.c
> @@ -197,7 +197,7 @@ static void hyp_dump_backtrace(unsigned long hyp_offs=
et)
>         kvm_nvhe_dump_backtrace_end();
>  }
>
> -#ifdef CONFIG_PROTECTED_NVHE_STACKTRACE
> +#ifdef CONFIG_PKVM_STACKTRACE
>  DECLARE_KVM_NVHE_PER_CPU(unsigned long [NVHE_STACKTRACE_SIZE/sizeof(long=
)],
>                          pkvm_stacktrace);
>
> @@ -225,12 +225,12 @@ static void pkvm_dump_backtrace(unsigned long hyp_o=
ffset)
>                 kvm_nvhe_dump_backtrace_entry((void *)hyp_offset, stacktr=
ace[i]);
>         kvm_nvhe_dump_backtrace_end();
>  }
> -#else  /* !CONFIG_PROTECTED_NVHE_STACKTRACE */
> +#else  /* !CONFIG_PKVM_STACKTRACE */
>  static void pkvm_dump_backtrace(unsigned long hyp_offset)
>  {
> -       kvm_err("Cannot dump pKVM nVHE stacktrace: !CONFIG_PROTECTED_NVHE=
_STACKTRACE\n");
> +       kvm_err("Cannot dump pKVM nVHE stacktrace: !CONFIG_PKVM_STACKTRAC=
E\n");
>  }
> -#endif /* CONFIG_PROTECTED_NVHE_STACKTRACE */
> +#endif /* CONFIG_PKVM_STACKTRACE */
>
>  /*
>   * kvm_nvhe_dump_backtrace - Dump KVM nVHE hypervisor backtrace.
> --
> 2.52.0.457.g6b5491de43-goog
>
