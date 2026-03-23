Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577CA3BF662
	for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Mar 2026 16:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774281699; cv=none; b=KQKAuoOa5UpT4KqwW8/5TAKKIF955XsTJajzBB6wecGJWe/YXfDOxj5K2lPWsEMiCIfc4c+bJe+JbG8uBmP/bU4E1R/H4m/NYWibqeBPfo09IWgD89th1vMYHfU19dWaR3lveRlItnDNW6PN1NvCa/lS1Gwy709XkxDg/EmPZTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774281699; c=relaxed/simple;
	bh=/nT6DYNAlmNtadaMb4iFhw2tLxQT7LKT6tZZK9mKpOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bAjTx4IluW69AxpVicYjw9a3R2xrrZCNVb+NK/0ZSyapYD6WUAxzmisw+GirDEyU2sIq8XbsElzP432vLKw50aMHjkJInCLj8QP/9d5GY7odpBdlEH43Nw7i1J31ivg20FSGvE2RF7V2f2k5xshOB06BO/aCIGLM9cbgrImHBcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=dcv4P/AR; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="dcv4P/AR"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8cd78a4ce8dso392261285a.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Mar 2026 09:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1774281697; x=1774886497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QGNB24MNI2cEuLKVW/uGrymPK0BoMZGJRt19xK2nIS0=;
        b=dcv4P/ARcEY8dLsdK32nC5tnU/l7likmioB0k5e/W6hww9aHhd1RmK3YigN4arH1VI
         0nuIvKE3T52ndE3VQTDWmWpyZ0Eys90pt718n8Dhg19T902AJu3NBtQfCJ3pC53wFFp+
         zgiaGQoosK0ZY10sf4QzTj8yOZw+hNc7bCmbkqsAIKyp8nIplD0rC3KHi8O4RptGvrTA
         IG4D6wq/F7CTFzeHMZ1zcs+otN0obOWfi9SVvx6yRK6SAJ0H0uxYmKxrHYidBOYD89BQ
         fwakMWpq/vhaj3i3kHR8XF6PV705DpYb3RFUIfo3kR3X3HP5D825UQkXsu3bJ99n7dlK
         swSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774281697; x=1774886497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QGNB24MNI2cEuLKVW/uGrymPK0BoMZGJRt19xK2nIS0=;
        b=ItolMmUljB9I435z1DdUdwWkDqSpDlcv8+ILuUUhS0Vmaexz8cNYFF/wrZAhe+/u6h
         qlKe3prIPnXLXQBVyt1yyq8WFdiP44QWvYhLLTBoShrkJ0DCZsA1JFVUSkNtGDZlD8Bn
         ZtgEaJqcubWNvof6eKtEnqjAZfBfbkNZG3vpZQZpguxU49JaeWjCRVcQGx16AOHGviUC
         q3E4x6qJqHitpdRZzGeL08hIW070cUAoRj4rwibOrCn38gd12vS7NJTmpZW7qGUt7/uD
         Q4wJNJefpBPnjO7/C9DgVfkxTKv1wNQt5b4sX5TsbHsgDPxHynxk0fRwEukh31Fq8nH1
         hpug==
X-Forwarded-Encrypted: i=1; AJvYcCUsQD2qztkmQgNjwzR1ZXDrWur2tHQS4Ju/ZYUYDqv1UFkaQr+KkIlN6Yu9LYYBm+VHn/a8xznGlAAReZ0XQS1vlB8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFdnAiM1zw4L/IGWb7DUZVW8SUyM+n/bWahL1WK8yn7DUk4W0c
	9qrafWJxE8sD/nKAIs05mz7cTOSZ7JV4CxLrIdQz7/GnIOxFo5ofi92ruOTO5mgaRGE=
X-Gm-Gg: ATEYQzx6sec5KcvsTUj+nR5VtTXIVVwXQ4Z3X9V0CAfe4oH4EZQ7Ye9cpItZHjXDA5a
	ldxG1xTz7ap5rHW/cCcxpilQWiBXXTM1VhisVE8OT3u5tKzC2HB5OchbyYMciF2l7FIJRGgo3+x
	UNUwmLoo3ql5AitPwAUWKDbyhwenOaQ1oXxp8+pXWtd/N6lzLZ6tw4dlIatdV6+v/5H5zUtZg15
	X9TRT97g5qlgVec05/cUlEUOzozyFejpdtrUP4QhT5F6MdvkoM9X+Qh7FCO6W/URqjYSkbL2HKK
	kVmLi0mQIIVrfp1/wUicJ0oqwYm2qnasJRBmK6/i/iP9NIrWsZ4o7NvIqhthbi8Oj2cesWxC/Hl
	7RdpL2y2cETGdYDXiz3tAgXWOMS7iOHm6NepUfGDm8W+8NkE5gDkgwBwHcas6J0laHxIP9GOGK+
	kx72Rli65ju+g9LIHkqi9sB6nZitYiUzGrlZhP3+EW1hvpDb5lw9Zm+XQfMa60SLNryg==
X-Received: by 2002:a05:620a:4543:b0:8c6:a539:55d4 with SMTP id af79cd13be357-8cfc7f33fd8mr1883458885a.48.1774281685710;
        Mon, 23 Mar 2026 09:01:25 -0700 (PDT)
Received: from vinmini.lan (c-73-143-21-186.hsd1.vt.comcast.net. [73.143.21.186])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cfc9088df1sm843364185a.25.2026.03.23.09.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 09:01:25 -0700 (PDT)
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
	Liu01 Tong <Tong.Liu01@amd.com>,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Kees Cook <kees@kernel.org>,
	Prike Liang <Prike.Liang@amd.com>,
	Felix Kuehling <felix.kuehling@amd.com>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	"Jesse.Zhang" <Jesse.Zhang@amd.com>,
	Philip Yang <Philip.Yang@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>,
	Ray Wu <ray.wu@amd.com>,
	Wayne Lin <Wayne.Lin@amd.com>,
	"Mario Limonciello (AMD)" <superm1@kernel.org>,
	=?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
	Ivan Lipski <ivan.lipski@amd.com>,
	Dominik Kaszewski <dominik.kaszewski@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 10/19] drm: Use trace_call__##name() at guarded tracepoint call sites
Date: Mon, 23 Mar 2026 12:00:29 -0400
Message-ID: <20260323160052.17528-11-vineeth@bitbyteword.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323160052.17528-1-vineeth@bitbyteword.org>
References: <20260323160052.17528-1-vineeth@bitbyteword.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace trace_foo() with the new trace_call__foo() at sites already
guarded by trace_foo_enabled(), avoiding a redundant
static_branch_unlikely() re-evaluation inside the tracepoint.
trace_call__foo() calls the tracepoint callbacks directly without
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
index 24e4b4fc91564..99f0e3c9bddcc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1012,7 +1012,7 @@ static void trace_amdgpu_cs_ibs(struct amdgpu_cs_parser *p)
 		struct amdgpu_job *job = p->jobs[i];
 
 		for (j = 0; j < job->num_ibs; ++j)
-			trace_amdgpu_cs(p, job, &job->ibs[j]);
+			trace_call__amdgpu_cs(p, job, &job->ibs[j]);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index f2beb980e3c3a..69d5723b98580 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1394,7 +1394,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
 
 	if (trace_amdgpu_vm_bo_mapping_enabled()) {
 		list_for_each_entry(mapping, &bo_va->valids, list)
-			trace_amdgpu_vm_bo_mapping(mapping);
+			trace_call__amdgpu_vm_bo_mapping(mapping);
 	}
 
 error_free:
@@ -2167,7 +2167,7 @@ void amdgpu_vm_bo_trace_cs(struct amdgpu_vm *vm, struct ww_acquire_ctx *ticket)
 				continue;
 		}
 
-		trace_amdgpu_vm_bo_cs(mapping);
+		trace_call__amdgpu_vm_bo_cs(mapping);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index b3d6f2cd8ab6f..2c6c8050af269 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5190,7 +5190,7 @@ static void amdgpu_dm_backlight_set_level(struct amdgpu_display_manager *dm,
 	}
 
 	if (trace_amdgpu_dm_brightness_enabled()) {
-		trace_amdgpu_dm_brightness(__builtin_return_address(0),
+		trace_call__amdgpu_dm_brightness(__builtin_return_address(0),
 					   user_brightness,
 					   brightness,
 					   caps->aux_support,
diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index fe174a4857be7..93d764d229ca9 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -429,7 +429,7 @@ static bool drm_sched_entity_add_dependency_cb(struct drm_sched_entity *entity,
 
 	if (trace_drm_sched_job_unschedulable_enabled() &&
 	    !test_bit(DMA_FENCE_FLAG_SIGNALED_BIT, &entity->dependency->flags))
-		trace_drm_sched_job_unschedulable(sched_job, entity->dependency);
+		trace_call__drm_sched_job_unschedulable(sched_job, entity->dependency);
 
 	if (!dma_fence_add_callback(entity->dependency, &entity->cb,
 				    drm_sched_entity_wakeup))
@@ -586,7 +586,7 @@ void drm_sched_entity_push_job(struct drm_sched_job *sched_job)
 		unsigned long index;
 
 		xa_for_each(&sched_job->dependencies, index, entry)
-			trace_drm_sched_job_add_dep(sched_job, entry);
+			trace_call__drm_sched_job_add_dep(sched_job, entry);
 	}
 	atomic_inc(entity->rq->sched->score);
 	WRITE_ONCE(entity->last_user, current->group_leader);
-- 
2.53.0

