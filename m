Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134233C73E3
	for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 15:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773327968; cv=none; b=u+rGYXS8kQlWcLyY6pjekMogsEEOF6zFjnag40KANSUKnd0b5RE9NdJ0bBP24RXfiKgYQyLxPVWaX5m9rWX/t/kWe0I8RXg20RUBZ6w7CbEkcz/JkDMk+Fya0HMDo9zUJQZSBlCLy0k4KIeBcfZfb30dXqWPLmn4b/QN4GkGV0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773327968; c=relaxed/simple;
	bh=ISwUA01szUrgwq3x98znZg18hqXI4hHpoGw0Eowzd+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P5fsG/m6HWFgAiM/3Ph4m4o8MzTZ2esvPXEL5HrznRUuGLr7mS+x32s2URmU7qZXnWXVzqmyEnDbvRoq7E8qrtBUnRgkGW/wU/DJU5mE0PLolaLtuh6zZCsrBuhYb+JFB3Dh1LIqNIcM5eRvZoq2QFkm3J47ocN39U3KQ3yvEJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=Zmj8hmQM; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="Zmj8hmQM"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7d76c145ed9so1198027a34.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 08:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1773327966; x=1773932766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e8m3myjjGE3NHxUw5Y98XcFvEZdApgquTYgyBVq6daI=;
        b=Zmj8hmQMVdDxVGYLczP0TFMy+qDFIW+knQL/US6yRC0TnnbrS2mVEpFtNT2vq+IR/n
         9qMX8M6EfR2EeAV24hDlh4suvZ++Qo9whAHl5Lyf/MWrKnDD+JwRAWxpxgkcNPwQZdjk
         rl87VuYYrSLxm1uaCektzSRpou758UK/xBrDIr+HIb9isHKBwLsh22rivC7/WvLqIkRK
         t9Tx9Ylf5qLhn0YKPHsP0NfG/dNNL4LcTIi9Tb2nOiSll3gPTWG/DDqFXSd56geB+uXu
         avXW96/qlcbuB9eA+1/+YWSTz6abx3H3Oq1TEqCRd65SOKENgxoJy0YhngNgs6zx3Nq5
         +UTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773327966; x=1773932766;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e8m3myjjGE3NHxUw5Y98XcFvEZdApgquTYgyBVq6daI=;
        b=WrbyhGVkBe7K1JQc85Ke3/p/Ieekx2x+JIQyWsaqE64Z5iWjHVxdjT/5WhV6wzyuIp
         n1WNzuc+o3RiLH4SeucT55hi4i/3f2nod/H4LQkNvyP8VyM5wmNA9y9qW+MVbY5EPMo5
         bvfU6j2+2PuWAOgd3VMyHNbw2eJ7V4uLj/PieoFz5/GNhjtauH28ECmkOpGKYDKmgkVS
         /Kx62KnjR8W7nPh/aRXXQY3kC5Bn2nquAY5IPDjQc1H+ROrjdZzl/Uxs0zv24ZP+P0A8
         2jhG4HWTvK1UQ0hrrjPK1/lUNsU/uY5O4o3bARm/VNIXspTiRGIAwCUIyWBUTxVS4zCt
         cfDg==
X-Forwarded-Encrypted: i=1; AJvYcCX+6tJLcQQvKGO+JMadDz9bXm6ZI9ES4bfRRHwFhKyObT4jKwNCDEwMtpO36C/yR56l/L9vzefGofj8QrS1Qj3/Kn4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw62mXebWbAD1epN1Z7p2QLLwlvWwhdwwcQ/Tj58iWB84toFDx4
	a1u//rkF07t2yfJmL3sr6TXnQy7X7SwMhTDbfkJcqWYVJUqhW7iixeXO4Mf+IjsPhzE=
X-Gm-Gg: ATEYQzywDqGrBPPiCPGJOIurdeXoG75kukLgSQBfuD8dxQQw9IS0S8x1Jq1jhpQGNEP
	wEcZLlbBAW+mF/4ScOv+gTKgaGciH6wZXTln1dOqDT1bnfqx/4ikDwQ2yhGU17sGXB1IDvV7pnK
	Yr7FO0JXZF+JcurvKcIrA68NGy97+eYc15H3vSwBN4DTdJnpj0CZ90mAlDTUF4JF+mKal+oWvas
	OD8PMH2yqHHtHhgzlTyJgD/5ltXX7nohMG6ERH3RNDx+HbOqzRpqEIrMZCnBFF9EnXo/KtAUaCQ
	cBfZPzf5XWQgbpxG3PiDofEiDQv89z4zq7x1l57HgdLZiuMVzxpJacpWgc5lLxdjYJr6s+qzDTA
	FEzEpim8bjqWjfmA7gAr3mHD7vZkfnC77Uvdi/U/VU0TZU+Af4HVyuf9Z9VCz2vTp4ZCEevByKX
	K5ViiN6q4XxkUVT1dJPvzSm6BnTCckXWmoNNUMPsrBuizxN81qSrqeWtgu/Bzv1hnkhg==
X-Received: by 2002:a05:6830:4107:b0:7d7:466f:b2fd with SMTP id 46e09a7af769-7d76a5a470fmr4892471a34.2.1773327966007;
        Thu, 12 Mar 2026 08:06:06 -0700 (PDT)
Received: from vinmini.lan (c-73-143-21-186.hsd1.vt.comcast.net. [73.143.21.186])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d76aedae57sm4321776a34.28.2026.03.12.08.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 08:06:05 -0700 (PDT)
From: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
To: 
Cc: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Harry Wentland <harry.wentland@amd.com>,
	Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <siqueira@igalia.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Philipp Stanner <phasta@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Sunil Khatri <sunil.khatri@amd.com>,
	Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	Liu01 Tong <Tong.Liu01@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Kees Cook <kees@kernel.org>,
	Prike Liang <Prike.Liang@amd.com>,
	=?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	"Jesse.Zhang" <Jesse.Zhang@amd.com>,
	Philip Yang <Philip.Yang@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>,
	Ray Wu <ray.wu@amd.com>,
	Wayne Lin <Wayne.Lin@amd.com>,
	"Mario Limonciello (AMD)" <superm1@kernel.org>,
	Ivan Lipski <ivan.lipski@amd.com>,
	Dominik Kaszewski <dominik.kaszewski@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 10/15] drm: Use trace_invoke_##name() at guarded tracepoint call sites
Date: Thu, 12 Mar 2026 11:05:05 -0400
Message-ID: <20260312150523.2054552-11-vineeth@bitbyteword.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312150523.2054552-1-vineeth@bitbyteword.org>
References: <20260312150523.2054552-1-vineeth@bitbyteword.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace trace_foo() with the new trace_invoke_foo() at sites already
guarded by trace_foo_enabled(), avoiding a redundant
static_branch_unlikely() re-evaluation inside the tracepoint.
trace_invoke_foo() calls the tracepoint callbacks directly without
utilizing the static branch again.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
Assisted-by: Claude:claude-sonnet-4-6
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c            | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c            | 4 ++--
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 drivers/gpu/drm/scheduler/sched_entity.c          | 4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 24e4b4fc91564..cdcb33edb2bb6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1012,7 +1012,7 @@ static void trace_amdgpu_cs_ibs(struct amdgpu_cs_parser *p)
 		struct amdgpu_job *job = p->jobs[i];
 
 		for (j = 0; j < job->num_ibs; ++j)
-			trace_amdgpu_cs(p, job, &job->ibs[j]);
+			trace_invoke_amdgpu_cs(p, job, &job->ibs[j]);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index f2beb980e3c3a..2d34608fd7298 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1394,7 +1394,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
 
 	if (trace_amdgpu_vm_bo_mapping_enabled()) {
 		list_for_each_entry(mapping, &bo_va->valids, list)
-			trace_amdgpu_vm_bo_mapping(mapping);
+			trace_invoke_amdgpu_vm_bo_mapping(mapping);
 	}
 
 error_free:
@@ -2167,7 +2167,7 @@ void amdgpu_vm_bo_trace_cs(struct amdgpu_vm *vm, struct ww_acquire_ctx *ticket)
 				continue;
 		}
 
-		trace_amdgpu_vm_bo_cs(mapping);
+		trace_invoke_amdgpu_vm_bo_cs(mapping);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index b3d6f2cd8ab6f..844b8fc5359a3 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5190,7 +5190,7 @@ static void amdgpu_dm_backlight_set_level(struct amdgpu_display_manager *dm,
 	}
 
 	if (trace_amdgpu_dm_brightness_enabled()) {
-		trace_amdgpu_dm_brightness(__builtin_return_address(0),
+		trace_invoke_amdgpu_dm_brightness(__builtin_return_address(0),
 					   user_brightness,
 					   brightness,
 					   caps->aux_support,
diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index fe174a4857be7..003c015b3bfcf 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -429,7 +429,7 @@ static bool drm_sched_entity_add_dependency_cb(struct drm_sched_entity *entity,
 
 	if (trace_drm_sched_job_unschedulable_enabled() &&
 	    !test_bit(DMA_FENCE_FLAG_SIGNALED_BIT, &entity->dependency->flags))
-		trace_drm_sched_job_unschedulable(sched_job, entity->dependency);
+		trace_invoke_drm_sched_job_unschedulable(sched_job, entity->dependency);
 
 	if (!dma_fence_add_callback(entity->dependency, &entity->cb,
 				    drm_sched_entity_wakeup))
@@ -586,7 +586,7 @@ void drm_sched_entity_push_job(struct drm_sched_job *sched_job)
 		unsigned long index;
 
 		xa_for_each(&sched_job->dependencies, index, entry)
-			trace_drm_sched_job_add_dep(sched_job, entry);
+			trace_invoke_drm_sched_job_add_dep(sched_job, entry);
 	}
 	atomic_inc(entity->rq->sched->score);
 	WRITE_ONCE(entity->last_user, current->group_leader);
-- 
2.53.0

