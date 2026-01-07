Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D034B21E0AF;
	Wed,  7 Jan 2026 03:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767757777; cv=none; b=PWBgGwb9y7IqFGy6ZZ9GGiCsj1MswGccFWTVuhYR/x5Who4cv2uRigiakLwvh5UQO7gVlpWRLd+qRZrn+K3s4tLaDTHzCfJoxNG/hLKaLEx8NlMz4nv1qcDpmFh+GNE+A3I6FAJd9Cq1CiObtYfl/jY/qVHgozJcofZlQ8DFBLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767757777; c=relaxed/simple;
	bh=GblSqByrnOyWARKVerxxmttj6WzbnJ0LUGnjdhyijzU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qtxG5VPs+S9ih9pKuXfGPP0uYHavbHV6GRHn6OY0F7sjIIEAOj3DAN79Hh3IkN6zNlPZbB1FBfo969XVytnw6xWgb+SrQ3t8ZjFDSNO1iWpKzujC+oGR2kMoWpalDxlecrO/ridsDjQ1heH8c3ZE4tjaP7pgqXsP4f0Yky0Bryg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pROKaz7k; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pROKaz7k"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767757772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TZsXTVrwMS0dDeLUg9YyVb83Bpf4n/yK7h7JcyrhB0U=;
	b=pROKaz7k9W2yQFZoeXw0bXp/kUCf8aFBj1bN/mqKhs9ncaqPQ7mPjCxIdSne1hW1GoZ8r9
	ye67XXGc4F08YGhoGUywC2g1KNW5gQa6fTIo87Qfzx1xEFGFLB0M0rAZFSGd+2oAbXUbtT
	nU+wo3MbsOcwP2pdKYoOy8ddHOcFkwc=
From: Fushuai Wang <fushuai.wang@linux.dev>
To: fushuai.wang@linux.dev
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com,
	mhiramat@kernel.org,
	rostedt@goodmis.org,
	shuah@kernel.org,
	wangfushuai@baidu.com
Subject: Re: [PATCH v2] selftests/tracing: Fix test_multiple_writes stall
Date: Wed,  7 Jan 2026 11:49:14 +0800
Message-Id: <20260107034914.22315-1-fushuai.wang@linux.dev>
In-Reply-To: <20251227041821.75504-1-fushuai.wang@linux.dev>
References: <20251227041821.75504-1-fushuai.wang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

> When /sys/kernel/tracing/buffer_size_kb is less than 12KB,
> the test_multiple_writes test will stall and wait for more
> input due to insufficient buffer space.
> 
> Check current buffer_size_kb value before the test. If it is
> less than 12KB, it temporarily increase the buffer to 12KB,
> and restore the original value after the tests are completed.
> 
> Fixes: 37f46601383a ("selftests/tracing: Add basic test for trace_marker_raw file")
> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>

Gentle ping.

---
Regards,
WANG
