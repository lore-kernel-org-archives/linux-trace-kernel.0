Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251B9231832
	for <linux-trace-kernel@vger.kernel.org>; Tue,  9 Jun 2026 04:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780980900; cv=none; b=J5tCZZM6li6mRXkob5FDd9SmM66IgFXLRxdm8qTVsNQ5SlZmLD5uZixe8ObX1Sf9E7SXs6s5Ng0lDcl8D1GCiIRZNZXTOkhrpi+m5IOKoSB1aAKiUwT4Csvi9Vex1q2wxn37bRWaa3WdNLga/o0A2mT4pCUOAYwOS+KrUgE8+L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780980900; c=relaxed/simple;
	bh=KizX8sFFz2IGlAJlB9WnEm5VcWecIe2ZED+jSDyWAQU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=M9erIgSjkUZMWX8k/t2wtxQtzthYxrF/JiSER4GBQt6DWSG6tK6DfF1fX9hwVRsDx+hlQLJqn5Yy8QhfvKtqLPF9+s/C+s78Szhd43tK3fF8PsF/v4SPq03vYyE/+elaHRDX1WIEjsE2qVZC14RuF3fnP9DQNgQ1yRfk0ADWbxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i0bupEl0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i0bupEl0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780980898;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Pd9upImIoa1IQzwIfZbjpbUJtZuuBkcSjLOKstofr9w=;
	b=i0bupEl0jroUs8l16NoeGv5Rqunm52eRvP4SjqQ5FuA8UKBRyGfb21n3RxqzRZ4AfLmXe7
	ZpMgvWCVjNaJiFmtqczU+PoLrKpNUCTyJu9bu+XPl8Rnu7Q+cf58AXEYDx+IDFludWelrW
	pObavy4gXELI1lvoOK+qj7zs5icIsrM=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-fh4SrQt0MRC5v_8pkI3GAA-1; Tue, 09 Jun 2026 00:54:56 -0400
X-MC-Unique: fh4SrQt0MRC5v_8pkI3GAA-1
X-Mimecast-MFC-AGG-ID: fh4SrQt0MRC5v_8pkI3GAA_1780980896
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-5174a236220so101000721cf.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 08 Jun 2026 21:54:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780980896; x=1781585696;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pd9upImIoa1IQzwIfZbjpbUJtZuuBkcSjLOKstofr9w=;
        b=Cu0gpaoeTB1sadHoN0nbnHxx1Vpe5wLZ7SW7t0XQmhmMg3/b8qrJ1tZYiR6HMlQoZV
         QkKNCfYSqEd2dDVsFjWtu3AoRhN4XCMI+t8tHL5gP9Ez4uX/zV6J5eI3f3xUbhBUDer3
         0Peeq5LS9c4eYtrjPTSEne6dTy3Tl5OWjZJWYhqNHgWxywEfSVd0Op2GF6uNr8z+SKri
         UsZsxUsAJdY/1F3gVCsqAWlnReBmVNVUuDbnWi6Ba6mS/GL0fzAjv4TSSY/w+rAAPVR8
         e2/gezWe44VSkYszoZ5VPeN+gtZFJRAI00x6RTsNGGqLuOsxvxASI9byT9C4SGLj4WiB
         9NpA==
X-Gm-Message-State: AOJu0Yx0uyb1Qh03v3CIJhCCmrdTdPcGI0w8EplJx/lWM8jkNynrQNgi
	cYoiT/NRQhHSp9SLg9a80pid1PTu8W0DHan/BXiIgdY9jACchtLogN2ahXojU+fQ0D/J/RlRkL1
	9JwY39AIwgD3QifI4o7yCMYR5F0LS/hcwvmHZlvIlfRxSHfI4HB/cI0wJQQ+bZXHacatYlgekkg
	==
X-Gm-Gg: Acq92OHS7pelDKQ3QfERF0NtkU/FJ/Uh++XHFCMiHilCD1l5AkdQ7iFp16UY9tbPU5D
	9iyVGs9BjebRMwDrbgIymJAOvLblb+cff2jtDR4Jc3aiyxb1bGIl/G5ID9dgFNKs6etR9xG1uvT
	Sx/rVXp779SWdazEm1YTR+4PAeawUsfe70ea4wKeUkjNYMFLdvmSZK+nJdx7XDHeIZcw/fsGWW2
	t8cFtpIcSde8fUK45svXHxFWMsjNn2kRTDuDLmqKWw/3w1j7E95kmUoHIglA9/ng5xK9mjFpwp1
	25BaHPHtdXGYx+13+Jias0tUJfHV6XWG2Y0tE5k+hV4K46RFnSGsIIKffkQ5Pw5vh+nvec9ABdG
	aK9oUA4FBTNKXSMBw/HCmJlzk6MrB/AHWibzVaRiSGkCwrl1+sxJMrPBcOkfiFGsu
X-Received: by 2002:a05:620a:688d:b0:915:b506:56cc with SMTP id af79cd13be357-915e822cacdmr147086485a.7.1780980896157;
        Mon, 08 Jun 2026 21:54:56 -0700 (PDT)
X-Received: by 2002:a05:620a:688d:b0:915:b506:56cc with SMTP id af79cd13be357-915e822cacdmr147083685a.7.1780980895723;
        Mon, 08 Jun 2026 21:54:55 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([2601:447:cc81:56d0:ab94:b2cb:29a6:7ac0])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a402ff9sm2014889285a.45.2026.06.08.21.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 21:54:55 -0700 (PDT)
From: Crystal Wood <crwood@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org,
	John Kacur <jkacur@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH] tracing/osnoise: Call synchronize_rcu() when unregistering
Date: Mon,  8 Jun 2026 23:54:30 -0500
Message-ID: <20260609045430.1589786-1-crwood@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7--eTkyGfJXhI7Qm9LyDBrcCK-hVoIhDbXTYKEbcrZM_1780980896
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

This ensures that any RCU readers traversing the instance list
have finished, before releasing the reference on the tracer that
the instance points to.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Crystal Wood <crwood@redhat.com>
---
 kernel/trace/trace_osnoise.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 5e83c4f6f2b4..0e1265acd1cc 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -179,7 +179,9 @@ static void osnoise_unregister_instance(struct trace_array *tr)
 	if (!found)
 		return;
 
-	kvfree_rcu_mightsleep(inst);
+	/* Do a full sync to ensure that tr remains valid, not just inst */
+	synchronize_rcu();
+	kvfree(inst);
 }
 
 /*
-- 
2.54.0

