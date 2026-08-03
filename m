Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426CE3B6C18
	for <linux-trace-kernel@vger.kernel.org>; Mon,  3 Aug 2026 12:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785760987; cv=none; b=qTGbZuG/g53B8j7eJZ2Y88/md8Eva/tItVm/ZlMmx1lZuoTSdz0PdvaWh+3q2BLwZygkPKA8N07+nSs/jIuDP7RECm0oFDHM3JeUSnX+2GiyVTNgkrumYN4GyrTk6M09JNPd193D0V9ySQclk/nXwUGjeiq8f2mqWej5NZFEhYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785760987; c=relaxed/simple;
	bh=BwXfUSI8RZ5WlNlvsW4Dg8xPJP7duOd+6j4GH2NB7KQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e167fYpCs1+f2mSqJDMQtfRJNgjHKV7NReIlhs9dRvz6ABm3ZOtengXfZ5+nv5NB9lLlAtcz9l4bX40Akfd07Ptt+ZqCeJjONk1/Qn60AN2xOvC5LQTvEF1njl1leVFZj5QCJ22jT7+rBDUC4z5J1DVqHsMMWfWoPwBhZIKJvhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ebv10M55; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ebv10M55"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785760983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/0h+UWlinGdaNRWQ3ePtD6vflPt+g0iOPa3K/aYZ+gU=;
	b=ebv10M550xegZcKAjU41448qc3wUASeRpVTzK5M+vRWQQTholPHKOqF5TXMVZA3FzVxl/7
	keKCBl5SzT98GNFFT2Nat3Kx01ua/TsCqFuJhQBuvzn9atx3Tbw73KD37mivrj3V+Fn3D0
	+rzwlzD80L3EdxzLpfvotGFOALn3Avc=
From: Fuad Tabba <fuad.tabba@linux.dev>
To: maz@kernel.org,
	oupton@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev
Cc: catalin.marinas@arm.com,
	will@kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	alexandru.elisei@arm.com,
	vdonnefort@google.com,
	joey.gouly@arm.com,
	seiden@linux.ibm.com,
	suzuki.poulose@arm.com,
	yuzenghui@huawei.com,
	qperret@google.com,
	ardb@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	tabba@google.com,
	fuad.tabba@linux.dev
Subject: [PATCH v2 05/11] KVM: arm64: nVHE: Run the source checker under C=2
Date: Mon,  3 Aug 2026 13:42:14 +0100
Message-Id: <20260803124220.332248-6-fuad.tabba@linux.dev>
In-Reply-To: <20260803124220.332248-1-fuad.tabba@linux.dev>
References: <20260803124220.332248-1-fuad.tabba@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The custom %.nvhe.o rule reuses rule_cc_o_c, which hooks the source
checker only for C=1, and that only when the object is rebuilt. The
C=2 hook, cmd_force_checksrc, hangs off the standard %.o rule that
nVHE objects do not use, so "make C=2" silently skips every nVHE
source file. Call cmd_force_checksrc after the compile rule, as the
standard rule does.

Fixes: 7621712918ad4 ("KVM: arm64: Add build rules for separate VHE/nVHE object files")
Reviewed-by: Vincent Donnefort <vdonnefort@google.com>
Tested-by: Vincent Donnefort <vdonnefort@google.com>
Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
---
 arch/arm64/kvm/hyp/nvhe/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
index f57450ebcb498..ccc1fe8394094 100644
--- a/arch/arm64/kvm/hyp/nvhe/Makefile
+++ b/arch/arm64/kvm/hyp/nvhe/Makefile
@@ -49,6 +49,7 @@ targets += $(hyp-obj) kvm_nvhe.tmp.o kvm_nvhe.rel.o hyp.lds hyp-reloc.S hyp-relo
 #    avoids file name clashes for files shared with VHE.
 $(obj)/%.nvhe.o: $(src)/%.c FORCE
 	$(call if_changed_rule,cc_o_c)
+	$(call cmd,force_checksrc)
 $(obj)/%.nvhe.o: $(src)/%.S FORCE
 	$(call if_changed_rule,as_o_S)
 
-- 
2.39.5

