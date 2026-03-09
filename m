Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9E53EFD2D
	for <linux-trace-kernel@vger.kernel.org>; Mon,  9 Mar 2026 16:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773073586; cv=none; b=jgFpgtil96+4S9N1RBc6GQNhGxtXm905yjYmb6CiHJ0iVTG8yMV/HX5xl7OrIi2tMMUnEISY04ClWwzt3vOA7nbnbeAaVZZcQlrJneFC+U7T7IKSrqTUQxEJn7I0TY9iBKzrdUTwgOZVVRJUBvjBFFDEW5oYtukg7LV2E/iNNyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773073586; c=relaxed/simple;
	bh=cWmCVGc8Z9dVFyLjcgMh+d+QoVHI1pxbCmuYrrytJC8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CZeQqwmxyTMmTY/Wd7vxdtyrpI2bSXcZAXXQIoaR7+eqmB4SEbjl4RqA8q+HZXW54uNH0jXQ8MC5yr4REonwvRsaWA8jsIPF1kVFHhoAZHr1Wcp1HV/iG2z1/P05EZ4lXHT0lYbzBkdkxZIGRxf3bVu3iqMPZcQMUwn+UxOvKx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Rr4Mvjk5; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rr4Mvjk5"
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-439ca4b3d0bso4329074f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 09 Mar 2026 09:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773073583; x=1773678383; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+KUjQbuHQJ21p2RQALWJdLghrvcyrBZVXJ9cfGciG9M=;
        b=Rr4Mvjk5clq/NiJCOv1MJSrHij6vyB8Z6AvuVJKGjdGzw98eO1OyHrvTTdwAC4OECT
         op3CtQeVBxCg5T9ytXA2mDEKsl0Zuli79ojGcG1AVZeIMfVdjQ0nFO85JMxygQK8wQ7N
         C/eygDj0ojMoJ04rIBijfiZ0Fl5clbp/n1IDf0j6T94ydsptr9MMWGnrq/eE5fA7KDGI
         K7Q9C26G5JNqL4RCTm/f6NGh2VEI/xorlurgvpiH9XMbdpjPhGh5Vv1JoHXuXsIAuciP
         29IdmoqokcmeyMFEN+l4S2S6ubUsMbCzZ3b9/UDN60q0DSbjE3/GP4wBCZaL5DPmxWOD
         skmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773073583; x=1773678383;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+KUjQbuHQJ21p2RQALWJdLghrvcyrBZVXJ9cfGciG9M=;
        b=vjk6YrXKOsi9PLjEU75gN8sHbxii5DiYVByG0EgJNx4CCuE3s41i/InoFCKjnbQ6jw
         PGAulga5NGWWIY8q272SM8YB7Gp6tKGIxRK//xM0vO5FvNICjiyUajhYWrIjIJsw34uS
         B0paDCDG/hEk7PIjJCNVE/abOJnIRPZJgRNmZHgptfA/kIUw7h0pqwiOImASJ6msYd4i
         qxBi2kaFOTeJgFP68BeKDH0YqgDt+1JVSuow2fNmyggWeNmM5gb3xmtPUUutqKEya6H8
         Kgh2/DEdspbBOk/99GzWrtp04976FSD1I8ZmYbsP+7UBlDZHX52N3ICRYvXAYUdXufi8
         uMqQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6CxarHM39tD5+Majin1mQ/jdSFsXsjSVYifsRdWpSRGXpqn6PYsj47ZhsQ6aTBafxmS/5s/6OjFNbwdvQZJi+S/o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9IPB1WbDpz18+i5N2uj+lUm30L/nUf+P8BF4mFHivTnR1mBV8
	xJ4i2heHLxr4+SiF4UIm4Ndqpnfok2Pce43zPfcWSWUhh3ipYuCjucQyJX5rMuVgxSGlje0wV+N
	65k/q1rIqiPWobFsfnAAMBw==
X-Received: from wrbfu7.prod.google.com ([2002:a05:6000:25e7:b0:439:c9ec:823])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:178f:b0:439:be3b:ddb6 with SMTP id ffacd0b85a97d-439da653249mr19834479f8f.59.1773073582885;
 Mon, 09 Mar 2026 09:26:22 -0700 (PDT)
Date: Mon,  9 Mar 2026 16:25:08 +0000
In-Reply-To: <20260309162516.2623589-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260309162516.2623589-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260309162516.2623589-23-vdonnefort@google.com>
Subject: [PATCH v14 22/30] KVM: arm64: Support unaligned fixmap in the pKVM hyp
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	jstultz@google.com, qperret@google.com, will@kernel.org, 
	aneesh.kumar@kernel.org, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Return the fixmap VA with the page offset, instead of the page base
address. This allows to use hyp_fixmap_map() seamlessly regardless of
the address alignment. While at it, do the same for hyp_fixblock_map().

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/arch/arm64/kvm/hyp/nvhe/mm.c b/arch/arm64/kvm/hyp/nvhe/mm.c
index 218976287d3f..c98cec0c150f 100644
--- a/arch/arm64/kvm/hyp/nvhe/mm.c
+++ b/arch/arm64/kvm/hyp/nvhe/mm.c
@@ -244,7 +244,7 @@ static void *fixmap_map_slot(struct hyp_fixmap_slot *slot, phys_addr_t phys)
 
 void *hyp_fixmap_map(phys_addr_t phys)
 {
-	return fixmap_map_slot(this_cpu_ptr(&fixmap_slots), phys);
+	return fixmap_map_slot(this_cpu_ptr(&fixmap_slots), phys) + offset_in_page(phys);
 }
 
 static void fixmap_clear_slot(struct hyp_fixmap_slot *slot)
@@ -366,7 +366,7 @@ void *hyp_fixblock_map(phys_addr_t phys, size_t *size)
 #ifdef HAS_FIXBLOCK
 	*size = PMD_SIZE;
 	hyp_spin_lock(&hyp_fixblock_lock);
-	return fixmap_map_slot(&hyp_fixblock_slot, phys);
+	return fixmap_map_slot(&hyp_fixblock_slot, phys) + offset_in_page(phys);
 #else
 	*size = PAGE_SIZE;
 	return hyp_fixmap_map(phys);
-- 
2.53.0.473.g4a7958ca14-goog

