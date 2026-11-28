Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795869194;
	b=hidAo+gwBaSPGCAH772rZfmVVzhVyBk3eODoPGduVcyTJ8Lupd225rvkO3z//LzRcKRH
	 AjmUlGSDSK5MaK6BWqnmiZieOxj57AHQw9lJpla7VNY1wXkJLjZMe+ruFm0B8mnOpk+i2
	 oNVS2BpqgbmPZcR66g1RwDZb6Kxrn7pK4ta6MqGhPdhTEh3LoXpeEs2XRHz64/iQIxLBH
	 QzoGJSuT4KWs+2iWBClF8g5DXxrVIjiatKF0DOfKdinIg8JSKqPxZrGBX+6uRtSveCdMM
	 LmsuNlsgj9ee3B0unDmYgNTVWPc9QjkP1Jw+ojjG53HzJ7XYBezwrBSebpTGrAaEqDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795869194;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=NHLg7QzMUvmQbR7yGVRZKWsvqhtvqdIwUR7km16E7I0=;
	b=qn4FCba+0+tKxxYSzEZcG/D6nhdBK4NkK/x4ZTekV9vVOSos161kO72RQKNHy5hdyeyn
	 12sjTtMy+Qi8E1iHik/0dHGF7i3wKHW/eT8B9rNJF/E9KKrxH5KWpgNsn/4eUJP4u5wg9
	 nQM2fbxfsGRK5d188iYpYNrcle9aQJF+iwHitOWeCoFsXrcKTQhVV/YNK+LLyMmW6Tfyb
	 snK9DXHqd+lhR/5zyUPFDOL3Fv2Z9+AG/9Zh1+NW2zoQeFjfFWtX4F5HzSXbfk4n8wfXU
	 KRYEGg1YKFFrbUAzin5/mJM+JS5ahGolBGHtY0R+ovk4EF2Bsu8i8BaruM3qdZjxyyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UgbAj1Qk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69251606A321;
	Sat, 28 Nov 2026 12:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UgbAj1Qk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D4C81F00897;
	Sat, 28 Nov 2026 12:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795869194;
	bh=NHLg7QzMUvmQbR7yGVRZKWsvqhtvqdIwUR7km16E7I0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UgbAj1Qkv9vgrhmQjPBb3Uin3peWb2GMRg/beMd3hsVnXHSE6u6PLIl3yAfzIwVSk
	 pfHvBIgrPTyKL0oY24fP48gQF4tMBPtybRbUhhPqycVcg7geq5Wbnm070vu/PGLyBi
	 0zZbVTy4e5gqJyozmgZ7ABV/P0KpBldWO7E5maSjuaWqnxhy7YDxg+l42RIpINtl1h
	 xaQPOJO2H/p/DJHrQLpEES6/juETq2enGdpv/nwf5qeVVNO+agHOwF4P0I6jm/gWXH
	 h9Fi2velcE5HbdTOCGQ+PXigUArBXok8RH4Y/aLVNdwiRaSBhFZiPXYnNc4hQlqO5M
	 D120zb4zWao4A==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Keke Ming <ming.jvle@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <jolsa@kernel.org>, linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2] uprobes: Free utask on dup_return_instance() failure
Date: Sat, 28 Nov 2026 21:33:10 +0900
Message-ID: <undine-1795869190837398987-1e7380873dfc6905@undined.local>
X-Mailer: UndineD 0.1
In-Reply-To: <20260822150906.528208-1-ming.jvle@gmail.com>
References: <20260822054620.452262-1-ming.jvle@gmail.com> <20260822150906.528208-1-ming.jvle@gmail.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Hi Keke,

Sorry for leaving this patch unattended for so long.

On Sat, 22 Aug 2026 23:09:06 +0800
Keke Ming <ming.jvle@gmail.com> wrote:

> dup_utask() installs the new uprobe_task in t->utask before copying
> return_instances. If dup_return_instance() fails, the partially copied
> utask is left attached to the child task.
> 
> Free the partially copied utask before returning -ENOMEM.
> 
> Also, dup_return_instance() copies the return_instance before fixing
> up extra_consumers.
> 
> Here, if no deep copy is needed, clear the copied extra_consumers
> pointer.

Thanks for the update.

Looking closely at v2, this patch actually bundles two distinct changes
and needs to be split (so that each one can focus on single issue):

1. Clearing ri->extra_consumers = NULL in dup_return_instance():
   This fixes a real, independent double-free / use-after-free bug that
   can happen on normal fork() even without any allocation failure.

   ri_pool_push() resets ri->cons_cnt to 0 while keeping
   ri->extra_consumers allocated for later reuse via krealloc(). When
   such a pooled return_instance is reused with cons_cnt <= 1 and the
   task forks, kmemdup() copies old->extra_consumers into the child's
   return_instance (shallow copied), causing both parent and child to
   alias the same heap buffer.

   Please split this fix into its own standalone patch with an accurate
   subject and changelog explaining the ri_pool_push() reuse scenario
   and the resulting double-free / UAF. That should have:

     Fixes: 8622e45b5da1 ("uprobes: Reuse return_instances between multiple uretprobes within task")
     Cc: stable@vger.kernel.org


2. Calling uprobe_free_utask(t) on dup_return_instance() failure in
   dup_utask():

   As Oleg pointed out on the v1 thread, freeing t->utask inside
   dup_utask() alone is not sufficient because uprobe_copy_process()
   returns void after the "No more failure paths" point in
   copy_process() (and mm_release() already calls uprobe_free_utask()
   on exit). According to the discussion, I think you will implement
   option B. In this case, please add below Fixes tag.

     Fixes: 248d3a7b2f10 ("uprobes: Change uprobe_copy_process() to dup return_instances")

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

