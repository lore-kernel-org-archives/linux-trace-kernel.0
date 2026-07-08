Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652E33F1ACF
	for <linux-trace-kernel@vger.kernel.org>; Wed,  8 Jul 2026 07:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783497476; cv=none; b=O2QgP734i90ZaXM5Inxe4qE3odUlEp5pRl/Yf/UM4J7rVyrtmvhHe3VQt/WhOlm0vm829Gz9gMSEPVnt2M50IU5H6nyXlYTWtGAtl7N+LqDqCzR2TuEsOa8sm+Z9oL6f478v1eyAM1ymFJ9OC7XjHBbO0UPZTQaeH/U1y2hcSBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783497476; c=relaxed/simple;
	bh=VzCYkNa30Geqvz9sJ1QH8BtffPcQxY2xckFaj8QY4L4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ex0nNybeZMqKDR82ZU5mz6ZdCtEmIAGaIEHGW9f1GKd3YHr/unVvESNbFb0ckd1Is97Xym6H2Uci+c71/FXB5ILvN72F4EOIUvdX3QH/ckFUPx+hwYQxmKjkpuYoXvB+PHR/qfc2mc7u1sYXGjx9aMovt9FGCdFj2u3wfNJolPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RBFeY7wy; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RBFeY7wy"
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-698addf0a80so513212a12.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 08 Jul 2026 00:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783497466; x=1784102266; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AKUSCNsamYINaoMMk1AY8FuyMTxoIpvfSaBPJ1kllt0=;
        b=RBFeY7wygWa7NBoQHRLDSPNlLfySQLEfBzDXY0cmYc0R+M0lixdqUobSW4n3bdpHwF
         nVXLe9X1HIx2BpDJ8RMyNLIvo2KtAIk8gmF7obEFu83T6uCdUz5m9bvih+RXm7NDIUkW
         0n0S/5WoFPyWuRLECTlOFmCVNz3rd7G+Xvj1RWHYaluk8Ctnh6/0IunpickdmMB43IC0
         cApiq5SrDsHt943g0oFBeqdDzYgpTrLVUQnpCSuw5vTPYMvwvoAmNZPM7zxfbN9VpvnX
         jC77aSjlzBqj+/mSv39AtB+EPOpnMUd31eKIW8QDGZZWVNq4Pw0XmMMOjcHTsQrOivm6
         DnMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783497466; x=1784102266;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AKUSCNsamYINaoMMk1AY8FuyMTxoIpvfSaBPJ1kllt0=;
        b=ASxzQUtTdC6X6b77AhiX5GuEFnVW1srhytn/21NY5Zu58tzn7CXlSR0bsmtq+kJsvB
         3ZSvClYtGtell99bHe24CMBCGFOdHDdy9BaLw0IK1x9Ux99zh+XYs6Vjvl4fi+0EQJ3C
         RyctL/biVZKidnrJoZHaIpNkidG7+dk1kgtj1c4DfidCRsjA5K67t9uYyFk43/mv5dfz
         8j69F9GS9Ep4Vh3TrAXk6kUcGKnvh2uyilACo/eNKCSR53YrBRqcflizlI6/YXryNuQo
         m1jA4+CNy2kSy/7Slv27u/RB0ihtUlJyo9MYB4CdHObPj1KxbPA6XAAkP6dyeQkdUGWi
         SGLA==
X-Forwarded-Encrypted: i=1; AHgh+Rq4iytXSQChyjvWdaIXLVYfa7+/6VJv/bo2LpMl5awOoi1a+owuCM84oIc30XUbEuDq6ZyF8zPP0zwEkhSbij0CPnI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU7z8VYJA9Q05ZggDZR97xozzgWuIxXRYAJ4Ei5t7QZGUhyKZj
	qEJxlWEULOFlHQxIyfO3OKN2pnovX7XeIzUe2W0j1Ok8DkTFRNXrFv+H5TxXgW3bC4VusEFcpaP
	gc8PaET/jiUNENz74CDmRsA==
X-Received: from edro11.prod.google.com ([2002:aa7:d3cb:0:b0:698:aaa3:b77d])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:4305:b0:698:585c:f07b with SMTP id 4fb4d7f45d1cf-69ab44634e8mr540676a12.3.1783497466019;
 Wed, 08 Jul 2026 00:57:46 -0700 (PDT)
Date: Wed,  8 Jul 2026 08:54:33 +0100
In-Reply-To: <20260708075435.47419-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260708075435.47419-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260708075435.47419-3-vdonnefort@google.com>
Subject: [PATCH v2 2/4] KVM: arm64: Move kvm_define_hypevents.h to arch/arm64/kvm/
From: Vincent Donnefort <vdonnefort@google.com>
To: maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com, 
	suzuki.poulose@arm.com, yuzenghui@huawei.com, catalin.marinas@arm.com, 
	will@kernel.org, rostedt@goodmis.org
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kernel-team@android.com, qperret@google.com, tabba@google.com, 
	linux-trace-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

kvm_define_hypevents.h is used to define the kernel-side structures for
hypervisor events. It doesn't need to be used anywhere else than in
hyp_trace.c.

Rename and move it to arch/arm64/kvm/

Reviewed-by: Fuad Tabba <tabba@google.com>
Tested-by: Fuad Tabba <tabba@google.com>
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/arch/arm64/include/asm/kvm_define_hypevents.h b/arch/arm64/kvm/define_hypevents.h
similarity index 100%
rename from arch/arm64/include/asm/kvm_define_hypevents.h
rename to arch/arm64/kvm/define_hypevents.h
diff --git a/arch/arm64/kvm/hyp_trace.c b/arch/arm64/kvm/hyp_trace.c
index 2411b4c32932..0c7349fe006a 100644
--- a/arch/arm64/kvm/hyp_trace.c
+++ b/arch/arm64/kvm/hyp_trace.c
@@ -391,7 +391,7 @@ static struct trace_remote_callbacks trace_remote_callbacks = {
 
 static const char *__hyp_enter_exit_reason_str(u8 reason);
 
-#include <asm/kvm_define_hypevents.h>
+#include "define_hypevents.h"
 
 static const char *__hyp_enter_exit_reason_str(u8 reason)
 {
-- 
2.55.0.795.g602f6c329a-goog

