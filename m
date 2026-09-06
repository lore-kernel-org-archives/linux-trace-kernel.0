Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8ACC3909A6
	for <linux-trace-kernel@vger.kernel.org>; Sun,  6 Sep 2026 13:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788701646; cv=none; b=tqm44Xt1dQo6ZSp28W/BpJR6e4ryhTSC0lzAufSzJ02LORCnSt8eXvx1pXMvb6ZQoccIBsIyA2YVmaX4g0mJyFH4AVw7sToTgPrJMn5DXV/flFJ+Pvm37zX1kxULpEzVhpRby+8hGnUH+u/nFt/ZjrRh4ws0T4Dzmqh7oMyp0y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788701646; c=relaxed/simple;
	bh=OmrnDvEUGlBTtRmQLeMuelKWG/ZFqM9c+ArC6f2Q3Pg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g0W8e9UO9K0rjEorKXr2HGEAcqlzjlTygFnltdWv/90odLNmkArhV6MyQKK64IiAoP7vVIpi6Bx3n5ANJ4BnRm6o58yQpT8JQQbGji9nQ2YeQgbCGkmSboZvZNvTCxs+dGlYjo06RFUnkYIIKNBp0yhGTpJQoQRh3qiUFroGeu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hIopU0sX; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hIopU0sX"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3966791a6eeso3154008a91.3
        for <linux-trace-kernel@vger.kernel.org>; Sun, 06 Sep 2026 06:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788701640; x=1789306440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Fa5UOAWLkyriWvd9QAh8ho2PSU5MrwWqtM+f95UnuKM=;
        b=hIopU0sXNy2NO5d/Rgrpj6GqD5nkrSMyXk40GCa7M9Lqj0CTaVRmGu5Jq+lX6ppZPn
         I5FmsLPSY9Gq4XRIRCBB8GgcJKsHOWmecaSVhKcwy3WCXCl7oycqv0pRZesxI7WbG0cW
         r9RppUtFghEUBf6boxvGLZzupqKxJVerWMnXWyTNC55e6b8Sh6xGfvhj9dHRudDuWTHR
         VS7Hm9ksXB058pIDL6L+rsQyvjpQZw7ZXZBvNKR6tea/JsnwteIS+q1u5xv5cZ6vX6pB
         nFAdqzDaoGrwQzxespGOmMUfwJAxOuXhVWAIdKfRR9pyViHls3wSd+Y0bDU82t12qUJS
         VyuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788701640; x=1789306440;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Fa5UOAWLkyriWvd9QAh8ho2PSU5MrwWqtM+f95UnuKM=;
        b=kkhJxz+ehSXsQH7W6DRskueSQDyKRxgBjoipTQT4cVIMaa+MlapbmP4wR5GPfa1CO6
         +241KeJDQZK57uJ6b591w4K9h2yrezQVGl63TKnIgoV+N7u+EYh62lMyxpvukoARVZTv
         rn1vIkN4fycNIA6r3VqAjCSKYMh4FjRnwLrsg5tHTLCMRzUzgG8TDLBDUCKJ4Sn6URFR
         hBWQ1iGcdfUQ/jYMCYssMtc2+7v88lTEz+aVJrhCgxUWZmBfaeB1f3pOrdMUiMvy0zG8
         znOaSnIZrVePcbKIrTKkbrRPcVqvSlyUmYFhfamasx68SAHUtnLDIaF65fTU7beZ7tjv
         bxWg==
X-Gm-Message-State: AFuF++nAND2ixB9GdAfeG+O4dDbKBWRqY7Fx7/aIdR2awaS6IaydmcCs
	skPQSMFNhD9wILwWr6KNn6XKuy8dbOzpAOiZ1XCtIKK6ziaoHJRJAa0=
X-Gm-Gg: AYBFou26Zqw93bOmNfsF+kXaVnpZNtkRSGC9YNBHKeIyZlUZ1XLwG/ADGV9ZF7i6WxM
	W7adGw4H7K4ovFK9HNL3rsN5CT7G7hKCKdiOTAMr+4oKu6CLrg4HO+qkGPFhWqkDBjLmyVkFUDV
	gbcPFiWnNI+Fy7LQ6rOevfjZ+bKCcZssRHIVNa4SnyZ1SdmCQ9uyTFahWZPbvKThFkJm0phsE0e
	isseu0hpDwhzCzvKDBhRam2TxngV+3uRpG4kh5BEKE05JZVT1d1zohUizri9ac+KTFW6FLZ69iA
	iEvb0SginbNNbOf/GZUCcm+T1rA8UHXkv9x5xUMLfbAu6w4fYj40FXzYjdR9xb0Vpvl2z2XpwkA
	hnxs/GKAV4vyD24LCFqJr+s/fMsCGD5OcX6z8jfV0YwjThEOSeNW61LX4obuAg9GKdmLJ0xPPSz
	epFiqqy4MAwjI23mbe0+i2gF0XVaX12aTkclkNmWA6fphSHw3g3Bs3COct9J2wun1FV3Qef2fHg
	cvpHGQ1E0HLG1L+
X-Received: by 2002:a17:90b:4a49:b0:392:ca3b:370a with SMTP id 98e67ed59e1d1-39b26100cd2mr25616356a91.2.1788701639546;
        Sun, 06 Sep 2026 06:33:59 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([2001:2d8:6467:d689:2b14:fe4a:ab17:f236])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b08cacbb0sm21427552a91.13.2026.09.06.06.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 06:33:59 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Tom Zanussi <zanussi@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	donggeunyoo.kernel@gmail.com
Subject: [PATCH] tracing: hist: free the var ref when its initialization fails
Date: Sun,  6 Sep 2026 22:33:52 +0900
Message-ID: <20260906133352.3815019-1-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

create_var_ref() allocates a VAR_REF hist_field and then calls
init_var_ref() to fill it in. When that fails the field is leaked.

commit 656fe2ba85e8 ("tracing: Use hist trigger's var_ref array to destroy
var_refs") made destroy_hist_field() return early for
HIST_FIELD_FL_VAR_REF, since var refs are freed by walking the trigger's
var_refs[] array instead. create_var_ref() adds the field to that array
only after init_var_ref() has succeeded, so on this path the field is in
neither place and nothing frees it. The call was correct when it was
written, before var refs were taken out of destroy_hist_field().

init_var_ref() cannot free it either. The caller owns the field, so
init_var_ref() undoes only its own string allocations and leaves the
field alone. Freeing it there would leave create_var_ref() passing freed
memory to destroy_hist_field(), which reads its flags.

Call __destroy_hist_field(), which frees the field without consulting
the flag.

Fixes: 656fe2ba85e8 ("tracing: Use hist trigger's var_ref array to destroy var_refs")
Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
---
Found by the Sashiko bot while reviewing an unrelated hist trigger patch:
https://lore.kernel.org/linux-trace-kernel/20260906124025.3550596-1-donggeunyoo.kernel@gmail.com/

That patch and this one are independent; this applies with or without it.

init_var_ref() only fails when kstrdup() returns NULL, so to reproduce it I
built a kernel with its last allocation forced to fail, leaving everything
else stock, and installed

  hist:keys=next_pid:delta=common_timestamp-$start

200 times against a sched_waking trigger defining $start. All 200 installs
fail, as intended; the question is what each failure leaves behind. With
CONFIG_DEBUG_KMEMLEAK:

  before  200 unreferenced objects, 38400 bytes
  after     0 unreferenced objects,     0 bytes

38400 is 200 * 192, one struct hist_field per failed call, which also
confirms the strings are not leaked: init_var_ref() frees those itself.
kmemleak points at the allocation in create_hist_field() reached from
create_var_ref().

checkpatch --strict is clean and an x86_64 W=1 build of the file adds no
warnings.

 kernel/trace/trace_events_hist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 963e0d6b61fd..34831a01bb9b 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -2234,7 +2234,7 @@ static struct hist_field *create_var_ref(struct hist_trigger_data *hist_data,
 	ref_field = create_hist_field(var_field->hist_data, NULL, flags, NULL);
 	if (ref_field) {
 		if (init_var_ref(ref_field, var_field, system, event_name)) {
-			destroy_hist_field(ref_field, 0);
+			__destroy_hist_field(ref_field);
 			return NULL;
 		}
 

base-commit: 1fc5a74b108fc90951890ec513ac81869f5eaff1
-- 
2.53.0

