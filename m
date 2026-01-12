Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFA3314A82
	for <linux-trace-kernel@vger.kernel.org>; Mon, 12 Jan 2026 07:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768203106; cv=none; b=ibTg2RbGLCBNPeAWP7MyQAl0SO8utMnPEGPW/6CcaiMAIkoMA2Ao6FVxgl7b3+f9DsMqs/at/ntLLQFE1cSEbOucwL/Dt0B0s+EKJPTSUj0Vue/ArVCGXyIzO2xRg0WZLWZWhGqpwMyOqZyaGhCdJ2vcp6D9VwZQfYPBwHOOiqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768203106; c=relaxed/simple;
	bh=POx2MI6Y+qHsD2NNDfeT21ziwReWguc8I022VBI4bI4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lUWsLzKnctXBSq2XZR8PlAzpa9IsqqKZ+EmZWPtkVp0BRmL0Jbg7u2PNNwdoqlIWs095j6N+PRbbvTcoKqvtb64EFk4x5MjhBMn8MThYW+QYvW3egg/uAwHzsRb6bmZKRLNIEt3hjsO4oL5V9z8H74LUWxTww/+ZvOsVU8Z+2b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=de61Heus; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="de61Heus"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768203101;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=C3tkMeBuolQULM8P+HbH2eANMDsvjXnBKF0jWbmCzkQ=;
	b=de61HeusuZXthMlF5wrjqEFvp81B2dLwH2ohRMRFSXChL8a/c24Dd9Db67WqDzH0a/McGc
	rKMS+BU2VN+E/oCtAmh6UWx0blogjWO4qerr/YB7Zfm/fk0NP7dmeOlyuNtJAOxt3RX/b5
	YCAprxmvRgN0lSKrjoSsqnlNucLQdtg=
From: Fushuai Wang <fushuai.wang@linux.dev>
To: tglx@kernel.org,
	peterz@infradead.org,
	mathieu.desnoyers@efficios.com,
	akpm@linux-foundation.org,
	aliceryhl@google.com,
	yury.norov@gmail.com,
	vmalik@redhat.com,
	kees@kernel.org,
	dave.hansen@linux.intel.com,
	luto@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	hpa@zytor.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	brauner@kernel.org,
	jack@suse.cz,
	cyphar@cyphar.com
Cc: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-trace-kernel@vger.kernel.org,
	wangfushuai@baidu.com
Subject: [PATCH v2 0/6] uaccess: Introduce copy_from_user_nul helper
Date: Mon, 12 Jan 2026 15:30:33 +0800
Message-Id: <20260112073039.1185-1-fushuai.wang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Fushuai Wang <wangfushuai@baidu.com>

Hi all,

This patch series introduces a new helper function, copy_from_user_nul,
to simplify cases where a buffer copied from userspace needs to be
NUL-terminated. In many places, after using copy_from_user, we manually
add a NUL byte to the end of the buffer to prevent string overflows and
ensure safe string handling.

The new helper performs both the copy and the NUL-termination in one
step, reducing repetitive code and the chance of errors.

v1 -> v2: Rewrite commit message and add some actual code improvements

--WANG

Fushuai Wang (6):
  uaccess: Add copy_from_user_nul helper
  x86/tlb: Use copy_from_user_nul() instead of copy_from_user()
  tracing: Use copy_from_user_nul() instead of copy_from_user()
  userns: Use copy_from_user_nul() instead of copy_from_user()
  time: Use copy_from_user_nul() instead of copy_from_user()
  kstrtox: Use copy_from_user_nul() instead of copy_from_user()

 arch/x86/mm/tlb.c         |  3 +--
 include/linux/uaccess.h   | 19 +++++++++++++++++++
 kernel/time/test_udelay.c |  3 +--
 kernel/trace/trace.c      |  3 +--
 kernel/user_namespace.c   |  3 +--
 lib/kstrtox.c             |  6 ++----
 6 files changed, 25 insertions(+), 12 deletions(-)

-- 
2.36.1

