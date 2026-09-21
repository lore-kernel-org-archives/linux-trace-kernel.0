Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44EFE48A2B5
	for <linux-trace-kernel@vger.kernel.org>; Mon, 21 Sep 2026 11:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789990256; cv=none; b=juA7CkTyh21B0lMS71mCLEwmYi6A/MbtD63QI8oARwBHCqWD8EcNajab7OqnpSVNXjpGAtZlhnDfm2dZuCZ9HM8WbXAsjbpPJTPC2kqdPEqtCqDJkYJWyqjH7nG45SAP4qBhRf59byy3AFzHisQPAch94Js3KLwoJAdVilyiJKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789990256; c=relaxed/simple;
	bh=q/WfhphlCMj5uksPDXAHSWb83jP/AqFyp82piIW5aY0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f158bb5XCspmiMTNON/A59EUN7N/HTXyRJIlaEE9yuNe01fI1ox+inSYzRFRQQmvPhUB8eZFwg9DSaoU0LcmFTILZv20XYBeer9Ipf/kjXQUfdadV8Gix9gqbWpCnq5IZ8MFYt9goJir6bmwWQ8tjhO5xi1MU2bEuLa7vyjn7Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CckTPE7e; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CckTPE7e"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc4aa0f1766so2198380a12.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 21 Sep 2026 04:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789990255; x=1790595055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q4McwHcWMLvbv6Ny1SKzttwDu6xFAoJakDC7CkO+B44=;
        b=CckTPE7e5A9rwUCk7piYRwiRF00Lzv/zweZrMo0TMiF8MUVFkghqWOA1C0AS8fFhDH
         KtPXAlMlz/7co0gTZ/sgvC2Za8bYlbV+G45JB7yvHa7cKJhXFNhuyEH3yQo+AiLzCQ9q
         Q8ykl2WF0P9AbKoQv6AIlYZ6vhAyab5ygXJmYv/fMTWrcWYSY6DLvvl1Evc+cDZkf3Oo
         IXDUCN+ertAEnUdOLCA2heFCNplYZomcM1tcWYkDIr2te9TVRJ4sXc2ELlqTYnlp0x3O
         5+lgvzSBnHqsQPNzkMtvVHvpwzga22++E6wNzGAmcCH5esmDRrpmt+usaddYOJsZ14n2
         KdrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789990255; x=1790595055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=q4McwHcWMLvbv6Ny1SKzttwDu6xFAoJakDC7CkO+B44=;
        b=qU2hH84zaWT8D0hhmgRuRdizUYuH6KE0gClsckTi5UVaYjXnSdVXfDf3XOlizdrVLw
         YIKcKye6FS+qbiT4uhNc5bVah5mSqMc1tYdoMb+Q4WkYAA9k7EkkFN9MDm9YFA0ekhRy
         zGyGKGNXEERsZuxVys/tOA7u77UEQ0qFBdNm3s6NDp5kms/lcanQRrYLpuw2goTW2eSF
         qsi6fc9TztuKePKyDViKffWnF/mPuhIvxUZ+nathN6WZ4X3XKdkB4nPfZnAYCs3wuTvV
         ykiwUe+13lIGpcqa9vadYxqKBojItg69PqMMp4YZC97MCT/NlXQ+OkQX9iE5TWRjOLF0
         9fSA==
X-Forwarded-Encrypted: i=1; AKwUvBzjP4U/k6+5P2ohScrqh3sAosg9hMlJvgZBiewnP/pYCKY5V2sG/NLPXuixlEUJeHG5fu4Bk+XgJvLr0gEq4nwhhsY=@vger.kernel.org
X-Gm-Message-State: AFuF++kGcqP0o++/6ybCtOTbRddS70iTGmpby4SoLMYjxibYNpE6K0T7
	2xlUr6qWbn/xBJtGu5DCrTJ/aex5vyD+u+uV9aavG6gsWFhPKUNkeJtv
X-Gm-Gg: AYBFou2lNrYysp3TE5DD3beUafbYgK2De7sA97Nk3L57JU4izTqbi4sfTXa6e5YmbKL
	IWkRjvJr5R2UZnyFlRROLc/Jndr0P/1YMPaRYZUkWT7gSR4DRG5c0O3CJMP1OFe+YRwctTkLo0V
	xaOJ4JvnXWAVEWduStzLhsn63vkpofsh4q2Uk7WZ++UlCm8QE5F5tkhhSZdZgv6g/SXvpzDGdcN
	oUSvjVBO9yywjPhrozU7W5fPRImUuzT4B7087XhJs6MOFX8cCsnE5HZS3QjSPLC+WYp7uSXgQ5P
	nkBzhNFvUpfn7CTe7buXE4oy0Cug/DYpN2+Xt5va2iTyQlm/lBzddIJ7wKkXvAOUYg9wq65E3BZ
	VtOVCkDY44xbg4Bfw69qJ+uLXv5VCO/KvwXcw8OMqo/0zseKc0YvKrzFwUJ5gtM3Xz2HeUoGWKT
	BO/SFbX5jQmbT7zUqS7hwyN0sgNKXVQ4uQ480irguJ7kcTb9RxM7mxKdqXBNNi4App9qPgAotG1
	rMdGB8J/eqjQrqDKMBEdFnwQxnihBX/uoU0R6w=
X-Received: by 2002:a17:90a:d40e:b0:39e:6c6a:656f with SMTP id 98e67ed59e1d1-39e6c6a6787mr8776523a91.50.1789990254542;
        Mon, 21 Sep 2026 04:30:54 -0700 (PDT)
Received: from bj-kjy-standalone-gaoxiang17.mioffice.cn ([43.224.245.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6ca86d83sm14003444a91.6.2026.09.21.04.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 04:30:54 -0700 (PDT)
From: Xiang Gao <gxxa03070307@gmail.com>
X-Google-Original-From: Xiang Gao <gaoxiang17@xiaomi.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Vincent Donnefort <vdonnefort@google.com>,
	Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	gao xu <gaoxu2@honor.com>,
	yinchuang1@xiaomi.com,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xiang Gao <gaoxiang17@xiaomi.com>
Subject: [PATCH v4 0/2] tracing: add ring-buffer memory usage statistics
Date: Mon, 21 Sep 2026 19:30:44 +0800
Message-Id: <20260921113047.1152602-1-gaoxiang17@xiaomi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260916063322.472172-1-gaoxiang17@xiaomi.com>
References: <20260916063322.472172-1-gaoxiang17@xiaomi.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Report the memory consumed by the tracing ring buffers, rather than the
usable data capacity exposed by buffer_size_kb. Android low-memory
diagnostics need this to attribute the memory used by tracing when
calculating lost RAM.

The buffers can be spread across the global trace array, dynamically
created instances, and snapshot buffers. Userspace currently has to
discover and sum every instance, and snapshot memory is not exposed by
the per-instance totals.

Patch 1 adds:

  /sys/kernel/tracing/trace_stats/memory_usage_kb

reporting:

  buffers: ...
  snapshot_buffers: ...

covering the global trace array and all instances across all CPUs.

Patch 2 adds the per-CPU view under
trace_stats/per_cpu/cpuN/memory_usage_kb.

The values account for the full pages backing the data sub-buffers and
reader page, plus the cached read page and mmap metadata page when
present. Slab-allocated ring-buffer metadata is not included.

Changes since v3:
- Check tracing_disabled on open and during init to avoid a use-after-free
  on temp_buffer/tracing_buffer_mask when tracer_alloc_buffers() fails.
- Use READ_ONCE() for ring-buffer fields that can change concurrently.

Changes since v2:
- Account for the bootstrapping temp_buffer (Donggeun Yoo).
- Rebase onto latest mainline; adapt to free_page becoming struct
  buffer_data_read_page.

Tested on arm64 QEMU with global buffer resize, snapshot alloc/free,
instance create/remove, and per-CPU aggregation, all against the
baseline that includes temp_buffer (3 pages per CPU).

Xiang Gao (2):
  tracing: add ring-buffer memory usage statistics in tracefs
  tracing: add per-CPU memory usage statistics in tracefs

 Documentation/trace/ftrace.rst |  15 ++++
 include/linux/ring_buffer.h    |   1 +
 kernel/trace/ring_buffer.c     |  41 +++++++++
 kernel/trace/trace.c           | 160 +++++++++++++++++++++++++++++++++
 4 files changed, 217 insertions(+)

-- 
2.34.1

