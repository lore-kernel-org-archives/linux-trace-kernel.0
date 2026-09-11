Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524644AD4C2
	for <linux-trace-kernel@vger.kernel.org>; Fri, 11 Sep 2026 19:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789155607; cv=none; b=sLbZRVrPhEeD6hLLZ4anwAqeiHWiWbVojlZ+whoBrjAEo8aB78yaOn5IX1p8vmT7WKKhqZDRfR7fNHVay4XqAG7cu2FWa672Xn0yFOyAkKew81MRskoRu9nRGuTEn3D6RhEiZpTVUj/3yFTB/tIQu3wk5hXrMsgEGXhUKzkW1hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789155607; c=relaxed/simple;
	bh=Hl8lb58k5xO116xnimdTk6S76A025J8eQHLdMylhG3c=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=hpUymnzgGUVCXzmxKXYbGdHjUBgNs/zE3sjkUCsLEGGkc/HVWD0/hTKScpW+Ik9wYgWfjKqBuxQ0J8PKSIUaQ9zlZK3YVJ2gYeLwTpDrteFr+aILaEyE1T67txLJLZ3L3b/uGWT1H5Stoh6AX7sWN0Lo1pzdP9wTTBx4koKk6Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QHfFBSL0; arc=none smtp.client-ip=209.85.128.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QHfFBSL0"
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49cd83ca361so12076665e9.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 11 Sep 2026 12:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789155591; x=1789760391; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SsGZO1OXHttrCzZvvia/9lx/17qMNq27XA0wxIFcezk=;
        b=QHfFBSL0HUEgZtI/Ppu3oiU4czm0/mJS4jJAzXYQpuSy40kY93fEA4e+d+jd+FbikQ
         jBFMcQFQenMVcAcnIHk2MgxUyqeHdMfqSzknlRkH+skr/Wmd22oAeUXopeCZJa0y8pm+
         +/bk/QXoA6BgeV+GUaUOe8MKssyTWKlpq40domwWIPidJjW1qL6QZPttkTXujJ6vLoBc
         B4v2T6CjxGlJDyBlnrXpBDYHhWpZb21sAtLIMJ7tvpkfSRIctya1zxkp1Pa5lCbT1qx6
         i3rbHDW1nuUIUR5WhR8O8Fd+I11bQ22+EX77vduwkhLau8OC3N24OeamzWt7J6Nq4USq
         tRDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789155591; x=1789760391;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SsGZO1OXHttrCzZvvia/9lx/17qMNq27XA0wxIFcezk=;
        b=bjgXQjfkKcmZZKe8CKFtm7glAeUmTyaWIj7XGiFwD/zi2GQ067YkY/MuPLp9WVXs51
         wfl3G7pLOKZzCGMF+d2XXOC4tytfECNXUAmXAudoOzZdF8cIOnw3UFhy+aB5xFk2vu2+
         VGgIJAAJqYSSAVzhMRs3UVFvf0NKVhuVNn7bEJibKYCA4enQVAepcLj1V2yIUKCEytjm
         VLtgH+At/zGu1kw5kNVdOAuMJekYRKuXtrqsWmX9Qu5VCO3gt5W8XyzLeTPhSaZYrTKv
         GpnSWBbrss3LVwjIsdrtz3inHro647gY1vY0GK6afg+66Qdqm8iZALMEILaJtTvAlSVM
         eHQA==
X-Forwarded-Encrypted: i=1; AKwUvBytK2d8DUgkdpXRyey2xsGmeBGN7NRdujGMYV3I0Ea4KVKRzhZqSuWVa8O3Jvhmd7+4BPSrskY4dr/NA/mT/oeROGo=@vger.kernel.org
X-Gm-Message-State: AFuF++ke6fk5NTXBTBnkjQWKgFBn6Fly+BmoHH8m1NjI0aku8ooaeM/y
	go2+vFXjh7BlyMyw4tWX4WU4NA/ONZu/Jouou6r4C2kDINHcIUjbBa+fnZyfw13aN82Z62CI54u
	w92fjr+clXsnZzd9FCz7qeA==
X-Received: from wmpn30.prod.google.com ([2002:a05:600c:181e:b0:49e:6594:3a28])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:628e:b0:49c:fc6c:be13 with SMTP id 5b1f17b1804b1-49e619c6463mr67670635e9.25.1789155591294;
 Fri, 11 Sep 2026 12:39:51 -0700 (PDT)
Date: Fri, 11 Sep 2026 20:39:34 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1007.g17ff1f9808-goog
Message-ID: <20260911193937.602202-1-vdonnefort@google.com>
Subject: [PATCH v2 0/3] ring-buffer: Fix and unify size and page calculations
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

This short series unifies minimum page calculation for ring buffers and
fix a small issue with the number of pages calculation for trace
remotes.

v2:
  - Add a helper in "Account for ring buffer page header in size
    calculation" (Steven)
  - Split the nr_pages overflow handling into its own patch (Steven)
  - Rename the helpers into __calc_nr_pages_ring_buffer_desc() and
    rb_calculate_nr_pages() (Steven)
  - Use RING_BUFFER_MIN_NR_PAGES in trace_rb_cpu_prepare() (Sashiko)

v1: https://lore.kernel.org/all/20260907192643.42513-1-vdonnefort@google.com

Vincent Donnefort (3):
  tracing/remotes: Account for ring buffer page header in size
    calculation
  tracing/remotes: Catch nr_page_va overflow in ring_buffer_desc sizing
  ring-buffer: Unify ring buffer minimum page calculations

 include/linux/ring_buffer.h       | 26 +++++++++++++++++++++++--
 kernel/trace/ring_buffer.c        | 32 +++++++++++++------------------
 kernel/trace/simple_ring_buffer.c |  4 ++--
 kernel/trace/trace_remote.c       |  6 +++++-
 4 files changed, 44 insertions(+), 24 deletions(-)


base-commit: df2908090cda368b01ff43709f51890076c56157
-- 
2.55.0.1007.g17ff1f9808-goog

