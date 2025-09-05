Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9022F2FFDFB
	for <linux-trace-kernel@vger.kernel.org>; Fri,  5 Sep 2025 09:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757063452; cv=none; b=KnjKezvA4zkw1y8c881Vt1QfI1snqZJ1GMQ5ITfN4Ycq29rt9j8FhNItMsi/61eyue3p9gOI4LqUUGCoiSu9GFtyRKmV5Rzf3QjRy7FjcbL4IS8Uh1EkqiaYv36wTdCuJoIC0h9tkj4wegEkaYQBVtFlR5J/QPMAtBeAr36ERYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757063452; c=relaxed/simple;
	bh=uzWqXcgkxCqg4JQl3dIDdqMd1cqCpcOGnZKSOa6Tl4M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uCe5GyJwKVxdkG0cg4UqxXD1eVGNMa56EID7nWkelzCNtgcEFpuB9Wxo+l6VZdRHizknSYpNnHZcqI+3Y3APVdQYt1+TU+bHMwVsoGh7KXaG2J4Ppeb81uy7BW3466vArIgxYuOpV+0MO/DoSn99JN5guJbkayI3rHDU8spm5EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ETQ7Rxod; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ETQ7Rxod"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45b8e28b3c5so17677645e9.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 05 Sep 2025 02:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757063449; x=1757668249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7zJgu83tGnDIyptwHs0M5qK30DmBJzP4OSe+GrCUmwM=;
        b=ETQ7Rxod5XiMR3LGD4ph01C8ZOUd/DdcKTnevXvAg4Wxyg1Yu5IPD2VCe4+MKOAVxV
         AlFyPaN3oUVIK0wpnZPn3uXazO26Qa1ll/ceVSN2EXG9Mu77u30ZcDmqdxun7Asuvx9D
         zqXMOG4PXcqQEx4Fer7absmN0qxuUAbQ2KsMUepQu7IZPelnEt7q6MQb4msArp4SWiHr
         2QDYuQxu9g7FwYmzysokozcy0KmtarZNX9KB6H9nqRhQ/a0La8VtGeTZqC01NB5IHsjF
         td71ntABuLduiMLYX2eswFUpSX9VesIYw0shG3OG32UOZ3YbQFbgu+CqDxovi7ZmqBuJ
         awUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757063449; x=1757668249;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7zJgu83tGnDIyptwHs0M5qK30DmBJzP4OSe+GrCUmwM=;
        b=X9+1ubMA8YU20bfZtYYmDtjomK50IyFk484A3RMD1v5eIjbgZTIt/wQp6pgRCxZHK1
         tNxbCNWRPcaW653Wbs1DKeQSrdGKH5mTacSnsM9Lhfqz9OE4iy5Fg2fxpmmmSjHCamqR
         WZ2Iy3tN54NhjZCEF/StiUwJL5NQzokvFrlcmjKQ5IwG5a3JtPF2Py7G95OyOobdADWy
         0TJodZBsnQDjLfzFeeru7iLjihtBYyJ2AnnJwgrmseOk+b6258718uQYiz2YgNrISopT
         R3Q6PO0JgJzJtMR9qD9xIfnorLs8jSLlUFNvhYV/ibwH4aVBvGaYbnETYBSduagMlAem
         jfoA==
X-Forwarded-Encrypted: i=1; AJvYcCXhP0/Xm9wo/dwpYT16AsrD/S0ZzqxKUSizgojzVZIShf+9c/TYA25jbFNUOtqRTqK8waj4ttWqe+YjByscEvM6OpI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz/FfT8qUoSdO4w9Z6JyqIv0KR86QskdQ83fg09UsLTX8vBXCS
	HpfwMD7cAgR/FEKTI9lXpD+DV8dDIqXtcwQuRhaTAuVkfXUvjfoz9Sylcb3rLJ90SO8=
X-Gm-Gg: ASbGnctIXVRJPhW/hhiHuDHZpI3OkVUsO8QiAXEYFBIxuBjVgkdgCRVKDwxJm2xn4TF
	+MNqpAWGEd4UmUlsqN89WLa//ptiuF/UQyF96u4oQzKEk5dixDoC/T1y7C+v3Y8ocHemNJYp2q+
	oygnqX2w0Tjp0Obzl3/ICEFouptOG3Pix7xbKfEA/Yt6mPQzNjQnrJIQyKltmOE62m1zUEplMXy
	smpminsjZkHrsrioCA8cYGB69Ev2zlOf9lGMrqVDM9yxakEE+c23EtTF/tO9g5JhuZ/4ySi7mDU
	49A5ILA+s+8W1gjJeqZ6GcMUEzoLfpcK1NgAaAJBUM5EBWVZfaw6Qa1I1Ko8qUImv/IOLBk3sVW
	wzKLdkcHv0j6zdhtvvbgh+j+GQ8Gl9aiHSmzTefxBQ+1GgSvHE0nDzK2mSg==
X-Google-Smtp-Source: AGHT+IGhXiWhBqn2jHzfmfm7BjzbLOSlu+pFGtb5WVSNU0SG0ViScbi/+1/rI2XAuiW/Ky3Svs9JsA==
X-Received: by 2002:a5d:584d:0:b0:3d2:633f:d02e with SMTP id ffacd0b85a97d-3e2ffd7fc1fmr1979807f8f.2.1757063448823;
        Fri, 05 Sep 2025 02:10:48 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf270fc3fasm30302590f8f.5.2025.09.05.02.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 02:10:48 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 0/1] trace: replace wq users and add WQ_PERCPU to alloc_workqueue() users
Date: Fri,  5 Sep 2025 11:10:39 +0200
Message-ID: <20250905091040.109772-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi!

Below is a summary of a discussion about the Workqueue API and cpu isolation
considerations. Details and more information are available here:

        "workqueue: Always use wq_select_unbound_cpu() for WORK_CPU_UNBOUND."
        https://lore.kernel.org/all/20250221112003.1dSuoGyc@linutronix.de/

=== Current situation: problems ===

Let's consider a nohz_full system with isolated CPUs: wq_unbound_cpumask is
set to the housekeeping CPUs, for !WQ_UNBOUND the local CPU is selected.

This leads to different scenarios if a work item is scheduled on an isolated
CPU where "delay" value is 0 or greater then 0:
        schedule_delayed_work(, 0);

This will be handled by __queue_work() that will queue the work item on the
current local (isolated) CPU, while:

        schedule_delayed_work(, 1);

Will move the timer on an housekeeping CPU, and schedule the work there.

Currently if a user enqueue a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.

This lack of consistentcy cannot be addressed without refactoring the API.

=== Plan and future plans ===

This patchset is the first stone on a refactoring needed in order to
address the points aforementioned; it will have a positive impact also
on the cpu isolation, in the long term, moving away percpu workqueue in
favor to an unbound model.

These are the main steps:
1)  API refactoring (that this patch is introducing)
    -   Make more clear and uniform the system wq names, both per-cpu and
        unbound. This to avoid any possible confusion on what should be
        used.

    -   Introduction of WQ_PERCPU: this flag is the complement of WQ_UNBOUND,
        introduced in this patchset and used on all the callers that are not
        currently using WQ_UNBOUND.

        WQ_UNBOUND will be removed in a future release cycle.

        Most users don't need to be per-cpu, because they don't have
        locality requirements, because of that, a next future step will be
        make "unbound" the default behavior.

2)  Check who really needs to be per-cpu
    -   Remove the WQ_PERCPU flag when is not strictly required.

3)  Add a new API (prefer local cpu)
    -   There are users that don't require a local execution, like mentioned
        above; despite that, local execution yeld to performance gain.

        This new API will prefer the local execution, without requiring it.

=== Introduced Changes by this series ===

1) [P 1] Replace use of system_wq

        system_wq is a per-CPU workqueue, but his name is not clear.

        Because of that, system_wq has been renamed in system_percpu_wq.


=== For Maintainers ===

There are prerequisites for this series, already merged in the master branch.
The commits are:

128ea9f6ccfb6960293ae4212f4f97165e42222d ("workqueue: Add system_percpu_wq and
system_dfl_wq")

930c2ea566aff59e962c50b2421d5fcc3b98b8be ("workqueue: Add new WQ_PERCPU flag")


Thanks!

Marco Crivellari (1):
  tracing: replace use of system_wq with system_percpu_wq

 kernel/trace/trace_events_user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.51.0

