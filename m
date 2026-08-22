Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0863F0A9F
	for <linux-trace-kernel@vger.kernel.org>; Sat, 22 Aug 2026 15:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787411369; cv=none; b=TAeGuwbbLabdQ6+16Uu5swJWUNT+BJx2m26vQK6b2rPHtUPrMODSmRZtT5PYE45bgEIBOkzG7LJ1DKWhJtbFcOY4mfiE2H1kXk8YVtg8qi5E6n1kHOKIwKplht3zgl4eW8dr+9YC8F98Jm+CsCi9/ebTLGHwayRtdcQXZ/XvB1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787411369; c=relaxed/simple;
	bh=IGYS9/MJmi0crQrMqbiomdqqv5fS8S+rJ101ghPw26E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nrtdl+dbmmbxtrUBv92mPzVotMyu1EiQIqxUpDjBIpklh2y+LDiDgq1ObdAikGJwDDyj6KNy1duD4JTyHLjXg2WJOPvi61OAmSjKL45MjOV3kyQquABaZWoVSnUBNfWXwkZPcEiMALenJjZZ3B6JTlq07yD2kxCA7y6wRzXIlHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YM7SrUrt; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YM7SrUrt"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-382ef647e20so2068136a91.1
        for <linux-trace-kernel@vger.kernel.org>; Sat, 22 Aug 2026 08:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787411367; x=1788016167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xN4hXMOwbHYw8YYoHSGskBU1Hru9hAdLN66h2VVXOns=;
        b=YM7SrUrtYAnhHYAaeIsAdACdKCoehgVqosn8VSUcPiYv7S5UXVIE6/f/GWmYdyLSSg
         olfwtyOA0EzuPMwWoMVN0TpOMYvpey2qY18eUwO/6fSPYe4Ni5bjfMZYwMRRGjoTJj7e
         obec/wGWWF5/P0/9Qx3eOxU/6pVaixqytZbrsKtf9VFK1DPC+ekED/+tjgU1NZbW8hhP
         NZR7cWUdjp2Qx46Hzqcl7rk340Nc6xoQRYOQDf7FkN1wqTOeElXbu9j+Z2KsBjB002If
         11ybhfHXz3RpfqT9LnZVryktLlPdV7qsRhvlC/EDjEUhy8oKJiNB4Jxa5o6sRnshBEgP
         lFsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787411367; x=1788016167;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xN4hXMOwbHYw8YYoHSGskBU1Hru9hAdLN66h2VVXOns=;
        b=gneUcxJnQmyT1ua+AadcHgPBAMczCKI20fl6EHKEhjzJHiQ/5M3IUJJxl9il155rbU
         7eY7pBGIFINfPfK0aLyqjHG7CGg4zy6QpLjYma28kA5odKpUigAP7idHc0wt9DFQFkUe
         Stb8uIzJGO1+xzviMsw+RKwX2bHtKA3EcIJMpb6gXO6z5zZr9of4NCfHEE1re8Jycqsj
         6T6a+i2nszg+MOANbvZwx8u41UsUhpD9mWM8TiJjHG/dtJHwV1Trbev5zeQYSP3KHN+0
         wgQ00Wez40fbzLseZTH5+qCIYx7RI3eROJ81/YXzRNu67xW8B/bmo/00O7Kwxb0oaazh
         CMmg==
X-Forwarded-Encrypted: i=1; AHgh+Rrxbb3aAdYkMHAxq2DN6n+Lg0WwzLv0hhsitzaKZTtQr3CnL1ARj0Dr7TrB7+iTM7Q+A08wjTAmmgh72aGJSrWw0P4=@vger.kernel.org
X-Gm-Message-State: AFuF++nyVt3QxjOShquJhm6k2Z1Cui1sfZzdOFudKd7VlDRlIebEbi4u
	fL4jK5qUKov4r1qSda1siJNlafgV1N/L23Q81YXyCzbWLsG4Eu5Msixx
X-Gm-Gg: AR+sD10v856RjqpLAg2IdR4EwYeaKQNJB8384O2xlDjPvKtk9tGnVLtn22bxqz30LmT
	cIS9BJxQSEAAFsiz31h1U0gngF6khO8GB/nuQH1wV+nVWzPdDvfEACLcXGbwilcer4H5RhSN3H9
	EtQP9wYez5qFyFM+subsLdT/mNqgRkvJV8WhgoKQHIHfgUNpCJPedMvrhYtxserimoO47nV8scE
	MTAyhyEC6Lr/YXYT6t+E8zRSx7JWdDeZQyTnGxtYsKFtEKYg//DTODxFW1422TQRic8jcRQl+ZH
	UQRVlanqpE51fKcC43yFTDetQ2k51opBIVGBZnSEPmzOJGAU4/hm3vC9ql1YGORRiIYyZaPWHFV
	nV5g2nWMP0y0GOBv8p9P9c3P2r3SASUZKOUUlFht0/qAviCrQU2wfV3xyBO+dqVlqBBfvOKm9P3
	SRiI8Qlokle43EKcFl61t7LhyxSa5y4i889+vv7PsOr46VVk412oj0AM2TjjoIGKZKjiYqOXr1u
	o+3TWfG2Ce6nf5tUwKEgKo40g==
X-Received: by 2002:a17:90b:2cc3:b0:392:e5b1:d833 with SMTP id 98e67ed59e1d1-395df29666cmr11845108a91.13.1787411366593;
        Sat, 22 Aug 2026 08:09:26 -0700 (PDT)
Received: from jvle-ThinkPad-X1-Carbon-Gen-8.. ([117.172.228.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1418619d6ecsm8057043c88.14.2026.08.22.08.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 08:09:25 -0700 (PDT)
From: Keke Ming <ming.jvle@gmail.com>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Keke Ming <ming.jvle@gmail.com>
Subject: [PATCH v2] uprobes: Free utask on dup_return_instance() failure
Date: Sat, 22 Aug 2026 23:09:06 +0800
Message-ID: <20260822150906.528208-1-ming.jvle@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260822054620.452262-1-ming.jvle@gmail.com>
References: <20260822054620.452262-1-ming.jvle@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dup_utask() installs the new uprobe_task in t->utask before copying
return_instances. If dup_return_instance() fails, the partially copied
utask is left attached to the child task.

Free the partially copied utask before returning -ENOMEM.

Also, dup_return_instance() copies the return_instance before fixing
up extra_consumers.

Here, if no deep copy is needed, clear the copied extra_consumers
pointer.

Signed-off-by: Keke Ming <ming.jvle@gmail.com>
---
v2 changes:
- Clear ri->extra_consumers = NULL when old->cons_cnt <= 1 in
  dup_return_instance(), fixing a potential double free during
  cleanup.
- Keep the dup_utask() error cleanup from v1.

 kernel/events/uprobes.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index b25531331902..73a6620c5701 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -2118,6 +2118,8 @@ static struct return_instance *dup_return_instance(struct return_instance *old)
 			kfree(ri);
 			return NULL;
 		}
+	} else {
+		ri->extra_consumers = NULL;
 	}
 
 	return ri;
@@ -2140,8 +2142,10 @@ static int dup_utask(struct task_struct *t, struct uprobe_task *o_utask)
 	p = &n_utask->return_instances;
 	for (o = o_utask->return_instances; o; o = o->next) {
 		n = dup_return_instance(o);
-		if (!n)
+		if (!n) {
+			uprobe_free_utask(t);
 			return -ENOMEM;
+		}
 
 		/* if uprobe is non-NULL, we'll have an extra refcount for uprobe */
 		uprobe = hprobe_expire(&o->hprobe, true);
-- 
2.43.0

