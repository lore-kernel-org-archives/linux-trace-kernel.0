Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A97481FB6
	for <linux-trace-kernel@vger.kernel.org>; Fri, 15 May 2026 13:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778853584; cv=none; b=DBdjzj3+2DduNDKpXFAhcYS8G7GVQnUp3xAW6GnNAnyzdyMTGhm3yu4DkcMFpcV7EKQyL3qbxxdGUtTeYcj4iOIJMxmVtcobMavkDlEG/zM9P131JRBkHvJoFUlW+mlsZrDATm0ZpAOJwSsOvxiE9pDRP5xJDJF2oEF1t4sT000=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778853584; c=relaxed/simple;
	bh=Vj7lbmKIQkOlOp1eKxcAyRTPbeqbj5UqGT816e/7Ed0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aYBVQXeKMgGDrf4beO8OpsJXAbBwFg308TrN50XxLNJHHtrOLo9Hmfn5gA3csU8DbbmgrKiwK3s+1d6D6Vd5dSd8eyyKtyXWOBgVxViXtZZ8qUaPhS0ru1V+/Y9UEqNievoh+anp1fFjM+gsHP3wzHeHydEM3pGhtFsaLLIsZh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=fwDKrGJB; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="fwDKrGJB"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-902deb2412fso1022531785a.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 15 May 2026 06:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1778853581; x=1779458381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=45LaM1Fr3Zq3iiITdQvbYZ1is3E5sWAW6nvjjI/+KtE=;
        b=fwDKrGJBUc1JjpfGswhFJ+phMq+8/6d121UphuleFiNLr7JitjUxvI4wGnpghU3Ec0
         yp1j7nvZwX1jOq0t+VMPmQhG4uxIM6MEszNTIXD42IQIDjq9wni2jKzzdJKlGczSAYPG
         oqcquFCDBdg15llOj3SV9goqbmFWHfKCoJyha9Bf1taw5YDI0+/QDWffbwHOo460gJxB
         N0D7tg8X7465oKt1+VvbN31fbDXB70CW3jmlTR/7Os2ERnQrg+21nOELuAwX47q+qjno
         ngWUrjyyeb8COHzshG4Dr2l01tzbXBEhhY48CpwK3zxSyutHHd3qTZvSR9hfZrHCXw50
         Cjhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778853581; x=1779458381;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=45LaM1Fr3Zq3iiITdQvbYZ1is3E5sWAW6nvjjI/+KtE=;
        b=J/QAvsS9YJn1d14lEPwZnyR6SLOhTRj4fOkR4N+bdwp7fw6CmTSVV3S0Ba5y+11/SD
         q8bxiBwKRm+AWonBUckxToA7gOgJkTtE9Ia9oyGk9t6mp4qC1u2X3pW0b9O082Zd73Fq
         9Uud3vzFZuxxbpXnFdPa9sZykollnMME3qY6pORGB1VH8oK4CEpeRSMtqUre/57e+z7C
         chEJcz6xZYbwHlu9oZ55GwKdVc5si4tfEVGe0ktUmOKbVIAW7b84x4WsKm3YRFo/QFVz
         UfbZBMtVj5g3NGE5rpekP0832fzAS6/eBVf1VCMhzSi1XWMv07B8eRyoN/O8m4mY6I+M
         LtwA==
X-Forwarded-Encrypted: i=1; AFNElJ80zb3QbB45XL5vu63VrWkf8yTe/8O5CYOz54vkIlzJ1w9mBhKYR6F59b+5kso/6e7ne26giNqtNh8WuPQlR5qKSDc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqhJdMcKa5E1By/KtriP2Lv/nyBthxWth8FWVeV+63AzNntgk6
	tOkHREYIY/2er7kvqhv0sDjSaXqZEA2taO7HHSk7C2I+e/t126vJABGgb3S6nrOQSNo=
X-Gm-Gg: Acq92OHSCahM2SXNEnAs1fsUfssapykJBWfwc7KkvksnI0RfDmvJc99wYzon+o56/iO
	IKi029ZsaW2Y4i5bQ6EZi2Q59k7I3pSwJa8SKpRLHzZ/xL+yH3GAYZR5kxP3FIxcAaoQIc3zsK9
	DPe4bv+ENVwvxemOnFP50Pg3DsYP/zqnj05RAUAwPgB7Stu4Tmfs+1iwxgFqp9VObQsUW6OBl55
	KS4TSMCbSmRuaj++oE2fLRnwpN4eoNH0zRdBhqgKGHkdmiQBPMUUHH19KfnL8J48uF4X+o8stKz
	KB/h8/c0ddeywnuFJ8xjh4MlzFQFy3ZTHDczf7iGU3fRcxxaQMKUhJCwvzfK1eGb8in6wQqmoQO
	ZuXBIYlYgtimNTtM4XQTFZilcPVwbchkl2P9vydpp2vIzhK7X4bRxJLla5DhRCqCknNzrYZGqJH
	hFZnC2Y9iqH4G/dvpyorISQJzRNqQa
X-Received: by 2002:a05:620a:29c9:b0:8cd:9665:9eff with SMTP id af79cd13be357-911cd46b36amr659332785a.21.1778853580911;
        Fri, 15 May 2026 06:59:40 -0700 (PDT)
Received: from vinp2.lan ([2607:fb92:1900:6734:902:ab48:6190:9c1e])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910bd02f12dsm564638885a.40.2026.05.15.06.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 06:59:40 -0700 (PDT)
From: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
To: Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Harry Wentland <harry.wentland@amd.com>,
	Leo Li <sunpeng.li@amd.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Philipp Stanner <phasta@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org,
	Vineeth Pillai <vineeth@bitbyteword.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v3 06/11] drm: Use trace_call__##name() at guarded tracepoint call sites
Date: Fri, 15 May 2026 09:59:32 -0400
Message-ID: <20260515135932.2238842-1-vineeth@bitbyteword.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vineeth Pillai <vineeth@bitbyteword.org>

Replace trace_foo() with the new trace_call__foo() at sites already
guarded by trace_foo_enabled(), avoiding a redundant
static_branch_unlikely() re-evaluation inside the tracepoint.
trace_call__foo() calls the tracepoint callbacks directly without
utilizing the static branch again.

Original v2 series:
https://lore.kernel.org/linux-trace-kernel/20260323160052.17528-1-vineeth@bitbyteword.org/

Parts of the original v2 series have already been merged in mainline.
This patch is being reposted as a follow-up cleanup for the remaining
unmerged pieces.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
Assisted-by: Claude:claude-sonnet-4-6
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c            |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c            |  4 ++--
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 10 +++++-----
 drivers/gpu/drm/scheduler/sched_entity.c          |  5 +++--
 4 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index b24d5d21be5f..cb0b5cb07d57 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1004,7 +1004,7 @@ static void trace_amdgpu_cs_ibs(struct amdgpu_cs_parser *p)
 		struct amdgpu_job *job = p->jobs[i];
 
 		for (j = 0; j < job->num_ibs; ++j)
-			trace_amdgpu_cs(p, job, &job->ibs[j]);
+			trace_call__amdgpu_cs(p, job, &job->ibs[j]);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 9ba9de16a27a..a36ae94c425f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1415,7 +1415,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
 
 	if (trace_amdgpu_vm_bo_mapping_enabled()) {
 		list_for_each_entry(mapping, &bo_va->valids, list)
-			trace_amdgpu_vm_bo_mapping(mapping);
+			trace_call__amdgpu_vm_bo_mapping(mapping);
 	}
 
 error_free:
@@ -2183,7 +2183,7 @@ void amdgpu_vm_bo_trace_cs(struct amdgpu_vm *vm, struct ww_acquire_ctx *ticket)
 				continue;
 		}
 
-		trace_amdgpu_vm_bo_cs(mapping);
+		trace_call__amdgpu_vm_bo_cs(mapping);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 5fc5d5608506..fbdc12cdd6bb 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5263,11 +5263,11 @@ static void amdgpu_dm_backlight_set_level(struct amdgpu_display_manager *dm,
 	}
 
 	if (trace_amdgpu_dm_brightness_enabled()) {
-		trace_amdgpu_dm_brightness(__builtin_return_address(0),
-					   user_brightness,
-					   brightness,
-					   caps->aux_support,
-					   power_supply_is_system_supplied() > 0);
+		trace_call__amdgpu_dm_brightness(__builtin_return_address(0),
+						 user_brightness,
+						 brightness,
+						 caps->aux_support,
+						 power_supply_is_system_supplied() > 0);
 	}
 
 	if (caps->aux_support) {
diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index fe174a4857be..185a2636b599 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -429,7 +429,8 @@ static bool drm_sched_entity_add_dependency_cb(struct drm_sched_entity *entity,
 
 	if (trace_drm_sched_job_unschedulable_enabled() &&
 	    !test_bit(DMA_FENCE_FLAG_SIGNALED_BIT, &entity->dependency->flags))
-		trace_drm_sched_job_unschedulable(sched_job, entity->dependency);
+		trace_call__drm_sched_job_unschedulable(sched_job,
+							entity->dependency);
 
 	if (!dma_fence_add_callback(entity->dependency, &entity->cb,
 				    drm_sched_entity_wakeup))
@@ -586,7 +587,7 @@ void drm_sched_entity_push_job(struct drm_sched_job *sched_job)
 		unsigned long index;
 
 		xa_for_each(&sched_job->dependencies, index, entry)
-			trace_drm_sched_job_add_dep(sched_job, entry);
+			trace_call__drm_sched_job_add_dep(sched_job, entry);
 	}
 	atomic_inc(entity->rq->sched->score);
 	WRITE_ONCE(entity->last_user, current->group_leader);
-- 
2.54.0

