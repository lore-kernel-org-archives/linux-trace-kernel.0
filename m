Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0B31F7569
	for <linux-trace-kernel@vger.kernel.org>; Wed,  8 Jul 2026 07:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783497472; cv=none; b=fIftzFAHwE2OP8QkK9Lpk5BH1R5ElgX+jzHwQeyCt9wYRmRruYfFg9WDFatQbhzLFBpwyUFPPhmi4qLEAT3bn64PJdcY5sW/gQCDTUBROdltCs+sFqs5HsfkI5kx/j9Dy877dJvnHYDv+JZICl+RypYEmgW387nkv2yk/QYVuGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783497472; c=relaxed/simple;
	bh=qlJ//R+zrN2UCFhuVoeh0f8WSwNtkFs3oJAd94Ej3GA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=pZF1+lKvMkiMVuTQFlp8s+ssoFL9uOdud5emvNuvnUgKOp5VsIqDTdhH887RacdZnz9APCFE3gDMC+ZmGnEEdStxTyeDw7MrrqD8O0W1MstSaX7ttJ2B+Nmr0RLAC81SJN4KPEjoxz1eg4k7IcOhRKIK/606GR+e9WobXmgImlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UODt6sRO; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UODt6sRO"
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-c15d2ae8d2dso21863866b.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 08 Jul 2026 00:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783497463; x=1784102263; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PxL6rMmvaAb+6E9RAHDZ9xlGXg899687R90+P4Nthl4=;
        b=UODt6sROhR6NxBHKnj4oqMu555zLwDAIA6xHKVOgmMGdKYfTqYYKKk7h1hBo/LmLfR
         gYxXqOPMllTnI2oORT2GulCjUEjBCKt2db3K59K4vq2eRx850EUC5sNgWv7fckZy0rLY
         sbxSwm2l3rvbgBbK0vvTYs/plKmc8ATgD4pfWHizT5ME9iWsD4vpkU3XyZsLkfJ6dWLG
         azifyFuW5+L8SCm2+kJTe0uWGwz1jzyEAmusCUHbGWIFZcOnyP7SZF9LmAXmrPcgDF4q
         Xett7TpXsBxjNBoJpHg2HeBqkVgxrcAsVMfK/Kn+PIvIMglLu9ZN110kryLRjQbJfzED
         DBRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783497463; x=1784102263;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PxL6rMmvaAb+6E9RAHDZ9xlGXg899687R90+P4Nthl4=;
        b=O2rUiLxHEachkrapqevWAono0qhaibpEsLjF6rJFRXBGRLSYnmuBaRewgeEIFKx2dn
         SAaYbiNyR/QLyzBQoMNxOqFAI9MMM4dFCAj52OQLV7phqg+kBlSs2yLAKSsNqkfOWdi8
         pFP9L1Uzvfjly2vBPImelMA0INtCPL7ICDTBaqlWpfmGwvveIQNNFPHqVcUSOmF9VNYb
         Gx2aeCgrENtH7/22BbDkYrsvCa9Fxw2c9ElnxnW1Pd5kkgAszinK8EQxpMZ1bXOdliwQ
         mKhFzIbVtlLPnNHIEuSKxhLOIWqtHcbBC2MHDxkGKFcGsDfiZbnVBBLIuJjfVAl3B1xH
         UH4g==
X-Forwarded-Encrypted: i=1; AHgh+Rp0Rz5H415+RQ1ferp42HXEpC5ROWdGNOdmYrGW029sJXXGj+dFx0VqS/DniN1Ue+4Cqy6fUxai2kueAKLa65T4oTg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMqSUBhHG5vspD64qkhaivfRX6rspmbr4IUfhzxjT2Sk3osiD4
	Jvr+7zhjahFLBmm5JAnr/W0vAGxuUNfTmXvzRCZkky1HgrD3yacEakmry+SWXYkjiTfJ8cz3b3p
	tyt1v9HEJNAEYY6TWQX2RJQ==
X-Received: from ejie9.prod.google.com ([2002:a17:906:2d49:b0:c12:5e2b:a869])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:906:1b56:b0:c12:6c2e:ae9 with SMTP id a640c23a62f3a-c15ce014ec3mr43200266b.22.1783497463092;
 Wed, 08 Jul 2026 00:57:43 -0700 (PDT)
Date: Wed,  8 Jul 2026 08:54:31 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260708075435.47419-1-vdonnefort@google.com>
Subject: [PATCH v2 0/4] trace_hyp_printk() for pKVM/nVHE hypervisor
From: Vincent Donnefort <vdonnefort@google.com>
To: maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com, 
	suzuki.poulose@arm.com, yuzenghui@huawei.com, catalin.marinas@arm.com, 
	will@kernel.org, rostedt@goodmis.org
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kernel-team@android.com, qperret@google.com, tabba@google.com, 
	linux-trace-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Hi all,

This series adds a hypervisor event "hyp_printk" which enables
developers to log pretty much anything into the hypervisor tracing
buffer, just like the kernel function trace_printk().

This enables rich logging from the hypervisor, while leaving all the
string parsing burden to the kernel. This has been the main way of
debugging pKVM in Android.

Even though not strictly related to trace_hyp_printk, I have added the
following two patches:

  * KVM: arm64: Allow early calls to pKVM host_share/unshare_hyp

    This one mainly intends to support one of the new features I have
    posted here [1], which allows to enable tracing as early as
    possible. I have added it here to limit cross-posting.

  * KVM: arm64: Move kvm_define_hypevents.h to arch/arm64/kvm/

    This one is just a cleanup.

[1] https://lore.kernel.org/all/20260605163825.1762953-1-vdonnefort@google.com/

Changelog:

v2:
  - Collect Fuad's tags
  - Rebase on 7.2-rc2
  - Warn when trace_hyp_printk callsites are exhausted (Fuad)

v1 (https://lore.kernel.org/all/20260612142245.1015744-1-vdonnefort@google.com/)

Vincent Donnefort (4):
  KVM: arm64: Allow early calls to pKVM host_share/unshare_hyp
  KVM: arm64: Move kvm_define_hypevents.h to arch/arm64/kvm/
  tracing/remotes: Add REMOTE_EVENT_CUSTOM_PRINTK() helper
  KVM: arm64: Add hyp_printk event to nVHE/pKVM hyp

 arch/arm64/include/asm/kvm_asm.h              |  4 +-
 arch/arm64/include/asm/kvm_hypevents.h        | 14 ++++
 arch/arm64/include/asm/kvm_hyptrace.h         |  8 +++
 arch/arm64/kernel/image-vars.h                |  1 +
 arch/arm64/kernel/vmlinux.lds.S               |  4 ++
 .../define_hypevents.h}                       |  0
 .../kvm/hyp/include/nvhe/define_events.h      |  2 -
 arch/arm64/kvm/hyp/include/nvhe/trace.h       | 65 +++++++++++++++++++
 arch/arm64/kvm/hyp/nvhe/events.c              |  6 ++
 arch/arm64/kvm/hyp/nvhe/hyp-main.c            |  2 +-
 arch/arm64/kvm/hyp_trace.c                    | 63 +++++++++++++++++-
 include/trace/define_remote_events.h          | 19 +++++-
 12 files changed, 179 insertions(+), 9 deletions(-)
 rename arch/arm64/{include/asm/kvm_define_hypevents.h => kvm/define_hypevents.h} (100%)


base-commit: 8cdeaa50eae8dad34885515f62559ee83e7e8dda
-- 
2.55.0.795.g602f6c329a-goog

