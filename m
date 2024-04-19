Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8323B2837F
	for <linux-trace-kernel@vger.kernel.org>; Fri, 19 Apr 2024 20:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713560125; cv=none; b=E0QwgKdTplsyiJ5s3eeapScYZXdg/sPD2WVlkabrm6oeCUg/8WGzJO7CVMqu1Yc79PksKzx5ywIu7AQ7kHzR7/fxngXw/Zmcsc9LCdE9kSRAY2qdChaCKlPEdhYtJhNCeSXCLKXkPW/iX8Ed20+yLtevw2CFDrs9gACy28198DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713560125; c=relaxed/simple;
	bh=0GvM01Qlx5wuJBtCbl0XQHDADvYPFlcLL9+gjZzeNB4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IU1+1qeEduNGIAjSOOB25MAKvgzplLgEKcIeonzM1LAwTu7To0k9krSt3fbX9Mwe5JvcmZeTZvFl0Rg6dEfqkgzREKdhLKITDUHAHnW2JVeI0deMqNV0cu3dVVhLvqelxNuBhM+aQ1NRmRcLk0aGTQX9r8SFYzAz9v1ycMlpIB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3WmKU+vS; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3WmKU+vS"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-434b5abbb0dso89251cf.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 19 Apr 2024 13:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713560123; x=1714164923; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AnzzcopxYVakJwmdZOL+JC6KyzHciDKz/A3YbkmreBI=;
        b=3WmKU+vSGEVMlsj7qemhhGlkU64jcdm379MU9ZmE//fK+O43qEPv+1bWIzzOV2FFUA
         IUyLGyFs0P5xn8VrNcE5npNWMe2r8zo8BIVMa3JV+ZcCyq2hwQjCeMrUVsD0RH7EwmBJ
         Tv1f9R7XDdDRXj+aFWFtkr27XigL8ELO3N1vGjbLcguur/XRUbTt8/MoxVI+YSdasvXh
         di0nnxD52+b9X8zIrpwWnVTAA0bTEfhkMP4dMMaAd05wWaaYCBvE10r9Cb4u9Lq4q7l4
         torqRnB0Ynyr9wx9ORJ+38qYRwDMjGzrnfbEF+YibFnJgTLzw0FCMeF3lbhfOnQ3q8lt
         A0HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713560123; x=1714164923;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AnzzcopxYVakJwmdZOL+JC6KyzHciDKz/A3YbkmreBI=;
        b=Gah+SN1HfRgmU6Y1XKyYCeilpZlgGWrb+gHd9l0DvfsR4C3BDERZuEslKpl2QEh3si
         VllaEh9lP4tkYpU/d/duzsVArB70eF+jKysy+xCWNSRt3CCbpM+FWxnZ6nvgEFGAdlzP
         TEnDobbXReZllAJuBg+8DIhTs+yujT4KYtk/5Xpp1CIsm4JwjKTi7LSMD3lPXK3FR3fk
         URHQNUyeNPGsbIrvOlXhtq4tAN3Awzm9JhdU9tzUjVy4O4OlbbdRpWLoRhs1tvdNSkH3
         sYKLlmutKBy1RbuCD+kWFFMEwhy+mu29SHQD2tE5XBIxYDRgb1yE4FnA/XXg5j/rk/yn
         jOug==
X-Forwarded-Encrypted: i=1; AJvYcCVsHC2tv9oHh/uwstSJKkOO51N462zUqLXITJzBvSCn6xSEVYhrVhYMFHzeHMeVteGjPO7cXB4TkjVFs/wZ+r3DxdWFA3JSyRaXigGG/cJrxhIy
X-Gm-Message-State: AOJu0YyvdBxC6n5YEDF1EQlcpQoEXNvbxKJza0DDJYBICvVhTTN6nGkI
	YtDT3xi2SZTyNmzgJXhc7LcM+GOgCwiW42HOdGc0T+Wbs08+h/4MxTdDDXDlt/oofBOkOL6j/0+
	Mtsg6dg+5v4doTzjPjW3eCTBh4ct9RchJQtBX
X-Google-Smtp-Source: AGHT+IH9sSY76fFvumrBUCB5IOWf40dprm49al51d9C63r/bzJh0mJ4NGK5So9vqJF4lfC7MlLaL31EdoOvAUHGh1YY=
X-Received: by 2002:ac8:7357:0:b0:437:c52f:cd6a with SMTP id
 q23-20020ac87357000000b00437c52fcd6amr69580qtp.8.1713560123419; Fri, 19 Apr
 2024 13:55:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240401232946.1837665-1-jthoughton@google.com>
 <20240401232946.1837665-6-jthoughton@google.com> <ZhmdOb7lAd3DM5Tq@google.com>
In-Reply-To: <ZhmdOb7lAd3DM5Tq@google.com>
From: James Houghton <jthoughton@google.com>
Date: Fri, 19 Apr 2024 13:54:47 -0700
Message-ID: <CADrL8HWAzcq4N-triWiMvtpUKvb7C03+2mQpNBxV9Ci-F5GyBw@mail.gmail.com>
Subject: Re: [PATCH v3 5/7] KVM: x86: Participate in bitmap-based PTE aging
To: David Matlack <dmatlack@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Yu Zhao <yuzhao@google.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Sean Christopherson <seanjc@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, James Morse <james.morse@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Shaoqin Huang <shahuang@redhat.com>, 
	Gavin Shan <gshan@redhat.com>, Ricardo Koller <ricarkol@google.com>, 
	Raghavendra Rao Ananta <rananta@google.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	David Rientjes <rientjes@google.com>, Axel Rasmussen <axelrasmussen@google.com>, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, kvm@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 1:44=E2=80=AFPM David Matlack <dmatlack@google.com>=
 wrote:
>
> On 2024-04-01 11:29 PM, James Houghton wrote:
> > Only handle the TDP MMU case for now. In other cases, if a bitmap was
> > not provided, fallback to the slowpath that takes mmu_lock, or, if a
> > bitmap was provided, inform the caller that the bitmap is unreliable.
>
> I think this patch will trigger a lockdep assert in
>
>   kvm_tdp_mmu_age_gfn_range
>     kvm_tdp_mmu_handle_gfn
>       for_each_tdp_mmu_root
>         __for_each_tdp_mmu_root
>           kvm_lockdep_assert_mmu_lock_held
>
> ... because it walks tdp_mmu_roots without holding mmu_lock.

Indeed, thanks. I'll make sure to build with CONFIG_LOCKDEP for the
future versions and check for errors.

>
> Yu's patch[1] added a lockless walk to the TDP MMU. We'd need something
> similar here and also update the comment above tdp_mmu_roots describing
> how tdp_mmu_roots can be read locklessly.

I'll add the macro / function to do the lockless walk of tdp_mmu_roots
and explain why it is safe. Thanks for pointing out this big mistake.

> [1] https://lore.kernel.org/kvmarm/ZItX64Bbx5vdjo9M@google.com/
