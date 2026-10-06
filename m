Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350A93563F6;
	Tue,  6 Oct 2026 16:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791305252; cv=none; b=UI5zo1Y+Fr2WxgyvdEy/lazPCZyZiBi5pUgcecA+U2y4iC58dMFk0c3c/PMq2RPQRS7KiriqSbBgZtGVqXWmELwdwNP7VTZQdXWhorNeMf0jJDaizsJyIP7oWDot+NA8cNIDIScQxMra9yhDcRAscm0P/gAUo4/x6OnoIMcgWco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791305252; c=relaxed/simple;
	bh=/h+op23MI0eLCsmes62NpIrbxEsijSRh4s9d4q4O7zg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iS2wEnr4G+f9JkW7JhTxSIqbI8kVzMsYl4nqVYEyki6+vcDTmTUfVPmo5/ujq7alsXOqlINkklJRnhg4y/OehY+lh9S0BIiz+acKC1vE0+lkdakbtZ9X5NwoH+kCJRyFbT9A1FIbUskMd61y2uWiVcvRy10lblX/K6O5SDXRxZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=gpdrUp8d; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="gpdrUp8d"
Received: from jeffbarnes-ThinkPad-P14s-Gen-2i.corp.microsoft.com (unknown [52.177.6.198])
	by linux.microsoft.com (Postfix) with ESMTPSA id 7000C20B7166;
	Tue,  6 Oct 2026 09:46:33 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7000C20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1791305194;
	bh=O7Zo8jVe43pQTgN6U7gRviNoDS/kOV/3u2QWjpeM4po=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gpdrUp8dAJVjv9+CoHByFzj/OYp6rDPOaPh2KJDrAiR98HSQk+/UH8Cl5jPUQGV3z
	 4oYb5bmpaNq6fiFXVIwE7sCpKh289Gf0TDCk0JLR+txkmBv6DQo4saqg3QDM90ei24
	 /KXvS0eBJo240qWD1djYV17fo8312UESlJ7+yi88=
From: Jeff Barnes <jeffbarnes@linux.microsoft.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	shuah@kernel.org
Cc: mathieu.desnoyers@efficios.com,
	reddybalavignesh9979@gmail.com,
	richard.weiyang@gmail.com,
	michael.bommarito@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v2 0/3] tracing/user_events: Share state with existing threads
Date: Tue,  6 Oct 2026 12:47:17 -0400
Message-ID: <20261006164720.3940272-1-jeffbarnes@linux.microsoft.com>
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

A thread created before the first user_events registration can share an
mm with another thread while retaining a NULL user_event_mm. If it later
registers an event, it can create independent registration state instead
of observing the state already associated with the shared mm. This allows
pre-existing threads in one address space to register different events
using the same enable address and bit.

Patch 1 fixes a locking issue found while reviewing this path. Duplicate
enabler lookup performs a plain traversal of the enabler list, while
asynchronous fault cleanup can remove entries under event_mutex. Serialize
the traversal with that cleanup.

Patch 2 finds the already-published user_event_mm for the current mm and
attaches the pre-existing thread to it. The global list lock serializes
lookup and attachment with the final task-count decrement and list removal.

Patch 3 adds a regression test covering two pre-existing threads that
attempt to register different events at the same enable address and bit.

Tested on 7.3.0-rc6 with virtme-ng:

- user_events ftrace_test: 6/6 passed
- user_events dyn_test: 4/4 passed
- user_events perf_test: 2/2 passed
- user_events abi_test: 7/7 passed

The user.preexisting_threads_same_address test passed.

Changes since v1:

- Split the duplicate-enabler locking correction into a preparatory patch.
- Protect duplicate-enabler traversal with event_mutex.
- Document and assert the group reg_mutex contract.
- Simplify existing-thread attachment around user_event_mms_lock.
- Serialize the final tasks decrement and list removal with lookup and
  attachment.
- Keep the regression selftest as the final patch.

Jeff Barnes (3):
  tracing/user_events: Serialize duplicate enabler lookup with event
    removal
  tracing/user_events: Share event state with existing threads
  selftests/user_events: Test registration from existing threads

 kernel/trace/trace_events_user.c              |  56 ++++++--
 .../testing/selftests/user_events/abi_test.c  | 125 ++++++++++++++++++
 2 files changed, 171 insertions(+), 10 deletions(-)


base-commit: a90ee4305c4a5df72c11b31dacfdc76e00fcf78a
-- 
2.43.0
