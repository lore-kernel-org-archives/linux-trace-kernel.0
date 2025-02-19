Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52511FCFD2;
	Wed, 19 Feb 2025 18:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739989249; cv=none; b=J2VN0DS1azLgWiFPtmynl28WzkO3r9lWbKk9pPEp/dOfWu9QmBuagEtI9lKVomCs5xk5EODc0x3HuGCxvhB3y+Vb0tvRJ9+5a923Ahur6/eHSimqzbtKqyD1T+D0g6smxZHmOvb6CIZYhJZuCK8DEjq37givfuIiYnVjAsbPEys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739989249; c=relaxed/simple;
	bh=X14I7mbTIu2+tFsLjHVL5fSZz+NqDimLUr7e8CxbkJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cRtElYX9UbrDp49aALNwyppUHK3KLlFsf4a4KWDTtMPw4YUzGpArEDaAORA2disPVA3nHW+KgMWHWSAObiACJhpHCKRWEDtgC4BPa5JYoqYMK0Gk3rcNy1z/roBQek6tE7TOZBvh6Cq+7sOWNLKlTeu5+9VY1k0eT+JCyYMf6cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oej0EZNh; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oej0EZNh"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-220c2a87378so372225ad.1;
        Wed, 19 Feb 2025 10:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739989247; x=1740594047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=76EGObTpdOqVLxr8ga99oMSHZxAdsSys7BY3UEvgdGo=;
        b=Oej0EZNhjzgZcZ80QOQXMavocEt9OUDwGXOWcfj4ihnRPbvq9fkgzSgwE1SKpeFc7N
         Cz9sc8W4WQMJFe534jm/DvG/yGm2ld0Vars48i3H8N8XJtMVYaqnb9GhRNjnrRe9p8qx
         sT+j3cx36mXWNMwN93dHXCT0Hm89aoBKhEl3fjw5cYoW1bGTa9R4AVhMwC+2eYggdicT
         VBlFHalHtLbIBdejW9K8PMshaaUT36AB8dHgEg8JPTvs7kvMCljTtAVAXUO8gwAEiYu+
         0uI1O5YaoOxgY1BlkrJyuzqbyB4wjhbTrQRHJA38eH1VZaTxODIDXfkT/LAtCcwye/iD
         pBZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739989247; x=1740594047;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=76EGObTpdOqVLxr8ga99oMSHZxAdsSys7BY3UEvgdGo=;
        b=n22XBJivSu4RyDFx4XSiEUNDmXfY2dh8q6F/maFFiNT6C2QPbWuxBOy5zgA65M4xvH
         mWdKCQWtHT+YddABeubbjGUwmUcywDFZb0YE1PHcWHdS3hhwZAQYPoFUMrf64S6RIYyB
         XyR/i963nk8zv+/6DaYK+Ho9UzJ0bqRoaIZOirZwWrQ43NDG5Srbefc7mSnvlULdekhi
         yFZs3+Hd5Tp/lntD6MsJBmzq6RE0h6ug11JrMZiT49ft7lcpBCtlPWvQIhRTK62e6EMg
         +WDyfvhd3IRQTIrf/ygZEbBlWrStfYT2YxH3bpVago6/R+7+O8krr1RSozfkXzYjwtOr
         RKDg==
X-Forwarded-Encrypted: i=1; AJvYcCUlwzNSjD5R/5VOaI8Uv5FevfJfVJqFwsu3/x4rnacEyQxLJmp/woOD+JiSGZlPQvSwJmHKGO+mYLB1iHE8gCaM2zDN@vger.kernel.org, AJvYcCWWD+kXo0pjRos1+jm8TLArOLcmvKXlw1k1O9icJkSrd4mpTf2yaBBokoL0w03xgVd6z3SXkFL9AvE=@vger.kernel.org, AJvYcCXB2B9hkBoGLY48AjW0ZDhrKMiRwP70wTikKw0hYJM1FzDW2R5BHw9Lg+1HggZxDDCx9o6fF0GRJ7+EoamS@vger.kernel.org
X-Gm-Message-State: AOJu0YxqKkPYTS457dF91I1bhCAsYkxpZIeQmU/DJWJkAmn6GLKPq9/Z
	wC6jXKzk0KuTWfnvM5Xs2DHsj8Phu0Sr314jcsqZwc+AXREIGihA
X-Gm-Gg: ASbGncthr8k01c6MsNzkxnmlRk33PwTiv72ifF4Y/6QZYY9pSHuKWDVrD1100J6OqM2
	ZQG+2/2bwXQIbIkz4RC1yvzjc2V4ydAW/rWZHQGVsq9X8fPpdiqwraal3/X6aSwAS8AjlLykmJL
	t6a342zUz6APJVY9yxs5cm8/anbz2tHHFVpm9floDTQmLKDaCsxITD4zSvJq4xvTOE/olPdO6XA
	boEaudvvNeaJFV2fvz8iNeOvB0T3E/h69MkuWjCd97+Qz5Dv0TtZo7kvPX9gdO4q5VmqCbCieYq
	+EtBscJN9p5Oqw==
X-Google-Smtp-Source: AGHT+IE9woL3cS8LSc84OwEKFZItt18q3T4hIJa4P0EOZXN+eQBRjN/5am8F7oQZrvigsd9J1eVjrg==
X-Received: by 2002:a05:6a20:3d84:b0:1ee:8922:563 with SMTP id adf61e73a8af0-1ee8cb08f4amr29813280637.16.1739989246845;
        Wed, 19 Feb 2025 10:20:46 -0800 (PST)
Received: from jemmy.. ([47.116.124.190])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ade083277b3sm7753218a12.27.2025.02.19.10.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 10:20:46 -0800 (PST)
From: Jemmy Wong <jemmywong512@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: Jemmy Wong <Jemmywong512@gmail.com>
Subject: [PATCH 0/2] sched: Refine scheduler naming for clarity and specificity
Date: Thu, 20 Feb 2025 02:20:18 +0800
Message-ID: <20250219182020.393006-1-jemmywong512@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi, I'm relatively new to Linux and eager to contribute to the community
with some foundational work.

I aim to help improve code readability and maintainability.
While reading the scheduler code, I found some naming inconsistencies
that made understanding the code more difficult.

Specifically:
1. Some function names do not accurately reflect their purpose.
2. Certain names are too general, making it unclear what they represent.
3. Some concepts are ambiguous, leading to potential confusion.

- Rename ttwu_do_wakeup to ttwu_set_running:
    - This function only sets task state to TASK_RUNNING,
        not performing the actual wakeup.

- Rename update_cfs_group to update_cfs_group_shares:
    - The name was too generic; specifying "shares" clarifies its purpose.

- Rename place_entity to update_entity_sched:
    - The function does not handle entity placement but updates
        sched info: vruntime, slice, and deadline.

- Rename update_load_<set, add, sub> to load_weight_<set, add, sub>:
    - "load" can refer to either PELT load or load weight, causing ambiguity;
        "load_weight" specifies it's dealing with weight.

- Rename struct sched_avg to struct sched_pelt:
    - This structure includes not just average statistics
        but also sums like <load, runnable, util>_sum, last_updae_time,
        all of which are PELT (Per-Entity Load Tracking) metrics.

- Rename init_entity_runnable_average to init_entity_pelt

This patch aims to improve code readability and reduce confusion by
ensuring names are more descriptive of their actual functionality or purpose.

Signed-off-by: Jemmy Wong <Jemmywong512@gmail.com>
---
Jemmy Wong (2):
  sched: Refine scheduler naming for clarity and specificity
  sched: Refine sched_avg naming for clarity and specificity

 Documentation/trace/ftrace.rst | 190 ++++++-------
 include/linux/sched.h          |   6 +-
 kernel/sched/core.c            |  18 +-
 kernel/sched/debug.c           |  36 +--
 kernel/sched/fair.c            | 478 ++++++++++++++++-----------------
 kernel/sched/pelt.c            | 100 +++----
 kernel/sched/pelt.h            |  16 +-
 kernel/sched/rt.c              |   2 +-
 kernel/sched/sched.h           |  22 +-
 9 files changed, 433 insertions(+), 435 deletions(-)

--
2.43.0
