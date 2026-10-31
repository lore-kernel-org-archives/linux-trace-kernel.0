Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793442349;
	b=Il7PBoZ+BNM+yRZvD6e8ybdMyvBb9fqa6hlWWJkMxGZnPgQfeqm7Uf3jyWlQZ5abygRN
	 yPjHvcinF/BloWycj1Iytfq3MYt9EJ8EieKfZt2se3yxJ0vE6DIgxosWIwDnvI4jnUhf0
	 HdIM2HMpVnyXCB54WgSS9Qe36wpETnTdTxAb3i/kWsQPM+XF2pbzUDCQzURERzl6T56na
	 eNtAjSF/vnpXq4r7DvE0pquFDdInRNKg1PncFN3tqe7na8c5i2dsyL4m1W8emfmrgmulQ
	 uYY295BeRDBOnpaJ7AKEota65FJ/A82CYJuzm0gcKJKvBVR8xNWRtN20Ai95Id9Un6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793442349;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=7yVmIuop4gnsPfbSLW6KTepFf/okMUAMYmN1g1+o1FQ=;
	b=eRyvvW9lcWGkJFZqH8a59wYE1pMWXYulvbHvmSDQXCS0fTWd40D42lDTxFaipqLBgd73
	 8B89KHLn5DE0mYEabjJ7BRw4dF21c4KU88OSCkofd8234qsdfEyk1pmUmojsAvLW0fYPQ
	 Dx1TVPHW5zLtJPF5YurMz0H1lcJTEDRas61dVedncHH6x82M8Exir542i1EhlY232bhkF
	 ggn2N7wGTkBQSpOQQsaITQoZJJnevW5PtPZa5tX5BFHsfPzkkf05lxuPsI8hLefAvrpjO
	 FfRbPRvJHJEY7SaRcGxiPB2Y6xURGSkHqJ+UpkfFgE+RdkegOxvupcj0MkcLvGRlT+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aDrysK9X;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD36A606A31C
	for <linux-trace-kernel@vger.kernel.org>; Sat, 31 Oct 2026 10:25:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD36A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aDrysK9X
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a5b2be99a8so9439015e9.2
        for <linux-trace-kernel@vger.kernel.org>; Sat, 31 Oct 2026 03:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793442347; x=1794047147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7yVmIuop4gnsPfbSLW6KTepFf/okMUAMYmN1g1+o1FQ=;
        b=aDrysK9XtMByDqlPYhyjkKCi2TLyC2moFntn4CYFUbAnVC2HRTL2JAU0qZmvPZYyKL
         r+hfeQ4QebXQg9U00GN5jkoBvFjaherbdm8zE8hcyRpZonXsCuIaKNkZXBPV0W3Wq+ZQ
         k7n4SRMb3Idy1ZG7SeFaYQGB2tMmF9J9LeUv7C837LqeNeXJ495njbegamdStcUVh/jd
         rydSv6oDaW5UO+po/BN3ha6JR49sndZBtLsAJG5920zKndYytYxKrUdjpbZjZ/q6a1lU
         QWvp1szLr1vCSuiHv/lyd/oLnTs8dDexjSWyWj2uJ1psf0qachRPL5038Q8JbNlTX4c3
         NpSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793442347; x=1794047147;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7yVmIuop4gnsPfbSLW6KTepFf/okMUAMYmN1g1+o1FQ=;
        b=abIJVKfW81oapE+Snhsr5FbtqOVQoClo1+rTLlXXmSxhV2nsgD3J/gsDjA9yiC+sMg
         A293AXllrOdS3isN5Vtgi+aOLP74Jwbib/VKQJ0neAdVXjycDoIlmpItwbR6wJWmR8dC
         91M1Qejp1FLl6mBWLG+Qu9GXZTRj7q303t+MsKNCn8iTC1dR46pyttnqPfL+Iu2YnDNN
         bi2Yy21wi0tW7YisdAfcthGfIyI3xx6jTdOwsuFyprWIdiGFFHrlBxKB3PvI84vuCGH7
         iLoQj+wkpV6t5LAjONfarUr2oFp8tg74R1g6FX61TpVzF66HvrFKWWsz17Zk6DVuSlW4
         mK/Q==
X-Forwarded-Encrypted: i=1; AKwUvBxjN9GJrC9y2m+mW0qrk7dLYWqd5newTfyDA6mVI+zDo0YiS1nHe+ejIWV4mXK0e5Va4AH+NPWLDqTzu1B1JShVvyg=@vger.kernel.org
X-Gm-Message-State: AFq9FYINibb684i1NAE+JsSZwto7WTwssVAnNCc50tqwAAoLduwz/Y8q
	MxllNLGbNgGf44/aMXJHhjWilio1iOMSnLMZafdVyShuNbvQEIl026zX
X-Gm-Gg: AYBFou0OXb0+YZk1ayfP0Q/kVnfEaoYpMZIOyvWXvIs8Md9812QGjyzyHpqLGIDof2K
	R0HTNWtc1t6ArBq3t3etNcJYpuOzJG0I59sASPG3A6VNsmGtqyZOb9Tp0Lnc32Y1NI5p0BO54/b
	ruf2lkN3mjoNpNkIBotD8mc3PHh434WNVUmFMK9MGrPBlN+TLqfuxVpuLPUbr8xSciBAdWl7QcT
	hLnG5oX9ra+AHUZHrT9yqLIrNW/8CX8GTcVHh4GKdaO8eSDo+I7m/OnWrguoHuyMPjev3qAdAOD
	OkVhzwlim6OHXB5AS7sHonLQPJuK1pi8HT3URBj4y10BniOkLUYdCp2yuajrq/A3A9QE7KZzz1c
	3Vda5LM9gadIFc3taO0lQuH7bOiuW+3fBJ+1Vjv/S4sHj+YSlE6sWjjNF4YEN4G3WOmm+vRCEwM
	BC3KtiU4jBF7wdws7om2jW8TUmJxpCs+pDC3sVYi07CxRTXfZw+yQvxtu078wS3GiVW1dtCa+Nw
	DBg/924EtytizUxjWYp8dXDzAv7+1U+FwwLPUXa1LuUCATZ3KzeOhofuQziVos5QqHzWfHI6znN
	YWLcmLtZ32Uu3sxQEwcPbzM1yIxSM+utmerVranvzYCc1LufWPtjejmlPG9pYPrn7QVear6AIr/
	4kr+mYUTTawpsmNW4d4nNZPpmx5faZpipvB/aLcth3k51j3KAR+8QZ9UOPRBcjXTY3k+uX1Bt6t
	CiGUwLIHTqezc5FlSFXl0w6XuzBk29BzN9k2+DhG6nYSUCdLWHCr7+qvuAVw==
X-Received: by 2002:a05:600c:19c8:b0:4a3:59c9:a743 with SMTP id 5b1f17b1804b1-4ac1913ef8fmr108040225e9.27.1793442347043;
        Sat, 31 Oct 2026 03:25:47 -0700 (PDT)
Received: from longitude (2a02-8434-fda5-4201-994c-f615-42f0-2afb.rev.sfr.net. [2a02:8434:fda5:4201:994c:f615:42f0:2afb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa7f3229dbsm195363135e9.1.2026.10.31.03.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 03:25:46 -0700 (PDT)
From: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
To: mhiramat@kernel.org
Cc: rostedt@goodmis.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] tools/bootconfig: Preserve tracing settings during export
Date: Sat, 31 Oct 2026 11:25:30 +0100
Message-ID: <cover.1793442331.git.edumucelli@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1793364709.git.edumucelli@gmail.com>
References: <cover.1793364709.git.edumucelli@gmail.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Masami,

Thanks for the review. I've updated the event-filter patch to use the
explicit delimiter pattern you suggested. It now warns and skips filters
that contain delimiters and both quote types, since bootconfig cannot
represent them. The other three patches are unchanged.

Changes in v2:
- Patch 1: use explicit escapes in *[,\;\#\}]* for the delimiter check.
  The semicolon also needs escaping for the shell to parse the pattern.
- Patch 1: detect both quote types, warn on stderr and skip the filter.
- Patches 2-4: no changes.

The series keeps event filters, generic trigger counts, histogram
variable ordering and paused histogram state during export. It is still
based on bootconfig/fixes, including the two fixes you picked up earlier.

I retested the filter change in a temporary tracefs instance on my Ubuntu
machine, running kernel 7.0.0-38-generic, with recording disabled. I also
checked the mixed-quote cases against real tracefs filters and added
regression checks for both quote orders and all four delimiters. The
fixture checks cover each fix and the full series.

Feedback is welcome.

Thanks,
Eduardo

Eduardo Mucelli Rezende Oliveira (4):
  tools/bootconfig: Quote event filters in ftrace2bconf.sh
  tools/bootconfig: Export replayable event trigger counts
  tools/bootconfig: Reset histogram variable tracking for each instance
  tools/bootconfig: Preserve paused histograms in ftrace2bconf.sh

 tools/bootconfig/scripts/ftrace2bconf.sh | 29 +++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)


base-commit: 1dc6d173c43e10a1d0ee36b43d0d2f371f4d262a
-- 
2.53.0

