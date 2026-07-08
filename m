Received: from mail-lf1-f73.google.com (mail-lf1-f73.google.com [209.85.167.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8939B3F8EC2
	for <linux-trace-kernel@vger.kernel.org>; Wed,  8 Jul 2026 07:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783497472; cv=none; b=AuqXXpbFTzQfnQ7CPgunZWBOxkupV9cpJBWucVZ6dXKKscC74gRPZNtgohj66DKHVmJdcNHqiKoC9mS2cdQZgiCbd/L48nBtb+5ETu+lzQfuQX3KsnAEd2VU2Avri5jv/gxTt64I7mHq50E8UXAaRjjRfh5dX1J/esX8lR2O0fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783497472; c=relaxed/simple;
	bh=C9lW5FtsNFxHad90kVAIzueR+ooJaPzexhKAr47w/Sk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tnHcYXMBChVgEypk2WKvvzY+6vMBwuv3MEfTBKmP0Ds0b6VUH4JmWesUSj9foGLsuIaiHPieovUPJj/lT2Eulff27jeBq3cD+V7OuZqPwNAH8qzYKcAuwyN7gYCbHYbzrGOateuVZ9cgCnCguhIrxAkPwLPEBuhSUnFegdakoIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eBS0mC55; arc=none smtp.client-ip=209.85.167.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eBS0mC55"
Received: by mail-lf1-f73.google.com with SMTP id 2adb3069b0e04-5aeb9aff688so331300e87.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 08 Jul 2026 00:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783497465; x=1784102265; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oAzLQ3gzA+KnrCzUsFBoGBhVOWJwQaHovl8NoBHBi/Q=;
        b=eBS0mC55t5zQqHgA6EdURvmi1uDBcY6PBKv827/q2WlOdv/DKtUuE2iqQfWJ/Q4eM1
         gCOtmrNnBjpg9/1SQ8+vKUTBcPlTOfpixcvR5ucq1ZoEZR1U5TnpruoaY2g7MsafrGUV
         z1XlWeovQL1LpmJ80p/eyERT/MKa9yI3rpmwt5PpaCShn9Arqlt71UCSPHXQnpOy9+32
         6bjB+o33uphiCzTRglT98Jgo76doKe7PSfKw5nEiQaDTs7Ba8kG0vKjUKRcWA9t4HApJ
         XDaVxSrfaFd50NAy4uE+0boZ3u3MI+kP3ytdZBLsZyxtt2ap0hN2s4Vfi1uLFutLdjzQ
         UtbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783497465; x=1784102265;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oAzLQ3gzA+KnrCzUsFBoGBhVOWJwQaHovl8NoBHBi/Q=;
        b=nfFHjToMpFaGPltPg2Et4MsfYs8KoD2zrjvAhEFPciUjpWI3fJIbMT/RI53hOiPBb6
         bCNGOz2lvh5Kr/1yuVCsrumGJT0x7l2k/NUy3zNuzwK2zI32zbAEJ/DGGfUP/NIs/MWW
         M23YJLyaegVNK4KiRoa9v69dHT7XyP5MmPGcSsx/W4bR/tzYTF3naDVix1khTTIQBiKn
         j+vJMObzwwfJV2xBn2vGb3XnO05333833iaxHi4S5qNKXvq0JI7D5av7p1HDh2M/LiBu
         9ev03bta+QrpUosHWdiPw/5b/2FYR4d9MqjERgaZvAU2J0TcPatGjNJaac2hB0w3VBRE
         MeYg==
X-Forwarded-Encrypted: i=1; AHgh+RpZpP/vM0JmJmiN8a7h+E0pZ5keWOsoRgcqhKki2o8aWHdxrWCM3DE1SlWs0ARKMZM+fpKOBYwrsJbiXml1C5Qz8ws=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOixgX/RrmhvY/fJSO3aExLCJ96593iHaL2VTn3Q8hESiSC99t
	czmRRCBrTea4yhb5T/0r2pR8bTKyojsQJ42NMbr9JY/vsXAOvhq/O8HqxuQaeu/OBlD6b8GL9to
	SK0x5AapoyvLk+ErSUNJZBw==
X-Received: from ljic3-n1.prod.google.com ([2002:a05:651c:2343:10b0:39a:fb7d:982d])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6512:3b20:b0:5ae:bb35:c956 with SMTP id 2adb3069b0e04-5b011497d66mr431084e87.56.1783497464617;
 Wed, 08 Jul 2026 00:57:44 -0700 (PDT)
Date: Wed,  8 Jul 2026 08:54:32 +0100
In-Reply-To: <20260708075435.47419-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260708075435.47419-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260708075435.47419-2-vdonnefort@google.com>
Subject: [PATCH v2 1/4] KVM: arm64: Allow early calls to pKVM host_share/unshare_hyp
From: Vincent Donnefort <vdonnefort@google.com>
To: maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com, 
	suzuki.poulose@arm.com, yuzenghui@huawei.com, catalin.marinas@arm.com, 
	will@kernel.org, rostedt@goodmis.org
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kernel-team@android.com, qperret@google.com, tabba@google.com, 
	linux-trace-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

The hypervisor tracing for pKVM relies on the __pkvm_host_share_hyp and
__pkvm_host_unshare_hyp HVCs. In order to start tracing as early as
possible, allow those two HVCs before the host is deprivileged.

Reviewed-by: Fuad Tabba <tabba@google.com>
Tested-by: Fuad Tabba <tabba@google.com>
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index 043495f7fc78..fb049c40d04f 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -89,12 +89,12 @@ enum __kvm_host_smccc_func {
 	__KVM_HOST_SMCCC_FUNC___vgic_v3_restore_vmcr_aprs,
 	__KVM_HOST_SMCCC_FUNC___vgic_v5_save_apr,
 	__KVM_HOST_SMCCC_FUNC___vgic_v5_restore_vmcr_apr,
+	__KVM_HOST_SMCCC_FUNC___pkvm_host_share_hyp,
+	__KVM_HOST_SMCCC_FUNC___pkvm_host_unshare_hyp,
 
 	MARKER(__KVM_HOST_SMCCC_FUNC_PKVM_ONLY),
 
 	/* Hypercalls that are available only when pKVM has finalised. */
-	__KVM_HOST_SMCCC_FUNC___pkvm_host_share_hyp,
-	__KVM_HOST_SMCCC_FUNC___pkvm_host_unshare_hyp,
 	__KVM_HOST_SMCCC_FUNC___pkvm_host_donate_guest,
 	__KVM_HOST_SMCCC_FUNC___pkvm_host_share_guest,
 	__KVM_HOST_SMCCC_FUNC___pkvm_host_unshare_guest,
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
index d3c69de698f4..361dbfe2e832 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
@@ -740,9 +740,9 @@ static const hcall_t host_hcall[] = {
 	HANDLE_FUNC(__vgic_v3_restore_vmcr_aprs),
 	HANDLE_FUNC(__vgic_v5_save_apr),
 	HANDLE_FUNC(__vgic_v5_restore_vmcr_apr),
-
 	HANDLE_FUNC(__pkvm_host_share_hyp),
 	HANDLE_FUNC(__pkvm_host_unshare_hyp),
+
 	HANDLE_FUNC(__pkvm_host_donate_guest),
 	HANDLE_FUNC(__pkvm_host_share_guest),
 	HANDLE_FUNC(__pkvm_host_unshare_guest),
-- 
2.55.0.795.g602f6c329a-goog

