Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62574AD4CD
	for <linux-trace-kernel@vger.kernel.org>; Mon,  5 Oct 2026 14:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791211214; cv=none; b=cR2Ef+iWdnErEhExBRff+Qk/35/j/1iA4SDNH68XqUqlw9YeeOII7KhoYjeyhnnpSSe7dp06xyf1TxyTdfu6da3GWrwSnK1lTj6EpXCIrR6yUgs9sdQqceYx0X1tWM+W1TRFqyNYU/v/gXwIgyOKWyanKgtQ84IyUEZzHiDPv24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791211214; c=relaxed/simple;
	bh=scbdS8+ALHSoPCYJ06IL+mUTbAbQNoAzTSATQs+2HyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DnVGH5IS8+iYUib+igxbcv6EXNIJHkbGaDz0Aq0Nxvgrh68TKL8/eb0QqlRqFjZJ+Tgy7FIQNA+13QDg8w+qi2sDHShfZXPgiilcHdSuBjX6ipnfE1ki4NTQ2ga+BbZdPUbQKUlrrs4LRJe/v2FtLoYV2GDGCxIpXZF7qMCZ4iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Cgio7ity; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Cgio7ity"
Received: from jeffbarnes-ThinkPad-P14s-Gen-2i.corp.microsoft.com (unknown [52.177.6.198])
	by linux.microsoft.com (Postfix) with ESMTPSA id 895FF20B7168;
	Mon,  5 Oct 2026 07:38:58 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 895FF20B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1791211139;
	bh=vM5T2lyezQkjmm52EuHiAJD/2gKVzsWx6u+4Pwn9ACE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cgio7ityEiz16VH/zmIjWxhRs9WfuVXEMJJxfAV3nzPy5SGPVXBO3oAOpQFxSeA0d
	 FhOu8nTTREcxmzcgWuqQ+4J71X0T7VQQjeJTlWkKBZKmdp51/e4GJ9BlyTfZ8HdT1C
	 /Hcb8TlmvOzBK7DUSS9iiGI19VEFNQ+I2h8tI8lM=
From: Jeff Barnes <jeffbarnes@linux.microsoft.com>
To: linux-trace-kernel@vger.kernel.org
Cc: mhiramat@kernel.org,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com
Subject: [PATCH v2 0/2] tracing/user_events: Share tracing state between existing threads
Date: Mon,  5 Oct 2026 10:39:42 -0400
Message-ID: <20261005143944.752112-1-jeffbarnes@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261002153934.798176-1-jeffbarnes@linux.microsoft.com>
References: <20261002153934.798176-1-jeffbarnes@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series fixes user_events registration from threads that already share
an address space before the first user_events registration.

The first patch adds regression coverage. The second ensures that
pre-existing threads sharing the same mm_struct also share the same
user_event_mm instead of independently creating wrappers with separate
enabler lists.

With the fix, a second registration using the same enable address and bit
is correctly rejected with EADDRINUSE.

The series was rebased onto Linux 7.3-rc6. The complete user_events ABI
selftest suite passes under virtme-ng:

PASSED: 7 / 7 tests passed.
Totals: pass:7 fail:0 xfail:0 xpass:0 skip:0 error:0
Changes in v2:

- Remove the unreachable second-registration cleanup assertion reported by
  Sashiko. ASSERT_EQ(-1, registration.second_ret) aborts on mismatch, so
  the subsequent if (!registration.second_ret) condition could never
  execute.
- Remove the now-unused second_unreg_ret field while retaining cleanup
  when the second registration unexpectedly succeeds.
- Remove the redundant first-registration cleanup guard.
- Use the natural alignment of the __u32 enable word and correct
  continuation indentation.
- Rebase onto Linux 7.3-rc6.

Both patches pass scripts/checkpatch.pl --strict with 0 errors,
0 warnings, and 0 checks.

Jeff

Jeff Barnes (2):
  selftests/user_events: Test registration from existing threads
  tracing/user_events: Share tracing state between existing threads


 kernel/trace/trace_events_user.c              |  78 +++++++++--
 .../testing/selftests/user_events/abi_test.c  | 125 ++++++++++++++++++
 2 files changed, 189 insertions(+), 14 deletions(-)

-- 
2.43.0

